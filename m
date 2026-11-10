Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.225.138
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794270503;
	b=Lct7ab15j8yP2m485eDdj7WG7ucjJ9w5bkfAyIQWPYvy5UmpQzduU9ow2TP06mKEPpZG
	 bd5mFZcQdoG/hcdc5i+GxGV40+DWXxvUy0x5d34l/OujwabyOVOUAJKpgOpfr5oUj314e
	 ctRvY7gO5iQilraS5DdYLNV/bcf2TrHK74IBJ8Y4N+0TU4A2WY/m/uA8ZQiJ2xiryovG3
	 NgV1Rb1Q/ihIuknJX96T+TEX3Xkjyx/C2y3avahB5AEiWE57CTgr+AiHBfxilVUQMqNvZ
	 F6ylP9B8Tk535X58G7ucSKP+ocd0s0qmd99lIPiSeyPbe2GJycKbWVMX7SiSG/IbCwg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794270503;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 X-Developer-Signature:X-Developer-Key:Content-Transfer-Encoding;
	bh=cSGrD0weinxM9idPsvdQK1nRz5hNvojpzh/54CKWxQc=;
	b=emBqztj2uBZCBtQZ5q1I71Ljnxvv6U2btFX1CuhXs/n6qiXhbhYGQ85uKZnPuQh8B7IU
	 yn0RfXteeFtcJ/pOhidNOzfmv1/sq519yp3/PaDoDkXrD5UH5SMmFCwkCtHkjufGkRLxp
	 46sx3PqIEFsLr4eCUIxqLcfV9JfgZNtYlekj9hDldszObD4IGFhf0anlLcsW5iAJ85TlF
	 OqP4bxzqT5hIHUtNTEnnMtmMr51DcUCjzkOTCLxizj0llUYy8T9u79j0I3223TNNKmR0+
	 ZXi5FA7Sa0nQEtGpzx/xCi0S2cXaJpQg4fIZ0cK5lBp6CmRPvTOu4Zmtl0J7SQdt4cw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ySJSB9em;
	arc=none smtp.remote-ip=74.125.225.138
Received: from mail-wm2-f10.google.com (mail-wm2-f10.google.com [74.125.225.138])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7A1B606A325
	for <bpf@vger.kernel.org>; Tue, 10 Nov 2026 00:28:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B7A1B606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ySJSB9em
Received: by mail-wm2-f10.google.com with SMTP id 5b1f17b1804b1-4b886ebe069so4837015e9.1
        for <bpf@vger.kernel.org>; Mon, 09 Nov 2026 16:28:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794270501; x=1794875301; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cSGrD0weinxM9idPsvdQK1nRz5hNvojpzh/54CKWxQc=;
        b=ySJSB9emUmq44LzYtJalnPUl77koAYGrY+5Z9mf4SEktX9suacU0zXkbHCtPT/Y/Ge
         7UvOflepv18q9cCezI6dyDnIE23RjQ00jDjxOwhcdoMw0AdOqm1jPVziTTJTzr21CueX
         Hmpo9+YwPWPNlH4idH1TixU7LjIyim2G4LXzYMx/GUa+/8MJmmKxuO1MGm2fd94rIl5A
         j6G0Ghi8Ha5PmJE64B4+7rjIUf14P1h2BuNP3/99B49GSeY+jq1w6LBaxfz0l/WLY7lM
         H8AnWYTsiE2iQ7kxAgXIZx60vc/URUrRQ0qT2ZVzlxCsZ6lgElQbR6sHEl7YexsN4xSK
         ZImQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794270501; x=1794875301;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=cSGrD0weinxM9idPsvdQK1nRz5hNvojpzh/54CKWxQc=;
        b=p6p1Ljzl7pKGQ8l/cTmCzdwWSNr8n7SuiVsjABY7AyksedIK9QmtKZab1kbrU/xeCq
         KqGSQPoZLZNBdINJW6xiKncWOEXI/Rq+PSLjPFesEZ/meLQoQpV2nheVcSJPnuXO7h45
         YoZULY0M0ECMTKKV1qALCZdlOK8urMQpgPfgLMTG0mrc5wdEtFZaPeUM58A26XNnhfwg
         SqMN0WPRsdQ2u4RMU9NTcQ1+kfi3HBPoS7pyViAlWh96FakVNNY6K0rdmIZUAOdqI/XR
         8o81Rkiw0HRvlBnLEcxhjszlFeqUhGEcQXvrnRM983cCYHGIZKXVW/YUJ/Vt8WcbC6CP
         6DGg==
