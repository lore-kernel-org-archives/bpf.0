Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794425991;
	b=FqCe+XgplwMMcY+5fUr60wykhnmKPfDvqdELu75b4aV3pmyC8wBa8nbcnrfLpQpdNkfz
	 E+cwf+XA08X0TP9dXpgLDqltMRmkJwTqMOzoC9CLNxxuJ/iIG/OU4rmLsxiBP18x8eNex
	 fHIWG+FR+GbWSMEL7dmuFCh1utB3ga1Kj9V7hAw4uBV5+9WgHSGennoKB81JzO8wjd1rj
	 StK2B9XmzvJxseduE3+KLeMXKKJzOEDQvajah/cqi8YDiIasWDkbnAJ4R8dKqMHnwOGpq
	 60HKv8S3XJ6BVT+QMYmqK6do53FJ0ziWvygJQxYZCpJIxfT1dRzP9HeMQlL40LWLIBA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794425991;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=FEQamrsPo6urht7cJ67TRsra9oOnDxC/CoYlG8i+IMU=;
	b=sLlTYQcgGrQlWurPb+SmMcqn8/wnaBV3aet339P54wZJ9LAvWlF82NfCnrNNJnTQRKbH
	 iWPJLRKnyydqUGKAMLJlEVhbXhFFry9XicB42wCebUfv8BIM6sqglHSHL6BfnNbVr1gW5
	 CcZ4RRJh+UwSU4smJKKfZDqQ8OumPQ1CGTp0qxvbrdcIBLQpCnW5COll87nNpGv/zHEo2
	 smFwCh3qylPuGaOsCZQnK3el0puQWSDhR6lvmHHK3nVJ7OCohfNUgEdH/knUST9Xwsk2R
	 uDvRca32N3F5J4E7yp0uF/p4Q7gYI+igGqtfcsJI7wZGQ5ERmvdd0YGv5GF3QV+okvA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oyhm0Qjq;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC7A0606A32A;
	Wed, 11 Nov 2026 19:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oyhm0Qjq
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794425991;
	b=g24p0YPxV8xO+RpwEsyaGthXbZ+IiV5gs+hHdxWZhAPAy9+55nJjNLefFGuIJ+YHM4V0
	 SXZAPEQ+HXpPqsiz6LTouImxl3DSdXE1lREpPAV/IjeonqSnryROh8dfMW+MdBm0ewAYZ
	 qph3Rndo7jquec5bBw3MjNOp42wn2Kdkkf5WneNzVGnQuJdDgXnu2vTvvafIPN+h402s7
	 bZlEfU2j88JbgURK6dDsdioDpk/qM1ZsDmznhDuB4K++sWtgy0TngJXIUmXO4FxaHjRo2
	 8usib6lL6UpY/G6gr1ctj9Sh5zy5+u6Q/EIxZ1hUNAMSdqD4a2orcPvBRUMHYfuh3NQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794425991;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=FEQamrsPo6urht7cJ67TRsra9oOnDxC/CoYlG8i+IMU=;
	b=DHWJziBb76vt2OJ4rSX6BHpT2iPkpeRLQqCHPvo3gGjONm+zuLSseJOUqj+8nrBvM1P+
	 8bEgxzl3RKSinhuWRhzURCNXdOIcZt7Kim8Y6hz6ZfinOGDqd/jkQy3VKBSV4YrSlQlDy
	 vU+n8Kh1NB8QM6keuHPGMpSkoTr01tqyyz9GMlia8F5R/RZqdYmEBG9/WdMljameu9Sw+
	 QS4IeLy2FAFRV2dXcmpSbVS2KW882pZbgFMrov3VlqKUI8H6pGOeER9GRcGOkn2Rf7uJe
	 jDLhK4c1Br126Itkf/wIiysQ1zACqkb/KSy45BggwuUK79aVfyjInjbEx3OdoXkCU0w==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id BA1601F00A06;
	Wed, 11 Nov 2026 19:39:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794425991;
	bh=FEQamrsPo6urht7cJ67TRsra9oOnDxC/CoYlG8i+IMU=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=oyhm0Qjqbr4EGrx8e025NMs2iHvXqJmXdkifm86oz4nTkhqezQuflI3npRwEi9rSj
	 T8nWMd2MWlwu4aaKnEYoyqapT6b6LaybVKR55MFWmoK8Zd17ZuJfO6KZQskzpiT9og
	 lCCwiUEAwsilr/ENGTuXdW9gL2joqDb9HwnBZPAw/C+JzKO/heDjl/HkDTbe90Pmdm
	 nBBwHZSD9a5qBDoVuRvNrr62UT6XI7ro2PmQMFrH+Sf5mzXSa32+WCg/znLM9P0RGK
	 IcH0rhW9dvp45Zpb87pWb7iNJiG3OMu1iJAEOGrB5YlUqDQegnQFhzwoe1X6DIW5gX
	 sVCUAP4HELFXQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 457E3490BA;
	Wed, 11 Nov 2026 19:39:50 +0000 (UTC)
