Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6731A325488
	for <bpf@vger.kernel.org>; Tue,  3 Feb 2026 06:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770099660; cv=none; b=MGnwxi8Jv6jkOiHUznmODGgvtLJwnkjFgKb01sJOBelgk1eY/WdRoaJNjcY8YokVjipBc7nn2t/dp1HShZxbwkxvRFoytbkxGtUYMw8IsnZz2WjWSIrqqCLqfEksAR3Asri+KGAjL7K/UKfceOHSBHYsGkOvgJpAqm5lYNxVz5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770099660; c=relaxed/simple;
	bh=InM2ymHSB4DRAR7LOXkdapVXvv6gG1otcfiXg0I0Tpg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H+tiC4S3IAEHM2PnF0Kv7MRsPcMryq1M0MxNV680rHHm1AxzzEcG2roxLZUk5+Ib5bDgsRwpoMdISsLmP8iCH0i9rFFuNeOud7aFrWTry6kRIaO4Z5MUt7e3gn5e8m0ObQfy81HhQtkKd5Ffd8x854MoP2/HhOPNudU5MkaTGZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=sZLk+ciN; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="sZLk+ciN"
Message-ID: <98aef740-fcbe-4d0d-905e-37a7addd5b32@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1770099645;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GHHv+JYvHw9l6JMKB0V4wzeRAy7p4nA+ckhekF/71zw=;
	b=sZLk+ciNoUcFLcraK8BqXcqwW4aXkEc5Nsa3XlhYaJk3Kap9n5rkWy1oWGDhzP89DBNpdY
	ZRm0X+sE0Y3SUMKuw/V6A7uidK20vOGHqQxXjT4JSjjb0jKk57h5IN5Pjf+PMWqPSV6IVa
	Cnhuz2s3AvHfmo4ex8kXZT+pgGRAbBU=
Date: Tue, 3 Feb 2026 14:20:34 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 2/3] bpf, riscv: add fsession support for
 trampolines
Content-Language: en-US
To: Menglong Dong <menglong8.dong@gmail.com>, ast@kernel.org
Cc: daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
 eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, bjorn@kernel.org, pulehui@huawei.com,
 puranjay@kernel.org, pjw@kernel.org, palmer@dabbelt.com,
 aou@eecs.berkeley.edu, alex@ghiti.fr, jiang.biao@linux.dev,
 bpf@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20260203055231.1088479-1-dongml2@chinatelecom.cn>
 <20260203055231.1088479-3-dongml2@chinatelecom.cn>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <20260203055231.1088479-3-dongml2@chinatelecom.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 3/2/26 13:52, Menglong Dong wrote:
