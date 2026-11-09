Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794206839;
	b=dAu4agQv+kNlFgzlW8s2f4I4gXaXF5/cBB1F3DqzFvZJv8bAzhkzr/fZmX+pB+h+/kBr
	 oxdT8llXom2pJOdjiNqd0ooZiYDdUX54mcdl9MK7nljMvBfPkfdffHIMw2KxjCy4u4Z1p
	 vN5Ejmi7pKpgiI+6Oxo2OGfkdzaItaDlCP5NpF+AOMA3wkys+aTGSbUapeUKlsvFRFxVc
	 ui6liCXvvpaDx+af8uEKYFWlbi3x0H7f6VhBCLzuAAG5PQhbstBuJ7RBVkb8rixYB3WDz
	 b1fVtUOcT0kC+y4sonO19H5R2voZSXr1BML8MzNDqztwYa3GHV3CkhKFbWxbHa8KYag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794206839;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=VWufYkS/5YgQkDL9gVKf0LzwUgBp3CmH1GRNk55dVrU=;
	b=XTuQyakYj2FSY65hixrb8KZGArZJxH4PmwKLZxcpJbpk6bCBlPIzCHCzBU6AVlIK0Frp
	 cJV5uz/QZAYwkaZaoNfQXT3QDrXydxAEtfZGHaLlglvxFD00O5/9aaQwr2L3BWX2is2Ah
	 OLq4lVN/7yBV1S32S3uwrGQ6TSay/7Bafwhve2U5f0D85eML9DMcS4JKW4E2nj6yv2ECq
	 yG5yV/j8YJ7wQLG6iASxoEJBwq6XI7p7TFZnzJM5HayuTJcBqr8ObH7Y4SroXaiLBEkYU
	 wOqRmUSQt/XnWddW8UJlDLzY3ty2n2x9K5UqEzAbeOZtmJq9XZ1CPG1e0f065chWduA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Fn9dlWjO;
	arc=none smtp.remote-ip=209.85.210.169
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33777606A31C
	for <bpf@vger.kernel.org>; Mon,  9 Nov 2026 06:47:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 33777606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Fn9dlWjO
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-8b8ecfa886bso186080b3a.0
        for <bpf@vger.kernel.org>; Sun, 08 Nov 2026 22:47:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794206838; x=1794811638; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=VWufYkS/5YgQkDL9gVKf0LzwUgBp3CmH1GRNk55dVrU=;
        b=Fn9dlWjOYJIN/IUcsCTCw7y5nRCyzSOKdgO06xZ9uoaPVkTX1IreT/Ol3t6tM9naWX
         yD1/61Sb4I/uHHNc2U6uQrltmtFAvnsJQVb4Bbl6oN5J7h8p+7thAuH3mZK6ua4OaUYh
         Ni8ZPHrBYWMWaHviypPFg4f2BzAskkXJsWbYfR6uMfE2A7VQej3+VZmq4HWlzDuZ7AUd
         7pqgaHmSR6M46j3HtOFDR52lyimUiuda8Jq0k4z46o7J8vdmIniqyNzsCrmXDdb/3cob
         YB4RyKk9fLvWaY9L8IcEAPq3QJZMOfbeLAJY9ViIMd78Jc3oRAZ7tMmXp01+UII6JrFf
         WmPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794206838; x=1794811638;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VWufYkS/5YgQkDL9gVKf0LzwUgBp3CmH1GRNk55dVrU=;
        b=kNPfni0R5c1h/5zib9SLmTYFs+oZOfXQXyJeoh0Pz3UfPdDdcCuD/7zzkBbIIc/DSd
         /HW2H8EGwb6OIEsZCImprXnTiT5VrzVLKcxlGEV3TRgDRG3+jUA2/IRG2WpT01Xcwye+
         6pf0hExsnQQmw7NFzChkIKUhnrnPNe92NGkBXRY/XMcuuqgT2AabjKKe5bpMFMCo9VFK
         qbrWp/8uEpyF5lzijNnoCzvuWwA8RxCxh75vldjhpbQm0IDv0Fn5obZnyrGzWsII5OFN
         wmfp/uaHCE02S1uvccsQ/DUM0e3NvwF4UvCNy4jmA54lZJgMUPU4GM8PRgHdIPrJ5R0J
         Cssg==
