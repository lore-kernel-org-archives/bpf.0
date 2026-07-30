Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 512EB341AB8;
	Thu, 30 Jul 2026 00:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785373004; cv=none; b=sSMvCYU6Lzlrhe0GvjWEGlJnE98S7pfvUS9XLMPK6g05JJilOqw+io5u0Y2q8rEbM2jNFmOuB7FV7f7pfkfWumzQNuD2vriekGiH19UDzXqFtHKNOjOfFYtzlRi5lNCCfwmUs2gLz20Kh7TXId1cwBOhjCvuGVmD3JK0KMR0MsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785373004; c=relaxed/simple;
	bh=TGXAVbJ8M7/8sVn7272d59dvJaxYLMb7UM2W2k0prXI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DEd2Dosb0gmKq1kXqDdhre0uu0OJBJI1TTp99wqSDWFeKObZXso7RnShedQACnF1SdOeMFPi7ye3z8YLvr53j1oxQ/BNjcJM0GHyWL5zIc2pK/AIr+X7p7WWSVGUDPTL3dsScByBqTmJ+TSTNBUgggPeGvz3TuPJF/g/+DtS+Ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XrJvNsuw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XrJvNsuw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC5941F000E9;
	Thu, 30 Jul 2026 00:56:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785373003;
	bh=/uAsm6obouSYYL/w0xQlW0IdkAzP1qciAls9Tgbh6io=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XrJvNsuw4b+dVX996Z+Ux4DHk5bSI0uZZv1kgYjCOAEgqBW6c8Pwmy2wTWM6psSvc
	 /y3ZSmuegdj28uRtxa8OHTPmifrjiAL2KNoAvJ3a7SF3X288hKyTXlmCNDfB7rOIPp
	 2zv/Sb5BczyHE2aLyY58X43HA3zoFdYsb3+DSdsbQ/0or6p5BaoExkAYrNrwjr12xR
	 bgwFHcWoCgg6qwqp5MestSPnZRcG4Fr9b3qsHfvTrAMfSn/hoSo6Pl9katy35oKfN5
	 ei+aj7AsFgfN9eMzdU7+1LHvC4ve+pbhbrI7MJFcRwj3n7gQRxwlmiudzi+mugec9O
	 gtFPN2pnQdfPg==
From: Jakub Kicinski <kuba@kernel.org>
To: muhammad.nazim.amirul.nazle.asmade@altera.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	ansuelsmth@gmail.com,
	pabeni@redhat.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	bpf@vger.kernel.org,
	Rohan G Thomas <rohan.g.thomas@altera.com>
Subject: Re: [PATCH net] net: stmmac: Disable queues before netif_tx_disable in xdp_release
Date: Wed, 29 Jul 2026 17:56:41 -0700
Message-ID: <20260730005641.4191366-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260727030645.13280-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
References: <20260727030645.13280-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
--- Patch [1]: [PATCH net] net: stmmac: Disable queues before netif_tx_disable in xdp_release ---
commit 6e8cad0a87bc0c603226682b31766cc479b5cc44
Author: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>

net: stmmac: Disable queues before netif_tx_disable in xdp_release

This moves netif_tx_disable() in stmmac_xdp_release() so that it runs
after stmmac_disable_all_queues() and the per-queue txtimer hrtimer_cancel()
loop.  The stated goal is to stop NAPI before TX is disabled, matching the
ordering used in stmmac_release().

Comments on the commit message and the reordering follow.

>     Fix this by calling stmmac_disable_all_queues() first to stop NAPI
>     processing before disabling TX, matching the order already used in
>     stmmac_release() since 7028471edb64.
>
>     Fixes: 7028471edb64 ("net: ethernet: stmicro: stmmac: first disable all queues and disconnect in release")

[Severity: Low]
Is this the right Fixes target?  Looking at 7028471edb64, its diff only
touches stmmac_release(); stmmac_xdp_release() is not modified there, and
at that revision stmmac_xdp_release() had no netif_tx_disable() call at
all.

