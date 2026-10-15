Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7169424DCF6
	for <bpf@vger.kernel.org>; Thu, 15 Oct 2026 04:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792038575; cv=none; b=pnD270jxa+AVfycXfizzfXkUFFccCy529JYNTIl07NJFkVFlsCCLDdaPCJOJKzuonTT1Daqbaiq0HpJfJTuZTScm8IRsud92CI9tq4a8ahXeysWkIvX5P5swwgRx/QMgMRdkG0QHtsSLERxeuhYsLO7O/USvJCPOZEdAisnwTKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792038575; c=relaxed/simple;
	bh=8WeGjJFnowc4eJ/OkoCWV+a99+94gpT8UuJCjjFkSqY=;
	h=Message-ID:From:Subject:To:In-Reply-To:References:Content-Type:
	 Date; b=jrTJIVGZ2sIVhcgrYQQx01DFj675FJHcZuc176IoFJMLVy8Af2WCPb9ysFzaTk0h4ohlKoRocoVpysBe5rhNhGUvlQ3P9CyrdL+ufXS0bJS2LHKFdH1IiCmxl47mYUjXr/lKtEQPcd+NrrrGSaDRrjaensyTQKmTPZjoPlqFfZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FeuyqJGm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FeuyqJGm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D38111F000C4;
	Thu, 15 Oct 2026 04:29:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792038574;
	bh=s/scWWKju9wfjMYZsRJtZYi3ov89wH/61Kn1wrM5bJg=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=FeuyqJGmomufQqkhterZPcUy0ByxyeV8iwWnM+wFt3KMvP7Snar/Iu2V5eMGg+FUG
	 LiHYxpWw7vJPOa+UtZzvYnksKgAOyuqJxPDEpJnJ3tGD25SDUvguXH42HUoKSMQ8iz
	 ox2RRl4x8w6e8hNFMueJcPAeZkAunGaLqmWnr8uJFgsyAlwwmHhYV6mOGnWrLX4U3X
	 JtfETKRPyqLuUZ30V1lzorChJpj4kcXwB8qyCpYnb3tN+IdSY4U4BY4qZhXgf8gPJK
	 DcJjQ23Fzt9/ZampgdF4js5lv7nPcxKaGrrPOGHm5tDZiIVSTo5+oWbWMWtfjYL78M
	 IVBYXp54N792A==
Message-ID: <sashiko-outbox-172270@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v11 07/26] bpf: Verify an unwind through
 landing pads and epilogues
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yonghong Song" <yonghong.song@linux.dev>, bpf@vger.kernel.org
In-Reply-To: <20261015040219.858407-1-yonghong.song@linux.dev>
References: <20261015040143.854070-1-yonghong.song@linux.dev>
 <20261015040219.858407-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Oct 2026 04:29:33 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] bpf: precision tracking fails to backtrack from unwind landing pad
- [High] bpf: global subprogram unwind pad bypassed if might_throw is true
--

commit d697ce1fb72f895b857d6e1eeaa219cab7a013bc
Author: Yonghong Song <yonghong.song@linux.dev>

bpf: Verify an unwind through landing pads and epilogues

