Received: from mail-oo2-f2.google.com (mail-oo2-f2.google.com [74.125.231.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 092053A451B
	for <bpf@vger.kernel.org>; Tue, 13 Oct 2026 08:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791879640; cv=none; b=IHE/T/3O4lRR+Y9DWNe43/HZALaqsYqvFMoJlAHotZdWgyiG5EiBQCIrMpRjI6yoFNb0nz91Dl2Ht84pxA2LFtwNYvlTOlmqEUIvx4WdFjdpCJ5d2X22KZdxiw8kHaBfetbV6crWtcVKzWsBt7rOedCB3F2K6NG6GFT35RP6RO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791879640; c=relaxed/simple;
	bh=zzNynjMgJw7WB5ZcAw0omZV492o4fs3u/8AslgBnsSY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fu6XMWdSXQawkwz9Qv3+lxUefVM9p0dXxrkAKV6QakJoqL8mzWWABJcJvT8LyolbvZOZIpR2hY/lbufct8B36VlL1P0mnppWx3iiOyeekaUqaNivr1m01hSHzzRcVmJDvKc988IlGiAxudMcjslk3LBn7d1a9aXvFMTVg4t3rXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dazggAzO; arc=none smtp.client-ip=74.125.231.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dazggAzO"
Received: by mail-oo2-f2.google.com with SMTP id 46e09a7af769-824fdec5521so1937419a34.0
        for <bpf@vger.kernel.org>; Tue, 13 Oct 2026 01:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791879638; x=1792484438; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NdJGkjLRgcT7oKI8M+55+ilxnBhUejoXL5Bjpf4+VcY=;
        b=dazggAzO+7VI7XWksz8bNqJG+3ezPMARWg4NFLt0XJPzsxN+oTh05jqwXf8FIyzloV
         7kdA6A743094Sub1Jn1kTeU/maTWZmuN6rvLNFCKwUNvdkD+hlyXp3Zwc9bG3B1w0EeV
         u0wGGdKJ84d7+s0+SgTgggWtCEnDCXGUTLcA3HAzXzX6FrmKqOuIveUOcu+l2eD2qd4t
         a/fUNLSJk2zKrk+rA7Dg2rnGNw8u7ja7D9aWrkdFrpk3wO/qxpDyJ2mlG1b2Q6O0ayG8
         arCrxvD4u9HMWe9XXXC9keMr8h1pcyfQsWO/aD3pN0W/5zEQhsk3CCTg+RTUtYjlqpmG
         nqDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791879638; x=1792484438;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=NdJGkjLRgcT7oKI8M+55+ilxnBhUejoXL5Bjpf4+VcY=;
        b=CMeBtBM4U20aI4pyrWU+8vVLcSx2rnABYQ2twVdsbugwoXL/CwqAcJd/M0rCCV4TPY
         GOU2vSKdMD1CgnTQtBAO/xtp5XpiJNS63eeVDwAIht+Q4wd5YzcIy8fApetAfg2omiYS
         QtryNoDTlJk8f+tA5kFIQcY733f/95jEZullNLplbXzmVNgxQ6Gvg/V95wkUnVZlllOu
         khd91qGUz6jqijA3zsoq+fRArI8SgEjkoiCEsSYz4/1L4WlOQKq3DudJ/vxZ0oMme9lu
         GqKDosnymYdQCUGg299Bl/n/CIojUIjvXImUmZbKT3ft2k78Cjx86pfN3FEurTHvKRFk
         B89Q==
X-Gm-Message-State: AFq9FYKXpOlIMDqbJIzmYpMwmTOTKKpiJvnSdWqCg9RSrgI9azQoVD17
	rURbLjycapLg5IfcBFQVxIfYDojYbqWmklN63ShIXSDaqcTWkBp+lEUcbVMA3tpExRI=
X-Gm-Gg: AYBFou3NMugGP2wRMWpvSGg/RuYmJo6NyQ2ilDWDqcYVzID2s7noiyVzCITGr6FH1dm
	0U1pOFo89vnKrEMqpl0ECYS6vz+soGiEQOkNxVbo/xZwrZ3bLBJ+nZ/zzEI2hSk6hlmIBXqjmxM
	OHnxxyXZVCWpfAd64vIQ4o/mP/B9OeOfKbN560SWQiVqb8bx0bagduls815L7JaaAha6Zzb5iGw
	rTjXgadLzG60dBswH0bJLl6M67JcdnKp5HO2JBYzrOgZpTBG7iV8584RrXdPmxE5HLUf15kQ6er
	LlCZuIGFsNyHB/HnBRocKR5OL59hphLMYvD4eNEvImTWOeo6tWW3tbD/LiqWEpYC0zsMtRVRQ29
	WDs7Wv+d7OmFhnnIjGxMbkrZ+vaUEO2OkQFIBiFQiXxy3ml96m58AB1XoSzU3xmgGLeoGR3P3g8
	vxctjp5u03KpuqUL1Dv88tGB6O414enbXKbi0Bde1RBgWcB1M/xi6pL/ceaODGmcBkT5MzKdJDO
	HtilgS74bHM4zg4JtSPuSv9pDuZutyEZqCV9illvQAvemppnrVLtMCxlJ119c1NvvrmfA+2DFhq
	lw1UdA==
X-Received: by 2002:a05:6820:4cc6:b0:6cd:3fbd:1d60 with SMTP id 006d021491bc7-6ef12ae7144mr8931337eaf.74.1791879637827;
        Tue, 13 Oct 2026 01:20:37 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:4f::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-8303a328dccsm11845906a34.22.2026.10.13.01.20.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 01:20:35 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Tejun Heo <tj@kernel.org>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v2 06/13] selftests/bpf: Test __nullable pointer members
Date: Tue, 13 Oct 2026 10:20:01 +0200
Message-ID: <20261013082012.1107446-7-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261013082012.1107446-1-memxor@gmail.com>
References: <20261013082012.1107446-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=10814; h=from:subject; bh=zzNynjMgJw7WB5ZcAw0omZV492o4fs3u/8AslgBnsSY=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIevsy3k1y6452IQXu1fe3iu6radBZ7b0x8VnSktkVQOEvl3w ZpzYUcrCIMbFICumyFLyfx+T8YnK34G2y7hh5rAygQxh4OIUgIncV2FkeFrVHzz5f4hZ15aJLMwsvE pKP5Sldn0vqDv2I2jb3JZlfxj+Sj+5Pefpi2mSbganrWta7eofTX2xQ+vSc5Hn+uosxUmuLAA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Add a struct_ops member to bpf_testmod whose argument struct carries two
task pointers, one plain and one __nullable, both made trusted through a
__safe_trusted alias of the struct in the module BTF, and a kfunc that
calls the member once with the nullable pointer unset and once set.

The callback acquires the plain pointer as is and the nullable one only
after a check, driven through the kfunc from a syscall program. The
failure case passes the nullable pointer to bpf_task_acquire() unchecked
and is rejected as possibly NULL.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../bpf/prog_tests/test_struct_ops_nullable.c | 68 +++++++++++++++++++
 .../selftests/bpf/progs/struct_ops_nullable.c | 45 ++++++++++++
 .../bpf/progs/struct_ops_nullable_fail.c      | 28 ++++++++
 .../selftests/bpf/test_kmods/bpf_testmod.c    | 33 +++++++++
 .../selftests/bpf/test_kmods/bpf_testmod.h    | 15 ++++
 .../bpf/test_kmods/bpf_testmod_kfunc.h        |  1 +
 6 files changed, 190 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/test_struct_ops_nullable.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_nullable.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_nullable_fail.c

diff --git a/tools/testing/selftests/bpf/prog_tests/test_struct_ops_nullable.c b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_nullable.c
new file mode 100644
index 000000000000..17d5de78273a
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_nullable.c
@@ -0,0 +1,68 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
+#include <test_progs.h>
+#include <bpf/btf.h>
+
+#include "struct_ops_nullable.skel.h"
+#include "struct_ops_nullable_fail.skel.h"
+
+/*
+ * Attach a callback that gets a trusted and a trusted __nullable task pointer
+ * through its argument struct and drive it through the
+ * bpf_testmod_ops3_call_test_nullable() kfunc.
+ */
+static void nullable_member(void)
+{
+	LIBBPF_OPTS(bpf_test_run_opts, topts);
+	struct struct_ops_nullable *skel;
+	struct bpf_link *link;
+	int err;
+
+	skel = struct_ops_nullable__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "struct_ops_nullable__open_and_load"))
+		return;
+
+	link = bpf_map__attach_struct_ops(skel->maps.testmod_nullable);
+	if (!ASSERT_OK_PTR(link, "attach_struct_ops"))
+		goto out;
+
+	err = bpf_prog_test_run_opts(bpf_program__fd(skel->progs.trigger), &topts);
+	ASSERT_OK(err, "test_run");
+	ASSERT_EQ(topts.retval, 0, "trigger_retval");
+
+	bpf_link__destroy(link);
+out:
+	struct_ops_nullable__destroy(skel);
+}
+
+/* Serialized because it attaches the singleton bpf_testmod_ops3. */
+/*
+ * The tag on the member of struct bpf_testmod_nullable_args reaches the module
+ * BTF only from a toolchain with btf_type_tag support.
+ */
+static bool testmod_has_nullable_tag(void)
+{
+	struct btf *vmlinux_btf, *module_btf;
+	bool found = false;
+
+	vmlinux_btf = btf__load_vmlinux_btf();
+	if (!ASSERT_OK_PTR(vmlinux_btf, "vmlinux_btf"))
+		return false;
+	module_btf = btf__load_module_btf("bpf_testmod", vmlinux_btf);
+	if (ASSERT_OK_PTR(module_btf, "module_btf"))
+		found = btf__find_by_name_kind(module_btf, "nullable", BTF_KIND_TYPE_TAG) > 0;
+	btf__free(module_btf);
+	btf__free(vmlinux_btf);
+	return found;
+}
+
+void serial_test_struct_ops_nullable(void)
+{
+	if (!testmod_has_nullable_tag()) {
+		test__skip();
+		return;
+	}
+	if (test__start_subtest("nullable_member"))
+		nullable_member();
+	RUN_TESTS(struct_ops_nullable_fail);
+}
diff --git a/tools/testing/selftests/bpf/progs/struct_ops_nullable.c b/tools/testing/selftests/bpf/progs/struct_ops_nullable.c
new file mode 100644
index 000000000000..387792924c09
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/struct_ops_nullable.c
@@ -0,0 +1,45 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
+
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include "../test_kmods/bpf_testmod.h"
+#include "../test_kmods/bpf_testmod_kfunc.h"
+
+char _license[] SEC("license") = "GPL";
+
+SEC("struct_ops/test_nullable")
+int BPF_PROG(test_nullable_cb, struct bpf_testmod_nullable_args *args)
+{
+	struct task_struct *t;
+	int ret = 0;
+
+	/* trusted, so good for a kfunc as is */
+	t = bpf_task_acquire(args->task);
+	if (!t)
+		return -1;
+	bpf_task_release(t);
+
+	/* trusted but __nullable, so a check has to come first */
+	if (args->task_or_null) {
+		t = bpf_task_acquire(args->task_or_null);
+		if (!t)
+			return -1;
+		bpf_task_release(t);
+		ret = 1;
+	}
+	return ret;
+}
+
+SEC(".struct_ops.link")
+struct bpf_testmod_ops3 testmod_nullable = {
+	.test_nullable = (void *)test_nullable_cb,
+};
+
+SEC("syscall")
+int trigger(void *ctx)
+{
+	/* one call without task_or_null, one with */
+	return bpf_testmod_ops3_call_test_nullable() != 2;
+}
diff --git a/tools/testing/selftests/bpf/progs/struct_ops_nullable_fail.c b/tools/testing/selftests/bpf/progs/struct_ops_nullable_fail.c
new file mode 100644
index 000000000000..c15b3a8c8d39
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/struct_ops_nullable_fail.c
@@ -0,0 +1,28 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
+
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include "bpf_misc.h"
+#include "../test_kmods/bpf_testmod.h"
+
+char _license[] SEC("license") = "GPL";
+
+/* The member is trusted, but __nullable, so it needs a check before the kfunc. */
+SEC("struct_ops/test_nullable")
+__failure __msg("Possibly NULL pointer passed to trusted")
+int BPF_PROG(unchecked_nullable, struct bpf_testmod_nullable_args *args)
+{
+	struct task_struct *t;
+
+	t = bpf_task_acquire(args->task_or_null);
+	if (t)
+		bpf_task_release(t);
+	return 0;
+}
+
+SEC(".struct_ops.link")
+struct bpf_testmod_ops3 testmod_nullable_fail = {
+	.test_nullable = (void *)unchecked_nullable,
+};
diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
index b4f0af2aeca4..0c0152885da3 100644
--- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
@@ -460,6 +460,11 @@ static int bpf_testmod_ops3__test_arena_multislot(struct bpf_testmod_arena_pair
 	return 0;
 }
 
