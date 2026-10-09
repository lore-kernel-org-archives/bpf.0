Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34AFF4F0536
	for <bpf@vger.kernel.org>; Fri,  9 Oct 2026 16:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791563590; cv=none; b=ss/4W6lAh8IHDZSFyHNmnlRIeebwXol79gBLyNojWGSKyxbdyiOXxA4HBhCYfivQOp5bMVxtFA3cS7XEC9eCosNUfp22TI9qYS94L9aNSulTF4+pYc2w3WS7Rr+tn4FsRVhop6HRcm2KAmvBgHiR+nXQUJGAiF7+KyeXxjTVtIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791563590; c=relaxed/simple;
	bh=adtJZs987/cifFrpNc95S6HlhnQjFutbkv9UM1xx51k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dODgcYavAPcI4l58sszOza7HOrUfe64Dy1Tww5WO7FX9CnsSAjc4c3FmO379lABkkKLXuNEYi4jTjDI1jFny+JlcphLWYE0gbsvEjj+QXHVcEQX7TVAA+wRu7AuUKPLCUtwQR+uM8TfFXqQHVfWh0O7K9IZ1cHMpqzZlaYoWMf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xkv2GSE4; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xkv2GSE4"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-53505bc6524so62845651cf.0
        for <bpf@vger.kernel.org>; Fri, 09 Oct 2026 09:33:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791563581; x=1792168381; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9sVGgzlu6+ENWUoJYb78q+rgs2zxlV0DomchfrV7sKg=;
        b=Xkv2GSE4g+z7SHr1obSJIZCEiaWY2EfLCAZJe7rIrqEj0QuJX0bgJEc0u+x22LbIQA
         DhjhQzg5rVBUKdMGsHpvJed+mfZ/XRxnvmwVUWke2Lv3vFhycVbljvWUBHVyNPyugh2Q
         oh5hZ6poIfFB2sMpU+8X9pcoIw2PpyJRcK7Q2ZHRJvfiQ5HpdG2S5Vbz9HVry6c8qSPb
         AttF+tUCXFUcC8aEMbJByr8BOFdl/t4XOCE5OuCQFSWZcYg/pGTcoE7cPyDmIi2ts73p
         X2wQXa3BU01PNabkM+2JUN7cW4fM1+cO3HskT4i1IH8KmroYGrK6RHwhH7nhhQYo8SWy
         9FoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791563581; x=1792168381;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9sVGgzlu6+ENWUoJYb78q+rgs2zxlV0DomchfrV7sKg=;
        b=CyIRXQtSkQXIEKPlThRSb7DZMbiMQdP2AraE0x9l0z37uy0M+AegckV08UoIV7/lQH
         i+DjmoSYPSzgplLfi+H+QmM1ontzWcipRgWqfGX0m2XhNqCP957EhhftDPlqXUTaEfUh
         ofyH2TYzLi/JG/y7CEMNAlb2Om9Fc5+vxL5j/maqhsv4zNEVqSZFD+FJg3fhUhhg1Imc
         HP98r9N7IOA94WggtiakI6/1Y5gBCXJ5fOsYKbhQNAGZjgB2G2UvEXBTcEeCEAL5NaFE
         zxF0d3NpKrmCBJAvTxk+bFnwD76FcFGEhvWwo6zOvTmtdwG0CxsHw+mIfFVC3UiFLron
         nzlQ==
X-Forwarded-Encrypted: i=1; AKwUvBw2z5ppPlmA+gFf/WJA5goy7GEV8cLMP6uaJ1ON4RQl/m8FTjf35mz/hALgZidY7rGuaHM=@vger.kernel.org
X-Gm-Message-State: AFq9FYL/LAhqQU3GAmmO+Y2iDHHan3Yp51mZ/z47WfHzxoEXyEaM1lPD
	EwSW+F8+r2e8CwG/d+E44SXXbGpH02uL07I78nwMjyzhX+xwMAX+FK9e
