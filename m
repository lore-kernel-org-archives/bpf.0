Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C12703D47C4
	for <bpf@vger.kernel.org>; Tue,  2 Jun 2026 23:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780444756; cv=none; b=fi9hSVl1DR08GXGWzKqVA0H1sVBOqTimnW1i3Fbg2sM8bnbXS8Cig/6NB9+3es1gkRlRAXvx1Q/hFAIqolPUpFIuEEc54Fw5YExdmdzvS2WEUmqsjCMQ6Z5XF7ipC4gnlZ90JrCthYTWcf+lBCgLQlgmH5HXf2aotKwYWVVfwDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780444756; c=relaxed/simple;
	bh=bfkbzcp1Fot1w6bvS24vOCxDosYYMCK/5oG6sXU5oes=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qVToQrwNCpYq0AZdQ885iNybgTI7q08xqdsunAwFS6H/WSYL0sbMCOxbvjuPnhIjEWE+dfRnHgF+nWrPrg6r/VeAbFr8PHLxzHZIqZBzs61Pi/ViffIJD/APKS1XRfwhN+4BZp1V12gfE8XyhpMMQlS1hV+9xe8VJPDkEdMsLDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oyDSsKHp; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oyDSsKHp"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-36bba9b849dso4812377a91.1
        for <bpf@vger.kernel.org>; Tue, 02 Jun 2026 16:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780444751; x=1781049551; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=W6G34oXGvIyApPhfMqkOGV/NoJJkAaxyWdHlCw0ixgI=;
        b=oyDSsKHpcLDJmeCKBCEtsELBYZ19G1qK8z8EsLsWbzE1590H4C7dzrgp7hlQwxOqll
         KKQwm+HT/4kvylYx0VDNNUKmf/QoI1TzeX2YRg8rJu8YQqS0mOiFWjjupz/UIdlySP2D
         tPdubeYKF9V2qn8+dl9oe+UoDN3foNYxrAGSLXzpnFRsNb0NwMdD0TbkAEOCgoDCYOec
         9YCmp8vzkd8+f39nd9e+bGgJYf5xk+WQywGOYaJBSwEZgFMHtttF8c3K6KekoID7IN8O
         Qum7TrRhF2JJ6hVQsoQI0D1DzPTu3TVQfbGFJ8thkI7FWCBrmWD7x0sdnXrDP4+09bdW
         /GLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780444751; x=1781049551;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W6G34oXGvIyApPhfMqkOGV/NoJJkAaxyWdHlCw0ixgI=;
        b=H0meaSMCQ6W2t8MMx9rTD/bfL06RNb7SxoRerJi7wZNHfFGb2MpzzBUQH1RxdpYbMq
         iPLDDl5I926pdzF3YQ9nvRiGoAwBwcM520pcW4wuPTCntdmzsvae1lq4LEkve2M5k6pQ
         GgAwZxmm46lqnxgAvUZuDSwNEdmke0NHv6tlrtYiArwWdlDVI3sez9WPpNtrOEzM8VVe
         hbZjeeEKPmCtWfXyk7rCeFVYqJ2mECHDlqAZdZz6kdWepPezgV+EQR8lQlzoksVsare2
         7YrG6v9uM2EzBBHvJVC1cqGDu22v+sE1dP0p8ClqbuG4XCjVwi/tXorKnShXKxwKcq1V
         d0fA==
X-Forwarded-Encrypted: i=1; AFNElJ96mePN9vdNi4J7N0J9ZqO3wHZyTiFaq0QWM0CnU1BmchNWakBwR8rSkvhK8aR0lmBpSLc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzn4MiMdvaWcaeJWT9BQS0PSeRsUp/aP8sIld7ZAxdgG713Uprr
	ePUdwGhymltrXzIWiqym9+DRknigNZRK41FPciD+ggXuuaDq1CfRAEf+r8ks3fEN3HV3SvqwdpH
	zO/BSP9EL9bGYjLMLjg8STIbBGw==
