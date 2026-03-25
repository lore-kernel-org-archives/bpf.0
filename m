Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83ACC7263B
	for <bpf@vger.kernel.org>; Wed, 25 Mar 2026 16:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774455403; cv=none; b=GC6ttezJMUtdSRQTTGbNCJWs6C6VeyMq3sJQpl9t76OvKVkMrvQPdd/yqPekdbnE0ODvhEvU6VNdEL5B0k5rr2Pzsbr/hkclERM0DX+1KyRb8Rvr++ETpXH1sEQsv7E0LZi+03kJsLYrrQmMPqzjaB10UeGiBggHwR7zwOhcvus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774455403; c=relaxed/simple;
	bh=j8L0lyWmHtYhrW0adChWFa9O0SJfBs7VWEXraH8Z3K8=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nzjnv3CLyv5akKZCJtwn8aNTBZUIYelyA+Vp+ZnvvdCBcof0twZEG//yBPCtA1pHNEzQdUNaWysfQ4qxQHGVaW1chjzanX65HDADL5yL6kGb7sMZz6jkNqst0KrXIrbDRuCtUecyVlOQWxK6pMA3Y4uXCaBUyvgXVHdiDB99uDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OHZiBJ0B; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OHZiBJ0B"
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5a13a06fc85so120328e87.1
        for <bpf@vger.kernel.org>; Wed, 25 Mar 2026 09:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774455400; x=1775060200; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mQNkW1E4iLDlDxzhZtGOPx0+whhP6nU11icM6Ww2f1o=;
        b=OHZiBJ0BKVinHawbp5KVCWz4pONosfxdPTjPNdbDtrq3lxry87TNsfTwbyn746clae
         s821WINOXO3VtGDN6qIn9dURTxVHBJiQmX1rKQIQOsX/yHyEb0GSsi+5WyQdWWv6XiCh
         A33I/D55YBIqGhaza/LWALHGjiETYKN8R9LAZvC0uEHu9PsNGOZArAm4qFCVVQyBPUOo
         gqjKJMzFDMcSYYu88Ei5dj3qSKtqdkuTQTtTK57d0nmJTuibK+rtLlFWEdh8IMZHldrp
         +qNSBJMaXAeORyYi4dlncauAmqQ7RRt3/rtpYO/p6nyQo4OSfvn9DMLbD8DQgWAFvAP6
         Q+kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774455400; x=1775060200;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mQNkW1E4iLDlDxzhZtGOPx0+whhP6nU11icM6Ww2f1o=;
        b=r8MmLW01bYSrZEXxD6dPK8JSrp/qLULL5quPOm6q+8KoqFTlNFLNsfJdy6rqb2EpAq
         IW8V0zQ5UTwO+ccDBekTFF641lKsLlGBRf1g9DxhvE3LtJOBmC/HLtUrIFMLyhdjLENF
         tQd+hPli/9T/MiTZDzyjCIGqQM0sBhncXH4rLKDdEzPrs2aZW1F+iVatt4w1Otzl0KMK
         HQGSbHpTanqp8BYwG0TpzdtKrc3LTRxi2jXkul/s454yeRGYiy+Z0sleAyuCMX4/9dK7
         xm2nENoU1pziEZdbuQU6UizfHdqtXHJVOxfzdeDIKHs/ZufNO/5X+dDid4dt3tBjf7BX
         ShoQ==
X-Forwarded-Encrypted: i=1; AJvYcCVqW8Fm9QHKKCClHqpiHNH7f1cgs3MrDQRpbPuqhw2VMPBv55TGp5k8XdvkibL+J2MkvOo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzrvpMZ/QRr5n6YOom3MYwGzdcSWs1m7W0et342vP27X+7kJO5
	qqZq+W+2SbV/I+Wlsh/g+7I6VjczoOH6HGy9niteVqr4EbB1X3Ymbhba
