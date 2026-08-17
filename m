Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 706803DC4CE;
	Mon, 17 Aug 2026 14:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786976139; cv=none; b=uviqcEDDONm8AKyPK6TsghS1wGUEXMBrnFXkBnujKQbRKnnr5epy8yp3lGdc/MSTych3/+2DboGjjg3WrONVYxP9pwCtAoAWqlurDR3LmmnDQfIbzUymaqyB5l/PAF8YBvalLkYaNWpZHc/q3zgMpKWkF3n/nRbsEGAcO5wwJJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786976139; c=relaxed/simple;
	bh=1/eYIkz0AFB91Tmeaq5LsODRm0JR6lxKLjBeydamfhk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZMd+UxN+xmBTFHuzR5FgClGIYs9mxUX9JJZ6sJ4QjpRtTYtVU4Pb1YPIHaadPpLmF+vk7oRE0bzuCaRq0DA24k+oLmwmXmukr02NwGARdDIQTU8ypyUP3VqjEgMt7NdO1Uro8xtXdCTsnnjqoJuLLA8T3vReAmAg/nYka/zFv1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=PjkYMs26; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="PjkYMs26"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=tF98P74tC4o92WZtcEtDR8sMudbG6OD9RkXX0/2R/aY=; b=PjkYMs26pnmHClcJTGAgdmR4lw
	Mhggn8iQqesep4Az0xBGqYl9dOgeV3VHQUHBouRx4IT6u1WpCr29gbNrUEo2VFZqBUwORylHSnJBU
	2kZrcR/nA6oHMUBPKNFgxX4UFDt+NFwJ0egiZiRL8jSmH5ABPCyHbh5JFrkxcjHY0FHaSd3ogWaVT
	xcq8U3HbdwR+t7qhqlcfEC0qB1mDBVoHS9gCMcpqzocRwUq/eGkgl3u80UjKtf0OURZr0ifbnMpzR
	Uou4WWVaT3pXXIz7Jqy8fdZaLBTReo51m1p592JK2v6Z1eMeEzYGKPLXaK6WU/LQYBn3+s5K3wZ7l
	eLSvycMg==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1wvy7c-000N6b-0J;
	Mon, 17 Aug 2026 16:15:28 +0200
Received: from localhost ([127.0.0.1])
	by sslproxy02.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1wvy7b-0000vQ-0F;
	Mon, 17 Aug 2026 16:15:26 +0200
Message-ID: <8a34148c-4704-4d8c-9c7f-cfadb523a745@iogearbox.net>
Date: Mon, 17 Aug 2026 16:15:25 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf] bpf: free page_pool frags via the page_pool path in
 bpf_xdp_shrink_data
To: Jiayuan Chen <jiayuan.chen@linux.dev>, bot+bpf-ci@kernel.org,
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
Content-Language: en-US
From: Daniel Borkmann <daniel@iogearbox.net>
Autocrypt: addr=daniel@iogearbox.net; keydata=
 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
In-Reply-To: <2c2c7bb6-cce5-4dc3-965c-bbf1c50905d9@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/28095/Mon Aug 17 08:23:59 2026)

