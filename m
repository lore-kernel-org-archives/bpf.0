Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B7C82D7D2E
	for <bpf@vger.kernel.org>; Tue, 12 May 2026 03:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778557232; cv=none; b=mom6J41I/CPwn6JRjy7pmmzIixquo1Up83xZ3HOqvgeDnxgdG8I36dHaUqOFSjKaBgoEYLpINfUCukkvTkOUhi7SIL7ft2LMJUflbzyDwzmFh0pETcdmzNLddy8zlEchVosQGv2Yq7JNHD2xSYDX07JQF2ZnL2olg1weTtL+htA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778557232; c=relaxed/simple;
	bh=O6NtiIR1kHDFzTseedNHjSp6vRNPkqFPHe5z7pHsSi0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SV/+fWoxNKoKKBAjmXo6/2yuCzWTuDPvn0hItZr5dVxPmpIz9yQamKvUbZ2VE/ecMP6AbFZuEyZip0/LLdQli4uknvkaaVhcevEKRgs0DKpeACk2/z35Rj4aMAb4gmlVDz/aprd18u3AJIx1+whfw5fCcXg8BRPhWFbdT6xjPP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Z1zSJb8p; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Z1zSJb8p"
Message-ID: <9ef5523e-ce74-40f2-a88d-600671d20c9a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1778557219;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/SouFMC4Nuxp1VVwysKIS+XT2FhPJuHW2n0LjeQNgqk=;
	b=Z1zSJb8pUBy7ImJTdv3Oq0BuC8aCCgp6FDFh/J855XnBYFKY5LoT/dwaCZeXT0rgsmqYQ7
	TsWC56dOAPSfo8R43iqul4e8RapaUqUpgEuXIjjpuKD9XPviWz5TtUopPYS7YtPs/BDRkW
	ubIOSHlhCZg5qnQiygKuBfMeWYHcSvU=
Date: Mon, 11 May 2026 20:40:08 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf v2 2/2] bpf: Avoid faultable build ID reads under mm
 locks
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Song Liu <song@kernel.org>
Cc: Puranjay Mohan <puranjay@kernel.org>,
 Shakeel Butt <shakeel.butt@linux.dev>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-team@meta.com
References: <20260409010604.1439087-1-ihor.solodrai@linux.dev>
 <20260409010604.1439087-3-ihor.solodrai@linux.dev>
 <8b2cf5ca-182e-4eb2-ab90-8fab9d81f6e1@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <8b2cf5ca-182e-4eb2-ab90-8fab9d81f6e1@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 4/9/26 9:34 AM, Mykyta Yatsenko wrote:
