Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.51
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793025756;
	b=zKhnOe1tJV1CmhHCIr0iUQxwgFQpCv4FP2MufEyng/1PSdSkI/IDdgqPa296chtHa68l
	 WskOMn+J8GZjBuunzcC+WQ8ycOEfxVXE1LR32LlfUFFj4ExtXDJLZcNhTcoSh1HlV1lfX
	 hiYGaJjDcf38XlPcy7cfT+Lzsks9iKc5E0uQZPz2KnbXeaxNy3UaIwZ9VW/pupJ6CARp9
	 UuY5uvUjMIlL16bZ/IOPMFsQZ2gDxHD30zEGcRBqO9Xj4+ch1WhBOWf0FN2k6wf8iSg1W
	 O/swRRQMwd49YEo8zNYpkkYkR/0PT+Dgo+kWR029G3zvZbNwmKcP64O05hGIRmKLaLg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793025756;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=FiyIo88XtSCmKUOLGbnBLJ62ZVS25doiOE2fXhFGrhU=;
	b=fZR9NcJJaFLJIKx/CO6tn56tg3JTUvQCgoXGK6KUrXQCERFvOj1K42u7aSU6nh/Kly/o
	 R7SnmDZoJkA758aIU4El9/v8Wgf1GouvrhqoYln9Sbu/HgLzrFmcK2MeX1dxQbKPefOeq
	 9qxLBCjNn0hWGPSdYeja8yhUzWxnkkF46LO89vmFkV0I5XjzwnpqbSbr8PTLFfKDZh39x
	 OPtgrMlmBzs3s9dt/eGfsZ3WOQ9gEoR371vc/Zm3QCcVLAvUPzlsooL59Vu+hzxgPGnFx
	 hHXFl2vdrFJPFvNAkczSRJWpjntmbnlSQRGE1slr3Vb35k5y7gwi0TgLxKKM6Cx5uRA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=GKfIPL5Z;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.51
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C0FA606A31B
	for <bpf@vger.kernel.org>; Mon, 26 Oct 2026 14:42:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8C0FA606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=GKfIPL5Z
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-4932b13c4ccso1573690fac.3
        for <bpf@vger.kernel.org>; Mon, 26 Oct 2026 07:42:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793025755; cv=none;
        d=google.com; s=arc-20260327;
        b=polIPEASUX35sHDcIxzAeauIma0g+7/c7xq3ld7/jlWwj7AVhPz/xBiD7FH+57ba6X
         n//W5pnV3TlmZR4Bdtrw1oryPe3XXP/pmRGn/2UZSN1XhfuIX+kXXpjFNOlGALVmxb/C
         ZKQbjEnub71QGRHL6OTuo93iA5a3sFN72wReqth/a7uEHDfwKUR9ADe+h4xAyTJIYcpB
         BO2gHvso2Fc8wTb3yiFWBUYRUMZ76A+d8SO3iqGyy+boMuGcqGlfwlIx52TU7laEYTQA
         FjVT7s6xVg5bThbbSyQ1AGPhgu5+exQwnPRF7jevRhAJkYZSt1i/y/yilrkE82x0sXvF
         nj2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FiyIo88XtSCmKUOLGbnBLJ62ZVS25doiOE2fXhFGrhU=;
        fh=2EmlKVduRmi4yqT2S/lKwjmkU+P7llwggCKf9gY7GLk=;
        b=TRsE1lDH6c5lR+eOeE7kD1gDvMytcSw23Oa8ZRsifCEih2dqsMdAHQvFxcIqT5+waB
         YZ29JfC89C/GgerF5eb80BQhWrie+/a/qZ/KmfMKbLpZeyogycxOpWjXdWWGu7X4e0eH
         B43m6/VGjdysV23GrpodRsHIntCIEFMH96qnOwDkVoC1SNmsBIuXzR2am+nUndWulz58
         7kFWwt84oRj+XKESm7hTLTF9FZgyxQkUI+4M9A2bprTB9fCEJxUo0prbMDXdrrozJyqx
         Gi66/QHTeJEcsB51rRCoY71Wn7h2esC3Iks0FKUAod0JohBqxbcfEoewK7C7QzKEQrcO
         Td6g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793025755; x=1793630555; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FiyIo88XtSCmKUOLGbnBLJ62ZVS25doiOE2fXhFGrhU=;
        b=GKfIPL5ZKa6e9p2e9kBDTVAckDJTe/+XOPYoEiJxEQfZFvGSFjg1XEuIryHOB8e27W
         L7FfIWwQSWZSxteWjHhD8wAL6WkiqxJgMkaNVNjvGC4963SIIR7t66OaU2YNyxK+VJxR
         xH4vmsTmM1IJ8mXg6wjf/YYh1sMIkF+4iiYtxYswLUvogttdUY5CTfzBY/2Bpfbg/M5L
         4Jg4RqvkpcFddiL2TZLaekEEUVBbC3KBy0eoQZobK7Heag1Twk19EWRR6vUDN2LuOVai
         rP3DteeycAvBG4eA3MgJeEv/8JlXbnwsaZYgE/tPBK0PcQmTpiHBu52Q63LEZU7Svr1e
         D20w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793025755; x=1793630555;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FiyIo88XtSCmKUOLGbnBLJ62ZVS25doiOE2fXhFGrhU=;
        b=r/u2vKj2cnODTAtivF6q38s86jRxkt8BV8p2D2xYDMfpHqaVX3OdhkKwjtnJJBk1Kp
         7HXNJmz/UcTWT+Ay5ctPu4YO0Stk1yAyAiZ5cKnWa3y21S3BH98VTWO1mjibL8qWkJ8z
         Jdad0aHuDmS94raxHFh7Xi1FrRIAqDYxjFRS0dwTRgrNhNucDgv8i4pLWo01w66QXF7W
         LxWACeTvkWsfAvsr/UxAbyz0+FfTOBOqfClfRujhsDmfgWN0Y9nY2xJiKVKxmXmygvFS
         TAFTKDbxpSmT13Htu6GXyXKIho/r4MQiV7zEyMNuDFKVjEHbQRh4FceIkFvRREfkgkR+
         0XLA==
