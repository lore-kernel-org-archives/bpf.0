Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E74E03D1701;
	Tue, 24 Mar 2026 08:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774340532; cv=none; b=RO0eEcfVVnWkK+K7bbBWWv/XkDA3ItraG1dV90I6LW28x2T3GK5XmgSSFvB8Hfjq+yyNu9h18Uc9nOdD/UoEo+uMBFgcK8yPOeGbvWMoGYsvohPMBDxuBVdYk5+9dVcEubs5X6ogXCeD8nIrpP0hWh0yqv2yWM4wlWYyi0tEvgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774340532; c=relaxed/simple;
	bh=CpK7m6qSdrKyyARQmFWYpOMmneo6/fuwyiPCnocPZSQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jNJ2sSqEP79WfP9ikFx/MIFJPMHRE0ADW1uxeBWow8s+9CBvv96gwTXp3VNY8pF4m2nIY9AOp7EqSkK5mzcH/4RF0kqIcO3icFzjNM35fgfpuE+L+prjrBM+N0yCo5CwacwCBl6zdsLuts9ueNkJQZYGhY+sGlPw67lD2SSQjvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EAV9QWiK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EAV9QWiK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B777C4AF09;
	Tue, 24 Mar 2026 08:22:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774340531;
	bh=CpK7m6qSdrKyyARQmFWYpOMmneo6/fuwyiPCnocPZSQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EAV9QWiKH0RcBmkKod+V3q/da8e1lN0WYndyqWwMjdPIBIo1Tsa1LwTZdfvJmfL9p
	 A58h+KGzv62JTVGoHtum9Ys6Xar5Ecu7ybuegz8zKRMwDRoSAo1fsKXFlERjOhQnry
	 VJ/RaFfr+Dixsd2KSnoeRJVRJm4nwcNk/2dgIoMqIyU7XtJT2bH0RZQ3jVJtuzCkSK
	 X5PB3I+okmMO9OevOw2xscJEYI0tPQ72U1jZI3Cy3G+Dg+70k21+rt1DdMUJQCYnMX
	 3tPsI0WQA43E2DZw9MeC8z0T6d5QGsyH1/IiY1TNTZvyJYyUX0Q3c/IKml8DXT4Gco
	 H4aL31AX0SJnA==
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
Subject: [PATCHv4 bpf-next 19/25] selftests/bpf: Add tracing multi skel/pattern/ids module attach tests
Date: Tue, 24 Mar 2026 09:18:40 +0100
Message-ID: <20260324081846.2334094-20-jolsa@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260324081846.2334094-1-jolsa@kernel.org>
References: <20260324081846.2334094-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adding tests for tracing_multi link attachment via all possible
libbpf apis - skeleton, function pattern and btf ids on top of
bpf_testmod kernel module.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/testing/selftests/bpf/Makefile          |   4 +-
 .../selftests/bpf/prog_tests/tracing_multi.c  | 105 ++++++++++++++++++
 .../bpf/progs/tracing_multi_attach_module.c   |  25 +++++
 .../selftests/bpf/progs/tracing_multi_check.c |  50 +++++++++
 4 files changed, 183 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/progs/tracing_multi_attach_module.c

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 308c085bad08..59e2d1f8f5cc 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -493,7 +493,8 @@ SKEL_BLACKLIST := btf__% test_pinning_invalid.c test_sk_assign.c
 LINKED_SKELS := test_static_linked.skel.h linked_funcs.skel.h		\
 		linked_vars.skel.h linked_maps.skel.h 			\
 		test_subskeleton.skel.h test_subskeleton_lib.skel.h	\
-		test_usdt.skel.h tracing_multi.skel.h
+		test_usdt.skel.h tracing_multi.skel.h			\
+		tracing_multi_module.skel.h
 
 LSKELS := fexit_sleep.c trace_printk.c trace_vprintk.c map_ptr_kern.c 	\
 	core_kern.c core_kern_overflow.c test_ringbuf.c			\
@@ -520,6 +521,7 @@ xsk_xdp_progs.skel.h-deps := xsk_xdp_progs.bpf.o
 xdp_hw_metadata.skel.h-deps := xdp_hw_metadata.bpf.o
 xdp_features.skel.h-deps := xdp_features.bpf.o
 tracing_multi.skel.h-deps := tracing_multi_attach.bpf.o tracing_multi_check.bpf.o
+tracing_multi_module.skel.h-deps := tracing_multi_attach_module.bpf.o tracing_multi_check.bpf.o
 
 LINKED_BPF_OBJS := $(foreach skel,$(LINKED_SKELS),$($(skel)-deps))
 LINKED_BPF_SRCS := $(patsubst %.bpf.o,%.c,$(LINKED_BPF_OBJS))
