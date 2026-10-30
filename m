Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.84.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793386280;
	b=wwkM6ye0RwvXkvditB8PWNwVq7mLIyFjVt9hrl5CO9gKW9HxmlKJrPez9JExxvgrBr8j
	 iWwfHbrBPVqXlzidY43n3sLLeY9BYEA/W6kid6YyJFRCA5d8/2hm3HwdU2k3xt7wB9sFY
	 fngX+uJjdQgaupXP6wOu8MdG8Sd4m5aTCBI8P+TrHSPC1j8dnaAce0Ajy+x04vwiuRaUN
	 TAlYeZYRoCF3R6DbPCSdACAmmaqwGeAEeksfks63IdFhhBPvMF459MthVyZVQddR9bYoW
	 G0YqrxbSNTyktZfQF4W350gyA/NWJD7ch285g1a8ShcyMg1gsDc14tacXyDKRdFz+4w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793386280;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Last-TLS-Session-Version;
	bh=x3i5tKbaIcpaKEBMwIFOWYmIWZiZXyyBPQVjaTT0ymA=;
	b=UZPUm8Pl6xHXl28dxCIImgdts/U5dto2Cm4S99J/B7sb2SMiH8UJURtrn3RXZkzw71YD
	 6IcRReA1ueuiunhhdZpffSbPb11YqvLfd1vL6iDXS1zpkfHbKnm+KiYjINkN6t2P918qs
	 b0twUDxKSfEu6guaM22t5qQKtYbms1/BuVQR3AAlKc5IaG/i1FsiWZv3Xt8mJ/gcg6OLL
	 5Hp2gdLOEovbP1y81pV/NAL4bDbJpmfSP9HGetQ5NBrbXUpqCW0NR51ci+iA6jv8syaNA
	 nqHn9yO7ASRrxhdZ4yWPutPoebwA8wGqh1IjKKWDvB2cOYGR04pxNuQCqbc23sTY1tw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=pBYxc9j9;
	arc=none smtp.remote-ip=185.246.84.56
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30578606A332
	for <bpf@vger.kernel.org>; Fri, 30 Oct 2026 18:51:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 30578606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=pBYxc9j9
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id D66F21A13D6;
	Fri, 30 Oct 2026 18:51:17 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id A460C603C2;
	Fri, 30 Oct 2026 18:51:17 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 530F1103290F9;
	Fri, 30 Oct 2026 19:51:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1793386276; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=x3i5tKbaIcpaKEBMwIFOWYmIWZiZXyyBPQVjaTT0ymA=;
	b=pBYxc9j9iuUEnGuZ2MTQ/jHDOWMx1CDFzEYVYeoaA/5FJe0jn6NHo2p50sqZi/+nB9MCRF
	+t4Nq+PvEGhWHqTM6S1E0I2EHgGjPKLGyZaxgjp9Px8CLYdaxyCswhd52AoCTHQ47HuGAa
	1E8kQ7e8OEvxCLkiOjZuo2NdtZiGBft/BB57ZggrjschADMztiydDBRaygsFkgGOzXCcoN
	z0Zc/E8g9dJOE66FpPqcamsMigOC81yQd+6WmkeX4/P3ziBOLEBH+jmsYnLnscZ64VYpDb
	NB4z8ZdkTRv8NYvx8MQNd6NlfKLlTjQydVfJL7UfG3iEIk6VkKCr7uJqP+C7gQ==
From: =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
Date: Fri, 30 Oct 2026 19:50:41 +0100
Subject: [PATCH bpf-next 2/2] selftests/bpf: port test_ftrace.sh to
 test_progs
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261030-ftrace_in_test_progs-v1-2-aa50c5dd1ccc@bootlin.com>
References: <20261030-ftrace_in_test_progs-v1-0-aa50c5dd1ccc@bootlin.com>
In-Reply-To: <20261030-ftrace_in_test_progs-v1-0-aa50c5dd1ccc@bootlin.com>
To: Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Ihor Solodrai <ihor.solodrai@linux.dev>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Emil Tsalapatis <emil@etsalapatis.com>, Shuah Khan <shuah@kernel.org>
Cc: ebpf@linuxfoundation.org, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
X-Mailer: b4 0.16.0
X-Last-TLS-Session-Version: TLSv1.3

