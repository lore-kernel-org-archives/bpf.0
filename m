Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 811783A6EF9;
	Wed, 25 Mar 2026 10:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774433708; cv=none; b=BnpwSVcmgO1sMZ2kY0eqJj+QmiNWYgozzhNu7PrKWNtoCyJ0O4+JOF72C6PNefwhJ2TskSa4PuKAqBm6IgyMw/NTUdgDNUH3iICar7dRX3TObMCUfWImxIQUsrzS94Qy+TADSqf7vCRsC0iZ5KN2l08PsY2u0OXozCzm5toVtDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774433708; c=relaxed/simple;
	bh=I5ub2k82QnwWVmEhtM1D7FjRhq6hNb9lhP0IWUgTASI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OFozyGFLx/IeAWUF1ymNaTFLGqqHPPGs51DoD6kzbCCSnRfM2idrvU4eZScfHXZBqAxOGH13pC/vslO5eRqHKu0OUWiFVA8QdXIJgtt/bDiACDI660pR29gVHWwbFjmdrD4ujpmVU7FtLGxM4a7pzZ/ddouytQ7sbTy4AXgl/UU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IFxX7Nds; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IFxX7Nds"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA8D7C2BCB0;
	Wed, 25 Mar 2026 10:15:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774433708;
	bh=I5ub2k82QnwWVmEhtM1D7FjRhq6hNb9lhP0IWUgTASI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=IFxX7NdsgnjOpXghpl0RmVj4wVEDyI5Jy48RxLlNG88zw7OyDDuoUs8xa/q5Uy4wy
	 vK7SHK9ZugFF4NGfi//A3YfW/Yy0W9QSW3k9/QPKIX1hxLW8F6T3EaXfL88sHUN1ZI
	 nXQlqXOEKbdYxV/4KpMMTUkDczB7Ku3+EQd7c6JTMCEolGFXfraxDuqY9grfEIwOTg
	 ro2czttNSHsm3rYuKx4wbPXj9b26JsQsj14dCBMm56I/qIisTC/RhZcb/QONxzLhPy
	 1cC5SGd/rP6dQmn2r/k6kotkS5pogKGZbH8M+bq6/sghIKh0TyE7rKAHuqcj15lYJe
	 76pMw9Yd0hoRA==
Message-ID: <4ca68533-9abf-4d54-ba15-5ab9bc3ed0dc@kernel.org>
Date: Wed, 25 Mar 2026 11:14:59 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] mm/page_alloc: Optimize
 __free_contig_frozen_range()
To: Zi Yan <ziy@nvidia.com>, Muhammad Usama Anjum <usama.anjum@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Lorenzo Stoakes <ljs@kernel.org>, "Liam R . Howlett"
 <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@kernel.org>,
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, Brendan Jackman <jackmanb@google.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Uladzislau Rezki <urezki@gmail.com>,
 Nick Terrell <terrelln@fb.com>, David Sterba <dsterba@suse.com>,
 Vishal Moola <vishal.moola@gmail.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, Ryan.Roberts@arm.com,
 david.hildenbrand@arm.com
References: <20260324133538.497616-1-usama.anjum@arm.com>
 <20260324133538.497616-4-usama.anjum@arm.com>
 <309C0716-A53B-422D-ABDE-E865DE0473BB@nvidia.com>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <309C0716-A53B-422D-ABDE-E865DE0473BB@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/24/26 16:06, Zi Yan wrote:
> On 24 Mar 2026, at 9:35, Muhammad Usama Anjum wrote:
> 
>> Apply the same batch-freeing optimization from free_contig_range() to the
>> frozen page path. The previous __free_contig_frozen_range() freed each
>> order-0 page individually via free_frozen_pages(), which is slow for the
>> same reason the old free_contig_range() was: each page goes to the
>> order-0 pcp list rather than being coalesced into higher-order blocks.
>>
>> Rewrite __free_contig_frozen_range() to call free_pages_prepare() for
>> each order-0 page, then batch the prepared pages into the largest
>> possible power-of-2 aligned chunks via free_prepared_contig_range().
>> If free_pages_prepare() fails (e.g. HWPoison, bad page) the page is
>> deliberately not freed; it should not be returned to the allocator.
>>
>> I've tested CMA through debugfs. The test allocates 16384 pages per
>> allocation for several iterations. There is 3.5x improvement.
>>
>> Before: 1406 usec per iteration
>> After:   402 usec per iteration
>>
>> Before:
>>
>>     70.89%     0.69%  cma              [kernel.kallsyms]      [.] free_contig_frozen_range
>>             |
>>             |--70.20%--free_contig_frozen_range
>>             |          |
>>             |          |--46.41%--__free_frozen_pages
>>             |          |          |
>>             |          |           --36.18%--free_frozen_page_commit
>>             |          |                     |
>>             |          |                      --29.63%--_raw_spin_unlock_irqrestore
>>             |          |
>>             |          |--8.76%--_raw_spin_trylock
>>             |          |
>>             |          |--7.03%--__preempt_count_dec_and_test
>>             |          |
>>             |          |--4.57%--_raw_spin_unlock
>>             |          |
>>             |          |--1.96%--__get_pfnblock_flags_mask.isra.0
>>             |          |
>>             |           --1.15%--free_frozen_page_commit
>>             |
>>              --0.69%--el0t_64_sync
>>
>> After:
>>
>>     23.57%     0.00%  cma              [kernel.kallsyms]      [.] free_contig_frozen_range
>>             |
>>             ---free_contig_frozen_range
>>                |
>>                |--20.45%--__free_contig_frozen_range
>>                |          |
>>                |          |--17.77%--free_pages_prepare
>>                |          |
>>                |           --0.72%--free_prepared_contig_range
>>                |                     |
>>                |                      --0.55%--__free_frozen_pages
>>                |
>>                 --3.12%--free_pages_prepare
>>
>> Suggested-by: Zi Yan <ziy@nvidia.com>
>> Signed-off-by: Muhammad Usama Anjum <usama.anjum@arm.com>
>> ---
>> Changes since v2:
>> - Rework the loop to check for memory sections just like __free_contig_range()
>> - Didn't add reviewed-by tags because of rework
>> ---
>>  mm/page_alloc.c | 26 ++++++++++++++++++++++++--
>>  1 file changed, 24 insertions(+), 2 deletions(-)
>>
>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>> index 250cc07e547b8..26eac35ef73bd 100644
>> --- a/mm/page_alloc.c
>> +++ b/mm/page_alloc.c
>> @@ -7038,8 +7038,30 @@ static int __alloc_contig_verify_gfp_mask(gfp_t gfp_mask, gfp_t *gfp_cc_mask)
>>
>>  static void __free_contig_frozen_range(unsigned long pfn, unsigned long nr_pages)
>>  {
>> -	for (; nr_pages--; pfn++)
>> -		free_frozen_pages(pfn_to_page(pfn), 0);
>> +	struct page *page = pfn_to_page(pfn);
>> +	struct page *start = NULL;
>> +	unsigned long start_sec;
>> +	unsigned long i;
>> +
>> +	for (i = 0; i < nr_pages; i++, page++) {
>> +		if (!free_pages_prepare(page, 0)) {
>> +			if (start) {
>> +				free_prepared_contig_range(start, page - start);
>> +				start = NULL;
>> +			}
>> +		} else if (start &&
>> +			   memdesc_section(page->flags) != start_sec) {
>> +			free_prepared_contig_range(start, page - start);
>> +			start = page;
>> +			start_sec = memdesc_section(page->flags);
>> +		} else if (!start) {
>> +			start = page;
>> +			start_sec = memdesc_section(page->flags);
>> +		}
>> +	}
>> +
>> +	if (start)
>> +		free_prepared_contig_range(start, page - start);
>>  }
> 
> This looks almost the same as __free_contig_range().
> 
> Two approaches to deduplicate the code:
> 
> 1. __free_contig_range() first does put_page_testzero()
> on all pages and call __free_contig_frozen_range()
> on the range, __free_contig_frozen_range() will need
> to skip not frozen pages. It is not ideal.

Right, let's not do that.

> 
> 2. add a helper function
> __free_contig_range_common(unsigned long pfn,
> unsigned long nr_pages, bool is_page_frozen),
> and
> a. call __free_contig_range_common(..., /*is_page_frozen=*/ false)
> in __free_contig_range(),
> b. __free_contig_range_common(..., /*is_page_frozen=*/ true)
> in __free_contig_frozen_range().
> 

As long as it's an internal helper, that makes sense. I wouldn't want to
expose the bool in the external interface.

Thanks!

-- 
Cheers,

David
