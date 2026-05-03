Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBD9919D07E
	for <bpf@vger.kernel.org>; Sun,  3 May 2026 18:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777834070; cv=none; b=YKpiaPNGawSMNTCl7laUY/z1cYcNXVyyjXmrgBY4ubxMbTcfkh73k0AGhqEenF7159XJ1gEcG9VRrG/rWdTFwX8hkmEapjGFU/El9Te57x9gx3NloYQUTddjlAuvHXpPXbEz0ebmmvCFjb88yyou7rQD+M+usjHEG1thQyuFG5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777834070; c=relaxed/simple;
	bh=JZZ9NTjJGiiwmcNSrY9zz4iQpy/94Jrg8tnvJSINdhc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nQtexv72vPxR0Vb9YkLwHCWeB0IucP+x70/j9oiSkHUPfNWNkCbI7q8dgulNeGZocGRzLNK9hWtIFvEpRjHg/2M8+YOPTUypQmODtj82yyqyChUvWnFSPAPMJERzJt2Or0z9UsACV69Fu8GiK/lcjhU3gQfmxRs9rWlwAS80jKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hwR5lTnp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hwR5lTnp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45E4FC2BCB4;
	Sun,  3 May 2026 18:47:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777834070;
	bh=JZZ9NTjJGiiwmcNSrY9zz4iQpy/94Jrg8tnvJSINdhc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=hwR5lTnp640IWwqAN5SY4eWuvXif2ejjhaflt65+js69btQHEfB0RPhrr4KS9kYJu
	 dtKh1lJEw0OmoeNPFgzD4xnAUSMjThOBv86Q/6FqSFyUpznUzYp+xGfwzL1i/V8TN5
	 bGNP92PvGof7BJ393+9DhuKqnD5u2H3THZwXuiyfROzONScRIdCTDH1zGU34Nf06/I
	 iMddE4ZSe+YQ4WylbMkjGRxUcaM5M/RpwrfnIGRScJ7x/gqQVl0VTWkUB9IEVt6Bf9
	 r6baTp6c4BZAQy0tZEYjuDPQOCj6TPtE+CLP0ArFDX0y564l0h+lugAAc8MyTM4DIq
	 pp5VuAClaGdHw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2] m68k, bpf: Add initial BPF JIT compiler
 support
Reply-To: sashiko@lists.linux.dev
To: "Kuan-Wei Chiu" <visitorckw@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260503181504.1037640-1-visitorckw@gmail.com>
References: <20260503181504.1037640-1-visitorckw@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 03 May 2026 18:47:49 +0000
Message-Id: <20260503184750.45E4FC2BCB4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] BPF-to-BPF subprogram calls (BPF_PSEUDO_CALL) are broken due to ca=
lling convention mismatches (uninitialized arguments and swapped return val=
ue).
--

commit f2d67ed1dad4f59dffd02142f7b92c353536f557
Author: Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: m68k, bpf: Add initial BPF JIT compiler support

This commit introduces a BPF JIT compiler for the m68k architecture, genera=
ting
m68020+ machine code. It currently excludes 68000/68010 and coldfire proces=
sors
because it relies on 32-bit branch displacements.

> diff --git a/arch/m68k/net/bpf_jit_comp.c b/arch/m68k/net/bpf_jit_comp.c
> new file mode 100644
> index 000000000000..98cef53c6f39
> --- /dev/null
> +++ b/arch/m68k/net/bpf_jit_comp.c
[ ... ]
> +static int emit_call(const struct bpf_insn *insn, struct jit_ctx *ctx)
> +{
[ ... ]
> +	emit_16(ctx, 0x4e90);					/* jsr (%a0) */
> +
> +	emit_16(ctx, 0x4fef);					/* lea 40(%sp), %sp */
> +	emit_16(ctx, 40);
> +
> +	emit_16(ctx, 0xc340);					/* exg %d0, %d1 */
> +
> +	return 0;
> +}

For BPF-to-BPF subprogram calls (BPF_PSEUDO_CALL), does this exg %d0, %d1
swap the halves of the return value incorrectly?

The caller seems to assume all callees return values using the C ABI (high
32 bits in %d0, low in %d1). However, BPF subprograms place their 64-bit
return value in BPF_REG_0 (mapped to %d1 and %d0), so swapping them here
would corrupt the returned value.

[ ... ]
> +static void build_prologue(struct jit_ctx *ctx)
> +{
[ ... ]
> +	emit_16(ctx, 0x202e);					/* move.l 8(%fp), %d0 */
> +	emit_16(ctx, 8);
> +
> +	bpf_put_reg32(bpf2m68k[BPF_REG_1][1], M68K_D0, ctx);
> +	emit_16(ctx, 0x7000 | (M68K_D0 << 9));			/* moveq #0, %d0 */
> +	bpf_put_reg32(bpf2m68k[BPF_REG_1][0], M68K_D0, ctx);
[ ... ]

In the case of BPF-to-BPF subprogram calls, emit_call() pushes arguments
R1-R5 onto the stack before the call, but this prologue appears to
unconditionally assume the C ABI.

It reads a single 32-bit context pointer from 8(%fp) into BPF_R1_LO and
zeroes BPF_R1_HI, while completely ignoring R2-R5 passed by the caller.

Could this lead to subprograms operating on uninitialized stack garbage
for R2-R5, and having their R1 incorrectly initialized?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260503181504.1037=
640-1-visitorckw@gmail.com?part=3D1
