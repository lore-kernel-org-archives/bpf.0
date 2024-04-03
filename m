Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F13EA18AF9
	for <bpf@vger.kernel.org>; Wed,  3 Apr 2024 21:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712180430; cv=none; b=RJypB6Wu2VjyrQfb4ls+3Dm+1UO+npaXT7SgFGbzwoUPr57tsog7yDNtlGsHFR3UC46Mimn2Tm4l9mGj/jQ6EMKnJVARofqggJuZxyH2EyjQOR4pvYhegB2yrstp/4eUcEvsnNSp6D9IVrwNMI2AYAbooQJrjclzz0/x0bRJ6yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712180430; c=relaxed/simple;
	bh=RQK/DtNqRhECIVizGl1QzUwJ5UrfN7yQavi+y0zH8mA=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=XAJ5oQMyQ8xtSnBeM9oZX5JwvvB3bm8iq67YMe5tHm3GfMrrTqJBKn2FkGcZC7GKC2ovNZ2pTPBQd47V6sBU8xlxZxm5X8bF++H7aS4hMcowXOznzGj5t+TO4VJ7/UvJNMaTRbTmnX7eBD0ofwGZRAiv3yyUTLKs2/Wig2yOiYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GODayltX; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GODayltX"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6ecc9f0bdaaso204026b3a.1
        for <bpf@vger.kernel.org>; Wed, 03 Apr 2024 14:40:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712180428; x=1712785228; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y7q+g5BBnJ7zwQj1icERu/kDTRv2yIdwUDSIddQ8wpc=;
        b=GODayltXLAiUJprq5g/QRy71yhZaapOCTx060nIfqFPc0qqTyjl/8tjv0asjPfEr+y
         OV28F84//FSQOlbSFEa/veDgMY8okb1Xgq8ZtdppKf0r7rf3hyfXWmviGLlkqvAShAvJ
         uQJyA22dQTDNfjeFbkPYSrONcWPvFP9qxiXVZ6vlquMsq1xGkaInWaTC/ijLtZ8eclcu
         NMJtqCkv5+AF8xV1UJRV+SSMBSthA+1zIpjitxLqZz3kVl2B8QQ8SvhT+f2K7Qs+HKWa
         nb3VSxWLRNiH4suIDoYmB0OdjpMthch+N7l/RyD5LavNfFAmTxDnw0iPmx3mvvWy3fMM
         D4Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712180428; x=1712785228;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Y7q+g5BBnJ7zwQj1icERu/kDTRv2yIdwUDSIddQ8wpc=;
        b=OFPRQZy8TjQ9V1LiqCFRIAPIylbODxzr0kAg6+jO8GrRsPdnSgZF1FaRZIre0j4qtN
         2CcxF/1vzfBbgn8ZzxZpFBFt7W94iAtYcdgGQ2Licnd7vR+RxIAfvZYLXQQEpm6+b9L2
         9X0032WCBPRrv5uv+6tIvjbOaC3zn0hywLjplkPZNeFeEvjv7JSBS8nudoF79CL7Y8cd
         aQomKyOWVqh6+z9o1AjlPApElZ7YcSBtbo+YQ7t27aoVwpRim+yzdZUGK5IJ00TlfCVm
         HxO9Hwry0I1H4YLOsOnyuN64uiGN7oyKGQEIT3WmsrLoPtlVmJmbK7HYQyH7rxees6VQ
         ThYA==
X-Forwarded-Encrypted: i=1; AJvYcCVj2S2pNejqH1/rJLI6+WUi7+E3vDxXFN9p/vASkif37KZE+UvahXlgt2UeRfqvj4+wt5kZ0gPhn596RluY0FZqBs5u
X-Gm-Message-State: AOJu0YzkJFP6pODJqWteaHoJ+FQwrEsHFH+v4vLib0MqllZISLoxSMpb
	QQXDEkESsjcEkSEfSpjcmb3Y5eHhGxeE16N9rd1I6qpBKxPn3yc7
