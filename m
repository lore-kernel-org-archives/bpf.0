Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EA30470E8F;
	Thu, 23 Jul 2026 10:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784800965; cv=none; b=C/HuGEqF/mee0k57GLGwGGJZunVDZyC12HfI7IMNm+z4GUSzjH5Zs8Dab+KLCDs4V3f3FND6ZDueiGaAziogqE604MqvZOsbLmxlWBgAZgID82tzg/Sw5ntMbT9RC2QlrTp7K885+lfKM/SFdpcykybbwi0E+4GfRM3Ep508a0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784800965; c=relaxed/simple;
	bh=3/S4sZ1lP9S368o47YJ/Ut/fgfnwdDGJKm1aK0A30Os=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K/1BtqzRUuBtAZjbhUBjOeuW+DhvPR84kQ0GFao4gO15zIF8NYL22+7ZjkL1zPJLLu4p3T0kzuQEDtxLPSnYOEgJWTMTunsWGttwO2nztIfZj81sbvw1kn/665QviGxYGcdInnuaP403p3SYQYxfUfE5+FC8JZWbsVY/re/Nz+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VmCGdwGc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VmCGdwGc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75C291F000E9;
	Thu, 23 Jul 2026 10:02:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784800963;
	bh=OQDCcqAtkKIaA7PAicNNEulvCZqNBi166nyjyG6ifdQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=VmCGdwGcxfc0JJqakuXb4uaNVeu3Xxo4n4vFZ7/QYziHmz/+CCOwyTK5dYhPp/Ab3
	 tN1+O1CxJxaMShrDBLV82a/uW1UioZk8Ee6ZmJM9CVdGIzgs7obyXYrIGB8T92GQYI
	 BM9FAdGhSOjrhsN7+qlHSZ/ur6eXzhbxLDXlV/A5dq5ffSjukgOzSpn2PMYTHK1ssy
	 feVY+xOx3HST7jUBenoxc8LyxR0v8QDshWsog3QBIqaz1jsTznyKVxV/E/yeh6dQor
	 MznQxLotcdfiYdotXyFj7f08oVVLaITdDA0QgGb9HnnbK7L9uiN0dhECg4qIz4y8wW
	 j+eE9btAF19IQ==
Message-ID: <60c1dbf3-3212-40f9-90c9-56aefdea5f1a@kernel.org>
Date: Thu, 23 Jul 2026 19:02:40 +0900
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH slab/for-next v4 5/8] mm/slab: allow kfree_rcu_sheaf() on
 PREEMPT_RT
To: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>,
 sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org, linux-rt-devel@lists.linux.dev,
 linux-kernel@vger.kernel.org, hao.li@linux.dev
References: <20260720-kfree_rcu_nolock-v4-0-964e03c41a4e@kernel.org>
 <20260720-kfree_rcu_nolock-v4-5-964e03c41a4e@kernel.org>
 <20260720125637.129D01F00A3A@smtp.kernel.org>
 <1c7ce106-c5b0-4689-8c24-b32a0966eb02@kernel.org>
 <a8dc9a6b-a08c-426a-9a92-30a4014e2446@kernel.org>
Content-Language: en-US
From: Harry Yoo <harry@kernel.org>
In-Reply-To: <a8dc9a6b-a08c-426a-9a92-30a4014e2446@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/23/26 6:46 PM, Vlastimil Babka (SUSE) wrote:
> On 7/23/26 07:39, Harry Yoo wrote:
>> On 7/20/26 9:56 PM, sashiko-bot@kernel.org wrote:
>>>
>>>> diff --git a/mm/slub.c b/mm/slub.c
>>>> index 8afa6b47b1f2b..deac315d0f23e 100644
>>>> --- a/mm/slub.c
>>>> +++ b/mm/slub.c
>>> [ ... ]
>>>> @@ -6080,10 +6081,10 @@ bool __kfree_rcu_sheaf(struct kmem_cache *s, void *obj, unsigned int free_flags)
>>>>  	struct slab_sheaf *rcu_sheaf;
>>>>  	bool allow_spin = free_flags_allow_spinning(free_flags);
>>>>  
>>>> -	if (WARN_ON_ONCE(IS_ENABLED(CONFIG_PREEMPT_RT)))
>>>> -		return false;
>>>> +	VM_WARN_ON_ONCE(IS_ENABLED(CONFIG_PREEMPT_RT) && allow_spin);
>>>>  
>>>> -	lock_map_acquire_try(&kfree_rcu_sheaf_map);
>>>> +	if (!IS_ENABLED(CONFIG_PREEMPT_RT))
>>>> +		lock_map_acquire_try(&kfree_rcu_sheaf_map);
>>>>  
>>>>  	if (!local_trylock(&s->cpu_sheaves->lock))
>>>              ^^^^^^^^^^^^^
>>> [Severity: High]
>>> This is a pre-existing issue, but since we are enabling this path for
>>> PREEMPT_RT, does the use of GFP_NOWAIT later in this function cause
>>> lock recursion deadlocks?
>>>
>>> When the fast path fails, __kfree_rcu_sheaf() calls:
>>>
>>>     empty = alloc_empty_sheaf(s, GFP_NOWAIT, alloc_flags);
>>>
>>> GFP_NOWAIT includes __GFP_KSWAPD_RECLAIM, which invokes wakeup_kswapd().
>>> The wake-up path enters the scheduler via try_to_wake_up() and attempts to
>>> acquire scheduler locks like pi_lock and the runqueue lock.
>>
>> This indeed looks like a real issue as kfree_rcu() can be called under
>> scheduler locks,
> 
> Are there any paths that actually do that?

in kernel/sched/core.c:

	/*
	 * Because this is called with p->pi_lock held, it is not possible
	 * to use kfree() here (when PREEMPT_RT=y), therefore punt to using
	 * kfree_rcu().
	 */
	kfree_rcu((union cpumask_rcuhead *)ac.user_mask, rcu);

...and try_to_wake_up acquires pi_lock.

So I'm bit puzzled :)

>> but not sure how it's been undiscovered for this long?
> 
> With kfree_rcu_sheaf_map we prevent the raw spinlock nesting detection in
> general.

Yeah. It only overrides wait type (and tell lockdep
that it is okay to acquire a spinlock, although we're holding a raw
spinlock).

> But I guess if there was an actual kfree_rcu() call under any
> scheduler lock involved in wakeup_kswapd(), lockdep would still trigger, right?

I was assuming so, but there is one!

...I guess we should look at when the path is executed.

>>> If kvfree_call_rcu() was called while the CPU already holds these scheduler
>>> locks, will this wake-up attempt cause a lock recursion self-deadlock?

-- 
Cheers,
Harry / Hyeonggon
