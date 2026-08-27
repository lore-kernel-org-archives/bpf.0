Received: from canpmsgout03.his.huawei.com (canpmsgout03.his.huawei.com [113.46.200.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9112F22A7F6;
	Thu, 27 Aug 2026 07:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787816606; cv=none; b=VkIMcnMFG3EyBNL6v789hYdTiF8Yu7AcSc732F41yRMz0hDZWw40WOlp4XuwWHP7i7NXSZrLZj67wLZnDbje9gt8xDX/fwlg1JrF5Vu5TD3zyCHOjiueT5hnjhgUG8MNb1N3UqJ7oDOyXTAVS6Cv/3s/+A53JEReTl29AsS87nM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787816606; c=relaxed/simple;
	bh=2PFCS/s7/GJK7ueBku4jN5isI57TszHw+fsRZhTOcpI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=n+Aivaex8yrkeYM7fajbrEK4nzMgiLbw23rvNZOUafoMV6fYu7T4iojvCyAleQ0J8ok9dglUmL8Mx+d5QKnvehtDUA9XP3O8e/HVaGkDMU16VUZvAAyhgCeeT+Fabd47tbsI3mySpHsKu6SMSVkJX9OKANuLhX7HesiDPZKx5D0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=UrqHASn9; arc=none smtp.client-ip=113.46.200.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="UrqHASn9"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=sCzw3umNum7mSvXZXcnG1hyjWlM3yJ8Y6HX8MPwqdXM=;
	b=UrqHASn9anXInRxZHfTvhEbviQj+BPcc715jVY5f7fYnLDnP1Oy5JaUFiT72vFvkLjsbCpz6h
	jUORsTbvVNr6k8bMsVqUViFgkwEzU3xtiy0JqqlNV7iAJv8iOPNPjCVrp2+6RtaKfAIPZCvbWqa
	NWjZFYB7u8+yN48YGAWB+nU=
Received: from mail.maildlp.com (unknown [172.19.162.197])
	by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4hVtWQ6RH3zpSvB;
	Thu, 27 Aug 2026 15:32:02 +0800 (CST)
Received: from kwepemf100007.china.huawei.com (unknown [7.202.181.221])
	by mail.maildlp.com (Postfix) with ESMTPS id E06A74057D;
	Thu, 27 Aug 2026 15:43:12 +0800 (CST)
Received: from [10.67.110.68] (10.67.110.68) by kwepemf100007.china.huawei.com
 (7.202.181.221) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 27 Aug
 2026 15:43:12 +0800
Message-ID: <7466dc22-6b03-4584-8289-02e7186129bb@huawei.com>
Date: Thu, 27 Aug 2026 15:43:11 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf] bpf: Fix UAF due to concurrent consumption of
 waiting_for_gp_ttrace
Content-Language: en-US
To: <bot+bpf-ci@kernel.org>, <pulehui@huaweicloud.com>, <bpf@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
	<eddyz87@gmail.com>, <memxor@gmail.com>, <martin.lau@linux.dev>,
	<yonghong.song@linux.dev>, <song@kernel.org>, <jolsa@kernel.org>,
	<emil@etsalapatis.com>, <ihor.solodrai@linux.dev>, <martin.lau@kernel.org>,
	<clm@meta.com>
References: <20260826103615.932094-1-pulehui@huaweicloud.com>
 <df5a55306918f6a83693a91db252f1e653602f35144e6ad189d502acb8b19ed0@mail.kernel.org>
From: Pu Lehui <pulehui@huawei.com>
In-Reply-To: <df5a55306918f6a83693a91db252f1e653602f35144e6ad189d502acb8b19ed0@mail.kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemf100007.china.huawei.com (7.202.181.221)


Thanks very much!

The review comments on bpf ci look excellent, and I will extract the 
valuable information from them.

On 2026/8/26 19:16, bot+bpf-ci@kernel.org wrote:
>>      alloc_bulk() runs in an IRQ context (serving as an implicit normal RCU
>>      read-side critical section), an RCU Tasks Trace GP cannot complete while
>>      alloc_bulk() is accessing the list.
> 
> Is this accurate on CONFIG_PREEMPT_RT? Looking at init_refill_work() in
> kernel/bpf/memalloc.c, it uses init_irq_work() without IRQ_WORK_INIT_HARD,
> so on RT the irq_work goes to lazy_list and is executed by the preemptible
> per-CPU 'irq_work/N' kthread, not in hardirq context. The allocator's own
> comment says "In RT irq_work runs in per-cpu kthread."
> 
> The conclusion still holds because run_irq_workd() wraps
> irq_work_run_list(&lazy_list) in guard(rcu)(), making it an explicit RCU
> read-side critical section on RT. So alloc_bulk() is protected by RCU, but
> the stated reason ('IRQ context') is only true on !RT.
> 
> Could the commit message clarify that the RCU-reader property comes from
> hardirq on !RT and explicit rcu_read_lock() in run_irq_workd() on RT?
> 
>>      Thus, the callback __free_rcu cannot run concurrently, ruling out
>>      missing RCU read-side locks as the cause.
> 
> Can __free_rcu really not run concurrently with alloc_bulk()? The race
> diagram two paragraphs later shows exactly that happening:
> 
> CPU0                                           CPU1
>                                                 __free_rcu (RCU Tasks Trace callback)
> alloc_bulk (irq context)
>    llist_del_first(&c->waiting_for_gp_ttrace)
>      entry = smp_load_acquire(&head->first);
>                                                 free_all(llist_del_all(&c->waiting_for_gp_ttrace))
>      next = READ_ONCE(entry->next); <-- trigger UAF
> 
> Looking at the guarantees from 57b23c0f612d, the RCU Tasks Trace GP
> contains at least one synchronize_rcu(), which waits for alloc_bulk()
> invocations that started before that internal synchronize_rcu(). But a
> fresh alloc_bulk() entered after the GP expired is not waited for, and
> __free_rcu can run while that fresh invocation is in flight.
> 
> So what's actually true is narrower: a ttrace GP cannot expire while an
> alloc_bulk() read section that began before the GP's internal
> synchronize_rcu() is still in flight. A fresh alloc_bulk() after the GP
> expired can race with __free_rcu().
> 
> Could the explanation be more precise about which alloc_bulk() invocations
> are protected and which can race?
> 
>> diff --git a/kernel/bpf/memalloc.c b/kernel/bpf/memalloc.c
>> index e9662db7198f..fb1e733bfb82 100644
>> --- a/kernel/bpf/memalloc.c
>> +++ b/kernel/bpf/memalloc.c
>> @@ -110,7 +110,9 @@ struct bpf_mem_cache {
>>   	struct llist_node *free_by_rcu_tail;
>>   	struct llist_head waiting_for_gp;
>>   	struct llist_node *waiting_for_gp_tail;
>> +	struct llist_node *waiting_for_reclaim_gp;
>>   	struct rcu_head rcu;
>> +	struct rcu_head rcu_reclaim;
>>   	atomic_t call_rcu_in_progress;
>>   	struct llist_head free_llist_extra_rcu;
> 
> [ ... ]
> 
>> @@ -276,12 +278,28 @@ static int free_all(struct bpf_mem_cache *c, struct llist_node *llnode, bool per
>>   	return cnt;
>>   }
>>
>> +static void __free_final_rcu(struct rcu_head *head)
>> +{
>> +	struct bpf_mem_cache *c = container_of(head, struct bpf_mem_cache, rcu);
>> +	struct llist_node *llnode = c->waiting_for_reclaim_gp;
>> +
>> +	c->waiting_for_reclaim_gp = NULL;
>> +	free_all(c, llnode, !!c->percpu_size);
>> +	atomic_set(&c->call_rcu_ttrace_in_progress, 0);
>> +}
>> +
>>   static void __free_rcu(struct rcu_head *head)
>>   {
>>   	struct bpf_mem_cache *c = container_of(head, struct bpf_mem_cache, rcu_ttrace);
>> +	struct llist_node *llnode = llist_del_all(&c->waiting_for_gp_ttrace);
>>
>> -	free_all(c, llist_del_all(&c->waiting_for_gp_ttrace), !!c->percpu_size);
>> -	atomic_set(&c->call_rcu_ttrace_in_progress, 0);
>> +	if (!llnode) {
>> +		atomic_set(&c->call_rcu_ttrace_in_progress, 0);
>> +		return;
>> +	}
>> +
>> +	c->waiting_for_reclaim_gp = llnode;
>> +	call_rcu(&c->rcu_reclaim, __free_final_rcu);
>                            ^^^^^^^^^^^^^^^^^^^^^^^^^
> 
> Does free_mem_alloc() wait for this new callback? Looking at the teardown
> path:
> 
> kernel/bpf/memalloc.c:free_mem_alloc() {
>      /*
>       * Trace grace period implies RCU grace period, so all __free_rcu
>       * don't need extra call_rcu() (and thus extra rcu_barrier() here).
>       */
>      rcu_barrier();               /* wait for __free_by_rcu */
>      rcu_barrier_tasks_trace();   /* wait for __free_rcu */
>      free_mem_alloc_no_barrier(ma);
>          -> free_percpu(ma->cache) / free_percpu(ma->caches)
> }
> 
> The barriers run in that order: normal RCU first, then tasks-trace. If
> __free_rcu() executes during rcu_barrier_tasks_trace() and queues
> call_rcu(&c->rcu_reclaim, __free_final_rcu), there's no rcu_barrier()
> left to wait for it. So free_percpu() runs while __free_final_rcu() is
> still queued on the now-freed per-cpu memory.
> 
> Concrete sequence:
> 1. do_call_rcu_ttrace() queues call_rcu_tasks_trace(&c->rcu_ttrace,
>     __free_rcu)
> 2. Map destroyed, destroy path computes rcu_in_progress >= 1 from
>     atomic_read(&c->call_rcu_ttrace_in_progress), takes deferred path
> 3. free_mem_alloc(): rcu_barrier() at 716 completes, rcu_barrier_tasks_trace()
>     at 717 waits for __free_rcu() which runs and queues call_rcu(&c->rcu_reclaim,
>     __free_final_rcu), barrier returns with normal-RCU callback newly queued
> 4. free_mem_alloc_no_barrier() frees the per-cpu memory holding c
> 5. When normal grace period ends, __free_final_rcu() runs on freed memory
> 
> Also, drain_mem_cache() drains seven lists but not waiting_for_reclaim_gp,
> and check_mem_cache() WARN_ON_ONCE()s on those seven but never inspects
> waiting_for_reclaim_gp, so the leak is silent.
> 
> Does this need an rcu_barrier() after rcu_barrier_tasks_trace() (or the
> two swapped plus an added one)? And should the comment at lines 706-715
> be updated since it now says the opposite of what the code does?
> 
> Also note check_mem_cache() should probably check waiting_for_reclaim_gp.
> 
> The same llist_del_first-vs-llist_del_all hazard that this patch fixes
> for waiting_for_gp_ttrace also exists on free_by_rcu_ttrace. Looking at
> kernel/bpf/memalloc.c:
> 
> alloc_bulk() does:
>      obj = llist_del_first(&c->free_by_rcu_ttrace);
> 
> while do_call_rcu_ttrace() does:
>      llnode = llist_del_all(&c->free_by_rcu_ttrace);
>      ...
>      free_all(c, llnode, percpu);  /* draining path, immediate free */
> 
> and drain_mem_cache() does:
>      free_all(llist_del_all(&c->free_by_rcu_ttrace), ...);
> 
> include/linux/llist.h's concurrency table marks the del_first x del_all
> cell 'L' (lock is needed) and the kerneldoc on llist_del_first says "If
> multiple consumers are needed, please use llist_del_all or use lock
> between consumers."
> 
> The non-draining path in do_call_rcu_ttrace() is incidentally covered by
> the new extra GP because nodes end up in waiting_for_gp_ttrace, but the
> draining direct-free and drain_mem_cache()'s free_all() still free without
> any RCU deferral.
> 
> Does free_by_rcu_ttrace need the same treatment?
> 
> While the nodes sit in c->waiting_for_reclaim_gp they are invisible to
> alloc_bulk()'s reuse loop, so for one extra normal RCU GP the allocator
> must kmalloc() instead of reusing. This partially undoes the optimization
> being fixed.
> 
> Is this expected? Should the commit message mention it?
> 
> The commit message says "Syzkaller repeatedly triggered" but carries no
> Reported-by:, Closes: or Link: tag, and the splat is from a private 6.6.0+
> tree rather than upstream syzbot.
> 
> Also, Hou Tao reported this exact hazard during review of 04fabf00b4d3 in
> July 2023 (lore.kernel.org/rcu/957dd5cd-0855-1197-7045-4cb1590bd753@huaweicloud.com).
> Alexei's reply was that the probability was "lower than a bit flip due to
> cosmic rays."
> 
> Could citing that thread make the analysis more credible and give proper
> credit to Hou Tao?
> 
> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/32959494022
