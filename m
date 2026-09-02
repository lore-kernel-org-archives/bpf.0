Received: from sender-pp-o93.zoho.in (sender-pp-o93.zoho.in [103.117.158.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 770BA4A384D
	for <bpf@vger.kernel.org>; Wed,  2 Sep 2026 15:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=103.117.158.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788361546; cv=pass; b=qloXZ96iv7fIarohPNmgDTfGPdDd2S7FKMU/SAVCdZWoFVgpKxJcS/yWDMmyaOe+rxBLGomBpPkZVcP9TUlNX0/9CuDsF/dWatSCfklzkgC8c5PiaPv6mygcNLyEqS9dGyM1+tGjQGOT8attiOnuhYNlP29MVtp/gYXq3Hdi3ik=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788361546; c=relaxed/simple;
	bh=IouXDEnDc5MbubEz7Rk2+taQ78zxS36zvijdhmx8m3A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=N5M8J0wbl5oVautTiSlBsR/YG2Q/lkCNE3WDIVJD2Z8Dt3ux/lEEZnEscGo9EgkxeUuSK8Btgc8Og7+vfYmQuKNQzpcj1IVpIbzvPgBm9KtGglsEKlyxr4LIcnd1afea5HMIuoy4tH3L6XFP0407Tqtz0+5abbGlVC6/VNiNkAQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.in; spf=pass smtp.mailfrom=zohomail.in; dkim=pass (1024-bit key) header.d=zohomail.in header.i=adi.sharma@zohomail.in header.b=Tou7qhDL; arc=pass smtp.client-ip=103.117.158.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.in
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.in header.i=adi.sharma@zohomail.in header.b="Tou7qhDL"
ARC-Seal: i=1; a=rsa-sha256; t=1788361494; cv=none; 
	d=zohomail.in; s=zohoarc; 
	b=MDCo40wxPNJtjR/DDGQ28im18BPyI1XmbQ3PjFdr0/S92yeMwMiuJ1YtkeUR2GrgRaupm8P2RJU1Lwu+cXmRc04x3PwJACLVJJMyNrE66bEPDBv/p7xRGNNNElSIzgfgF6lEHJ7FjvxnUIQB3ye+M4PoljBC8SDSqUlQpAulQN0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in; s=zohoarc; 
	t=1788361494; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=lvCRkcY8laT/MWxvPQDaANuS3kDizBBC0Z2t88+rPzU=; 
	b=cbhuoYEvmj1pibSj4mzfxRre4QxM3qKbIi2VzogG0+AO87L0baYrZ2gItYLA3Qt3dCkaq4Ke5JXcihfd9AFH6FMLJAYDwwtiPwEOpa+HAVq4jqHeuo5e0FlcwiitO4EWsvexzuXpLYjWh3ELJIxvlMTnSmD+ZrB6EPIVq3gdmuc=
ARC-Authentication-Results: i=1; mx.zohomail.in;
	dkim=pass  header.i=zohomail.in;
	spf=pass  smtp.mailfrom=adi.sharma@zohomail.in;
	dmarc=pass header.from=<adi.sharma@zohomail.in>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1788361494;
	s=zoho; d=zohomail.in; i=adi.sharma@zohomail.in;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=lvCRkcY8laT/MWxvPQDaANuS3kDizBBC0Z2t88+rPzU=;
	b=Tou7qhDLeSXOZRL2Z7DyOTIbHXCDI1OjjuilRaEwU4rcXMH79fa3QDfNN2IBje9U
	W/8BWb/blWpOcMFn13SwGh9YwsRydMzM05X/ZvSaHzMfNGFKYzsYVDHp+O+IjaGjK8s
	dMwtNe9RGs7MFfZWkfCt7WwCX3xoq//rk+W/aFEY=
Received: by mx.zoho.in with SMTPS id 1788361492580263.03799506135533;
	Wed, 2 Sep 2026 20:34:52 +0530 (IST)
From: Aditya Sharma <adi.sharma@zohomail.in>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	yonghong.song@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	jolsa@kernel.org,
	kpsingh@kernel.org,
	shuah@kernel.org,
	puranjay@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Aditya Sharma <adi.sharma@zohomail.in>
Subject: [PATCH bpf-next 2/2] selftests/bpf: Test bpf_send_signal_task() from kernel thread context
Date: Wed,  2 Sep 2026 20:34:39 +0530
Message-Id: <20260902150439.692725-2-adi.sharma@zohomail.in>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260902150439.692725-1-adi.sharma@zohomail.in>
References: <20260902150439.692725-1-adi.sharma@zohomail.in>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

The existing send_signal tests, including the _remote variants that
exercise bpf_send_signal_task() with a caller-supplied target, all
gate on

  if ((bpf_get_current_pid_tgid() >> 32) == pid)

so the BPF program only ever runs while current is the test process.
The caller-context dimension is therefore untested, which is how
bpf_send_signal_task() failing from kernel thread context went
unnoticed.

Add a program attached to tp_btf/workqueue_execute_start, where
current is always a kworker. It cannot filter on current, so it is
driven by target_pid alone, and the test asserts the child receives
the signal. Setting pid to 0 leaves the pre-existing programs in the
skeleton inert. Workqueues run on their own, so nothing has to be
triggered from userspace.

Without narrowing down the nmi_uaccess_okay() check to task == current,
this test fails on x86.

Assisted-by: Claude:claude-opus-5
Signed-off-by: Aditya Sharma <adi.sharma@zohomail.in>
---
 .../selftests/bpf/prog_tests/send_signal.c    | 104 ++++++++++++++++++
 .../bpf/progs/test_send_signal_kern.c         |  26 +++++
 2 files changed, 130 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/send_signal.c b/tools/testing/selftests/bpf/prog_tests/send_signal.c
index 7ac4d5a488aa..f9dd23db1ef9 100644
--- a/tools/testing/selftests/bpf/prog_tests/send_signal.c
+++ b/tools/testing/selftests/bpf/prog_tests/send_signal.c
@@ -261,6 +261,108 @@ static void test_send_signal_nmi(bool signal_thread, bool remote)
 	test_send_signal_common(&attr, signal_thread, remote);
 }
 
+static void test_send_signal_kworker(void)
+{
+	struct test_send_signal_kern *skel;
+	int pipe_c2p[2], pipe_p2c[2];
+	struct sigaction sa = {};
+	char buf[256];
+	int err = -1;
+	pid_t pid;
+
+	if (!ASSERT_OK(pipe(pipe_c2p), "pipe_c2p"))
+		return;
+
+	if (!ASSERT_OK(pipe(pipe_p2c), "pipe_p2c")) {
+		close(pipe_c2p[0]);
+		close(pipe_c2p[1]);
+		return;
+	}
+
+	pid = fork();
+	if (!ASSERT_GE(pid, 0, "fork")) {
+		close(pipe_c2p[0]);
+		close(pipe_c2p[1]);
+		close(pipe_p2c[0]);
+		close(pipe_p2c[1]);
+		return;
+	}
+
+	if (pid == 0) {
+		/* install signal handler and notify parent */
+		sa.sa_sigaction = sigusr1_siginfo_handler;
+		sa.sa_flags = SA_RESTART | SA_SIGINFO;
+		ASSERT_NEQ(sigaction(SIGUSR1, &sa, NULL), -1, "sigaction");
+
+		close(pipe_c2p[0]); /* close read */
+		close(pipe_p2c[1]); /* close write */
+
+		/* notify parent signal handler is installed */
+		ASSERT_EQ(write(pipe_c2p[1], buf, 1), 1, "pipe_write");
+
+		/* make sure parent enabled bpf program to send_signal */
+		ASSERT_EQ(read(pipe_p2c[0], buf, 1), 1, "pipe_read");
+
+		/* the signal is sent from workqueue context, so nothing has
+		 * to be triggered from here
+		 */
+		while (!sigusr1_received)
+			sleep(1);
+
+		buf[0] = sigusr1_received;
+
+		ASSERT_EQ(sigusr1_received, 8, "sigusr1_received");
+		ASSERT_EQ(write(pipe_c2p[1], buf, 1), 1, "pipe_write");
+
+		close(pipe_c2p[1]);
+		close(pipe_p2c[0]);
+		exit(0);
+	}
+
+	close(pipe_c2p[1]); /* close write */
+	close(pipe_p2c[0]); /* close read */
+
+	skel = test_send_signal_kern__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "skel_open_and_load"))
+		goto skel_open_load_failure;
+
+	/* wait until child signal handler installed */
+	ASSERT_EQ(read(pipe_c2p[0], buf, 1), 1, "pipe_read");
+
+	/* pid == 0 keeps the other programs of this skeleton inactive */
+	skel->bss->pid = 0;
+	skel->bss->sig = SIGUSR1;
+	skel->bss->target_pid = pid;
+
+	err = test_send_signal_kern__attach(skel);
+	if (!ASSERT_OK(err, "skel_attach")) {
+		err = -1;
+		goto destroy_skel;
+	}
+
+	/* notify child that bpf program can send_signal now */
+	ASSERT_EQ(write(pipe_p2c[1], buf, 1), 1, "pipe_write");
+
+	/* wait for result, workqueues run on their own */
+	err = read_with_timeout(pipe_c2p[0], buf, 1, 10 * 1000 * 1000);
+	if (!ASSERT_GT(err, 0, "reading pipe"))
+		goto destroy_skel;
+
+	ASSERT_EQ(buf[0], 8, "incorrect result");
+
+destroy_skel:
+	test_send_signal_kern__destroy(skel);
+skel_open_load_failure:
+	close(pipe_c2p[0]);
+	close(pipe_p2c[1]);
+	/*
+	 * Child is either about to exit cleanly or stuck in case of errors.
+	 * Nudge it to exit.
+	 */
+	kill(pid, SIGKILL);
+	wait(NULL);
+}
+
 void test_send_signal(void)
 {
 	if (test__start_subtest("send_signal_tracepoint"))
@@ -289,4 +391,6 @@ void test_send_signal(void)
 		test_send_signal_perf(true, true);
 	if (test__start_subtest("send_signal_nmi_thread_remote"))
 		test_send_signal_nmi(true, true);
+	if (test__start_subtest("send_signal_kworker"))
+		test_send_signal_kworker();
 }
