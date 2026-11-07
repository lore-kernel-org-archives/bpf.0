Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794027191;
	b=OP1TarqGX7Aq5TO0Q5o9v4Wtq0c2YfO0uCBKKMDSV1LugobrGqCqyClgnPftLF+2lfoF
	 FGAmE4o6MgyZhsnVtgssT1Yr8Flk9o03LAXbc7H+vI2HvwgfgduWA7laVh2AVaeE3lkY0
	 +dT61LqsOTEFHZAWn6lowLK0HulLV4PcdKmQltpRHdC1JI9x95zaHijdThfRASZoGBFav
	 OBwgmNM66/SNJTIPLa/Ven+K0pvpnhjmVlHzW5vCERUxhTJJERTExos4ycxP5YVuCusAr
	 BSqUewFVkpXhyTpKHx1B29a0eTEaEY12NOWwHNOjt/HWBWpkX82tHl8ad+9moIDjFbw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794027191;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=djIV5RKbjV6lKTFXE4keM32HxrawJwXVdzpBe/Xl+9s=;
	b=D5qUEsqOTC5u3mJIGkXBDpCy3VqZA/YsjP6AA8SRUPrOyH3aIDSuNnSnz1g+KgYph9n1
	 bWwAImNa8EtIPGoqipkpsc0oQkZGUQ7sDmmycPcDzIaWNwZC6+omrMR4uabepj6sHnvQu
	 tTJGTNGUCo5ngJ8Dr1er85Qxe4mqILpx2hA84y+8WjrlG62ZMYNOSyr8TyYFbcdaj2pnL
	 gM5bbw6SfqS6W1g+8xR/4eFNZ5QULMgEcklo3uee9Co8ipKRgi2N6itZw6+HoXHA6AGd7
	 RCQai3OlSl+jzEhhFXRn4T54IiBnuhIAr/QDHcpL34f1STrlApL+lliHFYf10Jb2bYw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YAc6tG20;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD770606A326
	for <bpf@vger.kernel.org>; Sat,  7 Nov 2026 04:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YAc6tG20
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 277F41F008A2;
	Sat,  7 Nov 2026 04:53:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794027190;
	bh=djIV5RKbjV6lKTFXE4keM32HxrawJwXVdzpBe/Xl+9s=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=YAc6tG20fkTeKZDHUBNTBk8xzpKut8W6TJKKEtqbX5n+GTLXQ5nebuI54nWMXSD5T
	 rvoyZKkSIK8nFFuk8Ilk3vVSOsb2nkxRK/vA6VyRpQe0vJBjb+8PJh2IZJBe4drZ4M
	 s2DuaphWhnrbLG0HpNx1rGPqaO6NJIM0hONTQajuOCa8L6hXqrUGaVXfu62HIdThG/
	 UXIMCwURmkFa0LaF1fxD2Gfcm0r5GCcfN6s1JQWluRhVrHZTe8FYkoiSjif7ecI+6f
	 qDQ62KSNC19JYPSFEfc2dSDHs4Z1G+ZY3SwWV3vGte56HhMt/v9ODPlow/b28oClhS
	 z3jDV+AS/aUkg==
Message-ID: <sashiko-outbox-202596@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v4 21/46] bpf: Verify static subprogs on their
 own
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
In-Reply-To: <20261107033758.1547725-22-alexei.starovoitov@gmail.com>
References: <20261107033758.1547725-1-alexei.starovoitov@gmail.com>
 <20261107033758.1547725-22-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 07 Nov 2026 04:53:09 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 4 potential
issues to consider:
- [High] bpf: bpf_flow_return() drops speculative state flag on callee
  exit
- [Medium] bpf: call_func_on_its_own() loses async callback context in
  frame[0]
- [Medium] bpf: add_insns_of_callees() double-counts insns and misses
  callx edges
- [Medium] bpf: bpf_flow_return() lazy fallback leaves stale post-call
  states
--

commit 9af28e54478c87831c1e29826a9fb6f36a5e5256
Author: Alexei Starovoitov <ast@kernel.org>

