Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECDFA1BD9C9
	for <bpf@vger.kernel.org>; Sat, 18 Jul 2026 02:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784343012; cv=none; b=JhuMUiSm/hACyuW2V2D7MzIyjAOGh115y3ay+HLDk0bHdNxia85jPkTIvXnoKYrEW80G2wF9BadKxryYGJZoKemRtHeczev+MJVuMcn/Vw0PYQewlg14fBnuBm6OLr9SntbqHNjotSDjdidiZQ7FynFehaah9AyjQKK6HrquSyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784343012; c=relaxed/simple;
	bh=u+AqsyILw7MDAQbrdjqu3jj/WLHg/MkHx6wQBxIoEbM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lm/bVusU5oZ6PYX7Bq8BL14Wxyz4Lyj9EURF0CewV5dBZIILncTKlvmZbONsalJawZZevDJiDSOwEskTMBrBJJz1ZccaqjQL0irqm8gOA/XLzcEO9+uOyRusWogayHarlSJil/Z5PolLcY+3RZSZXdNNk4LBb9Pa/h1J6PWfXtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4h2B816ZvPzYQtgy
	for <bpf@vger.kernel.org>; Sat, 18 Jul 2026 10:49:37 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 629784090C
	for <bpf@vger.kernel.org>; Sat, 18 Jul 2026 10:49:59 +0800 (CST)
Received: from [10.67.111.192] (unknown [10.67.111.192])
	by APP2 (Coremail) with UTF8SMTPA id Syh0CgCnjCjW6VpqBemEBg--.30745S2;
	Sat, 18 Jul 2026 10:49:59 +0800 (CST)
Message-ID: <e2d160c9-903b-46f6-82e0-b3fc74aaebcb@huaweicloud.com>
Date: Sat, 18 Jul 2026 10:49:58 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next] bpf, arm64: Fix stack-passed arguments for
 indirect trampolines
Content-Language: en-US
To: Puranjay Mohan <puranjay@kernel.org>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>
References: <20260717141737.4090962-1-puranjay@kernel.org>
From: Xu Kuohai <xukuohai@huaweicloud.com>
In-Reply-To: <20260717141737.4090962-1-puranjay@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:Syh0CgCnjCjW6VpqBemEBg--.30745S2
X-Coremail-Antispam: 1UD129KBjvJXoWxAr1kGFW8CFW7Wr48XF1fWFg_yoW5tr17pa
	10ywnxCFs5JrW09a4kXF4UXrySkFsYyr43CFWUJ34Fya1FgryDXFW5Ka1jk3s8Cr95Ar1x
	ZrWvy3sxCFZ7C3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvFb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6x
	kF7I0E14v26F4UJVW0owAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAq
	x4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6x
	CaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0E
	n4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I
	0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWU
	tVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcV
	CY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAF
	wI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvj
	xUF1v3UUUUU
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/

On 7/17/2026 10:17 PM, Puranjay Mohan wrote:
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
> This has gone unnoticed because no in-tree struct_ops member passes
> arguments on the stack. Pass is_struct_ops into save_args() and pick the
> offset accordingly, mirroring the x86 fix.
>

Which x86 fix? Add a reference to it?

> Fixes: 9014cf56f13d ("bpf, arm64: Support up to 12 function arguments")
> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> ---
>   arch/arm64/net/bpf_jit_comp.c | 16 ++++++++++++----
>   1 file changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
> index c6756b964c843..4fe235f7ce894 100644
> --- a/arch/arm64/net/bpf_jit_comp.c
> +++ b/arch/arm64/net/bpf_jit_comp.c
> @@ -2506,7 +2506,7 @@ static void clear_garbage(struct jit_ctx *ctx, int reg, int effective_bytes)
>   static void save_args(struct jit_ctx *ctx, int bargs_off, int oargs_off,
>   		      const struct btf_func_model *m,
>   		      const struct arg_aux *a,
> -		      bool for_call_origin)
> +		      bool for_call_origin, bool is_struct_ops)
>   {
>   	int i;
>   	int reg;
> @@ -2526,7 +2526,15 @@ static void save_args(struct jit_ctx *ctx, int bargs_off, int oargs_off,
>   		bargs_off += 8;
>   	}
>   
> -	soff = 32; /* on stack arguments start from FP + 32 */
> +	/*
> +	 * On-stack arguments start above the frame(s) pushed by the
> +	 * trampoline prologue. A traced function is entered through the
> +	 * fentry call, so both the parent (FP/x9) and the traced function
> +	 * (FP/LR) frames are saved and the arguments start at FP + 32. A
> +	 * struct_ops callback is called indirectly, so only the FP/LR frame
> +	 * is saved and the arguments start at FP + 16.
> +	 */
> +	soff = is_struct_ops ? 16 : 32;
>   	doff = (for_call_origin ? oargs_off : bargs_off);
>   
>   	/* save on stack arguments */
> @@ -2722,7 +2730,7 @@ static int prepare_trampoline(struct jit_ctx *ctx, struct bpf_tramp_image *im,
>   	store_func_meta(ctx, func_meta, func_meta_off);
>   
>   	/* save args for bpf */
> -	save_args(ctx, bargs_off, oargs_off, m, a, false);
> +	save_args(ctx, bargs_off, oargs_off, m, a, false, is_struct_ops);
>   
>   	/* save callee saved registers */
>   	emit(A64_STR64I(A64_R(19), A64_SP, regs_off), ctx);
> @@ -2771,7 +2779,7 @@ static int prepare_trampoline(struct jit_ctx *ctx, struct bpf_tramp_image *im,
>   
>   	if (flags & BPF_TRAMP_F_CALL_ORIG) {
>   		/* save args for original func */
> -		save_args(ctx, bargs_off, oargs_off, m, a, true);
> +		save_args(ctx, bargs_off, oargs_off, m, a, true, is_struct_ops);
>   		/* call original func */
>   		emit(A64_LDR64I(A64_R(10), A64_SP, retaddr_off), ctx);
>   		emit(A64_ADR(A64_LR, AARCH64_INSN_SIZE * 2), ctx);
>

LGTM. Since this issue is not covered by the existing selftests, I think
we need to add a new one.

> base-commit: 1d91ea01185656ac3ee63c5f9f6f8bde3c746b3d

