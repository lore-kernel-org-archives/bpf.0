Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793918711;
	b=BjG4P2EcxPHZ5zS3T08vXOeKeQ3Z6JOBrIUbKpncVtuSe5+XRT+fnyVC9TRFSwNjqcoZ
	 FlCip4kRDKilPGSJRfkJazMZ1UJCNkUX93RbOD0A+PU3FuliGJS1pXIqZZRZyarfTu521
	 D2rMBDY+eBi7WNP0JvpmaF/0eIK/lpjhoPmAEo6VIb4NIS/I67xjRnC+ah0sKRWcT/biJ
	 3MBfL72LV6D1Bde/668o4xrwe15VIEs96lilOKTpi2IrGacIsaanQQOyFlPJH7n5YzYvu
	 NDMiUTJ580c6EJA7UdgtwU81lk0eTPax75qGFLahXrFj0x20uRLoU08Ez7tQWaQPlBA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793918711;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=vGKX5S+D7jFYYPsriGNhenJk5u24Qkuc4Q0pWbzRV8M=;
	b=oS6SBycfh7gPMrT0hUk+SD/JUyW5+9yd5K6+bfZugvHLAqPZ1/iwtfo1OPUx0Cof9vwd
	 k2aJgCaIfVTgBy5ZZBdy/biJVBM8oI60YkL4RNLCCBUf0/N67y5YE+spNsX7/RnNMtm0y
	 X8EV0ydPbKI0uCBnV8+4Z8+LlCBvk7WwDf+TQtVACZuqhafE6/sgD2SqI84J10JHmcIEf
	 ikRZ0FYZp4RQY241ykGir7FwKMpdXh0044pzJ4D1XTLJWd2laOTGIaKEKdJ/YoPjKqnqG
	 cks0j7oEZ26ihuhRY2YDV1RG3CpWoPe+GzhELvgDNxxTyHNu1VzCMqBG8ZuxQYJpa8g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Iks7mJxm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C5BA606A32D
	for <bpf@vger.kernel.org>; Thu,  5 Nov 2026 22:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Iks7mJxm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E91391F0089F;
	Thu,  5 Nov 2026 22:45:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793918710;
	bh=vGKX5S+D7jFYYPsriGNhenJk5u24Qkuc4Q0pWbzRV8M=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=Iks7mJxmCX38cV4gCTf4HiXxzeKTyU2EjZOX4bY5zBpNW4le57R300DP0o3F6bKm1
	 Y4NPs1p8XAgiBk2k/ATpLoPI1mgCw925twW8uWHoktk9ej+aobXTolfZVFeJPRz94O
	 GctIHPvsiutDbQD5Q69xKTPOc1XyOa6/NseRfRAJ3IhogeVDnfKJQDV+aV1QN7tVnU
	 +Ru2O/j5C29uWITAy7wUOkS66402s6wP31PMqAC/ZD3E2b6PtP+YyyphiktFpV/iA8
	 IvMTWXj4OXQzo97cfZJd2kVOZ4GsBE9f0i3poMHWQ6sDhMCzABuZHRNAL9u4g0wnlQ
	 BsNY1beZ5ZmlA==
Message-ID: <sashiko-outbox-200328@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2 21/35] bpf: Verify static subprogs on their
 own
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
In-Reply-To: <20261105204513.2230344-22-alexei.starovoitov@gmail.com>
References: <20261105204513.2230344-1-alexei.starovoitov@gmail.com>
 <20261105204513.2230344-22-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 22:45:09 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Critical] bpf: stale reg->delta on scalar args in call_func_on_its_own()
- [High] bpf: bpf_flow_return() drops speculative state flag on callee exit
- [Medium] bpf: call_func_on_its_own() loses async callback RCU lock state
--

commit e8a6194ecde4a13fd7801b423df4fc8986d081f4
Author: Alexei Starovoitov <ast@kernel.org>

bpf: Verify static subprogs on their own

This commit verifies eligible static subprograms in a single-frame entry
state without their caller frames, mapping held references and locks to
positional inherited IDs and delivering exit states to all waiting callers.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 8080920378063..901f4c7620e9e 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> @@ -11794,6 +11797,175 @@ static void account_current_path(struct bpf_ver=
ifier_env *env);
>   * BPF_INHERITED_ID + the position for the function, and put back at the=
 return.
>   */

[ ... ]

