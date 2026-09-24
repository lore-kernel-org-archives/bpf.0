Received: from mail-oo2-f41.google.com (mail-oo2-f41.google.com [74.125.231.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1048D4C4F54
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 17:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790271884; cv=none; b=O86uJGGUTEb6n6FlzjnfetGWOY1uaZvsL289oRA5yk6fHexEqIpramx4lCnDV7Mu6R3Wqx/ZNGSNghaifSJtI7txvaVrWuPVxx8kNu8fn7XBkHfI4hfo+GuImIcfKlSQ83gm56QNof9i4lB9Qev3K1vlktYHjNsBOjokBN7ZRaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790271884; c=relaxed/simple;
	bh=9y7gP0E989+z+b6dO4rwjqqTQszRjM8bqv4dlkXEiJ4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eCGUEuQzlNXuEbHHEA4KRCidgNBAddydZ3Wjsufrnz3l1Gqhect1K3VDTGC69tG2Vl1MFy5rf9eF9JIH/LW+4vLHX3Tu8nX15/WS2dATjZ2TC5KRtsrRbmGF/GROqktZJfxhfPyQR3qzj7eWVBQ7CQagKS1JdNc0LGXL/OhTVTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=le+dwArn; arc=none smtp.client-ip=74.125.231.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="le+dwArn"
Received: by mail-oo2-f41.google.com with SMTP id 46e09a7af769-8177a7fc354so15393a34.3
        for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 10:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790271881; x=1790876681; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TtZyr7zD7XzEr4nEzXsxfa6vCpDgYRfpwe/x6NfV/Lc=;
        b=le+dwArnfPKq6sIKep8+Py2fv/NciejnoOzeaF2N/61B3uyf7e5WqIXLJWK8J0YT65
         pyUCG8T7rgVk/ubpf4E9jWfxZZ6g9lpfR1rlHoEWcfZtvH4wALnT4B17Emp2jl3jLYGh
         OHaHvlKjLFVUh57XdXtDNhoneWN8PqRgUzmwlAqpgoSdMGrlVOx+RJkYj2zU8TdMvfy2
         +vF/0NGnSzARZwHl5yXrLFsd62cXxrS7oxlozlg6dpJxdO4R3JBKbXn6Z4VQPh/3/GT7
         8ZC91EmihFabca0u6sJMeYnyOjfFg75awsIWcFs2iqdPOnE1U0IsDTXHY8rIgibySqD7
         04Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790271881; x=1790876681;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TtZyr7zD7XzEr4nEzXsxfa6vCpDgYRfpwe/x6NfV/Lc=;
        b=EExVzuqstyT6w+d8MYD4iWCTDIbVGC17dMzGI/hLimgCvKS3BJSlzqnozxgqHP2y3e
         7pOxYegytNNBRKpnipfJfjCMoxafDGU+mFczujxAexALw/NALi2urzrXnjxQD9M9Uc5B
         ogWTBCq12kKUQrGfQpBygIrku5S7m9nbFP7009phZEdXuwAT8JVKWX5EpkEb9dRc73bd
         0zBFe1KwRJXme91AjfQ0ZIp9P87E3gAbCJEaz1dRXEWA8SmxElUcgfSmLjc3mmsy6QBC
         Xq27DOlq6hA57SDYNlJZ2OiTEAJ4rU74v5h+UM5EzUeAlcNHhN4nPF5EaFlSYmBl5hh3
         dPiw==
X-Forwarded-Encrypted: i=1; AKwUvBysMnQCqJP+AV7ApSNqpR8PhKYxDq52NWpJPbOPagcIKA8hxaIVZNiSSopbzEZNTPuQXfw=@vger.kernel.org
X-Gm-Message-State: AFuF++kve+tJHWSSMiGu0EsGtZTm68lYB5GYG7CoOw0dhJ2T1TH9+KfZ
	DoAQWjKJ4ByTthOEeApulm/5OrjfjmR2tmZUQjzzFobAm5yn2WF0Qc1H
X-Gm-Gg: AYBFou3HLUP2NSGsJycvgqZxcMz8oS4urlzBE5F31reoj/g0CRRoWwPj10is5lTe4py
	oGT8OVON7fhVJuZIWt3wgql+ojILwoOw9qtG9wv1xmYR+ph5D7rClfeg/dWGjQjGO70qJb2YRA8
	KGnoIOPZq5uIJMCl+dCc8XK29dwH7IUD6sylBAHK2v17DEKemne3nY+o0TO65QT0xYs73PRvwDW
	9sgXHyh7Suxk1GU00YLXpWaTTuab0vpi2w2x9pb4ZGsSCDtlTBtXrHRWP1B3A87scQnM1KebKPr
	6WKnoMILlQrwg5sjZtXCNNrmzNyANcZ55UkxILTVTc05xqarP/IbknjRZ6WrlzTh6cdk418fumt
	rcvfb6KY1TboavGLOTJrLwQ6bnpkmHSGFFVamBo6u9+GejgH2vSH7XxmdsIFlFXxM7Bi4bUvAqr
	1qCiNPH0SlyiWUG8qQq1mdpqiN7wfcD/Iu3AZE7t5i0Kzd0Q+UB9hMQptR8Eame7yUVFiXBKz05
	10hDCpgELxCRlXMepI6kDj3+YnmGmUSPELm2astw08+JB9oIB7/ZhIbmUw5ZEnC+98XiqcJ/feH
	5YIoZmURxegkx5BTa8Em9wRS0jyu7Fk+SWZRT0wCFS0JfnW4NN5KjIDS5SQzG6oRVSfz1C/jwJ0
	2+JnXWaTD1DaJwTh607jtvA==
X-Received: by 2002:a05:6820:1ca6:b0:6aa:da04:b56f with SMTP id 006d021491bc7-6d43f2c7551mr2947931eaf.3.1790271880781;
        Thu, 24 Sep 2026 10:44:40 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-491e8f8d14asm3027802fac.0.2026.09.24.10.44.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 10:44:40 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Thu, 24 Sep 2026 11:44:33 -0600
Subject: [PATCH net v3 03/10] net: stmmac: keep datapath state coherent
 after reinitialization failure
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260924-submit-stmmac-reset-fixes-v1-v3-3-c031e3f3a282@gmail.com>
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

An MTU change releases the running datapath before reopening it. If the
reopen fails, its replacement DMA resources are freed, but the netdev is
still administratively up. A later close repeats NAPI shutdown, IRQ
release and DMA cleanup. Hardware resume failure has a different partial
state: suspend disabled NAPI but retained the IRQs and DMA resources, so
ordinary close can hang in a second napi_disable().

Track the datapath independently of the administrative state, with three
states describing running queues, suspended queues with resources still
owned, and a released datapath. Separate quiescing the queues from
releasing their resources, so close can perform only the remaining work.
Serialize these transitions with RTNL, including suspend and resume.

On a failed MTU reopen, leave the PHY attachment and runtime-PM reference
owned until ndo_stop(), but detach the netdev so the released datapath
cannot be used. On failed hardware resume, stop any partially initialized
DMA and leave the retained datapath suspended and detached. Do not call
netif_close() or change the administrative state. A later successful
resume can retry the retained datapath; alternatively an ordinary down
releases it, reattaches the now-down netdev, and permits a fresh open.

Stop phylink directly from its suspended state during close. Do not
restart it on failed hardware just to balance its shutdown. Preserve
IRQ-before-final-DMA-stop ordering, and stop DMA on failed open before
the caller frees the replacement rings, including IRQ-request failure
after hardware setup has started DMA.

Account for callers which are not excluded by netif_device_detach():
guard descriptor readback and its queue-count snapshot with RTNL and
resource ownership, reject TC queue reconfiguration while detached, and
prevent deferred reset work from reopening the failed interface. Check
availability under the TX queue lock before XDP transmission. XDP
configuration must use the actual datapath state rather than IFF_UP.
AF_XDP pool removal cannot be rejected: release any suspended rings before
a socket's pool is unmapped and freed, leaving recovery to down/up.

Track completion of the core sleep sequence separately from datapath
ownership. An administratively-up interface with a failed datapath still
needs SerDes shutdown, sleep pinctrl and PHY PM handling. Only quiesce
queues which are actually running, and preserve the resource state so
resume cannot restart queues whose resources were released.

A platform suspend or early resume failure can leave core sleep state
pending without a successful system resume before close. Share the
pinctrl/PMT restoration between resume and close, without restarting the
link or datapath. Use the installed wake state rather than a subsequently
changed WoL setting. Retain the pending marker on restoration errors and
retry on open after acquiring runtime PM; a successful datapath open must
not simply discard outstanding sleep cleanup.

A failed datapath cannot promise a working MAC WoL path and may have
released its wake IRQ. Reject suspend with -EBUSY in that case, before
changing hardware or invoking platform suspend, rather than silently
losing the configured wake source. Ordinary down/up can recover the
interface. PHY-only WoL does not require this MAC wake path.

The platform noirq callbacks must also distinguish ownership from IFF_UP:
XDP cleanup may already have released the PTP clock reference. Do not
disable that reference twice or acquire a new one on resume, while still
performing runtime-PM bus-clock transitions.

Fixes: 3470079687448 ("net: ethernet: stmicro: stmmac: permit MTU change with interface up")
Fixes: 6896c2449a18 ("net: stmmac: Check stmmac_hw_setup() in stmmac_resume()")
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac.h       |  13 ++
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  | 215 ++++++++++++++++-----
 .../net/ethernet/stmicro/stmmac/stmmac_platform.c  |  19 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_xdp.c   |   8 +-
 4 files changed, 193 insertions(+), 62 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac.h b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
index 7582fca63741..b35b554e4ab7 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac.h
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
@@ -258,6 +258,15 @@ struct stmmac_msi {
 	char int_name_tx_irq[MTL_MAX_TX_QUEUES][IFNAMSIZ + 18];
 };
 
+enum stmmac_datapath_state {
+	/* No IRQs or DMA allocations owned by a successful open. */
+	STMMAC_DATAPATH_DOWN,
+	/* Resources allocated, NAPI enabled. */
+	STMMAC_DATAPATH_RUNNING,
+	/* Resources retained, NAPI and DMA stopped; also after failed resume. */
+	STMMAC_DATAPATH_SUSPENDED,
+};
+
 struct stmmac_priv {
 	/* Frequently used values are kept adjacent for cache effect */
 	u32 tx_coal_frames[MTL_MAX_TX_QUEUES];
@@ -281,6 +290,10 @@ struct stmmac_priv {
 	struct mutex lock;
 
 	struct stmmac_dma_conf dma_conf;
+	/* IRQ/DMA ownership and NAPI state, serialized by RTNL. */
+	enum stmmac_datapath_state datapath;
+	/* Core sleep sequence completed, independently of datapath ownership. */
+	bool hw_suspended;
 
 	/* Generic channel for NAPI */
 	struct stmmac_channel channel[STMMAC_CH_MAX];
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 4f3d452c3503..43a6154fcf6d 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -4127,6 +4127,37 @@ stmmac_setup_dma_desc(struct stmmac_priv *priv, unsigned int mtu)
 	return ERR_PTR(ret);
 }
 
+/* Finish core sleep state even if the platform resume callback failed. */
+static int stmmac_resume_hw(struct stmmac_priv *priv)
+{
+	int ret;
+
+	if (!priv->hw_suspended)
+		return 0;
+
+	/* Use the state installed by suspend, not a subsequently changed WoL
+	 * setting. Clear PMT even when a different device caused the wakeup.
+	 */
+	if (priv->irq_wake) {
+		mutex_lock(&priv->lock);
+		stmmac_pmt(priv, priv->hw, 0);
+		mutex_unlock(&priv->lock);
+		priv->irq_wake = 0;
+	} else {
+		ret = pinctrl_pm_select_default_state(priv->device);
+		if (ret)
+			return ret;
+		if (priv->mii) {
+			ret = stmmac_mdio_reset(priv->mii);
+			if (ret)
+				return ret;
+		}
+	}
+	priv->hw_suspended = false;
+
+	return 0;
+}
+
 /**
  *  __stmmac_open - open entry point of the driver
  *  @dev : pointer to the device structure.
@@ -4181,6 +4212,7 @@ static int __stmmac_open(struct net_device *dev,
 	stmmac_enable_all_queues(priv);
 	netif_tx_start_all_queues(priv->dev);
 	stmmac_enable_all_dma_irq(priv);
+	priv->datapath = STMMAC_DATAPATH_RUNNING;
 
 	return 0;
 
@@ -4192,6 +4224,8 @@ static int __stmmac_open(struct net_device *dev,
 
 	stmmac_release_ptp(priv);
 init_error:
+	stmmac_stop_all_dma(priv);
+	stmmac_mac_set(priv, priv->ioaddr, false);
 	return ret;
 }
 
@@ -4213,6 +4247,10 @@ static int stmmac_open(struct net_device *dev)
 	if (ret < 0)
 		goto err_dma_resources;
 
+	ret = stmmac_resume_hw(priv);
+	if (ret)
+		goto err_runtime_pm;
+
 	ret = stmmac_init_phy(dev);
 	if (ret)
 		goto err_runtime_pm;
@@ -4246,25 +4284,38 @@ static int stmmac_open(struct net_device *dev)
 	return ret;
 }
 
-static void __stmmac_release(struct net_device *dev)
+/* Quiesce NAPI and transmit queues without releasing their resources. */
+static void stmmac_quiesce(struct stmmac_priv *priv)
 {
-	struct stmmac_priv *priv = netdev_priv(dev);
 	u8 chan;
 
-	/* Stop and disconnect the PHY */
-	phylink_stop(priv->phylink);
-
 	stmmac_disable_all_queues(priv);
 
 	for (chan = 0; chan < priv->plat->tx_queues_to_use; chan++)
 		hrtimer_cancel(&priv->dma_conf.tx_queue[chan].txtimer);
 
-	netif_tx_disable(dev);
+	netif_tx_disable(priv->dev);
+}
+
+static void __stmmac_release(struct net_device *dev)
+{
+	struct stmmac_priv *priv = netdev_priv(dev);
+
+	/* A failed MTU reopen has already released the data path. */
+	if (priv->datapath == STMMAC_DATAPATH_DOWN)
+		return;
+
+	phylink_stop(priv->phylink);
+
+	/* Suspend retains the resources, but has already stopped activity. */
+	if (priv->datapath == STMMAC_DATAPATH_RUNNING)
+		stmmac_quiesce(priv);
+	priv->datapath = STMMAC_DATAPATH_DOWN;
 
 	/* Free the IRQ lines */
 	stmmac_free_irq(dev, REQ_IRQ_ERR_ALL, 0);
 
-	/* Stop TX/RX DMA and clear the descriptors */
+	/* Stop TX/RX DMA after draining IRQ handlers which can restart it. */
 	stmmac_stop_all_dma(priv);
 
 	/* Release and free the Rx/Tx resources */
@@ -4285,6 +4336,15 @@ static void __stmmac_release(struct net_device *dev)
 static int stmmac_release(struct net_device *dev)
 {
 	struct stmmac_priv *priv = netdev_priv(dev);
+	int ret;
+
+	/* Resume may have failed before restoring pins or disabling MAC wake.
+	 * Complete that cleanup without restarting the link or the datapath.
+	 * If it fails, keep hw_suspended set so a fresh open can retry it.
+	 */
+	ret = stmmac_resume_hw(priv);
+	if (ret)
+		netdev_err(dev, "failed to restore hardware sleep state: %d\n", ret);
 
 	/* If the PHY or MAC has WoL enabled, then the PHY will not be
 	 * suspended when phylink_stop() is called below. Set the PHY
@@ -4298,6 +4358,8 @@ static int stmmac_release(struct net_device *dev)
 	stmmac_legacy_serdes_power_down(priv);
 	phylink_disconnect_phy(priv->phylink);
 	pm_runtime_put(priv->device);
+	/* Allow a fresh open after a failed MTU reopen or resume. */
+	netif_device_attach(dev);
 
 	return 0;
 }
@@ -6177,6 +6239,11 @@ static int stmmac_change_mtu(struct net_device *dev, int new_mtu)
 		if (ret) {
 			free_dma_desc_resources(priv, dma_conf);
 			kfree(dma_conf);
+			/*
+			 * Keep the administrative state and PHY/PM ownership until
+			 * ndo_stop(), but prevent use of the released data path.
+			 */
+			netif_device_detach(dev);
 			netdev_err(priv->dev, "failed reopening the interface after MTU change\n");
 			return ret;
 		}
@@ -6425,6 +6492,8 @@ static int stmmac_setup_tc_block_cb(enum tc_setup_type type, void *type_data,
 
 	if (!tc_cls_can_offload_and_chain0(priv->dev, type_data))
 		return ret;
+	if (!netif_device_present(priv->dev))
+		return -ENETDOWN;
 
 	__stmmac_disable_all_queues(priv);
 
@@ -6542,12 +6611,14 @@ static int stmmac_rings_status_show(struct seq_file *seq, void *v)
 {
 	struct net_device *dev = seq->private;
 	struct stmmac_priv *priv = netdev_priv(dev);
-	u8 rx_count = priv->plat->rx_queues_to_use;
-	u8 tx_count = priv->plat->tx_queues_to_use;
-	u8 queue;
+	u8 rx_count, tx_count, queue;
 
-	if ((dev->flags & IFF_UP) == 0)
-		return 0;
+	rtnl_lock();
+	if (priv->datapath == STMMAC_DATAPATH_DOWN)
+		goto out_unlock;
+
+	rx_count = priv->plat->rx_queues_to_use;
+	tx_count = priv->plat->tx_queues_to_use;
 
 	for (queue = 0; queue < rx_count; queue++) {
 		struct stmmac_rx_queue *rx_q = &priv->dma_conf.rx_queue[queue];
@@ -6581,6 +6652,8 @@ static int stmmac_rings_status_show(struct seq_file *seq, void *v)
 		}
 	}
 
+out_unlock:
+	rtnl_unlock();
 	return 0;
 }
 DEFINE_SHOW_ATTRIBUTE(stmmac_rings_status);
@@ -6962,6 +7035,18 @@ static int stmmac_bpf(struct net_device *dev, struct netdev_bpf *bpf)
 {
 	struct stmmac_priv *priv = netdev_priv(dev);
 
+	if (bpf->command != XDP_SETUP_PROG &&
+	    bpf->command != XDP_SETUP_XSK_POOL)
+		return -EOPNOTSUPP;
+
+	/*
+	 * Pool removal must succeed even after a failed resume. Release the
+	 * suspended rings before their pool or XDP buffer layout can change.
+	 * Leave the interface detached until it is closed and reopened.
+	 */
+	if (priv->datapath == STMMAC_DATAPATH_SUSPENDED)
+		__stmmac_release(dev);
+
 	switch (bpf->command) {
 	case XDP_SETUP_PROG:
 		return stmmac_xdp_set_prog(priv, bpf->prog, bpf->extack);
@@ -6992,6 +7077,10 @@ static int stmmac_xdp_xmit(struct net_device *dev, int num_frames,
 	nq = netdev_get_tx_queue(priv->dev, queue);
 
 	__netif_tx_lock(nq, cpu);
+	if (unlikely(!netif_device_present(dev) || netif_tx_queue_stopped(nq))) {
+		__netif_tx_unlock(nq);
+		return -ENETDOWN;
+	}
 	/* Avoids TX time-out as we are sharing with slow path */
 	txq_trans_cond_update(nq);
 
@@ -7364,6 +7453,9 @@ static void stmmac_reset_subtask(struct stmmac_priv *priv)
 	netdev_err(priv->dev, "Reset adapter.\n");
 
 	rtnl_lock();
+	if (!netif_device_present(priv->dev))
+		goto out_unlock;
+
 	netif_trans_update(priv->dev);
 	while (test_and_set_bit(STMMAC_RESETING, &priv->state))
 		usleep_range(1000, 2000);
@@ -7373,6 +7465,7 @@ static void stmmac_reset_subtask(struct stmmac_priv *priv)
 	dev_open(priv->dev, NULL);
 	clear_bit(STMMAC_DOWN, &priv->state);
 	clear_bit(STMMAC_RESETING, &priv->state);
+out_unlock:
 	rtnl_unlock();
 }
 
@@ -8193,34 +8286,41 @@ EXPORT_SYMBOL_GPL(stmmac_dvr_remove);
 /**
  * stmmac_suspend - suspend callback
  * @dev: device pointer
- * Description: this is the function to suspend the device and it is called
- * by the platform driver to stop the network queue, release the resources,
- * program the PMT register (for WoL), clean and release driver resources.
+ * Description: stop network activity and program hardware for system sleep,
+ * preserving any datapath resources still owned for resume or close.
  */
 int stmmac_suspend(struct device *dev)
 {
 	struct net_device *ndev = dev_get_drvdata(dev);
 	struct stmmac_priv *priv = netdev_priv(ndev);
-	u8 chan;
 
-	if (!ndev || !netif_running(ndev))
+	rtnl_lock();
+	if (!netif_running(ndev) || priv->hw_suspended) {
+		rtnl_unlock();
 		goto suspend_bsp;
+	}
+
+	/* A failed datapath cannot provide a working MAC wake path. It may
+	 * even have released its wake IRQ. Do not silently suspend without WoL.
+	 */
+	if (priv->wolopts && priv->datapath != STMMAC_DATAPATH_RUNNING) {
+		netdev_err(ndev, "cannot suspend failed datapath with MAC WoL enabled\n");
+		rtnl_unlock();
+		return -EBUSY;
+	}
 
 	mutex_lock(&priv->lock);
 
 	netif_device_detach(ndev);
 
-	stmmac_disable_all_queues(priv);
-
-	for (chan = 0; chan < priv->plat->tx_queues_to_use; chan++)
-		hrtimer_cancel(&priv->dma_conf.tx_queue[chan].txtimer);
+	if (priv->datapath == STMMAC_DATAPATH_RUNNING)
+		stmmac_quiesce(priv);
 
 	if (priv->eee_sw_timer_en) {
 		priv->tx_path_in_lpi_mode = false;
 		timer_delete_sync(&priv->eee_ctrl_timer);
 	}
 
-	/* Stop TX/RX DMA */
 	stmmac_stop_all_dma(priv);
 
 	stmmac_legacy_serdes_power_down(priv);
@@ -8236,12 +8336,14 @@ int stmmac_suspend(struct device *dev)
 
 	mutex_unlock(&priv->lock);
 
-	rtnl_lock();
 	phylink_suspend(priv->phylink, !!priv->wolopts);
-	rtnl_unlock();
+	if (priv->datapath == STMMAC_DATAPATH_RUNNING)
+		priv->datapath = STMMAC_DATAPATH_SUSPENDED;
+	priv->hw_suspended = true;
 
 	if (stmmac_fpe_supported(priv))
 		ethtool_mmsv_stop(&priv->fpe_cfg.mmsv);
+	rtnl_unlock();
 
 suspend_bsp:
 	if (priv->plat->suspend)
@@ -8305,35 +8407,35 @@ int stmmac_resume(struct device *dev)
 			return ret;
 	}
 
-	if (!netif_running(ndev))
-		return 0;
+	rtnl_lock();
+	if (!netif_running(ndev)) {
+		ret = 0;
+		goto out_unlock;
+	}
 
-	/* Power Down bit, into the PM register, is cleared
-	 * automatically as soon as a magic packet or a Wake-up frame
-	 * is received. Anyway, it's better to manually clear
-	 * this bit because it can generate problems while resuming
-	 * from another devices (e.g. serial console).
-	 */
-	if (priv->wolopts) {
-		mutex_lock(&priv->lock);
-		stmmac_pmt(priv, priv->hw, 0);
-		mutex_unlock(&priv->lock);
-		priv->irq_wake = 0;
-	} else {
-		pinctrl_pm_select_default_state(priv->device);
-		/* reset the phy so that it's ready */
-		if (priv->mii)
-			stmmac_mdio_reset(priv->mii);
+	if (priv->hw_suspended) {
+		ret = stmmac_resume_hw(priv);
+		if (ret)
+			goto out_unlock;
+
+		/* Terminate PM speed control without restarting a datapath
+		 * whose IRQs or rings were released before system sleep.
+		 */
+		if (priv->datapath != STMMAC_DATAPATH_SUSPENDED)
+			phylink_stop(priv->phylink);
+	}
+
+	if (priv->datapath != STMMAC_DATAPATH_SUSPENDED) {
+		ret = 0;
+		goto out_unlock;
 	}
 
 	if (!(priv->plat->flags & STMMAC_FLAG_SERDES_UP_AFTER_PHY_LINKUP)) {
 		ret = stmmac_legacy_serdes_power_up(priv);
 		if (ret < 0)
-			return ret;
+			goto out_unlock;
 	}
 
-	rtnl_lock();
-
 	/* Prepare the PHY to resume, ensuring that its clocks which are
 	 * necessary for the MAC DMA reset to complete are running
 	 */
@@ -8349,10 +8451,7 @@ int stmmac_resume(struct device *dev)
 	ret = stmmac_hw_setup(ndev);
 	if (ret < 0) {
 		netdev_err(priv->dev, "%s: Hw setup failed\n", __func__);
-		stmmac_legacy_serdes_power_down(priv);
-		mutex_unlock(&priv->lock);
-		rtnl_unlock();
-		return ret;
+		goto error_stop_dma;
 	}
 
 	stmmac_init_timestamping(priv);
@@ -8374,11 +8473,25 @@ int stmmac_resume(struct device *dev)
 	 * workqueue thread, which will race with initialisation.
 	 */
 	phylink_resume(priv->phylink);
-	rtnl_unlock();
-
+	priv->datapath = STMMAC_DATAPATH_RUNNING;
 	netif_device_attach(ndev);
+	rtnl_unlock();
 
 	return 0;
+
+error_stop_dma:
+	stmmac_stop_all_dma(priv);
+	stmmac_mac_set(priv, priv->ioaddr, false);
+	stmmac_legacy_serdes_power_down(priv);
+	mutex_unlock(&priv->lock);
+	/*
+	 * Keep the suspended data path detached. A later resume may retry, or
+	 * ndo_stop() can release its resources without disabling NAPI again.
+	 */
+out_unlock:
+	rtnl_unlock();
+
+	return ret;
 }
 EXPORT_SYMBOL_GPL(stmmac_resume);
 
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
index 6128ed1bd521..9bd622517389 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
@@ -958,8 +958,9 @@ static int __maybe_unused stmmac_pltfr_noirq_suspend(struct device *dev)
 		return 0;
 
 	if (!priv->wolopts) {
-		/* Disable clock in case of PWM is off */
-		clk_disable_unprepare(priv->plat->clk_ptp_ref);
+		/* A detached datapath may already have released its PTP clock. */
+		if (priv->datapath != STMMAC_DATAPATH_DOWN)
+			clk_disable_unprepare(priv->plat->clk_ptp_ref);
 
 		ret = pm_runtime_force_suspend(dev);
 		if (ret)
@@ -984,12 +985,14 @@ static int __maybe_unused stmmac_pltfr_noirq_resume(struct device *dev)
 		if (ret)
 			return ret;
 
-		ret = clk_prepare_enable(priv->plat->clk_ptp_ref);
-		if (ret < 0) {
-			netdev_warn(priv->dev,
-				    "failed to enable PTP reference clock: %pe\n",
-				    ERR_PTR(ret));
-			return ret;
+		if (priv->datapath != STMMAC_DATAPATH_DOWN) {
+			ret = clk_prepare_enable(priv->plat->clk_ptp_ref);
+			if (ret < 0) {
+				netdev_warn(priv->dev,
+					    "failed to enable PTP reference clock: %pe\n",
+					    ERR_PTR(ret));
+				return ret;
+			}
 		}
 	}
 
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_xdp.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_xdp.c
index d7e4db7224b0..909219775507 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_xdp.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_xdp.c
@@ -31,7 +31,8 @@ static int stmmac_xdp_enable_pool(struct stmmac_priv *priv,
 		return err;
 	}
 
-	need_update = netif_running(priv->dev) && stmmac_xdp_is_enabled(priv);
+	need_update = priv->datapath == STMMAC_DATAPATH_RUNNING &&
+		      stmmac_xdp_is_enabled(priv);
 
 	if (need_update) {
 		napi_disable(&ch->rx_napi);
@@ -69,7 +70,8 @@ static int stmmac_xdp_disable_pool(struct stmmac_priv *priv, u16 queue)
 	if (!pool)
 		return -EINVAL;
 
-	need_update = netif_running(priv->dev) && stmmac_xdp_is_enabled(priv);
+	need_update = priv->datapath == STMMAC_DATAPATH_RUNNING &&
+		      stmmac_xdp_is_enabled(priv);
 
 	if (need_update) {
 		napi_disable(&ch->rxtx_napi);
@@ -107,7 +109,7 @@ int stmmac_xdp_set_prog(struct stmmac_priv *priv, struct bpf_prog *prog,
 	bool need_update;
 	bool if_running;
 
-	if_running = netif_running(dev);
+	if_running = priv->datapath == STMMAC_DATAPATH_RUNNING;
 
 	if (prog && dev->mtu > ETH_DATA_LEN) {
 		/* For now, the driver doesn't support XDP functionality with

-- 
2.53.0

