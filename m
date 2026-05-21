Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BB253D4120;
	Thu, 21 May 2026 12:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779367554; cv=none; b=XOCuoxFEsLVM/tK9chx1ox5dATjpYsIU3S4BcBcDfDUkLGU3eKHlVx/ke5RQrmAxw6PYghOo68vNf/ga2PKIYCHVXqtej0PQWl5u5aKiYMPBs2FZFIaNn36WaNtosIThsDKQ6F0tFYKK1iChZkYN/Qay/XE8Hd7GllyVx8YDAik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779367554; c=relaxed/simple;
	bh=0XeVwpOTaC6nGGPv68jAk7teCl5i0R0UWvwGkK72tvI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ID/UASShK9wss3Jlz4MDVAV4RtgNGD1U0Q0nsBiUKJ9alnaGJHYwFYhbmRFF59YCHdlMRHVXuLMoIPq8I3IiH7AJzYUR3+ru5pf66V/i4XvaDSl3+v7hjUXW85R9Swbl8dTUe+TA+2Xb5GR5wlYSFHgPVeMixwuBgy/YD3Md6y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nDR2IA4Z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nDR2IA4Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 931BE1F000E9;
	Thu, 21 May 2026 12:45:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779367552;
	bh=r9th46JD2C/sVZV1Wmn6EQL5oOryeoMjHIEBOJT93Zw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nDR2IA4ZbkMHyQr0V+tsQbcxdWUnps3zdvN/emFpqBR0jj2rSBr99GvlzbHVK4sko
	 byzUSgdnB0YO9gPjkcfbMCKHWlp5gZjBkfYfLza0RlOyFtrraBgX/15EhFB24f/oq1
	 4FbGbF3+UnBvy8bGOj8DX8RzA6+Ok8WN98V11t8YRlC9U02iGv+LVwt8AVsSlQA+AY
	 jnINEFT49sgOsJ8aM94qT7Z1Qhb/s5QHb+rVXHLh6PvkRBYVaqsaJdODd1qzsjFowA
	 uU0TjTmApqDp/iBXy1/y/Y94e4LK7WGUXMkOQHtoeYnjFoWh+hKeRUcj1Q6ogRTEuv
	 i5XwHwG9MFFvg==
From: Jiri Olsa <jolsa@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCHv3 10/12] selftests/bpf: Add reattach tests for uprobe syscall
Date: Thu, 21 May 2026 14:44:09 +0200
Message-ID: <20260521124411.31133-11-jolsa@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260521124411.31133-1-jolsa@kernel.org>
References: <20260521124411.31133-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adding reattach tests for uprobe syscall tests to make sure
we can re-attach and optimize same uprobe multiple times.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 .../selftests/bpf/prog_tests/uprobe_syscall.c | 116 ++++++++++++++++--
 1 file changed, 106 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c b/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
index 9653fb5608f2..969f4deba9fd 100644
--- a/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
+++ b/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
@@ -430,21 +430,28 @@ static void *check_attach(struct uprobe_syscall_executed *skel, trigger_t trigge
 	return tramp;
 }
 
-static void check_detach(void *addr, void *tramp)
+static bool check_detach(void *addr, void *tramp)
 {
+	static const char nop10_prefix[] = { 0x66, 0x2e, 0x0f, 0x1f, 0x84 };
+	bool ok = true;
+
 	/* [uprobes_trampoline] stays after detach */
-	ASSERT_OK(find_uprobes_trampoline(tramp), "uprobes_trampoline");
-	ASSERT_OK(memcmp(addr, jmp2B, 2), "jmp2B");
+	if (!ASSERT_OK(find_uprobes_trampoline(tramp), "uprobes_trampoline"))
+		ok = false;
+	if (!ASSERT_OK(memcmp(addr, nop10_prefix, 5), "nop10_prefix"))
+		ok = false;
+	return ok;
 }
 
-static void check(struct uprobe_syscall_executed *skel, struct bpf_link *link,
-		  trigger_t trigger, void *addr, int executed)
+static void *check(struct uprobe_syscall_executed *skel, struct bpf_link *link,
+		   trigger_t trigger, void *addr, int executed)
 {
 	void *tramp;
 
 	tramp = check_attach(skel, trigger, addr, executed);
 	bpf_link__destroy(link);
 	check_detach(addr, tramp);
+	return tramp;
 }
 
 static void test_uprobe_legacy(void)
@@ -455,6 +462,7 @@ static void test_uprobe_legacy(void)
 	);
 	struct bpf_link *link;
 	unsigned long offset;
+	void *tramp;
 
 	offset = get_uprobe_offset(&uprobe_test);
 	if (!ASSERT_GE(offset, 0, "get_uprobe_offset"))
@@ -472,7 +480,28 @@ static void test_uprobe_legacy(void)
 	if (!ASSERT_OK_PTR(link, "bpf_program__attach_uprobe_opts"))
 		goto cleanup;
 
-	check(skel, link, uprobe_test, uprobe_test, 2);
+	tramp = check(skel, link, uprobe_test, uprobe_test, 2);
+
+	/* reattach and detach without triggering optimization */
+	link = bpf_program__attach_uprobe_opts(skel->progs.test_uprobe,
+					       0, "/proc/self/exe", offset, NULL);
+	if (!ASSERT_OK_PTR(link, "bpf_program__attach_uprobe_opts"))
+		goto cleanup;
+
+	bpf_link__destroy(link);
+	if (!check_detach(uprobe_test, tramp))
+		goto cleanup;
+
+	uprobe_test();
+	ASSERT_EQ(skel->bss->executed, 2, "executed_no_probe");
+
+	/* reattach with triggering optimization */
+	link = bpf_program__attach_uprobe_opts(skel->progs.test_uprobe,
+				0, "/proc/self/exe", offset, NULL);
+	if (!ASSERT_OK_PTR(link, "bpf_program__attach_uprobe_opts"))
+		goto cleanup;
+
+	check(skel, link, uprobe_test, uprobe_test, 4);
 
 	/* uretprobe */
 	skel->bss->executed = 0;