> +static int call_func_on_its_own(struct bpf_verifier_env *env, int subpro=
g, int insn_idx)
> +{
> +	u16 live =3D env->insn_aux_data[env->subprog_info[subprog].start].live_=
regs_before;
> +	struct bpf_verifier_state *state =3D env->cur_state;
> +	struct bpf_func_state *caller =3D state->frame[state->curframe], *calle=
e;
> +	struct bpf_verifier_state entry =3D {};
> +	int i, err;
> +
> +	callee =3D kzalloc_obj(*callee, GFP_KERNEL_ACCOUNT);
> +	if (!callee)
> +		return -ENOMEM;
> +	entry.frame[0] =3D callee;
> +	entry.in_sleepable =3D state->in_sleepable;
> +	entry.callers_unknown =3D state->callers_unknown;
> +	init_func_state(env, callee, BPF_MAIN_FUNC, 0, subprog);
> +	/* the frame that says so is not there when the function is verified */
> +	callee->in_rcu_callback_fn =3D in_rcu_callback(env);

[Severity: Medium]
Does setting callee->in_rcu_callback_fn =3D in_rcu_callback(env) lose the R=
CU
read lock state when called from a non-sleepable async callback within a
BPF_FUNC_CTX_NO_RCU_LOCK global subprogram?

When do_check_common() verifies a global subprogram with
env->no_rcu_read_lock =3D true and a non-sleepable async callback is queued=
 via
push_async_cb(), the callback frame has frame[0]->in_async_callback_fn =3D =
true
and in_rcu_callback_fn =3D false. Inside that callback, has_rcu_read_lock()
returns true because of state->frame[0]->in_async_callback_fn:

static bool has_rcu_read_lock(struct bpf_verifier_env *env)
{
	struct bpf_verifier_state *state =3D env->cur_state;

	if (state->active_rcu_locks || in_rcu_callback(env))
		return true;
	if (in_sleepable(env))
		return false;
	return !env->no_rcu_read_lock || state->frame[0]->in_async_callback_fn;
}

When the async callback invokes a static subprogram via
call_func_on_its_own(), entry.frame[0] is replaced by callee where both
in_rcu_callback_fn and in_async_callback_fn are false while
env->no_rcu_read_lock remains true.

Wouldn't has_rcu_read_lock() then return false inside the static subprogram,
causing check_map_func_compatibility() to reject valid map helpers,
check_func_call() to record BPF_FUNC_CTX_NO_RCU_LOCK instead of
BPF_FUNC_CTX_NON_SLEEPABLE for global callees, and entry states with and
without RCU read lock protection to be merged?

> +	for (i =3D BPF_REG_1; i <=3D BPF_REG_5; i++)
> +		if (live & BIT(i))
> +			callee->regs[i] =3D caller->regs[i];
> +	err =3D grow_stack_arg_slots(env, callee, bpf_in_stack_arg_cnt(&env->su=
bprog_info[subprog]));
> +	if (err) {
> +		bpf_free_verifier_state(&entry, false);
> +		return err;
> +	}
> +	for (i =3D 0; i < callee->out_stack_arg_cnt; i++)
> +		callee->stack_arg_regs[i] =3D caller->stack_arg_regs[i];
> +
> +	err =3D copy_reference_state(&entry, state);
> +	if (err) {
> +		bpf_free_verifier_state(&entry, false);
> +		return err;
> +	}
> +	for (i =3D 0; i < entry.acquired_refs; i++) {
> +		/* the id of a lock is the id of the pointer to it, which may have non=
e */
> +		entry.refs[i].id =3D inherited_id(state, entry.refs[i].id);
> +		if (entry.refs[i].type =3D=3D REF_TYPE_PTR)
> +			entry.refs[i].parent_id =3D inherited_id(state, entry.refs[i].parent_=
id);
> +	}
> +	entry.active_irq_id =3D inherited_id(state, entry.active_irq_id);
> +	entry.active_lock_id =3D inherited_id(state, entry.active_lock_id);
> +	callee->entry_refs =3D entry.acquired_refs;
> +	callee->entry_rcu_locks =3D entry.active_rcu_locks;
> +	callee->entry_preempt_locks =3D entry.active_preempt_locks;
> +	for (i =3D BPF_REG_1; i <=3D BPF_REG_5; i++) {
> +		callee->regs[i].id =3D inherited_id(state, callee->regs[i].id);
> +		callee->regs[i].parent_id =3D inherited_id(state, callee->regs[i].pare=
nt_id);
> +		callee->regs[i].map_uid =3D inherited_id(state, callee->regs[i].map_ui=
d);
> +	}
> +	for (i =3D 0; i < callee->out_stack_arg_cnt; i++) {
> +		callee->stack_arg_regs[i].id =3D inherited_id(state, callee->stack_arg=
_regs[i].id);
> +		callee->stack_arg_regs[i].parent_id =3D
> +			inherited_id(state, callee->stack_arg_regs[i].parent_id);
> +		callee->stack_arg_regs[i].map_uid =3D
> +			inherited_id(state, callee->stack_arg_regs[i].map_uid);
> +	}

[Severity: Critical]
When clearing scalar argument IDs in call_func_on_its_own(), can leaving
reg->delta non-zero corrupt scalar bounds tracking in sync_linked_regs()?

If a caller passes a SCALAR_VALUE argument that was offset from a linked
scalar (for example r1 =3D r6; r1 +=3D 10, which sets r1.id =3D base_id |
BPF_ADD_CONST64 and r1.delta =3D 10), inherited_id() returns 0 for r1.id,
leaving callee->regs[1].id =3D=3D 0 and callee->regs[1].delta =3D=3D 10 (and
similarly for callee->stack_arg_regs[i]).

In flow_arrive(), bpf_clear_singular_ids() skips registers where !reg->id.
When the callee later copies r1 to another register (r2 =3D r1),
assign_scalar_id_before_mov() only calls clear_scalar_id() if src_reg->id &
BPF_ADD_CONST:

	if (src_reg->id & BPF_ADD_CONST)
		clear_scalar_id(src_reg);
	if (!src_reg->id && !tnum_is_const(src_reg->var_off))
		src_reg->id =3D ++env->id_gen;

Because r1.id is 0, r1 and r2 receive a new base ID without BPF_ADD_CONST
while retaining delta =3D=3D 10. If r2 is then offset (for example r2 +=3D =
4,
setting r2.id |=3D BPF_ADD_CONST64 and r2.delta =3D 4) and a conditional br=
anch
refines r1 or r2, sync_linked_regs() assumes the register without
BPF_ADD_CONST has delta =3D=3D 0 and computes (s64)reg->delta -
(s64)known_reg->delta using the stale delta of 10 (or if r2 +=3D 10 so
reg->delta =3D=3D known_reg->delta, copies *reg =3D *known_reg with no offs=
et
adjustment).

In addition, reg_value_equal(), regs_exact(), and regsafe() (under
explore_alu_limits) memcmp up to offsetof(struct bpf_reg_state, id), which
includes s32 delta. Should call_func_on_its_own() also zero reg->delta (or
call clear_scalar_id()) when clearing IDs on arguments?

> +
> +	account_current_path(env);
> +	env->subprog_info[subprog].on_its_own =3D true;
> +	err =3D bpf_flow_call(env, state, &entry, subprog, insn_idx);
> +	bpf_free_verifier_state(&entry, false);
> +	/* the call waits, there is nothing to go on with */
> +	return err ?: PROCESS_BPF_EXIT;
> +}
> +
> +/* The current state is at exit of a function that is verified on its ow=
n. */
> +static int exit_func_on_its_own(struct bpf_verifier_env *env)
> +{
> +	struct bpf_verifier_state *state =3D env->cur_state;
> +	struct bpf_func_state *callee =3D state->frame[0];
> +	u32 i, nregs;
> +	int err;
> +
> +	nregs =3D bpf_ret_reg_pair(env, callee->subprogno) ? 2 : 1;
> +	for (i =3D 0; i < nregs; i++) {
> +		if (callee->regs[ret_regs[i]].type !=3D PTR_TO_STACK)
> +			continue;
> +		verbose(env, "cannot return stack pointer to the caller\n");
> +		return -EINVAL;
> +	}
> +	state->unwound |=3D bpf_is_unwind_exit(&env->prog->insnsi[env->insn_idx=
]);
> +
> +	/* Invalidate callee-local dynptrs and their slices before the frame go=
es away. */
> +	err =3D destroy_dynptrs_in_stack_slots(env, callee, 0,
> +					     callee->allocated_stack / BPF_REG_SIZE - 1);
> +	if (err)
> +		return err;
> +
> +	account_current_path(env);
> +	err =3D bpf_flow_exit(env, state, env->insn_idx);
> +	return err ?: PROCESS_BPF_EXIT;
> +}

