Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794415560;
	b=4ZyofuJlkRWcLV643x9BOqR/sMvgsDd9C0vRw1UHyr/50fYFMduphUhxFKnwo9G6LHX3
	 pmwvvmGTI/e/8moYdr7NXSCqKVsQyeLfZQlNZ//vVQwqQVYm9I2TL18nXLry51zT0OE3K
	 ZudWGsYU9bNaAiF/TvJf+BEIFn3CdzYZbTeYeALEQKODqpcUR4QdT5AZVis7zlnNOK8PC
	 HGh5oOZuBbnRdyJlJEwW+JstWzoDxAfuzccj4cVxK25iU2oGiyfIChkIkZHnT5UOKvCLr
	 srHvCJBg2dI3RzmaWHWkQGz+uiUcOED7AsL/pCpGlkrM597BDCE2IY7O71zA7OYz7Wg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794415560;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=ZaPP0tkht1XuBPcZogpcOgrS3gxzJYqo91fKSzFuDro=;
	b=mOcLFcNvc/GPQHSuX9b+y51nrpC/ITIssvp9iKbIiqjdQ9GRUgpxWZBcQxuhBWwLr6qQ
	 cLJndNl/RXjwwo6GjMt1Ez+uaFuaOvjVDh45YnPvNCe5LAmaWBmAOarTyhE1b9HoQqKdq
	 B/NyaDHJOpqvE5xR6RvDnN1zzq9JB0OWWh2W1+LKiyeg/rmm4B4ALfQ6Y3vFkY5YBqZd5
	 kJtugI64aorN8fH+9I+tGX+QoGga6IUV49FamCoJ3wAJWj8qr4cmps5qET7WWWj2MpMTj
	 Y/p+tgdIec9IryUaQAvhQ03gZQ1pMD8NugeYtP5IyaNkTTWLj19W/TaiHSWfEo9TlWg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=n181o67g;
	arc=none smtp.remote-ip=209.85.215.169
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42396606A31C
	for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 16:46:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 42396606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=n181o67g
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-cc4c02ddd62so1607677a12.0
        for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 08:46:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794415560; x=1795020360; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZaPP0tkht1XuBPcZogpcOgrS3gxzJYqo91fKSzFuDro=;
        b=n181o67gWPkAaR9c83wVgXu+DQPNEPa6/0Dfovzfd4tm1SNE0kH8ww2G+z2Y1vWqrN
         FCDJQiOzauOrxPgNpxc6kTJiuew/WKADhKJoWKrMeUJJ6dJkxTaRaCeAYnK2qEM5bYiI
         DZkaxVxMzzBeEOwbGz81jhevrDCkpUboKs82ClZJi0BC4LVJYZVO5sf0dRyhgrl8/+hW
         u2/PuaaislviTWlTFknLd0kMUQYxCBpe4qkhgvGOiTz0ugXZw/nuuhBPDxYSx6pVSEm+
         WjNWyBWzTQcorxnTen74me9cfCrAVBnbg/hvEi+tsWk+J7aAp1sXlWLRDB+EJafxTb6i
         rMvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794415560; x=1795020360;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZaPP0tkht1XuBPcZogpcOgrS3gxzJYqo91fKSzFuDro=;
        b=uPxnV1aIWpEcj7go2cNEqQMNVGT/0jsSDrVqG5j2QEVWPBQX0/OPc+4LWkjrupsLCo
         8ntRvazerv5jnZ7HURX+y9LRxb7ycadOdk+94WY+YwZMlqexrFS7pQXePTJUgp0mIdfH
         xOT38gzVYnHmKJJhxF1QhWj97fjfvN9d+w1tJHld2mGuhTdkVIM5bOSFoFxV7BEqw4Ay
         Lb36CT810cc4Abx2FGWndsGffnqjKPF+uoDYhpLZ+R2pn/wq+QbOJAtpmzbse8F2yBAz
         qkPDxplOlBNtIlkSOV51HfVR7zj8PUM2lUNI78301gOp48rh3RgM6tCGmGKHUSl/FNPy
         KceA==
X-Gm-Message-State: APuU4Z89oWgcLNPRZfhNlk2xlLjoSTWGcc4d0lW/rl7aY4+7vbevlZ9p
	rduMGLPct9QnZ+3mH+ICDoayVr77eFkdPgppo2kQnnxeivY/yOsWW/35i6m/5Q==
