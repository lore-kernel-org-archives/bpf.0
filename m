Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.225.139
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794270502;
	b=xz9xLbMFY+EDGCeLMIOvUSa/C/JN/f3NXc3+JQ5/fz6aumUX7+80wvuXx4gj3JZpOIKv
	 /ex2YeqdXqAb8nzqsUZpx6j6CnKPhSMctREsJw6CnXLpM9VA9wXrV5v9+Sj4MFwYnTCNh
	 Shf6rGgeaTBBrTr8wiFWd1Waif6OtpgjP0aDRh0pQWWoIqlAQz1zt0FkfwwSmd+mxA4XB
	 KslI72lHr8C5CQKkxA5YpBa6Wo7eBstRqrZoC8U20zMh1tj0VsSWZJaoFYJQcJpYRYJSi
	 Byeayff86PZLLWuoq/SMdUe/uFQJwqtAYjEbQfD8/R3XbNCbr6DZ10TqRi10kjG0beg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794270502;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 X-Developer-Signature:X-Developer-Key:Content-Transfer-Encoding;
	bh=BXfF7q/YVDDlebqn52YdZv8DNI6I5y98dxEhxzS9Z8o=;
	b=yAhAwv3TgYOqSKj5H6FmmgaZBYg9FXzlp+sJvPG6iIf0wZdkDB6hb8tAoV+jZMrlAVId
	 EEoEzeaSEf36NhIGcKOmG1EScFfNk2yPE9qQakeUEN3ODZBOs/D18khEoeLRP+3vVMwGk
	 t8210jLFbeBBObq/bGfqTDFozfpJcHVfVOFobi4fDz+bTVFjxhmgFRSNOkYEPJzyYnceM
	 wqLmsh++2RcTe3hf8qhW3jGt4uypAfFYd2Z5bmMPutlFbx6HhbGYOh0YCsqWcCCvpurtO
	 KrbSC19k9WX5Vkp6RQrt39lP5wP2FpJM3vIDpmZj/Ta8xkd1UJGQz9zeVVEvyLwJCcw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="cZsVj/sB";
	arc=none smtp.remote-ip=74.125.225.139
Received: from mail-wm2-f11.google.com (mail-wm2-f11.google.com [74.125.225.139])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A60C606A31C
	for <bpf@vger.kernel.org>; Tue, 10 Nov 2026 00:28:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9A60C606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cZsVj/sB
Received: by mail-wm2-f11.google.com with SMTP id 5b1f17b1804b1-4b769975b2bso6474955e9.1
        for <bpf@vger.kernel.org>; Mon, 09 Nov 2026 16:28:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794270500; x=1794875300; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BXfF7q/YVDDlebqn52YdZv8DNI6I5y98dxEhxzS9Z8o=;
        b=cZsVj/sB5p6to/Grz+wGV3qBI8eRqgXeRfilqv7jwOfVWFLn853vZTTymRH1FLWPIy
         VyA0QodtSnXY3bei+3ArJ0ANBSz9qhE6iy4f/3swJX8ju3PiiTuFvQ8/KCGKDw2GB97c
         2iEMTclrMRneAK7+i7KRvfOVsyfSvfKRUwkzntprJQDQb6jmqQ4pJRgtouq3Cu0CxRE4
         UG3a0z9eAAqW33aYWmspD5IYce5eBJAF1wHHGIWGKHPYUUxvpFO1MybzAMKYEVLvvFRY
         ri3XoO8j+UehFVrMi1kwlD2AnrckYM3zkYNqZxWesPqDiMwJAutMcqUjo53bS0ZGGSBL
         Yp4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794270500; x=1794875300;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=BXfF7q/YVDDlebqn52YdZv8DNI6I5y98dxEhxzS9Z8o=;
        b=NQDtiQcs0ExFUTwYG9W+NBWzkOT8lRXAcbTKZO80RXMuhfRIKHiVXxoReBEjQ7l35v
         u2Mf07k8zodgE2gBgL0tccfRLjMnnhpDQmH9Fx7J75SQnhVyW5XDevbbCbbQ0DerTrbV
         rI1rT2XeYNfRA/24n7wEXZH8Zoxu4XpNf8PS5n7yfu+HRP0sKJzS5XmJaw4j6KHYgk6V
         a9jUHaQqPzDymJQugx+0lpsRtpiC1OicdQgb/d9DQGII+H9zpT4Et6nypJhWqPD12Ct2
         by8Cq+H/J97r56bpVF5960s7R/1xSLnaUwGmOO5SgPK0IRaHupS9I9Ji+5VZXgXlME42
         fGHQ==
X-Gm-Message-State: APuU4Z86YnJuE5swAzWVHySx0ajBSvbDyscztmZg5kvTg4S87b1kAd7Y
	esxb32rTnWRKdSid/pVXv7Iw0g5HxKgMfobuvF6Qzi5PDYmj1j8fD94qa5nfA5DA
X-Gm-Gg: AYBFou0FVLzQ7xN50CU2NgO08RwuA7p4I7nmFv0iS9CRccoewQskVJd6zQEZV5X4OFP
	l/xnmtxsT0qVsUdfVKxJ7x418UC/hxn8g8gQQbhmT6ooWVNbZp9MDtwj1iNxLLfr7037qfIPGPX
	HF6789KLnWuyp5L7lZ8ctFNnzCgYVIYXQ+kteOXBke3Y/0wGDacBajEGtZi1cMgJH4QXpddOa4a
	AVxsJ2CLL0ajQpc1ujaLDQ3mPouOMyr48MBRxYgwmmyk140ch9RGBM0zly0eRwHEyjObIRaVhgv
	J/d/kXUUyxPUHvcZNmUfEWr+AdL7gLjxLD7KBWut3kEgPHp36vGHqFdcgU/xrhyCKHQ6MCfC7Iq
	OAO9AnwuX83DF9tNtwVTdhQpCOujN8rd1lcPNLQlmSmn7CPokabQpIoVt0oQW5Z0UiAoDPCRg9e
	n/ukbANdNOibEp8FLdtdbxkL7yeRg7iQUy2Jptr9TFmHzI/xrEmbdViZ5iA7JPdwJj4qweYisFj
	HfPsIz5IDSSvAouj83tojh5sOndq5ZofHOePtjHE9ouwxfD/jrDEuUaOYXC7cemeJP3ADpFaIeB
	fNd6uCpqz3iwWAgp+BKLi85X7liExIcwinxXZOS/EkpdDJgJ2Lnl0SH9mkJET/1NGM7GM+b/TWM
	MC6rhNdtozC/UsyJllFB4jid3uJfDM0nxSPhaARG+2G77JcGSPDcuBKVtEmhTSFMvf+Eo
