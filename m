Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 453EB3ADB89
	for <bpf@vger.kernel.org>; Mon, 10 Aug 2026 10:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786356284; cv=none; b=SVLIaaRkFJwhop4e4u2FMsncZSWE1wmBFudhzFCESHjMmQdT2q63zxxkl2IgbwBf+6YiPuis2dDGgmpNUcpQDfHPhu8UoqzUktk/YDv9P0ICWrk7urixHn42K+QO3+qf3bwj1h64mUduNs7XZtU1/Pz5EI++5DzNPwRmxe/dklc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786356284; c=relaxed/simple;
	bh=0eNUPRivkAyDw/X7eJVx32WSlAmJ9DhWWDFsEWjMms8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EH0JYEigMlNrHzbnPDSrcR1NRepXSBwqsJnXD0n62gnk5B6xmpjTSSsZ1vTtcUtDvoZr7Ud3ckR8zeaU3TAkhm2t3oAJ3Mg45HmFqDwb2acVQCKzORAY/JcKGulwLpCuIE8GW12Imzrxr3/qLddACI4AgszdRPFwgNtNvV/oI84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ky4l2XRL; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ky4l2XRL"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2cc61541f8cso45278695ad.0
        for <bpf@vger.kernel.org>; Mon, 10 Aug 2026 03:04:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786356281; x=1786961081; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ozYwJFDdFS/FQLP5HU1mX4pl18ZEOjlEIMxgrzg5xvk=;
        b=Ky4l2XRLtRNtR8MH0VhlY6PiB8Uh5pE/ZQgc6ZQyKQ6RT1ZIB7hlLy001xgEw7nrFn
         ELrVGR/FkbT/tPv9H4scoO9XeGukOJufy450BIJckKwWF5jGy2hb346sZ+mhkl57D6kO
         TjTKsqalMuVLFhDBT2ypXj7y6YRO/vFWKIo58fp9e3d30cdlM+Ww9tA42UzQZuOiP97m
         1XH1iP+Oa0Vl76fsK3vi4uwPv9jxRT408BR0S4pvBNlrA82VGZojWO+juLqJkEtNYqaD
         NqXejZkVelZpYbzEgV0UyU8b02j6A1tlN9o5XXCti9SH9uy/GaLHwwZIelbazMGVe0KX
         kj7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786356281; x=1786961081;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ozYwJFDdFS/FQLP5HU1mX4pl18ZEOjlEIMxgrzg5xvk=;
        b=qcVXd92FIszyDsCipVR1SxVCAZ/7sAZTeyzL1EquHAhLiL6B9hXxiHP8rjxRmG8B7p
         YEwTphv8RArPnpz4MxeseumRMRBTXwV4h4EeDD7zKkFurRvO+FsC9FyGOjvW2edMYi6E
         lcHoxqYufxVaK6baO+0+Ndawiv14x3O7Tpvsu5jefbVgIo8ngecHR8ICXWxK5HjYOuFt
         sJNsOLZxWkvS23k3MB6iyUGPng33+wb2BCnOiIu3AZNUWooyESe/93tSni885Rnro362
         9YGKpjhaLBcA9M9cf9+oN1UvuHX8J1ULeAu0GAjJNkXHiqhs9m0gvgobf+r/1k2J7akn
         6COA==
X-Forwarded-Encrypted: i=1; AHgh+RrYX1kYdlWPBU/K3hsUmiJWUsKsIZkVcpxRMz6IGqvcn6U6uJ/18BtTID3XfF8J5y7UKSQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpTijQhyk0TcWHud85n7Zy1qFmbMFXAZBVrLdKfhOUnUCMzSFP
	qmBMvH+dmVzexHf5Fl141tmtCdSxkwFqR7q3vVfRLUcLcL97GwhKSjFt
