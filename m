Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62E922F84F
	for <bpf@vger.kernel.org>; Sun, 19 Apr 2026 17:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776618498; cv=none; b=vAHkZp3Xxx6KA83hCKvF7Kx3vXWmnMOwNulH22rYrQ7OEgi2DsdISu3empYhjd8cA3eZ3MrPYHg5XIfR6kOndaauLrBBcAnCpOODsjE2atDG4XAcZl9izDHMLw+lg0HaPeJmFZJtkse9y81ehJBRGGBusfcC3WUeVqpriT0ludE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776618498; c=relaxed/simple;
	bh=4Zj+TWu8bHLzIJr7lLJrxTOINdeW7SkXNyrOcWrkYRo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=o59Tdw6PBL4iv/fQLp7RomAd5d7c4FeoHSpir6nQ1xNalKFj3CjnMfeqXrzGRVnmVkYiGrIdbS9oaQII5vLhDnRRhKvMAPvCUqIAjEn75AsSywGgeqobneZ5iWJYq6PifUr6qkZTMWGG0eVYaNuVZyQOxu7MIHPeET6eq95RXgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ffCfr2rv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ffCfr2rv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8136C2BCAF;
	Sun, 19 Apr 2026 17:08:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776618498;
	bh=4Zj+TWu8bHLzIJr7lLJrxTOINdeW7SkXNyrOcWrkYRo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=ffCfr2rvyw81k28c1q6nsV1RtKgAM2OKv1MAi6aI4/TisNgJJ0JkoqHlMokNakyWb
	 xQ4DbXo2FI1MuM8lr1eBSpnehfaJ02sAaH2oMYd78M+p1e8b1ySBWhAz5bOP0lMujq
	 dt3r71D0ck956nYliTs423b/Mjj6B6+hoOatduCcA+xniuKozjM6f7/TDb0azsBW4t
	 8AXYCOEK38Q+d2X5TvsSO5CW47GHhGoDpybPtHn2U33KgzSGSQt+ctPnQTwM0Vm2ph
	 Ta19rBKa4Ye4dUXxoeCclGjUazLT/B4jgIahgPeOb9fg3D/jv8sR0t41WymAmR+GPx
	 7Chhi32MYTrJw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v6 12/17] bpf: Support stack arguments for
 kfunc calls
Reply-To: sashiko@lists.linux.dev
To: "Yonghong Song" <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260419163417.736887-1-yonghong.song@linux.dev>
References: <20260419163417.736887-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 19 Apr 2026 17:08:17 +0000
Message-Id: <20260419170817.D8136C2BCAF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Sashiko AI review found 2 potential issue(s):
- [Critical] Loss of precision tracking for scalar stack arguments due to m=
odifying a local copy (`tmp_reg`).
- [Critical] Bypassing `mark_chain_precision` for stack arguments breaks da=
ta-flow backtracking, enabling unsafe state pruning.
--

commit 96adcc4832214af51212820f2056565abaf42a32
Author: Yonghong Song <yonghong.song@linux.dev>

bpf: Support stack arguments for kfunc calls

Extend the stack argument mechanism to kfunc calls, allowing kfuncs
with more than 5 parameters to receive additional arguments via the
r11-based stack arg area.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 2a346e4f28e15..13f1fd7880921 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
[ ... ]
> @@ -7314,8 +7322,12 @@ static int check_mem_size_reg(struct bpf_verifier_=
env *env,
>  	}
>  	err =3D check_helper_mem_access(env, mem_reg, mem_argno, size_reg->umax=
_value,
>  				      access_type, zero_size_allowed, meta);
> -	if (!err && !is_stack_argno(size_argno))
> -		err =3D mark_chain_precision(env, size_argno);
> +	if (!err) {
> +		if (is_stack_argno(size_argno))
> +			size_reg->precise =3D true;
> +		else
> +			err =3D mark_chain_precision(env, size_argno);
> +	}
>  	return err;
>  }

Does setting size_reg->precise =3D true without calling mark_chain_precisio=
n()
break data-flow backtracking?

If only the current state's flag is set, parent states and the source
registers that populated the stack argument will not be marked precise.
Could this lead to the verifier incorrectly pruning states if execution pat=
hs
merge before the stack store?

[ ... ]
> @@ -12373,20 +12400,44 @@ static int check_kfunc_args(struct bpf_verifier=
_env *env, struct bpf_kfunc_call_
[ ... ]
>  		if (i < MAX_BPF_FUNC_REG_ARGS) {
>  			reg =3D &regs[i + 1];
>  		} else {
>  			/* Retrieve the reg state from the outgoing stack arg slot. */
>  			struct bpf_func_state *caller =3D cur_func(env);
>  			int spi =3D out_arg_spi(caller, i - MAX_BPF_FUNC_REG_ARGS);
> =20
>  			if (!is_stack_arg_slot_initialized(caller, spi)) {
>  				verbose(env, "stack %s not properly initialized\n",
>  					reg_arg_name(env, argno));
>  				return -EINVAL;
>  			}
> =20
>  			tmp_reg =3D caller->stack_arg_regs[spi];
>  			reg =3D &tmp_reg;
>  			regno =3D -1;
>  		}
[ ... ]
> @@ -12413,9 +12464,13 @@ static int check_kfunc_args(struct bpf_verifier_=
env *env, struct bpf_kfunc_call_
>  						reg_arg_name(env, argno));
>  					return -EINVAL;
>  				}
> -				ret =3D mark_chain_precision(env, regno);
> -				if (ret < 0)
> -					return ret;
> +				if (regno < 0) {
> +					reg->precise =3D true;
> +				} else {
> +					ret =3D mark_chain_precision(env, regno);
> +					if (ret < 0)
> +						return ret;
> +				}
>  				meta->arg_constant.found =3D true;
>  				meta->arg_constant.value =3D reg->var_off.value;

Does setting reg->precise =3D true here modify a local copy instead of the =
actual
verifier state?

Since reg points to tmp_reg for stack arguments:

        tmp_reg =3D caller->stack_arg_regs[spi];
        reg =3D &tmp_reg;

it seems that reg->precise =3D true will only update the block-scoped tmp_r=
eg,
leaving the real state in caller->stack_arg_regs[spi] untouched. Could this
cause the verifier to lose track of precision requirements for scalar
constraints?

Additionally, similar to check_mem_size_reg() above, bypassing
mark_chain_precision() for stack arguments appears to skip backtracking
entirely.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260419163316.7310=
19-1-yonghong.song@linux.dev?part=3D12
