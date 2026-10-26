Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792986819;
	b=rBsDZjQtWRnkW+oynKQdTMjvsQo9tnp/6aBZ9G6bVGeQcullFUFID5N0+7aSIE4IA685
	 ciVMc3HiDJStjWbgH/TXFwg1S4/8UpCF/zTjVhjOJSafFKU6pEJNjNDLgSZtG4UA81S3t
	 18FnvsXOhgT6XcUTAvgsCSXpfgrBaEembai2Vyl9Owr6v36jvZIwQvyc8MG2QQnXU9Lqp
	 2By/bHhetWvWoVe/EKcaphic147LUsYnEnJVzoaIjl2yfj7XxRSKGgSs9FY9zDA5yS4wO
	 cqob270toFjKnS3jjxjtai/n+ePer5Fms/QXEyImlvN1AUoN8w+ZukFg4OIxgaMkAUQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792986819;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=1OdptzNlZZ5k5gGkwlxCqd6qMgT/cProQWSJTNmpg70=;
	b=UzlXnXfZnvoRZkgAqL+oxn6OEuGsowrLk5tbplEiTIWmdAk9LUU3RA02eiGLvAHOg0xE
	 NtbpjIqnlwuVpLkklpbx5QYpNDhHbeKI85fp42kvL/2WT+Ic0AUO48b7+70X9OiOSILAD
	 48XXlQY11Ew9yQRxEq1G2A+YRSz0hXlgwntd7gVSQTVNmIZzxi3SNXvAhhtgLSQ6kjtOS
	 NCHDYMbyTmNcHHHFpkKStULuXD5PbQmshnu62A1TVXEjAQfwJrSkJBxEXP1lMOokkc715
	 zQgIXLbhPlkwgdwjx+HmesVhD/B64fKfzzWX1KF23rmEH+FVo5o69mKIW1u6eBKoreQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gr9uL63H;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDD41606A31A
	for <bpf@vger.kernel.org>; Mon, 26 Oct 2026 03:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gr9uL63H
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 632081F01825;
	Mon, 26 Oct 2026 03:53:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792986818;
	bh=1OdptzNlZZ5k5gGkwlxCqd6qMgT/cProQWSJTNmpg70=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=gr9uL63HnUFyJq0/oCgzD7bLn4WkyCKInyDuQNaMk0lNffUq3j86WCYTHI8I5GO8b
	 /2qoUWWmuFk2hA6nNAIxqLb1hIS8SolRfLWQ6c2gUVi2nCJ+VSsldnt0DJgpEw+vig
	 VH6tA0JzbwaCOSjCQBNNG/UJt+Cjks0UWF8hqtcQdYwhnLrPdby/TxTDwYdjom7985
	 2YI4798RnHuho6mf+rbJUarBnGU+eXXmITKd4YY+96uPeeKYszFvqoAeM+Oyhnodkp
	 x/xx6+JrO5xn46OFPxHN2fYduo+PN+E53bEI0jMVcdC+CeqqwFHEiXHi8FIU0op2ak
	 +e55eo15smr5Q==
Content-Type: multipart/mixed; boundary="===============3956143948836320364=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <5e53bded944c197b9c22a1fc13956bf97cbec3962e7b97117174e49803b87e0f@mail.kernel.org>
In-Reply-To: <20261026025943.404450-70-alexei.starovoitov@gmail.com>
References: <20261026025943.404450-70-alexei.starovoitov@gmail.com>
Subject: Re: [PATCH bpf 69/81] bpf, docs: Rewrite verifier.rst
From: bot+bpf-ci@kernel.org
To: alexei.starovoitov@gmail.com,bpf@vger.kernel.org
Cc: daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Mon, 26 Oct 2026 03:53:38 +0000 (UTC)

--===============3956143948836320364==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf, docs: Rewrite verifier.rst

TL;DR:
- Joining verifier may reject programs older kernels accepted, contradicting
  the Q&A's compatibility guarantee
- verifier.rst may_goto and loop-unroll docs appear inaccurate for some JITs,
  configs and long loops
