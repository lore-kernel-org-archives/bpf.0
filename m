Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9B3F36654F;
	Mon,  5 Oct 2026 07:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791184188; cv=none; b=HwD9rOtIEZcMo4FFai3J/59hNhNgXkNkGr1fBYLJptmQztOUD8BNsh8Fe7SYpsng6pTuMKP46+XqlshBzmpK4BfUGxeO/Eil0c9AiyuhCDvOJut7PjFYYe1WQ4dEHEDHKDag06qI4SGAI1BSGHYh4vY77vxy9qablMusjxe9wKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791184188; c=relaxed/simple;
	bh=jb3w8wlq+Qv0ygeGwRU6Z+PlNF4szhvoi5z8UQOxTlg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aPSqucixi63ulhyINZG9Wy9FU6aV6ySh9H+TcwdD4sjCagOV9E4Q22ITHQqH0L3b9Uf/sLGeJWlfnwpBNrNyN9qhb7+wxlex1df29U3zni7CMyy7MRZVPp4LW0xKSZcZEFYJM6C57RGHOvuhIBrWSC9uS9AoLgCnueGbucl9jXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qlWY/WNi; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=8ZC8WLsO; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qlWY/WNi";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="8ZC8WLsO"
From: Kurt Kanzenbach <kurt@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1791184179;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DvAqa5evJVnKh8G03byOaDnVEYcO6OUHZZiRC6VgjpQ=;
	b=qlWY/WNil89xHkJXqcNhNDh7SH8KOJkI9faiXyeeVX0o/e/dGYhh5G52PQoUKjcGlmd6ZK
	a1LlV+ue9G+kk51rGf7IPjALjKwfAORmtpdB6jQ55/OijFvIvFDmseBx34Ru/JA1QpTw1T
	iqlHiLQa894YfW9dizNUKSi8CnKMhRH1c84FGK9W9UygYvcRQT/gOnyqklYTGLs0hJOH+R
	pPqR6CbacfKkc6p1m0MZijHM+OAmEhCKYDQWcgNb07xs15iBrxps3QbK+WCE0uKY8sSYfB
	fjonK/U1GlvPKro4vEwq0K6TfmmnXlMAX/xBm6JbhIfauFP1wgsaLa5s6XiG0g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1791184179;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DvAqa5evJVnKh8G03byOaDnVEYcO6OUHZZiRC6VgjpQ=;
	b=8ZC8WLsObKrg36pl1W3xiX/5ip6R2QRS8OMH6vVYuGXmCB5sd0ZM9Cp49JTAHi31Oj3+1F
	ikk5+/rg9FPkSVCw==
Date: Mon, 05 Oct 2026 09:09:33 +0200
Subject: [PATCH net v2 2/2] net: stmmac: Stop Tx queue when (en|dis)abling
 XSK pools
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261005-stmmac_xsk_crashes-v2-2-46c60cba6421@linutronix.de>
References: <20261005-stmmac_xsk_crashes-v2-0-46c60cba6421@linutronix.de>
In-Reply-To: <20261005-stmmac_xsk_crashes-v2-0-46c60cba6421@linutronix.de>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@kernel.org>
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
 b=owEBbQKS/ZANAwAKAcGT0fKqRnOCAcsmYgBqw00x6lywVr+g9Y9cbBChHwgASqwcTubl1SZqL
 K9vJg4flIKJAjMEAAEKAB0WIQS8ub+yyMN909/bWZLBk9HyqkZzggUCasNNMQAKCRDBk9HyqkZz
 gj4aD/wI1Xuu0ydvTV+3CfCelalHG2IV4MofX4FEydwzgfoW0RVV5KsT0AF86WXKM2GOX1z9i06
 cMMF/31xK4NSqNJ0Tx86r1gN4aI51ONdUfelSIKouic/mOhDKFszFJLYuLt3WuPqa84pg30yZxT
 7FEr1CGAUevTAAoQfttqM/HmmiyVfDq2u66kl2FA52Qo9QfpDHGNh0QSnztYymJPUJfWj5vACmV
 3xECciUoaidvbyQEzUAuyGa7GsTw+ZX03e9RSf/4yr7Sto5CrT28MzW3eYqw5ePHutL09shElHe
 Smd1ij2z5MnB9eoMoyOIauqYQHkfC5OH0GfL5FvRpezdsmwSZBzyfbZTFLkxtNpdB0o9kb81log
 QTVmM8HdOHiLMxo3PXE9rnZvUGRVUj13pp7R6l+kV7KRF/vS9DwOxsSCl76ubjnYk62oTqYBVus
 riKacf3Lza+4c0Dsu4ZHOo6O7Um1t0jR8R2umjyENU8KCqrc94ns4r+7Mis+lMHCnsFn2R3rzLO
 nZFcpGNmVc8ab36S+pzqSycdMW4MgSi4s8CA3Uoh5EB9xBldI5tXibNQjJ7Kg+rXWVp2uakWegK
 KeebELsxoWVWlYLLWbF4DvSW7WEOP5HTXRQSINhLVY86rCOUkAvTBBwhP7xxB1q6Nekwl+/K///
 +I1P5eUtWS1d6ag==
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

