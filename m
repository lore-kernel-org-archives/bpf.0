Received: from mta0.migadu.com (out-202.mta0.migadu.com [91.218.175.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D988B374A02
	for <bpf@vger.kernel.org>; Mon, 14 Sep 2026 08:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789375583; cv=none; b=UxZUseBI1dz79iatwgCJ28Kr5bgFhunxeucE+1VYcfw8sz1+FjZM6ugD0SSjIl1prOE/kyG33Ug6/DiBN+EaFh4q7/7DEwKodXRyRPT2DeBrf3ss2xJsqg1qfTCBCRjDS/fGAbCb8pN3I341sq4I4OxhRI7SId3OIOXmSYIOY08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789375583; c=relaxed/simple;
	bh=4Dd0n0gTLPNa/6hflxMCBDhcyfr6bR5PLYgiDXNQGGA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I8WTPUcI7wDAD2xdXVKmBMeDghU+/b+0UAv6PGBEzHqcg4MjMvmBsTrP82TJil3G/yiNOSzaK9CGEuhXz6qlQCXQjpCi7BJaa1p1ZjKadt99lOPuEvo08zlTDqJM4UdzUqa4TtbN/Xb+nnLfvpNOGtls4kHmA+ARx9Rg3Db4T9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=payzUWZ5; arc=none smtp.client-ip=91.218.175.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="payzUWZ5"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=4Dd0n0gTLPNa/6hflxMCBDhcyfr6bR5PLYgiDXNQGGA=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789375579; v=1; x=1789980379;
 b=payzUWZ5IoecKt1DiVG3ZwTtO3Gk5FVcS20RaS/tZQm9sx1TqNn81Rg9rU35lBNM0TWsR7tb
 6AVtFYdmVEWiB6htSoxINwC59aXIfl6N3+VGBBHN0hvTukI+KNNuXndimyotES6Qlxvm1EmwKBG
 IwdyJ8SG4/aRu1rSAceSR+WE=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id be2134d539f3b060;
	Mon, 14 Sep 2026 08:46:19 +0000
X-Mizu-Trace-ID: be2134d539f3b060
X-Migadu-Flow: FLOW_OUT
Message-ID: <8f506ce9-b108-44cf-8f9f-99a686c7d843@linux.dev>
Date: Mon, 14 Sep 2026 16:46:08 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf v3 1/2] bpf, veth: xdp: fix page_pool page leak on
 skb-backed XDP
To: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Cc: bpf@vger.kernel.org,
 syzbot+237bbeed8dfe0699b7f5@syzkaller.appspotmail.com,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Simon Horman <horms@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Emil Tsalapatis <emil@etsalapatis.com>,
 Ihor Solodrai <ihor.solodrai@linux.dev>, Shuah Khan <shuah@kernel.org>,
 Kuniyuki Iwashima <kuniyu@google.com>, Hangbin Liu <liuhangbin@gmail.com>,
 Martin Karsten <mkarsten@uwaterloo.ca>,
 =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
 Eelco Chaudron <echaudro@redhat.com>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20260911135711.109338-1-jiayuan.chen@linux.dev>
 <20260911135711.109338-2-jiayuan.chen@linux.dev> <aqaflCbYxNRe-13p@lore-desk>
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <aqaflCbYxNRe-13p@lore-desk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 9/13/26 9:05 PM, Lorenzo Bianconi wrote:
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
>> So record it in the xdp_buff. A dedicated mem_type field (mirroring
>> xdp_frame->mem_type) would read more naturally, but it grows xdp_buff, and
>> struct xdp_page_head embeds two of them, which shifts the layout the
>> xdp_do_redirect live-frames selftest hard-codes (MAX_PKT_SIZE). So use a
>> flag bit: add XDP_FLAGS_FRAGS_PAGE_POOL, the two skb-cow sites set it, and
>> bpf_xdp_shrink_data() frees the frag to the page_pool when it is set,
>> otherwise it keeps falling back to xdp->rxq->mem.type unchanged.
> I have not looked into the details yet, but I am wondering if it is possible
> to just move xdp_mem_info type (or ever the full xdp_mem_info) in xdp_buff and
> remove it from xdp_rxq_info struct. What do you think?


I think that would read better, but it touches ~20 datapath sites plus a
few drivers, so I choose keeping this one small enough to backport.


>> The flag describes the buff, so the buff <-> frame conversions have to keep
>> it consistent:
>> - buff -> frame: xdp_update_frame_from_buff() copies xdp->flags into the
>>    frame. veth XDP_TX/XDP_REDIRECT hand the frame to the peer, and cpumap
>>    and devmap run a second program on it, so the peer would inherit a stale
>>    tag; strip it, an xdp_frame describes its memory with ::mem_type.
>> - frame -> buff: xdp_convert_frame_to_buff() rebuilds a buff, and veth and
>>    devmap then run a program whose rxq says MEM_TYPE_PAGE_SHARED even for a
>>    page_pool frame (only cpumap copies mem_type into the rxq). A shrink
>>    there leaks the same way (this predates the series: bpf_xdp_adjust_tail()
>>    frees frags by rxq->mem.type), so re-derive the flag from the frame's
>>    ::mem_type.
>>
>> Fixes: e6d5dbdd20aa ("xdp: add multi-buff support for xdp running in generic mode")
>> Fixes: 0ebab78cbcbf ("net: veth: add page_pool for page recycling")
>> Fixes: bf25146a5595 ("bpf: add frags support to the bpf_xdp_adjust_tail() API")
>> Reported-by: syzbot+237bbeed8dfe0699b7f5@syzkaller.appspotmail.com
>> Closes: https://syzkaller.appspot.com/bug?extid=237bbeed8dfe0699b7f5
>> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
>> ---
>>   drivers/net/veth.c |  6 ++++++
>>   include/net/xdp.h  | 30 +++++++++++++++++++++++++++++-
>>   net/core/dev.c     |  6 ++++++
>>   net/core/filter.c  |  7 +++++++
>>   4 files changed, 48 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/veth.c b/drivers/net/veth.c
>> index 6ed3ee81153fb..a3fdf1959b76c 100644
>> --- a/drivers/net/veth.c
>> +++ b/drivers/net/veth.c
>> @@ -775,6 +775,12 @@ static int veth_convert_skb_to_xdp_buff(struct veth_rq *rq,
>>   	if (skb_shinfo(skb)->nr_frags) {
>>   		skb_shinfo(skb)->xdp_frags_size = skb->data_len;
>>   		xdp_buff_set_frags_flag(xdp);
>> +		/*
>> +		 * A nonlinear skb was cow'd into rq->page_pool above, so the
>> +		 * frags must be freed to that pool, not via the rxq's
>> +		 * MEM_TYPE_PAGE_SHARED.
>> +		 */
>> +		xdp_buff_set_frag_pp(xdp);
> Even if it is not a real problem at the moment, I still think we should
> set it not just if we have a non-liner skb, but for all skb returned by
> skb_pp_cow_data().


It's not an actual problem today, so I won't respin just for this, but
I'll fold it in if there is a v4.


>>   	} else {
>>   		xdp_buff_clear_frags_flag(xdp);
>>   	}
>> diff --git a/include/net/xdp.h b/include/net/xdp.h
>> index aa742f413c358..8fd4139e9cbd3 100644
>> --- a/include/net/xdp.h
>> +++ b/include/net/xdp.h
>> @@ -81,6 +81,14 @@ enum xdp_buff_flags {
>>   	 * XDP program is not attached.
>>   	 */
>>   	XDP_FLAGS_FRAGS_UNREADABLE	= BIT(2),
>> +	/*
>> +	 * frags are page_pool memory even though rxq->mem.type is not: a
>> +	 * skb-backed XDP buff (generic XDP, veth) is cow'd into a page_pool.
>> +	 * xdp_buff only: an xdp_frame describes its memory with ::mem_type, so
>> +	 * this is stripped in xdp_update_frame_from_buff() and re-derived from
>> +	 * ::mem_type in xdp_convert_frame_to_buff().
>> +	 */
>> +	XDP_FLAGS_FRAGS_PAGE_POOL	= BIT(3),
>>   };
>>   
>>   struct xdp_buff {
>> @@ -131,6 +139,16 @@ static __always_inline void xdp_buff_set_frag_unreadable(struct xdp_buff *xdp)
>>   	xdp->flags |= XDP_FLAGS_FRAGS_UNREADABLE;
>>   }
>>   
>> +static __always_inline void xdp_buff_set_frag_pp(struct xdp_buff *xdp)
>> +{
>> +	xdp->flags |= XDP_FLAGS_FRAGS_PAGE_POOL;
>> +}
>> +
>> +static __always_inline bool xdp_buff_is_frag_pp(const struct xdp_buff *xdp)
>> +{
>> +	return !!(xdp->flags & XDP_FLAGS_FRAGS_PAGE_POOL);
>> +}
>> +
>>   static __always_inline u32 xdp_buff_get_skb_flags(const struct xdp_buff *xdp)
>>   {
>>   	return xdp->flags;
>> @@ -394,6 +412,15 @@ void xdp_convert_frame_to_buff(const struct xdp_frame *frame,
>>   	xdp->data_meta = frame->data - frame->metasize;
>>   	xdp->frame_sz = frame->frame_sz;
>>   	xdp->flags = frame->flags;
>> +	/*
>> +	 * frame->flags never carries XDP_FLAGS_FRAGS_PAGE_POOL (it is stripped
>> +	 * in xdp_update_frame_from_buff()); re-derive it from the frame's own
>> +	 * memory type. veth and devmap rebuild a buff here and run a program
>> +	 * whose rxq says MEM_TYPE_PAGE_SHARED, so without this a shrink would
>> +	 * free a page_pool frag through page_frag_free().
>> +	 */
>> +	if (frame->mem_type == MEM_TYPE_PAGE_POOL)
>> +		xdp_buff_set_frag_pp(xdp);
>>   }
>>   
>>   static inline
>> @@ -420,7 +447,8 @@ int xdp_update_frame_from_buff(const struct xdp_buff *xdp,
>>   	xdp_frame->headroom = headroom - sizeof(*xdp_frame);
>>   	xdp_frame->metasize = metasize;
>>   	xdp_frame->frame_sz = xdp->frame_sz;
>> -	xdp_frame->flags = xdp->flags;
>> +	/* XDP_FLAGS_FRAGS_PAGE_POOL is xdp_buff only, don't carry it over */
>> +	xdp_frame->flags = xdp->flags & ~XDP_FLAGS_FRAGS_PAGE_POOL;
> IIUC this is only necessary for the veth case, right? If so, I would suggest to
> move it in veth driver (or to have a helper function called just in veth).
>
> Regards,
> Lorenzo


Not only veth - cpumap and devmap call xdp_update_frame_from_buff() too,
and their buff came from xdp_convert_frame_to_buff(), which sets the bit
from frame->mem_type.

Without the strip it bites via xdpf_clone() (devmap broadcast):

     memcpy(addr, xdpf, totalsize);          /* copies flags as is */
     nxdpf->mem_type = MEM_TYPE_PAGE_ORDER0; /* flags left alone */

the clone ends up ORDER0 with the page_pool bit still set, so the next
xdp_convert_frame_to_buff() hands the prog a buff claiming page_pool
over an ORDER0 page.

