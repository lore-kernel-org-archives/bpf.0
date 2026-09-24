Received: from mail-oa2-f12.google.com (mail-oa2-f12.google.com [74.125.231.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 410654CA79D
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 17:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790271887; cv=none; b=VOz9g1DbClnhYrriXMQzj/J90Y5deC9thVC4ymUWRJt80AXCJxlD0af35wSXI6YQvD0xHSJOhsuFeZ344/zTNmtBpqmcEPwejUWzhhb8VpE2LRQKjKrd9dJ3gRWuFNzS53fG34X8Z8593W4MiM4zW7qkhy/JC9MqV7P+QQ420Fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790271887; c=relaxed/simple;
	bh=mZteaWjFlTrdvZhXpeSLJ2aG6DK5laeYUpxIOr+Hy3o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DNLxZbZy+QqZNfwhA3mjI+MRqNh//kxCmPnCmWUXhG+ZT9GKFFJNCy8XgmNM7bJvmwnQ5/jNcw5p0GK7UYDSyfqsX6eIGluOFUa9qKReLlWYTFjlmGAIqtUJggU+GKY+11NNwsc/Qo+Areye+byJuvgmz5Vfz3qM4yldQ4K1vlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EBdje9So; arc=none smtp.client-ip=74.125.231.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EBdje9So"
Received: by mail-oa2-f12.google.com with SMTP id 586e51a60fabf-466cc9b2f1dso68331fac.0
        for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 10:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790271884; x=1790876684; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VeegLINSUVfOlfX4/9rlXB2NUVxrFUlmYGkBGDGCAS8=;
        b=EBdje9Son6k3N4bSxZLoyABCxp3aamjnHhUBbXiR3J/fSCX1n4GRIsoI2PJVIo2Npr
         /Cl0nABg9VzieViEolLQsfwMX5BuNEdnq1ti8ar3xBxgdaUdZvy50FQb8Qs1ZI2SAUwB
         V93lkGThrS2BUJ+XEwPZaiPGBCtQ8Hjeg4gGDCgX5C7kZM0TFn0P2yPyY5FLAdS10m5n
         TsZpNSI9mFH3iyTML+mLhQ4/PhVF2o5ZlosxZKtN5o/qN79TpmtNnDeimyXviUqQbmNG
         H6BR8Y1fb9x0ReqLmttsVtbIDRTZqWK4nfqm4ul4Ya3YUTWFZBNh1+xcB9jP783EMNNT
         EPjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790271884; x=1790876684;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VeegLINSUVfOlfX4/9rlXB2NUVxrFUlmYGkBGDGCAS8=;
        b=oRVNb71Jbxfkd2a/EPhq1drSUkq/zY+LTXmZQHDqp494GNl+LsFl2jMFHfQpdQYKCd
         oLApSBXCLvsZ5qPogeNCCrH7ny/dk2QFdRXGi80uISBoy6ZH5+DVtg3ziFENgzvl/K2l
         J+lqkgESLYa88siy2sSu8Q59S+JiOGbMW1yNp1I7FXhvtwh3rwzlsu7FizMQGlWLHDen
         oyqr7UC9b5AoAD+SvbM24aMpkiwYPXMegPBEHl7Yysw8b7clpslKgamKHkGvy1lXR+kT
         YNdVQLnUfMPJcZlT5BEsdNK78HqSy72MFBpt69pLiLBYx2Mcj9HImBj85wJ9GAiP+9aU
         S2wA==
X-Forwarded-Encrypted: i=1; AKwUvBxEuqUV4+IMiA+YGWEOXOeq/Q26TTKkOEr2IxO6zsnM6zh8qt1oyKQdnQyxOVHjEA4p3Es=@vger.kernel.org
X-Gm-Message-State: AFuF++lJQZywypM+X9C0iGj0UF4FdBU6TyefpwLr80YbYadbLVIwxggS
	d0t/zQ7bwIvmFhO0iPR/7Mtw6B1oO5JhPcwK2zd9Fh1iuHAISxNCsfFM
X-Gm-Gg: AYBFou2wyXUIJlPkYiN9fhSq6Tl6CtwJu2TwXMU2uQojjUuM6QcdVMJN5O9wUle5ShX
	ZGnsedFrHap1W2YNNLoFxn1aIEvP86iRi+dTJBYIZ8AY2K3CXuuvJdV/nXPQP6Nilh+qgXtZJ5G
	X+HCJ+C4zTExRsPgn2cNO15hOnx7ssRN0yzW5Yjyey/qJJofhXQS9t9HUXReRRGYst54BPvD+//
	ZnpdSUQ8p+a7UqaPwcmsApnYr5c8eyVusafawljVxv6WUrjV/uJQRo/eTyEPQ1tKW5UmZae3KD8
	+022cA/uCL7xU2ukDwMEqt1cB9MQjphawO8xzRLp5Z6FtNHPE/4PmgFEIuuQv+5fv2KhykJx0t1
	w24iihSqKGGcYCx6NeikHsfUCTIfMva9v+3hoXzBm2HmiDuKJ1LLrmAS5sJDybww7RpvD1nOro7
	YUA7tIcw2aVB2GBM6R6IdOkUrvhX85lgXrWQIcSGIGz7fVlQ5EbjZyirYUw29qONqp7M4d+qtBX
	JEksxJl6KwUbV1JuHPaskAkXawdl5aq0vP9cbBMTvewnIBzj9IV6J1U3Rcvuj3KkvRJhfdL6mjB
	rU58b2p2xSEMCgSdTOPYU+Y1KiqUXVwqPpTDVy3w9ii9lnM6p1x3sw/R2Zs7SUhn1sJat+Dfs/B
	7tdGeafqnQU9wxdRlE9F3Xg==
X-Received: by 2002:a05:6871:3325:b0:467:2b0b:d07d with SMTP id 586e51a60fabf-491e9629ecbmr2582163fac.1.1790271884027;
        Thu, 24 Sep 2026 10:44:44 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-491e8f8d14asm3027802fac.0.2026.09.24.10.44.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 10:44:43 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Thu, 24 Sep 2026 11:44:35 -0600
Subject: [PATCH net v3 05/10] net: stmmac: unwind partially allocated DMA
 configurations
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260924-submit-stmmac-reset-fixes-v1-v3-5-c031e3f3a282@gmail.com>
References: <20260924-submit-stmmac-reset-fixes-v1-v3-0-c031e3f3a282@gmail.com>
In-Reply-To: <20260924-submit-stmmac-reset-fixes-v1-v3-0-c031e3f3a282@gmail.com>
To: Russell King <linux@armlinux.org.uk>, Andrew Lunn <andrew@lunn.ch>, 
 Heiner Kallweit <hkallweit1@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Joakim Zhang <qiangqing.zhang@nxp.com>, 
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
 "Song, Yoong Siang" <yoong.siang.song@intel.com>
Cc: Richard Genoud <richard.genoud@bootlin.com>, 
 Alastair D'Silva <alastair@d-silva.org>, Maxime Ripard <mripard@kernel.org>, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org, 
 ZhaoJinming <zhaojinming@uniontech.com>, 
 Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>, 
 Ding Hui <dinghui1111@163.com>, James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.15.2

RX and TX allocation failure paths release all configured queues, even
when the failing queue has not allocated its buffer array or descriptors.
Only walk buffer arrays and free coherent memory when those allocations
exist. If TX allocation fails after RX allocation succeeds, release the
RX resources too.

Propagate RXQ memory-model registration errors instead of continuing
with an unusable RXQ. Clear XSK RXQ bindings before the RXQ goes away,
release any saved partial packet, and clear released resource pointers.
This also leaves configurations which are reused after close or XDP
reconfiguration with a consistent empty state.

The MTU transaction added later relies on preparation failures being
fully unwound without touching the currently active configuration.

Fixes: 71fedb0198cb ("net: stmmac: break some functions into RX and TX scopes")
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 49 ++++++++++++++++++-----
 1 file changed, 39 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index f7e91ae21448..3b918cf89806 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -1761,6 +1761,9 @@ static void dma_free_rx_skbufs(struct stmmac_priv *priv,
 	struct stmmac_rx_queue *rx_q = &dma_conf->rx_queue[queue];
 	int i;
 
+	if (!rx_q->buf_pool)
+		return;
+
 	for (i = 0; i < dma_conf->dma_rx_size; i++)
 		stmmac_free_rx_buffer(priv, rx_q, i);
 }
@@ -1884,17 +1887,19 @@ static int __init_dma_rx_desc_rings(struct stmmac_priv *priv,
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
@@ -1956,6 +1961,8 @@ static int init_dma_rx_desc_rings(struct net_device *dev,
 			dma_free_rx_skbufs(priv, dma_conf, queue);
 
 		rx_q->buf_alloc_num = 0;
+		if (rx_q->xsk_pool)
+			xsk_pool_set_rxq_info(rx_q->xsk_pool, NULL);
 		rx_q->xsk_pool = NULL;
 
 		queue--;
@@ -2099,6 +2106,9 @@ static void dma_free_tx_skbufs(struct stmmac_priv *priv,
 
 	tx_q->xsk_frames_done = 0;
 
+	if (!tx_q->tx_skbuff_dma || !tx_q->tx_skbuff)
+		return;
+
 	for (i = 0; i < dma_conf->dma_tx_size; i++)
 		stmmac_free_tx_buffer(priv, dma_conf, queue, i);
 
@@ -2137,10 +2147,16 @@ static void __free_dma_rx_desc_resources(struct stmmac_priv *priv,
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
@@ -2153,7 +2169,8 @@ static void __free_dma_rx_desc_resources(struct stmmac_priv *priv,
 
 	size = stmmac_get_rx_desc_size(priv) * dma_conf->dma_rx_size;
 
-	dma_free_coherent(priv->device, size, addr, rx_q->dma_rx_phy);
+	if (addr)
+		dma_free_coherent(priv->device, size, addr, rx_q->dma_rx_phy);
 
 	if (xdp_rxq_info_is_reg(&rx_q->xdp_rxq))
 		xdp_rxq_info_unreg(&rx_q->xdp_rxq);
@@ -2161,6 +2178,10 @@ static void __free_dma_rx_desc_resources(struct stmmac_priv *priv,
 	kfree(rx_q->buf_pool);
 	if (rx_q->page_pool)
 		page_pool_destroy(rx_q->page_pool);
+	rx_q->buf_pool = NULL;
+	rx_q->page_pool = NULL;
+	rx_q->dma_erx = NULL;
+	rx_q->dma_rx = NULL;
 }
 
 static void free_dma_rx_desc_resources(struct stmmac_priv *priv,
@@ -2201,10 +2222,16 @@ static void __free_dma_tx_desc_resources(struct stmmac_priv *priv,
 
 	size = stmmac_get_tx_desc_size(priv, tx_q) * dma_conf->dma_tx_size;
 
-	dma_free_coherent(priv->device, size, addr, tx_q->dma_tx_phy);
+	if (addr)
+		dma_free_coherent(priv->device, size, addr, tx_q->dma_tx_phy);
 
 	kfree(tx_q->tx_skbuff_dma);
 	kfree(tx_q->tx_skbuff);
+	tx_q->tx_skbuff_dma = NULL;
+	tx_q->tx_skbuff = NULL;
+	tx_q->dma_etx = NULL;
+	tx_q->dma_entx = NULL;
+	tx_q->dma_tx = NULL;
 }
 
 static void free_dma_tx_desc_resources(struct stmmac_priv *priv,
@@ -2411,6 +2438,8 @@ static int alloc_dma_desc_resources(struct stmmac_priv *priv,
 		return ret;
 
 	ret = alloc_dma_tx_desc_resources(priv, dma_conf);
+	if (ret)
+		free_dma_rx_desc_resources(priv, dma_conf);
 
 	return ret;
 }

-- 
2.53.0

