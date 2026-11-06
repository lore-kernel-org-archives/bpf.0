Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793939926;
	b=FYlIyc1/W5S5B1E853pILz8+UW5wVIT14vVkcFnv6LygVNM1lHZIejctWkN5MuXiA7a0
	 6nisd7TFmR7kRFcAEy5SVsnhuEG+4OIcSzqJfoVqpLMfBCHPx+iL3f06OaNiPN9mOeauL
	 +soawfsXL5YOv44r0HbMFcjVBzO6gCtYilTnyeBOWnTdOs5ILU9q0qYE7XhYGtfqLL5DK
	 xjVfa59fd4qv1K8uQCkM2ATfrZmKVW9xl3lg5zQ6w/CofJFZZCHA1MKydxs8JfOgTACuz
	 f1+uR9/8qudV6EqZNzBC3biofig2pC0J9/Ke+MvCVZ4lAyHtloGXSWF/1tP7lGfpbWQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793939926;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=J8aRUp5a74BZyJSn3PJRCqjD5a3wGTOhCccMHYCrooA=;
	b=h1nvOnFJGO6FKQBasXhQpLwpQQMq+GCPie6eUocoAGfZ4vqP3T0vWvMCUpB8yRV9geRS
	 bq7uOdJ/SuFGobc1H0k7MSS42TZ/28OkFiPyKcepZWHxTny5IxWvaeyzzuyywfQ/PDJGV
	 4wc3O9VGzTxU3eQqgAKJIg7ExTWVXjmtL/4i+yPvu6x9cRpxtkKR1rZzTCJjJhgotFbaP
	 fmlTRZndv1eRSrHua1XnDdHZWBTYn8MdYzS9UYS2Aaojy8WCyq6jpMED8dkclcTrE36wb
	 aUV2keeCaJLZuNNRiblJPTqAeg7hBBpEkjiqhPQdOxzggJEMQVJkqcRHZWTmD443c3A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kiOwETL8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EA33606A329
	for <bpf@vger.kernel.org>; Fri,  6 Nov 2026 04:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kiOwETL8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8DE51F0089F;
	Fri,  6 Nov 2026 04:38:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793939926;
	bh=J8aRUp5a74BZyJSn3PJRCqjD5a3wGTOhCccMHYCrooA=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=kiOwETL8AdtxZt6kz1Vj9mEdO4DdL2ThlloRNM7uEyjWCBN7v8c2mxPQx+Vct61To
	 5OiTrJIiaDpQ0M2oJzeicpFqlzwQimF5QBvIBp6JtdRoN20EoDapDqOdwDWQPmFjmJ
	 nMbfS87m0mJMPJNDXMG+hb2RJpKezLvR5rz9uH7piPA5nLVUZ0u6hSS3SRUPDV9dTH
	 ZKeoE5G1Vy2PkGAaCTBC9Z+EBi1eHXP9CECIcsy5/5DRcgclRUEMkNZMhxN3nsGnSP
	 PiWRnaB+2BM33DD4IqEut81qiZ7w5zSIe09fWvTez1Cl1uLWeH/AhC4MOQR2PA8aP4
	 REbM1TvP1iOYw==
Content-Type: multipart/mixed; boundary="===============4737595141466721812=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <d45442d2b60e1173e44eb688f47d82b116f39c084b65cf131a7c919f10bb7f4b@mail.kernel.org>
In-Reply-To: <20261106035111.3315285-20-alexei.starovoitov@gmail.com>
References: <20261106035111.3315285-20-alexei.starovoitov@gmail.com>
Subject: Re: [PATCH bpf-next v3 19/45] bpf: Verify programs as a fixpoint over the control flow graph
From: bot+bpf-ci@kernel.org
To: alexei.starovoitov@gmail.com,bpf@vger.kernel.org
Cc: daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Fri,  6 Nov 2026 04:38:45 +0000 (UTC)

--===============4737595141466721812==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Verify programs as a fixpoint over the control flow graph

TL;DR:
- Dead last-exit bail_insn may make valid loop programs fail with "R0
  !read_ok"; fixed only by a later patch
- Offloaded programs may reject bounded loops that previously loaded
- Log level 1 no longer rewinds per path, so -ENOSPC may break loads

> diff --git a/kernel/bpf/const_fold.c b/kernel/bpf/const_fold.c
> --- a/kernel/bpf/const_fold.c
> +++ b/kernel/bpf/const_fold.c
> @@ -263,6 +263,12 @@ int bpf_compute_const_regs(struct bpf_verifier_env *env)
>  
>  		for (r = 0; r < MAX_BPF_REG; r++)
>  			ci_in[start][r] = unknown;
> +		/*
> +		 * The subprog gets there from where it is out of budget too, see
> +		 * push_budget_exit(). That is not an edge of the graph.
> +		 */
> +		for (r = 0; r < MAX_BPF_REG && env->subprog_info[i].bail_insn >= 0; r++)
> +			ci_in[env->subprog_info[i].bail_insn][r] = unknown;
>  	}

