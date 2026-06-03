Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCF6136F439;
	Wed,  3 Jun 2026 11:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780485053; cv=none; b=Pvdt6Z/MGMh7XGcM3j7KiJWgzz1UTIWrK1uQ2deluIenJMipEyx11KpO9I3SlqpSCLqJ6sbLbJiiioRf4ig9dFGMR0T8Oo60mvwdNUhXFg8rgC2BAHtwr++Zx4P7h9iYbqJpTYCy4T+4QLa2EBZAnSl5Pq9o2asWj3dhHcx2z34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780485053; c=relaxed/simple;
	bh=YTvP+rq7K8nud+nxlmHrp6fytLgg/QHZ9vcHVWscO20=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iLcAmhDmkFDYeSoLXJz2Lc619WyakjtQrixmodrZCHgqoOjn6nLqOkaaQTvIVhwt6kt71XzFY3PAqu2d64vUd6W6SQ5iZCmmNjAmpSiQlsK3tESq7l/6N24Lgm86sSg2zuPyV2R/5THAoX0XELpSxY347vY8HwjV3XgGc9Oa/7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YX4VIC4k; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YX4VIC4k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A78431F00898;
	Wed,  3 Jun 2026 11:10:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780485052;
	bh=1yr0+dLJogmB5x3+gmMrSYuSEnaV1GQT5T4fNOxOgrI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YX4VIC4kJwRx14sGorLLionXbsutkA41bMK6vlc2mw86Ro7HPDwtf3bFbSM6TasUn
	 3OzP6eKIt8CYjyPNQm432OtNGn2d9RPMBM8onO4gwsv0c3x0rqi9UwUWUHJQ99ErMH
	 iLe7aMPiO55upW+pxPqqtG17Caatt9IoRMBODllrc6c1xdMVj8uhURM9cw0TeEOKud
	 S7Ri5BQnUsRx7htFylUGZ+lsr2fJLyY/6vX9VJ+MMf8O3uU+QYw+lS7W+qCmlfKpYL
	 0OxIIfsIVooYlFX/NdiHyBA5sYeFtvYKLObshIz9t/wW+/I9sd6ykbVS4LTSpJNaZW
	 joofuDmOGpGMQ==
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
Subject: [PATCHv7 bpf-next 27/29] selftests/bpf: Add tracing multi verifier fails test
Date: Wed,  3 Jun 2026 13:05:51 +0200
Message-ID: <20260603110554.29590-28-jolsa@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260603110554.29590-1-jolsa@kernel.org>
References: <20260603110554.29590-1-jolsa@kernel.org>
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

