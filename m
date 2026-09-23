Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26C1D400995
	for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 23:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790206632; cv=none; b=WHwrUie2XYAxq4zMbGY/Ztpv/v3AFWk/9Uv2QnhyLNxbFCMvjLA9Jiz+Uea0FVVGuKr89+hSe7FIky+fdDHdVY0nhA0HhSvgXaTOtcB7S9xlKuStmrlw9CXdHXfNRyAJRcTMuhtErxDjRl1gCHNHx2xumHBJ1w7UTfculsMkQaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790206632; c=relaxed/simple;
	bh=rBkYJ4vkBFl9C3+CrdvVSqZWv8Vo9Qzba6Qocv0jUJw=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=BQqwbb+YItPPtLe+8PiS55dlh4VYnQtIeRwt1mv8s1Kcl+NACgaXpTXPgiA0Kl/s+rU724NGZNnDSfzPH5//abWVDupFX7vrtoQlDBbI3Azp4aKp2DPdZZ00j4EPnvvUN9mPaNrC/fib/Ec5YrVyIE1kFezd6KQH9FgTpa6ROLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ITAeHtzq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ITAeHtzq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C3171F000FF;
	Wed, 23 Sep 2026 23:37:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790206630;
	bh=r3HpWZO0F4UpFzXwJg/20YlhF0166HvHabyef7qdMQg=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=ITAeHtzqCR9+lRT3wYvcaPQC5JPfWUK/0XQxtmCdArYapOrAVxOMdqAgLlcRLgQzW
	 c3IY2k3OpSDbBzJ0B5BHo6kYZLdslwbOnHSi4rztCAldudZ16BY+l6la3CoscD5jPP
	 gzED0nC7zHPPmVXcly4pjCAIBGJeFu+Erktx9ol2sH4DKNhBA3eusCeZxv4MmAhsDf
	 ow6MjExC2slZkNj3yD1bn0L7LzttIailw1wVhYHq4TeUfu9mixk3MEHb6D6V7MPfht
	 rj2VbONSCkZ3rE2JgtLFmEm5B/pfzAlosBuUdkVqlGE5cNTZOrHo6ulm66srLW4mBo
	 o0Wh8XyT4CKLg==
Content-Type: multipart/mixed; boundary="===============0462094654699547438=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <5073f8a5b50800bbcc6724199bafee6e347ea6de01e049b4c890723d8ba44726@mail.kernel.org>
In-Reply-To: <20260923223554.562379-6-alexei.starovoitov@gmail.com>
References: <20260923223554.562379-6-alexei.starovoitov@gmail.com>
Subject: Re: [PATCH bpf-next 5/8] bpf: Add may_goto to loops that are not walked to the end
From: bot+bpf-ci@kernel.org
To: alexei.starovoitov@gmail.com,bpf@vger.kernel.org
Cc: daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Wed, 23 Sep 2026 23:37:09 +0000 (UTC)

--===============0462094654699547438==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index 60f483d7e4a96..fb35f8a7aedd2 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h

[ ... ]

> diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
> index 2add8001c3ec3..2b965fa4bacc0 100644
> --- a/kernel/bpf/fixups.c
> +++ b/kernel/bpf/fixups.c

[ ... ]

