Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C641A3F23C5;
	Wed, 29 Apr 2026 12:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777465878; cv=none; b=lGIG71cEw2K43yvxutv8rhWRIaNACBt1FYXQPWsoTGNGM/XLHqzFWmhdf06FMZdhGkPZVxJF5g+JsMVnOHgy/ls9lWLVs5UnPTCfTKXcoX8sFKqyqEDVaY+yIZW6tmuzQocE5i0/XM93HsJSGFUqimhv74J3F5c57B65Giol5bY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777465878; c=relaxed/simple;
	bh=2pIojbJQg9tB5OJkbigs/SXblp/raktpEhuhy3g94i4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e3f6tiBlFEV8qH5ZfDYgz0pLKjU5PwFhFIpjUTJbxwIjC6a2xe6z7JM6Ndf1m2tviyrpMycdzJEZrm6pYHAjhQ/BmjYN6dZdEOV73F9lqmrckIQJ/QFqIx/2IRDREzH7hvy79Oy4x4o8HXMgeR8vNqwRfm+JlCmjaxZsg/4y2aI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=VQlCzalW; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="VQlCzalW"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C006E2A68;
	Wed, 29 Apr 2026 05:31:10 -0700 (PDT)
Received: from [10.57.90.96] (unknown [10.57.90.96])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B54663F836;
	Wed, 29 Apr 2026 05:31:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1777465876; bh=2pIojbJQg9tB5OJkbigs/SXblp/raktpEhuhy3g94i4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=VQlCzalWyEWttNiubbfJ002pfiwZMF9cJ/bo1THuZmxTORIUhLTEjcl6kqRyB6sJx
	 /4X6ML+SqxEJXwPD9h+y5al2/h2cdiLa4P0uQFXmsj8Hd22PEKtnFk3XYSnj+6ws4k
	 EGG+QZeaCZ/hV2vHCXXnbjyVpxLb0eq+oGafyXbw=
Message-ID: <9834200a-492c-4705-a2b2-e76cc0ba5392@arm.com>
Date: Wed, 29 Apr 2026 13:31:10 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/3] mm: Free contiguous order-0 pages efficiently
Content-Language: en-GB
To: Andrew Morton <akpm@linux-foundation.org>,
 Johannes Weiner <hannes@cmpxchg.org>
Cc: Muhammad Usama Anjum <usama.anjum@arm.com>,
 David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Brendan Jackman <jackmanb@google.com>, Zi Yan <ziy@nvidia.com>,
 Uladzislau Rezki <urezki@gmail.com>, Nick Terrell <terrelln@fb.com>,
 David Sterba <dsterba@suse.com>, Vishal Moola <vishal.moola@gmail.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 david.hildenbrand@arm.com
References: <20260401101634.2868165-1-usama.anjum@arm.com>
 <20260429103326.GA1743@cmpxchg.org>
 <20260429050430.d86f01dbe731edc9fa932add@linux-foundation.org>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20260429050430.d86f01dbe731edc9fa932add@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 29/04/2026 13:04, Andrew Morton wrote:
> On Wed, 29 Apr 2026 06:33:26 -0400 Johannes Weiner <hannes@cmpxchg.org> wrote:
> 
>> On Wed, Apr 01, 2026 at 11:16:18AM +0100, Muhammad Usama Anjum wrote:
>>> Hi All,
>>>
>>> A recent change to vmalloc caused some performance benchmark regressions (see
>>> [1]). I'm attempting to fix that (and at the same time significantly improve
>>> beyond the baseline) by freeing a contiguous set of order-0 pages as a batch.
>>
>> I think we should revert the original patch.
>>
>> The premise is that we can save some allocator calls by requesting
>> higher orders and splitting them up into singles. This is a frivolous
>> and short-sighted use of a very coveted and expensive resource.

I'm not sure it's that simple. First off, vmalloc has preferred to allocate high
order pages for quite a while, it's just that the patch you're referring to
makes it try even harder. So reverting the patch doesn't completely revert the
behaviour, it just reduces it.

Performance benefits because those high order pages are mapped appropriately in
the page table - i.e. 1G PUD, 2M PMD, (or 64K CONTPTE on arm64). So it's not
solely about the number of cycles spent in the allocator; the HW is used more
efficiently. vmalloc only splits to order-0 for the benefit of the caller,
because there are some places that assume they can access each returned struct page.

And all the order-0 pages of the original high order page are freed at the same
time, so it's not like we are destroying the contiguous resource; it remains
intact for the next user (well, ignoring that some will be freed to the pcpu
list - this series solves that wrinkle). I've heard it argued that this approach
is actually _better_ for conserving contiguous blocks because it's keeping the
lifetime of all the constituent pages bound together and reducing fragmentation.
I've never seen any data though...

>>
>> The buddy allocator tries hard to retain contiguity *if it isn't
>> needed by the caller*. This patch actively works around that.
>>>> The cost of recreating those higher orders elsewhere is shouldered by
>> whoever actually needs the contiguity down the line. And that process
>> is orders of magnitudes more expensive than we save here:
>>
>> We're saving cycles per page in the vmalloc path, and later spend tens
>> of thousands of cycles per page to recreate the contiguity. Scanning
>> PFN ranges, folio locks, rmap walks, TLB flushes, page copies.
>>
>> That's a terrible trade-off.
> 
> That's persuasive.
> 
> afaict much/all of this series remains useful after a06157804399
> ("mm/vmalloc: request large order pages from buddy allocator") is
> reverted?

Yes; although the motivation for the investigation was observed micro-benchmark
regressions due to a06157804399 ("mm/vmalloc: request large order pages from
buddy allocator"), this series is still beneficial even without that patch since
vmalloc will still allocate high order pages in many situations and so it's
still beneficial to free them efficiently when the time comes.

> 
> What I'm not understanding is how significant all of this is.  Sure,
> making many-page vmallocs faster is both beneficial and harmful.  And we
> have super-focused microbenchmarks which demonstrate both effects.  But
> how often does the kernel actually *do* this stuff in real-world (or
> even real-world corner-case) situations?

Afraid I don't have clear data on that. My intuition is that it's a real-world
corner case. But significant enough to justify all the previous effort to map by
hugepage where possile...

Thanks,
Ryan

