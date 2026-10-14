Received: from mail-m12772.qiye.163.com (mail-m12772.qiye.163.com [115.236.127.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B76E376469
	for <bpf@vger.kernel.org>; Wed, 14 Oct 2026 08:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.236.127.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791965692; cv=none; b=IQ4LaUhJ/1DGY8yWbCkE96pglElfX63Ga8O78dKT9S15GY4w1Sn+vPfLrab3XgnMCkZbAHDgT1RMYd8u6hJHRk46+adXpiBy1XWz4isFhGaD0mUiQWm1YuwxJ445R8CVe0jRCSdJhndZfGle6XjJdLUHUAptVDGkKrt48APKKvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791965692; c=relaxed/simple;
	bh=5NxZ3jqPtSVvxlH3v7WZVAP9ycsJzX19jO5a6ZOv88A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uj7NBI5vIJBBGIvRd5cHdv1zy4xdQzqvjcb66zFE9UU1ulAKAMW4Pa8G3LyH4PQGEZ5jv5/W1rJL1NGMuHLIowbSDwDvwgz0t0gmicUFp4idj5wPKb6tnySy9Etw29Ijsbplokl5EcCSJ/Va5w2rRCWroRW5keph4pvzK0cSMKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=easystack.cn; spf=pass smtp.mailfrom=easystack.cn; arc=none smtp.client-ip=115.236.127.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=easystack.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=easystack.cn
Received: from [192.168.0.59] (unknown [218.94.118.90])
	by smtp.qiye.163.com (Hmail) with ESMTP id 200c960fd;
	Wed, 14 Oct 2026 15:39:15 +0800 (GMT+08:00)
Message-ID: <f3b6f574-197c-4c19-94dc-463eef134236@easystack.cn>
Date: Wed, 14 Oct 2026 15:39:15 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/6] mm/page_owner: record the NUMA node in the scan
 cursor
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20261013122125.843451-1-zhen.ni@easystack.cn>
 <20261013122125.843451-5-zhen.ni@easystack.cn>
 <sashiko-outbox-169722@kernel.org>
From: "zhen.ni" <zhen.ni@easystack.cn>
In-Reply-To: <sashiko-outbox-169722@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa13959e6a90229kunm9f52cc4343f02
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFJQjdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlDSUMYVhkfQ0MdSUNMHkIYQlYVFA
	kWGhdVGRETFhoSFyQUDg9ZV1kYEgtZQVlJSkNVQk9VSkpDVUJLWVdZFhoPEhUdFFlBWU9LSFVCQk
	lOS1VKS0tVSkJLQlkG


在 2026/10/13 20:36, sashiko-bot@kernel.org 写道:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] mm: incomplete fix leaves page_owner vulnerable to unmapped page dereference
> --
> 
> commit 7b174b26adeea5712aaa10bd465514b5ce7dbe36
> Author: Zhen Ni <zhen.ni@easystack.cn>
> Subject: mm/page_owner: record the NUMA node in the scan cursor
> 
> This commit computes the page's NUMA node in page_owner_next_eligible()
> and stores it in the scan cursor to avoid dereferencing a potentially
> unmapped page later. It updates the debugfs nid filter and BPF program
> to use this stored node value.
> 
>> diff --git a/mm/page_owner.c b/mm/page_owner.c
>> index 617346a4ab22a..113e4e7e0b3a1 100644
>> --- a/mm/page_owner.c
>> +++ b/mm/page_owner.c
> [ ... ]
>> @@ -810,18 +824,8 @@ read_page_owner(struct file *file, char __user *buf, size_t count, loff_t *ppos)
>>   	/* Find an allocated page */
>>   	while (page_owner_next_eligible(&scan)) {
>>   		if (state->nid_filter_enabled) {
>> -			int nid;
>> -			memdesc_flags_t page_flags =
>> -				READ_ONCE(scan.page->flags);
>> -
>> -			/*
>> -			 * Bypass PF_POISONED_CHECK() in page_to_nid() to avoid
>> -			 * VM_BUG_ON when accessing poisoned pages.
>> -			 */
>> -			if (page_flags.f == PAGE_POISON_PATTERN)
>> -				goto skip_continue;
>> -			nid = memdesc_nid(&page_flags);
>> -			if (!node_isset(nid, state->nid_filter))
>> +			if (scan.nid < 0 ||
>> +			    !node_isset(scan.nid, state->nid_filter))
>>   				goto skip_continue;
>>   		}
>>   
> 
> [Severity: High]
> Does this fix leave scan.page vulnerable to an unmapped page dereference
> shortly after this block?
> 
> Although this patch successfully avoids dereferencing scan.page when checking
> the node filter, page_owner_next_eligible() drops the RCU lock via
> page_ext_put() before returning.
> 
> Just below the quoted block in read_page_owner(), scan.page is still
> passed directly to print_page_owner():
> 
> read_page_owner() {
>      ...
>      while (page_owner_next_eligible(&scan)) {
>          ...
>          return print_page_owner(buf, count, scan.pfn, scan.page,
>                                  &scan.po_snap, scan.po_snap.handle, state);
>      ...
> }
> 
> Inside print_page_owner(), the pointer is dereferenced by scnprintf using
> the %pGp formatter on &page->flags.f.
> 
> If a concurrent memory hot-remove operation frees the vmemmap backing this
> struct page after the RCU lock is dropped, will this %pGp format access
> trigger a kernel panic?
> 
> Additionally, a follow-up patch in this series (Patch 5) appears to introduce
> get_page_memcg_info() which also unconditionally dereferences scan.page
> outside the RCU lock from read_page_owner(). Does that face the same
> use-after-free risk?
> 

The page_ext RCU lock does not pin the underlying struct page. The 
dereference
in print_page_owner() predates this series and is not introduced by these
changes.



Thanks,
Zhen