X-Gm-Message-State: APuU4Z+FMreZ2pa8s6ENxIjpjSgp+DwujjHw1D7IFqo+N2kW9FxSj8Zv
	3w+hfjq9gif4XRzuQ6LwyRCpCIOxeSZ76tq4V4fDcaysEHG4nxPJ21ExCMsm0QZG
X-Gm-Gg: AYBFou3hHWrMzbz0FjsERUl6Kt91KTowC9EIcj8DXoFfd9RI204DSbhf0w3m1qzi/96
	Gtln4kkNt/C+XahaPPS92XeOeAV1owfqZRuPTO5ep4/sLE5iqBSYNHf06k3+VRHAmlkaZiuUfDB
	WgtFKFCIVTZ054+2Pz2K/GykBxyocquzncGVJA7TVCsLcXeKjbbjmaVfrqmiijdSMOsQJkLpAvE
	A8FIi2NMGM3yEjCZZsrPduCrfsc9nGxEd4ixhIYN4mA5nJ4FLqvCsP3xfdembUPcoAH8vCjOMZf
	nPo4kvLfD+u2NloKALOIdOJLqGsJCXehSNe8dSRWiZfHpEoTOtrlKj+FQn2vS+OOpITCrpY53Um
	SJqktsxXguo46CcAOqoeh2j774Ow12r5ZISJcu8N/3uJcP6JgxpD2KFN7ysF2zwsoCZxLTnGvPz
	S0FkY2sagm7teN4KC4D3vnDvmDju4S4aNLdrk21v1UqauNgYid77VSjLtvbxOrK4MGc52kbfGD1
	rsge/c6VVNlSEICozzMpT0V0WYC6Wnd5FoeWrBxtYpMkkeCnP2+zGXDHuyJtUecrU3546/F15lG
	w4bvlIIFh91T9uoVIcxNH2w9N7k8Pfwx6SCfb8K17VIsVCQsUXGGqorVrNS8DZQMn+ZEny/rCCV
	4laoFhCNk9MI/7fN5o8W1ncf2TJGIWpJ6W8vTlZg2ombgkb+X8QzqlnXhjIPr+Cnb8EP3
X-Received: by 2002:a05:600c:4e0d:b0:4b1:2026:6b41 with SMTP id 5b1f17b1804b1-4ba023505d3mr12685545e9.30.1794270501273;
        Mon, 09 Nov 2026 16:28:21 -0800 (PST)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ba01fe9357sm27964475e9.9.2026.11.09.16.28.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 16:28:20 -0800 (PST)
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
Subject: [PATCH bpf-next v1 19/20] selftests/bpf: Test bpf_kthread_bind()
Date: Tue, 10 Nov 2026 01:27:41 +0100
Message-ID: <db75d6e5819972e857114e2a5658328f6aa82855.1794269507.git.memxor@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=11794; i=memxor@gmail.com; h=from:subject:message-id; bh=Guv/E+qHaWVmXAmGNEm0z2NfjO/zbcZZnDtiDmusTI0=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIetTomfGanHxqtllW/JPXLzFWxvx48GkF+7zn/qI9E9jW PlxmW5TRykLgxgXg6yYIkvJ/31MxicqfwfaLuOGmcPKBDKEgYtTACaSbMvI8CnQ0jaxfKtU1cOS woWprvZPNvyv+XqF7Z+K09qF2Z+eZzP8D/a5xPfy08YvZud6b59S2qctn3lizYF/Ci7vyk41u7v HcAIA
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Bind a parked thread to the lowest CPU the test may run on and then to the
highest, start it, and check that its callback runs on the highest. Also
check that an impossible CPU is refused. A bind while the thread runs
moves it as well: the body parks with migration enabled, so the bind
completes at once, and the thread's next iteration, after a wake,
records the new CPU. A thread also binds itself from its body and runs
its first iteration on that CPU, since it is migratable during the call.
The tests wait for the body's first iteration, not only for its entry,
before they read the CPU it recorded.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../testing/selftests/bpf/bpf_experimental.h  |   1 +
 .../selftests/bpf/prog_tests/bpf_kthread.c    | 123 +++++++++++++++++-
 .../testing/selftests/bpf/progs/bpf_kthread.c |  49 ++++++-
 3 files changed, 166 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/bpf/bpf_experimental.h b/tools/testing/selftests/bpf/bpf_experimental.h
