Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793918751;
	b=4n6HfUoHHZKEME7QEaakPv4D5j/nWIF4eO3igR3B1vx4+gEFhCP/afrxbBRE/RJyLAe5
	 iByEtNbsxFcyxSKwgt0eqlQF5JB8sh5kG2cjoRN3qsRE4L+0pm/cbbi8jnRlO8xTH2fZG
	 jbMzvGvxnvCygj8eSNGYNgPAIdoIgJApRFTfgh3p40SVcTrGPZ5ZSJE+JyGPIlrtmqFIY
	 xnqdm/WGcIZOJGMD6jBP6fnUqbYpYPjrzPW7ameZCcXQD6FwQaBkVopBzFOOxR9u/H1R/
	 EDmuEyD/dnTgQznRlC5CH00rDOvSo+Idu2aLTaEsGnBJ0Q0v83rpdCEKwVJujLFDzHA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793918751;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=9SrOEYmfI4d75VYZ0nK5Mk4vzdtRNGH0TnAl2UAs//M=;
	b=rH6AUeoR393wYuSAaCxUyRdVsUyKwwxF2R8oCfvxTusetcdzzgk8+cgNturfv+Asockz
	 LXKiQA/y+smcm3ccBHCNIQ307dvPCK1YRzyS31NF0to2hfIg7v/X8sxUqJg5HfxaENX93
	 HdKzmEgAplML1t33gQkpwpXhCCEtczFxUBg7DKVWzEIrTyq0osgVDXdjiOlFkx0om9WjI
	 bMwX5MKWPzWaA/ZiWpVLDd1dwxDlX9R38GIE8DsYYTwuU6u/wIBJLRy8+DNsaOU+ORAHD
	 /WnpQreSKRwCRjmn3LpTMviJITEmFBtAkmjePE1WavaxuMqtG+fuY+d2xXnHMAoZ19w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="UQ/iyeFR";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D70A606A334
	for <bpf@vger.kernel.org>; Thu,  5 Nov 2026 22:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UQ/iyeFR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F9031F0089F;
	Thu,  5 Nov 2026 22:45:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793918750;
	bh=9SrOEYmfI4d75VYZ0nK5Mk4vzdtRNGH0TnAl2UAs//M=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=UQ/iyeFRyuRPS6O17jUIFic6SHDibuk87+pH+6erSmssieG0jKY13E/cBnXto/SqL
	 /idex6+FmCegfBFcf93a559XIKleR3CxwW4yBV9ypARmhM9i61miAnYagL62u3CD2R
	 LgZoLYf/2/iTD52lCyHXlelFl54RmAJQYwvqBUNFGgIyh52WorJ49Xrvd95LEDkuN6
	 SUJmd7RuCfdYxaiSD84dPY9QhODPl7iANMPTUPu4TlWvecFPrmbJDCTD9FPxl3wewK
	 SMAXqFnQT6ErBDTPsht9tVhh34eX25GXog6EnaJJcBJmx7q1gBZajeV9NKXU3OBjmP
	 DJa5/6MGexd7w==
Message-ID: <sashiko-outbox-200329@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2 19/35] bpf: Verify programs as a fixpoint
 over the control flow graph
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
In-Reply-To: <20261105204513.2230344-20-alexei.starovoitov@gmail.com>
References: <20261105204513.2230344-1-alexei.starovoitov@gmail.com>
 <20261105204513.2230344-20-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 22:45:50 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 7 potential issue(=
s) to consider:
- [High] bpf: missing bpf_head_guard_target() edge in update_insn() and nee=
d_const
- [High] bpf: missing loop_stack refs update in release_reference_state()
- [Medium] bpf: unreset loop_guard flag and ignored fatal errors in do_chec=
k_all()
- [Medium] bpf: join_func() rejects joins when fa->out_stack_arg_cnt < fb
- [Medium] bpf: unreachable bail_insn in check_unwind_insns() breaks budget=
 exit
- [Medium] bpf: check_loop_guard() rejects offloaded progs during patience =
walk
- [Medium] bpf: do_check_block() drains queued states after speculative nos=
pec abort
--

commit 03fa19749e4ec4512ca820f1f159f2944feace24
Author: Alexei Starovoitov <ast@kernel.org>

bpf: Verify programs as a fixpoint over the control flow graph

This commit switches the BPF verifier from path-by-path exploration to a
fixpoint iteration over the control flow graph, joining states at basic
block boundaries and inserting runtime loop guards for loops without
known bounds.

