Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793502398;
	b=xM0FR/3nvpvjj4TaqM2DuiCQP7PgbT39M+7yUif3AQ4d/FjIhFPpooC7N8DgjVYPDCGY
	 ONzLfd3cmUaoVTze3aVapPwXxiJrpLCH97sKHlxmGRo9cSEX0PvBeaz0haAoRXkQ5Xt3K
	 27uGGHolplYFuKCObteIbR83wvhLcv0h++4OSXEiCJ1154lxAE0TXCQ7PA7NPsz+E27Tm
	 GolBxH1GAX8k1HWbc93qF5VVm37EnXgQavdmttj9CEKRRRin10UwKV9uySBXIJVHarJ3j
	 rCV+t/XCH8aaZZoUkBHYDbN4qz2fUd5aKRP/WlufDAH6Ne6dlmVYyzv6R/WHg0cD+6w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793502398;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=vYmO6q68NRJAUJH9J4CIPDLKsLsq9A50tV5zPZqNWlo=;
	b=WqlLC3E1o/64teiawyX0MpzlsyVqfPevJf5veS/78IO0YUKRyfPc5V3/X2IwhWMEae1Q
	 5oOzXOxlMdTvgknIOE/NOGmz2zD8iWsUerDcFZ5MBpzdX7oEaOcVuI8uCXAMnCv53uhfh
	 YdZsf+Sg+b/Jqfx1hlYJF2fnOOYKPKMGcWYXoWTIOZXLco4OKNqvpU5aLeqT1RLaPj3FA
	 zyJfGuo3P13jNbW7e+p+my3MwwXe213HkTXYlJyVMDoEWvuFbpp2iDSmqV9AyTRAi9K83
	 jSTU8KMZ2YfF5+bvR8cv+1X69QHhJ1r4ZKMuV2uWSv0kEF1+t2E70qOcpolRUvgQLRg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ighoBSev;
	arc=none smtp.remote-ip=209.85.216.44
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DA12606A324
	for <bpf@vger.kernel.org>; Sun,  1 Nov 2026 03:06:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4DA12606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ighoBSev
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3ae7626d14aso1022673a91.2
        for <bpf@vger.kernel.org>; Sat, 31 Oct 2026 20:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793502397; x=1794107197; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vYmO6q68NRJAUJH9J4CIPDLKsLsq9A50tV5zPZqNWlo=;
        b=ighoBSevBKZT/hSd7UjPV86R/yeuscI4AS/Rc71W4zfFhKySP/JGBVq4+X2xo/ssIw
         6H/RqEc+tuYSb+HsTZVpXT45RBEILiEesKEUI97yJdWn2nZ9ffQ53t7HGD1L7G54QIc9
         IkUaUQLxd4vLTrE9iC1SByh5taKiaLgkIzA7w3Nyf+l6BDXpaarO60nO4mhH9Tm4BM04
         FT78zBiekCmNXUEp4SIXPGxeyQFCYP/0ItVUwCDObo4d+CaTpe/a+PgrCYAn/s0Om7sY
         d8G+Qfv1RwW4wsKkwRISFyNBac+8+UfpQSPWdPrltacE0vbjqDVBVFJZu3jQLhU30vTV
         YDMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793502397; x=1794107197;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=vYmO6q68NRJAUJH9J4CIPDLKsLsq9A50tV5zPZqNWlo=;
        b=MGSu225oIHRrNf3SbxcxeEY4/cYguMWqrEVIveUm4wLQmmZWRC/5h3n5ErehGGe0fC
         89dqoVJXa/PmPFZo9ZRIDOjs/LkPeC7kFmVi4V/eIjEA8loto3Z/WW4hZA5aS07K0jvX
         PqZzl/asDTO9I+rPHFYKGmkDOFD9jh5nu2qiNVFfA8tHbPbnUJBi67L5V16n07mDS4IN
         iT2Cd8ApLKGPcZSYN2P+OWR31gjcWlVc00a/OLmDNb8MbHOI5u0sbMq80RyldwQ6yfLt
         IHEEwQG1P9OUdxqIyDPnsC08isi/3GWIAS5fMKtJNOi47eBJuA2+U56SjCb3tb9Q94AE
         HOSQ==
X-Gm-Message-State: APuU4Z9XolCZP6v0kSCV1c4/8tOGnHmd3wML2mW/w7qmTmcsa3G1/NO3
	ENjJ/6Elvy95h8ta+wSL5dqr8OZyaPoGWKgE/h7aZDuNwmhMUKXQt11pGcwEtg==
X-Gm-Gg: AYBFou1QDttlgrnOMrb0Fbwj3bDfwMa5yga9Wn5NTkLEj0gXSqcyzrPfRiMSDQqmBL4
	9UOKGBpSc0mbXrUCXfwXTAHxf1fEywFfu5M0qYmlD7KkhuWM56k/Vs9GmRL3qEZAbdf7rRM39H2
	jFG7bYMkD/42jnTKvTzJa03GXlONnzBsLQsPQbr9NNpUQh0wtGH+AxM4P6u/bm/t6Chdxza4GKl
	sUWm05bosjitXzAL4tYe6tZRj24mCmIVHVynyIlbvuwAd3AOlrLAygEgH5wuR50GWIZMlaV2ly3
	EK64RXw/AAbUt3VAL8BNKytLTnAFLZoC58loFIarjn+RijfRS/93KNzYKNm79RQevRC16CY0fIi
	VBZKyks0vePbFetHG8KuEHUmOES4N5nkodrBh0oBZztvSGa7YuO7wzPd0RgM97TYLubknhNyFBJ
	g995vvOTQhvp3Ok5nk7r+wGL+XanPcI4MgtNIMAKtPy5leYdqS1k1SQVDvoRWDCo4o35lAGiKLh
	ng+phDpgmv2eTKBcDIuk9E/1KR+D6oomCJLqk47XWqUF5AXnw1i2+Ex+b0wszKBn6QixzoQaZQV
	vZy1Qr+HLAZc5qIFojeAIA4ES8oFn462cpqIukvktKz1U/HHTAMTtDJxdD2w9kIz/TIoyLuct5X
	/paszyv5h4YxwL9sTC5mg2y/tsX+JXWCw2sa7h0pxboMHz2hNevd8f0NLCyLOS7QzV33HO2UUYg
	==
X-Received: by 2002:a17:90b:164f:b0:3a8:59d3:530f with SMTP id 98e67ed59e1d1-3ae8983e34amr5605064a91.57.1793502395652;
        Sat, 31 Oct 2026 20:06:35 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.250])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3aebc8942e0sm110052a91.7.2026.10.31.20.06.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 20:06:35 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next v2 14/14] selftests/bpf: Add tests for BPF_REG_ARENA_SP
