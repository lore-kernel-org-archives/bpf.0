Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D57994C10FF
	for <bpf@vger.kernel.org>; Fri,  9 Oct 2026 10:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791542910; cv=none; b=tvflvfwcifeIjN4qIjKCx5LtgED0QsJR5pB/5hDxylmKDgF+siDscvZmzsRiEYNkExhkqPqLitDNsRL5wq98Sb/x9XZaV+i2Me+M117o4SgE79wxIqF0GF0MD1zV3YDbv9KYVYOM8oBdh6EAS4WwEKPfukyZY4A4YbhncN5Yspw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791542910; c=relaxed/simple;
	bh=W7HW6wOGVgTG827pI7YwEJhC/M6LMWil87GtRNymEcs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=azOifYp1aqDcdvGiBzus8DxDF645rpP7LvlyU8eCF74HScEwW2L+MvgDRZR1fhU1HgdzCEsohf51UaRGw2KGENr76XTGNSYXnYtOj9Sjtp/8LlJOPlNaTWqSdeL9IuFN3EpWZ4FsGHlvrcT+MYR+pJyGW53qt6JRHS5NheweD3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=p8bE+N7a; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p8bE+N7a"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3ab27c7e68aso597279a91.3
        for <bpf@vger.kernel.org>; Fri, 09 Oct 2026 03:48:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791542898; x=1792147698; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=E3CP77ORhD6tgpFd4FOq3ustnHMQICEALeXf+EAJZV4=;
        b=p8bE+N7aIKdJXtFBBxmhapH6WAbixte9KznlQW8KbzvFTpmuIF2K6mT0JEQdphO2GH
         UTwrDQk3+/Du53S++8c3/upAqU3HgMPqNW/NcZTWx77hWyB6zyI/G3RrwpwfhBQAUR/e
         Ra3C1UrpoUBotIfaqVGPmkrUjbJb7EQn9OO55wV3iyPY3pBsOnOWey6bzOu5R96sKryL
         2S4gNL6Q9iOkEi4Ep76jwGYZuHNg1kNQVwQtC6kMenoC0zjBcS81GrAgizgXM/KtFOof
         yHAKYpNsAfT4exTGoZO9xNLdB/Rd9xWyDUrd87z7ye7r9sBxEun5wH9nFJS5yDTm92jh
         Ux7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791542898; x=1792147698;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=E3CP77ORhD6tgpFd4FOq3ustnHMQICEALeXf+EAJZV4=;
        b=bcjmzOq9PGtwJAJq38ZTLI9gm49Vu3KnEaKWmy4w8S4JEPWRq5S1hsb7/TVCBlmQfO
         2kiK8gKxQpHVvNzzjBaJFGpz1pS/MAc4/hE9BSHtrxBYZql5wpIJrx9GAcj48ypRAd0U
         J6prBv+E+cpTFy3e8xyd6B8OcFm1pQrM2iBw0yE4zz9F3jhB5m6tJUmIEKA0Fj/UqpBc
         CWFAMQh3OUzoMNdGbg4HRL9gLffdvZR2Q3kYqLroWKadb32qYE4javd7K8czd1EbNLbn
         Sy8cEwfIU90zwn97zdLjf743abQR6061FuIIF/1Cb08aTLXSMyehwHVTbGkl7bbozTKV
         prxA==
X-Gm-Message-State: AFq9FYIyuZxF8f15xNYfauXfnZEa8eUWg+KFUkoW5OERiodBkTwDZrqG
	vgR1ljkWwFGNhrctyA9+gwdZZnK4hsY0ZNs3kd0/XIxyVc76M1iDCPTkHnWAeg==
X-Gm-Gg: AYBFou15WTGUYd6n80Ndr0tYcj4L8MhY8a+a+Yo5DsHEONP/tBAlKPmRcSwtjB8M6BB
	tF6hgEtqC3wkzbH7oT9nN1JE0HdJ1SqVKfDhyjK9YRlzhfQtSMl5qQ/5aajdD68sogefavMDSCc
	PoKGgmUVVF9LhPPuNbUjI+5Ibz5kX6Ra1m/jnNc1ImywRMWSl7wfNe1UoVB9+9ndinF7A+Kcxsr
	BJBTZAFkkxYxKVzlVt+RVeViWviQYcDu/KxAzMKBPU+9TnyCFAuGr203aUlvzkw6tG2j6Aclw+W
	NsbeCmL/MF/bRFTm/3QrHAhzwJnEdO+p5oKc1kTbQvM3CDoLTm2xfCoX7UnyMTEzqxOx33WWpg7
	kL8RqoRZJgpNo9v0Xs18gk80ZBqsa+i2IDWigUllzfS1cXd0x08B9x0OEJYaSO/GrFeSSpoK1hg
	DVp/NlmWpXULeXcXn+CNCYvIv1IjPJzQrJq0ieQhzoxS/hIVnh9do8cslqLqgKKfSa7eQlgGf4l
	/YcFM9uhRLKUlU=