X-Google-Smtp-Source: AGHT+IHrH00X1GoiR960DShPC1Z6YSqUZuILa9JTpIjmgbxP8vviiAuShTZNDafhkrrU/m8ftjoqNg==
X-Received: by 2002:a05:6a00:1ad3:b0:6ea:f05d:d2ec with SMTP id f19-20020a056a001ad300b006eaf05dd2ecmr909566pfv.2.1712180428053;
        Wed, 03 Apr 2024 14:40:28 -0700 (PDT)
Received: from localhost ([98.97.36.54])
        by smtp.gmail.com with ESMTPSA id c21-20020aa78c15000000b006ea8c030c1esm12173215pfd.211.2024.04.03.14.40.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 14:40:27 -0700 (PDT)
Date: Wed, 03 Apr 2024 14:40:26 -0700
From: John Fastabend <john.fastabend@gmail.com>
To: Tao Lyu <tao.lyu@epfl.ch>, 
 bpf@vger.kernel.org, 
 andrii@kernel.org
Cc: ast@kernel.org, 
 sanidhya.kashyap@epfl.ch, 
 mathias.payer@nebelwelt.net, 
 meng.xu.cs@uwaterloo.ca, 
 Tao Lyu <tao.lyu@epfl.ch>
Message-ID: <660dcccad5d07_21448208ee@john.notmuch>
In-Reply-To: <20240403202409.2615469-1-tao.lyu@epfl.ch>
References: <20240403202409.2615469-1-tao.lyu@epfl.ch>
Subject: RE: [PATCH bpf-next] bpf: Fix verifier error due to narrower scalar
 spill onto 64-bit spilled scalar slots
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Tao Lyu wrote:
> The verifier previously aimed to reject partial overwrite on an 8-byte stack slot
> that contains a spilled pointer.
> However, it rejects all partial stack overwrites
> as long as the targeted stack slot is a spilled register,
> because it does not check if the stack slot is a spilled pointer.
> 
> Finally, incomplete checks will result in the rejection of valid programs,
> which spill narrower scalar values onto scalar slots, as shown below.
> 
> 0: R1=ctx() R10=fp0
> ; asm volatile ( @ repro.bpf.c:679
> 0: (7a) *(u64 *)(r10 -8) = 1          ; R10=fp0 fp-8_w=1
> 1: (62) *(u32 *)(r10 -8) = 1
> attempt to corrupt spilled pointer on stack
> processed 2 insns (limit 1000000) max_states_per_insn 0 total_states 0 peak_states 0 mark_read 0.
> 
> The issue is fixed by adding a check on the spilled register type of targeted slots.
> 
> Fixes: ab125ed3ec1c ("bpf: fix check for attempt to corrupt spilled pointer")
> Signed-off-by: Tao Lyu <tao.lyu@epfl.ch>
> ---

A test case would be nice.

>  kernel/bpf/verifier.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 17c06f1505e4..3064ba7c140f 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -4493,6 +4493,7 @@ static int check_stack_write_fixed_off(struct bpf_verifier_env *env,
>  	 */
>  	if (!env->allow_ptr_leaks &&
>  	    is_spilled_reg(&state->stack[spi]) &&
> +	    state->stack[spi].spilled_ptr.type != SCALAR_VALUE &&
>  	    size != BPF_REG_SIZE) {

Might be worth a helper we have is_spilled_reg and is_spilled_scalar_reg
maybe a is_spilled_not_scalar_reg() is nice. Perhaps Andrii has a style
opinion. Or,

 is_spilled_reg(...) && !is_spilled_scalar_reg(...)

Not sure I like that any better than whats there in patch though.

>  		verbose(env, "attempt to corrupt spilled pointer on stack\n");
>  		return -EACCES;
> -- 
> 2.25.1
> 
> 


