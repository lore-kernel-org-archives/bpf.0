Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 215411DC198;
	Tue, 10 Feb 2026 13:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770730656; cv=none; b=TVzpsHfWLNoV/pPqKU/4QPSp3L6/+aOezfLf0JqjKsLH5JJGpIF69+BVQqOqw2CVcxgjFmG/NxJS5uQcZPMVxjzYxk5HVtjwW/U9nvuaC7hJvbA+Ec4yydo0QkrkoVGPfJmcN5zmOnlGfYcvBINbPYdYAq4/Mg/MS6LE6wnPbsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770730656; c=relaxed/simple;
	bh=OJL/jCjsZxIrowaR7pNnZ1ZmpK5JnffV4H7ABU7UqV4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pleVq/We+FqJ0xYdvvQpyAFwOVKnImEtVT3P8ytfYtA5ivlKKSDRYHfs2JAW4GEYiTaNhhFwuLX0GRqr/712vgZuJWYYBqf91jy1I7jNFIDtt1UZhMxMYo5HIIO0ckyh16EPIbYrUnac7WjMMab6ASzPxlcmAGvE/pHOrs25d88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E/ztk7Gc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E/ztk7Gc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FF41C116C6;
	Tue, 10 Feb 2026 13:37:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770730656;
	bh=OJL/jCjsZxIrowaR7pNnZ1ZmpK5JnffV4H7ABU7UqV4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=E/ztk7Gc3q2G+HzVPEEd9+pKTOFva4PzJxLRuOrG6F6ml1YtWECDXkAgDT5wblC1C
	 APB8eygni/f85tb4mAxqr6hc41FkurFrfdPbl1u//GnBeTpDFjGkaMHz/XjOfn+RrN
	 /vMcSUujzE/uNn+G4INuoHp7dppzH+zWIYu7prN1RwLtgrXlyCGIETN1CNwCUyCNpk
	 aEiIHsVNNJ6N2390bpKUvUeWkEQqBGtEVNf55Ax2cfSIRljSXSAQ/By3oRHESbjkV9
	 A8CA/1acNmkUiWJbRQBlSiwFfhnNM8lJsK4SVqXCQ2X1/ZDQkp5XtTfmB45eSPsJIM
	 TMVX7pKeP2T8Q==
From: Jiri Olsa <jolsa@kernel.org>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>
Subject: [PATCHv2 bpf-next 4/5] selftests/bpf: Add test for checking correct nop of optimized usdt
Date: Tue, 10 Feb 2026 14:36:48 +0100
Message-ID: <20260210133649.524292-5-jolsa@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260210133649.524292-1-jolsa@kernel.org>
References: <20260210133649.524292-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adding test that attaches bpf program on usdt probe in 2 scenarios;

- attach program on top of usdt_1, which is single nop instruction,
  so the probe stays on nop instruction and is not optimized.

- attach program on top of usdt_2 which is probe defined on top
  of nop,nop5 combo, so the probe is placed on top of nop5 and
  is optimized.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/testing/selftests/bpf/.gitignore        |  2 +
 tools/testing/selftests/bpf/Makefile          |  3 +-
 tools/testing/selftests/bpf/prog_tests/usdt.c | 85 +++++++++++++++++++
 tools/testing/selftests/bpf/progs/test_usdt.c |  9 ++
 tools/testing/selftests/bpf/usdt_1.c          | 18 ++++
 tools/testing/selftests/bpf/usdt_2.c          | 16 ++++
 6 files changed, 132 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/usdt_1.c
 create mode 100644 tools/testing/selftests/bpf/usdt_2.c

diff --git a/tools/testing/selftests/bpf/.gitignore b/tools/testing/selftests/bpf/.gitignore
index a3ea98211ea6..bfdc5518ecc8 100644
--- a/tools/testing/selftests/bpf/.gitignore
+++ b/tools/testing/selftests/bpf/.gitignore
@@ -47,3 +47,5 @@ verification_cert.h
 *.BTF
 *.BTF_ids
 *.BTF.base
+usdt_1
+usdt_2
diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index c6bf4dfb1495..306949162a5b 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -749,7 +749,8 @@ TRUNNER_EXTRA_SOURCES := test_progs.c		\
 			 $(VERIFY_SIG_HDR)		\
 			 flow_dissector_load.h	\
 			 ip_check_defrag_frags.h	\
-			 bpftool_helpers.c
+			 bpftool_helpers.c	\
+			 usdt_1.c usdt_2.c
 TRUNNER_LIB_SOURCES := find_bit.c
 TRUNNER_EXTRA_FILES := $(OUTPUT)/urandom_read				\
 		       $(OUTPUT)/liburandom_read.so			\
diff --git a/tools/testing/selftests/bpf/prog_tests/usdt.c b/tools/testing/selftests/bpf/prog_tests/usdt.c
index f4be5269fa90..0ef74894c1b8 100644
--- a/tools/testing/selftests/bpf/prog_tests/usdt.c
+++ b/tools/testing/selftests/bpf/prog_tests/usdt.c
@@ -247,6 +247,89 @@ static void subtest_basic_usdt(bool optimized)
 #undef TRIGGER
 }
 
