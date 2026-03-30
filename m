Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66BCC2DF136
	for <bpf@vger.kernel.org>; Mon, 30 Mar 2026 12:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774873863; cv=none; b=MEdMSUu5+I2AiiB10uAzW4Wd0ZZzr/LBSJtEYPItadSMOKNbObMPbM9/ZPkBYXKgftwYFHmzZgVPMToQiVRuRWHExMVa4CkZ+EF1MOfQXJgJPlcYf0NWNeexdrjo9K0VnrrlKIm4ureBpILc3voBx6s98DrJXn6tllikcqxS7Ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774873863; c=relaxed/simple;
	bh=Vhzcs9xescUcl05rBTbxkHV0uYwVcBAhpm5hjzjRAAQ=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aOJWAVzswanDXl3oHJPZMgHBzrKHJoG1xzlESO1eREyA8zdp9fJkA3oUUQZbOD3LVuiPmxjmyR2aml/3FwYPzoSSSAj3K6XARl8iz744VTLHNzOPucG+P5tTGuqPvZ+VfVHEnWPXwkZY7nDFpmS3GYLQGXcUrFzOCIxZo9lb4d4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KQMlU8vN; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KQMlU8vN"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5a2b542cbaaso1215321e87.0
        for <bpf@vger.kernel.org>; Mon, 30 Mar 2026 05:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774873860; x=1775478660; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tHeubX3+pOYegU1tnp4ax8+OXv2EqUmQq1HgXTpbPNE=;
        b=KQMlU8vNjMr60YPhCwPJ/2+E4BqzXg1Q3br29x8yHGlJMHiBPhhlwKkiRQMDFvnCs2
         Ve3b5lehRK/BiV1xEWpjEgf+F2vCPTknFQKEWQ4QheIHR4VtWUfBY2wrE6W1uexKYcmx
         E8RQSBAGiuegs0TjMsAbW8iGwpmbqPEzR7L/Y8h+fgQSIrsJeYO1w48Mf08NrCerTaMi
         JSyfMSsY2KKHJO9cgdWcUOyB7hPgLPGI1WWJcezICiJXbMPC8oMD+jFoFJza3QzKQvHM
         n14AZWV6aVpvfQxE0FVbejF+Sgnhv74+ZRIoTnYtf93s+DNKQkk1dlaaWKAcUiJlRAEu
         O+jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774873860; x=1775478660;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tHeubX3+pOYegU1tnp4ax8+OXv2EqUmQq1HgXTpbPNE=;
        b=qVgmqWI1+QwvQbPJZH3z3+tn8WO5jzWkrm7lo/9iij5Xirg9QD4fvewMIxTDPmgFg+
         sR2U1NRo1AZtrRdzHImRl/+bbDthKpdIOUEk4CLOjzakA64Qy6WunOI1ajRqM33rVxPP
         LN3tC7vlZUus2qP8Awvjr2l9986Aez0X6Cc+791I1zZ+KeBktlNdawb9r8jWi24Xt1bJ
         D4MmdMZ5VDwTYXDqoqBq7SOabCot78ix2d+lj0gb0oERa7dDUJxulV0Uo7rsCMqi7rKn
         oDCnrv/GcUFnjxeWJi8dVgh+66fhSpz8v55/CB2ERYUcF0gpxYsdP0aqdiCEYPe9vZGe
         KUGw==
X-Forwarded-Encrypted: i=1; AJvYcCU2fs2VeUyc0Cki84k22OxgcLbcyD3r2I4/UJfSgJgDB1DUeFgYYCs7fyL5+6aJNfOFBFM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBqFlpgScyBsiopIjzRPinD8Pq0QhbAv3lxtnnpyGeUPk69Pdu
	ZcUCBSnnVQEoAYDnXUprapYyUGDMCBiiHdJnrHo932KKT5PKhIW3OPQY
