Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794025985;
	b=txNkliZZuKVcC3R4HCDW0OqiqvPASdwyJaX2HPQTtZgj5+UPLLcaV4SroT91HQAVjjqt
	 aoJUa/XM9aurj2LbVNzdG+rkQoRnmgmuuP0ZoR5roZRZvlgK3wtwbItQHkxDlIMPp98xg
	 oWBZZDj4TFjraG47kSDeFHPPVhX+XChstbwKX40gKV9fmtA++UJHYowmiIGlP/DkYYHCQ
	 Gz++qfojoqkiD2jDeYLExeSFTkR/Ot4uVnu6LwnZzr2kH9Zp/QXO/rRwSkBVmy2gkfY6K
	 ZKD9XUw/x0Y1ueQxtNR0xhnNXM0dUk4eAl1GNyLYl+jMZGHbttZBdGQOmrqlxrlw6Gw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794025985;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=9kqEuqUnbPu02Bub1iYMi8hYFci1L9J2d80l8/bpoRo=;
	b=XR+mP9jgmbeJpBhAB3N+5bZzADOwvhSdSeHL1cF31vZUZ0QF1JbSY/wIqc0PDMpiFbfi
	 chCZtvBSqbP3ngL/oyGav66bLpF6a4Nba3p1v0n49ZdM3WsmSHZnyfWGvsUTA2ff8gr8P
	 dxKX9pQuTc070tmvda2CeuKZc5J41ByAZ1AiNAfp3bUACKkV9c3UWk7o/s0ctF7JmatEY
	 HNKQWb6SZiI1jc0qcF9ddSjcgc3GH+kZfxPdWCUlS/tjUrOojJON4ubmE8krCr0oXkXtO
	 zy2PE5lCGCzvlWl8D7UrwmVz50sUkUJYSOkXuQTrABJOjoLAULbIydVldeATNMTg4ww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ceuj8HA4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12199606A326
	for <bpf@vger.kernel.org>; Sat,  7 Nov 2026 04:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ceuj8HA4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 702A41F0089F;
	Sat,  7 Nov 2026 04:33:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794025984;
	bh=9kqEuqUnbPu02Bub1iYMi8hYFci1L9J2d80l8/bpoRo=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=Ceuj8HA47+EgOU11CrUP3JVzywDyRwpPx0fmJWg15FkrDcmDGLbdILEF5YJXV6DzK
	 bKNpCKAkS25PDR9erpEaq6kcHQSuVPhPaDrGFihEyx2A0FUoN26wZDjBHTjYQlc6vf
	 IcS+wlH++wmcxnAI0+B7Gm3q4FAbCD6rzN4dVBTBQtWVWmyOzsuGhUR//6veyMR9Od
	 5SogF4sgIC9v1gn1DGR9a+z6C4q8sBDpaq+kVyiKGYuKFG/Z/1Gso6R1zuryCHdAXo
	 +Hrv0GOFmuTmxNrw8ogeWmKw9/duU5Eq/udW6wIM7+d67H73sts9TN0hCite1Azebl
	 wBgrun+rQQ90g==
Content-Type: multipart/mixed; boundary="===============5145106238266065474=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <c8433390be7e9e39a545779f4c918dac491ab9cae03f807ecd4d4127940548a2@mail.kernel.org>
In-Reply-To: <20261107033758.1547725-20-alexei.starovoitov@gmail.com>
References: <20261107033758.1547725-20-alexei.starovoitov@gmail.com>
Subject: Re: [PATCH bpf-next v4 19/46] bpf: Verify programs as a fixpoint over the control flow graph
From: bot+bpf-ci@kernel.org
To: alexei.starovoitov@gmail.com,bpf@vger.kernel.org
Cc: daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Sat,  7 Nov 2026 04:33:04 +0000 (UTC)

--===============5145106238266065474==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Verify programs as a fixpoint over the control flow graph

TL;DR:
- Unwind-exit as bail_insn may let verifier accept programs where caller sees
  r0=0 after may_goto bail (possible NULL deref/OOB)
- Callback reference-release rule may reject previously loadable programs
- Loop-exit check may wrongly reject programs; offloaded loops possibly
  rejected

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> @@ -3456,13 +3479,23 @@ static int next_callx_callee(struct bpf_verifier_env *env, int caller, int from)
>  static int check_unwind_insns(struct bpf_verifier_env *env)
>  {
>  	struct bpf_insn *insn = env->prog->insnsi;
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
>  		}
>  		if (!bpf_is_unwind_goto(insn))
>  			continue;

