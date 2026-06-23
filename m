Received: from canpmsgout12.his.huawei.com (canpmsgout12.his.huawei.com [113.46.200.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0027F30D3E0;
	Tue, 23 Jun 2026 02:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782180726; cv=none; b=N/TGQLh1SjHUSKrccVhgRi9LJ1u7flOS1OBByb44jheuAzCHK0xv9Qjbrj5y9vrql1Qj0wXM6NW+u6q6phxHZnpie47h0jEdxKsDLDvcwEkkDV//oCY2Lxaa1p+u1QxBXt8W9zCkp/xCBI9/b8xOZwSELabGIyDCYOo4qvtYduk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782180726; c=relaxed/simple;
	bh=l9oyzbXNcsHmt1DmxFt6zVwM/N2xIVgjz/nadnI1CNw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=VDwqdstYtQ/mEljUF21KDkDdjPRVZnHPryR2KZ6Q4lFTgWYQAQPIeKLP9Zt7F7K4YJoc7CsFdNNbxLZVgh/bo0a6fMKEsn2vj/KPwT1dStJOZF9JruMtDesVaCahVj5As+fGAZCTRi5kB/aiwRFw9wORhAtUrgz3ZAwq9d39Jq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=XnjYqRCM; arc=none smtp.client-ip=113.46.200.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="XnjYqRCM"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=AGsszw77KlcZ5rp/LEwZTApNpU8N3RBDg6T3bY4aWNs=;
	b=XnjYqRCMLgZPQ4C2MokrD8cBJJFFd/fIMgHXNY0qWJci8OUgEcIvf7WOEaEQ9lg2aQSEPRfas
	w25DK6f5MY2Ba3yjTgcKNwc79KAmp1cIPkyl9WRWNzub1pVrgW/0G3vxzxGqI+op1G5621dGnJI
	diWXGxh8DBe7JCkNqduJIa4=
Received: from mail.maildlp.com (unknown [172.19.163.200])
	by canpmsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4gkpJ15JYPznTVX;
	Tue, 23 Jun 2026 10:03:13 +0800 (CST)
Received: from kwepemf100007.china.huawei.com (unknown [7.202.181.221])
	by mail.maildlp.com (Postfix) with ESMTPS id 60A244055B;
	Tue, 23 Jun 2026 10:11:58 +0800 (CST)
Received: from [10.67.110.68] (10.67.110.68) by kwepemf100007.china.huawei.com
 (7.202.181.221) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Tue, 23 Jun
 2026 10:11:57 +0800
Message-ID: <b6e8c677-5fff-4de1-8483-fc23361898dc@huawei.com>
Date: Tue, 23 Jun 2026 10:11:57 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 2/3] riscv, bpf: Add support for BPF exceptions
Content-Language: en-US
To: Varun R Mallya <varunrmallya@gmail.com>, <pjw@kernel.org>,
	<palmer@dabbelt.com>, <aou@eecs.berkeley.edu>, <ast@kernel.org>,
	<daniel@iogearbox.net>, <andrii@kernel.org>, <eddyz87@gmail.com>,
	<memxor@gmail.com>, <bjorn@kernel.org>
CC: <alex@ghiti.fr>, <martin.lau@linux.dev>, <song@kernel.org>,
	<yonghong.song@linux.dev>, <jolsa@kernel.org>, <emil@etsalapatis.com>,
	<puranjay@kernel.org>, <linux-riscv@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>
References: <20260621144259.288135-1-varunrmallya@gmail.com>
 <20260621144259.288135-3-varunrmallya@gmail.com>
From: Pu Lehui <pulehui@huawei.com>
In-Reply-To: <20260621144259.288135-3-varunrmallya@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemf100007.china.huawei.com (7.202.181.221)



On 2026/6/21 22:42, Varun R Mallya wrote:
> Add the JIT support required for BPF exceptions (bpf_throw()) on riscv64.
> 
> Two kinds of program need special prologue/epilogue handling:
> 
>    - A program acting as an exception boundary must save the full set of
>      riscv callee-saved GP registers (ra, s0-s11), not just the ones it
>      happens to clobber, so that the exception callback can restore the
>      state that was live at the boundary. ra and fp are stored first so
>      the saved ra/fp pair forms a valid stackframe record for the
>      unwinder.
> 
>    - The exception callback (exception_cb) does not allocate its own
>      frame. It reuses the boundary program's frame, whose frame pointer
>      is passed in a2, by setting SP = FP - stack_adjust. This lines the
>      epilogue's loads up with the registers the boundary saved, so both
>      paths restore the same order.
> 
> Wire up bpf_jit_support to be true only when CONFIG_FRAME_POINTER is
> enabled.
> 
> Signed-off-by: Varun R Mallya <varunrmallya@gmail.com>
> ---
>   arch/riscv/net/bpf_jit_comp64.c | 102 ++++++++++++++++++++++++++++++++
>   1 file changed, 102 insertions(+)
> 
> diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_comp64.c
> index c03c1de16b79..eafac0655dab 100644
> --- a/arch/riscv/net/bpf_jit_comp64.c
> +++ b/arch/riscv/net/bpf_jit_comp64.c
> @@ -56,6 +56,30 @@ static const int pt_regmap[] = {
>   	[RV_REG_T0] = offsetof(struct pt_regs, t0),
>   };
>   
> +/*
> + * Full set of RISC-V callee-saved GP registers (ra, s0-s11) saved by a program
> + * acting as an exception boundary, in the order they are stored on the stack.
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
> +
>   enum {
>   	RV_CTX_F_SEEN_TAIL_CALL =	0,
>   	RV_CTX_F_SEEN_CALL =		RV_REG_RA,
> @@ -231,6 +255,22 @@ static void emit_imm(u8 rd, s64 val, struct rv_jit_context *ctx)
>   static void __build_epilogue(bool is_tail_call, struct rv_jit_context *ctx)
>   {
>   	int stack_adjust = ctx->stack_size, store_offset = stack_adjust - 8;
> +	struct bpf_prog_aux *aux = ctx->prog->aux;
> +	int i;
> +
> +	if (aux->exception_boundary || aux->exception_cb) {
> +		/*
> +		 * An exception boundary saved the full callee-saved register
> +		 * set and the exception callback restores it from the boundary's
> +		 * frame. Both restore the same fixed set, in the same order it
> +		 * was stored by bpf_jit_build_prologue().
> +		 */
> +		for (i = 0; i < ARRAY_SIZE(rv_exception_csave_regs); i++) {
> +			emit_ld(rv_exception_csave_regs[i], store_offset, RV_REG_SP, ctx);
> +			store_offset -= 8;
> +		}
> +		goto epilogue_tail;
> +	}
>   
>   	if (seen_reg(RV_REG_RA, ctx)) {
>   		emit_ld(RV_REG_RA, store_offset, RV_REG_SP, ctx);
> @@ -267,6 +307,7 @@ static void __build_epilogue(bool is_tail_call, struct rv_jit_context *ctx)
>   		store_offset -= 8;
>   	}
>   
> +epilogue_tail:
>   	emit_addi(RV_REG_SP, RV_REG_SP, stack_adjust, ctx);
>   	/* Set return value. */
>   	if (!is_tail_call)
> @@ -2002,11 +2043,61 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
>   void bpf_jit_build_prologue(struct rv_jit_context *ctx, bool is_subprog)
>   {
>   	int i, stack_adjust = 0, store_offset, bpf_stack_adjust;
> +	struct bpf_prog_aux *aux = ctx->prog->aux;
>   
>   	bpf_stack_adjust = round_up(ctx->prog->aux->stack_depth, STACK_ALIGN);
>   	if (bpf_stack_adjust)
>   		mark_fp(ctx);
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

We don't need to duplicate code. Please merge it.

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

something confused—why is it A2? I feel like I missed something.

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
>   	if (seen_reg(RV_REG_RA, ctx))
>   		stack_adjust += 8;
>   	stack_adjust += 8; /* RV_REG_FP */
> @@ -2082,6 +2173,7 @@ void bpf_jit_build_prologue(struct rv_jit_context *ctx, bool is_subprog)
>   
>   	emit_addi(RV_REG_FP, RV_REG_SP, stack_adjust, ctx);
>   
> +tail_setup:
>   	if (bpf_stack_adjust)
>   		emit_addi(RV_REG_S5, RV_REG_SP, bpf_stack_adjust, ctx);
>   
> @@ -2157,3 +2249,13 @@ bool bpf_jit_supports_fsession(void)
>   {
>   	return true;
>   }
> +
> +bool bpf_jit_supports_exceptions(void)
> +{
> +	/*
> +	 * bpf_throw() unwinds by walking the frame-pointer chain from inside
> +	 * the kernel back into the BPF frames (see arch_bpf_stack_walk()), so
> +	 * exceptions require the frame-pointer unwinder to be enabled.
> +	 */
> +	return IS_ENABLED(CONFIG_FRAME_POINTER);

riscv select ARCH_WANT_FRAME_POINTERS, so this will always true

> +}
