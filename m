Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 985813BBFC4
	for <bpf@vger.kernel.org>; Wed,  7 Oct 2026 16:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791391412; cv=none; b=KexFK5lB4xPExngIpx3Kg7ff0/UptiCAh335qOfC4a8xjFKNZ/MO0BjEfjA3j+ZFRfT4x0es2c0S/RyoRO99C3ncRDQtdB1OumSWr+RE0v1xJD9D3elZokxDlRR5dNSLH0lv/ffIyw28+UBLBM85R/l9+NnECfJfLuKnOcI230E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791391412; c=relaxed/simple;
	bh=l+KTUT3F7qrB20HOkBO/LkU5toJJGsn6NN2gz3xjaZo=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=UfO475BRDLBiWPghPbzOBZ8ZoedlHyFcFogVRzrQ8/CBHVzM6TSELjJavGVRduA+cog1eJ5/N0z7vhoUkVg/nuPvXDnUG3GjIabYKyjlMGOdR0YSpqjwXmCKjCDb4St06W+orlEIhfGK5333gtdiY5ZWtESS9LkIIdniC0HW1gA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D56DI7MC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D56DI7MC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 178A61F000FF;
	Wed,  7 Oct 2026 16:43:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791391411;
	bh=MJEi6dHz8BAkxxzixvvmLE+a6r3qZabvMIiJOLt8bmY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=D56DI7MCCgMcFjbVmr+nBcQ/VtblVvq61yyOCSsm8hhcxl5k5/fU0tThHxvoTGXOx
	 JhWWstycCXmr23wDdgRyBwWxNIWmFJWC5FB0ShycqvCRzu/ydFkXConImUwxywVMwF
	 laqg839mLLuvqnq1pwunVxsOMy2Rls9oA6RHljGiqI7gWI9+Q8u/iWLAXwowgwkrgR
	 XirDbE8SAgH2HWJolvsDzjposCYHXi9k5EPH8gOmzsjcZYxG8vU/g0mEGSJ3a9JjRW
	 VXhrcn5fxMm8K/bcEcxsz0wx023oHLnUS/1uQWRZsZvgk6IObcgNfeyVFmUKPe1zmf
	 x3b9QApfZBb0A==
Message-ID: <sashiko-outbox-163202@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v4 1/2] bpf: Enforce trusted BTF ID argument
 provenance
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yiyang Chen" <chenyy23@mails.tsinghua.edu.cn>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261007-a3-arg-trusted-v4-v4-1-253ef3a1a69a@mails.tsinghua.edu.cn>
References: <20261007-a3-arg-trusted-v4-v4-0-253ef3a1a69a@mails.tsinghua.edu.cn>
 <20261007-a3-arg-trusted-v4-v4-1-253ef3a1a69a@mails.tsinghua.edu.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 07 Oct 2026 16:43:30 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] bpf: check_func_arg() allows PTR_UNTRUSTED | MEM_RCU into KF_RCU k=
funcs
--

commit 1e71cf476e59d8805f3765efcab69f9c9d9bba4a
Author: Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>

bpf: Enforce trusted BTF ID argument provenance

This commit modifies the verifier to make the provenance check contract-dri=
ven
by marking generated BTF ID kfunc argument types with PTR_TRUSTED and expli=
citly
adding MEM_RCU only for KF_RCU kfuncs. It uses the normalized type for modi=
fier
checks while reference lookup uses the original register.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 353bde9ae2274..a0ab793f041d8 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
[ ... ]
> @@ -9605,8 +9614,10 @@ static int check_func_arg(struct bpf_verifier_env =
*env, u32 arg, u32 slot, u32 p
>  			}
>  		}
> =20
> -		if (is_kfunc(meta) && (!is_trusted_reg(env, reg) ||
> -				       bpf_type_has_unsafe_modifiers(reg->type))) {
> +		reg_type =3D reg->type & ~(arg_type & PTR_MAYBE_NULL);
> +		if ((arg_type & PTR_TRUSTED) &&
> +		    (!is_trusted_reg_type(env, reg, reg_type) ||
> +		     bpf_type_has_unsafe_modifiers(reg_type))) {
>  			if (!(arg_type & MEM_RCU)) {
[ ... ]
>  				return -EINVAL;
>  			}
>  			if (!is_rcu_reg(reg)) {
[ ... ]
>  				return -EINVAL;
>  			}
>  		}

[Severity: High]
Does this allow a register with both MEM_RCU and PTR_UNTRUSTED modifiers to=
 be
passed into KF_RCU kfuncs?

If a BPF program loads a pointer that is marked as PTR_UNTRUSTED | MEM_RCU =
(for
example, when loading an __rcu pointer embedded in a union) inside an RCU
critical section, and passes it to a KF_RCU kfunc:

1. The arg_type has MEM_RCU, so the first inner check !(arg_type & MEM_RCU)=
 is
   false.
2. The register has MEM_RCU, so the second inner check !is_rcu_reg(reg) is
   false.
3. The validation falls through and succeeds, even though the register has =
the
   PTR_UNTRUSTED modifier.

Since check_reg_type() bypasses the strict compatible_reg_types check for k=
func
BTF_ID arguments, this appears to leave the verifier without any checks that
would reject the untrusted modifier here. Can this result in untrusted garb=
age
pointers being used as valid RCU pointers?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261007-a3-arg-tru=
sted-v4-v4-0-253ef3a1a69a@mails.tsinghua.edu.cn?part=3D1
