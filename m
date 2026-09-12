Received: from mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E038830F924
	for <bpf@vger.kernel.org>; Sat, 12 Sep 2026 02:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789180099; cv=none; b=tLoOKce/OYaBfdtLZGyBwDT7jCpf09YaMsz/YmZWIgUsVaUDslGofj8/fd8Oh7uqQMHwJu1S53dTBCu7Vu5WStp69VTrxRLy5Fb89RU2XblVgrp76noW4CXghxeWuF8L9OfIuW6Gt0D5E67asKWt1bI4fd2qGqrJbVj2NPh2Kcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789180099; c=relaxed/simple;
	bh=Yfe9l32DMYQCUL9qWKud4tySomIrKoZvFPcCYvrVMu8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uj8QJmew4KAcF5GPNNv0AnlLwhM2/aREs+ow8XWqvah/TT96/wn2TCaLKvZ0vlxAYk15OguMEFA4fsPL1j0MDJIUEk+z4AJXpfD556dlIERSUyrmOCB3ArV5wE7TEne7hlaRQS4UOoyuHbD4SssThnmKwtjGbLWPlwaq8eaOf1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=IJKk7iu2; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="IJKk7iu2"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=Yfe9l32DMYQCUL9qWKud4tySomIrKoZvFPcCYvrVMu8=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789180094; v=1; x=1789784894;
 b=IJKk7iu2CiQ9Eb+YRMEhMMtb7wd95tBcUYNwCymmJWQ8cFCYaIaZD7ioYtJ4OgGnnd83mFqx
 0E3hvA2P4NH0hnLXihxGxBmOS5rGhdp/Sw2E/Nfk8v8YyYI+zfmqTEfF7jDgAkBFiRD4sZ9SmSo
 +B9MSKWYrHPGwiINsMU8o3ak=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id c45397abb0f02fb6;
	Sat, 12 Sep 2026 02:28:14 +0000
X-Mizu-Trace-ID: c45397abb0f02fb6
X-Migadu-Flow: FLOW_OUT
Message-ID: <c8069a81-d9f1-4f0a-a0e0-58300080557a@linux.dev>
Date: Sat, 12 Sep 2026 10:28:11 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf v3 1/2] bpf, veth: xdp: fix page_pool page leak on
 skb-backed XDP
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260911135711.109338-1-jiayuan.chen@linux.dev>
 <20260911135711.109338-2-jiayuan.chen@linux.dev>
 <20260911143643.402B51F000FF@smtp.kernel.org>
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <20260911143643.402B51F000FF@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 9/11/26 10:36 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
>
> Pre-existing issues:
> - [High] veth_xdp_rcv_one() overwrites shared per-queue rq->xdp_rxq.mem.type state, corrupting subsequent SKB processing in the same NAPI poll and causing kernel panics.
> --
>
> commit 6d121019cfea2f329267400ac7c2525a49f34f53
> Author: Jiayuan Chen <jiayuan.chen@linux.dev>
>
>      bpf, veth: xdp: fix page_pool page leak on skb-backed XDP
>      
>      bpf_xdp_shrink_data() frees a released frag via __xdp_return() using
>      xdp->rxq->mem.type, but that type is wrong for skb-backed XDP: the skb is
>      cow'd into page_pool memory while the rxq still says MEM_TYPE_PAGE_SHARED.
>      This fixes the resulting page pool panics by recording the memory type in
>      the xdp_buff flags instead.
>
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
>>   	} else {
>>   		xdp_buff_clear_frags_flag(xdp);
>>   	}
> [Severity: High]
> This isn't a bug introduced by this patch, but can the shared per-queue memory
> type state be clobbered during a mixed batch?
>
> In veth_xdp_rcv_one(), the shared rq->xdp_rxq.mem.type state is overwritten
> with the incoming frame's type without being restored:
>
> veth_xdp_rcv_one() {
>      ...
>      case XDP_REDIRECT:
>          orig_frame = *frame;
>          xdp->rxq->mem.type = frame->mem_type;
>      ...
> }
>
> If a single NAPI poll (veth_xdp_rcv) processes a batch containing a native
> xdp_frame (e.g. MEM_TYPE_XSK_BUFF_POOL) followed by a standard sk_buff, the


The premise doesn't hold here: frame->mem_type is never 
MEM_TYPE_XSK_BUFF_POOL.


A zc buff gets copied out before it can ever become a frame. 
xdp_convert_buff_to_frame() sends

every XSK buff to xdp_convert_zc_to_xdp_frame(), and that one does:

     xdpf->mem_type = MEM_TYPE_PAGE_ORDER0;

     xsk_buff_free(xdp);


so the plain "xdp_frame->mem_type = xdp->rxq->mem.type" further down 
only ever sees non-XSK types.

I grepped the tree and the only things that ever  end up in a frame's 
mem_type are PAGE_SHARED,

PAGE_POOL and PAGE_ORDER0. So "xdp->rxq->mem.type = frame->mem_type" in 
veth_xdp_rcv_one() can't put

XSK in there, and the XSK branch in bpf_xdp_shrink_data() is simply not 
reachable from veth.


> next packet will be processed with the clobbered rxq->mem.type.
>
> When veth_xdp_rcv_skb() processes the subsequent sk_buff, the BPF program
> is executed with this clobbered state:
>
> veth_xdp_rcv_skb() {
>      ...
>      act = bpf_prog_run_xdp(xdp_prog, xdp);
>      ...
> }
>
> If this clobbered memory type is read by helpers like bpf_xdp_shrink_data(),
> could it lead to a kernel panic? For instance, if clobbered to XSK_BUFF_POOL,
> it would erroneously call xsk_buff_free() on a standard xdp_buff, resulting
> in a garbage dereference.
>
