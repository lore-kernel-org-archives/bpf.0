Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E77561A5BAE;
	Sat,  5 Sep 2026 02:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788573629; cv=none; b=aZzMeqg/CuSL5008+8Tom4g1lYy6hRC9BzcXuu2M2+sPnBm7PJqLUnJ5D2zZlrl/xKYACQ8l2ZMLMrH8sGYJkUm77YwFEw4TPiDr6Ug6ANvIIwes6gWthlbo7gnjzc8EDvLx+e1b1PIx7BtxSODysw4u1xKuKVBPy/Sz/YbYiYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788573629; c=relaxed/simple;
	bh=DEC1CJcgiZa8m+iFXZymvRKB4evD3khcBk1hxMOv0NI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m+CpJEmvuow8mSDwzB4bRTRkaiNkTvxcBYFJnYxKRjTXC8ZKIiP3LjTcM1UrsTTEq18NouRE/jqtSYeoKpL4mffaqqYkbfn3DWEs3aJGzQhfkUm75xQY9tE7lmYtpwNVul6ajr6zeTMOmMpDF90/Rj82IiurDJLPRT8oDJbm1Kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4hcGjQ0M8FzKHMPY;
	Sat,  5 Sep 2026 09:59:22 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 41AC240590;
	Sat,  5 Sep 2026 10:00:18 +0800 (CST)
Received: from [10.67.110.68] (unknown [10.67.110.68])
	by APP1 (Coremail) with UTF8SMTPA id cCh0CgC3nQiwd5tqRzwrAw--.48710S2;
	Sat, 05 Sep 2026 10:00:18 +0800 (CST)
Message-ID: <4dd1dfe3-7dc3-415c-99de-73f3f46a3397@huaweicloud.com>
Date: Sat, 5 Sep 2026 10:00:16 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf v3] bpf: Fix UAF due to concurrent consumption of
 ttrace lists in alloc_bulk
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 ast@kernel.org, houtao@huaweicloud.com, leon.hwang@linux.dev
Cc: daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com,
 memxor@gmail.com, martin.lau@linux.dev, yonghong.song@linux.dev,
 song@kernel.org, jolsa@kernel.org, emil@etsalapatis.com,
 ihor.solodrai@linux.dev, pulehui@huawei.com, martin.lau@kernel.org,
 mason@kernel.org
References: <20260901150307.3474349-1-pulehui@huaweicloud.com>
 <c846615ea25cf371f04302e136ce4b4dc50224fed1df1b1063afc94ecfc711db@mail.kernel.org>
Content-Language: en-US
From: Pu Lehui <pulehui@huaweicloud.com>
In-Reply-To: <c846615ea25cf371f04302e136ce4b4dc50224fed1df1b1063afc94ecfc711db@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:cCh0CgC3nQiwd5tqRzwrAw--.48710S2
X-Coremail-Antispam: 1UD129KBjvJXoW3Jw13XryrGF1fXryDAryDtrb_yoW7Wry5pF
	WrXF15Cr4DZFy2v34Iqr48Wr129wnYq343JFWrur9Ykrn0vrn5KF4Skry3ua4rCws7ua4S
	qFn0grn7Ja1Y9FDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9j14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1I6r4UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r
	xl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
	6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr
	0_Gr1lF7xvr2IY64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxa
	n2IY04v7MxkF7I0En4kS14v26r4a6rW5MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4
	AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE
	17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMI
	IF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4l
	IxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvf
	C2KfnxnUUI43ZEXa7sRidbbtUUUUU==
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/


