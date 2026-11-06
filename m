Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793940802;
	b=3euG7zcQVuWWTOj9dS03rkw8G3+jjYHwrK/LLqyl2JhY3v6XqTEqeZX2RA7bq6s+57Z5
	 MUDxxUK6SKyaZ0wywUUal2av/vnbU/fwZg8rRRqG42L034rMzvnA5mWpoFeHg5UZjUlJm
	 +kugXrn+5ZpQVafO3ka6fN1/hyG3wy5jlIJ+LtPe3Fpkw6xRfEX511X4OK91aOIGz+NVy
	 knbDlrJlyz63mwVMgELfGCZyXVApaFRyDmVPiiNZYv4g3rVqp3k2VZXPCbUyj+tFIbnAE
	 KI75eAgo6M/RPqFz6QzAzY9i/8C+iLoZyQ4svg98ILhf6hYPpbdpL2ZhVpNYuVbmJrw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793940802;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=f50S8LhDHJtSH3D2Oqf5TEc0LMm1TysfoxN+Z8pCh9Y=;
	b=ERdNs5oztYupL6j4tjn+PpE8zS+TnOQYuIP/InrL8C7tKS9Ao22GIMXzy2RPu5C3hI9+
	 zde3foih0dxuDTFqgHrRDF7XcJoNifmPxK5kXNlUB4nFfDMoa8lavXVFh2JdDMSW+NUJs
	 8XgeeUJ2IKvhXil8tIt7iAtcjK6y9Tgz/nluOJVS8X3jRqRR7BKLMEcFJv1uK/ZCIUtzi
	 vmwnTqcxlvZ9s8RxDRjUlMYWAY97bUw3EWDqvVEN1qBHXToEwwaurdGMWwoFySRPDn+xy
	 lWDnY8VCE5t69meoBNLOoDJutX5oG1vHH2UdYwDwtAOz/e9PtgzFRfQ38gsv479A2HA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=okBppRsn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 150B2606A31B
	for <bpf@vger.kernel.org>; Fri,  6 Nov 2026 04:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=okBppRsn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DD661F008A1;
	Fri,  6 Nov 2026 04:53:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793940801;
	bh=f50S8LhDHJtSH3D2Oqf5TEc0LMm1TysfoxN+Z8pCh9Y=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=okBppRsnh1mgZ0Y5zIxmlYMw6TmZS7T8ofLAha/XtZxLlkmg9ilGclul73mtsbQoS
	 aT40ruR3vdGddBZni7NPzHoaB0rStzhUQZGbqmv0xsdxdyPheeW+7JpVUd6/T5Q4c/
	 124N8kdBJwMuNcM7IDIZ5xKVJ1HzbOkMtwuYO5z1CvaQIcov+Z0YD0bWKbUJPW/M+b
	 s9ro9k9oCl/QPpXROFcGxJVze1eruwPEOx+iKFDet32nQZGLoxU6A3DeuW9XWrUZyA
	 REF39+6I1Bmh5d6uTywa6MclBJgI/rs0C6UePagQfsRhHfPaiUjDGdHvvKiso0XMvP
	 OH6Dyeyz8sLxg==
Message-ID: <sashiko-outbox-200776@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v3 21/45] bpf: Verify static subprogs on their
 own
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
In-Reply-To: <20261106035111.3315285-22-alexei.starovoitov@gmail.com>
References: <20261106035111.3315285-1-alexei.starovoitov@gmail.com>
 <20261106035111.3315285-22-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 04:53:21 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] bpf: bpf_flow_return() drops speculative state flag on callee exit
- [Medium] bpf: call_func_on_its_own() loses async callback context in fram=
e[0]
- [Medium] bpf: add_insns_of_callees() double-counts insns and misses callx=
 edges
- [Medium] bpf: bpf_flow_return() lazy fallback leaves stale post-call stat=
es
--

commit 34bdfd07d4f78d7029c50c8aec27497f8117e123
Author: Alexei Starovoitov <ast@kernel.org>

bpf: Verify static subprogs on their own

