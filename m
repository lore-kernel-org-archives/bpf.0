Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17B94374A0D;
	Thu, 27 Aug 2026 09:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787822663; cv=none; b=hZzuK/Fs9J3rikFQkDy3pKVslzckGUODLnEDnUBqYLHqAACxmaVwmV/teRJBxdcqJy1jRo7nY+UJpzkfgUON1GSJ7MbqLny10oi4zygFDx9pgA6W5HKfA1hypO6JsA6dZS8vD7HM6/TrZtNUwyW87sgaglEHL5ctwJMojUbf7kM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787822663; c=relaxed/simple;
	bh=yi4FWFFW1R9BUZu6btzY5pw2690an4UD3knvqdlAEOo=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=M1TMSxbPJJQG+17HuOzMrdT5t5LKuQT0w+CFceOzOPPNpN8f0oFi8bfSDoe3gGP+jn5qfv0TKisVUEJUkRUL5FR/JbQrqfULz8YCmC+mBKzbAqR/Ii6MFyD7SQx2xKya8CgzD17Y6rDIlYvthDttBKcg4t4IoSscmMCF2gclWtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y2xtxj9C; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y2xtxj9C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 628BB1F00A3A;
	Thu, 27 Aug 2026 09:24:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787822661;
	bh=KWVAY4BZ3AVEK1ZPL4CSPdCNNEjWfyQJVycszOUYYdk=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=Y2xtxj9CpGQi82+p0am0fd5nxq0UbocVfTNAhhNfSWyqV2qQ8pvyX2jQLgqLtsWBM
	 Z2PYIjBLi7x5XtKxDcUSrPY5hIN1y2C36psXgZCMV9xn052YRXSsjx7fmYua6Pa4u+
	 G0Wo26E76flf613VBTTnwhG+oAEAnirucapw0kLRiEFWSVGThTD/DL5Y2A4coRcCXk
	 OK1LYAmSrGSOkH2EwRNs0H5lFx+dN1ePf6oVz2TY0zdehlxH/RUx1SttU2DAH/1tw3
	 n8ekW6raji6ih5s3cJ1KC8hAqci/K4il/upym8K8EaAYIWlnOId0Hg2UNFyJsuaQ1s
	 UHXCgsJw1banQ==
Content-Type: multipart/mixed; boundary="===============4410778294104359820=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <497836f1914121810fa01a9a601342ad32a7fc76d62efebb02121d7b9f2e96e4@mail.kernel.org>
In-Reply-To: <20260827084013.1062816-1-pulehui@huaweicloud.com>
References: <20260827084013.1062816-1-pulehui@huaweicloud.com>
Subject: Re: [PATCH bpf v2] bpf: Fix UAF due to concurrent consumption of waiting_for_gp_ttrace
From: bot+bpf-ci@kernel.org
To: pulehui@huaweicloud.com,bpf@vger.kernel.org,linux-kernel@vger.kernel.org,houtao@huaweicloud.com
Cc: ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,yonghong.song@linux.dev,song@kernel.org,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev,pulehui@huawei.com,pulehui@huaweicloud.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Thu, 27 Aug 2026 09:24:21 +0000 (UTC)

--===============4410778294104359820==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/memalloc.c b/kernel/bpf/memalloc.c
> index e9662db7198f..58296e92a4fe 100644
> --- a/kernel/bpf/memalloc.c
> +++ b/kernel/bpf/memalloc.c

[ ... ]