X-Forwarded-Encrypted: i=1; AKwUvBzq1DE/BRDFFo1dyLQ5UCqCbfb36IIeqvDotOUlfKyXw3W1tn8vt3/PzVmnYZmfUUuuXP8=@vger.kernel.org
X-Gm-Message-State: AFq9FYK/BErry2T7YV/x1sTfVpDGH2gQ3dvI+/8ez7CsGD0RiSmYaZf4
	zw8XZPBda7RD+8GtDckBP8zok56nDFW5SflLmzYK0hNwxpkVV43wGtYrqP2A6NP152e+p8L+zVK
	qmE2p4b3gUuXCg6NEHS2D+0GYQEZsTGg=
X-Gm-Gg: AYBFou3mliGScVptCRMN2rafNH58oGOMtOBBEuv/K/MmudJL5tageBnf5shMobTYhIM
	ktJmMYoB1vHKS7aTxlr9C9BB9UVoSAso2H6K9zw+uZ5k0GXwcFkKX9gU/4l3G2dwSEz5zH/6c0f
	9GGH3zw0jEehwamZRJ0wWrcLt59NOAVo0EW9rTb4pi2NefPx1vrcCkjCWGj3TUJ6yvOn04ARoJA
	BCjr8XKnfpIWf5+6DCnFSQMldpwX/QBgPnlwQ1taMmRSXO3YvYfpOG6iJm86GS16LDafyYEk3Ky
	nR6kp8T1US0URk3Kfopt7DgDRBjRRZ2CVzzEPZ6zmrdYYqaROzSViSrwgPB1bG+7UsjaQvKKEHm
	0jdiAcKYwh7lckpLoallSVdKbb+OyjQVBKfVM3g==
X-Received: by 2002:a05:6871:73a2:b0:491:4a20:8ab8 with SMTP id
 586e51a60fabf-4a83f53b47amr3712608fac.28.1793025755162; Mon, 26 Oct 2026
 07:42:35 -0700 (PDT)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261019013335.13512-1-yangtiezhu@loongson.cn>
