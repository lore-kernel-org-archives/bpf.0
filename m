Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87FBE3D3326;
	Mon, 18 May 2026 11:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779102090; cv=none; b=qfb3jOYsdb3IIAUzRvZnkrL8mJsOozi6m365uQoRBD9BozwYgYEHODM2ltJW3HgvhNIvBAZp9IwNuDwG1UXENPo0COPpcLfhlgDGu2/kxzNF82Nn0mv6SxivZF/lBuy2v7Hm3Nh1PLjYXlOH+eXLl+GnxbSz8f+nc1OYBb9QNP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779102090; c=relaxed/simple;
	bh=6qRisYUewPQrwQgfo7iXLIPDLMkbLCXqfZVLhdIbPfg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GoRJfOgtge9wuDFHIwLU8JXJ2+BiIwwq8cQaCq2V6f7WUYGJke+JljztGWBPVtL7jkoBFnAPmlj2sRNlWkoarKd4thmViZoRtKpqnoNuCI4Jzvp2nLhmvxkOnuu+67OF3XsCl1crCcnt+3ysvIFsuzbDYsVNkRDui9PgDsCGeB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P+KrzcuO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P+KrzcuO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0823C2BCB7;
	Mon, 18 May 2026 11:01:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779102088;
	bh=6qRisYUewPQrwQgfo7iXLIPDLMkbLCXqfZVLhdIbPfg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=P+KrzcuO9CdXw94K/tWchpUVoDgWOCcFE9AjMC1YMqn9RsFQxYpWnTcAOEK98TlOA
	 MozHBGOV9tcEqooW5mOGBVLk+YT7xnMPB+QPDG33yR1B/WZMu8d3/3PXPnL+aTFFZq
	 5g7nQL3hYHa8H2wR4fnISHA+PY+kSj3d36FV3NN0E4k8jOXWsVBdMhgulxj2/nSbfx
	 liYpxhc9rFOeJK7OHxXe74vjhS4XwqHjE4u/5/nVOXBMXMdPN8R2wAoHlIFJZnLcoV
	 VioaXwegSKD4AhWlLT9udnKSJW2nNiIoBwwQuWsi760YIvzmwFPKDz1lWsBd6pijXg
	 sRVY3OOXmkjjw==
From: Jiri Olsa <jolsa@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCHv2 09/11] selftests/bpf: Add reattach tests for uprobe syscall
Date: Mon, 18 May 2026 12:59:55 +0200
Message-ID: <20260518105957.123445-10-jolsa@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260518105957.123445-1-jolsa@kernel.org>
References: <20260518105957.123445-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adding reattach tests for uprobe syscall tests to make sure
we can re-attach and optimize same uprobe multiple times.

The reason is that optimized uprobe does not restore original
nop10 after detach, but instead it uses 'jmp 8' instruction.

Making sure we can still install and optimize uprobe on top
of the 'jmp 8' instruction.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 .../selftests/bpf/prog_tests/uprobe_syscall.c | 115 ++++++++++++++++--
 1 file changed, 105 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c b/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
index e4a19dc9df69..e88b316a3f2c 100644
--- a/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
+++ b/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
@@ -431,21 +431,27 @@ static void *check_attach(struct uprobe_syscall_executed *skel, trigger_t trigge
 	return tramp;
 }
 
-static void check_detach(void *addr, void *tramp)
+static bool check_detach(void *addr, void *tramp)
 {
+	bool ok = true;
+
 	/* [uprobes_trampoline] stays after detach */
-	ASSERT_OK(find_uprobes_trampoline(tramp), "uprobes_trampoline");
-	ASSERT_OK(memcmp(addr, jmp2B, 2), "jmp2B");
+	if (!ASSERT_OK(find_uprobes_trampoline(tramp), "uprobes_trampoline"))
+		ok = false;
+	if (!ASSERT_OK(memcmp(addr, jmp2B, 2), "jmp2B"))
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
@@ -456,6 +462,7 @@ static void test_uprobe_legacy(void)
 	);
 	struct bpf_link *link;
 	unsigned long offset;
+	void *tramp;
 
 	offset = get_uprobe_offset(&uprobe_test);
 	if (!ASSERT_GE(offset, 0, "get_uprobe_offset"))
@@ -473,7 +480,28 @@ static void test_uprobe_legacy(void)
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
@@ -495,6 +523,7 @@ static void test_uprobe_multi(void)
 	LIBBPF_OPTS(bpf_uprobe_multi_opts, opts);
 	struct bpf_link *link;
 	unsigned long offset;
+	void *tramp;
 
 	offset = get_uprobe_offset(&uprobe_test);
 	if (!ASSERT_GE(offset, 0, "get_uprobe_offset"))
@@ -515,7 +544,28 @@ static void test_uprobe_multi(void)
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
@@ -539,6 +589,7 @@ static void test_uprobe_session(void)
 	);
 	struct bpf_link *link;
 	unsigned long offset;
+	void *tramp;
 
 	offset = get_uprobe_offset(&uprobe_test);
 	if (!ASSERT_GE(offset, 0, "get_uprobe_offset"))
@@ -558,7 +609,28 @@ static void test_uprobe_session(void)
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
@@ -568,7 +640,7 @@ static void test_uprobe_usdt(void)
 {
 	struct uprobe_syscall_executed *skel;
 	struct bpf_link *link;
-	void *addr;
+	void *addr, *tramp;
 
 	errno = 0;
 	addr = find_nop10(usdt_test);
@@ -587,7 +659,30 @@ static void test_uprobe_usdt(void)
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

