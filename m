Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6310B1DED49
	for <bpf@vger.kernel.org>; Thu, 15 Oct 2026 00:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792024410; cv=none; b=Vn2Tha9SaEigdI3uhkqd7hPVx1tEccXbHbGMgT4rq9bMpwekAGXcG8yXPnTlmUApIyiJpPIz+WROBe5r2Tx+MQ1Yyf9N7cPs3DF2rybqQv53WnXRcpQqGeaebd4kBY24mMW73g1ZaWnOFdxo9bI1IbikURbQYgi+HUwJZgua4t8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792024410; c=relaxed/simple;
	bh=iUzadXgwjw2M2xzXaF0Xf0TbM9QXrYqMI80k3EAQPzA=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=KcSRi7yti6VZ7jw5lx7sBGP8WTdnjp0p+WGnKa8hl6WGdFPv5XEkSXQJYgw/EIuOdX9os9CbSqliQ9oIbkbCfOrIqWiexI9keuDuKdzDwHEDLKdQRrx7G5EnJxM1ZSBVRiEuGq1OXy8dW3+By5DkhBpVwAcyva9Cn7/wqTB0O20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IjxgObEw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IjxgObEw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACAA01F000C4;
	Thu, 15 Oct 2026 00:33:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792024408;
	bh=KzpvuJk+DQx50JCBdbadqQB9TZFy661LAcRuwsCJmKM=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=IjxgObEwHmFE+QjkGdFBo4jGjxgKZ/ADHla6pyRuE6nA/dQrQg2zWSw1k7pQ4DfKq
	 jan21SiCC6+gX8VMhXESHAfSFbNiZNLz93frRFC4ri4l4MPIJLCvV+j7cvio4QOGFV
	 lXlMqxYRV1sSsF6omEesKgypw8X19IIRdrUJrRZpYyJAmnI7FnzNGTT5MtvcGxzi+X
	 k4Gt93for+W+fYhwzyOK3RgXL2P83PRozmnh/gJLFC6SDZEL/rDYHdsLmhKclyeWOj
	 6nLX/U02Stv1aHTS3vIt+NAEbzwx3tCtsLh2JDxeLME7uTr+Y/+jhR6/YF9vy0/tTi
	 7OLfiF1GzSM/g==
Content-Type: multipart/mixed; boundary="===============7714819288175777040=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <3b6aa67f3b7a066bee2276c466b6b572a909e716e2f818606fec4ef1d8fcaad6@mail.kernel.org>
In-Reply-To: <20261014233442.8392-8-emil@etsalapatis.com>
References: <20261014233442.8392-8-emil@etsalapatis.com>
Subject: Re: [PATCH bpf-next v4 7/8] bpf: Synchronize arena page faults with page freeing
From: bot+bpf-ci@kernel.org
To: emil@etsalapatis.com,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,daniel@iogearbox.net,emil@etsalapatis.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Thu, 15 Oct 2026 00:33:27 +0000 (UTC)

--===============7714819288175777040==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Synchronize arena page faults with page freeing

TL;DR:
- Arena faults may busy-loop on VM_FAULT_RETRY while any free runs
- Free worker may requeue itself in a CPU spin while a fault is in flight
- Deferred frees may be dropped if kmalloc_nolock() fails

> diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
> --- a/kernel/bpf/arena.c
> +++ b/kernel/bpf/arena.c

[ ... ]

> +static bool arena_opref_get(struct bpf_arena *arena, enum arena_opref ref)
> +{
> +	int users = atomic_read(&arena->opref);
> +
> +	do {
> +		if (users && (users ^ ref) < 0)
> +			return false;
> +	} while (!atomic_try_cmpxchg_acquire(&arena->opref, &users, users + ref));
> +	return true;
> +}
> +
> +static void arena_opref_put(struct bpf_arena *arena, enum arena_opref ref)
> +{
> +	if (atomic_fetch_sub_release(ref, &arena->opref) == ref)
> +		wake_up_all(&arena->opwait);
> +}

[ ... ]

