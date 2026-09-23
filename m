Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B8613EEAD0
	for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 23:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790206639; cv=none; b=pY+pVCBAGX73yMWNfP5NkZVGr7tV/C2tVm1/FeosM50tbkXHEafF7WFeW96JBb1lIRnMY+Z2qr2gZxDWfc/kIa7xipybxljxh3e9eEzJEfr/Zv1ELcVcWzHXTLkN/fOawjBVN8IVbcSq8bu2Lb9BBMSWdfXHHwtFglcyezbFEbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790206639; c=relaxed/simple;
	bh=v31fx5u7rg3YQNNX+KsP8wSA9Ok3OUk0nStcgXK8v28=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=F3i4h6GaBkY/9ci1xyeYvI18j25EdDu5L9SApMg7fimoSL62INhBLXHwBJs/cMEAg4ROKCngrKDGXTRvQTcmGm5x5cjhAnYQdZQntvKXs+D7Blfkfc1BFUPLUTSPvpdOeZRLznoq7A5ZKGyADLFi5q9i3JOrndbLGZ2T4+HUoTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m+lhxGkM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m+lhxGkM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE46E1F00893;
	Wed, 23 Sep 2026 23:37:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790206638;
	bh=RIggrcrnEd/T2XI++d2UFr31ReOuxsCL0rdJgME5GpM=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=m+lhxGkMGDpg1s/8tarYhFmgKMAXqrnbNgdbsBhOuy69qbVirfmvM+S7J37oMPHD0
	 l1qtpOgWUl69AVu6FmDE+Ii4dijrme4DbKko47OA7gGe+2qSBw52vC2w9uOd14aN7p
	 rxGBvw+BJuE/jS1YXzFZQymsjjYdct4mmDtRi/X5NWZamQdgJxs8WFyufMPRatSqDW
	 /BjW7/Y/kwRjbGo+q2GPtOPKJ2yCnlNddea5CG+A2T9s1XeAEbmCimNBQmNhV8OfO2
	 xs2GFFSXaOsQfUL4ngoJsePuoo5P/D+gzG6WB/s0p/jCOeujfQv0kwrum/Aa72gGCc
	 y8xhFcErdut6Q==
Content-Type: multipart/mixed; boundary="===============1753904630896182648=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <2d0b9cd0357628a3344d6aa7480b1d87eb272d4cbd8799113dd98c67cb3fd7ba@mail.kernel.org>
In-Reply-To: <20260923223554.562379-2-alexei.starovoitov@gmail.com>
References: <20260923223554.562379-2-alexei.starovoitov@gmail.com>
Subject: Re: [PATCH bpf-next 1/8] bpf: Trim range ends to var_off members
From: bot+bpf-ci@kernel.org
To: alexei.starovoitov@gmail.com,bpf@vger.kernel.org
Cc: daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Wed, 23 Sep 2026 23:37:16 +0000 (UTC)

--===============1753904630896182648==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index a7c9e2d8965d5..cb5d498ada698 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> @@ -2094,9 +2094,71 @@ static struct cnum64 cnum64_from_tnum(struct tnum tnum)
>  		return cnum64_from_urange(tnum.value, (tnum.value | tnum.mask));
>  }
>
> +/* smallest member of @t that is >= @x, wraps around to the smallest member of @t */
> +static u64 tnum_member_ge(struct tnum t, u64 x)
> +{
> +	if ((x & ~t.mask) == t.value)
> +		return x;
> +	if (x > (t.value | t.mask))
> +		return t.value;
> +	return tnum_step(t, x);
> +}
> +
> +/* largest member of @t that is <= @x, wraps around to the largest member of @t */
> +static u64 tnum_member_le(struct tnum t, u64 x)
> +{
> +	/* members of 'tc' are bitwise complements of members of 't' */
> +	struct tnum tc = { .value = ~(t.value | t.mask), .mask = t.mask };
> +
> +	return ~tnum_member_ge(tc, ~x);
> +}
> +
> +/*
> + * Move both ends of arc @c inwards to the nearest members of @t.
> + * Values that are dropped are not members of @t.
> + */
> +static struct cnum64 cnum64_tighten_by_tnum(struct cnum64 c, struct tnum t)
> +{
> +	u64 lo, hi, dlo, dhi;
> +
> +	if (cnum64_is_empty(c) || c.size == U64_MAX || !t.mask)
> +		return c;
> +	lo = tnum_member_ge(t, c.base);
> +	dlo = lo - c.base;
> +	if (dlo > c.size)
> +		return c;
> +	hi = tnum_member_le(t, c.base + c.size);
> +	dhi = c.base + c.size - hi;
> +	if (dhi > c.size - dlo)
> +		return c;
> +	return (struct cnum64){ .base = lo, .size = c.size - dlo - dhi };
> +}
> +
> +static struct cnum32 cnum32_tighten_by_tnum(struct cnum32 c, struct tnum t)
> +{
> +	struct tnum tc;
> +	u32 lo, hi, dlo, dhi;
> +
> +	t = tnum_subreg(t);
> +	if (cnum32_is_empty(c) || c.size == U32_MAX || !t.mask)
> +		return c;
> +	lo = tnum_member_ge(t, c.base);
> +	dlo = lo - c.base;
> +	if (dlo > c.size)
> +		return c;
> +	/* complement within 32 bits */
> +	tc = (struct tnum){ .value = (u32)~(t.value | t.mask), .mask = t.mask };
> +	hi = ~(u32)tnum_member_ge(tc, (u32)~(c.base + c.size));
> +	dhi = c.base + c.size - hi;
> +	if (dhi > c.size - dlo)
> +		return c;
> +	return (struct cnum32){ .base = lo, .size = c.size - dlo - dhi };
> +}
> +

