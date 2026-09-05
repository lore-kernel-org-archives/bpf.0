Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 196CC3B0AD8;
	Sat,  5 Sep 2026 08:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788595216; cv=none; b=C3XMgWEa5GpdYnu/R3hD76LMgjud//kDf+6SYO2cMTLnEeS1F4PXffVWKHwavSjLJMYULqIZQGXIHl5/ewxcSKNbWmkZ3xR9L6L8ovh39QueKVCh+dHRBnhFP+9m+8dhRK9rdh5mb4QAOzyOMPv135xHW+GoPVKMeSuhsmLSOWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788595216; c=relaxed/simple;
	bh=iyCkXomzR5286HHWdnoIJS2r8jQGggi5t8FrrMJjP+4=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=LgFU+RbsvLjyQc0icugAoJ2Njbvu969Xc061lIDcZqcVtIyv6Ahra7ZipLIYkE9frfwxNqrmOO7hJplCxEZVXcDVo7P4hZzFsTu7s/J7X7Bo4Xk9/2lhGh8lNZPtuyOVUv0shOxGLA38VuRnEfWbCQpaqHhMPktJWAdrF5xvb3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GhAXa2bh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GhAXa2bh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4976F1F00A3E;
	Sat,  5 Sep 2026 08:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788595214;
	bh=jd7wevDUqLErtg9VgaM84Yfx1htFuCdlyNRCsT18Zek=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=GhAXa2bhB9ZhppjTNXADjPibAvQc3qk/5nNOtwRFFfVIWXLRbMmtBI8I06ucospYN
	 iYO0q5XgbW1ZHxoNJ3p8dvxJCrwzCjwDisyj76IXFfZVwY8m+Oa6AIb5KWnKdWCbnD
	 WCJh8iN+nHcZGoHd3o/obkZTreAH5n7crSXo2HUjQ/ti7sDbpqE3MagnkYNgSiCleF
	 1stJqSDG7p0ROef4XBQMW9CskNvAeWb3/mKfI7ketdKSWKFkR7i/2PXpMwHPpqPp9b
	 tXthyzdThuMx32bqwibdaVi+haK7ewSVFLZQ+Byaa1nDt3Sq/0D9q01pLohtrgEy1C
	 5Q5h4JCLqRz8g==
Content-Type: multipart/mixed; boundary="===============8810913334160696580=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <fc702295c9ff5bdad0622a0aebbeadb040a0fabc0b79c6e904c968a516de859b@mail.kernel.org>
In-Reply-To: <20260905070409.4141522-3-pulehui@huaweicloud.com>
References: <20260905070409.4141522-3-pulehui@huaweicloud.com>
Subject: Re: [PATCH bpf-next v4 2/3] riscv, bpf: Add BPF stack arguments support for RV64 JIT
From: bot+bpf-ci@kernel.org
To: pulehui@huaweicloud.com,bpf@vger.kernel.org,linux-riscv@lists.infradead.org,linux-kernel@vger.kernel.org,jiangfeng@kylinos.cn
Cc: bjorn@kernel.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev,puranjay@kernel.org,pjw@kernel.org,palmer@dabbelt.com,alex@ghiti.fr,pulehui@huawei.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Sat,  5 Sep 2026 08:00:13 +0000 (UTC)

--===============8810913334160696580==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/arch/riscv/net/bpf_jit.h b/arch/riscv/net/bpf_jit.h
> index 419b9d795f2a..039877f286fc 100644
> --- a/arch/riscv/net/bpf_jit.h
> +++ b/arch/riscv/net/bpf_jit.h
> @@ -82,6 +82,7 @@ struct rv_jit_context {
>  	unsigned long flags;
>  	int stack_size;
>  	int tcc_offset;
> +	int stack_arg_sz;
>  	u64 arena_vm_start;
>  	u64 user_vm_start;
>  };
> diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_comp64.c
> index aac128b9f0a4..cda99c1f9ffe 100644
> --- a/arch/riscv/net/bpf_jit_comp64.c
> +++ b/arch/riscv/net/bpf_jit_comp64.c
> @@ -498,6 +498,18 @@ static void emit_ldx(u8 rd, s16 off, u8 rs, u8 size, bool sign_ext,
>  	ctx->ex_jmp_off = ctx->ninsns;
>  }
>
> +static void emit_stack_arg_ldx(u8 rd, s16 off, struct rv_jit_context *ctx)
> +{
> +	int idx = off / 8 - 1;
> +
> +	if (idx < 3) {
> +		emit_mv(rd, RV_REG_A5 + idx, ctx);
> +		return;
> +	}
> +
> +	emit_ldx_insn(rd, (idx - 3) * 8, RV_REG_FP, BPF_DW, false, ctx);
> +}
> +

