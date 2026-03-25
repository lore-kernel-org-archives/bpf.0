Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B2F139A04B
	for <bpf@vger.kernel.org>; Wed, 25 Mar 2026 08:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774428968; cv=none; b=GWvasx42JWUbojbuv4ChBwmeCP/Bo+Wu5PrRw3WMj/CBm+CgQVlXIb3GMeG/oGcUdRyYoZ165AM5QwYNkGNRyLQpKWbfKKIRG4QYGCGgpxa87scOxBRR+KdDNN9f9mmcUbzSjEQAI6UU+8AALmzaN8I30GR1aTZnBmTfbBf3KIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774428968; c=relaxed/simple;
	bh=bDEeZBZOAWwz1EVJgLMs5u70hrEdSx3ygSTWVHKvYJM=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L4wKumwBBd7CpKulPPvDrBmn1GuegSDglnWQ7kSwtcZkii+fg4utdG+T/DERahVKdJVQ8mm8/C7L7Fi8S/vcZqZ0Y9L4GKPeEjme70GDtBHJoB8PqZ+vD9p9GgwR9D9zPZBptLTvACztv9kfLt+NbtklS1NLD6Xjvc+nGtV1W5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=La9Dpobr; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="La9Dpobr"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5a27daa652fso6393657e87.0
        for <bpf@vger.kernel.org>; Wed, 25 Mar 2026 01:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774428964; x=1775033764; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PP9ZaWjF4kkscfMWl4N5NvAvTpHMI/CLS4RpQGDbPQE=;
        b=La9DpobrlEi7yJKEifwu9shvOIfMoZUb+La8G+BYN6n2X6DYWWaVZfeAkgkHU+Yo1t
         x1/vPLr0kX1BlXaopgCixVGVWmATBn3laqLlkTXoaCt3EzYIoEXFbBfNnGp7/hUjzcjt
         yEvZjAU+oXEDZ2LlCr/t1jprdfmOdBcHbpdFoHIsv9UjqoWc7x73zly4LHsOFx0r+uqi
         pFc2jXeXFr6ZKfmUCJT+ILZojbKPfSzJpuuOSgHcGzktTLGSCRrlxp1fkSahszDFwXi+
         ALOowkNQ/Jtb6DYk7YjQZmt9PwR9JyK+oUdpJFz2YcwNrCe/k0wQUR4T9Fq2DQUw8YsK
         ePxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774428964; x=1775033764;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PP9ZaWjF4kkscfMWl4N5NvAvTpHMI/CLS4RpQGDbPQE=;
        b=OUvbXAvS/O/Mj1gNyMGBtskdmiaoF4cke59CDvs9hYUkdV7eGV76Jkg2aa21ndAjRJ
         +f+DTUNaNGshN9bLVJ9oGJa2AWavLLurymG4Ac3T50gI2H9Iqp2ftfOehPr6EAP/CENd
         qouyfC846f1el3cCHdn/lcUhptpVL3jJw4N5eoJ57TWjBXYtFSnWbu001lG5W64mXlwT
         Ng+21vIoVK/8M4ZlRyNECNwvBKZ6wDotD6SJpNwv4VkIMXaMG9UgSykOgmDc4bInymzY
         Q3r7C8FOd1x8M/BwD3QAVrXiBwwSEFljeCDatG4azkubFGEVIE6i8MBcRMh+g7RT7uoN
         bQ8w==
X-Forwarded-Encrypted: i=1; AJvYcCXE7k17mZLejkxIr3HKhXGguURSv6uRpjDiXsWhWqfFo4YSnNYo0J9/UTDuKVoALjOCtog=@vger.kernel.org
X-Gm-Message-State: AOJu0YygHn+EuUsEaOSV83z93TO+GIOuFt2kiP+o5TfMT81KhYkThdtl
	sJ2ZC2XOdaJHcC3gFo7ZbRMB922DfWCT8hJVFmlpWDNe1heIwrWsp0q8
X-Gm-Gg: ATEYQzxKDofaT9lFXD2MTmqA8/QEyWmIDRJ+Z64HZxDUWFkVEOCa65djWHhYiJok7W9
	Qv9bosY5sm5NtojuigmQMEKeZgMYbyGmzMsDUGMgrCHP/u43M2C5THtq7Y0oxQEqHchzQjy4SHH
	K4KCPjNT0ffC4Xe9SATZ/aLFSGE3iXdfKOl/BYQwFZAuLVXSjNaTtViDXRwj1ig2Qn3EtYO6Jyb
	WBzmrrtt3U49vbYiHku8xywL5D0/ZcJwBlIZAAmnl/YbyK0jdDzfgDayO8FKFtrRQYaxDcfYSdS
	2fXLBee367L56tV4iAobtVSntJd06WZh9KTWl8kOP1Gn7TbVxQsCZj0g/PMnKKtAda5DbcUJdC7
	CtwBSjkl4+IejAJvUDyLpN83tJjMEwNB7JToZ6i/gxPjamy9wkjR9g+T7tuyGZQwL
