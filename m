Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792431522;
	b=brB08zahs7r1xsWQxWe3mHrjQlkCn4WjeIPmxS3ABL81rwADr85wMxVuJjnt4flkQ5No
	 cSZu1+p3Tiowj0JN/KVMYHmkujuoLCO05aZ9ItR6KS4+OgsGeFNHhJyoAz5EnDyWQmTVj
	 qQZlFzxubp6pr+OKIdDiIBNYu6lZraXy/EOqg8gmUvZdqY8qSt2nM5pwxJdKC2IKy86sE
	 h4WKlyAxnJDGDy9qvgKqYo+HcZgUxJd9lFMF9rvtQQbMXXDmk2Lp2MPmGhOXmWOr4w+3W
	 ZjvW2tiaZhFim7s9btetgif5EfxF0ALzz55/0SKGM1o1OuQlvQvt5T2X4vZdYEDQ3mA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792431522;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=7ykaxJta1Hj+twICobH251gv/WlRqnsBOHcpwmRY0M0=;
	b=z39CvW3y17/eFndTA9KstePaLcD3ZpxQlOr2yag1tRSrooiil3+L6QLqRzkDIL88q8iG
	 +xo9C2fRXb77+Ic9vSOjRa2Bc2mWdGOSTEwtvRtA0Shvq5+pv+09L54b2dP9R3MEoGl/R
	 jqB/APDcozeSV5Hiv0iqQZb49Up1jOh5Wi30eqZx6tUysvF2MMv8m0hFgMCDdNpRHC0n4
	 oCQ98qkvCEEFZnzMQnBuls7avQCwgGIvM3qNBmd7ruQa641cdpgAep0cIe7u5sD4Ew+eb
	 yiTrWt2zutfwHU4EEqnmgtMeQyjgNpxjuZVepb2GR05F6tPJkA5QgtXCXEA0mfUBjHQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G0XFbXNn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B888606A32C;
	Mon, 19 Oct 2026 17:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G0XFbXNn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA1CC1F000C6;
	Mon, 19 Oct 2026 17:38:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792431521;
	bh=7ykaxJta1Hj+twICobH251gv/WlRqnsBOHcpwmRY0M0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=G0XFbXNn6X4sA6mDTzmJUaHkacexmEeDXQUyLNgEhNyiIvcrOO2BGfswJm5pzhpDJ
	 Bbspgt55bDVGZUfXb5CtWa8bPcPexpSZdtroj5JH5ZzzykHEC3KbsSnhPt+tguvbh2
	 7qlFz2nKxcvyOBD8Xz1lT2JI8vYS/QnEy3Pt3P90o/Rdu4J+HAutLlFJZyBRgyWGgB
	 Toj1pMdpj5HW+SEfph0Hf5VChzH6ad8RCE6yy3yMUesxX431naK/NElYcrH6p8zZQQ
	 ZbDHcdSN2zfPhoQNag6Gzr0dDEaagtFbLYftFL/rGdQNSlMzA7sOvffixAs0XVYPDW
	 E+2KBE26briNA==
Subject: Re: [PATCH net-next v8 5/5] net: stmmac: rework stmmac_rx to support
 XDP rx multi-buff
From: netdev-bot+sashiko@kernel.org
To: lorenzo.bianconi@oss.qualcomm.com
Cc: maxime.chevallier@bootlin.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com, ast@kernel.org,
 daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
 sdf@fomichev.me, Jose.Abreu@synopsys.com, boon.leong.ong@intel.com,
 netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 bpf@vger.kernel.org
Date: Mon, 19 Oct 2026 17:38:40 +0000
Message-ID: <179243152020.3135.588086716583719127@kernel.org>
In-Reply-To: <20261018-stmmac-rx-mb-v8-5-5f58c0b25849@oss.qualcomm.com>
References: <20261018-stmmac-rx-mb-v8-5-5f58c0b25849@oss.qualcomm.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 0 (1) · Medium: 2 (1) · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The patch fixes a DMA under-sync on the XDP drop path but does
  not say so.
- [Medium] Fragment truesize is undercounted when num_pages is not a
  power of two.
- [Low] The patch advertises NETDEV_XDP_ACT_RX_SG (line 8189) and now
  runs frags-aware programs on multi-buffer xdp_buffs…

Pre-existing issues:
- [High] XDP_TX completions are recycled into the RX page_pool's lockless
  alloc cache from a different NAPI context.
- [Medium] The AF_XDP zero-copy XDP_PASS path reports XDP metadata whose
  bytes it never copies.

--

net: stmmac: rework stmmac_rx to support XDP rx multi-buff

This reworks stmmac_rx() to collect every descriptor of a frame in an
xdp_buff, so the XDP program runs on the whole frame, including any
fragments. The skb is then built from the xdp_buff with napi_build_skb()
and xdp_update_skb_frags_info(). The in-progress xdp_buff is saved in
rx_q->state across NAPI polls, and NETDEV_XDP_ACT_RX_SG is advertised.

> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index 04dc6dcaa435d..e9c61524fc740 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c

[ ... ]

> @@ -5806,6 +5812,119 @@ static int stmmac_rx_zc(struct stmmac_priv *priv, int limit, u32 queue)

[ ... ]

> +static struct sk_buff *stmmac_build_skb(struct xdp_buff *xdp)
> +{
> +	struct skb_shared_info *sinfo = xdp_get_shared_info_from_buff(xdp);
> +	u32 metasize = xdp->data - xdp->data_meta;

[ ... ]

> +	skb_mark_for_recycle(skb);
> +	skb_reserve(skb, xdp->data - xdp->data_hard_start);
> +	skb_put(skb, xdp->data_end - xdp->data);
> +	if (metasize)
> +		skb_metadata_set(skb, metasize);

[Severity: Medium]
This isn't a bug introduced by this patch. Now that the page_pool path
keeps the metadata, though, the AF_XDP zero-copy XDP_PASS path no longer
matches it. Does stmmac_construct_skb_zc() pass stale headroom bytes to
TC/BPF as metadata?

stmmac_construct_skb_zc() {
    ...
	skb_reserve(skb, xdp->data - xdp->data_hard_start);
	memcpy(__skb_put(skb, datasize), xdp->data, datasize);
	if (metasize)
		skb_metadata_set(skb, metasize);
    ...
}

Only [data, data_end) is copied into the new skb, but the metasize bytes
in front of skb->data are still marked as metadata. A TC/BPF program that
reads data_meta on frames from stmmac_rx_zc()->stmmac_dispatch_skb_zc()
would see leftover bytes from the napi_alloc_skb() headroom instead of
what the XDP program wrote.

Other zero-copy drivers copy metasize + datasize bytes starting at
xdp->data_meta and then call __skb_pull(skb, metasize). Would the same
approach work here?

> +
> +	if (unlikely(xdp_buff_has_frags(xdp)))
> +		xdp_update_skb_frags_info(skb, num_frags, sinfo->xdp_frags_size,
> +					  sinfo->xdp_frags_truesize,
> +					  xdp_buff_get_skb_flags(xdp));
> +	return skb;
> +}
> +
> +static bool stmmac_build_xdp_frags(struct stmmac_priv *priv,
> +				   struct stmmac_rx_queue *rx_q,
> +				   unsigned int len, struct page *page,
> +				   unsigned int offset,
> +				   enum dma_data_direction dma_dir,
> +				   struct xdp_buff *xdp)
> +{
> +	dma_addr_t dma_addr = page_pool_get_dma_addr(page) + offset;
> +
> +	dma_sync_single_for_cpu(priv->device, dma_addr, len, dma_dir);
> +	if (!xdp_buff_add_frag(xdp, page_to_netmem(page), offset, len,
> +			       xdp->frame_sz)) {

[Severity: Medium]
The commit message says:

  charge fragments the whole page_pool page size (xdp->frame_sz) as
  truesize instead of the old dma_buf_sz

Is xdp->frame_sz the page_pool page size in every configuration?

frame_sz comes from bufsz = rx_q->napi_skb_frag_size in stmmac_rx(). That
value is set in __alloc_dma_rx_desc_resources():

	rx_q->napi_skb_frag_size = num_pages * PAGE_SIZE;
	...
	pp_params.order = order_base_2(num_pages);

When num_pages is not a power of two, each page_pool buffer is
PAGE_SIZE << order, which is larger than napi_skb_frag_size. Two examples
with 4K pages and no XDP:

- dma_buf_sz of 8KiB: num_pages = 3, order 2, so each 16K page is charged
  as 12K.
- dma_buf_sz of 16KiB: num_pages = 5, order 3, so each 32K page is charged
  as 20K.

stmmac_xdp_shrink_tail() subtracts the same xdp->frame_sz. Then
stmmac_build_skb() adds sinfo->xdp_frags_truesize to skb->truesize
through xdp_update_skb_frags_info(). As a result, skb->truesize is lower
than the memory the fragments actually pin.

Could the fragment truesize use PAGE_SIZE << pp_params.order instead? Or
could num_pages be rounded up to a power of two?

[ ... ]

> @@ -5927,129 +6039,89 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)

[ ... ]

> +		pre_len = ctx.xdp.data_end - ctx.xdp.data_hard_start;
> +
> +		ctx.desc = p;
> +		ctx.ndesc = np;
> +
> +		skb = stmmac_xdp_run_prog(priv, &ctx.xdp);
> +		/* Due xdp_adjust_tail: DMA sync for_device
> +		 * cover max len CPU touch
> +		 */
> +		sync_len = ctx.xdp.data_end - ctx.xdp.data_hard_start;
> +		sync_len = max(sync_len, pre_len);

[Severity: Medium]
The old pre_len and sync_len subtracted buf->page_offset:

	sync_len = ctx.xdp.data_end - ctx.xdp.data_hard_start -
		   buf->page_offset;

The new ones don't. This looks like a separate DMA sync fix, and the
commit message doesn't mention it.

Commit 88095728511e ("net: stmmac: fix rx Scatter-Gather support") set
pp_params.offset = 0, and __page_pool_dma_sync_for_device() syncs from
dma_addr + pool->p.offset. So with the old formula, the XDP_CONSUMED path
synced [0, L) for an L-byte frame at XDP_PACKET_HEADROOM. The bytes the
CPU had touched were at [256, 256 + L).

Take a non-coherent platform and an XDP program that writes the packet,
grows the tail or writes metadata, and then returns XDP_DROP or
XDP_ABORTED, or fails a redirect. Could that leave dirty cache lines in
the recycled page? Those lines could later be written back over a frame
the device has DMA'd into the page.

The new formula looks like the correct one. Stable kernels that picked up
88095728511e would keep the under-sync. Could this go out as a separate
net fix with:

Fixes: 88095728511e ("net: stmmac: fix rx Scatter-Gather support")

or at least be described in the commit message?

> +
> +		/* For Not XDP_PASS verdict */
> +		if (IS_ERR(skb)) {
> +			unsigned int xdp_res = -PTR_ERR(skb);
> +
> +			if (xdp_res & STMMAC_XDP_CONSUMED) {
> +				stmmac_xdp_put_buff(rx_q, &ctx.xdp, sync_len,
> +						    true);
> +				rx_dropped++;
> +			} else if (xdp_res & (STMMAC_XDP_TX |
> +					      STMMAC_XDP_REDIRECT)) {
> +				xdp_status |= xdp_res;
> +			}

[Severity: High]
This is a pre-existing issue, but this patch sends fragment pages down the
same path. Is it safe for tx_napi to recycle XDP_TX completions directly
into this RX queue's page_pool?

stmmac_tx_clean() runs from ch->tx_napi and does:

	if (xdpf &&
	    tx_q->tx_skbuff_dma[entry].buf_type == STMMAC_TXBUF_T_XDP_TX) {
		xdp_return_frame_rx_napi(xdpf);
		tx_q->xdpf[entry] = NULL;
	}

That call ends up here:

xdp_return_frame_rx_napi()
  __xdp_return(..., napi_direct=true)
    page_pool_put_full_netmem(pp, netmem, true)
      page_pool_recycle_in_cache()
        pool->alloc.cache[pool->alloc.count++] = netmem;

The page_pool belongs to ch->rx_napi, which is a separate napi_struct.
stmmac_xdp_get_tx_queue() picks the XDP_TX queue by CPU. tx_napi can also
be scheduled on another CPU by stmmac_tx_timer() or by a per-channel TX
MSI vector. stmmac does not set pp_params.napi, so page_pool cannot catch
this.

At the same time, stmmac_rx() on rx_napi uses the same alloc cache. It
does so through stmmac_rx_refill() and through the new allow_direct=true
puts in stmmac_xdp_put_buff(), stmmac_build_xdp_frags() and
stmmac_xdp_shrink_tail().

Can these two contexts race on alloc.count and the cache slots? That
could lose a page, or cache the same page twice so that it gets handed to
two RX descriptors.

With multi-buffer frames, xdp_return_frame_rx_napi() now also returns
every fragment page with napi_direct=true, so more pages go through this
race.

[ ... ]

> @@ -8106,6 +8186,7 @@ static int __stmmac_dvr_probe(struct device *device,
>  	ndev->hw_features = NETIF_F_SG | NETIF_F_IP_CSUM | NETIF_F_IPV6_CSUM |
>  			    NETIF_F_RXCSUM;
>  	ndev->xdp_features = NETDEV_XDP_ACT_BASIC | NETDEV_XDP_ACT_REDIRECT |
> +			     NETDEV_XDP_ACT_RX_SG |
>  			     NETDEV_XDP_ACT_XSK_ZEROCOPY;

[Severity: Low]
With NETDEV_XDP_ACT_RX_SG advertised, frags-aware programs now see
multi-buffer frames. However, __alloc_dma_rx_desc_resources() still
registers the rxq with:

	ret = xdp_rxq_info_reg(&rx_q->xdp_rxq, priv->dev, queue, napi_id);

That leaves frag_size at 0, so bpf_xdp_frags_increase_tail() always
returns early:

	if (!rxq->frag_size || rxq->frag_size > xdp->frame_sz)
		return -EOPNOTSUPP;

Is it intended that a positive bpf_xdp_adjust_tail() on a multi-buffer
stmmac frame always fails, even when the last fragment page has room?
Other RX_SG drivers such as bnxt behave the same way, so this may just be
a limitation. Would registering with __xdp_rxq_info_reg() and a real
frag_size be worth considering?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261018-stmmac-rx-mb-v8-0-5f58c0b25849%40oss.qualcomm.com
