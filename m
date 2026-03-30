Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E66F19ABD8;
	Mon, 30 Mar 2026 14:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774881021; cv=none; b=bRP4MuvHid4CBma2XvPdf+/Pz0duPfI3wftC9SSOaD+4FPKqcYn+vUQI+3RbDubhz4IyDH2cZIrnv6CyDwGgD6Y0lF8MUfLRhNpP2ghZNWybxtpNSsORldE130U499zOKkbdAIPfJAxA0DoCSM7H96sTcz/UZ0orpsZOM1wuw6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774881021; c=relaxed/simple;
	bh=ZS3OUwwq2nYZzMP99yXm6JGeU6JJqt9zFp2EiybodHA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=EFCVuN2WE3EzV0+4kWuXVdI0Tn1MKpxAtGVFcehFdu21ZHJmxoetJWgOo4Wf3Z9X5pLctega0tXFfwtmvuL3dNsM7H/9Td0hgcKQM43J8pVqcju+PztPLpdO0cBJkrYFrHVjlPpEkhBUmWy1+WgzDSaTlZuR2wWTe1wUEAcW/zQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V/1qL4FW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V/1qL4FW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65B67C4CEF7;
	Mon, 30 Mar 2026 14:30:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774881021;
	bh=ZS3OUwwq2nYZzMP99yXm6JGeU6JJqt9zFp2EiybodHA=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=V/1qL4FWFPEzripEDi0iH0l1RG9W3igBF+HtPx6qB12DGhLLVltF/+epnEB0XG4cN
	 A61LJ15IOYkyTTDd/hcTZNrcIndLgKJoQC1nQRzUR7t4bK6Q3eLdbKakpMX0EjXll5
	 va8pz8LDQmpt10KjudDGpKj4bVdc2j/+/9Js9RsH8TeO9OdXy0sEsRPIbMEbfOAWB9
	 VX9/BZqxXu2rS1k3fitd821mytXBQyW2rjwQpKf20EMS+mEPYuMGdClLFx9Wu7OgGI
	 J95rFWZsJuSukLCBxB8+WsIHQuPbzF8yQIJlZKNh8Ku9BfQkAKVp8qzWD+/avl/yn8
	 wYLTKOKFZYwdA==
Message-ID: <b8bac0eb-17cc-4e0d-b7f0-a8e7e0da0d67@kernel.org>
Date: Mon, 30 Mar 2026 16:30:15 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/3] mm/page_alloc: Optimize free_contig_range()
Content-Language: en-US
To: Muhammad Usama Anjum <usama.anjum@arm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>, Mike Rapoport
 <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, Brendan Jackman <jackmanb@google.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>,
 Uladzislau Rezki <urezki@gmail.com>, Nick Terrell <terrelln@fb.com>,
 David Sterba <dsterba@suse.com>, Vishal Moola <vishal.moola@gmail.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 Ryan.Roberts@arm.com, david.hildenbrand@arm.com
