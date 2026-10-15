Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7622453D0A7
	for <bpf@vger.kernel.org>; Thu, 15 Oct 2026 15:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792077507; cv=none; b=BiezoWYX6S0ddkUpGPmIIIJv/cENYQcVOGCncGZ10LvMGROFbEO74jYw1DTo8jT2IPcnFw60F4tJWyxx+0jXGweX8wJAk+wV745+1hWgMyUuy0UJoPWufTOSul0xztpXsVLXl7zrzXwk74QZcWcQ8tW8+aHIQ7nM/yDVxI69rVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792077507; c=relaxed/simple;
	bh=624zeTfaa7LG7/Yw9IbQnp6HK8xQYZLCO4j9mDqNKmg=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=Aam7fn4p/ST4FdrYKvCgo1sMqjeNCyl2pX20TAoLNkTn8MRgqQ/CepGQH42kOSl+RpfYpalk4nIm4XukmJtQ8pOdLXL/tBje/dT4kfPUo7UUHxlwZfIfrPy/BHBfSaxldCbl5dqr1vL20DELPgP50zlh5OYyIAMPvgUjx/HYx7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=XMz4Ifz6; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="XMz4Ifz6"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4a16bc2278aso38937625e9.1
        for <bpf@vger.kernel.org>; Thu, 15 Oct 2026 08:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1792077502; x=1792682302; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=MaVUv32qgJuV4W/ldS77HsEf4QwUOPUz1tcehhnhpFE=;
        b=XMz4Ifz6qOlIcovZCm1dVKKQvexsDY0jRi1DEP7JbYEt94sX7nBFZY3sZ7yMQY+YyN
         LZLigPdkRAE5ELetFOT3eRQB32rcWAqSbs5Y4tAhaROg+AMWB2g1EN/iSu3mV2MHd9sj
         g00wHLUrcQMBopcM2nCYYftNiDIMVMEBD/2MSybN8MA1hifVvLv6YD7xJQHhfHNXSgxe
         1MCG1PUePAa638o9Ojr5oR3udkMsrSLeiyYnpwtJ1p6z4pRbw+SsUb6bcCbtqS4BN63g
         eLH51/9YqR1S9sOcf8lihuhYEC/FQn5vaaqxDOkdR+bpBIpxfqIU69S5mFTegtp8nChQ
         mwYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792077502; x=1792682302;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MaVUv32qgJuV4W/ldS77HsEf4QwUOPUz1tcehhnhpFE=;
        b=paoJwbCrQL1OOiCYeD9GYA0ik5h7wDpaJWl6ncDFoDvVKf9GNjrrdP8OR1ni0DHLXb
         hXZlxcmc63nSe0lMXY5WYOkk4C6zHGNRLr3eK5VhZxFuVn2coo6EJu1Bg5cYCt8aLasF
         fMN+5eGWgtOmxVwX40kxwMLHGzGq5YmXNHObFS6VsT5fVySfijroWBDXKl4sqiJ8cYHf
         BkAXMZnaPbHpfaM1k27YB4hOPlLgps0JJTs6FoDe7iwE4oNm5WxOvSXyPYdRFaW64sjT
         A3ii4z9zC/P+EwiMEWSXSjFBkgzdAzJrJtO4+SU300ns0sHWYAJpBFJMDDkt3UwKMF1C
         QfKA==
X-Forwarded-Encrypted: i=1; AKwUvBwePFPMqFkFwiewbiFKMtplJdHGtRTdCJZE6u9PATgZ48rh2swMztljdnKwyr4Y84qiZ6U=@vger.kernel.org
X-Gm-Message-State: AFq9FYJRMgwJHNMxiqD+bWQiiEAm2NDED1tF+tli2t70Mf8oYwFQUmPy
	SUvfWODw99kKe+7BquQ4DWRwRNLy7Do7GipWlueA3F0wNrIIN2BmjeTIKaYxIbROxXw=
X-Gm-Gg: AYBFou1RjhI8sMgGG/P8pisOsSTF3SquGE7As2A4gF1lt600Va8o+d8q4w5+NzCFaCx
	rNnGW7Bj4nCMMD38U4IIz14tsaEZPO89poMtXZaPYCYhX9PfvReRKEvPlK4TesWXL/PScjCeRgI
	h/TpeAvLN8kd18vKG4ZV+Yr/3O0OACmDxtg2SUmUv/wuCZycBck7QtBo2l3LpOZkc3TVVyt0wIH
	TH2rm3v7rIFZzF09VwpR6UQrjeS+GSS7n223d6crSRmh0OWIRctfutofA8iqQbz95VVx9vIzgAl
	5LgDI9Wvlx3gVrENtvKytp2X1V06nbPlm4da29KI8E2TegaIbRuMtadvR2JQpstX3LgKq/75PGV
	3miCXsE6UbCqfhYIN9SKZqjuAQF7Lt+4QJ7GSLOE3vB3Z2Qh3kLyXzV9NDOzuQHzG3yK2mdthD/
	6O6iDMS/qKxM/lHMxx0ICRGAZktQyoSMhdRyuJxZZUbxBXM/oW3PE=
