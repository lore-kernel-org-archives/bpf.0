Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792986813;
	b=Zj1fO6Iqn+ivZ8l8ioLdJQ/z2tIaRWUxO0rOz/fYCM+dCdh6l6S4KuDVUMnbNqgZ7EnK
	 WPBTo9K6QPnpFXYjov+K4cLIo6m20Gt6aYDyHNK4tnO3G2p0MV+GrJ8x91AANKbWaei6w
	 yZrgEeMUttFrzQo+BO66cdARaE13DSWNjZJKhqjsJnGDHovuqrT9R8QE5W8+l/GhsdAlR
	 WJq5tg1IJV4YzvlxQBmW0Ha9BEmhi2Kal2Go12mVnW4TD/MS37XVTbHbW5dbyN4UIqfzN
	 PlV0tnx0Xv2N9cCR1GGF2gJLtfMmFTbbg6HZ3jzcnQjqeyQXjb7eA1p3phiBuu0KzsA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792986813;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=UNDQPEA+KibyuGxw0Fjs36ybrMmPf8cBwq1JgY++Tnk=;
	b=MJYbNfsuZEvBNPD2Z7ajcEoCgeyu6+jkUsn1ekeZ3m5LATqvtQ6zo5308Bpuc8SiU6Oo
	 Lc8Jd9FaEJ2BxYE8m217vSnOhy22QzQopv/lRiEIiQaHnBN+KA2qsWKKbJHM541KLVH/g
	 NdCkDolpZSTsnQfyv9rpXPKlkOEg9KMcrAPTT1IpcAwJH4aaF8QvyN/cjzVi/cuKaUuFj
	 WseP5osWnE+cTDXLKq39ILpJoHKSqSZYd/xnML9JU7L9sy5YNSR5kPSv93liDEWO+Aw4s
	 YuAth9xs9//jc269126NArIr5AjqOvkzs/kupeauA89k2CFE4/zORJFAPFXxA4undCw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Zrt/f5b4";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 585B2606A31A
	for <bpf@vger.kernel.org>; Mon, 26 Oct 2026 03:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Zrt/f5b4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02E391F01825;
	Mon, 26 Oct 2026 03:53:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792986813;
	bh=UNDQPEA+KibyuGxw0Fjs36ybrMmPf8cBwq1JgY++Tnk=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=Zrt/f5b4Xy/ex2jntYJG4YXTcogWLXzQwbC64K1sVut59AdIxeEefzoMTfPUyWcS9
	 UCaofzb4ohEGXE1j/dLC7cF0zSKWtzphabs21qbILfwVM1iRu8Y3pSUxAbWdbE5f7Y
	 UgJYI/p6/SQ+jAzSLvtHyVfTaqcsQGWpNptYn6Bppzl6/oPjShyIK8dLhCPcEs1Qlc
	 laLJqzNBAx/b9k2jlcGhpxc1l6ev1QH/LmiuejdwypwqPqdeJtkmoA41VxKTCVj9MA
	 CE+h7Pf+h83FS8n4NTY2tvvrxwyCWcRWlhmtWTo8sSd2aWtrFdUiDR9E64rUxts/l1
	 b6AtyfStO1pLQ==
Content-Type: multipart/mixed; boundary="===============2995944056318544606=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <f3f414792a2e460ce25aa844391bed149528afa4db892f06dad84b4f5458e528@mail.kernel.org>
In-Reply-To: <20261026025943.404450-47-alexei.starovoitov@gmail.com>
References: <20261026025943.404450-47-alexei.starovoitov@gmail.com>
Subject: Re: [PATCH bpf 46/81] bpf: Finish the insn in the state that maybe_fork_scalars() splits off
From: bot+bpf-ci@kernel.org
To: alexei.starovoitov@gmail.com,bpf@vger.kernel.org
Cc: daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Mon, 26 Oct 2026 03:53:32 +0000 (UTC)

--===============2995944056318544606==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Finish the insn in the state that maybe_fork_scalars() splits off

TL;DR:
- Changelog may understate: pruning a forked r1=0 state in a terminating loop
  looks reachable, so the verifier could accept unsafe programs; maybe needs
  Fixes: tag
