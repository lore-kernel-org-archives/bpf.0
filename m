Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAD2427602C
	for <bpf@vger.kernel.org>; Sun,  1 Feb 2026 02:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769914467; cv=none; b=QBfPBLRZpjsb3DZO2dzU6gBvWP+vNNQAWJkWMt4lBltL/wg7AJihJ2jMflyoLNYjqxqV8unL8A0U72lhZvjKjDGH8RaGAuo5P1KkUA36SGGS/6l/JCYJ29rqPX3RpXhWxP0xhBJS/KRadg6GctyUcwPFtvOs5HGvkHBa9BQNgjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769914467; c=relaxed/simple;
	bh=9LAUzeA7Yzm4fwdyVqCA6+euEl8aeMIYDjZTGIl7jaA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E4J/4oDWFrvulmT3Q1RWSJ/7b9zdI7zQEc35jnN349sRTH9KyT+NxR0k4Rrz7Wyz3S2/K+UNKAMlDMRNVGrRw3io1o1ZVV3nAguF0ruJQjHdUMxsiIURlzNwrnS3k4dZgP3kLht/8fNKP33ViQLVpHvkCCNmJ1eDZLqpIw5QZyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cEdYh9Rs; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cEdYh9Rs"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-8231061d234so2858826b3a.1
        for <bpf@vger.kernel.org>; Sat, 31 Jan 2026 18:54:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769914465; x=1770519265; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bkAFnWXNwDw3D14KmV7W8kTtj3Y+/BoEBa02B92ekA8=;
        b=cEdYh9RsIFHKyAc5bl0cFvvYd3X84kqCqPWcN9aZ/J74G092yCoTCbcrYYCZv1qvkP
         EFAK2m+CfebVnuEVwOKLs8SjQp3Jo0lStHKm3VrJNk9NYiqN4XZsVKSKc+pGwGRYZx9A
         eqybL01z8rxpTrqFsIF3s267jsC43MvuVey4jvsUKlUVfWT/XdATDea0dMF3H6zXGT+l
         Z/6HuJaTnzntha4ecgsY5LS7icdbFz7X2kxtYhRfzwriKUfpCH+5gcMgoApT+oidiPaa
         yZ/4gI8YTrhzWZsr3aDQEZkUZMkx9OPPaitTX6rhTbij60pkjPKFyhjI5h27V/TVVr2L
         +TPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769914465; x=1770519265;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bkAFnWXNwDw3D14KmV7W8kTtj3Y+/BoEBa02B92ekA8=;
        b=OFhuLF+T4IgzrS3sE3OWhfr7T1jGwWHXch5yRR7WtE2/VFndS1L0TukGAwG4wqxWUP
         8TmVX9SNkmyZs4gacsItt8iKerQoeC2RD8xHd4VesiE8FSQ9oBi06J91zCG9DGpBv8b6
         9t+vSkSLOyJKXykaoJ2piTqkTsfa3tCD2be1SheBjyOGVtAj9p/EHkSFcQt4lAIBp7fp
         7y9xQUNxIqA306kaQoys/Pdh3gimZodzGc3p98oecncGPuWqjCPySqUZQ6xclYYSsH0O
         rKtrO+rP5tLs1RhYci9r7Y0ty1XVkO8S4pvg51vNqxdAslhFj2+GzaI0Ul5rjWR9VBeV
         u8XQ==
X-Gm-Message-State: AOJu0Yy09Zrlj9KkDcAIUwGfokPK2jxpedNMBiPM8AICC8kOUxPiayHM
	l9yhU0WF5ZeBgAuwf0Ex+HRSYI1qVMb3hLBSdjpqACYVTIhvwb+j7C3mthqyyQ==
X-Gm-Gg: AZuq6aInoOrI/KCvIM6H6F7/14RY3R3nkCFGD4mASo7JZdrgjjSzUwZVQUQcE+BvuAz
	BNACi89E9JAkbYyrGfwGcO8nXsYocdlmQF/wXI5O+qaiwMPaLc1LhRkXq16Y9jTP/6modi3r7iW
	7dUw3D75iz1BqD0qXCi3ke7rc9dZkJ6eIF17kAK0aobS8B/ax/BDIB3hkI96ovLmviTsPK69gcX
	twApwMK8ZDK5vg3cgjpvDwIglJ9VuobZd+KZ2KpxlZNxZuYilZhyPFdByy5LNYyZ4mJwOwmTJij
	mZT1wXZTuqmU1Esp/kl96/UaB7RL66GsnlrvfuxWcg2YkFkJhfk7cH3T5vXWmaqH+m0qIVr2g6w
	+jpiyeHx0RgLlh6BPzFVIKsMxOcDu/KHsQEuok0GBP1RC8+vKaUOcC6ymy4B3rzkTcGLCZjGZ2s
	4PNIWkAtLciZwd3SryeO4Ws+dmK0DjeLgIVM2c2xHo9+/oFUmB5VPRqDHmocAnPaw2Ww+XBQHqu
	ixXDLAv4NKnGkUhx9PWmUjPjKesicpskzth4TlwkXUlKuBx3s0Silwp3tmp
X-Received: by 2002:a05:6a00:2353:b0:81f:521c:b640 with SMTP id d2e1a72fcca58-823ab876337mr7118700b3a.55.1769914464875;
        Sat, 31 Jan 2026 18:54:24 -0800 (PST)
Received: from localhost.localdomain ([2601:600:837f:c6b0:18cf:ab6c:cac0:3007])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-823cdf6fa26sm2489251b3a.58.2026.01.31.18.54.24
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 31 Jan 2026 18:54:24 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	memxor@gmail.com,
	mykyta.yatsenko5@gmail.com,
	kernel-team@fb.com
Subject: [PATCH v9 bpf-next 7/9] selftests/bpf: Add timer stress test in NMI context
Date: Sat, 31 Jan 2026 18:54:01 -0800
Message-ID: <20260201025403.66625-8-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260201025403.66625-1-alexei.starovoitov@gmail.com>
References: <20260201025403.66625-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 .../testing/selftests/bpf/prog_tests/timer.c  | 158 ++++++++++++++++++
 tools/testing/selftests/bpf/progs/timer.c     |  85 ++++++++--
 2 files changed, 231 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/timer.c b/tools/testing/selftests/bpf/prog_tests/timer.c
index 2b932d4dfd43..09ff21e1ad2f 100644
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
index 4b4ca781e7cd..d6d5fefcd9b1 100644
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
2.47.3

