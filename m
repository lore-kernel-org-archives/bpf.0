Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A51731D130E
	for <bpf@vger.kernel.org>; Fri,  6 Mar 2026 00:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772756014; cv=none; b=GRPIavg67NdmjWiQIAY9ZQ//CZG8ssCvomAaG78fhxkPsDBaaPuuSU5WSjmUHSqRsKR6PCybkNWak2Vk614C4C9Zeh9d/JkqLXOfWFl9pMUPYEyWuHsl2yhKsN3X64srEsuSka7CJxFaLraFrZmUn0MbYQPmijeLYHQI3hRBf+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772756014; c=relaxed/simple;
	bh=Li4Kix+J1mGeqeHe3Fhv+8xWcy6XSHBFelrYjVb9IeQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qQMkAuUbmFtL3VfEUgCb6Fq9VOgAOsip0FhuNsYewW6pbRttiy7M2QjPFOPhknHLjSpIZKyPNhIdWrUZAyovOVlDngGkND6Y4603/59tLuCzfld70trK0zRRliC5OgAgFjdI6Dyd5iuZGxcJ8B4snNKIPLbRheQaep6YsNWjtAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wh93PVFS; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wh93PVFS"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-483770e0b25so73460585e9.0
        for <bpf@vger.kernel.org>; Thu, 05 Mar 2026 16:13:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772756011; x=1773360811; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=g8pmZpePRELpT0ZOdmN60HAwXvR2uRkWlak+kFMuYJ0=;
        b=Wh93PVFSNruYuXpWG+3ShiqMIzdql6Rpt+A0hif2y9CvZEc2hRkEMzue9++W+wzcn0
         BGb6fY60OkQ5UAqGJuRYqhEbXo4otlptz0FAsJkCg8eORV/vNKojE3jglH0h6L4EESzA
         YQTU6TQZFWEESmz3KSFvQlloyAvs/P3y7ihearxJn4V41PpLwWT327mt3lConjRUoYH6
         rCcRxj3KsU0E/4phKkfSdDNkc5G/czfBU/9HGykVgecGH1LMAghOjTNi1X2QeG5RaGRC
         Y2r8V8St6nwcUNFxaRj3nMrpW23tKnfnAKS+qoDkEqWVIal/6E6zYWEou+SlSTAHmpaQ
         JAZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772756011; x=1773360811;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g8pmZpePRELpT0ZOdmN60HAwXvR2uRkWlak+kFMuYJ0=;
        b=Fv9K+XrEUG2025ODsnli9LGgUn/WbId3miiyDJDffjRUFl/zjwk924d4zwGuzcQCdd
         HSYDO7V2LYul75nu/yHHiaZVWGqjwUkVtUh2HKqt5ytdMz8Gg33yGY2IzSnJmcctZPg9
         rDlwyqf5lOIGVVzFgl1+p6uqTNqqBFZ/ySkCD5GBdSQQaCvxNni+ffkB/OWP9RXJM2gd
         YV74tivzfwztwykYi802aaA1ahEa+9PpcSRZ/ypSv9V3jcl+qzCGv5SU++0/dXPTT2dq
         iqurQVrbAuA72+KIRYO3i9KdU8zf35c44eMzwI0bHUXYbXdiJezPdimucz5kPXMgeZMU
         ejXg==
X-Gm-Message-State: AOJu0YwDKLrwv3LAtOPnCxttYycP7NI0UqS/k0QQOU/OSgATfqZikH5d
	V+nUJO69LbWn9p7SxWLrhhSa2XG2TWEoor/9wiBcPcSKa4eIm6IO+V4s
