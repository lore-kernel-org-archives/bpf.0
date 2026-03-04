Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B43F3264F5;
	Wed,  4 Mar 2026 22:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772663119; cv=none; b=BKgA0OwqVHwVUOmkjLSNqpEytsoL7i9nZIjWX5qg7EnPY5zGPw7W97+7XYRuzR8QKpcWd7Gi1hR/Sy39PPUZ/N4GruLyGNREGaAdTyR/kHD+mwI4mY3bnH7LWt4ajoA4C43VCdmWpvQ6lJUmSyISGjaeCi9MenbLuRI3QlZ70cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772663119; c=relaxed/simple;
	bh=PT77UrZbckmM6fk4qBEs7K6o5nDExOVO2tNGoHHUZuI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XcsjcgYbZmpk6JxDH88vQZFDB2b+ro2NJQLTcuHkvAGbzWNlXWvG4K+m511aQx5zxlC0r6iYACsD0pHxXFW8NxpW9QAVqJsFUfaEbaKMMS6xqGjwoZhiKbEsiQ+UZOWP9TKKt6NH3eEslaIKLIar+n/+eCdoBL7smCOkB+DEsPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EEpkOoon; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EEpkOoon"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBD1AC4CEF7;
	Wed,  4 Mar 2026 22:25:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772663118;
	bh=PT77UrZbckmM6fk4qBEs7K6o5nDExOVO2tNGoHHUZuI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EEpkOoonWPK2tH+N818h4NfF+XQ3fypOwhFDfRu2PbYdJHIImfEhU7GCIBcWT5Y96
	 ZpM5tIVpKlXWYaEV4jciqHI0UHtZsIDupj4zwFYTKIaea70UMxCaFq16Td10d089bn
	 Qhj5Wig7A0g3e035H6qvxdExhpaGzkKJwYBIQ5H4dtViX3l67hAi69vUtUWa5PsNSI
	 RyOojj81IeFRwkwmLYiUevzaEV7dWWXNmX9batsFCKFgGWyJVNfuTaOA2JN6oG3xFY
	 t50Q1Z1eD63X30BfhkyMx0YCeYjCSa8xMEcE5KzberXnpKoVnn1JyGeykH/Dtg2Htk
	 8XBeRjfU5qUDg==
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
Subject: [PATCHv2 bpf-next 20/23] selftests/bpf: Add tracing multi session test
Date: Wed,  4 Mar 2026 23:21:38 +0100
Message-ID: <20260304222141.497203-21-jolsa@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260304222141.497203-1-jolsa@kernel.org>
References: <20260304222141.497203-1-jolsa@kernel.org>
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
index ffcf7e120e5f..2d1680b83fe9 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -486,7 +486,8 @@ LINKED_SKELS := test_static_linked.skel.h linked_funcs.skel.h		\
 		test_subskeleton.skel.h test_subskeleton_lib.skel.h	\
 		test_usdt.skel.h tracing_multi.skel.h			\
 		tracing_multi_module.skel.h				\
-		tracing_multi_intersect.skel.h
+		tracing_multi_intersect.skel.h				\
+		tracing_multi_session.skel.h
 
 LSKELS := fexit_sleep.c trace_printk.c trace_vprintk.c map_ptr_kern.c 	\
 	core_kern.c core_kern_overflow.c test_ringbuf.c			\
@@ -515,6 +516,7 @@ xdp_features.skel.h-deps := xdp_features.bpf.o
 tracing_multi.skel.h-deps := tracing_multi_attach.bpf.o tracing_multi_check.bpf.o
 tracing_multi_module.skel.h-deps := tracing_multi_attach_module.bpf.o tracing_multi_check.bpf.o
 tracing_multi_intersect.skel.h-deps := tracing_multi_intersect_attach.bpf.o tracing_multi_check.bpf.o
+tracing_multi_session.skel.h-deps := tracing_multi_session_attach.bpf.o tracing_multi_check.bpf.o
 
 LINKED_BPF_OBJS := $(foreach skel,$(LINKED_SKELS),$($(skel)-deps))
 LINKED_BPF_SRCS := $(patsubst %.bpf.o,%.c,$(LINKED_BPF_OBJS))
diff --git a/tools/testing/selftests/bpf/prog_tests/tracing_multi.c b/tools/testing/selftests/bpf/prog_tests/tracing_multi.c
index a0266dd5670f..3a55a2aed9a0 100644
--- a/tools/testing/selftests/bpf/prog_tests/tracing_multi.c
+++ b/tools/testing/selftests/bpf/prog_tests/tracing_multi.c
@@ -7,6 +7,7 @@
 #include "tracing_multi.skel.h"
 #include "tracing_multi_module.skel.h"
 #include "tracing_multi_intersect.skel.h"
+#include "tracing_multi_session.skel.h"
 #include "trace_helpers.h"
 
 static __u64 bpf_fentry_test_cookies[] = {
@@ -442,6 +443,34 @@ static void test_intersect(void)
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
@@ -465,4 +494,6 @@ void test_tracing_multi_test(void)
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
2.53.0

