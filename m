Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC7103C6A41
	for <bpf@vger.kernel.org>; Fri, 17 Jul 2026 09:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784280916; cv=none; b=VTcVAVbgTMo4RSUM9WROdTc8DQottZnjXjdJZEgDjTBP0uRTiBBPvdds7jO6+VsjpSWEJSnoAH8sV5xRdK+4mnoUL3hciednBDv+mf3XOqTCMzc3YjPkcBEd6xnfdYtEDsqKmKmOofd42KkF8Fu1bToHrIXjcgJ4d400LIV8afg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784280916; c=relaxed/simple;
	bh=clqIW9dle+lLxG0Clq/Jah5PH8VRyVxz4x/oh82GEiw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y7Ovpk1f3ENjXL4/I5HLfy+EohOJb5W+El36nx3Qu5CTnNZ0c6QAum2P/yd91apkhwatLTs92G8U7CsuaQuZFgF+CGMcVmdqc7xVK9viLkNPQ0NVxcGJI4biDil8d28rR8q9DfUpsoAfsGv82MsmduIHCMH6Ah0oJZ6lKkdKYFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=APxq7EWU; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="APxq7EWU"
Message-ID: <fc4d40aa-d466-4cdc-9007-2c07abc2c115@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784280913;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NmS7qe7hADr1RIiS3KezcjLV12JdH4+RZxjZBtVNZ38=;
	b=APxq7EWUY3z8qT+BVAgk+0dCCF3wRfJ8eiBkLw4s8+2bRGzOHYsARq4kpqGg0jUqtVA7qv
	BdQTrKS4NfvqhH51Lbm4LkBmdk6Ldz96iSexSRuQz9kXi0PgB6zFN/2CtNH1Xyipi56y7Z
	v3oxHFTLYyrVW4eKAreN65XCrilxq28=
Date: Fri, 17 Jul 2026 17:34:47 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 1/3] bpf: Add memory usage for arena
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260716142746.8794-1-jiayuan.chen@linux.dev>
 <20260716144840.3DE1F1F00A3A@smtp.kernel.org>
 <50c2d308-cfed-41bb-9084-54e380463ad2@linux.dev>
 <DK0QKAJXN3KI.2KJ3LLPYKTXGE@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <DK0QKAJXN3KI.2KJ3LLPYKTXGE@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 7/17/26 5:24 PM, Kumar Kartikeya Dwivedi wrote:
> On Fri Jul 17, 2026 at 4:08 AM CEST, Jiayuan Chen wrote:
>> On 7/16/26 10:48 PM, sashiko-bot@kernel.org wrote:
>>> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
>>>
>>> New issues:
>>> - [Medium] The `nr_pages` counter is modified using plain writes while being read concurrently locklessly, constituting a data race.
>>>
>>> Pre-existing issues:
>>> - [High] Functions that can sleep and acquire sleepable locks are called while holding a raw spinlock with interrupts disabled.
>>> --
>>>
>>> --- Patch [1]: [PATCH bpf-next 1/3] bpf: Add memory usage for arena ---
>>> commit 68cbc4739a7a9be56d49db779d319ec002523097
>>> Author: Jiayuan Chen <jiayuan.chen@linux.dev>
>>> Subject: bpf: Add memory usage for arena
>>>
>>> This patch adds memory usage tracking for the arena map type by counting
>>> the pages mapped into the arena. It bumps a counter in apply_range_set_cb()
>>> when a page is added, drops it in apply_range_clear_cb() when removed, and
>>> returns the calculated usage in map_mem_usage().
>>>
>>>> diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
>>>> index 80b7b8a694464..bc34602116040 100644
>>>> --- a/kernel/bpf/arena.c
>>>> +++ b/kernel/bpf/arena.c
>>> [ ... ]
>>>
>>>> @@ -196,6 +198,7 @@ static int apply_range_set_cb(pte_t *pte, unsigned long addr, void *data)
>>>>    	set_pte_at(&init_mm, addr, pte, pteval);
>>>>    #endif
>>>>    	d->i++;
>>>> +	d->arena->nr_pages++;
>>>>    	return 0;
>>>>    }
>>> [Severity: Medium]
>>> Is it safe to use a plain increment here since nr_pages is read concurrently?
>>>
>>> In arena_map_mem_usage(), arena->nr_pages is read locklessly via
>>> READ_ONCE(arena->nr_pages). The Linux Kernel Memory Model requires that writes
>>> pairing with a lockless READ_ONCE must be marked with WRITE_ONCE to prevent
>>> the compiler from splitting the writes or assuming no concurrent access.
>>>
>>> Could this lead to incorrect statistics or torn writes?
>>>
>>> [ ... ]
>>>
>>>> @@ -227,10 +230,11 @@ static int apply_range_clear_cb(pte_t *pte, unsigned long addr, void *data)
>>>>    	 * scratches its PTE. A later bpf_arena_free_pages() over that range walks
>>>>    	 * here. Without the skip, scratch_page would be freed.
>>>>    	 */
>>>> -	if (page == d->scratch_page)
>>>> +	if (page == d->arena->scratch_page)
>>>>    		return 0;
>>>>
>>>>    	__llist_add(&page->pcp_llist, d->free_pages);
>>>> +	d->arena->nr_pages--;
>>> [Severity: Medium]
>>> Similar to the increment above, does this plain decrement need WRITE_ONCE() to
>>> safely pair with the READ_ONCE() in arena_map_mem_usage()?
>> It's true.
>>
>>
> Overall seems ok to me, since you are going to resend, could you also split the
> changes to move remove scratch page field into a prep patch before adding
> nr_pages?
>
> Thanks!

Thanks for your review.

I will do it.

