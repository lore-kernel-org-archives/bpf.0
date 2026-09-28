Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CB0038D3F9
	for <bpf@vger.kernel.org>; Mon, 28 Sep 2026 18:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790620107; cv=none; b=MoJhNghEeIxDUFFbTQ6GPsubsuP1+nCQjWmkQ+JMQVslLyDuKDeNAvM27AotC8D3kubHZiF9gUJg+2aK0vpOqLRs0ACXhi/LGltzKj+X5pHqpA5n7iq9M81jc8KJzVfTB7kBpAzPCWZdXMSnMq7K4eo+3cN0qCsj1TqHMuSPoLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790620107; c=relaxed/simple;
	bh=ZhXWr/RZlpDNw60C16o/Ks1nqFW07EDBqdOM5nr8I2M=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FbA43aK4rdn1Q9kl9zOOzewH8BA9OynEghgEde86wiqSLjnBeK1KtQwH8ZKwdboA9+ng7bu8TzjnGIEr59vULlPviEKDrnqUwx0aGzzftzWCsSIvbyIGkXG1unc7WR4QXH0vCh438Jn7qhhLK+XivJwhenFBPwDFYTBUom/cQ6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ii1QcXku; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ii1QcXku"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EFEF1F000FF;
	Mon, 28 Sep 2026 18:28:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790620103;
	bh=cjNP5KZIvvtAnIqcCK/0694p/bwsl50BFtDlMEsBA2o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ii1QcXkuM/8QCpbnc5N1gRU6iEJi+F90KSkSOVMk1GtBsYM7vAeUdv3edhQnyaUxq
	 RquurVLrPtD92zv2yLEtoIJIIgJP/f6TDDYlC8agX+7u8Lan6bDPtW/JlKT+9xuZVp
	 xM3PpX+mxDzhr7V3DPMxZC7aKH8S4Ggtyojw+fulKPuwU38jnDPY+JiPK2r4C74LhT
	 t+0ZXWvZ1dlU4++Bn8emBZJ2D5l2vuR+mhqn6mUSLxL4yubDwtFdZ7WoCJqAh4QS+A
	 lBsOhn8CrPjGNu3umHcdwgRLQhgCT0OJJjwRnV2dqfTPW1YHIjxtHx6BTyVP3eWPKl
	 omftljMbQyW6A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2 08/11] bpf: Check subprog dynptr arguments
 in the common path
Reply-To: sashiko-reviews@lists.linux.dev
To: "Amery Hung" <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260928181414.644158-9-ameryhung@gmail.com>
References: <20260928181414.644158-1-ameryhung@gmail.com>
 <20260928181414.644158-9-ameryhung@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Sep 2026 18:28:22 +0000
Message-Id: <20260928182823.0EFEF1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] bpf: dead code and unreachable diagnostic in process_dynptr_func()
--

commit a02951e0de8834e87c650bf3681861699a204241
Author: Amery Hung <ameryhung@gmail.com>

bpf: Check subprog dynptr arguments in the common path

This commit routes subprog dynptr arguments through check_func_arg() to ens=
ure
register types, offsets, and dynptr states are validated in a common order.=
 It
also updates a related selftest to maintain consistent failure states across
different compilers.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index efb20e50c974a..075002f6a59fe 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -10883,7 +10883,7 @@ static int btf_check_func_arg_match(struct bpf_ve=
rifier_env *env, int subprog,
>  		nslots =3D btf_arg_slots(t);
> =20
>  		if (arg_type =3D=3D ARG_SCALAR || arg_type =3D=3D ARG_IGNORE ||
> -		    arg_type =3D=3D ARG_PTR_TO_CTX ||
> +		    arg_type =3D=3D ARG_PTR_TO_CTX || arg_type =3D=3D ARG_PTR_TO_DYNPT=
R ||
>  		    base_type(arg_type) =3D=3D ARG_PTR_TO_ARENA) {

[Severity: Low]
Does routing this through check_func_arg() render the register type validat=
ion
in process_dynptr_func() redundant and unreachable?

Since check_func_arg() calls check_reg_type() before process_dynptr_func(),
the requirement for PTR_TO_STACK or CONST_PTR_TO_DYNPTR is already enforced
earlier in the flow.

This makes the custom error block in process_dynptr_func() dead code:

kernel/bpf/verifier.c:process_dynptr_func() {
	...
	if (reg->type !=3D PTR_TO_STACK && reg->type !=3D CONST_PTR_TO_DYNPTR) {
		verbose(env,
			"%s expected pointer to stack or const struct bpf_dynptr\n",
			reg_arg_name(env, argno));
		...
		return -EINVAL;
	}
	...
}

The selftest updates in this patch seem to confirm this, as the expected
error message is changed from this custom diagnostic to the generic one
produced by check_reg_type().

>  			ret =3D check_func_arg(env, arg, slot, 0, &meta, env->insn_idx);
>  			if (ret)
> @@ -10912,15 +10912,6 @@ static int btf_check_func_arg_match(struct bpf_v=
erifier_env *env, int subprog,
>  					reg_arg_name(env, argno));
>  				return -EINVAL;
>  			}
> -		} else if (arg_type =3D=3D ARG_PTR_TO_DYNPTR) {
> -			ret =3D check_func_arg_reg_off(env, reg, argno, ARG_PTR_TO_DYNPTR);
> -			if (ret)
> -				return ret;
> -
> -			ret =3D process_dynptr_func(env, reg, argno, env->insn_idx,
> -						  arg_type, &meta);
> -			if (ret)
> -				return ret;
>  		} else if (base_type(arg_type) =3D=3D ARG_PTR_TO_BTF_ID) {
>  			int err;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260928181414.6441=
58-1-ameryhung@gmail.com?part=3D8
