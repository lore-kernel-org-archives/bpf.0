Received: from mail-oi2-f12.google.com (mail-oi2-f12.google.com [74.125.231.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96F86247280
	for <bpf@vger.kernel.org>; Tue, 22 Sep 2026 23:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790119687; cv=none; b=ZiTg/C6XWng2TS5DEufsrJNQr7ZHhiuOn9rACFtS/xtDSiOKqc0dFPXHcD70E3e+xSWWHatm2d4Knb2jcBdovhOt4/TF55h673ISZIkIG87eFUYigG39U44iyQKIx9sIvQ6DUkH4Iwmt2kdPrXcMHzUy8tEID6R1qpyQV7bXlrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790119687; c=relaxed/simple;
	bh=g88I3ajhZgKqEmtd7VAbLAZTdsXkJ8eCKI90a/8kWJU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mC43UVPHuDr/bNIvFQqWdxeih9ai87/pWn2L5qhaTxtd4HXs+YSQIJ5yBMgxwEnJ1/0jh9A7SVTN0DiNQ2j7PfNRo8ULu/0AGwMnmdUSiXh77YHY3CFvHlL0KeR3Mh1RwYe7ZX8UIUL0FZeE3OZkaCYoFJMFukpsuJZ9/lgPSvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=n3pgSE5A; arc=none smtp.client-ip=74.125.231.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n3pgSE5A"
Received: by mail-oi2-f12.google.com with SMTP id 5614622812f47-4b5c61966d0so266496b6e.3
        for <bpf@vger.kernel.org>; Tue, 22 Sep 2026 16:27:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790119669; x=1790724469; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Fksfzl4IPMgXKipiR4axd7m3k1B1K7tHRQ5FWUZko78=;
        b=n3pgSE5AISpszTqari+BuJpKG+EjQAVfr7lcuwKGTfuCVcoKxHo9DtJN3X3qrp92gL
         GgQWmdI1JGc/EyKewZWHYk7rECySWYPgZ7AWdUuwUWW3xwvlfBIFxowBpCFTy0LeFUhB
         CYUgCb+AKmZOoVXYmqcX8vSSymD/HH5VCuhOr/x+mdVgIDjrSU3sW1PrPRb7RksqVon+
         Ax1UHgelC/1823rbg1mZZq3E6jiPynw4RCeNcE36+80afiZG3iDV9KZg9hldWUj9950m
         IOoQipykDRCypZvJVSWZEg5Bi4BTtDmHU2vpPEIK078O4NxG1woJBFrxrl5wEzCs6zeC
         UPhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790119669; x=1790724469;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Fksfzl4IPMgXKipiR4axd7m3k1B1K7tHRQ5FWUZko78=;
        b=zzMZa1txPv6aORRfk5x0Nmud1lYuZLODUzsUitae6S3LlLQhMXEeQp/Vd4xE/sVeJ5
         oZqfdt+kiueVBZHfuqcz6WIuZ+2EQkqbjz2Ip4tmiJQUG56rtHZj6ylm5gKyFW7h9uLO
         xjrI0v+zVYd5cW4nbvhMZyNSxLTDGeHtLpB/+UdK/leWmPeYlmABAe+CwpsDSX1CU3km
         hg1oZn54SEqjaKxQoVsQj1DIQukkejqQuh4RJhmBv/J743ED32FasjfriMGTw5FxqXmJ
         dz/bXLysBfNMs6ICjx9wQlW7eyBMVcciuB9zrl0gok1SDAsZlZm5HrokER1IjAI5I0bW
         OyXQ==
X-Forwarded-Encrypted: i=1; AKwUvBxBgJ1vSyIf1WGXgKYyG+UUXM2o++qKQ/ZKtHMKrQzY30sj1tMG+qHlbj6ACMVNWeemO8s=@vger.kernel.org
X-Gm-Message-State: AFuF++mTIaiFKKT4e6tN4OGtqi40KBqAEUy8UYDhy6Ddttpn/hpP7TKh
	42nRj1XO+IM5rXt9Muxegn5HDxYLm6GjNarEj4aFptQkaiIxmhMl3wxq
X-Gm-Gg: AYBFou3xkFm7/NjWphBt8Gtcb1IZNklrSybGtHvh27mtloOTs0AXKoe+kW+tCtS2CeN
	W/y6do/NXdlpOVD9Hu8twjBvpG0aaN7X9eYR3zsjYNee/cUZ4BAOiab2R7vj5ff7fTMok5x1XHh
	YqQzqbzPbrflVoqLGhF15d0+Jy2L6P33Ct41uTkdcbtOYJt2rBrzFzHYhRQzDJRx3/7NRWL+tVa
	Lj2CuYYKSHOv2YioQUs8RT7aj2rv6opFUboi6HqKEQcaOzvgATEwrEfuO4+urRP4Ilej4AEtVYs
	dnUQqe+sQ0QrC3CMnDhd0cTxiWiBQAkBB52C6RYMso5DJPEBBhE8IyOgiz33v8zR0NtYu3+Y3hM
	uMyQguJusUBd+Z4QEImSsqG06w7uBSjJnWabRRPhgF1v7Lo4ky5nF0qnq5de8dsao1lUnwyUOat
	osD8yWNURLp+67OanzLhNf5HEJ7F6bUBpy6W0IiLvqjQ9HdCXAoCIRYppGBg9uDak+P8AB43QMW
	BxyqO852MbHyTPSDH/mPqs+uB+a2zhHv1b40Kt/LJD1Xn1ruHAd+2X55j+MDeKyqvRDs9gTHhRv
	HcVzpZVGufLqm7evU8fGgFp9hoJunx3+0CkuLM2jFG5D++gDwwqVpvi4HXSXzm4m7r5MrS+f/aT
	Yw9UEyxFhjVQvGDy2/dTEfA==
X-Received: by 2002:a05:6808:1645:b0:4c3:afa3:e417 with SMTP id 5614622812f47-4d5b66af2a9mr884663b6e.10.1790119668654;
        Tue, 22 Sep 2026 16:27:48 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-81603fc87cdsm1243053a34.13.2026.09.22.16.27.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 16:27:48 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Tue, 22 Sep 2026 17:27:41 -0600
Subject: [PATCH net v2 2/2] net: stmmac: keep datapath state coherent after
 reinitialization failure
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260922-submit-stmmac-reset-fixes-v1-v2-2-d92e609be996@gmail.com>
References: <20260922-submit-stmmac-reset-fixes-v1-v2-0-d92e609be996@gmail.com>
In-Reply-To: <20260922-submit-stmmac-reset-fixes-v1-v2-0-d92e609be996@gmail.com>
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
 Stanislav Fomichev <sdf@fomichev.me>
Cc: Richard Genoud <richard.genoud@bootlin.com>, 
 Alastair D'Silva <alastair@d-silva.org>, Maxime Ripard <mripard@kernel.org>, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org, 
 James Hilliard <james.hilliard1@gmail.com>
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
guard descriptor readback with RTNL and resource ownership, reject TC
queue reconfiguration while detached, and prevent deferred reset work
from reopening the failed interface. Check availability under the TX
queue lock before XDP transmission. XDP configuration must use the actual
datapath state rather than IFF_UP. In particular, AF_XDP pool removal
cannot be rejected: release any suspended rings before a socket's pool
is unmapped and freed, leaving recovery to a subsequent down/up cycle.

Fixes: 3470079687448 ("net: ethernet: stmicro: stmmac: permit MTU change with interface up")
Fixes: 6896c2449a18 ("net: stmmac: Check stmmac_hw_setup() in stmmac_resume()")
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac.h      |  11 ++
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 116 ++++++++++++++++------
 drivers/net/ethernet/stmicro/stmmac/stmmac_xdp.c  |   8 +-
 3 files changed, 103 insertions(+), 32 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac.h b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
index 7582fca63741..5bb92339cbde 100644
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
@@ -281,6 +290,8 @@ struct stmmac_priv {
 	struct mutex lock;
 
 	struct stmmac_dma_conf dma_conf;
+	/* IRQ/DMA ownership and NAPI state, serialized by RTNL. */
+	enum stmmac_datapath_state datapath;
 
 	/* Generic channel for NAPI */
 	struct stmmac_channel channel[STMMAC_CH_MAX];
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 1fb5f804ea23..7b423c87314c 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -4179,6 +4179,7 @@ static int __stmmac_open(struct net_device *dev,
 	stmmac_enable_all_queues(priv);
 	netif_tx_start_all_queues(priv->dev);
 	stmmac_enable_all_dma_irq(priv);
+	priv->datapath = STMMAC_DATAPATH_RUNNING;
 
 	return 0;
 
@@ -4190,6 +4191,8 @@ static int __stmmac_open(struct net_device *dev,
 
 	stmmac_release_ptp(priv);
 init_error:
+	stmmac_stop_all_dma(priv);
+	stmmac_mac_set(priv, priv->ioaddr, false);
 	return ret;
 }
 
@@ -4244,25 +4247,38 @@ static int stmmac_open(struct net_device *dev)
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
@@ -4296,6 +4312,8 @@ static int stmmac_release(struct net_device *dev)
 	stmmac_legacy_serdes_power_down(priv);
 	phylink_disconnect_phy(priv->phylink);
 	pm_runtime_put(priv->device);
+	/* Allow a fresh open after a failed MTU reopen or resume. */
+	netif_device_attach(dev);
 
 	return 0;
 }
@@ -6174,6 +6192,11 @@ static int stmmac_change_mtu(struct net_device *dev, int new_mtu)
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
@@ -6422,6 +6445,8 @@ static int stmmac_setup_tc_block_cb(enum tc_setup_type type, void *type_data,
 
 	if (!tc_cls_can_offload_and_chain0(priv->dev, type_data))
 		return ret;
+	if (!netif_device_present(priv->dev))
+		return -ENETDOWN;
 
 	__stmmac_disable_all_queues(priv);
 
@@ -6543,8 +6568,9 @@ static int stmmac_rings_status_show(struct seq_file *seq, void *v)
 	u8 tx_count = priv->plat->tx_queues_to_use;
 	u8 queue;
 
-	if ((dev->flags & IFF_UP) == 0)
-		return 0;
+	rtnl_lock();
+	if (priv->datapath == STMMAC_DATAPATH_DOWN)
+		goto out_unlock;
 
 	for (queue = 0; queue < rx_count; queue++) {
 		struct stmmac_rx_queue *rx_q = &priv->dma_conf.rx_queue[queue];
@@ -6578,6 +6604,8 @@ static int stmmac_rings_status_show(struct seq_file *seq, void *v)
 		}
 	}
 
+out_unlock:
+	rtnl_unlock();
 	return 0;
 }
 DEFINE_SHOW_ATTRIBUTE(stmmac_rings_status);
@@ -6959,6 +6987,18 @@ static int stmmac_bpf(struct net_device *dev, struct netdev_bpf *bpf)
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
@@ -6989,6 +7029,10 @@ static int stmmac_xdp_xmit(struct net_device *dev, int num_frames,
 	nq = netdev_get_tx_queue(priv->dev, queue);
 
 	__netif_tx_lock(nq, cpu);
+	if (unlikely(!netif_device_present(dev) || netif_tx_queue_stopped(nq))) {
+		__netif_tx_unlock(nq);
+		return -ENETDOWN;
+	}
 	/* Avoids TX time-out as we are sharing with slow path */
 	txq_trans_cond_update(nq);
 
@@ -7361,6 +7405,9 @@ static void stmmac_reset_subtask(struct stmmac_priv *priv)
 	netdev_err(priv->dev, "Reset adapter.\n");
 
 	rtnl_lock();
+	if (!netif_device_present(priv->dev))
+		goto out_unlock;
+
 	netif_trans_update(priv->dev);
 	while (test_and_set_bit(STMMAC_RESETING, &priv->state))
 		usleep_range(1000, 2000);
@@ -7370,6 +7417,7 @@ static void stmmac_reset_subtask(struct stmmac_priv *priv)
 	dev_open(priv->dev, NULL);
 	clear_bit(STMMAC_DOWN, &priv->state);
 	clear_bit(STMMAC_RESETING, &priv->state);
+out_unlock:
 	rtnl_unlock();
 }
 
@@ -8198,26 +8246,24 @@ int stmmac_suspend(struct device *dev)
 {
 	struct net_device *ndev = dev_get_drvdata(dev);
 	struct stmmac_priv *priv = netdev_priv(ndev);
-	u8 chan;
 
-	if (!ndev || !netif_running(ndev))
+	rtnl_lock();
+	if (priv->datapath != STMMAC_DATAPATH_RUNNING) {
+		rtnl_unlock();
 		goto suspend_bsp;
+	}
 
 	mutex_lock(&priv->lock);
 
 	netif_device_detach(ndev);
 
-	stmmac_disable_all_queues(priv);
-
-	for (chan = 0; chan < priv->plat->tx_queues_to_use; chan++)
-		hrtimer_cancel(&priv->dma_conf.tx_queue[chan].txtimer);
+	stmmac_quiesce(priv);
 
 	if (priv->eee_sw_timer_en) {
 		priv->tx_path_in_lpi_mode = false;
 		timer_delete_sync(&priv->eee_ctrl_timer);
 	}
 
-	/* Stop TX/RX DMA */
 	stmmac_stop_all_dma(priv);
 
 	stmmac_legacy_serdes_power_down(priv);
@@ -8233,12 +8279,12 @@ int stmmac_suspend(struct device *dev)
 
 	mutex_unlock(&priv->lock);
 
-	rtnl_lock();
 	phylink_suspend(priv->phylink, !!priv->wolopts);
-	rtnl_unlock();
+	priv->datapath = STMMAC_DATAPATH_SUSPENDED;
 
 	if (stmmac_fpe_supported(priv))
 		ethtool_mmsv_stop(&priv->fpe_cfg.mmsv);
+	rtnl_unlock();
 
 suspend_bsp:
 	if (priv->plat->suspend)
@@ -8302,8 +8348,11 @@ int stmmac_resume(struct device *dev)
 			return ret;
 	}
 
-	if (!netif_running(ndev))
-		return 0;
+	rtnl_lock();
+	if (priv->datapath != STMMAC_DATAPATH_SUSPENDED) {
+		ret = 0;
+		goto out_unlock;
+	}
 
 	/* Power Down bit, into the PM register, is cleared
 	 * automatically as soon as a magic packet or a Wake-up frame
@@ -8326,11 +8375,9 @@ int stmmac_resume(struct device *dev)
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
@@ -8346,10 +8393,7 @@ int stmmac_resume(struct device *dev)
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
@@ -8371,11 +8415,25 @@ int stmmac_resume(struct device *dev)
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

