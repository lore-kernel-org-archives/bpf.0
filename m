Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C314B43F093
	for <bpf@vger.kernel.org>; Fri, 17 Jul 2026 02:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784254105; cv=none; b=KOLuUbhitryrH0WoHR+cTYin2YDros5i2XyOxn3hBu2SX4U7mWJ9D0O/m/aeWLh1ksw/HRkVmgi2OKDlihqpdS0Hp4Yb0WodrdLUG+4R6Iq+82HUhoXS965wTqyQHjgGiw0Z+lb2b+OGK0d3Er25lgX2D9knPmCwEzWDygbCy6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784254105; c=relaxed/simple;
	bh=By3FimZceyxGDktINDq9g2IrqhxlFRDBNtG+uonqiis=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W383J+Vu/p3hJGISwxtSG7wqWWk8ZCOPu4kxHt67Q37c+mCmaBD4+vPJgxTxXye5qJ4I8bZdXWehGF9D85ZG4SDp3SXzNDagw0Vla7psRhEr97b9ebSQak/RBbQqESLyTEfZuuDXNPRyXoRLie7WoX5mNOm2oXqRixUyk24AhYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=UxetImme; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="UxetImme"
Message-ID: <50c2d308-cfed-41bb-9084-54e380463ad2@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784254091;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ut/bn6tdhBjZ2U2t5bilQwjTZNYcf8S/FU1sHi3PRTA=;
	b=UxetImmeMTy5r1AYTSDL9wpcQq8iz7sKP2lWQiRcVORWAiqdOdlpRQX/O9IBfrqtPfaW2/
	6OIUBHp/83de+2HKv3EehAta6d62yMLQIjDERGjlv3CSBq9U6pfwYlKohDGK8odOf9U3qM
	+n3uTtrrzJ/QW0cFomXHU3DW6b0xdbY=
Date: Fri, 17 Jul 2026 10:08:04 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 1/3] bpf: Add memory usage for arena
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260716142746.8794-1-jiayuan.chen@linux.dev>
 <20260716144840.3DE1F1F00A3A@smtp.kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <20260716144840.3DE1F1F00A3A@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 7/16/26 10:48 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
>
> New issues:
> - [Medium] The `nr_pages` counter is modified using plain writes while being read concurrently locklessly, constituting a data race.
>
> Pre-existing issues:
> - [High] Functions that can sleep and acquire sleepable locks are called while holding a raw spinlock with interrupts disabled.
> --
>
> --- Patch [1]: [PATCH bpf-next 1/3] bpf: Add memory usage for arena ---
> commit 68cbc4739a7a9be56d49db779d319ec002523097
> Author: Jiayuan Chen <jiayuan.chen@linux.dev>
> Subject: bpf: Add memory usage for arena
>
> This patch adds memory usage tracking for the arena map type by counting
> the pages mapped into the arena. It bumps a counter in apply_range_set_cb()
> when a page is added, drops it in apply_range_clear_cb() when removed, and
> returns the calculated usage in map_mem_usage().
>
>> diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
>> index 80b7b8a694464..bc34602116040 100644
>> --- a/kernel/bpf/arena.c
>> +++ b/kernel/bpf/arena.c
> [ ... ]
>
>> @@ -196,6 +198,7 @@ static int apply_range_set_cb(pte_t *pte, unsigned long addr, void *data)
>>   	set_pte_at(&init_mm, addr, pte, pteval);
>>   #endif
>>   	d->i++;
>> +	d->arena->nr_pages++;
>>   	return 0;
>>   }
> [Severity: Medium]
> Is it safe to use a plain increment here since nr_pages is read concurrently?
>
> In arena_map_mem_usage(), arena->nr_pages is read locklessly via
> READ_ONCE(arena->nr_pages). The Linux Kernel Memory Model requires that writes
> pairing with a lockless READ_ONCE must be marked with WRITE_ONCE to prevent
> the compiler from splitting the writes or assuming no concurrent access.
>
> Could this lead to incorrect statistics or torn writes?
>
> [ ... ]
>
>> @@ -227,10 +230,11 @@ static int apply_range_clear_cb(pte_t *pte, unsigned long addr, void *data)
>>   	 * scratches its PTE. A later bpf_arena_free_pages() over that range walks
>>   	 * here. Without the skip, scratch_page would be freed.
>>   	 */
>> -	if (page == d->scratch_page)
>> +	if (page == d->arena->scratch_page)
>>   		return 0;
>>   
>>   	__llist_add(&page->pcp_llist, d->free_pages);
>> +	d->arena->nr_pages--;
> [Severity: Medium]
> Similar to the increment above, does this plain decrement need WRITE_ONCE() to
> safely pair with the READ_ONCE() in arena_map_mem_usage()?

It's true.


> [ ... ]
>
>> @@ -506,8 +512,7 @@ static vm_fault_t arena_vm_fault(struct vm_fault *vmf)
>>   	if (ret)
>>   		goto out_sigsegv_memcg;
>>   
>> -	struct apply_range_data data = { .pages = &page, .i = 0,
>> -					 .scratch_page = arena->scratch_page };
>> +	struct apply_range_data data = { .arena = arena, .pages = &page, .i = 0 };
>>   	/* Account into memcg of the process that created bpf_arena */
>>   	ret = bpf_map_alloc_pages(map, NUMA_NO_NODE, 1, &page);
> [Severity: High]
> This isn't a bug introduced by this patch, but does this function call
> sleepable allocators while holding a raw spinlock?
>
> In arena_vm_fault(), the raw spinlock is acquired before this block:
>
> 	if (raw_res_spin_lock_irqsave(&arena->spinlock, flags))
>
> Then bpf_map_alloc_pages() performs sleepable memory allocations (GFP_USER
> with __GFP_DIRECT_RECLAIM). Furthermore, apply_to_page_range() is called
> shortly after, which may dynamically allocate kernel page tables using
> GFP_PGTABLE_KERNEL while taking init_mm.page_table_lock (a sleepable
> spinlock on PREEMPT_RT).
>
> Can this cause a kernel panic (BUG: sleeping function called from invalid
> context) or potential deadlocks?


Not true. __bpf_alloc_page::can_alloc_pages already check whether we are 
under lock.


> [ ... ]
>
>> @@ -696,8 +701,8 @@ static long arena_alloc_pages(struct bpf_arena *arena, long uaddr, long page_cnt
>>   		bpf_map_memcg_exit(old_memcg, new_memcg);
>>   		return 0;
>>   	}
>> +	data.arena = arena;
>>   	data.pages = pages;
>> -	data.scratch_page = arena->scratch_page;
>>   
>>   	if (raw_res_spin_lock_irqsave(&arena->spinlock, flags))
> [Severity: High]
> This isn't a bug introduced by this patch, but are sleepable functions also
> called inside this atomic section in arena_alloc_pages()?
>
> After the lock is acquired, the code enters a loop that calls
> bpf_map_alloc_pages() and apply_to_page_range(), both of which can sleep
> or acquire sleepable locks.


apply_to_page_range() does not allocate page tables here. 
arena_map_alloc() already did it.


