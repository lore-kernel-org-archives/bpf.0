Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CE963CB548
	for <bpf@vger.kernel.org>; Mon, 27 Jul 2026 08:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785139266; cv=none; b=IvYM4tJdsflRkad8FKqjnTovRQmqCIlgU9MhhEtq/iWKlF15mWAtigZaSqG6IgATzdeJ+HE6ZWOSZ21E8PbhfidC9wkhAZb99lZAPAnwdYtMSSQPysFUbw0xbVEpjzN33mRBNIiBNm4ZHRz55Ns2QQSQYTM6CoxhWQhxKpkAc1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785139266; c=relaxed/simple;
	bh=BFO10sMHX81uroVNFUc1FnB5adRwpZpKF4tLCFZQf5Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U/FmkB/TztSns+QoW5CIv2eShC1ygKFwy33FROGXkS6ZHn45FudNOETeHJQiYDHXlPU4UmDjkHb7W5oMlEYZG1CWSKM8b/0PZy8Y21G5NnpYPjSMS5PP1iaZzxRJBgaaLK45ITNUIu7cMVoqF3tAnqbd53orK6OXhHG33N1Wx4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=namaSkB1; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="namaSkB1"
Message-ID: <9a961b42-d095-4052-a749-dfabb9a45bf3@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1785139252;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dtpjon/BpvDyzvwfWw7MZxTAVhL5AfZXQA29No/Azgg=;
	b=namaSkB15KmGyr/imjdjaj6uTynOCo7i7aJkHOuhXOuageGT6Uqp7CLSV0KZJvdCPLjtFH
	h6uCOUpHv9IJJ7/AccFOOeXkPr7ktjSCRhM53myKoFgwXnVPFsq3LgzH8Ly0fXN/qyWlFa
	KgfUrEO84d/bVVjcb0nQF5iXmhXYsnY=
Date: Mon, 27 Jul 2026 16:00:24 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 2/3] bpf: arena: allocate the fault-in page
 outside the lock
To: sashiko-reviews@lists.linux.dev
Cc: linux-rt-devel@lists.linux.dev, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260727062521.376231-1-jiayuan.chen@linux.dev>
 <20260727062521.376231-3-jiayuan.chen@linux.dev>
 <20260727064257.01BD81F000E9@smtp.kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <20260727064257.01BD81F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 7/27/26 2:42 PM, sashiko-bot@kernel.org wrote:
[...]
>> @@ -489,55 +490,97 @@ static vm_fault_t arena_vm_fault(struct vm_fault *vmf)
>>   	kbase = bpf_arena_get_kern_vm_start(arena);
>>   	kaddr = kbase + (u32)(vmf->address);
>>   
>> -	if (raw_res_spin_lock_irqsave(&arena->spinlock, flags))
>> +	page = vmalloc_to_page((void *)kaddr);
>> +	if (!page) {
>> +		/*
>> +		 * Preallocate outside the lock so the allocation can sleep and go
>> +		 * through reclaim (both memcg and global), the way do_anonymous_page()
>> +		 * does. Under arena->spinlock only the non-blocking allocator is
>> +		 * available, which never reclaims.
>> +		 *
>> +		 * This has to be the sleepable variant: VM_FAULT_OOM below is only
>> +		 * meaningful if the OOM machinery was actually engaged. A failure
>> +		 * from the non-blocking allocator engages nothing, so the fault
>> +		 * would be retried forever.
>> +		 */
>> +		bpf_map_memcg_enter(&arena->map, &old_memcg, &new_memcg);
>> +		new_page = bpf_map_alloc_page_sleepable(map, NUMA_NO_NODE);
> [Severity: High]
> Is there a potential Denial of Service vector when BPF_F_SEGV_ON_FAULT is set?
>
> This unconditionally preallocates a page using
> bpf_map_alloc_page_sleepable() before checking the BPF_F_SEGV_ON_FAULT
> flag later in the function.
>
> This allocation can block, trigger direct memory reclaim, and invoke the
> OOM killer. Only after this expensive allocation does the code lock, check
> the flag, return VM_FAULT_SIGSEGV, and discard the page.
>
> Could this allow an unprivileged user to force severe memory pressure by
> repeatedly triggering page faults on unallocated addresses?

Once VM_FAULT_SIGSEGV is returned, the process gets a SIGSEGV and by 
default is killed,
so this isn't a realistic DoS.

But, I think it's worth moving the "arena->map.map_flags & 
BPF_F_SEGV_ON_FAULT" check before the allocation.


>> +		bpf_map_memcg_exit(old_memcg, new_memcg);
>> +		if (!new_page)
>> +			return VM_FAULT_OOM;
>> +	}
>> +
>> +	if (raw_res_spin_lock_irqsave(&arena->spinlock, flags)) {
>>   		/* Make a reasonable effort to address impossible case */
>> -		return VM_FAULT_RETRY;
>> +		fault_ret = VM_FAULT_RETRY;
>> +		goto out_err;
>> +	}
> [Severity: High]
> This is a pre-existing issue, but does returning VM_FAULT_RETRY here
> without releasing the fault lock cause a lock leak?
>
> The memory management subsystem strictly assumes the lock was released
> if VM_FAULT_RETRY is returned. Retrying the fault will leak the read lock
> reference, and if any thread subsequently attempts to acquire the mmap_lock
> for writing, the system could permanently deadlock.


Yes, it's true. arena_vm_fault() never touches mmap_lock, so returning 
VM_FAULT_RETRY violates the contract.

'''
do_user_addr_fault()
{
     fault = handle_mm_fault(...);          // call arena_vm_fault
     ...
     if (unlikely(fault & VM_FAULT_RETRY)) {
         flags |= FAULT_FLAG_TRIED;
         goto retry;                    // lock_mm_and_find_vma() will 
call mmap_read_lock again !
     }
     mmap_read_unlock(mm);
}
'''

I think I should fix it as a separate patch with high priority ?


