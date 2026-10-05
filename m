Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A6BF4DE71C;
	Mon,  5 Oct 2026 19:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791229701; cv=none; b=o6ND1YXuNcjidM8KyFKZo+tPRPwHu6FxrR29NifJwPCLiszd00FpqgFLON09ObzqO0uDB7UuosZEEXnCTToG5KAb45RW5lPOcEJExReEH7rieqyDVvcPRqVTJ72FrverHI+2MVxLxmzCDj83J/Ag5Jy0MMVqSr3zJhU62mBnr9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791229701; c=relaxed/simple;
	bh=9YrPjjNECcupDBUjRHMgYCPB1dXC4/QqY4mgSRIUWnE=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=X44SQwGc11s3PN5aRKNunHKC1UuZnS3kNM/y8DAfmz/lc6s3vmA3HUwvgt5T5cm2ku0P34DDaUSpFKYSMl2vxGTL+1YRrQGtbL7ur2lpLkIwhspKQiTWNLn6obYtOO/OwM7eJc2A4+irpl+6v41bxzo1vuC30iiaqcOKOHe5pHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=embZaJ4K; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="embZaJ4K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82CD21F000FF;
	Mon,  5 Oct 2026 19:48:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791229698;
	bh=SPdV1xzz1+BzXdXk7QYaGJQvujiFD/hlO8P3VRG/jO8=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=embZaJ4KuioOsBaeWBQ+pHBOVCfryMCOCjparzyUP0L4cxPbFvEAJhi9k6a+CZ1hL
	 NS+38pJg/HU6pym51PwCMgotoFT9Yv/y4hUsBSGu4iyiQI9c3WI7UBAFnjEeFQ/God
	 d28GEScEXhi3a2rM/rHqE2JKQlT7V2JcxPkxTeyQvAds6tuuQHoSyBzz3k5DTLe9ry
	 Lp11VVVldih63RZ1GH9tMzcaXtbKzK4pX4twS0aGKQkfKPHE2nJtZQ1NCSB4FCfeQD
	 PfD82SDoRL9UTP5d6gwgCieiyy0fAcWN+mRY15X2hYDw8CX1jsDpFUr7J/XVzvgyPA
	 QAmP1SeECcRUw==
Content-Type: multipart/mixed; boundary="===============8230421052853861394=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <506b804c97aaa3a66660bb0eebd85c6041e241532c1227f1012166785d240fae@mail.kernel.org>
In-Reply-To: <20261005185251.2422114-1-visitorckw@gmail.com>
References: <20261005185251.2422114-1-visitorckw@gmail.com>
Subject: Re: [PATCH v7] m68k, bpf: Add initial BPF JIT compiler support
From: bot+bpf-ci@kernel.org
To: visitorckw@gmail.com,corbet@lwn.net,skhan@linuxfoundation.org,geert@linux-m68k.org,ast@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,memxor@gmail.com,andrii@kernel.org,gerg@linux-m68k.org
Cc: rdunlap@infradead.org,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev,jserv@ccns.ncku.edu.tw,marscheng@google.com,eleanor15x@gmail.com,linux-doc@vger.kernel.org,linux-kernel@vger.kernel.org,linux-m68k@lists.linux-m68k.org,bpf@vger.kernel.org,visitorckw@gmail.com,daniel@thingy.jp,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Mon,  5 Oct 2026 19:48:15 +0000 (UTC)

--===============8230421052853861394==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> m68k, bpf: Add initial BPF JIT compiler support

TL;DR: Nit only, not a bug: the ColdFire byte-swap instruction sequences are
open-coded repeatedly in emit_to_le16/32/64() in the m68k JIT; suggests small
shared helpers, as arm's bpf_jit_32.c does.

> diff --git a/arch/m68k/net/bpf_jit_comp.c b/arch/m68k/net/bpf_jit_comp.c
> new file mode 100644
> index 000000000000..6c40d358acd4
> --- /dev/null
> +++ b/arch/m68k/net/bpf_jit_comp.c
> @@ -0,0 +1,1840 @@
[ ... ]
> +static inline void emit_to_le16(struct jit_ctx *ctx, s8 d_lo, s8 d_hi)
> +{
> +	if (CPU_IS_COLDFIRE) {
> +		emit_16(ctx, 0x71c0 | (d_lo << 9) | d_lo);		/* mvz.w d_lo, d_lo */
> +		emit_16(ctx, 0x7180 | (d_hi << 9) | d_lo);		/* mvz.b d_lo, d_hi */
> +		emit_16(ctx, 0xe088 | d_lo);				/* lsr.l #8, d_lo */
> +		emit_16(ctx, 0xe188 | d_hi);				/* lsl.l #8, d_hi */
> +		emit_16(ctx, 0x8080 | (d_lo << 9) | d_hi);		/* or.l d_hi, d_lo */
[ ... ]
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
[ ... ]
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
[ ... ]

This isn't a bug, but the ColdFire byte-swap sequence (mvz.w / mvz.b /
lsr.l #8 / lsl.l #8 / or.l) is open-coded once in emit_to_le16(), twice in
emit_to_le32() and four times in emit_to_le64(), differing only in which
register receives the result.  The ror.w #8 / swap / ror.w #8 sequence is
likewise repeated in emit_to_le32() and twice in emit_to_le64().

Could these go into small helpers, similar to emit_rev16() and emit_rev32()
in arch/arm/net/bpf_jit_32.c, so that emit_to_le32() and emit_to_le64()
reuse them instead of repeating the instructions?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/37360793550
--===============8230421052853861394==--
