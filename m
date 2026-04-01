Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0115E3DFC98
	for <bpf@vger.kernel.org>; Wed,  1 Apr 2026 15:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775056410; cv=none; b=dz0u0iYy64Qf44LnsvNimF0Amg891wi+eC3wpNzpv4oIC8mH+ef7o9gB8WcXP54NTWi6NfHFXJzJ1Oqx0p1EgUj8QoMhMoKfXvSoML4dalDb3D53VQticYy1OyhNBQ0kNn1nb4bzcTErEeYaFDl+pKHWjfD1br/WzDHtBUGy4XI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775056410; c=relaxed/simple;
	bh=dZW1osxab7mGAZ4+fKmLDArIJTqJIxJtxILGSSJcmq8=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y3d6gw7pKazAEATbGu3cNQYktHkU1C61u2wAaQvhXKGhaKqDAbirDgxJmQ2zAzUr2ZyJHxYtr1UNRMEQDo9sllAqbgJt+z3je7tpcfm2HUTTMx4IKCAswDR7g4emFtXAL5kYgcZ7J0TquPhjlujpWjuXJTEgGKYWucYGNKDFbws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eVamrbcj; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eVamrbcj"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5a2bd236adbso1311415e87.1
        for <bpf@vger.kernel.org>; Wed, 01 Apr 2026 08:13:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775056397; x=1775661197; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7V8NwxjJKMOpltZaIZFZoGhOg5tW8DUtEYCSg58hw0M=;
        b=eVamrbcjDm6tLclOmFDuXaEUwDy2blI+CL7/wk0ZxnKU/wq6J+2k2khDQflpU04aw5
         oXz/D6GCdYYg2tQuGPwHTOTFguAL7eOGXtmjmeQ6Yi90JQYZUsD/XgS4gaJm1eoRKKAQ
         8boNqM9ABhfR2ehuvaUo+adbCXS3teE/4eZWoURNwU0XBCHMOPh58DNYsgE6ljrAL7DR
         B0osrmvvpLYR9kmCDPj6b+9SI8+9GduSv64eOJhesmtV+StEPe56WaA2/coeXdZZCJj5
         +elkrxXaklqGkq8xZ4EEEE94BQx61chvVtIXlp28ZFhFcktJAxbS29lnyvfHQupb6Teo
         dseg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775056397; x=1775661197;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7V8NwxjJKMOpltZaIZFZoGhOg5tW8DUtEYCSg58hw0M=;
        b=ixUz0MbKPS1yoNRvScBwm0UaSu++3XhIckKiesitcOtxK6diZZU/y6EjKvXMDTngzX
         f3jtOzF0bd/9QqZ92h9UFktXDDbc/lzU7rLH8hkDuRjwzXoudO2MUTPBmIkYptd/odNa
         yBfbEyYcbcCm7IZZkdLnTsh/uS7RVjkW8X9DKpKb5zDbQQuQ8TtD/pnCPD76Ze5peO/H
         wmWUiBREBlT6wnvrFGxn2vniGt969Jm7zxN5+nR4b3qvSUUT5zTQYs/7nkSEDIvokrPf
         FKN7WmWr2d/e+cDIKpoVSvLaeqkJn2btDX8qquQCmtAc1m7yLmL+WyUDDPBWqiurgJ50
         n0Og==
X-Forwarded-Encrypted: i=1; AJvYcCWa34Qu6sAsROK+ppcnMKEPdQMYvp+dnweSIWST7XdCHlqtFFWsaZySiHyCp1ar8aOUwM8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhT2DoUE134DdL9JV1ExTdBioXkj82vvPrP+nKYkg27KjRz6h4
	GIYCV4HvkXoViK1+h1QAl39+uPSh+ChV/GhqskwpuSNjPRLxWXoTG6/S
X-Gm-Gg: ATEYQzzwOq44aRevpQEYv/dc9mwCoYxfDV3Nsqe+Gu0N0bi6pGMUDysqBT5biqJ3zfO
	1wcY+tbJrct86VCNEASFkMMIJPYS/XgvXqWNeWZGxXW9Z1ppZXHlSDq+OSIzvXiT/V7rzAHxyKv
	SSnW4KDV674Cnu1ETUxDcr3bFQUfd/QuMYJXiDOk4A0xhAoKXzwtuWsrGp3ShFPwJYvH1wu868u
	DJmlzA7CKHOKcLYpiiqqsvGZb63YjKeXsxx7W1vGxLp5+rL2uAwFc8NvwbKFIDReqWRWr0eUX9x
	M6TpvqU3sM3yewcvZeAArUPcfpSUMWd5LmQThJA3qM0P1NCjs0V7BNtVuDJi5YsKyv8x0XB6y3M
	0qWLxuo8YBSSNUeX3ZlHX/wbzDALxpqC82OPc/WIc3L3VqOKdZe/oaMMLKLnyLzCA
X-Received: by 2002:a05:6512:4023:b0:5a2:c0b8:26e with SMTP id 2adb3069b0e04-5a2c220b4afmr1279512e87.21.1775056396314;
        Wed, 01 Apr 2026 08:13:16 -0700 (PDT)
Received: from milan ([2001:9b1:d5a0:a500::24b])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a2c6cc5f90sm4157e87.49.2026.04.01.08.13.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 08:13:10 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@milan>
Date: Wed, 1 Apr 2026 17:13:07 +0200
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
Subject: Re: [PATCH v6 2/3] vmalloc: Optimize vfree with free_pages_bulk()
Message-ID: <ac02A4ntuPKT7eyp@milan>
References: <20260401101634.2868165-1-usama.anjum@arm.com>
 <20260401101634.2868165-3-usama.anjum@arm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260401101634.2868165-3-usama.anjum@arm.com>

On Wed, Apr 01, 2026 at 11:16:20AM +0100, Muhammad Usama Anjum wrote:
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
> Acked-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
> Acked-by: Zi Yan <ziy@nvidia.com>
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> Co-developed-by: Muhammad Usama Anjum <usama.anjum@arm.com>
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@arm.com>
> ---
> Changes since v5:
> - Change subject
> 
> Changes since v4:
> - Use num_pages_contiguous() instead of raw loop
> 
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
>  mm/page_alloc.c     | 28 ++++++++++++++++++++++++++++
>  mm/vmalloc.c        | 16 +++++-----------
>  3 files changed, 35 insertions(+), 11 deletions(-)
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
> index fb4522ba51faf..6568af69b5cdb 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -5175,6 +5175,34 @@ unsigned long alloc_pages_bulk_noprof(gfp_t gfp, int preferred_nid,
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
> +	while (nr_pages) {
> +		unsigned long nr_contig = num_pages_contiguous(page_array, nr_pages);
> +
> +		__free_contig_range(page_to_pfn(*page_array), nr_contig);
> +
> +		nr_pages -= nr_contig;
> +		page_array += nr_contig;
> +		cond_resched();
> +	}
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

LGTM: At least vmalloc change

I do not see any concern(mentioned by AI) if mod_lruvec_page_state();
is invoked in loop without cond_resched(). The operation is light and
nr_pages can not be millions of pages.

Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>

--
Uladzislau Rezki
