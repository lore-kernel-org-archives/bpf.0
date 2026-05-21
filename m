Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBB3433A711
	for <bpf@vger.kernel.org>; Thu, 21 May 2026 08:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779350423; cv=none; b=TeshgrWL7RRxqf6eC1rVmWANlDreh/KHpYPnaQK8feGC3fsHuKPgucyVLvqb5pm4H9wvyr+c4nV80hac5UxnKSWJiNuR/le6f/CZYj9CRC/Gx7Gxt+G6MuSQOCN08hKiUXITup+pJ7qz0uMTQa51TvcpYCAhcvH8yhf23UMp7kU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779350423; c=relaxed/simple;
	bh=O1sudiUKSDmev7mE5W3fLu0JtepX3IRh2rkt10V10Vc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Sq36oZNUKTDmz9CiP8CUnvpcaLczjjC/lwGFWVrEOYg9kKV2JnUIjrwdptgokYso/flrif1fOdxmTnIaBN+bJPrZB0sQdB5A+5WY+VkvWZIRr9MQYN93XKIYc1CPtrsDkOlH0FJfPL7g/QmpuxRJs6qtc3FXKyEZURdTciCEc+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LdyVFvTy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LdyVFvTy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD9EE1F000E9;
	Thu, 21 May 2026 08:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779350421;
	bh=1HYlhLWH/mPyyW+zkPnGGMD1glHKYxVERJ1VDCFFdlg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LdyVFvTymK6WgX5rJ4iyE32eWNg89+6q2piD3888qXkIL3RhGlEhH8d1v2xaMz2Al
	 37NylCmUnTvjjZws1QIeq4sUCASW7KtjfknJi4aq8urSqLw7QturDCYyFT1jhoWgGQ
	 dCHA1lmYuA7VSFoVK2NKHdc70GZRzjzDYWdEk+uujTISXX6/WNzKyMz2xU7xn0n3oK
	 FkvcbmFplEUrciTJSaIpA+UDeg8QU0qsT3xxhi5KWGnAI6nRDb5vCTyAOcMYdiMTxl
	 wfyL6xNa1JaTAdutPyNBxsLgjAuQfbIu7YHaHu4G+KiP65QTGRzFynVJdHLtb3tSHk
	 VvimTWIwxs/7g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 1/3] LoongArch: BPF: Fix tail call prologue alignment
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tiezhu Yang" <yangtiezhu@loongson.cn>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260521070128.28086-2-yangtiezhu@loongson.cn>
References: <20260521070128.28086-2-yangtiezhu@loongson.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 21 May 2026 08:00:21 +0000
Message-Id: <20260521080021.AD9EE1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The patch adds a `nop` to the subprogram prologue to fix a non-exis=
tent tail call jump offset issue, as BPF tail calls can never target subpro=
grams.
--

commit d9b7854227e065cad33918647040161cb3ceac6c
Author: Tiezhu Yang <yangtiezhu@loongson.cn>

LoongArch: BPF: Fix tail call prologue alignment

This commit adds a NOP instruction to the subprogram prologue in the LoongA=
rch
BPF JIT. The goal is to align the prologue size between main programs and
subprograms so that tail calls skip the correct number of instructions.

> diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
> index 24913dc7f4e83..aefe5fa1c5840 100644
> --- a/arch/loongarch/net/bpf_jit.c
> +++ b/arch/loongarch/net/bpf_jit.c
> @@ -149,12 +149,15 @@ static void build_prologue(struct jit_ctx *ctx)
>  		emit_insn(ctx, nop);
> =20
>  	/*
> -	 * First instruction initializes the tail call count (TCC)
> -	 * register to zero. On tail call we skip this instruction,
> -	 * and the TCC is passed in REG_TCC from the caller.
> +	 * Initialize or align the TCC register slot.
> +	 * For main programs, TCC is zeroed. For subprograms, a nop is emitted
> +	 * to keep the prologue size consistent, ensuring tail calls skip the
> +	 * correct number of instructions.
>  	 */
>  	if (is_main_prog)
>  		emit_insn(ctx, addid, REG_TCC, LOONGARCH_GPR_ZERO, 0);
> +	else
> +		emit_insn(ctx, nop);

[Severity: Low]
Is this nop instruction and alignment actually necessary for tail calls?

BPF tail calls resolve their target programs exclusively from a
BPF_MAP_TYPE_PROG_ARRAY map. Because subprograms do not have file descripto=
rs,
the verifier ensures that only main programs can be inserted into program
array maps.

Since a tail call can never target a subprogram, it seems it will always
unconditionally target a main program (which includes the TCC initialization
instruction). Does this mean the existing JIT implementation already safely
skips the main program's prologue, and this added nop provides no functional
benefit?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260521070128.2808=
6-1-yangtiezhu@loongson.cn?part=3D1