The commit adds support for verifying bpf_unwind() through landing pads and
epilogues. It updates verifier control flow, state tracking, and precision
backtracking to understand these non-linear execution paths.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 96f5ea8ea8bf8..fe24291260a0e 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
[ ... ]
> @@ -19674,6 +19682,133 @@ enum {
>  	INSN_IDX_UPDATED =3D 2,
>  };
> =20
> +static int unwind_frames(struct bpf_verifier_env *env, bool *do_print_st=
ate)
> +{
[ ... ]
> +		/*
> +		 * Mark the unwinding insn with the frame it ran in: backtracking
> +		 * from the pad comes back to that insn and goes on in that frame.
> +		 */
> +		err =3D bpf_push_jmp_history(env, state, INSN_F_UNWIND, 0, frameno, NU=
LL, 0);
> +		if (err)
> +			return err;
> +		clear_caller_saved_regs(env, caller->regs);
> +		mark_reg_unknown(env, caller->regs, BPF_REG_0);
> +		env->insn_idx =3D pad;
> +		if (do_print_state)
> +			*do_print_state =3D true;
> +		return INSN_IDX_UPDATED;

[Severity: High]
Does this code break precision backtracking?

The jmp_history entry is pushed before env->insn_idx is updated to pad. This
means the entry's idx will record the unwinding instruction instead of the =
pad
target.

During backtracking, when the verifier reaches pad, it calls
get_prev_insn_idx() which uses st->jmp_history entries where idx matches the
jump target. Because idx was recorded as the unwinding instruction,
get_prev_insn_idx() will fail to find it and fall back to linear backtracki=
ng
(pad - 1) instead of jumping back to the source instruction.=20

Since exception landing pads are typically emitted out-of-line by the compi=
ler,
backtracking into pad - 1 jumps into completely unrelated code, corrupting
precision tracking.

[ ... ]
> +static int process_global_call_unwind(struct bpf_verifier_env *env,
> +				      int call_idx, bool *do_print_state)
> +{
> +	const struct bpf_insn *insn =3D &env->prog->insnsi[call_idx];
> +	int subprog =3D bpf_find_subprog(env, call_idx + insn->imm + 1);
> +	struct bpf_verifier_state *branch;
> +	struct bpf_func_state *frame;
> +	int pad;
> +
> +	if (!bpf_subprog_is_global(env, subprog) ||
> +	    !env->subprog_info[subprog].might_unwind)
> +		return 0;
> +
> +	/* The call returning normally is walked later. */
> +	branch =3D push_stack(env, call_idx + 1, call_idx, false);
> +	if (IS_ERR(branch))
> +		return PTR_ERR(branch);
> +
> +	pad =3D bpf_exc_pad_of_call(env, call_idx);
> +	if (pad < 0)
> +		return unwind_frames(env, do_print_state);
> +	frame =3D cur_func(env);
> +	clear_caller_saved_regs(env, frame->regs);
> +	mark_reg_unknown(env, frame->regs, BPF_REG_0);
> +	env->insn_idx =3D pad;
> +	*do_print_state =3D true;
> +	return INSN_IDX_UPDATED;
> +}

[Severity: High]
Can this fail to record the non-linear edge for backtracking?

If a landing pad is found (pad >=3D 0), env->insn_idx is directly set to pa=
d and
the function returns. However, it seems a jmp_history entry linking pad bac=
k to
call_idx is never pushed.

Just like in unwind_frames(), this missing history entry causes
get_prev_insn_idx() to fall back to linear backtracking (pad - 1) during the
backtrack walk, which jumps into unrelated code and can severely corrupt
precision tracking.

[ ... ]
> @@ -19935,8 +20070,14 @@ static int do_check_insn(struct bpf_verifier_env=
 *env, bool *do_print_state)
>  				cur_func(env)->no_stack_arg_load =3D true;
>  			if (bpf_is_callx(insn))
>  				return check_func_callx(env, insn, &env->insn_idx);
> -			if (insn->src_reg =3D=3D BPF_PSEUDO_CALL)
> -				return check_func_call(env, insn, &env->insn_idx);
> +			if (insn->src_reg =3D=3D BPF_PSEUDO_CALL) {
> +				int call_idx =3D env->insn_idx;
> +
> +				err =3D check_func_call(env, insn, &env->insn_idx);
> +				if (err)
> +					return err;
> +				return process_global_call_unwind(env, call_idx, do_print_state);
> +			}

[Severity: High]
Does this check inadvertently bypass the unwind pad if the global subprogram
can also throw?

A global subprogram can be marked with both might_throw =3D true and
might_unwind =3D true if it can call both bpf_throw() and bpf_unwind().

When verifying a call to such a global subprogram, check_func_call() checks
might_throw, pushes the normal return branch, and returns PROCESS_BPF_EXIT
(which is non-zero) to simulate the exception exit:

check_func_call() {
    ...
    if (env->subprog_info[subprog].might_throw) {
        ...
        return process_bpf_exit_full(env, NULL, true);
    }
    ...
}

Because check_func_call() returns PROCESS_BPF_EXIT, if (err) evaluates to t=
rue
here, causing the verifier to return immediately and skip
process_global_call_unwind().

As a result, the unwind landing pad for this call is never pushed or explor=
ed.
Dead code sanitization will replace the unvisited pad with a jump to itself
(an infinite loop). If the global subprogram unwinds at runtime, it will ju=
mp
to this unverified pad and enter an infinite loop, causing a kernel denial =
of
service.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261015040143.8540=
70-1-yonghong.song@linux.dev?part=3D7
