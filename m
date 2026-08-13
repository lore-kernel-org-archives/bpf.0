Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC1B93955E8
	for <bpf@vger.kernel.org>; Thu, 13 Aug 2026 09:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786611802; cv=none; b=TPmGs+Avy2HJedSo9fPoP101j5QoCqs76/IyEzsjgDGBT/yTkMlGuDBKE/WsDqDKJcn+FOIIu18Q2ifqoyZiVy8x2zOQCmg985pXBq+UVNitwOIEmuEBg29V1jikA7QQ1ZnsDy1WLsAXs3GE6lgv3lchPGzB8SUbi2bG/zAA2Ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786611802; c=relaxed/simple;
	bh=fXGADN5+wp60htehVaqtl/B/L0WWIV/HGWGUsUhushI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YHPLpTonGuc+s7T8jOzPIo2ejPXbmXPkG/kSy5O44T7UGN7Sy+RiptNpq+3wOO03kdXJNySECcxjNzzwEzwJiCjyv6wOj5KQCYU48GyPqq8TTaJXwQqMGz7tsB3SJXbt3Ev7ExwJMsM4miQn7CuT9bjo4FQtBR5IqCu2r6Ln02w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4hLKBb74GBzKHN8C
	for <bpf@vger.kernel.org>; Thu, 13 Aug 2026 17:02:47 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 1111640953
	for <bpf@vger.kernel.org>; Thu, 13 Aug 2026 17:03:07 +0800 (CST)
Received: from [10.67.111.192] (unknown [10.67.111.192])
	by APP2 (Coremail) with UTF8SMTPA id Syh0CgBXw4pJiH1qugamCA--.35513S2;
	Thu, 13 Aug 2026 17:03:06 +0800 (CST)
Message-ID: <bba3c4f8-a7b3-40ae-a7bd-88594a7252bb@huaweicloud.com>
Date: Thu, 13 Aug 2026 17:03:05 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 1/7] bpf, arm64: Fix stack-passed arguments for
 indirect trampolines
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
 <20260810190922.3408757-2-puranjay@kernel.org>
From: Xu Kuohai <xukuohai@huaweicloud.com>
In-Reply-To: <20260810190922.3408757-2-puranjay@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:Syh0CgBXw4pJiH1qugamCA--.35513S2
X-Coremail-Antispam: 1UD129KBjvJXoWxAr1kGFW8CFW7XF4UCw1UAwb_yoW5KrW3pa
	10ywnxCFs5JrW09a4kXr4UuFyFkFZYyr43CFWUJ34Sya1FgryDXFW5KayYk3s8Cr95Zr1x
	Zr4jyr9IkFZ7C3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8
	ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1
	7KsUUUUUU==
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/

On 8/11/2026 3:09 AM, Puranjay Mohan wrote:
> save_args() reads stack-passed arguments relative to FP assuming the
> trampoline is entered through the fentry call from a traced function, in
> which case both the parent frame (FP/x9) and the traced function frame
> (FP/LR) are saved before FP is set, so the arguments start at FP + 32.
> 
> An indirect trampoline for a struct_ops callback is entered through a
> function pointer (blr), so only the FP/LR frame is pushed and the
> arguments start at FP + 16, not FP + 32. Every stack-passed argument of
> a struct_ops callback with more than eight argument slots is read two
> slots off.
> 
> This went unnoticed because no struct_ops member passed arguments on the
> stack until bpf_testmod_ops3::test_arena_stack, added by
> commit 2d4de9a493a0 ("selftests/bpf: Test stack-passed struct_ops arena arguments").
> That member covers this on arm64 once the JIT gains arena argument
> support later in this series. Pass is_struct_ops into save_args() and
> pick the offset accordingly, mirroring the x86 fix.
> 
> Fixes: 9014cf56f13d ("bpf, arm64: Support up to 12 function arguments")
> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> ---
>   arch/arm64/net/bpf_jit_comp.c | 19 +++++++++++++------
>   1 file changed, 13 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
> index d14d297ebb967..4af5a98b84e19 100644
> --- a/arch/arm64/net/bpf_jit_comp.c
> +++ b/arch/arm64/net/bpf_jit_comp.c
> @@ -2509,9 +2509,8 @@ static void clear_garbage(struct jit_ctx *ctx, int reg, int effective_bytes)
>   }
>   
>   static void save_args(struct jit_ctx *ctx, int bargs_off, int oargs_off,
> -		      const struct btf_func_model *m,
> -		      const struct arg_aux *a,
> -		      bool for_call_origin)
> +		      const struct btf_func_model *m, const struct arg_aux *a,
> +		      bool for_call_origin, bool is_struct_ops)
>   {
>   	int i;
>   	int reg;
> @@ -2531,7 +2530,15 @@ static void save_args(struct jit_ctx *ctx, int bargs_off, int oargs_off,
>   		bargs_off += 8;
>   	}
>   
> -	soff = 32; /* on stack arguments start from FP + 32 */
> +	/*
> +	 * On-stack arguments start above the frame(s) pushed by the trampoline
> +	 * prologue. Entered through the fentry call from a traced function, the
> +	 * prologue saves both the parent (FP/x9) and the traced function
> +	 * (FP/LR) frames, so the arguments start at FP + 32. A struct_ops
> +	 * callback is called indirectly and only the FP/LR frame is saved, so
> +	 * they start at FP + 16.
> +	 */
> +	soff = is_struct_ops ? 16 : 32;
>   	doff = (for_call_origin ? oargs_off : bargs_off);
>   
>   	/* save on stack arguments */
> @@ -2721,7 +2728,7 @@ static int prepare_trampoline(struct jit_ctx *ctx, struct bpf_tramp_image *im,
>   	store_func_meta(ctx, func_meta, func_meta_off);
>   
>   	/* save args for bpf */
> -	save_args(ctx, bargs_off, oargs_off, m, a, false);
> +	save_args(ctx, bargs_off, oargs_off, m, a, false, is_struct_ops);
>   
>   	/* save callee saved registers */
>   	emit(A64_STR64I(A64_R(19), A64_SP, regs_off), ctx);
> @@ -2770,7 +2777,7 @@ static int prepare_trampoline(struct jit_ctx *ctx, struct bpf_tramp_image *im,
>   
>   	if (flags & BPF_TRAMP_F_CALL_ORIG) {
>   		/* save args for original func */
> -		save_args(ctx, bargs_off, oargs_off, m, a, true);
> +		save_args(ctx, bargs_off, oargs_off, m, a, true, is_struct_ops);
>   		/* call original func */
>   		emit(A64_LDR64I(A64_R(10), A64_SP, retaddr_off), ctx);
>   		emit(A64_ADR(A64_LR, AARCH64_INSN_SIZE * 2), ctx);

Reviewed-by: Xu Kuohai <xukuohai@huawei.com>

