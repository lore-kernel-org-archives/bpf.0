Received: from mail-wm2-f8.google.com (mail-wm2-f8.google.com [74.125.225.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E0EA35839E
	for <bpf@vger.kernel.org>; Mon,  3 Aug 2026 12:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785761488; cv=none; b=QWVRPjDlHL8Mc4cQ8Edfd09yBqmFbX3ARwll6bXHl+5k3fMbYvCLZ7dQMlWi0usIA/qV6AfMB90iNlRX5mXQTilo4ofLM4skj7P/DBhunk8TGs62yTO+MHTFKXBdeCooXzFKmB6DBHMu3y4Q68xX0QAq9DKG/MWWL09gx6OgSUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785761488; c=relaxed/simple;
	bh=pDSAqdwMW4wh7/O1aIRY+wvrxxqwOhyXhLfID8RMQRM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RfyTy2dYzEFBzYOZ1mtpCNqDfnT0WpSLhMTwPbH40coME7I022pvjAKjLNK5Y453WsbCjsJvsJWKxW0rZ3jQKp0OVFhndtClil0i0YNwvnuse/W0rYyAdy9SIoAbBjlPgmHC2xIJhFjUvC7ZDP6sDNxhBwXxhxe/S9IOXqwXMps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O3lJher7; arc=none smtp.client-ip=74.125.225.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O3lJher7"
Received: by mail-wm2-f8.google.com with SMTP id 5b1f17b1804b1-4956bc73c0eso10395805e9.1
        for <bpf@vger.kernel.org>; Mon, 03 Aug 2026 05:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785761485; x=1786366285; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rMCjt7qpnrVB2zMY0twBSbaJu693AoU+lato3jtJTyA=;
        b=O3lJher7ZBRYwGLbRLQzUSbdeDoH7uYnu1j2lGICHBsZ/gXcQYi7djSRYZaBAgC4kb
         qrsT/U0a3jKAel0mtA02d0Hy89+QzAxUetSHwc0KZD6v7CcUVhBNSHLdAHN5kKlUWeMU
         CXyIT5esniFa5HZ39VV0qkpEKKNKCYhNXkRDZB2eX2JvyiFryoWqU39X+vnnuzlRpwDi
         xpLV77WfaKMQhphxg6NY2SfbQsq50WUUPgPUOz25qH08JYzOA4yOpt1rU7ELheRHhWz9
         X/HW9FtjMz9WqZbgLWMb6yzAZpKxa1GOX9UclZ9CBEoxXUNTRmpC1EblHIGgouN+U/5+
         xH9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785761485; x=1786366285;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=rMCjt7qpnrVB2zMY0twBSbaJu693AoU+lato3jtJTyA=;
        b=PafIN6t5ctOPGa9YWfV9ElYs7HaDL2sYSBVZ4HYZ7/w+1KhYihavZ18dlSdJ24Z8gD
         22bik+BXXZLUZDzeghZTtMgyrJ/TbRW22ptE3So0ckVhyyiIio7ccdaM5Dw0oU0dMlfb
         FQGIpdzff+nCx9yVGgEv6Z7NL6d0pTTcKVxOmvgkindCoKtNga2VlOMdUSjdegoDQv8C
         b8IAl9mjkfIicErqyd+ABO/QKVnfGe4YP1gmga/ScyA4ks/U6wsEhxI83do5aE9K4p5u
         GHsPnLHfsGYvVSeehSDMUjysxeXOHLcWmWb0/fF+7VpAg/ivdyT7WCdeHKeSSVse+97L
         otpw==
X-Gm-Message-State: AOJu0YxaO0L9/89BO6UneH0t2FKYXLWX21tKvaeIqaBRxG0K4TQSTzXV
	9tZ96axdQqk8zZdNPTbKBqG6kjJaBYI8u1DEwXTy25VXyJLTybA3wRrONbkYK/fo
X-Gm-Gg: AR+sD13ZqzQZY+2fA8qFQagUEqakSjnOP7sxoh/zslo+L2aUCUXVHBBTQWRMKIjNUqJ
	HY5sj4afRiYklIS5yoknufOJg5PWkYYYDtTDEnYeYqDDoJ0wL4uWJd/bvxSvijyTV9glOH4fl2l
	YZcyEExunb6vbQyr2xD/hH94ODN2unskwcClT5uSLWVQyxTEmWVkX4CA8A0lE6tPuPi4F3lM9nL
	jYqWixe2eHsZZMIB8+Y7yEBmIcmjuFnqxhIuUdc7zpaIH7Igcg/XCks977qDBfws1LDq83qojce
	bdZu8QePrfMBxh7SW3XoBf53JDhHOIny2N+iLhQgQHDqsKlPMv1nmgNpMo+FRPI2znP6LOfMf4K
	lVl8J7+jx4TyaVgDeFKa6YdMwLMWW4HTx7T0vKETpdGEkr079IX3+fZLIiiKFQLagy+Vto+exRp
	UBFSMx6FslRWJnVCtSjbZOjbc0S8TMIkRNL5Cq+lNU+yG0P48DhfdsS3GMRuT4FgrthGusFsXrP
	O+4T/ymcAiaxFWFSTifdkiGFJmBoZ6WrnvJenelQ6thQOxUQaG1y7D48ZDoBiiYo2/1oUK9tVX5
	ICeTN1bC8wasGBYxm4WpO1bnF1k=
X-Received: by 2002:a05:600c:4445:b0:493:a438:7f98 with SMTP id 5b1f17b1804b1-4980c694df5mr183209125e9.18.1785761484625;
        Mon, 03 Aug 2026 05:51:24 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49807b5f007sm220849875e9.6.2026.08.03.05.51.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 05:51:24 -0700 (PDT)
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
Subject: [PATCH bpf-next v3 7/9] selftests/bpf: Add struct_ops __arena and __arena_nullable argument tests
Date: Mon,  3 Aug 2026 14:51:08 +0200
Message-ID: <20260803125115.2264733-8-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260803125115.2264733-1-memxor@gmail.com>
References: <20260803125115.2264733-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=11598; i=memxor@gmail.com; h=from:subject; bh=zg8fgfPAhO8yfZStEBUx1EcU5AbSCVIWjQkJuUQU+rk=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIaugb8s7pZPpemGl3r2c1QGfXMLXuz08uNFVy3HmyaRbp 5fPCjLtKGVhEONikBVTZCn5v4/J+ETl70DbZdwwc1iZQIYwcHEKwERUtRj+WUtqWDA/XRti+UJ/ 9T6/Eva+A4v3yPDN53jPaK6ySLS5H6ii++PXxfZbH4ZG8OxT25F1pjU/vHZVttrNxa48KSJx65k B
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
 .../bpf/prog_tests/test_struct_ops_arena.c    | 74 +++++++++++++++
 .../testing/selftests/bpf/progs/arena_kfunc.c | 14 ++-
 .../selftests/bpf/progs/struct_ops_arena.c    | 94 +++++++++++++++++++
 .../bpf/progs/struct_ops_arena_fail.c         | 20 ++++
 .../selftests/bpf/test_kmods/bpf_testmod.c    | 24 +++++
 .../selftests/bpf/test_kmods/bpf_testmod.h    |  3 +
 .../bpf/test_kmods/bpf_testmod_kfunc.h        |  2 +
 7 files changed, 229 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/test_struct_ops_arena.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_arena.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_arena_fail.c

diff --git a/tools/testing/selftests/bpf/prog_tests/test_struct_ops_arena.c b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_arena.c
new file mode 100644
index 000000000000..b1e39defa38a
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
diff --git a/tools/testing/selftests/bpf/progs/arena_kfunc.c b/tools/testing/selftests/bpf/progs/arena_kfunc.c
index e7250c5197ab..15d48151797d 100644
--- a/tools/testing/selftests/bpf/progs/arena_kfunc.c
+++ b/tools/testing/selftests/bpf/progs/arena_kfunc.c
@@ -235,16 +235,26 @@ int arena_arg_bad_reg(void *ctx)
 	return 0;
 }
 
+#if defined(__BPF_FEATURE_ADDR_SPACE_CAST) && \
+	defined(__BPF_FEATURE_STACK_ARGUMENT)
 SEC("syscall")
 __arch_x86_64
 __failure __msg("arena pointer cannot be a stack argument")
 int arena_arg_stack(void *ctx)
 {
-#if defined(__BPF_FEATURE_ADDR_SPACE_CAST)
 	bpf_arena_alloc_pages(&arena, NULL, 1, NUMA_NO_NODE, 0);
 	bpf_kfunc_arena_stack_arg_test(1, 2, 3, 4, 5, (u64 *)1);
-#endif
 	return 0;
 }
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
 
 char _license[] SEC("license") = "GPL";
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
index f4cd1ad254a5..396e5b467855 100644
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
@@ -418,6 +430,16 @@ __bpf_kfunc void bpf_testmod_ops3_call_test_2(void)
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

