Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 356F5348C63
	for <bpf@vger.kernel.org>; Sat, 10 Oct 2026 04:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791606171; cv=none; b=mcQv4yMMITuhf3iGp2Ewllw+jRA46B5DgkhNXCgY2ogoJr1gXrC7GSeQMKjTxmlorCBQDdHZNCHhiayOu5F3Sn2wHIVpwdVtoJB8iDS7aWtislWr1WRoPoeUSVTp81MSqtev1Yzng1XhkPrikJU4dmwym6kor8db36ykemUpCt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791606171; c=relaxed/simple;
	bh=Ux+73aiT1+XWIFfd4q6YQNZbiuyNI7KN9ZHZYZvvO7E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aQ1QhK4jg4PzxksLK55n0Xqp6Bi7t9dzDO0377LpPRQiIYcCiaOHIfaHc32D6QO4F4AE4IL2Z6XXVCWx9zXU0eUvyj6rMT8xhbP5BGv5pZpHEyyDxfB3rPikru9XeS3kIcuabVxhwNBHveA1/07fOpuhe5Im/ymmqloKVaL0IRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=dL89iYZp; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="dL89iYZp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=D/
	pRMXqzDpBNEB8F11TFsAYVuvhv2zpllyQQv5jUxmM=; b=dL89iYZpVW5GHxOEEi
	bNfMVv9z53F8b9xHvo21bqkBJgfiWLCxmVwMkZ8+TLgO7SvEoyF4me7/3J8fyRto
	OwSLJaCfk2zekgVjXxPuYhgAgR6uv8DAuafLV0gTtOZe9fXQhuPrpn7wOr1y0XC2
	Ldd7iabKq23pkSputF+kqEC8o=
Received: from kylin-ERAZER-H610M.. (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wD3v+Bhvclqy5XMDg--.2624S6;
	Sat, 10 Oct 2026 12:22:00 +0800 (CST)
From: Yun Lu <luyun_611@163.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	ihor.solodrai@linux.dev
Cc: yatsenko@meta.com,
	bpf@vger.kernel.org
Subject: [PATCH bpf-next v6 4/4] selftests/bpf: Add task work BUSY window test
Date: Sat, 10 Oct 2026 12:21:32 +0800
Message-ID: <20261010042132.137430-5-luyun_611@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261010042132.137430-1-luyun_611@163.com>
References: <20261010042132.137430-1-luyun_611@163.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3v+Bhvclqy5XMDg--.2624S6
X-Coremail-Antispam: 1Uf129KBjvAXoWfCw1xWFykZw4UZr13uFWDtwb_yoW5Zry3to
	WfZw15XF1vqrnxWw1xX3WkAryagayqg3Z3Zr4Y93y5uF93X34jvFn8Cw13Xa4fKF4Fq34x
	ZFy0qFWS9r4ktryrn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUobyZUUUUU
X-CM-SenderInfo: pox130jbwriqqrwthudrp/xtbCxAmWZWrJvWmYcgAA3j

From: Yun Lu <luyun@kylinos.cn>

Add a regression test for reusing a bpf_task_work context while its
scheduling irq_work is still BUSY.  A test that schedules from a thread
pinned to one CPU never observes that window: irq_work_queue() self-IPIs
the local CPU and the invocation completes before the thread's next
syscall.

Use an fexit program on task_work_add() to delay the scheduling
handler's return with a time- and iteration-bounded busy-wait, after
the first-round callback was published and before the handler's tail
state transition.  The target task attempts to reuse the same context
from a later syscall, strictly after its own callback wrapper returned,
so the context is STANDBY at that point.  A valid window requires the
fexit program to observe the attempt's acknowledgment before returning,
which proves the attempt ran while the old handler, and thus the BUSY
irq_work, was still in flight.  With the map and program references
held and no competing scheduler, the only possible source of -EBUSY for
that attempt is the BUSY check in the acquire path.  Check that the
attempt is rejected with -EBUSY, that scheduling succeeds on a bounded
retry once BUSY clears, and that the second callback runs exactly once.

Each attempt uses dedicated workers and a fresh map value.  Reset the
shared slots before enabling the workers.  Stop and join them at the
end of the attempt, then wait for their TIDs to disappear from PID
lookup before checking the final callback count or starting another
attempt.  join alone can return before exit_task_work(); a signal-zero
tgkill probe still finds the worker until after its exit task_work has
run.  Bound that wait and fail on unexpected probe errors.  Callback
deliveries are also matched against the window's generation.

Missed windows are counted and retried within a bounded attempt budget;
hard failures fail the test.  Record the busy-wait elapsed time and loop
count as diagnostics, without asserting a wall-clock bound, since host
vCPU preemption can stretch wall-clock time without affecting the gate
behavior under test.

Skip when fewer than two CPUs are available or on PREEMPT_RT, detected
through the realtime sysfs flag when present or through the kernel
running the irq_work in its per-CPU irq_work/N thread.  Load and attach
errors fail the test instead of being inferred from tracefs file paths
and reported as unsupported.

Signed-off-by: Yun Lu <luyun@kylinos.cn>
---
 .../selftests/bpf/prog_tests/test_task_work.c | 562 ++++++++++++++++++
 .../selftests/bpf/progs/task_work_busy.c      | 380 ++++++++++++
 2 files changed, 942 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/task_work_busy.c

diff --git a/tools/testing/selftests/bpf/prog_tests/test_task_work.c b/tools/testing/selftests/bpf/prog_tests/test_task_work.c
index 6b45210e0578..47ed0ae3eace 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_task_work.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_task_work.c
@@ -3,9 +3,11 @@
 #include <test_progs.h>
 #include <string.h>
 #include <stdio.h>
+#include <fcntl.h>
 #include "task_work.skel.h"
 #include "task_work_fail.skel.h"
 #include "task_work_race.skel.h"
+#include "task_work_busy.skel.h"
 #include <linux/bpf.h>
 #include <linux/perf_event.h>
 #include <sys/syscall.h>
@@ -436,3 +438,563 @@ void serial_test_task_work_race(void)
 cleanup:
 	task_work_race__destroy(skel);
 }
