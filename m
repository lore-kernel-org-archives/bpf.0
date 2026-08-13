Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22AAA417BD2
	for <bpf@vger.kernel.org>; Thu, 13 Aug 2026 11:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786621899; cv=none; b=kLbw9FvD31sta3vFNGgFGVxlDRv0m3QT4ADTDZMQYG3BhlSmsslrkczFn52WFEJXumjFufxWQMCHcBa+01slWE+4nyPJAfVAV63osUohudDampiSzmIZS0ZZI/pDVIvtelT6XXCyA5+fhB56r8CGH66BHz/sra5EsJaP1zuKC54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786621899; c=relaxed/simple;
	bh=ooHwDIjXbYfHHI4BK7tfNyuMEQ+ozSpOpDLjro59lvk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Dy/Pu57CvD+6KnNImbRjdTUE/YxZd088NbjgENvzgG7rUda7cN8eFo7H6ww6I5b5ZKebvIuvKLHnWdvmpDpUZcP9+3huNu0sY/pKy88PLdDNKr4T6iI2+OoVeHpbdM0kx+7RfMSWRE2pcs+SyX4zf8T6tj7E1gouA2NkbyKvfCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4hLNwt49R5zKHN9J
	for <bpf@vger.kernel.org>; Thu, 13 Aug 2026 19:51:10 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id D0CA74058F
	for <bpf@vger.kernel.org>; Thu, 13 Aug 2026 19:51:29 +0800 (CST)
Received: from [10.67.111.192] (unknown [10.67.111.192])
	by APP2 (Coremail) with UTF8SMTPA id Syh0CgB34YjAr31q5oe0CA--.12728S2;
	Thu, 13 Aug 2026 19:51:29 +0800 (CST)
Message-ID: <2ce67108-4b79-4635-a46e-dbac21ef46cb@huaweicloud.com>
Date: Thu, 13 Aug 2026 19:51:28 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 4/7] bpf, arm64: Convert struct_ops arena
 arguments in the trampoline
Content-Language: en-US
To: Puranjay Mohan <puranjay@kernel.org>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 Mark Rutland <mark.rutland@arm.com>, Will Deacon <will@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>
References: <20260810190922.3408757-1-puranjay@kernel.org>
 <20260810190922.3408757-5-puranjay@kernel.org>
From: Xu Kuohai <xukuohai@huaweicloud.com>
In-Reply-To: <20260810190922.3408757-5-puranjay@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:Syh0CgB34YjAr31q5oe0CA--.12728S2
X-Coremail-Antispam: 1UD129KBjvJXoW3Xr4xuw4UGw4kJr1xKrW8Crg_yoWfArWUpF
	4FkayfCFWkJr4xCF1kXr47AF4Ykan3trW3ur1UJ3yrAFn0gry5KFWrKa1Ykas5Cr95ua1Y
	vr4qvwn0kF18ArJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AF
	wI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUF1
	v3UUUUU
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/

