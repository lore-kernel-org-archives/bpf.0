Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB4F43FCB05;
	Wed, 27 May 2026 11:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779882233; cv=none; b=oSwr2w9kW2Bz69cHm/mQK1iGouffO7H+nseSV0+oeqEV1/b24u/BP/ScmbyEpUsb1BJn6xeDiON5Egmv3MMBFxG9+lBnMW25VbUJT3BcD1bl9ujy/uQGhVDErq4eipeKiOgZTvn39IhzcXIgw9RNZWop2DU0991omo+D9qtWxgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779882233; c=relaxed/simple;
	bh=B9MGYfJW8vkhdBj72oqnvwB9s8QGr4Q7wHjwQGBaEFg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gi9Qhmwvqmkj8mSIcCTie0sbXrerDySNxMqBZAAWZIDqhhIzCtD5xmdHmtpeggkh+jiQ2vQLZcmJZ09Cka+jXkqqNGNN8KIIJk3DHZRl31pgmau8EUh35vxn8dMiQ8RDzPm6kqxtSVcCZxhOpykMuzJ1JY1iw4WXqUJFICOwhCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JY4T1Iik; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JY4T1Iik"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0F881F000E9;
	Wed, 27 May 2026 11:43:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779882229;
	bh=MdAUQinRgbJc8MezI25a+wzDM+hv+uEMdzvyqiyT1Ts=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JY4T1Iik8PHvYfu4yott6KTkRE0x5ech9s3AFv7EE9Oufy+uLeIrMr2LFbNrUtRkp
	 3DrqdkOwxpLasqsdb1CdSr2CPsDxpcdxbvu96xd8eOTDw8UwWQW7mRFCrD7zVYm3WU
	 qfa6rcndRZrVDQPtRfnIrw2lp/DLhZKbMhL228bOe4R2Zu+NPMydjVPjh2skZb3ngY
	 tATozmzvfSU3ggD9PiKezDvNMaXRPK0hApWqyRSQQhe+oI7Z3QCcYc5A3eQEN4hrEc
	 vMa1chMOgy042ItEmHSI5oiRLSxOZC7lL+uFwI/DXmv8KniBmOpb4XVC5jU7pY7CXv
	 NMFdpMn89ERQA==
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
Subject: [PATCHv6 bpf-next 22/29] selftests/bpf: Add tracing multi skel/pattern/ids module attach tests
Date: Wed, 27 May 2026 13:39:44 +0200
Message-ID: <20260527113951.46265-23-jolsa@kernel.org>
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
index 396b68f862fe..fcfeb0aeff11 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -500,7 +500,8 @@ SKEL_BLACKLIST := btf__% test_pinning_invalid.c test_sk_assign.c
 LINKED_SKELS := test_static_linked.skel.h linked_funcs.skel.h		\
 		linked_vars.skel.h linked_maps.skel.h 			\
 		test_subskeleton.skel.h test_subskeleton_lib.skel.h	\
-		test_usdt.skel.h tracing_multi.skel.h
+		test_usdt.skel.h tracing_multi.skel.h			\
+		tracing_multi_module.skel.h
 
 LSKELS := fexit_sleep.c trace_printk.c trace_vprintk.c map_ptr_kern.c 	\
 	core_kern.c core_kern_overflow.c test_ringbuf.c			\
@@ -527,6 +528,7 @@ xsk_xdp_progs.skel.h-deps := xsk_xdp_progs.bpf.o
 xdp_hw_metadata.skel.h-deps := xdp_hw_metadata.bpf.o
 xdp_features.skel.h-deps := xdp_features.bpf.o
 tracing_multi.skel.h-deps := tracing_multi_attach.bpf.o tracing_multi_check.bpf.o
+tracing_multi_module.skel.h-deps := tracing_multi_attach_module.bpf.o tracing_multi_check.bpf.o
 
 LINKED_BPF_OBJS := $(foreach skel,$(LINKED_SKELS),$($(skel)-deps))
 LINKED_BPF_SRCS := $(patsubst %.bpf.o,%.c,$(LINKED_BPF_OBJS))
diff --git a/tools/testing/selftests/bpf/prog_tests/tracing_multi.c b/tools/testing/selftests/bpf/prog_tests/tracing_multi.c
index e290513358d9..746a8398211a 100644
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
@@ -241,6 +250,96 @@ static void test_link_api_ids(void)
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
@@ -254,4 +353,10 @@ void test_tracing_multi_test(void)
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
index 000000000000..b3374f2db450
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
+__hidden extern int tracing_multi_arg_check(__u64 *ctx, __u64 *test_result, bool is_return);
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
index 333a3a7bae8a..7ede84c50cb6 100644
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
 int tracing_multi_arg_check(__u64 *ctx, __u64 *test_result, bool is_return)
 {
 	void *ip = (void *) bpf_get_func_ip(ctx);
@@ -145,6 +151,50 @@ int tracing_multi_arg_check(__u64 *ctx, __u64 *test_result, bool is_return)
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
 
 	return 0;
-- 
2.54.0

