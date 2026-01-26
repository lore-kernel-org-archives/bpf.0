Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A93452E03E3;
	Mon, 26 Jan 2026 21:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769462386; cv=none; b=C8UM7sPytGXye33fbtzyAzSKC3txY3UXKMTg4PbZjPcCeOeyNKO4xOchnx5E00OgUrhFnORHujB7ldAZeH40n/amymu0TBJYMWPDgy34Eu9+1vM+hOzERuI7PnkYOwOFQEJa13qRQQ9Erj3gR6jRJCVIlF6RU5gARXeAZ5NyGrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769462386; c=relaxed/simple;
	bh=f5CjdbtvfI7lSsK0TYfvFetqD0ElgrRjgzKIn4A46QA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TLNZkwr/b0wyzkAuQZwaawAaKVhqDnDggIMZDSwfmXpd9PL8Uhj242vcTRACZ9FoQBRnx9KouSytUGZXI2EneKScQ3/gh8ie1LY+/uYiIN7HPuDDF8fGLh2WWRzBCzwFE9fIX3NxWrdRCrL5DUSjsHuO9egvNc7K4rQTVQUHloc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OfBVmSri; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OfBVmSri"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F559C116C6;
	Mon, 26 Jan 2026 21:19:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769462386;
	bh=f5CjdbtvfI7lSsK0TYfvFetqD0ElgrRjgzKIn4A46QA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OfBVmSrifjuBRckOXslWbJRI/2DcRmX0hZ4ZJIG5bKiQ69OichrxGli+8HzK5ulUc
	 8PDz0BTffTT73WgELBcQa+M16ngyzW1Qx1zaSZ9OMNrfy/aU0wqG1F7chjPrAAzwTN
	 OpMYOClv9iJhOLTmeLLUhGNB0BgoqRMyLZWfOjiHrA6nHnqmfaRqRlqFKWrF89BfWd
	 NXXD5IMOuddZaEHla1JdKiVmD7GShyGRIi0+dbUkcYA7k5fDY5j315CsIURd3zX5PC
	 V+DNsuJujXMt3J2IO7r82HmZyoINGc7BDktj/g32Dks33a3mRqD0cEG/+PHTVPCW+e
	 hnr6Oah55i1Mw==
From: Jiri Olsa <jolsa@kernel.org>
To: Masami Hiramatsu <mhiramat@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
	bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	x86@kernel.org,
	Yonghong Song <yhs@fb.com>,
	Song Liu <songliubraving@fb.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Mahe Tardy <mahe.tardy@gmail.com>
Subject: [PATCHv2 bpf-next 5/6] selftests/bpf: Add stacktrace ips test for fentry/fexit
Date: Mon, 26 Jan 2026 22:18:36 +0100
Message-ID: <20260126211837.472802-6-jolsa@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260126211837.472802-1-jolsa@kernel.org>
References: <20260126211837.472802-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adding test that attaches fentry/fexitand verifies the
ORC stacktrace matches expected functions.

The test is only for ORC unwinder to keep it simple.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 .../selftests/bpf/prog_tests/stacktrace_ips.c | 51 +++++++++++++++++++
 .../selftests/bpf/progs/stacktrace_ips.c      | 20 ++++++++
 2 files changed, 71 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/stacktrace_ips.c b/tools/testing/selftests/bpf/prog_tests/stacktrace_ips.c
index 852830536109..da42b00e3d1f 100644
--- a/tools/testing/selftests/bpf/prog_tests/stacktrace_ips.c
+++ b/tools/testing/selftests/bpf/prog_tests/stacktrace_ips.c
@@ -183,6 +183,53 @@ static void test_stacktrace_ips_kprobe(bool retprobe)
 	stacktrace_ips__destroy(skel);
 }
 
+static void test_stacktrace_ips_trampoline(bool retprobe)
+{
+	LIBBPF_OPTS(bpf_test_run_opts, topts);
+	struct stacktrace_ips *skel;
+
+	skel = stacktrace_ips__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "stacktrace_ips__open_and_load"))
+		return;
+
+	if (!skel->kconfig->CONFIG_UNWINDER_ORC) {
+		test__skip();
+		goto cleanup;
+	}
+
+	if (retprobe) {
+		skel->links.fexit_test = bpf_program__attach_trace(skel->progs.fexit_test);
+		if (!ASSERT_OK_PTR(skel->links.fexit_test, "bpf_program__attach_trace"))
+			goto cleanup;
+	} else {
+		skel->links.fentry_test = bpf_program__attach_trace(skel->progs.fentry_test);
+		if (!ASSERT_OK_PTR(skel->links.fentry_test, "bpf_program__attach_trace"))
+			goto cleanup;
+	}
+
+	trigger_module_test_read(1);
+
+	load_kallsyms();
+
+	if (retprobe) {
+		check_stacktrace_ips(bpf_map__fd(skel->maps.stackmap), skel->bss->stack_key, 4,
+				     ksym_get_addr("bpf_testmod_stacktrace_test_3"),
+				     ksym_get_addr("bpf_testmod_stacktrace_test_2"),
+				     ksym_get_addr("bpf_testmod_stacktrace_test_1"),
+				     ksym_get_addr("bpf_testmod_test_read"));
+	} else {
+		check_stacktrace_ips(bpf_map__fd(skel->maps.stackmap), skel->bss->stack_key, 5,
+				     ksym_get_addr("bpf_testmod_stacktrace_test"),
+				     ksym_get_addr("bpf_testmod_stacktrace_test_3"),
+				     ksym_get_addr("bpf_testmod_stacktrace_test_2"),
+				     ksym_get_addr("bpf_testmod_stacktrace_test_1"),
+				     ksym_get_addr("bpf_testmod_test_read"));
+	}
+
+cleanup:
+	stacktrace_ips__destroy(skel);
+}
+
 static void __test_stacktrace_ips(void)
 {
 	if (test__start_subtest("kprobe_multi"))
@@ -195,6 +242,10 @@ static void __test_stacktrace_ips(void)
 		test_stacktrace_ips_kprobe(false);
 	if (test__start_subtest("kretprobe"))
 		test_stacktrace_ips_kprobe(true);
+	if (test__start_subtest("fentry"))
+		test_stacktrace_ips_trampoline(false);
+	if (test__start_subtest("fexit"))
+		test_stacktrace_ips_trampoline(true);
 }
 #else
 static void __test_stacktrace_ips(void)
diff --git a/tools/testing/selftests/bpf/progs/stacktrace_ips.c b/tools/testing/selftests/bpf/progs/stacktrace_ips.c
index cae077a4061b..6830f2978613 100644
--- a/tools/testing/selftests/bpf/progs/stacktrace_ips.c
+++ b/tools/testing/selftests/bpf/progs/stacktrace_ips.c
@@ -53,4 +53,24 @@ int rawtp_test(void *ctx)
 	return 0;
 }
 
+SEC("fentry/bpf_testmod_stacktrace_test")
+int fentry_test(struct pt_regs *ctx)
+{
+	/*
+	 * Skip 2 bpf_program/trampoline stack entries:
+	 * - bpf_prog_bd1f7a949f55fb03_fentry_test
+	 * - bpf_trampoline_182536277701
+	 */
+	stack_key = bpf_get_stackid(ctx, &stackmap, 2);
+	return 0;
+}
+
+SEC("fexit/bpf_testmod_stacktrace_test")
+int fexit_test(struct pt_regs *ctx)
+{
+	/* Skip 2 bpf_program/trampoline stack entries, check fentry_test. */
+	stack_key = bpf_get_stackid(ctx, &stackmap, 2);
+	return 0;
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.52.0

