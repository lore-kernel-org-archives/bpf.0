Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4658F363C73
	for <bpf@vger.kernel.org>; Thu, 22 Jan 2026 05:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769061196; cv=none; b=NfOYfuDhPrMWgsqvySAD1am9xsfkDgdIeaREuNK4z2FYWxTUqMaoSZ9H56SydlNwYXMfD5OTaur7HYXJRuIoE12dFF6Tw4UeK6lvHZmfjWmiIwZcwqQVk6o7LNfj/iwKgOfAFTEjpV15z0FT3G98eD6cz+r+QW1zTIzBB+KBGgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769061196; c=relaxed/simple;
	bh=BcDuF+Cb+TcWEiVWdZnZ/J27ck7zQ0IohtNfalCb73Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KR04c5k12hRb/pIYWhEbVglrIOgJynl6eMR9X7/8IFnJ4eDMSiTYW8Brdywgcn9hLgj7au6BSyf7YXt7KKHwWQ/e/ppbLmRpnx3D7q5RA0H0XDtx3aDME6RjHHp2C5uvYoVQZDxAObzk/E4dq0xKBJ2t2rsWVthmbqElZtgGLVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=L2h4ihHa; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="L2h4ihHa"
Date: Thu, 22 Jan 2026 13:52:48 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1769061178;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vTGJaFhXlbsw1EOpmJJykqdjn7GgJkZ5tylkFbIkt4g=;
	b=L2h4ihHa5di8qOkOTG1YwQKrsyF+rNJmC8iLx3iq4nFtNlTBmLc3/uKiCyoConCVw+gvX2
	hwTWnd/L57W+rIE/1NtCeLopGNZ2y6ph4hQS1G24MJE4iEirT3LLS3myp+5VHsNYnYbNZv
	iR9esG3KQM0hRVyb+wlj8scSE4K9AiY=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Hao Li <hao.li@linux.dev>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Harry Yoo <harry.yoo@oracle.com>, Petr Tesarik <ptesarik@suse.com>, 
	Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	Uladzislau Rezki <urezki@gmail.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Suren Baghdasaryan <surenb@google.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Alexei Starovoitov <ast@kernel.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-rt-devel@lists.linux.dev, bpf@vger.kernel.org, kasan-dev@googlegroups.com
Subject: Re: [PATCH v3 21/21] mm/slub: cleanup and repurpose some stat items
Message-ID: <5rmxfyxuhloucetufg2qic5elgi6frd7onjzdsosmhtjdqglij@5htmiqrdhkoj>
References: <20260116-sheaves-for-all-v3-0-5595cb000772@suse.cz>
 <20260116-sheaves-for-all-v3-21-5595cb000772@suse.cz>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260116-sheaves-for-all-v3-21-5595cb000772@suse.cz>
X-Migadu-Flow: FLOW_OUT

