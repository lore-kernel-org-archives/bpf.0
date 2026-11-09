Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794209566;
	b=qMqNAjiP2Vby3M2l3KfRBDa28SZFoytMVo+L/I1C+lv0K+iBeiRtfaa7rsOC7DmGWtH8
	 iKCBbDX3H/ro/rUsim38AavM+02BZ6cfJUxYzROZ8uUieEg7fIJp0X9/jiH90HHOAwkki
	 IZN3/UE5uMjnOpWOp5c1SMZcgepdwJLCxtTD2YDxseiLVwrp9DcBW9eJ5JBklYTEoVjcz
	 nbOXFxakc0wRJgXfPTR9e8ujhdrX3Iacg/f8qHtZRlBW+Xt/kcm7NS2MorAbDe+BVEPKi
	 DQvEvaQHEf8ylFuAGTBOnfSoNBsQZspc8b17Drjhe0goi32YWixXn9vQLcB0W464xkg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794209566;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=afzsI5xJiNH+0Zh1M5qypdgmPMSFqi42/EgP36Y/aR4=;
	b=f5G61/jWtHrkj51r1s+714yKGCMxUOiHQeBu+NJlSNjPuZfAhhIUaqSnHTvSAtnV+Tk1
	 p2VEsxpAPDE7e1iZXHdF2RhqMLUDII+ETjI4XRNczOBxTPSs3kaQ135xxq4hR5tmmBTCj
	 6RCAjsaacBLsU2rQXFLi0jr/e9iuR5UVYvhOUbf3OHEyuK2seWG1BkkhI6SpJRSNu1v+x
	 T2rgwXC47fNVzcQGWAUpqhF27fUvryIQV9hG/0BcQyma6eiWRl32tAqKPS7kJg47c/NP+
	 nZzyjtV5V5HE9545MsdpPQMZEi0BIvQzlm5pDaygeRNBaLRw6m7PRFwdgPC9P9CZF9w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nY6JsOAT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E7C7606A321
	for <bpf@vger.kernel.org>; Mon,  9 Nov 2026 07:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nY6JsOAT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 871A31F008A1;
	Mon,  9 Nov 2026 07:32:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794209565;
	bh=afzsI5xJiNH+0Zh1M5qypdgmPMSFqi42/EgP36Y/aR4=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=nY6JsOATZnmGlnFI3Xjjo/dlqOlzj5hHo6dt3eW58yXj7SAQEh9YO6apDcrdtoVdJ
	 Www93bdrRkRe7MpiLrD+TOBA1ezhj2h3bzvPe5WlrTHDN2F+bSBnWaxWaia5DKf6Y2
	 E8u3l9dVAYMBCiIFN0I9Y2BfVYcN62N01iowi+1FnSgkuNR6RtTsG7xa31eVRUhZTA
	 o5Uu8nrBIRWMII4233Ng/9J5JJwMgq99JgAhn1WTVoTRYI3TzwSRNe9tW5OBLhbVat
	 VI3B2D9XydJQPV/oBBoR5R32nI+C3hT049nbCxHW5ISj8RUBfGC27RjN8Gjp4jKyiv
	 PsTEfsViVJHOQ==
Message-ID: <sashiko-outbox-204545@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 15/26] bpf: Recompute a pointer after the jump
 that bounds its index
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
In-Reply-To: <20261109064715.2382452-16-alexei.starovoitov@gmail.com>
References: <20261109064715.2382452-1-alexei.starovoitov@gmail.com>
 <20261109064715.2382452-16-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 07:32:45 +0000
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
- [Medium] bpf: empty range accepted in recompute_ptr() and
  refine_linked_regs()
--

commit 409be5926da88fb4098b077eaa16b9ed30f13887
Author: Alexei Starovoitov <ast@kernel.org>

bpf: Recompute a pointer after the jump that bounds its index

