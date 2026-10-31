Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793483801;
	b=l65I/XCZwFAi/Lc7SsuI/KQLg5xR04YvOAebWA7ABEuxYGOjD26azDddt/rpwHnyn22p
	 vBEYHedU4CLdM1wV0vEoUxzJn7+OJrNGZxSVyNhgmPHtgzA/LhPYZ7cw3nPRAAqB7Wx2T
	 rBWWTexuwtg4Z00GwCIvXzTnOPuWgMDOcT7FHIsUwlyEhNI+6qovsjXwqoEcK8xOQVf0L
	 NyJxwigPQRS49w4/typVTMrBY4qposFTVqAtq8mtPDuxD3VOwQsYknyM4ggFj13O1OP9X
	 QSsO49gjpIAgQ0cJUmYbRIBgFa96TuAjno5P2llfcl6F7x18cTed9CqD9G3zIkhpOWg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793483801;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=XAe1/F60oV6cs9RDm6qDMpyMV6ZEesTxIZkf6B69LSg=;
	b=awc4yxLggiFsFENww0QB5NDBi5S2GuS01TwPyHSQ3Ryx7sMp4FX5nE+gkxds6fIAmfHU
	 PbnVhypvjTkQNX+ozsQrnHS1j8rgAhS7qBaKSD3lt/+V3xHlL2cKNIHlMe4Tod2jAHO1Q
	 i1yWccvitBtsVuYasY4eN4HVQRhIRZTOAx9lCzHbTK9u5FiV13+QwqzUlEaB3v5jMtlwK
	 P5MrsLJ/M+G9hRorKjsVbbNu3a3flxjP1k5wbVVranFtH+1PJHYRbDxZjtkopLVeFsrc9
	 nUqbJG2wkjiKEkI77w0TI0o2u5buPXLCXqHtZua1C0Ri3DBNvb7rYjJmcPLtH09LGhg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ddyjm0s1;
	arc=none smtp.remote-ip=209.85.216.51
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1AA4606A31A
	for <bpf@vger.kernel.org>; Sat, 31 Oct 2026 21:56:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D1AA4606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ddyjm0s1
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3ae1da332bcso876281a91.2
        for <bpf@vger.kernel.org>; Sat, 31 Oct 2026 14:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793483800; x=1794088600; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XAe1/F60oV6cs9RDm6qDMpyMV6ZEesTxIZkf6B69LSg=;
        b=ddyjm0s1CR4YJPQxLIjCIE7zkWESJX/HqZxkO7A3kCdokSReVJsKNLU27qXQyBKv/s
         SsSjFAkAmVIRowMDjM/P2wYMwvn7HAYJ742AVKimv1I2w4CgHEapekEYPCSF44ktLJ5C
         sBo8xG5Mg9ItA2bybx/mqCfYvfaItVwSxZ1sTQcBBQiDXwUUg75ilNWcYIPD/Hu6RHIP
         PiPCK30AxtF/UJ6R72rgTIs2mYlljP8GdfSBbaI0mU4J5cfCUlHaZ10c/JciSNzcKU/n
         a+HFlQchR6UWha4h5Et/74OBXOFOXSbjIoyCsDqYq/CzrtN2GHFF7q/KU1tdjtfFzPoS
         zL+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793483800; x=1794088600;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=XAe1/F60oV6cs9RDm6qDMpyMV6ZEesTxIZkf6B69LSg=;
        b=miQpq5Hq6S01Wg+6SuYqZm2gZPo5JPZl//HQXfYygTcRbe7N/14fY4pITiR/2+xdLY
         xo0lGaDWUM3z7ORrd/zIEYmeN1hBYJ8WFi1j3GJ5/MaKNrM33scbXky99Ntujrm7sas9
         aajTHcSujdDsAX0oWJuV3I5Foiylqh13xhpqvDKMROHtIdCslzYGMlWzs4uQgSkO4bwj
         VWADXWCA9S30chiVgUrlXBcRVhxZFa3jzmWmJCoj8Twsh+zdSyo8PlNQsA4b21nXr3I9
         Ns3OhOxbSOSXntcqN0tLsBWb8PZ6Ca4TyImsggmhrG3UOja2U96FtFWnzrFZLiK3yzQE
         Zcyg==
X-Gm-Message-State: AFq9FYJcvIxZ2FJkgG987fnN0lwBsIdO+6BPZzmjKe8XlkXcO8sVpE3h
	R11HPXzAtPPhbqpHPSZkSYCo6kZIbs2PJjSLyA4xXoBXCMlQZua7kP6JF6GeGg==
X-Gm-Gg: AYBFou2FA8fVm4gbum/IScrmBU487PyHorwQ+bZh4VbD4apNR8yQz+PuGArKOwXVxiZ
	8Jj0MQTLykjYFD3SR5lUwBWT0lpEMbdJa3MLk85QNPJpr3ZTvAyceRNLu7X69NBTTDdPR5RvG+5
	74hOpZF+pWaB3S4ZW6RM8OFYSHZzZa4i3JoDBOdsZ23KprwdXt9P01cHqd0/b4stcXX7WTh4Twb
	PwhWmNfvD1k5EBvk3m4E+4i1+yt7xFXZaUB5Ji8dDtHm40rFo876koL9XPIzPULz2o3PJQTnIfH
	K0kmcdiOk/chWuuXWNRSEqQASJe8p1eYT1JrxlpwjoaoH6DI8oSq78ywRlm6enBqZ0Rx529MveY
	yRcmNmOLhTgE+jwITRRQlFlRRg4XbfeNhp3QKHbVAXul2Iz6BethTQ2BWadz1zLTRy8z1rMf4bY
	NLiCYUOQKF2JmeNoArgmsEKMCQHqluGx82m8mzqyw6bxODr1yPYKAEU8pczL7EXvHQUGvJJgDhr
	TMbxJG03JHm56eMQBPvR8bydK30WRVgz7Ci7Pd98cIwcsfPU6P3i1TdysPm5gWRXak+dWZkDbem
	MiZ6pLymW2GTLwLg59P2sui0GkLuShZG2E+cy/UvlMRsP1ULLO/3j/UiBTMcCG0TBYJ4s4ZwgFg
	bYrDFSg5FOHIxTYzOVv3zMj8JJVmawljrQFNVEKl6aepOfK+pJJKkPEhW8q9tdeI2FnDWNy7R6Q
	==
X-Received: by 2002:a17:90b:380c:b0:3ac:b3ff:b476 with SMTP id 98e67ed59e1d1-3ae8982068emr4769298a91.38.1793483799860;
        Sat, 31 Oct 2026 14:56:39 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.241])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae85f3e087sm4719414a91.1.2026.10.31.14.56.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 14:56:39 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf v2 9/9] selftests/bpf: Test one may_goto time slice per prog invocation
Date: Sat, 31 Oct 2026 21:55:43 +0000
Message-ID: <20261031215543.682284-10-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261031215543.682284-1-alexei.starovoitov@gmail.com>
References: <20261031215543.682284-1-alexei.starovoitov@gmail.com>
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