diff --git a/tools/testing/selftests/bpf/prog_tests/tracing_multi.c b/tools/testing/selftests/bpf/prog_tests/tracing_multi.c
index fc22a2cf8c13..c533c1671d58 100644
--- a/tools/testing/selftests/bpf/prog_tests/tracing_multi.c
+++ b/tools/testing/selftests/bpf/prog_tests/tracing_multi.c
@@ -5,6 +5,7 @@
 #include <search.h>
 #include "bpf/libbpf_internal.h"
 #include "tracing_multi.skel.h"
+#include "tracing_multi_module.skel.h"
 #include "trace_helpers.h"
 
 static const char * const bpf_fentry_test[] = {
@@ -20,6 +21,14 @@ static const char * const bpf_fentry_test[] = {
 	"bpf_fentry_test10",
 };
 
+static const char * const bpf_testmod_fentry_test[] = {
+	"bpf_testmod_fentry_test1",
+	"bpf_testmod_fentry_test2",
+	"bpf_testmod_fentry_test3",
+	"bpf_testmod_fentry_test7",
+	"bpf_testmod_fentry_test11",
+};
+
 #define FUNCS_CNT (ARRAY_SIZE(bpf_fentry_test))
 
 static int compare(const void *ppa, const void *ppb)
@@ -236,6 +245,96 @@ static void test_link_api_ids(void)
 	free(ids);
 }
 
+static void test_module_skel_api(void)
+{
+	struct tracing_multi_module *skel = NULL;
+	int err;
+
+	skel = tracing_multi_module__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "tracing_multi__open_and_load"))
+		return;
+
+	skel->bss->pid = getpid();
+
+	err = tracing_multi_module__attach(skel);
+	if (!ASSERT_OK(err, "tracing_multi__attach"))
+		goto cleanup;
+
+	ASSERT_OK(trigger_module_test_read(1), "trigger_read");
+	ASSERT_EQ(skel->bss->test_result_fentry, 5, "test_result_fentry");
+	ASSERT_EQ(skel->bss->test_result_fexit, 5, "test_result_fexit");
+
+cleanup:
+	tracing_multi_module__destroy(skel);
+}
+
+static void test_module_link_api_pattern(void)
+{
+	struct tracing_multi_module *skel = NULL;
+
+	skel = tracing_multi_module__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "tracing_multi_module__open_and_load"))
+		return;
+
+	skel->bss->pid = getpid();
+
+	skel->links.test_fentry = bpf_program__attach_tracing_multi(skel->progs.test_fentry,
+					"bpf_testmod:bpf_testmod_fentry_test*", NULL);
+	if (!ASSERT_OK_PTR(skel->links.test_fentry, "bpf_program__attach_tracing_multi"))
+		goto cleanup;
+
+	skel->links.test_fexit = bpf_program__attach_tracing_multi(skel->progs.test_fexit,
+					"bpf_testmod:bpf_testmod_fentry_test*", NULL);
+	if (!ASSERT_OK_PTR(skel->links.test_fexit, "bpf_program__attach_tracing_multi"))
+		goto cleanup;
+
+	ASSERT_OK(trigger_module_test_read(1), "trigger_read");
+	ASSERT_EQ(skel->bss->test_result_fentry, 5, "test_result_fentry");
+	ASSERT_EQ(skel->bss->test_result_fexit, 5, "test_result_fexit");
+
+cleanup:
+	tracing_multi_module__destroy(skel);
+}
+
+static void test_module_link_api_ids(void)
+{
+	size_t cnt = ARRAY_SIZE(bpf_testmod_fentry_test);
+	LIBBPF_OPTS(bpf_tracing_multi_opts, opts);
+	struct tracing_multi_module *skel = NULL;
+	__u32 *ids;
+
+	skel = tracing_multi_module__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "tracing_multi_module__open_and_load"))
+		return;
+
+	skel->bss->pid = getpid();
+
+	ids = get_ids(bpf_testmod_fentry_test, cnt, "bpf_testmod");
+	if (!ASSERT_OK_PTR(ids, "get_ids"))
+		goto cleanup;
+
+	opts.ids = ids;
+	opts.cnt = cnt;
+
+	skel->links.test_fentry = bpf_program__attach_tracing_multi(skel->progs.test_fentry,
+						NULL, &opts);
+	if (!ASSERT_OK_PTR(skel->links.test_fentry, "bpf_program__attach_tracing_multi"))
+		goto cleanup;
+
+	skel->links.test_fexit = bpf_program__attach_tracing_multi(skel->progs.test_fexit,
+						NULL, &opts);
+	if (!ASSERT_OK_PTR(skel->links.test_fexit, "bpf_program__attach_tracing_multi"))
+		goto cleanup;
+
+	ASSERT_OK(trigger_module_test_read(1), "trigger_read");
+	ASSERT_EQ(skel->bss->test_result_fentry, 5, "test_result_fentry");
+	ASSERT_EQ(skel->bss->test_result_fexit, 5, "test_result_fexit");
+
+cleanup:
+	tracing_multi_module__destroy(skel);
+	free(ids);
+}
+
 void test_tracing_multi_test(void)
 {
 #ifndef __x86_64__
@@ -249,4 +348,10 @@ void test_tracing_multi_test(void)
 		test_link_api_pattern();
 	if (test__start_subtest("link_api_ids"))
 		test_link_api_ids();
+	if (test__start_subtest("module_skel_api"))
+		test_module_skel_api();
+	if (test__start_subtest("module_link_api_pattern"))
+		test_module_link_api_pattern();
+	if (test__start_subtest("module_link_api_ids"))
+		test_module_link_api_ids();
 }