X-Received: by 2002:a17:90b:4490:b0:3ab:39a5:1b70 with SMTP id 98e67ed59e1d1-3ab3af75ab6mr1375746a91.50.1791542897550;
        Fri, 09 Oct 2026 03:48:17 -0700 (PDT)
Received: from badger ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ab36ed053csm3050107a91.4.2026.10.09.03.48.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 03:48:17 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v3 00/51] bpf: use scalar evolution to widen bounded loops
Date: Fri,  9 Oct 2026 03:47:18 -0700
Message-ID: <20261009-scev-minimal-rebase-v3-0-bcba9bc53ac9@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Change-ID: 20260925-scev-minimal-rebase-911799c95dff
Content-Transfer-Encoding: 8bit

This series implements the scalar evolution (SCEV) technique for
verification of loops.

Scalar evolution is a static analysis technique that infers algebraic
expressions describing how variables change within a loop body.
These expressions can then be used to estimate the number of loop body
executions. This estimate can be used to represent induction variables
as ranges instead of enumerating each possible value.

For example, the following loop:

  for (r0 = 0; r0 < 10; r0++) {
    ...
  }

would now be verified with the assumption that r0 is a scalar value
in the range [0..9] within its body.

See the following patches for a more technical overview:
- "bpf: compute scalar evolution expressions for loops"
- "bpf: use SCEV to widen bounded loops"

The series can be viewed as consisting of the following parts:
- Preparatory patches fixing and extending liveness analysis and
  adding utility functions. The liveness changes collect stack access
  effects and register dependencies, including:
  - "bpf: fix arg_track_xfer() for atomic stack spills and fills"
  - "bpf: derive global subprog stack liveness from BTF signatures"
  - "bpf: compute parameters liveness in bpf_compute_live_registers()"
- Patches relaxing the verifier's current restrictions on accessing
  memory via varying offset pointers, specifically:
  - "bpf: allow subrange relations for PTR_TO_STACK in regsafe()"
  - "bpf: representation for intervals with steps"
  - "bpf: varying offset access support for PTR_TO_BTF_ID pointers"
- Patches to compute the immediate dominator tree and loop hierarchy.
- Patches implementing scalar evolution and integrating it with
  the main verification pass:
  - "bpf: allow precision backtracking between overlapping checkpoints"
  - "bpf: compute scalar evolution expressions for loops"
  - "bpf: use SCEV to widen bounded loops"
  - "bpf: avoid widening registers that hinder exact stack-slot tracking"
- Tests and test harness updates.

Literature
==========

- "Symbolic Evaluation of Chains of Recurrences for Loop Optimization"
  Robert A. van Engelen, 2000
- "The CR# Algebra and its Application in Loop Analysis and Optimization"
  Robert A. van Engelen, 2004

Supported patterns
==================

As scalar evolution analysis attempts to infer recurring relationships
from algebraic expressions describing loop variables, there are some
limitations on what can be expressed.

Below is a list of patterns that are expected to work with the current
implementation. The examples are pseudo-code for the indicated BPF
instruction shapes.

Loop widening currently requires allow_uninit_stack, the verifier mode
that permits reading uninitialized stack bytes. This requirement applies
even to loops that use only registers. Without it, the verifier uses
its existing iteration-by-iteration checking.

1. Counted loops, including decreasing counters:

       u64 i = 0;
       do { i += 1; } while (i < 10);

       u64 j = 3;
       do { j += -1; } while (j != 0);

   Header ranges are i in [0,9] and j in [1,3].
   Pre-condition loops, such as while (i < 10) { i += 1; },
   are also supported. The counter can reside in a register or a fixed
   8-byte frame-pointer spill.

2. Strided accesses into a map value:

       /* bytes is a map-value array with at least 16 bytes. */
       u64 i = 0, off = 0;
       do {
           bytes[off] = 1;
           i += 1;
           off += 2;
       } while (i < 8);

   At the header, off is in [0,14] with step 2. The byte store stays
   within the map value even though i and off are tracked separately.

3. A nonconstant entry value with a separate counted induction variable:

       u64 x = bpf_get_prandom_u32() & 6;  // {0,2,4,6}
       u64 i = 0;
       do { x += 6; i += 1; } while (i < 3);

   The counter i supplies the bound. At the header, x widens to [0,18]
   with step 2, retaining the alignment common to its entry values and
   its slope; x itself need not start at a constant.

4. Conditional assignment from an invariant value:

       u64 x = 5;
       for (u64 i = 0; i < 3; i += 1)
           if (i == 1) x = 10;
       return x;

   Widening joins the pre-loop value 5 with the assigned value 10,
   giving x in [5,10] both inside and after the loop.

5. Early exits in addition to the counted backedge:

       u64 i = 0;
       do {
           if (bpf_get_prandom_u32() == 0) break;
           i += 1;
       } while (i != 3);

   The counter still bounds the loop. An additional exit reduces the
   available lower-bound information; it does not by itself prevent
   widening.

