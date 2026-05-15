Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81D473A9D90
	for <bpf@vger.kernel.org>; Fri, 15 May 2026 23:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778888676; cv=none; b=IWPY8+W13GH1SwgOmkX8cuaF9/+DV2UtNzvrGcAWSp16vsWI5aJ68Lfe/w4Rf3ufTd5iUzNIQybuh7NqJZw6odFLkCYQbiKKqxTFsIGtFDvoEnW2pliiqD8Y3KDkC7UAIgYNDMnktzexQ1OP5Au0Jkn3CQM2WaBxx5N4/aAM+Sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778888676; c=relaxed/simple;
	bh=X0w8WKqVCMSAVrxFK3Zg8IgTppTDHr3CtV19muEKr2A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u4YOJ6Z5aBZZAsenPqdV6XkQ/LcTv8N/NtO6cj+ExYKe43rnx1yJam6MaIIcND73n6XOGOT1CGF9CW/fTcNeOb0153cGycbBWQtFAQHAJ2Sa6NeAiqJvtdaqxspPUljOPMwSnk9VnoyvNC3T9LprJDTyJc/O/Gx/FpEoM+QqxiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=uGhqrRY7; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="uGhqrRY7"
Message-ID: <e3879e7d-08b6-4bb7-bf76-b2f4d6f59a11@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1778888672;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sMQSl4pcwOYYAvhJ4KtMrvza91Bsy8kJtipnOMtb3cU=;
	b=uGhqrRY7QA/FH2jlGi1LKgZfovR6ix96TBaB4z9RxRqe+QQWDztoytwJvg8/fhsyVbLucK
	mz1uKaBfYVyTq3nLQW1RubhAqaw0Z7gHzwX/P8sWpcvNWyzZkmhrVXi0vkNVT/Dm7hp4rQ
	IaXACpVUszq8wDgZKZu3dwBUn6o+vsQ=
Date: Fri, 15 May 2026 16:44:25 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v5 2/3] bpf: Avoid faultable build ID reads under
 mm locks
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
 Suren Baghdasaryan <surenb@google.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman
 <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Puranjay Mohan <puranjay@kernel.org>, Shakeel Butt <shakeel.butt@linux.dev>,
 Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-team@meta.com
References: <20260515005244.1333013-1-ihor.solodrai@linux.dev>
 <20260515005244.1333013-3-ihor.solodrai@linux.dev>
 <CAEf4BzZ1u6N2+cSkkSn65F_D_jEZK+4Gy_M1GNOVXkD36h0Now@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <CAEf4BzZ1u6N2+cSkkSn65F_D_jEZK+4Gy_M1GNOVXkD36h0Now@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 5/15/26 3:40 PM, Andrii Nakryiko wrote:
> On Thu, May 14, 2026 at 5:53 PM Ihor Solodrai <ihor.solodrai@linux.dev> wrote:
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
>>  kernel/bpf/stackmap.c | 109 ++++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 109 insertions(+)
>>
>> diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
>> index 4ef0fd06cea5..08f7659505d1 100644
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
>> @@ -158,6 +159,109 @@ static inline void stack_map_build_id_set_ip(struct bpf_stack_build_id *id)
>>         memset(id->build_id, 0, BUILD_ID_SIZE_MAX);
>>  }
>>
>> +struct stack_map_vma_lock {
>> +       bool vma_locked;
>> +       struct vm_area_struct *vma;
>> +       struct mm_struct *mm;
>> +};
>> +
> 
> tbh, it feels like this should be provided as some sort of primitive
> by vma/mm API given how common it becomes when one tries to work with
> VMAs efficiently (in terms of avoiding unnecessary mmap lock)... but
> that would be a question to Suren maybe

Shakeel raised the same point in v4 [1]. I don't know of any potential
users of this pattern, and refactoring this into a generic mechanism
now (with only stackmap using it) seems premature. Although I agree
with the premise. Let's see if Suren has an opinion.

