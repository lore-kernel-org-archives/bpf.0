Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4208F3E451C
	for <bpf@vger.kernel.org>; Mon, 15 Jun 2026 11:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781522676; cv=none; b=GivcN8jWfG2KzsbnFcQOwJsjNshWsIZtdpOExNZp1BuXjsnXTsLRvbgpVXYv/D7RFNTYxO6Zt59jR6UtZT+MbPs9vgYW1U+NKmIvAzvH6lXvHL8MUB1d0brFqT2DXuDwgyr0VbM5kXADVvY7MWFX7vmS/68TkGJVVCIxKqdp4oE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781522676; c=relaxed/simple;
	bh=HkIgdzwD3ZUKlc+RqWeNOa+3GAYrS8/+G0KPsUOpERM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=D7v0JOvpOpqJADpep6JzBf8d3w/RA3tQb7XtU5atYR2W0gP6FHCFOvOELTx8ORVHXPGFP4kfNiu0kxdLKeYbBe4DcPl0zjpJdiX+XsvdUlzEXU/wKd8VdKPdRu640lF2Ss1+NekT0CXIB5tGe4aoyIhCx77QDVFZZb9eopL+JVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=olyYVGLC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="olyYVGLC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDA2C1F000E9;
	Mon, 15 Jun 2026 11:24:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781522674;
	bh=l6KfNdeBHCprTLPnt2IvqUCjkV0ZTJ9ktB2APjMHbLQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=olyYVGLCkXdE6ptNUTNS4xjQhhd03gVDxrjWpPHGVISfcr6SXgJ5KcZYuHQ2Hto91
	 n41TZCyL8akfO7OLlRm+EAOT6r4lwBv9VZGB0Rwo9AQ2HusJW/cfAAo3i5Kb+sbXkN
	 nEWIgJcbUSJW4hMAXxn2jDT9G4cm54mHda7uDkxFp2zL50TsWTWUq/3W3LrYspc0vp
	 7M6V0PrsGK1VxoMGmUOPsx4epAO889lqgkqZW5fTM3P3Nz5AqkYTErtIGJX1TBWRsw
	 tdgNFtiVle5DbvF6QQgyu6ZnXYLaOCz5oQ2vnFJ1UvjTF7Uz9hgSjdnlSEHg8Z1tuI
	 DfT73c1D+z18Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf 1/2] bpf: Preserve dynptr slice lifetime across
 rdonly_cast
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nuoqi Gui" <gnq25@mails.tsinghua.edu.cn>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260615-f01-09-rdonly-cast-dynptr-lifetime-v1-1-2dd0a369e153@mails.tsinghua.edu.cn>
References: <20260615-f01-09-rdonly-cast-dynptr-lifetime-v1-1-2dd0a369e153@mails.tsinghua.edu.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 15 Jun 2026 11:24:34 +0000
Message-Id: <20260615112434.BDA2C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The verifier tracking logic intended to invalidate `bpf_rdonly_c=
ast` aliases during dynptr stack overwrites can be bypassed by passing an u=
nchecked `PTR_MAYBE_NULL` slice or by chaining casts.
--

commit 4dccf7918016a6c3b330526f04f7eae4bbeed8d8
Author: Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>
Subject: bpf: Preserve dynptr slice lifetime across rdonly_cast

This patch updates the verifier to track lifetime metadata across
bpf_rdonly_cast(). It attaches the ref_obj_id and dynptr_id to casted
registers and ensures typed aliases are invalidated when a dynptr stack
slot is overwritten.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> @@ -12082,8 +12088,17 @@ static int check_kfunc_args(struct bpf_verifier_=
env *env, struct bpf_kfunc_call_
>  			continue;
>  		}
> =20
> -		if (is_kfunc_arg_ignore(btf, &args[i]) || is_kfunc_arg_implicit(meta, =
i))
> +		if (is_kfunc_arg_ignore(btf, &args[i]) || is_kfunc_arg_implicit(meta, =
i)) {
> +			if (meta->func_id =3D=3D special_kfunc_list[KF_bpf_rdonly_cast] &&
> +			    i =3D=3D 0 && is_spillable_regtype(reg->type)) {
> +				meta->rdonly_cast_src.id =3D reg->id;
> +				if (base_type(reg->type) =3D=3D PTR_TO_MEM)
> +					meta->rdonly_cast_src.dynptr_id =3D reg->dynptr_id;

[Severity: Medium]
Could this logic be bypassed by chaining casts?

If a slice is first cast to a struct, the result is PTR_TO_BTF_ID and it
stores the dynptr_id in its id field.

If that result is then cast to void * (returning PTR_TO_MEM),
base_type(reg->type) =3D=3D PTR_TO_MEM will be false, so
meta->rdonly_cast_src.dynptr_id remains 0.

The returned PTR_TO_MEM will get dynptr_id =3D 0, which would bypass the
invalidation checks in destroy_if_dynptr_stack_slot() entirely.

> +				meta->rdonly_cast_src.ref_obj_id =3D reg->ref_obj_id;
> +			}
> +
>  			continue;
> +		}
> =20
>  		t =3D btf_type_skip_modifiers(btf, args[i].type, NULL);

[ ... ]

> @@ -12932,10 +12947,17 @@ static int check_special_kfunc(struct bpf_verif=
ier_env *env, struct bpf_kfunc_ca
>  			regs[BPF_REG_0].type =3D PTR_TO_BTF_ID | PTR_UNTRUSTED;
>  			regs[BPF_REG_0].btf =3D desc_btf;
>  			regs[BPF_REG_0].btf_id =3D meta->arg_constant.value;
> +			regs[BPF_REG_0].id =3D meta->rdonly_cast_src.id;
> +			if (!regs[BPF_REG_0].id)
> +				regs[BPF_REG_0].id =3D meta->rdonly_cast_src.dynptr_id;

[Severity: Medium]
Does this correctly handle PTR_MAYBE_NULL slices passed to bpf_rdonly_cast?

Because bpf_rdonly_cast uses an __ign argument, it can accept an unchecked
PTR_MAYBE_NULL slice. These slices have a non-zero null-tracking id.

If meta->rdonly_cast_src.id is non-zero, this logic prioritizes the
null-tracking ID over dynptr_id. The returned typed alias will inherit the
null-tracking ID instead of the dynptr_id.

Later, when the parent dynptr is overwritten, the invalidation in
destroy_if_dynptr_stack_slot() will fail because it checks if the
dreg->id =3D=3D dynptr_id.

> +			regs[BPF_REG_0].ref_obj_id =3D meta->rdonly_cast_src.ref_obj_id;
>  		} else if (btf_type_is_void(ret_t)) {
>  			mark_reg_known_zero(env, regs, BPF_REG_0);
>  			regs[BPF_REG_0].type =3D PTR_TO_MEM | MEM_RDONLY | PTR_UNTRUSTED;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260615-f01-09-rdo=
nly-cast-dynptr-lifetime-v1-0-2dd0a369e153@mails.tsinghua.edu.cn?part=3D1