X-Gm-Gg: ATEYQzz8yyVIt6zDHyO1k8r8iEn3GEqATsMHPe0NQQ032b6+F3rHO+/6UNq3k5tI0Kw
	x/Izlv/ERtvv8bWeShUbA6nVxHMlMSb1YHRXxXFzArTBeTilC4lWYW74Nq8c7DpY6B3wpuLMNFW
	n1of/QyEox7cszmkzDUoSX5cAQUqstQ7+clxiQaZud9ddPMyls/orBEb6/QhTc3Afa+DyQ0zJDs
	vioqKKUxvhn2vaEcu9EWuOtu/hSI61s4U5LqPZO4IAHuWxGOIuYEoiwfaQEp7d2JWDkLBnc3Rgm
	2CKbfEzlo1RsGxBctZAaebryMDm046iXniTaQ7anwWQemdSKp+qOHLxRP8Kg0vr+xQTiUsb4UgO
	NuVAQCisi9VDVzzeQnX478oS8XubKm65FPx5YGev+3qDmYpO4cwrRK0cc7IoeTmRc
X-Received: by 2002:a05:6512:2308:b0:5a2:afba:65ee with SMTP id 2adb3069b0e04-5a2afba67abmr3252197e87.42.1774873859116;
        Mon, 30 Mar 2026 05:30:59 -0700 (PDT)
Received: from milan ([2001:9b1:d5a0:a500::24b])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-38c836d3f31sm16408931fa.3.2026.03.30.05.30.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 05:30:58 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@milan>
Date: Mon, 30 Mar 2026 14:30:56 +0200
To: Muhammad Usama Anjum <usama.anjum@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Brendan Jackman <jackmanb@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>,
	Uladzislau Rezki <urezki@gmail.com>, Nick Terrell <terrelln@fb.com>,
	David Sterba <dsterba@suse.com>,
	Vishal Moola <vishal.moola@gmail.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	Ryan.Roberts@arm.com, david.hildenbrand@arm.com
Subject: Re: [PATCH v4 2/3] vmalloc: Optimize vfree
Message-ID: <acptAMZrCKz3Y7O3@milan>
References: <20260327125720.2270651-1-usama.anjum@arm.com>
 <20260327125720.2270651-3-usama.anjum@arm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260327125720.2270651-3-usama.anjum@arm.com>

