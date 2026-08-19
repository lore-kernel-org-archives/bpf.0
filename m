Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F305390CAB
	for <bpf@vger.kernel.org>; Wed, 19 Aug 2026 06:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787120055; cv=none; b=UmNI4wsFHUMslAg5MeuV3/97Vq5gcD+fhFTHu9gpCooQf58sr9/f91UirV4NRIygjyI6ZMUa3iIFMGyFpAHaGVbR1LTOMwdUv2M/b17zQnEyx+MVbIQzu2mPrmRrpcbf0FXidbLvRcaNT9bKmeeh5n3mKicXfkz0efC28m8U/GM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787120055; c=relaxed/simple;
	bh=g2VXb8klEj4r/xby6FdavNqRjL+nz2K1InP47UVpdlk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=f0e6PlEtL4sZVLsEdb6zCZKEkZhCWcI2YiWOF7shKCpo3DexpVZEywnVr4SKY1tvbMa4nGsP4bDB6e6djnseqSXO+6v0AiydZrGsCxC7Ovv+O2OuH0+8XVIWvSoBprJMbSYYaC/BUZwSK4BAghU7DMkBkDrcP2dXb/XlOpeqqEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S8HiO5Le; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S8HiO5Le"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 070A61F000E9;
	Wed, 19 Aug 2026 06:14:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787120054;
	bh=g2qyz+ZFLiKpRLbZnzF3X3i5V03tLIBN+cIwKd2VPz4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=S8HiO5LeK4sNkjhvIvJw5dXgjiQYQjNJSURh/6cN8Lb+h1Q4PbZ7NF0L24ZQWFXbN
	 o+QHHwpzHKCT+d1g3dd/Wc5OexmA8aonqip4HvzjUpbeTjmwrt9VOAj+eHXbReH/CG
	 Pgl6th2Mb3UkOV2lu2hVVyV7CPdjzfkaHGCMrUzzRer2EU5s2XSiFA5Qqg0agyeRyU
	 IwZCszIg0WTvBY12FDlyThFuNDZiNw9Ykm6PG5T2u3t9V09f+0+usMKCDeOPwVGO+q
	 DGoBOVZW155P0Rkw/6NZH83vuTTFPjvOASK2GbPf4k8we0shdcuP70ifyJRJ1Zcyp7
	 GCiR+PAaIL0Kg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v7 06/10] bpf: Add verifier support for 16-byte
 returns in R0:R2
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yonghong Song" <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260819055309.3297684-1-yonghong.song@linux.dev>
References: <20260819055239.3293449-1-yonghong.song@linux.dev>
 <20260819055309.3297684-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 19 Aug 2026 06:14:13 +0000
Message-Id: <20260819061414.070A61F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The newly added support for kfuncs returning structs is complete=
ly unreachable due to an overlooked check in btf_distill_func_proto, and hi=
des a critical missing size limit.
--

--- Patch [6]: [PATCH bpf-next v7 06/10] bpf: Add verifier support for 16-b=
yte returns in R0:R2 ---
commit c9e349733faae615b87f8da3417558d2ede26348
Author: Yonghong Song <yonghong.song@linux.dev>

bpf: Add verifier support for 16-byte returns in R0:R2

LLVM 23 added support for returning a value in two registers for an
__int128, or a struct/union whose size is greater than 8 but not more than
16 bytes. See LLVM patches [1] and [2].

Before LLVM 23 the BPF backend could not return these values at all.

[ ... ]

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 991782b402f20..d79f0c069795c 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> @@ -13965,10 +13995,25 @@ static int check_kfunc_call(struct bpf_verifier=
_env *env, struct bpf_insn *insn,
>  	}
> =20
>  	if (btf_type_is_scalar(t)) {
> -		mark_reg_unknown(env, regs, BPF_REG_0);
> +		mark_kfunc_ret_regs(env, regs, t->size);
>  		if (meta.btf =3D=3D btf_vmlinux && (meta.func_id =3D=3D special_kfunc_=
list[KF_bpf_res_spin_lock] ||
>  		    meta.func_id =3D=3D special_kfunc_list[KF_bpf_res_spin_lock_irqsav=
e]))
>  			__mark_reg_const_zero(env, &regs[BPF_REG_0]);
> +	} else if (btf_type_is_struct(t)) {
> +		/*
> +		 * The returned struct comes back as raw register bits modeled
> +		 * as an unknown scalar, so it must contain only scalars:
> +		 * otherwise a pointer field would be laundered into a scalar
> +		 * and escape provenance and reference tracking.
> +		 */

[Severity: Medium]
Is this new struct return handling reachable?

Looking at early program loading, btf_distill_func_proto() unconditionally
rejects struct return types:

kernel/bpf/btf.c:btf_distill_func_proto() {
    ...
	if (ret < 0 || btf_type_is_struct(t)) {
		bpf_log(log,
			"The function %s return type %s is unsupported.\n",
			tname, btf_type_str(t));
		return -EINVAL;
	}
    ...
}

As a result, wouldn't programs be rejected before check_kfunc_call() is
executed?

Additionally, if this code were reachable, does it lack a bounds check on
t->size?

Because kfuncs use the C ABI, returning a large struct requires a hidden
'sret' pointer. Without a size limit, returning a struct larger than 16 byt=
es
might bypass the BPF return pair logic, as the BPF JIT would pass the
attacker-controlled BPF R1 as this pointer.

Could this potentially allow a kfunc to overwrite arbitrary kernel memory?

> +		if (!__btf_type_is_scalar_struct(env, desc_btf, t, 0)) {
> +			verbose(env,
> +				"kernel function %s returns %s %s that is not composed of scalars\n",
> +				func_name, btf_type_str(t),
> +				btf_name_by_offset(desc_btf, t->name_off));
> +			return -EINVAL;
> +		}
> +		mark_kfunc_ret_regs(env, regs, t->size);
>  	} else if (btf_type_is_ptr(t)) {
>  		ptr_type =3D btf_type_skip_modifiers(desc_btf, t->type, &ptr_type_id);
>  		err =3D check_special_kfunc(env, &meta, regs, insn_aux, ptr_type, desc=
_btf);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260819055239.3293=
449-1-yonghong.song@linux.dev?part=3D6
