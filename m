Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1714B225403
	for <bpf@vger.kernel.org>; Mon,  3 Aug 2026 04:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785731656; cv=none; b=UY6KCo5qKN+mJs7k1tXQkuISinQ/11tP3IUnCzKhNbygPAv0B0fmM8eJw3fPudLD3MV41E7rWx9Z6kY4Gxoa2DnC2xRf2v8rzwCfnRTkflSOzd8XD4YvyVCfbFTqE81EZpRnyhEoaKQ1Olbwbta0NCGJrnHBwpIQmev+kyBByy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785731656; c=relaxed/simple;
	bh=XoAjqIRhODsNbQNzRo4Q8Sr3RJSX6bXyM/3wRdSNcag=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=EebEVoO1K8cEuRVRVJbxudJeneZPfjhKJ0tPm4sxJO0W7hJXPIAyK8SC3RSXlm7nyE1NuMy6PL38jp80Q5vZkAkBUNjReCJRRTNFQmaQJCN15OKSSuYOcz+HWAop2d/qNnkW2Xr784MjQWQQLXAz8xHxIFBsDnty4VTITZWm+Jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U6YyGHzm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U6YyGHzm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDEE31F000E9;
	Mon,  3 Aug 2026 04:34:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785731654;
	bh=ct8ttThflfOsuK/Syp9efFyx44H5Li+Mo/1ee6JsRBM=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=U6YyGHzmyB2lU3dKoSyyEZViLPTu6n9Ce+keooKBpTIsE9UugYBEe/yzqjIbdl2ki
	 ADTGZ+hjBdmM4DP/UIj1OT2RCLugcCAEneyeqzmq8cihY0qrlcccBEN1UPs9NQOOMk
	 EMSsIp4LOTIGDICNpehF7E20zt4BRRnCyqG+adV39cXHi1AKgl8A5AdcCZ+HVkdQnO
	 ceJakkj5kXlOC6KGHzq8ucggOOajLoSxy4yXOfbyX+PztBFetWY1yaXTUwL+6x+wx2
	 uDdAxi9ShUZ55i64BbvSYpoaY610QK3nKeuyzMofXZpG9WQV6ftP/FPXuIPAHn3tDU
	 uMAJhP0uBqaCQ==
Content-Type: multipart/mixed; boundary="===============5212603704248020982=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <58d426a40ea20e2a5aa35f7ff2870e657e3578ac1366138ff923c7d31ad5115a@mail.kernel.org>
In-Reply-To: <20260803031457.3115812-2-memxor@gmail.com>
References: <20260803031457.3115812-2-memxor@gmail.com>
Subject: Re: [PATCH bpf-next v3 1/3] bpf: Show more useful info in stack depth stats
From: bot+bpf-ci@kernel.org
To: memxor@gmail.com,bpf@vger.kernel.org
Cc: andrii@kernel.org,ast@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,emil@etsalapatis.com,kkd@meta.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Mon,  3 Aug 2026 04:34:13 +0000 (UTC)

--===============5212603704248020982==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index b274004fccfd9..cc2b4a8619ac7 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -18777,10 +18777,15 @@ static void print_verification_stats(struct bpf_verifier_env *env)
>  	if (env->log.level & BPF_LOG_STATS) {
>  		verbose(env, "verification time %lld usec\n",
>  			div_u64(env->verification_time, 1000));
> -		verbose(env, "stack depth %d", env->subprog_info[0].stack_depth);
> -		for (i = 1; i < subprog_cnt; i++)
> -			verbose(env, "+%d", env->subprog_info[i].stack_depth);
> -		verbose(env, " max %d\n", env->max_stack_depth);
> +		verbose(env, "stack depth max %d\n", env->max_stack_depth);
> +		for (i = 0; i < subprog_cnt; i++) {
> +			const char *name = subprog_name(env, i);
> +
> +			if (!name[0])
> +				name = "<unknown>";
> +			verbose(env, "stack depth subprog %d %s %d\n", i, name,
> +				env->subprog_info[i].stack_depth);
> +		}

Does this code handle the verifier error path safely? Looking at
bpf_check() ordering (kernel/bpf/verifier.c around lines 20272-20392),
print_verification_stats() is called unconditionally after the
skip_full_check label and will run even when verification fails.

subprog_name() indexes aux->func_info:

kernel/bpf/verifier.c:subprog_name() {
    if (!env->prog->aux->func_info)
        return "";
    info = &env->prog->aux->func_info[subprog];
    return btf_type_name(env->prog->aux->btf, info->type_id);
}

But aux->func_info is allocated in check_btf_func_early() with size
attr->func_info_cnt (user-supplied), while env->subprog_cnt can be
larger after add_subprog_and_kfunc() runs. The invariant nfuncs ==
subprog_cnt is only enforced later in check_btf_func():

kernel/bpf/check_btf.c:check_btf_func() {
    if (nfuncs != env->subprog_cnt) {
        verbose(env, "number of funcs in func_info doesn't match ...");
        return -EINVAL;
    }
}

When this check fails and returns -EINVAL, the error path reaches
print_verification_stats() with func_info_cnt < subprog_cnt.

Concrete sequence:
1. check_btf_func_early() allocates func_info with nfuncs=1
2. add_subprog_and_kfunc() sets subprog_cnt=3 (two static subprogs)
3. check_btf_func() hits nfuncs != subprog_cnt and returns -EINVAL
4. Error path falls through to print_verification_stats()
5. The new loop runs for i = 0, 1, 2
6. subprog_name(env, 1) and subprog_name(env, 2) read
   func_info[1] and func_info[2] past the end of a 1-element array

This would be a heap out-of-bounds read. The garbage type_id then
causes btf_type_by_id() to return NULL when type_id >= btf->nr_types,
and btf_type_name() dereferences that NULL:

kernel/bpf/verifier.c:btf_type_name() {
    return btf_name_by_offset(btf, btf_type_by_id(btf, id)->name_off);
}

Could you either bound the loop by min(subprog_cnt, func_info_cnt), or
add a subprog >= func_info_cnt check to subprog_name() before indexing
func_info?

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/30781585579
--===============5212603704248020982==--