This commit verifies eligible static subprograms in a single standalone fra=
me
rather than in the call frames of their callers, joining states at the
subprogram entry and applying exit states to all waiting call sites.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 103f368035638..b61166f670945 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> @@ -11840,6 +11843,180 @@ static void account_current_path(struct bpf_ver=
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
What happens if a static subprogram verified on its own has multiple exit
paths, or is called from two sites whose entries are merged, where one exit
leaves caller-held references, locks, or packet data intact while a later
exit releases an inherited resource or changes packet data?

In kernel/bpf/flow.c:flow_apply_exit(), each exit state is applied to waiti=
ng
callers as it arrives:

	err =3D bpf_copy_verifier_state(&st, &w->st);
	if (!err)
		err =3D bpf_flow_return(env, &st, &x->st, call_idx);
	if (!err)
		err =3D bpf_flow_deliver(env, &st, call_idx + 1, call_idx);
	bpf_free_verifier_state(&st, false);
	if (err !=3D 1)
		return err;

When an earlier non-releasing exit reaches flow_apply_exit() (or is applied
via flow_do_united() when two entry states are joined by flow_merge()), a
post-call state is delivered to call_idx + 1 while w remains on entry->call=
s.

When a subsequent exit reaches bpf_flow_return() and sets
sub->releases_inherited =3D true (or sub->changes_pkt_data =3D true), retur=
ning 1
re-queues w at call_idx for in-frame verification, but any post-call states
already delivered to call_idx + 1 from earlier exits are not retracted. Can
those stale post-call states continue executing in the caller and trigger
false check_resource_leak() failures at program exit?

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
As reported by Sashiko on v2 [1], when a non-sleepable async callback
scheduled from a global subprogram verified with env->no_rcu_read_lock =3D=
=3D true
calls a static subprogram verified on its own, call_func_on_its_own() repla=
ces
entry.frame[0] with callee and only sets callee->in_rcu_callback_fn.

Because push_async_cb() sets async_cb->frame[0]->in_async_callback_fn =3D t=
rue
and async_cb->frame[0]->callback_ret_range rather than in_rcu_callback_fn,
has_rcu_read_lock() relies on state->frame[0]->in_async_callback_fn:

	if (state->active_rcu_locks || in_rcu_callback(env))
		return true;
	if (in_sleepable(env))
		return false;
	return !env->no_rcu_read_lock || state->frame[0]->in_async_callback_fn;

And check_return_code() (which check_kfunc_call() invokes for bpf_throw()
during do_check_all()) also checks frame->in_async_callback_fn and
frame->callback_ret_range on env->cur_state->frame[0].

Should call_func_on_its_own() also preserve state->frame[0]->in_async_callb=
ack_fn
and state->frame[0]->callback_ret_range on callee so RCU read-lock tracking
and async callback return-range checks are not lost inside the standalone
callee frame?

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
As reported by bot+bpf-ci@kernel.org on v2 [2], when speculation mitigation=
 is
active (!env->bypass_spec_v1 or !env->bypass_spec_v4), a static subprogram
entered with state->speculative =3D=3D false can spawn speculative paths in=
side
the callee via check_cond_jmp_op(), sanitize_ptr_alu(), or
check_unwind_goto().

When such a speculative path reaches BPF_EXIT, process_bpf_exit_full() rout=
es
it through exit_func_on_its_own() -> bpf_flow_exit() -> flow_apply_exit() ->
bpf_flow_return(). In bpf_flow_return(), caller->unwound is copied from
exit->unwound, but exit->speculative is not propagated to caller->speculati=
ve:

	if (exit->unwound && !bpf_is_unwind_goto(&env->prog->insnsi[call_idx + 1])=
) {
		verbose(env, "unwind_exit, but no unwind_goto after the call at insn %d\n=
",
			call_idx);
		return -EINVAL;
	}
	caller->unwound =3D exit->unwound;

In addition, in kernel/bpf/flow.c:flow_merge(), a non-speculative state t->=
st
can subsume a speculative state s->st via flow_within() ->
bpf_state_subsumes() and unite their flow_entry sets via flow_unite().

Could this cause speculative return states to resume in the caller as
non-speculative architectural paths (marking dead instructions as seen in
sanitize_mark_insn_seen() and failing the state->speculative check on
recoverable errors in do_check_block()) or cross-unite distinct call entrie=
s?

[ ... ]

> @@ -23452,6 +23641,37 @@ static int do_check_all(struct bpf_verifier_env =
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
As reported by bot+bpf-ci@kernel.org on v2 [3], if a static subprogram c is
verified in-frame for one call from s (or falls back to in-frame verificati=
on
when bpf_flow_return() returns 1, or across a do_check_all() restart where
on_its_own is not cleared) and is also verified on its own for another call,
prepare_func_exit() -> account_processed_insns() has already added the
in-frame instructions of c into both si[c].insns_total and si[s].insns_tota=
l.
When add_insns_of_callees() then adds the full si[c].insns_total to
si[s].insns_total, won't the in-frame portion be counted twice in
si[s].insns_total?

Also, since check_func_callx() calls check_static_func_call() and can verify
indirect targets on their own via call_func_on_its_own(), does
add_insns_of_callees() need to account for callx edges in env->callx_edges =
in
addition to bpf_pseudo_call() instructions?

[1] https://lore.kernel.org/r/20261105204513.2230344-22-alexei.starovoitov@=
gmail.com
[2] https://lore.kernel.org/r/fbc6a76bd8cb0b115a602fe1f8064612f09afac8924a2=
3ae5d64cf4e7fe68b43@mail.kernel.org
[3] https://lore.kernel.org/r/fbc6a76bd8cb0b115a602fe1f8064612f09afac8924a2=
3ae5d64cf4e7fe68b43@mail.kernel.org

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106035111.3315=
285-1-alexei.starovoitov@gmail.com?part=3D21
