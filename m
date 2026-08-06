Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6C4E2F7F12
	for <bpf@vger.kernel.org>; Thu,  6 Aug 2026 14:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786027383; cv=pass; b=BM9F2Jr81vWW752I+BhWcJ94g8pJIpcE2KG5y8lAEyEKekHDTzpCJLj1Oh4hj+OvWwZq0IglPFuOzdjgoaf8pdkg0NH1UA1EA98Qh9t/NExQDEsaaNuBR5ZVhKBU3CqFb7q5oSi6CD3LL7tprFUpHu+FMh0PUspq/AfR+oKi0w4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786027383; c=relaxed/simple;
	bh=d4crP78UmsZTHMp0ACz/sf0rl9UlxdgR4+5IJnRQLlA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BRNF8Ru9X/OluV0lzPb01iPw2bEJaw67ZF9DGbqrGTaFDHpYNM0iGiU49iLtc0s85Vj1F59GhbUApAjny+8WLEDoAG0HqGs/MOHFVoGNLcNka1vMorpzdEe3+oMMpFexnzAugw1sQqCPcIc1ebn9l30GUf/GCTh6gfLYFHserqM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=glMtunpS; arc=pass smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="glMtunpS"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6a10d02ff43so3873549a12.0
        for <bpf@vger.kernel.org>; Thu, 06 Aug 2026 07:43:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786027380; cv=none;
        d=google.com; s=arc-20260327;
        b=kmq4VJIwC9/9xa6ufGswuUYiS7SG6pTw7ylD6h/SRLDYwPkrhUTB7nNcWfEVsIv7gs
         tNYJuYNwvcCIicG9R9NkBR4lI9iAZNJ9fCz7Iuq5BTUfFe+Mcv+sNKhdlyeGs6+G5nvD
         cvUE30J1G8B53vfbqHuGqJbr/zCxruJD90564dEdmiXnEDjzGF1wn7EINgDT78h2m7LC
         ISOk6vT3HDwAcwYRJklrgFOkR9YIdoDnFc9NlulFSphimy9WrCG9tOaCxG4xNVwIaE+Z
         AcnsCJXO+1Pe3uz0Q9eIvp0uavKWq21GEzfe/bAGBr3ZCpNFEVCAbzb3EyxgKWsNxFB9
         pxtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VPGAgS2JZJzV8gNCDCNJHdtMdpaoK15faH9rH5iP8NY=;
        fh=rYvc710eiJj4mXe+rVRhgFNeWhcCb0IPgJVIIy8ZaOw=;
        b=Zwfyn2fD0GaZfQaJLJ8J6CrF+fYDC11lUsgC77BI6BqZY1VsMvkoQwoZIU2IjNZSQX
         XuS+wcrjlm6gWJ/LaugQnynTPJcE//VwabU6u/sKtph4iwkuBg57TLSH4mC7b1MJuNTI
         IKLfVR+twR99j+qPp/UlwVqzwhSaIlZidaBSDIEa8CdGI6AZD5khgev87Yt3tmrezuM8
         STNm2ImO3ViuXrkg7Wd9WVsMMwkHAdfr0nK6TCI+X7Ld7BePhRKwuZt4vwQwqEOwbRra
         bsUAeTjhC8Q1y928oHwStqftcapUyR04qWRhMTRQ4w9u0KniCOJdPJ+yt/VfQcIaIb/A
         h35g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786027380; x=1786632180; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=VPGAgS2JZJzV8gNCDCNJHdtMdpaoK15faH9rH5iP8NY=;
        b=glMtunpS6UqjI2WxMTPwbSgT+ZoP6F/HdobMp3fuLzNJCHsaFOorFGANZEeTQCPtvx
         uCns9dTjr+bb+r2pyXD1LHX2KrWBcgen9gu9zmQzXkXvhuXHHIuOHvSDe+MHh/bNGP8t
         ZoNflVNAsx9qe7ePFYLUBXNrIJ56ayT4N/T2rIe1EkAMavpPrLE4ejexKkbebM5GzUM8
         he8i8/1kfF9T2WLzMjXP32xYqbRWAV1DDAJsA9Otl7eZIDgT6fAB1Ih8uiNpo7eD26l0
         jNM331pNSINhFKOhKTysdTNkeq9bNB9JviiGfWJUIWZ5H72WHGas36Ez3vYdBfjO1r1F
         1pzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786027380; x=1786632180;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VPGAgS2JZJzV8gNCDCNJHdtMdpaoK15faH9rH5iP8NY=;
        b=micwh1vosFiOTP4mEFe+EHp+Hm+pTc6Nq90L2YwtcmpFYTLykTAMZetMl1vIfw2IR3
         k2ukreoW7fYceoYVI8D6aapWCFq5GVJ1THXQ+sRvarvHvJhNBIAztHgwQEvPARb9FjNT
         D5IZealL/hIlCHASFjaKZkWOZnPboE/YoRBM0zY6VXgMAsqHMbiRjEDrZgveyM5ak/XG
         jStrY2KYcGwSODCoJ7w74oweJWCZEzZkSUnXuiNdtx+q9lAF273wrntnS0ZPBGe34vN0
         4wiRqp+QCPrKJbWjjler1c3Nde5zqWgVoSdta51EXDnKo8f70jrq2cLuBnOVvQpcKWFL
         MpOw==
X-Forwarded-Encrypted: i=1; AHgh+Royxso1w2dQH26q/LIJRsf+N0pnbt7Fc3lfw3voQiYkPX/Fb63//wMln362+iaHoTLBo20=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbCRBQo9aYZbL2vs2B0agtavPQG2rdyhWXr4+wK06bxxKEh6gz
	Rj8ixWmqm8qjMvBzF8cSf1bApn6k9ZTYnMqftDrwucaoPT50unyBkPSlgooab7yZ15HclL0eA3c
	O6/pol5xhqwJOUque8WXq4Wg+4jvozIQ=
