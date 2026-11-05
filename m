Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793914544;
	b=Djy/naJjWmPsj3maq1bjddFgwEXLq3uKRAD/QODHQGhHRKJk+vDmtFnXcZ+VdcRES8vd
	 jXCvvssEyBGBaCS1MTpIZnMXo+Ad6yGrfILTQoUffm2PLKcnp4WsqvQdS3ecrsqAhdQ65
	 7fJrQpX7Qu59xEOTdpcz+VqPMWEm6mpAADhvqpR1WersiRRY/jipgTnpI0fjCYNbrlWXt
	 nump4eXWKTDv5iJlnRwPZG8cbucJz0tl9l5xdfGXE3++N+5pHC4QHBdmaAY2ztI10U5Ei
	 qkZYRNbM2kfCWBu1Z48SSG4X9K/2E0OznFKbTGagV/WOjGrWshqz4vQ07YL+9sryL5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793914544;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=CRN00+XWxXiDGnQjGReaFlxUJHz2+0fwoiD+aRzZhzE=;
	b=j+9LLLddD+g9jtZCm4hy9u1ro8wQk7hStABkTrWSanfpvVHQSalX68IdOS4QgObI53ya
	 oEIACrIIV5bQN7FNi5AVe59UkYfbonnorwpD22RG1v4zz/lePx7CSFsOtU8QP5fOJEAln
	 qk5rU3ppNReaC1fFXHON3sk37hJxdn5gStvqFCnifbQPqYMMvRfcueu2+ldUxuCTvteOI
	 acR5ahH3nOUe7OmJEoCjXoceLk5eBmk1CYh6WFYPRAGvPV5S8fCdixwpeP6SopavoSLuX
	 2pGzMxEyNS5NqMyvAlAF/b0KlWfZqeHouEqJ62CrAEpdYvj2IGnG4STtvFd7Tn7dQJg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PZl663Wv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D9E3606D807
	for <bpf@vger.kernel.org>; Thu,  5 Nov 2026 21:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PZl663Wv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9A6A1F008A3;
	Thu,  5 Nov 2026 21:35:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793914544;
	bh=CRN00+XWxXiDGnQjGReaFlxUJHz2+0fwoiD+aRzZhzE=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=PZl663WvjWElUvTGw2+gTlx/tmf7IesEhdcuoIigNvrpEb3LlE/BszyC1xxwlAkJq
	 Fvksexy0nS8S0Buia9covNC46gaU/QZkfZLNfZK9ez2o3CEWq1s+ui++aUVv2IGe9j
	 egzPRSgr8biRN8v2RiLw8VgFHyB6zuGJb9Jpk+VLpaMrTORbGFC80QDk8CYefNcImb
	 PdWuR09Z2bm2LF58WZXE2o7moi43YsvQHWDCmAbfaNwew67lrqRyZ1gA2hxJYDQHGT
	 bxC6LSOej6KrVtf38pGvC+zWKe7ygvRi5rLgx3qT97tx1lTL37K9U8QkAZuzUIVLDW
	 Q4MN4KynR2DSQ==
Content-Type: multipart/mixed; boundary="===============8532704445745712772=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <30511ed9caaa7fab02343ad6adbd72f0c7d689b7ae89d4b0c37bdf2beb45a414@mail.kernel.org>
In-Reply-To: <20261105204513.2230344-20-alexei.starovoitov@gmail.com>
References: <20261105204513.2230344-20-alexei.starovoitov@gmail.com>
Subject: Re: [PATCH bpf-next v2 19/35] bpf: Verify programs as a fixpoint over the control flow graph
From: bot+bpf-ci@kernel.org
To: alexei.starovoitov@gmail.com,bpf@vger.kernel.org
Cc: daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Thu,  5 Nov 2026 21:35:43 +0000 (UTC)

--===============8532704445745712772==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Verify programs as a fixpoint over the control flow graph

TL;DR:
- Removed insn limit leaves id_gen unbounded; id collisions may make verifier
  unsound
- Valid programs possibly rejected: dead bail_insn, bpf_throw-only loops,
  offloaded loops
- Possible nospec ordering gap; log level 1 may hit -ENOSPC

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
>  			bpf_find_containing_subprog(env, i)->can_unwind = true;
>  			seen = true;