bpf: Verify static subprogs on their own

This commit verifies eligible static subprograms independently of their
callers' stack frames using a single-frame entry state and remapped
inherited reference IDs.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 0a315a88e355a..3c3d1c8ea4529 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> @@ -11849,6 +11852,185 @@ static void account_current_path(struct bpf_ver=
ifier_env *env);

[ ... ]

> +static bool func_is_on_its_own(struct bpf_verifier_env *env, struct bpf_=
verifier_state *state,
> +			       int subprog)
> +{
> +	struct bpf_func_state *caller =3D state->frame[state->curframe];
> +	struct bpf_subprog_info *sub =3D &env->subprog_info[subprog];
> +	u16 live =3D env->insn_aux_data[sub->start].live_regs_before;
> +	u32 i;
> +
> +	if (sub->changes_pkt_data || sub->has_tail_call || sub->has_ld_abs ||
> +	    sub->is_cb || sub->is_async_cb || sub->is_exception_cb)
> +		return false;
> +	if (state->speculative)
> +		return false;
> +	if (sub->releases_inherited &&
> +	    (state->acquired_refs || state->active_rcu_locks || state->active_p=
reempt_locks))
> +		return false;

[Severity: Medium]
Can setting sub->releases_inherited (or sub->changes_pkt_data) lazily in
bpf_flow_return() leave stale post-call states at call_idx + 1 when a
subprogram only releases a caller-held resource on one branch?

When a non-releasing exit of the callee is processed first,
flow_apply_exit() -> bpf_flow_return() sees kept =3D=3D nheld and delivers a
post-call state with the resource still held to call_idx + 1.  When the
releasing exit later reaches bpf_flow_return(), it sets
sub->releases_inherited =3D true and returns 1 to re-verify the call in the
caller's context, but the state already delivered to call_idx + 1 is not
retracted and can cause check_resource_leak() to reject a valid program.

> +	/* what must not be done in that callback is refused by looking at the =
frames */
> +	if (in_rbtree_lock_required_cb(env))
> +		return false;
> +	/* there are that many names for what is held, and bpf_flow_return() ha=
s room for them */
> +	if (state->acquired_refs > BPF_ID_MAP_SIZE / 2)
> +		return false;
> +	for (i =3D BPF_REG_1; i <=3D BPF_REG_5; i++) {
> +		if (!(live & BIT(i)))
> +			continue;
> +		if (caller->regs[i].type =3D=3D PTR_TO_STACK ||
> +		    base_type(caller->regs[i].type) =3D=3D CONST_PTR_TO_DYNPTR)
> +			return false;
> +		if (arg_needs_caller(env, state, sub, &caller->regs[i]))
> +			return false;
> +	}
> +	for (i =3D 0; i < bpf_in_stack_arg_cnt(sub); i++) {
> +		if (caller->stack_arg_regs[i].type =3D=3D PTR_TO_STACK ||
> +		    base_type(caller->stack_arg_regs[i].type) =3D=3D CONST_PTR_TO_DYNP=
TR)
> +			return false;
> +		if (arg_needs_caller(env, state, sub, &caller->stack_arg_regs[i]))
> +			return false;
> +	}
> +	return true;
> +}
> +
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
Does replacing entry.frame[0] with callee lose
state->frame[0]->in_async_callback_fn and callback_ret_range when a static
subprogram is called from an async callback?

kernel/bpf/verifier.c:has_rcu_read_lock() {
	if (state->active_rcu_locks || in_rcu_callback(env))
		return true;
	if (in_sleepable(env))
		return false;
	return !env->no_rcu_read_lock || state->frame[0]->in_async_callback_fn;
}

When a global subprogram is verified for BPF_FUNC_CTX_NO_RCU_LOCK
(env->no_rcu_read_lock =3D=3D true) and schedules a non-sleepable async
callback such as a bpf_timer callback, has_rcu_read_lock() relies on
state->frame[0]->in_async_callback_fn.  Without copying
in_async_callback_fn and callback_ret_range to callee, has_rcu_read_lock()
returns false inside the static subprogram (rejecting RCU-protected map
helpers and misclassifying nested global calls), and check_return_code()
on a default bpf_throw() checks the main program's return range instead of
the async callback's.

