Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794022682;
	b=CX+nyD59tCv/m29exsJr19B3a6kZjqYJOMS6sZDe4rDXZ9HWzHH6gBYAF2iFbxUyjRlX
	 1IHOzB4WBemrgcCw99WMq2TYcqgVupOnbv0uIFZc0ZQ6ujhPXj2BY0t1S3g5P8zw4rNmD
	 +8h7sDO2gT6dEa71xp+PbJThF7cZ5YRlU+GrGJeLTT37Qnn2CCgRzJ6YshrXyHYbh9kxd
	 vYgz+OpEVxT8f8C0ehZFds6tYWP8e0y0OVYoewgNesVZKepb+Os/gvlffgEhe+e/tulVA
	 rCPZGY2FOOPVSebSV8TIYjquMh5sw1ktgdJpCGbDZI/eDdxcf4fLPjuAz7Q5JhSlTxg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794022682;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=HDq2WOrtRqqNSLOGpWya2iwcgnSkJwea9BS7e+xNQaM=;
	b=f2H2ZEwXCpLgxa53awMuDbaRpmjUeqqm/LEGan65y8Dzo7jyOhyM5ZtRWJHd8NsrwUzx
	 mjUZGGpn2bCFBbNAsVg/AvruAFMFCrcFxbECsLYk1l1/OYZbghl0OeWS4nJtppUQ6Mte/
	 7iGwylTePOBm/TDqM06eH0/98Q+octuJTYKKbvmuKUd+MM9d+73e8NjQbS028CdqaFuOz
	 eRcDOjffdk7TtcYjnqIIfTtNHHmcBl7n4bzvOxpLZdEEzl1641zNKgIFVExOitwE/VDlI
	 UZISfqd4OGBQrFe1N8JgyV1HjZY+N9glKAON+H9rMjFROCi3rUkg0Ma0h8uQ6eyX8Sg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ylPgT92h;
	arc=none smtp.remote-ip=209.85.216.53
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4A65606A332
	for <bpf@vger.kernel.org>; Sat,  7 Nov 2026 03:38:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B4A65606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ylPgT92h
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3ae691283ecso133178a91.0
        for <bpf@vger.kernel.org>; Fri, 06 Nov 2026 19:38:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794022681; x=1794627481; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=HDq2WOrtRqqNSLOGpWya2iwcgnSkJwea9BS7e+xNQaM=;
        b=ylPgT92hNkEasz+fkDKhbb9Xo0lsZu6Vcjrw3CfI/BIYhOQjW+W2ivSmcOU/heFM1i
         wlkZSQ6zF4A45G4uhHSU2lYS1CxulcuDF6zLbJgUfE/0IkL9vLrAzEEPDxym0sPQwcpU
         q0grBUqBJjcQ/Pif9xNSfJWoj6VlwREW+SizM02YFCHHakqfP0KZwC6885UaBASh0YYC
         I78dMN01p72L+Kbxu9CRtY0i9u5+ahYUUiHStrKHk42zzETn5xiDjP1esVgIBIihsrNu
         xZbVCiy+FkfrLhlaJaoN3GmtcDRPhc2zuiMGXYC+nKUClEE5cvaC5pfSYncnFVIvzNOz
         5sOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794022681; x=1794627481;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HDq2WOrtRqqNSLOGpWya2iwcgnSkJwea9BS7e+xNQaM=;
        b=LTMT8H/oG6/IZozd+LwW4C6E/dZlWLJujaAljQzoMoFY5HYq4oVdMJpLRUYXsTn2lt
         3DhM1aeWbaSqdpUsjyrcLCpkMeb6b181Xe/VXGVDyFGCHA8U/1zL5tVu6b/Yi+NIPzCC
         8/H56e+9Gffh04JcJ2tui+E2MhOWuyhD+bY2QoCkBE3oy3MJVTo4zcKMbm3ffwJXVL3d
         GvCCR3at1G8Gns8X8GtPgZOHFTRSoggZZkDho4VDsgEjunqmxQGq8zegmyLyjv/oouJP
         Itt5tcQyT0BwQxLlQMY0zE6k4TBsCt1ZNyzILVT/MUco0wE4a+MjrBQqTT8oMAPbdcd6
         eiYQ==
