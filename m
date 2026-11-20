Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795211494;
	b=H7fjdqVSFVcfKWD2G/CDDEU8CIF2pKidXcw7Bsmwv6bQR2Rt7qG/6oWWTkPH7iAqq5PT
	 EmvlNEaS/RcDCrwB47FvwOaYBEbuX9bcoaj/ydNslvuoPxd//o/g8wvBv1Ok2ZB5Pu0Ah
	 aGt6joYn929lBlNmhyJXgqppcdu6NAYXypnCgbgb8p5WTNIRwWzsXpLNHgfNHrTB5uevb
	 gqgNnRXekLNou3+HdKMmfGquJ70V14uYEsXiqdr68MFn9p0FfrB87Ldamgj2RHZnUo39B
	 bQSrRrlir7bGTdqf2zfg+pjMM0qYKhVD/5ukjrlJvG70ph0q9+/hMWAHq2TFScQaF5g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795211494;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=Qq8dGqhXf+/osB1gUVAahLhAGa5Z76O9oWMv3z3Vik8=;
	b=gk+bco4JC36P7KhhuvNK3wrfhkchWkxK9oGW6b+xD/hOA6kbdONe1h29htotFqzM8h09
	 TS0zoKqm//ps7F5GrXJGhR2UIU+IHX+VeWFtAuq7lvaZeHcgYer7ar2hGqYW/CfYoRjqg
	 PC+lixJeAYP81K+jEeXL57SSSf2rlaWKsHQbAtoH67NUmcgZMuPKwfS4a8TTPfgzTTsta
	 0Gl0EQfZiertBF1X/2gfXi/EdVBf60PxquRG1WM4c0D8Ym8qvUFQfKRW6s7cDu6NXg+qy
	 4j5tcxc1zYNcNe5l9Hogbq7mV0xgKWTemNVudykjM6L5g9h+earxN4a6iRxZ8+jj9tg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jTFlp8M7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81B3F606A696
	for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 21:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jTFlp8M7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E68C1F000CF;
	Fri, 20 Nov 2026 21:51:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795211493;
	bh=Qq8dGqhXf+/osB1gUVAahLhAGa5Z76O9oWMv3z3Vik8=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=jTFlp8M73dlFrVm0WuCT33en3uY1SJrfH/2i4NtL/1cjqN/7hlbVcvX10kNxHtYpm
	 SQdKlGkBkpP667pH7pNu+iynO9Adk13lVaByfmu9z5kRfWcWu/bGRnt+fD9SYqVtzP
	 XdfkEwZ7z0vDmb9SaduKcfbKKWUo1pMYHO3s2RXTWAM3DW0orkqQkE4Orpn7K94kXf
	 7A56iXu/Si5YKV6kBQdrQUekP+ZjBYgyOtwBb0yFEMa98xg0ACASSalZusT0iUJ/dV
	 X2aDrAXvyrhrFZnABcIoQvjVe1ZQ1gF2/bkRiNNv81dOpGdkBJ6L+uGdvNuHRaRhNC
	 mErF7UTD7bc3w==
Content-Type: multipart/mixed; boundary="===============8164250284931253104=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <09944de90bdaa1d82149bce7c2e1e1682e678f783e558097d7f6af5b2490252d@mail.kernel.org>
In-Reply-To: <20261120204959.614908-35-alexei.starovoitov@gmail.com>
References: <20261120204959.614908-35-alexei.starovoitov@gmail.com>
Subject: Re: [PATCH bpf-next v2 34/49] bpf: Partition the states after an error
From: bot+bpf-ci@kernel.org
To: alexei.starovoitov@gmail.com,bpf@vger.kernel.org
Cc: daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Fri, 20 Nov 2026 21:51:32 +0000 (UTC)

--===============8164250284931253104==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Partition the states after an error

TL;DR:
- bpf_undo_precision() may drop -ENOMEM/-E2BIG from partition_next(), so the
  load fails with the wrong error
