Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E13946DFF1
	for <bpf@vger.kernel.org>; Thu, 13 Aug 2026 11:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786620996; cv=none; b=RqEuBpq7VvwNmBwVhwTHIZI6uZueqJf2Z2kpyTt7KvpZo3Na2qGGdvL9ZfekfpcPPsVJq03+Kjkb/lC+1o5C+WTSnc85Gmtk+AS29x8EALAjt3ORHosJ+6tiWJQ6K7ZOn40NlVJR0qn4v7Mv1Ursi8NIfVVCmn7Py9jpwYUSLG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786620996; c=relaxed/simple;
	bh=dkXDfpqR8JlK6AkwKWbBIH/NttvosD5d2N41Qt7gWv0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a9FHQYxIl8wErNG3hWVmkNPs9W2yUQSP+uMqCzZYW07Cqdp8eqHEopZISA4I0aUoEcCRrs/kfKkwOYhWbCevozaK/IE8UYCV5wvYvUxqC+T/s5DVGip4i0zNV1/r13xmbnn0HtwjHWtnYy3w8Nb5Z60AzZLqrLhMj8n9vHy8esg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4hLNbk1vn8zYQvmp
	for <bpf@vger.kernel.org>; Thu, 13 Aug 2026 19:36:18 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id E52784056D
	for <bpf@vger.kernel.org>; Thu, 13 Aug 2026 19:36:24 +0800 (CST)
Received: from [10.67.111.192] (unknown [10.67.111.192])
	by APP3 (Coremail) with UTF8SMTPA id _Ch0CgAXBkU3rH1qXOGmCA--.22503S2;
	Thu, 13 Aug 2026 19:36:24 +0800 (CST)
Message-ID: <200b3bfb-e2d4-485e-8c4b-655d02fa1b29@huaweicloud.com>
Date: Thu, 13 Aug 2026 19:36:23 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 3/7] bpf, arm64: JIT __arena kfunc argument
 rebasing
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
 <20260810190922.3408757-4-puranjay@kernel.org>
From: Xu Kuohai <xukuohai@huaweicloud.com>
In-Reply-To: <20260810190922.3408757-4-puranjay@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_Ch0CgAXBkU3rH1qXOGmCA--.22503S2
X-Coremail-Antispam: 1UD129KBjvJXoWxuF18urW8Wr1UWFW8Cw4kWFg_yoWrAF18pw
	4rCF13Cr4DW3W7uryfJF47Cr1Y9w4rtw4akF17KrWYkrWqqa45GF4Fg3y5Aws8Cr48Z3y3
	XF1j9w1UCa9xJ37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