[ ... ]

>  static void __update_reg64_bounds(struct bpf_reg_state *reg)
>  {
> +	u64 tnum_next;
> +	bool umin_in_tnum;
> +
>  	cnum64_intersect_with(&reg->r64, cnum64_from_tnum(reg->var_off));
> +	reg->r64 = cnum64_tighten_by_tnum(reg->r64, reg->var_off);
>
>  	/* Check if u64 and tnum overlap in a single value */
>  	tnum_next = tnum_step(reg->var_off, reg_umin(reg));
> +	umin_in_tnum = (reg_umin(reg) & ~reg->var_off.mask) == reg->var_off.value;
> +	tmax = reg->var_off.value | reg->var_off.mask;
> +	if (umin_in_tnum && tnum_next > reg_umax(reg)) {
> +		/* The u64 range and the tnum only overlap in umin.
> +		 * u64:  ---[xxxxxx]-----
> +		 * tnum: --xx----------x-
> +		 */
> +		___mark_reg_known(reg, reg_umin(reg));
> +	} else if (!umin_in_tnum && tnum_next == tmax) {
> +		/* The u64 range and the tnum only overlap in the maximum value
> +		 * represented by the tnum, called tmax.
> +		 * u64:  ---[xxxxxx]-----
> +		 * tnum: xx-----x--------
> +		 */
> +		___mark_reg_known(reg, tmax);
> +	} else if (!umin_in_tnum && tnum_next <= reg_umax(reg) &&
> +		   tnum_step(reg->var_off, tnum_next) > reg_umax(reg)) {
> +		/* The u64 range and the tnum only overlap in between umin
> +		 * (excluded) and umax.
> +		 * u64:  ---[xxxxxx]-----
> +		 * tnum: xx----x-------x-
> +		 */
> +		___mark_reg_known(reg, tnum_next);
> +	}
>  }

After the tighten call, can the second and third branches of this
"Check if u64 and tnum overlap" block still execute?

The tighten call moves the range base to tnum_member_ge(t, base).
For a non-wrapping arc, reg_umin() is now always a member, so
umin_in_tnum is always true.

For a wrapping or full arc, reg_umin() returns 0. The second branch
requires tnum_next == tmax and !umin_in_tnum, which would need a const
tnum, but the tighten path and the full-range path already handle that
case. The third branch would need tnum_step(var_off, tnum_next) >
reg_umax(reg) == U64_MAX, which cannot occur.

This makes the second branch unreachable for the case it was designed to
handle: when the only member left in the range is tmax. The tighten
logic converts [non-member umin .. tmax] into the singleton [tmax, tmax].
Then umin_in_tnum is true, but tnum_next = tnum_step(var_off, tmax)
returns tmax when the input is already at or beyond tmax, so the first
branch test `tnum_next > reg_umax(reg)` is false and the register is
not marked known.

For example, with var_off=(0x5; 0x200000000) and r64=[0xe, 0x20000000f],
the range becomes [0x200000005, 0x200000005] after tighten, but var_off
stays (0x5; 0x200000000) and is_reg_const() sees it as non-constant.

The first __update_reg_bounds() inside reg_bounds_sync() is followed by
__reg_bound_offset(), which fixes var_off. But the trailing
__update_reg_bounds() call is not followed by __reg_bound_offset(), so
the register can be left with a constant range and a non-constant tnum.

Does this logic need updating to replace the three-case block with a
single constant check on the trimmed range?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/35929952632
--===============1753904630896182648==--
