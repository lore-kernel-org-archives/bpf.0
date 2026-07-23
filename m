Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52EF142BC56;
	Thu, 23 Jul 2026 09:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784799974; cv=none; b=a5LnstnXTJwziqPP9ozi+aO5RtqfDIW4tSkyc0xceROQ6bs9L2DKV8Xa0n+/yLFURoelc7IIaszISwrWQAumaO5Gf12c6NTxqgRM2B7JNP60XKVdtI+aX0HYg/iKaq/xdpUon1EH4F0jU63Yi1mueEq1KbllrXbNF98HE9p8gZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784799974; c=relaxed/simple;
	bh=NitLufdE/4i0EaywdulcGJUyybW1WobriDxx0kW0zuw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aWCtqND6MYdYJU5O6xOgtC8PI+EIjX5zXM+oTBo29RMMiiNuHPIezvxDkdNS3uFnYXyQ99ceJVeIkeh31sCnQfUr+T8hzNV4GyyLrNsaQhEJMxUcFRmcQrZOKKRW3+UUVBlfN3MgZ0eJpAxeGFqfWckE18YgDqqbRUahICPsLlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a8lBic8b; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a8lBic8b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 928321F000E9;
	Thu, 23 Jul 2026 09:46:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784799971;
	bh=aQoLo96zw0hxxBrNcRicMtUhLwVl+yi3CsLLfhJfpPY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=a8lBic8br0xTW38lbZuPJ1DFrHJ8Y8LS6+VHPO0N36kvB/eF5J14iY2vjWqpj+Daf
	 gYHlVlYLJ7kXnczCN0bXXoGs5as9D7H3Sqb6jQxicxySwAlbFvY0vmJoFtdNLY0D1o
	 RvphI1iVHFattz/PKtKSHR4jtKRorsH2ODMNLLsUg7/dRIH7fcGl4tYudyFmT0WiqJ
	 GLOheMJRIrOi3zM1pH+xTgIx3AbNzQ8IJ1307cIFEU2dDpkKmTQVLO0olOpus/cmO6
	 plcsQ3lU426dgBkTclS3U6r1GAc+O/IzzS4H3ihJBWCwr9TVSo2S6AsveSrExeCpzx
	 nAy5I/c6mkhhA==
Message-ID: <a8dc9a6b-a08c-426a-9a92-30a4014e2446@kernel.org>
Date: Thu, 23 Jul 2026 11:46:08 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH slab/for-next v4 5/8] mm/slab: allow kfree_rcu_sheaf() on
 PREEMPT_RT
Content-Language: en-US
To: Harry Yoo <harry@kernel.org>, sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org, linux-rt-devel@lists.linux.dev,
 linux-kernel@vger.kernel.org, hao.li@linux.dev
References: <20260720-kfree_rcu_nolock-v4-0-964e03c41a4e@kernel.org>
 <20260720-kfree_rcu_nolock-v4-5-964e03c41a4e@kernel.org>
 <20260720125637.129D01F00A3A@smtp.kernel.org>
 <1c7ce106-c5b0-4689-8c24-b32a0966eb02@kernel.org>
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Autocrypt: addr=vbabka@kernel.org; keydata=
 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
In-Reply-To: <1c7ce106-c5b0-4689-8c24-b32a0966eb02@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/23/26 07:39, Harry Yoo wrote:
> On 7/20/26 9:56 PM, sashiko-bot@kernel.org wrote:
>> 
>>> diff --git a/mm/slub.c b/mm/slub.c
>>> index 8afa6b47b1f2b..deac315d0f23e 100644
>>> --- a/mm/slub.c
>>> +++ b/mm/slub.c
>> [ ... ]
>>> @@ -6080,10 +6081,10 @@ bool __kfree_rcu_sheaf(struct kmem_cache *s, void *obj, unsigned int free_flags)
>>>  	struct slab_sheaf *rcu_sheaf;
>>>  	bool allow_spin = free_flags_allow_spinning(free_flags);
>>>  
>>> -	if (WARN_ON_ONCE(IS_ENABLED(CONFIG_PREEMPT_RT)))
>>> -		return false;
>>> +	VM_WARN_ON_ONCE(IS_ENABLED(CONFIG_PREEMPT_RT) && allow_spin);
>>>  
>>> -	lock_map_acquire_try(&kfree_rcu_sheaf_map);
>>> +	if (!IS_ENABLED(CONFIG_PREEMPT_RT))
>>> +		lock_map_acquire_try(&kfree_rcu_sheaf_map);
>>>  
>>>  	if (!local_trylock(&s->cpu_sheaves->lock))
>>              ^^^^^^^^^^^^^
>> [Severity: High]
>> This is a pre-existing issue, but since we are enabling this path for
>> PREEMPT_RT, does the use of GFP_NOWAIT later in this function cause
>> lock recursion deadlocks?
>> 
>> When the fast path fails, __kfree_rcu_sheaf() calls:
>> 
>>     empty = alloc_empty_sheaf(s, GFP_NOWAIT, alloc_flags);
>> 
>> GFP_NOWAIT includes __GFP_KSWAPD_RECLAIM, which invokes wakeup_kswapd().
>> The wake-up path enters the scheduler via try_to_wake_up() and attempts to
>> acquire scheduler locks like pi_lock and the runqueue lock.
> 
> This indeed looks like a real issue as kfree_rcu() can be called under
> scheduler locks,

Are there any paths that actually do that?

> but not sure how it's been undiscovered for this long?

With kfree_rcu_sheaf_map we prevent the raw spinlock nesting detection in
general. But I guess if there was an actual kfree_rcu() call under any
scheduler lock involved in wakeup_kswapd(), lockdep would still trigger, right?

>> If kvfree_call_rcu() was called while the CPU already holds these scheduler
>> locks, will this wake-up attempt cause a lock recursion self-deadlock?
>> 
> 

