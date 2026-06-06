Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C794A379EDA;
	Sat,  6 Jun 2026 12:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780749854; cv=none; b=p/HLFNnOlb0+svVsqNRrswJeBg2eDcFxk4h0XWbDn4+Ir7IZBC4+Mm0Ygt4JBGIjma14yMUkvgYzvO9HKc/wWkjLN9muxTveezohDmmf3pAZztanCCKKlLlFKmO4f/Ey+hDTsMgjZ7F0xEHTNSoUGiqtI3cgDxU01/4GLPGoNT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780749854; c=relaxed/simple;
	bh=biiHzeawdsL9urUpgUCwdfkW86VPl9RCg3+TudS1ScQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d4EIJ1zYVjlonTi0NAFzrf29AoxhcujouP7tMfCZejFWC07QlCcy8Htkj6IpoYK6xEmtlvmqpIZg+FcU4D9NmRAUIsapcqLiW47iKebYg8wh2aqB+DVyeixHZYNy+nK73DJmcAOTAS3bB56BvLaon5tH7TmaIMplwxvwKLe32v4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lz6u+feg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lz6u+feg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD8411F00893;
	Sat,  6 Jun 2026 12:44:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780749853;
	bh=xJ61ayjsf3l1Fq2OOkwYHK/hMtUwa4/GjcmxELayIOQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Lz6u+fegw3Q3hSeW98k9s1lytnjOrZ6G+9TuTzZBc/1bsj9SnI9b64WsGb+rTYeJw
	 3GZS4DADcEoqaMKStt2Z/YhIy4X6WVpM2K1RQDOULbJj2w4CS+S6sgK9O/5mdAsIeF
	 JwdDla5jWyKwniwOEHrb+4xlqYVFoD0AxOfH8/hLFAMK/+I+5BHN7N3EnVv6mdSEiS
	 XNCiuBMB8uIK4XwaQw4MFZuzUZypSLWGFASV9Yx69XIl6i+v8G4xeF2Qp/iGAX4lvw
	 bDM79Vxa+1uUk9ae5Wp/CrlItTpQ+4j+FlQbv0Kl6CnJGVhrcfHU07uPesMjSUHgfW
	 Z69uLG4qOuLxw==
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
Subject: [PATCHv8 bpf-next 25/29] selftests/bpf: Add tracing multi session test
Date: Sat,  6 Jun 2026 14:39:50 +0200
Message-ID: <20260606123955.345967-26-jolsa@kernel.org>
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

Adding tests for tracing multi link session.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/testing/selftests/bpf/Makefile          |  4 +-
 .../selftests/bpf/prog_tests/tracing_multi.c  | 45 +++++++++++++
 .../bpf/progs/tracing_multi_session_attach.c  | 65 +++++++++++++++++++
 3 files changed, 113 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/progs/tracing_multi_session_attach.c

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 2b5688c97006..d53b7e496ac9 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -514,7 +514,8 @@ LINKED_SKELS := test_static_linked.skel.h linked_funcs.skel.h		\
 		test_subskeleton.skel.h test_subskeleton_lib.skel.h	\
 		test_usdt.skel.h tracing_multi.skel.h			\
 		tracing_multi_module.skel.h				\
-		tracing_multi_intersect.skel.h
+		tracing_multi_intersect.skel.h				\
+		tracing_multi_session.skel.h
 
 LSKELS := fexit_sleep.c trace_printk.c trace_vprintk.c map_ptr_kern.c 	\
 	core_kern.c core_kern_overflow.c test_ringbuf.c			\
@@ -543,6 +544,7 @@ xdp_features.skel.h-deps := xdp_features.bpf.o
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