Most tests call a function that spins until may_goto stops it, four times.
With one time slice for an invocation of the prog only the first call
spins. With a time slice for each frame all four calls spin, and the test
fails after 1 sec.

  group           tests
  --------------  ------------------------------------------------------
  the problem     9 insns, three levels of short loops, a subprog with
                  65534 iterations, bpf_loop() with a callback that spins
                  or makes 60000 iterations
  ways to a loop  call, call through a function without a loop, global
                  function, callx, bpf_loop() inlined and not,
                  bpf_for_each_map_elem(), bpf_user_ringbuf_drain(),
                  bpf_find_vma(), bpf_rbtree_add()
  bpf_loop()      ends when the time is up: inlined and not, in a callback
                  of bpf_loop(). Goes on when BPF code calls the callback
                  too
  count           a loop that is on the stack ends when the time is up,
                  65535 calls that make one iteration read the clock
  new time slice  timer, wq, task_work, call_rcu, call_rcu_tasks_trace,
                  each after a prog on the cpu that used up its time. Tail
                  call, extension prog
  same one        a timer callback that interrupts the prog doesn't give it
                  more time, the exception callback
  registers       may_goto takes a register that is dead: R0-RN are live,
                  for each N. A register that is live through the back
                  edge only, at the target only, behind the may_goto only.
                  All of that when it calls C and when the time is up.
                  16-byte return value
  other           tracing prog with frames in a private stack, may_goto in
                  dead code

Two tests lock up a cpu on a kernel with a time slice for each frame: the
9 insns and the three levels of short loops. All other tests give up and
fail there, or pass. The tests are for x86-64 and arm64 with the JIT only.

may_goto_far gets four subtests with the may_goto in a subprog.

The test is serial. Its progs spin for 250 ms in an RCU read-side critical
section, one after the other. Next to them in 'test_progs -j' the test
"mmap" gives up its wait for the end of a map. The test takes 10 sec.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 .../selftests/bpf/prog_tests/may_goto_far.c   |  24 +-
 .../selftests/bpf/prog_tests/timed_may_goto.c | 195 ++++
 .../selftests/bpf/progs/timed_may_goto.c      | 898 ++++++++++++++++++
 .../selftests/bpf/progs/timed_may_goto_ext.c  |  23 +
 .../selftests/bpf/progs/timed_may_goto_user.c | 311 ++++++
 5 files changed, 1446 insertions(+), 5 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/timed_may_goto.c
 create mode 100644 tools/testing/selftests/bpf/progs/timed_may_goto.c
 create mode 100644 tools/testing/selftests/bpf/progs/timed_may_goto_ext.c
 create mode 100644 tools/testing/selftests/bpf/progs/timed_may_goto_user.c

diff --git a/tools/testing/selftests/bpf/prog_tests/may_goto_far.c b/tools/testing/selftests/bpf/prog_tests/may_goto_far.c
index 8d0ff30bd068..b6d262911a3e 100644
--- a/tools/testing/selftests/bpf/prog_tests/may_goto_far.c
+++ b/tools/testing/selftests/bpf/prog_tests/may_goto_far.c
@@ -34,8 +34,10 @@ static struct bpf_insn *fill(struct bpf_insn *insn, int cnt, int reg)
  * The prog returns 0 when may_goto jumps to its target and 2 when
  * it lands in one of 'r0 = r8' areas. There are no constants between
  * may_goto and its target to keep the distance when constants are blinded.
+ *
+ * With 'subprog' all of that is a subprog.
  */
-static void test_far(int off)
+static void test_far(int off, bool subprog)
 {
 	LIBBPF_OPTS(bpf_prog_load_opts, opts, .prog_flags = BPF_F_SLEEPABLE);
 	LIBBPF_OPTS(bpf_test_run_opts, topts);
@@ -50,6 +52,10 @@ static void test_far(int off)
 		return;
 
 	insn = insns;
+	if (subprog) {
+		*insn++ = BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, BPF_PSEUDO_CALL, 0, 1);
+		*insn++ = BPF_EXIT_INSN();
+	}
 	*insn++ = BPF_EMIT_CALL(BPF_FUNC_ktime_get_ns);
 	*insn++ = BPF_MOV64_REG(BPF_REG_6, BPF_REG_0);
 	*insn++ = BPF_ALU64_IMM(BPF_RSH, BPF_REG_6, 63);
@@ -82,11 +88,19 @@ static void test_far(int off)
 void test_may_goto_far(void)
 {
 	if (test__start_subtest("32762"))
-		test_far(32762);
+		test_far(32762, false);
 	if (test__start_subtest("32767"))
-		test_far(32767);
+		test_far(32767, false);
 	if (test__start_subtest("-32767"))
-		test_far(-32767);
+		test_far(-32767, false);
 	if (test__start_subtest("-32768"))
-		test_far(-32768);
+		test_far(-32768, false);
+	if (test__start_subtest("subprog 1"))
+		test_far(1, true);
+	if (test__start_subtest("subprog 32767"))
+		test_far(32767, true);
+	if (test__start_subtest("subprog -6"))
+		test_far(-6, true);
+	if (test__start_subtest("subprog -32768"))
+		test_far(-32768, true);
 }