X-Gm-Gg: ATEYQzyHEChqbstfFn/GatCydwnPLEjNiurXpwlo2EM9+2Z/GNx/KzPckc7lHv/8edQ
	3Em2hQN+A4yWmi7H5qGWqkXZzr06c/MvhYIUZGJRL/blLKweamuJrgnkHjsXPMS9ruk/mHGEuHs
	XiFNmqjVGAOJdnsoAyVi9nXN0wT6MbxLg7NozgUSKuO3/ejwYPrsjX8QwSisx0YzFv57S/ieBL5
	tqMzFHUSKcwwXj354JQp6cmJi7ojp8XxDsaaG11/rfb0O8IKzjuAYY8vGTAKu4dl6KJWbI2zYLk
	s6ojjbsLDbRJ7pVnhrp7biTxu3/vxAJR/TbneVb6o3yrJp158EY1nee4bmLYHBqqJsXS7t/qkdm
	IOtJTQ8GbpzJLL58yhNzNhl5Zck5jFquts3eXo+JC0TBqUezl4ezgHOWFCkrPjm/m
X-Received: by 2002:a05:6512:33c6:b0:5a2:7ba1:4932 with SMTP id 2adb3069b0e04-5a29b99ef6fmr1703865e87.42.1774455399259;
        Wed, 25 Mar 2026 09:16:39 -0700 (PDT)
Received: from milan ([2001:9b1:d5a0:a500::24b])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a2a064d35esm4117e87.34.2026.03.25.09.16.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 09:16:38 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@milan>
Date: Wed, 25 Mar 2026 17:16:36 +0100
To: Muhammad Usama Anjum <usama.anjum@arm.com>
Cc: Uladzislau Rezki <urezki@gmail.com>, Zi Yan <ziy@nvidia.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Brendan Jackman <jackmanb@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Nick Terrell <terrelln@fb.com>, David Sterba <dsterba@suse.com>,
	Vishal Moola <vishal.moola@gmail.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	Ryan.Roberts@arm.com, david.hildenbrand@arm.com
Subject: Re: [PATCH v3 2/3] vmalloc: Optimize vfree
Message-ID: <acQKZBqTjpm6-k2f@milan>
References: <20260324133538.497616-1-usama.anjum@arm.com>
 <20260324133538.497616-3-usama.anjum@arm.com>
 <1D88CFF0-8A74-413F-9A6A-39E27B760AE1@nvidia.com>
 <acOjIcqyIVY9KNn0@milan>
 <a79ff8ba-ed4a-43d0-9c4b-d2883a5c48e8@arm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a79ff8ba-ed4a-43d0-9c4b-d2883a5c48e8@arm.com>

