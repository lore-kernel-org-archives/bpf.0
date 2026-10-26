Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792983587;
	b=DIB5/+AxsIZfj3p+dwZ35ii8APUsqIO/Vzabl+gxVl6mOtAy2heyaXrG0ECNyaa/UkMV
	 vqGIprkLum4wI39TH5pTi4oDr2CNHuDf95Xg/ZL/tvZpNlORU3lihGC+LR/9vRT/bPpk7
	 DN328WRY/PTOhLGgZoBKdGWXb+D50UVf/TxBHQhO3njzN6RDPkOGvuAHcUstapkKKczyO
	 +pyk2eb8hTWmdUUBapVJiNRLvD4zprjUkZs+v/WmQpsAZ7c3HwZ1Y9JWINTGcjKQ7UfHI
	 oc6m8KpF9MBoFkvosfkktuaWXMZ34VT6k6BHaEjm7gy929NpQn2wa5Chf1K8O5uj65Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792983587;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=oFsLGa9o8kE/lUa0i6JTY83rBh221IrItOa8FhU14cQ=;
	b=c9ta7A4D7nH2gM42g8e9i1J/K7h3sBMmrdWZrHwUWeHojK8neuVJBRrjbFNCoS/SHL0C
	 Aiw58CTdHZPFCqWapQyRHcLaTsZCi1//BCUKMQ2kJZFzuvBjIDXzsh0W1DkOger1yPrbF
	 XEUB/LA/vRl7qKTkIuSRWWdTM4fs57fRh/1vARx76HG0YxTnwIkG/vtNH8cDX+NW/TGFi
	 KWnjNxrJqUT4jBh/mj58lkUDf5wJp0f/tHa0PViyBu6B9/v7Ab0x0z11oTxW9grLz6e1g
	 CKP0wNW72c9qmHCJ9G6yOZoc1YdHYpHSQ3KBTX8l5v8LaeESgmPajsFX87sY/vYUuaA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=JUI+z0Ul;
	arc=none smtp.remote-ip=209.85.210.181
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9B00606A31A
	for <bpf@vger.kernel.org>; Mon, 26 Oct 2026 02:59:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C9B00606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=JUI+z0Ul
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-8a05b210703so947587b3a.0
        for <bpf@vger.kernel.org>; Sun, 25 Oct 2026 19:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792983586; x=1793588386; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=oFsLGa9o8kE/lUa0i6JTY83rBh221IrItOa8FhU14cQ=;
        b=JUI+z0Ul/yH1P1++VS8qNsHg1FUfqgA/9UEme8JzwjtlQ/hQali9D3CSfw+OCRKmhG
         LuI+tThyT2hvbhkdI09qir4rroHY11nI2gIzFUSCl4tJ0WdznvX3roB54xIZB48nFr4H
         qidM2lhJ0LW+X1k5sXlMSDgEpIinqiyBFMwq8NOEWznixzNpPEvQ/7TcMX9R2f9FfgSz
         xRo6sLOLX27XJ1mcwF4lENAr+tDDEWwUGN7yLo+hej75AA9lCLhm9G3tZEW5+hSbL9Rn
         7Sqq9MLf1Ebh+2QVJ6d44x4BO9DaxE01/0vaEBZ4bIDCLXXly1YvyJoSy9It/GBRA19h
         Ygyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792983586; x=1793588386;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oFsLGa9o8kE/lUa0i6JTY83rBh221IrItOa8FhU14cQ=;
        b=DHeIFVBrW/QBaUa/9mMvqOAfJ55WAxE8AIaaocmPbj/56qOfJVEon0nUl4Qz7ddU8+
         PPJcE9/Pn8f1a2msO23P+XGI9BFDkBIhfvjIlqZxYc+siu+E0P6E2RUu/m3V9N0ZCxoh
         hs/+QUvc6sS8j5c9SRNHrOXkIqbDrCmwIpxgMo0VVp9TvgzG8GLdvFqifq/1sOhZJ+/B
         uTkHe+Nle2e8nDv43+cEJVOmiA3kQSUUryxlOSXFiICN6tfYJVcGk3WuWainp67kBF20
         HFUbFFQUl9MzUQm407586eOUE7PQGcHPszfWrQ/lOwR6hX6wneg6isbysvtodMY234ys
         3S4w==
X-Gm-Message-State: AFq9FYKANi/R7twQGSaE0LR8H10hGLLUcsXIDk2rnzboBWlOps3sz46r
	01N+PpcZ6nQeAPkheb2YXNfgeftupqTGoDJo7eMefm7bQYfCkXZ4x1yH2z861w==