References: <20260327125720.2270651-1-usama.anjum@arm.com>
 <20260327125720.2270651-2-usama.anjum@arm.com>
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
In-Reply-To: <20260327125720.2270651-2-usama.anjum@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/27/26 13:57, Muhammad Usama Anjum wrote:
> From: Ryan Roberts <ryan.roberts@arm.com>
> 
> Decompose the range of order-0 pages to be freed into the set of largest
> possible power-of-2 size and aligned chunks and free them to the pcp or
> buddy. This improves on the previous approach which freed each order-0
> page individually in a loop. Testing shows performance to be improved by
> more than 10x in some cases.
> 
> Since each page is order-0, we must decrement each page's reference
> count individually and only consider the page for freeing as part of a
> high order chunk if the reference count goes to zero. Additionally
> free_pages_prepare() must be called for each individual order-0 page
> too, so that the struct page state and global accounting state can be
> appropriately managed. But once this is done, the resulting high order
> chunks can be freed as a unit to the pcp or buddy.
> 
> This significantly speeds up the free operation but also has the side
> benefit that high order blocks are added to the pcp instead of each page
> ending up on the pcp order-0 list; memory remains more readily available
> in high orders.
> 
> vmalloc will shortly become a user of this new optimized
> free_contig_range() since it aggressively allocates high order
> non-compound pages, but then calls split_page() to end up with
> contiguous order-0 pages. These can now be freed much more efficiently.
> 
> The execution time of the following function was measured in a server
> class arm64 machine:
> 
> static int page_alloc_high_order_test(void)
> {
> 	unsigned int order = HPAGE_PMD_ORDER;
> 	struct page *page;
> 	int i;
> 
> 	for (i = 0; i < 100000; i++) {
> 		page = alloc_pages(GFP_KERNEL, order);
> 		if (!page)
> 			return -1;
> 		split_page(page, order);
> 		free_contig_range(page_to_pfn(page), 1UL << order);
> 	}
> 
> 	return 0;
> }
> 
> Execution time before: 4097358 usec
> Execution time after:   729831 usec
> 
> Perf trace before:
> 
>     99.63%     0.00%  kthreadd         [kernel.kallsyms]      [.] kthread
>             |
>             ---kthread
>                0xffffb33c12a26af8
>                |
>                |--98.13%--0xffffb33c12a26060
>                |          |
>                |          |--97.37%--free_contig_range
>                |          |          |
>                |          |          |--94.93%--___free_pages
>                |          |          |          |
>                |          |          |          |--55.42%--__free_frozen_pages
>                |          |          |          |          |
>                |          |          |          |           --43.20%--free_frozen_page_commit
>                |          |          |          |                     |
>                |          |          |          |                      --35.37%--_raw_spin_unlock_irqrestore
>                |          |          |          |
>                |          |          |          |--11.53%--_raw_spin_trylock
>                |          |          |          |
>                |          |          |          |--8.19%--__preempt_count_dec_and_test
>                |          |          |          |
>                |          |          |          |--5.64%--_raw_spin_unlock
>                |          |          |          |
>                |          |          |          |--2.37%--__get_pfnblock_flags_mask.isra.0
>                |          |          |          |
>                |          |          |           --1.07%--free_frozen_page_commit
>                |          |          |
>                |          |           --1.54%--__free_frozen_pages
>                |          |
>                |           --0.77%--___free_pages
>                |
>                 --0.98%--0xffffb33c12a26078
>                           alloc_pages_noprof
> 
> Perf trace after:
> 
>      8.42%     2.90%  kthreadd         [kernel.kallsyms]         [k] __free_contig_range
>             |
>             |--5.52%--__free_contig_range
>             |          |
>             |          |--5.00%--free_prepared_contig_range
>             |          |          |
>             |          |          |--1.43%--__free_frozen_pages
>             |          |          |          |
>             |          |          |           --0.51%--free_frozen_page_commit
>             |          |          |
>             |          |          |--1.08%--_raw_spin_trylock
>             |          |          |
>             |          |           --0.89%--_raw_spin_unlock
>             |          |
>             |           --0.52%--free_pages_prepare
>             |
>              --2.90%--ret_from_fork
>                        kthread
>                        0xffffae1c12abeaf8
>                        0xffffae1c12abe7a0
>                        |
>                         --2.69%--vfree
>                                   __free_contig_range
> 
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> Co-developed-by: Muhammad Usama Anjum <usama.anjum@arm.com>
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@arm.com>
> ---
> Changes since v3:
> - Move __free_contig_range() to more generic __free_contig_range_common()
>   which will used to free frozen pages as well
> - Simplify the loop in __free_contig_range_common()
> - Rewrite the comment
> 
> Changes since v2:
> - Handle different possible section boundries in __free_contig_range()
> - Drop the TODO
> - Remove return value from __free_contig_range()
> - Remove non-functional change from __free_pages_ok()
> 
> Changes since v1:
> - Rebase on mm-new
> - Move FPI_PREPARED check inside __free_pages_prepare() now that
>   fpi_flags are already being passed.
> - Add todo (Zi Yan)
> - Rerun benchmarks
> - Convert VM_BUG_ON_PAGE() to VM_WARN_ON_ONCE()
> - Rework order calculation in free_prepared_contig_range() and use
>   MAX_PAGE_ORDER as high limit instead of pageblock_order as it must
>   be up to internal __free_frozen_pages() how it frees them
> ---
>  include/linux/gfp.h |   2 +
>  mm/page_alloc.c     | 103 +++++++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 103 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/gfp.h b/include/linux/gfp.h
> index f82d74a77cad8..7c1f9da7c8e56 100644
> --- a/include/linux/gfp.h
> +++ b/include/linux/gfp.h
> @@ -467,6 +467,8 @@ void free_contig_frozen_range(unsigned long pfn, unsigned long nr_pages);
>  void free_contig_range(unsigned long pfn, unsigned long nr_pages);
>  #endif
>  
> +void __free_contig_range(unsigned long pfn, unsigned long nr_pages);
> +
>  DEFINE_FREE(free_page, void *, free_page((unsigned long)_T))
>  
>  #endif /* __LINUX_GFP_H */
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 75ee81445640b..18a96b51aa0be 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -91,6 +91,9 @@ typedef int __bitwise fpi_t;
>  /* Free the page without taking locks. Rely on trylock only. */
>  #define FPI_TRYLOCK		((__force fpi_t)BIT(2))
>  
> +/* free_pages_prepare() has already been called for page(s) being freed. */
> +#define FPI_PREPARED		((__force fpi_t)BIT(3))
> +
>  /* prevent >1 _updater_ of zone percpu pageset ->high and ->batch fields */
>  static DEFINE_MUTEX(pcp_batch_high_lock);
>  #define MIN_PERCPU_PAGELIST_HIGH_FRACTION (8)
> @@ -1310,6 +1313,9 @@ __always_inline bool __free_pages_prepare(struct page *page,

Hm I noticed the function isn't static, but it should be, and this is a good
oportunity to make it so.

>  	bool compound = PageCompound(page);
>  	struct folio *folio = page_folio(page);
>  
> +	if (fpi_flags & FPI_PREPARED)
> +		return true;
> +
>  	VM_BUG_ON_PAGE(PageTail(page), page);
>  
>  	trace_mm_page_free(page, order);

...

> +/**
> + * __free_contig_range - Free contiguous range of order-0 pages.
> + * @pfn: Page frame number of the first page in the range.
> + * @nr_pages: Number of pages to free.
> + *
> + * For each order-0 struct page in the physically contiguous range, put a
> + * reference. Free any page who's reference count falls to zero. The
> + * implementation is functionally equivalent to, but significantly faster than
> + * calling __free_page() for each struct page in a loop.
> + *
> + * Memory allocated with alloc_pages(order>=1) then subsequently split to
> + * order-0 with split_page() is an example of appropriate contiguous pages that
> + * can be freed with this API.
> + *
> + * Context: May be called in interrupt context or while holding a normal
> + * spinlock, but not in NMI context or while holding a raw spinlock.
> + */
> +void __free_contig_range(unsigned long pfn, unsigned long nr_pages)
> +{
> +	__free_contig_range_common(pfn, nr_pages, false);
> +}
> +EXPORT_SYMBOL(__free_contig_range);

I don't think the export is necessary for anything? Please drop.

> +
>  #ifdef CONFIG_CONTIG_ALLOC
>  /* Usage: See admin-guide/dynamic-debug-howto.rst */
>  static void alloc_contig_dump_pages(struct list_head *page_list)
> @@ -7330,8 +7430,7 @@ void free_contig_range(unsigned long pfn, unsigned long nr_pages)
>  	if (WARN_ON_ONCE(PageHead(pfn_to_page(pfn))))
>  		return;
>  
> -	for (; nr_pages--; pfn++)
> -		__free_page(pfn_to_page(pfn));
> +	__free_contig_range(pfn, nr_pages);
>  }
>  EXPORT_SYMBOL(free_contig_range);
>  #endif /* CONFIG_CONTIG_ALLOC */

