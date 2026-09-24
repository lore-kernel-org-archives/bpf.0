Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 569464BD119
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 18:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790276016; cv=none; b=oaMW1pktYwmJkzzgMthbugKb5dWf9M+20sX6IaWbDdsdqVqJhfY9Gf79RGemu383hluuyEoOLz812qZxljnX/gPha2QQ/ZLentU3R0oYMZyNyTdKfAX5vrUhx19JNdLm8xSueDre1ZmL3LWOwHcvAaIsaij9eHLmdhMSN3pG23g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790276016; c=relaxed/simple;
	bh=kAcpY4KD54QmBP7GL2UFi2y5LKkvrlh+OdEF+NBOXoE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YuN4Hga8vVgDW1R8B1N1yuyCFHuzWunY4ucpSnRyv7i6GNsSd/OWkMFdA5nTR6yhhDSatlEBM+nabrnxoLoGuy/J2AEwEQNPjFcOD9FFbGNaVpLvuBKAMh8rFPxp8MF+vdpLAOWv8P3PBZxpAUYsJIR7dQkn6JpIChPrNM83tD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YRkCsyw6; arc=none smtp.client-ip=209.85.216.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YRkCsyw6"
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3965ba1ba3eso139827a91.2
        for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 11:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790276004; x=1790880804; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SEXhKf0YHEVXlTj7OJFhNik/oKMJPJKlM09suwVREiU=;
        b=YRkCsyw6LtSH7GaAcPxCvr/7KIPJghvYsgK7bCHS1u8ZYMwBqjBjdHvhszu1L4cQgp
         3u8pbHH2v0giK47spsLk3mSRmIOqdJzKOC0GcXMJfPxBTG1Rvbld8YQTMqdCzFVsD7RS
         SFx44reXZLluQZEQTGZ1PGf8ieXidT54qb+bz8+I38PxaR3UG318POu70oq5Y7cv20/g
         nIphi2r4Wtk0lg1ntrPRyl/Anx9mSjGGGOO3SSHpCE8YypNj1EZW6kh01fUKXcL7a50P
         Rzh78V+vhF1w8taczxdz4RIw+0ZltDFkmvYqOuWmt1ar3mOv95sdtdCWlbdAeVDa0RNR
         TIPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790276004; x=1790880804;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SEXhKf0YHEVXlTj7OJFhNik/oKMJPJKlM09suwVREiU=;
        b=1HZuYKIixx/u/qZgGSxu8up4y7+n3FCEwvO0pTXQQWRPS8LFEsc7qMQTwRYmaWvMdC
         8xwyb+pOVJL6mHhtBXY1opHhB1Wlgqh8YDExqhL2kV4ZYQ579CxUy7H2Nf+UcF7xY0cs
         gqlOr6kIkeG5jY0WY6GCiN1CtdGTTbFq4fw0AJUPXFZicj4FVOKMHptmWX91lheCSaMW
         8pAsCHe2gpEWQwPPJZN1Iajs6usZZWV+QrAd/T7V30G4zHRkKK8Y9xyGQ3h99gqyIxQd
         jMxhce5eQDGQ53ibJu0be6L4cOe4KST/94bhhD4R+2WSQTLw7Ks+j5sjlteZf0C1vvk1
         n+Xg==
X-Forwarded-Encrypted: i=1; AKwUvBwHi1i2d23MpXdP43ARzTIQZn348+Unttp/0VcoiReAqmMbGy+SflQ+wDyPxDhXnPLjZ3w=@vger.kernel.org
X-Gm-Message-State: AFuF++ljhJHYs0nvBdQgjgwXjdlmHE1fpfZEVaPAe32uybXEiP2Q9853
	zEma2R2lif2SvYyzYQXFZ2HeeghDWDEkDoF89x5YiT8OCrM5JzaEqNlzM/SvuwQo6GY4w2OTcaf
	xsaJrGNnhmwvJX9RFwBTGY8j2gw==
