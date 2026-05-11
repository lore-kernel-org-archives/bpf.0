Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81D4540242C
	for <bpf@vger.kernel.org>; Mon, 11 May 2026 15:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778514384; cv=none; b=CJQlF5IpoTQkEFTjVuuT6qC9A3K5MeRFJANkxEwxVuM6TfsdR1apwTyydlMuB2ZYAToBoVY1qirLs642M4hERtvGLHT9s64msTEeA+DOrgVnFMg0Ib7s5/K3IX/z7/8xjB8f8cvGVgAiPCFx9q+XSS72Nu9DuvuTroakGg4u9AY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778514384; c=relaxed/simple;
	bh=O3bqGz5Qj9ntk94GWFe+fawiyqqYw+4q8xn2Ah5ZYYs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RBqrYXU5KKd0S3nSejppYTLX959eCqyWtDjGcYX2w69Fmnt/zC62FX1ILLVd2UJe/VCty0wH5ve8BUSNrzfqZ8DoaRA+CL+VsNeGvNTeThyq0NSRUTudz1HkhTiLXLRO2nYwPmzP/f+PKbiKwy7DjL3F33SX7+A2am8wkGHaZT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=iXg1M1ln; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="iXg1M1ln"
Message-ID: <1718e913-d51d-4e81-9106-c39c88e9e160@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1778514379;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lYVDoc61Anf9lkHD0Ti+iQia5vtS7ZB28rSYCKTlJ/E=;
	b=iXg1M1lnFj3cY0/FbgWFgE7XmqfETiuyj5DsT+8SGpsdFYwgbTPg95Tz68EXF9dWVFz1i9
	WH6ypEsZJsQuMBQNu2dmCOYhG3wAcRyq5QFimUQaXkb60gcC0sEDIy0FC89bs64puV+V3M
	7bSNlNUx31qlgGrrsEBw/TR4Ske3VCY=
Date: Mon, 11 May 2026 08:46:13 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v3 05/24] bpf: Support stack arguments for bpf
 functions
Content-Language: en-GB
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 jose.marchesi@oracle.com, kernel-team@fb.com, martin.lau@kernel.org,
 eddyz87@gmail.com, clm@meta.com, ihor.solodrai@linux.dev
References: <20260511053327.1883871-1-yonghong.song@linux.dev>
 <1bb0dfc54cc2dbe6a38c21af2717f1b575ba60ba66a763952f38ada03a65bf85@mail.kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <1bb0dfc54cc2dbe6a38c21af2717f1b575ba60ba66a763952f38ada03a65bf85@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 5/11/26 8:19 AM, bot+bpf-ci@kernel.org wrote:
>> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
>> index 321b9d69cf9c..f9020a4ea005 100644
>> --- a/include/linux/bpf_verifier.h
>> +++ b/include/linux/bpf_verifier.h
>> @@ -402,6 +402,7 @@ struct bpf_func_state {
>>   	bool in_callback_fn;
>>   	bool in_async_callback_fn;
>>   	bool in_exception_callback_fn;
>> +	bool no_stack_arg_load;
> [ ... ]
>
>> diff --git a/kernel/bpf/states.c b/kernel/bpf/states.c
>> index bd9c22945050..c249eb40c6d6 100644
>> --- a/kernel/bpf/states.c
>> +++ b/kernel/bpf/states.c
>> @@ -833,6 +833,32 @@ static bool stacksafe(struct bpf_verifier_env *env, struct bpf_func_state *old,
>>   	return true;
>>   }
>>
>> +/*
>> + * Compare stack arg slots between old and current states.
>> + * Outgoing stack args are path-local state and must agree for pruning.
>> + */
>> +static bool stack_arg_safe(struct bpf_verifier_env *env, struct bpf_func_state *old,
>> +			   struct bpf_func_state *cur, struct bpf_idmap *idmap,
>> +			   enum exact_level exact)
>> +{
>> +	int i, nslots;
>> +
>> +	nslots = max(old->out_stack_arg_cnt, cur->out_stack_arg_cnt);
>> +	for (i = 0; i < nslots; i++) {
>> +		struct bpf_reg_state *old_arg, *cur_arg;
>> +		struct bpf_reg_state not_init = { .type = NOT_INIT };
>> +
>> +		old_arg = i < old->out_stack_arg_cnt ?
>> +			  &old->stack_arg_regs[i] : &not_init;
>> +		cur_arg = i < cur->out_stack_arg_cnt ?
>> +			  &cur->stack_arg_regs[i] : &not_init;
>> +		if (!regsafe(env, old_arg, cur_arg, idmap, exact))
>> +			return false;
>> +	}
>> +
>> +	return true;
>> +}
>> +
>>   static bool refsafe(struct bpf_verifier_state *old, struct bpf_verifier_state *cur,
>>   		    struct bpf_idmap *idmap)
>>   {
>> @@ -924,6 +950,9 @@ static bool func_states_equal(struct bpf_verifier_env *env, struct bpf_func_stat
>>   	if (!stacksafe(env, old, cur, &env->idmap_scratch, exact))
>>   		return false;
>>
>> +	if (!stack_arg_safe(env, old, cur, &env->idmap_scratch, exact))
>> +		return false;
>> +
>>   	return true;
>>   }
> In v2 (May 7), bot+bpf-ci@kernel.org raised a concern that
> no_stack_arg_load is not compared during state pruning in
> func_states_equal():
>
>      "The same issue applies to state pruning: func_states_equal/
>      stack_arg_safe does not compare no_stack_arg_load either, so a
>      state with no_stack_arg_load=true can be pruned to an old state
>      with no_stack_arg_load=false incorrectly. Should no_stack_arg_load
>      be placed before stack (to be memcpy'd) or should copy_stack_state()
>      explicitly assign it?"
>
> The field placement was fixed (moving no_stack_arg_load before 'stack'
> so it gets copied by memcpy), but func_states_equal() still does not
> explicitly compare this field.
>
> Could this allow incorrect pruning? If a BPF program writes to stack
> args and calls a function on one path (setting no_stack_arg_load=true),
> then branches and tries to read from stack args on another path, the
> verifier might incorrectly prune to the old state with
> no_stack_arg_load=false, missing the enforcement that stack arg reads
> must happen before writes/calls.
>
> Looking at func_states_equal():
>
> kernel/bpf/states.c:func_states_equal() {
>      if (!stacksafe(env, old, cur, &env->idmap_scratch, exact))
>          return false;
>
>      if (!stack_arg_safe(env, old, cur, &env->idmap_scratch, exact))
>          return false;
>
>      return true;
> }
>
> Should no_stack_arg_load be compared here, similar to how other boolean
> flags in bpf_func_state are handled during state comparison?

You are right. The following is an example:

   /* subprog with incoming stack arg */
   r1 = *(r11+8);         /* read incoming arg, no_stack_arg_load = false */
                                                                                                                    
   if cond goto path2;
                                                                                                                    
   path1:
     call some_helper;    /* sets no_stack_arg_load = true */
     goto join;
                                                                                                                    
   path2:
     /* no call, no_stack_arg_load = false */
     goto join;
                                                                                                                    
   join:
     r2 = *(r11+8);       /* read incoming arg again */

In the above case, at 'join' point, we have no_stack_arg_load = true and false
respectively. In this case, we cannot do pruning.

Will fix.

>
> Reference: https://lore.kernel.org/bpf/11c51daec78a68837f719172ae1c21db8b3e98e0a76aa5bcd59c8b089760c40d@mail.kernel.org/
>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/25652623893