On 8/11/2026 3:09 AM, Puranjay Mohan wrote:
> Implement the struct_ops arena argument conversion on arm64. save_args()
> receives the arena base from bpf_tramp_arena_base() and consults the
> btf_func_model argument flags as it copies each native argument into the
> BPF ctx, routing a marked argument through x10 with the low half of the
> base materialized once into x11:
> 
>    sub w10, wsrc, w11    /* truncate and clear the upper 32 bits */
>    str x10, [sp, #slot]
> 
> A nullable argument tests the full 64-bit kernel pointer first:
> 
>    mov x10, xsrc
>    cbz x10, 1f
>    sub w10, w10, w11
> 1:
>    str x10, [sp, #slot]
> 
> The 32-bit subtraction is sufficient since (u32)(kaddr - base) ==
> (u32)kaddr - (u32)base, and it clears the upper half as the JITs require
> of arena pointer registers. Stack-passed arguments already reload
> through x10, so only the subtraction (and the NULL test) is inserted
> there.
> 
> The register loop now walks arguments rather than registers so that the
> per-argument flags line up with the slots a multi-slot argument occupies;
> the sequence of stores is otherwise unchanged. bpf_tramp_arena_base()
> returns a base only for a single-program struct_ops indirect trampoline,
> so a tracing trampoline emits exactly what it did before and never
> touches x11. The size probe reruns the same emission with the same model
> and nodes, so the image size matches by construction.
> 
> Conversion must never reach the original function, which takes kernel
> addresses. That holds because BPF_TRAMP_F_INDIRECT is incompatible with
> BPF_TRAMP_F_CALL_ORIG, so pass 0 rather than the base to the call-origin
> save_args() and assert the flag combination the same way x86 does,
> rather than leaving the invariant to a comment.
> 
> With both the kfunc and struct_ops directions implemented, flip
> bpf_jit_supports_arena_args() on for arm64 and drop the x86-64-only
> qualifier from the kfunc documentation.
> 
> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> ---
>   Documentation/bpf/kfuncs.rst  |  6 +--
>   arch/arm64/net/bpf_jit_comp.c | 85 ++++++++++++++++++++++++++++-------
>   2 files changed, 73 insertions(+), 18 deletions(-)
> 
> diff --git a/Documentation/bpf/kfuncs.rst b/Documentation/bpf/kfuncs.rst
> index 1004eb0bec617..d9cc2ab1cf018 100644
> --- a/Documentation/bpf/kfuncs.rst
> +++ b/Documentation/bpf/kfuncs.rst
> @@ -301,9 +301,9 @@ An example is given below::
>           }
>   
>   Calling such a kfunc requires the program to use an arena map and a JIT with
> -arena argument support (currently x86-64); verification fails otherwise. The
> -program can pass any value without compromising the kernel. A value that does
> -not point into the arena is a program bug.
> +arena argument support (currently x86-64 and arm64); verification fails
> +otherwise. The program can pass any value without compromising the kernel. A
> +value that does not point into the arena is a program bug.
>   
>   The suffixes have the same meaning on the arguments of struct_ops stub
>   functions, with the conversion running in the opposite direction. The
> diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
> index 7aad17a51f006..1cd327d213e34 100644
> --- a/arch/arm64/net/bpf_jit_comp.c
> +++ b/arch/arm64/net/bpf_jit_comp.c
> @@ -2377,6 +2377,11 @@ bool bpf_jit_supports_stack_args(void)
>   	return true;
>   }
>   
> +bool bpf_jit_supports_arena_args(void)
> +{
> +	return true;
> +}
> +
>   void *bpf_arch_text_copy(void *dst, void *src, size_t len)
>   {
>   	if (!aarch64_insn_copy(dst, src, len))
> @@ -2550,26 +2555,58 @@ static void clear_garbage(struct jit_ctx *ctx, int reg, int effective_bytes)
>   	}
>   }
>   
> +/*
> + * Convert an arena kernel address into the arena pointer form on its way into
> + * the BPF ctx, dst = (u32)(src - kern_vm_start), with @base_lo holding the low
> + * 32 bits of kern_vm_start. A nullable arg preserves NULL, tested on the full
> + * 64-bit kernel pointer. The 32-bit subtraction both truncates and clears the
> + * upper half, so the stored value satisfies the JIT invariant for arena
> + * pointer registers.
> + */
> +static void emit_arena_arg_conv(struct jit_ctx *ctx, u8 dst, u8 src, bool nullable, u8 base_lo)
> +{
> +	if (nullable) {
> +		if (dst != src)
> +			emit(A64_MOV(1, dst, src), ctx);
> +		/* skip the subtraction so that NULL stays NULL */
> +		emit(A64_CBZ(1, dst, 2), ctx);
> +		src = dst;
> +	}
> +	emit(A64_SUB(0, dst, src, base_lo), ctx);

Maybe I'm missing something, do we need to validate whether the
address in the src register is really inside the current bpf
prog's arena?

> +}
> +
>   static void save_args(struct jit_ctx *ctx, int bargs_off, int oargs_off,
>   		      const struct btf_func_model *m, const struct arg_aux *a,
> -		      bool for_call_origin, bool is_struct_ops)
> +		      bool for_call_origin, bool is_struct_ops, u64 arena_base)
>   {
> -	int i;
> -	int reg;
> -	int doff;
> -	int soff;
> -	int slots;
>   	u8 tmp = bpf2a64[TMP_REG_1];
> +	u8 base_lo = bpf2a64[TMP_REG_2];
> +	int i, reg, doff, soff, slots;
> +
> +	/* only the low 32 bits of the base take part in the subtraction */
> +	if (arena_base)
> +		emit_a64_mov_i(0, base_lo, (s32)(u32)arena_base, ctx);
>   
>   	/* store arguments to the stack for the bpf program, or restore
>   	 * arguments from stack for the original function
>   	 */
> -	for (reg = 0; reg < a->regs_for_args; reg++) {
> -		emit(for_call_origin ?
> -		     A64_LDR64I(reg, A64_SP, bargs_off) :
> -		     A64_STR64I(reg, A64_SP, bargs_off),
> -		     ctx);
> -		bargs_off += 8;
> +	for (i = 0, reg = 0; i < a->args_in_regs; i++) {
> +		bool arena_arg = arena_base && (m->arg_flags[i] & BTF_FMODEL_ARENA_ARG);
> +		bool nullable = m->arg_flags[i] & BTF_FMODEL_NULLABLE_ARG;
> +
> +		slots = (m->arg_size[i] + 7) / 8;
> +		while (slots-- > 0) {
> +			if (for_call_origin) {
> +				emit(A64_LDR64I(reg, A64_SP, bargs_off), ctx);
> +			} else if (arena_arg) {
> +				emit_arena_arg_conv(ctx, tmp, reg, nullable, base_lo);
> +				emit(A64_STR64I(tmp, A64_SP, bargs_off), ctx);
> +			} else {
> +				emit(A64_STR64I(reg, A64_SP, bargs_off), ctx);
> +			}
> +			reg++;
> +			bargs_off += 8;
> +		}
>   	}
>   
>   	/*
> @@ -2585,6 +2622,9 @@ static void save_args(struct jit_ctx *ctx, int bargs_off, int oargs_off,
>   
>   	/* save on stack arguments */
>   	for (i = a->args_in_regs; i < m->nr_args; i++) {
> +		bool arena_arg = arena_base && (m->arg_flags[i] & BTF_FMODEL_ARENA_ARG);
> +		bool nullable = m->arg_flags[i] & BTF_FMODEL_NULLABLE_ARG;
> +
>   		slots = (m->arg_size[i] + 7) / 8;
>   		/* verifier ensures arg_size <= 16, so slots equals 1 or 2 */
>   		while (slots-- > 0) {
> @@ -2594,6 +2634,8 @@ static void save_args(struct jit_ctx *ctx, int bargs_off, int oargs_off,
>   			 */
>   			if (slots == 0 && !for_call_origin)
>   				clear_garbage(ctx, tmp, m->arg_size[i] % 8);
> +			if (arena_arg)
> +				emit_arena_arg_conv(ctx, tmp, tmp, nullable, base_lo);

I think it is still worth adding a brief comment to explain
that this conversion never happens for original function calls,
though we have a WARN_ON_ONCE below preventing this, and the commit
message notes it.

>   			emit(A64_STR64I(tmp, A64_SP, doff), ctx);
>   			soff += 8;
>   			doff += 8;
> @@ -2653,8 +2695,21 @@ static int prepare_trampoline(struct jit_ctx *ctx, struct bpf_tramp_image *im,
>   	bool is_struct_ops = is_struct_ops_tramp(fentry);
>   	int cookie_off, cookie_cnt, cookie_bargs_off;
>   	int fsession_cnt = bpf_fsession_cnt(tnodes);
> +	u64 arena_base;
>   	u64 func_meta;
>   
> +	/*
> +	 * F_INDIRECT is only compatible with F_RET_FENTRY_RET, it is explicitly
> +	 * incompatible with F_CALL_ORIG | F_SKIP_FRAME | F_IP_ARG because
> +	 * @func_addr. Arena conversion relies on this: bpf_tramp_arena_base()
> +	 * only returns a base for the indirect trampoline, which therefore
> +	 * never calls the original function with converted arguments.
> +	 */
> +	WARN_ON_ONCE((flags & BPF_TRAMP_F_INDIRECT) &&
> +		     (flags & ~(BPF_TRAMP_F_INDIRECT | BPF_TRAMP_F_RET_FENTRY_RET)));
> +
> +	arena_base = bpf_tramp_arena_base(m, tnodes, flags);
> +
>   	/* trampoline stack layout:
>   	 *                    [ parent ip         ]
>   	 *                    [ FP                ]
> @@ -2770,7 +2825,7 @@ static int prepare_trampoline(struct jit_ctx *ctx, struct bpf_tramp_image *im,
>   	store_func_meta(ctx, func_meta, func_meta_off);
>   
>   	/* save args for bpf */
> -	save_args(ctx, bargs_off, oargs_off, m, a, false, is_struct_ops);
> +	save_args(ctx, bargs_off, oargs_off, m, a, false, is_struct_ops, arena_base);
>   
>   	/* save callee saved registers */
>   	emit(A64_STR64I(A64_R(19), A64_SP, regs_off), ctx);
> @@ -2818,8 +2873,8 @@ static int prepare_trampoline(struct jit_ctx *ctx, struct bpf_tramp_image *im,
>   	}
>   
>   	if (flags & BPF_TRAMP_F_CALL_ORIG) {
> -		/* save args for original func */
> -		save_args(ctx, bargs_off, oargs_off, m, a, true, is_struct_ops);
> +		/* the original func takes kernel addresses, never converted ones */
> +		save_args(ctx, bargs_off, oargs_off, m, a, true, is_struct_ops, 0);
>   		/* call original func */
>   		emit(A64_LDR64I(A64_R(10), A64_SP, retaddr_off), ctx);
>   		emit(A64_ADR(A64_LR, AARCH64_INSN_SIZE * 2), ctx);