X-Gm-Gg: ATEYQzwza7UVXDpsMc1/RHECeHQmhCWmY/ch9PmlcHItDhjlX6U3Citsz3GD5g2BRss
	tjL1HzPONkA3LmNuISrVWI+PY35ZMikhlXPx+9GvsORiIdZ5a55g/zunHs5hYqPGc1bVS1yHjni
	9fRZgulgfw5ATO5tHPxe1gVib8YpQUvHYcZiNKF5ovuvNx/Md+eOcEWP8XOErdXiXRayG2e/roI
	elMktTCvTvulqIBfLAj5yRFciQ4lh41sQoGikrZqYJDNKIqfDooPgIJwRGoUWQj7CEJ87caT2B1
	z+WCqrSUckwX6q+pmuiFm68YRBwbKiRDzF+uaJU6CjIJZh8pO1esLIWQUHddxbGC0YB7beNtuZC
	hPsw/OvjwG3dswm1hNtY1lY1o5nFKr5cqPeMXVCx7FHMBthrw/jBBiTe7ILKI1Xj9g9QKgAjt4Z
	/fjnP61fq7Yxe+PyyvN32X2CT8mX6seuEyNowvyNaNt4eakH0UYIvAFr6PngONpAxZP5Db1pDd+
	l7BNUTjd4bb1umWnqAbYkbK//+hC8ycNMLxJl46NKqzWzr5e0B6xdbQxW54hdFpNge+5zJAm6c=
X-Received: by 2002:a05:600c:4752:b0:480:4a8f:2d5c with SMTP id 5b1f17b1804b1-4852697721cmr1643005e9.29.1772756010754;
        Thu, 05 Mar 2026 16:13:30 -0800 (PST)