- Q&A also omits new limits and still says loops are unclear

> diff --git a/Documentation/bpf/bpf_design_QA.rst b/Documentation/bpf/bpf_design_QA.rst
> index 98d70b8a2533..f86b272920ae 100644
> --- a/Documentation/bpf/bpf_design_QA.rst
> +++ b/Documentation/bpf/bpf_design_QA.rst
> @@ -92,11 +92,8 @@ Q: What are the verifier limits?
>  A: The only limit known to the user space is BPF_MAXINSNS (4096).
>  It's the maximum number of instructions that the unprivileged bpf
>  program can have. The verifier has various internal limits.
> -Like the maximum number of instructions that can be explored during
> -program analysis. Currently, that limit is set to 1 million.
> -Which essentially means that the largest program can consist
> -of 1 million NOP instructions. There is a limit to the maximum number
> -of subsequent branches, a limit to the number of nested bpf-to-bpf
> +The largest program can consist of 1 million instructions.
> +There is a limit to the number of nested bpf-to-bpf
>  calls, a limit to the number of the verifier states per instruction,
>  a limit to the number of maps used by the program.
>  All these limits can be hit with a sufficiently complex program.

The answer still ends with the guarantee:

    The bpf development process guarantees that the future kernel
    versions will accept all bpf programs that were accepted by
    the earlier versions.

Does this contradict the verifier.rst that this same patch rewrites?

Example 4 in verifier.rst has programs that the verifier that follows each
path accepts, and that the joining verifier rejects:

    if (c) { i = 3; n = 4; } else { i = 7; n = 8; }
    arr[n - i]

    paths:  processed 25 insns
    joins:  R8 min value is negative, either use unsigned index or do a if (index >=0) check.

The ret = idx < 64 ? 0 : -1 program in the same example likewise goes from
loading to "math between map_value pointer and register with unbounded min
value is not allowed".

verifier.rst also says that a join without the rules can lose a fact that
the program uses, and that most of the rules apply only while there is
room.  So the number of states elsewhere in a program can decide whether
the program loads.

Programs that loaded before can now fail, and user space can see that.
Should the guarantee be qualified here, or should the series keep
accepting such programs?

Two smaller points about this answer.

The new text does not mention the per-program limits that replace the 1M
insn limit ("too many states for N insns", 16*N+4096 states at one time and
256*N+64K in total, see kernel/bpf/flow.c).

Also, the Q/A earlier in this file still reads:

    Q: Can loops be supported in a safe way?
    A: It's not clear yet.

while the new verifier.rst says the verifier permits loops.

[ ... ]

> diff --git a/Documentation/bpf/verifier.rst b/Documentation/bpf/verifier.rst
> index 510d15bc697b..cc1e6eae5471 100644
> --- a/Documentation/bpf/verifier.rst
> +++ b/Documentation/bpf/verifier.rst
> @@ -3,558 +3,1179 @@

[ ... ]

> +
> +  loop                                               method
> +  -------------------------------------------------  -------------------------------------------
> +  counted, scalar evolution describes all registers  ranges at the head, example 5
> +  counted, a register has no description             unroll, 100000 insns at most
> +  not counted                                        unroll while constants decide the exits,
> +                                                     4096 insns at most. Then this example and
> +                                                     example 7

Is "4096 insns at most" accurate for a loop that is not counted?

bpf_flow_loop_enter() in kernel/bpf/verifier.c raises the unroll budget for
long loops:

    /* Two trips for a loop of any length. Many a loop is left in the second one. */
    if (patience && flow_walk_factor(cur) == 1)
            patience = max_t(u64, patience, 2ULL * loop->nr_insns);

The walk then continues while:

    env->insn_processed - entry->walk_start <= entry->walk_patience

A loop with more than 2048 insns that is not inside another unrolled loop
is therefore unrolled for 2 * nr_insns insns, for example 6000 insns for a
loop of 3000 insns.

Should the table say "4096 insns, or two iterations of a longer loop"?

[ ... ]

