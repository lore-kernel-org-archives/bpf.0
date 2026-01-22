Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81AE0425CE7
	for <bpf@vger.kernel.org>; Thu, 22 Jan 2026 04:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769057959; cv=none; b=pP+uUPTGpsnksGKcjvvs2c54IlJqIe1H3kKtxVgHgaNvzUatjDH3tHUo3q5J6sE2+YHX1JT5m1QXJQk7nwNfFpmnuyUdlw+ZokVY6AwIV7vJ3QH7eZz+CMlL1W+mufpWh9p5XdGlusOeEjAbCUdUOdwNnn/jfwCzoC8CxOhU5SY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769057959; c=relaxed/simple;
	bh=nBalSnZ5sgtAF0RbPR61uXwFLdWtmdqbpdmK9pTkQE0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mDgjY7BYbOXb4ujJTlDX+ZxoOag7bNt422q/W+WIpVJtgaZGqIGxnQF0kZyRj8goevr+j8knDLIsbuZeeDr9fmrb2iNRhOy4VyrZfyAtWw7HzuG8q9HsVPfd7DWwJbLt31YnwBz4BpoPKilnLaiEKowJ35IULY0COFgAdEd6RrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ibmzka49; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ibmzka49"
Date: Thu, 22 Jan 2026 12:58:54 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1769057945;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MdpaA1zGTiovVE63EwimqyFpitVdOAF+4rwOeZdtVJc=;
	b=ibmzka49BLCb+VtqiOWz+F80wMeecNCfysx49eFBGfx1o6zi1Aaj/kQXMCeHsVNXR8kP04
	Lz68Ro2RfH5pjpOPQOK/w/Z8l4grQzLZRCmCcohTVKtswqjQvVnM9PtITTaluXuR3h/tt3
	dRap4bu40onjY+ct2VdHYx6n9zQxT7M=
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
Subject: Re: [PATCH v3 17/21] slab: refill sheaves from all nodes
Message-ID: <gmpxnzifhxamwnngr6holbcfdd42fvuq2xtqrqvdz75zv6fb57@hxbmcgfxtuko>
References: <20260116-sheaves-for-all-v3-0-5595cb000772@suse.cz>
 <20260116-sheaves-for-all-v3-17-5595cb000772@suse.cz>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260116-sheaves-for-all-v3-17-5595cb000772@suse.cz>
X-Migadu-Flow: FLOW_OUT