Date: Sun,  1 Nov 2026 03:05:10 +0000
Message-ID: <20261101030511.1578690-15-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261101030511.1578690-1-alexei.starovoitov@gmail.com>
References: <20261101030511.1578690-1-alexei.starovoitov@gmail.com>
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
  no_memory           The arena has no free page. The prog does not run,
                      returns 0, and its stderr has a message.
  attach_to_subprog   fentry to the main prog loads. fentry to a subprog
                      is rejected.
  jump_to_first_insn  A jump and a gotox to the first insn do not take
                      a stack again.
  slot_grows          A run needs a larger stack than the slot has. The
                      next run on the cpu does not get the same stack.
                      Skipped when the stack does not grow (64 Kbyte
                      pages) or the compiler inlined arena_free_pages().
  throw_stack_args    The main prog has stack arguments and calls
                      bpf_throw(). The kernel gets its registers back.

The first two subtests fail if all runs on a cpu get the same stack.

verifier_arena_stack has the tests of the verifier:
 - Progs with the four insns that can use r12 load and return correct
   values.
 - All other insns with r12 are rejected. So are a frame of an incorrect
   size, call chains with more than 32 Kbyte of frames, tail calls,
   BPF_LD_ABS, a gotox to 'r12 += N', a call and a callx of a callback that
   takes a stack, and progs without an arena.
 - A callback that starts with a call, or with the address of a function,
   keeps the target when the verifier adds code in front of this insn.
 - The prologue of a prog that writes to the packet is in front of the code
   that takes a stack.
 - r12 and the frame stay correct after a helper, a subprog with or without
   a frame, a callback and unwind_exit of a callee.
 - On x86 r12 is in the register of the 6th argument. Thus a subprog with 7
   arguments and a kfunc with 10 arguments are tested too.

pro_epilogue_arena_stack uses the struct_ops of bpf_testmod, which has
gen_prologue() and gen_epilogue(). The two run also when the arena has no
page for a stack and the prog is skipped.

struct_ops_refcounted_fail__arena_stack has a __ref argument and uses r12.
It is rejected.

Compilers do not emit r12. Thus the tests encode these insns with .8byte.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 .../selftests/bpf/prog_tests/arena_stack.c    |  323 +++++
 .../selftests/bpf/prog_tests/pro_epilogue.c   |    2 +
 .../prog_tests/test_struct_ops_refcounted.c   |    2 +
 .../selftests/bpf/prog_tests/verifier.c       |    2 +
 .../selftests/bpf/progs/arena_noarena.c       |   14 +
 .../testing/selftests/bpf/progs/arena_stack.c |  334 ++++++
 .../selftests/bpf/progs/arena_stack_fentry.c  |   13 +
 .../selftests/bpf/progs/arena_stack_grow.c    |  151 +++
 .../selftests/bpf/progs/arena_stack_loop.c    |   77 ++
 .../selftests/bpf/progs/arena_stack_nomem.c   |   41 +
 .../selftests/bpf/progs/arena_stack_throw.c   |  110 ++
 .../bpf/progs/pro_epilogue_arena_stack.c      |  199 ++++
 .../struct_ops_refcounted_fail__arena_stack.c |   61 +
 .../bpf/progs/verifier_arena_stack.c          | 1043 +++++++++++++++++
 14 files changed, 2372 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/arena_stack.c
 create mode 100644 tools/testing/selftests/bpf/progs/arena_stack.c
 create mode 100644 tools/testing/selftests/bpf/progs/arena_stack_fentry.c
 create mode 100644 tools/testing/selftests/bpf/progs/arena_stack_grow.c
 create mode 100644 tools/testing/selftests/bpf/progs/arena_stack_loop.c
 create mode 100644 tools/testing/selftests/bpf/progs/arena_stack_nomem.c
 create mode 100644 tools/testing/selftests/bpf/progs/arena_stack_throw.c
 create mode 100644 tools/testing/selftests/bpf/progs/pro_epilogue_arena_stack.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_refcounted_fail__arena_stack.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_arena_stack.c

diff --git a/tools/testing/selftests/bpf/prog_tests/arena_stack.c b/tools/testing/selftests/bpf/prog_tests/arena_stack.c
new file mode 100644
index 000000000000..4521589afb22
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/arena_stack.c
@@ -0,0 +1,323 @@
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
+#include "arena_stack_grow.skel.h"
+#include "arena_stack_throw.skel.h"
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
+/*
+ * A program that runs with preemption disabled is interrupted by a program in
+ * the timer interrupt
+ */
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
+		if (!ASSERT_EQ(run_tc_prog(bpf_program__fd(skel->progs.gotox_loop)), 7,
+			       "gotox_loop"))
+			break;
+	}
+	sched_setaffinity(0, sizeof(old), &old);
+out:
+	arena_stack_loop__destroy(skel);
+}
+
+/*
+ * The stack that a callback finds is too small. It gets a new one and the pages of the old
+ * one are freed. Before the callback starts another program gets these pages as its stack
+ * and gives it back. The stack of the callback has to stay taken.
+ */
+static void test_slot_grows(void)
+{
+	struct arena_stack_grow *skel;
+	cpu_set_t old;
+
+	/* the compiler may inline it */
+	if (libbpf_find_vmlinux_btf_id("arena_free_pages", BPF_TRACE_FEXIT) <= 0) {
+		test__skip();
+		return;
+	}
+	skel = arena_stack_grow__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "open_and_load"))
+		return;
+	if (!ASSERT_OK(pin_to_cpu0(&old), "pin"))
+		goto out;
+	/* the stack of the cpu is large enough for both programs */
+	ASSERT_OK(run_prog(bpf_program__fd(skel->progs.big)), "big");
+	ASSERT_OK(run_prog(bpf_program__fd(skel->progs.small)), "small");
+	ASSERT_OK(arena_stack_grow__attach(skel), "attach");
+	skel->bss->nest = 1;
+	ASSERT_OK(run_prog(bpf_program__fd(skel->progs.big)), "big with callbacks");
+	ASSERT_EQ(skel->bss->frame, 1, "frame of outer_cb");
+	/* the stack did not grow, or arena_free_pages() is inlined where it grows */
+	if (!skel->bss->waited)
+		test__skip();
+	sched_setaffinity(0, sizeof(old), &old);
+out:
+	arena_stack_grow__destroy(skel);
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
+	ASSERT_EQ(run_prog(bpf_program__fd(skel->progs.take_page)), 0, "take_page");
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
+/*
+ * bpf_throw() in a main program that has stack arguments. The exception callback restores the
+ * registers of the caller.
+ */
+static void test_throw_stack_args(void)
+{
+	struct arena_stack_throw *skel;
+	int i;
+
+	skel = arena_stack_throw__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "open_and_load"))
+		return;
+	if (!skel->rodata->has_stack_arg) {
+		test__skip();
+		goto out;
+	}
+	if (!ASSERT_OK(arena_stack_throw__attach(skel), "attach"))
+		goto out;
+	ASSERT_OK(run_prog(bpf_program__fd(skel->progs.calls_kfunc)), "calls_kfunc");
+	ASSERT_GE(skel->bss->throws, 1, "throws");
+	for (i = 0; i < 4; i++)
+		ASSERT_EQ(skel->bss->regs[i], 6 + i, "register");
+out:
+	arena_stack_throw__destroy(skel);
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
+	if (test__start_subtest("throw_stack_args"))
+		test_throw_stack_args();
+	if (test__start_subtest("jump_to_first_insn"))
+		test_jump_to_first_insn();
+	if (test__start_subtest("slot_grows"))
+		test_slot_grows();
+	if (test__start_subtest("no_memory"))
+		test_no_memory();
+}
diff --git a/tools/testing/selftests/bpf/prog_tests/pro_epilogue.c b/tools/testing/selftests/bpf/prog_tests/pro_epilogue.c
index 5d3c00a08a88..403aaaf12d1c 100644
--- a/tools/testing/selftests/bpf/prog_tests/pro_epilogue.c
+++ b/tools/testing/selftests/bpf/prog_tests/pro_epilogue.c
@@ -7,6 +7,7 @@
 #include "pro_epilogue_goto_start.skel.h"
 #include "epilogue_exit.skel.h"
 #include "pro_epilogue_with_kfunc.skel.h"
