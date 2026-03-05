Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 981CB346FC6
	for <bpf@vger.kernel.org>; Thu,  5 Mar 2026 18:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772733917; cv=none; b=jFERJb0LlMgl3CaKTQC6UiveOZw18hTEBnAi+kIKdW+aQj8ErVfkRRIvZnhbRJDjBFbSXhkEOvEYlee7RbhwQgr/kDWRJN253Gf9fPDYwyFxg+UWawNBJBwlShT8HQICEdRAIiEFWxvD9TwPivhhz8OL6qMtSZRwLTv2qv15dnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772733917; c=relaxed/simple;
	bh=NgI1m9lE6K+AIwJv+zitzN9U9CIioeM0KHPXN22Ymx4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SnmehGsjYqBj+21wWrw6ptT3MWRU0GI3NdJAHSLoNs3FXnziVtLTslQ+0gy+6UqF2YJsQ0Nzrb1f4BSrcJkt5xKv31lkbl2pvn7NVOtRx0SrrUPUn/qtlOE29r9yfvUEoI/qkH+jwqBMKN3eDn5LgWwXQrLgqH9Zouu+Pv6mV1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W7NWQ3Ri; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W7NWQ3Ri"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-8cbae8f69cbso848949185a.0
        for <bpf@vger.kernel.org>; Thu, 05 Mar 2026 10:05:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772733914; x=1773338714; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=V/QEIS2oMk3ji6SF/zVpi3eX2UCGOsvnls3/v635rIs=;
        b=W7NWQ3RiDmzGFXrVCiqoW6IqTcXodVYtmhzTb3HtSxVkcGgGGIk2KZzMO5qpZDPmfR
         u27Yj994p8vZNFf8xzXZ0DJA3wR3RsErY5NvPutz0Scsco+tAOKo6AQBZzHRqV4Lx4Pw
         gTlhsNQhfqj6sTjMtWqd429twR1HHoSGk0564aOo/kfjEw/krG6p3HqzVUOyenXR0PU4
         TX9pC1kKelaoZ6C1mHrOuW0o7VbndQuk6Dcfd3dW9OFP5PatCrkpch9NeIA2d896hkvC
         Yy/pasfL/WV0t0vRpV9CpCo6aRK6OG6ym6lOwPc1mPJZwx8QseFNLY9SGa+nDKFykbla
         e+3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772733914; x=1773338714;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V/QEIS2oMk3ji6SF/zVpi3eX2UCGOsvnls3/v635rIs=;
        b=PSolRVwziFpO8BuwuKmgXmpIl1p/A9PLoHJKIbaPxGggXqAldApEJLXJ1OtLFcILvI
         0vDbirCduZXIh3uQafvEJpOrMUFqSgAjOZdK7Ikru5L05qjglxkEH1Wlen19jSgU2En3
         A9IoKZg35aQ1IW4DmeibStU9YNduCBTsafCLcN1W4W6SLXb9hYkcNdzOYUdDHAP0gC1A
         nsuE0vDt5U42FHuPrWyk+Rs7jiDRYOM3nnlZG09pZzj0aeXQ8TN6kLp2LNtwInpQWzM/
         1OU+yxd5s2MCiUApkbMOavB5ww2etPCFnvpTR3TPDgCz2FxfhKJhpHJNz7Chda9yeWVk
         3pSw==
X-Forwarded-Encrypted: i=1; AJvYcCVDpVcX7FGT4p1La+3tmEav9CDTX6uJp0XSvtOatJxBXgW9uKGefIHVE7Sb/zjXqRJbSPo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwH8X+gQtYE5ZQpceTSHjnAe7D3xEPmYyEYu3NtCpEi4BvgHTJm
	SSsOB2J+4ZG0wbFHj6J9S8oQpMRIWbbN99341a3KM4OfSQmeOqyF7z7a
