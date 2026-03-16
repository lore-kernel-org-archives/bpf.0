Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B82DB3537E9;
	Mon, 16 Mar 2026 07:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773647695; cv=none; b=MTOM+si/P96GvU+0f6QN5fJ6oQC8G6c5ySbvj2Punfin868b2USo6PkVYH9y2Mj2sgH93zEQAqeZZW2pvVi9swhcw42XhovUfYkjPj9z0octaTYg3/e7iq+SBrsP1HhthuuLw8SE3bx4Py1iwZ9XEvbSrCAINCwJleO+LfNXjLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773647695; c=relaxed/simple;
	bh=N2cIBg3jsFXwg3AkXcKJuoRS5KKogYoyJ4SAH6tPtR8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IzFuffZXO0WoRs3kwxWuWULh6QG+w2LGNvrAw+zQwZW5V6TPUiS3NNJWrYmSF0HZa8kGkGXTj3WMqLkgHZLlExImYuWiHxSbg8nQun+6wtm+Knentv7Dwt2ccMezSSyg971mbjsvhOBw92AJVbn+rJi3o/MBzNMEYM3avleIQxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m/tqHKsz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m/tqHKsz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88A5EC19421;
	Mon, 16 Mar 2026 07:54:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773647695;
	bh=N2cIBg3jsFXwg3AkXcKJuoRS5KKogYoyJ4SAH6tPtR8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=m/tqHKszQ90zB+xNosAmecIHvKYCOcLPi7bIAbaFheEh4M1y8kuvwP0lAwRtNerCv
	 Tqpq27oihdX6XmttzDgbgysqWQoCpVOLFYi/RXNZ1vO/Ur1tfzOFGPf6Lu1dORoAOK
	 fBVCSWG0ZybwylmqNvwlh/H33WGcZhaX7KN3jM94uJrofVGI6DDGy08pBV9lpDY+dU
	 PfN0F/YiTeRRQYbJM0uHh74QeSjMYYeGmzdie/6/R8fqIvOMIrQL4o1TuFEidV0iGp
	 Xjy0pdR7JrN04nQT0cdQH9Mw8BtK+tid25XQrv6WFlUTSgOj7GMl016s+m/Yf4G6tx
	 uCHgQv5eyr/jg==
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
Subject: [PATCHv3 bpf-next 18/24] selftests/bpf: Add tracing multi skel/pattern/ids module attach tests
Date: Mon, 16 Mar 2026 08:51:32 +0100
Message-ID: <20260316075138.465430-19-jolsa@kernel.org>
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

Adding tests for tracing_multi link attachment via all possible
libbpf apis - skeleton, function pattern and btf ids on top of
bpf_testmod kernel module.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/testing/selftests/bpf/Makefile          |   4 +-
 .../selftests/bpf/prog_tests/tracing_multi.c  | 105 ++++++++++++++++++
 .../bpf/progs/tracing_multi_attach_module.c   |  26 +++++
 .../selftests/bpf/progs/tracing_multi_check.c |  50 +++++++++
 4 files changed, 184 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/progs/tracing_multi_attach_module.c

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index e09beba5674e..cf01a11d7803 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -485,7 +485,8 @@ SKEL_BLACKLIST := btf__% test_pinning_invalid.c test_sk_assign.c
 LINKED_SKELS := test_static_linked.skel.h linked_funcs.skel.h		\
 		linked_vars.skel.h linked_maps.skel.h 			\
 		test_subskeleton.skel.h test_subskeleton_lib.skel.h	\
-		test_usdt.skel.h tracing_multi.skel.h
+		test_usdt.skel.h tracing_multi.skel.h			\
+		tracing_multi_module.skel.h
 
 LSKELS := fexit_sleep.c trace_printk.c trace_vprintk.c map_ptr_kern.c 	\
 	core_kern.c core_kern_overflow.c test_ringbuf.c			\
@@ -512,6 +513,7 @@ xsk_xdp_progs.skel.h-deps := xsk_xdp_progs.bpf.o
 xdp_hw_metadata.skel.h-deps := xdp_hw_metadata.bpf.o
 xdp_features.skel.h-deps := xdp_features.bpf.o
 tracing_multi.skel.h-deps := tracing_multi_attach.bpf.o tracing_multi_check.bpf.o
+tracing_multi_module.skel.h-deps := tracing_multi_attach_module.bpf.o tracing_multi_check.bpf.o
 
 LINKED_BPF_OBJS := $(foreach skel,$(LINKED_SKELS),$($(skel)-deps))
 LINKED_BPF_SRCS := $(patsubst %.bpf.o,%.c,$(LINKED_BPF_OBJS))
diff --git a/tools/testing/selftests/bpf/prog_tests/tracing_multi.c b/tools/testing/selftests/bpf/prog_tests/tracing_multi.c
index cebf4eb68f18..e9042d8d4760 100644
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
@@ -229,6 +238,96 @@ static void test_link_api_ids(void)
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
@@ -242,4 +341,10 @@ void test_tracing_multi_test(void)
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
index 000000000000..e021790fb5b6
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/tracing_multi_attach_module.c
@@ -0,0 +1,26 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <stdbool.h>
+#include <linux/bpf.h>
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
index 883af0336c2f..0e3248312dd5 100644
--- a/tools/testing/selftests/bpf/progs/tracing_multi_check.c
+++ b/tools/testing/selftests/bpf/progs/tracing_multi_check.c
@@ -19,6 +19,12 @@ extern const void bpf_fentry_test8 __ksym;
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
@@ -146,5 +152,49 @@ void tracing_multi_arg_check(__u64 *ctx, __u64 *test_result, bool is_return)
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