> +8. A loop ends at run time: may_goto
> +------------------------------------
> +
> +It is possible that the loop of example 6 never ends. The verifier adds a may_goto insn before the
> +latch.
> +
> +- may_goto decrements a count.
> +- After 65535 iterations it reads the clock.
> +- It jumps to its target when the time slice is over.
> +
> +One run of a program has one time slice and one count. All loops and all subprograms of the run
> +share them.

Does may_goto behave like this on every configuration?  The description of
the run time behavior depends on the JIT.

First, the clock.  bpf_do_misc_fixups() in kernel/bpf/fixups.c emits the
timed sequence (count 0xffff, call to arch_bpf_timed_may_goto, 250 ms in
bpf_check_timed_may_goto()) only when bpf_jit_supports_timed_may_goto() is
true.  Otherwise each frame starts with:

    BPF_ST_MEM(BPF_DW, BPF_REG_FP, -stack_depth, BPF_MAX_LOOPS)

and only counts down 8M iterations.  No clock is read, and
bpf_prog_report_may_goto_violation() is never called, so unwound is not set
and nothing is written to stderr.

That contradicts "After 65535 iterations it reads the clock" and the later
paragraph about "unwound" and the stderr stream of the program.

Second, the shared budget.  The per-run budget ("One run of a program has
one time slice and one count. All loops and all subprograms of the run
share them.") is allocated only under:

    subprogs[i].stack_extra && bpf_jit_supports_timed_may_goto() &&
    bpf_jit_supports_percpu_insn() && bpf_jit_supports_exceptions() &&
    prog->jit_requested && prog->type != BPF_PROG_TYPE_EXT

Several cases do not meet this:

- riscv and loongarch support timed may_goto but not exceptions.
- x86-64 without the ORC unwinder and arm64 without the frame-pointer
  unwinder report no exceptions support.
- freplace programs (BPF_PROG_TYPE_EXT) are excluded.

In all of these each frame has its own 250 ms slice and its own count.
That is the behavior the comment above bpf_check_timed_may_goto() says the
budget exists to prevent.

So the diagram and "Thus a run reads the clock even if each loop in each
subprogram is short" hold only on x86-64 and arm64 with the required
unwinder.  Should the section state these conditions?

[ ... ]

> +The edge of the added may_goto is also an edge for the analysis. The state at the latch goes to
> +exit with r0 = 0. The verifier checks it as it checks each exit: the program must hold nothing,
> +and 0 must be a valid return value.

[ ... ]

> +**The target of an added may_goto.** An added may_goto has one target, and the verifier verifies
> +only this edge. The verifier selects the target at load time::
> +
> +          does the frame hold a lock, a reference or an rcu section
> +          that it did not hold at its entry ?
> +               | no                                | yes
> +               v                                   v
> +       exit from the function               exit from the loop
> +       (insn 30 above)                      (insn 27 above: jump across the latch)

Is this chart complete?  It says the target depends only on whether the
frame holds a lock, a reference or an rcu section, and the earlier
paragraph says the r0 = 0 exit is checked like each exit, so that "0 must
be a valid return value".

budget_can_unwind() in kernel/bpf/verifier.c chooses the target otherwise:

    if (st->acquired_refs != frame->entry_refs ||
        st->active_rcu_locks != frame->entry_rcu_locks ||
        st->active_preempt_locks != frame->entry_preempt_locks)
            return false;
    ...
    if (top && !frame->subprogno && !zero_is_valid_retval(env))
            return false;

Two things are missing from the chart.

First, a preempt-disable section also sends the may_goto to the exit of the
loop.

Second, when the main program cannot return 0, the verifier does not check
and reject the r0 = 0 exit.  It never makes that edge, and selects the exit
of the loop instead (guard_no_unwind in check_loop_guard()).

For program 1 (do { p = lookup(); } while (!p); return *p;) under a program
type whose return range excludes 0, the result is therefore "invalid mem
access 'map_value_or_null'", not a return value error.

Should the chart and the sentence about "0 must be a valid return value"
list these conditions?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/40263142572
--===============3956143948836320364==--
