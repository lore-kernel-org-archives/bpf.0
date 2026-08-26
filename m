Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 280A341D11C;
	Wed, 26 Aug 2026 12:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787747430; cv=none; b=SgC0BbFe3hv+JVT3lG0MFtjDtwYvFpjCW25MVit3L0Bw4rKgqQ0zMz0lcgkeMOGIQLc+CjH5gCgQfqNxnJGHZqUK3rlCipHBcnkcfirgNn/64NF/MoPemeAKvEVaDCyd7pK15yYLtOlywfNJ36WrFObFOwqHomodjIESw1qeR8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787747430; c=relaxed/simple;
	bh=7g9WYieq5DH8PTkAh++CiV42caM5OYD+6gLEc3qdowI=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=Mom+qoXnnFoAxTeBkr1bOiN/riJ1PXjpooCXZaN179EQU1plg/Z4pnZNCY+KeLhjGeB0jfKxBU2/DeVJLildxHx+JrqUhhV4HSsuFwsFGsMABxUiiF9wjJpZpArAZHnTdfpiQP522xPBNxC1jeyvxwmCS2TSS80+F6H9xgxtzW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4hVP9H4yZszKHMbr;
	Wed, 26 Aug 2026 20:29:39 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 425FF4056B;
	Wed, 26 Aug 2026 20:30:20 +0800 (CST)
Received: from [10.174.176.103] (unknown [10.174.176.103])
	by APP3 (Coremail) with UTF8SMTPA id _Ch0CgBXkUBb3I5qsgfwDg--.57335S2;
	Wed, 26 Aug 2026 20:30:20 +0800 (CST)
Subject: Re: [PATCH bpf] bpf: Fix UAF due to concurrent consumption of
 waiting_for_gp_ttrace
To: Pu Lehui <pulehui@huaweicloud.com>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>,
 Yonghong Song <yonghong.song@linux.dev>, Song Liu <song@kernel.org>,
 Jiri Olsa <jolsa@kernel.org>, Emil Tsalapatis <emil@etsalapatis.com>,
 Ihor Solodrai <ihor.solodrai@linux.dev>, Pu Lehui <pulehui@huawei.com>
References: <20260826103615.932094-1-pulehui@huaweicloud.com>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <8ddc39b4-a28c-fffb-8b90-b4d60e0adaec@huaweicloud.com>
Date: Wed, 26 Aug 2026 20:28:21 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260826103615.932094-1-pulehui@huaweicloud.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID:_Ch0CgBXkUBb3I5qsgfwDg--.57335S2
X-Coremail-Antispam: 1UD129KBjvJXoW3GFWUKr1kCr4kKFy5Kr4xtFb_yoW7Kw1DpF
	WxJr98Jr4kAFWSyas2vr4xC39xZw4Fqa43Gay8u34ayr15uw1qgFZ3Kry5ZF1akw40kFy3
	trn0kF1kAw4UZ3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Ib4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
	e2xFo4CEbIxvr21lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4I
	kC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWU
	WwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr
	0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWU
	JVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJb
	IYCTnIWIevJa73UjIFyTuYvjxUOBMKDUUUU
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

Hi,

