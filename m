Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793911516;
	b=vX2pCWEmWOLO71K4jW+yY+JbnsyaABdQGaRCtWweHai3tJtvWIxQeDtBkVHWzaIZue0Y
	 XHiTuK1r8JIWVy6Dni/bhmkNwH28yZytpq+PBiQ5s1W5ESjer068FI9ob6Chi4vBMD2Bs
	 URfouQapaj5leZY3Eay5PHmriEVxK06iqEu3rEQLlA4U2WuEUTqkGPzA4vr6A15ZjQUqj
	 tOjK/6eGLjYKEqG/lw8PR9+f6xTtxAlnhJmZRBPn0CBOkE4dqINCHWpz/BV8evjSNFga1
	 UIUfxt0tr4Fyx7hkU5/q5h23kkVVohGrA7VecvDonZtfUgCIdGhBstRtJrAUL2X+f6g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793911516;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=jxMrgeHHX9V93x+I2ilGX+NqVCSsuK+9fgNH6KyUhC4=;
	b=MDEvJUu6Jzd33Dqz9VjE4jRupqsEUaFy8BKQhKjk7kNpx8EtF8Rnvz4hTFrwenSBO7ET
	 xuD3/RtcHWbaPnFuh5iIx8zwPdb8rK3eFNmmhxiO9xKmfbgrlJygRT6+dm4KUW4hRzLLB
	 lhACt0hKLGj9oKNyBsDwr25FHk/cUjkF8GLk+ZCD5mYc191gRSkk0sEVhcWLj7Wrb86q4
	 pFGbpF6rhWloPDpr0VcAtbKV8GuoR61OxgmYgc+Oj0CFurnm7raHgc8MTd0qIm7wlhDcB
	 fY+VQa6qrZK8656vgekZKfZiO8ZAQIM2Zu+5rGgI2t7jhurLjqrg+2g0hNntfLb/CRQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=L0cYInY+;
	arc=none smtp.remote-ip=209.85.215.176
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B5A0606A326
	for <bpf@vger.kernel.org>; Thu,  5 Nov 2026 20:45:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2B5A0606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=L0cYInY+
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-cdb2e0062bbso939181a12.1
        for <bpf@vger.kernel.org>; Thu, 05 Nov 2026 12:45:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793911515; x=1794516315; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=jxMrgeHHX9V93x+I2ilGX+NqVCSsuK+9fgNH6KyUhC4=;
        b=L0cYInY+nt8UVqfvbs163ME6aHBs5aFAes6F4j1dQdZn72sT2EwWHZjNufClu//yR7
         +eVZ/YQDNr2J+x3r9RhAH9xrsWWhp3USwQOnfdgdP1h7muBPLx1+kCZKptU5GuBFiIi3
         R+T0U7WlDC/bVVi6pmQZvY42n4rH6enqqRB7cpoicenvZbHaWFHF2AUjc1/yI2zcWFVm
         tewD2RMd4D8XAWpIstXT0pAG7lThTscRKAqxUyx7l5Uk+38pUJv35M16NDevosl7i/TN
         AxLk8bET7qpXg/nnIMQq6l+C/N8Axn6tJnhktTjEr61XL041jgftos3vlSApycaUHkj0
         wCxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793911515; x=1794516315;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jxMrgeHHX9V93x+I2ilGX+NqVCSsuK+9fgNH6KyUhC4=;
        b=RMlrtLENJEf5lA7bm1aFEVHKyab9IUfU1UfCXl55d3Jw0oKGt0fxOMyDtH9yjXNa+U
         nQtMcLvPeq7SBQzbNMVokdL1AAPUfYc8N295jVj+m4Ysh87VSvv0vWQCyfyU1+OELs/P
         c8pbS64ueKxzwpu4eB9JQhVGhflOrSHnJky+oZ2CLBpdZZTrqXfZ1sbokkqdzjX61e71
         uuQbj6EhWETcfXQkM63XqH3kX8Ln7+NVeeZr2J0zW1ik/XWV03S7yylWCurfGyzRBKXu
         yNHDdtYDuVIsB7SPBNO4CWMcqpBH67ir5GRvVu9S0HWRCCEuYFDig8qBPbFl8+3aYfdz
         G+xg==
