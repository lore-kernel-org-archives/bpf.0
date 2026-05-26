Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 376B13559D6;
	Tue, 26 May 2026 21:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779829227; cv=none; b=sNb76rOvvwlRkLJ5+taDczVi9ZXJmlrtwFPc+z6wzv8K7Ts2NgtBElDFfFejR7DtzCcd3GnlwpJlgs7ZyJEiiByz3LI+WoeC657aAxmcoeFSB+cXe+2F48hHQjFpwQD3mY0qkPw+GB8voyXRmEynOfDA9fzRLHUbvr0tzOLi2as=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779829227; c=relaxed/simple;
	bh=D+kXgD31WDnU5q5/234czZPCxC5EUSm1dTTD+LP4tkk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MaNZdNa0tZg9TVU2JNiG/IuTwj1zoKlW/P1lXNxX4Qv4UfClWDKD/YhYNKrIElLSJXAX3pwhT5sv+/PvUPo6YUv0g7PtNSxcKrL6eOIDuSoDXj6KWrc2HUJkDxhcpd43BAKHrYyvlx/8aLmk/IulVjkeQ3VzWlI5DcSF/fkauDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BSgVsji8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BSgVsji8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DE1F1F00A3A;
	Tue, 26 May 2026 21:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779829226;
	bh=H2iJKVew0ulBnXG2iYC/UipilHv0mNH1x0/eG0LMoyw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BSgVsji82Kpg1T1tk/w23gm8/4J6TNGZCxHturJTQaWg09DRSI1LEuoI9Jh+mOAEa
	 nHmw4yByXcSoBOGTUR6W/k9tOkg5P4Zinq00/kaApQXxqEAe7CkKKNysqVyqZPTFuF
	 8rInsVO0MQ59KRKSR1tMJnJfFDY6Tvys4unEvhaXTYvVQZBXQZm7K9hmRZQ+pwqcF5
	 lqTGnSsu4SQWmTLfehIf2mEsQZY7vs20hobFsJaTCKtlyg4KZ5zBn/fg97Vsc0HirJ
	 NT6pCO8G1xePfO+gV3SjVLSOpmGIxj2Y03lZuH99SerNwF/LhDjZUHslRXDzaD6yOk
	 GCvwt5y9OxC8w==
From: Jiri Olsa <jolsa@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCHv4 11/13] selftests/bpf: Add reattach tests for uprobe syscall
Date: Tue, 26 May 2026 22:58:38 +0200
Message-ID: <20260526205840.173790-12-jolsa@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260526205840.173790-1-jolsa@kernel.org>
References: <20260526205840.173790-1-jolsa@kernel.org>
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
 .../selftests/bpf/prog_tests/uprobe_syscall.c | 114 ++++++++++++++++--
 1 file changed, 104 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c b/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
index 0868fb9793e0..969f4deba9fd 100644
--- a/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
+++ b/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
@@ -430,23 +430,28 @@ static void *check_attach(struct uprobe_syscall_executed *skel, trigger_t trigge
 	return tramp;
 }
 
-static void check_detach(void *addr, void *tramp)
+static bool check_detach(void *addr, void *tramp)
 {
 	static const char nop10_prefix[] = { 0x66, 0x2e, 0x0f, 0x1f, 0x84 };
+	bool ok = true;
 
 	/* [uprobes_trampoline] stays after detach */
-	ASSERT_OK(find_uprobes_trampoline(tramp), "uprobes_trampoline");
-	ASSERT_OK(memcmp(addr, nop10_prefix, 5), "nop10_prefix");
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
@@ -457,6 +462,7 @@ static void test_uprobe_legacy(void)
 	);
 	struct bpf_link *link;
 	unsigned long offset;
+	void *tramp;
 
 	offset = get_uprobe_offset(&uprobe_test);
 	if (!ASSERT_GE(offset, 0, "get_uprobe_offset"))
@@ -474,7 +480,28 @@ static void test_uprobe_legacy(void)
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
@@ -496,6 +523,7 @@ static void test_uprobe_multi(void)
 	LIBBPF_OPTS(bpf_uprobe_multi_opts, opts);
 	struct bpf_link *link;
 	unsigned long offset;
+	void *tramp;
 
 	offset = get_uprobe_offset(&uprobe_test);
 	if (!ASSERT_GE(offset, 0, "get_uprobe_offset"))
@@ -516,7 +544,28 @@ static void test_uprobe_multi(void)
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
@@ -540,6 +589,7 @@ static void test_uprobe_session(void)
 	);
 	struct bpf_link *link;
 	unsigned long offset;
+	void *tramp;
 
 	offset = get_uprobe_offset(&uprobe_test);
 	if (!ASSERT_GE(offset, 0, "get_uprobe_offset"))
@@ -559,7 +609,28 @@ static void test_uprobe_session(void)
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
@@ -569,7 +640,7 @@ static void test_uprobe_usdt(void)
 {
 	struct uprobe_syscall_executed *skel;
 	struct bpf_link *link;
-	void *addr;
+	void *addr, *tramp;
 
 	errno = 0;
 	addr = find_nop10(usdt_test);
@@ -588,7 +659,30 @@ static void test_uprobe_usdt(void)
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
2.54.0

