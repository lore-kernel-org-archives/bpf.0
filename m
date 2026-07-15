Received: from mail-wm2-f1.google.com (mail-wm2-f1.google.com [74.125.225.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D48DC3C09EF
	for <bpf@vger.kernel.org>; Wed, 15 Jul 2026 22:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784152865; cv=none; b=hntu24A8wUEVU+jRw0gXzNO9sCdxLDqrDbrTo1pNSuw2SaAUpibmNjqxtVq5UT1IOZmW1mruLTeKj14dvYW29X/0uatEFyZTN4id2+1kqfcUDi0O2yahiR6J3RbWT+N8GncPhmNFygetHpGtA2vQPdUFqkPqbdCzfr65/Yz93qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784152865; c=relaxed/simple;
	bh=lkvNzLS83JVBxQELw+YDPVvVIWT9bNm+UUjHQvqSYSQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D0v/6OkE8wZo/cl6MG/o81a4Xw2a+cXOwyz6SorOUVH38kPvKuZb2tFNDD5c1rNdliQ2yWnYI0d5vhMTUuUwzvyA1r56h+blHu7UtaQ3vkBOY4B9+nGERtpl4hjNZL72ICVSg5BCkoeRaJzVJXmrVYAHxlfifkJpR3EpMKf/zJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G8WfuYqX; arc=none smtp.client-ip=74.125.225.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G8WfuYqX"
Received: by mail-wm2-f1.google.com with SMTP id 5b1f17b1804b1-493b7dd83e8so6001585e9.1
        for <bpf@vger.kernel.org>; Wed, 15 Jul 2026 15:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784152862; x=1784757662; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OMvnid6WlD1luACt8W/mNqTDXICfXxrpBmuWc7r/sLk=;
        b=G8WfuYqXd8pzy8Pg93Yl+FEkjmyZPMdT2Uk9jGhTDdW1bzIlj/d3EzW/Jbn2vDuAQW
         Ak1Fgva/1hZGUuOwEaQ40BCLSzRgJcSn+/2E/ReGmnadTdElseOz+md3iTTKkTKtw+Wy
         6rKXyIS/hgZV7NjRbix0ZDq+41XI+YVKo+yxGQKimwL3rXmGBSKXViAHTBfF6nfRIUTV
         CrVKQ5m0B3WnfkQ08NPDp/RvS3JYCn4gVMP7WA+cJS0nSzl4ca9TpaRd84cPVOx6lSNt
         v5vCJkpo1bqp1kNJbFRLrY7y+MSK8znIfOOaMvgohpp1t/V381qfIZjMoj5x9elT16Ux
         egcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784152862; x=1784757662;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=OMvnid6WlD1luACt8W/mNqTDXICfXxrpBmuWc7r/sLk=;
        b=Xl3xdemlO5IS+qP9f55uxO8gw3IWNh5Wr1MuFPsjLj1j40m/4nGAO1wnr+YJd0dmvT
         +K7H2InieXNJX1WsguV+PEp/qseNNR9iGjB+t+sASta9NTVq58lcHU2Bi7E9ajGsibIZ
         Rvk09YjE0ofuIUMYlMSt/cOdy+rVCVMpvyTWmHqFVKDU+gfLkat7icIJs/oUMbGn0Yjg
         FcQzp+YaCADr+T/nG1Oml073xfCSTJMmasRUnUDkXw8T/d98mALUvf+oSHr8ODQXT2dm
         jGj0lW4UuIAELNz5WgzP5q+CA120wZbV+QIvGEFwNUPIdOgXQezZrL//uAYoUI9RAbfW
         zUrw==
X-Gm-Message-State: AOJu0YxmyZQnO3DfHJfkVKYmk4AZ6GRcUYlLGkdFOt+WcsuI74QZKrYT
	yGcUi+eB3GIis75gKiS7ObcJAjxh3zeXKsbo5YXhnxHdurf+VsD8xVxV+IkdjfAI
X-Gm-Gg: AfdE7cndklLqttMePQ1Zc+L5yCuLQ8J0yW+HbBpcPQkNV3DHQvUY6dXgdQl+B8qxTo+
	g3912JkhMYVbCZpzrXvqT/vBwsZHayPZP/ioIbtroYYqbSz6GOhh0acoh3fCJ2zxxZafX1bn1WS
	W6zoH25Nj90PmN8SBenckit7QsCcMX4IYpljXcXqlLrHWk/l9ZwFy4OXgs0aOFfZIgBgcpL0yno
	1+x0bfv3tuvei36RnbQjRac/xsNg8mizpzrUS34RBIiDuomtqarjRprejrNtq3hrTS9dfrmVM3G
	y1u1KuejhmxyM8eTQN95gB0NbbgnwhiSkPxa9ccityEnntTAr5OkjT6vuGgGhV1m3O5o3+FXJoK
	C8aEId4xZuvwGaxLCw3WWrZPFNX+y1mfGe522w9yEbQuXHJjqu4aMKxf205IPbT2r3Pgcy3fbPz
	1FXMyQb6mltbZWRt3/dCaK9RUUPSL4EUU0gV3waJk9Hbq+eQU0pl68zeKXxzTDeEsyw46OQ9s7K
	Q524CSHCnYqb5hajnq/jZ1D2CoW38Du2OOlfF2uGZyE
X-Received: by 2002:a05:600c:4693:b0:493:a5d0:d1a1 with SMTP id 5b1f17b1804b1-493f882993fmr197737645e9.31.1784152861692;
        Wed, 15 Jul 2026 15:01:01 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4953c599049sm66346835e9.0.2026.07.15.15.01.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 15:01:01 -0700 (PDT)
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
Subject: [PATCH bpf-next v1 7/9] selftests/bpf: Add struct_ops __arena and __arena_nullable argument tests
Date: Thu, 16 Jul 2026 00:00:47 +0200
Message-ID: <20260715220052.1590783-8-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260715220052.1590783-1-memxor@gmail.com>
References: <20260715220052.1590783-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=10513; i=memxor@gmail.com; h=from:subject; bh=yobRw5rCCxme28KnV+IGFiGzByjuvIvvN5HmSqa9+p0=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JISuC6c79wqNsdxyTum+nbu7nLdj+wtrLMOhl6CUp0W5F/ X1nw9w7SlkYxLgYZMUUWUr+72MyPlH5O9B2GTfMHFYmkCEMXJwCMJFt1xn+R6rdVK5zWXN+mdQU ob8n/x6/IvHp2oa601n8QXGnVm6a/Ijhn8rxC4uO+blxnDo8RfdCbXPPvopoNYWSls3RTrc9b5w 2YwEA
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
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../bpf/prog_tests/test_struct_ops_arena.c    | 72 ++++++++++++++
 .../selftests/bpf/progs/struct_ops_arena.c    | 94 +++++++++++++++++++
 .../bpf/progs/struct_ops_arena_fail.c         | 20 ++++
 .../selftests/bpf/test_kmods/bpf_testmod.c    | 24 +++++
 .../selftests/bpf/test_kmods/bpf_testmod.h    |  3 +
 .../bpf/test_kmods/bpf_testmod_kfunc.h        |  2 +
 6 files changed, 215 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/test_struct_ops_arena.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_arena.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_arena_fail.c

diff --git a/tools/testing/selftests/bpf/prog_tests/test_struct_ops_arena.c b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_arena.c
new file mode 100644
index 000000000000..fbf1a29d9af6
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_arena.c
@@ -0,0 +1,72 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
+#include <test_progs.h>
+
+#include "struct_ops_arena.skel.h"
+#include "struct_ops_arena_fail.skel.h"
+
+/*
+ * Attach callbacks with __arena and __arena_nullable arguments and drive
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
index fad106b1549c..48ce36a6b82f 100644
--- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
@@ -370,9 +370,21 @@ static int bpf_testmod_test_4(void)
 	return 0;
 }
 
+static int bpf_testmod_ops3__test_arena(u64 *ptr__arena)
+{
+	return 0;
+}
+
+static int bpf_testmod_ops3__test_arena_nullable(u64 *ptr__arena_nullable)
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
@@ -391,6 +403,16 @@ __bpf_kfunc void bpf_testmod_ops3_call_test_2(void)
 	st_ops3->test_2();
 }
 
+__bpf_kfunc int bpf_testmod_ops3_call_test_arena(u64 *ptr__arena)
+{
+	return st_ops3->test_arena(ptr__arena);
+}
+
+__bpf_kfunc int bpf_testmod_ops3_call_test_arena_nullable(u64 *ptr__arena_nullable)
+{
+	return st_ops3->test_arena_nullable(ptr__arena_nullable);
+}
+
 struct bpf_testmod_btf_type_tag_1 {
 	int a;
 };
@@ -795,6 +817,8 @@ BTF_ID_FLAGS(func, bpf_testmod_ctx_create, KF_ACQUIRE | KF_RET_NULL)
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
index 42d3fccc6ff9..ff0d3894d7af 100644
--- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h
@@ -121,6 +121,8 @@ u32 bpf_kfunc_call_test_static_unused_arg(u32 arg, u32 unused) __ksym;
 #endif
 
 void bpf_testmod_test_mod_kfunc(int i) __ksym;
+int bpf_testmod_ops3_call_test_arena(__u64 *ptr__arena) __ksym;
+int bpf_testmod_ops3_call_test_arena_nullable(__u64 *ptr__arena_nullable) __ksym;
 
 __u64 bpf_kfunc_call_test1(struct sock *sk, __u32 a, __u64 b,
 				__u32 c, __u64 d) __ksym;
-- 
2.53.0