X-Received: from pjbx36.prod.google.com ([2002:a17:90a:38a7:b0:36b:8abb:86b5])
 (user=hramamurthy job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:48cf:b0:36d:633a:e8aa with SMTP id 98e67ed59e1d1-36e30a2855amr1052328a91.13.1780444750697;
 Tue, 02 Jun 2026 16:59:10 -0700 (PDT)
Date: Tue,  2 Jun 2026 23:58:54 +0000
In-Reply-To: <20260602235900.3050782-1-hramamurthy@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260602235900.3050782-1-hramamurthy@google.com>
X-Mailer: git-send-email 2.54.0.1013.g208068f2d8-goog
Message-ID: <20260602235900.3050782-11-hramamurthy@google.com>
Subject: [PATCH net-next v2 10/15] gve: add gve_ctrl_ops for gve
 initialization/teardown sequences
From: Harshitha Ramamurthy <hramamurthy@google.com>
To: netdev@vger.kernel.org
Cc: joshwash@google.com, hramamurthy@google.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org, 
	john.fastabend@gmail.com, sdf@fomichev.me, willemb@google.com, 
	jordanrhee@google.com, jfraker@google.com, nktgrg@google.com, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Joshua Washington <joshwash@google.com>

Driver initialization and teardown involve a number of control plane
operations that need to be defined for gve_probe to operate in both
mailbox and adminq modes. This list includes:

- get_ptype_map: a mapping of packet types (L3+L4) held in RX completion
  descriptors
- configure_rss: set up default RSS configuration if the device is not
  queryable
- setup_stats_report: set up DMA region for stats report (AQ-only)
- reset_flow_rules: needed in teardown; flushes all flow rules from
  device

Reviewed-by: Willem de Bruijn <willemb@google.com>
Reviewed-by: Jordan Rhee <jordanrhee@google.com>
Signed-off-by: Joshua Washington <joshwash@google.com>
Signed-off-by: Harshitha Ramamurthy <hramamurthy@google.com>
---
 drivers/net/ethernet/google/gve/gve.h        | 12 ++++++++++
 drivers/net/ethernet/google/gve/gve_adminq.c |  7 +++---
 drivers/net/ethernet/google/gve/gve_adminq.h |  3 +--
 drivers/net/ethernet/google/gve/gve_main.c   | 24 +++++++++++++++-----
 4 files changed, 34 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve.h b/drivers/net/ethernet/google/gve/gve.h
index c2e68fd97de5..939b245ed562 100644
--- a/drivers/net/ethernet/google/gve/gve.h
+++ b/drivers/net/ethernet/google/gve/gve.h
@@ -832,12 +832,24 @@ struct gve_device_info {
  *                  structures stored in @priv to be used during initialization.
  * @set_num_ntfy_blks: Sets no. of vectors into @priv to be used during
  *                     initialization.
+ * @get_ptype_map: Learn packet type map from device and store it in @priv
+ * @configure_rss: Set up default RSS configuration
+ * @setup_stats_report: Set up DMA region for stats report (AdminQ only)
+ * @reset_flow_rules: Flush all flow rules from device
  */
 struct gve_ctrl_ops {
 	int (*map_db_bar)(struct gve_priv *priv);
 	void (*unmap_db_bar)(struct gve_priv *priv);
 	void (*set_num_queues)(struct gve_priv *priv);
 	int (*set_num_ntfy_blks)(struct gve_priv *priv);
+	int (*get_ptype_map)(struct gve_priv *priv);
+	int (*configure_rss)(struct gve_priv *priv,
+			     struct ethtool_rxfh_param *param);
+	int (*setup_stats_report)(struct gve_priv *priv,
+				  u64 stats_report_len,
+				  dma_addr_t stats_report_addr,
+				  u64 interval_ms); /* AQ-specific */
+	int (*reset_flow_rules)(struct gve_priv *priv);
 };
 
 struct gve_priv {
diff --git a/drivers/net/ethernet/google/gve/gve_adminq.c b/drivers/net/ethernet/google/gve/gve_adminq.c
index 84b548467a0c..d814108deeef 100644
--- a/drivers/net/ethernet/google/gve/gve_adminq.c
+++ b/drivers/net/ethernet/google/gve/gve_adminq.c
@@ -1327,8 +1327,7 @@ int gve_adminq_report_nic_ts(struct gve_priv *priv,
 	return gve_adminq_execute_cmd(priv, &cmd);
 }
 
-int gve_adminq_get_ptype_map_dqo(struct gve_priv *priv,
-				 struct gve_ptype_lut *ptype_lut)
+int gve_adminq_get_ptype_map_dqo(struct gve_priv *priv)
 {
 	struct gve_ptype_map *ptype_map;
 	union gve_adminq_command cmd;
@@ -1354,9 +1353,9 @@ int gve_adminq_get_ptype_map_dqo(struct gve_priv *priv,
 
 	/* Populate ptype_lut. */
 	for (i = 0; i < GVE_NUM_PTYPES; i++) {
-		ptype_lut->ptypes[i].l3_type =
+		priv->ptype_lut_dqo->ptypes[i].l3_type =
 			ptype_map->ptypes[i].l3_type;
-		ptype_lut->ptypes[i].l4_type =
+		priv->ptype_lut_dqo->ptypes[i].l4_type =
 			ptype_map->ptypes[i].l4_type;
 	}
 err:
diff --git a/drivers/net/ethernet/google/gve/gve_adminq.h b/drivers/net/ethernet/google/gve/gve_adminq.h
index 12d2d1347e21..d5f98a80be46 100644
--- a/drivers/net/ethernet/google/gve/gve_adminq.h
+++ b/drivers/net/ethernet/google/gve/gve_adminq.h
@@ -652,8 +652,7 @@ int gve_adminq_report_nic_ts(struct gve_priv *priv,
 			     dma_addr_t nic_ts_report_addr);
 
 struct gve_ptype_lut;
-int gve_adminq_get_ptype_map_dqo(struct gve_priv *priv,
-				 struct gve_ptype_lut *ptype_lut);
+int gve_adminq_get_ptype_map_dqo(struct gve_priv *priv);
 int gve_adminq_map_db_bar(struct gve_priv *priv);
 void gve_adminq_unmap_db_bar(struct gve_priv *priv);
 int gve_adminq_set_num_ntfy_blks(struct gve_priv *priv);
diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
index f8289f478e5b..06df6d8ad429 100644
--- a/drivers/net/ethernet/google/gve/gve_main.c
+++ b/drivers/net/ethernet/google/gve/gve_main.c
@@ -649,7 +649,8 @@ static int gve_alloc_control_plane_resources(struct gve_priv *priv)
 
 static int gve_setup_control_plane_resources(struct gve_priv *priv)
 {
-	int err = 0;
+	const struct gve_ctrl_ops *ops = priv->ctrl_ops;
+	int err;
 
 	err = gve_adminq_configure_device_resources(priv,
 						    priv->counter_array_bus,
@@ -664,7 +665,7 @@ static int gve_setup_control_plane_resources(struct gve_priv *priv)
 	}
 
 	if (!gve_is_gqi(priv)) {
-		err = gve_adminq_get_ptype_map_dqo(priv, priv->ptype_lut_dqo);
+		err = ops->get_ptype_map(priv);
 		if (err) {
 			dev_err(&priv->pdev->dev,
 				"Failed to get ptype map: err=%d\n", err);
@@ -686,12 +687,13 @@ static int gve_setup_control_plane_resources(struct gve_priv *priv)
 		goto teardown_clock;
 	}
 
-	err = gve_adminq_report_stats(priv, priv->stats_report_len,
+	err = ops->setup_stats_report(priv, priv->stats_report_len,
 				      priv->stats_report_bus,
 				      GVE_STATS_REPORT_TIMER_PERIOD);
 	if (err)
 		dev_err(&priv->pdev->dev,
 			"Failed to report stats: err=%d\n", err);
+
 	gve_set_device_resources_ok(priv);
 	return 0;
 
@@ -712,6 +714,7 @@ static int gve_setup_control_plane_resources(struct gve_priv *priv)
  */
 static void gve_teardown_control_plane_resources(struct gve_priv *priv)
 {
+	const struct gve_ctrl_ops *ops = priv->ctrl_ops;
 	int err;
 
 	/* Tell device its resources are being freed */
@@ -721,11 +724,13 @@ static void gve_teardown_control_plane_resources(struct gve_priv *priv)
 			dev_err(&priv->pdev->dev,
 				"Failed to reset flow rules: err=%d\n", err);
 		/* detach the stats report */
-		err = gve_adminq_report_stats(priv, 0, 0x0, GVE_STATS_REPORT_TIMER_PERIOD);
+		err = ops->setup_stats_report(priv, 0, 0x0,
+					      GVE_STATS_REPORT_TIMER_PERIOD);
 		if (err)
 			dev_err(&priv->pdev->dev,
 				"Failed to detach stats report: err=%d\n", err);
 		gve_teardown_clock(priv);
+
 		err = gve_adminq_deconfigure_device_resources(priv);
 		if (err)
 			dev_err(&priv->pdev->dev,
@@ -1811,6 +1816,7 @@ static int gve_xdp(struct net_device *dev, struct netdev_bpf *xdp)
 
 int gve_init_rss_config(struct gve_priv *priv, u16 num_queues)
 {
+	const struct gve_ctrl_ops *ops = priv->ctrl_ops;
 	struct gve_rss_config *rss_config = &priv->rss_config;
 	struct ethtool_rxfh_param rxfh = {0};
 	u16 i;
@@ -1826,15 +1832,17 @@ int gve_init_rss_config(struct gve_priv *priv, u16 num_queues)
 
 	rxfh.hfunc = ETH_RSS_HASH_TOP;
 
-	return gve_adminq_configure_rss(priv, &rxfh);
+	return ops->configure_rss(priv, &rxfh);
 }
 
 int gve_flow_rules_reset(struct gve_priv *priv)
 {
+	const struct gve_ctrl_ops *ops = priv->ctrl_ops;
+
 	if (!priv->max_flow_rules)
 		return 0;
 
-	return gve_adminq_reset_flow_rules(priv);
+	return ops->reset_flow_rules(priv);
 }
 
 int gve_adjust_config(struct gve_priv *priv,
@@ -2469,6 +2477,10 @@ static const struct gve_ctrl_ops gve_adminq_ops = {
 	.unmap_db_bar		= gve_adminq_unmap_db_bar,
 	.set_num_queues		= gve_adminq_set_num_queues,
 	.set_num_ntfy_blks	= gve_adminq_set_num_ntfy_blks,
+	.get_ptype_map		= gve_adminq_get_ptype_map_dqo,
+	.reset_flow_rules	= gve_adminq_reset_flow_rules,
+	.setup_stats_report	= gve_adminq_report_stats,
+	.configure_rss		= gve_adminq_configure_rss,
 };
 
 static int gve_init_priv(struct gve_priv *priv)
-- 
2.54.0.1013.g208068f2d8-goog