From: Mike Bazov via B4 Relay <devnull+mikeba.sentinelone.com@kernel.org>
Subject: [PATCH bpf-next v2 0/5] bpf: Check recursion per task for
 preemptible programs
Date: Wed, 11 Nov 2026 21:39:46 +0200
Message-Id: <20261111-bpf-preempt-v2-r2-v2-0-9d8f6b952ad2@sentinelone.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAILE9GoC/x2MwQqEMAxEf0VyNqBhXXB/RTy0NtUctltSEUH8d
 9Od28ybmQsKq3CBT3OB8iFFfskMtQ0sm0srowTzQB29exP6HDEr8zfveBAqYRzj6LrgwxBeYDu
 jUc7/5wS1nvjcYTbiXWH06tKy1U+b1wTu+wEeWWynhwAAAA==
To: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>
Cc: Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Emil Tsalapatis <emil@etsalapatis.com>, 
 Ihor Solodrai <ihor.solodrai@linux.dev>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 JP Kobryn <jp.kobryn@linux.dev>, linux-trace-kernel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Mike Bazov <mikeba@sentinelone.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794425986; l=7090;
 i=mikeba@sentinelone.com; s=20261022; h=from:subject:message-id;
 bh=LnQxenO2766xlJbzVCrrwOOFPUjVzlBWWREwY5b6Gkw=;
 b=Dn6g7Cnpd+M2gnaHODrGbsuqgZ2AsyoQ16gWyQpXx1aDsAJSq9CUqKtv2Xji2GAVNBv+T7v2u
 sDmRS2JTvCpCbHDMPiTLMnfiNzstDSRPy7rlzn7vPlCL9ozZ1XzP+MK
X-Developer-Key: i=mikeba@sentinelone.com; a=ed25519;
 pk=DBXcQ0qoCkgacRsRwT1JU7oOWpWSYuTyLiXMfNLcP+A=
X-Endpoint-Received: by B4 Relay for mikeba@sentinelone.com/20261022 with
 auth_id=1284
X-Original-From: Mike Bazov <mikeba@sentinelone.com>
Reply-To: mikeba@sentinelone.com

Tracing programs run preemptibly: trampoline programs only disable
migration, tracepoint probes run under SRCU-fast, and syscall tracepoint
and sleepable programs can fault. Their recursion check is a per-CPU
counter:

  CPU N
  -----
  task A enters prog -> prog->active on CPU N becomes 1
  task A is preempted inside prog
  task B enters prog on CPU N -> prog->active is already raised:
    the run is dropped and counted as a recursion miss
  task A resumes and finishes -> prog->active drops to 0

Nothing recursed, but task B's event is lost. Before 7.0 this was mostly
hidden, because distribution kernels used PREEMPT_VOLUNTARY. Commit
7dadeaa6e851 ("sched: Further restrict the preemption modes") left only
lazy and full preemption on x86 and arm64, so 7.0+ distribution kernels
drop such events in normal operation. Programs can't work around it: the
counter is checked before their first instruction.

In a production security agent with paired fentry/fexit programs on
inet_sendmsg() and inet_recvmsg(), a dropped half breaks the entry/exit
pairing and desynchronizes stateful protocol parsing. On a stock 7.0
kernel, 4,063 of 38.0M runs were dropped under 10 minutes of HTTP load.
v1 has the detailed analysis and a standalone reproducer.

This series checks recursion per task instead. Each run already links a
run context into the task's chain (current->bpf_ctx); the run context
now records the program, and the check walks the task's chain. Real
recursion, including through interrupts and NMIs, which run on top of
the interrupted task's chain, is still rejected; a second task is not.
Programs that keep a private stack keep the per-CPU check.

Patch 1 comes first and stands on its own. A per-CPU private stack is
only safe if a program never runs in two tasks at once on one CPU, and
that already happens on bpf-next today: two raw_tp dispatchers
tail-calling one handler, or one tracepoint program attached to a
syscall and a regular tracepoint, let a second task overwrite the
preempted task's stack. The selftests reproduce both. Patch 1 stops
giving tracing, raw_tp and tracepoint programs a private stack. Without
it, the per-task check would let a dispatcher in while its tail-call
target still uses a per-CPU stack.

  1. bpf: Avoid per-CPU private stack in preemptible tracing progs
  2. bpf: Check program recursion per task via bpf_ctx
  3. bpf: Check recursion per task for programs on syscall tracepoints
  4. selftests/bpf: Add trampoline and raw_tp preemption recursion test
  5. selftests/bpf: Test syscall tracepoint programs under preemption