+#ifdef __x86_64
+extern void usdt_1(void);
+extern void usdt_2(void);
+
+/* nop, nop5 */
+static unsigned char nop1_nop5_combo[6] = { 0x90, 0x0f, 0x1f, 0x44, 0x00, 0x00 };
+static unsigned char nop1[6] = { 0x90 };
+
+static void *find_instr(void *fn, unsigned char *instr, size_t cnt)
+{
+	int i;
+
+	for (i = 0; i < 10; i++) {
+		if (!memcmp(instr, fn + i, cnt))
+			return fn + i;
+	}
+	return NULL;
+}
+
+static void subtest_optimized_attach(void)
+{
+	struct test_usdt *skel;
+	__u8 *addr_1, *addr_2;
+
+	/* usdt_1 probe has single nop instruction */
+	addr_1 = find_instr(usdt_1, nop1_nop5_combo, 6);
+	if (!ASSERT_NULL(addr_1, "usdt_1_find_nop1_nop5_combo"))
+		return;
+
+	addr_1 = find_instr(usdt_1, nop1, 1);
+	if (!ASSERT_OK_PTR(addr_1, "usdt_1_find_nop1"))
+		return;
+
+	/* usdt_2 probe has nop,nop5 instructions combo */
+	addr_2 = find_instr(usdt_2, nop1_nop5_combo, 6);
+	if (!ASSERT_OK_PTR(addr_2, "usdt_2_find_nop1_nop5_combo"))
+		return;
+
+	skel = test_usdt__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "test_usdt__open_and_load"))
+		return;
+
+	/*
+	 * Attach program on top of usdt_1 which is single nop probe,
+	 * so the probe won't get optimized.
+	 */
+	skel->links.usdt_executed = bpf_program__attach_usdt(skel->progs.usdt_executed,
+						     0 /*self*/, "/proc/self/exe",
+						     "optimized_attach", "usdt_1", NULL);
+	if (!ASSERT_OK_PTR(skel->links.usdt_executed, "bpf_program__attach_usdt"))
+		goto cleanup;
+
+	usdt_1();
+	usdt_1();
+
+	/* nop is on addr_1 address */
+	ASSERT_EQ(*addr_1, 0xcc, "int3");
+	ASSERT_EQ(skel->bss->executed, 2, "executed");
+
+	bpf_link__destroy(skel->links.usdt_executed);
+
+	/*
+	 * Attach program on top of usdt_2 which is probe defined on top
+	 * of nop1,nop5 combo, so the probe gets optimized on top of nop5.
+	 */
+	skel->links.usdt_executed = bpf_program__attach_usdt(skel->progs.usdt_executed,
+						     0 /*self*/, "/proc/self/exe",
+						     "optimized_attach", "usdt_2", NULL);
+	if (!ASSERT_OK_PTR(skel->links.usdt_executed, "bpf_program__attach_usdt"))
+		goto cleanup;
+
+	usdt_2();
+	usdt_2();
+
+	/* nop5 is on addr_2 + 1 address */
+	ASSERT_EQ(*(addr_2 + 1), 0xe8, "call");
+	ASSERT_EQ(skel->bss->executed, 4, "executed");
+
+cleanup:
+	test_usdt__destroy(skel);
+}
+#endif
+
 unsigned short test_usdt_100_semaphore SEC(".probes");
 unsigned short test_usdt_300_semaphore SEC(".probes");
 unsigned short test_usdt_400_semaphore SEC(".probes");
@@ -516,6 +599,8 @@ void test_usdt(void)
 #ifdef __x86_64__
 	if (test__start_subtest("basic_optimized"))
 		subtest_basic_usdt(true);
+	if (test__start_subtest("optimized_attach"))
+		subtest_optimized_attach();
 #endif
 	if (test__start_subtest("multispec"))
 		subtest_multispec_usdt();
diff --git a/tools/testing/selftests/bpf/progs/test_usdt.c b/tools/testing/selftests/bpf/progs/test_usdt.c
index a78c87537b07..6911868cdf67 100644
--- a/tools/testing/selftests/bpf/progs/test_usdt.c
+++ b/tools/testing/selftests/bpf/progs/test_usdt.c
@@ -138,4 +138,13 @@ int usdt_sib(struct pt_regs *ctx)
 	return 0;
 }
 
+int executed;
+
+SEC("usdt")
+int usdt_executed(struct pt_regs *ctx)
+{
+	executed++;
+	return 0;
+}
+
 char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/usdt_1.c b/tools/testing/selftests/bpf/usdt_1.c
new file mode 100644
index 000000000000..4f06e8bcf58b
--- /dev/null
+++ b/tools/testing/selftests/bpf/usdt_1.c
@@ -0,0 +1,18 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#if defined(__x86_64__)
+
+/*
+ * Include usdt.h with defined USDT_NOP macro to use single
+ * nop instruction.
+ */
+#define USDT_NOP .byte 0x90
+#include "usdt.h"
+
+__attribute__((aligned(16)))
+void usdt_1(void)
+{
+	USDT(optimized_attach, usdt_1);
+}
+
+#endif
diff --git a/tools/testing/selftests/bpf/usdt_2.c b/tools/testing/selftests/bpf/usdt_2.c
new file mode 100644
index 000000000000..789883aaca4c
--- /dev/null
+++ b/tools/testing/selftests/bpf/usdt_2.c
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#if defined(__x86_64__)
+
+/*
+ * Include usdt.h with default nop,nop5 instructions combo.
+ */
+#include "usdt.h"
+
+__attribute__((aligned(16)))
+void usdt_2(void)
+{
+	USDT(optimized_attach, usdt_2);
+}
+
+#endif
-- 
2.53.0

