Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E83C2E717B;
	Mon, 30 Mar 2026 14:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774881401; cv=none; b=gUDHtGVOph8nSLo+QYARXkNWYS1I+3ud2NutCNgoiuBUSuv0VMOiVWpkMMgO9px+7h2O6ef4+G6+/3Br/IqtimWULW16eWaoZqTvFL/q4/lHguUmEnCuqHN+mN973+9l0e88/pITwU97st2sXggv5xV2FYCjib/783+33XRARcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774881401; c=relaxed/simple;
	bh=UUzXjb9asDBbFYQ/P+S6mXqciBQgW6rkek8EtvcnmEA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=i2/U94hx81naL2qIli5ZzxlXnZdg8Ww53/LSYqnH/iQjpqlwMFRwpkULcwiAGy9sFMMAwVoLoTk4rYyCH8FP7wRNElXbWMOHZdyZ6/8eINeK1zsA9BJnrhrCVWhECk5EI3clORYA49YKdk/C0YZL8oaBD92pJ18ZWa5hmignztE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oUjt9ek5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oUjt9ek5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EC07C19423;
	Mon, 30 Mar 2026 14:36:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774881401;
	bh=UUzXjb9asDBbFYQ/P+S6mXqciBQgW6rkek8EtvcnmEA=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=oUjt9ek5UytYIOgdx2VGoInarZWYBW/OInxfrQunSF4g0xgDSRG8tL1vJ1MMYLx09
	 znAh9a8Dg0WHt5KE0ZhCVD9hZ0EVoluGrE9kiHzt+LyqXcxOIE8WHwnwwAI1HDbmfl
	 yHCYmwYJRFTPzbBzS8FelbBewo6uH1RBI5riq+upPasi9sfo6bxDCr87JYIH14yQTh
	 OgAzqm94Ppz79bio8sBysAt1qiAuY1OfwloOGfAUwzQmFnVv/uqQn2l6JZO5ziM/F8
	 L9cJCYqXaPv3H19VygcorNBXydcIE+NCeXaGyMXAAgJF4vxnL5BkEgy4dUTqZhjFgt
	 eUAGSj1iIyiOw==
Message-ID: <d6db5b93-8bcb-4a34-9e44-3ff948e64ce8@kernel.org>
Date: Mon, 30 Mar 2026 16:36:35 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/3] mm/page_alloc: Optimize
 __free_contig_frozen_range()
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
 <20260327125720.2270651-4-usama.anjum@arm.com>
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
In-Reply-To: <20260327125720.2270651-4-usama.anjum@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/27/26 13:57, Muhammad Usama Anjum wrote:
> Apply the same batch-freeing optimization from free_contig_range() to the
> frozen page path. The previous __free_contig_frozen_range() freed each
> order-0 page individually via free_frozen_pages(), which is slow for the
> same reason the old free_contig_range() was: each page goes to the
> order-0 pcp list rather than being coalesced into higher-order blocks.
> 
> Rewrite __free_contig_frozen_range() to call free_pages_prepare() for
> each order-0 page, then batch the prepared pages into the largest
> possible power-of-2 aligned chunks via free_prepared_contig_range().
> If free_pages_prepare() fails (e.g. HWPoison, bad page) the page is
> deliberately not freed; it should not be returned to the allocator.
> 
> I've tested CMA through debugfs. The test allocates 16384 pages per
> allocation for several iterations. There is 3.5x improvement.
> 
> Before: 1406 usec per iteration
> After:   402 usec per iteration
> 
> Before:
> 
>     70.89%     0.69%  cma              [kernel.kallsyms]      [.] free_contig_frozen_range
>             |
>             |--70.20%--free_contig_frozen_range
>             |          |
>             |          |--46.41%--__free_frozen_pages
>             |          |          |
>             |          |           --36.18%--free_frozen_page_commit
>             |          |                     |
>             |          |                      --29.63%--_raw_spin_unlock_irqrestore
>             |          |
>             |          |--8.76%--_raw_spin_trylock
>             |          |
>             |          |--7.03%--__preempt_count_dec_and_test
>             |          |
>             |          |--4.57%--_raw_spin_unlock
>             |          |
>             |          |--1.96%--__get_pfnblock_flags_mask.isra.0
>             |          |
>             |           --1.15%--free_frozen_page_commit
>             |
>              --0.69%--el0t_64_sync
> 
> After:
> 
>     23.57%     0.00%  cma              [kernel.kallsyms]      [.] free_contig_frozen_range
>             |
>             ---free_contig_frozen_range
>                |
>                |--20.45%--__free_contig_frozen_range
>                |          |
>                |          |--17.77%--free_pages_prepare
>                |          |
>                |           --0.72%--free_prepared_contig_range
>                |                     |
>                |                      --0.55%--__free_frozen_pages
>                |
>                 --3.12%--free_pages_prepare
> 
> Suggested-by: Zi Yan <ziy@nvidia.com>
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@arm.com>

Acked-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>

> ---
> Changes since v3:
> - Use newly introduced __free_contig_range_common() as the pattern was
>   very similar to __free_contig_range()
> 
> Changes since v2:
> - Rework the loop to check for memory sections just like __free_contig_range()
> - Didn't add reviewed-by tags because of rework
> ---
>  mm/page_alloc.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 64be8a9019dca..110e912fa785e 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -7059,8 +7059,7 @@ static int __alloc_contig_verify_gfp_mask(gfp_t gfp_mask, gfp_t *gfp_cc_mask)
>  
>  static void __free_contig_frozen_range(unsigned long pfn, unsigned long nr_pages)
>  {
> -	for (; nr_pages--; pfn++)
> -		free_frozen_pages(pfn_to_page(pfn), 0);
> +	__free_contig_range_common(pfn, nr_pages, true);
>  }
>  
>  /**

