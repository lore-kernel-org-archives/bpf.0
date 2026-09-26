Received: from mail-oo2-f38.google.com (mail-oo2-f38.google.com [74.125.231.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C456B3793CC
	for <bpf@vger.kernel.org>; Sat, 26 Sep 2026 15:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790437789; cv=none; b=s9hnt+b4Bo3oL5TflTg1/57+UKiXoJwjcWVq4sDnip+aceTlkdgYvAYtBX9iReerecXb60iVKucvMY0rXA337HsYkhEYdiQFUCbHNOUepq5IbnC+MXCIQqsBG21PFPoymXrICyPooaaY//FiWZ827th+7SF6jdN3b9pC8eRuhYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790437789; c=relaxed/simple;
	bh=QYZgFUIPbVdL1Or1COkJk/8mNxr76FljLzr30hkvvGg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=E4Sdv04kMwToKiPcXqmVISGxufDx+V0UUNfo6Gw9ay3E19Ea7RamWSWosWuJa4CJJIbldeU0IWuZXm80sf+DJQfbn6DJRL7zuqZwWMmt6PqbGaVHqAJAIYCh6JKkTp2SC67FVPEShdj5as1trZRSvvoBOcDenTJ1Pd/SgaQMBSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TvYpRyNL; arc=none smtp.client-ip=74.125.231.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TvYpRyNL"
Received: by mail-oo2-f38.google.com with SMTP id 46e09a7af769-8138dddb94bso1294847a34.2
        for <bpf@vger.kernel.org>; Sat, 26 Sep 2026 08:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790437779; x=1791042579; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vPb0nEPWL3asml1fL9I1iOUw0gKSkYXR2hPi85apTC4=;
        b=TvYpRyNLcT3axJu3squaO2ZLPuwQf1Jhoo/dKxwou6uyxPz9SUj8vU0DTXYFWrJmjs
         b+g+dFq+Rg0i8wgBampZiE+ca1+Pi+dVVYPDrn+A7vVwoUQDjxUUR9buVjT++W4P/kE+
         tqv4N8QZJc/SCgT55ymfA35fEg5tuEUYNr8bYnGrLu1SmigM8DRA/sDbbUmmqn+6qcP6
         SmDFBWOQwrysbu9jAP7YnvIom6cttMe/lz/IjoiSUjcrRUzl3zy84oRA5h9ykYdRwNCU
         EhuoePbIouZR9xD3HYUMnnZgKqLUJihVuG8+eJTCNkS1AiQ2dU/CdpJxVsbJZv6Or66n
         67Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790437779; x=1791042579;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vPb0nEPWL3asml1fL9I1iOUw0gKSkYXR2hPi85apTC4=;
        b=pibBtHK+mJc1pPKx59MYocI0waa30vWtOrIRDPC7L66KPtHa9DJm8OJaMUudU9DxdG
         SrOANYQijLnwormdaIuD3nQQn6iTc2b1CDj/udT2sGmMa4vwI8FgeO4numYjiM5R1qN9
         fBQoxLfrUDxQINaeY/oq7tasX6GWfu62/Na59qnF5u2P2SIynfS9OSoqSr6nDxmdAC+8
         mhvBg2ecZdIGaEx9f3q35vA9SwRws1pJ8zJI+12zCQatELyTPdpo5InDlMkW5rqpHMOC
         cept4TjTW00g5ZlgRNcNVPDO8zYKSD/YntOgt8yAIf5u0SFP0+8VhMJNIWkjhbcq5B/d
         uyDg==
X-Forwarded-Encrypted: i=1; AKwUvBxzLBC9HQTfjZXHbARfNOThyC9Y3t6v0rgnUmkP76fBU0EuMJh8rt7enGhXPLL7Ng+ZXqg=@vger.kernel.org
X-Gm-Message-State: AFuF++kxQnmK3OE35pcCUXr7h+AN8n24hivzTL0LJl8qtO0JiJtevbQN
	ymT4ZXfxD0jQfUz8fsfRoG25YxwYmXb1BG0jCJha5mM0dZtzMi7UlNAs
X-Gm-Gg: AYBFou2R23mX188+UnaWPIuhRzJZe0M20w0QnB3Lv7bZoTMRMw+shyCSlszBIPoj45o
	rKSz68MsRoKOEqM1jGC2NVbPKl6OXozncI1cA+TNcMVFR41bgS96QRzjV7xfgj6VK/pYCbY1N10
	rnJEcOQSbtF85co43C8o+mCt0j7wdMvJBTc/Tx5+oz12E0TlRi5424RNbHmGsdHQCald6xMphwh
	3+dtguiPXGgINV2tBB/yNWrJN44Fdo33Twb989Qvao3nSy+cWtmagkZQAJHqnNuXf7VMpevtr0A
	v6OTBIAjV35/gQWgl3prnhuUVH3lQQkpLJH31p0no8nLXpOh0Ff3IPz2FaAkksX1xUo4gwY7JZn
	CkeLuj3+wVz3L3brRycChQ47he49nm/4r+rmNjQ+Fq5IT+phV8BWFAPD8p2hzEX5HR0jntlygVJ
	HPqQghttaZ5KYLCTmNEbjAudt2P/3qNA3WYVPTrNXf2VvSkJ1IMEI+VocR8XyTlD59oXIZW3l1i
	nRQP7CXwezdnIHBuWDZwaTZ2bN4cvc7zrd2WK5rnh7RDEzsAPUWEDPAWY/HdqyVolpinu0hSTEH
	JmHWYzMWP6pm0Gd4EtAhi8gm29bNg/uXaoVEpRdRr3aZhr2Sxhxnsy1YdosKyuJuptv6R9T65Rf
	CnFgumEqoIcfZeihbq1QIasNtRC+1jsU=
X-Received: by 2002:a05:6820:1c87:b0:6b1:705d:b29e with SMTP id 006d021491bc7-6d43f7a5e78mr8696086eaf.26.1790437778541;
        Sat, 26 Sep 2026 08:49:38 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-818e98b16d4sm5442366a34.26.2026.09.26.08.49.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 08:49:37 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sat, 26 Sep 2026 09:49:04 -0600
Subject: [PATCH net v4 09/15] net: stmmac: track datapath and power
 ownership across failed reopening
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260926-submit-stmmac-reset-fixes-v1-v4-9-ec1c0250b3c9@gmail.com>
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

Track allocated rings, IRQs and NAPI independently of IFF_UP and of
system sleep. Leave failed live reopening detached while the successful
ndo_open still owns its PHY attachment and runtime-PM reference;
ordinary down/up can recover without duplicate NAPI shutdown or PM puts.

Convert every live reopen consumer together: MTU, XDP program changes
and ethtool ring/channel changes. Restore old settings on error and
publish queue counts only after setup succeeds. XDP removal must release
its program even if rebuilding the non-XDP datapath fails. Use phylink
link replay for successful XDP rebuilding so the PHY is not stopped or
renegotiated.

Keep core sleep cleanup separate from platform and clock restoration.
Serialize noirq clock ownership and retry pending power transitions
before accessing MMIO. If restoration fails, block MAC, MDIO, PCS, IRQ
and PHC register accesses and finish only software cleanup. Check MAC
WoL viability before skipping an already completed core sleep sequence.

Close must reattach the netdev so ndo_open can retry power restoration.
Reject ethtool, timestamp, MAC-address, feature and qdisc installation
requests while registers remain inaccessible. Drain receive-filter work
under the address lock before power removal. VLAN and qdisc teardown
still clear their software state without touching unpowered registers.

Permit flower and u32 destruction while down or detached, clearing cached
rules without disabling already-stopped NAPI or accessing registers. TC
forgets deleted filters even when the driver returns an error, so rejecting
destruction would leave stale rules to be replayed on recovery. Keep
installation-only feature and RSS checks out of the destruction path.

Guard non-netdev-detach consumers, including TC, descriptor readback,
XDP transmission and reset work. Freeze deferred XSK teardown before
sleep through the prerequisite XSK change. Preserve PHY ownership on
failed ethtool reopen and stop a PHY temporarily resumed to supply the
MAC reset clock.

Fixes: 3470079687448 ("net: ethernet: stmicro: stmmac: permit MTU change with interface up")
Fixes: 6896c2449a18 ("net: stmmac: Check stmmac_hw_setup() in stmmac_resume()")
Fixes: ac746c8520d9 ("net: stmmac: enhance XDP ZC driver level switching performance")
Fixes: aa042f60e496 ("net: stmmac: Add support to Ethtool get/set ring parameters")
Fixes: 0366f7e06a6b ("net: stmmac: add ethtool support for get/set channels")
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-tegra.c  |   5 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac.h       |  29 ++
 .../net/ethernet/stmicro/stmmac/stmmac_ethtool.c   |  11 +
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  | 557 ++++++++++++++++++---
 drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c  |  15 +
 drivers/net/ethernet/stmicro/stmmac/stmmac_pcs.c   |   3 +-
 .../net/ethernet/stmicro/stmmac/stmmac_platform.c  |  38 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c    |  96 ++--
 drivers/net/ethernet/stmicro/stmmac/stmmac_vlan.c  |   6 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_xdp.c   |  39 +-
 10 files changed, 640 insertions(+), 159 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-tegra.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-tegra.c
index 4ede4420c93b..64a55c72c15c 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-tegra.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-tegra.c
@@ -105,8 +105,9 @@ static int __maybe_unused tegra_mgbe_resume(struct device *dev)
 	}
 
 	err = stmmac_resume(dev);
-	if (err < 0)
-		clk_bulk_disable_unprepare(ARRAY_SIZE(mgbe_clks), mgbe->clks);
+	/* Core resume failure retains the suspended datapath for retry or
+	 * close. Keep its register interface powered until that cleanup.
+	 */
 
 	return err;
 }
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac.h b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
index 3365ed237953..2fa7b18eb9a4 100644
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
@@ -281,6 +290,18 @@ struct stmmac_priv {
 	struct mutex lock;
 
 	struct stmmac_dma_conf *dma_conf;
+	/* IRQ/DMA ownership and NAPI state, serialized by RTNL. */
+	enum stmmac_datapath_state datapath;
+	/* Core sleep sequence completed, independently of datapath ownership. */
+	bool hw_suspended;
+	/* System PM blocks MMIO until power restoration has completed. */
+	bool hw_unavailable;
+	bool bsp_suspended;
+	bool bus_clks_suspended;
+	bool ptp_clock_enabled;
+	bool ptp_clock_suspended;
+	/* Clock ownership can also change in noirq PM, without RTNL. */
+	struct mutex pm_mutex;
 
 	/* Generic channel for NAPI */
 	struct stmmac_channel channel[STMMAC_CH_MAX];
@@ -402,6 +423,7 @@ extern const struct dev_pm_ops stmmac_simple_pm_ops;
 int stmmac_mdio_unregister(struct net_device *ndev);
 int stmmac_mdio_register(struct net_device *ndev);
 int stmmac_mdio_reset(struct mii_bus *mii);
+int stmmac_resume_clocks(struct stmmac_priv *priv);
 void stmmac_mdio_lock(struct stmmac_priv *priv);
 void stmmac_mdio_unlock(struct stmmac_priv *priv);
 int stmmac_pcs_setup(struct net_device *ndev);
@@ -432,6 +454,13 @@ static inline bool stmmac_xdp_is_enabled(struct stmmac_priv *priv)
 	return !!priv->xdp_prog;
 }
 