X-Gm-Gg: AYBFou1WAByCG/1s70eIKgGvX6japh4o61pYzcCdBChuGqdPbraJhVp6x1KrRloewi1
	vPeP1Q8E7tc64Acgdw26LwZjXzbN/VDYCpIV+Mu4HxpGzd03od4EkP+fHmbIxFUDIUpTMmx9KRG
	d84PeNdKPmWoFzsiiudpsBUP0Dppn0CGgIDWFLG1anySu2R5WBkCAfJ4d50E1hziwn93jPfBNsG
	mh73pBqCGptT76cMicnVhtjtxLAsIuw2qa1ePv4qwSf8mAQogKDP/VlJoLdQp9W9xKKlLauzXTF
	LyAnr8eKoC2p4dj0mOw4+Y157LEoKhKMXsm9SahdKbhCxaKvyxy8PErtIx9rzOoN9H8RPMrJTSg
	0be5GyyDnwDqsBAKLIP9wkWD3e6dBjlzO4JvXjCrzfXYgW+skmE90ktKCzVZBVkPYBKY3vgALsU
	xKBCT6Sg4GRNkTR73XBZ+suoNiKX3DSG2rBuziOVPS3Qqj+wgXToG9I+0sSIzwxEly0qDKOSa8I
	B9C9Hh0mpYMfCBFGP26VvHMFh+KMV5AwXAuQqgXvOrzQJnwkTXJfsEsAn5FAJEcBVcZ6YH2lNLq
	Yst84E6irwa+wMdSrApzyqWf2jYgqSUKGy2vQOdjryMPNv0dM3nCzqw6Pbv/N4wZt7XrlKd3NiT
	DO+rTqcLUu+C1Xh38VJZSqvScj5HJggnZRKMawzvWDFWkslx3zbn5hkS9SJiqJ0ssGmqyfi+ja0
	EtYJU1hPDXSjxv5C93row=
X-Received: by 2002:a17:90b:5347:b0:3ac:b6eb:e0dd with SMTP id 98e67ed59e1d1-3b182f9bcdbmr3054712a91.50.1794415559095;
        Wed, 11 Nov 2026 08:45:59 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.240])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b181b9419bsm2340811a91.0.2026.11.11.08.45.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 08:45:58 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next v3 00/29] bpf: Find linked registers by scalar evolution, remove scalar ids
Date: Wed, 11 Nov 2026 16:45:23 +0000
Message-ID: <20261111164557.2659679-1-alexei.starovoitov@gmail.com>
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
i at the start of the next one. Patch 16 has such a loop.

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
registers and none on the constants that are added. Registers that agree in
their low 32, 16 or 8 bits only are linked too, which covers extensions and
partial spills. The types of the registers are read in the state at the
jump. Nothing is added to struct bpf_reg_state, and delta goes.

One question is left to the state. A subprog or a callback loads a field of
a struct on the stack of its caller, tests it and loads it again. For
scev.c that is memory behind a pointer. It is promoted to a SCEV register
like a stack slot (patch 18): a store defines it, a load gives it its value
number, a join point has a phi, a call is a may-def. So it is a linked
register like any other. Which stack slot it is depends on the caller: the
main pass reads the pointer at the jump, in its state, refines the slot and
keeps nothing of the answer. There is still nothing in a state that
regsafe() or a join would have to compare.

Patch 1, by Vineet Gupta, stands alone.
  1  'w0 = (s8)w0' keeps a 32-bit range that fits in s8 already: the sign
     extension is a no-op.

Patches 2 - 7 change kernel/bpf/scev.c only. They are prerequisites of
patch 12: they get the expressions ready for all code. The main pass does
not use them yet. No verdict changes in the 32913 progs of the second table
below. Patch 5 gives more loops an iteration count, which can change
a verdict.
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
     its root however many insns computed it. Patches 12 and 16 compare
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
looks at the types of the arguments of helpers and kfuncs. Two masks lacked
slots that are written.
  8  bpf_sys_bpf() stores log_true_size into the attr of its caller, but
     arg2_type in bpf_sys_bpf_proto is ARG_PTR_TO_MEM | MEM_RDONLY. Mark it
     MEM_WRITE.
  9  A fix of liveness.c. What is loaded through a pointer to the stack of
     frame 1 or of frame 2 can point to the stack of frame 0.
     arg_track_deref() lost the older frames, so the mask of the call in
     frame 0 did not have the slots that are written through it.

