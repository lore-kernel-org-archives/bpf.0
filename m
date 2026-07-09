Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 047F91607A4
	for <bpf@vger.kernel.org>; Thu,  9 Jul 2026 03:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783566939; cv=none; b=iYF6lWTY3KL1P2YFb+hr+YxgrACZopVIERJvVpsazdov68yWd3tVzyTvmPP0bMflDnBfHL2CR1JfSGFWorRVYFaQP4w1DjQ3Nv3roq0l2hPG9x4RSCfZ4ZRgaUKyjEYYeMSLTz3M1rBJT0XR4JUtwSTVAvv1tTTKYTzhjeRt42w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783566939; c=relaxed/simple;
	bh=blo5jLqmPFG50ypyFgIaMtwALMzIa3TFho/sYVPSSd0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F4NyOGYOYs/rXOrwmz4RJz5ayxzIe56bjp3f0ewZc3kFiTFSJ/cIwnWckE5Z5rMQzklKOyWwWp0cz0GdPYoTFXiDdTbgUFH4vMo6C6hR5TfnLLZcPfqSvxAjerA7zjd1MbUSOv+K+Di17SrG0WeASndi5e2K9GvsOS0ryxo+Flk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ecEP3ruJ; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ecEP3ruJ"
Message-ID: <6143095a-7d01-4ff5-b6b1-c38335ab9dcf@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783566935;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VaDth1aWDpKghUcn3uRs0vIF77rbzyqR1E7XwOH1uvY=;
	b=ecEP3ruJnVcy7juK0n7TYkOrTBrIwp84zQsWP/NsDlJevsB1ZMQJf/REcR+Cpz14VXW7Va
	XsP/q6ViN49tiwVfPuZEMNFHI9cI+Ii7i/5LUPoBDRBwK9Mm8Q9FUC4VAEopv3WFJWBCv1
	XfSsoD+wZzPUjAn4Mxp3cfskznf92d4=
Date: Thu, 9 Jul 2026 11:15:18 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 06/12] bpf: Force JIT for programs using the
 R0:R2 register pair
Content-Language: en-US
To: Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman
 <eddyz87@gmail.com>, kernel-team@fb.com
References: <20260708200939.2153664-1-yonghong.song@linux.dev>
 <20260708201010.2158718-1-yonghong.song@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <20260708201010.2158718-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 9/7/26 04:10, Yonghong Song wrote:
> The R0:R2 return convention introduced in this series is only implemented
> in the JIT. The BPF interpreter has no notion of a second return register,
> so a program relying on the R0:R2 convention would compute wrong results
> under the interpreter. Force the JIT when bpf_prog_aux->ret_reg_pair is
> set.
> 
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> ---
>  include/linux/bpf.h   |  1 +
>  kernel/bpf/core.c     |  2 +-
>  kernel/bpf/verifier.c | 13 +++++++++++--
>  3 files changed, 13 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index c1a98fa36738..10966aba69a2 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -1780,6 +1780,7 @@ struct bpf_prog_aux {
>  	bool changes_pkt_data;
>  	bool might_sleep;
>  	bool kprobe_write_ctx;
> +	bool ret_reg_pair;
>  	struct {
>  		s32 keyring_serial;
>  		u8 keyring_type;
> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index 73dc3ee879de..819a97d25173 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
> @@ -2676,7 +2676,7 @@ struct bpf_prog *__bpf_prog_select_runtime(struct bpf_verifier_env *env, struct
>  		goto finalize;
>  
>  	if (IS_ENABLED(CONFIG_BPF_JIT_ALWAYS_ON) ||
> -	    bpf_prog_has_kfunc_call(fp))
> +	    bpf_prog_has_kfunc_call(fp) || fp->aux->ret_reg_pair)
>  		jit_needed = true;
>  
>  	if (!bpf_prog_select_interpreter(fp))
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index fcbf532159a5..ca8b2f436c20 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -453,6 +453,15 @@ bool bpf_ret_reg_pair(struct bpf_verifier_env *env, int subprog)
>  	return false;
>  }
>  
> +static bool bpf_ret_reg_pair_mark(struct bpf_verifier_env *env, int subprog)
> +{
> +	if (!bpf_ret_reg_pair(env, subprog))
> +		return false;
> +
> +	env->prog->aux->ret_reg_pair = true;


With 'jit_required' introduction [1], it has no need to introduce
'ret_reg_pair'. 'env->prog->jit_required = true;' is enough.

[1]
https://lore.kernel.org/bpf/20260708101806.18885-1-yangtiezhu@loongson.cn/

Thanks,
Leon
> +	return true;
> +}
> +
>  static const char *subprog_name(const struct bpf_verifier_env *env, int subprog)
>  {
>  	struct bpf_func_info *info;
> @@ -9877,7 +9886,7 @@ static int prepare_func_exit(struct bpf_verifier_env *env, int *insn_idx)
>  	} else {
>  		/* return to the caller whatever r0 had in the callee */
>  		caller->regs[BPF_REG_0] = *r0;
> -		if (bpf_ret_reg_pair(env, callee->subprogno)) {
> +		if (bpf_ret_reg_pair_mark(env, callee->subprogno)) {
>  			if (callee->regs[BPF_REG_2].type == PTR_TO_STACK) {
>  				verbose(env, "cannot return stack pointer to the caller\n");
>  				return -EINVAL;
> @@ -16806,7 +16815,7 @@ static int check_global_subprog_return_code(struct bpf_verifier_env *env)
>  	if (err)
>  		return err;
>  
> -	if (!bpf_ret_reg_pair(env, subprog))
> +	if (!bpf_ret_reg_pair_mark(env, subprog))
>  		return 0;
>  
>  	return check_global_ret_scalar_reg(env, BPF_REG_2);