X-Gm-Message-State: APuU4Z9Vrk53+5gubhCWFvvA56RjBwjnVf2K1QRhSoYdjC2xo0gMrvZy
	NXEb+VYB0CFTt98Us8otgNopo5DoGKK6ieYaO3P6cyRuJZG6zGUdYHd9Xop6rg==
X-Gm-Gg: AYBFou0JS+MBTpM0y0vt+0iyCH3hygtg7/yBapoizWbYU41RhneiBa4QhotjsQTPd5v
	6KIbWYhocgvYfKtBGXm00JLjCdo71BAVtBJ5mm+GQh5dHbmgZcLVojv9ltgMdVipONoQPT4k+EX
	H+Xt3dJdTaJjqnBUUJrLq0algO3h8SoJw+WQ+vT60nZDLBxShT2kZ7/6CKysC7jYrDKdZvOxWR0
	vApRNmmNgHy9AmZG5IA1S/DyTUu4vRPMJ0Mo8Auo0WgAMJCEhTritHpjkx59KJF6tFiRfz0HWCK
	ASa9d3egU5I1kuWWVPWiKv5u0/UbNlJKBSdLBVH54tH7MTjiny79kBeDditGjneQFulD09XL6eP
	6fQqGOlCsPszmDvJNU8mG0lGkBkRcGQgsBK5ul2Jxj02w+ybao7Lm815vODQrYwHgl/6puiZ/Y/
	et6e5RFgU3JaHeeXRZCSl9+uhmSiIiLLN17QuDUvIiqBCjBShMVXUaJw+HF6EeDbMSquCZvde58
	mMI6FI2pWVHCMIIsbWC4qd1DpcJ9g6BJKV4V0kw4auiHomhdbuVVQPlOCJGmcNPBpEOnIwjJ9zK
	HddGSHYEZ2SEstyQvarL8GAYxeOHDpcNn+BQBtnRCUz8grJwq9pkZ+QYHmTo26QUvi9QOt797gu
	RjEhVHKJ9dVeSylexE2oUpsS5AKEj3qt1hhVJLe8P6ZkU4nkzmI1ekn/7NZPJU0bESOyRA1RrWg
	==
X-Received: by 2002:a17:90b:3cc6:b0:3a8:786a:cfed with SMTP id 98e67ed59e1d1-3b10659feaemr712416a91.37.1794022680410;
        Fri, 06 Nov 2026 19:38:00 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.255])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b10580ca47sm1426425a91.8.2026.11.06.19.37.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 19:38:00 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next v4 00/46] bpf: A verifier that joins states
Date: Sat,  7 Nov 2026 03:37:08 +0000
Message-ID: <20261107033758.1547725-1-alexei.starovoitov@gmail.com>
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
  rust-bpf  scx_beerland/beerland_init_task        1000001 *        16430
  rust-bpf  scx_qmap/qmap_init_cids                 131088 *          196
  scx       scx_eevdf/eevdf_dispatch                350041          15322
  Cilium    bpf_host/cil_to_netdev, Oct 2026         64658           7538
  * "BPF program is too large", "The sequence of 8193 jumps is too complex"

Authors cut their progs until they fit. Nobody can cut core, alloc and the
crates of Rust: of the 653 progs of https://github.com/4ast/rust-bpf 187
load today, 170 hit one of these limits, 164 get "infinite loop detected"
and 122 "recursive call". Now 648 load, and the corpora of C progs below
lose none. For rust-bpf both kernels have 4 kfuncs on top, see Numbers.

