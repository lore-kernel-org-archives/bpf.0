Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D04202DF12E;
	Tue, 17 Mar 2026 18:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773773301; cv=none; b=H2N9SjGK2F0YZr6PRSBQFbWRcVFkAeGA7CFOQNw50xAbPhZtoPcKpBK6Y9jyD7T1cQtHC0WpwW/cHHDOndzgfmNeunEnIJ5Ti0wts+xsh4Xm5/msQtpXGXYlaaZrg0qeICXPIhcH6My/AhpqlWlsfmGpNyo1O05a8iOBTeNuZqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773773301; c=relaxed/simple;
	bh=0kftD+8TpquK9/vm0Pg5dmDv4lLs9LvJpTwekAHYelY=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=FOtdsTg8B/ikYguDGH32223iMFaWU8rKSQz1XktjggzPFAjHq5xLkyrMLkFHnF3GMA0xOVhmchevD5nBj2UsFg6SbfYm2GxsZIJg64d3LXM1rV9Kf5BEyfwiMGR41k6JfPm1ZEDhS8M46f2gfWqgZOwHrQoYvyWMhhxm6+vhWt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TLrEjRXB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TLrEjRXB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3036BC4CEF7;
	Tue, 17 Mar 2026 18:48:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773773301;
	bh=0kftD+8TpquK9/vm0Pg5dmDv4lLs9LvJpTwekAHYelY=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
	b=TLrEjRXBvHm6uz+AXfCI91M9LtqY+Vezy3RZ0rPS2pD0g373OnfuE39brLZI0gfl5
	 BOnNe/KmJx6FgL3Zj4h3X1JXsxzRo5P4bv+MjkW9ZrDE6ktxM5c4k7PzGD/6EUcKKz
	 7iYCE54XXkTvwtc7OoA40xr40QatoSYE88TNnOb8clG73SXl/IXEHp93RGPtBfcWyI
	 ezoqoYTf1WT0bWB7oMXX+pcabw+F2wDYnmeLfYpkgpLj+YsZi57k5oid+jT3bO8sFk
	 fjrdUOs55y6Y12ZVztTVSQD4qF7mq/7HC56gQmL0+8z2Xx/imowtZdWTYPYFrOXsKg
	 7ggcWqp3FZCmQ==
Message-ID: <3883abcd-426d-4211-ae76-b5601ee728de@kernel.org>
Date: Tue, 17 Mar 2026 19:48:15 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Subject: Re: [PATCH v2 1/3] mm/page_alloc: Optimize free_contig_range()
Content-Language: en-US
To: Zi Yan <ziy@nvidia.com>
Cc: Muhammad Usama Anjum <usama.anjum@arm.com>, Ryan.Roberts@arm.com,
 Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Mike Rapoport
 <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, Brendan Jackman <jackmanb@google.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Uladzislau Rezki <urezki@gmail.com>,
 Nick Terrell <terrelln@fb.com>, David Sterba <dsterba@suse.com>,
 "Vishal Moola (Oracle)" <vishal.moola@gmail.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, david.hildenbrand@arm.com
References: <20260316113209.945853-1-usama.anjum@arm.com>
 <20260316113209.945853-2-usama.anjum@arm.com>
 <220e97f0-dc82-4f37-b833-7160aee46cea@suse.cz>
 <703BB8CD-23D9-4012-8333-366837D7E95A@nvidia.com>
 <fde63978-d632-4196-b032-4cc20041fd90@kernel.org>
 <2AE5B748-C57B-4BC1-BF9E-6299CCBF295B@nvidia.com>
In-Reply-To: <2AE5B748-C57B-4BC1-BF9E-6299CCBF295B@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/17/26 16:17, Zi Yan wrote:
> On 16 Mar 2026, at 12:19, Vlastimil Babka (SUSE) wrote:
> 
>> On 3/16/26 17:02, Zi Yan wrote:
>>> On 16 Mar 2026, at 11:21, Vlastimil Babka wrote:
>>>
>>>>> +/*
>>>>> + * free_pages_prepare() has already been called for page(s) being freed.
>>>>> + * TODO: Perform per-subpage free_pages_prepare() checks for order > 0 pages
>>>>> + * (HWPoison, PageNetpp, bad free page).
>>>>> + */
>>>>
>>>> I'm confused, and reading the v1 thread didn't help either. Where would the
>>>> subpages to check come from? AFAICS we start from order-0 pages always.
>>>> __free_contig_range calls free_pages_prepare on every page with order 0
>>>> unconditionally, so we check every page as an order-0 page. If we then free
>>>> the bunch of individually checked pages as a high-order page, there's no
>>>> reason to check those subpages again, no? Am I missing something?
>>>
>>> There are two kinds of order > 0 pages, compound and not compound.
>>> free_pages_prepare() checks all tail pages of a compound order > 0 pages too.
>>> For non compound ones, free_pages_prepare() only has free_page_is_bad()
>>> check on tail ones.
>>>
>>> So my guess is that the TODO is to check all subpages on a non compound
>>> order > 0 one in the same manner. This is based on the assumption that
>>
>> OK but:
>>
>> 1) Why put that TODO specifically on FPI_PREPARED definition, which is for
>> the case we skip the prepare/check?
>> 2) Why add it in this series which AFAICS doesn't handle non-compound
>> order>0 anywhere.
>> 3) We'd better work on eliminating the non-compound order>0 usages
>> altogether, rather than work on support them better.
> 
> I agreed with you when I first saw this. After I think about it again,
> the issue might not be directly related to the allocation but is the free path.
> Like the patch title said, it is an optimization of free contiguous pages.
> These physically contiguous pages happen to come from alloc non-compound order>0
> and this leads to this optimization.