Received: from Tunnel (2a01cb089436c0001b77cc3ec8ba0ad1.ipv6.abo.wanadoo.fr. [2a01:cb08:9436:c000:1b77:cc3e:c8ba:ad1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4851fae5dbdsm71595685e9.8.2026.03.05.16.13.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 16:13:29 -0800 (PST)
Date: Fri, 6 Mar 2026 01:13:27 +0100
From: Paul Chaignon <paul.chaignon@gmail.com>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
	daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com,
	yonghong.song@linux.dev, emil@etsalapatis.com, arighi@nvidia.com,
	shung-hsi.yu@suse.com
Subject: Re: [PATCH bpf v2 1/2] bpf: refine u32/s32 bounds when ranges cross
 min/max boundary
Message-ID: <aaocJ3gJr7019urU@Tunnel>
References: <20260305-bpf-32-bit-range-overflow-v2-0-7169206a3041@gmail.com>
 <20260305-bpf-32-bit-range-overflow-v2-1-7169206a3041@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260305-bpf-32-bit-range-overflow-v2-1-7169206a3041@gmail.com>

On Thu, Mar 05, 2026 at 11:48:22AM -0800, Eduard Zingerman wrote:

[...]

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 401d6c4960eccfa90893660b7d8aece859787f7f..f960b382fdb3d4a4f5f2a66a525c2f594de529ff 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -2511,6 +2511,30 @@ static void __reg32_deduce_bounds(struct bpf_reg_state *reg)
>  	if ((u32)reg->s32_min_value <= (u32)reg->s32_max_value) {
>  		reg->u32_min_value = max_t(u32, reg->s32_min_value, reg->u32_min_value);
>  		reg->u32_max_value = min_t(u32, reg->s32_max_value, reg->u32_max_value);
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
> +			reg->s32_min_value = (s32)reg->u32_min_value;
> +			reg->u32_max_value = min_t(u32, reg->u32_max_value, reg->s32_max_value);
> +		} else if ((u32)reg->s32_max_value < reg->u32_min_value) {
> +			/*
> +			 * 0                                                   U32_MAX
> +			 * |              [xxxxxxxxxxxxxx u32 range xxxxxxxxxxxxxx]  |
> +			 * |----------------------------|----------------------------|
> +			 * |xxxxxxxxx]                       [xxxxxxxxxxxx s32 range |
> +			 * 0                     S32_MAX S32_MIN                    -1
> +			 */
> +			reg->s32_max_value = (s32)reg->u32_max_value;
> +			reg->u32_min_value = max_t(u32, reg->u32_min_value, reg->s32_min_value);
> +		}

Looks good to me. I also ran it through Agni and __reg_deduce_bounds
(aka special instruction BPF_SYNC2) is still found to be sound.

>  	}
>  }
>  
> diff --git a/tools/testing/selftests/bpf/prog_tests/reg_bounds.c b/tools/testing/selftests/bpf/prog_tests/reg_bounds.c
> index 0322f817d07be5d003c17dd7cedfa3aa4197678e..04938d0d431b38e086b50fe28b99e4ad2682742e 100644
> --- a/tools/testing/selftests/bpf/prog_tests/reg_bounds.c
> +++ b/tools/testing/selftests/bpf/prog_tests/reg_bounds.c
> @@ -422,15 +422,69 @@ static bool is_valid_range(enum num_t t, struct range x)
>  	}
>  }
>  
> -static struct range range_improve(enum num_t t, struct range old, struct range new)
> +static struct range range_intersection(enum num_t t, struct range old, struct range new)
>  {
>  	return range(t, max_t(t, old.a, new.a), min_t(t, old.b, new.b));
>  }
>  
> +/*
> + * Result is precise when 'x' and 'y' overlap or form a continuous range,
> + * result is an over-approximation if 'x' and 'y' do not overlap.
> + */
> +static struct range range_union(enum num_t t, struct range x, struct range y)
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
> + *   ((x ∩ [0, smax]) ∩ (y ∩ [0, smax])) ∪
> + *   ((x ∩ [smin,-1]) ∩ (y ∩ [smin,-1]))
> + *
> + * Precision might still be lost if final union is not a continuous range.
> + */
> +static struct range range_refine_in_halves(enum num_t x_t, struct range x,
> +					   enum num_t y_t, struct range y)
> +{
> +	struct range x_pos, x_neg, y_pos, y_neg, r_pos, r_neg;
> +	u64 smax, smin, neg_one;
> +
> +	if (t_is_32(x_t)) {
> +		smax = (u64)(u32)S32_MAX;
> +		smin = (u64)(u32)S32_MIN;
> +		neg_one = (u64)(u32)(s32)(-1);
> +	} else {
> +		smax = (u64)S64_MAX;
> +		smin = (u64)S64_MIN;
> +		neg_one = U64_MAX;
> +	}
> +	x_pos = range_intersection(x_t, x, range(x_t, 0, smax));
> +	x_neg = range_intersection(x_t, x, range(x_t, smin, neg_one));
> +	y_pos = range_intersection(y_t, y, range(x_t, 0, smax));
> +	y_neg = range_intersection(y_t, y, range(y_t, smin, neg_one));
> +	r_pos = range_intersection(x_t, x_pos, range_cast(y_t, x_t, y_pos));
> +	r_neg = range_intersection(x_t, x_neg, range_cast(y_t, x_t, y_neg));
> +	return range_union(x_t, r_pos, r_neg);
> +
> +}
> +
>  static struct range range_refine(enum num_t x_t, struct range x, enum num_t y_t, struct range y)
>  {
>  	struct range y_cast;
>  
> +	if (t_is_32(x_t) == t_is_32(y_t))
> +		x = range_refine_in_halves(x_t, x, y_t, y);

Don't we usually put changes to this file in a separate commit, as for
test changes in general?

Also I believe with these changes, we can now revert commit da653de268d3
("selftests/bpf: Update reg_bound range refinement logic").

> +
>  	y_cast = range_cast(y_t, x_t, y);
>  
>  	/* If we know that
> @@ -444,7 +498,7 @@ static struct range range_refine(enum num_t x_t, struct range x, enum num_t y_t,
>  	 */
>  	if (x_t == S64 && y_t == S32 && y_cast.a <= S32_MAX  && y_cast.b <= S32_MAX &&
>  	    (s64)x.a >= S32_MIN && (s64)x.b <= S32_MAX)
> -		return range_improve(x_t, x, y_cast);
> +		return range_intersection(x_t, x, y_cast);
>  
>  	/* the case when new range knowledge, *y*, is a 32-bit subregister
>  	 * range, while previous range knowledge, *x*, is a full register
> @@ -462,7 +516,7 @@ static struct range range_refine(enum num_t x_t, struct range x, enum num_t y_t,
>  		x_swap = range(x_t, swap_low32(x.a, y_cast.a), swap_low32(x.b, y_cast.b));
>  		if (!is_valid_range(x_t, x_swap))
>  			return x;
> -		return range_improve(x_t, x, x_swap);
> +		return range_intersection(x_t, x, x_swap);
>  	}
>  
>  	if (!t_is_32(x_t) && !t_is_32(y_t) && x_t != y_t) {
> @@ -480,7 +534,7 @@ static struct range range_refine(enum num_t x_t, struct range x, enum num_t y_t,
>  	}
>  
>  	/* otherwise, plain range cast and intersection works */
> -	return range_improve(x_t, x, y_cast);
> +	return range_intersection(x_t, x, y_cast);
>  }
>  
>  /* =======================
> 
> -- 
> 2.53.0
> 
