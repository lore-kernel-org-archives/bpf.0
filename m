Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB67445DF44;
	Wed, 22 Jul 2026 15:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784734131; cv=none; b=V3LLdkkfLQk3Kn8WDV0hHH2p3peYJhU+pfxs5u7fmFoMX4zzC6oC7o3NZ5FhPhvw3z1j17UG5Xdr0xmkUkD0mWe3mrxHlmwtWfu0VPjW+rgpgyr+bev/bKcAyy2TtSQNiJC736ZfuP3yOYcu5MJ+PzUZ9CyNfY3q8ObTtJTaZrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784734131; c=relaxed/simple;
	bh=T7qNbWNMCW+XnZ3bHIKMzFZeRbjfJifnJdxVxkDn+7M=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=S7YdygNGjCyKN0IJDacxpbyOIvX7BNAo8BsDSisqdHfiQenuRlBOmS4T8kQcuAKoYVn+Pr9kksb2PcCdwkSJdTg+lRqXGK7bsSLEgLaRiaZleJ6bAdLVQJW1NyPi5B9DfOc3iNmm8ehTqnsXEzky6zMpjlIBXP2i0S+u7oyNNVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AuW6CU/P; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AuW6CU/P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7234E1F000E9;
	Wed, 22 Jul 2026 15:28:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784734119;
	bh=LAPSEeqODkSr8MHh7/rXtwJjk2BELc7XRJ901+kQ/zI=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=AuW6CU/Pl8pOWp+6+XFCEhtEbQ56YsHdLLuakoq0hh9/EUVfwsFgDfepe7lSYzfd6
	 P0QQd4qLpOfvVLE4fjnVTgRsAMvmnql9p6b8kS3wJYqDsvCBW2T47GZQbXIUBGwgRy
	 nQ77eVZeoyvGOgaLgPsDjHleEgqLc91AzD+40HI31AjoKTGrcZhGsNd3U+wMvYXZB6
	 ibgYVZ121LCIMDQt7drSHK3lJlxUQi++TS+zKTn9nxZ6GuItakU1oN8VLUZbsEe11b
	 aPCbSaJI5IeGqdPwqN/ysQjy6uTpnPSYwtwJ06Zcm2+24zy+FDgm1yRs96jeTpA19g
	 Gl4xy2XhA/ehg==
Content-Type: multipart/mixed; boundary="===============5638868986840667114=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <1ad4363fcdd7bb7d9d11d831b450ef21753560486b90e90c7a9b93936677843c@mail.kernel.org>
In-Reply-To: <20260722140015.1982158-6-varunrmallya@gmail.com>
References: <20260722140015.1982158-6-varunrmallya@gmail.com>
Subject: Re: [PATCH bpf-next v3 5/6] riscv, bpf: Add support for BPF exceptions
From: bot+bpf-ci@kernel.org
To: varunrmallya@gmail.com,pjw@kernel.org,palmer@dabbelt.com,aou@eecs.berkeley.edu,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,bjorn@kernel.org,pulehui@huawei.com
Cc: alex@ghiti.fr,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,puranjay@kernel.org,linux-riscv@lists.infradead.org,linux-kernel@vger.kernel.org,bpf@vger.kernel.org,linux-kselftest@vger.kernel.org,varunrmallya@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed, 22 Jul 2026 15:28:37 +0000 (UTC)

--===============5638868986840667114==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_comp64.c
> index b804382075c40..e0c2f73bc646a 100644
> --- a/arch/riscv/net/bpf_jit_comp64.c
> +++ b/arch/riscv/net/bpf_jit_comp64.c
> @@ -56,6 +56,29 @@ static const int pt_regmap[] = {
>  	[RV_REG_T0] = offsetof(struct pt_regs, t0),
>  };
>
> +/* Full set of RISC-V callee-saved GP registers (ra, s0-s11) saved by a program
> + * acting as an exception boundary, in the order they are stored on the stack.
     ^^

This isn't a bug, but Bjorn Topel requested netdev-style multi-line
comments in v2. Should the opening /* be on the same line as the first
text instead of on its own line?

> + * RA and FP come first so the saved ra/fp pair forms a valid stackframe record
> + * at [FP-8]/[FP-16] for the unwinder. The exception callback reuses the
> + * boundary program's frame and restores this same set in its epilogue, so both
> + * paths must agree on the contents and ordering of this list.
> + */
> +static const int rv_exception_csave_regs[] = {
> +	RV_REG_RA,
> +	RV_REG_FP,
> +	RV_REG_S1,
> +	RV_REG_S2,
> +	RV_REG_S3,
> +	RV_REG_S4,
> +	RV_REG_S5,
> +	RV_REG_S6,
> +	RV_REG_S7,
> +	RV_REG_S8,
> +	RV_REG_S9,
> +	RV_REG_S10,
> +	RV_REG_S11,
> +};

