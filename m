Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.225.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794270494;
	b=gkd3TS/dyILQXqJx7YKmg5/iGRKDIvcgJLzLsOF2+cSa4fv8Fr4pka+oqOElISRL8iEm
	 xdITXP8booyHSvKp19ziU7uIdWPrEkS0A8hwHohSSD8zyHCsWGsqE6m/h1a0bGc2CS9Zq
	 gqAqGnkYOPSQRdM0uaa8SyAwuVuRvBiW6s9Eb89KIHrLG+KOUmDy4uZ7HrecMuhzvmYnw
	 ZWL+zPCxoUYFlfsU4x8q6VXIAhfTg/RP+YBYLRtfKn7yIVKSBpYTYw8oRs+hLi8lYu+ll
	 LRGAGCWr9t+bXXZ9dzuQ2ttFpa40QMR5L3plTWQUmJzfN+7aC+WJj4qb8qU/pd9RTjg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794270494;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 X-Developer-Signature:X-Developer-Key:Content-Transfer-Encoding;
	bh=WY2WrvH7AXrAtnOetGnQiKMlvDK0B42W5dVJ3bHM7T4=;
	b=wSuRlFOtYtxzMSC1dL/0T6FqSA5TxrHOF/DwfLkiwZTfyBeM7MeSO9N1LPjnj8rp1BEt
	 DvbTClMHuGJs0HoGLWHghB/wk2OsY5A0/KFHagPL7d4RTAkejxxSREDuV5KyFfadCFwI0
	 /S94c+mVI1yoZ/unfC8IbMNPVfmk5uN0j0s849RQ98YWjf8VeJdR/FWkqC7iYzZ0fLgal
	 qB5o9cgl03/dpykvfFY8oT6xztDFWUJWuYJssCfdbuF1uYwX/zQpoF2xxoKymW/mtRCtm
	 cTalT95SHk6D1Rfrv/D33RxIRinZNXjIrEBSnjU2rfa1iKdUifxgribyX6K8LgptwFg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=x6r3LHCb;
	arc=none smtp.remote-ip=74.125.225.72
Received: from mail-wr2-f8.google.com (mail-wr2-f8.google.com [74.125.225.72])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B82D606A31C
	for <bpf@vger.kernel.org>; Tue, 10 Nov 2026 00:28:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1B82D606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=x6r3LHCb
Received: by mail-wr2-f8.google.com with SMTP id ffacd0b85a97d-48df4afd489so424211f8f.0
        for <bpf@vger.kernel.org>; Mon, 09 Nov 2026 16:28:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794270492; x=1794875292; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WY2WrvH7AXrAtnOetGnQiKMlvDK0B42W5dVJ3bHM7T4=;
        b=x6r3LHCbavVIgFWfmqlmBCBltjaVHPSJ2Auxv7+hOae5Gr6GFdQaYd0AYuGdvFPWzS
         uBZ+uVIbxhItXjeJy1tGOxEfG3XU4f4fJ/tFMneDqGgC+Z2Slkf5XuEeT3Yw18MEZ8KY
         n0uv/xxyhmebOC/zZUb+sjurxHplxaRyAN61JBt2jZztDKiTIEm3L0t9V0ygU0c3QODu
         lGZENArVnsEJN/0h7+L7HDK2+E8sND5nvIHH9lCPqzs8RpKjmr7bxRFk8jPCDVZHmVrw
         r7+/i6UWBiffZthhf3g2fk1niVs4+O5lM6RB/FFZaFmEqau8glj8w3Tc+aLhfEiZ++uR
         Ixpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794270492; x=1794875292;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=WY2WrvH7AXrAtnOetGnQiKMlvDK0B42W5dVJ3bHM7T4=;
        b=dHHY2TXS29W2VN0NyWi7nDurpVcg46UkrIUKyriyaD9kINV/61P2tdPpw5HHsSLd7K
         Tjf9+fRFkj8khbzjEjj6MujoqJ2bXgQyDK4hjlnU0R4wYMfu5trwTPDS/1WXZVa2RXz8
         zWbmBslVHLTJjP08cEP6jhZYPEr5hZtt0D9fq6V8waE/2lr1WBbKWxmWkY3EXMxXa4G9
         5Lonr8C8fYN6h/NjQDZXEOKnHPkeTbO+QyBhGOGZralbQQe3nc5v105hFOiDkR7oE3ZT
         PMAJMOFoeYAM+qYYm+gxaXInmOc+BfpVMZG1CTUyQB9GDP3nPJTw2DEn1+hsppsFmT/f
         RS/w==
