Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794376092;
	b=2AhK14UC4X7iJQrqfKnMfx9K3J+Yyu9k4Co6fiUDAQs1FCaK+EfhR+djdPqt8hceQtcc
	 PH6EdmYgvXcrM+eus4vcwZDu34Ja0DDODnl1BCWaKaX0DyEipxfpNCzOYOCEYq3FGCR0B
	 JQzXkxrnUKElQf1pDDZoRiBzvEax6PHG5+C2oKtKser0xUphlOMDYGqv77FT98zDbah1E
	 scePDJBBw6O/nb2DE7X4oGafQ//3QieV8+yHXdreRr50Kab92EPqykUW3XsEgzeW5TPIU
	 EzB3d5qkxH2Q2ssios5VNaKwsD8h+O7yYiPmK5tOq3RLfRX1VA804SjJSU47QkUAEgA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794376092;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=+ML24gdrBTLKYC744so9nsTY/8WD8Te28oLZslIJscw=;
	b=lFJcwitMdCq3NlOZc2XtpxIR1ApYqEFjdzMLhsEDhFNDviP1Yt9nfe9XFy3iyUd741dJ
	 mfLt8zUWK3XzpFFeNKSUQIdfzLSrFSMWwg607VFrdyDHuS+ieQoAxTQ7XzuF099zmWcky
	 WVarGOQJrbvTziIEAaqWandeZPihqoGrMpWrSXh8HyVaZf22LVgoPNuAFmjgixUcHuMiw
	 1R8kjr9AJ+e9p4lEldh/Iu+3Rhav8V571wKU+b6OporO0AZoRS9oX01oXRV65ZKJq63cn
	 XEJGKMGVrNqg/yoBUyQNvlIVO7fGjSOyiSROD8D2pfFOILpWzC/DC9e9qEO3ZQ2WBZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lUTV0EfU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17AA2606A31C
	for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 05:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lUTV0EfU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 748D01F00A05;
	Wed, 11 Nov 2026 05:48:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794376091;
	bh=+ML24gdrBTLKYC744so9nsTY/8WD8Te28oLZslIJscw=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=lUTV0EfUmazWLhY76jctiBfOkmusCmCFANOas/dMW6LDBLvHRFHTWFWJXgWJZETdx
	 u7ZN9N3hK9uxgwRjfIzfYNLs8Pq2AToKpu7ZulLwouMJiGHW7bWuMktn6cY4BZ/kK5
	 c/dFu8zvQECbDE4dBN+JuQAPpU9nusdgh0/Wzd7IBUtCMJmH8FBPw2GBi9Lxc+X2ub
	 y+FgyViX/iEggm4KS3EUnw8lWNDTzQZvD/gf5d9g9rHvFuBWkUYUIoy37XdHkBYgdK
	 AAHAF1qBMkcszBkaCVpRnbFo0V2rvfWIsT3mHP9Y3mVqv+U2PIAIaZm++eaYplILUN
	 YInBpVdpr7sig==
Message-ID: <sashiko-outbox-208365@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2 16/29] bpf: Recompute a pointer after the
 jump that bounds its index
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
In-Reply-To: <20261111051341.2800252-17-alexei.starovoitov@gmail.com>
References: <20261111051341.2800252-1-alexei.starovoitov@gmail.com>
 <20261111051341.2800252-17-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 05:48:10 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [High] bpf: missing BPF_MAX_VAR_OFF offset bounds check in
  recompute_ptr()
--

commit 5f6f31940968145851bf6579a0206e69bee69836
Author: Alexei Starovoitov <ast@kernel.org>

bpf: Recompute a pointer after the jump that bounds its index

