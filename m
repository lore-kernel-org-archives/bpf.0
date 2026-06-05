Received: from mail-ej1-f74.google.com (mail-ej1-f74.google.com [209.85.218.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 131C93F483F
	for <bpf@vger.kernel.org>; Fri,  5 Jun 2026 13:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780664789; cv=none; b=nXRAu10s9Spg6lYiktmDK5LcH/Z9EKQA0Y4ZIWNVdEbjYzNIGrJ0s8zXRTEdZGn8trJWfc9I/MXAysBV17ySFxLiiihbTEB7H9pRVOUUkxQC3B6aT4jTFbElyRkGp+KGgdhPBMpxF9Fb5YvWrVkDgbJqe5pujPr9dF/JP+Acjgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780664789; c=relaxed/simple;
	bh=V1KPIqz+cAv/hDDxeMaj4eYYqkV7BU1cT6Za+pvDzUw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=gYgvlygzPayLg2a9Ibt4KBJ0SlODJcY9ZVwm9TqPqHLiQY4dg2BHlryDvaZnq7TcxwCNDCXFHgM+FjMcHys+dp7IDeCL1xBuHa4Ex9NLHXdJIj0eJr8Orp/+pgyjGneJWTzsxKf/mPTdsiubE03q0EAJIkkC2iBz6CuWxn0LG+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mayamatuszczyk.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AkP1RCwc; arc=none smtp.client-ip=209.85.218.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mayamatuszczyk.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AkP1RCwc"
Received: by mail-ej1-f74.google.com with SMTP id a640c23a62f3a-beeb1713d20so200611566b.1
        for <bpf@vger.kernel.org>; Fri, 05 Jun 2026 06:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780664786; x=1781269586; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lNb5wVpo/bFV/HKibQ5BVngRtUeTJAYuMZQhxMplvwI=;
        b=AkP1RCwcoEIvIIuB73DKTxrq3AtYoNXPfRf5K++vL/4hoiTuHF50ulKt99HY4MTPNf
         Q8G+G7MdxHUKAo0g8MYosDkNX0ofkl/TEawlagdx83ky2/eQeIqZY0SfE1KnzmbUzjec
         QaFKxHPdP6ohN+k6OhSiWF2iuI3hBqvrRvfK6A1qrncTWrtGsib/nrBP2Xud23B9pG/7
         Nb8p2fYEXQab+Nl14DiHZXfoyAbpWNEn3R19yd7NEJJ8YFmfTdWmBB5a+1jT6VJuAIZx
         09tjPIyoJmWovFlF1qVeeSGZ7wlR3xKyx9gQ5+A6HqaOQ8kout4efJGojj8MD7sjRt4C
         i23Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780664786; x=1781269586;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lNb5wVpo/bFV/HKibQ5BVngRtUeTJAYuMZQhxMplvwI=;
        b=rVzxsr7qv/nMW0tDMmkSAzRYwCbCUycKEDdVOyOwXn5yU50YhfUzEosvs2AukxsByr
         T0EY0fC8/qkGtvRLS8OhxtXPoXbGNw/Kb4vReJJtU3HgIgRbKJFPu4qNvg+uaxIqAGRV
         JeuQQ049Cr82dJM8RzCqWnW6jVBuO4BuznE3RqyGXFPjIdVtgvMyRJX4w0YH7OxxIp8G
         4uogV1Fanv6xnkja4DWdCaFN3z5YO0lsInzCNkx3o4jnSNkIbqEreMWJL1IHfuzMjb7I
         Q4CqhDn/m9Mksjp5EL5dkz+1HCxgXp3Uq+uJQ65tgW0jdw7B2/recgVXHftiARrZMnVC
         8upA==
X-Forwarded-Encrypted: i=1; AFNElJ+bQWjcRJI7ZHVClgqd4R/q/haCWmoSls1i9TeMKJgwtcMx//WD5WkhB7qS/F5n/p3pHKM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzr8IAxXBVmdFRImLqUANTiE/NA8q48PaX75GuAsup9rmd1QSr1
	Lx4VVTgzHHR+OCN0CssKncMVWp4Ejcf2uWx05gaKiMRTtgFRf6mVjDZ4HcamEgHQMMj/ndELrOr
	2/WQK1cN3jkLq6YI/1kCW8TgjS0zwB1lExSLJ8A==
X-Received: from edpd18.prod.google.com ([2002:aa7:c1d2:0:b0:67b:b3e7:d6a8])
 (user=mayamatuszczyk job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:906:4fcd:b0:bda:e47:70c7 with SMTP id a640c23a62f3a-bf37018943dmr167456666b.12.1780664773844;
 Fri, 05 Jun 2026 06:06:13 -0700 (PDT)
Date: Fri,  5 Jun 2026 13:06:01 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.1032.g2f8565e1d1-goog
Message-ID: <20260605130601.2699172-1-mayamatuszczyk@google.com>
Subject: [PATCH bpf-next v2] selftests/bpf: Run test_perf_branches more than 1 time
From: Maya Matuszczyk <mayamatuszczyk@google.com>
To: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>
Cc: Matt Bobrowski <mattbobrowski@google.com>, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Maya Matuszczyk <mayamatuszczyk@google.com>
Content-Type: text/plain; charset="UTF-8"

test_perf_branches bpf program was only being ran once, and
perf_branches test would fail if the only sample that was passed to
test_perf_branches didn't have branch data.
Fix those failures by running it a few more times and waiting until a valid
sample shows up, and leave the perf event only enabled for the duration of
test spins.

Signed-off-by: Maya Matuszczyk <mayamatuszczyk@google.com>
---
Changes from v1:
- Switched from CHECK to ASSERT_OK (Alexei Starovoitov)
- bpf -> bpf-next

v1: https://lore.kernel.org/bpf/20260408095710.4090495-1-mayamatuszczyk@google.com/
---
 .../selftests/bpf/prog_tests/perf_branches.c  | 57 +++++++++++++------
 .../selftests/bpf/progs/test_perf_branches.c  | 11 ++--
 2 files changed, 43 insertions(+), 25 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/perf_branches.c b/tools/testing/selftests/bpf/prog_tests/perf_branches.c
index 0a7ef770c487..153afcdc082e 100644
--- a/tools/testing/selftests/bpf/prog_tests/perf_branches.c
+++ b/tools/testing/selftests/bpf/prog_tests/perf_branches.c
@@ -15,10 +15,6 @@ static void check_good_sample(struct test_perf_branches *skel)
 	int pbe_size = sizeof(struct perf_branch_entry);
 	int duration = 0;
 
-	if (CHECK(!skel->bss->run_cnt, "invalid run_cnt",
-		  "checked sample validity before prog run"))
-		return;
-
 	if (CHECK(!skel->bss->valid, "output not valid",
 		 "no valid sample from prog"))
 		return;
@@ -49,10 +45,6 @@ static void check_bad_sample(struct test_perf_branches *skel)
 	int written_stack = skel->bss->written_stack_out;
 	int duration = 0;
 
-	if (CHECK(!skel->bss->run_cnt, "invalid run_cnt",
-		  "checked sample validity before prog run"))
-		return;
-
 	if (CHECK(!skel->bss->valid, "output not valid",
 		 "no valid sample from prog"))
 		return;
@@ -73,7 +65,6 @@ static void test_perf_branches_common(int perf_fd,
 	bool detached = false;
 	struct bpf_link *link;
 	volatile int j = 0;
-	cpu_set_t cpu_set;
 
 	skel = test_perf_branches__open_and_load();
 	if (CHECK(!skel, "test_perf_branches_load",
@@ -85,19 +76,35 @@ static void test_perf_branches_common(int perf_fd,
 	if (!ASSERT_OK_PTR(link, "attach_perf_event"))
 		goto out_destroy_skel;
 
-	/* generate some branches on cpu 0 */
-	CPU_ZERO(&cpu_set);
-	CPU_SET(0, &cpu_set);
-	err = pthread_setaffinity_np(pthread_self(), sizeof(cpu_set), &cpu_set);
-	if (CHECK(err, "set_affinity", "cpu #0, err %d\n", err))
+	err = ioctl(perf_fd, PERF_EVENT_IOC_RESET, 0);
+	if (!ASSERT_OK(err, "ioctl(PERF_EVENT_IOC_RESET)"))
 		goto out_destroy;
 
-	/* Spin the loop for a while by using a high iteration count, and by
-	 * checking whether the specific run count marker has been explicitly
-	 * incremented at least once by the backing perf_event BPF program.
+	err = ioctl(perf_fd, PERF_EVENT_IOC_REFRESH, 10);
+	if (!ASSERT_OK(err, "ioctl(PERF_EVENT_IOC_REFRESH)"))
+		goto out_destroy;
+
+	/* Make up a bunch of branch events until we time out or bpf prog sets a flag
+	 * that it caught a valid event. To be completely sure that required_size_out,
+	 * written_stack_out or written_global_out writes and reads won't get
+	 * reordered by anyone in a way that would fail this test, use atomic
+	 * operations
 	 */
-	for (i = 0; i < 100000000 && !*(volatile int *)&skel->bss->run_cnt; ++i)
+	for (i = 0; i < 100000000; ++i) {
+		/* This technically should be an atomic load with acquire
+		 * ordering, but we don't want to clog up memory bus while
+		 * spinning
+		 */
+		if (READ_ONCE(skel->bss->valid) > 0)
+			break;
 		++j;
+	}
+
+	__atomic_thread_fence(__ATOMIC_ACQUIRE);
+
+	err = ioctl(perf_fd, PERF_EVENT_IOC_DISABLE, 0);
+	if (!ASSERT_OK(err, "ioctl(PERF_EVENT_IOC_DISABLE)"))
+		goto out_destroy;
 
 	test_perf_branches__detach(skel);
 	detached = true;
@@ -121,6 +128,7 @@ static void test_perf_branches_hw(void)
 	attr.size = sizeof(attr);
 	attr.type = PERF_TYPE_HARDWARE;
 	attr.config = PERF_COUNT_HW_CPU_CYCLES;
+	attr.disabled = 1;
 	attr.freq = 1;
 	attr.sample_freq = 1000;
 	attr.sample_type = PERF_SAMPLE_BRANCH_STACK;
@@ -162,6 +170,7 @@ static void test_perf_branches_no_hw(void)
 	attr.size = sizeof(attr);
 	attr.type = PERF_TYPE_SOFTWARE;
 	attr.config = PERF_COUNT_SW_CPU_CLOCK;
+	attr.disabled = 1;
 	attr.freq = 1;
 	attr.sample_freq = 1000;
 	pfd = syscall(__NR_perf_event_open, &attr, -1, 0, -1, PERF_FLAG_FD_CLOEXEC);
@@ -175,6 +184,18 @@ static void test_perf_branches_no_hw(void)
 
 void test_perf_branches(void)
 {
+	int err, duration = 0;
+	cpu_set_t cpu_set;
+
+	/* Pin ourselves to cpu0 so that all branches we generate would be
+	 * also on cpu0
+	 */
+	CPU_ZERO(&cpu_set);
+	CPU_SET(0, &cpu_set);
+	err = pthread_setaffinity_np(pthread_self(), sizeof(cpu_set), &cpu_set);
+	if (!ASSERT_OK(err, "pthread_set_affinity"))
+		return;
+
 	if (test__start_subtest("perf_branches_hw"))
 		test_perf_branches_hw();
 	if (test__start_subtest("perf_branches_no_hw"))
diff --git a/tools/testing/selftests/bpf/progs/test_perf_branches.c b/tools/testing/selftests/bpf/progs/test_perf_branches.c
index 05ac9410cd68..9806414cebc4 100644
--- a/tools/testing/selftests/bpf/progs/test_perf_branches.c
+++ b/tools/testing/selftests/bpf/progs/test_perf_branches.c
@@ -8,7 +8,6 @@
 #include <bpf/bpf_tracing.h>
 
 int valid = 0;
-int run_cnt = 0;
 int required_size_out = 0;
 int written_stack_out = 0;
 int written_global_out = 0;
@@ -25,13 +24,11 @@ int perf_branches(void *ctx)
 	__u64 entries[4 * 3] = {0};
 	int required_size, written_stack, written_global;
 
-	++run_cnt;
-
 	/* write to stack */
 	written_stack = bpf_read_branch_records(ctx, entries, sizeof(entries), 0);
 	/* ignore spurious events */
 	if (!written_stack)
-		return 1;
+		return 0;
 
 	/* get required size */
 	required_size = bpf_read_branch_records(ctx, NULL, 0,
@@ -40,14 +37,14 @@ int perf_branches(void *ctx)
 	written_global = bpf_read_branch_records(ctx, fpbe, sizeof(fpbe), 0);
 	/* ignore spurious events */
 	if (!written_global)
-		return 1;
+		return 0;
 
 	required_size_out = required_size;
 	written_stack_out = written_stack;
 	written_global_out = written_global;
-	valid = 1;
+	__atomic_add_fetch(&valid, 1, __ATOMIC_RELEASE);
 
-	return 0;
+	return 1;
 }
 
 char _license[] SEC("license") = "GPL";
-- 
2.54.0.1032.g2f8565e1d1-goog

