Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.225.73
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794270499;
	b=I5fFEMC73yKNwLgFgxciQ0AQbgK1FJSbdRRdTYZOAO/+M1rIw7SOdwp9KbD+eP82DgCl
	 cyzPKv9Qc+3olzi9QdBg56hYIDOt72Yjx/xxUtHPNoG/rWGAJNNptskxgajDO1xk0cMCu
	 0FXUesPKXj6/p3NLjXuThYoS6wObLwVlA8NUrNmxbcpDQf1zWYtA2gvZaIlfSKaYIQyw1
	 4AsAW+Fq3lKdYCbfOT+HWzH4T/T2FzMgJNGHrKS2bbBKa4Ljj0M3Eg4Wb1d6YiLU3MdaW
	 IAHTVDVTsezzNC3AV0qW0buDRJUEYUAF8z1jBDRZsnq4d98ZoXspWpTEBkqNFj4jbrA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794270499;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 X-Developer-Signature:X-Developer-Key:Content-Transfer-Encoding;
	bh=fYSdAr7mskwrpw/V7vcV3GB+sO658wd8PFKpH6PmbUQ=;
	b=adKazV9wInNW9/HKO8B/3zdBs5TsJG+D1XYBw6NkRFohRFns2YB1a2KcELqjfbrbrCSn
	 uEXSt6VUhbJh6Qtb1gZr+RR2U4duPt0C4LYia3QKveCocN7Tqny+qKugrOCey9/japBvS
	 IXisem+MY7V81TauIwBbphKOEajv9XywXdISv872bR+OOO/0SiBTgIZzc6RFE5hMJZBo9
	 AhutK7/fV4tY9XGLRDk05bS6nPh+ORNRdoefGxbR0aAAVUVYUPLvgbIkbpsSL+J8P5bir
	 C3hzkrn6cSmpqB41r71djEW5pUDeHJKhIr7voCTH/V231Drq00LP/hELql1E7vx01xg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JB7ABvaO;
	arc=none smtp.remote-ip=74.125.225.73
Received: from mail-wr2-f9.google.com (mail-wr2-f9.google.com [74.125.225.73])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CEF0606A31C
	for <bpf@vger.kernel.org>; Tue, 10 Nov 2026 00:28:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3CEF0606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JB7ABvaO
Received: by mail-wr2-f9.google.com with SMTP id ffacd0b85a97d-490ca655ba2so725834f8f.1
        for <bpf@vger.kernel.org>; Mon, 09 Nov 2026 16:28:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794270498; x=1794875298; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fYSdAr7mskwrpw/V7vcV3GB+sO658wd8PFKpH6PmbUQ=;
        b=JB7ABvaObfwdWaAaAnoQwAVqHXE5IR6xBMFnQBwN1CEh9EDjCUeRtozhz9jRYyJW5f
         uQhB0Y+t8ITK9FTJZ7JoSwLkmx4IdBx7aPyBffNp5wcXwNEDxY/9nCW7XpqX3m3xuwZH
         aSFQ5vleQHyH6VgDBUg7ZWwDDhXSHrJEBeYLqt2ehaw4BtTlrnMRd5pDLtTJ9TdsaI6a
         VKJe5InUmiWWWoxtjTfkOt+4zRc7Ej/vjxxHK1y7V0W3zRn9RpBIVoMFIWMch2MGvrVB
         iygjVLU91bdgNG9oN9FNMuexN28/Bg56buNAe3YCJYQTT9iLMVLX97D76ISLl8a9cHbJ
         5vdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794270498; x=1794875298;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=fYSdAr7mskwrpw/V7vcV3GB+sO658wd8PFKpH6PmbUQ=;
        b=XSvamjUiBUbflVLBR8+euiKf+x+CrfhcOdFhb3X+xD91PdbFgq2Esmoxb2N0JQ0Ewf
         nl/UIgYoC03qJtsYRrcEUaMi4XIFpa57eoI7Y37gIeY5UeLUaP71mlv0YUCzJCob8UMe
         Ze9O9wut8yMgSu2Mam6AwL64XlDRbEfF417u6BEMsVlPIXcS6vrXwx4ialBMIhPm9p/z
         IAkqrsEP6/gWZj7LOb+C45NeDWXdYEwjzq2+fUb5mmCMzCAtB5l8xeVDwXFYwo8QsSsb
         +cVNncmFaEjYPmcvbXSs8Y8XyeoCMVZJAC2fhkrO4PtHPR1GgKzMZUmEii2GHCugwMsc
         l2sA==
