Received: from sender-pp-o93.zoho.in (sender-pp-o93.zoho.in [103.117.158.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2748128CF4A
	for <bpf@vger.kernel.org>; Thu,  1 Oct 2026 07:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=103.117.158.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790839626; cv=pass; b=Xp4oItLl2G82jPhoBlTzptWbuM3d0qcqDpzZnSzT+88cqeub/Bw/bTB1vLSAFrPhwIg1Tq88q6Fmstwyd+DYPDy4xbrtK4nPKZ7/PRlTYGZjinKDWryId6AJ1n5TmF9ZOzgoqMzR8f8M2UWjoyPYhyqEjKq/Fpta6XcbD4BosMs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790839626; c=relaxed/simple;
	bh=f9a1YoBw/YsnoqlxfFjyORNzOu7fLh2uiwTq5UKBoRM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=D0nsmJK8Iy6txME9BmVEdnyuSLI+rBSEOfnIcl32VOn0QoqmAoSGH7LyqCbqRFkmvK3oGzzPNnPUozA9DpoD4o0di6zBDNfu3XFYeEGHhNlvwVn9hONtr0PhLuNd3e0ermHedA7liGMP6ZLVy2SObGv9mkLU1MF4Dt06ktHu2rU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.in; spf=pass smtp.mailfrom=zohomail.in; dkim=pass (1024-bit key) header.d=zohomail.in header.i=adi.sharma@zohomail.in header.b=QdtAOkOO; arc=pass smtp.client-ip=103.117.158.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.in
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.in header.i=adi.sharma@zohomail.in header.b="QdtAOkOO"
ARC-Seal: i=1; a=rsa-sha256; t=1790839550; cv=none; 
	d=zohomail.in; s=zohoarc; 
	b=BmF6Lh8vQTs0BOfu7CN03E525S5Uxlw7xqShoe/nu01Nt2QTSyZinhId32y5L9Gcfzsp494buwn1omucbSMWhIZ6GSLms9Q4MTShRIc0XDJVqGmvLGaRnb/ydaZ65G0FQFmP4rkAxxt1ut5HrL0xCNXkUVmgY1z/3QPCmn+ZoQw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in; s=zohoarc; 
	t=1790839550; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Q4PHbtIIQrTJCe963mowL0owP4RmywZzLUn4iaGUQrU=; 
	b=JTIQdbSJOtzq+uckpIjVy4uD6HTY1ZwDB7RGcO+mO85d7WYqVGH12Fx/IRRDIzdElIkoDblGIdBEa/CcSCYFmZNmFChXTrVSQqnyTqgwQhHBmg762dS73XHf87iKTEdnobn8sxWlUUS0jl2837c9M4oSa43QOVh7EwDpmM4y5yk=
ARC-Authentication-Results: i=1; mx.zohomail.in;
	dkim=pass  header.i=zohomail.in;
	spf=pass  smtp.mailfrom=adi.sharma@zohomail.in;
	dmarc=pass header.from=<adi.sharma@zohomail.in>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1790839550;
	s=zoho; d=zohomail.in; i=adi.sharma@zohomail.in;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=Q4PHbtIIQrTJCe963mowL0owP4RmywZzLUn4iaGUQrU=;
	b=QdtAOkOOKuMjNvHl4PIst4inCaN1IcidLQ+YnDWuwSuL0TY01+s6oWcqsEDMJOfc
	KnhF4KXeA1p2thAIBGiAWZAEO0AKKTnddC2F9QMsEsylAfrBejdnn1Se3SSyKL8nV6e
	ZIrMA9M6li0XeVRcQlL6cbOVCIrIwrH5CkDI7AMw=
Received: by smtp.zoho.in with SMTPS id 1790839548838234.24264859201674;
	Thu, 1 Oct 2026 12:55:48 +0530 (IST)
From: Aditya Sharma <adi.sharma@zohomail.in>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	ihor.solodrai@linux.dev,
	kpsingh@kernel.org,
	matt@bobrowski.net,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	shuah@kernel.org,
	puranjay@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Aditya Sharma <adi.sharma@zohomail.in>
Subject: [PATCH bpf-next v2 2/2] selftests/bpf: Test bpf_send_signal_task() from kernel thread context
Date: Thu,  1 Oct 2026 12:54:49 +0530
Message-Id: <20261001072449.1377267-3-adi.sharma@zohomail.in>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261001072449.1377267-1-adi.sharma@zohomail.in>
References: <20261001072449.1377267-1-adi.sharma@zohomail.in>
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
driven by target_pid and gated on a kworker_test flag that only this
test sets, and the test asserts the child receives the signal.
Setting pid to 0 leaves the pre-existing programs in the skeleton
inert. Workqueues run on their own, so nothing has to be triggered
from userspace.

Without removing the nmi_uaccess_okay() check, this test fails on x86.

Assisted-by: Claude:claude-opus-5
Signed-off-by: Aditya Sharma <adi.sharma@zohomail.in>
---
 .../selftests/bpf/prog_tests/send_signal.c    | 106 ++++++++++++++++++
 .../bpf/progs/test_send_signal_kern.c         |  29 +++++
 2 files changed, 135 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/send_signal.c b/tools/testing/selftests/bpf/prog_tests/send_signal.c
index 7ac4d5a488aa..ecec2ee8b19a 100644
--- a/tools/testing/selftests/bpf/prog_tests/send_signal.c
+++ b/tools/testing/selftests/bpf/prog_tests/send_signal.c
@@ -261,6 +261,110 @@ static void test_send_signal_nmi(bool signal_thread, bool remote)
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
+		/*
+		 * The signal is sent from workqueue context, so nothing has
+		 * to be triggered from here.
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
+	skel->bss->kworker_test = 1;
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
@@ -289,4 +393,6 @@ void test_send_signal(void)
 		test_send_signal_perf(true, true);
 	if (test__start_subtest("send_signal_nmi_thread_remote"))
 		test_send_signal_nmi(true, true);
+	if (test__start_subtest("send_signal_kworker"))
+		test_send_signal_kworker();
 }
diff --git a/tools/testing/selftests/bpf/progs/test_send_signal_kern.c b/tools/testing/selftests/bpf/progs/test_send_signal_kern.c
index 176a355e3062..f9c4496d9fe1 100644
--- a/tools/testing/selftests/bpf/progs/test_send_signal_kern.c
+++ b/tools/testing/selftests/bpf/progs/test_send_signal_kern.c
@@ -9,6 +9,7 @@ void bpf_task_release(struct task_struct *p) __ksym;
 int bpf_send_signal_task(struct task_struct *task, int sig, enum pid_type type, u64 value) __ksym;
 
 __u32 sig = 0, pid = 0, status = 0, signal_thread = 0, target_pid = 0;
+__u32 kworker_test = 0;
 
 static __always_inline int bpf_send_signal_test(void *ctx)
 {
@@ -60,6 +61,34 @@ int send_signal_tp_sched(void *ctx)
 	return bpf_send_signal_test(ctx);
 }
 
+/*
+ * Send a signal to a task other than current, from a context where current
+ * is a kernel thread. No filtering on current is possible here, so this is
+ * driven by target_pid, and gated on kworker_test so that it stays inactive
+ * in the other tests.
+ */
+SEC("tp_btf/workqueue_execute_start")
+int send_signal_kworker(void *ctx)
+{
+	struct task_struct *target_task;
+	int ret;
+
+	if (status != 0 || !kworker_test || target_pid == 0)
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

