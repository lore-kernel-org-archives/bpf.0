Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792983759;
	b=1+rS2eQ0cx7dTb9QKWynwHhz3mGu+VI5TPrGz584iNuM8/pE9RwTTUt5t36gGoIQ+fic
	 uEsIhwaIB6RiQLvipfoECaZ514ttXEgxpaeq7llNuY875fbW2G8XjZLylY5HTobo9gUjS
	 wBqM+Q5HyTKPre1FRKKN5HVFBqa7VF4cGf72lmsUp7FZ5oCIlY3HJcSZczZbpT73o/G9l
	 3Mmvi4P8wJ1dPkdPmJk+m9kDT037fHUT3cBdyuDS/YzulWUfWD+KHfnnwpO3ET7PSDRVL
	 3nGmobS2lhzf2bbv27AfhlsbydoP5ful15So+5IFQaikLa+jUbqthIr4gRpbHbgHxKw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792983759;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=wl0Px9HlDC5jz7bGIYn5uZVB7nsQApHn1DwEIjNAgyU=;
	b=3nescY042YZXb9aEgzL6TFsrsbtlEbtTb288cDjkZ0sFUKnXyWry4rmsIM9L7nVmlxvX
	 A/zUDbhnzPZ926I58H0wU2CalDaJghJtPGmGT0V7aVMgt1sPbq/eG0WtEmrHGvGVVR//J
	 bUN05Ah7m+xRuNkq3ZNgIk2Z9IapT/TiCow38O8u6PiUxhafAqY03B9kydqlr+MhI8D62
	 RbNpt7y5VUTBzUywRwX+mZd0inLn4f5+dhJVUdVwpzuT0jbC/da2r0jbKumBCf3evCwQP
	 bmykmSyiWmarjjmhRWXAEv2xXw/IKZDY0/1f1ocZMc86i2q9NpIlfzhCMiOuO0ckT8A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=LOusRgfV;
	arc=none smtp.remote-ip=209.85.216.46
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 132C3606A31B
	for <bpf@vger.kernel.org>; Mon, 26 Oct 2026 03:02:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 132C3606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=LOusRgfV
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3ada8bc2380so992096a91.3
        for <bpf@vger.kernel.org>; Sun, 25 Oct 2026 20:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792983757; x=1793588557; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wl0Px9HlDC5jz7bGIYn5uZVB7nsQApHn1DwEIjNAgyU=;
        b=LOusRgfVuYAX0FBxA9Qd1pxYmdEkKUf8igKt9MQmL0d7m7djqZqgHVJ4K1QcWcD5kv
         AmYqw2/wZqQkN7AUNmLWpDXpXpO6JaFpHr7a69x8BdOBoydhD7CUfthnyryxshK1usi5
         zrXtUKybJYDJEKLqfvg8x6qx997EsrtiVqOqVzog/QsFx+qq27hznS8GjsdLDNvKjEl4
         7E0/9O22pf0+qjyYEH8crwzSzcQ7yeK+Y0iiSsJcSQjvzFzFtYk1kzRqsYdbcxAeJJUu
         JH2dO8YWZWjjcddo1+/at2rjo4zzXAdflclSgE3wuZXhdM06odV/E0zpkZpQysOZrT+z
         7FYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792983757; x=1793588557;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=wl0Px9HlDC5jz7bGIYn5uZVB7nsQApHn1DwEIjNAgyU=;
        b=CfELJo//QP9IZ9XoSO0IgBWDvUEiHL/jdd9JZei1BH4uaDnjzBRTjLoMdMpfg3qIIr
         jESwuB8CZCvjObyw9D+tMgcE45p7ZX/3S+dBMzvukS/iRcF9X5HoqIoAzDG6pNGWPSLM
         TY6zzLr7kNkfhP/7OhOm0b7qtpq10SnMXbRnjIhMhc5Zv5kTpNNWgg1I9zlJxzwgynDJ
         OGPdLyjgmTKr3zdsUi7Dg+c5PXqjXV6rm7zDn/NbZCoecZIBxfZfHzngfhj4sEue3dsd
         gSjHN5qmKFlUcpvE45YtbghGjSIvfoQbpzPWXEzUSWmXRQJ+ZhF5MdaDDDX4mfMXB3A7
         OD5w==
X-Gm-Message-State: AFq9FYL876oYT5JOSKrVa1dTx+JmWHYNtqarVqpwxRMB2DL+Lyp0u1w0
	63Xgmer2MKJb/2XB/iBPzAFdKw02d5qqAcVprNEICYsC6XXsZtGYYzDs9c0K1w==
X-Gm-Gg: AYBFou0QW/VcsZmx0AHdsPfEU8Fn5JC1ipXA2HU1XpgtUeNLsrI7sByEDcjZQnHPFy9
	iud36H1R62K+K6eT89Y9brg2gJN/CPuFowSlrr3hxOlzS3wBffo7rlowrtPkBjYNtD0R9ONZeXd
	UkRvGdTdIUlSlbHIpZrufowMNtkV62YZqAzJEl2m9bugWsTn/TAYgXDmWPwwj51TunBoioc/YOy
	RRx0EYqTpnZ/coCC5E5HPCwvXCmI0LkLXC4Q3Kti1DWvc6BKqfUZxjyLQQ1jEftVEwZso+2sme3
	Q4QavQwAHM2Yjh0Gqay3M47NSsCJnM1BIwYGSoxu6i0hWoF8akTy0rNUejPMjAFzimCuQICX/w9
	KRq6KRYqn5FhDsVU0f6nmpd+11iawQjKN9qnG/6BWaICi1Eymd1+FdXOElS7OsYcuBcsCrvqNn/
	LOjqDmF9VW/e1OI9jloaOtLpDRogyqaXmHEa0t2oo6Xjf2F4ahBmlA2g5Av1JZANOtCOcdIGMDq
	z0ulR8su+Yz9Pc+4jkdcJDAa8eD9fsYIRldzxSoriZp2Br6jvr6KlwzboGIp5xZiy9elqlSuXhB
	whoGgkK+DiK6xRxMevQBRQnktLudMXuIEzgCJUW7kpaYaIHXAjrpGJqwz/5RhqxOz4PszZ3s51z
	ipGcOT1HYorLXEKq3IlF5sSec4zZkaSHEIC4KuWg+ZcyzSQ==
X-Received: by 2002:a17:90b:4c92:b0:3a6:fc30:ce16 with SMTP id 98e67ed59e1d1-3adeafc7dd4mr4418351a91.51.1792983756927;
        Sun, 25 Oct 2026 20:02:36 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.242])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3adebe6946dsm6248837a91.4.2026.10.25.20.02.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 20:02:36 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf 29/81] selftests/bpf: Add tests for BPF_REG_ARENA_SP
Date: Mon, 26 Oct 2026 02:58:50 +0000
Message-ID: <20261026025943.404450-30-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261026025943.404450-1-alexei.starovoitov@gmail.com>
References: <20261026025943.404450-1-alexei.starovoitov@gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

r12 (BPF_REG_ARENA_SP) is the stack pointer of the second stack of a prog.
This stack is in arena. Each run of a prog takes a stack at entry and gives
it back at exit. Runs that preempt or interrupt each other on one cpu must
not get the same stack.

arena_stack runs progs:

  subtest             what it does
  ------------------  ---------------------------------------------------
  preemption          8 threads on one cpu run a prog that fills its
                      frames, spins, and then examines the frames.
  nesting             The same with preemption disabled. A prog in the
                      timer interrupt writes to its own frames.
  timer               A timer callback takes a stack of its own.
  throw               bpf_throw() does not give the stack back. After many
                      throws other progs continue to run correctly.
  no_memory           The arena is too small for the stack. The prog does
                      not run, returns 0, and its stderr has a message.
  attach_to_subprog   fentry to the main prog loads. fentry to a subprog
                      is rejected.
  jump_to_first_insn  A jump to the first insn does not take a stack again.

