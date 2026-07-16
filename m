Received: from mail-wm2-f0.google.com (mail-wm2-f0.google.com [74.125.225.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9643F41A57C
	for <bpf@vger.kernel.org>; Thu, 16 Jul 2026 11:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784201566; cv=none; b=tcJhnTMF2fR2lcPwtnI9uoJ0puKFPzWQ+jszQno7yp0Xn5HPWH2VZrA9mcb8NRJL5bvekvkOpb3WsFD+ia4l1/oav2vWI24FGhlR0RQ4oN06iLfksX7hdQMFfX/NHAghWDeGZwrMQK9+4bGc2CvDdq6ZM6m7qD2MVNV+3Rj0qQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784201566; c=relaxed/simple;
	bh=YZKBbW2GomCys1dMhNIiGDO21zwKxj5N/Rh2Z2W9Znk=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=p2bZZQ2vl3HivmklmMQAxKtM51jZN5No/V6rij2JT7Bq8r+NYl3MkISWMKDTjQEckBe6UeCVxHTYNZqnN2vcvZzK2Rxib3yBY9Y9h4No3wieAl3YIQf07gC1KQAOQV11Ue26DYGbVZE35jdlHjGjMbZNYuhUOCYAtWuq42GyDA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fO9ho2AZ; arc=none smtp.client-ip=74.125.225.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fO9ho2AZ"
Received: by mail-wm2-f0.google.com with SMTP id 5b1f17b1804b1-493b4d3a635so15052345e9.0
        for <bpf@vger.kernel.org>; Thu, 16 Jul 2026 04:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784201563; x=1784806363; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=nQFV6uTevVnEZyY/RP6SSrTntWr7oAjSimUXIkwaAKQ=;
        b=fO9ho2AZoxLV9iDAWhheewjocwoL+rjQCHNrKfuK1t77tmYHiIWtz6GRqmFlkisIzq
         HfYtYDCU/HWlpeNsnhLeJh4z32b1QHwmv6U+zYXiU1UdiP173uzK2s2BFYzgCivkIRlN
         gcbGvaK4nEctwW7bmlkpPQfLT2BIA+/F46htXTpO672UeVH8TpdbeGd0Dmc2OoWI5fTO
         PSlyHK4eVDVvXedZVutY6TpOfpzGbCSP7FSUHNcFCFKWxbVarecrCDjJ9laY8aVLJLUa
         HWUSQsjjkb8VaWd6XJdIZvmuyWH3qIehtuNbQ8aHrT8purrXHQmEUqBjc5p9FxbeE3aB
         c5Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784201563; x=1784806363;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nQFV6uTevVnEZyY/RP6SSrTntWr7oAjSimUXIkwaAKQ=;
        b=VFY24sGFJ6qNDmxgmk9ZFbYgv9l7Gy3kovYbLax4nOo8lrxFrhbPzV1yG1vZ4tcokp
         vynYf0ezegg94fhGN0OKMetTHcUqUUL39SpUWWx7pbn99x5dpfFySZYQE5k2q9lApQzX
         Jy4MU416OxWexpfKvhp7m9jHuiNXIar2AoQim28zMfB4sjpK01j8iOjp7nmN0tPbItIS
         rf3OayhEVvYcZvU+3kQtXyYwm4FaHnKwSin2LUjw7CtfS5qWSPvSUCguPAalkEm6obkM
         jYbpgUIy3kOTPwKkGtDZ0Sdo4RZn2WRXHzTPMO7HDmBHgQSjhd6yUoiG7jfMJ5wZ8Xvc
         xcHQ==
X-Gm-Message-State: AOJu0Yw8dc/XqSu1gHm3CKK5sqQvHswb0zuIHDCSvsI8aEYrMlBPKV4L
	OveZFFwBDXkLKtgOMdZMOAOeNnZTqKCA8w+VgDeBxUD899W3+CdT6Gr/
X-Gm-Gg: AfdE7cn7gGZZZVbk7NEgR9fME6wNnuN3eLv4H8j7IYjM+w63B4Zodx5pPindnL5Ut1Q
	tHtFuNbg8YJ3XuGizmak+Hrm4Xh4whDhNHlMxR2xvrJNNb3S+jYybBHjZNGUUVlMidlZHOLtH5J
	KjLO7aqL5eThHR4r3HaDNLeQ0cfIEOky6PgzxU27lNf/B8s/Nafr+PoWlDpwAFn/F1mPdrkxvWI
	FTdBw8KwBBxmJi/Nx5DSK8ZjkVHTQGTB6NmcV2Rv9dFaC6HtfHGXQfK2tRFwhJ0a8aMAl6NMUyx
	pBBn4ujjrFct7sdj53ka9fpUXjvaiS8g+cQFX73FE7m4VGWhEQ/ZzKJjNi7ZTrtrFrI18OC9ylc
	O8j+Az/u96oM1WgSmZ8lsrHmmddj1R5t57LdKVlaZ8K8sGKIU3swvo+cOXp9Fhfbr8jRJa5D8++
	gSbFrpH2lCo8rebuuzYD0FvS/HbX93FK7QGkx5YUD+y6Tcsk5BljnZqJ3uZOSi/wppJs4X2EUEu
	yLChp2/FpL8FO4oann5U1ytgTXge5mTmgfcGPqLlY9H
X-Received: by 2002:a05:600c:1d9a:b0:493:c535:3934 with SMTP id 5b1f17b1804b1-495384a43aemr130193515e9.36.1784201562704;
        Thu, 16 Jul 2026 04:32:42 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f47688f29sm21622919f8f.21.2026.07.16.04.32.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 04:32:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 16 Jul 2026 13:32:41 +0200
Message-Id: <DJZYO1XU6ANR.27W4M62WISKOV@gmail.com>
Cc: <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf-next v1 8/9] bpf, x86: Fix stack-passed arguments
 for indirect trampolines
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: <sashiko-reviews@lists.linux.dev>, "Kumar Kartikeya Dwivedi"
 <memxor@gmail.com>
X-Mailer: aerc 0.21.0
References: <20260715220052.1590783-1-memxor@gmail.com>
 <20260715220052.1590783-9-memxor@gmail.com>
 <20260715221412.ACF3D1F000E9@smtp.kernel.org>
In-Reply-To: <20260715221412.ACF3D1F000E9@smtp.kernel.org>

On Thu Jul 16, 2026 at 12:14 AM CEST, sashiko-bot wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
>
> Pre-existing issues:
> - [Medium] The patch correctly fixes the struct_ops stack argument offset=
 bug for x86, but leaves the exact same bug unfixed in the ARM64, RISC-V, a=
nd LoongArch BPF JIT implementations.
> --
>
> --- Patch [8]: [PATCH bpf-next v1 8/9] bpf, x86: Fix stack-passed argumen=
ts for indirect trampolines ---
> commit 804aec167442bbd8ddbbc13495bc188618bbaeaf
> Author: Tejun Heo <tj@kernel.org>
>
> bpf, x86: Fix stack-passed arguments for indirect trampolines
>
> This commit fixes a bug in the x86 BPF JIT where stack-passed arguments
> for indirect trampolines (such as struct_ops) were read from the wrong
> offset. It correctly adjusts the offset to account for only the caller's
> return address being on the stack, which fixes callbacks that have more
> than six arguments.
>
>> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
>> index 2f25353f135bd..672fe54dfeb8d 100644
>> --- a/arch/x86/net/bpf_jit_comp.c
>> +++ b/arch/x86/net/bpf_jit_comp.c
>> @@ -3074,6 +3074,7 @@ static void save_args(const struct btf_func_model =
*m, u8 **prog,
>>  {
>>  	int arg_regs, first_off =3D 0, nr_regs =3D 0, nr_stack_slots =3D 0;
>>  	bool use_jmp =3D bpf_trampoline_use_jmp(flags);
>> +	int stack_args_off =3D (use_jmp || (flags & BPF_TRAMP_F_INDIRECT)) ? 1=
6 : 24;
>
> [Severity: Medium]
> This is a pre-existing issue, but does this same bug also need to be fixe=
d
> in the ARM64, RISC-V, and LoongArch BPF JIT implementations?
>
> On ARM64, save_args() unconditionally hardcodes a 32-byte offset:
>
> arch/arm64/net/bpf_jit_comp.c:save_args() {
>     ...
>     soff =3D 32; /* on stack arguments start from FP + 32 */
>     ...
> }
>

Yes, but it will be sent separately as a separate patch.

> This seems to assume two 16-byte frames (FP+LR and FP+R9), but struct_ops
> only pushes one, meaning stack arguments would start at FP + 16.
>
> Similarly, on RISC-V and LoongArch, store_args() unconditionally skips 16
> bytes for the traced function's T0 and FP frame:
>
> arch/riscv/net/bpf_jit_comp64.c:store_args() {
>     ...
>     /* skip slots for T0 and FP of traced function */
>     emit_ld(RV_REG_T1, 16 + (i - RV_MAX_REG_ARGS) * 8, RV_REG_FP, ctx);
>     ...
> }
>
> For BPF_TRAMP_F_INDIRECT (is_struct_ops), the prologue aligns FP directly
> to the caller's SP, so arguments start exactly at FP. Will these hardcode=
d
> offsets cause the JIT to read 16 bytes past the actual arguments on these
> architectures as well?
>
>>  	int i, j, slot =3D 0;
>>
>>  	/* Store function arguments to stack.

