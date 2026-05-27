Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CBE93557F3;
	Wed, 27 May 2026 11:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779882261; cv=none; b=Xd33wqMrmmcVwzdnrBUIykYt1jiTRa4nKEA6JA/r0Jbq0zZ+XmuHAAQnxwb7Mlm1/MHzfjPyUAoIgqn2Tkoddbfr08bXv95C9NZBJTCKLB2xTolH1S9D5HhRerZ7okipzdN43YKxrHOZfGnXCg2jTUSeDiADhWzORJuIvlEQsH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779882261; c=relaxed/simple;
	bh=3UO4jn27A3mevzQ3+8L6rNz8codnyOglySvMe11uYxg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kAZ5B+d0/XJEb/F1NIZZc51oZhjYo0EuXhg4UZAFlURoi41a/bBBj4q5U62KlClt5H4cBrp7DJ6RRqLkO09pplLAGAydlNEPVQZBzJ9uX3gLjrIJ6zPUfsbqjN0IkOhjh1QXenHkPQ6wuLv7oNwg5d+hVT9tNhKk0U+Uax90NPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AwGGRPTm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AwGGRPTm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C7C31F00A3A;
	Wed, 27 May 2026 11:44:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779882259;
	bh=SnVfxmEA9AR/aqzVezlLFL7L7mQEsvVEAo2jy3FqvMk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AwGGRPTmkNPqHCBYWXxraFT+u31PWmQekk/qPH8RFPB3wuyzEzXrRdDcNIp2XuByI
	 5NmQKd4I1Z3DjCqk5ragYk7NsqTuJOHoQtmg7Bn95ejrEJhES7QVa1S7GENY89zVm+
	 EGyCHpYY4a+lTOBfZncbH0IdvRPsdGISY5xbKVeiLLWjsX6q31q/I7Tx2Gd519VI+M
	 ARPXfoqPWG3EV4bFKEZ9GSYsOCQ2k6+2l2K0YOWZTG/sCksE2aWbNuyRmXu7vGQu0c
	 iR0iUOncZh96S+Ynli7BatmXZ3D2upFHkZ9yyQoAFKsUM2ZCmyURFemLkTuOkhIL+X
	 l0ZNhRhSk9qpQ==
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
Subject: [PATCHv6 bpf-next 25/29] selftests/bpf: Add tracing multi session test
Date: Wed, 27 May 2026 13:39:47 +0200
Message-ID: <20260527113951.46265-26-jolsa@kernel.org>
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

Adding tests for tracing multi link session.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/testing/selftests/bpf/Makefile          |  4 +-
 .../selftests/bpf/prog_tests/tracing_multi.c  | 40 ++++++++++++++++
 .../bpf/progs/tracing_multi_session_attach.c  | 47 +++++++++++++++++++
 3 files changed, 90 insertions(+), 1 deletion(-)
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
index f27c086d3f78..202005f2dbeb 100644
--- a/tools/testing/selftests/bpf/prog_tests/tracing_multi.c
+++ b/tools/testing/selftests/bpf/prog_tests/tracing_multi.c
@@ -7,6 +7,7 @@
 #include "tracing_multi.skel.h"
 #include "tracing_multi_module.skel.h"
 #include "tracing_multi_intersect.skel.h"
+#include "tracing_multi_session.skel.h"
 #include "trace_helpers.h"
 
 static __u64 bpf_fentry_test_cookies[] = {
@@ -454,6 +455,43 @@ static void test_intersect(void)
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
@@ -477,4 +515,6 @@ void test_tracing_multi_test(void)
 		test_intersect();
 	if (test__start_subtest("cookies"))
 		test_link_api_ids(true);
+	if (test__start_subtest("session"))
+		test_session();
 }
diff --git a/tools/testing/selftests/bpf/progs/tracing_multi_session_attach.c b/tools/testing/selftests/bpf/progs/tracing_multi_session_attach.c
new file mode 100644
index 000000000000..4dc9bce96097
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/tracing_multi_session_attach.c
@@ -0,0 +1,47 @@
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

