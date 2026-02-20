Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14B1B3382DA;
	Fri, 20 Feb 2026 10:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771584201; cv=none; b=t65IqFp+XU2r3Jh5DOVDgdBtU+8E/xK+y3VEytu9DjdgVsMPTXr5flQXBpaS/tjqoVDlGepHpoJQVlldtn54AD3MMwYViuHO/mRzUeeuIhlInFndyDqUwrxMfbfzIMz2UAerBlTbrU1Tp2TomF5XYBJ+RiS22ndjzE7q82ktYzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771584201; c=relaxed/simple;
	bh=aMVzuAIk1dN5DYG5umlxXnQpvAHaohfIb8cpPlQAlvo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UuDVNnoETnnGhxgTbHz2JewBve+/exzKmSOvatRipTlj6LdXsCJtennTvpVQotDP6ppSyIGUeLWTFxKHDeDGu+ik78ITkydSsKL7G/yldDaMRP/dUzGrnn7gWSJn4l32SXXPwpo1EgXXvM7NS3LbM7nE65hZJYQRvvq5hhDDpus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hQ2Ms7Rt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hQ2Ms7Rt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D4D2C19425;
	Fri, 20 Feb 2026 10:43:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771584200;
	bh=aMVzuAIk1dN5DYG5umlxXnQpvAHaohfIb8cpPlQAlvo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hQ2Ms7RtbrdyAHxH9kKfPCLsv9014J1RfrQ+x4llH6rYKLX7qNYYe6/zvwYC08VWY
	 Y0VuiBI1ZnkZ6bJwzMYMbU97svLuViHvNysW4XW5x0I5ttr2c/xg+xDccO1P/uc/Di
	 j/rUsVV6Po2fZNC8RkyQnb82sOqtFr4Ut//PH0ou73/U7BEp6Xx09pl+ApF7FePn4j
	 zPTaWV6UMNIAMhcrk2NQSBquiSPwVKlEYEx4IX9k6AX1P8tHo6ndqdsFbCn0QoQHW8
	 KISjhyi20mwlHFzRB3v+76xkfCg7myDDMw6mG4LBsKeOjtqGt7/fviCg/Z5ooiZoUd
	 DPo2qQTUTOMDQ==
From: Jiri Olsa <jolsa@kernel.org>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>
Subject: [PATCHv4 bpf-next 4/5] selftests/bpf: Add test for checking correct nop of optimized usdt
Date: Fri, 20 Feb 2026 11:42:19 +0100
Message-ID: <20260220104220.634154-5-jolsa@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260220104220.634154-1-jolsa@kernel.org>
References: <20260220104220.634154-1-jolsa@kernel.org>
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
 tools/testing/selftests/bpf/prog_tests/usdt.c | 92 +++++++++++++++++++
 tools/testing/selftests/bpf/progs/test_usdt.c | 12 +++
 tools/testing/selftests/bpf/usdt_1.c          | 18 ++++
 tools/testing/selftests/bpf/usdt_2.c          | 16 ++++
 6 files changed, 142 insertions(+), 1 deletion(-)
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
index 6776158f1f3e..23857d17fc5b 100644
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
index f4be5269fa90..69759b27794d 100644
--- a/tools/testing/selftests/bpf/prog_tests/usdt.c
+++ b/tools/testing/selftests/bpf/prog_tests/usdt.c
@@ -247,6 +247,96 @@ static void subtest_basic_usdt(bool optimized)
 #undef TRIGGER
 }
 
+#ifdef __x86_64__
+extern void usdt_1(void);
+extern void usdt_2(void);
+
+static unsigned char nop1[1] = { 0x90 };
+static unsigned char nop1_nop5_combo[6] = { 0x90, 0x0f, 0x1f, 0x44, 0x00, 0x00 };
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
+	/* usdt_1 USDT probe has single nop instruction */
+	addr_1 = find_instr(usdt_1, nop1_nop5_combo, 6);
+	if (!ASSERT_NULL(addr_1, "usdt_1_find_nop1_nop5_combo"))
+		return;
+
+	addr_1 = find_instr(usdt_1, nop1, 1);
+	if (!ASSERT_OK_PTR(addr_1, "usdt_1_find_nop1"))
+		return;
+
+	/* usdt_2 USDT probe has nop,nop5 instructions combo */
+	addr_2 = find_instr(usdt_2, nop1_nop5_combo, 6);
+	if (!ASSERT_OK_PTR(addr_2, "usdt_2_find_nop1_nop5_combo"))
+		return;
+
+	skel = test_usdt__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "test_usdt__open_and_load"))
+		return;
+
+	skel->bss->expected_ip = (unsigned long) addr_1;
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
+	/* int3 is on addr_1 address */
+	ASSERT_EQ(*addr_1, 0xcc, "int3");
+	ASSERT_EQ(skel->bss->executed, 2, "executed");
+
+	bpf_link__destroy(skel->links.usdt_executed);
+
+	/* we expect the nop5 ip */
+	skel->bss->expected_ip = (unsigned long) addr_2 + 1;
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
+	/* nop stays on addr_2 address */
+	ASSERT_EQ(*addr_2, 0x90, "nop");
+
+	/* call is on addr_2 + 1 address */
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
@@ -516,6 +606,8 @@ void test_usdt(void)
 #ifdef __x86_64__
 	if (test__start_subtest("basic_optimized"))
 		subtest_basic_usdt(true);
+	if (test__start_subtest("optimized_attach"))
+		subtest_optimized_attach();
 #endif
 	if (test__start_subtest("multispec"))
 		subtest_multispec_usdt();
diff --git a/tools/testing/selftests/bpf/progs/test_usdt.c b/tools/testing/selftests/bpf/progs/test_usdt.c
index a78c87537b07..f00cb52874e0 100644
--- a/tools/testing/selftests/bpf/progs/test_usdt.c
+++ b/tools/testing/selftests/bpf/progs/test_usdt.c
@@ -138,4 +138,16 @@ int usdt_sib(struct pt_regs *ctx)
 	return 0;
 }
 
+#ifdef __TARGET_ARCH_x86
+int executed;
+unsigned long expected_ip;
+
+SEC("usdt")
+int usdt_executed(struct pt_regs *ctx)
+{
+	if (expected_ip == ctx->ip)
+		executed++;
+	return 0;
+}
+#endif
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

