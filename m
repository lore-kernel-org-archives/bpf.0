Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 044834457D7
	for <bpf@vger.kernel.org>; Fri, 24 Jul 2026 19:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784921936; cv=none; b=nDEUYIwmrtGn+zYdMUt3HhUQG7STm3aMNl7e0wJ2vlIu7aEnGi8LDXpzdCe4xLmWoZmWJCiKcdnAvDquB1Zn+TYsdyFqy9bv8nX9CsToh6s6m6oUDlk4RLD1UvxeNjooNuR+zFriqM5Dn0jF5HCUmMFC7vc5qjabyM+FneOpxnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784921936; c=relaxed/simple;
	bh=A9EzM3kQSe6GvMO4s5H+XgjcZYWWqKZglBR5N3sjOrg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=KCLjDCWozHtexKgdkUGUd7R5Zdp3l2mtQbGC0sJamh5bKiSTJX+Qx43/Zr1MdmTPtKbvTPfY+H0j6A930vO0hwbJAp01xt1JWwvj77p4Vgi+HJkIHnKG2PlwC5BsazmlCN+uSV6q+EKMA+VfrDcxUS/zxIfYpVda2v9TFNMPNJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aYZnk94D; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aYZnk94D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57F981F000E9;
	Fri, 24 Jul 2026 19:38:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784921934;
	bh=fXkuMb+n0HhvY5nv1bsBMBQKp5sXGb1nWsy7MgHLdVQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aYZnk94DObA1+zq6VVM1lwxxzTqd0LoRccuW0k5DsYk3SkPKQz3KSXNy+3kp692ve
	 7xqtJNFvaTnUpmEXags2Tsox702h7swx0otrJPGRHftvIm5P8ubcGmXRWFhPqXumVv
	 MLIJie6qdfflvvlLy8tAlsYUIX4EcL6eprDtuEhlbI/hnTAC8dTHCo3V+4ilk3IvIm
	 qIbkp010CU4YtvE2zHV8mOwAhWRqWNqSdzT18e1wXuYw8zfh/WAn4af4qFhfidkAQg
	 nrsyNAWq5Xw7AckKkpvN6fm4xau6bdyR/XvCTH4Ri07kgFFU7j0dQyIT5KtoARIPqg
	 bIObZKhI5wjdA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2 11/18] bpf: Classify kfunc mem_size args
 from BTF without register state
Reply-To: sashiko-reviews@lists.linux.dev
To: "Amery Hung" <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260724190813.1458271-12-ameryhung@gmail.com>
References: <20260724190813.1458271-1-ameryhung@gmail.com>
 <20260724190813.1458271-12-ameryhung@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 Jul 2026 19:38:53 +0000
Message-Id: <20260724193854.57F981F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Removing the `SCALAR_VALUE` check from `is_kfunc_arg_mem_size()` a=
nd `is_kfunc_arg_const_mem_size()` allows unvalidated pointer registers to =
be passed as memory size arguments during kfunc lookahead validation, trigg=
ering a `verifier_bug` kernel warning splat and local DoS.
--

--- Patch [11]: [PATCH bpf-next v2 11/18] bpf: Classify kfunc mem_size args=
 from BTF without register state ---
commit 55013229ec44003dda12328783652d410aa4f75e
Author: Amery Hung <ameryhung@gmail.com>

bpf: Classify kfunc mem_size args from BTF without register state

This commit drops the scalar register type check in is_kfunc_arg_mem_size()
and is_kfunc_arg_const_mem_size() to decouple get_kfunc_ptr_arg_type()
from register state.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 0f8d403083177..f6b373630ca95 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -10795,26 +10795,24 @@ static bool is_kfunc_rcu_protected(struct bpf_c=
all_arg_meta *meta)
>  }
> =20
>  static bool is_kfunc_arg_mem_size(const struct btf *btf,
> -				  const struct btf_param *arg,
> -				  const struct bpf_reg_state *reg)
> +				  const struct btf_param *arg)
>  {
>  	const struct btf_type *t;
> =20
>  	t =3D btf_type_skip_modifiers(btf, arg->type, NULL);
> -	if (!btf_type_is_scalar(t) || reg->type !=3D SCALAR_VALUE)
> +	if (!btf_type_is_scalar(t))
>  		return false;
> =20
>  	return btf_param_match_suffix(btf, arg, "__sz");
>  }

[Severity: High]
Could this removal allow a pointer register to be incorrectly classified as=
 a
memory size parameter during kfunc lookahead validation?

If a BPF program passes a pointer register (such as PTR_TO_STACK with a fix=
ed
offset of 0) instead of a scalar to a size argument suffixed with __sz,
get_kfunc_ptr_arg_type() will now look ahead and classify it solely based on
the BTF signature.

Because of this classification, check_kfunc_args() eagerly processes the
unverified register as a size parameter before the generic scalar validation
loop catches it:

check_kfunc_args()
    ...
    check_mem_size_reg(env, buff_reg, size_reg, argno, next_argno, ...)

Inside check_mem_size_reg(), the pointer with a fixed offset of 0 yields a
size of 0. Since zero-size is allowed, it passes the bounds check and calls
mark_chain_precision() on the pointer register.

Because mark_chain_precision() expects a SCALAR_VALUE, it triggers a
verifier_bug splat for backtracking misuse when given a pointer. On systems
configured with panic_on_warn, this creates a local denial of service
regression.

Should the register type check be retained here, or is there another way to
prevent pointer registers from bypassing validation during the lookahead?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260724190813.1458=
271-1-ameryhung@gmail.com?part=3D11
