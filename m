Received: from mail-oo2-f5.google.com (mail-oo2-f5.google.com [74.125.231.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BCC5223DE7
	for <bpf@vger.kernel.org>; Sat,  8 Aug 2026 00:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786149604; cv=none; b=iuQ7veum3R040948VZ1ndBxoISbhjTvMs7dpOX30AWpZ32gpNFt065MH/6JLIOUnPsFG8HGjO3B6rIgmT9U1tTMdhXwdtOR0/T1UM0PZa4DgkwCC67/VIemScEDEYq0QNNfkdFCiiiKlxSGKiZx/j36CbuHb+yYsTrRNCOp1SHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786149604; c=relaxed/simple;
	bh=lWF02eTye9G83JreQdkHT318ZQys2xWo7sudTq2HvPE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pMek/9lCNOa54WAcRBzXuak//VhIP8MBHtoeN99XlFTTM6Fx7lOm8hyNYDzSgY+4Xc5IL2b7lLhCh9hNkwVvVmFNYeDCJGQ5cJOXqLAv5y0jmxX940NhSdewKcrD3/EsuxCkZ3GZGNrSDDzVF46VC6fh45k/2UMLzOpdM62N6yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VBvNVH+/; arc=none smtp.client-ip=74.125.231.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VBvNVH+/"
Received: by mail-oo2-f5.google.com with SMTP id 006d021491bc7-6a3900cb2b5so41026eaf.0
        for <bpf@vger.kernel.org>; Fri, 07 Aug 2026 17:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786149601; x=1786754401; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7bHEBSDYUgpYPQFmM+W0XzUDTRFjT2OhX+zFyMLTe14=;
        b=VBvNVH+/94b8DNzracuyp9leXRdnmHbBwRqfMv/XHlxtUVHTk96Hq2boz6jEsS6QEx
         A+WuD0Feq/6FZOtDbifowHLec2doOZm1J3L/ivsvFudVdlJx2GvFipGN3KbobL9s7l1h
         OkVkHCCzxi7f/eGrG7Aad9xq3FBwpnZAsMLQ3JSERYgSlTSq7MyZ9oKU8rl68kWmjG0Y
         NEmd92Tl9MQs/W2Lb7pabD3rctcuRIDpuC8cmuAEJIRKJpkn5TpknpKy3yDlyVBArqBf
         8H/3htkdibxHI0OsQ/h8JhNZPYV9A2OuCcvcbAMcUA0h8w5xOKJkbiwVOFWX2X2y0D+k
         MPlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786149601; x=1786754401;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=7bHEBSDYUgpYPQFmM+W0XzUDTRFjT2OhX+zFyMLTe14=;
        b=MUkN80qEVeG0ALdsZqD5HWbLL0nw8JtN4lxb7UZBd/fHQFRRDa2fJ6xcyhp47Bpwpo
         lEXa58fY+FLpcC1unyO7vDlUFLegyIbP1HC/rXT/3L+qKfSioJA3vaob5VgbqucxhOwp
         rrYLovoIZpuVdEw6BcGerv8YYlLxh9jGt8PDiwKZCp73RAFeSi8SM2PQXr5mN1OIragd
         dQ457LsirUn/QXR9Y8Q1rNJS6PFhEixmRMeD623TVa8UUqrRuYS3kSDk7gYM+us3Sy8T
         lRFz3QacIXAddL/Z6OKFe2Vb5fw4t1kqeAevfWmuEWpkV5asn87socGgAPm3UKZwJbDg
         igOA==
X-Gm-Message-State: AOJu0YzJflRsY+M+VALQuS5iIT7zV6lz002HO3e1d9c4OJTOOQWcKDBQ
	FanFftEFN8qqo90ob3LTIHZcldGZyratt2lrpovrgbz+RqermgZsiVwGkc4B8rDHRmc=
X-Gm-Gg: AR+sD12tWP0wBfR6PkW51iYPoZxCV/QnW1NBlAsrmpGOz8ex0Xen+Lvx6q5sFMRAAbl
	pOxdD5PjFbtlnMK+sreRbsUf6ZQPWAJU40T1/KA+1Vaw14IGmvEs6FLVGx7U97gakWuPrvpLaAp
	3PFO7jq9+JZJPtOycZGi0fi7w43BtJwYOU00daKcCL0a0ISZy2e6YJwf0605WZ7kNvJwxIwcPts
	S3MQgrvEnKTY8oOqr5qxMTtXW9RbR1vYjH6YMrXLxXFnPzcmA8mv5EzaXPYdBW5gpklV7VQuxxS
	RhKx6MnWx2ffTnoIp9d6UqO5Rle3xNmerVdLeisBEPejdbdwCHqDCUjhG6rkuGNCTCoFf4OX05B
	jRUgigCyug2Hj4sygvU36d2BhfPiL7kMCLeGQH+samWFpqPU2kv3GW3lgxpRnu/+EYqIPq4Bzp7
	Lsu2w/5KPgvPYvQup5ez9G+4aaNEeteHGQZ+s6EJNrJRxjeV/PCFKNPJfgB6m96R5J8v9sp3Bmk
	eMhhSaHBj5NFUeGBKnNaFh57l5UuSsPve/hjFA1F852c6ZbWG/8Fv4glS4nICIhVte8Qjk=
X-Received: by 2002:a05:6820:189a:b0:6aa:f2f9:b3ee with SMTP id 006d021491bc7-6b0211b73e2mr7667078eaf.6.1786149601222;
        Fri, 07 Aug 2026 17:40:01 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:43::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6b02bfa6379sm3246130eaf.14.2026.08.07.17.39.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 17:39:59 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v5 08/14] selftests/bpf: Add kfunc __arena and __arena__nullable argument tests
Date: Sat,  8 Aug 2026 02:39:28 +0200
Message-ID: <20260808003938.3486067-9-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260808003938.3486067-1-memxor@gmail.com>
References: <20260808003938.3486067-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=11848; i=memxor@gmail.com; h=from:subject; bh=nw98ZsTIxa/HWUqOmdJ5yI7Juvq1JmjNXPYpBebyKjw=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIausqvLSAsWUfb7mhSGfdM/z6e0MXaHCHP9MtWTaxXd7co57 mnztKGVhEONikBVTZCn5v4/J+ETl70DbZdwwc1iZQIYwcHEKwESuyTP8s9xg5huoc7a1z+6nw2uh5f mLHHR2Tuj8H/Nzmcnxm7IuHYwMe/fwJHut4fJ7ofjR6v3lI1s5rkyN79ghPVeKOa3XR3wlFwA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

From: Tejun Heo <tj@kernel.org>

Add arena-argument kfuncs to bpf_testmod, which also exercises the
argument rebasing on module kfuncs, and tests covering the accepted
argument forms (arena pointer, low 32 bits as a scalar, full user
address as a scalar), the exact rebase semantics via capture kfuncs
returning the raw argument (zero low 32 bits arrive as the arena kernel
base under __arena and as NULL under __arena__nullable), five arena
arguments in one call, a mixed __arena plus __arena__nullable call
exercising both bitmasks on one call site, a kernel-side dereference of
an unpopulated page recovering through the scratch page, and the
rejections (no arena in the program, incompatible register type).

The tests run on x86-64 and skip elsewhere, as programs with
arena-tagged kfunc args fail verification where the JIT lacks support.

Signed-off-by: Tejun Heo <tj@kernel.org>
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../selftests/bpf/prog_tests/verifier.c       |   3 +
 .../testing/selftests/bpf/progs/arena_kfunc.c | 234 ++++++++++++++++++
 .../selftests/bpf/test_kmods/bpf_testmod.c    |  44 ++++
 .../bpf/test_kmods/bpf_testmod_kfunc.h        |   9 +
 4 files changed, 290 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/arena_kfunc.c

diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
index b79bafca68f7..380a624dd63f 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
@@ -2,6 +2,7 @@
 
 #include <test_progs.h>
 
+#include "arena_kfunc.skel.h"
 #include "cap_helpers.h"
 #include "verifier_align.skel.h"
 #include "verifier_and.skel.h"
@@ -161,6 +162,8 @@ static void run_tests_aux(const char *skel_name,
 
 #define RUN(skel) run_tests_aux(#skel, skel##__elf_bytes, NULL)
 
+void test_arena_kfunc(void)                   { RUN_TESTS(arena_kfunc); }
+
 void test_verifier_align(void)                { RUN(verifier_align); }
 void test_verifier_and(void)                  { RUN(verifier_and); }
 void test_verifier_arena(void)                { RUN(verifier_arena); }
diff --git a/tools/testing/selftests/bpf/progs/arena_kfunc.c b/tools/testing/selftests/bpf/progs/arena_kfunc.c
new file mode 100644
index 000000000000..cdcea889da58
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/arena_kfunc.c
@@ -0,0 +1,234 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
+
+#define BPF_NO_KFUNC_PROTOTYPES
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+#include "bpf_experimental.h"
+#include <bpf_arena_common.h>
+#include "../test_kmods/bpf_testmod_kfunc.h"
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARENA);
+	__uint(map_flags, BPF_F_MMAPABLE);
+	/* page 0 hosts the arena global, page 1 is for allocations */
+	__uint(max_entries, 2);
+} arena SEC(".maps");
+
+/*
+ * Occupies page 0 so no allocation lands at arena offset 0, which the
+ * nullable tests below must be able to tell apart from NULL.
+ */
+u64 __arena arena_pad;
+
+/* volatile to force the scalar reloads below */
+volatile u64 stash;
+
+SEC("syscall")
+__arch_x86_64
+__success __retval(0)
+int arena_arg_forms(void *ctx)
+{
+#if defined(__BPF_FEATURE_ADDR_SPACE_CAST)
+	u64 __arena *val;
+	u64 ret;
+
+	val = bpf_arena_alloc_pages(&arena, NULL, 1, NUMA_NO_NODE, 0);
+	if (!val)
+		return 1;
+
+	/* PTR_TO_ARENA argument */
+	*val = 41;
+	ret = bpf_kfunc_arena_arg_test((u64 *)val);
+	if (ret != 41 || *val != 42)
+		return 2;
+
+	/* the low 32 bits as a scalar */
+	stash = (u32)(u64)val;
+	ret = bpf_kfunc_arena_arg_test((u64 *)stash);
+	if (ret != 42 || *val != 43)
+		return 3;
+
+	/* the full user address as a scalar */
+	stash = (u64)val;
+	bpf_addr_space_cast(stash, 1, 0);
+	ret = bpf_kfunc_arena_arg_test((u64 *)stash);
+	if (ret != 43 || *val != 44)
+		return 4;
+
+	bpf_arena_free_pages(&arena, (void __arena *)val, 1);
+#endif
+	return 0;
+}
+
+/*
+ * Pin the rebase semantics using the capture kfuncs, which return the raw
+ * argument value: __arena rebases unconditionally, so zero low 32 bits
+ * arrive as the arena kernel base, while __arena__nullable turns them into
+ * NULL.
+ */
+SEC("syscall")
+__arch_x86_64
+__success __retval(0)
+int arena_arg_rebase(void *ctx)
+{
+#if defined(__BPF_FEATURE_ADDR_SPACE_CAST)
+	u64 __arena *val;
+	u64 base, off;
+
+	val = bpf_arena_alloc_pages(&arena, NULL, 1, NUMA_NO_NODE, 0);
+	if (!val)
+		return 1;
+
+	base = bpf_kfunc_arena_cap_test(NULL);
+	if (!base)
+		return 2;
+
+	/* only the low 32 bits contribute */
+	stash = 0xbadc0ffe00000000;
+	if (bpf_kfunc_arena_cap_test((u64 *)stash) != base)
+		return 3;
+
+	off = (u32)(u64)val;
+	if (bpf_kfunc_arena_cap_test((u64 *)val) != base + off)
+		return 4;
+
+	if (bpf_kfunc_arena_cap_nullable_test(NULL) != 0)
+		return 5;
+
+	stash = 0xbadc0ffe00000000;
+	if (bpf_kfunc_arena_cap_nullable_test((u64 *)stash) != 0)
+		return 6;
+
+	if (bpf_kfunc_arena_cap_nullable_test((u64 *)val) != base + off)
+		return 7;
+
+	bpf_arena_free_pages(&arena, (void __arena *)val, 1);
+#endif
+	return 0;
+}
+
+SEC("syscall")
+__arch_x86_64
+__success __retval(0)
+int arena_args5(void *ctx)
+{
+#if defined(__BPF_FEATURE_ADDR_SPACE_CAST)
+	u64 __arena *val;
+
+	val = bpf_arena_alloc_pages(&arena, NULL, 1, NUMA_NO_NODE, 0);
+	if (!val)
+		return 1;
+
+	val[0] = 1;
+	val[1] = 2;
+	val[2] = 4;
+	val[3] = 8;
+	val[4] = 16;
+
+	if (bpf_kfunc_arena_args5_test((u64 *)&val[0], (u64 *)&val[1],
+				       (u64 *)&val[2], (u64 *)&val[3],
+				       (u64 *)&val[4]) != 31)
+		return 2;
+	if (bpf_kfunc_arena_args5_test((u64 *)&val[0], (u64 *)&val[1],
+				       (u64 *)&val[2], (u64 *)&val[3], NULL) != 15)
+		return 3;
+
+	bpf_arena_free_pages(&arena, (void __arena *)val, 1);
+#endif
+	return 0;
+}
+
+SEC("syscall")
+__arch_x86_64
+__success __retval(0)
+int arena_arg_mixed(void *ctx)
+{
+#if defined(__BPF_FEATURE_ADDR_SPACE_CAST)
+	u64 __arena *val;
+
+	val = bpf_arena_alloc_pages(&arena, NULL, 1, NUMA_NO_NODE, 0);
+	if (!val)
+		return 1;
+
+	val[0] = 7;
+	val[1] = 5;
+
+	if (bpf_kfunc_arena_mixed_test((u64 *)&val[0], NULL) != 7)
+		return 2;
+
+	if (bpf_kfunc_arena_mixed_test((u64 *)&val[0], (u64 *)&val[1]) != 12)
+		return 3;
+
+	bpf_arena_free_pages(&arena, (void __arena *)val, 1);
+#endif
+	return 0;
+}
+
+/* kernel-side faults on unpopulated pages recover via the scratch page */
+SEC("syscall")
+__arch_x86_64
+__success __retval(0)
+int arena_arg_unpopulated(void *ctx)
+{
+#if defined(__BPF_FEATURE_ADDR_SPACE_CAST)
+	u64 __arena *val;
+
+	val = bpf_arena_alloc_pages(&arena, NULL, 1, NUMA_NO_NODE, 0);
+	if (!val)
+		return 1;
+
+	stash = (u64)val + PAGE_SIZE;
+	bpf_kfunc_arena_arg_test((u64 *)stash);
+
+	bpf_arena_free_pages(&arena, (void __arena *)val, 1);
+#endif
+	return 0;
+}
+
+SEC("syscall")
+__arch_x86_64
+__failure __msg("arena pointer requires a program with an associated arena")
+int arena_arg_no_arena(void *ctx)
+{
+	bpf_kfunc_arena_arg_test((u64 *)1);
+	return 0;
+}
+
+SEC("syscall")
+__arch_x86_64
+__failure __msg("is not a pointer to arena or scalar")
+int arena_arg_bad_reg(void *ctx)
+{
+	u64 buf = 0;
+
+	/* use the arena so the program passes the arena presence check */
+	bpf_arena_alloc_pages(&arena, NULL, 1, NUMA_NO_NODE, 0);
+	bpf_kfunc_arena_arg_test(&buf);
+	return 0;
+}
+
+#if defined(__BPF_FEATURE_ADDR_SPACE_CAST) && \
+	defined(__BPF_FEATURE_STACK_ARGUMENT)
+SEC("syscall")
+__arch_x86_64
+__failure __msg("arena pointer cannot be a stack argument")
+int arena_arg_stack(void *ctx)
+{
+	bpf_arena_alloc_pages(&arena, NULL, 1, NUMA_NO_NODE, 0);
+	bpf_kfunc_arena_stack_arg_test(1, 2, 3, 4, 5, (u64 *)1);
+	return 0;
+}
+#else
+SEC("syscall")
+__arch_x86_64
+__description("arena_arg_stack: not supported, dummy test")
+__success
+int arena_arg_stack(void *ctx)
+{
+	return 0;
+}
+#endif
+
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
index 0585794606ed..2291bb466517 100644
--- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
@@ -237,6 +237,44 @@ __bpf_kfunc void bpf_kfunc_common_test(void)
 {
 }
 
