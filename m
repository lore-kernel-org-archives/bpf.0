Received: from mta1.migadu.com (out-128.mta1.migadu.com [95.215.58.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9917A3955F5
	for <bpf@vger.kernel.org>; Tue, 25 Aug 2026 15:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787670330; cv=none; b=BqzRwLdCdGTGHKmz9RSjOJmZUXlIayMnRlNGK2QAe6rXWZws9bwDfGgD2M0Xnz1xDqn7vkR8aE/tQedpOrg07YKoENm2ecNZysdDAnTHasPRrC9m6lUQNpsGm6MKlsRt1VdwDTtE005OtqJrC64gFK/Mpv/JrQxj5xoj6qiKAXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787670330; c=relaxed/simple;
	bh=uYU2qg0EoBNSsLVN1LXKLFou3zzAEe8tQs0NvwzqPwc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IDpiiuJUWuscHugb/8mq1bNQsJybNJhar/65d0rOeiueuWcZj37ydC/MuVVMB6NhHOwuj+gbLWne72U+s9b/SGu//CWUdrAMbOEuZp/u42x7JUOrJsdpRJV6fdIQb6bw6/cvYE++2qKsrPI5CdIrKZ6syIpdv0yFE2f2ActltT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=WQEKNSAd; arc=none smtp.client-ip=95.215.58.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="WQEKNSAd"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=uYU2qg0EoBNSsLVN1LXKLFou3zzAEe8tQs0NvwzqPwc=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787670326; v=1; x=1788275126;
 b=WQEKNSAdFpBzx0ALkpcXjzoYtiT1MBhCtJ28YPRg4zGFK5H6WFWxlTaHTwHjyAoSeFQvDgIg
 r+cQHlWmdHq9GmgmkuX/jWAtVETt88OTs1d60qQ4/wxw8nW4OLk83JOiIuvahGfN07hTdKPsJFK
 g1cIhgXFFDbQll60xSLrQyv0=
X-Envelope-To: bpf@vger.kernel.org
Received: from localhost.localdomain (147.136.157.2)
	by smtp.migadu.com with ESMTPS id 3022ce5690d1a011;
	Tue, 25 Aug 2026 15:05:26 +0000
X-Mizu-Trace-ID: 3022ce5690d1a011
X-Migadu-Flow: FLOW_OUT
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: bpf@vger.kernel.org,
	jolsa@kernel.org
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Shuah Khan <shuah@kernel.org>,
	Jakub Sitnicki <jakub@cloudflare.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Jiawei Zhao <phoenix500526@163.com>,
	Ingo Molnar <mingo@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf v2 2/2] selftests/bpf: Add test for usdt probe with page-crossing nop10
Date: Tue, 25 Aug 2026 23:04:34 +0800
Message-ID: <20260825150444.31603-2-jiayuan.chen@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260825150444.31603-1-jiayuan.chen@linux.dev>
References: <20260825150444.31603-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a USDT probe laid out so that its nop10 crosses a page boundary
and check that attaching to it succeeds and the probe fires. Without
the previous fix libbpf shifts the uprobe onto the nop10 and the
attach fails with -ENOTSUPP.

Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
---
 tools/testing/selftests/bpf/prog_tests/usdt.c | 54 +++++++++++++++++++
 tools/testing/selftests/bpf/usdt_2.c          | 16 ++++++
 2 files changed, 70 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/usdt.c b/tools/testing/selftests/bpf/prog_tests/usdt.c
index 8004c9568ffa..eff1e57ab13c 100644
--- a/tools/testing/selftests/bpf/prog_tests/usdt.c
+++ b/tools/testing/selftests/bpf/prog_tests/usdt.c
@@ -250,6 +250,7 @@ static void subtest_basic_usdt(bool optimized)
 #ifdef __x86_64__
 extern void usdt_1(void);
 extern void usdt_2(void);
+extern void usdt_2_cross_page(void);
 extern void usdt_red_zone_trigger(void);
 
 static unsigned char nop1[1] = { 0x90 };
@@ -342,6 +343,57 @@ static void subtest_optimized_attach(void)
 	test_usdt__destroy(skel);
 }
 
