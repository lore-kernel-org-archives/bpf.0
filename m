Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A734B3FD969
	for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 23:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790206643; cv=none; b=fMl37josNtExoyW4TM6lz+jIMcX9yoh9YskUz867yVrPZx1ZzQbNsDXwYty2qQtNrW9sRoZSnIhpFPmsi2tepKgWVmGFBKC7m2KXkPkKWQ00xJMzXPlSeFRP0/EdXFFSnPoxQzFpeV6NwgF4yq8cH28Bju/NuaQaEOX0KhcO7Jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790206643; c=relaxed/simple;
	bh=2a2E6eFvf144WYgIjvIZAQw2TWgl8T59rIZlHFTls7Q=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=kY0gRD+RV3jU/mMRJHMKQB2g//eTVzYfYODxGa8RAgAW/FHCNwG0GqDUmNksFFxOIm+Twpf77bSegRug7uB0OC/y4BNmA00UNkHm+kTwWJvZUffOfQ2uekhFoy7pbEvou5vEq00VSrCIQ/PLMGhri0VNMWTnB0BrcUrMDEAsI1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NJO1Y4AI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NJO1Y4AI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9FFC1F000FF;
	Wed, 23 Sep 2026 23:37:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790206641;
	bh=S8WsYRHMymuSuE2DxdQgc3vpiWloIOqXPxVJ4C3WgQY=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=NJO1Y4AIyvGxJDyFliHr3NaIOnFQuT2wBqbkDUWdAyZl3gyGBDrAJTFPUi5EIYYIz
	 Ss/ckaVQzc0EaDVyIFWvmoJI6SMdiwPZB5h1CwUS0d/W6ySf7HPRgxnKO9rcvpk0de
	 KDAt8DqkI8b+twFGuRvwJTEYiS1br/vEfx7S6OO0F+XJRRS/4rz/7TRIoEOm0myyQF
	 hoqd7qLlTRK/Bd1hOjmAjlYuL+KCfyWdKDENe1Xv1BJ5hPoxfHETNRsTUVN72Vy18S
	 suysmhGzCgDk+GtL4p7jIjnu+k6bD4cXGZlMFb55Wu6wPIDHHh6vDdDOim7bYIuXyo
	 l9l5Tmmy7kScA==
Content-Type: multipart/mixed; boundary="===============3495949293045538196=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <092fc6388e27aa21a2c8c2539c6ff37ba824a13228d6fc7ecb8eaaeff14a4ce3@mail.kernel.org>
In-Reply-To: <20260923223554.562379-5-alexei.starovoitov@gmail.com>
References: <20260923223554.562379-5-alexei.starovoitov@gmail.com>
Subject: Re: [PATCH bpf-next 4/8] bpf: Detect loops that never exit
From: bot+bpf-ci@kernel.org
To: alexei.starovoitov@gmail.com,bpf@vger.kernel.org
Cc: daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Wed, 23 Sep 2026 23:37:19 +0000 (UTC)

--===============3495949293045538196==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index 981902cd5b71a..60f483d7e4a96 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h

[ ... ]

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 85b2691f81b12..06dc269991b22 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -19192,6 +19192,21 @@ static int do_check_insn(struct bpf_verifier_env *env, bool *do_print_state)
>  	return -EFAULT;
>  }
>
> +/* Did the jump at @prev take the walk out of the loop @prev is in? */
> +static bool left_loop(struct bpf_verifier_env *env, int prev, int insn_idx)
> +{
> +	struct bpf_insn_aux_data *aux = env->insn_aux_data;
> +	struct bpf_insn *insn;
> +
> +	if (prev < 0 || prev >= env->prog->len || !aux[prev].scc ||
> +	    aux[prev].scc == aux[insn_idx].scc)
> +		return false;
> +	/* the callee is not in SCC of the call, the insn after the call is */
> +	insn = &env->prog->insnsi[prev];
> +	return !((BPF_CLASS(insn->code) == BPF_JMP || BPF_CLASS(insn->code) == BPF_JMP32) &&
> +		 BPF_OP(insn->code) == BPF_CALL);
> +}

Does left_loop() handle sync callback-calling helpers correctly?

The comment says "the insn after the call is" in the SCC of the call,
which holds for bpf-to-bpf calls inside a loop. But for a sync
callback-calling helper outside any loop, bpf_compute_scc() gives the call
insn C its own singleton SCC:

kernel/bpf/cfg.c:bpf_compute_scc()
	if (bpf_calls_callback(env, w)) /* implicit loop? */
		assign_scc = true;

The insn C+1 is outside that SCC. When the helper returns and do_check()
calls left_loop(env, C, C+1), aux[C].scc is nonzero and differs from
aux[C+1].scc, but the function returns false because insn C is BPF_CALL.
So bpf_scc_mark_exit() is never called for the only edge out of that
implicit loop.

The callback convergence branch in bpf_is_state_visited() always adds a
backedge:

kernel/bpf/states.c:bpf_is_state_visited()
	if (bpf_calls_callback(env, insn_idx)) {
		if (states_equal(env, &sl->state, cur, RANGE_WITHIN)) {
			loop = true;
			goto hit;

The checkpoint at C never marks visit->exited, so when it reaches
branches == 0, maybe_exit_scc() sees backedges != NULL and exited ==
false:

kernel/bpf/states.c:maybe_exit_scc()
	if (env->widen_loops && !st->speculative && visit->backedges && !visit->exited) {
		verbose(env, "loop at insn %d never exits\n", st->insn_idx);
		env->widen_used = true;
		return -EINVAL;
	}

and fails with "loop at insn %d never exits" for helpers like bpf_loop,
bpf_for_each_map_elem, bpf_find_vma, bpf_user_ringbuf_drain,
bpf_rbtree_add, and others.

After commit c7896d6154118 enables widen_loops for every bpf_capable
program with more than one SCC, this false verdict causes the widened walk
to fail and fall back to walking every iteration again. That roughly
doubles verification work, removes the benefit of widening for the whole
program, and leaves a false "never exits" message in the log. A program
that uses a callback helper and has a loop that only verifies when widened
remains rejected.

A minimal reproducer is:

	r1 = 10
	r2 = cb
	r3 = 0
	r4 = 0
	call bpf_loop
	r0 = 0
	exit

with cb returning 0.

Should the fallthrough of a callback-calling insn (insn_idx == prev + 1)
be treated as a normal edge rather than excluded?

> @@ -19358,6 +19375,9 @@ static int do_check(struct bpf_verifier_env *env)
>  		} else if (err < 0) {
>  			return err;
>  		} else if (err == PROCESS_BPF_EXIT) {
> +			/* exit or bpf_throw() inside of a loop */
> +			if (env->widen_loops)
> +				bpf_scc_mark_exit(env, state, env->insn_idx);
>  			goto process_bpf_exit;

Can bpf_throw() from a callee mark the caller's loop as exited?

bpf_scc_mark_exit() only marks the visit whose SCC contains env->insn_idx
in the current frame, and only when no outer callsite is in an SCC:

kernel/bpf/states.c:bpf_scc_mark_exit()
	if (st->speculative || !env->insn_aux_data[insn_idx].scc)
		return;
	...
	for (i = 0; i < st->curframe; i++) {
		callsite = bpf_frame_insn_idx(st, i);
		if (env->insn_aux_data[callsite].scc)
			return;

An exception ends the whole program, so it leaves every enclosing loop.
But if bpf_throw() or bpf_assert() is in a static subprog called from a
loop body:

	l: ...
	   call foo
	   goto l

and foo() throws on some path, the caller's loop is never marked:

- If foo has no loop, the throw insn has scc 0 and the function returns at
  the first check.
- If foo has a loop, frame 0's callsite is in an SCC and the function
  returns in the loop.

If the throw is the only way out of the loop, the widened walk fails with
"loop at insn N never exits". After commit c7896d6154118 this costs a full
re-walk, and the fallback may then reject the program with "infinite loop
detected". The same assert inlined in the loop body is accepted.

Should exception exits mark the visit that compute_scc_callchain() picks
for the state (the outermost frame in an SCC) instead?

Also, the "exit" half of the comment never happens: an exit insn has no
CFG successors so its aux->scc is always 0, and PROCESS_BPF_EXIT from a
real exit only happens at curframe 0. Only the throw half of this hunk
does anything.

> diff --git a/kernel/bpf/states.c b/kernel/bpf/states.c
> index 22987ce070e74..39e6052922e59 100644
> --- a/kernel/bpf/states.c
> +++ b/kernel/bpf/states.c

[ ... ]

> @@ -1462,6 +1499,9 @@ int bpf_is_state_visited(struct bpf_verifier_env *env, int insn_idx)
>  		if (states_equal(env, &sl->state, cur, loop ? RANGE_WITHIN : NOT_EXACT)) {
>  hit:
>  			sl->hit_cnt++;
> +			/* what follows the old state was seen, it may leave the loop */
> +			if (env->widen_loops && !sl->state.branches)
> +				bpf_scc_mark_exit(env, cur, insn_idx);

Can this mark set visit->exited for a loop that never exits?

The mark fires whenever cur is pruned by any fully explored state. That
includes a checkpoint created inside the same visit whose whole subtree
only went around the loop.

Consider a loop with a counter and an unpredictable branch, with no edge
out of the SCC:

	r6 = 0
	l: r6 += 1
	   call bpf_get_prandom_u32
	   if r0 > 5 goto a
	   goto l
	a: goto l

Walk with widen_loops:

1. L1 (r6 = 0) at l becomes entry_state. Trip 1 pushes branch B1 (r6 = 1)
   at the if.
2. The fallthrough reaches l with r6 = 1. That is not within L1, so it is
   widened and a new checkpoint L2 (r6 unknown) is added to the head of
   the explored list.
3. Trip 2 pushes B2 and converges on L2 through a backedge. B2 also
   converges on L2 while L2 is still in progress, so neither hit sets the
   mark. L2 reaches branches == 0, and maybe_exit_scc(L2) returns early
   because L2 is not the entry_state.
4. B1 is popped and reaches l with r6 = 1. It is compared against L2
   first. L2 is a superset, so the result is a hit with
   !sl->state.branches, and bpf_scc_mark_exit(env, cur, l) sets
   visit->exited = true.
5. When L1 completes, maybe_exit_scc() sees exited == true and accepts the
   loop.

The program then spins until the may_goto budget runs out and bpf_throw()
fires. Before this series such a program was rejected with "BPF program is
too large" or "infinite loop detected".

The commit message lists pruning by a fully explored state as a way of
leaving the loop. Is this over-approximation intentional, or should the
mark only fire when sl belongs to a different (earlier or outer) visit?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/35929952632
--===============3495949293045538196==--