> Implement BPF_TRACE_FSESSION support in the RISC-V trampoline JIT. The
> logic here is similar to what we did in x86_64.
> 
> In order to simply the logic, we factor out the function invoke_bpf() for
> fentry and fexit.
> 
> Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> ---
>  arch/riscv/net/bpf_jit_comp64.c | 74 ++++++++++++++++++++++++++++-----
>  1 file changed, 64 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_comp64.c
> index e4f45e2e7e2f..f10418ff6a9b 100644
> --- a/arch/riscv/net/bpf_jit_comp64.c
> +++ b/arch/riscv/net/bpf_jit_comp64.c
> @@ -996,6 +996,29 @@ static int invoke_bpf_prog(struct bpf_tramp_link *l, int args_off, int retval_of
>  	return ret;
>  }
>  
> +static int invoke_bpf(struct bpf_tramp_links *tl, int args_off, int retval_off,
> +		      int run_ctx_off, int func_meta_off, bool save_ret, u64 func_meta,
> +		      int cookie_off, struct rv_jit_context *ctx)
> +{
> +	int i, cur_cookie = (cookie_off - args_off) / 8;
> +
> +	for (i = 0; i < tl->nr_links; i++) {
> +		int err;
> +
> +		if (tl->links[i]->link.prog->call_session_cookie) {

NIT: we have helper bpf_prog_calls_session_cookie() to read
call_session_cookie.

Thanks,
Leon

> +			u64 meta = func_meta | ((u64)cur_cookie << BPF_TRAMP_COOKIE_INDEX_SHIFT);
> +
> +			emit_store_stack_imm64(RV_REG_T1, -func_meta_off, meta, ctx);
> +			cur_cookie--;
> +		}
> +		err = invoke_bpf_prog(tl->links[i], args_off, retval_off, run_ctx_off,
> +				      save_ret, ctx);
> +		if (err)
> +			return err;
> +	}
> +	return 0;
> +}
> +
>  static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im,
>  					 const struct btf_func_model *m,
>  					 struct bpf_tramp_links *tlinks,
> @@ -1005,13 +1028,15 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im,
>  	int i, ret, offset;
>  	int *branches_off = NULL;
>  	int stack_size = 0, nr_arg_slots = 0;
> -	int retval_off, args_off, nregs_off, ip_off, run_ctx_off, sreg_off, stk_arg_off;
> +	int retval_off, args_off, func_meta_off, ip_off, run_ctx_off, sreg_off, stk_arg_off;
> +	int cookie_off, cookie_cnt;
>  	struct bpf_tramp_links *fentry = &tlinks[BPF_TRAMP_FENTRY];
>  	struct bpf_tramp_links *fexit = &tlinks[BPF_TRAMP_FEXIT];
>  	struct bpf_tramp_links *fmod_ret = &tlinks[BPF_TRAMP_MODIFY_RETURN];
>  	bool is_struct_ops = flags & BPF_TRAMP_F_INDIRECT;
>  	void *orig_call = func_addr;
>  	bool save_ret;
> +	u64 func_meta;
>  	u32 insn;
>  
>  	/* Two types of generated trampoline stack layout:
> @@ -1042,10 +1067,14 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im,
>  	 *                  [ ...               ]
>  	 * FP - args_off    [ arg1              ]
>  	 *
> -	 * FP - nregs_off   [ regs count        ]
> +	 * FP - func_meta_off [ regs count, etc ]  always
>  	 *
>  	 * FP - ip_off      [ traced func	] BPF_TRAMP_F_IP_ARG
>  	 *
> +	 *                  [ stack cookie N    ]
> +	 *                  [ ...               ]
> +	 * FP - cookie_off  [ stack cookie 1    ]
> +	 *
>  	 * FP - run_ctx_off [ bpf_tramp_run_ctx ]
>  	 *
>  	 * FP - sreg_off    [ callee saved reg	]
> @@ -1077,14 +1106,20 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im,
>  	stack_size += nr_arg_slots * 8;
>  	args_off = stack_size;
>  
> +	/* function metadata, such as regs count */
>  	stack_size += 8;
> -	nregs_off = stack_size;
> +	func_meta_off = stack_size;
>  
>  	if (flags & BPF_TRAMP_F_IP_ARG) {
>  		stack_size += 8;
>  		ip_off = stack_size;
>  	}
>  
> +	cookie_cnt = bpf_fsession_cookie_cnt(tlinks);
> +	/* room for session cookies */
> +	stack_size += cookie_cnt * 8;
> +	cookie_off = stack_size;
> +
>  	stack_size += round_up(sizeof(struct bpf_tramp_run_ctx), 8);
>  	run_ctx_off = stack_size;
>  
> @@ -1132,10 +1167,19 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im,
>  	if (flags & BPF_TRAMP_F_IP_ARG)
>  		emit_store_stack_imm64(RV_REG_T1, -ip_off, (u64)func_addr, ctx);
>  
> -	emit_store_stack_imm64(RV_REG_T1, -nregs_off, nr_arg_slots, ctx);
> +	func_meta = nr_arg_slots;
> +	emit_store_stack_imm64(RV_REG_T1, -func_meta_off, func_meta, ctx);
>  
>  	store_args(nr_arg_slots, args_off, ctx);
>  
> +	if (bpf_fsession_cnt(tlinks)) {
> +		/* clear all session cookies' value */
> +		for (i = 0; i < cookie_cnt; i++)
> +			emit_sd(RV_REG_FP, -cookie_off + 8 * i, RV_REG_ZERO, ctx);
> +		/* clear return value to make sure fentry always get 0 */
> +		emit_sd(RV_REG_FP, -retval_off, RV_REG_ZERO, ctx);
> +	}
> +
>  	if (flags & BPF_TRAMP_F_CALL_ORIG) {
>  		emit_imm(RV_REG_A0, ctx->insns ? (const s64)im : RV_MAX_COUNT_IMM, ctx);
>  		ret = emit_call((const u64)__bpf_tramp_enter, true, ctx);
> @@ -1143,9 +1187,9 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im,
>  			return ret;
>  	}
>  
> -	for (i = 0; i < fentry->nr_links; i++) {
> -		ret = invoke_bpf_prog(fentry->links[i], args_off, retval_off, run_ctx_off,
> -				      flags & BPF_TRAMP_F_RET_FENTRY_RET, ctx);
> +	if (fentry->nr_links) {
> +		ret = invoke_bpf(fentry, args_off, retval_off, run_ctx_off, func_meta_off,
> +				 flags & BPF_TRAMP_F_RET_FENTRY_RET, func_meta, cookie_off, ctx);
>  		if (ret)
>  			return ret;
>  	}
> @@ -1192,9 +1236,14 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im,
>  		*(u32 *)(ctx->insns + branches_off[i]) = insn;
>  	}
>  
> -	for (i = 0; i < fexit->nr_links; i++) {
> -		ret = invoke_bpf_prog(fexit->links[i], args_off, retval_off,
> -				      run_ctx_off, false, ctx);
> +	/* set "is_return" flag for fsession */
> +	func_meta |= (1ULL << BPF_TRAMP_IS_RETURN_SHIFT);
> +	if (bpf_fsession_cnt(tlinks))
> +		emit_store_stack_imm64(RV_REG_T1, -func_meta_off, func_meta, ctx);
> +
> +	if (fexit->nr_links) {
> +		ret = invoke_bpf(fexit, args_off, retval_off, run_ctx_off, func_meta_off,
> +				 false, func_meta, cookie_off, ctx);
>  		if (ret)
>  			goto out;
>  	}
> @@ -2094,3 +2143,8 @@ bool bpf_jit_inlines_helper_call(s32 imm)
>  		return false;
>  	}
>  }
> +
> +bool bpf_jit_supports_fsession(void)
> +{
> +	return true;
> +}