The first two subtests fail if all runs on a cpu get the same stack.

verifier_arena_stack has the tests of the verifier:
 - Progs with the four insns that can use r12 load and return correct
   values.
 - All other insns with r12 are rejected. So are a frame of an incorrect
   size, call chains with more than 32 Kbyte of frames, tail calls, and
   progs without an arena.
 - r12 and the frame stay correct after a helper, a subprog with or without
   a frame, a callback and unwind_exit of a callee.
 - On x86 r12 is in the register of the 6th argument. Thus a subprog with 7
   arguments and a kfunc with 10 arguments are tested too.

Compilers do not emit r12. Thus the tests encode these insns with .8byte.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 .../selftests/bpf/prog_tests/arena_stack.c    | 249 +++++++
 .../selftests/bpf/prog_tests/verifier.c       |   2 +
 .../selftests/bpf/progs/arena_noarena.c       |  14 +
 .../testing/selftests/bpf/progs/arena_stack.c | 334 +++++++++
 .../selftests/bpf/progs/arena_stack_fentry.c  |  13 +
 .../selftests/bpf/progs/arena_stack_loop.c    |  52 ++
 .../selftests/bpf/progs/arena_stack_nomem.c   |  32 +
 .../bpf/progs/verifier_arena_stack.c          | 635 ++++++++++++++++++
 8 files changed, 1331 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/arena_stack.c
 create mode 100644 tools/testing/selftests/bpf/progs/arena_stack.c
 create mode 100644 tools/testing/selftests/bpf/progs/arena_stack_fentry.c
 create mode 100644 tools/testing/selftests/bpf/progs/arena_stack_loop.c
 create mode 100644 tools/testing/selftests/bpf/progs/arena_stack_nomem.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_arena_stack.c

diff --git a/tools/testing/selftests/bpf/prog_tests/arena_stack.c b/tools/testing/selftests/bpf/prog_tests/arena_stack.c
new file mode 100644
index 000000000000..aa567eb48353
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/arena_stack.c
@@ -0,0 +1,249 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#define _GNU_SOURCE
+#include <test_progs.h>
+#include <pthread.h>
+#include <sched.h>
+#include <linux/perf_event.h>
+#include <sys/syscall.h>
+#include "arena_stack.skel.h"
+#include "arena_stack_nomem.skel.h"
+#include "arena_stack_fentry.skel.h"
+#include "arena_stack_loop.skel.h"
+
+static int run_prog(int fd)
+{
+	LIBBPF_OPTS(bpf_test_run_opts, opts);
+
+	if (bpf_prog_test_run_opts(fd, &opts))
+		return -1;
+	return opts.retval;
+}
+
+static int run_tc_prog(int fd)
+{
+	char pkt[64] = {};
+	LIBBPF_OPTS(bpf_test_run_opts, opts, .data_in = pkt, .data_size_in = sizeof(pkt));
+
+	if (bpf_prog_test_run_opts(fd, &opts))
+		return -1;
+	return opts.retval;
+}
+
+static int pin_to_cpu0(cpu_set_t *old)
+{
+	cpu_set_t set;
+
+	if (sched_getaffinity(0, sizeof(*old), old))
+		return -1;
+	CPU_ZERO(&set);
+	CPU_SET(0, &set);
+	return sched_setaffinity(0, sizeof(set), &set);
+}
+
+#define NR_THREADS 8
+#define NR_RUNS 20
+
+static int preempted_fd;
+
+static void *preempted_thread(void *arg)
+{
+	long bad = 0;
+	int i;
+
+	for (i = 0; i < NR_RUNS; i++)
+		bad += run_prog(preempted_fd) != 0;
+	return (void *)bad;
+}
+
+/* Programs on one cpu preempt each other. They don't exit in the order they started. */
+static void test_preemption(struct arena_stack *skel)
+{
+	pthread_t thread[NR_THREADS];
+	long bad = 0;
+	cpu_set_t old;
+	void *ret;
+	int i, n;
+
+	if (!ASSERT_OK(pin_to_cpu0(&old), "pin"))
+		return;
+	preempted_fd = bpf_program__fd(skel->progs.preempted);
+	/* threads inherit the affinity */
+	for (n = 0; n < NR_THREADS; n++)
+		if (!ASSERT_OK(pthread_create(&thread[n], NULL, preempted_thread, NULL), "thread"))
+			break;
+	for (i = 0; i < n; i++) {
+		pthread_join(thread[i], &ret);
+		bad += (long)ret;
+	}
+	ASSERT_EQ(bad, 0, "runs with a corrupted frame");
+	sched_setaffinity(0, sizeof(old), &old);
+}
+
+/* A program that runs with preemption disabled is interrupted by a program in the timer interrupt */
+static void test_nesting(struct arena_stack *skel)
+{
+	struct perf_event_attr attr = {
+		.size = sizeof(attr),
+		.type = PERF_TYPE_SOFTWARE,
+		.config = PERF_COUNT_SW_CPU_CLOCK,
+		.sample_period = 50000, /* nsec */
+	};
+	struct bpf_link *link = NULL;
+	int i, pfd, bad = 0;
+	cpu_set_t old;
+
+	if (!ASSERT_OK(pin_to_cpu0(&old), "pin"))
+		return;
+	pfd = syscall(__NR_perf_event_open, &attr, -1, 0, -1, 0);
+	if (!ASSERT_GE(pfd, 0, "perf_event_open"))
+		goto out;
+	link = bpf_program__attach_perf_event(skel->progs.in_interrupt, pfd);
+	if (!ASSERT_OK_PTR(link, "attach_perf_event")) {
+		close(pfd);
+		goto out;
+	}
+	for (i = 0; i < 200; i++)
+		bad += run_tc_prog(bpf_program__fd(skel->progs.interrupted)) != 0;
+	ASSERT_EQ(bad, 0, "runs with a corrupted frame");
+	/* the program was interrupted */
+	ASSERT_GT(skel->bss->interrupts, 10, "interrupts");
+	bpf_link__destroy(link);
+out:
+	sched_setaffinity(0, sizeof(old), &old);
+}
+
+/* bpf_throw() doesn't return the stack. Programs run when all stacks of the cpu are taken. */
+static void test_throw(struct arena_stack *skel)
+{
+	cpu_set_t old;
+	int i;
+
+	if (!ASSERT_OK(pin_to_cpu0(&old), "pin"))
+		return;
+	for (i = 0; i < 40; i++)
+		run_prog(bpf_program__fd(skel->progs.throws));
+	for (i = 0; i < 40; i++)
+		if (!ASSERT_EQ(run_prog(bpf_program__fd(skel->progs.prog_returns_7)), 7, "returns_7"))
+			break;
+	/* the same with preemption disabled */
+	for (i = 0; i < 200; i++)
+		run_tc_prog(bpf_program__fd(skel->progs.throws_nested));
+	for (i = 0; i < 40; i++)
+		if (!ASSERT_EQ(run_tc_prog(bpf_program__fd(skel->progs.returns_8_nested)), 8,
+			       "returns_8_nested"))
+			break;
+	sched_setaffinity(0, sizeof(old), &old);
+}
+
+/* A callback that the kernel calls takes a stack of its own */
+static void test_timer(struct arena_stack *skel)
+{
+	int i, j;
+
+	for (i = 0; i < 100; i++) {
+		if (!ASSERT_OK(run_prog(bpf_program__fd(skel->progs.start_timer)), "start_timer"))
+			return;
+		for (j = 0; j < 1000 && skel->bss->timer_runs <= i; j++)
+			usleep(100);
+	}
+	ASSERT_EQ(skel->bss->timer_runs, 100, "runs of the callback");
+	ASSERT_EQ(skel->bss->timer_bad, 0, "runs with a wrong frame");
+}
+
+static void test_attach_to_subprog(struct arena_stack *skel)
+{
+	struct arena_stack_fentry *fentry;
+	int tgt_fd = bpf_program__fd(skel->progs.preempted);
+
+	/* the main program is fine */
+	fentry = arena_stack_fentry__open();
+	if (!ASSERT_OK_PTR(fentry, "open"))
+		return;
+	ASSERT_OK(bpf_program__set_attach_target(fentry->progs.on_entry, tgt_fd, "preempted"),
+		  "set_attach_target");
+	ASSERT_OK(arena_stack_fentry__load(fentry), "load for the main program");
+	arena_stack_fentry__destroy(fentry);
+
+	fentry = arena_stack_fentry__open();
+	if (!ASSERT_OK_PTR(fentry, "open"))
+		return;
+	ASSERT_OK(bpf_program__set_attach_target(fentry->progs.on_entry, tgt_fd, "spin"),
+		  "set_attach_target");
+	ASSERT_ERR(arena_stack_fentry__load(fentry), "load for a subprog");
+	arena_stack_fentry__destroy(fentry);
+}
+
+/* The insns that take the stack are in front of the first insn. A jump to it doesn't run them. */
+static void test_jump_to_first_insn(void)
+{
+	struct arena_stack_loop *skel;
+	cpu_set_t old;
+	int i;
+
+	skel = arena_stack_loop__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "open_and_load"))
+		return;
+	if (!ASSERT_OK(pin_to_cpu0(&old), "pin"))
+		goto out;
+	for (i = 0; i < 1000; i++) {
+		if (!ASSERT_EQ(run_tc_prog(bpf_program__fd(skel->progs.loop)), 7, "loop"))
+			break;
+		if (!ASSERT_EQ(run_tc_prog(bpf_program__fd(skel->progs.nop_loop)), 7, "nop_loop"))
+			break;
+	}
+	sched_setaffinity(0, sizeof(old), &old);
+out:
+	arena_stack_loop__destroy(skel);
+}
+
+static void test_no_memory(void)
+{
+	struct bpf_prog_info info = {};
+	__u32 info_len = sizeof(info);
+	struct arena_stack_nomem *skel;
+	char buf[256] = {};
+	int fd;
+
+	skel = arena_stack_nomem__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "open_and_load"))
+		return;
+	fd = bpf_program__fd(skel->progs.returns_1);
+	ASSERT_EQ(run_prog(fd), 0, "retval");
+	ASSERT_EQ(skel->bss->runs, 0, "runs");
+	ASSERT_OK(bpf_prog_get_info_by_fd(fd, &info, &info_len), "info");
+	ASSERT_EQ(info.recursion_misses, 1, "misses");
+	ASSERT_GT(bpf_prog_stream_read(fd, BPF_STREAM_STDERR, buf, sizeof(buf) - 1, NULL), 0,
+		  "stream_read");
+	ASSERT_HAS_SUBSTR(buf, "No memory for the stack in arena", "stderr");
+	arena_stack_nomem__destroy(skel);
+}
+
+void test_arena_stack(void)
+{
+	struct arena_stack *skel;
+
+#if !defined(__x86_64__) && !defined(__aarch64__)
+	/* other JITs don't support r12 */
+	test__skip();
+	return;
+#endif
+	skel = arena_stack__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "open_and_load"))
+		return;
+	if (test__start_subtest("preemption"))
+		test_preemption(skel);
+	if (test__start_subtest("nesting"))
+		test_nesting(skel);
+	if (test__start_subtest("attach_to_subprog"))
+		test_attach_to_subprog(skel);
+	if (test__start_subtest("timer"))
+		test_timer(skel);
+	if (test__start_subtest("throw"))
+		test_throw(skel);
+	arena_stack__destroy(skel);
+	if (test__start_subtest("jump_to_first_insn"))
+		test_jump_to_first_insn();
+	if (test__start_subtest("no_memory"))
+		test_no_memory();
+}
diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
index 643d67782619..089d8ea3f651 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
@@ -13,6 +13,7 @@
 #include "verifier_and.skel.h"
 #include "verifier_arena.skel.h"
 #include "verifier_arena_cast.skel.h"
