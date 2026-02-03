Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B12B2C08D1;
	Tue,  3 Feb 2026 09:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770111609; cv=none; b=BzSO8EbaLOUxcsyrBsMvI0AuEHhgKVc5MJtemHk6DeowUSj2a/0hUdboZowUY1jcOjQQ30pVD+x/gtJjxpdaEZYeXP/YJsb+rI+/cFr01H73ByqLq9xy+jNXsN8J1ZZjet800+zQO2miv6kST8Rt+ycszRt9t0kuUZmDUAwhufE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770111609; c=relaxed/simple;
	bh=gb2ktjdb6StmFJyWY47SG5vU5JdFXCuvzyNMn5eKSgA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uyk2vnBk74B7D4yFIflKUE7hMOg7idySvYGgishCUsJKoYLEULyuhcG0roPc+4Xg7n8/JpJdHaffNa3LdYDtmKn+vsXz9ZdVIodOwmsluDFJAMUcttZF/OvIbUmr4mFKj99gl8hOABJBwP91JrVEMc5te8QNGDtMwBlgbky6sB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pV2G5hxf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pV2G5hxf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59402C116D0;
	Tue,  3 Feb 2026 09:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770111608;
	bh=gb2ktjdb6StmFJyWY47SG5vU5JdFXCuvzyNMn5eKSgA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pV2G5hxflOFPJDSTTUDs+atExGJA+ZNFjnKM6y0n8C46kh7W//GG9wki6ytdu3dwV
	 tE7iaSFXsaorPEnwVAFG4sPZuNtKJdrDHZzLSonpIgeTUku4xfw0Jsr7DhQ8zd3Vl6
	 G1Jy8KP+G5i47Z3WDO/2UjEy/hXRPID+Yl0H1oBAJwzLZdLdNxds9QPqw3w7dkbzdD
	 ke5UdluvNQkGzsWSUkZ9hPiHRLQeLL03IFc2RhobTJPVM4+bXSoAfX2TPud1DWWqjh
	 9DYVTTz3joKW3J/qJW6lcUvI/krptq8c+KyG9/EdRLx2kR/741fciil1dxtqqVLEbr
	 1cP4Mf6HAovow==
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
Subject: [RFC bpf-next 10/12] selftests/bpf: Add fentry tracing multi func test
Date: Tue,  3 Feb 2026 10:38:17 +0100
Message-ID: <20260203093819.2105105-11-jolsa@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260203093819.2105105-1-jolsa@kernel.org>
References: <20260203093819.2105105-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adding selftest for fentry multi func test that attaches to
bpf_fentry_test* functions and checks argument values based
on the processed function.

We need to cast to real arguments types in multi_arg_check,
because the checked value can be shorter than u64.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/testing/selftests/bpf/Makefile          |   3 +-
 .../selftests/bpf/prog_tests/tracing_multi.c  |  48 +++++++
 .../selftests/bpf/progs/tracing_multi_check.c | 132 ++++++++++++++++++
 .../bpf/progs/tracing_multi_fentry.c          |  17 +++
 4 files changed, 199 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/tracing_multi.c
 create mode 100644 tools/testing/selftests/bpf/progs/tracing_multi_check.c
 create mode 100644 tools/testing/selftests/bpf/progs/tracing_multi_fentry.c

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index c6bf4dfb1495..b12d7b0e7828 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -481,7 +481,7 @@ SKEL_BLACKLIST := btf__% test_pinning_invalid.c test_sk_assign.c
 LINKED_SKELS := test_static_linked.skel.h linked_funcs.skel.h		\
 		linked_vars.skel.h linked_maps.skel.h 			\
 		test_subskeleton.skel.h test_subskeleton_lib.skel.h	\
-		test_usdt.skel.h
+		test_usdt.skel.h tracing_multi_fentry_test.skel.h
 
 LSKELS := fexit_sleep.c trace_printk.c trace_vprintk.c map_ptr_kern.c 	\
 	core_kern.c core_kern_overflow.c test_ringbuf.c			\
