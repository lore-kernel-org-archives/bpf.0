Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 436B23CB544;
	Thu,  8 Oct 2026 19:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791486597; cv=none; b=X3d78+6v64hMYei3xe1jqJ2Bb4mv9UJEH5I9ZQLvAFTMER/fkWOUMYtl3U2k7KluF5TJxxhH6NcURLemiiLfhqOb6Y2SL7afqCOAX0/Kl1tVSdtUdRWglgXMX0Yr8ll58mewO5OeDpJUpKRZfzUCRaW1rBUfMtA/tVt7oBB2USY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791486597; c=relaxed/simple;
	bh=ZtsJ/J6og9v1sSGi5BvrXay/Rs5UivOcV4SGINHVhn8=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ifrg7h/wr4QESOjmR00BiS840+hN25X4j9hhF04BFA0/AZsdir2iCGMcBKuKTT7LPF7+qTAKBerwYbsVMEHVeBk3tNhxBMIjJ9XmJsiOeIWI9P3WyG0QiYrL8/FK7H/FlHTvAW4f69CUqK/j7Hbw/Xb/KGwk0EqmYH/F7Doth7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dxmly9Nb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dxmly9Nb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00E321F00893;
	Thu,  8 Oct 2026 19:09:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791486596;
	bh=wAWKGPJyRscDwvNxPVIL5+JORBwTt1tqurvLG0tb6lA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=dxmly9Nbbo0VSAzjLtvFMu1xA4eIgxcH+tzNFwz4Wgo8RrqR/T4svmfAYk8ndnWmk
	 v3VFU/ihyb/aji8mSwNwsH8nzmh9kxs99DOIJzQR4WxnMrE8KJK0fIUD5ygNStiFK4
	 ACHD+vkEaKaycsy6dLqSAKs9ag3NEtnsrh0byOdqJkLh71efbFViT7uXdzRHfYVDHz
	 KzE2ojMpWvD6dPSHKbv/Q5/xx7QYogFLf+khEi+TaUehdQ4GBswNeRlAyK7qtqjNNA
	 5S83utmP5olrexRBqZl3ARxcoAKrQzyJp8rfeq3k3qDMA4sVHO6CfokMKHNpSagUFl
	 cvQ7rzCvGrqUA==
Subject: Re: [PATCH net v2 2/2] net: stmmac: Stop Tx queue when (en|dis)abling
 XSK pools
From: netdev-bot+sashiko@kernel.org
To: kurt@linutronix.de
Cc: maxime.chevallier@bootlin.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, edumazet@kernel.org,
 mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com, ast@kernel.org,
 daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
 sdf@fomichev.me, yoong.siang.song@intel.com,
 noor.azura.ahmad.tarmizi@intel.com, faizal.abdul.rahim@intel.com,
 boon.leong.ong@intel.com, bigeasy@linutronix.de, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org
Date: Thu, 08 Oct 2026 19:09:54 +0000
Message-ID: <179148659458.434549.12782551117834577099@kernel.org>
In-Reply-To: <20261005-stmmac_xsk_crashes-v2-2-46c60cba6421@linutronix.de>
References: <20261005-stmmac_xsk_crashes-v2-2-46c60cba6421@linutronix.de>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 1 (1) · Medium: 0 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The patch only stops the netdev Tx queue, and the driver's own
  XDP transmit paths ignore that.

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but the new wake-
  up makes it visible: if stmmac_enable_tx_queue() fails, the Tx queue…

--

net: stmmac: Stop Tx queue when (en|dis)abling XSK pools

This patch stops the netdev Tx queue in stmmac_xdp_enable_pool() and
stmmac_xdp_disable_pool() while the Tx DMA descriptor resources are freed
and reallocated. The queue is woken once the ring has been rebuilt. The goal
is to fix crashes in stmmac_xmit() when XSK pools are toggled while Tx
traffic is running.

> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_xdp.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_xdp.c
> index d7e4db7224b0c..883bd3fe8089d 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_xdp.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_xdp.c
> @@ -6,6 +6,16 @@
>  #include "stmmac.h"
>  #include "stmmac_xdp.h"
>  
> +static void stmmac_xdp_stop_tx_queue(struct stmmac_priv *priv, u16 queue)
> +{
> +	struct netdev_queue *nq = netdev_get_tx_queue(priv->dev, queue);
> +
> +	__netif_tx_lock_bh(nq);
> +	txq_trans_cond_update(nq);
> +	netif_tx_stop_queue(nq);
> +	__netif_tx_unlock_bh(nq);
> +}

[Severity: High]

Does setting __QUEUE_STATE_DRV_XOFF here keep the driver's own XDP
transmit paths away from the ring while it is freed and reallocated?

