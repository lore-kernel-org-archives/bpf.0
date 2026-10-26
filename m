Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.187
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793053696;
	b=z+mO0jPDuGepwdChmkR4aqpfC7vFVn02XM5zigpj5Y5wCGK0BYWOUYC2gLqcP4Osr+Zd
	 c+gExqzNx8SW7Nb6c0a7qAgfiXqfsBRRCRG90szrToNraOahM8vzCkeDmXhl/TPWO0hY6
	 tcuQs7fVnbQNIhMWtgYBpYl6yCM/oOFQdhZRrfYA/X5U7gkFj8LmktHAKzNf9VN8SbJHi
	 upEHDlNXmhNKjTpLW9AmpWmmRhxiGYrJFD37jnGR8PIraiBN94SeoRfbC1/0W1w4b8tjr
	 pzyCUWAenLaK8g7JbY0t//Z2H0tBmZ0KIV/Cmk/pHSqy6NW/mjHPFc0jnznofsMlb8w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793053696;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=QmxZ/x08D4SwzN3kodEnCPtTmR0nQ9+CflHwRQZVH4g=;
	b=LnElW826EHdHKXCdLk9r41eA+yJRdfyQ+Om3angcfzmFejjFVCApLopEPC7kPu/K4VIB
	 Ydx59MtLEAlsfF7puFgACGp9Bv2rov7LXyXFnUX8gz6RDlclJUT6UJ4xiM0D1fJf378og
	 yH0pUFq4WJmGGJj+6DTKcfWFEbmdmGsX+uckS8zV2i2JQcmVNpMZ8qbW0+wqEl2u7u/Qc
	 XgOLShRU+q3xBDBc5QxoaZ5h5zbtSHrVeveZpOw+sz3uQbN/0JuTNhyBHdj6jl3mjt2vG
	 N3XRm/cnIk9VEcwTm8vQmii3f3xxTq3WMy2GMC1sWXbiHfNfYRFZO6QP0PjQEypwJJg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b="RC7w/q2R";
	arc=none smtp.remote-ip=95.215.58.187
Received: from mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48C25606A31A
	for <bpf@vger.kernel.org>; Mon, 26 Oct 2026 22:28:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 48C25606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=RC7w/q2R
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=92i0znDg6NVfaWsgnPMdacfuNUwHFX7r3O4GlX3cGkk=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793053692; v=1; x=1793658492;
 b=RC7w/q2Rqph5wawefGfJ/le+6/tNIg/ZLbM2MhAhNXWtY365722YkptZhFaL3GOZ+k6nhH1U
 ISIBLEEmVpdZQ+92Bq3reg8LTl+Nz+vqdrEXsP5ALcDTBBvPuYP5ydSuHLjvxNONyuNnnybZX93
 3TK9/kas733MqT7YmCGOcXSU=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 2c9ad6bebd5089d0;
	Mon, 26 Oct 2026 22:28:12 +0000
X-Mizu-Trace-ID: 2c9ad6bebd5089d0
X-Migadu-Flow: FLOW_OUT
Message-ID: <fbb26ce0-00a0-42ba-abc6-82c3c6201d8a@linux.dev>
Date: Mon, 26 Oct 2026 15:28:09 -0700
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf 00/81] bpf: Stack in arena and a verifier that joins
 states
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
Cc: daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com,
 memxor@gmail.com
References: <20261026025943.404450-1-alexei.starovoitov@gmail.com>
Content-Language: en-US
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <20261026025943.404450-1-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2026-10-25 7:58 p.m., Alexei Starovoitov wrote:
> From: Alexei Starovoitov <ast@kernel.org>
> 
> The goal of this series is to load Rust programs as rustc and LLVM compile
> them. These programs keep data, heap and address-taken locals in arena.
> They use trait objects, recursion, unwinding, and loops that have no known
> bound. The test programs are in https://github.com/4ast/rust-bpf
> 
> The series has three parts:
> 
>    patches  1-15   Fixes and a revert. They do not depend on the other
>                    parts.
>    patches 16-31   A stack in arena.
>    patches 32-81   A verifier that joins states.
> 
> Only patches 1-15 are for merging now, into the bpf tree. Parts 2 and 3 are
> for review. The series applies to the bpf tree.
> 
> Parts 2 and 3 can be reviewed separately. They touch each other only in
> patches 51, 53 and 80.