On Fri, Jan 16, 2026 at 03:40:37PM +0100, Vlastimil Babka wrote:
> __refill_objects() currently only attempts to get partial slabs from the
> local node and then allocates new slab(s). Expand it to trying also
> other nodes while observing the remote node defrag ratio, similarly to
> get_any_partial().
> 
> This will prevent allocating new slabs on a node while other nodes have
> many free slabs. It does mean sheaves will contain non-local objects in
> that case. Allocations that care about specific node will still be
> served appropriately, but might get a slowpath allocation.
> 
> Like get_any_partial() we do observe cpuset_zone_allowed(), although we
> might be refilling a sheaf that will be then used from a different
> allocation context.
> 
> We can also use the resulting refill_objects() in
> __kmem_cache_alloc_bulk() for non-debug caches. This means
> kmem_cache_alloc_bulk() will get better performance when sheaves are
> exhausted. kmem_cache_alloc_bulk() cannot indicate a preferred node so
> it's compatible with sheaves refill in preferring the local node.
> Its users also have gfp flags that allow spinning, so document that
> as a requirement.
> 
> Reviewed-by: Suren Baghdasaryan <surenb@google.com>
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> ---
>  mm/slub.c | 137 ++++++++++++++++++++++++++++++++++++++++++++++++--------------
>  1 file changed, 106 insertions(+), 31 deletions(-)
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index d52de6e3c2d5..2c522d2bf547 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -2518,8 +2518,8 @@ static void free_empty_sheaf(struct kmem_cache *s, struct slab_sheaf *sheaf)
>  }
>  
>  static unsigned int
> -__refill_objects(struct kmem_cache *s, void **p, gfp_t gfp, unsigned int min,
> -		 unsigned int max);
> +refill_objects(struct kmem_cache *s, void **p, gfp_t gfp, unsigned int min,
> +	       unsigned int max);
>  
>  static int refill_sheaf(struct kmem_cache *s, struct slab_sheaf *sheaf,
>  			 gfp_t gfp)
> @@ -2530,8 +2530,8 @@ static int refill_sheaf(struct kmem_cache *s, struct slab_sheaf *sheaf,
>  	if (!to_fill)
>  		return 0;
>  
> -	filled = __refill_objects(s, &sheaf->objects[sheaf->size], gfp,
> -			to_fill, to_fill);
> +	filled = refill_objects(s, &sheaf->objects[sheaf->size], gfp, to_fill,
> +				to_fill);
>  
>  	sheaf->size += filled;
>  
> @@ -6522,29 +6522,22 @@ void kmem_cache_free_bulk(struct kmem_cache *s, size_t size, void **p)
>  EXPORT_SYMBOL(kmem_cache_free_bulk);
>  
>  static unsigned int
> -__refill_objects(struct kmem_cache *s, void **p, gfp_t gfp, unsigned int min,
> -		 unsigned int max)
> +__refill_objects_node(struct kmem_cache *s, void **p, gfp_t gfp, unsigned int min,
> +		      unsigned int max, struct kmem_cache_node *n)
>  {
>  	struct slab *slab, *slab2;
>  	struct partial_context pc;
>  	unsigned int refilled = 0;
>  	unsigned long flags;
>  	void *object;
> -	int node;
>  
>  	pc.flags = gfp;
>  	pc.min_objects = min;
>  	pc.max_objects = max;
>  
> -	node = numa_mem_id();
> -
> -	if (WARN_ON_ONCE(!gfpflags_allow_spinning(gfp)))
> +	if (!get_partial_node_bulk(s, n, &pc))
>  		return 0;
>  
> -	/* TODO: consider also other nodes? */
> -	if (!get_partial_node_bulk(s, get_node(s, node), &pc))
> -		goto new_slab;
> -
>  	list_for_each_entry_safe(slab, slab2, &pc.slabs, slab_list) {
>  
>  		list_del(&slab->slab_list);
> @@ -6582,8 +6575,6 @@ __refill_objects(struct kmem_cache *s, void **p, gfp_t gfp, unsigned int min,
>  	}
>  
>  	if (unlikely(!list_empty(&pc.slabs))) {
> -		struct kmem_cache_node *n = get_node(s, node);
> -
>  		spin_lock_irqsave(&n->list_lock, flags);
>  
>  		list_for_each_entry_safe(slab, slab2, &pc.slabs, slab_list) {
> @@ -6605,13 +6596,92 @@ __refill_objects(struct kmem_cache *s, void **p, gfp_t gfp, unsigned int min,
>  		}
>  	}
>  
> +	return refilled;
> +}
>  
> -	if (likely(refilled >= min))
> -		goto out;
> +#ifdef CONFIG_NUMA
> +static unsigned int
> +__refill_objects_any(struct kmem_cache *s, void **p, gfp_t gfp, unsigned int min,
> +		     unsigned int max, int local_node)


Just a small note: I noticed that the local_node variable is unused. It seems
the intention was to skip local_node in __refill_objects_any(), since it had
already been attempted in __refill_objects_node().

Everything else looks good.

Reviewed-by: Hao Li <hao.li@linux.dev>

> +{
> +	struct zonelist *zonelist;
> +	struct zoneref *z;
> +	struct zone *zone;
> +	enum zone_type highest_zoneidx = gfp_zone(gfp);
> +	unsigned int cpuset_mems_cookie;
> +	unsigned int refilled = 0;
> +
> +	/* see get_any_partial() for the defrag ratio description */
> +	if (!s->remote_node_defrag_ratio ||
> +			get_cycles() % 1024 > s->remote_node_defrag_ratio)
> +		return 0;
> +
> +	do {
> +		cpuset_mems_cookie = read_mems_allowed_begin();
> +		zonelist = node_zonelist(mempolicy_slab_node(), gfp);
> +		for_each_zone_zonelist(zone, z, zonelist, highest_zoneidx) {
> +			struct kmem_cache_node *n;
> +			unsigned int r;
> +
> +			n = get_node(s, zone_to_nid(zone));
> +
> +			if (!n || !cpuset_zone_allowed(zone, gfp) ||
> +					n->nr_partial <= s->min_partial)
> +				continue;
> +
> +			r = __refill_objects_node(s, p, gfp, min, max, n);
> +			refilled += r;
> +
> +			if (r >= min) {
> +				/*
> +				 * Don't check read_mems_allowed_retry() here -
> +				 * if mems_allowed was updated in parallel, that
> +				 * was a harmless race between allocation and
> +				 * the cpuset update
> +				 */
> +				return refilled;
> +			}
> +			p += r;
> +			min -= r;
> +			max -= r;
> +		}
> +	} while (read_mems_allowed_retry(cpuset_mems_cookie));
> +
> +	return refilled;
> +}
> +#else
> +static inline unsigned int
> +__refill_objects_any(struct kmem_cache *s, void **p, gfp_t gfp, unsigned int min,
> +		     unsigned int max, int local_node)
> +{
> +	return 0;
> +}
> +#endif
> +
> +static unsigned int
> +refill_objects(struct kmem_cache *s, void **p, gfp_t gfp, unsigned int min,
> +	       unsigned int max)
> +{
> +	int local_node = numa_mem_id();
> +	unsigned int refilled;
> +	struct slab *slab;
> +
> +	if (WARN_ON_ONCE(!gfpflags_allow_spinning(gfp)))
> +		return 0;
> +
> +	refilled = __refill_objects_node(s, p, gfp, min, max,
> +					 get_node(s, local_node));
> +	if (refilled >= min)
> +		return refilled;
> +
> +	refilled += __refill_objects_any(s, p + refilled, gfp, min - refilled,
> +					 max - refilled, local_node);
> +	if (refilled >= min)
> +		return refilled;
>  
>  new_slab:
>  
> -	slab = new_slab(s, pc.flags, node);
> +	slab = new_slab(s, gfp, local_node);
>  	if (!slab)
>  		goto out;
>  
> @@ -6626,8 +6696,8 @@ __refill_objects(struct kmem_cache *s, void **p, gfp_t gfp, unsigned int min,
>  
>  	if (refilled < min)
>  		goto new_slab;
> -out:
>  
> +out:
>  	return refilled;
>  }
>  
> @@ -6637,18 +6707,20 @@ int __kmem_cache_alloc_bulk(struct kmem_cache *s, gfp_t flags, size_t size,
>  {
>  	int i;
>  
> -	/*
> -	 * TODO: this might be more efficient (if necessary) by reusing
> -	 * __refill_objects()
> -	 */
> -	for (i = 0; i < size; i++) {
> +	if (IS_ENABLED(CONFIG_SLUB_TINY) || kmem_cache_debug(s)) {
> +		for (i = 0; i < size; i++) {
>  
> -		p[i] = ___slab_alloc(s, flags, NUMA_NO_NODE, _RET_IP_,
> -				     s->object_size);
> -		if (unlikely(!p[i]))
> -			goto error;
> +			p[i] = ___slab_alloc(s, flags, NUMA_NO_NODE, _RET_IP_,
> +					     s->object_size);
> +			if (unlikely(!p[i]))
> +				goto error;
>  
> -		maybe_wipe_obj_freeptr(s, p[i]);
> +			maybe_wipe_obj_freeptr(s, p[i]);
> +		}
> +	} else {
> +		i = refill_objects(s, p, flags, size, size);
> +		if (i < size)
> +			goto error;
>  	}
>  
>  	return i;
> @@ -6659,7 +6731,10 @@ int __kmem_cache_alloc_bulk(struct kmem_cache *s, gfp_t flags, size_t size,
>  
>  }
>  
> -/* Note that interrupts must be enabled when calling this function. */
> +/*
> + * Note that interrupts must be enabled when calling this function and gfp
> + * flags must allow spinning.
> + */
>  int kmem_cache_alloc_bulk_noprof(struct kmem_cache *s, gfp_t flags, size_t size,
>  				 void **p)
>  {
> 
> -- 
> 2.52.0
> 