This isn't a bug, but the literal 3 appears seven times across this file
and bpf_jit_core.c (lines 505, 510, 535, 540, 563, 568, and bpf_jit_core.c
line 78). The value really represents RV_MAX_REG_ARGS - MAX_BPF_FUNC_REG_ARGS
(8 - 5). The file already defines RV_MAX_REG_ARGS symbolically and uses it in
the kfunc fix-up loop (if (idx < RV_MAX_REG_ARGS) / (idx - RV_MAX_REG_ARGS)),
but the stack argument helpers use the literal instead.

Would a named constant (e.g. NR_STACK_ARG_REGS = RV_MAX_REG_ARGS -
MAX_BPF_FUNC_REG_ARGS) placed in bpf_jit.h be worth it here, so the same
value in bpf_jit_core.c and the three emit helpers cannot drift apart? arm64
uses NR_STACK_ARG_REGS with an explicit stack_arg_reg[] table.

>  static void emit_st(u8 rd, s16 off, s32 imm, u8 size, struct rv_jit_context *ctx)
>  {
>  	emit_imm(RV_REG_T1, imm, ctx);
> @@ -515,6 +527,19 @@ static void emit_st(u8 rd, s16 off, s32 imm, u8 size, struct rv_jit_context *ctx
>  	ctx->ex_jmp_off = ctx->ninsns;
>  }
>
> +static void emit_stack_arg_st(s16 off, s32 imm, struct rv_jit_context *ctx)
> +{
> +	int idx = -off / 8 - 1;
> +
> +	emit_imm(RV_REG_T1, imm, ctx);
> +	if (idx < 3) {
> +		emit_mv(RV_REG_A5 + idx, RV_REG_T1, ctx);
> +		return;
> +	}
> +
> +	emit_stx_insn(RV_REG_SP, (idx - 3) * 8, RV_REG_T1, BPF_DW, ctx);
> +}
> +

This isn't a bug, but for idx < 3 (the common case, covering BPF args 6-8),
could this be emit_imm(RV_REG_A5 + idx, imm, ctx) directly, avoiding the
RV_REG_T1 round trip and one instruction per store? The emit_imm then emit_mv
sequence is carried over from emit_st() where materialising into a scratch
register is unavoidable because the destination is memory. Here in the
register case the immediate could be materialised straight into the
destination. The two sibling helpers (emit_stack_arg_ldx, emit_stack_arg_stx)
have no scratch use at all, and arm64's emit_stack_arg_store() writes the
immediate path directly into the argument register.

> +static void emit_stx(u8 rd, s16 off, u8 rs, u8 size, struct rv_jit_context *ctx)
> +{
> +	if (is_12b_int(off)) {
> @@ -531,6 +556,18 @@ static void emit_stx(u8 rd, s16 off, u8 rs, u8 size, struct rv_jit_context *ctx)
>  	ctx->ex_jmp_off = ctx->ninsns;
>  }
>
> +static void emit_stack_arg_stx(s16 off, u8 rs, struct rv_jit_context *ctx)
> +{
> +	int idx = -off / 8 - 1;
> +
> +	if (idx < 3) {
> +		emit_mv(RV_REG_A5 + idx, rs, ctx);
> +		return;
> +	}
> +
> +	emit_stx_insn(RV_REG_SP, (idx - 3) * 8, rs, BPF_DW, ctx);
> +}
> +

[ ... ]

> diff --git a/arch/riscv/net/bpf_jit_core.c b/arch/riscv/net/bpf_jit_core.c
> index cbfcd287ea16..ed48005568c8 100644
> --- a/arch/riscv/net/bpf_jit_core.c
> +++ b/arch/riscv/net/bpf_jit_core.c
> @@ -48,6 +48,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_verifier_env *env, struct bpf_pr
>  	int pass = 0, prev_ninsns = 0, i;
>  	struct rv_jit_data *jit_data;
>  	struct rv_jit_context *ctx;
> +	u16 stack_arg_cnt;
>
>  	if (!prog->jit_requested)
>  		return prog;
> @@ -71,6 +72,11 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_verifier_env *env, struct bpf_pr
>
>  	ctx->arena_vm_start = bpf_arena_get_kern_vm_start(prog->aux->arena);
>  	ctx->user_vm_start = bpf_arena_get_user_vm_start(prog->aux->arena);
> +
> +	stack_arg_cnt = bpf_out_stack_arg_cnt(env, prog);
> +	/* First 3 stack args in regs, rest on stack */
> +	ctx->stack_arg_sz = stack_arg_cnt > 3 ? round_up((stack_arg_cnt - 3) * 8, STACK_ALIGN) : 0;
> +
>  	ctx->prog = prog;
>  	ctx->offset = kvzalloc_objs(int, prog->len);
>  	if (!ctx->offset)


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/33952202002
--===============8810913334160696580==--