X-Received: from pjbsq12.prod.google.com ([2002:a17:90b:530c:b0:3a0:8124:2580])
 (user=hramamurthy job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:4e8f:b0:39e:6c68:1551 with SMTP id 98e67ed59e1d1-3a09896c4demr2911658a91.25.1790276004353;
 Thu, 24 Sep 2026 11:53:24 -0700 (PDT)
Date: Thu, 24 Sep 2026 18:53:11 +0000
In-Reply-To: <20260924185316.2831077-1-hramamurthy@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260924185316.2831077-1-hramamurthy@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260924185316.2831077-8-hramamurthy@google.com>
Subject: [PATCH net-next v8 07/12] gve: add gve_ctrl_ops for gve
 initialization/teardown sequences
From: Harshitha Ramamurthy <hramamurthy@google.com>
To: netdev@vger.kernel.org
Cc: joshwash@google.com, hramamurthy@google.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org, 
	john.fastabend@gmail.com, sdf@fomichev.me, jordanrhee@google.com, 
	willemb@google.com, nktgrg@google.com, maolson@google.com, thostet@google.com, 
	jacob.e.keller@intel.com, debarghyak@google.com, kees@kernel.org, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	przemyslaw.kitszel@intel.com
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
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Joshua Washington <joshwash@google.com>
Signed-off-by: Harshitha Ramamurthy <hramamurthy@google.com>
---
 drivers/net/ethernet/google/gve/gve.h        | 12 ++++++++++++
 drivers/net/ethernet/google/gve/gve_adminq.c |  7 +++----
 drivers/net/ethernet/google/gve/gve_adminq.h |  3 +--
 drivers/net/ethernet/google/gve/gve_main.c   | 24 ++++++++++++++++++------
 4 files changed, 34 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve.h b/drivers/net/ethernet/google/gve/gve.h
index 026d685ecaee..e0583e8cd2cd 100644
--- a/drivers/net/ethernet/google/gve/gve.h
+++ b/drivers/net/ethernet/google/gve/gve.h
@@ -833,12 +833,24 @@ struct gve_device_info {
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
index 901673d2e264..1176e13fafc0 100644
--- a/drivers/net/ethernet/google/gve/gve_adminq.c
+++ b/drivers/net/ethernet/google/gve/gve_adminq.c
@@ -1329,8 +1329,7 @@ int gve_adminq_report_nic_ts(struct gve_priv *priv,
 	return gve_adminq_execute_cmd(priv, &cmd);
 }
 
-int gve_adminq_get_ptype_map_dqo(struct gve_priv *priv,
-				 struct gve_ptype_lut *ptype_lut)
+int gve_adminq_get_ptype_map_dqo(struct gve_priv *priv)
 {
 	struct gve_ptype_map *ptype_map;
 	union gve_adminq_command cmd;
@@ -1356,9 +1355,9 @@ int gve_adminq_get_ptype_map_dqo(struct gve_priv *priv,
 
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
index fe1e8868cdfe..5e51c060e237 100644
--- a/drivers/net/ethernet/google/gve/gve_adminq.h
+++ b/drivers/net/ethernet/google/gve/gve_adminq.h
@@ -652,8 +652,7 @@ int gve_adminq_report_nic_ts(struct gve_priv *priv,
 			     dma_addr_t nic_ts_report_addr);
 
 struct gve_ptype_lut;
-int gve_adminq_get_ptype_map_dqo(struct gve_priv *priv,
-				 struct gve_ptype_lut *ptype_lut);
+int gve_adminq_get_ptype_map_dqo(struct gve_priv *priv);
 int gve_adminq_set_num_ntfy_blks(struct gve_priv *priv);
 void gve_adminq_set_num_queues(struct gve_priv *priv);
 int gve_adminq_map_db_bar(struct gve_priv *priv);
diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
index 07135c52a707..45451eac3e0a 100644
--- a/drivers/net/ethernet/google/gve/gve_main.c
+++ b/drivers/net/ethernet/google/gve/gve_main.c
@@ -706,7 +706,8 @@ abort:
 
 static int gve_setup_control_plane_resources(struct gve_priv *priv)
 {
-	int err = 0;
+	const struct gve_ctrl_ops *ops = priv->ctrl_ops;
+	int err;
 
 	err = gve_adminq_configure_device_resources(priv,
 						    priv->counter_array_bus,
@@ -721,7 +722,7 @@ static int gve_setup_control_plane_resources(struct gve_priv *priv)
 	}
 
 	if (!gve_is_gqi(priv)) {
-		err = gve_adminq_get_ptype_map_dqo(priv, priv->ptype_lut_dqo);
+		err = ops->get_ptype_map(priv);
 		if (err) {
 			dev_err(&priv->pdev->dev,
 				"Failed to get ptype map: err=%d\n", err);
@@ -743,12 +744,13 @@ static int gve_setup_control_plane_resources(struct gve_priv *priv)
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
 
@@ -772,6 +774,7 @@ deconfigure_device:
  */
 static void gve_teardown_control_plane_resources(struct gve_priv *priv)
 {
+	const struct gve_ctrl_ops *ops = priv->ctrl_ops;
 	int err;
 
 	/* Tell device its resources are being freed */
@@ -781,11 +784,13 @@ static void gve_teardown_control_plane_resources(struct gve_priv *priv)
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
@@ -1819,6 +1824,7 @@ static int gve_xdp(struct net_device *dev, struct netdev_bpf *xdp)
 
 int gve_init_rss_config(struct gve_priv *priv, u16 num_queues)
 {
+	const struct gve_ctrl_ops *ops = priv->ctrl_ops;
 	struct gve_rss_config *rss_config = &priv->rss_config;
 	struct ethtool_rxfh_param rxfh = {0};
 	u16 i;
@@ -1834,15 +1840,17 @@ int gve_init_rss_config(struct gve_priv *priv, u16 num_queues)
 
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
@@ -2483,6 +2491,10 @@ static const struct gve_ctrl_ops gve_adminq_ops = {
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
2.56.0.rc1.310.g51773c2048-goog

