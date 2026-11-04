Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793777206;
	b=kmX3vSf/kQuSmk62dPyViosov3czVcVn2TCTTQXJvnUFkB0mAcnYrx+gL2ZHxQ9e5uqt
	 a9vXVWDuadOXz1YLSm+2YOZRbeEE2ClIq+1qSROyGqlRJnfKZq+RGGtJ9b5BUMj4nR/i0
	 Bp+DyNtsipLYoZ3SXsN6lReeE9qiajQah+ZfcvVuEX4486rdu1rXZhyTmt7lwNLr/mta2
	 XQIkn+L+cOfZJ5n9a9OYzvkxtYnt1PdI6CvEEc2V/+ux/FZhB+uVS+QDetA/n0NDd0Qti
	 ksSgQDB+mXJi/KodZNOAqxbLF2n/yxD92mFYrdYzBbD6KNCk9DRQcfpblQ2nPzRuAoQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793777206;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=nzNG0/YK8WDIZzlezpfUa+szM40i3f9UjD+pAaw0PVk=;
	b=4tAbRDjkctZbL67/IAWnrmMcQPNWmqQb32hL3+UXiNS6mi1baShw3ZCRcUAdQDnELUjq
	 LUXPe/4Hk+II1rZwmSCv0OHg1SNAmmb94PY0qKPEyYzy27E81c8P9gL/CzDVhIxd2vVkr
	 CfnLGQc7M9i8VuvozhipXyCVMnlqGQfVSlMrY2YbQGZ+NXX7izDEVbJpL+aUm6bNBl4Kz
	 syZUIbMPaDIy4rZl/QjTCP/uYMdLio8Qkw59lLUxveialkFoS4eMCZZd1eK6iyrTq1zUS
	 a6foEeBsmpUbbXUDNxikFdf+IFnCN+wW25SYdVGYiAnRDi8NOm8Gz5BlNLl5hoM5EaA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nGR0Wv8Z;
	arc=none smtp.remote-ip=209.85.215.177
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F951606A326
	for <bpf@vger.kernel.org>; Wed,  4 Nov 2026 07:26:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9F951606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nGR0Wv8Z
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-cdab938dc83so174768a12.3
        for <bpf@vger.kernel.org>; Tue, 03 Nov 2026 23:26:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793777205; x=1794382005; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=nzNG0/YK8WDIZzlezpfUa+szM40i3f9UjD+pAaw0PVk=;
        b=nGR0Wv8ZJzYqpCCSZTHU8s5UOmMvWiCTTbx7EKS5Eb5viU374gfHxvowklhQHxEGP6
         CEIySAf1D2NjAfDQuJmiehCV6wvZo1qUEzUZXDBrC44taV+ZQV9M/BjCSBXJWGYRKO38
         MWu+zwL8NTcGRBCQ5p3GC5Fkyno3827X/xKIU6z7zzkMiMi1xFbN6rTOx0ct6apvYvXM
         vGM7P/WOOydKGKhAR2LV/hRoUPTWuI78J1QaD8dK8ny9oxqR/XKW3OtjdwyomGdyvBdv
         BQ1WpW4dwYElKIp7zCfjRlXpyKk5u5faESYxxXz1A0s9zK7+fvJKQ6bmIwms6DRea1cF
         YMeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793777205; x=1794382005;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nzNG0/YK8WDIZzlezpfUa+szM40i3f9UjD+pAaw0PVk=;
        b=I+6Zo3IPwY2lEyvTdYR2fRq7Lx/jGBStn6CFcFgH98sio2jPCEwdL3yxCGU2FSExW4
         2GpauqFXWrGpLWRdf2vawYrTqH83s3Pw/JE+ojNBF18JUS2e0AEBGV2uLCqjA7VMiOpi
         Q8nrqHTlCpexaxouFxHmmcHK6WWkHlT2M/ercqmczMaGMX6lR2faZtCHOOWTYLncWooC
         9CFlFwgAMz2KIlKlGaoj88epSaAVcL8I1NlD4FS0MVdHp7uonmSqTjmd3K2gQW1YRM42
         rtcRkXszy/uOy0103T3YRFHyqqBi6tKLPOGuEIGzTcH/DxM6fhajrmEiYeERxVB34KHb
         QLeA==
X-Forwarded-Encrypted: i=1; AKwUvBzbPGnHTBHvvYhIFL9WrdGzSYFphMHhKtXX7km67Td5Qw1NVZ1REBg4tRc8uWy646PbX84=@vger.kernel.org
X-Gm-Message-State: APuU4Z8s79kb9Cak1ZdIdCddtErg6zp4ILl+BkxdJtuKtxVGOEqjXiMZ
	HKm99Gf52POh6bZW/vs0PgPBFfB09N7fq7SzYpPPJvaaoLsnu3Dlhb51DzvqiQ==
