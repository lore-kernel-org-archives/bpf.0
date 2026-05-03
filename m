Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66F0636D9F9
	for <bpf@vger.kernel.org>; Sun,  3 May 2026 17:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777830505; cv=none; b=B01cxqM2GudEIevLCDEXHXUUzEYqEEKZle5lh2dkhkU9Y2ZlmZKvWap5K++C/dXrlr4KcMPhS2yRAwKmxy9yfs/W8ehF6DDL4B4v4YgRU84zs2/R97NSAHEwDcdaMcjp5i7e0tRpS90iQVKCiPgmmD4veGj75LRE0aFFADAbHI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777830505; c=relaxed/simple;
	bh=72HR0N1IcRA0jgqnpozUUir+piwB3syOsvI7gTeuoLg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O51Gd6kLyN0/0QjAmvU3xw4Mix3+rk3GiezkQYSmFohpT39FuFzEcbss404EqzXdA7kKigMYRfW/p9ZREz5uVdXroQKJa0e8rgTCb5lx/zkJAQrcWlZtucDVgYarHhCnvv9CTxf0oHRQAhuuoYFecNPKIrOqOSU7qqjnEdlqPOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RxW1ESSX; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RxW1ESSX"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-c80148ae949so251922a12.2
        for <bpf@vger.kernel.org>; Sun, 03 May 2026 10:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777830504; x=1778435304; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=anmvjbXOA2xSMfBhfCZgjRrWUNuIqYn5mcL9tcDiC44=;
        b=RxW1ESSXeBsiDdarHLFmj4Ux8CNuwMz87KGXRh70B7S1wg/cXtYVQZq4jWCS2ZXivz
         oTVL2YrYnTP9dOq7bHI1a8zbL+WTkvH7eS3T8soAJkaWGusnSND9L6O33/RIB+6cnq0J
         qqFB38QtsJPWxLhmPNsqJlxjrA6WpY+BysBDlpUD9LAnL5+aocFWAV/ms8maheSuW+l7
         81LtsCFftRoqGfs8RoQ+sOwVZ8P5rM7u0UruzooPWLa9gyujg7tchVOvkHJUPDUbZzDC
         viHu7qlRhpNp8ZbFx4db1QxQPPzxKKEst8az27bbX9vApPxlPtRAYdkN60wZQKzzboye
         gZ8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777830504; x=1778435304;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=anmvjbXOA2xSMfBhfCZgjRrWUNuIqYn5mcL9tcDiC44=;
        b=YHcEV3ZMvHHx4skVQhcFsTCGE3/ZbfOwHW5Gr/xGfG/oeuFAzOodn6leBK5GW8czsT
         +hCjb6NMU/Ljyp1MfysvwGNUNvasAwZign0pmxI0SSkW2HJBRGHmn294PHyW/wjhYfrK
         tpMsyw2ZabadOh+udRfk8VsYrUvZwypAt/NMU+E4unFAJxmuKPP+jrvENk/TjAfaAGFs
         Psb2roSETp2Y885IsT+FCQUmbS7ZyCYiODlyHeOdtbIBmbJhUBjJadfLaDg/uCBsfajC
         1RPBzXouhOiadjUPluElueijk7n/KawQlDiWnxYUVZkRuzfEUou74AtG6e+8riLEi/zK
         7V6g==
X-Forwarded-Encrypted: i=1; AFNElJ9iUfZFwTXbkjVcf4hFulT9XXe42foz0Q2JdPpQS/7q47wF93NGYfeRT7m4l6ynpvLLoDE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4n0csvL9Lnkr/qYJlGtHCS0x3fztM0N7uHCTmZAIhJoN0S3md
	vUmL3Zz8++Ocs9FoadmhBdd+U07PCEWf7vz6d2Rtf3ZXEKQwmAM3ubkA
X-Gm-Gg: AeBDiesIMVpfo/gf747ZWYJQl4PrQeMTbAPAQN0j9H/155TZtOrDSNqFDNvjsBhscOF
	WvTvQL3CBhp8VnC/ibFifDMOP2GNymPcLtUuIlTbJ0dFDcPhn5C7sEtmaStXB9vFkz6FcpxjnJ2
	g/7W/Jr3+UcjI0C4RhhWP1PB31r3FiDXwL2MaBo4h/B/07QIFqdeOeqgbFFQOP+EKyIgr2xQdll
	JIJCVzAPGQnltLw5KbD3YKjTmA7etFoOdT34cqFnzran0Mup2bndQt09RaY7zaa2Q8xwyk8M55J
	Yiq5Q/QaL5uKHyQrh2mIUmdxCku9/ulY9TGYTwazMGWIJeVdCsspg5qLfrIK69WD6foyxxApNme
	asuFVTRmWB5rqFsuWvAnisEjeaYFuVNGeTSMpZhu2dsjI5IF5PT9nrzWu+Nqj7da+iNcOhKavfG
	lgXGwnRTUkIJK7oCr+c5A86UhIIHgaK5P4ZnyHDf/ykKmesrYCFrUGYjlfPLPYpR+LqX0ccDb0F
	DtZ2wtT
