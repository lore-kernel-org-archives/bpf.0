Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B3263E9F80
	for <bpf@vger.kernel.org>; Thu,  2 Apr 2026 14:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775141157; cv=none; b=pKYToqgDdyOXejYt9990acKmALcZciSnraZuFUvpZEFTWt9qC7mhfTvNKTE4JSBdwhBIA1NIG/rbHoymoo0zA9IZS6QjCxURK+dWk/qDwxsl2UPztlMF6lR5jN5ilNr6qe8UGbuvvUsP1ZTu3P9+1mtNRam9aDrxfItaaqaThAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775141157; c=relaxed/simple;
	bh=kcxeCDSDDdbXApk4LPhEfPzavWimfD/V6ejHAD1tmLc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XXGHkSi0dqZVOzSVH1cp9pOQKz3ddSJ9LuKgu1yR6E8ngRhc8bzpP/DXdKXe6grhEyTjCJF1KX+cjquAAPgpZn3e1z2IpNPnCbYNIJQRfe/7PdeZq2yN7rhfhpiz1tKOQykbA5OWJIruMD4FX+KyAAboX0V58SiDpokYPbqh2q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fGjjy/9n; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fGjjy/9n"
Message-ID: <be79c4fd-7b04-4877-83fd-e86e0949aeca@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1775141154;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gxSvDZin+pSB0gT1Wn1Ko0uZlM+qDq4l5LfEa1amAik=;
	b=fGjjy/9nhd6yiSk2MVjWud82lMMjd+Ffi4vFDGTTCGWMVeaU5myaTz4QEelJqHx/AzkJjT
	ehamBFkcvSNBXJ5iV68MJ/lI2BtSvSJBIOa0z993NVHwZqIGX5aaN1lEMRQT2t7ZeQ2FI/
	uWv3l96BE/rY4xSIevTZqA1/DZG3/bo=
Date: Thu, 2 Apr 2026 07:45:42 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 04/10] bpf: Support stack arguments for kfunc
 calls
Content-Language: en-GB
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 jose.marchesi@oracle.com, kernel-team@fb.com, martin.lau@kernel.org,
 eddyz87@gmail.com, clm@meta.com, ihor.solodrai@linux.dev
References: <20260402012747.3918081-1-yonghong.song@linux.dev>
 <f8e301126ace0672841b6a9f9a8ee1e4dba2f6784817ec4d9ba9489518db3cce@mail.kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <f8e301126ace0672841b6a9f9a8ee1e4dba2f6784817ec4d9ba9489518db3cce@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 4/1/26 8:18 PM, bot+bpf-ci@kernel.org wrote:
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index d424fe611ef8..6579156486b8 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
> [ ... ]
>
>> @@ -13687,13 +13694,41 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
>>   	 * verifier sees.
>>   	 */
>>   	for (i = 0; i < nargs; i++) {
>> -		struct bpf_reg_state *regs = cur_regs(env), *reg = &regs[i + 1];
>> +		struct bpf_reg_state *regs = cur_regs(env), *reg;
>> +		struct bpf_reg_state saved_reg;
> [ ... ]
>
>> +		if (i < MAX_BPF_FUNC_REG_ARGS) {
>> +			reg = &regs[i + 1];
>> +		} else {
>> +			/*
>> +			 * Retrieve the spilled reg state from the stack arg slot.
>> +			 * Reuse the existing type checking infrastructure which
>> +			 * reads from cur_regs(env)[regno], temporarily copy the
>> +			 * stack arg reg state into regs[BPF_REG_1] and restore
>> +			 * it after checking.
>> +			 */
> [ ... ]
>
>> +			is_stack_arg = true;
>> +			regno = BPF_REG_1;
>> +			saved_reg = regs[BPF_REG_1];
>> +			regs[BPF_REG_1] = caller->stack_arg_slots[spi].spilled_ptr;
>> +			reg = &regs[BPF_REG_1];
>> +		}
>> +
>>   		if (is_kfunc_arg_prog_aux(btf, &args[i])) {
> [ ... ]
>
>> -			continue;
>> +			goto next_arg;
>>   		}
>>
>>   		if (is_kfunc_arg_ignore(btf, &args[i]) || is_kfunc_arg_implicit(meta, i))
>>   			continue;
> The is_kfunc_arg_prog_aux path above was converted from continue to
> goto next_arg so that regs[BPF_REG_1] gets restored via the next_arg
> label. The scalar path and the KF_ARG_PTR_TO_NULL path were also
> converted the same way.
>
> Should this continue for is_kfunc_arg_ignore/is_kfunc_arg_implicit
> also be goto next_arg? When a stack arg (i >= MAX_BPF_FUNC_REG_ARGS)

You are right. My initial version with a early bpf-next is okay.
But after rebase on top of master, I missed the above as it is
newly introduced. Will fix in the next revision.

> hits this continue, is_stack_arg is true but the next_arg restore is
> skipped, so regs[BPF_REG_1] keeps the spilled pointer from the
> current iteration. On the next iteration, saved_reg then captures that
> stale value instead of the original register state.
>
> The comment above says "restore it after checking", which this continue
> path does not do. The impact is currently masked because each iteration
> independently overwrites regs[BPF_REG_1] and the caller_saved clearing
> in check_kfunc_call() resets R1 after the loop, but it breaks the
> save/restore invariant the rest of this patch establishes.
>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/23879588767

