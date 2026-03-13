Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A600389116;
	Fri, 13 Mar 2026 09:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773395547; cv=none; b=aCxnhkk3oOYXNpvFuImC/XE90s7WoqV0nsf3cEs5BMzNDRfVAwLdKdzEr+hB4lVhl/F2FCVicmJLKMtzsAYmUIvFNvJEsswpuDoRXtOkn/aZUNzSEGM95vHpWKleHcatpT3zvdRR2akJCZMS43mqVterFVoVmy9EagY9iTaicpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773395547; c=relaxed/simple;
	bh=wlHzuUH0gUssp1UjidQbhAVH/CdfFqbsFbfXxNH8yRQ=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=oJ/QAF8ApujaV+I2f8sly/UNidSgDvemBDtxD2A4qkcvaX/XoHj4rcY0jVi7rV+/i6rz55qnBurEj2oY1zLk+2SR2YWpqW3iHXzhpuc29EwCMtvNr4nh45+WRDbHZIXw0yw1PBw+QnuLV9UMfOGbIF34Iyoift0GDFvUQ8Wkzf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=IS6TiZha; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="IS6TiZha"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=jy7ZZYhO/l6AOCV4Dt/j5MRaTr5NmlKcOirpso5gcsI=; b=IS6TiZhaV0r1bpOdecb9kd2zO3
	dD+nbNrCUZkuwrfym0QXMmg1pFWyHd9jO0+DXZJnQ1dmdm6S0+UHCnxOnmt9S0uUdoiniBoqHGSds
	0mAhaK7gupwWjWkExGdhAyM6yyGYSdOC3CVtLdTiVFby49GLG/22tLeYrOWQR+9AOzGbamw0163ob
	j1rYlZfrRYq+w8eNoRQiGjHq4+7913owSh9W074U8TBLvoKSsKCZDOCsJs/7K8pKSUZQ7mFVRY4dI
	Rs6IMA7eSNSTudh7m0WAiaob+l59EEUmUzRMUlVybxLihfLaRagXRbxmjKW1DiPBxYF6xLKMWIpMe
	iLoJhtVg==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:47236 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1w0zBo-000000000hB-43IP;
	Fri, 13 Mar 2026 09:52:17 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1w0zBm-0000000D4GM-1hc0;
	Fri, 13 Mar 2026 09:52:14 +0000
In-Reply-To: <abPdzyXJHqt5v3bi@shell.armlinux.org.uk>
References: <abPdzyXJHqt5v3bi@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	bpf@vger.kernel.org,
	Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Stanislav Fomichev <sdf@fomichev.me>
Subject: [PATCH net-next v3 15/15] net: stmmac: use queue rather than
 ->queue_index
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1w0zBm-0000000D4GM-1hc0@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Fri, 13 Mar 2026 09:52:14 +0000

We use a lot of ->queue_index where we already have the queue / channel
index (which are actually the same index), which has been used to get
the queue struct. Since queue and queue_index are identical in
priv->(tx|rx)_queue[queue]->queue_index there is no point using the
queue_index where we already have queue.

Use queue rather than queue_index.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 25 ++++++++-----------
 1 file changed, 11 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 55b79e9e637f..8393cbd0875e 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -440,7 +440,7 @@ static void stmmac_set_queue_rx_buf_size(struct stmmac_priv *priv,
 	else
 		buf_size = priv->dma_conf.dma_buf_sz;
 
-	stmmac_set_dma_bfsize(priv, priv->ioaddr, buf_size, rx_q->queue_index);
+	stmmac_set_dma_bfsize(priv, priv->ioaddr, buf_size, chan);
 }
 
 /**
@@ -1902,7 +1902,7 @@ static int __init_dma_rx_desc_rings(struct stmmac_priv *priv,
 						   NULL));
 		netdev_info(priv->dev,
 			    "Register MEM_TYPE_XSK_BUFF_POOL RxQ-%d\n",
-			    rx_q->queue_index);
+			    queue);
 		xsk_pool_set_rxq_info(rx_q->xsk_pool, &rx_q->xdp_rxq);
 	} else {
 		WARN_ON(xdp_rxq_info_reg_mem_model(&rx_q->xdp_rxq,
@@ -1910,7 +1910,7 @@ static int __init_dma_rx_desc_rings(struct stmmac_priv *priv,
 						   rx_q->page_pool));
 		netdev_info(priv->dev,
 			    "Register MEM_TYPE_PAGE_POOL RxQ-%d\n",
-			    rx_q->queue_index);
+			    queue);
 	}
 
 	if (rx_q->xsk_pool) {
@@ -2310,9 +2310,7 @@ static int __alloc_dma_rx_desc_resources(struct stmmac_priv *priv,
 	else
 		napi_id = ch->rx_napi.napi_id;
 
-	ret = xdp_rxq_info_reg(&rx_q->xdp_rxq, priv->dev,
-			       rx_q->queue_index,
-			       napi_id);
+	ret = xdp_rxq_info_reg(&rx_q->xdp_rxq, priv->dev, queue, napi_id);
 	if (ret) {
 		netdev_err(priv->dev, "Failed to register xdp rxq info\n");
 		return -EINVAL;
@@ -3340,7 +3338,7 @@ static void stmmac_tx_timer_arm(struct stmmac_priv *priv, u32 queue)
 	if (!tx_coal_timer)
 		return;
 
-	ch = &priv->channel[tx_q->queue_index];
+	ch = &priv->channel[queue];
 	napi = tx_q->xsk_pool ? &ch->rxtx_napi : &ch->tx_napi;
 
 	/* Arm timer only if napi is not already scheduled.
@@ -6918,12 +6916,11 @@ void stmmac_enable_rx_queue(struct stmmac_priv *priv, u32 queue)
 	stmmac_clear_rx_descriptors(priv, &priv->dma_conf, queue);
 
 	stmmac_init_rx_chan(priv, priv->ioaddr, priv->plat->dma_cfg,
-			    rx_q->dma_rx_phy, rx_q->queue_index);
+			    rx_q->dma_rx_phy, queue);
 
-	stmmac_set_queue_rx_tail_ptr(priv, rx_q, rx_q->queue_index,
-				     rx_q->buf_alloc_num);
+	stmmac_set_queue_rx_tail_ptr(priv, rx_q, queue, rx_q->buf_alloc_num);
 
-	stmmac_set_queue_rx_buf_size(priv, rx_q, rx_q->queue_index);
+	stmmac_set_queue_rx_buf_size(priv, rx_q, queue);
 
 	stmmac_start_rx_dma(priv, queue);
 
@@ -6969,12 +6966,12 @@ void stmmac_enable_tx_queue(struct stmmac_priv *priv, u32 queue)
 	stmmac_clear_tx_descriptors(priv, &priv->dma_conf, queue);
 
 	stmmac_init_tx_chan(priv, priv->ioaddr, priv->plat->dma_cfg,
-			    tx_q->dma_tx_phy, tx_q->queue_index);
+			    tx_q->dma_tx_phy, queue);
 
 	if (tx_q->tbs & STMMAC_TBS_AVAIL)
-		stmmac_enable_tbs(priv, priv->ioaddr, 1, tx_q->queue_index);
+		stmmac_enable_tbs(priv, priv->ioaddr, 1, queue);
 
-	stmmac_set_queue_tx_tail_ptr(priv, tx_q, tx_q->queue_index, 0);
+	stmmac_set_queue_tx_tail_ptr(priv, tx_q, queue, 0);
 
 	stmmac_start_tx_dma(priv, queue);
 
-- 
2.47.3

