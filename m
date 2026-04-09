Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0003924DD15
	for <bpf@vger.kernel.org>; Thu,  9 Apr 2026 04:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775708446; cv=none; b=aX447AxnRDyBqy92fEGGx6UejX5SfjouSbIZiOhaDwt57MCHEphsQwnfvzCXqXiBvoIrGUqI/6ub+SqwJj6bLZ+httUFgZQXtAlqOtrbmQsxU561gIzw6uyw0BDsqRsBpN4aqf3Ss0bHeT1TuYsneKcmZTa2jal8NIuGgdc6U9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775708446; c=relaxed/simple;
	bh=65I4WorEjOQJB/0YHWmuGVaHDAzhSJopSU6BK3WMu4o=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Bbpxuc4OVs68sjt50xzV+sgI4oBZIbXb0Jzzw+KPdIcTXnn0Auaz8p/ELrmfOOwpmjXku9gWSnKo1DCQ97d4G980YuOwUU8vO9qNMYrqPaojhb20p2LULnBKI/cXfKoDPRNVLwft7nYW5guEglhJu+gU04Y+2JABDpHrmR1KDzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ZOwQeVXS; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZOwQeVXS"
Message-ID: <bf91eb90-1b6a-4bad-a0e5-072f9dce7daa@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1775708433;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SXivS5dvxTdcrkjcpWeHkhv1qBc5P8vwKzl4jmwUB10=;
	b=ZOwQeVXSAKHFNh3w4RZq4vjP/2CTcr48/1DZN87TgqMyBuvsUfFlVPbxZC4rsFFx/jfeJw
	p8L553/J8Eya4bVLJ/Vt2j7vjAZ/UfjQbgwCo0aAzKduIGgjjIET9HvYkVL3RTrG8IAKnr
	2fUvRlZoPNkIWmzuK4wzA8Nt9ZK89sg=
Date: Wed, 8 Apr 2026 21:20:25 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf v2 2/2] bpf: Avoid faultable build ID reads under mm
 locks
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
To: Puranjay Mohan <puranjay@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov <ast@kernel.org>,
 Song Liu <song@kernel.org>, Shakeel Butt <shakeel.butt@linux.dev>,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com
References: <20260409010604.1439087-1-ihor.solodrai@linux.dev>
 <20260409010604.1439087-3-ihor.solodrai@linux.dev>