X-Gm-Gg: AYBFou2R2eXVjkHIVnVEvzo+4GPqRSWIBr4A30zbJ4xVhBPJaaWlv+uMCMZc2olHiD2
	G8Ep8WeKbsJSIIexcxzpCqA5pBVyOL1kKrdJxWu9w80bhRAgvM5kUFZHHo6yRH5MdbpMtVZhAJY
	qOdBzKRwVlHtw/hN5qKBzVnRwNsIvzPIW3cTr38Ks29zcSW4McqPBKxlYrEqHfS5eR84PjkhdRD
	SbD9i+xPeEPshQNS6Igo6NWQfvkA3bant5YIzcd5gt84/5onx7OP32WCU1vBFN7OUDfz6WoYN1c
	Jvh6NeTa5cQRqHoHC6KnprkzYr4Q3B92ktkuIaE4IQ0vi92Tk4WW+LW2t6YKHo6Pv9Y4lxpdPhJ
	FvAtyZROb+V6IbN1V15wlCyM3Xn9+HoajhdauVYX6UBNxTcVca1dqEjQdlesL0EjfToCoQmrtQV
	LB6v880L5bA1/E7Az9feX2Q7BkUCNtYLv8g2c6ldtzzBi6qq/kmOFN3oAt2oOn8Iq4bFbfrK/5o
	zbyGIHardrQz5iqZ4eOoi2I5ZMcAf66AsSWXgZ3TK+x1U4MI38CXk9pvybI+Q0+7oIZTThaPOee
	lAKb0D/3RRFpiYUop+izSL5Rllc/m4Oc0vmIbFbgt93zC/jouqnFylftXR7/y0C7LqZ1mhLpayd
	dMzIsBGF4B1yclQBd0lWXPZyv
X-Received: by 2002:a05:6a21:1f8d:b0:3dd:a195:fa1d with SMTP id adf61e73a8af0-3e7cd54472emr4568166637.66.1792983585727;
        Sun, 25 Oct 2026 19:59:45 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.242])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8a36ada2805sm830392b3a.12.2026.10.25.19.59.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 19:59:45 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf 00/81] bpf: Stack in arena and a verifier that joins states
Date: Mon, 26 Oct 2026 02:58:21 +0000
Message-ID: <20261026025943.404450-1-alexei.starovoitov@gmail.com>
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

The goal of this series is to load Rust programs as rustc and LLVM compile
them. These programs keep data, heap and address-taken locals in arena.
They use trait objects, recursion, unwinding, and loops that have no known
bound. The test programs are in https://github.com/4ast/rust-bpf

The series has three parts:

  patches  1-15   Fixes and a revert. They do not depend on the other
                  parts.
  patches 16-31   A stack in arena.
  patches 32-81   A verifier that joins states.

Only patches 1-15 are for merging now, into the bpf tree. Parts 2 and 3 are
for review. The series applies to the bpf tree.

Parts 2 and 3 can be reviewed separately. They touch each other only in
patches 51, 53 and 80.

Where to start
==============

Patch 69 rewrites Documentation/bpf/verifier.rst. It explains the algorithm
with 11 examples. Read it first. Then read patches 47, 52 and 53: the join
of two states, the new main pass, and the switch to it.

  Part 2
  patches 16-22   arena: default size, addr_space_cast of a pointer that is
                  not in arena, .bss.addr_space.1, pointers that are
                  stored in arena
  patches 23-29   r12: the stacks, the verifier, the JITs, the tests
  patches 30-31   kfuncs for Rust. Patch 31 is a placeholder and is not
                  for merging.

  Part 3
  patches 32-39   stack arguments from the code, scalar evolution
  patches 40-41   a packet pointer keeps its range when the prog adds
                  a scalar >= 0
  patches 42-43   more targets of callx, the 'unwound' bit
  patches 44-46   the count of 32-bit shifts in scalar evolution,
                  maybe_fork_scalars() pushes to the next insn
  patches 47-53   the new main pass. Patch 53 is the switch.
  patches 54-59   24 arguments of static subprogs, 32 frames,
                  1024 subprogs
  patches 60-67   removal of pruning, precision tracking and SCCs
  patch   68      a register can hold a pointer to one of a set of
                  functions
  patch   69      the documentation
  patches 70-81   selftests

Selftests pass up to patch 52 and at the end of the series. Between these
points some selftests fail, because the verifier log changes. Each patch
builds.

Part 1: fixes
=============

 - Patches 1-6 remove BPF_F_ARENA_SCALAR. The compiler can emit one
   addr_space_cast for each pointer. That is cheaper than one more insn for
   each access. No released kernel has the flag.
 - Patches 7-8: may_goto has a limit of 250 ms for each call of a subprog,
   not for a run of a prog. A prog of 9 insns causes a soft lockup. The
   patches give one time slice and one count to the full run.
 - Patches 9-10: scalar evolution does not clear 'delta' in a register that
   it widens. Then the verifier calculates an incorrect range for a linked
   register.
 - Patch 11 removes a race between two selftests.
 - Patches 12-13: scalar evolution widens a pointer to a buffer
   (PTR_TO_BUF). The verifier rejects an access to a buffer at a variable
   offset. Thus it rejects a correct loop over the per-cpu values of a map
   element.
 - Patches 14-15: scalar evolution reports a verifier bug, with a WARN, for
   a correct prog in which two variables count together.

Part 2: a stack in arena
========================