X-Gm-Message-State: APuU4Z91Z4ooyRq+C+3bRp0rZlJ6lVef1QGYbrDINrQT49et+rBMQavd
	hALEd6gQBBAKujaqk9znZaLTY7V2SjHTD5wAsuXDqVxvikN7WmeuLY4KyO6JcA==
X-Gm-Gg: AYBFou0NoewcLnwoMqHE8ViCw3/gRql+w6i10yo8ST4QZzCQkzdJB9BTZaYIurhbSUI
	ngiud7gOVk5VVGZrxiZ1hqO39RF8T1O31n8ldjc6XVx0+VxVCS72faP8luKYGXYqcxlDJf3lOWF
	UdUnQBn9z2n0dDCeRH0LOcPNl3MRoVA+SP21z4YYURReFQ1mZsmp+QA4BcCJsT6ti896UZ0Suba
	tlsxjkHeMEmWFDdXxLXsDS6zl81G6tLbExh55vIezUve0hvlsDVPcCzlIvpmtUif/J8fUY/qxTM
	pNpPlWS+vxUencPpIO9cIpwEUP6ad8GJOomV+6fYEFyRowIEwLBaT6I9rGUFNdBM451pJh3uoov
	tO2Vvitl1pM0uWLwAX6/90asuqiLR2hlavT+JXFwOeuPG/K46WFEKZPt6ia9gmbhu5CgHLLrMJg
	HFaZmu1wjud58EQH+G11WLY95ThXfQV6adcaMS95Zs/1jGTNlvbf6GWf6FSI6nTYHfxY6Quxa68
	rBKYxPH3em58zYtssti5HDlQzAivogt/LPbViUxf8MqNliJQi3DssS9zHac78SpxDluq4aeIDed
	gH8z7F4+0sHAgsQHK3ig9zzJvM/V3alQ+eVUASRARukGHa8j2DJqMs3YYcJZtbjN+/EMZRNDHwh
	8cnyV79joX9ItEJgBfdwA4OOME2F0xdrNNtVSB2wnJHUyd6so0pAXM59Pgagc7Du3UugpWwlULQ
	==
X-Received: by 2002:a05:6a20:7fa3:b0:3e2:91c0:5b5 with SMTP id adf61e73a8af0-3edc1c4320cmr4724684637.5.1794206838015;
        Sun, 08 Nov 2026 22:47:18 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.252])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cdb96206f38sm1273924a12.0.2026.11.08.22.47.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 22:47:17 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next 00/26] bpf: Find linked registers by scalar evolution, remove scalar ids
Date: Mon,  9 Nov 2026 06:46:44 +0000
Message-ID: <20261109064715.2382452-1-alexei.starovoitov@gmail.com>
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

  char *buf = bpf_map_lookup_elem(&map, &key);    /* 128 bytes */
  ..
  p = buf + i;                                    /* i is a byte */
  if (i > 100)
          return 0;
  *p = buf[0];

The jump bounds i. p was computed before:

  invalid access to map value, value_size=128 off=255 size=1

People do not write that, compilers do. In a loop over strings or records
in a buffer clang computes 'buf + i' at the end of an iteration and tests
i at the start of the next one. Patch 15 has such a loop.

What the verifier knows about two registers is in the state:

  r2 = r1                     r1 and r2 get id 7
  r2 += 4                     id 7 | BPF_ADD_CONST64, delta 4
  *(u64 *)(r10 - 8) = r1      fp-8 has id 7
  if r1 > 100 goto ..         sync_linked_regs() refines all three

A scalar id is dropped at the second '+=', at a sign extension, at a 32-bit
spill of a wider value. A jump refines at most five registers and stack
slots (LINKED_REGS_MAX), the others lose their id. Nothing links a pointer
to its index. And scalar ids have a price: every insn that moves or
changes a scalar assigns, keeps or clears ids, regsafe() maps the ids of
two states, a join reconciles them. States that differ in nothing but
scalar ids are verified twice.

That r2 is r1 + 4, and that p is buf + i, is static. It takes no state.
Scalar evolution has it for loops: every register and stack slot has an
expression there. This series computes the expressions for whole subprogs,
before the main pass. A value that no expression describes, such as the
result of a call or a load, gets an SSA name: %r0.8 is the def of r0 by
insn 8. The prog above:

   0: call bpf_get_prandom_u32#7     r0 is %r0.0
   1: r7 = r0
   2: r7 &= 255                      r7 is (& %r0.0 255)
   8: call bpf_map_lookup_elem#1     r0 is %r0.8
  10: r6 = r0
  11: r2 = r6
  12: r2 += r7                       r2 is (+ %r0.8 (& %r0.0 255))
  13: if r7 > 0x64 goto pc+2

