Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792986823;
	b=5jqXDZAGm0e7lKUBPdCJjT1ETsqDXvHS7O+/F7w0d9eFkm9SdHdkxdhpbrfzc7LePdAR
	 9hrsRRJ7Zy0YMetri359FmDtPQpcSG2KxKqfn0x6MCkh4LVx8Ka/PtnMO3/e7PLFK2STQ
	 nWGLfuwCavAk+Nu6+am5ZjYOUf/moI42bjTPMxH9uh9MNaJuq89IMZK56DCnXWn855Xi5
	 rRv1arckmc4hfNxMecmOZgUe4pqBmHzdUDW3Sbo4QbqBm5YTy9bP7kFDgBZ9+Pl1C/oIS
	 xpkNvyo4kuWw6Wjp1LfqsFEhwRhvy4xAKxS0an04sByJc/rWDQr5MR7UPkZrMiK8WQA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792986823;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=oelDaTTG+3S4GaIdZ0WWGpM28k8MeJYryaR1HzjIRCo=;
	b=FBKNcqlLvHYxgs+bS7OPnGbw/SSrg9NZBQfw3BMPF3q3/R82qPr2vIvTV+CapU7xe35c
	 ONdcpHXIYVSQGjfL+h1eunzBKJq5FFON7y4yUhUsdJ7A0Jv3oqIcR/IvvxSIQNH7ha/6r
	 PiODIKAZdSGmgVDiTkHuX1nzvhcyD8dK5dBH5PEb2V3mqd6+/c/vt/42ivrN2jkU0YWig
	 V2ztDjjUvtc0hLwXO2AJ36okeTZ91U6I9Ej1py9HFD22i9Hj8Bim9l7VgAOVUwW34TYHe
	 xDcge1WwBesNbp2X4K/DWgqM5FtxxmvOQG686iYxFf59iNPB0ho8p1WEP7KwHzsCHcA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ge534OAd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B59A7606A31D
	for <bpf@vger.kernel.org>; Mon, 26 Oct 2026 03:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ge534OAd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 629321F01825;
	Mon, 26 Oct 2026 03:53:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792986822;
	bh=oelDaTTG+3S4GaIdZ0WWGpM28k8MeJYryaR1HzjIRCo=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=ge534OAdyQ7dH5PZY2A1B1/Q2C92+1BjuqFdsu/m1mWfJuChh/MpFRJRRDH5pxauz
	 RcRIyXwD9hwMgOcu1BM8Z2cIG41WibPi845sfpM2fRzLX59E84fmJ1S/9iYMa7H9BN
	 aHHtCXZcGbGPErtWobDB5Vb62pycrQHpmgwa1e735wR3K+x95Xum0pKU71cB2iMusp
	 nHkX7lEnRH1Gxa5yzjTFyZIYiBXONKAe4ASRfnSyB6Oy/oCe46mmI/EhVV+++3qB0V
	 /bp8jD6CIHA1sGngIit1fB727pkXqk9VA82/8HN8g63uFXjshcK6YLN2riBRtIAPOf
	 jCshM/dc7CeAA==
Content-Type: multipart/mixed; boundary="===============1253832364625648183=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <94b8c5e39269c5e8b82ee456fe7c2641da087c7ed2e85f0526f3350134ff853b@mail.kernel.org>
In-Reply-To: <20261026025943.404450-53-alexei.starovoitov@gmail.com>
References: <20261026025943.404450-53-alexei.starovoitov@gmail.com>
Subject: Re: [PATCH bpf 52/81] bpf: Add the main pass as a fixpoint over the control flow graph
From: bot+bpf-ci@kernel.org
To: alexei.starovoitov@gmail.com,bpf@vger.kernel.org
Cc: daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Mon, 26 Oct 2026 03:53:42 +0000 (UTC)

--===============1253832364625648183==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Add the main pass as a fixpoint over the control flow graph

TL;DR:
- Verifier may accept never-ending loops: a destroyed or nested iterator's
  next() counts as a bound
- Possible NULL frame dereference in flow_unset_differs() on curframe mismatch
- Subprog return merges may reject valid programs
- Rest: comment and changelog nits