index 0fcb969ba034..e41d326a0017 100644
--- a/tools/testing/selftests/bpf/bpf_experimental.h
+++ b/tools/testing/selftests/bpf/bpf_experimental.h
@@ -357,6 +357,7 @@ extern int bpf_task_wake(struct task_struct *task, __u64 flags) __weak __ksym;
 extern struct task_struct *bpf_kthread_create(int (callback_fn)(__u64 arg), __u64 arg,
 					      __u64 flags) __weak __ksym;
 extern int bpf_kthread_start(struct task_struct *task, __u64 flags) __weak __ksym;
+extern int bpf_kthread_bind(struct task_struct *task, __u32 cpu, __u64 flags) __weak __ksym;
 extern int bpf_kthread_stop(struct task_struct *task, __u64 flags) __weak __ksym;
 extern bool bpf_kthread_should_stop(void) __weak __ksym;
 
diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_kthread.c b/tools/testing/selftests/bpf/prog_tests/bpf_kthread.c
index 095cdef37d66..e32a975c7a0d 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_kthread.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_kthread.c
@@ -2,6 +2,7 @@
 /* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
 
 #include <test_progs.h>
+#include <sched.h>
 #include "bpf_kthread.skel.h"
 #include "verifier_bpf_kthread.skel.h"
 
@@ -10,6 +11,8 @@ struct kthread_args {
 	__u32 idx;
 	__u32 start;
 	__u32 body;
+	__u32 bind;
+	__u32 cpu;
 };
 
 enum body {
@@ -18,6 +21,7 @@ enum body {
 	BODY_SELF_STOPPER,
 	BODY_RING,
 	BODY_STOP_CHECKER,
+	BODY_SELF_BINDER,
 };
 
 static int run_prog(struct bpf_program *prog, struct kthread_args *args, int *retval)
@@ -34,9 +38,12 @@ static int run_prog(struct bpf_program *prog, struct kthread_args *args, int *re
 	return err;
 }
 
-static int create_thread(struct bpf_kthread *skel, __u32 idx, bool start, enum body body)
+static int create_thread_on(struct bpf_kthread *skel, __u32 idx, bool start, enum body body,
+			    int cpu)
 {
-	struct kthread_args args = { .idx = idx, .start = start, .body = body };
+	struct kthread_args args = {
+		.idx = idx, .start = start, .body = body, .bind = cpu >= 0, .cpu = cpu,
+	};
 	int err, retval;
 
 	err = run_prog(skel->progs.create_thread, &args, &retval);
@@ -45,6 +52,21 @@ static int create_thread(struct bpf_kthread *skel, __u32 idx, bool start, enum b
 	return 0;
 }
 
+static int create_thread(struct bpf_kthread *skel, __u32 idx, bool start, enum body body)
+{
+	return create_thread_on(skel, idx, start, body, -1);
+}
+
+static int bind_thread(struct bpf_kthread *skel, __u32 idx, __u32 cpu)
+{
+	struct kthread_args args = { .idx = idx, .cpu = cpu };
+	int retval;
+
+	if (!ASSERT_OK(run_prog(skel->progs.bind_thread, &args, &retval), "bind_thread"))
+		return -EFAULT;
+	return retval;
+}
+
 /* Returns what the program returned, which for stop_thread is what the stop returned. */
 static int control_thread(struct bpf_program *prog, __u32 idx)
 {
@@ -73,6 +95,19 @@ static bool wait_for(__u32 *p)
 	return false;
 }
 
+/* Poll until *p exceeds @seen, for up to two seconds: the thread has looped again. */
+static bool wait_past(__u32 *p, __u32 seen)
+{
+	int i;
+
+	for (i = 0; i < 2000; i++) {
+		if (__atomic_load_n(p, __ATOMIC_ACQUIRE) > seen)
+			return true;
+		usleep(1000);
+	}
+	return false;
+}
+
 /* Whether the thread sleeps: state 'S' in /proc/<tid>/stat, read past the parenthesised comm. */
 static bool thread_sleeping(__u32 tid)
 {
@@ -105,6 +140,25 @@ static bool wait_sleeping(__u32 tid)
 	return false;
 }
 