X-Received: by 2002:a05:6a00:14ca:b0:82f:2b0:2809 with SMTP id d2e1a72fcca58-8352d1c5a0fmr6729109b3a.1.1777830503583;
        Sun, 03 May 2026 10:48:23 -0700 (PDT)
Received: from google.com (61-230-38-200.dynamic-ip.hinet.net. [61.230.38.200])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8351582edf9sm9012901b3a.12.2026.05.03.10.48.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 May 2026 10:48:23 -0700 (PDT)
Date: Mon, 4 May 2026 01:48:18 +0800
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: bot+bpf-ci@kernel.org
Cc: geert@linux-m68k.org, ast@kernel.org, daniel@iogearbox.net,
	andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com,
	martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
	jolsa@kernel.org, jserv@ccns.ncku.edu.tw, eleanor15x@gmail.com,
	linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
	bpf@vger.kernel.org, martin.lau@kernel.org, clm@meta.com,
	ihor.solodrai@linux.dev
Subject: Re: [PATCH bpf-next] m68k, bpf: Add initial BPF JIT compiler support
Message-ID: <afeKYtMhrsfsAgEE@google.com>
References: <20260429124046.3480827-1-visitorckw@gmail.com>
 <5c97b756f6430dd7c58b8bc4eaff2f906765eb7218c9cb1b48e47187d0028816@mail.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5c97b756f6430dd7c58b8bc4eaff2f906765eb7218c9cb1b48e47187d0028816@mail.kernel.org>

On Wed, Apr 29, 2026 at 01:39:10PM +0000, bot+bpf-ci@kernel.org wrote:
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 13f49378b157..9d6e73c1caaf 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -4699,6 +4699,12 @@ L:	bpf@vger.kernel.org
> >  S:	Maintained
> >  F:	arch/loongarch/net/
> >
> > +BPF JIT FOR M68K
>            ^^^
> 
> This isn't a bug, but the surrounding BPF JIT entries all use lowercase
> 'for': 'BPF JIT for ARM', 'BPF JIT for ARM64', 'BPF JIT for LOONGARCH',
> 'BPF JIT for MIPS', etc. For consistency, this should be 'BPF JIT for
> M68K'.

I doubt anyone really cares about the casing here, but I will fix it in
v2 anyway.

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
> > diff --git a/arch/m68k/Kconfig b/arch/m68k/Kconfig
> > index 11835eb59d94..67ac01c9ab42 100644
> > --- a/arch/m68k/Kconfig
> > +++ b/arch/m68k/Kconfig
> > @@ -8,6 +8,7 @@ config M68K
> >  	select ARCH_HAS_CPU_FINALIZE_INIT if MMU
> >  	select ARCH_HAS_CURRENT_STACK_POINTER
> >  	select ARCH_HAS_DMA_PREP_COHERENT if M68K_NONCOHERENT_DMA && !COLDFIRE
> > +	select HAVE_EBPF_JIT if (!COLDFIRE && !M68000 && !M68010)
>                                                           ^^^^^^^
> 
> Does this reference a valid Kconfig symbol? The symbol M68010 doesn't
> appear to be defined anywhere in the kernel tree. A search across
> arch/m68k/ and the wider tree shows M68010 is referenced only in this
> new line. The m68k CPU Kconfig (arch/m68k/Kconfig.cpu) defines
> COLDFIRE, M68000, M68020, M68030, M68040, M68060, SUN3, M68KCLASSIC,
> etc., but no M68010.
> 
> Because undefined Kconfig symbols evaluate to 'n', the condition
> !M68010 is always true. This means the gating for 68010 hardware that
> the commit message describes is never actually enforced (dead
> sub-expression).
> 
> The commit message states the JIT targets 'm68020+ processors...
> excludes 68000/68010 and coldfire', so the intent is clearly to exclude
> 68010 - but that exclusion is not functional as written.

Ah, I actually had a local fixup for this but forgot to squash it
before sending.

Out of curiosity, is there any checker tool that warns about
referencing non-existent symbols?

