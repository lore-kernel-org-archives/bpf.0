Received: from canpmsgout04.his.huawei.com (canpmsgout04.his.huawei.com [113.46.200.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1722288D0;
	Thu, 27 Aug 2026 07:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787816475; cv=none; b=JhWn6w3yXP2U+ODhE1MeE+YpXWfUf9oJxce94iC4tMwWH2oTXW4xCUusrQEZyPSzl++esha7NrKCnYF40KMdNrLV+H9d1luhsGLwz+LZ2KADRXMjsyjzU09n2IM+yuA/zPGrxhbTiC8NCXrT4EItWE36xdMW9sU1oPrcIXMIzOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787816475; c=relaxed/simple;
	bh=txgUXZbU8Q6CNA0+WA6rcx7IYIP0Z+YpXq5GZygeH6o=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=hXeyLg+89xibA9AZvM2HerEWOL9oL1uCUgEjYWOmFzyGDn9Sr7dAcRp3ybICj90HzWgfNXEYCtcykOm9E9LLYD3XFoss8xTNtddv/DtC4f8GUQJNd9SYX2/zEfAj5zJrLajHGD5e2Q0egTTC+Sq0tAR32ovAWKVBPNaB2d2SnuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=QAhARHj8; arc=none smtp.client-ip=113.46.200.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="QAhARHj8"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=F/Ui8w6HQRjTbBohgYv3fbxlDs5T3RetYa6B+yTzMr4=;
	b=QAhARHj8jTnyeG5DS9zF+hYj97U3TJNTsUAYVeHPaK9vo472QOmAW6MOlEQQmDntd0RVN9Jga
	T53Q3wvrGTacRdsCn4b7yaJkmCjoLr7RJSx2lJ9Wvc5ICC0JOh8n7iX+nSyAoKQx1g88Jet3Xdf
	cJwICkLfpvOVpIxga49O1Ow=
Received: from mail.maildlp.com (unknown [172.19.162.197])
	by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4hVtTG75gmz1prLg;
	Thu, 27 Aug 2026 15:30:10 +0800 (CST)
Received: from kwepemf100007.china.huawei.com (unknown [7.202.181.221])
	by mail.maildlp.com (Postfix) with ESMTPS id 1464D4057D;
	Thu, 27 Aug 2026 15:40:59 +0800 (CST)
Received: from [10.67.110.68] (10.67.110.68) by kwepemf100007.china.huawei.com
 (7.202.181.221) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 27 Aug
 2026 15:40:58 +0800
Message-ID: <05446fdb-2e94-47b0-91fb-b4f84b6baaa3@huawei.com>
Date: Thu, 27 Aug 2026 15:40:57 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf] bpf: Fix UAF due to concurrent consumption of
 waiting_for_gp_ttrace
To: Hou Tao <houtao@huaweicloud.com>, Pu Lehui <pulehui@huaweicloud.com>,
	<bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
	<daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman
	<eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai
 Lau <martin.lau@linux.dev>, Yonghong Song <yonghong.song@linux.dev>, Song Liu
	<song@kernel.org>, Jiri Olsa <jolsa@kernel.org>, Emil Tsalapatis
	<emil@etsalapatis.com>, Ihor Solodrai <ihor.solodrai@linux.dev>
References: <20260826103615.932094-1-pulehui@huaweicloud.com>
 <8ddc39b4-a28c-fffb-8b90-b4d60e0adaec@huaweicloud.com>
Content-Language: en-US
From: Pu Lehui <pulehui@huawei.com>
In-Reply-To: <8ddc39b4-a28c-fffb-8b90-b4d60e0adaec@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemf100007.china.huawei.com (7.202.181.221)



On 2026/8/26 20:28, Hou Tao wrote:
> Hi,
> 
> On 8/26/2026 6:36 PM, Pu Lehui wrote:
>> From: Pu Lehui <pulehui@huawei.com>
>>
>> Syzkaller repeatedly triggered UAF splats related to nodes in
>> waiting_for_gp_ttrace within the bpf memalloc:
>>
>> BUG: KASAN: slab-use-after-free in llist_del_first+0x85/0x110 lib/llist.c:61
>> Read of size 8 at addr ffff8881572cd080 by task syz.4.470/5112
>>
>> CPU: 2 PID: 5112 Comm: syz.4.470 Not tainted 6.6.0+ #1
>> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996)
>> Call Trace:
>>   <IRQ>
>>   ...
>>   kasan_report+0xab/0xe0 mm/kasan/report.c:581
>>   llist_del_first+0x85/0x110 lib/llist.c:61
>>   alloc_bulk+0x193/0x460 kernel/bpf/memalloc.c:229
>>   bpf_mem_refill+0x386/0x560 kernel/bpf/memalloc.c:436
>>
>> Freed by task 14:
>>   ...
>>   __kmem_cache_free+0x15d/0x330 mm/slub.c:3885
>>   free_one kernel/bpf/memalloc.c:262 [inline]
>>   free_all kernel/bpf/memalloc.c:271 [inline]
>>   __free_rcu kernel/bpf/memalloc.c:281 [inline]
>>   __free_rcu_tasks_trace+0x48/0xd0 kernel/bpf/memalloc.c:291
>>   rcu_tasks_invoke_cbs+0x1ec/0x3e0 kernel/rcu/tasks.h:571
>>   rcu_tasks_one_gp+0x13d/0x220 kernel/rcu/tasks.h:621
>>   rcu_tasks_kthread+0xf3/0x120 kernel/rcu/tasks.h:651
>>
>> Initially, we suspected that alloc_bulk() lacked RCU Tasks Trace
>> protection when accessing waiting_for_gp_ttrace. However, explicitly
>> adding rcu_read_lock_trace() did not help.
>>
>> This is expected because, as noted in commit 57b23c0f612d("bpf: Retire
>> rcu_trace_implies_rcu_gp()"), an RCU Tasks Trace GP currently implies
>> (and will continue to imply in the future) a normal RCU GP. Since
>> alloc_bulk() runs in an IRQ context (serving as an implicit normal RCU
>> read-side critical section), an RCU Tasks Trace GP cannot complete while
>> alloc_bulk() is accessing the list. Thus, the callback __free_rcu cannot
>> run concurrently, ruling out missing RCU read-side locks as the cause.
>>
>> Further investigation revealed that the UAF does not occur before the
>> RCU Tasks Trace grace period expires, but rather during the execution of
>> its callback. When the callback invokes llist_del_all to reclaim
>> waiting_for_gp_ttrace nodes, there is no synchronization protecting
>> against concurrent alloc_bulk() calls. If alloc_bulk() operates on
>> waiting_for_gp_ttrace simultaneously, a race condition ensues, as
>> illustrated below:
>>
>> CPU0                                           CPU1
>>                                                 __free_rcu (RCU Tasks Trace callback)
>> alloc_bulk (irq context)
>>    llist_del_first(&c->waiting_for_gp_ttrace)
>>      entry = smp_load_acquire(&head->first);
>>      do {
>>        if (entry == NULL)
>>          return NULL;
>>                                                 free_all(llist_del_all(&c->waiting_for_gp_ttrace))
>>                                                   llist_for_each_safe(pos, t, llnode)
>>                                                     free_one(pos);
>>        next = READ_ONCE(entry->next); <-- trigger UAF
>>      } while (!try_cmpxchg(&head->first, &entry, next));
>>
>> Since alloc_bulk() operates on waiting_for_gp_ttrace under irq context,
>> fix the issue by deferring the node reclamation. In __free_rcu callback,
>> detach the waiting_for_gp_ttrace nodes to a local list pointer and invoke
>> a normal RCU callback to free them.
>>
>> Fixes: 04fabf00b4d3 ("bpf: Allow reuse from waiting_for_gp_ttrace list.")
>> Signed-off-by: Pu Lehui <pulehui@huawei.com>
>> ---
>> Another potential fix would be to invoke llist_del_all() on
>> waiting_for_gp_ttrace before call_rcu_tasks_trace(), but that would
>> defeat the purpose of reusing waiting_for_gp_ttrace in alloc_bulk().
>>
>>   kernel/bpf/memalloc.c | 22 ++++++++++++++++++++--
>>   1 file changed, 20 insertions(+), 2 deletions(-)
>>
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
>>   
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
>>   }
> 
> It will extra delay for the freeing of these memory objects. I think
> using a raw spinlock to protect the concurrentl llist_del_all() and
> llist_del_first() will be simpler. Alexei had written a patch for it
> before [0].
> 
> [0]:
> https://lore.kernel.org/bpf/CAADnVQKea47Q1WPtmVrHEZijb=Ms8QzufVj8eds5HmNXGxSRug@mail.gmail.com/#t
> 
> However in my understanding, free_by_rcu_ttrace doesn't have such
> problem. The only possible way when there is concurrent llist_del_all()
> and llist_del_first() is during bpf_mem_alloc_destroy().
> bpf_mem_alloc_destroy() will set draining as true and do_call_rcu_ttrace
> will invoke free_all in advance. But right then, the caller of
> bpf_mem_alloc_destroy() will ensure there is no active allocation and
> there will be no invocation of llist_del_first().

Hi Hou Tao,

Thanks for the review! Using a raw spinlock to protect 
waiting_for_gp_ttrace is indeed much simpler and cleaner, avoiding both 
extra freeing latency and teardown barrier issues.

I will send v2 with this approach shortly.

>>   
>>   static void enque_to_free(struct bpf_mem_cache *c, void *obj)
> 
