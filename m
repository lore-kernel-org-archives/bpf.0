Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F8F33CB2C5
	for <bpf@vger.kernel.org>; Thu,  5 Mar 2026 16:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772729404; cv=none; b=Tj9JElCK/v3RNyb3wwm5VZczh1nMCdoBVBIHCnUjNRglhc8pHXaxSkqLBwSir6EY0ehZIX8SlVY5/Yb0nNbTQ7mN+94ofc7+5/OsT5Fyb5x6+EzD2nUtOxQg046WumEgQyFq381DcJ5mfNBYIO7TBedbAX5nDSMTYwRNpqiGM04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772729404; c=relaxed/simple;
	bh=z5Sdgi6E2R83dmIB+dhOHqaAyJJZp1T35IOcLO+dWaY=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=J5FV0vbRQsyDVOtQfIR8PbutgaIK0M76DAbfEZh5HAI5aijH4+tBNAlbeWpe9skMph43VnwMd8RmXW3KgLvzoXA00LusrBcuDv89uQdK7pGHKlEC5vVnE6iiuTHLiPLqHkwyOB/ziJSl9TT7Q3aNC8SpjxwDapqR8WRGPHoB76g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=tGd/NqLR; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="tGd/NqLR"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-899d6b7b073so85051286d6.2
        for <bpf@vger.kernel.org>; Thu, 05 Mar 2026 08:50:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1772729401; x=1773334201; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OtnUNlPOJGYKo4fOyAuC0p3kFXSMCZO0E2+BGlyCxWU=;
        b=tGd/NqLRZpaCHTNl6cbUlfdff8csG0L48VS/lUcO/l8dlWABF36SXfukdAdKNYPKH+
         tp1iDJFmWDaCPjHXyN3pd26MNXzRlB6+6kZUs4eovGyQx9iTTCDpafGJdywy/dyq0JMH
         hZoDN27BqW1i1/bFve1U+NzHAQ7jb8G/+LxL93IwjEdit57eIs9Y9rajmIqKvzSBuUJo
         RIq9bow+45GZ6kmnzccSM5DRvQJAJzDxj35YecIuu8WTf4kXuu9dIVK1PdoMuIWFa78s
         blP1rfEhH5PoQcjV7UdzSCP5tq9Inoolyt3T7o8YbAwytf6lTUfWT6Xz5gtbOuWtfK+i
         VWmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772729401; x=1773334201;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OtnUNlPOJGYKo4fOyAuC0p3kFXSMCZO0E2+BGlyCxWU=;
        b=onzUOow+0frUofKCEvNopKm8EfVPEt+6lPqHhZuh9uW5tc1SJujkTR1M41IPLsDaqW
         flvqjwiXlh0b25Uhj4eYO+48VAcSxfUT2mNpxJmEWOGq2w7X8p768aoKMexGqjOiCgxD
         GQHGPPJeK6VeFwjG9+TzVTSq/qQ71deqCTCF9ay2aSywYvkVidiRrjX2Cs80FhEvsc06
         nyzmCO61WlKP+M6aVqqNIcTCQR/UgMmn4NvbjWqp4TmCFErllfXWLz3vNlKNWzZNNMJl
         vTqPg216CS0WhoBEOHuM0QB8nVZ/dBuyu4y9KWwUt8T5uVUkBSXMOsEbxGUDQTkUjCjB
         JGtQ==
X-Forwarded-Encrypted: i=1; AJvYcCUSDwrPuiaHvspiAMfTPygLFHtcQ67icN7bFUuLV23T0hBbZZMvfdWuJDjmLxWloVR2U5A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbmHDqLxaSPeQ1DhE4jD2YwcCnSGskcLn6ePytokeW8SugI5pU
	HV3qd3LYO+mCqKCjko8KTNz6InWdlIE8tmOr8q6/EVanu2+lzBqxTKPhLKopdWfynaE=
