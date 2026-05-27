Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 687603557F3;
	Wed, 27 May 2026 11:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779882280; cv=none; b=Fl2PaQdJkKoztIwfP2FFyuGKlmycUmE0YUPXLH6vLQSfaXrhfQC1k2wnFkLlTX+rjT/G8jw/NewAF/q9moloJ1DSWxjXc8/TmnjcuFDkMXNQlXnA9F1pCQhXK5iRZe2c7IACduoTM4mk//KRI5VuT+0qkmblsjpJOmSq1o+D4z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779882280; c=relaxed/simple;
	bh=mpUZfVfm2mauAmx1f4F6lLePiJ75keb2aUNegWA8ECE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rlLTGHhVhGRJBum1EGMd2Ktp3CD98rtdlAbzyTF/kI4suYvqOkcC9Nd2V8ECIn/WoxzkZIcZksdROHXHfTB+/72hr8OYyiHRknJO59jMvAibQoOGR3agUPOURtfI2BhGOEkSLR2AYtnXH4XtaR+V/6VEZ4j4eqHC5J4F7gIo4+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZtlM/YZm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZtlM/YZm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D6111F000E9;
	Wed, 27 May 2026 11:44:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779882279;
	bh=n3nP6t73nmVSmDsSBInaimMZUMsEFLG2Fvb9XWdEJqQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZtlM/YZmksbp6uEf45qeBJRUJM+40Z1IeF67iEpXgZ0FA7bhhR4F95zZtJFZ2GCpg
	 D8SPTFCx+EnT2dtJBklYo0jsYhlwCeTbWk+AYUrLjw3JwYIMzOS9CJInwMiFexItuU
	 wCfkCcaQUXS/6dbvkGMAghPqRtR9HSLh9w9zUUPLV9BxqJr/C4kgva4fAb0QeV4hwv
	 NBwKcjM/0Q5zSmSAtuRUg18U3AFgUqwQJsc0SyUFFNEhObw3D3V+EQZjhuAMDiewRd
	 NmTLmF/l3mZWSMIKANBpkjn2M+jbTgc7rmvTUiAE77JEu/Ft706RzX308T4wUq7Ykv
	 4rO1VyLx6rCSg==
From: Jiri Olsa <jolsa@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	Menglong Dong <menglong8.dong@gmail.com>,
	Steven Rostedt <rostedt@kernel.org>
Subject: [PATCHv6 bpf-next 27/29] selftests/bpf: Add tracing multi verifier fails test
Date: Wed, 27 May 2026 13:39:49 +0200
Message-ID: <20260527113951.46265-28-jolsa@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260527113951.46265-1-jolsa@kernel.org>
References: <20260527113951.46265-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adding tests for verifier fails on tracing multi programs.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 .../selftests/bpf/prog_tests/tracing_multi.c  |  2 ++
 .../bpf/progs/tracing_multi_verifier.c        | 31 +++++++++++++++++++
 2 files changed, 33 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/tracing_multi_verifier.c

diff --git a/tools/testing/selftests/bpf/prog_tests/tracing_multi.c b/tools/testing/selftests/bpf/prog_tests/tracing_multi.c
index f968dcabd795..43401e93b778 100644
--- a/tools/testing/selftests/bpf/prog_tests/tracing_multi.c
+++ b/tools/testing/selftests/bpf/prog_tests/tracing_multi.c
@@ -9,6 +9,7 @@
 #include "tracing_multi_intersect.skel.h"
 #include "tracing_multi_session.skel.h"
 #include "tracing_multi_fail.skel.h"
+#include "tracing_multi_verifier.skel.h"
 #include "trace_helpers.h"
 
 static __u64 bpf_fentry_test_cookies[] = {
@@ -613,4 +614,5 @@ void test_tracing_multi_test(void)
 		test_session();
 	if (test__start_subtest("attach_api_fails"))
 		test_attach_api_fails();
+	RUN_TESTS(tracing_multi_verifier);
 }
diff --git a/tools/testing/selftests/bpf/progs/tracing_multi_verifier.c b/tools/testing/selftests/bpf/progs/tracing_multi_verifier.c
new file mode 100644
index 000000000000..7b6ed41bf452
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/tracing_multi_verifier.c
@@ -0,0 +1,31 @@
+// SPDX-License-Identifier: GPL-2.0
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include "bpf_misc.h"
+
+char _license[] SEC("license") = "GPL";
+
+SEC("fentry.multi/bpf_fentry_test1")
+__failure
+__msg("func 'bpf_multi_func' doesn't have 1-th argument")
+int BPF_PROG(fentry_direct_access, int a)
+{
+	return a;
+}
+
+SEC("fexit.multi/bpf_fentry_test3")
+__failure
+__msg("invalid bpf_context access off=24 size=8")
+int BPF_PROG(fexit_direct_access, char a, int b, __u64 c, int ret)
+{
+	return ret;
+}
+
+SEC("fsession.multi/bpf_fentry_test4")
+__failure
+__msg("invalid bpf_context access off=16 size=8")
+int BPF_PROG(fsession_direct_access, void *a, char b, int c, __u64 d, int ret)
+{
+	return c;
+}
-- 
2.54.0

