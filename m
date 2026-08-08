Received: from mail-oo2-f8.google.com (mail-oo2-f8.google.com [74.125.231.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F2BB223DE7
	for <bpf@vger.kernel.org>; Sat,  8 Aug 2026 00:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786149610; cv=none; b=e0Q21Yxmm1F7tWtZMSliKjalaWVf4BumZuLFuFrf6QMuN/AVoVGVPudPaDfkGe6M/UYhITcBmU9DC8Lf7PULiJavX7CaZEOOJpX4/5E2Ky8o13zyfp7mgbt3tMa3vL3xpboASnEIcLyxNKz1CK+Yly3yoXokaRtCph/5ear4oyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786149610; c=relaxed/simple;
	bh=PGkQyuyDWJ5m0S3LML9d6UKluiJsSnl6BAkzVyhVcNo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gTSynwUohfvqIdWJ6u0jqYeQZDTqGRwo3o+S79qrUdleuXeUE8BmnzBSXBsJNaZM1H6noeQwONdL+4aY9zd76qqX8BxpIHibHELdXYzaaRArDyy8dkzegb0YXnqG2/rGVvX7SbIuJ4QKwgbZrdhTh2fCCAL5ePnR+f9XmZE2Te4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f9Tzb5mz; arc=none smtp.client-ip=74.125.231.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f9Tzb5mz"
Received: by mail-oo2-f8.google.com with SMTP id 006d021491bc7-6acbe402385so27760eaf.0
        for <bpf@vger.kernel.org>; Fri, 07 Aug 2026 17:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786149607; x=1786754407; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dz2XVCQMPBVCMGBR8jM6szsH/nooTb7JCHlCO+Xk7a8=;
        b=f9Tzb5mzFdcqK4XcpvxKkXHQT0QS2EhUeLA6GRTGDxOYukmGZk+YWo5rIoK90KOntN
         ItwNma9EqSF8KowYwLlzLpVz2L5KKRuPrf4sN+tP2IEpWa/74Bz1SQ7Z4GZ/dSogMkbk
         x9jVohpzySBsTwYpyAEwNTnTLuSBDqxeE2UHf6BgN/T+U7k6dbuAH71aBhmpNwxc5fcJ
         TGVUZKMXzrA33MPnDdttAHd6VVfahRYiBv6qQi+ZJb9claWzKdg32Zk0Tx8JGIO1aR9q
         cygue4l7gDN6BPGz56DPkEndaenneBqiZOzU8cxHN7dcpEJ92eRSsy4kwInJs/xwovW5
         XFQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786149607; x=1786754407;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=dz2XVCQMPBVCMGBR8jM6szsH/nooTb7JCHlCO+Xk7a8=;
        b=jIHUv611Bg0gquVvy6VPtx9zSHxfJs5qfbHbgHUUJo6j2fcVzrPrma+a5C6gh5ULOZ
         Wk7X/X13LUJa941FVPweYJgkNVtWUzy88mCQbM3S6uGMrQHU/KGSv4Y/kxUZU8dq5qt4
         jBFmL7SW3YAz3LrhGQTJb8n3Hn1vASIwC1SkpdIATzXNHkWhJ0GYYr6R1as1ixd5oqWv
         g6KQepUIvlebm7votOwSw/AY/spOAR6lzdzF776s4urX6HgTAecxk32pZbtlBNPaGELA
         1ck/ngMdmeHHC2GRHz3PQeU8GCU0QDnGCaOTF5PSg0MXZgBl99lPU28uF5/Um8CoiMey
         yDzg==
X-Gm-Message-State: AOJu0YwPji0wlSuZym+Hhk6hhOGyQssJ1/pKhU6CeuCfcb/50NRW+6a3
	5SHzIAQwlzQ4mzLHI7Tc/SgUYtZGf1rjnnrqseRCZb2UePeOT/hrlFEtKmU6t68sDFI=
X-Gm-Gg: AR+sD11nBcHpRausrIVOwqGtW/r+K8lQunBsWWa+zBvZ61fu0pZH5iHSs/xzfmhbLaa
	LmnbZqZgpv7cTT3jbwoS/HXEbZbm2/M2WMLKTjsH8ky6qVGiV80j5gxV2LRernfBiHmKOJ04Feo
	LKuxN18pFHdQ6XNaGoyVfEyquwqBfnYA8OoQTzrVQ+CaRhVIsoLzEr3rvX/DrsxjXw0B69Ijtv4
	AIgCp8uQ7IJL3dQPp0wp9te+YGPH1+Pf0ZgkJUL7q+yfucEhB4IrTdn5P5ClYVMc2riwwytGwzq
	8wwjm/KwbbesDOQ2LJGz9djHeTTUPWNAhtQMs+2Rk1Y2kz9js1CnICpCQOxBQsf1iwKkuFycYYN
	q0cGV7LVWNJRljdqwlYdWomtRw7H7h/QmQPCxLsQmCdOlKPVeQqYtJsOcJGlIHp38tKBbCOMVrI
	ohs0g0deQXG2XdDzsjm0qIbjtuNT+NXYE8fEL7jremIASHd/xiy3nnJV+PyPrqAWw7V0WccIpvS
	1WS4l7jPC7t5a2E2UjFE+YJIngJk7FAK3m4WIe/C1lm+++J2kZZzQHX6T1dSRGxsNd6ZL8=
X-Received: by 2002:a05:6820:4481:b0:6b0:4170:59ae with SMTP id 006d021491bc7-6b041706e40mr2103190eaf.27.1786149607328;
        Fri, 07 Aug 2026 17:40:07 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:4d::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-459f1a76701sm3065049fac.5.2026.08.07.17.40.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 17:40:05 -0700 (PDT)
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
Subject: [PATCH bpf-next v5 10/14] selftests/bpf: Add struct_ops __arena and __arena__nullable argument tests
Date: Sat,  8 Aug 2026 02:39:30 +0200
Message-ID: <20260808003938.3486067-11-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260808003938.3486067-1-memxor@gmail.com>
References: <20260808003938.3486067-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=10607; i=memxor@gmail.com; h=from:subject; bh=3HuKAr9AOkSJ/HqrbduFoOvFyMTg7fWxSFQeHWuSSFI=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIausqtLLWXQrk+pjF13LMqWHDCyqKnyzhHdodH3//tqpw2Xe gY8dpSwMYlwMsmKKLCX/9zEZn6j8HWi7jBtmDisTyBAGLk4BmEjFX4b/9WdXeHne3S6U4TBzwyHJyH 3ZorNOnnOuPOs0MbHSeedKC4Z/Ks1hf8p2PZFd/Vx9icFFDdOZNewrPi/b+P6v8wv3x5N5uQA=
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
index 2291bb466517..1e6d632c6f83 100644
--- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
@@ -385,9 +385,21 @@ static int bpf_testmod_test_4(void)
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
@@ -406,6 +418,16 @@ __bpf_kfunc void bpf_testmod_ops3_call_test_2(void)
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
@@ -814,6 +836,8 @@ BTF_ID_FLAGS(func, bpf_testmod_ctx_create, KF_ACQUIRE | KF_RET_NULL)
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
index 453bfd94154f..ea1747e2ad1f 100644
--- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h
@@ -120,6 +120,8 @@ u32 bpf_kfunc_call_test_static_unused_arg(u32 arg, u32 unused) __ksym;
 #endif
 
 void bpf_testmod_test_mod_kfunc(int i) __ksym;
+int bpf_testmod_ops3_call_test_arena(__u64 *ptr__arena) __ksym;
+int bpf_testmod_ops3_call_test_arena_nullable(__u64 *ptr__arena__nullable) __ksym;
 
 __u64 bpf_kfunc_call_test1(struct sock *sk, __u32 a, __u64 b,
 				__u32 c, __u64 d) __ksym;
-- 
2.53.0-Meta

