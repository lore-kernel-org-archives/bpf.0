Received: from mail-oa2-f12.google.com (mail-oa2-f12.google.com [74.125.231.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82D3A4E2F0B
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 17:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790271893; cv=none; b=rTGjT4BI0Aut4dswj7DAAknMLVzmUMRCty/2UOzrozotpYElpvdnfc8c+qWYUjHcF4dtcH84cldCPb6A5bj1NAYQTZvd9qX2Rf69GPFiaA3/5JcrPW1IqUXfTwjq8gc0Ysd0r2KGJ+bB+7qw+6j7Jkw5mSQW9D4+4+bjqDoX6/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790271893; c=relaxed/simple;
	bh=oSKv4z50xpgiudG7X7lH49P4ApuJBJy/7sOi24m92pY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Z/97CwdRT7EWvZ5gzhY/CIJ0nVWRe5W9dCS/mlWrf4+iRbrZKFWsenzHsGAVMbh6VSF67shBqhk6NY2jseN+RZMvY7A8CY5GNVu7yN43ay+OgTCpdZ0wneHziPmiey+g6E9rECj/WS3GwTqr5BLFL9v/sFPXFhCxMP78B4lguNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UuVfWVgD; arc=none smtp.client-ip=74.125.231.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UuVfWVgD"
Received: by mail-oa2-f12.google.com with SMTP id 586e51a60fabf-46accbdfb21so176120fac.1
        for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 10:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790271889; x=1790876689; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=f1PwaHwj9rfBVEy3YdGHV1C8wVDTJmsR2WRPtw2545g=;
        b=UuVfWVgD7sksFyV1j8Xn/VBzvMbg/wbKpWBFoiQ72bUA52+8+h/+ST1ahiAaChzIfy
         I6tTPg4A5Lg6+awrLyPjVDyIOvCF4CSjM+1skZXmNhB9YLiaAZjxllE92LNlLa51pEKz
         IEkQh3+fE3eT0Bf2f/wnxK4/yyzV5PznvdUWbRFtAJnIpR0uYeH1w1kg/0x8Ck1jDeu6
         C3mv4GQVQ8iIDkkjzg/V1SfP4RZyBWWtkkueuOaRFTV5vAfohCM5vhpCwSZduN7E9Weh
         U3tGKc0alyo76KZJU4OxLuLtTATdDqzKVoD5NkB+mbEZd/2O95aoxAYmNCop7Rvyd7Bk
         th7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790271889; x=1790876689;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=f1PwaHwj9rfBVEy3YdGHV1C8wVDTJmsR2WRPtw2545g=;
        b=r+Pd0t0Cqnl7zUKewDL0HvMZhFzUkYT65Uab9p+gq1FOcGTNcl2+IGJNwxX63DFxOP
         /QMMPn/p3Qbi+R1mrUyd1v5qFaJFurfMV3qobUnqplPvbeovsofZ3hF5wltJgvU3U0WA
         wASb2KxKmqnKg6CcVNcqzli1fVTmvs6er9ggv2jxradNXpeYXFKijosDJeT09tPTh4Zv
         D0eqPDjUi9OFa5e1A9FyVZ4gsre5LE1IgPoX2W0i3CWALKpCscsdXqo5iyW2o8/pg+iO
         Gr4mIhqJpykpLYv7wvBUI6k529l3lEEUGwQhZV0XGmFtjoJcGnjT8Y5NJOEl+Oz7uqhx
         hohw==
X-Forwarded-Encrypted: i=1; AKwUvBz5k58AmZMSrWyqAxmoXTVpsuuyBx4MD7MrAzJiLvZ4G8IOyXKCLWjasB/ka0zWyY23m6I=@vger.kernel.org
X-Gm-Message-State: AFuF++lU/8U9GQ4zsRRUV7Xy74Ha13XHppnC0jqLlZg1A+aEe9NnyAwV
	57oek6HuGIfiEiraZ+ogzqzT3Tvhy75I3GfYPPwKtVJ8cFbpqjq4WU5g
X-Gm-Gg: AYBFou3hbL7jIDgQ/RdHJBAv+t7YZ/EKWxKYu/MG+8XvX086YLnp7mK5la1F/EhDkFN
	Z6ROoHSOSJKdKityvavcl6CKey8PJgVzNkOlj3k7hkyij+94Z9hZc6NkssRVhscP3z9UUtoZjGO
	CohOp0OtOOSF4Em79wECU5c9f2RO2x0lffoNOztjo1kZHEeIVkPgNdHUUotXs983A65Ft2cMm9u
	N2vyz0WNSxzQwSKpQnNHQG7hV4eHoPKa1cGZ+TJzoJuoeM3SBnq38m/tXbptiirtgh7iOFj7iT/
	FP55tZQ9cPJdyP3okvLcmmJCUbbLXiu4cUnL5DKblJYvEdXjY70y198Fk2eUojhkymYfGrhTHku
	yS6V22l/xXFYM9LcE2eEkHO9P7IOyKdiPC+sgWzG7CB8vT+p0umTC92q2TlerWCpPOPbIhtqrAy
	6hzLzt6cnVEZadABfMEWD0/rvvH/FcDx/zuPOcg22kXZSf/ylEd9s3sQZdryuEYncOPAqeaBLdX
	iYTPacp1evor0DPrNyoQE9bDXIbtK9kD3C2rCk+GX9LjVn0Wh3dihrE+sKVuozJKnT5AHLkWe9g
	N+XQNZzLDm6Xw0TR9rldEiAWIDElqKHCcdv3e3fL2JA2EmesXy6llP4AL5LrUSRo4iSD8Ayca9+
	5q5rfz9EVXL+ZPVEZA5oWaA==
X-Received: by 2002:a05:6870:46a4:b0:485:d1ab:7936 with SMTP id 586e51a60fabf-491e517f415mr3158477fac.23.1790271889262;
        Thu, 24 Sep 2026 10:44:49 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-491e8f8d14asm3027802fac.0.2026.09.24.10.44.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 10:44:48 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Thu, 24 Sep 2026 11:44:38 -0600
Subject: [PATCH net v3 08/10] net: stmmac: use the tracked datapath restart
 for XSK pool changes
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260924-submit-stmmac-reset-fixes-v1-v3-8-c031e3f3a282@gmail.com>
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

Live XSK pool changes free and replace individual RX/TX queues through
void helpers. An allocation failure is only logged and the caller enables
NAPI over missing rings. The TX queue and its timer also remain available
while their storage is being freed.

Use the XDP datapath release/open pair instead. Quiesce all NAPI contexts,
transmitters, IRQ handlers and timers while the old program and pool bitmap
still describe the active layout. Only then change the bitmap and rebuild
the queues. This pauses all queues during a pool change, but avoids a
partially running datapath and shares its failure and ownership handling
with program changes instead of maintaining a second queue-level lifetime.

Undo the new pool's bitmap bit and DMA mapping if reopening for attachment
fails. For removal, free every reference to the pool before unmapping it
and return success even if rebuilding the ordinary queues fails: socket
teardown must not leave the departing pool reachable. In both cases failed
reopening leaves the interface detached for down/up recovery.

Remove the unused per-queue allocation/enable helpers. Preserve their TBS
programming when using the full XDP reopen path, and clear the released TX
pool pointer alongside its RX counterpart.

Fixes: bba2556efad6 ("net: stmmac: Enable RX via AF_XDP zero-copy")
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac.h      |   4 -
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 105 +---------------------
 drivers/net/ethernet/stmicro/stmmac/stmmac_xdp.c  |  44 +++++----
 3 files changed, 24 insertions(+), 129 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac.h b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
index ab5157fccc46..f07623a1285c 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac.h
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
@@ -437,10 +437,6 @@ static inline bool stmmac_xdp_is_enabled(struct stmmac_priv *priv)
 	return !!priv->xdp_prog;
 }
 
-void stmmac_disable_rx_queue(struct stmmac_priv *priv, u32 queue);
-void stmmac_enable_rx_queue(struct stmmac_priv *priv, u32 queue);
-void stmmac_disable_tx_queue(struct stmmac_priv *priv, u32 queue);
-void stmmac_enable_tx_queue(struct stmmac_priv *priv, u32 queue);
 int stmmac_xsk_wakeup(struct net_device *dev, u32 queue, u32 flags);
 struct timespec64 stmmac_calc_tas_basetime(ktime_t old_base_time,
 					   ktime_t current_time,
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 467f471874cf..d56b7f911db0 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -2232,6 +2232,7 @@ static void __free_dma_tx_desc_resources(struct stmmac_priv *priv,
 	tx_q->dma_etx = NULL;
 	tx_q->dma_entx = NULL;
 	tx_q->dma_tx = NULL;
+	tx_q->xsk_pool = NULL;
 }
 
 static void free_dma_tx_desc_resources(struct stmmac_priv *priv,
@@ -7148,107 +7149,6 @@ static int stmmac_xdp_xmit(struct net_device *dev, int num_frames,
 	return nxmit;
 }
 
-void stmmac_disable_rx_queue(struct stmmac_priv *priv, u32 queue)
-{
-	struct stmmac_channel *ch = &priv->channel[queue];
-	unsigned long flags;
-
-	spin_lock_irqsave(&ch->lock, flags);
-	stmmac_disable_dma_irq(priv, priv->ioaddr, queue, 1, 0);
-	spin_unlock_irqrestore(&ch->lock, flags);
-
-	stmmac_stop_rx_dma(priv, queue);
-	__free_dma_rx_desc_resources(priv, priv->dma_conf, queue);
-}
-
-void stmmac_enable_rx_queue(struct stmmac_priv *priv, u32 queue)
-{
-	struct stmmac_rx_queue *rx_q = &priv->dma_conf->rx_queue[queue];
-	struct stmmac_channel *ch = &priv->channel[queue];
-	unsigned long flags;
-	int ret;
-
-	ret = __alloc_dma_rx_desc_resources(priv, priv->dma_conf, queue);
-	if (ret) {
-		netdev_err(priv->dev, "Failed to alloc RX desc.\n");
-		return;
-	}
-
-	ret = __init_dma_rx_desc_rings(priv, priv->dma_conf, queue, GFP_KERNEL);
-	if (ret) {
-		__free_dma_rx_desc_resources(priv, priv->dma_conf, queue);
-		netdev_err(priv->dev, "Failed to init RX desc.\n");
-		return;
-	}
-
-	stmmac_reset_rx_queue(priv, queue);
-	stmmac_clear_rx_descriptors(priv, priv->dma_conf, queue);
-
-	stmmac_init_rx_chan(priv, priv->ioaddr, priv->plat->dma_cfg,
-			    rx_q->dma_rx_phy, queue);
-
-	stmmac_set_queue_rx_tail_ptr(priv, rx_q, queue, rx_q->buf_alloc_num);
-
-	stmmac_set_queue_rx_buf_size(priv, rx_q, queue);
-
-	stmmac_start_rx_dma(priv, queue);
-
-	spin_lock_irqsave(&ch->lock, flags);
-	stmmac_enable_dma_irq(priv, priv->ioaddr, queue, 1, 0);
-	spin_unlock_irqrestore(&ch->lock, flags);
-}
-
-void stmmac_disable_tx_queue(struct stmmac_priv *priv, u32 queue)
-{
-	struct stmmac_channel *ch = &priv->channel[queue];
-	unsigned long flags;
-
-	spin_lock_irqsave(&ch->lock, flags);
-	stmmac_disable_dma_irq(priv, priv->ioaddr, queue, 0, 1);
-	spin_unlock_irqrestore(&ch->lock, flags);
-
-	stmmac_stop_tx_dma(priv, queue);
-	__free_dma_tx_desc_resources(priv, priv->dma_conf, queue);
-}
-
-void stmmac_enable_tx_queue(struct stmmac_priv *priv, u32 queue)
-{
-	struct stmmac_tx_queue *tx_q = &priv->dma_conf->tx_queue[queue];
-	struct stmmac_channel *ch = &priv->channel[queue];
-	unsigned long flags;
-	int ret;
-
-	ret = __alloc_dma_tx_desc_resources(priv, priv->dma_conf, queue);
-	if (ret) {
-		netdev_err(priv->dev, "Failed to alloc TX desc.\n");
-		return;
-	}
-
-	ret = __init_dma_tx_desc_rings(priv,  priv->dma_conf, queue);
-	if (ret) {
-		__free_dma_tx_desc_resources(priv, priv->dma_conf, queue);
-		netdev_err(priv->dev, "Failed to init TX desc.\n");
-		return;
-	}
-
-	stmmac_reset_tx_queue(priv, queue);
-	stmmac_clear_tx_descriptors(priv, priv->dma_conf, queue);
-
-	stmmac_init_tx_chan(priv, priv->ioaddr, priv->plat->dma_cfg,
-			    tx_q->dma_tx_phy, queue);
-
-	if (tx_q->tbs & STMMAC_TBS_AVAIL)
-		stmmac_enable_tbs(priv, priv->ioaddr, 1, queue);
-
-	stmmac_set_queue_tx_tail_ptr(priv, tx_q, queue, 0);
-
-	stmmac_start_tx_dma(priv, queue);
-
-	spin_lock_irqsave(&ch->lock, flags);
-	stmmac_enable_dma_irq(priv, priv->ioaddr, queue, 0, 1);
-	spin_unlock_irqrestore(&ch->lock, flags);
-}
-
 void stmmac_xdp_release(struct net_device *dev)
 {
 	struct stmmac_priv *priv = netdev_priv(dev);
@@ -7345,6 +7245,9 @@ int stmmac_xdp_open(struct net_device *dev)
 
 		stmmac_set_queue_tx_tail_ptr(priv, tx_q, chan, 0);
 
+		if (tx_q->tbs & STMMAC_TBS_AVAIL)
+			stmmac_enable_tbs(priv, priv->ioaddr, 1, chan);
+
 		hrtimer_setup(&tx_q->txtimer, stmmac_tx_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
 	}
 
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_xdp.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_xdp.c
index 7ecb7addd2ea..907ac49a1b76 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_xdp.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_xdp.c
@@ -9,7 +9,6 @@
 static int stmmac_xdp_enable_pool(struct stmmac_priv *priv,
 				  struct xsk_buff_pool *pool, u16 queue)
 {
-	struct stmmac_channel *ch = &priv->channel[queue];
 	bool need_update;
 	u32 frame_size;
 	int err;
@@ -34,23 +33,23 @@ static int stmmac_xdp_enable_pool(struct stmmac_priv *priv,
 	need_update = priv->datapath == STMMAC_DATAPATH_RUNNING &&
 		      stmmac_xdp_is_enabled(priv);
 
-	if (need_update) {
-		napi_disable(&ch->rx_napi);
-		napi_disable(&ch->tx_napi);
-		stmmac_disable_rx_queue(priv, queue);
-		stmmac_disable_tx_queue(priv, queue);
-	}
+	if (need_update)
+		stmmac_xdp_release(priv->dev);
 
 	set_bit(queue, priv->af_xdp_zc_qps);
 
 	if (need_update) {
-		stmmac_enable_rx_queue(priv, queue);
-		stmmac_enable_tx_queue(priv, queue);
-		napi_enable(&ch->rxtx_napi);
-
-		err = stmmac_xsk_wakeup(priv->dev, queue, XDP_WAKEUP_RX);
-		if (err)
+		err = stmmac_xdp_open(priv->dev);
+		if (err) {
+			clear_bit(queue, priv->af_xdp_zc_qps);
+			xsk_pool_dma_unmap(pool, STMMAC_RX_DMA_ATTR);
+			netdev_err(priv->dev, "failed reopening after XSK pool attach: %pe; interface remains detached\n",
+				   ERR_PTR(err));
 			return err;
+		}
+
+		/* The pool is installed even if link resolution is still pending. */
+		napi_schedule(&priv->channel[queue].rxtx_napi);
 	}
 
 	return 0;
@@ -58,9 +57,9 @@ static int stmmac_xdp_enable_pool(struct stmmac_priv *priv,
 
 static int stmmac_xdp_disable_pool(struct stmmac_priv *priv, u16 queue)
 {
-	struct stmmac_channel *ch = &priv->channel[queue];
 	struct xsk_buff_pool *pool;
 	bool need_update;
+	int err;
 
 	if (queue >= priv->plat->rx_queues_to_use ||
 	    queue >= priv->plat->tx_queues_to_use)
@@ -73,24 +72,21 @@ static int stmmac_xdp_disable_pool(struct stmmac_priv *priv, u16 queue)
 	need_update = priv->datapath == STMMAC_DATAPATH_RUNNING &&
 		      stmmac_xdp_is_enabled(priv);
 
-	if (need_update) {
-		napi_disable(&ch->rxtx_napi);
-		stmmac_disable_rx_queue(priv, queue);
-		stmmac_disable_tx_queue(priv, queue);
-		synchronize_rcu();
-	}
+	if (need_update)
+		stmmac_xdp_release(priv->dev);
 
 	xsk_pool_dma_unmap(pool, STMMAC_RX_DMA_ATTR);
 
 	clear_bit(queue, priv->af_xdp_zc_qps);
 
 	if (need_update) {
-		stmmac_enable_rx_queue(priv, queue);
-		stmmac_enable_tx_queue(priv, queue);
-		napi_enable(&ch->rx_napi);
-		napi_enable(&ch->tx_napi);
+		err = stmmac_xdp_open(priv->dev);
+		if (err)
+			netdev_err(priv->dev, "failed reopening after XSK pool removal: %pe; interface remains detached\n",
+				   ERR_PTR(err));
 	}
 
+	/* Socket teardown must be able to unmap and free the removed pool. */
 	return 0;
 }
 

-- 
2.53.0