> 
> 
> On 4/9/26 2:06 AM, Ihor Solodrai wrote:
>> Sleepable build ID parsing can block in __kernel_read() [1], so the
>> stackmap sleepable path must not call it while holding mmap_lock or a
>> per-VMA read lock.
>>
>> The issue and the fix are conceptually similar to a recent procfs
>> patch [2].
>>
>> Resolve each covered VMA with a stable read-side reference, preferring
>> lock_vma_under_rcu() and falling back to mmap_read_lock() only long
> meganit: falling back to mmap_read_trylock()?
>> enough to acquire the VMA read lock. Take a reference to the backing
>> file, drop the VMA lock, and then parse the build ID through
>> (sleepable) build_id_parse_file().
>>
>> [1]: https://lore.kernel.org/all/20251218005818.614819-1-shakeel.butt@linux.dev/
>> [2]: https://lore.kernel.org/all/20260128183232.2854138-1-andrii@kernel.org/
>>
>> Fixes: 777a8560fd29 ("lib/buildid: use __kernel_read() for sleepable context")
>> Assisted-by: Codex:gpt-5.4
>> Suggested-by: Puranjay Mohan <puranjay@kernel.org>
>> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
>> ---
>>   kernel/bpf/stackmap.c | 139 ++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 139 insertions(+)
>>
>> diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
>> index 4ef0fd06cea5..de3d89e20a1e 100644
>> --- a/kernel/bpf/stackmap.c
>> +++ b/kernel/bpf/stackmap.c
>> @@ -9,6 +9,7 @@
>>   #include <linux/perf_event.h>
>>   #include <linux/btf_ids.h>
>>   #include <linux/buildid.h>
>> +#include <linux/mmap_lock.h>
>>   #include "percpu_freelist.h"
>>   #include "mmap_unlock_work.h"
>>   @@ -158,6 +159,139 @@ static inline void stack_map_build_id_set_ip(struct bpf_stack_build_id *id)
>>       memset(id->build_id, 0, BUILD_ID_SIZE_MAX);
>>   }
>>   +enum stack_map_vma_lock_state {
>> +    STACK_MAP_LOCKED_NONE = 0,
>> +    STACK_MAP_LOCKED_VMA,
>> +    STACK_MAP_LOCKED_MMAP,
>> +};
>> +
>> +struct stack_map_vma_lock {
>> +    enum stack_map_vma_lock_state state;
>> +    struct vm_area_struct *vma;
>> +    struct mm_struct *mm;
>> +};
>> +
>> +static struct vm_area_struct *stack_map_lock_vma(struct stack_map_vma_lock *lock, unsigned long ip)
>> +{
>> +    struct mm_struct *mm = lock->mm;
>> +    struct vm_area_struct *vma;
>> +
>> +    if (WARN_ON_ONCE(!mm))
>> +        return NULL;
>> +
>> +    vma = lock_vma_under_rcu(mm, ip);
>> +    if (vma)
>> +        goto vma_locked;
>> +
>> +    if (!mmap_read_trylock(mm))
>> +        return NULL;
>> +
>> +    vma = vma_lookup(mm, ip);
>> +    if (!vma) {
>> +        mmap_read_unlock(mm);
>> +        return NULL;
>> +    }
>> +
>> +#ifdef CONFIG_PER_VMA_LOCK
>> +    if (!vma_start_read_locked(vma)) {
>> +        mmap_read_unlock(mm);
>> +        return NULL;
>> +    }
>> +    mmap_read_unlock(mm);
>> +#else
>> +    lock->state = STACK_MAP_LOCKED_MMAP;
>> +    lock->vma = vma;
>> +    return vma;
>> +#endif
>> +
>> +vma_locked:
>> +    lock->state = STACK_MAP_LOCKED_VMA;
>> +    lock->vma = vma;
>> +    return vma;
>> +}
>> +
>> +static void stack_map_unlock_vma(struct stack_map_vma_lock *lock)
>> +{
>> +    struct vm_area_struct *vma = lock->vma;
>> +    struct mm_struct *mm = lock->mm;
>> +
>> +    switch (lock->state) {
>> +    case STACK_MAP_LOCKED_VMA:
>> +        if (WARN_ON_ONCE(!vma))
>> +            break;
>> +        vma_end_read(vma);
>> +        break;
>> +    case STACK_MAP_LOCKED_MMAP:
>> +        if (WARN_ON_ONCE(!mm))
>> +            break;
>> +        mmap_read_unlock(mm);
>> +        break;
>> +    default:
>> +        break;
>> +    }
>> +
>> +    lock->state = STACK_MAP_LOCKED_NONE;
>> +    lock->vma = NULL;
>> +}
>> +
>> +static void stack_map_get_build_id_offset_sleepable(struct bpf_stack_build_id *id_offs,
>> +                            u32 trace_nr)
>> +{
>> +    struct mm_struct *mm = current->mm;
>> +    struct stack_map_vma_lock lock = {
>> +        .state = STACK_MAP_LOCKED_NONE,
>> +        .vma = NULL,
>> +        .mm = mm,
>> +    };
>> +    struct file *file, *prev_file = NULL;
>> +    unsigned long vm_pgoff, vm_start;
>> +    struct vm_area_struct *vma;
>> +    const char *prev_build_id;
>> +    u64 ip;
>> +
>> +    for (u32 i = 0; i < trace_nr; i++) {
>> +        ip = READ_ONCE(id_offs[i].ip);
> 
> I'm not sure if I understand why READ_ONCE is necessary here.

Hi Mykyta, thank you for review and apologies for slow response.

My understanding is we need to work with a local snapshot of
id_offs[i].ip, because this data can be modified by user's BPF
program, as Andrii explained here:
https://lore.kernel.org/all/20240829174232.3133883-9-andrii@kernel.org/

> 
>> +        vma = stack_map_lock_vma(&lock, ip);
>> +        if (!vma || !vma->vm_file) {
>> +            stack_map_build_id_set_ip(&id_offs[i]);
>> +            stack_map_unlock_vma(&lock);
>> +            continue;
>> +        }
>> +
>> +        file = vma->vm_file;
>> +        vm_pgoff = vma->vm_pgoff;
>> +        vm_start = vma->vm_start;
>> +
>> +        if (file == prev_file) {
> 
> What if instead of caching prev_file, we cache vm_start and vm_end, and if the next IP is in range, reuse previous build id. This should optimize this code further, avoiding locks on the vma used on previous iteration.

Great idea. I implemented this in v3, in addition to prev_file caching.

> 
>> +            memcpy(id_offs[i].build_id, prev_build_id, BUILD_ID_SIZE_MAX);
>> +            stack_map_unlock_vma(&lock);
>> +            goto build_id_valid;
>> +        }
>> +
>> +        file = get_file(file);
>> +        stack_map_unlock_vma(&lock);
>> +
>> +        /* build_id_parse_file() may block on filesystem reads */
>> +        if (build_id_parse_file(file, id_offs[i].build_id, NULL)) {
>> +            stack_map_build_id_set_ip(&id_offs[i]);
>> +            fput(file);
>> +            continue;
>> +        }
>> +
>> +        if (prev_file)
>> +            fput(prev_file);
>> +        prev_file = file;
>> +        prev_build_id = id_offs[i].build_id;
>> +
>> +build_id_valid:
>> +        id_offs[i].offset = (vm_pgoff << PAGE_SHIFT) + ip - vm_start;
>> +        id_offs[i].status = BPF_STACK_BUILD_ID_VALID;
>> +    }
>> +
>> +    if (prev_file)
>> +        fput(prev_file);
>> +}
>> +
>>   /*
>>    * Expects all id_offs[i].ip values to be set to correct initial IPs.
>>    * They will be subsequently:
>> @@ -178,6 +312,11 @@ static void stack_map_get_build_id_offset(struct bpf_stack_build_id *id_offs,
>>       const char *prev_build_id;
>>       int i;
>>   +    if (may_fault && has_user_ctx) {
>> +        stack_map_get_build_id_offset_sleepable(id_offs, trace_nr);
>> +        return;
>> +    }
>> +
>>       /* If the irq_work is in use, fall back to report ips. Same
>>        * fallback is used for kernel stack (!user) on a stackmap with
>>        * build_id.
> 

