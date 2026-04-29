Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 677B444102D
	for <bpf@vger.kernel.org>; Wed, 29 Apr 2026 22:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777501453; cv=none; b=qJyo0bLX/2nKpcNk70Ad+TdxlNdy0Dxgs7y1MXLb/1dWYwHNMp0VJAw/p3rd3IthGuDfwptF+mYFvQjcE8DKhLDtbud1MopsQxFGt+dURspf7Lz5VREGvAHy3ngraK4JhbY9I9tOsU2Jq8iNpmrfJGIhTH6S8dRhPD4RNysCteI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777501453; c=relaxed/simple;
	bh=iGIx6eiN7zQf647BdAifVBOJdPODtS7g0KA82Nv/E78=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=iUivtZidBFnxnO69bSbo1r3g+bdyuJkpzFLxY8cFbJI8BTCeptgYeKYsGOzIbmM9ILSblWqjn08qyxaEDFqEDKgnXSL1gdQ55ao4BbWjrGpV1x7O84+vVITGgckGDVztfrQm4usyMAMUIllDF+K11WMA9g4O81x+5zlTG36oNRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=G+bp3Yla; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="G+bp3Yla"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id CE2D0A53A6;
	Thu, 30 Apr 2026 00:24:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1777501444; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=d4gXF/4TbLDUTUJqF5RI64DL4J7e89oj8p6pphOtx7M=;
	b=G+bp3YlaUDx29fwq+6erg9WliYTHzFtI7GxefrA92h/m0FiE2zJcEstVjQ4npNQ0eMx6dY
	AtuI8RiWjSXxP1+8GPVyj6DHcEB/n5KSQZJEjjWOYgfKboF8BOGacvXzJjWSlj8o/rkz06
	l2tcHcmyewXjHdJkP+yhUgDUB5s53st46Pq9i+QC6Jtj3kZAK1PITvHx2W8ugvicwf14rh
	W0tEQLahtqtPUcXDXyhsVnCUtKP86XD2wXNavh79D7GR5MSAXgmXqv4uyTlj59/h9/J5UJ
	kaRTlPeGGQ2WlT7mE2wscRJ0CEcDX2hVov97+T8UqYF1hYPMmLdcVHTSux+cRQ==
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 30 Apr 2026 00:24:04 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: sashiko@lists.linux.dev
Cc: bpf@vger.kernel.org
Subject: Re: [PATCH net-next v8 3/7] net: bcmgenet: add basic XDP support
 (PASS/DROP)
In-Reply-To: <20260429211701.55F2FC19425@smtp.kernel.org>
References: <20260428205846.2625550-4-nb@tipi-net.de>
 <20260429211701.55F2FC19425@smtp.kernel.org>
Message-ID: <eb3d0d5fc61f9d07c7ae20b3ec7760d9@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

On 29.4.2026 23:17, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential 
> issue(s) to consider:
> - [High] Hardware checksum offload (CHECKSUM_COMPLETE) is 
> unconditionally applied after XDP execution, causing valid modified 
> packets to be dropped.
> - [Medium] The driver advertises NETDEV_XDP_ACT_BASIC without 
> supporting XDP_TX, violating the XDP feature API contract.
> --
> 
> commit fcb14e148a380096868da445b34bcc00893540bf
> Author: Nicolai Buchwitz <nb@tipi-net.de>
> 
> net: bcmgenet: add basic XDP support (PASS/DROP)
> 
> This commit adds basic XDP support to the bcmgenet driver, allowing XDP
> programs to execute in the RX path with support for XDP_PASS and 
> XDP_DROP.
> 
>> diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c 
>> b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
>> --- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
>> +++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
> [ ... ]
>> @@ -2404,30 +2462,34 @@ static unsigned int bcmgenet_desc_rx(struct 
>> bcmgenet_rx_ring *ring,
> [ ... ]
>> +		/* Save rx_csum before XDP runs - an XDP program
>> +		 * could overwrite the RSB via bpf_xdp_adjust_head.
>>  		 */
>> +		if (dev->features & NETIF_F_RXCSUM)
>> +			rx_csum = (__force __be16)(status->rx_csum & 0xffff);
>> 
>> +		xdp_init_buff(&xdp, PAGE_SIZE, &ring->xdp_rxq);
>> +		xdp_prepare_buff(&xdp, page_address(rx_page),
>> +				 GENET_RX_HEADROOM, pkt_len, true);
>> 
>> +		xdp_act = bcmgenet_run_xdp(ring, xdp_prog, &xdp, rx_page);
>> +		if (xdp_act != XDP_PASS)
>> +			goto next;
>> 
>> +		skb = bcmgenet_xdp_build_skb(ring, &xdp);
>> +		if (unlikely(!skb)) {
>> +			BCMGENET_STATS64_INC(stats, dropped);
>> +			page_pool_put_full_page(ring->page_pool,
>> +						rx_page, true);
>> +			goto next;
>>  		}
>> 
>>  		/* Set up checksum offload */
>>  		if (dev->features & NETIF_F_RXCSUM) {
>> -			rx_csum = (__force __be16)(status->rx_csum & 0xffff);
>>  			if (rx_csum) {
>>  				skb->csum = (__force __wsum)ntohs(rx_csum);
>>  				skb->ip_summed = CHECKSUM_COMPLETE;
>>  			}
> 
> If the XDP program modifies the packet payload (e.g., rewriting IPs or
> ports), the hardware checksum saved before XDP execution will no longer 
> match
> the new payload.
> 
> If we unconditionally apply this old checksum and set CHECKSUM_COMPLETE 
> on
> the SKB here, will the network stack drop the valid modified packet due 
> to a
> hardware checksum failure?
> 
> Should the checksum be invalidated when an XDP program is present?

This is the standard pattern across XDP drivers (e.g. ice). With
CHECKSUM_COMPLETE, the stack performs software validation by combining
the hardware checksum with its own pseudo-header sum. If an XDP program
modifies the packet, validation fails and the stack drops the packet,
no silent corruption. XDP programs that modify packets and return PASS
are extremely rare; the common pattern is modify+TX/REDIRECT.

> 
> [ ... ]
>> @@ -4054,6 +4148,7 @@ static int bcmgenet_probe(struct platform_device 
>> *pdev)
>>  			 NETIF_F_RXCSUM;
>>  	dev->hw_features |= dev->features;
>>  	dev->vlan_features |= dev->features;
>> +	dev->xdp_features = NETDEV_XDP_ACT_BASIC;
>> 
>>  	netdev_sw_irq_coalesce_default_on(dev);
> 
> The commit message notes that XDP_TX is not yet supported and returns
> XDP_ABORTED.
> 
> The UAPI definition for NETDEV_XDP_ACT_BASIC implies support for 
> XDP_PASS,
> XDP_DROP, XDP_ABORTED, and XDP_TX. Does advertising this flag without 
> XDP_TX
> support break feature detection for userspace applications?
> 
> I see from the patch series that XDP_TX support is added in a later 
> commit.
> Would it be safer to defer setting NETDEV_XDP_ACT_BASIC until that 
> patch to
> avoid breaking userspace assumptions during a bisect?

Per <linux/netdev.h>, NETDEV_XDP_ACT_BASIC = "XDP features set supported
by all drivers (XDP_ABORTED, XDP_DROP, XDP_PASS, XDP_TX)". The XDP_TX
listed there is the BPF action constant, which is always handled (we
return XDP_ABORTED for unsupported actions, which is the documented
behavior). The driver-level XDP_TX *capability* is a separate flag
(NETDEV_XDP_ACT_XDP_TX), not implied by BASIC.

Thanks
Nicolai