The Tx lock is released before stmmac_disable_tx_queue() calls
__free_dma_tx_desc_resources(). DRV_XOFF only stops callers that reach
ndo_start_xmit through the stack.

Both XDP Tx paths in stmmac_main.c choose the queue by CPU. Neither checks
whether that queue is stopped before calling stmmac_xdp_xmit_xdpf():

stmmac_xdp_xmit_back() {
    ...
	queue = stmmac_xdp_get_tx_queue(priv, cpu);
	nq = netdev_get_tx_queue(priv->dev, queue);

	__netif_tx_lock(nq, cpu);
    ...
	res = stmmac_xdp_xmit_xdpf(priv, queue, xdpf, zc);
    ...
}

stmmac_xdp_xmit() {
    ...
	if (unlikely(test_bit(STMMAC_DOWN, &priv->state)))
		return -ENETDOWN;
    ...
	__netif_tx_lock(nq, cpu);
    ...
		res = stmmac_xdp_xmit_xdpf(priv, queue, frames[i], true);
    ...
}

need_update requires stmmac_xdp_is_enabled(), so an XDP program is always
attached while this window is open. Only the NAPI instances of this one
channel are disabled.

Two producers can still reach this queue during the window:

- RX NAPI of another channel, running on a CPU that
  stmmac_xdp_get_tx_queue() maps to this queue, can hit XDP_TX.
- A redirect from another device on such a CPU can enter
  stmmac_xdp_xmit().

Either path then runs:

stmmac_xdp_xmit_xdpf()
    stmmac_get_tx_desc()
    stmmac_set_tx_dma_entry()
    tx_q->xdpf[entry] = ...
    stmmac_set_desc_addr()

These calls can write into the descriptor ring that was released with
dma_free_coherent() and into the kfree()'d tx_skbuff_dma array. They can
also race with __init_dma_tx_desc_rings() while the ring is being rebuilt.

In stmmac_xdp_disable_pool(), synchronize_rcu() only runs after the ring has
already been freed:

		stmmac_disable_tx_queue(priv, queue);
		synchronize_rcu();

so it cannot drain ndo_xdp_xmit callers that are in flight before the free.

Would this need a per-queue gate that the XDP Tx paths check under the Tx
lock, or a drain before the free, rather than DRV_XOFF alone?

[ ... ]

> @@ -46,6 +57,7 @@ static int stmmac_xdp_enable_pool(struct stmmac_priv *priv,
>  		stmmac_enable_rx_queue(priv, queue);
>  		stmmac_enable_tx_queue(priv, queue);
>  		napi_enable(&ch->rxtx_napi);
> +		netif_tx_wake_queue(netdev_get_tx_queue(priv->dev, queue));

[Severity: High]

This is a pre-existing issue that this patch did not introduce, but the
new wake-up makes it more visible. What happens here if
stmmac_enable_tx_queue() failed?

stmmac_enable_tx_queue() returns void and only logs the failure:

	ret = __alloc_dma_tx_desc_resources(priv, &priv->dma_conf, queue);
	if (ret) {
		netdev_err(priv->dev, "Failed to alloc TX desc.\n");
		return;
	}

A failure in __init_dma_tx_desc_rings() is handled the same way. Either way
it skips stmmac_init_tx_chan(), stmmac_start_tx_dma() and
stmmac_enable_dma_irq().

__free_dma_tx_desc_resources() never clears tx_q->dma_tx/dma_etx/dma_entx,
tx_skbuff_dma or tx_skbuff. That leaves three problems:

- If dma_alloc_coherent() fails in __alloc_dma_tx_desc_resources(), the
  descriptor pointer still points at the freed coherent memory.
- If the tx_skbuff allocation fails, tx_skbuff is left NULL.
- The earlier partial allocations leak.

netif_tx_wake_queue() is called unconditionally here and in
stmmac_xdp_disable_pool(). The next stmmac_xmit() would then dereference
tx_q->tx_skbuff[first_entry]. It would also write descriptors through
stmmac_get_tx_desc() into the freed ring. That is the same
dwmac4_set_addr()/dwmac4_set_vlan_tag() crash described in the commit
message.

A later stmmac_release()->free_dma_desc_resources() could also free the
stale pointers a second time.

Before this patch the queue was never stopped, so traffic hit the broken
ring the same way.

Should the failure be returned to the callers, the partial allocations
unwound, and the queue kept stopped until a valid ring is in place?

>  
>  		err = stmmac_xsk_wakeup(priv->dev, queue, XDP_WAKEUP_RX);
>  		if (err)

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261005-stmmac_xsk_crashes-v2-0-46c60cba6421%40linutronix.de
