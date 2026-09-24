Received: from mail-oa2-f12.google.com (mail-oa2-f12.google.com [74.125.231.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 736F14CDA2A
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 17:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790271892; cv=none; b=GvXtrppPoKoo8L5DK/ZqIf1LmiD6S7Iw09x18ChrkaSPFwLD8orJuHGHkM9qmGtpe9JKoE0njdRo2GVA+xYN6vWsuf1t6eVA+0H/DoKW/knzTZuCYydrOTBpJCohtcra50oavsjuPu3cefbplZeciXVdbKj40ekvUMNbCXQMBDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790271892; c=relaxed/simple;
	bh=+uJA8K99nhUsZccE6waCxD+29v0Sux0NtFKA9JWXbF8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Vf3/y4EbG+2olWhs9mec0Smis/sfyVZN+mfBHOr7cJiAJ9lE+vWrubrBxni0K1BtZ4D5AH6/e2hQJ7VwTSO8aYmXy3y/xa9XOZ1f8+9PLDGJxx+9Jo6+paVc5k5SXKHKn+KpSxp4XosIX2hK8GgOtz6+GYmGXpFsPFcRMA5s69o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LvErCLMn; arc=none smtp.client-ip=74.125.231.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LvErCLMn"
Received: by mail-oa2-f12.google.com with SMTP id 586e51a60fabf-466ccbd4773so79543fac.2
        for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 10:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790271886; x=1790876686; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=M68w6voEJqSndFT85lXiA/rCj1JRKLr+RlFPQfO14Dg=;
        b=LvErCLMnSl6I2PfSMTJK0UdXn5eJMf5+BuuoEl5y6z9D+TW6cXyJj646IkmFSU8+CX
         XZKlTOqIRvh4xAtTqnUmEwuH8TWgVjGjpTjwB84CQm93vaK5gnuWEsrDrHkxJsqSSWyW
         mwBRHCrVEQHGgTJvgxZIm7ILLViZ8uAMONrQNPKRMcEVqdHl67kJ2LK2JpxrIyUz7D+7
         7yHOS9Ds7Wutm3DLJgkgu/hFJHgDytlWWRfWgVOwBx2X55Wvqn0olCffAD/QG6Lp27a/
         vp06Yb1e+qeEV/h1AvzjaiGR+qfM/Yw5iVCRIFbBIuN3j7/fCdKEB0NKajLJKsGU/Xn6
         CgOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790271886; x=1790876686;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=M68w6voEJqSndFT85lXiA/rCj1JRKLr+RlFPQfO14Dg=;
        b=JoIsmUHuIgXnJpFbXcocTWNO3nNVlr4CfbkraEEn3/HjpYUx9gCkM0m21CQy9mAfy2
         jVoA07bd3dCpZ0riAnVXq+vaB2+xsaXVStVkWyOqHSk1w9BFOto4Z0cbXTa1eMsfXty0
         4l2vIlW/Sd+GmSEIkmX/pD0sjSdz+jZadiTCgx3c/GN3Hc+3lkOauyBZAkExG0pGIbRT
         mg8U3IMe4sYgjvUQfJRrCkF73sDdB2PrXShNEwYGAuuU3mBLXBXZERvQy8QFT8qOiX2u
         qBKUzCdCkXOiws9l8YYuDwFOAqsEEZgxh+ov7rnl3E0t1LiQzvTTI87jkRg+rQfcKAps
         pJGg==
X-Forwarded-Encrypted: i=1; AKwUvBzP2qAVKggMJf49RCeHbyLQOIs+RVyoNUc7u2uC/icmNJnJMWuFK+t7Q8Itdb6DkLaVMYY=@vger.kernel.org
X-Gm-Message-State: AFuF++mkA8sP4Y7CSJrBGKZS0+/5NKoRZCi2uYtqFo48lcwJ8+xs69F2
	s9vHnZUzn/GTXzCiHV/mcOk+pUOI2zgPdlcO6fqs+Cwe0xNV5DMgLQU9
X-Gm-Gg: AYBFou3VDFq0gSNCVDYK8JL+AXQKiYld9N97oW/HBVr5igEOtwO+KgV2byWizUtXvdc
	Au38yaAuFDWhtEj6GKrbJOv9V1jNjy1FLUPOCTD8U97It6L5jc+odOH8SFTmDfab9bhz48LaHH4
	VQcNFct6HvJVc7mLclwsOcXDuv74Qmiyp0CrK1941zTO7SJNNaiRppRpVZWaYC0QdCpEmY1tQc4
	NOyNYSKvR2ApjaD1Fcw32AEiy9j1ClMCa9pjDIBnZwWUHs+EQ3PShvIZkMGIOXLDAZpzXMUKWJ+
	UjHfYq59R3urM0GpAN6u/hLvNiZAMCcTEpbKPC1V3eM9FiA82cp9N0gyf5O70CR/81HbduzPjW7
	/W4aPud5ghsWVDItCsufnjQQ/gPKCHbrI9EjuJ5nZWvtAz6SgjSzvWj5/Aq8i2azZ0AsikPMYJo
	1Qj4qFRhj++SvbRpWbuWlsRUSC5IvpLgNzE8uELwHDNXWrimw0zjmc+JquN2J1yClDwZS+9Quu1
	b1wBRh0WFsjoue2WbvNM4OsGDPLTx7ZJrU/KRaZEV/wCOOdLZzYKjChUNa+KW5mVyCJs6Rm91z9
	4MZpCy0VmpImsWOBT1ZbnPtn67bLIHaJ52ykZ+QFHKwWnhkZzbTKBwke4CMv9JUSkTtd8lQUYXG
	v+BzDQunVYQQ0ns1iTOaNfNfwzW/xPmyO
X-Received: by 2002:a05:6871:cc:b0:45e:54a3:b8ca with SMTP id 586e51a60fabf-491e9b762camr3199921fac.19.1790271885874;
        Thu, 24 Sep 2026 10:44:45 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-491e8f8d14asm3027802fac.0.2026.09.24.10.44.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 10:44:45 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Thu, 24 Sep 2026 11:44:36 -0600
Subject: [PATCH net v3 06/10] net: stmmac: keep DMA configurations at
 stable addresses
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260924-submit-stmmac-reset-fixes-v1-v3-6-c031e3f3a282@gmail.com>
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

The allocated DMA configuration contains RXQ metadata registered with
XDP and referenced by AF_XDP pools. Copying the configuration into priv
and freeing its original allocation leaves those references pointing at
the old storage. Retain the allocated object instead and keep a pointer
in priv, preserving ring sizes and per-queue settings while down.

Use persistent channel objects for per-queue IRQ contexts instead of
deriving priv from an embedded DMA configuration. XSK wakeup must also
avoid accessing replaceable queue objects. Drain transmitters and NAPI
poll tails before cancelling TX timers so a late rearm cannot outlive
the configuration containing the timer.

Update both open callers with the ownership change. Successful open
keeps the new configuration and frees the empty old object. Failed open
restores the old pointer before freeing the failed replacement. Detach
around the existing MTU reopen so XDP transmit cannot enter while that
pointer is being replaced, and reattach after success. The later MTU
transaction replaces this reopen path with retained-resource rollback.

The empty configuration remains allocated while down because ethtool,
TC and the next open still use its ring sizes and per-queue settings.
The probe-managed action frees the current object after netdev teardown.

Fixes: ba39b344e924 ("net: ethernet: stmicro: stmmac: generate stmmac dma conf before open")
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/net/ethernet/stmicro/stmmac/chain_mode.c   |   6 +-
 drivers/net/ethernet/stmicro/stmmac/ring_mode.c    |   4 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac.h       |   2 +-
 .../net/ethernet/stmicro/stmmac/stmmac_ethtool.c   |   4 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  | 268 +++++++++++----------
 .../net/ethernet/stmicro/stmmac/stmmac_selftests.c |   8 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c    |   6 +-
 7 files changed, 155 insertions(+), 143 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/chain_mode.c b/drivers/net/ethernet/stmicro/stmmac/chain_mode.c
index 66025e2509e9..65243c5e539e 100644
--- a/drivers/net/ethernet/stmicro/stmmac/chain_mode.c
+++ b/drivers/net/ethernet/stmicro/stmmac/chain_mode.c
@@ -48,7 +48,7 @@ static int jumbo_frm(struct stmmac_tx_queue *tx_q, struct sk_buff *skb,
 
 	while (len != 0) {
 		tx_q->tx_skbuff[entry] = NULL;
-		entry = STMMAC_NEXT_ENTRY(entry, priv->dma_conf.dma_tx_size);
+		entry = STMMAC_NEXT_ENTRY(entry, priv->dma_conf->dma_tx_size);
 		desc = tx_q->dma_tx + entry;
 
 		if (len > bmax) {
@@ -137,7 +137,7 @@ static void refill_desc3(struct stmmac_rx_queue *rx_q, struct dma_desc *p)
 		 */
 		p->des3 = cpu_to_le32((unsigned int)(rx_q->dma_rx_phy +
 				      (((rx_q->dirty_rx) + 1) %
-				       priv->dma_conf.dma_rx_size) *
+				       priv->dma_conf->dma_rx_size) *
 				      sizeof(struct dma_desc)));
 }
 
@@ -154,7 +154,7 @@ static void clean_desc3(struct stmmac_tx_queue *tx_q, struct dma_desc *p)
 		 */
 		p->des3 = cpu_to_le32((unsigned int)((tx_q->dma_tx_phy +
 				      ((tx_q->dirty_tx + 1) %
-				       priv->dma_conf.dma_tx_size))
+				       priv->dma_conf->dma_tx_size))
 				      * sizeof(struct dma_desc)));
 }
 
