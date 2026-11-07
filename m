Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794026458;
	b=1YIBv8fY5YZSJdiiBv/+NQzgqjlJrvJmbyi0XHemaJW836hXz970dNbLJrN8nyKvUAc+
	 I5k9OcGPGhBJh4bjiIi3uBOoTPWQDIRbUJ4yvCMe+w+Cjdq0FLSV0z9QoNHrGvNsv8Wxv
	 8p85k77dOQw09+v4bSq5sHqn3Gfsq50xUDqzWIzP2IMNzW4VRrdIFJQCgaL9JXi1zWHYs
	 RKp0tWk1Bxkqh6n8Fk7oOm97abcla7BtznEZge8YrnBpl2yduG9KXJNMsGwUmClELrq18
	 sGlkU1PPPg6fgdKXAB7Mv2/ZSfTf3vMPEbM4kHeUkbgCRqaa9UXhRIY/HWz2Bge2S4A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794026458;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=6dXHgkk7eTDJutniuxJ3bS6l/JkQKVzYKtKi795mQok=;
	b=nB7kM3KKHUdLWawxISKO4X1eH8qp3G9tTyFDcS621i/c9Cn+aEeeLV5//Hf1kl4D9Fvr
	 c1qi0v6+h/M8wRl/E6G3aSX2nEIHfMnMehMxTmyVm9HpiOi+gpc5EmWyT2l7nADk0y+JC
	 m/PmaXKIu4OJD/P1bShM1hYta7LHQigve3cJTwGmyrjDCcEEu4VxKeHR+T7a/0lbreKiO
	 9WvoMLHihKdA4vc77EvceIqHbAYbs71yexUQ8XE1k33qSrt84c5Uxy3+wj/36mxCZ7AS8
	 wzXwAGlMjiB1vplPt7vN2mIOHVM9ILxZI3YKIDHeZZQLv4baccCknkjRsXILBRIpmTw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GHy4v95R;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBF09606A326
	for <bpf@vger.kernel.org>; Sat,  7 Nov 2026 04:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GHy4v95R
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43F1F1F0089F;
	Sat,  7 Nov 2026 04:40:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794026457;
	bh=6dXHgkk7eTDJutniuxJ3bS6l/JkQKVzYKtKi795mQok=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=GHy4v95R/Ep0iRf1B6OSLmwFCFhgGH2fucP1EuQSK3q/V70FhCcytbCbhm3F5N/fn
	 cj7nIS3B/6o1ZKUSK2az3MT0Vcxp9mu3K8pR5c/j/aVryrl9JWQA3nOpYRr5TuYXuj
	 j1DGvYkcJMf7gMTxwCfKFf9c/TCfkF+386ygZwbE1Q2Qya7M7L+u1/X++3jbKH4PPO
	 wM9WMKA1NoQQu36rWbjcI3sq5LdxkL6BEVP0gJ84Cu+Dp4BCFr/JokO97iSN+l+5q9
	 buU/2j3SXaLOg0k5F+nhrEUwqXm8Jqw9A7ogxPAvh0Ra+yln0e9/fH4ORJY/RqVAS3
	 39Ff+Uh7yOyEw==
Message-ID: <sashiko-outbox-202591@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v4 19/46] bpf: Verify programs as a fixpoint
 over the control flow graph
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
In-Reply-To: <20261107033758.1547725-20-alexei.starovoitov@gmail.com>
References: <20261107033758.1547725-1-alexei.starovoitov@gmail.com>
 <20261107033758.1547725-20-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 07 Nov 2026 04:40:55 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 6 potential
issues to consider:
- [High] bpf: missing loop_stack refs update in
  release_reference_state()
- [High] bpf: missing bpf_head_guard_target() edge in update_insn() and
  need_const
- [Medium] bpf: check_loop_guard() rejects offloaded progs during
  patience walk
- [Medium] bpf: unreset loop_guard flag and ignored fatal errors in
  do_check_all()
- [Medium] bpf: do_check_block() mishandles nospec ordering with
  check_loop_guard()
- [Medium] bpf: do_check_all() fails to reset sub_aux->unreliable on
  round restart
--

commit 493d8e622b4ec09b90d62f364aafffd0843d557b
Author: Alexei Starovoitov <ast@kernel.org>

bpf: Verify programs as a fixpoint over the control flow graph

This commit replaces path-by-path symbolic execution in do_check() with a
fixpoint iteration over basic blocks that joins compatible states and
inserts may_goto guards into loops without proven bounds.