6. Array accesses through different memory types:

   Bounded varying offsets are supported for arrays in BTF-typed
   objects, stack memory, map values and keys, packet data and
   metadata, and memory buffers. The usual bounds, alignment and
   access restrictions still apply.

   For stack arrays indexed by a widened loop counter, only byte and
   half-word accesses are supported; see limitation 5 below.

   For an array in a BTF-typed object:

       struct inner { int a, b; };
       struct object { struct inner arr[8]; };
       /* o points to a live, non-NULL BTF-typed struct object. */
       u64 i = bpf_get_prandom_u32() & 7;
       value = o->arr[i].b;

   The 4-byte load has offsets 4 + 8*i, i in [0,7]. Bounds keep
   accesses within arr; base and step 8 ensure that each possible
   offset selects member b. Such accesses also work without a loop.

7. Nested loops with separate counters:

       u64 i = 0;
       do {
           u64 j = 0;
           do {
               /* body */
               j += 1;
           } while (j < 3);
           i += 1;
       } while (i < 4);

   Both loops can be widened: i is in [0,3] at the outer header,
   and j is in [0,2] at the inner header. The inner counter is reset
   on each outer iteration; i is unchanged by the inner loop.

8. Incrementing and comparing a pointer directly:

       /* bytes is a map-value array with at least 8 bytes. */
       u8 *p = bytes, *end = bytes + 8;
       do {
           *p = 1;
           p++;
       } while (p != end);

   The initial pointer and fixed end pointer give eight iterations,
   without a separate integer counter. At the loop header, p ranges
   from bytes to bytes + 7, so each byte store stays within the array.
   Deriving the iteration count requires the compared pointers to have
   a provable common memory origin.

9. A loop bounded by an exit other than the latch:

       u64 i = 0, len = 14;
       do {
           if (i == len)
               break;
           use(i);
           i += 1;
       } while (i != 64);

   Every exit condition dominating the latch bounds the iteration
   count; the smallest bound wins. Here i is in [0,14] at the header,
   not [0,63], so use(i) sees the range established by the break.

Limitations
===========

Patterns that lose precision after widening
-------------------------------------------

Widening can lose information that the verifier gets by checking
each iteration separately. For example:

    r7 = 5;
    for (r6 = 0; r6 < 3; r6++)
        if (r6 == 1)
            r7 = 10;
    if (r7 != 10)
        invalid_stack_read();

R7 is always 10 at the real exit, but is represented as [5, 10] at
loop entry and after the loop. The verifier therefore cannot exclude
the invalid read and rejects this otherwise safe program.
It would be hard to avoid this limitation.

The same issue affects correlated linear counters at loop exit:

    u64 i = 0, off = 0;
    while (i < 8) {
        i++;
        off += 2;
    }
    if (off != 16)
        invalid_stack_read();

Enumeration establishes off == 16. Widening tracks i and off
independently, and the exit check on i does not reconstruct off's exact
final value. This can be lifted after analysis adjustments.

Patterns not widened yet
------------------------

If one of the variables modified in the loop cannot be widened, the
verifier checks each iteration instead. Examples include:

1. 32-bit recurrences and comparisons:

       for (u32 i = 0; i < 8; i++)      // ALU32 / JMP32
           use(i);

   Only 64-bit arithmetic and comparisons are supported.
   This limitation will be lifted.

2. Non-linear updates:

       for (u64 i = 1; i < 16; i *= 2)  // non-linear recurrence
           use(i);

   Recognition is currently limited to simple additive recurrences.
   Literature describes a way to represent this, but it is not
   considered a priority at the moment.

3. A controlling counter or bound that is not constant at loop entry:

       u64 limit = unknown_in_range(1, 8);
       for (u64 i = 0; i < limit; i++)
           use(i);

       u64 i = unknown_in_range(0, 7);
       while (i < 8)
           i++;

   Both loops have finite bounds, but iteration-count evaluation
   currently requires concrete entry values. Other induction variables
   may have nonconstant entry ranges once a separate counter establishes
   the iteration bound. This limitation can be lifted eventually.

4. Alternative values referring to another evolving register:

       r7 = 0;
       for (r6 = 0; r6 < 4; r6++)
           if (condition)
               r7 = r6;
       use(r7);

   R6 changes on each iteration. Widening currently supports
   conditional assignments only from constants or values that do not
   change in the loop. This limitation can be lifted.

5. Stack addresses whose widening would lose precise slot tracking:

       u64 slots[4];
       for (u64 i = 0; i < 4; i++)
           slots[i] = i;

       struct bpf_dynptr dptrs[4];
       for (u64 i = 0; i < 4; i++)
           bpf_dynptr_from_xdp(ctx, 0, &dptrs[i]);

   Keep such indices concrete for 4- and 8-byte stack loads/stores and
   calls requiring fixed-offset stack objects. Dependencies inside
   nested loops also constrain the outer loop.
   It would be hard to lift this limitation.