On 8/16/26 7:16 AM, Jiayuan Chen wrote:
> On 8/16/26 11:57 AM, bot+bpf-ci@kernel.org wrote:
>>> diff --git a/net/core/filter.c b/net/core/filter.c
>>> index 16845987b244..3aab5556abe2 100644
>>> --- a/net/core/filter.c
>>> +++ b/net/core/filter.c
>>> @@ -86,6 +86,7 @@
>>>   #include <net/inet_dscp.h>
>>>
>>>   #include "dev.h"
>>> +#include "netmem_priv.h"
>>>
>>>   /* Keep the struct bpf_fib_lookup small so that it fits into a cacheline */
>>>   static_assert(sizeof(struct bpf_fib_lookup) == 64, "struct bpf_fib_lookup size check");
>>> @@ -4288,6 +4289,14 @@ static bool bpf_xdp_shrink_data(struct xdp_buff *xdp, skb_frag_t *frag,
>>>       if (mem_type == MEM_TYPE_XSK_BUFF_POOL) {
>>>           netmem = 0;
>>>           zc_frag = bpf_xdp_shrink_data_zc(xdp, shrink, tail, release);
>>> +    } else if (netmem_is_pp(netmem)) {
>>> +        /* The rxq mem model does not always describe how a released
>>> +         * frag must be freed: the generic-XDP and veth paths run the
>>> +         * program on a shared rxq while the frag has been cow'd into
>>> +         * page_pool memory. Trust the page itself and return a
>>> +         * page_pool frag to its pool regardless of rxq->mem.type.
>>> +         */
>>> +        mem_type = MEM_TYPE_PAGE_POOL;
>>>       }
>>>
>>>       if (release) {
>> The comment says the fix handles rxq->mem.type "regardless" of its value,
>> but the implementation still checks MEM_TYPE_XSK_BUFF_POOL first. When the
>> shared rxq has been left with mem_type == MEM_TYPE_XSK_BUFF_POOL by
>> veth_xdp_rcv_one() (which writes frame->mem_type into the shared rxq on
>> XDP_TX/XDP_REDIRECT and never restores it), a page_pool frag skips the new
>> netmem_is_pp() branch entirely and goes to bpf_xdp_shrink_data_zc() instead.
>>
>> Should the comment say "regardless of rxq->mem.type, unless the rxq claims
>> XSK memory" or should the netmem_is_pp() test be unconditional so the stale
>> MEM_TYPE_XSK_BUFF_POOL case is also handled?
>>
>> The commit message states: "A single rxq->mem.type can be wrong in either
>> direction." The code, however, only corrects one direction: it upgrades
>> mem_type to MEM_TYPE_PAGE_POOL when the frag is a page_pool page, but it
>> never downgrades when rxq->mem.type already says MEM_TYPE_PAGE_POOL and the
>> frag is not a page_pool page.
>>
>> That second direction is reachable on the very path the commit message
>> cites. veth_xdp_rcv_one() (drivers/net/veth.c:638) points the buff at the
>> shared rxq and then, on XDP_TX/XDP_REDIRECT, writes the frame's type into
>> it:
>>
>>      xdp->rxq = &rq->xdp_rxq;
>>      ...
>>      case XDP_TX:
>>              xdp->rxq->mem.type = frame->mem_type;
>>      case XDP_REDIRECT:
>>              xdp->rxq->mem.type = frame->mem_type;
>>
>> Once one redirected frame with mem_type == MEM_TYPE_PAGE_POOL is TX'd or
>> redirected, rq->xdp_rxq.mem.type stays MEM_TYPE_PAGE_POOL for every
>> subsequent packet on that queue.
>>
>> A later frame whose frags are plain pages then reaches:
>>
>>      } else if (netmem_is_pp(netmem)) {   /* false, mem_type left as PAGE_POOL */
>>      ...
>>      __xdp_return(netmem, mem_type, false, zc_frag);
>>
>> and __xdp_return()'s MEM_TYPE_PAGE_POOL arm (net/core/xdp.c:436-446) skips
>> the check and dereferences a garbage pool pointer:
>>
>>      /* No need to check netmem_is_pp() as mem->type knows this a page_pool page */
>>      page_pool_put_full_netmem(netmem_get_pp(netmem), netmem, napi_direct);
>>
>> netmem_get_pp() reads page->pp, which for a non-page_pool page holds
>> whatever the allocator left there.
>>
>> This specific crash is pre-existing rather than introduced by the patch, but
>> the patch is the change that claims to make the frag itself authoritative,
>> and it had the netmem in hand. Could the decision be unconditional:
>>
>>      } else {
>>              mem_type = netmem_is_pp(netmem) ? MEM_TYPE_PAGE_POOL : mem_type;
> 
> This is a non-pool page being mistreated as a pool page, and I think it's a separate issue, xdp_return_buff and xdp_convert_buff_to_frame hit it too, not just this path.
Could you look into this as well, and make this a small series along with a BPF selftest
which exercises/tests this bug?

Thanks,
Daniel