[Severity: High]
What happens when a speculative path spawned inside a static subprogram
verified on its own reaches exit_func_on_its_own()?

A non-speculative caller passes func_is_on_its_own() and waits in
bpf_flow_call() with w->st.speculative =3D=3D false. While verifying the ca=
llee,
check_cond_jmp_op(), sanitize_ptr_alu(), or check_unwind_goto() can push a
speculative branch with branch->speculative =3D true and branch->flow_entry=
 =3D
id. When that speculative state reaches BPF_EXIT:

exit_func_on_its_own()
  bpf_flow_exit()
    flow_apply_exit()
      bpf_flow_return(env, &st, &x->st, call_idx)

In bpf_flow_return(), caller->unwound is copied from exit->unwound, but
exit->speculative is not propagated to caller->speculative. As a result, st
is delivered back to the caller at call_idx + 1 with st.speculative =3D=3D =
false.

In the caller, wouldn't this cause sanitize_mark_insn_seen() to mark
architecturally unreachable instructions as seen (bypassing
sanitize_dead_code()) and prevent do_check_block() from inserting nospec
barriers on recoverable errors because state->speculative is false? Also, in
flow_merge(), can a non-speculative state t->st from another call entry
subsume a speculative state s->st via bpf_state_subsumes() and call
flow_unite(flow, s->st.flow_entry, t->st.flow_entry), cross-delivering exits
between the two calls?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105204513.2230=
344-1-alexei.starovoitov@gmail.com?part=3D21
