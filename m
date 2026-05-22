Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D41AD368D59
	for <bpf@vger.kernel.org>; Fri, 22 May 2026 18:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779473114; cv=none; b=iCfVUqXCS1ihsdnZ9LC8WiNRNXv+GQkA2FF9GM3It104W8ImiV7PLmEEg+ak6pTuU/YEEo0OT8VRTj/w+Kchz4Jg5mYIVF+8JkAC0lxQmMChIu+sVNkCJCTfNpIgz+LW/3d1TOajm/G7y3R1InxUwkCtvasZaIEWly9w4ceTZko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779473114; c=relaxed/simple;
	bh=Xj+OFoLuXhLvGMwXVVrB907QQVD1jZgT2IxH6x4cYa8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QpA1Uu45dKl66aDLZCx7pQZNjV98bic3/3PtxTXqPxgbOlusX3Y7cXceBWuvPTmHQiD/bPn1foN3cL9AV6uJ+oZTd4FyNTUzIYNazpDf3b+z1qSmMCgN3pDdBmn+w/19Zv2pMqw+fpL9EYURdRO2gruUyEkJlv6gukco/9zjFMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=tDxAsecN; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="tDxAsecN"
Message-ID: <7b1a89e6-d473-4ef6-b8de-09c87bda7337@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779473099;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZeYnfArxJw9f8aoySqJcF0s1ka9b0ozSHGV4Y5P7NuA=;
	b=tDxAsecNWd/wvcsBEhqa6y+cMvF8sH5V3F+pUxTPhELnPmQVZvrxWYSN6obmj2jF5ewnKp
	TDA37ceG159xddxfXFL7wCjVIrbw+QOSLO8/Ud1ZLFBLHFmlhO77wT9mCdaJByFXNw8Nho
	FaMiyqgusTiP3xzcKQavJf/OzTBPiqQ=
Date: Fri, 22 May 2026 11:04:41 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v6 2/3] bpf: Avoid faultable build ID reads under
 mm locks
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman
 <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Puranjay Mohan <puranjay@kernel.org>, Shakeel Butt <shakeel.butt@linux.dev>,
 Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-team@meta.com
References: <20260521225022.2695755-1-ihor.solodrai@linux.dev>
 <20260521225022.2695755-3-ihor.solodrai@linux.dev>
 <CAEf4BzZ2i95MaoEt+twNKmw-9FGYbNJ-mLwwHRJ8yAJN7njvwQ@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <CAEf4BzZ2i95MaoEt+twNKmw-9FGYbNJ-mLwwHRJ8yAJN7njvwQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 5/22/26 10:42 AM, Andrii Nakryiko wrote:
> On Thu, May 21, 2026 at 3:51 PM Ihor Solodrai <ihor.solodrai@linux.dev> wrote:
>>
>> Sleepable build ID parsing can block in __kernel_read() [1], so the
>> stackmap sleepable path must not call it while holding mmap_lock or a
>> per-VMA read lock.
>>
>> The issue and the fix are conceptually similar to a recent procfs
>> patch [2].
>>
>> Resolve each covered VMA with a stable read-side reference, preferring
>> lock_vma_under_rcu() and falling back to mmap_read_trylock() only long
>> enough to acquire the VMA read lock. Take a reference to the backing
>> file, drop the VMA lock, and then parse the build ID through
>> (sleepable) build_id_parse_file().
>>
>> We have to use mmap_read_trylock() (and give up on failure) in this
>> context because taking mmap_read_lock() is generally unsafe on code
>> paths reachable from BPF programs [3], and may lead to deadlocks.
>>
>> [1] https://lore.kernel.org/all/20251218005818.614819-1-shakeel.butt@linux.dev/
>> [2] https://lore.kernel.org/all/20260128183232.2854138-1-andrii@kernel.org/
>> [3] https://lore.kernel.org/bpf/2895ecd8-df1e-4cc0-b9f9-aef893dc2360@linux.dev/
>>
>> Fixes: d4dd9775ec24 ("bpf: wire up sleepable bpf_get_stack() and bpf_get_task_stack() helpers")
>> Suggested-by: Puranjay Mohan <puranjay@kernel.org>
>> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
>> ---
>>  kernel/bpf/stackmap.c | 107 ++++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 107 insertions(+)
>>
>> diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
>> index 4c753e02c415..95336c0e8b56 100644
>> --- a/kernel/bpf/stackmap.c
>> +++ b/kernel/bpf/stackmap.c
>> @@ -9,6 +9,7 @@
>>  #include <linux/perf_event.h>
>>  #include <linux/btf_ids.h>
>>  #include <linux/buildid.h>
>> +#include <linux/mmap_lock.h>
>>  #include "percpu_freelist.h"
>>  #include "mmap_unlock_work.h"
>>
>> @@ -174,6 +175,107 @@ static inline void stack_map_build_id_set_valid(struct bpf_stack_build_id *id,
>>                 memcpy(id->build_id, build_id, BUILD_ID_SIZE_MAX);
>>  }
>>
>> +struct stack_map_vma_lock {
>> +       bool vma_locked;
>> +       struct vm_area_struct *vma;
>> +       struct mm_struct *mm;
>> +};
>> +
>> +static struct vm_area_struct *stack_map_lock_vma(struct stack_map_vma_lock *lock, unsigned long ip)
>> +{
>> +       struct mm_struct *mm = lock->mm;
>> +       struct vm_area_struct *vma;
>> +
>> +       if (WARN_ON_ONCE(!mm))
>> +               return NULL;
>> +
>> +       vma = lock_vma_under_rcu(mm, ip);
>> +       if (vma)
>> +               goto vma_locked;
>> +
>> +       /*
>> +        * Taking mmap_read_lock() is unsafe here, because the caller
>> +        * BPF program might already hold it, causing a deadlock.
>> +        */
>> +       if (!mmap_read_trylock(mm))
>> +               return NULL;
>> +
>> +       vma = vma_lookup(mm, ip);
>> +       if (!vma) {
>> +               mmap_read_unlock(mm);
>> +               return NULL;
>> +       }
> 
> As the code is written right now, this vma_lookup is futile if we
> don't have CONFIG_PER_VMA_LOCK, no? We'll just unlock mmap and return
> NULL regardless of this operation succeeding. So if that's the intent,
> then starting from mmap_read_trylock() all the way to mmap_read_unlock
> + return NULL should be under #ifdef CONFIG_PER_VMA_LOCK.
> 
> But could it be that the intent was to set lock->vma_lock = false,
> lock->vma=vma + return vma here if vma_lookup under mmap_lock
> succeeded?...
> 
> (oh, now scrolling further down the thread, seems like AIs picked up
> on this as well, oh well)
> 
>> +
>> +#ifdef CONFIG_PER_VMA_LOCK
>> +       if (!vma_start_read_locked(vma)) {
>> +               mmap_read_unlock(mm);
>> +               return NULL;
>> +       }
>> +       mmap_read_unlock(mm);
>> +#else
>> +       mmap_read_unlock(mm);
>> +       return NULL;
> 
> see above, was this meant to be a "return vma"?
> 
> This whole function is quite confusing, please help me understand how
> it's supposed to work both with and without CONFIG_PER_VMA_LOCK.

In v2 the stack_map_vma_lock could be holding either vma lock or mmap
lock, in order to support CONFIG_PER_VMA_LOCK=n

Then I tried testing it, and it turned out to set CONFIG_PER_VMA_LOCK=n
you need to disable SMP, which seems like an unlikely kconfig:
https://lore.kernel.org/bpf/bf91eb90-1b6a-4bad-a0e5-072f9dce7daa@linux.dev/

So since v3 I dropped attempt to support CONFIG_PER_VMA_LOCK=n by
treating it the same way as failed mmap_read_trylock(), which is
expressed by returning NULL from stack_map_lock_vma().

I guess you have a point in that the stackmap lock/unlock helpers can
be refactored further. But with respect to CONFIG_PER_VMA_LOCK=n I
don't see why we'd want to maintain additional complexity of mmap lock
bookkeeping.


> 
>> +#endif
> 
>> +vma_locked:
>> +       lock->vma_locked = true;
>> +       lock->vma = vma;
>> +       return vma;
>> +}
>> +
>> +static void stack_map_unlock_vma(struct stack_map_vma_lock *lock)
>> +{
>> +       struct vm_area_struct *vma = lock->vma;
>> +
>> +       if (lock->vma_locked) {
>> +               if (WARN_ON_ONCE(!vma))
>> +                       goto out;
> 
> this should never ever happen, it's a bug, we shouldn't warn on it, we
> should make sure we never ever have vma_locked set to true if there is
> no vma
> 
> the whole pattern of returning NULL from stack_map_lock_vma() and
> still holding lock (i.e., allowing and expecting to call
> stack_map_unlock_vma) seems confusing and error-prone, tbh

The idea of stack_map_lock_vma() was that it may fail like trylock,
and it is safe to call corresponding unlock(), even if lock isn't
held.  This allows to have an unlock() on all paths after a lock() in
the code, instead of "if locked" or "if null" checks.

> 
> why not simplify it to "if we got vma and locked it -> we return
> non-NULL vma and lock is held, otherwise no lock is held (because
> why?)"

I'll try that.

> 
> pw-bot: cr
> 
> 
>> +               vma_end_read(vma);
>> +       }
>> +out:
>> +       lock->vma_locked = false;
>> +       lock->vma = NULL;
>> +}
>> +
>> +static void stack_map_get_build_id_offset_sleepable(struct bpf_stack_build_id *id_offs,
>> +                                                   u32 trace_nr)
>> +{
>> +       struct mm_struct *mm = current->mm;
>> +       struct stack_map_vma_lock lock = {
>> +               .vma_locked = false,
>> +               .vma = NULL,
>> +               .mm = mm,
>> +       };
>> +       struct vm_area_struct *vma;
>> +       struct file *file;
>> +       u64 offset;
>> +       u64 ip;
>> +
>> +       for (u32 i = 0; i < trace_nr; i++) {
>> +               ip = READ_ONCE(id_offs[i].ip);
>> +
>> +               vma = stack_map_lock_vma(&lock, ip);
>> +               if (!vma || !vma->vm_file) {
>> +                       stack_map_build_id_set_ip(&id_offs[i]);
>> +                       stack_map_unlock_vma(&lock);
> 
> see above, I find this confusing to need to call unlock_vma if there
> is no vma in the first place...
> 
>> +                       continue;
>> +               }
>> +
>> +               file = get_file(vma->vm_file);
>> +               offset = stack_map_build_id_offset(vma->vm_pgoff, vma->vm_start, ip);
>> +               stack_map_unlock_vma(&lock);
>> +
>> +               /* build_id_parse_file() may block on filesystem reads */
>> +               if (build_id_parse_file(file, id_offs[i].build_id, NULL)) {
>> +                       stack_map_build_id_set_ip(&id_offs[i]);
>> +                       fput(file);
>> +                       continue;
>> +               }
>> +               fput(file);
>> +
>> +               stack_map_build_id_set_valid(&id_offs[i], offset, id_offs[i].build_id);
> 
> what about
> 
> if (build_id_parse_file(...))
>     stack_map_build_id_set_ip(...); /* no build id, parsing failed */
> else
>     stack_map_build_id_set_valid(...);
> 
> fput(file);
> 
> ?
> 
>> +       }
>> +}
>> +
>>  /*
>>   * Expects all id_offs[i].ip values to be set to correct initial IPs.
>>   * They will be subsequently:
>> @@ -194,6 +296,11 @@ static void stack_map_get_build_id_offset(struct bpf_stack_build_id *id_offs,
>>         const unsigned char *prev_build_id;
>>         int i;
>>
>> +       if (may_fault && has_user_ctx) {
>> +               stack_map_get_build_id_offset_sleepable(id_offs, trace_nr);
>> +               return;
>> +       }
>> +
>>         /* If the irq_work is in use, fall back to report ips. Same
>>          * fallback is used for kernel stack (!user) on a stackmap with
>>          * build_id.
>> --
>> 2.54.0
>>