In Rust, &local, &heap and &static are the same type of pointer. One insn
can dereference all of them, and a prog can store them in memory. The heap
and the statics are in arena. The verifier does not track the contents of
arena. Thus a pointer to the BPF stack becomes a scalar after the prog
stores it in arena and loads it again. The prog cannot use it.

The series adds a second stack, in arena. A new register, r12
(BPF_REG_ARENA_SP), points to it.

      kernel memory                     arena
  +---------------------+      +--------------------------+
  | BPF stack    <- r10 |      | heap, statics            |
  |                     |      +--------------------------+
  |  spilled registers  |      | stack in arena    <- r12 |
  |  other locals       |      |                          |
  |                     |      |  locals whose address    |
  +---------------------+      |  the prog takes          |
                               +--------------------------+
  The verifier tracks          The verifier tracks nothing.
  each slot.                   An access cannot leave arena.

 - The compiler selects the stack for each local.
 - Each run of a prog takes a stack at its start and gives it back at its
   exit. The usual case is 8 and 4 insns without a call.
 - The verifier accepts r12 in four insns only: 'r12 += N' as the first
   insn of a function, a load, a store, and 'rX = r12'.
 - x86 and arm64 JITs support r12. The arm64 code is compile tested only.

The compiler
------------

No released compiler emits this code. The changes to the BPF backend of
LLVM are in review:
 - r12, and the passes that put data and locals in arena and that emit
   addr_space_cast
 - calls through a table of functions
 - fixes for the code that rustc emits: jump tables, atomics, undef, invoke

A Rust prog needs all of them.

Part 3: a verifier that joins states
====================================

The problem
-----------

The verifier follows each path of a prog. It stops a path only when a state
that it saw before at the same insn covers the current state. Each branch
can double the number of paths.

  if (a) r7 |= 1;              2 paths
  if (b) r7 |= 2;              4 paths
  ...                          ...
  if (t) r7 |= 1 << 19;        2^20 paths, r7 is different in each path
  x = arr[r7 & 63];

  BPF program is too large. Processed 1000001 insn

Rust code is generic, inlined, and full of checked arithmetic. It hits this
limit. The verifier also rejects recursion and each loop for which it
cannot prove an end.

The idea
--------

Where two paths meet, the verifier makes one state from the two states.
This operation is a join. The join covers the two states.

         today                         this series

          [if]                            [if]
         /    \                          /    \
      r1=1    r1=5                    r1=1    r1=5
         \    /                          \    /
         [next]                          [next]
    verified 2 times:               verified 1 time:
    r1=1, then r1=5                 r1=[1,5]

The work now depends on the size of the prog, not on the number of paths.
The 20 ifs above give "processed 74 insns". The limits of 1M insns and 8K
jumps go away.

The check of one insn against one state does not change: do_check_insn()
and check_*() stay. The new code decides which state the verifier uses
next, and what it does where states meet.

The algorithm
-------------

The main pass is a fixpoint over the control flow graph. Each basic block
has a set of states.

  1. Take the first block, in reverse post order, that has a new state.
  2. Verify the insns of the block with that state.
  3. Send the result to each successor of the block.
  4. In the successor:

              state S arrives at block B
                          |
                          v
            +---------------------------+  yes
            | a state of B covers S ?   |------> drop S
            +---------------------------+
                          | no
                          v
            +---------------------------+  yes
            | S and a state T of B      |------> T = join(S, T)
            | have a join ?             |        verify B again with T
            +---------------------------+
                          | no
                          v
              add S to the set of B
              verify B with S

  5. Stop when no block has a new state.

"Covers" is the test that pruning uses today (regsafe(), stacksafe()), with
all scalars compared. The verifier does this test on each join: the result
must cover the two inputs. If it does not, that is a verifier bug and the
prog does not load.

Pruning, precision tracking and backtracking are not necessary.
Patches 60-67 remove them: 3517 lines.

When the verifier does not join
-------------------------------

A join loses the relation between registers. Progs depend on some
relations. Thus a block has a set of states and not one state. There are
two cases.

Case 1: the states have no join. The verifier keeps the two states. NULL
checks and error paths work as they do today.

  state S             state T              join
  ------------------  -------------------  ---------
  scalar 1            scalar 5             [1,5]
  scalar              pointer              no join
  pointer to map A    pointer to map B     no join
  holds a reference   holds no reference   no join
  holds a lock        holds no lock        no join

Case 2: the join contains a value that is in none of the inputs, and a
later jump tests this value.

      ret = -2, p not set        ret = 1, p not set
                    \              /
                     v            v
              if (ret < 0) goto err;
              if (ret > 0) goto skip;
              use(p);

The join is ret=[-2,1]. It contains 0, so the joined state arrives at
use(p), and the verifier rejects a correct prog. The verifier keeps the two
states, because a later jump compares ret with a constant and there is a
gap between -2 and 1. One backward pass finds the registers that later
jumps test. It is similar to the calculation of live registers.

Such rules only refuse a join. Thus they cannot make an unsafe prog load.
5 progs of Cilium and 5 progs of sched-ext/scx need them.