>     bpf: Add the main pass as a fixpoint over the control flow graph
>
>     [ ... ]
>
>     This does not prove that a loop ends. A loop gets may_goto unless the
>     number of iterations is known, or each iteration executes may_goto or
>     bpf_iter_*_next(). flow_place_guards() puts may_goto before a conditional
>     jump that exits the loop, with the same target. The prog can arrive there
>     with the same state through that jump.

flow_place_guards() also has a 'header:' fallback.  It is taken when the back
edges overflow, for an irreducible loop whose back edges are not exiting
jumps, or for a back edge that has no latch in the loop itself.

There, may_goto is placed at the loop head, and its target is exits[0].to of
the outermost loop around it.  That is not an edge of the program, so the
state at the head may not match any state that reaches that target, which is
why check_loop_guard() sets the live NOT_INIT registers to 0 for
guard_at_header.  The fallback also places no may_goto at all when the
outermost loop has no recorded exit.

Could the changelog describe the head fallback and how the verifier handles
its edge?

> diff --git a/kernel/bpf/flow.c b/kernel/bpf/flow.c
> new file mode 100644
> index 000000000000..fc5272ed2af8
> --- /dev/null
> +++ b/kernel/bpf/flow.c
> @@ -0,0 +1,1817 @@

[ ... ]

> +/* Does the insn at @idx stop the loop @h? */
> +static bool flow_is_bound(struct bpf_verifier_env *env, int h, int idx)
> +{
> +	struct bpf_insn *insn = &env->prog->insnsi[idx];
> +	int t;
> +
> +	/* Once it is out of budget it's a jump. It has to leave the loop. */
> +	if (bpf_is_may_goto_insn(insn)) {
> +		t = bpf_loop_at_index(env, idx + insn->off + 1);
> +		return t != h && !bpf_is_nested_loop(env, t, h);
> +	}
> +	/* as long as the program doesn't go on when there is nothing left, see iter_is_drained() */
> +	return bpf_insn_is_iter_next(env, insn);
> +}

[ ... ]

> +		/* see flow_place_guards() about loops with more than one entry */
> +		loop->rt_bounded = !loop->backedges_overflow && !loop->irreducible;
> +		for (i = 0; i < loop->backedges_cnt && loop->rt_bounded; i++) {
> +			for (n = loop->backedges[i].from; n >= 0 && n != h; n = env->idoms[n])
> +				if (flow_is_bound(env, h, n))
> +					break;
> +			if (n < 0 || !flow_is_bound(env, h, n))
> +				loop->rt_bounded = false;
> +		}
> +		/* also when it's bounded: the main pass may find that it's not */
> +		flow_place_guards(env, h, seen);
> +	}

Can flow_compute_loop_bounds() mark a loop rt_bounded when the
bpf_iter_*_next() call that dominates its back edge belongs to an iterator
that is created and destroyed within one trip?

flow_is_bound() only checks bpf_insn_is_iter_next(), so a call in a nested
loop counts as a bound for the outer loop, and nothing checks that the same
iterator is alive across trips.  An rt_bounded loop never gets may_goto from
check_loop_guard(), and the "never exits" rejection in bpf_flow_loop_enter()
is skipped for it:

	if (!loop->rt_bounded && !loop->has_guards)

For example, the usual bpf_for() pattern inside an unbounded loop:

	  r6 = &one ll            ; global in .data, unknown to the verifier
	1: r1 = r10; r1 += -8; r2 = 0; r3 = 2
	   call bpf_iter_num_new
	2: r1 = r10; r1 += -8
	   call bpf_iter_num_next
	   if r0 != 0 goto 2b
	   r1 = r10; r1 += -8
	   call bpf_iter_num_destroy
	   r1 = *(u64 *)(r6 + 0)
	   if r1 != 0 goto 1b      ; back edge of the loop at 1
	   r0 = 0; exit

The idom chain from the back edge reaches the bpf_iter_num_next() call of
the inner loop, so the loop at 1 gets rt_bounded = true.  Scalar evolution
cannot count the loop, and because rt_bounded is set, bpf_flow_loop_enter()
checks the body once.

