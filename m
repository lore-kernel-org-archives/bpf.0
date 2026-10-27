Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793092253;
	b=tbDNNQSL/cIJWAUUYgjoJJsqMQ50EUmaCj0NGQDVcr/D+5wRF2QiQJiO5W+sdavMVUbs
	 cKNZvqzu6VpV8U1RDKRb4nImuhRXiRF7222093Rj7qWmNgY4IOS/vWsrHQ6OdI0yvLAlV
	 o1WmuTWaJyB/7y/YerldyWHtez5fBT71I29GOuskJJNU11K2CsKnnqTpyAEFQpRmXCqCF
	 mHZyumTiu5a9u71WGVP9/E/zBeub7Wm0Pv92Re/RmLhxPwcy6nrvBl4sVFWcTPQN57pwc
	 TFHLnbAPSzc842TkpgVcj9HOL/ud3IKrbH0dbshsnojbwA7jYxFtPNejXuqjHxWNsPQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793092253;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=wy7JHxQwUZNHWq+XEZMf1oDxplyRZe0up+B5GG9yIXw=;
	b=ArqHPE0gPTz4p7u3r/UETckVOKS4XBuiaVMyqKIc+sMZ+4/TcbspLXNleagq8wnT3kNe
	 84aczJfRMi4fbeZ68QQZOPoqsY6TEZWRy87SoftgyY1X4ECBqu9snIkSdE6M7a69BtC7i
	 pB7Cu66cobmidA6s4bs0X9yMPLtyA7Bh8jsbOqFET8QqKtWjz/Jlkzd/10ycqGBDuTc0P
	 9GGjm7EszfeNkIFYTu4LNW2SOaBaZNnXJFN6WXSM/sPzg3vxard45jWhsDGlF6b8PBCM3
	 OiEH7GDoKqum6TQxgoUzfVxEL0+IDb09P5ulTCki8EXz9vlfnwdykD/rqxYIjwGQ5vg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KzWgtNHV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0F94606A31A;
	Tue, 27 Oct 2026 09:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KzWgtNHV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 410261F01825;
	Tue, 27 Oct 2026 09:10:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793092252;
	bh=wy7JHxQwUZNHWq+XEZMf1oDxplyRZe0up+B5GG9yIXw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=KzWgtNHVe49QUMir0cIGD8U+6iphp40+xr4a81O50teAKy8Z/+FEXIwEmB16qhjye
	 6IVcDsFlwEipT6ASUk7D8Zs3n1XCQKoPxs3BNL9xQT9f1WxHeHynFHMyOQvstJZljk
	 QzHXZhagO7IBOanIjfXuNG5eD35KN2xcJUIOczUifLFpRIRDotqP4EDKAnaT9CGNu2
	 voaDjT/wCL8OEwu7LeYvw7xFFWjzZ1ll5uqRWNULc9ZAMTv7BAFD6/G2xD/5end9zo
	 UKwIoozQ3M/S7uMP/VJqm6GQdI5BTrwtRCBtV1LzMgRrjpFnpHucD8sIwUP3BJ3Mqc
	 CP/x5TdEfVEiQ==
Subject: Re: [PATCH net 1/6] net: stmmac: take ownership of saved RX state at
 poll entry
From: netdev-bot+sashiko@kernel.org
To: lorenzo.bianconi@oss.qualcomm.com
Cc: maxime.chevallier@bootlin.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com, ast@kernel.org,
 daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
 sdf@fomichev.me, Jose.Abreu@synopsys.com, boon.leong.ong@intel.com,
 o.rempel@pengutronix.de, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org
Date: Tue, 27 Oct 2026 09:10:50 +0000
Message-ID: <179309225078.3134.4254254722485703329@kernel.org>
In-Reply-To: <20261023-stmmac-xdp-fixes-v1-1-efb37e19f5bd@oss.qualcomm.com>
References: <20261023-stmmac-xdp-fixes-v1-1-efb37e19f5bd@oss.qualcomm.com>
X-sashiko-severity: High
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

Critical: 0 · High: 1 · Medium: 0 (1) · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The commit message says that on resume a saved partial frame
  would be resumed "with descriptors from the freshly initialized ring",…

Pre-existing issues:
- [Medium] In stmmac_rx()
  (drivers/net/ethernet/stmicro/stmmac/stmmac_main.c), the…

--

net: stmmac: take ownership of saved RX state at poll entry

The saved partial-frame RX state is now taken and cleared at the start of
stmmac_rx() and stmmac_rx_zc(). It is saved again only if the frame is
still incomplete when the poll ends. The saved skb is also dropped in
stmmac_reset_rx_queue() and __free_dma_rx_desc_resources().

> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index b20e5038eeadd..fba21599a5e15 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c

[ ... ]

