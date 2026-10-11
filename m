Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D45A3630AC
	for <bpf@vger.kernel.org>; Sun, 11 Oct 2026 06:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791700715; cv=none; b=uNfcHzMnIqyVc+Lsl87dXBHDtk9zWuRBm9IEbYlr2iWMUnn+wykEWcnQu3fIhP1rYi74N/trbwYaJ5urIgnVV0pBf+CXiqQgqc8t5rEiBwa8K0bxWQyu0MdzSS9SRE2CAwuWypHMElAfCf24Fr2AVQtpeX+OBnF1ByDYXiiELsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791700715; c=relaxed/simple;
	bh=qzNSEKrEa/OntKJiX0RzHd5p1EfronQ5VyBAzveI8os=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=bImB4nCvWrfy7oq6fJ168kndGC/pu9mkQRFngKkq8HcQhaZoX4lTe8Wa6GLmfqsnvzaH4sfEqPdH3Wo6UoORrDaNz/RlrtZ4OYTP1USjJZ0HiyURL/IIi/fGmWqQ7dT+Ah7fDhtfk3x7cCZYdh2gv/b/TY3Yy1wuDNZqMbWPqW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kSnUxEJP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kSnUxEJP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9B401F0089B;
	Sun, 11 Oct 2026 06:38:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791700714;
	bh=IHi+CHB3+erf2jhPcS40BTI3y5/SQLhA79u/9oaxZ9s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kSnUxEJPOE7YiRVI8pbMYUGGF+fSm3fvXLokPsBPHnxwuHeokVnJGeFBE94P7w/oA
	 X2St3RtZ/71gdoPm+UQRaS9VI+iRLsUeBwMYYRgrLP6QCT5YwwPFKyZdDO8LP+FZux
	 g+zr4DMmbo6QaeICBQqgEf2C3LkL3rIdU8Q1TJAPc1ho7ZIToVOAqvh9QZ9b8BhIUU
	 9ytUxi3CX5fnzssFXVo2edtGbgw591naDBNuuQfyX/thtMRnysph2fAQuyLPw6gApG
	 gnkeh1kx89/c6V8TZpQWapnuya3A/C1TzDH2bHeX87wZdB4ZBQrskpDfxe0VWohEkK
	 RF98lQy4locGA==
Message-ID: <sashiko-outbox-167072@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 1/9] bpf: static subprogram arguments liveness
 should use BTF type info
Reply-To: sashiko-reviews@lists.linux.dev
To: "Eduard Zingerman" <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261010-scev-minimal-v3-followups-v1-1-6000e95ef993@gmail.com>
References: <20261010-scev-minimal-v3-followups-v1-0-6000e95ef993@gmail.com>
 <20261010-scev-minimal-v3-followups-v1-1-6000e95ef993@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 11 Oct 2026 06:38:33 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] bpf: state explosion for non-BTF static subprograms
--

commit aaf0f2ac344fe68dd84ff5e9d26151d93e265a96
Author: Eduard Zingerman <eddyz87@gmail.com>

bpf: static subprogram arguments liveness should use BTF type info

When computing liveness marks for arguments of static subprograms, this
commit modifies the verifier to mark all arguments in the subprogram's
BTF type as live to avoid gaps in unreliable BTF detection.

> diff --git a/kernel/bpf/liveness.c b/kernel/bpf/liveness.c
> index e657e6d95408f..024790097f960 100644
> --- a/kernel/bpf/liveness.c
> +++ b/kernel/bpf/liveness.c

[ ... ]

> @@ -2623,14 +2623,15 @@ static void compute_insn_live_regs(struct bpf_ver=
ifier_env *env,
>  			if (bpf_get_call_summary(env, insn, &cs)) {
>  				use =3D GENMASK(min_t(u8, cs.arg_slot_cnt, MAX_BPF_FUNC_REG_ARGS), 1=
);
>  			} else if (bpf_pseudo_call(insn)) {
> -				/* a static callee's reads are added in bpf_compute_live_registers()=
 */
> +				/*
> +				 * Use BTF signatures as a starting point.
> +				 * See special case for static subprograms
> +				 * in the bpf_compute_live_registers()'s main loop.
> +				 */
>  				subprog =3D callee_subprog(env, insn);
> -				if (bpf_subprog_is_global(env, subprog)) {
> -					reg_args =3D min_t(u8, env->subprog_info[subprog].arg_slot_cnt, MAX=
_BPF_FUNC_REG_ARGS);
> -					use =3D GENMASK(reg_args, 1);
> -				} else {
> -					use =3D 0;
> -				}
> +				reg_args =3D min_t(u8, env->subprog_info[subprog].arg_slot_cnt,
> +						 MAX_BPF_FUNC_REG_ARGS);
> +				use =3D GENMASK(reg_args, 1);

[Severity: Medium]
Will this unconditionally force registers R1-R5 to be tracked as live for
static subprograms when BTF is missing?

Before this patch, `use` was initialized to 0 for static subprograms, which
correctly limited liveness to registers actually read by the callee. By
removing the `bpf_subprog_is_global()` check, could this unnecessarily widen
the liveness mask?

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 2f190abe34489..fc1937b37dcff 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> @@ -14834,15 +14834,27 @@ static bool try_btf_prepare_func_args(struct bp=
f_verifier_env *env, int subprog)
>  	return !err;
>  }
> =20
> -/* Prepare argument metadata for liveness; the main program is handled s=
eparately. */
> +/* Initialize env->subprog_info[].arg_slot_cnt */
>  static void prepare_subprog_args(struct bpf_verifier_env *env)
>  {
> +	struct bpf_prog_aux *aux =3D env->prog->aux;
> +	const struct btf_type *t;
>  	int i;
> =20
> -	for (i =3D 1; i < env->subprog_cnt; i++) {
> -		if (!try_btf_prepare_func_args(env, i) && bpf_subprog_is_global(env, i=
))
> -			/* Keep all argument registers live if the prototype is unavailable. =
*/
> -			env->subprog_info[i].arg_slot_cnt =3D MAX_BPF_FUNC_REG_ARGS;
> +	for (i =3D 0; i < env->subprog_cnt; i++) {
> +		/*
> +		 * Keep all argument registers live if the prototype is unavailable.
> +		 * No need to include stack args, as those are not supported for
> +		 * subprograms w/o BTF.
> +		 */
> +		env->subprog_info[i].arg_slot_cnt =3D MAX_BPF_FUNC_REG_ARGS;
> +		if (!aux->func_info)
> +			continue;

[Severity: Medium]
Does initializing `arg_slot_cnt` to 5 for all subprograms without BTF sever=
ely
degrade state pruning?

If a BPF program without BTF makes a pseudo-call to a static subprogram, the
verifier now requires exact state matches for R1-R5 during pruning, even if
the callee never reads them. Could this cause previously valid programs to =
be
rejected by the 1M instruction complexity limit due to state explosion?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261010-scev-minim=
al-v3-followups-v1-0-6000e95ef993@gmail.com?part=3D1