Alexei, everyone,

This series shouldn't land as is. It's not ready.

It breaks a bunch of production BPF programs, and may have security
issues which Opus 5.5 and GPT 6.1 refuse to investigate.

pw-bot: cr

Alexei, a couple of suggestions that I think will help to iterate
faster while keeping the changes well tested:

   * split up the series into independent parts of reasonable size: 80+
     patches and 20k+ diff is difficult to process for AI, and
     impossible for humans

   * get someone with cybersecurity-blessed LLM access involved into
     the review / development process: we definitely don't want to ship
     new bugs that common AIs miss or refuse to find, even if they are
     not "real" security bugs

   * ask your development bots to ensure that verification of prod BPF
     programs (bots can pull those tested by BPF CI from github
     artifacts, just ask) has not regressed, and that there is a path
     for updating existing programs to work both with old and new
     verifier

Pasting below Meta progs regressions, top 10 issues found and confirmed
by my "agent swarm", and a list of "forbidden" topics.

I can share the full list of issues, code and giant .md reports too,
if anyone is interested let me know.

Thanks Meta for paying for the tokens.

======== PASTE #1: Meta prod BPF programs regressions

LOAD FAILURES REPORTED BY CI

These six production programs change from success to failure. 
Independent review reproduced each on fixed objects and identified patch 
53 as first bad.

Program                              Family / object
bpfj_jailer_scan                      bpfjailer / jailer.bpf.o
jailer_cgroup_attach_task             bpfjailer / jailer.bpf.o
bpfj_fs_file_open                     bpfjailer / fs_enforce.bpf.o
syar_file_open                        sysarmor / security_file_open.bpf.o
armr_filemod_security_inode_link      metarmor / filemod.bpf.o
tcdecapinfo                           katran / tc_decap_info.o

ADDITIONAL CONFIGURATION-DEPENDENT LOAD FAILURES

Both programs below are present in the same CI results and pass with
CI's default .rodata values. Independent review confirmed
success-to-failure regressions when the relevant non-default .rodata
options are enabled:

- bpfj_base_role_assign (bpfjailer / jailer.bpf.o)
- bpfj_jailer_exec (bpfjailer / jailer.bpf.o)

VERIFICATION COST REGRESSIONS

The following eleven production programs are also present in that CI
run.  They continue to load. Cost regressions were independently
confirmed in controlled measurements; CI's comparison records verdicts
and state counts, so the timing figures below come from non-debug
review runs.

bpfjailer / net_enforce.bpf.o:
- enforce_security_socket_recvmsg                 about 2x slower
- enforce_security_socket_recvmsg_sleepable       about 2x slower
- enforce_security_socket_sendmsg                 about 1.4x slower
- enforce_security_socket_sendmsg_sleepable       about 1.5x slower
- enforce_security_socket_connect                 about 1.5x slower
- enforce_security_socket_connect_sleepable       about 1.4x slower

bpfjailer / sock_addr_redirect.bpf.o:
- bpfj_redirect_socket_connect                    about 1.3x slower

strobelight / strobelight_process_monitor.o:
- tracepoint__syscalls_exit_mmap
- tracepoint__syscalls_enter_exit
- tracepoint__syscalls_enter_exit_group
   All three increase from a few hundred processed insns to about 22.8K.
   exit_mmap and enter_exit were timed at about 12x slower verification.

bpfjailer / exec_enforce.bpf.o:
- bpfj_exec_bprm_creds_for_exec                    about 1.1x slower

======== END OF PASTE #1

======== PASTE #2: Top 10 issues

Top 10 issues: "bpf: Stack in arena and a verifier that joins states"
Patch numbers refer to the 2026-10-26, 81-patch posting.
All ten findings were upheld by independent review.