Patches 10 - 11 fix what is wrong in the main pass today. The patches
after them refine more registers and stack slots, so more progs would run
into both.
 10  'r0 <<= 3; r0 += 5; if r0 s< -2 goto ..; if r0 s> 1 goto ..'
     The range [-2, 1] and var_off don't overlap. The verifier goes on with
     an empty register, up to "verifier bug: REG INVARIANTS VIOLATION".
     Detect at the jump that the branch is dead. The live branch gets the
     operands as the jump refines them.
 11  On big endian the first half-slot of a 64-bit spill has the upper 32
     bits of the value. __clean_func_state() and stacksafe() treated it as
     a 32-bit spill, which has the low 32 bits.

Patches 12 - 19 use the expressions.
 12  A new ability. find_linked_regs() computes the linked registers of
     each conditional jump: expressions with a constant difference, modulo
     2^64, 2^32, 2^16 or 2^8. check_cond_jmp_op() refines them:
     refine_linked_regs(). sync_linked_regs() still runs.
 13  A prerequisite of the removal of scalar ids. Phis are value numbered
     by join point and operands, up to a constant offset (GVN): a copy that
     is made on each of two paths is linked after the join point.
     recvfrom_x of Falco depends on such a link.
 14  Tests for 12 and 13. The tests of scalar ids stay and cover the
     mechanism. The new ones are for what only a static analysis can get
     wrong: an arena add that is converted to ALU32, a store through a
     dynptr slice, an edge that the verifier adds, a link at a loop header,
     a pointer that is not a scalar, big endian half-slots, an empty
     intersection, phis.
 15  More tests, by Vineet Gupta: sign extensions, for 1 and 12.
 16  A new ability. A linked register can be a pointer: base + the tested
     register + delta. After the jump the main pass recomputes it, as
     'p = buf; p += i' would, with the i that the jump refined. The prog at
     the top loads. A live register or stack slot has to hold buf at the
     jump: 'buf += i' in place is not found.
 17  Tests for 16.
 18  A prerequisite of the removal of scalar ids. Register promotion:
     memory behind a pointer is a SCEV register, like a stack slot. A jump
     that tests what was loaded from it or stored to it refines the stack
     slot of the caller that the pointer points to.
 19  Tests for 18.

Patches 20 - 27 remove scalar ids: their users (20 - 23), the ids (24),
dead code (25 - 27).
 20  scev.c left it to the main pass to check, by scalar ids, that an
     induction variable and its copy hold the same value at loop entry. It
     compares their expressions there.
 21  scev.c does not analyze irreducible loops, so the jumps in them have
     no linked registers. Compute expressions in their bodies too, with the
     same worklist and a phi for every live register at a secondary entry.
     Still no recurrences and no iteration count for such a loop.
 22  Remove sync_linked_regs(). Jumps refine by scalar evolution only.
 23  flow_join_makes_up() recognized copies of a scalar by their id. It
     compares their ranges. A heuristic on which states are joined:
     soundness does not depend on it.
 24  Stop assigning ids to scalars. States that differed in scalar ids only
     are one state.
 25  Dead code: scalar ids in regsafe().
 26  Dead code: scalar ids in the join of states.
 27  Dead code: scalar ids in the log and in bpf_verifier.h.

Patches 28 - 29 are about loops of GCC. scev.c computes the iteration
count of a loop (header_count: how often the header is executed).
header_count = backedge-taken count + 1. A loop without it is walked: the
verifier unrolls the loop, one state per iteration; a counted loop is
summarized, one state for all iterations. A long loop that is walked ends
with "more than 1024 states that cannot be joined". Such loops loaded when
the verifier explored each path.
 28  A new ability. GCC keeps 'int i' as the sign extension of a 32-bit
     add: 'w1 += 1; r3 = (s32)r1'. That is a new recurrence,
     (sext32 (linear r3 1)). A wrap is handled.
 29  Tests for 28.
Long loops of GCC that still have no iteration count are rejected as
before, among them dump_task_sleepable() of bpf_iter_tasks.c, where one of
two backedges has no linear latch.

