Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6651A311969
	for <bpf@vger.kernel.org>; Sun, 26 Jul 2026 08:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785055020; cv=pass; b=LhTumEbtYQx+e0aTPEMGi40Go33B2J5J3JoxDSRUb4Q8KA1kr4ZAKaWTpltww3GC9qfckocEGSJDMTuQpif+RAjzyfoFoEEOGVsKBYv8NhcLM/II29jYtLpWFTpA4QQJcVZhgcetzqUPITcMhckjX2q6of3obei4oKXZN4Y07sM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785055020; c=relaxed/simple;
	bh=rmn2ecOhRTLO6zZsFLG40KuuGj21KujR3dAxEkWkneo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LOGwdM2kQQBaiKE7m91U1MWAsZb/a55ikLNMSx3wQZcqj5VfWdwnjuaiNaaMSW7HbgUbiWI1nCZYnP/6zkz5H4goc3fNYZrwanmjwEvquVN89DNUjxh0MRR2fRApBLZ7QWqSp+NYWFrhgKJmJ1koMqesNlFHfuela3WUn5V3Hbc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cgf/Chkf; arc=pass smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cgf/Chkf"
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-43b7e186a0cso676345fac.0
        for <bpf@vger.kernel.org>; Sun, 26 Jul 2026 01:36:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785055018; cv=none;
        d=google.com; s=arc-20260327;
        b=Fq0OoUlGng+g6choUlgu3Npgur1E/bl8LD82kp5Gsjcn338weHwa+8eFP8xXl55Mq0
         pqhb5RgfoX/mqOSjPojSDqgyodS+mHAbo5GO9TvfILn8vY9fNJd0BGZkYSWQdbYoVV9I
         VPJ4d7p44np5lijMOXRq+4icQnikeyr1OaOMl9dVPXuecNwDCv3CZWVthDGc/N/2YLdu
         MqjIEGbUCz1+N6cRzFP2dkbZo5J2idVjNHY/cC3pWga+4M28ZK8Raf4UF1OxsiECzSML
         f20gqBqYmVoI/aGg/y4ksVoi243NU8HvmFc9sQjpKOHL2Qk+scrfqaNHLeRQsaBLTXJm
         Z8NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3r5rSuJa2Lzq0CYs5fizgtYeBwnpeKSHwMn5ylN1Tng=;
        fh=ztyCCUnjt6QBtaeXlpUgcxQmfR3gs42SB2fEbMjY7nM=;
        b=WVxVL4mV5XNWzU1JZHtuEMyVGrjWiUv2FHa7OWIfYsVMSEncb49B64ps2m9ubBeyCY
         yDbjNz/6KhS+u0kMJjX4tNtKMhp2IYmGyAn2Rju8/m4CJ7nfLRA+XtrfSUDhvCxLn262
         DK882Paxh9o/5ezbw4/nMAM8Wwgx6KpGL94u/w51zngWgE8sM94uIvd2n/zdbsNnNSok
         739uHWC9HJAWqXhC9vpJKTTlVNEAnX8OzKQ9b3ALQk8Hi5PBpChW2E8IMY/LxNQAOFWT
         LCfyzdK1iOPW6LLlV+DMQ6+5v/jiDpuTr/HZnu9ZoAL3iIIVS1LfdVlgZE75bQa/Vl7J
         gZHA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785055018; x=1785659818; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3r5rSuJa2Lzq0CYs5fizgtYeBwnpeKSHwMn5ylN1Tng=;
        b=Cgf/Chkfrln5oTtrd795puiIanjQjB15zc5shLna7QuUpTup92PnoNJR2sipBwWsQt
         6buBpdVOGx/g7i1CK92vQR0gI4J4ASUNed6L/XL0MH/+cmGTb5Mfqv3RwRP6xQ2MmXEN
         snkpOpGcZJTcHe8RUCUag8zFT/+TYh2cWEqjFaBSW+4XEqgWPXs5poezb33DpHgI73L8
         6zmRQW4WJ9r3CgUsrO4YMgskpY544oCsoQSg7eqOyfhQVAl3yaYAYXG8DdbMvcYcZssk
         cHwwFmQms64NRKJDCxUxpkfbvkKdhc09nGMbG+ge8rAeq3qIeZdzaQGnbL6PsnyLGcC4
         UV5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785055018; x=1785659818;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3r5rSuJa2Lzq0CYs5fizgtYeBwnpeKSHwMn5ylN1Tng=;
        b=HuPe1qjVeWXPBMiiYdzp6EfL5J3JZF05B/LKPyv1B42B/c2HSQXRVwwt6Z12lgpOkM
         eKLZF1nEYQmhicq/l0IOSKGDW8dq3XO3SLjkVSJmR8VVTt7g+xYuwJGeWlI9Le8uNH9z
         6DtavFSEwF+/UZxKobrl9r5tHmUwp0KGp6KyeCAOw8d7jVuo1cBGtMrBDnl8L1PocI9r
         iVB/R1JByJF03dcV2X59/KKi1kMMie0JRnXPrE5X4s7NB9VBXgcL7sV5NJpn5wOuJKPp
         mv1K91MaJf1zwsQU9NaLK2bFwlRfa76jWRE7pG96SkncJjcE3dw3eK0yM7mysBROBxWM
         FATw==
