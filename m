Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1102743DA49;
	Wed,  3 Jun 2026 11:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780485034; cv=none; b=lGKDzFXFT11CmtvyA44e5b3f5Sdg79iEyNOiLl/QHQAy8dhZyBtSoDYHXjf7+vaXTFz4T9us9v8zvxTWooRRjyy5ClVvKj4OQnSNM+9GMZpkynUDWrHWVWjcvwPYjHahKVuNPEIBS1iUEs+CFSl3n5bGQnneWkCRNlzx5VptMYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780485034; c=relaxed/simple;
	bh=MvyMiv8o4xPJR61Quorr+tcWVAHulEJqNEn4KTJI9EU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OCuL+iKNnIA7qBA+8wrIYwDujBCUSOwjXAzmGTOE5c4YmtKAP3VTvx/TZW2M9pizx8Nw38hKsn76NOnSZxxiz5Dy9EoMgX4YocGtAH6UJiT3WwMykduo95a1VjNX5uXwsOnIZIe+N7KpU8Yd2ojcdHR5PAR1vB8kwZ2rMoX5clE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LXQ3J81p; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LXQ3J81p"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CF321F00893;
	Wed,  3 Jun 2026 11:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780485033;
	bh=7oOln2h/vD8iv8UyuBucrIYf9TxlG1VOVMgbL017ohU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LXQ3J81pAQmBbS2giD9gr+HQU/AohmBYneRj3RyS20foqDYHXJgKUw9Cypf6fT55F
	 CTM36G1CVDWuTj0YzRQNvd4kEKdBpKN63WLKQdff/jkPOkHA4AtIgNYK3ptz+jzNb9
	 WcIrFG9kWQt5zHXvg44kH+jA2kNYd93WmfAeyJgj6wdoMZtRnd1QFOb6nlfF34hBrU
	 V2oNiBL1yaKna4Q3n08I9NbX5KhCETtlEKgucMyd6Yvcv+pZi40rx6T0gRHdOXaU/T
	 PNnaOEp9G9SirpHERXHdc1clqdswwj8a/+JdDAMCS00m55G+sB144dMCrPZNqv5UUQ
	 PVHOfOeWW6/iw==
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
Subject: [PATCHv7 bpf-next 25/29] selftests/bpf: Add tracing multi session test
Date: Wed,  3 Jun 2026 13:05:49 +0200
Message-ID: <20260603110554.29590-26-jolsa@kernel.org>
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

Adding tests for tracing multi link session.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/testing/selftests/bpf/Makefile          |  4 +-
 .../selftests/bpf/prog_tests/tracing_multi.c  | 45 +++++++++++++
 .../bpf/progs/tracing_multi_session_attach.c  | 65 +++++++++++++++++++
 3 files changed, 113 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/progs/tracing_multi_session_attach.c

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 95b87cba46bc..30ad24bb7054 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -502,7 +502,8 @@ LINKED_SKELS := test_static_linked.skel.h linked_funcs.skel.h		\
 		test_subskeleton.skel.h test_subskeleton_lib.skel.h	\
 		test_usdt.skel.h tracing_multi.skel.h			\
 		tracing_multi_module.skel.h				\
-		tracing_multi_intersect.skel.h
+		tracing_multi_intersect.skel.h				\
+		tracing_multi_session.skel.h
 
 LSKELS := fexit_sleep.c trace_printk.c trace_vprintk.c map_ptr_kern.c 	\
 	core_kern.c core_kern_overflow.c test_ringbuf.c			\
@@ -531,6 +532,7 @@ xdp_features.skel.h-deps := xdp_features.bpf.o
 tracing_multi.skel.h-deps := tracing_multi_attach.bpf.o tracing_multi_check.bpf.o
 tracing_multi_module.skel.h-deps := tracing_multi_attach_module.bpf.o tracing_multi_check.bpf.o
 tracing_multi_intersect.skel.h-deps := tracing_multi_intersect_attach.bpf.o tracing_multi_check.bpf.o
+tracing_multi_session.skel.h-deps := tracing_multi_session_attach.bpf.o tracing_multi_check.bpf.o
 
 LINKED_BPF_OBJS := $(foreach skel,$(LINKED_SKELS),$($(skel)-deps))
 LINKED_BPF_SRCS := $(patsubst %.bpf.o,%.c,$(LINKED_BPF_OBJS))
