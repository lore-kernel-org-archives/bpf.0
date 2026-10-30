Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793395971;
	b=qp+5MOAXUOsTF33ahs9hv80eoTaqAN9OPxVjTzmFC0nBVP/EyZEf4VWoguI5+7x5B+Bw
	 Hl2GayXus5lIP1pR4Wbe2gn9iFpBWfOkx5UKmZxun8rzekmfBRCaZ0cDDMhlBO9bWQLTk
	 K2/LXhgveBRlDeydo3aHk+i+gBne8OpisW/6zb/suNtE4cCa8uMzk7EA8/p3aX1Wwi+7D
	 ARw/KTYm5JqdDWiFxByI/HiKax2Q0z/VIdAUTlstXNuGnU7LesId9VljPeCe7evwN5ZAQ
	 XQZuxYTM3UhXu+gFKA3W+2e50g90ejnwI6SxIqDZsio5sI/CIXIU9hawijgF1AaOteQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793395971;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=atBG3b4jQQy/gl47VTTfMJBJdUGO5JnrhmLaafXl1Xc=;
	b=VvzMfDg7Npqi6HEQ/zcaM2n/jzpY7gyTbY4kqGs1LqFlwA+VsovkIIwnRi98D0vY3jXO
	 15IwNwR9kXhNRYjG3nD4T0mtGa/BLeXm5nRZPx4W3xgvdMuXfYrUKhZKKtJ3u0RQs1/oz
	 x6QtUYW5RpwAXRP1mD6N/8Np15qpbs/OkxL5BWVHsl42PJun7By7zgwlkOIJxP5rtvu+t
	 vt7nDx4wW1u22Eie/kO/XrtT+9QpNupB7xOS8JgALyH8srDM6IkYj48y5/cGKGgn5GDmr
	 03G7Hr1z05rzpEydQw17XXBFtlRVCw1+3RwB7KcHfp1LDSTF0abNAHJALNz9NADy5KQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CxfwpNU8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D185606A320;
	Fri, 30 Oct 2026 21:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CxfwpNU8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E612D1F00A02;
	Fri, 30 Oct 2026 21:32:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793395970;
	bh=atBG3b4jQQy/gl47VTTfMJBJdUGO5JnrhmLaafXl1Xc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=CxfwpNU8WX5+Kxv9FhqH63eHZX+esbUwlMMOl8381+fx9Wa6ObQGPIg5LA9doCkMX
	 L0BEJncGlvy5K/jqEiHVwMrTPQiqW8YCMstwhiczdf8k1JGyjm2TWh48YRoV9gsiIw
	 230PZoiFsnklsHs5P0fmoCh8u79/Xujg/Ty0iyDysfMtGDxJV3lIh9Wx97YpYRZ38o
	 6cpGFKck8XAYf5QMYQ4VImcy7IDTfsczCz4WCas0sbktE3j30vlWJK6hR7ne1vKkQx
	 viWdQgOkgvCtyBpTl/9TnwPGZz/Vvzq0uPqhrHta7lTxkzXQEhH9i7dF75/8Bo2VSI
	 tEfoG9GATsYsw==
Subject: Re: [PATCH net] net: lan966x: don't free XDP buffers in fdma tx clear
 with budget 0
From: netdev-bot+sashiko@kernel.org
To: daniel.machon@microchip.com
Cc: horatiu.vultur@microchip.com, UNGLinuxDriver@microchip.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, ast@kernel.org, daniel@iogearbox.net,
 hawk@kernel.org, john.fastabend@gmail.com, sdf@fomichev.me,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Date: Fri, 30 Oct 2026 21:32:49 +0000
Message-ID: <179339596952.3131.4206946876532380801@kernel.org>
In-Reply-To:
 <20261029-lan966x-fdma-tx-clear-budget-v1-1-38c52d7aab8c@microchip.com>
References:
 <20261029-lan966x-fdma-tx-clear-budget-v1-1-38c52d7aab8c@microchip.com>
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

