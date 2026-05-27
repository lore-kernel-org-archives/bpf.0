Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B07B3CF689
	for <bpf@vger.kernel.org>; Wed, 27 May 2026 08:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779869188; cv=none; b=Au5S95zikHsKe/LPVJokWhNJlfDCONP+8J1KfGS2Q9rEcfS9eNT53YQ4scjxwDi/u/h9UTNyjkOJ+mrDxN+KqGm9jVTAValv38cuEL5rO0AjVTT9amo+I58cNXoD7TD/KsSR84z8cZNdd7DJRaGtbrsz/C/6ZYtaokX1isxvSfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779869188; c=relaxed/simple;
	bh=yXhnmlqn6x0Qf5z9mhVW9Ue33vEccoa7DzYQrKwNw4I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cNwH323AwZ2kLXpUcpKh1wwKDWXG88Z4/8OGgvBmjOcPZqcq3IwRlVG3ktcdHQEzxPn3BBa2Slt4kK7w/2ljnusFKi0My1t9n9c62k8kDbtFSSutJj6Qq87ls0k5v5HZE1V4rmeTaoNrQDFbBUOg3ovnPaHtlp2y5vGsjKLQwIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 71A7168BEB; Wed, 27 May 2026 10:06:24 +0200 (CEST)
Date: Wed, 27 May 2026 10:06:24 +0200
From: Christoph Hellwig <hch@lst.de>
To: sashiko-reviews@lists.linux.dev
Cc: Christoph Hellwig <hch@lst.de>, bpf@vger.kernel.org
Subject: Re: [PATCH] mm/slab: improve kmem_cache_alloc_bulk
Message-ID: <20260527080624.GA20439@lst.de>
References: <20260527070239.2252948-2-hch@lst.de> <20260527072718.42A141F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260527072718.42A141F000E9@smtp.kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, May 27, 2026 at 07:27:17AM +0000, sashiko-bot@kernel.org wrote:
> Does this omit setting op_ctx->rsvd_page_tables.count to pt_count on success?
> Since op_ctx is initialized via memset previously, the count will remain 0,
> which could lead to memory leaks when these page tables are consumed or
> cleaned up later.

Yes, fixed.

> >  			} else {
> >  				int i;
> > -				for (i = 0; i < ret; i++)
> > +				for (i = 0; i < BULK_SIZE; i++)
> >  					fail |= check_buf(bulk_array[i], size, want_ctor, want_rcu, want_zero);
> >  				kmem_cache_free_bulk(c, ret, bulk_array);
> 
> [Severity: Low]
> Will this cause a compilation error? The local variable ret is removed from
> this scope, but it is still used in the kmem_cache_free_bulk() call above.

Yes, no idea why this didn't get included in my build after
enabling it earlier.

> 
> >  			}
> > @@ -354,17 +352,18 @@ static int __init do_kmem_cache_size_bulk(int size, int *total_failures)
> >  
> >  	c = kmem_cache_create("test_cache", size, size, 0, NULL);
> >  	for (iter = 0; (iter < maxiter) && !fail; iter++) {
> > -		num = kmem_cache_alloc_bulk(c, GFP_KERNEL, ARRAY_SIZE(objects),
> > -					    objects);
> > -		for (i = 0; i < num; i++) {
> > +		if (!kmem_cache_alloc_bulk(c, GFP_KERNEL, ARRAY_SIZE(objects),
> > +				objects))
> > +			continue;
> > +
> > +		for (i = 0; i < ARRAY_SIZE(objects); i++) {
> >  			bytes = count_nonzero_bytes(objects[i], size);
> >  			if (bytes)
> >  				fail = true;
> >  			fill_with_garbage(objects[i], size);
> >  		}
> >  
> > -		if (num)
> > -			kmem_cache_free_bulk(c, num, objects);
> > +		kmem_cache_free_bulk(c, num, objects);
> 
> [Severity: Medium]
> Is num uninitialized here? It's no longer assigned the result of the
> allocation call, so passing it to kmem_cache_free_bulk() might use
> indeterminate stack data and lead to memory corruption.

Yes, this should use ARRAY_SIZE directly as well.

> > +bool kmem_cache_alloc_bulk_noprof(struct kmem_cache *s, gfp_t flags,
> > +		size_t size, void **p)
> >  {
> >  	unsigned int i = 0;
> >  	void *kfence_obj;
> >  
> >  	if (!size)
> > -		return 0;
> > +		return false;
> 
> [Severity: High]
> Does this incorrectly report an allocation failure when size is 0?

It correctly reports one as that's how all callers treat a 0 return.

Update version in git here, not reposting until more human comments
arrive:

https://git.infradead.org/?p=users/hch/misc.git;a=shortlog;h=refs/heads/fix-kmem_cache_alloc_bulk
