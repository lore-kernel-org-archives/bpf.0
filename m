Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9600495033
	for <bpf@vger.kernel.org>; Thu,  3 Sep 2026 12:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788438695; cv=none; b=pnVH7jvvZuNAbEjXbnLfmLC7oECAclNfGQQg2u9kN6QDEpMqkuXeH7+KXCxkf+kOz5/XaS1vdOFM+YRtL83ZdZAE3nEQ3pTW0ssSiSuw/bO34KDpCCd0uoS0woje+G4Awmno9yuiCmV0iom9aWp1LITNtJXw8egGnmh6We3lWxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788438695; c=relaxed/simple;
	bh=mhHD0CPBpfs0DvkuTjmhLU3Yrtcut48RhRGVtfcbpS0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jdSTkQe12WSYxbNs2lyVxIGfLXsQqrdSJ6FRV3LfcMjUkgPGcsCX6oh6Fty2zhNJLMlwcZ5Sn7uhcumavV/96+AiPu14HwT86YvJ/Myxs8BGhZIGjX/2A3OAruSG5AnJ6dpRPTdh5kP/8ZKW+6vc3eqM1hvGPSxaV2BMIoWHBMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=hp+WsyBO; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="hp+WsyBO"
Received: from mail01.layka.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id A1857881F7;
	Thu, 03 Sep 2026 14:31:30 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 408N1pBPQgA5; Thu,  3 Sep 2026 14:31:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1788438689; bh=mhHD0CPBpfs0DvkuTjmhLU3Yrtcut48RhRGVtfcbpS0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=hp+WsyBOEFCkGeDjHWZg/mSr0h1n1+Tbi8Osvx7/cUxo1ilVkY1KC5naydx5Zo7eb
	 zWRcBbUQcj7eiz7rKQK1NsNaqMPjw8j2iCavclxun4SFoqO3+2kjUvZg66iWEcPvs9
	 v3oVgoWGzoOgwI3T/uX8Y52emO+84Die2721UI9EU1yhvB16wiuK9sLm4L2NyazXVn
	 zoIzjVOXRn9C4hOsnObT/lC4Uvy8CPVIUnNzRLZ1qaYeitSopmjxyvwXOESswK6uA6
	 OuEiU3zT/KjRF0ipUp8xYeIPZ318z3DZX8/pCai7o3YaF2690Op96sZqc8OUVXBCBR
	 kJo6W30HTBJ6g==
Message-ID: <092ced27-06b8-4dad-b746-5c4585b61d13@disroot.org>
Date: Thu, 3 Sep 2026 13:31:07 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] bpf: Fix u32 overflow issue in map batch operations
To: bpf@vger.kernel.org
Cc: andrii@kernel.org, eddyz87@gmail.com, ast@kernel.org,
 daniel@iogearbox.net, memxor@gmail.com, martin.lau@linux.dev,
 song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org,
 emil@etsalapatis.com, ihor.solodrai@linux.dev, john.fastabend@gmail.com,
 brianvv@google.com, sashiko-reviews@lists.linux.dev, maghasi@disroot.org
References: <20260902204439.287888-1-maghasi@disroot.org>
 <20260903082734.623904-1-maghasi@disroot.org>
 <20260903084533.E78781F000E9@smtp.kernel.org>
Content-Language: en-US
From: Masoud Aghasi <maghasi@disroot.org>
In-Reply-To: <20260903084533.E78781F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 03/09/2026 09:45, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [Critical] Missing size_t casts in queue_stack_maps.c cause pointer arithmetic to overflow u32, corrupting map data.
> - [High] qs->size is typed as u32, which can silently overflow to 0 when max_entries is U32_MAX.
> --
> 
> commit aa1d0d53f1c01402c01cb62c0b2ef581ca4869bd
> Author: Masoud Aghasi <maghasi@disroot.org>
> 
> bpf: Fix u32 overflow issue in map batch operations
> 
> This patch fixes a u32 overflow in several map batch operations that can occur
> when the map size exceeds 4GB. It adds size_t casts to prevent the offset and
> size calculations from overflowing during memory operations.
> 
>> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
>> index 6874ba1424af0..731388ae00ad1 100644
>> --- a/kernel/bpf/syscall.c
>> +++ b/kernel/bpf/syscall.c
> [ ... ]
>> @@ -2179,12 +2179,12 @@ int generic_map_lookup_batch(struct bpf_map *map,
>>  		if (err)
>>  			goto free_buf;
>>  
>> -		if (copy_to_user(keys + cp * map->key_size, key,
>> +		if (copy_to_user(keys + (size_t)cp * map->key_size, key,
>>  				 map->key_size)) {
>>  			err = -EFAULT;
>>  			goto free_buf;
>>  		}
>> -		if (copy_to_user(values + cp * value_size, value, value_size)) {
>> +		if (copy_to_user(values + (size_t)cp * value_size, value, value_size)) {
>>  			err = -EFAULT;
>>  			goto free_buf;
>>  		}
> 
> [Severity: Critical]
> This is a pre-existing issue, but since this patch fixes u32 overflows for
> map element offsets, could we also address similar overflows in
> queue_stack_maps.c?
> 
> If a queue or stack map is created where the capacity (max_entries *
> value_size) exceeds 4GB, do these calculations wrap the element offset when
> head, tail, or index counters multiply with map.value_size?
> 
> kernel/bpf/queue_stack_maps.c:__queue_map_get() {
>     ...
>     ptr = &qs->elements[qs->tail * qs->map.value_size];
>     ...
> }
> 
> kernel/bpf/queue_stack_maps.c:__stack_map_get() {
>     ...
>     ptr = &qs->elements[index * qs->map.value_size];
>     ...
> }
> 
> kernel/bpf/queue_stack_maps.c:queue_stack_map_push_elem() {
>     ...
>     dst = &qs->elements[qs->head * qs->map.value_size];
>     ...
> }
> 
> [Severity: High]
> This is also a pre-existing issue, but I noticed a potential truncation 
> when allocating these maps:
> 
> kernel/bpf/queue_stack_maps.c:queue_stack_map_alloc() {
>     ...
>     qs->size = size;
>     ...
> }
> 
> If a user allocates a queue or stack map with max_entries set exactly to
> U32_MAX, the required size calculation (u64)attr->max_entries + 1 evaluates
> to 0x100000000. Because qs->size is typed as u32, does this assignment
> silently truncate the size to 0, resulting in a map that behaves like it has
> 0 capacity?
> 

These issues are already fixed by commit:
802a30c5db72 ("bpf: Fix queue/stack map u32 index overflow")

