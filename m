Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE39E2580D7;
	Thu, 30 Apr 2026 12:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777552385; cv=none; b=mItSVggQeJ7Biye49dj65WDzu7Bta7JJp5XDR9YAkpCzoy0C1m9kni5+8nVVK6ysCfNc0KQW4IjntymequuJp4fnpcFGcLUABUoq/+dD5kYxjXLzNv2FbnRpcang1zDXoZdL44wHscv5QiTt88C8SUO5B3LcBXvyLQB8sGsE9jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777552385; c=relaxed/simple;
	bh=Kmi7hh+sO6z2S3y8opc1Fyz09zGGdr9v7xC+7nSlt1o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UZfNmuD9cGikxVhy98vcRaAuV/TEYk8oXhXa/Qr9ifv2lfSuzXPf9SnZ6s4ZQ1NF7NttE1KkC5/Tgdv6CPB4FNUhagXJjYvSJXE0w6VuFeO/TsoIcJ9gjtTUbQytupo7/bilhxzzA2k3mLWQFs9Cvfvs6MMaGHZ+/HkETwaKFlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=l7HQCUDy; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="l7HQCUDy"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9DE3219F6;
	Thu, 30 Apr 2026 05:32:56 -0700 (PDT)
Received: from [10.57.90.96] (unknown [10.57.90.96])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 120723F7B4;
	Thu, 30 Apr 2026 05:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1777552382; bh=Kmi7hh+sO6z2S3y8opc1Fyz09zGGdr9v7xC+7nSlt1o=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=l7HQCUDyMDl141q50c9CPFNzaRun/uJJSrTG+cDq+t5dHzHX/7fZFsawMzauuUqbo
	 2hqU40o6oMaJ2JL32aGkaUS3q3l5HHCoP3KLaTYiE5SZ2+XtTqVpUywpHxLT2IqzXL
	 BFRC6vsF5AFL4+5quCkrbFdsyVLq2RX89OG+XyAM=
Message-ID: <74bddfeb-0530-4cca-af17-a7920f17bb5b@arm.com>
Date: Thu, 30 Apr 2026 13:32:57 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/3] mm: Free contiguous order-0 pages efficiently
Content-Language: en-GB
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Muhammad Usama Anjum <usama.anjum@arm.com>,
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
 <9834200a-492c-4705-a2b2-e76cc0ba5392@arm.com>
 <20260429135228.GA1987@cmpxchg.org>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20260429135228.GA1987@cmpxchg.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 29/04/2026 14:52, Johannes Weiner wrote:
> On Wed, Apr 29, 2026 at 01:31:10PM +0100, Ryan Roberts wrote:
>> On 29/04/2026 13:04, Andrew Morton wrote:
>>> On Wed, 29 Apr 2026 06:33:26 -0400 Johannes Weiner <hannes@cmpxchg.org> wrote:
>>>
>>>> On Wed, Apr 01, 2026 at 11:16:18AM +0100, Muhammad Usama Anjum wrote:
>>>>> Hi All,
>>>>>
>>>>> A recent change to vmalloc caused some performance benchmark regressions (see
>>>>> [1]). I'm attempting to fix that (and at the same time significantly improve
>>>>> beyond the baseline) by freeing a contiguous set of order-0 pages as a batch.
>>>>
>>>> I think we should revert the original patch.
>>>>
>>>> The premise is that we can save some allocator calls by requesting
>>>> higher orders and splitting them up into singles. This is a frivolous
>>>> and short-sighted use of a very coveted and expensive resource.
>>
>> I'm not sure it's that simple. First off, vmalloc has preferred to allocate high
>> order pages for quite a while, it's just that the patch you're referring to
>> makes it try even harder. So reverting the patch doesn't completely revert the
>> behaviour, it just reduces it.
>>
>> Performance benefits because those high order pages are mapped appropriately in
>> the page table - i.e. 1G PUD, 2M PMD, (or 64K CONTPTE on arm64). So it's not
>> solely about the number of cycles spent in the allocator; the HW is used more
>> efficiently. vmalloc only splits to order-0 for the benefit of the caller,
>> because there are some places that assume they can access each returned struct page.
> 
> Sure, TLB benefits can offset the cost.
> 
> PTE mapped higher orders on systems without contpte (still many) are the problem.

Perhaps vmalloc should only request the high orders when it knows it can map
them beneficially then? (which I guess was the case prior to the patch in
question?).

> 
>> And all the order-0 pages of the original high order page are freed at the same
>> time, so it's not like we are destroying the contiguous resource; it remains
>> intact for the next user (well, ignoring that some will be freed to the pcpu
>> list - this series solves that wrinkle). I've heard it argued that this approach
>> is actually _better_ for conserving contiguous blocks because it's keeping the
>> lifetime of all the constituent pages bound together and reducing fragmentation.
> 
> You're still consuming contiguity and increasing competition over
> it. That needs to pay off in a closed system, not just in one small
> part of it.
> 
> I'm a bit skeptical of that beneficial effect. Sure, if there aren't
> any small fragments and most everybody is doing larger allocations,
> then yes, this could make sense. Although in that case, even calling
> the buddy allocator repeatedly from vmalloc would give you physically
> adjacent pages due to the way splitting works (although I'm not sure
> right now if you'd get the right exact PFN order for contpte).
> 
> But as long as there is a mix of allocation sizes with mixed
> lifetimes, consuming contiguity that you don't need has a high cost
> over vacuuming up holes and fragments. Because now you're competing
> with somebody who has no choice but to *painstakingly move live pages
> around to coalesce the holes*.
> 
> That's the whole reason for the __rmqueue_smallest()-first policy in
> the page allocator. It's fine for somebody to challenge this. But it
> feels pretty strange to make a unilateral decision in vmalloc that
> works around and inverts established allocator policy, with very
> little data to boot.
> 
>> I've never seen any data though...
> 
> Yes. Considering the possible externalities of this patch, IMO we
> should have much more data on big picture behavior, under varying
> pressure situations and workloads etc.
> 
> The reason for my email was that we see this hurting in experiments
> with new code. The vmalloc higher-orders cause a sharp increase in
> compaction activity, subsequent lock contention in zsmalloc migration
> callbacks etc. I wasn't just making this up.

Fair enough.

For the avoidence of doubt, are you also suggesting that this series should not
go in or just that a06157804399 ("mm/vmalloc: request large order pages from
buddy allocator") should be reverted? If the latter, then perhaps it's best to
move the discussion to that thread to catch Vishal and Willy's attention?

Thanks,
Ryan