On 2026/9/1 23:55, bot+bpf-ci@kernel.org wrote:
>> This is expected because, as noted in commit 57b23c0f612d ("bpf: Retire
>> rcu_trace_implies_rcu_gp()"), an RCU Tasks Trace GP currently implies
>> (and will continue to imply in the future) a normal RCU GP. Since
>> alloc_bulk() runs in an RCU read-side CS (!PREEMPT_RT runs in IRQ
>> context, PREEMPT_RT runs with guard(rcu)), an RCU Tasks Trace GP cannot
>> complete while alloc_bulk() is accessing the list.
> 
> Is this claim about the RCU Tasks Trace GP accurate? Looking at the SRCU
> implementation, synchronize_rcu() sits in the middle of the SRCU scan
> (kernel/rcu/srcutree.c srcu_readers_active_idx_check()), not at the end.
> 
> An RCU GP is only required to wait for read-side critical sections that
> were already in progress when the GP started. Once a CPU reports its
> quiescent state, a new hardirq handler on that CPU does not delay the GP.
> So an alloc_bulk() that starts after the synchronize_rcu() call cannot
> hold off the RCU Tasks Trace GP at all.
> 
> Even if the GP could not complete during alloc_bulk(), that would not
> prevent the callback from running during alloc_bulk(). Callbacks are
> invoked asynchronously after the GP ends (srcu_invoke_callbacks workqueue
> in current kernels, or rcu_tasks_invoke_cbs in the 6.6 kernel that
> produced the splat).
> 
> The race diagram three paragraphs later shows __free_rcu executing
> concurrently with alloc_bulk's llist_del_first, which would not be
> possible if the statement above were true.
> 
> Would it be more accurate to say that RCU read-side protection is not the
> missing ingredient here, but rather mutual exclusion between the two
> llist consumers?

Regarding the commit message: there is no real contradiction. Those 
paragraphs were merely explaining our initial troubleshooting hypothesis 
and addressing earlier discussions where adding rcu_read_lock_trace() 
was suggested [0], rather than claiming that RCU Tasks Trace prevents 
the race.

However, to keep the commit log focused and avoid any confusion, I will 
simply drop that part in the next

[0] 
https://lore.kernel.org/bpf/3f72c4e7-340f-4374-9ebe-f9bffd08c755@paulmck-laptop/

> 
>> diff --git a/kernel/bpf/memalloc.c b/kernel/bpf/memalloc.c
>> index e9662db7198f..5927943c765a 100644
>> --- a/kernel/bpf/memalloc.c
>> +++ b/kernel/bpf/memalloc.c
> 
> [ ... ]
> 
>> @@ -214,25 +215,25 @@ static void alloc_bulk(struct bpf_mem_cache *c, int cnt, int node, bool atomic)
>>   	gfp = __GFP_NOWARN | __GFP_ACCOUNT;
>>   	gfp |= atomic ? GFP_NOWAIT : GFP_KERNEL;
>>
>> -	for (i = 0; i < cnt; i++) {
>> -		/*
>> -		 * For every 'c' llist_del_first(&c->free_by_rcu_ttrace); is
>> -		 * done only by one CPU == current CPU. Other CPUs might
>> -		 * llist_add() and llist_del_all() in parallel.
>> -		 */
>> -		obj = llist_del_first(&c->free_by_rcu_ttrace);
>> -		if (!obj)
>> -			break;
>> -		add_obj_to_free_list(c, obj);
>> -	}
>> -	if (i >= cnt)
>> -		return;
>> +	scoped_guard(raw_spinlock_irqsave, &c->lock) {
>> +		for (i = 0; i < cnt; i++) {
>> +			/*
>> +			 * For every 'c' llist_del_first(&c->free_by_rcu_ttrace); is
>> +			 * done only by one CPU == current CPU. Other CPUs might
>> +			 * llist_add() and llist_del_all() in parallel.
>> +			 */
>> +			obj = llist_del_first(&c->free_by_rcu_ttrace);
>> +			if (!obj)
>> +				break;
>> +			add_obj_to_free_list(c, obj);
>> +		}
>>
>> -	for (; i < cnt; i++) {
>> -		obj = llist_del_first(&c->waiting_for_gp_ttrace);
>> -		if (!obj)
>> -			break;
>> -		add_obj_to_free_list(c, obj);
>> +		for (; i < cnt; i++) {
>> +			obj = llist_del_first(&c->waiting_for_gp_ttrace);
>> +			if (!obj)
>> +				break;
>> +			add_obj_to_free_list(c, obj);
>> +		}
>>   	}
>>   	if (i >= cnt)
>>   		return;
> 
> The comment moved inside the new critical section still states the
> lockless rationale:
> 
>      /*
>       * For every 'c' llist_del_first(&c->free_by_rcu_ttrace); is
>       * done only by one CPU == current CPU. Other CPUs might
>       * llist_add() and llist_del_all() in parallel.
>       */
> 
> The last sentence asserts that concurrent llist_del_all() is fine.
> According to include/linux/llist.h, the del_first x del_all combination
> requires a lock, and the commit message's first race diagram shows exactly
> this combination producing the KASAN splat.
> 
> Should this comment be updated to reflect that c->lock now serializes
> against __free_rcu() and the draining branch of do_call_rcu_ttrace(),
> rather than asserting that lockless operation is safe?

make sense to me.

> 
> The related comments in enque_to_free() ("Nothing races to add to

The comments in enque_to_free looks fine, no need to modify.

> free_by_rcu_ttrace list.") and drain_mem_cache() ("Except for
> waiting_for_gp_ttrace list, there are no concurrent operations on these
> lists") may also need updates, though they are outside this diff.

The comments in drain_mem_cache are slightly incorrect, but the impact 
is not significant. In addition, they are outside this diff.

> 
> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/33525009657

