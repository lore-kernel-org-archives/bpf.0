Received: from mail-wm2-f7.google.com (mail-wm2-f7.google.com [74.125.225.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 481BF3EEAF8
	for <bpf@vger.kernel.org>; Wed,  5 Aug 2026 21:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785963883; cv=none; b=rz6fH/BqIp53fJ9Uo31Dy/YiqajtZTKW/euv6Q/WBpXgLlDEE95jM92X7s7hquOnzbWz3c9xWpbnfRvX/7wkIt5zVd2xrnPyQGhEotKWoXebzCHAHpmNLH/7eZhxjjzbb/349xL2s2EKGp2s4x6Q5Iieg8I4Mxhtm3e3H8A8nyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785963883; c=relaxed/simple;
	bh=7qluDoInJ6+xo4pkwEF1EqnSBrPxTRXkN9BqR6STNd8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kjyb3uqBR12ydEmxQa41Kp2tZpftzqEywMgL+ASHGtziNY/cGmLRUeaIK1xSt7KZWjzYgbTTEkWhSALp1F/KIb6w4Otoj5ygAARrss076KBcxFXoo4HcypJeApc2faA3H/aJoZ5mxEJZq53Kwa4/88TS7FXIgLsKBsH1UWFD0Bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fHqbg7G6; arc=none smtp.client-ip=74.125.225.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fHqbg7G6"
Received: by mail-wm2-f7.google.com with SMTP id 5b1f17b1804b1-49557073245so4649455e9.1
        for <bpf@vger.kernel.org>; Wed, 05 Aug 2026 14:04:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785963879; x=1786568679; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XGNZN9kH+O4lA2Xxci7QW/2SYWaagscP4SlU5yKoV08=;
        b=fHqbg7G6m2gqGdYKTgIkcSqxymLGWcU+tfwnF2KeGZDf7JKBlg1eOWzRg9rrREbiJ3
         PFTsRPQcfPO7R1Vnl4sFPKS4L+2pvfqQmbg1AnWu+84WHBPkMCua3Tcv2Xz3QjZ/d/Oc
         ibTaiP3qGq/PLJa9gm5lwt9suuBIXGaLMJXEI5GUTGYHcBILwK2yNCe9cX+HMsmRYN3i
         SCTM95XYx7PSF657slEmPA6EwVYSmlDC9FJ3+Nxk+lZQg/dToaUJGVMreZacZ9gUozxu
         lWCEg48MssJP06WJdo3c3FRJK9zWbIiDLcYAGLvzZO1+fu64HDht29T0BifPvypYW1hL
         kiZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785963879; x=1786568679;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=XGNZN9kH+O4lA2Xxci7QW/2SYWaagscP4SlU5yKoV08=;
        b=sT4kW2dCyIrP1BIwT1LTcCiqhgVbl+xSQ6HTJJs9Mtnm4YOP5Wxiu5jnWc8Xssy3Wk
         dvQpeJMefFcqYd/Htse7CX0GgVNOXxcjpndxKic8yN66vXrzuBhJxIgc61viOrgVYVF7
         ybTFAJUV50V3qNbuxwBCaoHOjNVhWCFjFhsIfQDJorzqtkdEhJv/K/gTFyvWql3dEdvh
         J+dRFBleHyxjPBiYCTSt/d6Wk7vjv1PMb9KCFPyv9VwWhPX+S1l98Cb/RV5W1Oi9I2VD
         ArRh2fglLUB3sOKHbVNYawJqPkBTifVq4o61fdRiAmatonI2TWkTfoi9Qxb4cvMm5uJg
         0MqQ==
X-Gm-Message-State: AOJu0YweMY9xdTqSWuv1uGWRJ1vQU1iYGmRPZQn9OmEAj509j9s6XmjI
	km3mHKZ2ibyEgYjOt5hZWkEuFsZ+T5sjZYuop9RAbdcNLPFZU3MQ5mWc07wikOVR
X-Gm-Gg: AR+sD12MCEe8oMC50/86w0ZPjkdczluyP29f8u0ik/2hEQo5Tp+fqauSeehzGh8b+mw
	eBH1J/ndOju2d43qo8XOJvep/AnLnUK+UxgIDVdoVqe5Ip2cCfEc6MPuu8D4Kw8LK1DTwxT7J+M
	WDxeG4kKns8/jBDMgSo+20bbi9YkEJVFOAwTlYDF8a5kiWb9yBELGaq3Ay3+/TGbT7dajnBhvww
	0e94i7uL+KIm/jB5sbkTToAwgkrfdCCcARPECFCX24IgeUqgWmbgCGFd+CqEJq2tQHfYkCTRagk
	h0xhhBE3zirFKlBZNiv0dLVgBLiR8TX2FYC5UMa8gaqxwNDjyGDrNyJDbMAcIcNK0Q8GWxdO1sc
	mtdwSpLj46Ki5dOEN3NUcSemxSwEhLDfD70oAefYJ55bZGwpOgxJzVQ2tm/pM7YxL7TK5dgoz8Y
	33lY1fK1pEsSflcXzKNTLOHfhpm3TvyX1A6WQaLTRDkgde/M6kzPYCph8ES6QdaG3AHTV+U1pb/
	+Ft51R192MYqS4VruHkwE2sgriB3wc79v6V+31SxLYFSX41ocyaqNOQ1/a2exlr/piyrGwJ38o/
	OR/tGJqkoNxFLf2ZNBO+WhmI7s0=
X-Received: by 2002:a05:600c:6a8a:b0:498:ee7:e407 with SMTP id 5b1f17b1804b1-4994e7d3f2fmr108200245e9.17.1785963879501;
        Wed, 05 Aug 2026 14:04:39 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4994e980559sm75343255e9.2.2026.08.05.14.04.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 14:04:38 -0700 (PDT)
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
Subject: [PATCH bpf-next v4 10/13] selftests/bpf: Add struct_ops __arena and __arena__nullable argument tests
Date: Wed,  5 Aug 2026 23:04:21 +0200
Message-ID: <20260805210427.3218326-11-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260805210427.3218326-1-memxor@gmail.com>
References: <20260805210427.3218326-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=10602; i=memxor@gmail.com; h=from:subject; bh=ioU9l4/qVts/D8kUuShK3Utu1+BSrwYFS/ZuNatIRV4=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIat40VSV7xLPZhtl/SmQ3r2/p3Fv2SvXvsPfrlnafFuxv oHRSEe8o5SFQYyLQVZMkaXk/z4m4xOVvwNtl3HDzGFlAhnCwMUpABNZdZ/hn733hWO3Y42ZF8de Vq+uOdwo/9ruvJVv4j6rSXPWHPu6gpuR4RHLz9SMiW07P1zyPuVeqKgiF3l2X8DL48zrRDr0HhU tZQcA
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

From: Tejun Heo <tj@kernel.org>

Add test_arena and test_arena_nullable members to bpf_testmod_ops3 with
arena-tagged stub arguments and kfuncs that forward a caller-provided
pointer to them. The kfuncs take arena-tagged arguments, so each round
trip exercises both conversion directions end to end: the kfunc receives
a kernel arena address and the trampoline converts it back to an arena
pointer for the callback.

The non-nullable callback dereferences its argument with no NULL branch
and captures the raw ctx value, which the trigger program compares
against the arena offset of the passed object, pinning the exact
(u32)(kaddr - kern_vm_start) conversion. The nullable callback verifies
that only a true kernel NULL arrives as NULL. Failure coverage: a
program with no arena is rejected when it loads. The tests run on x86-64
and skip elsewhere, as the programs fail verification where the JIT
lacks arena argument support.

Signed-off-by: Tejun Heo <tj@kernel.org>
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../bpf/prog_tests/test_struct_ops_arena.c    | 74 +++++++++++++++
 .../selftests/bpf/progs/struct_ops_arena.c    | 94 +++++++++++++++++++
 .../bpf/progs/struct_ops_arena_fail.c         | 20 ++++
 .../selftests/bpf/test_kmods/bpf_testmod.c    | 24 +++++
 .../selftests/bpf/test_kmods/bpf_testmod.h    |  3 +
 .../bpf/test_kmods/bpf_testmod_kfunc.h        |  2 +
 6 files changed, 217 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/test_struct_ops_arena.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_arena.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_arena_fail.c

diff --git a/tools/testing/selftests/bpf/prog_tests/test_struct_ops_arena.c b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_arena.c
new file mode 100644
index 000000000000..323d707c543f
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_arena.c
@@ -0,0 +1,74 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
+#include <test_progs.h>
+
+#include "struct_ops_arena.skel.h"
+#include "struct_ops_arena_fail.skel.h"
+
+#if defined(__x86_64__)
+/*
+ * Attach callbacks with __arena and __arena__nullable arguments and drive
+ * them through the bpf_testmod_ops3_call_test_arena*() kfuncs.
+ */
+static void arena_arg(void)
+{
+	LIBBPF_OPTS(bpf_test_run_opts, topts);
+	struct struct_ops_arena *skel;
+	struct bpf_link *link = NULL;
+	int err;
+
+	skel = struct_ops_arena__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "struct_ops_arena__open_and_load"))
+		return;
+
+	link = bpf_map__attach_struct_ops(skel->maps.testmod_arena);
+	if (!ASSERT_OK_PTR(link, "attach_struct_ops"))
+		goto out;
+
+	err = bpf_prog_test_run_opts(bpf_program__fd(skel->progs.trigger),
+				     &topts);
+	ASSERT_OK(err, "test_run");
+	ASSERT_EQ(topts.retval, 0, "trigger_retval");
+
+out:
+	bpf_link__destroy(link);
+	struct_ops_arena__destroy(skel);
+}
+
+/*
+ * A program with no arena cannot attach to a member with an __arena
+ * argument.
+ */
+static void arena_arg_fail(void)
+{
+	struct struct_ops_arena_fail *skel;
+
+	skel = struct_ops_arena_fail__open_and_load();
+	if (ASSERT_ERR_PTR(skel, "struct_ops_arena_fail__open_and_load"))
+		return;
+
+	struct_ops_arena_fail__destroy(skel);
+}
+#endif
+
+/*
+ * Serialized because it attaches the singleton bpf_testmod_ops3, which
+ * test_struct_ops_private_stack also attaches; registering it twice fails
+ * with -EEXIST.
+ */
+void serial_test_struct_ops_arena(void)
+{
+	/*
+	 * Arena struct_ops arguments need JIT support, currently x86-64 only.
+	 * Elsewhere verification fails with "JIT does not support arena
+	 * arguments", so the programs cannot even load.
+	 */
+#if defined(__x86_64__)
+	if (test__start_subtest("arena_arg"))
+		arena_arg();
+	if (test__start_subtest("arena_arg_fail"))
+		arena_arg_fail();
+#else
+	test__skip();
+#endif
+}
diff --git a/tools/testing/selftests/bpf/progs/struct_ops_arena.c b/tools/testing/selftests/bpf/progs/struct_ops_arena.c
new file mode 100644
index 000000000000..40c856a748d2
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/struct_ops_arena.c
@@ -0,0 +1,94 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
+
+#define BPF_NO_KFUNC_PROTOTYPES
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_experimental.h"
+#include <bpf_arena_common.h>
+#include "../test_kmods/bpf_testmod.h"
+#include "../test_kmods/bpf_testmod_kfunc.h"
+
+char _license[] SEC("license") = "GPL";
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARENA);
+	__uint(map_flags, BPF_F_MMAPABLE);
+	/* page 0 hosts the arena globals, page 1 is for allocations */
+	__uint(max_entries, 2);
+} arena SEC(".maps");
+
+/* also associates the callbacks with the arena */
+u64 __arena arena_touch;
+/* raw value of the last __arena ctx argument, captured by test_arena_cb */
+u64 __arena cb_ptr_val;
+
+SEC("struct_ops/test_arena")
+int test_arena_cb(unsigned long long *ctx)
+{
+	u64 __arena *ptr = (u64 __arena *)ctx[0];
+
+	arena_touch++;
+	cb_ptr_val = ctx[0];
+	*ptr += 1;
+	return 0;
+}
+
+SEC("struct_ops/test_arena_nullable")
+int test_arena_nullable_cb(unsigned long long *ctx)
+{
+	u64 __arena *ptr = (u64 __arena *)ctx[0];
+
+	arena_touch++;
+	if (!ptr)
+		return 0xbee;
+	*ptr += 1;
+	return 0;
+}
+
+SEC(".struct_ops.link")
+struct bpf_testmod_ops3 testmod_arena = {
+	.test_arena = (void *)test_arena_cb,
+	.test_arena_nullable = (void *)test_arena_nullable_cb,
+};
+
+SEC("syscall")
+int trigger(void *ctx)
+{
+#if defined(__BPF_FEATURE_ADDR_SPACE_CAST)
+	u64 __arena *val;
+	int ret;
+
+	val = bpf_arena_alloc_pages(&arena, NULL, 1, NUMA_NO_NODE, 0);
+	if (!val)
+		return 1;
+
+	*val = 41;
+	ret = bpf_testmod_ops3_call_test_arena((u64 *)val);
+	if (ret)
+		return 2;
+	if (*val != 42)
+		return 3;
+
+	/*
+	 * The callback must have seen exactly (u32)(kaddr - kern_vm_start),
+	 * which is the arena offset of val with the upper 32 bits clear.
+	 */
+	if (cb_ptr_val != (u32)(u64)val)
+		return 4;
+
+	ret = bpf_testmod_ops3_call_test_arena_nullable((u64 *)val);
+	if (ret)
+		return 5;
+	if (*val != 43)
+		return 6;
+
+	/* NULL survives the nullable kfunc and the trampoline as NULL */
+	ret = bpf_testmod_ops3_call_test_arena_nullable(NULL);
+	if (ret != 0xbee)
+		return 7;
+
+	bpf_arena_free_pages(&arena, (void __arena *)val, 1);
+#endif
+	return 0;
+}
diff --git a/tools/testing/selftests/bpf/progs/struct_ops_arena_fail.c b/tools/testing/selftests/bpf/progs/struct_ops_arena_fail.c
new file mode 100644
index 000000000000..1c0ec727d637
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/struct_ops_arena_fail.c
@@ -0,0 +1,20 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
+
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include "../test_kmods/bpf_testmod.h"
+
+char _license[] SEC("license") = "GPL";
+
+/* No arena in the program: attaching to test_arena must be rejected. */
+SEC("struct_ops/test_arena")
+int test_arena_no_arena(unsigned long long *ctx)
+{
+	return 0;
+}
+
+SEC(".struct_ops.link")
+struct bpf_testmod_ops3 testmod_arena_fail = {
+	.test_arena = (void *)test_arena_no_arena,
+};
diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
index b92ac1e5df1d..64ca43744c59 100644
--- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
@@ -397,9 +397,21 @@ static int bpf_testmod_test_4(void)
 	return 0;
 }
 
