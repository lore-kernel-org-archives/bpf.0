Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90B41157480;
	Mon, 26 Jan 2026 21:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769462374; cv=none; b=AISYpv+vHJOsyn3QUo/fNrY8FSy5lepl2/ftKbrw0NZaS+YxVHRcdRbL0BPSfdU2Ifo0oAth1YR80x3/0DiimGUgWBsUhsCM8gFO3mks+PrgqTc1qOePC5GurH7S8nmSJsiEIhzIjSljFUEoOywTZj/LF4DRxOD3bssGZYWayMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769462374; c=relaxed/simple;
	bh=jHenB7uG5OaeIVSLbTl8ievADyxvLciRLxSUcm+DDZU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IBVKIjWohPbOuUH2F+fNl3XinYPoxo8jNIOddzYVln7JjBf/VS4ccLtUPBxZe/Zbs2iLxZJYSBLpj6aHd3tHwEUhIifZ4oLCMEbOmznIulqBQFMdn5bFPs8ykTEilLb9Z2vWFHaL6mCGmR5KnK4FLKq1lUfGxZEGczwe8uKJmJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dX0YkeK1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dX0YkeK1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6DBDC116C6;
	Mon, 26 Jan 2026 21:19:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769462374;
	bh=jHenB7uG5OaeIVSLbTl8ievADyxvLciRLxSUcm+DDZU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dX0YkeK1LiesbfbI88TXJ16bxZG1tG6WiQ2YIlP63R05vUpyPVWA2xdk/8atrySLl
	 BRQmRL/spQEbTyg8Eaj9i53OXZEyO0dKOsCt6Lwr7MZAOFKvPVJTx3CS9xbi8PyKrH
	 hUWHvbOSVElspgyopbEL2xO8JTcs+JPb6owmC9G/k6jAEAa2OLSSOYsafjjBT7KQqf
	 jkYLWdy7y1MZVzNJqvJjcOzsd+CI91udJE9f30C9nKMldfHHFMwnPO2Fo05kVMwWPd
	 puiWjU8+e08hTE4tVIIUXdhDYPTQMAsaRoG+eiHJLFu/s9FK0D9hdvNh3ldYftV7EN
	 OKbFNsuRLeVEQ==
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
Subject: [PATCHv2 bpf-next 4/6] selftests/bpf: Add stacktrace ips test for kprobe/kretprobe
Date: Mon, 26 Jan 2026 22:18:35 +0100
Message-ID: <20260126211837.472802-5-jolsa@kernel.org>
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

Adding test that attaches kprobe/kretprobe and verifies the
ORC stacktrace matches expected functions.

The test is only for ORC unwinder to keep it simple.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 .../selftests/bpf/prog_tests/stacktrace_ips.c | 50 +++++++++++++++++++
 .../selftests/bpf/progs/stacktrace_ips.c      |  7 +++
 2 files changed, 57 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/stacktrace_ips.c b/tools/testing/selftests/bpf/prog_tests/stacktrace_ips.c
index c93718dafd9b..852830536109 100644
--- a/tools/testing/selftests/bpf/prog_tests/stacktrace_ips.c
+++ b/tools/testing/selftests/bpf/prog_tests/stacktrace_ips.c
@@ -137,6 +137,52 @@ static void test_stacktrace_ips_raw_tp(void)
 	stacktrace_ips__destroy(skel);
 }
 
+static void test_stacktrace_ips_kprobe(bool retprobe)
+{
+	LIBBPF_OPTS(bpf_kprobe_opts, opts,
+		.retprobe = retprobe
+	);
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
+	skel->links.kprobe_test = bpf_program__attach_kprobe_opts(
+						skel->progs.kprobe_test,
+						"bpf_testmod_stacktrace_test", &opts);
+	if (!ASSERT_OK_PTR(skel->links.kprobe_test, "bpf_program__attach_kprobe_opts"))
+		goto cleanup;
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
@@ -145,6 +191,10 @@ static void __test_stacktrace_ips(void)
 		test_stacktrace_ips_kprobe_multi(true);
 	if (test__start_subtest("raw_tp"))
 		test_stacktrace_ips_raw_tp();
+	if (test__start_subtest("kprobe"))
+		test_stacktrace_ips_kprobe(false);
+	if (test__start_subtest("kretprobe"))
+		test_stacktrace_ips_kprobe(true);
 }
 #else
 static void __test_stacktrace_ips(void)
diff --git a/tools/testing/selftests/bpf/progs/stacktrace_ips.c b/tools/testing/selftests/bpf/progs/stacktrace_ips.c
index a96c8150d7f5..cae077a4061b 100644
--- a/tools/testing/selftests/bpf/progs/stacktrace_ips.c
+++ b/tools/testing/selftests/bpf/progs/stacktrace_ips.c
@@ -31,6 +31,13 @@ int unused(void)
 
 __u32 stack_key;
 
+SEC("kprobe")
+int kprobe_test(struct pt_regs *ctx)
+{
+	stack_key = bpf_get_stackid(ctx, &stackmap, 0);
+	return 0;
+}
+
 SEC("kprobe.multi")
 int kprobe_multi_test(struct pt_regs *ctx)
 {
-- 
2.52.0