X-Gm-Message-State: APuU4Z+EUoSSKq34+GJKmF/8091YWSDKpRgEJknMNM0TgllNk4Wio2qI
	XbN1w8HzNbxSLWC3bFpC+g1IcOEM/wpLZld1YMQ1q21FUrp8OkqvGIXVCwfV5d86
X-Gm-Gg: AYBFou07fpOtyQ1g0pV2oiVBGYF0M/i+RHNpqO/A/1TRiq7/g4VZyIyPBkwdPpVzR+M
	7TwQprwnm+9rV9QTMT7CuILsFnY+Tmcuk/LDnPso5TcZMeWHPoz0KubMIf653dumGfueIhxeERw
	L+qsArfAIRHXmDIk7enR6MmhG8x6B+6sGTvHm8T/9fxfup9aK4KI5nFgQ6JVaf862U5DnSFeBFr
	ORrww8fTAIZ5C9/yB7QA0gUXgENKMqbxxtg1hAVSF07oNVNosgkjjXGx6nKCx92wnF4X083cYda
	N7s8EeQxZTI8WtHMcNuwcW46pR9P1r6T6lOYd+KVfyhtpBBD43zdH+8AhxCoDCajmtl7lHxZ4F3
	lT4Ek0OUcZlDVhnYULGDqDhOgoPvReFifRr1sewdGVx/talbUzihg6SvTPdFsId8rJwJx2IvPXa
	Q4syvqq4WVc+tipLVK0d8jVxXLkMyhDwcFZPJ836zeuHkqvY1gfq4vDyeXLdS53pDUEU+7ZNRR/
	9aPD2o4yJbddWtQcZLXF5elnMTzUW/MSayerpsFrpyrtqKWMSSNN4od1ZeAP2SADwtYkUCXKGvT
	+Z2jAhUmkAabMvlhPCLhcZttds9dpDkBxsmJTGMRXms+ON2aX1wkk0fVd5KQDBMUfy/a96kvrQm
	toXbnkRqw3w1jMDmE3ITDR/HGOZgE0dd70oau+jGyl5Bfrw1ZHkAxs7ufDCduM84So874
X-Received: by 2002:a05:600c:1d14:b0:4a1:faa1:3813 with SMTP id 5b1f17b1804b1-4ba0234f9e1mr11901925e9.27.1794270492354;
        Mon, 09 Nov 2026 16:28:12 -0800 (PST)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ba0234a5dcsm23180795e9.2.2026.11.09.16.28.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 16:28:11 -0800 (PST)
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
Subject: [PATCH bpf-next v1 14/20] selftests/bpf: Test bpf_task_park() and bpf_task_wake()
Date: Tue, 10 Nov 2026 01:27:36 +0100
Message-ID: <c639853745afb71f1391a496113ca8ab4318bea0.1794269507.git.memxor@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=15879; i=memxor@gmail.com; h=from:subject:message-id; bh=ivVLNKwGfqIdZ+TrOCw+SzuD+nBx2db6F+xNPyYHbv0=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIetTokde0rkE9UNZ34+qVSxYcijzm8rdpQzXJ3EFC09If mcaWrCpo5SFQYyLQVZMkaXk/z4m4xOVvwNtl3HDzGFlAhnCwMUpABP5NY/hf8Tk/wErXpo9SXl2 1HOhlWHoQvlvD5uDlzGVnUnX9WD22c7wP2xmmAJzzZa3uzY8lxdWMC//Pm/e2fn/L4koZe9gC96 5mAMA
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Cover the runtime behaviour of the two kfuncs with the intended pattern.
The waiter resets a condition in a map value, publishes itself through a
task kptr, and loops on the condition around the park. The element is a
value of an array map, which the program holds, so the loop keeps its
pointer across the park; a value of a hash map would have to be looked
up again on every turn. The waker loads the published task under
bpf_rcu_read_lock(), and only if it finds one sets the condition and
wakes it.

