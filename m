Received: from mail-m127101.qiye.163.com (mail-m127101.qiye.163.com [115.236.127.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FEC84398F1
	for <bpf@vger.kernel.org>; Mon, 12 Oct 2026 07:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.236.127.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791789398; cv=none; b=Fccv9dewphWrD6UavyjM3BGQakh2VfYHa6bBA2TRDwqXYxC6UGreVp+AUJAMnKvQu2G7yMPXHEV/9HZwJrXAnx5h5Bg4gTpFmBwc5pO3b+ODeED3lGjcXWp5Tuy37gC0rH+bwemAT+nXlx1MS5epYLyaJqdtyojylS8eJDEL8OY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791789398; c=relaxed/simple;
	bh=Swfzze0oyPNk0q11WcBJrldWQfuQEsFL30ZS9DVbM+8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=liSYaMuwqFjEQUCwpRXh4H6fLA5+DcZ0CfJTtemypVekLzPw26kjbMelkrmd7HSumQ33S13Fiwa2qgcACfXdYFYX9nR3f9WRXenmAVHbFc2f/uLxFKSAjQzHZW0Gt5Nu1OCv3qgshz8g9XsOrEFh51Vj6dkHzWZV+5VnDx72gV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=easystack.cn; spf=pass smtp.mailfrom=easystack.cn; arc=none smtp.client-ip=115.236.127.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=easystack.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=easystack.cn
Received: from [192.168.0.59] (unknown [218.94.118.90])
	by smtp.qiye.163.com (Hmail) with ESMTP id 1ff53ae1d;
	Mon, 12 Oct 2026 15:01:10 +0800 (GMT+08:00)
Message-ID: <d6a4a451-0a6d-415b-a1cb-92d72f345044@easystack.cn>
Date: Mon, 12 Oct 2026 15:01:09 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] mm/page_owner: add bpf_page_owner_get_nid() kfunc
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20261009112308.240769-1-zhen.ni@easystack.cn>
 <20261009112308.240769-5-zhen.ni@easystack.cn>
 <sashiko-outbox-165521@kernel.org>
From: "zhen.ni" <zhen.ni@easystack.cn>
In-Reply-To: <sashiko-outbox-165521@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa12eea4eea0229kunmb8911f515906f0
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFJQjdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkaGR4eVh1DTRpKS0NKQx5JGFYVFA
	kWGhdVGRETFhoSFyQUDg9ZV1kYEgtZQVlJSkNVQk9VSkpDVUJLWVdZFhoPEhUdFFlBWU9LSFVCQk
	lOS1VKS0tVSkJLQlkG


在 2026/10/9 20:20, sashiko-bot@kernel.org 写道:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [High] bpf: arbitrary kernel memory read via page_owner_scan stack aliasing
> - [High] bpf: bpf_page_owner_get_nid() oops on unmapped struct page
> --
> 
> commit 86f6fa9f642d356a9518f6b22fec24555b1e1568
> Author: Zhen Ni <zhen.ni@easystack.cn>
> 
> mm/page_owner: add bpf_page_owner_get_nid() kfunc
> 
> This commit extracts the NUMA node lookup from read_page_owner() into a shared
> page_owner_get_nid() helper. It then exposes this helper to BPF programs via a
> new bpf_page_owner_get_nid() kfunc.
> 
>> diff --git a/mm/page_owner.c b/mm/page_owner.c
>> index eb420803a434a..43a722678accf 100644
>> --- a/mm/page_owner.c
>> +++ b/mm/page_owner.c
> [ ... ]
>> @@ -711,6 +711,19 @@ void __dump_page_owner(const struct page *page)
>>   	page_ext_put(page_ext);
>>   }
>>   
>> +/*
>> + * NUMA node of @page, bypassing PF_POISONED_CHECK() in page_to_nid() to
>> + * avoid VM_BUG_ON on poisoned pages; -1 for poisoned pages.
>> + */
>> +int page_owner_get_nid(struct page *page)
>> +{
>> +	memdesc_flags_t page_flags = READ_ONCE(page->flags);
> 
> [Severity: High]
> Can this trigger a kernel oops on an unmapped struct page?
> 
> The KF_SLEEPABLE flag on bpf_iter_page_owner_next() allows the BPF program to
> be preempted or to explicitly sleep while holding the scan object.
> 
> If memory is hot-removed while the program sleeps, the vmemmap region backing
> the struct page pointer inside the scan object could be unmapped.
> 
> When the program wakes up and calls bpf_page_owner_get_nid(), this raw
> READ_ONCE(page->flags) would dereference the potentially unmapped pointer and
> crash the kernel.
> 
> Should bpf_page_owner_get_nid() use copy_from_kernel_nofault() or BPF probe
> read semantics to safely probe the memory instead?
> 

The pfn->page dereference racing memory hot-remove is pre-existing: the
debugfs read path already does READ_ONCE(page->flags) the same way. But
a standalone sleepable kfunc does widen the window, since the program
can sleep between next() and get_nid() while holding the page pointer.

Rather than harden that kfunc, I'll drop it -- the NUMA node can be
computed inside page_owner_next_eligible() at hit time, while the page
is still valid and inside the walk, and stored in a new scan->nid field.

>> +
>> +	if (page_flags.f == PAGE_POISON_PATTERN)
>> +		return -1;
>> +	return memdesc_nid(&page_flags);
>> +}
>> +
> 
>> diff --git a/mm/page_owner_iter.c b/mm/page_owner_iter.c
>> index 80693d4174077..907517a291443 100644
>> --- a/mm/page_owner_iter.c
>> +++ b/mm/page_owner_iter.c
> [ ... ]
>> @@ -165,4 +165,9 @@ __bpf_kfunc int bpf_page_owner_stack_snprint(depot_stack_handle_t handle,
>>   	return stack_depot_snprint(handle, buf, buf_size, 0);
>>   }
>>   
>> +__bpf_kfunc int bpf_page_owner_get_nid(struct page_owner_scan *scan)
>> +{
>> +	return page_owner_get_nid(scan->page);
>> +}
> 
> [Severity: High]
> Is there a risk of an arbitrary kernel memory read here?
> 
> Because the scan object physically resides on the BPF program's stack (as
> returned by bpf_iter_page_owner_next()), a BPF program can overwrite the
> scan->page pointer with an arbitrary kernel address using normal BPF stack
> pointers (PTR_TO_STACK).
> 
> If the program then passes the aliased PTR_TO_BTF_ID to
> bpf_page_owner_get_nid(), wouldn't this kfunc blindly dereference the forged
> pointer, bypassing verifier safety checks?
> 

See the message above for the fix.


Thanks,
Zhen

