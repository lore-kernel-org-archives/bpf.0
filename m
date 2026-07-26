Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93E6035DA75
	for <bpf@vger.kernel.org>; Sun, 26 Jul 2026 08:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785054941; cv=pass; b=eCjURmcKbrzLqA+Lail+eHJbDZJRuDIZKiu+NqQK/I1q4hWKBJRTM94+Wx29u0sGsu9erduv1xOid4hJIw5255H0VDG6YcYJ2HTOFbXOUDqYarqN7HD2FH7xfRMicgLx56H9dImbixn2bqNl8NW+MpGnuPvMO0uazIk+++Jqibs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785054941; c=relaxed/simple;
	bh=EnfebP7aMNSbdO8NGq9HNoA4RZgiWY81yTFuZlrrUpk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d+JJzWnW/toRBk2maNzqv3iMU2q7nXKgVznIJvgw9S1t1AeP5VohWF4vXmf+TAt42ZoKcuWxtQG6c3qU/ZiOgaZGRpgZhQpQ1gantuYW2Puo4gB1MrxJSX+5xo5gZxaI1/VpMmF7SEX0+Bd2yH5T1sfluk+M0cQxDfR+SXVrC+w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=p2/R5syx; arc=pass smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p2/R5syx"
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-6aae5eb0ee0so551752eaf.3
        for <bpf@vger.kernel.org>; Sun, 26 Jul 2026 01:35:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785054938; cv=none;
        d=google.com; s=arc-20260327;
        b=mtfZjJrD+AkbkpVspgKqmVhYoo4EK6CKKXemMEdFtwFp/2ly3URZjdJ73Yzt2LT4P4
         fs/jdexY7Vh2+SGq6HsC7TpTKGqdI93tdkQs5VcCOv5ZnJlpwQ6NgHKe7monMIwtFUWy
         TugslgskYRP+61MAPrvSuCF7IwH5WH1rtS1x5m9fZzu+rbCH93DVYzHk+KmkfbpWuMCV
         KOkJldCfISTwnIV4i2+W0VXYTuNV6H2hX6n369rJ/1L55ZlpAer3JiHsG4rWxFah8X9M
         qa9b9AoeI7hN3VC0kZZnFN3hnQNfd4qH4FFT0lpedXqvguyM0tQjgR2LM1W44Hbrf4hL
         oJ0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BKmJvDliVsXRF7emQ91eKD3KWYQQya1Q0B4Yo1eQGYY=;
        fh=TOpSx2aBz6hdwsD/3qdxo/uQFtDNAi62mJDP8E08aQs=;
        b=PlKiJKYe0pytM9E7CSKidSgXnymYLUVfiGSfYuwX0nn+e2b1esODgeg5OrpWKehjLC
         q5J0A+CZHM8cr462eojP+z4hMgAu9eLSPMC8buKUiaiTuPeA/kSVmZiwAyu5ykr8SueK
         /EUbnQd879X81Ee8O8gjXZMOaCrMCuhS9PMGMxH4MUz3h8AM3sdK42QhqtOkvU0PK/nT
         Hxk2+cTqI8zqWQkx1KdicnSSfc7YdiBXR3ZV8hMbwrJ3no5NH+MfD0Dk14dCPNS8Eh8+
         msg41DFLlAxk1NWB+F0qOw435OLrJRxHy6Q0gH5ofqE6YzVbrol41IyVihRhiSHM6v2e
         no4g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785054938; x=1785659738; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BKmJvDliVsXRF7emQ91eKD3KWYQQya1Q0B4Yo1eQGYY=;
        b=p2/R5syxCmD5bSnW3UhoEXPZffXrlgcGwWM1BHwkaX8X8uHdrUJD2bYd9/fyDBE00O
         UdAPDpYx3KD7i4UnHLip+WHVq1eZSQT5Hr6Z7CbZxcrZLUAMExTzs6LqKzlnjTsyYylo
         uTNAoQvJnwlR/Pf3fbAaSn27FhX2rUKVHzix24HFO7NnxvSVIpDxSx2Phk/0oTUMCnxv
         +iVV7oSexR7/a/oKgaIOriP4zw5UgEQnG4H8Zww/cvKTqlbuRcVOWUNHk3ocazcsf4Xp
         CKwoGIhDFbOvJ1haq99YZmjQPOhGZevDi+jif2nI92lnLSK0x4NHRoJbFFJ0C8DpFGrg
         QDNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785054938; x=1785659738;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BKmJvDliVsXRF7emQ91eKD3KWYQQya1Q0B4Yo1eQGYY=;
        b=qUgH1IAu1yaiKfCNpJ7VbK+a00svtFDupEvT2su2JMSnDFnvkGavTeJs6JEbTIA7L5
         yeaBX5KGWhazVag21sWyUSfrnoi3VPS2er6mmzRyUcRdMVMYqS5WWEKNjKmdUP72UAh1
         bghIisTK+VES3D+J0vxnamjVjBmQIbukyNkzlge30vlgcyLxRNWB7eMpajDUMHy5VTdJ
         iG/Idxe9u3phL3QQttpLU3jkHrmJyoQpNMWby6B3Ej/FbaEEkJ4FeW0h6UALbaRDyEGk
         vL+HauOXf2rVzu6ORn7ClaTzTjasq+M4oFJNUrHtfyLP2VArpVaDluaGujCXUhyH22cQ
         ZNRQ==
