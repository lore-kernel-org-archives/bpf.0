Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C4A1440A2E
	for <bpf@vger.kernel.org>; Wed,  9 Sep 2026 07:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788939014; cv=none; b=B44HGJzhiV2dywJ/aN8LKvRBFKvTOcrXNm7bBE1qHnMO+owBFQq79RUMV58C7xy2vFxTU34rRTDkbxiztkDl3MXIJbQc4CUjYffUflEmCU8TFY6pYGC4GWt/sp6byjAfzswwpsfFNXvikbS6Vw5IJbxxwdOQCe+wwYuZyqXYJDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788939014; c=relaxed/simple;
	bh=EJ/4ro8uGM3gfP6dS8hPIQMQkiau5gAA18MbyUMtmEE=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=BzR+X8po31BSVRzqv8EajUHcmwpL8PyzldRH03ZTaRHurhLZjy+8cWZkmWLwbiAVO/Brhmd5p6gxJfmtNZ6iXKytcrUNkO86CZ/JFIFUuDXXrIa83MetrHCo07DoJycGUYp+8tsJGy3NOURmHMsPJ17NDJ0w2mdk3iOgBFxv1so=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b5v7KIeI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b5v7KIeI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 620051F00A3E;
	Wed,  9 Sep 2026 07:30:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788939005;
	bh=d63FprcewcMcqao967XdtVpjGkY/HTsBEo9s2CapnK0=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=b5v7KIeIFBbakFnHRVVjbxi1UoGP5xCLVneuRw4g92y9lmbeIndXKsrIbEALmfuBB
	 IlOGn4gx3NmFwAP2NnH+8acu8TLIzgzzKNRqgjsfhOluUVVKW18cl7W3QBrpTcHMga
	 fG3lJdYUyPBA0gCvSPFvnAQQO60o6tnbc9OBfX/EIMOl3MxALxUpsvA9ldtiuTOhJc
	 I6EAnhpzMpT/eMXskQE9mAnNWa/s/ipcqzZPqmx4WVASdjxlG50zG/RoDLA5ZPFHHR
	 gISD5Qsqu50Uy4HKduA0MLW0MmvArLzIOzlV6+eNc3sBaddeg5sLWrrux5J9fZuF/J
	 cu5X0qEK/vrcA==
Content-Type: multipart/mixed; boundary="===============8904187601414109402=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <41db2f5f6481cb0e9ca5a73d5a597578ebffa4bd39cbcf98aabbcaf87048809f@mail.kernel.org>
In-Reply-To: <20260909062610.4008921-1-yonghong.song@linux.dev>
References: <20260909062610.4008921-1-yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next v2 09/12] bpf, arm64: Move kfunc arguments into the arm64 calling convention
From: bot+bpf-ci@kernel.org
To: yonghong.song@linux.dev,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,kernel-team@fb.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Wed,  9 Sep 2026 07:30:04 +0000 (UTC)

--===============8904187601414109402==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> commit 7c4f41d1b9c4dfdbada8f6d1b1097849ccb20de8
> Author: Yonghong Song <yonghong.song@linux.dev>
>
>     bpf, arm64: Move kfunc arguments into the arm64 calling convention
>
>     Do proper move from bpf calling convention to arm64 calling convention
>     to satisfy native requirement. AAPCS64 only ever moves an argument to a
>     higher slot, so the moves need one scratch register to carry an eightbyte
>     from one stack slot to another, and never the one a convention moving an
>     argument down would need.
>
>     In addition, the arena argument walk counts eightbytes rather than
>     parameters, as an argument may take two registers. The walk takes the
>     func model from the caller now, as the moves need it too, and runs first
>     so that they carry the rebased value.
>
>     Signed-off-by: Yonghong Song <yonghong.song@linux.dev>

This looks like a bug fix for multi-slot kfunc argument support.
Should this include:

  Fixes: 2092c3247e45 ("bpf: Prepare kfunc arguments for the JIT from an ABI description")

In v1 of this series, Alexei Starovoitov raised a design concern about
the overall approach. He questioned why the BPF calling convention should
diverge from x86-64/arm64, noting that both JIT patches doing argument
shuffling is a sign that the approach may be wrong on the BPF side. He
suggested adjusting the BPF calling convention to match arm64 (the
stricter of the two architectures) rather than forcing all JITs to adapt:

  "Why cannot we adjust bpf calling convention to match arm64/x86 the
  best? Since arm64 is stricter, I'd pick that style. There are no kfuncs
  that use int128 or 16+ byte args, so it's a matter of bpf subprogs
  calling bpf subprogs. Seems cleaner to adjust what llvm emits instead of
  forcing all jits to adapt."