> @@ -297,6 +307,7 @@ static void enque_to_free(struct bpf_mem_cache *c, void *obj)
>  static void do_call_rcu_ttrace(struct bpf_mem_cache *c)
>  {
>  	struct llist_node *llnode, *t;
> +	unsigned long flags;
>
>  	if (atomic_xchg(&c->call_rcu_ttrace_in_progress, 1)) {
>  		if (unlikely(READ_ONCE(c->draining))) {
> @@ -307,8 +318,10 @@ static void do_call_rcu_ttrace(struct bpf_mem_cache *c)
>  	}
>
>  	WARN_ON_ONCE(!llist_empty(&c->waiting_for_gp_ttrace));
> +	raw_spin_lock_irqsave(&c->lock, flags);
>  	llist_for_each_safe(llnode, t, llist_del_all(&c->free_by_rcu_ttrace))
> -		llist_add(llnode, &c->waiting_for_gp_ttrace);
> +		__llist_add(llnode, &c->waiting_for_gp_ttrace);
> +	raw_spin_unlock_irqrestore(&c->lock, flags);

Can this loop iteration count be bounded? The critical section covers
the whole free_by_rcu_ttrace -> waiting_for_gp_ttrace transfer, so
c->lock is held with IRQs disabled for a number of iterations that has
no upper bound.

free_by_rcu_ttrace is filled from enque_to_free() by free_bulk() and,
more significantly, by the batch append in __free_by_rcu():

kernel/bpf/memalloc.c:__free_by_rcu() {
    llist_add_batch(llnode, c->waiting_for_gp_tail,
                    &tgt->free_by_rcu_ttrace);
}

That batch is the whole c->waiting_for_gp chain, which builds from
every bpf_mem_free_rcu()/unit_free_rcu() that happened while
call_rcu_in_progress was set, proportional to the object-free rate
without any watermark. While call_rcu_ttrace_in_progress is set,
successive __free_by_rcu() invocations keep appending without anything
draining it, so batches accumulate across rounds.

Compare the other new critical sections in the patch, which are all
O(1): __llist_del_all in __free_rcu and drain_mem_cache, or bounded by
c->batch in alloc_bulk (roughly 48 iterations max). Only this one is
unbounded, and raw_spinlock_t + irqsave means it is non-preemptible
even on PREEMPT_RT, where do_call_rcu_ttrace() is reached from the
rcuc/rcuop kthread via __free_by_rcu().

The lock is only needed for the destination list. llist_del_all() on
free_by_rcu_ttrace is an xchg and is already safe against concurrent
llist_add() producers without a lock. Could the chain be re-linked (or
its tail found) outside the lock and spliced into waiting_for_gp_ttrace
with a single __llist_add_batch() under the lock, keeping the IRQ-off
window O(1)?

[ ... ]

> @@ -620,6 +634,8 @@ int bpf_mem_alloc_percpu_unit_init(struct bpf_mem_alloc *ma, int size)
>  static void drain_mem_cache(struct bpf_mem_cache *c)
>  {
>  	bool percpu = !!c->percpu_size;
> +	struct llist_node *llnode;
> +	unsigned long flags;
>
>  	/* No progs are using this bpf_mem_cache, but htab_map_free() called
>  	 * bpf_mem_cache_free() for all remaining elements and they can be in
> @@ -629,7 +645,10 @@ static void drain_mem_cache(struct bpf_mem_cache *c)
>  	 * on these lists, so it is safe to use __llist_del_all().
>  	 */
>  	free_all(c, llist_del_all(&c->free_by_rcu_ttrace), percpu);
> -	free_all(c, llist_del_all(&c->waiting_for_gp_ttrace), percpu);
> +	raw_spin_lock_irqsave(&c->lock, flags);
> +	llnode = __llist_del_all(&c->waiting_for_gp_ttrace);
> +	raw_spin_unlock_irqrestore(&c->lock, flags);
> +	free_all(c, llnode, percpu);

Does the comment above need updating? It says "Except for
waiting_for_gp_ttrace list, there are no concurrent operations on these
lists, so it is safe to use __llist_del_all()."

Before the patch the comment matched the code: waiting_for_gp_ttrace
was the one list drained with the atomic llist_del_all(), and the
comment named it as the exception to "safe to use __llist_del_all()".

After the patch waiting_for_gp_ttrace is the list that does use
__llist_del_all() (now serialised by c->lock), while free_by_rcu_ttrace
and waiting_for_gp still use the atomic llist_del_all(). The sentence
now points at the opposite list from the code, and no longer explains
why the new lock is needed here.

A reader trying to work out which lists still need atomic accessors
after this change gets the wrong answer from the comment. Should the
comment say that concurrent consumption of waiting_for_gp_ttrace is now
excluded by c->lock, so plain __llist_del_all() is safe, while
free_by_rcu_ttrace / waiting_for_gp still need the atomic variants?

[ ... ]

commit 03e0a12c3be3d11fe9a3b87582070b2158a7bb74
Author: Pu Lehui <pulehui@huawei.com>

>     bpf: Fix UAF due to concurrent consumption of waiting_for_gp_ttrace
>
>     Syzkaller repeatedly triggered UAF splats related to nodes in
>     waiting_for_gp_ttrace within the bpf memalloc:

[ ... ]

>     This is expected because, as noted in commit 57b23c0f612d ("bpf: Retire
>     rcu_trace_implies_rcu_gp()"), an RCU Tasks Trace GP currently implies
>     (and will continue to imply in the future) a normal RCU GP. Since
>     alloc_bulk() runs in an RCU read-side CS (!PREEMPT_RT runs in IRQ
>     context, PREEMPT_RT runs with guard(rcu)), an RCU Tasks Trace GP cannot
>     complete while alloc_bulk() is accessing the list. Thus, the callback
>     __free_rcu cannot run concurrently, ruling out missing RCU read-side
>     locks as the cause. And same for free_by_rcu_ttrace list.

Is the statement "Thus, the callback __free_rcu cannot run concurrently"
accurate as written?

Looking at the race diagram three paragraphs later, it shows exactly
that scenario: __free_rcu on CPU1 executing in the middle of
alloc_bulk's llist_del_first on CPU0. What the RCU argument actually
establishes is narrower: the GP cannot complete during the particular
read-side CS it is waiting on, so RCU read-side protection is not what
is missing.

Nothing prevents a new alloc_bulk() from starting after the GP has
completed and running concurrently with the callback. __free_rcu runs
from the rcu_tasks_trace kthread (process context, no irqs disabled, any
CPU) while alloc_bulk runs from irq_work on the cache's own CPU; on
PREEMPT_RT alloc_bulk is even preemptible, so same-CPU interleaving is
possible too.

A reviewer reading this sentence literally would conclude the race in
the diagram is impossible. Could the paragraph say "RCU read-side
protection is not what is missing; what is missing is mutual exclusion
between the two llist consumers"?

>     Note that free_by_rcu_ttrace does not suffer from this issue as it only
>     has a single active consumer during normal operation.

Is this premise correct? free_by_rcu_ttrace has two distinct consumers,
and they are not confined to one CPU:

  - alloc_bulk() memalloc.c:225 (still outside c->lock):

    obj = llist_del_first(&c->free_by_rcu_ttrace);

  - do_call_rcu_ttrace() memalloc.c:322, and drain_mem_cache()
    memalloc.c:647:

    llist_del_all(&c->free_by_rcu_ttrace)

do_call_rcu_ttrace() is called as do_call_rcu_ttrace(tgt) with
tgt = c->tgt from free_bulk() (memalloc.c:341, 364) and __free_by_rcu()
(memalloc.c:370, 383). c->tgt is set to the cache that allocated the
object, potentially another CPU's cache:

kernel/bpf/memalloc.c:unit_free() {
    c->tgt = *(struct bpf_mem_cache **)llnode;
}

So llist_del_all(&tgt->free_by_rcu_ttrace) on CPU1 can run concurrently
with llist_del_first(&tgt->free_by_rcu_ttrace) in alloc_bulk(tgt) on
tgt's own CPU. The file's own comment at memalloc.c:220-224 says as
much: "Other CPUs might llist_add() and llist_del_all() in parallel."

What actually keeps that pair harmless in the common case is the RCU
deferral the changelog describes earlier, not single-consumer-ness: the
nodes taken by llist_del_all() are moved to waiting_for_gp_ttrace and
only freed by __free_rcu() after an RCU tasks trace GP, which cannot
elapse while alloc_bulk() is inside its RCU read-side section. That
argument does not cover the two draining paths, which free immediately
while still only being ordered against alloc_bulk() by
WRITE_ONCE(c->draining, true) / irq_work_sync().

Since the changelog is what a reviewer will use to decide the fix is
complete, should the sentence be corrected to state the real reason (RCU
deferral) or should the residual draining-path window be acknowledged?

Leon Hwang suggested in the v2 review that scoped_guard() could be used
instead of explicit raw_spin_lock_irqsave/raw_spin_unlock_irqrestore to
simplify the code and avoid needing the flags variable. This is a code
style improvement that would make the locking more idiomatic. The
suggestion applies to multiple locations: alloc_bulk(), __free_rcu(),
do_call_rcu_ttrace(), and drain_mem_cache(). Is this something worth
addressing before merge?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/33055527430
--===============4410778294104359820==--
