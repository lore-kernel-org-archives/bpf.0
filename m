Received: from mail-wm2-f9.google.com (mail-wm2-f9.google.com [74.125.225.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 547279460
	for <bpf@vger.kernel.org>; Sun, 26 Jul 2026 02:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785031562; cv=none; b=tedcmjHVsAwBgqMK4Vb5lji0av1GEM4xjDQYY289F0qigcxmTgk4ypocO/uC32ml2QqMxEGkA4ZoVNHS1M8IkTEol8ziiIhY5HSTN1D2Au+5Sfa/JciFHRcSlfTUwjAiH6yN1lGGFkNjinY18NfsJYWecrcIELZotHffzDZY4s0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785031562; c=relaxed/simple;
	bh=sN4RbrModujGLKTBVjG0end3RnEdzfJOGujmwjCeq5g=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=q3SR5ppqfBCZifRHqIL91ksSsnKjZL4tdGC9CiJqT5ejSKroeStHvflh8myulBkqOBGL2R2GpU3joXU1oWJUJ8PNw0ESQ/bhiw2H0y/5kdmLsf2h/9PK9WtqcD0AwmMzuofMRIZPia40tdVOoeWgStPzmc/9XJb4z5Ct2+YArIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZBP6kgJb; arc=none smtp.client-ip=74.125.225.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZBP6kgJb"
Received: by mail-wm2-f9.google.com with SMTP id 5b1f17b1804b1-493e55619a2so5580355e9.1
        for <bpf@vger.kernel.org>; Sat, 25 Jul 2026 19:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785031559; x=1785636359; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=+2CWXHagWnojowIm/br50AnM1vZRtkEZ6hP9eHXWtFg=;
        b=ZBP6kgJb8kYmCIvdfa2vUTAhogWMnL3GZTISr/zxPKQf3M/xT8aqyv49+N8QE4akIF
         kF8J+Qb8wq7Abo2W8NTwn0Gkcorgl1m6dN/nhiSJecvJXo3x3LOSd4iL2mcTcQUHR11e
         OwVpYNKj/Xgl/DmpPIST2LWY217P5KbyMZ2m0LAiTwDm095uytjabSSQEwvln11NCCv1
         XzDWq969Dek7XtOPZDEIsn+nb5FnNkymsg5kKSb51aF5peupuNJUUMuJPOmojZ+gnxvI
         dzodkG7R2Dy5lrpiXG1iZA/1lmDoWn8Fu+Hm7MuBfIoWq1e3RpwKCUPqcLrRFBNJ/bvH
         NC4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785031559; x=1785636359;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+2CWXHagWnojowIm/br50AnM1vZRtkEZ6hP9eHXWtFg=;
        b=R2yuCS3Lv2YgmNbVt6eT11upcQaY2nlaqusXsSVeK5u2jNsmPg24Ih2kMHLapjPa4l
         2jIGIhJEAmGpRSZvuN2QJw//T122zVeoRoL5WdQjdvyG8rGV/+2Ffh86thhIITRwnOUA
         +nFA+/drU7qmGX+IBLkr9LOv6i2v7LNdHxbiNIuW2T9zesC+CdddnfUxyKAccuXvCxnD
         lT1HAeJt7BYqVYEhwR/vjRUS+2okzx2YAzgIApTHSKjjRiP0+HHQ+mpNIDxuFDziY5EA
         93WTi2O1KOPCZErHE6WciwCTyXuDVyY9+EqAN78PsXrHnhwdVZmvzBQo58Y72Biwo7p/
         F2xg==
X-Gm-Message-State: AOJu0Ywvvb0r/a/nyrNMyMkbJUkE8bufvr4Fb5VVWWw6IyGlSdg61thO
	tcx8S/hPPWbair835UpO4iW5bxxI2q8eJCOM+nAWvQpICIDNzKEQQpBv
X-Gm-Gg: AR+sD10qx5Z84JAkiq1JyEP2X0KOFoO9/vG5Eu8T9ZMJTF44dgdx8Berv4fsTbqSzrq
	tCu1q1PVeQTZxsKgCOepeBWfAQudqX0exc+MTopB3jjYwuDeA0/xb8szPkYREqhZke5TM2IiBEF
	XHjrlnQICynFWfCGZ+f5ckrVnrjpzGXbtSJvKHlOBzjWB4nAhuqe2itz/JqlEXqVll7Ca6DJsoz
	v/dWmiZD692skx58ye1+v4tgeEqInJWKngf1gpG4rJQKcdVR3RBUBr0ZHeepVTsD9SERk2l6OkM
	heG76glVR/hstF8U/fAvdKx3EP2+vHyfmDoraOx9cBsgm/Anow7ldWgyeolwGlbfMtgMUUayCFM
	B9f+1l6SoP1+5+nPxHoUYZleiqBNdtUovFvlnDrXVCFEmf9Z2lcpE6wQqF/8X5HJysYXpqaVMKw
	EKOM0oT8sj0p6GiwjhQgqXxq0fWbifobtXgaTyuhDZOmDXgkvrt/fBtxGvjb/7Hr2AlXseJEwLV
	7cBSo1Yw1taPSsRiGwSg9tj90K3stb6628mV3bB3ANS
X-Received: by 2002:a05:6000:40cf:b0:47f:77dc:b072 with SMTP id ffacd0b85a97d-47f9fc8fc9fmr5707559f8f.18.1785031559439;
        Sat, 25 Jul 2026 19:05:59 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85c532d4sm35234534f8f.22.2026.07.25.19.05.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jul 2026 19:05:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 26 Jul 2026 04:05:58 +0200
Message-Id: <DK84VLH9CPHS.1824I69UOMUTQ@gmail.com>
Cc: <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf-next v2 8/9] bpf, x86: Fix stack-passed arguments
 for indirect trampolines
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: <sashiko-reviews@lists.linux.dev>
X-Mailer: aerc 0.21.0
References: <20260726013105.3689867-1-memxor@gmail.com>
 <20260726013105.3689867-9-memxor@gmail.com>
 <20260726015112.7CACC1F000E9@smtp.kernel.org>
In-Reply-To: <20260726015112.7CACC1F000E9@smtp.kernel.org>

On Sun Jul 26, 2026 at 3:51 AM CEST, sashiko-bot wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
>
> Pre-existing issues:
> - [High] The patch fixes the stack-passed argument offset for indirect st=
ruct_ops trampolines on x86, but leaves the exact same logical bug unfixed =
in the ARM64, RISC-V, and LoongArch BPF JIT compilers.
> --
>
> --- Patch [8]: [PATCH bpf-next v2 8/9] bpf, x86: Fix stack-passed argumen=
ts for indirect trampolines ---
> commit 1625042935fc87b38acf83c8304433545d672f35
> Author: Tejun Heo <tj@kernel.org>
>
> bpf, x86: Fix stack-passed arguments for indirect trampolines
>
> This patch fixes the calculation of stack-passed arguments for indirect
> trampolines in the x86 BPF JIT compiler. It introduces stack_args_off
> to properly handle the number of return addresses on the stack depending
> on how the trampoline was called.
>
>> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
>> index dfb5335ad8374..4b349ae35ebf9 100644
>> --- a/arch/x86/net/bpf_jit_comp.c
>> +++ b/arch/x86/net/bpf_jit_comp.c
>> @@ -3075,6 +3075,7 @@ static void save_args(const struct btf_func_model =
*m, u8 **prog,
>>  {
>>  	int arg_regs, first_off =3D 0, nr_regs =3D 0, nr_stack_slots =3D 0;
>>  	bool use_jmp =3D bpf_trampoline_use_jmp(flags);
>> +	int stack_args_off =3D (use_jmp || (flags & BPF_TRAMP_F_INDIRECT)) ? 1=
6 : 24;
>
> [Severity: High]
> This is a pre-existing issue, but does this same logical bug need to be f=
ixed
> for ARM64, RISC-V, and LoongArch?
>
> Looking at arch/arm64/net/bpf_jit_comp.c:save_args(), there is a hardcode=
d
> offset that unconditionally assumes two frames were pushed:
>
>     soff =3D 32; /* on stack arguments start from FP + 32 */
>
> Similarly, in arch/riscv/net/bpf_jit_comp64.c:store_args(), there is a
> hardcoded offset of 16 which skips the first 16 bytes of caller arguments=
 for
> struct_ops:
>
>     emit_ld(RV_REG_T1, 16 + (i - RV_MAX_REG_ARGS) * 8, RV_REG_FP, ctx);
>
> And arch/loongarch/net/bpf_jit.c:store_args() shares the same hardcoded o=
ffset:
>
>     emit_insn(ctx, ldd, LOONGARCH_GPR_T1, LOONGARCH_GPR_FP,
>                   16 + (i - LOONGARCH_MAX_REG_ARGS) * 8);
>
> If a struct_ops callback with more than 8 arguments (or 6 on some
> architectures) is executed on these platforms, could it receive out-of-bo=
unds
> stack memory instead of the actual arguments?
>

Will be followed up on separately for each arch.

>>  	int i, j, slot =3D 0;
>>
>>  	/* Store function arguments to stack.
> [ ... ]

