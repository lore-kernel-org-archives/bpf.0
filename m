Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E2A019DFAB
	for <bpf@vger.kernel.org>; Sat, 21 Feb 2026 13:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771681334; cv=none; b=Pat3g0V/fw7eiT6dA2PGq22YiNg0IjASkVDZcZgBDYqICEVQfdu8YNkhVpRdsbm02pHtV43fuURZ2PdSpBgI0KHtc7kNjDRbxGOBZ7VDbZYF8q/C2nuyVjuge1B0rjS2oFKFOVVLG3M/U1kunIckA1MmIt+00Vym+nQV3CYZ0JE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771681334; c=relaxed/simple;
	bh=eUB3TmBjdU3RDXUIbB7RJMKu2zNCckp2YQ9uVjU9d1s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sDjRk2RTsRZflHxp/x1O1VuSgCSAEv3R8c63xu3vrkkN5r+Ba22tlizmrnzEbcCPm61ULTOJtdqhC7O+jC/xXJ1QyAwWPxI6CnvsD8Y895/0YQ3TuuzliebPlNYR5JbQ6sEbKmVCKpgq1bI/2ixlVLp0Av/B7AKkmrg910JFwN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=Xedk4Oju; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="Xedk4Oju"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b8f96f6956aso409903766b.3
        for <bpf@vger.kernel.org>; Sat, 21 Feb 2026 05:42:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1771681331; x=1772286131; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FTJ7mEU8ZxJdWX7snIcPnyH3PcO4cHVmQhTIJPXf4UQ=;
        b=Xedk4OjuSwO/hT3Rrywo8YisIDeAHNgIv4hwsBKajQ97SwCgwKWJwm9vGbJ7dNRUYN
         hMfS5Sq8dqQKzn7MOK43yp+RBV8l2GjiZPuzZ/VtQFK3ZmoC3fHl4E71iinwMG70/plf
         2VJpqi2M4uv25X5RR+sQDrw0eCJE1HihuPU1Ce2vDX5wSDw/7fJn5EPa4ZT4UXHJFNz+
         AIyxvwhieYgKTs9m7VO7Q0mSou/mUQ/yYMnxN8QYsmezxHHB0ovOBobVSI7zZZfhMk6z
         CtekL4VJ0B0lPaVZzhDwVWKjP6WENfm6YDNmLDi/CfaagN58ub0mcucBMmqY8qusBvrQ
         tKsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771681331; x=1772286131;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FTJ7mEU8ZxJdWX7snIcPnyH3PcO4cHVmQhTIJPXf4UQ=;
        b=UlrHT0Zt2SNmls8ZqMXDV3Asd6eTVKKwR3kiR/gVdOBphcEJBNxbfQK8BxJH5Bwc2O
         eZhouQ0QOUjvawmyjsmA/7xAwcwUxJK12vmj7U/uwH/Y8sR98oCqIZo6/Lql+/sF3jUQ
         +teTuLSQFU0h6qq8JxiUjUrtMU6xBvxD6oxzyZwy+c7xNkaQ8ORLe2z8i/bCmRRnZqQK
         Oa/l1UXBLCZIwd5Jk+99lcu6/f73cJRT3JHSAWbGuabhbkMml8c7dC4SQjI/9i1TswHA
         OVDvtWblPrVV1VmlM8kwbSOyyZLYqAi4Enx0tWzXKV8EJYiFyXPxzf2xQeMg631adpSp
         0FDw==
X-Gm-Message-State: AOJu0YzD3KbgnIKkQb4U5SqOljTpGo9Jh7cCdrW+ft5M4rlkz8mvLtKO
	K6gpOxSUJwVWmB2doSnGBCZ1LH7GWYgcFEvnxT0sEneJ8TcLbbc3zg20oP0kpYKrVsLKsONXODP
	QC6Iu
X-Gm-Gg: AZuq6aLOvGEgV06/XeGZxr6ff0QI4F8A147aZ+2yhLAJDfEXQGdZu8M4hCPry9obWYF
	pz1rJHLxuEhtH988F+1bWJBEFT3faAodVUOYRrLYwkX1jU6Lo//rNix3WVnk/8AgZ4BEHGkOiH0
	Bb+VFrQKNCva/tl3PmsGbzGLV0b/ell8zJJ1cNbgyKNxzKqd0oBndRZ11avOO4CyO5xwh2LZsU4
	cmH3cAUEr5iqIjNCunZXk91fMlBotZ2FogD1/7w/CHHz+RAiscv7VVsKM/3nEAa6SXGJmtweX0V
	ViDPSQPtMqAQDe1pZ+wU7E5nlk7kXZou9NUY1awVxdpHOkkI4o9QjfxLkUQX3IiYC/7uby2qnka
	FBIFGV2pYylI9emcxOtnYowmr5Qt3uOnI98nZ4eokmctvj7LUbWc+xiak/yHOdQCOOVkMUWe7sO
	OQgF9AFYDm2zJ1jUJpRtalncYkum1DEwtJ50bFGA==
