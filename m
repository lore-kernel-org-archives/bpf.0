Received: from mail-oo2-f37.google.com (mail-oo2-f37.google.com [74.125.231.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A38EA438011
	for <bpf@vger.kernel.org>; Sun, 27 Sep 2026 22:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790546422; cv=none; b=C2Rhuz3GJStl0wwEfzK2//b8Zm+AT5mz4lGQshCn54qZKdLIz5Cmy87pW+Mr2iUxWtgCUaAasb8H6wemZiyxwPJDeAwn4sMHJEywCwu4qoU+MpbIovU+7Kde5wk151m7ZpGUe/Od9kvCkknOBWhouqb0e50g5lTXSLCDCwmVapM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790546422; c=relaxed/simple;
	bh=hGe7opUWtd3dH+BdZuV25FvF4CrbbA/rtGiLv7Y7dx0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rUqJbkcpeCqsEjjVaRDqbu0PlnpQcqNNS7eih/t/K1gMXBXHDqFBrcQpDoOSys7SN/OzSxqbyYPx2RN0tKB9HCPzXF0/hZNOv5jvLnO9D1eHbbRdO5n1e4pQqscenrYFRfJZVBxw6TmDrn4Eq1QcslVZ9R96EvPmSz0YUhFEVoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UHrFFPym; arc=none smtp.client-ip=74.125.231.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UHrFFPym"
Received: by mail-oo2-f37.google.com with SMTP id 46e09a7af769-8137b129131so1604973a34.2
        for <bpf@vger.kernel.org>; Sun, 27 Sep 2026 15:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790546414; x=1791151214; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=83ThLbPC5Dd2yel01jjZwvC9Fqqb0286KBpR//NQh0A=;
        b=UHrFFPymSvZvb/sw3uMIuvlZzTGk4450dm76KbUfFaWlXzX1fJljVIYPJY/rWTS3mp
         xKtWcoKroSN+boopjjE+t6qe0zfl+C+KOnCVXher7nSqB5/NJZcWY11Zk0goR5mNlKFj
         rOqDtgrdzo53QeyAWmm23h9fPH0VIhd7uC8SjG3tP4h8aE0xuWAukJmHY6EH/3Tqf/56
         lHsn9qArSGM24Aoue2mawlsvQf/L8mDb3mz2pNGGaOAJ4hS/2uN+cFeFzF8z3J1zhiIt
         ooak+xVdjejbnE01BtM/sqoGDZEbO6eMJyFEEwvAi01YvG2qqzQeas4xyU2Nc4PNQuZV
         dCIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790546414; x=1791151214;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=83ThLbPC5Dd2yel01jjZwvC9Fqqb0286KBpR//NQh0A=;
        b=MoWQtxuyyFdx8h7e1lCpULmuKCpYn8INsbCwvAD1Ft+nBrKas3nfEQ/G3k9fIycy82
         L0uau2FP9oedpipLNzl7eAN8HI+3UDTY7S90PNvcdQlkkfgZ/sSXFCz29ZwzHjqkFpcA
         6Rx8K+ZOCaPpYyois+KGu5Q8/0dUgKcNh/2ZvGpK7yqXpCEzRCzuiOPgloKfgBSjMJyv
         CMix4Q1wtx1sOit1nEpWullgj2AKYcxQhorTElMxbmkWI9x3nfIigTq3zS2Cnq2dso3Y
         ZuR+J7gxhEyrww2N6f4ukuyDbEapz1LKDT692mmXFdCIJ586wxU/o9Ax4vmrmeuFKW9h
         4NPg==
X-Forwarded-Encrypted: i=1; AKwUvByhJ6DX5iNUsh/yx86ZYMqYgVi5bQ74m+q7G0OlrOz7AHcdwKyZjW80HGRmnMspTgTPHxQ=@vger.kernel.org
X-Gm-Message-State: AFuF++mZMPIc2ybywy7EeG6aNl+YZcn3jVvefowWKpYM34za7RRF3Z9D
	P/oXv7uqNpUpfIiJVh5QUXmIcvctYiSVvSjZdXiGngltr6ZQHC69qeOo
X-Gm-Gg: AYBFou1iT1X0/9AadnTxcSKtvTpqfna0FX3Z5WgBwSuFkYKJNFRNdHc0XD6aOrM4Mlk
	T2xza23UCyAu4BGXAqEXdIjsBHtCPNCGKBIXHNEsfWpg0nFo/CvJ82yv24xPLgfMtzWAvikO54i
	u1zUM7KUUJ2cWLxOVoIMQBpYKh0OP2h4Gf/Yjr4vZF334v8GCiEO4QIvrcsIjFQepD/iSSCDYlw
	LEx+1rze6JzhTVC1rELL3QUg/9FQFUYKzrOMpJKfT23EJUspY8hOGr2L3plPbfuR2heVoLkf+qQ
	tYsLaYeH+iLHvkRE+u3F59/mX+l8tLXhlt+RdWsa9uVqyd7ZhutVP73mg6J7x7qxl+EdcOyO0N2
	ap0lX706aiymmpK79kqEDm2GJwcyaokALEa3BZgjjrRaiacXSN/rCYl6bJ1gtwLrmEK0h7pWJsO
	/S6AzyQv0RkLP5tX86fssaUVq9wKRGwVOj832D+M08x6SOj3s/XzCm3OIX/11FKtmMzylTyCiQ0
	un/Cf5B2txleDwLXDB72GiXxQrcJaE5Q364o0F5mPOdXcqCKIYXR//WkQr3GMnaqBtRofWixbo8
	l61ThNjdik+ond52cEjgMQ/OX5jVxtAYo04CRHtP2NpmkJ56g9UhSnxt2NTSt9IQxt3kRcWguKf
	d9BbKf5vbenITucBYT5eN
X-Received: by 2002:a05:6830:2992:b0:7fe:e653:9535 with SMTP id 46e09a7af769-81782989d7bmr12777689a34.16.1790546414159;
        Sun, 27 Sep 2026 15:00:14 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-81b3de6f7e1sm4874147a34.22.2026.09.27.15.00.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 15:00:13 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sun, 27 Sep 2026 15:59:46 -0600
Subject: [PATCH net-next v5 11/19] net: stmmac: complete DMA configuration
 allocation unwind
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260927-submit-stmmac-reset-fixes-v1-v5-11-feec6c14dd06@gmail.com>
References: <20260927-submit-stmmac-reset-fixes-v1-v5-0-feec6c14dd06@gmail.com>
In-Reply-To: <20260927-submit-stmmac-reset-fixes-v1-v5-0-feec6c14dd06@gmail.com>
To: Russell King <linux@armlinux.org.uk>, Andrew Lunn <andrew@lunn.ch>, 
 Heiner Kallweit <hkallweit1@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Christian Marangi <ansuelsmth@gmail.com>, 
 Tiezhu Yang <yangtiezhu@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, Serge Semin <fancer.lancer@gmail.com>, 
 Suraj Jaiswal <quic_jsuraj@quicinc.com>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Joao Pinto <Joao.Pinto@synopsys.com>, 
 Vladimir Oltean <vladimir.oltean@nxp.com>, 
 Ong Boon Leong <boon.leong.ong@intel.com>, 
 Voon Weifeng <weifeng.voon@intel.com>, 
 "Song, Yoong Siang" <yoong.siang.song@intel.com>, 
 Linus Walleij <linusw@kernel.org>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Magnus Karlsson <magnus.karlsson@intel.com>, 
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>, 
 Simon Horman <horms@kernel.org>, 
 =?utf-8?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn@kernel.org>, 
 Thierry Reding <thierry.reding@kernel.org>, 
 Jonathan Hunter <jonathanh@nvidia.com>, Chen-Yu Tsai <wens@kernel.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, Jose Abreu <Jose.Abreu@synopsys.com>, 
 Yao Zi <me@ziyao.cc>, Philipp Zabel <p.zabel@pengutronix.de>
Cc: Richard Genoud <richard.genoud@bootlin.com>, 
 Alastair D'Silva <alastair@d-silva.org>, Maxime Ripard <mripard@kernel.org>, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org, 
 ZhaoJinming <zhaojinming@uniontech.com>, 
 Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>, 
 Ding Hui <dinghui1111@163.com>, Linkui Xiao <xiaolinkui@kylinos.cn>, 
 Linkui Xiao <xiaolinkui@126.com>, linux-tegra@vger.kernel.org, 
 linux-sunxi@lists.linux.dev, James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.15.2

Build on Ding Hui's per-queue allocation cleanup. The combined RX/TX
allocator still needs to release the successful RX allocation if TX
allocation fails. Guard coherent frees after the per-queue unwind has
already emptied a queue.

Propagate RXQ memory-model registration errors instead of continuing
with an unusable RXQ. Clear XSK RXQ bindings before the RXQ goes away and
release any saved partial packet. The MTU transaction added later relies
on preparation failures being fully unwound without touching the active
configuration.

Take ownership of saved partial RX state at poll entry by clearing the
saved flag and skb pointer immediately. Preserve incomplete state if the
next descriptor is still DMA-owned. A budget-one completion must not
leave an already delivered or freed skb reachable by the new teardown
cleanup.

Fixes: 71fedb0198cb ("net: stmmac: break some functions into RX and TX scopes")
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 54 ++++++++++++++++-------
 1 file changed, 37 insertions(+), 17 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 258de45d122c..bc19f8c19bb8 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -1931,17 +1931,19 @@ static int __init_dma_rx_desc_rings(struct stmmac_priv *priv,
 	rx_q->xsk_pool = stmmac_get_xsk_pool(priv, queue);
 
 	if (rx_q->xsk_pool) {
-		WARN_ON(xdp_rxq_info_reg_mem_model(&rx_q->xdp_rxq,
-						   MEM_TYPE_XSK_BUFF_POOL,
-						   NULL));
+		ret = xdp_rxq_info_reg_mem_model(&rx_q->xdp_rxq,
+						 MEM_TYPE_XSK_BUFF_POOL, NULL);
+		if (ret)
+			return ret;
 		netdev_info(priv->dev,
 			    "Register MEM_TYPE_XSK_BUFF_POOL RxQ-%d\n",
 			    queue);
 		xsk_pool_set_rxq_info(rx_q->xsk_pool, &rx_q->xdp_rxq);
 	} else {
-		WARN_ON(xdp_rxq_info_reg_mem_model(&rx_q->xdp_rxq,
-						   MEM_TYPE_PAGE_POOL,
-						   rx_q->page_pool));
+		ret = xdp_rxq_info_reg_mem_model(&rx_q->xdp_rxq,
+						 MEM_TYPE_PAGE_POOL, rx_q->page_pool);
+		if (ret)
+			return ret;
 		netdev_info(priv->dev,
 			    "Register MEM_TYPE_PAGE_POOL RxQ-%d\n",
 			    queue);
@@ -2003,6 +2005,8 @@ static int init_dma_rx_desc_rings(struct net_device *dev,
 			dma_free_rx_skbufs(priv, dma_conf, queue);
 
 		rx_q->buf_alloc_num = 0;
+		if (rx_q->xsk_pool)
+			xsk_pool_set_rxq_info(rx_q->xsk_pool, NULL);
 		rx_q->xsk_pool = NULL;
 
 		queue--;
@@ -2188,10 +2192,16 @@ static void __free_dma_rx_desc_resources(struct stmmac_priv *priv,
 	void *addr;
 
 	/* Release the DMA RX socket buffers */
-	if (rx_q->xsk_pool)
+	if (rx_q->xsk_pool) {
 		dma_free_rx_xskbufs(priv, dma_conf, queue);
-	else
+		xsk_pool_set_rxq_info(rx_q->xsk_pool, NULL);
+	} else {
 		dma_free_rx_skbufs(priv, dma_conf, queue);
+	}
+	if (rx_q->state_saved)
+		dev_kfree_skb_any(rx_q->state.skb);
+	rx_q->state.skb = NULL;
+	rx_q->state_saved = 0;
 
 	rx_q->buf_alloc_num = 0;
 	rx_q->xsk_pool = NULL;
@@ -2204,7 +2214,8 @@ static void __free_dma_rx_desc_resources(struct stmmac_priv *priv,
 
 	size = stmmac_get_rx_desc_size(priv) * dma_conf->dma_rx_size;
 
-	dma_free_coherent(priv->device, size, addr, rx_q->dma_rx_phy);
+	if (addr)
+		dma_free_coherent(priv->device, size, addr, rx_q->dma_rx_phy);
 	rx_q->dma_erx = NULL;
 	rx_q->dma_rx = NULL;
 	rx_q->dma_rx_phy = 0;
@@ -2259,7 +2270,8 @@ static void __free_dma_tx_desc_resources(struct stmmac_priv *priv,
 
 	size = stmmac_get_tx_desc_size(priv, tx_q) * dma_conf->dma_tx_size;
 
-	dma_free_coherent(priv->device, size, addr, tx_q->dma_tx_phy);
+	if (addr)
+		dma_free_coherent(priv->device, size, addr, tx_q->dma_tx_phy);
 	tx_q->dma_etx = NULL;
 	tx_q->dma_entx = NULL;
 	tx_q->dma_tx = NULL;
@@ -2500,6 +2512,8 @@ static int alloc_dma_desc_resources(struct stmmac_priv *priv,
 		return ret;
 
 	ret = alloc_dma_tx_desc_resources(priv, dma_conf);
+	if (ret)
+		free_dma_rx_desc_resources(priv, dma_conf);
 
 	return ret;
 }
@@ -5822,6 +5836,7 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
 	struct sk_buff *skb = NULL;
 	struct stmmac_xdp_buff ctx;
 	int xdp_status = 0;
+	bool in_progress = rx_q->state_saved;
 	int bufsz;
 
 	dma_dir = page_pool_get_dma_dir(rx_q->page_pool);
@@ -5836,6 +5851,14 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
 		stmmac_display_ring(priv, rx_head, priv->dma_conf.dma_rx_size, true,
 				    rx_q->dma_rx_phy, desc_size);
 	}
+	if (in_progress) {
+		skb = rx_q->state.skb;
+		error = rx_q->state.error;
+		len = rx_q->state.len;
+		rx_q->state.skb = NULL;
+		rx_q->state_saved = false;
+	}
+
 	while (count < limit) {
 		unsigned int buf1_len = 0, buf2_len = 0;
 		enum pkt_hash_types hash_type;
@@ -5844,12 +5867,7 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
 		int entry;
 		u32 hash;
 
-		if (!count && rx_q->state_saved) {
-			skb = rx_q->state.skb;
-			error = rx_q->state.error;
-			len = rx_q->state.len;
-		} else {
-			rx_q->state_saved = false;
+		if (!in_progress) {
 			skb = NULL;
 			error = 0;
 			len = 0;
@@ -5883,6 +5901,8 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
 
 		prefetch(np);
 
+		in_progress = status & rx_not_ls;
+
 		if (priv->extend_desc)
 			stmmac_rx_extended_status(priv, &priv->xstats, rx_q->dma_erx + entry);
 		if (unlikely(status == discard_frame)) {
@@ -6057,7 +6077,7 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
 		count++;
 	}
 
-	if (status & rx_not_ls || skb) {
+	if (in_progress || skb) {
 		rx_q->state_saved = true;
 		rx_q->state.skb = skb;
 		rx_q->state.error = error;

-- 
2.53.0