1. Patch 7 overwrites the second return register of aggregate returns.
    In kernel/bpf/fixups.c, the subprog-exit may_goto budget update
    assumes R1-R3 are dead and loads the frame count into R2. A static
    subprog returning a 9-16-byte struct uses R0:R2, so callers receive
    a value inconsistent with the verified state. Confirmed outcomes
    include wrong results, KASAN out-of-bounds writes and a fault
    through a corrupted pointer. From patch 53, automatically guarded
    plain C loops trigger this too (clang 23).

2. Part 1 leaves a reachable out-of-bounds bug fixed by patch 46.  On
    the base and after patch 15, maybe_fork_scalars() pushes an AND/OR
    fork to the same instruction;
    kernel/bpf/states.c:bpf_is_state_visited() can prune that fork
    against an unfinished state using RANGE_WITHIN inside a
    SCEV-terminating loop. Both loop-header and body checkpoints
    reproduce out-of-bounds map-value writes on the base and after
    patch 15. Patch 46 rejects them, but is outside the proposed
    merge-now subset. The added test is
    and_scalar_fork_at_long_loop_head_rejects_oob. This predates the
    series.

3. Patch 18 truncates kernel pointers on JITs requiring explicit zero
    extension.  kernel/bpf/fixups.c:bpf_lower_cast_mov() lowers rX =
    addr_space_cast(rY,0,1) to a 64-bit move while retaining zext_dst.
    bpf_opt_subreg_zext_lo32_rnd_hi32() then inserts wX = wX,
    discarding the pointer's upper half before dereference. This
    affects different-register casts on s390x/riscv64/ppc64. The
    instruction sequence appears in real s390x CI; enabling needs_zext
    in the verification harness reproduced a crash.

4. Iterator-based termination detection accepts an unguarded infinite
    loop.  kernel/bpf/flow.c:flow_is_bound() treats a dominating
    iter_next as bounding a loop without establishing that the iterator
    was created outside it.  do { bpf_for(i,0,1000) { ... } } while
    (v->x) is rejected before the switch, but accepted with zero
    may_goto guards afterwards and causes a soft lockup.  The related
    flow_iters_are_remade() heuristic also mistakes nine distinct entry
    iterator IDs for recreation: eight sequential valid split-state
    bpf_for loops exhaust verification restarts and fail to load.

5. Patches 51/53 admit recursion where the shared runtime budget is
    unavailable.  The recursion admission check in
    kernel/bpf/verifier.c requires only bpf_jit_supports_percpu_insn();
    budget setup in fixups.c additionally needs timed_may_goto and
    exception support. On x86 with CONFIG_UNWINDER_FRAME_POINTER=y, a
    loop around recursive calls, with no explicit may_goto, loads but
    soft-locks instead of terminating; runs remained active beyond 187
    seconds. riscv64 and loongarch have the same capability
    mismatch. The documented 8M-call limit is insufficient for this
    shape.

6. Newly admitted loops and recursion are unsafe for hardware offload.
    From patch 53, offloaded uncounted loops and recursive subprogs
    load, while their inserted guards/counters protect only the host
    instruction stream.  netdevsim confirmed both acceptance
    changes. In drivers/net/ethernet/netronome/nfp/bpf/verifier.c,
    nfp_bpf_get_stack_usage() assumes recursion was rejected and walks
    calls through fixed MAX_CALL_FRAMES arrays. Patch 50's
    bpf_insert_loop_guards() also shifts aux indices before offload
    finalization; NFP still indexes zext flags by the original
    instruction position. Actual NFP execution/crash consequences were
    not tested.

7. Patch 53's uncounted-loop fallback rejects previously valid bounded
    loops.  kernel/bpf/verifier.c:bpf_flow_loop_enter() stops walking
    at an undecided exit or the 4096-insn budget; calls/iterators can
    also prevent walking.  bpf_scev_forget_regs()/widening then discard
    bounds needed for accesses.  Reproducer shapes include multiple
    backedges, duplicated constant exits, flag latches, loop-carried
    induction-variable copies and bpf_for with a 32-bit spilled
    counter. Seven confirmed load regressions: bpfj_jailer_scan,
    jailer_cgroup_attach_task, bpfj_fs_file_open, syar_file_open,
    test_select_dst_max, test_select_dst_max_boundary, and
    on_perf_event in torchscriptstacks_sample.o. All load before patch
    53 and fail afterwards.

