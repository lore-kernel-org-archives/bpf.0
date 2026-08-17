Received: from mta1.migadu.com (out-61.mta1.migadu.com [95.215.58.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 295B944161B
	for <bpf@vger.kernel.org>; Mon, 17 Aug 2026 14:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786977026; cv=none; b=S6lyH+L82/Ev5gUrcIDqBf/cCcMCXwOASpXuT3rBzOnZzerkxkjVf8LcRWWvk9eEskP0PdudY/UyFANa+OErwzSlWwyaeZY2DoMpCFxM3PdpwE9v6t2TrJWaNIB1VxlgmKzgwgqSoRKl49vDbKt0lUkAd2K/ocdtgc1N+QhrOlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786977026; c=relaxed/simple;
	bh=rwsfwe1KC9WcPPdY4abw6tIn22E87mujFPrmBhYTeAQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ld9JS3avOdRpQHRKWC9RFfzYgIlRO9+Z2B2/7/UJzhriVfZbLTyNR1pEnya8zpdEl6CcKQzsHSPzQyyJd4S6bUXZcapDKnznuSxe3KOZHOPMdmItqFy7JbAiqV+XPkVpQILErQatGqtsN+DJEGZMqoJrm42fulPMekXTqTaZZwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qra4UERD; arc=none smtp.client-ip=95.215.58.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qra4UERD"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=rwsfwe1KC9WcPPdY4abw6tIn22E87mujFPrmBhYTeAQ=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786977023; v=1; x=1787581823;
 b=qra4UERDP0xNfaaZrlb9BWRpNzwWUXNCoH4NvBHJXEmhcb1K0YsQIPgkJ4XF0EhocRCvGZ4N
 G2pdhB1n+rqGFCe1aarh1HdfgI8pNcJ4PXqHcm30uP2J/0l5OwTgwTCaYpWmHgVAwAREuJsmAFH
 SFHLClsYZ1wTFleQFkkRJOQk=
X-Envelope-To: bpf@vger.kernel.org
Received: from [10.54.26.211] (222.72.143.228)
	by smtp.migadu.com with ESMTPS id 7d67e3c03a18b92d;
	Mon, 17 Aug 2026 14:30:13 +0000
X-Migadu-Flow: FLOW_OUT
Message-ID: <deeacbf2-8ae3-4f32-9787-c3625d686113@linux.dev>
Date: Mon, 17 Aug 2026 22:29:58 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf] bpf: free page_pool frags via the page_pool path in
 bpf_xdp_shrink_data
To: Daniel Borkmann <daniel@iogearbox.net>, bot+bpf-ci@kernel.org,
 bpf@vger.kernel.org, netdev@vger.kernel.org
Cc: syzbot+237bbeed8dfe0699b7f5@syzkaller.appspotmail.com,
 john.fastabend@gmail.com, sdf@fomichev.me, martin.lau@linux.dev,
 ast@kernel.org, andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com,
 song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org,
 emil@etsalapatis.com, ihor.solodrai@linux.dev, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 hawk@kernel.org, toke@redhat.com, lorenzo@kernel.org,
 linux-kernel@vger.kernel.org, martin.lau@kernel.org, clm@meta.com
References: <20260816031245.268898-1-jiayuan.chen@linux.dev>
 <5aa97a9a0b8cd20feda29b304874967a8019d8b4b3dd4021dc5c0dac43c10d05@mail.kernel.org>
 <2c2c7bb6-cce5-4dc3-965c-bbf1c50905d9@linux.dev>
 <8a34148c-4704-4d8c-9c7f-cfadb523a745@iogearbox.net>
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <8a34148c-4704-4d8c-9c7f-cfadb523a745@iogearbox.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 8/17/26 10:15 PM, Daniel Borkmann wrote:
> On 8/16/26 7:16 AM, Jiayuan Chen wrote:
>> On 8/16/26 11:57 AM, bot+bpf-ci@kernel.org wrote:
>>>> diff --git a/net/core/filter.c b/net/core/filter.c
>>>> index 16845987b244..3aab5556abe2 100644
>>>> --- a/net/core/filter.c
>>>> +++ b/net/core/filter.c
>>>> @@ -86,6 +86,7 @@
>>>>   #include <net/inet_dscp.h>
>>>>
>>>>   #include "dev.h"
>>>> +#include "netmem_priv.h"
>>>>
>>>>   /* Keep the struct bpf_fib_lookup small so that it fits into a 
>>>> cacheline */
>>>>   static_assert(sizeof(struct bpf_fib_lookup) == 64, "struct 
>>>> bpf_fib_lookup size check");
>>>> @@ -4288,6 +4289,14 @@ static bool bpf_xdp_shrink_data(struct 
>>>> xdp_buff *xdp, skb_frag_t *frag,
>>>>       if (mem_type == MEM_TYPE_XSK_BUFF_POOL) {
>>>>           netmem = 0;
>>>>           zc_frag = bpf_xdp_shrink_data_zc(xdp, shrink, tail, 
>>>> release);
>>>> +    } else if (netmem_is_pp(netmem)) {
>>>> +        /* The rxq mem model does not always describe how a released
>>>> +         * frag must be freed: the generic-XDP and veth paths run the
>>>> +         * program on a shared rxq while the frag has been cow'd into
>>>> +         * page_pool memory. Trust the page itself and return a
>>>> +         * page_pool frag to its pool regardless of rxq->mem.type.
>>>> +         */
>>>> +        mem_type = MEM_TYPE_PAGE_POOL;
>>>>       }
>>>>
>>>>       if (release) {
>>> The comment says the fix handles rxq->mem.type "regardless" of its 
>>> value,
>>> but the implementation still checks MEM_TYPE_XSK_BUFF_POOL first. 
>>> When the
>>> shared rxq has been left with mem_type == MEM_TYPE_XSK_BUFF_POOL by
>>> veth_xdp_rcv_one() (which writes frame->mem_type into the shared rxq on
>>> XDP_TX/XDP_REDIRECT and never restores it), a page_pool frag skips 
>>> the new
>>> netmem_is_pp() branch entirely and goes to bpf_xdp_shrink_data_zc() 
>>> instead.
>>>
>>> Should the comment say "regardless of rxq->mem.type, unless the rxq 
>>> claims
>>> XSK memory" or should the netmem_is_pp() test be unconditional so 
>>> the stale
>>> MEM_TYPE_XSK_BUFF_POOL case is also handled?
>>>
>>> The commit message states: "A single rxq->mem.type can be wrong in 
>>> either
>>> direction." The code, however, only corrects one direction: it upgrades
>>> mem_type to MEM_TYPE_PAGE_POOL when the frag is a page_pool page, 
>>> but it
>>> never downgrades when rxq->mem.type already says MEM_TYPE_PAGE_POOL 
>>> and the
>>> frag is not a page_pool page.
>>>
>>> That second direction is reachable on the very path the commit message
>>> cites. veth_xdp_rcv_one() (drivers/net/veth.c:638) points the buff 
>>> at the
>>> shared rxq and then, on XDP_TX/XDP_REDIRECT, writes the frame's type 
>>> into
>>> it:
>>>
>>>      xdp->rxq = &rq->xdp_rxq;
>>>      ...
>>>      case XDP_TX:
>>>              xdp->rxq->mem.type = frame->mem_type;
>>>      case XDP_REDIRECT:
>>>              xdp->rxq->mem.type = frame->mem_type;
>>>
>>> Once one redirected frame with mem_type == MEM_TYPE_PAGE_POOL is 
>>> TX'd or
>>> redirected, rq->xdp_rxq.mem.type stays MEM_TYPE_PAGE_POOL for every
>>> subsequent packet on that queue.
>>>
>>> A later frame whose frags are plain pages then reaches:
>>>
>>>      } else if (netmem_is_pp(netmem)) {   /* false, mem_type left as 
>>> PAGE_POOL */
>>>      ...
>>>      __xdp_return(netmem, mem_type, false, zc_frag);
>>>
>>> and __xdp_return()'s MEM_TYPE_PAGE_POOL arm (net/core/xdp.c:436-446) 
>>> skips
>>> the check and dereferences a garbage pool pointer:
>>>
>>>      /* No need to check netmem_is_pp() as mem->type knows this a 
>>> page_pool page */
>>>      page_pool_put_full_netmem(netmem_get_pp(netmem), netmem, 
>>> napi_direct);
>>>
>>> netmem_get_pp() reads page->pp, which for a non-page_pool page holds
>>> whatever the allocator left there.
>>>
>>> This specific crash is pre-existing rather than introduced by the 
>>> patch, but
>>> the patch is the change that claims to make the frag itself 
>>> authoritative,
>>> and it had the netmem in hand. Could the decision be unconditional:
>>>
>>>      } else {
>>>              mem_type = netmem_is_pp(netmem) ? MEM_TYPE_PAGE_POOL : 
>>> mem_type;
>>
>> This is a non-pool page being mistreated as a pool page, and I think 
>> it's a separate issue, xdp_return_buff and xdp_convert_buff_to_frame 
>> hit it too, not just this path.
> Could you look into this as well, and make this a small series along 
> with a BPF selftest
> which exercises/tests this bug?
>
> Thanks,
> Daniel


Thanks Daniel. I'm still thinking of a unified fix( for example 
__xdp_return() since that's the one place 
bpf_xdp_shrink_data/xdp_return_buff/xdp_convert_buff_to_frame go
through), deciding by the page itself there handles both directions at once.

I'll work on it.

