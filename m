Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB45B3CF68A;
	Wed,  1 Apr 2026 09:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775035176; cv=none; b=oGH8RU9kWfdPoav+K7bTwwkuyu+u5l3XxkupjS+M4hNMumBfvJN1l+W1Og7QftkI3GtJiwcIcAz0bFdWzV8K4O2RSCEOM6xvSxqNqv2bPE2jsaj5QulUEbxRGxqJ/9LrS9/YjljZ4BMqJP9TPFMfSZtsG3+it6w2tKu9HLwPc9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775035176; c=relaxed/simple;
	bh=jUjFCCnbzFPHXcrJnArw9JouUlj+FBuCgch0ngZXMTw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=hJTsHzHOmJn8ntqRDpKZVq+qhhkuhZbRasMBMuPWMTM9Rvww74S2TMYAY+c8KoVsh1FqHEZopWxm6jmQD+yt3fULN5Oux89JrDkO4ipaglx9OrXTuhE097AuoYhAMrHNzkpfjV3PJnfodD3R1auYzSrzVcz6n7APIzZoS8pwVEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jp3XqGg/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jp3XqGg/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3FB2C4CEF7;
	Wed,  1 Apr 2026 09:19:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775035175;
	bh=jUjFCCnbzFPHXcrJnArw9JouUlj+FBuCgch0ngZXMTw=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=Jp3XqGg/uKhu2Pqn6P4Nf7cKFakXRJ1HlZxnet10zStjNd7ZZPhgmZCmpdCnRMnsF
	 zcrke9g3oIIV4+Jto4uhKj1rZ/geQMUFm4dWw1deZ1RwmvGnNmnzhR3KMrNtPdytnt
	 HijuMCb6e0TVopn0OmE2xnqCl+RFgg6Y/spg/GTf/sVJeY3rZ+ERuDCieEQiMNqwAB
	 SpyczBXcMcoD8iCXJe6vVB0sjqwyUzYHSaYzS9WcTvA2WtlRsot4gX9iZ6JJT8FrpJ
	 oVGxNIljsZKpb9lJ0QZxSJ8lFAYlYRo6dmVnXoMlOy2aksvdWEqs1TKkSdw+Xl8vCh
	 BU0ZQJMiNO/NA==
Message-ID: <c52c0500-b255-41ee-a2fd-1caaba5499df@kernel.org>
Date: Wed, 1 Apr 2026 11:19:29 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/3] vmalloc: Optimize vfree
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
References: <20260331152208.975266-1-usama.anjum@arm.com>
 <20260331152208.975266-3-usama.anjum@arm.com>
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
In-Reply-To: <20260331152208.975266-3-usama.anjum@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


Nit: the subject could be more specific, e.g. like this?

vmalloc: Optimize vfree with free_pages_bulk()

On 3/31/26 17:22, Muhammad Usama Anjum wrote:
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

Acked-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>

> +void free_pages_bulk(struct page **page_array, unsigned long nr_pages)
> +{
> +	while (nr_pages) {
> +		unsigned long nr_contig = num_pages_contiguous(page_array, nr_pages);
> +
> +		__free_contig_range(page_to_pfn(*page_array), nr_contig);

I'll note that num_pages_contiguous() already handled crossing the section
boundaries and __free_contig_range() checks them again. But that's fine I
think, we don't have to optimize for !SPARSEMEM_VMEMMAP architectures and on
SPARSEMEM_VMEMMAP the checks should be compiled out, right.
It would complicate the API otherwise.

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