+static int bpf_testmod_ops3__test_nullable(struct bpf_testmod_nullable_args *args)
+{
+	return 0;
+}
+
 static struct bpf_testmod_ops3 __bpf_testmod_ops3 = {
 	.test_1 = bpf_testmod_test_3,
 	.test_2 = bpf_testmod_test_4,
@@ -467,6 +472,7 @@ static struct bpf_testmod_ops3 __bpf_testmod_ops3 = {
 	.test_arena_nullable = bpf_testmod_ops3__test_arena_nullable,
 	.test_arena_stack = bpf_testmod_ops3__test_arena_stack,
 	.test_arena_multislot = bpf_testmod_ops3__test_arena_multislot,
+	.test_nullable = bpf_testmod_ops3__test_nullable,
 };
 
 static void bpf_testmod_test_struct_ops3(void)
@@ -507,6 +513,32 @@ __bpf_kfunc int bpf_testmod_ops3_call_test_arena_multislot(u64 *ptr__arena)
 	return st_ops3->test_arena_multislot(p, ptr__arena);
 }
 
+/*
+ * The members of struct bpf_testmod_nullable_args are trusted the way the
+ * verifier's BTF_TYPE_SAFE_TRUSTED() lists vmlinux members: through a struct
+ * of the same name with the __safe_trusted suffix in the BTF of the module.
+ */
+struct bpf_testmod_nullable_args__safe_trusted {
+	struct task_struct *task;
+	struct task_struct *task_or_null;
+};
+
+/*
+ * Call test_nullable() with @task_or_null unset, then set. The callback
+ * returns 1 when it found a task there, so the expected result is 2.
+ */
+__bpf_kfunc int bpf_testmod_ops3_call_test_nullable(void)
+{
+	struct bpf_testmod_nullable_args args = { .task = current };
+	int ret;
+
+	BTF_TYPE_EMIT(struct bpf_testmod_nullable_args__safe_trusted);
+
+	ret = st_ops3->test_nullable(&args);
+	args.task_or_null = current;
+	return ret | st_ops3->test_nullable(&args) << 1;
+}
+
 struct bpf_testmod_btf_type_tag_1 {
 	int a;
 };