@@ -494,6 +523,7 @@ static void test_uprobe_multi(void)
 	LIBBPF_OPTS(bpf_uprobe_multi_opts, opts);
 	struct bpf_link *link;
 	unsigned long offset;
+	void *tramp;
 
 	offset = get_uprobe_offset(&uprobe_test);
 	if (!ASSERT_GE(offset, 0, "get_uprobe_offset"))
@@ -514,7 +544,28 @@ static void test_uprobe_multi(void)
 	if (!ASSERT_OK_PTR(link, "bpf_program__attach_uprobe_multi"))
 		goto cleanup;
 
-	check(skel, link, uprobe_test, uprobe_test, 2);
+	tramp = check(skel, link, uprobe_test, uprobe_test, 2);
+
+	/* reattach and detach without triggering optimization */
+	link = bpf_program__attach_uprobe_multi(skel->progs.test_uprobe_multi,
+				0, "/proc/self/exe", NULL, &opts);
+	if (!ASSERT_OK_PTR(link, "bpf_program__attach_uprobe_multi"))
+		goto cleanup;
+
+	bpf_link__destroy(link);
+	if (!check_detach(uprobe_test, tramp))
+		goto cleanup;
+
+	uprobe_test();
+	ASSERT_EQ(skel->bss->executed, 2, "executed_no_probe");
+
+	/* reattach with triggering optimization */
+	link = bpf_program__attach_uprobe_multi(skel->progs.test_uprobe_multi,
+				0, "/proc/self/exe", NULL, &opts);
+	if (!ASSERT_OK_PTR(link, "bpf_program__attach_uprobe_multi"))
+		goto cleanup;
+
+	check(skel, link, uprobe_test, uprobe_test, 4);
 
 	/* uretprobe.multi */
 	skel->bss->executed = 0;
@@ -538,6 +589,7 @@ static void test_uprobe_session(void)
 	);
 	struct bpf_link *link;
 	unsigned long offset;
+	void *tramp;
 
 	offset = get_uprobe_offset(&uprobe_test);
 	if (!ASSERT_GE(offset, 0, "get_uprobe_offset"))
@@ -557,7 +609,28 @@ static void test_uprobe_session(void)
 	if (!ASSERT_OK_PTR(link, "bpf_program__attach_uprobe_multi"))
 		goto cleanup;
 
-	check(skel, link, uprobe_test, uprobe_test, 4);
+	tramp = check(skel, link, uprobe_test, uprobe_test, 4);
+
+	/* reattach and detach without triggering optimization */
+	link = bpf_program__attach_uprobe_multi(skel->progs.test_uprobe_session,
+				0, "/proc/self/exe", NULL, &opts);
+	if (!ASSERT_OK_PTR(link, "bpf_program__attach_uprobe_multi"))
+		goto cleanup;
+
+	bpf_link__destroy(link);
+	if (!check_detach(uprobe_test, tramp))
+		goto cleanup;
+
+	uprobe_test();
+	ASSERT_EQ(skel->bss->executed, 4, "executed_no_probe");
+
+	/* reattach with triggering optimization */
+	link = bpf_program__attach_uprobe_multi(skel->progs.test_uprobe_session,
+				0, "/proc/self/exe", NULL, &opts);
+	if (!ASSERT_OK_PTR(link, "bpf_program__attach_uprobe_multi"))
+		goto cleanup;
+
+	check(skel, link, uprobe_test, uprobe_test, 8);
 
 cleanup:
 	uprobe_syscall_executed__destroy(skel);
@@ -567,7 +640,7 @@ static void test_uprobe_usdt(void)
 {
 	struct uprobe_syscall_executed *skel;
 	struct bpf_link *link;
-	void *addr;
+	void *addr, *tramp;
 
 	errno = 0;
 	addr = find_nop10(usdt_test);
@@ -586,7 +659,30 @@ static void test_uprobe_usdt(void)
 	if (!ASSERT_OK_PTR(link, "bpf_program__attach_usdt"))
 		goto cleanup;
 
-	check(skel, link, usdt_test, addr, 2);
+	tramp = check(skel, link, usdt_test, addr, 2);
+
+	/* reattach and detach without triggering optimization */
+	link = bpf_program__attach_usdt(skel->progs.test_usdt,
+				-1 /* all PIDs */, "/proc/self/exe",
+				"optimized_uprobe", "usdt", NULL);
+	if (!ASSERT_OK_PTR(link, "bpf_program__attach_usdt"))
+		goto cleanup;
+
+	bpf_link__destroy(link);
+	if (!check_detach(addr, tramp))
+		goto cleanup;
+
+	usdt_test();
+	ASSERT_EQ(skel->bss->executed, 2, "executed_no_probe");
+
+	/* reattach with triggering optimization */
+	link = bpf_program__attach_usdt(skel->progs.test_usdt,
+				-1 /* all PIDs */, "/proc/self/exe",
+				"optimized_uprobe", "usdt", NULL);
+	if (!ASSERT_OK_PTR(link, "bpf_program__attach_usdt"))
+		goto cleanup;
+
+	check(skel, link, usdt_test, addr, 4);
 
 cleanup:
 	uprobe_syscall_executed__destroy(skel);
-- 
2.53.0

