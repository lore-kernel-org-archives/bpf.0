Received: from mta0.migadu.com (out-147.mta0.migadu.com [91.218.175.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ECF2415F35
	for <bpf@vger.kernel.org>; Mon, 24 Aug 2026 12:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787574011; cv=none; b=IOQswd9ThJmW3XQpEM+GFJ2jlhZgJ7sbwsUfjX+GpoPXB0u2pfkFGy4j+SbXUC/QHWUkn3GOhIa2YWyhkEk5azlnBRcgHD8EQ42bm79mn/UcKyuqXZi8LR3V0+AahPUvHAI/A6TLKMnK88fShczSf2+kOukiha6rUHpsofV0eYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787574011; c=relaxed/simple;
	bh=NbaD03yilMmk0puKZ/RanUhxoZrnyNj20MyBlr5dU3c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PBu1qADfsB5iQB58krT0KMD4KWT8gV41zH6p2P109JIWIq8mpIGTemuOAMxIM057CLWigZ4F4joGC9ad9N6DEYrcrAUarHQwXEIZFmrtJVowcgi6wqQozW0Bcvq3NbvMvBRayRmzq7FUVFnCSyuOYwzLa3p8/zHmyshxEVT1mzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=HChm1EYs; arc=none smtp.client-ip=91.218.175.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="HChm1EYs"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=NbaD03yilMmk0puKZ/RanUhxoZrnyNj20MyBlr5dU3c=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787574007; v=1; x=1788178807;
 b=HChm1EYsGv+3NZSwPcRB8Kqk1ncAXfvuYVFBpj2Rj2ukenVGpajY1wfGvMF1OtVMZgwdrcyi
 4loStMrlRqSefmYR4ov966+HE4ehIaamGaDsEPVtHU/k/T54NEssawfVa5OrDldPy+3YjjOceqh
 2mPQatqui3squ+geO9WcVJqI=
X-Envelope-To: bpf@vger.kernel.org
Received: from [10.54.25.56] (222.72.143.228)
	by smtp.migadu.com with ESMTPS id 9a9d63bd1232e71b;
	Mon, 24 Aug 2026 12:19:57 +0000
X-Mizu-Trace-ID: 9a9d63bd1232e71b
X-Migadu-Flow: FLOW_OUT
Message-ID: <01fd251d-1134-4251-9c11-79943e367ffe@linux.dev>
Date: Mon, 24 Aug 2026 20:19:44 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf v2 1/2] bpf, veth: xdp: fix page_pool page leak on
 skb-backed XDP
To: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org,
 syzbot+237bbeed8dfe0699b7f5@syzkaller.appspotmail.com,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Simon Horman <horms@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Andrii Nakryiko
 <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Emil Tsalapatis <emil@etsalapatis.com>,
 Ihor Solodrai <ihor.solodrai@linux.dev>, Shuah Khan <shuah@kernel.org>,
 Kuniyuki Iwashima <kuniyu@google.com>, Hangbin Liu <liuhangbin@gmail.com>,
 Krishna Kumar <krikku@gmail.com>, Martin Karsten <mkarsten@uwaterloo.ca>,
 =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20260824030257.263179-1-jiayuan.chen@linux.dev>
 <20260824030705.266049-1-jiayuan.chen@linux.dev> <aowdem3KQVfvocE7@lore-desk>
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <aowdem3KQVfvocE7@lore-desk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 8/24/26 6:31 PM, Lorenzo Bianconi wrote:
>> bpf_xdp_shrink_data() frees a released frag via __xdp_return() using
>> xdp->rxq->mem.type, but that type is wrong for skb-backed XDP: the skb is
>> cow'd into page_pool memory while the rxq still says MEM_TYPE_PAGE_SHARED,
>> so the page_pool page is freed with page_frag_free() and we hit
>> "Bad page state ... page_pool leak".
>>
>> Both generic XDP and veth are affected. A non-linear skb is cow'd into
>> page_pool memory (skb_cow_data_for_xdp() -> skb_pp_cow_data() for generic
>> XDP, veth_convert_skb_to_xdp_buff() for veth), so its frags become
>> page_pool pages while the rxq keeps MEM_TYPE_PAGE_SHARED.
>>
>> We can't just fix rxq->mem.type in place:
>> - generic XDP: xdp->rxq is dev->_rx[queue].xdp_rxq (see
>>    bpf_prog_run_generic_xdp()), a shared rxq that other CPUs may access in
>>    parallel, so we must not write to it.
>> - veth: rq->xdp_rxq.mem is shared per-queue state that veth resets on XDP
>>    teardown, and with GRO that reset runs without stopping in-flight NAPI,
>>    so a type stashed there can be clobbered under a packet still in flight.
>>
>> Adding a check in __xdp_return() or bpf_xdp_shrink_data() itself is not an
>> option either: without recording it somewhere, both can only guess the
>> frag's memory type, which quickly gets confusing.
>>
>> So record it in the xdp_buff. Add a XDP_FLAGS_FRAGS_PAGE_POOL flag; the two
>> skb-cow sites set it, and bpf_xdp_shrink_data() frees the frag to the
>> page_pool when it is set, otherwise it keeps falling back to
>> xdp->rxq->mem.type unchanged. No other path changes behaviour.
>>
>> Fixes: e6d5dbdd20aa ("xdp: add multi-buff support for xdp running in generic mode")
>> Fixes: 0ebab78cbcbf ("net: veth: add page_pool for page recycling")
> Hi Jiayuan Chen,
>
> thx for fixing it. Can we do something like the patch below instead?
>
> Regards,
> Lorenzo
>
> diff --git a/net/core/xdp.c b/net/core/xdp.c
> index 1d679e8fd649..4ed659b58141 100644
> --- a/net/core/xdp.c
> +++ b/net/core/xdp.c
> @@ -433,16 +433,16 @@ EXPORT_SYMBOL_GPL(xdp_rxq_info_attach_page_pool);
>   void __xdp_return(netmem_ref netmem, enum xdp_mem_type mem_type,
>   		  bool napi_direct, struct xdp_buff *xdp)
>   {
> +	netmem_ref head_netmem = netmem_compound_head(netmem);
> +	if (netmem_is_pp(head_netmem))
> +		mem_type = MEM_TYPE_PAGE_POOL;
> +
>   	switch (mem_type) {
>   	case MEM_TYPE_PAGE_POOL:
> -		netmem = netmem_compound_head(netmem);
>   		if (napi_direct && xdp_return_frame_no_direct())
>   			napi_direct = false;
> -		/* No need to check netmem_is_pp() as mem->type knows this a
> -		 * page_pool page
> -		 */
> -		page_pool_put_full_netmem(netmem_get_pp(netmem), netmem,
> -					  napi_direct);
> +		page_pool_put_full_netmem(netmem_get_pp(head_netmem),
> +					  head_netmem, napi_direct);
>   		break;
>   	case MEM_TYPE_PAGE_SHARED:
>   		page_frag_free(__netmem_address(netmem));


Hi Lorenzo,

I tried this, but it regresses the bpf selftest with a page_pool ref 
underflow (0 warns on master, 45 with the patch):

     WARNING: include/net/page_pool/helpers.h:297 at 
page_pool_alloc_frag_netmem
     skb_pp_cow_data
     veth_xdp_rcv_skb


On XDP_TX/XDP_REDIRECT veth has to take plain page refs via get_page() 
(veth_xdp_get()) and then
consume_skb(): the skb itself must be freed while the data pages stay 
alive for the frame. consume_skb()
already returns the skb's page_pool ref, so what the frame holds 
afterwards is a plain page ref, to be
dropped with page_frag_free().

netmem_is_pp() can't see that: it only says the page still belongs to a 
pool (other users may still hold pool refs on the same page),
not what kind of ref we're dropping. So __xdp_return() turns those 
plain-ref drops into a second pool
put and pp_ref goes negative.

That's why I kept the type in the xdp_buff and only override it in the 
shrink path, where we know the
frag ref is the cow'd page_pool one.

Regards,
Jiayuan

