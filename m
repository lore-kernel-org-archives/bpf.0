Received: from mail-oo2-f37.google.com (mail-oo2-f37.google.com [74.125.231.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E69946983F
	for <bpf@vger.kernel.org>; Sun, 27 Sep 2026 22:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790546445; cv=none; b=iaMYGg3P+8EmX6fTS9xSdgruzGEdYmMwFRGTBVKmnE812B/MpkvWu9QKLNCGdQc9l1bo7abhsBJ8L1J+hKhsHkHK6ajO8Iwy77PNIGXu6G00sqMix8lthLAZiqTjItLux5ukMAuUvSCPIYCCYt2ghtjIxQKli7KrNp3Ke2YO7Nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790546445; c=relaxed/simple;
	bh=VIduLl42KnAOTfMWR9Pr8MdjqMBHpV/GRP6MkSBNbqQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nNYkm07SIf1hWG3Q9AvXsG/ITJQ1ellmql5jiHf2Pp6qFH1S/5LNiM5rXiVbbA3XaKAsh5KX5YcHDjxLjnUTeHcVGPmijiQZic3/MYtOng2VNAJ0WaK1kEb35LyYHyqeKwBCXSm2ekahPeR2uZ3Y34BSg5WCLJMuGGExvmNAJc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tgm8p7ao; arc=none smtp.client-ip=74.125.231.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tgm8p7ao"
Received: by mail-oo2-f37.google.com with SMTP id 46e09a7af769-80032c08611so2022645a34.3
        for <bpf@vger.kernel.org>; Sun, 27 Sep 2026 15:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790546438; x=1791151238; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1gLUXzy2Xjx8Cab+i1wrgHaR5HLup8/A3/8/0Q1nuNo=;
        b=Tgm8p7aomEGQBmCTuo+iZ07z+LtqbVWzEq7KmxtQoqXQiQNUzuYZvrH8lRPZrKy6F1
         u9FIBRTupdPczT7aJxyYf85590QugF4gIr2rRa6MkbrfBkabq/LpPQ3qL+RbZqK2mRjp
         OBfyMPrMBxWc4dL00WRf1IySSJUjI5rKKjN3DHQQU2iutG4HhzNCOviLIqtYTN+nAzXL
         oAn9pKLk+e2Vn37CL4LeW/Z9PLzNvXiYBHmUvNhX6DhOsxoUa2PbeMOWEhb6WbfitTQd
         lU8mQiENkmOyI291QaPdtqFjh9T5Ovj81zEUOFp47LqP+A0pGM0z13JJ4ST5mFkM/AWL
         pl9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790546438; x=1791151238;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1gLUXzy2Xjx8Cab+i1wrgHaR5HLup8/A3/8/0Q1nuNo=;
        b=rLbmyRvNgErR9Hwhyz+6hi4cPI+9ePwHE1MAJ75+rgprdwngKPQLTfJWZKAggR47Fw
         U/ZtRbcg5NhGWYalAvzg7iQCVzMbh1c/fgYzoa1Lt6k7xLgPGln+t4uF+bDSq86lCYDb
         2MsDDI+/ulki4VqzK95EQx4V4oPdbjSPbQxM/NaerAKrrGO/pCSSp9o/f6Cqr5wmbpYN
         9gtPpy85BOYB2yKLWUTg7/LZI5yRYtp2vGxxmGG6ojBh/lLZOx+NV/UKedm6Dyl7I+mg
         QZ9sjopFY/q6h1njzhLSviYGZ2gMxlLDINPsiQxDE2VmCB00SbXsUNCavCitgmTM1eyr
         yvsg==
X-Forwarded-Encrypted: i=1; AKwUvBxOucBXkMjBa+fvPpRjEIYAsLIStWPAK16PGtJXKFNe6HOSaD9C2X5l4Z6AFpYiqd5ZQtc=@vger.kernel.org
X-Gm-Message-State: AFuF++lb4vDGImLF1O6p5uwj57KvoqJXcNbO7NenjhMGcZ/I/nuo/yGY
	js6oKLsJposCv4gjz4fEaO1/W7lXUcRuapqCBIBdrKu8GlrjtkC59M7N
X-Gm-Gg: AYBFou2HB9EId8+y/idS7ODnBlg/wNyXphaqUjMTuAeEA8SkaOmOnpEz5eMVHqInDtr
	Pb2u++taiHmwkenQWkLiI5FlhIfAfeoWR+nVJetyZ4Na6p81Rg9bP7vRrgs96HV0/SPpZu9Ci7Q
	2MPDUTa8uYIGAOfojUouQZi5XrjCjRVGYJhPN1XxW9FkK942DJK9lXIhd7bCRFHGlMzchE+pcxk
	nIKY+OP1mta6lRtIGToAkhthdp7Y3pngCAVX4U4iAndAgo6bFl92V3/GAjP7kFm+Ihm4siiRljR
	MdQlylPpfnt7GSENMFpZNR+mfVnTEL4XQMqR66XB6MYTfVYuJSbIZCEQWanx6qcHhY9wxO85r9p
	GNeeqv6RRV8w8FTCOi88taeAcKslCuCgMaUc1a74p1WxGJJBNVEW8QxhrqRCWOhHpKn/e9zWhfT
	xoZ8m+V6ytZKehDGr7RgvzwmNDKN2x0t62kekICydWhnFaWWf3SLfXzkoxOSA0WOefHwvfMkq53
	oKSi9XZLiPijnADYiKGpnI74+oRCvw7zqal30+XT07sIPTNqXek33p5CinqaiAcZ3PtTstFJQH/
	ab9S2gXC3iv+to+nizshCM+NwUdEJCzAaWEFGeHhaS/Wv2hITIVsmnc4KuYdLBpPRnzboPG+s6u
	Y2WqXF7bG9DMiv4CAkHLczVrSY1isZJTQuZd+Mf+frw==
X-Received: by 2002:a05:6820:a28b:20b0:6d7:97cf:dba5 with SMTP id 006d021491bc7-6d797cfdd2emr2266574eaf.37.1790546437865;
        Sun, 27 Sep 2026 15:00:37 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-81b3de6f7e1sm4874147a34.22.2026.09.27.15.00.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 15:00:36 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sun, 27 Sep 2026 15:59:54 -0600
Subject: [PATCH net-next v5 19/19] net: stmmac: retain DMA resources across
 MTU changes
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260927-submit-stmmac-reset-fixes-v1-v5-19-feec6c14dd06@gmail.com>
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

Prepare the replacement configuration before quiescing the old datapath.
Retain its rings and IRQ registrations until setup succeeds so rollback
needs no new allocations or IRQ requests. Fill RX buffer holes before
reset without altering active descriptors; rebuild the retained rings
only after a successful reset.

Mask the device DMA interrupt sources, gate shared-IRQ handlers and
drain all registered handlers before the final transmitter and timer
cancellation. Restore saved interrupt masks only after the selected
rings and NAPI are ready. This leaves interrupt-controller lines
available to unrelated devices.

Program receive limits using the prospective MTU and restore the old MTU
before rollback. Reapply PHC and TC state before starting DMA,
preserving the PHC registration and packet timestamp filters. Continuous
PHC time across the reset is not preserved.

If rollback fails, leave the administratively-up interface detached in a
distinct HALTED state: rings retained, NAPI disabled and IRQ
registrations released. Close or a later down/up can finish cleanup and
recovery without freeing IRQs twice. Retain potentially active DMA
memory until hardware shutdown is confirmed.

Fixes: 3470079687448 ("net: ethernet: stmicro: stmmac: permit MTU change with interface up")
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac.h      |   2 +
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 216 +++++++++++++++++-----
 2 files changed, 173 insertions(+), 45 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac.h b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
index 06fe750624b6..a65253d309d0 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac.h
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
@@ -279,6 +279,8 @@ enum stmmac_datapath_state {
 	STMMAC_DATAPATH_RUNNING,
 	/* Resources retained, NAPI disabled, DMA stop requested. */
 	STMMAC_DATAPATH_SUSPENDED,
+	/* Failed MTU rollback: rings retained, but no IRQs or running NAPI. */
+	STMMAC_DATAPATH_HALTED,
 };
 
 struct stmmac_priv {
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 435c76b7db30..7951b3e60d84 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -1016,7 +1016,7 @@ static void stmmac_release_ptp(struct stmmac_priv *priv)
 }
 
 /* ptp_mutex excludes configuration and crosstimestamp operations. The
- * spinlock also excludes atomic clock reads while changing this gate.
+ * spinlock also excludes atomic gettime callers while changing this gate.
  */
 static void stmmac_block_ptp(struct stmmac_priv *priv, bool block)
 {
@@ -2251,6 +2251,30 @@ static void stmmac_free_tx_skbufs(struct stmmac_priv *priv)
 		dma_free_tx_skbufs(priv, priv->dma_conf, queue);
 }
 
+/* NAPI is stopped, but DMA may still be using the old rings. Fill holes in
+ * the software buffer array without changing any descriptors. If allocation
+ * fails, the old rings can continue unchanged. Otherwise rollback after a
+ * reset will not need to allocate buffers.
+ */
+static int stmmac_prepare_rx_buffers(struct stmmac_priv *priv)
+{
+	struct stmmac_dma_conf *dma_conf = priv->dma_conf;
+	u32 queue, i;
+	int ret;
+
+	for (queue = 0; queue < priv->plat->rx_queues_to_use; queue++) {
+		struct stmmac_rx_queue *rx_q = &dma_conf->rx_queue[queue];
+
+		for (i = 0; i < dma_conf->dma_rx_size; i++) {
+			ret = stmmac_alloc_rx_buffer(priv, rx_q, &rx_q->buf_pool[i]);
+			if (ret)
+				return ret;
+		}
+	}
+
+	return 0;
+}
+
 /* Only after a successful DMA reset. MTU rollback has already filled holes;
  * resume may need new page-pool buffers or a partially populated XSK ring.
  */
@@ -4425,14 +4449,38 @@ static void stmmac_synchronize_irq(struct stmmac_priv *priv)
 			synchronize_irq(msi->tx_irq[i]);
 }
 
+/* Keep the IRQ registrations, but prevent DMA handlers from using the rings.
+ * The caller drains handlers after quiescing every channel and restores their
+ * masks only once the active DMA configuration is ready again.
+ */
+static void stmmac_set_dma_irq_state(struct stmmac_priv *priv, bool enable,
+				     u32 *irq_mask)
+{
+	u32 channels = max(priv->plat->rx_queues_to_use,
+			   priv->plat->tx_queues_to_use);
+	u32 chan;
+
+	for (chan = 0; chan < channels; chan++) {
+		struct stmmac_channel *ch = &priv->channel[chan];
+		unsigned long flags;
+
+		spin_lock_irqsave(&ch->lock, flags);
+		ch->irq_quiesced = !enable;
+		if (enable)
+			stmmac_set_dma_irq_mask(priv, priv->ioaddr, chan,
+						irq_mask[chan]);
+		else
+			irq_mask[chan] = stmmac_set_dma_irq_mask(priv, priv->ioaddr,
+								 chan, 0);
+		spin_unlock_irqrestore(&ch->lock, flags);
+	}
+}
+
 /**
- *  stmmac_setup_dma_desc - Generate a dma_conf and allocate DMA queue
- *  @priv: driver private structure
- *  @mtu: MTU to setup the dma queue and buf with
- *  Description: Allocate and generate a dma_conf based on the provided MTU.
- *  Allocate the Tx/Rx DMA queue and init them.
- *  Return value:
- *  the dma_conf allocated struct on success and an appropriate ERR_PTR on failure.
+ * stmmac_setup_dma_desc - allocate and initialize a DMA configuration
+ * @priv: driver private structure
+ * @mtu: MTU to size the receive buffers for
+ * Return: the allocated configuration, or an ERR_PTR on failure
  */
 static struct stmmac_dma_conf *
 stmmac_setup_dma_desc(struct stmmac_priv *priv, unsigned int mtu)
@@ -4666,7 +4714,7 @@ static int __stmmac_open(struct net_device *dev,
 	priv->dma_conf = dma_conf;
 
 	/* The PHY is suspended when the interface is reopened without
-	 * disconnecting the PHY, e.g. on MTU change. IEEE 802.3 allows PHYs
+	 * disconnecting the PHY, e.g. on an ethtool change. IEEE 802.3 allows PHYs
 	 * to stop their receive clock while powered down, but the DMA
 	 * software reset in stmmac_hw_setup() requires a running receive
 	 * clock, and phylink_start() below resumes the PHY only after the
@@ -4823,20 +4871,22 @@ static void stmmac_quiesce(struct stmmac_priv *priv)
 static void __stmmac_release(struct net_device *dev)
 {
 	struct stmmac_priv *priv = netdev_priv(dev);
+	enum stmmac_datapath_state state = priv->datapath;
 
-	/* A failed MTU reopen has already released the data path. */
+	/* There may be no resources left after detached XDP reconfiguration. */
 	if (priv->datapath == STMMAC_DATAPATH_DOWN)
 		return;
 
 	phylink_stop(priv->phylink);
 
-	/* Suspend retains the resources, but has already stopped activity. */
+	/* SUSPENDED and HALTED retain rings with NAPI already disabled. */
 	if (priv->datapath == STMMAC_DATAPATH_RUNNING)
 		stmmac_quiesce(priv);
 	priv->datapath = STMMAC_DATAPATH_DOWN;
 
 	/* Free the IRQ lines */
-	stmmac_free_irq(dev, REQ_IRQ_ERR_ALL, 0);
+	if (state != STMMAC_DATAPATH_HALTED)
+		stmmac_free_irq(dev, REQ_IRQ_ERR_ALL, 0);
 
 	/* Drain any final IRQ-triggered network activity before DMA shutdown. */
 	stmmac_stop_tx_queues(priv);
@@ -6723,6 +6773,109 @@ static void stmmac_set_rx_mode(struct net_device *dev)
 	stmmac_set_filter(priv, priv->hw, dev);
 }
 
+static int stmmac_reconfigure_mtu(struct net_device *dev, int mtu)
+{
+	struct stmmac_priv *priv = netdev_priv(dev);
+	struct stmmac_dma_conf *old_conf = priv->dma_conf;
+	struct stmmac_dma_conf *new_conf;
+	int old_mtu = dev->mtu;
+	int ret, restore_ret;
+	u32 irq_mask[STMMAC_CH_MAX];
+	u32 chan;
+
+	new_conf = stmmac_setup_dma_desc(priv, mtu);
+	if (IS_ERR(new_conf))
+		return PTR_ERR(new_conf);
+
+	mutex_lock(&priv->ptp_mutex);
+	stmmac_block_ptp(priv, true);
+	netif_device_detach(dev);
+	phylink_stop(priv->phylink);
+	stmmac_quiesce(priv);
+	if (stmmac_fpe_supported(priv))
+		ethtool_mmsv_stop(&priv->fpe_cfg.mmsv);
+
+	/* Drain handlers before the final TX stop and configuration swap,
+	 * and keep the registrations for rollback.
+	 */
+	stmmac_set_dma_irq_state(priv, false, irq_mask);
+	stmmac_synchronize_irq(priv);
+	stmmac_stop_tx_queues(priv);
+
+	ret = stmmac_prepare_rx_buffers(priv);
+	if (ret)
+		goto restart;
+
+	stmmac_stop_all_dma(priv);
+	phylink_prepare_resume(priv->phylink);
+
+	/* MAC receive limits must be programmed for the prospective MTU. */
+	WRITE_ONCE(dev->mtu, mtu);
+	priv->dma_conf = new_conf;
+	stmmac_reset_queues_param(priv);
+	ret = stmmac_hw_setup(dev, false, true);
+	if (ret) {
+		stmmac_stop_all_dma(priv);
+		stmmac_mac_set(priv, priv->ioaddr, false);
+		priv->dma_conf = old_conf;
+		WRITE_ONCE(dev->mtu, old_mtu);
+
+		/* Reuse the retained rings. Reinitialize them only after reset
+		 * has completed, not merely after clearing the DMA enable bits.
+		 */
+		restore_ret = stmmac_hw_setup(dev, true, true);
+		if (restore_ret) {
+			stmmac_stop_all_dma(priv);
+			stmmac_mac_set(priv, priv->ioaddr, false);
+			/* Setup may have restored DMA interrupt enables. */
+			stmmac_set_dma_irq_state(priv, false, irq_mask);
+			stmmac_free_irq(dev, REQ_IRQ_ERR_ALL, 0);
+			stmmac_stop_tx_queues(priv);
+			stmmac_stop_all_dma(priv);
+			memset(irq_mask, 0, sizeof(irq_mask));
+			stmmac_set_dma_irq_state(priv, true, irq_mask);
+			priv->datapath = STMMAC_DATAPATH_HALTED;
+			netdev_err(dev, "MTU rollback failed: %pe; interface remains detached\n",
+				   ERR_PTR(restore_ret));
+			goto free_new;
+		}
+	} else {
+		/* Hardware setup completed its reset before using the new rings.
+		 * The old DMA allocations can now be released safely.
+		 */
+		stmmac_put_dma_conf(priv, old_conf);
+		for (chan = 0; chan < priv->plat->tx_queues_to_use; chan++)
+			hrtimer_setup(&new_conf->tx_queue[chan].txtimer,
+				      stmmac_tx_timer, CLOCK_MONOTONIC,
+				      HRTIMER_MODE_REL);
+	}
+
+	stmmac_set_rx_mode(dev);
+	stmmac_vlan_restore(priv);
+	stmmac_start_all_dma(priv);
+
+restart:
+	stmmac_block_ptp(priv, false);
+	mutex_unlock(&priv->ptp_mutex);
+	stmmac_enable_all_queues(priv);
+	stmmac_set_dma_irq_state(priv, true, irq_mask);
+	stmmac_enable_all_dma_irq(priv);
+	phylink_start(priv->phylink);
+	netif_device_attach(dev);
+	for (chan = 0; chan < priv->plat->tx_queues_to_use; chan++)
+		stmmac_tx_timer_arm(priv, chan);
+	if (!ret)
+		return 0;
+	goto free_conf;
+
+free_new:
+	/* Failed rollback leaves the registered PHC inaccessible as well. */
+	mutex_unlock(&priv->ptp_mutex);
+free_conf:
+	stmmac_put_dma_conf(priv, new_conf);
+	return ret;
+}
+
 /**
  *  stmmac_change_mtu - entry point to change MTU size for the device.
  *  @dev : device pointer.
@@ -6737,9 +6890,7 @@ static void stmmac_set_rx_mode(struct net_device *dev)
 static int stmmac_change_mtu(struct net_device *dev, int new_mtu)
 {
 	struct stmmac_priv *priv = netdev_priv(dev);
-	struct stmmac_dma_conf *old_conf = priv->dma_conf;
 	int txfifosz = priv->plat->tx_fifo_size;
-	struct stmmac_dma_conf *dma_conf;
 	const int mtu = new_mtu;
 	int ret;
 
@@ -6765,35 +6916,9 @@ static int stmmac_change_mtu(struct net_device *dev, int new_mtu)
 	 */
 	if (netif_running(dev) &&
 	    (dev->mtu > ETH_DATA_LEN || mtu > ETH_DATA_LEN)) {
-		netdev_dbg(priv->dev, "restarting interface to change its MTU\n");
-		/* Try to allocate the new DMA conf with the new mtu */
-		dma_conf = stmmac_setup_dma_desc(priv, mtu);
-		if (IS_ERR(dma_conf)) {
-			netdev_err(priv->dev, "failed allocating new dma conf for new MTU %d\n",
-				   mtu);
-			return PTR_ERR(dma_conf);
-		}
-
-		netif_device_detach(dev);
-		__stmmac_release(dev);
-
-		ret = __stmmac_open(dev, dma_conf);
-		if (ret) {
-			priv->dma_conf = old_conf;
-			stmmac_put_dma_conf(priv, dma_conf);
-			/*
-			 * Keep the administrative state and PHY/PM ownership until
-			 * ndo_stop(), but prevent use of the released data path.
-			 */
-			netif_device_detach(dev);
-			netdev_err(priv->dev, "failed reopening the interface after MTU change\n");
+		ret = stmmac_reconfigure_mtu(dev, mtu);
+		if (ret)
 			return ret;
-		}
-
-		stmmac_put_dma_conf(priv, old_conf);
-
-		stmmac_set_rx_mode(dev);
-		netif_device_attach(dev);
 	}
 
 	WRITE_ONCE(dev->mtu, mtu);
@@ -7632,11 +7757,12 @@ static int stmmac_bpf(struct net_device *dev, struct netdev_bpf *bpf)
 		return -EOPNOTSUPP;
 
 	/*
-	 * Pool removal must succeed even after a failed resume. Release the
-	 * suspended rings before their pool or XDP buffer layout can change.
+	 * Pool removal must succeed after failed resume or MTU rollback. Release
+	 * retained rings before their pool or XDP buffer layout can change.
 	 * Leave the interface detached until it is closed and reopened.
 	 */
-	if (priv->datapath == STMMAC_DATAPATH_SUSPENDED)
+	if (priv->datapath == STMMAC_DATAPATH_SUSPENDED ||
+	    priv->datapath == STMMAC_DATAPATH_HALTED)
 		__stmmac_release(dev);
 
 	switch (bpf->command) {

-- 
2.53.0