Loops in BPF progs are written for the verifier, not for the reader:

  bpf_qdisc_fifo.c       bpf_for(i, 0, sch->q.qlen) {
  arena_htab.c           for (i = zero; i < 100000 && can_loop; i++) {
  rbtree_search_kptr.c   while (rb_n && can_loop) {
  tailcall_bpf2bpf2.c    barrier_var(ret); return ret;

Now plain C loads: 'for (i = 0; i < 100000; i++)', 'while (rb_n)'. The last
patch has 34 progs of the selftests without these macros. bpf-next rejects
all of them, five in some flavours of test_progs only.

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
 - A loop is counted by a jump in the middle of its body, by a jump that
   sets a flag, by a copy of the counter.
 - may_goto is also added to 5 progs of the table below that load today:
   loop1, loop2, loop5, tcp_autolowat_enqueue_rcvq (GCC), chaos_enqueue
   (as of v2).
 - Recursion is allowed on x86-64 and arm64. Patch 22 lists the exceptions.
 - All added may_goto of an invocation share its time slice of 250 ms. Then
   the prog returns 0. A subprog that cannot unwind, or a frame that holds
   a lock or a reference, leaves the loop. If the code behind the loop
   reads what only the loop sets, the subprog returns 0. The stderr stream
   has the cause.
 - A subprog that returns void can have a tail call or LD_ABS. LLVM 23
   makes 'void' of an 'int' that no caller reads.
 - With CAP_PERFMON a part of a pointer can be spilled, and 32-bit add to
   a pointer and ops on two pointers make a number. With it "invalid size
   of register spill" and "32-bit pointer arithmetic prohibited" are gone.
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
The tables are those of v2. A: bpf-next 8424858a5de0. B: the series, the
same objects. The selftests that the series adds or changes are not
counted. None of them is lost. v4 against v3 on these corpora and rust-bpf:
no prog is lost, insns +0.8%, states +1.0%, mem -0.9%.

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
crates                   428        135        423      8.3M  9.4 s
The insns are those of v4, like the four rows at the top of this letter.
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
  29-31  loops that are too long for a walk: the first iteration, what
         a call returns, where the jumps of the loop stop a number
  32-34  more loops with a count: a jump in the middle of the body,
         a copy of the counter
  35-37  rules of today's verifier that plain C runs into: subprogs that
         return void, parts of pointers, 32-bit add to a pointer
  38-46  selftests: 38-39 adjust tests, 40-46 add tests
Each patch builds. Patches 1-18 add the code that patch 19 switches to.
Some selftests fail from patch 19 to 38.

Follow-ups
==========
 - Documentation/bpf/verifier.rst: the algorithm, with examples.
 - Liveness: no spilled pointer is kept for reads that see only its bytes.
 - No second pass over the prog when a loop gets may_goto late: half of the
   insns for rust-bpf.
 - bpf_prog_info tells that an invocation of the prog was cut short.

v3 -> v4
========
 - What comes around a loop, or back from the callback of bpf_loop(), is
   widened only with the state that it comes from. v3 took all states at
   the head: after 'ret = 0; if (..) { denied++; ret = -EPERM; }' in front
   of bpf_for() it widened ret, and rejected 'return ret' of an LSM prog
   (Eduard). The rule of flow_merge() on constant offsets of pointers in
   a loop is gone (patches 14, 15, 17, 19).
 - A jump in the middle of the body counts a loop, also when four other
   exits are nearer to the back edge. Ranges are one iteration shorter
   behind it. v3 rejected an index that is carried through bpf_for() and
   that only the count of such a jump bounds (Eduard, patches 32-33).
 - 'while (buf[i++] && i < N)' is counted: its exit tests a copy of the
   counter (Eduard, patch 34).
 - A counted loop joins and widens what has no closed form. v3 forgot it if
   the loop was too long for a walk: 'if (n < 8) v[n++] = 0;' in two loops
   of 100 iterations was rejected with 'for' and loaded with bpf_for()
   (patch 20).
 - The exits of a loop by way of a flag are found in one pass against the
   edges. v3 searched from each edge, 4096 insns per back edge: with 30 ifs
   in front of 'while (more)' the loop lost its count (patch 18).
 - may_goto at the head of a loop leaves the subprog if the code behind the
   loop reads what only the loop sets: glob_match() of arena_strsearch
   needs no cond_break (patch 19).
 - Widening: a sum that no jump of the loop depends on becomes an unknown
   scalar in two passes, not in five. A bound that leaves a fixed stop and
   32 bits is not tried at S64_MAX (patches 3, 4).
 - Patches 35-37 are new, with their tests in 45: what plain C runs into in
   today's verifier.
 - Patch 46 is new: 34 progs of the selftests in plain C that bpf-next
   rejects, five in some flavours of test_progs only.
 - Patches 29-35 of v3 are folded into the patches that add the code that
   they change: 3, 9, 14, 15, 19 and 21. 36-38 of v3 are 29-31.
 - Rebased to bpf-next 3e1821848412.

v2 -> v3
========
 - A scalar argument of a static subprog loses delta together with its id.
   v2 kept delta, took wrong bounds in the callee and let an access out of
   bounds load (sashiko).
 - A loop with calls is walked for two iterations. v2 widened it at once
   and rejected strobemeta.h with two maps or two strings.
 - The frame of a recursive subprog grows before the stack of a chain of
   calls is checked, not after (bpf-ci, sashiko).
 - A loop that ends when a flag is false is counted by the jump that clears
   the flag, also when code stands between that jump and the test. States
   with 0 and 1 in a flag are not joined in front of its test.
 - Patches 29-38 of v3 are new. Each loads code that bpf-next loads and v2
   rejects: casts, the context in a struct, r0 at a dead exit (bpf-ci,
   sashiko), a register that only a loop sets (bpf-ci), loops that count
   down in bytes, loop-carried values in long loops, and numbers that only
   a jump of the loop stops (Ihor).

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

Alexei Starovoitov (46):
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
  bpf: Keep the first iteration of a counted loop apart
  bpf: What a call returns in each iteration is like what the loop loads
  bpf: Find where the jumps of a loop stop a number
  bpf: A loop is one iteration shorter behind the jump that counts it
  bpf: Give the places of a back edge to the jumps that count
  bpf: Count a loop whose exit tests a copy of the counter
  bpf: Allow tail calls and LD_ABS in subprogs that return void
  bpf: A part of a pointer that is spilled is a number
  bpf: 32-bit add to a pointer and pointer op pointer make a number
  selftests/bpf: Adjust tests to log lines that are gone
  selftests/bpf: Adjust tests to new verdicts, messages and order
  selftests/bpf: Test states that are not joined
  selftests/bpf: Test static subprogs that are verified on their own
  selftests/bpf: Test loops that are counted, walked or widened
  selftests/bpf: Test progs that run out of budget
  selftests/bpf: Test callx of one of a set of functions
  selftests/bpf: Test pointers that become numbers and subprogs that
    return void
  selftests/bpf: Test progs without bpf_for(), zero, can_loop and such

 Documentation/bpf/bpf_design_QA.rst           |    7 +-
 Documentation/bpf/kfuncs.rst                  |    2 +-
 Documentation/bpf/linux-notes.rst             |    4 +-
 include/linux/bpf.h                           |    6 +
 include/linux/bpf_verifier.h                  |  602 +--
 include/linux/filter.h                        |   16 +
 kernel/bpf/Makefile                           |    2 +-
 kernel/bpf/backtrack.c                        | 1052 ------
 kernel/bpf/cfg.c                              |  297 +-
 kernel/bpf/check_btf.c                        |   10 +-
 kernel/bpf/const_fold.c                       |  270 +-
 kernel/bpf/core.c                             |   19 +
 kernel/bpf/diagnostics.c                      |   13 -
 kernel/bpf/diagnostics.h                      |    1 -
 kernel/bpf/fixups.c                           |  333 ++
 kernel/bpf/flow.c                             | 3319 +++++++++++++++++
 kernel/bpf/join.c                             |  664 ++++
 kernel/bpf/liveness.c                         |  114 +-
 kernel/bpf/log.c                              |   14 +-
 kernel/bpf/loops.c                            |  176 +-
 kernel/bpf/scev.c                             |  460 ++-
 kernel/bpf/states.c                           | 1181 +-----
 kernel/bpf/verifier.c                         | 3168 ++++++++++------
 .../bpf/prog_tests/bpf_verif_scale.c          |    4 +-
 .../bpf/prog_tests/cgroup_skb_egress_ret.c    |   23 +
 .../selftests/bpf/prog_tests/log_buf.c        |    4 +-
 .../selftests/bpf/prog_tests/log_fixup.c      |    6 +-
 .../selftests/bpf/prog_tests/plain_c.c        |  160 +
 .../selftests/bpf/prog_tests/reg_bounds.c     |    5 +-
 .../prog_tests/test_struct_ops_refcounted.c   |    2 +
 .../selftests/bpf/prog_tests/verifier.c       |   19 +
 .../selftests/bpf/progs/aggregate_ret_func.c  |   15 -
 .../selftests/bpf/progs/aggregate_ret_kfunc.c |    7 -
 ...f_qdisc_fail__invalid_dynptr_cross_frame.c |    4 +-
 .../bpf/progs/cgroup_skb_egress_ret.c         |   12 +
 .../bpf/progs/compute_live_registers.c        |    8 +-
 .../selftests/bpf/progs/cpumask_failure.c     |    2 +-
 .../testing/selftests/bpf/progs/dynptr_fail.c |    9 +-
 .../selftests/bpf/progs/exceptions_assert.c   |   24 +-
 tools/testing/selftests/bpf/progs/iters.c     |  114 +-
 .../selftests/bpf/progs/iters_state_safety.c  |    8 +-
 .../selftests/bpf/progs/iters_testmod_seq.c   |   12 +-
 .../bpf/progs/mem_rdonly_untrusted.c          |   16 +-
 .../selftests/bpf/progs/plain_c_arena_htab.c  |  222 ++
 .../bpf/progs/plain_c_arena_htab_asm.c        |    5 +
 .../selftests/bpf/progs/plain_c_arena_list.c  |  181 +
 .../selftests/bpf/progs/plain_c_arena_race.c  |   45 +
 .../bpf/progs/plain_c_arena_strsearch.c       |  263 ++
 .../bpf/progs/plain_c_bpf_ma_ttrace.c         |   53 +
 .../bpf/progs/plain_c_bpf_nop_bench.c         |   75 +
 .../bpf/progs/plain_c_bpf_qdisc_fifo.c        |  132 +
 .../bpf/progs/plain_c_bpf_qdisc_fq.c          |  728 ++++
 .../bpf/progs/plain_c_cpumask_success.c       |   83 +
 .../bpf/progs/plain_c_dynptr_success.c        |  175 +
 .../selftests/bpf/progs/plain_c_iters.c       |  147 +
 .../bpf/progs/plain_c_mem_rdonly_untrusted.c  |   24 +
 .../bpf/progs/plain_c_mptcp_subflow.c         |  116 +
 .../bpf/progs/plain_c_rbtree_search.c         |  136 +
 .../bpf/progs/plain_c_rbtree_search_kptr.c    |  264 ++
 .../bpf/progs/plain_c_strobemeta_bpf_loop.c   |  583 +++
 .../bpf/progs/plain_c_tailcall_bpf2bpf2.c     |   40 +
 .../plain_c_tailcall_bpf2bpf_hierarchy1.c     |   44 +
 .../plain_c_tailcall_bpf2bpf_hierarchy2.c     |   81 +
 .../plain_c_tailcall_bpf2bpf_hierarchy3.c     |   74 +
 .../bpf/progs/plain_c_tailcall_callback.c     |   80 +
 .../bpf/progs/plain_c_test_wakeup_source.c    |   93 +
 .../plain_c_tracing_stack_arg_tailcall_tgt.c  |   55 +
 .../bpf/progs/plain_c_verifier_arena_large.c  |  122 +
 .../plain_c_verifier_iterating_callbacks.c    |   25 +
 .../bpf/progs/plain_c_verifier_loop_as_is.c   |   40 +
 .../bpf/progs/plain_c_xdp_lb_bench.c          |  723 ++++
 .../selftests/bpf/progs/stack_arg_precision.c |   48 +-
 .../bpf/progs/struct_ops_refcounted_subprog.c |   30 +
 .../selftests/bpf/progs/test_global_func15.c  |    5 -
 .../selftests/bpf/progs/test_global_func3.c   |  125 +
 .../selftests/bpf/progs/timer_failure.c       |    9 +-
 .../selftests/bpf/progs/verifier_align.c      |   10 +-
 .../selftests/bpf/progs/verifier_and.c        |    4 +-
 .../bpf/progs/verifier_arena_stack.c          |   82 +
 .../bpf/progs/verifier_array_access.c         |   18 +-
 .../selftests/bpf/progs/verifier_bounds.c     |  114 +-
 .../bpf/progs/verifier_bounds_deduction.c     |    2 +-
 .../bpf/progs/verifier_bounds_step.c          |   73 +-
 .../selftests/bpf/progs/verifier_budget.c     | 1915 ++++++++++
 .../bpf/progs/verifier_calls_in_a_row.c       |  223 ++
 .../selftests/bpf/progs/verifier_callx.c      |  128 +-
 .../selftests/bpf/progs/verifier_callx_many.c |  113 +
 .../bpf/progs/verifier_callx_rodata.c         |  167 +-
 .../selftests/bpf/progs/verifier_cfg.c        |    8 +-
 .../bpf/progs/verifier_global_subprogs.c      |   11 +-
 .../bpf/progs/verifier_helper_value_access.c  |    8 +-
 .../selftests/bpf/progs/verifier_idoms.c      |    9 +-
 .../bpf/progs/verifier_iterating_callbacks.c  |   70 +-
 .../bpf/progs/verifier_jumps_ahead.c          |  670 ++++
 .../selftests/bpf/progs/verifier_ld_ind.c     |   31 +-
 .../bpf/progs/verifier_linked_scalars.c       |    7 +-
 .../selftests/bpf/progs/verifier_live_stack.c |   37 +-
 .../bpf/progs/verifier_liveness_exp.c         |    7 +-
 .../selftests/bpf/progs/verifier_loop_as_is.c |  513 +++
 .../bpf/progs/verifier_loop_hierarchy.c       |  125 +-
 .../selftests/bpf/progs/verifier_loop_latch.c |  308 +-
 .../selftests/bpf/progs/verifier_loop_need.c  |  372 ++
 .../selftests/bpf/progs/verifier_loop_walk.c  |  306 ++
 .../selftests/bpf/progs/verifier_loops1.c     |   16 +-
 .../bpf/progs/verifier_map_ret_val.c          |    2 +-
 .../bpf/progs/verifier_mem_size_reg.c         |   52 +-
 .../selftests/bpf/progs/verifier_movsx.c      |    3 +-
 .../selftests/bpf/progs/verifier_precision.c  |  186 +-
 .../selftests/bpf/progs/verifier_ptr_off.c    |  279 ++
 .../selftests/bpf/progs/verifier_scalar_ids.c |  329 +-
 .../selftests/bpf/progs/verifier_scev.c       |  272 +-
 .../bpf/progs/verifier_search_pruning.c       |   40 +-
 .../selftests/bpf/progs/verifier_spill_fill.c |  271 +-
 .../selftests/bpf/progs/verifier_spin_lock.c  |    4 +-
 .../selftests/bpf/progs/verifier_stack_arg.c  |  181 +
 .../selftests/bpf/progs/verifier_stack_ptr.c  |   13 +-
 .../bpf/progs/verifier_subprog_callers.c      |  543 +++
 .../bpf/progs/verifier_subprog_insn_stats.c   |   16 +-
 .../bpf/progs/verifier_subprog_precision.c    |  353 +-
 .../selftests/bpf/progs/verifier_tailcall.c   |   96 +
 .../selftests/bpf/progs/verifier_uninit.c     |    2 +-
 .../selftests/bpf/progs/verifier_unpriv.c     |   27 +-
 .../bpf/progs/verifier_unpriv_perf.c          |    4 +-
 .../bpf/progs/verifier_value_illegal_alu.c    |   42 +-
 .../bpf/progs/verifier_value_or_null.c        |    2 +-
 .../bpf/progs/verifier_value_ptr_arith.c      |   65 +-
 .../selftests/bpf/progs/verifier_var_off.c    |  206 +-
 tools/testing/selftests/bpf/verifier/calls.c  |   46 +-
 .../testing/selftests/bpf/verifier/precise.c  |   69 +-
 129 files changed, 19983 insertions(+), 5477 deletions(-)
 delete mode 100644 kernel/bpf/backtrack.c
 create mode 100644 kernel/bpf/flow.c
 create mode 100644 kernel/bpf/join.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/cgroup_skb_egress_ret.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/plain_c.c
 create mode 100644 tools/testing/selftests/bpf/progs/cgroup_skb_egress_ret.c
 create mode 100644 tools/testing/selftests/bpf/progs/plain_c_arena_htab.c
 create mode 100644 tools/testing/selftests/bpf/progs/plain_c_arena_htab_asm.c
 create mode 100644 tools/testing/selftests/bpf/progs/plain_c_arena_list.c
 create mode 100644 tools/testing/selftests/bpf/progs/plain_c_arena_race.c
 create mode 100644 tools/testing/selftests/bpf/progs/plain_c_arena_strsearch.c
 create mode 100644 tools/testing/selftests/bpf/progs/plain_c_bpf_ma_ttrace.c
 create mode 100644 tools/testing/selftests/bpf/progs/plain_c_bpf_nop_bench.c
 create mode 100644 tools/testing/selftests/bpf/progs/plain_c_bpf_qdisc_fifo.c
 create mode 100644 tools/testing/selftests/bpf/progs/plain_c_bpf_qdisc_fq.c
 create mode 100644 tools/testing/selftests/bpf/progs/plain_c_cpumask_success.c
 create mode 100644 tools/testing/selftests/bpf/progs/plain_c_dynptr_success.c
 create mode 100644 tools/testing/selftests/bpf/progs/plain_c_iters.c
 create mode 100644 tools/testing/selftests/bpf/progs/plain_c_mem_rdonly_untrusted.c
 create mode 100644 tools/testing/selftests/bpf/progs/plain_c_mptcp_subflow.c
 create mode 100644 tools/testing/selftests/bpf/progs/plain_c_rbtree_search.c
 create mode 100644 tools/testing/selftests/bpf/progs/plain_c_rbtree_search_kptr.c
 create mode 100644 tools/testing/selftests/bpf/progs/plain_c_strobemeta_bpf_loop.c
 create mode 100644 tools/testing/selftests/bpf/progs/plain_c_tailcall_bpf2bpf2.c
 create mode 100644 tools/testing/selftests/bpf/progs/plain_c_tailcall_bpf2bpf_hierarchy1.c
 create mode 100644 tools/testing/selftests/bpf/progs/plain_c_tailcall_bpf2bpf_hierarchy2.c
 create mode 100644 tools/testing/selftests/bpf/progs/plain_c_tailcall_bpf2bpf_hierarchy3.c
 create mode 100644 tools/testing/selftests/bpf/progs/plain_c_tailcall_callback.c
 create mode 100644 tools/testing/selftests/bpf/progs/plain_c_test_wakeup_source.c
 create mode 100644 tools/testing/selftests/bpf/progs/plain_c_tracing_stack_arg_tailcall_tgt.c
 create mode 100644 tools/testing/selftests/bpf/progs/plain_c_verifier_arena_large.c
 create mode 100644 tools/testing/selftests/bpf/progs/plain_c_verifier_iterating_callbacks.c
 create mode 100644 tools/testing/selftests/bpf/progs/plain_c_verifier_loop_as_is.c
 create mode 100644 tools/testing/selftests/bpf/progs/plain_c_xdp_lb_bench.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_refcounted_subprog.c
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