> Implement arena argument rebasing for kfunc calls on arm64. x28 already
> holds kern_vm_start whenever the prog has an arena, and the newly added
> extended-register add zero-extends the 32-bit arena offset in place, so
> an unconditional argument costs a single instruction emitted right
> before the call:
> 
>    add xN, x28, wN, uxtw
> 
> A nullable argument first truncates into wN so that a zero offset leaves
> xN holding a real NULL, then tests it and jumps over the add:
> 
>    mov wN, wN
>    cbz wN, 1f
>    add xN, x28, wN, uxtw
> 1:
> 
> The rebase is native code generated after constant blinding has run on
> the BPF instruction stream, so blinding never sees it and needs no
> special handling. The emitted count depends only on the kfunc model, so
> it is identical across JIT passes.
> 
> bpf_jit_supports_arena_args() is not flipped yet; that happens when the
> struct_ops trampoline side is in place as well.
> 
> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> ---
>   arch/arm64/net/bpf_jit.h      | 11 +++++++++
>   arch/arm64/net/bpf_jit_comp.c | 42 +++++++++++++++++++++++++++++++++++
>   2 files changed, 53 insertions(+)
> 
> diff --git a/arch/arm64/net/bpf_jit.h b/arch/arm64/net/bpf_jit.h
> index d13de4222cfb7..b2fe6e6dcf447 100644
> --- a/arch/arm64/net/bpf_jit.h
> +++ b/arch/arm64/net/bpf_jit.h
> @@ -243,6 +243,17 @@
>   /* Rn - Rm; set condition flags */
>   #define A64_CMP(sf, Rn, Rm) A64_SUBS(sf, A64_ZR, Rn, Rm)
>   
> +/* Add/subtract (extended register) */
> +#define A64_ADDSUB_EREG(sf, Rd, Rn, Rm, ext, shift, type) \
> +	aarch64_insn_gen_add_sub_extended_reg(Rd, Rn, Rm, \
> +		AARCH64_INSN_EXTEND_##ext, shift, A64_VARIANT(sf), \
> +		AARCH64_INSN_ADSB_##type)
> +/* Rd = Rn + (EXT(Rm) << shift) */
> +#define A64_ADD_EXT(sf, Rd, Rn, Rm, ext, shift) \
> +	A64_ADDSUB_EREG(sf, Rd, Rn, Rm, ext, shift, ADD)
> +/* Rd = Rn + (u32)Rm */
> +#define A64_ADD_UXTW(Rd, Rn, Rm) A64_ADD_EXT(1, Rd, Rn, Rm, UXTW, 0)
> +
>   /* Data-processing (1 source) */
>   #define A64_DATA1(sf, Rd, Rn, type) aarch64_insn_gen_data1(Rd, Rn, \
>   	A64_VARIANT(sf), AARCH64_INSN_DATA1_##type)
> diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
> index 4af5a98b84e19..7aad17a51f006 100644
> --- a/arch/arm64/net/bpf_jit_comp.c
> +++ b/arch/arm64/net/bpf_jit_comp.c
> @@ -1249,6 +1249,43 @@ static void emit_stack_arg_store_imm(s32 imm, s16 bpf_off, const u8 tmp, struct
>   	}
>   }
>   
> +/*
> + * Rebase the __arena args of a kfunc call to arena kernel addresses,
> + * xN = kern_vm_start + (u32)xN, with the arena base register holding
> + * kern_vm_start. A nullable arg preserves NULL by skipping the add, tested
> + * on the truncated value as arena NULL is offset 0.
> + */
> +static int emit_kfunc_arena_args(struct jit_ctx *ctx, const struct bpf_insn *insn)
> +{
> +	const u8 arena_vm_base = bpf2a64[ARENA_VM_START];
> +	const struct btf_func_model *fm;
> +	int i;
> +
> +	fm = bpf_jit_find_kfunc_model(ctx->prog, insn);
> +	if (!fm)
> +		return -EINVAL;
> +
> +	for (i = 0; i < min_t(int, fm->nr_args, MAX_BPF_FUNC_REG_ARGS); i++) {
> +		const u8 reg = bpf2a64[BPF_REG_1 + i];
> +		u8 flags = fm->arg_flags[i];
> +
> +		if (!(flags & BTF_FMODEL_ARENA_ARG))
> +			continue;
> +		if (WARN_ON_ONCE(!ctx->arena_vm_start))
> +			return -EINVAL;
> +
> +		if (flags & BTF_FMODEL_NULLABLE_ARG) {
> +			/* 32-bit mov clears the upper 32 bits */
> +			emit(A64_MOV(0, reg, reg), ctx);
> +			/* skip the add so that NULL stays NULL */
> +			emit(A64_CBZ(0, reg, 2), ctx);
> +		}
> +		emit(A64_ADD_UXTW(reg, arena_vm_base, reg), ctx);
> +	}
> +
> +	return 0;
> +}
> +
>   /* JITs an eBPF instruction.
>    * Returns:
>    * 0  - successfully JITed an 8-byte eBPF instruction.
> @@ -1671,6 +1708,11 @@ static int build_insn(const struct bpf_verifier_env *env, const struct bpf_insn
>   					    &func_addr, &func_addr_fixed);
>   		if (ret < 0)
>   			return ret;
> +		if (insn->src_reg == BPF_PSEUDO_KFUNC_CALL) {
> +			ret = emit_kfunc_arena_args(ctx, insn);
> +			if (ret < 0)
> +				return ret;
> +		}
>   		emit_call(func_addr, ctx);
>   		/*
>   		 * Call to arch_bpf_timed_may_goto() is emitted by the

Reviewed-by: Xu Kuohai <xukuohai@huawei.com>

