Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5EAE469823
	for <bpf@vger.kernel.org>; Wed, 30 Sep 2026 08:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790758548; cv=none; b=A529f6ovQvT5gL5vGf6OwqhbhQD98M0AcCD7SLktPNZ7llpgXpaWEjxBlKFZrcn38PFnAE/DMLYB4AElAHGFSZjpPwiS5ZaGKdE7mgddoIA6bOA5k1cv9cqmLnk+RmVwECSVT+bDSLLSTRGNr0MlRbtOcZrErYGvzNEdURBPYXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790758548; c=relaxed/simple;
	bh=BUdqi/79Rg4Ej3LMsVwAteVw8JY3Cubaz8q4cmXeVUs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kDWDgn975mVLrj28MXiKdKMEQNDtLDrLvPhwaLCuVNseTM3uK+AwV1S8RShfkaxmPodR583/wQNhGxt0s4kCWgPddgvRvQ/u0W9c3dBqY6KVA89m+Y9EOHM0UaazCLfLfqizFxuyZRTIq/YemD58NjHBNFMkKwIKWO0kMevV2gA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=EKMtk1Ue; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="EKMtk1Ue"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=PP
	qSzDV3CZd+DIRuO7yjYUNwVsvflcTp62Qxm2FwE/Y=; b=EKMtk1UexHLAWXnpuy
	QOTsgWOZOA4yTcM6w9gHg45jKvsc6J6o7o6A0Ve9s++lKqidr50F7/lsJWM8PHV1
	mNWx03FJzI0hZeOJ/FJ1vSgUM1pcUStOWa39Gc7dHhI5lie7VCggcuD+EG6Rg1Wk
	BUUpVrJugi9RYkeDwQwel6N40=
