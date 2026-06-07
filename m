Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B6B136C5BB
	for <bpf@vger.kernel.org>; Sun,  7 Jun 2026 08:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780822795; cv=none; b=NJkkaYTMm/uIFek3k5Mg+Nt/8OViEEIYoXFzpLYJD3gTtxlurjfHjdn++uphW5V0K2QDTAUIydAVRjFMUYV7DWWkhy5X9O/esmUej3BnsP4bn/JsUCV2e274tiytYBABZDhpaFnOXOT5wA619rkxz0PjU6B2YvkXUuLYX+gCIpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780822795; c=relaxed/simple;
	bh=51hCHviJV9dx2kHJUEdIxPea9gknSXJj2/BlEWlzHPA=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=EI3neFziqtz3ouGS9EGEs06Lj0S/WM4NWE87cF2kMW1hn9r9Okml8LVOCUUBXCkwAh2iAMu9tA6wv1ZuzlqtJAaBrTpmQTbWwHOSZ9iGORyzFIgbbkvmpKq3mI87HpQIaqjuCOWS+0Xuyn2Vj3ygApG8kLkJRI9jYWV3xgX7eIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IrE0gVMt; arc=none smtp.client-ip=209.85.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IrE0gVMt"
Received: by mail-wm1-f66.google.com with SMTP id 5b1f17b1804b1-490cdae130cso649125e9.0
        for <bpf@vger.kernel.org>; Sun, 07 Jun 2026 01:59:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780822792; x=1781427592; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hd8eJQE2e7HGUVx3+ey2vy9S5cDeuFg6IlJZJVllcIw=;
        b=IrE0gVMtulCp3oN+57lGho/0OvEyOcm17i4vJeiNhE9ynyhO2q26zdmuxh/tu2IPeY
         SCHz/B3zBNOHZIkgY0hf4t9GCZgIHZnh+czAQ3UymI0m/m5SrMI+IaXYo3C+FFotApdD
         ZoBU7FONBHEYzKjsZzOCu+HhfZCWHqlxs0YMuWu5n2ZHJSYjhfi3P2INkkNPICzgV9mm
         1JvcWhCl3jN+yQg/CRAt2HQ5nbZIG7RGU6X8I3KnOdKg0w+7noDqvtjfwW0rNH1G8w9I
         P6q34vJZnO9m/lWgHwm/Lj2qNI8+0FvT9DF5FrOTafbujNCMuDZIyjSOkFU2lOHgj6FA
         NiwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780822792; x=1781427592;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hd8eJQE2e7HGUVx3+ey2vy9S5cDeuFg6IlJZJVllcIw=;
        b=c22GjgWVJ/ciJJb/NnxMD7bHJZsaA4C91BFTs7reUgoUzSW5YJ8SwXiOvioWyqFrPm
         sw5pU8NPZ2oAZlgeqZEWJ4dJLS40lICQY4kkRTsjrTIQPn+8TaxTfnCZEsEdECOuw9TN
         Y4Tvss+BgbXK7K5UQVedHS98QApMWxQoBCSZQSTQPRI+STqnTZ+rhylMWFJZvI9eP4h2
         iQhnMaxDXSDkXdBzYqON95caWb+8zNl6SvJMDIv/G7qHPbsLGt/kmF+KMzucwHbkuXb2
         QrWFLmJTD4RI5m1snitNnaUudFUS4T1xgO3EorV19w9RGv6j7DQmlP8UNobZbl5qh50o
         reTQ==
X-Forwarded-Encrypted: i=1; AFNElJ+7gRtbYEEckmj9KvxRAE1ngvA7LsyYbJMFZwalHDoTF8UxPQXjoebZTMQuYQ+ZoAv25Qs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAif4HBXnnxb0stLVRUlPz8N9/JmgQBMU7dR4qo2d6+RL628mZ
	pEMSCfXQUiGjHjZTr/qdgQ93YLxSEay6xAM05CgBo3NVIfLFa1j+A5FJ