The v2 took the opposite approach - keeping the BPF calling convention
and implementing JIT argument shuffling in both x86 and arm64. Was this
design decision explicitly discussed and agreed upon?

> diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
> index 3aa3ea0bc30b..bdac930dbdec 100644
> --- a/arch/arm64/net/bpf_jit_comp.c
> +++ b/arch/arm64/net/bpf_jit_comp.c

[ ... ]

> @@ -1262,19 +1268,20 @@ static void emit_stack_arg_store_imm(s32 imm, s16 bpf_off, const u8 tmp, struct
>   * kern_vm_start. A nullable arg preserves NULL by skipping the add, tested
>   * on the truncated value as arena NULL is offset 0.
>   */
> -static int emit_kfunc_arena_args(struct jit_ctx *ctx, const struct bpf_insn *insn)
> +static int emit_kfunc_arena_args(struct jit_ctx *ctx, const struct btf_func_model *fm)
>  {
>  	const u8 arena_vm_base = bpf2a64[ARENA_VM_START];
> -	const struct btf_func_model *fm;
> -	int i;
> -
> -	fm = bpf_jit_find_kfunc_model(ctx->prog, insn);
> -	if (!fm)
> -		return -EINVAL;
> +	int i, slot;
>
> -	for (i = 0; i < min_t(int, fm->nr_args, MAX_BPF_FUNC_REG_ARGS); i++) {
> -		const u8 reg = bpf2a64[BPF_REG_1 + i];
> +	for (i = 0, slot = 0; i < fm->nr_args; i++) {
> +		u32 arg_regs = (fm->arg_size[i] + 7) / 8;
>  		u8 flags = fm->arg_flags[i];
> +		u8 reg;
> +
> +		if (slot + arg_regs > MAX_BPF_FUNC_REG_ARGS)
> +			break;
> +		reg = bpf2a64[BPF_REG_1 + slot];
> +		slot += arg_regs;
>
>  		if (!(flags & BTF_FMODEL_ARENA_ARG))
>  			continue;

[ ... ]

> @@ -1293,6 +1300,45 @@ static int emit_kfunc_arena_args(struct jit_ctx *ctx, const struct bpf_insn *ins
>  	return 0;
>  }
>
> +static bool a64_arg_on_stack(u8 slot)
> +{
> +	return slot >= arm64_arg_abi.nr_arg_regs;
> +}
> +
> +static s32 a64_arg_stack_off(u8 slot)
> +{
> +	return (slot - arm64_arg_abi.nr_arg_regs) * sizeof(u64);
> +}
> +
> +/*
> + * AAPCS64 only ever moves an argument to a higher slot, so the planner asks
> + * for the scratch only to carry an eightbyte from one stack slot to another.
> + */
> +static void emit_kfunc_arg_moves(struct jit_ctx *ctx, const struct btf_func_model *fm)
> +{
> +	struct bpf_jit_arg_move moves[BPF_JIT_MAX_ARG_MOVES];
> +	const u8 tmp = bpf2a64[TMP_REG_1];
> +	u32 i, n;
> +
> +	n = bpf_jit_plan_arg_moves(&arm64_arg_abi, fm, moves);
> +
> +	for (i = 0; i < n; i++) {
> +		u8 dst = moves[i].dst, src = moves[i].src, reg;
> +
> +		if (a64_arg_on_stack(src)) {
> +			reg = a64_arg_on_stack(dst) ? tmp : dst;
> +			emit(A64_LDR64I(reg, A64_SP, a64_arg_stack_off(src)), ctx);
> +		} else {
> +			reg = src;
> +		}
> +
> +		if (a64_arg_on_stack(dst))
> +			emit(A64_STR64I(reg, A64_SP, a64_arg_stack_off(dst)), ctx);
> +		else if (reg != dst)
> +			emit(A64_MOV(1, dst, reg), ctx);
> +	}
> +}

This isn't a bug, but would it be clearer to say the plan never needs a
scratch on AAPCS64 and that TMP_REG_1 is only this helper's
stack-to-stack carrier? As written, the comment reads as though moves[]
can contain BPF_JIT_ARG_TMP (which the loop does not handle - unlike the
x86 version at arch/x86/net/bpf_jit_comp.c which does), and the ': dst'
arm in the conditional looks unreachable for the same reason (src on the
stack implies dst on the stack, since dst >= src >= nr_arg_regs).

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/34320399441
--===============8904187601414109402==--