The two lines being moved here were added by 77711683a504 ("net: stmmac:
ensure tx function is not running in stmmac_xdp_release()"), whose diff
adds exactly:

	/* Ensure tx function is not running */
	netif_tx_disable(dev);

Should the tag point at 77711683a504 instead?  As written, a stable
backport would be selected for trees containing 7028471edb64 (v6.0) even
though the code being changed only exists from 77711683a504 (v6.1)
onwards.

>     Signed-off-by: Rohan G Thomas <rohan.g.thomas@altera.com>
>     Signed-off-by: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>

[Severity: Low]
The From: author is Nazim Amirul, but the first Signed-off-by: in the
chain is Rohan G Thomas, and there is no Co-developed-by: line.

Documentation/process/submitting-patches.rst says the SoB chain should
reflect the real route a patch took, "with the first SoB entry signalling
primary authorship of a single author", and that every Co-developed-by:
must be immediately followed by the Signed-off-by: of that co-author.

Should either the commit author be Rohan G Thomas, or a
Co-developed-by: Rohan G Thomas <rohan.g.thomas@altera.com> line be added
immediately before his Signed-off-by:?

> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index 151c77713025c..d806687788a8d 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -7085,15 +7085,15 @@ void stmmac_xdp_release(struct net_device *dev)
>  	struct stmmac_priv *priv = netdev_priv(dev);
>  	u8 chan;
>  
> -	/* Ensure tx function is not running */
> -	netif_tx_disable(dev);
> -
>  	/* Disable NAPI process */
>  	stmmac_disable_all_queues(priv);
>  
>  	for (chan = 0; chan < priv->plat->tx_queues_to_use; chan++)
>  		hrtimer_cancel(&priv->dma_conf.tx_queue[chan].txtimer);
>  
> +	/* Ensure tx function is not running */
> +	netif_tx_disable(dev);
> +

[Severity: Medium]
Is this a functional revert of 77711683a504 ("net: stmmac: ensure tx
function is not running in stmmac_xdp_release()")?  That commit
deliberately placed these two lines as the first statement of
stmmac_xdp_release(), with the reasoning "there is a possibility that tx
function is still running on other queues which will lead to tx queue
timed out and reset adapter".  The changelog here neither mentions that
commit nor explains why its concern no longer applies.

The new order also leaves ndo_start_xmit live while TX completion is
already off.  stmmac_disable_all_queues() can sleep:

drivers/net/ethernet/stmicro/stmmac/stmmac_main.c:stmmac_disable_all_queues() {
	for (queue = 0; queue < rx_queues_cnt; queue++) {
		rx_q = &priv->dma_conf.rx_queue[queue];
		if (rx_q->xsk_pool) {
			synchronize_rcu();
			break;
		}
	}
	__stmmac_disable_all_queues(priv);
}

During that window (plus the hrtimer_cancel() loop) the TX queues are
still enabled, so stmmac_xmit() on another CPU can accept frames and ring
the TX doorbell after TX-completion NAPI has been disabled.  Those frames
are never TX-completed, and their descriptors and buffers are torn down a
few statements later by stmmac_stop_all_dma()/free_dma_desc_resources().

Note the sole caller runs with the interface up, so unlike the ndo_stop
path the core has not quiesced the qdisc:

drivers/net/ethernet/stmicro/stmmac/stmmac_xdp.c:stmmac_xdp_set_prog() {
	...
	if (if_running && need_update)
		stmmac_xdp_release(dev);
	...
}

Is the claim that "matching the order already used in stmmac_release()"
makes this safe accurate here, given that stmmac_release() is invoked
from ndo_stop with TX already drained by the core?

Also, can the changelog substantiate "it can be processed after TX is
stopped, leading to a kernel panic"?  No mechanism or reproducer is given
for that panic.

>  	/* Free the IRQ lines */
>  	stmmac_free_irq(dev, REQ_IRQ_ERR_ALL, 0);
>  
>  	/* Stop TX/RX DMA channels */
>  	stmmac_stop_all_dma(priv);

[Severity: Medium]
This isn't a bug introduced by this patch, but the reorder widens the
exposure of an existing gap in the XDP teardown path.  netif_tx_disable()
now sits immediately before stmmac_free_irq(), stmmac_stop_all_dma() and
free_dma_desc_resources(), so the last frame accepted by stmmac_xmit()
(already hardware-owned and doorbelled via the TX tail pointer) can be in
flight only microseconds before the rings are released.

The TX DMA stop has no completion handshake:

drivers/net/ethernet/stmicro/stmmac/dwmac4_lib.c:dwmac4_dma_stop_tx() {
	value &= ~DMA_CONTROL_ST;
	writel(value, ioaddr + DMA_CHAN_TX_CONTROL(dwmac4_addrs, chan));
	...
}

stmmac_stop_all_dma() only loops over stop_rx_dma/stop_tx_dma/deinit_chan,
and dwmac4_dma_deinit_channel() just masks channel interrupts; nothing
polls for "transmit process stopped".  TX completion cannot drain the ring
either, since napi_disable() already ran.

Previously the whole of stmmac_disable_all_queues() (including a possible
synchronize_rcu() when an XSK pool is attached) plus the hrtimer_cancel()
loop sat between the last doorbell and DMA teardown, which acted as a
de-facto drain window.  After this change only free_irq() and a few MMIO
writes remain.

Can free_dma_desc_resources() then dma_free_coherent() the descriptor ring
and unmap the TX buffers while the engine is still fetching a descriptor
or writing back status?  Would the order napi_disable -> netif_tx_disable
-> hrtimer_cancel, or an explicit wait for the transmit process to stop
before free_dma_desc_resources(), avoid this?  The same missing handshake
exists in __stmmac_release(), so this is not new here.
-- 
pw-bot: cr
