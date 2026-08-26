Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49D6D3E49FF;
	Wed, 26 Aug 2026 11:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787742980; cv=none; b=IHr5LRopfh5vEKWQ6VQ7U+Sw2cO3KZGOlWkM/tRhtfNN+tk7bAimb3YB4q3igzLQcbBFVU259ssWF/x5kDsGub0NA/4k2d7CgBgWc5I/IXPVbagl+m99fPunpbxJ/p0SnG7T+zyYGfBdEMHGqmb/2hq/QW8F8jjYZpVRWi2BiWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787742980; c=relaxed/simple;
	bh=1/mDzs2cxsqkU2PV6qHFmAOwBKxm4Gunswd5HaOYWMc=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=DRzrtDRxivBG2YuVX/DXMcioxpr4EvMZoTv8mudu5vSybeOU/L9dM21BtX1VyYQctJG4ZgtoVfyXnABXzBl8BWpeuPicnO7gEFTg26lQx+zNQWY7RhagXC3LT+W287NCYYjNdP44hT0ckOG6omHRGpNkAOm57Onro7b9ik1L8Pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XC34EHse; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XC34EHse"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B7631F000E9;
	Wed, 26 Aug 2026 11:16:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787742967;
	bh=IIRv0wK/j9FwfIwCkQYoFkzmxtN0k9V5TdAR70ziAZs=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=XC34EHsezb980Yqy+q9+JKJEjlLUTAIYKG4aAKOy+B8mYnfuGXxH2Bd2bDuToz2Zi
	 2ifZEo0V9YgUIbDy60YTgAAapOKBpF/CTDL5vAEWrdbcoghC2ruNjr1b/rZYYff7xU
	 0m/dMeMMl0hsGxkEK7P/wqdJB7gc033JsJCuzSwDckfDkdCBF4rOULxGuqjN/UO8og
	 CDW+kGXeukffx8nBpGcUjyGBOVgDqC/tJfcG/1oNOtbZDVkrtdYPDtpcKgQPWYOBWJ
	 e3XgKV3366Ve0ELBi3A1twZAT/IpKMa9/4Rb8q+IP/Aqopsp5r9IXAPs9aHsgukrbl
	 M23hR1pVUHPOg==
Content-Type: multipart/mixed; boundary="===============2489781423379362181=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <df5a55306918f6a83693a91db252f1e653602f35144e6ad189d502acb8b19ed0@mail.kernel.org>
In-Reply-To: <20260826103615.932094-1-pulehui@huaweicloud.com>
References: <20260826103615.932094-1-pulehui@huaweicloud.com>
Subject: Re: [PATCH bpf] bpf: Fix UAF due to concurrent consumption of waiting_for_gp_ttrace
From: bot+bpf-ci@kernel.org
To: pulehui@huaweicloud.com,bpf@vger.kernel.org,linux-kernel@vger.kernel.org
Cc: ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,yonghong.song@linux.dev,song@kernel.org,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev,pulehui@huawei.com,pulehui@huaweicloud.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed, 26 Aug 2026 11:16:06 +0000 (UTC)

--===============2489781423379362181==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

>     alloc_bulk() runs in an IRQ context (serving as an implicit normal RCU
>     read-side critical section), an RCU Tasks Trace GP cannot complete while
>     alloc_bulk() is accessing the list.

Is this accurate on CONFIG_PREEMPT_RT? Looking at init_refill_work() in
kernel/bpf/memalloc.c, it uses init_irq_work() without IRQ_WORK_INIT_HARD,
so on RT the irq_work goes to lazy_list and is executed by the preemptible
per-CPU 'irq_work/N' kthread, not in hardirq context. The allocator's own
comment says "In RT irq_work runs in per-cpu kthread."

The conclusion still holds because run_irq_workd() wraps
irq_work_run_list(&lazy_list) in guard(rcu)(), making it an explicit RCU
read-side critical section on RT. So alloc_bulk() is protected by RCU, but
the stated reason ('IRQ context') is only true on !RT.

Could the commit message clarify that the RCU-reader property comes from
hardirq on !RT and explicit rcu_read_lock() in run_irq_workd() on RT?

>     Thus, the callback __free_rcu cannot run concurrently, ruling out
>     missing RCU read-side locks as the cause.

Can __free_rcu really not run concurrently with alloc_bulk()? The race
diagram two paragraphs later shows exactly that happening:

CPU0                                           CPU1
                                               __free_rcu (RCU Tasks Trace callback)
alloc_bulk (irq context)
  llist_del_first(&c->waiting_for_gp_ttrace)
    entry = smp_load_acquire(&head->first);
                                               free_all(llist_del_all(&c->waiting_for_gp_ttrace))
    next = READ_ONCE(entry->next); <-- trigger UAF

