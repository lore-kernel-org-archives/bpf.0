Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E55FA471CE7
	for <bpf@vger.kernel.org>; Fri, 18 Sep 2026 05:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789710279; cv=none; b=FDd0rtGo51SJgW1gHPSqwzVadcSfE3Pce/C3BP4DN3IhpGpcS5qiebMFkbR+pvU/NfbDZXxly7z100dM45y/eh4bvvAdzVwFzDab4QTkMFzfQev6K47Weur3qEHcB8YYus3OEFxX6w8iWIAfJN11YuZqpErr5fYuMAV5YOrYS+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789710279; c=relaxed/simple;
	bh=uSczFDyHeJZLl680t0R9NrQQxHbccUxrQk8tNvG+sYY=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=lNXvRwvuuVZE1DYHmOvvmCV74wy6QhQBVOaTHwqHs8gpUgKQalG+ncFruKiWQLpdzo7wDTjOvoyA0sEQrGpdUtzxS0m5glbCyiKWgOtFy4UhAj9wWcAFsYSuZePNifs6kqwvOnXwcdckk+B0eLGcGIX8mm5VEUXyth0int1a56g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ch8DZUEM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ch8DZUEM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 094141F000FF;
	Fri, 18 Sep 2026 05:44:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789710277;
	bh=pQQFcwgI6pM0TQv4+LHaBxm/S9yufHz3cKnc/zGceYA=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=Ch8DZUEMjyJVMFBVNG1vaAh2HAc4fptHEpuZLvG3/fjPKUoC5SNzUzcV7Hr+eLbBN
	 Sz0XXtuxcYkpfIBf9cMif2wuc4VHwN9/DW3X3EdYN9JOdY84TzvXNpRPCFB+7QL9DT
	 7beAe72DjIZrRBNho7lrcNu/bsLQ+GEd+t0Fzih5X+LQbcWI+i8gSikjUZbye+pK8a
	 3MGik4fKMpzeBV/QGJRNhnCs7CbsvZdsQi2mc6JBMGq0oJ9sl8CpS+QXzjHh+XHNp9
	 eUYAaeyO9hRuDFkNVHh6ZTacbVCR9I6sV6QH2oUgY9ar9elGT+xr05Is7LB4odRIsT
	 4BPt7X5MVoNXw==
Content-Type: multipart/mixed; boundary="===============6713896808307550678=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <df5244af92cf0268c54eafb2546e7c37a9e6d8a2d534e2b62864b1b80f65ffb3@mail.kernel.org>
In-Reply-To: <20260918044301.3290118-1-yonghong.song@linux.dev>
References: <20260918044301.3290118-1-yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next v2 12/20] bpf, arm64: Dispatch exception cleanup pads at run time
From: bot+bpf-ci@kernel.org
To: yonghong.song@linux.dev,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,kernel-team@fb.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Fri, 18 Sep 2026 05:44:36 +0000 (UTC)

--===============6713896808307550678==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
> index 6c04fee468766..560eba305bca2 100644
> --- a/arch/arm64/net/bpf_jit_comp.c
> +++ b/arch/arm64/net/bpf_jit_comp.c

[ ... ]

> @@ -75,7 +76,21 @@ static const int bpf2a64[] = {
>  	[ARENA_VM_START] = A64_R(28),
>  };
>
> +/* Throw-site spill: the five pairs push_callee_regs() forces on, same size and
> + * slot order, so arch_bpf_run_cleanup_pad() reads both alike.
> + */
> +#define A64_CLEANUP_SPILL_SZ	(5 * 16)
> +
> +/*
> + * Where a landing pad's frame is anchored, since the stack pointer generated
> + * code normally addresses it through is the walker's inside a pad. bpf2a64[]
> + * maps nothing to x24, so nothing else in generated code touches it.
> + */
> +#define A64_CLEANUP_FP		A64_R(24)
> +
>  struct jit_ctx {
> +	/* Bytes reserved for the throw-site spill; see bpf_cleanup_force_spill(). */
> +	u32 throw_spill;
>  	const struct bpf_prog *prog;
>  	int idx;
>  	int epilogue_offset;

This isn't a bug, but would it read better to put throw_spill next to
stack_size and stack_arg_size, which it is always used with, rather
than ahead of prog at the head of the struct?

[ ... ]

> @@ -1367,6 +1411,7 @@ static int build_insn(const struct bpf_verifier_env *env, const struct bpf_insn
>  	const s16 off = insn->off;
>  	const s32 imm = insn->imm;
>  	const int i = insn - ctx->prog->insnsi;
> +	const bool in_pad = bpf_cleanup_insn_in_pad(ctx->prog, i);
>  	const bool is64 = BPF_CLASS(code) == BPF_ALU64 ||
>  			  BPF_CLASS(code) == BPF_JMP;
>  	u8 jmp_cond;
> @@ -1378,9 +1423,14 @@ static int build_insn(const struct bpf_verifier_env *env, const struct bpf_insn
>  	int ret;
>  	bool sign_extend;
>
> -	if (bpf_insn_is_indirect_target(env, ctx->prog, i))
> +	if (bpf_insn_is_indirect_target(env, ctx->prog, i) ||
> +	    bpf_cleanup_insn_is_pad(ctx->prog, i))
>  		emit_bti(A64_BTI_J, ctx);
>
> +	if (bpf_cleanup_insn_is_pad(ctx->prog, i))
> +		emit(A64_SUB_I(1, A64_CLEANUP_FP, fp,
> +			       ctx->stack_size + ctx->stack_arg_size), ctx);
> +

This isn't a bug, but could the two bpf_cleanup_insn_is_pad() calls
share a local the way in_pad does, and could the throw-site check
further down use the existing 'i' instead of recomputing
insn - ctx->prog->insnsi?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/35308528711
--===============6713896808307550678==--