Commit ff205766dbbe ("ftrace: Fix function_graph tracer interaction with
BPF trampoline") made sure that trampolines generated for tracing
programs did not collide with the function graph when we are returning
from the hooked function. The series bringing this commit also came with
a new test ensuring that the kernel does not crash when executing BPF
programs handled by trampolines while the function graph trace is
enabled, but this test is a standalone shell script, hence not executed
in CI.

Convert the script to the test_progs runner so it can be executed
automatically by the CI infrastructure. There are two main options to
port this test:
  - just enable ftrace during some existing trampoline-related tests
    (eg: fentry/fexit tests)
  - create a dedicated, minimal test with function graph

The new test adopts the latter approach, with a smaller scope to keep
execution time reasonable. On top of some simple fentry/fexit program,
it also adds a small fmod_ret program to ensure that return values are
correctly handled while the function graph enabled. Despite the few
asserts in the new test, the actual goal  is to make sure that the
kernel does not crash because of some incorrect stack frame skipping
when both the function graph and tracing programs are running.

ftrace is configured through the new ftrace helpers, and restored to its
original state afterward. Despite being restored afterward, it is
configured for the whole system, so the test is marked as serial_ to
avoid conflicts with other tests needing traces (eg trace_vprintk)

With the new test integrated into test_progs, drop test_ftrace.sh.

Signed-off-by: Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>
---
 .../selftests/bpf/prog_tests/fgraph_trampoline.c   | 129 +++++++++++++++++++++
 .../selftests/bpf/progs/fgraph_trampoline.c        |  29 +++++
 tools/testing/selftests/bpf/test_ftrace.sh         |  44 -------
 3 files changed, 158 insertions(+), 44 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/fgraph_trampoline.c b/tools/testing/selftests/bpf/prog_tests/fgraph_trampoline.c
new file mode 100644
index 000000000000..98edd77cf214
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/fgraph_trampoline.c
@@ -0,0 +1,129 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <test_progs.h>
+#include "trace_helpers.h"
+#include "fgraph_trampoline.skel.h"
+
+#define TRACER_GRAPH	"function_graph"
+
+#define FTRACE_NOTRACE	"*printk* *console* *wake* *serial* *lock*"
+#define GRAPH_FUNCS	"bpf_prog_test*"
+
+/* See test_run.c: we are overriding bpf_modify_return_test with a program
+ * returning 5, but not bpf_modify_return_test2
+ */
+#define FMOD_EXPECTED_RETVAL ((1 << 16) | (5 + 1 + 3 + 3 + 4 + 5 + 6 + 7))
+
+static int configure_tracer(struct tracefs_ctl *ftrace)
+{
+	int err;
+
+	err = tracefs_ctl_filter_write(ftrace, "set_ftrace_filter", "");
+	if (err)
+		return err;
+	err = tracefs_ctl_filter_write(ftrace, "set_ftrace_notrace",
+				       FTRACE_NOTRACE);
+	if (err)
+		return err;
+	err = tracefs_ctl_filter_write(ftrace, "set_graph_function", GRAPH_FUNCS);
+	if (err)
+		return err;
+	err = tracefs_ctl_filter_write(ftrace, "set_graph_notrace", "");
+	if (err)
+		return err;
+	err = tracefs_ctl_set(ftrace, "current_tracer", TRACER_GRAPH);
+	if (err)
+		return err;
+
+	return err;
+}
+
+static int run_test_under_ftrace_graph(struct tracefs_ctl *ftrace,
+				       struct bpf_program *prog, int *retval)
+{
+	LIBBPF_OPTS(bpf_test_run_opts, opts);
+	int err, stop_err;
+
+	err = tracefs_ctl_set(ftrace, "tracing_on", "1");
+	if (err)
+		return err;
+
+	err = bpf_prog_test_run_opts(bpf_program__fd(prog), &opts);
+	if (retval)
+		*retval = opts.retval;
+
+	stop_err = tracefs_ctl_set(ftrace, "tracing_on", "0");
+	if (!err)
+		err = stop_err;
+
+	return err;
+}
+
+void serial_test_fgraph_trampoline(void)
+{
+	struct fgraph_trampoline *skel = NULL;
+	struct tracefs_ctl *ftrace;
+	int retval;
+
+	ftrace = tracefs_ctl_init();
+	if (!ASSERT_OK_PTR(ftrace, "tracefs_ctl_init"))
+		return;
+
+	if (configure_tracer(ftrace)) {
+		test__skip();
+		tracefs_ctl_restore(ftrace);
+		goto cleanup;
+	}
+
+	skel = fgraph_trampoline__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "fgraph_trampoline__open_and_load"))
+		goto cleanup;
+
+	if (test__start_subtest("no_trampoline")) {
+		ASSERT_OK(run_test_under_ftrace_graph(ftrace,
+						      skel->progs.fentry_test1,
+						      NULL),
+			  "run test no trampoline");
+	}
+
+	if (test__start_subtest("attach_fentry_fexit")) {
+		skel->links.fentry_test1 =
+			bpf_program__attach(skel->progs.fentry_test1);
+		if (!ASSERT_OK_PTR(skel->links.fentry_test1, "attach_fentry"))
+			goto destroy_cleanup;
+		skel->links.fexit_test1 =
+			bpf_program__attach(skel->progs.fexit_test1);
+		if (!ASSERT_OK_PTR(skel->links.fexit_test1, "attach_fexit"))
+			goto destroy_cleanup;
+
+		memset(skel->bss, 0, sizeof(*skel->bss));
+		ASSERT_OK(run_test_under_ftrace_graph(ftrace,
+						      skel->progs.fentry_test1,
+						      NULL),
+			  "run test with fentry and fexit");
+
+		ASSERT_EQ(skel->bss->fexit_result, 1, "fexit_result");
+
+		fgraph_trampoline__detach(skel);
+	}
+
+	if (test__start_subtest("attach_fmod_ret")) {
+		skel->links.fmod_ret_test =
+			bpf_program__attach(skel->progs.fmod_ret_test);
+		if (!ASSERT_OK_PTR(skel->links.fmod_ret_test, "attach_fmod_ret"))
+			goto destroy_cleanup;
+
+		ASSERT_OK(run_test_under_ftrace_graph(ftrace,
+						      skel->progs.fmod_ret_test,
+						      &retval),
+			  "run test with fmod_ret");
+		ASSERT_EQ(retval, FMOD_EXPECTED_RETVAL, "fmod return value");
+
+		fgraph_trampoline__detach(skel);
+	}
+
+destroy_cleanup:
+	fgraph_trampoline__destroy(skel);
+cleanup:
+	tracefs_ctl_restore(ftrace);
+}
diff --git a/tools/testing/selftests/bpf/progs/fgraph_trampoline.c b/tools/testing/selftests/bpf/progs/fgraph_trampoline.c
new file mode 100644
index 000000000000..1cc2dadc817e
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/fgraph_trampoline.c
@@ -0,0 +1,29 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+__u64 fexit_result;
+
+SEC("fentry/bpf_fentry_test1")
+int BPF_PROG(fentry_test1, int a)
+{
+	return 0;
+}
+
+SEC("fexit/bpf_fentry_test1")
+int BPF_PROG(fexit_test1, int a, int ret)
+{
+	fexit_result = (a == 1 && ret == 2);
+	return 0;
+}
+
+SEC("fmod_ret/bpf_modify_return_test")
+int BPF_PROG(fmod_ret_test, int a, int *b, int ret)
+{
+	return 5;
+}
+
+char _license[] SEC("license") = "GPL";
+
diff --git a/tools/testing/selftests/bpf/test_ftrace.sh b/tools/testing/selftests/bpf/test_ftrace.sh
deleted file mode 100755
index f5109eb0e951..000000000000
--- a/tools/testing/selftests/bpf/test_ftrace.sh
+++ /dev/null
@@ -1,44 +0,0 @@
-#!/bin/bash
-
-if [[ -e /sys/kernel/tracing/trace ]]; then
-    TR=/sys/kernel/tracing/
-else
-    TR=/sys/kernel/debug/tracing/
-fi
-
-clear_trace() { # reset trace output
-    echo > $TR/trace
-}
-
-disable_tracing() { # stop trace recording
-    echo 0 > $TR/tracing_on
-}
-
-enable_tracing() { # start trace recording
-    echo 1 > $TR/tracing_on
-}
-
-reset_tracer() { # reset the current tracer
-    echo nop > $TR/current_tracer
-}
-
-disable_tracing
-clear_trace
-
-echo "" > $TR/set_ftrace_filter
-echo '*printk* *console* *wake* *serial* *lock*' > $TR/set_ftrace_notrace
-
-echo "bpf_prog_test*" > $TR/set_graph_function
-echo "" > $TR/set_graph_notrace
-
-echo function_graph > $TR/current_tracer
-
-enable_tracing
-./test_progs -t fentry
-./test_progs -t fexit
-disable_tracing
-clear_trace
-
-reset_tracer
-
-exit 0

-- 
2.56.0

