Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71C2913777E
	for <bpf@vger.kernel.org>; Thu, 27 Aug 2026 06:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787812436; cv=none; b=AtD+KPXcK3d6tNEG5yQI9UVlt24qfkLpK9vA3aBdbEenAhYwiahMo2WjaSYJFpxLHpH+W0dZYl2SP2Az3B2rVHQsoW4M3QPVvE9NqKhhgulZcabxWe8UlRlkmdGBZKmzLNGbAS5yDY8JRKD1+p0KJYYoUpHjvX3hp8FWM2e+Nu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787812436; c=relaxed/simple;
	bh=PNY/wwv4AqGfOnaHo9t0NG2Hfd6/A89n/DMopZeTbzE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GnYe1HfK9wMtQtlzXkY1yYjTL25e3m73R00QkpOuiTFU8yLeKnASgZDYn22k6A65qO6DxlJFBR0nFqQtRQKtsr7Jfr8epjCEqU6X9CTTSUQl/8lknYzYGhBs+awRk04Qf8AzLKbs5zuQA0iEiaikIL8+9qhlO/xE5TaTYl2sh1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nsQi+Atk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nsQi+Atk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D50501F000E9;
	Thu, 27 Aug 2026 06:33:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787812435;
	bh=nQZgQuRP6D81mjWXD+4ztm5u4R8uIidDqmddn7T3OPM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nsQi+Atkxkosv96NpN515N5g+ebQVivzFXy/5ZzEsmv2v5oflItoLILHbDkUlZH+r
	 AgwHQ342Njn8c2USBsHABpJKT42f8SIzBMfNTxkCUE6xX8ZwX3XKtlUcydAKZPICli
	 yHYTJrczCOg8n6tTQvFypc9y0OJ6UsZu1MGdkYwDQTIhPnKUJJ2dtkzJAin9XU3+00
	 Hdz7Nt4VKgrXVU7R2qvAjIAxjghFZfkxuDON5E/JVaqDWA32aBJjY5kwNqpusJcedh
	 rq76cBkqG9Xvv2DO8oXQyDqV/plJiMnVONv0m6DFmWdEz+leAjL5rc6yWWaHOcJoj6
	 ieXgV6I8ULp6w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v3 06/11] bpf: Allow a global function to
 return arena pointers by value
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yonghong Song" <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260827061145.2517714-1-yonghong.song@linux.dev>
References: <20260827061114.2514603-1-yonghong.song@linux.dev>
 <20260827061145.2517714-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 27 Aug 2026 06:33:54 +0000
Message-Id: <20260827063354.D50501F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The verifier error message for unsupported return types incorrectly=
 claims that arena pointers are supported for the main BPF program, when th=
ey are actually rejected.
--

commit 518fd93d71684c317540966a4f0aa467d524c25b
Author: Yonghong Song <yonghong.song@linux.dev>

bpf: Allow a global function to return arena pointers by value

This patch allows global functions to return a struct by value that contains
arena pointers. It updates btf_validate_return_type() to allow arena pointe=
rs
and adjusts the corresponding error message in btf_prepare_func_args().

> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index b1f4ef614d4c4..f6d82a8fd617b 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -7973,13 +7973,22 @@ static int btf_validate_return_type(struct bpf_ve=
rifier_env *env, struct btf *bt
>  	if (btf_type_is_struct(t) && t->size <=3D 16) {
>  		/*
>  		 * A global function's caller models the return as an opaque
[ ... ]
> +		u32 member_kinds =3D BTF_MEMBER_SCALAR;
> =20
> -		if (local_func || btf_struct_is_composed_of(env, btf, t, BTF_MEMBER_SC=
ALAR))
> +		if (subprog)
> +			member_kinds |=3D BTF_MEMBER_ARENA_PTR;
> +
> +		if (local_func || btf_struct_is_composed_of(env, btf, t, member_kinds))
>  			return 0;
>  	}
> =20
> @@ -8075,7 +8084,8 @@ int btf_prepare_func_args(struct bpf_verifier_env *=
env, int subprog)
>  		if (is_global) {
>  			bpf_log(log,
>  				"Global function %s() has unsupported return type. "
> -				"Only void, scalar, or a scalar-only struct/union up to 16 bytes is =
supported.\n",
> +				"Only void, a scalar, an arena pointer, or a struct/union of "
> +				"scalars and arena pointers up to 16 bytes is supported.\n",
>  				tname);
>  		}
>  		return err;

[Severity: Low]
Does this new error message in btf_prepare_func_args() incorrectly claim th=
at
arena pointers are supported for the main BPF program?

In btf_validate_return_type(), arena pointers are only added to member_kinds
if subprog is non-zero:

    if (subprog)
        member_kinds |=3D BTF_MEMBER_ARENA_PTR;

However, if a user attempts to load a main BPF program (subprog =3D=3D 0) w=
ith a
global linkage (like BPF_PROG_TYPE_EXT) that returns a struct containing an
arena pointer, it will be rejected by btf_validate_return_type() but then p=
rint
this error message incorrectly implying that arena pointers are supported.

Should the error message be adjusted, or should the subprog check be change=
d so
they match?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260827061114.2514=
603-1-yonghong.song@linux.dev?part=3D6
