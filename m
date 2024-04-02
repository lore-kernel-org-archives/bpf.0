Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 720DB175A1
	for <bpf@vger.kernel.org>; Tue,  2 Apr 2024 17:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712080219; cv=none; b=nIWQe8nwbcae2IO/uCnQOKo6ArM6rjioy1iOv0h5/HKMDidHh24Nq27KAJXsqWxv6MrQk8gNyQm0tU6CLXpvnX8FKuDTDqz7KyPL/O0/hn62IEKcz/iG8ZdIkktUTVph42EBtIwEzypsFINZAazV6y90Eu0Wzi/pICgCTCArNoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712080219; c=relaxed/simple;
	bh=E+hfCUJl4o05uCM7E/5AldGKLbn+ghUu+NWDxqztRWI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BhZSexvFcOsi+uUnuJWcmg1UeuH9TFIdoTNHNcoHy6Z8AG3COxNTOdGE5ZLnxSNAR2sPA+2K9N0gf/RTYUK1zSI3a8uLFElLBMOJzQ9E2Sih0iV6MgFlXz+4ZtDl30y2FYoNF+KbpywtlJXUJ77Tn/z76MLL3bRFt1LRllCIRzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ks6GSQq9; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ks6GSQq9"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-5d81b08d6f2so4325281a12.0
        for <bpf@vger.kernel.org>; Tue, 02 Apr 2024 10:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712080218; x=1712685018; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zhe8PMh/BVRCwZKUKIJXRrVHdPLAQTbj8F0GoS8POWs=;
        b=Ks6GSQq9hN9tVKtskwVqNEz6V+fox+cm8EQu8LdzTaJY97Zw+WollDDLh5J2j4JXyt
         EVv+P1tDpr/NnmQB6xOkliI/7uN7zrVshJtAaPVaqB/I30uhM8sA/hm/eBmlDJRZoyXI
         0xFzpAZjtACyEjui1Xf/jHGuBi07319yjebh0/uLC4/C8MzdvZoSQs7REOZogrUhHHMh
         xyRM9jWGoynls1gz68QCGQxUvPWm0MWaMOnSLBY4WogcssJeZsg3IeLsdEsTGbkmHXHk
         tdC6sRpyV84JANDoEiNZo17bE5z7RA8CFQAKMWiXqABP3vVssUU00fqnQ2tLbs+InpRm
         k60g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712080218; x=1712685018;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zhe8PMh/BVRCwZKUKIJXRrVHdPLAQTbj8F0GoS8POWs=;
        b=Wziwi+nle91tffo122SsfzPyGkXDFMB7+lPpbT7st0Tzs5Vx6lttAL9pHVR1VsTkOO
         dd5XcCRyfrrkmyQE103MSQ6GadVhbu2ngaNAnwBpiiA0ajDUR5AmVZs7unbsJQMacB5+
         bmyUJ6X8z1cqfM/6lKn85diU3ALt1XZBKvo6hp+P1xQTPTL5x+7TuBUGQdgOwgm/aJYI
         LvxyNotcxY1I9MRvVpioYRIUdJtkJ4deiW8YTnKCwQ+YVvWrYTsc8/c9RofRw+ysVZ/5
         M+SMsqWhpIThxRxRAYRMoHxjBmh19c87p9HqbhONAuVeiyNYb/PL0rWLwYRHYjurK5+U
         XYVA==
X-Forwarded-Encrypted: i=1; AJvYcCVGoW8L9rxFw8xhv4W+T18iEtxN/21G+H1zKliu08Pe5/VRC62J+4ZJyGnC0FcdmZBrE4jCmTumhRVUGvioQjg9nZ9B
X-Gm-Message-State: AOJu0YzNlAo6wMytr2N8SDZGJtNdzzTMGFy5aD3leQJN0ZsWGZxSg85Q
	cDfG6so8Z/9NGv+Z4PpHQA7oke6TuXiuFYyzzIhV/8r3Ly/vvkAL3aLbqjUbRDp34b3ivWfros8
	/zJ/mRFHptjdKB5cfSC9sVLs/U6E=