That order in the waker is what makes the wake test deterministic. If
the waker set the condition first and then looked for a task, a turn
that landed between the waiter's reset of the condition and its
publication would set the condition with nobody to wake; the waiter
would then see it set, return without any wake having reached it, and
every later wake would find no task. The test would fail on a legal
interleaving. Setting the condition only once a task is found closes
the window: the waiter returns 0 only after a wake run that found it,
and such a run reports 0 or 1. It is also the order the kfunc's release
store pairs with: a park that consumes the wake sees the condition on
its next look.

The subtests check that a park with nobody to wake it times out; that a
wake delivered to a running task makes the next park return at once,
even a poll with a zero timeout, and that the park consumes it so a
second poll times out; that a waiter blocked with a timer returns 0
once a waker has found it and set the condition; that a waiter blocked
without a timer is found asleep, which is made deterministic by waiting
until the thread shows as sleeping in /proc before issuing the one wake
that must return 1; that a signal ends the wait with -EINTR on the next
park; that non-zero flags are rejected; and that a prog array takes a
syscall program that wakes but refuses one that parks, which would
otherwise sleep as the target of a tail call.

The waiter's park is bounded by a 10 second timeout from a global the
harness can change, so that a lost wake fails the affected subtest with
a timeout instead of hanging the run until the test_progs watchdog
fires. Only the asleep subtest removes the bound, for the one park it
observes, and restores it before draining the waiter.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../testing/selftests/bpf/bpf_experimental.h  |   3 +
 .../selftests/bpf/prog_tests/task_park.c      | 240 ++++++++++++++++++
 tools/testing/selftests/bpf/progs/task_park.c | 172 +++++++++++++
 3 files changed, 415 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/task_park.c
 create mode 100644 tools/testing/selftests/bpf/progs/task_park.c

diff --git a/tools/testing/selftests/bpf/bpf_experimental.h b/tools/testing/selftests/bpf/bpf_experimental.h
index 2893bf06ff25..ccb6e749edd5 100644
--- a/tools/testing/selftests/bpf/bpf_experimental.h
+++ b/tools/testing/selftests/bpf/bpf_experimental.h
@@ -351,6 +351,9 @@ extern void bpf_iter_css_destroy(struct bpf_iter_css *it) __weak __ksym;
 extern int bpf_wq_init(struct bpf_wq *wq, void *p__map, unsigned int flags) __weak __ksym;
 extern int bpf_wq_start(struct bpf_wq *wq, unsigned int flags) __weak __ksym;
 
+extern int bpf_task_park(__u64 timeout_ns, __u64 flags) __weak __ksym;
+extern int bpf_task_wake(struct task_struct *task, __u64 flags) __weak __ksym;
+
 struct bpf_iter_kmem_cache;
 extern int bpf_iter_kmem_cache_new(struct bpf_iter_kmem_cache *it) __weak __ksym;
 extern struct kmem_cache *bpf_iter_kmem_cache_next(struct bpf_iter_kmem_cache *it) __weak __ksym;
