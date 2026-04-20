Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAE0E13D51E
	for <bpf@vger.kernel.org>; Mon, 20 Apr 2026 04:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776657638; cv=none; b=nibu3YQGLRKWe9/OJ4YiMlImlvCkkYFKqW9jQp3AesdciAm5IWiXv9Yfj91PByX/RPjXkAqwQhbOMphisqOdCzEGDEkB66WRMrp93EkzkUeMZaPWz6jnxf8QDIuoDdR/ZeaoLLFfpb6QVocSotYtmiJB73iip9jLfUOaD9pdMYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776657638; c=relaxed/simple;
	bh=VABlcxgdaMr+0sV+51KEnnYOMCrRZF4if7ZFD5uf4KI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=EPQ9iYXte3hJ8i1kkICmzN2JyQvbqfylHuff34Ya/nLvGL6zcsZmzMBBWgVuFUkb+mPQWI0CQEfGpSlOLaGOuvq2xkVlrw0O+udv2Vjt81gfkBENWhbyn2e+FSRtQCxpevvwpLjD/V/qdHJjH/rri8tvu26o3ZVEfG40zdvuEzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PMyNetD3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PMyNetD3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5396BC19425;
	Mon, 20 Apr 2026 04:00:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776657638;
	bh=VABlcxgdaMr+0sV+51KEnnYOMCrRZF4if7ZFD5uf4KI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=PMyNetD31F3sGpwBq4mObU2VO+97I0CvSbXJLdIna83cUSl2bTi2Q/L1gRN17jHE7
	 nP91XCsI50ypQ6VgYgOSbWSKT6S90OrSOhrNx7QFg/s2pU584ye2rRz04ua7TlHqqf
	 wieEqra1oJdaf6lDJg0Fp6oKBp+SMM+Y1IjPbegPSq2cPLi3Egdchie+FjJ1Yqr5gj
	 4PzFq2TNFWXIG5tNbaQRTjmboNXc55dPEDMxVe0c+xyuuPJB8cHJvwL6fqoOrz9xLt
	 I/hqXxhVQdXZ9P+8bVSw8TmFbHkoz4k/wuIcZsalK61IJ9Gj4qPaFTXcWmBeRrOohu
	 /QQ3jC2/+C75g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] bpf: verifier: fix NULL deref in map_kptr_match_type()
 for scalar regs
Reply-To: sashiko@lists.linux.dev
To: "Avinash Pal" <avinashpal441@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260419035948.9498-1-avinashpal441@gmail.com>
References: <20260419035948.9498-1-avinashpal441@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Apr 2026 04:00:37 +0000
Message-Id: <20260420040038.5396BC19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Sashiko AI review found 2 potential issue(s):
- [Medium] Invalid union access and type punning due to unverified `reg->bt=
f` read.
- [Medium] Flawed bug diagnosis; patch addresses a structurally unreachable=
 code path.
--

commit ce0e8cc557a90340c0553cc6fd6f929375190b78
Author: Avinash Pal <avinashpal441@gmail.com>

bpf: verifier: fix NULL deref in map_kptr_match_type() for scalar regs

This commit adds an early NULL check for the register BTF field in
map_kptr_match_type() to prevent an alleged NULL pointer dereference
when a scalar value is evaluated.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D221372

> Call chain:
>   check_store_reg()
>     -> check_mem_access()
>        -> check_map_kptr_access()
>           -> map_kptr_match_type()
>              -> btf_is_kernel(reg->btf)   <-- NULL deref
>
> For scalar registers reg->btf is NULL. map_kptr_match_type() passes
> this directly to btf_is_kernel(), which performs a container_of()-based
> offset access and triggers a general protection fault:

Is this sequence actually possible in the unpatched code?

Looking at map_kptr_match_type(), the base register type is checked
before btf_is_kernel() is ever called:

    if (base_type(reg->type) !=3D PTR_TO_BTF_ID)
        goto bad_type;

    if (btf_is_kernel(reg->btf)) {
        ...

For a scalar register, base_type(reg->type) evaluates to SCALAR_VALUE,
causing it to fail the PTR_TO_BTF_ID check and jump to the bad_type label
without evaluating btf_is_kernel(reg->btf).

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 69d75515ed3f7..15b8f71074f93 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -4545,6 +4545,18 @@ static int map_kptr_match_type(struct bpf_verifier=
_env *env,
>  			       struct btf_field *kptr_field,
>  			       struct bpf_reg_state *reg, u32 regno)
>  {
> +	/*
> +	 * If the source register has no BTF type (e.g. it is a scalar),
> +	 * it cannot possibly match a kptr slot. Reject early to avoid
> +	 * passing a NULL reg->btf to btf_is_kernel(), which would cause
> +	 * a NULL pointer dereference inside that function.
> +	 */
> +	if (!reg->btf) {

Is it safe to access reg->btf before verifying the register type?

In struct bpf_reg_state, the btf pointer is part of an anonymous union
and shares memory with fields used by other register types, such as
range for PTR_TO_PACKET or mem_size for PTR_TO_MEM.

If a non-BTF register is evaluated and its aliased memory happens to be 0
(for example, a packet pointer with range =3D=3D 0), could this incorrectly
trigger the early exit with -EACCES? This would bypass the expected type
mismatch handling and -EINVAL return code in the bad_type block.

> +		verbose(env, "R%d is not a pointer, cannot store into kptr slot\n",
> +			regno);
> +		return -EACCES;
> +	}
> +
>  	const char *targ_name =3D btf_type_name(kptr_field->kptr.btf, kptr_fiel=
d->kptr.btf_id);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260419035948.9498=
-1-avinashpal441@gmail.com?part=3D1