This commit extends linked-register refinement at conditional jumps to
recompute a pointer register p =3D x + i once a conditional jump bounds the
index i.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 138581a759bbb..c2a3f74d441fe 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -19741,6 +19741,43 @@ static struct bpf_reg_state *scev_reg_for_fill(s=
truct bpf_func_state *frame, u32
>  	return &ss->spilled_ptr;
>  }
> =20
> +/*
> + *	p =3D buf + i; if (i > 100) return 0; *p =3D 0;
> + * p is @dst_reg, x is @ptr_reg, i is @off_reg. Scalar evolution says th=
at p =3D=3D x + i. So the insns
> + * 'p =3D x; p +=3D i' are a no-op at run time, and a state that is soun=
d before them is sound after
> + * them: apply their transfer function. Type, object and offset of p are=
 taken from x as it is now;
> + * how p was computed does not matter.
> + * The old p is replaced, not intersected: a state does not distinguish =
two values of one hash map,
> + * and the intersection of an offset into the one with an offset into th=
e other holds for neither.
> + * It is replaced only if the new range is a subset of the old one. An e=
mpty range is a subset too:
> + * the path is infeasible, p is left as it is.
> + */
> +static bool recompute_ptr(struct bpf_verifier_env *env, struct bpf_reg_s=
tate *dst_reg,
> +			  const struct bpf_reg_state *ptr_reg, const struct bpf_reg_state *of=
f_reg)
> +{
> +	struct bpf_reg_state sum =3D *ptr_reg;
> +
> +	/* the cpu can speculate past the jump with an out-of-bounds index */
> +	if (!env->bypass_spec_v1)
> +		return false;
> +	/* 'p +=3D i' assigns a new id to a packet pointer */
> +	if (ptr_reg->type =3D=3D SCALAR_VALUE || type_is_pkt_pointer(ptr_reg->t=
ype) ||
> +	    !bpf_is_widenable_reg_type(ptr_reg))
> +		return false;
> +	__mark_reg32_unbounded(&sum);
> +	scalar_step_add(&sum, ptr_reg, off_reg);
> +	sum.r64 =3D cnum64_add(ptr_reg->r64, off_reg->r64);
> +	sum.var_off =3D tnum_add(ptr_reg->var_off, off_reg->var_off);
> +	reg_bounds_sync(&sum);
> +	if (reg_is_empty(&sum) || const_tnum_range_mismatch(&sum) ||
> +	    const_tnum_range_mismatch_32(&sum))
> +		return false;
> +	if (!bpf_reg_union_compatible(dst_reg, &sum) || !cnum64_is_subset(dst_r=
eg->r64, sum.r64))
> +		return false;
> +	*dst_reg =3D sum;
> +	return true;
> +}

[Severity: High]
Can recompute_ptr() overwrite *dst_reg with a pointer offset outside
(-BPF_MAX_VAR_OFF, BPF_MAX_VAR_OFF)?

When adjust_ptr_min_max_vals() verifies the earlier p =3D x + i while i is
not yet constant, check_reg_sane_offset_scalar() and
check_reg_sane_offset_ptr() only check known constant offsets and smin,
so dst_reg->r64 can have an smax >=3D BPF_MAX_VAR_OFF (for example
[-16, 0xfffffff0ULL] on PTR_TO_STACK).  If a subsequent conditional jump
narrows i to the constant 0xfffffff0ULL, cnum64_is_subset(dst_reg->r64,
sum.r64) succeeds and recompute_ptr() sets dst_reg->var_off.value to
0xfffffff0ULL without calling check_reg_sane_offset_scalar() or
check_reg_sane_offset_ptr().

Downstream callers that assume a constant var_off.value fits in 32 bits
then truncate it, allowing out-of-bounds kernel memory access at runtime:

kernel/bpf/verifier.c:stack_slot_obj_get_spi() {
	...
	off =3D reg->var_off.value;
	if (off >=3D 0 || off % BPF_REG_SIZE) {
	...
}

Here 0xfffffff0ULL is truncated to int off =3D -16, validating stack slot
fp-16 while passing r10 + 0xfffffff0ULL to the helper or kfunc.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111051341.2800=
252-1-alexei.starovoitov@gmail.com?part=3D16