+#include "pro_epilogue_arena_stack.skel.h"
 
 struct st_ops_args {
 	__u64 a;
@@ -57,6 +58,7 @@ void test_pro_epilogue(void)
 	RUN_TESTS(pro_epilogue_goto_start);
 	RUN_TESTS(epilogue_exit);
 	RUN_TESTS(pro_epilogue_with_kfunc);
+	RUN_TESTS(pro_epilogue_arena_stack);
 	if (test__start_subtest("tailcall"))
 		test_tailcall();
 }
diff --git a/tools/testing/selftests/bpf/prog_tests/test_struct_ops_refcounted.c b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_refcounted.c
index da60c715fc59..db79ac9b98d3 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_struct_ops_refcounted.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_refcounted.c
@@ -4,6 +4,7 @@
 #include "struct_ops_refcounted_fail__ref_leak.skel.h"
 #include "struct_ops_refcounted_fail__global_subprog.skel.h"
 #include "struct_ops_refcounted_fail__tail_call.skel.h"
+#include "struct_ops_refcounted_fail__arena_stack.skel.h"
 
 void test_struct_ops_refcounted(void)
 {
@@ -11,4 +12,5 @@ void test_struct_ops_refcounted(void)
 	RUN_TESTS(struct_ops_refcounted_fail__ref_leak);
 	RUN_TESTS(struct_ops_refcounted_fail__global_subprog);
 	RUN_TESTS(struct_ops_refcounted_fail__tail_call);
+	RUN_TESTS(struct_ops_refcounted_fail__arena_stack);
 }
diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
index a1180076bdf0..5be3a3dfaf6b 100644
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
@@ -208,6 +209,7 @@ void test_verifier_align(void)                { RUN(verifier_align); }
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
diff --git a/tools/testing/selftests/bpf/progs/arena_stack_grow.c b/tools/testing/selftests/bpf/progs/arena_stack_grow.c
new file mode 100644
index 000000000000..be64296431c3
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/arena_stack_grow.c
@@ -0,0 +1,151 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include "../../../include/linux/filter.h"
+#include "bpf_misc.h"
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARENA);
+	__uint(map_flags, BPF_F_MMAPABLE);
+	__uint(max_entries, 4096);
+} arena SEC(".maps");
+
+/* Compilers don't know r12 yet */
+#define R12 12
+#define ADJ(n)		BPF_RAW_INSN(BPF_ALU64 | BPF_ADD | BPF_K, R12, 0, 0, n)
+#define LDX(dst, off)	BPF_RAW_INSN(BPF_LDX | BPF_MEM | BPF_DW, dst, R12, off, 0)
+#define ST(off, imm)	BPF_RAW_INSN(BPF_ST | BPF_MEM | BPF_DW, R12, 0, off, imm)
+
+/* With 4K pages a program with such a frame needs a stack of two pages, the others need one */
+#define BIG 4096
+
+int nest, freed, waited;
+long frame;
+
+static __naked __noinline __used long small_cb(void)
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
+/* The callback takes a stack of its own, the first one after the stack of the cpu */
+SEC("syscall")
+__naked int small(void)
+{
+	asm volatile (
+	".8byte %[adj];"
+	"r1 = 1;"
+	"r2 = small_cb ll;"
+	"r3 = 0;"
+	"r4 = 0;"
+	"call %[bpf_loop];"
+	"r0 = 0;"
+	"exit;"
+	:
+	: __imm(bpf_loop),
+	  __imm_insn(adj, ADJ(16))
+	: __clobber_all);
+}
+
+static __naked __noinline __used long inner_cb(void)
+{
+	asm volatile (
+	".8byte %[adj];"
+	".8byte %[st];"
+	"r0 = 0;"
+	"exit;"
+	:
+	: __imm_insn(adj, ADJ(16)),
+	  __imm_insn(st, ST(-16, 2))
+	: __clobber_all);
+}
+
+/* Write to the start of the stack, let inner_cb() do the same in its stack, read it back */
+static __naked __noinline __used long outer_cb(void)
+{
+	asm volatile (
+	".8byte %[adj];"
+	".8byte %[st];"
+	"r1 = 1;"
+	"r2 = inner_cb ll;"
+	"r3 = 0;"
+	"r4 = 0;"
+	"call %[bpf_loop];"
+	".8byte %[ldx];"
+	"r2 = %[frame] ll;"
+	"*(u64 *)(r2 + 0) = r1;"
+	"r0 = 0;"
+	"exit;"
+	:
+	: __imm(bpf_loop),
+	  __imm_addr(frame),
+	  __imm_insn(adj, ADJ(BIG)),
+	  __imm_insn(st, ST(-BIG, 1)),
+	  __imm_insn(ldx, LDX(BPF_REG_1, -BIG))
+	: __clobber_all);
+}
+
+/* The stack that small_cb() has used is too small for outer_cb() */
+SEC("syscall")
+__naked int big(void)
+{
+	asm volatile (
+	".8byte %[adj];"
+	"r1 = %[nest] ll;"
+	"r1 = *(u32 *)(r1 + 0);"
+	"if r1 == 0 goto 1f;"
+	"r1 = 1;"
+	"r2 = outer_cb ll;"
+	"r3 = 0;"
+	"r4 = 0;"
+	"call %[bpf_loop];"
+"1:"
+	"r0 = 0;"
+	"exit;"
+	:
+	: __imm(bpf_loop),
+	  __imm_addr(nest),
+	  __imm_insn(adj, ADJ(16))
+	: __clobber_all);
+}
+
+/* The pages of the old stack are free. This program gets them. */
+SEC("fexit/arena_free_worker")
+__naked int after_free(void)
+{
+	asm volatile (
+	".8byte %[adj];"
+	"r1 = %[freed] ll;"
+	"r2 = 1;"
+	"*(u32 *)(r1 + 0) = r2;"
+	"r0 = 0;"
+	"exit;"
+	:
+	: __imm_addr(freed),
+	  __imm_insn(adj, ADJ(16))
+	: __clobber_all);
+}
+
+static long is_freed(__u64 i, void *ctx)
+{
+	return *(volatile int *)&freed != 0;
+}
+
+/* The old pages are queued. Keep outer_cb() here until the worker has preempted it. */
+SEC("fexit/arena_free_pages")
+int wait_for_worker(void *ctx)
+{
+	if (nest && !bpf_get_smp_processor_id()) {
+		waited = 1;
+		bpf_loop(1 << 23, is_freed, NULL, 0);
+	}
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/arena_stack_loop.c b/tools/testing/selftests/bpf/progs/arena_stack_loop.c
new file mode 100644
index 000000000000..21e7e784b267
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/arena_stack_loop.c
@@ -0,0 +1,77 @@
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
+/* the same through a jump table */
+SEC("tc")
+__naked int gotox_loop(void)
+{
+	asm volatile (
+	".pushsection .jumptables,\"\",@progbits;"
+"jt_%=:"
+	".quad first_%= - tc;"
+	".size jt_%=, 8;"
+	".global jt_%=;"
+	".popsection;"
+"first_%=:"
+	"if r1 == 0 goto 2f;"
+	"r1 = 0;"
+	"r2 = jt_%= ll;"
+	"r2 = *(u64 *)(r2 + 0);"
+	".8byte %[gotox];"	/* gotox r2 */
+"2:"
+	"call returns_7;"
+	"exit;"
+	:
+	: __imm_insn(gotox, BPF_RAW_INSN(BPF_JMP | BPF_JA | BPF_X, BPF_REG_2, 0, 0, 0))
+	: __clobber_all);
+}
+
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/arena_stack_nomem.c b/tools/testing/selftests/bpf/progs/arena_stack_nomem.c
new file mode 100644
index 000000000000..9519249478a9
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/arena_stack_nomem.c
@@ -0,0 +1,41 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include "../../../include/linux/filter.h"
+#include "bpf_misc.h"
+
+/* The arena has one page. take_page() takes it, so there is no page for a stack. */
+struct {
+	__uint(type, BPF_MAP_TYPE_ARENA);
+	__uint(map_flags, BPF_F_MMAPABLE);
+	__uint(max_entries, 1);
+} arena SEC(".maps");
+
+void *bpf_arena_alloc_pages(void *map, void *addr, __u32 page_cnt, int node_id,
+			    __u64 flags) __ksym;
+
+int runs;
+
+SEC("syscall")
+int take_page(void *ctx)
+{
+	return bpf_arena_alloc_pages(&arena, NULL, 1, -1 /* NUMA_NO_NODE */, 0) ? 0 : 1;
+}
+
+SEC("syscall")
+__naked int returns_1(void)
+{
+	asm volatile (
+	".8byte %[adj];"	/* r12 += 16 */
+	"r1 = %[runs] ll;"
+	"r0 = 1;"
+	"*(u32 *)(r1 + 0) = r0;"
+	"exit;"
+	:
+	: __imm_addr(runs),
+	  __imm_insn(adj, BPF_RAW_INSN(BPF_ALU64 | BPF_ADD | BPF_K, 12, 0, 0, 16))
+	: __clobber_all);
+}
+
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/arena_stack_throw.c b/tools/testing/selftests/bpf/progs/arena_stack_throw.c
new file mode 100644
index 000000000000..ac14139fb901
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/arena_stack_throw.c
@@ -0,0 +1,110 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <stdbool.h>
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include "../../../include/linux/filter.h"
+#include "bpf_misc.h"
+
+extern void bpf_throw(__u64 cookie) __ksym;
+extern void bpf_kfunc_common_test(void) __ksym;
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARENA);
+	__uint(map_flags, BPF_F_MMAPABLE);
+	__uint(max_entries, 64);
+} arena SEC(".maps");
+
+/* BTF FUNC records are not generated for kfuncs referenced from inline assembly */
+void __kfunc_btf_root(void)
+{
+	bpf_throw(0);
+	bpf_kfunc_common_test();
+}
+
+long never, throws, regs[4];
+
+/*
+ * r6-r9 are in registers that a callee keeps. What the kfunc returns with is stored in regs[].
+ * A program that can throw saves all such registers, so its own caller is not affected.
+ */
+SEC("syscall")
+__naked int calls_kfunc(void)
+{
+	asm volatile (
+	"r1 = %[never] ll;"
+	"r1 = *(u64 *)(r1 + 0);"
+	"if r1 == 0 goto +1;"
+	"call %[bpf_throw];"
+	"r6 = 6;"
+	"r7 = 7;"
+	"r8 = 8;"
+	"r9 = 9;"
+	"call %[bpf_kfunc_common_test];"
+	"r1 = %[regs] ll;"
+	"*(u64 *)(r1 + 0) = r6;"
+	"*(u64 *)(r1 + 8) = r7;"
+	"*(u64 *)(r1 + 16) = r8;"
+	"*(u64 *)(r1 + 24) = r9;"
+	"r0 = 0;"
+	"exit;"
+	:
+	: __imm(bpf_throw),
+	  __imm(bpf_kfunc_common_test),
+	  __imm_addr(never),
+	  __imm_addr(regs)
+	: __clobber_all);
+}
+
+#ifdef __BPF_FEATURE_STACK_ARGUMENT
+
+const volatile bool has_stack_arg = true;
+
+static __naked __noinline __used
+long callee_6args(long a, long b, long c, long d, long e, long f)
+{
+	asm volatile (
+	"r0 = *(u64 *)(r11 + 8);"
+	"exit;"
+	::: __clobber_all);
+}
+
+/* The main program uses r12, has a stack argument and throws */
+SEC("fentry/bpf_kfunc_common_test")
+__naked int on_kfunc(void)
+{
+	asm volatile (
+	".8byte %[adj];"	/* r12 += 16 */
+	"r1 = %[throws] ll;"
+	"r2 = 1;"
+	"lock *(u64 *)(r1 + 0) += r2;"
+	"r1 = 1;"
+	"r2 = 2;"
+	"r3 = 3;"
+	"r4 = 4;"
+	"r5 = 5;"
+	"*(u64 *)(r11 - 8) = 6;"
+	"call callee_6args;"
+	"r1 = 0;"
+	"call %[bpf_throw];"
+	"exit;"
+	:
+	: __imm(bpf_throw),
+	  __imm_addr(throws),
+	  __imm_insn(adj, BPF_RAW_INSN(BPF_ALU64 | BPF_ADD | BPF_K, 12, 0, 0, 16))
+	: __clobber_all);
+}
+
+#else
+
+const volatile bool has_stack_arg = false;
+
+SEC("fentry/bpf_kfunc_common_test")
+int on_kfunc(void *ctx)
+{
+	return 0;
+}
+
+#endif
+
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/pro_epilogue_arena_stack.c b/tools/testing/selftests/bpf/progs/pro_epilogue_arena_stack.c
new file mode 100644
index 000000000000..40fbcc004608
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/pro_epilogue_arena_stack.c
@@ -0,0 +1,199 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <vmlinux.h>
+#include <bpf/bpf_tracing.h>
+#include "bpf_misc.h"
+#include "../test_kmods/bpf_testmod.h"
+#include "../test_kmods/bpf_testmod_kfunc.h"
+
+char _license[] SEC("license") = "GPL";
+
+#if defined(__TARGET_ARCH_x86) || defined(__TARGET_ARCH_arm64)
+
+/* One page: the stack of the cpu, or what take_page() takes so that there is no stack */
+struct {
+	__uint(type, BPF_MAP_TYPE_ARENA);
+	__uint(map_flags, BPF_F_MMAPABLE);
+	__uint(max_entries, 1);
+} arena SEC(".maps");
+
+/* Compilers don't know r12 yet, vmlinux.h has no BPF_ALU64 and the like */
+#define INSN(code, dst, src, off, imm) \
+	((__u64)(code) | (__u64)(dst) << 8 | (__u64)(src) << 12 | \
+	 (__u64)(__u16)(off) << 16 | (__u64)(__u32)(imm) << 32)
+/* r12 += n */
+#define ADJ(n)		INSN(0x07, 12, 0, 0, n)
+/* *(u64 *)(r12 + off) = imm */
+#define ST(off, imm)	INSN(0x7a, 12, 0, off, imm)
+/* dst = *(u64 *)(r12 + off) */
+#define LDX(dst, off)	INSN(0x79, dst, 12, off, 0)
+
+/* args->a += 1, through the stack in arena */
+static __naked __noinline __used int subprog(struct st_ops_args *args)
+{
+	asm volatile (
+	".8byte %[adj];"
+	".8byte %[st];"		/* *(u64 *)(r12 - 8) = 1 */
+	".8byte %[ldx];"	/* r0 = *(u64 *)(r12 - 8) */
+	"r2 = *(u64 *)(r1 +0);"
+	"r0 += r2;"
+	"*(u64 *)(r1 +0) = r0;"
+	"exit;"
+	:
+	: __imm_const(adj, ADJ(48)),
+	  __imm_const(st, ST(-8, 1)),
+	  __imm_const(ldx, LDX(BPF_REG_0, -8))
+	: __clobber_all);
+}
+
+/*
+ * The prologue and the store of ctx are in front of the code that takes a stack.
+ * Every exit goes to the epilogue: the one without a stack is the first of them.
+ */
+__success
+/* prologue */
+__xlated("0: r6 = *(u64 *)(r1 +0)")
+__xlated("1: r7 = *(u64 *)(r6 +0)")
+__xlated("2: r7 += 1000")
+__xlated("3: *(u64 *)(r6 +0) = r7")
+/* save __u64 *ctx to stack */
+__xlated("4: *(u64 *)(r10 -8) = r1")
+/* take a stack */
+__xlated("5: r2 = ")
+__xlated("7: r2 = &(void __percpu *)(r2)")
+__xlated("...")
+__xlated("w12 = w0")
+__xlated("r1 = r6")
+__xlated("if r0 != 0x0 goto pc+")
+/* no stack */
+__xlated("r0 = 0")
+/* epilogue */
+__xlated("r1 = *(u64 *)(r10 -8)")
+__xlated("r1 = *(u64 *)(r1 +0)")
+__xlated("r6 = *(u64 *)(r1 +0)")
+__xlated("r6 += 10000")
+__xlated("*(u64 *)(r1 +0) = r6")
+__xlated("r0 = r6")
+__xlated("r0 *= 2")
+__xlated("exit")
+__xlated("...")
+/* main prog */
+__xlated("w12 += 16")
+__xlated("*(u64 *)(r12 -8) = 10")
+__xlated("...")
+__xlated("call pc+")
+/* give the stack back, then the epilogue */
+__xlated("w12 += -16")
+__xlated("if w12 & 0x10 goto pc+5")
+__xlated("...")
+__xlated("*(u64 *)(r2 +0) = 0")
+__xlated("gotol pc-")
+__xlated("...")
+__xlated("r0 = r6")
+__xlated("gotol pc-")
+SEC("struct_ops/test_pro_epilogue")
+__naked int test_pro_epilogue(void)
+{
+	asm volatile (
+	".8byte %[adj];"
+	".8byte %[st];"		/* *(u64 *)(r12 - 8) = 10 */
+	"r1 = *(u64 *)(r1 +0);"
+	"r2 = *(u64 *)(r1 +0);"
+	".8byte %[ldx];"	/* r3 = *(u64 *)(r12 - 8) */
+	"r2 += r3;"
+	"*(u64 *)(r1 +0) = r2;"
+	"call subprog;"
+	"exit;"
+	:
+	: __imm_const(adj, ADJ(16)),
+	  __imm_const(st, ST(-8, 10)),
+	  __imm_const(ldx, LDX(BPF_REG_3, -8))
+	: __clobber_all);
+}
+
+/* No frame in the main prog, r12 is used by the function that it calls */
+__success
+SEC("struct_ops/test_prologue")
+__naked int test_prologue(void)
+{
+	asm volatile (
+	"r1 = *(u64 *)(r1 +0);"
+	"call subprog;"
+	"exit;"
+	::: __clobber_all);
+}
+
+__success
+SEC("struct_ops/test_epilogue")
+__naked int test_epilogue(void)
+{
+	asm volatile (
+	"r1 = *(u64 *)(r1 +0);"
+	"call subprog;"
+	"exit;"
+	::: __clobber_all);
+}
+
+SEC("syscall")
+__retval(1001) /* PROLOGUE_A [1000] + SUBPROG_A [1] */
+int syscall_prologue(void *ctx)
+{
+	struct st_ops_args args = {};
+
+	return bpf_kfunc_st_ops_test_prologue(&args);
+}
+
+SEC("syscall")
+__retval(20002) /* (SUBPROG_A [1] + EPILOGUE_A [10000]) * 2 */
+int syscall_epilogue(void *ctx)
+{
+	struct st_ops_args args = {};
+
+	return bpf_kfunc_st_ops_test_epilogue(&args);
+}
+
+SEC("syscall")
+__retval(22022) /* (PROLOGUE_A [1000] + MAIN_A [10] + SUBPROG_A [1] + EPILOGUE_A [10000]) * 2 */
+int syscall_pro_epilogue(void *ctx)
+{
+	struct st_ops_args args = {};
+
+	return bpf_kfunc_st_ops_test_pro_epilogue(&args);
+}
+
+static bool take_page(void)
+{
+	return bpf_arena_alloc_pages(&arena, NULL, 1, -1 /* NUMA_NO_NODE */, 0);
+}
+
+/* A prog that gets no stack is skipped. Its prologue and its epilogue are not. */
+SEC("syscall")
+__retval(1000) /* PROLOGUE_A [1000], the prog returns 0 */
+int syscall_prologue_no_stack(void *ctx)
+{
+	struct st_ops_args args = {};
+
+	if (!take_page() || bpf_kfunc_st_ops_test_prologue(&args))
+		return -1;
+	return args.a;
+}
+
+SEC("syscall")
+__retval(20000) /* EPILOGUE_A [10000] * 2 */
+int syscall_epilogue_no_stack(void *ctx)
+{
+	struct st_ops_args args = {};
+
+	if (!take_page())
+		return -1;
+	return bpf_kfunc_st_ops_test_epilogue(&args);
+}
+
+SEC(".struct_ops.link")
+struct bpf_testmod_st_ops pro_epilogue_arena_stack = {
+	.test_prologue = (void *)test_prologue,
+	.test_epilogue = (void *)test_epilogue,
+	.test_pro_epilogue = (void *)test_pro_epilogue,
+};
+
+#endif
diff --git a/tools/testing/selftests/bpf/progs/struct_ops_refcounted_fail__arena_stack.c b/tools/testing/selftests/bpf/progs/struct_ops_refcounted_fail__arena_stack.c
new file mode 100644
index 000000000000..35ed2fc28a94
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/struct_ops_refcounted_fail__arena_stack.c
@@ -0,0 +1,61 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <vmlinux.h>
+#include <bpf/bpf_tracing.h>
+#include "../test_kmods/bpf_testmod.h"
+#include "bpf_misc.h"
+
+char _license[] SEC("license") = "GPL";
+
+#if defined(__TARGET_ARCH_x86) || defined(__TARGET_ARCH_arm64)
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARENA);
+	__uint(map_flags, BPF_F_MMAPABLE);
+	__uint(max_entries, 1);
+} arena SEC(".maps");
+
+/* BTF FUNC records are not generated for kfuncs referenced from inline assembly */
+void __kfunc_btf_root(void)
+{
+	bpf_task_release(NULL);
+}
+
+/* r12 += 16, compilers don't know r12 yet */
+#define ADJ_16 (0x07 | 12 << 8 | 16ULL << 32)
+
+static __naked __noinline __used void uses_arena_stack(void)
+{
+	asm volatile (
+	".8byte %[adj];"
+	"exit;"
+	:
+	: __imm_const(adj, ADJ_16)
+	: __clobber_all);
+}
+
+/*
+ * A program that gets no stack in arena is skipped: nobody would release the
+ * task. It doesn't matter which function of the program uses r12.
+ */
+SEC("struct_ops/test_refcounted")
+__failure __msg("program with __ref argument cannot use R12")
+__naked int refcounted_fail__arena_stack(void)
+{
+	asm volatile (
+	"r1 = *(u64 *)(r1 + 8);"
+	"call %[bpf_task_release];"
+	"call uses_arena_stack;"
+	"r0 = 0;"
+	"exit;"
+	:
+	: __imm(bpf_task_release)
+	: __clobber_all);
+}
+
+SEC(".struct_ops.link")
+struct bpf_testmod_ops testmod_ref_acquire = {
+	.test_refcounted = (void *)refcounted_fail__arena_stack,
+};
+
+#endif
diff --git a/tools/testing/selftests/bpf/progs/verifier_arena_stack.c b/tools/testing/selftests/bpf/progs/verifier_arena_stack.c
new file mode 100644
index 000000000000..61fb949f5865
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_arena_stack.c
@@ -0,0 +1,1043 @@
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
+/* gotox reg */
+#define GOTOX(reg)	BPF_RAW_INSN(BPF_JMP | BPF_JA | BPF_X, reg, 0, 0, 0)
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
+struct prog_test_pair_arg {
+	__u64 lo;
+	__u64 hi;
+};
+
+extern __u64 bpf_kfunc_call_test_pair_arg_nofit(__u64 a, __u64 b, __u64 c, __u64 d,
+						struct prog_test_pair_arg s) __ksym;
+extern void bpf_throw(__u64 cookie) __ksym;
+
+/* BTF FUNC records are not generated for kfuncs referenced from inline assembly */
+void __kfunc_btf_root(void)
+{
+	struct prog_test_pair_arg s = {};
+
+	bpf_kfunc_call_stack_arg(0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
+	bpf_kfunc_call_test_pair_arg_nofit(0, 0, 0, 0, s);
+	bpf_throw(0);
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
+/*
+ * bpf_throw() finds the registers that the main program saved from its stack pointer at the
+ * call. x86 moves rsp for a kfunc that has stack arguments. bpf_throw() is not one of them.
+ */
+SEC("syscall")
+__description("arena stack: no move of the stack pointer in front of bpf_throw()")
+__success
+__arch_x86_64
+__jited("	movq	%r9, {{.*}}(%rbp)")
+__jited("	callq	{{.*}}")
+__naked void throw_stack_args_jit(void)
+{
+	asm volatile (
+	".8byte %[adj];"
+	"r1 = 1;"
+	"r2 = 2;"
+	"r3 = 3;"
+	"r4 = 4;"
+	"r5 = 5;"
+	"*(u64 *)(r11 - 16) = 7;"
+	"*(u64 *)(r11 - 8) = 6;"
+	"call callee_7args;"
+	"r1 = r0;"
+	"call %[bpf_throw];"
+	"exit;"
+	:
+	: __imm(bpf_throw),
+	  __imm_insn(adj, ADJ(16))
+	: __clobber_all);
+}
+
+/* The caller of the program goes on with the registers that the exception callback restores */
+SEC("syscall")
+__description("arena stack: the main program has stack arguments and throws")
+__success __retval(675)
+__naked void throw_stack_args(void)
+{
+	asm volatile (
+	".8byte %[adj];"
+	"r1 = 1;"
+	"r2 = 2;"
+	"r3 = 3;"
+	"r4 = 4;"
+	"r5 = 5;"
+	"*(u64 *)(r11 - 16) = 7;"
+	"*(u64 *)(r11 - 8) = 6;"
+	"call callee_7args;"
+	"r1 = r0;"
+	"call %[bpf_throw];"
+	"exit;"
+	:
+	: __imm(bpf_throw),
+	  __imm_insn(adj, ADJ(16))
+	: __clobber_all);
+}
+
+/* The second half of the struct is argument 6 for the JIT: slots count, not arguments */
+SEC("tc")
+__description("arena stack: a kfunc with 5 arguments in 6 slots")
+__success __retval(1091)
+__naked void kfunc_5args_6slots(void)
+{
+	asm volatile (
+	".8byte %[adj];"
+	".8byte %[st];"		/* *(u64 *)(r12 - 16) = 1000 */
+	"r1 = 1;"
+	"r2 = 2;"
+	"r3 = 3;"
+	"r4 = 4;"
+	"r5 = 5;"
+	"*(u64 *)(r11 - 8) = 6;"
+	"call %[bpf_kfunc_call_test_pair_arg_nofit];"
+	".8byte %[ldx];"
+	"r0 += r1;"
+	"exit;"
+	:
+	: __imm(bpf_kfunc_call_test_pair_arg_nofit),
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
+/* the report names the load as the origin of the number */
+__msg("Causal path:")
+__msg(">>> 3 | (79) r1 = *(u64 *)(r12 -16)")
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
+__msg("Causal path:")
+__msg(">>> 1 | (bf) r1 = r12")
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
+/* has no frame: its first insn is the call, not r12 += N */
+static __naked __noinline __used long calls_loop_cb(void)
+{
+	asm volatile (
+	"call loop_cb;"
+	"exit;"
+	::: __clobber_all);
+}
+
+/*
+ * The main program names loop_cb() first, so libbpf puts it in front of the callback.
+ * The code that takes a stack moves the first insn of the callback down.
+ * The call has to find loop_cb() from there.
+ */
+SEC("syscall")
+__description("arena stack: a callback starts with a call of a function in front of it")
+__success __retval(145)
+__xlated("call pc-{{[0-9]+}}")
+__naked void callback_calls_backward(void)
+{
+	asm volatile (
+	"r1 = 0;"
+	"*(u64 *)(r10 - 8) = r1;"
+	"r1 = 100;"
+	"r2 = r10;"
+	"r2 += -8;"
+	"call loop_cb;"
+	"r1 = 10;"
+	"r2 = calls_loop_cb ll;"
+	"r3 = r10;"
+	"r3 += -8;"
+	"r4 = 0;"
+	"call %[bpf_loop];"
+	/* 100 + 0 + 1 + ... + 9 */
+	"r0 = *(u64 *)(r10 - 8);"
+	"exit;"
+	:
+	: __imm(bpf_loop)
+	: __clobber_all);
+}
+
+/* runs loop_cb() twice. It takes a stack for callee_with_frame() */
+static __naked __noinline __used long loops_loop_cb(void)
+{
+	asm volatile (
+	"r6 = loop_cb ll;"
+	"r7 = r2;"
+	"call callee_with_frame;"
+	"r1 = 2;"
+	"r2 = r6;"
+	"r3 = r7;"
+	"r4 = 0;"
+	"call %[bpf_loop];"
+	"r0 = 0;"
+	"exit;"
+	:
+	: __imm(bpf_loop)
+	: __clobber_all);
+}
+
+/* the same for the address of a function */
+SEC("syscall")
+__description("arena stack: a callback starts with the address of a function in front of it")
+__success __retval(13)
+__naked void callback_names_backward(void)
+{
+	asm volatile (
+	"r1 = 0;"
+	"*(u64 *)(r10 - 8) = r1;"
+	/* 0 + 1 + 2 + 3 + 4 */
+	"r1 = 5;"
+	"r2 = loop_cb ll;"
+	"r3 = r10;"
+	"r3 += -8;"
+	"r4 = 0;"
+	"call %[bpf_loop];"
+	/* 3 * (0 + 1) */
+	"r1 = 3;"
+	"r2 = loops_loop_cb ll;"
+	"r3 = r10;"
+	"r3 += -8;"
+	"r4 = 0;"
+	"call %[bpf_loop];"
+	"r0 = *(u64 *)(r10 - 8);"
+	"exit;"
+	:
+	: __imm(bpf_loop)
+	: __clobber_all);
+}
+
+SEC("syscall")
+__description("arena stack: call of a callback that uses r12")
+__failure __msg("loop_cb() uses R12 and is both called and a callback")
+__naked void call_of_callback(void)
+{
+	asm volatile (
+	".8byte %[adj];"
+	"r1 = 0;"
+	"*(u64 *)(r10 - 8) = r1;"
+	"r1 = 1;"
+	"r2 = loop_cb ll;"
+	"r3 = r10;"
+	"r3 += -8;"
+	"r4 = 0;"
+	"call %[bpf_loop];"
+	"r1 = 1;"
+	"r2 = r10;"
+	"r2 += -8;"
+	"call loop_cb;"
+	"exit;"
+	:
+	: __imm(bpf_loop),
+	  __imm_insn(adj, ADJ(16))
+	: __clobber_all);
+}
+
+/* gcc doesn't support indirect calls */
+#ifdef __clang__
+SEC("syscall")
+__description("arena stack: callx of a callback that uses r12")
+__failure __msg("loop_cb() uses R12 and is both called and a callback")
+__naked void callx_of_callback(void)
+{
+	asm volatile (
+	".8byte %[adj];"
+	"r1 = 0;"
+	"*(u64 *)(r10 - 8) = r1;"
+	"r1 = 1;"
+	"r2 = loop_cb ll;"
+	"r3 = r10;"
+	"r3 += -8;"
+	"r4 = 0;"
+	"call %[bpf_loop];"
+	"r1 = 1;"
+	"r2 = r10;"
+	"r2 += -8;"
+	"r6 = loop_cb ll;"
+	"callx r6;"
+	"exit;"
+	:
+	: __imm(bpf_loop),
+	  __imm_insn(adj, ADJ(16))
+	: __clobber_all);
+}
+#endif
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
+SEC("tc")
+__description("arena stack: ld_abs")
+__failure __msg("BPF_LD_[ABS|IND] is not allowed in programs that use R12")
+__naked void ld_abs(void)
+{
+	asm volatile (
+	".8byte %[adj];"
+	"r6 = r1;"
+	"r0 = *(u8 *)skb[0];"
+	"exit;"
+	:
+	: __imm_insn(adj, ADJ(16))
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
+SEC("syscall")
+__description("arena stack: gotox to r12 += 16")
+__failure __msg("jump to the insn that changes R12")
+__naked void gotox_to_adj(void)
+{
+	asm volatile (
+	".pushsection .jumptables,\"\",@progbits;"
+"jt_%=:"
+	".quad out_%= - syscall;"
+	".quad first_%= - syscall;"
+	".size jt_%=, 16;"
+	".global jt_%=;"
+	".popsection;"
+"first_%=:"
+	".8byte %[adj];"
+	/* r1 is ctx, then 0: the loop ends */
+	"if r1 == 0 goto out_%=;"
+	"call %[bpf_get_prandom_u32];"
+	"r0 &= 1;"
+	"r0 <<= 3;"
+	"r2 = jt_%= ll;"
+	"r2 += r0;"
+	"r2 = *(u64 *)(r2 + 0);"
+	"r1 = 0;"
+	".8byte %[gotox];"	/* gotox r2 */
+"out_%=:"
+	"r0 = 0;"
+	"exit;"
+	:
+	: __imm(bpf_get_prandom_u32),
+	  __imm_insn(adj, ADJ(16)),
+	  __imm_insn(gotox, GOTOX(BPF_REG_2))
+	: __clobber_all);
+}
+
+/*
+ * The flag in the stack of the caller is 0, then 1: one jump to the first insn. The insns that
+ * take the stack are in front of it and use r6-r8.
+ */
+static __naked __noinline __used long gotox_first_insn_cb(void)
+{
+	asm volatile (
+	".pushsection .jumptables,\"\",@progbits;"
+"jt_%=:"
+	".quad first_%= - .text;"
+	".size jt_%=, 8;"
+	".global jt_%=;"
+	".popsection;"
+"first_%=:"
+	"r3 = *(u64 *)(r2 + 0);"
+	"if r3 != 0 goto second_%=;"
+	"r3 = 1;"
+	"*(u64 *)(r2 + 0) = r3;"
+	"r6 = r2;"
+	"r7 = 10;"
+	"r8 = 100;"
+	".8byte %[mov9];"	/* r9 = r12 */
+	"r3 = jt_%= ll;"
+	"r3 = *(u64 *)(r3 + 0);"
+	".8byte %[gotox];"	/* gotox r3 */
+"second_%=:"
+	"r0 = *(u64 *)(r6 + 0);"
+	"r0 += r7;"
+	"r0 += r8;"
+	".8byte %[mov3];"	/* r3 = r12 */
+	"r3 -= r9;"
+	"r0 += r3;"
+	"*(u64 *)(r2 + 0) = r0;"
+	"r0 = 0;"
+	"exit;"
+	:
+	: __imm_insn(mov9, MOV(BPF_REG_9)),
+	  __imm_insn(mov3, MOV(BPF_REG_3)),
+	  __imm_insn(gotox, GOTOX(BPF_REG_3))
+	: __clobber_all);
+}
+
+SEC("syscall")
+__description("arena stack: gotox to the first insn of a callback")
+__success __retval(111)
+__naked void gotox_first_insn_of_callback(void)
+{
+	asm volatile (
+	"r1 = 0;"
+	"*(u64 *)(r10 - 8) = r1;"
+	"r1 = 1;"
+	"r2 = gotox_first_insn_cb ll;"
+	"r3 = r10;"
+	"r3 += -8;"
+	"r4 = 0;"
+	"call %[bpf_loop];"
+	/* the flag through r6, r7, r8 and no change of r12: 1 + 10 + 100 + 0 */
+	"r0 = *(u64 *)(r10 - 8);"
+	"exit;"
+	:
+	: __imm(bpf_loop)
+	: __clobber_all);
+}
+
+/*
+ * The kernel's prologue is in front of the code that takes a stack. The exit in
+ * the prologue has no frame to drop and no stack to give back.
+ */
+SEC("tc")
+__description("arena stack: prologue of a prog that writes to the packet")
+__success __retval(7)
+__xlated("5: call unknown")		/* bpf_skb_pull_data() */
+__xlated("6: if r0 == 0x0 goto pc+2")
+__xlated("7: w0 = 2")
+__xlated("8: exit")
+__xlated("9: r1 = r6")
+/* take a stack */
+__xlated("10: r2 = 0x")
+__xlated("12: r2 = &(void __percpu *)(r2)")
+__xlated("...")
+__xlated("r12 = *(u32 *)(r2 +8)")
+/* main prog */
+__xlated("w12 += 48")
+__xlated("r2 = *(u64 *)(r1 +")
+__naked void packet_write_prologue(void)
+{
+	asm volatile (
+	".8byte %[adj];"
+	"r2 = *(u32 *)(r1 + %[data]);"
+	"r3 = *(u32 *)(r1 + %[data_end]);"
+	"r4 = r2;"
+	"r4 += 1;"
+	"r0 = 1;"
+	"if r4 > r3 goto 1f;"
+	"r0 = 7;"
+	"*(u8 *)(r2 + 0) = r0;"
+	".8byte %[stx];"	/* *(u64 *)(r12 - 8) = r0 */
+	".8byte %[ldx];"	/* r0 = *(u64 *)(r12 - 8) */
+"1:"
+	"exit;"
+	:
+	: __imm_insn(adj, ADJ(48)),
+	  __imm_insn(stx, STX(BPF_DW, -8, BPF_REG_0)),
+	  __imm_insn(ldx, LDX(BPF_DW, BPF_REG_0, -8)),
+	  __imm_const(data, offsetof(struct __sk_buff, data)),
+	  __imm_const(data_end, offsetof(struct __sk_buff, data_end))
+	: __clobber_all);
+}
+
+#endif
+
+char _license[] SEC("license") = "GPL";
-- 
2.55.0

