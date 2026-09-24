Received: from mta0.migadu.com (out-236.mta0.migadu.com [91.218.175.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4499543F8A1
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 10:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.236
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790244728; cv=none; b=Bw5BTB+kGAc5S1h3QnyiiGx8Q1ybLmf8DwI7dIURNwqwFyoIvJ11RUQ0wxzXPICe6l2X3rTL4nQT5ApZwbb+vPuX4QNz1sVhafJZAFjgWRcWHObafyHzuIhvKglsSBu98pT15tksGGjKtWIEznh1UVRT5JK723DEhfo2SjH0jFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790244728; c=relaxed/simple;
	bh=DwhwcjfHKNAi0RJaiKWJ3k6gHg6GswCFgnOJIuwcrnY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZQgROfh2FWBwFrbt7rQ7bqrZGSGBq0XoVARNn7PCDvX6EaF5McEqs6oaKelIn/MQJ3171EjyZH+6kexiXl52SruOC9xh7hkTD061VG6ZuRec85XN7308+PmysyA0+ijgCXmrI4vLMj9NscbZUN1mWD9McYz4hwyQRhuxOxW0Si0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=buslNqz+; arc=none smtp.client-ip=91.218.175.236
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="buslNqz+"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=DwhwcjfHKNAi0RJaiKWJ3k6gHg6GswCFgnOJIuwcrnY=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790244713; v=1; x=1790849513;
 b=buslNqz+jA05b7KMcXSMZrl5dsCYKvTLovCQjpQB1xgI13qKsPfKcRnh64BeQTcS+uLPLG7g
 mM3uf4e2HxAoGIYwo8qqp8pHJmKEc1tNJRehvj/g8EoI3KS0KpHCtCZxWqs/pJ2el0TxBrjhwk2
 jN4feBIvDUj2suncmOUF9PoQ=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 1a764c7245a7f326;
	Thu, 24 Sep 2026 10:11:53 +0000
X-Mizu-Trace-ID: 1a764c7245a7f326
X-Migadu-Flow: FLOW_OUT
Message-ID: <7fba6431-14ab-45de-99dd-17e38cae2841@linux.dev>
Date: Thu, 24 Sep 2026 18:11:40 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf v2 1/2] bpf: Add sleepable arena page allocation path
To: Emil Tsalapatis <emil@etsalapatis.com>, bpf@vger.kernel.org
Cc: ast@kernel.org, andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com,
 daniel@iogearbox.net
References: <20260924053621.7076-1-emil@etsalapatis.com>
 <20260924053621.7076-2-emil@etsalapatis.com>
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <20260924053621.7076-2-emil@etsalapatis.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 9/24/26 1:36 PM, Emil Tsalapatis wrote:
> The bpf_arena_alloc_pages() function currently only allocates pages
> inside a spinlock critical section with IRQs off. This forces the use
> of alloc_pages_nolock() in the BPF allocator, even when the caller is
> a sleepable BPF function. This in turn causes allocation failures even
> in cases where falling into the allocator slow path and possibly
> sleeping would eventually succeed. This can be triggered consistently
> by heavy BPF arena users like scx.
>
> Add a separate arena page allocation path just for sleepable callers.
> The path preallocates the arena memory to be added to the tree before
> taking the critical section.
>
> Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
> ---
>   include/linux/bpf.h  |   6 +++
>   kernel/bpf/arena.c   | 123 ++++++++++++++++++++++++++++++-------------
>   kernel/bpf/syscall.c |   8 +--
>   3 files changed, 92 insertions(+), 45 deletions(-)
>
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index e7c5e203eddd..b37e34cf1086 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -720,6 +720,12 @@ void bpf_map_free_internal_structs(struct bpf_map *map, void *obj);
>   int bpf_dynptr_from_file_sleepable(struct file *file, u32 flags,
>   				   struct bpf_dynptr *ptr__uninit);
>   
> +static inline bool is_bpf_alloc_nonsleepable(void)
> +{
> +	return preempt_count() > 0 || irqs_disabled() ||
> +		IS_ENABLED(CONFIG_PREEMPT_RT);
> +}
> +


A runtime check cannot tell whether sleeping is allowed: without
CONFIG_PREEMPT_COUNT preempt_count() does not see spinlocks or
rcu_read_lock(), which is why preemptible() is 0 there.

How about passing 'sleepable' down to bpf_map_alloc_pages() instead?
The verifier already proves it, and the code gets simpler.


>   #if defined(CONFIG_MMU) && defined(CONFIG_64BIT)
>   void *bpf_arena_alloc_pages_non_sleepable(void *p__map, void *addr__ign, u32 page_cnt, int node_id,
>   					  u64 flags);
> diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
> index c6369ea5e208..eaeae16bbe7a 100644
> --- a/kernel/bpf/arena.c
> +++ b/kernel/bpf/arena.c
> @@ -704,6 +704,27 @@ static u64 clear_lo32(u64 val)
>   	return val & ~(u64)~0U;
>   }
>   
> +static int arena_adjust_tree(struct bpf_arena *arena, long uaddr, long page_cnt, long *pgoff)
> +{
> +	int ret;
> +
> +	/* Special case where user is requesting specific range. */
> +	if (uaddr) {
> +		ret = is_range_tree_set(&arena->rt, *pgoff, page_cnt);
> +		if (ret)
> +			return ret;
> +		return range_tree_clear(&arena->rt, *pgoff, page_cnt);
> +	}
> +
> +	ret = range_tree_find(&arena->rt, page_cnt);
> +	if (ret < 0)
> +		return ret;
> +
> +	*pgoff = ret;
> +
> +	return range_tree_clear(&arena->rt, *pgoff, page_cnt);
> +}
> +
>   /*
>    * Allocate pages and vmap them into kernel vmalloc area.
>    * Later the pages will be mmaped into user space vma.
> @@ -721,7 +742,9 @@ static long arena_alloc_pages(struct bpf_arena *arena, long uaddr, long page_cnt
>   	long alloc_pages;
>   	unsigned long flags;
>   	long pgoff = 0;
> +	bool can_sleep;
>   	u32 uaddr32;
> +	long addr = 0;
>   	int ret, i;
>   
>   	if (node_id != NUMA_NO_NODE &&
> @@ -741,31 +764,38 @@ static long arena_alloc_pages(struct bpf_arena *arena, long uaddr, long page_cnt
>   	}
>   
>   	bpf_map_memcg_enter(&arena->map, &old_memcg, &new_memcg);
> -	/* Cap allocation size to KMALLOC_MAX_CACHE_SIZE so kmalloc_nolock() can succeed. */
> -	alloc_pages = min(page_cnt, KMALLOC_MAX_CACHE_SIZE / sizeof(struct page *));
> -	pages = kmalloc_nolock(alloc_pages * sizeof(struct page *), __GFP_ACCOUNT, NUMA_NO_NODE);
> -	if (!pages) {
> -		bpf_map_memcg_exit(old_memcg, new_memcg);
> -		return 0;
> +
> +	can_sleep = sleepable && !is_bpf_alloc_nonsleepable();
> +	if (can_sleep) {
> +		alloc_pages = page_cnt;
> +		pages = kvcalloc(page_cnt, sizeof(struct page *), GFP_KERNEL_ACCOUNT);
> +		if (!pages)
> +			goto out_memcg;
> +
> +		ret = bpf_map_alloc_pages(&arena->map, node_id, page_cnt, pages);
> +		if (ret)
> +			goto out_free_array;
> +		data.i = 0;
> +	} else {
> +		/* Cap allocation size so kmalloc_nolock() can succeed. */
> +		alloc_pages = min(page_cnt, KMALLOC_MAX_CACHE_SIZE / sizeof(struct page *));
> +		pages = kmalloc_nolock(alloc_pages * sizeof(struct page *), __GFP_ACCOUNT,
> +				       NUMA_NO_NODE);
> +		if (!pages)
> +			goto out_memcg;
>   	}
> +
>   	data.arena = arena;
>   	data.pages = pages;
>   
>   	if (raw_res_spin_lock_irqsave(&arena->spinlock, flags))
>   		goto out_free_pages;
>   
> -	if (uaddr) {
> -		ret = is_range_tree_set(&arena->rt, pgoff, page_cnt);
> -		if (ret)
> -			goto out_unlock_free_pages;
> -		ret = range_tree_clear(&arena->rt, pgoff, page_cnt);
> -	} else {
> -		ret = pgoff = range_tree_find(&arena->rt, page_cnt);
> -		if (pgoff >= 0)
> -			ret = range_tree_clear(&arena->rt, pgoff, page_cnt);
> +	ret = arena_adjust_tree(arena, uaddr, page_cnt, &pgoff);
> +	if (ret) {
> +		raw_res_spin_unlock_irqrestore(&arena->spinlock, flags);
> +		goto out_free_pages;
>   	}
> -	if (ret)
> -		goto out_unlock_free_pages;
>   
>   	remaining = page_cnt;
>   	uaddr32 = (u32)(arena->user_vm_start + pgoff * PAGE_SIZE);
> @@ -773,12 +803,14 @@ static long arena_alloc_pages(struct bpf_arena *arena, long uaddr, long page_cnt
>   	while (remaining) {
>   		long this_batch = min(remaining, alloc_pages);
>   
> -		/* zeroing is needed, since alloc_pages_bulk() only fills in non-zero entries */
> -		memset(pages, 0, this_batch * sizeof(struct page *));
> +		if (!can_sleep) {
> +			/* alloc_pages_bulk() only fills in non-zero entries. */
> +			memset(pages, 0, this_batch * sizeof(struct page *));
>   
> -		ret = bpf_map_alloc_pages(&arena->map, node_id, this_batch, pages);
> -		if (ret)
> -			goto out;
> +			ret = bpf_map_alloc_pages(&arena->map, node_id, this_batch, pages);
> +			if (ret)
> +				goto out_unmap;
> +		}
>   
>   		/*
>   		 * Earlier checks made sure that uaddr32 + page_cnt * PAGE_SIZE - 1
> @@ -793,35 +825,50 @@ static long arena_alloc_pages(struct bpf_arena *arena, long uaddr, long page_cnt
>   					  kern_vm_start + uaddr32 + (mapped << PAGE_SHIFT),
>   					  this_batch << PAGE_SHIFT, apply_range_set_cb, &data);
>   		if (ret) {
> -			/* data.i pages were mapped, account them and free the remaining */
> +			/* data.i pages were mapped, account them and free the remaining. */
>   			mapped += data.i;
> -			for (i = data.i; i < this_batch; i++)
> -				free_pages_nolock(pages[i], 0);
> -			goto out;
> +			if (!can_sleep)
> +				for (i = data.i; i < this_batch; i++)
> +					free_pages_nolock(pages[i], 0);
> +			goto out_unmap;
>   		}
>   
>   		mapped += this_batch;
>   		remaining -= this_batch;
>   	}
> +
>   	flush_vmap_cache(kern_vm_start + uaddr32, mapped << PAGE_SHIFT);
>   	raw_res_spin_unlock_irqrestore(&arena->spinlock, flags);
> -	kfree_nolock(pages);
> -	bpf_map_memcg_exit(old_memcg, new_memcg);
> -	return clear_lo32(arena->user_vm_start) + uaddr32;
> -out:
> +
> +	addr = clear_lo32(arena->user_vm_start) + uaddr32;
> +	goto out_free_array;
> +
> +out_unmap:
> +	if (can_sleep)
> +		flush_vmap_cache(kern_vm_start + uaddr32, mapped << PAGE_SHIFT);
>   	range_tree_set(&arena->rt, pgoff + mapped, page_cnt - mapped);
>   	raw_res_spin_unlock_irqrestore(&arena->spinlock, flags);
> -	if (mapped) {
> -		flush_vmap_cache(kern_vm_start + uaddr32, mapped << PAGE_SHIFT);
> -		arena_free_pages(arena, uaddr32, mapped, sleepable);
> +	if (mapped || can_sleep) {
> +		if (!can_sleep)
> +			flush_vmap_cache(kern_vm_start + uaddr32, mapped << PAGE_SHIFT);
> +		arena_free_pages(arena, uaddr32, mapped, can_sleep);
>   	}
> -	goto out_free_pages;
> -out_unlock_free_pages:
> -	raw_res_spin_unlock_irqrestore(&arena->spinlock, flags);
> +
>   out_free_pages:
> -	kfree_nolock(pages);
> +	if (can_sleep)
> +		for (i = data.i; i < page_cnt; i++)
> +			__free_page(pages[i]);
> +
> +out_free_array:
> +	if (can_sleep)
> +		kvfree(pages);
> +	else
> +		kfree_nolock(pages);
> +
> +out_memcg:
>   	bpf_map_memcg_exit(old_memcg, new_memcg);
> -	return 0;
> +
> +	return addr;
>   }
>   
>   /*
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 74496fd716d3..d193d84cc33e 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -596,15 +596,9 @@ static void bpf_map_release_memcg(struct bpf_map *map)
>   }
>   #endif
>   
> -static bool can_alloc_pages(void)
> -{
> -	return preempt_count() == 0 && !irqs_disabled() &&
> -		!IS_ENABLED(CONFIG_PREEMPT_RT);
> -}
> -
>   static struct page *__bpf_alloc_page(int nid)
>   {
> -	if (!can_alloc_pages())
> +	if (is_bpf_alloc_nonsleepable())
>   		return alloc_pages_nolock(__GFP_ACCOUNT, nid, 0);
>   
>   	return alloc_pages_node(nid,
