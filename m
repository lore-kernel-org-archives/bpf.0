Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794910558;
	b=g1lV7oyvo15ServXYUdk2PG1C68fxoIS+E5cfw+bvoRQ+9FdaBI2H8b1fl3TvFIqp6DM
	 nTfjd3So7mKxkPVjx6sKGIeb/AgtvtMtRj+1l9oOlRnJDG9huBNOXaEjzYLTwRFFhXP52
	 XNKCPIbJixTya1UI2/NlmNyv9lqw6TrisjWDq6uPI4sbkGv/QxKDCJuLHteARsm5kOMIK
	 nuhbiFGC38RN26MUiiwKRU5nui1+2X2nRVvDRzQI0Ts22gTOYMyOYeXQfsPbCkPG7mCIG
	 F+cmDmIHdhWDiVKSOLg5zd/E/vOk8FLsM5gvdNDjeuAKrpDbKK8iMauzYoi3asr6rEQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794910558;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=cqNFlhZFtaF6NhalgUXNQFVaNzn3J4vmFMkG6jX+QrI=;
	b=HbUOybuUPO2R3aVIO9TUy+VivhcwD3MUWH5T8MtIS+IzGieYYMBYyztwIUIKjAMgpDUQ
	 fhoh9iHcAVHHk5e5NphT4JpdDVAPujNG95PZlBZnqyusYdJWeUswOUbQycmbRI/Huwk8o
	 NBmHIRrbsAMLP2sV4jAcK03Mh+5rp2qg7uYkf6KMta08hca03Ct8HlyecAr1k4t/A/C7d
	 oKkQT2DQ25YBPpm/s0qZj7+WnlXVXthazVQBRTvCI/K0AQyZNdH1BOZ7oOgf44liMWHdy
	 HtqwJG/v1PMeMlFkIOe2CDE6yL6cGfi90Q/asqW37ovThgPRmBiuFoCT75PHKsZzhrg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mlSVEzXK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B998606A31C
	for <bpf@vger.kernel.org>; Tue, 17 Nov 2026 10:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mlSVEzXK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F7C01F000C4;
	Tue, 17 Nov 2026 10:15:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794910557;
	bh=cqNFlhZFtaF6NhalgUXNQFVaNzn3J4vmFMkG6jX+QrI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mlSVEzXKWL/jCbXT5+40/xpKrw8mFFqYIwyM7lsRiHe0My3JsOEPAzl6Qrx0Qvn7+
	 Et6BVqeCKKivxpJhbxPU4e/Xs3vQVWToUQ8VP6BUMkggwhvdzNr7+THhftUvnhEQsk
	 Tl2o6g1U3XI2CfaViNS63ivAUf9ChFQhzKqGBsj/wSC4tePF8rWZl5hm1DlL9e7tvL
	 f1W5hquRn25i/Y6AWNjHnYThHUlusx2XNgZ8fDVGPP3TZgDUaCDI3AloGU/UJHgDrG
	 AQ605z936OXyJ9Pwfl8ubAqv3S8QwyBfZeLuEGOz7+qiXl5PEvB64VKZ8utarm7hPB
	 2WzlwGW33EO1g==
Message-ID: <sashiko-outbox-218581@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10] m68k, bpf: Add initial BPF JIT compiler support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kuan-Wei Chiu" <visitorckw@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261117095110.2736779-1-visitorckw@gmail.com>
References: <20261117095110.2736779-1-visitorckw@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 10:15:57 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] m68k, bpf: premature tail-call counter decrement in
  emit_tail_call()
--

commit 1499906cea3bda86a820cc6d5342bc01d96944c1
Author: Kuan-Wei Chiu <visitorckw@gmail.com>

m68k, bpf: Add initial BPF JIT compiler support

This commit adds an eBPF JIT compiler for m68k targeting m68020+ and MMU
ColdFire processors.

> diff --git a/arch/m68k/net/bpf_jit_comp.c b/arch/m68k/net/bpf_jit_comp.c
> new file mode 100644
> index 0000000000000..d5b818ffa7e22
> --- /dev/null
> +++ b/arch/m68k/net/bpf_jit_comp.c

[ ... ]

> +static void emit_tail_call(const struct bpf_insn *insn, struct jit_ctx *=
ctx)
> +{
> +	const s8 *r2 =3D bpf2m68k[BPF_REG_2];
> +	const s8 *r3 =3D bpf2m68k[BPF_REG_3];
> +	int jmp_out_1, jmp_out_2, jmp_out_3;

[ ... ]

> +	emit_16(ctx, 0x262e);					/* move.l d16(%fp), %d3 */
> +	emit_16(ctx, (u16)STACK_OFFSET(BPF_TC_LO));
> +	emit_16(ctx, 0x4a83);					/* tst.l %d3 */
> +	emit_16(ctx, 0x6700);					/* beq.w jmp_out_2 */
> +	jmp_out_2 =3D ctx->idx;
> +	emit_16(ctx, 0);
> +
> +	emit_16(ctx, 0x5383);					/* subq.l #1, %d3 */
> +	emit_16(ctx, 0x2d43);					/* move.l %d3, d16(%fp) */
> +	emit_16(ctx, (u16)STACK_OFFSET(BPF_TC_LO));
> +
> +	emit_16(ctx, 0xd482);					/* add.l %d2, %d2 */
> +	emit_16(ctx, 0xd482);					/* add.l %d2, %d2 */
> +	emit_16(ctx, 0x43e8);					/* lea d16(%a0), %a1 */
> +	emit_16(ctx, offsetof(struct bpf_array, ptrs));
> +	emit_16(ctx, 0xd3c2);					/* adda.l %d2, %a1 */
> +
> +	emit_16(ctx, 0x2051);					/* movea.l (%a1), %a0 */
> +
> +	emit_16(ctx, 0x2408);					/* move.l %a0, %d2 */
> +	emit_16(ctx, 0x4a82);					/* tst.l %d2 */
> +	emit_16(ctx, 0x6700);					/* beq.w jmp_out_3 */
> +	jmp_out_3 =3D ctx->idx;
> +	emit_16(ctx, 0);

[Severity: Medium]
Should BPF_TC_LO be decremented and stored back to the stack only after
checking that the target bpf_prog pointer in (%a1) is non-NULL?  As
written, attempting a tail call on an empty prog-array slot branches to
jmp_out_3 after already decrementing the counter, so failed tail calls to
NULL slots consume remaining tail-call attempts and exhaust
MAX_TAIL_CALL_CNT early.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117095110.2736=
779-1-visitorckw@gmail.com?part=3D1