Received: from kylin-ERAZER-H610M.. (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgAnDapYzrxqRk3PCA--.39078S5;
	Wed, 30 Sep 2026 16:54:52 +0800 (CST)
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
Subject: [PATCH bpf-next v5 3/3] selftests/bpf: Add task work scheduling race test
Date: Wed, 30 Sep 2026 16:54:17 +0800
Message-ID: <20260930085417.186729-4-luyun_611@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260930085417.186729-1-luyun_611@163.com>
References: <20260930085417.186729-1-luyun_611@163.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PigvCgAnDapYzrxqRk3PCA--.39078S5
X-Coremail-Antispam: 1Uf129KBjvAXoW3Cw18WF13GFWDuF4UGw4xXrb_yoW8Gr43Jo
	Z3uan8tw18Gr97Awn7Xa4ktr1YganFg3s5Zw40grW5A3WfZr4YvF1kCw4fA34xAF4Fqa43
	ZFy8Jw1rZr48JFWfn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxU3Hq2DUUUU
X-CM-SenderInfo: pox130jbwriqqrwthudrp/xtbCwx2UY2q8zl0JcgAA3X

From: Yun Lu <luyun@kylinos.cn>

Add cross-CPU stress coverage for the captured-task cancellation and
irq_work context-reuse fixes in this series.  Run scheduling and the
target callback on different CPUs, rotating through three map-value
lifetime patterns for 1500 rounds.

Reuse rounds keep the map value and start the next generation after the
callback records its completion.  The next scheduling attempt can race
with the remaining callback cleanup, checking that the context becomes
reusable and subsequent generations make progress.

Late-deletion rounds remove the value after the callback records its
completion, racing deletion with the remaining callback cleanup and the
scheduling handler's final state transition.  Early-deletion rounds
remove it once the BPF program announces that it is about to schedule,
racing deletion with context acquisition and callback publication.
These deletion variants stress the cancellation paths affected by the
captured-task fix.

Publish the scheduling result together with its generation in one
packed value, so a stale result cannot be mistaken for the current
round's.  The BPF program retries transient -EBUSY results without
publishing them; in early-deletion rounds, accept -ENOENT when
deletion removes the value before a retry looks it up.  Check callback
completion separately for each generation so that an earlier callback
cannot satisfy a later round.

The test exercises these races under load; it does not force the exact
faulting interleavings.

Signed-off-by: Yun Lu <luyun@kylinos.cn>
---
 .../selftests/bpf/prog_tests/test_task_work.c | 281 ++++++++++++++++++
 .../selftests/bpf/progs/task_work_race.c      | 126 ++++++++
 2 files changed, 407 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/task_work_race.c

diff --git a/tools/testing/selftests/bpf/prog_tests/test_task_work.c b/tools/testing/selftests/bpf/prog_tests/test_task_work.c
index 774b31a5f6ca..6b45210e0578 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_task_work.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_task_work.c
@@ -5,10 +5,14 @@
 #include <stdio.h>
 #include "task_work.skel.h"
 #include "task_work_fail.skel.h"
+#include "task_work_race.skel.h"
 #include <linux/bpf.h>
 #include <linux/perf_event.h>
 #include <sys/syscall.h>
 #include <time.h>
+#include <pthread.h>
+#include <sched.h>
+#include <unistd.h>
 
 static int perf_event_open(__u32 type, __u64 config, int pid)
 {
@@ -155,3 +159,280 @@ void test_task_work(void)
 
 	RUN_TESTS(task_work_fail);
 }
+
+#define TASK_WORK_RACE_ROUNDS		1500
+#define TASK_WORK_RACE_POLL_US		100
+#define TASK_WORK_RACE_POLL_ITERS	20000
+#define TASK_WORK_RACE_START_POLL_ITERS	50000
+
+/* Must match progs/task_work_race.c. */
+enum task_work_race_status {
+	RACE_ARM_SEQ,
+	RACE_READY_SEQ,
+	/* High 32 bits hold the sequence, low 32 bits the signed error. */
+	RACE_RESULT,
+};
+
+struct task_work_race_value {
+	__u32 seq;
+	char data[60];
+	struct bpf_task_work tw;
+};
+
+struct task_work_race_ctx {
+	int stop;
+	int setup_err;
+	int trigger_tid;
+	int target_tid;
+};
+
+struct task_work_race_thread_arg {
+	struct task_work_race_ctx *ctx;
+	int cpu;
+	int *tid;
+};
+
+static int task_work_race_pin_cpu(int cpu)
+{
+	cpu_set_t set;
+
+	CPU_ZERO(&set);
+	CPU_SET(cpu, &set);
+	return pthread_setaffinity_np(pthread_self(), sizeof(set), &set);
+}
+
+static void *task_work_race_worker(void *arg)
+{
+	struct task_work_race_thread_arg *thread = arg;
+	struct task_work_race_ctx *ctx = thread->ctx;
+	int err;
+
+	err = task_work_race_pin_cpu(thread->cpu);
+	if (err)
+		__atomic_store_n(&ctx->setup_err, err, __ATOMIC_RELEASE);
+	__atomic_store_n(thread->tid, syscall(__NR_gettid), __ATOMIC_RELEASE);
+	while (!__atomic_load_n(&ctx->stop, __ATOMIC_ACQUIRE))
+		getppid();
+	return NULL;
+}
+
+static int task_work_race_status(struct task_work_race *skel, int idx,
+				 __s64 *value)
+{
+	return bpf_map_lookup_elem(bpf_map__fd(skel->maps.status), &idx,
+				   value);
+}
+
+static int task_work_race_set_status(struct task_work_race *skel, int idx,
+				     __s64 value)
+{
+	return bpf_map_update_elem(bpf_map__fd(skel->maps.status), &idx,
+				   &value, BPF_ANY);
+}
+
+static int task_work_race_wait_ready(struct task_work_race *skel, __u32 seq)
+{
+	int i;
+
+	for (i = 0; i < TASK_WORK_RACE_POLL_ITERS; i++) {
+		__s64 value = 0;
+
+		if (!task_work_race_status(skel, RACE_READY_SEQ, &value) &&
+		    value == seq)
+			return 0;
+		if (!task_work_race_status(skel, RACE_RESULT, &value) &&
+		    (__u32)((__u64)value >> 32) == seq)
+			/*
+			 * The BPF program finished between the two reads:
+			 * RESULT makes waiting for READY unnecessary. Any error
+			 * that occurred before READY is checked by the caller.
+			 */
+			return 0;
+		usleep(TASK_WORK_RACE_POLL_US);
+	}
+	return -ETIMEDOUT;
+}
+
+static int task_work_race_prepare_elem(struct task_work_race *skel)
+{
+	struct task_work_race_value value = {};
+	int key = 0;
+
+	if (!bpf_map_lookup_elem(bpf_map__fd(skel->maps.hmap), &key, &value))
+		return 0;
+	if (errno != ENOENT)
+		return -errno;
+	if (bpf_map_update_elem(bpf_map__fd(skel->maps.hmap), &key, &value,
+				BPF_NOEXIST))
+		return -errno;
+	return 0;
+}
+
+static int task_work_race_arm(struct task_work_race *skel, __u32 seq)
+{
+	if (task_work_race_set_status(skel, RACE_ARM_SEQ, seq))
+		return -errno;
+	return task_work_race_wait_ready(skel, seq);
+}
+
+static int task_work_race_check_done(struct task_work_race *skel, __u32 seq)
+{
+	int i;
+
+	for (i = 0; i < TASK_WORK_RACE_POLL_ITERS; i++) {
+		__s64 result = 0;
+
+		if (!task_work_race_status(skel, RACE_RESULT, &result) &&
+		    (__u32)((__u64)result >> 32) == seq)
+			return (__s32)result;
+		usleep(TASK_WORK_RACE_POLL_US);
+	}
+	return -ETIMEDOUT;
+}
+
+static int task_work_race_wait_callback(struct task_work_race *skel,
+					__u32 seq)
+{
+	int i, key = seq;
+
+	for (i = 0; i < TASK_WORK_RACE_POLL_ITERS; i++) {
+		__u64 completed = 0;
+
+		if (!bpf_map_lookup_elem(bpf_map__fd(skel->maps.completed),
+					 &key, &completed) && completed)
+			return 0;
+		usleep(TASK_WORK_RACE_POLL_US);
+	}
+	return -ETIMEDOUT;
+}
+
+void serial_test_task_work_race(void)
+{
+	struct task_work_race_ctx ctx = {};
+	struct task_work_race_thread_arg trigger_arg = {
+		.ctx = &ctx,
+		.tid = &ctx.trigger_tid,
+	};
+	struct task_work_race_thread_arg target_arg = {
+		.ctx = &ctx,
+		.tid = &ctx.target_tid,
+	};
+	struct task_work_race *skel;
+	pthread_t trigger, target;
+	cpu_set_t allowed;
+	int cpu, cpu_count = 0;
+	bool target_started = false, trigger_started = false;
+	int err, i, key = 0;
+
+	if (sched_getaffinity(0, sizeof(allowed), &allowed)) {
+		ASSERT_OK(-errno, "sched_getaffinity");
+		return;
+	}
+	for (cpu = 0; cpu < CPU_SETSIZE && cpu_count < 2; cpu++) {
+		if (!CPU_ISSET(cpu, &allowed))
+			continue;
+		if (!cpu_count)
+			trigger_arg.cpu = cpu;
+		else
+			target_arg.cpu = cpu;
+		cpu_count++;
+	}
+	if (cpu_count < 2) {
+		printf("%s:SKIP:need two CPUs in the process affinity mask\n",
+		       __func__);
+		test__skip();
+		return;
+	}
+
+	skel = task_work_race__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "open_and_load"))
+		return;
+	if (!ASSERT_OK(task_work_race__attach(skel), "attach"))
+		goto cleanup;
+
+	err = pthread_create(&target, NULL, task_work_race_worker, &target_arg);
+	if (!ASSERT_OK(err, "pthread_create target"))
+		goto cleanup;
+	target_started = true;
+	err = pthread_create(&trigger, NULL, task_work_race_worker, &trigger_arg);
+	if (!ASSERT_OK(err, "pthread_create trigger"))
+		goto stop;
+	trigger_started = true;
+
+	for (i = 0; i < TASK_WORK_RACE_START_POLL_ITERS; i++) {
+		if (__atomic_load_n(&ctx.trigger_tid, __ATOMIC_ACQUIRE) &&
+		    __atomic_load_n(&ctx.target_tid, __ATOMIC_ACQUIRE))
+			break;
+		usleep(TASK_WORK_RACE_POLL_US);
+	}
+	if (!ASSERT_TRUE(__atomic_load_n(&ctx.trigger_tid, __ATOMIC_ACQUIRE) &&
+			 __atomic_load_n(&ctx.target_tid, __ATOMIC_ACQUIRE),
+			 "thread start"))
+		goto stop;
+	if (!ASSERT_OK(__atomic_load_n(&ctx.setup_err, __ATOMIC_ACQUIRE),
+		       "thread affinity"))
+		goto stop;
+
+	skel->bss->trigger_tid = __atomic_load_n(&ctx.trigger_tid, __ATOMIC_ACQUIRE);
+	skel->bss->target_tid = __atomic_load_n(&ctx.target_tid, __ATOMIC_ACQUIRE);
+
+	for (i = 0; i < TASK_WORK_RACE_ROUNDS; i++) {
+		__u32 seq = i + 1;
+		int variant = i % 3;
+
+		if (!ASSERT_OK(task_work_race_prepare_elem(skel), "prepare elem") ||
+		    !ASSERT_OK(task_work_race_arm(skel, seq), "round ready"))
+			goto stop;
+
+		if (variant == 2 &&
+		    !ASSERT_OK(bpf_map_delete_elem(bpf_map__fd(skel->maps.hmap),
+						   &key), "early delete"))
+			goto stop;
+
+		err = task_work_race_check_done(skel, seq);
+		/*
+		 * Variant 2 deletes the element after READY. A scheduling attempt
+		 * racing with deletion can return -EBUSY, which the BPF program
+		 * retries without publishing RESULT. The retry can then report
+		 * -ENOENT because the element is gone; accept that terminal result.
+		 * A later variant 0 round recreates the element.
+		 */
+		if (variant == 2 && err == -ENOENT)
+			err = 0;
+		if (!ASSERT_OK(err, "schedule")) {
+			fprintf(stderr, "round %d schedule failed: %d\n", i, err);
+			goto stop;
+		}
+
+		if (variant != 2 &&
+		    !ASSERT_OK(task_work_race_wait_callback(skel, seq),
+			       "callback"))
+			goto stop;
+
+		if (variant == 1 &&
+		    !ASSERT_OK(bpf_map_delete_elem(bpf_map__fd(skel->maps.hmap),
+						   &key), "late delete"))
+			goto stop;
+	}
+
+	/* A distinct completion generation prevents an old callback satisfying this. */
+	if (!ASSERT_OK(task_work_race_prepare_elem(skel), "final prepare") ||
+	    !ASSERT_OK(task_work_race_arm(skel, TASK_WORK_RACE_ROUNDS + 1),
+		       "final ready") ||
+	    !ASSERT_OK(task_work_race_check_done(skel,
+					TASK_WORK_RACE_ROUNDS + 1),
+		       "final schedule") ||
+	    !ASSERT_OK(task_work_race_wait_callback(skel,
+					     TASK_WORK_RACE_ROUNDS + 1),
+		       "final callback"))
+		goto stop;
+
+stop:
+	__atomic_store_n(&ctx.stop, 1, __ATOMIC_RELEASE);
+	if (trigger_started)
+		pthread_join(trigger, NULL);
+	if (target_started)
+		pthread_join(target, NULL);
+cleanup:
+	task_work_race__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/task_work_race.c b/tools/testing/selftests/bpf/progs/task_work_race.c
new file mode 100644
index 000000000000..c94eca510cb3
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/task_work_race.c
@@ -0,0 +1,126 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 KylinSoft Corporation. */
+#include <vmlinux.h>
+#include <stdbool.h>
+#include <errno.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include "bpf_misc.h"
+
+char _license[] SEC("license") = "GPL";
+
+#define TASK_WORK_RACE_MAX_SEQ	2048
+
+enum task_work_race_status {
+	RACE_ARM_SEQ,
+	RACE_READY_SEQ,
+	/* High 32 bits hold the sequence, low 32 bits the signed error. */
+	RACE_RESULT,
+	RACE_STATUS_MAX,
+};
+
+int trigger_tid;
+int target_tid;
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, RACE_STATUS_MAX);
+	__type(key, int);
+	__type(value, __s64);
+} status SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, TASK_WORK_RACE_MAX_SEQ);
+	__type(key, int);
+	__type(value, __u64);
+} completed SEC(".maps");
+
+struct task_work_race_value {
+	__u32 seq;
+	char data[60];
+	struct bpf_task_work tw;
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__uint(map_flags, BPF_F_NO_PREALLOC);
+	__uint(max_entries, 4);
+	__type(key, int);
+	__type(value, struct task_work_race_value);
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
+static int process_work(struct bpf_map *map, void *key, void *value)
+{
+	struct task_work_race_value *work = value;
+	__u64 *done;
+	int seq = work->seq;
+
+	if (seq <= 0 || seq >= TASK_WORK_RACE_MAX_SEQ)
+		return 0;
+	done = bpf_map_lookup_elem(&completed, &seq);
+	if (done)
+		*done = 1;
+	return 0;
+}
+
+SEC("tracepoint/syscalls/sys_enter_getppid")
+int race_sched_work(void *ctx)
+{
+	struct task_work_race_value *work;
+	struct task_struct *task;
+	__s64 *arm, *result;
+	__u32 tid = (__u32)bpf_get_current_pid_tgid();
+	int key = 0, err;
+	__u32 seq;
+
+	if (tid != trigger_tid)
+		return 0;
+
+	key = RACE_ARM_SEQ;
+	arm = bpf_map_lookup_elem(&status, &key);
+	key = RACE_RESULT;
+	result = bpf_map_lookup_elem(&status, &key);
+	if (!arm || !result || *arm <= 0 ||
+	    (__u32)((__u64)*result >> 32) == *arm)
+		return 0;
+	seq = *arm;
+
+	task = bpf_task_from_pid(target_tid);
+	if (!task) {
+		err = -ESRCH;
+		goto out_done;
+	}
+
+	key = 0;
+	work = bpf_map_lookup_elem(&hmap, &key);
+	if (!work) {
+		err = -ENOENT;
+		goto out_task;
+	}
+
+	work->seq = seq;
+	set_status(RACE_READY_SEQ, seq);
+	err = bpf_task_work_schedule_signal(task, &work->tw, &hmap,
+					    process_work);
+	if (err == -EBUSY) {
+		bpf_task_release(task);
+		return 0;
+	}
+
+out_task:
+	bpf_task_release(task);
+out_done:
+	/* Publish the sequence and its error in one store. */
+	*result = ((__u64)seq << 32) | (__u32)err;
+	return 0;
+}
-- 
2.43.0