@@ -507,6 +507,7 @@ test_usdt.skel.h-deps := test_usdt.bpf.o test_usdt_multispec.bpf.o
 xsk_xdp_progs.skel.h-deps := xsk_xdp_progs.bpf.o
 xdp_hw_metadata.skel.h-deps := xdp_hw_metadata.bpf.o
 xdp_features.skel.h-deps := xdp_features.bpf.o
+tracing_multi_fentry_test.skel.h-deps := tracing_multi_fentry.bpf.o tracing_multi_check.bpf.o
 
 LINKED_BPF_OBJS := $(foreach skel,$(LINKED_SKELS),$($(skel)-deps))
 LINKED_BPF_SRCS := $(patsubst %.bpf.o,%.c,$(LINKED_BPF_OBJS))
diff --git a/tools/testing/selftests/bpf/prog_tests/tracing_multi.c b/tools/testing/selftests/bpf/prog_tests/tracing_multi.c
new file mode 100644
index 000000000000..6d45147f0730
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/tracing_multi.c
@@ -0,0 +1,48 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <test_progs.h>
+
+#ifdef __x86_64__
+#include "tracing_multi_fentry_test.skel.h"
+#include "trace_helpers.h"
+
+static void multi_fentry_test(void)
+{
+	LIBBPF_OPTS(bpf_test_run_opts, topts);
+	struct tracing_multi_fentry_test *skel = NULL;
+	int err, prog_fd;
+
+	skel = tracing_multi_fentry_test__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "fentry_multi_skel_load"))
+		goto cleanup;
+
+	err = tracing_multi_fentry_test__attach(skel);
+	if (!ASSERT_OK(err, "fentry_attach"))
+		goto cleanup;
+
+	prog_fd = bpf_program__fd(skel->progs.test);
+	err = bpf_prog_test_run_opts(prog_fd, &topts);
+	ASSERT_OK(err, "test_run");
+
+	ASSERT_EQ(skel->bss->test_result_1, 8, "test_result");
+
+cleanup:
+	tracing_multi_fentry_test__destroy(skel);
+}
+
+void __test_tracing_multi_test(void)
+{
+	if (test__start_subtest("fentry/simple"))
+		multi_fentry_test();
+}
+#else
+void __test_tracing_multi_test(void)
+{
+	test__skip();
+}
+#endif /* __x86_64__ */
+
+void test_tracing_multi_test(void)
+{
+	__test_tracing_multi_test();
+}
diff --git a/tools/testing/selftests/bpf/progs/tracing_multi_check.c b/tools/testing/selftests/bpf/progs/tracing_multi_check.c
new file mode 100644
index 000000000000..e5efa9884dfd
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/tracing_multi_check.c
@@ -0,0 +1,132 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+extern const void bpf_fentry_test1 __ksym;
+extern const void bpf_fentry_test2 __ksym;
+extern const void bpf_fentry_test3 __ksym;
+extern const void bpf_fentry_test4 __ksym;
+extern const void bpf_fentry_test5 __ksym;
+extern const void bpf_fentry_test6 __ksym;
+extern const void bpf_fentry_test7 __ksym;
+extern const void bpf_fentry_test8 __ksym;
+
+void multi_arg_check(__u64 *ctx, __u64 *test_result)
+{
+	void *ip = (void *) bpf_get_func_ip(ctx);
+	__u64 value = 0;
+
+	if (ip == &bpf_fentry_test1) {
+		int a;
+
+		if (bpf_get_func_arg(ctx, 0, &value))
+			return;
+		a = (int) value;
+
+		*test_result += a == 1;
+	} else if (ip == &bpf_fentry_test2) {
+		__u64 b;
+		int a;
+
+		if (bpf_get_func_arg(ctx, 0, &value))
+			return;
+		a = (int) value;
+		if (bpf_get_func_arg(ctx, 1, &value))
+			return;
+		b = value;
+
+		*test_result += a == 2 && b == 3;
+	} else if (ip == &bpf_fentry_test3) {
+		char a, b;
+		__u64 c;
+
+		if (bpf_get_func_arg(ctx, 0, &value))
+			return;
+		a = (int) value;
+		if (bpf_get_func_arg(ctx, 1, &value))
+			return;
+		b = (int) value;
+		if (bpf_get_func_arg(ctx, 2, &value))
+			return;
+		c = value;
+
+		*test_result += a == 4 && b == 5 && c == 6;
+	} else if (ip == &bpf_fentry_test4) {
+		void *a;
+		char b;
+		int c;
+		__u64 d;
+
+		if (bpf_get_func_arg(ctx, 0, &value))
+			return;
+		a = (void*) value;
+		if (bpf_get_func_arg(ctx, 1, &value))
+			return;
+		b = (char) value;
+		if (bpf_get_func_arg(ctx, 2, &value))
+			return;
+		c = (int) value;
+		if (bpf_get_func_arg(ctx, 3, &value))
+			return;
+		d = value;
+
+		*test_result += a == (void *) 7 && b == 8 && c == 9 && d == 10;
+	} else if (ip == &bpf_fentry_test5) {
+		__u64 a;
+		void *b;
+		short c;
+		int d;
+		__u64 e;
+
+		if (bpf_get_func_arg(ctx, 0, &value))
+			return;
+		a = value;
+		if (bpf_get_func_arg(ctx, 1, &value))
+			return;
+		b = (void*) value;
+		if (bpf_get_func_arg(ctx, 2, &value))
+			return;
+		c = (short) value;
+		if (bpf_get_func_arg(ctx, 3, &value))
+			return;
+		d = (int) value;
+		if (bpf_get_func_arg(ctx, 4, &value))
+			return;
+		e = value;
+
+		*test_result += a == 11 && b == (void *) 12 && c == 13 && d == 14 && e == 15;
+	} else if (ip == &bpf_fentry_test6) {
+		__u64 a;
+		void *b;
+		short c;
+		int d;
+		void *e;
+		__u64 f;
+
+		if (bpf_get_func_arg(ctx, 0, &value))
+			return;
+		a = value;
+		if (bpf_get_func_arg(ctx, 1, &value))
+			return;
+		b = (void*) value;
+		if (bpf_get_func_arg(ctx, 2, &value))
+			return;
+		c = (short) value;
+		if (bpf_get_func_arg(ctx, 3, &value))
+			return;
+		d = (int) value;
+		if (bpf_get_func_arg(ctx, 4, &value))
+			return;
+		e = (void*) value;;
+		if (bpf_get_func_arg(ctx, 5, &value))
+			return;
+		f = value;;
+
+		*test_result += a == 16 && b == (void *) 17 && c == 18 && d == 19 && e == (void *) 20 && f == 21;
+	} else if (ip == &bpf_fentry_test7) {
+		*test_result += 1;
+	} else if (ip == &bpf_fentry_test8) {
+		*test_result += 1;
+	}
+}
diff --git a/tools/testing/selftests/bpf/progs/tracing_multi_fentry.c b/tools/testing/selftests/bpf/progs/tracing_multi_fentry.c
new file mode 100644
index 000000000000..628734596114
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/tracing_multi_fentry.c
@@ -0,0 +1,17 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+char _license[] SEC("license") = "GPL";
+
+__u64 test_result_1 = 0;
+
+__hidden extern void multi_arg_check(__u64 *ctx, __u64 *test_result);
+
+SEC("fentry.multi/bpf_fentry_test*")
+int BPF_PROG(test, __u64 a, __u64 b, __u64 c, __u64 d, __u64 e, __u64 f)
+{
+	multi_arg_check(ctx, &test_result_1);
+	return 0;
+}
-- 
2.52.0