6. Values modified by a nested loop do not get a closed-form summary
   for the enclosing loop:

       u64 sum = 0;
       for (u64 i = 0; i < 4; i++)
           for (u64 j = 0; j < 4; j++)
               sum++;
       use(sum);

   The inner loop may widen, but the outer analysis forgets values
   modified by it rather than deriving the combined recurrence.
   This limitation can be lifted.

7. Multiple backedges and irreducible control flow:

       i = 0;
   H:  if (i >= 8) goto done;
       if (condition) { i++; goto H; }  // first backedge
       i++; goto H;                    // second backedge
   done:

       i = 0;
       if (condition) goto body;       // second entry into the loop
   H:  i++;
   body:
       if (i < 8) goto H;

   Widening requires a reducible loop with one backedge and a supported
   dominating exit condition. Multiple exits are supported, but their
   early-exit paths reduce what can be inferred about iteration counts.
   It is unclear whether this can be lifted at the moment.

8. Large slopes and unsupported iteration bounds:

       for (u64 i = 0, x = 0; i < 4; i++) {
           use(x);
           x += 65536;                // slope outside signed 16 bits
       }

   Slopes used for linear widening must be nonzero signed-16-bit
   constants. The inferred number of header executions must be finite
   and less than U32_MAX. Counter wraparound must be ruled out while
   deriving the bound.

9. Incompatible pointer alternatives or comparison operands:

       p = &map_a[0];
       q = &map_b[0];

       for (u64 i = 0; i < 10; i++) {
           if (i == 5)
               p = q;
           use(*p);
       }

   At the loop header, p has SCEV ANY(p_entry, q). The alternatives
   point into different maps, so their offsets cannot be joined while
   retaining one map's metadata. Joining invariant pointer
   alternatives requires compatible pointer metadata, including type,
   origin IDs, frame number.

10. Some hard-coded constant limits:
   - Programs with more than 16 nested loops in one function are rejected.
   - Loops with more than 256 exits exceed the metadata limits and are
     not analyzed for widening.
   - At most 4 exit conditions dominating the latch are consulted for
     the iteration count of a loop.
   - Expression traversal is limited to depth 8. Only a small fixed number
     of alternative values can be joined.

Veristat changes
================

The main impact of the series is a 23% reduction in number of
processed instructions on a subset of Meta BPF programs.

Verdict changes
---------------

Two programs flip succes->failure, both selftests whose expectations
are updated by the series:
- verifier_gotox/gotox_edges_at_limit: test's CFG is a nest of ~1000
  irreducible loops, deeper than the per-function loop stack (16),
  the program is rejected with "Too many nested loops".
- verifier_scev/conditional_assignment_on_second_iteration:
  a value assigned on the second iteration is checked after the loop
  with its widened range, so a stack read guarded by that check
  is rejected.

No program from the production corpora changes verdict.

Regressions
-----------

20 programs regress by 30-33% and 6 more by 10-21%, all from an
appliction objects sharing one unwinder library.
All programs share a common reason for regression:
- a big outer loop contains several smaller nested loops;
- nested loops are now widened and coverge, their convergence
  adds backedges to the outer loop's SCC, thus flipping
  checkpoint comparisons with the outer loop to RANGE_WITHIN mode.

Support for 32-bit recurrences and comparisons widens these loops too
and removes the regression. This would be handled in a followup.

Statistics
----------

A: master; B: scev-minimal-v3. Corpora: cilium, meta, scx, selftests.
Insns counts verifier-processed instructions, not program size.
Object exclusions: verifier_scev.bpf.o.

Histogram: selected programs, without the table filters.

Total progs: 7952
Old success: 5637
New success: 5646
total_insns diff min:  -99.84%
total_insns diff max:   61.90%
0 -> value: 0
value -> 0: 0
total_insns abs max old: 837,487
total_insns abs max new: 837,487
-100 .. -95  %: 15
 -95 .. -90  %: 12
 -90 .. -85  %: 10
 -85 .. -75  %: 8
 -75 .. -70  %: 6
 -70 .. -65  %: 14
 -65 .. -60  %: 38
 -60 .. -55  %: 10
 -55 .. -50  %: 17
 -50 .. -45  %: 36
 -45 .. -40  %: 9
 -40 .. -35  %: 25
 -35 .. -25  %: 10
 -25 .. -15  %: 11
 -15 .. -10  %: 48
 -10 .. -5   %: 47
  -5 .. 0    %: 111
   0 .. 5    %: 7488
   5 .. 15   %: 3
  15 .. 25   %: 5
  30 .. 35   %: 20
  35 .. 40   %: 7
  40 .. 50   %: 1
  60 .. 65   %: 1

Tables: success in both runs; baseline Insns >= 5,000.
Ranked by percentage change, then instruction-count change, file, program.
Meta names are anonymized; numbered objects are distinct files.

Top wins (50)
-------------

