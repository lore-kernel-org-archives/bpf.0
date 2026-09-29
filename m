Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B3233A4F58
	for <bpf@vger.kernel.org>; Tue, 29 Sep 2026 07:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790666951; cv=none; b=L7UoqlasN3ESQ37gdZm0MKnfGsrxXt2Z0zi7yUHYn2GsZv8IXau9654cG+v7oq3NMCtydkwPFmj3bjRD+MJdsr/mPC//y45KyrnDv0B89YyniR7aQWNlV+7i7AzB05pu5cgslfEDZb/OeKs/fG1nc+nRNacXo87uuGyUN5oEWkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790666951; c=relaxed/simple;
	bh=KQ16XsW+SuT3NNzlp3jQzm5NLsK7h45RXkSLe98I8EY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LbmhUZtm7oBLXFKYvQokNi4qza38eLbyPd5XXI0ooJdSXKyxKFoWRu/VXaz8dDnPxwPRNKAOcsgavkldHcOpALg+KAfCF4p5+pfFumMf3XQ6M3Q3EPbxwmsBi+EiijyU6xDDFfM380kuAZs8Z5sXI0aTgK+8/PmfuP/IebofVAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=mieBKwHg; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="mieBKwHg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=TL
	OE0cEQY7RUFUp374/EcCIRcJiRag/SRbN40YGEWso=; b=mieBKwHgsQ4ZggRz8R
	w3tzjIfZ2PbP7V+tX+biS67g3Ti4fkzDJ1EILBL2zj2Qte/9eHd6ErNCb8z4oVdr
	w+tCT6IHvt+bOc+P9GekGJxCp1S0Cj6m8ICYeYtFzJlyHBO8sC2hHmPVh/kqO0LY
	129uOTs48p2KGJ3cIke7UAM1w=
Received: from kylin-ERAZER-H610M.. (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCgvCgD3H4iLaLtqtLTxBw--.62773S5;
	Tue, 29 Sep 2026 15:28:17 +0800 (CST)
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
Subject: [PATCH bpf-next v4 3/3] selftests/bpf: Add task work scheduling race test
Date: Tue, 29 Sep 2026 15:28:00 +0800
Message-ID: <20260929072800.113129-4-luyun_611@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260929072800.113129-1-luyun_611@163.com>
References: <20260929072800.113129-1-luyun_611@163.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:QCgvCgD3H4iLaLtqtLTxBw--.62773S5
X-Coremail-Antispam: 1Uf129KBjvAXoW3tFy7KrW3AFyfKryfCF4kZwb_yoW8JF4kJo
	Z3ua15tw1kGr97Awn7Xa4ktr4YganFgas5Zr40grW5AF1fZrWYvF1kCw4fJw1xZF4rXa43
	ZFykZw1rAr48JFyfn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxU39mRUUUUU
X-CM-SenderInfo: pox130jbwriqqrwthudrp/xtbCwxHHlmq7aJEAiAAA3j

From: Yun Lu <luyun@kylinos.cn>

Exercise task-work scheduling and callback execution on different CPUs
while userspace reuses or deletes the associated map value.  Run 1500
rounds rotating through context reuse, deletion after the callback has
recorded its generation, and deletion racing with scheduling.

Publish the scheduling result and its generation in one packed value, so
userspace does not rely on ordering between separate map slots.  Record
callbacks in separate per-generation slots so an earlier callback cannot
satisfy a later round's completion check.

Retry transient -EBUSY results while the context is unavailable for
reuse.  In the deletion-race case, allow -ENOENT if the element is
removed before a retry finds it.

Choose two CPUs from the process affinity mask and skip if fewer than
two are available.  Bound the thread-start wait, report thread creation
and affinity failures, and stop the worker threads with an atomic
handshake.

Signed-off-by: Yun Lu <luyun@kylinos.cn>
---
 .../selftests/bpf/prog_tests/test_task_work.c | 283 ++++++++++++++++++
 .../selftests/bpf/progs/task_work_race.c      | 126 ++++++++
 2 files changed, 409 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/task_work_race.c

diff --git a/tools/testing/selftests/bpf/prog_tests/test_task_work.c b/tools/testing/selftests/bpf/prog_tests/test_task_work.c
index 774b31a5f6ca..ff56976f4226 100644
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
@@ -155,3 +159,282 @@ void test_task_work(void)
 
 	RUN_TESTS(task_work_fail);
 }
