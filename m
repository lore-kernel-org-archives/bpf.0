Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D10D39E6F0
	for <bpf@vger.kernel.org>; Tue, 13 Oct 2026 07:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791877405; cv=none; b=SZV9lS7EtaUjjJ4dDzNRUP/ZPj4sG1jNpi4Uv4YBC/m2goSCUH0/uWjkPHJziwPtGiLV2tt7dGyqOOj4ShREHi9UJDXvsjzPlg5x5VWDcb/kdiGBruJtGHMTsZ0GtAIH/cY7di55Q1bqRNl8ovYeD6A3IpkyJLOdq+irBBJ0vWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791877405; c=relaxed/simple;
	bh=qyViu7G0baWrVyQKm8+w1OE2XvJLZWqAJk5LT9YAYZk=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OyA1PAB/oBYyM/6grswT2kFCL6EKo2aW/fSGfc+hOVVithp2HZu9atV6gzbj2lNsrU2DoQbxi2evY/Mjpbbr2J1Y0atH9CCC2pVUKOgM5H214to88qUXdD06JIGeXwp5xNLGkBuhMQ21SMuZ0YKQJK2b1O3sDWtE8LtlDJYJ7uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tBDrEFm8; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tBDrEFm8"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4a1880e1bf1so24175225e9.1
        for <bpf@vger.kernel.org>; Tue, 13 Oct 2026 00:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791877403; x=1792482203; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=W/8ShQHfpM2Gr1qqiy9jPsgsr0xtKy/BekhMiNt1+8E=;
        b=tBDrEFm8/e5is3u575ZXsx/ZtKrExQk4nt1mNaQnuHu/3zU8wp8RPSGiXaguheO3dV
         b39qFGPSPf284oLwPblDQnfKCfgRHjLtcV3yiT0mI1J8nL/fFgx/l6Gc6zRsA8g260Fu
         BSnywTvBKyP5ZJg9gYZldg/imbRTjhkxYKZ2+A+ICyBgIlAYIHnpTMgSabTExw4MV75w
         yjntrZYSM/vSekwxAnWlNfjrTQyKC5DVfPT9G6zeacSY7tlHpw9/Nn+iEqPLy5ARb1iP
         hiUln5wKdhgxRyYT4vBbjhfvIUoOTZT8vF2ySk8o6l02xSNL1cCA+pB0Grnlpp+0mTA4
         ZVtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791877403; x=1792482203;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=W/8ShQHfpM2Gr1qqiy9jPsgsr0xtKy/BekhMiNt1+8E=;
        b=LZ9AVqOkH1XEGibB1PQhyDvWx5i7DT8q00sOzbXHX+jhdftMOs54N9pqxaSXIpJZFc
         AeqrRe2qyzCkC66C57XMu2cXG1qV0OAfoiquUJkTe+bCP7IKpVQK4LRRR2UNAdVxmhc2
         fLs3pgmQUYhaORHyV6W3VxLZjc5862dRea6LMCEdpFb1KkFCuQQfm2dkiw1nX/Wyy8vp
         GgT6PCGf9p4MGJVCdcHWIY9sOJR+uV3vTq28ce27SFxSOF0lj3vyJUKtj7toFlqN9qYV
         Sl4lZIt5E48WwoW2HUiQYNM5p+DEy8EZDBW4Zv2fQjq92Bty2LnxcpqrCqpzMDIucOmf
         SWpw==
X-Forwarded-Encrypted: i=1; AKwUvBxn708NvQMEkUqdTe2WIpZ6WdjLwQMrKH4+vp7pLvl9DmZ6ll6r6l8nNEls7BKTgxlGJaY=@vger.kernel.org
X-Gm-Message-State: AFq9FYIhI/zFqHyS3SfevbJybyHrJ/M+naIvCRcqsYgXoDML2LAWIDk8
	jLMTnXhsiC4HNuvgofV2cdH2j6oSvfpqs0WB1J0awufS5DLFd9mUBBek