File                                Program                            Insns (A)  Insns (B)       Insns (DIFF)
----------------------------------  ---------------------------------  ---------  ---------  -----------------
verifier_bounds.bpf.o               crossing_64_bit_signed_boundary_2      12330         20   -12310 (-99.84%)
verifier_iterating_callbacks.bpf.o  test1                                   7004         12    -6992 (-99.83%)
bpf_iter_tasks.bpf.o                dump_task_sleepable                    85522        556   -84966 (-99.35%)
bpf_iter_task_stack.bpf.o           dump_task_stack                         7209         65    -7144 (-99.10%)
profiler-10.bpf.o                   hhvm_stack                             23828        347   -23481 (-98.54%)
bpf_iter_unix.bpf.o                 dump_unix                               9026        226    -8800 (-97.50%)
meta-app-22.bpf.o                   program-03                              8705        319    -8386 (-96.34%)
meta-app-22.bpf.o                   program-06                              8948        328    -8620 (-96.33%)
security-sandbox-10.bpf.o           fork                                   30760       1249   -29511 (-95.94%)
profiler-02.bpf.o                   on_py_event                            79064       3864   -75200 (-95.11%)
profiler-03.bpf.o                   on_py_event                            79064       3864   -75200 (-95.11%)
profiler-05.bpf.o                   on_py_event                            79064       3864   -75200 (-95.11%)
security-monitor-66.bpf.o           mac_sysctl_write                        7333        448    -6885 (-93.89%)
profiler-04.bpf.o                   get_task_stacks                        73176       6050   -67126 (-91.73%)
security-monitor-65.bpf.o           lsm_bprm_creds_for_exec                17538       1701   -15837 (-90.30%)
security-monitor-65.bpf.o           lsm_task_alloc                          5674        565    -5109 (-90.04%)
security-monitor-65.bpf.o           lsm_fo_task_update                     11399       1181   -10218 (-89.64%)
security-sandbox-29.bpf.o           test_glob_match                        47257       5477   -41780 (-88.41%)
load-balancer-17.bpf.o              edgeloom_tc                            24854       2984   -21870 (-87.99%)
profiler-13.bpf.o                   handle_aten_op_call_start               7183        976    -6207 (-86.41%)
security-monitor-65.bpf.o           lsm_file_open                         154412      21168  -133244 (-86.29%)
security-monitor-17.bpf.o           test_execve                           293300      46071  -247229 (-84.29%)
security-sandbox-13.bpf.o           kvm_die                                36514       5807   -30707 (-84.10%)
security-monitor-97.bpf.o           child_iter                             41266       8182   -33084 (-80.17%)
scheduler-30.bpf.o                  lavd_dispatch                         290915      66359  -224556 (-77.19%)
security-monitor-25.bpf.o           syscalls_kill                          98038      27912   -70126 (-71.53%)
security-sandbox-14.bpf.o           kernel_module_request                   7880       2357    -5523 (-70.09%)
security-sandbox-14.bpf.o           kernel_load_data                        7881       2358    -5523 (-70.08%)
security-sandbox-14.bpf.o           kernel_read_file                        7882       2359    -5523 (-70.07%)
xdp_lb_bench.bpf.o                  xdp_lb_bench                           27126       9208   -17918 (-66.05%)
firewall-05.bpf.o                   ingress                                54034      18584   -35450 (-65.61%)
firewall-05.bpf.o                   tc_in                                  54034      18584   -35450 (-65.61%)
firewall-07.bpf.o                   ingress                                54034      18584   -35450 (-65.61%)
firewall-07.bpf.o                   tc_in                                  54034      18584   -35450 (-65.61%)
security-sandbox-01.bpf.o           bpf                                    30692      10586   -20106 (-65.51%)
security-monitor-34.bpf.o           syscall_setresuid                     122200      43305   -78895 (-64.56%)
security-monitor-34.bpf.o           syscalls_setfsgid                     122200      43305   -78895 (-64.56%)
security-monitor-34.bpf.o           syscalls_setfsuid                     122200      43305   -78895 (-64.56%)
security-monitor-34.bpf.o           syscalls_setgid                       122200      43305   -78895 (-64.56%)
security-monitor-34.bpf.o           syscalls_setregid                     122200      43305   -78895 (-64.56%)
security-monitor-34.bpf.o           syscalls_setreuid                     122200      43305   -78895 (-64.56%)
security-monitor-34.bpf.o           syscalls_setuid                       122200      43305   -78895 (-64.56%)
security-monitor-15.bpf.o           cve_2021_4034                         122481      43629   -78852 (-64.38%)
security-monitor-16.bpf.o           test                                  122517      43665   -78852 (-64.36%)
security-sandbox-10.bpf.o           exec                                   12908       4626    -8282 (-64.16%)
security-monitor-12.bpf.o           connect_security_socket_connect       216252      78013  -138239 (-63.92%)
security-monitor-19.bpf.o           kernel_modules_do_init                 92980      33776   -59204 (-63.67%)
security-monitor-23.bpf.o           enter_pivot_root                       93518      34311   -59207 (-63.31%)
security-monitor-08.bpf.o           bpf_prog_detect                        93384      34494   -58890 (-63.06%)
firewall-05.bpf.o                   egress                                 58436      21951   -36485 (-62.44%)