diff --git a/tools/testing/selftests/bpf/progs/test_send_signal_kern.c b/tools/testing/selftests/bpf/progs/test_send_signal_kern.c
index 176a355e3062..d1c000c30885 100644
--- a/tools/testing/selftests/bpf/progs/test_send_signal_kern.c
+++ b/tools/testing/selftests/bpf/progs/test_send_signal_kern.c
@@ -60,6 +60,32 @@ int send_signal_tp_sched(void *ctx)
 	return bpf_send_signal_test(ctx);
 }
 
+/* Send a signal to a task other than current, from a context where current
+ * is a kernel thread. No filtering on current is possible here, so this is
+ * driven entirely by target_pid.
+ */
+SEC("tp_btf/workqueue_execute_start")
+int send_signal_kworker(void *ctx)
+{
+	struct task_struct *target_task;
+	int ret;
+
+	if (status != 0 || target_pid == 0)
+		return 0;
+
+	target_task = bpf_task_from_pid(target_pid);
+	if (!target_task)
+		return 0;
+
+	ret = bpf_send_signal_task(target_task, sig, PIDTYPE_TGID, 8);
+	bpf_task_release(target_task);
+
+	if (ret == 0)
+		status = 1;
+
+	return 0;
+}
+
 SEC("perf_event")
 int send_signal_perf(void *ctx)
 {
-- 
2.34.1