In-Reply-To: <20261019013335.13512-1-yangtiezhu@loongson.cn>
From: Hengqi Chen <hengqi.chen@gmail.com>
Date: Mon, 26 Oct 2026 22:42:24 +0800
X-Gm-Features: AclHuK9VfDqy3TFsNraLnkzPJtLGJTrw97NH5dTf1M621wbyFJ758LDBDfZcRk0
Message-ID: <CAEyhmHQhi6rgxXEvg6aCA=5XUVBSUpBUbFrjSyJDoD_bz5dDLw@mail.gmail.com>
Subject: Re: [PATCH v3] LoongArch: BPF: Fix stack arguments for indirect trampolines
To: Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: Huacai Chen <chenhuacai@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, loongarch@lists.linux.dev, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 19, 2026 at 9:33=E2=80=AFAM Tiezhu Yang <yangtiezhu@loongson.cn=
> wrote:
>
> From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
>
> LoongArch passes arguments beyond a0-a7 at the caller stack pointer. The
> trampoline store_args() helper always reads those arguments at FP + 16,
> which is correct for a regular fentry trampoline: its prologue leaves FP
> 16 bytes below the stack pointer at trampoline entry to hold the saved
> RA/FP frame record of the parent function.
>
> A struct_ops indirect trampoline is entered through a function pointer an=
d
> only saves its own RA and FP before setting FP to the entry stack pointer=
.
> Its stack arguments therefore start at FP, not FP + 16. As a result, ever=
y
> stack-passed struct_ops argument is currently read two slots late.
>
> Select the source offset based on whether the trampoline is indirect. Thi=
s
> also prepares the stack-passed arena argument path to consume the actual
> pointer slot.
>
> With this patch, the BPF selftest "./test_progs -t struct_ops_multi_args"
> passed on LoongArch.
>
> Fixes: c9ebe2016de9 ("LoongArch: BPF: Support up to 12 function arguments=
 for trampoline")
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> ---

Acked-by: Hengqi Chen <hengqi.chen@gmail.com>

> v3:
>   - Reword the log and comment to clarify that the 16-byte frame record
>     is saved for the parent function, not the traced function. (bot+bpf-c=
i)
>   - Remove a stray blank line after the opening brace of store_args(). (b=
ot+bpf-ci)
>   - Reorder the comment sentences to match the true/false branches of
>     is_struct_ops for better readability.
>
> Here is the original link:
> https://lore.kernel.org/bpf/20260821233516.3426127-8-memxor@gmail.com/
>
> This version is based on the series:
> https://lore.kernel.org/loongarch/20261016081006.26069-1-yangtiezhu@loong=
son.cn/
>
>  arch/loongarch/net/bpf_jit.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
>
> diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
> index 1a7c8effc37b..c6784602f029 100644
> --- a/arch/loongarch/net/bpf_jit.c
> +++ b/arch/loongarch/net/bpf_jit.c
> @@ -1725,17 +1725,22 @@ int bpf_arch_text_invalidate(void *dst, size_t le=
n)
>         return ret;
>  }
>
> -static void store_args(struct jit_ctx *ctx, int nr_arg_slots, int args_o=
ff)
> +static void store_args(struct jit_ctx *ctx, int nr_arg_slots, int args_o=
ff, bool is_struct_ops)
>  {
> +       /*
> +        * Indirect struct_ops trampolines place incoming stack arguments=
 directly at FP.
> +        * Regular fentry trampolines need to skip the 16-byte RA/FP fram=
e record saved
> +        * for the parent function.
> +        */
> +       int stack_args_off =3D is_struct_ops ? 0 : 16;
>         int i;
>
>         for (i =3D 0; i < nr_arg_slots; i++) {
>                 if (i < LOONGARCH_MAX_REG_ARGS)
>                         emit_insn(ctx, std, LOONGARCH_GPR_A0 + i, LOONGAR=
CH_GPR_FP, -args_off);
>                 else {
> -                       /* Skip slots for T0 and FP of traced function */
>                         emit_insn(ctx, ldd, LOONGARCH_GPR_T1, LOONGARCH_G=
PR_FP,
> -                                 16 + (i - LOONGARCH_MAX_REG_ARGS) * 8);
> +                                 stack_args_off + (i - LOONGARCH_MAX_REG=
_ARGS) * 8);
>                         emit_insn(ctx, std, LOONGARCH_GPR_T1, LOONGARCH_G=
PR_FP, -args_off);
>                 }
>                 args_off -=3D 8;
> @@ -2068,7 +2073,7 @@ static int __arch_prepare_bpf_trampoline(struct jit=
_ctx *ctx, struct bpf_tramp_i
>         func_meta =3D nr_arg_slots;
>         emit_store_stack_imm64(ctx, LOONGARCH_GPR_T1, -func_meta_off, fun=
c_meta);
>
> -       store_args(ctx, nr_arg_slots, args_off);
> +       store_args(ctx, nr_arg_slots, args_off, is_struct_ops);
>
>         if (bpf_fsession_cnt(tnodes)) {
>                 /* clear all session cookies' value */
> --
> 2.42.0
>