> @@ -1537,6 +1537,143 @@ static int add_hidden_subprog(struct bpf_verifier_env *env, struct bpf_insn *pat
>  /* Do various post-verification rewrites in a single program pass.
>   * These rewrites simplify JIT and interpreter implementations.
>   */
> +/*
> + * The walk with widened loops is done. Loops where some state came back to
> + * a state that was still walked were not walked to the end and have to be
> + * bounded at run time.
> + */
> +int bpf_commit_loop_guards(struct bpf_verifier_env *env)
> +{
> +	struct bpf_insn_aux_data *aux = env->insn_aux_data;
> +	int i;
> +
> +	for (i = 0; i < env->prog->len; i++) {
> +		if (!aux[i].scc || !test_bit(aux[i].scc, env->scc_converged))
> +			continue;
> +		if (aux[i].guard_impossible) {
> +			verbose(env, "loop with back-edge at insn %d cannot be bounded\n", i);
> +			return -E2BIG;
> +		}
> +		if (aux[i].guard_pending) {
> +			aux[i].loop_guard = true;
> +			env->seen_exception = true;
> +		}
> +	}
> +	return 0;
> +}

[ ... ]

> +/*
> + * The main pass went over the back-edge of jump @insn at @idx with a state
> + * that stands for any number of iterations. Nothing bounds the loop at run
> + * time, so add may_goto to the back-edge. The program cannot go on when
> + * may_goto is out of budget: nothing but the loop was verified for the state
> + * in the loop. Call bpf_throw(). The main pass made sure it can be called.
> + *
> + * back-edge is the jump:             back-edge is the edge to the next insn:
> + *   if cond goto guard                 if cond goto target
> + *   goto next                        guard:
> + * guard:                               may_goto throw
> + *   may_goto throw                     goto next
> + *   goto head                        throw:
> + * throw:                               r1 = 0
> + *   r1 = 0                             call bpf_throw
> + *   call bpf_throw                   next:
> + * next:
> + *
> + * Returns the number of insns in @buf.
> + */
> +static int add_loop_guard(struct bpf_verifier_env *env, int idx, struct bpf_insn *buf,
> +			  int stack_depth, u16 *stack_depth_extra)
> +{
> +	struct bpf_insn_aux_data *aux = &env->insn_aux_data[idx];
> +	struct bpf_insn orig = env->prog->insnsi[idx];
> +	bool ja = BPF_OP(orig.code) == BPF_JA;
> +	bool gotol = ja && BPF_CLASS(orig.code) == BPF_JMP32;
> +	int target = idx + 1 + (gotol ? orig.imm : orig.off);
> +	bool guard_jump_edge = ja || aux->backedge_br;
> +	struct bpf_insn *p = buf, *jeq, *skip = NULL, *back = NULL;
> +	int stack_off, cnt, err = 0;
> +
> +	if (guard_jump_edge && !ja) {
> +		*p = orig;
> +		p->off = 1;
> +		p++;
> +		skip = p;
> +		*p++ = BPF_JMP_A(0);
> +	} else if (!guard_jump_edge) {
> +		*p++ = orig;
> +	}
> +
> +	/* the same insns may_goto is replaced with, see bpf_do_misc_fixups() */
> +	if (bpf_jit_supports_timed_may_goto()) {
> +		stack_off = -stack_depth - 16;
> +		*stack_depth_extra = 16;
> +		*p++ = BPF_LDX_MEM(BPF_DW, BPF_REG_AX, BPF_REG_10, stack_off);

If a subprogram has multiple loops, will add_loop_guard() be called
multiple times?

Looking at bpf_commit_loop_guards():

    for (i = 0; i < env->prog->len; i++) {
        if (aux[i].guard_pending) {
            aux[i].loop_guard = true;

and bpf_do_misc_fixups():

    for (i = 0; i < insn_cnt;) {
        if (env->insn_aux_data[i + delta].loop_guard) {
            cnt = add_loop_guard(env, i + delta, insn_buf, stack_depth,
                                 &stack_depth_extra);

add_loop_guard() gets called once per back-edge that needs a guard.

When bpf_jit_supports_timed_may_goto() returns true, add_loop_guard()
computes stack_off = -stack_depth - 16 and sets *stack_depth_extra = 16.

If add_loop_guard() is called a second time for another back-edge in the
same subprogram, it will compute the same stack_off and overwrite
stack_depth_extra with 16 again.

Both guards would use the same stack slot (-stack_depth - 16), corrupting
each other's loop counters.

Further down in bpf_do_misc_fixups(), the code checks:

    int stack_slots = subprogs[i].stack_extra / 8;
    int slots = delta;  // delta = 2 for timed
    if (stack_slots > slots) {
        verifier_bug(env, "stack_slots supports may_goto only");
        return -EFAULT;
    }

With one guard: stack_extra=16, stack_slots=2, slots=2 => passes
With two guards: stack_extra=16 (wrong!), stack_slots=2, slots=2 => passes
but the guards share one slot

Should the timed case accumulate stack_depth_extra?

    stack_off = -stack_depth - *stack_depth_extra - 16;
    *stack_depth_extra += 16;

The non-timed case has a similar issue:

> +	} else {
> +		stack_off = -stack_depth - 8;
> +		*stack_depth_extra = max_t(u16, *stack_depth_extra, 8);

If a subprogram has multiple non-timed guards, they would all compute
stack_off = -stack_depth - 8 and share the same stack slot.

Should this also accumulate?

    stack_off = -stack_depth - *stack_depth_extra - 8;
    *stack_depth_extra += 8;

[ ... ]

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 06dc269991b22..2fb5a66bd7d49 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -8322,6 +8322,73 @@ int bpf_widen_loop_head(struct bpf_verifier_env *env, int insn_idx, bool backedg
>  	return 0;
>  }
>
> +static bool program_returns_void(struct bpf_verifier_env *env);
> +static bool return_retval_range(struct bpf_verifier_env *env, struct bpf_retval_range *range);
> +
> +/* Why bpf_throw() cannot be called in @st, NULL if it can. */
> +static const char *cannot_throw(struct bpf_verifier_env *env, struct bpf_verifier_state *st)
> +{
> +	struct bpf_retval_range range;
> +	struct bpf_func_state *frame;
> +	int i;
> +
> +	if (!env->prog->jit_requested || !bpf_jit_supports_exceptions())
> +		return "JIT does not support exceptions";

This checks jit_requested, but nothing requires the program to actually use
JIT at load time.

When add_loop_guard() emits BPF_EMIT_CALL(bpf_throw), does anything set
prog->jit_required?

For an explicit bpf_throw() in the program, add_kfunc_call() sets
env->prog->jit_required = 1, so a JIT failure rejects the program.

For loop guards, on a kernel without CONFIG_BPF_JIT_ALWAYS_ON,
bpf_fixup_call_args() can fall back to the interpreter:

    if (env->prog->jit_requested && !bpf_prog_is_offloaded(env->prog->aux)) {
        err = bpf_jit_subprogs(env);
        if (err == 0)
            return 0;
        if (err == -EFAULT)
            return err;
    }
#ifndef CONFIG_BPF_JIT_ALWAYS_ON
    if (prog->jit_required) { ... return -EINVAL; }

The exception callback makes subprog_cnt > 1, so JIT goes through
bpf_jit_subprogs(). If that fails (e.g., JIT allocation failure), the
out_cleanup path clears prog->jit_requested.

Since jit_required is false, the program is accepted and
__bpf_prog_select_runtime() lets it run in the interpreter.

When the may_goto budget of a guarded loop runs out, the interpreter calls
bpf_throw(). arch_bpf_stack_walk() finds no JITed BPF frame, so ctx.aux
stays NULL.

After WARN_ON_ONCE(!ctx.aux), bpf_throw() dereferences ctx.aux:

    ctx.aux->bpf_exception_cb(cookie, ctx.sp +
        ctx.aux->stack_arg_sp_adjust, ctx.bp, 0, 0);

Can bpf_commit_loop_guards() set env->prog->jit_required = true when it
commits a guard?

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/35929952632
--===============0462094654699547438==--