+#include "verifier_arena_stack.skel.h"
 #include "verifier_arena_large.skel.h"
 #include "verifier_arena_globals1.skel.h"
 #include "verifier_arena_globals2.skel.h"
@@ -207,6 +208,7 @@ void test_verifier_align(void)                { RUN(verifier_align); }
 void test_verifier_and(void)                  { RUN(verifier_and); }
 void test_verifier_arena(void)                { RUN(verifier_arena); }
 void test_verifier_arena_cast(void)           { RUN(verifier_arena_cast); }
+void test_verifier_arena_stack(void)          { RUN_TESTS(verifier_arena_stack); }
 void test_verifier_arena_large(void)          { RUN(verifier_arena_large); }
 void test_verifier_arena_globals1(void)       { RUN(verifier_arena_globals1); }
 void test_verifier_arena_globals2(void)       { RUN(verifier_arena_globals2); }
diff --git a/tools/testing/selftests/bpf/progs/arena_noarena.c b/tools/testing/selftests/bpf/progs/arena_noarena.c
index 1f46e5aa403b..8a7ce3e36703 100644
--- a/tools/testing/selftests/bpf/progs/arena_noarena.c
+++ b/tools/testing/selftests/bpf/progs/arena_noarena.c
@@ -21,4 +21,18 @@ int arena_arg_no_arena(void *ctx)
 	return 0;
 }
 
+SEC("syscall")
+__arch_x86_64
+__arch_arm64
+__description("arena stack: no arena")
+__failure __msg("R12 can only be used in a program that has an associated arena")
+__naked void r12_no_arena(void)
+{
+	asm volatile (
+	".8byte 0xc1bf;"	/* r1 = r12 */
+	"r0 = 0;"
+	"exit;"
+	::: __clobber_all);
+}
+
 char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/arena_stack.c b/tools/testing/selftests/bpf/progs/arena_stack.c