+static int bpf_testmod_ops3__test_arena(u64 *ptr__arena)
+{
+	return 0;
+}
+
+static int bpf_testmod_ops3__test_arena_nullable(u64 *ptr__arena__nullable)
+{
+	return 0;
+}
+
 static struct bpf_testmod_ops3 __bpf_testmod_ops3 = {
 	.test_1 = bpf_testmod_test_3,
 	.test_2 = bpf_testmod_test_4,
+	.test_arena = bpf_testmod_ops3__test_arena,
+	.test_arena_nullable = bpf_testmod_ops3__test_arena_nullable,
 };
 
 static void bpf_testmod_test_struct_ops3(void)
@@ -418,6 +430,16 @@ __bpf_kfunc void bpf_testmod_ops3_call_test_2(void)
 	st_ops3->test_2();
 }
 
+__bpf_kfunc int bpf_testmod_ops3_call_test_arena(u64 *ptr__arena)
+{
+	return st_ops3->test_arena(ptr__arena);
+}
+
+__bpf_kfunc int bpf_testmod_ops3_call_test_arena_nullable(u64 *ptr__arena__nullable)
+{
+	return st_ops3->test_arena_nullable(ptr__arena__nullable);
+}
+
 struct bpf_testmod_btf_type_tag_1 {
 	int a;
 };
