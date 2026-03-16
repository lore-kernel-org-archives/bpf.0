Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4B683537E8;
	Mon, 16 Mar 2026 07:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773647728; cv=none; b=n/8rFrv+JwcBfya2Lwi5gemCmfLHQkISypQHC7sag4wb912amjmVBzEUBGLu+f5zunwlTCivGKPEuiXUxjz8xIWZ2Ibi7Q/bFfwJooQ28G3MfPSmDRG8M0sUToCLXCs7/xse14xQazkW0NAPcw1O1niZl7DZscRex1eBJNC/4Fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773647728; c=relaxed/simple;
	bh=GUJxft45e/pFp52LPbGCiUtIvL4Mvs4afmDPSzfwpJc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LyoLv1izKlEqamuAMqFftWedCwA9AuVO6XCi7FDYGGboaioPwv+dBz7ob9JfDY2JOr76hlqN6m9v3Iz+/pxG/1vQY1KB1ZoMR98j2UnzA0uN2V5ZW7tnqqh9cK4sL9O++bp+JXJ5eSGpondVYfYdzWa7RrmIIJ/7V/vx9TjnFEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I25+Qw2S; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I25+Qw2S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A19CC19421;
	Mon, 16 Mar 2026 07:55:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773647728;
	bh=GUJxft45e/pFp52LPbGCiUtIvL4Mvs4afmDPSzfwpJc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=I25+Qw2S7z3xhNjIGjGff4U523tCBdjymq35fh0pgK3Watj/trC9ypWt3baDHuIWf
	 Vea5otvrhvUH0G2LG/Oy9fzsBfR1s2eW7tS/6PdQU6NO+nwLECSQCRc/CaHyshtGBC
	 Wr+vHH/IFmLgIOva+uAIGquGclkYLnhUhei6dYgYLJZvtu19zCyRO/o0nMW6F63lX8
	 P3kdKIIRddFHyTfVk2E6v8dqwft13fUdyvqxURW5HbD2kU5457H3HDIGa2Kr4DDoQI
	 IMAZxk6Hy7L28twz6+tHYK8MaM7EDXX2UuycOIdKr+87mUllD9K6YitKYJ2j4AI9cl
	 3EbC7s0cUpFZQ==
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
Subject: [PATCHv3 bpf-next 21/24] selftests/bpf: Add tracing multi session test
Date: Mon, 16 Mar 2026 08:51:35 +0100
Message-ID: <20260316075138.465430-22-jolsa@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260316075138.465430-1-jolsa@kernel.org>
References: <20260316075138.465430-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adding tests for tracing multi link session.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/testing/selftests/bpf/Makefile          |  4 +-
 .../selftests/bpf/prog_tests/tracing_multi.c  | 40 +++++++++++++++++
 .../bpf/progs/tracing_multi_session_attach.c  | 43 +++++++++++++++++++
 3 files changed, 86 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/progs/tracing_multi_session_attach.c

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index e56e213441d8..bde0d62c147c 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -487,7 +487,8 @@ LINKED_SKELS := test_static_linked.skel.h linked_funcs.skel.h		\
 		test_subskeleton.skel.h test_subskeleton_lib.skel.h	\
 		test_usdt.skel.h tracing_multi.skel.h			\
 		tracing_multi_module.skel.h				\
-		tracing_multi_intersect.skel.h
+		tracing_multi_intersect.skel.h				\
+		tracing_multi_session.skel.h
 
 LSKELS := fexit_sleep.c trace_printk.c trace_vprintk.c map_ptr_kern.c 	\
 	core_kern.c core_kern_overflow.c test_ringbuf.c			\
@@ -516,6 +517,7 @@ xdp_features.skel.h-deps := xdp_features.bpf.o
 tracing_multi.skel.h-deps := tracing_multi_attach.bpf.o tracing_multi_check.bpf.o
 tracing_multi_module.skel.h-deps := tracing_multi_attach_module.bpf.o tracing_multi_check.bpf.o
 tracing_multi_intersect.skel.h-deps := tracing_multi_intersect_attach.bpf.o tracing_multi_check.bpf.o
+tracing_multi_session.skel.h-deps := tracing_multi_session_attach.bpf.o tracing_multi_check.bpf.o
 
 LINKED_BPF_OBJS := $(foreach skel,$(LINKED_SKELS),$($(skel)-deps))
 LINKED_BPF_SRCS := $(patsubst %.bpf.o,%.c,$(LINKED_BPF_OBJS))