+/*
+ * Test attachment to a USDT probe whose nop10 crosses a page boundary.
+ * The kernel can't optimize such nop10, so libbpf keeps the uprobe on
+ * the preceding 1-byte nop. Do not assume any particular placement
+ * here, though: however the probe ends up attached, the attachment
+ * must succeed and the probe must fire.
+ */
+static void subtest_optimized_attach_cross_page(void)
+{
+	long page_sz = sysconf(_SC_PAGESIZE);
+	struct test_usdt *skel;
+	__u8 *addr = NULL;
+	long i;
+
+	/* combo is placed up to a page of padding after the function start */
+	for (i = 0; i < 2 * page_sz; i++) {
+		if (!memcmp((void *)usdt_2_cross_page + i, nop1_nop10_combo, 11)) {
+			addr = (void *)usdt_2_cross_page + i;
+			break;
+		}
+	}
+	if (!ASSERT_OK_PTR(addr, "find_nop1_nop10_combo"))
+		return;
+
+	/* layout sanity check: the nop10 must cross the page boundary */
+	if (!ASSERT_GT((unsigned long)(addr + 1) % page_sz + 10, page_sz,
+		       "nop10_crosses_page"))
+		return;
+
+	skel = test_usdt__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "test_usdt__open_and_load"))
+		return;
+
+	skel->bss->my_pid = getpid();
+
+	skel->links.usdt0 = bpf_program__attach_usdt(skel->progs.usdt0,
+						     0 /*self*/, "/proc/self/exe",
+						     "optimized_attach",
+						     "usdt_2_cross_page", NULL);
+	if (!ASSERT_OK_PTR(skel->links.usdt0, "bpf_program__attach_usdt"))
+		goto cleanup;
+
+	usdt_2_cross_page();
+	usdt_2_cross_page();
+
+	ASSERT_EQ(skel->bss->usdt0_called, 2, "usdt0_called");
+
+cleanup:
+	test_usdt__destroy(skel);
+}
+
 /*
  * Test that USDT arguments survive nop10 optimization in a function where
  * the compiler places operands in the red zone.
@@ -660,6 +712,8 @@ void test_usdt(void)
 		subtest_basic_usdt(true);
 	if (test__start_subtest("optimized_attach"))
 		subtest_optimized_attach();
+	if (test__start_subtest("optimized_attach_cross_page"))
+		subtest_optimized_attach_cross_page();
 	if (test__start_subtest("optimized_red_zone"))
 		subtest_optimized_red_zone();
 #endif
diff --git a/tools/testing/selftests/bpf/usdt_2.c b/tools/testing/selftests/bpf/usdt_2.c
index 5e38f8605b02..3b7024b9b08b 100644
--- a/tools/testing/selftests/bpf/usdt_2.c
+++ b/tools/testing/selftests/bpf/usdt_2.c
@@ -13,6 +13,22 @@ void usdt_2(void)
 	USDT(optimized_attach, usdt_2);
 }
 
+/*
+ * Force the nop1,nop10 combo of the USDT probe to a spot where the nop10
+ * crosses a page boundary: .balign starts the padding exactly at a page
+ * start regardless of the compiler-generated prologue size, and the 4086
+ * one-byte nops put the nop1 at page offset 4086, so the following nop10
+ * occupies the last 9 bytes of that page and 1 byte of the next one.
+ * The kernel can't optimize such nop10, so libbpf must keep the uprobe
+ * on the 1-byte nop.
+ */
+__attribute__((noinline))
+void usdt_2_cross_page(void)
+{
+	asm volatile (".balign 4096, 0x90\n\t.skip 4086, 0x90");
+	USDT(optimized_attach, usdt_2_cross_page);
+}
+
 static volatile unsigned long usdt_red_zone_arg1 = 0xDEADBEEF;
 static volatile unsigned long usdt_red_zone_arg2 = 0xCAFEBABE;
 static volatile unsigned long usdt_red_zone_arg3 = 0xFEEDFACE;
-- 
2.43.0

