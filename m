Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49C353AD505
	for <bpf@vger.kernel.org>; Wed, 29 Apr 2026 22:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777501714; cv=none; b=NxzJRBjSUrx/4ue6lZLyADT1DfnymIr31SOAz74/JV93y9eP0MVvYkwJu+I4AT6UJj/1uVuTJs3tnehRJ9Uc9bPVJqioPHcNFtHPZb6KR3NjxoVbl+UBkOHvtvhVb48wOzZXyzbhNFRJIZqk2ERMVhn89K2fmnZk+nEWmM41fSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777501714; c=relaxed/simple;
	bh=aNm+s0txs9FKI9MwjARfAGhmgLZ1ncukDcZzugZgzoI=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=Jh5pPj9z+yTBU7GRE9nUnuzX4ERauxsxLnaExov2zJPO672edOrGKsJaiKaO2mYbpJPC82rgpCBZnx2f36USLQG4MLclKX+SCCmgnq8btAq9HtBzQHuS0x2uGW0LU+d1vNbMugh+RQ1iMxb8CVPe127lxqSQeWZEpxceUPSaZPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=hVE8HD3y; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="hVE8HD3y"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C4EC4A5338;
	Thu, 30 Apr 2026 00:28:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1777501707; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=hDckQNXjFAqW+Wij25qyaXDy5zQYlGqCmZLO5d2LLeY=;
	b=hVE8HD3y1DD8v5oVGykHzYiYM2oEaRSgROr14+0PqAMPZGPWCUtVmxCaYyEmEqWyZDHxk7
	LFQHA1fHaWGFfgEXPv/9sTDn1KFumdOpE0UqSPRZSpB6lVupgXvpQ0SbMrz70vWr+jHC8a
	T0xphsCxpBc3K7rctDU7PY9jdAmDAM4sKm1SYHOXfe/5kvgK2ol5K0KZ5bYamm86Le0ZtL
	jbOF4xb7K6kuh4uGl3i5iilr3giqygcb2vOal9GRihUUoeBBZF7QBrGofeP49j3KbirFiS
	Gnzi380z1nID68GxZX1fLjhUvXqfdWOJbdMAf473XlG2SGrOs8H52jIllUsNeA==
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 30 Apr 2026 00:28:27 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: sashiko@lists.linux.dev
Cc: bpf@vger.kernel.org
Subject: Re: [PATCH net-next v8 4/7] net: bcmgenet: add XDP_TX support
In-Reply-To: <20260429211702.42E86C2BCB4@smtp.kernel.org>
References: <20260428205846.2625550-5-nb@tipi-net.de>
 <20260429211702.42E86C2BCB4@smtp.kernel.org>
Message-ID: <362a57c57af4eecd5214ea49070811f8@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

On 29.4.2026 23:17, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 4 potential 
> issue(s) to consider:
> - [High] Out-of-bounds array access in `bcmgenet_tx_reclaim` during 
> interface teardown
> - [High] Incorrect DMA address calculation for local XDP_TX causes 
> information leak and packet corruption
> - [High] Prepending `status_64` block overwrites XDP metadata and 
> causes memory corruption
> - [Medium] XDP TX ring size is smaller than standard NAPI budget
> --
> 
> commit 9add891fa4e7cf62ec26683116338b5877c21662
> Author: Nicolai Buchwitz <nb@tipi-net.de>
> 
> net: bcmgenet: add XDP_TX support
> 
> Implement XDP_TX using ring 16 (DESC_INDEX), the hardware default
> descriptor ring, dedicated to XDP TX for isolation from SKB TX queues.
> 
>> diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c 
>> b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
>> index 1b60571446e1..3c3b0c44ea8a 100644
>> --- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
>> +++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
>> @@ -48,8 +48,10 @@
>> 
>>  #define GENET_Q0_RX_BD_CNT	\
>>  	(TOTAL_DESC - priv->hw_params->rx_queues * 
>> priv->hw_params->rx_bds_per_q)
>> +#define GENET_Q16_TX_BD_CNT	32
> 
> Is it possible to drop packets here during bursts since this TX ring is 
> smaller
> than the standard NAPI budget?

Yes, by design. If the ring fills, frames are dropped, which is standard
XDP backpressure. Same approach as bnxt, mvneta, and other drivers.

> 
> The standard RX NAPI budget is 64, and TX completions are reclaimed 
> only once
> before the RX loop. If the RX loop processes a full budget of 64 
> packets and
> they all result in an XDP_TX action, the first 32 will fill the TX 
> ring.
> 
> The remaining 32 packets would fail in bcmgenet_xdp_xmit_frame() 
> because
> ring->free_bds < 1, and be dropped.
> 
> [ ... ]
>> @@ -2043,6 +2069,9 @@ static void bcmgenet_tx_reclaim_all(struct 
>> net_device *dev)
>>  	do {
>>  		bcmgenet_tx_reclaim(dev, &priv->tx_rings[i++], true);
>>  	} while (i <= priv->hw_params->tx_queues && 
>> netif_is_multiqueue(dev));
>> +
>> +	/* Also reclaim XDP TX ring */
>> +	bcmgenet_tx_reclaim(dev, &priv->xdp_tx_ring, true);
>>  }
> 
> Can this cause an out-of-bounds array access during interface teardown?
> 
> When bcmgenet_tx_reclaim_all() calls bcmgenet_tx_reclaim() with all == 
> true,
> it unconditionally calls netdev_tx_reset_queue(netdev_get_tx_queue(dev, 
> ring->index)).