X-Gm-Gg: AR+sD116nvl6J6lEBkEx16s/MYezYcXypOUi8275LQT0nOpDpmcaDux8i3K0SdnvF7T
	HnMSWMRskJmhjghnoUIOfIhRZoBTWLbltQgRhClT6q8NqEW4qy5eozeTfsLJFKJ0VPjyVtuJld1
	kO9SwPhPRwdSSf0WhKvVcfDTU4M2rlgpvvd3donJsJCpyRF6Rg+15qeFe80M7ZpP/uyBBsQu8HS
	muk+jGw9wtbNZrGm+Yqm4+pqP859FsUpU4SlmAH0D8+r9r5cK/oDmMH+ps/Ai9n67Eg/k8MoHtb
	F0hF5xLRdb/ZWKYTSRc3GmnXDNX5dUauKEFLx6XRrDLmIDM5V1wa4GB2oJv8df6blNAViS1L6p/
	hQnJGrML0I7rjhUdmCb/ls9Qy4MdJ9tGtfBTjlh70Uu2jONh/GNt+eAgEFL4zGiHt/2M+IUlvP3
	ni6YSZHVNiaRMbJDFwHFDEx1ggzJREAhsTwBh5pKKN22h1PHd+Q7/FN7X6WvXD0Q==
X-Received: by 2002:a17:902:ccc9:b0:2cc:db7a:251 with SMTP id d9443c01a7336-2d2b2d8ec9emr202193325ad.2.1786356281230;
        Mon, 10 Aug 2026 03:04:41 -0700 (PDT)
Received: from google.com ([103.137.210.175])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d16c50ef1asm33063605ad.83.2026.08.10.03.04.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 03:04:40 -0700 (PDT)
Date: Mon, 10 Aug 2026 18:04:32 +0800
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: Greg Ungerer <gerg@polyxeno.com>
Cc: geert@linux-m68k.org, ast@kernel.org, daniel@iogearbox.net,
	andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com,
	martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
	jolsa@kernel.org, jserv@ccns.ncku.edu.tw, eleanor15x@gmail.com,
	marscheng@google.com, linux-kernel@vger.kernel.org,
	linux-m68k@lists.linux-m68k.org, bpf@vger.kernel.org,
	Daniel Palmer <daniel@thingy.jp>
Subject: Re: [PATCH bpf-next v4 RESEND] m68k, bpf: Add initial BPF JIT
 compiler support
Message-ID: <anmiML76I1qSiZLL@google.com>
References: <20260729002737.1008358-1-visitorckw@gmail.com>
 <1ade6c35-7f8a-406d-9c89-8d10218258c6@polyxeno.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1ade6c35-7f8a-406d-9c89-8d10218258c6@polyxeno.com>

Hi Greg,

