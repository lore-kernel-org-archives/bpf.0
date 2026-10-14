Received: from mail-m19731110.qiye.163.com (mail-m19731110.qiye.163.com [220.197.31.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6436B347505
	for <bpf@vger.kernel.org>; Wed, 14 Oct 2026 07:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791964391; cv=none; b=f61mOKLMmNSZFVhYJBZXchHeTuIwchwq0BvNb5l9SHMU05lOifTlgkChw+WnOPrebUlvnw7qFK+79KSQqmf0XipFBVexotpfUNCLls/T8wYTtyw1FWCUo7mqf1Kk/nhgjnX/2BbBesM1DgM47yQeWbR02+SUyVyFOTrB71q565k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791964391; c=relaxed/simple;
	bh=nJZBGhEUFLqdeoEdfpk2eQt5LVvAlCH8oD3JwwCKG6Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pqKDjcYrKx+eOca1GCjkN03dZjSWvXJ+W+bu/arewNz5lWwQJe+DadwkJsugYqynrUlJbfvgzrA0xrjUEAAGZNWppVJg/9nBAok/j03NytF0lJnGJ1hpJGB2ni0zVeDAV96puwNZai3yHD2FQQDk2zEbF+dst9hLJfPEwSxtNUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=easystack.cn; spf=pass smtp.mailfrom=easystack.cn; arc=none smtp.client-ip=220.197.31.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=easystack.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=easystack.cn
Received: from [192.168.0.59] (unknown [218.94.118.90])
	by smtp.qiye.163.com (Hmail) with ESMTP id 200ca9f7c;
	Wed, 14 Oct 2026 15:47:45 +0800 (GMT+08:00)
Message-ID: <774f27c4-8c73-47d1-831d-0b827c0f3be5@easystack.cn>
Date: Wed, 14 Oct 2026 15:47:44 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/6] mm/page_owner: add bpf_page_owner_get_memcg_info()
 kfunc
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20261013122125.843451-1-zhen.ni@easystack.cn>
 <20261013122125.843451-6-zhen.ni@easystack.cn>
 <sashiko-outbox-169738@kernel.org>
From: "zhen.ni" <zhen.ni@easystack.cn>
In-Reply-To: <sashiko-outbox-169738@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa13961ad3c0229kunm6bb54fc9449bf
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFJQjdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlCSxlKVh0ZSh1OTR1OS09DSFYVFA
	kWGhdVGRETFhoSFyQUDg9ZV1kYEgtZQVlJSkNVQk9VSkpDVUJLWVdZFhoPEhUdFFlBWU9LSFVCQk
	lOS1VKS0tVSkJLQlkG



在 2026/10/13 20:49, sashiko-bot@kernel.org 写道:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [High] bpf: TOCTOU race in bpf_page_owner_get_memcg_info() leads to page fault
> - [High] mm: wild pointer dereference in get_page_memcg_info() for tail pages
> --
> 
> commit ab0ccc33a4ab8ccdaacb5f6b2dca8722bf6d6123
> Author: Zhen Ni <zhen.ni@easystack.cn>
> 
> mm/page_owner: add bpf_page_owner_get_memcg_info() kfunc
> 
> This commit exposes per-page memcg information to BPF programs.
> It splits memcg info collection out of print_page_owner_memcg() into
> a new get_page_memcg_info() function and adds the
> bpf_page_owner_get_memcg_info() kfunc.
> 
> Link: https://lore.kernel.org/linux-mm/20261009112308.240769-6-zhen.ni@easystack.cn/
> 
>> diff --git a/mm/page_owner.c b/mm/page_owner.c
>> index 113e4e7e0b3a1..664121be66863 100644
>> --- a/mm/page_owner.c
>> +++ b/mm/page_owner.c
>> @@ -538,16 +538,22 @@ void pagetypeinfo_showmixedcount_print(struct seq_file *m,
> 
> [ ... ]
> 
>> +int get_page_memcg_info(struct page *page, struct memcg_info *info,
>> +			char *buf, int size)
>>   {
>>   	unsigned long memcg_data;
>>   	struct obj_cgroup *objcg;
>>   	struct mem_cgroup *memcg;
>> +	int ret = -ENODATA;
>> +
>> +	*info = (struct memcg_info){};
>>   
>>   	rcu_read_lock();
>>   	memcg_data = READ_ONCE(page->memcg_data);
>> +	if (!memcg_data)
>> +		goto out_unlock;
> 
> [Severity: High]
> Does removing the PageTail() guard here expose a wild pointer dereference?
> 
> In struct folio, the first tail page's _nr_pages field aliases exactly with
> the memcg_data offset when CONFIG_MEMCG is enabled. Due to a lack of memory
> barriers in __update_page_owner_handle(), page_owner_next_eligible() can
> observe PAGE_EXT_OWNER_ALLOCATED before page_owner->order is updated,
> yielding a tail page.
> 
> If a tail page is passed here, the non-zero _nr_pages value (e.g., 512 for a
> large folio) will bypass the !memcg_data check and be dereferenced as an
> obj_cgroup pointer later in the function, leading to a kernel panic.
> 

The `PageTail(page)` check is not removed. get_page_memcg_info() still
reads:

         memcg_data = READ_ONCE(page->memcg_data);
         if (!memcg_data || PageTail(page))
                 goto out_unlock;

Won't fix.
> [ ... ]
> 
>> diff --git a/mm/page_owner_iter.c b/mm/page_owner_iter.c
>> index a2b90c8748520..86e0b4b52bfc7 100644
>> --- a/mm/page_owner_iter.c
>> +++ b/mm/page_owner_iter.c
>> @@ -177,4 +177,21 @@ __bpf_kfunc int bpf_page_owner_stack_snprint(struct page_owner_scan *scan,
>>   				   0);
>>   }
>>   
>> +__bpf_kfunc int bpf_page_owner_get_memcg_info(struct page_owner_scan *scan,
>> +					      struct memcg_info *info__uninit,
>> +					      char *buf__uninit, u32 buf__sz)
>> +{
>> +	/* Guard against the section being offlined after scan. */
>> +	struct page *page = pfn_to_online_page(scan->pfn);
>> +
>> +	if (!page) {
>> +		*info__uninit = (struct memcg_info){};
>> +		if (buf__uninit && buf__sz)
>> +			buf__uninit[0] = '\0';
>> +		return -ENODATA;
>> +	}
>> +
>> +	return get_page_memcg_info(page, info__uninit, buf__uninit, buf__sz);
>> +}
> 
> [Severity: High]
> Is this vulnerable to a time-of-check to time-of-use race with memory
> hot-remove?
> 
> The pfn_to_online_page() check and subsequent get_page_memcg_info()
> dereference occur without holding get_online_mems(). Because this is a
> sleepable BPF kfunc (KF_SLEEPABLE), the thread can be preempted between the
> check and the dereference.
> 
> If memory hot-remove offlines and removes the memory section concurrently, it
> tears down the vmemmap backing the struct page. When the thread resumes and
> get_page_memcg_info() attempts to read page->memcg_data, it will fault on the
> unmapped address.
> 

pfn_to_online_page() here is meant to close a window that the iterator
would otherwise widen, not to fully serialize against memory hot-remove.



Thanks,
Zhen
