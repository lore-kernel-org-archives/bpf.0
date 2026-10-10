Received: from mail-m155116.qiye.163.com (mail-m155116.qiye.163.com [101.71.155.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22883360EE5
	for <bpf@vger.kernel.org>; Sat, 10 Oct 2026 10:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791629795; cv=none; b=rKCgfvBJiBbYOARX4764AfUtQoFZ5qK3XrQII3UbFfnHZsUQWWhGTUZwXghM3TyzxKMe6tJYr7sUd/7FEUnf6+Cj5lqVKjZsZ+tOj3nIAZ87sTFT2kLN+JSx0Kv3Mv+41PlbunkqbmDS2LyHCGxJoy/tG7nSE9BYetExtgSRqe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791629795; c=relaxed/simple;
	bh=OH9EpUZsyauVd+qduWdm1HoDvZutAxHCeQzKNjSPBV4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WwMGs1/IaKcJcCRRsaJdr9so7nu9Qmu/PufLRo9z8kIIWvZKZkuWp82HCAVwdO+c9nXoWjJcCuhcIs/qbFpGbF9g6ZlS5apNftqf7Ew4Oka4w659L+2TRlXZm2ylQERjDcejcWc8RodzUKqZxU7/gtiq0ZlmzwxRGUNBKFLel0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=easystack.cn; spf=pass smtp.mailfrom=easystack.cn; arc=none smtp.client-ip=101.71.155.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=easystack.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=easystack.cn
Received: from [192.168.0.59] (unknown [218.94.118.90])
	by smtp.qiye.163.com (Hmail) with ESMTP id 1feac8c51;
	Sat, 10 Oct 2026 17:40:44 +0800 (GMT+08:00)
Message-ID: <3b0ee0eb-b5d7-4131-80bd-0746e70191f9@easystack.cn>
Date: Sat, 10 Oct 2026 17:40:43 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] mm/page_owner: extract page_owner_next_eligible()
 from read loop
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20261009112308.240769-1-zhen.ni@easystack.cn>
 <20261009112308.240769-2-zhen.ni@easystack.cn>
 <sashiko-outbox-165395@kernel.org>
From: "zhen.ni" <zhen.ni@easystack.cn>
In-Reply-To: <sashiko-outbox-165395@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa1252fae7a0229kunm0f3a7def51546d
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFJQjdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlDTB4fVh9CHUIZHxlMSBlOTVYVFA
	kWGhdVGRETFhoSFyQUDg9ZV1kYEgtZQVlJSkNVQk9VSkpDVUJLWVdZFhoPEhUdFFlBWU9LSFVCQk
	lOS1VKS0tVSkJLQlkG



在 2026/10/9 19:35, sashiko-bot@kernel.org 写道:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] mm: soft lockup in page_owner_next_eligible() due to missing cond_resched()
> --
> 
> commit 303a10c305ed333982228df86334f12bd6d8a3c2
> Author: Zhen Ni <zhen.ni@easystack.cn>
> 
> mm/page_owner: extract page_owner_next_eligible() from read loop
> 
> This commit extracts the page scanning logic from read_page_owner() into a
> dedicated helper, page_owner_next_eligible(). It advances a cursor to the
> next eligible page and takes a snapshot of the page_owner record inside the
> page_ext RCU window.
> 
>> diff --git a/mm/page_owner.c b/mm/page_owner.c
>> index fbbda7ba914ba..bafe474f33602 100644
>> --- a/mm/page_owner.c
>> +++ b/mm/page_owner.c
> 
> [ ... ]
> 
>> @@ -798,37 +795,67 @@ read_page_owner(struct file *file, char __user *buf, size_t count, loff_t *ppos)
>>   			goto ext_put_continue;
>>   
>>   		/*
>> -		 * Access to page_ext->handle isn't synchronous so we should
>> -		 * be careful to access it.
>> +		 * Take a snapshot of the page_owner record inside the RCU
>> +		 * window, then validate it, so that print_page_owner()
>> +		 * reads the checked handle from the same snapshot.
>>   		 */
>> -		handle = READ_ONCE(page_owner->handle);
>> -		if (!handle)
>> -			goto ext_put_continue;
>> +		scan->pfn = pfn;
>> +		scan->page = page;
>> +		scan->po_snap = *page_owner;
>> +		page_ext_put(page_ext);
>>   
>> +		if (!scan->po_snap.handle)
>> +			continue;
> 
> [Severity: High]
> Could this cause a soft lockup? By using a continue statement here in
> page_owner_next_eligible(), we jump directly to the next loop iteration
> (advancing pfn) without executing cond_resched() at the end of the loop
> block.
> 
> If a large contiguous sequence of allocated pages lacks stack handles
> (e.g., if stack depot is exhausted or during early non-tracked allocations),
> the kernel could iterate over millions of pages without yielding.
> 
> The original implementation used goto ext_put_continue; which correctly
> yielded. Does this need to be updated to explicitly yield or use the
> goto instead?
> 

Many contiguous allocated pages having a zero handleis an extreme
case, so I didn't add a scheduling point there.

It is harmless and keeps the reject path uniform, so I'll switch it to
`goto ext_put_continue` in the next revision.

>> +
>> +		return true;
>> +
>> +ext_put_continue:
>> +		page_ext_put(page_ext);
>> +		cond_resched();
>> +	}
> 

Thanks,
Zhen
