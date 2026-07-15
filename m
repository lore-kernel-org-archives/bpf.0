Received: from mail-wr2-f0.google.com (mail-wr2-f0.google.com [74.125.225.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 386D13C141A
	for <bpf@vger.kernel.org>; Wed, 15 Jul 2026 22:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784152863; cv=none; b=P5Z3/bAZUETeAr9UIj6hKzivLUKsKGw4PKIcAFTVGINVXa5gpBgjlrsQMwbCjAr1QH7pAzelN13go22pCR9XyS2NmiCODv+cQ8GaLBfN8Yh+BV2ETA+ZMcL0BtjRdkn4gSCVsGX/j6sJreDEqoE68gBoyLw6UUQ9ljSwZbgpGMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784152863; c=relaxed/simple;
	bh=9yrpxtklULZO6VnhGprWaXaUQ8gxj8KCvS9Hloqn2Bc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B0rcqbZkA56eg3lrhOjIwr3O6qqpUaebV2yATVIJbBVYYTzJa/sYqxSvr9n8CD3Zg3v71L2MYl1eycqI219Mz9HTB6e0KFGl+vYqi22lyMFDhrxJgHc46LbQd1zTQ62xm+04ahtfCX/1QBat8aJzdLIayRZ9lKq3qp5Yeb+vcK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cq+ldLGh; arc=none smtp.client-ip=74.125.225.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cq+ldLGh"
Received: by mail-wr2-f0.google.com with SMTP id ffacd0b85a97d-47f4c92d1b3so483001f8f.0
        for <bpf@vger.kernel.org>; Wed, 15 Jul 2026 15:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784152859; x=1784757659; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ATJfFRa/uqTJdxlY2AfqT4yYahm7uC9ph4XhL7W06yA=;
        b=cq+ldLGhM2HDZdMDAn2kXKQhE00WkunmIGaRtpX5AnUDpbKq/kh7rlKoMWUZ8CNFDK
         HGtEUa1C64Fpaf/ec1UR/jYrIEbpwQxtH/mewUwxdM6M+ve1TOYcjv8edrUFhAGbzwV+
         ZAfwVgx2CvIT3m7b7zvLONvr0KI9i2KzoS5bDwm/uYlIr76eZLTQdtm1O0+rddDr23DS
         F5POOK+WIcAnmjly4/L2TNgRht3LzI7bsfu+4QvAA+Ew/2VVwpc0njRQFbcQ5KoCl+ci
         Ubeacf8by0t9flTkZD0Rno3dZi3BEEsEY79E16VOxLJ1Ed6bG+xW0ikPMd2VrJtyjQ4s
         1GRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784152859; x=1784757659;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ATJfFRa/uqTJdxlY2AfqT4yYahm7uC9ph4XhL7W06yA=;
        b=kLj20phF/UoYby/ZrShpnxXSRge7a+Er2CUVXvuU/Rlzjp8g0vIihPlkj+PC5SOplp
         mMhdLN4/HJZatmQ2/vyFKByK3U62bm2+bLreMpVLDclK0AFbHKeUwqDIAkeJlRjEKN+w
         mXUtwWpleLUKrY/458CRVcPJVrMQ1nzfLDIDhZU9owNGtS1hcS3zFq4ammznFeKWa4Sk
         5uWyjtrsi56U6iRjeOvBGV40e7tPpm0TmdfmFivD42aGs4mKtWx7jhoAXlRD7l091TIg
         +imm+E1tcqzby2ubf1rcja1i3Zun6XCu7t7qfx55QTQsj8yRgusq72Q+tFaAok50G8DU
         nTKw==
X-Gm-Message-State: AOJu0YzBGP3HwO4zO64B3k/BE0pKoepZJXbkMeYE9Qi0GRgGvlUW3o3T
	sofUSFRRpyM//tS34Bd4rfgoc+jvgiOADbHZnZ8YQESW8FgEiw9ZR1l26JzEaMSK
X-Gm-Gg: AfdE7cmxv74hqmgYEr+cEkBN0HVW1bZjuVRRjdY0InMOvu+63IGhhlPakmAGbCPEghx
	HB7X0yGAdXijrV4MReDzKgISXTLNKuZplfiQrgGdJiLjGs8ffrxdaB4KUs0jPiNcHQ7Q11a9IHX
	3Oy3prZZaEbVEZ7UwbcCscYyLEx4GCnGtZGg6zMhGwCx6kbQnT4BEBM2fEuXPgcZMo/MxEHB3Qd
	yUwE1VgqnU8xHLlNLiHgNhA0+9Xwmm/u/X/PnKAa1P5u2V2j2eja/JrVxn8XrE8KX9M0PwcLsFX
	IEJjM2bdM+8EnMslFv/GJxs8gQbX5L1OeEYi+uOUN90MEcZTBPJD+94/15YabII9tUqw+2+RIIx
	ZSSU9Muv4NV5wTF343tusg3ou5YJYJfwZ4Tjm6929VHzA+QpR3o0447vpDz/Uz/72fDU+nJNB4n
	pKVOoZCCahc8kFrIjHtTSZyQFpzz5lJiqCBEpQUeNh+36duDg2QZ4Tiiyq333Alz6eRxipSD2MP
	3Vr86IknvEWMm1gxb1Bk7Ecx6n/u1bN3785FLHfQSQASvazJqTUbHQ=
X-Received: by 2002:a05:6000:2510:b0:475:f0c2:5b01 with SMTP id ffacd0b85a97d-47f488dfb44mr9934682f8f.55.1784152859261;
        Wed, 15 Jul 2026 15:00:59 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f4634debesm19592641f8f.8.2026.07.15.15.00.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 15:00:58 -0700 (PDT)
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
Subject: [PATCH bpf-next v1 5/9] selftests/bpf: Add kfunc __arena and __arena_nullable argument tests
Date: Thu, 16 Jul 2026 00:00:45 +0200
Message-ID: <20260715220052.1590783-6-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260715220052.1590783-1-memxor@gmail.com>
References: <20260715220052.1590783-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=12461; i=memxor@gmail.com; h=from:subject; bh=AqnDWmx/cWm94HqHCRCrIGh4lEfQAzHyjkswriRpOmo=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JISuC6bblqmdXmc6c2pz15+gCyY8Lurs2ek+OmiPTnGIxc Z/8/iSNjlIWBjEuBlkxRZaS//uYjE9U/g60XcYNM4eVCWQIAxenAEzk611Gho+fPseVTcngDJW7 M23yzeLCiSv/bWqcaXOe49QmsdyNZxYyMkxuFV6SeZF/Z/faxRfin/XKr9O4/ajFMiCNse3khhV Xr7EDAA==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

From: Tejun Heo <tj@kernel.org>

Add arena-argument kfuncs to bpf_testmod, which also exercises the
argument rebasing on module kfuncs, and tests covering the accepted
argument forms (arena pointer, low 32 bits as a scalar, full user
address as a scalar), the exact rebase semantics via capture kfuncs
returning the raw argument (zero low 32 bits arrive as the arena kernel
base under __arena and as NULL under __arena_nullable), a NULL round
trip through a nullable deref kfunc, five arena arguments in one call, a
mixed __arena plus __arena_nullable call exercising both bitmasks on one
call site, a kernel-side dereference of an unpopulated page recovering
through the scratch page, and the rejections (no arena in the program,
incompatible register type).

The tests run on x86-64 and skip elsewhere, as programs with
arena-tagged kfunc args fail verification where the JIT lacks support.

Signed-off-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../selftests/bpf/prog_tests/arena_kfunc.c    |  15 ++
 .../testing/selftests/bpf/progs/arena_kfunc.c | 250 ++++++++++++++++++
 .../selftests/bpf/test_kmods/bpf_testmod.c    |  57 ++++
 .../bpf/test_kmods/bpf_testmod_kfunc.h        |  10 +
 4 files changed, 332 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/arena_kfunc.c
 create mode 100644 tools/testing/selftests/bpf/progs/arena_kfunc.c

diff --git a/tools/testing/selftests/bpf/prog_tests/arena_kfunc.c b/tools/testing/selftests/bpf/prog_tests/arena_kfunc.c
new file mode 100644
index 000000000000..9be19565f0d5
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/arena_kfunc.c
@@ -0,0 +1,15 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
+#include <test_progs.h>
+
+#include "arena_kfunc.skel.h"
+
+/*
+ * The test kfuncs live in bpf_testmod. Resolving kfuncs against module
+ * BTFs needs CAP_SYS_ADMIN, so run with full capabilities instead of
+ * through the verifier tests' capability-restricted runner.
+ */
+void test_arena_kfunc(void)
+{
+	RUN_TESTS(arena_kfunc);
+}
diff --git a/tools/testing/selftests/bpf/progs/arena_kfunc.c b/tools/testing/selftests/bpf/progs/arena_kfunc.c
new file mode 100644
index 000000000000..e7250c5197ab
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/arena_kfunc.c
@@ -0,0 +1,250 @@
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
+ * arrive as the arena kernel base, while __arena_nullable turns them into
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
+SEC("syscall")
+__arch_x86_64
+__failure __msg("arena pointer cannot be a stack argument")
+int arena_arg_stack(void *ctx)
+{
+#if defined(__BPF_FEATURE_ADDR_SPACE_CAST)
+	bpf_arena_alloc_pages(&arena, NULL, 1, NUMA_NO_NODE, 0);
+	bpf_kfunc_arena_stack_arg_test(1, 2, 3, 4, 5, (u64 *)1);
+#endif
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
index 30f1cd23093c..fad106b1549c 100644
--- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
@@ -210,6 +210,56 @@ __bpf_kfunc void bpf_kfunc_common_test(void)
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
+__bpf_kfunc u64 bpf_kfunc_arena_nullable_arg_test(u64 *val__arena_nullable)
+{
+	u64 old;
+
+	if (!val__arena_nullable)
+		return 0xdeadbeef;
+
+	old = *val__arena_nullable;
+	*val__arena_nullable = old + 1;
+	return old;
+}
+
+__bpf_kfunc u64 bpf_kfunc_arena_cap_test(u64 *val__arena)
+{
+	return (u64)val__arena;
+}
+
+__bpf_kfunc u64 bpf_kfunc_arena_cap_nullable_test(u64 *val__arena_nullable)
+{
+	return (u64)val__arena_nullable;
+}
+
+__bpf_kfunc u64 bpf_kfunc_arena_args5_test(u64 *a__arena, u64 *b__arena,
+					   u64 *c__arena, u64 *d__arena,
+					   u64 *e__arena_nullable)
+{
+	return *a__arena + *b__arena + *c__arena + *d__arena +
+	       (e__arena_nullable ? *e__arena_nullable : 0);
+}
+
+__bpf_kfunc u64 bpf_kfunc_arena_stack_arg_test(u64 a, u64 b, u64 c, u64 d, u64 e,
+						u64 *f__arena)
+{
+	return a + b + c + d + e + *f__arena;
+}
+
+__bpf_kfunc u64 bpf_kfunc_arena_mixed_test(u64 *a__arena, u64 *b__arena_nullable)
+{
+	return *a__arena + (b__arena_nullable ? *b__arena_nullable : 0);
+}
+
 __bpf_kfunc void bpf_kfunc_dynptr_test(struct bpf_dynptr *ptr,
 				       struct bpf_dynptr *ptr__nullable)
 {
@@ -723,6 +773,13 @@ BTF_ID_FLAGS(func, bpf_iter_testmod_seq_next, KF_ITER_NEXT | KF_RET_NULL)
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
index c36bb911defa..42d3fccc6ff9 100644
--- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h
@@ -98,6 +98,16 @@ void bpf_kfunc_call_test_release(struct prog_test_ref_kfunc *p) __ksym;
 void bpf_kfunc_call_test_ref(struct prog_test_ref_kfunc *p) __ksym;
 
 void bpf_kfunc_call_test_mem_len_pass1(void *mem, int len) __ksym;
+__u64 bpf_kfunc_arena_arg_test(__u64 *val__arena) __ksym;
+__u64 bpf_kfunc_arena_nullable_arg_test(__u64 *val__arena_nullable) __ksym;
+__u64 bpf_kfunc_arena_cap_test(__u64 *val__arena) __ksym;
+__u64 bpf_kfunc_arena_cap_nullable_test(__u64 *val__arena_nullable) __ksym;
+__u64 bpf_kfunc_arena_args5_test(__u64 *a__arena, __u64 *b__arena,
+				 __u64 *c__arena, __u64 *d__arena,
+				 __u64 *e__arena_nullable) __ksym;
+__u64 bpf_kfunc_arena_stack_arg_test(__u64 a, __u64 b, __u64 c, __u64 d, __u64 e,
+				     __u64 *f__arena) __ksym;
+__u64 bpf_kfunc_arena_mixed_test(__u64 *a__arena, __u64 *b__arena_nullable) __ksym;
 int *bpf_kfunc_call_test_get_rdwr_mem(struct prog_test_ref_kfunc *p, const int rdwr_buf_size) __ksym;
 int *bpf_kfunc_call_test_get_rdonly_mem(struct prog_test_ref_kfunc *p, const int rdonly_buf_size) __ksym;
 int *bpf_kfunc_call_test_acq_rdonly_mem(struct prog_test_ref_kfunc *p, const int rdonly_buf_size) __ksym;
-- 
2.53.0