new file mode 100644
index 000000000000..8c93e4cea71c
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/arena_stack.c
@@ -0,0 +1,334 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include "../../../include/linux/filter.h"
+#include "bpf_misc.h"
+
+extern void bpf_throw(__u64 cookie) __ksym;
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARENA);
+	__uint(map_flags, BPF_F_MMAPABLE);
+	__uint(max_entries, 4096);
+} arena SEC(".maps");
+
+/* BTF FUNC records are not generated for kfuncs referenced from inline assembly */
+void __kfunc_btf_root(void)
+{
+	bpf_throw(0);
+}
+
+/* Compilers don't know r12 yet */
+#define R12 12
+#define ADJ(n)		BPF_RAW_INSN(BPF_ALU64 | BPF_ADD | BPF_K, R12, 0, 0, n)
+#define LDX(dst, off)	BPF_RAW_INSN(BPF_LDX | BPF_MEM | BPF_DW, dst, R12, off, 0)
+#define STX(off, src)	BPF_RAW_INSN(BPF_STX | BPF_MEM | BPF_DW, R12, src, off, 0)
+#define ST(off, imm)	BPF_RAW_INSN(BPF_ST | BPF_MEM | BPF_DW, R12, 0, off, imm)
+
+/*
+ * Fill the frame, spin long enough to be preempted, check the frame.
+ * Returns the number of words that have changed.
+ */
+static __naked __noinline __used long spin(long seed)
+{
+	asm volatile (
+	".8byte %[adj];"
+	".8byte %[stx32];"
+	"r1 += 1;"
+	".8byte %[stx24];"
+	"r1 += 1;"
+	".8byte %[stx16];"
+	"r1 += 1;"
+	".8byte %[stx8];"
+	"r2 = 3000000;"
+"1:"
+	"r2 += -1;"
+	"if r2 != 0 goto 1b;"
+	"r0 = 0;"
+	".8byte %[ldx8];"
+	"if r2 == r1 goto +1;"
+	"r0 += 1;"
+	"r1 -= 1;"
+	".8byte %[ldx16];"
+	"if r2 == r1 goto +1;"
+	"r0 += 1;"
+	"r1 -= 1;"
+	".8byte %[ldx24];"
+	"if r2 == r1 goto +1;"
+	"r0 += 1;"
+	"r1 -= 1;"
+	".8byte %[ldx32];"
+	"if r2 == r1 goto +1;"
+	"r0 += 1;"
+	"exit;"
+	:
+	: __imm_insn(adj, ADJ(32)),
+	  __imm_insn(stx32, STX(-32, BPF_REG_1)),
+	  __imm_insn(stx24, STX(-24, BPF_REG_1)),
+	  __imm_insn(stx16, STX(-16, BPF_REG_1)),
+	  __imm_insn(stx8, STX(-8, BPF_REG_1)),
+	  __imm_insn(ldx32, LDX(BPF_REG_2, -32)),
+	  __imm_insn(ldx24, LDX(BPF_REG_2, -24)),
+	  __imm_insn(ldx16, LDX(BPF_REG_2, -16)),
+	  __imm_insn(ldx8, LDX(BPF_REG_2, -8))
+	: __clobber_all);
+}
+
+/* the same, one frame deeper */
+static __naked __noinline __used long spin_deeper(long seed)
+{
+	asm volatile (
+	".8byte %[adj];"
+	".8byte %[stx];"
+	"r6 = r1;"
+	"r1 += 100;"
+	"call spin;"
+	".8byte %[ldx];"
+	"if r1 == r6 goto +1;"
+	"r0 += 1;"
+	"exit;"
+	:
+	: __imm_insn(adj, ADJ(128)),
+	  __imm_insn(stx, STX(-64, BPF_REG_1)),
+	  __imm_insn(ldx, LDX(BPF_REG_1, -64))
+	: __clobber_all);
+}
+
+SEC("syscall")
+__naked int preempted(void)
+{
+	asm volatile (
+	".8byte %[adj];"
+	"call %[bpf_get_prandom_u32];"
+	"r6 = r0;"
+	".8byte %[stx];"
+	"r1 = r6;"
+	"if r6 & 1 goto 1f;"
+	"call spin;"
+	"goto 2f;"
+"1:"
+	"call spin_deeper;"
+"2:"
+	".8byte %[ldx];"
+	"if r1 == r6 goto +1;"
+	"r0 += 1;"
+	"exit;"
+	:
+	: __imm(bpf_get_prandom_u32),
+	  __imm_insn(adj, ADJ(16)),
+	  __imm_insn(stx, STX(-16, BPF_REG_6)),
+	  __imm_insn(ldx, LDX(BPF_REG_1, -16))
+	: __clobber_all);
+}
+
+static long thrower(void);
+
+/* The same with preemption disabled. Programs in interrupts nest. */
+SEC("tc")
+__naked int interrupted(void)
+{
+	asm volatile (
+	".8byte %[adj];"
+	"call %[bpf_get_prandom_u32];"
+	"r6 = r0;"
+	".8byte %[stx];"
+	"r1 = r6;"
+	"call spin_deeper;"
+	".8byte %[ldx];"
+	"if r1 == r6 goto +1;"
+	"r0 += 1;"
+	"exit;"
+	:
+	: __imm(bpf_get_prandom_u32),
+	  __imm_insn(adj, ADJ(16)),
+	  __imm_insn(stx, STX(-16, BPF_REG_6)),
+	  __imm_insn(ldx, LDX(BPF_REG_1, -16))
+	: __clobber_all);
+}
+
+long interrupts;
+
+static __naked __noinline __used long scribble(void)
+{
+	asm volatile (
+	".8byte %[adj];"
+	".8byte %[st128];"
+	".8byte %[st64];"
+	".8byte %[st8];"
+	"r0 = 0;"
+	"exit;"
+	:
+	: __imm_insn(adj, ADJ(128)),
+	  __imm_insn(st128, ST(-128, -1)),
+	  __imm_insn(st64, ST(-64, -1)),
+	  __imm_insn(st8, ST(-8, -1))
+	: __clobber_all);
+}
+
+SEC("perf_event")
+__naked int in_interrupt(void)
+{
+	asm volatile (
+	".8byte %[adj];"
+	".8byte %[st32];"
+	".8byte %[st8];"
+	"call scribble;"
+	"r1 = %[interrupts] ll;"
+	"r2 = 1;"
+	"lock *(u64 *)(r1 + 0) += r2;"
+	"r0 = 0;"
+	"exit;"
+	:
+	: __imm_addr(interrupts),
+	  __imm_insn(adj, ADJ(32)),
+	  __imm_insn(st32, ST(-32, -1)),
+	  __imm_insn(st8, ST(-8, -1))
+	: __clobber_all);
+}
+
+SEC("tc")
+__naked int throws_nested(void)
+{
+	asm volatile (
+	".8byte %[adj];"
+	"call thrower;"
+	"exit;"
+	:
+	: __imm_insn(adj, ADJ(16))
+	: __clobber_all);
+}
+
+SEC("tc")
+__naked int returns_8_nested(void)
+{
+	asm volatile (
+	".8byte %[adj];"
+	".8byte %[st];"
+	".8byte %[ldx];"
+	"exit;"
+	:
+	: __imm_insn(adj, ADJ(16)),
+	  __imm_insn(st, ST(-16, 8)),
+	  __imm_insn(ldx, LDX(BPF_REG_0, -16))
+	: __clobber_all);
+}
+
+static __naked __noinline __used long thrower(void)
+{
+	asm volatile (
+	".8byte %[adj];"
+	"r1 = 5;"
+	"call %[bpf_throw];"
+	"r0 = 0;"
+	"exit;"
+	:
+	: __imm(bpf_throw),
+	  __imm_insn(adj, ADJ(64))
+	: __clobber_all);
+}
+
+SEC("syscall")
+__naked int throws(void)
+{
+	asm volatile (
+	".8byte %[adj];"
+	"call thrower;"
+	"exit;"
+	:
+	: __imm_insn(adj, ADJ(16))
+	: __clobber_all);
+}
+
+static __naked __noinline __used long returns_7(void)
+{
+	asm volatile (
+	".8byte %[adj];"
+	".8byte %[st];"
+	".8byte %[ldx];"
+	"exit;"
+	:
+	: __imm_insn(adj, ADJ(16)),
+	  __imm_insn(st, ST(-16, 7)),
+	  __imm_insn(ldx, LDX(BPF_REG_0, -16))
+	: __clobber_all);
+}
+
+SEC("syscall")
+__naked int prog_returns_7(void)
+{
+	asm volatile (
+	".8byte %[adj];"
+	".8byte %[st];"
+	".8byte %[ldx];"
+	"exit;"
+	:
+	: __imm_insn(adj, ADJ(16)),
+	  __imm_insn(st, ST(-16, 7)),
+	  __imm_insn(ldx, LDX(BPF_REG_0, -16))
+	: __clobber_all);
+}
+
+struct elem {
+	struct bpf_timer t;
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, 1);
+	__type(key, int);
+	__type(value, struct elem);
+} timers SEC(".maps");
+
+long timer_runs, timer_bad;
+
+/* The kernel calls it. Fill the frame, call a function that has a frame, check the frame. */
+static __naked __noinline __used int timer_cb(void *map, int *key, struct elem *val)
+{
+	asm volatile (
+	".8byte %[adj];"
+	".8byte %[st32];"
+	".8byte %[st8];"
+	"call returns_7;"
+	".8byte %[ldx32];"
+	".8byte %[ldx8];"
+	"r1 += r2;"
+	"r1 += r0;"
+	"r2 = %[timer_runs] ll;"
+	"r3 = 1;"
+	"lock *(u64 *)(r2 + 0) += r3;"
+	"if r1 == 49 goto 1f;"
+	"r2 = %[timer_bad] ll;"
+	"lock *(u64 *)(r2 + 0) += r3;"
+"1:"
+	"r0 = 0;"
+	"exit;"
+	:
+	: __imm_addr(timer_runs),
+	  __imm_addr(timer_bad),
+	  __imm_insn(adj, ADJ(32)),
+	  __imm_insn(st32, ST(-32, 11)),
+	  __imm_insn(st8, ST(-8, 31)),
+	  __imm_insn(ldx32, LDX(BPF_REG_1, -32)),
+	  __imm_insn(ldx8, LDX(BPF_REG_2, -8))
+	: __clobber_all);
+}
+
+SEC("syscall")
+int start_timer(void *ctx)
+{
+	struct elem *e;
+	int key = 0;
+
+	/* the program has to have an arena */
+	asm volatile ("" :: "r"(&arena));
+	e = bpf_map_lookup_elem(&timers, &key);
+	if (!e)
+		return 2;
+	bpf_timer_init(&e->t, &timers, 1 /* CLOCK_MONOTONIC */);
+	if (bpf_timer_set_callback(&e->t, timer_cb))
+		return 3;
+	return bpf_timer_start(&e->t, 0, 0) ? 4 : 0;
+}
+
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/arena_stack_fentry.c b/tools/testing/selftests/bpf/progs/arena_stack_fentry.c
new file mode 100644
index 000000000000..4dd870c51166
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/arena_stack_fentry.c
@@ -0,0 +1,13 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+SEC("fentry")
+int BPF_PROG(on_entry)
+{
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/arena_stack_loop.c b/tools/testing/selftests/bpf/progs/arena_stack_loop.c
new file mode 100644
index 000000000000..da88baf64cee
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/arena_stack_loop.c
@@ -0,0 +1,52 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include "../../../include/linux/filter.h"
+#include "bpf_misc.h"
+
+/* A stack that is not returned is noticed soon */
+struct {
+	__uint(type, BPF_MAP_TYPE_ARENA);
+	__uint(map_flags, BPF_F_MMAPABLE);
+	__uint(max_entries, 8);
+} arena SEC(".maps");
+
+static __naked __noinline __used long returns_7(void)
+{
+	asm volatile (
+	".8byte %[adj];"	/* r12 += 16 */
+	".8byte %[st];"		/* *(u64 *)(r12 - 8) = 7 */
+	".8byte %[ldx];"	/* r0 = *(u64 *)(r12 - 8) */
+	"exit;"
+	:
+	: __imm_insn(adj, BPF_RAW_INSN(BPF_ALU64 | BPF_ADD | BPF_K, 12, 0, 0, 16)),
+	  __imm_insn(st, BPF_RAW_INSN(BPF_ST | BPF_MEM | BPF_DW, 12, 0, -8, 7)),
+	  __imm_insn(ldx, BPF_RAW_INSN(BPF_LDX | BPF_MEM | BPF_DW, 0, 12, -8, 0))
+	: __clobber_all);
+}
+
+/* r1 is ctx, then 0: one jump to the first insn of the program */
+#define LOOP					\
+"1:"						\
+	"if r1 == 0 goto 2f;"			\
+	"r1 = 0;"				\
+	"goto 1b;"				\
+"2:"						\
+	"call returns_7;"			\
+	"exit;"
+
+SEC("tc")
+__naked int loop(void)
+{
+	asm volatile (LOOP ::: __clobber_all);
+}
+
+/* the same after the nop is removed */
+SEC("tc")
+__naked int nop_loop(void)
+{
+	asm volatile ("goto +0;" LOOP ::: __clobber_all);
+}
+
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/arena_stack_nomem.c b/tools/testing/selftests/bpf/progs/arena_stack_nomem.c
new file mode 100644
index 000000000000..dddeae3ea7ce
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/arena_stack_nomem.c
@@ -0,0 +1,32 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include "../../../include/linux/filter.h"
+#include "bpf_misc.h"
+
+/* one page, the program needs two */
+struct {
+	__uint(type, BPF_MAP_TYPE_ARENA);
+	__uint(map_flags, BPF_F_MMAPABLE);
+	__uint(max_entries, 1);
+} arena SEC(".maps");
+
+int runs;
+
+SEC("syscall")
+__naked int returns_1(void)
+{
+	asm volatile (
+	".8byte %[adj];"	/* r12 += 32768 */
+	"r1 = %[runs] ll;"
+	"r0 = 1;"
+	"*(u32 *)(r1 + 0) = r0;"
+	"exit;"
+	:
+	: __imm_addr(runs),
+	  __imm_insn(adj, BPF_RAW_INSN(BPF_ALU64 | BPF_ADD | BPF_K, 12, 0, 0, 32768))
+	: __clobber_all);
+}
+
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/verifier_arena_stack.c b/tools/testing/selftests/bpf/progs/verifier_arena_stack.c
new file mode 100644
index 000000000000..79a4552f1a93
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_arena_stack.c
@@ -0,0 +1,635 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include "../../../include/linux/filter.h"
+#include "bpf_misc.h"
+
+#if defined(__TARGET_ARCH_x86) || defined(__TARGET_ARCH_arm64)
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARENA);
+	__uint(map_flags, BPF_F_MMAPABLE);
+	__uint(max_entries, 64);
+} arena SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_PROG_ARRAY);
+	__uint(max_entries, 1);
+	__uint(key_size, sizeof(int));
+	__uint(value_size, sizeof(int));
+} jmp_table SEC(".maps");
+
+/* Compilers don't know r12 yet */
+#define R12 12
+/* r12 += n */
+#define ADJ(n)		BPF_RAW_INSN(BPF_ALU64 | BPF_ADD | BPF_K, R12, 0, 0, n)
+/* dst = r12 */
+#define MOV(dst)	BPF_RAW_INSN(BPF_ALU64 | BPF_MOV | BPF_X, dst, R12, 0, 0)
+/* dst = *(sz *)(r12 + off) */
+#define LDX(sz, dst, off) BPF_RAW_INSN(BPF_LDX | BPF_MEM | sz, dst, R12, off, 0)
+#define LDSX(sz, dst, off) BPF_RAW_INSN(BPF_LDX | BPF_MEMSX | sz, dst, R12, off, 0)
+/* *(sz *)(r12 + off) = src */
+#define STX(sz, off, src) BPF_RAW_INSN(BPF_STX | BPF_MEM | sz, R12, src, off, 0)
+/* *(sz *)(r12 + off) = imm */
+#define ST(sz, off, imm) BPF_RAW_INSN(BPF_ST | BPF_MEM | sz, R12, 0, off, imm)
+/* dst = addr_space_cast(dst, 0, 1) */
+#define CAST_KERN(dst)	BPF_RAW_INSN(BPF_ALU64 | BPF_MOV | BPF_X, dst, dst, BPF_ADDR_SPACE_CAST, 1)
+
+SEC("syscall")
+__description("arena stack: load and store")
+__success __retval(12)
+__xlated("r0 = *(u64 *)(r12 -16)")
+__xlated("r2 = *(u64 *)(r12 -8)")
+__naked void load_store(void)
+{
+	asm volatile (
+	".8byte %[adj];"
+	".8byte %[st];"		/* *(u64 *)(r12 - 16) = 7 */
+	"r1 = 5;"
+	".8byte %[stx];"	/* *(u64 *)(r12 - 8) = r1 */
+	".8byte %[ldx0];"	/* r0 = *(u64 *)(r12 - 16) */
+	".8byte %[ldx1];"	/* r2 = *(u64 *)(r12 - 8) */
+	"r0 += r2;"
+	"exit;"
+	:
+	: __imm_insn(adj, ADJ(16)),
+	  __imm_insn(st, ST(BPF_DW, -16, 7)),
+	  __imm_insn(stx, STX(BPF_DW, -8, BPF_REG_1)),
+	  __imm_insn(ldx0, LDX(BPF_DW, BPF_REG_0, -16)),
+	  __imm_insn(ldx1, LDX(BPF_DW, BPF_REG_2, -8))
+	: __clobber_all);
+}
+
+SEC("syscall")
+__description("arena stack: every size, sign extension")
+__success __retval(0)
+__naked void sizes(void)
+{
+	asm volatile (
+	".8byte %[adj];"
+	"r1 = 0x8899aabb ll;"
+	".8byte %[stx];"	/* *(u64 *)(r12 - 16) = r1 */
+	"r0 = 1;"
+	".8byte %[ldx_b];"
+	"if r2 != 0xbb goto 1f;"
+	"r0 = 2;"
+	".8byte %[ldx_h];"
+	"if r2 != 0xaabb goto 1f;"
+	"r0 = 3;"
+	".8byte %[ldx_w];"
+	"r3 = 0x8899aabb ll;"
+	"if r2 != r3 goto 1f;"
+	"r0 = 4;"
+	".8byte %[ldsx_w];"
+	"if r2 s>= 0 goto 1f;"
+	"r0 = 5;"
+	".8byte %[st_b];"	/* *(u8 *)(r12 - 15) = 0 */
+	".8byte %[ldx_h];"
+	"if r2 != 0xbb goto 1f;"
+	"r0 = 0;"
+"1:"
+	"exit;"
+	:
+	: __imm_insn(adj, ADJ(16)),
+	  __imm_insn(stx, STX(BPF_DW, -16, BPF_REG_1)),
+	  __imm_insn(ldx_b, LDX(BPF_B, BPF_REG_2, -16)),
+	  __imm_insn(ldx_h, LDX(BPF_H, BPF_REG_2, -16)),
+	  __imm_insn(ldx_w, LDX(BPF_W, BPF_REG_2, -16)),
+	  __imm_insn(ldsx_w, LDSX(BPF_W, BPF_REG_2, -16)),
+	  __imm_insn(st_b, ST(BPF_B, -15, 0))
+	: __clobber_all);
+}
+
+SEC("syscall")
+__description("arena stack: rX = r12 is the address of the frame")
+__success __retval(9)
+__naked void address(void)
+{
+	asm volatile (
+	".8byte %[adj];"
+	".8byte %[mov];"	/* r1 = r12 */
+	"r1 += -8;"
+	".8byte %[cast];"
+	"r2 = 9;"
+	"*(u64 *)(r1 + 0) = r2;"
+	".8byte %[ldx];"	/* r0 = *(u64 *)(r12 - 8) */
+	"exit;"
+	:
+	: __imm_insn(adj, ADJ(16)),
+	  __imm_insn(mov, MOV(BPF_REG_1)),
+	  __imm_insn(cast, CAST_KERN(BPF_REG_1)),
+	  __imm_insn(ldx, LDX(BPF_DW, BPF_REG_0, -8))
+	: __clobber_all);
+}
+
+static __naked __noinline __used long callee_with_frame(void)
+{
+	asm volatile (
+	".8byte %[adj];"
+	".8byte %[st0];"
+	".8byte %[st1];"
+	".8byte %[ldx];"
+	"exit;"
+	:
+	: __imm_insn(adj, ADJ(16)),
+	  __imm_insn(st0, ST(BPF_DW, -16, 10)),
+	  __imm_insn(st1, ST(BPF_DW, -8, 10)),
+	  __imm_insn(ldx, LDX(BPF_DW, BPF_REG_0, -16))
+	: __clobber_all);
+}
+
+SEC("syscall")
+__description("arena stack: the frame of the callee is above")
+__success __retval(21)
+__naked void call(void)
+{
+	asm volatile (
+	".8byte %[adj];"
+	".8byte %[st];"		/* *(u64 *)(r12 - 16) = 1 */
+	"call callee_with_frame;"
+	"r6 = r0;"
+	"call callee_with_frame;"
+	"r0 += r6;"
+	".8byte %[ldx];"	/* r1 = *(u64 *)(r12 - 16) */
+	"r0 += r1;"
+	"exit;"
+	:
+	: __imm_insn(adj, ADJ(16)),
+	  __imm_insn(st, ST(BPF_DW, -16, 1)),
+	  __imm_insn(ldx, LDX(BPF_DW, BPF_REG_1, -16))
+	: __clobber_all);
+}
+
+/* no frame of its own, r12 goes through */
+static __naked __noinline __used long callee_in_the_middle(void)
+{
+	asm volatile (
+	"call %[bpf_get_prandom_u32];"
+	"call callee_with_frame;"
+	"exit;"
+	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+SEC("syscall")
+__description("arena stack: a function without a frame in the middle")
+__success __retval(11)
+__naked void call_through(void)
+{
+	asm volatile (
+	".8byte %[adj];"
+	".8byte %[st];"
+	"call callee_in_the_middle;"
+	".8byte %[ldx];"
+	"r0 += r1;"
+	"exit;"
+	:
+	: __imm_insn(adj, ADJ(16)),
+	  __imm_insn(st, ST(BPF_DW, -16, 1)),
+	  __imm_insn(ldx, LDX(BPF_DW, BPF_REG_1, -16))
+	: __clobber_all);
+}
+
+SEC("syscall")
+__description("arena stack: helpers don't change r12")
+__success __retval(3)
+__naked void helper(void)
+{
+	asm volatile (
+	".8byte %[adj];"
+	".8byte %[st];"
+	"call %[bpf_get_prandom_u32];"
+	"call %[bpf_ktime_get_ns];"
+	".8byte %[ldx];"
+	"exit;"
+	:
+	: __imm(bpf_get_prandom_u32),
+	  __imm(bpf_ktime_get_ns),
+	  __imm_insn(adj, ADJ(16)),
+	  __imm_insn(st, ST(BPF_DW, -16, 3)),
+	  __imm_insn(ldx, LDX(BPF_DW, BPF_REG_0, -16))
+	: __clobber_all);
+}
+
+static __naked __noinline __used long store_through(long addr)
+{
+	asm volatile (
+	".8byte %[adj];"
+	".8byte %[st];"
+	".8byte %[cast];"
+	"r2 = 5;"
+	"*(u64 *)(r1 + 0) = r2;"
+	"r0 = 0;"
+	"exit;"
+	:
+	: __imm_insn(adj, ADJ(64)),
+	  __imm_insn(st, ST(BPF_DW, -64, 77)),
+	  __imm_insn(cast, CAST_KERN(BPF_REG_1))
+	: __clobber_all);
+}
+
+SEC("syscall")
+__description("arena stack: the callee writes to the frame of the caller")
+__success __retval(5)
+__naked void pass_address(void)
+{
+	asm volatile (
+	".8byte %[adj];"
+	".8byte %[mov];"
+	"r1 += -16;"
+	"call store_through;"
+	".8byte %[ldx];"
+	"exit;"
+	:
+	: __imm_insn(adj, ADJ(16)),
+	  __imm_insn(mov, MOV(BPF_REG_1)),
+	  __imm_insn(ldx, LDX(BPF_DW, BPF_REG_0, -16))
+	: __clobber_all);
+}
+
+static __naked __noinline __used long unwinds(void)
+{
+	asm volatile (
+	".8byte %[adj];"
+	".8byte %[st];"
+	"r0 = 0;"
+	".8byte %[unwind_exit];"
+	:
+	: __imm_insn(adj, ADJ(32)),
+	  __imm_insn(st, ST(BPF_DW, -32, -1)),
+	  __imm_insn(unwind_exit, BPF_RAW_INSN(BPF_JMP | BPF_EXIT, 0, BPF_UNWIND_EXIT, 0, 0))
+	: __clobber_all);
+}
+
+/* its pad only carries on */
+static __naked __noinline __used long unwinds_through(void)
+{
+	asm volatile (
+	".8byte %[adj];"
+	"call unwinds;"
+	".8byte %[unwind_goto];"
+	"r0 = 0;"
+	"exit;"
+	".8byte %[unwind_exit];"
+	:
+	: __imm_insn(adj, ADJ(16)),
+	  __imm_insn(unwind_goto, BPF_RAW_INSN(BPF_JMP | BPF_JCOND, 0, BPF_UNWIND_GOTO, 2, 0)),
+	  __imm_insn(unwind_exit, BPF_RAW_INSN(BPF_JMP | BPF_EXIT, 0, BPF_UNWIND_EXIT, 0, 0))
+	: __clobber_all);
+}
+
+SEC("syscall")
+__description("arena stack: r12 in the landing pad")
+__success __retval(5)
+__naked void unwind(void)
+{
+	asm volatile (
+	".8byte %[adj];"
+	".8byte %[st];"		/* *(u64 *)(r12 - 16) = 5 */
+	"call unwinds_through;"
+	".8byte %[unwind_goto];"
+	"r0 = 1;"
+	"exit;"
+	".8byte %[ldx];"	/* r0 = *(u64 *)(r12 - 16) */
+	"exit;"
+	:
+	: __imm_insn(adj, ADJ(16)),
+	  __imm_insn(st, ST(BPF_DW, -16, 5)),
+	  __imm_insn(unwind_goto, BPF_RAW_INSN(BPF_JMP | BPF_JCOND, 0, BPF_UNWIND_GOTO, 2, 0)),
+	  __imm_insn(ldx, LDX(BPF_DW, BPF_REG_0, -16))
+	: __clobber_all);
+}
+
+#ifdef __BPF_FEATURE_STACK_ARGUMENT
+
+extern __u64 bpf_kfunc_call_stack_arg(__u64 a, __u64 b, __u64 c, __u64 d, __u64 e, __u64 f,
+				      __u64 g, __u64 h, __u64 i, __u64 j) __ksym;
+
+/* BTF FUNC records are not generated for kfuncs referenced from inline assembly */
+void __kfunc_btf_root(void)
+{
+	bpf_kfunc_call_stack_arg(0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
+}
+
+static __naked __noinline __used
+long callee_7args(long a, long b, long c, long d, long e, long f, long g)
+{
+	asm volatile (
+	".8byte %[adj];"
+	"r0 = *(u64 *)(r11 + 8);"
+	".8byte %[stx0];"	/* *(u64 *)(r12 - 16) = f */
+	"r0 = *(u64 *)(r11 + 16);"
+	".8byte %[stx8];"	/* *(u64 *)(r12 - 8) = g */
+	"r6 = r5;"
+	"call %[bpf_get_prandom_u32];"
+	".8byte %[ldx0];"
+	".8byte %[ldx8];"
+	"r0 *= 10;"
+	"r0 += r1;"
+	"r0 *= 10;"
+	"r0 += r6;"
+	"exit;"
+	:
+	: __imm(bpf_get_prandom_u32),
+	  __imm_insn(adj, ADJ(16)),
+	  __imm_insn(stx0, STX(BPF_DW, -16, BPF_REG_0)),
+	  __imm_insn(stx8, STX(BPF_DW, -8, BPF_REG_0)),
+	  __imm_insn(ldx0, LDX(BPF_DW, BPF_REG_0, -16)),
+	  __imm_insn(ldx8, LDX(BPF_DW, BPF_REG_1, -8))
+	: __clobber_all);
+}
+
+SEC("syscall")
+__description("arena stack: a function with 7 arguments")
+__success __retval(1675)
+__naked void stack_args(void)
+{
+	asm volatile (
+	".8byte %[adj];"
+	".8byte %[st];"		/* *(u64 *)(r12 - 16) = 1000 */
+	"r1 = 1;"
+	"r2 = 2;"
+	"r3 = 3;"
+	"r4 = 4;"
+	"r5 = 5;"
+	"*(u64 *)(r11 - 16) = 7;"
+	"*(u64 *)(r11 - 8) = 6;"
+	"call callee_7args;"
+	".8byte %[ldx];"
+	"r0 += r1;"
+	"exit;"
+	:
+	: __imm_insn(adj, ADJ(16)),
+	  __imm_insn(st, ST(BPF_DW, -16, 1000)),
+	  __imm_insn(ldx, LDX(BPF_DW, BPF_REG_1, -16))
+	: __clobber_all);
+}
+
+SEC("tc")
+__description("arena stack: a kfunc with 10 arguments")
+__success __retval(1055)
+__naked void kfunc_stack_args(void)
+{
+	asm volatile (
+	".8byte %[adj];"
+	".8byte %[st];"		/* *(u64 *)(r12 - 16) = 1000 */
+	"r1 = 1;"
+	"r2 = 2;"
+	"r3 = 3;"
+	"r4 = 4;"
+	"r5 = 5;"
+	"*(u64 *)(r11 - 40) = 10;"
+	"*(u64 *)(r11 - 32) = 9;"
+	"*(u64 *)(r11 - 24) = 8;"
+	"*(u64 *)(r11 - 16) = 7;"
+	"*(u64 *)(r11 - 8) = 6;"
+	"call %[bpf_kfunc_call_stack_arg];"
+	".8byte %[ldx];"
+	"r0 += r1;"
+	"exit;"
+	:
+	: __imm(bpf_kfunc_call_stack_arg),
+	  __imm_insn(adj, ADJ(16)),
+	  __imm_insn(st, ST(BPF_DW, -16, 1000)),
+	  __imm_insn(ldx, LDX(BPF_DW, BPF_REG_1, -16))
+	: __clobber_all);
+}
+
+#endif /* __BPF_FEATURE_STACK_ARGUMENT */
+
+SEC("syscall")
+__description("arena stack: what is loaded is a number")
+__failure __msg("R1 invalid mem access 'scalar'")
+__naked void loaded_is_number(void)
+{
+	asm volatile (
+	".8byte %[adj];"
+	"r1 = r10;"
+	".8byte %[stx];"
+	".8byte %[ldx];"
+	"r0 = *(u64 *)(r1 - 8);"
+	"exit;"
+	:
+	: __imm_insn(adj, ADJ(16)),
+	  __imm_insn(stx, STX(BPF_DW, -16, BPF_REG_1)),
+	  __imm_insn(ldx, LDX(BPF_DW, BPF_REG_1, -16))
+	: __clobber_all);
+}
+
+SEC("syscall")
+__description("arena stack: rX = r12 is a number")
+__failure __msg("R1 invalid mem access 'scalar'")
+__naked void address_is_number(void)
+{
+	asm volatile (
+	".8byte %[adj];"
+	".8byte %[mov];"
+	"r0 = *(u64 *)(r1 + 0);"
+	"exit;"
+	:
+	: __imm_insn(adj, ADJ(16)),
+	  __imm_insn(mov, MOV(BPF_REG_1))
+	: __clobber_all);
+}
+
+#define BAD_INSN(name, desc, msg, first, second)			\
+SEC("syscall")								\
+__description("arena stack: " desc)					\
+__failure __msg(msg)							\
+__naked void name(void)							\
+{									\
+	asm volatile (							\
+	".8byte %[first_insn];"						\
+	".8byte %[second_insn];"					\
+	"r0 = 0;"							\
+	"exit;"								\
+	:								\
+	: __imm_insn(first_insn, first),				\
+	  __imm_insn(second_insn, second)				\
+	: __clobber_all);						\
+}
+
+#define NOP BPF_MOV64_IMM(BPF_REG_1, 0)
+
+BAD_INSN(adj_not_first, "r12 += 16 is not the first insn",
+	 "R12 can be changed by the first insn of a function only", NOP, ADJ(16))
+BAD_INSN(adj_twice, "r12 += 16 twice",
+	 "R12 can be changed by the first insn of a function only", ADJ(16), ADJ(16))
+BAD_INSN(adj_negative, "r12 += -16", "invalid size of the frame", ADJ(-16), NOP)
+BAD_INSN(adj_zero, "r12 += 0", "invalid size of the frame", ADJ(0), NOP)
+BAD_INSN(adj_unaligned, "r12 += 8", "invalid size of the frame", ADJ(8), NOP)
+BAD_INSN(adj_large, "r12 += 32784", "invalid size of the frame", ADJ(32784), NOP)
+BAD_INSN(mov_to, "r12 = r1", "R12 is invalid", NOP, BPF_MOV64_REG(R12, BPF_REG_1))
+BAD_INSN(mov_imm, "r12 = 0", "R12 is invalid", NOP, BPF_MOV64_IMM(R12, 0))
+BAD_INSN(add_reg, "r12 += r1", "R12 is invalid", NOP, BPF_ALU64_REG(BPF_ADD, R12, BPF_REG_1))
+BAD_INSN(adj32, "w12 += 16", "R12 is invalid", BPF_ALU32_IMM(BPF_ADD, R12, 16), NOP)
+BAD_INSN(sub_imm, "r12 -= 16", "R12 is invalid", BPF_ALU64_IMM(BPF_SUB, R12, 16), NOP)
+BAD_INSN(add_from, "r1 += r12", "R12 is invalid", NOP, BPF_ALU64_REG(BPF_ADD, BPF_REG_1, R12))
+BAD_INSN(mov32_from, "w1 = w12", "R12 is invalid", NOP, BPF_MOV32_REG(BPF_REG_1, R12))
+BAD_INSN(load_to, "r12 = *(u64 *)(r10 - 8)", "R12 is invalid", NOP,
+	 BPF_LDX_MEM(BPF_DW, R12, BPF_REG_10, -8))
+BAD_INSN(store_from, "*(u64 *)(r10 - 8) = r12", "R12 is invalid", NOP,
+	 BPF_STX_MEM(BPF_DW, BPF_REG_10, R12, -8))
+BAD_INSN(store_itself, "*(u64 *)(r12 - 8) = r12", "R12 is invalid", NOP,
+	 BPF_STX_MEM(BPF_DW, R12, R12, -8))
+BAD_INSN(atomic, "lock *(u64 *)(r12 - 8) += r1", "R12 is invalid", NOP,
+	 BPF_ATOMIC_OP(BPF_DW, BPF_ADD, R12, BPF_REG_1, -8))
+BAD_INSN(jump, "if r12 == 0 goto", "R12 is invalid", NOP, BPF_JMP_IMM(BPF_JEQ, R12, 0, 0))
+BAD_INSN(r13, "r1 = r13", "R13 is invalid", NOP, BPF_MOV64_REG(BPF_REG_1, 13))
+BAD_INSN(local_atomic, "atomic that is local to the cpu", "BPF_ATOMIC uses invalid atomic opcode",
+	 BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
+	 BPF_ATOMIC_OP(BPF_DW, BPF_ADD | BPF_FETCH | 0x1000, BPF_REG_10, BPF_REG_1, -8))
+
+SEC("syscall")
+__description("arena stack: jump to r12 += 16")
+__failure __msg("jump to the insn that changes R12")
+__naked void jump_to_adj(void)
+{
+	asm volatile (
+"1:"
+	".8byte %[adj];"
+	"call %[bpf_get_prandom_u32];"
+	"if r0 != 0 goto 1b;"
+	"exit;"
+	:
+	: __imm(bpf_get_prandom_u32),
+	  __imm_insn(adj, ADJ(16))
+	: __clobber_all);
+}
+
+/* adds the index and what the context points to, through its frame */
+static __naked __noinline __used long loop_cb(void)
+{
+	asm volatile (
+	".8byte %[adj];"
+	".8byte %[stx16];"	/* *(u64 *)(r12 - 16) = r1 */
+	"r4 = *(u64 *)(r2 + 0);"
+	".8byte %[ldx16];"	/* r5 = *(u64 *)(r12 - 16) */
+	"r4 += r5;"
+	"*(u64 *)(r2 + 0) = r4;"
+	"r0 = 0;"
+	"exit;"
+	:
+	: __imm_insn(adj, ADJ(16)),
+	  __imm_insn(stx16, STX(BPF_DW, -16, BPF_REG_1)),
+	  __imm_insn(ldx16, LDX(BPF_DW, BPF_REG_5, -16))
+	: __clobber_all);
+}
+
+SEC("syscall")
+__description("arena stack: r12 in a callback")
+__success __retval(145)
+__naked void callback(void)
+{
+	asm volatile (
+	".8byte %[adj];"
+	".8byte %[st];"		/* *(u64 *)(r12 - 8) = 100 */
+	"r1 = 0;"
+	"*(u64 *)(r10 - 8) = r1;"
+	"r1 = 10;"
+	"r2 = loop_cb ll;"
+	"r3 = r10;"
+	"r3 += -8;"
+	"r4 = 0;"
+	"call %[bpf_loop];"
+	/* 0 + 1 + ... + 9 and what is in the frame of the main program */
+	"r0 = *(u64 *)(r10 - 8);"
+	".8byte %[ldx];"	/* r1 = *(u64 *)(r12 - 8) */
+	"r0 += r1;"
+	"exit;"
+	:
+	: __imm(bpf_loop),
+	  __imm_insn(adj, ADJ(16)),
+	  __imm_insn(st, ST(BPF_DW, -8, 100)),
+	  __imm_insn(ldx, LDX(BPF_DW, BPF_REG_1, -8))
+	: __clobber_all);
+}
+
+SEC("tc")
+__description("arena stack: tail call")
+__failure __msg("tail_calls are not allowed in programs that use R12")
+__naked void tail_call(void)
+{
+	asm volatile (
+	".8byte %[adj];"
+	"r2 = %[jmp_table] ll;"
+	"r3 = 0;"
+	"call %[bpf_tail_call];"
+	"r0 = 0;"
+	"exit;"
+	:
+	: __imm(bpf_tail_call),
+	  __imm_addr(jmp_table),
+	  __imm_insn(adj, ADJ(16))
+	: __clobber_all);
+}
+
+static __naked __noinline __used long frame_16(void)
+{
+	asm volatile (
+	".8byte %[adj];"
+	"r0 = 0;"
+	"exit;"
+	:
+	: __imm_insn(adj, ADJ(16))
+	: __clobber_all);
+}
+
+static __naked __noinline __used long frame_16k_calls_16(void)
+{
+	asm volatile (
+	".8byte %[adj];"
+	"call frame_16;"
+	"exit;"
+	:
+	: __imm_insn(adj, ADJ(16384))
+	: __clobber_all);
+}
+
+static __naked __noinline __used long frame_16k(void)
+{
+	asm volatile (
+	".8byte %[adj];"
+	".8byte %[st];"
+	".8byte %[ldx];"
+	"exit;"
+	:
+	: __imm_insn(adj, ADJ(16384)),
+	  __imm_insn(st, ST(BPF_DW, -16384, 4)),
+	  __imm_insn(ldx, LDX(BPF_DW, BPF_REG_0, -16384))
+	: __clobber_all);
+}
+
+SEC("syscall")
+__description("arena stack: 32K")
+__success __retval(4)
+__naked void depth_max(void)
+{
+	asm volatile (
+	".8byte %[adj];"
+	"call frame_16k;"
+	"exit;"
+	:
+	: __imm_insn(adj, ADJ(16384))
+	: __clobber_all);
+}
+
+SEC("syscall")
+__description("arena stack: more than 32K")
+__failure __msg("combined size of the frames in the stack in arena is 32784. Too large")
+__naked void depth_too_large(void)
+{
+	asm volatile (
+	".8byte %[adj];"
+	"call frame_16k_calls_16;"
+	"exit;"
+	:
+	: __imm_insn(adj, ADJ(16384))
+	: __clobber_all);
+}
+
+#endif
+
+char _license[] SEC("license") = "GPL";
-- 
2.55.0