- charge_loops() may skip charging outer loops on entering a peeled inner loop
- IN_FRAMES may change nothing for callx sets
- stale return comments

> diff --git a/kernel/bpf/equation.c b/kernel/bpf/equation.c
> --- a/kernel/bpf/equation.c
> +++ b/kernel/bpf/equation.c

[ ... ]

> +/* At a call bpf_equations_before_insn() moves the equations of r1-r5 to the next frame */
> +u16 bpf_args_with_equation(const struct bpf_verifier_state *st)
> +{
> +	u16 args = 0;
> +	u32 r;
> +
> +	for (r = BPF_REG_1; r <= BPF_REG_5; r++)
> +		if (bpf_find_xreg_equation(&st->equations, bpf_xreg(st->curframe + 1, r)))
> +			args |= BIT(r);
> +	return args;
> +}

Can IN_FRAMES take effect for a callx through a function set?

The first time do_check_block() checks the callx, bpf_equations_before_insn()
runs before do_check_insn() and moves the equations of r1-r5 from frame fr to
frame fr+1, deleting the ones in frame fr:

    if (r && (bpf_pseudo_call(insn) || bpf_is_callx(insn)))
        copy_xreg_equation(env, eqs, bpf_xreg(fr + 1, r), bpf_xreg(fr, r));
    bpf_equations_forget_xreg(env, st, bpf_xreg(fr, r));