X-Gm-Gg: AR+sD10+wYWRHUYckrE/4iRXLCrfGGjRVxv7QqRtl9Z+oJ0HI/S5Q7cihJ0cw8EVaNE
	5NAjE3mKGbKAKP34MrzhKk4tKgJqx8rh69l50rQNEj+ud8tKqHCNL63rDVZ+b9yprdx8sHDdBdH
	WNnIxNOoIk4zDC2+Ng+BW/TwZYztY/FMD6YJ/pjkX36iuitJT/EdiJIsxPVtzoqVQUnteog2PXX
	Jvz+bhiAP4CW+um/xKpkg62EVfMLGXdpVB7n6036Y+/ZeR5tPR8BubHyWjfuqvkFi8JO5ftq1Iu
	v18WJOTRJzYFNJHJfY05diAApwBu4rTRUfMpUFpgrB0ODEdwkibdvuQZfSLf
X-Received: by 2002:a17:907:c00d:b0:c16:8799:fcb4 with SMTP id
 a640c23a62f3a-c2039dc55edmr813480466b.19.1786027379606; Thu, 06 Aug 2026
 07:42:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260806143924.319238-1-daniel@iogearbox.net> <20260806143924.319238-4-daniel@iogearbox.net>
In-Reply-To: <20260806143924.319238-4-daniel@iogearbox.net>
From: Puranjay Mohan <puranjay12@gmail.com>
Date: Thu, 6 Aug 2026 15:42:46 +0100
X-Gm-Features: AUfX_mw0FDWgEmoCjhyBQD4opK0xnJeB0WgEbtsqduGubaUfGd9lrLsNqip3Q8k
Message-ID: <CANk7y0hVZoGJRt=v=3499ALtJ5DnPA16OZYyEzBik=H-4G8+2g@mail.gmail.com>
Subject: Re: [PATCH bpf-next 4/6] bpf, arm64: Fix exception table metadata for
 arena load-acquire
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: memxor@gmail.com, eddyz87@gmail.com, info@starlabs.sg, bpf@vger.kernel.org, 
	Peilin Ye <yepeilin@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 6, 2026 at 3:39=E2=80=AFPM Daniel Borkmann <daniel@iogearbox.ne=
t> wrote:
>
> Same problem as on x86-64: add_exception_handler() decides whether an
> instruction is a load by its class, and a load-acquire is of BPF_STX
> class even though it reads from src_reg into dst_reg. As a result ...
>
>   if (BPF_CLASS(insn->code) !=3D BPF_LDX)
>           dst_reg =3D DONT_CLEAR;
>
> ... drops the register to clear, and ...
>
>   if (BPF_CLASS(insn->code) =3D=3D BPF_LDX)
>           arena_reg =3D bpf2a64[insn->src_reg];
>   else
>           arena_reg =3D bpf2a64[insn->dst_reg];
>
> ... hands ex_handler_bpf() the value register instead of the address
> register. A load-acquire from an arena pointer that faults on an
> unmapped page is therefore reported as a WRITE at a bogus address,
> and dst_reg keeps its previous value instead of being cleared to 0.
>
> Note that emit_atomic_ld_st() already picks src_reg as the address
> for BPF_LOAD_ACQ, so only the exception table metadata was out of sync
> with the emitted access.
>
> Same as on x86-64, use bpf_atomic_is_load_acq() so a load-acquire takes
> the load path.
>
> Fixes: 9bb12368d539 ("bpf, arm64: Support load-acquire and store-release =
instructions")
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> Cc: Peilin Ye <yepeilin@google.com>
> ---
>  arch/arm64/net/bpf_jit_comp.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.=
c
> index 4cdc7dfb05ba..d14d297ebb96 100644
> --- a/arch/arm64/net/bpf_jit_comp.c
> +++ b/arch/arm64/net/bpf_jit_comp.c
> @@ -1178,7 +1178,12 @@ static int add_exception_handler(const struct bpf_=
insn *insn,
>
>         ex->insn =3D ins_offset;
>
> -       if (BPF_CLASS(insn->code) !=3D BPF_LDX)
> +       /*
> +        * A load-acquire is of BPF_STX class, but reads from src_reg int=
o
> +        * dst_reg like a BPF_LDX does, hence it must not be treated as a=
 store
> +        * here.
> +        */
> +       if (BPF_CLASS(insn->code) !=3D BPF_LDX && !bpf_atomic_is_load_acq=
(insn))
>                 dst_reg =3D DONT_CLEAR;
>
>         ex->fixup =3D FIELD_PREP(BPF_FIXUP_REG_MASK, dst_reg);
> @@ -1193,7 +1198,7 @@ static int add_exception_handler(const struct bpf_i=
nsn *insn,
>                  * memory access. Pass the reg holding the unmodified 32-=
bit address to
>                  * ex_handler_bpf.
>                  */
> -               if (BPF_CLASS(insn->code) =3D=3D BPF_LDX)
> +               if (BPF_CLASS(insn->code) =3D=3D BPF_LDX || bpf_atomic_is=
_load_acq(insn))
>                         arena_reg =3D bpf2a64[insn->src_reg];
>                 else
>                         arena_reg =3D bpf2a64[insn->dst_reg];
> --
> 2.43.0
>

Thanks for fixing this.

Reviewed-by: Puranjay Mohan <puranjay@kernel.org>