Top losses (38)
---------------

File                              Program                        Insns (A)  Insns (B)      Insns (DIFF)
--------------------------------  -----------------------------  ---------  ---------  ----------------
profiler-26.bpf.o                 handle_cu_mem_address_reserve      34326      45724  +11398 (+33.21%)
profiler-26.bpf.o                 handle_cu_mem_create               34326      45724  +11398 (+33.21%)
profiler-26.bpf.o                 handle_malloc                      34326      45724  +11398 (+33.21%)
profiler-26.bpf.o                 handle_cu_mem_map                  34524      45922  +11398 (+33.01%)
profiler-19.bpf.o                 sched_waking                       17454      23153   +5699 (+32.65%)
profiler-27.bpf.o                 handle_cuda_launch_exc             17477      23176   +5699 (+32.61%)
profiler-27.bpf.o                 handle_cuda_launch                 17490      23189   +5699 (+32.58%)
profiler-12.bpf.o                 on_custom_event_begin              17697      23396   +5699 (+32.20%)
profiler-12.bpf.o                 on_custom_event_end                17701      23400   +5699 (+32.20%)
profiler-26.bpf.o                 handle_mtia_cached_alloc           35494      46892  +11398 (+32.11%)
profiler-26.bpf.o                 handle_mtia_allocate_enter         35555      46953  +11398 (+32.06%)
profiler-26.bpf.o                 handle_pytorch_malloc              35847      47245  +11398 (+31.80%)
profiler-19.bpf.o                 oncpu                              17990      23689   +5699 (+31.68%)
profiler-12.bpf.o                 on_task_enqueued                   18035      23734   +5699 (+31.60%)
profiler-12.bpf.o                 sched_waking                       18070      23769   +5699 (+31.54%)
profiler-12.bpf.o                 on_task_dequeued                   18210      23909   +5699 (+31.30%)
profiler-12.bpf.o                 on_request_context_event           18301      24000   +5699 (+31.14%)
profiler-12.bpf.o                 on_pytorch_event                   18302      24001   +5699 (+31.14%)
profiler-12.bpf.o                 on_task_stats                      18384      24083   +5699 (+31.00%)
profiler-12.bpf.o                 oncpu                              18488      24187   +5699 (+30.83%)
profiler-19.bpf.o                 sched_switch_offcpu                64726      78210  +13484 (+20.83%)
profiler-12.bpf.o                 sched_switch                       33515      40257   +6742 (+20.12%)
profiler-09.bpf.o                 on_custom_event_start              38281      45973   +7692 (+20.09%)
profiler-09.bpf.o                 trace_func_entry                   38281      45973   +7692 (+20.09%)
profiler-12.bpf.o                 get_crochet_walltime_stacks        43473      50215   +6742 (+15.51%)
profiler-24.bpf.o                 get_task_stacks                    94740     103742    +9002 (+9.50%)
test_cls_redirect_subprogs.bpf.o  cls_redirect                       72052      73682    +1630 (+2.26%)
security-sandbox-20.bpf.o         redirect_socket_connect            72423      73913    +1490 (+2.06%)
scheduler-28.bpf.o                arena_alloc_mask                   27159      27175      +16 (+0.06%)
scheduler-30.bpf.o                arena_alloc_mask                   27159      27175      +16 (+0.06%)
scx_cake.bpf.o                    arena_alloc_mask                   28721      28737      +16 (+0.06%)
scx_arena.bpf.o                   arena_alloc_mask                   28734      28750      +16 (+0.06%)
scx_arena_selftests.bpf.o         arena_alloc_mask                   28734      28750      +16 (+0.06%)
scx_chaos.bpf.o                   arena_alloc_mask                   28734      28750      +16 (+0.06%)
scx_p2dq.bpf.o                    arena_alloc_mask                   28734      28750      +16 (+0.06%)
scx_cake.bpf.o                    cake_init_task                     28758      28774      +16 (+0.06%)
scheduler-01.bpf.o                arena_alloc_mask                   29197      29208      +11 (+0.04%)
scheduler-03.bpf.o                arena_alloc_mask                   29197      29208      +11 (+0.04%)

Changelog
=========

v2 -> v3:
TLDR: another bunch of major correctness fixes, plus several improvements
      to avoid veristat-meta failure identified for v2.
- Widen only when allow_uninit_stack is set.
- Mark scalar registers and stack spills used by the selected bounding
  condition's base, step and bound expressions precise before widening.
- Join alternative values only for registers with compatible pointer
  metadata. Include the loop-entry value when a register is assigned an
  invariant in the body, including unconditional assignments.