- Forked path loses its verifier log record of the insn (log-only regression)

> bpf: Finish the insn in the state that maybe_fork_scalars() splits off
>
> When a register is -1 or 0, maybe_fork_scalars() splits the state in two
> before an 'and' or an 'or' with a constant. The result is more accurate for
> each value alone. The verifier continues with -1. It pushes a copy of the
> state with 0 and verifies the copy later, from the same insn.
>
>            today                              this patch
>
>   N:   r1 &= 8    r1 is -1 or 0      N:   r1 &= 8    r1 is -1 or 0
>         /     \                            /     \
>     r1 = -1   r1 = 0                   r1 = -1   r1 = 0
>     r1 &= 8   push to N                r1 &= 8   r1 &= 8
>        |                                  |      push to N+1
>   N+1: ...                           N+1: ...
>
> At insn N the copy is a part of the state that it came from. If pruning
> compared the two states, it would drop the copy, and no one would verify
> the case r1 = 0. Today that does not occur for one reason only: the first
> state has branches that are not explored, and pruning does not use such
> states.
>
> Do not depend on that. Do the insn in the copy too, and push the copy to
> the next insn. All other code that pushes a state does the same.
>
> No verdict changes in selftests, Cilium and scx. Each fork processes one
> insn less, and the sequence in which the verifier explores states changes
> slightly. 68 of 144 progs of Cilium process a different number of insns,
> from -4.8% to +3.3%. The total is 1151838 -> 1151493.
>
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>

The changelog says the copy is not dropped today because "the first state has
branches that are not explored, and pruning does not use such states".  Is
that accurate for the parent commit?

bpf_is_state_visited() can prune against a stored state that still has
branches > 0, when both states are in the same loop and SCEV has proved
that loop terminates:

