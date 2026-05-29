Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1706D3B47D6
	for <bpf@vger.kernel.org>; Fri, 29 May 2026 08:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780045175; cv=none; b=uTC8tFpSCxt0JT/UJurIgugV6krAD0jWwbXGFocxczmCLJk5WLOQ3/DmPbWcNjW0kTZFk48dWuRt0mpWVsa15SuRrHlOvJXHZfzX5YvKyHJ/yDGOl3se32cjezYtdsFiltxSFzwsPLQbTLLuY50aEvYYlTrdSOBnSR2lQBYy2+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780045175; c=relaxed/simple;
	bh=LQ384OTRpp5hGIIIMVjSY1ltmB0vquK45EwYMLyVoDE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=RtfG8oFv/6YOSdloun559tp15Kiuibs9oJ2vPWBWjxORSoPiTTlpns8Km+kSEEJ5xPEFBzONpl6JOtWCKwXF7PyzDb1dA6+EJrpnDXnZiKGEsY0f+8H9YUEq/SX9XsqXI6jFqDR8vhnkp6+I8s6U6zNE1vZ4cbsOdWxX3hXFiH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T7OTZMdI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T7OTZMdI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3B101F00893;
	Fri, 29 May 2026 08:59:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780045173;
	bh=Y0S3MGeS1vewhtIyMw4x2YxFPhfKHXqpiHtZ1udIdX4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=T7OTZMdIZ5x+3rnzR2XFSvJI8Y6Xk0mkqjlpCsS4jLi+whkm8MPpd2oHH7rSKFXs5
	 5W1y0FxKi6vd0t2D9CSuLNedF6k7dzXoF75uUDdojYD3HPEkNuDZbAy0WNhzYVkhPU
	 oGCTWgzldL6PJpsPiClP5Ai6bKCSXdcbV3z7dMI3NIkEi0okwAUgZPRDZ7bxhi7NEe
	 BYs/NBNDaxTZHwNiuilMf1oNq45ht8Oe7kL6Hqj3Z5vkLmXhElVFjBnN/9dsmHK7iz
	 vbm//Ay4XP2SXxg6U0hk9AA69KF8iruMLbc+ptc2Dk+M3VR2h4uqmIVJoG3yUGwmMC
	 yvq34wjejr8+A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf 1/2] bpf: fork state when comparing sign crossing
 ranges with zero
Reply-To: sashiko-reviews@lists.linux.dev
To: "Eduard Zingerman" <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260529-cnum-split-at-zero-v1-1-986c03752226@gmail.com>
References: <20260529-cnum-split-at-zero-v1-1-986c03752226@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 29 May 2026 08:59:33 +0000
Message-Id: <20260529085933.A3B101F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] Inconsistent verifier state and bypassed linked register synchro=
nization.
- [Medium] Missing scalar type check applies zero-comparison workaround to =
pointer offsets.
--

commit dc22ab232b73a45e1aacc8d291fb5640c3a0d950
Author: Eduard Zingerman <eddyz87@gmail.com>

bpf: fork state when comparing sign crossing ranges with zero

This commit introduces a workaround for the verifier when evaluating a
comparison of a sign-crossing scalar against zero. It forks the verifier st=
ate
to process negative and non-negative branches separately, restoring precisi=
on
lost in the cnum-based scalar representation.

Link: https://lore.kernel.org/bpf/96c4a1aa4333d10b882a9b5093d2d982f9f106e3.=
camel@gmail.com/T/

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index c8d980fdd7099..7998e8da5e554 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
[ ... ]
> @@ -15965,6 +15965,73 @@ static void sync_linked_regs(struct bpf_verifier=
_env *env, struct bpf_verifier_s
> +static int maybe_fork_cmp_with_zero(struct bpf_verifier_env *env,
> +				    struct bpf_insn *insn,
> +				    struct bpf_reg_state *src_reg,
> +				    struct bpf_reg_state *dst_reg)
> +{
[ ... ]
> +	if (!is_reg_const(src_reg, is_jmp32) || reg_const_value(src_reg, is_jmp=
32) !=3D 0)
> +		return 0;
> +

[Severity: Medium]
Does this code apply the scalar workaround to pointer types?

It appears that dst_reg is not checked for SCALAR_VALUE. If dst_reg is a=20
valid pointer with a variable offset (e.g., PTR_TO_MAP_VALUE) that happens=
=20
to cross zero, and the program compares it against zero (if (ptr =3D=3D 0))=
,=20
the verifier might artificially restrict the pointer's offset and fork the =
state.

Since valid pointers are not zero, both forks will follow the fall-through=
=20
path, meaning this doesn't create a safety vulnerability but could lead to=
=20
unnecessary state exploration and semantically incorrect behavior. Should w=
e=20
verify dst_reg->type =3D=3D SCALAR_VALUE here?

> +	bool cross_sign32 =3D is_jmp32 &&
> +		dst_reg->r32.size < S32_MAX &&
> +		cnum32_smin(dst_reg->r32) < 0 && cnum32_smax(dst_reg->r32) > 0;
> +	bool cross_sign64 =3D !is_jmp32 &&
> +		dst_reg->r64.size < S64_MAX &&
> +		cnum64_smin(dst_reg->r64) < 0 && cnum64_smax(dst_reg->r64) > 0;
> +	if (!cross_sign32 && !cross_sign64)
> +		return 0;
> +
> +	fork =3D push_stack(env, env->insn_idx, env->insn_idx, cur->speculative=
);
> +	if (!fork)
> +		return -ENOMEM;
> +
> +	fork_dst_regno =3D swapped ? insn->src_reg : insn->dst_reg;
> +	fork_dst_reg =3D &fork->frame[fork->curframe]->regs[fork_dst_regno];
> +	if (is_jmp32) {
> +		cnum32_intersect_with_srange(&dst_reg->r32, S32_MIN, -1);
> +		cnum32_intersect_with_srange(&fork_dst_reg->r32, 0, S32_MAX);
> +	} else {
> +		cnum64_intersect_with_srange(&dst_reg->r64, S64_MIN, -1);
> +		cnum64_intersect_with_srange(&fork_dst_reg->r64, 0, S64_MAX);
> +	}

[Severity: Medium]
Are we leaving dst_reg and fork_dst_reg in an inconsistent state by not
calling reg_bounds_sync()?

Because dst_reg->r32 or r64 are modified directly here without syncing,=20
the bounds are narrowed but var_off and the other bounds remain wide.

Additionally, because the dst_reg bounds are forced to be strictly negative=
=20
here, is_branch_taken() later in check_cond_jmp_op() might evaluate=20
the branch statically (pred =3D=3D 0). If it does, check_cond_jmp_op() will=
=20
return early and completely bypass sync_linked_regs() for the current branc=
h.

While this makes the verifier strictly more conservative for the linked
registers (since wider bounds fail faster), it could cause linked registers
to lose precision and lead to potential spurious rejections.

> +	return 0;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260529-cnum-split=
-at-zero-v1-0-986c03752226@gmail.com?part=3D1
