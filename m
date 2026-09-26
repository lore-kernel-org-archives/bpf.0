Received: from mail-oo2-f37.google.com (mail-oo2-f37.google.com [74.125.231.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E962C37E5F5
	for <bpf@vger.kernel.org>; Sat, 26 Sep 2026 15:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790437789; cv=none; b=g76dU13S/o51dReNj7AyQUJFeenVjz8pOJNXClsu/brPW6GzjyskEqZjCdFjruLLbbHc1RBjlEIOTHVDSQT80ALl+KW+vM7tnBIc1YOUIxb/UodhEsisseBatgshC9uQSWE+zUGkUIdLlgJ+XUdUARg1BUhi/BG/ST/Rp5caGPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790437789; c=relaxed/simple;
	bh=AAtTdvZNrumwoPmEQLjH0UMJLifFnY3iZ+J8gFMDj0s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lDLOe9E+NL9C8Rai3EDJuxG8PO2xu9s7qyv1Ql7oUjlFxdAgy+snXXHd4nNIm9iVX2M6NCqVs3hYeAgu8nCrdgNgf2ajMjB6U1t+4m/BOVyZ4N7seypKMU8NorO0jHgG/ItVnVx88V7CqSi+XCZAW5JIRTRbZkd8wqWrqrkQCy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lVgyT9ZN; arc=none smtp.client-ip=74.125.231.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lVgyT9ZN"
Received: by mail-oo2-f37.google.com with SMTP id 46e09a7af769-7fcb425fc2bso1178413a34.3
        for <bpf@vger.kernel.org>; Sat, 26 Sep 2026 08:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790437783; x=1791042583; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Q30zsdAglVy5fQcIaWXAHFq5dI/FtpUN3Zb+euSKjCs=;
        b=lVgyT9ZNWDq1v2vYk18T7sv3wFR/R4txc7ZSpm46c8JszfhlyluTu4xPpUKfzWl92q
         CZpqGZGqniWZljHS6LKhL0LcLTZ4D9ooIBRAVa96FxWjOXXiusyzWFoDmKzM7yQPYBJC
         4rT27h9KZXPYag60pPnGfW3AzhOp873LWCO5MMIzxwHArwFczQecZv/VouwK5NANeYaf
         5Q2kljrMG+crlDnPDroozHvVvsXSXB/a3bHlvnzm9htIBowXs1joZizUsh8ReATp+frj
         y6N5CK9tFVzeQKVa1oOUOKsXIaoG44WysIUMsbkU716yTqMdECPobx5fdyOQSNhX3djn
         axDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790437783; x=1791042583;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Q30zsdAglVy5fQcIaWXAHFq5dI/FtpUN3Zb+euSKjCs=;
        b=g+AMF7U0qfO6JKxsL0aon9nwT3W9aqLsTzVxqisaQ2+5ASNCqWs/a34/IVLXXU5g9E
         iAln00k+B5IPc9VozxGGG8uOkONgG7xE82rtOAxF2x7Fn1gX4ALZ6xtVElNd2lob6R5I
         /+C/zWq2O3Kxeg1xSCCnD5tJG0ZQbjdgaB3c0RrBes5REhCtgklLjaFcQay2oCLz/M3K
         lfobQcc6vqUV3UvBicH/K5+FXMq+9Jgr54J4Pf43i2M1BY1kIYNmnAiGRhBCbyHQdpYV
         OtVICUkTrIO6wQfKkOQyDVOktaEiwVR+b/+/2ivpcy9XKpzIqfflyvItHlQgR4FlqIy4
         rYVQ==
X-Forwarded-Encrypted: i=1; AKwUvBxwvQXi4bhrwacYnpueM8zFqmZ400RTew37p7Uyy/QynstyIsY1CMQ9pv62of6rhabBKrI=@vger.kernel.org
X-Gm-Message-State: AFuF++keXz4hzuXCpmh+kCFfKcsYfWYu2yN0S3+zVRxWBDHagWxJfKYI
	xWaslTSh2px98136812KtBG2hMYhguKbqIsDNNswDTCQ5EEAEty5hQOE
X-Gm-Gg: AYBFou030fLmVOeO/j5KvsgDeHitYJ1o7hPzGiYezX3rjYMkwHu8ab5iuAM9KAz1M7S
	i7a3ueq/MkAfCzUkRDmc1FBV+OkzyRG+q0ihOCkuH9hmPZeM1W9ywAhIEy2KSNOMSltHTCni7X1
	+VX65XrDE6amtlEvtS0s5R7sKC8r4YI4998x3Fj+bKSAGqoPoAGSNaBM/fl7rvEJuu5lMPGLeu/
	9WAZ/brcRUIjDH2d1RdmMTRjExLxLuW/Lgrky97hOc6blbq4XEWFGAI3toMcqZoDIwg1GbzzF8K
	2lPupcL0v/lv+uUq8YWMGajP9Q1dGBKl/b/2pU54JbasSh/qGmD9V9MxkXld3MOwKbB26GALr0h
	xIGn48eg73OUNk7XeLub/k4beSoH9Gyp8Dmp4Ol2lnqcFmKp9WdgoRjfhqmpas8mcXb8n1+6Kva
	TNDNcL6qmmSAeBKS3q3pomHqihUEdlPVocItL/GIXkobRJcqCOEj0q+VgA79zKo5WJgEGRY3xpb
	6UT77srJomvOrDLK9scHIpeA1ua50aaguZlLNzAMbVaoo1FL+GZDw2FgWHy/JDuo9X8E99LYW3N
	9XWnPNrQKuXq33wb+T4F4NxRGP7x0xYy3y0E7Y9xNWbZxjTWKBKovpchn4vszGM1T9v5j4vHiCF
	mXzYugSwNdSMhovBSGOQd
X-Received: by 2002:a05:6830:3887:b0:7f5:17:3f2a with SMTP id 46e09a7af769-8178317d7ddmr9815575a34.15.1790437783091;
        Sat, 26 Sep 2026 08:49:43 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-818e98b16d4sm5442366a34.26.2026.09.26.08.49.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 08:49:42 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sat, 26 Sep 2026 09:49:06 -0600
Subject: [PATCH net v4 11/15] net: stmmac: restore TC offloads before
 restarting DMA
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260926-submit-stmmac-reset-fixes-v1-v4-11-ec1c0250b3c9@gmail.com>
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

A DMA software reset loses MAC filters and the MTL gate schedule, not
just the ring addresses. Restore those offloads during ordinary hardware
setup and resume. The later live-XDP reset fallback and retained-ring
MTU transaction will use the same restoration.

Keep the parsed L3/L4 rule rather than only its cookie. Program from
that saved definition both when installing a rule and after reset. Do
not publish a partially programmed replacement; restore the previous
slot when installation fails. Keep runtime VLAN priorities in the
existing queue configuration and replay EtherType steering and the
configured preemption/TC mapping. Preserve the additional fragment size.

Restore EST after the timestamp counter is usable, advancing its saved
base time by whole cycles when necessary. Delay DMA start until filters,
timestamp state and the gate schedule have been restored. Propagate a
replay error through the existing rollback or detached recovery path.

Build and validate TAPRIO replacements separately, including the PHC time
read, and publish the saved schedule only after hardware setup succeeds.
Keep the previous schedule on rejection and attempt to restore it after
a programming error. A rejected first install must not leave an enabled
zero-cycle cache for PHC adjustment or reset replay. Serialize schedule
publication with those consumers under the PTP mutex.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac.h      |   9 +
 drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.c  |   1 +
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c |  25 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c   | 286 +++++++++++++++-------
 4 files changed, 226 insertions(+), 95 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac.h b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
index b65f47db3c2e..6abb0d1d4095 100644
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
@@ -433,6 +440,8 @@ void stmmac_set_ethtool_ops(struct net_device *netdev);
 void stmmac_ptp_register(struct stmmac_priv *priv);
 void stmmac_ptp_unregister(struct stmmac_priv *priv);
 int stmmac_ptp_restore(struct stmmac_priv *priv);
+int stmmac_tc_restore_filters(struct stmmac_priv *priv);
+int stmmac_tc_restore_est(struct stmmac_priv *priv);
 int stmmac_xdp_open(struct net_device *dev);
 void stmmac_xdp_release(struct net_device *dev);
 int stmmac_get_phy_intf_sel(phy_interface_t interface);
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
index 618e01772ab8..edcb9a025385 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -3756,6 +3756,11 @@ static int stmmac_hw_setup(struct net_device *dev)
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
@@ -3818,9 +3823,6 @@ static int stmmac_hw_setup(struct net_device *dev)
 		stmmac_enable_tbs(priv, priv->ioaddr, enable, chan);
 	}
 
-	/* Start the ball rolling... */
-	stmmac_start_all_dma(priv);
-
 	phylink_rx_clk_stop_block(priv->phylink);
 	stmmac_set_hw_vlan_mode(priv, priv->hw);
 	phylink_rx_clk_stop_unblock(priv->phylink);
@@ -4348,6 +4350,14 @@ static int __stmmac_open(struct net_device *dev,
 	stmmac_init_coalesce(priv);
 
 	stmmac_vlan_restore(priv);
+	mutex_lock(&priv->ptp_mutex);
+	ret = stmmac_tc_restore_est(priv);
+	mutex_unlock(&priv->ptp_mutex);
+	if (ret)
+		goto irq_error;
+
+	/* All reset-sensitive offloads must be installed before DMA runs. */
+	stmmac_start_all_dma(priv);
 
 	ret = stmmac_request_irq(dev);
 	if (ret)
@@ -8722,10 +8732,14 @@ int stmmac_resume(struct device *dev)
 		goto error_stop_dma;
 	}
 
-	stmmac_init_timestamping(priv);
 	mutex_lock(&priv->ptp_mutex);
-	stmmac_block_ptp(priv, false);
+	stmmac_init_timestamping(priv);
+	ret = stmmac_tc_restore_est(priv);
+	if (!ret)
+		stmmac_block_ptp(priv, false);
 	mutex_unlock(&priv->ptp_mutex);
+	if (ret)
+		goto error_stop_dma;
 
 	stmmac_init_coalesce(priv);
 	phylink_rx_clk_stop_block(priv->phylink);
@@ -8734,6 +8748,7 @@ int stmmac_resume(struct device *dev)
 
 	stmmac_vlan_restore(priv);
 
+	stmmac_start_all_dma(priv);
 	stmmac_enable_all_queues(priv);
 	stmmac_enable_all_dma_irq(priv);
 
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
index 9ded65750e89..de254919f6ab 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
@@ -14,12 +14,17 @@
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
@@ -519,31 +524,15 @@ static int tc_add_ip4_flow(struct stmmac_priv *priv,
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
@@ -554,11 +543,7 @@ static int tc_add_ports_flow(struct stmmac_priv *priv,
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
@@ -566,10 +551,7 @@ static int tc_add_ports_flow(struct stmmac_priv *priv,
 
 	switch (entry->ip_proto) {
 	case IPPROTO_TCP:
-		is_udp = false;
-		break;
 	case IPPROTO_UDP:
-		is_udp = true;
 		break;
 	default:
 		return -EINVAL;
@@ -577,23 +559,46 @@ static int tc_add_ports_flow(struct stmmac_priv *priv,
 
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
 
@@ -629,6 +634,7 @@ static int tc_add_flow(struct stmmac_priv *priv,
 {
 	struct stmmac_flow_entry *entry = tc_find_flow(priv, cls, false);
 	struct flow_rule *rule = flow_cls_offload_flow_rule(cls);
+	struct stmmac_flow_entry new = {};
 	int i, ret;
 
 	if (!entry) {
@@ -637,23 +643,33 @@ static int tc_add_flow(struct stmmac_priv *priv,
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
 
@@ -739,6 +755,8 @@ static int tc_add_vlan_flow(struct stmmac_priv *priv,
 
 		prio = BIT(match.key->vlan_priority);
 		stmmac_rx_queue_prio(priv, priv->hw, prio, tc);
+		priv->plat->rx_queues_cfg[tc].prio = prio;
+		priv->plat->rx_queues_cfg[tc].use_prio = true;
 
 		entry->in_use = true;
 		entry->cookie = cls->cookie;
@@ -760,6 +778,8 @@ static int tc_del_vlan_flow(struct stmmac_priv *priv,
 
 	if (stmmac_tc_active(priv))
 		stmmac_rx_queue_prio(priv, priv->hw, 0, entry->tc);
+	priv->plat->rx_queues_cfg[entry->tc].prio = 0;
+	priv->plat->rx_queues_cfg[entry->tc].use_prio = true;
 
 	entry->in_use = false;
 	entry->cookie = 0;
@@ -934,6 +954,45 @@ static int tc_setup_cls(struct stmmac_priv *priv,
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
@@ -957,7 +1016,37 @@ struct timespec64 stmmac_calc_tas_basetime(ktime_t old_base_time,
 	return time;
 }
 
-static void tc_taprio_map_maxsdu_txq(struct stmmac_priv *priv,
+/* Called after timestamp setup and before DMA starts, with ptp_mutex held.
+ * The PHC can still be blocked while reset state is being restored.
+ */
+int stmmac_tc_restore_est(struct stmmac_priv *priv)
+{
+	struct stmmac_est *est = priv->est;
+	struct timespec64 base;
+	unsigned long flags;
+	u64 now, cycle;
+	int ret;
+
+	if (!est || !est->enable)
+		return 0;
+	mutex_lock(&priv->est_lock);
+	read_lock_irqsave(&priv->ptp_lock, flags);
+	ret = stmmac_get_systime(priv, priv->ptpaddr, &now);
+	read_unlock_irqrestore(&priv->ptp_lock, flags);
+	if (ret)
+		goto out;
+	cycle = (u64)est->ctr[1] * NSEC_PER_SEC + est->ctr[0];
+	base = stmmac_calc_tas_basetime(ktime_set(est->btr_reserve[1],
+						  est->btr_reserve[0]), now, cycle);
+	est->btr[0] = base.tv_nsec;
+	est->btr[1] = base.tv_sec;
+	ret = stmmac_est_configure(priv, priv, est, priv->plat->clk_ptp_rate);
+out:
+	mutex_unlock(&priv->est_lock);
+	return ret;
+}
+
+static void tc_taprio_map_maxsdu_txq(struct stmmac_est *est,
 				     struct tc_taprio_qopt_offload *qopt)
 {
 	u32 num_tc = qopt->mqprio.qopt.num_tc;
@@ -974,7 +1063,7 @@ static void tc_taprio_map_maxsdu_txq(struct stmmac_priv *priv,
 		count = qopt->mqprio.qopt.count[i];
 
 		for (j = offset; j < offset + count; j++)
-			priv->est->max_sdu[j] = qopt->max_sdu[i] + ETH_HLEN - ETH_TLEN;
+			est->max_sdu[j] = qopt->max_sdu[i] + ETH_HLEN - ETH_TLEN;
 	}
 }
 
@@ -984,8 +1073,9 @@ static int tc_taprio_configure(struct stmmac_priv *priv,
 	u32 size, wid = priv->dma_cap.estwid, dep = priv->dma_cap.estdep;
 	struct netlink_ext_ack *extack = qopt->mqprio.extack;
 	struct timespec64 time, current_time, qopt_time;
+	struct stmmac_est *est;
 	ktime_t current_time_ns;
-	int err, i, ret = 0;
+	int i, ret;
 	u64 ctr;
 
 	if (qopt->base_time < 0)
@@ -1040,34 +1130,27 @@ static int tc_taprio_configure(struct stmmac_priv *priv,
 	if (qopt->cycle_time_extension >= BIT(wid + 7))
 		return -ERANGE;
 
-	if (!priv->est) {
-		priv->est = devm_kzalloc(priv->device, sizeof(*priv->est),
-					 GFP_KERNEL);
-		if (!priv->est)
-			return -ENOMEM;
-
-		mutex_init(&priv->est_lock);
-	} else {
-		mutex_lock(&priv->est_lock);
-		memset(priv->est, 0, sizeof(*priv->est));
-		mutex_unlock(&priv->est_lock);
-	}
+	/* Build the replacement without changing the installed schedule. An
+	 * entry rejected below must not leave an enabled, zero-cycle cache for
+	 * PHC adjustment or reset replay to consume.
+	 */
+	est = kzalloc_obj(*est);
+	if (!est)
+		return -ENOMEM;
 
 	size = qopt->num_entries;
-
-	mutex_lock(&priv->est_lock);
-	priv->est->gcl_size = size;
-	priv->est->enable = qopt->cmd == TAPRIO_CMD_REPLACE;
-	mutex_unlock(&priv->est_lock);
+	est->gcl_size = size;
+	est->enable = true;
 
 	for (i = 0; i < size; i++) {
 		s64 delta_ns = qopt->entries[i].interval;
 		u32 gates = qopt->entries[i].gate_mask;
 
-		if (delta_ns > GENMASK(wid - 1, 0))
-			return -ERANGE;
-		if (gates > GENMASK(31 - wid, 0))
-			return -ERANGE;
+		if (delta_ns > GENMASK(wid - 1, 0) ||
+		    gates > GENMASK(31 - wid, 0)) {
+			ret = -ERANGE;
+			goto free_est;
+		}
 
 		switch (qopt->entries[i].command) {
 		case TC_TAPRIO_CMD_SET_GATES:
@@ -1079,47 +1162,69 @@ static int tc_taprio_configure(struct stmmac_priv *priv,
 			gates &= ~BIT(0);
 			break;
 		default:
-			return -EOPNOTSUPP;
+			ret = -EOPNOTSUPP;
+			goto free_est;
 		}
 
-		priv->est->gcl[i] = delta_ns | (gates << wid);
+		est->gcl[i] = delta_ns | (gates << wid);
 	}
 
-	mutex_lock(&priv->est_lock);
 	/* Adjust for real system time */
-	priv->ptp_clock_ops.gettime64(&priv->ptp_clock_ops, &current_time);
+	ret = priv->ptp_clock_ops.gettime64(&priv->ptp_clock_ops, &current_time);
+	if (ret)
+		goto free_est;
 	current_time_ns = timespec64_to_ktime(current_time);
 	time = stmmac_calc_tas_basetime(qopt->base_time, current_time_ns,
 					qopt->cycle_time);
 
-	priv->est->btr[0] = (u32)time.tv_nsec;
-	priv->est->btr[1] = (u32)time.tv_sec;
+	est->btr[0] = (u32)time.tv_nsec;
+	est->btr[1] = (u32)time.tv_sec;
 
 	qopt_time = ktime_to_timespec64(qopt->base_time);
-	priv->est->btr_reserve[0] = (u32)qopt_time.tv_nsec;
-	priv->est->btr_reserve[1] = (u32)qopt_time.tv_sec;
+	est->btr_reserve[0] = (u32)qopt_time.tv_nsec;
+	est->btr_reserve[1] = (u32)qopt_time.tv_sec;
 
 	ctr = qopt->cycle_time;
-	priv->est->ctr[0] = do_div(ctr, NSEC_PER_SEC);
-	priv->est->ctr[1] = (u32)ctr;
+	est->ctr[0] = do_div(ctr, NSEC_PER_SEC);
+	est->ctr[1] = (u32)ctr;
 
-	priv->est->ter = qopt->cycle_time_extension;
+	est->ter = qopt->cycle_time_extension;
 
-	tc_taprio_map_maxsdu_txq(priv, qopt);
+	tc_taprio_map_maxsdu_txq(est, qopt);
 
-	ret = stmmac_est_configure(priv, priv, priv->est,
-				   priv->plat->clk_ptp_rate);
-	mutex_unlock(&priv->est_lock);
+	if (!priv->est) {
+		priv->est = devm_kzalloc(priv->device, sizeof(*priv->est),
+					 GFP_KERNEL);
+		if (!priv->est) {
+			ret = -ENOMEM;
+			goto free_est;
+		}
+		mutex_init(&priv->est_lock);
+	}
+
+	mutex_lock(&priv->est_lock);
+	ret = stmmac_est_configure(priv, priv, est, priv->plat->clk_ptp_rate);
 	if (ret) {
 		netdev_err(priv->dev, "failed to configure EST\n");
-		goto disable;
+		goto restore;
 	}
 
 	ret = tc_config_preemption(priv, extack, qopt->mqprio.preemptible_tcs);
 	if (ret)
-		goto disable;
+		goto restore;
 
-	return 0;
+	*priv->est = *est;
+	mutex_unlock(&priv->est_lock);
+free_est:
+	kfree(est);
+	return ret;
+
+restore:
+	/* A failed hardware update must not publish the rejected schedule. */
+	if (stmmac_est_configure(priv, priv, priv->est, priv->plat->clk_ptp_rate))
+		netdev_err(priv->dev, "failed to restore EST\n");
+	mutex_unlock(&priv->est_lock);
+	goto free_est;
 
 disable:
 	if (priv->est) {
@@ -1137,9 +1242,7 @@ static int tc_taprio_configure(struct stmmac_priv *priv,
 		mutex_unlock(&priv->est_lock);
 	}
 
-	err = tc_config_preemption(priv, extack, 0);
-
-	return qopt->cmd == TAPRIO_CMD_DESTROY ? err : ret;
+	return tc_config_preemption(priv, extack, 0);
 }
 
 static void tc_taprio_stats(struct stmmac_priv *priv,
@@ -1180,7 +1283,10 @@ static int tc_setup_taprio(struct stmmac_priv *priv,
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

