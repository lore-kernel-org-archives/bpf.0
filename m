Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52AD034F27B
	for <bpf@vger.kernel.org>; Thu, 23 Jul 2026 08:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784793665; cv=none; b=eZELu7pKBlU4TxNasqhS+v6yR6DicV8JT/YwINDskxKVKB67rUZ3K6gHpJApLmIh3FL+fgdOSDqIcf3fqh/Yj9kh4CuQfNc5YbO3z/nQCOMD2eQp8WUVzaAIErnengGsxDZiY6oWw59lMiz7CWxqpirmOIP0LctWiIqVACMGl2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784793665; c=relaxed/simple;
	bh=agyTYR9DQlLbceL1EprTEiO78zBh/OF3gai4m6lcooA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bpeu2HdVQ3d3k8Bg6nbtMXimh+2b0fjuQjrIK8rthyuy6FglG6/5cJGnacpVJpF2MyxS+slN5Kffmlq8RHTZnxjz8tXF4UYpIgC03GKeRvVTchsLFuqrY0cXYzFvqQumJUFbjITY/zKXS8pZDYtvzw/uX1gqqUfhrY1QgGWebqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=klqrzBHx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="klqrzBHx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE5CF1F000E9;
	Thu, 23 Jul 2026 08:01:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784793663;
	bh=0yLjDDJlVJfPdjKabOA0emZ79pefskUgdxuubC3o73M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=klqrzBHxdwJoCQicOix5syWa1Wh62AwrU0hHlwLoOgCmpMQynrcsKZnkgprs17lpD
	 mY9MFvQsLuzX1xMl7YZWel0nH7oXDxFdtR8obrevpZALSYwYaGDVaYgOPwB00TdiVX
	 I0z90dvxXBbDtLNg3maXftCZ45F5wGMqh4n6OSY7E/u5TZJmhklGIeSYYyJ0GDcUv2
	 EYJcfRa0MosoENCU0i57CZvXNU52S+JFXb4ZZzYNmicuZTy/Jxm0YsVccpzID/vZa5
	 Vd6ngd9pAuxut5S0JWo/7H2SQ17eeFGyN1TG7eCK3v2qzMKJprxvRis0LSVNNaFtRF
	 9cPbeIvayOyVA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v1 17/18] bpf: Classify scalar kfunc arguments
 from BTF
Reply-To: sashiko-reviews@lists.linux.dev
To: "Amery Hung" <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260723050806.1158442-18-ameryhung@gmail.com>
References: <20260723050806.1158442-1-ameryhung@gmail.com>
 <20260723050806.1158442-18-ameryhung@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Jul 2026 08:01:03 +0000
Message-Id: <20260723080103.AE5CF1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Critical] The `KF_ARG_MEM_SIZE` argument type completely bypasses the `S=
CALAR_VALUE` check, allowing eBPF programs to pass massive pointers as buff=
er sizes.
- [Low] Uninitialized variables `ref_t` and `ref_tname` passed by value to =
`get_kfunc_arg_type()`.
--

--- Patch [17]: [PATCH bpf-next v1 17/18] bpf: Classify scalar kfunc argume=
nts from BTF ---
commit ea739f7fbc71c6a534cb3103ddbdf3b31c5f391a
Author: Amery Hung <ameryhung@gmail.com>
Subject: bpf: Classify scalar kfunc arguments from BTF

This patch updates how scalar kfunc arguments are handled by moving their
classification out of the inline register state validation and into BTF-bas=
ed
classification. It adds specific KF_ARG_* kinds for scalars and separates
BTF classification from register validation in check_kfunc_args.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 24858a38c34cf..ba2608592bd5f 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> @@ -12130,11 +12122,13 @@ static int check_kfunc_args(struct bpf_verifier=
_env *env, struct bpf_call_arg_me
>  		if (reg_is_referenced(env, reg))
>  			update_ref_obj(&meta->ref_obj, reg);
> =20
> -		ref_t =3D btf_type_skip_modifiers(btf, t->type, &ref_id);
> -		ref_tname =3D btf_name_by_offset(btf, ref_t->name_off);
> +		if (btf_type_is_ptr(t)) {
> +			ref_t =3D btf_type_skip_modifiers(btf, t->type, &ref_id);
> +			ref_tname =3D btf_name_by_offset(btf, ref_t->name_off);
> +		}
> =20
> -		kf_arg_type =3D get_kfunc_ptr_arg_type(env, meta, t, ref_t, ref_tname,
> -						     args, i, nargs, argno);
> +		kf_arg_type =3D get_kfunc_arg_type(env, meta, t, ref_t, ref_tname,
> +						 args, i, nargs, argno);

[Severity: Low]
If a kfunc call has a scalar argument, btf_type_is_ptr(t) evaluates to fals=
e,
skipping the initialization of ref_t and ref_tname.=20

Could this result in passing uninitialized variables from the stack by value
into get_kfunc_arg_type() during check_kfunc_args()?

[ ... ]

> @@ -12435,6 +12462,19 @@ static int check_kfunc_args(struct bpf_verifier_=
env *env, struct bpf_call_arg_me
>  				}
>  			}
>  			break;
> +		case KF_ARG_CONST_MEM_SIZE:
> +			if (reg->type !=3D SCALAR_VALUE) {
> +				verbose(env, "%s is not a scalar\n", reg_arg_name(env, argno));
> +				return -EINVAL;
> +			}
> +
> +			ret =3D process_const_arg(env, reg, argno, meta);
> +			if (ret < 0)
> +				return ret;
> +
> +			fallthrough;
> +		case KF_ARG_MEM_SIZE:
> +			break;

[Severity: Critical]
Does this allow an eBPF program to bypass the scalar check by passing a
non-scalar register as the size parameter?

Because the KF_ARG_MEM_SIZE case label is placed after the SCALAR_VALUE
check inside KF_ARG_CONST_MEM_SIZE, an argument that is exactly
KF_ARG_MEM_SIZE will jump directly to its label and break out, leaving the
register's type unchecked.

Could this allow programs to pass a pointer as a buffer size, potentially
leading to out-of-bounds memory accesses?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260723050806.1158=
442-1-ameryhung@gmail.com?part=3D17