This commit extends scalar evolution linked-register refinement at
conditional jumps to recompute pointers of the form base + index + delta
when the jump bounds the index register.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index d980e2c608050..970211dfe38c1 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -19774,6 +19774,39 @@ static struct bpf_reg_state *scev_reg_for_fill(s=
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
> + * It is replaced only if the new range is a subset of the old one.
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
> +	if (!bpf_reg_union_compatible(dst_reg, &sum) || !cnum64_is_subset(dst_r=
eg->r64, sum.r64))
> +		return false;
> +	*dst_reg =3D sum;
> +	return true;
> +}
> +
>  /*
>   * The jump at @idx refined @regno. A register that scalar evolution lin=
ks to it holds
>   * @regno + delta on every path to the jump: intersect the two. The inte=
rsection is empty: no
> @@ -19783,22 +19816,29 @@ static void refine_linked_regs(struct bpf_verif=
ier_env *env, struct bpf_verifier
>  			       int idx, u32 regno)
>  {
>  	struct bpf_func_state *frame =3D vstate->frame[vstate->curframe];
> -	struct bpf_reg_state *reg, implied, saved;
> +	struct bpf_reg_state *reg, *base_reg, implied, saved;
>  	u32 pos, linked_regno, fill_off, bits;
> +	int base_regno;
>  	s64 delta;
> =20
>  	if (frame->regs[regno].type !=3D SCALAR_VALUE)
>  		return;
>  	for (pos =3D 0;
> -	     bpf_scev_next_linked_reg(env, idx, regno, &pos, &linked_regno, &fi=
ll_off, &delta,
> -				      &bits);
> +	     bpf_scev_next_linked_reg(env, idx, regno, &pos, &linked_regno, &fi=
ll_off, &base_regno,
> +				      &delta, &bits);
>  	     pos++) {
>  		reg =3D scev_reg_for_fill(frame, linked_regno, fill_off, bits);
> -		if (!reg || reg->type !=3D SCALAR_VALUE)
> +		if (!reg || (base_regno < 0 && reg->type !=3D SCALAR_VALUE))
>  			continue;
> =20
>  		implied =3D frame->regs[regno];
>  		add_scalar_to_reg(&implied, delta);
> +		if (base_regno >=3D 0) {
> +			base_reg =3D scev_reg_for_fill(frame, base_regno, 0, 64);
> +			if (base_reg && bits =3D=3D 64 && recompute_ptr(env, reg, base_reg, &=
implied))
> +				goto scratch;
> +			continue;
> +		}
>  		if (regs_fit_in_bits(reg, &implied, bits))
>  			bits =3D 64;
>  		if (bits < 32)
> @@ -19811,6 +19851,7 @@ static void refine_linked_regs(struct bpf_verifie=
r_env *env, struct bpf_verifier
>  			*reg =3D saved;
>  			continue;
>  		}
> +scratch:
>  		if (linked_regno < MAX_BPF_REG)
>  			mark_reg_scratched(env, linked_regno);
>  		else

[Severity: Medium]
Can recompute_ptr() overwrite dst_reg with an empty or inconsistent range?

Unlike the scalar path in refine_linked_regs(), the base_regno >=3D 0 path
jumps to scratch without checking reg_is_empty(),
const_tnum_range_mismatch() or const_tnum_range_mismatch_32() on the new
state.  In recompute_ptr(), cnum64_is_subset(dst_reg->r64, sum.r64) does
not reject an empty range because cnum64_is_subset() returns true when the
smaller range is CNUM64_EMPTY:

kernel/bpf/cnum_defs.h:cnum64_is_subset() {
	if (FN(is_empty(smaller)))
		return true;
    ...
}

If the tested scalar register has a signed range crossing 0, known bits in
var_off, and a linear step > 1, adding delta in add_scalar_to_reg(&implied,
delta) or adding ptr_reg's offset in recompute_ptr() can shift the range so
that it no longer crosses 0, allowing __reg_bound_offset() and
__update_bounds_from_step() inside reg_bounds_sync() to narrow r64 to
CNUM64_EMPTY.  recompute_ptr() then writes that empty range into *dst_reg,
and any later ALU or jump instruction on dst_reg triggers verifier_bug() in
reg_bounds_sanity_check().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261109064715.2382=
452-1-alexei.starovoitov@gmail.com?part=3D15