On Fri, Jan 16, 2026 at 03:40:41PM +0100, Vlastimil Babka wrote:
> A number of stat items related to cpu slabs became unused, remove them.
> 
> Two of those were ALLOC_FASTPATH and FREE_FASTPATH. But instead of
> removing those, use them instead of ALLOC_PCS and FREE_PCS, since
> sheaves are the new (and only) fastpaths, Remove the recently added
> _PCS variants instead.
> 
> Change where FREE_SLOWPATH is counted so that it only counts freeing of
> objects by slab users that (for whatever reason) do not go to a percpu
> sheaf, and not all (including internal) callers of __slab_free(). Thus
> flushing sheaves (counted by SHEAF_FLUSH) no longer also increments
> FREE_SLOWPATH. This matches how ALLOC_SLOWPATH doesn't count sheaf
> refills (counted by SHEAF_REFILL).
> 
> Reviewed-by: Suren Baghdasaryan <surenb@google.com>
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> ---
>  mm/slub.c | 77 +++++++++++++++++----------------------------------------------
>  1 file changed, 21 insertions(+), 56 deletions(-)
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index c12e90cb2fca..d73ad44fa046 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -330,33 +330,19 @@ enum add_mode {
>  };
>  
>  enum stat_item {
> -	ALLOC_PCS,		/* Allocation from percpu sheaf */
> -	ALLOC_FASTPATH,		/* Allocation from cpu slab */
> -	ALLOC_SLOWPATH,		/* Allocation by getting a new cpu slab */
> -	FREE_PCS,		/* Free to percpu sheaf */
> +	ALLOC_FASTPATH,		/* Allocation from percpu sheaves */
> +	ALLOC_SLOWPATH,		/* Allocation from partial or new slab */
>  	FREE_RCU_SHEAF,		/* Free to rcu_free sheaf */
>  	FREE_RCU_SHEAF_FAIL,	/* Failed to free to a rcu_free sheaf */
> -	FREE_FASTPATH,		/* Free to cpu slab */
> -	FREE_SLOWPATH,		/* Freeing not to cpu slab */
> +	FREE_FASTPATH,		/* Free to percpu sheaves */
> +	FREE_SLOWPATH,		/* Free to a slab */

Nits: Would it make sense to add stat(s, FREE_SLOWPATH) in
free_deferred_objects() as well, since it also calls __slab_free()?

Everything else looks good.

This patchset replaces cpu slab with cpu sheaves and really simplifies the code
overall - I really like the direction and the end result. It's really been a
pleasure reviewing this series. Thanks!

Reviewed-by: Hao Li <hao.li@linux.dev>

-- 
Thanks,
Hao

>  	FREE_ADD_PARTIAL,	/* Freeing moves slab to partial list */
>  	FREE_REMOVE_PARTIAL,	/* Freeing removes last object */
> -	ALLOC_FROM_PARTIAL,	/* Cpu slab acquired from node partial list */
> -	ALLOC_SLAB,		/* Cpu slab acquired from page allocator */
> -	ALLOC_REFILL,		/* Refill cpu slab from slab freelist */
> -	ALLOC_NODE_MISMATCH,	/* Switching cpu slab */
> +	ALLOC_SLAB,		/* New slab acquired from page allocator */
> +	ALLOC_NODE_MISMATCH,	/* Requested node different from cpu sheaf */
>  	FREE_SLAB,		/* Slab freed to the page allocator */
> -	CPUSLAB_FLUSH,		/* Abandoning of the cpu slab */
> -	DEACTIVATE_FULL,	/* Cpu slab was full when deactivated */
> -	DEACTIVATE_EMPTY,	/* Cpu slab was empty when deactivated */
> -	DEACTIVATE_REMOTE_FREES,/* Slab contained remotely freed objects */
> -	DEACTIVATE_BYPASS,	/* Implicit deactivation */
>  	ORDER_FALLBACK,		/* Number of times fallback was necessary */
> -	CMPXCHG_DOUBLE_CPU_FAIL,/* Failures of this_cpu_cmpxchg_double */
>  	CMPXCHG_DOUBLE_FAIL,	/* Failures of slab freelist update */
> -	CPU_PARTIAL_ALLOC,	/* Used cpu partial on alloc */
> -	CPU_PARTIAL_FREE,	/* Refill cpu partial on free */
> -	CPU_PARTIAL_NODE,	/* Refill cpu partial from node partial */
> -	CPU_PARTIAL_DRAIN,	/* Drain cpu partial to node partial */
>  	SHEAF_FLUSH,		/* Objects flushed from a sheaf */
>  	SHEAF_REFILL,		/* Objects refilled to a sheaf */
>  	SHEAF_ALLOC,		/* Allocation of an empty sheaf */
> @@ -4347,8 +4333,10 @@ void *alloc_from_pcs(struct kmem_cache *s, gfp_t gfp, int node)
>  	 * We assume the percpu sheaves contain only local objects although it's
>  	 * not completely guaranteed, so we verify later.
>  	 */
> -	if (unlikely(node_requested && node != numa_mem_id()))
> +	if (unlikely(node_requested && node != numa_mem_id())) {
> +		stat(s, ALLOC_NODE_MISMATCH);
>  		return NULL;
> +	}
>  
>  	if (!local_trylock(&s->cpu_sheaves->lock))
>  		return NULL;
> @@ -4371,6 +4359,7 @@ void *alloc_from_pcs(struct kmem_cache *s, gfp_t gfp, int node)
>  		 */
>  		if (page_to_nid(virt_to_page(object)) != node) {
>  			local_unlock(&s->cpu_sheaves->lock);
> +			stat(s, ALLOC_NODE_MISMATCH);
>  			return NULL;
>  		}
>  	}
> @@ -4379,7 +4368,7 @@ void *alloc_from_pcs(struct kmem_cache *s, gfp_t gfp, int node)
>  
>  	local_unlock(&s->cpu_sheaves->lock);
>  
> -	stat(s, ALLOC_PCS);
> +	stat(s, ALLOC_FASTPATH);
>  
>  	return object;
>  }
> @@ -4451,7 +4440,7 @@ unsigned int alloc_from_pcs_bulk(struct kmem_cache *s, gfp_t gfp, size_t size,
>  
>  	local_unlock(&s->cpu_sheaves->lock);
>  
> -	stat_add(s, ALLOC_PCS, batch);
> +	stat_add(s, ALLOC_FASTPATH, batch);
>  
>  	allocated += batch;
>  
> @@ -5111,8 +5100,6 @@ static void __slab_free(struct kmem_cache *s, struct slab *slab,
>  	unsigned long flags;
>  	bool on_node_partial;
>  
> -	stat(s, FREE_SLOWPATH);
> -
>  	if (IS_ENABLED(CONFIG_SLUB_TINY) || kmem_cache_debug(s)) {
>  		free_to_partial_list(s, slab, head, tail, cnt, addr);
>  		return;
> @@ -5416,7 +5403,7 @@ bool free_to_pcs(struct kmem_cache *s, void *object, bool allow_spin)
>  
>  	local_unlock(&s->cpu_sheaves->lock);
>  
> -	stat(s, FREE_PCS);
> +	stat(s, FREE_FASTPATH);
>  
>  	return true;
>  }
> @@ -5664,7 +5651,7 @@ static void free_to_pcs_bulk(struct kmem_cache *s, size_t size, void **p)
>  
>  	local_unlock(&s->cpu_sheaves->lock);
>  
> -	stat_add(s, FREE_PCS, batch);
> +	stat_add(s, FREE_FASTPATH, batch);
>  
>  	if (batch < size) {
>  		p += batch;
> @@ -5686,10 +5673,12 @@ static void free_to_pcs_bulk(struct kmem_cache *s, size_t size, void **p)
>  	 */
>  fallback:
>  	__kmem_cache_free_bulk(s, size, p);
> +	stat_add(s, FREE_SLOWPATH, size);
>  
>  flush_remote:
>  	if (remote_nr) {
>  		__kmem_cache_free_bulk(s, remote_nr, &remote_objects[0]);
> +		stat_add(s, FREE_SLOWPATH, remote_nr);
>  		if (i < size) {
>  			remote_nr = 0;
>  			goto next_remote_batch;
> @@ -5784,6 +5773,7 @@ void slab_free(struct kmem_cache *s, struct slab *slab, void *object,
>  	}
>  
>  	__slab_free(s, slab, object, object, 1, addr);
> +	stat(s, FREE_SLOWPATH);
>  }
>  
>  #ifdef CONFIG_MEMCG
> @@ -5806,8 +5796,10 @@ void slab_free_bulk(struct kmem_cache *s, struct slab *slab, void *head,
>  	 * With KASAN enabled slab_free_freelist_hook modifies the freelist
>  	 * to remove objects, whose reuse must be delayed.
>  	 */
> -	if (likely(slab_free_freelist_hook(s, &head, &tail, &cnt)))
> +	if (likely(slab_free_freelist_hook(s, &head, &tail, &cnt))) {
>  		__slab_free(s, slab, head, tail, cnt, addr);
> +		stat_add(s, FREE_SLOWPATH, cnt);
> +	}
>  }
>  
>  #ifdef CONFIG_SLUB_RCU_DEBUG
> @@ -6705,6 +6697,7 @@ int __kmem_cache_alloc_bulk(struct kmem_cache *s, gfp_t flags, size_t size,
>  		i = refill_objects(s, p, flags, size, size);
>  		if (i < size)
>  			goto error;
> +		stat_add(s, ALLOC_SLOWPATH, i);
>  	}
>  
>  	return i;
> @@ -8704,33 +8697,19 @@ static ssize_t text##_store(struct kmem_cache *s,		\
>  }								\
>  SLAB_ATTR(text);						\
>  
> -STAT_ATTR(ALLOC_PCS, alloc_cpu_sheaf);
>  STAT_ATTR(ALLOC_FASTPATH, alloc_fastpath);
>  STAT_ATTR(ALLOC_SLOWPATH, alloc_slowpath);
> -STAT_ATTR(FREE_PCS, free_cpu_sheaf);
>  STAT_ATTR(FREE_RCU_SHEAF, free_rcu_sheaf);
>  STAT_ATTR(FREE_RCU_SHEAF_FAIL, free_rcu_sheaf_fail);
>  STAT_ATTR(FREE_FASTPATH, free_fastpath);
>  STAT_ATTR(FREE_SLOWPATH, free_slowpath);
>  STAT_ATTR(FREE_ADD_PARTIAL, free_add_partial);
>  STAT_ATTR(FREE_REMOVE_PARTIAL, free_remove_partial);
> -STAT_ATTR(ALLOC_FROM_PARTIAL, alloc_from_partial);
>  STAT_ATTR(ALLOC_SLAB, alloc_slab);
> -STAT_ATTR(ALLOC_REFILL, alloc_refill);
>  STAT_ATTR(ALLOC_NODE_MISMATCH, alloc_node_mismatch);
>  STAT_ATTR(FREE_SLAB, free_slab);
> -STAT_ATTR(CPUSLAB_FLUSH, cpuslab_flush);
> -STAT_ATTR(DEACTIVATE_FULL, deactivate_full);
> -STAT_ATTR(DEACTIVATE_EMPTY, deactivate_empty);
> -STAT_ATTR(DEACTIVATE_REMOTE_FREES, deactivate_remote_frees);
> -STAT_ATTR(DEACTIVATE_BYPASS, deactivate_bypass);
>  STAT_ATTR(ORDER_FALLBACK, order_fallback);
> -STAT_ATTR(CMPXCHG_DOUBLE_CPU_FAIL, cmpxchg_double_cpu_fail);
>  STAT_ATTR(CMPXCHG_DOUBLE_FAIL, cmpxchg_double_fail);
> -STAT_ATTR(CPU_PARTIAL_ALLOC, cpu_partial_alloc);
> -STAT_ATTR(CPU_PARTIAL_FREE, cpu_partial_free);
> -STAT_ATTR(CPU_PARTIAL_NODE, cpu_partial_node);
> -STAT_ATTR(CPU_PARTIAL_DRAIN, cpu_partial_drain);
>  STAT_ATTR(SHEAF_FLUSH, sheaf_flush);
>  STAT_ATTR(SHEAF_REFILL, sheaf_refill);
>  STAT_ATTR(SHEAF_ALLOC, sheaf_alloc);
> @@ -8806,33 +8785,19 @@ static struct attribute *slab_attrs[] = {
>  	&remote_node_defrag_ratio_attr.attr,
>  #endif
>  #ifdef CONFIG_SLUB_STATS
> -	&alloc_cpu_sheaf_attr.attr,
>  	&alloc_fastpath_attr.attr,
>  	&alloc_slowpath_attr.attr,
> -	&free_cpu_sheaf_attr.attr,
>  	&free_rcu_sheaf_attr.attr,
>  	&free_rcu_sheaf_fail_attr.attr,
>  	&free_fastpath_attr.attr,
>  	&free_slowpath_attr.attr,
>  	&free_add_partial_attr.attr,
>  	&free_remove_partial_attr.attr,
> -	&alloc_from_partial_attr.attr,
>  	&alloc_slab_attr.attr,
> -	&alloc_refill_attr.attr,
>  	&alloc_node_mismatch_attr.attr,
>  	&free_slab_attr.attr,
> -	&cpuslab_flush_attr.attr,
> -	&deactivate_full_attr.attr,
> -	&deactivate_empty_attr.attr,
> -	&deactivate_remote_frees_attr.attr,
> -	&deactivate_bypass_attr.attr,
>  	&order_fallback_attr.attr,
>  	&cmpxchg_double_fail_attr.attr,
> -	&cmpxchg_double_cpu_fail_attr.attr,
> -	&cpu_partial_alloc_attr.attr,
> -	&cpu_partial_free_attr.attr,
> -	&cpu_partial_node_attr.attr,
> -	&cpu_partial_drain_attr.attr,
>  	&sheaf_flush_attr.attr,
>  	&sheaf_refill_attr.attr,
>  	&sheaf_alloc_attr.attr,
> 
> -- 
> 2.52.0
> 
