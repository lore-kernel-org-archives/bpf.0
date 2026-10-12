Received: from mail-m127173.xmail.ntesmail.com (mail-m127173.xmail.ntesmail.com [115.236.127.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1E07433E9D
	for <bpf@vger.kernel.org>; Mon, 12 Oct 2026 06:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.236.127.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791787426; cv=none; b=Va1B3oL/XA/LBUAbNEQSMCvqH3gT06YyKWU0DUjSdBbsxgtWOB60t8nfJXuxV2nbDlNmdeual5T7J8zaTHY3qXnOPnwDdOQvPVE8AYM7U8mh8MsmC40ln6RH3CLjaJMTssV5B/1GC/H9iEkyfvKqTlRMclgWwmQQ4YXf/OIkzO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791787426; c=relaxed/simple;
	bh=8baN5WdT9Ns03lHdyP4B9CTLzhsBg4von6quIVr0HP4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EubbCZbPAqkNk+S4exFwkczrUDBS2LOEdTtNB6QnG2y/k/VITESsMqevIgsKOyJI3ESL353bgpegpWOelVpyQrx7BPiA9kOgUXTICjgWuOr/38KTzPM0hJ65RPMtd6C88Tua0z/be8xIt9FOktOXXgaiVwFRchaHFmx4iOF8I6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=easystack.cn; spf=pass smtp.mailfrom=easystack.cn; arc=none smtp.client-ip=115.236.127.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=easystack.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=easystack.cn
Received: from [192.168.0.59] (unknown [218.94.118.90])
	by smtp.qiye.163.com (Hmail) with ESMTP id 1ff4c61c7;
	Mon, 12 Oct 2026 14:28:15 +0800 (GMT+08:00)
Message-ID: <d1e7558a-c560-4413-9a48-374a70257d73@easystack.cn>
Date: Mon, 12 Oct 2026 14:28:14 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] mm/page_owner: add bpf_iter target "page_owner"
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20261009112308.240769-1-zhen.ni@easystack.cn>
 <20261009112308.240769-3-zhen.ni@easystack.cn>
 <sashiko-outbox-165432@kernel.org>
From: "zhen.ni" <zhen.ni@easystack.cn>
In-Reply-To: <sashiko-outbox-165432@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa12ecc2c9d0229kunmdcf911e458dbd6
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFJQjdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlCH0pLVk4dS0lPQ0lLH0IfGFYVFA
	kWGhdVGRETFhoSFyQUDg9ZV1kYEgtZQVlJSkNVQk9VSkpDVUJLWVdZFhoPEhUdFFlBWU9LSFVCQk
	lOS1VKS0tVSkJLQlkG


在 2026/10/9 19:50, sashiko-bot@kernel.org 写道:
> Thank you for your contribution! Sashiko AI review found 5 potential issue(s) to consider:
> - [High] mm: vmemmap use-after-free in page_owner_next_eligible() during memory hot-remove
> - [Medium] mm: bpf_iter page_owner skips pages when seq_file buffer fills
> - [Medium] bpf: missing EOF notification for page_owner bpf_iter
> - [Medium] bpf: page_owner_iter skips records during chunked seq_read
> - [Medium] bpf: page_owner_iter lacks EOF notification and yields stale po_snap
> --
> 
> commit fd543af9dd8ff743b641757854c444d98608421d
> Author: Zhen Ni <zhen.ni@easystack.cn>
> Subject: mm/page_owner: add bpf_iter target "page_owner"
> 
> This commit registers a bpf_iter target page_owner that walks the pages
> eligible for page_owner output. The attached BPF program receives the pfn,
> the page, and the page_owner record to filter and format the output.
> 
>> diff --git a/mm/page_owner.c b/mm/page_owner.c
>> index bafe474f33602..eb420803a434a 100644
>> --- a/mm/page_owner.c
>> +++ b/mm/page_owner.c
> [ ... ]
>> @@ -741,7 +717,7 @@ void __dump_page_owner(const struct page *page)
>>    * must advance scan->pfn past the hit before calling again to resume
>>    * the scan.
>>    */
>> -static bool page_owner_next_eligible(struct page_owner_scan *scan)
>> +bool page_owner_next_eligible(struct page_owner_scan *scan)
> 
> [Severity: High]
> Does exposing this function to the BPF iterator API introduce a use-after-free
> regression during memory hot-remove?
> 
> Inside page_owner_next_eligible(), pfn_valid() is used to verify memory
> sections. However, since the iteration runs without holding memory hotplug
> locks or a continuous rcu_read_lock(), the memory section can be
> concurrently hot-removed by another CPU as soon as pfn_valid() returns.
> 
> If the vmemmap pages backing the page struct are unmapped and freed during
> this race, the subsequent call will dereference the unmapped page struct:
> 
> 	page = pfn_to_page(pfn);
> 	if (skip_buddy_pages(&pfn, page))
> 		continue;
> 
> Can this cause a kernel page fault and panic?
> 
> While this logic already existed in the /sys/kernel/debug/page_owner read
> path, this patch relies on it and exposes the buggy code path to the new
> BPF iterator API.
> 

This race is pre-existing and not introduced here, so it might be better
handled in a separate series rather than as part of this change.

>> diff --git a/mm/page_owner_iter.c b/mm/page_owner_iter.c
>> new file mode 100644
>> index 0000000000000..33dc9dcd59dec
>> --- /dev/null
>> +++ b/mm/page_owner_iter.c
> [ ... ]
>> +static void *page_owner_seq_start(struct seq_file *seq, loff_t *posp)
>> +{
>> +	struct page_owner_scan *scan = seq->private;
>> +
>> +	if (*posp == 0)
>> +		scan->pfn = min_low_pfn;
>> +	else
>> +		scan->pfn++;
> 
> [Severity: Medium]
> Can this unconditionally skip elements during chunked reads?
> 
> During a seq_read iteration, if a formatted record overflows the output
> buffer, the iterator discards the overflowed record, returns to userspace,
> and later resumes by calling start() with *posp > 0.
> 
> Since next() already advanced scan->pfn to point to the overflowed record,
> start() increments it again here. Does this mean userspace tools reading
> the iterator output in chunks (like cat or bpftool iter) will silently
> drop one valid page owner record at every buffer chunk boundary?
> 

Will remove the `else scan->pfn++` in page_owner_seq_start().

>> +
>> +	if (!page_owner_next_eligible(scan))
>> +		return NULL;
>> +	return scan->page;
>> +}
>> +
> [ ... ]
>> +static void page_owner_seq_stop(struct seq_file *seq, void *v)
>> +{
>> +}
> 
> [Severity: Medium]
> Are we missing an EOF notification here?
> 
> Standard bpf_iter implementations invoke the BPF program with v == NULL
> during seq_ops->stop() to notify the program of EOF, enabling summary
> aggregate output. Because this function is empty, BPF programs attached to
> the page_owner iterator cannot detect the end of iteration.
> 
> Does this mean any logic relying on the standard EOF signal to output
> summary statistics or perform cleanup will never execute?
> 

page_owner_seq_stop() didn't implement the EOF (v == NULL) run; I'll add
it.

>> +
>> +static int page_owner_prog_seq_show(struct bpf_prog *prog,
>> +				    struct bpf_iter_meta *meta, void *v)
>> +{
>> +	struct page_owner_scan *scan = meta->seq->private;
>> +	struct bpf_iter__page_owner ctx;
>> +
>> +	/* @po: hit-time snapshot, no RCU window needed. */
>> +	ctx.meta = meta;
>> +	ctx.page = (struct page *)v;
>> +	ctx.po = &scan->po_snap;
> 
> [Severity: Medium]
> If EOF were properly signaled with v == NULL, would this unconditional
> assignment provide stale data to the BPF program?
> 
> By unconditionally assigning ctx.po to the snapshot pointer, ctx.po is
> never NULL, even when v (the page) is NULL. Does this mean BPF programs
> cannot reliably use if (!ctx->po) to detect EOF, and might operate on stale
> snapshot data from the last valid page?
> 

That ctx.po issue only arises with the EOF run, so I'll fix both
together.


Thanks,
Zhen
