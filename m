Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 980E570808
	for <bpf@vger.kernel.org>; Wed,  4 Mar 2026 02:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772589864; cv=none; b=HOOHYyvu6+Nv1YQn8QBMs0+5rfkj6OIJ0B0uUemGRzkuu5IZl0SrDOkZCpnT0l2+zzOObCjm8OSUg3/1R4GdQHHDq1kg6pV4cJNNqoQdwtIfmDLsPZWNzUOS3pQDtTWi8O3pJOJQM6dwKrQwO3CWerjDaY4bUkRZLWpZKacey9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772589864; c=relaxed/simple;
	bh=QhTV/iWXDi65yO7UJFlwrHJ77vXGxJPcWuiou5imFPw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e9ROXjZGO05JGt/I8XMqDfsjIfP3z0RmP4+lQtMTe06owNAEyo1Ptw6XmE0fJC94uTlqteQ7LtvU8VkI35E6HCwRKDbgX+8Uo0k4A7phJPQy01nVaeIAeJEiGvtQC5AG+0kyHRVEGiSk0VOBqjCWZfc6qRl+4DgxxIGNMTrM4ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vIO0GibL; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vIO0GibL"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772589859;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dZNYN9APb6O7lTvOGYOzyJCu+M47K/ysceq9bq5ATMI=;
	b=vIO0GibLLoapKGgBaqp46JHz55azCvqWBBp8FpUyfN/vRMERAZzLwJes4ikCrD5thUwenZ
	dZ7wmpFKLmWvRQmu12TsNj+HQqaGyn3fPp6ymTwZWbZ3VVB7bTtU5b8UPt9X3HR9Mo3awY
	gF7QApKWx472HstbZuX6de7LLSrJ0/Q=
From: Menglong Dong <menglong.dong@linux.dev>
To: yangtiezhu@loongson.cn, Hengqi Chen <hengqi.chen@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, chenhuacai@kernel.org, vincent.mc.li@gmail.com,
 menglong8.dong@gmail.com, loongarch@lists.linux.dev, bpf@vger.kernel.org,
 Hengqi Chen <hengqi.chen@gmail.com>
Subject:
 Re: [PATCH 1/3] LoongArch: BPF: Introduce emit_store_stack_imm64() helper
Date: Wed, 04 Mar 2026 10:04:02 +0800
Message-ID: <4716621.LvFx2qVVIh@7940hx>
In-Reply-To: <20260226065952.4082859-2-hengqi.chen@gmail.com>
References:
 <20260226065952.4082859-1-hengqi.chen@gmail.com>
 <20260226065952.4082859-2-hengqi.chen@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-Migadu-Flow: FLOW_OUT

On 2026/2/26 14:59 Hengqi Chen <hengqi.chen@gmail.com> write:
> Introduce a helper to store 64-bit immediate on the trampoline stack.
> The helper will be used in the next patch. Also refactor the existing
> code to use this helper.
> 
> Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
> ---
>  arch/loongarch/net/bpf_jit.c | 24 +++++++++++++-----------
>  1 file changed, 13 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
> index 3bd89f55960d..e3deb0da6a50 100644
> --- a/arch/loongarch/net/bpf_jit.c
> +++ b/arch/loongarch/net/bpf_jit.c
> @@ -1480,6 +1480,12 @@ static void restore_args(struct jit_ctx *ctx, int nargs, int args_off)
>  	}
>  }

LGTM.

Reviewed-by: Menglong Dong <menglong8.dong@gmail.com>

>  
> +static void emit_store_stack_imm64(struct jit_ctx *ctx, int reg, int stack_off, u64 imm64)
> +{
> +	move_imm(ctx, reg, imm64, false);
> +	emit_insn(ctx, std, reg, LOONGARCH_GPR_FP, stack_off);
> +}
> +
>  static int invoke_bpf_prog(struct jit_ctx *ctx, struct bpf_tramp_link *l,
>  			   int args_off, int retval_off, int run_ctx_off, bool save_ret)
>  {
> @@ -1488,12 +1494,11 @@ static int invoke_bpf_prog(struct jit_ctx *ctx, struct bpf_tramp_link *l,
>  	struct bpf_prog *p = l->link.prog;
>  	int cookie_off = offsetof(struct bpf_tramp_run_ctx, bpf_cookie);
>  
> -	if (l->cookie) {
> -		move_imm(ctx, LOONGARCH_GPR_T1, l->cookie, false);
> -		emit_insn(ctx, std, LOONGARCH_GPR_T1, LOONGARCH_GPR_FP, -run_ctx_off + cookie_off);
> -	} else {
> +	if (l->cookie)
> +		emit_store_stack_imm64(ctx, LOONGARCH_GPR_T1,
> +				      -run_ctx_off + cookie_off, l->cookie);
> +	else
>  		emit_insn(ctx, std, LOONGARCH_GPR_ZERO, LOONGARCH_GPR_FP, -run_ctx_off + cookie_off);
> -	}
>  
>  	/* arg1: prog */
>  	move_imm(ctx, LOONGARCH_GPR_A0, (const s64)p, false);
> @@ -1726,14 +1731,11 @@ static int __arch_prepare_bpf_trampoline(struct jit_ctx *ctx, struct bpf_tramp_i
>  	emit_insn(ctx, std, LOONGARCH_GPR_S1, LOONGARCH_GPR_FP, -sreg_off);
>  
>  	/* store ip address of the traced function */
> -	if (flags & BPF_TRAMP_F_IP_ARG) {
> -		move_imm(ctx, LOONGARCH_GPR_T1, (const s64)func_addr, false);
> -		emit_insn(ctx, std, LOONGARCH_GPR_T1, LOONGARCH_GPR_FP, -ip_off);
> -	}
> +	if (flags & BPF_TRAMP_F_IP_ARG)
> +		emit_store_stack_imm64(ctx, LOONGARCH_GPR_T1, -ip_off, (u64)func_addr);
>  
>  	/* store nargs number */
> -	move_imm(ctx, LOONGARCH_GPR_T1, nargs, false);
> -	emit_insn(ctx, std, LOONGARCH_GPR_T1, LOONGARCH_GPR_FP, -nargs_off);
> +	emit_store_stack_imm64(ctx, LOONGARCH_GPR_T1, -nargs_off, nargs);
>  
>  	store_args(ctx, nargs, args_off);
>  
> -- 
> 2.43.5
> 
> 
> 




