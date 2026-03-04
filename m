Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9B4B384243;
	Wed,  4 Mar 2026 22:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772663098; cv=none; b=rIwTuyVnrTG/L2pR/2affyo5ovzXYU1iv887Ft21FCCPWbT/pOJfL7eriSkSWDvJBaLhGwkUnbjw6kfqtHnfZGA9vyx5UZiUqXXAZqtcu4uhRnOUKTEu12cJNVkVhd1aOshe6E/iuAb1gsw6Hjja9lGpjHBsBcJ+VLnqIeZc0D4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772663098; c=relaxed/simple;
	bh=8rUgwhlDh/5bCtRY4RketM8mzF20CqRaC5s4PiuHedE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MFIwhf7TFBqhhBNZC/ucU70IzNhmfh/FKId//7qnsyL2BvVKiwh0w3kXFdFQqIV85W71RiPjxV108QHNgYJOXv/buViU+3E2kWNPvtikIbtYupxTCcUn8uwLUmbEITZA9ErpUbNBvzv+DJv7o1o8zCY9mIuEKt7wja+EYQPSjzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jlTsA8BS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jlTsA8BS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E0B7C4CEF7;
	Wed,  4 Mar 2026 22:24:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772663098;
	bh=8rUgwhlDh/5bCtRY4RketM8mzF20CqRaC5s4PiuHedE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jlTsA8BS3IQqXl1iaPaHYMnFP8fRge1MGK8wDwfnwGMPpWKPmIRhHp5hiKQPovbvw
	 o9qynKEb1iehkLTyYfev3Rxe4WtJu6CYgSQsXM52HsutVaSCJpQIonHm5HwY1W+bfC
	 IbkEV7UBrDjgon30XmErl0YxcRNuXfH5ZfxYC7MN40FJJL9hkeng2cYUFyg0Qw5GwU
	 DpQTxeYzyyYiFlFX6wz1q0uaj+FSSRpxVAhsj+BzHMgOSKDtNOBHFRb3+3zkXRCDGw
	 m+BOaPU+6YdjspdYSDG70Bpp1wmxyyGWCIVOiclhyHxCosLLbazMuqYta8LdrObaqj
	 2cUaQCIzZUL6w==
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
Subject: [PATCHv2 bpf-next 18/23] selftests/bpf: Add tracing multi intersect tests
Date: Wed,  4 Mar 2026 23:21:36 +0100
Message-ID: <20260304222141.497203-19-jolsa@kernel.org>
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

Adding tracing multi tests for intersecting attached functions.

Using bits from (from 1 to 16 values) to specify (up to 4) attached
programs, and randomly choosing bpf_fentry_test* functions they are
attached to.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/testing/selftests/bpf/Makefile          |  4 +-
 .../selftests/bpf/prog_tests/tracing_multi.c  | 99 +++++++++++++++++++
 .../progs/tracing_multi_intersect_attach.c    | 42 ++++++++
 3 files changed, 144 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/progs/tracing_multi_intersect_attach.c

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index e8df26b7af95..ffcf7e120e5f 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -485,7 +485,8 @@ LINKED_SKELS := test_static_linked.skel.h linked_funcs.skel.h		\
 		linked_vars.skel.h linked_maps.skel.h 			\
 		test_subskeleton.skel.h test_subskeleton_lib.skel.h	\
 		test_usdt.skel.h tracing_multi.skel.h			\
-		tracing_multi_module.skel.h
+		tracing_multi_module.skel.h				\
+		tracing_multi_intersect.skel.h
 
 LSKELS := fexit_sleep.c trace_printk.c trace_vprintk.c map_ptr_kern.c 	\
 	core_kern.c core_kern_overflow.c test_ringbuf.c			\
@@ -513,6 +514,7 @@ xdp_hw_metadata.skel.h-deps := xdp_hw_metadata.bpf.o
 xdp_features.skel.h-deps := xdp_features.bpf.o
 tracing_multi.skel.h-deps := tracing_multi_attach.bpf.o tracing_multi_check.bpf.o
 tracing_multi_module.skel.h-deps := tracing_multi_attach_module.bpf.o tracing_multi_check.bpf.o
+tracing_multi_intersect.skel.h-deps := tracing_multi_intersect_attach.bpf.o tracing_multi_check.bpf.o
 
 LINKED_BPF_OBJS := $(foreach skel,$(LINKED_SKELS),$($(skel)-deps))
 LINKED_BPF_SRCS := $(patsubst %.bpf.o,%.c,$(LINKED_BPF_OBJS))
diff --git a/tools/testing/selftests/bpf/prog_tests/tracing_multi.c b/tools/testing/selftests/bpf/prog_tests/tracing_multi.c
index 55091b319b4f..775ef7c50e73 100644
--- a/tools/testing/selftests/bpf/prog_tests/tracing_multi.c
+++ b/tools/testing/selftests/bpf/prog_tests/tracing_multi.c
@@ -6,6 +6,7 @@
 #include "bpf/libbpf_internal.h"
 #include "tracing_multi.skel.h"
 #include "tracing_multi_module.skel.h"
