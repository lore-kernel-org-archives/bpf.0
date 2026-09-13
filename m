Received: from mta0.migadu.com (out-27.mta0.migadu.com [91.218.175.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C39A4372EC0
	for <bpf@vger.kernel.org>; Sun, 13 Sep 2026 02:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789267671; cv=none; b=V2xxnlbgY7oo0j6/BdrQZWmO8pFN5rZFBgjbmkLH0eqmmxokiiiyL42dXnSGQKQBD+CMypF/6afYVrjbKNVKPZy4jYI7FzHG7SM3SrX0PMgp5xEnI3WAIiE9jGgctHprvjuRz8Z7/N39mf5hAe8Faf8K4wKcl6nPZdQSNKD5DpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789267671; c=relaxed/simple;
	bh=3yEvN/WEYq7hvpNz4u2zcTqxB5yZPsIKrjoAuH19Ogo=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=B2NOiMbUhgvV4yHjjjY+gh01f3MrczlS3kMxERUshvplWBFoZxN8hJSYsXKWp4a84Eo80VqPsp71ql0pfgJvv0TV0/JMSnjDjotelUzB6bIWYc8EIY2sg1ExtG+SZ2WTBDUeu6X3AwY0UtuENz85KET2T/kmoo23idCiqqqgeu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=A+QNlN/8; arc=none smtp.client-ip=91.218.175.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="A+QNlN/8"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=3yEvN/WEYq7hvpNz4u2zcTqxB5yZPsIKrjoAuH19Ogo=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789267666; v=1; x=1789872466;
 b=A+QNlN/8SDA4f2Hy4/5m3IDXzH0ozuDXaQqaTxDdChEvcgWsmFLQPotO2+3N3gxBoRaHW/JJ
 KQI9VItW9jz8qykub6M8a/Zlbt6clZOYLHk+WbOlvxkbxPF7wWGX0AIjxm72YY/U1TAJYhhdNQW
 d4buUnS1/xfvgszKS6YiROh0=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 3e64528a14f6b989;
	Sun, 13 Sep 2026 02:47:46 +0000
X-Mizu-Trace-ID: 3e64528a14f6b989
X-Migadu-Flow: FLOW_OUT
Message-ID: <1994d80f-2e3f-4d44-ab1a-8a293c8c00b2@linux.dev>
Date: Sat, 12 Sep 2026 19:47:43 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v4 11/15] bpf, arm64: Place trampoline arguments
 by the arm64 calling convention
Content-Language: en-GB
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman
 <eddyz87@gmail.com>, kernel-team@fb.com
References: <20260912195156.980886-1-yonghong.song@linux.dev>
 <20260912195252.990578-1-yonghong.song@linux.dev>
In-Reply-To: <20260912195252.990578-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/12/26 12:52 PM, Yonghong Song wrote:
> calc_arg_aux(), save_args() and restore_args() number argument registers
> and stack slots consecutively, while AAPCS64 rounds both up to an even
> one for an argument aligned to 16 bytes: an __int128, or an aggregate
> holding one. The argument that takes the hole, and every argument after
> it, is saved from and restored to the wrong place, so a bpf program
> attached to such a function reads a neighbouring eightbyte, and the
> arguments handed on to the original function are shifted.
>
> Take the position of each argument slot from bpf_jit_place_args() and
> keep it in struct arg_aux. save_args() then reads a slot from the
> register, or the incoming stack slot, and restore_args() puts it back
> there; the outgoing area built for the original function mirrors the
> incoming one, hole and all.
>
> A bpf program still cannot read an __int128 argument itself: it is an
> integer wider than eight bytes, which btf_ctx_access() refuses, so the
> program is rejected whatever the trampoline does with the argument. What
> a program can read, and what the placement puts right, is an aggregate
> holding an __int128, allowed as a struct, and any argument that follows
> a 16-byte aligned one. Both were taken from the wrong place before.
>
> Bound the argument slots rather than the arguments while here.
> btf_distill_func_proto() only limits the count although a by-value
> argument may take two slots, so, similar to x86-64, support up to
> MAX_BPF_FUNC_ARGS argument slots and refuse a function with more.
>
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> ---
>   arch/arm64/net/bpf_jit_comp.c | 78 ++++++++++++++++++++++++-----------
>   1 file changed, 54 insertions(+), 24 deletions(-)
>
> diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
> index 3aa3ea0bc30b..25a7657a6710 100644
> --- a/arch/arm64/net/bpf_jit_comp.c
> +++ b/arch/arm64/net/bpf_jit_comp.c
> @@ -1220,6 +1220,12 @@ static int add_exception_handler(const struct bpf_insn *insn,
>   	return 0;
>   }
>   
> +static const struct bpf_jit_arg_abi arm64_arg_abi = {
> +	.nr_arg_regs		= 8,
> +	.even_reg_align		= true,
> +	.even_stack_align	= true,
> +};
> +
>   static const u8 stack_arg_reg[] = { A64_R(5), A64_R(6), A64_R(7) };
>   
>   #define NR_STACK_ARG_REGS	ARRAY_SIZE(stack_arg_reg)
> @@ -1293,6 +1299,16 @@ static int emit_kfunc_arena_args(struct jit_ctx *ctx, const struct bpf_insn *ins
>   	return 0;
>   }
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
>   /* JITs an eBPF instruction.
>    * Returns:
>    * 0  - successfully JITed an 8-byte eBPF instruction.
> @@ -2529,33 +2545,41 @@ struct arg_aux {
>   	 * arguments to be properly aligned)
>   	 */
>   	int ostack_for_args;
> +	/* where AAPCS64 puts each argument slot: an argument register below
> +	 * the eighth, an on-stack argument slot from it up
> +	 */
> +	u8 pos_of_slot[MAX_BPF_FUNC_ARG_SLOTS];
>   };
>   
>   static int calc_arg_aux(const struct btf_func_model *m,
>   			 struct arg_aux *a)
>   {
> -	int stack_slots, nregs, slots, i;
> +	int slots, i, slot, total;
> +
> +	total = bpf_jit_place_args(&arm64_arg_abi, m, a->pos_of_slot);
> +	if (total > MAX_BPF_FUNC_ARGS)
> +		return -ENOTSUPP;

This patch addressed an issue mentioned in v3:
    https://lore.kernel.org/bpf/20260911154914.2004336-1-yonghong.song@linux.dev/T/#mb01dbaae9dce27b7d2061da8d95c12561e5ecdc9
which includes both register and stack arguments.

But in v4, I missed to implement x86_64 for stack arguments. x86_64 does not have 16-byte alignment requirement for
the first 6 reigsters. I will wait pahole change
    https://lore.kernel.org/bpf/20260911040955.339939-1-yonghong.song@linux.dev/T/#t
and then do proper x86_64 stack argument alignment with additional selftests.

>   
>   	/* verifier ensures m->nr_args <= MAX_BPF_FUNC_ARGS */
> -	for (i = 0, nregs = 0; i < m->nr_args; i++) {
> +	for (i = 0, slot = 0; i < m->nr_args; i++) {
>   		slots = (m->arg_size[i] + 7) / 8;
> -		if (nregs + slots <= 8) /* passed through register ? */
> -			nregs += slots;
> -		else
> +		if (a64_arg_on_stack(a->pos_of_slot[slot])) /* passed through register ? */
>   			break;
> +		slot += slots;
>   	}
>   
>   	a->args_in_regs = i;
> -	a->regs_for_args = nregs;
> +	a->regs_for_args = slot;
>   	a->ostack_for_args = 0;
>   	a->bstack_for_args = 0;
>   
>   	/* the rest arguments are passed through stack */
> -	for (; i < m->nr_args; i++) {
> -		stack_slots = (m->arg_size[i] + 7) / 8;
> -		a->bstack_for_args += stack_slots * 8;
> -		a->ostack_for_args = a->ostack_for_args + stack_slots * 8;
> -	}
> +	for (; i < m->nr_args; i++)
> +		a->bstack_for_args += ((m->arg_size[i] + 7) / 8) * 8;
> +
> +	/* the outgoing area reaches the last slot, over any alignment hole */
> +	if (a->bstack_for_args)
> +		a->ostack_for_args = a64_arg_stack_off(a->pos_of_slot[total - 1]) + 8;
>   
>   	return 0;
>   }
> @@ -2602,7 +2626,7 @@ static void save_args(struct jit_ctx *ctx, int bargs_off, int oargs_off,
>   {
>   	u8 tmp = bpf2a64[TMP_REG_1];
>   	u8 base_lo = bpf2a64[TMP_REG_2];
> -	int i, reg, doff, soff, slots;
> +	int i, reg, slot, soff, slots;
>   
>   	/* only the low 32 bits of the base take part in the subtraction */
>   	if (arena_base)
> @@ -2611,12 +2635,13 @@ static void save_args(struct jit_ctx *ctx, int bargs_off, int oargs_off,
>   	/* store arguments to the stack for the bpf program, or restore
>   	 * arguments from stack for the original function
>   	 */
> -	for (i = 0, reg = 0; i < a->args_in_regs; i++) {
> +	for (i = 0, slot = 0; i < a->args_in_regs; i++) {
>   		bool arena_arg = arena_base && (m->arg_flags[i] & BTF_FMODEL_ARENA_ARG);
>   		bool nullable = m->arg_flags[i] & BTF_FMODEL_NULLABLE_ARG;
>   
>   		slots = (m->arg_size[i] + 7) / 8;
>   		while (slots-- > 0) {
> +			reg = a->pos_of_slot[slot++];
>   			if (for_call_origin) {
>   				emit(A64_LDR64I(reg, A64_SP, bargs_off), ctx);
>   			} else if (arena_arg) {
> @@ -2625,7 +2650,6 @@ static void save_args(struct jit_ctx *ctx, int bargs_off, int oargs_off,
>   			} else {
>   				emit(A64_STR64I(reg, A64_SP, bargs_off), ctx);
>   			}
> -			reg++;
>   			bargs_off += 8;
>   		}
>   	}
> @@ -2637,9 +2661,11 @@ static void save_args(struct jit_ctx *ctx, int bargs_off, int oargs_off,
>   	 * (FP/LR) frames, so the arguments start at FP + 32. A struct_ops
>   	 * callback is called indirectly and only the FP/LR frame is saved, so
>   	 * they start at FP + 16.
> +	 *
> +	 * The outgoing area mirrors the incoming one, hole and all; only the
> +	 * bpf program takes the arguments packed.
>   	 */
>   	soff = is_struct_ops ? 16 : 32;
> -	doff = (for_call_origin ? oargs_off : bargs_off);
>   
>   	/* save on stack arguments */
>   	for (i = a->args_in_regs; i < m->nr_args; i++) {
> @@ -2649,7 +2675,9 @@ static void save_args(struct jit_ctx *ctx, int bargs_off, int oargs_off,
>   		slots = (m->arg_size[i] + 7) / 8;
>   		/* verifier ensures arg_size <= 16, so slots equals 1 or 2 */
>   		while (slots-- > 0) {
> -			emit(A64_LDR64I(tmp, A64_FP, soff), ctx);
> +			int off = a64_arg_stack_off(a->pos_of_slot[slot++]);
> +
> +			emit(A64_LDR64I(tmp, A64_FP, soff + off), ctx);
>   			/* if there is unused space in the last slot, clear
>   			 * the garbage contained in the space.
>   			 */
> @@ -2664,19 +2692,21 @@ static void save_args(struct jit_ctx *ctx, int bargs_off, int oargs_off,
>   			 */
>   			if (arena_arg)
>   				emit_arena_arg_conv(ctx, tmp, tmp, nullable, base_lo);
> -			emit(A64_STR64I(tmp, A64_SP, doff), ctx);
> -			soff += 8;
> -			doff += 8;
> +			if (for_call_origin)
> +				emit(A64_STR64I(tmp, A64_SP, oargs_off + off), ctx);
> +			else
> +				emit(A64_STR64I(tmp, A64_SP, bargs_off), ctx);
> +			bargs_off += 8;
>   		}
>   	}
>   }
>   
> -static void restore_args(struct jit_ctx *ctx, int bargs_off, int nregs)
> +static void restore_args(struct jit_ctx *ctx, int bargs_off, const struct arg_aux *a)
>   {
> -	int reg;
> +	int slot;
>   
> -	for (reg = 0; reg < nregs; reg++) {
> -		emit(A64_LDR64I(reg, A64_SP, bargs_off), ctx);
> +	for (slot = 0; slot < a->regs_for_args; slot++) {
> +		emit(A64_LDR64I(a->pos_of_slot[slot], A64_SP, bargs_off), ctx);
>   		bargs_off += 8;
>   	}
>   }
> @@ -2948,7 +2978,7 @@ static int prepare_trampoline(struct jit_ctx *ctx, struct bpf_tramp_image *im,
>   	}
>   
>   	if (flags & BPF_TRAMP_F_RESTORE_REGS)
> -		restore_args(ctx, bargs_off, a->regs_for_args);
> +		restore_args(ctx, bargs_off, a);
>   
>   	/* restore callee saved register x19 and x20 */
>   	emit(A64_LDR64I(A64_R(19), A64_SP, regs_off), ctx);

