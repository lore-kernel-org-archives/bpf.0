Received: from mail-oo2-f40.google.com (mail-oo2-f40.google.com [74.125.231.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A90A438011
	for <bpf@vger.kernel.org>; Sun, 27 Sep 2026 22:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790546434; cv=none; b=cpad6oMyXMRm1A3v3OlPC/e+o6PeBvXA4WmbPuN6DlqATUG9WUd9KI1+HVz6OHYeslElhprwKp3sPojvFsxiv8CehJbhww7SqtA72D2FrgP/F1fJQtGStlcJ2TvjKb99lyeBKfS1Kb686XO5rG6uhm63woJuBlD91nJ/JVldOpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790546434; c=relaxed/simple;
	bh=i82rXsPXr5BvSIGo+y39qg6b41tpeiBPkr+Ivprgbh8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mMUojVYTz7HTHgPXeL8L2NEXDYcasWPOaezp8hkuJNxRjeo9XpkdjNcZYx7AVb75Gm34KKkSXS5bGC9BNaIjocVcT5ysm/w2yCjm3aySXPIMh5fUuxoItmLB0Xf0VLAIDQoJ6h1hvRFQiOURdAJOpKoJGMN/SJFM5YZPp6d8ku8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VC8ppuKN; arc=none smtp.client-ip=74.125.231.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VC8ppuKN"
Received: by mail-oo2-f40.google.com with SMTP id 006d021491bc7-6c2613d80fbso1551880eaf.1
        for <bpf@vger.kernel.org>; Sun, 27 Sep 2026 15:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790546426; x=1791151226; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lD84VmNHyuDi5sN9BWRPY67CA1UQsdRVGAGzNHELzk0=;
        b=VC8ppuKNmVPGZ2i/IHiNtX586vU1Y+RhEz1WasNiQmJ3IW5Ll9I+NaNLq8cmuG1COm
         keQOqZeYxrrPJj7EZsiPkyb3QRZvBf+u+NXny9B8j6aLj8DFnCo08uDKKwOLJmxFNTC4
         lFsDzGyYe5+1wgE4+8WvS2j9qbbViGiR0jXGFQQLHACvYxUIxUNCR62ipKQJDRvMl0ww
         7fzmOAM//c2vzFefnPAiC+f4Qo9qWr9sy/NV9K+L0rTpgHY2FNiWs9+wc6AznhinyfC5
         qHNoGYy+vHICS9LG8uDrEbk7s5MNC2UDxy6sD+BUwhRSG1TZH015Vn3HFBnmnTd0Rqez
         1EMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790546426; x=1791151226;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lD84VmNHyuDi5sN9BWRPY67CA1UQsdRVGAGzNHELzk0=;
        b=R4ksOkdvPZ3GN0JfNMd8EQeNwvA714ZgDrWYiNsfe+npjWzNJB0VGTzgNOLJwSwOu5
         0z4/d0u25iyQskShhGH/FwkKzvzrW0h0NIi8r4xIZHF/q6wu9a6SZUDxD5vMRGZUaIZd
         kXfiVvU3cPA6VAZ2anFAFY19612AwaxLbgiRfeDFMkHIi0AIssAWKaCcbcFBssvB68VS
         PXqc1eRK/s9gZ4zqKx5Fi84sghOC2kVujvWqzV+QLsIFawSKwQ5t/h7W9HdYDe490i/7
         dZO76S9eXFlpMb8zQEWmVjIdbaNuILF/EtlCYrwH9HeTG4sGLpcMjeZJQUxvi83W0No4
         ylMQ==
X-Forwarded-Encrypted: i=1; AKwUvBwu+rnzVq/b5cu8ghisspV07gECma8e1qYodlP7KaYOiKPTaOhYX+atv1RU3gSLOFTMCOQ=@vger.kernel.org
X-Gm-Message-State: AFuF++nQTaU7C1DanxeKtpacnSxeBaEDTKv3XYU7oS124v0bbd5XWq+P
	R4fxvFHZdraocXNNK5CPsgbkdmepqLniMoRwDcz+yeQTgOE8YVV4hqXb
X-Gm-Gg: AYBFou13eK0m1I0wH0lX6A4e4ggCOqlfL7pGIcRhQ70I+RhatgbyQJCGTRSAss0+0KS
	lRN/NT/imaNf6V0ExoXDb/DGgGslrV3aLL74vv9yDxavjTknnzabDRZdJ3JvAs+HmlrFGZddMlt
	qXt5S8SdbXCNLU0qD/ns6PsTKFwmWIC0+HzhtHyfnaat5weeI9YN0++N69ojhk4QqHewlYv0J2N
	C0nvtewzARPqeQxYKYkLFH+sgWyShqqpBG2a+UDUYDHYm9S/sFuZwBqAWLmL3metxr53JV1v5f9
	+wHQcMp/QTUR+aHszVSAwdt0YNfZBVgP+R09yvT3lgY3t9+8h5VyVO5hMGMZa8bSwglHYbI90cu
	nWYX3TBlWYOIiXqlkUMdJIGoROFKJT8O/PVf5BXkDsy0sdk+FYw59ktiEODACxlSfxZJ4awWyB7
	b3i2957QpxlE0Tj33WlTDtc0azacCYNtryJcp1xahzB7KtU28JdDdq9UrOLxWdnHYmanxyecMzp
	46wRX4wmcu42S0zTQZo/yP2by5nAt4RmddA5E1mOe6X4ULVpoAD1lmZraJXM3cnURsLJfasSCZh
	2jQEJe0Wk9Dz2T5EBZiJqYCmrPLunuycLQwq697PABzRTMJWPxvI6H4GQmJtdRHc44ULKJvzIO7
	MYZiKdmcsW10AGvek39nd
X-Received: by 2002:a05:6820:c89:b0:6d8:bba5:6589 with SMTP id 006d021491bc7-6d8bba56c55mr1492864eaf.48.1790546426064;
        Sun, 27 Sep 2026 15:00:26 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-81b3de6f7e1sm4874147a34.22.2026.09.27.15.00.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 15:00:25 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sun, 27 Sep 2026 15:59:50 -0600
Subject: [PATCH net-next v5 15/19] net: stmmac: restore TC offloads before
 restarting DMA
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260927-submit-stmmac-reset-fixes-v1-v5-15-feec6c14dd06@gmail.com>
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

A DMA software reset loses MAC filters and the MTL gate schedule, not
just the ring addresses. Build on Lorenzo Bianconi's EST replay helper
and embedded schedule state to restore the remaining offloads during
ordinary hardware setup and resume. The later live-XDP reset fallback
and retained-ring MTU transaction use the same restoration.

Keep the parsed L3/L4 rule rather than only its cookie. Program from
that saved definition both when installing a rule and after reset. Do
not publish a partially programmed replacement; restore the previous
slot when installation fails. Keep runtime VLAN priorities in the
existing queue configuration and replay EtherType steering and the
configured preemption/TC mapping. Preserve the additional fragment size.

Use stmmac_setup_est() after timestamp initialization, with the PTP mutex
held. Read the counter internally under the PTP lock so reset replay can
run while public PHC operations remain blocked. Advance the saved base
time by whole cycles when necessary. Delay DMA start until filters,
timestamp state and the gate schedule have been restored. Propagate a
replay error through the existing rollback or detached recovery path.

Build and validate TAPRIO replacements separately, including the PHC time
read, and publish the saved schedule only after hardware setup succeeds.
Keep the previous schedule on rejection and attempt to restore it after
a programming error. A rejected first install must not leave an enabled
zero-cycle cache for PHC adjustment or reset replay. Serialize schedule
publication with those consumers under the PTP mutex.

Pass the unpublished schedule to the same EST base-time and hardware
programming helper used by open, resume and PHC time adjustment. Keep
public TAPRIO requests gated while the PHC is blocked, without blocking
internal reset replay.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac.h      |   8 +
 drivers/net/ethernet/stmicro/stmmac/stmmac_est.c  |  29 ++-
 drivers/net/ethernet/stmicro/stmmac/stmmac_est.h  |   4 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.c  |   1 +
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c |  32 +--
 drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c  |   2 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c   | 275 +++++++++++++---------
 7 files changed, 216 insertions(+), 135 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac.h b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
index 38370f2cbe87..04d08b2c1e3f 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac.h
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
@@ -151,6 +151,9 @@ struct stmmac_fpe_cfg {
 	struct ethtool_mmsv mmsv;
 	const struct stmmac_fpe_reg *reg;
 	u32 fpe_csr;	/* MAC_FPE_CTRL_STS reg cache */
+	u32 preemptible_tcs;
+	u32 add_frag_size;
+	bool mapping_configured;
 };
 
 struct stmmac_tc_entry {
@@ -194,6 +197,10 @@ struct stmmac_flow_entry {
 	unsigned long cookie;
 	unsigned long action;
 	u8 ip_proto;
+	u32 ip4_src;
+	u32 ip4_dst;
+	u16 port_src;
+	u16 port_dst;
 	int in_use;
 	int idx;
 	int is_l4;
@@ -440,6 +447,7 @@ void stmmac_set_ethtool_ops(struct net_device *netdev);
 void stmmac_ptp_register(struct stmmac_priv *priv);
 void stmmac_ptp_unregister(struct stmmac_priv *priv);
 int stmmac_ptp_restore(struct stmmac_priv *priv);
+int stmmac_tc_restore_filters(struct stmmac_priv *priv);
 int stmmac_xdp_open(struct net_device *dev);
 void stmmac_xdp_release(struct net_device *dev);
 int stmmac_get_phy_intf_sel(phy_interface_t interface);
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_est.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_est.c
index 49edfebbc39e..059ef60c13d0 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_est.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_est.c
@@ -80,29 +80,42 @@ static int est_configure(struct stmmac_priv *priv, struct stmmac_est *cfg,
 	return 0;
 }
 
-int __stmmac_setup_est(struct stmmac_priv *priv)
+/* Program either the installed schedule or an unpublished replacement. */
+int __stmmac_setup_est(struct stmmac_priv *priv, struct stmmac_est *est)
 {
 	struct timespec64 current_time, time;
 	ktime_t current_time_ns, basetime;
+	unsigned long flags;
+	u64 now;
 	u64 cycle_time;
 	int err;
 
 	lockdep_assert_held(&priv->est_lock);
+	lockdep_assert_held(&priv->ptp_mutex);
 
-	priv->ptp_clock_ops.gettime64(&priv->ptp_clock_ops, &current_time);
+	if (!priv->ptp_enabled)
+		return -EOPNOTSUPP;
+
+	/* Reset replay owns ptp_mutex while public PHC reads are blocked. */
+	read_lock_irqsave(&priv->ptp_lock, flags);
+	err = stmmac_get_systime(priv, priv->ptpaddr, &now);
+	read_unlock_irqrestore(&priv->ptp_lock, flags);
+	if (err)
+		return err;
+	current_time = ns_to_timespec64(now);
 	current_time_ns = timespec64_to_ktime(current_time);
 
-	time.tv_nsec = priv->est.btr_reserve[0];
-	time.tv_sec = priv->est.btr_reserve[1];
+	time.tv_nsec = est->btr_reserve[0];
+	time.tv_sec = est->btr_reserve[1];
 	basetime = timespec64_to_ktime(time);
 
-	cycle_time = (u64)priv->est.ctr[1] * NSEC_PER_SEC + priv->est.ctr[0];
+	cycle_time = (u64)est->ctr[1] * NSEC_PER_SEC + est->ctr[0];
 
 	time = stmmac_calc_tas_basetime(basetime, current_time_ns, cycle_time);
-	priv->est.btr[0] = (u32)time.tv_nsec;
-	priv->est.btr[1] = (u32)time.tv_sec;
+	est->btr[0] = (u32)time.tv_nsec;
+	est->btr[1] = (u32)time.tv_sec;
 
-	err = stmmac_est_configure(priv, priv, &priv->est,
+	err = stmmac_est_configure(priv, priv, est,
 				   priv->plat->clk_ptp_rate, true);
 	if (err)
 		netdev_err(priv->dev, "failed to re-configure EST\n");
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_est.h b/drivers/net/ethernet/stmicro/stmmac/stmmac_est.h
index b4d1a1f04f10..5665e7a53994 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_est.h
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_est.h
@@ -66,14 +66,14 @@
 
 extern const struct stmmac_est_ops dwmac510_est_ops;
 
-int __stmmac_setup_est(struct stmmac_priv *priv);
+int __stmmac_setup_est(struct stmmac_priv *priv, struct stmmac_est *est);
 static inline int stmmac_setup_est(struct stmmac_priv *priv)
 {
 	int ret = 0;
 
 	mutex_lock(&priv->est_lock);
 	if (priv->est.enable)
-		ret = __stmmac_setup_est(priv);
+		ret = __stmmac_setup_est(priv, &priv->est);
 	mutex_unlock(&priv->est_lock);
 
 	return ret;
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.c
index c889204a7aa5..067ea1f5134b 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.c
@@ -195,6 +195,7 @@ void stmmac_fpe_set_add_frag_size(struct stmmac_priv *priv, u32 add_frag_size)
 	value = readl(ioaddr + reg->mtl_fpe_reg);
 	writel(u32_replace_bits(value, add_frag_size, FPE_MTL_ADD_FRAG_SZ),
 	       ioaddr + reg->mtl_fpe_reg);
+	priv->fpe_cfg.add_frag_size = add_frag_size;
 }
 
 #define ALG_ERR_MSG "TX algorithm SP is not suitable for one-to-many mapping"
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 95757f3cbc64..f5060924dae8 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -3829,6 +3829,11 @@ static int stmmac_hw_setup(struct net_device *dev)
 		if (ret)
 			return ret;
 	}
+	ret = stmmac_tc_restore_filters(priv);
+	if (ret)
+		return ret;
+	if (stmmac_fpe_supported(priv))
+		stmmac_fpe_set_add_frag_size(priv, priv->fpe_cfg.add_frag_size);
 
 	/* Initialize Safety Features */
 	stmmac_safety_feat_configuration(priv);
@@ -3891,9 +3896,6 @@ static int stmmac_hw_setup(struct net_device *dev)
 		stmmac_enable_tbs(priv, priv->ioaddr, enable, chan);
 	}
 
-	/* Start the ball rolling... */
-	stmmac_start_all_dma(priv);
-
 	phylink_rx_clk_stop_block(priv->phylink);
 	stmmac_set_hw_vlan_mode(priv, priv->hw);
 	phylink_rx_clk_stop_unblock(priv->phylink);
@@ -4441,16 +4443,17 @@ static int __stmmac_open(struct net_device *dev,
 	if (ret)
 		goto init_error;
 
-	/* The core soft reset in stmmac_hw_setup() clears the MTL_EST
-	 * registers, so re-apply the taprio offload after PTP is up.
-	 */
-	ret = stmmac_setup_est(priv);
-	if (ret < 0)
-		goto est_error;
-
 	stmmac_init_coalesce(priv);
 
 	stmmac_vlan_restore(priv);
+	mutex_lock(&priv->ptp_mutex);
+	ret = stmmac_setup_est(priv);
+	mutex_unlock(&priv->ptp_mutex);
+	if (ret)
+		goto irq_error;
+
+	/* All reset-sensitive offloads must be installed before DMA runs. */
+	stmmac_start_all_dma(priv);
 
 	ret = stmmac_request_irq(dev);
 	if (ret)
@@ -4478,7 +4481,6 @@ static int __stmmac_open(struct net_device *dev,
 	for (chan = 0; chan < priv->plat->tx_queues_to_use; chan++)
 		hrtimer_cancel(&priv->dma_conf->tx_queue[chan].txtimer);
 
-est_error:
 	stmmac_release_ptp(priv);
 init_error:
 	/* Undo phylink_prepare_resume() even if hardware setup failed before
@@ -8892,10 +8894,11 @@ int stmmac_resume(struct device *dev)
 
 init_coalesce:
 	mutex_lock(&priv->ptp_mutex);
-	stmmac_block_ptp(priv, false);
-	mutex_unlock(&priv->ptp_mutex);
 	ret = stmmac_setup_est(priv);
-	if (ret < 0)
+	if (!ret)
+		stmmac_block_ptp(priv, false);
+	mutex_unlock(&priv->ptp_mutex);
+	if (ret)
 		goto error_stop_dma;
 
 	stmmac_init_coalesce(priv);
@@ -8905,6 +8908,7 @@ int stmmac_resume(struct device *dev)
 
 	stmmac_vlan_restore(priv);
 
+	stmmac_start_all_dma(priv);
 	stmmac_enable_all_queues(priv);
 	stmmac_enable_all_dma_irq(priv);
 	stmmac_unmask_pci_irq(priv);
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
index b34711231227..f27c6ff210a3 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
@@ -107,7 +107,7 @@ static int stmmac_adjust_time(struct ptp_clock_info *ptp, s64 delta)
 	 * error, but do not report success if only schedule replay failed.
 	 */
 	if (priv->est.enable) {
-		err = __stmmac_setup_est(priv);
+		err = __stmmac_setup_est(priv, &priv->est);
 		if (!ret)
 			ret = err;
 	}
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
index cac2b6e34c94..06089d47f373 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
@@ -15,12 +15,17 @@
 static int tc_config_preemption(struct stmmac_priv *priv,
 				struct netlink_ext_ack *extack, u32 preemptible_tcs)
 {
-	/* Qdisc teardown must not access unpowered registers. */
-	if (priv->hw_unavailable)
-		return 0;
+	int ret = 0;
 
-	return stmmac_fpe_map_preemption_class(priv, priv->dev, extack,
-					      preemptible_tcs);
+	/* Qdisc teardown still clears the saved mapping after failed resume. */
+	if (!priv->hw_unavailable)
+		ret = stmmac_fpe_map_preemption_class(priv, priv->dev, extack,
+						      preemptible_tcs);
+	if (!ret) {
+		priv->fpe_cfg.preemptible_tcs = preemptible_tcs;
+		priv->fpe_cfg.mapping_configured = true;
+	}
+	return ret;
 }
 
 static void tc_fill_all_pass_entry(struct stmmac_tc_entry *entry)
@@ -520,31 +525,15 @@ static int tc_add_ip4_flow(struct stmmac_priv *priv,
 {
 	struct flow_rule *rule = flow_cls_offload_flow_rule(cls);
 	struct flow_dissector *dissector = rule->match.dissector;
-	bool inv = entry->action & STMMAC_FLOW_ACTION_DROP;
 	struct flow_match_ipv4_addrs match;
-	u32 hw_match;
-	int ret;
 
 	/* Nothing to do here */
 	if (!dissector_uses_key(dissector, FLOW_DISSECTOR_KEY_IPV4_ADDRS))
 		return -EINVAL;
 
 	flow_rule_match_ipv4_addrs(rule, &match);
-	hw_match = ntohl(match.key->src) & ntohl(match.mask->src);
-	if (hw_match) {
-		ret = stmmac_config_l3_filter(priv, priv->hw, entry->idx, true,
-					      false, true, inv, hw_match);
-		if (ret)
-			return ret;
-	}
-
-	hw_match = ntohl(match.key->dst) & ntohl(match.mask->dst);
-	if (hw_match) {
-		ret = stmmac_config_l3_filter(priv, priv->hw, entry->idx, true,
-					      false, false, inv, hw_match);
-		if (ret)
-			return ret;
-	}
+	entry->ip4_src = ntohl(match.key->src) & ntohl(match.mask->src);
+	entry->ip4_dst = ntohl(match.key->dst) & ntohl(match.mask->dst);
 
 	return 0;
 }
@@ -555,11 +544,7 @@ static int tc_add_ports_flow(struct stmmac_priv *priv,
 {
 	struct flow_rule *rule = flow_cls_offload_flow_rule(cls);
 	struct flow_dissector *dissector = rule->match.dissector;
-	bool inv = entry->action & STMMAC_FLOW_ACTION_DROP;
 	struct flow_match_ports match;
-	u32 hw_match;
-	bool is_udp;
-	int ret;
 
 	/* Nothing to do here */
 	if (!dissector_uses_key(dissector, FLOW_DISSECTOR_KEY_PORTS))
@@ -567,10 +552,7 @@ static int tc_add_ports_flow(struct stmmac_priv *priv,
 
 	switch (entry->ip_proto) {
 	case IPPROTO_TCP:
-		is_udp = false;
-		break;
 	case IPPROTO_UDP:
-		is_udp = true;
 		break;
 	default:
 		return -EINVAL;
@@ -578,23 +560,46 @@ static int tc_add_ports_flow(struct stmmac_priv *priv,
 
 	flow_rule_match_ports(rule, &match);
 
-	hw_match = ntohs(match.key->src) & ntohs(match.mask->src);
-	if (hw_match) {
-		ret = stmmac_config_l4_filter(priv, priv->hw, entry->idx, true,
-					      is_udp, true, inv, hw_match);
+	entry->port_src = ntohs(match.key->src) & ntohs(match.mask->src);
+	entry->port_dst = ntohs(match.key->dst) & ntohs(match.mask->dst);
+
+	entry->is_l4 = true;
+	return 0;
+}
+
+static int tc_config_flow(struct stmmac_priv *priv,
+			  const struct stmmac_flow_entry *entry)
+{
+	bool inv = entry->action & STMMAC_FLOW_ACTION_DROP;
+	bool udp = entry->ip_proto == IPPROTO_UDP;
+	int ret;
+
+	/* Clear the whole slot, including matches removed by a replacement. */
+	ret = stmmac_config_l3_filter(priv, priv->hw, entry->idx, false,
+				      false, false, false, 0);
+	if (ret || !entry->in_use)
+		return ret;
+	if (entry->ip4_src) {
+		ret = stmmac_config_l3_filter(priv, priv->hw, entry->idx, true,
+					      false, true, inv, entry->ip4_src);
 		if (ret)
 			return ret;
 	}
-
-	hw_match = ntohs(match.key->dst) & ntohs(match.mask->dst);
-	if (hw_match) {
+	if (entry->ip4_dst) {
+		ret = stmmac_config_l3_filter(priv, priv->hw, entry->idx, true,
+					      false, false, inv, entry->ip4_dst);
+		if (ret)
+			return ret;
+	}
+	if (entry->port_src) {
 		ret = stmmac_config_l4_filter(priv, priv->hw, entry->idx, true,
-					      is_udp, false, inv, hw_match);
+					    udp, true, inv, entry->port_src);
 		if (ret)
 			return ret;
 	}
-
-	entry->is_l4 = true;
+	if (entry->port_dst)
+		return stmmac_config_l4_filter(priv, priv->hw, entry->idx, true,
+					      udp, false, inv, entry->port_dst);
 	return 0;
 }
 
@@ -630,6 +635,7 @@ static int tc_add_flow(struct stmmac_priv *priv,
 {
 	struct stmmac_flow_entry *entry = tc_find_flow(priv, cls, false);
 	struct flow_rule *rule = flow_cls_offload_flow_rule(cls);
+	struct stmmac_flow_entry new = {};
 	int i, ret;
 
 	if (!entry) {
@@ -638,23 +644,33 @@ static int tc_add_flow(struct stmmac_priv *priv,
 			return -ENOENT;
 	}
 
-	ret = tc_parse_flow_actions(priv, &rule->action, entry,
+	new.idx = entry->idx;
+	ret = tc_parse_flow_actions(priv, &rule->action, &new,
 				    cls->common.extack);
 	if (ret)
 		return ret;
 
 	for (i = 0; i < ARRAY_SIZE(tc_flow_parsers); i++) {
-		ret = tc_flow_parsers[i].fn(priv, cls, entry);
+		ret = tc_flow_parsers[i].fn(priv, cls, &new);
 		if (!ret)
-			entry->in_use = true;
+			new.in_use = true;
 		else if (ret == -EOPNOTSUPP)
 			return ret;
 	}
 
-	if (!entry->in_use)
+	if (!new.in_use)
 		return -EINVAL;
 
-	entry->cookie = cls->cookie;
+	ret = tc_config_flow(priv, &new);
+	if (ret) {
+		/* Do not publish a rule that was only partially programmed. */
+		if (tc_config_flow(priv, entry))
+			netdev_err(priv->dev, "failed to restore flower filter %d\n",
+				   entry->idx);
+		return ret;
+	}
+	new.cookie = cls->cookie;
+	*entry = new;
 	return 0;
 }
 
@@ -740,6 +756,8 @@ static int tc_add_vlan_flow(struct stmmac_priv *priv,
 
 		prio = BIT(match.key->vlan_priority);
 		stmmac_rx_queue_prio(priv, priv->hw, prio, tc);
+		priv->plat->rx_queues_cfg[tc].prio = prio;
+		priv->plat->rx_queues_cfg[tc].use_prio = true;
 
 		entry->in_use = true;
 		entry->cookie = cls->cookie;
@@ -761,6 +779,8 @@ static int tc_del_vlan_flow(struct stmmac_priv *priv,
 
 	if (stmmac_tc_active(priv))
 		stmmac_rx_queue_prio(priv, priv->hw, 0, entry->tc);
+	priv->plat->rx_queues_cfg[entry->tc].prio = 0;
+	priv->plat->rx_queues_cfg[entry->tc].use_prio = true;
 
 	entry->in_use = false;
 	entry->cookie = 0;
@@ -935,6 +955,45 @@ static int tc_setup_cls(struct stmmac_priv *priv,
 	return ret;
 }
 
+int stmmac_tc_restore_filters(struct stmmac_priv *priv)
+{
+	int i, ret;
+
+	for (i = 0; i < priv->flow_entries_max; i++) {
+		struct stmmac_flow_entry *entry = &priv->flow_entries[i];
+
+		if (!entry->in_use)
+			continue;
+		ret = tc_config_flow(priv, entry);
+		if (ret)
+			return ret;
+	}
+	for (i = 0; i < priv->rfs_entries_total; i++) {
+		struct stmmac_rfs_entry *entry = &priv->rfs_entries[i];
+
+		if (!entry->in_use)
+			continue;
+		switch (entry->type) {
+		/* VLAN priorities are replayed by stmmac_mtl_configuration(). */
+		case STMMAC_RFS_T_VLAN:
+			break;
+		case STMMAC_RFS_T_LLDP:
+			stmmac_rx_queue_routing(priv, priv->hw, PACKET_DCBCPQ,
+						entry->tc);
+			break;
+		case STMMAC_RFS_T_1588:
+			stmmac_rx_queue_routing(priv, priv->hw, PACKET_PTPQ,
+						entry->tc);
+			break;
+		}
+	}
+	/* The XGMAC callback also restores the runtime TC-to-queue mapping. */
+	if (priv->fpe_cfg.mapping_configured)
+		return tc_config_preemption(priv, NULL,
+					    priv->fpe_cfg.preemptible_tcs);
+	return 0;
+}
+
 struct timespec64 stmmac_calc_tas_basetime(ktime_t old_base_time,
 					   ktime_t current_time,
 					   u64 cycle_time)
@@ -958,7 +1017,7 @@ struct timespec64 stmmac_calc_tas_basetime(ktime_t old_base_time,
 	return time;
 }
 
-static void tc_taprio_map_maxsdu_txq(struct stmmac_priv *priv,
+static void tc_taprio_map_maxsdu_txq(struct stmmac_est *est,
 				     struct tc_taprio_qopt_offload *qopt)
 {
 	u32 num_tc = qopt->mqprio.qopt.num_tc;
@@ -975,7 +1034,7 @@ static void tc_taprio_map_maxsdu_txq(struct stmmac_priv *priv,
 		count = qopt->mqprio.qopt.count[i];
 
 		for (j = offset; j < offset + count; j++)
-			priv->est.max_sdu[j] = qopt->max_sdu[i] + ETH_HLEN - ETH_TLEN;
+			est->max_sdu[j] = qopt->max_sdu[i] + ETH_HLEN - ETH_TLEN;
 	}
 }
 
@@ -984,10 +1043,10 @@ static int tc_taprio_configure(struct stmmac_priv *priv,
 {
 	u32 size, wid = priv->dma_cap.estwid, dep = priv->dma_cap.estdep;
 	struct netlink_ext_ack *extack = qopt->mqprio.extack;
+	struct timespec64 qopt_time;
 	u64 ctr = qopt->cycle_time;
-	struct timespec64 time;
-	u32 *gcl = NULL;
-	int i, ret = 0;
+	struct stmmac_est *est;
+	int i, ret;
 
 	if (qopt->base_time < 0)
 		return -ERANGE;
@@ -1032,48 +1091,43 @@ static int tc_taprio_configure(struct stmmac_priv *priv,
 		return -EOPNOTSUPP;
 	}
 
-	mutex_lock(&priv->est_lock);
-
 	if (qopt->cmd == TAPRIO_CMD_DESTROY)
 		goto disable;
-	if (priv->hw_unavailable) {
-		ret = -EHOSTDOWN;
-		goto unlock;
-	}
-
-	if (qopt->num_entries > dep) {
-		ret = -EINVAL;
-		goto unlock;
-	}
-
-	if (!qopt->cycle_time) {
-		ret = -ERANGE;
-		goto unlock;
-	}
+	if (priv->hw_unavailable)
+		return -EHOSTDOWN;
+	if (!priv->ptp_enabled || !priv->ptp_clock_ops.gettime64)
+		return -EOPNOTSUPP;
+	/* Unlike reset replay, a new schedule requires an accessible PHC. */
+	if (priv->ptp_blocked)
+		return -EBUSY;
 
-	if (qopt->cycle_time_extension >= BIT(wid + 7)) {
-		ret = -ERANGE;
-		goto unlock;
-	}
+	if (qopt->num_entries > dep)
+		return -EINVAL;
+	if (!qopt->cycle_time)
+		return -ERANGE;
+	if (qopt->cycle_time_extension >= BIT(wid + 7))
+		return -ERANGE;
 
-	gcl = kzalloc(sizeof(*gcl) * EST_GCL, GFP_KERNEL);
-	if (!gcl) {
-		ret = -ENOMEM;
-		goto unlock;
-	}
+	/* Build the replacement without changing the installed schedule. An
+	 * entry rejected below must not leave an enabled, zero-cycle cache for
+	 * PHC adjustment or reset replay to consume.
+	 */
+	est = kzalloc_obj(*est);
+	if (!est)
+		return -ENOMEM;
 
 	size = qopt->num_entries;
+	est->gcl_size = size;
+	est->enable = true;
+
 	for (i = 0; i < size; i++) {
 		s64 delta_ns = qopt->entries[i].interval;
 		u32 gates = qopt->entries[i].gate_mask;
 
-		if (delta_ns > GENMASK(wid - 1, 0)) {
+		if (delta_ns > GENMASK(wid - 1, 0) ||
+		    gates > GENMASK(31 - wid, 0)) {
 			ret = -ERANGE;
-			goto free_gcl;
-		}
-		if (gates > GENMASK(31 - wid, 0)) {
-			ret = -ERANGE;
-			goto free_gcl;
+			goto free_est;
 		}
 
 		switch (qopt->entries[i].command) {
@@ -1087,61 +1141,59 @@ static int tc_taprio_configure(struct stmmac_priv *priv,
 			break;
 		default:
 			ret = -EOPNOTSUPP;
-			goto free_gcl;
+			goto free_est;
 		}
 
-		gcl[i] = delta_ns | (gates << wid);
+		est->gcl[i] = delta_ns | (gates << wid);
 	}
 
-	memset(&priv->est, 0, sizeof(priv->est));
-	memcpy(priv->est.gcl, gcl, sizeof(priv->est.gcl));
-	priv->est.gcl_size = size;
-
-	time = ktime_to_timespec64(qopt->base_time);
-	priv->est.btr_reserve[0] = (u32)time.tv_nsec;
-	priv->est.btr_reserve[1] = (u32)time.tv_sec;
+	qopt_time = ktime_to_timespec64(qopt->base_time);
+	est->btr_reserve[0] = (u32)qopt_time.tv_nsec;
+	est->btr_reserve[1] = (u32)qopt_time.tv_sec;
+	est->ctr[0] = do_div(ctr, NSEC_PER_SEC);
+	est->ctr[1] = (u32)ctr;
+	est->ter = qopt->cycle_time_extension;
 
-	priv->est.ctr[0] = do_div(ctr, NSEC_PER_SEC);
-	priv->est.ctr[1] = (u32)ctr;
+	tc_taprio_map_maxsdu_txq(est, qopt);
 
-	priv->est.ter = qopt->cycle_time_extension;
-	tc_taprio_map_maxsdu_txq(priv, qopt);
-
-	ret = __stmmac_setup_est(priv);
+	mutex_lock(&priv->est_lock);
+	ret = __stmmac_setup_est(priv, est);
 	if (ret)
-		goto disable;
+		goto restore;
 
 	ret = tc_config_preemption(priv, extack, qopt->mqprio.preemptible_tcs);
 	if (ret)
-		goto disable;
-
-	priv->est.enable = true;
-	kfree(gcl);
+		goto restore;
 
+	priv->est = *est;
 	mutex_unlock(&priv->est_lock);
+free_est:
+	kfree(est);
+	return ret;
 
-	return 0;
+restore:
+	/* A failed hardware update must not publish the rejected schedule. */
+	if (stmmac_est_configure(priv, priv, &priv->est,
+				 priv->plat->clk_ptp_rate, priv->est.enable))
+		netdev_err(priv->dev, "failed to restore EST\n");
+	mutex_unlock(&priv->est_lock);
+	goto free_est;
 
 disable:
+	mutex_lock(&priv->est_lock);
 	priv->est.enable = false;
 	if (!priv->hw_unavailable)
 		stmmac_est_configure(priv, priv, &priv->est,
 				     priv->plat->clk_ptp_rate, false);
-	/* Reset taprio status */
+	/* Reset taprio stats */
 	for (i = 0; i < priv->plat->tx_queues_to_use; i++) {
 		priv->xstats.max_sdu_txq_drop[i] = 0;
 		priv->xstats.mtl_est_txq_hlbf[i] = 0;
 		priv->xstats.mtl_est_txq_hlbs[i] = 0;
 	}
-	i = tc_config_preemption(priv, extack, 0);
-	if (qopt->cmd == TAPRIO_CMD_DESTROY)
-		ret = i;
-free_gcl:
-	kfree(gcl);
-unlock:
 	mutex_unlock(&priv->est_lock);
 
-	return ret;
+	return tc_config_preemption(priv, extack, 0);
 }
 
 static void tc_taprio_stats(struct stmmac_priv *priv,
@@ -1182,7 +1234,10 @@ static int tc_setup_taprio(struct stmmac_priv *priv,
 	switch (qopt->cmd) {
 	case TAPRIO_CMD_REPLACE:
 	case TAPRIO_CMD_DESTROY:
+		/* Serialize cache publication with PHC adjustment and reset replay. */
+		mutex_lock(&priv->ptp_mutex);
 		err = tc_taprio_configure(priv, qopt);
+		mutex_unlock(&priv->ptp_mutex);
 		break;
 	case TAPRIO_CMD_STATS:
 		tc_taprio_stats(priv, qopt);

-- 
2.53.0