X-Gm-Gg: AYBFou0MPLgGr3wgX+Fdq8cJMQJTJH1C/riuHQU65MGG5ab/oMpKzOsrTa5hm/Faq3o
	kZjl30c8A5DYkRBl2vBROVk/NC0ehrsheYvgbKcTFuRkbJDmli1vGWRp8ODDNylmxPRGai3q9HD
	/gUBpusoi3Ldis/YnMENcGX4ySUNVK/MtzIcc9inxrgWH4PFBpJYUkBfHN+jtfR3w/RH8XX01Fw
	PZ4rsENme5Eijz/6dRDe1fEtLL1RSSZGdr5q5SquQW8HXE1Y0/abs61qrg6AjEnXcGBKMJE7oCL
	wfknZatuGsN6KrefteWNwmgFcIJkQzONVYiVb9ciXSioQO3R10ZCSP3FYlzOz2QXj1Hdl1GbIJm
	TOfikUlrdVYIN0m9lQBxVjmiIeqG2Jn/p5UNTJwKDJf9UVxjYzM6WRYpVyBMtCjDskm8rPTxExz
	tjfMV2PD8uI6lrbMYxXTc1LF4OBwkHixeRuDUwHoolz98eNFP6Zu6YHR71mBzajpnGrAsQIdp9V
	8ebXNl49mjt773jfJxSGl5gGbpDV5j37K/xYun4+je7cTKtWMs5zWgSDHQP+Nnm7xXP3S6+iyxM
	wwsuK8Ag8ZXpctfdZQjt5P8ATHkD8kbTsRIQfWozekgbGLbG5T8bNvc+
X-Received: by 2002:a17:90a:f307:b0:3ae:9944:3bf0 with SMTP id 98e67ed59e1d1-3ae99443c7bmr8431848a91.34.1793777204673;
        Tue, 03 Nov 2026 23:26:44 -0800 (PST)
Received: from [192.168.0.13] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b09452d89bsm1388475a91.0.2026.11.03.23.26.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 23:26:44 -0800 (PST)
Message-ID: <f1e784a5de228293bc4fe21a5cfcc60d93a4400d.camel@gmail.com>
Subject: Re: [PATCH bpf-next 16/37] bpf: Count loops whose first value or
 bound is a range
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
Cc: daniel@iogearbox.net, andrii@kernel.org, memxor@gmail.com
Date: Wed, 04 Nov 2026 00:26:40 -0700
In-Reply-To: <20261103234104.208239-17-alexei.starovoitov@gmail.com>
References: <20261103234104.208239-1-alexei.starovoitov@gmail.com>
	 <20261103234104.208239-17-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-10+b1 
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Tue, 2026-11-03 at 23:40 +0000, Alexei Starovoitov wrote:

...

> diff --git a/kernel/bpf/scev.c b/kernel/bpf/scev.c
> index 8662205a3b59..eac792dc7b10 100644
> --- a/kernel/bpf/scev.c
> +++ b/kernel/bpf/scev.c
> @@ -2035,11 +2035,20 @@ static int match_linear_latch(struct bpf_verifier=
_env *env,
> =C2=A0	return false;
> =C2=A0}
> =C2=A0
> +/* What is known about a scalar or about the offset of a pointer. */
> =C2=A0struct scev_value {
> -	u64 value;	/* scalar value or a pointer offset */
> +	u64 umin, umax;
> +	s64 smin, smax;
> +	u32 u32_min, u32_max;
> +	s32 s32_min, s32_max;
> =C2=A0	int ptr_reg;	/* SCEV register identifying the pointer origin, or -=
1. */
> =C2=A0};

Nice set of improvements.
Quick question: can the above use cnum{32,64} instead of direct bounds?
Reason being, that I thought compute_backedge_taken_count() can be
expressed in terms of cnums as well, in which case there would be no
need to split it as two functions.

...

> +/*
> + * The first value or the bound is not a constant. The count is for the =
pair that is
> + * the furthest apart.
> + */
> +static bool compute_backedge_taken_max(struct bpf_verifier_env *env, str=
uct bpf_func_state *st,
> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const struct linear_latch *latc=
h,
> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const struct scev_value *initia=
l,
> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const struct scev_value *step_v=
al,
> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const struct scev_value *bound,
> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct bpf_loop_iters *iters, u=
64 *result)

cnums aside, it appears surprising that both compute_backedge_taken_count()
and compute_backedge_taken_max() are necessary.
For example, I'd expect that compute_backedge_taken_max() should be
expressible using compute_backedge_taken_count() as:

  high  :=3D compute_backedge_taken_count(..., min(initial), step, max(boun=
d), ...);
  low   :=3D compute_backedge_taken_count(..., max(initial), step, min(boun=
d), ...);
  ... overflow check for iv with `low` and `high` ...

Or vice-versa, compute_backedge_taken_count() seem to be expressible
as a special case for compute_backedge_taken_max() with ranges
[initial, initial] and [bound, bound].

Is there some precision loss I don't understand?

--

Also, you'd consider it a nit, but compute_backedge_taken_count() has
a nice set of comments explaining where each condition is coming from.

...
