Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2048F1A680E
	for <bpf@vger.kernel.org>; Sat,  5 Sep 2026 22:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788647630; cv=none; b=Gad1EtW26NmrTWdJKwR5Rw+tg1Jh6RnWYhjbPkGfimqq7U0Ly5p0T8DDUrulUCIFHDVCyT79kZHixEMeKGmDLmKH1/U3a4CDSjmuuDSfUggbvpUQlM2VaPwgoVhO1n9+zxwOB/lsrPwUkzbksCcECOpCMH7itK7gIXHvVngK8JM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788647630; c=relaxed/simple;
	bh=3kaH3+BbBDo9qOmeFzDwz91mKumU9Lr2oLJBdg3UX3A=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hOQ46tvIJlOBvRIAcxssx07FpxdojMC7wjvphiPJ8COaK2CMaza+bEzEwZ1sV6WySJdGTZ2bb0+rKsNDrMy+hGRy0ZeBlQLEsZTLTpvHloKFYluSuy58amwKhcBKxgI30wn5fs/LI2P9LEqPtx9u8M9JM9ZwMFizsBiq/KMovIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=flWiIM6+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="flWiIM6+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85D551F00A3A;
	Sat,  5 Sep 2026 22:33:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788647628;
	bh=Nu7vhQOSXgdFltMr2dnSieTUo9klsYk/p0hJIqSiCug=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=flWiIM6+VrBZf2gQtu13ZqD5HNr1qF3kr/RTEkVdHrs69utwyb7CTat7l0pi9I9Uf
	 aSsRQuD0kDH9+X497UC5hSaPBqk2FJInuJxb4fjQTuM7LcIvbQ5Ma3EIlzcdM9QBZ3
	 Fq4TEpEBu9BOnPpqPxqYUf0/brZ6sCG7k5mlZgj7UIwEqOr5+iPN8DDZV2knJ79gDe
	 svicNovziFVpztzfYcp+PWlZAC3X11YZwC2l9JeO+QJzlfSGyCCIUyqpI4aDtPSd83
	 20EOIVMJyBDJxvkPbb31WlQyb5gXzzdYNHuE8c/bdDHvYPney6/wYPlAJ8fotxdSdn
	 eqw45DhLImGbA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v1 22/22] bpf: Check helper and kfunc arguments
 in one path
Reply-To: sashiko-reviews@lists.linux.dev
To: "Amery Hung" <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260905220117.922028-23-ameryhung@gmail.com>
References: <20260905220117.922028-1-ameryhung@gmail.com>
 <20260905220117.922028-23-ameryhung@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 05 Sep 2026 22:33:47 +0000
Message-Id: <20260905223348.85D551F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] Out-of-bounds reads on `meta->fn->arg_type` and `meta->fn->arg=
_btf_id` for kfuncs with more than 5 arguments, allowing bypass of eBPF ver=
ifier safety checks.
--

commit a1895fafaa5219b7b972d20a932c550f7862cec8
Author: Amery Hung <ameryhung@gmail.com>

bpf: Check helper and kfunc arguments in one path

This commit unifies the argument checking logic for BPF helpers and kfuncs
by introducing check_func_args(). It moves kfunc-specific argument handling
into the shared check_func_arg() path to avoid duplicating the argument
iteration and switch logic.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 6c5d7e544f844..54656fb31bbe7 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
[ ... ]
> @@ -8808,6 +8840,7 @@ static int check_func_arg(struct bpf_verifier_env *=
env, u32 arg,
>  			  struct bpf_call_arg_meta *meta,
>  			  int insn_idx)
>  {
> +	const struct btf_param *btf_arg =3D meta->btf ? &btf_params(meta->func_=
proto)[arg] : NULL;
>  	const struct bpf_func_proto *fn =3D meta->fn;
>  	struct bpf_func_state *caller =3D cur_func(env);
>  	struct bpf_reg_state *regs =3D cur_regs(env);
>  	argno_t argno =3D argno_from_arg(arg + 1);
>  	struct bpf_reg_state *reg =3D get_func_arg_reg(caller, regs, arg);
>  	enum bpf_arg_type arg_type =3D fn->arg_type[arg];

[Severity: Critical]
Can this read out of bounds when processing kfuncs with more than 5
arguments? The fn->arg_type array is sized for MAX_BPF_FUNC_ARGS (5), but
kfuncs can have more arguments. For stack arguments (arg >=3D 5), this appe=
ars
to read past the end of the array.

[ ... ]
> @@ -8935,6 +8980,7 @@ static int check_func_arg(struct bpf_verifier_env *=
env, u32 arg,
>  	case ARG_PTR_TO_BTF_ID_SOCK_COMMON:
>  	{
>  		const u32 *arg_btf_id =3D fn->arg_btf_id[arg];

[Severity: Critical]
Does this also read out of bounds for kfuncs with more than 5 arguments?
Similar to arg_type, the arg_btf_id array in struct bpf_func_proto is limit=
ed
to MAX_BPF_FUNC_ARGS. If a garbage pointer is dereferenced here, could it
crash the verifier?

[ ... ]
> @@ -9056,6 +9389,37 @@ static int check_func_arg(struct bpf_verifier_env =
*env, u32 arg,
>  	return err;
>  }
> =20
> +static int check_func_args(struct bpf_verifier_env *env, struct bpf_call=
_arg_meta *meta,
> +			   int insn_idx)
> +{
> +	struct bpf_func_state *caller =3D cur_func(env);
> +	const struct btf_param *args =3D NULL;
> +	u32 arg, nargs =3D MAX_BPF_FUNC_REG_ARGS;
> +	int err;
> +
> +	if (meta->btf) {
> +		args =3D btf_params(meta->func_proto);
> +		nargs =3D btf_type_vlen(meta->func_proto);
> +	}
> +
> +	if (nargs > MAX_BPF_FUNC_REG_ARGS) {
> +		err =3D check_outgoing_stack_args(env, caller, nargs, meta->func_name,
> +						meta->btf, args);
> +		if (err)
> +			return err;
> +	}
> +
> +	for (arg =3D 0; arg < nargs; arg++) {
> +		if (meta->fn->arg_type[arg] =3D=3D ARG_UNUSED)
> +			break;

[Severity: Critical]
Could this loop early-exit and bypass verifier checks for stack arguments?

Since nargs can exceed 5 for kfuncs, the out-of-bounds read on
meta->fn->arg_type[arg] might evaluate to ARG_UNUSED (0). If this happens,
the loop breaks and skips the safety checks for all remaining stack
arguments, potentially allowing unverified memory access.

> +		err =3D check_func_arg(env, arg, meta, insn_idx);
> +		if (err)
> +			return err;
> +	}
> +
> +	return 0;
> +}
> +

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260905220117.9220=
28-1-ameryhung@gmail.com?part=3D22