X-Gm-Message-State: APuU4Z/kdBl2dbrhSgsiRDsrGSYuj8ClgIgPwmIrgbO6Ip4pJ5BHWMC9
	pcdpItteidFcIW833mE/jo8OSoJSX08EHLFhY07NFyUNtMVyokrbTu5yMKwJKfNw
X-Gm-Gg: AYBFou1aM5mHqPH82bDfDHCOaxdvFx1qicLYiyAw2eXkNW6+TKCXTeUc2bPT2SDuJ32
	XhIc4JAsNnmajw+kL4VaDJDoj3pWac4t6WXGCYSmgU32rzerwHGfN3RnYML4gjgC96Ho/MG5U9M
	9YUwhLZ1U2IjNmenWnbL8371CNHlBkdr2DjSvWAHNrm37IYe4Z4j6qw8lV+u06k8Z2Ta3mOMpUj
	aG9adOZRdPpDJduabNfRg3E0N4xUA9lFXTcDFYMwnOuUBzGIoU4kCsMJQ/v2+yr9XJFpGnAIZJ9
	8iCj7kvN3r/X2NK8NGOTbe39MRlCgRoylL4GVm+Cd8bYsPVp0WZyk/QegzH8b+cnRwLp8Nw7N9b
	JyTRpfM6ec392MwrRB5l7e/NiuKPXoi41EU2bZRojKxnKzi8lOfVcATuef8f7RcUh6w0xuhjCMD
	PwdoFCVALms8qfDwxtSvXrn5ZYqk89LtBt3JdQJmMqmXRgbs7xd0aiZ349RIY9ZSxQw5ws9zp3x
	0EGrNHYaeA+0M0kl0uQYiDlNKsiWKEDZROuHlRLuP2Dk84PHz4ngXwCI92FgSp5I6RsyBIfvkMI
	TmBoCoec/4pk0Oza5LQDsLTHrApO596D0qSQbubOZ2TWbdYDHdDoVNC83of/7/yvMUpBc1g1Jot
	SycZuXuwznQLcx6/AqLoaD3LyXNHnECfMXPRhoe/Bw0pc4im9ce36FvgURVpo44RYZpGSxcLmUj
	YtdQoFpjdCkw8SHw==
X-Received: by 2002:a05:6000:26c8:b0:48e:669b:76e9 with SMTP id ffacd0b85a97d-49830d818famr1806084f8f.47.1794270497633;
        Mon, 09 Nov 2026 16:28:17 -0800 (PST)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-498811fa70esm464525f8f.19.2026.11.09.16.28.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 16:28:16 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Tejun Heo <tj@kernel.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 17/20] selftests/bpf: Test bpf_task_wake() from tracing programs
