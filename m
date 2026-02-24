Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EF2E3806B1
	for <bpf@vger.kernel.org>; Tue, 24 Feb 2026 11:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771934293; cv=none; b=OL3vkjohC+g62YyugOnt/DfUXI21SouhgFPaHKTMQCVZQdRVeGBzx+AyohZ5xyLAsctGUJizqCWhIeyS7QbBPcb0htkIY4PTogH10h9crdoZiHLIusUkTldAXtbIXTV7eh+fK8dnhOMbaHQNDu8yGdk8iAvWTQsnS6lWPCmHYNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771934293; c=relaxed/simple;
	bh=wkT0q5bbLZPuGs2df1U8lxsgVSmGPx80wqb8rK16ggU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ILag7Bt+66meZmQDnBwkHm1KiO+Vi6xEE/35xJgJPYfETZwLTkp1d/tk3HEgoYpnnkh7M65oo+xqUDDLWfW4G/PQ665wVo7gYDjAtn9rqL7+dsUfkXfjixkRv2wiMGU+x56eeSly8Rc0k1puTY7EJT3KlmnRfb5shRLIeOj7qpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=SZyGdrW5; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="SZyGdrW5"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b8f86167d39so689299166b.0
        for <bpf@vger.kernel.org>; Tue, 24 Feb 2026 03:58:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1771934290; x=1772539090; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=xA4pRqrCSI2pf0oHQ8r+dNVq4irSpfaRvf4AX1ii1/8=;
        b=SZyGdrW5glA5qits2+T3iCN9jjmQS8udFMugTukOwR/cH32w7zco9Txxpqv0IQlOnA
         AABFDNt9B2ojIbQEoZ7e+Sw5oh9cipz/wXuxRHklTp+jMP4m8O2KRtxTiIlFJtSRP+xk
         f0OIAGRMVmFyZPcVqHDhaU6r9f4btj5MfiWgykQod6mYtB79TNWqt2MAxRyi7KVdr4Vw
         wM6bFjUGDRJosQkwO0Cm41Enj36mA9Ab4OTIt+zI5iGMcj1xQfMM6J3XAXjwLvv+ysg9
         XbyRftD8TibfVdzki3CDsovJCbZD3Z0XHfJtW6YOdIE2tAdYWtT74DODZu0Bz4b3FiR1
         h/kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771934290; x=1772539090;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xA4pRqrCSI2pf0oHQ8r+dNVq4irSpfaRvf4AX1ii1/8=;
        b=JTlDH5E7ZS7fqa+RAUF+s0T3iBZcYtv2KZS0NKdz+XHd6JRPVBgENajjdEW9r4GT6t
         283f4TKNBJL95zFwRh8Ag1cgq9GTgkyCgOhQwIKetfDjgaenH7rUZWvCayHFXS75q7NI
         G1ElfvI/zJvORocNzSSgLgbdNKpbQ4aYbQzXtfWoYMzfL5PNVx1EoTPeP2K3jrilh/IX
         9L6sV5910HIDWp1pzP6NgO5S7aw139iwTvvRDICEqaAQT4P0sHGXGoXBvfVhYcNF2mLK
         n8IV2x93BnLHOZK4TY7sH828Dyir7GQzJwRSDpUQ1KOKY65JDtoeKJqzia9Ba+x33gqh
         m9SA==
X-Gm-Message-State: AOJu0Yx4F9LrkRsundGW8HMp5Qu2iRuIXuTXrBfGcheCH67QjHGLTXvD
	AoDo0namAx/f5n0gV2htTAZ1sW9BgBCEI5hTI+aP4lhP0KM9aiIzcMMlRkVh2fGUBBP5374Ok1p
	UhWVAMxC4Rg==
X-Gm-Gg: ATEYQzz1WjO6acoorrtiXehJtam5D+K+S6fmZthap/VE1mNGwP7JJxwGkxpYu9sxWgs
	6+aHNOTtVXCLxm3TZqeMOuDKSZPKKz+P1hz8osGELvy3054MUOt2FQsKDeCr2+kAzViW8dYxkhv
	ugxJJA9O6zhStcqGUgeEqoEltjs12aEXTEwuKVVHimb0+yPZgA0PjWssCX9/Ga7kB50u9g6pgGG
	HGokUUSH+imx9ZuK9YZgUHnTM4o2Vw7Zzq/AxgXsymwWFiScp0p5z3vazw3V2zGS7lbbhmnhJ5s
	sH2D68wxRD/0asrmVMLN3ECKSDH5BolXJO0n5Vf8NxJj6CaLw46x8Bj6TIODvIIMrmFm9jZot/v
	JG0chjWWOLwOznA7KpVU7DPuoqvaTqjMVab9mrgWfW9dKXKxH85OzdPz3fCSGgs9e94N0ZheECZ
	UQ3oOt8waf+HBxcybyyYaGpTShJkM=
X-Received: by 2002:a17:907:930a:b0:b77:1b05:a081 with SMTP id a640c23a62f3a-b9081a025cfmr781623766b.27.1771934289623;
        Tue, 24 Feb 2026 03:58:09 -0800 (PST)
Received: from cloudflare.com ([104.28.193.185])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9084eb912dsm421279966b.55.2026.02.24.03.58.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 03:58:08 -0800 (PST)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: bpf@vger.kernel.org,  kernel-team@cloudflare.com,
  lsf-pc@lists.linux-foundation.org
