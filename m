Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEF6033F8B1
	for <bpf@vger.kernel.org>; Thu,  5 Mar 2026 20:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772744112; cv=none; b=EvGXYPZSkJpr+zZefYiWHqzel9gc0RNwrTl9we0kcUijpEtY/jpb6Z3OWvBMU2mCYghHRg+snkCl7ThXoGAJzSpwrTcdJ5niIFOHbrncbLiXi1rfx9m10GNPy+XrHHnO5aPh9n2fa7zSsx1gahaxnWZ+LcvJuAqq0TNKThrhLcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772744112; c=relaxed/simple;
	bh=xvYuAHiV4QHCd6NSpANjnkxpULNFGmsm3ZwbSN7FhAY=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=OuKfNGLVEUxg1w762SQpUBA8jR46XWT2tCNrnuaYS58yfed6wUVa+pDc8zw46tFL21qPZnuGRHrrSTvIPgPGw3Ugv+4SQkbUvz1jXlzfgyVStmnRdP3cH5bA923wlDY2/FPYK8Ysdz1kjuWOLeycTZXJ2QR6QkZkIG98fC0gkf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=b8W2YhHF; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="b8W2YhHF"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-899efe93d4eso64895356d6.2
        for <bpf@vger.kernel.org>; Thu, 05 Mar 2026 12:55:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1772744110; x=1773348910; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wb7WhMNXom5z4jMhgY64ckMQ1PVc1150iVjtrviI18w=;
        b=b8W2YhHFoF5QPgbcJ0Hsk4i/sdn+TqzzLBj9PtbWZJ7WZr7UV2IgzMX+tUk16HCzVe
         jZLpO9HGohXdoWOqMLUHEMtHUwvNFiJTVppo+AmKHe/HansEkG95NzIYDCPjSmEtQg4M
         IX/l+jaKVkgO3D/HK0Vb+r8YICeanRe4R9N6SKp/8N3dXN2q1Ze1mnlXLHvqDvdq1OyK
         t/qCxRx9kDjUYaRGQ+dMJDdmYyktwPbyjLn+yluh+S+aazXlMZgSlCsOhVaxH9fjljOx
         veYKlYuzD3cdiRKeZo+3I1IDW86cN7CWJmcV/9mi2AhNL1T00Mgo9BumGpgfg+VMyWje
         K9Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772744110; x=1773348910;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wb7WhMNXom5z4jMhgY64ckMQ1PVc1150iVjtrviI18w=;
        b=YA1hVNG1Fvg+xqF4lm5zVv+OH4r1HMIR1LNmJFo8gw0XIBC0jcm0JydLMvopGX7cIM
         oF+q0Ia7rJzeIg8rFQ/j52Oo8Z7Tw09mqGs7OnllNG2iCpznN4ZdQ/2Ltb70z+ZrhsTa
         kR3FkRi+Cu4K33BqDZGxYNf7HIypZlTHyln1cx3jvNmbbcDkFYAXIaJzBk4lnMoYZd5y
         05K9ze5B7PZN293n+G4Ux9CagGKJNNEWQmpkEc3VKel8pokYrwWuqevUD2XA/eSofSGK
         LErMP7ieL5OLo5d6pfDzEdDUUxrCZROM1cXxCkqP1zjJKjqBalVmRlXWvDCp57qm5ctd
         Wdwg==
X-Forwarded-Encrypted: i=1; AJvYcCW9fEyDKxl4rJjVQr+s20BvDorUneaPfNEs7qYTn4PWuFO/YVxJrqRVN7g3RUP3wlNOWCs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyfv0q0BWzlMAJTQP53aZVEVqgUiliVgq8r9pTjY7UjWpC826Vl
	p7g2XtE92pB617FGb159VpTd3ZKGrAX00Bu5zah9oarOsvWbHvDwVtkzlm8PVgaVZQk=
X-Gm-Gg: ATEYQzxcQChyv6xSIJjrbnXE2J+jFe2oDCxAaLyDrz/lLikkIE2Me6Vp16fYinlAyTZ
	0EaGwCo1V8iKPTpByUJspyp6L9CywFLDRbXhK6VC2KJaHIm08WG2FfMNnI85X8bR4/1NpG0oNMQ
	bRwJxjHFl9zisDR+6CB52k0OduNlZ60oQyPGz5S7gHu4FqpE96CdZr6ofw073r9XoTqMxlxOZnF
	CAR4XvwBttWzhKh/p4prkIATXfudMzS6Bh7rX8EP8rBe9lj6rK+iueoWKQQm7VCZneE9G0QZvic
	2caFGIRMIAYNEHbGGB54edC33tUYnQLTfO6ZNG436GybBC+Y9biC+LTVoAv0nPOpq22urXKRcsD
	Y66USSeIdr4J0VfgjziDyjXJEM+RebPXeiG3BcoiDehd5TXwGgQpYzaxPUDapXS8JvB908JY5Dy
	Be5pbXKi/3gAnZCx2IZUdJbs8ywyG2q4FTsw==