X-Google-Smtp-Source: AGHT+IGQjQ263DermnFXrlynUvqKj6jHweN8XnDdbSU5pLKXuEdo+5A20OuNdKeRBNf4pOxU+oFzTg9cPV4WLNjaOUg=
X-Received: by 2002:a17:90b:46c1:b0:2a2:5c6a:d1a2 with SMTP id
 jx1-20020a17090b46c100b002a25c6ad1a2mr435401pjb.29.1712080217554; Tue, 02 Apr
 2024 10:50:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240320122153.3622252-1-tao.lyu@epfl.ch>
In-Reply-To: <20240320122153.3622252-1-tao.lyu@epfl.ch>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 2 Apr 2024 10:50:05 -0700
Message-ID: <CAEf4Bza98OQ-axH-o1xE4KA72Ga9bLwdDuWJS_irESbbxp1saA@mail.gmail.com>
Subject: Re: [PATCH] Inaccurate rejection conditions
To: Tao Lyu <tao.lyu@epfl.ch>
Cc: andrii@kernel.org, yonghong.song@linux.dev, bpf@vger.kernel.org, 
	sanidhya.kashyap@epfl.ch, mathias.payer@nebelwelt.net, 
	meng.xu.cs@uwaterloo.ca
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 20, 2024 at 5:28=E2=80=AFAM Tao Lyu <tao.lyu@epfl.ch> wrote:
>
> Signed-off-by: Tao Lyu <tao.lyu@epfl.ch>
> ---
>  kernel/bpf/verifier.c | 1 +
>  1 file changed, 1 insertion(+)
>
> Hi,
>
> I am sorry to bother you due to my confusion on constraints about stack w=
rites.
>
> 1. When an instruction stores 64-bit values onto the stack with fixed off=
set and BPF_CAP only,
>    the verifier marks the stack slot type as STACK_SPILL, no matter wheth=
er they are scalar or pointers.
>
> 2. Then, a store instruction with a **32-bit scalar value** on the same s=
tack slot leads to a verification rejection.
>    As it says, this might corrupt the stack pointer by asserting if the s=
tack slot type is STACK_SPILL.
>    However, even if the stack slot type is STACK_SPILL, it might store a =
64-bit scalar and not a stack pointer.
>    IMHO, this "issue" might originate from the incomplete conditions in t=
he check_stack_write_fixed_off() function below.
>    It only checks if the stack slot is a spilled register but forgets to =
check if the spilled register type is a pointer.
>
>  4479 static int check_stack_write_fixed_off(struct bpf_verifier_env *env=
,
>  ...
>  4494     if (!env->allow_ptr_leaks &&
>  4495         is_spilled_reg(&state->stack[spi]) &&
>  4496         size !=3D BPF_REG_SIZE) {
>  4497         verbose(env, "attempt to corrupt spilled pointer on stack\n=
");
>  4498         return -EACCES;
>  4499     }
>  ...
>  4600 }
>
> Below is an example bpf program, which stores a 64-bit and 32-bit immedia=
te value on the same stack slot.
> But the second one gets rejected due to the above.
>
> 0: R1=3Dctx() R10=3Dfp0
> ; asm volatile ( @ repro.bpf.c:679
> 0: (7a) *(u64 *)(r10 -8) =3D 1          ; R10=3Dfp0 fp-8_w=3D1
> 1: (62) *(u32 *)(r10 -8) =3D 1
> attempt to corrupt spilled pointer on stack
> processed 2 insns (limit 1000000) max_states_per_insn 0 total_states 0 pe=
ak_states 0 mark_read 0.
>
> If my understanding is correct, then we can apply the attached patch.
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index de7813947981..65f7eb315e9c 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -4493,6 +4493,7 @@ static int check_stack_write_fixed_off(struct bpf_v=
erifier_env *env,
>          */
>         if (!env->allow_ptr_leaks &&
>             is_spilled_reg(&state->stack[spi]) &&
> +           state->stack[spi].spilled_ptr.type !=3D SCALAR_VALUE &&

I think it's possible to easily convert PTR_TO_MEM kind of register to
SCALAR_VALUE through arithmetic operations, and so allowing to spill
SCALAR_VALUE to stack is basically just as dangerous as spilling
PTR_TO_MEM directly.

So it feels a bit dangerous to do this.

pw-bot: cr

>             size !=3D BPF_REG_SIZE) {
>                 verbose(env, "attempt to corrupt spilled pointer on stack=
\n");
>                 return -EACCES;
> --
> 2.25.1
>
