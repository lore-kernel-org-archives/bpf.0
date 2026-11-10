Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.66
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794270468;
	b=aVGmthujdmcs/e8mkCl+60upNERBFeUrcD8g/LkBt/M8YQEXP38VB0dTFSxJ1v65IZrv
	 XayXl5MhoMmz0NM0W5MrrUfxkGqkB1jVatgjiZH5KBj1otutmdmeNJFWiJdG6/oFKqYrt
	 3TOiW3l/4y9oYpGuQcSYi+DoW11OzEYL5DRh5gfWcgZjZb5s9jnX6HMgOOP/wNBuLx8ti
	 0U3NZ/c0bjJdjjOSztSf3DFMBXlTf9EwfLXR7IELVPei1Zm8NX1EtxWEI9RFJiUJt8FKz
	 dNgtKXdukHqWbDKZ/2kQ1gKd2or/qjWMi5r4J1eibAo0fDTexYzQtS1wHwTIdtvzBNg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794270468;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:X-Developer-Signature:
	 X-Developer-Key:Content-Transfer-Encoding;
	bh=wDZQFQ76JRtDkVw7cG7OCDOacrRvqJRCM3ZO2vpU5aM=;
	b=slGfXhvAsBTnfQ2qeezJ60GBf9OFyXnrIVtRbe41zZEYcRbxkNX9eYP6IwgEP8NeaIU+
	 aLTIu6d9XfnoT9r9/dfJ5/kIFtCmwJAnzLNjypiUcBr/j6IHHpDQ0fqzBU1CrKv/Vuj40
	 YKKNAZ5C9kVF2EIxcIMD7a+K2kCW/R11erQaT5Gt6N4ZKVJ+r5xSyM6I3K3GtU2YpOikP
	 zDm4kB5GQS7Lzrbviym+ejwfM4k/4Ht/jvQD1dupiGhxGI3SMi0XQW/aI1gdJ2mpZ1ecG
	 DOMZmQx9Fk2b3oqOZZZ/2fAPn6lT7wbaLxcwHOFNzr4lp1rzC0ZntAnnXz6FwKTTeMA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=y0adB+rE;
	arc=none smtp.remote-ip=209.85.128.66
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DACD606A31C
	for <bpf@vger.kernel.org>; Tue, 10 Nov 2026 00:27:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7DACD606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=y0adB+rE
Received: by mail-wm1-f66.google.com with SMTP id 5b1f17b1804b1-4a9a8d6cea8so17387275e9.1
        for <bpf@vger.kernel.org>; Mon, 09 Nov 2026 16:27:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794270467; x=1794875267; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=wDZQFQ76JRtDkVw7cG7OCDOacrRvqJRCM3ZO2vpU5aM=;
        b=y0adB+rE9S5BlEWr3K3B8cwqBYzY1XhfntUolMTgpkaRwZOtB9f7CvqBLihyLUsVXk
         r+8ojuHH7leadkFB27JsxYwxNy7BFm9flMFIjNPVckx7gFCpPIe+Sb/JbujePIG/Ft3o
         C0no2QYv1UFs1zhZlJULoPXOxGH7JWnes1qu21RfqRJ0y/6bewBBX+UBINRFrPidjla1
         IIv2/B9ySyymCVeMjtDgS1SSXP/MLkVSjxeWQDTDUbFT6+8z+jUb/khlgEIvGKx098xM
         naZfeOMt7K8s174pGzjB2iZlpW+iWmxA53ZeE+s5lap766uogZAgHDhM+wM9laCDrzjm
         hh+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794270467; x=1794875267;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wDZQFQ76JRtDkVw7cG7OCDOacrRvqJRCM3ZO2vpU5aM=;
        b=r8eJNYY/0ulchkiNZ6l+kzUMPiEfGA7Wn6UHBTAOcE3dylJ3CLGSEYXVBx7NMwukb/
         duMRD6+JbinEx7t8AOe7QjQxIxLXR2VzVYlt+3fFnLjsN/tD9qRcZN2GtX/p2TN7Qw1A
         a+NLNvZBG6su8KWrJzFQkVU9Y8WpMsbXe4G1LXaPn+WmNdQurjaF7+BpG9d44guSU/wY
         6dWeXEj77lJ1v0GLLDzOvV99oJdbsn+pB1L4MSMDbyIo9iQhAom8NmA76nBeM9O8zmgu
         RhHBiAb8rRNon5xFWle2Yee919A3yabrUCtYNfaghRtBEPssfpZuExyltneV2AjhftLL
         tAlA==