Date: Tue, 10 Nov 2026 01:27:39 +0100
Message-ID: <0073b3ee8c2fd5c3e272248cd913b370cb709853.1794269507.git.memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1794269506.git.memxor@gmail.com>
References: <cover.1794269506.git.memxor@gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6561; i=memxor@gmail.com; h=from:subject:message-id; bh=tsVirPMbJUwJf3aVkhWBThMOqoCvUDJfHMf41R1jXIY=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIetToueys9Z6C5cc4Pe5b/Guyo3D4saNnebX58vFeTWGb ++bmVXWUcrCIMbFICumyFLyfx+T8YnK34G2y7hh5rAygQxh4OIUgIk8XcvI0Mvo38luMa1oGvNf BYNtev1TxRaI3N/yqJXL8uj0x2c/yDAyTHgp3jixt+De7o0PeP94eZo+YBev4Q/5vlQryORYqmo DPwA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Wake the parked waiter from a tracing program in both of the contexts
the wake distinguishes. Attached to task_rename, the program runs in
process context when the test thread renames itself, so its wake is
direct and reports that it found the task asleep. Attached to
sched_waking, it runs when the test thread's own sleep ends, inside
try_to_wake_up() with the thread's pi_lock held and IRQs disabled, so
its wake is deferred to irq_work and returns 2, and the park ends when
the irq_work runs. In each case the test checks that the waiter returned
before the syscall drain was tried, which runs only as a fallback so
that a lost wake fails the test instead of hanging it. The program is
attached only once the waiter sleeps, since the thread's polling sleeps
are wakeups of its own.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../selftests/bpf/prog_tests/task_park.c      | 66 +++++++++++++++++++
 tools/testing/selftests/bpf/progs/task_park.c | 48 +++++++++++++-
 2 files changed, 113 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/task_park.c b/tools/testing/selftests/bpf/prog_tests/task_park.c
index 43514132e6e9..a479a183c696 100644
--- a/tools/testing/selftests/bpf/prog_tests/task_park.c
+++ b/tools/testing/selftests/bpf/prog_tests/task_park.c
@@ -4,6 +4,7 @@
 #include <test_progs.h>
 #include <pthread.h>
 #include <signal.h>
+#include <sys/prctl.h>
 #include <sys/syscall.h>
 #include "task_park.skel.h"
 #include "verifier_task_park.skel.h"
@@ -169,6 +170,67 @@ static void test_wake_asleep(struct task_park *skel)
 	skel->data->park_timeout_ns = timeout;
 }
 
+/*
+ * Wait until the waiter sleeps, attach the tracing program @prog, let @fire
+ * raise its event for this thread, and check that the program's wake, not the
+ * syscall drain, ended the park and returned @expected_ret. The program
+ * attaches only once the waiter sleeps, since the polling sleeps of this
+ * thread are events of its own, and the drain runs only if the event failed.
+ */
+static void test_wake_tracing(struct task_park *skel, struct bpf_program *prog,
+			      int (*fire)(void), int expected_ret)
+{
+	__u64 timeout = skel->data->park_timeout_ns;
+	struct bpf_link *link = NULL;
+	struct waiter w;
+	bool woken;
+	int i;
+
+	skel->data->park_timeout_ns = ~0ULL;
+	skel->bss->waker_tid = syscall(SYS_gettid);
+	skel->data->tracing_wake_ret = -1;
+	if (!ASSERT_OK(start_waiter(&w, skel->progs.park_until_woken), "pthread_create"))
+		goto out;
+	for (i = 0; i < 5000 && !waiter_sleeping(&w); i++)
+		usleep(1000);
+	if (ASSERT_TRUE(waiter_sleeping(&w), "waiter_sleeping")) {
+		link = bpf_program__attach(prog);
+		if (ASSERT_OK_PTR(link, "attach"))
+			ASSERT_OK(fire(), "fire");
+	}
+	for (i = 0; i < 5000 && !waiter_done(&w); i++)
+		usleep(1000);
+	woken = waiter_done(&w);
+	bpf_link__destroy(link);
+	/* Bound any further park before draining, so a lost wake cannot hang the join. */
+	skel->data->park_timeout_ns = timeout;
+	if (!woken)
+		wake_until_done(skel, &w);
+	pthread_join(w.thread, NULL);
+	ASSERT_TRUE(woken, "woken_by_tracing_prog");
+	ASSERT_EQ(skel->data->tracing_wake_ret, expected_ret, "tracing_wake_ret");
+	ASSERT_OK(w.err, "park_until_woken");
+	ASSERT_EQ((__s32)w.retval, 0, "wake_park_ret");
+out:
+	skel->data->park_timeout_ns = timeout;
+}
+
+/* Renaming the thread to its own name still fires task_rename. */
+static int rename_self(void)
+{
+	char comm[16];
+
+	if (prctl(PR_GET_NAME, comm))
+		return -errno;
+	return prctl(PR_SET_NAME, comm) ? -errno : 0;
+}
+
+/* The timer that ends this sleep wakes the thread, which fires sched_waking. */
+static int sleep_self(void)
+{
+	return usleep(1000) ? -errno : 0;
+}
+
 static void sig_noop(int sig)
 {
 }
