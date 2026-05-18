Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F5863815D4
	for <bpf@vger.kernel.org>; Mon, 18 May 2026 17:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779124892; cv=none; b=eEuPHy3pcmurk1TOJ6Yp27wzvKey9HXQOrQpTx7smdXdY86JZ0KliyO2dnaIScx163PN6wMQT9FhWUexi5s/7IFqfWw36dOXtBdNC4nL77uEkIA3Cpo6JytsCiCy1d4XJcDLuFw+bGNbZIcgLaE0W4vtptfc7xogMIanj4G0ZgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779124892; c=relaxed/simple;
	bh=lmIpfVH09uw6skieK6a7+eAdiOZHXfLwP/3VvLrBdkM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SfjLpgKhrLYMSP9Zwka9ENiaMhyzCEF/f9GK9eKcazu7SVviDhXmOOvuwH2URVD3iQ9KxrCRI9tod8iutsdnOVbWFCmc0uZHgK2pD4NVDU1DNsMPO4EwbfOEQ6fHmK9LLoKJUZH2vYGay558DNTx4sBF0i/pY4MYHM0dFqVL1Gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L69afiLV; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L69afiLV"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2bcd730e090so19794625ad.2
        for <bpf@vger.kernel.org>; Mon, 18 May 2026 10:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779124891; x=1779729691; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=byQGBQ0gkbnM4aMKl0MiGQ340VfWIeN70GJT/M+hFdU=;
        b=L69afiLVASluCEriTzU5pHyC9gx4gjV9+yJD5MdKZi5wngQRkzFvDUEqAu4sMVwTW4
         XcohFLr66V1DHjzLZkYyvPaMEJNdocfeA8hyg1QvgPrpGahl8d9eYaJU85ousV7fKtVq
         WAhaa7AmKQ+nx9BNNGkgPUciDCLswbuH6WBkihxVMYHOYw3X1ZogzfjsbG5eXOFj27lZ
         zOtzcpnOZCO53dm/9aBkSYJon3tHJmqVha+8pJovqJdTiQxbVbEkyA7yGIbJHW0HPex6
         yrGKLz9PPpoyz4tit3uwJwUD6IVL+t4uKlw97zhajQA4e3y4ytpOKHn8SQZWqaPNIXFB
         Ezqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779124891; x=1779729691;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=byQGBQ0gkbnM4aMKl0MiGQ340VfWIeN70GJT/M+hFdU=;
        b=LcW9Xv4JQzkbagZ9ndXFgbDYntMr2cp4yMPIeWvhmJy8JkUP/lc7jUkdFJkfPF6Qh9
         ss8vSnsV3NE5u4GlyirCItnmPQo9ZAa5Xs+rsG3hAmLGB9sZoZb7VWTfekqxUHcjN2Rk
         HP2QdAcPjORWximKQAGQN5hT23NutAD1VWPUuEav4veEwdklUVPAiUTL7MQbumpYA4SK
         jfZwinVv8Tdd5ebflBYA9LigR7VyQoAbSdToYR9dOcniSCCBKvJh7U3oGNU40YPA8Mpu
         b+Trv1rCusElkTg7NvlupOZmWr/0NKBZnASJ8nk2EsnkH2bbw77YxkCPQDTurUNiYOJf
         Q4Mg==
X-Forwarded-Encrypted: i=1; AFNElJ9kyTna1hbz4Qe6AKMnD/v6/bMCZ5tVskHWDSg/w19B66TCqorl8CbnkF+1tJ+FdFBifpw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz30trz0LhzV3OELFs/QIQX1TnQ0A6tgQHyUA1y0AyZ0AVUiJOY
	DfUI5xEq8kk1u2F9mBsAkM7vyeSufTk1lGPZkL7Aw/3ywls34H+nMCCs
X-Gm-Gg: Acq92OEAD76EdplNFIk2CM18d6535fIdthW6EDuWMuFrYM0qUMcwLety4pQXxuOBSTC
	lrkcWR3dCkQcCmYuJD1ZGrps4bZkr40kX/fFFYl+trrIHE1sN6ntOPdK2xalfGDALpteGP++ksz
	QHZCmgFT3hwpoi3TyKrbCQq8fTsrOZ3Hb4W+2lH1NpUBpaArzV1sNq3JUns6J6sr0Ny65J6mbfw
	8pTZHnRU5Lr/33m5rrPxuiicbyR1w0YLJaRZyl7kUT5fohmoWlyD+mUNCqc9cVyr54OcL+XFUfB
	moJ4P/hUKZkKbGcmCu6ePMELmOIW8wHTHrNP8P65gDmgzj1a5BhUAzrCTgIdYolrk2TE+PAtIig
	owhYzD0CkCOhWiK9PBW2yJbVKNN4aVEWDGGawapQH6KzE71UXUJmuH3/fzumh1uBQ0yCRf5exKX
	E4lrF1G6gtFmjGvWKupyPCp36hhCyDYWHIubMaKDIBqefK
X-Received: by 2002:a17:903:2284:b0:2b2:4bf9:1766 with SMTP id d9443c01a7336-2bd7e949015mr186264205ad.33.1779124890749;
        Mon, 18 May 2026 10:21:30 -0700 (PDT)