bail_insn is the last BPF_EXIT of the subprog in insn order, and it is picked
here before bpf_compute_const_regs() and bpf_prune_dead_branches() run.
Nothing re-checks that this exit is still reachable after pruning.

bpf_prune_dead_branches() turns conditional jumps with constant operands into
BPF_JMP_A().  Loads from read-only maps fold to constants in
const_reg_xfer(), so a 'const volatile' guard like 'if (!enabled) return 0;'
can leave the last exit of a function unreachable.

bpf_compute_live_registers() only updates state[i].in for insns that are in
env->cfg.insn_postorder:

    for (i = 0; i < env->cfg.cur_postorder; ++i) {
        int insn_idx = env->cfg.insn_postorder[i];
        ...
    insn_aux[i].live_regs_before = mask_lo(in) | mask_hi(in);

An exit that is not in the postorder gets live_regs_before == 0, which
includes R0.  The budget edge is not in bpf_insn_successors() (the new
const_fold comment says "That is not an edge of the graph"), so unlike the
tail_call/LD_ABS edge to exit_idx, nothing makes this target live.

When a guarded loop runs out of budget:

check_loop_guard()
  push_budget_exit()
    push_stack(env, sub->bail_insn, ...)   /* R0 = 0 */
flow_drain()
  bpf_flow_guard_edge()
    bpf_flow_deliver()
      flow_arrive()
        bpf_clean_verifier_state()

__clean_func_state() marks every register that is dead at bail_insn as
NOT_INIT, so R0 is lost.  For the main prog, the exit then reaches
check_return_code() -> check_reg_arg(env, BPF_REG_0, SRC_OP), which fails
with "R0 !read_ok" (-EACCES).

Can a valid program be rejected only because of where the compiler placed a
dead exit?  This needs the last exit by insn index to sit in a branch that is
pruned as constant, a loop in that function that gets guards, and
budget_can_unwind() to be true.

bpf_subprog_info::exit_idx has the same meaning ("one of the BPF_EXIT
instructions in this subprogram").  Would choosing an exit that is still in
the postorder after bpf_prune_dead_branches(), or marking R0 (and R2 for
ret_reg_pair) live at bail_insn in bpf_compute_live_registers(), avoid this?
The later commit cfd0b02db6cf ("bpf: Allow recursive subprogs") also uses
bail_insn as the target of the recursion guard, so it has the same issue, and
nothing in the rest of the series changes how bail_insn is chosen.

[ ... ]

> @@ -21132,7 +21244,25 @@ static int loop_stack_push(struct bpf_verifier_env *env, bool *pushed)
>  
>  	for (; num_missing; num_missing--, cnt++) {
>  		h = missing_headers[num_missing - 1];
> -		loop_stack[cnt] = (struct loop_stack_entry){ .loop_id = h };
> +		/* wherever it is entered: a loop can have more than one entry */
> +		if (!aux[h].loop->exits_cnt) {
> +			verbose(env, "loop at insn %d never exits\n", h);
> +			return -EINVAL;
> +		}

A loop whose only way out is bpf_throw() (for example bpf_assert() used as
the loop bound) is now rejected, although it was accepted before this commit
and stops at run time.

The loop exits come from the CFG edges in bpf_compute_loops(), which uses
bpf_insn_successors().  That function adds a hidden edge to the subprog exit
for tail_call and LD_ABS/LD_IND, but nothing for the bpf_throw() kfunc, which
keeps its plain fall-through successor.  Take:

    for (i = 0; ; i++) {
        bpf_assert(i < 16);   /* if (!(i < 16)) bpf_throw(0); */
        sum += arr[i];
    }

The throw block falls through back into the loop body, so the loop gets
exits_cnt == 0.  When the first state reaches the head,

flow_add()
  bpf_flow_loop_enter()
    loop_stack_push()

hits the new check and fails with "loop at insn N never exits" (-EINVAL).

Before this commit, do_check() followed paths: i is a known constant on every
trip, is_branch_taken() decides the assert, and at i == 16 check_kfunc_call()
ends the path via process_bpf_exit_full(env, NULL, true).  So the program
loaded.

The commit message lists "no exit: rejected", but does not mention loops that
end with bpf_throw().  Was this case considered?  Would treating a
bpf_throw() call like the tail_call hidden edge, or noting the change in the
changelog, make the behaviour explicit?

[ ... ]

> @@ -21669,6 +21854,10 @@ static int do_check(struct bpf_verifier_env *env)
>  		if (state->speculative && insn_aux->nospec)
>  			goto process_bpf_exit;
>  
> +		err = check_loop_guard(env);
> +		if (err)
> +			return err;
> +
>  		err = do_check_insn(env, &do_print_state);

Should check_loop_guard() run before the nospec early exit?  It models the
may_goto that bpf_insert_loop_guards() puts in front of a guard_place insn,
and the emitted code is in the opposite order.

bpf_insert_loop_guards() patches insn X into [may_goto ..., X].
patch_list_adj_aux() gives X's aux data, nospec included, to the last insn of
the patch, which is X.  bpf_do_misc_fixups() then emits BPF_ST_NOSPEC()
directly in front of X:

    may_goto expansion (conditional JEQ on the stack counter)
    NOSPEC
    X

At run time a speculative path can follow the may_goto branch to guard_to (or
to the budget exit) before it reaches the barrier.  The verifier never checks
that edge for a speculative state that it drops at X because of nospec.

With !bypass_spec_v1 (no CAP_PERFMON), a speculative state can reach a guard
place, for example the conditional jump that leaves the loop
(flow_set_guard()) or the loop head, and fail there with a recoverable error
such as an uninitialized register, which sets insn_aux->nospec.  From then on
every later speculative state at X that is not within an earlier one is
dropped before check_loop_guard().  nospec also survives a do_check_all()
restart, so a loop that becomes guarded in round 2 (rt_bounded lost, or
guards_late) never has its guard edge explored for any speculative state at X.

Does this mean the code at guard_to is verified only for non-speculative
states, and so gets no nospec barriers for speculative register values?  At
e9cbd02faf11 do_check_block() still tests nospec before check_loop_guard().

[ ... ]

> @@ -21669,6 +21854,10 @@ static int do_check(struct bpf_verifier_env *env)
> +	if (!entry->guarded && !bpf_loop_walk_may_give_up(entry))
> +		return 0;
> +
> +	/* the device runs the insns that the driver was given, without may_goto */
> +	if (bpf_prog_is_offloaded(env->prog->aux)) {
> +		verbose(env, "loop at insn %d has no known bound in an offloaded program\n", h);
> +		return -EINVAL;
> +	}

Are offloaded programs rejected here for loops that a walk would prove
finite, before the walk has finished?

The commit message says a loop that is "counted, or walked to its end" gets
nothing added.  A state in a walk (flow_try_walk() sets apart, terminates and
probe, and counted is never set at this commit) has
bpf_loop_walk_may_give_up() == true and entry->guarded == false, so it is not
caught by the early return above.  The first time it reaches the guard place
in its first trip, check_loop_guard() returns -EINVAL for an offloaded
program.

For non-offloaded programs, the same state only pushes guard edges, and
bpf_flow_guard_edge() drops them while loop->guarded is false.  If the walk
reaches the end of the loop, the loop never gets may_goto and aux->loop_guard
is never set.  So nothing would need to be added to the offloaded program
either.  The offload check fires on a possibility (the walk may give up), not
on a may_goto that will actually be inserted.

A concrete path is an XDP program loaded with prog_ifindex for an nfp device
by a loader with CAP_PERFMON, with a loop that has no may_goto and no
bpf_iter_*_next(), and for which bpf_compute_loop_iters() finds no count:

do_check_all()
  do_check()
    do_check_block()
      check_loop_guard()  -> "loop at insn N has no known bound in an
                              offloaded program"

The old do_check() accepted such bounded loops in offloaded programs.
Could the check return 0 while !entry->guarded, and reject only once the
state takes edges that are real?  A walk that gives up continues with
entry->guarded = loop->guarded = true (flow_end_walk()) and still reaches this
check.

[ ... ]

> @@ -21523,9 +21760,6 @@ static int do_check(struct bpf_verifier_env *env)
>  		if (need_resched())
>  			cond_resched();
>  
>  		env->prev_insn_idx = prev_insn_idx;
>  		if (env->insn_idx >= insn_cnt) {

[ ... ]

> @@ -21538,18 +21772,10 @@ static int do_check(struct bpf_verifier_env *env)
>  		account_processed_insn(env);
>  
> -		if (env->insn_processed > BPF_COMPLEXITY_LIMIT_INSNS) {
> -			verbose(env,
> -				"BPF program is too large. Processed %d insn\n",
> -				env->insn_processed);
> -			return -E2BIG;
> -		}
> -

Is anything keeping env->id_gen below BPF_MAX_ID now?  include/linux/
bpf_verifier.h states "env->id_gen stays below BPF_MAX_ID. So no id is a name
or has a bit of BPF_ADD_CONST."

Before this commit insn_processed was never reset, so a whole bpf_check()
handled at most 1M insns and env->id_gen stayed at a few million.  With this
check removed, do_check_block() runs with no bound on the insns it processes
or the ids it hands out.  The work is bounded only by flow.c's state budget
(256 * len + 64K states, each running a whole basic block) times the length
of a block, and do_check_all() can repeat the main pass and every global
subprog pass without resetting env->id_gen.  The only BPF_MAX_ID test at this
commit is in bpf_flow_return(), which is unreachable because bpf_flow_call()
and bpf_flow_exit() have no callers yet.

Ids are handed out per processed insn, for example
assign_scalar_id_before_mov() does:

    src_reg->id = ++env->id_gen;

for every 'rX = rY' of an unknown scalar.  If id_gen passes 0x40000000
(BPF_ADD_CONST32), a fresh id such as 0x40000005 has the BPF_ADD_CONST32 bit
set.  collect_linked_regs() and sync_linked_regs() compare
'id & ~BPF_ADD_CONST', so they treat that register as linked to a live
register with id 5, and with equal deltas sync_linked_regs() does
'*reg = *known_reg', copying bounds learned for one register into an
unrelated one.  Once id_gen wraps at 2^32, ids collide with live pointer ids
outright.  Can that lead to unsound verdicts?

Commit 23c6d5586fb8 ("bpf: Verify static subprogs on their own") later adds
this to the loop:

	/* no insn makes as many ids as there are from here to BPF_INHERITED_ID */
	if (env->id_gen >= BPF_MAX_ID) {
		verbose(env, "too many ids\n");
		return -E2BIG;
	}

Since this commit removes the old implicit bound, could that check move into
this patch?

[ ... ]

> @@ -21712,23 +21891,40 @@ static int do_check(struct bpf_verifier_env *env)
>  process_bpf_exit:
>  			account_current_path(env);
>  			mark_verifier_state_scratched(env);
> -			err = bpf_update_branch_counts(env, env->cur_state);
> -			if (err)
> -				return err;
> -			err = pop_stack(env, &prev_insn_idx, &env->insn_idx,
> -					pop_log);
> [ ... ]
> +			bpf_free_verifier_state(state, false);
> +			memset(state, 0, sizeof(*state));
> +			return flow_drain(env);

At log_level 1 the verifier log is no longer rolled back when a state
finishes.  The removed code used:

	bool pop_log = !(env->log.level & BPF_LOG_LEVEL2);
	...
	err = pop_stack(env, &prev_insn_idx, &env->insn_idx, pop_log);

and pop_stack() did bpf_vlog_reset(&env->log, head->log_pos), so at level 1
the log held at most the path being verified.  Nothing replaces it:
flow_drain(), bpf_flow_deliver() and bpf_flow_next() never touch env->log,
while do_check_block() still prints "%d: " plus the insn for every insn.  The
log now grows with every block of the pass until do_check_common() resets it
on success.

bpf_verifier_vlog() calls bpf_vlog_update_len_max() for each line, which
keeps the largest end_pos ever reached.  bpf_vlog_finalize() reports that as
log_true_size and does:

	if (log->ubuf && log->len_max > log->len_total)
		return -ENOSPC;

and bpf_check() turns that into the result of the load.  Can a branchy
program loaded with log_level=1 and a buffer larger than its longest path's
log, but smaller than the log of all its blocks, now fail with -ENOSPC even
though verification succeeded?  Previously it loaded.

When a load fails at level 1, the log is also no longer the path that led to
the error, but every block processed before it in flow order.  The commit
message describes the log only at level 2 ("Log level 2 shows basic blocks,
not paths") and does not mention level 1 or log_true_size/-ENOSPC.  Should
the log be reset per block at level 1, or should this be documented?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/42109044416
--===============8532704445745712772==--
