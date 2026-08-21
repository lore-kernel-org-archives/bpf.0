Received: from mta1.migadu.com (out-200.mta1.migadu.com [95.215.58.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB3C1477E51
	for <bpf@vger.kernel.org>; Fri, 21 Aug 2026 10:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787308336; cv=none; b=CJcYX+e/22K9eM/DVJFBjwXAqsUZ//XYE4yGiAze6FSCI0rUphhkcQjdVxhY/3rAs+kxzH3GIRQduku5GXNWvWlKlr1sGvoBB7E97AtJ1TV1L94Q9AtyaW1Y7eqr6DpOGUKBBXqXIrnxEnrLaSSADDftCwKfFUGxEiHC9ipLsZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787308336; c=relaxed/simple;
	bh=vGxALVxYx3q9zXEee3nQ8ja9VdCTQ/P6wNlC27wubIg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DaiB444ZasDfZvRP2k9FUxNnyRBYVDr5jNcTTswYxRennYe0Gh25a/8BbBzFAgDw8qc/0zdkgAZB9//D1nfEz+sF8bOvgyX0WyBvH/kGljxfYuZsGf+8KSNxtagr1rGEwnbeCjuAdAs2yCz+C5n6w+QROEeDcmIIvQT85yZL2O4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=TUugIQ8h; arc=none smtp.client-ip=95.215.58.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="TUugIQ8h"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=vGxALVxYx3q9zXEee3nQ8ja9VdCTQ/P6wNlC27wubIg=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787308328; v=1; x=1787913128;
 b=TUugIQ8h2tM82VRHIvFcFoWt2O//dmEWSkbIFhvN8ItH/FCGumv/0G4Y5s99ATCmAYLwic3X
 4T3/hp8rRrZHn+WhS6u55cgxfFwJOSpB/ozAgbGKe97LNsUzwVmaQdyhJC1D3fuDtMkZwBTWdmu
 H9oizclQHmYFgp14YGsLg75w=
X-Envelope-To: bpf@vger.kernel.org
Received: from [10.54.25.56] (210.22.144.162)
	by smtp.migadu.com with ESMTPS id fb7e5c527d70a055;
	Fri, 21 Aug 2026 10:32:07 +0000
X-Mizu-Trace-ID: fb7e5c527d70a055
X-Migadu-Flow: FLOW_OUT
Message-ID: <44f56d87-14eb-4fb8-bade-09c94aa0952b@linux.dev>
Date: Fri, 21 Aug 2026 18:31:55 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v4 2/4] bpf: arena: allocate the fault-in page
 outside the lock
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org
Cc: emil@etsalapatis.com, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com,
 martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
 jolsa@kernel.org, ihor.solodrai@linux.dev, linux-kernel@vger.kernel.org,
 martin.lau@kernel.org, clm@meta.com
References: <20260821050631.39784-2-jiayuan.chen@linux.dev>
 <b951553281d4e1491647aad4c4c0a8fac03d6b78ecac351fd216888eaae6ce72@mail.kernel.org>
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <b951553281d4e1491647aad4c4c0a8fac03d6b78ecac351fd216888eaae6ce72@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 8/21/26 1:59 PM, bot+bpf-ci@kernel.org wrote:
>> diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
>> index 7b6847200b43..50dac9ba0f5e 100644
>> --- a/kernel/bpf/arena.c
>> +++ b/kernel/bpf/arena.c
> [ ... ]
>
>> @@ -489,59 +490,108 @@ static vm_fault_t arena_vm_fault(struct vm_fault *vmf)
>>   	kbase = bpf_arena_get_kern_vm_start(arena);
>>   	kaddr = kbase + (u32)(vmf->address);
>>
>> +	page = vmalloc_to_page((void *)kaddr);
>> +	if (!page && !(arena->map.map_flags & BPF_F_SEGV_ON_FAULT)) {
>> +		/*
>> +		 * We run in process context here, so preallocate the page
>> +		 * outside the lock with an explicitly sleepable allocator. It
>> +		 * can then go through reclaim (both memcg and global) and the
>> +		 * OOM path, the way do_anonymous_page() does; under
>> +		 * arena->spinlock only the non-blocking allocator is available,
>> +		 * which never reclaims. That also decides the return value:
>> +		 * VM_FAULT_OOM below is only meaningful if the OOM machinery was
>> +		 * actually engaged, which the non-blocking allocator never does.
>> +		 */
>> +		bpf_map_memcg_enter(&arena->map, &old_memcg, &new_memcg);
>> +		new_page = bpf_map_alloc_page_sleepable(map);
>> +		bpf_map_memcg_exit(old_memcg, new_memcg);
>> +		if (!new_page)
>> +			return VM_FAULT_OOM;
>> +	}
> Can this return VM_FAULT_OOM when the allocation is charged to a foreign
> memcg?
>
> The preallocation charges the arena creator's memcg, not current's:
>
>      bpf_map_memcg_enter(&arena->map, &old_memcg, &new_memcg);
>      /* set_active_memcg(bpf_map_get_memcg(map)) */
>
>      new_page = bpf_map_alloc_page_sleepable(map);
>      /* GFP_KERNEL|__GFP_ZERO|__GFP_ACCOUNT|__GFP_NOWARN */
>
> For an order-0 GFP_KERNEL allocation the only realistic NULL is a memcg
> charge rejection. mem_cgroup_oom() calls out_of_memory() with oom_control
> pointing at the arena owner's memcg, so the OOM killer can only select
> victims inside that cgroup.
>
> VM_FAULT_OOM reaches pagefault_out_of_memory() (mm/oom_kill.c:1180-1193),
> which only resolves current->memcg_in_oom; otherwise it prints the
> rate-limited "Huh VM_FAULT_OOM leaked out to the #PF handler. Retrying PF"
> message and returns. Because the over-limit memcg is foreign, killing
> tasks there never makes fatal_signal_pending(current) true, so
> try_charge_memcg()'s force-charge escape hatch never fires.
>
> If the owner memcg's charge is dominated by memory its tasks cannot free
> (for example the arena's own pages, which are only freed by the bpf program
> or by map destruction and are unreclaimable), or if that cgroup has no
> OOM-eligible tasks left, mem_cgroup_oom() returns false, try_charge_memcg()
> returns -ENOMEM, and the instruction is retried in a loop.
>
> This creates an unbounded fault/retry livelock burning CPU in the faulting
> task plus dmesg spam, where the pre-image returned a bounded
> VM_FAULT_SIGSEGV. Before this patch the in-lock allocator never engaged
> reclaim or the OOM killer, so a user touching an arena page could not kill
> anything. Now any task that can mmap the arena (the fd can be passed via
> SCM_RIGHTS or a bpffs pin, so the faulting task need not be in the owner's
> cgroup at all) can drive the memcg OOM killer in the owner's cgroup one
> task at a time simply by faulting in pages.


Thanks, you're right — this is a real bug, and I could reproduce it.

The root cause is simply that we return VM_FAULT_OOM.

That return value does nothing useful for arena: all reclaim and OOM 
handling (both memcg and global) already happens inside

bpf_map_alloc_page_sleepable().


The fix is to return VM_FAULT_SIGBUS instead of VM_FAULT_OOM.