Loops
-----

The verifier changes the state that enters a loop. The new state covers all
iterations. Then the verifier verifies the body one time.

        i = 0
          |
          v
  +--> head:  i = [0,63]      scalar evolution: 64 iterations
  |     body                  verified 1 time
  |     i++
  +---- if (i < 64)

  loop                          state at the head       at run time
  ----------------------------  ----------------------  -----------------
  scalar evolution counts it    ranges of all           no change
                                iterations
  scalar evolution cannot       join, then remove the   the verifier adds
  count it                      bound that grows        may_goto
                                (widening)
  it has no exit                -                       the verifier
                                                        rejects the prog

Subprogs
--------

The verifier verifies a static subprog for each state at its entry, not for
each chain of calls. Recursion uses the same mechanism.

  caller A:  call f  --+                        +-->  A continues
                       +-->  f, entry state X --+
  caller B:  call f  --+     verified 1 time    +-->  B continues

A subprog that gets a pointer to the stack of its caller is an exception.
The verifier verifies it in the context of the caller, as it does today.

Termination
-----------

The verifier does not prove that a prog ends. The kernel enforces the end
at run time. It uses insns that are in the tree: may_goto, unwind_exit and
unwind_goto.

  what                      limit for one run of a prog
  ------------------------  ---------------------------
  loops that have may_goto  250 ms
  stack of recursion        4096 bytes
  calls of recursive        8M
  subprogs

When a run hits a limit:

          does the frame hold a lock or a reference
          that it did not hold at its entry ?
              | no                          | yes
              v                             v
     leave the function             leave the loop
      main prog: return 0            the code after the loop
      subprog:   unwind_exit,        releases the lock or
                 the caller          the reference
                 continues at its
                 landing pad

The verifier selects one of the two exits at load time and verifies it as
an edge of the prog. It rejects a prog that can use neither. A subprog can
use unwind_exit only if unwind_goto follows each call of it. C has no
unwind_goto, thus a subprog in C leaves the loop. The kernel sets the
'unwound' bit in bpf_prog_info and writes the cause to the stderr stream of
the prog.

Limits
------

The verifier limits the number of states. N is the number of insns of the
prog.

  states at one insn           1024
  states at one time           16 * N + 4096
  states in total              256 * N + 64K

The verifier rejects a prog that hits a limit. At half of a limit it joins
all states that have a join.

The price
---------

A join loses the relation between scalars. The verifier now rejects this
prog, because n - i is [-3,5]:

  if (c) { i = 3; n = 4; } else { i = 7; n = 8; }
  x = arr[n - i];

Veristat changes
================

The series decreases the number of processed insns by 62% for selftests,
and by 68% to 87% for Cilium and sched-ext/scx.

A: the bpf tree. B: this series. The two runs use the same objects. The
selftests that the series adds are not counted.
Insns is the number of insns that the verifier processes. It is not the
size of a prog.
Progs is the number of progs that load in the two runs.
Object exclusions: scx_mavd.bpf.o, scx_nitosis.bpf.o. User space loads them
with a prog flag that veristat does not set.

Corpus             Progs  Insns (A)  Insns (B)        Insns (DIFF)
-----------------  -----  ---------  ---------  ------------------
selftests           3712    7100167    2675773  -4424394 (-62.31%)
cilium               144    1151838     282948   -868890 (-75.44%)
scx, as in BPF CI    394    1652788     253946  -1398842 (-84.64%)
scx, master          468    3836779     475390  -3361389 (-87.61%)
tools/sched_ext      240     118880      37454    -81426 (-68.49%)

The progs of rust-bpf load only with the series:

  rust-bpf, 16 schedulers   225 of 225 progs load, 1741677 insns
  rust-bpf, crates          423 of 428 progs load, 17321881 insns

Verdict changes
---------------

No prog of Cilium or sched-ext/scx changes its verdict.

Regressions
-----------

One prog with 5,000 insns or more regresses.

scx_mlfq.bpf.o, mlfq_dispatch: 12902 -> 15673 (+21.48%). It has nested
loops that scalar evolution cannot count. 8 states enter each of the two
inner loops. The verifier verifies each loop again until the state at its
head does not change.

Top wins (30 of 217)
--------------------

Progs that load in the two runs. The larger Insns is 5,000 or more.
Ranked by percentage change, then by the change of Insns, file, program.