Looking at the guarantees from 57b23c0f612d, the RCU Tasks Trace GP
contains at least one synchronize_rcu(), which waits for alloc_bulk()
invocations that started before that internal synchronize_rcu(). But a
fresh alloc_bulk() entered after the GP expired is not waited for, and
__free_rcu can run while that fresh invocation is in flight.

So what's actually true is narrower: a ttrace GP cannot expire while an
alloc_bulk() read section that began before the GP's internal
synchronize_rcu() is still in flight. A fresh alloc_bulk() after the GP
expired can race with __free_rcu().

Could the explanation be more precise about which alloc_bulk() invocations
are protected and which can race?

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

[ ... ]

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
                          ^^^^^^^^^^^^^^^^^^^^^^^^^

Does free_mem_alloc() wait for this new callback? Looking at the teardown
path:

kernel/bpf/memalloc.c:free_mem_alloc() {
    /*
     * Trace grace period implies RCU grace period, so all __free_rcu
     * don't need extra call_rcu() (and thus extra rcu_barrier() here).
     */
    rcu_barrier();               /* wait for __free_by_rcu */
    rcu_barrier_tasks_trace();   /* wait for __free_rcu */
    free_mem_alloc_no_barrier(ma);
        -> free_percpu(ma->cache) / free_percpu(ma->caches)
}

The barriers run in that order: normal RCU first, then tasks-trace. If
__free_rcu() executes during rcu_barrier_tasks_trace() and queues
call_rcu(&c->rcu_reclaim, __free_final_rcu), there's no rcu_barrier()
left to wait for it. So free_percpu() runs while __free_final_rcu() is
still queued on the now-freed per-cpu memory.

Concrete sequence:
1. do_call_rcu_ttrace() queues call_rcu_tasks_trace(&c->rcu_ttrace,
   __free_rcu)
2. Map destroyed, destroy path computes rcu_in_progress >= 1 from
   atomic_read(&c->call_rcu_ttrace_in_progress), takes deferred path
3. free_mem_alloc(): rcu_barrier() at 716 completes, rcu_barrier_tasks_trace()
   at 717 waits for __free_rcu() which runs and queues call_rcu(&c->rcu_reclaim,
   __free_final_rcu), barrier returns with normal-RCU callback newly queued
4. free_mem_alloc_no_barrier() frees the per-cpu memory holding c
5. When normal grace period ends, __free_final_rcu() runs on freed memory

Also, drain_mem_cache() drains seven lists but not waiting_for_reclaim_gp,
and check_mem_cache() WARN_ON_ONCE()s on those seven but never inspects
waiting_for_reclaim_gp, so the leak is silent.

Does this need an rcu_barrier() after rcu_barrier_tasks_trace() (or the
two swapped plus an added one)? And should the comment at lines 706-715
be updated since it now says the opposite of what the code does?

Also note check_mem_cache() should probably check waiting_for_reclaim_gp.

The same llist_del_first-vs-llist_del_all hazard that this patch fixes
for waiting_for_gp_ttrace also exists on free_by_rcu_ttrace. Looking at
kernel/bpf/memalloc.c:

alloc_bulk() does:
    obj = llist_del_first(&c->free_by_rcu_ttrace);

while do_call_rcu_ttrace() does:
    llnode = llist_del_all(&c->free_by_rcu_ttrace);
    ...
    free_all(c, llnode, percpu);  /* draining path, immediate free */

and drain_mem_cache() does:
    free_all(llist_del_all(&c->free_by_rcu_ttrace), ...);

include/linux/llist.h's concurrency table marks the del_first x del_all
cell 'L' (lock is needed) and the kerneldoc on llist_del_first says "If
multiple consumers are needed, please use llist_del_all or use lock
between consumers."

The non-draining path in do_call_rcu_ttrace() is incidentally covered by
the new extra GP because nodes end up in waiting_for_gp_ttrace, but the
draining direct-free and drain_mem_cache()'s free_all() still free without
any RCU deferral.

Does free_by_rcu_ttrace need the same treatment?

While the nodes sit in c->waiting_for_reclaim_gp they are invisible to
alloc_bulk()'s reuse loop, so for one extra normal RCU GP the allocator
must kmalloc() instead of reusing. This partially undoes the optimization
being fixed.

Is this expected? Should the commit message mention it?

The commit message says "Syzkaller repeatedly triggered" but carries no
Reported-by:, Closes: or Link: tag, and the splat is from a private 6.6.0+
tree rather than upstream syzbot.

Also, Hou Tao reported this exact hazard during review of 04fabf00b4d3 in
July 2023 (lore.kernel.org/rcu/957dd5cd-0855-1197-7045-4cb1590bd753@huaweicloud.com).
Alexei's reply was that the probability was "lower than a bit flip due to
cosmic rays."

Could citing that thread make the analysis more credible and give proper
credit to Hou Tao?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/32959494022
--===============2489781423379362181==--