> @@ -542,19 +571,28 @@ static void arena_vm_close(struct vm_area_struct *vma)
>  static vm_fault_t arena_vm_fault(struct vm_fault *vmf)
>  {
[ ... ]
> +	if (!arena_opref_get(arena, ARENA_OPREF_FAULT)) {
> +		if (vmf->flags & FAULT_FLAG_ALLOW_RETRY)
> +			goto retry;
> +		/* zap_pages() does not need the fault caller's mmap_lock. */
> +		wait_event(arena->opwait, arena_opref_get(arena, ARENA_OPREF_FAULT));
> +	}

When a free currently holds ARENA_OPREF_FREE and FAULT_FLAG_ALLOW_RETRY is
set, this jumps to retry: which calls release_fault_lock() and returns
VM_FAULT_RETRY without waiting for the free to finish.  Can this turn into
a busy loop in the faulting thread?

The test is on FAULT_FLAG_ALLOW_RETRY rather than
fault_flag_allow_retry_first(), and the arch fault handlers keep
FAULT_FLAG_ALLOW_RETRY set when they add FAULT_FLAG_TRIED.  On x86,
do_user_addr_fault() does:

    if (unlikely(fault & VM_FAULT_RETRY)) {
        flags |= FAULT_FLAG_TRIED;
        goto retry;
    }

so the retried attempt reaches the same check, fails arena_opref_get()
again, and returns VM_FAULT_RETRY again:

    lock_mm_and_find_vma()
      handle_mm_fault()
        __do_fault()    (also allocates and frees a prealloc PTE page
                         when the PMD is empty)
          arena_vm_fault()
            mmap_read_unlock()
            goto retry

The thread spins in kernel mode for as long as a free holds
ARENA_OPREF_FREE.  A free can hold it across work that sleeps or runs long:

    wait_for_faults() -> folio_wait_locked()
    zap_pages() -> i_mmap_lock_read() and zap_vma_range(), over up to the
                   whole 4 GiB arena
    arena_put_page() -> lock_page(), for every freed page

Before this patch a fault only took the busy -EAGAIN path when it hit a page
inside the range being freed.  With this patch, a fault anywhere in the
arena spins while any free is running.  Every arch with arena JIT support
selects PREEMPT_LAZY, so tick preemption bounds the spin and it is not a
permanent hang, but it is still an unbounded busy wait.

The usual MM convention (see __folio_lock_or_retry()) is to drop the fault
lock, sleep until the condition can be met, and then return VM_FAULT_RETRY
on the first attempt, blocking on the FAULT_FLAG_TRIED attempt.  The opwait
waitqueue added here would allow that, for example:

    release_fault_lock(vmf);
    wait_event(arena->opwait, atomic_read(&arena->opref) <= 0);
    return VM_FAULT_RETRY;

with the existing wait_event() kept for the !fault_flag_allow_retry_first()
case.  Would something like that work?

The existing non-retry wait_event() is also TASK_UNINTERRUPTIBLE with
mmap_read_lock held, and it is woken only when the count returns to exactly
0.  If frees keep overlapping, can the waiter be held off indefinitely?

[ ... ]

> @@ -1130,13 +1203,18 @@ static void arena_free_worker(struct work_struct *work)
[ ... ]
> +	if (!arena_opref_get(arena, ARENA_OPREF_FREE)) {
> +		schedule_work(work);
> +		return;
> +	}

The same busy polling happens in the other direction here.  When a fault
holds ARENA_OPREF_FAULT, arena_free_worker() requeues itself immediately.
The work item clears its pending bit before running, so schedule_work()
always succeeds and the kworker re-runs back to back until the fault count
drops to zero.

Faults can hold that reference for a long time.  arena_vm_fault() takes it
before the preallocation:

    if (!arena_opref_get(arena, ARENA_OPREF_FAULT)) { ... }
    ...
    new_page = alloc_pages_node(map->numa_node,
                                GFP_KERNEL | __GFP_ZERO |
                                __GFP_ACCOUNT | __GFP_NOWARN |
                                __GFP_RETRY_MAYFAIL, 0);

and holds it until after folio_lock_or_retry(), which may sleep in
__folio_lock_or_retry() -> folio_wait_locked{,_killable}().  The
GFP_KERNEL | __GFP_ACCOUNT allocation can enter direct or memcg reclaim, and
when the cgroup is over memory.high, try_charge_memcg() can call
__mem_cgroup_handle_over_high(), which sleeps for up to
MEMCG_MAX_HIGH_DELAY_JIFFIES (2*HZ) in schedule_timeout_killable().  For
that whole time the free worker polls at full CPU on a system_wq worker.

All non-sleepable frees take this path:

    bpf_arena_free_pages_non_sleepable()
      arena_free_pages(..., false)
        irq_work -> arena_free_irq() -> schedule_work()

and so does every sleepable free that sees a fault in flight, because of
this check in arena_free_pages():

    if (!arena_opref_get(arena, ARENA_OPREF_FREE))
            goto defer;

So under memory pressure, when releasing arena memory matters most, are
frees postponed while a CPU spins?  Before this patch the worker requeued
only on an rqspinlock failure or when a range overlapped another free.

A related side effect: sleepable frees that used to complete synchronously
now go to the defer path whenever any fault is in flight.  If
kmalloc_nolock() fails there, does the free get silently dropped, leaving the
pages allocated until the arena is destroyed?

arena_opref_put() already calls wake_up_all(&arena->opwait) when the fault
count goes from -1 to 0, but no free-side path waits on opwait, so that
wakeup has no consumer.  Could the worker, which already sleeps in
wait_for_faults(), zap_pages() and lock_page(), instead do:

    wait_event(arena->opwait, arena_opref_get(arena, ARENA_OPREF_FREE));

Alternatively, could the fault take its admission only after the sleeping
preallocation?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/38657686181
--===============7714819288175777040==--
