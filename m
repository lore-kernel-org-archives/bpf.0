Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A25601C84A2
	for <bpf@vger.kernel.org>; Mon, 18 May 2026 17:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779125554; cv=none; b=Ql+dZGMJhkMC/rSOOYXZY5yA3NHbLP9Xeu4AIkbAfmQvQR9s/wZ/TDghfgB6rfYceyaXxcgg8ztr52dXyn5MuHmSPAOdpkQZ3hulxvWUqoQL9y8IAVCXnrUgZK5gNj2FXMLVc90FCq2sk5P2p14blyit1/fI8rq4GUJRHjPEmbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779125554; c=relaxed/simple;
	bh=AH+DBcfb8hb1EXWNIPBBXvrpcWc8hMPu2qrEVpv3n+A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VeLwbk9HvTx+A4XTEqsCRD6YOz24LWN0gqiBIW0B1hFYA+Cr2TxA3nYVfAxXDlz56vz9zkl7MJLiAFdbrSypCr7jNZZZb+zCJ4bH7GVGKb74xOXKNxKKcXWn55NdhiNeClds/WCwHDZuNA0r/jLZUJpGklUFJ30rGoE5faWLK3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=noNNTp+M; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="noNNTp+M"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2bab2548e8bso10944335ad.0
        for <bpf@vger.kernel.org>; Mon, 18 May 2026 10:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779125552; x=1779730352; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2uzkrbz+xMoiruhnNnylQApyqxZ7RLlqdiRaKQfhQVA=;
        b=noNNTp+Mp4zszvaxnK49BxdeEj+qjciSrzuCUcijqqYz6IU+Z3Nm5XLHMM0bHXsG8m
         ZJGnWXfSE+48hRG0EffhNm20s8dKyDu5/K26vBFfZ/7Ix4zJUt/w6kKzQo5pCbidfTHq
         qw1mB2VA67HLVd1DcQGHYf5IgaBE/IlJWomQGc85PG01UpmxQxU6yhs8UZUZwpkMATmP
         LbkWO6Gx2aGPMKZh1Jr/sDzxOixvu0ZLteOjkgEIqnYycXtYevrY37GZ1ptGYZyL2HL5
         yAOXgSoggdZjfkt3n8CSfPg/D6IL7jvyPyuyYW1MGnR4bpVVi2R+er1EbH3i7cPMzpcv
         NJ8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779125552; x=1779730352;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2uzkrbz+xMoiruhnNnylQApyqxZ7RLlqdiRaKQfhQVA=;
        b=QGwCJO3AEJE3a/5/KoKULIb8slCvJ+1hIgMyqdSZhWzBDq0KQMynVxoxIwFg+xMjr5
         1a3Y2npsQT5mmc8C2sPxGYozPZiUrTfbi5Iqveb6ezB+Mw4h1TnfuFJF7dRr64F7LdsU
         6AJDCDJTj9467P2HvLmRrflibn2Na6oELiS9LZ8wOapIRabEufaTNpMUARMpuvqjNSv3
         QyfrMCVsgC73eR2uUqwP5EKfPoHons4v+RRoN3iUHyEghIjCKRqwplnt7MGaiAiMbLej
         2DJr0hQWOgS9QwLUcmVG21lhD0HeKOQJqL15ZhHgfRvMvUZOez3k2+n5LMS4u6r4c2rz
         Q7qQ==
X-Gm-Message-State: AOJu0YzgqJ5PT4EsqRJvqxsGUgUPGS/ZbHrMwjIOp2Qlu0piopPzskro
	JVu/esjPxIASKrCWBT9Q8Nnmd+1qleUzDtwjzupXZg9JGVQPoW6jdzIZQ5unQA==
X-Gm-Gg: Acq92OFQAqQnqCuyKQYPzfh4tc9mKu2MQeuGqNopslRQieIBc3G+Lji4fUD9wqYRJOr
	8XfZxpNAf35+cJ0MXRwdnHB1GH8u8Qru3zu7w5pg2on+/4NsoFOsH13IoWjw2gHljnPcyXHg94d
	mMYl6Xgf8ByjVjihuPlQDWRTH3DbWwbHdizysYg3pbUo8jSCtMJwToaWDxrnKNu5iQe0V2AxVOn
	iHq0M0LbIJNWk9dLsJIWNJ4JiK8rUQtPA+/BqYoXDZETF+tu4gs8YU/gfLFf3EIqkoQfIL7kZq6
	jzRmZ9+VHfbKSfQQhsQJYJRrFVby7ilI44/PV71/2CM0+jrErP2KbTCixUL3Vg80+sjWpgrWhU6
	FZ8PBZ/wVEPjyCpjcYvRUZKxkWdAzCdTzDhp8pSIRazIakTigfTbd0FxdWhGs9WfC2EIOr6hK4X
	th0ouW8vDIzCEzc+Klw1GUvbHyFKTNGCWomA==