X-Gm-Gg: Acq92OEUhAQnmmE4hkankvUCVJQg1wnSFoOKJf8dtB8T1MA7rsCA8DjHjPccw7f0uI/
	JN4bKbmKCyn6VTWSyA+/1YFDeYtPgNdkS5Txs4GFfOroxsQNikI1ShaZVYuOtZ+1pzm9Dhc8Cle
	s8YUoWiW8t+KC6SQ5hyk+tMEpPQBNUAY44xtR1go1AkWUCKKLmbiqfInqLsYCzjcmktt+HQh37L
	p6tLqK697j3h1ijWrlggZUDzVvz8PqIRN+kvUnjMFmaX1e23utFQRAQUY8pl7wgWfB/XvPx56x7
	//ZgwZnfhMiFcwv7hnP2EMgIZKXz8IUo3kqK9Scjo1UcdLZZzL9RLtwF9CG8xIeQalzlr4EdaUD
	Ui3DLsIqTa8zOwP1DU1xAMndKmNDIVx0el3uQa8Wc2FF6nxSRXUOdZn8pF9nOCD8rdBLFmFUfn8
	nRb7IxlhIT8M+G2l+FK2RGEg98W2nddZcLNN5yCua18GjISsT1M9bC0nxbaOThTftEMRyLNhBiE
	KDtgGNOKkAK/94s2HB1dlTiH1GGF5QFKNZJ7Zy2tYKkvdiA0/iUl7eg7sM9ovGTVB6jh4jotbjE
X-Received: by 2002:a05:600c:628c:b0:48f:e26a:1744 with SMTP id 5b1f17b1804b1-490c25a87f5mr166153635e9.9.1780822792343;
        Sun, 07 Jun 2026 01:59:52 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f35fd33sm45756094f8f.35.2026.06.07.01.59.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2026 01:59:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 07 Jun 2026 10:59:51 +0200
Message-Id: <DJ2OZSCSEVEI.3APUCE7ML9X4Q@gmail.com>
Cc: <song@kernel.org>, <yonghong.song@linux.dev>, <jolsa@kernel.org>,
 <houtao1@huawei.com>, <linux-kernel@vger.kernel.org>,
 <stable@vger.kernel.org>
Subject: Re: [PATCH bpf] bpf: Validate BTF repeated field counts before
 expansion
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: "Paul Moses" <p@1g4.org>, <martin.lau@linux.dev>, <ast@kernel.org>,
 <daniel@iogearbox.net>, <andrii@kernel.org>, <eddyz87@gmail.com>,
 <memxor@gmail.com>, <bpf@vger.kernel.org>
X-Mailer: aerc 0.21.0
References: <20260605234301.1109063-1-p@1g4.org>
In-Reply-To: <20260605234301.1109063-1-p@1g4.org>

On Sat Jun 6, 2026 at 1:43 AM CEST, Paul Moses wrote:
> btf_parse_struct_metas() walks user-supplied BTF during BPF_BTF_LOAD,
> and btf_repeat_fields() expands repeatable fields from array elements
> into the fixed BTF_FIELDS_MAX scratch array used by btf_parse_fields().
>
> The remaining-capacity check performs the expanded field count calculatio=
n
> in u32. A malformed BTF can wrap that calculation, causing the check to
> pass even when the expanded field count exceeds the scratch array
> capacity. The following memcpy() can then write past the end of the
> array.
>
> Use checked addition and multiplication before copying repeated fields
> and reject impossible counts.
>
> Fixes: 797d73ee232d ("bpf: Check the remaining info_cnt before repeating =
btf fields")
> Cc: stable@vger.kernel.org
> Signed-off-by: Paul Moses <p@1g4.org>
> ---

Do you have an example where this actually occurred in practice?

>  kernel/bpf/btf.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
>
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index a62d78581207..510aa32847da 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -3668,7 +3668,7 @@ static int btf_get_field_type(const struct btf *btf=
, const struct btf_type *var_
>  static int btf_repeat_fields(struct btf_field_info *info, int info_cnt,
>  			     u32 field_cnt, u32 repeat_cnt, u32 elem_size)
>  {
> -	u32 i, j;
> +	u32 i, j, total_cnt, total_repeats;
>  	u32 cur;
>
>  	/* Ensure not repeating fields that should not be repeated. */
> @@ -3686,10 +3686,9 @@ static int btf_repeat_fields(struct btf_field_info=
 *info, int info_cnt,
>  		}
>  	}
>
> -	/* The type of struct size or variable size is u32,
> -	 * so the multiplication will not overflow.
> -	 */
> -	if (field_cnt * (repeat_cnt + 1) > info_cnt)
> +	if (check_add_overflow(repeat_cnt, 1, &total_repeats) ||
> +	    check_mul_overflow(field_cnt, total_repeats, &total_cnt) ||
> +	    total_cnt > (u32)info_cnt)
>  		return -E2BIG;
>
>  	cur =3D field_cnt;