Subject: Re: [LSF/MM/BPF TOPIC] BPF local storage for every packet
In-Reply-To: <e0f16c6c-cd9f-4881-b638-c52c8a83104e@linux.dev> (Martin KaFai
	Lau's message of "Mon, 23 Feb 2026 11:26:13 -0800")
References: <87ecmffopy.fsf@cloudflare.com>
	<5fdee5fd-aff1-4764-820e-3b1f3ad00941@linux.dev>
	<877bs6fc25.fsf@cloudflare.com>
	<e0f16c6c-cd9f-4881-b638-c52c8a83104e@linux.dev>
Date: Tue, 24 Feb 2026 12:58:08 +0100
Message-ID: <871piafj5b.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Feb 23, 2026 at 11:26 AM -08, Martin KaFai Lau wrote:
> On 2/21/26 5:42 AM, Jakub Sitnicki wrote:
>> On Fri, Feb 20, 2026 at 10:34 AM -08, Martin KaFai Lau wrote:
>>> On 2/20/26 6:56 AM, Jakub Sitnicki wrote:
>>>> In the upcoming days we are going to post an RFC which proposes to
>>>> extend the concept of BPF local storage to socket buffers (sk_buff, skb)
>>>> as means to attach arbitrary metadata to packets from BPF programs [1]
>>>> (slides 41-55).
>>>> Design wise, BPF local storage is a great fit for a packet metadata
>>>> container, as it that avoids some of the shortcoming of the the XDP
>>>> metadata interface:
>>>> 1. Users interact with storage through BPF maps and can take advantage
>>>>      of existing built-in BPF map types, while still being able to
>>>>      implement a custom data format,
>>>> 2. Maps within local storage can have different properties controlled by
>>>>      map flags. For example, maps with BPF_F_CLONE set can survive packet
>>>>      cloning. Other flags could allow map contents to survive sk_buff
>>>>      scrubbing during encapsulation/decapsulation or pass across network
>>>>      namespace boundaries.
>>>> 3. Local storage supports multiple users out of the box - each user
>>>>      creates their own map, eliminating the need to coordinate data
>>>>      layout,
>>>> 4. Local storage has its own backing memory, so persisting it across
>>>>      network stack layers requires no changes to the network stack.
>>>> However, this flexibility comes at a cost. While XDP metadata requires
>>>> no allocations [2], an initial write to BPF local storage requires two:
>>>> one for bpf_local_storage_elem, and one for bpf_local_storage itself.
>>>> We would like to align this work with the needs of other BPF local
>>>> storage users (socks, cgroups, tasks, inodes), where allocation overhead
>>>> has been a concern as well [2].
>>>> Optimization ideas we would like to put up for discussion:
>>>> - slimming down bpf_local_storage so it can be embedded as an skb
>>>>     extension chunk,
>>>> - making the bpf_local_storage cache size configurable,
>>>> - allowing bpf_local_storage to be pre-allocated,
>>>> - co-allocating bpf_local_storage and bpf_local_storage_elem for the
>>>>     single-map case.
>>>
>>> The sk/cgroup/task storage has a much longer lifetime. Meaning once allocation
>>> is done, the storage stays in the sk until the sk is closed. The length of
>>> lifetime is quite different from the skb. I am afraid we are re-purposing
>>> bpf_local_storage for a very different use case where skb lifecycle is much
>>> shorter.
>>>
>>> We are planning to increase the 'sizeof(struct sock)' for perf reason. Saving an
>>> allocation is an upside but not the major one we are looking (or care) for
>>> sk. We are more looking for cacheline efficiency and probably remove the need
>>> for bpf_local_storage[_elem] if the user chooses to use the in-place spaces of a
>>> sk.
>>>
>>> If 'sizeof(struct sk_buff)' can be increased, this should align on where sk
>>> local storage is going. If skb will solely depend on the existing
>>> bpf_local_storage and has no plan to raise sizeof(struct sk_buff) for perf
>>> purpose, the existing bpf_local_storage may be the wrong place to
>>> repurpose/optimize because the lifecycle of skb is very different.
>> The lifetime difference is undeniable, but I still see common ground.
>> To make it more concrete:
>> 1. IIRC you've mentioned wanting more bpf_local_storage->cache entries
>>     for socks in some scenarios, while for skbs I'd expect we need
>>     fewer. We could make the cache size configurable via a flexible
>>     array.
>> 2. Embedding bpf_local_storage is another overlap I had in mind. For
>>     socks that in within the same memory blob as struct sock, while for
>>     skbs we'd want to embed it in skb_ext (once it's small enough). This
>>     depends on whether you end up dropping bpf_local_storage for
>>     sk_local_storage entirely, which I didn't know about until now.
>
> For the in-place sk storage, it should not need the bpf_local_storage and the
> bpf_local_storage_elem. A stable map_xyz->sk_offset should be enough. If a
> storage is needed for all sk, the bpf prog should use the in-place sk storage
> instead of going through the bpf_local_storage[_elem].

Call me overly optimistic, but if we can pull it off for sk storage,
then what stops us from transplanting this pattern to skb_ext and skb
storage?

> imo, if we manage to pull out a new solution (whatever that is) for skb but does
> not perform close to the skb->data_meta, it is probably hard to use in
> production. I could be wrong but I don't see how embedding local_storage and/or
> shrink the cache can get there. I think we need another solution/design.

skb->data_meta is allocation free. That would be the ultimate goal.

I could see that happening is if we allocate space for skb_ext together
with sk_buff and embed map storage within the skb_ext chunk.

Apart from the long term goal, I still see value in a naive BPF local
storage implementation, like we have in sock/task/..., today because:

1. skb local storage would be available only after GRO, so we're dealing
   lower pps rate than XDP.

2. If you have use cases, like we do, when you want to attach metadata
   only to the first packet of the L4 connection, then the skb local
   storage allocation rate is the same as your established socket
   allocation rate. And we know BPF local storage is good enough for
   that.

3. There's feature gap. skb->data_meta doesn't survive past TC. Paying
   an allocation cost - user decides if its worth the price - is better
   than nothing.