With in_frames set, check_func_callx_set() sees func_is_on_its_own() return
false for a member and re-queues the same insn:

    if (!func_is_on_its_own(env, cur, set->subprog[i])) {
        branch = push_stack(env, *insn_idx, *insn_idx, false);
        ...
        env->head->again = true;

push_stack() copies the state after before_insn(), so frame fr+1 has the
argument equations and frame fr has none.

When that copy comes back to do_check_block() at the callx,
bpf_equations_before_insn() runs again.  The BPF_CALL branch drops the fr+1
equations, and copy_xreg_equation() then copies from frame fr, which is now
empty.

On the re-check, func_is_on_its_own() -> bpf_call_needs_frames() computes
args &= bpf_args_with_equation(st), which is 0, so it returns false and
func_is_on_its_own() returns true as it did before the partition.

So for a callx through a function set the IN_FRAMES partition seems to change
nothing: the pass repeats the same error and spends budget.  Is that
intended, or should callx sets be excluded from IN_FRAMES (or the equations
kept across the second before_insn())?

[ ... ]

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> +/*
> + * The loops that keep the current state apart pay for the work since the last state, but not
> + * a loop that the state enters. A trip that is peeled on the budget of a loop belongs to that
> + * loop. Such trips can use up the budget of an inner loop.
> + */
> +static void charge_loops(struct bpf_verifier_env *env, u64 cost)
> +{
> +	const struct bpf_verifier_state *st = env->cur_state;
> +	const struct loop_stack_entry *e;
> +	struct bpf_loop *starved_loop = NULL;
> +	int fr, i;
> +
> +	for (fr = st->curframe; env->pass && fr >= 0; fr--) {
> +		for (i = st->frame[fr]->loop_stack_cnt - 1; i >= 0; i--) {
> +			e = &st->frame[fr]->loop_stack[i];
> +			if ((e->peeled || e->loop->disjoint_apart) &&
> +			    (e->trip || e->loop->header != st->insn_idx))
> +				e->loop->this_pass.cost += cost;
> +			if (e->peeled && e->trip >= e->loop->peel_cnt) {
> +				if (starved_loop && e->loop->partitioned)
> +					starved_loop->this_pass.starved =
> +						e->loop->this_pass.starves = true;
> +				return;
> +			}

The header test correctly skips the charge for a loop the state has just
entered, but the early return below it also fires for that loop.

Consider an inner loop I with peel_cnt == 0 that is being peeled on its
budget, nested in an outer loop O that keeps the state apart.  When the state
reaches I's header, I is on the loop stack with trip 0 and charge_loops() is
called with the cost of the block just run in O's body:

- I is not charged (trip == 0 and header == insn_idx), as the comment says
- e->peeled && e->trip >= e->loop->peel_cnt is true && 0 >= 0, so the
  function returns
- O is never visited, so the cost of that block is charged to no loop

This repeats on every entry into I, once per trip of O.  O's this_pass.cost
then reads lower than the work done in the states it keeps apart, which
feeds bpf_loop_has_budget(O), bpf_loop_partition_is_active(O), the
over_budget test in bpf_undo_precision() and the full_peel_cost estimate in
undo_loop().

When a state has just entered a budget-peeled inner loop at trip 0, should
the return be skipped so that the outer loops still pay for the block before
the inner loop?

[ ... ]

> diff --git a/kernel/bpf/precision.c b/kernel/bpf/precision.c
> --- a/kernel/bpf/precision.c
> +++ b/kernel/bpf/precision.c

[ ... ]

> +/* The pass is over its budget. Returns true if another partition replaces the last one. */
> +bool bpf_undo_precision(struct bpf_verifier_env *env)
> +{

[ ... ]

> +	env->over_limit = false;
> +	memcpy(prec->data_deps, prec->undo, 5 * prec->words * sizeof(long));

[ ... ]

> +	if (partition_by[__ffs(prec->partitioned_by)] != partition_suspect_loops && !again)
> +		prec->too_costly |= prec->partitioned_by;
> +	return partition_next(env) > 0;
> +}

Can this drop an error from partition_next()?

partition_next() always runs add_deps() first, which reaches
compute_deps_of_unproven() -> add_control_deps() -> find_control_seeds() and
bpf_compute_deps().  These use kvmalloc_array() and kvcalloc() with
BPF_VERIFIER_GFP (which includes __GFP_RETRY_MAYFAIL), so they can return
-ENOMEM without setting env->no_mem.  bpf_add_cost_and_check() on the same
path can also return -E2BIG or -EINTR.

The "> 0" test turns any of these into false, after the partition has already
been undone (data_deps restored, undo_loop() called, env->over_limit
cleared).  With do_check_all() as wired up in 02e7abee2ca0 ("bpf: Verify in
passes"):

- If the pass had no error and only ran over its budget (env->err == 0), the
  caller computes limit = !env->err and rejects the load with the pass's
  -E2BIG instead of -ENOMEM.
- If the pass had an error, the caller goes on to bpf_partition_more() on a
  pass whose partition is already undone, which swaps this_pass into
  last_pass and may call keep_precision().  The retry repeats the same
  allocations, and env->aborted is sticky but -ENOMEM is not, so -ENOMEM is
  the error that gets lost.

bpf_partition_more() returns its errors as an int and the caller handles them
with "if (more < 0 && more != -E2BIG) err = more;".  The same
"return partition_next(env) > 0;" is still present at the end of the series.

Could bpf_undo_precision() return int, as bpf_partition_more() does, so that
do_check_all() can stop with the real error?

[ ... ]

> + * Returns 1 if more is kept apart.
> + */
> +int bpf_partition_more(struct bpf_verifier_env *env)

This isn't a bug, but the return value comments don't match the code.

When no partition is left, partition_next() returns "wait":

    wait = wait && prec->budget < env->max_cost - env->cost;
    prec->budget_left = prec->budget = min(4 * prec->budget, env->max_cost - env->cost);
    prec->failing_path_due = prec->budget_grew = true;
    return wait;

so bpf_partition_more() can return 1 when nothing more is kept apart; the
next pass then undoes to the last keep with a larger budget.  The function
can also return a negative error (from alloc_masks(), find_calls_to_unproven()
or a partition step), which the comment does not mention, although the
driver depends on it (last |= more != 1).

Similarly, the comment above bpf_undo_precision() says "Returns true if
another partition replaces the last one", but it also returns true when only
the budget grows (partitioned_by = 0).  It also says "The pass is over its
budget", yet the function is called after every pass and returns false at
once when !env->over_limit.  Could these comments be updated?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/44817467639
--===============8164250284931253104==--