diff --git a/tools/testing/selftests/bpf/prog_tests/timed_may_goto.c b/tools/testing/selftests/bpf/prog_tests/timed_may_goto.c
new file mode 100644
index 000000000000..3da3f33a2898
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/timed_may_goto.c
@@ -0,0 +1,195 @@
+// SPDX-License-Identifier: GPL-2.0
+#define _GNU_SOURCE
+#include <sched.h>
+#include <test_progs.h>
+#include <network_helpers.h>
+#include "timed_may_goto.skel.h"
+#include "timed_may_goto_user.skel.h"
+#include "timed_may_goto_ext.skel.h"
+
+#define TRIES 4
+
+static int run_tc(struct bpf_program *prog)
+{
+	LIBBPF_OPTS(bpf_test_run_opts, opts,
+		.data_in = &pkt_v4,
+		.data_size_in = sizeof(pkt_v4),
+		.repeat = 1,
+	);
+
+	if (!ASSERT_OK(bpf_prog_test_run_opts(bpf_program__fd(prog), &opts), "test_run"))
+		return -1;
+	return opts.retval;
+}
+
+static int run_syscall(struct bpf_program *prog)
+{
+	LIBBPF_OPTS(bpf_test_run_opts, opts);
+
+	if (!ASSERT_OK(bpf_prog_test_run_opts(bpf_program__fd(prog), &opts), "test_run"))
+		return -1;
+	return opts.retval;
+}
+
+static void wait_for(int *val, int expected, const char *name)
+{
+	int i;
+
+	for (i = 0; i < 500 && *(volatile int *)val != expected; i++)
+		usleep(10000);
+	ASSERT_EQ(*val, expected, name);
+}
+
+static void test_async(struct timed_may_goto_user *skel)
+{
+	ASSERT_EQ(run_syscall(skel->progs.async_after_timeout), 0, "async_after_timeout");
+	wait_for(&skel->bss->timer_cnt, 1000, "timer_cnt");
+	wait_for(&skel->bss->wq_cnt, 1000, "wq_cnt");
+	wait_for(&skel->bss->tw_cnt, 1000, "tw_cnt");
+	wait_for(&skel->bss->rcu_cnt, 1000, "rcu_cnt");
+	wait_for(&skel->bss->rcu_trace_cnt, 1000, "rcu_trace_cnt");
+}
+
+static void test_timer_on_top(struct timed_may_goto_user *skel)
+{
+	int ms = run_syscall(skel->progs.spin_under_timer);
+	int ticks = skel->bss->ticks;
+
+	/* stop the timer */
+	skel->bss->ticks = 100;
+	ASSERT_GE(ms, 200, "ms");
+	ASSERT_LE(ms, 500, "ms");
+	/* control: the callback interrupted the prog, and its loop went on to the end */
+	ASSERT_GE(ticks, 5, "ticks");
+	ASSERT_LT(ticks, 100, "ticks");
+}
+
+static void test_freplace(struct timed_may_goto_user *skel)
+{
+	struct timed_may_goto_ext *ext;
+
+	ASSERT_EQ(run_tc(skel->progs.freplace_target), 1, "not replaced");
+
+	ext = timed_may_goto_ext__open();
+	if (!ASSERT_OK_PTR(ext, "ext_open"))
+		return;
+	bpf_program__set_attach_target(ext->progs.replacement,
+				       bpf_program__fd(skel->progs.freplace_target),
+				       "replaced_global");
+	if (!ASSERT_OK(timed_may_goto_ext__load(ext), "ext_load") ||
+	    !ASSERT_OK(timed_may_goto_ext__attach(ext), "ext_attach"))
+		goto out;
+	ASSERT_EQ(run_tc(skel->progs.freplace_target), TRIES, "replaced");
+out:
+	timed_may_goto_ext__destroy(ext);
+	ASSERT_EQ(run_tc(skel->progs.freplace_target), 1, "not replaced");
+}
+
+/* What a prog leaves behind when its time is up doesn't matter for the next one on the cpu. */
+static void test_tail_call_and_throw(struct timed_may_goto_user *skel)
+{
+	int key = 0, fd = bpf_program__fd(skel->progs.tail_callee);
+	int map_fd = bpf_map__fd(skel->maps.jmp_table);
+
+	if (!ASSERT_OK(bpf_map_update_elem(map_fd, &key, &fd, 0), "update"))
+		return;
+
+	ASSERT_EQ(run_tc(skel->progs.normal_prog), 1, "normal_prog");
+	ASSERT_EQ(run_tc(skel->progs.normal_prog), 1, "normal_prog");
+
+	ASSERT_EQ(run_tc(skel->progs.tail_call_in_subprog), 1, "tail_call_in_subprog");
+	ASSERT_EQ(skel->bss->tail_callee_spun, 1, "tail_callee_spun");
+
+	ASSERT_EQ(run_tc(skel->progs.tail_call_after_timeout), 0, "tail_call_after_timeout");
+	ASSERT_EQ(skel->bss->tail_callee_spun, 1, "tail_callee_spun");
+
+	ASSERT_EQ(run_tc(skel->progs.throw_after_timeout), 7, "throw_after_timeout");
+	ASSERT_EQ(run_tc(skel->progs.throw_after_timeout), 7, "throw_after_timeout");
+}
+
+static void test_user_ringbuf(struct timed_may_goto_user *skel)
+{
+	struct user_ring_buffer *rb;
+	void *sample;
+	int i;
+
+	rb = user_ring_buffer__new(bpf_map__fd(skel->maps.user_ringbuf), NULL);
+	if (!ASSERT_OK_PTR(rb, "user_ring_buffer__new"))
+		return;
+	for (i = 0; i < TRIES; i++) {
+		sample = user_ring_buffer__reserve(rb, 8);
+		if (!ASSERT_OK_PTR(sample, "reserve"))
+			goto out;
+		user_ring_buffer__submit(rb, sample);
+	}
+	/* The helper takes a sample out of the buffer for each call: all calls have to run. */
+	ASSERT_EQ(run_syscall(skel->progs.drain), TRIES * 10 + 1, "drain");
+out:
+	user_ring_buffer__free(rb);
+}
+
+static void test_priv_stack(struct timed_may_goto_user *skel)
+{
+	LIBBPF_OPTS(bpf_test_run_opts, opts);
+	int fd = bpf_program__fd(skel->progs.priv_stack);
+	struct bpf_link *link;
+
+	link = bpf_program__attach(skel->progs.priv_stack);
+	if (!ASSERT_OK_PTR(link, "attach"))
+		return;
+	ASSERT_OK(bpf_prog_test_run_opts(fd, &opts), "test_run");
+	ASSERT_EQ(skel->bss->priv_stack_spun, 1, "priv_stack_spun");
+	ASSERT_EQ(skel->bss->priv_stack_cb_spun, 0, "priv_stack_cb_spun");
+	bpf_link__destroy(link);
+}
+
+/*
+ * Serial: most progs spin for 250 ms in an RCU read-side critical section, one after the other.
+ * That delays what other tests wait for. In parallel mode "mmap" gives up its wait for the end of
+ * a map.
+ */
+void serial_test_timed_may_goto(void)
+{
+	struct timed_may_goto_user *skel;
+	cpu_set_t old, new;
+
+	/* The interpreter counts in each frame. */
+	if (!is_jit_enabled()) {
+		test__skip();
+		return;
+	}
+
+	RUN_TESTS(timed_may_goto);
+
+#if !defined(__x86_64__) && !defined(__aarch64__)
+	return;
+#endif
+	skel = timed_may_goto_user__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "open_and_load"))
+		return;
+
+	/* Count and timestamp are per-cpu: all progs of a subtest run on one cpu. */
+	if (!ASSERT_OK(sched_getaffinity(0, sizeof(old), &old), "getaffinity"))
+		goto out;
+	CPU_ZERO(&new);
+	CPU_SET(sched_getcpu(), &new);
+	if (!ASSERT_OK(sched_setaffinity(0, sizeof(new), &new), "setaffinity"))
+		goto out;
+
+	if (test__start_subtest("async"))
+		test_async(skel);
+	if (test__start_subtest("timer_on_top"))
+		test_timer_on_top(skel);
+	if (test__start_subtest("freplace"))
+		test_freplace(skel);
+	if (test__start_subtest("tail_call_and_throw"))
+		test_tail_call_and_throw(skel);
+	if (test__start_subtest("user_ringbuf"))
+		test_user_ringbuf(skel);
+	if (test__start_subtest("priv_stack"))
+		test_priv_stack(skel);
+
+	sched_setaffinity(0, sizeof(old), &old);
+out:
+	timed_may_goto_user__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/timed_may_goto.c b/tools/testing/selftests/bpf/progs/timed_may_goto.c
new file mode 100644
index 000000000000..c1c48af808a9
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/timed_may_goto.c
@@ -0,0 +1,898 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * There is one time slice of may_goto for an invocation of a prog: one call from the kernel into
+ * the main prog, with the subprogs and sync callbacks that it reaches.
+ *
+ * Most tests call a function that spins until may_goto stops it, four times, each in a different
+ * way. Only the first call can spin. With a time slice for each call all four do.
+ */
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include "bpf_misc.h"
+#include "bpf_experimental.h"
+
+char _license[] SEC("license") = "GPL";
+
+#if (defined(__TARGET_ARCH_x86) || defined(__TARGET_ARCH_arm64)) && __clang_major__ >= 18
+
+#define TRIES 4
+
+int zero;
+
+/* Return 1 if the loop went on until the time was up. */
+static __always_inline int spin(void)
+{
+	__u64 t0 = bpf_ktime_get_ns();
+
+	while (can_loop)
+		;
+	return bpf_ktime_get_ns() - t0 > 100 * 1000 * 1000;
+}
+
+static __noinline int spins(void)
+{
+	return spin();
+}
+
+static __noinline int counts_to_1000(void)
+{
+	int i, cnt = zero;
+
+	for (i = zero; i < 1000 && can_loop; i++)
+		cnt++;
+	return cnt;
+}
+
+SEC("tc")
+__description("timed may_goto: call")
+__success __retval(1)
+int call_subprog(void *ctx)
+{
+	int i, n = 0;
+
+	for (i = 0; i < TRIES; i++)
+		n += spins();
+	return n;
+}
+
+SEC("tc")
+__description("timed may_goto: a call after the time is up makes no iteration")
+__success __retval(0)
+int short_loop_after_timeout(void *ctx)
+{
+	spins();
+	return counts_to_1000();
+}
+
+SEC("tc")
+__description("timed may_goto: the loop of the main prog stops when the time is up in a subprog")
+__success __retval(1)
+int main_loop_after_timeout(void *ctx)
+{
+	int n = 0;
+
+	while (can_loop && n < 2 * TRIES)
+		n += spins();
+	return n;
+}
+
+static __noinline int passes(int i)
+{
+	return spins() + i;
+}
+
+SEC("tc")
+__description("timed may_goto: call through a function without a loop")
+__success __retval(1)
+int call_through(void *ctx)
+{
+	int i, n = 0;
+
+	for (i = 0; i < TRIES; i++)
+		n += passes(zero);
+	return n;
+}
+
+__noinline int global_spins(void)
+{
+	return spin();
+}
+
+SEC("tc")
+__description("timed may_goto: call of a global function")
+__success __retval(1)
+int call_global(void *ctx)
+{
+	int i, n = 0;
+
+	for (i = 0; i < TRIES; i++)
+		n += global_spins();
+	return n;
+}
+
+SEC("tc")
+__description("timed may_goto: callx")
+__success __retval(1)
+__naked void callx_subprog(void)
+{
+	asm volatile (
+		"r6 = 0;"
+		"r7 = 0;"
+	"1:"
+		"r3 = %[spins] ll;"
+		"callx r3;"
+		"r6 += r0;"
+		"r7 += 1;"
+		"if r7 < 4 goto 1b;"
+		"r0 = r6;"
+		"exit;"
+		:
+		: __imm_addr(spins)
+		: __clobber_all);
+}
+
+/* With a time slice for each call it gives up, so that the test fails and doesn't lock up. */
+static int loop_cb(__u64 i, int *spun)
+{
+	*spun += spin();
+	return *spun > 2 * TRIES;
+}
+
+SEC("tc")
+__description("timed may_goto: bpf_loop() inlined")
+__success __retval(1)
+int loop_inlined(void *ctx)
+{
+	int spun = 0;
+
+	bpf_loop(1 << 20, loop_cb, &spun, 0);
+	return spun;
+}
+
+SEC("tc")
+__description("timed may_goto: bpf_loop() not inlined")
+__success __retval(1)
+int loop_not_inlined(void *ctx)
+{
+	int spun = 0;
+
+	bpf_loop(1 << 20, loop_cb, &spun, zero);
+	return spun;
+}
+
+static int count_cb(__u64 i, int *calls)
+{
+	(*calls)++;
+	return 0;
+}
+
+/* The time is up: the helper calls the callback one more time. It returns 1 in its first insns. */
+#define LOOP_ENDS(name, flags)							\
+SEC("tc")									\
+__description("timed may_goto: bpf_loop() " #name " ends when the time is up")	\
+__success __retval(10)								\
+int loop_ends_##name(void *ctx)							\
+{										\
+	int calls = 0;								\
+										\
+	spins();								\
+	return bpf_loop(1000, count_cb, &calls, flags) * 10 + calls;		\
+}
+
+LOOP_ENDS(inlined, 0)
+LOOP_ENDS(not_inlined, zero)
+
+struct nested {
+	__u64 t0;
+	int spun;
+};
+
+/* Without an end of bpf_loop(): give up, so that the test fails and doesn't lock up. */
+static int inner_cb(__u64 i, struct nested *n)
+{
+	if (!n->spun)
+		n->spun = spin();
+	return (i & 1023) == 0 && bpf_ktime_get_ns() - n->t0 > 1000 * 1000 * 1000;
+}
+
+static int outer_cb(__u64 i, struct nested *n)
+{
+	bpf_loop(1 << 23, inner_cb, n, 0);
+	return bpf_ktime_get_ns() - n->t0 > 1000 * 1000 * 1000;
+}
+
+SEC("tc")
+__description("timed may_goto: bpf_loop() in bpf_loop() ends when the time is up")
+__success __retval(1)
+int loop_in_loop(void *ctx)
+{
+	struct nested n = { .t0 = bpf_ktime_get_ns() };
+
+	bpf_loop(1 << 23, outer_cb, &n, 0);
+	return n.spun && bpf_ktime_get_ns() - n.t0 < 500 * 1000 * 1000;
+}
+
+static __noinline int called_cb(__u64 i, int *calls)
+{
+	(*calls)++;
+	return 0;
+}
+
+/* BPF code calls the callback too, so its return value has to be its own. bpf_loop() goes on. */
+SEC("tc")
+__description("timed may_goto: bpf_loop() with a callback that is called as well")
+__success __retval(45)
+int loop_and_call(void *ctx)
+{
+	int calls = 0;
+
+	spins();
+	if (called_cb(zero, &calls))
+		return 100;
+	return bpf_loop(TRIES, called_cb, &calls, 0) * 10 + calls;
+}
+
+static int short_cb(__u64 i, __u64 *t0)
+{
+	int j;
+
+	for (j = zero; j < 60000 && can_loop; j++)
+		;
+	return (i & 1023) == 0 && bpf_ktime_get_ns() - *t0 > 1000 * 1000 * 1000;
+}
+
+/*
+ * The main prog has no may_goto. Each call of the callback ends before it reads the clock. The
+ * iterations of all calls add up.
+ */
+SEC("tc")
+__description("timed may_goto: bpf_loop() the callback makes 60000 iterations")
+__success __retval(1)
+int loop_short_cb(void *ctx)
+{
+	__u64 t0 = bpf_ktime_get_ns();
+
+	bpf_loop(1 << 20, short_cb, &t0, 0);
+	return bpf_ktime_get_ns() - t0 < 1000 * 1000 * 1000;
+}
+
+/* spins() uses up the time. The loop that calls it ends at its next may_goto. */
+static __noinline int loops_around_spins(void)
+{
+	int n = zero;
+
+	while (can_loop && n < 20000) {
+		if (n < 2 * TRIES)
+			spins();
+		n++;
+	}
+	return n;
+}
+
+SEC("tc")
+__description("timed may_goto: a loop that is on the stack ends when the time is up")
+__success __retval(1)
+int rest_of_batch(void *ctx)
+{
+	return loops_around_spins();
+}
+
+static __noinline int one_iteration(void)
+{
+	int i, n = zero;
+
+	for (i = zero; i < 1 && can_loop; i++)
+		n++;
+	return n;
+}
+
+long calls_ok;
+
+static int call_one(__u64 i, __u64 *t0)
+{
+	if (!one_iteration())
+		return 1;
+	calls_ok++;
+	/* With a time slice for each call: give up. */
+	return (i & 1023) == 0 && bpf_ktime_get_ns() - *t0 > 1000 * 1000 * 1000;
+}
+
+static int call_many(__u64 i, __u64 *t0)
+{
+	long before = calls_ok;
+
+	bpf_loop(1 << 23, call_one, t0, 0);
+	return calls_ok - before != 1 << 23;
+}
+
+/*
+ * The iterations of all calls count: the prog reads the clock in each 65535th call. The call that
+ * finds out that the time is up makes its iteration.
+ */
+SEC("tc")
+__description("timed may_goto: 65535 calls that make one iteration read the clock")
+__success __retval(1)
+int clock_after_65535_calls(void *ctx)
+{
+	__u64 t0 = bpf_ktime_get_ns();
+
+	calls_ok = 0;
+	bpf_loop(1000, call_many, &t0, 0);
+	return calls_ok > 0 && calls_ok % 65535 == 0;
+}
+
+#define MAP(name, map_type, flags)			\
+struct {						\
+	__uint(type, map_type);				\
+	__uint(max_entries, TRIES);			\
+	__uint(map_flags, flags);			\
+	__type(key, int);				\
+	__type(value, int);				\
+} name SEC(".maps")
+
+MAP(array, BPF_MAP_TYPE_ARRAY, 0);
+MAP(hash, BPF_MAP_TYPE_HASH, 0);
+
+/* The first call uses up the time. The second call ends the loop of the helper. */
+static int elem_cb(void *map, int *key, int *val, int *spun)
+{
+	*spun += spin();
+	return 0;
+}
+
+#define FOR_EACH(name)								\
+SEC("tc")									\
+__description("timed may_goto: bpf_for_each_map_elem() " #name)			\
+__success __retval(21)								\
+int for_each_##name(void *ctx)							\
+{										\
+	int i, key, spun = 0;							\
+										\
+	for (i = 0; i < TRIES; i++) {						\
+		key = i;							\
+		bpf_map_update_elem(&name, &key, &key, 0);			\
+	}									\
+	return bpf_for_each_map_elem(&name, elem_cb, &spun, 0) * 10 + spun;	\
+}
+
+FOR_EACH(array)
+FOR_EACH(hash)
+
+static long vma_cb(struct task_struct *task, struct vm_area_struct *vma, int *spun)
+{
+	*spun += spin();
+	return 0;
+}
+
+SEC("raw_tp")
+__description("timed may_goto: bpf_find_vma()")
+__success __retval(1)
+int find_vma(void *ctx)
+{
+	struct task_struct *task = bpf_get_current_task_btf();
+	__u64 addr = task->mm->arg_start;
+	int i, spun = 0;
+
+	for (i = 0; i < TRIES; i++)
+		if (bpf_find_vma(task, addr, vma_cb, &spun, 0))
+			return 100;
+	return spun;
+}
+
+struct tree_node {
+	struct bpf_rb_node rb;
+	int key;
+};
+
+#define private(name) SEC(".data." #name) __hidden __attribute__((aligned(8)))
+private(A) struct bpf_spin_lock lock;
+private(A) struct bpf_rb_root root __contains(tree_node, rb);
+
+int less_spun, less_calls;
+
+static bool less(struct bpf_rb_node *a, const struct bpf_rb_node *b)
+{
+	long n = zero;
+
+	/* no helpers under the lock */
+	while (can_loop)
+		n++;
+	less_calls++;
+	less_spun += n > 1000 * 1000;
+	return container_of(a, struct tree_node, rb)->key <
+	       container_of(b, struct tree_node, rb)->key;
+}
+
+SEC("tc")
+__description("timed may_goto: bpf_rbtree_add()")
+__success __retval(1)
+int rbtree_add(void *ctx)
+{
+	struct bpf_rb_node *rb;
+	struct tree_node *n;
+	int i;
+
+	less_spun = less_calls = 0;
+	for (i = 0; i < TRIES; i++) {
+		n = bpf_obj_new(typeof(*n));
+		if (!n)
+			return 100;
+		n->key = TRIES - i;
+		bpf_spin_lock(&lock);
+		bpf_rbtree_add(&root, &n->rb, less);
+		bpf_spin_unlock(&lock);
+	}
+	for (i = 0; i < TRIES; i++) {
+		bpf_spin_lock(&lock);
+		rb = bpf_rbtree_first(&root);
+		if (rb)
+			rb = bpf_rbtree_remove(&root, rb);
+		bpf_spin_unlock(&lock);
+		if (!rb)
+			return 101;
+		bpf_obj_drop(container_of(rb, struct tree_node, rb));
+	}
+	if (less_calls < TRIES - 1)
+		return 102;
+	return less_spun;
+}
+
+/*
+ * All registers are live at the may_goto, so it saves one of them in the stack. They are the same
+ * after 70000 iterations: the loop reads the clock.
+ */
+__naked __noinline __used
+static long regs_across_may_goto(void)
+{
+	asm volatile (
+		"r0 = 10;"
+		"r6 = 6;"
+		"r7 = 7;"
+		"r8 = 8;"
+		"r9 = 0;"
+	"1:"
+		"may_goto 2f;"
+		"r9 += 1;"
+		"if r9 < 70000 goto 1b;"
+	"2:"
+		"r0 += r1;"
+		"r0 += r2;"
+		"r0 += r3;"
+		"r0 += r4;"
+		"r0 += r5;"
+		"r0 += r6;"
+		"r0 += r7;"
+		"r0 += r8;"
+		"r0 += r9;"
+		"exit;"
+		::: __clobber_all);
+}
+
+SEC("tc")
+__description("timed may_goto: registers across may_goto")
+__success __retval(70046)
+__naked void regs_across_may_goto_main(void)
+{
+	asm volatile (
+		"r1 = 1;"
+		"r2 = 2;"
+		"r3 = 3;"
+		"r4 = 4;"
+		"r5 = 5;"
+		"call regs_across_may_goto;"
+		"exit;"
+		::: __clobber_all);
+}
+
+/*
+ * may_goto uses a register that is dead. In live_r0_rN() R0 - RN are live at the may_goto and the
+ * next one is not. The values come from memory, so the verifier doesn't know them. Return their sum
+ * and the number of iterations.
+ */
+__u64 vals[10] = { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 };
+__u64 zero64;
+
+#define LD0(b)		"r0 = *(u64 *)(r" #b " + 0);"
+#define LD1(b) LD0(b)	"r1 = *(u64 *)(r" #b " + 8);"
+#define LD2(b) LD1(b)	"r2 = *(u64 *)(r" #b " + 16);"
+#define LD3(b) LD2(b)	"r3 = *(u64 *)(r" #b " + 24);"
+#define LD4(b) LD3(b)	"r4 = *(u64 *)(r" #b " + 32);"
+#define LD5(b) LD4(b)	"r5 = *(u64 *)(r" #b " + 40);"
+#define LD6(b) LD5(b)	"r6 = *(u64 *)(r" #b " + 48);"
+#define LD7(b) LD6(b)	"r7 = *(u64 *)(r" #b " + 56);"
+#define LD8(b) LD7(b)	"r8 = *(u64 *)(r" #b " + 64);"
+
+#define SUM0
+#define SUM1 SUM0	"r0 += r1;"
+#define SUM2 SUM1	"r0 += r2;"
+#define SUM3 SUM2	"r0 += r3;"
+#define SUM4 SUM3	"r0 += r4;"
+#define SUM5 SUM4	"r0 += r5;"
+#define SUM6 SUM5	"r0 += r6;"
+#define SUM7 SUM6	"r0 += r7;"
+#define SUM8 SUM7	"r0 += r8;"
+
+/* The count of iterations is at r10 - 8. It begins with a number from memory too. */
+#define COUNT_INIT(t)						\
+		"r" #t " = %[zero64] ll;"			\
+		"r" #t " = *(u64 *)(r" #t " + 0);"		\
+		"*(u64 *)(r10 - 8) = r" #t ";"
+#define COUNT_AND_LOOP(t)					\
+		"r" #t " = *(u64 *)(r10 - 8);"			\
+		"r" #t " += 1;"					\
+		"*(u64 *)(r10 - 8) = r" #t ";"			\
+		"if r" #t " < 70000 goto 1b;"
+#define ADD_COUNT_AND_EXIT					\
+		"r1 = *(u64 *)(r10 - 8);"			\
+		"r0 += r1;"					\
+		"exit;"						\
+		:						\
+		: __imm_addr(vals), __imm_addr(zero64)		\
+		: __clobber_all
+
+#define LIVE_REGS(n, next)					\
+__naked __noinline __used					\
+static long live_r0_r##n(void)					\
+{								\
+	asm volatile (						\
+		COUNT_INIT(next)				\
+		"r" #n " = %[vals] ll;"				\
+		LD##n(n)					\
+	"1:"							\
+		"may_goto 2f;"					\
+		COUNT_AND_LOOP(next)				\
+	"2:"							\
+		SUM##n						\
+		ADD_COUNT_AND_EXIT);				\
+}
+
+LIVE_REGS(0, 1)
+LIVE_REGS(1, 2)
+LIVE_REGS(2, 3)
+LIVE_REGS(3, 4)
+LIVE_REGS(4, 5)
+LIVE_REGS(5, 6)
+LIVE_REGS(6, 7)
+LIVE_REGS(7, 8)
+LIVE_REGS(8, 9)
+
+/* R2 is read at the top of the loop only: it is live at the may_goto through the back edge. */
+__naked __noinline __used
+static long live_back_edge(void)
+{
+	asm volatile (
+		COUNT_INIT(3)
+		"r2 = %[vals] ll;"
+		LD2(2)
+	"1:"
+		"*(u64 *)(r10 - 16) = r2;"
+		"may_goto 2f;"
+		COUNT_AND_LOOP(3)
+	"2:"
+		"r0 += r1;"
+		"r2 = *(u64 *)(r10 - 16);"
+		"r0 += r2;"
+		ADD_COUNT_AND_EXIT);
+}
+
+/* R2 is read only where the may_goto jumps to. */
+__naked __noinline __used
+static long live_target(void)
+{
+	asm volatile (
+		COUNT_INIT(3)
+		"r2 = %[vals] ll;"
+		LD2(2)
+	"1:"
+		"may_goto 2f;"
+		COUNT_AND_LOOP(3)
+		"goto 3f;"
+	"2:"
+		"r0 += r2;"
+	"3:"
+		"r0 += r1;"
+		ADD_COUNT_AND_EXIT);
+}
+
+/* R2 is set in front of the may_goto in each iteration, and read only right behind it. */
+__naked __noinline __used
+static long live_fall_through(void)
+{
+	asm volatile (
+		COUNT_INIT(3)
+		"r1 = %[vals] ll;"
+		LD1(1)
+		"*(u64 *)(r10 - 16) = r0;"
+	"1:"
+		"r2 = %[vals] ll;"
+		"r2 = *(u64 *)(r2 + 16);"
+		"may_goto 2f;"
+		"*(u64 *)(r10 - 16) = r2;"
+		COUNT_AND_LOOP(3)
+	"2:"
+		"r0 += r1;"
+		"r2 = *(u64 *)(r10 - 16);"
+		"r0 += r2;"
+		ADD_COUNT_AND_EXIT);
+}
+
+#define CALL_AND_ADD(f)	"call " #f ";" "r6 += r0;"
+#define CALL_ALL_LIVE						\
+		"r6 = 0;"					\
+		CALL_AND_ADD(live_r0_r0)			\
+		CALL_AND_ADD(live_r0_r1)			\
+		CALL_AND_ADD(live_r0_r2)			\
+		CALL_AND_ADD(live_r0_r3)			\
+		CALL_AND_ADD(live_r0_r4)			\
+		CALL_AND_ADD(live_r0_r5)			\
+		CALL_AND_ADD(live_r0_r6)			\
+		CALL_AND_ADD(live_r0_r7)			\
+		CALL_AND_ADD(live_r0_r8)			\
+		CALL_AND_ADD(live_back_edge)			\
+		CALL_AND_ADD(live_target)			\
+		CALL_AND_ADD(live_fall_through)			\
+		"r0 = r6;"					\
+		"exit;"
+
+/*
+ * The sums: 1 + 3 + 6 + 10 + 15 + 21 + 28 + 36 + 45 = 165. Then 6, 3 (the may_goto doesn't jump)
+ * and 6. 12 * 70000 iterations: each function reads the clock.
+ */
+SEC("tc")
+__description("timed may_goto: may_goto takes a register that is dead")
+__success __retval(840180)
+__naked void dead_reg(void)
+{
+	asm volatile (
+		CALL_ALL_LIVE
+		::: __clobber_all);
+}
+
+/* No iteration: 165, then 6, 6 (the may_goto jumps) and 4 (R2 isn't stored). */
+SEC("tc")
+__description("timed may_goto: may_goto takes a register that is dead, the time is up")
+__success __retval(181)
+__naked void dead_reg_time_is_up(void)
+{
+	asm volatile (
+		"call spins_on_may_goto;"
+		CALL_ALL_LIVE
+		::: __clobber_all);
+}
+
+/*
+ * The subprog uses up the time of the prog and returns. With a time slice for each call the caller
+ * calls it 65535 times before it reads the clock.
+ */
+__naked __noinline __used
+static unsigned long spins_on_may_goto(void)
+{
+	asm volatile (
+	"1:"
+		"may_goto 2f;"
+		"goto 1b;"
+	"2:"
+		"r0 = 0;"
+		"exit;"
+		::: __clobber_all);
+}
+
+/* The first may_goto of the function finds that the time is up */
+SEC("tc")
+__description("timed may_goto: registers across may_goto when the time is up")
+__success __retval(46)
+__naked void regs_when_time_is_up(void)
+{
+	asm volatile (
+		"call spins_on_may_goto;"
+		"r1 = 1;"
+		"r2 = 2;"
+		"r3 = 3;"
+		"r4 = 4;"
+		"r5 = 5;"
+		"call regs_across_may_goto;"
+		"exit;"
+		::: __clobber_all);
+}
+
+/* The first insn of the main prog is the target of a jump. It must not set the count again. */
+SEC("socket")
+__description("timed may_goto: 9 insns")
+__success __retval(1)
+__naked void loop_calls_subprog_with_may_goto(void)
+{
+	asm volatile (
+	"1:"
+		"call spins_on_may_goto;"
+		"may_goto 2f;"
+		"goto 1b;"
+	"2:"
+		"r0 = 1;"
+		"exit;"
+		::: __clobber_all);
+}
+
+/*
+ * These subprogs make 60000 iterations in each call. With a read of the clock after 65535
+ * iterations of a call none of them reads it, and their caller does it after
+ * 65535 * 60000 * 60000 iterations.
+ */
+__naked __noinline __used
+static unsigned long loops_60000(void)
+{
+	asm volatile (
+		"r1 = 60000;"
+	"1:"
+		"may_goto 2f;"
+		"r1 += -1;"
+		"if r1 != 0 goto 1b;"
+	"2:"
+		"r0 = 0;"
+		"exit;"
+		::: __clobber_all);
+}
+
+__naked __noinline __used
+static unsigned long calls_60000_times(void)
+{
+	asm volatile (
+		"r6 = 60000;"
+	"1:"
+		"call loops_60000;"
+		"may_goto 2f;"
+		"r6 += -1;"
+		"if r6 != 0 goto 1b;"
+	"2:"
+		"r0 = 0;"
+		"exit;"
+		::: __clobber_all);
+}
+
+SEC("socket")
+__description("timed may_goto: three levels of loops that end before they read the clock")
+__success __retval(1)
+__naked void three_levels_of_short_loops(void)
+{
+	asm volatile (
+	"1:"
+		"call calls_60000_times;"
+		"may_goto 2f;"
+		"goto 1b;"
+	"2:"
+		"r0 = 1;"
+		"exit;"
+		::: __clobber_all);
+}
+
+/* The callee ends one iteration before it reads the clock. */
+__naked __noinline __used
+static unsigned long loops_65534(void)
+{
+	asm volatile (
+		"r1 = 65534;"
+	"1:"
+		"may_goto 2f;"
+		"r1 += -1;"
+		"if r1 != 0 goto 1b;"
+	"2:"
+		"r0 = 0;"
+		"exit;"
+		::: __clobber_all);
+}
+
+SEC("socket")
+__description("timed may_goto: the subprog makes 65534 iterations")
+__success __retval(1)
+__naked void loop_calls_subprog_with_65534_iterations(void)
+{
+	asm volatile (
+		"call %[bpf_ktime_get_ns];"
+		"r6 = r0;"
+	"1:"
+		"call loops_65534;"
+		"may_goto 2f;"
+		"goto 1b;"
+	"2:"
+		"call %[bpf_ktime_get_ns];"
+		"r0 -= r6;"
+		"r1 = r0;"
+		"r0 = 1;"
+		"if r1 < 1000000000 goto +1;"
+		"r0 = 0;"
+		"exit;"
+		:
+		: __imm(bpf_ktime_get_ns)
+		: __clobber_all);
+}
+
+/* The subprog returns 16 bytes in R0 and R2. may_goto must not change them. */
+__naked __noinline __used
+static unsigned __int128 returns_pair_after_may_goto(void)
+{
+	asm volatile (
+		"r0 = 1;"
+		"r2 = 2;"
+	"1:"
+		"may_goto 2f;"
+		"goto 1b;"
+	"2:"
+		"exit;"
+		::: __clobber_all);
+}
+
+SEC("socket")
+__description("timed may_goto: the subprog returns 16 bytes")
+__success __retval(3)
+__naked void subprog_with_may_goto_returns_pair(void)
+{
+	asm volatile (
+		"call returns_pair_after_may_goto;"
+		"r0 += r2;"
+		"exit;"
+		::: __clobber_all);
+}
+
+/* Dead code doesn't count: a prog that has no may_goto left gets no insns. */
+__naked __noinline __used
+static unsigned long may_goto_is_dead_code(void)
+{
+	asm volatile (
+		"r0 = 0;"
+		"if r0 == 0 goto 2f;"
+	"1:"
+		"may_goto 2f;"
+		"goto 1b;"
+	"2:"
+		"exit;"
+		::: __clobber_all);
+}
+
+SEC("socket")
+__description("timed may_goto: may_goto in dead code")
+__success __retval(0)
+__xlated("0: call pc+1")
+__xlated("1: exit")
+__xlated("2: r0 = 0")
+__xlated("3: exit")
+__naked void dead_may_goto(void)
+{
+	asm volatile (
+		"call may_goto_is_dead_code;"
+		"exit;"
+		::: __clobber_all);
+}
+
+static __noinline int throws_after_spin(void)
+{
+	spin();
+	bpf_throw(0);
+	return 0;
+}
+
+__noinline int exception_cb_loops(u64 cookie)
+{
+	return counts_to_1000();
+}
+
+/* The exception callback belongs to the invocation that throws. */
+SEC("tc")
+__description("timed may_goto: bpf_throw() the exception callback has a loop")
+__exception_cb(exception_cb_loops)
+__success __retval(0)
+int throw_after_timeout(void *ctx)
+{
+	return throws_after_spin();
+}
+
+#else
+
+SEC("socket")
+__description("timed may_goto: not supported dummy test")
+__success
+int dummy_test(void)
+{
+	return 0;
+}
+
+#endif
diff --git a/tools/testing/selftests/bpf/progs/timed_may_goto_ext.c b/tools/testing/selftests/bpf/progs/timed_may_goto_ext.c
new file mode 100644
index 000000000000..969ca58b6eed
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/timed_may_goto_ext.c
@@ -0,0 +1,23 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+#include "bpf_experimental.h"
+
+char _license[] SEC("license") = "GPL";
+
+static __noinline int spins(void)
+{
+	__u64 t0 = bpf_ktime_get_ns();
+
+	while (can_loop)
+		;
+	return bpf_ktime_get_ns() - t0 > 100 * 1000 * 1000;
+}
+
+/* Each call of an extension prog is an invocation: one of its two calls spins. */
+SEC("freplace")
+int replacement(int i)
+{
+	return spins() + spins() + i;
+}
diff --git a/tools/testing/selftests/bpf/progs/timed_may_goto_user.c b/tools/testing/selftests/bpf/progs/timed_may_goto_user.c
new file mode 100644
index 000000000000..8b85815d45d2
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/timed_may_goto_user.c
@@ -0,0 +1,311 @@
+// SPDX-License-Identifier: GPL-2.0
+/* The tests of timed_may_goto.c that need help from user space. */
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include "bpf_misc.h"
+#include "bpf_experimental.h"
+
+char _license[] SEC("license") = "GPL";
+
+#define TRIES 4
+#define CLOCK_MONOTONIC 1
+
+int zero;
+
+/* Return 1 if the loop went on until the time was up. */
+static __always_inline int spin(void)
+{
+	__u64 t0 = bpf_ktime_get_ns();
+
+	while (can_loop)
+		;
+	return bpf_ktime_get_ns() - t0 > 100 * 1000 * 1000;
+}
+
+static __noinline int spins(void)
+{
+	return spin();
+}
+
+static __noinline int counts_to_1000(void)
+{
+	int i, cnt = zero;
+
+	for (i = zero; i < 1000 && can_loop; i++)
+		cnt++;
+	return cnt;
+}
+
+/* Nothing special: the loops go on, then the time is up one time. */
+SEC("tc")
+int normal_prog(void *ctx)
+{
+	int i, n = 0;
+
+	if (counts_to_1000() != 1000)
+		return 100;
+	for (i = 0; i < TRIES; i++)
+		n += spins();
+	return n;
+}
+
+/*
+ * Async callbacks
+ */
+struct elem {
+	struct bpf_timer timer;
+	struct bpf_wq wq;
+	struct bpf_task_work tw;
+	struct bpf_rcu_head rcu;
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, 2);
+	__type(key, int);
+	__type(value, struct elem);
+} async SEC(".maps");
+
+int timer_cnt, wq_cnt, tw_cnt, rcu_cnt, rcu_trace_cnt;
+
+static int timer_cb(void *map, int *key, struct elem *e)
+{
+	timer_cnt = counts_to_1000();
+	return 0;
+}
+
+static int wq_cb(void *map, int *key, void *val)
+{
+	wq_cnt = counts_to_1000();
+	return 0;
+}
+
+static int tw_cb(struct bpf_map *map, void *key, void *val)
+{
+	tw_cnt = counts_to_1000();
+	return 0;
+}
+
+static int rcu_cb(struct bpf_map *map, void *key, void *val)
+{
+	rcu_cnt = counts_to_1000();
+	return 0;
+}
+
+static int rcu_trace_cb(struct bpf_map *map, void *key, void *val)
+{
+	rcu_trace_cnt = counts_to_1000();
+	return 0;
+}
+
+/*
+ * The time of this prog is up when it starts the callbacks. User space keeps the task on the cpu,
+ * so the callbacks find what it has left. Each call of a callback is an invocation of its own.
+ */
+SEC("syscall")
+int async_after_timeout(void *ctx)
+{
+	struct task_struct *task = bpf_get_current_task_btf();
+	struct elem *e, *e1;
+	int key = 0, key1 = 1;
+
+	e = bpf_map_lookup_elem(&async, &key);
+	e1 = bpf_map_lookup_elem(&async, &key1);
+	if (!e || !e1)
+		return 100;
+	if (bpf_timer_init(&e->timer, &async, CLOCK_MONOTONIC) ||
+	    bpf_timer_set_callback(&e->timer, timer_cb))
+		return 101;
+	if (bpf_wq_init(&e->wq, &async, 0) || bpf_wq_set_callback(&e->wq, wq_cb, 0))
+		return 102;
+	if (!spins())
+		return 103;
+	/* control: the time is up */
+	if (counts_to_1000())
+		return 109;
+	if (bpf_timer_start(&e->timer, 0, BPF_F_TIMER_CPU_PIN))
+		return 104;
+	if (bpf_wq_start(&e->wq, 0))
+		return 105;
+	if (bpf_task_work_schedule_resume(task, &e->tw, &async, tw_cb))
+		return 106;
+	if (bpf_call_rcu(&e->rcu, &async, rcu_cb))
+		return 107;
+	if (bpf_call_rcu_tasks_trace(&e1->rcu, &async, rcu_trace_cb))
+		return 108;
+	return 0;
+}
+
+int ticks;
+
+static int tick_cb(void *map, int *key, struct elem *e)
+{
+	if (counts_to_1000() != 1000)
+		ticks = 1000;
+	if (++ticks < 100)
+		bpf_timer_start(&e->timer, 20 * 1000 * 1000, BPF_F_TIMER_CPU_PIN);
+	return 0;
+}
+
+/*
+ * A callback of the prog interrupts it, on the same cpu, each 20 ms. It has its own time. That
+ * doesn't give more time to the prog. Return how long the loop went on, in ms.
+ */
+SEC("syscall")
+int spin_under_timer(void *ctx)
+{
+	struct elem *e;
+	int key = 1;
+	__u64 t0;
+
+	e = bpf_map_lookup_elem(&async, &key);
+	if (!e)
+		return 0;
+	if (bpf_timer_init(&e->timer, &async, CLOCK_MONOTONIC) ||
+	    bpf_timer_set_callback(&e->timer, tick_cb) ||
+	    bpf_timer_start(&e->timer, 20 * 1000 * 1000, BPF_F_TIMER_CPU_PIN))
+		return 0;
+	t0 = bpf_ktime_get_ns();
+	while (can_loop)
+		;
+	return (bpf_ktime_get_ns() - t0) / 1000000;
+}
+
+/*
+ * Extension prog
+ */
+__noinline int replaced_global(int i)
+{
+	return spin() + i;
+}
+
+SEC("tc")
+int freplace_target(void *ctx)
+{
+	int i, n = 0;
+
+	for (i = 0; i < TRIES; i++)
+		n += replaced_global(zero);
+	return n;
+}
+
+/*
+ * Tail calls
+ */
+struct {
+	__uint(type, BPF_MAP_TYPE_PROG_ARRAY);
+	__uint(max_entries, 1);
+	__uint(key_size, sizeof(int));
+	__uint(value_size, sizeof(int));
+} jmp_table SEC(".maps");
+
+int tail_callee_spun;
+
+SEC("tc")
+int tail_callee(struct __sk_buff *skb)
+{
+	int i;
+
+	tail_callee_spun = 0;
+	for (i = 0; i < TRIES; i++)
+		tail_callee_spun += spins();
+	return 0;
+}
+
+static __noinline int tail_calls(struct __sk_buff *skb)
+{
+	bpf_tail_call(skb, &jmp_table, 0);
+	return zero + 100;
+}
+
+/* The target of the tail call is another prog. It returns to this function. */
+SEC("tc")
+int tail_call_in_subprog(struct __sk_buff *skb)
+{
+	int i, n;
+
+	n = tail_calls(skb);
+	if (counts_to_1000() != 1000)
+		return 101;
+	for (i = 0; i < TRIES; i++)
+		n += spins();
+	return n;
+}
+
+SEC("tc")
+int tail_call_after_timeout(struct __sk_buff *skb)
+{
+	spins();
+	bpf_tail_call(skb, &jmp_table, 0);
+	return 100;
+}
+
+static __noinline int throws(void)
+{
+	spin();
+	bpf_throw(7);
+	return 0;
+}
+
+SEC("tc")
+int throw_after_timeout(void *ctx)
+{
+	return throws();
+}
+
+/*
+ * bpf_user_ringbuf_drain()
+ */
+struct {
+	__uint(type, BPF_MAP_TYPE_USER_RINGBUF);
+	__uint(max_entries, 4096);
+} user_ringbuf SEC(".maps");
+
+static long drain_cb(struct bpf_dynptr *dynptr, int *spun)
+{
+	*spun += spin();
+	return 0;
+}
+
+SEC("syscall")
+int drain(void *ctx)
+{
+	int spun = 0;
+
+	return bpf_user_ringbuf_drain(&user_ringbuf, drain_cb, &spun, 0) * 10 + spun;
+}
+
+/*
+ * A tracing prog with large frames: they are in a private stack.
+ */
+int priv_stack_spun, priv_stack_cb_spun;
+
+static __noinline int spins_with_stack(void)
+{
+	volatile char buf[128] = {};
+
+	return spin() + buf[zero & 127];
+}
+
+static int priv_stack_cb(__u64 i, int *spun)
+{
+	volatile char buf[128] = {};
+
+	*spun += spin() + buf[zero & 127];
+	return 0;
+}
+
+SEC("fentry/bpf_fentry_test1")
+int BPF_PROG(priv_stack)
+{
+	volatile char buf[128] = {};
+	int i, n = buf[zero & 127], spun = 0;
+
+	for (i = 0; i < TRIES; i++)
+		n += spins_with_stack();
+	bpf_loop(TRIES, priv_stack_cb, &spun, zero);
+	priv_stack_spun = n;
+	priv_stack_cb_spun = spun;
+	return 0;
+}
-- 
2.55.0

