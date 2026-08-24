Received: from canpmsgout11.his.huawei.com (canpmsgout11.his.huawei.com [113.46.200.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6521F3E5EF1
	for <bpf@vger.kernel.org>; Mon, 24 Aug 2026 06:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787553521; cv=none; b=jZp+LMGpyXKvvRrudBtzPDghgzGjFoSfMjDyK3Jkn6iwE0HKVta32Y/inWj+HpjpQrJkSCyxL92n2s0VdXpdoYeXOJdf00mYQFw+cKw6Y3uZZf5C2dc4PjRTRV73kaQcJj6mKL5fu30XKEt4yr1JfBQy5i0pec9mN4D+56e4Rbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787553521; c=relaxed/simple;
	bh=wH66iN+aj2E1yCXxm/3+/lcK62YMjW/P4p/z8DmVxYw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=HFKTqo+nL543yTz3F+1362S5uTvnCdIp5EVPaX4UWaTxOSaVgtIMCjm9CuC33ghP3G3SPwOPFRuKnHQdctWiA29XcbCv8Ok2y3+nWtTMouU/o3wHTsD2PXWtthjg4/BHh8E4OMvrhmuTXEpkUfffTynxecqyXf1A0t+fdOYKq9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=PpnangB4; arc=none smtp.client-ip=113.46.200.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="PpnangB4"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=3oZKq3aU2D4jE/s2/NJr0AQV13AwodN5U0AAPDTi7OM=;
	b=PpnangB4AYyMA5nOsPwJVV9VX0D3pv6NZRyATggB1k0QCujLbGhicYz9THhB/BLKPV8Corc5Q
	4NBY8BPClnJahXkRhJN2S+o2DNZ1IaQCFxlZ83FQgTon7mPIkpsnaHKezGgeJYZXkDEoCTW8NIe
	hpbL9BdlBCFe8GFOuep+6eY=
Received: from mail.maildlp.com (unknown [172.19.163.15])
	by canpmsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4hT1DY6Mk2zKm5m;
	Mon, 24 Aug 2026 14:27:41 +0800 (CST)
Received: from kwepemf100007.china.huawei.com (unknown [7.202.181.221])
	by mail.maildlp.com (Postfix) with ESMTPS id D615240578;
	Mon, 24 Aug 2026 14:38:29 +0800 (CST)
Received: from [10.67.110.68] (10.67.110.68) by kwepemf100007.china.huawei.com
 (7.202.181.221) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 24 Aug
 2026 14:38:29 +0800
Message-ID: <a89f4cfd-9898-4e0f-a235-ed27199cb552@huawei.com>
Date: Mon, 24 Aug 2026 14:38:28 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v1 04/14] bpf, riscv: Convert struct_ops arena
 arguments in the trampoline
Content-Language: en-US
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, <bpf@vger.kernel.org>
CC: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, Alexei Starovoitov
	<ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann
	<daniel@iogearbox.net>, Eduard Zingerman <eddyz87@gmail.com>, Emil Tsalapatis
	<emil@etsalapatis.com>, Ihor Solodrai <ihor.solodrai@linux.dev>,
	<kkd@meta.com>, <kernel-team@meta.com>
References: <20260821233516.3426127-1-memxor@gmail.com>
 <20260821233516.3426127-5-memxor@gmail.com>
From: Pu Lehui <pulehui@huawei.com>
In-Reply-To: <20260821233516.3426127-5-memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemf100007.china.huawei.com (7.202.181.221)


On 2026/8/22 7:34, Kumar Kartikeya Dwivedi wrote:
> A struct_ops callback receives native kernel addresses, while its BPF
> program expects an arena pointer argument as a zero-extended 32-bit offset.
> Convert arguments marked with BTF_FMODEL_ARENA_ARG while the trampoline
> copies them into the BPF context.
> 
> bpf_tramp_arena_base() supplies the known base only for the single-program
> indirect trampoline. Materialize its low 32 bits once in t2, subtract it
> from each tagged argument through t1, and zero-extend the result before
> storing it. For a nullable argument, preserve the full native pointer in t1
> and branch over the variable-length subtraction sequence when it is NULL.
> 
> Walk the function model by argument while keeping a separate ABI slot
> index. This keeps the arena flags aligned with the correct native register
> or stack slot when an earlier argument occupies two slots, including the
> case where a 16-byte argument straddles a7 and the stack. Registered and
> stack-passed arena pointers use the same conversion helper.
> 
> bpf_tramp_arena_base() returns zero for tracing trampolines, so their
> emitted argument-save sequence is unchanged. An indirect trampoline cannot
> call the original function, which ensures a converted pointer never escapes
> back into a native callback. Advertise the struct_ops capability
> independently now that the reverse conversion is implemented.
> 
> Cc: Björn Töpel <bjorn@kernel.org>
> Cc: Pu Lehui <pulehui@huawei.com>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---
>   arch/riscv/net/bpf_jit_comp64.c | 93 +++++++++++++++++++++++++++++----
>   1 file changed, 82 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_comp64.c
> index c97d13a3eae4..8db992a285f6 100644
> --- a/arch/riscv/net/bpf_jit_comp64.c
> +++ b/arch/riscv/net/bpf_jit_comp64.c
> @@ -888,20 +888,75 @@ int bpf_arch_text_poke(void *ip, enum bpf_text_poke_type old_t,
>   	return ret;
>   }
>   
> -static void store_args(int nr_arg_slots, int args_off, int stack_args_off,
> +/*
> + * Convert an arena kernel address into the arena pointer form on its way
> + * into the BPF ctx, dst = (u32)(src - kern_vm_start). A nullable arg
> + * preserves NULL, tested on the full 64-bit kernel pointer. The final
> + * zero-extension makes the stored value satisfy the JIT invariant for arena
> + * pointer registers.
> + */
> +static void emit_arena_arg_conv(u8 dst, u8 src, bool nullable, u8 base,
> +				struct rv_jit_context *ctx)
> +{
> +	int branch_off = 0;
> +
> +	if (nullable) {
> +		if (dst != src)
> +			emit_mv(dst, src, ctx);
> +		branch_off = ctx->ninsns;
> +		/* Patched below once the variable-length conversion is emitted. */
> +		emit(rv_nop(), ctx);
> +		src = dst;
> +	}
> +
> +	emit_sub(dst, src, base, ctx);
> +	emit_zextw(dst, dst, ctx);
> +
> +	if (nullable && ctx->insns) {
> +		u32 insn = rv_beq(dst, RV_REG_ZERO, ctx->ninsns - branch_off);
> +
> +		*(u32 *)(ctx->insns + branch_off) = insn;
> +	}
> +}
> +
> +static void store_args(const struct btf_func_model *m, int args_off,
> +		       int stack_args_off, u64 arena_base,
>   		       struct rv_jit_context *ctx)
>   {
> -	int i;
> +	int i, j, slot = 0;
>   
> -	for (i = 0; i < nr_arg_slots; i++) {
> -		if (i < RV_MAX_REG_ARGS) {
> -			emit_sd(RV_REG_FP, -args_off, RV_REG_A0 + i, ctx);
> -		} else {
> -			emit_ld(RV_REG_T1, stack_args_off +
> -				(i - RV_MAX_REG_ARGS) * 8, RV_REG_FP, ctx);
> -			emit_sd(RV_REG_FP, -args_off, RV_REG_T1, ctx);
> +	/* Only the low 32 bits of the base take part in the subtraction. */
> +	if (arena_base)
> +		emit_imm(RV_REG_T2, (s32)(u32)arena_base, ctx);
> +
> +	/*
> +	 * Walk arguments and slots together so a 16-byte argument consumes two
> +	 * ABI locations before the flags for the following argument are used.
> +	 */
> +	for (i = 0; i < m->nr_args; i++) {
> +		bool arena_arg = arena_base && (m->arg_flags[i] & BTF_FMODEL_ARENA_ARG);
> +		bool nullable = m->arg_flags[i] & BTF_FMODEL_NULLABLE_ARG;
> +		int slots = round_up(m->arg_size[i], 8) / 8;

small nits. maybe name `arg_slots` will looks better.

> +
> +		for (j = 0; j < slots; j++, slot++) {
> +			u8 src;
> +
> +			if (slot < RV_MAX_REG_ARGS) {
> +				src = RV_REG_A0 + slot;
> +			} else {
> +				emit_ld(RV_REG_T1, stack_args_off +
> +					(slot - RV_MAX_REG_ARGS) * 8, RV_REG_FP, ctx);
> +				src = RV_REG_T1;
> +			}
> +
> +			if (arena_arg) {
> +				emit_arena_arg_conv(RV_REG_T1, src, nullable,
> +						    RV_REG_T2, ctx);
> +				src = RV_REG_T1;
> +			}
> +			emit_sd(RV_REG_FP, -args_off, src, ctx);
> +			args_off -= 8;
>   		}
> -		args_off -= 8;
>   	}
>   }
>   
> @@ -1039,9 +1094,20 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im,
>   	bool is_struct_ops = is_struct_ops_tramp(fentry);
>   	void *orig_call = func_addr;
>   	bool save_ret;
> +	u64 arena_base;
>   	u64 func_meta;
>   	u32 insn;
>   
> +	/*
> +	 * F_INDIRECT is only compatible with F_RET_FENTRY_RET. In particular,
> +	 * an indirect trampoline never calls the original function with the
> +	 * arena arguments converted into their BPF representation.
> +	 */
> +	WARN_ON_ONCE((flags & BPF_TRAMP_F_INDIRECT) &&
> +		     (flags & ~(BPF_TRAMP_F_INDIRECT | BPF_TRAMP_F_RET_FENTRY_RET)));
> +
> +	arena_base = bpf_tramp_arena_base(m, tnodes, flags);
> +
>   	/* Two types of generated trampoline stack layout:
>   	 *
>   	 * 1. trampoline called from function entry
> @@ -1189,7 +1255,7 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im,
>   	 * SP, which the trampoline keeps as FP. The fentry path pushes the
>   	 * parent frame first, so its incoming stack arguments start at FP + 16.
>   	 */
> -	store_args(nr_arg_slots, args_off, is_struct_ops ? 0 : 16, ctx);
> +	store_args(m, args_off, is_struct_ops ? 0 : 16, arena_base, ctx);
>   
>   	if (bpf_fsession_cnt(tnodes)) {
>   		/* clear all session cookies' value */
> @@ -2172,6 +2238,11 @@ bool bpf_jit_supports_arena_kfunc_args(void)
>   	return true;
>   }
>   
> +bool bpf_jit_supports_arena_struct_ops_args(void)
> +{
> +	return true;
> +}
> +
>   bool bpf_jit_supports_ptr_xchg(void)
>   {
>   	return true;
