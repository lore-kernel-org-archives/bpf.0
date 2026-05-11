Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3BFD3A4F23
	for <bpf@vger.kernel.org>; Mon, 11 May 2026 16:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778516499; cv=none; b=RLQaD9SpSkQ8/0GpbONzGhRlyH8nvguIL10Fe3wqzyHhopu2Okjr6PNNxMc3yA8ZBr8+5yGZPsbMCZWOFnXGEWHh9n+GAI7i2evui5reIWQd/9QywqE6+9fyW1sB392qthgBEyAsgAkX5iMK4iMKQaNEPMJQ3lxXGKr8vVoQrFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778516499; c=relaxed/simple;
	bh=NpzLMSpLQBoEgBEfLALVRm0Is6pCRuFqE40WCKJ9xw0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UEwZJbXcXvfCc8Z61fc/Ea9JfpZ721IoqKvAZ0+vDekuVLKJEPVes9dYF1l9OjUkqbn8foWxswk2TieYzBoAz0swhkAMjav1fyjEKg1ELCt6s5YCT1RSyAyflgyeQRcjIRwvOsYMKOGxFRLNiODS3Yi6b9PN3c6+VKojp3z6eU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=BBZVUO/U; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="BBZVUO/U"
Message-ID: <daba95b9-763d-4c9b-b45c-d31757f3e434@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1778516494;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uAbchmtPkZRJ96izN8iZu3d1GyfIEuHjXDGyAEvh5XQ=;
	b=BBZVUO/UQFyFYuLZKha2nZ5JG2lSGWADvfTGLuD/CzUfBWqGuIAFtzA7qzdr4z34OP5AgW
	bAr12xt7aL7Vo5A/xanaS1nNqWfD3PhJOT1lhWX3zEkKtb9skXF3wOG/nC6uFufOS+bRLo
	yUEJobdNwCOlKdn594W/GPyKNQ7S9Zs=
Date: Mon, 11 May 2026 09:21:27 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v3 05/24] bpf: Support stack arguments for bpf
 functions
Content-Language: en-GB
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bot+bpf-ci@kernel.org,
 bpf@vger.kernel.org
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 jose.marchesi@oracle.com, kernel-team@fb.com, martin.lau@kernel.org,
 eddyz87@gmail.com, clm@meta.com, ihor.solodrai@linux.dev
References: <20260511053327.1883871-1-yonghong.song@linux.dev>
 <1bb0dfc54cc2dbe6a38c21af2717f1b575ba60ba66a763952f38ada03a65bf85@mail.kernel.org>
 <1718e913-d51d-4e81-9106-c39c88e9e160@linux.dev>
 <DIFZ4QX7T164.30KVT7BJ584K7@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <DIFZ4QX7T164.30KVT7BJ584K7@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 5/11/26 6:05 PM, Alexei Starovoitov wrote:
> On Mon May 11, 2026 at 8:46 AM PDT, Yonghong Song wrote:
>>
>> On 5/11/26 8:19 AM, bot+bpf-ci@kernel.org wrote:
>>>> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
>>>> index 321b9d69cf9c..f9020a4ea005 100644
>>>> --- a/include/linux/bpf_verifier.h
>>>> +++ b/include/linux/bpf_verifier.h
>>>> @@ -402,6 +402,7 @@ struct bpf_func_state {
>>>>    	bool in_callback_fn;
>>>>    	bool in_async_callback_fn;
>>>>    	bool in_exception_callback_fn;
>>>> +	bool no_stack_arg_load;
>>> [ ... ]
>>>
>>>> diff --git a/kernel/bpf/states.c b/kernel/bpf/states.c
>>>> index bd9c22945050..c249eb40c6d6 100644
>>>> --- a/kernel/bpf/states.c
>>>> +++ b/kernel/bpf/states.c
>>>> @@ -833,6 +833,32 @@ static bool stacksafe(struct bpf_verifier_env *env, struct bpf_func_state *old,
>>>>    	return true;
>>>>    }
>>>>
>>>> +/*
>>>> + * Compare stack arg slots between old and current states.
>>>> + * Outgoing stack args are path-local state and must agree for pruning.
>>>> + */
>>>> +static bool stack_arg_safe(struct bpf_verifier_env *env, struct bpf_func_state *old,
>>>> +			   struct bpf_func_state *cur, struct bpf_idmap *idmap,
>>>> +			   enum exact_level exact)
>>>> +{
>>>> +	int i, nslots;
>>>> +
>>>> +	nslots = max(old->out_stack_arg_cnt, cur->out_stack_arg_cnt);
>>>> +	for (i = 0; i < nslots; i++) {
>>>> +		struct bpf_reg_state *old_arg, *cur_arg;
>>>> +		struct bpf_reg_state not_init = { .type = NOT_INIT };
>>>> +
>>>> +		old_arg = i < old->out_stack_arg_cnt ?
>>>> +			  &old->stack_arg_regs[i] : &not_init;
>>>> +		cur_arg = i < cur->out_stack_arg_cnt ?
>>>> +			  &cur->stack_arg_regs[i] : &not_init;
>>>> +		if (!regsafe(env, old_arg, cur_arg, idmap, exact))
>>>> +			return false;
>>>> +	}
>>>> +
>>>> +	return true;
>>>> +}
>>>> +
>>>>    static bool refsafe(struct bpf_verifier_state *old, struct bpf_verifier_state *cur,
>>>>    		    struct bpf_idmap *idmap)
>>>>    {
>>>> @@ -924,6 +950,9 @@ static bool func_states_equal(struct bpf_verifier_env *env, struct bpf_func_stat
>>>>    	if (!stacksafe(env, old, cur, &env->idmap_scratch, exact))
>>>>    		return false;
>>>>
>>>> +	if (!stack_arg_safe(env, old, cur, &env->idmap_scratch, exact))
>>>> +		return false;
>>>> +
>>>>    	return true;
>>>>    }
>>> In v2 (May 7), bot+bpf-ci@kernel.org raised a concern that
>>> no_stack_arg_load is not compared during state pruning in
>>> func_states_equal():
>>>
>>>       "The same issue applies to state pruning: func_states_equal/
>>>       stack_arg_safe does not compare no_stack_arg_load either, so a
>>>       state with no_stack_arg_load=true can be pruned to an old state
>>>       with no_stack_arg_load=false incorrectly. Should no_stack_arg_load
>>>       be placed before stack (to be memcpy'd) or should copy_stack_state()
>>>       explicitly assign it?"
>>>
>>> The field placement was fixed (moving no_stack_arg_load before 'stack'
>>> so it gets copied by memcpy), but func_states_equal() still does not
>>> explicitly compare this field.
>>>
>>> Could this allow incorrect pruning? If a BPF program writes to stack
>>> args and calls a function on one path (setting no_stack_arg_load=true),
>>> then branches and tries to read from stack args on another path, the
>>> verifier might incorrectly prune to the old state with
>>> no_stack_arg_load=false, missing the enforcement that stack arg reads
>>> must happen before writes/calls.
>>>
>>> Looking at func_states_equal():
>>>
>>> kernel/bpf/states.c:func_states_equal() {
>>>       if (!stacksafe(env, old, cur, &env->idmap_scratch, exact))
>>>           return false;
>>>
>>>       if (!stack_arg_safe(env, old, cur, &env->idmap_scratch, exact))
>>>           return false;
>>>
>>>       return true;
>>> }
>>>
>>> Should no_stack_arg_load be compared here, similar to how other boolean
>>> flags in bpf_func_state are handled during state comparison?
>> You are right. The following is an example:
>>
>>     /* subprog with incoming stack arg */
>>     r1 = *(r11+8);         /* read incoming arg, no_stack_arg_load = false */
>>                                                                                                                      
>>     if cond goto path2;
>>                                                                                                                      
>>     path1:
>>       call some_helper;    /* sets no_stack_arg_load = true */
>>       goto join;
>>                                                                                                                      
>>     path2:
>>       /* no call, no_stack_arg_load = false */
>>       goto join;
>>                                                                                                                      
>>     join:
>>       r2 = *(r11+8);       /* read incoming arg again */
>>
>> In the above case, at 'join' point, we have no_stack_arg_load = true and false
>> respectively. In this case, we cannot do pruning.
>>
>> Will fix.
> Hold on. Didn't we agree that any call should scratch all arg slots?
> In the above example call some_helper will scratch it and last read shouldn't be allowed.

You are right.

    join:
      r2 = *(r11+8);       /* read incoming arg again */

is not allowed for path1. We can avoid this no_stack_arg_load
comparison in stack_arg_safe() and later the verifier will reject
at above join point with path1.