@@ -827,6 +849,8 @@ BTF_ID_FLAGS(func, bpf_testmod_ctx_create, KF_ACQUIRE | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_testmod_ctx_release, KF_RELEASE)
 BTF_ID_FLAGS(func, bpf_testmod_ops3_call_test_1)
 BTF_ID_FLAGS(func, bpf_testmod_ops3_call_test_2)
+BTF_ID_FLAGS(func, bpf_testmod_ops3_call_test_arena)
+BTF_ID_FLAGS(func, bpf_testmod_ops3_call_test_arena_nullable)
 BTF_ID_FLAGS(func, bpf_kfunc_get_default_trusted_ptr_test);
 BTF_ID_FLAGS(func, bpf_kfunc_put_default_trusted_ptr_test);
 BTF_KFUNCS_END(bpf_testmod_common_kfunc_ids)
diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.h b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.h
index 863fd10f1619..c367ec856776 100644
--- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.h
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.h
@@ -106,6 +106,9 @@ struct bpf_testmod_ops2 {
 struct bpf_testmod_ops3 {
 	int (*test_1)(void);
 	int (*test_2)(void);
+	/* Used to test arena pointer arguments. */
+	int (*test_arena)(u64 *ptr);
+	int (*test_arena_nullable)(u64 *ptr);
 };
 
 struct st_ops_args {
diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h b/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h
index 3317436b03a3..a5b6b5db0dd5 100644
--- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h
@@ -121,6 +121,8 @@ u32 bpf_kfunc_call_test_static_unused_arg(u32 arg, u32 unused) __ksym;
 #endif
 
 void bpf_testmod_test_mod_kfunc(int i) __ksym;
+int bpf_testmod_ops3_call_test_arena(__u64 *ptr__arena) __ksym;
+int bpf_testmod_ops3_call_test_arena_nullable(__u64 *ptr__arena__nullable) __ksym;
 
 __u64 bpf_kfunc_call_test1(struct sock *sk, __u32 a, __u64 b,
 				__u32 c, __u64 d) __ksym;
-- 
2.53.0

