Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793872780;
	b=1Ow0zzz7Wyhw5eCCz7KQkhiJOOs3l2KECSHkTGyUaneJLHX2/pd8adsQHNP0jk85pGoM
	 Vm2xadkjbT2t2G5jxfJTgsejFG/HfVa8VUN9+NF58z9aTnTNy9LQIP8aMzEov5m4A3tcX
	 e1tVs/u+wS/yC26k4dFVs8trMFmQzk6fgaXkYm79GVVqhBwcXSvVECvy9Po7smXRH6Tn0
	 MZAHAj7M7EAI3qcgQzMyawMeZN4APdblo3Pn2DnqhFe5m742CehfmDHzXLxkVNXZ1+DDV
	 tB4R6SsR2w1Pq+1TaKvzAq3BpTEH22GiPGr2cnPf4JczxdNB75qOIiSF1puiSbrU0RA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793872780;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=DFynwRQzUygtrqE+QHjdbW9aoarxVpxVGzFfqPEgWug=;
	b=VxNRi+pnMBtgycTBoSknQ6p9BnCkj4g9U+i1KWD3GSKRjnEALuteQQAKcN4GU59Cv/zN
	 bIzR63t+1Nx2YMw0OgSc+Fpdxp2UYgD1qy2zDRHS51jdnjFyUmeQ/FReLn4Tkd40HHYw9
	 LXBkqvs16P5bo5B5fZw2MB0XUzxIB6F2lM0tPRkOU0NStg43wmJ6xjQbGagxol+A4Gcpr
	 MaEMsboKq7AzoVbZ8sfSoRTozFjcU2xwRh9ch2ZNkn71IafCPdfvxsLUW0aJYPbmkUUbZ
	 5Tgw/zdBsbRievCsV/q4UQIPxcd5yjLe4osEwu0OjoET7kaLZgb3ajKVSRTEmicH3dA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LnApAkbW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 569C5606A326;
	Thu,  5 Nov 2026 09:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LnApAkbW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AB481F000C1;
	Thu,  5 Nov 2026 09:59:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793872780;
	bh=DFynwRQzUygtrqE+QHjdbW9aoarxVpxVGzFfqPEgWug=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=LnApAkbWfIGnF9Whko+YqQC0EYPDHDdMbqIKDsR+QoiyOcol1rAVwCFi2+s5vcoC5
	 3aepn9+5lv/GLJejO/RHud648OqqmhJIBx2qDgSS+OabJyGaMdkqLqf+2IWARJWfKJ
	 f8Ua9mRFVKPchgEiq67H+wNd/+HM1fjXZG7NTFsP7dOJThiCgi2pqD3+uPG4L88aXD
	 udzc9sTWXQi9uweVeAioCtlS/5f96NWxLSGHJwXnwAnaDMUkzy8/tt+21zAizMfiRq
	 KK2a9tQO0amZGP8GRarVnB5DXKr0D6YyEPDx2h3lqJzMkYVFsQBVHDHlhTD+SreR2r
	 5WeM7rRBn78GQ==
Message-ID: <833b2ebf-ac7c-42b1-bb75-2fc56e0f0fbe@kernel.org>
Date: Thu, 5 Nov 2026 10:59:34 +0100
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 bpf 0/3] xdp: fix page_pool leaks
To: Slawomir Stepien <sst@poczta.fm>,
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: ast@kernel.org, daniel@iogearbox.net, davem@davemloft.net,
 kuba@kernel.org, john.fastabend@gmail.com, sdf@fomichev.me,
 netdev@vger.kernel.org, bpf@vger.kernel.org, magnus.karlsson@intel.com,
 aleksander.lobakin@intel.com, ilias.apalodimas@linaro.org, toke@redhat.com,
 lorenzo@kernel.org, ihor.solodrai@linux.dev, tavip@google.com,
 Tianyi Gao <tianyi@cloudflare.com>
References: <20261104121316.1155680-1-sst@poczta.fm> <ausorQSZn/tuxUWg@boxer>
 <auw7ofYYYwOoGH2d@nr200>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <auw7ofYYYwOoGH2d@nr200>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/5/26 09:17, Slawomir Stepien wrote:
> On lis 04, 2026 13:44, Maciej Fijalkowski wrote:
>> On Wed, Nov 04, 2026 at 01:13:13PM +0100, Slawomir Stepien wrote:
>>> v1:
>>> https://lore.kernel.org/bpf/20251003140243.2534865-1-maciej.fijalkowski@intel.com/
>>> v1->v2:
>>> - add skb to xdp_buff converter (Jakub)
>>> - postpone restoration of veth's xdp_rxq_info mem model (AI)
>>>
>>> v2:
>>> https://lore.kernel.org/bpf/20251017143103.2620164-1-maciej.fijalkowski@intel.com/T/
>>> v2->v3:
>>> - make skb->xdp_buff conversion agnostic of current skb->data position
>>>    (Toke)
>>> - do not pull mac header in veth (Toke)
>>> - use virt_to_head_page() when checking if xdp->data comes from
>>>    page_pool (Olek)
>>> - add ack from Toke
>>>
>>> v3:
>>> https://lore.kernel.org/bpf/20251022125209.2649287-1-maciej.fijalkowski@intel.com/
>>> v3->v4:
>>> - include skb->head when calculating packet length (Toke, lkp)
>>>
>>> v4:
>>> https://lore.kernel.org/bpf/20251027121318.2679226-1-maciej.fijalkowski@intel.com/
>>> v4->v5:
>>> - rely again on sk_buff::pp_recycle when setting mem type on rxq
>>>    (Jesper, Jakub)
>>> - add ack from Toke on patch 2 and restore it on patch 1
>>>
>>> v5:
>>> https://lore.kernel.org/bpf/20251029221315.2694841-1-maciej.fijalkowski@intel.com/
>>> v5->v6:
>>> - rebase onto bpf/master
>>> - patch 1: set MEM_TYPE_PAGE_POOL unconditionally in
>>>    xdp_convert_skb_to_buff(); mem type only matters for frags consumed
>>>    by the program, and those always come from skb_pp_cow_data() (Jakub)
>>> - patch 1: add DEBUG_NET_WARN_ON_ONCE() for a non-linear skb without
>>>    pp_recycle and document the expectation in kdoc (Jakub); the warning
>>>    is limited to non-linear skbs since linear ones legitimately skip
>>>    the CoW
>>> - new patch 2: veth_xdp_rcv_one() ran the program on an xdp_frame with
>>>    whatever mem type the previous packet left on rq->xdp_rxq; use the
>>>    frame's mem type instead, as cpumap and devmap do. With patch 3 alone
>>>    veth sends page_pool frames to its peer and the peer's program
>>>    trimming frags crashed the kernel, so this comes first
>>> - patch 3 (was 2): veth turns the buff into an xdp_frame on
>>>    XDP_{TX,REDIRECT}, so the head is released through mem type too;
>>>    keep the queue's original model unless the buffer was copied into
>>>    rq->page_pool (Jakub)
>>> - patch 3: take page_pool refs on compound heads via netmem helpers
>>> - patch 3: do not restore the rxq mem model after XDP_{TX,REDIRECT}
>>>    and on the error path; with patch 2 every path sets its own mem type
>>> - patch 3: veth can now redirect MEM_TYPE_PAGE_POOL frames, which needs
>>>    commit b3ca872947ef ("bpf: Use the frame mem type in devmap egress
>>>    XDP") in devmap; list it as a stable prerequisite
>>> - drop Reviewed-by/Tested-by tags as patches 1 and 3 changed
>>
>> I mentioned the changes [0] that were developed after v5 revision yet you
>> decided to go with what you had - that might be okay but to be transparent
>> it would be worth stating *why* you chose not to pursue further or explore
>> approach where __do_xdp_generic() is called from veth.
>>
>> Was it due to semantics change pointed out by Bjorn? Or is it too big a
>> hammer for fixing page_pool leaks and should be implemented as a
>> follow-up?
> 
> That. For me, at this point in time it is easier to reason about the fix first rather than refactor.
> 

I like approach where __do_xdp_generic() is called from veth.
Look at patch link[0] below - how much (ugly) code is removed from veth.c

>> Regardless, thank you for reviving this work, I am to blame for not
>> dedicating further effort here.
> 
> No worries Maciej! You did a great job and I think it is worth pushing.
> 
>> [0]: https://lore.kernel.org/bpf/20260509084858.773921-5-maciej.fijalkowski@intel.com/
>>
I like how much code this [0] patch removes. Especially removing the
ugly veth_xdp_get() function that manipulate the refcnt directly on pages.

Thanks for working on this, much appreciated!

--Jesper

Cc. Tianyi Gao <tianyi@cloudflare.com> whom is working on improving veth
for Cloudflare use-cases.


