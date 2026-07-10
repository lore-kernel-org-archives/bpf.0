Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC0336A379
	for <bpf@vger.kernel.org>; Fri, 10 Jul 2026 17:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783705097; cv=none; b=hHP3+IScI+M35H60WzPFLnMCO9ZwxLcfrrBdnmi72VMfK4g+VlB3ainrs6UDb4r+Nx7uGjdVNvvBVGsF6mpvdTKd2PBZSTgXchb2gr3+44QZu7cT6DO9qZnpE3EcgmleXKgK70acIon9XHokF3OcKGrT/ESihxedxWZellOAb00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783705097; c=relaxed/simple;
	bh=xqmBs9nRsDs2OdV/mGmPRCDiikdU9VPQgNarYNuO6vs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ekSA7yG2oH9f+BF8I+2gnz+AhX86ZAxR/YyOAW5YnkhmNVIFetvyj7aEDYjEkO709QskxHRgbqs4unepbBmhIWRRg2fLmAIT6h2wCc41D4wgV9U6Zj+hoQmLRM+s1snrpvQmtD2kf2PhrV9vvVx0JrM0UXrRqmlshFepqWbIfxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZgdUhilu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZgdUhilu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE08B1F00A3A;
	Fri, 10 Jul 2026 17:38:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783705096;
	bh=gj85/WBfT6jiCym8zFm8Q5J7zi4JCJ2+5+QvVNpMWgg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZgdUhiluaVn3OOP/kU7D4WoM9BnG91WWjcXm0zaqWgu9rv0wEyZvET/+4WDGUiiGj
	 l3si8hTgvl3prFZr28LAKBeVUNxs25UwgSyyqQ4OmarXQX3I+5cPFvGi+HjkuWg7+h
	 qRRzqOm2BlzAUiGFRLpuiVrwhWM1rCHwVJDk52YBJeoSp+0lsU8uIEsxwwefG6EFzY
	 3TLJZoVIUaFVTg+JKR3ruVXIUFA4o+zH+dAxQm9Br0Qy/LU48IyLVfdN1Z8rvUe0w6
	 Xse63M4ZbNq3zJtAa0wZ6kuPQFBvSUJlISIFLT7Ge3snV+hmNduvqaEADiAHNdotmS
	 tZJ5nXQNda9GA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next 2/2] net: atlantic: convert RX path to
 page_pool
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yangyu Chen" <cyy@cyyself.name>
Cc: bpf@vger.kernel.org
In-Reply-To: <tencent_164779DC8B18AB10B9C636BE23C178ED5907@qq.com>
References: <tencent_7DB01BE7F8FA056BB5F11D3570CF636C4309@qq.com>
 <tencent_164779DC8B18AB10B9C636BE23C178ED5907@qq.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 Jul 2026 17:38:15 +0000
Message-Id: <20260710173815.DE08B1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

New issues:
- [Critical] Uninitialized physical addresses cause severe DMA memory corru=
ption during RX buffer refill.

Pre-existing issues:
- [High] The ndo_xdp_xmit callback violates API contract by not repacking a=
rrays on failure, causing UAF and memory leaks.
- [High] Malformed RX packets exceeding MAX_SKB_FRAGS cause a permanent inf=
inite NAPI polling loop.
- [High] Aborting XDP assembly on oversized packets leaves trailing fragmen=
ts uncleaned, leading to packet injection.
- [High] Updating u64_stats without disabling preemption causes a system li=
velock on 32-bit architectures.
--

--- Patch [2]: [PATCH net-next 2/2] net: atlantic: convert RX path to page_=
pool ---
commit d3fa6dc4118e01fdb55de72ea89c2b574594ac08
Author: Yangyu Chen <cyy@cyyself.name>

net: atlantic: convert RX path to page_pool

This commit converts the atlantic driver's RX path to use page_pool for
fragment management to reduce DMA map/unmap overhead. It also registers the
PTP RX ring's xdp_rxq and cleans up deprecated ethtool counters.

> diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_ring.c b/drivers/n=
et/ethernet/aquantia/atlantic/aq_ring.c
> index c59b6c0b37f1e..e06c502b59f95 100644
> --- a/drivers/net/ethernet/aquantia/atlantic/aq_ring.c
> +++ b/drivers/net/ethernet/aquantia/atlantic/aq_ring.c

[ ... ]

