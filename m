Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9DCE459ADC;
	Tue, 15 Sep 2026 08:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789462529; cv=none; b=BcnEZ7dM/hKHR3xJ72CPIjeW0lb4mx3TVw2OI4tC+egMjYfRtlD/G78RD2XnvzeOUz33okww6K9PrfBTg9vw1fr5KzwfxHvmMdsD0slWikH7PgI427Mz1194Xj+KOVarjCbKDFXwYbhgNjCFy3LuFa4IhNQ3B0BhHyW+NEnyrZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789462529; c=relaxed/simple;
	bh=jb3w8wlq+Qv0ygeGwRU6Z+PlNF4szhvoi5z8UQOxTlg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IrYCXEPgoRG5HHjG5J1gMmr3yatgnyAwxICqBcCRFso+Rw6hX9s4bQ/9NXm9ElGNnJBKCtrtXgotxuP4aTJEetkz/pzU3cEAItFz67ZlTHpxQw8h8zYd1GVfG8tC0YQVnw12BMnib2wvRDLx6eLks+6MrzdKj/VqyZJ3cvAM+rI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZIuDE2lw; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BO2ps6V/; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZIuDE2lw";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BO2ps6V/"
From: Kurt Kanzenbach <kurt@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1789462525;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DvAqa5evJVnKh8G03byOaDnVEYcO6OUHZZiRC6VgjpQ=;
	b=ZIuDE2lw+VwT9CnPFGVL98Ofa/deyDQiEif4a67Na/f1/c7mB2i9Op/v1j+JzCu29uZu0P
	Z5Cv2v3x2E+NL3IJsPK+kbz48wD8S07jVdEiRtiJYj3zEiWFZyT7CCFi3eByD7Oyt+XyTv
	LiPdsw5oQDT6xLcNUgKySyMbMHLGofpIXb4hkc2SGak0r0NV3xnCrvqax6YYbwmkQdtUHJ
	ihN1i9g8cjDSiRq07wKt654szOjLGaoAKI7Lok7NvEHJmAIVk3GaCmZkirfYfeEWRpGGhR
	l80SMfgVPLA12e3E574iJghjgmgTz92ua0vQglGyYxGCKfKZ7S6t8rXH4uKIpg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1789462525;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DvAqa5evJVnKh8G03byOaDnVEYcO6OUHZZiRC6VgjpQ=;
	b=BO2ps6V/Ws6mGmzzs96OVKHelSA6/FTD4+OHsip7PMMbSEg3irweOBQVogm0Xoibt6kdYx
	YtHq5TWBxGId2xBw==
Date: Tue, 15 Sep 2026 10:55:06 +0200
Subject: [PATCH RFC net 2/2] net: stmmac: Stop Tx queue when (en|dis)abling
 XSK pools
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260915-stmmac_xsk_crashes-v1-2-e14553fcf553@linutronix.de>
References: <20260915-stmmac_xsk_crashes-v1-0-e14553fcf553@linutronix.de>
In-Reply-To: <20260915-stmmac_xsk_crashes-v1-0-e14553fcf553@linutronix.de>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, 
 Song Yoong Siang <yoong.siang.song@intel.com>, 
 Noor Azura Ahmad Tarmizi <noor.azura.ahmad.tarmizi@intel.com>, 
 Mohd Faizal Abdul Rahim <faizal.abdul.rahim@intel.com>, 
 Ong Boon Leong <boon.leong.ong@intel.com>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, netdev@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org, 
 Kurt Kanzenbach <kurt@linutronix.de>
X-Developer-Signature: v=1; a=openpgp-sha256; l=3072; i=kurt@linutronix.de;
 h=from:subject:message-id; bh=jb3w8wlq+Qv0ygeGwRU6Z+PlNF4szhvoi5z8UQOxTlg=;
 b=owEBbQKS/ZANAwAKAcGT0fKqRnOCAcsmYgBqqQf8Rae688HCKG4SYbiJWE30GbSItajMZk8qi
 MDgrrri2n+JAjMEAAEKAB0WIQS8ub+yyMN909/bWZLBk9HyqkZzggUCaqkH/AAKCRDBk9HyqkZz
 gjfmD/0fY5JaRyYAEzmht8tz7MMLCTOf98MmqAnVVcBOaCPLsigShdGsCifmwESageKSCe/wueG
 IUFy+OrtFSKqsLTdmP8UfBJaqaExXS8YJzXLGhgS+BNWuO2hDPHLV8tIkxK6hxPSesF3lZ0Lz5M
 Z74KdmE3KGagbCaKay315nz3Q6jqYRKSQcGWYrmYyMqTWSK7IM/3KrugE2hmRLuTaKwSMw5z40Y
 YENOOhALKxaZnfMitlyFXzDOW5NuYTMxJhHDhlYghpdhS3EV/jmkGFuCLwEP7uocWfDpG5LQwUr
 c2XcRJbXxHsURje15qVoHhMTo8BtFGJzXcgmuNdLTleMLlrXmfYnkZC0Kr1lu2nZT5dxpCVsZbP
 szplSoN49Le+/vXP8pScExNPvl/kc2mcYudJw6Zhj4CZLyirzbbS3vkyukXoHoINbgO9Kd2vjTA
 pgy9TH3MLFJaVd0r/IagRtL6pUbsezJlxD/9hHYpHgfNOD/fsO6SDpDRjmU3GJEH9n+ZVGaKPuL
 +jJ5ONnoDmkCsiPwkTxxxdFmaobiHYR9IlM2xKm/XIIkqPL6XPkrlAa9fp5FHLerLgn7Sp8ioVb
 hWQ53Un6fut5YA1E0ZKp+E4GRw/yZ/Z1zqM5Mlf5L1pzPYNtLlUY6wkQiJdtBa10kgsPc0IaQQv
 uxmfdsAeXCepr8g==