X-Received: by 2002:a05:6512:6181:b0:5a2:7b43:62da with SMTP id 2adb3069b0e04-5a29b992dabmr963125e87.30.1774428963937;
        Wed, 25 Mar 2026 01:56:03 -0700 (PDT)
Received: from milan ([2001:9b1:d5a0:a500::24b])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a285192b44sm3673978e87.5.2026.03.25.01.56.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 01:56:03 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@milan>
Date: Wed, 25 Mar 2026 09:56:01 +0100
To: Zi Yan <ziy@nvidia.com>
Cc: Muhammad Usama Anjum <usama.anjum@arm.com>,
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
	Uladzislau Rezki <urezki@gmail.com>, Nick Terrell <terrelln@fb.com>,
	David Sterba <dsterba@suse.com>,
	Vishal Moola <vishal.moola@gmail.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	Ryan.Roberts@arm.com, david.hildenbrand@arm.com
Subject: Re: [PATCH v3 2/3] vmalloc: Optimize vfree
Message-ID: <acOjIcqyIVY9KNn0@milan>
References: <20260324133538.497616-1-usama.anjum@arm.com>
 <20260324133538.497616-3-usama.anjum@arm.com>
 <1D88CFF0-8A74-413F-9A6A-39E27B760AE1@nvidia.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1D88CFF0-8A74-413F-9A6A-39E27B760AE1@nvidia.com>

