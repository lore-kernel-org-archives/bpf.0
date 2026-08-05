Received: from out-182.mta1.migadu.com (mta1.migadu.com [37.59.57.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B26DC3F9294
	for <bpf@vger.kernel.org>; Wed,  5 Aug 2026 10:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.59.57.117
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785926226; cv=none; b=k+mWuBys5edSDb62zvHQEuZGXuMNj1Jrw1fkWjMwoyRlejwgIbJLj7hs+wkxYnidqHFLghClnWTz9zkhvQkZjNwW7O//SqAQhHpx1iqSpny4zzUSdaTB5j11ZnviROOtDVxspWii3Rr5PNdqcTv99TXDO+sAjTcmcaqv5o8qv7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785926226; c=relaxed/simple;
	bh=LS35LYkQCpQBh79iSZYLFW/+ZVWWpIVo8XtgcNbLroU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V06x6O0bg4WQ50djk+NC5C3TTsDEPhf73cPOfiGiJjbc0257V9xosFoQEoKMxpSbNuY325I2Yt7uuo9TdORZfnjHMOnXAwdWb3QEFcNyAzs80dCkbDWUc9Luhjb4VCnYxs/u6+m2rcWI3JE8ss+hsyy28BDRV22qrQhOS+EvUeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=iuafqLkX; arc=none smtp.client-ip=37.59.57.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="iuafqLkX"
Message-ID: <48cf25f3-3f8a-4a42-a902-7d87d9dafcd8@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1785926211;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fdMzOHfWVKaOlnzPa/ucwOQRBf5ESDgDzD6GRAtvHGY=;
	b=iuafqLkXTS9dOqZtfWxcnvqVywZRIvlGLzzVM9FjieC7Y061NuPVtJgN6ifBCFlkoblbLH
	3KcJaKhkPESmeG+EQzU2tWKGdEiocIC6SX9FTNaqJRfubUwVluDa1hqHGDoqxR3hfB06dR
	B/ULHEjscoxJ4wWD82ZsuX93LQqDd3Q=
Date: Wed, 5 Aug 2026 18:36:30 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 1/4] bpf: Add a sleepable page allocator for
 map memory
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org, linux-rt-devel@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20260805091720.139924-1-jiayuan.chen@linux.dev>
 <20260805091720.139924-2-jiayuan.chen@linux.dev>
 <20260805093251.636CC1F00A3A@smtp.kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <20260805093251.636CC1F00A3A@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 8/5/26 5:32 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
>
> New issues:
> - [High] Using __GFP_ZERO to zero pages intended for user-space mapping skips required dcache flushes on cache-aliasing architectures.
> - [Medium] bpf_map_alloc_page_sleepable() and __bpf_alloc_page() silently bypass task/VMA NUMA mempolicy when the requested node is NUMA_NO_NODE.
>
> Pre-existing issues:
> - [High] The fallback allocation path in __bpf_alloc_page() omits __GFP_ZERO, returning uninitialized kernel memory that can be exposed to user space.
> --
>
> --- Patch [1]: [PATCH bpf-next v2 1/4] bpf: Add a sleepable page allocator for map memory ---
> commit 2a4210c942ca919834ce20218ab8bedc6cbb40a8
> Author: Jiayuan Chen <jiayuan.chen@linux.dev>
>
> bpf: Add a sleepable page allocator for map memory
>
> This patch adds bpf_map_alloc_page_sleepable() to provide a blocking page
> allocator for sleepable contexts. This avoids using the non-blocking
> allocator, which never reclaims or engages the OOM machinery, for contexts
> that can actually sleep.
>
>> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
>> index 8d111da886553..67d8157c6623e 100644
>> --- a/kernel/bpf/syscall.c
>> +++ b/kernel/bpf/syscall.c
>> @@ -602,15 +602,14 @@ static bool can_alloc_pages(void)
>>   		!IS_ENABLED(CONFIG_PREEMPT_RT);
>>   }
>>   
>> +#define BPF_PAGE_GFP (GFP_KERNEL | __GFP_ZERO | __GFP_ACCOUNT | __GFP_NOWARN)
>> +
>>   static struct page *__bpf_alloc_page(int nid)
>>   {
>>   	if (!can_alloc_pages())
>>   		return alloc_pages_nolock(__GFP_ACCOUNT, nid, 0);
> [Severity: High]
> This is a pre-existing issue, but does this fallback path leak uninitialized
> kernel memory?
>
> The call to alloc_pages_nolock() passes only __GFP_ACCOUNT and completely
> omits __GFP_ZERO. If a BPF map is allocated on PREEMPT_RT where
> can_alloc_pages() returns false, this could expose uninitialized pages to
> user space.


Not ture.

alloc_pages_nolock::alloc_frozen_pages_nolock_noprof append __GFP_ZERO 
to alloc_gfp by default.


>>   
>> -	return alloc_pages_node(nid,
>> -				GFP_KERNEL | __GFP_ZERO | __GFP_ACCOUNT
>> -				| __GFP_NOWARN,
>> -				0);
>> +	return alloc_pages_node(nid, BPF_PAGE_GFP, 0);
> [Severity: Medium]
> When nid is NUMA_NO_NODE, does alloc_pages_node() bypass the task's NUMA
> mempolicy?
>
> Since alloc_pages_node() automatically resolves NUMA_NO_NODE to the local
> CPU node rather than defaulting to the task's mempolicy, this could cause
> pages to land on the wrong nodes for user applications.


Already replied to v1.

This matches every other bpf map allocation via alloc_pages_node(); none 
honor the task mempolicy.

>>   }
>>   
> [ ... ]
>> @@ -636,6 +635,20 @@ int bpf_map_alloc_pages(const struct bpf_map *map, int nid,
>>   	return ret;
>>   }
>>   
>> +/*
>> + * For callers that know they run in a sleepable context, e.g. a user page
>> + * fault handler. can_alloc_pages() is a conservative guess made for BPF
>> + * program context - notably it is always false on PREEMPT_RT - so going
>> + * through bpf_map_alloc_pages() there would needlessly pick the
>> + * non-blocking allocator, which never reclaims and never engages the OOM
>> + * machinery.
>> + */
>> +struct page *bpf_map_alloc_page_sleepable(const struct bpf_map *map)
>> +{
>> +	might_sleep();
>> +	return alloc_pages_node(map->numa_node, BPF_PAGE_GFP, 0);
> [Severity: High]
> Does using __GFP_ZERO (via BPF_PAGE_GFP) skip required dcache flushes on
> cache-aliasing architectures?
>
> When allocating pages destined for user-space mapping (like the arena page
> fault handler), __GFP_ZERO uses clear_page() which leaves zeros in the
> kernel's dcache. Could user processes reading from these pages see stale,
> uninitialized physical memory instead of zeros?


The patch doesn't change zeroing, we already used  __GFP_ZERO before.


I asked claude to check the review and it told me the review was 
overthinking:

     no arena-capable arch selects ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE, so 
flush_dcache_page()
     is a no-op and there's no aliasing concern.

But I think this needs to be remembered.


> [Severity: Medium]
> Similar to the issue in __bpf_alloc_page(), does using alloc_pages_node()
> here bypass the task mempolicy when map->numa_node is NUMA_NO_NODE?
>
>> +}
>> +