Critical: 0 · High: 0 (1) · Medium: 1 (1) · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] This patch adds a skip to lan966x_fdma_tx_clear_buf()
  (drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c, line 359): `if…

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but
  lan966x_fdma_reload()…
- [Medium] This problem wasn't introduced by this patch, but
  lan966x_fdma_deinit()…

--

net: lan966x: don't free XDP buffers in fdma tx clear with budget 0

This patch makes lan966x_fdma_tx_clear_buf() skip completed XDP_TX and
ndo_xdp_xmit DCBs when netpoll calls it with a budget of 0. That way the
page pool and XDP return APIs are not called with hardirqs disabled. The
skipped buffers are left for the next NAPI poll, and skbs are still freed
via napi_consume_skb().

> diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c b/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c
> index 21668bbcc9063..1fbe910c5ec38 100644
> --- a/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c
> +++ b/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c
> @@ -353,6 +353,12 @@ static void lan966x_fdma_tx_clear_buf(struct lan966x *lan966x, int weight)
>  		if (!fdma_db_is_done(db))
>  			continue;
>  
> +		/* XDP and page pool APIs can't be used with a budget of 0.
> +		 * Leave these buffers for the next NAPI poll.
> +		 */
> +		if (!weight && !dcb_buf->use_skb)
> +			continue;

[Severity: Medium]
Can this starve netconsole transmits on the port that owns the FDMA NAPI?

skbs and XDP frames get slots from the same ring through
lan966x_fdma_get_next_dcb(), which only checks the used bit:

lan966x_fdma_get_next_dcb() {
	...
		if (!dcb_buf->used &&
		    !fdma_is_last(&tx->fdma, &tx->fdma.dcbs[i]))
			return i;
	...
}

If heavy XDP_TX or ndo_xdp_xmit traffic fills every usable slot, a
netpoll skb ends up here in lan966x_fdma_xmit():

	next_to_use = lan966x_fdma_get_next_dcb(tx);
	if (next_to_use < 0) {
		netif_stop_queue(dev);
		return NETDEV_TX_BUSY;
	}

__netpoll_send_skb() then polls between retries:

netpoll_poll_dev()->poll_one_napi()->napi->poll(napi, 0)
  ->lan966x_fdma_tx_clear_buf(lan966x, 0)

With the new check, every completed XDP DCB is skipped. No slot is freed,
clear stays false, and lan966x_fdma_wakeup_netdev() is never called.

Once the retries run out, the skb is put on npinfo->txq and handed to
delayed work, and later messages queue behind it. In normal operation a
later IRQ-driven NAPI poll frees the DCBs and output only comes late.

During a panic, with the other CPUs stopped and hardirqs off, would that
work ever run? If not, the netconsole output is lost.

Before this patch, the budget-0 poll freed those slots, so netpoll could
make progress.

[Severity: High]
This isn't a bug introduced by this patch, but can XDP_TX pages that TX
DCBs still hold end up in the wrong page_pool when lan966x_fdma_reload()
replaces the RX pool?

lan966x_fdma_reload() does:

	napi_synchronize(&lan966x->napi);
	napi_disable(&lan966x->napi);
	...
	err = lan966x_fdma_rx_alloc(&lan966x->rx);
	...
	page_pool_destroy(page_pool);

	lan966x_fdma_wakeup_netdev(lan966x);
	napi_enable(&lan966x->napi);

It never walks tx->dcbs_buf[]. Suppose an XDP_TX DCB posted by the last
poll completes in hardware after napi_disable(). The FDMA IRQ's
napi_schedule() then does nothing, and the DCB stays used.

The first poll after napi_enable() then runs this in
lan966x_fdma_tx_clear_buf():

	page_pool_recycle_direct(rx->page_pool,
				 dcb_buf->data.page);

At that point rx->page_pool is the new pool. __page_pool_put_page() does
not check which pool owns the page. So the old pool's page, with its old
DMA mapping and order, goes into the new pool's cache.

If the MTU change raised page_order, could the new pool give this smaller
page to the RX ring? There db_size is PAGE_SIZE << new_order, so the
device could DMA a large frame past the end of the page.

Even if the order stays the same, the old pool's inflight count would
never reach zero, so its shutdown stalls and the pool is leaked. And
wouldn't the new pool's inflight count go negative when it is destroyed?

This can happen on these paths while XDP_TX traffic is flowing:

lan966x_port_change_mtu()->lan966x_fdma_change_mtu()
  ->__lan966x_fdma_reload()->lan966x_fdma_reload()

lan966x_xdp_setup()->lan966x_fdma_reload_page_pool()
  ->__lan966x_fdma_reload()->lan966x_fdma_reload()

This patch doesn't widen the window much. An IRQ-driven NAPI poll still
reclaims those DCBs if it runs before napi_disable().

[Severity: Medium]
This is a pre-existing issue, but does lan966x_fdma_deinit() leak the TX
DCBs that are still marked used?

lan966x_fdma_deinit() {
	...
	napi_synchronize(&lan966x->napi);
	napi_disable(&lan966x->napi);

	lan966x_fdma_rx_free_pages(&lan966x->rx);
	fdma_free_coherent(lan966x->dma_dev, &lan966x->rx.fdma);
	page_pool_destroy(lan966x->rx.page_pool);
	lan966x_fdma_tx_free(&lan966x->tx);
}

lan966x_fdma_tx_free() only does:

	kfree(tx->dcbs_buf);
	fdma_free_coherent(lan966x->dma_dev, &tx->fdma);

Entries that are still used are never released:

- skb and xdp_ndo buffers stay DMA-mapped
- skbs are not consumed
- xdp_frames are not returned
- XDP_TX pages are not returned to the page pool

Those pages keep the destroyed pool inflight, so its shutdown stalls.

lan966x_remove() and the probe error path both call fdma_deinit() before
lan966x_cleanup_ports(). After napi_disable() no poll can reclaim these
entries.

This patch adds completed but deferred XDP buffers to what can still be
outstanding here. The window is narrow, because an IRQ-driven poll
normally frees them before napi_disable().

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261029-lan966x-fdma-tx-clear-budget-v1-1-38c52d7aab8c%40microchip.com