- Consider up to four exit conditions dominating the backedge and use
  the tightest available iteration bound. Match the induction variable
  in either operand of the comparison.
- Require full spills for linear stack recurrences. Treat partially
  spilled and unallocated stack slots as unknown scalars and all-zero
  slots as zero. Materialize writable stack values safely, growing the
  stack when needed.
- Keep base/step in sync with the bounds as the last step of
  reg_bounds_sync(). Preserve the register state when sign extension
  leaves all possible values unchanged. Check that step is nonzero and
  base is smaller than step.
- Handle latch comparison polarity correctly when the continuing branch
  enters a nested loop. Compute SCEVs only for exits owned by the loop,
  fixing a verifier bug for irreducible inner loops.
- Exclude BPF_F_INNER_MAP single-element arrays from the separate-lookup
  shortcut in bpf_same_memory_origin().
- Fix stack-pointer tracking through load-acquire/store-release and
  atomic exchange/fetch/cmpxchg operations, so accesses through recovered
  stack pointers are included in liveness analysis.
- Derive global subprogram stack effects from BTF argument types, so
  freplace cannot invalidate a loop termination proof based on the
  original callee body.
- Compute argument liveness from callee reads for static subprograms
  and from BTF-declared arguments for globals. Prepare argument metadata
  before liveness analysis, avoiding unnecessarily live registers that
  prevented widening.
- Treat already-unbounded scalars as already widened, allowing unknown
  SCEVs such as stack outputs of probe-read helpers called through a
  subprogram.
- Widen to an unbounded range when computing an induction variable's
  range overflows signed 64-bit arithmetic, retaining the power-of-two
  alignment common to the entry value and slope.
- Fix dominator computation for subprograms whose entry is a loop header:
  initialize the entry as its own dominator during the fixed-point
  computation and skip updates to it. Use overflow-checked predecessor
  allocations.
- Replace the private worklist heap with the kernel min-heap and limit
  expression rewriting to 32 passes before falling back to unknown.
- Add regression coverage for the liveness, stack, pointer, iteration
  bound and widening changes. Fix __msg_next validation when an expected
  message is missing.

v1 -> v2:
TLDR: a bunch of major correctness fixes.
- Introduce arg_access_info to distinguish read, may-write and
  must-write effects of helper/kfunc stack accesses. Handle map-specific
  argument semantics and writes through unknown callbacks.
- Fix base/step tracking across signed overflow, truncation,
  sign/zero extension and linked-register updates.
- Rework iteration-count calculation for signed/unsigned increasing
  and decreasing counters, including counter overflow checks.
  Evaluate the full latch base expression and consistently count
  header executions.
- Substitute all registers in instantiate_header_scevs().
- Track pointer origins when evaluating latch expressions.
  Require compatible operands before deriving iteration bounds.
- Preserve the correct congruence base when widening nonconstant
  entry values, assign fresh IDs to widened packet pointers,
  and exclude nullable pointers from widening.
- Account for values modified on nested-loop exit paths when computing
  invariants. Do not use an inner loop's latch to bound an outer loop.
- Restrict pruning against in-progress SCEV states to terminating
  innermost loops sharing the same entry checkpoint, preventing
  inner-loop pruning from hiding a nonterminating outer loop.
- Rework loop entry/exit handling on the main verification pass.
- Extend fixed-stack-offset widening suppression to ANY expressions
  and all dynptr arguments described by helper/kfunc prototypes.
- Fix BTF array handling: retain bounds checks for fixed arrays inside
  flexible-array elements and preserve array type IDs when element
  types contain typedefs.
- Fix SCEV handling of endian conversions and narrow fills on
  big-endian systems.
- Grow expression storage geometrically and scale the expression hash
  table with program size. Add cancellation/rescheduling checks to
  dominator computation and fix the postorder-number allocation leak.
- Pack bpf_reg_state/bpf_func_state for latter to fit back into
  the 1 KiB allocation bucket, measured SCEV memory consumption
  overhead is 3% now.
- Major additions in the selftests.

