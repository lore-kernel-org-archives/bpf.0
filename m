Received: from mail-wm2-f8.google.com (mail-wm2-f8.google.com [74.125.225.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DD28367B8E
	for <bpf@vger.kernel.org>; Sun, 26 Jul 2026 01:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785029478; cv=none; b=Manf2D8zhruxXYNeHTpNft8IGelgA1pY7Y852tluBUFYe2WRDc80vHokfy91FWh4Rx8VhVbQwXmPPpmiO+lt5A/V5YRvGurJyZq2mO2q0Hcz3ecc0mflV8oAko9YuneM1RoOHcVRId6PRl9KDVvb9iJoo6qkgieOrJ8GbqojI64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785029478; c=relaxed/simple;
	bh=2pJh71fXz6UcwG+aVbaPEIV2mQWk95Psfsk2S2WpLu0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ce7XX6nXrW9rcqr+6sNfdnP3vAn6VgS1THGRKqNwpsWayrKDB0mfeFc8yI6RoyHHR8y+YaJGQprpMsdhBGB7az1/6duIMOJrbOT9TPKF8tBEGjuuha+gt/UAp+qyR8Yt7w0fdWMAU0PXMMTBXNG7gKZxtT0hlfemL+1PZj847a4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BOPj/lG8; arc=none smtp.client-ip=74.125.225.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BOPj/lG8"
Received: by mail-wm2-f8.google.com with SMTP id 5b1f17b1804b1-4956bc73c0eso6549175e9.1
        for <bpf@vger.kernel.org>; Sat, 25 Jul 2026 18:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785029475; x=1785634275; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZmHGkM2Gi5ZYULmCI+f6CT0f33RPzzTxbkYtXWfOdhc=;
        b=BOPj/lG8PscU8Y9rFST8NVK5GYvh51dCpPU64nXlKOUc6QNkpsFiFz9x0oww+f+VqD
         K0eR2wg17kBcS/pwbK/IVqjkh+f4lJhZIunMIUQF+NeT2ufJqyav8uH7lhS+aVt8PiuB
         JDagASs6p53pfxwVYSDYPUmu2ucoagYmN89eE33sajRN0cs4wD8C4IbLnIomzniIRAgl
         Lr4r46ejI28CZ3bvt8JEsOhlZG9sfxL/N9UpQ2LL0m2gHgUvYWXYGYR34ioNGmcD7U3L
         d7bETceHljmwewPsADDjw+bPKNtFEGnVykKEwqcud1B1lIUDFbHR2Qhjt7Ou7viwEiPv
         NWOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785029475; x=1785634275;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZmHGkM2Gi5ZYULmCI+f6CT0f33RPzzTxbkYtXWfOdhc=;
        b=Z5LlTlnjWgV6aKoyTWc82QMzmj3vZQr6ZeP9E9KcJPkxk+D8kShNoj7WvqfVkvYIiZ
         ShlD3SWCD7wu1M78tfSoiWuBVJJ3WbmuWZA5pywHG0+FveZfAL6C1aRN9rKM3zAXOsrg
         aZh/hr9emiWfJJKawBvEQybdhmbpB4lWpaxjDli0KpCrqi3FaYvgUushq02fpBidCkhU
         xqgKG+LVeQ4ZHhZtOw8mmjQdQ9+DuxEJx11b8SCgoQrDJkfpxAR7rxfHHtaz6qJ/3+FR
         Eu7JQtMlPoNflFKk+iGdqQUu2VPLDa9YlgtJ+DAEe6mDGLyhuZo5N9powAqAI2mAg08H
         Mv7A==
X-Gm-Message-State: AOJu0Yyatvk1QpwE11T7MuWY9coGQUO2nwn1dbWs3PQQFsDW3Uw/WyPC
	BY0xSB6m3mLrFDDf2IdZeat+8c9amvC24qumHmySgyghyCZ8eM7LsmzghnCPAwzI
X-Gm-Gg: AR+sD13Y/p2g7xP9nWs+gRA88DsbjsJjsOVhIc+KiYGJ9L62JdrUO+VvYhdC2UEhZ1I
	GWHqCU3yk5/IwsyMnN+BJSt9OqpAnRDCrABJxv3OdHopVAbjegWjsrl6LH4+WZR60asC3SHXiJM
	DXZ64Cufek5VrmfPs3M7SlIaozp0CBgEMfur94RVs0vQ4NzOxYqkCR7FHzK/oT0EAn628EuVpmH
	F3KrEMdglnxbk3zSR0xGgdb+7HA8cRR4XxNRYnvTtlmDE69ixl2PLMPz0VKHyEgOJjxw+M5R8Bw
	VOX3LSomb8crvwukHxVi2VstwpPojFzVxH9HeDY3lI+qOaxhcqUCObBbXkK6fU8D1E83fn6esoz
	Y3TQe58FZCYJJux0PA1C3wjoSiPsE6LzgQ1/BRdrmIkuhxYMRZNUU+PBAZNmWSwqOl5bW/0OgGB
	9CRSljc33JbwCMAfW0TmkDr6MJvX8gNS7c1Hf2AbniQD0bOv6JpZO1vUGuh+3ldw781A1bTSAry
	IbgZehcwc9wFdq2mRrTVQpqV+3ADJnD4wUA2UpndpUD
X-Received: by 2002:a05:600c:1d0d:b0:495:727f:40d2 with SMTP id 5b1f17b1804b1-496b571354amr48952935e9.38.1785029475307;
        Sat, 25 Jul 2026 18:31:15 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4957f9b8b67sm149177545e9.4.2026.07.25.18.31.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jul 2026 18:31:14 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v2 9/9] selftests/bpf: Test stack-passed struct_ops arena arguments
Date: Sun, 26 Jul 2026 03:31:02 +0200
Message-ID: <20260726013105.3689867-10-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260726013105.3689867-1-memxor@gmail.com>
References: <20260726013105.3689867-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5274; i=memxor@gmail.com; h=from:subject; bh=JIS7Wfhf3S5X7uvk7woORlEYAnTLNCOfmOHRGpyTbWs=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JISs12Trr2nqmmluZfSy7dac/CDZlU9pT8+jJvG+LlUMcz 55/KLito5SFQYyLQVZMkaXk/z4m4xOVvwNtl3HDzGFlAhnCwMUpABPJ6WBkeLhb1UlN6vWnFK9y qxvyx08nJMp85zv+4IvQGr7bgVH75jAyXHZkyJw7/9WfJ9kNgVucuRflN5zN33ImYNFn0aOTTE9 MYQMA
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

From: Tejun Heo <tj@kernel.org>

Add a test_arena_stack member with eight leading scalar arguments so the
arena pointer is passed on the stack.

The callback validates the first and last scalar ctx slots before
dereferencing the pointer in ctx[8]. This exercises the indirect
trampoline stack layout and arena conversion together, and prevents a
regression where stack arguments are read one slot late.

Signed-off-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../selftests/bpf/progs/struct_ops_arena.c    | 21 +++++++++++++++++++
 .../selftests/bpf/test_kmods/bpf_testmod.c    | 14 +++++++++++++
 .../selftests/bpf/test_kmods/bpf_testmod.h    |  3 +++
 .../bpf/test_kmods/bpf_testmod_kfunc.h        |  1 +
 4 files changed, 39 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/struct_ops_arena.c b/tools/testing/selftests/bpf/progs/struct_ops_arena.c
index 40c856a748d2..ba04c73d8d96 100644
--- a/tools/testing/selftests/bpf/progs/struct_ops_arena.c
+++ b/tools/testing/selftests/bpf/progs/struct_ops_arena.c
@@ -46,10 +46,24 @@ int test_arena_nullable_cb(unsigned long long *ctx)
 	return 0;
 }
 