r6 is %r0.8 too, so at insn 13 r2 is r6 + r7. For each conditional jump
scev.c computes the linked registers: the live registers and stack slots
that are a tested register + a constant (delta) on every path to the jump,
or a pointer + a tested register + delta. The main pass refines them after
the jump. Scalar ids go.

Linked registers are static. A link holds on every path to its jump,
whatever state gets there (intraprocedural: the entry values of a subprog
are symbols, so a fact holds for every caller). There is no limit of five
registers and none on the constants that are added. A link can hold modulo
2^32, 2^16 or 2^8 only, which covers extensions and partial spills. The
types of the registers are read in the state at the jump. Nothing is added
to struct bpf_reg_state, and delta goes.

Patch 1, by Vineet Gupta, stands alone.
  1  'w0 = (s8)w0' keeps a 32-bit range that fits in s8 already: the sign
     extension is a no-op.

Patches 2 - 7 change kernel/bpf/scev.c only. They are prerequisites of
patch 12: they get the expressions ready for all code. The main pass does
not use them yet. No verdict changes.
  2  A fix of the representation. 'w5 >>= w4' and 'r5 >>= r4; w5 = w5' had
     the same expression, (zext32 (>> r5 r4)). They are distinct values.
     The operands of 32-bit shifts and divisions are zero or sign
     extended, a shift amount is masked:
     (zext32 (>> (zext32 r5) (& r4 31))).
  3  Cost. Expressions are going to be constructed for all insns of a prog,
     not only for loops. The hash table allocated for every second
     expression. It gets chains in an array, it grows, (REG r) has a fixed
     id. With all code analyzed: 471 -> 6 allocations per load, the time in
     scev.c per insn goes from 485 to 291 ns. A constant factor, 1.7.
  4  Cost. No phi for a dead register (pruned SSA). At a join point 25
     registers and stack slots have two expressions on average, one of
     them is live. 1.79 -> 0.78 expressions per insn, 291 to 170 ns per
     insn: 1.7 again.
  5  Simplify an expression at construction, so that 'r2 is r1 + 3' is at
     its root however many insns computed it. Patches 12 and 15 compare
     expressions at every conditional jump.
  6  What a load or a call returns was '_', one expression for all of
     them. Such a value gets an SSA name: a def by an insn, %r0.6, or a phi
     before an insn, %r8.7=phi(1, 2). From here on an expression id can be
     a value number (struct expr::is_vn): the registers that have it hold
     the same value.
  7  Compute the expressions for whole subprogs. A subprog is analyzed as
     the outermost loop, which runs once. No users yet.

Patches 8 - 9 are about stack slots. A slot keeps its expression across
a store through a pointer and across a call if that insn cannot write to
the slot. scev.c takes that from bpf_may_write_mask(). liveness.c computes
the mask before the main pass: it tracks the values derived from FP and
looks at the types of the arguments of helpers and kfuncs. Nothing checked
it.
  8  bpf_sys_bpf() stores log_true_size into the attr of its caller, but
     arg2_type in bpf_sys_bpf_proto is ARG_PTR_TO_MEM | MEM_RDONLY. Mark it
     MEM_WRITE.
  9  The main pass sees every write to a stack. Check each of them against
     the mask of the insn.

Patches 10 - 11 fix what is wrong in the main pass today. The patches
after them refine more registers and stack slots, so more progs would run
into both.
 10  'r0 <<= 3; r0 += 5; if r0 s< -2 goto ..; if r0 s> 1 goto ..'
     The range [-2, 1] and var_off don't overlap. The verifier goes on with
     an empty register, up to "verifier bug: REG INVARIANTS VIOLATION".
     Detect at the jump that the branch is dead.
 11  On big endian the first half-slot of a 64-bit spill has the upper 32
     bits of the value. __clean_func_state() and stacksafe() treated it as
     a 32-bit spill, which has the low 32 bits.