X-Gm-Message-State: APuU4Z+TCIZSqbmvIxhE8OspmMFYxfXuIVYVG5DwoVrWQXJ0GQMTJzl6
	q9i7BdCX9yqUXNn4FPYf0XU3IsaHWXYgbsiPzPysr0GZlmUCtJ9W05uJWMBIneoJ
X-Gm-Gg: AYBFou3vBgq38Kdc41Z0YHNWdqKxwEY2g2IO6c1UiitHYPVi9iNlSsNAYi3iNm13aK5
	A+/YNAjXTQ9k837tU4+FQXMtrvniRnGITdyNr0Bu9WbpFI0QD6Eo5UVTRP7Xh1QHq9GxIvjNB3Y
	/GjwCWm/0euhd2UurMWJexVqxCQ0+DlBWEaROzr7qDVQhUXxE6+GyOBwvG/Kx3Pk/g2X894dPjJ
	cVnKfr9XWK99Qo/JG5mOa43tDwiY13T8+YZnIEViR145ecjsHFniuIahQJEU/SpqOEZXD4XUfxl
	9v/Tr6/n5D/SKw3dF/4c/QS3BavGT7Q1Mgp4xCWqIST3ymY+ODGk0dzK+pJ/FFuGk6hKjaP62rk
	mz0RMCNCWc6VOlEEGusH+PphFrWE/4Zb3m4pVv7i6Xjtd77Zf6HgAQ+EvjuRcMrFuCZLVs3ycGp
	/sV/2gEbjGK5wGUtaEY85dUdWgjOx3VCv+Pm6bmZgHWPiSbceS1LGorT8DiDBBF0T5pneaXAy75
	9rD4wwm6U4HbIDDxx+V1oyCTufYptly/K9FWZ89txhIjC6HfXVv77rzVRthsQya0roHfAQT6xOg
	3LsknVETzNxVtUyhXbQpIfhCmZmLpLWH5xcQylLMtpHY+/U6ZEFgmR7gWEAX7SzW1Q+tx3BLmJ5
	W4/CSOGRejuazkmqhXqG/OfpXzLLQeMBGfadWllRUjDYHijorOZGfgnItZ3kKrxIp3ieB
X-Received: by 2002:a05:600c:8109:b0:4b6:2396:7953 with SMTP id 5b1f17b1804b1-4ba01dabb56mr17017455e9.3.1794270466553;
        Mon, 09 Nov 2026 16:27:46 -0800 (PST)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-498366c43f4sm2069306f8f.47.2026.11.09.16.27.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 16:27:46 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Tejun Heo <tj@kernel.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 00/20] BPF kthreads and waitqueues
Date: Tue, 10 Nov 2026 01:27:22 +0100
Message-ID: <cover.1794269506.git.memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7717; i=memxor@gmail.com; h=from:subject:message-id; bh=SIwkSwj7zFxtPXGzSb+XpE+jaMppBggcwpWLkj3snrQ=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIetTovOP2T/1K8NmmhbHmvfZ65So77X8MG1+8957aaucX rSzaNR0lLIwiHExyIopspT838dkfKLyd6DtMm6YOaxMIEMYuDgFYCJHTjAyfLXyFOKIU1lzdOON f9Z//U7sPsWncvHcy/5bbeGrd/VPLmD4K2wSzFnMYsjcFFS8L3W9LP9mgf3rb5/KPL7x+Y4X7Np uXAA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Currently, a BPF program has no thread of its own and no way to sleep
until another program wakes it. It runs for the length of one
invocation, in a task that entered the kernel or in a kworker, so a
program that waits for work can only poll for it.