X-Gm-Gg: ATEYQzzE81dO1MZQKB4dlyaOildE0j3j2LEwUGmFaqPErvxgIBy9KJ8XTwYM7UT4Jr5
	f5y7fmPcroeeppulD2yuO4JiB1QgoSxxxtVcPe9NWw+hgMItFDt0fOMKqqa5iu/zMwf/ipE+Ebv
	YcueH1EKLfirNLZlm9EJL61WhVxWKus3o0uKcmtWA4xiVzAZLhL2TM1RHy8zxv2p5ZGOP/AbQDG
	Al4BNUTA2fIiwPiw8oTUHHZGrDuLzjk2AXTz9khjeu04h85Y1xw6rcvaY0fOGs9uwUPuDko3Jmt
	U4Vo2BBAH5ni17KWIKUtvMddYjEahPoHrN9UzbAcrgVm9BxJmnaNXjsyDdqA2R2IrJaJqmEx2F2
	mkv+ll89RV3LSIRfRJsOUoST/gQNv780J8Cq6jyyzlq10WeLx7FBFDj1SrkeiUM3Ni8v6ilcDvV
	SC0k3rITLs1lRPwSAGrvxwkrk=
X-Received: by 2002:a05:6214:21ab:b0:89a:8be:9d49 with SMTP id 6a1803df08f44-89a19af3cbfmr95532936d6.31.1772729400631;
        Thu, 05 Mar 2026 08:50:00 -0800 (PST)
Received: from localhost ([140.174.219.137])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89a0c1fd01bsm62676516d6.49.2026.03.05.08.49.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Mar 2026 08:49:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 05 Mar 2026 11:49:58 -0500
Message-Id: <DGV04J3T69LG.352QG90C5TZZD@etsalapatis.com>
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Eduard Zingerman" <eddyz87@gmail.com>, <bpf@vger.kernel.org>,
 <ast@kernel.org>
Cc: <andrii@kernel.org>, <daniel@iogearbox.net>, <martin.lau@linux.dev>,
 <kernel-team@fb.com>, <yonghong.song@linux.dev>, <arighi@nvidia.com>,
 <shung-hsi.yu@suse.com>
Subject: Re: [PATCH bpf-next v1 1/2] bpf: refine u32/s32 bounds when ranges
 cross min/max boundary
X-Mailer: aerc 0.20.1
References: <20260305110929.738140-1-eddyz87@gmail.com>
In-Reply-To: <20260305110929.738140-1-eddyz87@gmail.com>

On Thu Mar 5, 2026 at 6:09 AM EST, Eduard Zingerman wrote:
> Same as in __reg64_deduce_bounds(), refine s32/u32 ranges
> in __reg32_deduce_bounds() in the following situations:
Nit: Can we add a cover letter since this is a 2-patch series?

Also, can we explicitly state the condition: IIUC it's: "When
the signed and unsigned ranges of a register partially overlap
on an entirely (signed) positive of (signed) negative interval".
This helps with the ASCII and also covers the question "what happens
when the ranges overlap in two places" - nothing, we don't refine
the register's bounds in that case, as noted in __reg64_deduce_bounds.

