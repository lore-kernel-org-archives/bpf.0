Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8809225A38
	for <bpf@vger.kernel.org>; Wed,  4 Mar 2026 02:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772590323; cv=none; b=lZ2347HfZzh1dn5vfDXbNIQRr3G5lYLwIjRa9tjbQyqqzwdYtE7IRU6f8iJ/oNUYQFHrTvrG69CASPZ0KmGBCYDtzPCuiWgVqTpFPAX7q3bwqJNTGqEiEWfdk799uRoKJgUpNKFgtXzkQ60Nx/wMncPG3F9FIoxz3cErSQM2QqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772590323; c=relaxed/simple;
	bh=+ln2qpL7UIDJ6Ozm5fAZfRbT3ugssJqgGKWPyLhvYKY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f/M23dLL75l/8L7ITgR+7u5PmV9vjlCtoZTP07qVK9IoAdWn0pvNu/TsPSbOIwPIWyVwKOMlb4mQwAqln2uzWlFfNkolI4f3Dy89eD/R03zL6UiSMhd/PU+1QkBgZXK6h1zkGmCjE5FkYrPIao9c1D13fg+kGZJxAAmACbRLnzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ANVPPWZy; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ANVPPWZy"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772590320;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4sBwnWUJpaeKeNj3qv0xiKMez9ZuMOGa2pu0UCc1/MI=;
	b=ANVPPWZyhkCQMV4NjlxLCaBUdjnm9JoMA4Uzfvdkekafi3bk909Jl6rP7+se9e3aas8JxM
	DOoQ+RuHbe0deMk6QOb1XmmAxMU87QOemGCOvEREJNpxENcrSoybTctDSwSoimKna2XDSJ
	csVy/LXPK+sTUufst5Sd1Sz/QBvgL0s=
From: Menglong Dong <menglong.dong@linux.dev>
To: Hengqi Chen <hengqi.chen@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, chenhuacai@kernel.org, yangtiezhu@loongson.cn,
 vincent.mc.li@gmail.com, menglong8.dong@gmail.com, loongarch@lists.linux.dev,
 bpf@vger.kernel.org, Hengqi Chen <hengqi.chen@gmail.com>
Subject: Re: [PATCH 2/3] LoongArch: BPF: Add fsession support for trampolines
Date: Wed, 04 Mar 2026 10:11:49 +0800
Message-ID: <2254625.irdbgypaU6@7940hx>
In-Reply-To: <20260226065952.4082859-3-hengqi.chen@gmail.com>
References:
 <20260226065952.4082859-1-hengqi.chen@gmail.com>
 <20260226065952.4082859-3-hengqi.chen@gmail.com>
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
> Implement BPF_TRACE_FSESSION support in LoongArch BPF JIT.
> The logic here is almost identical to what has been done in
> RISC-V JIT.
> 
> The key changes are:
>   - Allocate stack space for function meta and session cookies
>   - Introduce invoke_bpf() as a wrapper around invoke_bpf_prog()
>     that populates session cookies before each invocation
>   - Implement bpf_jit_supports_fsession() callback
> 
> Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
> ---
>  arch/loongarch/net/bpf_jit.c | 78 +++++++++++++++++++++++++++++++-----
>  1 file changed, 67 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
> index e3deb0da6a50..16da53f80266 100644
> --- a/arch/loongarch/net/bpf_jit.c
> +++ b/arch/loongarch/net/bpf_jit.c
> @@ -1549,6 +1549,31 @@ static int invoke_bpf_prog(struct jit_ctx *ctx, struct bpf_tramp_link *l,
>  	return ret;
>  }
>  

LGTM.

Reviewed-by: Menglong Dong <menglong8.dong@gmail.com>

Some nits maybe you can do when you respin the V2 if you don't mind,
see below.

> +static int invoke_bpf(struct jit_ctx *ctx, struct bpf_tramp_links *tl,
> +		      int args_off, int retval_off, int run_ctx_off,
> +		      int func_meta_off, bool save_ret, u64 func_meta,
> +		      int cookie_off)
> +{
[...]
>  
> +	if (bpf_fsession_cnt(tlinks)) {
> +		/* clear all session cookies' value */
> +		for (i = 0; i < cookie_cnt; i++)
> +			emit_insn(ctx, std, LOONGARCH_GPR_ZERO, LOONGARCH_GPR_FP, -cookie_off + 8 * i);
> +		/* clear return value to make sure fentry always get 0 */
> +		emit_insn(ctx, std, LOONGARCH_GPR_ZERO, LOONGARCH_GPR_FP, -retval_off);
> +	}
> +
>  	/* To traced function */
>  	/* Ftrace jump skips 2 NOP instructions */
>  	if (is_kernel_text((unsigned long)orig_call) ||
> @@ -1755,9 +1799,10 @@ static int __arch_prepare_bpf_trampoline(struct jit_ctx *ctx, struct bpf_tramp_i
>  			return ret;
>  	}
>  
> -	for (i = 0; i < fentry->nr_links; i++) {
> -		ret = invoke_bpf_prog(ctx, fentry->links[i], args_off, retval_off,
> -				      run_ctx_off, flags & BPF_TRAMP_F_RET_FENTRY_RET);
> +	if (fentry->nr_links) {

This checking is unnecessary, as invoke_bpf() will return directly
if !fentry->nr_links.

PS: I was told this when I implement the fsession for s390 this way :)


> +		ret = invoke_bpf(ctx, fentry, args_off, retval_off, run_ctx_off,
> +				 func_meta_off, flags & BPF_TRAMP_F_RET_FENTRY_RET,
> +				 func_meta, cookie_off);
>  		if (ret)
>  			return ret;
>  	}
> @@ -1791,8 +1836,14 @@ static int __arch_prepare_bpf_trampoline(struct jit_ctx *ctx, struct bpf_tramp_i
>  		*branches[i] = larch_insn_gen_bne(LOONGARCH_GPR_T1, LOONGARCH_GPR_ZERO, offset);
>  	}
>  
> -	for (i = 0; i < fexit->nr_links; i++) {
> -		ret = invoke_bpf_prog(ctx, fexit->links[i], args_off, retval_off, run_ctx_off, false);
> +	/* set "is_return" flag for fsession */
> +	func_meta |= (1ULL << BPF_TRAMP_IS_RETURN_SHIFT);
> +	if (bpf_fsession_cnt(tlinks))
> +		emit_store_stack_imm64(ctx, LOONGARCH_GPR_T1, -func_meta_off, func_meta);
> +
> +	if (fexit->nr_links) {

And this checking.

Thanks!
Menglong Dong

> +		ret = invoke_bpf(ctx, fexit, args_off, retval_off, run_ctx_off,
> +				 func_meta_off, false, func_meta, cookie_off);
>  		if (ret)
>  			goto out;
>  	}
> @@ -2132,3 +2183,8 @@ bool bpf_jit_supports_subprog_tailcalls(void)
>  {
>  	return true;
>  }
> +
> +bool bpf_jit_supports_fsession(void)
> +{
> +	return true;
> +}
> -- 
> 2.43.5
> 
> 
> 