Only the const pass is told about the extra edge to bail_insn.  Liveness is
not, even though the comment above bpf_head_guard_target() in
bpf_verifier.h says liveness must account for these edges too.

bail_insn is chosen in check_unwind_insns() before bpf_compute_const_regs()
and bpf_prune_dead_branches() run, so pruning can turn the last exit into
dead code.  For example, with a const volatile bool debug that is 0 at load
time, GCC may place the exit of "if (debug) return ..." last.

bpf_compute_live_registers() only visits insns in env->cfg.insn_postorder,
so live_regs_before stays 0 at a dead bail_insn.  When
check_loop_guard() -> push_budget_exit() -> push_stack(env,
sub->bail_insn, ...) delivers the state, clean_verifier_state() uses that
live mask and __clean_func_state() marks R0 NOT_INIT.  The exit check then
rejects the program with "R0 !read_ok".

Can this reject a valid program?  It needs a main prog with a loop that gets
may_goto and a last exit that is dead after constant pruning.

A later commit in the series fixes this: a989e69c3268 ("bpf: R0 is live at
the exit that an added may_goto goes to").  It adds R0, and R2 for a pair,
to insn_aux[bail_insn].live_regs_before in bpf_compute_live_registers().
Should that fix be part of this commit, next to the const_fold handling of
the same edge?

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> @@ -3459,7 +3482,17 @@ static int check_unwind_insns(struct bpf_verifier_env *env)
>  	bool seen = false;
>  	int i;
>  
> +	for (i = 0; i < env->subprog_cnt; i++)
> +		env->subprog_info[i].bail_insn = -1;
> +
>  	for (i = 0; i < env->prog->len; i++, insn++) {
> +		if (bpf_is_ldimm64(insn)) {
> +			i++;
> +			insn++;
> +			continue;
> +		}
> +		if (insn->code == (BPF_JMP | BPF_EXIT))
> +			bpf_find_containing_subprog(env, i)->bail_insn = i;
>  		if (bpf_is_unwind_exit(insn)) {

check_unwind_insns() sets bail_insn to the last BPF_EXIT of each subprog,
and push_budget_exit() later sends the out-of-budget state there with
R0 = 0.  Is anything making sure this exit is reachable?

check_unwind_insns() runs before bpf_compute_const_regs() and
bpf_prune_dead_branches().  Consider:

  const volatile bool debug;
  if (debug)
          return skb->len + 7;
  while (*p)
          ;
  return 0;

The 'if (debug)' becomes a BPF_JMP_A, and if the exit of the dead branch is
last, bail_insn is dead code with live_regs_before == 0.  The unbounded loop
gets may_goto, and budget_can_unwind() is true in the main prog.  Then:

check_loop_guard()
  push_budget_exit()
flow_drain()
  bpf_flow_guard_edge()
    bpf_flow_deliver()
      flow_arrive()
        bpf_clean_verifier_state()
          __clean_func_state()   /* R0 -> NOT_INIT, liveness says dead */

and at the exit process_bpf_exit_full() -> check_return_code() fails with
"R0 !read_ok", so a valid program fails to load.  This is the "potentially
unsafe usage" case in bpf.md, where the verifier reads a register that
liveness reports dead.

a989e69c3268 ("bpf: R0 is live at the exit that an added may_goto goes to")
later in the series marks R0, and R2 for a register pair, live at bail_insn
in bpf_compute_live_registers().

[ ... ]

> +/*
> + * The current frame leaves with 0 in place of the result: with unwind_exit if the subprog
> + * can do that, with exit otherwise. The insns are added when the main pass is over. Until
> + * then an exit that the subprog has stands for them.
> + */
> +static int push_budget_exit(struct bpf_verifier_env *env)
> +{
> +	struct bpf_subprog_info *sub = &env->subprog_info[cur_func(env)->subprogno];
> +	struct bpf_verifier_state *branch;
> +	struct bpf_reg_state *regs;
> +
> +	branch = push_stack(env, sub->bail_insn, env->insn_idx, false);
> +	if (IS_ERR(branch))
> +		return PTR_ERR(branch);
> +	branch->unwound = sub->bail_unwinds;
> +	regs = branch->frame[branch->curframe]->regs;
> +	__mark_reg_const_zero(env, &regs[BPF_REG_0]);

push_budget_exit() sends a copy of the state to the last BPF_EXIT of the
subprog in program order.  Can that exit be dead code after
bpf_prune_dead_branches()?

bpf_compute_live_registers() only walks env->cfg.insn_postorder, so a dead
insn keeps live_regs_before == 0, and the budget edge is not a CFG edge, so
liveness never learns that R0 (or R2 for a ret_reg_pair subprog) is read
there.  In the chain flow_drain() -> bpf_flow_guard_edge() ->
bpf_flow_deliver(), bpf_clean_verifier_state() then sets the R0 that
push_budget_exit() just made 0 to NOT_INIT.

process_bpf_exit_full() -> check_return_code() -> check_reg_arg(env,
BPF_REG_0, SRC_OP) then fails with "R0 !read_ok".  This looks like it
affects every non-void main program (or async callback) with a loop that
gets a guard while it holds nothing, which is the case the commit message
says now loads ("It goes to 'r0 = 0; exit'").  It also affects loops the old
path walk accepted but whose walk now runs out of patience (BPF_FLOW_MAX_TRY
= 4096 insns).

This is fixed later in the series by a989e69c3268, which marks R0, and R2
for a register pair, live at bail_insn.

[ ... ]

> +	/* the device runs the insns that the driver was given, without may_goto */
> +	if (bpf_prog_is_offloaded(env->prog->aux)) {
> +		verbose(env, "loop at insn %d has no known bound in an offloaded program\n", h);
> +		return -EINVAL;
> +	}

The check above this lets two kinds of state through: guarded entries, and
entries still in a walk on patience (bpf_loop_walk_may_give_up()).  A walk
is not a loop that needs may_goto, and the comment further down says "Both
are dropped as long as the loop has no may_goto: the state is in a walk that
may get to the end of the loop".  The commit message also says "counted, or
walked to its end -> nothing is added".

For an offloaded program, does the first state that reaches the guard_place
insn of any uncounted loop get -EINVAL, even when the walk would have
reached the end of the loop without a may_goto being added?  The path is
flow_try_walk() returning 1 and then check_loop_guard() at the guard place
in the first trip.

Before this commit such bounded loops were checked by path exploration, and
the NFP verifier hooks do not reject backward jumps, so these programs
loaded.  Would rejecting only when entry->guarded is set still catch every
loop that really gets may_goto?  A walk that gives up calls
bpf_flow_loop_gets_guards(), and the next entry or round is guarded.  No
later commit in the series changes this check.

[ ... ]

> @@ -21790,23 +21974,40 @@ static int do_check(struct bpf_verifier_env *env)
>  process_bpf_exit:
>  			account_current_path(env);
>  			mark_verifier_state_scratched(env);
> -			err = bpf_update_branch_counts(env, env->cur_state);
> -			if (err)
> -				return err;
> -			err = pop_stack(env, &prev_insn_idx, &env->insn_idx,
> -					pop_log);
[ ... ]
> +			bpf_free_verifier_state(state, false);
> +			memset(state, 0, sizeof(*state));
> +			return flow_drain(env);

At log_level 1 the verifier log is no longer rewound when a path ends.
Before this patch do_check() used pop_log = !(env->log.level &
BPF_LOG_LEVEL2) and pop_stack() did:

    if (pop_log) bpf_vlog_reset(&env->log, head->log_pos);

so at level 1 the log only held the current path from the entry.  Now
do_check_block() prints every insn at BPF_LOG_LEVEL, and the only resets
left are the one at the end of a successful pass in do_check_common() and
the one in do_check_all() between rounds.

Can this make a valid program fail to load?  bpf_vlog_update_len_max()
records the largest end_pos reached, and bpf_vlog_finalize() returns
-ENOSPC when log->ubuf && log->len_max > log->len_total, which bpf_check()
takes as the result.  Take a switch of 64 cases of 100 insns each, loaded
with log_level=1 and a 64KB buffer.  Before, the peak was about one path.
Now it is all 6400 insns of the pass.  On a failing program, -ENOSPC may
also replace the real -EACCES or -EINVAL.

On failure, level 1 also no longer shows the path that leads to the error.
It shows the tail of the whole flow-order trace, which mixes blocks of
unrelated paths.

The commit message only says "Log level 2 shows basic blocks, not paths".
It does not mention that level 1 loses its per-path rewinding.  Later
commits in the series (8a4d520dc379 removes pop_stack() entirely) do not
restore it.

[ ... ]

> +static int do_check(struct bpf_verifier_env *env)
> +{
> +	int prev_insn_idx = -1;
> +	int err;
> +
> +	err = bpf_flow_deliver(env, env->cur_state, env->insn_idx, -1);
> +	while (!err) {
> +		err = bpf_flow_next(env, &prev_insn_idx);
> +		if (err == -ENOENT)
> +			return 0;
> +		if (err)
> +			break;
> +		/* What is known about how the state came to be is not kept with it. */
> +		bpf_diag_event_log_restore(env, 0);
> +		err = do_check_block(env, prev_insn_idx);
> +	}
> +	return err;
>  }

The same log growth at level 1 applies in the new do_check().  Nothing
rewinds the log in do_check(), do_check_block(), flow_drain() or flow.c
between states, and the only reset in do_check_common() runs on success
only.  With BPF_LOG_FIXED the earlier blocks fill the buffer first, so the
error message at the end is cut off.  At level 1 the blocks have no "from X
to Y" header, so the trace is hard to follow.

I searched the rest of the series.  8a4d520dc379 ("bpf: Remove prune
points, levels of state comparison and pop_stack()") removes pop_stack() and
elem->log_pos without a replacement, and do_check() at the end of the series
still never rewinds.

Would it work to save env->log.end_pos at the start of do_check() and, when
!(env->log.level & BPF_LOG_LEVEL2), call bpf_vlog_reset() back to that
position before each do_check_block()?  At level 1 the log would then hold
only the block being checked plus its error.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/42160076968
--===============4737595141466721812==--