X-Gm-Message-State: APuU4Z8jdo+vCcVqgoF5gnRInNbCXmGhFWEY/Ndv40GKlitJDlAxwTOY
	nRG6JNjVw1yrpfP0bKNsIFjcWx30PZM70TFuPLnGmXEoNSKVrjUtl4Gym0lvBA==
X-Gm-Gg: AYBFou04x1sjdtCVK6AemNCW/P9ffMAVX4w2bUCVzOVn09MK73rZg5uVlXPyKzAcyuK
	JvjG3tdraQ75JzN2SnfN1TC+GLWxdS4xHUymAmvEovpsXsI3mtrTXBt4JgzZx/N36Uh3DbAKd14
	isYpPO07HWGJNfbxyqqIC4A84W13985iMxjQqeCvOFHL+twSWobmUwWSCAM7Ic6kfOxvw5tNQtt
	qkJpMngeBp7afDLPXmTD1btUhRz+RGHVTrcRE4xxwVTWbJp7riiMjG2QJlwMaqJXteLPiqd6vqF
	NzuUxiJWlngbhoJ2B7/xIg0BxLTTb5G6EW1oB+PRFFj30DwrWoRqrfXitrb6NoNfWduRrIxGYHO
	op5GJ1rVDbLhtZ1rQg3PFGtcE4vO4RjiLmbUz80SRLcLu5D+r8/Kfp7tb+QmgaL7Qxvu4ykzoEN
	kqQzLEUJjw2qJWHY1vdfOdSfw5iQz28XXOE+Wh8+Vpx/OI7A/NH49QQ7o768wkSC5nKY7ZB3lhr
	7mezRrznZW20L26fyL0wQVCOjQE5Al4Gi2LWy3r4+cm1GJUTzfgX2+0CUlXdTg1lJT8Vcg1Z4hN
	N+rNI1K9jhbt5J5OVYuYmzLFBixPrb+Nk244riijgwh8x7tldLO5Qg7M1GrQAhJMp4FhhozhGQ7
	4j10/LCrHdIk2ce/mAoBJ705RXuXEsZSmoZXURUD74KoIkvd1SfUtxUFjXl4RsnbbjiYBVa9yBD
	Y=
X-Received: by 2002:a17:90a:e190:b0:3ac:a7ee:678c with SMTP id 98e67ed59e1d1-3b0db60a4f7mr246648a91.2.1793911514997;
        Thu, 05 Nov 2026 12:45:14 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.251])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b0b328a04asm5039178a91.14.2026.11.05.12.45.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 12:45:14 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next v2 00/35] bpf: A verifier that joins states
Date: Thu,  5 Nov 2026 20:44:37 +0000
Message-ID: <20261105204513.2230344-1-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
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

The verifier follows each path of a prog, and each branch can double the
number of paths. The work grows with the paths, not with the prog:
  insns processed                                    today    this series
  rust-bpf  scx_beerland/beerland_init_task        1000001 *        17893
  rust-bpf  scx_qmap/qmap_init_cids                 131088 *          196
  scx       scx_eevdf/eevdf_dispatch                350041          15199
  Cilium    bpf_host/cil_to_netdev, Oct 2026         64658           7472
  * "BPF program is too large", "The sequence of 8193 jumps is too complex"

Authors cut their progs until they fit. Nobody can cut core, alloc and the
crates of Rust: of the 653 progs of https://github.com/4ast/rust-bpf 187
load today, 170 hit one of these limits, 164 get "infinite loop detected"
and 122 "recursive call". Now 648 load, and no corpus of C progs loses one.
For rust-bpf both kernels have 4 kfuncs on top, see Numbers.