+/* RTNL serializes TC callbacks with datapath and power transitions. */
+static inline bool stmmac_tc_active(struct stmmac_priv *priv)
+{
+	return priv->datapath == STMMAC_DATAPATH_RUNNING &&
+	       netif_device_present(priv->dev) && !priv->hw_unavailable;
+}
+
 void stmmac_disable_rx_queue(struct stmmac_priv *priv, u32 queue);
 void stmmac_enable_rx_queue(struct stmmac_priv *priv, u32 queue);
 void stmmac_disable_tx_queue(struct stmmac_priv *priv, u32 queue);
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
index 994350fcdbfa..6742401671ff 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
@@ -1090,7 +1090,18 @@ static void stmmac_get_mm_stats(struct net_device *ndev,
 	s->MACMergeHoldCount = mmc->mmc_tx_hold_req_cntr;
 }
 
+static int stmmac_ethtool_begin(struct net_device *dev)
+{
+	struct stmmac_priv *priv = netdev_priv(dev);
+
+	/* Close reattaches the netdev so open can retry power restoration.
+	 * Presence alone does not make registers accessible after failed resume.
+	 */
+	return priv->hw_unavailable ? -EHOSTDOWN : 0;
+}
+
 static const struct ethtool_ops stmmac_ethtool_ops = {
+	.begin = stmmac_ethtool_begin,
 	.supported_coalesce_params = ETHTOOL_COALESCE_USECS |
 				     ETHTOOL_COALESCE_MAX_FRAMES,
 	.get_drvinfo = stmmac_ethtool_getdrvinfo,
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index c4ba97d57b47..22a65c1c1681 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -653,6 +653,9 @@ static int stmmac_hwtstamp_set(struct net_device *dev,
 	u32 ts_master_en = 0;
 	u32 ts_event_en = 0;
 
+	if (priv->hw_unavailable)
+		return -EHOSTDOWN;
+
 	if (!(priv->dma_cap.time_stamp || priv->adv_ts)) {
 		NL_SET_ERR_MSG_MOD(extack, "No support for HW time stamping");
 		priv->hwts_tx_en = 0;
@@ -946,12 +949,16 @@ static void stmmac_setup_ptp(struct stmmac_priv *priv)
 	priv->ptp_extts = 0;
 	priv->ptp_blocked = false;
 
+	mutex_lock(&priv->pm_mutex);
 	ret = clk_prepare_enable(priv->plat->clk_ptp_ref);
-	if (ret < 0)
+	priv->ptp_clock_enabled = !ret;
+	mutex_unlock(&priv->pm_mutex);
+	if (ret < 0) {
 		netdev_warn(priv->dev,
 			    "failed to enable PTP reference clock: %pe\n",
 			    ERR_PTR(ret));
-
+		return;
+	}
 	if (stmmac_init_timestamping(priv) == 0)
 		stmmac_ptp_register(priv);
 }
@@ -959,7 +966,26 @@ static void stmmac_setup_ptp(struct stmmac_priv *priv)
 static void stmmac_release_ptp(struct stmmac_priv *priv)
 {
 	stmmac_ptp_unregister(priv);
-	clk_disable_unprepare(priv->plat->clk_ptp_ref);
+	mutex_lock(&priv->pm_mutex);
+	if (priv->ptp_clock_enabled) {
+		clk_disable_unprepare(priv->plat->clk_ptp_ref);
+		priv->ptp_clock_enabled = false;
+	}
+	/* A later noirq resume must not reacquire a released reference. */
+	priv->ptp_clock_suspended = false;
+	mutex_unlock(&priv->pm_mutex);
+}
+
+/* ptp_mutex excludes configuration and crosstimestamp operations. The
+ * spinlock also excludes atomic clock reads while changing this gate.
+ */
+static void stmmac_block_ptp(struct stmmac_priv *priv, bool block)
+{
+	unsigned long flags;
+
+	write_lock_irqsave(&priv->ptp_lock, flags);
+	WRITE_ONCE(priv->ptp_blocked, block);
+	write_unlock_irqrestore(&priv->ptp_lock, flags);
 }
 
 static void stmmac_legacy_serdes_power_down(struct stmmac_priv *priv)
@@ -1064,6 +1090,9 @@ static void stmmac_mac_link_down(struct phylink_config *config,
 {
 	struct stmmac_priv *priv = netdev_priv(to_net_dev(config->dev));
 
+	if (READ_ONCE(priv->hw_unavailable))
+		return;
+
 	stmmac_mac_set(priv, priv->ioaddr, false);
 	if (priv->dma_cap.eee)
 		stmmac_set_eee_pls(priv, priv->hw, false);
@@ -1188,10 +1217,12 @@ static void stmmac_mac_disable_tx_lpi(struct phylink_config *config)
 	netdev_dbg(priv->dev, "disable EEE\n");
 	priv->eee_sw_timer_en = false;
 	timer_delete_sync(&priv->eee_ctrl_timer);
-	stmmac_set_lpi_mode(priv, priv->hw, STMMAC_LPI_DISABLE, false, 0);
 	priv->tx_path_in_lpi_mode = false;
 
-	stmmac_set_eee_timer(priv, priv->hw, 0, STMMAC_DEFAULT_TWT_LS);
+	if (!READ_ONCE(priv->hw_unavailable)) {
+		stmmac_set_lpi_mode(priv, priv->hw, STMMAC_LPI_DISABLE, false, 0);
+		stmmac_set_eee_timer(priv, priv->hw, 0, STMMAC_DEFAULT_TWT_LS);
+	}
 	mutex_unlock(&priv->lock);
 }
 
@@ -3781,10 +3812,6 @@ static int stmmac_hw_setup(struct net_device *dev)
 		stmmac_enable_tbs(priv, priv->ioaddr, enable, chan);
 	}
 
-	/* Configure real RX and TX queues */
-	netif_set_real_num_rx_queues(dev, priv->plat->rx_queues_to_use);
-	netif_set_real_num_tx_queues(dev, priv->plat->tx_queues_to_use);
-
 	/* Start the ball rolling... */
 	stmmac_start_all_dma(priv);
 
@@ -4086,6 +4113,32 @@ static int stmmac_request_irq(struct net_device *dev)
 	return ret;
 }
 
+/* Drain registered handlers without disabling lines shared by other devices. */
+static void stmmac_synchronize_irq(struct stmmac_priv *priv)
+{
+	struct stmmac_msi *msi = priv->msi;
+	int irq = priv->dev->irq;
+	u32 i;
+
+	synchronize_irq(irq);
+	if (priv->wol_irq > 0 && priv->wol_irq != irq)
+		synchronize_irq(priv->wol_irq);
+	if (priv->sfty_irq > 0 && priv->sfty_irq != irq)
+		synchronize_irq(priv->sfty_irq);
+	if (!msi)
+		return;
+	if (msi->sfty_ce_irq > 0 && msi->sfty_ce_irq != irq)
+		synchronize_irq(msi->sfty_ce_irq);
+	if (msi->sfty_ue_irq > 0 && msi->sfty_ue_irq != irq)
+		synchronize_irq(msi->sfty_ue_irq);
+	for (i = 0; i < priv->plat->rx_queues_to_use; i++)
+		if (msi->rx_irq[i] > 0)
+			synchronize_irq(msi->rx_irq[i]);
+	for (i = 0; i < priv->plat->tx_queues_to_use; i++)
+		if (msi->tx_irq[i] > 0)
+			synchronize_irq(msi->tx_irq[i]);
+}
+
 /**
  *  stmmac_setup_dma_desc - Generate a dma_conf and allocate DMA queue
  *  @priv: driver private structure
@@ -4164,6 +4217,89 @@ stmmac_setup_dma_desc(struct stmmac_priv *priv, unsigned int mtu)
 	return ERR_PTR(ret);
 }
 
+/* The freezer excludes pool teardown and userspace from noirq callbacks.
+ * Outside system sleep these flags are changed under RTNL.
+ */
+int stmmac_resume_clocks(struct stmmac_priv *priv)
+{
+	int ret = 0;
+
+	mutex_lock(&priv->pm_mutex);
+	if (priv->bus_clks_suspended) {
+		ret = pm_runtime_force_resume(priv->device);
+		if (ret)
+			goto out;
+		priv->bus_clks_suspended = false;
+	}
+	if (priv->ptp_clock_suspended) {
+		ret = clk_prepare_enable(priv->plat->clk_ptp_ref);
+		if (ret)
+			goto out;
+		priv->ptp_clock_enabled = true;
+		priv->ptp_clock_suspended = false;
+	}
+out:
+	mutex_unlock(&priv->pm_mutex);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(stmmac_resume_clocks);
+
+static int stmmac_resume_power(struct stmmac_priv *priv, bool system_resume)
+{
+	bool pending = priv->bus_clks_suspended || priv->bsp_suspended ||
+		       priv->ptp_clock_suspended;
+	int ret;
+
+	ret = stmmac_resume_clocks(priv);
+	if (ret)
+		return ret;
+	if (priv->bsp_suspended && priv->plat->resume) {
+		ret = priv->plat->resume(priv->device, priv->plat->bsp_priv);
+		if (ret)
+			return ret;
+		priv->bsp_suspended = false;
+	}
+	/* A wrapper which powers the device outside these callbacks must
+	 * complete its own resume before core register access is possible.
+	 */
+	if (system_resume || pending)
+		WRITE_ONCE(priv->hw_unavailable, false);
+	return priv->hw_unavailable ? -EHOSTDOWN : 0;
+}
+
+/* Finish core sleep state only after its power dependencies are restored. */
+static int stmmac_resume_hw(struct stmmac_priv *priv)
+{
+	int ret;
+
+	if (!priv->hw_suspended)
+		return 0;
+	if (priv->hw_unavailable)
+		return -EHOSTDOWN;
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
@@ -4205,28 +4341,42 @@ static int __stmmac_open(struct net_device *dev,
 
 	stmmac_init_coalesce(priv);
 
-	phylink_start(priv->phylink);
-
 	stmmac_vlan_restore(priv);
 
 	ret = stmmac_request_irq(dev);
 	if (ret)
 		goto irq_error;
 
+	/* Publish the topology only when no other fallible setup remains.
+	 * The combined setter restores the old counts if an increase fails.
+	 */
+	ret = netif_set_real_num_queues(dev, priv->plat->tx_queues_to_use,
+					priv->plat->rx_queues_to_use);
+	if (ret) {
+		stmmac_free_irq(dev, REQ_IRQ_ERR_ALL, 0);
+		goto irq_error;
+	}
+
 	stmmac_enable_all_queues(priv);
 	netif_tx_start_all_queues(priv->dev);
 	stmmac_enable_all_dma_irq(priv);
+	priv->datapath = STMMAC_DATAPATH_RUNNING;
+	phylink_start(priv->phylink);
 
 	return 0;
 
 irq_error:
-	phylink_stop(priv->phylink);
-
 	for (chan = 0; chan < priv->plat->tx_queues_to_use; chan++)
 		hrtimer_cancel(&priv->dma_conf->tx_queue[chan].txtimer);
 
 	stmmac_release_ptp(priv);
 init_error:
+	/* Undo phylink_prepare_resume() even if hardware setup failed before
+	 * phylink_start(). Keep the PHY attachment and outer PM ownership.
+	 */
+	phylink_stop(priv->phylink);
+	stmmac_stop_all_dma(priv);
+	stmmac_mac_set(priv, priv->ioaddr, false);
 	return ret;
 }
 
@@ -4249,6 +4399,13 @@ static int stmmac_open(struct net_device *dev)
 	if (ret < 0)
 		goto err_dma_resources;
 
+	ret = stmmac_resume_power(priv, false);
+	if (ret)
+		goto err_runtime_pm;
+	ret = stmmac_resume_hw(priv);
+	if (ret)
+		goto err_runtime_pm;
+
 	ret = stmmac_init_phy(dev);
 	if (ret)
 		goto err_runtime_pm;
@@ -4312,23 +4469,36 @@ static void __stmmac_release(struct net_device *dev)
 {
 	struct stmmac_priv *priv = netdev_priv(dev);
 
+	/* A failed MTU reopen has already released the data path. */
+	if (priv->datapath == STMMAC_DATAPATH_DOWN)
+		return;
+
 	phylink_stop(priv->phylink);
-	stmmac_quiesce(priv);
+
+	/* Suspend retains the resources, but has already stopped activity. */
+	if (priv->datapath == STMMAC_DATAPATH_RUNNING)
+		stmmac_quiesce(priv);
+	priv->datapath = STMMAC_DATAPATH_DOWN;
 
 	/* Free the IRQ lines */
 	stmmac_free_irq(dev, REQ_IRQ_ERR_ALL, 0);
+
 	/* TX error IRQs can restart a queue after the first quiescence. */
 	stmmac_stop_tx_queues(priv);
 
-	/* Stop TX/RX DMA and clear the descriptors */
-	stmmac_stop_all_dma(priv);
+	/* Stop TX/RX DMA after draining IRQ handlers which can restart it. */
+	if (!priv->hw_unavailable) {
+		stmmac_stop_all_dma(priv);
+		/* Link resolution need not have reached mac_link_up() yet. */
+		stmmac_mac_set(priv, priv->ioaddr, false);
+	}
 
 	/* Release and free the Rx/Tx resources */
 	free_dma_desc_resources(priv, priv->dma_conf);
 
 	stmmac_release_ptp(priv);
 
-	if (stmmac_fpe_supported(priv))
+	if (!priv->hw_unavailable && stmmac_fpe_supported(priv))
 		ethtool_mmsv_stop(&priv->fpe_cfg.mmsv);
 }
 
@@ -4341,6 +4511,17 @@ static void __stmmac_release(struct net_device *dev)
 static int stmmac_release(struct net_device *dev)
 {
 	struct stmmac_priv *priv = netdev_priv(dev);
+	int ret;
+
+	/* Resume may have failed before restoring pins or disabling MAC wake.
+	 * Complete that cleanup without restarting the link or the datapath.
+	 * If it fails, keep hw_suspended set so a fresh open can retry it.
+	 */
+	ret = stmmac_resume_power(priv, false);
+	if (!ret)
+		ret = stmmac_resume_hw(priv);
+	if (ret)
+		netdev_err(dev, "failed to restore hardware sleep state: %d\n", ret);
 
 	/* If the PHY or MAC has WoL enabled, then the PHY will not be
 	 * suspended when phylink_stop() is called below. Set the PHY
@@ -4354,6 +4535,8 @@ static int stmmac_release(struct net_device *dev)
 	stmmac_legacy_serdes_power_down(priv);
 	phylink_disconnect_phy(priv->phylink);
 	pm_runtime_put(priv->device);
+	/* Allow a fresh open after a failed MTU reopen or resume. */
+	netif_device_attach(dev);
 
 	return 0;
 }
@@ -6185,6 +6368,9 @@ static void stmmac_set_rx_mode(struct net_device *dev)
 {
 	struct stmmac_priv *priv = netdev_priv(dev);
 
+	if (READ_ONCE(priv->hw_unavailable))
+		return;
+
 	stmmac_set_filter(priv, priv->hw, dev);
 }
 
@@ -6247,6 +6433,11 @@ static int stmmac_change_mtu(struct net_device *dev, int new_mtu)
 			priv->dma_conf = old_conf;
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
@@ -6290,6 +6481,9 @@ static int stmmac_set_features(struct net_device *netdev,
 {
 	struct stmmac_priv *priv = netdev_priv(netdev);
 
+	if (priv->hw_unavailable)
+		return -EHOSTDOWN;
+
 	/* Keep the COE Type in case of csum is supporting */
 	if (features & NETIF_F_RXCSUM)
 		priv->hw->rx_csum = priv->plat->rx_coe;
@@ -6377,6 +6571,12 @@ static irqreturn_t stmmac_interrupt(int irq, void *dev_id)
 	struct net_device *dev = (struct net_device *)dev_id;
 	struct stmmac_priv *priv = netdev_priv(dev);
 
+	if (READ_ONCE(priv->hw_unavailable)) {
+		if (priv->irq_wake)
+			pm_wakeup_event(priv->device, 0);
+		return IRQ_NONE;
+	}
+
 	/* Check if adapter is up */
 	if (test_bit(STMMAC_DOWN, &priv->state))
 		return IRQ_HANDLED;
@@ -6399,6 +6599,12 @@ static irqreturn_t stmmac_mac_interrupt(int irq, void *dev_id)
 	struct net_device *dev = (struct net_device *)dev_id;
 	struct stmmac_priv *priv = netdev_priv(dev);
 
+	if (READ_ONCE(priv->hw_unavailable)) {
+		if (priv->irq_wake)
+			pm_wakeup_event(priv->device, 0);
+		return IRQ_NONE;
+	}
+
 	/* Check if adapter is up */
 	if (test_bit(STMMAC_DOWN, &priv->state))
 		return IRQ_HANDLED;
@@ -6414,6 +6620,9 @@ static irqreturn_t stmmac_safety_interrupt(int irq, void *dev_id)
 	struct net_device *dev = (struct net_device *)dev_id;
 	struct stmmac_priv *priv = netdev_priv(dev);
 
+	if (READ_ONCE(priv->hw_unavailable))
+		return IRQ_NONE;
+
 	/* Check if adapter is up */
 	if (test_bit(STMMAC_DOWN, &priv->state))
 		return IRQ_HANDLED;
@@ -6431,6 +6640,9 @@ static irqreturn_t stmmac_msi_intr_tx(int irq, void *data)
 	int chan = ch->index;
 	int status;
 
+	if (READ_ONCE(priv->hw_unavailable))
+		return IRQ_NONE;
+
 	/* Check if adapter is up */
 	if (test_bit(STMMAC_DOWN, &priv->state))
 		return IRQ_HANDLED;
@@ -6453,6 +6665,9 @@ static irqreturn_t stmmac_msi_intr_rx(int irq, void *data)
 	struct stmmac_priv *priv = ch->priv_data;
 	int chan = ch->index;
 
+	if (READ_ONCE(priv->hw_unavailable))
+		return IRQ_NONE;
+
 	/* Check if adapter is up */
 	if (test_bit(STMMAC_DOWN, &priv->state))
 		return IRQ_HANDLED;
@@ -6484,13 +6699,40 @@ static int stmmac_ioctl(struct net_device *dev, struct ifreq *rq, int cmd)
 static int stmmac_setup_tc_block_cb(enum tc_setup_type type, void *type_data,
 				    void *cb_priv)
 {
+	struct flow_cls_common_offload *common = type_data;
 	struct stmmac_priv *priv = cb_priv;
+	bool active = stmmac_tc_active(priv);
 	int ret = -EOPNOTSUPP;
+	bool destroy;
+
+	switch (type) {
+	case TC_SETUP_CLSU32:
+		destroy = ((struct tc_cls_u32_offload *)type_data)->command ==
+			  TC_CLSU32_DELETE_KNODE;
+		break;
+	case TC_SETUP_CLSFLOWER:
+		destroy = ((struct flow_cls_offload *)type_data)->command ==
+			  FLOW_CLS_DESTROY;
+		break;
+	default:
+		return ret;
+	}
 
-	if (!tc_cls_can_offload_and_chain0(priv->dev, type_data))
+	if (common->chain_index) {
+		NL_SET_ERR_MSG(common->extack, "Driver supports only offload of chain 0");
+		return ret;
+	}
+	if (!destroy && !tc_can_offload_extack(priv->dev, common->extack))
 		return ret;
+	if (!destroy && !active)
+		return -ENETDOWN;
 
-	__stmmac_disable_all_queues(priv);
+	/* TC discards deleted filters regardless of the callback result. Clear
+	 * their cached state even while down or detached, without touching NAPI
+	 * or inaccessible registers. Recovery must not replay deleted rules.
+	 */
+	if (active)
+		__stmmac_disable_all_queues(priv);
 
 	switch (type) {
 	case TC_SETUP_CLSU32:
@@ -6503,7 +6745,8 @@ static int stmmac_setup_tc_block_cb(enum tc_setup_type type, void *type_data,
 		break;
 	}
 
-	stmmac_enable_all_queues(priv);
+	if (active)
+		stmmac_enable_all_queues(priv);
 	return ret;
 }
 
@@ -6558,6 +6801,9 @@ static int stmmac_set_mac_address(struct net_device *ndev, void *addr)
 	struct stmmac_priv *priv = netdev_priv(ndev);
 	int ret = 0;
 
+	if (priv->hw_unavailable)
+		return -EHOSTDOWN;
+
 	ret = pm_runtime_resume_and_get(priv->device);
 	if (ret < 0)
 		return ret;
@@ -6609,8 +6855,9 @@ static int stmmac_rings_status_show(struct seq_file *seq, void *v)
 	u8 rx_count, tx_count, queue;
 
 	rtnl_lock();
-	if ((dev->flags & IFF_UP) == 0)
+	if (priv->datapath == STMMAC_DATAPATH_DOWN)
 		goto out_unlock;
+
 	rx_count = priv->plat->rx_queues_to_use;
 	tx_count = priv->plat->tx_queues_to_use;
 
@@ -6924,7 +7171,7 @@ static int stmmac_vlan_update(struct stmmac_priv *priv, bool is_double)
 		hash = 0;
 	}
 
-	if (!netif_running(priv->dev))
+	if (!netif_running(priv->dev) || priv->hw_unavailable)
 		return 0;
 
 	return stmmac_update_vlan_hash(priv, priv->hw, hash, pmatch, is_double);
@@ -6940,6 +7187,9 @@ static int stmmac_vlan_rx_add_vid(struct net_device *ndev, __be16 proto, u16 vid
 	bool is_double = false;
 	int ret;
 
+	if (priv->hw_unavailable)
+		return -EHOSTDOWN;
+
 	ret = pm_runtime_resume_and_get(priv->device);
 	if (ret < 0)
 		return ret;
@@ -6982,9 +7232,12 @@ static int stmmac_vlan_rx_kill_vid(struct net_device *ndev, __be16 proto, u16 vi
 	bool is_double = false;
 	int ret;
 
-	ret = pm_runtime_resume_and_get(priv->device);
-	if (ret < 0)
-		return ret;
+	/* Removal must update the cached filters even if power cannot return. */
+	if (!priv->hw_unavailable) {
+		ret = pm_runtime_resume_and_get(priv->device);
+		if (ret < 0)
+			return ret;
+	}
 
 	if (be16_to_cpu(proto) == ETH_P_8021AD)
 		is_double = true;
@@ -7009,7 +7262,8 @@ static int stmmac_vlan_rx_kill_vid(struct net_device *ndev, __be16 proto, u16 vi
 	priv->num_double_vlans = num_double_vlans;
 
 del_vlan_error:
-	pm_runtime_put(priv->device);
+	if (!priv->hw_unavailable)
+		pm_runtime_put(priv->device);
 
 	return ret;
 }
@@ -7029,6 +7283,18 @@ static int stmmac_bpf(struct net_device *dev, struct netdev_bpf *bpf)
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
@@ -7191,7 +7457,13 @@ void stmmac_xdp_release(struct net_device *dev)
 {
 	struct stmmac_priv *priv = netdev_priv(dev);
 
+	netif_device_detach(dev);
+	/* Pause MAC/PCS resolution, but keep the PHY and negotiation running.
+	 * stmmac_xdp_open() completes this replay under the same RTNL lock.
+	 */
+	phylink_replay_link_begin(priv->phylink);
 	stmmac_quiesce(priv);
+	priv->datapath = STMMAC_DATAPATH_DOWN;
 
 	/* Free the IRQ lines */
 	stmmac_free_irq(dev, REQ_IRQ_ERR_ALL, 0);
@@ -7210,7 +7482,13 @@ void stmmac_xdp_release(struct net_device *dev)
 	 * watchdogs during reset
 	 */
 	netif_trans_update(dev);
-	netif_carrier_off(dev);
+
+	if (stmmac_fpe_supported(priv))
+		ethtool_mmsv_stop(&priv->fpe_cfg.mmsv);
+
+	/* Keep PTP across the immediately following stmmac_xdp_open(). That
+	 * function releases it if reopening fails, before returning DOWN.
+	 */
 }
 
 int stmmac_xdp_open(struct net_device *dev)
@@ -7289,19 +7567,25 @@ int stmmac_xdp_open(struct net_device *dev)
 
 	/* Enable NAPI process*/
 	stmmac_enable_all_queues(priv);
-	netif_carrier_on(dev);
-	netif_tx_start_all_queues(dev);
 	stmmac_enable_all_dma_irq(priv);
+	priv->datapath = STMMAC_DATAPATH_RUNNING;
+	phylink_replay_link_end(priv->phylink);
+	netif_device_attach(dev);
 
 	return 0;
 
 irq_error:
-	for (chan = 0; chan < priv->plat->tx_queues_to_use; chan++)
-		hrtimer_cancel(&priv->dma_conf->tx_queue[chan].txtimer);
+	stmmac_stop_tx_queues(priv);
+	stmmac_stop_all_dma(priv);
+	stmmac_mac_set(priv, priv->ioaddr, false);
 
 init_error:
 	free_dma_desc_resources(priv, priv->dma_conf);
 dma_desc_error:
+	/* STOPPED keeps replay_end() from reconfiguring a failed MAC. */
+	phylink_stop(priv->phylink);
+	phylink_replay_link_end(priv->phylink);
+	stmmac_release_ptp(priv);
 	return ret;
 }
 
@@ -7424,6 +7708,9 @@ static void stmmac_reset_subtask(struct stmmac_priv *priv)
 	netdev_err(priv->dev, "Reset adapter.\n");
 
 	rtnl_lock();
+	if (!netif_device_present(priv->dev))
+		goto out_unlock;
+
 	netif_trans_update(priv->dev);
 	while (test_and_set_bit(STMMAC_RESETING, &priv->state))
 		usleep_range(1000, 2000);
@@ -7433,6 +7720,7 @@ static void stmmac_reset_subtask(struct stmmac_priv *priv)
 	dev_open(priv->dev, NULL);
 	clear_bit(STMMAC_DOWN, &priv->state);
 	clear_bit(STMMAC_RESETING, &priv->state);
+out_unlock:
 	rtnl_unlock();
 }
 
@@ -7677,13 +7965,37 @@ static void stmmac_napi_del(struct net_device *dev)
 	}
 }
 
-int stmmac_reinit_queues(struct net_device *dev, u8 rx_cnt, u8 tx_cnt)
+/* Rebuild only the datapath. The administratively-up device still owns its
+ * PHY attachment and runtime-PM reference, even if this reopen fails.
+ */
+static int stmmac_reopen(struct net_device *dev)
 {
 	struct stmmac_priv *priv = netdev_priv(dev);
-	int ret = 0, i;
+	struct stmmac_dma_conf *old_conf = priv->dma_conf;
+	struct stmmac_dma_conf *dma_conf;
+	int ret;
 
-	if (netif_running(dev))
-		stmmac_release(dev);
+	dma_conf = stmmac_setup_dma_desc(priv, dev->mtu);
+	if (IS_ERR(dma_conf))
+		return PTR_ERR(dma_conf);
+
+	ret = __stmmac_open(dev, dma_conf);
+	if (ret) {
+		priv->dma_conf = old_conf;
+		free_dma_desc_resources(priv, dma_conf);
+		kfree(dma_conf);
+		return ret;
+	}
+
+	kfree(old_conf);
+	netif_device_attach(dev);
+	return 0;
+}
+
+static void stmmac_set_queues(struct net_device *dev, u8 rx_cnt, u8 tx_cnt)
+{
+	struct stmmac_priv *priv = netdev_priv(dev);
+	int i;
 
 	stmmac_napi_del(dev);
 
@@ -7695,9 +8007,31 @@ int stmmac_reinit_queues(struct net_device *dev, u8 rx_cnt, u8 tx_cnt)
 									rx_cnt);
 
 	stmmac_napi_add(dev);
+}
+
+int stmmac_reinit_queues(struct net_device *dev, u8 rx_cnt, u8 tx_cnt)
+{
+	struct stmmac_priv *priv = netdev_priv(dev);
+	u8 old_rx = priv->plat->rx_queues_to_use;
+	u8 old_tx = priv->plat->tx_queues_to_use;
+	int ret = 0;
+
+	if (netif_running(dev)) {
+		if (!netif_device_present(dev))
+			return -ENETDOWN;
+		netif_device_detach(dev);
+		__stmmac_release(dev);
+	}
+
+	stmmac_set_queues(dev, rx_cnt, tx_cnt);
 
 	if (netif_running(dev))
-		ret = stmmac_open(dev);
+		ret = stmmac_reopen(dev);
+	if (ret) {
+		stmmac_set_queues(dev, old_rx, old_tx);
+		netdev_err(dev, "failed reopening after channel change: %pe; interface remains detached\n",
+			   ERR_PTR(ret));
+	}
 
 	return ret;
 }
@@ -7705,16 +8039,28 @@ int stmmac_reinit_queues(struct net_device *dev, u8 rx_cnt, u8 tx_cnt)
 int stmmac_reinit_ringparam(struct net_device *dev, u32 rx_size, u32 tx_size)
 {
 	struct stmmac_priv *priv = netdev_priv(dev);
+	u32 old_rx = priv->dma_conf->dma_rx_size;
+	u32 old_tx = priv->dma_conf->dma_tx_size;
 	int ret = 0;
 
-	if (netif_running(dev))
-		stmmac_release(dev);
+	if (netif_running(dev)) {
+		if (!netif_device_present(dev))
+			return -ENETDOWN;
+		netif_device_detach(dev);
+		__stmmac_release(dev);
+	}
 
 	priv->dma_conf->dma_rx_size = rx_size;
 	priv->dma_conf->dma_tx_size = tx_size;
 
 	if (netif_running(dev))
-		ret = stmmac_open(dev);
+		ret = stmmac_reopen(dev);
+	if (ret) {
+		priv->dma_conf->dma_rx_size = old_rx;
+		priv->dma_conf->dma_tx_size = old_tx;
+		netdev_err(dev, "failed reopening after ring change: %pe; interface remains detached\n",
+			   ERR_PTR(ret));
+	}
 
 	return ret;
 }
@@ -8131,6 +8477,7 @@ static int __stmmac_dvr_probe(struct device *device,
 	stmmac_napi_add(ndev);
 
 	mutex_init(&priv->lock);
+	mutex_init(&priv->pm_mutex);
 	rwlock_init(&priv->ptp_lock);
 	mutex_init(&priv->ptp_mutex);
 
@@ -8278,30 +8625,43 @@ EXPORT_SYMBOL_GPL(stmmac_dvr_remove);
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
+	bool accessible;
+	int ret = 0;
 
-	if (!ndev || !netif_running(ndev))
+	rtnl_lock();
+	if (!netif_running(ndev))
+		goto suspend_bsp;
+
+	/* A failed datapath cannot provide a working MAC wake path. It may
+	 * even have released its wake IRQ. Do not silently suspend without WoL.
+	 */
+	if (priv->wolopts && priv->datapath != STMMAC_DATAPATH_RUNNING) {
+		netdev_err(ndev, "cannot suspend failed datapath with MAC WoL enabled\n");
+		rtnl_unlock();
+		return -EBUSY;
+	}
+	if (priv->hw_suspended)
 		goto suspend_bsp;
 
 	mutex_lock(&priv->lock);
 
 	netif_device_detach(ndev);
 
-	stmmac_quiesce(priv);
+	if (priv->datapath == STMMAC_DATAPATH_RUNNING)
+		stmmac_quiesce(priv);
 
 	if (priv->eee_sw_timer_en) {
 		priv->tx_path_in_lpi_mode = false;
 		timer_delete_sync(&priv->eee_ctrl_timer);
 	}
 
-	/* Stop TX/RX DMA */
 	stmmac_stop_all_dma(priv);
 
 	stmmac_legacy_serdes_power_down(priv);
@@ -8317,18 +8677,41 @@ int stmmac_suspend(struct device *dev)
 
 	mutex_unlock(&priv->lock);
 
-	rtnl_lock();
 	phylink_suspend(priv->phylink, !!priv->wolopts);
-	rtnl_unlock();
+	if (priv->datapath == STMMAC_DATAPATH_RUNNING)
+		priv->datapath = STMMAC_DATAPATH_SUSPENDED;
+	priv->hw_suspended = true;
 
 	if (stmmac_fpe_supported(priv))
 		ethtool_mmsv_stop(&priv->fpe_cfg.mmsv);
 
 suspend_bsp:
-	if (priv->plat->suspend)
-		return priv->plat->suspend(dev, priv->plat->bsp_priv);
+	accessible = !priv->hw_unavailable;
+	mutex_lock(&priv->ptp_mutex);
+	stmmac_block_ptp(priv, true);
+	mutex_unlock(&priv->ptp_mutex);
+	/* Drain MDIO transactions before the platform can remove power. */
+	if (priv->mii)
+		mutex_lock(&priv->mii->mdio_lock);
+	/* ndo_set_rx_mode() can run without RTNL under the address lock. */
+	netif_addr_lock_bh(ndev);
+	WRITE_ONCE(priv->hw_unavailable, true);
+	netif_addr_unlock_bh(ndev);
+	if (priv->mii)
+		mutex_unlock(&priv->mii->mdio_lock);
+	if (priv->datapath == STMMAC_DATAPATH_SUSPENDED) {
+		stmmac_synchronize_irq(priv);
+		stmmac_stop_tx_queues(priv);
+		if (accessible)
+			stmmac_stop_all_dma(priv);
+	}
+	if (priv->plat->suspend && !priv->bsp_suspended) {
+		priv->bsp_suspended = true;
+		ret = priv->plat->suspend(dev, priv->plat->bsp_priv);
+	}
+	rtnl_unlock();
 
-	return 0;
+	return ret;
 }
 EXPORT_SYMBOL_GPL(stmmac_suspend);
 
@@ -8380,41 +8763,39 @@ int stmmac_resume(struct device *dev)
 	struct stmmac_priv *priv = netdev_priv(ndev);
 	int ret;
 
-	if (priv->plat->resume) {
-		ret = priv->plat->resume(dev, priv->plat->bsp_priv);
-		if (ret)
-			return ret;
+	rtnl_lock();
+	ret = stmmac_resume_power(priv, true);
+	if (ret)
+		goto out_unlock;
+
+	if (!netif_running(ndev)) {
+		ret = 0;
+		goto out_unlock;
 	}
 
-	if (!netif_running(ndev))
-		return 0;
+	if (priv->hw_suspended) {
+		ret = stmmac_resume_hw(priv);
+		if (ret)
+			goto out_unlock;
 
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
@@ -8430,13 +8811,13 @@ int stmmac_resume(struct device *dev)
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
+	mutex_lock(&priv->ptp_mutex);
+	stmmac_block_ptp(priv, false);
+	mutex_unlock(&priv->ptp_mutex);
 
 	stmmac_init_coalesce(priv);
 	phylink_rx_clk_stop_block(priv->phylink);
@@ -8455,11 +8836,25 @@ int stmmac_resume(struct device *dev)
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
 
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
index 07d5eab05996..136f1f74af57 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
@@ -135,6 +135,9 @@ static int stmmac_xgmac2_mdio_read_c22(struct mii_bus *bus, int phyaddr,
 	struct stmmac_priv *priv = netdev_priv(bus->priv);
 	u32 addr;
 
+	if (READ_ONCE(priv->hw_unavailable))
+		return -EHOSTDOWN;
+
 	/* Until ver 2.20 XGMAC does not support C22 addr >= 4 */
 	if (priv->synopsys_id < DWXGMAC_CORE_2_20 &&
 	    phyaddr > MII_XGMAC_MAX_C22ADDR)
@@ -151,6 +154,9 @@ static int stmmac_xgmac2_mdio_read_c45(struct mii_bus *bus, int phyaddr,
 	struct stmmac_priv *priv = netdev_priv(bus->priv);
 	u32 addr;
 
+	if (READ_ONCE(priv->hw_unavailable))
+		return -EHOSTDOWN;
+
 	stmmac_xgmac2_c45_format(priv, phyaddr, devad, phyreg, &addr);
 
 	return stmmac_xgmac2_mdio_read(priv, addr, MII_XGMAC_BUSY);
@@ -198,6 +204,9 @@ static int stmmac_xgmac2_mdio_write_c22(struct mii_bus *bus, int phyaddr,
 	struct stmmac_priv *priv = netdev_priv(bus->priv);
 	u32 addr;
 
+	if (READ_ONCE(priv->hw_unavailable))
+		return -EHOSTDOWN;
+
 	/* Until ver 2.20 XGMAC does not support C22 addr >= 4 */
 	if (priv->synopsys_id < DWXGMAC_CORE_2_20 &&
 	    phyaddr > MII_XGMAC_MAX_C22ADDR)
@@ -215,6 +224,9 @@ static int stmmac_xgmac2_mdio_write_c45(struct mii_bus *bus, int phyaddr,
 	struct stmmac_priv *priv = netdev_priv(bus->priv);
 	u32 addr;
 
+	if (READ_ONCE(priv->hw_unavailable))
+		return -EHOSTDOWN;
+
 	stmmac_xgmac2_c45_format(priv, phyaddr, devad, phyreg, &addr);
 
 	return stmmac_xgmac2_mdio_write(priv, addr, MII_XGMAC_BUSY,
@@ -248,6 +260,9 @@ static int stmmac_mdio_access(struct stmmac_priv *priv, unsigned int pa,
 	u32 addr;
 	int ret;
 
+	if (READ_ONCE(priv->hw_unavailable))
+		return -EHOSTDOWN;
+
 	ret = pm_runtime_resume_and_get(priv->device);
 	if (ret < 0)
 		return ret;
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_pcs.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_pcs.c
index df37af5ab837..7de83fb8f06f 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_pcs.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_pcs.c
@@ -60,7 +60,8 @@ static void dwmac_integrated_pcs_disable(struct phylink_pcs *pcs)
 {
 	struct stmmac_pcs *spcs = phylink_pcs_to_stmmac_pcs(pcs);
 
-	stmmac_mac_irq_modify(spcs->priv, spcs->int_mask, 0);
+	if (!READ_ONCE(spcs->priv->hw_unavailable))
+		stmmac_mac_irq_modify(spcs->priv, spcs->int_mask, 0);
 }
 
 static void dwmac_integrated_pcs_get_state(struct phylink_pcs *pcs,
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
index 6128ed1bd521..0d914d69379e 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
@@ -957,14 +957,23 @@ static int __maybe_unused stmmac_pltfr_noirq_suspend(struct device *dev)
 	if (!netif_running(ndev))
 		return 0;
 
-	if (!priv->wolopts) {
-		/* Disable clock in case of PWM is off */
-		clk_disable_unprepare(priv->plat->clk_ptp_ref);
+	mutex_lock(&priv->pm_mutex);
+	if (!priv->irq_wake) {
+		/* A detached datapath may already have released its PTP clock. */
+		if (priv->ptp_clock_enabled) {
+			clk_disable_unprepare(priv->plat->clk_ptp_ref);
+			priv->ptp_clock_enabled = false;
+			priv->ptp_clock_suspended = true;
+		}
 
+		priv->bus_clks_suspended = true;
 		ret = pm_runtime_force_suspend(dev);
-		if (ret)
+		if (ret) {
+			mutex_unlock(&priv->pm_mutex);
 			return ret;
+		}
 	}
+	mutex_unlock(&priv->pm_mutex);
 
 	return 0;
 }
@@ -973,27 +982,8 @@ static int __maybe_unused stmmac_pltfr_noirq_resume(struct device *dev)
 {
 	struct net_device *ndev = dev_get_drvdata(dev);
 	struct stmmac_priv *priv = netdev_priv(ndev);
-	int ret;
-
-	if (!netif_running(ndev))
-		return 0;
 
-	if (!priv->wolopts) {
-		/* enable the clk previously disabled */
-		ret = pm_runtime_force_resume(dev);
-		if (ret)
-			return ret;
-
-		ret = clk_prepare_enable(priv->plat->clk_ptp_ref);
-		if (ret < 0) {
-			netdev_warn(priv->dev,
-				    "failed to enable PTP reference clock: %pe\n",
-				    ERR_PTR(ret));
-			return ret;
-		}
-	}
-
-	return 0;
+	return stmmac_resume_clocks(priv);
 }
 
 const struct dev_pm_ops stmmac_pltfr_pm_ops = {
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
index bb1dfe2702ac..9ded65750e89 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
@@ -11,6 +11,17 @@
 #include "dwmac5.h"
 #include "stmmac.h"
 
+static int tc_config_preemption(struct stmmac_priv *priv,
+				struct netlink_ext_ack *extack, u32 preemptible_tcs)
+{
+	/* Qdisc teardown must not access unpowered registers. */
+	if (priv->hw_unavailable)
+		return 0;
+
+	return stmmac_fpe_map_preemption_class(priv, priv->dev, extack,
+					      preemptible_tcs);
+}
+
 static void tc_fill_all_pass_entry(struct stmmac_tc_entry *entry)
 {
 	memset(entry, 0, sizeof(*entry));
@@ -171,18 +182,16 @@ static int tc_fill_entry(struct stmmac_priv *priv,
 static void tc_unfill_entry(struct stmmac_priv *priv,
 			    struct tc_cls_u32_offload *cls)
 {
-	struct stmmac_tc_entry *entry;
+	struct stmmac_tc_entry *entry, *frag;
 
 	entry = tc_find_entry(priv, cls, false);
 	if (!entry)
 		return;
 
-	entry->in_use = false;
-	if (entry->frag_ptr) {
-		entry = entry->frag_ptr;
-		entry->is_frag = false;
-		entry->in_use = false;
-	}
+	frag = entry->frag_ptr;
+	if (frag)
+		memset(frag, 0, sizeof(*frag));
+	memset(entry, 0, sizeof(*entry));
 }
 
 static int tc_config_knode(struct stmmac_priv *priv,
@@ -212,6 +221,9 @@ static int tc_delete_knode(struct stmmac_priv *priv,
 	/* Set entry and fragments as not used */
 	tc_unfill_entry(priv, cls);
 
+	if (!stmmac_tc_active(priv))
+		return 0;
+
 	return stmmac_rxp_config(priv, priv->hw->pcsr, priv->tc_entries,
 				 priv->tc_entries_max);
 }
@@ -345,6 +357,8 @@ static int tc_setup_cbs(struct stmmac_priv *priv,
 		return -EINVAL;
 	if (!priv->dma_cap.av)
 		return -EOPNOTSUPP;
+	if (priv->hw_unavailable && qopt->enable)
+		return -EHOSTDOWN;
 
 	port_transmit_rate_kbps = qopt->idleslope - qopt->sendslope;
 
@@ -380,10 +394,12 @@ static int tc_setup_cbs(struct stmmac_priv *priv,
 
 		priv->plat->tx_queues_cfg[queue].mode_to_use = MTL_QUEUE_AVB;
 	} else if (!qopt->enable) {
-		ret = stmmac_dma_qmode(priv, priv->ioaddr, queue,
-				       MTL_QUEUE_DCB);
-		if (ret)
-			return ret;
+		if (!priv->hw_unavailable) {
+			ret = stmmac_dma_qmode(priv, priv->ioaddr, queue,
+					       MTL_QUEUE_DCB);
+			if (ret)
+				return ret;
+		}
 
 		priv->plat->tx_queues_cfg[queue].mode_to_use = MTL_QUEUE_DCB;
 		return 0;
@@ -645,23 +661,21 @@ static int tc_del_flow(struct stmmac_priv *priv,
 		       struct flow_cls_offload *cls)
 {
 	struct stmmac_flow_entry *entry = tc_find_flow(priv, cls, false);
-	int ret;
+	int ret = 0;
 
 	if (!entry || !entry->in_use)
 		return -ENOENT;
 
-	if (entry->is_l4) {
-		ret = stmmac_config_l4_filter(priv, priv->hw, entry->idx, false,
-					      false, false, false, 0);
-	} else {
-		ret = stmmac_config_l3_filter(priv, priv->hw, entry->idx, false,
-					      false, false, false, 0);
+	if (stmmac_tc_active(priv)) {
+		if (entry->is_l4)
+			ret = stmmac_config_l4_filter(priv, priv->hw, entry->idx,
+						      false, false, false, false, 0);
+		else
+			ret = stmmac_config_l3_filter(priv, priv->hw, entry->idx,
+						      false, false, false, false, 0);
 	}
 
-	entry->in_use = false;
-	entry->cookie = 0;
-	entry->is_l4 = false;
-	entry->action = 0;
+	*entry = (struct stmmac_flow_entry) { .idx = entry->idx };
 	return ret;
 }
 
@@ -744,7 +758,8 @@ static int tc_del_vlan_flow(struct stmmac_priv *priv,
 	if (!entry || !entry->in_use || entry->type != STMMAC_RFS_T_VLAN)
 		return -ENOENT;
 
-	stmmac_rx_queue_prio(priv, priv->hw, 0, entry->tc);
+	if (stmmac_tc_active(priv))
+		stmmac_rx_queue_prio(priv, priv->hw, 0, entry->tc);
 
 	entry->in_use = false;
 	entry->cookie = 0;
@@ -840,13 +855,13 @@ static int tc_del_ethtype_flow(struct stmmac_priv *priv,
 
 	switch (entry->etype) {
 	case ETH_P_LLDP:
-		stmmac_rx_queue_routing(priv, priv->hw,
-					PACKET_DCBCPQ, 0);
+		if (stmmac_tc_active(priv))
+			stmmac_rx_queue_routing(priv, priv->hw, PACKET_DCBCPQ, 0);
 		priv->rfs_entries_cnt[STMMAC_RFS_T_LLDP]--;
 		break;
 	case ETH_P_1588:
-		stmmac_rx_queue_routing(priv, priv->hw,
-					PACKET_PTPQ, 0);
+		if (stmmac_tc_active(priv))
+			stmmac_rx_queue_routing(priv, priv->hw, PACKET_PTPQ, 0);
 		priv->rfs_entries_cnt[STMMAC_RFS_T_1588]--;
 		break;
 	default:
@@ -901,12 +916,12 @@ static int tc_setup_cls(struct stmmac_priv *priv,
 {
 	int ret = 0;
 
-	/* When RSS is enabled, the filtering will be bypassed */
-	if (priv->rss.enable)
-		return -EBUSY;
-
 	switch (cls->command) {
 	case FLOW_CLS_REPLACE:
+		/* When RSS is enabled, the filtering will be bypassed. */
+		if (priv->rss.enable)
+			return -EBUSY;
+
 		ret = tc_add_flow_cls(priv, cls);
 		break;
 	case FLOW_CLS_DESTROY:
@@ -1015,6 +1030,8 @@ static int tc_taprio_configure(struct stmmac_priv *priv,
 
 	if (qopt->cmd == TAPRIO_CMD_DESTROY)
 		goto disable;
+	if (priv->hw_unavailable)
+		return -EHOSTDOWN;
 
 	if (qopt->num_entries > dep)
 		return -EINVAL;
@@ -1098,8 +1115,7 @@ static int tc_taprio_configure(struct stmmac_priv *priv,
 		goto disable;
 	}
 
-	ret = stmmac_fpe_map_preemption_class(priv, priv->dev, extack,
-					      qopt->mqprio.preemptible_tcs);
+	ret = tc_config_preemption(priv, extack, qopt->mqprio.preemptible_tcs);
 	if (ret)
 		goto disable;
 
@@ -1109,8 +1125,9 @@ static int tc_taprio_configure(struct stmmac_priv *priv,
 	if (priv->est) {
 		mutex_lock(&priv->est_lock);
 		priv->est->enable = false;
-		stmmac_est_configure(priv, priv, priv->est,
-				     priv->plat->clk_ptp_rate);
+		if (!priv->hw_unavailable)
+			stmmac_est_configure(priv, priv, priv->est,
+					     priv->plat->clk_ptp_rate);
 		/* Reset taprio status */
 		for (i = 0; i < priv->plat->tx_queues_to_use; i++) {
 			priv->xstats.max_sdu_txq_drop[i] = 0;
@@ -1120,7 +1137,7 @@ static int tc_taprio_configure(struct stmmac_priv *priv,
 		mutex_unlock(&priv->est_lock);
 	}
 
-	err = stmmac_fpe_map_preemption_class(priv, priv->dev, extack, 0);
+	err = tc_config_preemption(priv, extack, 0);
 
 	return qopt->cmd == TAPRIO_CMD_DESTROY ? err : ret;
 }
@@ -1269,7 +1286,7 @@ static int stmmac_reset_tc_mqprio(struct net_device *ndev,
 	netdev_reset_tc(ndev);
 	netif_set_real_num_tx_queues(ndev, priv->plat->tx_queues_to_use);
 
-	return stmmac_fpe_map_preemption_class(priv, ndev, extack, 0);
+	return tc_config_preemption(priv, extack, 0);
 }
 
 static int tc_setup_dwmac510_mqprio(struct stmmac_priv *priv,
@@ -1286,6 +1303,8 @@ static int tc_setup_dwmac510_mqprio(struct stmmac_priv *priv,
 
 	if (!qopt->num_tc)
 		return stmmac_reset_tc_mqprio(ndev, extack);
+	if (priv->hw_unavailable)
+		return -EHOSTDOWN;
 
 	if (qopt->num_tc > ARRAY_SIZE(tc_to_txq))
 		return -EINVAL;
@@ -1315,8 +1334,7 @@ static int tc_setup_dwmac510_mqprio(struct stmmac_priv *priv,
 	if (err)
 		goto error_reset_tc;
 
-	err = stmmac_fpe_map_preemption_class(priv, ndev, extack,
-					      mqprio->preemptible_tcs);
+	err = tc_config_preemption(priv, extack, mqprio->preemptible_tcs);
 	if (err)
 		goto error_reset_num_tx_queues;
 
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_vlan.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_vlan.c
index e24efe3bfedb..006882c14a8d 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_vlan.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_vlan.c
@@ -114,6 +114,8 @@ static int vlan_del_hw_rx_fltr(struct net_device *dev,
 			       struct mac_device_info *hw,
 			       __be16 proto, u16 vid)
 {
+	struct stmmac_priv *priv = netdev_priv(dev);
+	bool update_hw = netif_running(dev) && !priv->hw_unavailable;
 	int i, ret = 0;
 
 	/* Single Rx VLAN Filter */
@@ -121,7 +123,7 @@ static int vlan_del_hw_rx_fltr(struct net_device *dev,
 		if ((hw->vlan_filter[0] & VLAN_TAG_VID) == vid) {
 			hw->vlan_filter[0] = 0;
 
-			if (netif_running(dev))
+			if (update_hw)
 				vlan_write_single(dev, 0);
 		}
 		return 0;
@@ -132,7 +134,7 @@ static int vlan_del_hw_rx_fltr(struct net_device *dev,
 		if ((hw->vlan_filter[i] & VLAN_TAG_DATA_VEN) &&
 		    ((hw->vlan_filter[i] & VLAN_TAG_DATA_VID) == vid)) {
 
-			if (netif_running(dev)) {
+			if (update_hw) {
 				ret = vlan_write_filter(dev, hw, i, 0);
 				if (ret)
 					return ret;
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_xdp.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_xdp.c
index d7e4db7224b0..7ecb7addd2ea 100644
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
@@ -106,8 +108,9 @@ int stmmac_xdp_set_prog(struct stmmac_priv *priv, struct bpf_prog *prog,
 	struct bpf_prog *old_prog;
 	bool need_update;
 	bool if_running;
+	int ret;
 
-	if_running = netif_running(dev);
+	if_running = priv->datapath == STMMAC_DATAPATH_RUNNING;
 
 	if (prog && dev->mtu > ETH_DATA_LEN) {
 		/* For now, the driver doesn't support XDP functionality with
@@ -117,25 +120,41 @@ int stmmac_xdp_set_prog(struct stmmac_priv *priv, struct bpf_prog *prog,
 		return -EOPNOTSUPP;
 	}
 
-	if (!prog)
-		xdp_features_clear_redirect_target(dev);
-
 	need_update = !!priv->xdp_prog != !!prog;
 	if (if_running && need_update)
 		stmmac_xdp_release(dev);
 
 	old_prog = xchg(&priv->xdp_prog, prog);
-	if (old_prog)
-		bpf_prog_put(old_prog);
 
 	/* Disable RX SPH for XDP operation */
 	priv->sph_active = priv->sph_capable && !stmmac_xdp_is_enabled(priv);
 
-	if (if_running && need_update)
-		stmmac_xdp_open(dev);
+	if (if_running && need_update) {
+		ret = stmmac_xdp_open(dev);
+		if (ret) {
+			netdev_err(dev, "failed reopening after XDP change: %pe; interface remains detached\n",
+				   ERR_PTR(ret));
+			if (prog) {
+				/* The core retains the old program on error and drops
+				 * the reference it passed for the proposed program.
+				 */
+				xchg(&priv->xdp_prog, old_prog);
+				priv->sph_active = priv->sph_capable && !old_prog;
+				return ret;
+			}
+			/* Uninstalling a BPF link must release its program even
+			 * if the non-XDP datapath cannot be restarted.
+			 */
+		}
+	}
+
+	if (old_prog)
+		bpf_prog_put(old_prog);
 
 	if (prog)
 		xdp_features_set_redirect_target(dev, false);
+	else
+		xdp_features_clear_redirect_target(dev);
 
 	return 0;
 }

-- 
2.53.0