diff --git a/tools/testing/selftests/bpf/prog_tests/task_park.c b/tools/testing/selftests/bpf/prog_tests/task_park.c
new file mode 100644
index 000000000000..a65539fdc412
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/task_park.c
@@ -0,0 +1,240 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
+
+#include <test_progs.h>
+#include <pthread.h>
+#include <signal.h>
+#include <sys/syscall.h>
+#include "task_park.skel.h"
+
+static int run_syscall_prog(struct bpf_program *prog, __u32 *retval)
+{
+	LIBBPF_OPTS(bpf_test_run_opts, opts);
+	int err;
+
+	err = bpf_prog_test_run_opts(bpf_program__fd(prog), &opts);
+	if (!err)
+		*retval = opts.retval;
+	return err;
+}
+
+/* A thread blocked in a syscall program that parks. */
+struct waiter {
+	struct bpf_program *prog;
+	pthread_t thread;
+	pid_t tid;
+	__u32 retval;
+	int err;
+	int done;
+};
+
+static void *waiter_fn(void *arg)
+{
+	struct waiter *w = arg;
+
+	__atomic_store_n(&w->tid, syscall(SYS_gettid), __ATOMIC_RELEASE);
+	w->err = run_syscall_prog(w->prog, &w->retval);
+	__atomic_store_n(&w->done, 1, __ATOMIC_RELEASE);
+	return NULL;
+}
+
+static bool waiter_done(struct waiter *w)
+{
+	return __atomic_load_n(&w->done, __ATOMIC_ACQUIRE);
+}
+
+static int start_waiter(struct waiter *w, struct bpf_program *prog)
+{
+	memset(w, 0, sizeof(*w));
+	w->prog = prog;
+	return pthread_create(&w->thread, NULL, waiter_fn, w);
+}
+
+/*
+ * Whether the waiter thread sleeps in the kernel, which for this thread can
+ * only be the park: state 'S' in /proc/self/task/<tid>/stat, read past the
+ * parenthesised comm.
+ */
+static bool waiter_sleeping(struct waiter *w)
+{
+	pid_t tid = __atomic_load_n(&w->tid, __ATOMIC_ACQUIRE);
+	char path[64], buf[512], *p;
+	int fd, n;
+
+	if (!tid)
+		return false;
+	snprintf(path, sizeof(path), "/proc/self/task/%d/stat", tid);
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
+/*
+ * Wake the waiter until it has returned. A wake before the waiter published
+ * itself finds no task and sets nothing; one that finds the task sets the
+ * condition, so the waiter returns 0 only after a wake run that found it,
+ * and such a run returns 0 or 1. Returns the last result that found a task,
+ * or -ESRCH if none did.
+ */
+static int wake_until_done(struct task_park *skel, struct waiter *w)
+{
+	int i, last = -ESRCH;
+	__u32 retval;
+
+	for (i = 0; i < 5000 && !waiter_done(w); i++) {
+		if (run_syscall_prog(skel->progs.wake_waiter, &retval))
+			break;
+		if ((__s32)retval >= 0)
+			last = retval;
+		usleep(1000);
+	}
+	return last;
+}
+
+static void test_timeout(struct task_park *skel)
+{
+	__u32 retval;
+
+	if (ASSERT_OK(run_syscall_prog(skel->progs.park_timeout, &retval), "park_timeout"))
+		ASSERT_EQ((__s32)retval, -ETIMEDOUT, "timeout_ret");
+}
+
+static void test_flags(struct task_park *skel)
+{
+	__u32 retval;
+
+	if (ASSERT_OK(run_syscall_prog(skel->progs.bad_flags, &retval), "bad_flags"))
+		ASSERT_EQ(retval, 0, "flags_ret");
+}
+
+static void test_pending(struct task_park *skel)
+{
+	__u32 retval;
+
+	if (ASSERT_OK(run_syscall_prog(skel->progs.park_pending, &retval), "park_pending"))
+		ASSERT_EQ((__s32)retval, -ETIMEDOUT, "pending_ret");
+}
+
+static void test_wake(struct task_park *skel)
+{
+	struct waiter w;
+	int last;
+
+	if (!ASSERT_OK(start_waiter(&w, skel->progs.park_until_woken), "pthread_create"))
+		return;
+	last = wake_until_done(skel, &w);
+	pthread_join(w.thread, NULL);
+	ASSERT_GE(last, 0, "wake_found_waiter");
+	ASSERT_OK(w.err, "park_until_woken");
+	ASSERT_EQ((__s32)w.retval, 0, "wake_park_ret");
+}
+
+/*
+ * Wake a waiter that is known to be asleep, without a timer: once the thread
+ * shows as sleeping, the one wake that follows must report that it found the
+ * task asleep.
+ */
+static void test_wake_asleep(struct task_park *skel)
+{
+	__u64 timeout = skel->data->park_timeout_ns;
+	struct waiter w;
+	__u32 retval;
+	int i;
+
+	skel->data->park_timeout_ns = ~0ULL;
+	if (!ASSERT_OK(start_waiter(&w, skel->progs.park_until_woken), "pthread_create"))
+		goto out;
+	for (i = 0; i < 5000 && !waiter_sleeping(&w); i++)
+		usleep(1000);
+	if (ASSERT_TRUE(waiter_sleeping(&w), "waiter_sleeping")) {
+		if (ASSERT_OK(run_syscall_prog(skel->progs.wake_waiter, &retval), "wake_waiter"))
+			ASSERT_EQ((__s32)retval, 1, "wake_found_asleep");
+	}
+	/* Bound any further park before draining, so a lost wake cannot hang the join. */
+	skel->data->park_timeout_ns = timeout;
+	wake_until_done(skel, &w);
+	pthread_join(w.thread, NULL);
+	ASSERT_OK(w.err, "park_until_woken");
+	ASSERT_EQ((__s32)w.retval, 0, "wake_park_ret");
+out:
+	skel->data->park_timeout_ns = timeout;
+}
+
+static void sig_noop(int sig)
+{
+}
+
+/*
+ * A program that parks cannot be the target of a tail call: a prog array takes
+ * a syscall program that wakes and refuses one that parks.
+ */
+static void test_prog_array(struct task_park *skel)
+{
+	int map_fd = bpf_map__fd(skel->maps.jmp_table);
+	__u32 key = 0;
+	int fd;
+
+	fd = bpf_program__fd(skel->progs.wake_waiter);
+	ASSERT_OK(bpf_map_update_elem(map_fd, &key, &fd, BPF_ANY), "member_that_wakes");
+	fd = bpf_program__fd(skel->progs.park_timeout);
+	ASSERT_EQ(bpf_map_update_elem(map_fd, &key, &fd, BPF_ANY), -EINVAL, "member_that_parks");
+}
+
+/* A signal ends the sleep, and the park reports it as -EINTR. */
+static void test_signal(struct task_park *skel)
+{
+	struct sigaction sa = { .sa_handler = sig_noop }, old_sa;
+	struct waiter w;
+	bool interrupted;
+	int i;
+
+	if (!ASSERT_OK(sigaction(SIGUSR2, &sa, &old_sa), "sigaction"))
+		return;
+	if (!ASSERT_OK(start_waiter(&w, skel->progs.park_until_woken), "pthread_create"))
+		goto out;
+	/* A signal handled before the thread enters its syscall ends nothing: resend. */
+	for (i = 0; i < 5000 && !waiter_done(&w); i++) {
+		pthread_kill(w.thread, SIGUSR2);
+		usleep(1000);
+	}
+	interrupted = waiter_done(&w);
+	if (!interrupted)
+		wake_until_done(skel, &w);
+	pthread_join(w.thread, NULL);
+	ASSERT_TRUE(interrupted, "interrupted");
+	ASSERT_OK(w.err, "park_until_woken");
+	ASSERT_EQ((__s32)w.retval, -EINTR, "signal_park_ret");
+out:
+	sigaction(SIGUSR2, &old_sa, NULL);
+}
+
+void test_task_park(void)
+{
+	struct task_park *skel;
+
+	skel = task_park__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "open_and_load"))
+		return;
+	if (test__start_subtest("timeout"))
+		test_timeout(skel);
+	if (test__start_subtest("flags"))
+		test_flags(skel);
+	if (test__start_subtest("pending"))
+		test_pending(skel);
+	if (test__start_subtest("wake"))
+		test_wake(skel);
+	if (test__start_subtest("wake_asleep"))
+		test_wake_asleep(skel);
+	if (test__start_subtest("prog_array"))
+		test_prog_array(skel);
+	if (test__start_subtest("signal"))
+		test_signal(skel);
+	task_park__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/task_park.c b/tools/testing/selftests/bpf/progs/task_park.c
new file mode 100644
index 000000000000..c777cc787dab
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/task_park.c
@@ -0,0 +1,172 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
+
+#include "bpf_experimental.h"
+#include <errno.h>
+
+/* Exercise bpf_task_park() and bpf_task_wake() from syscall programs. */
+char _license[] SEC("license") = "GPL";
+
+extern struct task_struct *bpf_task_acquire(struct task_struct *task) __ksym;
+extern void bpf_task_release(struct task_struct *task) __ksym;
+extern void bpf_rcu_read_lock(void) __ksym;
+extern void bpf_rcu_read_unlock(void) __ksym;
+
+#define READ_ONCE(x) (*(volatile typeof(x) *)&(x))
+#define WRITE_ONCE(x, v) (*(volatile typeof(x) *)&(x) = (v))
+
+enum { WAITING, WOKEN };
+
+/* The waiter publishes itself here; the waker sets the condition and wakes it. */
+struct park_elem {
+	struct task_struct __kptr *task;
+	__u32 state;
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, 1);
+	__type(key, __u32);
+	__type(value, struct park_elem);
+} park_map SEC(".maps");
+
+/* A tail call would run its target under the caller's protection, which a park leaves. */
+struct {
+	__uint(type, BPF_MAP_TYPE_PROG_ARRAY);
+	__uint(max_entries, 1);
+	__uint(key_size, sizeof(__u32));
+	__uint(value_size, sizeof(__u32));
+} jmp_table SEC(".maps");
+
+/* Bound on each sleep of the waiter, so that a lost wake fails a test instead of hanging it. */
+__u64 park_timeout_ns = 10ULL * 1000 * 1000 * 1000;
+
+static __always_inline struct park_elem *lookup_elem(void)
+{
+	__u32 key = 0;
+
+	return bpf_map_lookup_elem(&park_map, &key);
+}
+
+/* Reset the condition, then publish the task: a wake between the two sets it again. */
+static int publish_waiter(void)
+{
+	struct park_elem *elem = lookup_elem();
+	struct task_struct *task;
+
+	if (!elem)
+		return -ENOENT;
+	WRITE_ONCE(elem->state, WAITING);
+	task = bpf_task_acquire(bpf_get_current_task_btf());
+	if (!task)
+		return -ESRCH;
+	task = bpf_kptr_xchg(&elem->task, task);
+	if (task)
+		bpf_task_release(task);
+	return 0;
+}
+
+static void withdraw_waiter(void)
+{
+	struct park_elem *elem = lookup_elem();
+	struct task_struct *task;
+
+	if (!elem)
+		return;
+	task = bpf_kptr_xchg(&elem->task, NULL);
+	if (task)
+		bpf_task_release(task);
+}
+
+/*
+ * Sleep until wake_waiter() has set the condition. The element is a value of
+ * an array map, which the program holds, so its pointer survives the park and
+ * the loop keeps it; a value of a hash map would have to be looked up again
+ * on every turn. A park that returns 0 before the condition is set is a
+ * spurious wakeup that just goes round once more.
+ */
+SEC("syscall")
+int park_until_woken(void *ctx)
+{
+	struct park_elem *elem;
+	int i, ret;
+
+	ret = publish_waiter();
+	if (ret)
+		return ret;
+	elem = lookup_elem();
+	if (!elem)
+		return -ENOENT;
+	ret = -EAGAIN;
+	for (i = 0; i < 100; i++) {
+		if (READ_ONCE(elem->state) == WOKEN) {
+			ret = 0;
+			break;
+		}
+		ret = bpf_task_park(park_timeout_ns, 0);
+		if (ret)
+			break;
+		ret = -EAGAIN;
+	}
+	withdraw_waiter();
+	return ret;
+}
+
+/*
+ * Wake whoever published itself, without taking a reference. The condition is
+ * set only once a task is found: a waiter between its reset of the condition
+ * and its publication must not find it set, or it would return without any
+ * wake having reached it. Setting the condition before the wake is the order
+ * the kfunc's release store pairs with, so a park that consumes this wake
+ * sees the condition on its next look.
+ */
+SEC("syscall")
+int wake_waiter(void *ctx)
+{
+	struct park_elem *elem = lookup_elem();
+	struct task_struct *task;
+	int ret = -ESRCH;
+
+	if (!elem)
+		return -ENOENT;
+	bpf_rcu_read_lock();
+	task = elem->task;
+	if (task) {
+		WRITE_ONCE(elem->state, WOKEN);
+		ret = bpf_task_wake(task, 0);
+	}
+	bpf_rcu_read_unlock();
+	return ret;
+}
+
+/* Nothing wakes this task: the park sleeps 1 ms and times out. */
+SEC("syscall")
+int park_timeout(void *ctx)
+{
+	return bpf_task_park(1000000, 0);
+}
+
+/*
+ * A wake that finds its task running is kept for the next park, which returns
+ * at once even as a poll. That park consumes it, so a second poll finds
+ * nothing and reports the timeout.
+ */
+SEC("syscall")
+int park_pending(void *ctx)
+{
+	if (bpf_task_wake(bpf_get_current_task_btf(), 0))
+		return -EBUSY;
+	if (bpf_task_park(0, 0))
+		return -EAGAIN;
+	return bpf_task_park(0, 0);
+}
+
+SEC("syscall")
+int bad_flags(void *ctx)
+{
+	if (bpf_task_park(0, 1) != -EINVAL)
+		return 1;
+	if (bpf_task_wake(bpf_get_current_task_btf(), 1) != -EINVAL)
+		return 2;
+	return 0;
+}
-- 
2.53.0