diff --git a/tools/testing/selftests/bpf/prog_tests/tracing_multi.c b/tools/testing/selftests/bpf/prog_tests/tracing_multi.c
index f14a936a4667..04d83c37495b 100644
--- a/tools/testing/selftests/bpf/prog_tests/tracing_multi.c
+++ b/tools/testing/selftests/bpf/prog_tests/tracing_multi.c
@@ -7,6 +7,7 @@
 #include "tracing_multi.skel.h"
 #include "tracing_multi_module.skel.h"
 #include "tracing_multi_intersect.skel.h"
+#include "tracing_multi_session.skel.h"
 #include "trace_helpers.h"
 
 static __u64 bpf_fentry_test_cookies[] = {
@@ -442,6 +443,43 @@ static void test_intersect(void)
 	tracing_multi_intersect__destroy(skel);
 }
 
+static void test_session(void)
+{
+	LIBBPF_OPTS(bpf_test_run_opts, topts);
+	struct tracing_multi_session *skel;
+	int err, prog_fd;
+
+	skel = tracing_multi_session__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "tracing_multi_session__open_and_load"))
+		return;
+
+	skel->bss->pid = getpid();
+
+	err = tracing_multi_session__attach(skel);
+	if (!ASSERT_OK(err, "tracing_multi_session__attach"))
+		goto cleanup;
+
+	/* execute kernel session */
+	prog_fd = bpf_program__fd(skel->progs.test_session_1);
+	err = bpf_prog_test_run_opts(prog_fd, &topts);
+	ASSERT_OK(err, "test_run");
+
+	ASSERT_EQ(skel->bss->test_result_fentry, 10, "test_result_fentry");
+	/* extra count (+1 for each fexit execution) for test_result_fexit cookie */
+	ASSERT_EQ(skel->bss->test_result_fexit, 20, "test_result_fexit");
+
+	/* execute bpf_testmo.ko session */
+	ASSERT_OK(trigger_module_test_read(1), "trigger_read");
+
+	ASSERT_EQ(skel->bss->test_result_fentry, 15, "test_result_fentry");
+	/* extra count (+1 for each fexit execution) for test_result_fexit cookie */
+	ASSERT_EQ(skel->bss->test_result_fexit, 30, "test_result_fexit");
+
+
+cleanup:
+	tracing_multi_session__destroy(skel);
+}
+
 void test_tracing_multi_test(void)
 {
 #ifndef __x86_64__
@@ -465,4 +503,6 @@ void test_tracing_multi_test(void)
 		test_intersect();
 	if (test__start_subtest("cookies"))
 		test_link_api_ids(true);
+	if (test__start_subtest("session"))
+		test_session();
 }
diff --git a/tools/testing/selftests/bpf/progs/tracing_multi_session_attach.c b/tools/testing/selftests/bpf/progs/tracing_multi_session_attach.c
new file mode 100644
index 000000000000..c9e005939d74
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/tracing_multi_session_attach.c
@@ -0,0 +1,43 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+char _license[] SEC("license") = "GPL";
+
+__hidden extern void tracing_multi_arg_check(__u64 *ctx, __u64 *test_result, bool is_return);
+
+__u64 test_result_fentry = 0;
+__u64 test_result_fexit = 0;
+
+SEC("fsession.multi/bpf_fentry_test*")
+int BPF_PROG(test_session_1)
+{
+	volatile __u64 *cookie = bpf_session_cookie(ctx);
+
+	if (bpf_session_is_return(ctx)) {
+		tracing_multi_arg_check(ctx, &test_result_fexit, true);
+		/* extra count for test_result_fexit cookie */
+		test_result_fexit += *cookie == 0xbeafbeafbeafbeaf;
+	} else {
+		tracing_multi_arg_check(ctx, &test_result_fentry, false);
+		*cookie = 0xbeafbeafbeafbeaf;
+	}
+	return 0;
+}
+
+SEC("fsession.multi/bpf_testmod:bpf_testmod_fentry_test*")
+int BPF_PROG(test_session_2)
+{
+	volatile __u64 *cookie = bpf_session_cookie(ctx);
+
+	if (bpf_session_is_return(ctx)) {
+		tracing_multi_arg_check(ctx, &test_result_fexit, true);
+		/* extra count for test_result_fexit cookie */
+		test_result_fexit += *cookie == 0xbeafbeafbeafbeaf;
+	} else {
+		tracing_multi_arg_check(ctx, &test_result_fentry, false);
+		*cookie = 0xbeafbeafbeafbeaf;
+	}
+	return 0;
+}
-- 
2.53.0