X-Received: by 2002:a17:902:da90:b0:2bd:612b:912d with SMTP id d9443c01a7336-2bd7e8ad548mr166936445ad.14.1779125551825;
        Mon, 18 May 2026 10:32:31 -0700 (PDT)
Received: from google.com ([118.150.148.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5cfe6b8fsm163562595ad.46.2026.05.18.10.32.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 10:32:31 -0700 (PDT)
Date: Tue, 19 May 2026 01:32:29 +0800
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next v3] m68k, bpf: Add initial BPF JIT compiler
 support
Message-ID: <agtNLbj1V0DuEJvL@google.com>
References: <20260511212756.3163955-1-visitorckw@gmail.com>
 <20260513010339.81EDEC2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260513010339.81EDEC2BCB0@smtp.kernel.org>

On Wed, May 13, 2026 at 01:03:39AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
> - [High] BPF-to-BPF calls (BPF_PSEUDO_CALL) are broken, corrupting arguments, return values, and tail call tracking.
> - [High] Missing protection against signed division overflow (`S32_MIN / -1` and `S64_MIN / -1`), leading to undefined behavior and potential kernel panics.
> - [Medium] Using `kcalloc` for potentially large array allocations leads to JIT failures under memory fragmentation.
> --
> 
> commit 1a2c23f18e30a4b931f962e5e35eed83ff42f6a2
> Author: Kuan-Wei Chiu <visitorckw@gmail.com>
> 
> m68k, bpf: Add initial BPF JIT compiler support
> 
> Add a BPF JIT compiler for the m68k architecture.
> 
> > diff --git a/arch/m68k/net/bpf_jit_comp.c b/arch/m68k/net/bpf_jit_comp.c
> > new file mode 100644
> > index 0000000000000..1531b321410ae
> > --- /dev/null
> > +++ b/arch/m68k/net/bpf_jit_comp.c
> 
> [ ... ]
> 
> > +static noinline s32 jit_sdiv32(s32 a, s32 b) { return b ? a / b : 0; }
> > +static noinline s32 jit_smod32(s32 a, s32 b) { return b ? a % b : a; }
> > +
> > +static noinline u64 jit_mul64(u64 a, u64 b) { return a * b; }
> > +static noinline u64 jit_div64(u64 a, u64 b) { return b ? div64_u64(a, b) : 0; }
> > +static noinline s64 jit_sdiv64(s64 a, s64 b) { return b ? div64_s64(a, b) : 0; }
> 
> What happens if signed division or modulo is performed by -1 with the minimum
> representable value (e.g., S32_MIN / -1)?
> 
> In C, evaluating INT_MIN / -1 results in signed integer overflow (undefined
> behavior), which can trigger a CPU division exception on m68k and crash the
> kernel.
> 
> Should explicit bounds checking be added to handle these edge cases and return
> the dividend as required by the eBPF specification?
> 

Ack.
will add the missing bounds checks in neext version.

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
> 
> Does this code break BPF-to-BPF calls (BPF_PSEUDO_CALL)?
> 
> It appears to treat the subprogram exactly like a standard C helper by pushing
> BPF registers R1-R5 to the stack and then executing exg %d0, %d1 to swap the
> 64-bit return value.
> 
> However, the subprogram's JIT-compiled code unconditionally uses the standard
> build_prologue(), which lacks a check for ctx->prog->is_func.
> 
> Consequently, doesn't the subprogram act like a root BPF program, initializing
> BPF_REG_1 from 8(%fp), zeroing its upper 32 bits, and completely ignoring the
> stacked R2-R5 arguments?
> 
> Additionally, it seems the global tail call counter (BPF_TC_LO) is improperly
> reset to 33 on every subprogram entry, and the return value of BPF subprograms
> (which already populate BPF_REG_0 properly) gets corrupted by the swap.
> 

Will try to fix this.

> [ ... ]
> 
> > +struct bpf_prog *bpf_int_jit_compile(struct bpf_verifier_env *env, struct bpf_prog *prog)
> > +{
> > +	struct bpf_binary_header *header;
> > +	struct jit_ctx ctx;
> > +	unsigned int image_size;
> > +	u8 *image_ptr;
> > +
> > +	if (!prog->jit_requested)
> > +		return prog;
> > +
> > +	memset(&ctx, 0, sizeof(ctx));
> > +	ctx.prog = prog;
> > +
> > +	ctx.offsets = kcalloc(prog->len + 1, sizeof(int), GFP_KERNEL);
> 
> Is it safe to use kcalloc() here for potentially large array allocations?
> 
> Since the BPF verifier allows up to 1,000,000 instructions per program, this
> could request up to 4MB of contiguous physical memory.
> 
> On systems with memory fragmentation, this large physically contiguous
> allocation is highly likely to fail, unnecessarily aborting JIT compilation.
> 
> Would it be better to use kvcalloc() instead, consistent with other BPF JITs?
> 

Ack.
Will change to kvcalloc().

Regards,
Kuan-Wei

> > +	if (!ctx.offsets)
> > +		return prog;
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260511212756.3163955-1-visitorckw@gmail.com?part=1
