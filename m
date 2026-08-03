Received: from mail-wr2-f1.google.com (mail-wr2-f1.google.com [74.125.225.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E826E2253B0
	for <bpf@vger.kernel.org>; Mon,  3 Aug 2026 12:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785761485; cv=none; b=NVSnRo1cfZq0ZOiLfe0VGJGVT+FsXXoNTzZMTVAyfYawhnoLra+5DUcp+z5g2lWIMbqFHL3/IvQ7NKVbV226YZnjnoq5fYy0xf8AZwVZAz5kTAVnM+uhKeBq8dC8QotB8iq/FN3Pd4ksMDN/pig5rAvAnhsnUpTA/rzQUGQeHsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785761485; c=relaxed/simple;
	bh=HhPffXtdJ2wvX856F2nN+bffDZrS3Rfd44/UvguDk4s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P13ketkofhpEyEuE2bDW+6WJBZctsvPg3zfIEfChD/fQRCNoT2wZh0gScAPmXJirEKOcOtE6UlfMg6eO2B//cLDvXgihB5Vf5vfIhVLY8dbyrObRBKTSH2qZ7R+04tOCifecmSQesn/tdadaKEIHvRLlHBKX7tMjY7skIgJAHTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rbEWBWmd; arc=none smtp.client-ip=74.125.225.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rbEWBWmd"
Received: by mail-wr2-f1.google.com with SMTP id ffacd0b85a97d-473b8c0fd5aso677687f8f.1
        for <bpf@vger.kernel.org>; Mon, 03 Aug 2026 05:51:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785761482; x=1786366282; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aCfM/1K/mK7GsZmN553wbcNAXciJxpe5+AwVGcRHGMg=;
        b=rbEWBWmdfbftG4wltN9I8sCnb/WS4wB+M+iWAXYAwxhXTgYpRH6bRCXaiEXuqF4mQz
         bNtrcwz3ATynNvPSsThAk+32oaOlZ/J3PFzR0Y5drAgAwoiEpsapLhCb8YQ9kviXqFWe
         H1ybZwOqeWMGCnKN9NtP15dKOJVgM3yuVhRZkAWI38XgHhBTe0GymBBrE/fKtBXGD951
         RVitAGdB4TYe2k6AvvnpNNQeESFABELckOIWqtgVuUDaw0zaFwmWw8NZgOGIZ//n7FPO
         bjFBuZ2obN9iCR8jjQ35JVNsbOcFlUvarTH9P6Bv1unJC3Iq+wTzc8TjsWUmG3DHsDzN
         D7LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785761482; x=1786366282;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=aCfM/1K/mK7GsZmN553wbcNAXciJxpe5+AwVGcRHGMg=;
        b=ggq0OSoFRzfjw3CZlnTw9Z7BHL872U7z5HbakrR9X+OUDcged+/JgSVBlNz3yc7MT4
         iTFJpCvghQpVG8s57nkZKHzu2RjGnKIjbT0YHIRkzCdbMevJO7vB4Ie4uo9NHuPkN7RQ
         Fe4urB8WFPZIqSA9NRmSoFn8z2BdxyEYwbNoY4jr92JPr3uFXQVZm9Hg6WnDAR+X8cJI
         Bsc5lMIvoGCNI3IyQC/7gdObvCS17vpiStJTHyw4hGumBNCbl3snIxXISdVhfmoS1DxU
         V4fpsrENw956SlfnO+DjtLb5wHCDQFuqpSjsAzpLSKRnhM1e3SQCR0IzY2wR55UQv7qV
         GTpQ==
X-Gm-Message-State: AOJu0YzvZe12nyWjlW4mcGeLgu/mj0/+mDkkpnQPuUnRUSSsUu8P9IMs
	0J4wpixOwLyyFI+nBxl5KjbMrr33ZRyhCz18/amPg4ROq0zcD6o7Cdrg5Hl4Utow
X-Gm-Gg: AR+sD13bOtKVq/4/B4kYcByQ869rdf+Ea66vtQ1mYA0mStnpAEiKatPXAfOqAbvmqQ5
	AbKLryPBApY51qwC+cZNHKRF4bQExB1B5l6fuDOM0UfVa0HAQhvvHfO3IAtHQHRSHFR2Nb3Vj38
	FP3plimVw1ujZA9bBU6KzEGdiR1SEeTHNWsQdrDDQ/9uJQaEgKVoVhhMx8brSJOX99ft3GoMXDc
	JLJEwsOurtgfRGN/egMYFJAwKFKlHckSlcdxJqcIWU2zZvQWFkizvSYqrlUoB48wLZ9akM0BjCM
	ue0uD0YOOJbmysFn/ieU6rqFIvweDuXDG5QSL+65HDFdbG7Wyf40pguIhw/Q9Z38XQIB0VWRdu9
	8sTAnEg2J6Tj9YC21hunm9FuBXmO2eg+IacRe8VJoZk+BW5CBwHCrw5gwcqrfONjEbH3am5rkcc
	OQg8+PFBns0WeBZA8TchserFwiUGfjezJIs0BERcVeDvQtmUYFq7cyqTWABJNV4c2DtT1HyejSf
	XlguU+oJN9dcniIwGMKXyiIN5u4JtZ4R2gRX+er2Bo8+yU0Y0CQCAIhSbzQOmxXIUxMVob6A9AO
	B0/0tljEys0U+bP8drNLZlewxn0=
X-Received: by 2002:a05:6000:230e:b0:47f:2de3:b351 with SMTP id ffacd0b85a97d-47fd72d2fc7mr23229258f8f.26.1785761481957;
        Mon, 03 Aug 2026 05:51:21 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fd4562a38sm32409858f8f.21.2026.08.03.05.51.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 05:51:21 -0700 (PDT)
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
Subject: [PATCH bpf-next v3 5/9] selftests/bpf: Add kfunc __arena and __arena_nullable argument tests
Date: Mon,  3 Aug 2026 14:51:06 +0200
Message-ID: <20260803125115.2264733-6-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260803125115.2264733-1-memxor@gmail.com>
References: <20260803125115.2264733-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=12461; i=memxor@gmail.com; h=from:subject; bh=W26iBrlQJp16O0vfqwy5cnxpJV02I1sXmJUMbEaYQ8k=; b=kA0DAAoWRy03e2NUL4MByyZiAGpwjrPIR3OyReFoZ6Nzko369ufV9ElsoRLjONNHEWFyv78YJ 4h1BAAWCgAdFiEEdP++AjPIeftRPaYLRy03e2NUL4MFAmpwjrMACgkQRy03e2NUL4PsjQEAz2JW fvFL6mtZn+r8GAzM1lQsWu452G+9pbjEs+o0HAcA/3WRessdhGifQ6GmishpjDOXQsAeEiVI2Ke 0SNcSCp0M
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
index eb0f9b5e18d8..f4cd1ad254a5 100644
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