v1: https://lore.kernel.org/bpf/20260926-scev-minimal-rebase-v1-0-c8e5ab5ba79f@gmail.com/
v2: https://lore.kernel.org/bpf/20261004-scev-minimal-rebase-v2-0-f6254e29fdf2@gmail.com/
---
Eduard Zingerman (51):
      bpf: represent stack access effects with arg_access_info
      bpf: describe helper stack accesses with arg_access_info
      bpf: describe kfunc stack accesses with arg_access_info
      bpf: track may_write flags in liveness
      bpf: summarize may write stack slots in insn_aux_data
      bpf: summarize live stack slots in insn_aux_data
      bpf: summarize regs that may hold a frame pointer in insn_aux_data
      bpf: record write effects for atomic operations in liveness.c
      bpf: fix arg_track_xfer() for atomic stack spills and fills
      bpf: derive global subprog stack liveness from BTF signatures
      bpf: compute parameters liveness in bpf_compute_live_registers()
      bpf: add tnum_alignment()
      bpf: add cnum{32,64}_union()
      bpf: add cnum64_intersect_linear()
      bpf: expose bpf_rev_opcode() and bpf_flip_opcode()
      bpf: expose bpf_grow_stack_state()
      bpf: expose bpf_verbose_snum()
      bpf: allow subrange relations for PTR_TO_STACK in regsafe()
      bpf: representation for intervals with steps
      bpf: varying offset access support for PTR_TO_BTF_ID pointers
      bpf: save DFS postorder numbers for program instructions
      bpf: move the live-register and SCC printout to a standalone function
      bpf: compute immediate dominators
      bpf: compute loop hierarchy
      bpf: add bpf_set_reg_range()
      bpf: add bpf_mark_reg_known_scalar()
      bpf: add bpf_reg_union() and bpf_reg_union_compatible()
      bpf: add bpf_split_cur_state()
      bpf: add bpf_same_memory_origin()
      bpf: add bpf_spill_size()
      bpf: record basic-block ends in insn_aux_data
      bpf: allow precision backtracking between overlapping checkpoints
      bpf: compute scalar evolution expressions for loops
      bpf: use SCEV to widen bounded loops
      bpf: avoid widening registers that hinder exact stack-slot tracking
      bpf: bpf_func_state size optimization
      selftests/bpf: __msg_next tag for matching messages on consecutive lines
      selftests/bpf: bound UNIX socket path loops by sun_path size
      selftests/bpf: test for stack-pointer subrange pruning
      selftests/bpf: tests for may_write stack-liveness tracking
      selftests/bpf: tests for may_def marks of atomic RMW operations
      selftests/bpf: tests for stack pointer spills/fills through atomics
      selftests/bpf: tests for map special cases in bpf_helper_stack_access_bytes()
      selftests/bpf: tests for BTF-based global subprog stack liveness
      selftests/bpf: test for register liveness of subprogram arguments
      selftests/bpf: tests for register base/step arithmetic
      selftests/bpf: tests for register base/step state pruning
      selftests/bpf: tests for varying offset access to PTR_TO_BTF_ID
      selftests/bpf: tests for loop hierarchy computation
      selftests/bpf: tests for immediate dominator computation
      selftests/bpf: tests for SCEV analysis and loop widening

 include/linux/bpf_verifier.h                       |  192 +-
 include/linux/cnum.h                               |    3 +
 include/linux/tnum.h                               |    2 +
 kernel/bpf/Makefile                                |    2 +-
 kernel/bpf/backtrack.c                             |    5 +
 kernel/bpf/btf.c                                   |  159 +-
 kernel/bpf/cfg.c                                   |   56 +-
 kernel/bpf/cnum.c                                  |   36 +
 kernel/bpf/cnum_defs.h                             |   44 +
 kernel/bpf/const_fold.c                            |    2 +
 kernel/bpf/fixups.c                                |   18 +
 kernel/bpf/liveness.c                              |  522 ++--
 kernel/bpf/log.c                                   |   19 +-
 kernel/bpf/loops.c                                 |  616 ++++
 kernel/bpf/ringbuf.c                               |    4 +-
 kernel/bpf/scev.c                                  | 2761 +++++++++++++++++
 kernel/bpf/states.c                                |  216 +-
 kernel/bpf/tnum.c                                  |   11 +
 kernel/bpf/verifier.c                              |  918 +++++-
 .../testing/selftests/bpf/prog_tests/exceptions.c  |    2 +-
 tools/testing/selftests/bpf/prog_tests/verifier.c  |   10 +
 tools/testing/selftests/bpf/progs/bpf_iter_unix.c  |    2 +-
 tools/testing/selftests/bpf/progs/bpf_misc.h       |    6 +
 .../selftests/bpf/progs/compute_live_registers.c   |   41 +-
 .../selftests/bpf/progs/test_skc_to_unix_sock.c    |    2 +-
 .../selftests/bpf/progs/verifier_bounds_step.c     |  544 ++++
 .../bpf/progs/verifier_btf_array_access.c          |  576 ++++
 tools/testing/selftests/bpf/progs/verifier_gotox.c |    6 +-
 tools/testing/selftests/bpf/progs/verifier_idoms.c |  377 +++
 .../selftests/bpf/progs/verifier_kfunc_uninit.c    |    6 +
 .../selftests/bpf/progs/verifier_live_stack.c      |  485 ++-
 .../selftests/bpf/progs/verifier_loop_hierarchy.c  |  346 +++
 tools/testing/selftests/bpf/progs/verifier_scev.c  | 3180 ++++++++++++++++++++
 .../selftests/bpf/progs/verifier_stack_ptr.c       |   36 +
 tools/testing/selftests/bpf/test_loader.c          |   11 +
 35 files changed, 10800 insertions(+), 416 deletions(-)
---
base-commit: e1d84a37cba984388988d2f1ddc84561413f0db2
change-id: 20260925-scev-minimal-rebase-911799c95dff