On Fri, Aug 07, 2026 at 01:28:20AM +1000, Greg Ungerer wrote:
> Hi Kuan-Wei,
> 
> On 29/7/26 10:27, Kuan-Wei Chiu wrote:
> > Add a BPF JIT compiler for the m68k architecture.
> > 
> > The JIT generates m68k machine code targeting m68020+ processors. It
> > currently excludes 68000/68010 and coldfire processors, as it relies on
> > 32 bit branch displacements (b<cc>.l) to handle large bpf programs.
> 
> I was interested to see how difficult this would be to get working on
> a ColdFire target. There is a little more to it than just the 32bit
> branch displacements. If you limit the target space to ColdFire parts
> that have an MMU (so parts that have the ISA_B or ISA_C instruction
> set) then 32bit branch displacements are supported. So that is no longer
> a problem.
> 
> The following are issues I hit:
> 
> 1. lack of movem with pre-decrement and post-increment modes
>    used in quite a few places
> 
> 2. lack of register exchange instruction ("exg")
>    used in emit_atomic()
>    used in emit_call()
>    used in 64bit bpf shitf operations in emit_alu64_shift()
> 
> 3. lack of rotate instructions ("ror" and "rox")
>    used for bpf shift operations in emit_alu64_shift()
>    used for endian transformation in emit_bpf_end()
> 
> Issue (1) is easy to work around, manually manipulating %sp as required
> with an extra instruction.
> 
> Issue (2) also is easy enough, needing temporary storage.
> 
> Issue (3) is annoying and means a bunch more instructions to carry
> out the equivalent operations. None the less it is not too difficult to
> modify for. ISA_C does have a "byterev" instruction that would make this
> really easy - but only the very most modern ColdFire silicon use that
> (like the 5441x family).
> 
> The attached patch is my first pass at it. It works and passes the
> test_bpf.ko module with no failures(*). Surely could be optimized a little
> more, but good enough to get it working. Tested and running on an
> M5475 ColdFire target.
> 
>     test_bpf: Summary: 1061 PASSED, 0 FAILED, [1049/1049 JIT'ed]
>     test_bpf: test_tail_calls: Summary: 10 PASSED, 0 FAILED, [10/10 JIT'ed]
> 
> 
> (*) I did come across a cache flush issue specific to ColdFire - but it
> is not related to this code and can be worked around.
> 
> 

Thanks for testing the jit and providing the patch to enable coldfire
support. It's great to see it running successfully on the M5475 target.

For v5, please let me know how you would prefer to proceed. I can
either squash your changes directly into my current patch, or keep your
work as an independent patch and send them together as a patch series.
Let me know what works best for you.

Regards,
Kuan-Wei
> 

> --- a/arch/m68k/net/bpf_jit_comp.c
> +++ b/arch/m68k/net/bpf_jit_comp.c
> @@ -518,6 +518,47 @@
>  	bpf_put_reg32(dst[0], d_hi, ctx);
>  }
>  
> +static inline void emit_lsh64(struct jit_ctx *ctx, s8 d_lo, s8 d_hi)
> +{
> +	if (CPU_IS_COLDFIRE) {
> +		emit_16(ctx, 0xd080 | (d_lo << 9) | d_lo);		/* add.l d_lo, d_lo */
> +		emit_16(ctx, 0xd180 | (d_hi << 9) | d_hi);		/* addx.l d_hi, d_hi */
> +	} else {
> +		emit_16(ctx, 0xe388 | d_lo);				/* lsll #1, d_lo */
> +		emit_16(ctx, 0xe390 | d_hi);				/* roxl.l #1, d_hi */
> +	}
> +}
> +
> +static inline void emit_rsh64(struct jit_ctx *ctx, s8 d_lo, s8 d_hi)
> +{
> +	if (CPU_IS_COLDFIRE) {
> +		emit_16(ctx, 0xe288 | d_lo);				/* lsr.l #1, d_lo */
> +		emit_16(ctx, 0xe288 | d_hi);				/* lsr.l #1, d_hi */
> +		emit_16(ctx, 0x6400);					/* bcc 1f */
> +		emit_16(ctx, 0x0006);
> +		emit_16(ctx, 0x08c0 | d_lo);				/* bset #31, d_lo */
> +		emit_16(ctx, 0x001f);
> +	} else {
> +		emit_16(ctx, 0xe288 | d_hi);				/* lsrl #1, d_hi */
> +		emit_16(ctx, 0xe290 | d_lo);				/* roxr.l #1, d_lo */
> +	}
> +}
> +
> +static inline void emit_arsh64(struct jit_ctx *ctx, s8 d_lo, s8 d_hi)
> +{
> +	if (CPU_IS_COLDFIRE) {
> +		emit_16(ctx, 0xe288 | d_lo);				/* lsr.l #1, d_lo */
> +		emit_16(ctx, 0xe280 | d_hi);				/* asr.l #1, d_hi */
> +		emit_16(ctx, 0x6400);					/* bcc 1f */
> +		emit_16(ctx, 0x0006);
> +		emit_16(ctx, 0x08c0 | d_lo);				/* bset #31, d_lo */
> +		emit_16(ctx, 0x001f);
> +	} else {
> +		emit_16(ctx, 0xe280 | d_hi);				/* asrl #1, d_hi */
> +		emit_16(ctx, 0xe290 | d_lo);				/* roxr.l #1, d_lo */
> +	}
> +}
> +
>  static void emit_alu64_shift(const struct bpf_insn *insn, struct jit_ctx *ctx, bool is_imm)
>  {
>  	const s8 *dst = bpf2m68k[insn->dst_reg];
> @@ -551,16 +592,12 @@
>  
>  	loop_start = ctx->idx;
>  
> -	if (BPF_OP(insn->code) == BPF_LSH) {
> -		emit_16(ctx, 0xe388 | d_lo);				/* lsll #1, d_lo */
> -		emit_16(ctx, 0xe390 | d_hi);				/* roxl.l #1, d_hi */
> -	} else if (BPF_OP(insn->code) == BPF_RSH) {
> -		emit_16(ctx, 0xe288 | d_hi);				/* lsrl #1, d_hi */
> -		emit_16(ctx, 0xe290 | d_lo);				/* roxr.l #1, d_lo */
> -	} else if (BPF_OP(insn->code) == BPF_ARSH) {
> -		emit_16(ctx, 0xe280 | d_hi);				/* asrl #1, d_hi */
> -		emit_16(ctx, 0xe290 | d_lo);				/* roxr.l #1, d_lo */
> -	}
> +	if (BPF_OP(insn->code) == BPF_LSH)
> +		emit_lsh64(ctx, d_lo, d_hi);
> +	else if (BPF_OP(insn->code) == BPF_RSH)
> +		emit_rsh64(ctx, d_lo, d_hi);
> +	else if (BPF_OP(insn->code) == BPF_ARSH)
> +		emit_arsh64(ctx, d_lo, d_hi);
>  
>  	emit_16(ctx, 0x5380 | count_reg);				/* subq.l #1, count_reg */
>  	emit_16(ctx, 0x6600);						/* bne.w loop_start */
> @@ -573,6 +610,107 @@
>  	bpf_put_reg32(dst[0], d_hi, ctx);
>  }
>  
> +static inline void emit_to_le16(struct jit_ctx *ctx, s8 d_lo, s8 d_hi)
> +{
> +	if (CPU_IS_COLDFIRE) {
> +		emit_16(ctx, 0x71c0 | (d_lo << 9) | d_lo);		/* mvz.w d_lo, d_lo */
> +		emit_16(ctx, 0x7180 | (d_hi << 9) | d_lo);		/* mvz.b d_lo, d_hi */
> +		emit_16(ctx, 0xe088 | d_lo);				/* lsr.l #8, d_lo */
> +		emit_16(ctx, 0xe188 | d_hi);				/* lsl.l #8, d_hi */
> +		emit_16(ctx, 0x8080 | (d_lo << 9) | d_hi);		/* or.l d_hi, d_lo */
> +	} else {
> +		emit_16(ctx, 0x0280 | d_lo);				/* andi.l #0xffff, d_lo */
> +		emit_32(ctx, 0xffff);
> +		emit_16(ctx, 0xe058 | d_lo);				/* ror.w #8, d_lo */
> +	}
> +
> +	emit_16(ctx, 0x7000 | (d_hi << 9));				/* moveq #0, d_hi */
> +}
> +
> +static inline void emit_to_le32(struct jit_ctx *ctx, s8 d_lo, s8 d_hi)
> +{
> +	if (CPU_IS_COLDFIRE) {
> +		emit_16(ctx, 0x2f00 | d_lo);				/* move.l d_lo, -(%sp) */
> +		emit_16(ctx, 0x4840 | d_lo);				/* swap d_lo */
> +		emit_16(ctx, 0x71c0 | (d_lo << 9) | d_lo);		/* mvz.w d_lo, d_lo */
> +		emit_16(ctx, 0x7180 | (d_hi << 9) | d_lo);		/* mvz.b d_lo, d_hi */
> +		emit_16(ctx, 0xe088 | d_lo);				/* lsr.l #8, d_lo */
> +		emit_16(ctx, 0xe188 | d_hi);				/* lsl.l #8, d_hi */
> +		emit_16(ctx, 0x8080 | (d_hi << 9) | d_lo);		/* or.l d_lo, d_hi */
> +		emit_16(ctx, 0x2017 | (d_lo << 9));			/* move.l (%sp), d_lo */
> +		emit_16(ctx, 0x2e80 | d_hi);				/* move.l d_hi, (%sp) */
> +		emit_16(ctx, 0x71c0 | (d_lo << 9) | d_lo);		/* mvz.w d_lo, d_lo */
> +		emit_16(ctx, 0x7180 | (d_hi << 9) | d_lo);		/* mvz.b d_lo, d_hi */
> +		emit_16(ctx, 0xe088 | d_lo);				/* lsr.l #8, d_lo */
> +		emit_16(ctx, 0xe188 | d_hi);				/* lsl.l #8, d_hi */
> +		emit_16(ctx, 0x8080 | (d_lo << 9) | d_hi);		/* or.l d_hi, d_lo */
> +		emit_16(ctx, 0x4840 | d_lo);				/* swap d_lo */
> +		emit_16(ctx, 0x809f | (d_lo << 9));			/* or.l (%sp)+, d_lo */
> +	} else {
> +		emit_16(ctx, 0xe058 | d_lo);				/* ror.w #8, d_lo */
> +		emit_16(ctx, 0x4840 | d_lo);				/* swap d_lo */
> +		emit_16(ctx, 0xe058 | d_lo);				/* ror.w #8, d_lo */
> +	}
> +
> +	emit_16(ctx, 0x7000 | (d_hi << 9));				/* moveq #0, d_hi */
> +}
> +
> +static inline void emit_to_le64(struct jit_ctx *ctx, s8 d_lo, s8 d_hi)
> +{
> +	if (CPU_IS_COLDFIRE) {
> +		emit_16(ctx, 0x2f00 | d_lo);				/* move.l d_lo, -(%sp) */
> +		emit_16(ctx, 0x2f00 | d_hi);				/* move.l d_hi, -(%sp) */
> +
> +		emit_16(ctx, 0x4840 | d_lo);				/* swap d_lo */
> +		emit_16(ctx, 0x71c0 | (d_lo << 9) | d_lo);		/* mvz.w d_lo, d_lo */
> +		emit_16(ctx, 0x7180 | (d_hi << 9) | d_lo);		/* mvz.b d_lo, d_hi */
> +		emit_16(ctx, 0xe088 | d_lo);				/* lsr.l #8, d_lo */
> +		emit_16(ctx, 0xe188 | d_hi);				/* lsl.l #8, d_hi */
> +		emit_16(ctx, 0x8080 | (d_hi << 9) | d_lo);		/* or.l d_lo, d_hi */
> +		emit_16(ctx, 0x202f | (d_lo << 9));			/* move.l 4(%sp), d_lo */
> +		emit_16(ctx, 0x0004);
> +		emit_16(ctx, 0x2f40 | d_hi);				/* move.l d_hi, 4(%sp) */
> +		emit_16(ctx, 0x0004);
> +		emit_16(ctx, 0x71c0 | (d_lo << 9) | d_lo);		/* mvz.w d_lo, d_lo */
> +		emit_16(ctx, 0x7180 | (d_hi << 9) | d_lo);		/* mvz.b d_lo, d_hi */
> +		emit_16(ctx, 0xe088 | d_lo);				/* lsr.l #8, d_lo */
> +		emit_16(ctx, 0xe188 | d_hi);				/* lsl.l #8, d_hi */
> +		emit_16(ctx, 0x8080 | (d_lo << 9) | d_hi);		/* or.l d_hi, d_lo */
> +		emit_16(ctx, 0x4840 | d_lo);				/* swap d_lo */
> +		emit_16(ctx, 0x81af | (d_lo << 9));			/* or.l d_lo, 4(%sp) */
> +		emit_16(ctx, 0x0004);
> +
> +		emit_16(ctx, 0x2017 | (d_lo << 9));			/* move.l (%sp), d_lo */
> +		emit_16(ctx, 0x4840 | d_lo);				/* swap d_lo */
> +		emit_16(ctx, 0x71c0 | (d_lo << 9) | d_lo);		/* mvz.w d_lo, d_lo */
> +		emit_16(ctx, 0x7180 | (d_hi << 9) | d_lo);		/* mvz.b d_lo, d_hi */
> +		emit_16(ctx, 0xe088 | d_lo);				/* lsr.l #8, d_lo */
> +		emit_16(ctx, 0xe188 | d_hi);				/* lsl.l #8, d_hi */
> +		emit_16(ctx, 0x8080 | (d_hi << 9) | d_lo);		/* or.l d_lo, d_hi */
> +		emit_16(ctx, 0x2017 | (d_lo << 9));			/* move.l (%sp), d_lo */
> +		emit_16(ctx, 0x2e80 | d_hi);				/* move.l d_hi, (%sp) */
> +		emit_16(ctx, 0x71c0 | (d_lo << 9) | d_lo);		/* mvz.w d_lo, d_lo */
> +		emit_16(ctx, 0x7180 | (d_hi << 9) | d_lo);		/* mvz.b d_lo, d_hi */
> +		emit_16(ctx, 0xe088 | d_lo);				/* lsr.l #8, d_lo */
> +		emit_16(ctx, 0xe188 | d_hi);				/* lsl.l #8, d_hi */
> +		emit_16(ctx, 0x8080 | (d_lo << 9) | d_hi);		/* or.l d_hi, d_lo */
> +		emit_16(ctx, 0x4840 | d_lo);				/* swap d_lo */
> +		emit_16(ctx, 0x809f | (d_lo << 9));			/* or.l (%sp)+, d_lo */
> +
> +		emit_16(ctx, 0x201f | (d_hi << 9));			/* move.l (%sp)+, d_hi */
> +	} else {
> +		emit_16(ctx, 0xe058 | d_lo);				/* ror.w #8, d_lo */
> +		emit_16(ctx, 0x4840 | d_lo);				/* swap d_lo */
> +		emit_16(ctx, 0xe058 | d_lo);				/* ror.w #8, d_lo */
> +
> +		emit_16(ctx, 0xe058 | d_hi);				/* ror.w #8, d_hi */
> +		emit_16(ctx, 0x4840 | d_hi);				/* swap d_hi */
> +		emit_16(ctx, 0xe058 | d_hi);				/* ror.w #8, d_hi */
> +
> +		emit_16(ctx, 0xc140 | (d_hi << 9) | d_lo);		/* exg d_lo, d_hi */
> +	}
> +}
> +
>  static void emit_bpf_end(const struct bpf_insn *insn, struct jit_ctx *ctx)
>  {
>  	const s8 *dst = bpf2m68k[insn->dst_reg];
> @@ -587,27 +725,13 @@
>  	if (to_le) {
>  		switch (imm) {
>  		case 16:
> -			emit_16(ctx, 0x0280 | d_lo);			/* andi.l #0xffff, d_lo */
> -			emit_32(ctx, 0xffff);
> -			emit_16(ctx, 0xe058 | d_lo);			/* ror.w #8, d_lo */
> -			emit_16(ctx, 0x7000 | (d_hi << 9));		/* moveq #0, d_hi */
> +			emit_to_le16(ctx, d_lo, d_hi);
>  			break;
>  		case 32:
> -			emit_16(ctx, 0xe058 | d_lo);			/* ror.w #8, d_lo */
> -			emit_16(ctx, 0x4840 | d_lo);			/* swap d_lo */
> -			emit_16(ctx, 0xe058 | d_lo);			/* ror.w #8, d_lo */
> -			emit_16(ctx, 0x7000 | (d_hi << 9));		/* moveq #0, d_hi */
> +			emit_to_le32(ctx, d_lo, d_hi);
>  			break;
>  		case 64:
> -			emit_16(ctx, 0xe058 | d_lo);			/* ror.w #8, d_lo */
> -			emit_16(ctx, 0x4840 | d_lo);			/* swap d_lo */
> -			emit_16(ctx, 0xe058 | d_lo);			/* ror.w #8, d_lo */
> -
> -			emit_16(ctx, 0xe058 | d_hi);			/* ror.w #8, d_hi */
> -			emit_16(ctx, 0x4840 | d_hi);			/* swap d_hi */
> -			emit_16(ctx, 0xe058 | d_hi);			/* ror.w #8, d_hi */
> -
> -			emit_16(ctx, 0xc140 | (d_hi << 9) | d_lo);	/* exg d_lo, d_hi */
> +			emit_to_le64(ctx, d_lo, d_hi);
>  			break;
>  		}
>  	} else {
> @@ -692,8 +816,8 @@
>  	}
>  
>  	if (is_64) {
> -		emit_16(ctx, 0x48e7);					/* movem.l d0-d1, -(%sp) */
> -		emit_16(ctx, 0xc000);
> +		emit_16(ctx, 0x2f01);					/* move.l d1, -(%sp) */
> +		emit_16(ctx, 0x2f00);					/* move.l d0, -(%sp) */
>  
>  		emit_16(ctx, 0x2f00 | s_lo);				/* move.l s_lo, -(%sp) */
>  		emit_16(ctx, 0x2f00 | s_hi);				/* move.l s_hi, -(%sp) */
> @@ -710,11 +834,11 @@
>  		emit_16(ctx, 0x2601);					/* move.l %d1, %d3 */
>  		emit_16(ctx, 0x2400);					/* move.l %d0, %d2 */
>  
> -		emit_16(ctx, 0x4cdf);					/* movem.l (%sp)+, d0-d1 */
> -		emit_16(ctx, 0x0003);
> +		emit_16(ctx, 0x201f);					/* move.l (%sp)+, d0 */
> +		emit_16(ctx, 0x221f);					/* move.l (%sp)+, d1 */
>  	} else {
> -		emit_16(ctx, 0x48e7);					/* movem.l d0-d1, -(%sp) */
> -		emit_16(ctx, 0xc000);
> +		emit_16(ctx, 0x2f01);					/* move.l d1, -(%sp) */
> +		emit_16(ctx, 0x2f00);					/* move.l d0, -(%sp) */
>  
>  		emit_16(ctx, 0x2f00 | s_lo);				/* move.l s_lo, -(%sp) */
>  		emit_16(ctx, 0x2f00 | d_lo);				/* move.l d_lo, -(%sp) */
> @@ -729,8 +853,8 @@
>  		emit_16(ctx, 0x2600);					/* move.l %d0, %d3 */
>  		emit_16(ctx, 0x7400);					/* moveq #0, %d2 */
>  
> -		emit_16(ctx, 0x4cdf);					/* movem.l (%sp)+, d0-d1 */
> -		emit_16(ctx, 0x0003);
> +		emit_16(ctx, 0x201f);					/* move.l (%sp)+, d0 */
> +		emit_16(ctx, 0x221f);					/* move.l (%sp)+, d1 */
>  	}
>  
>  	bpf_put_reg32(dst[1], M68K_D3, ctx);
> @@ -905,8 +1029,8 @@
>  		s8 s_lo = bpf_get_reg32(src[1], tmp2[1], ctx);
>  
>  		if (insn->imm != BPF_CMPXCHG) {
> -			emit_16(ctx, 0x48e7);			/* movem.l d0-d1, -(%sp) */
> -			emit_16(ctx, 0xc000);
> +			emit_16(ctx, 0x2f01);			/* move.l d1, -(%sp) */
> +			emit_16(ctx, 0x2f00);			/* move.l d0, -(%sp) */
>  		}
>  
>  		emit_16(ctx, 0x2f00 | M68K_D0);			/* move.l %d0, -(%sp) */
> @@ -930,8 +1054,8 @@
>  			if (is_fetch)
>  				emit_16(ctx, 0x2600);		/* move.l %d0, %d3 */
>  
> -			emit_16(ctx, 0x4cdf);			/* movem.l (%sp)+, d0-d1 */
> -			emit_16(ctx, 0x0003);
> +			emit_16(ctx, 0x201f);			/* move.l (%sp)+, d0 */
> +			emit_16(ctx, 0x221f);			/* move.l (%sp)+, d1 */
>  
>  			if (is_fetch) {
>  				bpf_put_reg32(src[1], M68K_D3, ctx);
> @@ -945,8 +1069,8 @@
>  		s8 s_hi = bpf_get_reg32(src[0], tmp2[0], ctx);
>  
>  		if (insn->imm != BPF_CMPXCHG) {
> -			emit_16(ctx, 0x48e7);			/* movem.l d0-d1, -(%sp) */
> -			emit_16(ctx, 0xc000);
> +			emit_16(ctx, 0x2f01);			/* move.l d1, -(%sp) */
> +			emit_16(ctx, 0x2f00);			/* move.l d0, -(%sp) */
>  		}
>  
>  		emit_16(ctx, 0x2f00 | M68K_D0);			/* move.l %d0, -(%sp) */
> @@ -965,7 +1089,13 @@
>  		emit_16(ctx, 24);
>  
>  		if (insn->imm == BPF_CMPXCHG) {
> -			emit_16(ctx, 0xc141);			/* exg %d0, %d1 */
> +			if (CPU_IS_COLDFIRE) {
> +				emit_16(ctx, 0x2f00);		/* move.l %d0, -(%sp) */
> +				emit_16(ctx, 0x2001);		/* move.l %d1, %d0 */
> +				emit_16(ctx, 0x221f);		/* move.l (%sp)+, %d1 */
> +			} else {
> +				emit_16(ctx, 0xc141);		/* exg %d0, %d1 */
> +			}
>  		} else {
>  			bool is_fetch = (insn->imm & BPF_FETCH) || insn->imm == BPF_XCHG;
>  
> @@ -974,8 +1104,8 @@
>  				emit_16(ctx, 0x2401);		/* move.l %d1, %d2 */
>  			}
>  
> -			emit_16(ctx, 0x4cdf);			/* movem.l (%sp)+, d0-d1 */
> -			emit_16(ctx, 0x0003);
> +			emit_16(ctx, 0x201f);			/* move.l (%sp)+, d0 */
> +			emit_16(ctx, 0x221f);			/* move.l (%sp)+, d1 */
>  
>  			if (is_fetch) {
>  				bpf_put_reg32(src[1], M68K_D2, ctx);
> @@ -1244,8 +1374,15 @@
>  	emit_16(ctx, 0x4fef);					/* lea 40(%sp), %sp */
>  	emit_16(ctx, 40);
>  
> -	if (insn->src_reg != BPF_PSEUDO_CALL)
> -		emit_16(ctx, 0xc340);					/* exg %d0, %d1 */
> +	if (insn->src_reg != BPF_PSEUDO_CALL) {
> +		if (CPU_IS_COLDFIRE) {
> +			emit_16(ctx, 0x2f00);			/* move.l %d0, -(%sp) */
> +			emit_16(ctx, 0x2001);			/* move.l %d1, %d0 */
> +			emit_16(ctx, 0x221f);			/* move.l (%sp)+, %d1 */
> +		} else {
> +			emit_16(ctx, 0xc340);			/* exg %d0, %d1 */
> +		}
> +	}
>  
>  	return 0;
>  }
> @@ -1261,8 +1398,15 @@
>  	emit_16(ctx, 0x4e56);					/* link %a6, #-total_stack */
>  	emit_16(ctx, -total_stack);
>  
> -	emit_16(ctx, 0x48e7);					/* movem.l d2-d5, -(%sp) */
> -	emit_16(ctx, 0x3c00);
> +	if (CPU_IS_COLDFIRE) {
> +		emit_16(ctx, 0x4fef);				/* lea -16(%sp), %sp */
> +		emit_16(ctx, 0xfff0);
> +		emit_16(ctx, 0x48d7);				/* movem.l d2-d5, (%sp) */
> +		emit_16(ctx, 0x003c);
> +	} else {
> +		emit_16(ctx, 0x48e7);				/* movem.l d2-d5, -(%sp) */
> +		emit_16(ctx, 0x3c00);
> +	}
>  
>  	emit_16(ctx, 0x2d40);					/* move.l %d0, off(%fp) */
>  	emit_16(ctx, (u16)STACK_OFFSET(BPF_TC_LO));
> @@ -1302,8 +1446,15 @@
>  
>  static void build_epilogue(struct jit_ctx *ctx)
>  {
> -	emit_16(ctx, 0x4cdf);					/* movem.l (%sp)+, d2-d5 */
> -	emit_16(ctx, 0x003c);
> +	if (CPU_IS_COLDFIRE) {
> +		emit_16(ctx, 0x4cd7);				/* movem.l (%sp), d2-d5 */
> +		emit_16(ctx, 0x003c);
> +		emit_16(ctx, 0x4fef);				/* lea 16(%sp), %sp */
> +		emit_16(ctx, 0x0010);
> +	} else {
> +		emit_16(ctx, 0x4cdf);				/* movem.l (%sp)+, d2-d5 */
> +		emit_16(ctx, 0x003c);
> +	}
>  
>  	emit_16(ctx, 0x4e5e);					/* unlk %fp */
>  	emit_16(ctx, 0x4e75);					/* rts */
> --- a/arch/m68k/Kconfig
> +++ b/arch/m68k/Kconfig
> @@ -8,7 +8,7 @@
>  	select ARCH_HAS_CPU_FINALIZE_INIT if MMU
>  	select ARCH_HAS_CURRENT_STACK_POINTER
>  	select ARCH_HAS_DMA_PREP_COHERENT if M68K_NONCOHERENT_DMA && !COLDFIRE
> -	select HAVE_EBPF_JIT if (!COLDFIRE && !M68000)
> +	select HAVE_EBPF_JIT if MMU
>  	select ARCH_HAS_SYNC_DMA_FOR_DEVICE if M68K_NONCOHERENT_DMA
>  	select ARCH_HAVE_NMI_SAFE_CMPXCHG if RMW_INSNS
>  	select ARCH_MIGHT_HAVE_PC_PARPORT if ISA