+
+#define TASK_WORK_BUSY_ROUNDS		32
+#define TASK_WORK_BUSY_MAX_ATTEMPTS	96
+#define TASK_WORK_BUSY_POLL_US		100
+#define TASK_WORK_BUSY_POLL_ITERS	20000
+#define TASK_WORK_BUSY_START_POLL_ITERS	50000
+#define TASK_WORK_BUSY_GAP_US		10000
+/* Must match BUSY_WAIT_ITERS in progs/task_work_busy.c. */
+#define TASK_WORK_BUSY_WAIT_ITERS	1000000LL
+
+/* Must match progs/task_work_busy.c. */
+enum task_work_busy_status {
+	BUSY_ARM_SEQ,
+	/*
+	 * High 32 bits hold the sequence.  BUSY_WINDOW low bits: 1 open,
+	 * 2 the in-window attempt was seen before the handler returned,
+	 * 3 the wait bound was reached without it.  Result slots: signed
+	 * error in the low 32 bits.
+	 */
+	BUSY_WINDOW,
+	BUSY_ACK,
+	BUSY_GEN1_RESULT,
+	BUSY_GEN2_RESULT,
+	BUSY_CB1_SEQ,
+	BUSY_CB2_COUNT,
+	BUSY_CB2_SEQ,
+	BUSY_RECOVER_SEQ,
+	BUSY_LAST_WAIT_NS,
+	BUSY_LAST_WAIT_LOOPS,
+	BUSY_RT_DETECTED,
+	BUSY_STATUS_MAX,
+};
+
+/* Must match progs/task_work_busy.c. */
+enum task_work_busy_stat {
+	BUSY_STAT_TOTAL,
+	BUSY_STAT_FILTERED,
+	BUSY_STAT_WINDOW,
+	BUSY_STAT_ACK_SEEN,
+	BUSY_STAT_TIMEOUT,
+	BUSY_STAT_G1_RETRY,
+	BUSY_STAT_G2_RETRY,
+	BUSY_STAT_MAX,
+};
+
+struct task_work_busy_value {
+	__u32 seq;
+	char data[60];
+	struct bpf_task_work tw;
+};
+
+enum task_work_busy_attempt {
+	TWB_VALID,
+	TWB_MISSED,
+	TWB_RT,
+	TWB_HARD_FAIL,
+};
+
+static const char *twb_attempt_name(enum task_work_busy_attempt r)
+{
+	switch (r) {
+	case TWB_VALID:
+		return "valid";
+	case TWB_MISSED:
+		return "missed";
+	case TWB_RT:
+		return "rt";
+	default:
+		return "fail";
+	}
+}
+
+/*
+ * Positive confirmation of PREEMPT_RT only: not every RT kernel provides
+ * this file, and its absence proves nothing.  The definitive check for
+ * such kernels is the irq_work thread observation inside the BPF program.
+ */
+static bool task_work_busy_rt_confirmed(void)
+{
+	char buf[2] = {};
+	int fd, n;
+
+	fd = open("/sys/kernel/realtime", O_RDONLY | O_CLOEXEC);
+	if (fd < 0)
+		return false;
+	n = read(fd, buf, sizeof(buf) - 1);
+	close(fd);
+	return n > 0 && buf[0] == '1';
+}
+
+static int task_work_busy_status(struct task_work_busy *skel, int idx,
+				 __s64 *value)
+{
+	return bpf_map_lookup_elem(bpf_map__fd(skel->maps.status), &idx,
+				   value);
+}
+
+static int task_work_busy_set_status(struct task_work_busy *skel, int idx,
+				     __s64 value)
+{
+	return bpf_map_update_elem(bpf_map__fd(skel->maps.status), &idx,
+				   &value, BPF_ANY);
+}
+
+static int task_work_busy_stat(struct task_work_busy *skel, int idx,
+			       __u64 *value)
+{
+	return bpf_map_lookup_elem(bpf_map__fd(skel->maps.stats), &idx,
+				   value);
+}
+
+/*
+ * Wait until the high 32 bits of slot idx hold seq; return the signed
+ * low 32 bits through err.
+ */
+static int task_work_busy_wait_seq(struct task_work_busy *skel, int idx,
+				   __u32 seq, __s32 *err)
+{
+	int i;
+
+	for (i = 0; i < TASK_WORK_BUSY_POLL_ITERS; i++) {
+		__s64 value = 0;
+
+		if (!task_work_busy_status(skel, idx, &value) &&
+		    (__u32)((__u64)value >> 32) == seq) {
+			*err = (__s32)value;
+			return 0;
+		}
+		usleep(TASK_WORK_BUSY_POLL_US);
+	}
+	return -ETIMEDOUT;
+}
+
+static int task_work_busy_wait_value(struct task_work_busy *skel, int idx,
+				     __s64 want)
+{
+	int i;
+
+	for (i = 0; i < TASK_WORK_BUSY_POLL_ITERS; i++) {
+		__s64 value = 0;
+
+		if (!task_work_busy_status(skel, idx, &value) && value == want)
+			return 0;
+		usleep(TASK_WORK_BUSY_POLL_US);
+	}
+	return -ETIMEDOUT;
+}
+
+/* Wait until the window slot reports a final state (2 or 3) for seq. */
+static int task_work_busy_wait_window(struct task_work_busy *skel, __u32 seq,
+				      __s64 *window)
+{
+	int i;
+
+	for (i = 0; i < TASK_WORK_BUSY_POLL_ITERS; i++) {
+		__s64 value = 0;
+
+		if (!task_work_busy_status(skel, BUSY_WINDOW, &value) &&
+		    (__u32)((__u64)value >> 32) == seq &&
+		    (__u32)value >= 2) {
+			*window = value;
+			return 0;
+		}
+		usleep(TASK_WORK_BUSY_POLL_US);
+	}
+	return -ETIMEDOUT;
+}
+
+/*
+ * The fexit program publishes the wait diagnostics before the final
+ * window state; the slots were zeroed before arming and are written only
+ * once per attempt.  Wait for both fields instead of assuming propagation
+ * order between independent slots.
+ */
+static int task_work_busy_wait_diag(struct task_work_busy *skel,
+				    __s64 *wait_ns, __s64 *loops)
+{
+	int i;
+
+	for (i = 0; i < TASK_WORK_BUSY_POLL_ITERS; i++) {
+		__s64 ns = 0, lp = 0;
+
+		if (task_work_busy_status(skel, BUSY_LAST_WAIT_NS, &ns) ||
+		    task_work_busy_status(skel, BUSY_LAST_WAIT_LOOPS, &lp))
+			return -errno;
+		if (ns > 0 && lp >= 1 && lp <= TASK_WORK_BUSY_WAIT_ITERS) {
+			*wait_ns = ns;
+			*loops = lp;
+			return 0;
+		}
+		usleep(TASK_WORK_BUSY_POLL_US);
+	}
+	return -ETIMEDOUT;
+}
+
+static int task_work_busy_prepare_elem(struct task_work_busy *skel, int key)
+{
+	struct task_work_busy_value value = {};
+
+	if (!bpf_map_update_elem(bpf_map__fd(skel->maps.hmap), &key, &value,
+				 BPF_NOEXIST))
+		return 0;
+	return -errno;
+}
+
+static int task_work_busy_reset(struct task_work_busy *skel)
+{
+	static const int zeroed[] = {
+		BUSY_WINDOW, BUSY_ACK, BUSY_GEN1_RESULT, BUSY_GEN2_RESULT,
+		BUSY_CB1_SEQ, BUSY_CB2_COUNT, BUSY_CB2_SEQ, BUSY_RECOVER_SEQ,
+		BUSY_LAST_WAIT_NS, BUSY_LAST_WAIT_LOOPS,
+	};
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(zeroed); i++)
+		if (task_work_busy_set_status(skel, zeroed[i], 0))
+			return -errno;
+	return 0;
+}
+
+/*
+ * join waits for clear_child_tid, which is cleared before exit_task_work().
+ * PID lookup stops finding the worker only after its exit task_work has run.
+ * Probe with signal 0; no signal is delivered.  Do not create new workers
+ * until both old TIDs have disappeared.
+ */
+static int task_work_busy_wait_exit(int tid)
+{
+	int i;
+
+	for (i = 0; i < TASK_WORK_BUSY_POLL_ITERS; i++) {
+		if (syscall(__NR_tgkill, getpid(), tid, 0)) {
+			if (errno == ESRCH)
+				return 0;
+			return -errno;
+		}
+		usleep(TASK_WORK_BUSY_POLL_US);
+	}
+	return -ETIMEDOUT;
+}
+
+/*
+ * Run one attempt on dedicated workers and report its outcome.  The
+ * workers are stopped, joined and waited out of PID lookup before another
+ * attempt can reset the shared state.  join alone does not wait for their
+ * exit task_work to finish.
+ */
+static enum task_work_busy_attempt
+task_work_busy_run_attempt(struct task_work_busy *skel, int seq,
+			   int trigger_cpu, int target_cpu, __s64 *out_wait_ns)
+{
+	struct task_work_race_ctx ctx = {};
+	struct task_work_race_thread_arg trigger_arg = {
+		.ctx = &ctx,
+		.cpu = trigger_cpu,
+		.tid = &ctx.trigger_tid,
+	};
+	struct task_work_race_thread_arg target_arg = {
+		.ctx = &ctx,
+		.cpu = target_cpu,
+		.tid = &ctx.target_tid,
+	};
+	enum task_work_busy_attempt result = TWB_HARD_FAIL;
+	pthread_t trigger, target;
+	bool trigger_started = false, target_started = false;
+	__s64 window = 0, wait_ns = 0, loops = 0, count = -1, rt = 0;
+	__s32 res = 0;
+	int err, i;
+
+	*out_wait_ns = 0;
+	/* Do not let a reused TID match the previous attempt's filter. */
+	skel->bss->trigger_tid = 0;
+	skel->bss->target_tid = 0;
+
+	/* Clear old state before enabling workers that can read it. */
+	if (!ASSERT_OK(task_work_busy_prepare_elem(skel, seq), "prepare elem"))
+		goto out;
+	if (!ASSERT_OK(task_work_busy_reset(skel), "reset slots"))
+		goto out;
+
+	err = pthread_create(&target, NULL, task_work_race_worker, &target_arg);
+	if (err) {
+		ASSERT_OK(err, "pthread_create target");
+		goto out;
+	}
+	target_started = true;
+	err = pthread_create(&trigger, NULL, task_work_race_worker, &trigger_arg);
+	if (err) {
+		ASSERT_OK(err, "pthread_create trigger");
+		goto out;
+	}
+	trigger_started = true;
+
+	for (i = 0; i < TASK_WORK_BUSY_START_POLL_ITERS; i++) {
+		if (__atomic_load_n(&ctx.trigger_tid, __ATOMIC_ACQUIRE) &&
+		    __atomic_load_n(&ctx.target_tid, __ATOMIC_ACQUIRE))
+			break;
+		usleep(TASK_WORK_BUSY_POLL_US);
+	}
+	if (!ASSERT_TRUE(__atomic_load_n(&ctx.trigger_tid, __ATOMIC_ACQUIRE) &&
+			 __atomic_load_n(&ctx.target_tid, __ATOMIC_ACQUIRE),
+			 "thread start"))
+		goto out;
+	if (!ASSERT_OK(__atomic_load_n(&ctx.setup_err, __ATOMIC_ACQUIRE),
+		       "thread affinity"))
+		goto out;
+
+	skel->bss->trigger_tid = __atomic_load_n(&ctx.trigger_tid, __ATOMIC_ACQUIRE);
+	skel->bss->target_tid = __atomic_load_n(&ctx.target_tid, __ATOMIC_ACQUIRE);
+
+	/* Arm last, once this attempt's value, slots and TIDs are in place. */
+	if (!ASSERT_OK(task_work_busy_set_status(skel, BUSY_ARM_SEQ, seq),
+		       "arm"))
+		goto out;
+
+	/*
+	 * First-round scheduling; transient -EBUSY is retried inside the
+	 * BPF program without publishing a result.
+	 */
+	err = task_work_busy_wait_seq(skel, BUSY_GEN1_RESULT, seq, &res);
+	if (!ASSERT_OK(err, "gen1 result"))
+		goto out;
+	if (!ASSERT_OK(res, "gen1 schedule")) {
+		fprintf(stderr, "attempt %d: gen1 failed: %d\n", seq, res);
+		goto out;
+	}
+
+	err = task_work_busy_wait_window(skel, seq, &window);
+	if (err) {
+		/*
+		 * The window never reached a final state.  On PREEMPT_RT
+		 * the scheduling handler runs in the irq_work thread, the
+		 * fexit filter records that, and no window can open: a
+		 * definitive skip instead of a failure.
+		 */
+		if (!task_work_busy_status(skel, BUSY_RT_DETECTED, &rt) && rt) {
+			result = TWB_RT;
+			goto out;
+		}
+		ASSERT_OK(err, "window close");
+		goto out;
+	}
+	if (!ASSERT_OK(task_work_busy_wait_diag(skel, &wait_ns, &loops),
+		       "wait diagnostics"))
+		goto out;
+
+	if ((__u32)window == 3) {
+		/*
+		 * The attempt did not arrive inside the wait bound.  The
+		 * elapsed time and loop count are diagnostics only; count
+		 * the miss and retry with a fresh attempt.
+		 */
+		result = TWB_MISSED;
+		goto out;
+	}
+
+	/*
+	 * Valid window: the handler saw this sequence's attempt before
+	 * returning, so the attempt ran while the scheduling irq_work was
+	 * still BUSY.  The elapsed time is a diagnostic only: host vCPU
+	 * preemption can stretch wall-clock time without affecting the
+	 * gate behavior under test.
+	 */
+	if (!ASSERT_OK(task_work_busy_wait_value(skel, BUSY_CB1_SEQ, seq),
+		       "gen1 callback"))
+		goto out;
+
+	err = task_work_busy_wait_seq(skel, BUSY_ACK, seq, &res);
+	if (!ASSERT_OK(err, "in-window attempt"))
+		goto out;
+	if (res != -EBUSY) {
+		fprintf(stderr,
+			"attempt %d: in-window reuse %s (%d), expected -EBUSY, wait_ns %lld\n",
+			seq, res == 0 ? "accepted" : "failed", res,
+			(long long)wait_ns);
+		ASSERT_EQ(res, -EBUSY, "in-window BUSY gate rejection");
+		goto out;
+	}
+
+	/*
+	 * The window was released; retry until BUSY clears.  The second
+	 * callback must then run exactly once.
+	 */
+	if (!ASSERT_OK(task_work_busy_set_status(skel, BUSY_RECOVER_SEQ, seq),
+		       "enable recovery"))
+		goto out;
+	err = task_work_busy_wait_seq(skel, BUSY_GEN2_RESULT, seq, &res);
+	if (!ASSERT_OK(err, "recovery result"))
+		goto out;
+	if (!ASSERT_OK(res, "recovery schedule")) {
+		fprintf(stderr, "attempt %d: recovery failed: %d\n", seq, res);
+		goto out;
+	}
+	if (!ASSERT_OK(task_work_busy_wait_value(skel, BUSY_CB2_SEQ, seq),
+		       "gen2 callback"))
+		goto out;
+	result = TWB_VALID;
+out:
+	__atomic_store_n(&ctx.stop, 1, __ATOMIC_RELEASE);
+	if (trigger_started &&
+	    (!ASSERT_OK(pthread_join(trigger, NULL), "trigger join") ||
+	     !ASSERT_OK(task_work_busy_wait_exit(ctx.trigger_tid), "trigger exit")))
+		result = TWB_HARD_FAIL;
+	if (target_started &&
+	    (!ASSERT_OK(pthread_join(target, NULL), "target join") ||
+	     !ASSERT_OK(task_work_busy_wait_exit(ctx.target_tid), "target exit")))
+		result = TWB_HARD_FAIL;
+	/* Both workers have passed exit_task_work; the count is now stable. */
+	if (result == TWB_VALID) {
+		if (!ASSERT_OK(task_work_busy_status(skel, BUSY_CB2_COUNT, &count),
+			       "cb2 count")) {
+			result = TWB_HARD_FAIL;
+		} else if (!ASSERT_EQ(count, 1, "gen2 callback exactly once")) {
+			fprintf(stderr, "attempt %d: gen2 callback count %lld\n",
+				seq, (long long)count);
+			result = TWB_HARD_FAIL;
+		}
+	}
+	*out_wait_ns = wait_ns;
+	fprintf(stderr, "attempt %d: %s (window %u wait_ns %lld loops %lld)\n",
+		seq, twb_attempt_name(result), (__u32)window,
+		(long long)wait_ns, (long long)loops);
+	return result;
+}
+
+void serial_test_task_work_busy(void)
+{
+	struct task_work_busy *skel;
+	struct bpf_link *link_tp = NULL, *link_fexit = NULL;
+	cpu_set_t allowed;
+	int cpu, cpu_count = 0, trigger_cpu = -1, target_cpu = -1;
+	int attempt, attempts_started = 0, valid = 0, missed = 0;
+	bool hard_fail = false;
+	__s64 max_wait_ns = 0;
+	__u64 stat_window = 0, stat_total = 0, stat_filtered = 0;
+	__u64 stat_g1r = 0, stat_g2r = 0;
+
+	if (task_work_busy_rt_confirmed()) {
+		printf("%s:SKIP:PREEMPT_RT runs irq_work in a kernel thread\n",
+		       __func__);
+		test__skip();
+		return;
+	}
+	if (sched_getaffinity(0, sizeof(allowed), &allowed)) {
+		ASSERT_OK(-errno, "sched_getaffinity");
+		return;
+	}
+	for (cpu = 0; cpu < CPU_SETSIZE && cpu_count < 2; cpu++) {
+		if (!CPU_ISSET(cpu, &allowed))
+			continue;
+		if (!cpu_count)
+			trigger_cpu = cpu;
+		else
+			target_cpu = cpu;
+		cpu_count++;
+	}
+	if (cpu_count < 2) {
+		printf("%s:SKIP:need two CPUs in the process affinity mask\n",
+		       __func__);
+		test__skip();
+		return;
+	}
+
+	skel = task_work_busy__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "open_and_load"))
+		return;
+
+	link_tp = bpf_program__attach_tracepoint(skel->progs.busy_sched_work,
+						 "syscalls",
+						 "sys_enter_getppid");
+	if (!ASSERT_OK_PTR(link_tp, "attach tracepoint"))
+		goto cleanup;
+
+	link_fexit = bpf_program__attach_trace(skel->progs.busy_fexit_task_work_add);
+	if (!ASSERT_OK_PTR(link_fexit, "attach fexit"))
+		goto cleanup;
+
+	for (attempt = 1;
+	     attempt <= TASK_WORK_BUSY_MAX_ATTEMPTS &&
+	     valid < TASK_WORK_BUSY_ROUNDS;
+	     attempt++) {
+		enum task_work_busy_attempt res;
+		__s64 wait_ns = 0;
+
+		attempts_started = attempt;
+		res = task_work_busy_run_attempt(skel, attempt, trigger_cpu,
+						 target_cpu, &wait_ns);
+		switch (res) {
+		case TWB_VALID:
+			valid++;
+			if (wait_ns > max_wait_ns)
+				max_wait_ns = wait_ns;
+			break;
+		case TWB_MISSED:
+			missed++;
+			break;
+		case TWB_RT:
+			printf("%s:SKIP:PREEMPT_RT detected (irq_work thread ran the handler)\n",
+			       __func__);
+			test__skip();
+			goto cleanup;
+		case TWB_HARD_FAIL:
+			hard_fail = true;
+			break;
+		}
+		if (hard_fail)
+			break;
+		/* Pacing only; worker disappearance provides the lifecycle boundary. */
+		usleep(TASK_WORK_BUSY_GAP_US);
+	}
+
+	if (!ASSERT_OK(task_work_busy_stat(skel, BUSY_STAT_WINDOW, &stat_window),
+		       "window stat") ||
+	    !ASSERT_OK(task_work_busy_stat(skel, BUSY_STAT_TOTAL, &stat_total),
+		       "total stat") ||
+	    !ASSERT_OK(task_work_busy_stat(skel, BUSY_STAT_FILTERED, &stat_filtered),
+		       "filtered stat") ||
+	    !ASSERT_OK(task_work_busy_stat(skel, BUSY_STAT_G1_RETRY, &stat_g1r),
+		       "gen1 retry stat") ||
+	    !ASSERT_OK(task_work_busy_stat(skel, BUSY_STAT_G2_RETRY, &stat_g2r),
+		       "gen2 retry stat"))
+		goto cleanup;
+	fprintf(stderr,
+		"task_work_busy: %d/%d valid, %d missed, %d attempts, max_wait %lld ns, windows %llu, adds %llu, filtered %llu, g1_retries %llu, g2_retries %llu\n",
+		valid, TASK_WORK_BUSY_ROUNDS, missed, attempts_started,
+		(long long)max_wait_ns, (unsigned long long)stat_window,
+		(unsigned long long)stat_total,
+		(unsigned long long)stat_filtered,
+		(unsigned long long)stat_g1r, (unsigned long long)stat_g2r);
+
+	/*
+	 * Consistency and coverage assertions only make sense when no hard
+	 * failure aborted the loop; after a hard failure keep the primary
+	 * reason instead of deriving more assertion noise from it.
+	 */
+	if (!hard_fail) {
+		if (!ASSERT_EQ(stat_window, (__u64)(valid + missed),
+			       "window accounting"))
+			fprintf(stderr,
+				"windows entered %llu, valid %d, missed %d\n",
+				(unsigned long long)stat_window, valid, missed);
+		if (!ASSERT_GE(stat_total, (__u64)(2 * valid),
+			       "task_work_add calls seen"))
+			fprintf(stderr,
+				"only %llu task_work_add calls for %d valid rounds\n",
+				(unsigned long long)stat_total, valid);
+		if (valid != TASK_WORK_BUSY_ROUNDS)
+			fprintf(stderr,
+				"busy coverage: %d/%d valid, %d missed in %d attempts\n",
+				valid, TASK_WORK_BUSY_ROUNDS, missed,
+				attempts_started);
+		if (!ASSERT_EQ(valid, TASK_WORK_BUSY_ROUNDS,
+			       "valid busy windows"))
+			goto cleanup;
+	}
+cleanup:
+	bpf_link__destroy(link_tp);
+	bpf_link__destroy(link_fexit);
+	task_work_busy__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/task_work_busy.c b/tools/testing/selftests/bpf/progs/task_work_busy.c
new file mode 100644
index 000000000000..13b807d146fb
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/task_work_busy.c
@@ -0,0 +1,380 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 KylinSoft Corporation. */
+#include <vmlinux.h>
+#include <stdbool.h>
+#include <errno.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include <bpf/bpf_core_read.h>
+
+char _license[] SEC("license") = "GPL";
+
+/*
+ * Bounds for the hardirq busy-wait that holds the scheduling handler
+ * inside the real window: task_work_add() has published the callback,
+ * but the handler's tail state transition has not run yet.
+ * irq_work_single() clears BUSY only after the handler returns, so
+ * while this wait runs, the context's scheduling irq_work is BUSY,
+ * even though the first callback may already have completed and
+ * returned the context to STANDBY.
+ *
+ * The wait is bounded both by a bpf_ktime_get_ns() check and by an
+ * iteration budget.  The time bound is checked against a monotonic
+ * clock: host vCPU preemption can stretch the wall-clock duration of
+ * the window, which only makes the window longer, never shorter.
+ * BUSY_WAIT_ITERS must match TASK_WORK_BUSY_WAIT_ITERS.
+ */
+#define BUSY_WAIT_NS		4000000ULL
+#define BUSY_WAIT_ITERS		1000000ULL
+
+int trigger_tid;
+int target_tid;
+
+/*
+ * High 32 bits of the result slots hold the sequence, low 32 bits the
+ * signed error.  BUSY_WINDOW low bits: 1 open, 2 the in-window attempt
+ * was seen before the handler returned, 3 the wait bound was reached
+ * without it.  Must match the test.
+ */
+enum task_work_busy_status {
+	BUSY_ARM_SEQ,
+	BUSY_WINDOW,
+	BUSY_ACK,
+	BUSY_GEN1_RESULT,
+	BUSY_GEN2_RESULT,
+	BUSY_CB1_SEQ,
+	BUSY_CB2_COUNT,
+	BUSY_CB2_SEQ,
+	BUSY_RECOVER_SEQ,
+	BUSY_LAST_WAIT_NS,
+	BUSY_LAST_WAIT_LOOPS,
+	BUSY_RT_DETECTED,
+	BUSY_STATUS_MAX,
+};
+
+enum task_work_busy_stat {
+	BUSY_STAT_TOTAL,	/* every task_work_add fexit hit */
+	BUSY_STAT_FILTERED,	/* armed, rejected by the source filter */
+	BUSY_STAT_WINDOW,	/* windows entered */
+	BUSY_STAT_ACK_SEEN,	/* windows closed with the attempt seen */
+	BUSY_STAT_TIMEOUT,	/* windows that reached the wait bound */
+	BUSY_STAT_G1_RETRY,	/* transient gen-1 -EBUSY retries */
+	BUSY_STAT_G2_RETRY,	/* transient recovery -EBUSY retries */
+	BUSY_STAT_MAX,
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, BUSY_STATUS_MAX);
+	__type(key, int);
+	__type(value, __s64);
+} status SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, BUSY_STAT_MAX);
+	__type(key, int);
+	__type(value, __u64);
+} stats SEC(".maps");
+
+struct task_work_busy_value {
+	__u32 seq;
+	char data[60];
+	struct bpf_task_work tw;
+};
+
+/*
+ * max_entries must cover TASK_WORK_BUSY_MAX_ATTEMPTS in the test: each
+ * attempt schedules into its own fresh value.
+ */
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__uint(map_flags, BPF_F_NO_PREALLOC);
+	__uint(max_entries, 128);
+	__type(key, int);
+	__type(value, struct task_work_busy_value);
+} hmap SEC(".maps");
+
+static __always_inline void set_status(int key, __s64 value)
+{
+	__s64 *slot;
+
+	slot = bpf_map_lookup_elem(&status, &key);
+	if (slot)
+		*slot = value;
+}
+
+static __always_inline __s64 get_status(int key)
+{
+	__s64 *slot = bpf_map_lookup_elem(&status, &key);
+
+	return slot ? *slot : 0;
+}
+
+static __always_inline void bump_stat(int key)
+{
+	__u64 *slot = bpf_map_lookup_elem(&stats, &key);
+
+	if (slot)
+		__sync_fetch_and_add(slot, 1);
+}
+
+struct busy_wait_ctx {
+	__u64 seq;
+	__u64 start;
+	bool acked;
+};
+
+/* bpf_loop() callback: return 0 continues the loop, return 1 stops it. */
+static long busy_wait_cb(__u32 i, void *pctx)
+{
+	struct busy_wait_ctx *w = pctx;
+
+	if (((__u64)get_status(BUSY_ACK) >> 32) == w->seq) {
+		w->acked = true;
+		return 1;
+	}
+	if (bpf_ktime_get_ns() - w->start > BUSY_WAIT_NS)
+		return 1;
+	return 0;
+}
+
+static int busy_cb_gen1(struct bpf_map *map, void *key, void *value)
+{
+	struct task_work_busy_value *work = value;
+	__u64 we = (__u64)get_status(BUSY_WINDOW) >> 32;
+
+	/*
+	 * Backstop for deliveries from abandoned attempts: accept only
+	 * while no window for a different sequence is published.  The
+	 * test waits for the old workers to disappear from PID lookup,
+	 * after their exit task_work, before resetting the shared state.
+	 * This callback may run before fexit publishes the window state.
+	 */
+	if (we && we != (__u64)work->seq)
+		return 0;
+	set_status(BUSY_CB1_SEQ, work->seq);
+	return 0;
+}
+
+static int busy_cb_gen2(struct bpf_map *map, void *key, void *value)
+{
+	struct task_work_busy_value *work = value;
+	__s64 *count;
+	int key2 = BUSY_CB2_COUNT;
+
+	/*
+	 * Count only deliveries belonging to the sequence whose window is
+	 * (or was) published: a late delivery from an abandoned attempt
+	 * must not satisfy a later exactly-once check.
+	 */
+	if ((__u64)work->seq != ((__u64)get_status(BUSY_WINDOW) >> 32))
+		return 0;
+	set_status(BUSY_CB2_SEQ, work->seq);
+	count = bpf_map_lookup_elem(&status, &key2);
+	if (count)
+		__sync_fetch_and_add(count, 1);
+	return 0;
+}
+
+SEC("fexit/task_work_add")
+int BPF_PROG(busy_fexit_task_work_add, struct task_struct *task,
+	     struct callback_head *work, int notify, int retval)
+{
+	struct busy_wait_ctx w = {};
+	__u64 seq, elapsed, loops;
+
+	bump_stat(BUSY_STAT_TOTAL);
+	seq = (__u64)get_status(BUSY_ARM_SEQ);
+	if (!seq)
+		return 0;
+
+	/*
+	 * One-shot arm.  Only this test's own first-round add may consume
+	 * it and hold the window: a successful TWA_SIGNAL add of the
+	 * bpf_task_work callback, issued from the trigger thread's CPU by
+	 * the self-IPI'd scheduling handler and targeting the target
+	 * thread.  Everything else leaves the arm untouched.
+	 */
+	if (retval != 0 || notify != TWA_SIGNAL ||
+	    BPF_CORE_READ(task, pid) != target_tid) {
+		bump_stat(BUSY_STAT_FILTERED);
+		return 0;
+	}
+	if ((__u32)bpf_get_current_pid_tgid() != (__u32)trigger_tid) {
+		/*
+		 * The armed first-round add reached us from another
+		 * context.  On PREEMPT_RT, irq_work that is not marked
+		 * HARD runs in the per-CPU "irq_work/N" thread; record
+		 * that as a definitive RT observation so the test can
+		 * skip instead of waiting for a window that cannot open.
+		 */
+		char comm[16] = {};
+
+		bpf_get_current_comm(comm, sizeof(comm));
+		if (comm[0] == 'i' && comm[1] == 'r' && comm[2] == 'q' &&
+		    comm[3] == '_' && comm[4] == 'w' && comm[5] == 'o' &&
+		    comm[6] == 'r' && comm[7] == 'k' && comm[8] == '/' &&
+		    comm[9] >= '0' && comm[9] <= '9')
+			set_status(BUSY_RT_DETECTED, 1);
+		bump_stat(BUSY_STAT_FILTERED);
+		return 0;
+	}
+
+	set_status(BUSY_ARM_SEQ, 0);
+	set_status(BUSY_WINDOW, (seq << 32) | 1);
+	bump_stat(BUSY_STAT_WINDOW);
+
+	w.seq = seq;
+	w.start = bpf_ktime_get_ns();
+	loops = (__u64)bpf_loop(BUSY_WAIT_ITERS, busy_wait_cb, &w, 0);
+	elapsed = bpf_ktime_get_ns() - w.start;
+
+	/*
+	 * Publish both diagnostics once per attempt.  The test waits for
+	 * both slots to become nonzero, without using either to infer
+	 * propagation order or to assert a wall-clock bound.
+	 */
+	set_status(BUSY_LAST_WAIT_LOOPS, (__s64)loops);
+	set_status(BUSY_LAST_WAIT_NS, (__s64)elapsed);
+	if (w.acked) {
+		set_status(BUSY_WINDOW, (seq << 32) | 2);
+		bump_stat(BUSY_STAT_ACK_SEEN);
+	} else {
+		set_status(BUSY_WINDOW, (seq << 32) | 3);
+		bump_stat(BUSY_STAT_TIMEOUT);
+	}
+	return 0;
+}
+
+/*
+ * Attempt the second scheduling round on the same context, targeting the
+ * trigger thread.  The attempt uses the value keyed by its own sequence,
+ * so it can never touch another attempt's context.  Returns true if a
+ * terminal result was published into res_key; a transient -EBUSY is left
+ * unpublished for the caller's retry policy, mirroring the race test's
+ * convention.
+ */
+static __always_inline bool busy_try_gen2(__u64 seq, int res_key)
+{
+	struct task_work_busy_value *work;
+	struct task_struct *task;
+	int key = (int)seq, err;
+
+	task = bpf_task_from_pid(trigger_tid);
+	if (!task) {
+		set_status(res_key, ((__s64)seq << 32) | (__u32)-ESRCH);
+		return true;
+	}
+	work = bpf_map_lookup_elem(&hmap, &key);
+	if (!work) {
+		bpf_task_release(task);
+		set_status(res_key, ((__s64)seq << 32) | (__u32)-ENOENT);
+		return true;
+	}
+	work->seq = seq;
+	err = bpf_task_work_schedule_signal(task, &work->tw, &hmap,
+					    busy_cb_gen2);
+	bpf_task_release(task);
+	if (err == -EBUSY)
+		return false;
+	set_status(res_key, ((__s64)seq << 32) | (__u32)err);
+	return true;
+}
+
+SEC("tracepoint/syscalls/sys_enter_getppid")
+int busy_sched_work(void *ctx)
+{
+	__u32 tid = (__u32)bpf_get_current_pid_tgid();
+	struct task_work_busy_value *work;
+	struct task_struct *task;
+	__u64 window, seq;
+	int key, err;
+
+	if (tid == (__u32)trigger_tid) {
+		/*
+		 * Trigger thread: schedule the first round once per armed
+		 * sequence, targeting the target thread.  The kfunc queues
+		 * the scheduling irq_work and returns; the handler then
+		 * parks inside the fexit window above.  Transient -EBUSY
+		 * is retried on the next syscall without publishing, so
+		 * only terminal results reach userspace.
+		 */
+		seq = (__u64)get_status(BUSY_ARM_SEQ);
+		if (!seq ||
+		    ((__u64)get_status(BUSY_GEN1_RESULT) >> 32) == seq)
+			return 0;
+		key = (int)seq;
+		task = bpf_task_from_pid(target_tid);
+		if (!task) {
+			set_status(BUSY_GEN1_RESULT,
+				   ((__s64)seq << 32) | (__u32)-ESRCH);
+			set_status(BUSY_ARM_SEQ, 0);
+			return 0;
+		}
+		work = bpf_map_lookup_elem(&hmap, &key);
+		if (!work) {
+			bpf_task_release(task);
+			set_status(BUSY_GEN1_RESULT,
+				   ((__s64)seq << 32) | (__u32)-ENOENT);
+			set_status(BUSY_ARM_SEQ, 0);
+			return 0;
+		}
+		work->seq = seq;
+		err = bpf_task_work_schedule_signal(task, &work->tw, &hmap,
+						    busy_cb_gen1);
+		bpf_task_release(task);
+		if (err == -EBUSY) {
+			bump_stat(BUSY_STAT_G1_RETRY);
+			return 0;
+		}
+		set_status(BUSY_GEN1_RESULT, ((__s64)seq << 32) | (__u32)err);
+		return 0;
+	}
+
+	if (tid != (__u32)target_tid)
+		return 0;
+
+	window = (__u64)get_status(BUSY_WINDOW);
+	seq = window >> 32;
+	if (!seq || (__u32)window == 0)
+		return 0;
+	/*
+	 * The first callback must have completed for this sequence.  Being
+	 * inside the target thread's own subsequent syscall proves the
+	 * callback wrapper has returned and the context is STANDBY, which
+	 * is stronger than observing the completion marker from another
+	 * thread.
+	 */
+	if ((__u64)get_status(BUSY_CB1_SEQ) != seq)
+		return 0;
+
+	if ((__u64)get_status(BUSY_ACK) >> 32 != seq) {
+		/*
+		 * The in-window attempt, exactly once per sequence.  On a
+		 * fixed kernel it must be rejected with -EBUSY: the context
+		 * is STANDBY, the map and program references are alive and
+		 * no other scheduler exists, so only the BUSY gate can
+		 * reject here.
+		 */
+		if (!busy_try_gen2(seq, BUSY_ACK))
+			set_status(BUSY_ACK,
+				   ((__s64)seq << 32) | (__u32)-EBUSY);
+		return 0;
+	}
+
+	/*
+	 * Recovery, gated by the test: the fexit program releasing the
+	 * window does not mean the whole old handler has returned and
+	 * BUSY has cleared yet, so retry until the schedule succeeds.
+	 */
+	if ((__u64)get_status(BUSY_RECOVER_SEQ) != seq)
+		return 0;
+	if ((__s32)get_status(BUSY_ACK) == 0)
+		return 0;	/* scheduled in-window; nothing to recover */
+	if (((__u64)get_status(BUSY_GEN2_RESULT) >> 32) == seq)
+		return 0;	/* terminal recovery result published */
+	if (!busy_try_gen2(seq, BUSY_GEN2_RESULT))
+		bump_stat(BUSY_STAT_G2_RETRY);
+	return 0;
+}
-- 
2.43.0

