Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D65AB3F166E;
	Wed, 29 Apr 2026 13:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777469950; cv=none; b=YBQDB1O40ddZNPECiAwl21JanZd53oa58luiXPigcfZ5ZQoXdvSm2trDnVnS814O1cOxxvlqFFoJD5a10aJihpJKH8lOqlz7OVdSex9uTekPfEgoUBoKmTnCE8CMx12vsqvzg/FtpCgMZHzKf8pQw0qJ6ZPH0m0jqZbIolFCcjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777469950; c=relaxed/simple;
	bh=osP4W3/oJUMKZpmJm93icRtApK2brzZfwQDW6ma8R6c=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=NjBiU3yeq3os2ZxBOehGlDE6XCrHLsrk8mVDKyDle8kGBByrMbq9WAlMSofB8FVcUyGwrdE3I+awbFS/yB5QRsGOd2uhT7nIwK7Cx0yp1uprP0lK8Socoi2+TMEYZZQQomNDLFhZjVmMheD+OrMkkB8eCdZxTKmUqSzTg4J2ro4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H0V1AVmj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H0V1AVmj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 671B7C19425;
	Wed, 29 Apr 2026 13:39:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777469950;
	bh=osP4W3/oJUMKZpmJm93icRtApK2brzZfwQDW6ma8R6c=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=H0V1AVmjU8vN0wCJa9cvT651MLkif544jnbmf2erblDU+qmb87Qq5z8u6lfn2RLia
	 QRpe4n6UcHWrtxj32ZAFxVdOijGNYwhcqu5gXGObGSPykwxQCDV0T3KlZqf1C2ZeY4
	 MlNukFm8/pY3sj8wA7APgIdNeNKMUwNIXTt6/lph1Kh5Ou1KfJrwSlnviTR2qE51yk
	 IkJP4IA57m3x6QK6oEQY+3MVPXhXwcxHqMKlu7/AKI4MUgp+6sWWsLixM+/B2B6z2V
	 HfV9v7/n4H5RnGnFiphs1tzGZjWIHLy6twm3GGQoXSM9HxuMqJ6LFp5dpdGA+roew/
	 pT6TTAZ/oeUkw==
Content-Type: multipart/mixed; boundary="===============4284955305587179238=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <5c97b756f6430dd7c58b8bc4eaff2f906765eb7218c9cb1b48e47187d0028816@mail.kernel.org>
In-Reply-To: <20260429124046.3480827-1-visitorckw@gmail.com>
References: <20260429124046.3480827-1-visitorckw@gmail.com>
Subject: Re: [PATCH bpf-next] m68k, bpf: Add initial BPF JIT compiler support
From: bot+bpf-ci@kernel.org
To: visitorckw@gmail.com,geert@linux-m68k.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com
Cc: martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,jserv@ccns.ncku.edu.tw,eleanor15x@gmail.com,linux-kernel@vger.kernel.org,linux-m68k@lists.linux-m68k.org,bpf@vger.kernel.org,visitorckw@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed, 29 Apr 2026 13:39:10 +0000 (UTC)

--===============4284955305587179238==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/MAINTAINERS b/MAINTAINERS
> index 13f49378b157..9d6e73c1caaf 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4699,6 +4699,12 @@ L:	bpf@vger.kernel.org
>  S:	Maintained
>  F:	arch/loongarch/net/
>
> +BPF JIT FOR M68K
           ^^^

This isn't a bug, but the surrounding BPF JIT entries all use lowercase
'for': 'BPF JIT for ARM', 'BPF JIT for ARM64', 'BPF JIT for LOONGARCH',
'BPF JIT for MIPS', etc. For consistency, this should be 'BPF JIT for
M68K'.

> +M:	Kuan-Wei Chiu <visitorckw@gmail.com>
> +L:	bpf@vger.kernel.org
> +S:	Maintained
> +F:	arch/m68k/net/
> +
>  BPF JIT for MIPS (32-BIT AND 64-BIT)
>  M:	Johan Almbladh <johan.almbladh@anyfinetworks.com>
>  M:	Paul Burton <paulburton@kernel.org>

[ ... ]

> diff --git a/arch/m68k/Kconfig b/arch/m68k/Kconfig
> index 11835eb59d94..67ac01c9ab42 100644
> --- a/arch/m68k/Kconfig
> +++ b/arch/m68k/Kconfig
> @@ -8,6 +8,7 @@ config M68K
>  	select ARCH_HAS_CPU_FINALIZE_INIT if MMU
>  	select ARCH_HAS_CURRENT_STACK_POINTER
>  	select ARCH_HAS_DMA_PREP_COHERENT if M68K_NONCOHERENT_DMA && !COLDFIRE
> +	select HAVE_EBPF_JIT if (!COLDFIRE && !M68000 && !M68010)
                                                          ^^^^^^^

Does this reference a valid Kconfig symbol? The symbol M68010 doesn't
appear to be defined anywhere in the kernel tree. A search across
arch/m68k/ and the wider tree shows M68010 is referenced only in this
new line. The m68k CPU Kconfig (arch/m68k/Kconfig.cpu) defines
COLDFIRE, M68000, M68020, M68030, M68040, M68060, SUN3, M68KCLASSIC,
etc., but no M68010.