Received: from google.com ([118.150.148.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5bd5fb0csm145325175ad.17.2026.05.18.10.21.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 10:21:30 -0700 (PDT)
Date: Tue, 19 May 2026 01:21:24 +0800
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: bot+bpf-ci@kernel.org
Cc: geert@linux-m68k.org, ast@kernel.org, daniel@iogearbox.net,
	andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com,
	martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
	jolsa@kernel.org, jserv@ccns.ncku.edu.tw, eleanor15x@gmail.com,
	marscheng@google.com, linux-kernel@vger.kernel.org,
	linux-m68k@lists.linux-m68k.org, bpf@vger.kernel.org,
	daniel@thingy.jp, martin.lau@kernel.org, clm@meta.com,
	ihor.solodrai@linux.dev
Subject: Re: [PATCH bpf-next v3] m68k, bpf: Add initial BPF JIT compiler
 support
Message-ID: <agtKlJgezZCmAdcq@google.com>
References: <20260511212756.3163955-1-visitorckw@gmail.com>
 <85662b75ba1f428629fcb97491d0abe8f3fd93b257cd90766cb4604144dfc331@mail.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <85662b75ba1f428629fcb97491d0abe8f3fd93b257cd90766cb4604144dfc331@mail.kernel.org>

On Mon, May 11, 2026 at 10:12:31PM +0000, bot+bpf-ci@kernel.org wrote:
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index b2040011a386..261cc1124685 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -4699,6 +4699,12 @@ L:	bpf@vger.kernel.org
> >  S:	Maintained
> >  F:	arch/loongarch/net/
> >
> > +BPF JIT for M68K
> 
> This isn't a bug, but the surrounding BPF JIT entries all use lowercase
> 'for': 'BPF JIT for ARM', 'BPF JIT for ARM64', 'BPF JIT for LOONGARCH',
> 'BPF JIT for MIPS', etc. For consistency, should this be
> 'BPF JIT for M68K'?

I think this is an AI hallucination, as my patch already uses a
lowercase 'for'.

> 
> Reference: https://lore.kernel.org/bpf/20260429133910.6F6DCC19425@smtp.kernel.org/
> 
> > +M:	Kuan-Wei Chiu <visitorckw@gmail.com>
> > +L:	bpf@vger.kernel.org
> > +S:	Maintained
> > +F:	arch/m68k/net/
> > +
> >  BPF JIT for MIPS (32-BIT AND 64-BIT)
> >  M:	Johan Almbladh <johan.almbladh@anyfinetworks.com>
> >  M:	Paul Burton <paulburton@kernel.org>
> 
> [ ... ]
> 
> > diff --git a/arch/m68k/net/bpf_jit_comp.c b/arch/m68k/net/bpf_jit_comp.c
> > new file mode 100644
> > index 000000000000..1531b321410a
> > --- /dev/null
> > +++ b/arch/m68k/net/bpf_jit_comp.c
> 
> [ ... ]
> 
> > +static int emit_call(const struct bpf_insn *insn, struct jit_ctx *ctx)
> > +{
> > +	const s8 arg_regs[] = { BPF_REG_5, BPF_REG_4, BPF_REG_3, BPF_REG_2, BPF_REG_1 };
> > +	const s8 *tmp1 = bpf2m68k[TMP_REG_1];
> > +	bool extra_pass = ctx->target != NULL;
> > +	u64 func_addr;
> > +	bool fixed;
> > +	int i, err;
> > +
> > +	err = bpf_jit_get_func_addr(ctx->prog, insn, extra_pass, &func_addr, &fixed);
> > +	if (err)
> > +		return err;
> > +
> > +	for (i = 0; i < 5; i++) {
> > +		const s8 *reg = bpf2m68k[arg_regs[i]];
> > +		s8 d_lo = bpf_get_reg32(reg[1], tmp1[1], ctx);
> > +		s8 d_hi = bpf_get_reg32(reg[0], tmp1[0], ctx);
> > +
> > +		emit_16(ctx, 0x2f00 | d_lo);			/* move.l d_lo, -(%sp) */
> > +		emit_16(ctx, 0x2f00 | d_hi);			/* move.l d_hi, -(%sp) */
> > +	}
> > +
> > +	emit_16(ctx, 0x207c);					/* movea.l #func_addr, %a0 */
> > +	emit_32(ctx, (u32)func_addr);
> > +
> > +	emit_16(ctx, 0x4e90);					/* jsr (%a0) */
> > +
> > +	emit_16(ctx, 0x4fef);					/* lea 40(%sp), %sp */
> > +	emit_16(ctx, 40);
> > +
> > +	emit_16(ctx, 0xc340);					/* exg %d0, %d1 */
> > +
> > +	return 0;
> > +}
> 
> Does the exg %d0, %d1 swap the halves of the return value incorrectly
> for BPF-to-BPF subprogram calls (BPF_PSEUDO_CALL)?
> 
> The emit_call() function unconditionally swaps %d0 and %d1 after all
> calls, which appears correct for C ABI helper functions (where high 32
> bits are in %d0, low in %d1). However, BPF subprograms place their 64-bit
> return value in BPF_REG_0, which is mapped to %d1 and %d0.
> 
> If a BPF subprogram returns a value via BPF_REG_0:
>     BPF subprogram: BPF_REG_0 -> %d1:%d0 (high:low)
>     After exg:      %d0:%d1 (swapped - incorrect ordering)
> 
> Additionally, the prologue assumes C ABI and reads a context pointer
> from 8(%fp):
> 
> arch/m68k/net/bpf_jit_comp.c:build_prologue() {
>     emit_16(ctx, 0x202e);       /* move.l 8(%fp), %d0 */
>     emit_16(ctx, 8);
> }
> 
> But BPF-to-BPF calls pass arguments via the stack (pushed by emit_call),
> not via the C calling convention. Wouldn't this cause the prologue to
> read an incorrect context pointer for BPF subprogram entry points?
> 

I think currently it works because pseudo calls will fail at
bpf_jit_get_func_addr() and fall back to the interpreter anyway.

I might try to fix this issue, test it, and submit a v4.

Regards,
Kuan-Wei

> Reference: https://lore.kernel.org/bpf/6736ffb5.050a0220.11da83.0029.GAE@google.com/
> 
> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/25698934894

