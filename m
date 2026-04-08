Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE35933F36B
	for <bpf@vger.kernel.org>; Wed,  8 Apr 2026 04:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775624025; cv=none; b=K2tKQVwqxmedhKw98PiVLE5U6F87Vx8MCyR9R1LQBC/8+WRvaoZG3z152jS/xy8+9TWCngc49VqaZ1ljCtwQpPLHP6BwqATPZEFBI68W2S9R0gC2rpmmaixYKf/WjaO75hFUqEJkazAC1Lg6WNJtHdK38hx2stqnjiw1ZsmxIPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775624025; c=relaxed/simple;
	bh=eUreFnw7TNbIWOZB7gOPPZgYaWAWPsIzkYVOwl2eDU0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cxVwH0t8B89krFv2+quxXfgtnRL8d3tI7MaHJhzO6s/esxC6omaClaQbEu89HLBMD4i9Tnz/Y/Bymo4JNgKb/osoCPrDN97xfCPB0uXsdlU+QS6ZSVQMFjhgdLrr1ZgwFApy7mFneu0VT1O4551cOBBj005ADtp0vQ407ZEyTTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=SV+dxM70; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="SV+dxM70"
Message-ID: <2701e70f-826c-4e85-a577-e6358401b44f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1775624021;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dpNmTtU8mw+soVtvnaLzBfRfjXlgN4B8Wk105OKGlpI=;
	b=SV+dxM70rvD+jH9uzIvW7vIkpL9q8WxFRWafktBRNdxFvdtZHttSUNHefUHvT+WqcBC25j
	L3uovB2q4mzKEtqQR9j7kiQe1kYL7M1oYq0H/9ePu5jULx5tgaZKqos6MDYzzrwmVncbkO
	DXawg3N0Yv0l9aIgzADUo+MAAWgf7Ac=
Date: Tue, 7 Apr 2026 21:53:35 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v3 05/11] bpf: Support stack arguments for kfunc
 calls
Content-Language: en-GB
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 jose.marchesi@oracle.com, kernel-team@fb.com, martin.lau@kernel.org,
 eddyz87@gmail.com, clm@meta.com, ihor.solodrai@linux.dev