Precision that is lost is listed in patches 20, 22 and 28. Most of it:
a link holds on every path to its jump. A scalar id held on the paths that
the state took: 'if (n < 0 || n > 16) return 0; return n;' on the result of
a helper that returns at most 16 does not bound what it returns any more,
one of its paths is dead in the main pass only. A link that is made in
a loop does not leave the loop. And but for the memory that a jump tests
(patch 18) linked registers belong to the frame of the jump. Scalar ids
also linked the registers of the callers: a subprog that tests its argument
refined the register that the caller keeps. No program of the two tables
below depends on one of these but for one selftest. Gated phis and links at
loop exits, which bring most of it back, are left to a follow-up.

Patches 12 - 27 do what patches 3 - 12 of Vineet Gupta's "bpf: track scalar
equality across the low 32 bits" v3 [1] do, without a link in the state.
Patch 1 and the tests of patch 15 are his.

The selftests as GCC builds them gain most. GCC keeps the int that a call
returned as 'r5 = (s32)r0', tests w0 and returns r5, and no scalar id
links r5 to r0. "should have been in [0, 1]" is in the log of
test_progs-bpf_gcc 19 times before the series and never after it,
83 tests and 303 subtests fail in place of 87 and 320. Of the 220 entries
of BPF CI's deny list for that flavour 64 pass, 58 did.

kernel/ and include/: 2062 lines added, 1101 removed.

veristat over the BPF programs of Tetragon, Tracee, Falco, the Datadog
agent and more than 70 other public projects, HEAD and releases, built with
clang 14 - 20 and 24 for several -mcpu, against the tree before the series.
Nothing that loads stops loading, 629 more load.

                     progs               load     insns   states
  Tetragon           81856    78221 ->   78221   +1.71 %  +1.51 %
  Tracee             35204    32212 ->   32465   -9.06 %  -8.65 %
  Falco             104434   103665 ->  103691   -5.26 %  -6.68 %
  Datadog agent     806923   779575 ->  779907   -0.01 %  -0.00 %
  others             77162    64426 ->   64444   -5.56 %  -7.85 %
  all              1105579  1058099 -> 1058728   -0.32 %  -0.10 %

veristat over 32913 progs, against the tree before the series. 33 more
load: 20 of the selftests as GCC builds them, among them profiler1-3,
test_sk_lookup and setget_sockopt, and four asm tests in their flavours.
One asm test stops loading in its four flavours, "regalloc in callee".
Patch 22 changes it.

                     progs           load     insns   states
  selftests, clang   18810  11750 -> 11757   -0.21 %  -0.43 %
  selftests, GCC      6011   3651 ->  3673   -3.74 %  -4.28 %
  Cilium              5193   5189 ->  5189   -0.80 %  -1.76 %
  sched_ext           1272   1163 ->  1163   +0.05 %  +0.02 %
  katran, bpfjailer    538    511 ->   511   -0.48 %  -0.66 %
  Rust                1089   1081 ->  1081   -5.33 %  -6.47 %
  all                32913  23345 -> 23374   -2.69 %  -4.35 %

To load them the kernel spends 1.9 % more instructions on the C programs
and 4.1 % fewer on those in Rust (perf stat): scev.c analyzes all code
(patches 7 and 12), the main pass verifies fewer insns and states
(patch 24). mem_peak of veristat goes down by 0.8 % and 7.4 %. Load time
follows the instructions: 2 to 4 % more for the C programs, 5 to 7 % less
for those in Rust. To load Tetragon, Tracee and Falco it spends 0.5 %,
3.5 % and 2.1 % more instructions, load time goes up by 0 to 3 %, mem_peak
goes down by 3.4 %, 0.2 % and 0.1 %.

v2 -> v3:
- The live branch is refined if the other one is dead (patches 10, 12, 14).
- No recomputed pointer if 'p += i' refuses the offset (patches 16, 17).
- is_iv_at_header() asks the state at loop entry for the types (patch 20).
- What a dead stack slot is after bpf_probe_read_kernel() (log of patch 4).
- The comment of set_expr_base() has the base of a phi (patch 13).
v2: https://lore.kernel.org/bpf/20261111051341.2800252-1-alexei.starovoitov@gmail.com/

v1 -> v2:
v1 rejected programs that load today. Most of them at the removal of
scalar ids: links that only a state knows. The two that real programs were
found to depend on are back, without ids:
- A bpf_loop() callback or a static subprog loads a field of a struct on
  the stack of its caller, tests it and loads it again. New patch 18.