This series introduces two low-level primitives that let BPF programs
build such patterns themselves:

 - bpf_task_park() and bpf_task_wake(), which put the current task to
   sleep and make a task runnable.
 - BPF kthreads, kernel threads whose body is a callback of the program
   that created them.

The kernel provides the mechanism and the program keeps the policy.
There is no wait queue object in the kernel. A wait queue is what the
program builds out of the two kfuncs: a list of parked tasks, kept in a
map or in arena memory, with its own rule for whom to wake and in which
order. The kernel only guarantees that a wake is not lost between the
program's check of its condition and its sleep. Likewise, a thread is
just a task. The program holds it as a task kptr and decides how many
threads it runs, where they run, and when they stop.

We are doing various experiments with synthetic and production workloads
for various use cases (dynamically scaled proactive reclamation, and
dynamically scaled network stack processing) where such primitives
provide foundations for building more adaptive policies to enable better
efficiency and workload isolation.

API Examples
------------

For example, a worker that sleeps until there is work, the program that
creates it, and a waker on the event the worker waits for. q is a value
of an array map with a flag and the worker's task kptr:

	static int worker(u64 arg)
	{
		bpf_repeat(BPF_MAX_LOOPS) {
			if (bpf_kthread_should_stop())
				break;
			if (READ_ONCE(q->ready))
				serve(q);
			else
				bpf_task_park(U64_MAX, 0); /* no timeout */
		}
		return 0;
	}

	SEC("syscall")
	int start(struct start_args *ctx)
	{
		struct task_struct *t;

		t = bpf_kthread_create(worker, ctx->arg, 0);
		if (!t)
			return -ENOMEM;
		bpf_kthread_bind(t, ctx->cpu, 0);
		bpf_kthread_start(t, 0);
		/* Keep t in q for bpf_task_wake() and bpf_kthread_stop(). */
		...
	}

	SEC("tp_btf/mm_vmscan_direct_reclaim_begin")
	int BPF_PROG(reclaim_begin, gfp_t gfp_flags, int order)
	{
		struct task_struct *t;

		bpf_rcu_read_lock();
		t = q->worker;
		if (t) {
			WRITE_ONCE(q->ready, 1);
			bpf_task_wake(t, 0);
		}
		bpf_rcu_read_unlock();
		return 0;
	}

A syscall program parks the same way, in the user thread that runs it.

Sleeping for an unbounded time is new for BPF programs, and most of the
series is about keeping it safe:

 - The park drops the program's Tasks Trace RCU section and its CPU pin
   for the sleep, since neither may be held that long. It is therefore
   limited to syscall programs and kthread bodies, whose runner holds
   the program for the whole run, and the program may resume on another
   CPU. The verifier invalidates the pointers the sleep may free, such
   as hash map values, and refuses the park in other callbacks, under a lock,
   in RCU, preempt-disabled and IRQ-disabled sections, and while a
   dynptr or an iterator other than bpf_iter_num is live.
 - The wake is available to every program type and in every context.
   Where it cannot be issued, with IRQs disabled under the scheduler's
   locks or in NMI, it is deferred to irq_work.
 - A program's threads end with the program: releasing its last
   reference stops them. A stop is cooperative, so a thread body has to
   check bpf_kthread_should_stop(), and it cannot loop without a bound.
   The kthread kfuncs are for syscall programs only for now.
 - Tail calls, the stack in arena and may_goto do not know yet about a
   program that sleeps and may resume on another CPU. They are refused
   for now in a program that parks or uses the kthread kfuncs, so a
   loop in such a program needs a bound of its own, as bpf_repeat()
   gives it.

