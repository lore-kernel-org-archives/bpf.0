Received: from mail-wm2-f10.google.com (mail-wm2-f10.google.com [74.125.225.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 240DA3E5EFF
	for <bpf@vger.kernel.org>; Wed,  5 Aug 2026 21:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785963881; cv=none; b=FsY8FWjlf59qeXdtXuqsvJ0Sn4zawJy+fuzQABTr+SCkWDMzT2vjf4nEYY7dOgEEg1Q2jivpwtIkHLzOYlXrD8y3nCgbEI8IYPgWRQhKXIbuvp2vqFgBh1506Ku9mz4SByapEZ98EUG8B3Ptg5Dlr02qoFDXnW5bKMyd9Cq1a7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785963881; c=relaxed/simple;
	bh=ZK6GJBSF5DFTedhJJgEincE4TvbBvgx8BLgBcskypRY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U2f2AjzGanQOAY4o6xN2/YWromrarhm6q/jnpEDYqfRrteWyV2HDrWr1W4E7E462a9QBOG9Ik27zQV/o0McqLlhrG6CduPSbOepkLy/Uj2nif0quq7uEkQqENtD/yeTs6dQAuhLTYTHwwBIzfM55kUOkC8uICFga2qleCYb7L2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K7kYETWP; arc=none smtp.client-ip=74.125.225.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K7kYETWP"
Received: by mail-wm2-f10.google.com with SMTP id 5b1f17b1804b1-495501e57beso3488325e9.1
        for <bpf@vger.kernel.org>; Wed, 05 Aug 2026 14:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785963877; x=1786568677; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fKOTtFi8KIndCkF6LWMZCjWcInSQr40wGHovpvn/ZbY=;
        b=K7kYETWPTCGLRl24PxpolKg60ADfGgh2KJCPgdnAfhMsjvakTQeF22lzSWMjvTeNW4
         GOZD1ahAUrm4Q/JflXshgt3ioGXSE6ghTNwjCC0hcGtswD/8JukoZzdGtT2ci00FISMF
         gD5X/dYsr7tUC7NPSufa8nBdd+9I01TOkf6kafkiUiqQFiSZBGyWdo8/YLQeELo9kKIB
         XXCQlzaVDSSdZd94C53SsC/Od07dXA94bNjBmbzvCTZ488JNVnYNzcr5gD1z2gQJ5uy8
         w9dewqPJ/z/xPNy3DqDoBoGmfdtV0M/GFkocken90lwmJhniGaVG9jbIkpGwfUBd7cZV
         Df0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785963877; x=1786568677;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=fKOTtFi8KIndCkF6LWMZCjWcInSQr40wGHovpvn/ZbY=;
        b=LGp6zFEx1yAZ7ITmg93ieceDFop7Z0tGHvRbQEDaZo8dzEXVue1AuFwnpNfSWKpgQi
         XYEhPgHES5svmT8dy5Xw9KMo4a9LxSGQpjUFZhgpzgBgD/BeHE2GQ/LHgeQhSn7253LK
         LAwC+Dtj8buqrowDrOL2krh7jgoJa0HJ72FL8ZwWxNAmhu1jTqIQGqQ93zUj6nrZiV/5
         lILYcdGf4gDNZVxLIvl/o8TLlFuHP4sw0DpCnHM2WoGr+4B4jY6jec+9S/1KjgeD9poz
         9oxpVJhSQjvxGfqiJELEKP4GHe5K2A2+5TXaPzjoccOQm9yTM4O/RoB2A0xTPnM4w1sG
         PunA==
X-Gm-Message-State: AOJu0YzqdMfLhJpSdbmGyOmScTkqtT02J19lCu+MDf6txYCZPZXQ7MBg
	LzsuNkEVc8SzEJ122t6JW+qUM9igG1OpLM6UFL/Lz6SuyFag1pGxKtQZCT/+Dfhz
X-Gm-Gg: AR+sD11xe5r89P3s2CMnKydg/AChkRS3C1rR9FAxym9Zy3tOjMSYqc5fXm0z5fnj4VW
	a8jQH4NbRVdzrSZcJoLLyl/GFYUuTeIupAUioILfKvlQbD4grGeeDAU15YlEO0OtwawT3FM7B2S
	wCxkxc4m9glySHkJmoE1eFTi7ajHI0k7tiJ8t5cam05mVohwtelGW6/fB1+k+he4kpRhU6bCDH/
	KxTekWNxS4rxXWTBNwV+lojO+TEPTTIKrUpX+ncQ1pbbXsn2gGa3W5f/ODVa2wfooqWv+lsvmE7
	aS3N7noRtYEq30v2HUprBRPTQnfCJdbtAfHipUWnyBZCSo3oSBGGZrGgjzhBOwu8Fz8vxc2YFX/
	3OuvgkleQnBH/mB11iFMcskjOMxzS0aKVUyVoxmBYf23i4zgpNIfbyTpfS3jDgFCkndDBdCT5yN
	5r6wDh3rt80p7/8ML3G75qv7PAEWGquCYkAvnSvhdyDfvQpG4dKHzQdUlEqiYULLKLpoVhmM3fR
	5lXpYeGL1Pu5VdZ8JJ7pa7yJaK5vOWaVxIjGfTgJYRmDlwOf2rCdH3SmJy/zfk499yIsAsx2c5o
	1X97dY3U2ty2QwzcMkGxj6ByAHk=
X-Received: by 2002:a05:600c:a47:b0:495:779a:ed33 with SMTP id 5b1f17b1804b1-4994e7ad575mr110046515e9.7.1785963877310;
        Wed, 05 Aug 2026 14:04:37 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4995422016fsm5786925e9.8.2026.08.05.14.04.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 14:04:36 -0700 (PDT)
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
Subject: [PATCH bpf-next v4 08/13] selftests/bpf: Add kfunc __arena and __arena__nullable argument tests
Date: Wed,  5 Aug 2026 23:04:19 +0200
Message-ID: <20260805210427.3218326-9-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260805210427.3218326-1-memxor@gmail.com>
References: <20260805210427.3218326-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=13004; i=memxor@gmail.com; h=from:subject; bh=smlH69HuqAHow+6EUEQwBm7NJEN7aX8gOpBkSqMfr2o=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIat40dQE56X+G/yfHpG53D7V/vbuiLk7Eg5UL4gUWHai7 Idjo8jzjlIWBjEuBlkxRZaS//uYjE9U/g60XcYNM4eVCWQIAxenAExkswwjw0/BU/OkdgYXyb3b yu27quafpJOQc3j/756vPpOfPFd10WBk+PxScG9yiyPH6hCHZLYrof+rWvK2/T6iJXxo3p7ormP yTAA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

From: Tejun Heo <tj@kernel.org>

Add arena-argument kfuncs to bpf_testmod, which also exercises the
argument rebasing on module kfuncs, and tests covering the accepted
argument forms (arena pointer, low 32 bits as a scalar, full user
address as a scalar), the exact rebase semantics via capture kfuncs
returning the raw argument (zero low 32 bits arrive as the arena kernel
base under __arena and as NULL under __arena__nullable), a NULL round
trip through a nullable deref kfunc, five arena arguments in one call, a
mixed __arena plus __arena__nullable call exercising both bitmasks on one
call site, a kernel-side dereference of an unpopulated page recovering
through the scratch page, and the rejections (no arena in the program,
incompatible register type).

The tests run on x86-64 and skip elsewhere, as programs with
arena-tagged kfunc args fail verification where the JIT lacks support.

Signed-off-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../selftests/bpf/prog_tests/verifier.c       |   8 +
 .../testing/selftests/bpf/progs/arena_kfunc.c | 260 ++++++++++++++++++
 .../selftests/bpf/test_kmods/bpf_testmod.c    |  57 ++++
 .../bpf/test_kmods/bpf_testmod_kfunc.h        |  10 +
 4 files changed, 335 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/arena_kfunc.c

diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
index b79bafca68f7..7eaee71783b6 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
@@ -2,6 +2,7 @@
 
 #include <test_progs.h>
 
+#include "arena_kfunc.skel.h"
 #include "cap_helpers.h"
 #include "verifier_align.skel.h"
 #include "verifier_and.skel.h"
@@ -161,6 +162,13 @@ static void run_tests_aux(const char *skel_name,
 
 #define RUN(skel) run_tests_aux(#skel, skel##__elf_bytes, NULL)
 
+/*
+ * The test kfuncs live in bpf_testmod. Resolving kfuncs against module
+ * BTFs needs CAP_SYS_ADMIN, so run with full capabilities instead of
+ * through the verifier tests' capability-restricted runner.
+ */
+void test_arena_kfunc(void)                   { RUN_TESTS(arena_kfunc); }
+
 void test_verifier_align(void)                { RUN(verifier_align); }
 void test_verifier_and(void)                  { RUN(verifier_and); }
 void test_verifier_arena(void)                { RUN(verifier_arena); }
diff --git a/tools/testing/selftests/bpf/progs/arena_kfunc.c b/tools/testing/selftests/bpf/progs/arena_kfunc.c
new file mode 100644
index 000000000000..d6c382ce81af
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/arena_kfunc.c
@@ -0,0 +1,260 @@
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
+int arena_arg_nullable(void *ctx)
+{
+#if defined(__BPF_FEATURE_ADDR_SPACE_CAST)
+	u64 __arena *val;
+	u64 ret;
+
+	val = bpf_arena_alloc_pages(&arena, NULL, 1, NUMA_NO_NODE, 0);
+	if (!val)
+		return 1;
+
+	*val = 41;
+	ret = bpf_kfunc_arena_nullable_arg_test((u64 *)val);
+	if (ret != 41 || *val != 42)
+		return 2;
+
+	if (bpf_kfunc_arena_nullable_arg_test(NULL) != 0xdeadbeef)
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
index eb0f9b5e18d8..b92ac1e5df1d 100644
--- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
@@ -237,6 +237,56 @@ __bpf_kfunc void bpf_kfunc_common_test(void)
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
+__bpf_kfunc u64 bpf_kfunc_arena_nullable_arg_test(u64 *val__arena__nullable)
+{
+	u64 old;
+
+	if (!val__arena__nullable)
+		return 0xdeadbeef;
+
+	old = *val__arena__nullable;
+	*val__arena__nullable = old + 1;
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
@@ -755,6 +805,13 @@ BTF_ID_FLAGS(func, bpf_iter_testmod_seq_next, KF_ITER_NEXT | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_iter_testmod_seq_destroy, KF_ITER_DESTROY)
 BTF_ID_FLAGS(func, bpf_iter_testmod_seq_value)
 BTF_ID_FLAGS(func, bpf_kfunc_common_test)
+BTF_ID_FLAGS(func, bpf_kfunc_arena_arg_test)
+BTF_ID_FLAGS(func, bpf_kfunc_arena_nullable_arg_test)
+BTF_ID_FLAGS(func, bpf_kfunc_arena_cap_test)
+BTF_ID_FLAGS(func, bpf_kfunc_arena_cap_nullable_test)
+BTF_ID_FLAGS(func, bpf_kfunc_arena_args5_test)
+BTF_ID_FLAGS(func, bpf_kfunc_arena_stack_arg_test)
+BTF_ID_FLAGS(func, bpf_kfunc_arena_mixed_test)
 BTF_ID_FLAGS(func, bpf_kfunc_call_test_mem_len_pass1)
 BTF_ID_FLAGS(func, bpf_kfunc_dynptr_test)
 BTF_ID_FLAGS(func, bpf_kfunc_nested_acquire_nonzero_offset_test, KF_ACQUIRE)
diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h b/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h
index c36bb911defa..3317436b03a3 100644
--- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h
@@ -98,6 +98,16 @@ void bpf_kfunc_call_test_release(struct prog_test_ref_kfunc *p) __ksym;
 void bpf_kfunc_call_test_ref(struct prog_test_ref_kfunc *p) __ksym;
 
 void bpf_kfunc_call_test_mem_len_pass1(void *mem, int len) __ksym;
+__u64 bpf_kfunc_arena_arg_test(__u64 *val__arena) __ksym;
+__u64 bpf_kfunc_arena_nullable_arg_test(__u64 *val__arena__nullable) __ksym;
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
2.53.0

