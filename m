Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792934337;
	b=eNOyrtqOzTOThiNWO4+XcVrFvZkUEX2MxleE4Yy/w9ZGaDwqgbkYYn8cVmO+Rs9gcEfS
	 4QbmBWCqhQpUNBkCAZcypZvhF5gsZFcKFhZfLPbxNflratAeFD/eBdTZ3TUUwK/eSpEQQ
	 AUSDE2YvafsPh9NKDfhxJFx7k4Gc5nn4Heb+SS6Y9XWRiYQj3NUT0uNAbgRYiP+EYWpG/
	 DK6ztxoEgBT9gJiHYS79Nkj9SH6cmPcigN55KijeLAZRuoMH5My2zdrdCv8vqUNAVJclo
	 MprAJtPa3wRZ8BANpgJDJslHMeXayOMyaOWKmQclIO3OlgGHHOAfoFr3nXgdib9SkXw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792934337;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:Date:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=DP7yAHiJHNXgOEkd7w8o5Vce5wXP1kX+DYHQnqG0YTA=;
	b=w0xpLSA0xhSQFM1WQdaJdq0ITHXGe+Cxr/1FsclCRh5vOC1VIGUM0ac9maj/ARFXw0z3
	 iXZUPl1wz+dYPDfFWPhhRzXNefeASpEwdDiPtLzSzjlGRPNfaniOWHiZ/CHf8LO2Rmj/5
	 fvdtJmlvfDigB7eBPwCS6Hzlbx18NkJEtsn8Mt3YbGXHhuOkepHJqRV6YmvNQZMKx88ih
	 XNQN2YPmaGfKw2YNGTpOzF+/Y9r1E+lpHYKpf+Vn8LiHSVk7rfkSDaKSwppUqUEaFi3VY
	 sAjh4jG45wnSc6MZ6RJ9M9gJV9QsRvTQECZCq9n9QYmWvpHFU9pnEjjliQVw/67ZJDg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=NhXEoDSS;
	arc=none smtp.remote-ip=209.85.221.51
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B384606A31A
	for <bpf@vger.kernel.org>; Sun, 25 Oct 2026 13:18:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0B384606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=NhXEoDSS
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-48df54150dfso1150730f8f.0
        for <bpf@vger.kernel.org>; Sun, 25 Oct 2026 06:18:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792934335; x=1793539135; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DP7yAHiJHNXgOEkd7w8o5Vce5wXP1kX+DYHQnqG0YTA=;
        b=NhXEoDSSTyKdC9o/Sj9s+FZloL/xsNUjfS5kK6TZ/yWKFHWQ0fWKxT6iTqIW+JyefH
         G5ktan3A5UwjbfY3maLj/UjXUsZXev5LqEEcr6napTzMlK7AMoTce5I1yMzX/PUv9WLM
         0sdQ7raDO8qbwlxJD2oP1UL2vj3EtUE9XMCJeLMupFhYXqSD09XoP7U9IF3vKefaL39k
         WpjN9CPzqZ7ynvHXSWa2IZ7QCyFoE1v+a/BnB/g5a3fN3IV6Q4WlPppVF+XbGUBEDdtf
         eXP/jmmtjtM9PD4VTNzK/J4MxUVpiCfqkghSuEUrmWP5mQCaxEtiM0lvg/fLlk9biPm6
         sMgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792934335; x=1793539135;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DP7yAHiJHNXgOEkd7w8o5Vce5wXP1kX+DYHQnqG0YTA=;
        b=YVu9LCuP0/XA/RxzTiQ+txvpoqc/kZfOu38UQ734vBvlM7iq5o1/aJcA+Hq+FHXkA1
         98jyA1vzhWomXnUpMKGkBIlnAFCM0kd14297K7D/oWf1KlPZB56odtrqywD8kUA7gJHP
         HPNaz0ZBXS+cKy1fFhdvD/FVu6FndtEAwZvkj0jDVmgiKi2nIFyHtwH/wGSKx31ZuVal
         HdXSef5pf4AiWB26crWxqUfu99xDVvGRMZZplYyJH6ad1Ql/VUQx5B6KIPPj7NJFBSnK
         Gi9PM5wygPJuFh244yjYWgcyEoS+5HkZUKEDHb9uBrUegTh7YyImpcdvmSjf/9hq9w6x
         waxQ==
X-Forwarded-Encrypted: i=1; AKwUvBx7xbkXhSEBlpoXVh6bC/b+GILxMXe28kyWW6l8azim+GXTO/+cxnukJ6QXHpv/etxssFQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYLtKtvYevf8LkUrvYQJsC4JrCUnY1bCoDBUlMYz1sQ7fjhmHP0c
	p4T/UEwQ6Rql1E9GlgrelZ7e9ikZ5bQBH4LbN6QUL0TFyCFdAcUJsI4taoMsbe1l