+/* The lowest and highest CPUs the test may run on; a bound thread has to run there. */
+static int allowed_cpus(int *lo, int *hi)
+{
+	cpu_set_t set;
+	int cpu;
+
+	if (sched_getaffinity(0, sizeof(set), &set))
+		return -1;
+	*lo = *hi = -1;
+	for (cpu = 0; cpu < CPU_SETSIZE; cpu++) {
+		if (!CPU_ISSET(cpu, &set))
+			continue;
+		if (*lo < 0)
+			*lo = cpu;
+		*hi = cpu;
+	}
+	return *lo < 0 ? -1 : 0;
+}
+
 static bool task_exists(__u32 tid)
 {
 	char path[64];
@@ -405,6 +459,67 @@ static void test_stop_ring(__u32 size)
 	bpf_kthread__destroy(skel);
 }
 
+/*
+ * A thread bound before its start runs on that CPU, and the last bind wins. A
+ * thread bound while it runs moves at its next sleep, which for a body that
+ * parks is at once, since the park sleeps with migration enabled; its next
+ * iteration runs on the new CPU.
+ */
+static void test_bind(void)
+{
+	struct bpf_kthread *skel;
+	int lo, hi;
+	__u32 loops;
+
+	if (!ASSERT_OK(allowed_cpus(&lo, &hi), "allowed_cpus"))
+		return;
+	skel = bpf_kthread__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "open_and_load"))
+		return;
+	if (create_thread_on(skel, 0, false, BODY_WORKER, lo))
+		goto out;
+	ASSERT_EQ(bind_thread(skel, 0, -1), -EINVAL, "bind impossible cpu");
+	ASSERT_EQ(bind_thread(skel, 0, hi), 0, "bind ret");
+	ASSERT_EQ(start_thread(skel, 0), 0, "start ret");
+	if (!ASSERT_TRUE(wait_past(&skel->bss->loops[0], 0), "ran"))
+		goto out;
+	ASSERT_EQ(skel->bss->cpus[0], hi, "cpu");
+	ASSERT_EQ(bind_thread(skel, 0, lo), 0, "bind running ret");
+	loops = skel->bss->loops[0];
+	ASSERT_GE(wake_thread(skel, 0), 0, "wake ret");
+	if (ASSERT_TRUE(wait_past(&skel->bss->loops[0], loops), "looped"))
+		ASSERT_EQ(skel->bss->cpus[0], lo, "cpu after bind");
+	ASSERT_EQ(stop_thread(skel, 0), 0, "stop ret");
+out:
+	bpf_kthread__destroy(skel);
+}
+
+/*
+ * A thread binds itself: it is migratable during the call, so the bind takes
+ * effect before it returns, and the thread's first iteration runs on the CPU.
+ */
+static void test_self_bind(void)
+{
+	struct bpf_kthread *skel;
+	int lo, hi;
+
+	if (!ASSERT_OK(allowed_cpus(&lo, &hi), "allowed_cpus"))
+		return;
+	skel = bpf_kthread__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "open_and_load"))
+		return;
+	skel->bss->self_bind_cpu = lo;
+	if (create_thread(skel, 0, true, BODY_SELF_BINDER))
+		goto out;
+	if (!ASSERT_TRUE(wait_past(&skel->bss->loops[0], 0), "ran"))
+		goto out;
+	ASSERT_EQ(skel->bss->self_bind_ret, 0, "self bind ret");
+	ASSERT_EQ(skel->bss->cpus[0], lo, "cpu");
+	ASSERT_EQ(stop_thread(skel, 0), 0, "stop ret");
+out:
+	bpf_kthread__destroy(skel);
+}
+
 void test_bpf_kthread(void)
 {
 	RUN_TESTS(verifier_bpf_kthread);
@@ -431,4 +546,8 @@ void test_bpf_kthread(void)
 		test_stop_ring(2);
 	if (test__start_subtest("stop_ring3"))
 		test_stop_ring(3);
+	if (test__start_subtest("bind"))
+		test_bind();
+	if (test__start_subtest("self_bind"))
+		test_self_bind();
 }
