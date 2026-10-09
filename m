Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BB784C33C5
	for <bpf@vger.kernel.org>; Fri,  9 Oct 2026 11:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791545180; cv=none; b=o5BntAx23NKY+B6Y26S5lQPy6bQEmXr1sudqMkRjUhLH8wQn0FCZKoZxahlcI+mNQBamogyHjbxAQi02mlUDQIsTAS6AfnFYpqTA6P3a/sAGJXP21qXEi/sn2rwnlGkU28ZWdY5OUYGz7nBBC11Cyla6k7Lrov88XQND/WkG6D0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791545180; c=relaxed/simple;
	bh=ulHPuTkycrSkJUi+/eA0BvHAvJ7Xx0TlP5V7VJPj2Ow=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=ir6WQwUQijfftnFiSmCNpFYz6CBiaZjSPBsiK42Y9C6Aoj1/vxXSlmLq7/VFrAtRLYCEqNeis1oZ4s2z2W0kc2XnZmLF7v38HRAJYNY564l+psIDfCDp7BsbeYJ5pFoDB9btZClxnyr8haW02wdlEKr/rAr/U+Jn50GoCLDXu+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V71WyQpo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V71WyQpo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECF5A1F000FF;
	Fri,  9 Oct 2026 11:26:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791545170;
	bh=0C2yp3+g+a0Cp6Xk/x+oxmBF7XnSgyowyLxawe2ZGUA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=V71WyQpoeLjuYX3i5eHKZbV9xSo+tsevOgvibU6gWVm77VHj3NUxHranxSzH6IEo3
	 1zCbB2fdDEazMNMEwqkbBeLmGZk9v0L3THBbvcSat+vArzZl0oIs7hHUmVwftFHhUk
	 j93AknQUs5vQm5OnReb6WGB3aK0D3GuEFNu57AEClZb9tflspbRCSgYlJsURIZGzca
	 vGEtuWr72KzO+3cse809oAfHQpXbOji0exVPZWk7hNpwsEa9nFG/i1mWLMFLg0nObP
	 5xw+9ZcJGhtXCElTjStoG8RciIkb92XUiF9Ym0IGCzCTPv3dGhgkJ3ZMyn+V60hwo2
	 KIbNd3ezQQHCw==
Message-ID: <sashiko-outbox-165368@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v3 11/51] bpf: compute parameters liveness in
 bpf_compute_live_registers()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Eduard Zingerman" <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261009-scev-minimal-rebase-v3-11-bcba9bc53ac9@gmail.com>
References: <20261009-scev-minimal-rebase-v3-0-bcba9bc53ac9@gmail.com>
 <20261009-scev-minimal-rebase-v3-11-bcba9bc53ac9@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Oct 2026 11:26:09 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] bpf: state pruning bypasses NOT_INIT check for static subprog args
--

commit 9fa2cdb3328d1fdeb0246efe76e84a8ecaca85e6
Author: Eduard Zingerman <eddyz87@gmail.com>

bpf: compute parameters liveness in bpf_compute_live_registers()

This commit changes the verifier to compute exact liveness for the
arguments of calls to subprograms instead of assuming r1..r5 are read.
It adds a separate pass to prepare BTF function arguments early so that
liveness can be accurately determined.

> diff --git a/kernel/bpf/liveness.c b/kernel/bpf/liveness.c
> index a359e457e6c0c..8d8428ccc5052 100644
> --- a/kernel/bpf/liveness.c
> +++ b/kernel/bpf/liveness.c

[ ... ]

> @@ -2613,8 +2620,18 @@ static void compute_insn_live_regs(struct bpf_veri=
fier_env *env,
>  		case BPF_CALL:
>  			def =3D ALL_CALLER_SAVED_REGS;
>  			use =3D def & ~BIT(BPF_REG_0);
> -			if (bpf_get_call_summary(env, insn, &cs))
> +			if (bpf_get_call_summary(env, insn, &cs)) {
>  				use =3D GENMASK(min_t(u8, cs.arg_slot_cnt, MAX_BPF_FUNC_REG_ARGS), 1=
);
> +			} else if (bpf_pseudo_call(insn)) {
> +				/* a static callee's reads are added in bpf_compute_live_registers()=
 */
> +				subprog =3D callee_subprog(env, insn);
> +				if (bpf_subprog_is_global(env, subprog)) {
> +					reg_args =3D min_t(u8, env->subprog_info[subprog].arg_slot_cnt, MAX=
_BPF_FUNC_REG_ARGS);
> +					use =3D GENMASK(reg_args, 1);
> +				} else {
> +					use =3D 0;
> +				}
> +			}

[Severity: High]
Does marking these unused arguments as not live for static subprograms
interact poorly with verifier state pruning?=20

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index a5456a6e26946..50cb564be9f74 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> @@ -10939,6 +10940,15 @@ static int btf_check_func_arg_match(struct bpf_v=
erifier_env *env, int subprog, s
>  	meta.fn =3D fn;
>  	meta.func_proto =3D func_proto;
> =20
> +	/*
> +	 * Check if all register arguments declared in BTF are initialized.
> +	 * If they aren't the BTF is unreliable.
> +	 */
> +	if (!bpf_subprog_is_global(env, subprog)) {
> +		for (i =3D 0; i < min_t(u32, sub->arg_slot_cnt, MAX_BPF_FUNC_REG_ARGS)=
; i++)
> +			if (caller->regs[BPF_REG_1 + i].type =3D=3D NOT_INIT)
> +				return -EINVAL;
> +	}
>  	return check_func_args(env, &meta, env->insn_idx);
>  }

[Severity: High]
Because unused arguments are no longer marked as live due to the change
in compute_insn_live_regs(), can this NOT_INIT check be completely
bypassed by regsafe()?

If the verifier first explores a path where the argument is initialized,
the subprogram is not marked unreliable. If it subsequently explores
another path where the argument is left NOT_INIT, this second path
will be pruned before evaluating the BPF_CALL instruction and hitting
btf_check_func_arg_match().

Could this result in the subprogram remaining "reliable", allowing
fentry/freplace extension programs to attach to it and potentially
leak uninitialized kernel memory via the BTF context?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261009-scev-minim=
al-rebase-v3-0-bcba9bc53ac9@gmail.com?part=3D11