@@ -926,6 +958,7 @@ BTF_ID_FLAGS(func, bpf_testmod_ops3_call_test_arena)
 BTF_ID_FLAGS(func, bpf_testmod_ops3_call_test_arena_nullable)
 BTF_ID_FLAGS(func, bpf_testmod_ops3_call_test_arena_stack)
 BTF_ID_FLAGS(func, bpf_testmod_ops3_call_test_arena_multislot)
+BTF_ID_FLAGS(func, bpf_testmod_ops3_call_test_nullable)
 BTF_ID_FLAGS(func, bpf_kfunc_get_default_trusted_ptr_test);
 BTF_ID_FLAGS(func, bpf_kfunc_put_default_trusted_ptr_test);
 BTF_ID_FLAGS(func, bpf_kfunc_kasan_poison)
diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.h b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.h
index 2b12f81bf748..b905c35490eb 100644
--- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.h
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.h
@@ -114,6 +114,19 @@ struct bpf_testmod_arena_pair {
 	u64 b;
 };
 
+/* The kernel defines the BPF pointer qualifiers, user space and BPF programs need them empty. */
+#ifndef __nullable
+#define __nullable
+#endif
+
+/* Arguments of test_nullable(), trusted through the __safe_trusted alias in the module */
+struct bpf_testmod_nullable_args {
+	/* never NULL */
+	struct task_struct *task;
+	/* NULL on the first call, set on the second */
+	struct task_struct __nullable *task_or_null;
+};
+
 struct bpf_testmod_ops3 {
 	int (*test_1)(void);
 	int (*test_2)(void);
@@ -125,6 +138,8 @@ struct bpf_testmod_ops3 {
 				u64 g, u64 h, u64 *ptr);
 	/* a multi-slot leading arg, so @ptr is not at the slot its arg index suggests */
 	int (*test_arena_multislot)(struct bpf_testmod_arena_pair p, u64 *ptr);
+	/* Used to test __nullable pointer members. */
+	int (*test_nullable)(struct bpf_testmod_nullable_args *args);
 };
 
 struct st_ops_args {
diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h b/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h
index 67c02a421d13..d88c99109c31 100644
--- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h
@@ -218,6 +218,7 @@ int bpf_testmod_ops3_call_test_arena(__u64 *ptr__arena) __ksym;
 int bpf_testmod_ops3_call_test_arena_nullable(__u64 *ptr__arena__nullable) __ksym;
 int bpf_testmod_ops3_call_test_arena_stack(__u64 *ptr__arena) __ksym;
 int bpf_testmod_ops3_call_test_arena_multislot(__u64 *ptr__arena) __ksym;
+int bpf_testmod_ops3_call_test_nullable(void) __ksym;
 
 __u64 bpf_kfunc_call_test1(struct sock *sk, __u32 a, __u64 b,
 				__u32 c, __u64 d) __ksym;
-- 
2.53.0-Meta