diff --git a/tools/testing/selftests/bpf/progs/bpf_kthread.c b/tools/testing/selftests/bpf/progs/bpf_kthread.c
index 97812fdd2005..99ec48339158 100644
--- a/tools/testing/selftests/bpf/progs/bpf_kthread.c
+++ b/tools/testing/selftests/bpf/progs/bpf_kthread.c
@@ -28,6 +28,8 @@ struct kthread_args {
 	__u32 idx;		/* the thread's slot, and the argument of its callback */
 	__u32 start;		/* create: start the thread */
 	__u32 body;		/* create: which callback, see enum body */
+	__u32 bind;		/* create: bind the thread to cpu before starting it */
+	__u32 cpu;		/* create and bind: the CPU */
 };
 
 enum body {
@@ -36,11 +38,14 @@ enum body {
 	BODY_SELF_STOPPER,	/* try to stop itself first, then as above */
 	BODY_RING,		/* stop the next thread of a ring, then return idx + 1 */
 	BODY_STOP_CHECKER,	/* park until stopped, then record what later parks return */
+	BODY_SELF_BINDER,	/* bind itself to self_bind_cpu first, then as worker */
 };
 
 __u32 runs[NR_THREADS];		/* callback entries, per slot */
 __u32 tids[NR_THREADS];		/* the thread's PID, per slot */
 char comms[NR_THREADS][16];	/* the comm the thread read for itself, per slot */
+__u32 cpus[NR_THREADS];		/* the CPU the thread last ran on, per slot */
+__u32 loops[NR_THREADS];	/* iterations of the body's loop, per slot */
 __u32 exit_now[NR_THREADS];	/* set by the test: the callback returns idx + 1 */
 int self_stop_ret;		/* bpf_kthread_stop() on the calling thread */
 int spawn_ret;			/* bpf_kthread_start() by the spawner */
@@ -50,6 +55,8 @@ __u32 ring_size;		/* set by the test: threads in the ring */
 __u32 ring_ready;		/* ring threads about to stop their successor */
 int ring_stop_ret[NR_THREADS];	/* what stopping the successor returned, per slot */
 int stop_park_rets[4];		/* what the park returned once a stop was pending */
+__u32 self_bind_cpu;		/* set by the test: where the self binder binds itself */
+int self_bind_ret;		/* what that bind returned */
 
 static __u32 load(__u32 *p)
 {
@@ -74,6 +81,8 @@ static int worker(__u64 arg)
 	__sync_fetch_and_add(&runs[idx], 1);
 
 	bpf_repeat(LOOP_BOUND) {
+		cpus[idx] = bpf_get_smp_processor_id();
+		__sync_fetch_and_add(&loops[idx], 1);
 		if (bpf_kthread_should_stop())
 			return 0;
 		if (load(&exit_now[idx]))
@@ -191,6 +200,13 @@ static int ring_stopper(__u64 arg)
 	return idx + 1;
 }
 
+/* Bind itself to self_bind_cpu, then run as a worker, which records its CPU. */
+static int self_binder(__u64 arg)
+{
+	self_bind_ret = bpf_kthread_bind(bpf_get_current_task_btf(), load(&self_bind_cpu), 0);
+	return worker(arg);
+}
+
 /* Take the thread out of slot @idx; the caller releases it. */
 static struct task_struct *take(__u32 idx)
 {
@@ -216,20 +232,28 @@ int create_thread(struct kthread_args *args)
 		task = bpf_kthread_create(ring_stopper, args->idx, 0);
 	else if (args->body == BODY_STOP_CHECKER)
 		task = bpf_kthread_create(stop_checker, args->idx, 0);
+	else if (args->body == BODY_SELF_BINDER)
+		task = bpf_kthread_create(self_binder, args->idx, 0);
 	else
 		task = bpf_kthread_create(worker, args->idx, 0);
 	if (!task)
 		return -EAGAIN;
+	if (args->bind) {
+		ret = bpf_kthread_bind(task, args->cpu, 0);
+		if (ret)
+			goto stop;
+	}
 	if (args->start) {
 		ret = bpf_kthread_start(task, 0);
-		if (ret) {
-			bpf_kthread_stop(task, 0);
-			bpf_task_release(task);
-			return ret;
-		}
+		if (ret)
+			goto stop;
 	}
 	publish(args->idx, task);
 	return 0;
+stop:
+	bpf_kthread_stop(task, 0);
+	bpf_task_release(task);
+	return ret;
 }
 
 /* Start the thread of slot idx through the RCU-protected pointer in its slot. */
@@ -272,6 +296,21 @@ int wake_thread(struct kthread_args *args)
 	return ret;
 }
 
+/* Bind the thread of slot idx to args->cpu, running or not. */
+SEC("syscall")
+int bind_thread(struct kthread_args *args)
+{
+	struct task_struct *task;
+	int ret;
+
+	task = take(args->idx);
+	if (!task)
+		return -ESRCH;
+	ret = bpf_kthread_bind(task, args->cpu, 0);
+	publish(args->idx, task);
+	return ret;
+}
+
 /* Stop the thread of slot idx and empty the slot; returns what the stop returned. */
 SEC("syscall")
 int stop_thread(struct kthread_args *args)
-- 
2.53.0

