Received: from mail-pj2-f41.google.com (mail-pj2-f41.google.com [74.125.227.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43D472FE05C
	for <bpf@vger.kernel.org>; Sat, 26 Sep 2026 14:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790432450; cv=none; b=NQkk64cE2QKxwXMIRYLH2/1wf7wTlozw7GpDnBWQ9vxJ4re8mhChzwSo5QHs2IJg8PBIwSHVVq+3Ii4picq6tCu2ummK2dJM52/PTB0o12LKq0JfOeD90aLxHbSlvlYO1hFb1ePWHSFvb+oZM50LEIISVjXZAEzQYtbF6Min6sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790432450; c=relaxed/simple;
	bh=k++0JCD+uQhctGVsCJo+TEgRNo954cZ6zsypfE7k7ic=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=b15BFk+aW5xPnqEDk8EpLWN86+/Sj4840KaPT2WB/ZRZB6nt0cMTBDIoXIOSkTSCdULeEARCak9IqBYBFAG5eyOaDv63pLw9/Yv6tUszYvxAi1UaLqpq8M1YURaiz+XpbyQFxlhkUKbB/mWqKgx9sJSxQzfqWeiD0pEOaDLbM6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dw6Z2GTt; arc=none smtp.client-ip=74.125.227.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dw6Z2GTt"
Received: by mail-pj2-f41.google.com with SMTP id 98e67ed59e1d1-3a0abca97c0so941498a91.1
        for <bpf@vger.kernel.org>; Sat, 26 Sep 2026 07:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790432447; x=1791037247; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QXtTJnIwOwlNSaT3zuDzEn3MOJUVnl5wpo3sERpAgvM=;
        b=Dw6Z2GTtVkhbSIqBXePKiihjDospdKpEuKbThuNFyf4LO9zTjM9wfmWuhJVmuWEiyJ
         r1tZE2wv2dIyjL+rjBxyN9c/vrBtghdYbaGl3EkH+pYHm6mN9+LUaf8h6Aq3wLqaPC4I
         +BnrYIfyjC5uLliDTuN9eOzpwTafau9MVp8SKEvsbF4iPKpkZ2RlUrP1RbMt2Vb1UOSa
         T1EoqNzWXjPo/gKs9c9m8QLv2a3dTPq8pj/VmNTtushbkuazEm9SeviXVs5zArXZ5dJe
         AV5XkJxg+Tsw+4uMXe/G7dsfghqRucZmpovTCX3RtSBbzCLBKmXaq1y7mDvI7sXKLPuj
         cpzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790432447; x=1791037247;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QXtTJnIwOwlNSaT3zuDzEn3MOJUVnl5wpo3sERpAgvM=;
        b=EF5U9IPqcn5dJwoD8hMkAfEu+6UQVy9tt1rJqPbYKK5a3mHtwaZQKbe/3sSXjZWoI8
         bxfuZvjhZEuyHcwBeUwFhbvBNY0eia8Whv1bdUueHzyiSd8hrn+y/GsEmXujaIUTzmlM
         lexiDWkPGblXmzaoP99dZasT3zHJcs/siVrmD/Kf/rl2ydtSOuWEIImZElBbjvnR+dxj
         rDfgT6JMBwviLC3Y7T1jzeaj+x3E+jQyUCyG3oXodIMqpRT5oKV3H9aRoVTBGKgYeUk3
         OS4ONYXNbwM5E5gviugVvXXFXpUyqIkS3iYklvhB8K53fuiTmxMfn/YGlhTuEmCGvGZ7
         Ubqw==
X-Gm-Message-State: AFq9FYJSZLilr/04hUC4zBWFxTno1G9XigbfpVJRBIdN09rT5S9jIm3Q
	zDOn+HKXcB6/kE02ez6zpQkoTjRbJsDiYWUe+0ZZy/dDN7R0g8881EY/uP8YBofK6TA=
X-Gm-Gg: AYBFou0B6HIh3fLYnP7lkbzJa9sVEbnk+FRbtLhIbIFoDtI/J7TbzfISvl5Zs+5Kn3k
	7I/KKcdAQOS5YX3kRve3qmlgeLsoVcHJbLvdAYMU2LgjMDUGFszxWq+Bq/22vdAWQd1lZpgbCy8
	FoaLYmXjR4NQ0s7pLEr2JorH+f96ZvPvyT1/1IwLR75FiqyMCZzpWsnLUjQxUICemdWjh1vmteZ
	tizQX8fDDgFQ6yyLFY307f3m26s0Bz+/BU76Xqz75ROefNpONlPb3PIthsh+6sqtuD/+7LwiVHe
	Nt40XG6Ya7QHgbtNUn4zjO9rTsDL5eFEpNOBpFr6KPCcw6yd78lYFMEFweukXtEL6zpKAiwLHaR
	wYv/6LH55gwEXDYV21tc1N0zLudKFwpCj4aRnTOXMxQJwgog7fM3bIze9k/1Ffv3oSeiUBDpkrN
	34HI3tb/Ua74H5JMSWXviB8Kbhg76ccqqjlTNcams+xOt39vBt0VjZePrj37ydyS+K0ak2Gb6mW
	N1tikr/JCwgRqOh4pY/01IUscAYsnHE76RfK/ErnQE=
X-Received: by 2002:a17:90b:2b44:b0:3a0:c276:1ed1 with SMTP id 98e67ed59e1d1-3a0c27622bamr3443231a91.3.1790432447058;
        Sat, 26 Sep 2026 07:20:47 -0700 (PDT)
Received: from ezingerman-fedora-PF4V722J ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0c2e986easm10949613a91.1.2026.09.26.07.20.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 07:20:46 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org
Cc: daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next 00/36] bpf: use scalar evolution to widen bounded loops
Date: Sat, 26 Sep 2026 07:19:58 -0700
Message-ID: <20260926-scev-minimal-rebase-v1-0-c8e5ab5ba79f@gmail.com>
X-Mailer: git-send-email 2.55.0
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
- Preparatory patches extending liveness analysis to collect
  additional information and adding various utility functions.
- Patches relaxing the verifier's current restrictions on accessing
  memory via varying offset pointers, specifically:
  - "bpf: allow subrange relations for PTR_TO_STACK in regsafe()"
  - "bpf: representation for intervals with steps"
  - "bpf: varying offset access support for PTR_TO_BTF_ID pointers"
- Patches to compute the immediate dominator tree and loop hierarchy.
- Patches implementing scalar evolution and integrating it with
  the main verification pass:
  - "bpf: avoid widening registers that hinder exact stack-slot tracking"
  - "bpf: use SCEV to widen bounded loops"
  - "bpf: compute scalar evolution expressions for loops"
- Tests.

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

8. Some equivalent latch forms and large or wrapping recurrences:

       if (bound > i) goto again;      // i is the BPF source operand

       for (u64 i = 0, x = 0; i < 4; i++) {
           use(x);
           x += 65536;                // slope outside signed 16 bits
       }

   Latch matching currently expects the induction variable as the
   destination operand. Widened slopes must be nonzero signed-16-bit
   constants, computed ranges must fit signed 64-bit arithmetic,
   and iteration counts must be representable and finite.

9. Some hard-coded constant limits:
   - Programs with more than 16 nested loops in one function are rejected.
   - Loops with more than 256 exits exceed the metadata limits and are
     not analyzed for widening.
   - Expression traversal is limited to depth 8. Only a small fixed number
     of alternative values can be joined.

Memory consumption
------------------

SCEV retains environments at analyzed block boundaries, including loop
headers and latch conditions, rather than at every straight-line
instruction. Branch-heavy loop bodies can nevertheless require many
environments, even when the loop is ultimately not widened:

    for (u64 i = 0; i < 8; i++) {
        if (p0) x += 1; else x += 2;
        if (p1) x += 3; else x += 4;
        ...                         // many more branches and joins
    }

Each environment uses 2,136 bytes for its register and stack arrays.
A loop with about 500,000 conditional jumps, each skipping one
instruction, can require roughly a million environments:
about 2 GiB for these arrays alone.

Veristat changes
================

A is master and B is this patch-set. The comparison for 7,152
programs: 134 from Cilium, 1,222 from Meta, 375 from sched_ext,
and 5,421 from BPF selftests.

Current impact on selftests is small. Work is in progress to improve
this, for example, reducing pyperf600_nounroll from 460,062 to 1,588
processed instructions. This follow-up work is not included below.

The histogram includes all programs in the corpus, including failed
loads and programs below the table cutoff. The 6,877 unchanged
programs are in the 0..5% bin. Veristat accepts 4,750 programs on A
and 4,758 on B: 10 new acceptances and two new rejections. Both new
rejections are expected by this series' selftests.
These are load verdicts, not test pass/fail counts.

Insns change   Programs
-------------  --------
-100 .. -95 %         8
-95 .. -90 %         10
-90 .. -85 %          8
-85 .. -75 %         15
-75 .. -65 %         17
-65 .. -60 %         32
-60 .. -55 %          7
-55 .. -50 %         16
-50 .. -45 %         23
-45 .. -40 %          8
-40 .. -35 %          6
-35 .. -25 %         10
-25 .. -20 %         11
-20 .. -10 %          8
-10 .. -5 %          55
-5 .. 0 %             9
0 .. 5 %           6898
5 .. 15 %             3
35 .. 40 %            6
40 .. 50 %            1
60 .. 65 %            1

The tables include only programs accepted in both runs with at least
5,000 baseline verifier-processed instructions.

Top wins (50)
-------------

File                                Program                              Insns (A)  Insns (B)       Insns (DIFF)
----------------------------------  -----------------------------------  ---------  ---------  -----------------
verifier_iterating_callbacks.bpf.o  test1                                     7004         12    -6992 (-99.83%)
bpf_iter_tasks.bpf.o                dump_task_sleepable                      85522        556   -84966 (-99.35%)
bpf_iter_task_stack.bpf.o           dump_task_stack                           7209         65    -7144 (-99.10%)
bpf_iter_unix.bpf.o                 dump_unix                                 9109        226    -8883 (-97.52%)
security-monitor-62.bpf.o           lsm_bprm_creds_for_exec                  17538       1701   -15837 (-90.30%)
security-monitor-62.bpf.o           lsm_task_alloc                            5674        565    -5109 (-90.04%)
security-monitor-62.bpf.o           lsm_fo_task_update                       11399       1181   -10218 (-89.64%)
security-monitor-62.bpf.o           lsm_file_open                           154412      21168  -133244 (-86.29%)
security-sandbox-17.bpf.o           ptrace_traceme                           16036       3134   -12902 (-80.46%)
security-sandbox-10.bpf.o           fork                                     30760       6211   -24549 (-79.81%)
security-sandbox-17.bpf.o           ptrace_access_check                      21206       5258   -15948 (-75.21%)
security-sandbox-12.bpf.o           task_kill                                27823       7688   -20135 (-72.37%)
security-monitor-22.bpf.o           syscalls_kill                            97920      27794   -70126 (-71.62%)
security-sandbox-13.bpf.o           kernel_module_request                     7175       2461    -4714 (-65.70%)
security-sandbox-13.bpf.o           kernel_load_data                          7176       2462    -4714 (-65.69%)
security-sandbox-13.bpf.o           kernel_read_file                          7177       2463    -4714 (-65.68%)
security-monitor-32.bpf.o           syscall_setresuid                       122082      43187   -78895 (-64.62%)
security-monitor-32.bpf.o           syscalls_setfsgid                       122082      43187   -78895 (-64.62%)
security-monitor-32.bpf.o           syscalls_setfsuid                       122082      43187   -78895 (-64.62%)
security-monitor-32.bpf.o           syscalls_setgid                         122082      43187   -78895 (-64.62%)
security-monitor-32.bpf.o           syscalls_setregid                       122082      43187   -78895 (-64.62%)
security-monitor-32.bpf.o           syscalls_setreuid                       122082      43187   -78895 (-64.62%)
security-monitor-32.bpf.o           syscalls_setuid                         122082      43187   -78895 (-64.62%)
security-monitor-12.bpf.o           connect_security_socket_connect         216137      77825  -138312 (-63.99%)
security-monitor-16.bpf.o           kernel_modules_do_init                   92863      33648   -59215 (-63.77%)
security-monitor-20.bpf.o           enter_pivot_root                         93400      34193   -59207 (-63.39%)
security-monitor-08.bpf.o           bpf_prog_detect                          93266      34376   -58890 (-63.14%)
security-monitor-31.bpf.o           inode_create                             96265      37055   -59210 (-61.51%)
security-monitor-10.bpf.o           cgroup_mkdir                             96513      37525   -58988 (-61.12%)
security-monitor-03.bpf.o           net_block_bind                           64652      25231   -39421 (-60.97%)
security-monitor-03.bpf.o           net_block_recvmsg                        64652      25231   -39421 (-60.97%)
security-monitor-03.bpf.o           net_block_sendmsg                        64652      25231   -39421 (-60.97%)
security-monitor-04.bpf.o           action_proc_term_sched_process_exec      64739      25299   -39440 (-60.92%)
security-monitor-13.bpf.o           sock_iter                                64818      25350   -39468 (-60.89%)
file-system-monitor-03.bpf.o        proc_file_open                           64883      25437   -39446 (-60.80%)
security-monitor-34.bpf.o           udp_recv_v6                              65089      25623   -39466 (-60.63%)
security-monitor-34.bpf.o           udp_send_v6                              65089      25623   -39466 (-60.63%)
security-monitor-34.bpf.o           udp_recv_v4                              65092      25626   -39466 (-60.63%)
security-monitor-34.bpf.o           udp_send_v4                              65093      25627   -39466 (-60.63%)
security-monitor-18.bpf.o           memfd_create                             65291      25845   -39446 (-60.42%)
security-monitor-17.bpf.o           lsm_file_open                           130665      51773   -78892 (-60.38%)
security-monitor-07.bpf.o           security_socket_listen                   65378      25932   -39446 (-60.34%)
security-monitor-05.bpf.o           accept_security_socket_accept            65435      25989   -39446 (-60.28%)
security-monitor-21.bpf.o           raw_tracepoint__sched_process_exec       65511      26045   -39466 (-60.24%)
security-monitor-06.bpf.o           bash_reader                              65601      26161   -39440 (-60.12%)
security-monitor-30.bpf.o           python3_armor                            65805      26339   -39466 (-59.97%)
security-monitor-32.bpf.o           syscalls_setgroups                       67083      27617   -39466 (-58.83%)
security-monitor-09.bpf.o           fexit_cap_capable                        68221      28162   -40059 (-58.72%)
security-sandbox-31.bpf.o           test_file_open                           15279       6331    -8948 (-58.56%)
security-monitor-03.bpf.o           net_block_init                           71217      31453   -39764 (-55.83%)

Top losses (10)
---------------

File               Program  Insns (A)  Insns (B)    Insns (DIFF)
-----------------  -------  ---------  ---------  --------------
firewall-06.bpf.o  ingress       9323       9624   +301 (+3.23%)
firewall-06.bpf.o  tc_in         9323       9624   +301 (+3.23%)
firewall-08.bpf.o  ingress       9323       9624   +301 (+3.23%)
firewall-08.bpf.o  tc_in         9323       9624   +301 (+3.23%)
firewall-06.bpf.o  egress        9334       9635   +301 (+3.22%)
firewall-08.bpf.o  egress        9334       9635   +301 (+3.22%)
firewall-06.bpf.o  tc_eg         9488       9789   +301 (+3.17%)
firewall-08.bpf.o  tc_eg         9488       9789   +301 (+3.17%)
firewall-05.bpf.o  tc_eg       156665     161269  +4604 (+2.94%)
firewall-07.bpf.o  tc_eg       156665     161269  +4604 (+2.94%)

---
Eduard Zingerman (36):
      bpf: track may_write flags in liveness
      bpf: summarize may write stack slots in insn_aux_data
      bpf: summarize live stack slots in insn_aux_data
      bpf: summarize regs that may hold a frame pointer in insn_aux_data
      bpf: record write effects for atomic operations in liveness.c
      bpf: add tnum_alignment()
      bpf: add cnum{32,64}_union()
      bpf: add cnum64_intersect_linear()
      bpf: add bpf_set_reg_range()
      bpf: add bpf_mark_reg_known_scalar()
      bpf: add bpf_reg_union()
      bpf: expose comparison opcode transformations
      bpf: allow subrange relations for PTR_TO_STACK in regsafe()
      bpf: representation for intervals with steps
      bpf: varying offset access support for PTR_TO_BTF_ID pointers
      bpf: save DFS postorder numbers for program instructions
      bpf: move the live-register and SCC printout to a standalone function
      bpf: compute immediate dominators
      bpf: compute loop hierarchy
      bpf: add a min-heap for ordered analysis worklists
      bpf: record basic-block ends in insn_aux_data
      bpf: add bpf_split_cur_state()
      bpf: allow precision backtracking between overlapping checkpoints
      bpf: compute scalar evolution expressions for loops
      bpf: use SCEV to widen bounded loops
      bpf: avoid widening registers that hinder exact stack-slot tracking
      selftests/bpf: __msg_next tag for matching messages on consecutive lines
      selftests/bpf: test for stack-pointer subrange pruning
      selftests/bpf: tests for may_write stack-liveness tracking
      selftests/bpf: tests for may_def marks of atomic RMW operations
      selftests/bpf: tests for register base/step arithmetic
      selftests/bpf: tests for register base/step state pruning
      selftests/bpf: tests for varying offset access to PTR_TO_BTF_ID
      selftests/bpf: tests for loop hierarchy computation
      selftests/bpf: tests for immediate dominator computation
      selftests/bpf: cover SCEV analysis and loop widening

 include/linux/bpf_verifier.h                       |  156 +-
 include/linux/cnum.h                               |    3 +
 include/linux/tnum.h                               |    2 +
 kernel/bpf/Makefile                                |    2 +-
 kernel/bpf/backtrack.c                             |    5 +
 kernel/bpf/btf.c                                   |  149 +-
 kernel/bpf/cfg.c                                   |   56 +-
 kernel/bpf/cnum.c                                  |   36 +
 kernel/bpf/cnum_defs.h                             |   44 +
 kernel/bpf/fixups.c                                |   18 +
 kernel/bpf/heap.c                                  |   87 +
 kernel/bpf/liveness.c                              |  335 ++-
 kernel/bpf/log.c                                   |    7 +
 kernel/bpf/loops.c                                 |  576 +++++
 kernel/bpf/scev.c                                  | 2246 ++++++++++++++++++++
 kernel/bpf/states.c                                |  197 +-
 kernel/bpf/tnum.c                                  |   11 +
 kernel/bpf/verifier.c                              |  514 ++++-
 tools/testing/selftests/bpf/prog_tests/verifier.c  |   10 +
 tools/testing/selftests/bpf/progs/bpf_misc.h       |    6 +
 .../selftests/bpf/progs/verifier_bounds_step.c     |  307 +++
 .../bpf/progs/verifier_btf_array_access.c          |  506 +++++
 tools/testing/selftests/bpf/progs/verifier_gotox.c |    6 +-
 tools/testing/selftests/bpf/progs/verifier_idoms.c |  390 ++++
 .../selftests/bpf/progs/verifier_live_stack.c      |  209 +-
 .../selftests/bpf/progs/verifier_loop_hierarchy.c  |  317 +++
 tools/testing/selftests/bpf/progs/verifier_scev.c  | 1108 ++++++++++
 .../selftests/bpf/progs/verifier_stack_ptr.c       |   33 +
 tools/testing/selftests/bpf/test_loader.c          |   10 +
 29 files changed, 7107 insertions(+), 239 deletions(-)
---
base-commit: 6ac134ec930642d5b574b63a72a0e999c2470c64
change-id: 20260925-scev-minimal-rebase-911799c95dff