X-Forwarded-Encrypted: i=1; AHgh+RqbDdQzPHD08PyLXmxb/PhNZiKkJEzG8AtZDfOjHYKDnLGjBAroH6LL4D1uNkCQ0t1DC7k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9/RBhFSzh8c2JSvCGvZ5UZHE/phsCciYDW0tn2EWVpxBVO+Ur
	wngKFMC0720nuj4fd+pfRa4xpvebH3Sf8CE8/RrG5TFBCCKuvE0ZLER/GGh6YxT3FZspnkqfcBm
	izBN5NGsuAuK40qjNIIr7DrSacOV82O4=
X-Gm-Gg: AR+sD10lCeu6SZahFc5zFmJuzf3+dJZ5ogdrva0O/UcaPJoqVV622ZMp7h4J2NqaFT6
	SRUajC7ZTE4Hvs7kiIuVG0JX3w7KDqYU/GO55yW0I3GwqLDgEfXDizWSrSWr1SghcZxAe9dFqZK
	tAEQAiP+n3YlhSU0iCJLjo9lmJt+Hm64wBP/xs6yu2fD5b//WYinpUExEx1K51PWE/aD6w7Y3fe
	bdkPA5s8JpKUVct9dvbCFBRWXLTZ6LsYqxCK093cRmQ+/uCxjkK8jvh/4U01xU=
X-Received: by 2002:a05:6870:c2a8:b0:456:d0c5:5d13 with SMTP id
 586e51a60fabf-457f26ee4demr4248713fac.27.1785054938369; Sun, 26 Jul 2026
 01:35:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260711100956.4351-1-yangtiezhu@loongson.cn> <20260711100956.4351-2-yangtiezhu@loongson.cn>
In-Reply-To: <20260711100956.4351-2-yangtiezhu@loongson.cn>
From: Hengqi Chen <hengqi.chen@gmail.com>
Date: Sun, 26 Jul 2026 16:35:27 +0800
X-Gm-Features: AUfX_mxMpmApX6zp4Hr8BZQo-e-RR8udWaFtTKur81x4KQBBrXXPTnGzNOgdLls
Message-ID: <CAEyhmHRFRTyV=HoRDKz7KzdGUQdg=KkbpHmkauEEKBB6AvdnPA@mail.gmail.com>
Subject: Re: [PATCH v1 1/3] LoongArch: BPF: Remove redundant zext jumping in move_imm()
To: Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: Huacai Chen <chenhuacai@kernel.org>, loongarch@lists.linux.dev, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 11, 2026 at 6:10=E2=80=AFPM Tiezhu Yang <yangtiezhu@loongson.cn=
> wrote:
>
> In move_imm(), when an immediate hits the 12-bit unsigned range, an
> `ori rd, $zero, imm` instruction is emitted.
>
> According to the manual, the ori instruction inherently performs a
> logical or with zero-extended immediate operands against $zero, so
> the upper 32 bits of the destination register `rd` are already 0.
>

It would be great to add a link to the doc:
  https://loongson.github.io/LoongArch-Documentation/LoongArch-Vol1-EN.html=
#_andi_ori_xori

> However, the existing JIT code unconditionally executes `goto zext;`
> after ori, forcing it to fallthrough into `emit_zext_32()` to clear
> the upper 32 bits for 32-bit ALU operations.
>
> Fix this redundancy by directly returning from the function inside
> the `is_unsigned_imm12` block.
>
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> ---
>  arch/loongarch/net/bpf_jit.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/loongarch/net/bpf_jit.h b/arch/loongarch/net/bpf_jit.h
> index a8e29be35fa8..bb58c42c2f2a 100644
> --- a/arch/loongarch/net/bpf_jit.h
> +++ b/arch/loongarch/net/bpf_jit.h
> @@ -156,7 +156,7 @@ static inline void move_imm(struct jit_ctx *ctx, enum=
 loongarch_gpr rd, long imm
>         /* ori rd, $zero, imm_11_0 */
>         if (is_unsigned_imm12(imm)) {
>                 emit_insn(ctx, ori, rd, LOONGARCH_GPR_ZERO, imm);
> -               goto zext;
> +               return;
>         }
>
>         /* lu52id rd, $zero, imm_63_52 */
> --

Acked-by: Hengqi Chen <hengqi.chen@gmail.com>

> 2.42.0
>
