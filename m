Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 693C83E2764;
	Wed, 25 Mar 2026 14:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774449284; cv=none; b=QMNN1bnDiLTTwSt0YVkga8/U25Y6IPsqRHDIV6UKuYHGUtSoQ33xQidpWvw9N31N3a5sshtYrkOmgLnYq0ADQb5CGQ+uwWbe2AVLyouW3Uii6TaKsypnQr1GcZTBK90iZyXWC8qEfI7qSxYJ1FRjXu4C+iz8oFpMmlBsmvQZstY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774449284; c=relaxed/simple;
	bh=6/u6HKYQDsWx6V41hulRBAMFC+hy/qZJazOJY5r5Rmk=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=UdSxGJA01clriaUwF614a4rGB6Rg4p4TlCN+cpjgIbb8yrQ7sV+FYaeTMKnHxKT9mrxaYluFLDrYDZyjyU9PbV1dWlrNc/GPQO3iAqz3enxPT/BfuDnfaqQTCL06wPwYJ8T57VfitkbW7AhQ300zFSpmiQKPO9bznt922jp4KCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=BPDlcuAx; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="BPDlcuAx"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2216D1F91;
	Wed, 25 Mar 2026 07:34:34 -0700 (PDT)
Received: from [10.1.194.63] (e142334-100.cambridge.arm.com [10.1.194.63])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B644F3F836;
	Wed, 25 Mar 2026 07:34:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1774449280; bh=6/u6HKYQDsWx6V41hulRBAMFC+hy/qZJazOJY5r5Rmk=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=BPDlcuAxL4aXuXQ8Rz7EjB+h55HmaQlwOQxJGa3gYVwAmSuKM5tpQ7gB738eHHnlf
	 k12R0YuctQPWcvu5NQEdtTVUtt2sbw8t90IUopt1Yd6Fj9KVK2j8oIaH08yx8g9ZN9
	 99yOkdve+glFLZtZjDymTldx7BrJmgMrb7LoXZqo=
Message-ID: <c379889b-42eb-44ea-8cf4-1f29a45b6ce1@arm.com>
Date: Wed, 25 Mar 2026 14:34:36 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: usama.anjum@arm.com, Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Brendan Jackman <jackmanb@google.com>, Johannes Weiner <hannes@cmpxchg.org>,
 Uladzislau Rezki <urezki@gmail.com>, Nick Terrell <terrelln@fb.com>,
 David Sterba <dsterba@suse.com>, Vishal Moola <vishal.moola@gmail.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 Ryan.Roberts@arm.com, david.hildenbrand@arm.com
Subject: Re: [PATCH v3 2/3] vmalloc: Optimize vfree
To: Zi Yan <ziy@nvidia.com>
References: <20260324133538.497616-1-usama.anjum@arm.com>
 <20260324133538.497616-3-usama.anjum@arm.com>
 <1D88CFF0-8A74-413F-9A6A-39E27B760AE1@nvidia.com>
From: Usama Anjum <usama.anjum@arm.com>
Content-Language: en-US
In-Reply-To: <1D88CFF0-8A74-413F-9A6A-39E27B760AE1@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

<snip>
>> +void free_pages_bulk(struct page **page_array, unsigned long nr_pages)
>> +{
>> +	unsigned long start_pfn = 0, pfn;
>> +	unsigned long i, nr_contig = 0;
>> +
>> +	for (i = 0; i < nr_pages; i++) {
>> +		pfn = page_to_pfn(page_array[i]);
>> +		if (!nr_contig) {
>> +			start_pfn = pfn;
>> +			nr_contig = 1;
>> +		} else if (start_pfn + nr_contig != pfn) {
>> +			__free_contig_range(start_pfn, nr_contig);
>> +			start_pfn = pfn;
>> +			nr_contig = 1;
>> +			cond_resched();
>> +		} else {
>> +			nr_contig++;
>> +		}
>> +	}
>> +	if (nr_contig)
>> +		__free_contig_range(start_pfn, nr_contig);
>> +}
> 
> free_pages_bulk() assumes pages in page_array are sorted in PFN ascending order.
> I think it is worth documenting it, since without sorting, it can degrade
> back to the original implementation.
I'll add the kerneldoc comment.

> 
>> +
>>  /*
>>   * This is the 'heart' of the zoned buddy allocator.
>>   */
>> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
>> index c607307c657a6..e9b3d6451e48b 100644
>> --- a/mm/vmalloc.c
>> +++ b/mm/vmalloc.c
>> @@ -3459,19 +3459,13 @@ void vfree(const void *addr)
>>
>>  	if (unlikely(vm->flags & VM_FLUSH_RESET_PERMS))
>>  		vm_reset_perms(vm);
>> -	for (i = 0; i < vm->nr_pages; i++) {
>> -		struct page *page = vm->pages[i];
>>
>> -		BUG_ON(!page);
>> -		/*
>> -		 * High-order allocs for huge vmallocs are split, so
>> -		 * can be freed as an array of order-0 allocations
>> -		 */
>> -		if (!(vm->flags & VM_MAP_PUT_PAGES))
>> -			mod_lruvec_page_state(page, NR_VMALLOC, -1);
>> -		__free_page(page);
>> -		cond_resched();
>> +	if (!(vm->flags & VM_MAP_PUT_PAGES)) {
>> +		for (i = 0; i < vm->nr_pages; i++)
>> +			mod_lruvec_page_state(vm->pages[i], NR_VMALLOC, -1);
>>  	}
>> +	free_pages_bulk(vm->pages, vm->nr_pages);
>> +
> 
> stats is updated before any page is freed. It is better to mention
> it in the commit message.
I'll mention it.

> 
>>  	kvfree(vm->pages);
>>  	kfree(vm);
>>  }
>> -- 
>> 2.47.3
> 
> Otherwise, LGTM.
> 
> Acked-by: Zi Yan <ziy@nvidia.com>
> 
> Best Regards,
> Yan, Zi
> 

Thanks,
Usama