> @@ -6032,10 +6042,8 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
>  		/* Remove FCS if needed */
>  		if (!fcs_stripped && pskb_trim(skb, len)) {
>  			dev_kfree_skb_any(skb);
> -			skb = NULL;
>  			rx_dropped++;
> -			count++;
> -			continue;
> +			goto next;
>  		}

[Severity: Medium]
This isn't a bug introduced by this patch, but can a multi-descriptor
frame reach the stack as a truncated fragment when napi_build_skb() fails
on a descriptor that is not the last one?

The allocation failure path in stmmac_rx() does not set error:

	skb = napi_build_skb(page_address(buf->page),
			     rx_q->napi_skb_frag_size);
	if (!skb) {
		page_pool_recycle_direct(rx_q->page_pool,
					 buf->page);
		buf->page = NULL;
		rx_dropped++;
		count++;
		goto drain_data;
	}

When status & rx_not_ls is set, drain_data jumps back to read_again. At
that point skb == NULL and error == 0, and len still holds the bytes of
the dropped prefix.

With no XDP program attached, stmmac_xdp_run_prog() returns NULL. The next
descriptor of the same frame then builds a new skb from a mid-frame
buffer.

On the last descriptor, len still includes the dropped prefix. So
pskb_trim() does nothing, because len is not smaller than skb->len:

	return (len < skb->len) ? __pskb_trim(skb, len) : 0;

Wouldn't that pass a mid-payload fragment, with its FCS still attached,
to napi_gro_receive()? Its ip_summed would come from the status of the
whole frame, and rx_bytes would be counted with the full-frame len.

The same thing seems to happen across a poll boundary. In that case
in_progress saves skb == NULL, error == 0 and len.

The old status & rx_not_ls save condition behaved the same way. Later in
the series, "net: stmmac: drop multi-buffer frames in XDP mode" sets
error for rx_not_ls when XDP is enabled. The non-XDP path is unchanged.

[ ... ]

> @@ -8412,6 +8421,9 @@ static void stmmac_reset_rx_queue(struct stmmac_priv *priv, u32 queue)
>  {
>  	struct stmmac_rx_queue *rx_q = &priv->dma_conf.rx_queue[queue];
>  
> +	dev_kfree_skb_any(rx_q->state.skb);
> +	rx_q->state.skb = NULL;
> +	rx_q->state_saved = false;
>  	rx_q->cur_rx = 0;
>  	rx_q->dirty_rx = 0;
>  }

[Severity: High]
The commit message says that without this drain, a partial frame saved
before suspend would be resumed "with descriptors from the freshly
initialized ring". Is the ring actually freshly initialized on the
stmmac_resume() path?

stmmac_resume() does:

	stmmac_reset_queues_param(priv);

	stmmac_free_tx_skbufs(priv);
	stmmac_clear_descriptors(priv, &priv->dma_conf);

	ret = stmmac_hw_setup(ndev);

stmmac_clear_rx_descriptors() calls stmmac_init_rx_desc() on every RX
descriptor, and that only sets ownership bits:

- dwmac4_rd_init_rx_desc() and dwxgmac2_init_rx_desc() OR OWN|BUF1V into
  des3.
- enh_desc_init_rx_desc() and ndesc_init_rx_desc() OR RDES0_OWN into
  des0.

Buffer addresses are never reprogrammed and empty slots are not refilled.
stmmac_init_dma_engine() then sets the RX tail pointer to buf_alloc_num,
which gives every descriptor back to the DMA.

Suppose page_pool_alloc_pages() failed in stmmac_rx_refill() for the
slots used by the saved partial frame. The loop then breaks before
stmmac_set_desc_addr():

	if (!buf->page) {
		buf->page = page_pool_alloc_pages(rx_q->page_pool, gfp);
		if (!buf->page)
			break;
	}

Those descriptors keep the DMA addresses of pages that state.skb now
owns, and buf->page == NULL.

With this change, stmmac_reset_rx_queue() returns those pages to the
page_pool through dev_kfree_skb_any(). The same descriptors are then
re-armed and the DMA is restarted.

Can the device then DMA into pages that have already been recycled or
freed?

There is a separate problem on dwmac4 and xgmac. A descriptor that was
written back but not refilled before suspend still holds write-back data
in des0/des1. For example, dwmac4_wrback_get_rx_vlan_tci() reads the VLAN
tag from des0. Re-arming that descriptor would make the DMA treat the
write-back data as a buffer address.

The re-arm-without-refill behaviour predates this patch: an earlier
upstream re-init on resume was reverted. Before this patch, the stale skb
would also have been completed and freed on the first poll after resume,
while those descriptors were still armed. So this change frees the pages
earlier rather than creating the problem.

Since the resume handling depends on the ring being freshly initialized,
should the commit message be corrected? And should the resume path refill
and reprogram the RX descriptors before the DMA is restarted?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261023-stmmac-xdp-fixes-v1-0-efb37e19f5bd%40oss.qualcomm.com
