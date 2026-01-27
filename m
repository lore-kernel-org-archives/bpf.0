Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E9F836E495
	for <bpf@vger.kernel.org>; Tue, 27 Jan 2026 19:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769542340; cv=none; b=HfuYiybumIXXukrfqy0rngTbmYcfWZlKmZUCYcvkzA05m4kA4URWJnhdjrOvs17GfhBQVt5pWVbx/+ldpuedo8ayymRCq9au+rmrSmEGzi8i0Ti+e53zX3icYRYDF6GoblRTk6QFlKF8m+H5tplCDEgTrAwdubkha12St/pnwb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769542340; c=relaxed/simple;
	bh=+zll8YWmXOI5LQFMcvLeLap9N/dG8Up/vTHyOuVZrqc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CD3nmI6ta92Vq1hqQq5OWmYMd4AJ13oSzxc/RAIPPBmCDimVABGrktj18HTHjPPJdu0d8y6pmJCMKmg82WVOrNOgcViTwP9j0RySagCJa3vNRO3yyEkQ6UHUKsiFc4rpy1lAxSrNzuYRYVYJ6OzDp7bJHNi1+SpbYgdXQlJPZXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I78kdpqy; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I78kdpqy"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-432755545fcso4536885f8f.1
        for <bpf@vger.kernel.org>; Tue, 27 Jan 2026 11:32:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769542337; x=1770147137; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=94l3IamNynYw4DhIAk618jOMcaBvFWR4ubG0MusccgM=;
        b=I78kdpqyHK4udbvb3hT0BWgzct3CxWSnT8Z3T24ggOF45U/pSXx29a6sMBuE2xHaqi
         t4n0QTz8FbnU3Qc7YkNUWTwlhyT8mrq63EfcUr+AMndTldqN+dJPuK+mbMfBpCX/uG2/
         qIdqnWlwuF4SztD6U8Kl7EiJS/YvIwRSSZAEgnUUbRFvd3AXmm7ZObNvrCckt6pfnc0j
         2GRZiIFo65kq5qsfxjP68btsm8d5ImojkbgacWRK0ylkVsz8QahXkns9RlYGZEb4jaOU
         jD5roi209l3KyFhXTpFxv3Re7RrNjiow1rjxH/1Wzpx3Xp0nJZABjmrjiXao1NMPOko1
         lXhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769542337; x=1770147137;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=94l3IamNynYw4DhIAk618jOMcaBvFWR4ubG0MusccgM=;
        b=vKjC5AzuD4IWZo1sPQ/O6BHIMdTWyUad4KF+Gm4HtsjZDm8yv/Ph5EwMEURq/VidCA
         lurpIAbH/D5C8NYQPbFSQLtMLuRQm+JFMa8JmN83sVrORXBt/AH1evXm9HvDPAx6Ky0N
         xVwiMkbEQIEpMbW0ChNWsM84d3VBA1Rw8dhGkJwetCzXCFR5UMTeaoIohjaHod4BWKAS
         HVYbGE80KtyxjsPbAwb3szLY0YRHq/4mEkaoMgKm+cLI8ADmCJXAdt0+PBr2YET1RRss
         lQVvtWCUHCbkHquaDXv8aC13UzQg19vkobCXQ+ZztlZThxWjXCb5sHRmvjCMBf87JVdN
         1zig==
X-Gm-Message-State: AOJu0YxCqsVVImVF+ZTJ3CswKz7UTCfeK885liAT2JwjIrn8Jm4dIOr3
	6IEk1mPBxBGng54K32APrqofJhwk3WoyAOnri96rF09r63XVccBWHZbOyZmmw6oN
X-Gm-Gg: AZuq6aLQIa+tiTbn0CEdyIIA4MeFS9f9xjVVtRxIC57ll1coj7apceOoM5HttUq4Doh
	+eUg8rZuBhY3C9Dw4rHo6vDqLn93SSF4R6KC2NyNbckvAGAf/ZEfPftMnw3BmFMbn0tZ7VqvFJw
	jCZx0roFecWJhqe//38+rCQTuBxhOyPZm+rRhQCYtXvktvvJmLLcmkQ9x3i1Gep5SnRBUFHqMZx
	0nWy8YYEhi5wzHpoeY0TpGpSGTjWpE7CNGySpLFD0jKqf4BzsbyW5LBc6mxliWh29Np0xfTAkfV
	64Z9tSGRnOC0rlaCJx4Krg3VDnN74B/559sPyQpQOl4FXyO7dZavu0sG9ezz2O5iXWfj5w6l/aE
	wK7J/a3Mpa+8O30Xs1pW9wha3SHvxR4iRK5IE9pW4czrEAwZuBnpt+4a2RJ+GojBZURoZ2jqCm0
	uFZMdxhaZIGe3xB3ujr2ogL1vPHjI20o1W1x1lmhhR
