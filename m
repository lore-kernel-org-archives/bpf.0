Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69E0929DB8F;
	Fri, 20 Mar 2026 14:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774017232; cv=none; b=BSfC1SNaiZH7tL0e4zZ4ZJ+EzYffNPoiDhWjf7nsDLwb9gVK5dOafdC50e3IMSkLXiwGYZHjHW/47sk8RV6nqCS09wdQoTMw/CzL1ErBZ1UT6zVj96Kv5egyx9ZZ3SVW0qt7GnmjAJ73DmsHi1e+FxZQBZM/tOl9bl1ENV0Lk9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774017232; c=relaxed/simple;
	bh=woNciVcFPVPKMQT5S/73G3cJUwtRkApIxOo1qnPR/fA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=AqCXJqNwCurgBKx2HapHq9PvBJojQPgV1R+d+17GM5JNSRZzG8yCyJREDCEAxu73H1Pq35dHLOl6xyCjOxaBU5JjCz3RRtQT2YG7LOutlgoSZC/5gfqo8v/GM7gmCV1+IatJnzqaxb5U5OmELUi576rqsb9Jxv5/GCgnK/bXqjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m040ISdA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m040ISdA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56BC8C4CEF7;
	Fri, 20 Mar 2026 14:33:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774017232;
	bh=woNciVcFPVPKMQT5S/73G3cJUwtRkApIxOo1qnPR/fA=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=m040ISdArhiK15Wt+g2CXOlAvu3bmHrRHpsjRNyEr+5iQN0VHvwWEumgevnywYjgK
	 7RWgfS9f7qIpRldtep2k0MvPI0QGqwKqCkowgyPujUSov0ZTUfaNdgWzIENX/xaDfl
	 7KwtQ6jZ/xdWEyJiuF0eTiDqfIjbOAFNn46yoa/BTGzlgCGZrV/+ZgYsk39dWsQjPN
	 FVFgBH4utS0kC2+I0NUEdiK2vL204Cde0ej3BOxGLMSKBAewmL8+8P4xEz3Pjq2opg
	 e9UWBA1ff3zHWLPMxoUWuPcHIvLstFIWFd76R/3VL243g31wdj13Plvlj75qRli5Jk
	 7cC+vmQ/cIGEA==
Message-ID: <38379a16-d596-4266-ac3b-1dbee5356add@kernel.org>
Date: Fri, 20 Mar 2026 15:33:46 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] vmalloc: Optimize vfree
Content-Language: en-US
To: "David Hildenbrand (Arm)" <david@kernel.org>,
 Muhammad Usama Anjum <usama.anjum@arm.com>,
 Andrew Morton <akpm@linux-foundation.org>, Lorenzo Stoakes <ljs@kernel.org>,
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
 <20260316113209.945853-3-usama.anjum@arm.com>
 <e59ab258-7331-412c-b490-657e32ec1fe0@kernel.org>
 <b7959d34-6e7d-45c2-a674-f32afd057068@kernel.org>
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
In-Reply-To: <b7959d34-6e7d-45c2-a674-f32afd057068@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/20/26 09:39, David Hildenbrand (Arm) wrote:
> On 3/16/26 16:49, Vlastimil Babka wrote:
>>>  mm/vmalloc.c | 34 +++++++++++++++++++++++++---------
>>>  1 file changed, 25 insertions(+), 9 deletions(-)
>>>
>>> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
>>> index c607307c657a6..8b935395fb068 100644
>>> --- a/mm/vmalloc.c
>>> +++ b/mm/vmalloc.c
>>> @@ -3459,18 +3459,34 @@ void vfree(const void *addr)
>>>  
>>>  	if (unlikely(vm->flags & VM_FLUSH_RESET_PERMS))
>>>  		vm_reset_perms(vm);
>>> -	for (i = 0; i < vm->nr_pages; i++) {
>>> -		struct page *page = vm->pages[i];
>>> +
>>> +	if (vm->nr_pages) {
>>> +		bool account = !(vm->flags & VM_MAP_PUT_PAGES);
>>> +		unsigned long start_pfn, pfn;
>>> +		struct page *page = vm->pages[0];
>>> +		int nr = 1;
>>>  
>>>  		BUG_ON(!page);
>>> -		/*
>>> -		 * High-order allocs for huge vmallocs are split, so
>>> -		 * can be freed as an array of order-0 allocations
>>> -		 */
>>> -		if (!(vm->flags & VM_MAP_PUT_PAGES))
>>> +		start_pfn = page_to_pfn(page);
>>> +		if (account)
>>>  			mod_lruvec_page_state(page, NR_VMALLOC, -1);
>>> -		__free_page(page);
>>> -		cond_resched();
>>> +
>>> +		for (i = 1; i < vm->nr_pages; i++) {
>>> +			page = vm->pages[i];
>>> +			BUG_ON(!page);
>> 
>> We shouldn't be adding BUG_ON()'s. Rather demote also the pre-existing one
>> to VM_WARN_ON_ONCE() and skip gracefully.
>> 
>>> +			if (account)
>>> +				mod_lruvec_page_state(page, NR_VMALLOC, -1);
>> 
>> I think we should be able to batch this too to use "nr"?
> 
> Are we sure that pages cannot cross nodes etc? It could happen that we
> have a contig range that spans zones/nodes/etc ...

Hmm single order-3 allocation can't but we could be unlucky and get the last
order-3 from zone X and first order-3 from adjacent zone Y.
In that case the loop would need to also check same zone/node.

> Anyhow, should we try to decouple both things, providing a
> core-mm function to do the page freeing?
> 
> We do have something similar, optimized unpinning of large folios,
> in unpin_user_pages_dirty_lock(). This here is a bit different.
> 
> 
> So what I am thinking about for this code here to do:
> 
> 	if (!(vm->flags & VM_MAP_PUT_PAGES)) {
> 		for (i = 0; i < vm->nr_pages; i++)
> 			mod_lruvec_page_state(vm->pages[i], NR_VMALLOC, -1);
> 	}
> 	free_pages_bulk(vm->pages, vm->nr_pages);
> 
> 
> We could optimize the first loop to do batching where possible as well.
> 
> 
> free_pages_bulk() would match alloc_pages_bulk()
> 
> 	void free_pages_bulk(struct page **page_array, unsigned long nr_pages)
> 
> Internally we'd do the contig handling.
> 
> Was that already discussed?

AFAIU some of Zi's replies hinted at this direction. It would make sense, yeah.