X-Gm-Gg: ATEYQzyAP7lVM+6dmycyh4SrQb0VsBxkHPS/6y4IsvZnDrN63mP5ZYtVhWa38Ni7uJj
	Iqyw74os1N4s08sFAs2nBpezyo1ROLYw10aMRy8t+uJIqEqziDKz6XyswyyXQTa1Guxt20rbnX2
	69l2onIX9Ef3PqiYX/Yeeo9R0mqxsHPLIfUsZGGhK0rxyoN9WRR4NbdJrbp9mGXOi2ZUV+Hjq0D
	dusON/IAzVOq+ss9eRt5iESOGUBldIdrqdtHIdEf3zM3OIPlJWpa/Xi1P7Yl+a3QjOQbCvAxs5L
	CLzBBsCFv0FVZybQrEAYHNkZq3qrNq9heAhhObTlzxtfeEB5Z6r/x2QlM/R48z5JUyV/g1JJ1FW
	YPJH36SZ/fgsx5fpheJTjcBemp8vHmjBlfBvL6gS0hoYd97Q7gZpCGeneZGKWb/2b+yaTgLaU7V
	NFm4atQow2QC5qN0SmsgE8AVrP1e2IacnwK8VeIgIMV86kQ0g7V+FE
X-Received: by 2002:a05:620a:4408:b0:8b2:e3c1:24b7 with SMTP id af79cd13be357-8cd634e8fe6mr383710885a.29.1772733914190;
        Thu, 05 Mar 2026 10:05:14 -0800 (PST)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cbbf73451csm1956637385a.47.2026.03.05.10.05.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 10:05:13 -0800 (PST)
Message-ID: <9a23fbacdc6d33ec8fcb3f6988395b5129f75369.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1 1/2] bpf: refine u32/s32 bounds when ranges
 cross min/max boundary
From: Eduard Zingerman <eddyz87@gmail.com>
To: Emil Tsalapatis <emil@etsalapatis.com>, bpf@vger.kernel.org,
 ast@kernel.org
Cc: andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev, 
	kernel-team@fb.com, yonghong.song@linux.dev, arighi@nvidia.com, 
	shung-hsi.yu@suse.com
Date: Thu, 05 Mar 2026 10:05:09 -0800
In-Reply-To: <DGV04J3T69LG.352QG90C5TZZD@etsalapatis.com>
References: <20260305110929.738140-1-eddyz87@gmail.com>
	 <DGV04J3T69LG.352QG90C5TZZD@etsalapatis.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2026-03-05 at 11:49 -0500, Emil Tsalapatis wrote:
> On Thu Mar 5, 2026 at 6:09 AM EST, Eduard Zingerman wrote:
> > Same as in __reg64_deduce_bounds(), refine s32/u32 ranges
> > in __reg32_deduce_bounds() in the following situations:
> Nit: Can we add a cover letter since this is a 2-patch series?
>=20
> Also, can we explicitly state the condition: IIUC it's: "When
> the signed and unsigned ranges of a register partially overlap
> on an entirely (signed) positive of (signed) negative interval".
> This helps with the ASCII and also covers the question "what happens
> when the ranges overlap in two places" - nothing, we don't refine
> the register's bounds in that case, as noted in __reg64_deduce_bounds.

Sure, I'll extend the description.

