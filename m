Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF0DE3914E5
	for <bpf@vger.kernel.org>; Fri, 28 Aug 2026 04:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787891611; cv=none; b=G4Zeyf7+G+/IZ6ib2as49MNd5Iw/MsZiCPyGHFlbdDVIxGbGDefxBao9yQufyBh9uPE64mTcyjnL/Uy5czJJ+jnlRmlWMy2k468aPVBZkmpdnulnuAYGJqqFSXSKi8S0510BOi3r8Z7gQPNGa3RFCLoqHKJDxenihSBufpks3fE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787891611; c=relaxed/simple;
	bh=h7NHupRRHcBXgS1u09CDaObGl1zCdCGlz0WmHK2DQro=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=Y1d5DZgCL6v6YAJNWxTSe83cCR1i9QXWWs4597HDXDpiNCapnEqbkjGl04ZgT9zMqQYw3z5lw+xkBsxtqqceWju3u/LR7WUx4/6jY9GkziPDkhtFqKUhov7+w9h7MFdWenn77Uw/7VLkpoHZ1oXCihfhMI75fDuCi6CDgoZ/DLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [123.138.236.242])
	by gateway (Coremail) with SMTP id _____8BxbdKWD5FqgvoFAA--.17108S3;
	Fri, 28 Aug 2026 12:33:26 +0800 (CST)
Received: from [10.130.40.83] (unknown [123.138.236.242])
	by front1 (Coremail) with SMTP id qMiowJCx9cyUD5FqDRoVAA--.14463S2;
	Fri, 28 Aug 2026 12:33:25 +0800 (CST)
Subject: Re: [PATCH bpf-next v1 07/14] bpf, loongarch: Fix stack arguments for
 indirect trampolines
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc: Huacai Chen <chenhuacai@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Eduard Zingerman <eddyz87@gmail.com>, Emil Tsalapatis
 <emil@etsalapatis.com>, Ihor Solodrai <ihor.solodrai@linux.dev>,
 kkd@meta.com, kernel-team@meta.com, loongarch@lists.linux.dev,
 Hengqi Chen <hengqi.chen@gmail.com>
References: <20260821233516.3426127-1-memxor@gmail.com>
 <20260821233516.3426127-8-memxor@gmail.com>
From: Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <a5d4c26c-6735-8af1-1d3f-fe7f1898b285@loongson.cn>
Date: Fri, 28 Aug 2026 12:33:24 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260821233516.3426127-8-memxor@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJCx9cyUD5FqDRoVAA--.14463S2
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoWxXw15Jw43uFy3XFW7KFWDWrX_yoWrWw4rpF
	4v9Fs3CF48JrW8K3Z7uayUuFySvFs3Z3y3Gr4DJFyrCas8ury8GF1rK3ZI9F98GrnYvw1x
	ZrsYvws0vFWUA3gCm3ZEXasCq-sJn29KB7ZKAUJUUUU3529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUPIb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4UJVWxJr1ln4kS14v26r126r1DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12
	xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1q
	6rW5McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr4
	1lc7I2V7IY0VAS07AlzVAYIcxG8wCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxG
	rwCFx2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km07C267AKxVWUAVWUtwC20s026c02F40E14
	v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkG
	c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4U
	MIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jr9NsUUU
	UU=

Cc: loongarch@lists.linux.dev
Cc: Hengqi Chen <hengqi.chen@gmail.com>

