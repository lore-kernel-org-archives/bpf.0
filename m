Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADA5A34E774
	for <bpf@vger.kernel.org>; Thu, 13 Aug 2026 19:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786648821; cv=none; b=X05A2pk1kNXK8mR0MbDZix5DLNO8D9tp2u0L90uPrjLEYAJM+2Ft+rKoo84kCMYGaiI6bHPFRBpmdeGWKUV7WloE+11Ekf4TxzqL+XB/vfRVr//M2oyE2WA+tPe+Xo6GGSyfvncdgbPkDXtKNPXvE92oycCrbLICiE9N1QprasM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786648821; c=relaxed/simple;
	bh=fwoxTUH9AKkz2oYg7ESgZHFMKpkDNhlwoSfhSXjFPm8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Ncf95zmhMFQuEdXfTgHCjZSuVFig3n25tuwfJRLCTOjtiizta6v7cYTwZta/XBZmrUKhkQdpipaZu0upJEFiCh25l2fd7WX+1x1/k9NGrKNz1kkGckgeZhXmuXlX+/CG3wY4Uy7b6Dr7iDoGyhOpRg966UrgNtxmchhP8GjEZOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kY7km4/B; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kY7km4/B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D78BE1F000E9;
	Thu, 13 Aug 2026 19:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786648819;
	bh=ZTZfQLtrooTnmqAv0Tju22LKf9GpR1ldKLzw7+joINY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=kY7km4/BMXNLtyd6kp4dn8vYLaY6D4T2mfLDR6/o1fKfrKGgP+tRvbx3Dt9pgWlM4
	 greoulhVGUt1Y5AJXCxJUIYBFvmW5CGrwNlht4pS3DtHj7sZXgJNymvOvLm4+uli4s
	 vrvcRvNeI+3ir/RgThmCWGHjjn5w7PqmQUazJnTPbmLE8k9Ks0EkGE1Xb2ygndt516
	 GD0ERtZrsLlOy32DNT1PPG8DhEuhR7D03EUP0RFRbXe45Ul+D8WfUUFwJXkSAp4nfh
	 crKxk/md5v+ymUc+abwShLaYL3YB0Mw+y5xe/iW0E4IYTTPHvO44ImtEJSbYTZdAI6
	 vzQxxdr43jl6A==
From: Puranjay Mohan <puranjay@kernel.org>
To: Xu Kuohai <xukuohai@huaweicloud.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Martin KaFai
 Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Kumar
 Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, Yonghong
 Song <yonghong.song@linux.dev>, Mark Rutland <mark.rutland@arm.com>, Will
 Deacon <will@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>,
 Puranjay Mohan <puranjay12@gmail.com>
Subject: Re: [PATCH bpf-next 4/7] bpf, arm64: Convert struct_ops arena
 arguments in the trampoline
In-Reply-To: <2ce67108-4b79-4635-a46e-dbac21ef46cb@huaweicloud.com>
References: <20260810190922.3408757-1-puranjay@kernel.org>
 <20260810190922.3408757-5-puranjay@kernel.org>
 <2ce67108-4b79-4635-a46e-dbac21ef46cb@huaweicloud.com>
Date: Thu, 13 Aug 2026 20:20:13 +0100
Message-ID: <m2mrupzv2q.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Xu Kuohai <xukuohai@huaweicloud.com> writes:

> On 8/11/2026 3:09 AM, Puranjay Mohan wrote:
>> Implement the struct_ops arena argument conversion on arm64. save_args()
>> receives the arena base from bpf_tramp_arena_base() and consults the
>> btf_func_model argument flags as it copies each native argument into the
>> BPF ctx, routing a marked argument through x10 with the low half of the
>> base materialized once into x11:
>> 
>>    sub w10, wsrc, w11    /* truncate and clear the upper 32 bits */
>>    str x10, [sp, #slot]
>> 
>> A nullable argument tests the full 64-bit kernel pointer first:
>> 
>>    mov x10, xsrc
>>    cbz x10, 1f
>>    sub w10, w10, w11
>> 1:
>>    str x10, [sp, #slot]
>> 
>> The 32-bit subtraction is sufficient since (u32)(kaddr - base) ==
>> (u32)kaddr - (u32)base, and it clears the upper half as the JITs require
>> of arena pointer registers. Stack-passed arguments already reload
>> through x10, so only the subtraction (and the NULL test) is inserted
>> there.
>> 
>> The register loop now walks arguments rather than registers so that the
>> per-argument flags line up with the slots a multi-slot argument occupies;
>> the sequence of stores is otherwise unchanged. bpf_tramp_arena_base()
>> returns a base only for a single-program struct_ops indirect trampoline,
>> so a tracing trampoline emits exactly what it did before and never
>> touches x11. The size probe reruns the same emission with the same model
>> and nodes, so the image size matches by construction.
>> 
>> Conversion must never reach the original function, which takes kernel
>> addresses. That holds because BPF_TRAMP_F_INDIRECT is incompatible with
>> BPF_TRAMP_F_CALL_ORIG, so pass 0 rather than the base to the call-origin
>> save_args() and assert the flag combination the same way x86 does,
>> rather than leaving the invariant to a comment.
>> 
>> With both the kfunc and struct_ops directions implemented, flip
>> bpf_jit_supports_arena_args() on for arm64 and drop the x86-64-only
>> qualifier from the kfunc documentation.
>> 
>> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
>> ---
>>   Documentation/bpf/kfuncs.rst  |  6 +--
>>   arch/arm64/net/bpf_jit_comp.c | 85 ++++++++++++++++++++++++++++-------
>>   2 files changed, 73 insertions(+), 18 deletions(-)
>> 
>> diff --git a/Documentation/bpf/kfuncs.rst b/Documentation/bpf/kfuncs.rst
>> index 1004eb0bec617..d9cc2ab1cf018 100644
>> --- a/Documentation/bpf/kfuncs.rst
>> +++ b/Documentation/bpf/kfuncs.rst
>> @@ -301,9 +301,9 @@ An example is given below::
>>           }
>>   
>>   Calling such a kfunc requires the program to use an arena map and a JIT with
>> -arena argument support (currently x86-64); verification fails otherwise. The
>> -program can pass any value without compromising the kernel. A value that does
>> -not point into the arena is a program bug.
>> +arena argument support (currently x86-64 and arm64); verification fails
>> +otherwise. The program can pass any value without compromising the kernel. A
>> +value that does not point into the arena is a program bug.
>>   
>>   The suffixes have the same meaning on the arguments of struct_ops stub
>>   functions, with the conversion running in the opposite direction. The
>> diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
>> index 7aad17a51f006..1cd327d213e34 100644
>> --- a/arch/arm64/net/bpf_jit_comp.c
>> +++ b/arch/arm64/net/bpf_jit_comp.c
>> @@ -2377,6 +2377,11 @@ bool bpf_jit_supports_stack_args(void)
>>   	return true;
>>   }
>>   
>> +bool bpf_jit_supports_arena_args(void)
>> +{
>> +	return true;
>> +}
>> +
>>   void *bpf_arch_text_copy(void *dst, void *src, size_t len)
>>   {
>>   	if (!aarch64_insn_copy(dst, src, len))
>> @@ -2550,26 +2555,58 @@ static void clear_garbage(struct jit_ctx *ctx, int reg, int effective_bytes)
>>   	}
>>   }
>>   
>> +/*
>> + * Convert an arena kernel address into the arena pointer form on its way into
>> + * the BPF ctx, dst = (u32)(src - kern_vm_start), with @base_lo holding the low
>> + * 32 bits of kern_vm_start. A nullable arg preserves NULL, tested on the full
>> + * 64-bit kernel pointer. The 32-bit subtraction both truncates and clears the
>> + * upper half, so the stored value satisfies the JIT invariant for arena
>> + * pointer registers.
>> + */
>> +static void emit_arena_arg_conv(struct jit_ctx *ctx, u8 dst, u8 src, bool nullable, u8 base_lo)
>> +{
>> +	if (nullable) {
>> +		if (dst != src)
>> +			emit(A64_MOV(1, dst, src), ctx);
>> +		/* skip the subtraction so that NULL stays NULL */
>> +		emit(A64_CBZ(1, dst, 2), ctx);
>> +		src = dst;
>> +	}
>> +	emit(A64_SUB(0, dst, src, base_lo), ctx);
>
> Maybe I'm missing something, do we need to validate whether the
> address in the src register is really inside the current bpf
> prog's arena?

The JIT can assume that it is a kernel address into the arena as it
comes from struct ops.

>
>> +}
>> +
>>   static void save_args(struct jit_ctx *ctx, int bargs_off, int oargs_off,
>>   		      const struct btf_func_model *m, const struct arg_aux *a,
>> -		      bool for_call_origin, bool is_struct_ops)
>> +		      bool for_call_origin, bool is_struct_ops, u64 arena_base)
>>   {
>> -	int i;
>> -	int reg;
>> -	int doff;
>> -	int soff;
>> -	int slots;
>>   	u8 tmp = bpf2a64[TMP_REG_1];
>> +	u8 base_lo = bpf2a64[TMP_REG_2];
>> +	int i, reg, doff, soff, slots;
>> +
>> +	/* only the low 32 bits of the base take part in the subtraction */
>> +	if (arena_base)
>> +		emit_a64_mov_i(0, base_lo, (s32)(u32)arena_base, ctx);
>>   
>>   	/* store arguments to the stack for the bpf program, or restore
>>   	 * arguments from stack for the original function
>>   	 */
>> -	for (reg = 0; reg < a->regs_for_args; reg++) {
>> -		emit(for_call_origin ?
>> -		     A64_LDR64I(reg, A64_SP, bargs_off) :
>> -		     A64_STR64I(reg, A64_SP, bargs_off),
>> -		     ctx);
>> -		bargs_off += 8;
>> +	for (i = 0, reg = 0; i < a->args_in_regs; i++) {
>> +		bool arena_arg = arena_base && (m->arg_flags[i] & BTF_FMODEL_ARENA_ARG);
>> +		bool nullable = m->arg_flags[i] & BTF_FMODEL_NULLABLE_ARG;
>> +
>> +		slots = (m->arg_size[i] + 7) / 8;
>> +		while (slots-- > 0) {
>> +			if (for_call_origin) {
>> +				emit(A64_LDR64I(reg, A64_SP, bargs_off), ctx);
>> +			} else if (arena_arg) {
>> +				emit_arena_arg_conv(ctx, tmp, reg, nullable, base_lo);
>> +				emit(A64_STR64I(tmp, A64_SP, bargs_off), ctx);
>> +			} else {
>> +				emit(A64_STR64I(reg, A64_SP, bargs_off), ctx);
>> +			}
>> +			reg++;
>> +			bargs_off += 8;
>> +		}
>>   	}
>>   
>>   	/*
>> @@ -2585,6 +2622,9 @@ static void save_args(struct jit_ctx *ctx, int bargs_off, int oargs_off,
>>   
>>   	/* save on stack arguments */
>>   	for (i = a->args_in_regs; i < m->nr_args; i++) {
>> +		bool arena_arg = arena_base && (m->arg_flags[i] & BTF_FMODEL_ARENA_ARG);
>> +		bool nullable = m->arg_flags[i] & BTF_FMODEL_NULLABLE_ARG;
>> +
>>   		slots = (m->arg_size[i] + 7) / 8;
>>   		/* verifier ensures arg_size <= 16, so slots equals 1 or 2 */
>>   		while (slots-- > 0) {
>> @@ -2594,6 +2634,8 @@ static void save_args(struct jit_ctx *ctx, int bargs_off, int oargs_off,
>>   			 */
>>   			if (slots == 0 && !for_call_origin)
>>   				clear_garbage(ctx, tmp, m->arg_size[i] % 8);
>> +			if (arena_arg)
>> +				emit_arena_arg_conv(ctx, tmp, tmp, nullable, base_lo);
>
> I think it is still worth adding a brief comment to explain
> that this conversion never happens for original function calls,
> though we have a WARN_ON_ONCE below preventing this, and the commit
> message notes it.

Added the comment in v2.
