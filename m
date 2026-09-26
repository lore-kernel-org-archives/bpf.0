Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC28C331EA5
	for <bpf@vger.kernel.org>; Sat, 26 Sep 2026 14:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790433360; cv=none; b=FHZ/taHcjtFi4SUk5XuxJgGIk4Fe472UmiY0w74/8YirqeXs8yeLkfWd/P71RCrh6K6DTKPWCQrIx57Lb/a/yeY5ry4HdeTCsarb4/8dU4NKNjCTX3EKo9pEDwxVRSBQ0YIjERZ/tcD+fC0SPvoQ4KQkzHyhXDoeHvrWjk4hvN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790433360; c=relaxed/simple;
	bh=AIwYe8YFKjM3JRWRHDr159C+andUv0rAtnEesHwmyK8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=QQo82HrWVt6Y/WofAWTbaSPp7ILFUjfeLnoqcFjlw/JgAMSjw1Fi001Ow1tjI3JuTgmJmynGTbXYY4pzlAit8/aN0HreiU140V7SmxyKAyhsch9hFgc3n8Cf8ZbSM4OnRQ/Tc11VaIEXbfHDKbgcboNuUjk+LywoRLm9fu7cdfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=grH0wiJj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="grH0wiJj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F5611F000FF;
	Sat, 26 Sep 2026 14:35:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790433359;
	bh=EZFJELXQXrqTFTZyKECnPKLvNFQYGILdqNpeBA7RhyM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=grH0wiJjspsDSM1NSS1HwLRVm1y0fCVEI8glB2C9fC+mjdFD9s9qGI2BYA/EKu7UT
	 Zl+exR82navqz8uFwEflv+o+NgvrHIVPqqXKBRkDDxvUWW4n6F3tGd/eFlogHHpWZP
	 TE31C89Wba5TtrDa0EsK2f4hI1DMBk/IMDa46iwL6lX6RTa6JrpT/hdyKWLYXyHl37
	 fiKzGljUrcMKhf5aRsbCSiFd4aWNFkFifjyQ9ldFlbgLWR9ch86VUrT86V6qDwDmZL
	 F+PTBWY5jPQ6netC70k5hBvoR1IwdAtHigLyTyEQOCkS+ldHEkB5ML3sN9EaXXnLmK
	 9qhP3ueEW/YhA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 14/36] bpf: representation for intervals with
 steps
Reply-To: sashiko-reviews@lists.linux.dev
To: "Eduard Zingerman" <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260926-scev-minimal-rebase-v1-14-c8e5ab5ba79f@gmail.com>
References: <20260926-scev-minimal-rebase-v1-0-c8e5ab5ba79f@gmail.com>
 <20260926-scev-minimal-rebase-v1-14-c8e5ab5ba79f@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 26 Sep 2026 14:35:58 +0000
Message-Id: <20260926143559.2F5611F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] bpf: verifier linear equation tracking ignores integer wrap-ar=
ound leading to OOB access
--

commit e753188b2ce55741938a6a63ee79699c312fb712
Author: Eduard Zingerman <eddyz87@gmail.com>

bpf: representation for intervals with steps

Extend scalar register tracking with a linear base + step * k description
to allow the verifier to reason about strided values, updating scalar
ALU operations to maintain these constraints.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 79aa924861548..89b1a0aa3a25b 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> @@ -2165,10 +2173,16 @@ static void deduce_bounds_64_from_32(struct bpf_r=
eg_state *reg)
>  	reg->r64 =3D cnum64_cnum32_intersect(reg->r64, reg->r32);
>  }
> =20
> +static void deduce_bounds_64_from_step(struct bpf_reg_state *reg)
> +{
> +	reg->r64 =3D cnum64_intersect_linear(reg->r64, reg->base, reg->step);
> +}

[Severity: Critical]
If the base and step variables become desynchronized from the true runtime
value during ALU operations, could this intersection incorrectly shrink the
register bounds?

If the linear representation is mathematically flawed due to integer
wrap-around, the verifier might deduce bounds that exclude the actual runti=
me
value.

Is it possible this leads to out-of-bounds accesses bypassing checks?

[ ... ]

> @@ -15589,6 +15615,50 @@ static int sanitize_check_bounds(struct bpf_veri=
fier_env *env,
>  	return 0;
>  }
> =20
> +static void scalar_step_add(struct bpf_reg_state *dst_reg,
> +			    const struct bpf_reg_state *a,
> +			    const struct bpf_reg_state *b)
> +{
> +	u16 base, step;
> +
> +	/* If either 'a' or 'b' is a constant, update the base/step for the cou=
nterpart. */
> +	if (tnum_is_const(b->var_off)) {
> +		step =3D a->step;
> +		base =3D imod((s64)a->base + (s64)b->var_off.value, step);
> +	} else if (tnum_is_const(a->var_off)) {
> +		step =3D b->step;
> +		base =3D imod((s64)b->base + (s64)a->var_off.value, step);

[Severity: Critical]
Does this computation account for 32-bit or 64-bit integer wrap-around?

If a register is initialized with a non-power-of-2 stride (for example, bas=
e=3D0
and step=3D3), and then undergoes an addition that wraps around 32 bits, the
true remainder modulo 3 changes because 2^32 is not divisible by 3.

Since this computes imod() on the 64-bit sum, the tracking might blindly
ignore boundary wrap-around, leading to an inaccurate linear representation.

Furthermore, in adjust_scalar_min_max_vals(), when alu32 is true, the funct=
ion
calls zext_32_to_64() which zero-extends the 32-bit result without
invalidating the 64-bit base and step tracking.

Could this allow a crafted BPF program to bypass bounds checks?

> +	} else {
> +		step =3D 1;
> +		base =3D 0;
> +	}
> +	dst_reg->base =3D base;
> +	dst_reg->step =3D step;
> +}
> +
> +static void scalar_step_mul(struct bpf_reg_state *dst_reg, struct bpf_re=
g_state *src_reg)
> +{
> +	u64 amount =3D src_reg->var_off.value;
> +
> +	if (tnum_is_const(src_reg->var_off) && (s64)amount >=3D 0 &&
> +	    !check_mul_overflow(dst_reg->step, amount, &dst_reg->step) &&

[Severity: Critical]
This code checks if the step value overflows a u16, but it does not appear =
to
verify if the register actual value multiplication wraps around 64 bits or
32 bits.

If the underlying integer multiplication wraps, the linear equation might
no longer accurately reflect the actual value of the register.

Could this also lead to an incorrect linear equation being propagated?

> +	    dst_reg->step !=3D 0)
> +		dst_reg->base =3D (dst_reg->base * amount) % dst_reg->step;
> +	else
> +		reg_step_reset(dst_reg);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260926-scev-minim=
al-rebase-v1-0-c8e5ab5ba79f@gmail.com?part=3D14
