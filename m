Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81846438494
	for <bpf@vger.kernel.org>; Thu, 27 Aug 2026 14:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787841844; cv=none; b=YqrVTPME3M2MjUzOpjvfGInFoz3/hxA3nsys6pU7fX+FJKDf5/R47DB6B17FmOkyNSnJ1xqNsy58I9G6decwGUpIva6aCEwhVlCupKkBS/e67nHkG++5RHcPvwt/KI6tM22VyXrIYOxDCsY3pidRZEe0DmZd4nrnfzVins7p9Hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787841844; c=relaxed/simple;
	bh=2yMOlEQj7jAQnVYrnxq92q5cPb+VkABylohPsNFpaTw=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=QO6lrB0oX8dCr5UaUom7BOBHtVXTKorNJSk7Z3Jr+8VFoWCUK5dbb6rqoDCK5SYs0CRPVQiItbbgMoZZsnTwxnF/QxMRkQScnU6lEvmZ6jFiujKxxu8DWcR3RGwN1Mcw+6sSHXiEAtDde/UWpKGzUmsWjrzW8WPsIul+tQbvPtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4hW4582thTzYQtLj
	for <bpf@vger.kernel.org>; Thu, 27 Aug 2026 22:43:24 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 5E72B4059C
	for <bpf@vger.kernel.org>; Thu, 27 Aug 2026 22:43:55 +0800 (CST)
Received: from [10.174.176.103] (unknown [10.174.176.103])
	by APP3 (Coremail) with UTF8SMTPA id _Ch0CgCXhUQoTZBqI_p3Dw--.9575S2;
	Thu, 27 Aug 2026 22:43:55 +0800 (CST)
Subject: Re: [PATCH bpf v2] bpf: Fix UAF due to concurrent consumption of
 waiting_for_gp_ttrace
To: Pu Lehui <pulehui@huaweicloud.com>, sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260827084013.1062816-1-pulehui@huaweicloud.com>
 <20260827084756.EC4271F000E9@smtp.kernel.org>
 <f17ac4ba-3276-4fef-b9e5-5423956b68fa@huaweicloud.com>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <9e28e21e-9e84-0104-40b2-490735b3451c@huaweicloud.com>
Date: Thu, 27 Aug 2026 22:43:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <f17ac4ba-3276-4fef-b9e5-5423956b68fa@huaweicloud.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:_Ch0CgCXhUQoTZBqI_p3Dw--.9575S2
X-Coremail-Antispam: 1UD129KBjvJXoWxGr48GrWxXw1fKw15Wr4UArb_yoWrGry3pF
	Z5XFyUArZ8AFZakrnFqw48GryfAw4Iq345GayUXFySkry3Aw1jgr4jqrWj9F9xAr4kCa47
	trn093s7Zr1UZaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkG14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7I2V7IY0VAS07AlzVAY
	IcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
	v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jrv_JF1lIxkG
	c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4U
	MIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUdEfOUUU
	UU=
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

Hi,

On 8/27/2026 7:45 PM, Pu Lehui wrote:
>
> On 2026/8/27 16:47, sashiko-bot@kernel.org wrote:
>> Thank you for your contribution! Sashiko AI review found 1 potential
>> issue(s) to consider:
>>
>> Pre-existing issues:
>> - [High] The patch fixes concurrent consumption for
>> `waiting_for_gp_ttrace` but incorrectly claims `free_by_rcu_ttrace`
>> is safe. A race condition during cache destruction leads to a
>> Use-After-Free on `free_by_rcu_ttrace`.
>> -- 
>>
>> commit ed5f43858e59ce799a585eeedfe466c5543df6aa
>> Author: Pu Lehui <pulehui@huawei.com>
>> Subject: bpf: Fix UAF due to concurrent consumption of
>> waiting_for_gp_ttrace
>>
>> This commit fixes a use-after-free caused by concurrent consumption of
>> waiting_for_gp_ttrace nodes by alloc_bulk() and __free_rcu(). It
>> introduces
>> a raw spinlock to synchronize operations on this list.
>>
>> The commit message notes:
>>> Note that free_by_rcu_ttrace does not suffer from this issue as it only
>>> has a single active consumer during normal operation.
>>
>>> diff --git a/kernel/bpf/memalloc.c b/kernel/bpf/memalloc.c
>>> index e9662db7198fe..58296e92a4fed 100644
>>> --- a/kernel/bpf/memalloc.c
>>> +++ b/kernel/bpf/memalloc.c
>> [ ... ]
>>> @@ -297,6 +307,7 @@ static void enque_to_free(struct bpf_mem_cache
>>> *c, void *obj)
>>>   static void do_call_rcu_ttrace(struct bpf_mem_cache *c)
>>>   {
>>>       struct llist_node *llnode, *t;
>>> +    unsigned long flags;
>>>         if (atomic_xchg(&c->call_rcu_ttrace_in_progress, 1)) {
>>>           if (unlikely(READ_ONCE(c->draining))) {
>>>               llnode = llist_del_all(&c->free_by_rcu_ttrace);
>>>               free_all(c, llnode, !!c->percpu_size);
>>>           }
>>
>> [Severity: High]
>> This is a pre-existing issue, but does free_by_rcu_ttrace actually
>> suffer
>> from a similar race condition during cache destruction?
>>
>> If userspace triggers destruction of a BPF memory allocator via
>> bpf_mem_alloc_destroy(), CPU 0 sets c->draining = true and synchronizes
>> the irq_work:
>>
>> CPU 0: bpf_mem_alloc_destroy()
>>      WRITE_ONCE(c->draining, true);
>>      irq_work_sync(&c->refill_work);
>>
>> Meanwhile, CPU 1 could be executing alloc_bulk() inside the refill work,
>> consuming from free_by_rcu_ttrace:
>>
>> CPU 1: alloc_bulk()
>>      obj = llist_del_first(&c->free_by_rcu_ttrace);
>>
>> If CPU 1 reads the head pointer in llist_del_first() but is delayed
>> before
>> READ_ONCE(entry->next), and concurrently an RCU callback on CPU 2 calls
>> do_call_rcu_ttrace(), CPU 2 will observe draining == true here and
>> immediately free the nodes.
>>
>> When CPU 1 resumes and executes READ_ONCE(entry->next), won't this
>> result
>> in a use-after-free on the node that was just freed to the slab
>> allocator?
>
> Quoting what Hou Tao said earlier [0]:
> ```
> The only possible way when there is concurrent llist_del_all()
> and llist_del_first() is during bpf_mem_alloc_destroy().
> bpf_mem_alloc_destroy() will set draining as true and do_call_rcu_ttrace
> will invoke free_all in advance. But right then, the caller of
> bpf_mem_alloc_destroy() will ensure there is no active allocation and
> there will be no invocation of llist_del_first().
> ```

Er, I need to take it back. bpf_mem_alloc_destroy() could ensure there
is no caller for unit_alloc(), but under PREEMPT_RT, alloc_bulk may
still be running in the irq work kthread, and there will be the same
problem.
>
> [0]
> https://lore.kernel.org/bpf/05446fdb-2e94-47b0-91fb-b4f84b6baaa3@huawei.com/T/#m7b523472481ed192f4004517a6f877dc72d02370

