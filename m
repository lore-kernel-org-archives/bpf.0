Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE39E3375CF;
	Fri, 20 Feb 2026 10:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771582220; cv=none; b=gLeEftJXfWwjczDKhnmqNaQodzWRzpNW63YRF30V28oZFq4qzqyKibEgvRfOQTNFmZGvEj/IuAdv00vfdju0Z8ZmR88765bsWyeTLol7A3rkEYc1wwW8rHZLlBcA4cY0grcHgmHqr3F7g0/57DfaRnrBg2rtn5F7tiPWm557fXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771582220; c=relaxed/simple;
	bh=sevu5MP/a6O8f0Td9az3iPdWIuwqxZF316et63Q/peM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JGQU4cZ1OMjklkvjrvZYiqzcsvmq+j1B4N9qPixugThtn7uM8PZEwensATK4MyaFYD2L3yjxbtJloYTiWay053D42gupKijnMhpJelNiovJYFjC3xd3EC8ucCduwB0OPg3jwtAc51gkR3DvWlb3+wbKOsWrv1MNZ0N6P82A4USw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W2IoN0nc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W2IoN0nc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAFADC116C6;
	Fri, 20 Feb 2026 10:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771582220;
	bh=sevu5MP/a6O8f0Td9az3iPdWIuwqxZF316et63Q/peM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=W2IoN0nc8witL6GXh2CIdS+VCmx2rCyA/0Jpj1y9xJHbgbQkb0zI3j271eHWCK75/
	 Rgdz7horFF4fa1fu3TGZqGVle/wh2no5uQ4k+mKoxGozTngpeemEkx13QUiBAwVYAQ
	 dOECUUk1mBnv0IacwHy7wet+ZwhhPGieig31O310JK5tNIy2llxCLkjK3ib6rl+A2O
	 Y5S3b4icvbQV6w1Q8Id0J/5AWz3ZOL4UkzpyMBC5llffdVBUL0TT1ctmvOXy72+kCj
	 D/nXED4zXR5D5EJc/yYiBnfLk3CIH5alLhUTwvfLuGctEtmwIqTMcfJagZ2G9ofimG
	 8t2j/A0NpaT/w==
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
Subject: [PATCH bpf-next 15/17] selftests/bpf: Add tracing multi session test
Date: Fri, 20 Feb 2026 11:06:47 +0100
Message-ID: <20260220100649.628307-16-jolsa@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260220100649.628307-1-jolsa@kernel.org>
References: <20260220100649.628307-1-jolsa@kernel.org>
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
 tools/testing/selftests/bpf/Makefile          |  4 ++-
 .../selftests/bpf/prog_tests/tracing_multi.c  | 31 +++++++++++++++++++
 .../bpf/progs/tracing_multi_session_attach.c  | 27 ++++++++++++++++
 3 files changed, 61 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/progs/tracing_multi_session_attach.c

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 0cbc9bcb9a2e..b415d64bf0d1 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -482,7 +482,8 @@ LINKED_SKELS := test_static_linked.skel.h linked_funcs.skel.h		\
 		linked_vars.skel.h linked_maps.skel.h 			\
 		test_subskeleton.skel.h test_subskeleton_lib.skel.h	\
 		test_usdt.skel.h tracing_multi.skel.h			\
-		tracing_multi_intersect.skel.h
+		tracing_multi_intersect.skel.h				\
+		tracing_multi_session.skel.h
 
 LSKELS := fexit_sleep.c trace_printk.c trace_vprintk.c map_ptr_kern.c 	\
 	core_kern.c core_kern_overflow.c test_ringbuf.c			\
@@ -510,6 +511,7 @@ xdp_hw_metadata.skel.h-deps := xdp_hw_metadata.bpf.o
 xdp_features.skel.h-deps := xdp_features.bpf.o
 tracing_multi.skel.h-deps := tracing_multi_attach.bpf.o tracing_multi_check.bpf.o
 tracing_multi_intersect.skel.h-deps := tracing_multi_intersect_attach.bpf.o tracing_multi_check.bpf.o
+tracing_multi_session.skel.h-deps := tracing_multi_session_attach.bpf.o tracing_multi_check.bpf.o
 
 LINKED_BPF_OBJS := $(foreach skel,$(LINKED_SKELS),$($(skel)-deps))
 LINKED_BPF_SRCS := $(patsubst %.bpf.o,%.c,$(LINKED_BPF_OBJS))
diff --git a/tools/testing/selftests/bpf/prog_tests/tracing_multi.c b/tools/testing/selftests/bpf/prog_tests/tracing_multi.c
index 1bab4c3ea808..3d9327b80e88 100644
--- a/tools/testing/selftests/bpf/prog_tests/tracing_multi.c
+++ b/tools/testing/selftests/bpf/prog_tests/tracing_multi.c
@@ -6,6 +6,7 @@
 #include "bpf/libbpf_internal.h"
 #include "tracing_multi.skel.h"
 #include "tracing_multi_intersect.skel.h"
+#include "tracing_multi_session.skel.h"
 #include "trace_helpers.h"
 
 static __u64 bpf_fentry_test_cookies[] = {
@@ -311,6 +312,34 @@ static void test_intersect(void)
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
+	prog_fd = bpf_program__fd(skel->progs.test_session);
+	err = bpf_prog_test_run_opts(prog_fd, &topts);
+	ASSERT_OK(err, "test_run");
+
+	ASSERT_EQ(skel->bss->test_result_fentry, 10, "test_result_fentry");
+	/* extra count for test_result_fexit cookie */
+	ASSERT_EQ(skel->bss->test_result_fexit, 20, "test_result_fexit");
+
+cleanup:
+	tracing_multi_session__destroy(skel);
+}
+
 void test_tracing_multi_test(void)
 {
 #ifndef __x86_64__
@@ -328,4 +357,6 @@ void test_tracing_multi_test(void)
 		test_intersect();
 	if (test__start_subtest("cookies"))
 		test_link_api_ids(true);
+	if (test__start_subtest("session"))
+		test_session();
 }
diff --git a/tools/testing/selftests/bpf/progs/tracing_multi_session_attach.c b/tools/testing/selftests/bpf/progs/tracing_multi_session_attach.c
new file mode 100644
index 000000000000..9d717018a00f
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/tracing_multi_session_attach.c
@@ -0,0 +1,27 @@
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
+int BPF_PROG(test_session)
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
2.52.0