>
> 0                                                   U32_MAX
> |  [xxxxxxxxxxxxxx u32 range xxxxxxxxxxxxxx]              |
> |----------------------------|----------------------------|
> |xxxxx s32 range xxxxxxxxx]                       [xxxxxxx|
> 0                     S32_MAX S32_MIN                    -1
>
> 0                                                   U32_MAX
> |              [xxxxxxxxxxxxxx u32 range xxxxxxxxxxxxxx]  |
> |----------------------------|----------------------------|
> |xxxxxxxxx]                       [xxxxxxxxxxxx s32 range |
> 0                     S32_MAX S32_MIN                    -1
>
> This helps for e.g. consider the following program:
>
>    call %[bpf_get_prandom_u32];
>    w0 &=3D 0xffffffff;
>    if w0 < 0x3 goto 1f;    // on fall-through u32 range [3..U32_MAX]
>    if w0 s> 0x1 goto 1f;   // on fall-through s32 range [S32_MIN..1]
>    if w0 s< 0x0 goto 1f;   // range can be narrowed to  [S32_MIN..-1]
>    r10 =3D 0;
> 1: ...;
>
> The reg_bounds.c selftest is updated to incorporate identical logic,
> refinement based on non-overflowing range halves:
>
>   ((x =E2=88=A9 [0, smax]) =E2=88=A9 (y =E2=88=A9 [0, smax])) =E2=88=AA
>   ((x =E2=88=A9 [smin,-1]) =E2=88=A9 (y =E2=88=A9 [smin,-1]))
>

> Reported-by: Andrea Righi <arighi@nvidia.com>
> Reported-by: Emil Tsalapatis <emil@etsalapatis.com>
> Closes: https://lore.kernel.org/bpf/aakqucg4vcujVwif@gpd4/T/
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> ---
>  kernel/bpf/verifier.c                         | 24 ++++++++
>  .../selftests/bpf/prog_tests/reg_bounds.c     | 58 +++++++++++++++++--
>  2 files changed, 78 insertions(+), 4 deletions(-)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index d92cf2821657..2b79a2a4d1b5 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -2532,6 +2532,30 @@ static void __reg32_deduce_bounds(struct bpf_reg_s=
tate *reg)
>  	if ((u32)reg->s32_min_value <=3D (u32)reg->s32_max_value) {
>  		reg->u32_min_value =3D max_t(u32, reg->s32_min_value, reg->u32_min_val=
ue);
>  		reg->u32_max_value =3D min_t(u32, reg->s32_max_value, reg->u32_max_val=
ue);
> +	} else {
> +		if (reg->u32_max_value < (u32)reg->s32_min_value) {
> +			/* See __reg64_deduce_bounds() for detailed explanation.
> +			 * Refine ranges in the following situation:
> +			 *
> +			 * 0                                                   U32_MAX
> +			 * |  [xxxxxxxxxxxxxx u32 range xxxxxxxxxxxxxx]              |
> +			 * |----------------------------|----------------------------|
> +			 * |xxxxx s32 range xxxxxxxxx]                       [xxxxxxx|
> +			 * 0                     S32_MAX S32_MIN                    -1
> +			 */
> +			reg->s32_min_value =3D (s32)reg->u32_min_value;
> +			reg->u32_max_value =3D min_t(u32, reg->u32_max_value, reg->s32_max_va=
lue);
> +		} else if ((u32)reg->s32_max_value < reg->u32_min_value) {
> +			/*
> +			 * 0                                                   U32_MAX
> +			 * |              [xxxxxxxxxxxxxx u32 range xxxxxxxxxxxxxx]  |
> +			 * |----------------------------|----------------------------|
> +			 * |xxxxxxxxx]                       [xxxxxxxxxxxx s32 range |
> +			 * 0                     S32_MAX S32_MIN                    -1
> +			 */
> +			reg->s32_max_value =3D (s32)reg->u32_max_value;
> +			reg->u32_min_value =3D max_t(u32, reg->u32_min_value, reg->s32_min_va=
lue);
> +		}
>  	}
>  }
> =20
> diff --git a/tools/testing/selftests/bpf/prog_tests/reg_bounds.c b/tools/=
testing/selftests/bpf/prog_tests/reg_bounds.c
> index 0322f817d07b..446e5ef62f44 100644
> --- a/tools/testing/selftests/bpf/prog_tests/reg_bounds.c
> +++ b/tools/testing/selftests/bpf/prog_tests/reg_bounds.c
> @@ -422,15 +422,65 @@ static bool is_valid_range(enum num_t t, struct ran=
ge x)
>  	}
>  }
> =20
> -static struct range range_improve(enum num_t t, struct range old, struct=
 range new)
> +static struct range range_intersection(enum num_t t, struct range old, s=
truct range new)
>  {
>  	return range(t, max_t(t, old.a, new.a), min_t(t, old.b, new.b));
>  }
> =20
> +static struct range range_union(enum num_t t, struct range x, struct ran=
ge y)
> +{
> +	if (!is_valid_range(t, x))
> +		return y;
> +	if (!is_valid_range(t, y))
> +		return x;
> +	return range(t, min_t(t, x.a, y.a), max_t(t, x.b, y.b));
> +}
> +

AFAICT this is only fully accurate if the ranges are intersect/are consecut=
ive.
Is it that it's fine to include extra values into the interval since
we're dealing with bounds checking, and so can relax the bounds as we
please? If so, then this is fine.=20

If not, can we either change the name to make it clear we assume the caller=
 has=20
ensured this, or add a check in the function itself?=20

