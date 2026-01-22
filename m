Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 526B3371048
	for <bpf@vger.kernel.org>; Thu, 22 Jan 2026 18:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769105039; cv=none; b=FaA+omOcPtLmD7Y8Ww3MeYVs4lGQrt1yrkv2jMl714x/mwMGKVhStyPS6UzoW2KZs3jR0bMNgCpVjklWe051f/zCc94Wuc+SvU0ugZIgC5K66pWEQBZloqebGuCNSuiVVBEEkdSDot6j5YpxvWGKtNHwZH57WwcoxlMMwVZ3fJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769105039; c=relaxed/simple;
	bh=+zll8YWmXOI5LQFMcvLeLap9N/dG8Up/vTHyOuVZrqc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=X/tAMwvzsjMyzP0Y3wD/z2BHt+/SNW1hZ9X+0nLj+dS/VzOdamWPXX3h2CGSovd7TBILmHAg3kVMaBd9lys0LQZgfoBLucd8fK4OxnjifVAfxMJ1S5UJMRX0QfMnh9DIvxcUb2eYHPojCjQ8U4SD3AVHENxo4SN8qJozEN99xOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OSo8NTID; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OSo8NTID"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-47fedb7c68dso13872795e9.2
        for <bpf@vger.kernel.org>; Thu, 22 Jan 2026 10:03:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769105028; x=1769709828; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=94l3IamNynYw4DhIAk618jOMcaBvFWR4ubG0MusccgM=;
        b=OSo8NTIDjvlTE6HHAMPhDCqZwTY5kGwvlerqLTLWjXH7NRgJ9L1u9gJQ9SSDt0N2Fx
         2/lWCA8Yf6m0JETKHImwKFSh+TKzjb/E8qjA0LFfZSxjL0FY+N0LBG8VvsrBepKosSMB
         SWGvI7TW7ZJSNGROYhiZwJAUIW1Ew1sS8xBVvIrDt7HyJIJ+k4wfknnBMl3k2JKasJLf
         LH+rWYKHASu7LBLP/EeiYtydoTSy3rYB/pNtCywjKR6lbS31uFMGUZHxPNzi2MR/sQsZ
         GsEw2qAvCQYET35ZswTP35qvduvzhjjnT9yasYFfn2Q+ySamZNn4eCMi17X9aSYirZrh
         ievA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769105028; x=1769709828;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=94l3IamNynYw4DhIAk618jOMcaBvFWR4ubG0MusccgM=;
        b=X63dzA7zqcT5w/06v1MtU3qI0dOvESUt8ay990kdD0lSkRBS8X4+Akncfgju8BlfrR
         NbjrvENi0YtUlEnlAUryUSz0BYt6UZCSkZON1J0LmDnVuzxBqaAHR5/JhRGwYXKanrBi
         Ky9MmxESaL1daeUzmf/Ydw0Cwcg1/9cImagPOEX8tSFEVivTvtpbkTPBDHVZezeqMVFW
         5S2Gw7Qy6oeylNeAd4wdwkXUOe0k53xL84MORh2qPi4NyMieKNHiXh7NjyQBTpaJZrAa
         n6PMuAsQWODYcK6YidAYFWmfPnhlDE83Nj1Fbo81zAcp04ywHioXYvsBH4LMWYoixGAt
         rY4A==
X-Gm-Message-State: AOJu0YzQspyg9s8zAD2NeH69JrMPdmjpwTlBEkarBdpbXGj725T9NKyS
	RIVanboRhCfrGddDr8Wq5cNSby/O9ImPJ+dLLppyDFwPm24scfrzqVm+
X-Gm-Gg: AZuq6aJvM5noYQ+Yx9FCL6J+GVNGA6E1QmUHOOkN8JkS3kSIFyrLKYgnNPaZHloKDzo
	xYIOJcE+J3+ZUiKc0T7U/SlC7xqyGY8567WyKV1hT+mpbAZ4QT2uFVG4rIxAG47Zv9olLQvFkh/
	qucVvE1TTwRFSJpcEZvDDuLWlrR5837wy0lZ/whP/HOSpuRW/qwyhYT7lfJOcw9jkY0JAT+tJma
	ufdZRe0T2V3Ua8+J5fBnZaq28e0gp58zpURxqlBjL4kU3mWSnWkXzhnOUMkD7jici+gD6rx9IiO
	1exL0tFH36IXtFLdTQghiR/BY6gr67g4LAeXJpSBoKz5YQpOusVH3NYsjTVc6AvO9L0o/7zHgAC
	A07L1AzdOFGHe1FJDnUQr36k3F4f7gDFjkgB7W9rZg52Jj9F7opEmmydImjRSSuclL0lV0mu9tX
	m7vZhwwyEMNSGv
X-Received: by 2002:a05:600c:1d28:b0:47e:e4ff:e2ac with SMTP id 5b1f17b1804b1-4804c9d4fd2mr7767355e9.33.1769105027963;
        Thu, 22 Jan 2026 10:03:47 -0800 (PST)
Received: from localhost ([2a02:8109:a307:d900:df8b:2445:a6ca:bb5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4804d4fb117sm824185e9.9.2026.01.22.10.03.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 10:03:47 -0800 (PST)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Thu, 22 Jan 2026 18:03:20 +0000
Subject: [PATCH bpf-next v7 7/8] selftests/bpf: Add timer stress test in
 NMI context
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260122-timer_nolock-v7-7-04a45c55c2e2@meta.com>
References: <20260122-timer_nolock-v7-0-04a45c55c2e2@meta.com>
In-Reply-To: <20260122-timer_nolock-v7-0-04a45c55c2e2@meta.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
 memxor@gmail.com, eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1769105013; l=8721;
 i=yatsenko@meta.com; s=20251031; h=from:subject:message-id;
 bh=DHUbkcr6vElchGtN5+GYsKlHTKlnFF5DGMkPlZo7cWo=;
 b=joqWtvQtnZ1/GTkf3BYjqkOJ/+DTmCYwRlr+VlZyQ51IL4HwuE1Gv+y3TUeq4KKqKPcz0tlkP
 5vePveR2Mx7A1f7zyVeDsiPk9JwyKC+r536lW/b/vRxc9g6RcFrdyoW
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

