Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 351FD4A64E5
	for <bpf@vger.kernel.org>; Fri, 11 Sep 2026 16:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789145257; cv=none; b=Dn2E90JwgnBpI37DYffOg1hrxXloGofSw4Kiv+7ZwhHzGoiEuf+Lul/eZ981bs+2jyKs4ubbx9EemvLghfogWr530p60lnzx8z9lTQQ5//ArYMrjI6wObjOGdjpLzVie4xtxiD4E6wjV+NtaQofrXRw9BUJ1ALKklTPEmNC2OrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789145257; c=relaxed/simple;
	bh=uBL3EESAPAX7JaZeeehiMZDUjpiQlWekJ5Q6mUp6ihU=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=V8WqFI87+6vLOhun4YeZP5R0JYnHL07aR7r1ZS5OtTcnu/72RLU2V343A7zKUPuNjluma2qEnmksF5e6Qs+hFNw+Efwo0HXvys+TKRXHhHP7hiZX6JVaQcoc6dW+kuJS/fGckAHh+3m/9LaTG0L5E7kcDz/WBjwU3rK2DE5NB9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MPzTOVpx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MPzTOVpx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5E071F000FF;
	Fri, 11 Sep 2026 16:47:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789145254;
	bh=01cn9UgRR0tGFILgxD7Z08g7+3C3KYuEjUQniPvA0D0=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=MPzTOVpxp5RJK2kvAJhpb7TiDvfw1l6fR7g/W0Z9wIbGZRpWUYX2gDsv560nqp4vK
	 XP0oJz8Vz/gQRGVwwFMtJHi10YTTQ57VHfqzTo+Po7I1QG6f9TwhgHVYKDco/wgWfe
	 eLyHN8sXMsCnuU4g7T27PgAS0ps5SY/y/fsOeFJsriy4HG2x2WTyNGzcPRmqDhKM+q
	 bR+B00tgIIbyrwD0uosgEqv5eK+NK1+qGikyaIfgbNZc3dA2t0W1gTOnYW0R8RpWKv
	 L1IbglJQ6EgIMzYGqJsRz3cIWPLBH8nfobRgLSrfWORRwwZHi5hnmZI+rpYa0AWQ18
	 kIDT4C6sG938w==
Content-Type: multipart/mixed; boundary="===============7004763093065550919=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <f4f7cb06233a74fad41e9ebb3da63dd916eb11b3842346e9fa7da6c9061211b7@mail.kernel.org>
In-Reply-To: <20260911155010.2011265-1-yonghong.song@linux.dev>
References: <20260911155010.2011265-1-yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next v3 11/15] bpf, arm64: Move kfunc arguments into the arm64 calling convention
From: bot+bpf-ci@kernel.org
To: yonghong.song@linux.dev,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,kernel-team@fb.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Fri, 11 Sep 2026 16:47:33 +0000 (UTC)

--===============7004763093065550919==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
> index 3aa3ea0bc30b..bbde7c0836ae 100644
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
> @@ -1293,6 +1300,52 @@ static int emit_kfunc_arena_args(struct jit_ctx *ctx, const struct bpf_insn *ins
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

This isn't a bug, but would it be worth expressing
emit_stack_arg_load()/emit_stack_arg_store() in terms of
a64_arg_on_stack()/a64_arg_stack_off() (or noting in a comment that the
two forms describe the same slot-to-location map), so the layout lives
in one place? The file now carries two independent encodings of the same
physical outgoing-argument layout: the pre-existing helpers express it
as 'idx = bpf slot - 5', register when idx < NR_STACK_ARG_REGS
(x5/x6/x7) and memory at SP + (idx - NR_STACK_ARG_REGS) * 8 otherwise;
the new helpers express it as 'slot', register when slot <
arm64_arg_abi.nr_arg_regs and memory at SP + (slot - nr_arg_regs) * 8.

> +
> +/*
> + * Move the arguments AAPCS64 places somewhere other than the argument slot the
> + * BPF calling convention gave them. Slot N is X(N) up to the eighth, and the
> + * outgoing stack argument area from SP beyond it, both for the slot an
> + * argument comes from and for the one it goes to.
> + *
> + * AAPCS64 only ever moves an argument to a higher slot, so no move here ever
> + * takes BPF_JIT_ARG_TMP: bpf_jit_plan_arg_moves() hands out the scratch only
> + * for a convention that moves one down, which needs a register to carry the
> + * value past its own destination.
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
> +			reg = tmp;
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

[ ... ]

> @@ -2534,7 +2598,13 @@ struct arg_aux {
>  static int calc_arg_aux(const struct btf_func_model *m,
>  			 struct arg_aux *a)
>  {
> -	int stack_slots, nregs, slots, i;
> +	int stack_slots, nregs, slots, i, total;
> +
> +	/* arm64 supports up to MAX_BPF_FUNC_ARGS argument slots */
> +	for (i = 0, total = 0; i < m->nr_args; i++)
> +		total += (m->arg_size[i] + 7) / 8;
> +	if (total > MAX_BPF_FUNC_ARGS)
> +		return -ENOTSUPP;
>
>  	/* verifier ensures m->nr_args <= MAX_BPF_FUNC_ARGS */
>  	for (i = 0; i < m->nr_args; i++) {

This isn't a bug, but could the changelog say explicitly that arm64's
trampoline path now rejects models whose arguments exceed
MAX_BPF_FUNC_ARGS eightbytes (previously it accepted up to twice that),
so the narrowing is visible to anyone bisecting an fentry attach
failure? The third changelog paragraph describes the calc_arg_aux() hunk
as adding support ('let us support up to MAX_BPF_FUNC_ARGS argument
slots'), while on the trampoline path the hunk is a new restriction:
calc_arg_aux() previously accepted any model btf_distill_func_proto()
admitted (up to 12 arguments of up to 16 bytes, i.e. up to 24
eightbytes), and now returns -ENOTSUPP for anything above 12 eightbytes,
so arch_prepare_bpf_trampoline()/arch_bpf_trampoline_size() fail for
those targets.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/34620351527
--===============7004763093065550919==--