+SEC("struct_ops/test_arena_stack")
+int test_arena_stack_cb(unsigned long long *ctx)
+{
+	u64 __arena *ptr = (u64 __arena *)ctx[8];
+
+	arena_touch++;
+	/* pin the slot layout: the leading args fill ctx[0]..ctx[7] */
+	if (ctx[0] != 1 || ctx[7] != 8)
+		return 0xbad;
+	*ptr += 1;
+	return 0;
+}
+
 SEC(".struct_ops.link")
 struct bpf_testmod_ops3 testmod_arena = {
 	.test_arena = (void *)test_arena_cb,
 	.test_arena_nullable = (void *)test_arena_nullable_cb,
+	.test_arena_stack = (void *)test_arena_stack_cb,
 };
 
 SEC("syscall")
@@ -88,6 +102,13 @@ int trigger(void *ctx)
 	if (ret != 0xbee)
 		return 7;
 
+	/* the arena pointer is stack-passed into the trampoline here */
+	ret = bpf_testmod_ops3_call_test_arena_stack((u64 *)val);
+	if (ret)
+		return 8;
+	if (*val != 44)
+		return 9;
+
 	bpf_arena_free_pages(&arena, (void __arena *)val, 1);
 #endif
 	return 0;
diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
index 48ce36a6b82f..9e268fd69a93 100644
--- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
@@ -380,11 +380,19 @@ static int bpf_testmod_ops3__test_arena_nullable(u64 *ptr__arena_nullable)
 	return 0;
 }
 