> -static int aq_get_rxpages(struct aq_ring_s *self, struct aq_ring_buff_s =
*rxbuf)
> +static int aq_get_rxpages(struct aq_ring_s *self, struct aq_ring_buff_s =
*rxbuf)
>  {
> -	unsigned int order =3D self->page_order;
> -	u16 page_offset =3D self->page_offset;
> -	u16 frame_max =3D self->frame_max;
> -	u16 tail_size =3D self->tail_size;
> -	int ret;
> -
> -	if (rxbuf->rxdata.page) {
> -		/* One means ring is the only user and can reuse */
> -		if (page_ref_count(rxbuf->rxdata.page) > 1) {
> -			/* Try reuse buffer */
> -			rxbuf->rxdata.pg_off +=3D frame_max + page_offset +
> -						tail_size;
> -			if (rxbuf->rxdata.pg_off + frame_max + tail_size <=3D
> -			    (PAGE_SIZE << order)) {
> -				u64_stats_update_begin(&self->stats.rx.syncp);
> -				self->stats.rx.pg_flips++;
> -				u64_stats_update_end(&self->stats.rx.syncp);
> -
> -			} else {
> -				/* Buffer exhausted. We have other users and
> -				 * should release this page and realloc
> -				 */
> -				aq_free_rxpage(&rxbuf->rxdata,
> -					       aq_nic_get_dev(self->aq_nic));
> -				u64_stats_update_begin(&self->stats.rx.syncp);
> -				self->stats.rx.pg_losts++;
> -				u64_stats_update_end(&self->stats.rx.syncp);
> -			}
> -		} else {
> -			rxbuf->rxdata.pg_off =3D page_offset;
> -			u64_stats_update_begin(&self->stats.rx.syncp);
> -			self->stats.rx.pg_reuses++;
> -			u64_stats_update_end(&self->stats.rx.syncp);
> -		}
> +	unsigned int size =3D self->page_offset + self->frame_max +
> +			    self->tail_size;
> +	unsigned int pg_off;
>  	struct page *page;
> -	int ret =3D -ENOMEM;
> -	dma_addr_t daddr;
> -
> -	page =3D dev_alloc_pages(order);
> -	if (unlikely(!page))
> -		goto err_exit;
> =20
> -	daddr =3D dma_map_page(dev, page, 0, PAGE_SIZE << order,
> -			     DMA_FROM_DEVICE);
> +	/* Buffers whose page was not passed up the stack are reposted
> +	 * with the data they already carry discarded.
> +	 */
> +	if (rxbuf->rxdata.page)
> +		return 0;
> =20
> -	if (unlikely(dma_mapping_error(dev, daddr)))
> -		goto free_page;
> -
> -	rxpage->page =3D page;
> -	rxpage->daddr =3D daddr;
> -	rxpage->order =3D order;
> -	rxpage->pg_off =3D rx_ring->page_offset;
> -
> -	return 0;
> -
> -free_page:
> -	__free_pages(page, order);
> -
> -err_exit:
> -	return ret;
> -}
> -
> -static int aq_get_rxpages(struct aq_ring_s *self, struct aq_ring_buff_s =
*rxbuf)
> -{
> -	unsigned int order =3D self->page_order;
> -	u16 page_offset =3D self->page_offset;
> -	u16 frame_max =3D self->frame_max;
> -	u16 tail_size =3D self->tail_size;
> -	int ret;
> -
> -	if (rxbuf->rxdata.page) {
> -		/* One means ring is the only user and can reuse */
> -		if (page_ref_count(rxbuf->rxdata.page) > 1) {
> -			/* Try reuse buffer */
> -			rxbuf->rxdata.pg_off +=3D frame_max + page_offset +
> -						tail_size;
> -			if (rxbuf->rxdata.pg_off + frame_max + tail_size <=3D
> -			    (PAGE_SIZE << order)) {
> -				u64_stats_update_begin(&self->stats.rx.syncp);
> -				self->stats.rx.pg_flips++;
> -				u64_stats_update_end(&self->stats.rx.syncp);
> -
> -			} else {
> -				/* Buffer exhausted. We have other users and
> -				 * should release this page and realloc
> -				 */
> -				aq_free_rxpage(&rxbuf->rxdata,
> -					       aq_nic_get_dev(self->aq_nic));
> -				u64_stats_update_begin(&self->stats.rx.syncp);
> -				self->stats.rx.pg_losts++;
> -				u64_stats_update_end(&self->stats.rx.syncp);
> -			}
> -		} else {
> -			rxbuf->rxdata.pg_off =3D page_offset;
> -			u64_stats_update_begin(&self->stats.rx.syncp);
> -			self->stats.rx.pg_reuses++;
> -			u64_stats_update_end(&self->stats.rx.syncp);
> -		}
> +	page =3D page_pool_dev_alloc_frag(self->pg_pool, &pg_off, size);
> +	if (unlikely(!page)) {
> +		u64_stats_update_begin(&self->stats.rx.syncp);
> +		self->stats.rx.alloc_fails++;
> +		u64_stats_update_end(&self->stats.rx.syncp);

[Severity: High]
This is a pre-existing issue, but can this cause a system livelock on 32-bit
architectures?

The u64_stats_update_begin() function is called here in process context
(e.g., during aq_ring_rx_fill() via aq_vec_start()) without disabling
preemption.

If a writer is preempted by a reader (such as ndo_get_stats64() invoked from
a different CPU), the reader will spin forever in the
u64_stats_fetch_retry() loop on 32-bit systems because the sequence counter
will never become even.

> +		return -ENOMEM;
> +	}
> =20
> -	if (!rxbuf->rxdata.page) {
> -		ret =3D aq_alloc_rxpages(&rxbuf->rxdata, self);
> -		if (ret) {
> -			u64_stats_update_begin(&self->stats.rx.syncp);
> -			self->stats.rx.alloc_fails++;
> -			u64_stats_update_end(&self->stats.rx.syncp);
> -		}
> -		return ret;
> -	}
> +	rxbuf->rxdata.page =3D page;
> +	rxbuf->rxdata.daddr =3D page_pool_get_dma_addr(page);
> +	rxbuf->rxdata.pg_off =3D pg_off + self->page_offset;

[Severity: Critical]
Can this cause severe DMA memory corruption during RX buffer refill?

The initialization of buff->pa appears to be missing or was removed here,
but the hardware callback still executes immediately after and
unconditionally overwrites the descriptor's physical address:

hw_atl_b0_hw_ring_rx_fill() {
    ...
    rxd->buf_addr =3D buff->pa;
    rxd->hdr_addr =3D 0U;
    ...
}

Because buff->pa is no longer initialized for RX, it contains garbage from
the previous packet (specifically rss_hash and next, due to the union in
the aq_ring_buff_s struct).

This programs the NIC with arbitrary physical addresses, causing it to DMA
incoming network packets into random physical memory.

[ ... ]

> @@ -438,22 +380,15 @@ int aq_xdp_xmit(struct net_device *dev, int num_fra=
mes,
>  }

[Severity: High]
This is a pre-existing issue, but does the error handling in aq_xdp_xmit()
violate the ndo_xdp_xmit API contract?

When transmitting a batch of XDP frames, if a frame in the middle fails
(returning NETDEV_TX_BUSY), the function increments a drop counter and
returns num_frames - drop:

aq_xdp_xmit() {
    ...
    if (aq_nic_xmit_xdpf(aq_nic, ring, xdpf) =3D=3D NETDEV_TX_BUSY)
        drop++;
    ...
    return num_frames - drop;
}

The loop drops frames but does not repack the frames array. The network
stack (e.g., devmap) assumes that a partial success count N means the first
N frames succeeded and the rest failed.

It will free the frames at the end of the array, some of which were actually
successfully queued for transmission by the driver. This leads to freeing
memory that the NIC is actively trying to DMA, while leaking the memory of
the frame that actually failed.

[ ... ]

> @@ -547,8 +490,11 @@ static bool aq_add_rx_fragment(struct device *dev,
>  	do {
>  		skb_frag_t *frag;
> =20
> -		if (unlikely(sinfo->nr_frags >=3D MAX_SKB_FRAGS))
> +		if (unlikely(sinfo->nr_frags >=3D MAX_SKB_FRAGS)) {
> +			/* Attached frags must reach xdp_return_buff() */
> +			xdp_buff_set_frags_flag(xdp);
>  			return true;

[Severity: High]
This is a pre-existing issue, but does aborting XDP assembly on oversized
packets leave trailing fragments uncleaned?

When an RX packet exceeds MAX_SKB_FRAGS during XDP processing, this early
return aborts but fails to set buff_->is_cleaned =3D 1 for the remaining
descriptors of the malformed packet.

The outer loop in __aq_ring_xdp_clean() handles the abort by advancing
sw_head by 1. Because the trailing fragments were never marked as cleaned,
subsequent iterations of the loop will encounter them and incorrectly parse
them as the Start-Of-Packet (SOP) for new frames.

This forces the driver to interpret raw middle-of-packet payload data as
Ethernet/IP headers, leading to arbitrary packet injection.

> +		}
> =20
>  		frag =3D &sinfo->frags[sinfo->nr_frags++];
>  		buff_ =3D &ring->buff_ring[buff_->next];

[ ... ]

> @@ -675,6 +626,7 @@ static int __aq_ring_rx_clean(struct aq_ring_s *self,=
 struct napi_struct *napi,
>  			err =3D -ENOMEM;
>  			goto err_exit;
>  		}
> +		skb_mark_for_recycle(skb);

[Severity: High]
This is a pre-existing issue, but does the bailout logic in
__aq_ring_rx_clean() create an unrecoverable infinite loop?

If a remote attacker sends a highly fragmented or malformed packet that
spans more than MAX_SKB_FRAGS descriptors, the driver detects this and
jumps to err_exit:

__aq_ring_rx_clean() {
    ...
    if (unlikely(!is_rsc_completed) || frag_cnt > MAX_SKB_FRAGS) {
        err =3D 0;
        goto err_exit;
    }
    ...
}

Because it bails out without advancing the sw_head ring pointer or dropping
the packet, the driver will process the exact same malformed packet on the
next NAPI poll, hit the exact same condition, and bail out again.

This creates a permanent infinite loop in softirq context, leading to a
complete denial of service for the CPU core processing RX queues.

>  		if (is_ptp_ring)
>  			buff->len -=3D
>  				aq_ptp_extract_ts(self->aq_nic, skb_hwtstamps(skb),

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/tencent_7DB01BE7F8F=
A056BB5F11D3570CF636C4309@qq.com?part=3D2
