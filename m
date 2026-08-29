Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B46E21D3E8;
	Sat, 29 Aug 2026 09:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787997057; cv=none; b=O+sIhcJIJZ/nnbLxuWNMZhU2FRlyRqpUj0B4JDb3lyg6hIL32VHKkaRL0FqIB47bCCEvXBlJP74xXj1hmrBF/H9Je4xO5g9d2STgegtXUIl0hQWyiE6jURtBPi3W9LcBBT0CNXFfm3tRrUlGoequhnVptileFW9AjQ3Hi2MClCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787997057; c=relaxed/simple;
	bh=yCSxuHMApiJbZjWlTyBAJ/ejtTmXlUc2q7hJBfEVGXQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IOHAHO1rub/PhD+zyk55g7Pji/Dfx6l2rPMEtRC0yTIAdFefIHBLDTIWAJMkJiOkkQPLNqegM0YNwXbiL7es77NVg3XtR1i9Xo40o/FTQhozgM5sM0PMa5wL3L8ZZd1Vm9ku06y1ltKi3b1PXgGtHrhQzzBEePQ5qaQYf3YWSPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4hX9Tm6mLkzYQtx4;
	Sat, 29 Aug 2026 17:50:04 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id F206E40577;
	Sat, 29 Aug 2026 17:50:38 +0800 (CST)
Received: from [10.67.110.68] (unknown [10.67.110.68])
	by APP1 (Coremail) with UTF8SMTPA id cCh0CgBXSNRtq5JqT0ZTEA--.33965S2;
	Sat, 29 Aug 2026 17:50:38 +0800 (CST)
Message-ID: <6d865765-0495-4553-b928-3cad80703533@huaweicloud.com>
Date: Sat, 29 Aug 2026 17:50:37 +0800
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
To: Hou Tao <houtao@huaweicloud.com>, ast@kernel.org, bot+bpf-ci@kernel.org,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com,
 memxor@gmail.com, martin.lau@linux.dev, yonghong.song@linux.dev,
 song@kernel.org, jolsa@kernel.org, emil@etsalapatis.com,
 ihor.solodrai@linux.dev, pulehui@huawei.com, martin.lau@kernel.org,
 clm@meta.com
References: <20260827084013.1062816-1-pulehui@huaweicloud.com>
 <497836f1914121810fa01a9a601342ad32a7fc76d62efebb02121d7b9f2e96e4@mail.kernel.org>
 <e9558ab7-3ab0-c93f-0d29-fb9ebb08e4ad@huaweicloud.com>
From: Pu Lehui <pulehui@huaweicloud.com>
In-Reply-To: <e9558ab7-3ab0-c93f-0d29-fb9ebb08e4ad@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgBXSNRtq5JqT0ZTEA--.33965S2
X-Coremail-Antispam: 1UD129KBjvAXoWfJw1xtr1fWr17Aw17KrWrGrg_yoW8XryfCo
	Wfur43tr18tF1fCa4DC348Gr4Yka4kG3sxZrn3JrW3Za1UXFyqq34fuay5Xay3ZFyvkFs8
	Z3WUt3y5CFy8Jas3n29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UjIYCTnIWjp_UUUY67AC8VAFwI0_Xr0_Wr1l1xkIjI8I6I8E6xAIw20EY4v20xva
	j40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2
	x7M28EF7xvwVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8
	JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r
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

++to Alexei

