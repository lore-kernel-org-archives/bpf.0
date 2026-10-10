Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A6A13C09F7;
	Sat, 10 Oct 2026 08:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791622565; cv=none; b=rchoMxzXe423oexUoL1ob8ibaY/jVCbs4oO3VIk92HvVvevNTarZcpOuq0P3C6nVaytaTYxMU8kXF4W9adJFpjhX/CE43U1JNIIhpSHC5RbV6WuY9RcQ2gKi2nySsme27IPJikWW6NKkf/FPdUyTgNutvmYxeCMtQhQV7TULPVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791622565; c=relaxed/simple;
	bh=S1eX0RBN5WE4yYzba4O/NKEmsuWm+oBdkGM258TU794=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=RNLVb9EPI9kiyKm7fS/ry3cPGa+HsWuhtACRsYVV/NKWRnaBu+cwXN+6wK+PpEvM52VS8e468O0+IVVopwI044+Xn+8b69u8U6PX4gOnyhnVgdHm3e03I2kGCdDVPjGtSTx/ayPl5fRtlqmNkcN9yY6wRfrNJ4re/8qTrGb3IpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lmgNtCMd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lmgNtCMd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FDDF1F000FF;
	Sat, 10 Oct 2026 08:56:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791622563;
	bh=PXGECzpbsrEqal5CMwGLH6DcA0sQT7TM47DRVm6PlDI=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=lmgNtCMdUXmVBhtWGQgR9b98gZvv3xhL/Yr88RmtdNy8VD+p5IqHlshCrJo7hVIiE
	 eITZTE0i4rWL5a9JbAzxpI2yMxSCt6BEkWrK8DnQ55zMl3jQsvcZTQCOjIuioHd/Xg
	 TRd8YZeGqWZ0YhhwLVx+7a0B84L00q15mggRh/uqPDBBN/T/YBOqT9AyRNdTZr54xy
	 Q5r2jmVKrkFxAj53LVCOwj5yTVzRSMF1CdfQKidPtmtTnJ6OfB44UFZELs0ux8lCgY
	 +WUdVTQNvnL85A6zpqcHgX1Mqgvv3zLkFy69oVZRve2jHBWyYvRgZAe9x9kLLiN85j
	 LXvSlEyjPgBHQ==
Content-Type: multipart/mixed; boundary="===============1628657098954736497=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <b31863a31621c860cc2d857b65d8478058ccd088f3b3178ea19582dbbb1331fc@mail.kernel.org>
In-Reply-To: <20261010075448.3150878-1-visitorckw@gmail.com>
References: <20261010075448.3150878-1-visitorckw@gmail.com>
Subject: Re: [PATCH v8] m68k, bpf: Add initial BPF JIT compiler support
From: bot+bpf-ci@kernel.org
To: visitorckw@gmail.com,corbet@lwn.net,skhan@linuxfoundation.org,geert@linux-m68k.org,ast@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,memxor@gmail.com,andrii@kernel.org,gerg@linux-m68k.org
Cc: rdunlap@infradead.org,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev,jserv@ccns.ncku.edu.tw,marscheng@google.com,eleanor15x@gmail.com,linux-doc@vger.kernel.org,linux-kernel@vger.kernel.org,linux-m68k@lists.linux-m68k.org,bpf@vger.kernel.org,visitorckw@gmail.com,daniel@thingy.jp,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Sat, 10 Oct 2026 08:56:00 +0000 (UTC)

--===============1628657098954736497==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> m68k, bpf: Add initial BPF JIT compiler support

TL;DR: m68k JIT returns true from bpf_jit_needs_zext() but still zero-extends
after every ALU32 op and load, so verifier-inserted zexts only add code.
Results stay correct; should it honour verifier_zext or drop the override?

> diff --git a/arch/m68k/net/bpf_jit_comp.c b/arch/m68k/net/bpf_jit_comp.c
> new file mode 100644
> index 000000000000..debbf5fbe95b
> --- /dev/null
> +++ b/arch/m68k/net/bpf_jit_comp.c
> @@ -0,0 +1,1810 @@

[ ... ]

> +static void emit_alu32_x(const struct bpf_insn *insn, struct jit_ctx *ctx)
> +{

[ ... ]

> +	}
> +
> +	bpf_put_reg32(dst[1], d_reg, ctx);
> +	emit_16(ctx, 0x7000 | (tmp1[0] << 9));			/* moveq #0, tmp1 */
> +	bpf_put_reg32(dst[0], tmp1[0], ctx);
> +}

emit_alu32_k() ends with the same three lines.  Is it necessary to clear the
upper 32 bits after every ALU32 operation here?

The file also has:

> +bool bpf_jit_needs_zext(void)
> +{
> +	return true;
> +}

Because bpf_jit_needs_zext() returns true, bpf_opt_subreg_zext_lo32_rnd_hi32()
adds a BPF_ZEXT_REG(dst) after every 32-bit def whose upper half is read
later, and it sets prog->aux->verifier_zext.  Nothing in this JIT reads
verifier_zext, so each inserted zext goes through emit_alu32_x() as a plain
mov32 and clears the high word a second time.

For a stack-backed register (R1-R9, AX) the inserted zext costs six extra
instructions, about 20 bytes and four memory accesses:

  move.l d16(%fp),%d2
  move.l d16(%fp),%d4
  move.l %d4,%d2
  move.l %d2,d16(%fp)
  moveq #0,%d3
  move.l %d3,d16(%fp)

The other 32-bit JITs that return true from bpf_jit_needs_zext() skip the
high word clear when verifier_zext is set, for example arm32
(emit_a32_alu_r64 and the special mov32 for zext case), x86-32, riscv32
(bpf_put_reg32) and powerpc32.  emit_ldx() also always zero-extends here.

Results are still correct, but the opt-in only adds code.  Should
emit_alu32_x(), emit_alu32_k() and emit_ldx() honour
ctx->prog->aux->verifier_zext, with the imm == 1 zext mov clearing only the
high word?  Alternatively, since the JIT already zero-extends everywhere,
could the bpf_jit_needs_zext() override be dropped?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/38037161364
--===============1628657098954736497==--
