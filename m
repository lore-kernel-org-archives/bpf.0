Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7B342E06EF
	for <bpf@vger.kernel.org>; Tue, 28 Jul 2026 06:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785220394; cv=none; b=VJsMXkCZEwD3aXNw2mJhauTPUo/tytrLmZ+sYEXJS3ma0YQXOe7i9GbgUglstV2jO7GO2OP08ugN/gFoX+zQXMlj3wrYJ5o4xKClK17VesHOpdOdbFpA1bDFrM4hricBgIIL5nJNtLSrepr1YQkY8wmfs9M+51LQ5L5rsyAlIF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785220394; c=relaxed/simple;
	bh=/Q4ifderT4hgMA2eKv9t7NI6l8LxDAxGztxN2WsqlpI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EwBH4Rkb3Ay7AAwfAr20Qo2mbwlxhFzA3DFpEU2tieq05dD6yHW13dek7OTditnMcO31FsmjcodX1JNRhoam6iddJGcnX1lbA11Ri417SQN4J7v9zHTZLTvLNDio2qD/HpC0JGwJFtQCJ+yGB4nULWze5KLbhHEdT7p1I5DTZFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=LYrQLgRy; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="LYrQLgRy"
Message-ID: <80b2e0fb-ef66-4b3e-9436-9dbcaa022d19@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1785220380;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+ReBaCmFPvWJ0y4l7kaBFutT+YEYdORA3Xpxp0I/2n4=;
	b=LYrQLgRylc9KnN0r96b0XEyGNLfZv1qMJs7ZELPlCf3pv6TvZb/6EVOtYmG8tk7ncZ3m/x
	ivnUa3/ERVsawecynqxG8f2buayjENVaV0x7en0WeFyzx48aHUTSSzu+hvcGDm5YM7IEtX
	6HGfkcRwnbSIqWLHVPQLdwr9XGxcu60=
Date: Tue, 28 Jul 2026 14:32:44 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next] bpf: arena: fix mmap_lock deadlock on arena lock
 failure
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260728060517.95183-1-jiayuan.chen@linux.dev>
 <20260728062332.806161F000E9@smtp.kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <20260728062332.806161F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 7/28/26 2:23 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
>
> Pre-existing issues:
> - [High] BPF arena page faults can spuriously crash the user process with SIGSEGV due to transient lockless allocation failures.
> --
>
> --- Patch [1]: [PATCH bpf-next] bpf: arena: fix mmap_lock deadlock on arena lock failure ---
> commit c57623f4077e743e8c901306fcec7c67d2aafc17
> Author: Jiayuan Chen <jiayuan.chen@linux.dev>
>
> bpf: arena: fix mmap_lock deadlock on arena lock failure
>
> This commit fixes a potential deadlock in the arena page fault handler by
> returning VM_FAULT_SIGBUS instead of VM_FAULT_RETRY when the arena spinlock
> cannot be acquired. Returning retry would cause the fault path to attempt
> retaking the mmap_lock, which was never dropped.
>
>> diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
>> --- a/kernel/bpf/arena.c
>> +++ b/kernel/bpf/arena.c
>> @@ -490,8 +490,12 @@ static vm_fault_t arena_vm_fault(struct vm_fault *vmf)
>>   	kaddr = kbase + (u32)(vmf->address);
>>   
>>   	if (raw_res_spin_lock_irqsave(&arena->spinlock, flags))
>> -		/* Make a reasonable effort to address impossible case */
>> -		return VM_FAULT_RETRY;
>> +		/*
>> +		 * A failed lock means a possible deadlock was detected. Don't
>> +		 * return VM_FAULT_RETRY: this handler never took mmap_lock, but
>> +		 * the fault path would re-take it on retry and deadlock. Fail.
>> +		 */
>> +		return VM_FAULT_SIGBUS;
> [Severity: High]
> This is a pre-existing issue, but looking further down in arena_vm_fault(),
> does a transient allocation failure unexpectedly cause a SIGSEGV?
>
> Since the raw spinlock is held, disabling IRQs, bpf_map_alloc_pages()
> falls back to an opportunistic lockless allocation which can fail under
> memory pressure:
>
> 	ret = bpf_map_alloc_pages(map, NUMA_NO_NODE, 1, &page);
> 	if (ret) {
> 		range_tree_set(&arena->rt, vmf->pgoff, 1);
> 		goto out_sigsegv_memcg;
> 	}
>
> When this lockless allocation fails, the error path jumps to
> out_sigsegv_memcg and returns VM_FAULT_SIGSEGV instead of VM_FAULT_OOM or
> safely dropping the lock to retry.
>
> Could this cause user processes mapping a BPF arena to experience spurious
> crashes during memory contention?


Yes I'm on it 
https://lore.kernel.org/bpf/20260727062521.376231-1-jiayuan.chen@linux.dev/

And current patch is from your review result of that patch...

