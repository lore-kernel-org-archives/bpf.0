Received: from mail-oo2-f7.google.com (mail-oo2-f7.google.com [74.125.231.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A79B4A841E
	for <bpf@vger.kernel.org>; Thu, 15 Oct 2026 23:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792107721; cv=none; b=mRfwwFs2uF4eiMc3iotHApyZ32CsNZoVUtFK2uQ5jaLGOPPPs9im6CM1sokHnEo7UUb2r8WoEgYM9s/1ZF+xgsdKvtZH7nBsfB62BVmhRG5G9u9rCBDnMn0a1hXcUz5lYDLbXNPtYKkchYD4f+bmPY6JFcYOcK5rJ+oZps1fY/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792107721; c=relaxed/simple;
	bh=WuW3mfflVkQBXhW5eK5tG0IBndV4ONM+KDGiWrTk6ao=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tLhfiuQWVDZcN46ES7MJWFvCSEa12au9OLiuXvFWvu64SG0WOkAJxRvnUQVN0ncJZyOTg0YNpNGB0fSiw1oXtlOM0dioYasfttN3h2eVa6yfqH04UUmYuW1W+Kk5h9txwyu3Z0sukbQtjI4L9NrlXBYGNf0ON0t0pVxKgNxBlLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l1Pi6kpV; arc=none smtp.client-ip=74.125.231.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l1Pi6kpV"
Received: by mail-oo2-f7.google.com with SMTP id 006d021491bc7-6dcee5a2fa8so405005eaf.1
        for <bpf@vger.kernel.org>; Thu, 15 Oct 2026 16:41:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792107718; x=1792712518; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=u0XY2wb5YIAdIm7W+dNYyrfZK/jVLP2WlgD1w7oN5+s=;
        b=l1Pi6kpVDgn/B7V0CKF7Abmyao9hSwLziDgiMlhx9B7lnLNwWeig+6Sa/Mxt/404aa
         9HRzg0TGLE3XQFImmagahzlpDDwYtl1kBeLqwpEPsjjQk3jYJmUAoTIzps4We0cIeIOG
         RysHi4vBYMW/UstPNOJntXKVk0rxAUqn5MYkWQ1jEjHB9Qq56+oCWwrznEKUCJsitC58
         7/IZkTbKRix7s8ZbEcUZwLuPhwgEMZq3SvK5dlqcsLgRFnYgPVgpyI870/59iBE2KtJf
         DJ/SAbD3kcNX6eByaxd0d6lAjbNMWYSWga0wj1jUtSJu6CHKOJxotqScfVp5zT2wkw3a
         eEfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792107718; x=1792712518;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=u0XY2wb5YIAdIm7W+dNYyrfZK/jVLP2WlgD1w7oN5+s=;
        b=CW3eHHymDVE6bsxbtVxg9rNe8Yl6a3EgsJdf3FCm3Q4TFL2OWRjptPW+D1JVzQX7dd
         btAtPhKYXUgu6S4YpUIQmhS+jKQJa8ZFlOpX3jU6DgmB4ozgDM7Uq6vF4FwTSzV9x2b6
         6pSoicRA8HCj7mBt3b/ACYPJa3e2tjR58mrTPMcvSqmKaUAgkogK+/kmjLI+DzSeNHRQ
         thAE70MIWfg35CQnCx/DGOKTi2HbNlePQiGjxd55nqt5wu+yK47LG4MKmk/LU6G4dRHq
         yU5BsoaZGmnMiVI+JHjf7qahjP+I0MDnFoxCn7JikxF7+AAGH5zVyQNxF2hD1z+JGAqM
         1VsQ==
X-Gm-Message-State: AFq9FYI8r1hwrFDo/mOblFYY8OZfNvd5ypYkhESo7aldJYS9g+Hp3gOs
	Apl3uM6hsIzay/rm19M9IaT/DijBsrfkDDLj/ZRm4OOPx+XQMGi1n5GZ/dvMJIcUvEU=
X-Gm-Gg: AYBFou0Vp83Lq/SYeV0LWWsZmmLV8LgQgdghAvMExDDCwqNpHGCrTfUURtqEPb4HeFt
	OIZvF++pR0wjnEtwJllBF+odnKpslCLYJ8q16FGc9woU5odv1r629zK4EkrES7pfZKmMedIU99j
	mlCsOMaGl/dOaBc12iIfvqrnBNhMEXFSci9QZC3NQzb09tN5RWOHB0DrJA2iblkAo5nIsV434an
	nzikFJZdsKdRuRrOZ3VKjLfEI7IBFNdFGtEqet39Bqm80p9BKloQ+tU3eFmzMLObsWsOiWFS8pf
	UB8n33q4IJvz55PrxCfZKw0HOhKi+PGSw4XB1LuBRhQ9wa8l7PjMcmSFO5WncLQjVhVPT8imtT7
	YiKqhP1T0GsNJkBBVkT/M/TYFTRtHkf3Xwvf9MM9G1QkSvDt308fN+5Z55OJXCUHhv0ZL+imMZf
	U06YN8FnobaVbWYM7F/dxMDzG+Hi2uJtQP1JOcNRVGm0onfs8hGsqVK4TC4rkLqYfvlYb/+3+gY
	AFY4xkmMoQcoFaNbBhEAj4bbGQzWjWe7bofVp83Xe4PNXX7urg8iE1EkFK7dRoruN6u6SFDtDOh
	LkGH
X-Received: by 2002:a05:6820:4df8:b0:6ca:36f9:178e with SMTP id 006d021491bc7-7010f2b1543mr1069664eaf.28.1792107718131;
        Thu, 15 Oct 2026 16:41:58 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:7::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-7018f2df328sm566502eaf.7.2026.10.15.16.41.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 16:41:56 -0700 (PDT)
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
Subject: [PATCH bpf-next v3 08/15] selftests/bpf: Test __nullable pointer members
Date: Fri, 16 Oct 2026 01:41:14 +0200
Message-ID: <20261015234125.3152346-9-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261015234125.3152346-1-memxor@gmail.com>
References: <20261015234125.3152346-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=19300; h=from:subject; bh=WuW3mfflVkQBXhW5eK5tG0IBndV4ONM+KDGiWrTk6ao=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIeti3OuONxuj+qM5Je5t1Pt1wr7S8R/nzPdRYr/v/DxxJlBe /3Z9RykLgxgXg6yYIkvJ/31MxicqfwfaLuOGmcPKBDKEgYtTACZS8IGR4ZSxy+lDPctWzl4jcz1/lc SffbudMj8GX92w3NejN4n3w0dGhg7vnd5f/i0+/Ohvr2Wiz8bAT2azLmw60nL0sl1u5ZKVj3kB
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

Three more members cover the other kinds of pointer that keep the flag:
a per-CPU pointer, which only the per-CPU helpers consume, the struct
itself through a plain pointer, which the verifier probes, and a pointer
to a scalar, which walks as untrusted memory. The callback uses each
after a check and a failure test uses each without one.
bpf_testmod_ops3 gets the base helpers for the per-CPU helpers.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../bpf/prog_tests/test_struct_ops_nullable.c | 60 +++++++++++++++++++
 .../selftests/bpf/progs/struct_ops_nullable.c | 60 +++++++++++++++++++
 .../bpf/progs/struct_ops_nullable_fail.c      | 28 +++++++++
 .../progs/struct_ops_nullable_fail__percpu.c  | 28 +++++++++
 .../progs/struct_ops_nullable_fail__plain.c   | 26 ++++++++
 .../progs/struct_ops_nullable_fail__scalar.c  | 26 ++++++++
 .../selftests/bpf/test_kmods/bpf_testmod.c    | 43 +++++++++++++
 .../selftests/bpf/test_kmods/bpf_testmod.h    | 28 +++++++++
 .../bpf/test_kmods/bpf_testmod_kfunc.h        |  1 +
 tools/testing/selftests/bpf/testing_helpers.c | 43 +++++++++++++
 tools/testing/selftests/bpf/testing_helpers.h |  6 ++
 11 files changed, 349 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/test_struct_ops_nullable.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_nullable.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_nullable_fail.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_nullable_fail__percpu.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_nullable_fail__plain.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_nullable_fail__scalar.c

diff --git a/tools/testing/selftests/bpf/prog_tests/test_struct_ops_nullable.c b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_nullable.c
new file mode 100644
index 000000000000..1e8e55419624
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_nullable.c
@@ -0,0 +1,60 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
+#include <test_progs.h>
+
+#include "struct_ops_nullable.skel.h"
+#include "struct_ops_nullable_fail.skel.h"
+#include "struct_ops_nullable_fail__percpu.skel.h"
+#include "struct_ops_nullable_fail__plain.skel.h"
+#include "struct_ops_nullable_fail__scalar.skel.h"
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
+void serial_test_struct_ops_nullable(void)
+{
+	int has_tag;
+
+	/* the tag reaches the module BTF only from a toolchain with btf_type_tag support */
+	has_tag = testmod_member_has_type_tag("bpf_testmod_nullable_args", "task_or_null", "nullable");
+	if (!ASSERT_GE(has_tag, 0, "testmod_btf"))
+		return;
+	if (!has_tag) {
+		printf("%s:SKIP: no nullable type tag in the bpf_testmod BTF\n", __func__);
+		test__skip();
+		return;
+	}
+	if (test__start_subtest("nullable_member"))
+		nullable_member();
+	RUN_TESTS(struct_ops_nullable_fail);
+	RUN_TESTS(struct_ops_nullable_fail__percpu);
+	RUN_TESTS(struct_ops_nullable_fail__plain);
+	RUN_TESTS(struct_ops_nullable_fail__scalar);
+}
diff --git a/tools/testing/selftests/bpf/progs/struct_ops_nullable.c b/tools/testing/selftests/bpf/progs/struct_ops_nullable.c
new file mode 100644
index 000000000000..144c4eab862c
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/struct_ops_nullable.c
@@ -0,0 +1,60 @@
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
+	int ret = 0, *i;
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
+	/* per-CPU and __nullable: a check has to come first, per_cpu_ptr() has none */
+	if (args->pcpu_or_null) {
+		struct bpf_testmod_pcpu *v = bpf_this_cpu_ptr(args->pcpu_or_null);
+
+		if (v->val != 0x5ca1ab1e)
+			return -1;
+	}
+	/* through a plain pointer the loads are probed, __nullable still asks for a check */
+	t = args->self->task_or_null;
+	if (t && t->pid != args->task->pid)
+		return -1;
+	/* a pointer to a scalar walks as untrusted memory, __nullable applies all the same */
+	i = args->int_or_null;
+	if (i && *i != 7)
+		return -1;
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
diff --git a/tools/testing/selftests/bpf/progs/struct_ops_nullable_fail__percpu.c b/tools/testing/selftests/bpf/progs/struct_ops_nullable_fail__percpu.c
new file mode 100644
index 000000000000..652015189162
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/struct_ops_nullable_fail__percpu.c
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
+/*
+ * The member is per-CPU and __nullable: per_cpu_ptr() shifts NULL like any
+ * other pointer, so a check has to come before the helper.
+ */
+SEC("struct_ops/test_nullable")
+__failure __msg("Possibly NULL pointer passed to trusted R1")
+int BPF_PROG(unchecked_percpu, struct bpf_testmod_nullable_args *args)
+{
+	struct bpf_testmod_pcpu *v = bpf_this_cpu_ptr(args->pcpu_or_null);
+
+	return v->val;
+}
+
+SEC(".struct_ops.link")
+struct bpf_testmod_ops3 testmod_nullable_fail = {
+	.test_nullable = (void *)unchecked_percpu,
+};
diff --git a/tools/testing/selftests/bpf/progs/struct_ops_nullable_fail__plain.c b/tools/testing/selftests/bpf/progs/struct_ops_nullable_fail__plain.c
new file mode 100644
index 000000000000..ddd64317d691
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/struct_ops_nullable_fail__plain.c
@@ -0,0 +1,26 @@
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
+/*
+ * Through a plain pointer the member is probed, which would tolerate NULL,
+ * but it is __nullable, so a check has to come first all the same.
+ */
+SEC("struct_ops/test_nullable")
+__failure __msg("invalid mem access 'ptr_or_null_'")
+int BPF_PROG(unchecked_plain, struct bpf_testmod_nullable_args *args)
+{
+	return args->self->task_or_null->pid;
+}
+
+SEC(".struct_ops.link")
+struct bpf_testmod_ops3 testmod_nullable_fail = {
+	.test_nullable = (void *)unchecked_plain,
+};
diff --git a/tools/testing/selftests/bpf/progs/struct_ops_nullable_fail__scalar.c b/tools/testing/selftests/bpf/progs/struct_ops_nullable_fail__scalar.c
new file mode 100644
index 000000000000..28b442147304
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/struct_ops_nullable_fail__scalar.c
@@ -0,0 +1,26 @@
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
+/*
+ * A pointer to a scalar walks as untrusted memory, which is probed, but it
+ * is __nullable, so a check has to come first all the same.
+ */
+SEC("struct_ops/test_nullable")
+__failure __msg("invalid mem access 'rdonly_untrusted_mem_or_null'")
+int BPF_PROG(unchecked_scalar, struct bpf_testmod_nullable_args *args)
+{
+	return *args->int_or_null;
+}
+
+SEC(".struct_ops.link")
+struct bpf_testmod_ops3 testmod_nullable_fail = {
+	.test_nullable = (void *)unchecked_scalar,
+};
diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
index b4f0af2aeca4..92495affa461 100644
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
@@ -507,6 +513,41 @@ __bpf_kfunc int bpf_testmod_ops3_call_test_arena_multislot(u64 *ptr__arena)
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
+static DEFINE_PER_CPU(struct bpf_testmod_pcpu, bpf_testmod_nullable_pcpu);
+
+/*
+ * Call test_nullable() with the __nullable members unset, then set. The
+ * callback returns 1 when it found a task in @task_or_null, so the expected
+ * result is 2.
+ */
+__bpf_kfunc int bpf_testmod_ops3_call_test_nullable(void)
+{
+	struct bpf_testmod_nullable_args args = { .task = current };
+	int seven = 7, ret;
+
+	BTF_TYPE_EMIT(struct bpf_testmod_nullable_args__safe_trusted);
+
+	if (!st_ops3 || !st_ops3->test_nullable)
+		return -EOPNOTSUPP;
+	args.self = &args;
+	ret = st_ops3->test_nullable(&args);
+	args.task_or_null = current;
+	this_cpu_write(bpf_testmod_nullable_pcpu.val, 0x5ca1ab1e);
+	args.pcpu_or_null = &bpf_testmod_nullable_pcpu;
+	args.int_or_null = &seven;
+	return ret | st_ops3->test_nullable(&args) << 1;
+}
+
 struct bpf_testmod_btf_type_tag_1 {
 	int a;
 };
@@ -926,6 +967,7 @@ BTF_ID_FLAGS(func, bpf_testmod_ops3_call_test_arena)
 BTF_ID_FLAGS(func, bpf_testmod_ops3_call_test_arena_nullable)
 BTF_ID_FLAGS(func, bpf_testmod_ops3_call_test_arena_stack)
 BTF_ID_FLAGS(func, bpf_testmod_ops3_call_test_arena_multislot)
+BTF_ID_FLAGS(func, bpf_testmod_ops3_call_test_nullable)
 BTF_ID_FLAGS(func, bpf_kfunc_get_default_trusted_ptr_test);
 BTF_ID_FLAGS(func, bpf_kfunc_put_default_trusted_ptr_test);
 BTF_ID_FLAGS(func, bpf_kfunc_kasan_poison)
@@ -1876,6 +1918,7 @@ static const struct bpf_verifier_ops bpf_testmod_verifier_ops = {
 };
 
 static const struct bpf_verifier_ops bpf_testmod_verifier_ops3 = {
+	.get_func_proto	 = bpf_base_func_proto,
 	.is_valid_access = bpf_testmod_ops_is_valid_access,
 };
 
diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.h b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.h
index 2b12f81bf748..cde3a2f47959 100644
--- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.h
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.h
@@ -114,6 +114,32 @@ struct bpf_testmod_arena_pair {
 	u64 b;
 };
 
+/* The kernel defines the BPF pointer qualifiers, user space and BPF programs need them empty. */
+#ifndef __nullable
+#define __nullable
+#endif
+#ifndef __percpu
+#define __percpu
+#endif
+
+struct bpf_testmod_pcpu {
+	int val;
+};
+
+/* Arguments of test_nullable(), trusted through the __safe_trusted alias in the module */
+struct bpf_testmod_nullable_args {
+	/* never NULL */
+	struct task_struct *task;
+	/* NULL on the first call, set on the second */
+	struct task_struct __nullable *task_or_null;
+	/* NULL on the first call, a per-CPU variable on the second */
+	struct bpf_testmod_pcpu __percpu __nullable *pcpu_or_null;
+	/* NULL on the first call, set on the second */
+	int __nullable *int_or_null;
+	/* this struct again, through a plain pointer, which the verifier probes */
+	struct bpf_testmod_nullable_args *self;
+};
+
 struct bpf_testmod_ops3 {
 	int (*test_1)(void);
 	int (*test_2)(void);
@@ -125,6 +151,8 @@ struct bpf_testmod_ops3 {
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
diff --git a/tools/testing/selftests/bpf/testing_helpers.c b/tools/testing/selftests/bpf/testing_helpers.c
index 202c40e536b2..c60b2425c59a 100644
--- a/tools/testing/selftests/bpf/testing_helpers.c
+++ b/tools/testing/selftests/bpf/testing_helpers.c
@@ -8,6 +8,7 @@
 #include <sys/mman.h>
 #include <alloca.h>
 #include <bpf/bpf.h>
+#include <bpf/btf.h>
 #include <bpf/libbpf.h>
 #include "disasm.h"
 #include "test_progs.h"
@@ -644,3 +645,45 @@ int compare_text_to_expected(const char *actual, const char *expected)
 	}
 	return -1;
 }
+
+int testmod_member_has_type_tag(const char *struct_name, const char *member, const char *tag)
+{
+	struct btf *vmlinux_btf, *module_btf = NULL;
+	const struct btf_member *m;
+	const struct btf_type *t;
+	int err = 0, id, i;
+
+	vmlinux_btf = btf__load_vmlinux_btf();
+	if (!vmlinux_btf)
+		return -errno;
+	module_btf = btf__load_module_btf("bpf_testmod", vmlinux_btf);
+	if (!module_btf) {
+		err = -errno;
+		goto out;
+	}
+	id = btf__find_by_name_kind_own(module_btf, struct_name, BTF_KIND_STRUCT);
+	if (id < 0) {
+		err = id;
+		goto out;
+	}
+	t = btf__type_by_id(module_btf, id);
+	for (i = 0, m = btf_members(t); i < btf_vlen(t); i++, m++) {
+		if (strcmp(btf__name_by_offset(module_btf, m->name_off), member))
+			continue;
+		/* the tag sits on the pointee, behind the pointer and other modifiers */
+		for (id = m->type; id; id = t->type) {
+			t = btf__type_by_id(module_btf, id);
+			if (btf_is_type_tag(t) && !strcmp(btf__name_by_offset(module_btf, t->name_off), tag)) {
+				err = 1;
+				break;
+			}
+			if (!btf_is_ptr(t) && !btf_is_mod(t) && !btf_is_typedef(t))
+				break;
+		}
+		break;
+	}
+out:
+	btf__free(module_btf);
+	btf__free(vmlinux_btf);
+	return err;
+}
diff --git a/tools/testing/selftests/bpf/testing_helpers.h b/tools/testing/selftests/bpf/testing_helpers.h
index d5083fb92ccd..069a3bac3f66 100644
--- a/tools/testing/selftests/bpf/testing_helpers.h
+++ b/tools/testing/selftests/bpf/testing_helpers.h
@@ -67,4 +67,10 @@ int stack_mprotect(void);
 /* Runs diff(1) on mismatch */
 int compare_text_to_expected(const char *actual, const char *expected);
 
+/*
+ * Whether @member of struct @struct_name in the BTF of bpf_testmod carries
+ * the BTF type tag @tag: 1 if so, 0 if not, negative on a BTF error.
+ */
+int testmod_member_has_type_tag(const char *struct_name, const char *member, const char *tag);
+
 #endif /* __TESTING_HELPERS_H */
-- 
2.53.0-Meta