Patches 12 - 16 use the expressions.
 12  A new ability. find_linked_regs() computes the linked registers of
     each conditional jump: expressions with a constant difference, modulo
     2^64, 2^32, 2^16 or 2^8. check_cond_jmp_op() refines them:
     refine_linked_regs(). sync_linked_regs() still runs.
 13  Tests for 12. The tests of scalar ids stay and cover the mechanism.
     The new ones are for what only a static analysis can get wrong:
     an arena add that is converted to ALU32, a store through a dynptr
     slice, an edge that the verifier adds, a link at a loop header,
     a pointer that is not a scalar, big endian half-slots, an empty
     intersection.
 14  More tests, by Vineet Gupta: sign extensions, for 1 and 12.
 15  A new ability. A linked register can be a pointer: base + the tested
     register + delta. After the jump the main pass recomputes it, as
     'p = buf; p += i' would, with the i that the jump refined. The prog at
     the top loads. A live register or stack slot has to hold buf at the
     jump: 'buf += i' in place is not found.
 16  Tests for 15.

Patches 17 - 24 remove scalar ids: their users (17 - 20), the ids (21),
dead code (22 - 24).
 17  scev.c left it to the main pass to check, by scalar ids, that an
     induction variable and its copy hold the same value at loop entry. It
     compares their expressions there.
 18  scev.c does not analyze irreducible loops, so the jumps in them have
     no linked registers. Find them in the basic block of the jump (local
     value numbering).
 19  Remove sync_linked_regs(). Jumps refine by scalar evolution only.
 20  flow_join_makes_up() recognized copies of a scalar by their id. It
     compares their ranges. A heuristic on which states are joined:
     soundness does not depend on it.
 21  Stop assigning ids to scalars. States that differed in scalar ids only
     are one state.
 22  Dead code: scalar ids in regsafe().
 23  Dead code: scalar ids in the join of states.
 24  Dead code: scalar ids in the log and in bpf_verifier.h.

Patches 25 - 26 are about loops of GCC. scev.c computes the iteration
count of a loop (header_count: how often the header is executed).
header_count = backedge-taken count + 1. A loop without it is walked: the
verifier unrolls the loop, one state per iteration; a counted loop is
summarized, one state for all iterations. A long loop that is walked ends
with "more than 1024 states that cannot be joined". Such loops loaded when
the verifier explored each path.
 25  A new ability. GCC keeps 'int i' as the sign extension of a 32-bit
     add: 'w1 += 1; r3 = (s32)r1'. That is a new recurrence,
     (sext32 (linear r3 1)). A wrap is handled.
 26  Tests for 25.
Long loops of GCC that still have no iteration count are rejected as
before, among them dump_task_sleepable() of bpf_iter_tasks.c, where one of
two backedges has no linear latch.

Precision that is lost is listed in patches 17 and 19. Most of it: linked
registers belong to the frame of the jump. Scalar ids also linked
registers and stack slots of the callers: a subprog that tests its
argument refined the register that the caller keeps.

Patches 12 - 24 do what patches 3 - 12 of Vineet Gupta's "bpf: track scalar
equality across the low 32 bits" v3 [1] do, without a link in the state.
Patch 1 and the tests of patch 14 are his.

The selftests as GCC builds them gain most. GCC keeps the int that a call
returned as 'r5 = (s32)r0', tests w0 and returns r5, and no scalar id
links r5 to r0. "should have been in [0, 1]" is in the log of
test_progs-bpf_gcc 19 times before the series and never after it,
83 tests and 303 subtests fail in place of 87 and 320. Of the 220 entries
of BPF CI's deny list for that flavour 64 pass, 58 did.

kernel/ and include/: 1513 lines added, 948 removed.

veristat over 32913 progs, against the tree before the series. 29 more
load: 20 of the selftests as GCC builds them, among them profiler1-3,
test_sk_lookup and setget_sockopt, and 9 asm tests. One asm test stops
loading in its four flavours, "regalloc in callee". Patch 19 changes it.

                     progs           load     insns   states
  selftests, clang   18810  11750 -> 11754   -0.21 %  -0.43 %
  selftests, GCC      6011   3651 ->  3672   -3.74 %  -4.28 %
  Cilium              5193   5189 ->  5189   -0.80 %  -1.76 %
  sched_ext           1272   1163 ->  1163   +0.05 %  +0.03 %
  katran, bpfjailer    538    511 ->   511   -0.48 %  -0.66 %
  Rust                1089   1081 ->  1081   -5.56 %  -6.59 %
  all                32913  23345 -> 23370   -2.79 %  -4.42 %