+__bpf_kfunc u64 bpf_kfunc_arena_arg_test(u64 *val__arena)
+{
+	u64 old;
+
+	old = *val__arena;
+	*val__arena = old + 1;
+	return old;
+}
+
+__bpf_kfunc u64 bpf_kfunc_arena_cap_test(u64 *val__arena)
+{
+	return (u64)val__arena;
+}
+
+__bpf_kfunc u64 bpf_kfunc_arena_cap_nullable_test(u64 *val__arena__nullable)
+{
+	return (u64)val__arena__nullable;
+}
+
+__bpf_kfunc u64 bpf_kfunc_arena_args5_test(u64 *a__arena, u64 *b__arena,
+					   u64 *c__arena, u64 *d__arena,
+					   u64 *e__arena__nullable)
+{
+	return *a__arena + *b__arena + *c__arena + *d__arena +
+	       (e__arena__nullable ? *e__arena__nullable : 0);
+}
+
+__bpf_kfunc u64 bpf_kfunc_arena_stack_arg_test(u64 a, u64 b, u64 c, u64 d, u64 e,
+						u64 *f__arena)
+{
+	return a + b + c + d + e + *f__arena;
+}
+
+__bpf_kfunc u64 bpf_kfunc_arena_mixed_test(u64 *a__arena, u64 *b__arena__nullable)
+{
+	return *a__arena + (b__arena__nullable ? *b__arena__nullable : 0);
+}
+
 __bpf_kfunc void bpf_kfunc_dynptr_test(struct bpf_dynptr *ptr,
 				       struct bpf_dynptr *ptr__nullable)
 {
@@ -755,6 +793,12 @@ BTF_ID_FLAGS(func, bpf_iter_testmod_seq_next, KF_ITER_NEXT | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_iter_testmod_seq_destroy, KF_ITER_DESTROY)
 BTF_ID_FLAGS(func, bpf_iter_testmod_seq_value)
 BTF_ID_FLAGS(func, bpf_kfunc_common_test)
+BTF_ID_FLAGS(func, bpf_kfunc_arena_arg_test)
+BTF_ID_FLAGS(func, bpf_kfunc_arena_cap_test)
+BTF_ID_FLAGS(func, bpf_kfunc_arena_cap_nullable_test)
+BTF_ID_FLAGS(func, bpf_kfunc_arena_args5_test)
+BTF_ID_FLAGS(func, bpf_kfunc_arena_stack_arg_test)
+BTF_ID_FLAGS(func, bpf_kfunc_arena_mixed_test)
 BTF_ID_FLAGS(func, bpf_kfunc_call_test_mem_len_pass1)
 BTF_ID_FLAGS(func, bpf_kfunc_dynptr_test)
 BTF_ID_FLAGS(func, bpf_kfunc_nested_acquire_nonzero_offset_test, KF_ACQUIRE)
diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h b/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h
index c36bb911defa..453bfd94154f 100644
--- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h
@@ -98,6 +98,15 @@ void bpf_kfunc_call_test_release(struct prog_test_ref_kfunc *p) __ksym;
 void bpf_kfunc_call_test_ref(struct prog_test_ref_kfunc *p) __ksym;
 
 void bpf_kfunc_call_test_mem_len_pass1(void *mem, int len) __ksym;
+__u64 bpf_kfunc_arena_arg_test(__u64 *val__arena) __ksym;
+__u64 bpf_kfunc_arena_cap_test(__u64 *val__arena) __ksym;
+__u64 bpf_kfunc_arena_cap_nullable_test(__u64 *val__arena__nullable) __ksym;
+__u64 bpf_kfunc_arena_args5_test(__u64 *a__arena, __u64 *b__arena,
+				 __u64 *c__arena, __u64 *d__arena,
+				 __u64 *e__arena__nullable) __ksym;
+__u64 bpf_kfunc_arena_stack_arg_test(__u64 a, __u64 b, __u64 c, __u64 d, __u64 e,
+				     __u64 *f__arena) __ksym;
+__u64 bpf_kfunc_arena_mixed_test(__u64 *a__arena, __u64 *b__arena__nullable) __ksym;
 int *bpf_kfunc_call_test_get_rdwr_mem(struct prog_test_ref_kfunc *p, const int rdwr_buf_size) __ksym;
 int *bpf_kfunc_call_test_get_rdonly_mem(struct prog_test_ref_kfunc *p, const int rdonly_buf_size) __ksym;
 int *bpf_kfunc_call_test_acq_rdonly_mem(struct prog_test_ref_kfunc *p, const int rdonly_buf_size) __ksym;
-- 
2.53.0-Meta

