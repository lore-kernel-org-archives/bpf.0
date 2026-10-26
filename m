Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793000600;
	b=zqEcJqePClfysMwSikscP0v085HvVwe4GgnCVHhimPcbEpA9R7HOPYwvSZeEQBLoPFCO
	 qCjaDjqZKFqs3CyF40tZGAoNLLLS2UhAdpKPmorh3p7q/kfHbGB7+jGngNAyOGLtoK2q/
	 fF//8LPlUNj1WuOq3ozfTKkvMB9azMSsdmKYpik4Cxma5hLJicuDWtEnAKd5W6PWmWR89
	 c5Vl03XDqz1ctIQvwtE4vLM14Y2L2fdR+8vS0hNOoB9UeuyvotXKpSJuEubiv/vymJCO7
	 xO4J8Z7Towzwa9FwGqI4DKPRMFTD9JoDwCnqSLHGt8rkas1IARd8l1W3Q3Q37/SArHg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793000600;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=hOfnCH+7CYoZiGAiRuh8IJFPtlhrgdv3kKtPaMkLAdQ=;
	b=veRkLxMgorbbiJkej2ya6i9WgCdcu2o/2ekgsZJH1gcPSTSQyaPKSCcQrR1DL8IHjcEw
	 AIUPlQOuQ1KJaEZ32mK5Spiud/ItMzdz/WpKRSExcMKfV6hk4Jze2azStjiWCNhyTC0R6
	 H1WXBxf579nA6IqrjDR6YGyCEBH3es1U7pmOwagrWcG2XfFo2jrMhQ8x+JTcyqNq+dk03
	 SWdLlEBbwAIveCPYg4L5ozaMgbapVz3XXGrw0yxuVGwjHX5FY7UgAX13kbIhyLHKSCxRf
	 JC7ssKT9O4M3PEE6tukaadCNa9XqJ5yM1t+Fs+TZtJ/KNuDA92cj6N1MRFuUe0FbC0A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JAdFX2VW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60313606A31A;
	Mon, 26 Oct 2026 07:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JAdFX2VW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 368C91F01825;
	Mon, 26 Oct 2026 07:43:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793000600;
	bh=hOfnCH+7CYoZiGAiRuh8IJFPtlhrgdv3kKtPaMkLAdQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=JAdFX2VW5261ezgvvKOnoCW5hSsSCAgV1wUzoQ5lBbc4Pgk7RjwpKp/BBsBXrZuQV
	 L90ZaneqOgiEIVT/LV7VqP0Hmn6PKWgzUFnPfxW0Bf7IVTYwcF8xxOihihy6KKEGhW
	 J1NVs+Yq7CTZBxKJy8qaxvOiUGTGJs1qZwiQWgPdPfS0roekjD4eDLnDvLQcnTJJdg
	 DYZHAudsDg2pEwHDYZR6bQqruYKVi100FFgYGTraG6ir9d4F1skj6A1Haayc5H0ii2
	 WKFb2NzBUAoWD8hhMA2R1nJDoS5L82xQuJ85rjDSuRZOdigcJ5biYWDBiDYN9XHpYg
	 6Y+Mf1e1TkhKA==
Subject: Re: [PATCH net] igc: track rx frame boundaries independent of skbs
From: netdev-bot+sashiko@kernel.org
To: p@1g4.org
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, ast@kernel.org, daniel@iogearbox.net,
 hawk@kernel.org, john.fastabend@gmail.com, sdf@fomichev.me,
 maciej.fijalkowski@intel.com, vedang.patel@intel.com, jithu.joseph@intel.com,
 andre.guedes@intel.com, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Date: Mon, 26 Oct 2026 07:43:18 +0000
Message-ID: <179300059875.3134.14278423796840357371@kernel.org>
In-Reply-To: <20261025065154.2037149-1-p@1g4.org>
References: <20261025065154.2037149-1-p@1g4.org>
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

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 (2) · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The new split-frame discard paths leave frames out of
  rx_packets and rx_bytes, which contradicts the rtnl_link_stats64…