> diff --git a/kernel/bpf/liveness.c b/kernel/bpf/liveness.c
> index 6a2ee407412b8..60296eb880dbe 100644
> --- a/kernel/bpf/liveness.c
> +++ b/kernel/bpf/liveness.c
> @@ -2837,6 +2837,11 @@ int bpf_compute_live_registers(struct bpf_verifier=
_env *env)
>  		 */
>  		insn_aux[i].zext_dst =3D def32 >=3D 0 && (mask_hi(out) & BIT(def32));
>  	}
> +	/* the exit that stands for 'r0 =3D 0; exit' may be dead code, see push=
_budget_exit() */
> +	for (i =3D 0; i < env->subprog_cnt; i++)
> +		if (env->subprog_info[i].bail_insn >=3D 0)
> +			insn_aux[env->subprog_info[i].bail_insn].live_regs_before |=3D
> +				BIT(BPF_REG_0) | (bpf_ret_reg_pair(env, i) ? BIT(BPF_REG_2) : 0);
> =20
>  out:
>  	kvfree(state);

[Severity: High]
While bpf_compute_live_registers() accounts for the synthetic edge from a
loop header to bpf_head_guard_target(env, insn_idx), do stack-slot liveness
in update_insn() and constant propagation in flow_compute_need_const() miss
that edge?

kernel/bpf/liveness.c:update_insn() {
    ...
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
    ...
}

When a loop has guard_at_header set and cannot unwind (for example, while a
lock or reference is held across the loop), check_loop_guard() pushes the
state at the loop header to guard_to before do_check_insn() runs at the
header.  If a stack slot is written before the loop, overwritten at the
header or on all in-loop paths to guard_to, and then read at guard_to,
update_insn() marks the slot dead at the loop header.
bpf_clean_verifier_state() in flow_arrive() then clears its spilled_ptr and
marks it STACK_POISON at the header before check_loop_guard() pushes that
state to guard_to.

At guard_to, reading the slot fails with "slot poisoned by dead code
elimination" on a valid program.  Moreover, when env->allow_uninit_stack is
set and the slot held a spilled pointer before the loop that in-loop paths
overwrite with a scalar, join_slot() joins STACK_POISON from the header
guard with the scalar slot into STACK_INVALID, allowing the pointer left on
the stack when may_goto fires at the header to be read as a scalar at
guard_to.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 62a58f38f4e22..0e35f4454c805 100644
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
Does release_reference_state() also need to decrement
state->frame[fr]->loop_stack[l].refs when idx <
state->frame[fr]->loop_stack[l].refs?

loop_stack_push() records env->cur_state->acquired_refs in
loop_stack[cnt].refs, and check_refs_taken_in_loop() scans from
entry->refs to st->acquired_refs - 1 at loop backedges:

kernel/bpf/verifier.c:check_refs_taken_in_loop() {
    ...
	for (i =3D entry->refs; i < st->acquired_refs; i++) {
		if (st->refs[i].type !=3D REF_TYPE_PTR)
			continue;
    ...
}

If a reference acquired before the loop (idx < entry->refs) is released
inside the loop and a new reference is acquired and leaked in the same
iteration, memmove() shifts the new reference down to entry->refs - 1 while
entry->refs stays unchanged, so check_refs_taken_in_loop() skips it at the
backedge.  In addition, loop_stack_safe() in kernel/bpf/states.c does not
check old_stack[i].refs =3D=3D cur_stack[i].refs (unlike join_loop_stack()).

[ ... ]

> @@ -21630,14 +21713,204 @@ int bpf_flow_loop_enter(struct bpf_verifier_en=
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
As reported by bot+bpf-ci@kernel.org on v2 [1], does check_loop_guard()
reject offloaded programs during a patience walk even when the walk would
finish without needing a may_goto?

When flow_try_walk() starts walking a loop that bpf_compute_loop_iters()
could not count, entry->guarded is false, but bpf_loop_walk_may_give_up()
is true so that check_loop_guard() can track guard_no_unwind and
guard_edge_dropped in case the walk later gives up.  Testing
bpf_prog_is_offloaded() before checking entry->guarded rejects the
offloaded program on the first trip of the walk, even if the walk would
reach the end of the loop and never add a may_goto.

[ ... ]

> @@ -21796,6 +22017,10 @@ static int do_check(struct bpf_verifier_env *env)
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

[ ... ]

> @@ -21839,23 +22054,40 @@ static int do_check(struct bpf_verifier_env *en=
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
As reported by bot+bpf-ci@kernel.org on v2 [2], should check_loop_guard()
run before the state->speculative && insn_aux->nospec exit, and should a
speculative instruction that aborts with insn_aux->nospec =3D true discard
states it pushed onto env->head instead of draining them?

When bpf_insert_loop_guards() prepends a may_goto sequence to a guarded
instruction, patch_list_adj_aux() keeps insn_aux->nospec on the original
instruction after the prepended may_goto jump.  At runtime, speculative
execution reaches the may_goto jump before the nospec barrier, but in
do_check_block() any speculative state reaching an instruction with
insn_aux->nospec already set (from an earlier path or a previous round in
do_check_all()) jumps to process_bpf_exit before check_loop_guard() can
verify the guard edge.

Conversely, when insn_aux->nospec is not yet set and do_check_insn() fails
with error_recoverable_with_nospec(err) on a speculative path, jumping to
process_bpf_exit calls flow_drain(env), which delivers both the guard
branch and any branch state pushed onto env->head by the aborted
do_check_insn() call before it failed.

[ ... ]

> @@ -23245,6 +23480,44 @@ static int do_check_main(struct bpf_verifier_env=
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

[Severity: Medium]
When do_check_all() restarts a verification round, should it also clear
env->insn_aux_data[i].loop_guard and stop immediately on fatal errors such
as -EAGAIN, -ENOMEM, -EFAULT, or -E2BIG?

bpf_flow_guard_edge() sets aux[prev_insn_idx].loop_guard =3D true during a
round, and neither bpf_flow_new_round() nor do_check_all() clears it.  If a
guard edge taken in round 1 is abandoned in round 2 renders an inner loop or
called static subprogram unreachable (seen =3D=3D 0), bpf_insert_loop_guard=
s()
still sees stale loop_guard =3D=3D true on those dead instructions, patches=
 in
may_goto, and appends 'r0 =3D 0; exit' with aux[i].seen =3D 1 forced on the
appended exit instructions.

Also, if env->guards_late or env->restart was set before do_check_main() or
do_check_subprogs() aborted with -EAGAIN (pending signal), -ENOMEM, -EFAULT
(verifier_bug), or -E2BIG (total_states limit), do_check_all() ignores ret,
wipes the error from env->log, and starts another round without resetting
env->total_states.

> +		for (i =3D 1; env->prog->aux->func_info && i < env->subprog_cnt; i++) {
> +			sub_aux =3D subprog_aux(env, i);
> +			memset(sub_aux->called, 0, sizeof(sub_aux->called));
> +			memset(sub_aux->verified, 0, sizeof(sub_aux->verified));
> +			sub_aux->called_with_pkt_ptrs =3D false;
> +		}
> +	}
> +}

[Severity: Medium]
Should this loop also reset sub_aux->unreliable =3D false when discarding a
round?

In a round that gets restarted (for example when a loop header guard first
pushes a state to guard_to and a later state at the header sets
aux->guard_unset_reg =3D true and env->guards_late =3D true), the stale sta=
te
pushed to guard_to can reach a subprogram call with mismatched registers
and cause btf_check_subprog_call() to set
prog->aux->func_info_aux[subprog].unreliable =3D true:

kernel/bpf/verifier.c:btf_check_subprog_call() {
    ...
	if (prog->aux->func_info_aux[subprog].unreliable)
		return -EINVAL;

	err =3D btf_check_func_arg_match(env, subprog, btf);
	if (err)
		prog->aux->func_info_aux[subprog].unreliable =3D true;
    ...
}

In the restarted round, btf_check_subprog_call() sees unreliable =3D=3D true
and immediately returns -EINVAL for a global function (or leaves a static
subprogram marked unreliable for fentry/fexit attachment), rejecting a
valid program after its diagnostic log was already wiped by
bpf_vlog_reset().

[1] https://lore.kernel.org/r/30511ed9caaa7fab02343ad6adbd72f0c7d689b7ae89d=
4b0c37bdf2beb45a414@mail.kernel.org
[2] https://lore.kernel.org/r/30511ed9caaa7fab02343ad6adbd72f0c7d689b7ae89d=
4b0c37bdf2beb45a414@mail.kernel.org

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261107033758.1547=
725-1-alexei.starovoitov@gmail.com?part=3D19
