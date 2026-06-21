Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3756224F3;
	Sun, 21 Jun 2026 15:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782055954; cv=none; b=pybHqiL9FiK1WFVa8WwD+BWaTGO0HeiWrt80j3ixPuxTI+cykBBvcOCNmqAIuZJEHrHyVLa1CF3v1dXVANBbEOZF7vWvj8KxCElLVGw0VhpAdmQc1wV+iOVzBXZDnXrJRaIPtNyLUcNMsf2RilErU1DJRZNsJFzB7x0vlAx2Le0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782055954; c=relaxed/simple;
	bh=QoCxHWSClVF8gY9o2yqG9O25RXq8OnAprTtaMIKtQM4=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=fqZRCEL/g2h3UyB294XfCS5Mn8qlAb628HSUFOBwavDEVgWc/Ks8xyGxei4yAoSNLUj3m1wn8QSYObaoUyd3fniSk+z5kvHFa2kcEHZHX6AJPmnt2GLqP+NfHxE8RWQtN8FMmVATR4VKDY1OtxAfSyoyU1k+cj85rVtF5S40rtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B7RDxXYt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B7RDxXYt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D29D01F000E9;
	Sun, 21 Jun 2026 15:32:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782055953;
	bh=Gvc449anW/TaW87Tk/rh+DmBQXANxwCVNZsSYVPpmO4=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=B7RDxXYtRElE/JdSxTx6BaUqtINa0eNmbhY+qoPRpskg4k14RGxKO9bZKMzSpQ6Xq
	 UtKoEupVVjcXJtlKqmQO5QIVoh6LHVlivtljHzB+QUXyvXD4fexbFPYgwJcl1Ubmwe
	 p/yfOq6X4iHFQXGrJYdXw+lVgQpJh4eZd4vibG8wIdsXaaJY65GGxzfDUVnQD2fpuM
	 C4cmPhUHOmrIeXYtmz/Bjzq25RFi3uBzf+uSwq85dpMQYr4QPyvfh7BHTlAkK7CtND
	 jhGBHYCewnIR3pyFsMJRaXwrbSN9Humqq9ABtenxz6S/mzDYX6WX1ED0oqwfU3dooX
	 Oscq12rZmlazw==
Content-Type: multipart/mixed; boundary="===============5443670299775155235=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <950216803ac2380e0537b27c94ff87dd2ae0dc689fe320c51d96b9095cefc614@mail.kernel.org>
In-Reply-To: <20260621144259.288135-3-varunrmallya@gmail.com>
References: <20260621144259.288135-3-varunrmallya@gmail.com>
Subject: Re: [PATCH bpf-next 2/3] riscv, bpf: Add support for BPF exceptions
From: bot+bpf-ci@kernel.org
To: varunrmallya@gmail.com,pjw@kernel.org,palmer@dabbelt.com,aou@eecs.berkeley.edu,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,bjorn@kernel.org
Cc: alex@ghiti.fr,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,pulehui@huawei.com,puranjay@kernel.org,linux-riscv@lists.infradead.org,linux-kernel@vger.kernel.org,bpf@vger.kernel.org,linux-kselftest@vger.kernel.org,varunrmallya@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Sun, 21 Jun 2026 15:32:32 +0000 (UTC)

--===============5443670299775155235==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_comp64.c
> index c03c1de16b79..eafac0655dab 100644
> --- a/arch/riscv/net/bpf_jit_comp64.c
> +++ b/arch/riscv/net/bpf_jit_comp64.c

[ ... ]

> @@ -2002,11 +2043,61 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
>  void bpf_jit_build_prologue(struct rv_jit_context *ctx, bool is_subprog)
>  {
>  	int i, stack_adjust = 0, store_offset, bpf_stack_adjust;
> +	struct bpf_prog_aux *aux = ctx->prog->aux;
>
>  	bpf_stack_adjust = round_up(ctx->prog->aux->stack_depth, STACK_ALIGN);
>  	if (bpf_stack_adjust)
>  		mark_fp(ctx);
>
> +	if (aux->exception_boundary || aux->exception_cb) {
> +		/*
> +		 * A program acting as an exception boundary saves the full set
> +		 * of riscv callee saved registers (ra, s0-s11).
> +		 */
> +		stack_adjust = round_up(ARRAY_SIZE(rv_exception_csave_regs) * 8,
> +					STACK_ALIGN);
> +		stack_adjust += bpf_stack_adjust;
> +		store_offset = stack_adjust - 8;
> +
> +		/* emit kcfi type preamble immediately before the first insn */
> +		emit_kcfi(is_subprog ? cfi_bpf_subprog_hash : cfi_bpf_hash, ctx);
> +
> +		/* nops reserved for auipc+jalr pair */
> +		for (i = 0; i < RV_FENTRY_NINSNS; i++)
> +			emit(rv_nop(), ctx);
> +
> +		/* First instruction is always setting the tail-call-counter
> +		 * (TCC) register. This instruction is skipped for tail calls.
> +		 * Force using a 4-byte (non-compressed) instruction.
> +		 */
> +		emit(rv_addi(RV_REG_TCC, RV_REG_ZERO, MAX_TAIL_CALL_CNT), ctx);

This isn't a bug, but could the kcfi preamble, fentry-nops loop, and
TCC-init instruction be emitted once before the exception_boundary /
exception_cb branch instead of being duplicated? The same three-part
sequence appears again below in the non-exception path, and the two copies
must stay byte-for-byte identical since the tail-call epilogue skip offset
depends on this fixed layout.

> +
> +		if (!aux->exception_cb && aux->exception_boundary) {
> +			/*
> +			 * Boundary program: allocate the frame and save the
> +			 * full callee-saved set, capturing the caller's values.
> +			 */
> +			emit_addi(RV_REG_SP, RV_REG_SP, -stack_adjust, ctx);
> +			for (i = 0; i < ARRAY_SIZE(rv_exception_csave_regs); i++) {
> +				emit_sd(RV_REG_SP, store_offset,
> +					rv_exception_csave_regs[i], ctx);
> +				store_offset -= 8;
> +			}
> +			emit_addi(RV_REG_FP, RV_REG_SP, stack_adjust, ctx);
> +		} else {
> +			/*
> +			 * Exception callback, reuse the boundary program's
> +			 * frame, whose frame pointer is passed in a2. Setting
> +			 * SP = FP - stack_adjust lines the epilogue's loads up
> +			 * with the registers the boundary saved.
> +			 */
> +			emit_mv(RV_REG_FP, RV_REG_A2, ctx);
> +			emit_addi(RV_REG_SP, RV_REG_FP, -stack_adjust, ctx);
> +		}
> +
> +		goto tail_setup;
> +	}
> +
>  	if (seen_reg(RV_REG_RA, ctx))
>  		stack_adjust += 8;
>  	stack_adjust += 8; /* RV_REG_FP */

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/27908252575
--===============5443670299775155235==--