X-Forwarded-Encrypted: i=1; AHgh+RrWj1lUG4eh49OXxzCGNtENQDeetlIdRSIdwkkXQZA2B58F9pyx9AsT6QYTM0y+sW7SPKY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNlClak75okfp5dw6WISEk61wyEJXwZ/yRaXhFB7ghRH9Jk7oR
	5tQ0+/QyrzTA1KWEeub4I+U78AsDCj+qcmhI3zaX+hhXlCYvKRfKK7DD43koaDAfp594UpeTT/c
	SfzyUZdEIyttsTO0uAC41jYiBUBRv1+o=
X-Gm-Gg: AR+sD11W4V8vYVQxCtDx48fpEIAZlaiNCNsujtQmCuAAwcHCzRiIQX1RVU+BbCWcWfT
	J9fxlo4Wbfs0fM1vxvseFMkWt/AQUkG08Ea1ly60xX4VOK6yp0xy5aYCu3DxN5sbG0fVs5s9iSs
	p2Ikup3AO7wpnxNlQMoH8/UkudnZ5IX68VMq9t3uQmAkfBATyxxN6PUqho3ihUJA/pGQAeQ0W10
	h0kNDNOwG0U+xbcSO57kDWNvpHt4faN4EKgpcFjbno2fPbyOVpRKucbSfZbPVE=
X-Received: by 2002:a05:6820:f013:b0:6aa:ff23:190 with SMTP id
 006d021491bc7-6aaffb13b8dmr3261108eaf.51.1785055018285; Sun, 26 Jul 2026
 01:36:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260711100956.4351-1-yangtiezhu@loongson.cn> <20260711100956.4351-3-yangtiezhu@loongson.cn>
In-Reply-To: <20260711100956.4351-3-yangtiezhu@loongson.cn>
From: Hengqi Chen <hengqi.chen@gmail.com>
Date: Sun, 26 Jul 2026 16:36:47 +0800
X-Gm-Features: AUfX_mxocj0yJ8qj0TxOQ3B1mc7jK5ZzM6dkY3EPo74I1cqQZ8PLkCG9BI5Rnoc
Message-ID: <CAEyhmHRcGHgG5Xyd7hDzUpwTwNKDKcwsABcEZ5TH5xaKAzmabw@mail.gmail.com>
Subject: Re: [PATCH v1 2/3] LoongArch: BPF: Remove dead move_imm() call in
 BPF_NEG path
To: Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: Huacai Chen <chenhuacai@kernel.org>, loongarch@lists.linux.dev, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 11, 2026 at 6:10=E2=80=AFPM Tiezhu Yang <yangtiezhu@loongson.cn=
> wrote:
>
> The BPF_NEG operation is a unary operator that performs `dst =3D -dst`.
> The current code unconditionally executes a move_imm() call before the
> subtraction, generating useless JITted instructions to load data into
> the temporary register `t1`. This `t1` register is never used anywhere
> else in the entire BPF_NEG path.
>
> Remove this dead `move_imm()` call to avoid useless instructions.
>
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> ---
>  arch/loongarch/net/bpf_jit.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
> index 2738b4db1165..5f32b205a6ac 100644
> --- a/arch/loongarch/net/bpf_jit.c
> +++ b/arch/loongarch/net/bpf_jit.c
> @@ -894,7 +894,6 @@ static int build_insn(const struct bpf_insn *insn, st=
ruct jit_ctx *ctx, bool ext
>         /* dst =3D -dst */
>         case BPF_ALU | BPF_NEG:
>         case BPF_ALU64 | BPF_NEG:
> -               move_imm(ctx, t1, imm, is32);
>                 emit_insn(ctx, subd, dst, LOONGARCH_GPR_ZERO, dst);
>                 emit_zext_32(ctx, dst, is32);
>                 break;
> --

Acked-by: Hengqi Chen <hengqi.chen@gmail.com>

> 2.42.0
>
