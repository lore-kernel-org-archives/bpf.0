Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A59C3AE1BC;
	Sat,  6 Jun 2026 12:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780749874; cv=none; b=WvNO8ZFgzE9eK1sjD94oUrS128Botz528rbE346nLbW099wqDpJsJ9ycctmslzntOv+toUxCo3HOIxLNHVCOQxwHJhkTlqZovf0GNU+Tk6o70I5QLZvdnzDGoiMw8R73Tr/FWZiHCZPdFcq4Cpw6MIVHlGrOOm0PabZ+8sBIGyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780749874; c=relaxed/simple;
	bh=YTvP+rq7K8nud+nxlmHrp6fytLgg/QHZ9vcHVWscO20=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V6PL/MXTDL8DglEnZEfy068p+xdUYhZNHsoCx3pD1UMp6wlZQ4Q9g3g74YsV2OOUWsvQhTosZu4zbJr4CL78IBSM86yw5NqgBCw0Rbco+RnGnFn0Hnrvid32J0pcfvMjblSnUvQn9cil8pSO2cNHES5t9/7gFSiCBPkjnCzswiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZDFyThrt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZDFyThrt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CBC71F00893;
	Sat,  6 Jun 2026 12:44:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780749873;
	bh=1yr0+dLJogmB5x3+gmMrSYuSEnaV1GQT5T4fNOxOgrI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZDFyThrtdDy/b55iZANYrN4U19Vwb9aujtOccMrpE0n5Al+y3/RTWgU6lUNy2PyKP
	 HNkrZEG6X4cqD25LTn8qXx9axRUr4onSj7eMBAWPZnZNSTEN0yv9ZZy2tLcgQGqEZX
	 sKSETMtEZKmeTUN0pJoevVbORr09TFBDrGeOMqCSIxN7/dgtXk96HvaSO3Fd4J5PaV
	 +G6QppY4NhXiaLCKxaDJoJd9kRGOz4cE0mn9XEmnBlp1YZdLskauUEMn8X4vdu5KAG
	 uHREyKceSVjuaeCOXE9cpcU5/GPluWh+ciE0ozmWK4craz5WxejsIzB2fZDKQj0SXH
	 yjeluJW8bf0qQ==
From: Jiri Olsa <jolsa@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	Menglong Dong <menglong8.dong@gmail.com>,
	Steven Rostedt <rostedt@kernel.org>
Subject: [PATCHv8 bpf-next 27/29] selftests/bpf: Add tracing multi verifier fails test
Date: Sat,  6 Jun 2026 14:39:52 +0200
Message-ID: <20260606123955.345967-28-jolsa@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260606123955.345967-1-jolsa@kernel.org>
References: <20260606123955.345967-1-jolsa@kernel.org>
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
index 7e1bb071ce2a..9e026f2b254d 100644
--- a/tools/testing/selftests/bpf/prog_tests/tracing_multi.c
+++ b/tools/testing/selftests/bpf/prog_tests/tracing_multi.c
@@ -9,6 +9,7 @@
 #include "tracing_multi_intersect.skel.h"
 #include "tracing_multi_session.skel.h"
 #include "tracing_multi_fail.skel.h"
+#include "tracing_multi_verifier.skel.h"
 #include "trace_helpers.h"
 
 static __u64 bpf_fentry_test_cookies[] = {
@@ -619,4 +620,5 @@ void test_tracing_multi_test(void)
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