[1] https://lore.kernel.org/bpf/agYzuDIJszA_7rp3@linux.dev/

> 
>> +static struct vm_area_struct *
>> +stack_map_lock_vma(struct stack_map_vma_lock *lock, unsigned long ip)
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
>> +#endif
>> +vma_locked:
>> +       lock->vma_locked = true;
>> +       lock->vma = vma;
>> +       return vma;
>> +}
>> +
> 
> cc'ing Suren to help check we didn't miss any of the per-VMA/mmap
> locking gotchas
> 
>> +static void stack_map_unlock_vma(struct stack_map_vma_lock *lock)
>> +{
>> +       struct vm_area_struct *vma = lock->vma;
>> +
>> +       if (lock->vma_locked) {
>> +               if (WARN_ON_ONCE(!vma))
>> +                       goto out;
>> +               vma_end_read(vma);
>> +       }
>> +out:
>> +       lock->vma_locked = false;
>> +       lock->vma = NULL;
>> +}
>> +
>> +static void stack_map_get_build_id_offset_sleepable(struct bpf_stack_build_id *id_offs,
>> +                                                   u32 trace_nr)
> 
> why is this only sleepable case? the only difference between sleepable
> and non-sleepable is the use of build_id_parse[_file] vs
> build_id_parse_nofault to fetch build ID, no? Other than that the
> algorithm of locking VMAs is the same, no?

There seems to be a difference in lock lifetimes, because
non-sleepable path may run with IRQs disabled. Right now it does:

    bool irq_work_busy = bpf_mmap_unlock_get_irq_work(&work);
      ...
    if (!has_user_ctx || irq_work_busy || !mmap_read_trylock(current->mm)) {
      // fallback to IPs...
    }
    for (i = 0; i < trace_nr; i++) {
      // fetch build_id ...
    }
    bpf_mmap_unlock_mm(work, current->mm);

While on sleepable path we always release the lock before parsing with
the new stack_map_unlock_vma(), because build_id_parse_file() can
block.

Not sure how this could be reconciled in a common lock/unlock pattern,
if that's what you're suggesting.

For me it's easier to reason about when sleepable / non-sleepable are
on distinct codepaths, although we may be able to factor out some
common helpers.


> 
>> +{
>> +       struct mm_struct *mm = current->mm;
>> +       struct stack_map_vma_lock lock = {
>> +               .vma_locked = false,
>> +               .vma = NULL,
>> +               .mm = mm,
>> +       };
>> +       unsigned long vm_pgoff, vm_start;
>> +       struct vm_area_struct *vma;
>> +       struct file *file;
>> +       u64 ip;
>> +
>> +       for (u32 i = 0; i < trace_nr; i++) {
>> +               ip = READ_ONCE(id_offs[i].ip);
>> +               vma = stack_map_lock_vma(&lock, ip);
>> +               if (!vma || !vma->vm_file) {
>> +                       stack_map_build_id_set_ip(&id_offs[i]);
>> +                       stack_map_unlock_vma(&lock);
>> +                       continue;
>> +               }
>> +
>> +               file = get_file(vma->vm_file);
>> +               vm_pgoff = vma->vm_pgoff;
>> +               vm_start = vma->vm_start;
> 
> nit: we can calculate offset here instead of carrying over pgoff and
> start, offset formula is cheap, no big deal
> 
> 
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
>> +               id_offs[i].offset = (vm_pgoff << PAGE_SHIFT) + ip - vm_start;
>> +               id_offs[i].status = BPF_STACK_BUILD_ID_VALID;
>> +       }
>> +}
>> +
>>  /*
>>   * Expects all id_offs[i].ip values to be set to correct initial IPs.
>>   * They will be subsequently:
>> @@ -178,6 +282,11 @@ static void stack_map_get_build_id_offset(struct bpf_stack_build_id *id_offs,
>>         const char *prev_build_id;
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