The idea
========
Do not follow paths. Where paths meet, join their states: r1=1 and r1=5
give r1=[1,5]. Repeat until no state changes. States stay apart only if
they have no join, or if a later check depends on the difference.
  loops      counted by scalar evolution: one state covers all iterations
             walked: a state per iteration, while constants decide an exit
             all other loops: join at the head, widen, add may_goto
  subprogs   A static subprog is verified for the states at its entry, not
             for each chain of calls. Recursion is the same, with widening.
  run time   may_goto limits the time of loops and of recursion. r10 limits
             the depth: it must be in the upper half of its kernel stack.

What users see
==============
 - The limits of 1M processed insns and 8192 jumps are gone. The limits are
   on states, for a prog of N insns: 1024 at an insn, 16 * N + 4096 at
   a time, 256 * N + 64K in all.
 - "infinite loop detected" is gone: the verifier adds may_goto. A loop
   that has no exit gets "loop at insn N never exits".
 - may_goto is also added to 5 progs of the table below that load today:
   loop1, loop2, loop5, tcp_autolowat_enqueue_rcvq (GCC), chaos_enqueue.
 - Recursion is allowed on x86-64 and arm64. Patch 22 lists the exceptions.
 - All added may_goto of an invocation share its time slice of 250 ms. Then
   the prog returns 0. A subprog that cannot unwind, or a frame that holds
   a lock or a reference, leaves the loop. The stderr stream has the cause.
 - A join loses the relation between scalars. This is rejected now:
     if (c) { i = 3; n = 4; } else { i = 7; n = 8; }
     x = arr[n - i];                                    n - i is [-3, 5]
 - A cgroup_skb prog whose r0 can be 2 or 3 attaches to egress only. That
   holds for a range too: 'return 1' and 'return 2' are joined to [1, 2].
 - The log has no "mark_precise:", "N: safe", "depth=" and no scc column.
   Level 2 shows "from 13 to 9: within", "joined" or "widened" where states
   meet. The statistics line keeps its format: "limit 0", "mark_read 0".
 - BPF_F_TEST_STATE_FREQ is accepted and has no effect.

Numbers
=======
A: bpf-next 8424858a5de0. B: this series, the same objects. The selftests
that the series adds or changes are not counted. None of them is lost.

Corpus                 Progs  Lost  Gained  Insns  States   Mem  Time
---------------------  -----  ----  ------  -----  ------  ----  ----
selftests               3043     0       1   -63%   +120%  -18%  -27%
selftests, no_alu32     2905     0       1   -66%    +86%  -27%  -34%
selftests, cpuv4        2914     0       1   -64%    +96%  -27%  -32%
selftests, bpf_gcc      2733     0       5   -69%    +96%  -16%  -24%
37 builds of Cilium     5189     0       0   -75%    +11%   -6%  -31%
sched-ext/scx            495     0       0   -89%    -34%  -66%  -67%
scx, as BPF CI has it    428     0       0   -85%    -22%  -38%  -39%
tools/sched_ext          240     0       0   -69%    +37%   +3%  -11%
public progs of Meta     511     0       0   -85%    -35%  -55%  -48%
all                    18458     0       8   -74%    +10%  -19%  -36%

Progs load in A and in B. The per cent compare sums over these progs:
75.1M -> 19.2M processed insns, 61 -> 39 s. Mem is mem_peak of veristat.
Time is the best of 3 runs on kernels without debug options. B counts each
state that arrives at a basic block as a state, A only those that it saves.
Gained: loop3 in the 4 builds, 4 progs that A rejects only in GCC's code.
Of the progs that take 1000 insns or more in B, two take over 5% more than
in A. loop5, 82 -> 4182: a walk up to its limit of 4096 insns, then a join.
res_spin_lock_test_held_lock_max, 2356 -> 4088: states that hold different
numbers of locks have no join.

rust-bpf               Progs  load in A  load in B  B: insns   time
16 schedulers            225         52        225      1.6M  1.9 s
crates                   428        135        423      7.3M  9.4 s
For rust-bpf A and B have the kfuncs of patches 30-31 of [1] on top. They
are in no series now. No released compiler emits the code of rust-bpf.