X-Gm-Gg: AYBFou3CPa25O8Bzm9ssChEFRf30I8DrfPC53/OPna1jf4v+A7nI9oxmm0W0lvWJa2y
	wmR/cf07aDbTUqN34iAP+7ITsKWbww81191EBvbZZ+fHHNCV6aIfJqXxbjrSduXS+Hl31j6a8SE
	MODB5CiZEoPWqFXPjb8+p3KqMukpiXDCOzHWmrABDhEkzJ4H4eU6uMcRXzFOkwWaNan96X1o2wU
	B/tb/H8d4mtn9i5JEEp76IoPXIA/oQzyzYSHSAXRWqX6CgSeqVu4IZiiax6gJN8U2Gj86Xd4FhF
	Rossnd3gxfPpFrgfRqAUtGLSNlDDCTDc+7hD0N03BaaWsEwLzogOagq7qksOfN9NKtejw0c2cXS
	NVTpTJj2RMLh+MOWkfdGOiAOtbT3Ld0rMBKa0mz4mn5FO0hxqnYtFCSO6ZhpQCuQt0tTuiY5LSR
	tQ3knXzN4kYoDyTmvPu+ZwiaBOn5//WELhSff7+7xn5Pu7El56/dpoJbrzSz/ZqjZMlv9m7979e
	9lSSDOKa4QjmhlJ8ToOxOk99RtwbJwyPg==
X-Received: by 2002:ac8:59d5:0:b0:535:1d5b:a7fa with SMTP id d75a77b69052e-535a6101048mr25000311cf.14.1791563580780;
        Fri, 09 Oct 2026 09:33:00 -0700 (PDT)
Received: from google.com (61-230-52-229.dynamic-ip.hinet.net. [61.230.52.229])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5359b6fa0f9sm21647561cf.8.2026.10.09.09.32.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 09:33:00 -0700 (PDT)
Date: Sat, 10 Oct 2026 00:32:51 +0800
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: Greg Ungerer <gerg@linux-m68k.org>
Cc: bot+bpf-ci@kernel.org, corbet@lwn.net, skhan@linuxfoundation.org,
	geert@linux-m68k.org, ast@kernel.org, daniel@iogearbox.net,
	eddyz87@gmail.com, memxor@gmail.com, andrii@kernel.org,
	rdunlap@infradead.org, martin.lau@linux.dev, song@kernel.org,
	yonghong.song@linux.dev, jolsa@kernel.org, emil@etsalapatis.com,
	ihor.solodrai@linux.dev, jserv@ccns.ncku.edu.tw,
	marscheng@google.com, eleanor15x@gmail.com,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-m68k@lists.linux-m68k.org, bpf@vger.kernel.org,
	daniel@thingy.jp, martin.lau@kernel.org, mason@kernel.org
Subject: Re: [PATCH v7] m68k, bpf: Add initial BPF JIT compiler support
Message-ID: <askXM-fN-olasi7l@google.com>
References: <20261005185251.2422114-1-visitorckw@gmail.com>
 <506b804c97aaa3a66660bb0eebd85c6041e241532c1227f1012166785d240fae@mail.kernel.org>
 <342ca584-c4ef-4d73-9017-9d21bbf9ce10@linux-m68k.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <342ca584-c4ef-4d73-9017-9d21bbf9ce10@linux-m68k.org>

