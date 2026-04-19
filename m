Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D21A21A262A
	for <bpf@vger.kernel.org>; Sun, 19 Apr 2026 18:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776622708; cv=none; b=WcdW4rBhcNZUwW+DSHPgh0EdjjdTKX8xoh5DHH6qiNP4OVugXc4UbZhG4OAQW8L3TdCCBLqnBfrqYX2i7ny4aYeYle6dgccCEes2//WhS3deaohye6VyMK7WxyeIFc/mI1C3NXET105eFq0DCBa1Wfv7tHRk8/YIn29J6akMYp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776622708; c=relaxed/simple;
	bh=nnNLoHilbGtk8BFTqFAMC6rzO3aSqW/kCOKVtbVDCL0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AgeoaQlZhPr6t8AZ4BIFc8c5/bzbGEcGvqTPgiVsdoNTa7cdrI84SvbfRgeZ6pl8YOtMAbR74RGvqpgP920vCyoXMyjH8Mfl2qJWm6P2dLOD/CP7b0eUg8oNZP3m6UR7cEf9n4y14KC7AkXl39TdpB/j+alVUUCIEQ0ahHVIe/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=P9oQRHqs; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="P9oQRHqs"
Message-ID: <1e100198-b8df-41a5-a0b1-f22a572def4b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776622704;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=35BHCWzpr9q2sFUNK2dBT2Tg29aGjePelhPITGDhfXI=;
	b=P9oQRHqshxa488xvxCiy9l7U6HL6YwSWPDpewnzbE4M5WL/f0fx/bg6sbp7vAmMMa1mAp6
	J6E6lLpJGKhzlZnUAe8Nkjme3rBo4gVYK//goh+ZsY5dM7x4vRw85sWZq6cO7zNs2BOVPj
	7Zao0b5GG/DJb8AfOs0ki9qNmoNcMlk=
Date: Sun, 19 Apr 2026 11:18:19 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v6 12/17] bpf: Support stack arguments for kfunc
 calls
Content-Language: en-GB
To: sashiko@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260419163417.736887-1-yonghong.song@linux.dev>
 <20260419170817.D8136C2BCAF@smtp.kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20260419170817.D8136C2BCAF@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 4/19/26 10:08 AM, sashiko-bot@kernel.org wrote:
> Sashiko AI review found 2 potential issue(s):
> - [Critical] Loss of precision tracking for scalar stack arguments due to modifying a local copy (`tmp_reg`).
> - [Critical] Bypassing `mark_chain_precision` for stack arguments breaks data-flow backtracking, enabling unsafe state pruning.
> --
>
> commit 96adcc4832214af51212820f2056565abaf42a32
> Author: Yonghong Song <yonghong.song@linux.dev>
>
> bpf: Support stack arguments for kfunc calls
>
> Extend the stack argument mechanism to kfunc calls, allowing kfuncs
> with more than 5 parameters to receive additional arguments via the
> r11-based stack arg area.
>
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index 2a346e4f28e15..13f1fd7880921 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
> [ ... ]
>> @@ -7314,8 +7322,12 @@ static int check_mem_size_reg(struct bpf_verifier_env *env,
>>   	}
>>   	err = check_helper_mem_access(env, mem_reg, mem_argno, size_reg->umax_value,
>>   				      access_type, zero_size_allowed, meta);
>> -	if (!err && !is_stack_argno(size_argno))
>> -		err = mark_chain_precision(env, size_argno);
>> +	if (!err) {
>> +		if (is_stack_argno(size_argno))
>> +			size_reg->precise = true;
>> +		else
>> +			err = mark_chain_precision(env, size_argno);
>> +	}
>>   	return err;
>>   }
> Does setting size_reg->precise = true without calling mark_chain_precision()
> break data-flow backtracking?
>
> If only the current state's flag is set, parent states and the source
> registers that populated the stack argument will not be marked precise.
> Could this lead to the verifier incorrectly pruning states if execution paths
> merge before the stack store?

You are right. Let me think how to resolve this.

>
> [ ... ]
>> @@ -12373,20 +12400,44 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
> [ ... ]
>>   		if (i < MAX_BPF_FUNC_REG_ARGS) {
>>   			reg = &regs[i + 1];
>>   		} else {
>>   			/* Retrieve the reg state from the outgoing stack arg slot. */
>>   			struct bpf_func_state *caller = cur_func(env);
>>   			int spi = out_arg_spi(caller, i - MAX_BPF_FUNC_REG_ARGS);
>>   
>>   			if (!is_stack_arg_slot_initialized(caller, spi)) {
>>   				verbose(env, "stack %s not properly initialized\n",
>>   					reg_arg_name(env, argno));
>>   				return -EINVAL;
>>   			}
>>   
>>   			tmp_reg = caller->stack_arg_regs[spi];
>>   			reg = &tmp_reg;
>>   			regno = -1;
>>   		}
> [ ... ]
>> @@ -12413,9 +12464,13 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
>>   						reg_arg_name(env, argno));
>>   					return -EINVAL;
>>   				}
>> -				ret = mark_chain_precision(env, regno);
>> -				if (ret < 0)
>> -					return ret;
>> +				if (regno < 0) {
>> +					reg->precise = true;
>> +				} else {
>> +					ret = mark_chain_precision(env, regno);
>> +					if (ret < 0)
>> +						return ret;
>> +				}
>>   				meta->arg_constant.found = true;
>>   				meta->arg_constant.value = reg->var_off.value;
> Does setting reg->precise = true here modify a local copy instead of the actual
> verifier state?
>
> Since reg points to tmp_reg for stack arguments:
>
>          tmp_reg = caller->stack_arg_regs[spi];
>          reg = &tmp_reg;
>
> it seems that reg->precise = true will only update the block-scoped tmp_reg,
> leaving the real state in caller->stack_arg_regs[spi] untouched. Could this
> cause the verifier to lose track of precision requirements for scalar
> constraints?

Right, tmp_reg is not used. I guess my previous usage of tmp_reg due to
an early hack but I didn't remove it. Will remove tmp_reg in the next revision.

>
> Additionally, similar to check_mem_size_reg() above, bypassing
> mark_chain_precision() for stack arguments appears to skip backtracking
> entirely.

Ack.

