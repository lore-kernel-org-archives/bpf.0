Received: from mail-oo2-f37.google.com (mail-oo2-f37.google.com [74.125.231.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46C3743CE71
	for <bpf@vger.kernel.org>; Sat, 26 Sep 2026 15:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790437797; cv=none; b=TCbApvg/bcqmjIxE11c2CF+oMWrpcL+/DzO5lZd9crHjSkG0Bp+E+QBTRnZ6M0EkeX26xLUMd2uK14vPyJhLzktt25kpWXkmDhclyUQsDnUTS/f1Nml5bjBPv36PrU4/OFkYJ3qDhbTEl187zRZ3iewtGKAqmTIctJ+y0THR2GE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790437797; c=relaxed/simple;
	bh=j0GelKIR+8sdSlghOzo6HZis8yz0eoknRZijzt1nYiI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CCX244EAs6E/1+1lJajv2BmsZX+s15tzOmGu6o9j+ZYZYUSluJG4THHkU1c/Ka7wvIbMXMYScGbMKMMNT1iFaLlL/52S3GFBRc9/7Q7voIB8jJ1uh1EpoqoS3bm1PZs2lDCirE73E48z9IoobZRALwK1FOY/lvj3uCoRJyGket0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B/ojQ3Yq; arc=none smtp.client-ip=74.125.231.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B/ojQ3Yq"
Received: by mail-oo2-f37.google.com with SMTP id 46e09a7af769-8137b129131so1172505a34.2
        for <bpf@vger.kernel.org>; Sat, 26 Sep 2026 08:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790437792; x=1791042592; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HLTMfxgLa8vC7MGW+mtlayhPdwf1DSymVq+0sQ7was0=;
        b=B/ojQ3Yq5qiUm2G/cX5CQ6AXssPvf3iN7bZb6zo0GokYVfJt7eM1oi+81EgVOvzGsq
         pseWAqmGugTtlS8CpnqHSCXsz8emXopgeMvxdB14MDa6LyOsx1IgcJNfdB9cyoMQq4Pm
         SIsjNNqdwmGrZfz3NEcfJ2muYGkKdp5ZACn6UIlbhFfjip6dp8aHI66X87pUNHRh8pWm
         VRC0Xu6R9NK9lkAld6R1MukaTcttyP8nqRMRTpOo1PqeLCE2yKdnKKk+cef8pBmEylul
         zPSR4emyxTbIm2exwG64EF/1BpV6SpehlwXdjEAq9+PFq5ilG2RTIeCaq9310xc03gNk
         8v4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790437792; x=1791042592;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HLTMfxgLa8vC7MGW+mtlayhPdwf1DSymVq+0sQ7was0=;
        b=e91MGO+/dGA7HzRXiFwMIz9u3poPFz0Qlr+3jKTfusJSNroG+n9hGqGKkvSwMILLg3
         EK2iqrzfIbZ6ONpPGnNb+ckKMk0QZurVUeS/LDOEKoA+4SzPW+B03mGQFhX9huTjD5jN
         wS0Bmdnv5PUMsRE5WxwJOgtnfsXU7QLUHov1VS1YfuXDRFmI3YY5v4Dq6/rURXeKLHzA
         JYEvqB+UY1PjncNlGsDx4lY4cezU4KuRgnFfSs6fZy3jLsdq42fyej3Bhv4+U2zXS7U7
         mh8nhUIPVl3T5u2xq1Wf46sQ/RHmit3EBEL03Ky0tUTnHUKRFQZsdt1ALToImEEbHM53
         ai+g==
X-Forwarded-Encrypted: i=1; AKwUvBxrYDCRiB/2GAdYEV8sEOVRuNHZSKyx1OAPhCmRQ3oRhU+/RngeGUPBaxo3eHsKkgh9awU=@vger.kernel.org
X-Gm-Message-State: AFuF++mb/WTXNfdSRlivJjiePO+lE1muILm7WyPFGedjJsubvEJF3sO1
	cWv4RvKPbBQpx1EpV2ubYoM10o7khOx989JhyeDgWT+wFpq9UeQAUcEm
X-Gm-Gg: AYBFou3+Xl5oWS6Fvqm1QE0prMK/a+q3CgFvoXOXzBKfjI0cq26jlsU4Vg6fsIRGyNr
	DCcSM7rH7/BXvT532wqm7dFoSj1f9Z8L63e/6CDhZnTihvnZZJiLivZz1kMyUQ1hQmsChB19Vul
	86QzwwoXXX42uLtjFSuMP0nQMu7sXgUQglaxjQDwdLeF29smzS7svDsQi1bS11GiyWjyH35Zk/c
	rnnLRqIkYVhYI5HmUiHIctjhFeZtbB01AZOPYzoAfQr4ps2K6J40VXYtc/7EAOI7lEvBo+6f5nM
	Xie4ErC9MziCmjJhahX+cDLE0zM2fWIXt+Nf0BOg3jp52UvK5N7xUVruNZ1za4Rw43utr5I0TdP
	LRLXCyb0QsZTWkz9lyW+Idwi8dkDim5861OjwEHjGixmDNP4KfXsU07mXt/P6UFqPRDTccDiHMA
	RqhMQx6wB/AmbOzgrrb3aHcONoLc+5frbj6mseODJRX+lVffAZQCtlFY76yV+Xkf9Obwe9Th3f5
	FXOSdXqgHLXP/vj0t7Y0vRMBDv1UM4IkbdELIYx83WTIrw0U7AedZ84glD2yxq9gPRPEW5c5kb3
	XSaT1LnSmS5130IOd3B0xQwHdw4d99RBZMUUVY33pU0srzQ8oo4c1oCLStgxGbX6/P/eeveI00O
	uAHKxhFeZMfTj3MZpDzVsO0mbMxOoOx4=
X-Received: by 2002:a05:6830:258a:b0:816:b03e:f9db with SMTP id 46e09a7af769-81780b974femr9021140a34.6.1790437791761;
        Sat, 26 Sep 2026 08:49:51 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-818e98b16d4sm5442366a34.26.2026.09.26.08.49.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 08:49:51 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sat, 26 Sep 2026 09:49:10 -0600
Subject: [PATCH net v4 15/15] net: stmmac: retain DMA resources across MTU
 changes
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260926-submit-stmmac-reset-fixes-v1-v4-15-ec1c0250b3c9@gmail.com>
References: <20260926-submit-stmmac-reset-fixes-v1-v4-0-ec1c0250b3c9@gmail.com>
In-Reply-To: <20260926-submit-stmmac-reset-fixes-v1-v4-0-ec1c0250b3c9@gmail.com>
To: Russell King <linux@armlinux.org.uk>, Andrew Lunn <andrew@lunn.ch>, 
 Heiner Kallweit <hkallweit1@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Joakim Zhang <qiangqing.zhang@nxp.com>, 
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
 Samuel Holland <samuel@sholland.org>, Eric Dumazet <edumazet@kernel.org>
Cc: Richard Genoud <richard.genoud@bootlin.com>, 
 Alastair D'Silva <alastair@d-silva.org>, Maxime Ripard <mripard@kernel.org>, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org, 
 ZhaoJinming <zhaojinming@uniontech.com>, 
 Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>, 
 Ding Hui <dinghui1111@163.com>, James Hilliard <james.hilliard1@gmail.com>, 
 linux-tegra@vger.kernel.org, linux-sunxi@lists.linux.dev
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
index 9e711acb81fb..e2b9b5b387c7 100644
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
index 08049c05ffc4..8964f52c26ba 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -977,7 +977,7 @@ static void stmmac_release_ptp(struct stmmac_priv *priv)
 }
 
 /* ptp_mutex excludes configuration and crosstimestamp operations. The
- * spinlock also excludes atomic clock reads while changing this gate.
+ * spinlock also excludes atomic gettime callers while changing this gate.
  */
 static void stmmac_block_ptp(struct stmmac_priv *priv, bool block)
 {
@@ -2205,6 +2205,30 @@ static void stmmac_free_tx_skbufs(struct stmmac_priv *priv)
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
 /* Only after a successful DMA reset, and with all RX buffers prepared. */
 static void stmmac_reinit_dma_desc(struct stmmac_priv *priv)
 {
@@ -4311,14 +4335,38 @@ static void stmmac_synchronize_irq(struct stmmac_priv *priv)
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
@@ -4544,7 +4592,7 @@ static int __stmmac_open(struct net_device *dev,
 	priv->dma_conf = dma_conf;
 
 	/* The PHY is suspended when the interface is reopened without
-	 * disconnecting the PHY, e.g. on MTU change. IEEE 802.3 allows PHYs
+	 * disconnecting the PHY, e.g. on an ethtool change. IEEE 802.3 allows PHYs
 	 * to stop their receive clock while powered down, but the DMA
 	 * software reset in stmmac_hw_setup() requires a running receive
 	 * clock, and phylink_start() below resumes the PHY only after the
@@ -4699,20 +4747,22 @@ static void stmmac_quiesce(struct stmmac_priv *priv)
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
@@ -6601,6 +6651,109 @@ static void stmmac_set_rx_mode(struct net_device *dev)
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
@@ -6615,9 +6768,7 @@ static void stmmac_set_rx_mode(struct net_device *dev)
 static int stmmac_change_mtu(struct net_device *dev, int new_mtu)
 {
 	struct stmmac_priv *priv = netdev_priv(dev);
-	struct stmmac_dma_conf *old_conf = priv->dma_conf;
 	int txfifosz = priv->plat->tx_fifo_size;
-	struct stmmac_dma_conf *dma_conf;
 	const int mtu = new_mtu;
 	int ret;
 
@@ -6643,35 +6794,9 @@ static int stmmac_change_mtu(struct net_device *dev, int new_mtu)
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
@@ -7514,11 +7639,12 @@ static int stmmac_bpf(struct net_device *dev, struct netdev_bpf *bpf)
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