Sure and this use-case doesn't need the TODO to be solved, or am I mistaken?

That TODO seems to be about a hypothetical other use case with order>0
non-compound pages. Because AFAICS the use-cases in this series are not
about order>0 non-compound pages. Maybe they exist for a brief moment
between allocation and split_page() (in vmalloc() case?), but when we are
freeing them, we start with a contiguous series of order-0 pages (refcounted
or not).

So by my definition we are not freeing an order>0 non-compound page. By
"freeing order>0 non-compound page" I mean specifically what ___free_pages()
is handling in the "else if (!head) {" path, which I'd love to get rid of.
That TODO to me seems like about supporting that case.

> The problem they want to solve is to speed up page free path by freeing
> a group of pages together. They are optimizing for a special situation
> where a group of pages that are physically contiguous, so that these pages
> can be freed via free_pages(page, order /* > 0 */). If we take away

I don't think we want that as that leads to the case I described above. It
assumes head is refcounted and tail are not. I'd rather not overload it with
a case where we have contiguous order-0 pages where each is refcounted (or
none are). Yeah we can optimize the freeing like this series does, but I'd
not do it via something like "free_pages(page, order /* > 0 */)"

> the allocation of non-compound order>0, like you suggested in 3, we basically

I suggested we'd take it away in the sense of not producing order>0 where
head is refcounted, tails are not, and it's not a compound page. I'd rather
have an API that applies split_page() before and returns it as order-0
refcounted pages, but not the intermediate order>0 non-compound anymore.

> remove the optimization opportunity from them. I am not sure that what
> people want.
> 
> To think about the problem broadly, how can we optimize free_page_bulk(),
> if that exists? Sorting input pages based on PFNs, so that we can them in
> high orders instead of individual order-0s. This patch basically says,
> hey, the group of pages we are freeing are all contiguous, since that is
> how we allocate them, freeing them as a whole is much quicker than freeing
> them individually.

Yes we can have generalized, perhaps stacked support for the cases used by
the converted callers in this series, but not using a generic API that would
try e.g. sorting pfns even when we know they are already sorted. That means:

- given as contiguous range, frozen (patch 3)
- given as contiguous range, not frozen (patch 1)
- probably contiguous, needs checking, given as array of pages (patch 2)

>>
>>> all non compound order > 0 page users use split_page() after the allocation,
>>> treat each page individually, and free them back altogether. But I am not
>>> sure if this is true for all users allocating non compound order > 0 pages.
>>
>> Maybe as part of the elimination (point 3 above) we should combine the
>> allocation+split so it's never the first without the second anymore.

I elaborated on this above.

>>> And free_pages_prepare_bulk() might be a better name for such functions.
>>>
>>> The above confusion is also a reason I asked Ryan to try adding a unsplit_page()
>>> function to fuse back non compound order > 0 pages and free the fused one
>>> as we are currently doing. But that looks like a pain to implment. Maybe an
>>
>> Yeah not sure it's worth it either.
>>
>>> alternative to this FPI_PREPARED is to add FPI_FREE_BULK and loop through all
>>> subpages if FPI_FREE_BULK is set with
>>> __free_pages_prepare(page + i, 0, fpi_flags & ~FPI_FREE_BULK) in
>>> __free_pages_ok().
>>
>> Hmm, maybe...
> 
> Let me know if my reasoning above moves your opinion on FPI_FREE_BULK towards
> a positive direction. :)

If you can make it work to support the three cases above, without doing
unnecessary work, and with no "free_pages(page, order /* > 0 */)" like API?

> Best Regards,
> Yan, Zi