+
+#define TASK_WORK_RACE_ROUNDS	1500
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
+	int trigger_cpu;
+	int target_cpu;
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
+static void *task_work_race_trigger(void *arg)
+{
+	struct task_work_race_ctx *ctx = arg;
+	int err;
+
+	err = task_work_race_pin_cpu(ctx->trigger_cpu);
+	if (err)
+		__atomic_store_n(&ctx->setup_err, err, __ATOMIC_RELEASE);
+	__atomic_store_n(&ctx->trigger_tid, syscall(__NR_gettid),
+			 __ATOMIC_RELEASE);
+	while (!__atomic_load_n(&ctx->stop, __ATOMIC_ACQUIRE))
+		getppid();
+	return NULL;
+}
+
+static void *task_work_race_target(void *arg)
+{
+	struct task_work_race_ctx *ctx = arg;
+	int err;
+
+	err = task_work_race_pin_cpu(ctx->target_cpu);
+	if (err)
+		__atomic_store_n(&ctx->setup_err, err, __ATOMIC_RELEASE);
+	__atomic_store_n(&ctx->target_tid, syscall(__NR_gettid),
+			 __ATOMIC_RELEASE);
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
+	for (i = 0; i < 2000000 / 100; i++) {
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
+		usleep(100);
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
+	for (i = 0; i < 2000000 / 100; i++) {
+		__s64 result = 0;
+
+		if (!task_work_race_status(skel, RACE_RESULT, &result) &&
+		    (__u32)((__u64)result >> 32) == seq)
+			return (__s32)result;
+		usleep(100);
+	}
+	return -ETIMEDOUT;
+}
+
+static int task_work_race_wait_callback(struct task_work_race *skel,
+					__u32 seq)
+{
+	int i, key = seq;
+
+	for (i = 0; i < 2000000 / 100; i++) {
+		__u64 completed = 0;
+
+		if (!bpf_map_lookup_elem(bpf_map__fd(skel->maps.completed),
+					 &key, &completed) && completed)
+			return 0;
+		usleep(100);
+	}
+	return -ETIMEDOUT;
+}
+
+void serial_test_task_work_race(void)
+{
+	struct task_work_race_ctx ctx = {};
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
+			ctx.trigger_cpu = cpu;
+		else
+			ctx.target_cpu = cpu;
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
+	err = pthread_create(&target, NULL, task_work_race_target, &ctx);
+	if (!ASSERT_OK(err, "pthread_create target"))
+		goto cleanup;
+	target_started = true;
+	err = pthread_create(&trigger, NULL, task_work_race_trigger, &ctx);
+	if (!ASSERT_OK(err, "pthread_create trigger"))
+		goto stop;
+	trigger_started = true;
+
+	for (i = 0; i < 5000000 / 100; i++) {
+		if (__atomic_load_n(&ctx.trigger_tid, __ATOMIC_ACQUIRE) &&
+		    __atomic_load_n(&ctx.target_tid, __ATOMIC_ACQUIRE))
+			break;
+		usleep(100);
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
+		 * Variant 2 deletes the element right after READY, so losing
+		 * the race against the scheduling kfunc is a valid outcome:
+		 * the schedule itself fails with -EBUSY (ctx already FREED),
+		 * and the retry on the next tracepoint invocation fails with
+		 * -ENOENT because the element is gone.  Either way the round
+		 * exercised the deletion paths; a later variant 0 round
+		 * recreates the element.
+		 */
+		if (variant == 2 && (err == -EBUSY || err == -ENOENT))
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