kernel/bpf/states.c:bpf_is_state_visited() {
    ...
			old_loop = current_loop(&sl->state);
			cur_loop = current_loop(cur);
			if (old_loop && cur_loop &&
			    old_loop->terminates && cur_loop->terminates &&
			    old_loop->entry_state == cur_loop->entry_state) {
				if (states_equal(env, &sl->state, cur, RANGE_WITHIN)) {
					loop = true;
					goto hit;
				}
    ...
}

The sequence below needs a loop for which bpf_compute_loop_iters() returned 1,
so that handle_loop_entry_exit() set entry->terminates and
entry->entry_state:

(1) cur reaches a prune point N inside the loop body that holds 'r1 |= 8',
    with r1 in [-1, 0].  bpf_is_state_visited() adds a checkpoint S at N
    through bpf_split_cur_state(), so S->branches == 1.

(2) maybe_fork_scalars() pushes the copy B at insn N, so S->branches == 2.

(3) cur, with r1 = -1, takes 'if r1 s< 0 goto exit' and ends.
    bpf_update_branch_counts() brings S->branches down to 1.

(4) B is popped at N.  handle_loop_entry_exit() changes nothing, because N is
    not the loop header.  bpf_is_state_visited() then finds S at N with
    branches == 1.  current_loop() of S and of B is the same terminating loop
    with the same entry_state, because B is a copy.  states_equal(S, B,
    RANGE_WITHIN) holds, because B equals S except that r1 = 0, which is
    within [-1, 0], and RANGE_WITHIN compares scalar ranges whatever the
    precision.

B is then pruned, and the r1 = 8 path is never verified.  That path could be
the out-of-bounds map access of or_scalar_fork_rejects_oob in
progs/verifier_bounds.c, placed inside such a loop.

So in this tree the problem looks reachable, and this patch fixes a real
soundness hole.  The other paths that use states with branches > 0
(is_iter_next_insn(), may_goto, bpf_calls_callback()) cannot match an ALU
insn.

Should the changelog describe the bug as reachable?  Should it also carry a
Fixes: tag?  The candidate would be:

  Fixes: 6ccf49f79327 ("bpf: Use SCEV to widen bounded loops")

That commit added pruning against states with branches > 0 in terminating
loops.  Before it, c845894ebd6f ("bpf: Fix unsound scalar forking in
maybe_fork_scalars() for BPF_OR") had already made the copy resume at the
same insn.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index f065e7e829c6..b44a5c63a922 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> @@ -17386,19 +17389,25 @@ static int maybe_fork_scalars(struct bpf_verifier_env *env, struct bpf_insn *ins
>  	else
>  		return 0;
>
> -	branch = push_stack(env, env->insn_idx, env->insn_idx, false);
> +	branch = push_stack(env, env->insn_idx + 1, env->insn_idx, false);
>  	if (IS_ERR(branch))
>  		return PTR_ERR(branch);
>
> -	regs = branch->frame[branch->curframe]->regs;
> +	reg = &branch->frame[branch->curframe]->regs[insn->dst_reg];
>  	if (alu32) {
> -		__mark_reg32_known(&regs[insn->dst_reg], 0);
> +		__mark_reg32_known(reg, 0);
>  		__mark_reg32_known(dst_reg, -1ull);
>  	} else {
> -		__mark_reg_known(&regs[insn->dst_reg], 0);
> +		__mark_reg_known(reg, 0);
>  		__mark_reg_known(dst_reg, -1ull);
>  	}
> -	return 0;
> +	/*
> +	 * The insn is done with in the branch too, and what gets to the next insn is a state
> +	 * like any other. At this insn the branch is a part of the state that is looked at:
> +	 * it must not be compared with it.
> +	 */
> +	clear_scalar_id(reg);
> +	return adjust_scalar_min_max_vals(env, insn, reg, *src_reg);
>  }

Does the branch pushed here lose the verifier log record of insn N?

maybe_fork_scalars() runs inside the diagnostic modification scope of
check_alu_op().  push_stack() saves the log position at the fork, which is
before bpf_diag_mod_end() adds the BPF_DIAG_HISTORY_MOD event for insn N, and
that event is added on the current path only:

check_alu_op()
    bpf_diag_mod_begin(env, &regs[insn->dst_reg], NULL, BPF_DIAG_MOD_WRITE)
    adjust_reg_min_max_vals()
        adjust_scalar_min_max_vals()
            maybe_fork_scalars()
                push_stack()
                    elem->diag_log_pos = bpf_diag_event_log_save(env)
    bpf_diag_mod_end(env)    <- event for insn N, current path only

When the branch is popped, pop_stack() calls
bpf_diag_event_log_restore(env, head->diag_log_pos), which cuts the log back
to before that event.

Before this patch the branch resumed at insn N, and check_alu_op() ran again
and recorded an event of its own.  For 'r6 |= 8' that was R6 0 -> 8, and for
a 32-bit fork the old and new snapshots also differ.  Now the branch resumes
at N+1, and its event log has no change of dst_reg at insn N.

This would show up with log_level >= 1 when that path later fails and the
report follows dst_reg's lineage through diag_build_lineage().  For example:

    r6 s>>= 63
    r6 |= 8
    if r6 s< 0 goto out
    r0 = r6
    exit

or 'r2 = r6' before a helper call.  In such a report the Causal path would
say that r6 last changed at the 's>>= 63' insn, with signed range [-1, 0],
and leave out the insn that made r6 equal to 8.

The new comment says "The insn is done with in the branch too", and the
commit message says "Do the insn in the copy too".  Neither holds for this
part of the insn.  The same applies to reg_bounds_sanity_check(), which
check_alu_op() runs only on regs[] of the current state.

The cast fork in check_helper_call() shows how to keep the history there:

kernel/bpf/verifier.c:check_helper_call() {
    ...
    bpf_diag_mod_end(env);
    ...
    branch = push_stack(env, env->insn_idx + 1, env->insn_idx, false);
    ...
    bpf_diag_mod_begin(env, &regs[BPF_REG_0], NULL, BPF_DIAG_MOD_WRITE);
    ...
}

Would calling bpf_diag_mod_end() before push_stack() and bpf_diag_mod_begin()
again after it work here too?

Verdicts are not affected, this is a verifier log regression only.  Later in
the series, b3ab9c9b1713 ("bpf: Remove prune points, levels of state
comparison and pop_stack()") removes diag_log_pos and the per-path restore,
which replaces the mechanism this depends on.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/40263142572
--===============2995944056318544606==--