+static int bpf_testmod_ops3__test_arena_stack(u64 a, u64 b, u64 c, u64 d,
+					      u64 e, u64 f, u64 g, u64 h,
+					      u64 *ptr__arena)
+{
+	return 0;
+}
+
 static struct bpf_testmod_ops3 __bpf_testmod_ops3 = {
 	.test_1 = bpf_testmod_test_3,
 	.test_2 = bpf_testmod_test_4,
 	.test_arena = bpf_testmod_ops3__test_arena,
 	.test_arena_nullable = bpf_testmod_ops3__test_arena_nullable,
+	.test_arena_stack = bpf_testmod_ops3__test_arena_stack,
 };
 
 static void bpf_testmod_test_struct_ops3(void)
@@ -413,6 +421,11 @@ __bpf_kfunc int bpf_testmod_ops3_call_test_arena_nullable(u64 *ptr__arena_nullab
 	return st_ops3->test_arena_nullable(ptr__arena_nullable);
 }
 
+__bpf_kfunc int bpf_testmod_ops3_call_test_arena_stack(u64 *ptr__arena)
+{
+	return st_ops3->test_arena_stack(1, 2, 3, 4, 5, 6, 7, 8, ptr__arena);
+}
+
 struct bpf_testmod_btf_type_tag_1 {
 	int a;
 };
@@ -819,6 +832,7 @@ BTF_ID_FLAGS(func, bpf_testmod_ops3_call_test_1)
 BTF_ID_FLAGS(func, bpf_testmod_ops3_call_test_2)
 BTF_ID_FLAGS(func, bpf_testmod_ops3_call_test_arena)
 BTF_ID_FLAGS(func, bpf_testmod_ops3_call_test_arena_nullable)
+BTF_ID_FLAGS(func, bpf_testmod_ops3_call_test_arena_stack)
 BTF_ID_FLAGS(func, bpf_kfunc_get_default_trusted_ptr_test);
 BTF_ID_FLAGS(func, bpf_kfunc_put_default_trusted_ptr_test);
 BTF_KFUNCS_END(bpf_testmod_common_kfunc_ids)
diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.h b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.h
index c367ec856776..33f2af5b7085 100644
--- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.h
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.h
@@ -109,6 +109,9 @@ struct bpf_testmod_ops3 {
 	/* Used to test arena pointer arguments. */
 	int (*test_arena)(u64 *ptr);
 	int (*test_arena_nullable)(u64 *ptr);
+	/* enough leading args to force @ptr onto the stack on x86 and arm64 */
+	int (*test_arena_stack)(u64 a, u64 b, u64 c, u64 d, u64 e, u64 f,
+				u64 g, u64 h, u64 *ptr);
 };
 
 struct st_ops_args {
diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h b/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h
index ff0d3894d7af..1a72d0fda53c 100644
--- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h
@@ -123,6 +123,7 @@ u32 bpf_kfunc_call_test_static_unused_arg(u32 arg, u32 unused) __ksym;
 void bpf_testmod_test_mod_kfunc(int i) __ksym;
 int bpf_testmod_ops3_call_test_arena(__u64 *ptr__arena) __ksym;
 int bpf_testmod_ops3_call_test_arena_nullable(__u64 *ptr__arena_nullable) __ksym;
+int bpf_testmod_ops3_call_test_arena_stack(__u64 *ptr__arena) __ksym;
 
 __u64 bpf_kfunc_call_test1(struct sock *sk, __u32 a, __u64 b,
 				__u32 c, __u64 d) __ksym;
-- 
2.53.0