bcmgenet_tx_reclaim() does not call netdev_tx_reset_queue() or
netdev_get_tx_queue(). The only netdev_get_tx_queue() in the reclaim
path (in __bcmgenet_tx_reclaim, for BQL) is guarded by
"if (ring->index != DESC_INDEX)". The netdev_tx_reset_queue() loop in
bcmgenet_fini_dma() iterates indices 0..tx_queues only.

> 
> The XDP TX ring has an index of 16 (DESC_INDEX), but the network device 
> is
> allocated with only GENET_MAX_MQ_CNT + 1 TX queues (typically 5). 
> Accessing
> index 16 of dev->_tx is out-of-bounds, and netdev_tx_reset_queue() will 
> write
> to this invalid memory.
> 
> [ ... ]
>> @@ -2299,11 +2328,96 @@ static struct sk_buff 
>> *bcmgenet_xdp_build_skb(struct bcmgenet_rx_ring *ring,
>>  	return skb;
>>  }
>> 
>> +static bool bcmgenet_xdp_xmit_frame(struct bcmgenet_priv *priv,
>> +				     struct xdp_frame *xdpf, bool dma_map)
>> +{
> [ ... ]
>> +	if (dma_map) {
> [ ... ]
>> +	} else {
>> +		struct page *page = virt_to_page(xdpf->data);
>> +
>> +		/* For local XDP_TX the caller already prepended the TSB
>> +		 * into xdpf->data/len, so dma_len == xdpf->len.
>> +		 */
>> +		dma_len = xdpf->len;
>> +		mapping = page_pool_get_dma_addr(page) +
>> +			  sizeof(*xdpf) + xdpf->headroom;
> 
> Does this calculation result in an incorrect DMA address?
> 
> The calculation implicitly assumes that xdpf resides exactly at the 
> beginning
> of the page. However, the driver configures the RX page pool with
> offset = XDP_PACKET_HEADROOM (typically 256 bytes).
> 
> By omitting the distance from the start of the page to xdpf, the 
> calculated
> DMA address points XDP_PACKET_HEADROOM bytes before the actual packet 
> data,
> which could lead to transmitting uninitialized memory.

Correct, xdpf does reside at the start of the page. 
xdp_convert_buff_to_frame()
stores the xdp_frame at xdp->data_hard_start, which equals 
page_address(page)
for our page_pool layout. page_pool_get_dma_addr() returns the DMA 
address
of the page start (not offset by .offset). sizeof(*xdpf) + 
xdpf->headroom
equals xdpf->data - data_hard_start, pointing to the prepended TSB.

> 
>> +		dma_sync_single_for_device(kdev, mapping, dma_len,
>> +					   DMA_BIDIRECTIONAL);
>> +	}
> [ ... ]
>> +	case XDP_TX:
>> +		/* Prepend a zeroed TSB (Transmit Status Block).  The GENET
>> +		 * MAC has TBUF_64B_EN set globally, so hardware expects every
>> +		 * TX buffer to begin with a 64-byte struct status_64.  Back
>> +		 * up xdp->data into the RSB area (which is no longer needed
>> +		 * after the BPF program ran) and zero it.
>> +		 */
>> +		if (xdp->data - xdp->data_hard_start <
>> +		    sizeof(struct status_64) + sizeof(struct xdp_frame)) {
>> +			page_pool_put_full_page(ring->page_pool, rx_page,
>> +						true);
>> +			return XDP_DROP;
>> +		}
>> +		xdp->data -= sizeof(struct status_64);
>> +		xdp->data_meta -= sizeof(struct status_64);
>> +		memset(xdp->data, 0, sizeof(struct status_64));
> 
> Could this overwrite XDP metadata and cause memory corruption?

xdp_convert_buff_to_frame() validates (headroom - metasize) >=
sizeof(struct xdp_frame) and returns NULL otherwise; we drop the frame
in that case. The memset writes to [xdp->data - 64, xdp->data] before
the data shift, which was previously the RSB area, not the metadata
area. Both data and data_meta are shifted equally, preserving the
metasize gap.

> 
> The space check does not account for metasize (xdp->data - 
> xdp->data_meta).
> If the BPF program appended metadata, the memset() here completely 
> overwrites
> it.
> 
> Furthermore, if metasize is > 0, the shifted xdp->data_meta pointer 
> could
> underflow and point exactly to or before xdp->data_hard_start. When
> xdp_convert_buff_to_frame() is subsequently called, it writes the 
> xdp_frame
> structure at data_hard_start, which would overlap with the shifted 
> data_meta.

Thanks
Nicolai