References: <20260405172611.1336162-1-yonghong.song@linux.dev>
 <adcc0eb54109467ffa3e970608a73ba0b39230928555d09663cd771441c010dd@mail.kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <adcc0eb54109467ffa3e970608a73ba0b39230928555d09663cd771441c010dd@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 4/5/26 11:20 AM, bot+bpf-ci@kernel.org wrote:
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
> [ ... ]
>
>> +static struct bpf_reg_state *get_kfunc_arg_reg(struct bpf_verifier_env *env, int argno)
>> +{
>> +	struct bpf_func_state *caller;
>> +	int spi;
>> +
>> +	if (argno < MAX_BPF_FUNC_REG_ARGS)
>> +		return &cur_regs(env)[argno + 1];
>> +
>> +	caller = cur_func(env);
>> +	spi = caller->incoming_stack_arg_depth / BPF_REG_SIZE + (argno - MAX_BPF_FUNC_REG_ARGS);
>> +	return &caller->stack_arg_slots[spi].spilled_ptr;
>> +}
>> +
>>   static enum kfunc_ptr_arg_type
>>   get_kfunc_ptr_arg_type(struct bpf_verifier_env *env,
>>   		       struct bpf_kfunc_call_arg_meta *meta,
> [ ... ]
>
>>   {
>>   	u32 regno = argno + 1;
>>   	struct bpf_reg_state *regs = cur_regs(env);
>>   	struct bpf_reg_state *reg = &regs[regno];
> When check_kfunc_args() calls this function for a stack arg (argno >= 5),
> the stack arg state was placed into regs[BPF_REG_1], but this local
> reg reads regs[argno + 1] instead, which is a callee-saved register
> (BPF_REG_6 through BPF_REG_9) or the frame pointer (BPF_REG_10).
>
> For argno >= 10 (MAX_BPF_FUNC_ARGS is 12), this reads past
> regs[MAX_BPF_REG - 1] into adjacent struct fields, since
> bpf_func_state.regs[] only has 11 entries (BPF_REG_0..BPF_REG_10).
>
> This reg is used later for register_is_null() and base_type(reg->type),
> which would cause wrong argument type classification for pointer-typed
> stack args.  The is_kfunc_arg_mem_size() lookahead a few lines below
> was correctly updated to use get_kfunc_arg_reg() -- should this local
> reg use the same helper?

To use BPF_REG_1 to represent the stack argument is a hack. It may confuse
people and it may have some subtle issues due to this.

In the next revision, I will discard this patch and implement it properly.
In most cases, for related functions w.r.t. stack argument validation,
I will ensure functions has parameters like (reg_state, regno, argno).
If the argument is a stack argument, regno will be -1 (not a register).
In cases where argno is not really available, argno will be -1. But in
any case, at least one of them is positive. The verification log will
print out message properly. If regno is non-negative, log 'regno' is needed.
Otherwise, log 'argno'.

>
>> 	if (argno + 1 < nargs &&
>> -	    (is_kfunc_arg_mem_size(meta->btf, &args[argno + 1], &regs[regno + 1]) ||
>> -	     is_kfunc_arg_const_mem_size(meta->btf, &args[argno + 1], &regs[regno + 1])))
>> +	    (is_kfunc_arg_mem_size(meta->btf, &args[argno + 1], get_kfunc_arg_reg(env, argno + 1)) ||
>> +	     is_kfunc_arg_const_mem_size(meta->btf, &args[argno + 1], get_kfunc_arg_reg(env, argno + 1))))
>>   		arg_mem_size = true;
> [ ... ]
>
>> 		case KF_ARG_PTR_TO_MEM_SIZE:
>>   		{
>>   			struct bpf_reg_state *buff_reg = &regs[regno];
>>   			const struct btf_param *buff_arg = &args[i];
>> -			struct bpf_reg_state *size_reg = &regs[regno + 1];
>> +			struct bpf_reg_state *size_reg;
>>   			const struct btf_param *size_arg = &args[i + 1];
>> +			struct bpf_reg_state saved_size_reg = {};
>> +			bool size_is_stack_arg = false;
>> +
>> +			if (i >= MAX_BPF_FUNC_REG_ARGS) {
>> +				size_is_stack_arg = true;
>> +				saved_size_reg = regs[regno + 1];
>> +				regs[regno + 1] = *get_kfunc_arg_reg(env, i + 1);
>> +				verbose(env, "Use reg %d to represent mem_size\n", regno + 1);
>> +			}
>> +			size_reg = &regs[regno + 1];
> Is there a missing case when the pointer arg is the last register arg
> (i == MAX_BPF_FUNC_REG_ARGS - 1, i.e. i == 4) and the size arg is
> the first stack arg (i + 1 == 5)?

Yes. This is something I intend to support. arg4 (starting from arg0)
is a memory pointer at reg5, and arg5 represents the memory size at
the first stack argument.

>
> In that case i < MAX_BPF_FUNC_REG_ARGS, so is_stack_arg is false and
> regno is 5 (BPF_REG_5).  The condition "i >= MAX_BPF_FUNC_REG_ARGS"
> is false, so size_is_stack_arg stays false.  Then size_reg becomes
> &regs[6], which is BPF_REG_6 (a callee-saved register) instead of
> the stack arg slot for arg 5.

In this case, BPF_REG_6 will be saved first, and then BPF_REG_6 will
have the first stack argument for future verification.

But in any case, this patch set is a hack. I will have proper
implementation in the next revision.

>
> The get_kfunc_ptr_arg_type() lookahead correctly handles this boundary
> with get_kfunc_arg_reg(env, argno + 1), so the arg gets classified as
> KF_ARG_PTR_TO_MEM_SIZE, but then the actual size check reads from the
> wrong register.
>
> Would something like "if (i + 1 >= MAX_BPF_FUNC_REG_ARGS)" be the
> right condition here?
>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/24006922024