X-Received: by 2002:a05:600c:1989:b0:4a1:80d8:aed5 with SMTP id 5b1f17b1804b1-4ba0233f99amr12689255e9.6.1794270499581;
        Mon, 09 Nov 2026 16:28:19 -0800 (PST)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ba0236bb1asm12791765e9.2.2026.11.09.16.28.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 16:28:18 -0800 (PST)
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
Subject: [PATCH bpf-next v1 18/20] selftests/bpf: Test BPF kthreads
Date: Tue, 10 Nov 2026 01:27:40 +0100
Message-ID: <9f1f608b4ee5e6f5e9f5807f95c7fe2fa60d5343.1794269507.git.memxor@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=36474; i=memxor@gmail.com; h=from:subject:message-id; bh=xFH6otyE34FeJ4coHzeWh8boiYz/P9sjUOVuYRvNpDQ=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIetToif7uUqH+RstE43Z1vYcNLteIDazV4b9DWNR+GS7q 2w7r/3oKGVhEONikBVTZCn5v4/J+ETl70DbZdwwc1iZQIYwcHEKwETetDAy7DG9V3Iy7K4J+7qL 1n+eNeVNszrNEiR4ppfz8cZJpc8FPjEy/HCa/rR1vsH5NbseCE+yX6jQHWhTbu48v8DffWIdT54 xBwA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Exercise the kthread kfuncs from syscall programs. The thread's body
records its PID and parks until the test wakes it to return or a stop is
pending. The subtests cover a thread that exits through its callback's
return and reports that return to a later stop; a stop that ends a running
callback through bpf_kthread_should_stop(); what the park returns to a
thread that is being stopped, -ESHUTDOWN from then on except when it has a
wake to consume; a stop before the start, which
runs no callback and reports -EINTR; a start through an RCU-protected kptr
and a repeated start; a thread that cannot stop itself; a thread that
creates and starts another from its callback; the control kfuncs on a task
that is no BPF kthread, nonzero flags, and bpf_kthread_should_stop() from a
thread of a user process; the thread's name; and the stop of a running
thread when the last reference on its program goes.

The verifier cases pin the reference the creation returns and the program
must release, the callback's scalar argument and 32-bit return, a callback
that creates a thread, the task pointers the control kfuncs take, the
registration for syscall programs only, and the refusal of may_goto in a
program that creates a thread, since the creation may migrate.

The worker bodies sleep in bpf_task_park() between their checks, with a
timeout of ten seconds, well past what any test waits, so that a lost
wake fails a test instead of being covered by the timeout. The start_exit
test checks that the thread sleeps before it wakes it to return. The
verifier tests check that the park is allowed in the body and in a
global function the body calls, and refused in a bpf_loop() callback
under the body, directly or through that function. The name check
expects the program's thread index after its id both in the full name
/proc reports and in the comm the thread reads for itself with
bpf_get_current_comm(), and the spawn test checks the second thread's
index. A callback that indexes an array with its argument checks that
the argument is a scalar the body can bound, and a global function that
creates a thread with a parking body loads when called from a bpf_wq
callback, since taking the body's address does not make the function
park.

Two threads stopping each other, and three in a ring, exercise the
refusal of the stop that would close a ring of waits: each thread waits
until all of them are about to stop, or until its own stop arrives, so
that the waits do form a ring, exactly one stop returns -EDEADLK, the
others return their successor's exit code as the ring unwinds, every
thread exits, and only the thread the refused stop was aimed at is left
in its slot for the test to collect.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../testing/selftests/bpf/bpf_experimental.h  |   6 +
 .../selftests/bpf/prog_tests/bpf_kthread.c    | 434 ++++++++++++++++++
 .../testing/selftests/bpf/progs/bpf_kthread.c | 334 ++++++++++++++
 .../bpf/progs/verifier_bpf_kthread.c          | 398 ++++++++++++++++
 4 files changed, 1172 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/bpf_kthread.c
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_kthread.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_bpf_kthread.c

diff --git a/tools/testing/selftests/bpf/bpf_experimental.h b/tools/testing/selftests/bpf/bpf_experimental.h
index ccb6e749edd5..0fcb969ba034 100644
--- a/tools/testing/selftests/bpf/bpf_experimental.h
+++ b/tools/testing/selftests/bpf/bpf_experimental.h
@@ -354,6 +354,12 @@ extern int bpf_wq_start(struct bpf_wq *wq, unsigned int flags) __weak __ksym;
 extern int bpf_task_park(__u64 timeout_ns, __u64 flags) __weak __ksym;
 extern int bpf_task_wake(struct task_struct *task, __u64 flags) __weak __ksym;
 
+extern struct task_struct *bpf_kthread_create(int (callback_fn)(__u64 arg), __u64 arg,
+					      __u64 flags) __weak __ksym;
+extern int bpf_kthread_start(struct task_struct *task, __u64 flags) __weak __ksym;
+extern int bpf_kthread_stop(struct task_struct *task, __u64 flags) __weak __ksym;
+extern bool bpf_kthread_should_stop(void) __weak __ksym;
+
 struct bpf_iter_kmem_cache;
 extern int bpf_iter_kmem_cache_new(struct bpf_iter_kmem_cache *it) __weak __ksym;
 extern struct kmem_cache *bpf_iter_kmem_cache_next(struct bpf_iter_kmem_cache *it) __weak __ksym;
diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_kthread.c b/tools/testing/selftests/bpf/prog_tests/bpf_kthread.c
new file mode 100644
index 000000000000..095cdef37d66
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_kthread.c
@@ -0,0 +1,434 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
+
+#include <test_progs.h>
+#include "bpf_kthread.skel.h"
+#include "verifier_bpf_kthread.skel.h"
+
+/* The context of the syscall programs, as the programs declare it. */
+struct kthread_args {
+	__u32 idx;
+	__u32 start;
+	__u32 body;
+};
+
+enum body {
+	BODY_WORKER,
+	BODY_SPAWNER,
+	BODY_SELF_STOPPER,
+	BODY_RING,
+	BODY_STOP_CHECKER,
+};
+
+static int run_prog(struct bpf_program *prog, struct kthread_args *args, int *retval)
+{
+	LIBBPF_OPTS(bpf_test_run_opts, opts,
+		.ctx_in = args,
+		.ctx_size_in = args ? sizeof(*args) : 0,
+	);
+	int err;
+
+	err = bpf_prog_test_run_opts(bpf_program__fd(prog), &opts);
+	if (!err)
+		*retval = opts.retval;
+	return err;
+}
+
+static int create_thread(struct bpf_kthread *skel, __u32 idx, bool start, enum body body)
+{
+	struct kthread_args args = { .idx = idx, .start = start, .body = body };
+	int err, retval;
+
+	err = run_prog(skel->progs.create_thread, &args, &retval);
+	if (!ASSERT_OK(err, "create_thread") || !ASSERT_EQ(retval, 0, "create_ret"))
+		return -1;
+	return 0;
+}
+
+/* Returns what the program returned, which for stop_thread is what the stop returned. */
+static int control_thread(struct bpf_program *prog, __u32 idx)
+{
+	struct kthread_args args = { .idx = idx };
+	int retval;
+
+	if (!ASSERT_OK(run_prog(prog, &args, &retval), bpf_program__name(prog)))
+		return -EFAULT;
+	return retval;
+}
+
+#define start_thread(skel, idx) control_thread((skel)->progs.start_thread, idx)
+#define wake_thread(skel, idx) control_thread((skel)->progs.wake_thread, idx)
+#define stop_thread(skel, idx) control_thread((skel)->progs.stop_thread, idx)
+
+/* Poll until *p is nonzero, for up to two seconds. */
+static bool wait_for(__u32 *p)
+{
+	int i;
+
+	for (i = 0; i < 2000; i++) {
+		if (__atomic_load_n(p, __ATOMIC_ACQUIRE))
+			return true;
+		usleep(1000);
+	}
+	return false;
+}
+
+/* Whether the thread sleeps: state 'S' in /proc/<tid>/stat, read past the parenthesised comm. */
+static bool thread_sleeping(__u32 tid)
+{
+	char path[64], buf[512], *p;
+	int fd, n;
+
+	snprintf(path, sizeof(path), "/proc/%u/stat", tid);
+	fd = open(path, O_RDONLY);
+	if (fd < 0)
+		return false;
+	n = read(fd, buf, sizeof(buf) - 1);
+	close(fd);
+	if (n <= 0)
+		return false;
+	buf[n] = 0;
+	p = strrchr(buf, ')');
+	return p && p[1] == ' ' && p[2] == 'S';
+}
+
+/* Poll until the thread sleeps, for up to two seconds. */
+static bool wait_sleeping(__u32 tid)
+{
+	int i;
+
+	for (i = 0; i < 2000; i++) {
+		if (thread_sleeping(tid))
+			return true;
+		usleep(1000);
+	}
+	return false;
+}
+
+static bool task_exists(__u32 tid)
+{
+	char path[64];
+
+	snprintf(path, sizeof(path), "/proc/%u", tid);
+	return !access(path, F_OK);
+}
+
+/* Poll until the task has left /proc, for up to two seconds. */
+static bool wait_gone(__u32 tid)
+{
+	int i;
+
+	for (i = 0; i < 2000; i++) {
+		if (!task_exists(tid))
+			return true;
+		usleep(1000);
+	}
+	return false;
+}
+
+static int read_file(const char *path, char *buf, size_t size)
+{
+	int fd, n;
+
+	fd = open(path, O_RDONLY);
+	if (fd < 0)
+		return -errno;
+	n = read(fd, buf, size - 1);
+	close(fd);
+	if (n < 0)
+		return -errno;
+	buf[n] = 0;
+	return n;
+}
+
+/*
+ * The thread is named after the program that created it and its index among
+ * the program's threads. /proc shows a kernel thread's full name whatever its
+ * length; the comm the thread reads for itself is what tracepoints and perf
+ * report, and the name is short enough to fit it.
+ */
+static void check_comm(struct bpf_kthread *skel, __u32 tid, __u32 idx)
+{
+	struct bpf_prog_info info = {};
+	__u32 len = sizeof(info);
+	char path[64], buf[512], want[64];
+
+	if (!ASSERT_OK(bpf_prog_get_info_by_fd(bpf_program__fd(skel->progs.create_thread),
+					       &info, &len), "prog_info"))
+		return;
+	snprintf(want, sizeof(want), "bpfk/%u:%u", info.id, idx);
+
+	snprintf(path, sizeof(path), "/proc/%u/comm", tid);
+	if (!ASSERT_GT(read_file(path, buf, sizeof(buf)), 0, "read comm"))
+		return;
+	if (buf[strlen(buf) - 1] == '\n')
+		buf[strlen(buf) - 1] = 0;
+	ASSERT_STREQ(buf, want, "comm");
+	ASSERT_STREQ(skel->bss->comms[idx], want, "task comm");
+}
+
+/*
+ * A started thread runs its callback, which parks until woken; its return ends
+ * the thread and is what the stop reports.
+ */
+static void test_start_exit(void)
+{
+	struct bpf_kthread *skel;
+	__u32 tid;
+
+	skel = bpf_kthread__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "open_and_load"))
+		return;
+	if (create_thread(skel, 0, true, BODY_WORKER))
+		goto out;
+	if (!ASSERT_TRUE(wait_for(&skel->bss->runs[0]), "ran"))
+		goto out;
+	tid = skel->bss->tids[0];
+	ASSERT_TRUE(task_exists(tid), "alive");
+	ASSERT_TRUE(wait_sleeping(tid), "parked");
+	check_comm(skel, tid, 0);
+
+	__atomic_store_n(&skel->bss->exit_now[0], 1, __ATOMIC_RELEASE);
+	ASSERT_GE(wake_thread(skel, 0), 0, "wake ret");
+	ASSERT_TRUE(wait_gone(tid), "exited");
+	ASSERT_EQ(stop_thread(skel, 0), 1, "exit code");
+	ASSERT_EQ(skel->bss->runs[0], 1, "runs");
+	ASSERT_EQ(stop_thread(skel, 0), -ESRCH, "slot empty");
+out:
+	bpf_kthread__destroy(skel);
+}
+
+/* A stop ends a running callback through bpf_kthread_should_stop(). */
+static void test_stop_running(void)
+{
+	struct bpf_kthread *skel;
+	__u32 tid;
+
+	skel = bpf_kthread__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "open_and_load"))
+		return;
+	if (create_thread(skel, 1, true, BODY_WORKER))
+		goto out;
+	if (!ASSERT_TRUE(wait_for(&skel->bss->runs[1]), "ran"))
+		goto out;
+	tid = skel->bss->tids[1];
+	ASSERT_EQ(stop_thread(skel, 1), 0, "stop ret");
+	ASSERT_TRUE(wait_gone(tid), "exited");
+out:
+	bpf_kthread__destroy(skel);
+}
+
+/* A stop makes every park return -ESHUTDOWN, except one that has a wake to consume. */
+static void test_stop_park_rets(void)
+{
+	struct bpf_kthread *skel;
+
+	skel = bpf_kthread__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "open_and_load"))
+		return;
+	if (create_thread(skel, 0, true, BODY_STOP_CHECKER))
+		goto out;
+	if (!ASSERT_TRUE(wait_for(&skel->bss->runs[0]), "ran"))
+		goto out;
+	ASSERT_EQ(stop_thread(skel, 0), 1, "stop ret");
+	ASSERT_EQ(skel->bss->stop_park_rets[0], -ESHUTDOWN, "park the stop ended");
+	ASSERT_EQ(skel->bss->stop_park_rets[1], -ESHUTDOWN, "poll after the stop");
+	ASSERT_EQ(skel->bss->stop_park_rets[2], 0, "park with a wake pending");
+	ASSERT_EQ(skel->bss->stop_park_rets[3], -ESHUTDOWN, "park after the wake");
+out:
+	bpf_kthread__destroy(skel);
+}
+
+/* A thread stopped before it is started never runs its callback. */
+static void test_stop_parked(void)
+{
+	struct bpf_kthread *skel;
+
+	skel = bpf_kthread__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "open_and_load"))
+		return;
+	if (create_thread(skel, 2, false, BODY_WORKER))
+		goto out;
+	ASSERT_EQ(stop_thread(skel, 2), -EINTR, "stop ret");
+	ASSERT_EQ(skel->bss->runs[2], 0, "runs");
+out:
+	bpf_kthread__destroy(skel);
+}
+
+/* A parked thread starts through an RCU-protected pointer; a second start is a no-op. */
+static void test_start_later(void)
+{
+	struct bpf_kthread *skel;
+
+	skel = bpf_kthread__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "open_and_load"))
+		return;
+	if (create_thread(skel, 2, false, BODY_WORKER))
+		goto out;
+	ASSERT_EQ(start_thread(skel, 2), 0, "start ret");
+	if (!ASSERT_TRUE(wait_for(&skel->bss->runs[2]), "ran"))
+		goto out;
+	ASSERT_EQ(start_thread(skel, 2), 0, "second start ret");
+	ASSERT_EQ(stop_thread(skel, 2), 0, "stop ret");
+	ASSERT_EQ(skel->bss->runs[2], 1, "runs");
+out:
+	bpf_kthread__destroy(skel);
+}
+
+/* A thread cannot stop itself. */
+static void test_self_stop(void)
+{
+	struct bpf_kthread *skel;
+
+	skel = bpf_kthread__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "open_and_load"))
+		return;
+	if (create_thread(skel, 3, true, BODY_SELF_STOPPER))
+		goto out;
+	if (!ASSERT_TRUE(wait_for(&skel->bss->runs[3]), "ran"))
+		goto out;
+	ASSERT_EQ(skel->bss->self_stop_ret, -EDEADLK, "self stop ret");
+	ASSERT_EQ(stop_thread(skel, 3), 0, "stop ret");
+out:
+	bpf_kthread__destroy(skel);
+}
+
+/* A thread creates and starts another thread from its callback. */
+static void test_spawn(void)
+{
+	struct bpf_kthread *skel;
+
+	skel = bpf_kthread__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "open_and_load"))
+		return;
+	if (create_thread(skel, 0, true, BODY_SPAWNER))
+		goto out;
+	if (!ASSERT_TRUE(wait_for(&skel->bss->runs[1]), "child ran") ||
+	    !ASSERT_TRUE(wait_for(&skel->bss->runs[0]), "parent ran"))
+		goto out;
+	ASSERT_EQ(skel->bss->spawn_ret, 0, "spawn ret");
+	ASSERT_NEQ(skel->bss->tids[0], skel->bss->tids[1], "distinct threads");
+	check_comm(skel, skel->bss->tids[0], 0);
+	check_comm(skel, skel->bss->tids[1], 1);
+	ASSERT_EQ(stop_thread(skel, 1), 0, "stop child");
+	ASSERT_EQ(stop_thread(skel, 0), 0, "stop parent");
+out:
+	bpf_kthread__destroy(skel);
+}
+
+/* Tasks that are no BPF kthreads, nonzero flags, and a stop before the start. */
+static void test_misuse(void)
+{
+	struct bpf_kthread *skel;
+	int retval;
+
+	skel = bpf_kthread__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "open_and_load"))
+		return;
+	if (ASSERT_OK(run_prog(skel->progs.control_foreign_task, NULL, &retval), "foreign")) {
+		ASSERT_EQ(retval, 0, "foreign ret");
+		ASSERT_EQ(skel->bss->foreign_start_ret, -ESRCH, "foreign start ret");
+		ASSERT_EQ(skel->bss->foreign_stop_ret, -ESRCH, "foreign stop ret");
+	}
+	if (ASSERT_OK(run_prog(skel->progs.misuse, NULL, &retval), "misuse"))
+		ASSERT_EQ(retval, 0, "misuse ret");
+	bpf_kthread__destroy(skel);
+}
+
+/* The program's release stops the threads it still has. */
+static void test_program_free(void)
+{
+	struct bpf_kthread *skel;
+	__u32 tid;
+
+	skel = bpf_kthread__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "open_and_load"))
+		return;
+	if (create_thread(skel, 0, true, BODY_WORKER))
+		goto out;
+	if (!ASSERT_TRUE(wait_for(&skel->bss->runs[0]), "ran"))
+		goto out;
+	tid = skel->bss->tids[0];
+	bpf_kthread__destroy(skel);
+	ASSERT_TRUE(wait_gone(tid), "exited");
+	return;
+out:
+	bpf_kthread__destroy(skel);
+}
+
+/*
+ * Threads stopping each other in a ring. The stop that would close the ring of
+ * waits is refused with -EDEADLK, the others return their successor's exit
+ * code as the ring unwinds, and every thread exits. The thread the refused
+ * stop was aimed at is the one left in its slot; the others were taken by the
+ * threads that stopped them.
+ */
+static void test_stop_ring(__u32 size)
+{
+	struct bpf_kthread *skel;
+	int refused = 0, left = 0, ret;
+	__u32 i, peer;
+
+	skel = bpf_kthread__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "open_and_load"))
+		return;
+	skel->bss->ring_size = size;
+	for (i = 0; i < size; i++)
+		if (create_thread(skel, i, false, BODY_RING))
+			goto out;
+	for (i = 0; i < size; i++)
+		if (!ASSERT_EQ(start_thread(skel, i), 0, "start ret"))
+			goto out;
+	for (i = 0; i < size; i++) {
+		if (!ASSERT_TRUE(wait_for(&skel->bss->runs[i]), "ran") ||
+		    !ASSERT_TRUE(wait_gone(skel->bss->tids[i]), "exited"))
+			goto out;
+	}
+	for (i = 0; i < size; i++) {
+		peer = i + 1 < size ? i + 1 : 0;
+		ret = skel->bss->ring_stop_ret[i];
+		if (ret == -EDEADLK)
+			refused++;
+		else
+			ASSERT_EQ(ret, peer + 1, "ring stop ret");
+	}
+	ASSERT_EQ(refused, 1, "one stop refused");
+	for (i = 0; i < size; i++) {
+		ret = stop_thread(skel, i);
+		if (ret == -ESRCH)
+			continue;
+		ASSERT_EQ(ret, i + 1, "exit code");
+		left++;
+	}
+	ASSERT_EQ(left, 1, "one thread left in its slot");
+out:
+	bpf_kthread__destroy(skel);
+}
+
+void test_bpf_kthread(void)
+{
+	RUN_TESTS(verifier_bpf_kthread);
+
+	if (test__start_subtest("start_exit"))
+		test_start_exit();
+	if (test__start_subtest("stop_running"))
+		test_stop_running();
+	if (test__start_subtest("stop_park_rets"))
+		test_stop_park_rets();
+	if (test__start_subtest("stop_parked"))
+		test_stop_parked();
+	if (test__start_subtest("start_later"))
+		test_start_later();
+	if (test__start_subtest("self_stop"))
+		test_self_stop();
+	if (test__start_subtest("spawn"))
+		test_spawn();
+	if (test__start_subtest("misuse"))
+		test_misuse();
+	if (test__start_subtest("program_free"))
+		test_program_free();
+	if (test__start_subtest("stop_ring2"))
+		test_stop_ring(2);
+	if (test__start_subtest("stop_ring3"))
+		test_stop_ring(3);
+}
diff --git a/tools/testing/selftests/bpf/progs/bpf_kthread.c b/tools/testing/selftests/bpf/progs/bpf_kthread.c
new file mode 100644
index 000000000000..97812fdd2005
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/bpf_kthread.c
@@ -0,0 +1,334 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
+
+#include "bpf_experimental.h"
+#include <bpf/bpf_helpers.h>
+#include <errno.h>
+#include "bpf_misc.h"
+
+char _license[] SEC("license") = "GPL";
+
+#define NR_THREADS 4
+#define LOOP_BOUND (1 << 23)	/* BPF_MAX_LOOPS */
+#define PARK_TIMEOUT_NS (10ULL * 1000 * 1000 * 1000)
+
+struct thread_slot {
+	struct task_struct __kptr *task;
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, NR_THREADS);
+	__type(key, __u32);
+	__type(value, struct thread_slot);
+} threads SEC(".maps");
+
+/* The context of the syscall programs below. */
+struct kthread_args {
+	__u32 idx;		/* the thread's slot, and the argument of its callback */
+	__u32 start;		/* create: start the thread */
+	__u32 body;		/* create: which callback, see enum body */
+};
+
+enum body {
+	BODY_WORKER,		/* loop until told to return or asked to stop */
+	BODY_SPAWNER,		/* create and start thread 1 first, then as above */
+	BODY_SELF_STOPPER,	/* try to stop itself first, then as above */
+	BODY_RING,		/* stop the next thread of a ring, then return idx + 1 */
+	BODY_STOP_CHECKER,	/* park until stopped, then record what later parks return */
+};
+
+__u32 runs[NR_THREADS];		/* callback entries, per slot */
+__u32 tids[NR_THREADS];		/* the thread's PID, per slot */
+char comms[NR_THREADS][16];	/* the comm the thread read for itself, per slot */
+__u32 exit_now[NR_THREADS];	/* set by the test: the callback returns idx + 1 */
+int self_stop_ret;		/* bpf_kthread_stop() on the calling thread */
+int spawn_ret;			/* bpf_kthread_start() by the spawner */
+int foreign_start_ret;		/* bpf_kthread_start() on a task that is no BPF kthread */
+int foreign_stop_ret;		/* bpf_kthread_stop() on the same */
+__u32 ring_size;		/* set by the test: threads in the ring */
+__u32 ring_ready;		/* ring threads about to stop their successor */
+int ring_stop_ret[NR_THREADS];	/* what stopping the successor returned, per slot */
+int stop_park_rets[4];		/* what the park returned once a stop was pending */
+
+static __u32 load(__u32 *p)
+{
+	return *(volatile __u32 *)p;
+}
+
+/*
+ * The body of a thread: record who runs it, then sleep in bpf_task_park()
+ * until the test wakes it to return or bpf_kthread_stop() asks it to stop. The
+ * park's timeout is ten seconds, well past what a test waits, so that a lost
+ * wake fails the test instead of passing on the timeout. The bounded loop
+ * outlasts any test; a callback cannot loop without a bound.
+ */
+static int worker(__u64 arg)
+{
+	__u64 idx = arg;
+
+	if (idx >= NR_THREADS)
+		return -EINVAL;
+	tids[idx] = bpf_get_current_pid_tgid();
+	bpf_get_current_comm(comms[idx], sizeof(comms[idx]));
+	__sync_fetch_and_add(&runs[idx], 1);
+
+	bpf_repeat(LOOP_BOUND) {
+		if (bpf_kthread_should_stop())
+			return 0;
+		if (load(&exit_now[idx]))
+			return idx + 1;
+		bpf_task_park(PARK_TIMEOUT_NS, 0);
+	}
+	return -ETIME;
+}
+
+/*
+ * What bpf_task_park() returns to a thread that is being stopped: -ESHUTDOWN
+ * from the park that the stop ends or finds, and from every later one, a poll
+ * included, except one that finds a wake pending, which wins as it does over a
+ * signal. The stop is pending for good, so none of this depends on where the
+ * thread was when it arrived.
+ */
+static int stop_checker(__u64 arg)
+{
+	__u64 idx = arg;
+	int ret = 0;
+
+	if (idx >= NR_THREADS)
+		return -EINVAL;
+	__sync_fetch_and_add(&runs[idx], 1);
+
+	bpf_repeat(LOOP_BOUND) {
+		ret = bpf_task_park(PARK_TIMEOUT_NS, 0);
+		if (ret == -ESHUTDOWN)
+			break;
+	}
+	stop_park_rets[0] = ret;
+	stop_park_rets[1] = bpf_task_park(0, 0);
+	bpf_task_wake(bpf_get_current_task_btf(), 0);
+	stop_park_rets[2] = bpf_task_park(PARK_TIMEOUT_NS, 0);
+	stop_park_rets[3] = bpf_task_park(PARK_TIMEOUT_NS, 0);
+	return idx + 1;
+}
+
+/* Publish @task in slot @idx, releasing whatever the slot held. */
+static void publish(__u32 idx, struct task_struct *task)
+{
+	struct thread_slot *slot;
+
+	slot = bpf_map_lookup_elem(&threads, &idx);
+	if (!slot) {
+		bpf_task_release(task);
+		return;
+	}
+	task = bpf_kptr_xchg(&slot->task, task);
+	if (task)
+		bpf_task_release(task);
+}
+
+/* Thread 0 of the spawn case: it creates and starts thread 1, then runs as worker 0. */
+static int spawner(__u64 arg)
+{
+	struct task_struct *task;
+
+	task = bpf_kthread_create(worker, 1, 0);
+	if (!task) {
+		spawn_ret = -ENOMEM;
+		return -ENOMEM;
+	}
+	spawn_ret = bpf_kthread_start(task, 0);
+	publish(1, task);
+	return worker(arg);
+}
+
+static int self_stopper(__u64 arg)
+{
+	self_stop_ret = bpf_kthread_stop(bpf_get_current_task_btf(), 0);
+	return worker(arg);
+}
+
+/*
+ * Thread @idx of a ring of ring_size threads stops thread idx + 1, the last
+ * one thread 0. Each waits until all of them are about to stop, so that the
+ * stops form a ring of waits: the stop that would close it is refused with
+ * -EDEADLK and the others complete as the ring unwinds. A thread returns
+ * idx + 1 once its stop has returned, whichever way it did.
+ */
+static int ring_stopper(__u64 arg)
+{
+	__u64 idx = arg, size = load(&ring_size);
+	struct task_struct *task = NULL, *peer_task;
+	struct thread_slot *slot;
+	__u32 peer;
+
+	if (idx >= NR_THREADS || !size)
+		return -EINVAL;
+	tids[idx] = bpf_get_current_pid_tgid();
+	__sync_fetch_and_add(&runs[idx], 1);
+
+	peer = idx + 1 < size ? idx + 1 : 0;
+	slot = bpf_map_lookup_elem(&threads, &peer);
+	if (!slot)
+		return -ENOENT;
+	bpf_rcu_read_lock();
+	peer_task = slot->task;
+	if (peer_task)
+		task = bpf_task_acquire(peer_task);
+	bpf_rcu_read_unlock();
+	if (!task)
+		return -ESRCH;
+
+	/* A stop can only arrive once every thread is at the barrier: leave it then too. */
+	__sync_fetch_and_add(&ring_ready, 1);
+	bpf_repeat(LOOP_BOUND) {
+		if (load(&ring_ready) >= size || bpf_kthread_should_stop())
+			break;
+		bpf_task_park(1000000, 0);
+	}
+	ring_stop_ret[idx] = bpf_kthread_stop(task, 0);
+	bpf_task_release(task);
+	return idx + 1;
+}
+
+/* Take the thread out of slot @idx; the caller releases it. */
+static struct task_struct *take(__u32 idx)
+{
+	struct thread_slot *slot;
+
+	slot = bpf_map_lookup_elem(&threads, &idx);
+	if (!slot)
+		return NULL;
+	return bpf_kptr_xchg(&slot->task, NULL);
+}
+
+SEC("syscall")
+int create_thread(struct kthread_args *args)
+{
+	struct task_struct *task;
+	int ret;
+
+	if (args->body == BODY_SPAWNER)
+		task = bpf_kthread_create(spawner, args->idx, 0);
+	else if (args->body == BODY_SELF_STOPPER)
+		task = bpf_kthread_create(self_stopper, args->idx, 0);
+	else if (args->body == BODY_RING)
+		task = bpf_kthread_create(ring_stopper, args->idx, 0);
+	else if (args->body == BODY_STOP_CHECKER)
+		task = bpf_kthread_create(stop_checker, args->idx, 0);
+	else
+		task = bpf_kthread_create(worker, args->idx, 0);
+	if (!task)
+		return -EAGAIN;
+	if (args->start) {
+		ret = bpf_kthread_start(task, 0);
+		if (ret) {
+			bpf_kthread_stop(task, 0);
+			bpf_task_release(task);
+			return ret;
+		}
+	}
+	publish(args->idx, task);
+	return 0;
+}
+
+/* Start the thread of slot idx through the RCU-protected pointer in its slot. */
+SEC("syscall")
+int start_thread(struct kthread_args *args)
+{
+	struct thread_slot *slot;
+	struct task_struct *task;
+	__u32 idx = args->idx;
+	int ret = -ESRCH;
+
+	slot = bpf_map_lookup_elem(&threads, &idx);
+	if (!slot)
+		return -ENOENT;
+	bpf_rcu_read_lock();
+	task = slot->task;
+	if (task)
+		ret = bpf_kthread_start(task, 0);
+	bpf_rcu_read_unlock();
+	return ret;
+}
+
+/* Wake the thread of slot idx from its park, through the RCU-protected pointer in its slot. */
+SEC("syscall")
+int wake_thread(struct kthread_args *args)
+{
+	struct thread_slot *slot;
+	struct task_struct *task;
+	__u32 idx = args->idx;
+	int ret = -ESRCH;
+
+	slot = bpf_map_lookup_elem(&threads, &idx);
+	if (!slot)
+		return -ENOENT;
+	bpf_rcu_read_lock();
+	task = slot->task;
+	if (task)
+		ret = bpf_task_wake(task, 0);
+	bpf_rcu_read_unlock();
+	return ret;
+}
+
+/* Stop the thread of slot idx and empty the slot; returns what the stop returned. */
+SEC("syscall")
+int stop_thread(struct kthread_args *args)
+{
+	struct task_struct *task;
+	int ret;
+
+	task = take(args->idx);
+	if (!task)
+		return -ESRCH;
+	ret = bpf_kthread_stop(task, 0);
+	bpf_task_release(task);
+	return ret;
+}
+
+/* The control kfuncs refuse a task that is no BPF kthread, init here. */
+SEC("syscall")
+int control_foreign_task(void *ctx)
+{
+	struct task_struct *task;
+
+	task = bpf_task_from_pid(1);
+	if (!task)
+		return -ESRCH;
+	foreign_start_ret = bpf_kthread_start(task, 0);
+	foreign_stop_ret = bpf_kthread_stop(task, 0);
+	bpf_task_release(task);
+	return 0;
+}
+
+/*
+ * A thread of a user process is never asked to stop, nonzero flags are refused
+ * everywhere, and a thread stopped before it was started reports -EINTR.
+ */
+SEC("syscall")
+int misuse(void *ctx)
+{
+	struct task_struct *task;
+	int ret;
+
+	if (bpf_kthread_should_stop())
+		return 1;
+	task = bpf_kthread_create(worker, 0, 1);
+	if (task) {
+		bpf_kthread_stop(task, 0);
+		bpf_task_release(task);
+		return 2;
+	}
+	task = bpf_kthread_create(worker, 0, 0);
+	if (!task)
+		return 3;
+	if (bpf_kthread_start(task, 1) != -EINVAL)
+		ret = 4;
+	else if (bpf_kthread_stop(task, 1) != -EINVAL)
+		ret = 5;
+	else
+		ret = bpf_kthread_stop(task, 0) == -EINTR ? 0 : 6;
+	bpf_task_release(task);
+	return ret;
+}
diff --git a/tools/testing/selftests/bpf/progs/verifier_bpf_kthread.c b/tools/testing/selftests/bpf/progs/verifier_bpf_kthread.c
new file mode 100644
index 000000000000..26f732702698
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_bpf_kthread.c
@@ -0,0 +1,398 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
+
+#include "bpf_experimental.h"
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+
+char _license[] SEC("license") = "GPL";
+
+struct slot {
+	struct task_struct __kptr *task;
+	struct task_struct __kptr_untrusted *untrusted_task;
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, 1);
+	__type(key, __u32);
+	__type(value, struct slot);
+} slots SEC(".maps");
+
+static struct slot *lookup_slot(void)
+{
+	__u32 key = 0;
+
+	return bpf_map_lookup_elem(&slots, &key);
+}
+
+static int body(__u64 arg)
+{
+	return 0;
+}
+
+static int body_negative(__u64 arg)
+{
+	return -1;
+}
+
+static int body_deref_arg(__u64 arg)
+{
+	return *(int *)arg;
+}
+
+static int body_spawns(__u64 arg)
+{
+	struct task_struct *task;
+
+	task = bpf_kthread_create(body, arg, 0);
+	if (!task)
+		return -1;
+	bpf_task_release(task);
+	return 0;
+}
+
+static int body_parks(__u64 arg)
+{
+	return bpf_task_park(0, 0);
+}
+
+/* A global function that parks is admitted from the thread body as from the main program. */
+__noinline int kthread_park_global(void)
+{
+	return bpf_task_park(0, 0);
+}
+
+static int body_parks_via_global(__u64 arg)
+{
+	return kthread_park_global();
+}
+
+static int park_cb(__u32 index, void *data)
+{
+	bpf_task_park(0, 0);
+	return 1;
+}
+
+static int body_parks_in_callback(__u64 arg)
+{
+	bpf_loop(1, park_cb, NULL, 0);
+	return 0;
+}
+
+static int park_global_cb(__u32 index, void *data)
+{
+	kthread_park_global();
+	return 1;
+}
+
+static int body_parks_via_global_in_callback(__u64 arg)
+{
+	bpf_loop(1, park_global_cb, NULL, 0);
+	return 0;
+}
+
+/* The task bpf_kthread_create() returns carries a reference the program must release. */
+SEC("syscall")
+__failure __msg("Unreleased reference")
+int create_leaks_task(void *ctx)
+{
+	return bpf_kthread_create(body, 0, 0) != NULL;
+}
+
+SEC("syscall")
+__success
+int create_releases_task(void *ctx)
+{
+	struct task_struct *task;
+
+	task = bpf_kthread_create(body, 0, 0);
+	if (!task)
+		return 0;
+	bpf_task_release(task);
+	return 0;
+}
+
+/* The callback returns an int and is checked as one: a negative return is fine. */
+SEC("syscall")
+__success
+int callback_returns_negative(void *ctx)
+{
+	struct task_struct *task;
+
+	task = bpf_kthread_create(body_negative, 0, 0);
+	if (!task)
+		return 0;
+	bpf_task_release(task);
+	return 0;
+}
+
+/* The callback's argument is a number, whatever the creator passed. */
+SEC("syscall")
+__failure __msg("R1 invalid mem access 'scalar'")
+int callback_dereferences_arg(void *ctx)
+{
+	struct task_struct *task;
+
+	task = bpf_kthread_create(body_deref_arg, 0, 0);
+	if (!task)
+		return 0;
+	bpf_task_release(task);
+	return 0;
+}
+
+/* A thread may create threads. */
+SEC("syscall")
+__success
+int callback_creates_thread(void *ctx)
+{
+	struct task_struct *task;
+
+	task = bpf_kthread_create(body_spawns, 0, 0);
+	if (!task)
+		return 0;
+	bpf_task_release(task);
+	return 0;
+}
+
+/* The thread body may sleep in bpf_task_park(), directly or through a global function. */
+SEC("syscall")
+__success
+int callback_parks(void *ctx)
+{
+	struct task_struct *task;
+
+	task = bpf_kthread_create(body_parks, 0, 0);
+	if (!task)
+		return 0;
+	bpf_task_release(task);
+	return 0;
+}
+
+SEC("syscall")
+__success
+int callback_parks_via_global(void *ctx)
+{
+	struct task_struct *task;
+
+	task = bpf_kthread_create(body_parks_via_global, 0, 0);
+	if (!task)
+		return 0;
+	bpf_task_release(task);
+	return 0;
+}
+
+/* A callback under the thread body is a callback like any other: no park there. */
+SEC("syscall")
+__failure __msg("bpf_task_park() is not allowed in a callback")
+int callback_parks_in_nested_callback(void *ctx)
+{
+	struct task_struct *task;
+
+	task = bpf_kthread_create(body_parks_in_callback, 0, 0);
+	if (!task)
+		return 0;
+	bpf_task_release(task);
+	return 0;
+}
+
+SEC("syscall")
+__failure __msg("global function kthread_park_global() may call bpf_task_park(), "
+		"which is not allowed in a callback")
+int callback_parks_via_global_in_nested_callback(void *ctx)
+{
+	struct task_struct *task;
+
+	task = bpf_kthread_create(body_parks_via_global_in_callback, 0, 0);
+	if (!task)
+		return 0;
+	bpf_task_release(task);
+	return 0;
+}
+
+__u32 indexed[4];
+
+/* The argument is an unknown scalar: the body bounds it before it indexes with it. */
+static int body_indexes_arg(__u64 arg)
+{
+	if (arg < 4)
+		return indexed[arg];
+	return 0;
+}
+
+SEC("syscall")
+__success
+int callback_indexes_with_arg(void *ctx)
+{
+	struct task_struct *task;
+
+	task = bpf_kthread_create(body_indexes_arg, 1, 0);
+	if (!task)
+		return 0;
+	bpf_task_release(task);
+	return 0;
+}
+
+/*
+ * The creation waits for kthreadd with migration enabled, so the program may
+ * go on on another CPU, where the time slice of may_goto is another run's.
+ */
+SEC("syscall")
+__failure __msg("may_goto cannot be used in a program that may migrate")
+int create_with_may_goto(void *ctx)
+{
+	struct task_struct *task;
+	int i;
+
+	for (i = 0; i < 4 && can_loop; i++) {
+		task = bpf_kthread_create(body_indexes_arg, i, 0);
+		if (task)
+			bpf_task_release(task);
+	}
+	return 0;
+}
+
+struct wq_elem {
+	struct bpf_wq wq;
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, 1);
+	__type(key, __u32);
+	__type(value, struct wq_elem);
+} wq_map SEC(".maps");
+
+/* Taking the address of a body that parks does not make this function park. */
+__noinline int spawn_parking_thread(void)
+{
+	struct task_struct *task;
+
+	task = bpf_kthread_create(body_parks, 0, 0);
+	if (!task)
+		return -1;
+	bpf_task_release(task);
+	return 0;
+}
+
+static int spawn_wq_cb(void *map, int *key, void *value)
+{
+	spawn_parking_thread();
+	return 0;
+}
+
+/* So a global function that creates such a thread may be called from a callback. */
+SEC("syscall")
+__success
+int global_spawner_in_wq_callback(void *ctx)
+{
+	struct wq_elem *elem;
+	__u32 key = 0;
+
+	elem = bpf_map_lookup_elem(&wq_map, &key);
+	if (!elem)
+		return 0;
+	if (bpf_wq_init(&elem->wq, &wq_map, 0))
+		return 0;
+	return bpf_wq_set_callback(&elem->wq, spawn_wq_cb, 0);
+}
+
+/*
+ * bpf_kthread_stop() takes a referenced or trusted task; bpf_kthread_start()
+ * also an RCU-protected one that is not NULL.
+ */
+SEC("syscall")
+__failure __msg("R1 must be referenced or trusted")
+int stop_untrusted_task(void *ctx)
+{
+	struct slot *slot = lookup_slot();
+	struct task_struct *task;
+
+	if (!slot)
+		return 0;
+	task = slot->untrusted_task;
+	if (!task)
+		return 0;
+	return bpf_kthread_stop(task, 0);
+}
+
+SEC("syscall")
+__failure __msg("R1 must be a rcu pointer")
+int start_untrusted_task(void *ctx)
+{
+	struct slot *slot = lookup_slot();
+	struct task_struct *task;
+
+	if (!slot)
+		return 0;
+	task = slot->untrusted_task;
+	if (!task)
+		return 0;
+	return bpf_kthread_start(task, 0);
+}
+
+SEC("syscall")
+__failure __msg("Possibly NULL pointer passed to trusted R1")
+int start_maybe_null_task(void *ctx)
+{
+	struct slot *slot = lookup_slot();
+	struct task_struct *task;
+	int ret;
+
+	if (!slot)
+		return 0;
+	bpf_rcu_read_lock();
+	task = slot->task;
+	ret = bpf_kthread_start(task, 0);
+	bpf_rcu_read_unlock();
+	return ret;
+}
+
+SEC("syscall")
+__success
+int start_rcu_task(void *ctx)
+{
+	struct slot *slot = lookup_slot();
+	struct task_struct *task;
+	int ret = 0;
+
+	if (!slot)
+		return 0;
+	bpf_rcu_read_lock();
+	task = slot->task;
+	if (task)
+		ret = bpf_kthread_start(task, 0);
+	bpf_rcu_read_unlock();
+	return ret;
+}
+
+/* bpf_kthread_stop() sleeps, so a pointer that only an RCU section protects will not do. */
+SEC("syscall")
+__failure __msg("kernel func bpf_kthread_stop is sleepable within rcu_read_lock region")
+int stop_rcu_task(void *ctx)
+{
+	struct slot *slot = lookup_slot();
+	struct task_struct *task;
+	int ret = 0;
+
+	if (!slot)
+		return 0;
+	bpf_rcu_read_lock();
+	task = slot->task;
+	if (task)
+		ret = bpf_kthread_stop(task, 0);
+	bpf_rcu_read_unlock();
+	return ret;
+}
+
+SEC("tp/syscalls/sys_enter_nanosleep")
+__failure __msg("calling kernel function bpf_kthread_create is not allowed")
+int create_from_tracepoint(void *ctx)
+{
+	struct task_struct *task;
+
+	task = bpf_kthread_create(body, 0, 0);
+	if (task)
+		bpf_task_release(task);
+	return 0;
+}
-- 
2.53.0