File                                Program                               Insns (A)  Insns (B)       Insns (DIFF)
----------------------------------  ------------------------------------  ---------  ---------  -----------------
verifier_iterating_callbacks.bpf.o  loop_inside_iter_volatile_limit           22026         53   -21973 (-99.76%)
verifier_iterating_callbacks.bpf.o  loop_inside_iter                          19022         46   -18976 (-99.76%)
verifier_iterating_callbacks.bpf.o  loop_inside_iter_signed                   19022         46   -18976 (-99.76%)
scx_lavd.bpf.o                      lavd_dispatch                            281049       1644  -279405 (-99.42%)
scx_flow.bpf.o                      flow_select_cpu                          293093       2692  -290401 (-99.08%)
scx_rusty.bpf.o                     rusty_stopping                            19399        195   -19204 (-98.99%)
scx_sdt.bpf.o                       sdt_init_task                             23674        653   -23021 (-97.24%)
loop1.bpf.o                         nested_loops                             361349      10138  -351211 (-97.19%)
scx_eevdf.bpf.o                     eevdf_init                               114919       3460  -111459 (-96.99%)
scx_flow.bpf.o                      flow_stopping                             82255       2543   -79712 (-96.91%)
scx_flow.bpf.o                      flow_enqueue                             219201       6971  -212230 (-96.82%)
scx_eevdf.bpf.o                     eevdf_running                            104967       3473  -101494 (-96.69%)
scx_eevdf.bpf.o                     eevdf_select_cid                         338451      11720  -326731 (-96.54%)
profiler2.bpf.o                     tracepoint__syscalls__sys_enter_kill      26094        967   -25127 (-96.29%)
libarena_asan.bpf.o                 test_buddy_alloc_multiple                242337      10415  -231922 (-95.70%)
scx_flow.bpf.o                      flow_dispatch                             70469       3053   -67416 (-95.67%)
profiler3.bpf.o                     tracepoint__syscalls__sys_enter_kill      29687       1411   -28276 (-95.25%)
scx_eevdf.bpf.o                     eevdf_dispatch                           371871      19992  -351879 (-94.62%)
scx_pandemonium.bpf.o               pandemonium_enqueue                      108878       6356  -102522 (-94.16%)
scx_rusty.bpf.o                     rusty_enqueue                             21659       1361   -20298 (-93.72%)
test_verif_scale3.bpf.o             balancer_ingress                         837487      57515  -779972 (-93.13%)
bpf_host.o                          tail_handle_ipv4_from_netdev              73355       5499   -67856 (-92.50%)
scx_cake.bpf.o                      cake_dispatch                             35827       2776   -33051 (-92.25%)
scx_eevdf.bpf.o                     eevdf_enqueue                            110634       8913  -101721 (-91.94%)
bpf_xdp.o                           tail_lb_ipv4                              62753       5162   -57591 (-91.77%)
scx_pandemonium.bpf.o               pandemonium_dispatch                      26412       2210   -24202 (-91.63%)
scx_cake.bpf.o                      cake_enqueue                              66882       6190   -60692 (-90.74%)
test_verif_scale1.bpf.o             balancer_ingress                         546742      51125  -495617 (-90.65%)
scx_pandemonium.bpf.o               pandemonium_select_cpu                   232415      23420  -208995 (-89.92%)
scx_cake.bpf.o                      cake_select_cpu                           50249       5189   -45060 (-89.67%)

Follow-up
=========

After verification the verifier replaces single insns with sequences of
insns. Each replacement moves the rest of the prog, so the cost is
quadratic. It is a large part of the load time of the largest Rust progs,
which have more than 100000 insns. A follow-up series of 8 patches applies
all replacements of a pass in one step.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>

