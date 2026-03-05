Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 389DC3431E7
	for <bpf@vger.kernel.org>; Thu,  5 Mar 2026 20:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772743872; cv=none; b=Ot2EOnflS3F6rZK+H/8g5bWHU1OsyhdAEj1dmWrNMP1Zhk35QO+BIH+x3qADCLtEgxURB2HF8zKRzkji5sD1m2raZRQ41LscErAJPGn64bBBCP9qpxNTIsg++3PNQbDapuPXDo7lLoalZTxkeI5hXjuuGu0dLcMEsaREyijnRRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772743872; c=relaxed/simple;
	bh=p5YlhbRk+DLdOeFvJHeBHRLdpw+KbUFAPYDgsqIIEvo=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=OMizA23uzhIwi8LhpspOp0f73oeI7xNv4dM+JGxIQRYIy3FhJtk4KtqsPUg3RjEFaiZwTp4w+x/BFZu9zyhaxzrLXEVp7uWelqna0BC8XuXmXv0/mN8Ol9DTiMxCRf3aH/9NXjD+NOBqNQq+sh51wSRP8cwcAXgsiKQWgR3zKIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=SP5UoVBO; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="SP5UoVBO"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-899a5db525cso78238476d6.3
        for <bpf@vger.kernel.org>; Thu, 05 Mar 2026 12:51:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1772743869; x=1773348669; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sgzw/Yy6469YUUjWg/HkJ4Vd8K17K8C4vT9bmbT6Yt8=;
        b=SP5UoVBOR/UO2fPpyv5ytYYV5NnPB4U/rKiQqo+Rxa+tDjSSivKhGpqu/7wwd9ORyR
         m79aJAd8TtAgGJatj51bb0SZVSZdb0ywoViBVPj5YUfv0PBEhPZh9OTfaaKcYm/ojvzj
         CScRS/VK8TWUhHpPW8NyxaY3Ib2Tj7OSsbSmC4offKEfKjlzvPa5Am7X2ncK1/hjwbix
         otvzcAsd5Eb1Hqkf40h2WzD9B+z28iDwQhE5ynMC+G2FvWdbJDJJXNkeEJDxGC2cZ4iX
         rJqOWQnPN7tq1qPy+JT3GKYDlOt58eNUZtJTKlvxnIV+3454TC2VARRKlKOlh9FuUEZy
         26mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772743869; x=1773348669;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sgzw/Yy6469YUUjWg/HkJ4Vd8K17K8C4vT9bmbT6Yt8=;
        b=E86jgItcgg0PnIFm5T8XFaoUQ4YdYq8mg99J6h9wiOnSU7hveUeDPB9tbcTgpawDX1
         OizBLHVvKZHYzJUTah1n6eFYwJgL+1vATCpku9ijh+RXqg3LV8BqqHPnr1aUwYcDruSr
         1M71hZkn0GVd6PIwLlvYwb+W51LSLJLaNIPpskd+IJV4VfY6kRZSDv89kxrIX4H80tSn
         5WN6uoWrRCI5dwAX1U09hHn5RJrhGbA90bIu1MHSAY/9ycNbsL+SRrp3dxt6DQ4WgYaR
         vQchOeJx/BeXHRByc8L4asQo7HoPDpNzWGm7Dp98nYhSHCK09ooUl4y+j9Ofva+HLAjx
         HhrQ==
X-Forwarded-Encrypted: i=1; AJvYcCU+C5ABGks3P4wkuTPOoJlLZ103fTeX+6xGY6ziTyPV1xOhQj1LasaJY1JhmKb+9ItbLvM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3gnNb+LAcHjDzuoRr8psPcuUF0aCc+JB1Xvxlz7t05QRquTkz
	855IRE5KQmi9AWP4bphFEbp//dubPRqvM0rOT06U0wlK/xO/SZk0wrGlAMBgHDLNvVo=
X-Gm-Gg: ATEYQzwfbNKOTIE+/AUmzcVv985I713oNpTACFXRXa0twkFuNmH8YYX8vOU/feFsO4B
	C3mPIoSoHg8LrBPHh9BggWb5IyI6iX0imNq9fnWD1+LunIuZb3mt3igxl8tZXdfwB5BlHqhA/J5
	VPh8afC8r0yml6Y2VrwSl2iAE69zCiCMLIuMQYdiqeDdxKUVDtAl25BKIIhUIy2l9DgFy0/fxNP
	283VXNDEzvJZSWUOQcXG+k74hFf4WYjVEi8O8TIkv0ZzyX9s8MYlKZU/Jq3n3jFhY1yI4+84oAa
	OfY2z2yKeiw6KmsnuR3LgvfmiyVevdRQtX8h+aY1eCgXuMZO7p4JIuumqdFwNKQhmHDLEQO7S6z
	PFaoegbulMCL5Gvzlwh81OueeYJ1D4Ko4vlQr8CBwz8bvlQ1u9Apah9fJxxVqJnQKbEFhLo+Q+x
	QOgMPQfOmNLupvzTUhH47in14=