X-Received: by 2002:a17:907:d94:b0:b8e:2a8a:4320 with SMTP id a640c23a62f3a-b9081c00aa1mr169530866b.49.1771681331159;
        Sat, 21 Feb 2026 05:42:11 -0800 (PST)
Received: from cloudflare.com ([104.28.225.185])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9084ea031bsm99876166b.54.2026.02.21.05.42.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Feb 2026 05:42:10 -0800 (PST)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: bpf@vger.kernel.org,  kernel-team@cloudflare.com,
  lsf-pc@lists.linux-foundation.org
Subject: Re: [LSF/MM/BPF TOPIC] BPF local storage for every packet
In-Reply-To: <5fdee5fd-aff1-4764-820e-3b1f3ad00941@linux.dev> (Martin KaFai
	Lau's message of "Fri, 20 Feb 2026 10:34:09 -0800")
References: <87ecmffopy.fsf@cloudflare.com>
	<5fdee5fd-aff1-4764-820e-3b1f3ad00941@linux.dev>
Date: Sat, 21 Feb 2026 14:42:10 +0100
Message-ID: <877bs6fc25.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 20, 2026 at 10:34 AM -08, Martin KaFai Lau wrote:
> On 2/20/26 6:56 AM, Jakub Sitnicki wrote:
>> In the upcoming days we are going to post an RFC which proposes to
>> extend the concept of BPF local storage to socket buffers (sk_buff, skb)
>> as means to attach arbitrary metadata to packets from BPF programs [1]
>> (slides 41-55).
>> Design wise, BPF local storage is a great fit for a packet metadata
>> container, as it that avoids some of the shortcoming of the the XDP
>> metadata interface:
>> 1. Users interact with storage through BPF maps and can take advantage
>>     of existing built-in BPF map types, while still being able to
>>     implement a custom data format,
>> 2. Maps within local storage can have different properties controlled by
>>     map flags. For example, maps with BPF_F_CLONE set can survive packet
>>     cloning. Other flags could allow map contents to survive sk_buff
>>     scrubbing during encapsulation/decapsulation or pass across network
>>     namespace boundaries.
>> 3. Local storage supports multiple users out of the box - each user
>>     creates their own map, eliminating the need to coordinate data
>>     layout,
>> 4. Local storage has its own backing memory, so persisting it across
>>     network stack layers requires no changes to the network stack.
>> However, this flexibility comes at a cost. While XDP metadata requires
>> no allocations [2], an initial write to BPF local storage requires two:
>> one for bpf_local_storage_elem, and one for bpf_local_storage itself.
>> We would like to align this work with the needs of other BPF local
>> storage users (socks, cgroups, tasks, inodes), where allocation overhead
>> has been a concern as well [2].
>> Optimization ideas we would like to put up for discussion:
>> - slimming down bpf_local_storage so it can be embedded as an skb
>>    extension chunk,
>> - making the bpf_local_storage cache size configurable,
>> - allowing bpf_local_storage to be pre-allocated,
>> - co-allocating bpf_local_storage and bpf_local_storage_elem for the
>>    single-map case.
>
> The sk/cgroup/task storage has a much longer lifetime. Meaning once alloc=
ation
> is done, the storage stays in the sk until the sk is closed. The length of
> lifetime is quite different from the skb. I am afraid we are re-purposing
> bpf_local_storage for a very different use case where skb lifecycle is mu=
ch
> shorter.
>
> We are planning to increase the 'sizeof(struct sock)' for perf reason. Sa=
ving an
> allocation is an upside but not the major one we are looking (or care) for
> sk. We are more looking for cacheline efficiency and probably remove the =
need
> for bpf_local_storage[_elem] if the user chooses to use the in-place spac=
es of a
> sk.
>
> If 'sizeof(struct sk_buff)' can be increased, this should align on where =
sk
> local storage is going. If skb will solely depend on the existing
> bpf_local_storage and has no plan to raise sizeof(struct sk_buff) for perf
> purpose, the existing bpf_local_storage may be the wrong place to
> repurpose/optimize because the lifecycle of skb is very different.

The lifetime difference is undeniable, but I still see common ground.
To make it more concrete:

1. IIRC you've mentioned wanting more bpf_local_storage->cache entries
   for socks in some scenarios, while for skbs I'd expect we need
   fewer. We could make the cache size configurable via a flexible
   array.

2. Embedding bpf_local_storage is another overlap I had in mind. For
   socks that in within the same memory blob as struct sock, while for
   skbs we'd want to embed it in skb_ext (once it's small enough). This
   depends on whether you end up dropping bpf_local_storage for
   sk_local_storage entirely, which I didn't know about until now.

3. I've heard the idea of allocating skb_ext memory together with
   sk_buff was floated in the past. While trimming skb_ext at build-time
   is hard today =E2=80=94 say I need XFRM but don't care about crypto offl=
oads
   keeping state in skb_ext =E2=80=94 the idea is similar to what you're
   proposing for struct sock.

Thanks,
-jkbs