> >=20
> > 0                                                   U32_MAX
> > >  [xxxxxxxxxxxxxx u32 range xxxxxxxxxxxxxx]              |
> > > ----------------------------|----------------------------|
> > > xxxxx s32 range xxxxxxxxx]                       [xxxxxxx|
> > 0                     S32_MAX S32_MIN                    -1
> >=20
> > 0                                                   U32_MAX
> > >              [xxxxxxxxxxxxxx u32 range xxxxxxxxxxxxxx]  |
> > > ----------------------------|----------------------------|
> > > xxxxxxxxx]                       [xxxxxxxxxxxx s32 range |
> > 0                     S32_MAX S32_MIN                    -1
> >=20
> > This helps for e.g. consider the following program:
> >=20
> >    call %[bpf_get_prandom_u32];
> >    w0 &=3D 0xffffffff;
> >    if w0 < 0x3 goto 1f;    // on fall-through u32 range [3..U32_MAX]
> >    if w0 s> 0x1 goto 1f;   // on fall-through s32 range [S32_MIN..1]
> >    if w0 s< 0x0 goto 1f;   // range can be narrowed to  [S32_MIN..-1]
> >    r10 =3D 0;
> > 1: ...;
> >=20
> > The reg_bounds.c selftest is updated to incorporate identical logic,
> > refinement based on non-overflowing range halves:
> >=20
> >   ((x =E2=88=A9 [0, smax]) =E2=88=A9 (y =E2=88=A9 [0, smax])) =E2=88=AA
> >   ((x =E2=88=A9 [smin,-1]) =E2=88=A9 (y =E2=88=A9 [smin,-1]))
> >=20
>=20
> > Reported-by: Andrea Righi <arighi@nvidia.com>
> > Reported-by: Emil Tsalapatis <emil@etsalapatis.com>
> > Closes: https://lore.kernel.org/bpf/aakqucg4vcujVwif@gpd4/T/
> > Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> > ---
> >  kernel/bpf/verifier.c                         | 24 ++++++++
> >  .../selftests/bpf/prog_tests/reg_bounds.c     | 58 +++++++++++++++++--
> >  2 files changed, 78 insertions(+), 4 deletions(-)
> >=20
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index d92cf2821657..2b79a2a4d1b5 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -2532,6 +2532,30 @@ static void __reg32_deduce_bounds(struct bpf_reg=
_state *reg)
> >  	if ((u32)reg->s32_min_value <=3D (u32)reg->s32_max_value) {
> >  		reg->u32_min_value =3D max_t(u32, reg->s32_min_value, reg->u32_min_v=
alue);
> >  		reg->u32_max_value =3D min_t(u32, reg->s32_max_value, reg->u32_max_v=
alue);
> > +	} else {
> > +		if (reg->u32_max_value < (u32)reg->s32_min_value) {
> > +			/* See __reg64_deduce_bounds() for detailed explanation.
> > +			 * Refine ranges in the following situation:
> > +			 *
> > +			 * 0                                                   U32_MAX
> > +			 * |  [xxxxxxxxxxxxxx u32 range xxxxxxxxxxxxxx]              |
> > +			 * |----------------------------|----------------------------|
> > +			 * |xxxxx s32 range xxxxxxxxx]                       [xxxxxxx|
> > +			 * 0                     S32_MAX S32_MIN                    -1
> > +			 */
> > +			reg->s32_min_value =3D (s32)reg->u32_min_value;
> > +			reg->u32_max_value =3D min_t(u32, reg->u32_max_value, reg->s32_max_=
value);
> > +		} else if ((u32)reg->s32_max_value < reg->u32_min_value) {
> > +			/*
> > +			 * 0                                                   U32_MAX
> > +			 * |              [xxxxxxxxxxxxxx u32 range xxxxxxxxxxxxxx]  |
> > +			 * |----------------------------|----------------------------|
> > +			 * |xxxxxxxxx]                       [xxxxxxxxxxxx s32 range |
> > +			 * 0                     S32_MAX S32_MIN                    -1
> > +			 */
> > +			reg->s32_max_value =3D (s32)reg->u32_max_value;
> > +			reg->u32_min_value =3D max_t(u32, reg->u32_min_value, reg->s32_min_=
value);
> > +		}
> >  	}
> >  }
> > =20
> > diff --git a/tools/testing/selftests/bpf/prog_tests/reg_bounds.c b/tool=
s/testing/selftests/bpf/prog_tests/reg_bounds.c
> > index 0322f817d07b..446e5ef62f44 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/reg_bounds.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/reg_bounds.c
> > @@ -422,15 +422,65 @@ static bool is_valid_range(enum num_t t, struct r=
ange x)
> >  	}
> >  }
> > =20
> > -static struct range range_improve(enum num_t t, struct range old, stru=
ct range new)
> > +static struct range range_intersection(enum num_t t, struct range old,=
 struct range new)
> >  {
> >  	return range(t, max_t(t, old.a, new.a), min_t(t, old.b, new.b));
> >  }
> > =20
> > +static struct range range_union(enum num_t t, struct range x, struct r=
ange y)
> > +{
> > +	if (!is_valid_range(t, x))
> > +		return y;
> > +	if (!is_valid_range(t, y))
> > +		return x;
> > +	return range(t, min_t(t, x.a, y.a), max_t(t, x.b, y.b));
> > +}
> > +
>=20
> AFAICT this is only fully accurate if the ranges are intersect/are consec=
utive.
> Is it that it's fine to include extra values into the interval since
> we're dealing with bounds checking, and so can relax the bounds as we
> please? If so, then this is fine.=20

Yes, this over-approximates when on range can't represent the union
and that is fine for the context. I'll add a comment to clarify this,
can't figure a better name.