bpf_iter_num_destroy() makes unmark_stack_slots_iter() set the iterator slot
to STACK_INVALID, so the state that comes back to 1 has no iterator.
flow_same_iters() is true and flow_merge() drops the state as within the
entry state, and the pass ends after one trip.  Only one iterator id ever
reaches the inner loop, so flow_iters_are_remade() never runs, and
iter_is_drained() is never reached because every trip calls next() on a new
active iterator.

The program then loads with no may_goto in the outer loop and never ends
while 'one' is not 0.  With 'for (;;)' and no exit, flow_place_guards()
places no guard either, and the "never exits" rejection is skipped, so a
loop that never ends is accepted.  The same happens without a nested loop:

	while (x) {
		bpf_iter_num_new(&it, 0, 1);
		bpf_iter_num_next(&it);
		bpf_iter_num_destroy(&it);
	}

Before the series, bpf_is_state_visited() rejected these programs with
"infinite loop detected".  The commit message says "bpf_iter_*_next() stops
a loop only if all iterations use the same iterator", but nothing enforces
that when the iterator does not survive to the loop head.

flow.c is first built by 0535bc235aed ("bpf: Verify programs as a fixpoint
over the control flow graph"), and flow_is_bound(), check_loop_guard(),
iter_is_drained() and flow_iters_are_remade() are unchanged up to the end of
the series, so no later fix was found.

Should an iter_next count as a bound only if its iterator slot is still
STACK_ITER in the state at the loop head, and otherwise clear rt_bounded and
restart, as iter_is_drained() does?

[ ... ]

> +			if (class == BPF_JMP && BPF_OP(insn->code) == BPF_CALL) {
> +				in.regs &= ~GENMASK(BPF_REG_5, BPF_REG_0);
> +				s = idx + insn->imm + 1;
> +				if (bpf_pseudo_call(insn) &&
> +				    !bpf_subprog_is_global(env, bpf_find_subprog(env, s)))
> +					in.regs |= need[s].regs & GENMASK(BPF_REG_5, BPF_REG_1);

Does this miss the case where a callee that runs in its own frame returns a
value that the caller tests against a constant, or needs as a constant?

Needs go into a callee only through its arguments: need[s] is added to r1-r5
at the call.  A BPF_EXIT has no successors in bpf_insn_successors(), so
need[exit] is 0 for all three kinds, and nothing carries a need from the
insn after a call back into the callee's exit.  The callee's r0 is never
"tested" (or a "needed constant") at its exit, even when every caller
compares it with a constant right after the call.

This matters for a static subprog that is not verified on its own.
func_is_on_its_own() (wired in 0535bc235aed) returns false for a callee that
gets a PTR_TO_STACK argument, a nullable pointer, packet_end, or that is
called from a callback.  The consumers then look at:

	need = &flow->tested[fr == a->curframe ? a->insn_idx :
			     a->frame[fr + 1]->callsite + 1];

For the callee frame this is tested[exit], which is 0.  For the caller
frame, tested[callsite + 1] does have r0, but the caller's r0 is NOT_INIT
while the callee runs, because check_func_call() calls
clear_caller_saved_regs() after setup_func_entry().  So flow_number_at()
returns NULL and the register is skipped.  flow_rets_differ(), the rule for
"a constant that a subprog returns", is used only in bpf_flow_exit(), the
path for functions that are verified on their own.

Take the motivating example from the commit message, with the lookup
written as a subprog that takes &p:

	static __noinline int get(struct val **pp) /* pp is on the caller's stack */
	{
		struct val *v = bpf_map_lookup_elem(&map, &key);
		if (!v)
			return -2;
		if (v->skip)
			return 1;
		*pp = v;
		return 0;
	}
	...
	struct val *p;
	int ret = get(&p);
	if (ret < 0) goto err;
	if (ret > 0) goto skip;
	use(p);

The callee runs in a frame because of the PTR_TO_STACK argument.  Its return
paths jump to one shared exit insn, which is a point, and the states
(r0=-2, p unset) and (r0=1, p unset) meet there.  flow_unset_differs() and
flow_null_differs() do not refuse them, and flow_join_makes_up() sees
tested[exit] == 0, so flow_merge() joins them into r0=[-2,1] with p unset.
That state returns to the caller, takes the r0 == 0 path through both jumps,
and reaches use(p) without p.  The program is rejected, although the old
path-by-path verifier accepted it.

The same gap affects FLOW_NEED_ARG.  A callee in a frame that returns 16 or
32, with the result passed as the size of bpf_ringbuf_reserve(), has the two
constants joined at its exit, and the helper then sees a non-constant size.

The commit message says the verifier keeps such states apart ("a tested
register, and its ranges have a gap  ret=-2 and ret=1"), which does not hold
when the states meet inside a callee that runs in a frame.

No later commit in the series changes flow.c.  Would it work to give each
exit of a static subprog the union of need[call + 1] over its call sites,
limited to r0 (and r1 for bpf_ret_reg_pair())?

[ ... ]

> +/*
> + * Put *@ps into @set, one of the sets of states at its insn. Returns
> + * 1 if it is within a state of the set. It is gone then.
> + * 0 if it is in the set now, as it was or joined with states of the set.
> + * @cycle: it came around a cycle, what grew is forgotten.
> + */
> +/*
> + * A state is within another one, or has a join with it, only when the chains of calls and the
> + * loops they are in are the same, iterations that are kept apart included. A walk leaves
> + * a state per iteration at every point of the loop and of what it calls. Tell
> + * them apart before the registers are compared or, for a join, copied.
> + */
> +static u32 flow_kind(const struct bpf_verifier_state *st)

[ ... ]

> +/*
> + * Two things of which one is there: "if (hdr->ipv4) ... else if (hdr->ipv6)". The one that
> + * is not there is 0. What the other one is may be unknown, e.g. a pointer to the packet
> + * after the packet was changed. (0, x) is not within (y, 0) and the join (?, ?) forgets that
> + * it's one or the other.
> + * The same for a number that was compared with 0: 0 on one path, not 0 on the other.
> + */
> +/*
> + * bpf_loop(N, ...) with a small N: the calls of the callback are looked at one by one, like
> + * the iterations of a loop that is walked. The call stops to enter the callback when
> + * callback_depth gets to N.
> + */
> +static bool flow_callback_depth_differs(struct bpf_verifier_env *env,

This isn't a bug, but the comment that documents flow_merge() (@ps, @set,
@cycle and the 1/0 return values) sits directly above flow_kind(), which
takes one const state and returns a hash.  flow_merge() itself is much
further down and its only header is the flow_has_room() comment.

Could this block move to flow_merge()?  It could also mention the negative
error returns (-EAGAIN, -E2BIG, -EINVAL with env->restart set, -ENOMEM), and
that *ps has been freed on every non-zero return, since bpf_flow_deliver()
relies on that with:

	return err < 0 ? err : 0;

The same thing happens a second time here: the comment starting "Two things
of which one is there" describes flow_null_pair() and flow_null_differs(),
but it is stacked above flow_callback_depth_differs() and its own comment,
well before flow_null_differs().  Could it move next to the function it
describes?

[ ... ]

> +static bool flow_unset_differs(const struct bpf_verifier_state *a,
> +			       const struct bpf_verifier_state *b)
> +{
> +	u32 fr, i;
> +
> +	for (fr = 0; fr <= a->curframe; fr++)
> +		for (i = BPF_REG_0; i < BPF_REG_FP; i++)
> +			if ((a->frame[fr]->regs[i].type == NOT_INIT) !=
> +			    (b->frame[fr]->regs[i].type == NOT_INIT))
> +				return true;
> +	return false;
> +}

Can flow_unset_differs() dereference a NULL frame here?

It walks frames 0 to a->curframe and reads b->frame[fr], and
flow_join_makes_up() does the same through flow_number_at(b->frame[fr], i).
Neither checks that a->curframe == b->curframe.  In flow_merge() the only
filter in front of them that relates to the call chain is:

	if (t->kind != s->kind)
		continue;

kind is a 32-bit jhash from flow_kind() with a fixed seed, so equal kinds do
not prove equal curframe.  flow_within() does compare curframe, but when it
fails, flow_merge() falls through to the next check instead of skipping the
state.

Frames above curframe are NULL: prepare_func_exit() sets
state->frame[state->curframe--] = NULL, and bpf_copy_verifier_state() frees
and NULLs frames above src->curframe.  So if a state t in the set has more
frames than the arriving s, and their kinds collide,
flow_unset_differs(&t->st, &s->st) reads a NULL b->frame[fr].  This needs
!widen and flow_has_room(), and frame[0]->subprogno has to match, which
happens when one function is reached through call chains of different depth.

The other helpers that flow_merge() calls in the same place
(flow_null_differs, flow_needed_consts_differ, flow_callback_depth_differs,
flow_earlier_trip, flow_same_iters, flow_within) all start with an explicit
curframe check, and bpf_states_join() checks it in join_check_state().

Should flow_unset_differs() and flow_join_makes_up() return false when
a->curframe != b->curframe, as the sibling helpers do?  flow.c is unchanged
after this patch in the series, so no later fix was found.

[ ... ]

> +	env->cur_state = &s->st;
> +	env->insn_idx = insn_idx;
> +	err = bpf_flow_loop_enter(env, &backedge, &drop);
> +	env->cur_state = cur;
> +	env->insn_idx = cur_idx;
> +	if (err || drop)
> +		goto err_free;
> +
> +	err = flow_merge(env, &flow->states[insn_idx], &s, backedge ? FLOW_CYCLE : cycle);
> +	if (err)
> +		return err < 0 ? err : 0;
> +	flow_set_pending(flow, s);
> +	return 0;

This isn't a bug, but the commit message argues soundness with a universal
claim:

	The verifier drops a state only when the set has a state that
	covers it. Thus a verified state covers each run of the prog.

The comment at the top of flow.c says the same, that an arriving state is
"dropped, if it is within a state of the set".

Here there is a second way to drop a state.  When bpf_flow_loop_enter() sets
*drop, the arriving state is freed through err_free and bpf_flow_deliver()
returns 0, and no state in any set covers it.  At the end of the series
(51224d16c11b) this happens on a back edge of a counted loop whose
iterations are walked apart, once ++entry->trip reaches
entry->max_header_count ("there is no such iteration at run time").

Soundness on that path does not come from coverage.  It depends on scalar
evolution giving a correct upper bound on the number of header visits.

Could the commit message and the comment at the top of flow.c name this
exception, and the assumption it relies on, so that the soundness argument
is complete?

[ ... ]

> +/*
> + * The call at @call_idx in @caller of a function that is verified on its own,
> + * @entry is the state at its first insn. Both are taken.
> + */
> +int bpf_flow_call(struct bpf_verifier_env *env, struct bpf_verifier_state *caller,
> +		  struct bpf_verifier_state *entry, int subprog, int call_idx)
> +{
> +	struct bpf_flow *flow = env->flow;
> +	struct flow_func *f = &flow->funcs[subprog];
> +	struct flow_waiter *w, *o, *on;
> +	int id;
> +
> +	caller->insn_idx = call_idx;
> +	list_for_each_entry_safe(o, on, &f->waiters, node) {
> +		if (o->call_idx != call_idx || o->dead)
> +			continue;
> +		/* it gets what the call that is there gets */
> +		if (o->st.flow_entry == caller->flow_entry && flow_within(env, &o->st, caller))
> +			return 0;
> +	}

This isn't a bug today, but the comment says both @caller and @entry are
taken, and that does not hold on every path.  When an existing waiter at the
same call_idx covers the caller, the function returns 0 before

	w->st = *caller;
	memset(caller, 0, sizeof(*caller));

and before bpf_flow_deliver() takes @entry.  The flow_entry_new() and
kzalloc_obj() error paths leave both states untouched too.

The only caller, call_func_on_its_own(), frees 'entry' with
bpf_free_verifier_state(&entry, false) in every case, and process_bpf_exit
frees env->cur_state, so nothing leaks now.  A caller that trusted the
comment and skipped the free would leak the callee frame on the covered
path.

Could the comment say that the states are taken only when the call has to
wait, or could bpf_flow_call() empty both states on every path?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/40263142572
--===============1253832364625648183==--
