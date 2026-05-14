Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32FC539BFF2
	for <bpf@vger.kernel.org>; Thu, 14 May 2026 10:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778755599; cv=none; b=rm7C6QobetOXRSwg2+qRP1YUHzD8H/3rbp4ezOWtYiJ6Uw75yk/neEXFwuwzSna1xzZEzlIZwAQeDqChc21NnjBrS/LmCmqmx55U1/3cdAApFHbOgh8ePVv6N6qQVFcopum+8Wnon4lTfOBX3RlsRLltFZ6sa0J49E6TwCrLOJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778755599; c=relaxed/simple;
	bh=F4xBkpk9kPz3YJ72H0E7mPabiAQvWifA+nbZuqDB9kE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dJ7mLccqpw5YkfAqS+R9soIH7RkCFfK12z3yZAx7YC2avdw0mzKA+KrnE5RW9+sKo3wPyinHD6PLlAK8xgdu/XdnPbNVobHp6ROg/AapAF9mQ7bEQwUrdWxHCWl5DNoTlslZFQsIKiV9XKoLKCpPQEG1bmzxYK5u7kjo9scvhIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OnZDqZkR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OnZDqZkR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD792C2BCB3;
	Thu, 14 May 2026 10:46:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778755598;
	bh=F4xBkpk9kPz3YJ72H0E7mPabiAQvWifA+nbZuqDB9kE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=OnZDqZkRv8Q9tY4UA9gOrBg/gHrDQ39ULWlP+0ustk+5KdyE/EwLymsOvPwPe0piY
	 MWeccMtP8TuzOUYz7Em6xomRnUiI2dRie0sQ5s7VBkZ5MfE5QMK00s8R0fqv+9ugA+
	 HYVasRD6VAZNgDZnhXPCQF4uvJGPYg4wS1nwJBX1T0v1QKd+KtyQ1m0v0TRF+oIbCg
	 YJkmGYb2yxqa+eJyYLX2XOsNcNCdufcH4VxIuUh3sfKUE5hX6FAMrnKVFEjR2GlzIJ
	 /1T8o6CqFkhxGnHIVQUembrU8EDXUBChfB2tcsRZVQ5/g7jqEvRrrjPf1JJBos8z/q
	 PXdLBLFR9ns7w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v4 05/25] bpf: Support stack arguments for bpf
 functions
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yonghong Song" <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260513045015.2385013-1-yonghong.song@linux.dev>
References: <20260513045015.2385013-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 14 May 2026 10:46:38 +0000
Message-Id: <20260514104638.BD792C2BCB3@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] Bypass of caller stack argument initialization checks allows N=
ULL pointer dereferences and out-of-bounds heap reads, leading to verifier =
crashes or privilege escalation.
--

commit 64c850bac22b15ca90af1ba361a4d764104b6ffb
Author: Yonghong Song <yonghong.song@linux.dev>

bpf: Support stack arguments for bpf functions

This commit allows the compiler to pass additional arguments via a dedicated
stack area through the BPF_REG_PARAMS (r11) register. It tracks outgoing st=
ack
arguments and introduces bounds checks for stack arguments in BPF subprogra=
ms.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 3bafb7ad2ba71..69965d2c5fdd5 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -4050,6 +4080,103 @@ static int check_stack_write(struct bpf_verifier_=
env *env,
>  	return err;
>  }
> =20
> +/*
> + * Read a value from the incoming stack arg area.
> + * off is a positive offset from r11 (e.g. +8 for arg6, +16 for arg7).
> + */
> +static int check_stack_arg_read(struct bpf_verifier_env *env, struct bpf=
_func_state *state,
> +				int off, int dst_regno)
> +{
> +	struct bpf_subprog_info *subprog =3D &env->subprog_info[state->subprogn=
o];
> +	struct bpf_verifier_state *vstate =3D env->cur_state;
> +	int spi =3D off / BPF_REG_SIZE - 1;
> +	struct bpf_func_state *caller, *cur;
> +	struct bpf_reg_state *arg;
> +
> +	if (state->no_stack_arg_load) {
> +		verbose(env, "r11 load must be before any r11 store or call insn\n");
> +		return -EINVAL;
> +	}
> +
> +	if (spi + 1 > bpf_in_stack_arg_cnt(subprog)) {
> +		verbose(env, "invalid read from stack arg off %d depth %d\n",
> +			off, bpf_in_stack_arg_cnt(subprog) * BPF_REG_SIZE);
> +		return -EACCES;
> +	}
> +
> +	caller =3D vstate->frame[vstate->curframe - 1];
> +	arg =3D &caller->stack_arg_regs[spi];

Could this lead to an out-of-bounds read or a NULL pointer dereference?

If check_outgoing_stack_args() is skipped (e.g. due to an error in
btf_prepare_func_args()), caller->stack_arg_regs might be NULL or smaller
than spi. Since check_func_call() or push_callback_call() can ignore
btf_check_func_arg_match() failures for static subprograms or callbacks,
the callee can still execute.

If sub->arg_cnt was updated before the failure, bpf_in_stack_arg_cnt(subpro=
g)
would be greater than 0, allowing this check to pass and potentially access=
ing
unallocated memory.

[ ... ]

> @@ -8922,6 +9078,7 @@ static int btf_check_func_arg_match(struct bpf_veri=
fier_env *env, int subprog,
>  				    struct bpf_reg_state *regs)
>  {
>  	struct bpf_subprog_info *sub =3D subprog_info(env, subprog);
> +	struct bpf_func_state *caller =3D cur_func(env);
>  	struct bpf_verifier_log *log =3D &env->log;
>  	u32 i;
>  	int ret;
> @@ -8930,13 +9087,16 @@ static int btf_check_func_arg_match(struct bpf_ve=
rifier_env *env, int subprog,
>  	if (ret)
>  		return ret;
> =20
> +	ret =3D check_outgoing_stack_args(env, caller, sub->arg_cnt);
> +	if (ret)
> +		return ret;
> +

Is it possible for btf_prepare_func_args() to return an error after modifyi=
ng
sub->arg_cnt?

For instance, if a BTF tag is unsupported in a static subprogram,
btf_prepare_func_args() will return an error after already assigning
sub->arg_cnt. This skips check_outgoing_stack_args(), which is responsible
for verifying that the caller actually allocated and initialized
caller->stack_arg_regs. This could lead to the unverified memory access
mentioned above.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260513044949.2382=
019-1-yonghong.song@linux.dev?part=3D5