> +/*
> + * This function attempts to improve x range intersecting it with y.
> + * range_cast(... to_t ...) looses precision for ranges that pass to_t
> + * min/max boundaries. To avoid such precision loses this function
> + * splits both x and y into halves corresponding to non-overflowing
> + * sub-ranges: [0, smin] and [smax, -1].
> + * Final result is computed as follows:
> + *
> + *   ((x =E2=88=A9 [0, smax]) =E2=88=A9 (y =E2=88=A9 [0, smax])) =E2=88=
=AA
> + *   ((x =E2=88=A9 [smin,-1]) =E2=88=A9 (y =E2=88=A9 [smin,-1]))
> + *
> + * Precision might still be lost if final union is not a continuous rang=
e.
> + */
> +static struct range range_refine_in_halves(enum num_t x_t, struct range =
x,
> +					   enum num_t y_t, struct range y)
> +{
> +	struct range x_pos, x_neg, y_pos, y_neg, r_pos, r_neg;
> +	u64 smax, smin, neg_one;
> +
> +	if (t_is_32(x_t)) {
> +		smax =3D (u64)(u32)S32_MAX;
> +		smin =3D (u64)(u32)S32_MIN;
> +		neg_one =3D (u64)(u32)(s32)(-1);
> +	} else {
> +		smax =3D (u64)S64_MAX;
> +		smin =3D (u64)S64_MIN;
> +		neg_one =3D U64_MAX;
> +	}
> +	x_pos =3D range_intersection(x_t, x, range(x_t, 0, smax));
> +	x_neg =3D range_intersection(x_t, x, range(x_t, smin, neg_one));
> +	y_pos =3D range_intersection(y_t, y, range(x_t, 0, smax));
> +	y_neg =3D range_intersection(y_t, y, range(y_t, smin, neg_one));
> +	r_pos =3D range_intersection(x_t, x_pos, range_cast(y_t, x_t, y_pos));
> +	r_neg =3D range_intersection(x_t, x_neg, range_cast(y_t, x_t, y_neg));
> +	return range_union(x_t, r_pos, r_neg);
> +
> +}
> +
>  static struct range range_refine(enum num_t x_t, struct range x, enum nu=
m_t y_t, struct range y)
>  {
>  	struct range y_cast;
> =20
> +	if (t_is_32(x_t) =3D=3D t_is_32(y_t))
> +		x =3D range_refine_in_halves(x_t, x, y_t, y);
> +
>  	y_cast =3D range_cast(y_t, x_t, y);
> =20
>  	/* If we know that
> @@ -444,7 +494,7 @@ static struct range range_refine(enum num_t x_t, stru=
ct range x, enum num_t y_t,
>  	 */
>  	if (x_t =3D=3D S64 && y_t =3D=3D S32 && y_cast.a <=3D S32_MAX  && y_cas=
t.b <=3D S32_MAX &&
>  	    (s64)x.a >=3D S32_MIN && (s64)x.b <=3D S32_MAX)
> -		return range_improve(x_t, x, y_cast);
> +		return range_intersection(x_t, x, y_cast);
> =20
>  	/* the case when new range knowledge, *y*, is a 32-bit subregister
>  	 * range, while previous range knowledge, *x*, is a full register
> @@ -462,7 +512,7 @@ static struct range range_refine(enum num_t x_t, stru=
ct range x, enum num_t y_t,
>  		x_swap =3D range(x_t, swap_low32(x.a, y_cast.a), swap_low32(x.b, y_cas=
t.b));
>  		if (!is_valid_range(x_t, x_swap))
>  			return x;
> -		return range_improve(x_t, x, x_swap);
> +		return range_intersection(x_t, x, x_swap);
>  	}
> =20
>  	if (!t_is_32(x_t) && !t_is_32(y_t) && x_t !=3D y_t) {
> @@ -480,7 +530,7 @@ static struct range range_refine(enum num_t x_t, stru=
ct range x, enum num_t y_t,
>  	}
> =20
>  	/* otherwise, plain range cast and intersection works */
> -	return range_improve(x_t, x, y_cast);
> +	return range_intersection(x_t, x, y_cast);
>  }
> =20
>  /* =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

