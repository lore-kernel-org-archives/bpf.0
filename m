Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 892593AF656
	for <bpf@vger.kernel.org>; Thu, 27 Aug 2026 11:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787831117; cv=none; b=dqytXfJ/GidoaoF5HPij+t4E3RHc7A7Z4P31jceGE/4ob2KMkFo1DNF9NP0q4ubeZTgAE7QOmse9Xiy2FYc7pnkS4NtBJpCr1gp5fb2gxuHVyF3LPcDZxQqVRRz4AyAbFFZjYgyA0S50xXo9cC80Qp5/RLd87AolCw2j5vxc9gI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787831117; c=relaxed/simple;
	bh=cXPp8pKkXgP0gQxOjb/WfC7X59/smhaiCLkEXz7eNTA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VHQLIgzm9MQ9I2HR++nx8MGFNI3mjQpjaOrJPyX1gy5ccIIZuJUFy9nFm521qt5iULsdLE7LXSoZOBJx86z6c/QEh5cAgB/VVFxKNf4qt+FRBqjYyvnQrkIDTp029RLBt96Zn/khNpw5pmlSIxHgm36UOunzyPiBPG3dJCJ9Mq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4hW06b0QxBzKHMMd
	for <bpf@vger.kernel.org>; Thu, 27 Aug 2026 19:44:23 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 35FF440911
	for <bpf@vger.kernel.org>; Thu, 27 Aug 2026 19:45:05 +0800 (CST)
Received: from [10.67.110.68] (unknown [10.67.110.68])
	by APP3 (Coremail) with UTF8SMTPA id _Ch0CgD35UQ_I5Bqvq1oDw--.56879S2;
	Thu, 27 Aug 2026 19:45:05 +0800 (CST)
Message-ID: <f17ac4ba-3276-4fef-b9e5-5423956b68fa@huaweicloud.com>
Date: Thu, 27 Aug 2026 19:45:03 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf v2] bpf: Fix UAF due to concurrent consumption of
 waiting_for_gp_ttrace
Content-Language: en-US
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org, Hou Tao <houtao@huaweicloud.com>
References: <20260827084013.1062816-1-pulehui@huaweicloud.com>
 <20260827084756.EC4271F000E9@smtp.kernel.org>
From: Pu Lehui <pulehui@huaweicloud.com>
In-Reply-To: <20260827084756.EC4271F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_Ch0CgD35UQ_I5Bqvq1oDw--.56879S2
X-Coremail-Antispam: 1UD129KBjvJXoWxuryDZw13KFWrZr43WFW8Xrb_yoW5ZFW5pF
	Z3Gry5Ars8ZFWS93Wqqw48CFWfAa1xW347GayUWrySkry3Zw1jgF4IkrWUZF98Cr4vk347
	tryq9wn7Ar1UZFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyS14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCF04k20xvY0x0EwIxGrwCF
	x2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14
	v26r106r1rMI8E67AF67kF1VAFwI0_Jrv_JF1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY
	67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2
	IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_
	Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUywZ7UUUUU=
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/


On 2026/8/27 16:47, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] The patch fixes concurrent consumption for `waiting_for_gp_ttrace` but incorrectly claims `free_by_rcu_ttrace` is safe. A race condition during cache destruction leads to a Use-After-Free on `free_by_rcu_ttrace`.
> --
> 
> commit ed5f43858e59ce799a585eeedfe466c5543df6aa
> Author: Pu Lehui <pulehui@huawei.com>
> Subject: bpf: Fix UAF due to concurrent consumption of waiting_for_gp_ttrace
> 
> This commit fixes a use-after-free caused by concurrent consumption of
> waiting_for_gp_ttrace nodes by alloc_bulk() and __free_rcu(). It introduces
> a raw spinlock to synchronize operations on this list.
> 
> The commit message notes:
>> Note that free_by_rcu_ttrace does not suffer from this issue as it only
>> has a single active consumer during normal operation.
> 
>> diff --git a/kernel/bpf/memalloc.c b/kernel/bpf/memalloc.c
>> index e9662db7198fe..58296e92a4fed 100644
>> --- a/kernel/bpf/memalloc.c
>> +++ b/kernel/bpf/memalloc.c
> [ ... ]
>> @@ -297,6 +307,7 @@ static void enque_to_free(struct bpf_mem_cache *c, void *obj)
>>   static void do_call_rcu_ttrace(struct bpf_mem_cache *c)
>>   {
>>   	struct llist_node *llnode, *t;
>> +	unsigned long flags;
>>   
>>   	if (atomic_xchg(&c->call_rcu_ttrace_in_progress, 1)) {
>>   		if (unlikely(READ_ONCE(c->draining))) {
>>   			llnode = llist_del_all(&c->free_by_rcu_ttrace);
>>   			free_all(c, llnode, !!c->percpu_size);
>>   		}
> 
> [Severity: High]
> This is a pre-existing issue, but does free_by_rcu_ttrace actually suffer
> from a similar race condition during cache destruction?
> 
> If userspace triggers destruction of a BPF memory allocator via
> bpf_mem_alloc_destroy(), CPU 0 sets c->draining = true and synchronizes
> the irq_work:
> 
> CPU 0: bpf_mem_alloc_destroy()
>      WRITE_ONCE(c->draining, true);
>      irq_work_sync(&c->refill_work);
> 
> Meanwhile, CPU 1 could be executing alloc_bulk() inside the refill work,
> consuming from free_by_rcu_ttrace:
> 
> CPU 1: alloc_bulk()
>      obj = llist_del_first(&c->free_by_rcu_ttrace);
> 
> If CPU 1 reads the head pointer in llist_del_first() but is delayed before
> READ_ONCE(entry->next), and concurrently an RCU callback on CPU 2 calls
> do_call_rcu_ttrace(), CPU 2 will observe draining == true here and
> immediately free the nodes.
> 
> When CPU 1 resumes and executes READ_ONCE(entry->next), won't this result
> in a use-after-free on the node that was just freed to the slab allocator?

Quoting what Hou Tao said earlier [0]:
```
The only possible way when there is concurrent llist_del_all()
and llist_del_first() is during bpf_mem_alloc_destroy().
bpf_mem_alloc_destroy() will set draining as true and do_call_rcu_ttrace
will invoke free_all in advance. But right then, the caller of
bpf_mem_alloc_destroy() will ensure there is no active allocation and
there will be no invocation of llist_del_first().
```

[0] 
https://lore.kernel.org/bpf/05446fdb-2e94-47b0-91fb-b4f84b6baaa3@huawei.com/T/#m7b523472481ed192f4004517a6f877dc72d02370