> If not, can we either change the name to make it clear we assume the call=
er has=20
> ensured this, or add a check in the function itself?=20
>=20
> > +/*
> > + * This function attempts to improve x range intersecting it with y.
> > + * range_cast(... to_t ...) looses precision for ranges that pass to_t
> > + * min/max boundaries. To avoid such precision loses this function
> > + * splits both x and y into halves corresponding to non-overflowing
> > + * sub-ranges: [0, smin] and [smax, -1].
> > + * Final result is computed as follows:
> > + *
> > + *   ((x =E2=88=A9 [0, smax]) =E2=88=A9 (y =E2=88=A9 [0, smax])) =E2=
=88=AA
> > + *   ((x =E2=88=A9 [smin,-1]) =E2=88=A9 (y =E2=88=A9 [smin,-1]))
> > + *
> > + * Precision might still be lost if final union is not a continuous ra=
nge.
> > + */
> > +static struct range range_refine_in_halves(enum num_t x_t, struct rang=
e x,
> > +					   enum num_t y_t, struct range y)
> > +{
> > +	struct range x_pos, x_neg, y_pos, y_neg, r_pos, r_neg;
> > +	u64 smax, smin, neg_one;
> > +
> > +	if (t_is_32(x_t)) {
> > +		smax =3D (u64)(u32)S32_MAX;
> > +		smin =3D (u64)(u32)S32_MIN;
> > +		neg_one =3D (u64)(u32)(s32)(-1);
> > +	} else {
> > +		smax =3D (u64)S64_MAX;
> > +		smin =3D (u64)S64_MIN;
> > +		neg_one =3D U64_MAX;
> > +	}
> > +	x_pos =3D range_intersection(x_t, x, range(x_t, 0, smax));
> > +	x_neg =3D range_intersection(x_t, x, range(x_t, smin, neg_one));
> > +	y_pos =3D range_intersection(y_t, y, range(x_t, 0, smax));
> > +	y_neg =3D range_intersection(y_t, y, range(y_t, smin, neg_one));
> > +	r_pos =3D range_intersection(x_t, x_pos, range_cast(y_t, x_t, y_pos))=
;
> > +	r_neg =3D range_intersection(x_t, x_neg, range_cast(y_t, x_t, y_neg))=
;
> > +	return range_union(x_t, r_pos, r_neg);
> > +
> > +}
> > +
> >  static struct range range_refine(enum num_t x_t, struct range x, enum =
num_t y_t, struct range y)
> >  {
> >  	struct range y_cast;
> > =20
> > +	if (t_is_32(x_t) =3D=3D t_is_32(y_t))
> > +		x =3D range_refine_in_halves(x_t, x, y_t, y);
> > +
> >  	y_cast =3D range_cast(y_t, x_t, y);
> > =20
> >  	/* If we know that
> > @@ -444,7 +494,7 @@ static struct range range_refine(enum num_t x_t, st=
ruct range x, enum num_t y_t,
> >  	 */
> >  	if (x_t =3D=3D S64 && y_t =3D=3D S32 && y_cast.a <=3D S32_MAX  && y_c=
ast.b <=3D S32_MAX &&
> >  	    (s64)x.a >=3D S32_MIN && (s64)x.b <=3D S32_MAX)
> > -		return range_improve(x_t, x, y_cast);
> > +		return range_intersection(x_t, x, y_cast);
> > =20
> >  	/* the case when new range knowledge, *y*, is a 32-bit subregister
> >  	 * range, while previous range knowledge, *x*, is a full register
> > @@ -462,7 +512,7 @@ static struct range range_refine(enum num_t x_t, st=
ruct range x, enum num_t y_t,
> >  		x_swap =3D range(x_t, swap_low32(x.a, y_cast.a), swap_low32(x.b, y_c=
ast.b));
> >  		if (!is_valid_range(x_t, x_swap))
> >  			return x;
> > -		return range_improve(x_t, x, x_swap);
> > +		return range_intersection(x_t, x, x_swap);
> >  	}
> > =20
> >  	if (!t_is_32(x_t) && !t_is_32(y_t) && x_t !=3D y_t) {
> > @@ -480,7 +530,7 @@ static struct range range_refine(enum num_t x_t, st=
ruct range x, enum num_t y_t,
> >  	}
> > =20
> >  	/* otherwise, plain range cast and intersection works */
> > -	return range_improve(x_t, x, y_cast);
> > +	return range_intersection(x_t, x, y_cast);
> >  }
> > =20
> >  /* =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
