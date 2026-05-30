Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A43EC27874F
	for <bpf@vger.kernel.org>; Sat, 30 May 2026 04:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780116879; cv=none; b=Hw/3HTpIzeq4Dgl8im9GaBaq6uvOyPl9vQf/yxlkLIOUrKVOdJRVqM6az12BaWFwU964E0EydL9cvCSps1Q1O0m/bBiQ+RqXP2W34kjnp6gewYLH4Kepxci7jCpq5hpGWgU92zL1Tt+vId2MNdhWKrPPp4wcqZsLjgMSnyrv5YE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780116879; c=relaxed/simple;
	bh=Y/cM7rhLDatCPfcrqu7ffYqVIU6sGkoZQ1uogsUdF/w=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=oIM5x3XgatNyQ3HabcqAze08faDWJ+EebaOlf+LmFmySHXODlsE7qxt7Ny74z50UiOQzZ7YP8qQT1lnKOHTb1DMzBlxSeGJJ81FW9C1cOrqYK3DQXOx1AmHioD+i6wDN6Lj7L8nr3R0PBhWjrV63+t10FwsX78RVyiYfWa+fqFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SyX2fgXM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SyX2fgXM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CD9F1F00893;
	Sat, 30 May 2026 04:54:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780116878;
	bh=2E1N6ewzNJ2y1pftwg816at/Vgo9g2qvWGOz/1b2tcY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SyX2fgXMtaLvoi6WAmErl+s+xjv0tGfBmoyOk+CuFpy7KNYh9GZuGdm6Ez+KXFShS
	 iw6ebizvuhPOQTN6mBITuYQ1h7Ogg1FUGrjbejT1qJCfLAADk8rnqDoaXHVoqUWqrR
	 q/T7OjZW307dwic3r+MpcjxVXAVPoKCCKh43w6EM5YoT/LERYZ1RWQgKmRcsyvsKG9
	 ynmbM4JQd8RSfV51bhvPbpwOBvgvu9s0BODqaRgAADW/urUBYzmmHBlzApeAwwkB2H
	 /2V45EQowATi/UxLLzBgbLJxNdCANS4BJLXXhK0GknD+nsPnRJXkg2PnmB+StveJf4
	 kr8gWuXOkppoQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2 3/5] bpf: Allow subprogs to return arena
 pointers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Emil Tsalapatis" <emil@etsalapatis.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260530002259.4505-4-emil@etsalapatis.com>
References: <20260530002259.4505-4-emil@etsalapatis.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 30 May 2026 04:54:37 +0000
Message-Id: <20260530045438.5CD9F1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Global subprograms returning arena pointers have their return valu=
e unconditionally marked as a scalar at the call site.
- [Medium] The verifier bypasses BTF type enforcement for global subprogram=
 return values.
- [Low] The error message logged when a global function has an invalid retu=
rn type is outdated and confusing.
--

commit 0192bc82392a7d1bde4b6ab66bef8ece2f90c7cf
Author: Emil Tsalapatis <emil@etsalapatis.com>

bpf: Allow subprogs to return arena pointers

This patch expands the verifier to permit returning an arena pointer to the
caller from a subprogram. The main subprog is still not allowed to return
an arena pointer.

> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index c6a930aca67ec..7a8101879f84d 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c

[ ... ]

> @@ -7963,17 +7993,15 @@ int btf_prepare_func_args(struct bpf_verifier_env=
 *env, int subprog)
[ ... ]
> -	if (!btf_type_is_void(t) && !btf_type_is_int(t) && !btf_is_any_enum(t))=
 {
> -		if (!is_global)
> -			return -EINVAL;
> -		bpf_log(log,
> -			"Global function %s() return value not void or scalar. "
> -			"Only those are supported.\n",
> -			tname);
> +
> +	err =3D btf_validate_return_type(env, btf, t, subprog);
> +	if (err) {
> +		if (is_global) {
> +			bpf_log(log,
> +				"Global function %s() return value not void or scalar. "
> +				"Only those are supported.\n",
> +				tname);
> +		}
>  		return -EINVAL;
>  	}

[Severity: Low]
Since arena pointers are now supported, should this error message be
updated to avoid confusing users? It still states that only void or
scalars are supported.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index c8d980fdd7099..64d7954e93ea7 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -9375,7 +9375,7 @@ static int check_func_call(struct bpf_verifier_env =
*env, struct bpf_insn *insn,
>  		clear_caller_saved_regs(env, caller->regs);
>  		invalidate_outgoing_stack_args(env, cur_func(env));
> =20
> -		/* All non-void global functions return a 64-bit SCALAR_VALUE. */
> +		/* All non-void global functions return a 64-bit SCALAR_VALUE or PTR_T=
O_ARENA. */
>  		if (!subprog_returns_void(env, subprog)) {
>  			mark_reg_unknown(env, caller->regs, BPF_REG_0);
>  			caller->regs[BPF_REG_0].subreg_def =3D DEF_NOT_SUBREG;
>  		}

[Severity: High]
Does this unconditionally mark the caller's R0 register as a SCALAR_VALUE?

When returning from a global subprogram, mark_reg_unknown() clears the
register state. If the subprogram actually returned an arena pointer,
it seems the caller will receive an untracked scalar instead. Any attempt
by the caller to dereference it would then fail verification.

Should we inspect the subprogram's BTF return type here to dynamically
set caller->regs[BPF_REG_0].type =3D PTR_TO_ARENA when appropriate?

> @@ -16645,6 +16645,10 @@ static int check_global_subprog_return_code(stru=
ct bpf_verifier_env *env)
>  	if (err)
>  		return err;
> =20
> +	/* Pointers to arena are safe to pass between subprograms. */
> +	if (is_arena_reg(env, BPF_REG_0))
> +		return 0;
> +
>  	if (is_pointer_value(env, BPF_REG_0)) {
>  		verbose(env, "R%d leaks addr as return value\n", BPF_REG_0);
>  		return -EACCES;

[Severity: Medium]
Does this bypass BTF type enforcement for the return value?

By just checking if R0 is an arena register and returning 0, a global
subprogram declared in BTF as returning an int could successfully return
a PTR_TO_ARENA. Conversely, a subprogram declared as returning an arena
pointer could successfully return a SCALAR_VALUE, since the fallback scalar
check later in the function would allow it.

Should we verify that the actual register type matches the subprogram's
BTF return type signature?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260530002259.4505=
-1-emil@etsalapatis.com?part=3D3