On Tue, Mar 24, 2026 at 10:55:55AM -0400, Zi Yan wrote:
> On 24 Mar 2026, at 9:35, Muhammad Usama Anjum wrote:
> 
> > From: Ryan Roberts <ryan.roberts@arm.com>
> >
> > Whenever vmalloc allocates high order pages (e.g. for a huge mapping) it
> > must immediately split_page() to order-0 so that it remains compatible
> > with users that want to access the underlying struct page.
> > Commit a06157804399 ("mm/vmalloc: request large order pages from buddy
> > allocator") recently made it much more likely for vmalloc to allocate
> > high order pages which are subsequently split to order-0.
> >
> > Unfortunately this had the side effect of causing performance
> > regressions for tight vmalloc/vfree loops (e.g. test_vmalloc.ko
> > benchmarks). See Closes: tag. This happens because the high order pages
> > must be gotten from the buddy but then because they are split to
> > order-0, when they are freed they are freed to the order-0 pcp.
> > Previously allocation was for order-0 pages so they were recycled from
> > the pcp.
> >
> > It would be preferable if when vmalloc allocates an (e.g.) order-3 page
> > that it also frees that order-3 page to the order-3 pcp, then the
> > regression could be removed.
> >
> > So let's do exactly that; use the new __free_contig_range() API to
> > batch-free contiguous ranges of pfns. This not only removes the
> > regression, but significantly improves performance of vfree beyond the
> > baseline.
> >
> > A selection of test_vmalloc benchmarks running on arm64 server class
> > system. mm-new is the baseline. Commit a06157804399 ("mm/vmalloc: request
> > large order pages from buddy allocator") was added in v6.19-rc1 where we
> > see regressions. Then with this change performance is much better. (>0
> > is faster, <0 is slower, (R)/(I) = statistically significant
> > Regression/Improvement):
> >
> > +-----------------+----------------------------------------------------------+-------------------+--------------------+
> > | Benchmark       | Result Class                                             |   mm-new          |  this series       |
> > +=================+==========================================================+===================+====================+
> > | micromm/vmalloc | fix_align_alloc_test: p:1, h:0, l:500000 (usec)          |        1331843.33 |         (I) 67.17% |
> > |                 | fix_size_alloc_test: p:1, h:0, l:500000 (usec)           |         415907.33 |             -5.14% |
> > |                 | fix_size_alloc_test: p:4, h:0, l:500000 (usec)           |         755448.00 |         (I) 53.55% |
> > |                 | fix_size_alloc_test: p:16, h:0, l:500000 (usec)          |        1591331.33 |         (I) 57.26% |
> > |                 | fix_size_alloc_test: p:16, h:1, l:500000 (usec)          |        1594345.67 |         (I) 68.46% |
> > |                 | fix_size_alloc_test: p:64, h:0, l:100000 (usec)          |        1071826.00 |         (I) 79.27% |
> > |                 | fix_size_alloc_test: p:64, h:1, l:100000 (usec)          |        1018385.00 |         (I) 84.17% |
> > |                 | fix_size_alloc_test: p:256, h:0, l:100000 (usec)         |        3970899.67 |         (I) 77.01% |
> > |                 | fix_size_alloc_test: p:256, h:1, l:100000 (usec)         |        3821788.67 |         (I) 89.44% |
> > |                 | fix_size_alloc_test: p:512, h:0, l:100000 (usec)         |        7795968.00 |         (I) 82.67% |
> > |                 | fix_size_alloc_test: p:512, h:1, l:100000 (usec)         |        6530169.67 |        (I) 118.09% |
> > |                 | full_fit_alloc_test: p:1, h:0, l:500000 (usec)           |         626808.33 |             -0.98% |
> > |                 | kvfree_rcu_1_arg_vmalloc_test: p:1, h:0, l:500000 (usec) |         532145.67 |             -1.68% |
> > |                 | kvfree_rcu_2_arg_vmalloc_test: p:1, h:0, l:500000 (usec) |         537032.67 |             -0.96% |
> > |                 | long_busy_list_alloc_test: p:1, h:0, l:500000 (usec)     |        8805069.00 |         (I) 74.58% |
> > |                 | pcpu_alloc_test: p:1, h:0, l:500000 (usec)               |         500824.67 |              4.35% |
> > |                 | random_size_align_alloc_test: p:1, h:0, l:500000 (usec)  |        1637554.67 |         (I) 76.99% |
> > |                 | random_size_alloc_test: p:1, h:0, l:500000 (usec)        |        4556288.67 |         (I) 72.23% |
> > |                 | vm_map_ram_test: p:1, h:0, l:500000 (usec)               |         107371.00 |             -0.70% |
> > +-----------------+----------------------------------------------------------+-------------------+--------------------+
> >
> > Fixes: a06157804399 ("mm/vmalloc: request large order pages from buddy allocator")
> > Closes: https://lore.kernel.org/all/66919a28-bc81-49c9-b68f-dd7c73395a0d@arm.com/
> > Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> > Co-developed-by: Muhammad Usama Anjum <usama.anjum@arm.com>
> > Signed-off-by: Muhammad Usama Anjum <usama.anjum@arm.com>
> > ---
> > Changes since v2:
> > - Remove BUG_ON in favour of simple implementation as this has never
> >   been seen to output any bug in the past as well
> > - Move the free loop to separate function, free_pages_bulk()
> > - Update stats, lruvec_stat in separate loop
> >
> > Changes since v1:
> > - Rebase on mm-new
> > - Rerun benchmarks
> >
> > Made-with: Cursor
> > ---
> >  include/linux/gfp.h |  2 ++
> >  mm/page_alloc.c     | 23 +++++++++++++++++++++++
> >  mm/vmalloc.c        | 16 +++++-----------
> >  3 files changed, 30 insertions(+), 11 deletions(-)
> >
> > diff --git a/include/linux/gfp.h b/include/linux/gfp.h
> > index 7c1f9da7c8e56..71f9097ab99a0 100644
> > --- a/include/linux/gfp.h
> > +++ b/include/linux/gfp.h
> > @@ -239,6 +239,8 @@ unsigned long alloc_pages_bulk_noprof(gfp_t gfp, int preferred_nid,
> >  				struct page **page_array);
> >  #define __alloc_pages_bulk(...)			alloc_hooks(alloc_pages_bulk_noprof(__VA_ARGS__))
> >
> > +void free_pages_bulk(struct page **page_array, unsigned long nr_pages);
> > +
> >  unsigned long alloc_pages_bulk_mempolicy_noprof(gfp_t gfp,
> >  				unsigned long nr_pages,
> >  				struct page **page_array);
> > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > index eedce9a30eb7e..250cc07e547b8 100644
> > --- a/mm/page_alloc.c
> > +++ b/mm/page_alloc.c
> > @@ -5175,6 +5175,29 @@ unsigned long alloc_pages_bulk_noprof(gfp_t gfp, int preferred_nid,
> >  }
> >  EXPORT_SYMBOL_GPL(alloc_pages_bulk_noprof);
> >
> > +void free_pages_bulk(struct page **page_array, unsigned long nr_pages)
> > +{
> > +	unsigned long start_pfn = 0, pfn;
> > +	unsigned long i, nr_contig = 0;
> > +
> > +	for (i = 0; i < nr_pages; i++) {
> > +		pfn = page_to_pfn(page_array[i]);
> > +		if (!nr_contig) {
> > +			start_pfn = pfn;
> > +			nr_contig = 1;
> > +		} else if (start_pfn + nr_contig != pfn) {
> > +			__free_contig_range(start_pfn, nr_contig);
> > +			start_pfn = pfn;
> > +			nr_contig = 1;
> > +			cond_resched();
>
It will cause schedule while atomic. Have you checked that
__free_contig_range() also can sleep? Of so then we are aligned, if not
probably we should remove it.

--
Uladzislau Rezki
