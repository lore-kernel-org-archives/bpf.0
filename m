Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B490141DDE4
	for <bpf@vger.kernel.org>; Thu, 13 Aug 2026 19:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786647881; cv=none; b=IAKTHlaHjE81cgBnE2ERWmAAK3ZdPgazgseEz0wzt+AT1a5Dk/jQPMaBwqLC/gfLo5gxZPh4dJmShiIfvHILwVv7jUNT4th2yIFKrUoRYixosYkW3mhpVYzTsRwkPSOEuv8M29cMLVpqh3nuC5kak6xl4PZn+Vs0m/up4nyJWXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786647881; c=relaxed/simple;
	bh=eXKRx2qUPuIXieOLZ+MIfRmrJOmhf41yG28H3P2RuKo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NsrpW2HtdxrqWwutc7yPyHlb5CUxVIj6Z+jhgJUL8itZtWnZfs5p17RC51nmU9Wk+b59qCdsEoaozUB6/uvm7j0IgyMsvw9E6oDF8nKMosVnUww4hWBi+ZsdFAky4VjyIObEGn8rb2fSxp2MVx7DEKcFyvS6S0eW8aETrn2ktd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D/zwp9vE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D/zwp9vE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51F7C1F000E9;
	Thu, 13 Aug 2026 19:04:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786647879;
	bh=SDey6SJ2ieE8UkeHLB2/6GWAFfrwj4yefGQP1JS7Wl8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=D/zwp9vEv5wed/Ea1Nnpyz88f9+ny1qrxhZrLaU1HzBtEdVEWHEbaIIBRE6VD3Ynt
	 KMe7g41LnES9fZD15/Bl9UtxNIgSbECdPl7FMkC7DoUj6NqUDzkYbaOFRvFaPLBOsE
	 BOP2LmuYedeqosF9aJ674W+Tvun7iCubwbcBe5iC43BYdV/K3i9TSukhEkyvKAPeY7
	 nrNLe5oUks6vA+g8iD6Kq+keKSHdUdlSxXPGKqMyZJ8tjJO700E2z3vFn8AeD7NWqe
	 Is6nSHyTc6IANB3suzPrsMEVcdaQfe/Jmn8ahurmVofTIPQkocGXIErAfnUjP0rYwI
	 GK3egrC7Sj79A==
From: Puranjay Mohan <puranjay@kernel.org>
To: bpf@vger.kernel.org
Cc: Puranjay Mohan <puranjay@kernel.org>,
	"Alexei Starovoitov" <ast@kernel.org>,
	"Daniel Borkmann" <daniel@iogearbox.net>,
	"Andrii Nakryiko" <andrii@kernel.org>,
	"Martin KaFai Lau" <martin.lau@linux.dev>,
	"Eduard Zingerman" <eddyz87@gmail.com>,
	"Kumar Kartikeya Dwivedi" <memxor@gmail.com>,
	"Song Liu" <song@kernel.org>,
	"Yonghong Song" <yonghong.song@linux.dev>,
	Xu Kuohai <xukuohai@huaweicloud.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Will Deacon <will@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Xu Kuohai <xukuohai@huawei.com>
Subject: [PATCH bpf-next v2 7/7] selftests/bpf: Test a multi-slot argument before a struct_ops arena argument
Date: Thu, 13 Aug 2026 12:03:54 -0700
Message-ID: <20260813190356.335181-8-puranjay@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260813190356.335181-1-puranjay@kernel.org>
References: <20260813190356.335181-1-puranjay@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The trampoline reads the __arena flag from the btf_func_model per
argument but stores the ctx one register slot at a time, so the two only
line up if every preceding argument occupies exactly one slot. Every
arena-bearing member of bpf_testmod_ops3 takes single-slot arguments, so
nothing exercises the mapping and a mis-indexed arg_flags lookup would
go unnoticed on any architecture.

Add test_arena_multislot(), whose first argument is a 16-byte struct
passed by value. It fills ctx[0] and ctx[1], putting the arena pointer
at argument index one but slot two. The callback checks both halves of
the struct before dereferencing ctx[2], so a JIT that walks registers
instead of arguments converts the wrong slot and fails the test.

Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
Acked-by: Xu Kuohai <xukuohai@huawei.com>
---
 .../selftests/bpf/progs/struct_ops_arena.c    | 24 +++++++++++++++++++
 .../selftests/bpf/test_kmods/bpf_testmod.c    | 15 ++++++++++++
 .../selftests/bpf/test_kmods/bpf_testmod.h    |  8 +++++++
 .../bpf/test_kmods/bpf_testmod_kfunc.h        |  1 +
 4 files changed, 48 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/struct_ops_arena.c b/tools/testing/selftests/bpf/progs/struct_ops_arena.c
index ba04c73d8d967..8aa8639df91f0 100644
--- a/tools/testing/selftests/bpf/progs/struct_ops_arena.c
+++ b/tools/testing/selftests/bpf/progs/struct_ops_arena.c
@@ -59,11 +59,28 @@ int test_arena_stack_cb(unsigned long long *ctx)
 	return 0;
 }
 
