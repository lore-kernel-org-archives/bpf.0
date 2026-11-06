Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793940959;
	b=AxM1UjkUXowYqaTLrQmCcCnP6g0x1a1I8f1yigTrsI9qaXl1jHefIlAGJaWPkkk7pahC
	 ynzoxnl+bXRrBuzjIWGOC01Ws6ZVtKp0oLs5uC00QmrE694tCPf4N6Oomrx2IouyJW1uV
	 hqoWMnNV3P7IKruUpPzonPAETe6L05sQo62BFlz9GRgvH1lUiGEiWne+bC5mYdIM3e6j9
	 lU0rN7FxyKKv7ZDKihY6XwURoLX/864ljLc2wIos6ENsRLUjGX5MUmyvYhFOAgfMUVYV9
	 f4BkNYjQySdBhGQXzsINr27kEFxNw/ycnEfT4fFTF8ghd7+Eoyfk+3YLnhW1bSiLL8Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793940959;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=KLvkwZRa6hwMcN/vOTx5oBmLhbTRFW1LdDCbU6C5d2E=;
	b=Nm2Pz9zAzajZQZXnpbTpH4bKh8C+5QJivS8F+MRhJp3SpKZv3WCiHmr4TvbFlVVA5QqT
	 Jj8R3elBa5kvmaYlW8pVQPdnqEZiUPv8MxHCpOaiLL4r8KTbtdwopFcTRKD4yR1Mapz06
	 2oyinIrnqECH6KW60g8v9IGxz0EvHw0RzcDygoaqd5LxWbdP5UbpLmc4YqHjyQDXjKmhd
	 FrNOy9QzPNk5b5zE/NMNEjqb9XEUXjUjTUyR+F4PC1MzI1e2TBEd5XA2sP5YK8rnFg+Xk
	 RjRYRT9faFQI65U33htWqHpvMT2SqoHmP66tlYyvivRjyUeOZlke6z4CqmxBE16PuQA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MY1K2f4r;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AA61606A31B
	for <bpf@vger.kernel.org>; Fri,  6 Nov 2026 04:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MY1K2f4r
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEC571F008A1;
	Fri,  6 Nov 2026 04:55:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793940959;
	bh=KLvkwZRa6hwMcN/vOTx5oBmLhbTRFW1LdDCbU6C5d2E=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=MY1K2f4rT5EHy48TfBF9BKFkfrbudUyVqWuekpsZviEECvVZPm2sWgWEWFRbBDiHG
	 31ZzyQ9XdYk3FH6eaFfwfEmdaaDVcoQIYm4qONJ0ki3pnSMjVBii+jTK4LuFGsXMxb
	 b7/3E2xbVyO8jSzIiQ2H7ou2rTRPVH00gXNtcrYKUA5mFivBIeLlL/Jo42tXcWMcUl
	 0gX+9EWts+c4b2MaawBO3mks2/8rVXUCu8WI67Bqb1Xr52jcC1MTTckA9ERW8g7HdG
	 ywvCaWSraN2xlWC3KTnojq09bELCJ+oo1MS2TIrOGJVxhNzv638MNHa5Eb3nmGl7co
	 0qTxPjjCi3Kfg==
Message-ID: <sashiko-outbox-200780@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v3 19/45] bpf: Verify programs as a fixpoint
 over the control flow graph
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
In-Reply-To: <20261106035111.3315285-20-alexei.starovoitov@gmail.com>
References: <20261106035111.3315285-1-alexei.starovoitov@gmail.com>
 <20261106035111.3315285-20-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 04:55:58 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:
- [High] bpf: missing bpf_head_guard_target() edge in update_insn() and nee=
d_const
- [High] bpf: missing loop_stack refs update in release_reference_state()
- [Medium] bpf: join_func() and func_states_equal() reject post-call stack =
arg states
- [Medium] bpf: unreset loop_guard flag and ignored fatal errors in do_chec=
k_all()
- [Medium] bpf: do_check_block() mishandles nospec ordering with check_loop=
_guard()
- [Medium] bpf: check_loop_guard() rejects offloaded progs during patience =
walk
--

commit 2c82419db13e7e33be1c8b05f84811e97169e868
Author: Alexei Starovoitov <ast@kernel.org>

