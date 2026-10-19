Received: from mail-oa2-f10.google.com (mail-oa2-f10.google.com [74.125.231.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 856F24E9C2C
	for <bpf@vger.kernel.org>; Mon, 19 Oct 2026 13:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792416155; cv=none; b=huoM6dHvqfBZyTdmj39TJvAFJ/tf2t7Vr81wjOe402iCRnzjuVCUPupuAyWhyRzUYnzAvIExhUEbL3+GC/kl4dVzRrwuosepbKwY2XaooxxWO2CNq1dHsSYFKZgKq5euJpGaJhD/LQS8FVW9Kwv1iQZoj5u2l30EUzYfaq6tZkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792416155; c=relaxed/simple;
	bh=LVhhXJPgEEQhK6/3vaevZi6XuMowg2GMWXS6wbywf2E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZwmDa0W+36tToWIMwf1atmxdxwURE1anNCfnKewKepbphV/xDvJps2fcMdtJDQHDHDmn2OPSZYZsCyNaZtWIreKqdsaiqFi6DZTtSzESORZ42A/UgU1b6z8sQsQ2vmUK4k60GOzuOiYC4Uedb33g+gAI5Vz2ImkzNNIdEot+0Zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rz/TlA2M; arc=none smtp.client-ip=74.125.231.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rz/TlA2M"
Received: by mail-oa2-f10.google.com with SMTP id 586e51a60fabf-4a79c661392so182433fac.0
        for <bpf@vger.kernel.org>; Mon, 19 Oct 2026 06:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792416151; x=1793020951; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1aCi0Z3PgfkSB8oq9axTSnU2dfj+Qnj/Rf0uggztA54=;
        b=rz/TlA2M39v7I7kXNe+761sehzjiQabixCmKY3n1AE9aA/7uVePKifT8AdBpY6tb1M
         l8P2JJKvOUKFPm5sYnqUFZBvNFV6W2eey5ICehr0Vu042CnicnmiG5DrsKnLbHqNZWtw
         lERK1W4UwiOYgAqZirhwpgCk72w1LPYgLhC5rok65S6APxuZd/mjCEnf4O2jfNGuJxiB
         25cfEOa2pMU092FXJyjRPsRSywuiVw8mZWXCyGxwAmpmPq+Vlo8gVBiPkxbjpd0hx10a
         DKiqq4Fg6gLjOhtYU/zWVXSaGmc3vVMoKHGoRDtR5pSKw3qGERtqRleUE1mEm5WXj8pZ
         ysNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792416151; x=1793020951;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=1aCi0Z3PgfkSB8oq9axTSnU2dfj+Qnj/Rf0uggztA54=;
        b=JEWmjuChfvCtRxBEUAx6Ze7zOfDyV3nBnFDFF/j5Eh26GSaEfoLXC3BaISKcjb4agi
         nQN7VL1CKfTcNOCOTkyKmMkh6WHx/HSMyZx45w08JxH19dTo3PAFsUnMfrffZXfnfvVC
         s1PeAQT/ccQddIw3f9rNHj0IBtIvA6jMXmcA82JJiSEgTMkLx8HJ5RzGO/PPB/gR50Gv
         AmVQ7UpTJyOfTpUcuN5045GLiLwJNA1GLvfGGuLbknvMklAkne/7R2VRy29jRkMeH4aC
         w3yMEQcGPAHNRNe6sv5xXkuky96QJSBnfC+gtrR5+Lg1pfEi7Ji6WoOHUhTxPc9oH0J9
         qwHw==
X-Gm-Message-State: AFq9FYKVkFU1VwjOvXUjv/IYee88L1wP5t1GXnXRRHWeWcIrpJq9Yy4f
	QAsyOH9aAbam2Oy1vtW6VgRhQXkj792vkbVru06yN4WNW+7xK5kmdLdJxEDoUTTZ9jQ=
X-Gm-Gg: AYBFou3ePARHRISRO4jGfNj8KHsMNhB+UL9u0II7D119LHM6vF1yqMhhrBpkT1rpbxR
	sUVRRSSl28jDDoP0pVouBPA0ajg4k4wNOulAWot5c5NdhANy4odZTLlYUQ5vAPk8CyRcEEQvoD+
	mRjywCxuRzHPezkUW68Ll8dKFlQtQJcyJp4oizhxe8h9tzFG1aIwYYsFIvMfUgfJYOv2/USdP+0
	jcnIqerdJbH3NQPUisvQeq5+m+u7t88YGVsMe7WHwr9EAtuktD/Rwbfz0CXTZkB5EzdhmG/88zf
	nShKn++edCsiA8GtbaHtb1RNZZ3ELTtAGg/7sFPrgYsWdSACrIf3YiAc1bUq/SPPn4kAF2B/mXv
	0SeGPYTJATbg34dF0hq2xxUu2E4s+qoG3yh13nypbY61sdY2wRoxEKCJhH7eidi7kDvxUUtneI/
	ilKFSs7/lLa5e39rAL1YLJnIFtfwQGHtvtTMr4r1owbrovOR+/Oo9Zfw3T+FRDb3+ULYGy8AepW
	abr4LA8D0XgFpxZEqCIg9qzPeX798pO5KzqOVYlpaHjUaIrs1sJKH/4o4TguoT/uTN9fb/WC+d8
	v//X1A==
X-Received: by 2002:a05:6870:d20f:b0:42c:49c7:a499 with SMTP id 586e51a60fabf-4a7575c5c51mr5661775fac.3.1792416150952;
        Mon, 19 Oct 2026 06:22:30 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:71::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4a73b6cac55sm8892696fac.11.2026.10.19.06.22.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 06:22:29 -0700 (PDT)
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
Subject: [PATCH bpf-next v5 08/16] selftests/bpf: Test __nullable pointer members
Date: Mon, 19 Oct 2026 15:21:50 +0200
Message-ID: <20261019132203.3034698-9-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261019132203.3034698-1-memxor@gmail.com>
References: <20261019132203.3034698-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=22002; h=from:subject; bh=LVhhXJPgEEQhK6/3vaevZi6XuMowg2GMWXS6wbywf2E=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIeuaxFGB5HQOodVyOqoz1eanL/7k4hmrvSKH/+qrXf9VDPgN Qu91lLIwiHExyIopspT838dkfKLyd6DtMm6YOaxMIEMYuDgFYCLP3zAyTNu7NnRBlXjUx2zmXaE17h 2bJ/39kzTvHVux5KHLs+f6iDL8TyheLvA5YC9HrmnJqpV+1a2iNV/UV3/oEghge3F/8qVQLgA=
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

More members cover the other kinds of pointer: a per-CPU one, which
only the per-CPU helpers consume and which keeps the flag, the struct
itself through a plain pointer and through an untrusted one out of a
__kptr_untrusted map value that is never set, and a pointer to a scalar,
which are probed and lose it. The callback uses each after a check; a
failure test passes the per-CPU pointer unchecked, and three programs
read the probed ones unchecked and load. bpf_testmod_ops3 gets the base
helpers for the per-CPU helpers.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../bpf/prog_tests/test_struct_ops_nullable.c | 62 ++++++++++++++
 .../selftests/bpf/progs/struct_ops_nullable.c | 82 +++++++++++++++++++
 .../bpf/progs/struct_ops_nullable_fail.c      | 28 +++++++
 .../progs/struct_ops_nullable_fail__percpu.c  | 28 +++++++
 .../progs/struct_ops_nullable_probed__plain.c | 26 ++++++
 .../struct_ops_nullable_probed__scalar.c      | 26 ++++++
 .../struct_ops_nullable_probed__untrusted.c   | 45 ++++++++++
 .../selftests/bpf/test_kmods/bpf_testmod.c    | 43 ++++++++++
 .../selftests/bpf/test_kmods/bpf_testmod.h    | 34 ++++++++
 .../bpf/test_kmods/bpf_testmod_kfunc.h        |  1 +
 tools/testing/selftests/bpf/testing_helpers.c | 45 ++++++++++
 tools/testing/selftests/bpf/testing_helpers.h |  7 ++
 12 files changed, 427 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/test_struct_ops_nullable.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_nullable.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_nullable_fail.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_nullable_fail__percpu.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_nullable_probed__plain.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_nullable_probed__scalar.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_nullable_probed__untrusted.c

diff --git a/tools/testing/selftests/bpf/prog_tests/test_struct_ops_nullable.c b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_nullable.c
new file mode 100644
index 000000000000..028f070f2e5f
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_nullable.c
@@ -0,0 +1,62 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
+#include <test_progs.h>
+
+#include "struct_ops_nullable.skel.h"
+#include "struct_ops_nullable_fail.skel.h"
+#include "struct_ops_nullable_fail__percpu.skel.h"
+#include "struct_ops_nullable_probed__plain.skel.h"
+#include "struct_ops_nullable_probed__scalar.skel.h"
+#include "struct_ops_nullable_probed__untrusted.skel.h"
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
+	RUN_TESTS(struct_ops_nullable_probed__plain);
+	RUN_TESTS(struct_ops_nullable_probed__scalar);
+	RUN_TESTS(struct_ops_nullable_probed__untrusted);
+}
diff --git a/tools/testing/selftests/bpf/progs/struct_ops_nullable.c b/tools/testing/selftests/bpf/progs/struct_ops_nullable.c
new file mode 100644
index 000000000000..929969e1e012
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/struct_ops_nullable.c
@@ -0,0 +1,82 @@
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
+/* an untrusted pointer to the argument struct, never set, for the verifier */
+struct untrusted_val {
+	struct bpf_testmod_nullable_args __kptr_untrusted *args;
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, 1);
+	__type(key, int);
+	__type(value, struct untrusted_val);
+} untrusted_map SEC(".maps");
+
+SEC("struct_ops/test_nullable")
+int BPF_PROG(test_nullable_cb, struct bpf_testmod_nullable_args *args)
+{
+	struct bpf_testmod_nullable_args *u;
+	struct untrusted_val *v;
+	struct task_struct *t;
+	int ret = 0, *i, zero = 0;
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
+	/* through an untrusted pointer the member is probed too, and stays nullable */
+	v = bpf_map_lookup_elem(&untrusted_map, &zero);
+	u = v ? v->args : NULL;
+	if (u) {
+		t = u->task_or_null;
+		if (t && t->pid != args->task->pid)
+			return -1;
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
diff --git a/tools/testing/selftests/bpf/progs/struct_ops_nullable_probed__plain.c b/tools/testing/selftests/bpf/progs/struct_ops_nullable_probed__plain.c
new file mode 100644
index 000000000000..c45f6d34f7d2
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/struct_ops_nullable_probed__plain.c
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
+ * Through a plain pointer the member is probed, which tolerates NULL, so the
+ * tag asks for no check there, as the BTF_TYPE_SAFE_*_OR_NULL lists never did.
+ */
+SEC("struct_ops/test_nullable")
+__success
+int BPF_PROG(unchecked_plain, struct bpf_testmod_nullable_args *args)
+{
+	return args->self->task_or_null->pid;
+}
+
+SEC(".struct_ops.link")
+struct bpf_testmod_ops3 testmod_nullable_probed = {
+	.test_nullable = (void *)unchecked_plain,
+};
diff --git a/tools/testing/selftests/bpf/progs/struct_ops_nullable_probed__scalar.c b/tools/testing/selftests/bpf/progs/struct_ops_nullable_probed__scalar.c
new file mode 100644
index 000000000000..ff768746b0da
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/struct_ops_nullable_probed__scalar.c
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
+ * A pointer to a scalar walks as untrusted memory, which is probed, so the
+ * tag asks for no check there.
+ */
+SEC("struct_ops/test_nullable")
+__success
+int BPF_PROG(unchecked_scalar, struct bpf_testmod_nullable_args *args)
+{
+	return *args->int_or_null;
+}
+
+SEC(".struct_ops.link")
+struct bpf_testmod_ops3 testmod_nullable_probed = {
+	.test_nullable = (void *)unchecked_scalar,
+};
diff --git a/tools/testing/selftests/bpf/progs/struct_ops_nullable_probed__untrusted.c b/tools/testing/selftests/bpf/progs/struct_ops_nullable_probed__untrusted.c
new file mode 100644
index 000000000000..961999139841
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/struct_ops_nullable_probed__untrusted.c
@@ -0,0 +1,45 @@
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
+struct untrusted_val {
+	struct bpf_testmod_nullable_args __kptr_untrusted *args;
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, 1);
+	__type(key, int);
+	__type(value, struct untrusted_val);
+} untrusted_map SEC(".maps");
+
+/*
+ * Through an untrusted pointer the member is probed, which tolerates NULL, so
+ * the tag asks for no check there.
+ */
+SEC("struct_ops/test_nullable")
+__success
+int BPF_PROG(unchecked_untrusted, struct bpf_testmod_nullable_args *args)
+{
+	struct bpf_testmod_nullable_args *u;
+	struct untrusted_val *v;
+	int zero = 0;
+
+	v = bpf_map_lookup_elem(&untrusted_map, &zero);
+	u = v ? v->args : NULL;
+	if (!u)
+		return 0;
+	return u->task_or_null->pid;
+}
+
+SEC(".struct_ops.link")
+struct bpf_testmod_ops3 testmod_nullable_probed = {
+	.test_nullable = (void *)unchecked_untrusted,
+};
diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
index 613abd27be5d..37d5824810d1 100644
--- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
@@ -506,6 +506,11 @@ static int bpf_testmod_ops3__test_arena_multislot(struct bpf_testmod_arena_pair
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
@@ -513,6 +518,7 @@ static struct bpf_testmod_ops3 __bpf_testmod_ops3 = {
 	.test_arena_nullable = bpf_testmod_ops3__test_arena_nullable,
 	.test_arena_stack = bpf_testmod_ops3__test_arena_stack,
 	.test_arena_multislot = bpf_testmod_ops3__test_arena_multislot,
+	.test_nullable = bpf_testmod_ops3__test_nullable,
 };
 
 static void bpf_testmod_test_struct_ops3(void)
@@ -553,6 +559,41 @@ __bpf_kfunc int bpf_testmod_ops3_call_test_arena_multislot(u64 *ptr__arena)
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
@@ -980,6 +1021,7 @@ BTF_ID_FLAGS(func, bpf_testmod_ops3_call_test_arena)
 BTF_ID_FLAGS(func, bpf_testmod_ops3_call_test_arena_nullable)
 BTF_ID_FLAGS(func, bpf_testmod_ops3_call_test_arena_stack)
 BTF_ID_FLAGS(func, bpf_testmod_ops3_call_test_arena_multislot)
+BTF_ID_FLAGS(func, bpf_testmod_ops3_call_test_nullable)
 BTF_ID_FLAGS(func, bpf_kfunc_get_default_trusted_ptr_test);
 BTF_ID_FLAGS(func, bpf_kfunc_put_default_trusted_ptr_test);
 BTF_ID_FLAGS(func, bpf_kfunc_kasan_poison)
@@ -1956,6 +1998,7 @@ static const struct bpf_verifier_ops bpf_testmod_verifier_ops = {
 };
 
 static const struct bpf_verifier_ops bpf_testmod_verifier_ops3 = {
+	.get_func_proto	 = bpf_base_func_proto,
 	.is_valid_access = bpf_testmod_ops_is_valid_access,
 };
 
diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.h b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.h
index 2b12f81bf748..1a67564a6b8d 100644
--- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.h
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.h
@@ -114,6 +114,38 @@ struct bpf_testmod_arena_pair {
 	u64 b;
 };
 
+/*
+ * The qualifiers are BTF type tags for the verifier. The module gets them
+ * from bpf_compiler_types.h, user space and BPF programs need them empty.
+ */
+#ifdef __KERNEL__
+#include <linux/bpf_compiler_types.h>
+#endif
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
@@ -125,6 +157,8 @@ struct bpf_testmod_ops3 {
 				u64 g, u64 h, u64 *ptr);
 	/* a multi-slot leading arg, so @ptr is not at the slot its arg index suggests */
 	int (*test_arena_multislot)(struct bpf_testmod_arena_pair p, u64 *ptr);
+	/* Used to test __nullable pointer members. */
+	int (*test_nullable)(struct bpf_testmod_nullable_args *args);
 };
 
 struct st_ops_args {
diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h b/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h
index 8f2f8b8a26e3..1e7b1f1e5148 100644
--- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h
@@ -224,6 +224,7 @@ int bpf_testmod_ops3_call_test_arena(__u64 *ptr__arena) __ksym;
 int bpf_testmod_ops3_call_test_arena_nullable(__u64 *ptr__arena__nullable) __ksym;
 int bpf_testmod_ops3_call_test_arena_stack(__u64 *ptr__arena) __ksym;
 int bpf_testmod_ops3_call_test_arena_multislot(__u64 *ptr__arena) __ksym;
+int bpf_testmod_ops3_call_test_nullable(void) __ksym;
 
 __u64 bpf_kfunc_call_test1(struct sock *sk, __u32 a, __u64 b,
 				__u32 c, __u64 d) __ksym;
diff --git a/tools/testing/selftests/bpf/testing_helpers.c b/tools/testing/selftests/bpf/testing_helpers.c
index 202c40e536b2..1e3e31ac36eb 100644
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
@@ -644,3 +645,47 @@ int compare_text_to_expected(const char *actual, const char *expected)
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
+	err = -ENOENT;
+	for (i = 0, m = btf_members(t); i < btf_vlen(t); i++, m++) {
+		if (strcmp(btf__name_by_offset(module_btf, m->name_off), member))
+			continue;
+		err = 0;
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
index d5083fb92ccd..36a75158495b 100644
--- a/tools/testing/selftests/bpf/testing_helpers.h
+++ b/tools/testing/selftests/bpf/testing_helpers.h
@@ -67,4 +67,11 @@ int stack_mprotect(void);
 /* Runs diff(1) on mismatch */
 int compare_text_to_expected(const char *actual, const char *expected);
 
+/*
+ * Whether @member of struct @struct_name in the BTF of bpf_testmod carries
+ * the BTF type tag @tag: 1 if so, 0 if not, negative on a BTF error or when
+ * the struct or the member is missing.
+ */
+int testmod_member_has_type_tag(const char *struct_name, const char *member, const char *tag);
+
 #endif /* __TESTING_HELPERS_H */
-- 
2.53.0-Meta