diff --git a/tools/testing/selftests/bpf/prog_tests/tracing_multi.c b/tools/testing/selftests/bpf/prog_tests/tracing_multi.c
index 0f066063cb82..05683b8d0680 100644
--- a/tools/testing/selftests/bpf/prog_tests/tracing_multi.c
+++ b/tools/testing/selftests/bpf/prog_tests/tracing_multi.c
@@ -7,6 +7,7 @@
 #include "tracing_multi.skel.h"
 #include "tracing_multi_module.skel.h"
 #include "tracing_multi_intersect.skel.h"
+#include "tracing_multi_session.skel.h"
 #include "trace_helpers.h"
 
 static __u64 bpf_fentry_test_cookies[] = {
@@ -455,6 +456,48 @@ static void test_intersect(void)
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
+	/* 10 for test_session_1, 1 for test_fsession_s */
+	ASSERT_EQ(skel->bss->test_result_fentry, 11, "test_result_fentry");
+	/* extra count (+1 for each fexit execution) for test_result_fexit cookie check/inc */
+	ASSERT_EQ(skel->bss->test_result_fexit, 22, "test_result_fexit");
+
+	skel->bss->test_result_fentry = 0;
+	skel->bss->test_result_fexit = 0;
+
+	/* execute bpf_testmo.ko session */
+	ASSERT_OK(trigger_module_test_read(1), "trigger_read");
+
+	/* 5 for test_session_2 */
+	ASSERT_EQ(skel->bss->test_result_fentry, 5, "test_result_fentry");
+	/* extra count (+1 for each fexit execution) for test_result_fexit cookie */
+	ASSERT_EQ(skel->bss->test_result_fexit, 10, "test_result_fexit");
+
+
+cleanup:
+	tracing_multi_session__destroy(skel);
+}
+
 void test_tracing_multi_test(void)
 {
 #ifndef __x86_64__
@@ -478,4 +521,6 @@ void test_tracing_multi_test(void)
 		test_intersect();
 	if (test__start_subtest("cookies"))
 		test_link_api_ids(true);
+	if (test__start_subtest("session"))
+		test_session();
 }
diff --git a/tools/testing/selftests/bpf/progs/tracing_multi_session_attach.c b/tools/testing/selftests/bpf/progs/tracing_multi_session_attach.c
new file mode 100644
index 000000000000..7c9a46016ccd
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/tracing_multi_session_attach.c
@@ -0,0 +1,65 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+char _license[] SEC("license") = "GPL";
+
+__hidden extern int tracing_multi_arg_check(__u64 *ctx, __u64 *test_result, bool is_return);
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
+		if (tracing_multi_arg_check(ctx, &test_result_fexit, true))
+			return 0;
+		/* extra count for test_result_fexit cookie */
+		test_result_fexit += *cookie == 0xbeafbeafbeafbeaf;
+	} else {
+		if (tracing_multi_arg_check(ctx, &test_result_fentry, false))
+			return 0;
+		*cookie = 0xbeafbeafbeafbeaf;
+	}
+	return 0;
+}
+
+SEC("fsession.multi.s/bpf_fentry_test1")
+int BPF_PROG(test_fsession_s)
+{
+	volatile __u64 *cookie = bpf_session_cookie(ctx);
+
+	if (bpf_session_is_return(ctx)) {
+		if (tracing_multi_arg_check(ctx, &test_result_fexit, true))
+			return 0;
+		/* extra count for test_result_fexit cookie */
+		test_result_fexit += *cookie == 0xbeafbeafbeafbeaf;
+	} else {
+		if (tracing_multi_arg_check(ctx, &test_result_fentry, false))
+			return 0;
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
+		if (tracing_multi_arg_check(ctx, &test_result_fexit, true))
+			return 0;
+		/* extra count for test_result_fexit cookie */
+		test_result_fexit += *cookie == 0xbeafbeafbeafbeaf;
+	} else {
+		if (tracing_multi_arg_check(ctx, &test_result_fentry, false))
+			return 0;
+		*cookie = 0xbeafbeafbeafbeaf;
+	}
+	return 0;
+}
-- 
2.54.0

