Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F6A33B47F7;
	Wed,  1 Jul 2026 11:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782904545; cv=none; b=eP1q42bXK6T9LZEUApoA1elc9SDiD5tFbz9ZaW2d7dYPXAEgoOZdFe+GWdKNiT5zV4KuVCVD/Y+zzmcCyjaqcIVAuscxOs22NSxmu5hn3DGGpd2r7b5Ov3D85nWyng5vpVs4JMAkj8T/0uvRQlvG0pm3dBpxfBLYLkZ7ZdEiH+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782904545; c=relaxed/simple;
	bh=u36Jgwty3fAXzW+vua7eADq/gYDm5AV5hUVRpg2Z4gY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V8jkOQod8dQvjcLLYohaeA8urplsDvdapWylkuisM90yGOPN8PsXSBPpKlyKP8azXn//S5ItJ/gw/uM/LNS4cWpW0H0SvJxHkFqz4RN6yFFYTGJhCxj/7DfAoQ1KE4HuqeBd1wsNBF5ZhowzIzdUtbcxKOCOl9X8l8gfHKJXUxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jYYsgIG0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jYYsgIG0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BE6F1F000E9;
	Wed,  1 Jul 2026 11:15:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782904544;
	bh=wjI3X0+PWVS1zeujionbVM3gve4kTilxCZBaJp68tNo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jYYsgIG0LSfqPeW7CBW/uKIXahMw+NzJMNo6C0lqwXWszKa3vfUGKEDRY8G/1cCCa
	 ghfauP5+pYg2SywAu37+KfPiEIw0BN0DNFDjjuVF8Vid6MUQPIW/3yRXhgFp5VDE5T
	 YA6NczTKsFb4hvtxDCgqrQTHZEUx4o5eoJUz36h96H2TMTdaqcb5lEh0TZTF0R1qy2
	 7sZsCK8QPj2O8v4pDOhX7Jcs8n6LGsa07FhjW9DIE2gYd/ZW472Q/t+GuRESLIF1ih
	 4vLY08dkipQFgrZD0IPJyuyjmxe09mN1QGu6GmxFIWcbs7UTXyAYLkP5rL8XBfuW9c
	 bxJVOD1Mlww3Q==
From: Jiri Olsa <jolsa@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCHv5 11/13] selftests/bpf: Add reattach tests for uprobe syscall
Date: Wed,  1 Jul 2026 13:13:35 +0200
Message-ID: <20260701111337.53943-12-jolsa@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260701111337.53943-1-jolsa@kernel.org>
References: <20260701111337.53943-1-jolsa@kernel.org>
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
 .../selftests/bpf/prog_tests/uprobe_syscall.c | 130 ++++++++++++++++--
 1 file changed, 120 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c b/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
index ba50071ace40..7711018f8acd 100644
--- a/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
+++ b/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
@@ -404,6 +404,16 @@ static void *find_nop10(void *fn)
 
 typedef void (__attribute__((nocf_check)) *trigger_t)(void);
 
+static void check_attach_notrigger(struct uprobe_syscall_executed *skel,
+				   void *addr, int executed)
+{
+	unsigned char *op = addr;
+
+	/* Make sure bpf program was not executed. */
+	ASSERT_EQ(skel->bss->executed, executed, "executed");
+	ASSERT_EQ(*op, 0xcc, "int3");
+}
+
 static void *check_attach(struct uprobe_syscall_executed *skel, trigger_t trigger,
 			  void *addr, int executed)
 {
@@ -430,23 +440,26 @@ static void *check_attach(struct uprobe_syscall_executed *skel, trigger_t trigge
 	return tramp;
 }
 
-static void check_detach(void *addr, void *tramp)
+static bool check_detach(void *addr, void *tramp)
 {
 	static const unsigned char nop10_prefix[] = { 0x66, 0x2e, 0x0f, 0x1f, 0x84 };
+	bool ok = true;
 
 	/* [uprobes_trampoline] stays after detach */
-	ASSERT_OK(find_uprobes_trampoline(tramp), "uprobes_trampoline");
-	ASSERT_OK(memcmp(addr, nop10_prefix, 5), "nop10_prefix");
+	ok &= ASSERT_OK(find_uprobes_trampoline(tramp), "uprobes_trampoline");
+	ok &= ASSERT_OK(memcmp(addr, nop10_prefix, 5), "nop10_prefix");
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
@@ -457,6 +470,7 @@ static void test_uprobe_legacy(void)
 	);
 	struct bpf_link *link;
 	unsigned long offset;
+	void *tramp;
 
 	offset = get_uprobe_offset(&uprobe_test);
 	if (!ASSERT_GE(offset, 0, "get_uprobe_offset"))
@@ -474,7 +488,30 @@ static void test_uprobe_legacy(void)
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
+	check_attach_notrigger(skel, uprobe_test, 2);
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
@@ -496,6 +533,7 @@ static void test_uprobe_multi(void)
 	LIBBPF_OPTS(bpf_uprobe_multi_opts, opts);
 	struct bpf_link *link;
 	unsigned long offset;
+	void *tramp;
 
 	offset = get_uprobe_offset(&uprobe_test);
 	if (!ASSERT_GE(offset, 0, "get_uprobe_offset"))
@@ -516,7 +554,30 @@ static void test_uprobe_multi(void)
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
+	check_attach_notrigger(skel, uprobe_test, 2);
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
@@ -540,6 +601,7 @@ static void test_uprobe_session(void)
 	);
 	struct bpf_link *link;
 	unsigned long offset;
+	void *tramp;
 
 	offset = get_uprobe_offset(&uprobe_test);
 	if (!ASSERT_GE(offset, 0, "get_uprobe_offset"))
@@ -559,7 +621,30 @@ static void test_uprobe_session(void)
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
+	check_attach_notrigger(skel, uprobe_test, 4);
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
@@ -569,7 +654,7 @@ static void test_uprobe_usdt(void)
 {
 	struct uprobe_syscall_executed *skel;
 	struct bpf_link *link;
-	void *addr;
+	void *addr, *tramp;
 
 	errno = 0;
 	addr = find_nop10(usdt_test);
@@ -588,7 +673,32 @@ static void test_uprobe_usdt(void)
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
+	check_attach_notrigger(skel, addr, 2);
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