X-Received: by 2002:a05:6000:613:b0:435:97f6:4f44 with SMTP id ffacd0b85a97d-435dd1d8cebmr4491776f8f.56.1769542336833;
        Tue, 27 Jan 2026 11:32:16 -0800 (PST)
Received: from localhost (i68975BB5.versanet.de. [104.151.91.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435e1323034sm974073f8f.35.2026.01.27.11.32.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jan 2026 11:32:16 -0800 (PST)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Tue, 27 Jan 2026 19:31:24 +0000
Subject: [PATCH bpf-next v8 7/8] selftests/bpf: Add timer stress test in
 NMI context
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260127-timer_nolock-v8-7-5a29a9571059@meta.com>
References: <20260127-timer_nolock-v8-0-5a29a9571059@meta.com>
In-Reply-To: <20260127-timer_nolock-v8-0-5a29a9571059@meta.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
 memxor@gmail.com, eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1769542292; l=8721;
 i=yatsenko@meta.com; s=20251031; h=from:subject:message-id;
 bh=DHUbkcr6vElchGtN5+GYsKlHTKlnFF5DGMkPlZo7cWo=;
 b=arDktk/gauDab9D4QXNc6A4AsPq5b6gk11eNNN89exzwElPW46dddXWrOCDFeMoIAxE6hwBTX
 vk4takzOJhPCn+PISquTB8i0zP+CXDyuOGnjNX1tLQqNhGLVJfH9bQb
X-Developer-Key: i=yatsenko@meta.com; a=ed25519;
 pk=TFoLStOoH/++W4HJHRgNr8zj8vPFB1W+/QECPcQygzo=

From: Mykyta Yatsenko <yatsenko@meta.com>

Add stress tests for BPF timers that run in NMI context using perf_event
programs attached to PERF_COUNT_HW_CPU_CYCLES.

The tests cover three scenarios:
- nmi_race: Tests concurrent timer start and async cancel operations
- nmi_update: Tests updating a map element (effectively deleting and
  inserting new for array map) from within a timer callback
- nmi_cancel: Tests timer self-cancellation attempt.

A common test_common() helper is used to share timer setup logic across
all test modes.

The tests spawn multiple threads in a child process to generate
perf events, which trigger the BPF programs in NMI context. Hit counters
verify that the NMI code paths were actually exercised.

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 tools/testing/selftests/bpf/prog_tests/timer.c | 158 +++++++++++++++++++++++++
 tools/testing/selftests/bpf/progs/timer.c      |  85 +++++++++++--
 2 files changed, 231 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/timer.c b/tools/testing/selftests/bpf/prog_tests/timer.c
index 2b932d4dfd436fd322bd07169f492e20e4ec7624..09ff21e1ad2f020146dd0623f3610d6db656812e 100644
--- a/tools/testing/selftests/bpf/prog_tests/timer.c
+++ b/tools/testing/selftests/bpf/prog_tests/timer.c
@@ -1,12 +1,27 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (c) 2021 Facebook */
+#include <sched.h>
 #include <test_progs.h>
+#include <linux/perf_event.h>
+#include <sys/syscall.h>
 #include "timer.skel.h"
 #include "timer_failure.skel.h"
 #include "timer_interrupt.skel.h"
 
 #define NUM_THR 8
 
+static int perf_event_open(__u32 type, __u64 config, int pid, int cpu)
+{
+	struct perf_event_attr attr = {
+		.type = type,
+		.config = config,
+		.size = sizeof(struct perf_event_attr),
+		.sample_period = 10000,
+	};
+
+	return syscall(__NR_perf_event_open, &attr, pid, cpu, -1, 0);
+}
+
 static void *spin_lock_thread(void *arg)
 {
 	int i, err, prog_fd = *(int *)arg;
@@ -57,6 +72,134 @@ static int timer_stress_async_cancel(struct timer *timer_skel)
 	return timer_stress_runner(timer_skel, true);
 }
 
+static void *nmi_cpu_worker(void *arg)
+{
+	volatile __u64 num = 1;
+	int i;
+
+	for (i = 0; i < 500000000; ++i)
+		num *= (i % 7) + 1;
+	(void)num;
+
+	return NULL;
+}
+
+static int run_nmi_test(struct timer *timer_skel, struct bpf_program *prog)
+{
+	struct bpf_link *link = NULL;
+	int pe_fd = -1, pipefd[2] = {-1, -1}, pid = 0, status;
+	char buf = 0;
+	int ret = -1;
+
+	if (!ASSERT_OK(pipe(pipefd), "pipe"))
+		goto cleanup;
+
+	pid = fork();
+	if (pid == 0) {
+		/* Child: spawn multiple threads to consume multiple CPUs */
+		pthread_t threads[NUM_THR];
+		int i;
+
+		close(pipefd[1]);
+		read(pipefd[0], &buf, 1);
+		close(pipefd[0]);
+
+		for (i = 0; i < NUM_THR; i++)
+			pthread_create(&threads[i], NULL, nmi_cpu_worker, NULL);
+		for (i = 0; i < NUM_THR; i++)
+			pthread_join(threads[i], NULL);
+		exit(0);
+	}
+
+	if (!ASSERT_GE(pid, 0, "fork"))
+		goto cleanup;
+
+	/* Open perf event for child process across all CPUs */
+	pe_fd = perf_event_open(PERF_TYPE_HARDWARE,
+				PERF_COUNT_HW_CPU_CYCLES,
+				pid,  /* measure child process */
+				-1);  /* on any CPU */
+	if (pe_fd < 0) {
+		if (errno == ENOENT || errno == EOPNOTSUPP) {
+			printf("SKIP:no PERF_COUNT_HW_CPU_CYCLES\n");
+			test__skip();
+			ret = EOPNOTSUPP;
+			goto cleanup;
+		}
+		ASSERT_GE(pe_fd, 0, "perf_event_open");
+		goto cleanup;
+	}
+
+	link = bpf_program__attach_perf_event(prog, pe_fd);
+	if (!ASSERT_OK_PTR(link, "attach_perf_event"))
+		goto cleanup;
+	pe_fd = -1;  /* Ownership transferred to link */
+
+	/* Signal child to start CPU work */
+	close(pipefd[0]);
+	pipefd[0] = -1;
+	write(pipefd[1], &buf, 1);
+	close(pipefd[1]);
+	pipefd[1] = -1;
+
+	waitpid(pid, &status, 0);
+	pid = 0;
+
+	/* Verify NMI context was hit */
+	ASSERT_GT(timer_skel->bss->test_hits, 0, "test_hits");
+	ret = 0;
+
+cleanup:
+	bpf_link__destroy(link);
+	if (pe_fd >= 0)
+		close(pe_fd);
+	if (pid > 0) {
+		write(pipefd[1], &buf, 1);
+		waitpid(pid, &status, 0);
+	}
+	if (pipefd[0] >= 0)
+		close(pipefd[0]);
+	if (pipefd[1] >= 0)
+		close(pipefd[1]);
+	return ret;
+}
+
+static int timer_stress_nmi_race(struct timer *timer_skel)
+{
+	int err;
+
+	err = run_nmi_test(timer_skel, timer_skel->progs.nmi_race);
+	if (err == EOPNOTSUPP)
+		return 0;
+	return err;
+}
+
+static int timer_stress_nmi_update(struct timer *timer_skel)
+{
+	int err;
+
+	err = run_nmi_test(timer_skel, timer_skel->progs.nmi_update);
+	if (err == EOPNOTSUPP)
+		return 0;
+	if (err)
+		return err;
+	ASSERT_GT(timer_skel->bss->update_hits, 0, "update_hits");
+	return 0;
+}
+
+static int timer_stress_nmi_cancel(struct timer *timer_skel)
+{
+	int err;
+
+	err = run_nmi_test(timer_skel, timer_skel->progs.nmi_cancel);
+	if (err == EOPNOTSUPP)
+		return 0;
+	if (err)
+		return err;
+	ASSERT_GT(timer_skel->bss->cancel_hits, 0, "cancel_hits");
+	return 0;
+}
+
 static int timer(struct timer *timer_skel)
 {
 	int err, prog_fd;
@@ -159,6 +302,21 @@ void serial_test_timer_async_cancel(void)
 	test_timer(timer_cancel_async);
 }
 
+void serial_test_timer_stress_nmi_race(void)
+{
+	test_timer(timer_stress_nmi_race);
+}
+
+void serial_test_timer_stress_nmi_update(void)
+{
+	test_timer(timer_stress_nmi_update);
+}
+
+void serial_test_timer_stress_nmi_cancel(void)
+{
+	test_timer(timer_stress_nmi_cancel);
+}
+
 void test_timer_interrupt(void)
 {
 	struct timer_interrupt *skel = NULL;
diff --git a/tools/testing/selftests/bpf/progs/timer.c b/tools/testing/selftests/bpf/progs/timer.c
index 4b4ca781e7cdcf78015359cbd8f8d8ff591d6036..d6d5fefcd9b13598d83070e573607129e8d579d3 100644
--- a/tools/testing/selftests/bpf/progs/timer.c
+++ b/tools/testing/selftests/bpf/progs/timer.c
@@ -63,6 +63,9 @@ __u64 bss_data;
 __u64 abs_data;
 __u64 err;
 __u64 ok;
+__u64 test_hits;
+__u64 update_hits;
+__u64 cancel_hits;
 __u64 callback_check = 52;
 __u64 callback2_check = 52;
 __u64 pinned_callback_check;
@@ -427,30 +430,88 @@ static int race_timer_callback(void *race_array, int *race_key, struct bpf_timer
 	return 0;
 }
 
-SEC("syscall")
-int race(void *ctx)
+/* Callback that updates its own map element */
+static int update_self_callback(void *map, int *key, struct bpf_timer *timer)
+{
+	struct elem init = {};
+
+	bpf_map_update_elem(map, key, &init, BPF_ANY);
+	__sync_fetch_and_add(&update_hits, 1);
+	return 0;
+}
+
+/* Callback that cancels itself using async cancel */
+static int cancel_self_callback(void *map, int *key, struct bpf_timer *timer)
+{
+	bpf_timer_cancel_async(timer);
+	__sync_fetch_and_add(&cancel_hits, 1);
+	return 0;
+}
+
+enum test_mode {
+	TEST_RACE_SYNC,
+	TEST_RACE_ASYNC,
+	TEST_UPDATE,
+	TEST_CANCEL,
+};
+
+static __always_inline int test_common(enum test_mode mode)
 {
 	struct bpf_timer *timer;
-	int err, race_key = 0;
 	struct elem init;
+	int ret, key = 0;
 
 	__builtin_memset(&init, 0, sizeof(struct elem));
-	bpf_map_update_elem(&race_array, &race_key, &init, BPF_ANY);
 
-	timer = bpf_map_lookup_elem(&race_array, &race_key);
+	bpf_map_update_elem(&race_array, &key, &init, BPF_ANY);
+	timer = bpf_map_lookup_elem(&race_array, &key);
 	if (!timer)
-		return 1;
+		return 0;
+
+	ret = bpf_timer_init(timer, &race_array, CLOCK_MONOTONIC);
+	if (ret && ret != -EBUSY)
+		return 0;
 
-	err = bpf_timer_init(timer, &race_array, CLOCK_MONOTONIC);
-	if (err && err != -EBUSY)
-		return 1;
+	if (mode == TEST_RACE_SYNC || mode == TEST_RACE_ASYNC)
+		bpf_timer_set_callback(timer, race_timer_callback);
+	else if (mode == TEST_UPDATE)
+		bpf_timer_set_callback(timer, update_self_callback);
+	else
+		bpf_timer_set_callback(timer, cancel_self_callback);
 
-	bpf_timer_set_callback(timer, race_timer_callback);
 	bpf_timer_start(timer, 0, 0);
-	if (async_cancel)
+
+	if (mode == TEST_RACE_ASYNC)
 		bpf_timer_cancel_async(timer);
-	else
+	else if (mode == TEST_RACE_SYNC)
 		bpf_timer_cancel(timer);
 
 	return 0;
 }
+
+SEC("syscall")
+int race(void *ctx)
+{
+	return test_common(async_cancel ? TEST_RACE_ASYNC : TEST_RACE_SYNC);
+}
+
+SEC("perf_event")
+int nmi_race(void *ctx)
+{
+	__sync_fetch_and_add(&test_hits, 1);
+	return test_common(TEST_RACE_ASYNC);
+}
+
+SEC("perf_event")
+int nmi_update(void *ctx)
+{
+	__sync_fetch_and_add(&test_hits, 1);
+	return test_common(TEST_UPDATE);
+}
+
+SEC("perf_event")
+int nmi_cancel(void *ctx)
+{
+	__sync_fetch_and_add(&test_hits, 1);
+	return test_common(TEST_CANCEL);
+}

-- 
2.52.0