Content-Language: en-US
In-Reply-To: <20260409010604.1439087-3-ihor.solodrai@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 4/8/26 6:06 PM, Ihor Solodrai wrote:
> Sleepable build ID parsing can block in __kernel_read() [1], so the
> stackmap sleepable path must not call it while holding mmap_lock or a
> per-VMA read lock.
> 
> The issue and the fix are conceptually similar to a recent procfs
> patch [2].
> 
> Resolve each covered VMA with a stable read-side reference, preferring
> lock_vma_under_rcu() and falling back to mmap_read_lock() only long
> enough to acquire the VMA read lock. Take a reference to the backing
> file, drop the VMA lock, and then parse the build ID through
> (sleepable) build_id_parse_file().
> 
> [1]: https://lore.kernel.org/all/20251218005818.614819-1-shakeel.butt@linux.dev/
> [2]: https://lore.kernel.org/all/20260128183232.2854138-1-andrii@kernel.org/
> 
> Fixes: 777a8560fd29 ("lib/buildid: use __kernel_read() for sleepable context")
> Assisted-by: Codex:gpt-5.4
> Suggested-by: Puranjay Mohan <puranjay@kernel.org>
> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
> ---
>  kernel/bpf/stackmap.c | 139 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 139 insertions(+)
> 
> diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
> index 4ef0fd06cea5..de3d89e20a1e 100644
> --- a/kernel/bpf/stackmap.c
> +++ b/kernel/bpf/stackmap.c
> @@ -9,6 +9,7 @@
>  #include <linux/perf_event.h>
>  #include <linux/btf_ids.h>
>  #include <linux/buildid.h>
> +#include <linux/mmap_lock.h>
>  #include "percpu_freelist.h"
>  #include "mmap_unlock_work.h"
>  
> @@ -158,6 +159,139 @@ static inline void stack_map_build_id_set_ip(struct bpf_stack_build_id *id)
>  	memset(id->build_id, 0, BUILD_ID_SIZE_MAX);
>  }
>  
> +enum stack_map_vma_lock_state {
> +	STACK_MAP_LOCKED_NONE = 0,
> +	STACK_MAP_LOCKED_VMA,
> +	STACK_MAP_LOCKED_MMAP,
> +};
> +
> +struct stack_map_vma_lock {
> +	enum stack_map_vma_lock_state state;
> +	struct vm_area_struct *vma;
> +	struct mm_struct *mm;
> +};
> +
> +static struct vm_area_struct *stack_map_lock_vma(struct stack_map_vma_lock *lock, unsigned long ip)
> +{
> +	struct mm_struct *mm = lock->mm;
> +	struct vm_area_struct *vma;
> +
> +	if (WARN_ON_ONCE(!mm))
> +		return NULL;
> +
> +	vma = lock_vma_under_rcu(mm, ip);
> +	if (vma)
> +		goto vma_locked;
> +
> +	if (!mmap_read_trylock(mm))
> +		return NULL;
> +
> +	vma = vma_lookup(mm, ip);
> +	if (!vma) {
> +		mmap_read_unlock(mm);
> +		return NULL;
> +	}
> +
> +#ifdef CONFIG_PER_VMA_LOCK

Puranjay and others,

I tried to test this patch with CONFIG_PER_VMA_LOCK=n, and it turns
out it's not easy to turn off.

    config PER_VMA_LOCK
    	def_bool y
    	depends on ARCH_SUPPORTS_PER_VMA_LOCK && MMU && SMP

AFAIU this definition means that PER_VMA_LOCK is automatically true if
it's dependencies are satisfied. The only practical way to do it
appears to be disabling SMP, which is probably very unusual.

So I am thinking, maybe instead of having to manage both mmap and vma
lock in stackmap.c, we can assume CONFIG_PER_VMA_LOCK=y, and have

    #ifndef CONFIG_PER_VMA_LOCK
    return -ENOTSUPP
    #endif

somewhere in the stack_map_get_build_id_offset() callstack?
Say in __bpf_get_stackid()?

Thoughts?

> +	if (!vma_start_read_locked(vma)) {
> +		mmap_read_unlock(mm);
> +		return NULL;
> +	}
> +	mmap_read_unlock(mm);
> +#else
> +	lock->state = STACK_MAP_LOCKED_MMAP;
> +	lock->vma = vma;
> +	return vma;
> +#endif
> +
> +vma_locked:
> +	lock->state = STACK_MAP_LOCKED_VMA;
> +	lock->vma = vma;
> +	return vma;
> +}
> +
> +static void stack_map_unlock_vma(struct stack_map_vma_lock *lock)
> +{
> +	struct vm_area_struct *vma = lock->vma;
> +	struct mm_struct *mm = lock->mm;
> +
> +	switch (lock->state) {
> +	case STACK_MAP_LOCKED_VMA:
> +		if (WARN_ON_ONCE(!vma))
> +			break;
> +		vma_end_read(vma);
> +		break;
> +	case STACK_MAP_LOCKED_MMAP:
> +		if (WARN_ON_ONCE(!mm))
> +			break;
> +		mmap_read_unlock(mm);
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	lock->state = STACK_MAP_LOCKED_NONE;
> +	lock->vma = NULL;
> +}
> +
> +static void stack_map_get_build_id_offset_sleepable(struct bpf_stack_build_id *id_offs,
> +						    u32 trace_nr)
> +{
> +	struct mm_struct *mm = current->mm;
> +	struct stack_map_vma_lock lock = {
> +		.state = STACK_MAP_LOCKED_NONE,
> +		.vma = NULL,
> +		.mm = mm,
> +	};
> +	struct file *file, *prev_file = NULL;
> +	unsigned long vm_pgoff, vm_start;
> +	struct vm_area_struct *vma;
> +	const char *prev_build_id;
> +	u64 ip;
> +
> +	for (u32 i = 0; i < trace_nr; i++) {
> +		ip = READ_ONCE(id_offs[i].ip);
> +		vma = stack_map_lock_vma(&lock, ip);
> +		if (!vma || !vma->vm_file) {
> +			stack_map_build_id_set_ip(&id_offs[i]);
> +			stack_map_unlock_vma(&lock);
> +			continue;
> +		}
> +
> +		file = vma->vm_file;
> +		vm_pgoff = vma->vm_pgoff;
> +		vm_start = vma->vm_start;
> +
> +		if (file == prev_file) {
> +			memcpy(id_offs[i].build_id, prev_build_id, BUILD_ID_SIZE_MAX);
> +			stack_map_unlock_vma(&lock);
> +			goto build_id_valid;
> +		}
> +
> +		file = get_file(file);
> +		stack_map_unlock_vma(&lock);
> +
> +		/* build_id_parse_file() may block on filesystem reads */
> +		if (build_id_parse_file(file, id_offs[i].build_id, NULL)) {
> +			stack_map_build_id_set_ip(&id_offs[i]);
> +			fput(file);
> +			continue;
> +		}
> +
> +		if (prev_file)
> +			fput(prev_file);
> +		prev_file = file;
> +		prev_build_id = id_offs[i].build_id;
> +
> +build_id_valid:
> +		id_offs[i].offset = (vm_pgoff << PAGE_SHIFT) + ip - vm_start;
> +		id_offs[i].status = BPF_STACK_BUILD_ID_VALID;
> +	}
> +
> +	if (prev_file)
> +		fput(prev_file);
> +}
> +
>  /*
>   * Expects all id_offs[i].ip values to be set to correct initial IPs.
>   * They will be subsequently:
> @@ -178,6 +312,11 @@ static void stack_map_get_build_id_offset(struct bpf_stack_build_id *id_offs,
>  	const char *prev_build_id;
>  	int i;
>  
> +	if (may_fault && has_user_ctx) {
> +		stack_map_get_build_id_offset_sleepable(id_offs, trace_nr);
> +		return;
> +	}
> +
>  	/* If the irq_work is in use, fall back to report ips. Same
>  	 * fallback is used for kernel stack (!user) on a stackmap with
>  	 * build_id.