X-Received: by 2002:a05:6214:2265:b0:899:e814:825f with SMTP id 6a1803df08f44-89a19d2383amr110890506d6.59.1772744109697;
        Thu, 05 Mar 2026 12:55:09 -0800 (PST)
Received: from localhost ([140.174.219.137])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89a07f690c1sm77385516d6.44.2026.03.05.12.55.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Mar 2026 12:55:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 05 Mar 2026 15:55:07 -0500
Message-Id: <DGV5C8B9Q4M4.34BP6TZGX8KM1@etsalapatis.com>
Cc: <daniel@iogearbox.net>, <martin.lau@linux.dev>, <kernel-team@fb.com>,
 <yonghong.song@linux.dev>, <arighi@nvidia.com>, <shung-hsi.yu@suse.com>
Subject: Re: [PATCH bpf v2 2/2] selftests/bpf: test refining u32/s32 bounds
 when ranges cross min/max boundary
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Eduard Zingerman" <eddyz87@gmail.com>, <bpf@vger.kernel.org>,
 <ast@kernel.org>, <andrii@kernel.org>
X-Mailer: aerc 0.20.1
References: <20260305-bpf-32-bit-range-overflow-v2-0-7169206a3041@gmail.com>
 <20260305-bpf-32-bit-range-overflow-v2-2-7169206a3041@gmail.com>
In-Reply-To: <20260305-bpf-32-bit-range-overflow-v2-2-7169206a3041@gmail.com>

On Thu Mar 5, 2026 at 2:48 PM EST, Eduard Zingerman wrote:
> Two test cases for signed/unsigned 32-bit bounds refinement
> when s32 range crosses the sign boundary:
> - s32 range [S32_MIN..1] overlapping with u32 range [3..U32_MAX],
>   s32 range tail before sign boundary overlaps with u32 range.
> - s32 range [-3..5] overlapping with u32 range [0..S32_MIN+3],
>   s32 range head after the sign boundary overlaps with u32 range.
>
> This covers both branches added in the __reg32_deduce_bounds().
>
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

> ---
>  .../testing/selftests/bpf/progs/verifier_bounds.c  | 37 ++++++++++++++++=
++++++
>  1 file changed, 37 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/progs/verifier_bounds.c b/tools/=
testing/selftests/bpf/progs/verifier_bounds.c
> index 97065a26cf70603c3e4b8d43d3a04248828398fc..60ef976959153d25c19ba08c3=
c2f265d8d83b33e 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_bounds.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_bounds.c
> @@ -2000,4 +2000,41 @@ __naked void bounds_refinement_multiple_overlaps(v=
oid *ctx)
>  	: __clobber_all);
>  }
> =20
> +SEC("socket")
> +__success
> +__flag(BPF_F_TEST_REG_INVARIANTS)
> +__naked void signed_unsigned_intersection32_case1(void *ctx)
> +{
> +	asm volatile("									\
> +	call %[bpf_get_prandom_u32];							\
> +	w0 &=3D 0xffffffff;								\
> +	if w0 < 0x3 goto 1f;		/* on fall-through u32 range [3..U32_MAX]  */	\
> +	if w0 s> 0x1 goto 1f;		/* on fall-through s32 range [S32_MIN..1]  */	\
> +	if w0 s< 0x0 goto 1f;		/* range can be narrowed to  [S32_MIN..-1] */	\
> +	r10 =3D 0;			/* thus predicting the jump. */			\
> +1:	exit;										\
> +"	:
> +	: __imm(bpf_get_prandom_u32)
> +	: __clobber_all);
> +}
> +
> +SEC("socket")
> +__success
> +__flag(BPF_F_TEST_REG_INVARIANTS)
> +__naked void signed_unsigned_intersection32_case2(void *ctx)
> +{
> +	asm volatile("									\
> +	call %[bpf_get_prandom_u32];							\
> +	w0 &=3D 0xffffffff;								\
> +	if w0 > 0x80000003 goto 1f;	/* on fall-through u32 range [0..S32_MIN+3]=
 */	\
> +	if w0 s< -3 goto 1f;		/* on fall-through s32 range [-3..S32_MAX] */	\
> +	if w0 s> 5 goto 1f;		/* on fall-through s32 range [-3..5] */		\
> +	if w0 <=3D 5 goto 1f;		/* range can be narrowed to  [0..5] */		\
> +	r10 =3D 0;			/* thus predicting the jump */			\
> +1:	exit;										\
> +"	:
> +	: __imm(bpf_get_prandom_u32)
> +	: __clobber_all);
> +}
> +
>  char _license[] SEC("license") =3D "GPL";

