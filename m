Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A9EA43F8CF;
	Thu, 27 Aug 2026 11:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787831143; cv=none; b=WdQ9luEMnSdNCcD9XI+TnDFgB1dCrmn4TSQgHCuIH2h41EMyyIP0zGkz0YoM1CezbskcAMaJhAvS2NgwzD71MLkRCg9YZ/078K6jvtyr6ZnqvCraXoJUpL9qEFAiN3NXtFp2IqAi9dO9W5AxmDlVxkJQ7V6LQINY/AHMyr+FQ7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787831143; c=relaxed/simple;
	bh=4/6Q9Hyv/Uc6R8d+ArJIkGE2O2zjnA3bBX/nSSI28eg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lHkYOsMhfdEvSoyt4y5Dxt2DRX4U7wNOxxT0ZIriWilii3BvIC0dB95ucNSoT09S3/UiHuHBmJOEGp/WDMght0rx7e9bqtQjURlyhustSJminueiYYndmJ8OtDlZfyzandkPnlFBEui4n3FGRDIfVMtx2cZlcTECUB1OaAgQDcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4hW07Q40MjzYQty7;
	Thu, 27 Aug 2026 19:45:06 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 4D38340574;
	Thu, 27 Aug 2026 19:45:37 +0800 (CST)
Received: from [10.67.110.68] (unknown [10.67.110.68])
	by APP4 (Coremail) with UTF8SMTPA id gCh0CgCnhBlgI5BqjsyODw--.1732S2;
	Thu, 27 Aug 2026 19:45:37 +0800 (CST)
Message-ID: <de17533f-73fa-4673-90de-133d93ce7492@huaweicloud.com>
Date: Thu, 27 Aug 2026 19:45:36 +0800
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
To: Leon Hwang <leon.hwang@linux.dev>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>,
 Yonghong Song <yonghong.song@linux.dev>, Song Liu <song@kernel.org>,
 Jiri Olsa <jolsa@kernel.org>, Emil Tsalapatis <emil@etsalapatis.com>,
 Ihor Solodrai <ihor.solodrai@linux.dev>, Hou Tao <houtao@huaweicloud.com>,
 Pu Lehui <pulehui@huawei.com>
References: <20260827084013.1062816-1-pulehui@huaweicloud.com>
 <63ae0f06-e5a8-4a21-90cd-03e0ef100fda@linux.dev>
From: Pu Lehui <pulehui@huaweicloud.com>
In-Reply-To: <63ae0f06-e5a8-4a21-90cd-03e0ef100fda@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgCnhBlgI5BqjsyODw--.1732S2
X-Coremail-Antispam: 1UD129KBjvJXoW3GF4kJw13WFy7GryUGw45Jrb_yoW7XryUpF
	yxGF1rJF48ZFZF93WIqr4kAa9aqw40qa43C3yUua4Skr15Zw1DtFyfAry7uF90vrWxKr4S
	yr1vgryxCrWUZFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvK14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kI
	c2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbV
	WUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF
	67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42
	IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF
	0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxh
	VjvjDU0xZFpf9x0JUZYFZUUUUU=
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/