Pre-existing issues:
- [High] In igc_clean_rx_irq(), the FPE mPacket early exit leaks the RX
  page and its DMA mapping.
- [High] igc_xdp_set_prog(), igc_xdp_enable_pool() and
  igc_xdp_disable_pool() tear down and rebuild the RX ring while NAPI…

--

igc: track rx frame boundaries independent of skbs

The patch adds a per-ring rx_in_frame flag so the inline TSIP timestamp
header is stripped only from the first buffer of a frame. Split frames
that are not supported (XDP enabled, AF_XDP zero-copy) are rejected
before XDP runs, and their continuation descriptors are drained. The RX
poll functions now return a work_done count that includes discarded
descriptors, instead of total_packets.

> diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
> index 1fb5f3cbe93c5..9ca5558c762c9 100644
> --- a/drivers/net/ethernet/intel/igc/igc_main.c
> +++ b/drivers/net/ethernet/intel/igc/igc_main.c
> @@ -474,6 +474,7 @@ static void igc_clean_rx_ring(struct igc_ring *ring)
>  		igc_clean_rx_ring_page_shared(ring);
>  
>  	clear_ring_uses_large_buffer(ring);
> +	ring->rx_in_frame = false;
>  
>  	ring->next_to_alloc = 0;
>  	ring->next_to_clean = 0;
> @@ -673,6 +674,7 @@ static void igc_configure_rx_ring(struct igc_adapter *adapter,
>  	/* reset next-to- use/clean to place SW in sync with hardware */
>  	ring->next_to_clean = 0;
>  	ring->next_to_use = 0;
> +	ring->rx_in_frame = false;
>  
>  	if (ring->xsk_pool)
>  		buf_size = xsk_pool_get_rx_frame_size(ring->xsk_pool);

[Severity: High]
This isn't a bug introduced by this patch, but these new resets assume
NAPI is not polling the ring. Do the XDP reconfiguration paths actually
guarantee that?

igc_xdp_set_prog(), igc_xdp_enable_pool() and igc_xdp_disable_pool() all
clean the ring before they disable NAPI:

drivers/net/ethernet/intel/igc/igc_xdp.c:igc_xdp_set_prog() {
    ...
		for (i = 0; i < adapter->num_rx_queues; i++) {
			igc_disable_rx_ring(adapter->rx_ring[i]);
			igc_disable_tx_ring(adapter->tx_ring[i]);
			napi_disable(&adapter->rx_ring[i]->q_vector->napi);
		}
    ...
			napi_enable(&adapter->rx_ring[i]->q_vector->napi);
			igc_enable_tx_ring(adapter->tx_ring[i]);
			igc_enable_rx_ring(adapter->rx_ring[i]);
    ...
}

igc_disable_rx_ring() does only an RXDCTL write before it calls
igc_clean_rx_ring(). Also, napi_enable() runs before
igc_enable_rx_ring()->igc_configure_rx_ring().

Suppose igc_clean_rx_irq() is running on another CPU while
igc_clean_rx_ring_page_shared() calls dev_kfree_skb(rx_ring->skb) and
drains the pages. Could the poll then call igc_add_rx_frag() on the freed
skb, or drop page references a second time through igc_put_rx_buffer()?

When the poll exits, it also writes rx_ring->skb, next_to_clean and
rx_in_frame back, after the reset. igc_configure_rx_ring() resets
rx_in_frame but not rx_ring->skb. A later poll could then see
first == true with a stale non-NULL skb, and the new (!first && !skb)
check would not catch that.

Triggering this needs a CAP_NET_ADMIN user to attach or detach an XDP
program, or to bind or unbind an AF_XDP pool while XDP is loaded, while
RX traffic keeps a poll running on another CPU.

[ ... ]

> @@ -2635,21 +2635,34 @@ static int igc_clean_rx_irq(struct igc_q_vector *q_vector, const int budget)
>  		dma_rmb();
>  
>  		rx_buffer = igc_get_rx_buffer(rx_ring, size, &rx_buffer_pgcnt);
> +		tsip = first && igc_test_staterr(rx_desc, IGC_RXDADV_STAT_TSIP);
> +
> +		if ((!first && !skb) ||
> +		    (first && igc_xdp_is_enabled(adapter) &&
> +		     !igc_test_staterr(rx_desc, IGC_RXD_STAT_EOP)) ||
> +		    unlikely(tsip && size < IGC_TS_HDR_LEN)) {
> +			if (first)
> +				dev_core_stats_rx_dropped_inc(rx_ring->netdev);
> +			xdp_res = IGC_XDP_CONSUMED;
> +			goto xdp_done;
> +		}
> +

[Severity: Medium]
Should the frames dropped here still count toward rx_packets and
rx_bytes?

include/uapi/linux/if_link.h describes rx_packets in rtnl_link_stats64
as including "packets which host had to drop at various stages of
processing (even in the driver)".

Take a hardware-good first descriptor that is dropped only because XDP is
enabled and EOP is not set. It jumps to xdp_done and skips the new
total_bytes/total_packets block, so only rx_dropped and work_done are
incremented. igc_clean_rx_irq_zc() does the same for !eop frames.
igc_update_stats() then exports the ring totals directly as
net_stats->rx_packets and rx_bytes.

Frames that the XDP program drops are still counted in the same function,
and before this patch every descriptor was counted. The commit message
says the exclusion is intentional ("without counting successful RX"), but
that doesn't match the documented semantics.

>  		truesize = igc_get_rx_frame_truesize(rx_ring, size);
>  
>  		pktbuf = page_address(rx_buffer->page) + rx_buffer->page_offset;

[ ... ]

> -		if (igc_fpe_is_pmac_enabled(adapter) &&
> +		if (first && igc_fpe_is_pmac_enabled(adapter) &&
>  		    igc_fpe_handle_mpacket(adapter, rx_desc, size, pktbuf + pkt_offset)) {
>  			/* Advance the ring next-to-clean */
>  			igc_is_non_eop(rx_ring, rx_desc);
>  			cleaned_count++;
> +			work_done++;
>  			continue;
>  		}

[Severity: High]
This is a pre-existing issue, but this block is being modified here. Does
this early exit leak the RX page and its DMA mapping?

igc_get_rx_buffer() always decrements rx_buffer->pagecnt_bias. This path
advances next_to_clean and continues, but it never restores the bias and
never calls igc_put_rx_buffer(). That function is the only place that
recycles or unmaps the page and clears rx_buffer->page.

The slot still holds the page after next_to_clean has moved past it. If
igc_reuse_rx_page() later recycles a buffer into that slot, it overwrites
the page without checking:

drivers/net/ethernet/intel/igc/igc_main.c:igc_reuse_rx_page() {
    ...
	new_buff = &rx_ring->rx_buffer_info[nta];
    ...
	new_buff->page		= old_buff->page;
    ...
}

The old page and its mapping are then lost.

If igc_alloc_rx_buffers() reaches the slot first, igc_alloc_mapped_page()
reuses the page because bi->page is non-NULL, but the bias is one too
low. igc_can_reuse_rx_page() would then always see
(rx_buffer_pgcnt - pagecnt_bias) > 1, so the page is never freed.

igc_fpe_handle_mpacket() returns true for any SMD-V or SMD-R frame. With
pMAC enabled, the link partner can trigger this with every such frame it
sends.

The new drop path in this patch already releases the buffer correctly:
pagecnt_bias++ in the IGC_XDP_CONSUMED case, then igc_put_rx_buffer(),
cleaned_count++ and igc_is_non_eop(). Could the mPacket case release the
buffer the same way?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261025065154.2037149-1-p%401g4.org
