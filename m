Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A83F334C1C;
	Mon, 16 Mar 2026 16:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773678128; cv=none; b=XOhs7Fd4OVtEFLuSva9FSg5eoKtunYGYta9TW8qLodsdrKHif//HfCUlU/G0F7oGRQI5OD4dBfe2cWIrcj5rmP6aNBXPxrrMB8//h2yG1vgRQJCzBZwpcisF1NIEXGwT83/1s3puhCZsqU758VO/II63b0OT6ayQAwVDubr9ecc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773678128; c=relaxed/simple;
	bh=5ALDfe6IoRbuZfXMM8bRpZyhpEkGKssanIAghhRg5zA=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:References:
	 In-Reply-To:Content-Type; b=QgUZVe/LtKRAgasGFZtIW5qmX8gGxgxYp/37pugKaHS30XkaB9Upm5B5/jlYXzMG8UgjnTNQ2IinrRLc+SE2tM5yyEfUjqkqIYlD+V0or4NWeJc4bEjDjRlys9Eq/KsLIvcDQikda4WTU07h9wnqwEYy+JosYUM63U3VHEkn9zE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JUdUbMR9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JUdUbMR9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9C6BC19425;
	Mon, 16 Mar 2026 16:22:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773678127;
	bh=5ALDfe6IoRbuZfXMM8bRpZyhpEkGKssanIAghhRg5zA=;
	h=Date:From:Subject:To:References:In-Reply-To:From;
	b=JUdUbMR94IE0Xujl6Qx5aVdh8iusl2gZ3QO7zR0ZDivWsEYMkTR6+0ZNd1VKuE2D6
	 5zZA06lsXSW8QJG+NgKw79p3zyCaCUNtwfATi0ahCpoRrsqvOwpGlW5qQ2qpe0esVx
	 8hyaxkvnPQ/liBzHbpcBcU/jRQw4+vyA0ypfXKtM8oYsY9ONAgdXGrYXJ5TFQifGsE
	 V4VEDehG6UNB2YH9Sp3fAtmYzcpJyelsbPkYoNb5ssoEEzmLBTl3SjK4jx3YCZS+bG
	 AjG1OD0BKyG5rCqaarLVqPGuBJrXgtgSprr7XJzBeFsqjqfb3xx9PtvmFwbjzcoIj3
	 Arfylj6+ZgvuQ==
Message-ID: <92811e6b-70d6-4669-8b62-c8544507ea19@kernel.org>
Date: Mon, 16 Mar 2026 17:22:02 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Vlastimil Babka <vbabka@kernel.org>
Subject: Re: [PATCH v2 3/3] mm/page_alloc: Optimize
 __free_contig_frozen_range()
Content-Language: en-US
To: Muhammad Usama Anjum <usama.anjum@arm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Mike Rapoport
 <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, Brendan Jackman <jackmanb@google.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>,
 Uladzislau Rezki <urezki@gmail.com>, Nick Terrell <terrelln@fb.com>,
 David Sterba <dsterba@suse.com>,
 "Vishal Moola (Oracle)" <vishal.moola@gmail.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, Ryan.Roberts@arm.com,
 david.hildenbrand@arm.com
References: <20260316113209.945853-1-usama.anjum@arm.com>
 <20260316113209.945853-4-usama.anjum@arm.com>
In-Reply-To: <20260316113209.945853-4-usama.anjum@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/16/26 12:31, Muhammad Usama Anjum wrote:
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

LGTM.
Reviewed-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>

> ---
>  mm/page_alloc.c | 18 ++++++++++++++++--
>  1 file changed, 16 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 6a9430f720579..2e99fa85cdc8e 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -7020,8 +7020,22 @@ static int __alloc_contig_verify_gfp_mask(gfp_t gfp_mask, gfp_t *gfp_cc_mask)
>  
>  static void __free_contig_frozen_range(unsigned long pfn, unsigned long nr_pages)
>  {
> -	for (; nr_pages--; pfn++)
> -		free_frozen_pages(pfn_to_page(pfn), 0);
> +	struct page *page = pfn_to_page(pfn);
> +	struct page *start = NULL;
> +	unsigned long i;
> +
> +	for (i = 0; i < nr_pages; i++, page++) {
> +		if (free_pages_prepare(page, 0)) {
> +			if (!start)
> +				start = page;
> +		} else if (start) {
> +			free_prepared_contig_range(start, page - start);
> +			start = NULL;
> +		}
> +	}
> +
> +	if (start)
> +		free_prepared_contig_range(start, page - start);
>  }
>  
>  /**