bpf: Verify programs as a fixpoint over the control flow graph

This commit replaces path-by-path exploration in the BPF verifier with a
fixpoint iteration over the control flow graph that joins states at merge
points. It also adds loop guard injection and bounded patience walks for
loops without statically known trip counts.

> diff --git a/kernel/bpf/flow.c b/kernel/bpf/flow.c
> index c4a6384d34bce..62115e396635a 100644
> --- a/kernel/bpf/flow.c
> +++ b/kernel/bpf/flow.c
> @@ -1024,7 +1024,7 @@ static int flow_compute_need_const(struct bpf_verif=
ier_env *env, struct flow_nee
>  		if (jump)
>  			gen[i] =3D flow_tested_regs(env, i);
>  		else if (flag)
> -			gen[i] =3D flow_flag_regs(env, i);
> +			gen[i] =3D bpf_flow_flag_regs(env, i);

[Severity: High]
As reported by Sashiko on v2 [1], when a loop has no dominating exit
condition and flow_place_guards() places a guard at the loop header h with
aux[h].guard_at_header =3D true and aux[h].guard_to =3D t, check_loop_guard=
()
pushes the state at h along a synthetic BPF_GUARD_LEAVES_LOOP edge to t when
aux->guard_no_unwind is true (for example, when a lock, reference, or RCU
read lock is held across the loop).

While bpf_compute_const_regs(), analyze_subprog(), bpf_flow_compute_kinds(),
and bpf_compute_live_registers() account for t =3D bpf_head_guard_target(en=
v,
idx), update_insn() in kernel/bpf/liveness.c and flow_compute_need_const() =
in
kernel/bpf/flow.c only propagate across bpf_insn_successors(env, idx):

kernel/bpf/liveness.c:update_insn() {
	succ =3D bpf_insn_successors(env, insn_idx);
	if (succ->cnt =3D=3D 0)
		return false;

	/* All instructions of one frame array share the same mask width */
	for (s =3D 0; s < succ->cnt; ++s) {
		unsigned long *succ_live;

		succ_live =3D rel_mask(fm, relative_idx(instance, succ->items[s]), FM_LIV=
E_BEFORE);
		for (w =3D 0; w < fm->words; w++)
			new_after[w] |=3D succ_live[w];
	}
}

If a stack slot holds a value or spilled kernel pointer before entering loop
header h, is overwritten on all normal in-loop CFG paths to t (setting
FM_MUST_WRITE), and is read at or after t, update_insn() does not union
FM_LIVE_BEFORE from t =3D bpf_head_guard_target(env, h) into new_before at =
h,
leaving the slot marked dead at h.

When a state arrives at h in bpf_flow_deliver() -> flow_arrive(),
bpf_clean_verifier_state() clears the dead slot's spilled_ptr to NOT_INIT a=
nd
marks slot_type as STACK_POISON before check_loop_guard() pushes that state
from h to t. At t, reading the slot fails with a false-positive poisoned sl=
ot
error when !env->allow_uninit_stack, or if env->allow_uninit_stack is true
and the header guard state joins at t with a normal loop-exit state where t=
he
slot was overwritten with a scalar, join_slot() in kernel/bpf/join.c turns
STACK_MISC/STACK_ZERO + STACK_POISON into STACK_INVALID. Can this allow
check_stack_read_fixed_off() at t to read back the unoverwritten kernel
pointer spilled before h as an unbounded SCALAR_VALUE when the header
may_goto guard triggers at runtime, and should update_insn() and
flow_compute_need_const() also propagate from bpf_head_guard_target()?

[ ... ]

> diff --git a/kernel/bpf/states.c b/kernel/bpf/states.c
> index 9d3a86b5820e9..4b2506f3e3e27 100644
> --- a/kernel/bpf/states.c
> +++ b/kernel/bpf/states.c

[ ... ]

> @@ -999,9 +1026,19 @@ static bool func_states_equal(struct bpf_verifier_e=
nv *env, struct bpf_func_stat
>  	if (!old->no_stack_arg_load && cur->no_stack_arg_load)
>  		return false;

[Severity: Medium]
As reported by Sashiko on v2 [2], every function frame starts with
no_stack_arg_load =3D false and out_stack_arg_cnt =3D 0, and do_check_insn(=
) only
calls end_stack_arg_loads() on BPF_CALL when bpf_in_stack_arg_cnt() is
non-zero.

When a path writes an outgoing stack argument in check_stack_arg_write(),
end_stack_arg_loads() sets state->no_stack_arg_load =3D true and
grow_stack_arg_slots() increases state->out_stack_arg_cnt. After the call
finishes, invalidate_outgoing_stack_args() resets all state->stack_arg_regs=
[i]
to NOT_INIT, but state->out_stack_arg_cnt remains at its grown value.

When this post-call state arrives at a loop header or merge point where an
earlier pre-call state (with fa->out_stack_arg_cnt =3D=3D 0 and
fa->no_stack_arg_load =3D=3D false) is stored:

1. func_states_equal() rejects !old->no_stack_arg_load &&
   cur->no_stack_arg_load even when the subprogram has no incoming stack
   arguments.
2. join_func() in kernel/bpf/join.c rejects fa->out_stack_arg_cnt <
   fb->out_stack_arg_cnt:

kernel/bpf/join.c:join_func() {
	if (fa->out_stack_arg_cnt < fb->out_stack_arg_cnt)
		return false;
}

Does this prevent joining, widening, and state subsumption whenever a call
with stack arguments occurs inside a loop or on one side of a branch?

[ ... ]

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 5af42d2dcab94..4801e9ac0089d 100644
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

[Severity: High]
As reported by Sashiko on v2 [3], loop_stack_push() records
env->cur_state->acquired_refs in loop_stack[cnt].refs when entering a loop,
and check_refs_taken_in_loop() scans from i =3D entry->refs to
st->acquired_refs at loop backedges to ensure references acquired inside the
loop are still held in a register or stack slot.

When release_reference_state() removes state->refs[idx] and shifts the
remaining entries down with memmove(), it decrements
state->frame[fr]->entry_refs if idx < entry_refs, but it does not decrement
state->frame[fr]->loop_stack[l].refs when idx < loop_stack[l].refs.

If a program acquires a reference before entering a loop, releases that
pre-loop reference inside the loop, and then acquires a new reference inside
the loop and leaks it before taking the backedge, memmove() shifts the
in-loop reference down to index entry->refs - 1 while entry->refs stays
unchanged. Can this cause check_refs_taken_in_loop() to miss the leaked
in-loop reference at the backedge, and should loop_stack_safe() in
kernel/bpf/states.c also check old_stack[i].refs =3D=3D cur_stack[i].refs to
match join_loop_stack()?

[ ... ]

> @@ -21581,14 +21663,174 @@ int bpf_flow_loop_enter(struct bpf_verifier_en=
v *env, bool *backedge, bool *drop

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
As reported by bot+bpf-ci@kernel.org on v2 [4], when bpf_compute_loop_iters=
()
returns 0 and bpf_flow_loop_enter() starts a patience walk via
flow_try_walk(), entry->apart =3D true, entry->terminates =3D true,
entry->counted =3D false, and entry->guarded remains false unless the walk =
later
gives up.

Because bpf_loop_walk_may_give_up(entry) is true during the walk, doesn't
check_loop_guard() reject offloaded programs with -EINVAL on the very first
iteration of the walk, before the walk has a chance to reach the end of the
loop without needing may_goto?

[ ... ]

> @@ -21747,6 +21937,10 @@ static int do_check(struct bpf_verifier_env *env)
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
> @@ -21768,19 +21962,9 @@ static int do_check(struct bpf_verifier_env *env)
>  		}
> =20
>  		if (state->speculative && insn_aux->nospec_result) {
> -			/* If we are on a path that performed a jump-op, this
> -			 * may skip a nospec patched-in after the jump. This can
> -			 * currently never happen because nospec_result is only
> -			 * used for the write-ops
> -			 * `*(size*)(dst_reg+off)=3Dsrc_reg|imm32` and helper
> -			 * calls. These must never skip the following insn
> -			 * (i.e., bpf_insn_successors()'s opcode_info.can_jump
> -			 * is false). Still, add a warning to document this in
> -			 * case nospec_result is used elsewhere in the future.
> -			 *
> -			 * All non-branch instructions have a single
> -			 * fall-through edge. For these, nospec_result should
> -			 * already work.
> +			/*
> +			 * All non-branch instructions have a single fall-through
> +			 * edge. For these, nospec_result should already work.
>  			 */
>  			if (verifier_bug_if((BPF_CLASS(insn->code) =3D=3D BPF_JMP ||
>  					     BPF_CLASS(insn->code) =3D=3D BPF_JMP32) &&
> @@ -21790,23 +21974,40 @@ static int do_check(struct bpf_verifier_env *en=
v)
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
As reported by bot+bpf-ci@kernel.org on v2 [5], when bpf_insert_loop_guards=
()
prepends a may_goto sequence in front of a guarded instruction,
patch_list_adj_aux() in kernel/bpf/fixups.c copies old->nospec onto the last
instruction of the patch (the original instruction after may_goto), so at
runtime the injected may_goto executes before the BPF_ST_NOSPEC() barrier.

In do_check_block(), however, the early exit on state->speculative &&
insn_aux->nospec runs before check_loop_guard(env), and do_check_all() does
not clear insn_aux->nospec across rounds. Once insn_aux->nospec is set on t=
he
guarded instruction, won't subsequent speculative states reaching it jump to
process_bpf_exit before check_loop_guard() and skip verifying the speculati=
ve
may_goto branch?

Conversely, when insn_aux->nospec is not yet set and do_check_insn() fails
with a recoverable error on a speculative path, jumping to process_bpf_exit
calls flow_drain(env), which delivers any states pushed onto env->head by t=
he
failed do_check_insn() call (such as other_branch pushed in
check_cond_jmp_op() before regs_bounds_sanity_check_branches() fails, or
callback states pushed in push_callback_call() before a later check fails).
Shouldcheck_loop_guard() run before the insn_aux->nospec check, and should
states pushed by a failed speculative do_check_insn() be discarded instead =
of
drained?

[ ... ]

> @@ -23196,6 +23400,44 @@ static int do_check_main(struct bpf_verifier_env=
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
As reported by Sashiko on v2 [6], when do_check_all() restarts verification
for a new round, it clears env->insn_aux_data[i].seen =3D 0 and calls
bpf_flow_new_round(env), which resets guard_edge_dropped and no_guard_edges,
but neither resets env->insn_aux_data[i].loop_guard =3D false (or
env->total_states).

If bpf_flow_guard_edge() sets aux[i].loop_guard =3D true during round 1 on a
path or static subprogram that becomes unreachable in round 2,
bpf_insert_loop_guards() and append_budget_exit() in kernel/bpf/fixups.c wi=
ll
still see aux[i].loop_guard =3D=3D true even though aux[i].seen =3D=3D 0, p=
atching
may_goto at a dead instruction and setting seen =3D 1 on the appended budget
exit instructions of an otherwise dead subprogram.

In addition, if a fatal error such as -EAGAIN, -ENOMEM, -EFAULT, or -E2BIG
occurs after env->guards_late or env->restart was set earlier in the round,
won't do_check_all() ignore ret, reset the verifier log, and start another
round instead of returning the error immediately?

[1] https://lore.kernel.org/r/20261105204513.2230344-20-alexei.starovoitov@=
gmail.com
[2] https://lore.kernel.org/r/20261105204513.2230344-20-alexei.starovoitov@=
gmail.com
[3] https://lore.kernel.org/r/20261105204513.2230344-20-alexei.starovoitov@=
gmail.com
[4] https://lore.kernel.org/r/30511ed9caaa7fab02343ad6adbd72f0c7d689b7ae89d=
4b0c37bdf2beb45a414@mail.kernel.org
[5] https://lore.kernel.org/r/30511ed9caaa7fab02343ad6adbd72f0c7d689b7ae89d=
4b0c37bdf2beb45a414@mail.kernel.org
[6] https://lore.kernel.org/r/20261105204513.2230344-20-alexei.starovoitov@=
gmail.com

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106035111.3315=
285-1-alexei.starovoitov@gmail.com?part=3D19
