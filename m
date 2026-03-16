Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46D171A0BD6
	for <bpf@vger.kernel.org>; Mon, 16 Mar 2026 03:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773630165; cv=none; b=Ccmi2MlksEzOdDvKBTR5ztcJC0C81HbwJ4ISMFwIYspHMErVBcs6Yrvaaxg0wRsKFAuEc3wgAcf+Xmd3zATxxKqgH30A5AcCbaU61bIikhdavElQSOGC+brR/pLGAxhk/o7RhGn6NK2H8L/y4kM74td793E8RuyPSUVYUOs0Y+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773630165; c=relaxed/simple;
	bh=bXfROKGIpD7uNrbt3P0W8H0r6CwusT6WnnP2FHJRDH0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=STvDxuHg48UF9VD3x0jynUunUOtPtMx379KGjPC5hNkDLseS9va7lXUU/s4DfFk2Pbu0RSW4Rkuo8dWtxcbm+7goj5EfNFf0qug6klXDYrtOdsa3+7XsY37folu+7r+MNx7WLFvLwZVqePNEKV3ku+pbl4lwkq1HfQVqynddlRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=lME4OytX; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lME4OytX"
Message-ID: <b3e25c27-6e18-4d12-8799-344367fe723a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1773630161;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V165vY637xMUVaxU2R4TFGGzMmhg6Qeg6T4fpI0wKm8=;
	b=lME4OytXbOXVIj746pt/i+bpDAHQYNAN1b7pkw37Djry677MpifcnWdHr7Yy6HDPp3fD8F
	KzMdihUTe9gDVvht2yDVz3laW4DQESbIEFmi0p/AOxpKuek2sBbeUAsJE4fxP3TKzXnJbo
	u/blV1WFCfug+Z9b21r/cAmMySTOHH8=
Date: Sun, 15 Mar 2026 20:02:34 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [LSF/MM/BPF TOPIC] BPF local storage for every packet
To: Jakub Sitnicki <jakub@cloudflare.com>
Cc: lsf-pc@lists.linux-foundation.org, bpf@vger.kernel.org,
 kernel-team@cloudflare.com
References: <87ecmffopy.fsf@cloudflare.com>
 <aa2fada2-3f61-4f3d-9f55-36538f566333@linux.dev>
 <87ikbcoc4o.fsf@cloudflare.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <87ikbcoc4o.fsf@cloudflare.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


在 2026/3/3 13:07, Jakub Sitnicki 写道:
> On Tue, Mar 03, 2026 at 07:06 AM -08, Zhu Yanjun wrote:
>> 在 2026/2/20 6:56, Jakub Sitnicki 写道:
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
>> Interested in this topic. I hope to join this meeting.
> Thanks for the interest. I've since posted the RFC for that [1] and the
> topic is, at least partially, no longer relevant. We won't be adding new
> users of BPF local storage [2].
>
> I've proposed to the PC that we can change it to:
>
> 1) How to make regular BPF maps work as a stash-away storage for skb
> metadata. I've highlighted my initial concerns [3] and will give it a
> try to get hands-on experience with this approach.
>
> 2) Or if we decide to go with a secondary skb metadata embedded in the
> skb_ext - which is another direction I wanted to explore, then we could
> discuss how to optimize skb_ext (this overlaps with the original
> proposal).

Thanks a lot. I’m very interested in this topic and was wondering 
whether it is on the agenda for the LSF meeting.

Zhu Yanjun

>
> Thanks,
> -jkbs
>
> [1] https://lore.kernel.org/all/20260226-skb-local-storage-v1-0-4ca44f0dd9d1@cloudflare.com/
> [2] https://lore.kernel.org/all/CAADnVQKVfyh3_OZshvYf7GJUF-ph2eMfmaQsxNgwBJd1AJgXTQ@mail.gmail.com/
> [3] https://lore.kernel.org/all/87wlzydk12.fsf@cloudflare.com/

-- 
Best Regards,
Yanjun.Zhu

