Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 838AF37204A
	for <bpf@vger.kernel.org>; Sun, 26 Jul 2026 08:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785055874; cv=pass; b=sFI77fGYYF8WbCnGb7VX1P1kv1M2OhUcKGNsUqfktQuYjWcqZtnTgd5razKi5jGIRxqLcsK5eual7AsFQC51QdadiyUGg2DTy8YDIRlTjG/Ksz6mqdfzNie0AKJQw7BLVzLB/zTFsBp17u6CE919ICiuq+p7DuPpJp+p3IhmmmQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785055874; c=relaxed/simple;
	bh=rqz7d2m3VZstPz+96gzxXTWggZ9WTTq04ig0rUihvKU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V7C2Fs1zD7B5Ywe7MY/eoWKECgXffn8NqIFitx/af/7jss186OuNYCTci/QKdv+Eu7OBMbzuwJySGK/kx3Jm4IORi/WU6SiSojq90cPenwP/1refNjnZv1yRSeFkh6OSQvc6MzHVG1tgRV7vdb/B4QRtIdK8Eu5q0iNVdaKQJzs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZyE3Q3yL; arc=pass smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZyE3Q3yL"
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-7ec1e9d3359so1150190a34.0
        for <bpf@vger.kernel.org>; Sun, 26 Jul 2026 01:51:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785055872; cv=none;
        d=google.com; s=arc-20260327;
        b=BlymhWAOcsaQLZw9EzFhofkktNAVJSyYtzVuUuZg1cCi9wOjeqYAG9sEXO6B6j/3BH
         ZtfzATGa5MpFcCLYs2Eor599OC3KANhrHiohpPyYC2iNmhCLOdV5q8Xzd3tK5UdarsN/
         2Q1wCDEAKR/i7lr7GPsBgU8x9kl+lA8jso4iu2SsB/1+8bu7wiYgmYkKzE9EjRE5u2oH
         WjeOvxGA1qq6O28k35ZbZivKRnW2ZbggOMiPYv7L/mHcE2woLqLPKYTyt+eLKiut8i73
         60hHQPPxYWbCG791Z8HEcKzfPkStLX0HhG6VqOX1GCoxwFviBIXaRZooILaRxEJntDpM
         VNRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BPuSW2wZArI0F9+o5ZkCVesoYUmAaH0wK5ElTdhyANU=;
        fh=MNUyUDxmKLq3fiAMtYikdtfr6neb4hsS64ZEKcVJ8qU=;
        b=E3GAOSjQUeKeyLhjKu0qtjxSwvh0a1QgdDUDRlYwsLGQlRy2OIvzfDNVfza2OOE7KD
         kLkEX7Q/JsXUc/aByeQiaqReXeewkmcvPbxXox0C2p2mQzf0Z+tqp4B+a4ucQijkCW2B
         7ctwN98q7gCUKkjoAyKBnFSKo2RCbT0vTgLHOVFtNp/xKYQWczAQLvk3xWPP5cxC6XPC
         GtXYcCnayv72BZAhVLXdUveHdr/SJehBENgM4G+KsfyuOeaKELUW/qMoOUH5aYmD1+mk
         S0iG+Rfa629BG78K1HFCn8Fhza87HBh3SVl12yzveDbGQrFfRuHZQJlZP5MFAP94F2Td
         YgmA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785055872; x=1785660672; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BPuSW2wZArI0F9+o5ZkCVesoYUmAaH0wK5ElTdhyANU=;
        b=ZyE3Q3yLi9DxpQv53b557VNaRY/9WGQ4RPZU3Ggk/ArxXXsoori1U8//QkIkxe4aXx
         WI0Yg2MGudYbs8+mQCTwO0WRbA//JA1/vbJmKXHWORy0uTovtqZHgI2+ssJggshp8RA2
         xSHBK0JHsxXyB5NfncxsOL4kdJf6HEsmkSKtcvqeulfs5M5TMAdh955ofATlKeKv2PwR
         RoC20/lBiJeSuQl9HhNKgHXdWUFidVQAR7qY1q0w5ZaT4MmSGQDLFZHRW/DJLqQ6073u
         5CXppVins19naY2CHhP3UXodDWsCRxS/4nuZNbODj+qtI+up+kH+SyZvXaKJsy12ut0o
         SF2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785055872; x=1785660672;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BPuSW2wZArI0F9+o5ZkCVesoYUmAaH0wK5ElTdhyANU=;
        b=YF7XAV4tzbr18lstBB6YYgSryBzxmFcrQ2G96w1cIS0//jvGob3sf5nw3ZZyCX6Y0B
         kHlAbQuaiWjB/IoRWiYrVKWRtpZWTGKnlCg06VfovFIK/hYMWE99nHDm9vCPbU0zHqC2
         QmNT/FpilIk5HKTyPDfmRJTuj6gG4iat4bNGfKiYlBWsPEaE2EV4YfLVXUkv91fgD5+c
         HL5jGxyo33LeudlvQe0gQg06dCRWq7Pv95GU5YpzQuLJyhcCmGwXjOjier5YzLy/aGz8
         4TRBWVmm0B2hOZpA6JyouyQ1UffSoO8Orb1Xpj1lj0JxRg0W0QcDXkirIf4T+gnIcMHy
         JPyQ==