Behavior changes worth a look:

- On the kernel stack, the frames of a call chain share one stack
  budget, while a private stack checks each frame on its own. Programs
  whose frames only fit separately no longer load, e.g. a raw_tp program
  with two 2000-byte frames: "combined stack size of 2 calls is 4000.
  Too large". Is that acceptable, or would an opt-in private stack, which
  would keep the per-CPU check, be preferred as a follow-up?
- Raw tracepoint programs were the only ones with a private stack that
  BPF_PROG_TEST_RUN runs, so unwinding on a private stack is now checked
  in the generated code only. A run-time test could use bpf_testmod's
  struct_ops that requests a private stack: wanted in this series or as
  a follow-up?
- The same program can now run in two tasks at once on one CPU, so a
  program using a per-CPU map as scratch space can see another run's
  data.
- Timed may_goto keeps its budget per program and CPU, as before: a run
  in another task can renew the budget of a preempted run.

Testing:

x86-64 VM with 4 vCPUs, full preemption, bpf-next 0fb18ce8a2e9 with and
without the series.

- The same test_progs binary on both kernels:

                                            bpf-next    series
  trampoline_preempt, 14 preemption         all fail    all pass
    subtests (20 rounds each, the
    overlap is checked in every round)
  trampoline_preempt, 4 recursion           all pass    all pass
    subtests
  verifier_unwind, may_goto_priv_stack,     pass        pass
    timed_may_goto, test_global_funcs,
    recursion, task_local_storage

  On bpf-next the second task is dropped in every round of every
  preemption subtest, and two_dispatchers and tp_dual also corrupt the
  preempted task's stack.

- HTTP load: nginx -> gunicorn -> Redis on the VM, the production
  fentry/fexit probe (8 programs on inet[6]_{send,recv}msg()), 4
  CPU-bound tasks, and 200,000 requests from wrk on each kernel:

                probe runs    recursion misses
  bpf-next       7,966,760               9,254
  series         7,976,662                   0

Changes in v2:
- v1 kept recursion-checked trampoline programs non-preemptible. As
  discussed on v1, v2 checks recursion per task instead, using the
  bpf_ctx chain, so programs stay preemptible.
- Cover raw_tp/tp_btf, sleepable trampoline programs, BPF_PROG_TEST_RUN
  and syscall tracepoints, not only trampolines.
- New patch 1: no per-CPU private stack for these program types, which
  also fixes two existing stack corruptions.
- New deterministic selftests: every round forces a second task into the
  program while the first is preempted inside it, proves the overlap,
  and checks the preempted task's stack; plus true-recursion tests.

v1: https://lore.kernel.org/bpf/20261025-b4-bpf-trampoline-preempt-v1-0-198dcdc0c6ac@sentinelone.com/

---
Mike Bazov (5):
      bpf: Avoid per-CPU private stack in preemptible tracing progs
      bpf: Check program recursion per task via bpf_ctx
      bpf: Check recursion per task for programs on syscall tracepoints
      selftests/bpf: Add trampoline and raw_tp preemption recursion test
      selftests/bpf: Test syscall tracepoint programs under preemption

 include/linux/bpf.h                                |  54 ++-
 kernel/bpf/trampoline.c                            |  28 +-
 kernel/bpf/verifier.c                              |  43 +-
 kernel/trace/bpf_trace.c                           |  12 +-
 net/bpf/test_run.c                                 |   4 +-
 net/ipv4/bpf_tcp_ops.c                             |   6 +-
 .../selftests/bpf/prog_tests/may_goto_priv_stack.c |   6 +-
 .../selftests/bpf/prog_tests/timed_may_goto.c      |   6 +-
 .../selftests/bpf/prog_tests/trampoline_preempt.c  | 464 +++++++++++++++++++++
 .../selftests/bpf/progs/may_goto_priv_stack.c      |  14 +-
 .../selftests/bpf/progs/test_global_func3.c        |   9 +
 .../selftests/bpf/progs/timed_may_goto_user.c      |  16 +-
 .../selftests/bpf/progs/trampoline_preempt.c       | 302 ++++++++++++++
 .../selftests/bpf/progs/verifier_private_stack.c   |  65 +--
 .../testing/selftests/bpf/progs/verifier_unwind.c  |  33 +-
 15 files changed, 975 insertions(+), 87 deletions(-)
---
base-commit: 0fb18ce8a2e9de830433923cf65838933d615359
change-id: 20261111-bpf-preempt-v2-r2-f9f9a0dbd5d4

Best regards,
-- 
Mike Bazov <mikeba@sentinelone.com>