X-Developer-Key: i=kurt@linutronix.de; a=openpgp;
 fpr=BCB9BFB2C8C37DD3DFDB5992C193D1F2AA467382

When enabling or disabling XSK pools in parallel to Tx traffic, kernel
crashes occur. For VLAN tagged frames that happens in stmmac_xmit() ->
dwmac4_set_vlan_tag() and for normal frames in stmmac_xmit() ->
dwmac4_set_addr(). Both of these functions access the Tx DMA descriptors.

The XDP pool (en|dis)ablement frees and reallocates the Tx DMA resources:

 stmmac_disable_tx_queue:
   __free_dma_tx_desc_resources

 stmmac_enable_tx_queue:
   __alloc_dma_tx_desc_resources
   __init_dma_tx_desc_rings

NAPI is disabled during that allocation window, but the Tx queue is not
stopped. Therefore, add the stopping of the Tx queue during the enabling
and disabling of XSK pools. Update trans_start when stopping the queue
to avoid spurious watchdog timeouts.

The issue can be easily reproduced by:

 1. Run iperf
 2. Run application which opens an AF_XDP/ZC socket

Fixes: 132c32ee5bc0 ("net: stmmac: Add TX via XDP zero-copy socket")
Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_xdp.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_xdp.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_xdp.c
index d7e4db7224b0..883bd3fe8089 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_xdp.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_xdp.c
@@ -6,6 +6,16 @@
 #include "stmmac.h"
 #include "stmmac_xdp.h"
 
+static void stmmac_xdp_stop_tx_queue(struct stmmac_priv *priv, u16 queue)
+{
+	struct netdev_queue *nq = netdev_get_tx_queue(priv->dev, queue);
+
+	__netif_tx_lock_bh(nq);
+	txq_trans_cond_update(nq);
+	netif_tx_stop_queue(nq);
+	__netif_tx_unlock_bh(nq);
+}
+
 static int stmmac_xdp_enable_pool(struct stmmac_priv *priv,
 				  struct xsk_buff_pool *pool, u16 queue)
 {
@@ -36,6 +46,7 @@ static int stmmac_xdp_enable_pool(struct stmmac_priv *priv,
 	if (need_update) {
 		napi_disable(&ch->rx_napi);
 		napi_disable(&ch->tx_napi);
+		stmmac_xdp_stop_tx_queue(priv, queue);
 		stmmac_disable_rx_queue(priv, queue);
 		stmmac_disable_tx_queue(priv, queue);
 	}
@@ -46,6 +57,7 @@ static int stmmac_xdp_enable_pool(struct stmmac_priv *priv,
 		stmmac_enable_rx_queue(priv, queue);
 		stmmac_enable_tx_queue(priv, queue);
 		napi_enable(&ch->rxtx_napi);
+		netif_tx_wake_queue(netdev_get_tx_queue(priv->dev, queue));
 
 		err = stmmac_xsk_wakeup(priv->dev, queue, XDP_WAKEUP_RX);
 		if (err)
@@ -73,6 +85,7 @@ static int stmmac_xdp_disable_pool(struct stmmac_priv *priv, u16 queue)
 
 	if (need_update) {
 		napi_disable(&ch->rxtx_napi);
+		stmmac_xdp_stop_tx_queue(priv, queue);
 		stmmac_disable_rx_queue(priv, queue);
 		stmmac_disable_tx_queue(priv, queue);
 		synchronize_rcu();
@@ -87,6 +100,7 @@ static int stmmac_xdp_disable_pool(struct stmmac_priv *priv, u16 queue)
 		stmmac_enable_tx_queue(priv, queue);
 		napi_enable(&ch->rx_napi);
 		napi_enable(&ch->tx_napi);
+		netif_tx_wake_queue(netdev_get_tx_queue(priv->dev, queue));
 	}
 
 	return 0;

-- 
2.47.3