On 8/26/2026 6:36 PM, Pu Lehui wrote:
> From: Pu Lehui <pulehui@huawei.com>
>
> Syzkaller repeatedly triggered UAF splats related to nodes in
> waiting_for_gp_ttrace within the bpf memalloc:
>
> BUG: KASAN: slab-use-after-free in llist_del_first+0x85/0x110 lib/llist.c:61
> Read of size 8 at addr ffff8881572cd080 by task syz.4.470/5112
>
> CPU: 2 PID: 5112 Comm: syz.4.470 Not tainted 6.6.0+ #1
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996)
> Call Trace:
>  <IRQ>
>  ...
>  kasan_report+0xab/0xe0 mm/kasan/report.c:581
>  llist_del_first+0x85/0x110 lib/llist.c:61
>  alloc_bulk+0x193/0x460 kernel/bpf/memalloc.c:229
>  bpf_mem_refill+0x386/0x560 kernel/bpf/memalloc.c:436
>
> Freed by task 14:
>  ...
>  __kmem_cache_free+0x15d/0x330 mm/slub.c:3885
>  free_one kernel/bpf/memalloc.c:262 [inline]
>  free_all kernel/bpf/memalloc.c:271 [inline]
>  __free_rcu kernel/bpf/memalloc.c:281 [inline]
>  __free_rcu_tasks_trace+0x48/0xd0 kernel/bpf/memalloc.c:291
>  rcu_tasks_invoke_cbs+0x1ec/0x3e0 kernel/rcu/tasks.h:571
>  rcu_tasks_one_gp+0x13d/0x220 kernel/rcu/tasks.h:621
>  rcu_tasks_kthread+0xf3/0x120 kernel/rcu/tasks.h:651
>
> Initially, we suspected that alloc_bulk() lacked RCU Tasks Trace
> protection when accessing waiting_for_gp_ttrace. However, explicitly
> adding rcu_read_lock_trace() did not help.
>
> This is expected because, as noted in commit 57b23c0f612d("bpf: Retire
> rcu_trace_implies_rcu_gp()"), an RCU Tasks Trace GP currently implies
> (and will continue to imply in the future) a normal RCU GP. Since
> alloc_bulk() runs in an IRQ context (serving as an implicit normal RCU
> read-side critical section), an RCU Tasks Trace GP cannot complete while
> alloc_bulk() is accessing the list. Thus, the callback __free_rcu cannot
> run concurrently, ruling out missing RCU read-side locks as the cause.
>
> Further investigation revealed that the UAF does not occur before the
> RCU Tasks Trace grace period expires, but rather during the execution of
> its callback. When the callback invokes llist_del_all to reclaim
> waiting_for_gp_ttrace nodes, there is no synchronization protecting
> against concurrent alloc_bulk() calls. If alloc_bulk() operates on
> waiting_for_gp_ttrace simultaneously, a race condition ensues, as
> illustrated below:
>
> CPU0                                           CPU1
>                                                __free_rcu (RCU Tasks Trace callback)
> alloc_bulk (irq context)
>   llist_del_first(&c->waiting_for_gp_ttrace)
>     entry = smp_load_acquire(&head->first);
>     do {
>       if (entry == NULL)
>         return NULL;
>                                                free_all(llist_del_all(&c->waiting_for_gp_ttrace))
>                                                  llist_for_each_safe(pos, t, llnode)
>                                                    free_one(pos);
>       next = READ_ONCE(entry->next); <-- trigger UAF
>     } while (!try_cmpxchg(&head->first, &entry, next));
>
> Since alloc_bulk() operates on waiting_for_gp_ttrace under irq context,
> fix the issue by deferring the node reclamation. In __free_rcu callback,
> detach the waiting_for_gp_ttrace nodes to a local list pointer and invoke
> a normal RCU callback to free them.
>
> Fixes: 04fabf00b4d3 ("bpf: Allow reuse from waiting_for_gp_ttrace list.")
> Signed-off-by: Pu Lehui <pulehui@huawei.com>
> ---
> Another potential fix would be to invoke llist_del_all() on
> waiting_for_gp_ttrace before call_rcu_tasks_trace(), but that would
> defeat the purpose of reusing waiting_for_gp_ttrace in alloc_bulk().
>
>  kernel/bpf/memalloc.c | 22 ++++++++++++++++++++--
>  1 file changed, 20 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/bpf/memalloc.c b/kernel/bpf/memalloc.c
> index e9662db7198f..fb1e733bfb82 100644
> --- a/kernel/bpf/memalloc.c
> +++ b/kernel/bpf/memalloc.c
> @@ -110,7 +110,9 @@ struct bpf_mem_cache {
>  	struct llist_node *free_by_rcu_tail;
>  	struct llist_head waiting_for_gp;
>  	struct llist_node *waiting_for_gp_tail;
> +	struct llist_node *waiting_for_reclaim_gp;
>  	struct rcu_head rcu;
> +	struct rcu_head rcu_reclaim;
>  	atomic_t call_rcu_in_progress;
>  	struct llist_head free_llist_extra_rcu;
>  
> @@ -276,12 +278,28 @@ static int free_all(struct bpf_mem_cache *c, struct llist_node *llnode, bool per
>  	return cnt;
>  }
>  
> +static void __free_final_rcu(struct rcu_head *head)
> +{
> +	struct bpf_mem_cache *c = container_of(head, struct bpf_mem_cache, rcu);
> +	struct llist_node *llnode = c->waiting_for_reclaim_gp;
> +
> +	c->waiting_for_reclaim_gp = NULL;
> +	free_all(c, llnode, !!c->percpu_size);
> +	atomic_set(&c->call_rcu_ttrace_in_progress, 0);
> +}
> +
>  static void __free_rcu(struct rcu_head *head)
>  {
>  	struct bpf_mem_cache *c = container_of(head, struct bpf_mem_cache, rcu_ttrace);
> +	struct llist_node *llnode = llist_del_all(&c->waiting_for_gp_ttrace);
>  
> -	free_all(c, llist_del_all(&c->waiting_for_gp_ttrace), !!c->percpu_size);
> -	atomic_set(&c->call_rcu_ttrace_in_progress, 0);
> +	if (!llnode) {
> +		atomic_set(&c->call_rcu_ttrace_in_progress, 0);
> +		return;
> +	}
> +
> +	c->waiting_for_reclaim_gp = llnode;
> +	call_rcu(&c->rcu_reclaim, __free_final_rcu);
>  }

It will extra delay for the freeing of these memory objects. I think
using a raw spinlock to protect the concurrentl llist_del_all() and
llist_del_first() will be simpler. Alexei had written a patch for it
before [0].

[0]:
https://lore.kernel.org/bpf/CAADnVQKea47Q1WPtmVrHEZijb=Ms8QzufVj8eds5HmNXGxSRug@mail.gmail.com/#t

However in my understanding, free_by_rcu_ttrace doesn't have such
problem. The only possible way when there is concurrent llist_del_all()
and llist_del_first() is during bpf_mem_alloc_destroy().
bpf_mem_alloc_destroy() will set draining as true and do_call_rcu_ttrace
will invoke free_all in advance. But right then, the caller of
bpf_mem_alloc_destroy() will ensure there is no active allocation and
there will be no invocation of llist_del_first().
>  
>  static void enque_to_free(struct bpf_mem_cache *c, void *obj)