X-Forwarded-Encrypted: i=1; AHgh+RqqGDG1mC+bsm1D+86iGkhdwrJ3EcjMmSLV5o72k/l+ctO34v+OieVc1RaPd3E5gTIn3V4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCoXf2AOQdg9FvKiirvXCM/xwA/Ro0YC2EIksxQH69pbHOEhWI
	uy55OUVhWO6J4hQqOGdGE1RkRUjzIxBGKY/9AqHdjoOa7CAtiNj1PYI7RlKX+cwp7CWYM3gqEGc
	W9B1AxdnQZdkezXYLB7YL2uWL8F67EWc=
X-Gm-Gg: AR+sD10kKs1Y9Ap/7q0wc16zomje4HPguOzemrl8Sk1ZQNMfZOYHqxSlQQGgITR0gzx
	0ol/lzQCUR0Ax4TftlyjLSx0BUCQg0VwLdUqgjrahB0tXy/8AiMJ0XcO3jna75FsvlDBspDBJWd
	gHRjS4BCYQLP8Bp4gvogb7+vyOqhXuHrEGFPnoExlzrQfZvTyzH4lcUh4sYTdXMYWZgfMstf417
	DDzfA0Otiyxm7E06ThYhmpYc/0GAYilg4EBBpVoOI66KITtl5C5TYIbTttXACc=
X-Received: by 2002:a05:6820:4b85:b0:6a3:1e40:6332 with SMTP id
 006d021491bc7-6aaffc6e253mr3887480eaf.59.1785055872371; Sun, 26 Jul 2026
 01:51:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260711100956.4351-1-yangtiezhu@loongson.cn> <20260711100956.4351-4-yangtiezhu@loongson.cn>
In-Reply-To: <20260711100956.4351-4-yangtiezhu@loongson.cn>
From: Hengqi Chen <hengqi.chen@gmail.com>
Date: Sun, 26 Jul 2026 16:51:01 +0800
X-Gm-Features: AUfX_mx1gpab_zKwSKOhb9cCFWLVj1GDITEpZB1e_dlRrpj8YkBDPb0g7Y5wMfk
Message-ID: <CAEyhmHRPsBC-XUzkrvpCf896yzZF3fxV_AvrDZW4200qrqhi7w@mail.gmail.com>
Subject: Re: [PATCH v1 3/3] LoongArch: BPF: Split unconditional branch JA
 paths statically
To: Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: Huacai Chen <chenhuacai@kernel.org>, loongarch@lists.linux.dev, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 11, 2026 at 6:10=E2=80=AFPM Tiezhu Yang <yangtiezhu@loongson.cn=
> wrote:
>
> In build_insn(), both 32-bit and 64-bit unconditional branch JA paths
> currently share a single case block. It relies on a runtime condition
> check to multiplex between the 'off' and 'imm' fields.
>
> Since the instruction classes are already resolved at compile-time via
> distinct switch-case labels, this runtime check is redundant.
>
> Split the two paths into individual case blocks to remove the redundant
> runtime check.
>

Though no big deal, someone would argue that the emit_uncond_jmp() is
duplicated.

> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> ---
>  arch/loongarch/net/bpf_jit.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
> index 5f32b205a6ac..69bc30f88c44 100644
> --- a/arch/loongarch/net/bpf_jit.c
> +++ b/arch/loongarch/net/bpf_jit.c
> @@ -1150,11 +1150,12 @@ static int build_insn(const struct bpf_insn *insn=
, struct jit_ctx *ctx, bool ext
>
>         /* PC +=3D off */
>         case BPF_JMP | BPF_JA:
> +               jmp_offset =3D bpf2la_offset(i, off, ctx);
> +               if (emit_uncond_jmp(ctx, jmp_offset) < 0)
> +                       goto toofar;
> +               break;
>         case BPF_JMP32 | BPF_JA:
> -               if (BPF_CLASS(code) =3D=3D BPF_JMP)
> -                       jmp_offset =3D bpf2la_offset(i, off, ctx);
> -               else
> -                       jmp_offset =3D bpf2la_offset(i, imm, ctx);
> +               jmp_offset =3D bpf2la_offset(i, imm, ctx);
>                 if (emit_uncond_jmp(ctx, jmp_offset) < 0)
>                         goto toofar;
>                 break;
> --

Acked-by: Hengqi Chen <hengqi.chen@gmail.com>

> 2.42.0
>
>