X-Gm-Gg: AYBFou3XyPlk1d3gFYwJjSAjLIC+aCM6nrb9UnlKdlpnV3q4OidLY59TUXm3WRl5/qG
	CMioQFBj98wizkV2NHUA6O8wDZdCI0q9tMCMPSOe7lsSJ91vUFwAVH8pDCmsZe+i21MfiFqCeql
	jkb+xsF0qtbmuK1aGXwj776jxa9tD5aoef7o0p4vWvSxJbAXv2awlPPbFoojFpBj0JSYAYzdFcX
	irBVF63oXjJf4Tes6xHA4OIwrtS25+J6fRcF0cuPgJicF6T7GCQX/vtxY8nIgEQGytbKuY8c+8t
	9zniUqTk+Kz2Tgxo4k/OSNl3bUSpl1xu8GyNGdqx/PEvXx+6ujaB5MbeAI64vQLRiN4FqL1uoRI
	noNc4WqRVovh2Ie9lD6XufLgBoiHTohhXtIB+TTZlbKouQjcfgEvXA54bWdhvHq2mEILCnxPydE
	gTrXWckhpTG4s+w2nwRyQ86E4bT45ivdDw8xh47nDlWbC+UDN5UBnj9cdO4N78kncuZrCXzLz+A
	NX+69bSvvO/AM9jMfUo0RA2dAlRHnZaxvpgU2+8ncw=
X-Received: by 2002:a05:6000:4910:b0:487:767:b301 with SMTP id ffacd0b85a97d-48e3eba5e15mr6824961f8f.57.1792934335178;
        Sun, 25 Oct 2026 06:18:55 -0700 (PDT)
Received: from krava ([176.74.159.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e412cc164sm9402669f8f.7.2026.10.25.06.18.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 06:18:54 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Sun, 25 Oct 2026 14:18:53 +0100
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org,
	andrii@kernel.org, Menglong Dong <dongml2@chinatelecom.cn>,
	Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH bpf 1/2] x86/ftrace: Use jmp mode only where functions
 are aligned
Message-ID: <at4BvTcsjWwDuvbl@krava>
References: <20261024073712.1074591-1-daniel@iogearbox.net>
 <DMDB1EESN4U0.KLEICFNC4NUP@gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DMDB1EESN4U0.KLEICFNC4NUP@gmail.com>

On Sat, Oct 24, 2026 at 07:10:57PM +0000, Alexei Starovoitov wrote:
> On Sat, Oct 24, 2026 at 12:37 AM Daniel Borkmann <daniel@iogearbox.net> wrote:
> > Bit 0 has that meaning only for the direct trampolines that a dyn_ftrace
> > record can point to, so jmp mode relies on every other target being even.
> > Select HAVE_DYNAMIC_FTRACE_WITH_JMP only where it is, with
> > CONFIG_CC_HAS_SANE_FUNCTION_ALIGNMENT or without CONFIG_CC_OPTIMIZE_FOR_SIZE.
> 
> Disabling it for -Os builds is not great.
> Can we fix the users of ftrace_call_replace() instead ?

looks good, it takes care of the C function targets, the rest
should be aligned ftrace trampolines (static or dynamic) or
direct api targets

jirka

> 
> diff --git a/arch/x86/kernel/ftrace.c b/arch/x86/kernel/ftrace.c
> index 17d6edf..654c3f2 100644
> --- a/arch/x86/kernel/ftrace.c
> +++ b/arch/x86/kernel/ftrace.c
> @@ -190,11 +190,11 @@ int ftrace_update_ftrace_func(ftrace_func_t func)
>  	const char *new;
> 
>  	ip = (unsigned long)(&ftrace_call);
> -	new = ftrace_call_replace(ip, (unsigned long)func);
> +	new = text_gen_insn(CALL_INSN_OPCODE, (void *)ip, func);
>  	smp_text_poke_single((void *)ip, new, MCOUNT_INSN_SIZE, NULL);
> 
>  	ip = (unsigned long)(&ftrace_regs_call);
> -	new = ftrace_call_replace(ip, (unsigned long)func);
> +	new = text_gen_insn(CALL_INSN_OPCODE, (void *)ip, func);
>  	smp_text_poke_single((void *)ip, new, MCOUNT_INSN_SIZE, NULL);
> 
>  	return 0;
> @@ -503,7 +503,7 @@ void arch_ftrace_update_trampoline(struct ftrace_ops *ops)
> 
>  	mutex_lock(&text_mutex);
>  	/* Do a safe modify in case the trampoline is executing */
> -	new = ftrace_call_replace(ip, (unsigned long)func);
> +	new = text_gen_insn(CALL_INSN_OPCODE, (void *)ip, func);
>  	smp_text_poke_single((void *)ip, new, MCOUNT_INSN_SIZE, NULL);
>  	mutex_unlock(&text_mutex);
>  }
> 
