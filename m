Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11E602571DA
	for <bpf@vger.kernel.org>; Mon, 23 Feb 2026 19:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771874813; cv=none; b=TS/fc11qwm821XQpXdpC49XKPj5UKEElqPra1bpI3t6F6irPnUmSIspCLisHfDf9+Z5nwxtDN6JuFRYQu9dG6jE0QAIn14JdwlcPrMWE8RTol0GiqTaCJpyr6itx29OqVv60SG600hs/Fk+QOPdyWfxi6q7weyFqSmk4axr5K44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771874813; c=relaxed/simple;
	bh=iyUHJHHbHiMnzC56ZuEuiuqfucnJnkY+drjiYAnTIgg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aL5ruVxMN/YyDHTwcXr7gHiov+DPIHg6lc9ZR8tHj5EL3SUQHqrWb1J8zevV8kwJE44LtQJ1hPo/oqksQnZ3mc578trHWMiynFSvbJtMRn+9RVGF0zzhAhFUUA425tGfagrrbHOnmorXGerv/lhZOxBrTz7SNmbL7/RNEbRoVfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=GqyEYsOS; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="GqyEYsOS"
Message-ID: <e0f16c6c-cd9f-4881-b638-c52c8a83104e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1771874809;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V9BhDXbDb+yH2yMv7tSmQcdqgxwb0xNI6HvhXw+0pJk=;
	b=GqyEYsOSVJ+fZLS0D5M9huUiqM4Y0iGXDBZtVWi77s/fw1BmvRPJGL9OfzOGY0K6124x2p
	eLi8cVXXOz92G54rvU6KCI8LiCKigEfRCKDXiaWnXcHeiupxtdISiXP45l3dsEPa2IzCVR
	iec3DqYk57Y2BLyPZW+Z60y701oYYJo=
Date: Mon, 23 Feb 2026 11:26:13 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [LSF/MM/BPF TOPIC] BPF local storage for every packet
To: Jakub Sitnicki <jakub@cloudflare.com>
Cc: bpf@vger.kernel.org, kernel-team@cloudflare.com,
 lsf-pc@lists.linux-foundation.org
References: <87ecmffopy.fsf@cloudflare.com>
 <5fdee5fd-aff1-4764-820e-3b1f3ad00941@linux.dev>
 <877bs6fc25.fsf@cloudflare.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <877bs6fc25.fsf@cloudflare.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 2/21/26 5:42 AM, Jakub Sitnicki wrote:
> On Fri, Feb 20, 2026 at 10:34 AM -08, Martin KaFai Lau wrote:
>> On 2/20/26 6:56 AM, Jakub Sitnicki wrote:
>>> In the upcoming days we are going to post an RFC which proposes to
>>> extend the concept of BPF local storage to socket buffers (sk_buff, skb)
>>> as means to attach arbitrary metadata to packets from BPF programs [1]
>>> (slides 41-55).
>>> Design wise, BPF local storage is a great fit for a packet metadata
>>> container, as it that avoids some of the shortcoming of the the XDP
>>> metadata interface:
>>> 1. Users interact with storage through BPF maps and can take advantage
>>>      of existing built-in BPF map types, while still being able to
>>>      implement a custom data format,
>>> 2. Maps within local storage can have different properties controlled by
>>>      map flags. For example, maps with BPF_F_CLONE set can survive packet
>>>      cloning. Other flags could allow map contents to survive sk_buff
>>>      scrubbing during encapsulation/decapsulation or pass across network
>>>      namespace boundaries.
>>> 3. Local storage supports multiple users out of the box - each user
>>>      creates their own map, eliminating the need to coordinate data
>>>      layout,
>>> 4. Local storage has its own backing memory, so persisting it across
>>>      network stack layers requires no changes to the network stack.
>>> However, this flexibility comes at a cost. While XDP metadata requires
>>> no allocations [2], an initial write to BPF local storage requires two:
>>> one for bpf_local_storage_elem, and one for bpf_local_storage itself.
>>> We would like to align this work with the needs of other BPF local
>>> storage users (socks, cgroups, tasks, inodes), where allocation overhead
>>> has been a concern as well [2].
>>> Optimization ideas we would like to put up for discussion:
>>> - slimming down bpf_local_storage so it can be embedded as an skb
>>>     extension chunk,
>>> - making the bpf_local_storage cache size configurable,
>>> - allowing bpf_local_storage to be pre-allocated,
>>> - co-allocating bpf_local_storage and bpf_local_storage_elem for the
>>>     single-map case.
>>
>> The sk/cgroup/task storage has a much longer lifetime. Meaning once allocation
>> is done, the storage stays in the sk until the sk is closed. The length of
>> lifetime is quite different from the skb. I am afraid we are re-purposing
>> bpf_local_storage for a very different use case where skb lifecycle is much
>> shorter.
>>
>> We are planning to increase the 'sizeof(struct sock)' for perf reason. Saving an
>> allocation is an upside but not the major one we are looking (or care) for
>> sk. We are more looking for cacheline efficiency and probably remove the need
>> for bpf_local_storage[_elem] if the user chooses to use the in-place spaces of a
>> sk.
>>
>> If 'sizeof(struct sk_buff)' can be increased, this should align on where sk
>> local storage is going. If skb will solely depend on the existing
>> bpf_local_storage and has no plan to raise sizeof(struct sk_buff) for perf
>> purpose, the existing bpf_local_storage may be the wrong place to
>> repurpose/optimize because the lifecycle of skb is very different.
> 
> The lifetime difference is undeniable, but I still see common ground.
> To make it more concrete:
> 
> 1. IIRC you've mentioned wanting more bpf_local_storage->cache entries
>     for socks in some scenarios, while for skbs I'd expect we need
>     fewer. We could make the cache size configurable via a flexible
>     array.
> 
> 2. Embedding bpf_local_storage is another overlap I had in mind. For
>     socks that in within the same memory blob as struct sock, while for
>     skbs we'd want to embed it in skb_ext (once it's small enough). This
>     depends on whether you end up dropping bpf_local_storage for
>     sk_local_storage entirely, which I didn't know about until now.

For the in-place sk storage, it should not need the bpf_local_storage 
and the bpf_local_storage_elem. A stable map_xyz->sk_offset should be 
enough. If a storage is needed for all sk, the bpf prog should use the 
in-place sk storage instead of going through the bpf_local_storage[_elem].

imo, if we manage to pull out a new solution (whatever that is) for skb 
but does not perform close to the skb->data_meta, it is probably hard to 
use in production. I could be wrong but I don't see how embedding 
local_storage and/or shrink the cache can get there. I think we need 
another solution/design.

> 
> 3. I've heard the idea of allocating skb_ext memory together with
>     sk_buff was floated in the past. While trimming skb_ext at build-time
>     is hard today — say I need XFRM but don't care about crypto offloads
>     keeping state in skb_ext — the idea is similar to what you're
>     proposing for struct sock.