On 2026/8/27 22:40, Hou Tao wrote:
> 
> 
> On 8/27/2026 5:24 PM, bot+bpf-ci@kernel.org wrote:
>>> diff --git a/kernel/bpf/memalloc.c b/kernel/bpf/memalloc.c
>>> index e9662db7198f..58296e92a4fe 100644
>>> --- a/kernel/bpf/memalloc.c
>>> +++ b/kernel/bpf/memalloc.c
>> [ ... ]
>>
>>> @@ -297,6 +307,7 @@ static void enque_to_free(struct bpf_mem_cache *c, void *obj)
>>>   static void do_call_rcu_ttrace(struct bpf_mem_cache *c)
>>>   {
>>>   	struct llist_node *llnode, *t;
>>> +	unsigned long flags;
>>>
>>>   	if (atomic_xchg(&c->call_rcu_ttrace_in_progress, 1)) {
>>>   		if (unlikely(READ_ONCE(c->draining))) {
>>> @@ -307,8 +318,10 @@ static void do_call_rcu_ttrace(struct bpf_mem_cache *c)
>>>   	}
>>>
>>>   	WARN_ON_ONCE(!llist_empty(&c->waiting_for_gp_ttrace));
>>> +	raw_spin_lock_irqsave(&c->lock, flags);
>>>   	llist_for_each_safe(llnode, t, llist_del_all(&c->free_by_rcu_ttrace))
>>> -		llist_add(llnode, &c->waiting_for_gp_ttrace);
>>> +		__llist_add(llnode, &c->waiting_for_gp_ttrace);
>>> +	raw_spin_unlock_irqrestore(&c->lock, flags);
>> Can this loop iteration count be bounded? The critical section covers
>> the whole free_by_rcu_ttrace -> waiting_for_gp_ttrace transfer, so
>> c->lock is held with IRQs disabled for a number of iterations that has
>> no upper bound.
>>
>> free_by_rcu_ttrace is filled from enque_to_free() by free_bulk() and,
>> more significantly, by the batch append in __free_by_rcu():
>>
>> kernel/bpf/memalloc.c:__free_by_rcu() {
>>      llist_add_batch(llnode, c->waiting_for_gp_tail,
>>                      &tgt->free_by_rcu_ttrace);
>> }
>>
>> That batch is the whole c->waiting_for_gp chain, which builds from
>> every bpf_mem_free_rcu()/unit_free_rcu() that happened while
>> call_rcu_in_progress was set, proportional to the object-free rate
>> without any watermark. While call_rcu_ttrace_in_progress is set,
>> successive __free_by_rcu() invocations keep appending without anything
>> draining it, so batches accumulate across rounds.
>>
>> Compare the other new critical sections in the patch, which are all
>> O(1): __llist_del_all in __free_rcu and drain_mem_cache, or bounded by
>> c->batch in alloc_bulk (roughly 48 iterations max). Only this one is
>> unbounded, and raw_spinlock_t + irqsave means it is non-preemptible
>> even on PREEMPT_RT, where do_call_rcu_ttrace() is reached from the
>> rcuc/rcuop kthread via __free_by_rcu().
>>
>> The lock is only needed for the destination list. llist_del_all() on
>> free_by_rcu_ttrace is an xchg and is already safe against concurrent
>> llist_add() producers without a lock. Could the chain be re-linked (or
>> its tail found) outside the lock and spliced into waiting_for_gp_ttrace
>> with a single __llist_add_batch() under the lock, keeping the IRQ-off
>> window O(1)?
> 
> I think it is a good suggestion to reduce the lock scope of the
> irq-disabled raw-spinlock.
>>
>> [ ... ]
>>
>>> @@ -620,6 +634,8 @@ int bpf_mem_alloc_percpu_unit_init(struct bpf_mem_alloc *ma, int size)
>>>   static void drain_mem_cache(struct bpf_mem_cache *c)
>>>   {
>>>   	bool percpu = !!c->percpu_size;
>>> +	struct llist_node *llnode;
>>> +	unsigned long flags;
>>>
>>>   	/* No progs are using this bpf_mem_cache, but htab_map_free() called
>>>   	 * bpf_mem_cache_free() for all remaining elements and they can be in
>>> @@ -629,7 +645,10 @@ static void drain_mem_cache(struct bpf_mem_cache *c)
>>>   	 * on these lists, so it is safe to use __llist_del_all().
>>>   	 */
>>>   	free_all(c, llist_del_all(&c->free_by_rcu_ttrace), percpu);
>>> -	free_all(c, llist_del_all(&c->waiting_for_gp_ttrace), percpu);
>>> +	raw_spin_lock_irqsave(&c->lock, flags);
>>> +	llnode = __llist_del_all(&c->waiting_for_gp_ttrace);
>>> +	raw_spin_unlock_irqrestore(&c->lock, flags);
>>> +	free_all(c, llnode, percpu);
>> Does the comment above need updating? It says "Except for
>> waiting_for_gp_ttrace list, there are no concurrent operations on these
>> lists, so it is safe to use __llist_del_all()."
>>
>> Before the patch the comment matched the code: waiting_for_gp_ttrace
>> was the one list drained with the atomic llist_del_all(), and the
>> comment named it as the exception to "safe to use __llist_del_all()".
>>
>> After the patch waiting_for_gp_ttrace is the list that does use
>> __llist_del_all() (now serialised by c->lock), while free_by_rcu_ttrace
>> and waiting_for_gp still use the atomic llist_del_all(). The sentence
>> now points at the opposite list from the code, and no longer explains
>> why the new lock is needed here.
>>
>> A reader trying to work out which lists still need atomic accessors
>> after this change gets the wrong answer from the comment. Should the
>> comment say that concurrent consumption of waiting_for_gp_ttrace is now
>> excluded by c->lock, so plain __llist_del_all() is safe, while
>> free_by_rcu_ttrace / waiting_for_gp still need the atomic variants?
> 
> Good point.
>>
>> [ ... ]
>>
>> commit 03e0a12c3be3d11fe9a3b87582070b2158a7bb74
>> Author: Pu Lehui <pulehui@huawei.com>
>>
>>>      bpf: Fix UAF due to concurrent consumption of waiting_for_gp_ttrace
>>>
>>>      Syzkaller repeatedly triggered UAF splats related to nodes in
>>>      waiting_for_gp_ttrace within the bpf memalloc:
>> [ ... ]
>>
>>>      This is expected because, as noted in commit 57b23c0f612d ("bpf: Retire
>>>      rcu_trace_implies_rcu_gp()"), an RCU Tasks Trace GP currently implies
>>>      (and will continue to imply in the future) a normal RCU GP. Since
>>>      alloc_bulk() runs in an RCU read-side CS (!PREEMPT_RT runs in IRQ
>>>      context, PREEMPT_RT runs with guard(rcu)), an RCU Tasks Trace GP cannot
>>>      complete while alloc_bulk() is accessing the list. Thus, the callback
>>>      __free_rcu cannot run concurrently, ruling out missing RCU read-side
>>>      locks as the cause. And same for free_by_rcu_ttrace list.
>> Is the statement "Thus, the callback __free_rcu cannot run concurrently"
>> accurate as written?
> 
> I think it just means multiple __free_rcu() can not run concurrently.
>>
>> Looking at the race diagram three paragraphs later, it shows exactly
>> that scenario: __free_rcu on CPU1 executing in the middle of
>> alloc_bulk's llist_del_first on CPU0. What the RCU argument actually
>> establishes is narrower: the GP cannot complete during the particular
>> read-side CS it is waiting on, so RCU read-side protection is not what
>> is missing.
>>
>> Nothing prevents a new alloc_bulk() from starting after the GP has
>> completed and running concurrently with the callback. __free_rcu runs
>> from the rcu_tasks_trace kthread (process context, no irqs disabled, any
>> CPU) while alloc_bulk runs from irq_work on the cache's own CPU; on
>> PREEMPT_RT alloc_bulk is even preemptible, so same-CPU interleaving is
>> possible too.
>>
>> A reviewer reading this sentence literally would conclude the race in
>> the diagram is impossible. Could the paragraph say "RCU read-side
>> protection is not what is missing; what is missing is mutual exclusion
>> between the two llist consumers"?
>>
>>>      Note that free_by_rcu_ttrace does not suffer from this issue as it only
>>>      has a single active consumer during normal operation.
>> Is this premise correct? free_by_rcu_ttrace has two distinct consumers,
>> and they are not confined to one CPU:
>>
>>    - alloc_bulk() memalloc.c:225 (still outside c->lock):
>>
>>      obj = llist_del_first(&c->free_by_rcu_ttrace);
>>
>>    - do_call_rcu_ttrace() memalloc.c:322, and drain_mem_cache()
>>      memalloc.c:647:
>>
>>      llist_del_all(&c->free_by_rcu_ttrace)
>>
>> do_call_rcu_ttrace() is called as do_call_rcu_ttrace(tgt) with
>> tgt = c->tgt from free_bulk() (memalloc.c:341, 364) and __free_by_rcu()
>> (memalloc.c:370, 383). c->tgt is set to the cache that allocated the
>> object, potentially another CPU's cache:
>>
>> kernel/bpf/memalloc.c:unit_free() {
>>      c->tgt = *(struct bpf_mem_cache **)llnode;
>> }
>>
>> So llist_del_all(&tgt->free_by_rcu_ttrace) on CPU1 can run concurrently
>> with llist_del_first(&tgt->free_by_rcu_ttrace) in alloc_bulk(tgt) on
>> tgt's own CPU. The file's own comment at memalloc.c:220-224 says as
>> much: "Other CPUs might llist_add() and llist_del_all() in parallel."
>>
>> What actually keeps that pair harmless in the common case is the RCU
>> deferral the changelog describes earlier, not single-consumer-ness: the
>> nodes taken by llist_del_all() are moved to waiting_for_gp_ttrace and
>> only freed by __free_rcu() after an RCU tasks trace GP, which cannot
>> elapse while alloc_bulk() is inside its RCU read-side section. That
>> argument does not cover the two draining paths, which free immediately
>> while still only being ordered against alloc_bulk() by
>> WRITE_ONCE(c->draining, true) / irq_work_sync().
> 
> Er, It seems the UAF problem is still possible for free_by_rcu_ttrace
> under PREEMPT_RT. The possible race is shown below:
> 
> // CPU=0
> // irq work is still busy (e.g., on PREEMPT_RT)
> alloc_bulk()
>    llist_del_first(&c->free_by_rcu_ttrace)
>                                             
>              // CPU=1
>              bpf_mem_alloc_destroy
>                  WRITE_ONCE(c->draining, true)
>                  // wait for CPU 0
>                  irq_work_sync()
> 
>                  // CPU=2 (due to cross-cpu free)
>                  do_call_rcu_ttrace()
>                      llist_del_all(&c->free_by_rcu_ttrace)
>                      // due to c->draining is True
>                      free_all()

Hi Hou Tao,

Thanks for pointing out that.

Indeed, free_by_rcu_ttrace also requires spinlock protection. However, 
converting it entirely to spinlock + non-atomic __llist_* ops would 
introduce unnecessary locking overhead into the fast-freeing path 
(particularly in enque_to_free(), which runs in a tight loop inside 
free_bulk()).

Therefore, I propose adding the spinlock only at the actual consumer 
race points while keeping the atomic llist_* ops against concurrent 
lockless producers. This keeps the logic simple, avoids penalizing the 
hot free path, and completely eliminates the UAF.

How about the following?

diff --git a/kernel/bpf/memalloc.c b/kernel/bpf/memalloc.c
index e9662db7198f..942480d399ec 100644
--- a/kernel/bpf/memalloc.c
+++ b/kernel/bpf/memalloc.c
@@ -119,6 +119,7 @@ struct bpf_mem_cache {
  	struct llist_head waiting_for_gp_ttrace;
  	struct rcu_head rcu_ttrace;
  	atomic_t call_rcu_ttrace_in_progress;
+	raw_spinlock_t lock;
  };

  struct bpf_mem_caches {
@@ -214,25 +215,27 @@ static void alloc_bulk(struct bpf_mem_cache *c, 
int cnt, int node, bool atomic)
  	gfp = __GFP_NOWARN | __GFP_ACCOUNT;
  	gfp |= atomic ? GFP_NOWAIT : GFP_KERNEL;

-	for (i = 0; i < cnt; i++) {
-		/*
-		 * For every 'c' llist_del_first(&c->free_by_rcu_ttrace); is
-		 * done only by one CPU == current CPU. Other CPUs might
-		 * llist_add() and llist_del_all() in parallel.
-		 */
-		obj = llist_del_first(&c->free_by_rcu_ttrace);
-		if (!obj)
-			break;
-		add_obj_to_free_list(c, obj);
-	}
-	if (i >= cnt)
-		return;
-
-	for (; i < cnt; i++) {
-		obj = llist_del_first(&c->waiting_for_gp_ttrace);
-		if (!obj)
-			break;
-		add_obj_to_free_list(c, obj);
+	scoped_guard(raw_spinlock_irqsave, &c->lock) {
+		for (i = 0; i < cnt; i++) {
+			/*
+			 * For every 'c' llist_del_first(&c->free_by_rcu_ttrace); is
+			 * done only by one CPU == current CPU. Other CPUs might
+			 * llist_add() and llist_del_all() in parallel.
+			 */
+			obj = llist_del_first(&c->free_by_rcu_ttrace);
+			if (!obj)
+				break;
+			add_obj_to_free_list(c, obj);
+		}
+		if (i >= cnt)
+			return;
+
+		for (; i < cnt; i++) {
+			obj = llist_del_first(&c->waiting_for_gp_ttrace);
+			if (!obj)
+				break;
+			add_obj_to_free_list(c, obj);
+		}
  	}
  	if (i >= cnt)
  		return;
@@ -279,8 +282,12 @@ static int free_all(struct bpf_mem_cache *c, struct 
llist_node *llnode, bool per
  static void __free_rcu(struct rcu_head *head)
  {
  	struct bpf_mem_cache *c = container_of(head, struct bpf_mem_cache, 
rcu_ttrace);
+	struct llist_node *llnode;
+
+	scoped_guard(raw_spinlock_irqsave, &c->lock)
+		llnode = llist_del_all(&c->waiting_for_gp_ttrace);

-	free_all(c, llist_del_all(&c->waiting_for_gp_ttrace), !!c->percpu_size);
+	free_all(c, llnode, !!c->percpu_size);
  	atomic_set(&c->call_rcu_ttrace_in_progress, 0);
  }

@@ -300,7 +307,8 @@ static void do_call_rcu_ttrace(struct bpf_mem_cache *c)

  	if (atomic_xchg(&c->call_rcu_ttrace_in_progress, 1)) {
  		if (unlikely(READ_ONCE(c->draining))) {
-			llnode = llist_del_all(&c->free_by_rcu_ttrace);
+			scoped_guard(raw_spinlock_irqsave, &c->lock)
+				llnode = llist_del_all(&c->free_by_rcu_ttrace);
  			free_all(c, llnode, !!c->percpu_size);
  		}
  		return;
@@ -535,6 +543,7 @@ int bpf_mem_alloc_init(struct bpf_mem_alloc *ma, int 
size, bool percpu)
  			c->objcg = objcg;
  			c->percpu_size = percpu_size;
  			c->tgt = c;
+			raw_spin_lock_init(&c->lock);
  			init_refill_work(c);
  			prefill_mem_cache(c, cpu);
  		}
@@ -557,7 +566,7 @@ int bpf_mem_alloc_init(struct bpf_mem_alloc *ma, int 
size, bool percpu)
  			c->objcg = objcg;
  			c->percpu_size = percpu_size;
  			c->tgt = c;
-
+			raw_spin_lock_init(&c->lock);
  			init_refill_work(c);
  			prefill_mem_cache(c, cpu);
  		}
@@ -609,7 +618,7 @@ int bpf_mem_alloc_percpu_unit_init(struct 
bpf_mem_alloc *ma, int size)
  		c->objcg = objcg;
  		c->percpu_size = percpu_size;
  		c->tgt = c;
-
+		raw_spin_lock_init(&c->lock);
  		init_refill_work(c);
  		prefill_mem_cache(c, cpu);
  	}
-- 
2.34.1

> 
> The problem is that alloc_bulk may still be running in the irq work
> kthread under PREEMPT_RT when unit_alloc() doesn't have any caller any more.
>>
>> Since the changelog is what a reviewer will use to decide the fix is
>> complete, should the sentence be corrected to state the real reason (RCU
>> deferral) or should the residual draining-path window be acknowledged?
>>
>> Leon Hwang suggested in the v2 review that scoped_guard() could be used
>> instead of explicit raw_spin_lock_irqsave/raw_spin_unlock_irqrestore to
>> simplify the code and avoid needing the flags variable. This is a code
>> style improvement that would make the locking more idiomatic. The
>> suggestion applies to multiple locations: alloc_bulk(), __free_rcu(),
>> do_call_rcu_ttrace(), and drain_mem_cache(). Is this something worth
>> addressing before merge?
>>
>>
>> ---
>> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
>> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
>>
>> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/33055527430

