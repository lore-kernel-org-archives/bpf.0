Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ED6329B799
	for <bpf@vger.kernel.org>; Fri,  6 Mar 2026 00:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772756329; cv=none; b=VO4B4Fif14+vkblzGOrjuF7K3MV53gp5ClsmbB06FmybOXm4/Mi43r27fPnjp08SSkxE3Btd2LzA6bEhVakHNCs8Y5SH3NYG1G3fPZ1RKSFjXX22idCedy+T0aqJDf15RJuOfdff2vX8+HbG/WR8WVxeDM5JAEHztXhozAcpDcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772756329; c=relaxed/simple;
	bh=OP4xdoUwZTyDHMl1F7uKWo3g9OvRqEut7op43FhbzRY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=g4+ejXhbGolvLvYkjq/IKpstmz4O6qEZDptEF3sRXKRGB9IIukJDR8WIIt6WvZBUS5x/JqEmMtG8SpPdj/YCkhtAixlknqHrCNHNDhDg6Ovcv+Ct+0twPyE4Vy8IhGBKnRGEdwnNw2ywheZtsKMx5oncCi8ptfqfkSC7m2m3eJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jj1RHGkT; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jj1RHGkT"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-899f79df682so56985496d6.2
        for <bpf@vger.kernel.org>; Thu, 05 Mar 2026 16:18:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772756327; x=1773361127; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=TFm8UaHEcrMdpDVoVcpn4/FOzazs2hinzuuANeaHhfA=;
        b=jj1RHGkTptjadfEAZ/8NNLwP3C55XNGEwlxTF42t5sgLYyNRJtZs7jQFeA29eGmDro
         LKfB2Su7mS4mmL4R18QM9YteyUGvmAY+UJ0pbkmIHCV9A1yqC47vFkpPHBNQvZNHaq/C
         UXjhLVhdxbjdlv0My0EO5Xw2sFGl/LBru/nxrDu44iEAZKENidLiznjZHVLDEhuG3hYV
         ZbYUbE+yMtIRelmrENJw+yZnmUvi4IB5H+MJrZQ72g2bhJiZk18cSumRPF+IQBnsR9mm
         kET+fV9vDhxjXV4SeJ8Vw+WINhW2ciVhIgeAuoraR3ixkh/3Z3Who7M5A+52aW9XWny/
         6y7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772756327; x=1773361127;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TFm8UaHEcrMdpDVoVcpn4/FOzazs2hinzuuANeaHhfA=;
        b=u971atSiHvJfsZW08ErQlxhKRwuuJB+I90VEmiqK2S7BqpPsAt+79sc3imSLRFuROQ
         LqdhgkGela1DXjUHP7Vnp8XgnOLQXcGYbEYktake73qWrNlUyLV6JLFKfmd3QrR0Aiyl
         9gqcCuI81bViqmoHQMyJo5cxaeXabKPc4ooAHmqBlM4PtQ79L22PMbbvdW8pYvztO1Rq
         /zBScMxG7EAyOVdYJaK3XIhpvqcVQ2gRqERg0LVLsVIFQu4LX5RFgLkRhTYAFI9pjZlw
         NohhUzB4HRoO2T9o9VXcIJpXE+Ve8BZ9cSxP4M8SUnAUEt80LBoekDnLINYvRy7tGbrH
         DJdA==
X-Gm-Message-State: AOJu0YwyKRbGO1+O3+6lyQh8k1WOARhCdNChp3Gg89ppqiSIG2vlJvGE
	KXV5V+ImztRMNXjO8lwcElHz9Olio+lFDqkJoaHIX2jeZfTvbz991Ou7