8. Joining constant offsets loses facts required by otherwise valid
    accesses.  kernel/bpf/flow.c's replacement for precision tracking
    lacks rules for non-stack pointer addends and constant array-map
    keys. tcdecapinfo loads before patch 53 but fails afterwards:
    joining two constant packet offsets breaks range propagation in
    find_good_pkt_pointers(). Independent plain-C reproducers also
    fail: selecting t->pid versus t->tgid through a trusted BTF pointer
    (clang 23), and selecting array-map key 0 or 1 before a lookup
    whose constant-key proof previously made a NULL check unnecessary.

9. The 16-join heuristic widens states even in acyclic code.
    kernel/bpf/flow.c:flow_merge() sets widen_all when s->joins exceeds
    BPF_FLOW_MAX_JOINS, bypassing NULL, initialization, constant and
    pointer offset distinctions. armr_filemod_security_inode_link is a
    confirmed patch-53 load regression. No loop is required: a static
    helper called once with v+32 and from 18 sites with v+0 fails with
    an unbounded pointer offset; the 17-site control loads. This cutoff
    is absent from verifier.rst's description of when states remain
    separate.

10. Scanning states makes verification much slower despite fewer
     processed insns.  kernel/bpf/flow.c:flow_merge()/flow_within()
     repeatedly scan resident states through bpf_state_subsumes(). On
     non-debug kernels, vip_filter takes about 4.5 times longer while
     processing 24% fewer insns. A 1029-insn synthetic with 1024
     distinct offset states, 12 merge points and 64 live stack slots
     took 40.6 seconds; the base rejected it in 0.67 seconds. Patch 53
     removes the processed-insn budget; remaining state-count limits do
     not bound the comparisons proportionally. Loads remain
     interruptible. KASAN timings obscure the regression.

======== END OF PASTE #2

======== PASTE #3: Topics blocked by LLM guardrails

And the list of issues the bots refused to look into:

     1. Run-time recursion checks (patches 51, 53): whether the stack
        charged for recursive frames bounds the real kernel and arena
        stack use, how the per-run call budget is enforced, and how both
        behave when runs nest.

     2. Join (patches 47, 66, 68): whether bpf_state_subsumes(), which
        decides that a joined state covers both inputs, checks every
        register and stack-slot property that matters, including the
        function sets of patch 68.

     3. Main pass (patches 52/53): whether verifying a static subprogram
        once per entry state, rather than per call chain, keeps all the
        facts its callers rely on, and how tail calls interact with

     5. Stack in arena (patches 16-31): memory-safety properties of r12,
        the per-cpu arena stacks, BPF_ATOMIC_LOCAL, the JIT changes and
        the new arena kfuncs, including how arena stack frames are
        released on early exits.

     6. Removals and raised limits (patches 32, 54, 56, 58, 60-67):
        whether any remaining safety check depended on the removed
        precision tracking, pruning or loop detection, or on the old
        frame, stack-argument and subprogram limits.

     7. Worst-case verification cost (patches 52/53, 60): CPU time and
        memory the verifier can be made to spend under the new state
        limits, now that the processed-insn and pending-jump limits are
        gone.

     8. Function tables and callx (patches 42, 68): whether every
        function in a tracked set is verified for each indirect call or
        helper/kfunc argument it reaches, with up to 1024 targets per
        table.

     9. Packet pointer range (patch 40): whether keeping a packet
        pointer's range after adding a non-negative scalar is correct in
        every case the patch allows.

    10. Unprivileged programs (patches 47, 52/53): whether the Spectre
        mitigations still hold when states are joined and the main pass
        is a fixpoint.

    11. Architectures other than x86-64: how the per-run budget,
        unwinding and recursion checks (patches 7, 43, 51) and the arm64
        r12 support (patch 28) behave on other JITs.

======== END OF PASTE #3

> 
> [...]
> 