To load them the kernel spends 1.4 % more instructions on the C programs
and 4.3 % fewer on those in Rust (perf stat): scev.c analyzes all code
(patches 7 and 12), the main pass verifies fewer insns and states
(patch 21). mem_peak of veristat goes down by 0.9 % and 7.5 %. Load time
follows the instructions: 1 to 2 % more for the C programs, 4 to 8 % less
for those in Rust.

[1] https://lore.kernel.org/bpf/20261020161907.2115379-1-vineet.gupta@linux.dev/

Signed-off-by: Alexei Starovoitov <ast@kernel.org>

Alexei Starovoitov (24):
  bpf: Model 32-bit shifts and divisions exactly in scalar evolution
  bpf: Construct scalar evolution expressions without allocations
  bpf: Don't join dead registers in scalar evolution
  bpf: Simplify scalar evolution expressions at construction
  bpf: Give SSA names to the values that scalar evolution does not track
  bpf: Compute scalar evolution expressions for whole subprogs
  bpf: Mark the attr argument of bpf_sys_bpf() as MEM_WRITE
  bpf: Check writes to the stack against bpf_may_write_mask()
  bpf: Detect a dead branch when a range and var_off don't overlap
  bpf: Don't treat half of a 64-bit spill as a 32-bit spill on big
    endian
  bpf: Refine registers linked by scalar evolution at conditional jumps
  selftests/bpf: Test registers linked by scalar evolution
  bpf: Recompute a pointer after the jump that bounds its index
  selftests/bpf: Test a pointer computed before its index is bounded
  bpf: Find a copy of an induction variable without scalar ids
  bpf: Find linked registers in the basic blocks of irreducible loops
  bpf: Remove sync_linked_regs(), refine by scalar evolution only
  bpf: Recognize copies of a scalar by their ranges in
    flow_join_makes_up()
  bpf: Stop assigning ids to scalars
  bpf: Remove scalar ids from regsafe()
  bpf: Remove scalar ids from the join of states
  bpf: Remove scalar ids from the log and from bpf_verifier.h
  bpf: Support sign-extended 32-bit linear scalar evolution
  selftests/bpf: Test loops with a sign-extended 32-bit induction
    variable

Vineet Gupta (2):
  bpf: Keep the 32-bit range across a no-op sign extension
  selftests/bpf: Test sign extensions of a range and of a linked
    register

 include/linux/bpf_verifier.h                  |   53 +-
 kernel/bpf/flow.c                             |   15 +-
 kernel/bpf/join.c                             |   54 +-
 kernel/bpf/liveness.c                         |   13 +
 kernel/bpf/log.c                              |   10 +-
 kernel/bpf/scev.c                             | 1594 +++++++++++++----
 kernel/bpf/states.c                           |  127 +-
 kernel/bpf/syscall.c                          |    2 +-
 kernel/bpf/verifier.c                         |  593 +++---
 .../selftests/bpf/prog_tests/reg_bounds.c     |    5 +-
 .../selftests/bpf/progs/verifier_arena.c      |   70 +
 .../bpf/progs/verifier_array_access.c         |    2 +-
 .../selftests/bpf/progs/verifier_bounds.c     |   37 +-
 .../bpf/progs/verifier_bounds_step.c          |    6 +-
 .../bpf/progs/verifier_direct_packet_access.c |    2 +-
 .../bpf/progs/verifier_linked_scalars.c       |    5 +-
 .../selftests/bpf/progs/verifier_loop_latch.c |    8 +-
 .../selftests/bpf/progs/verifier_movsx.c      |  186 ++
 .../selftests/bpf/progs/verifier_raw_stack.c  |   35 +
 .../selftests/bpf/progs/verifier_reg_equal.c  |   11 +-
 .../selftests/bpf/progs/verifier_regalloc.c   |    2 +-
 .../selftests/bpf/progs/verifier_scalar_ids.c |   70 +-
 .../selftests/bpf/progs/verifier_scev.c       |  321 +++-
 .../selftests/bpf/progs/verifier_spill_fill.c |   31 +
 24 files changed, 2147 insertions(+), 1105 deletions(-)

-- 
2.55.0

