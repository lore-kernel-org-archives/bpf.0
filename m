Received: from mta0.migadu.com (out-30.mta0.migadu.com [91.218.175.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F6B5331203
	for <bpf@vger.kernel.org>; Thu, 13 Aug 2026 18:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786645248; cv=none; b=VeaZDc2cC8ElNh/WhQFqBQYvLukRi4kSnz2EA7m6BZrbVpFPzxKn6G6GaYV+iLiXmjbARvikao82lQPKcaBjzzRcJvRpVZECeBy44N02ApLbgJzcH9yLOp63o1IRArqK4wEz871OZ1uMEQJDkdEANwzWYFyAJgDqxAVkKPm2mqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786645248; c=relaxed/simple;
	bh=egvimJ4WZjMFhgUE8NNQCpcSLbpIKRWuSWKKVmUbRiY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RlqSU+pGHfhg9sNuoqG38YQul+rrEQco3jewwHjpeFyxO/32klHxKVejG41A2eyByXPA+esYK8jKPsYcOTDFwCaIbRzmgBQxu6S5qin14I/ZE6cjKLzKzgsH/h2vA2F5EIcPtPuUegRtn4Fr3Uc6JgXGVbhBm4km0GhL3YvFW1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=J3zqoO/t; arc=none smtp.client-ip=91.218.175.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="J3zqoO/t"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=egvimJ4WZjMFhgUE8NNQCpcSLbpIKRWuSWKKVmUbRiY=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786645243; v=1; x=1787250043;
 b=J3zqoO/twCVX/tPc6cCOl+t6yTsoRXyN6NQDI87VvZz7d5phZFNR6avubYzoLS+DEVHqqzMV
 /f9F4CzaMvrsKTfmKbB4bxQiUlOjWXDrPabw5BzwqRmwj6L16rkr4pBMmvPtCZUPQqR0Ue6Tzkm
 Cd0uFk5zZQco7kEYBJtpy2ME=
X-Envelope-To: bpf@vger.kernel.org
Received: from [IPV6:2600:381:1f2d:e3e3:185d:58c3:4c79:68c] (2600:381:1f2d:e3e3:185d:58c3:4c79:68c)
	by smtp.migadu.com with ESMTPS id ab9661d86048f2c6;
	Thu, 13 Aug 2026 18:20:43 +0000
X-Migadu-Flow: FLOW_OUT
Message-ID: <cd43d82d-0f0b-48a9-9d81-eb214d96a3ad@linux.dev>
Date: Thu, 13 Aug 2026 11:20:40 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v4 07/13] bpf: Add verifier support for 16-byte
 returns in R0:R2
Content-Language: en-GB
To: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com
References: <20260811000911.2378679-1-yonghong.song@linux.dev>
 <20260811000947.2381981-1-yonghong.song@linux.dev>
 <e6f6247b319dde9f055092cd337a61292887b141.camel@gmail.com>
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <e6f6247b319dde9f055092cd337a61292887b141.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 8/12/26 3:12 PM, Eduard Zingerman wrote:
> On Mon, 2026-08-10 at 17:09 -0700, Yonghong Song wrote:
>
> ...
>
>> @@ -9810,10 +9827,14 @@ static int prepare_func_exit(struct bpf_verifier_env *env, int *insn_idx)
>>   	struct bpf_func_state *caller, *callee;
>>   	struct bpf_reg_state *r0;
>>   	bool in_callback_fn;
>> +	u32 i, nregs;
>>   	int err;
>>   
>>   	callee = state->frame[state->curframe];
>>   	r0 = &callee->regs[BPF_REG_0];
>> +	nregs = bpf_ret_reg_pair(env, callee->subprogno) ? 2 : 1;
>> +	if (nregs > 1)
>> +		env->prog->jit_required = 1;
> Definitely let's move this to bpf_compute_subprog_ret_regs()
> instead of setting it in multiple places.

Indeed, 'env->prog->jit_required = 1' will be in bpf_compute_subprog_ret_regs().

>
>>   	if (r0->type == PTR_TO_STACK) {
>>   		/* technically it's ok to return caller's stack pointer
>>   		 * (or caller's caller's pointer) back to the caller,
>> @@ -9849,8 +9870,23 @@ static int prepare_func_exit(struct bpf_verifier_env *env, int *insn_idx)
>>   			return -EFAULT;
>>   		}
>>   	} else {
>> -		/* return to the caller whatever r0 had in the callee */
>> -		caller->regs[BPF_REG_0] = *r0;
>> +		/*
>> +		 * return to the caller whatever the callee had in the
>> +		 * return register(s)
>> +		 */
>> +		for (i = 0; i < nregs; i++)
>> +			caller->regs[ret_regs[i]] = callee->regs[ret_regs[i]];
>> +
>> +		/*
>> +		 * R2 carries only the upper half of a register pair return
>> +		 * value. A stack pointer must not escape the callee (see the
>> +		 * R0 case above), but there is no need to reject the whole
>> +		 * program for it: hand the caller an uninitialized R2 instead,
>> +		 * so that only a caller actually using the returned pointer
>> +		 * fails.
>> +		 */
>> +		if (nregs > 1 && caller->regs[BPF_REG_2].type == PTR_TO_STACK)
>> +			bpf_mark_reg_not_init(env, &caller->regs[BPF_REG_2]);
> Why special casing this? What if caller does not use r0,
> should r0 be reset in such a case as well?
> Let's handle both r0 and r2 in one place.

Will handle PTR_TO_STACK for both r0 and r2.

>
>>   	}
>>   
>>   	/* for callbacks like bpf_loop or bpf_for_each_map_elem go back to callsite,
> ...
>
>> @@ -16710,11 +16775,26 @@ static int check_global_subprog_return_code(struct bpf_verifier_env *env)
>>   {
>>   	struct bpf_func_state *cur_frame = cur_func(env);
>>   	u32 subprog = cur_frame->subprogno;
>> +	u32 i, nregs;
>> +	int err;
>>   
>>   	if (subprog_returns_void(env, subprog))
>>   		return 0;
>>   
>> -	return check_global_ret_scalar_reg(env, BPF_REG_0);
>> +	/*
>> +	 * An arena pointer is only a legitimate return value when it is the
>> +	 * whole of it, that is when it is returned in R0 alone. Both halves of
>> +	 * a register pair carry a piece of a >8 byte scalar, so an arena
>> +	 * pointer in either of them is a leak.
>> +	 */
> Why forbidding returning two arena pointers?

Okay, will relax this. Indeed, two arena pointers are supported.

>
>> +	nregs = bpf_ret_reg_pair(env, subprog) ? 2 : 1;
>> +	for (i = 0; i < nregs; i++) {
>> +		err = check_global_ret_scalar_reg(env, ret_regs[i], nregs == 1);
>> +		if (err)
>> +			return err;
>> +	}
>> +
>> +	return 0;
>>   }
>>   
>>   /* Bitmask with 1s for all caller saved registers */
>> @@ -17203,10 +17283,16 @@ static int process_bpf_exit_full(struct bpf_verifier_env *env,
>>   	 */
>>   	if (cur_frame->subprogno &&
>>   	    !cur_frame->in_async_callback_fn &&
>> -	    !cur_frame->in_exception_callback_fn)
>> +	    !cur_frame->in_exception_callback_fn) {
>>   		err = check_global_subprog_return_code(env);
>> -	else
>> +	} else {
>> +		if (!cur_frame->subprogno && bpf_ret_reg_pair(env, 0)) {
>> +			verbose(env,
>> +				"return value larger than 8 bytes is not supported at program exit\n");
>> +			return -EINVAL;
>> +		}
> Same as with callbacks, I don't see a reason to check this.
> The purpose of the verifier is to avoid loading a program
> that would accidentally bring down the kernel, this check
> does not contribute towards this goal.

Okay, will remove it.

>
>>   		err = check_return_code(env, BPF_REG_0, "R0");
>> +	}
>>   	if (err)
>>   		return err;
>>   	return PROCESS_BPF_EXIT;
>> @@ -19366,6 +19452,22 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
>>   			return -EOPNOTSUPP;
>>   		}
>>   
>> +		/*
>> +		 * An extension replaces the target outright, so it has to match
>> +		 * the target's return convention. Its own return value is capped
>> +		 * at 8 bytes (a >8 byte program return is rejected at BPF_EXIT),
>> +		 * so it can never fill the R0:R2 pair the target's callers read.
>> +		 * This cannot be left to btf_check_type_match() above, which
>> +		 * compares return types by btf_type->info only: an int carries no
>> +		 * vlen, so a 16-byte __int128 and an 8-byte long compare equal.
>> +		 */
> Should the btf_check_type_match() be fixed?