How to read the series
======================
Start with patch 7, the overview. Then 4-5, 13-14, 15, 17 and 19.
  1-2    what is added to a prog: may_goto, the checks of recursion
  3-5    union and widening of a range, join.c: the join of two states
  6-10   data structures of flow.c, passes ahead of the main pass: order of
         the insns, places for may_goto, what later checks depend on
  11-14  the sets of states, iterations, what is not joined, the merge
  15-18  how states move: edges, calls and exits, loops, added edges
  19     the switch. The check of one insn against one state is the same.
  20-22  more counted loops, static subprogs on their own, recursion
  23-26  removal of pruning, precision tracking and SCCs: 3382 lines
  27-28  callx: a pointer to one of a set of functions, live registers
  29-35  selftests: 29-30 adjust tests, 31-35 add tests
Each patch builds. Patches 1-18 add the code that patch 19 switches to.
Some selftests fail from patch 19 to 29. flow.c has 2798 lines.

Follow-ups
==========
 - Documentation/bpf/verifier.rst: the algorithm, with examples.
 - Liveness: no spilled pointer is kept for reads that see only its bytes.
 - No second pass over the prog when a loop gets may_goto late: half of the
   insns for rust-bpf.
 - bpf_prog_info tells that an invocation of the prog was cut short.

v1 -> v2
========
v1 is part 3 of [1]. Its patches for the verifier of today and the time
slice of may_goto are in bpf-next.
 - Recursion: may_goto and r10, no per-cpu counters of bytes and calls.
 - flow.c comes in 9 patches and join.c in 2. In v1 each was one patch.
 - No public prog of Meta is lost (Ihor): widening goes to fixed stops, and
   constants that are added to a pointer to the packet are not joined.
 - A state is compared only with the states of a related shape (Ihor).
 - bpf_iter_*_next() stops a loop only if the iterator was created before
   the loop (Ihor). A loop with two entries is walked.
 - Offloaded progs get neither may_goto nor recursion (Ihor).
 - The failures of v1 in BPF CI (s390x, arm64, gcc) are fixed.

[1] https://lore.kernel.org/bpf/20261026025943.404450-1-alexei.starovoitov@gmail.com/

Signed-off-by: Alexei Starovoitov <ast@kernel.org>