+#include "tracing_multi_intersect.skel.h"
 #include "trace_helpers.h"
 
 static const char * const bpf_fentry_test[] = {
@@ -31,6 +32,20 @@ static const char * const bpf_testmod_fentry_test[] = {
 
 #define FUNCS_CNT (ARRAY_SIZE(bpf_fentry_test))
 
+static int get_random_funcs(const char **funcs)
+{
+	int i, cnt = 0;
+
+	for (i = 0; i < FUNCS_CNT; i++) {
+		if (rand() % 2)
+			funcs[cnt++] = bpf_fentry_test[i];
+	}
+	/* we always need at least one.. */
+	if (!cnt)
+		funcs[cnt++] = bpf_fentry_test[rand() % FUNCS_CNT];
+	return cnt;
+}
+
 static int compare(const void *ppa, const void *ppb)
 {
 	const char *pa = *(const char **) ppa;
@@ -328,6 +343,88 @@ static void test_module_link_api_ids(void)
 	free(ids);
 }
 
+static bool is_set(__u32 mask, __u32 bit)
+{
+	return (1 << bit) & mask;
+}
+
+static void __test_intersect(__u32 mask, const struct bpf_program *progs[4], __u64 *test_results[4])
+{
+	LIBBPF_OPTS(bpf_tracing_multi_opts, opts);
+	LIBBPF_OPTS(bpf_test_run_opts, topts);
+	struct bpf_link *links[4] = { NULL };
+	const char *funcs[FUNCS_CNT];
+	__u64 expected[4];
+	__u32 *ids, i;
+	int err, cnt;
+
+	/*
+	 * We have 4 programs in progs and the mask bits pick which
+	 * of them gets attached to randomly chosen functions.
+	 */
+	for (i = 0; i < 4; i++) {
+		if (!is_set(mask, i))
+			continue;
+
+		cnt = get_random_funcs(funcs);
+		ids = get_ids(funcs, cnt, NULL);
+		if (!ASSERT_OK_PTR(ids, "get_ids"))
+			goto cleanup;
+
+		opts.ids = ids;
+		opts.cnt = cnt;
+		links[i] = bpf_program__attach_tracing_multi(progs[i], NULL, &opts);
+		free(ids);
+
+		if (!ASSERT_OK_PTR(links[i], "bpf_program__attach_tracing_multi"))
+			goto cleanup;
+
+		expected[i] = *test_results[i] + cnt;
+	}
+
+	err = bpf_prog_test_run_opts(bpf_program__fd(progs[0]), &topts);
+	ASSERT_OK(err, "test_run");
+
+	for (i = 0; i < 4; i++) {
+		if (!is_set(mask, i))
+			continue;
+		ASSERT_EQ(*test_results[i], expected[i], "test_results");
+	}
+
+cleanup:
+	for (i = 0; i < 4; i++)
+		bpf_link__destroy(links[i]);
+}
+
+static void test_intersect(void)
+{
+	const struct bpf_program *progs[4];
+	struct tracing_multi_intersect *skel;
+	__u64 *test_results[4];
+	__u32 i;
+
+	skel = tracing_multi_intersect__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "tracing_multi_intersect__open_and_load"))
+		return;
+
+	skel->bss->pid = getpid();
+
+	progs[0] = skel->progs.fentry_1;
+	progs[1] = skel->progs.fexit_1;
+	progs[2] = skel->progs.fentry_2;
+	progs[3] = skel->progs.fexit_2;
+
+	test_results[0] = &skel->bss->test_result_fentry_1;
+	test_results[1] = &skel->bss->test_result_fexit_1;
+	test_results[2] = &skel->bss->test_result_fentry_2;
+	test_results[3] = &skel->bss->test_result_fexit_2;
+
+	for (i = 1; i < 16; i++)
+		__test_intersect(i, progs, test_results);
+
+	tracing_multi_intersect__destroy(skel);
+}
+
 void test_tracing_multi_test(void)
 {
 #ifndef __x86_64__
@@ -347,4 +444,6 @@ void test_tracing_multi_test(void)
 		test_module_link_api_pattern();
 	if (test__start_subtest("module_link_api_ids"))
 		test_module_link_api_ids();
+	if (test__start_subtest("intersect"))
+		test_intersect();
 }
diff --git a/tools/testing/selftests/bpf/progs/tracing_multi_intersect_attach.c b/tools/testing/selftests/bpf/progs/tracing_multi_intersect_attach.c
new file mode 100644
index 000000000000..bbd052b02559
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/tracing_multi_intersect_attach.c
@@ -0,0 +1,42 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <stdbool.h>
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+char _license[] SEC("license") = "GPL";
+
+__hidden extern int tracing_multi_arg_check(__u64 *ctx, __u64 *test_result, bool is_return);
+
+__u64 test_result_fentry_1 = 0;
+__u64 test_result_fentry_2 = 0;
+__u64 test_result_fexit_1 = 0;
+__u64 test_result_fexit_2 = 0;
+
+SEC("fentry.multi")
+int BPF_PROG(fentry_1)
+{
+	tracing_multi_arg_check(ctx, &test_result_fentry_1, false);
+	return 0;
+}
+
+SEC("fentry.multi")
+int BPF_PROG(fentry_2)
+{
+	tracing_multi_arg_check(ctx, &test_result_fentry_2, false);
+	return 0;
+}
+
+SEC("fexit.multi")
+int BPF_PROG(fexit_1)
+{
+	tracing_multi_arg_check(ctx, &test_result_fexit_1, true);
+	return 0;
+}
+
+SEC("fexit.multi")
+int BPF_PROG(fexit_2)
+{
+	tracing_multi_arg_check(ctx, &test_result_fexit_2, true);
+	return 0;
+}
-- 
2.53.0