[ ... ]

> @@ -312,11 +335,67 @@ static void emit_normal_restore(struct rv_jit_context *ctx, int stack_adjust)
>  	emit_ld(RV_REG_TCC, ctx->tcc_offset, RV_REG_SP, ctx);
>  }
>
> +static bool is_exception_prog(const struct bpf_prog *prog)
> +{
> +	return prog->aux->exception_boundary || prog->aux->exception_cb;
> +}
> +
> +static void emit_exception_boundary_prologue(struct rv_jit_context *ctx,
> +					     int stack_adjust)
> +{
> +	int store_offset = stack_adjust - 8;
> +	int i;
> +
> +	emit_addi(RV_REG_SP, RV_REG_SP, -stack_adjust, ctx);
> +	for (i = 0; i < ARRAY_SIZE(rv_exception_csave_regs); i++) {
> +		emit_sd(RV_REG_SP, store_offset, rv_exception_csave_regs[i], ctx);
> +		store_offset -= 8;
> +	}
> +
> +	/* store TCC from RV_REG_TCC to stack */
> +	emit_sd(RV_REG_SP, store_offset, RV_REG_TCC, ctx);
> +	ctx->tcc_offset = store_offset;
> +
> +	emit_addi(RV_REG_FP, RV_REG_SP, stack_adjust, ctx);
> +}
> +
> +/* reuses the boundary program's frame, whose frame pointer
> + * is passed in a2 (since it's the third argument from bpf_throw()).
     ^^

Same comment style here - should this also follow netdev style?

> + * Setting SP = FP - stack_adjust lines the epilogue's loads up with
> + * the registers the boundary saved.
> + */
> +static void emit_exception_cb_prologue(struct rv_jit_context *ctx,
> +				       int stack_adjust)
> +{
> +	emit_mv(RV_REG_FP, RV_REG_A2, ctx);
> +	emit_addi(RV_REG_SP, RV_REG_FP, -stack_adjust, ctx);
> +	ctx->tcc_offset = stack_adjust - 8 - ARRAY_SIZE(rv_exception_csave_regs) * 8;
> +}
> +
> +/* Used by both the boundary program and the exception callback alike, since the
> + * callback runs on the boundary's frame.
     ^^

And here as well.

> + */
> +static void emit_exception_restore(struct rv_jit_context *ctx, int stack_adjust)
> +{
> +	int store_offset = stack_adjust - 8;
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(rv_exception_csave_regs); i++) {
> +		emit_ld(rv_exception_csave_regs[i], store_offset, RV_REG_SP, ctx);
> +		store_offset -= 8;
> +	}
> +	/* restore TCC from stack to RV_REG_TCC */
> +	emit_ld(RV_REG_TCC, ctx->tcc_offset, RV_REG_SP, ctx);
> +}
> +
>  static void __build_epilogue(bool is_tail_call, struct rv_jit_context *ctx)
>  {
>  	int stack_adjust = ctx->stack_size;
>
> -	emit_normal_restore(ctx, stack_adjust);
> +	if (is_exception_prog(ctx->prog))
> +		emit_exception_restore(ctx, stack_adjust);
> +	else
> +		emit_normal_restore(ctx, stack_adjust);
>
>  	emit_addi(RV_REG_SP, RV_REG_SP, stack_adjust, ctx);
>  	/* Set return value. */

[ ... ]

> @@ -2183,3 +2280,12 @@ bool bpf_jit_supports_subprog_tailcalls(void)
>  {
>  	return true;
>  }
> +
> +bool bpf_jit_supports_exceptions(void)
> +{
> +	/* bpf_throw() unwinds by walking the frame-pointer chain from inside
> +	 * the kernel back into the BPF frames (see arch_bpf_stack_walk()), so
         ^^

And one more multi-line comment here with the same style.

> +	 * exceptions require the frame-pointer unwinder to be enabled.
> +	 */
> +	return IS_ENABLED(CONFIG_FRAME_POINTER);
> +}


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/29929750005
--===============5638868986840667114==--