- A copy that is made on each of two paths: recvfrom_x of Falco. New
  patch 13.
The others are listed in patch 22.
- A 32-bit jump refines the 32-bit range of a register that is linked in
  64 bits, a slot that holds a 32-bit spill is linked modulo 2^32
  (patch 12).
- 'for (i = n; i > 0; i--) a[i - 1]' (patch 20).
- v1's patch 9, the check of writes against bpf_may_write_mask(), is
  dropped. It said "verifier bug" on valid programs with four frames, and
  it was right: new patch 9 fixes arg_track_deref() in liveness.c.
- Irreducible loops are analyzed by the worklist of all other loops, not
  basic block by basic block (patch 21).
From the review of v1:
- The operands of a phi have no defs (patch 6).
- Fixes tags, read-only memory (patch 8).
- A slice buffer at a variable stack offset, a slice of 0 bytes, var_off
  that don't overlap, a fill from a slot that a slice may alias (patch 12).
- No recomputed pointer if the sum is empty (patch 16).
v1: https://lore.kernel.org/bpf/20261109064715.2382452-1-alexei.starovoitov@gmail.com/

[1] https://lore.kernel.org/bpf/20261020161907.2115379-1-vineet.gupta@linux.dev/

Signed-off-by: Alexei Starovoitov <ast@kernel.org>

Alexei Starovoitov (27):
  bpf: Model 32-bit shifts and divisions exactly in scalar evolution
  bpf: Construct scalar evolution expressions without allocations
  bpf: Don't join dead registers in scalar evolution
  bpf: Simplify scalar evolution expressions at construction
  bpf: Give SSA names to the values that scalar evolution does not track
  bpf: Compute scalar evolution expressions for whole subprogs
  bpf: Mark the attr argument of bpf_sys_bpf() as MEM_WRITE
  bpf: Include older frames in a fill through an imprecise stack pointer
  bpf: Detect a dead branch when a range and var_off don't overlap
  bpf: Don't treat half of a 64-bit spill as a 32-bit spill on big
    endian
  bpf: Refine registers linked by scalar evolution at conditional jumps
  bpf: Value number the phis of scalar evolution
  selftests/bpf: Test registers linked by scalar evolution
  bpf: Recompute a pointer after the jump that bounds its index
  selftests/bpf: Test a pointer computed before its index is bounded
  bpf: Promote memory behind a pointer to SCEV registers
  selftests/bpf: Test the memory of a caller that a jump tests
  bpf: Find a copy of an induction variable without scalar ids
  bpf: Compute scalar evolution expressions in irreducible loops
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

 include/linux/bpf_verifier.h                  |   55 +-
 kernel/bpf/flow.c                             |   15 +-
 kernel/bpf/join.c                             |   54 +-
 kernel/bpf/liveness.c                         |   17 +-
 kernel/bpf/log.c                              |   10 +-
 kernel/bpf/scev.c                             | 2212 +++++++++++++----
 kernel/bpf/states.c                           |  127 +-
 kernel/bpf/syscall.c                          |    2 +-
 kernel/bpf/verifier.c                         |  671 +++--
 .../selftests/bpf/prog_tests/reg_bounds.c     |    5 +-
 .../selftests/bpf/progs/verifier_arena.c      |   70 +
 .../bpf/progs/verifier_array_access.c         |    2 +-
 .../selftests/bpf/progs/verifier_bounds.c     |   62 +-
 .../bpf/progs/verifier_bounds_step.c          |    6 +-
 .../bpf/progs/verifier_direct_packet_access.c |    2 +-
 .../bpf/progs/verifier_linked_scalars.c       |    7 +-
 .../selftests/bpf/progs/verifier_live_stack.c |   60 +
 .../selftests/bpf/progs/verifier_loop_latch.c |   69 +-
 .../selftests/bpf/progs/verifier_movsx.c      |  186 ++
 .../selftests/bpf/progs/verifier_reg_equal.c  |   11 +-
 .../selftests/bpf/progs/verifier_regalloc.c   |    2 +-
 .../selftests/bpf/progs/verifier_scalar_ids.c |   70 +-
 .../selftests/bpf/progs/verifier_scev.c       |  509 +++-
 .../selftests/bpf/progs/verifier_spill_fill.c |   31 +
 24 files changed, 2998 insertions(+), 1257 deletions(-)

-- 
2.55.0