X-Gm-Gg: ATEYQzzIZ7el8WX7g+t1AOLGROgOCE3CCbfTerjYtiP6Az/az/st1FYhgNNXP7IjW01
	0LVqWS1CcwxGoUbg/1JZHHOIlTRkoi6TOAyKpWYMIJIFL/2j7b/qbl6qvlKFIaz7tHg0Yn+R5oV
	gBOraej4rwEIhaksmYHClxyuWArCpslr6b/8Ajiiscq5QlLke50rGxEIWfEtQo3tWpHYzvcTENt
	F0r7wFhAsLa6Rk0933s8PMQhveTzpooFHFTDGQGAIM+khKKTAggLiFiSdBiIjwYk8UcpUjdv/l8
	TtQ9wV80vwBtctDrKAuhtzzt15i0zV9XmKgfsRRh2pWxPUjUUkstPct5Kp9hhfplMRnR+haupFP
	LGpqjDFig1I+wqjYfpyOB+j5+ttuqijeVzeRvDN7lzyaJu80Evol2JcMhMpHo2irnFPHQLPEcul
	M3GnkzwhD6+jN+KIyAOUYl1LfFMXMUpErfa4McxGkyROCQd4IGyeeX
X-Received: by 2002:a05:6214:411a:b0:89a:954:c1c with SMTP id 6a1803df08f44-89a30a669c6mr2143576d6.22.1772756326964;
        Thu, 05 Mar 2026 16:18:46 -0800 (PST)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89a0e31b035sm68751516d6.17.2026.03.05.16.18.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 16:18:46 -0800 (PST)
Message-ID: <fd6a7d7fc0eee70b0b3053b1db34e9e986b2a067.camel@gmail.com>
Subject: Re: [PATCH bpf v2 1/2] bpf: refine u32/s32 bounds when ranges cross
 min/max boundary
From: Eduard Zingerman <eddyz87@gmail.com>
To: Paul Chaignon <paul.chaignon@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, 	martin.lau@linux.dev, kernel-team@fb.com,
 yonghong.song@linux.dev, 	emil@etsalapatis.com, arighi@nvidia.com,
 shung-hsi.yu@suse.com
Date: Thu, 05 Mar 2026 16:18:42 -0800
In-Reply-To: <aaocJ3gJr7019urU@Tunnel>
References: <20260305-bpf-32-bit-range-overflow-v2-0-7169206a3041@gmail.com>
	 <20260305-bpf-32-bit-range-overflow-v2-1-7169206a3041@gmail.com>
	 <aaocJ3gJr7019urU@Tunnel>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-03-06 at 01:13 +0100, Paul Chaignon wrote:
> On Thu, Mar 05, 2026 at 11:48:22AM -0800, Eduard Zingerman wrote:
>=20
> [...]
>=20
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 401d6c4960eccfa90893660b7d8aece859787f7f..f960b382fdb3d4a4f5f2a66=
a525c2f594de529ff 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -2511,6 +2511,30 @@ static void __reg32_deduce_bounds(struct bpf_reg=
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
>=20
> Looks good to me. I also ran it through Agni and __reg_deduce_bounds
> (aka special instruction BPF_SYNC2) is still found to be sound.

Great, thank you!

>=20
> >  	}
> >  }
> > =20
> > diff --git a/tools/testing/selftests/bpf/prog_tests/reg_bounds.c b/tool=
s/testing/selftests/bpf/prog_tests/reg_bounds.c
> > index 0322f817d07be5d003c17dd7cedfa3aa4197678e..04938d0d431b38e086b50fe=
28b99e4ad2682742e 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/reg_bounds.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/reg_bounds.c
> > @@ -422,15 +422,69 @@ static bool is_valid_range(enum num_t t, struct r=
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
> > +/*
> > + * Result is precise when 'x' and 'y' overlap or form a continuous ran=
ge,
> > + * result is an over-approximation if 'x' and 'y' do not overlap.
> > + */
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
>=20
> Don't we usually put changes to this file in a separate commit, as for
> test changes in general?

W/o this change the reg_bounds.c tests would fail.
So far we tried to keep selftests passing for every commit,
to help with any potential bisecting.

>=20
> Also I believe with these changes, we can now revert commit da653de268d3
> ("selftests/bpf: Update reg_bound range refinement logic").

Makes sense, thank you for pointing this out.

> > +
> >  	y_cast =3D range_cast(y_t, x_t, y);
> > =20
> >  	/* If we know that
> > @@ -444,7 +498,7 @@ static struct range range_refine(enum num_t x_t, st=
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
> > @@ -462,7 +516,7 @@ static struct range range_refine(enum num_t x_t, st=
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
> > @@ -480,7 +534,7 @@ static struct range range_refine(enum num_t x_t, st=
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
> >=20
> > --=20
> > 2.53.0
> >=20
