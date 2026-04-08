Received: from mail-ed1-f73.google.com (mail-ed1-f73.google.com [209.85.208.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F5B63B47C6
	for <bpf@vger.kernel.org>; Wed,  8 Apr 2026 09:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775642260; cv=none; b=uaPQH9eAYbTmE6EFoUl6BoeD6JJDhlZ9grNSpyEiaGefP4vAV/Kw4TRiyop6XBzHbvFfVgz9JVvoyytgUcLz9IZDDTgAK8R+KsTSx8h/l4enD59B6l3tomO3xDIXZTCaelE8ntgqPF05pAGJsOAJcqr2OgOmqAntclUt86hYOEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775642260; c=relaxed/simple;
	bh=C9FG3DtWS19fzdQFs6EET2d8cyZQ21hc9YyvZv11zaE=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=RAGf7l1p7y/as4DhxyPnDcwRCdjGI7kCO2I9yOZpa9wDR6vQ7SgHKqEYIBe9jyQfyANfQiO8gu0NSo6CvrwG4vMREq4QzyU54Kj8ZkFLbZUaFEWpfZlRS0vrV0kGXIsAbZHIjLpg/gjsGZNxeLEI+AezsIvw320XnKJPVbayS6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mayamatuszczyk.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VwqFZG2b; arc=none smtp.client-ip=209.85.208.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mayamatuszczyk.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VwqFZG2b"
Received: by mail-ed1-f73.google.com with SMTP id 4fb4d7f45d1cf-66c73f6be2cso6506857a12.0
        for <bpf@vger.kernel.org>; Wed, 08 Apr 2026 02:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775642248; x=1776247048; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=CzIbkkxlc3hTYE+O4JvgRtwb3OFAdaRiTNhNwoqT7Ec=;
        b=VwqFZG2b2sBU+nuYlHRj4fdK0KPttZuRlzGIggApahQ2IZyQtWlNKNxnSgHleAWVt2
         +d7POiPYp3ipyzJSMLafNOxbha+H1uLxc+HMlDdMvOSObOT9D0X1Ruwa3TFHfWq1f8Cp
         nzpmMovfsEXDNLvqb4Ls0keJMzAB1xOGv4U0tecl+U+EEzky+hclDg7A4spuZB8XOnJB
         25wyJcL1b+G7QdtglgF2myR0nIkKafLW8Pg869AFqJrD2RWWTh7vRTw7izBFg0wA7iM2
         RExwyALpIuPz4UglLgYMF30VLFuj6kSFpmuc6VGvxf9QVBKwMS3FePcjfQZRUF7MIzls
         psSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775642248; x=1776247048;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CzIbkkxlc3hTYE+O4JvgRtwb3OFAdaRiTNhNwoqT7Ec=;
        b=IRsB9unt3VqUMDF7zAljDux0/Ke0QJJnApECiGvGGarv65H//v1IQuPePbl018mPWD
         PDpRvJEM2A3QjYL32C5SlJTMxkQSXQHmH5C1xgMFPGckVRZOdIztT4a6LyT2b0ujqxy/
         dgVorp5xJq3lwF6tPITiUO3bKq+XTTUp7chfCOOhk9VyH6p8g24qHC3I8q0/CXeej0O7
         GBFlbKh30zMd3Q9I5ffaG4Yx8ZT8zNeeAxvOXEw/Fxv7goZLnaVwMEt/H8VJNiHv8jJ4
         ebRPQKzGKv5P6Yo11d6WALafCDl0QF6dj7xh/kjN2Kr/SLDu5bjlTKBWRNqnWTIQe+Qq
         k2iw==
X-Forwarded-Encrypted: i=1; AJvYcCVqFu+i3Fx8ORHQKPrQKeuCvR4xvsRvaft9mdMbUMxzrCqdVvCu+D2K/HoFkrdE62PlKfo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwfR3WzXmhvsdY+4NZksYf0xARzmNu3u7xHOotJUVgJ6zy9IV8
	SHUHf0GcBB56m0Cz3j/tT8SDko67rAW167xCJgmkcxn8LkxdD2xZtRWZ3koFO6QSNjDY7GIGICE
	H6eYQCjirc6MUolRyOulsKd50RLZp2otSxPtURg==
X-Received: from edql23.prod.google.com ([2002:aa7:c317:0:b0:66b:f774:b985])
 (user=mayamatuszczyk job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:a2d4:10b0:66e:4372:8cfa with SMTP id 4fb4d7f45d1cf-66e43728e1fmr6413850a12.28.1775642248103;
 Wed, 08 Apr 2026 02:57:28 -0700 (PDT)
Date: Wed,  8 Apr 2026 09:57:10 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260408095710.4090495-1-mayamatuszczyk@google.com>
Subject: [PATCH bpf] selftests/bpf: Run test_perf_branches more than 1 time
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
 .../selftests/bpf/prog_tests/perf_branches.c  | 57 +++++++++++++------
 .../selftests/bpf/progs/test_perf_branches.c  | 11 ++--
 2 files changed, 43 insertions(+), 25 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/perf_branches.c b/tools/testing/selftests/bpf/prog_tests/perf_branches.c
index 0a7ef770c487..1dcb7c70f545 100644
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
+	if (CHECK(err == -1, "perf event reset", "ioctl err %d", errno))
 		goto out_destroy;
 
-	/* Spin the loop for a while by using a high iteration count, and by
-	 * checking whether the specific run count marker has been explicitly
-	 * incremented at least once by the backing perf_event BPF program.
+	err = ioctl(perf_fd, PERF_EVENT_IOC_REFRESH, 10);
+	if (CHECK(err == -1, "perf event refresh", "ioctl err %d", errno))
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
+	if (CHECK(err == -1, "perf event disable", "ioctl err %d", errno))
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
+	if (CHECK(err, "set_affinity", "cpu #0, err %d\n", err))
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
2.53.0.1213.gd9a14994de-goog