On Fri, Mar 27, 2026 at 12:57:14PM +0000, Muhammad Usama Anjum wrote:
> From: Ryan Roberts <ryan.roberts@arm.com>
> 
> Whenever vmalloc allocates high order pages (e.g. for a huge mapping) it
> must immediately split_page() to order-0 so that it remains compatible
> with users that want to access the underlying struct page.
> Commit a06157804399 ("mm/vmalloc: request large order pages from buddy
> allocator") recently made it much more likely for vmalloc to allocate
> high order pages which are subsequently split to order-0.
> 
> Unfortunately this had the side effect of causing performance
> regressions for tight vmalloc/vfree loops (e.g. test_vmalloc.ko
> benchmarks). See Closes: tag. This happens because the high order pages
> must be gotten from the buddy but then because they are split to
> order-0, when they are freed they are freed to the order-0 pcp.
> Previously allocation was for order-0 pages so they were recycled from
> the pcp.
> 
> It would be preferable if when vmalloc allocates an (e.g.) order-3 page
> that it also frees that order-3 page to the order-3 pcp, then the
> regression could be removed.
> 
> So let's do exactly that; update stats separately first as coalescing is
> hard to do correctly without complexity. Use free_pages_bulk() which uses
> the new __free_contig_range() API to batch-free contiguous ranges of pfns.
> This not only removes the regression, but significantly improves
> performance of vfree beyond the baseline.
> 
> A selection of test_vmalloc benchmarks running on arm64 server class
> system. mm-new is the baseline. Commit a06157804399 ("mm/vmalloc: request
> large order pages from buddy allocator") was added in v6.19-rc1 where we
> see regressions. Then with this change performance is much better. (>0
> is faster, <0 is slower, (R)/(I) = statistically significant
> Regression/Improvement):
> 
> +-----------------+----------------------------------------------------------+-------------------+--------------------+
> | Benchmark       | Result Class                                             |   mm-new          |  this series       |
> +=================+==========================================================+===================+====================+
> | micromm/vmalloc | fix_align_alloc_test: p:1, h:0, l:500000 (usec)          |        1331843.33 |         (I) 67.17% |
> |                 | fix_size_alloc_test: p:1, h:0, l:500000 (usec)           |         415907.33 |             -5.14% |
> |                 | fix_size_alloc_test: p:4, h:0, l:500000 (usec)           |         755448.00 |         (I) 53.55% |
> |                 | fix_size_alloc_test: p:16, h:0, l:500000 (usec)          |        1591331.33 |         (I) 57.26% |
> |                 | fix_size_alloc_test: p:16, h:1, l:500000 (usec)          |        1594345.67 |         (I) 68.46% |
> |                 | fix_size_alloc_test: p:64, h:0, l:100000 (usec)          |        1071826.00 |         (I) 79.27% |
> |                 | fix_size_alloc_test: p:64, h:1, l:100000 (usec)          |        1018385.00 |         (I) 84.17% |
> |                 | fix_size_alloc_test: p:256, h:0, l:100000 (usec)         |        3970899.67 |         (I) 77.01% |
> |                 | fix_size_alloc_test: p:256, h:1, l:100000 (usec)         |        3821788.67 |         (I) 89.44% |
> |                 | fix_size_alloc_test: p:512, h:0, l:100000 (usec)         |        7795968.00 |         (I) 82.67% |
> |                 | fix_size_alloc_test: p:512, h:1, l:100000 (usec)         |        6530169.67 |        (I) 118.09% |
> |                 | full_fit_alloc_test: p:1, h:0, l:500000 (usec)           |         626808.33 |             -0.98% |
> |                 | kvfree_rcu_1_arg_vmalloc_test: p:1, h:0, l:500000 (usec) |         532145.67 |             -1.68% |
> |                 | kvfree_rcu_2_arg_vmalloc_test: p:1, h:0, l:500000 (usec) |         537032.67 |             -0.96% |
> |                 | long_busy_list_alloc_test: p:1, h:0, l:500000 (usec)     |        8805069.00 |         (I) 74.58% |
> |                 | pcpu_alloc_test: p:1, h:0, l:500000 (usec)               |         500824.67 |              4.35% |
> |                 | random_size_align_alloc_test: p:1, h:0, l:500000 (usec)  |        1637554.67 |         (I) 76.99% |
> |                 | random_size_alloc_test: p:1, h:0, l:500000 (usec)        |        4556288.67 |         (I) 72.23% |
> |                 | vm_map_ram_test: p:1, h:0, l:500000 (usec)               |         107371.00 |             -0.70% |
> +-----------------+----------------------------------------------------------+-------------------+--------------------+
> 
> Fixes: a06157804399 ("mm/vmalloc: request large order pages from buddy allocator")
> Closes: https://lore.kernel.org/all/66919a28-bc81-49c9-b68f-dd7c73395a0d@arm.com/
> Acked-by: Zi Yan <ziy@nvidia.com>
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> Co-developed-by: Muhammad Usama Anjum <usama.anjum@arm.com>
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@arm.com>
> ---
> Changes since v3:
> - Add kerneldoc comment and update description
> - Add tag
> 
> Changes since v2:
> - Remove BUG_ON in favour of simple implementation as this has never
>   been seen to output any bug in the past as well
> - Move the free loop to separate function, free_pages_bulk()
> - Update stats, lruvec_stat in separate loop
> 
> Changes since v1:
> - Rebase on mm-new
> - Rerun benchmarks
> ---
>  include/linux/gfp.h |  2 ++
>  mm/page_alloc.c     | 38 ++++++++++++++++++++++++++++++++++++++
>  mm/vmalloc.c        | 16 +++++-----------
>  3 files changed, 45 insertions(+), 11 deletions(-)
> 
> diff --git a/include/linux/gfp.h b/include/linux/gfp.h
> index 7c1f9da7c8e56..71f9097ab99a0 100644
> --- a/include/linux/gfp.h
> +++ b/include/linux/gfp.h
> @@ -239,6 +239,8 @@ unsigned long alloc_pages_bulk_noprof(gfp_t gfp, int preferred_nid,
>  				struct page **page_array);
>  #define __alloc_pages_bulk(...)			alloc_hooks(alloc_pages_bulk_noprof(__VA_ARGS__))
>  
> +void free_pages_bulk(struct page **page_array, unsigned long nr_pages);
> +
>  unsigned long alloc_pages_bulk_mempolicy_noprof(gfp_t gfp,
>  				unsigned long nr_pages,
>  				struct page **page_array);
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 18a96b51aa0be..64be8a9019dca 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -5175,6 +5175,44 @@ unsigned long alloc_pages_bulk_noprof(gfp_t gfp, int preferred_nid,
>  }
>  EXPORT_SYMBOL_GPL(alloc_pages_bulk_noprof);
>  
> +/*
> + * free_pages_bulk - Free an array of order-0 pages
> + * @page_array: Array of pages to free
> + * @nr_pages: The number of pages in the array
> + *
> + * Free the order-0 pages. Adjacent entries whose PFNs form a contiguous
> + * run are released with a single __free_contig_range() call.
> + *
> + * This assumes page_array is sorted in ascending PFN order. Without that,
> + * the function still frees all pages, but contiguous runs may not be
> + * detected and the freeing pattern can degrade to freeing one page at a
> + * time.
> + *
> + * Context: Sleepable process context only; calls cond_resched()
> + */
> +void free_pages_bulk(struct page **page_array, unsigned long nr_pages)
> +{
> +	unsigned long start_pfn = 0, pfn;
> +	unsigned long i, nr_contig = 0;
> +
> +	for (i = 0; i < nr_pages; i++) {
> +		pfn = page_to_pfn(page_array[i]);
> +		if (!nr_contig) {
> +			start_pfn = pfn;
> +			nr_contig = 1;
> +		} else if (start_pfn + nr_contig != pfn) {
> +			__free_contig_range(start_pfn, nr_contig);
> +			start_pfn = pfn;
> +			nr_contig = 1;
> +			cond_resched();
> +		} else {
> +			nr_contig++;
> +		}
> +	}
> +	if (nr_contig)
> +		__free_contig_range(start_pfn, nr_contig);
> +}
> +
>  /*
>   * This is the 'heart' of the zoned buddy allocator.
>   */
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index c607307c657a6..e9b3d6451e48b 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -3459,19 +3459,13 @@ void vfree(const void *addr)
>  
>  	if (unlikely(vm->flags & VM_FLUSH_RESET_PERMS))
>  		vm_reset_perms(vm);
> -	for (i = 0; i < vm->nr_pages; i++) {
> -		struct page *page = vm->pages[i];
>  
> -		BUG_ON(!page);
> -		/*
> -		 * High-order allocs for huge vmallocs are split, so
> -		 * can be freed as an array of order-0 allocations
> -		 */
> -		if (!(vm->flags & VM_MAP_PUT_PAGES))
> -			mod_lruvec_page_state(page, NR_VMALLOC, -1);
> -		__free_page(page);
> -		cond_resched();
> +	if (!(vm->flags & VM_MAP_PUT_PAGES)) {
> +		for (i = 0; i < vm->nr_pages; i++)
> +			mod_lruvec_page_state(vm->pages[i], NR_VMALLOC, -1);
>  	}
> +	free_pages_bulk(vm->pages, vm->nr_pages);
> +
>  	kvfree(vm->pages);
>  	kfree(vm);
>  }
> -- 
> 2.47.3
> 
LGTM:

Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>

--
Uladzislau Rezki