Kumar Kartikeya Dwivedi (20):
  bpf: Add bpf_task_park() and bpf_task_wake()
  bpf: Invalidate what a bpf_task_park() sleep may free
  bpf: Refuse bpf_task_park() in callbacks
  bpf: Propagate bpf_task_park() through global functions
  bpf: Verify a function that parks in the context of its caller
  bpf: Defer bpf_task_wake() to irq_work when IRQs are disabled
  bpf: Keep programs that park away from per-CPU state and tail calls
  bpf: Register bpf_task_park() for syscall programs
  bpf: Register bpf_task_wake() for all program types
  bpf: Add BPF kthreads for syscall programs
  bpf: Let a BPF kthread sleep in bpf_task_park()
  bpf: Add bpf_kthread_bind() to pin a BPF kthread to a CPU
  bpf: Add bpf_kthread_attach_cgroup() to place a BPF kthread in a
    cgroup
  selftests/bpf: Test bpf_task_park() and bpf_task_wake()
  selftests/bpf: Test what survives bpf_task_park()
  selftests/bpf: Test bpf_task_park() across functions and callbacks
  selftests/bpf: Test bpf_task_wake() from tracing programs
  selftests/bpf: Test BPF kthreads
  selftests/bpf: Test bpf_kthread_bind()
  selftests/bpf: Test bpf_kthread_attach_cgroup()

 include/linux/bpf.h                           |   5 +
 include/linux/bpf_verifier.h                  |  15 +
 include/linux/cgroup.h                        |   3 +
 include/linux/filter.h                        |   7 +
 include/linux/sched.h                         |   4 +
 kernel/bpf/Makefile                           |   2 +-
 kernel/bpf/arraymap.c                         |   7 +-
 kernel/bpf/cfg.c                              |  23 +
 kernel/bpf/core.c                             |   1 +
 kernel/bpf/diagnostics.c                      |   3 +
 kernel/bpf/diagnostics.h                      |   1 +
 kernel/bpf/fixups.c                           |   6 +
 kernel/bpf/flow.c                             |   3 +-
 kernel/bpf/join.c                             |   4 +-
 kernel/bpf/kthread.c                          | 572 ++++++++++++++++
 kernel/bpf/states.c                           |  10 +-
 kernel/bpf/syscall.c                          |  12 +-
 kernel/bpf/task_park.c                        | 311 +++++++++
 kernel/bpf/verifier.c                         | 279 +++++++-
 kernel/cgroup/cgroup.c                        |  45 ++
 kernel/fork.c                                 |   2 +
 .../testing/selftests/bpf/bpf_experimental.h  |  12 +
 .../selftests/bpf/prog_tests/bpf_kthread.c    | 641 ++++++++++++++++++
 .../selftests/bpf/prog_tests/task_park.c      | 311 +++++++++
 .../testing/selftests/bpf/progs/bpf_kthread.c | 414 +++++++++++
 tools/testing/selftests/bpf/progs/task_park.c | 218 ++++++
 .../bpf/progs/verifier_arena_stack.c          |  27 +
 .../bpf/progs/verifier_bpf_kthread.c          | 398 +++++++++++
 .../selftests/bpf/progs/verifier_task_park.c  | 550 +++++++++++++++
 .../bpf/progs/verifier_task_park_frames.c     | 393 +++++++++++
 30 files changed, 4270 insertions(+), 9 deletions(-)
 create mode 100644 kernel/bpf/kthread.c
 create mode 100644 kernel/bpf/task_park.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/bpf_kthread.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/task_park.c
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_kthread.c
 create mode 100644 tools/testing/selftests/bpf/progs/task_park.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_bpf_kthread.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_task_park.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_task_park_frames.c


base-commit: 0fb18ce8a2e9de830433923cf65838933d615359
-- 
2.53.0

