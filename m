Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 466D5330B09;
	Sat,  5 Sep 2026 03:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788580635; cv=none; b=LLj8kdhUCIPULWsMzXidNXW4Tykv/nzOPGZPYWE71G1FyDDVb9sbdBVf6DgaOiNW235k7uYUCearzqUbYfdp8ORCliF2tgUIL5yicjIN8D5KigS1U8vj2LBRu5txYA/cH6ZYDtgYOXY2+wT8x+fhp2UmRCLr//OS52RxJLGxsTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788580635; c=relaxed/simple;
	bh=v2cJjHBCwBS2XsY6T8ty8m0x/9OL9ccafQwXISePhpA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gM6Th936SXiLLVdo+qGXNEmDGreNVzay7qrpbAEdQweSFFYZbZeHneMVFEeBb1KXwddkdFmJKtjC5rlOkyilCjgMj/LUqZX76OwvKO0qfsDMONcH6FWAPXQXDQxyidNQfzfNHFSHpS1ITnyOUaeQi1klsn3744scpX3zeYfyfbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4hcKJQ4b3XzYQtpv;
	Sat,  5 Sep 2026 11:56:22 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 555D940573;
	Sat,  5 Sep 2026 11:57:08 +0800 (CST)
Received: from [10.67.110.68] (unknown [10.67.110.68])
	by APP4 (Coremail) with UTF8SMTPA id gCh0CgB32pcSk5tq6d09Aw--.3822S2;
	Sat, 05 Sep 2026 11:57:08 +0800 (CST)
Message-ID: <4a837795-6b89-41e6-a346-78082cf35d64@huaweicloud.com>
Date: Sat, 5 Sep 2026 11:57:06 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf v4] bpf: Fix UAF due to concurrent consumption of
 ttrace lists in alloc_bulk
Content-Language: en-US
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 ast@kernel.org, houtao@huaweicloud.com, leon.hwang@linux.dev
Cc: daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com,
 memxor@gmail.com, martin.lau@linux.dev, yonghong.song@linux.dev,
 song@kernel.org, jolsa@kernel.org, emil@etsalapatis.com,
 ihor.solodrai@linux.dev, pulehui@huawei.com, martin.lau@kernel.org,
 mason@kernel.org
References: <20260905021139.4116529-1-pulehui@huaweicloud.com>
 <6fb6eba20f7975410960a3603614f1873fe7212e4d4f77408dcc33726dc31fde@mail.kernel.org>
From: Pu Lehui <pulehui@huaweicloud.com>
In-Reply-To: <6fb6eba20f7975410960a3603614f1873fe7212e4d4f77408dcc33726dc31fde@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgB32pcSk5tq6d09Aw--.3822S2
X-Coremail-Antispam: 1UD129KBjvJXoWxGrW7WF4rJrW3uFy3CFW8Crg_yoW5trW3pF
	s5ZF98AFn8JF1ayayIvw48CFWxCwsFvw43Ga43Wr1S9wn8Kr18KFZaqFyagr909rZ7ua4Y
	qr1qqw1rJF45ZaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvE14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1I6r4UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
	0xkIwI1lc7CjxVAaw2AFwI0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7
	v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF
	1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIx
	AIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI
	42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWI
	evJa73UjIFyTuYvjTRNJ5oDUUUU
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/


On 2026/9/5 11:00, bot+bpf-ci@kernel.org wrote:
>> Syzkaller repeatedly triggered UAF splats related to nodes in
>> waiting_for_gp_ttrace within the bpf memalloc:
>> BUG: KASAN: slab-use-after-free in llist_del_first+0x85/0x110 lib/llist.c:61
>> Read of size 8 at addr ffff8881572cd080 by task syz.4.470/5112
>>   ...
>>   llist_del_first+0x85/0x110 lib/llist.c:61
>>   alloc_bulk+0x193/0x460 kernel/bpf/memalloc.c:229
>>   bpf_mem_refill+0x386/0x560 kernel/bpf/memalloc.c:436
>> Freed by task 14:
>>   ...
>>   __free_rcu kernel/bpf/memalloc.c:281 [inline]
>>   __free_rcu_tasks_trace+0x48/0xd0 kernel/bpf/memalloc.c:291
>>   rcu_tasks_invoke_cbs+0x1ec/0x3e0 kernel/rcu/tasks.h:571
>>   rcu_tasks_one_gp+0x13d/0x220 kernel/rcu/tasks.h:621
>>   rcu_tasks_kthread+0xf3/0x120 kernel/rcu/tasks.h:651
> 
> The file and line numbers in this stack trace refer to v6.6 (the v1
> posting included 'Not tainted 6.6.0+', which was dropped in later
> versions). Against the current tree, these line numbers point to different
> locations: alloc_bulk() line 229 is in a blank/'if (i >= cnt)' section
> (the waiting_for_gp_ttrace access is now at line 231), bpf_mem_refill()
> line 436 is the closing brace, and __free_rcu_tasks_trace() no longer
> exists at all (removed by commit 57b23c0f612d).
> 
> Should the stack trace include the kernel version to prevent future
> readers from trying to map these line numbers onto the current tree?

This is reproducible on mainline too, and the log makes the race pretty 
obvious at a glance. I don't think there's any real need to change it.

> 
>> In addition, there is also a theoretical race condition on the
>> free_by_rcu_ttrace list. This race requires two preconditions: an
>> in-flight Tasks Trace GP keeping c->call_rcu_ttrace_in_progress == 1,
>> and concurrent cross-CPU frees repopulating c->free_by_rcu_ttrace with
>> new nodes. Under these conditions, the following scenario triggers UAF:
>> // CPU0
>> // irq work is still busy (on PREEMPT_RT)
>> alloc_bulk()
>>    llist_del_first(&c->free_by_rcu_ttrace)
>>      entry = smp_load_acquire(&head->first);
>>      do {
>>        if (entry == NULL)
>>          return NULL;
>>          // CPU1
>>          bpf_mem_alloc_destroy()
>>            WRITE_ONCE(c->draining, true)
>>            // wait for CPU0
>>            irq_work_sync()
>>                  // CPU2
>>                  do_call_rcu_ttrace(tgt(CPU0))
>>                    if (c->draining) {
>>                      llist_del_all(&c->free_by_rcu_ttrace)
>>                      free_all()
>>                    }
>> // CPU0 continue
>>        next = READ_ONCE(entry->next); <-- trigger UAF
> 
> The annotation suggests this race window exists only on PREEMPT_RT
> kernels. However, on non-PREEMPT_RT configurations, alloc_bulk() runs in
> hard IRQ context and irq_work_sync() from another CPU still has to wait
> for it, so the same race window exists there too. The earlier comment that
> commit d114dde245f9 removed also mentioned non-RT cases: 'arch_irq_work_
> has_interrupt() being false and irq work is invoked in timer interrupt.'
> 
> Would '(e.g., on PREEMPT_RT)' be more accurate than '(on PREEMPT_RT)' to
> indicate this is an example rather than a precondition?

PREEMPT_RT was just a handy example here.

> 
> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/33938697434