Because undefined Kconfig symbols evaluate to 'n', the condition
!M68010 is always true. This means the gating for 68010 hardware that
the commit message describes is never actually enforced (dead
sub-expression).

The commit message states the JIT targets 'm68020+ processors...
excludes 68000/68010 and coldfire', so the intent is clearly to exclude
68010 - but that exclusion is not functional as written.

>  	select ARCH_HAS_SYNC_DMA_FOR_DEVICE if M68K_NONCOHERENT_DMA
>  	select ARCH_HAVE_NMI_SAFE_CMPXCHG if RMW_INSNS
>  	select ARCH_MIGHT_HAVE_PC_PARPORT if ISA

[ ... ]

> diff --git a/arch/m68k/net/bpf_jit_comp.c b/arch/m68k/net/bpf_jit_comp.c
> new file mode 100644
> index 000000000000..cfeffd03c434
> --- /dev/null
> +++ b/arch/m68k/net/bpf_jit_comp.c

[ ... ]

> @@ -0,0 +1,1543 @@

[ ... ]

> +static void emit_alu64_x(const struct bpf_insn *insn, struct jit_ctx *ctx)
> +{

[ ... ]

> +	case BPF_XOR:
> +		emit_16(ctx, 0xb180 | (s_lo << 9) | d_lo);		/* eor.l d_lo, s_lo */
> +		emit_16(ctx, 0xb180 | (s_hi << 9) | d_hi);		/* eor.l d_hi, s_hi */
                                                                       ^^^^^^^^^^^

The comments describe the operand order in reverse. The m68k 'eor.l Dn,
<ea>' opcode 0xB180 has Dn (bits 11-9) encode the source register and
EA (bits 2-0) encode the destination (EA = EA XOR Dn). The emitted
instruction is:

  0xb180 | (s_lo << 9) | d_lo    /* d_lo := d_lo ^ s_lo */

which is functionally correct. However, the comment reads 'eor.l d_lo,
s_lo', which in m68k assembler convention (source first) describes the
wrong operation: s_lo := d_lo ^ s_lo.

This is inconsistent with the correctly-worded sibling comment in
emit_alu32_x:

  emit_16(ctx, 0xb180 | (s_reg << 9) | d_reg);  /* eor.l src, dst */

The emitted machine code is correct; only the comments are reversed.
This also affects the BPF_XOR case in emit_alu64_k (four lines total).

> +		break;
> +	}
> +
> +	bpf_put_reg32(dst[1], d_lo, ctx);
> +	bpf_put_reg32(dst[0], d_hi, ctx);
> +}

[ ... ]

> +static void build_prologue(struct jit_ctx *ctx)
> +{
> +	int bpf_stack = 512;
> +	int total_stack = SCRATCH_SIZE + bpf_stack;
> +
> +	emit_16(ctx, 0x7021);					/* moveq #33, %d0 */
> +
> +	emit_16(ctx, 0x4e56);					/* link %a6, #-total_stack */
> +	emit_16(ctx, -total_stack);
> +
> +	emit_16(ctx, 0x48e7);					/* movem.l d2-d5, -(%sp) */
                                                                  ^^^^^^

Does this comment accurately describe the register mask 0x3f3c? The
mask 0x3f3c in predecrement mode (bits 2-5 and 8-13 set) encodes the
register set {D2, D3, D4, D5, D6, D7, A2, A3, A4, A5} - that's 10
registers, not just d2-d5.

Predecrement register mask encoding uses bit 0=A7, bit 1=A6, ..., bit
7=A0, bit 8=D7, bit 9=D6, ..., bit 15=D0. A true 'movem.l d2-d5,
-(%sp)' would use mask 0x3c00.

The save matches the corresponding epilogue restore (mask 0x3cfc, which
in postincrement mode covers the same 10 registers), so the code is
functionally correct and the stack is balanced. However, D6, D7, A2-A5
are never modified by the JIT and do not need to be saved, causing 24
bytes of wasted stack space and 6 unnecessary register saves per JIT'd
function call.

> +	emit_16(ctx, 0x3f3c);
> +
> +	emit_16(ctx, 0x2d40);					/* move.l %d0, off(%fp) */
> +	emit_16(ctx, (u16)STACK_OFFSET(BPF_TC_LO));

[ ... ]

> +static void build_epilogue(struct jit_ctx *ctx)
> +{
> +	emit_16(ctx, 0x4cdf);					/* movem.l (%sp)+, d2-d5 */
                                                                  ^^^^^^

Similar to the prologue comment issue, the mask 0x3cfc in postincrement
mode (bits 2-7 and 10-13 set) encodes restoring {D2, D3, D4, D5, D6,
D7, A2, A3, A4, A5}. A true 'movem.l (%sp)+, d2-d5' would use mask
0x003c.

Postincrement mask encoding uses bit 0=D0, bit 1=D1, ..., bit 7=D7, bit
8=A0, ..., bit 15=A7. This matches the prologue's save, so the stack is
balanced and values are correctly restored, but the comment is
inaccurate.

> +	emit_16(ctx, 0x3cfc);
> +
> +	emit_16(ctx, 0x4e5e);					/* unlk %fp */
> +	emit_16(ctx, 0x4e75);					/* rts */
> +}


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/25110417551
--===============4284955305587179238==--