diff --git a/drivers/net/ethernet/stmicro/stmmac/ring_mode.c b/drivers/net/ethernet/stmicro/stmmac/ring_mode.c
index d2f0c321661d..0299d6a6c32b 100644
--- a/drivers/net/ethernet/stmicro/stmmac/ring_mode.c
+++ b/drivers/net/ethernet/stmicro/stmmac/ring_mode.c
@@ -52,7 +52,7 @@ static int jumbo_frm(struct stmmac_tx_queue *tx_q, struct sk_buff *skb,
 		stmmac_prepare_tx_desc(priv, desc, 1, bmax, csum,
 				STMMAC_RING_MODE, 0, false, skb->len);
 		tx_q->tx_skbuff[entry] = NULL;
-		entry = STMMAC_NEXT_ENTRY(entry, priv->dma_conf.dma_tx_size);
+		entry = STMMAC_NEXT_ENTRY(entry, priv->dma_conf->dma_tx_size);
 
 		if (priv->extend_desc)
 			desc = (struct dma_desc *)(tx_q->dma_etx + entry);
@@ -102,7 +102,7 @@ static void refill_desc3(struct stmmac_rx_queue *rx_q, struct dma_desc *p)
 	struct stmmac_priv *priv = rx_q->priv_data;
 
 	/* Fill DES3 in case of RING mode */
-	if (priv->dma_conf.dma_buf_sz == BUF_SIZE_16KiB)
+	if (priv->dma_conf->dma_buf_sz == BUF_SIZE_16KiB)
 		p->des3 = cpu_to_le32(le32_to_cpu(p->des2) + BUF_SIZE_8KiB);
 }
 
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac.h b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
index b35b554e4ab7..ab5157fccc46 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac.h
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
@@ -289,7 +289,7 @@ struct stmmac_priv {
 	int (*hwif_quirks)(struct stmmac_priv *priv);
 	struct mutex lock;
 
-	struct stmmac_dma_conf dma_conf;
+	struct stmmac_dma_conf *dma_conf;
 	/* IRQ/DMA ownership and NAPI state, serialized by RTNL. */
 	enum stmmac_datapath_state datapath;
 	/* Core sleep sequence completed, independently of datapath ownership. */
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
index 1be5310ca766..994350fcdbfa 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
@@ -396,8 +396,8 @@ static void stmmac_get_ringparam(struct net_device *netdev,
 
 	ring->rx_max_pending = DMA_MAX_RX_SIZE;
 	ring->tx_max_pending = DMA_MAX_TX_SIZE;
-	ring->rx_pending = priv->dma_conf.dma_rx_size;
-	ring->tx_pending = priv->dma_conf.dma_tx_size;
+	ring->rx_pending = priv->dma_conf->dma_rx_size;
+	ring->tx_pending = priv->dma_conf->dma_tx_size;
 }
 
 static int stmmac_set_ringparam(struct net_device *netdev,
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 3b918cf89806..ce598b575763 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -79,7 +79,7 @@ static int phyaddr = -1;
 module_param(phyaddr, int, 0444);
 MODULE_PARM_DESC(phyaddr, "Physical device address");
 
-#define STMMAC_TX_THRESH(x)	((x)->dma_conf.dma_tx_size / 4)
+#define STMMAC_TX_THRESH(x)	((x)->dma_conf->dma_tx_size / 4)
 
 /* Limit to make sure XDP TX and slow path can coexist */
 #define STMMAC_XSK_TX_BUDGET_MAX	256
@@ -297,7 +297,7 @@ static void stmmac_disable_all_queues(struct stmmac_priv *priv)
 
 	/* synchronize_rcu() needed for pending XDP buffers to drain */
 	for (queue = 0; queue < rx_queues_cnt; queue++) {
-		rx_q = &priv->dma_conf.rx_queue[queue];
+		rx_q = &priv->dma_conf->rx_queue[queue];
 		if (rx_q->xsk_pool) {
 			synchronize_rcu();
 			break;
@@ -356,10 +356,10 @@ static void print_pkt(unsigned char *buf, int len)
 
 static inline u32 stmmac_tx_avail(struct stmmac_priv *priv, u32 queue)
 {
-	struct stmmac_tx_queue *tx_q = &priv->dma_conf.tx_queue[queue];
+	struct stmmac_tx_queue *tx_q = &priv->dma_conf->tx_queue[queue];
 
 	return CIRC_SPACE(tx_q->cur_tx, tx_q->dirty_tx,
-			  priv->dma_conf.dma_tx_size);
+			  priv->dma_conf->dma_tx_size);
 }
 
 static size_t stmmac_get_tx_desc_size(struct stmmac_priv *priv,
@@ -438,7 +438,7 @@ static void stmmac_set_queue_rx_buf_size(struct stmmac_priv *priv,
 	if (rx_q->xsk_pool && rx_q->buf_alloc_num)
 		buf_size = xsk_pool_get_rx_frame_size(rx_q->xsk_pool);
 	else
-		buf_size = priv->dma_conf.dma_buf_sz;
+		buf_size = priv->dma_conf->dma_buf_sz;
 
 	stmmac_set_dma_bfsize(priv, priv->ioaddr, buf_size, chan);
 }
@@ -450,10 +450,10 @@ static void stmmac_set_queue_rx_buf_size(struct stmmac_priv *priv,
  */
 static inline u32 stmmac_rx_dirty(struct stmmac_priv *priv, u32 queue)
 {
-	struct stmmac_rx_queue *rx_q = &priv->dma_conf.rx_queue[queue];
+	struct stmmac_rx_queue *rx_q = &priv->dma_conf->rx_queue[queue];
 
 	return CIRC_CNT(rx_q->cur_rx, rx_q->dirty_rx,
-			priv->dma_conf.dma_rx_size);
+			priv->dma_conf->dma_rx_size);
 }
 
 static bool stmmac_eee_tx_busy(struct stmmac_priv *priv)
@@ -463,7 +463,7 @@ static bool stmmac_eee_tx_busy(struct stmmac_priv *priv)
 
 	/* check if all TX queues have the work finished */
 	for (queue = 0; queue < tx_cnt; queue++) {
-		struct stmmac_tx_queue *tx_q = &priv->dma_conf.tx_queue[queue];
+		struct stmmac_tx_queue *tx_q = &priv->dma_conf->tx_queue[queue];
 
 		if (tx_q->dirty_tx != tx_q->cur_tx)
 			return true; /* still unfinished work */
@@ -2129,7 +2129,7 @@ static void stmmac_free_tx_skbufs(struct stmmac_priv *priv)
 	u8 queue;
 
 	for (queue = 0; queue < tx_queue_cnt; queue++)
-		dma_free_tx_skbufs(priv, &priv->dma_conf, queue);
+		dma_free_tx_skbufs(priv, priv->dma_conf, queue);
 }
 
 /**
@@ -2638,7 +2638,7 @@ static void stmmac_dma_operation_mode(struct stmmac_priv *priv)
 
 	/* configure all channels */
 	for (chan = 0; chan < rx_channels_count; chan++) {
-		struct stmmac_rx_queue *rx_q = &priv->dma_conf.rx_queue[chan];
+		struct stmmac_rx_queue *rx_q = &priv->dma_conf->rx_queue[chan];
 
 		qmode = priv->plat->rx_queues_cfg[chan].mode_to_use;
 
@@ -2710,7 +2710,7 @@ static const struct xsk_tx_metadata_ops stmmac_xsk_tx_metadata_ops = {
 static bool stmmac_xdp_xmit_zc(struct stmmac_priv *priv, u32 queue, u32 budget)
 {
 	struct netdev_queue *nq = netdev_get_tx_queue(priv->dev, queue);
-	struct stmmac_tx_queue *tx_q = &priv->dma_conf.tx_queue[queue];
+	struct stmmac_tx_queue *tx_q = &priv->dma_conf->tx_queue[queue];
 	struct stmmac_txq_stats *txq_stats = &priv->xstats.txq_stats[queue];
 	bool csum = !priv->plat->tx_queues_cfg[queue].coe_unsupported;
 	struct xsk_buff_pool *pool = tx_q->xsk_pool;
@@ -2799,7 +2799,7 @@ static bool stmmac_xdp_xmit_zc(struct stmmac_priv *priv, u32 queue, u32 budget)
 		xsk_tx_metadata_to_compl(meta,
 					 &tx_q->tx_skbuff_dma[entry].xsk_meta);
 
-		tx_q->cur_tx = STMMAC_NEXT_ENTRY(tx_q->cur_tx, priv->dma_conf.dma_tx_size);
+		tx_q->cur_tx = STMMAC_NEXT_ENTRY(tx_q->cur_tx, priv->dma_conf->dma_tx_size);
 		entry = tx_q->cur_tx;
 	}
 	u64_stats_update_begin(&txq_stats->napi_syncp);
@@ -2847,7 +2847,7 @@ static void stmmac_bump_dma_threshold(struct stmmac_priv *priv, u32 chan)
 static int stmmac_tx_clean(struct stmmac_priv *priv, int budget, u32 queue,
 			   bool *pending_packets)
 {
-	struct stmmac_tx_queue *tx_q = &priv->dma_conf.tx_queue[queue];
+	struct stmmac_tx_queue *tx_q = &priv->dma_conf->tx_queue[queue];
 	struct stmmac_txq_stats *txq_stats = &priv->xstats.txq_stats[queue];
 	unsigned int bytes_compl = 0, pkts_compl = 0;
 	unsigned int entry, xmits = 0, count = 0;
@@ -2860,7 +2860,7 @@ static int stmmac_tx_clean(struct stmmac_priv *priv, int budget, u32 queue,
 	entry = tx_q->dirty_tx;
 
 	/* Try to clean all TX complete frame in 1 shot */
-	while ((entry != tx_q->cur_tx) && count < priv->dma_conf.dma_tx_size) {
+	while ((entry != tx_q->cur_tx) && count < priv->dma_conf->dma_tx_size) {
 		struct xdp_frame *xdpf;
 		struct sk_buff *skb;
 		struct dma_desc *p;
@@ -2967,7 +2967,7 @@ static int stmmac_tx_clean(struct stmmac_priv *priv, int budget, u32 queue,
 
 		stmmac_release_tx_desc(priv, p, priv->descriptor_mode);
 
-		entry = STMMAC_NEXT_ENTRY(entry, priv->dma_conf.dma_tx_size);
+		entry = STMMAC_NEXT_ENTRY(entry, priv->dma_conf->dma_tx_size);
 	}
 	tx_q->dirty_tx = entry;
 
@@ -3035,13 +3035,13 @@ static int stmmac_tx_clean(struct stmmac_priv *priv, int budget, u32 queue,
  */
 static void stmmac_tx_err(struct stmmac_priv *priv, u32 chan)
 {
-	struct stmmac_tx_queue *tx_q = &priv->dma_conf.tx_queue[chan];
+	struct stmmac_tx_queue *tx_q = &priv->dma_conf->tx_queue[chan];
 
 	netif_tx_stop_queue(netdev_get_tx_queue(priv->dev, chan));
 
 	stmmac_stop_tx_dma(priv, chan);
-	dma_free_tx_skbufs(priv, &priv->dma_conf, chan);
-	stmmac_clear_tx_descriptors(priv, &priv->dma_conf, chan);
+	dma_free_tx_skbufs(priv, priv->dma_conf, chan);
+	stmmac_clear_tx_descriptors(priv, priv->dma_conf, chan);
 	stmmac_reset_tx_queue(priv, chan);
 	stmmac_init_tx_chan(priv, priv->ioaddr, priv->plat->dma_cfg,
 			    tx_q->dma_tx_phy, chan);
@@ -3102,8 +3102,8 @@ static int stmmac_napi_check(struct stmmac_priv *priv, u32 chan, u32 dir)
 {
 	int status = stmmac_dma_interrupt_status(priv, priv->ioaddr,
 						 &priv->xstats, chan, dir);
-	struct stmmac_rx_queue *rx_q = &priv->dma_conf.rx_queue[chan];
-	struct stmmac_tx_queue *tx_q = &priv->dma_conf.tx_queue[chan];
+	struct stmmac_rx_queue *rx_q = &priv->dma_conf->rx_queue[chan];
+	struct stmmac_tx_queue *tx_q = &priv->dma_conf->tx_queue[chan];
 	struct stmmac_channel *ch = &priv->channel[chan];
 	struct napi_struct *rx_napi;
 	struct napi_struct *tx_napi;
@@ -3323,7 +3323,7 @@ static int stmmac_init_dma_engine(struct stmmac_priv *priv)
 
 	/* DMA RX Channel Configuration */
 	for (chan = 0; chan < rx_channels_count; chan++) {
-		rx_q = &priv->dma_conf.rx_queue[chan];
+		rx_q = &priv->dma_conf->rx_queue[chan];
 
 		stmmac_init_rx_chan(priv, priv->ioaddr, priv->plat->dma_cfg,
 				    rx_q->dma_rx_phy, chan);
@@ -3334,7 +3334,7 @@ static int stmmac_init_dma_engine(struct stmmac_priv *priv)
 
 	/* DMA TX Channel Configuration */
 	for (chan = 0; chan < tx_channels_count; chan++) {
-		tx_q = &priv->dma_conf.tx_queue[chan];
+		tx_q = &priv->dma_conf->tx_queue[chan];
 
 		stmmac_init_tx_chan(priv, priv->ioaddr, priv->plat->dma_cfg,
 				    tx_q->dma_tx_phy, chan);
@@ -3347,7 +3347,7 @@ static int stmmac_init_dma_engine(struct stmmac_priv *priv)
 
 static void stmmac_tx_timer_arm(struct stmmac_priv *priv, u32 queue)
 {
-	struct stmmac_tx_queue *tx_q = &priv->dma_conf.tx_queue[queue];
+	struct stmmac_tx_queue *tx_q = &priv->dma_conf->tx_queue[queue];
 	u32 tx_coal_timer = priv->tx_coal_timer[queue];
 	struct stmmac_channel *ch;
 	struct napi_struct *napi;
@@ -3415,7 +3415,7 @@ static void stmmac_init_coalesce(struct stmmac_priv *priv)
 	u8 chan;
 
 	for (chan = 0; chan < tx_channel_count; chan++) {
-		struct stmmac_tx_queue *tx_q = &priv->dma_conf.tx_queue[chan];
+		struct stmmac_tx_queue *tx_q = &priv->dma_conf->tx_queue[chan];
 
 		priv->tx_coal_frames[chan] = STMMAC_TX_FRAMES;
 		priv->tx_coal_timer[chan] = STMMAC_COAL_TX_TIMER;
@@ -3436,12 +3436,12 @@ static void stmmac_set_rings_length(struct stmmac_priv *priv)
 	/* set TX ring length */
 	for (chan = 0; chan < tx_channels_count; chan++)
 		stmmac_set_tx_ring_len(priv, priv->ioaddr,
-				       (priv->dma_conf.dma_tx_size - 1), chan);
+				       (priv->dma_conf->dma_tx_size - 1), chan);
 
 	/* set RX ring length */
 	for (chan = 0; chan < rx_channels_count; chan++)
 		stmmac_set_rx_ring_len(priv, priv->ioaddr,
-				       (priv->dma_conf.dma_rx_size - 1), chan);
+				       (priv->dma_conf->dma_rx_size - 1), chan);
 }
 
 /**
@@ -3650,7 +3650,7 @@ static bool stmmac_tso_channel_permitted(struct stmmac_priv *priv,
 					 unsigned int chan)
 {
 	/* TSO and TBS cannot co-exist */
-	return !(priv->dma_conf.tx_queue[chan].tbs & STMMAC_TBS_AVAIL);
+	return !(priv->dma_conf->tx_queue[chan].tbs & STMMAC_TBS_AVAIL);
 }
 
 /**
@@ -3768,7 +3768,7 @@ static int stmmac_hw_setup(struct net_device *dev)
 
 	/* TBS */
 	for (chan = 0; chan < tx_cnt; chan++) {
-		struct stmmac_tx_queue *tx_q = &priv->dma_conf.tx_queue[chan];
+		struct stmmac_tx_queue *tx_q = &priv->dma_conf->tx_queue[chan];
 		int enable = tx_q->tbs & STMMAC_TBS_AVAIL;
 
 		stmmac_enable_tbs(priv, priv->ioaddr, enable, chan);
@@ -3804,7 +3804,7 @@ static void stmmac_free_irq(struct net_device *dev,
 			if (msi->tx_irq[j] > 0) {
 				irq_set_affinity_hint(msi->tx_irq[j], NULL);
 				free_irq(msi->tx_irq[j],
-					 &priv->dma_conf.tx_queue[j]);
+					 &priv->channel[j]);
 			}
 		}
 		irq_idx = priv->plat->rx_queues_to_use;
@@ -3814,7 +3814,7 @@ static void stmmac_free_irq(struct net_device *dev,
 			if (msi->rx_irq[j] > 0) {
 				irq_set_affinity_hint(msi->rx_irq[j], NULL);
 				free_irq(msi->rx_irq[j],
-					 &priv->dma_conf.rx_queue[j]);
+					 &priv->channel[j]);
 			}
 		}
 
@@ -3968,7 +3968,7 @@ static int stmmac_request_irq_multi_msi(struct net_device *dev)
 		sprintf(int_name, "%s:%s-%d", dev->name, "rx", i);
 		ret = request_irq(msi->rx_irq[i],
 				  stmmac_msi_intr_rx,
-				  0, int_name, &priv->dma_conf.rx_queue[i]);
+				  0, int_name, &priv->channel[i]);
 		if (unlikely(ret < 0)) {
 			netdev_err(priv->dev,
 				   "%s: alloc rx-%d  MSI %d (error: %d)\n",
@@ -3992,7 +3992,7 @@ static int stmmac_request_irq_multi_msi(struct net_device *dev)
 		sprintf(int_name, "%s:%s-%d", dev->name, "tx", i);
 		ret = request_irq(msi->tx_irq[i],
 				  stmmac_msi_intr_tx,
-				  0, int_name, &priv->dma_conf.tx_queue[i]);
+				  0, int_name, &priv->channel[i]);
 		if (unlikely(ret < 0)) {
 			netdev_err(priv->dev,
 				   "%s: alloc tx-%d  MSI %d (error: %d)\n",
@@ -4116,8 +4116,8 @@ stmmac_setup_dma_desc(struct stmmac_priv *priv, unsigned int mtu)
 	/* Chose the tx/rx size from the already defined one in the
 	 * priv struct. (if defined)
 	 */
-	dma_conf->dma_tx_size = priv->dma_conf.dma_tx_size;
-	dma_conf->dma_rx_size = priv->dma_conf.dma_rx_size;
+	dma_conf->dma_tx_size = priv->dma_conf->dma_tx_size;
+	dma_conf->dma_rx_size = priv->dma_conf->dma_rx_size;
 
 	if (!dma_conf->dma_tx_size)
 		dma_conf->dma_tx_size = DMA_DEFAULT_TX_SIZE;
@@ -4131,6 +4131,7 @@ stmmac_setup_dma_desc(struct stmmac_priv *priv, unsigned int mtu)
 
 		/* Setup per-TXQ tbs flag before TX descriptor alloc */
 		tx_q->tbs |= tbs_en ? STMMAC_TBS_AVAIL : 0;
+		tx_q->tbs |= priv->dma_conf->tx_queue[chan].tbs & STMMAC_TBS_EN;
 	}
 
 	ret = alloc_dma_desc_resources(priv, dma_conf);
@@ -4204,10 +4205,8 @@ static int __stmmac_open(struct net_device *dev,
 	u8 chan;
 	int ret;
 
-	for (int i = 0; i < priv->plat->tx_queues_to_use; i++)
-		if (priv->dma_conf.tx_queue[i].tbs & STMMAC_TBS_EN)
-			dma_conf->tx_queue[i].tbs = priv->dma_conf.tx_queue[i].tbs;
-	memcpy(&priv->dma_conf, dma_conf, sizeof(*dma_conf));
+	/* Keep RXQ metadata and timers at their registered addresses. */
+	priv->dma_conf = dma_conf;
 
 	/* The PHY is suspended when the interface is reopened without
 	 * disconnecting the PHY, e.g. on MTU change. IEEE 802.3 allows PHYs
@@ -4249,7 +4248,7 @@ static int __stmmac_open(struct net_device *dev,
 	phylink_stop(priv->phylink);
 
 	for (chan = 0; chan < priv->plat->tx_queues_to_use; chan++)
-		hrtimer_cancel(&priv->dma_conf.tx_queue[chan].txtimer);
+		hrtimer_cancel(&priv->dma_conf->tx_queue[chan].txtimer);
 
 	stmmac_release_ptp(priv);
 init_error:
@@ -4261,6 +4260,7 @@ static int __stmmac_open(struct net_device *dev,
 static int stmmac_open(struct net_device *dev)
 {
 	struct stmmac_priv *priv = netdev_priv(dev);
+	struct stmmac_dma_conf *old_conf = priv->dma_conf;
 	struct stmmac_dma_conf *dma_conf;
 	int ret;
 
@@ -4294,7 +4294,7 @@ static int stmmac_open(struct net_device *dev)
 	if (ret)
 		goto err_serdes;
 
-	kfree(dma_conf);
+	kfree(old_conf);
 
 	/* We may have called phylink_speed_down before */
 	phylink_speed_up(priv->phylink);
@@ -4308,6 +4308,7 @@ static int stmmac_open(struct net_device *dev)
 err_runtime_pm:
 	pm_runtime_put(priv->device);
 err_dma_resources:
+	priv->dma_conf = old_conf;
 	free_dma_desc_resources(priv, dma_conf);
 	kfree(dma_conf);
 	return ret;
@@ -4319,11 +4320,16 @@ static void stmmac_quiesce(struct stmmac_priv *priv)
 	u8 chan;
 
 	stmmac_disable_all_queues(priv);
+	netif_tx_disable(priv->dev);
 
-	for (chan = 0; chan < priv->plat->tx_queues_to_use; chan++)
-		hrtimer_cancel(&priv->dma_conf.tx_queue[chan].txtimer);
+	/* A poll function can still arm a timer after napi_complete_done().
+	 * Drain those poll tails and in-flight transmitters before cancelling
+	 * the timers, so none can be rearmed after their final cancellation.
+	 */
+	synchronize_net();
 
-	netif_tx_disable(priv->dev);
+	for (chan = 0; chan < priv->plat->tx_queues_to_use; chan++)
+		hrtimer_cancel(&priv->dma_conf->tx_queue[chan].txtimer);
 }
 
 static void __stmmac_release(struct net_device *dev)
@@ -4348,7 +4354,7 @@ static void __stmmac_release(struct net_device *dev)
 	stmmac_stop_all_dma(priv);
 
 	/* Release and free the Rx/Tx resources */
-	free_dma_desc_resources(priv, &priv->dma_conf);
+	free_dma_desc_resources(priv, priv->dma_conf);
 
 	stmmac_release_ptp(priv);
 
@@ -4413,7 +4419,7 @@ static bool stmmac_vlan_insert(struct stmmac_priv *priv, struct sk_buff *skb,
 		return false;
 
 	stmmac_set_tx_owner(priv, p);
-	tx_q->cur_tx = STMMAC_NEXT_ENTRY(tx_q->cur_tx, priv->dma_conf.dma_tx_size);
+	tx_q->cur_tx = STMMAC_NEXT_ENTRY(tx_q->cur_tx, priv->dma_conf->dma_tx_size);
 	return true;
 }
 
@@ -4433,7 +4439,7 @@ static void stmmac_tso_allocator(struct stmmac_priv *priv, u32 *entry,
 				 dma_addr_t des, int total_len,
 				 bool last_segment, u32 queue)
 {
-	struct stmmac_tx_queue *tx_q = &priv->dma_conf.tx_queue[queue];
+	struct stmmac_tx_queue *tx_q = &priv->dma_conf->tx_queue[queue];
 	struct dma_desc *desc;
 	u32 buff_size;
 	int tmp_len;
@@ -4443,7 +4449,7 @@ static void stmmac_tso_allocator(struct stmmac_priv *priv, u32 *entry,
 	while (tmp_len > 0) {
 		dma_addr_t curr_addr;
 
-		*entry = STMMAC_NEXT_ENTRY(*entry, priv->dma_conf.dma_tx_size);
+		*entry = STMMAC_NEXT_ENTRY(*entry, priv->dma_conf->dma_tx_size);
 		WARN_ON(tx_q->tx_skbuff[*entry]);
 
 		if (tx_q->tbs & STMMAC_TBS_AVAIL)
@@ -4467,7 +4473,7 @@ static void stmmac_tso_allocator(struct stmmac_priv *priv, u32 *entry,
 
 static void stmmac_flush_tx_descriptors(struct stmmac_priv *priv, int queue)
 {
-	struct stmmac_tx_queue *tx_q = &priv->dma_conf.tx_queue[queue];
+	struct stmmac_tx_queue *tx_q = &priv->dma_conf->tx_queue[queue];
 
 	/* The own bit must be the latest setting done when prepare the
 	 * descriptor and then barrier is needed to make sure that
@@ -4620,7 +4626,7 @@ static netdev_tx_t stmmac_tso_xmit(struct sk_buff *skb, struct net_device *dev)
 	nfrags = skb_shinfo(skb)->nr_frags;
 	queue = skb_get_queue_mapping(skb);
 
-	tx_q = &priv->dma_conf.tx_queue[queue];
+	tx_q = &priv->dma_conf->tx_queue[queue];
 	txq_stats = &priv->xstats.txq_stats[queue];
 	first_tx = tx_q->cur_tx;
 
@@ -4658,7 +4664,7 @@ static netdev_tx_t stmmac_tso_xmit(struct sk_buff *skb, struct net_device *dev)
 		stmmac_set_mss(priv, mss_desc, mss);
 		tx_q->mss = mss;
 		tx_q->cur_tx = STMMAC_NEXT_ENTRY(tx_q->cur_tx,
-						priv->dma_conf.dma_tx_size);
+						priv->dma_conf->dma_tx_size);
 		WARN_ON(tx_q->tx_skbuff[tx_q->cur_tx]);
 	}
 
@@ -4729,7 +4735,7 @@ static netdev_tx_t stmmac_tso_xmit(struct sk_buff *skb, struct net_device *dev)
 
 	/* Manage tx mitigation */
 	tx_packets = CIRC_CNT(tx_q->cur_tx + 1, first_tx,
-			      priv->dma_conf.dma_tx_size);
+			      priv->dma_conf->dma_tx_size);
 	tx_q->tx_count_frames += tx_packets;
 
 	if ((skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP) && priv->hwts_tx_en)
@@ -4761,7 +4767,7 @@ static netdev_tx_t stmmac_tso_xmit(struct sk_buff *skb, struct net_device *dev)
 	 * ndo_start_xmit will fill this descriptor the next time it's
 	 * called and stmmac_tx_clean may clean up to this descriptor.
 	 */
-	tx_q->cur_tx = STMMAC_NEXT_ENTRY(tx_q->cur_tx, priv->dma_conf.dma_tx_size);
+	tx_q->cur_tx = STMMAC_NEXT_ENTRY(tx_q->cur_tx, priv->dma_conf->dma_tx_size);
 
 	if (unlikely(stmmac_tx_avail(priv, queue) <= (MAX_SKB_FRAGS + 1))) {
 		netif_dbg(priv, hw, priv->dev, "%s: stop transmitted packets\n",
@@ -4791,7 +4797,7 @@ static netdev_tx_t stmmac_tso_xmit(struct sk_buff *skb, struct net_device *dev)
 	 * segment.
 	 */
 	is_last_segment = CIRC_CNT(tx_q->cur_tx, first_entry,
-				   priv->dma_conf.dma_tx_size) == 1;
+				   priv->dma_conf->dma_tx_size) == 1;
 
 	/* Complete the first descriptor before granting the DMA */
 	stmmac_prepare_tso_tx_desc(priv, first, 1, proto_hdr_len, 0, 1,
@@ -4829,13 +4835,13 @@ static netdev_tx_t stmmac_tso_xmit(struct sk_buff *skb, struct net_device *dev)
 	for (;;) {
 		desc = stmmac_get_tx_desc(priv, tx_q, first_entry);
 		stmmac_release_tx_desc(priv, desc, priv->descriptor_mode);
-		stmmac_free_tx_buffer(priv, &priv->dma_conf, queue,
+		stmmac_free_tx_buffer(priv, priv->dma_conf, queue,
 				      first_entry);
 		if (first_entry == entry)
 			break;
 
 		first_entry = STMMAC_NEXT_ENTRY(first_entry,
-						priv->dma_conf.dma_tx_size);
+						priv->dma_conf->dma_tx_size);
 	}
 error:
 	dev_err(priv->device, "Tx dma map failed\n");
@@ -4920,7 +4926,7 @@ static netdev_tx_t stmmac_xmit(struct sk_buff *skb, struct net_device *dev)
 		return NETDEV_TX_BUSY;
 	}
 
-	tx_q = &priv->dma_conf.tx_queue[queue];
+	tx_q = &priv->dma_conf->tx_queue[queue];
 	first_tx = tx_q->cur_tx;
 
 	/* Check if VLAN can be inserted by HW */
@@ -4996,7 +5002,7 @@ static netdev_tx_t stmmac_xmit(struct sk_buff *skb, struct net_device *dev)
 		unsigned int frag_size = skb_frag_size(frag);
 		bool last_segment = (i == (nfrags - 1));
 
-		entry = STMMAC_NEXT_ENTRY(entry, priv->dma_conf.dma_tx_size);
+		entry = STMMAC_NEXT_ENTRY(entry, priv->dma_conf->dma_tx_size);
 		WARN_ON(tx_q->tx_skbuff[entry]);
 
 		desc = stmmac_get_tx_desc(priv, tx_q, entry);
@@ -5026,7 +5032,7 @@ static netdev_tx_t stmmac_xmit(struct sk_buff *skb, struct net_device *dev)
 	 * This approach takes care about the fragments: desc is the first
 	 * element in case of no SG.
 	 */
-	tx_packets = CIRC_CNT(entry + 1, first_tx, priv->dma_conf.dma_tx_size);
+	tx_packets = CIRC_CNT(entry + 1, first_tx, priv->dma_conf->dma_tx_size);
 	tx_q->tx_count_frames += tx_packets;
 
 	if ((skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP) && priv->hwts_tx_en)
@@ -5054,7 +5060,7 @@ static netdev_tx_t stmmac_xmit(struct sk_buff *skb, struct net_device *dev)
 	 * ndo_start_xmit will fill this descriptor the next time it's
 	 * called and stmmac_tx_clean may clean up to this descriptor.
 	 */
-	entry = STMMAC_NEXT_ENTRY(entry, priv->dma_conf.dma_tx_size);
+	entry = STMMAC_NEXT_ENTRY(entry, priv->dma_conf->dma_tx_size);
 	tx_q->cur_tx = entry;
 
 	if (netif_msg_pktdata(priv)) {
@@ -5169,7 +5175,7 @@ static void stmmac_rx_vlan(struct net_device *dev, struct sk_buff *skb)
  */
 static inline void stmmac_rx_refill(struct stmmac_priv *priv, u32 queue)
 {
-	struct stmmac_rx_queue *rx_q = &priv->dma_conf.rx_queue[queue];
+	struct stmmac_rx_queue *rx_q = &priv->dma_conf->rx_queue[queue];
 	int dirty = stmmac_rx_dirty(priv, queue);
 	unsigned int entry = rx_q->dirty_rx;
 	gfp_t gfp = (GFP_ATOMIC | __GFP_NOWARN);
@@ -5220,7 +5226,7 @@ static inline void stmmac_rx_refill(struct stmmac_priv *priv, u32 queue)
 		dma_wmb();
 		stmmac_set_rx_owner(priv, p, use_rx_wd);
 
-		entry = STMMAC_NEXT_ENTRY(entry, priv->dma_conf.dma_rx_size);
+		entry = STMMAC_NEXT_ENTRY(entry, priv->dma_conf->dma_rx_size);
 	}
 	rx_q->dirty_rx = entry;
 	stmmac_set_queue_rx_tail_ptr(priv, rx_q, queue, rx_q->dirty_rx);
@@ -5248,12 +5254,12 @@ static unsigned int stmmac_rx_buf1_len(struct stmmac_priv *priv,
 
 	/* First descriptor, not last descriptor and not split header */
 	if (status & rx_not_ls)
-		return priv->dma_conf.dma_buf_sz;
+		return priv->dma_conf->dma_buf_sz;
 
 	plen = stmmac_get_rx_frame_len(priv, p, coe);
 
 	/* First descriptor and last descriptor and not split header */
-	return min_t(unsigned int, priv->dma_conf.dma_buf_sz, plen);
+	return min_t(unsigned int, priv->dma_conf->dma_buf_sz, plen);
 }
 
 static unsigned int stmmac_rx_buf2_len(struct stmmac_priv *priv,
@@ -5283,7 +5289,7 @@ static unsigned int stmmac_rx_buf2_len(struct stmmac_priv *priv,
 
 	/* Not GMAC4 and not last descriptor */
 	if (priv->plat->core_type != DWMAC_CORE_GMAC4 && (status & rx_not_ls))
-		return priv->dma_conf.dma_buf_sz;
+		return priv->dma_conf->dma_buf_sz;
 
 	/* GMAC4 or last descriptor */
 	plen = stmmac_get_rx_frame_len(priv, p, coe);
@@ -5295,7 +5301,7 @@ static int stmmac_xdp_xmit_xdpf(struct stmmac_priv *priv, int queue,
 				struct xdp_frame *xdpf, bool dma_map)
 {
 	struct stmmac_txq_stats *txq_stats = &priv->xstats.txq_stats[queue];
-	struct stmmac_tx_queue *tx_q = &priv->dma_conf.tx_queue[queue];
+	struct stmmac_tx_queue *tx_q = &priv->dma_conf->tx_queue[queue];
 	bool csum = !priv->plat->tx_queues_cfg[queue].coe_unsupported;
 	unsigned int entry = tx_q->cur_tx;
 	enum stmmac_txbuf_type buf_type;
@@ -5361,7 +5367,7 @@ static int stmmac_xdp_xmit_xdpf(struct stmmac_priv *priv, int queue,
 
 	stmmac_enable_dma_transmission(priv, priv->ioaddr, queue);
 
-	entry = STMMAC_NEXT_ENTRY(entry, priv->dma_conf.dma_tx_size);
+	entry = STMMAC_NEXT_ENTRY(entry, priv->dma_conf->dma_tx_size);
 	tx_q->cur_tx = entry;
 
 	return STMMAC_XDP_TX;
@@ -5552,7 +5558,7 @@ static void stmmac_dispatch_skb_zc(struct stmmac_priv *priv, u32 queue,
 
 static bool stmmac_rx_refill_zc(struct stmmac_priv *priv, u32 queue, u32 budget)
 {
-	struct stmmac_rx_queue *rx_q = &priv->dma_conf.rx_queue[queue];
+	struct stmmac_rx_queue *rx_q = &priv->dma_conf->rx_queue[queue];
 	unsigned int entry = rx_q->dirty_rx;
 	struct dma_desc *rx_desc = NULL;
 	bool ret = true;
@@ -5592,7 +5598,7 @@ static bool stmmac_rx_refill_zc(struct stmmac_priv *priv, u32 queue, u32 budget)
 		dma_wmb();
 		stmmac_set_rx_owner(priv, rx_desc, use_rx_wd);
 
-		entry = STMMAC_NEXT_ENTRY(entry, priv->dma_conf.dma_rx_size);
+		entry = STMMAC_NEXT_ENTRY(entry, priv->dma_conf->dma_rx_size);
 	}
 
 	if (rx_desc) {
@@ -5616,7 +5622,7 @@ static struct stmmac_xdp_buff *xsk_buff_to_stmmac_ctx(struct xdp_buff *xdp)
 static int stmmac_rx_zc(struct stmmac_priv *priv, int limit, u32 queue)
 {
 	struct stmmac_rxq_stats *rxq_stats = &priv->xstats.rxq_stats[queue];
-	struct stmmac_rx_queue *rx_q = &priv->dma_conf.rx_queue[queue];
+	struct stmmac_rx_queue *rx_q = &priv->dma_conf->rx_queue[queue];
 	unsigned int count = 0, error = 0, len = 0;
 	int dirty = stmmac_rx_dirty(priv, queue);
 	unsigned int next_entry = rx_q->cur_rx;
@@ -5633,7 +5639,7 @@ static int stmmac_rx_zc(struct stmmac_priv *priv, int limit, u32 queue)
 		netdev_dbg(priv->dev, "%s: descriptor ring:\n", __func__);
 		desc_size = stmmac_get_rx_desc_size(priv);
 
-		stmmac_display_ring(priv, rx_head, priv->dma_conf.dma_rx_size, true,
+		stmmac_display_ring(priv, rx_head, priv->dma_conf->dma_rx_size, true,
 				    rx_q->dma_rx_phy, desc_size);
 	}
 	while (count < limit) {
@@ -5677,7 +5683,7 @@ static int stmmac_rx_zc(struct stmmac_priv *priv, int limit, u32 queue)
 
 		/* Prefetch the next RX descriptor */
 		next_entry = STMMAC_NEXT_ENTRY(rx_q->cur_rx,
-					       priv->dma_conf.dma_rx_size);
+					       priv->dma_conf->dma_rx_size);
 		if (unlikely(next_entry == rx_q->dirty_rx))
 			break;
 
@@ -5802,7 +5808,7 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
 {
 	u32 rx_errors = 0, rx_dropped = 0, rx_bytes = 0, rx_packets = 0;
 	struct stmmac_rxq_stats *rxq_stats = &priv->xstats.rxq_stats[queue];
-	struct stmmac_rx_queue *rx_q = &priv->dma_conf.rx_queue[queue];
+	struct stmmac_rx_queue *rx_q = &priv->dma_conf->rx_queue[queue];
 	struct stmmac_channel *ch = &priv->channel[queue];
 	unsigned int count = 0, error = 0, len = 0;
 	int status = 0, coe = priv->hw->rx_csum;
@@ -5815,7 +5821,7 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
 	int bufsz;
 
 	dma_dir = page_pool_get_dma_dir(rx_q->page_pool);
-	bufsz = DIV_ROUND_UP(priv->dma_conf.dma_buf_sz, PAGE_SIZE) * PAGE_SIZE;
+	bufsz = DIV_ROUND_UP(priv->dma_conf->dma_buf_sz, PAGE_SIZE) * PAGE_SIZE;
 
 	if (netif_msg_rx_status(priv)) {
 		void *rx_head = stmmac_get_rx_desc(priv, rx_q, 0);
@@ -5823,7 +5829,7 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
 		netdev_dbg(priv->dev, "%s: descriptor ring:\n", __func__);
 		desc_size = stmmac_get_rx_desc_size(priv);
 
-		stmmac_display_ring(priv, rx_head, priv->dma_conf.dma_rx_size, true,
+		stmmac_display_ring(priv, rx_head, priv->dma_conf->dma_rx_size, true,
 				    rx_q->dma_rx_phy, desc_size);
 	}
 	while (count < limit) {
@@ -5863,7 +5869,7 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
 			break;
 
 		next_entry = STMMAC_NEXT_ENTRY(rx_q->cur_rx,
-					       priv->dma_conf.dma_rx_size);
+					       priv->dma_conf->dma_rx_size);
 		if (unlikely(next_entry == rx_q->dirty_rx))
 			break;
 
@@ -5997,7 +6003,7 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
 						buf1_len, dma_dir);
 			skb_add_rx_frag(skb, skb_shinfo(skb)->nr_frags,
 					buf->page, buf->page_offset, buf1_len,
-					priv->dma_conf.dma_buf_sz);
+					priv->dma_conf->dma_buf_sz);
 			buf->page = NULL;
 		}
 
@@ -6006,7 +6012,7 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
 						buf2_len, dma_dir);
 			skb_add_rx_frag(skb, skb_shinfo(skb)->nr_frags,
 					buf->sec_page, 0, buf2_len,
-					priv->dma_conf.dma_buf_sz);
+					priv->dma_conf->dma_buf_sz);
 			buf->sec_page = NULL;
 		}
 
@@ -6231,6 +6237,7 @@ static void stmmac_set_rx_mode(struct net_device *dev)
 static int stmmac_change_mtu(struct net_device *dev, int new_mtu)
 {
 	struct stmmac_priv *priv = netdev_priv(dev);
+	struct stmmac_dma_conf *old_conf = priv->dma_conf;
 	int txfifosz = priv->plat->tx_fifo_size;
 	struct stmmac_dma_conf *dma_conf;
 	const int mtu = new_mtu;
@@ -6267,10 +6274,12 @@ static int stmmac_change_mtu(struct net_device *dev, int new_mtu)
 			return PTR_ERR(dma_conf);
 		}
 
+		netif_device_detach(dev);
 		__stmmac_release(dev);
 
 		ret = __stmmac_open(dev, dma_conf);
 		if (ret) {
+			priv->dma_conf = old_conf;
 			free_dma_desc_resources(priv, dma_conf);
 			kfree(dma_conf);
 			/*
@@ -6282,9 +6291,10 @@ static int stmmac_change_mtu(struct net_device *dev, int new_mtu)
 			return ret;
 		}
 
-		kfree(dma_conf);
+		kfree(old_conf);
 
 		stmmac_set_rx_mode(dev);
+		netif_device_attach(dev);
 	}
 
 	WRITE_ONCE(dev->mtu, mtu);
@@ -6455,15 +6465,11 @@ static irqreturn_t stmmac_safety_interrupt(int irq, void *dev_id)
 
 static irqreturn_t stmmac_msi_intr_tx(int irq, void *data)
 {
-	struct stmmac_tx_queue *tx_q = (struct stmmac_tx_queue *)data;
-	struct stmmac_dma_conf *dma_conf;
-	int chan = tx_q->queue_index;
-	struct stmmac_priv *priv;
+	struct stmmac_channel *ch = data;
+	struct stmmac_priv *priv = ch->priv_data;
+	int chan = ch->index;
 	int status;
 
-	dma_conf = container_of(tx_q, struct stmmac_dma_conf, tx_queue[chan]);
-	priv = container_of(dma_conf, struct stmmac_priv, dma_conf);
-
 	/* Check if adapter is up */
 	if (test_bit(STMMAC_DOWN, &priv->state))
 		return IRQ_HANDLED;
@@ -6482,13 +6488,9 @@ static irqreturn_t stmmac_msi_intr_tx(int irq, void *data)
 
 static irqreturn_t stmmac_msi_intr_rx(int irq, void *data)
 {
-	struct stmmac_rx_queue *rx_q = (struct stmmac_rx_queue *)data;
-	struct stmmac_dma_conf *dma_conf;
-	int chan = rx_q->queue_index;
-	struct stmmac_priv *priv;
-
-	dma_conf = container_of(rx_q, struct stmmac_dma_conf, rx_queue[chan]);
-	priv = container_of(dma_conf, struct stmmac_priv, dma_conf);
+	struct stmmac_channel *ch = data;
+	struct stmmac_priv *priv = ch->priv_data;
+	int chan = ch->index;
 
 	/* Check if adapter is up */
 	if (test_bit(STMMAC_DOWN, &priv->state))
@@ -6655,34 +6657,34 @@ static int stmmac_rings_status_show(struct seq_file *seq, void *v)
 	tx_count = priv->plat->tx_queues_to_use;
 
 	for (queue = 0; queue < rx_count; queue++) {
-		struct stmmac_rx_queue *rx_q = &priv->dma_conf.rx_queue[queue];
+		struct stmmac_rx_queue *rx_q = &priv->dma_conf->rx_queue[queue];
 
 		seq_printf(seq, "RX Queue %d:\n", queue);
 
 		if (priv->extend_desc) {
 			seq_printf(seq, "Extended descriptor ring:\n");
 			sysfs_display_ring((void *)rx_q->dma_erx,
-					   priv->dma_conf.dma_rx_size, 1, seq, rx_q->dma_rx_phy);
+					   priv->dma_conf->dma_rx_size, 1, seq, rx_q->dma_rx_phy);
 		} else {
 			seq_printf(seq, "Descriptor ring:\n");
 			sysfs_display_ring((void *)rx_q->dma_rx,
-					   priv->dma_conf.dma_rx_size, 0, seq, rx_q->dma_rx_phy);
+					   priv->dma_conf->dma_rx_size, 0, seq, rx_q->dma_rx_phy);
 		}
 	}
 
 	for (queue = 0; queue < tx_count; queue++) {
-		struct stmmac_tx_queue *tx_q = &priv->dma_conf.tx_queue[queue];
+		struct stmmac_tx_queue *tx_q = &priv->dma_conf->tx_queue[queue];
 
 		seq_printf(seq, "TX Queue %d:\n", queue);
 
 		if (priv->extend_desc) {
 			seq_printf(seq, "Extended descriptor ring:\n");
 			sysfs_display_ring((void *)tx_q->dma_etx,
-					   priv->dma_conf.dma_tx_size, 1, seq, tx_q->dma_tx_phy);
+					   priv->dma_conf->dma_tx_size, 1, seq, tx_q->dma_tx_phy);
 		} else if (!(tx_q->tbs & STMMAC_TBS_AVAIL)) {
 			seq_printf(seq, "Descriptor ring:\n");
 			sysfs_display_ring((void *)tx_q->dma_tx,
-					   priv->dma_conf.dma_tx_size, 0, seq, tx_q->dma_tx_phy);
+					   priv->dma_conf->dma_tx_size, 0, seq, tx_q->dma_tx_phy);
 		}
 	}
 
@@ -7148,31 +7150,31 @@ void stmmac_disable_rx_queue(struct stmmac_priv *priv, u32 queue)
 	spin_unlock_irqrestore(&ch->lock, flags);
 
 	stmmac_stop_rx_dma(priv, queue);
-	__free_dma_rx_desc_resources(priv, &priv->dma_conf, queue);
+	__free_dma_rx_desc_resources(priv, priv->dma_conf, queue);
 }
 
 void stmmac_enable_rx_queue(struct stmmac_priv *priv, u32 queue)
 {
-	struct stmmac_rx_queue *rx_q = &priv->dma_conf.rx_queue[queue];
+	struct stmmac_rx_queue *rx_q = &priv->dma_conf->rx_queue[queue];
 	struct stmmac_channel *ch = &priv->channel[queue];
 	unsigned long flags;
 	int ret;
 
-	ret = __alloc_dma_rx_desc_resources(priv, &priv->dma_conf, queue);
+	ret = __alloc_dma_rx_desc_resources(priv, priv->dma_conf, queue);
 	if (ret) {
 		netdev_err(priv->dev, "Failed to alloc RX desc.\n");
 		return;
 	}
 
-	ret = __init_dma_rx_desc_rings(priv, &priv->dma_conf, queue, GFP_KERNEL);
+	ret = __init_dma_rx_desc_rings(priv, priv->dma_conf, queue, GFP_KERNEL);
 	if (ret) {
-		__free_dma_rx_desc_resources(priv, &priv->dma_conf, queue);
+		__free_dma_rx_desc_resources(priv, priv->dma_conf, queue);
 		netdev_err(priv->dev, "Failed to init RX desc.\n");
 		return;
 	}
 
 	stmmac_reset_rx_queue(priv, queue);
-	stmmac_clear_rx_descriptors(priv, &priv->dma_conf, queue);
+	stmmac_clear_rx_descriptors(priv, priv->dma_conf, queue);
 
 	stmmac_init_rx_chan(priv, priv->ioaddr, priv->plat->dma_cfg,
 			    rx_q->dma_rx_phy, queue);
@@ -7198,31 +7200,31 @@ void stmmac_disable_tx_queue(struct stmmac_priv *priv, u32 queue)
 	spin_unlock_irqrestore(&ch->lock, flags);
 
 	stmmac_stop_tx_dma(priv, queue);
-	__free_dma_tx_desc_resources(priv, &priv->dma_conf, queue);
+	__free_dma_tx_desc_resources(priv, priv->dma_conf, queue);
 }
 
 void stmmac_enable_tx_queue(struct stmmac_priv *priv, u32 queue)
 {
-	struct stmmac_tx_queue *tx_q = &priv->dma_conf.tx_queue[queue];
+	struct stmmac_tx_queue *tx_q = &priv->dma_conf->tx_queue[queue];
 	struct stmmac_channel *ch = &priv->channel[queue];
 	unsigned long flags;
 	int ret;
 
-	ret = __alloc_dma_tx_desc_resources(priv, &priv->dma_conf, queue);
+	ret = __alloc_dma_tx_desc_resources(priv, priv->dma_conf, queue);
 	if (ret) {
 		netdev_err(priv->dev, "Failed to alloc TX desc.\n");
 		return;
 	}
 
-	ret = __init_dma_tx_desc_rings(priv,  &priv->dma_conf, queue);
+	ret = __init_dma_tx_desc_rings(priv,  priv->dma_conf, queue);
 	if (ret) {
-		__free_dma_tx_desc_resources(priv, &priv->dma_conf, queue);
+		__free_dma_tx_desc_resources(priv, priv->dma_conf, queue);
 		netdev_err(priv->dev, "Failed to init TX desc.\n");
 		return;
 	}
 
 	stmmac_reset_tx_queue(priv, queue);
-	stmmac_clear_tx_descriptors(priv, &priv->dma_conf, queue);
+	stmmac_clear_tx_descriptors(priv, priv->dma_conf, queue);
 
 	stmmac_init_tx_chan(priv, priv->ioaddr, priv->plat->dma_cfg,
 			    tx_q->dma_tx_phy, queue);
@@ -7251,7 +7253,7 @@ void stmmac_xdp_release(struct net_device *dev)
 	stmmac_disable_all_queues(priv);
 
 	for (chan = 0; chan < priv->plat->tx_queues_to_use; chan++)
-		hrtimer_cancel(&priv->dma_conf.tx_queue[chan].txtimer);
+		hrtimer_cancel(&priv->dma_conf->tx_queue[chan].txtimer);
 
 	/* Free the IRQ lines */
 	stmmac_free_irq(dev, REQ_IRQ_ERR_ALL, 0);
@@ -7260,7 +7262,7 @@ void stmmac_xdp_release(struct net_device *dev)
 	stmmac_stop_all_dma(priv);
 
 	/* Release and free the Rx/Tx resources */
-	free_dma_desc_resources(priv, &priv->dma_conf);
+	free_dma_desc_resources(priv, priv->dma_conf);
 
 	/* Disable the MAC Rx/Tx */
 	stmmac_mac_set(priv, priv->ioaddr, false);
@@ -7284,14 +7286,14 @@ int stmmac_xdp_open(struct net_device *dev)
 	u8 chan;
 	int ret;
 
-	ret = alloc_dma_desc_resources(priv, &priv->dma_conf);
+	ret = alloc_dma_desc_resources(priv, priv->dma_conf);
 	if (ret < 0) {
 		netdev_err(dev, "%s: DMA descriptors allocation failed\n",
 			   __func__);
 		goto dma_desc_error;
 	}
 
-	ret = init_dma_desc_rings(dev, &priv->dma_conf, GFP_KERNEL);
+	ret = init_dma_desc_rings(dev, priv->dma_conf, GFP_KERNEL);
 	if (ret < 0) {
 		netdev_err(dev, "%s: DMA descriptors initialization failed\n",
 			   __func__);
@@ -7311,7 +7313,7 @@ int stmmac_xdp_open(struct net_device *dev)
 
 	/* DMA RX Channel Configuration */
 	for (chan = 0; chan < rx_cnt; chan++) {
-		rx_q = &priv->dma_conf.rx_queue[chan];
+		rx_q = &priv->dma_conf->rx_queue[chan];
 
 		stmmac_init_rx_chan(priv, priv->ioaddr, priv->plat->dma_cfg,
 				    rx_q->dma_rx_phy, chan);
@@ -7326,7 +7328,7 @@ int stmmac_xdp_open(struct net_device *dev)
 
 	/* DMA TX Channel Configuration */
 	for (chan = 0; chan < tx_cnt; chan++) {
-		tx_q = &priv->dma_conf.tx_queue[chan];
+		tx_q = &priv->dma_conf->tx_queue[chan];
 
 		stmmac_init_tx_chan(priv, priv->ioaddr, priv->plat->dma_cfg,
 				    tx_q->dma_tx_phy, chan);
@@ -7356,10 +7358,10 @@ int stmmac_xdp_open(struct net_device *dev)
 
 irq_error:
 	for (chan = 0; chan < priv->plat->tx_queues_to_use; chan++)
-		hrtimer_cancel(&priv->dma_conf.tx_queue[chan].txtimer);
+		hrtimer_cancel(&priv->dma_conf->tx_queue[chan].txtimer);
 
 init_error:
-	free_dma_desc_resources(priv, &priv->dma_conf);
+	free_dma_desc_resources(priv, priv->dma_conf);
 dma_desc_error:
 	return ret;
 }
@@ -7367,8 +7369,6 @@ int stmmac_xdp_open(struct net_device *dev)
 int stmmac_xsk_wakeup(struct net_device *dev, u32 queue, u32 flags)
 {
 	struct stmmac_priv *priv = netdev_priv(dev);
-	struct stmmac_rx_queue *rx_q;
-	struct stmmac_tx_queue *tx_q;
 	struct stmmac_channel *ch;
 
 	if (test_bit(STMMAC_DOWN, &priv->state) ||
@@ -7382,11 +7382,9 @@ int stmmac_xsk_wakeup(struct net_device *dev, u32 queue, u32 flags)
 	    queue >= priv->plat->tx_queues_to_use)
 		return -EINVAL;
 
-	rx_q = &priv->dma_conf.rx_queue[queue];
-	tx_q = &priv->dma_conf.tx_queue[queue];
 	ch = &priv->channel[queue];
 
-	if (!rx_q->xsk_pool && !tx_q->xsk_pool)
+	if (!test_bit(queue, priv->af_xdp_zc_qps))
 		return -EINVAL;
 
 	if (!napi_if_scheduled_mark_missed(&ch->rxtx_napi)) {
@@ -7777,8 +7775,8 @@ int stmmac_reinit_ringparam(struct net_device *dev, u32 rx_size, u32 tx_size)
 	if (netif_running(dev))
 		stmmac_release(dev);
 
-	priv->dma_conf.dma_rx_size = rx_size;
-	priv->dma_conf.dma_tx_size = tx_size;
+	priv->dma_conf->dma_rx_size = rx_size;
+	priv->dma_conf->dma_tx_size = tx_size;
 
 	if (netif_running(dev))
 		ret = stmmac_open(dev);
@@ -7943,6 +7941,13 @@ struct plat_stmmacenet_data *stmmac_plat_dat_alloc(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(stmmac_plat_dat_alloc);
 
+static void stmmac_free_dma_conf(void *data)
+{
+	struct stmmac_priv *priv = data;
+
+	kfree(priv->dma_conf);
+}
+
 static int __stmmac_dvr_probe(struct device *device,
 			      struct plat_stmmacenet_data *plat_dat,
 			      struct stmmac_resources *res)
@@ -7967,6 +7972,13 @@ static int __stmmac_dvr_probe(struct device *device,
 	priv = netdev_priv(ndev);
 	priv->device = device;
 	priv->dev = ndev;
+	/* Keep ring sizes and per-queue settings even while the device is down. */
+	priv->dma_conf = kzalloc_obj(*priv->dma_conf);
+	if (!priv->dma_conf)
+		return -ENOMEM;
+	ret = devm_add_action_or_reset(device, stmmac_free_dma_conf, priv);
+	if (ret)
+		return ret;
 
 	for (i = 0; i < MTL_MAX_RX_QUEUES; i++)
 		u64_stats_init(&priv->xstats.rxq_stats[i].napi_syncp);
@@ -8389,7 +8401,7 @@ EXPORT_SYMBOL_GPL(stmmac_suspend);
 
 static void stmmac_reset_rx_queue(struct stmmac_priv *priv, u32 queue)
 {
-	struct stmmac_rx_queue *rx_q = &priv->dma_conf.rx_queue[queue];
+	struct stmmac_rx_queue *rx_q = &priv->dma_conf->rx_queue[queue];
 
 	rx_q->cur_rx = 0;
 	rx_q->dirty_rx = 0;
@@ -8397,7 +8409,7 @@ static void stmmac_reset_rx_queue(struct stmmac_priv *priv, u32 queue)
 
 static void stmmac_reset_tx_queue(struct stmmac_priv *priv, u32 queue)
 {
-	struct stmmac_tx_queue *tx_q = &priv->dma_conf.tx_queue[queue];
+	struct stmmac_tx_queue *tx_q = &priv->dma_conf->tx_queue[queue];
 
 	tx_q->cur_tx = 0;
 	tx_q->dirty_tx = 0;
@@ -8480,7 +8492,7 @@ int stmmac_resume(struct device *dev)
 	stmmac_reset_queues_param(priv);
 
 	stmmac_free_tx_skbufs(priv);
-	stmmac_clear_descriptors(priv, &priv->dma_conf);
+	stmmac_clear_descriptors(priv, priv->dma_conf);
 
 	ret = stmmac_hw_setup(ndev);
 	if (ret < 0) {
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c
index c25dc9f89270..2511339e55e4 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c
@@ -887,8 +887,8 @@ static int stmmac_test_flowctrl(struct stmmac_priv *priv)
 		struct stmmac_channel *ch = &priv->channel[i];
 		u32 tail;
 
-		tail = priv->dma_conf.rx_queue[i].dma_rx_phy +
-			(priv->dma_conf.dma_rx_size * sizeof(struct dma_desc));
+		tail = priv->dma_conf->rx_queue[i].dma_rx_phy +
+			(priv->dma_conf->dma_rx_size * sizeof(struct dma_desc));
 
 		stmmac_set_rx_tail_ptr(priv, priv->ioaddr, tail, i);
 		stmmac_start_rx(priv, priv->ioaddr, i);
@@ -1787,7 +1787,7 @@ static int stmmac_test_arpoffload(struct stmmac_priv *priv)
 static int __stmmac_test_jumbo(struct stmmac_priv *priv, u16 queue)
 {
 	struct stmmac_packet_attrs attr = { };
-	int size = priv->dma_conf.dma_buf_sz;
+	int size = priv->dma_conf->dma_buf_sz;
 
 	if (!dwmac_is_xmac(priv->plat->core_type))
 		size -= NET_IP_ALIGN;
@@ -1873,7 +1873,7 @@ static int stmmac_test_tbs(struct stmmac_priv *priv)
 
 	/* Find first TBS enabled Queue, if any */
 	for (i = 0; i < priv->plat->tx_queues_to_use; i++)
-		if (priv->dma_conf.tx_queue[i].tbs & STMMAC_TBS_AVAIL)
+		if (priv->dma_conf->tx_queue[i].tbs & STMMAC_TBS_AVAIL)
 			break;
 
 	if (i >= priv->plat->tx_queues_to_use)
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
index 42a00446e9b4..bb1dfe2702ac 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
@@ -1197,13 +1197,13 @@ static int tc_setup_etf(struct stmmac_priv *priv,
 		return -EOPNOTSUPP;
 	if (qopt->queue >= priv->plat->tx_queues_to_use)
 		return -EINVAL;
-	if (!(priv->dma_conf.tx_queue[qopt->queue].tbs & STMMAC_TBS_AVAIL))
+	if (!(priv->dma_conf->tx_queue[qopt->queue].tbs & STMMAC_TBS_AVAIL))
 		return -EINVAL;
 
 	if (qopt->enable)
-		priv->dma_conf.tx_queue[qopt->queue].tbs |= STMMAC_TBS_EN;
+		priv->dma_conf->tx_queue[qopt->queue].tbs |= STMMAC_TBS_EN;
 	else
-		priv->dma_conf.tx_queue[qopt->queue].tbs &= ~STMMAC_TBS_EN;
+		priv->dma_conf->tx_queue[qopt->queue].tbs &= ~STMMAC_TBS_EN;
 
 	netdev_info(priv->dev, "%s ETF for Queue %d\n",
 		    qopt->enable ? "enabled" : "disabled", qopt->queue);

-- 
2.53.0