X-Gm-Gg: AYBFou2b8t77d7zCeOUxWHdbPdvPghHmdrQXyCr00A1gH+XckSIy5vNwoiI/GYz0t1O
	ynVCzpScAW/sOMyLtOjdCfG7x92/aD1bwsjLSkAZuTg9Z6qNif/YMVtKGaiWmpBDx51GdL632vB
	EW5p+t4j1yb6zxNYp+n/lTUkzyVSaxHT57+8DIQv5/zaxyUFZK+xwHSCIkatovZ0Uv5NByqAKCu
	CHKeyWw9ivevBAKdnwvaXSx6/UI3iRIUbufTw5auCmIuMGH3xj3Uz3JlQvRnVSBQ7YZCLcCPryz
	QHRrVVqGX9YoEPCSpRKvyaxAyZZzA2JG+3eezDHjjhHSvIl9qBqhN5O+J0FCyx5//9Kkt7v7a3a
	g7B6Jo//IuxVuvwSHbpjUeEyuMTwVKC+isTFxkPx0dn32fEruJNV8ZgJT//PCXD/8/n08cDnwCY
	2HRcezarqgIhNQsPwCNd39//zZuaYMLT9XO4wFV5wFXWnB
X-Received: by 2002:a05:600c:3544:b0:4a1:813f:2a57 with SMTP id 5b1f17b1804b1-4a18e4ad8fcmr209198915e9.13.1791877402466;
        Tue, 13 Oct 2026 00:43:22 -0700 (PDT)
Received: from krava ([2a02:8308:a00c:e200::25dc])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a19f318c31sm121713705e9.3.2026.10.13.00.43.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 00:43:21 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 13 Oct 2026 09:43:19 +0200
To: Alan Maguire <alan.maguire@oracle.com>
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
	eddyz87@gmail.com, ihor.solodrai@linux.dev, yonghong.song@linux.dev,
	song@kernel.org, martin.lau@linux.dev, memxor@gmail.com,
	emil@etsalapatis.com, puranjay@kernel.org, yatsenko@meta.com,
	bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next 1/3] btf: Fix size/vlen validation for
 BTF_KIND_LOC_PARAM
Message-ID: <as3hF9vH609sPWOw@krava>
References: <20261012140640.2932195-1-alan.maguire@oracle.com>
 <20261012140640.2932195-2-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261012140640.2932195-2-alan.maguire@oracle.com>

On Mon, Oct 12, 2026 at 03:06:38PM +0100, Alan Maguire wrote:
> Validation logic allowed a BTF_KIND_LOC_PARAM with size <= 4
> and vlen == 2, an inconsistent representation.
> 
> Fixes: a3df11403e8c8 ("bpf: Verify BTF_KIND_LOC_PARAM vlen, flags")
> Suggested-by: Alexei Starovoitov <ast@kernel.org>
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> ---
>  kernel/bpf/btf.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index b09c04ccdc6d..64c78434fa05 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -4827,12 +4827,12 @@ static s32 btf_loc_param_check_meta(struct btf_verifier_env *env,
>  	case BTF_LOC_PARAM_CONST | BTF_LOC_PARAM_SIGNED:
>  	case BTF_LOC_PARAM_CONST | BTF_LOC_PARAM_ADDR:
>  	case BTF_LOC_PARAM_CONST | BTF_LOC_PARAM_ADDR | BTF_LOC_PARAM_SIGNED:
> -		if (vlen > 2)
> +		if (vlen < 1 || vlen > 2)
>  			goto invalid_vlen;

nit, is this condition needed? the check down ensures vlen is 1 or 2

jirka

> -		/* Ensure size/vlen are consistent */
> -		if (size > sizeof(__u32) && vlen != 2)
> +		if (!size || size > sizeof(__u64))
>  			goto invalid_vlen;
> -		if (size > sizeof(__u64))
> +		/* Ensure size/vlen are consistent */
> +		if (vlen != (size > sizeof(__u32) ? 2 : 1))
>  			goto invalid_vlen;
>  		break;
>  	case BTF_LOC_PARAM_REG:
> -- 
> 2.43.5
> 