Alexei Starovoitov (35):
  bpf: Add may_goto to the loops that the verifier marks
  bpf: Limit depth and time of recursive subprogs at run time
  bpf: Add union and widening of the range of a register
  bpf: Add join of registers and stack slots
  bpf: Add join of verifier states
  bpf: Tell which arguments of a call a join must leave alone
  bpf: Add the data structures of the main pass over the control flow
    graph
  bpf: Order the insns, find what stops a loop and where may_goto can go
  bpf: Find the registers that hold a number or a pointer to arena
  bpf: Find the registers and stack slots that later checks depend on
  bpf: Add the sets of states at an insn and the entries of functions
  bpf: Compare states of different iterations of a loop
  bpf: Decide which states are not joined
  bpf: Merge the state that arrives into the set at an insn
  bpf: Move states along edges, into loops and subprogs and out of them
  bpf: Make the state after a call from the caller's state and an exit
    state
  bpf: Enter and leave loops in the main pass, build flow.c
  bpf: Tell the passes over the graph where an added may_goto goes
  bpf: Verify programs as a fixpoint over the control flow graph
  bpf: Keep the count of a loop when a register has no closed form
  bpf: Verify static subprogs on their own
  bpf: Allow recursive subprogs
  bpf: Remove is_state_visited(), bpf_compute_scc() and iter.depth
  bpf: Remove precision tracking
  bpf: Remove prune points, levels of state comparison and pop_stack()
  bpf: Update comments about paths, pruning and explored states
  bpf: Track a pointer to one of a set of functions
  bpf: callx reads what the subprogs whose address is taken read
  selftests/bpf: Adjust tests to log lines that are gone
  selftests/bpf: Adjust tests to new verdicts, messages and order
  selftests/bpf: Test states that are not joined
  selftests/bpf: Test static subprogs that are verified on their own
  selftests/bpf: Test loops that are counted, walked or widened
  selftests/bpf: Test progs that run out of budget
  selftests/bpf: Test callx of one of a set of functions

 Documentation/bpf/bpf_design_QA.rst           |    7 +-
 Documentation/bpf/kfuncs.rst                  |    2 +-
 Documentation/bpf/linux-notes.rst             |    4 +-
 include/linux/bpf.h                           |    6 +
 include/linux/bpf_verifier.h                  |  526 ++--
 include/linux/filter.h                        |   16 +
 kernel/bpf/Makefile                           |    2 +-
 kernel/bpf/backtrack.c                        | 1052 -------
 kernel/bpf/cfg.c                              |  297 +-
 kernel/bpf/const_fold.c                       |   14 +-
 kernel/bpf/core.c                             |   19 +
 kernel/bpf/diagnostics.c                      |   13 -
 kernel/bpf/diagnostics.h                      |    1 -
 kernel/bpf/fixups.c                           |  360 +++
 kernel/bpf/flow.c                             | 2798 +++++++++++++++++
 kernel/bpf/join.c                             |  650 ++++
 kernel/bpf/liveness.c                         |  109 +-
 kernel/bpf/log.c                              |   14 +-
 kernel/bpf/loops.c                            |    8 +
 kernel/bpf/scev.c                             |  166 +-
 kernel/bpf/states.c                           | 1180 +------
 kernel/bpf/verifier.c                         | 2669 ++++++++++------
 .../bpf/prog_tests/bpf_verif_scale.c          |    4 +-
 .../bpf/prog_tests/cgroup_skb_egress_ret.c    |   23 +
 .../selftests/bpf/prog_tests/log_buf.c        |    4 +-
 .../selftests/bpf/prog_tests/log_fixup.c      |    6 +-
 .../selftests/bpf/prog_tests/reg_bounds.c     |    5 +-
 .../selftests/bpf/prog_tests/verifier.c       |   19 +
 .../selftests/bpf/progs/aggregate_ret_func.c  |   15 -
 .../selftests/bpf/progs/aggregate_ret_kfunc.c |    7 -
 ...f_qdisc_fail__invalid_dynptr_cross_frame.c |    4 +-
 .../bpf/progs/cgroup_skb_egress_ret.c         |   12 +
 .../bpf/progs/compute_live_registers.c        |    8 +-
 .../selftests/bpf/progs/cpumask_failure.c     |    2 +-
 .../testing/selftests/bpf/progs/dynptr_fail.c |    4 +-
 .../selftests/bpf/progs/exceptions_assert.c   |   24 +-
 tools/testing/selftests/bpf/progs/iters.c     |  114 +-
 .../selftests/bpf/progs/iters_state_safety.c  |    8 +-
 .../selftests/bpf/progs/iters_testmod_seq.c   |   12 +-
 .../bpf/progs/mem_rdonly_untrusted.c          |   16 +-
 .../selftests/bpf/progs/stack_arg_precision.c |   48 +-
 .../selftests/bpf/progs/test_global_func15.c  |    5 -
 .../selftests/bpf/progs/test_global_func3.c   |  125 +
 .../selftests/bpf/progs/timer_failure.c       |    9 +-
 .../selftests/bpf/progs/verifier_align.c      |   10 +-
 .../selftests/bpf/progs/verifier_and.c        |    4 +-
 .../bpf/progs/verifier_arena_stack.c          |   49 +
 .../bpf/progs/verifier_array_access.c         |   14 +-
 .../selftests/bpf/progs/verifier_bounds.c     |  114 +-
 .../bpf/progs/verifier_bounds_deduction.c     |    2 +-
 .../bpf/progs/verifier_bounds_step.c          |   73 +-
 .../selftests/bpf/progs/verifier_budget.c     | 1873 +++++++++++
 .../bpf/progs/verifier_calls_in_a_row.c       |  170 +
 .../selftests/bpf/progs/verifier_callx.c      |  128 +-
 .../selftests/bpf/progs/verifier_callx_many.c |  113 +
 .../bpf/progs/verifier_callx_rodata.c         |  167 +-
 .../selftests/bpf/progs/verifier_cfg.c        |    8 +-
 .../bpf/progs/verifier_global_subprogs.c      |   11 +-
 .../bpf/progs/verifier_helper_value_access.c  |    8 +-
 .../selftests/bpf/progs/verifier_idoms.c      |    9 +-
 .../bpf/progs/verifier_iterating_callbacks.c  |   70 +-
 .../bpf/progs/verifier_jumps_ahead.c          |  555 ++++
 .../bpf/progs/verifier_linked_scalars.c       |    7 +-
 .../selftests/bpf/progs/verifier_live_stack.c |   37 +-
 .../bpf/progs/verifier_liveness_exp.c         |    7 +-
 .../selftests/bpf/progs/verifier_loop_as_is.c |  198 ++
 .../bpf/progs/verifier_loop_hierarchy.c       |  125 +-
 .../selftests/bpf/progs/verifier_loop_latch.c |    2 +-
 .../selftests/bpf/progs/verifier_loop_need.c  |  320 ++
 .../selftests/bpf/progs/verifier_loop_walk.c  |  197 ++
 .../selftests/bpf/progs/verifier_loops1.c     |   16 +-
 .../bpf/progs/verifier_map_ret_val.c          |    2 +-
 .../bpf/progs/verifier_mem_size_reg.c         |   52 +-
 .../selftests/bpf/progs/verifier_movsx.c      |    3 +-
 .../selftests/bpf/progs/verifier_precision.c  |  186 +-
 .../selftests/bpf/progs/verifier_ptr_off.c    |  225 ++
 .../selftests/bpf/progs/verifier_scalar_ids.c |  329 +-
 .../selftests/bpf/progs/verifier_scev.c       |  198 +-
 .../bpf/progs/verifier_search_pruning.c       |   40 +-
 .../selftests/bpf/progs/verifier_spill_fill.c |  224 +-
 .../selftests/bpf/progs/verifier_spin_lock.c  |    4 +-
 .../selftests/bpf/progs/verifier_stack_arg.c  |  139 +
 .../selftests/bpf/progs/verifier_stack_ptr.c  |   13 +-
 .../bpf/progs/verifier_subprog_callers.c      |  509 +++
 .../bpf/progs/verifier_subprog_insn_stats.c   |   16 +-
 .../bpf/progs/verifier_subprog_precision.c    |  353 +--
 .../selftests/bpf/progs/verifier_tailcall.c   |   27 +
 .../selftests/bpf/progs/verifier_uninit.c     |    2 +-
 .../selftests/bpf/progs/verifier_unpriv.c     |   23 +-
 .../bpf/progs/verifier_unpriv_perf.c          |    4 +-
 .../bpf/progs/verifier_value_or_null.c        |    2 +-
 .../bpf/progs/verifier_value_ptr_arith.c      |   61 +-
 .../selftests/bpf/progs/verifier_var_off.c    |  206 +-
 tools/testing/selftests/bpf/verifier/calls.c  |   46 +-
 .../testing/selftests/bpf/verifier/precise.c  |   69 +-
 95 files changed, 12210 insertions(+), 5197 deletions(-)
 delete mode 100644 kernel/bpf/backtrack.c
 create mode 100644 kernel/bpf/flow.c
 create mode 100644 kernel/bpf/join.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/cgroup_skb_egress_ret.c
 create mode 100644 tools/testing/selftests/bpf/progs/cgroup_skb_egress_ret.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_budget.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_calls_in_a_row.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_callx_many.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_jumps_ahead.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_loop_as_is.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_loop_need.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_loop_walk.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_ptr_off.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_subprog_callers.c

-- 
2.55.0