The function btf_check_type_match() calls btf_check_func_type_match().
In btf_check_func_type_match(), we have


         t1 = btf_type_skip_modifiers(btf1, t1->type, NULL);
         t2 = btf_type_skip_modifiers(btf2, t2->type, NULL);
         if (t1->info != t2->info) {
                 bpf_log(log,
                         "Return type %s of %s() doesn't match type %s of %s()\n",
                         btf_type_str(t1), fn1,
                         btf_type_str(t2), fn2);
                 return -EINVAL;
         }

         for (i = 0; i < nargs1; i++) {
		...
	}

It only checked the t1->info vs. t2->info. For example t1->info and t2->info both
have kind INT. But t1 and t2 may have different INT type (e.g. int vs. long)
and this is allowed in btf_check_func_type_match().
The same thing it also allows int vs. int128.
The same for other kinds e.g. struct (some struct has smaller size and some struct
has larger size).

So I didn't use btf_check_type_match() and rather use tgt_info->fmodel.ret_size > 8
where reject any prog returning more than 8 bytes.

>
>> +		if (prog_extension && tgt_info->fmodel.ret_size > 8) {
>> +			bpf_log(log,
>> +				"Cannot replace function %s with a >8 byte return value\n",
>> +				tname);
>> +			return -EOPNOTSUPP;
>> +		}
>> +
>>   		/*
>>   		 * *.multi programs don't need an address during program
>>   		 * verification, we just take the module ref if needed.