> +	for (i =3D BPF_REG_1; i <=3D BPF_REG_5; i++)
> +		if (live & BIT(i))
> +			callee->regs[i] =3D caller->regs[i];

[ ... ]

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
As reported by bot+bpf-ci@kernel.org on v2 [1], does returning from a
speculative path via exit_func_on_its_own() and bpf_flow_return() drop
exit->speculative?

Although func_is_on_its_own() rejects speculative caller states at entry,
a conditional branch or pointer ALU operation inside the callee can spawn
a speculative path with state->speculative =3D true.  When that path reaches
BPF_EXIT, flow_apply_exit() copies the non-speculative waiting caller
state and calls bpf_flow_return(), which does not propagate
exit->speculative to caller->speculative.  The speculative return state is
then delivered to the caller as a normal architectural state, marking
architecturally dead instructions as seen and turning recoverable
speculative faults into fatal verification errors.  In addition,
flow_merge() -> flow_within() allows a non-speculative state from another
call entry to subsume a speculative state in the callee and cross-unite
their flow_entry sets via flow_unite().

[ ... ]

> @@ -23532,6 +23726,37 @@ static int do_check_all(struct bpf_verifier_env =
*env)
>  	}
>  }
> =20
> +/*
> + * What it took to verify a static subprog on its own is not in insns_to=
tal of its callers.
> + * Add it, once per caller. The main prog and global subprogs have all o=
f it already.
> + */
> +static void add_insns_of_callees(struct bpf_verifier_env *env)
> +{
> +	struct bpf_subprog_info *si =3D env->subprog_info;
> +	struct bpf_insn *insn =3D env->prog->insnsi;
> +	int *added, i, j, s, c;
> +
> +	added =3D kvcalloc(env->subprog_cnt, sizeof(*added), GFP_KERNEL_ACCOUNT=
);
> +	if (!added)
> +		return;
> +	/* callees first */
> +	for (i =3D 0; i < env->subprog_cnt; i++) {
> +		s =3D env->subprog_topo_order[i];
> +		if (!s || bpf_subprog_is_global(env, s))
> +			continue;
> +		for (j =3D si[s].start; j < si[s + 1].start; j++) {
> +			if (!bpf_pseudo_call(&insn[j]))
> +				continue;
> +			c =3D bpf_find_subprog(env, j + insn[j].imm + 1);
> +			if (c <=3D 0 || c =3D=3D s || !si[c].on_its_own || added[c] =3D=3D s)
> +				continue;
> +			added[c] =3D s;
> +			si[s].insns_total +=3D si[c].insns_total;
> +		}
> +	}
> +	kvfree(added);
> +}

[Severity: Medium]
As reported by bot+bpf-ci@kernel.org on v2 [2], can add_insns_of_callees()
double-count si[c].insns_total and miss indirect callx callees?

When a static callee c is verified on its own at one call site (or sets
on_its_own before bpf_flow_return() falls back to in-frame verification,
or in an earlier do_check_all() round) and in-frame at another call from
static subprogram s, prepare_func_exit() -> account_processed_insns() has
already added the in-frame instructions to both si[c].insns_total and
si[s].insns_total, so adding si[c].insns_total here counts them a second
time.  Conversely, static subprograms called via callx and verified on
their own via check_func_callx() -> check_static_func_call() are skipped
because the loop only checks bpf_pseudo_call().

[1] https://lore.kernel.org/r/fbc6a76bd8cb0b115a602fe1f8064612f09afac8924a2=
3ae5d64cf4e7fe68b43@mail.kernel.org
[2] https://lore.kernel.org/r/fbc6a76bd8cb0b115a602fe1f8064612f09afac8924a2=
3ae5d64cf4e7fe68b43@mail.kernel.org

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261107033758.1547=
725-1-alexei.starovoitov@gmail.com?part=3D21