diff --git a/tools/testing/selftests/bpf/progs/tracing_multi_attach_module.c b/tools/testing/selftests/bpf/progs/tracing_multi_attach_module.c
new file mode 100644
index 000000000000..ad9e0a5fda4e
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/tracing_multi_attach_module.c
@@ -0,0 +1,25 @@
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
+SEC("fentry.multi/bpf_testmod:bpf_testmod_fentry_test*")
+int BPF_PROG(test_fentry)
+{
+	tracing_multi_arg_check(ctx, &test_result_fentry, false);
+	return 0;
+}
+
+SEC("fexit.multi/bpf_testmod:bpf_testmod_fentry_test*")
+int BPF_PROG(test_fexit)
+{
+	tracing_multi_arg_check(ctx, &test_result_fexit, true);
+	return 0;
+}
diff --git a/tools/testing/selftests/bpf/progs/tracing_multi_check.c b/tools/testing/selftests/bpf/progs/tracing_multi_check.c
index 580195729506..631fa76ead6a 100644
--- a/tools/testing/selftests/bpf/progs/tracing_multi_check.c
+++ b/tools/testing/selftests/bpf/progs/tracing_multi_check.c
@@ -18,6 +18,12 @@ extern const void bpf_fentry_test8 __ksym;
 extern const void bpf_fentry_test9 __ksym;
 extern const void bpf_fentry_test10 __ksym;
 
+extern const void bpf_testmod_fentry_test1 __ksym;
+extern const void bpf_testmod_fentry_test2 __ksym;
+extern const void bpf_testmod_fentry_test3 __ksym;
+extern const void bpf_testmod_fentry_test7 __ksym;
+extern const void bpf_testmod_fentry_test11 __ksym;
+
 void tracing_multi_arg_check(__u64 *ctx, __u64 *test_result, bool is_return)
 {
 	void *ip = (void *) bpf_get_func_ip(ctx);
@@ -145,5 +151,49 @@ void tracing_multi_arg_check(__u64 *ctx, __u64 *test_result, bool is_return)
 		err |= is_return ? ret != 0 : 0;
 
 		*test_result += err == 0 ? 1 : 0;
+	} else if (ip == &bpf_testmod_fentry_test1) {
+		int a;
+
+		err |= bpf_get_func_arg(ctx, 0, &value);
+		a = (int) value;
+
+		err |= is_return ? ret != 2 : 0;
+
+		*test_result += err == 0 && a == 1;
+	} else if (ip == &bpf_testmod_fentry_test2) {
+		int a;
+		__u64 b;
+
+		err |= bpf_get_func_arg(ctx, 0, &value);
+		a = (int) value;
+		err |= bpf_get_func_arg(ctx, 1, &value);
+		b = (__u64) value;
+
+		err |= is_return ? ret != 5 : 0;
+
+		*test_result += err == 0 && a == 2 && b == 3;
+	} else if (ip == &bpf_testmod_fentry_test3) {
+		char a;
+		int b;
+		__u64 c;
+
+		err |= bpf_get_func_arg(ctx, 0, &value);
+		a = (char) value;
+		err |= bpf_get_func_arg(ctx, 1, &value);
+		b = (int) value;
+		err |= bpf_get_func_arg(ctx, 2, &value);
+		c = (__u64) value;
+
+		err |= is_return ? ret != 15 : 0;
+
+		*test_result += err == 0 && a == 4 && b == 5 && c == 6;
+	} else if (ip == &bpf_testmod_fentry_test7) {
+		err |= is_return ? ret != 133 : 0;
+
+		*test_result += err == 0;
+	} else if (ip == &bpf_testmod_fentry_test11) {
+		err |= is_return ? ret != 231 : 0;
+
+		*test_result += err == 0;
 	}
 }
-- 
2.53.0