X-Received: by 2002:a05:6214:410d:b0:89a:909:260 with SMTP id 6a1803df08f44-89a2e03b66amr19477226d6.48.1772743868567;
        Thu, 05 Mar 2026 12:51:08 -0800 (PST)
Received: from localhost ([140.174.219.137])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89a04849cb3sm92408366d6.6.2026.03.05.12.51.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Mar 2026 12:51:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 05 Mar 2026 15:51:06 -0500
Message-Id: <DGV595P7RD99.1DBDDKJIFFI8E@etsalapatis.com>
Cc: <daniel@iogearbox.net>, <martin.lau@linux.dev>, <kernel-team@fb.com>,
 <yonghong.song@linux.dev>, <arighi@nvidia.com>, <shung-hsi.yu@suse.com>
Subject: Re: [PATCH bpf v2 1/2] bpf: refine u32/s32 bounds when ranges cross
 min/max boundary
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Eduard Zingerman" <eddyz87@gmail.com>, <bpf@vger.kernel.org>,
 <ast@kernel.org>, <andrii@kernel.org>
X-Mailer: aerc 0.20.1
References: <20260305-bpf-32-bit-range-overflow-v2-0-7169206a3041@gmail.com>
 <20260305-bpf-32-bit-range-overflow-v2-1-7169206a3041@gmail.com>
In-Reply-To: <20260305-bpf-32-bit-range-overflow-v2-1-7169206a3041@gmail.com>

On Thu Mar 5, 2026 at 2:48 PM EST, Eduard Zingerman wrote:
> Same as in __reg64_deduce_bounds(), refine s32/u32 ranges
> in __reg32_deduce_bounds() in the following situations:
>
> - s32 range crosses U32_MAX/0 boundary, positive part of the s32 range
>   overlaps with u32 range:
>
>   0                                                   U32_MAX
>   |  [xxxxxxxxxxxxxx u32 range xxxxxxxxxxxxxx]              |
>   |----------------------------|----------------------------|
>   |xxxxx s32 range xxxxxxxxx]                       [xxxxxxx|
>   0                     S32_MAX S32_MIN                    -1
>
> - s32 range crosses U32_MAX/0 boundary, negative part of the s32 range
>   overlaps with u32 range:
>
>   0                                                   U32_MAX
>   |              [xxxxxxxxxxxxxx u32 range xxxxxxxxxxxxxx]  |
>   |----------------------------|----------------------------|
>   |xxxxxxxxx]                       [xxxxxxxxxxxx s32 range |
>   0                     S32_MAX S32_MIN                    -1
>
> - No refinement if ranges overlap in two intervals.
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

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

> ---
>  kernel/bpf/verifier.c                              | 24 +++++++++
>  .../testing/selftests/bpf/prog_tests/reg_bounds.c  | 62 ++++++++++++++++=
++++--
>  2 files changed, 82 insertions(+), 4 deletions(-)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 401d6c4960eccfa90893660b7d8aece859787f7f..f960b382fdb3d4a4f5f2a66a5=
25c2f594de529ff 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -2511,6 +2511,30 @@ static void __reg32_deduce_bounds(struct bpf_reg_s=
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
> index 0322f817d07be5d003c17dd7cedfa3aa4197678e..04938d0d431b38e086b50fe28=
b99e4ad2682742e 100644
> --- a/tools/testing/selftests/bpf/prog_tests/reg_bounds.c
> +++ b/tools/testing/selftests/bpf/prog_tests/reg_bounds.c
> @@ -422,15 +422,69 @@ static bool is_valid_range(enum num_t t, struct ran=
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
> +/*
> + * Result is precise when 'x' and 'y' overlap or form a continuous range=
,
> + * result is an over-approximation if 'x' and 'y' do not overlap.
> + */
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
> @@ -444,7 +498,7 @@ static struct range range_refine(enum num_t x_t, stru=
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
> @@ -462,7 +516,7 @@ static struct range range_refine(enum num_t x_t, stru=
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
> @@ -480,7 +534,7 @@ static struct range range_refine(enum num_t x_t, stru=
ct range x, enum num_t y_t,
>  	}
> =20
>  	/* otherwise, plain range cast and intersection works */
> -	return range_improve(x_t, x, y_cast);
> +	return range_intersection(x_t, x, y_cast);
>  }
> =20
>  /* =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