> 
> >  	select ARCH_HAS_SYNC_DMA_FOR_DEVICE if M68K_NONCOHERENT_DMA
> >  	select ARCH_HAVE_NMI_SAFE_CMPXCHG if RMW_INSNS
> >  	select ARCH_MIGHT_HAVE_PC_PARPORT if ISA
> 
> [ ... ]
> 
> > diff --git a/arch/m68k/net/bpf_jit_comp.c b/arch/m68k/net/bpf_jit_comp.c
> > new file mode 100644
> > index 000000000000..cfeffd03c434
> > --- /dev/null
> > +++ b/arch/m68k/net/bpf_jit_comp.c
> 
> [ ... ]
> 
> > @@ -0,0 +1,1543 @@
> 
> [ ... ]
> 
> > +static void emit_alu64_x(const struct bpf_insn *insn, struct jit_ctx *ctx)
> > +{
> 
> [ ... ]
> 
> > +	case BPF_XOR:
> > +		emit_16(ctx, 0xb180 | (s_lo << 9) | d_lo);		/* eor.l d_lo, s_lo */
> > +		emit_16(ctx, 0xb180 | (s_hi << 9) | d_hi);		/* eor.l d_hi, s_hi */
>                                                                        ^^^^^^^^^^^
> 
> The comments describe the operand order in reverse. The m68k 'eor.l Dn,
> <ea>' opcode 0xB180 has Dn (bits 11-9) encode the source register and
> EA (bits 2-0) encode the destination (EA = EA XOR Dn). The emitted
> instruction is:
> 
>   0xb180 | (s_lo << 9) | d_lo    /* d_lo := d_lo ^ s_lo */
> 
> which is functionally correct. However, the comment reads 'eor.l d_lo,
> s_lo', which in m68k assembler convention (source first) describes the
> wrong operation: s_lo := d_lo ^ s_lo.
> 
> This is inconsistent with the correctly-worded sibling comment in
> emit_alu32_x:
> 
>   emit_16(ctx, 0xb180 | (s_reg << 9) | d_reg);  /* eor.l src, dst */
> 
> The emitted machine code is correct; only the comments are reversed.
> This also affects the BPF_XOR case in emit_alu64_k (four lines total).

Ack. Will fix the comment in v2.

> 
> > +		break;
> > +	}
> > +
> > +	bpf_put_reg32(dst[1], d_lo, ctx);
> > +	bpf_put_reg32(dst[0], d_hi, ctx);
> > +}
> 
> [ ... ]
> 
> > +static void build_prologue(struct jit_ctx *ctx)
> > +{
> > +	int bpf_stack = 512;
> > +	int total_stack = SCRATCH_SIZE + bpf_stack;
> > +
> > +	emit_16(ctx, 0x7021);					/* moveq #33, %d0 */
> > +
> > +	emit_16(ctx, 0x4e56);					/* link %a6, #-total_stack */
> > +	emit_16(ctx, -total_stack);
> > +
> > +	emit_16(ctx, 0x48e7);					/* movem.l d2-d5, -(%sp) */
>                                                                   ^^^^^^
> 
> Does this comment accurately describe the register mask 0x3f3c? The
> mask 0x3f3c in predecrement mode (bits 2-5 and 8-13 set) encodes the
> register set {D2, D3, D4, D5, D6, D7, A2, A3, A4, A5} - that's 10
> registers, not just d2-d5.
> 
> Predecrement register mask encoding uses bit 0=A7, bit 1=A6, ..., bit
> 7=A0, bit 8=D7, bit 9=D6, ..., bit 15=D0. A true 'movem.l d2-d5,
> -(%sp)' would use mask 0x3c00.
> 
> The save matches the corresponding epilogue restore (mask 0x3cfc, which
> in postincrement mode covers the same 10 registers), so the code is
> functionally correct and the stack is balanced. However, D6, D7, A2-A5
> are never modified by the JIT and do not need to be saved, causing 24
> bytes of wasted stack space and 6 unnecessary register saves per JIT'd
> function call.

Ack. Will change the mask to 0x3c00.

Regards,
Kuan-Wei

> 
> > +	emit_16(ctx, 0x3f3c);
> > +
> > +	emit_16(ctx, 0x2d40);					/* move.l %d0, off(%fp) */
> > +	emit_16(ctx, (u16)STACK_OFFSET(BPF_TC_LO));
> 
> [ ... ]
> 
> > +static void build_epilogue(struct jit_ctx *ctx)
> > +{
> > +	emit_16(ctx, 0x4cdf);					/* movem.l (%sp)+, d2-d5 */
>                                                                   ^^^^^^
> 
> Similar to the prologue comment issue, the mask 0x3cfc in postincrement
> mode (bits 2-7 and 10-13 set) encodes restoring {D2, D3, D4, D5, D6,
> D7, A2, A3, A4, A5}. A true 'movem.l (%sp)+, d2-d5' would use mask
> 0x003c.
> 
> Postincrement mask encoding uses bit 0=D0, bit 1=D1, ..., bit 7=D7, bit
> 8=A0, ..., bit 15=A7. This matches the prologue's save, so the stack is
> balanced and values are correctly restored, but the comment is
> inaccurate.
> 
> > +	emit_16(ctx, 0x3cfc);
> > +
> > +	emit_16(ctx, 0x4e5e);					/* unlk %fp */
> > +	emit_16(ctx, 0x4e75);					/* rts */
> > +}
> 
> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/25110417551

