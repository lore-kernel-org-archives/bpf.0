Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F16D227BF7C
	for <bpf@vger.kernel.org>; Mon, 27 Jul 2026 07:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785137461; cv=none; b=iBAaWK8cyDTPEVqS882oAnSRSKls+nxJUQYmQucFfKbXKVjhpSP3DoeG6yzZGWOXMyF2MUHBwdobfv4zKgHgSKadHU8iEgHdlnfq230Z+Hdpw+VqsOFCNwz3tUrCScseSJ7Ra3CwYhBHYukmM0G6fs1W7KqaNDu/KwGC+AyijTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785137461; c=relaxed/simple;
	bh=ZPJKG+xl4t4TjM2rDqu8w++m594RGqMKLAmZmXGVk+4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HiuTz4XDT5tOQW3fRJ0dzE1kAqIj1nrcCwUM8rAde+aTwf3ATvXeqpZqemxf0DWvCpUzergDH8TSH7EF7U4Vdgsg5QJPDWZQL1moUeRnaWI3lvXVyjh012VtmOsfVb+tQ3BqiASRdnyChQkBMemGcZfrJ/Fz7GHA9pU3VKQPF1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=g3hUekky; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="g3hUekky"
Message-ID: <b45fbc0f-4941-4880-9a4c-7b91198420c0@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1785137447;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qrIWarYcK/axO6Wo8y7UEi0T0ByoE/cV3aU88cAfZlc=;
	b=g3hUekkyxQFZhrPlNOVxjGoGGNscI4PmZnhJ/806OBoFWeT2WV6UeFp9c+O1NllXXTpLYK
	aJQ/da8w5dQF13LYyaHgMilW2rEzvyZHM8irs4rbVXnSnfycdJHNwZmIjZZgqyrPvHXqbv
	9uZ6xqwqKN166FfcBJCIt5esW7ynsGU=
Date: Mon, 27 Jul 2026 15:30:21 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 1/3] bpf: Add a sleepable page allocator for map
 memory
To: sashiko-reviews@lists.linux.dev
Cc: linux-rt-devel@lists.linux.dev, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org
References: <20260727062521.376231-1-jiayuan.chen@linux.dev>
 <20260727062521.376231-2-jiayuan.chen@linux.dev>
 <20260727063709.99F3B1F000E9@smtp.kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <20260727063709.99F3B1F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 7/27/26 2:37 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] NUMA Mempolicy Bypass in bpf_map_alloc_page_sleepable() and __bpf_alloc_page()
> --
>
> --- Patch [1]: [PATCH bpf-next 1/3] bpf: Add a sleepable page allocator for map memory ---
> commit 7a6023ef7f19fc884e94ffe457ae83ff0d4b5e1e
> Author: Jiayuan Chen <jiayuan.chen@linux.dev>
>
> bpf: Add a sleepable page allocator for map memory
>
> This commit introduces bpf_map_alloc_page_sleepable() to provide a blocking
> page allocator for callers known to be in a sleepable context, such as user
> page fault handlers. This avoids the conservative, non-blocking behavior of
> can_alloc_pages() which is always false under PREEMPT_RT.
>
>> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
>> --- a/kernel/bpf/syscall.c
>> +++ b/kernel/bpf/syscall.c
> [ ... ]
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
>>   
>> -	return alloc_pages_node(nid,
>> -				GFP_KERNEL | __GFP_ZERO | __GFP_ACCOUNT
>> -				| __GFP_NOWARN,
>> -				0);
>> +	return alloc_pages_node(nid, BPF_PAGE_GFP, 0);
> [Severity: Medium]
> This isn't a bug introduced by this patch, but does using alloc_pages_node()
> here bypass the task's NUMA mempolicy?
>
> Because alloc_pages_node() ignores task mempolicy, pages might land on the
> current CPU's local NUMA node instead of the node requested by the task.
> Could this branch to use a mempolicy-aware allocation when nid is
> NUMA_NO_NODE?
>
>>   }
> [ ... ]
>> +/*
>> + * For callers that know they run in a sleepable context, e.g. a user page
>> + * fault handler. can_alloc_pages() is a conservative guess made for BPF
>> + * program context - notably it is always false on PREEMPT_RT - so going
>> + * through bpf_map_alloc_pages() there would needlessly pick the
>> + * non-blocking allocator, which never reclaims and never engages the OOM
>> + * machinery.
>> + */
>> +struct page *bpf_map_alloc_page_sleepable(const struct bpf_map *map, int nid)
>> +{
>> +	might_sleep();
>> +	return alloc_pages_node(nid, BPF_PAGE_GFP, 0);
> [Severity: Medium]
> Since this function is intended for user space page fault handlers, will
> unconditionally calling alloc_pages_node() cause the allocation to ignore
> the user task's mempolicy?
>
> Similar to __bpf_alloc_page(), if nid is NUMA_NO_NODE, replacing this with a
> mempolicy-aware allocation might prevent silent performance regressions from
> misaligned memory placement during page faults.
>
>> +}


You remind me. But I don't think this is really about (task) mempolicy.
We should respect map.numa_node/map->numa_node, just like other maps do
when allocating their elements.