On Wed, Mar 25, 2026 at 03:02:14PM +0000, Muhammad Usama Anjum wrote:
> On 25/03/2026 8:56 am, Uladzislau Rezki wrote:
> > On Tue, Mar 24, 2026 at 10:55:55AM -0400, Zi Yan wrote:
> >> On 24 Mar 2026, at 9:35, Muhammad Usama Anjum wrote:
> >>
> >>> From: Ryan Roberts <ryan.roberts@arm.com>
> >>>
> >>> Whenever vmalloc allocates high order pages (e.g. for a huge mapping) it
> >>> must immediately split_page() to order-0 so that it remains compatible
> >>> with users that want to access the underlying struct page.
> >>> Commit a06157804399 ("mm/vmalloc: request large order pages from buddy
> >>> allocator") recently made it much more likely for vmalloc to allocate
> >>> high order pages which are subsequently split to order-0.
> >>>
> >>> Unfortunately this had the side effect of causing performance
> >>> regressions for tight vmalloc/vfree loops (e.g. test_vmalloc.ko
> >>> benchmarks). See Closes: tag. This happens because the high order pages
> >>> must be gotten from the buddy but then because they are split to
> >>> order-0, when they are freed they are freed to the order-0 pcp.
> >>> Previously allocation was for order-0 pages so they were recycled from
> >>> the pcp.
> >>>
> >>> It would be preferable if when vmalloc allocates an (e.g.) order-3 page
> >>> that it also frees that order-3 page to the order-3 pcp, then the
> >>> regression could be removed.
> >>>
> >>> So let's do exactly that; use the new __free_contig_range() API to
> >>> batch-free contiguous ranges of pfns. This not only removes the
> >>> regression, but significantly improves performance of vfree beyond the
> >>> baseline.
> >>>
> >>> A selection of test_vmalloc benchmarks running on arm64 server class
> >>> system. mm-new is the baseline. Commit a06157804399 ("mm/vmalloc: request
> >>> large order pages from buddy allocator") was added in v6.19-rc1 where we
> >>> see regressions. Then with this change performance is much better. (>0
> >>> is faster, <0 is slower, (R)/(I) = statistically significant
> >>> Regression/Improvement):
> >>>
> >>> +-----------------+----------------------------------------------------------+-------------------+--------------------+
> >>> | Benchmark       | Result Class                                             |   mm-new          |  this series       |
> >>> +=================+==========================================================+===================+====================+
> >>> | micromm/vmalloc | fix_align_alloc_test: p:1, h:0, l:500000 (usec)          |        1331843.33 |         (I) 67.17% |
> >>> |                 | fix_size_alloc_test: p:1, h:0, l:500000 (usec)           |         415907.33 |             -5.14% |
> >>> |                 | fix_size_alloc_test: p:4, h:0, l:500000 (usec)           |         755448.00 |         (I) 53.55% |
> >>> |                 | fix_size_alloc_test: p:16, h:0, l:500000 (usec)          |        1591331.33 |         (I) 57.26% |
> >>> |                 | fix_size_alloc_test: p:16, h:1, l:500000 (usec)          |        1594345.67 |         (I) 68.46% |
> >>> |                 | fix_size_alloc_test: p:64, h:0, l:100000 (usec)          |        1071826.00 |         (I) 79.27% |
> >>> |                 | fix_size_alloc_test: p:64, h:1, l:100000 (usec)          |        1018385.00 |         (I) 84.17% |
> >>> |                 | fix_size_alloc_test: p:256, h:0, l:100000 (usec)         |        3970899.67 |         (I) 77.01% |
> >>> |                 | fix_size_alloc_test: p:256, h:1, l:100000 (usec)         |        3821788.67 |         (I) 89.44% |
> >>> |                 | fix_size_alloc_test: p:512, h:0, l:100000 (usec)         |        7795968.00 |         (I) 82.67% |
> >>> |                 | fix_size_alloc_test: p:512, h:1, l:100000 (usec)         |        6530169.67 |        (I) 118.09% |
> >>> |                 | full_fit_alloc_test: p:1, h:0, l:500000 (usec)           |         626808.33 |             -0.98% |
> >>> |                 | kvfree_rcu_1_arg_vmalloc_test: p:1, h:0, l:500000 (usec) |         532145.67 |             -1.68% |
> >>> |                 | kvfree_rcu_2_arg_vmalloc_test: p:1, h:0, l:500000 (usec) |         537032.67 |             -0.96% |
> >>> |                 | long_busy_list_alloc_test: p:1, h:0, l:500000 (usec)     |        8805069.00 |         (I) 74.58% |
> >>> |                 | pcpu_alloc_test: p:1, h:0, l:500000 (usec)               |         500824.67 |              4.35% |
> >>> |                 | random_size_align_alloc_test: p:1, h:0, l:500000 (usec)  |        1637554.67 |         (I) 76.99% |
> >>> |                 | random_size_alloc_test: p:1, h:0, l:500000 (usec)        |        4556288.67 |         (I) 72.23% |
> >>> |                 | vm_map_ram_test: p:1, h:0, l:500000 (usec)               |         107371.00 |             -0.70% |
> >>> +-----------------+----------------------------------------------------------+-------------------+--------------------+
> >>>
> >>> Fixes: a06157804399 ("mm/vmalloc: request large order pages from buddy allocator")
> >>> Closes: https://lore.kernel.org/all/66919a28-bc81-49c9-b68f-dd7c73395a0d@arm.com/
> >>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> >>> Co-developed-by: Muhammad Usama Anjum <usama.anjum@arm.com>
> >>> Signed-off-by: Muhammad Usama Anjum <usama.anjum@arm.com>
> >>> ---
> >>> Changes since v2:
> >>> - Remove BUG_ON in favour of simple implementation as this has never
> >>>   been seen to output any bug in the past as well
> >>> - Move the free loop to separate function, free_pages_bulk()
> >>> - Update stats, lruvec_stat in separate loop
> >>>
> >>> Changes since v1:
> >>> - Rebase on mm-new
> >>> - Rerun benchmarks
> >>>
> >>> Made-with: Cursor
> >>> ---
> >>>  include/linux/gfp.h |  2 ++
> >>>  mm/page_alloc.c     | 23 +++++++++++++++++++++++
> >>>  mm/vmalloc.c        | 16 +++++-----------
> >>>  3 files changed, 30 insertions(+), 11 deletions(-)
> >>>
> >>> diff --git a/include/linux/gfp.h b/include/linux/gfp.h
> >>> index 7c1f9da7c8e56..71f9097ab99a0 100644
> >>> --- a/include/linux/gfp.h
> >>> +++ b/include/linux/gfp.h
> >>> @@ -239,6 +239,8 @@ unsigned long alloc_pages_bulk_noprof(gfp_t gfp, int preferred_nid,
> >>>  				struct page **page_array);
> >>>  #define __alloc_pages_bulk(...)			alloc_hooks(alloc_pages_bulk_noprof(__VA_ARGS__))
> >>>
> >>> +void free_pages_bulk(struct page **page_array, unsigned long nr_pages);
> >>> +
> >>>  unsigned long alloc_pages_bulk_mempolicy_noprof(gfp_t gfp,
> >>>  				unsigned long nr_pages,
> >>>  				struct page **page_array);
> >>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> >>> index eedce9a30eb7e..250cc07e547b8 100644
> >>> --- a/mm/page_alloc.c
> >>> +++ b/mm/page_alloc.c
> >>> @@ -5175,6 +5175,29 @@ unsigned long alloc_pages_bulk_noprof(gfp_t gfp, int preferred_nid,
> >>>  }
> >>>  EXPORT_SYMBOL_GPL(alloc_pages_bulk_noprof);
> >>>
> >>> +void free_pages_bulk(struct page **page_array, unsigned long nr_pages)
> >>> +{
> >>> +	unsigned long start_pfn = 0, pfn;
> >>> +	unsigned long i, nr_contig = 0;
> >>> +
> >>> +	for (i = 0; i < nr_pages; i++) {
> >>> +		pfn = page_to_pfn(page_array[i]);
> >>> +		if (!nr_contig) {
> >>> +			start_pfn = pfn;
> >>> +			nr_contig = 1;
> >>> +		} else if (start_pfn + nr_contig != pfn) {
> >>> +			__free_contig_range(start_pfn, nr_contig);
> >>> +			start_pfn = pfn;
> >>> +			nr_contig = 1;
> >>> +			cond_resched();
> >>
> > It will cause schedule while atomic. Have you checked that
> > __free_contig_range() also can sleep? Of so then we are aligned, if not
> > probably we should remove it.
> Sorry, I didn't get it. How does having cond_resched() in this function
> affects __free_contig_range()?
> 
It is not. What i am asking is about:

<snip>
spin_lock();
free_pages_bulk()
...
<snip>

so this is not allowed because there is cond_resched() call. We
can remove it and make it possible to invoke free_pages_bulk() under
spin-lock, __but__ only if for example other calls do not sleep:

__free_contig_range()
memdesc_section()
free_prepared_contig_range()
...

>
> The current user of this function is only vfree() which is sleepable.
> 
I know. But this function can be used by others soon or later.

Another option is add a comment, saying that it is only for sleepable
contexts.

--
Uladzislau Rezki
