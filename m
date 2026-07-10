Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1CC0384238
	for <bpf@vger.kernel.org>; Fri, 10 Jul 2026 19:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783711807; cv=none; b=qnRShBsU6UagNFZLesF9JPQmjE70bIWOPTdgRFOx9tfWAzbBCzNt+u7ujQ606+lI5ulTLW9xmpdDOH3zUxpNg0G5Xab8ahohl7EcO1ENT3T4s/4rtXO3mksLpWi2rIdpmdwzTgazrtwPbSJhJAgWCTjjTe4w3ra04pcFFR5FNj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783711807; c=relaxed/simple;
	bh=OJyuDRFw5yM7/ipRBHROAtI1htqYGWkRB6CFsrEems0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QmzjDVxWPr7XfSF/54ueqAHq0fEeL9TX3rrma8loGtDPAFDvsKxPiAaAkyP3S9h5GeZOyQ6p8IBMmWiVU0WcoO/cHQ2Yt/9g8F6IObDDAzA2GI5BBppoblPEGprdLM2m/CLVjBIQE6XU0dDwnbqugyKp5znpdGbALhC9MCj4ido=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=cyuE7HaQ; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="cyuE7HaQ"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783711801;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qOS7ND7S/XqEDQUm5xhB/QBTb8cHZ1II1QNdq1LwFY8=;
	b=cyuE7HaQaO6lJrUhhZH4i1gu70nf69EsjKo3utBIdACj7f6+uR091EcG/OGVpuCKbyDEfw
	SRjQNjZ19HnJqrt5hXIipRINi9Bt6LUolxOB1rUlX5p5pnXAd7x+IFUGbUhvBQuF6mdi3o
	VcmxTLNmCcxgXzOybYwcL5/CY1f2QaQ=
From: Ihor Solodrai <ihor.solodrai@linux.dev>
To: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Tejun Heo <tj@kernel.org>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH bpf v2 2/2] selftests/bpf: Cover tracing implicit kfunc args
Date: Fri, 10 Jul 2026 12:29:40 -0700
Message-ID: <20260710192940.3020280-3-ihor.solodrai@linux.dev>
In-Reply-To: <20260710192940.3020280-1-ihor.solodrai@linux.dev>
References: <20260710192940.3020280-1-ihor.solodrai@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Kumar Kartikeya Dwivedi <memxor@gmail.com>

KF_IMPLICIT_ARGS kfuncs have a BPF-call prototype and a real kernel
target prototype. Add a tracing selftest that attaches fentry and fexit
programs to bpf_kfunc_implicit_arg(), runs a syscall BPF program that
calls it, and checks that the tracing context exposes both the explicit
argument and the implicit prog aux pointer.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Co-developed-by: Ihor Solodrai <ihor.solodrai@linux.dev>
Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
---
 .../prog_tests/kfunc_implicit_args_tracing.c  | 36 +++++++++
 .../bpf/progs/kfunc_implicit_args_tracing.c   | 77 +++++++++++++++++++
 2 files changed, 113 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/kfunc_implicit_args_tracing.c
 create mode 100644 tools/testing/selftests/bpf/progs/kfunc_implicit_args_tracing.c

diff --git a/tools/testing/selftests/bpf/prog_tests/kfunc_implicit_args_tracing.c b/tools/testing/selftests/bpf/prog_tests/kfunc_implicit_args_tracing.c
new file mode 100644
index 000000000000..61cc5aaba025
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/kfunc_implicit_args_tracing.c
@@ -0,0 +1,36 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
+
+#include <test_progs.h>
+#include "kfunc_implicit_args_tracing.skel.h"
+
+void test_kfunc_implicit_args_tracing(void)
+{
+	struct kfunc_implicit_args_tracing *skel;
+	LIBBPF_OPTS(bpf_test_run_opts, topts);
+	int err, fd;
+
+	skel = kfunc_implicit_args_tracing__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "open_and_load"))
+		return;
+
+	err = kfunc_implicit_args_tracing__attach(skel);
+	if (!ASSERT_OK(err, "attach"))
+		goto cleanup;
+
+	fd = bpf_program__fd(skel->progs.trigger_implicit_arg);
+	err = bpf_prog_test_run_opts(fd, &topts);
+	if (!ASSERT_OK(err, "test_run"))
+		goto cleanup;
+
+	ASSERT_EQ(topts.retval, 5, "kfunc_retval");
+	ASSERT_EQ(skel->bss->fentry_arg_cnt, 2, "fentry_arg_cnt");
+	ASSERT_NEQ(skel->bss->fentry_aux_arg, 0, "fentry_aux_arg");
+	ASSERT_EQ(skel->bss->fentry_result, 1, "fentry_result");
+	ASSERT_EQ(skel->bss->fexit_arg_cnt, 2, "fexit_arg_cnt");
+	ASSERT_NEQ(skel->bss->fexit_aux_arg, 0, "fexit_aux_arg");
+	ASSERT_EQ(skel->bss->fexit_result, 1, "fexit_result");
+
+cleanup:
+	kfunc_implicit_args_tracing__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/kfunc_implicit_args_tracing.c b/tools/testing/selftests/bpf/progs/kfunc_implicit_args_tracing.c
new file mode 100644
index 000000000000..995f8b8b5b9e
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/kfunc_implicit_args_tracing.c
@@ -0,0 +1,77 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
+
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include <errno.h>
+
+extern int bpf_kfunc_implicit_arg(int a) __weak __ksym;
+
+char _license[] SEC("license") = "GPL";
+
+/* Shared arg checks; reports arg count and aux, returns 1 on success. */
+static __always_inline __u64
+check_implicit_args(void *ctx, __u64 *arg_cnt, __u64 *aux_arg)
+{
+	__u64 a = 0, aux = 0, z = 0;
+	__u64 result;
+	__s64 err;
+
+	*arg_cnt = bpf_get_func_arg_cnt(ctx);
+	result = *arg_cnt == 2;
+
+	err = bpf_get_func_arg(ctx, 0, &a);
+	result &= err == 0 && (int)a == 5;
+
+	err = bpf_get_func_arg(ctx, 1, &aux);
+	*aux_arg = aux;
+	result &= err == 0 && aux != 0;
+
+	err = bpf_get_func_arg(ctx, 2, &z);
+	result &= err == -EINVAL;
+
+	return result;
+}
+
+__u64 fentry_result;
+__u64 fentry_arg_cnt;
+__u64 fentry_aux_arg;
+
+SEC("fentry/bpf_kfunc_implicit_arg")
+int BPF_PROG(trace_implicit_arg_fentry)
+{
+	__u64 ret = 0;
+	__s64 err;
+
+	fentry_result = check_implicit_args(ctx, &fentry_arg_cnt, &fentry_aux_arg);
+
+	err = bpf_get_func_ret(ctx, &ret);
+	fentry_result &= err == -EOPNOTSUPP;
+
+	return 0;
+}
+
+__u64 fexit_result;
+__u64 fexit_arg_cnt;
+__u64 fexit_aux_arg;
+
+SEC("fexit/bpf_kfunc_implicit_arg")
+int BPF_PROG(trace_implicit_arg_fexit)
+{
+	__u64 ret = 0;
+	__s64 err;
+
+	fexit_result = check_implicit_args(ctx, &fexit_arg_cnt, &fexit_aux_arg);
+
+	err = bpf_get_func_ret(ctx, &ret);
+	fexit_result &= err == 0 && ret == 5;
+
+	return 0;
+}
+
+SEC("syscall")
+int trigger_implicit_arg(void *ctx)
+{
+	return bpf_kfunc_implicit_arg(5);
+}
-- 
2.55.0