X-Received: by 2002:a05:600c:6990:b0:4a0:1ea1:477a with SMTP id 5b1f17b1804b1-4a18e4d8bbamr346299595e9.27.1792077501740;
        Thu, 15 Oct 2026 08:18:21 -0700 (PDT)
Received: from localhost ([2620:10d:c090:600::1:2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1bd96f9a0sm76246975e9.1.2026.10.15.08.18.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Oct 2026 08:18:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 15 Oct 2026 15:18:14 +0000
Message-Id: <DM5IGBG43VV3.10SCYNYXURJXE@etsalapatis.com>
Cc: <ast@kernel.org>, <andrii@kernel.org>, <eddyz87@gmail.com>,
 <memxor@gmail.com>, <daniel@iogearbox.net>, <martin.lau@kernel.org>,
 <yonghong.song@linux.dev>, <mason@kernel.org>, <ihor.solodrai@linux.dev>
Subject: Re: [PATCH bpf-next v4 7/8] bpf: Synchronize arena page faults with
 page freeing
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: <bot+bpf-ci@kernel.org>, <emil@etsalapatis.com>, <bpf@vger.kernel.org>
X-Mailer: aerc 0.21.0
References: <20261014233442.8392-8-emil@etsalapatis.com>
 <3b6aa67f3b7a066bee2276c466b6b572a909e716e2f818606fec4ef1d8fcaad6@mail.kernel.org>
In-Reply-To: <3b6aa67f3b7a066bee2276c466b6b572a909e716e2f818606fec4ef1d8fcaad6@mail.kernel.org>

On Thu Oct 15, 2026 at 12:33 AM UTC, bot+bpf-ci wrote:
>> bpf: Synchronize arena page faults with page freeing
>
> TL;DR:
> - Arena faults may busy-loop on VM_FAULT_RETRY while any free runs
> - Free worker may requeue itself in a CPU spin while a fault is in flight
> - Deferred frees may be dropped if kmalloc_nolock() fails

Out of the concerns I only one that isn't preexisting is the free worker co=
nstantly
being requeued being used as a way to cause high CPU usage without billing =
it to
the process. We can prioritize frees over page faults to make sure that fre=
es
cannot be delayed indefinitely.

>
>> diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
>> --- a/kernel/bpf/arena.c
>> +++ b/kernel/bpf/arena.c
>
> [ ... ]
>
>> +static bool arena_opref_get(struct bpf_arena *arena, enum arena_opref r=
ef)
>> +{
>> +	int users =3D atomic_read(&arena->opref);
>> +
>> +	do {
>> +		if (users && (users ^ ref) < 0)
>> +			return false;
>> +	} while (!atomic_try_cmpxchg_acquire(&arena->opref, &users, users + re=
f));
>> +	return true;
>> +}
>> +
>> +static void arena_opref_put(struct bpf_arena *arena, enum arena_opref r=
ef)
>> +{
>> +	if (atomic_fetch_sub_release(ref, &arena->opref) =3D=3D ref)
>> +		wake_up_all(&arena->opwait);
>> +}
>
> [ ... ]
>
>> @@ -542,19 +571,28 @@ static void arena_vm_close(struct vm_area_struct *=
vma)
>>  static vm_fault_t arena_vm_fault(struct vm_fault *vmf)
>>  {
> [ ... ]
>> +	if (!arena_opref_get(arena, ARENA_OPREF_FAULT)) {
>> +		if (vmf->flags & FAULT_FLAG_ALLOW_RETRY)
>> +			goto retry;
>> +		/* zap_pages() does not need the fault caller's mmap_lock. */
>> +		wait_event(arena->opwait, arena_opref_get(arena, ARENA_OPREF_FAULT));
>> +	}
>
> When a free currently holds ARENA_OPREF_FREE and FAULT_FLAG_ALLOW_RETRY i=
s
> set, this jumps to retry: which calls release_fault_lock() and returns
> VM_FAULT_RETRY without waiting for the free to finish.  Can this turn int=
o
> a busy loop in the faulting thread?
>
> The test is on FAULT_FLAG_ALLOW_RETRY rather than
> fault_flag_allow_retry_first(), and the arch fault handlers keep
> FAULT_FLAG_ALLOW_RETRY set when they add FAULT_FLAG_TRIED.  On x86,
> do_user_addr_fault() does:
>
>     if (unlikely(fault & VM_FAULT_RETRY)) {
>         flags |=3D FAULT_FLAG_TRIED;
>         goto retry;
>     }
>
> so the retried attempt reaches the same check, fails arena_opref_get()
> again, and returns VM_FAULT_RETRY again:
>
>     lock_mm_and_find_vma()
>       handle_mm_fault()
>         __do_fault()    (also allocates and frees a prealloc PTE page
>                          when the PMD is empty)
>           arena_vm_fault()
>             mmap_read_unlock()
>             goto retry
>
> The thread spins in kernel mode for as long as a free holds
> ARENA_OPREF_FREE.  A free can hold it across work that sleeps or runs lon=
g:
>
>     wait_for_faults() -> folio_wait_locked()
>     zap_pages() -> i_mmap_lock_read() and zap_vma_range(), over up to the
>                    whole 4 GiB arena
>     arena_put_page() -> lock_page(), for every freed page
>
> Before this patch a fault only took the busy -EAGAIN path when it hit a p=
age
> inside the range being freed.  With this patch, a fault anywhere in the
> arena spins while any free is running.  Every arch with arena JIT support
> selects PREEMPT_LAZY, so tick preemption bounds the spin and it is not a
> permanent hang, but it is still an unbounded busy wait.
>
> The usual MM convention (see __folio_lock_or_retry()) is to drop the faul=
t
> lock, sleep until the condition can be met, and then return VM_FAULT_RETR=
Y
> on the first attempt, blocking on the FAULT_FLAG_TRIED attempt.  The opwa=
it
> waitqueue added here would allow that, for example:
>
>     release_fault_lock(vmf);
>     wait_event(arena->opwait, atomic_read(&arena->opref) <=3D 0);
>     return VM_FAULT_RETRY;
>
> with the existing wait_event() kept for the !fault_flag_allow_retry_first=
()
> case.  Would something like that work?
>
> The existing non-retry wait_event() is also TASK_UNINTERRUPTIBLE with
> mmap_read_lock held, and it is woken only when the count returns to exact=
ly
> 0.  If frees keep overlapping, can the waiter be held off indefinitely?
>
> [ ... ]
>
>> @@ -1130,13 +1203,18 @@ static void arena_free_worker(struct work_struct=
 *work)
> [ ... ]
>> +	if (!arena_opref_get(arena, ARENA_OPREF_FREE)) {
>> +		schedule_work(work);
>> +		return;
>> +	}
>
> The same busy polling happens in the other direction here.  When a fault
> holds ARENA_OPREF_FAULT, arena_free_worker() requeues itself immediately.
> The work item clears its pending bit before running, so schedule_work()
> always succeeds and the kworker re-runs back to back until the fault coun=
t
> drops to zero.
>
> Faults can hold that reference for a long time.  arena_vm_fault() takes i=
t
> before the preallocation:
>
>     if (!arena_opref_get(arena, ARENA_OPREF_FAULT)) { ... }
>     ...
>     new_page =3D alloc_pages_node(map->numa_node,
>                                 GFP_KERNEL | __GFP_ZERO |
>                                 __GFP_ACCOUNT | __GFP_NOWARN |
>                                 __GFP_RETRY_MAYFAIL, 0);
>
> and holds it until after folio_lock_or_retry(), which may sleep in
> __folio_lock_or_retry() -> folio_wait_locked{,_killable}().  The
> GFP_KERNEL | __GFP_ACCOUNT allocation can enter direct or memcg reclaim, =
and
> when the cgroup is over memory.high, try_charge_memcg() can call
> __mem_cgroup_handle_over_high(), which sleeps for up to
> MEMCG_MAX_HIGH_DELAY_JIFFIES (2*HZ) in schedule_timeout_killable().  For
> that whole time the free worker polls at full CPU on a system_wq worker.
>
> All non-sleepable frees take this path:
>
>     bpf_arena_free_pages_non_sleepable()
>       arena_free_pages(..., false)
>         irq_work -> arena_free_irq() -> schedule_work()
>
> and so does every sleepable free that sees a fault in flight, because of
> this check in arena_free_pages():
>
>     if (!arena_opref_get(arena, ARENA_OPREF_FREE))
>             goto defer;
>
> So under memory pressure, when releasing arena memory matters most, are
> frees postponed while a CPU spins?  Before this patch the worker requeued
> only on an rqspinlock failure or when a range overlapped another free.
>
> A related side effect: sleepable frees that used to complete synchronousl=
y
> now go to the defer path whenever any fault is in flight.  If
> kmalloc_nolock() fails there, does the free get silently dropped, leaving=
 the
> pages allocated until the arena is destroyed?
>
> arena_opref_put() already calls wake_up_all(&arena->opwait) when the faul=
t
> count goes from -1 to 0, but no free-side path waits on opwait, so that
> wakeup has no consumer.  Could the worker, which already sleeps in
> wait_for_faults(), zap_pages() and lock_page(), instead do:
>
>     wait_event(arena->opwait, arena_opref_get(arena, ARENA_OPREF_FREE));
>
> Alternatively, could the fault take its admission only after the sleeping
> preallocation?
>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a =
bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/READM=
E.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/386576=
86181

