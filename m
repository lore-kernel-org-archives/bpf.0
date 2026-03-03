Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0B0147DF90
	for <bpf@vger.kernel.org>; Tue,  3 Mar 2026 15:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772550421; cv=none; b=naKa3h1GEZeBqN+w/9ruuYgPWFsq16vQDiFrem3IKQwfW3rwpaBGJPNeTsNOamGD3C8uoQb3eSsFCWBYSjwHdnkKN518Aje0ZIBW7deygqo6pq+xk/vKUMQrWGiAqA/vgm/ZOBte+sSeGoMjYwItByXzwl4OGUEnvBCqGfBSoAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772550421; c=relaxed/simple;
	bh=zZAQwnXwTS4ZJrc9nWuiqrG5mkirIuNcJQLGStcnLpc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Zl8aFWWTYMZxRKOiYZ6BWOOLYkWn9TMAIMjvX2vmiHDyWazZOh+PF/d2vyQJP/FghXSB4IYGZ8dSG93BgESlVjyriGKBDVmA0KcSHROJQ8afaxXdqVVosmOitfRswdL94CecLXwQUuqw9q1p20+wmB92lwDRREJCXJTDABWS8sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=BRqmf0+F; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="BRqmf0+F"
Message-ID: <aa2fada2-3f61-4f3d-9f55-36538f566333@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772550417;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kPkRskiwsoZ3DEHGZEpEaLK9DAp/hC6vkb4Wg9Zbopc=;
	b=BRqmf0+FCA2qWGQPLN/z+Dzjre/NCMVUX60l1PnIaikAfiLAeuLeUTTw9/B2aQiwwUxh50
	T0+Rsg6S/Ll8FPb2bwujPhEsdtvYcu32Y/Ubmn6TSvFrF8EjvR5eau0AKNmjcwintUcd9q
	fqDae1or4kMwGywAbFiSHBZxsS3ye20=
Date: Tue, 3 Mar 2026 07:06:46 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [LSF/MM/BPF TOPIC] BPF local storage for every packet
To: Jakub Sitnicki <jakub@cloudflare.com>, lsf-pc@lists.linux-foundation.org
Cc: bpf@vger.kernel.org, kernel-team@cloudflare.com
References: <87ecmffopy.fsf@cloudflare.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <87ecmffopy.fsf@cloudflare.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2026/2/20 6:56, Jakub Sitnicki 写道:
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

Interested in this topic. I hope to join this meeting.

Zhu Yanjun

> - making the bpf_local_storage cache size configurable,
> - allowing bpf_local_storage to be pre-allocated,
> - co-allocating bpf_local_storage and bpf_local_storage_elem for the
>    single-map case.
> 
> Thanks,
> -jkbs
> 
> [1] https://fosdem.org/2026/schedule/event/DSC9L3-rich-packet-metadata/
> [2] Assuming sufficient free headroom in the skb linear buffer.
> [3] http://msgid.link/ad835a9b-e544-48d3-b6e2-ffe172fcfa6d@linux.dev