> diff --git a/kernel/bpf/states.c b/kernel/bpf/states.c
> index 9d3a86b5820e9..4b2506f3e3e27 100644
> --- a/kernel/bpf/states.c
> +++ b/kernel/bpf/states.c
[ ... ]
> @@ -872,16 +873,19 @@ static bool stack_arg_safe(struct bpf_verifier_env =
*env, struct bpf_func_state *
>  			   struct bpf_func_state *cur, struct bpf_idmap *idmap,
>  			   enum exact_level exact)
>  {
> -	int i, nslots, cur_cnt =3D cur->out_stack_arg_cnt;
> +	int i, nslots, cur_cnt =3D cur->out_stack_arg_cnt;
> =20
> -	nslots =3D max(old->out_stack_arg_cnt, cur->out_stack_arg_cnt);
> +	/* incoming arguments are not compared with outgoing ones, the other wa=
y is ruled out */
> +	if (bpf_stack_args_are_incoming(cur) && !bpf_stack_args_are_incoming(ol=
d))
> +		cur_cnt =3D 0;
> +	nslots =3D max(old->out_stack_arg_cnt, cur_cnt);
>  	for (i =3D 0; i < nslots; i++) {
>  		struct bpf_reg_state *old_arg, *cur_arg;
>  		struct bpf_reg_state not_init =3D { .type =3D NOT_INIT };
> =20
>  		old_arg =3D i < old->out_stack_arg_cnt ?
>  			  &old->stack_arg_regs[i] : &not_init;
> -		cur_arg =3D i < cur->out_stack_arg_cnt ?
> +		cur_arg =3D i < cur_cnt ?
>  			  &cur->stack_arg_regs[i] : &not_init;
>  		if (!regsafe(env, old_arg, cur_arg, idmap, exact))
>  			return false;

[Severity: Medium]
Here in stack_arg_safe(), slots beyond old->out_stack_arg_cnt are treated
as NOT_INIT and therefore subsume any slot in cur, even when
old->out_stack_arg_cnt < cur->out_stack_arg_cnt.

However, when joining or widening states in kernel/bpf/join.c:join_func():

    if (fa->out_stack_arg_cnt < fb->out_stack_arg_cnt)
        return false;

When a function writes outgoing stack arguments for a call inside a loop
body or branch, check_stack_arg_write() grows state->out_stack_arg_cnt, and
invalidate_outgoing_stack_args() after the call resets stack_arg_regs[i]
to NOT_INIT while keeping state->out_stack_arg_cnt > 0.

When that post-call state (fb, with out_stack_arg_cnt > 0) is later joined
or widened into an earlier state at a loop header or merge point (fa, with
out_stack_arg_cnt =3D=3D 0), won't join_func() unconditionally reject the j=
oin?

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 8b26bf625e5f5..227bb613176ad 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
[ ... ]
> @@ -1605,9 +1617,14 @@ static int acquire_irq_state(struct bpf_verifier_e=
nv *env, int insn_idx)
> =20
>  static void release_reference_state(struct bpf_verifier_state *state, in=
t idx)
>  {
> -	int last_idx;
> +	int last_idx, fr;
>  	size_t rem;
> =20
> +	/* the frames that were entered with it don't hold it ever since */
> +	for (fr =3D 0; fr <=3D state->curframe; fr++)
> +		if (idx < state->frame[fr]->entry_refs)
> +			state->frame[fr]->entry_refs--;
> +
>  	/* IRQ state requires the relative ordering of elements remaining the
>  	 * same, since it relies on the refs array to behave as a stack, so that
>  	 * it can detect out-of-order IRQ restore. Hence use memmove to shift

[Severity: High]
When release_reference_state() releases a reference at idx and shifts
state->refs[] down via memmove(), it decrements state->frame[fr]->entry_refs
if idx < entry_refs, but should it also decrement
state->frame[fr]->loop_stack[i].refs when idx < loop_stack[i].refs (and
should loop_stack_safe() in kernel/bpf/states.c also check
old_stack[i].refs =3D=3D cur_stack[i].refs)?

In loop_stack_push(), loop_stack[cnt].refs is set to
env->cur_state->acquired_refs upon entering a loop. On a backedge,
bpf_flow_loop_enter()->check_refs_taken_in_loop() checks for leaked
references acquired in the loop by scanning from entry->refs:

    for (i =3D entry->refs; i < st->acquired_refs; i++) {
        if (st->refs[i].type !=3D REF_TYPE_PTR)
            continue;
        ...
    }

If a reference acquired before the loop (idx < entry->refs) is released
inside the loop and a new reference is acquired inside the loop without
being released, memmove() shifts the new in-loop reference to index
entry->refs - 1 while entry->refs stays unchanged, causing
check_refs_taken_in_loop() to skip it on the backedge.

[ ... ]
> @@ -3459,7 +3482,17 @@ static int check_unwind_insns(struct bpf_verifier_=
env *env)
>  	bool seen =3D false;
>  	int i;
> =20
> +	for (i =3D 0; i < env->subprog_cnt; i++)
> +		env->subprog_info[i].bail_insn =3D -1;
> +
>  	for (i =3D 0; i < env->prog->len; i++, insn++) {
> +		if (bpf_is_ldimm64(insn)) {
> +			i++;
> +			insn++;
> +			continue;
> +		}
> +		if (insn->code =3D=3D (BPF_JMP | BPF_EXIT))
> +			bpf_find_containing_subprog(env, i)->bail_insn =3D i;
>  		if (bpf_is_unwind_exit(insn)) {
>  			bpf_find_containing_subprog(env, i)->can_unwind =3D true;
>  			seen =3D true;

[Severity: Medium]
check_unwind_insns() runs before bpf_compute_const_regs() and
bpf_prune_dead_branches(), recording the last BPF_EXIT in each subprogram
as bail_insn.

If a subprogram has two BPF_EXIT instructions and the second one is in a
branch that gets pruned by bpf_prune_dead_branches(), bail_insn will not be
in env->cfg.insn_postorder, so bpf_compute_live_registers() leaves
live_regs_before as 0 at bail_insn.

When check_loop_guard()->push_budget_exit() later sets R0 =3D 0 and pushes a
state to sub->bail_insn, flow_arrive()->bpf_clean_verifier_state() scrubs R0
to NOT_INIT because live_regs_before is 0, causing check_return_code() at
bail_insn to fail with -EACCES. Additionally, if bail_insn is in an
unreached branch, verifying the synthetic state from push_budget_exit() at
bail_insn runs sanitize_mark_insn_seen(env), marking the dead BPF_EXIT as
seen. Should bail_insn be selected after dead branch pruning, or handled
without marking the target instruction as seen?

[ ... ]
> +static int check_loop_guard(struct bpf_verifier_env *env)
> +{
> +	struct bpf_insn_aux_data *aux =3D &env->insn_aux_data[env->insn_idx];
> +	struct bpf_verifier_state *branch;
> +	struct bpf_func_state *frame =3D cur_func(env);
> +	struct loop_stack_entry *entry;
> +	struct bpf_loop *loop;
> +	int h, err;
> +
> +	h =3D bpf_loop_at_index(env, env->insn_idx);
> +	/* The callback came back to the helper that calls it: the program is n=
ot in front of it. */
> +	if (h < 0 || !frame->loop_stack_cnt || frame->callback_depth)
> +		return 0;
> +	loop =3D env->insn_aux_data[h].loop;
> +	entry =3D &frame->loop_stack[frame->loop_stack_cnt - 1];
> +	if (loop->rt_bounded || !env->insn_aux_data[env->insn_idx].guard_place =
||
> +	    entry->loop_id !=3D h)
> +		return 0;
> +	if (verifier_bug_if(!entry->terminates && !entry->guarded, env,
> +			    "nothing stops the loop at %d", h))
> +		return -EFAULT;
> +	if (!entry->guarded && !bpf_loop_walk_may_give_up(entry))
> +		return 0;
> +
> +	/* the device runs the insns that the driver was given, without may_got=
o */
> +	if (bpf_prog_is_offloaded(env->prog->aux)) {
> +		verbose(env, "loop at insn %d has no known bound in an offloaded progr=
am\n", h);
> +		return -EINVAL;
> +	}

[Severity: Medium]
When a loop is not counted by SCEV, bpf_flow_loop_enter() starts a patience
walk via flow_try_walk() with entry->guarded =3D=3D false and
bpf_loop_walk_may_give_up(entry) =3D=3D true. If the walk finishes within i=
ts
patience budget, no may_goto is needed or inserted.

Because check_loop_guard() checks bpf_prog_is_offloaded(env->prog->aux)
before checking whether entry->guarded is true, won't an offloaded program
be rejected on the first iteration of a patience walk even when the walk
would complete normally without needing may_goto?

> +
> +	/*
> +	 * A guard has one way out, and only that one is looked at.
> +	 *
> +	 * Leave the subprog, if that is possible every time the program gets h=
ere:
> +	 *	do { p =3D lookup(); } while (!p); *p
> +	 * The code that follows the loop counts on what the jump that leaves i=
t has found out.
> +	 *
> +	 * Otherwise leave the loop:
> +	 *	lock(); do { ... } while (...); unlock();
> +	 * The code that follows the loop releases what is held.
> +	 *
> +	 * It's the same way for all states that get here. As long as they leav=
e the subprog
> +	 * what would leave the loop is dropped. Both are dropped as long as th=
e loop has
> +	 * no may_goto: the state is in a walk that may get to the end of the l=
oop.
> +	 */
> +	if (!aux->guard_no_unwind && !budget_can_unwind(env, env->cur_state)) {
> +		aux->guard_no_unwind =3D true;
> +		/* What would leave the loop from the states that were here is gone. A=
ll again. */
> +		if (aux->guard_edge_dropped && loop->guarded)
> +			env->guards_late =3D true;
> +	}
> +	if (!aux->guard_no_unwind) {
> +		err =3D push_budget_exit(env);
> +		if (err)
> +			return err;
> +		env->head->guard_edge =3D BPF_GUARD_LEAVES_SUBPROG;
> +	}
> +
> +	branch =3D push_stack(env, env->insn_aux_data[env->insn_idx].guard_to, =
env->insn_idx, false);
> +	if (IS_ERR(branch))
> +		return PTR_ERR(branch);
> +	env->head->guard_edge =3D BPF_GUARD_LEAVES_LOOP;
> +	return 0;
> +}

[Severity: High]
When a loop has no dominating exit condition, flow_place_guards() sets
guard_place and guard_at_header at the loop header, and check_loop_guard()
pushes a synthetic BPF_GUARD_LEAVES_LOOP edge from the loop header to
guard_to.

While bpf_compute_const_regs(), compute_subprog_args(), and
bpf_compute_live_registers() account for t =3D bpf_head_guard_target(env, i=
dx),
kernel/bpf/liveness.c:update_insn() and
kernel/bpf/flow.c:flow_compute_need_const() only iterate over
bpf_insn_successors(env, idx):

kernel/bpf/liveness.c:update_insn() {
    succ =3D bpf_insn_successors(env, insn_idx);
    if (succ->cnt =3D=3D 0)
        return false;

    for (s =3D 0; s < succ->cnt; ++s) {
        unsigned long *succ_live;

        succ_live =3D rel_mask(fm, relative_idx(instance, succ->items[s]), =
FM_LIVE_BEFORE);
        for (w =3D 0; w < fm->words; w++)
            new_after[w] |=3D succ_live[w];
    }
}

If a stack slot (such as fp-8) holds a value or a spilled kernel pointer
before the loop header h, is overwritten on all normal in-loop paths before
reaching guard_to (setting FM_MUST_WRITE inside the loop), and is read at
or after guard_to (setting FM_LIVE_BEFORE at guard_to), update_insn() does
not propagate FM_LIVE_BEFORE across bpf_head_guard_target(env, h), so fp-8
is marked dead at h.

When a state arrives at h, flow_arrive()->bpf_clean_verifier_state() marks
fp-8 as STACK_POISON and clears spilled_ptr. check_loop_guard() then pushes
this poisoned state from h to guard_to (when aux->guard_no_unwind is true,
e.g. while holding a lock, reference, or RCU read lock across the loop).

At guard_to:
1. If !env->allow_uninit_stack or no other state joins at guard_to, reading
   fp-8 fails verification with "slot poisoned by dead code elimination".
2. If env->allow_uninit_stack is true and the header guard state joins at
   guard_to with a normal loop-exit state that overwrote fp-8 with a scalar
   (STACK_SPILL scalar, STACK_MISC, or STACK_ZERO), join_slot() in
   kernel/bpf/join.c merges that slot with STACK_POISON into STACK_INVALID.
   Subsequent stack reads at guard_to then treat fp-8 as an initialized
   SCALAR_VALUE, even though at runtime the may_goto inserted at h jumps
   directly to guard_to with the original pre-loop kernel pointer still in
   fp-8.

Should update_insn() and flow_compute_need_const() also propagate across
bpf_head_guard_target()?

[ ... ]
> @@ -21669,6 +21854,10 @@ static int do_check(struct bpf_verifier_env *env)
>  		if (state->speculative && insn_aux->nospec)
>  			goto process_bpf_exit;
> =20
> +		err =3D check_loop_guard(env);
> +		if (err)
> +			return err;
> +
>  		err =3D do_check_insn(env, &do_print_state);
>  		if (error_recoverable_with_nospec(err) && state->speculative) {
>  			/* Prevent this speculative path from ever reaching the
> @@ -21690,19 +21879,9 @@ static int do_check(struct bpf_verifier_env *env)
>  		}
> =20
>  		if (state->speculative && insn_aux->nospec_result) {
[ ... ]
>  process_bpf_exit:
>  			account_current_path(env);
>  			mark_verifier_state_scratched(env);
> -			err =3D bpf_update_branch_counts(env, env->cur_state);
> -			if (err)
> -				return err;
> -			err =3D pop_stack(env, &prev_insn_idx, &env->insn_idx,
> -					pop_log);
> -			if (err < 0) {
> -				if (err !=3D -ENOENT)
> -					return err;
> -				break;
> -			} else {
> -				do_print_state =3D true;
> -				continue;
> -			}
> +			bpf_free_verifier_state(state, false);
> +			memset(state, 0, sizeof(*state));
> +			return flow_drain(env);
> +		}

[Severity: Medium]
When state->speculative is true and do_check_insn() fails with a
recoverable error, do_check_block() sets insn_aux->nospec =3D true to place=
 a
speculation barrier before env->insn_idx and jumps to process_bpf_exit.

However, check_loop_guard() has already run before do_check_insn() (and
do_check_insn() itself may have pushed branches onto env->head before
failing, such as in push_callback_call() or check_kfunc_call() for
KF_bpf_res_spin_lock), and process_bpf_exit then calls flow_drain(env),
delivering all states queued on env->head instead of discarding them.

Should check_loop_guard() be skipped or should states pushed during the
aborted speculative instruction be discarded before jumping to
process_bpf_exit?

[ ... ]
> @@ -23118,6 +23317,44 @@ static int do_check_main(struct bpf_verifier_env=
 *env)
>  	return ret;
>  }
> =20
> +/*
> + * What stops a loop is assumed before the main pass and checked in it, =
see flow_is_bound(). The
> + * main prog and global functions may get to the same loop. It has may_g=
oto for all of them or
> + * for none, so all are done again when the assumption doesn't hold, wha=
tever came out.
> + * The same when a loop gets may_goto, or its may_goto gets another way =
out, and what went through
> + * the loop before is not there any more, see bpf_flow_loop_gets_guards(=
).
> + *
> + * A round that is dropped counts as paths that never run. What it found=
 out about the insns, the
> + * subprogs and the prog stays. Each of these is made for more than one =
state that gets to an insn:
> + * it grows to the safe side, or another value is refused, or the last o=
ne that gets there sets it.
> + * Where the round got to is dropped with its verdict: the passes that f=
ollow take an insn that was
> + * seen for one that passed its checks, and a function that is called ha=
s to be safe.
> + */
> +static int do_check_all(struct bpf_verifier_env *env)
> +{
> +	struct bpf_func_info_aux *sub_aux;
> +	u64 log_pos =3D env->log.end_pos;
> +	int i, ret;
> +
> +	for (;;) {
> +		bpf_flow_new_round(env);
> +		ret =3D do_check_main(env);
> +		ret =3D ret ?: do_check_subprogs(env);
> +		if (!(env->restart && bpf_flow_loops_lost_bound(env)) && !env->guards_=
late)
> +			return ret;
> +		/* the log is dropped when a function is found to be safe */
> +		bpf_vlog_reset(&env->log, min(log_pos, env->log.end_pos));
> +		for (i =3D 0; i < env->prog->len; i++)
> +			env->insn_aux_data[i].seen =3D 0;
> +		for (i =3D 1; env->prog->aux->func_info && i < env->subprog_cnt; i++) {
> +			sub_aux =3D subprog_aux(env, i);
> +			memset(sub_aux->called, 0, sizeof(sub_aux->called));
> +			memset(sub_aux->verified, 0, sizeof(sub_aux->verified));
> +			sub_aux->called_with_pkt_ptrs =3D false;
> +		}
> +	}
> +}

[Severity: Medium]
Two questions about restarting a round in do_check_all():

1. During a round, bpf_flow_guard_edge() sets aux[prev_insn_idx].loop_guard=
 =3D true.
   When a round is restarted, do_check_all() clears aux[i].seen =3D 0 and
   bpf_flow_new_round() clears aux[i].guard_edge_dropped, but neither
   clears aux[i].loop_guard. If an instruction had loop_guard set in the
   first round on a path that becomes unreachable in the next round (leaving
   aux[i].seen =3D=3D 0), won't bpf_insert_loop_guards() and append_budget_=
exit()
   still patch a may_goto at that dead instruction and force seen =3D 1 on =
the
   appended budget exit instructions?

2. If env->guards_late or env->restart was set earlier in the round and
   do_check_main() or do_check_subprogs() subsequently aborts with a fatal
   error such as -EAGAIN, -ENOMEM, or -EFAULT, should do_check_all() return
   ret immediately rather than resetting the log and starting another round?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105204513.2230=
344-1-alexei.starovoitov@gmail.com?part=3D19