Can bail_insn end up pointing at an unwind_exit here?  The test
insn->code == (BPF_JMP | BPF_EXIT) also matches an unwind_exit, since
bpf_is_unwind_exit() is the same code with src_reg == BPF_UNWIND_EXIT.

push_budget_exit() later pushes a state to sub->bail_insn and sets
branch->unwound = sub->bail_unwinds.  Nothing in this commit assigns
bail_unwinds, so it is always false.  But when bail_insn is an unwind_exit,
prepare_func_exit() unwinds anyway:

    if (bpf_is_unwind_exit(&env->prog->insnsi[*insn_idx]) || state->unwound) {
        ...
        state->unwound = true;

so the caller is verified only at the unwind_goto landing pad.

The insns that are inserted after the main pass do something else.
bpf_insert_loop_guards() -> append_budget_exit() -> budget_exit_insn()
emits:

    if (!sub->bail_unwinds)
        return BPF_EXIT_INSN();

That is a plain 'r0 = 0; exit'.  The subprog returns normally, unwind_goto
emits no branch in the JIT, and the caller continues after the call with
r0 = 0.  The verifier never checked that path with r0 = 0.

Consider a static subprog whose last exit is an unwind_exit, with a loop
whose header guard reaches code that reads a register the head does not
set (the glob_match() case from the commit message).  check_loop_guard() ->
guard_reads_unset_reg() sets guard_unset_reg, budget_can_unwind() returns
true through or_exit, and push_budget_exit() is called.  If the normal
exits return a non-NULL PTR_TO_MAP_VALUE and the caller dereferences r0
right after 'call; unwind_goto', or return [1, N] and the caller uses
r0 - 1 as an index, the program loads.  When may_goto runs out of budget
the caller then dereferences NULL or accesses memory out of bounds.  This
needs CAP_BPF and a JIT with unwind support.  The fall-through after
unwind_goto is only a speculative path, and not followed at all when
bypass_spec_v1 is set.

The commit message says "A subprog that holds nothing is left with
'r0 = 0; exit' then. Its caller is verified with 0."  Is that true for
this case?

If the unwind_exit is dead code for a caller that has no unwind_goto, the
same state would instead get a spurious "unwind_exit, but no unwind_goto
after the call" rejection.

Would skipping unwind exits when choosing bail_insn, for example
'insn->code == (BPF_JMP | BPF_EXIT) && !bpf_is_unwind_exit(insn)', keep the
stand-in neutral whatever bail_unwinds says?  b9dc59a51bf3 ("bpf: Allow
recursive subprogs") later sets bail_unwinds = can_unwind || ..., which
makes the two agree again, but this commit and the next two
(bc7d16f2f77e, 6a00b2a0a6a9) have the mismatch, which matters for
bisection.  The same mismatch shows up in push_budget_exit() and in
check_loop_guard() below, where a LEAVES_SUBPROG guard edge is verified as
an unwind but emitted as a plain return.

[ ... ]

> @@ -12558,12 +12642,22 @@ static int prepare_func_exit(struct bpf_verifier_env *env, int *insn_idx)
>  	if (callee->in_callback_fn) {
>  		if (r0->type != SCALAR_VALUE) {
>  			verbose(env, "R0 not a scalar value\n");
>  			return -EACCES;
>  		}
>  
> +		/* It's called any number of times: what it takes it has to release. */
> +		for (i = callee->entry_refs; i < state->acquired_refs; i++) {
> +			if (state->refs[i].type != REF_TYPE_PTR)
> +				continue;
> +			verbose(env, "Unreleased reference id=%d alloc_insn=%d\n",
> +				state->refs[i].id, state->refs[i].insn_idx);
> +			bpf_diag_leak(env, state->refs[i].id, state->refs[i].insn_idx, *insn_idx);
> +			return -EINVAL;
> +		}
> +
>  		/* we are going to rely on register's precise value */
>  		err = mark_chain_precision(env, BPF_REG_0);
>  		if (err)
>  			return err;

Is it intended to bring back the rule that a synchronous callback must
release every REF_TYPE_PTR reference it acquires?  ae6e3a273f59 ("bpf:
Drop special callback reference handling") removed that rule on purpose,
because callbacks are verified as called an unknown number of times.

A program like this used to load:

  static int cb(u32 i, struct ctx *c)
  {
      if (!c->t)
          c->t = bpf_task_acquire(task);
      return 0;
  }
  ...
  bpf_loop(n, cb, &ctx, 0);
  if (ctx.t)
      bpf_task_release(ctx.t);

On the iteration that acquires, refs[entry_refs] is the task reference, so
the new loop rejects it with "Unreleased reference".

The fixpoint does not seem to need this rule for soundness.  States with
different refs[] are never joined (refsafe() and join.c compare them), so
a callback that leaks on every call still hits the state limits or the
leak check at the main exit.

The "What user space sees" list in the commit message does not mention
this change in which programs are accepted.  Should the commit message say
so, or should the check be narrowed?

[ ... ]

> @@ -21243,13 +21359,32 @@ static int loop_stack_push(struct bpf_verifier_env *env, bool *pushed)
>  	if (!frame->loop_stack)
>  		return -ENOMEM;
>  	loop_stack = frame->loop_stack;
>  
>  	for (; num_missing; num_missing--, cnt++) {
>  		h = missing_headers[num_missing - 1];
> -		loop_stack[cnt] = (struct loop_stack_entry){ .loop_id = h };
> +		/* wherever it is entered: a loop can have more than one entry */
> +		if (!aux[h].loop->exits_cnt) {
> +			verbose(env, "loop at insn %d never exits\n", h);
> +			return -EINVAL;
> +		}

Can exits_cnt be zero for a loop that does have an exit?  struct bpf_loop
documents that @exits can be incomplete:

    /* @exits of a loop in this one is cut. Then @exits of this loop can
       lack exits too. */
    bool nested_exits_overflow;

In the exit computation in kernel/bpf/loops.c, once the innermost loop of
an insn has overflowed (more than MAX_LOOP_EXITS == 256 exits), later
edges from that insn are not recorded for any loop:

    iarray_for_each(s, succ) {
        if (aux[iloop].loop->exits_overflow)
            break;
        ...
        for (t = iloop; t >= 0 && t != sloop; t = aux[t].loop_header) {
            ...
            err = add_exit(aux[t].loop, i, s);

So an outer 'for (;;)' loop that is left only from the body of a nested
loop with more than 256 exits (a large switch, or a gotox whose shared
jump table leaves the inner loop), where those jumps come after the
overflow point, ends up with exits_cnt == 0 and nested_exits_overflow set.

Such a loop can still be walked to its end by flow_try_walk(), or guarded
at a dominating jump that leaves it, since flow_set_guard() uses loop
membership and not @exits.  Before this check the program could load.  Now
it is rejected the first time a state enters the loop, with a message that
is not true.

Should the check be skipped when @exits may be cut, for example
'!aux[h].loop->exits_cnt && !aux[h].loop->nested_exits_overflow'?  The
code at the end of the series (d39416384f5a) is the same, so no later
commit changes this.

[ ... ]

> @@ -21627,59 +21710,238 @@ int bpf_flow_loop_enter(struct bpf_verifier_env *env, bool *backedge, bool *drop

[ ... ]

> +	if (!entry->guarded && !bpf_loop_walk_may_give_up(entry))
> +		return 0;
> +
> +	/* the device runs the insns that the driver was given, without may_goto */
> +	if (bpf_prog_is_offloaded(env->prog->aux)) {
> +		verbose(env, "loop at insn %d has no known bound in an offloaded program\n", h);
> +		return -EINVAL;
> +	}

Does this reject offloaded programs with a loop that the walk would have
accepted?

For a loop that SCEV does not count, flow_try_walk() sets entry->apart and
entry->terminates and leaves entry->guarded at loop->guarded, which is
false at first.  At this commit entry->counted is never set, so
bpf_loop_walk_may_give_up() (apart && terminates && !counted) is true.
The early return is not taken, and the offload check returns -EINVAL on
the first trip, before the walk has decided anything.

That contradicts the commit message ("counted, or walked to its end:
nothing is added").  It is also a regression against the parent commit,
where do_check() followed the paths of such a bounded loop and accepted
the program, and NFP supports backward jumps.

When the program is not offloaded, the edges pushed here are dropped by
bpf_flow_guard_edge() while the loop has no may_goto.  For offloaded
programs, would it be enough to reject once entry->guarded is set?
flow_end_walk() copies loop->guarded into entry->guarded when a walk gives
up, so a loop that really needs may_goto would still be rejected on the
next pass through the guard place.  The check is the same at the end of
the series (d39416384f5a).


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/42335829855
--===============5145106238266065474==--
