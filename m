Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAB3D26CE2C
	for <bpf@vger.kernel.org>; Sat, 18 Apr 2026 16:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776530835; cv=none; b=Ggh2NjaqLHmnI7DeuvZRmnDcjUHIrHSpYg2RN+jltGcRebVpoGxPzX4Xji4mx7X8vQn8POVFcnnmMFMslOu5ysxuN8JuDw8v6oD/8tNA0t8mCMaJfbaQw8UQpJw15SpZDboWIIj9sj/PvS+CxW95FqscNRagvolya0dDWKv/rpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776530835; c=relaxed/simple;
	bh=gg8hnS31MFphRTfmcZ71co/wGzpDeL1coTxsAe9aIog=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fEeVHenvd0YhIUvjiz33Z+t75IaSfjAqsYQLYgcx+Ys/mI1ylQVRK6BSWSd9Ogkt9xoH6czoy2gRrK5Frpqo2YZRwp/ju4sOiBWvQr6r8hCPkG9qVE1Lbbdj6xBvGiIBtF3ZpQVr57d4qhD8a92HlrsaZkrA6tEdbOeQJE9cCGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=bbli9OxI; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="bbli9OxI"
Message-ID: <bf24331a-dfca-4a56-b33b-3fd75a8ba6bc@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776530831;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gT8exPkCyXHcLgab2qXso4+5blZfcRhsCq3CbJ3hMLw=;
	b=bbli9OxIfnA8Bgf9tgS99bMovQsDPzOowy6ERYXO9oaDHpQs0/yLvd4COoWz+yPDgMOAWE
	r68Y4d8QPEE2CEa6HS/tbROrOik7uJBLquveWGIZypUy5/qHUoILokpOv9q5duzLIbiR/a
	dQ218Q/R9YiCbsFlc/i+ajp0U2MCUrY=
Date: Sat, 18 Apr 2026 09:47:05 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v5 03/16] bpf: Refactor to handle memory and size
 together
Content-Language: en-GB
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 jose.marchesi@oracle.com, kernel-team@fb.com, martin.lau@kernel.org,
 eddyz87@gmail.com, clm@meta.com, ihor.solodrai@linux.dev
References: <20260417034713.2627100-1-yonghong.song@linux.dev>
 <dce4ce2de406cbd89d8c9a50bee1bee3d5701b3b1d77da8bb2c8d9c9d90b279b@mail.kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <dce4ce2de406cbd89d8c9a50bee1bee3d5701b3b1d77da8bb2c8d9c9d90b279b@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 4/17/26 5:52 PM, bot+bpf-ci@kernel.org wrote:
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index 2bedaa193d54..7a7024d94cf0 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
> [ ... ]
>
>> @@ -7020,15 +7020,17 @@ static int check_helper_mem_access(struct bpf_verifier_env *env, int regno,
>>   /* verify arguments to helpers or kfuncs consisting of a pointer and an access
>>    * size.
>>    *
>> - * @regno is the register containing the access size. regno-1 is the register
>> - * containing the pointer.
>> + * @mem_regno is the register containing the pointer, mem_regno+1 is the register
>> + * containing the access size.
>>    */
>>   static int check_mem_size_reg(struct bpf_verifier_env *env,
>> -			      struct bpf_reg_state *reg, u32 regno,
>> +			      struct bpf_reg_state *mem_reg,
>> +			      struct bpf_reg_state *size_reg, u32 mem_regno,
>>   			      enum bpf_access_type access_type,
>>   			      bool zero_size_allowed,
>>   			      struct bpf_call_arg_meta *meta)
>>   {
>> +	int size_regno = mem_regno + 1;
>>   	int err;
>>
>>   	/* This is used to refine r0 return value bounds for helpers
> The refactoring passes size_reg as a parameter to prepare for stack
> arguments, but this code still hardcodes size_regno as mem_regno + 1.
> Does this assumption hold when stack arguments are used, where the size
> might not be at mem_regno + 1?

When stack arguments are used, the 'mem_regno' will be replaced as
'mem_argno' and the size_regno will be size_argno which represents
either a register or an argument idx (idx starts from 1). See next patch.

>
> Looking at how mark_chain_precision() is called later in this function:
>
>>   	err = check_helper_mem_access(env, mem_reg, mem_regno, size_reg->umax_value,
>>   				      access_type, zero_size_allowed, meta);
>>   	if (!err)
>> -		err = mark_chain_precision(env, regno);
>> +		err = mark_chain_precision(env, size_regno);
> The incorrect size_regno value would cause mark_chain_precision() to mark
> the wrong register for precision tracking. For example, if the memory
> pointer is passed in R5 and the size is in a stack slot, mem_regno would
> be 5, making size_regno 6. This would incorrectly backtrack BPF_REG_6
> instead of the stack slot containing the size argument.

This won't happen. There will be some check in the above if statement.

>
> Could this break verifier state pruning when the commit message's stated
> goal of handling "stack arguments as they may be beyond registers 1-5" is
> implemented?

This will be addressed when stack arguments are supported and we can mark size_argno
precision is true since the size itself will be a constant.

>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/24592562564