On 2026/8/22 上午7:35, Kumar Kartikeya Dwivedi wrote:
> LoongArch passes arguments beyond a0-a7 at the caller stack pointer. The
> trampoline store_args() helper always reads those arguments at FP + 16,
> which is correct for an fentry trampoline: its prologue leaves FP 16 bytes
> below the stack pointer at trampoline entry after accounting for the saved
> parent and traced-function frames.
> 
> A struct_ops indirect trampoline is entered through a function pointer and
> only saves its own RA and FP before setting FP to the entry stack pointer.
> Its stack arguments therefore start at FP, not FP + 16. As a result, every
> stack-passed struct_ops argument is currently read two slots late.
> 
> Select the source offset based on whether the trampoline is indirect. This
> also prepares the stack-passed arena argument path to consume the actual
> pointer slot.
> 
> Fixes: c9ebe2016de9 ("LoongArch: BPF: Support up to 12 function arguments for trampoline")
> Cc: Tiezhu Yang <yangtiezhu@loongson.cn>
> Cc: Huacai Chen <chenhuacai@kernel.org>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---
>   arch/loongarch/net/bpf_jit.c | 9 +++++----
>   1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
> index 29c281bef28e..d193293a0fd2 100644
> --- a/arch/loongarch/net/bpf_jit.c
> +++ b/arch/loongarch/net/bpf_jit.c
> @@ -1662,17 +1662,18 @@ int bpf_arch_text_invalidate(void *dst, size_t len)
>   	return ret;
>   }
>   
> -static void store_args(struct jit_ctx *ctx, int nr_arg_slots, int args_off)
> +static void store_args(struct jit_ctx *ctx, int nr_arg_slots, int args_off, bool is_struct_ops)
>   {
> +	int stack_args_off = is_struct_ops ? 0 : 16;
>   	int i;
>   
>   	for (i = 0; i < nr_arg_slots; i++) {
>   		if (i < LOONGARCH_MAX_REG_ARGS)
>   			emit_insn(ctx, std, LOONGARCH_GPR_A0 + i, LOONGARCH_GPR_FP, -args_off);
>   		else {
> -			/* Skip slots for T0 and FP of traced function */
> +			/* Skip the saved T0 and FP slots for a traced function. */
>   			emit_insn(ctx, ldd, LOONGARCH_GPR_T1, LOONGARCH_GPR_FP,
> -				  16 + (i - LOONGARCH_MAX_REG_ARGS) * 8);
> +				  stack_args_off + (i - LOONGARCH_MAX_REG_ARGS) * 8);
>   			emit_insn(ctx, std, LOONGARCH_GPR_T1, LOONGARCH_GPR_FP, -args_off);
>   		}
>   		args_off -= 8;
> @@ -1995,7 +1996,7 @@ static int __arch_prepare_bpf_trampoline(struct jit_ctx *ctx, struct bpf_tramp_i
>   	func_meta = nr_arg_slots;
>   	emit_store_stack_imm64(ctx, LOONGARCH_GPR_T1, -func_meta_off, func_meta);
>   
> -	store_args(ctx, nr_arg_slots, args_off);
> +	store_args(ctx, nr_arg_slots, args_off, is_struct_ops);
>   
>   	if (bpf_fsession_cnt(tnodes)) {
>   		/* clear all session cookies' value */

According to the suggestion from bot+bpf-ci, adding the following
comment before "int stack_args_off = is_struct_ops ? 0 : 16;" and
removing the pre-existing comment inside the else branch would be
much better:

/*
  * Regular fentry trampolines need to skip the 16-byte saved T0 and FP
  * slots of the traced function. Indirect struct_ops trampolines place
  * incoming stack arguments directly at FP.
  */

This clarifies both frame layouts without causing any ambiguity
inside the loop.

Other than that, the code looks good to me:

Acked-by: Tiezhu Yang <yangtiezhu@loongson.cn>

By the way, I wrote a selftest for this patch:

   selftests/bpf: Add test for indirect struct_ops trampoline
 
https://lore.kernel.org/bpf/20260828042715.16546-1-yangtiezhu@loongson.cn/

Without this patch:

   $ sudo ./test_progs -t struct_ops_trampoline
   ...
   run_struct_ops_trampoline:FAIL:check_stack_passed_arg9 unexpected 
check_stack_passed_arg9: actual 69570864 != expected 9999
   #471     struct_ops_trampoline:FAIL
   Summary: 0/0 PASSED, 0 SKIPPED, 1 FAILED

With this patch:

   $ sudo ./test_progs -t struct_ops_trampoline
   #471     struct_ops_trampoline:OK
   Summary: 1/0 PASSED, 0 SKIPPED, 0 FAILED

Tested-by: Tiezhu Yang <yangtiezhu@loongson.cn>

Thanks,
Tiezhu