Alexei Starovoitov (81):
  selftests/bpf: Remove tests for global data in arena
  libbpf: Remove .arena.data
  libbpf: Keep format strings of bpf_printk() in .rodata
  selftests/bpf: Remove tests for arena access through numbers
  bpf: Remove BPF_F_ARENA_SCALAR
  bpf, x86: Remove r0_on_stack from fetching atomics in arena
  bpf: One time slice of may_goto for a run of a prog
  selftests/bpf: Test may_goto in a loop that calls a subprog that spins
  bpf: Clear delta of a register that scalar evolution widens
  selftests/bpf: Test that a widened register is not linked
  selftests/bpf: Wait for the last maps of map_kptr to be freed
  bpf: Don't widen a pointer to a buffer in scalar evolution
  selftests/bpf: Test a loop that moves a pointer to a buffer
  bpf: Fix a false verifier bug in the clamp of scalar evolution
  selftests/bpf: Test induction variables that come back out of range
  libbpf: Make arena 1 Gbyte when max_entries is not set
  selftests/bpf: Test the default size of arena
  bpf: Treat addr_space_cast of a pointer that is not in arena as a move
  selftests/bpf: Test addr_space_cast of pointers that are not in arena
  libbpf: Support .bss.addr_space.1 section
  libbpf: Relocate pointers that are stored in arena
  selftests/bpf: Test pointers in arena and .bss.addr_space.1
  bpf: Introduce bpf register BPF_REG_ARENA_SP
  bpf: Add stacks for programs to arena
  bpf, x86: Add BPF_ATOMIC_LOCAL
  bpf: Support BPF_REG_ARENA_SP in the verifier
  bpf, x86: Support BPF_REG_ARENA_SP
  bpf, arm64: Support BPF_REG_ARENA_SP
  selftests/bpf: Add tests for BPF_REG_ARENA_SP
  bpf: Add bpf_arena_memcmp() and bpf_arena_memcpy() kfuncs
  bpf: Add bpf_alloc() and bpf_free() kfuncs
  bpf: Count stack arguments of a static subprog from its code
  selftests/bpf: Test static subprogs that don't take what BTF says
  bpf: Let scalar evolution see loads from read-only maps
  selftests/bpf: Test scalar evolution with a loop bound in .rodata
  bpf: Helpers don't write through ARG_ANYTHING
  selftests/bpf: Test scalar evolution with stack address as
    ARG_ANYTHING
  bpf: Simplify (zext32 (zext32 x)) in scalar evolution
  selftests/bpf: Test scalar evolution with a latch on a 32-bit copy
  bpf: Keep the range of a packet pointer when a number >= 0 is added
  selftests/bpf: Test range of a packet pointer after a number is added
  bpf: Allow BPF_MAX_SUBPROGS targets of a read from a table of
    functions
  bpf: Tell user space that a run of a prog was cut short
  bpf: Mask the count of a 32-bit shift in scalar evolution
  selftests/bpf: Expect the masked count of 32-bit shifts
  bpf: Finish the insn in the state that maybe_fork_scalars() splits off
  bpf: Add join of verifier states
  bpf: Describe loops that scalar evolution cannot count exactly
  selftests/bpf: Adjust tests to loops that are counted now
  bpf: Add may_goto to the loops that the verifier marks
  bpf: Check stack and count calls of recursive subprogs at run time
  bpf: Add the main pass as a fixpoint over the control flow graph
  bpf: Verify programs as a fixpoint over the control flow graph
  bpf: Allow 24 arguments of static subprogs
  selftests/bpf: Test a static subprog with 24 arguments
  bpf: Bump MAX_CALL_FRAMES to 32
  selftests/bpf: Test 32 and 33 call frames
  bpf: Bump BPF_MAX_SUBPROGS to 1024
  selftests/bpf: Make room in veristat for the stats of 1024 subprogs
  bpf: Remove is_state_visited()
  bpf: Remove precision tracking
  bpf: Remove prune points, levels of state comparison and pop_stack()
  bpf: Print 0 as the limit in the statistics line
  bpf: Remove bpf_compute_scc()
  bpf: Update comments about paths, pruning and explored states
  bpf: Remove iter.depth
  bpf: Remove leftovers of precision tracking and read marks
  bpf: Track a pointer to one of a set of functions
  bpf, docs: Rewrite verifier.rst
  selftests/bpf: Adjust tests of precision tracking
  selftests/bpf: Adjust tests of linked registers and spills
  selftests/bpf: Adjust tests of pruning
  selftests/bpf: Adjust tests of loops
  selftests/bpf: Adjust tests of recursion
  selftests/bpf: Adjust tests to the order of verification and to the
    log
  selftests/bpf: Adjust tests of unprivileged progs
  selftests/bpf: Test states that are not joined
  selftests/bpf: Test progs that run out of budget
  selftests/bpf: Test 'unwound' in bpf_prog_info
  selftests/bpf: Test the stack in arena after recursion ran out of
    budget
  selftests/bpf: Test callx of one of a set of functions

 Documentation/bpf/bpf_design_QA.rst           |    7 +-
 Documentation/bpf/kfuncs.rst                  |   12 +-
 Documentation/bpf/verifier.rst                | 1661 ++++++---
 arch/arm64/net/bpf_jit_comp.c                 |   19 +-
 arch/x86/net/bpf_jit_comp.c                   |  195 +-
 include/linux/bpf.h                           |   72 +-
 include/linux/bpf_verifier.h                  |  458 +--
 include/linux/filter.h                        |   58 +-
 include/uapi/linux/bpf.h                      |   13 +-
 kernel/bpf/Makefile                           |    2 +-
 kernel/bpf/arena.c                            |  282 ++
 kernel/bpf/backtrack.c                        | 1041 ------
 kernel/bpf/btf.c                              |    8 +-
 kernel/bpf/cfg.c                              |  253 +-
 kernel/bpf/const_fold.c                       |   20 +-
 kernel/bpf/core.c                             |  169 +-
 kernel/bpf/diagnostics.c                      |    7 -
 kernel/bpf/diagnostics.h                      |    1 -
 kernel/bpf/disasm.c                           |    7 +
 kernel/bpf/fixups.c                           |  858 ++++-
 kernel/bpf/flow.c                             | 1817 ++++++++++
 kernel/bpf/helpers.c                          |   12 +
 kernel/bpf/join.c                             |  649 ++++
 kernel/bpf/liveness.c                         |   21 +-
 kernel/bpf/log.c                              |   14 +-
 kernel/bpf/loops.c                            |   24 +
 kernel/bpf/scev.c                             |  875 ++++-
 kernel/bpf/states.c                           | 1095 +-----
 kernel/bpf/syscall.c                          |    5 +-
 kernel/bpf/verifier.c                         | 2998 +++++++++++------
 tools/bpf/bpftool/prog.c                      |    2 +
 tools/include/uapi/linux/bpf.h                |   13 +-
 tools/lib/bpf/bpf_helpers.h                   |   18 +-
 tools/lib/bpf/libbpf.c                        |  551 +--
 tools/testing/selftests/bpf/Makefile          |   12 +-
 .../testing/selftests/bpf/Makefile.buildvars  |   25 -
 tools/testing/selftests/bpf/Makefile.skel     |   17 +-
 .../bpf/prog_tests/arena_data_ptrs.c          |   67 +
 .../bpf/prog_tests/arena_default_size.c       |   22 +
 .../bpf/prog_tests/arena_scalar_blinded.c     |   21 -
 .../selftests/bpf/prog_tests/arena_stack.c    |  249 ++
 .../bpf/prog_tests/bpf_verif_scale.c          |    4 +-
 .../selftests/bpf/prog_tests/ctx_rewrite.c    |   14 +-
 .../selftests/bpf/prog_tests/data_in_arena.c  |  216 --
 .../selftests/bpf/prog_tests/log_buf.c        |    4 +-
 .../selftests/bpf/prog_tests/log_fixup.c      |    6 +-
 .../selftests/bpf/prog_tests/map_kptr.c       |    5 +
 .../bpf/prog_tests/may_goto_budget.c          |   31 +
 .../selftests/bpf/prog_tests/reg_bounds.c     |    5 +-
 .../selftests/bpf/prog_tests/tracing_struct.c |   15 +-
 .../selftests/bpf/prog_tests/unwound.c        |   96 +
 .../selftests/bpf/prog_tests/verifier.c       |   12 +-
 .../selftests/bpf/progs/aggregate_ret_func.c  |   15 -
 .../selftests/bpf/progs/aggregate_ret_kfunc.c |    7 -
 .../selftests/bpf/progs/arena_data_ptrs.c     |  117 +
 ...in_arena_decl.c => arena_data_ptrs_fail.c} |   24 +-
 .../selftests/bpf/progs/arena_default_size.c  |   21 +
 .../selftests/bpf/progs/arena_noarena.c       |   17 +-
 .../testing/selftests/bpf/progs/arena_stack.c |  334 ++
 .../selftests/bpf/progs/arena_stack_fentry.c  |   13 +
 .../selftests/bpf/progs/arena_stack_loop.c    |   52 +
 .../selftests/bpf/progs/arena_stack_nomem.c   |   32 +
 ...f_qdisc_fail__invalid_dynptr_cross_frame.c |    4 +-
 .../bpf/progs/compute_live_registers.c        |   13 +
 .../selftests/bpf/progs/cpumask_failure.c     |    2 +-
 .../selftests/bpf/progs/data_in_arena.c       |  112 -
 .../bpf/progs/data_in_arena_extern.c          |   20 -
 .../selftests/bpf/progs/data_in_arena_fail.c  |   20 -
 .../selftests/bpf/progs/data_in_arena_nomap.c |   20 -
 .../selftests/bpf/progs/data_in_arena_rust.rs |   73 -
 .../testing/selftests/bpf/progs/dynptr_fail.c |    4 +-
 .../selftests/bpf/progs/exceptions_assert.c   |   24 +-
 tools/testing/selftests/bpf/progs/iters.c     |  112 +-
 .../selftests/bpf/progs/iters_state_safety.c  |    8 +-
 .../selftests/bpf/progs/iters_testmod_seq.c   |   12 +-
 .../selftests/bpf/progs/may_goto_budget.c     |   73 +
 .../bpf/progs/mem_rdonly_untrusted.c          |   16 +-
 .../selftests/bpf/progs/stack_arg_precision.c |   48 +-
 .../selftests/bpf/progs/test_global_func15.c  |    5 -
 .../selftests/bpf/progs/test_global_func3.c   |  107 +-
 .../selftests/bpf/progs/timer_failure.c       |    9 +-
 .../bpf/progs/tracing_struct_int128_tgt.c     |   26 +-
 .../bpf/progs/tracing_struct_int128_tracer.c  |    7 +
 tools/testing/selftests/bpf/progs/unwound.c   |  113 +
 .../selftests/bpf/progs/verifier_align.c      |   10 +-
 .../selftests/bpf/progs/verifier_and.c        |    4 +-
 .../selftests/bpf/progs/verifier_arena.c      |   15 +
 .../selftests/bpf/progs/verifier_arena_cast.c |  456 +++
 .../bpf/progs/verifier_arena_scalar.c         | 1155 -------
 .../bpf/progs/verifier_arena_stack.c          |  683 ++++
 .../bpf/progs/verifier_array_access.c         |   14 +-
 .../selftests/bpf/progs/verifier_bounds.c     |  589 +++-
 .../bpf/progs/verifier_bounds_deduction.c     |    2 +-
 .../bpf/progs/verifier_bounds_step.c          |   73 +-
 .../bpf/progs/verifier_bpf_fastcall.c         |   24 +-
 .../selftests/bpf/progs/verifier_budget.c     | 1159 +++++++
 .../selftests/bpf/progs/verifier_callx.c      |   22 +-
 .../selftests/bpf/progs/verifier_callx_many.c |   90 +
 .../bpf/progs/verifier_callx_rodata.c         |  222 +-
 .../selftests/bpf/progs/verifier_cfg.c        |    8 +-
 .../bpf/progs/verifier_direct_packet_access.c |  375 +++
 .../bpf/progs/verifier_global_subprogs.c      |    7 +-
 .../bpf/progs/verifier_helper_value_access.c  |    8 +-
 .../selftests/bpf/progs/verifier_idoms.c      |    5 +-
 .../bpf/progs/verifier_iterating_callbacks.c  |  118 +-
 .../bpf/progs/verifier_jumps_ahead.c          |  864 +++++
 .../selftests/bpf/progs/verifier_live_stack.c |   23 +-
 .../bpf/progs/verifier_loop_hierarchy.c       |  125 +-
 .../selftests/bpf/progs/verifier_loops1.c     |   14 +-
 .../bpf/progs/verifier_map_ret_val.c          |    2 +-
 .../selftests/bpf/progs/verifier_may_goto_1.c |  109 +-
 .../bpf/progs/verifier_mem_size_reg.c         |    8 +-
 .../selftests/bpf/progs/verifier_movsx.c      |    2 +-
 .../selftests/bpf/progs/verifier_precision.c  |  191 +-
 .../selftests/bpf/progs/verifier_scalar_ids.c |  313 +-
 .../selftests/bpf/progs/verifier_scev.c       | 1567 ++++++++-
 .../selftests/bpf/progs/verifier_sdiv.c       |   64 +-
 .../bpf/progs/verifier_search_pruning.c       |   30 +-
 .../selftests/bpf/progs/verifier_spill_fill.c |  218 +-
 .../selftests/bpf/progs/verifier_spin_lock.c  |    4 +-
 .../selftests/bpf/progs/verifier_stack_arg.c  |  200 +-
 .../bpf/progs/verifier_stack_arg_order.c      |    2 +-
 .../selftests/bpf/progs/verifier_stack_ptr.c  |   15 +-
 .../bpf/progs/verifier_subprog_insn_stats.c   |   16 +-
 .../bpf/progs/verifier_subprog_precision.c    |  348 +-
 .../selftests/bpf/progs/verifier_unpriv.c     |   23 +-
 .../bpf/progs/verifier_unpriv_perf.c          |    4 +-
 .../bpf/progs/verifier_value_or_null.c        |    2 +-
 .../bpf/progs/verifier_value_ptr_arith.c      |   15 +-
 .../selftests/bpf/progs/verifier_var_off.c    |  557 ++-
 tools/testing/selftests/bpf/test_loader.c     |    2 -
 .../selftests/bpf/verifier/basic_stx_ldx.c    |    4 +-
 tools/testing/selftests/bpf/verifier/calls.c  |  101 +-
 .../testing/selftests/bpf/verifier/precise.c  |   69 +-
 .../selftests/bpf/verifier/pseudo_func.c      |    2 +-
 tools/testing/selftests/bpf/veristat.c        |    7 +-
 136 files changed, 17339 insertions(+), 8119 deletions(-)
 delete mode 100644 kernel/bpf/backtrack.c
 create mode 100644 kernel/bpf/flow.c
 create mode 100644 kernel/bpf/join.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/arena_data_ptrs.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/arena_default_size.c
 delete mode 100644 tools/testing/selftests/bpf/prog_tests/arena_scalar_blinded.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/arena_stack.c
 delete mode 100644 tools/testing/selftests/bpf/prog_tests/data_in_arena.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/may_goto_budget.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/unwound.c
 create mode 100644 tools/testing/selftests/bpf/progs/arena_data_ptrs.c
 rename tools/testing/selftests/bpf/progs/{data_in_arena_decl.c => arena_data_ptrs_fail.c} (50%)
 create mode 100644 tools/testing/selftests/bpf/progs/arena_default_size.c
 create mode 100644 tools/testing/selftests/bpf/progs/arena_stack.c
 create mode 100644 tools/testing/selftests/bpf/progs/arena_stack_fentry.c
 create mode 100644 tools/testing/selftests/bpf/progs/arena_stack_loop.c
 create mode 100644 tools/testing/selftests/bpf/progs/arena_stack_nomem.c
 delete mode 100644 tools/testing/selftests/bpf/progs/data_in_arena.c
 delete mode 100644 tools/testing/selftests/bpf/progs/data_in_arena_extern.c
 delete mode 100644 tools/testing/selftests/bpf/progs/data_in_arena_fail.c
 delete mode 100644 tools/testing/selftests/bpf/progs/data_in_arena_nomap.c
 delete mode 100644 tools/testing/selftests/bpf/progs/data_in_arena_rust.rs
 create mode 100644 tools/testing/selftests/bpf/progs/may_goto_budget.c
 create mode 100644 tools/testing/selftests/bpf/progs/unwound.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_arena_cast.c
 delete mode 100644 tools/testing/selftests/bpf/progs/verifier_arena_scalar.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_arena_stack.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_budget.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_callx_many.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_jumps_ahead.c

-- 
2.55.0

