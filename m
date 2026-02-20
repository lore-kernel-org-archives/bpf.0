Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD4BE223702
	for <bpf@vger.kernel.org>; Fri, 20 Feb 2026 18:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771612458; cv=none; b=aUy6jHg8kIXoUtonZxBusWN79O3afsDNpGP9SjqVW1svOshcUCdLitiNOR+/wZ3uANztM7cmQZacKNKA8JWfcblZieQ2MeUuqZG/RR2Pib3pCjvOAJQ8N40v/0/5OPdPTYohh/V8FhBdikcWM0kfWvw/E4oy/ouZv61mjlNzql0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771612458; c=relaxed/simple;
	bh=7fFboDtHFza8pMHIPa5EiZf2os8gnU4vNFnuiWBqX48=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hYaeih+vXUZ1oo8k4xT4SFq0PYs2ppRyVuZiZ0j5Pwi7eUcNC+b4qX0waS3Ez+s7f26Ob+UC4k3q3eWvaSBZ7dumLTvyZfGlh670iRg2kuMAkmPxZSmtuyaEsfRH871nyVnplzj/E6m3ep5661x+C9uB4mY5itX7CHxCmNeXAtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=L9XW445U; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="L9XW445U"
Message-ID: <5fdee5fd-aff1-4764-820e-3b1f3ad00941@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1771612453;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EcxT8imdMfZkikPDM0dfVYGxwygSXNnJNQIDYYcR5tc=;
	b=L9XW445UXq7HLi3ZcLb7UqfFOyeMnNhe0yORsiITLzZ5wZm3ctdrQTYDOszzaiZa1eF637
	AQPcUXyLdcTtLzME6p0XtI5/TTOy4YOhOMLOFlTLiBnYJZONCrNdmJf/pHwV58pByB7ZCT
	dJs1kuXow+83ybW0fYyo1EzeKZa/EOY=
Date: Fri, 20 Feb 2026 10:34:09 -0800
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
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <87ecmffopy.fsf@cloudflare.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2/20/26 6:56 AM, Jakub Sitnicki wrote:
> In the upcoming days we are going to post an RFC which proposes to
> extend the concept of BPF local storage to socket buffers (sk_buff, skb)
> as means to attach arbitrary metadata to packets from BPF programs [1]
> (slides 41-55).
> 
> Design wise, BPF local storage is a great fit for a packet metadata
> container, as it that avoids some of the shortcoming of the the XDP
> metadata interface:
> 
> 1. Users interact with storage through BPF maps and can take advantage
>     of existing built-in BPF map types, while still being able to
>     implement a custom data format,
> 
> 2. Maps within local storage can have different properties controlled by
>     map flags. For example, maps with BPF_F_CLONE set can survive packet
>     cloning. Other flags could allow map contents to survive sk_buff
>     scrubbing during encapsulation/decapsulation or pass across network
>     namespace boundaries.
> 
> 3. Local storage supports multiple users out of the box - each user
>     creates their own map, eliminating the need to coordinate data
>     layout,
> 
> 4. Local storage has its own backing memory, so persisting it across
>     network stack layers requires no changes to the network stack.
> 
> However, this flexibility comes at a cost. While XDP metadata requires
> no allocations [2], an initial write to BPF local storage requires two:
> one for bpf_local_storage_elem, and one for bpf_local_storage itself.
> 
> We would like to align this work with the needs of other BPF local
> storage users (socks, cgroups, tasks, inodes), where allocation overhead
> has been a concern as well [2].
> 
> Optimization ideas we would like to put up for discussion:
> - slimming down bpf_local_storage so it can be embedded as an skb
>    extension chunk,
> - making the bpf_local_storage cache size configurable,
> - allowing bpf_local_storage to be pre-allocated,
> - co-allocating bpf_local_storage and bpf_local_storage_elem for the
>    single-map case.

The sk/cgroup/task storage has a much longer lifetime. Meaning once 
allocation is done, the storage stays in the sk until the sk is closed. 
The length of lifetime is quite different from the skb. I am afraid we 
are re-purposing bpf_local_storage for a very different use case where 
skb lifecycle is much shorter.

We are planning to increase the 'sizeof(struct sock)' for perf reason. 
Saving an allocation is an upside but not the major one we are looking 
(or care) for sk. We are more looking for cacheline efficiency and 
probably remove the need for bpf_local_storage[_elem] if the user 
chooses to use the in-place spaces of a sk.

If 'sizeof(struct sk_buff)' can be increased, this should align on where 
sk local storage is going. If skb will solely depend on the existing 
bpf_local_storage and has no plan to raise sizeof(struct sk_buff) for 
perf purpose, the existing bpf_local_storage may be the wrong place to 
repurpose/optimize because the lifecycle of skb is very different.

> [1] https://fosdem.org/2026/schedule/event/DSC9L3-rich-packet-metadata/
> [2] Assuming sufficient free headroom in the skb linear buffer.
> [3] http://msgid.link/ad835a9b-e544-48d3-b6e2-ffe172fcfa6d@linux.dev
> 