On Tue, Oct 06, 2026 at 11:53:22PM +1000, Greg Ungerer wrote:
> Why thank you LLM review :-)
> 
> On 6/10/26 05:48, bot+bpf-ci@kernel.org wrote:
> >> m68k, bpf: Add initial BPF JIT compiler support
> > 
> > TL;DR: Nit only, not a bug: the ColdFire byte-swap instruction sequences are
> > open-coded repeatedly in emit_to_le16/32/64() in the m68k JIT; suggests small
> > shared helpers, as arm's bpf_jit_32.c does.
> > 
> >> diff --git a/arch/m68k/net/bpf_jit_comp.c b/arch/m68k/net/bpf_jit_comp.c
> >> new file mode 100644
> >> index 000000000000..6c40d358acd4
> >> --- /dev/null
> >> +++ b/arch/m68k/net/bpf_jit_comp.c
> >> @@ -0,0 +1,1840 @@
> > [ ... ]
> >> +static inline void emit_to_le16(struct jit_ctx *ctx, s8 d_lo, s8 d_hi)
> >> +{
> >> +	if (CPU_IS_COLDFIRE) {
> >> +		emit_16(ctx, 0x71c0 | (d_lo << 9) | d_lo);		/* mvz.w d_lo, d_lo */
> >> +		emit_16(ctx, 0x7180 | (d_hi << 9) | d_lo);		/* mvz.b d_lo, d_hi */
> >> +		emit_16(ctx, 0xe088 | d_lo);				/* lsr.l #8, d_lo */
> >> +		emit_16(ctx, 0xe188 | d_hi);				/* lsl.l #8, d_hi */
> >> +		emit_16(ctx, 0x8080 | (d_lo << 9) | d_hi);		/* or.l d_hi, d_lo */
> > [ ... ]
> >> +static inline void emit_to_le32(struct jit_ctx *ctx, s8 d_lo, s8 d_hi)
> >> +{
> >> +	if (CPU_IS_COLDFIRE) {
> >> +		emit_16(ctx, 0x2f00 | d_lo);				/* move.l d_lo, -(%sp) */
> >> +		emit_16(ctx, 0x4840 | d_lo);				/* swap d_lo */
> >> +		emit_16(ctx, 0x71c0 | (d_lo << 9) | d_lo);		/* mvz.w d_lo, d_lo */
> >> +		emit_16(ctx, 0x7180 | (d_hi << 9) | d_lo);		/* mvz.b d_lo, d_hi */
> >> +		emit_16(ctx, 0xe088 | d_lo);				/* lsr.l #8, d_lo */
> >> +		emit_16(ctx, 0xe188 | d_hi);				/* lsl.l #8, d_hi */
> >> +		emit_16(ctx, 0x8080 | (d_hi << 9) | d_lo);		/* or.l d_lo, d_hi */
> >> +		emit_16(ctx, 0x2017 | (d_lo << 9));			/* move.l (%sp), d_lo */
> >> +		emit_16(ctx, 0x2e80 | d_hi);				/* move.l d_hi, (%sp) */
> >> +		emit_16(ctx, 0x71c0 | (d_lo << 9) | d_lo);		/* mvz.w d_lo, d_lo */
> >> +		emit_16(ctx, 0x7180 | (d_hi << 9) | d_lo);		/* mvz.b d_lo, d_hi */
> >> +		emit_16(ctx, 0xe088 | d_lo);				/* lsr.l #8, d_lo */
> >> +		emit_16(ctx, 0xe188 | d_hi);				/* lsl.l #8, d_hi */
> >> +		emit_16(ctx, 0x8080 | (d_lo << 9) | d_hi);		/* or.l d_hi, d_lo */
> >> +		emit_16(ctx, 0x4840 | d_lo);				/* swap d_lo */
> >> +		emit_16(ctx, 0x809f | (d_lo << 9));			/* or.l (%sp)+, d_lo */
> > [ ... ]
> >> +static inline void emit_to_le64(struct jit_ctx *ctx, s8 d_lo, s8 d_hi)
> >> +{
> >> +	if (CPU_IS_COLDFIRE) {
> >> +		emit_16(ctx, 0x2f00 | d_lo);				/* move.l d_lo, -(%sp) */
> >> +		emit_16(ctx, 0x2f00 | d_hi);				/* move.l d_hi, -(%sp) */
> >> +
> >> +		emit_16(ctx, 0x4840 | d_lo);				/* swap d_lo */
> >> +		emit_16(ctx, 0x71c0 | (d_lo << 9) | d_lo);		/* mvz.w d_lo, d_lo */
> >> +		emit_16(ctx, 0x7180 | (d_hi << 9) | d_lo);		/* mvz.b d_lo, d_hi */
> >> +		emit_16(ctx, 0xe088 | d_lo);				/* lsr.l #8, d_lo */
> >> +		emit_16(ctx, 0xe188 | d_hi);				/* lsl.l #8, d_hi */
> >> +		emit_16(ctx, 0x8080 | (d_hi << 9) | d_lo);		/* or.l d_lo, d_hi */
> >> +		emit_16(ctx, 0x202f | (d_lo << 9));			/* move.l 4(%sp), d_lo */
> >> +		emit_16(ctx, 0x0004);
> >> +		emit_16(ctx, 0x2f40 | d_hi);				/* move.l d_hi, 4(%sp) */
> >> +		emit_16(ctx, 0x0004);
> >> +		emit_16(ctx, 0x71c0 | (d_lo << 9) | d_lo);		/* mvz.w d_lo, d_lo */
> >> +		emit_16(ctx, 0x7180 | (d_hi << 9) | d_lo);		/* mvz.b d_lo, d_hi */
> >> +		emit_16(ctx, 0xe088 | d_lo);				/* lsr.l #8, d_lo */
> > [ ... ]
> > 
> > This isn't a bug, but the ColdFire byte-swap sequence (mvz.w / mvz.b /
> > lsr.l #8 / lsl.l #8 / or.l) is open-coded once in emit_to_le16(), twice in
> > emit_to_le32() and four times in emit_to_le64(), differing only in which
> > register receives the result. 
> 
> I did consider using helpers for these during coding, but ultimately decided
> against it. The open coded versions allow for a handful of extra instruction
> optimizations - due to that flexibility of producing the 16bit swap sequence
> result in different registers. For example I could combine a stack pop with
> the or'ing of the result, and more efficiently store an intermediate result
> into the temporary stack storage.
> 
> The patch below gives an example of an implementation using helpers. I am not tied
> to the open coded version: Kuan-Wei if you prefer the code with helpers feel free
> to use this instead.

I don't have a strong opinion either way, since it sounds like you
already made a deliberate judgment call when writing it. Maybe I can
switch to the helper version for now to make this already large patch a
bit smaller. If anyone cares or if it ever shows up in benchmarks in
the future, we can always go back to the open-coded version to optimize
it.

> 
> FWIW, the to_le32 coded sequence is 1 instruction longer (17 instructions to 18).
> The to_le64 coded sequence is 5 instructions longer (34 instructions to 39).
> Total byte count differs less, due to use of offsets in the open coded versions.
> 
> Regards
> Greg
> 
> 
> 
> --- arch/m68k/net/bpf_jit_comp.c.org	2026-10-06 23:08:25.924094287 +1000
> +++ arch/m68k/net/bpf_jit_comp.c	2026-10-06 22:51:13.099505355 +1000
> @@ -640,14 +640,19 @@
>  	bpf_put_reg32(dst[0], d_hi, ctx);
>  }
>  
> +static inline void emit_cf_swap16(struct jit_ctx *ctx, s8 d_lo, s8 d_hi)
> +{
> +	emit_16(ctx, 0x71c0 | (d_lo << 9) | d_lo);			/* mvz.w d_lo, d_lo */
> +	emit_16(ctx, 0x7180 | (d_hi << 9) | d_lo);			/* mvz.b d_lo, d_hi */
> +	emit_16(ctx, 0xe088 | d_lo);					/* lsr.l #8, d_lo */
> +	emit_16(ctx, 0xe188 | d_hi);					/* lsl.l #8, d_hi */
> +	emit_16(ctx, 0x8080 | (d_lo << 9) | d_hi);			/* or.l d_hi, d_lo */
> +}
> +
>  static inline void emit_to_le16(struct jit_ctx *ctx, s8 d_lo, s8 d_hi)
>  {
>  	if (CPU_IS_COLDFIRE) {
> -		emit_16(ctx, 0x71c0 | (d_lo << 9) | d_lo);		/* mvz.w d_lo, d_lo */
> -		emit_16(ctx, 0x7180 | (d_hi << 9) | d_lo);		/* mvz.b d_lo, d_hi */
> -		emit_16(ctx, 0xe088 | d_lo);				/* lsr.l #8, d_lo */
> -		emit_16(ctx, 0xe188 | d_hi);				/* lsl.l #8, d_hi */
> -		emit_16(ctx, 0x8080 | (d_lo << 9) | d_hi);		/* or.l d_hi, d_lo */
> +		emit_cf_swap16(ctx, d_lo, d_hi);
>  	} else {
>  		emit_16(ctx, 0x0280 | d_lo);				/* andi.l #0xffff, d_lo */
>  		emit_32(ctx, 0xffff);
> @@ -657,25 +662,23 @@
>  	emit_16(ctx, 0x7000 | (d_hi << 9));				/* moveq #0, d_hi */
>  }
>  
> +static inline void emit_cf_swap32(struct jit_ctx *ctx, s8 d_lo, s8 d_hi)
> +{
> +	emit_16(ctx, 0x2f00 | d_lo);					/* move.l d_lo, -(%sp) */
> +	emit_16(ctx, 0x4840 | d_lo);					/* swap d_lo */
> +	emit_cf_swap16(ctx, d_lo, d_hi);
> +	emit_16(ctx, 0x2000 | (d_lo << 9) | d_hi);			/* move.l d_lo, d_hi */

Should be emit_16(ctx, 0x2000 | (d_hi << 9) | d_lo) ?

Regards,
Kuan-Wei

> +	emit_16(ctx, 0x2017 | (d_lo << 9));				/* move.l (%sp), d_lo */
> +	emit_16(ctx, 0x2e80 | d_hi);					/* move.l d_hi, (%sp) */
> +	emit_cf_swap16(ctx, d_lo, d_hi);
> +	emit_16(ctx, 0x4840 | d_lo);					/* swap d_lo */
> +	emit_16(ctx, 0x809f | (d_lo << 9));				/* or.l (%sp)+, d_lo */
> +}
> +
>  static inline void emit_to_le32(struct jit_ctx *ctx, s8 d_lo, s8 d_hi)
>  {
>  	if (CPU_IS_COLDFIRE) {
> -		emit_16(ctx, 0x2f00 | d_lo);				/* move.l d_lo, -(%sp) */
> -		emit_16(ctx, 0x4840 | d_lo);				/* swap d_lo */
> -		emit_16(ctx, 0x71c0 | (d_lo << 9) | d_lo);		/* mvz.w d_lo, d_lo */
> -		emit_16(ctx, 0x7180 | (d_hi << 9) | d_lo);		/* mvz.b d_lo, d_hi */
> -		emit_16(ctx, 0xe088 | d_lo);				/* lsr.l #8, d_lo */
> -		emit_16(ctx, 0xe188 | d_hi);				/* lsl.l #8, d_hi */
> -		emit_16(ctx, 0x8080 | (d_hi << 9) | d_lo);		/* or.l d_lo, d_hi */
> -		emit_16(ctx, 0x2017 | (d_lo << 9));			/* move.l (%sp), d_lo */
> -		emit_16(ctx, 0x2e80 | d_hi);				/* move.l d_hi, (%sp) */
> -		emit_16(ctx, 0x71c0 | (d_lo << 9) | d_lo);		/* mvz.w d_lo, d_lo */
> -		emit_16(ctx, 0x7180 | (d_hi << 9) | d_lo);		/* mvz.b d_lo, d_hi */
> -		emit_16(ctx, 0xe088 | d_lo);				/* lsr.l #8, d_lo */
> -		emit_16(ctx, 0xe188 | d_hi);				/* lsl.l #8, d_hi */
> -		emit_16(ctx, 0x8080 | (d_lo << 9) | d_hi);		/* or.l d_hi, d_lo */
> -		emit_16(ctx, 0x4840 | d_lo);				/* swap d_lo */
> -		emit_16(ctx, 0x809f | (d_lo << 9));			/* or.l (%sp)+, d_lo */
> +		emit_cf_swap32(ctx, d_lo, d_hi);
>  	} else {
>  		emit_16(ctx, 0xe058 | d_lo);				/* ror.w #8, d_lo */
>  		emit_16(ctx, 0x4840 | d_lo);				/* swap d_lo */
> @@ -688,45 +691,12 @@
>  static inline void emit_to_le64(struct jit_ctx *ctx, s8 d_lo, s8 d_hi)
>  {
>  	if (CPU_IS_COLDFIRE) {
> -		emit_16(ctx, 0x2f00 | d_lo);				/* move.l d_lo, -(%sp) */
>  		emit_16(ctx, 0x2f00 | d_hi);				/* move.l d_hi, -(%sp) */
> -
> -		emit_16(ctx, 0x4840 | d_lo);				/* swap d_lo */
> -		emit_16(ctx, 0x71c0 | (d_lo << 9) | d_lo);		/* mvz.w d_lo, d_lo */
> -		emit_16(ctx, 0x7180 | (d_hi << 9) | d_lo);		/* mvz.b d_lo, d_hi */
> -		emit_16(ctx, 0xe088 | d_lo);				/* lsr.l #8, d_lo */
> -		emit_16(ctx, 0xe188 | d_hi);				/* lsl.l #8, d_hi */
> -		emit_16(ctx, 0x8080 | (d_hi << 9) | d_lo);		/* or.l d_lo, d_hi */
> -		emit_16(ctx, 0x202f | (d_lo << 9));			/* move.l 4(%sp), d_lo */
> -		emit_16(ctx, 0x0004);
> -		emit_16(ctx, 0x2f40 | d_hi);				/* move.l d_hi, 4(%sp) */
> -		emit_16(ctx, 0x0004);
> -		emit_16(ctx, 0x71c0 | (d_lo << 9) | d_lo);		/* mvz.w d_lo, d_lo */
> -		emit_16(ctx, 0x7180 | (d_hi << 9) | d_lo);		/* mvz.b d_lo, d_hi */
> -		emit_16(ctx, 0xe088 | d_lo);				/* lsr.l #8, d_lo */
> -		emit_16(ctx, 0xe188 | d_hi);				/* lsl.l #8, d_hi */
> -		emit_16(ctx, 0x8080 | (d_lo << 9) | d_hi);		/* or.l d_hi, d_lo */
> -		emit_16(ctx, 0x4840 | d_lo);				/* swap d_lo */
> -		emit_16(ctx, 0x81af | (d_lo << 9));			/* or.l d_lo, 4(%sp) */
> -		emit_16(ctx, 0x0004);
> -
> -		emit_16(ctx, 0x2017 | (d_lo << 9));			/* move.l (%sp), d_lo */
> -		emit_16(ctx, 0x4840 | d_lo);				/* swap d_lo */
> -		emit_16(ctx, 0x71c0 | (d_lo << 9) | d_lo);		/* mvz.w d_lo, d_lo */
> -		emit_16(ctx, 0x7180 | (d_hi << 9) | d_lo);		/* mvz.b d_lo, d_hi */
> -		emit_16(ctx, 0xe088 | d_lo);				/* lsr.l #8, d_lo */
> -		emit_16(ctx, 0xe188 | d_hi);				/* lsl.l #8, d_hi */
> -		emit_16(ctx, 0x8080 | (d_hi << 9) | d_lo);		/* or.l d_lo, d_hi */
> +		emit_cf_swap32(ctx, d_lo, d_hi);
> +		emit_16(ctx, 0x2000 | (d_lo << 9) | d_hi);		/* move.l d_lo, d_hi */
>  		emit_16(ctx, 0x2017 | (d_lo << 9));			/* move.l (%sp), d_lo */
>  		emit_16(ctx, 0x2e80 | d_hi);				/* move.l d_hi, (%sp) */
> -		emit_16(ctx, 0x71c0 | (d_lo << 9) | d_lo);		/* mvz.w d_lo, d_lo */
> -		emit_16(ctx, 0x7180 | (d_hi << 9) | d_lo);		/* mvz.b d_lo, d_hi */
> -		emit_16(ctx, 0xe088 | d_lo);				/* lsr.l #8, d_lo */
> -		emit_16(ctx, 0xe188 | d_hi);				/* lsl.l #8, d_hi */
> -		emit_16(ctx, 0x8080 | (d_lo << 9) | d_hi);		/* or.l d_hi, d_lo */
> -		emit_16(ctx, 0x4840 | d_lo);				/* swap d_lo */
> -		emit_16(ctx, 0x809f | (d_lo << 9));			/* or.l (%sp)+, d_lo */
> -
> +		emit_cf_swap32(ctx, d_lo, d_hi);
>  		emit_16(ctx, 0x201f | (d_hi << 9));			/* move.l (%sp)+, d_hi */
>  	} else {
>  		emit_16(ctx, 0xe058 | d_lo);				/* ror.w #8, d_lo */
> 
> 
> 
> 