On 2026/8/27 16:51, Leon Hwang wrote:
> On 27/8/26 16:40, Pu Lehui wrote:
>> From: Pu Lehui <pulehui@huawei.com>
> [...]
>>   kernel/bpf/memalloc.c | 31 +++++++++++++++++++++++++------
>>   1 file changed, 25 insertions(+), 6 deletions(-)
>>
>> diff --git a/kernel/bpf/memalloc.c b/kernel/bpf/memalloc.c
>> index e9662db7198f..58296e92a4fe 100644
>> --- a/kernel/bpf/memalloc.c
>> +++ b/kernel/bpf/memalloc.c
>> @@ -119,6 +119,7 @@ struct bpf_mem_cache {
>>   	struct llist_head waiting_for_gp_ttrace;
>>   	struct rcu_head rcu_ttrace;
>>   	atomic_t call_rcu_ttrace_in_progress;
>> +	raw_spinlock_t lock;
>>   };
>>   
>>   struct bpf_mem_caches {
>> @@ -207,6 +208,7 @@ static void add_obj_to_free_list(struct bpf_mem_cache *c, void *obj)
>>   static void alloc_bulk(struct bpf_mem_cache *c, int cnt, int node, bool atomic)
>>   {
>>   	struct mem_cgroup *memcg = NULL, *old_memcg;
>> +	unsigned long flags;
>>   	gfp_t gfp;
>>   	void *obj;
>>   	int i;
>> @@ -228,12 +230,14 @@ static void alloc_bulk(struct bpf_mem_cache *c, int cnt, int node, bool atomic)
>>   	if (i >= cnt)
>>   		return;
>>   
>> +	raw_spin_lock_irqsave(&c->lock, flags);
>>   	for (; i < cnt; i++) {
>> -		obj = llist_del_first(&c->waiting_for_gp_ttrace);
>> +		obj = __llist_del_first(&c->waiting_for_gp_ttrace);
>>   		if (!obj)
>>   			break;
>>   		add_obj_to_free_list(c, obj);
>>   	}
>> +	raw_spin_unlock_irqrestore(&c->lock, flags);
> 
> Looks like scoped_guard() could get rid of the 'flags':
> 
> scoped_guard(raw_spinlock_irqsave, &c->lock) {
> 	...
> }
> 
>>   	if (i >= cnt)
>>   		return;
>>   
>> @@ -279,8 +283,14 @@ static int free_all(struct bpf_mem_cache *c, struct llist_node *llnode, bool per
>>   static void __free_rcu(struct rcu_head *head)
>>   {
>>   	struct bpf_mem_cache *c = container_of(head, struct bpf_mem_cache, rcu_ttrace);
>> +	struct llist_node *llnode;
>> +	unsigned long flags;
>>   
>> -	free_all(c, llist_del_all(&c->waiting_for_gp_ttrace), !!c->percpu_size);
>> +	raw_spin_lock_irqsave(&c->lock, flags);
>> +	llnode = __llist_del_all(&c->waiting_for_gp_ttrace);
>> +	raw_spin_unlock_irqrestore(&c->lock, flags);
> 
> Ditto
>> +
>> +	free_all(c, llnode, !!c->percpu_size);
>>   	atomic_set(&c->call_rcu_ttrace_in_progress, 0);
>>   }
>>   
>> @@ -297,6 +307,7 @@ static void enque_to_free(struct bpf_mem_cache *c, void *obj)
>>   static void do_call_rcu_ttrace(struct bpf_mem_cache *c)
>>   {
>>   	struct llist_node *llnode, *t;
>> +	unsigned long flags;
>>   
>>   	if (atomic_xchg(&c->call_rcu_ttrace_in_progress, 1)) {
>>   		if (unlikely(READ_ONCE(c->draining))) {
>> @@ -307,8 +318,10 @@ static void do_call_rcu_ttrace(struct bpf_mem_cache *c)
>>   	}
>>   
>>   	WARN_ON_ONCE(!llist_empty(&c->waiting_for_gp_ttrace));
>> +	raw_spin_lock_irqsave(&c->lock, flags);
>>   	llist_for_each_safe(llnode, t, llist_del_all(&c->free_by_rcu_ttrace))
>> -		llist_add(llnode, &c->waiting_for_gp_ttrace);
>> +		__llist_add(llnode, &c->waiting_for_gp_ttrace);
>> +	raw_spin_unlock_irqrestore(&c->lock, flags);
> 
> Ditto
> 
>>   
>>   	if (unlikely(READ_ONCE(c->draining))) {
>>   		__free_rcu(&c->rcu_ttrace);
>> @@ -535,6 +548,7 @@ int bpf_mem_alloc_init(struct bpf_mem_alloc *ma, int size, bool percpu)
>>   			c->objcg = objcg;
>>   			c->percpu_size = percpu_size;
>>   			c->tgt = c;
>> +			raw_spin_lock_init(&c->lock);
>>   			init_refill_work(c);
>>   			prefill_mem_cache(c, cpu);
>>   		}
>> @@ -557,7 +571,7 @@ int bpf_mem_alloc_init(struct bpf_mem_alloc *ma, int size, bool percpu)
>>   			c->objcg = objcg;
>>   			c->percpu_size = percpu_size;
>>   			c->tgt = c;
>> -
>> +			raw_spin_lock_init(&c->lock);
>>   			init_refill_work(c);
>>   			prefill_mem_cache(c, cpu);
>>   		}
>> @@ -609,7 +623,7 @@ int bpf_mem_alloc_percpu_unit_init(struct bpf_mem_alloc *ma, int size)
>>   		c->objcg = objcg;
>>   		c->percpu_size = percpu_size;
>>   		c->tgt = c;
>> -
>> +		raw_spin_lock_init(&c->lock);
>>   		init_refill_work(c);
>>   		prefill_mem_cache(c, cpu);
>>   	}
>> @@ -620,6 +634,8 @@ int bpf_mem_alloc_percpu_unit_init(struct bpf_mem_alloc *ma, int size)
>>   static void drain_mem_cache(struct bpf_mem_cache *c)
>>   {
>>   	bool percpu = !!c->percpu_size;
>> +	struct llist_node *llnode;
>> +	unsigned long flags;
>>   
>>   	/* No progs are using this bpf_mem_cache, but htab_map_free() called
>>   	 * bpf_mem_cache_free() for all remaining elements and they can be in
>> @@ -629,7 +645,10 @@ static void drain_mem_cache(struct bpf_mem_cache *c)
>>   	 * on these lists, so it is safe to use __llist_del_all().
>>   	 */
>>   	free_all(c, llist_del_all(&c->free_by_rcu_ttrace), percpu);
>> -	free_all(c, llist_del_all(&c->waiting_for_gp_ttrace), percpu);
>> +	raw_spin_lock_irqsave(&c->lock, flags);
>> +	llnode = __llist_del_all(&c->waiting_for_gp_ttrace);
>> +	raw_spin_unlock_irqrestore(&c->lock, flags);
> 
> Ditto
> 
> Thanks,
> Leon
> 
>> +	free_all(c, llnode, percpu);
>>   	free_all(c, __llist_del_all(&c->free_llist), percpu);
>>   	free_all(c, __llist_del_all(&c->free_llist_extra), percpu);
>>   	free_all(c, __llist_del_all(&c->free_by_rcu), percpu);

ok, will do