+SEC("struct_ops/test_arena_multislot")
+int test_arena_multislot_cb(unsigned long long *ctx)
+{
+	u64 __arena *ptr = (u64 __arena *)ctx[2];
+
+	arena_touch++;
+	/*
+	 * The 16-byte struct occupies ctx[0] and ctx[1], so @ptr is argument
+	 * one but slot two. Getting that wrong hands the callback a scalar.
+	 */
+	if (ctx[0] != 11 || ctx[1] != 22)
+		return 0xbad;
+	*ptr += 1;
+	return 0;
+}
+
 SEC(".struct_ops.link")
 struct bpf_testmod_ops3 testmod_arena = {
 	.test_arena = (void *)test_arena_cb,
 	.test_arena_nullable = (void *)test_arena_nullable_cb,
 	.test_arena_stack = (void *)test_arena_stack_cb,
+	.test_arena_multislot = (void *)test_arena_multislot_cb,
 };
 
 SEC("syscall")
@@ -109,6 +126,13 @@ int trigger(void *ctx)
 	if (*val != 44)
 		return 9;
 
+	/* a multi-slot arg precedes the arena pointer here */
+	ret = bpf_testmod_ops3_call_test_arena_multislot((u64 *)val);
+	if (ret)
+		return 10;
+	if (*val != 45)
+		return 11;
+
 	bpf_arena_free_pages(&arena, (void __arena *)val, 1);
 #endif
 	return 0;
diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
index a6133f7521f34..9366a3c578f13 100644
--- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
@@ -402,12 +402,19 @@ static int bpf_testmod_ops3__test_arena_stack(u64 a, u64 b, u64 c, u64 d,
 	return 0;
 }
 
+static int bpf_testmod_ops3__test_arena_multislot(struct bpf_testmod_arena_pair p,
+						  u64 *ptr__arena)
+{
+	return 0;
+}
+
 static struct bpf_testmod_ops3 __bpf_testmod_ops3 = {
 	.test_1 = bpf_testmod_test_3,
 	.test_2 = bpf_testmod_test_4,
 	.test_arena = bpf_testmod_ops3__test_arena,
 	.test_arena_nullable = bpf_testmod_ops3__test_arena_nullable,
 	.test_arena_stack = bpf_testmod_ops3__test_arena_stack,
+	.test_arena_multislot = bpf_testmod_ops3__test_arena_multislot,
 };
 
 static void bpf_testmod_test_struct_ops3(void)
@@ -441,6 +448,13 @@ __bpf_kfunc int bpf_testmod_ops3_call_test_arena_stack(u64 *ptr__arena)
 	return st_ops3->test_arena_stack(1, 2, 3, 4, 5, 6, 7, 8, ptr__arena);
 }
 
+__bpf_kfunc int bpf_testmod_ops3_call_test_arena_multislot(u64 *ptr__arena)
+{
+	struct bpf_testmod_arena_pair p = { .a = 11, .b = 22 };
+
+	return st_ops3->test_arena_multislot(p, ptr__arena);
+}
+
 struct bpf_testmod_btf_type_tag_1 {
 	int a;
 };
@@ -852,6 +866,7 @@ BTF_ID_FLAGS(func, bpf_testmod_ops3_call_test_2)
 BTF_ID_FLAGS(func, bpf_testmod_ops3_call_test_arena)
 BTF_ID_FLAGS(func, bpf_testmod_ops3_call_test_arena_nullable)
 BTF_ID_FLAGS(func, bpf_testmod_ops3_call_test_arena_stack)
+BTF_ID_FLAGS(func, bpf_testmod_ops3_call_test_arena_multislot)
 BTF_ID_FLAGS(func, bpf_kfunc_get_default_trusted_ptr_test);
 BTF_ID_FLAGS(func, bpf_kfunc_put_default_trusted_ptr_test);
 BTF_KFUNCS_END(bpf_testmod_common_kfunc_ids)
diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.h b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.h
index 33f2af5b70857..210b919290cc2 100644
--- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.h
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.h
@@ -103,6 +103,12 @@ struct bpf_testmod_ops2 {
 	int (*test_1)(void);
 };
 
+/* 16 bytes, so it takes two argument slots when passed by value */
+struct bpf_testmod_arena_pair {
+	u64 a;
+	u64 b;
+};
+
 struct bpf_testmod_ops3 {
 	int (*test_1)(void);
 	int (*test_2)(void);
@@ -112,6 +118,8 @@ struct bpf_testmod_ops3 {
 	/* enough leading args to force @ptr onto the stack on x86 and arm64 */
 	int (*test_arena_stack)(u64 a, u64 b, u64 c, u64 d, u64 e, u64 f,
 				u64 g, u64 h, u64 *ptr);
+	/* a multi-slot leading arg, so @ptr is not at the slot its arg index suggests */
+	int (*test_arena_multislot)(struct bpf_testmod_arena_pair p, u64 *ptr);
 };
 
 struct st_ops_args {
diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h b/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h
index c4383acb53c11..7d81070eefe7f 100644
--- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h
@@ -123,6 +123,7 @@ void bpf_testmod_test_mod_kfunc(int i) __ksym;
 int bpf_testmod_ops3_call_test_arena(__u64 *ptr__arena) __ksym;
 int bpf_testmod_ops3_call_test_arena_nullable(__u64 *ptr__arena__nullable) __ksym;
 int bpf_testmod_ops3_call_test_arena_stack(__u64 *ptr__arena) __ksym;
+int bpf_testmod_ops3_call_test_arena_multislot(__u64 *ptr__arena) __ksym;
 
 __u64 bpf_kfunc_call_test1(struct sock *sk, __u32 a, __u64 b,
 				__u32 c, __u64 d) __ksym;
-- 
2.53.0-Meta