@@ -237,6 +299,10 @@ void test_task_park(void)
 		test_wake(skel);
 	if (test__start_subtest("wake_asleep"))
 		test_wake_asleep(skel);
+	if (test__start_subtest("wake_tracing"))
+		test_wake_tracing(skel, skel->progs.wake_on_rename, rename_self, 1);
+	if (test__start_subtest("wake_tracing_deferred"))
+		test_wake_tracing(skel, skel->progs.wake_on_waking, sleep_self, 2);
 	if (test__start_subtest("prog_array"))
 		test_prog_array(skel);
 	if (test__start_subtest("signal"))
diff --git a/tools/testing/selftests/bpf/progs/task_park.c b/tools/testing/selftests/bpf/progs/task_park.c
index c777cc787dab..2320ede02cc9 100644
--- a/tools/testing/selftests/bpf/progs/task_park.c
+++ b/tools/testing/selftests/bpf/progs/task_park.c
@@ -4,7 +4,7 @@
 #include "bpf_experimental.h"
 #include <errno.h>
 
-/* Exercise bpf_task_park() and bpf_task_wake() from syscall programs. */
+/* Exercise bpf_task_park() from syscall programs, bpf_task_wake() from those and tracing ones. */
 char _license[] SEC("license") = "GPL";
 
 extern struct task_struct *bpf_task_acquire(struct task_struct *task) __ksym;
@@ -139,6 +139,52 @@ int wake_waiter(void *ctx)
 	return ret;
 }
 
+/* Set by the test: the thread whose events wake the waiter. */
+__u32 waker_tid;
+/* What the last wake from a tracing program returned. */
+int tracing_wake_ret = -1;
+
+/*
+ * The same wake from a tracing program, on an event of the thread the test
+ * names. The task kptr read under bpf_rcu_read_lock() is what bpf_task_wake()
+ * accepts, so the event takes no reference.
+ */
+static __always_inline void wake_waiter_on_event(struct task_struct *task)
+{
+	struct park_elem *elem = lookup_elem();
+	struct task_struct *waiter;
+
+	if (!elem || task->pid != waker_tid)
+		return;
+	bpf_rcu_read_lock();
+	waiter = elem->task;
+	if (waiter) {
+		WRITE_ONCE(elem->state, WOKEN);
+		tracing_wake_ret = bpf_task_wake(waiter, 0);
+	}
+	bpf_rcu_read_unlock();
+}
+
+/* The wake from process context: task_rename fires from prctl(). */
+SEC("tp_btf/task_rename")
+int BPF_PROG(wake_on_rename, struct task_struct *task, const char *comm)
+{
+	wake_waiter_on_event(task);
+	return 0;
+}
+
+/*
+ * The wake from under the scheduler's locks: sched_waking fires inside
+ * try_to_wake_up() with the woken task's pi_lock held and IRQs disabled,
+ * where the wake cannot be issued, so it is queued for irq_work and returns 2.
+ */
+SEC("tp_btf/sched_waking")
+int BPF_PROG(wake_on_waking, struct task_struct *p)
+{
+	wake_waiter_on_event(p);
+	return 0;
+}
+
 /* Nothing wakes this task: the park sleeps 1 ms and times out. */
 SEC("syscall")
 int park_timeout(void *ctx)
-- 
2.53.0

