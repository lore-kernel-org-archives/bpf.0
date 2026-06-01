Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C6423E63B7
	for <bpf@vger.kernel.org>; Mon,  1 Jun 2026 17:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780336490; cv=none; b=IVDpYsozxKHMaE5lKqi9nZ0B6lpYQFPizhPxXMjL6rD/c4C7ZNlXBOk+8JM8cgZJH3pCy04cBxpcKg95DUGeug7+rtPgAEsbOVijpYukC1uZST5T2nKYGq7DN2gBEeYw5RfZUnN5ixx1W08I2ukdXhWpdfAPhhx2gOMMSNJ7M18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780336490; c=relaxed/simple;
	bh=NO7ff2MjdNzbLfFOWvir+qy19F9IvmUY1vpeOLqSrMY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=uuEMxwU+dqJKI12UmYWwl879YSO3/0JuexalFw9Osg4g7GMRXB/l9tbXTLSVFDaoy/QQoTQM/UIK+UXSTRFtTmABtFpfYfCE9wd1LYO9ZDCQmNonwg6F7RMvRXDSepkN0zPbQVP1bu33DJZ5fuVkDcAhmkiAcJYX/53nRUZpxLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mQET3XET; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mQET3XET"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c85a3669a15so980913a12.1
        for <bpf@vger.kernel.org>; Mon, 01 Jun 2026 10:54:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780336488; x=1780941288; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=83Wqxzx9G3Fx1CZm6JdVy+MWy9bwrjSI+ye1bNW5Jis=;
        b=mQET3XETpldZqVY0OhH46OrcrneFRCD/b8SN6wJGJFJYPaeRGJzTS8Rs+QUNz3w68Z
         /xCZBGVpI9KWeDFBjQwLZyKX77dtRnN1wy1dqEpdX/OC1MWJEoXOZwBauJHX1lBKHbHI
         8mndbVFDDD0f3itDNamfp6Baq8tEOLC0BNEbrCClzbYH7vdtK2YcX8VrpyAWjpJdcE9r
         7THKE6PCrt9N3QhfCZvdqPa6H8RzyHPFHtPrNw9jqe3s1cve7Xs7BJQCQIQFrjv/YGb8
         M8H/QBTlk5i9a0RlKFswrd5zurA6OW9AW7Ap5jWNeSvdkEgI7P4NHtIomZV3xobM//4m
         onEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780336488; x=1780941288;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=83Wqxzx9G3Fx1CZm6JdVy+MWy9bwrjSI+ye1bNW5Jis=;
        b=OhI2HyjYoVoc01m0xFXxjf1PZ7ZblW4r44rrmFA3E0OgX35O+R6qYFNIJwWsfX4dtS
         kPGD+uSzO2MnMnlnN1J94TGJb/6yHpVwNR4siidybVupUkGgwmeXs5zuc27P8BfHOPl/
         Wu2faUs/1x8XH64tFuhjfW22OGar7i0bblMIWY7YpIlwKwI/7cqCXzqDBmdW+RtHB+bh
         /0jK5l8WZBlamtGImcWxhoB6TyoANRJuf+zDxEO4ge/30mGqxT81BQmLkhw4ekoWJd6J
         6UQrty+m0NbQkTW7RDPp1KkGQWNrve6IfWFpMZcCCdYUZZwlQzrLqW95edkMTxSq0bhF
         GUWQ==
X-Forwarded-Encrypted: i=1; AFNElJ/dLT5CLetvJ2P2RxtI1QnWxquwPCqKmK5p8NPkd7O9n6fQpVOcijDCD5b/b8jU7n81SEI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7P7OGwr5xKsjHZbNUet3VMRVY+RV3wJOBNlpdoAb4wsdTY3hU
	ww11xCW9uencc7TQ3t7S5taQyAf5UnJKTxSiF+wv/rqLX//s9YIsuDPqAsxbCK6dIy5wGA9JsIG
	qX7JVby8g9xvcNZMvSuIv1mN/5A==
X-Received: from pgan68.prod.google.com ([2002:a63:4047:0:b0:c85:894e:5b3c])
 (user=hramamurthy job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:6005:b0:3b4:661d:8405 with SMTP id adf61e73a8af0-3b47886ce87mr438434637.4.1780336487549;
 Mon, 01 Jun 2026 10:54:47 -0700 (PDT)
Date: Mon,  1 Jun 2026 17:54:32 +0000
In-Reply-To: <20260601175437.3767283-1-hramamurthy@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260601175437.3767283-1-hramamurthy@google.com>
X-Mailer: git-send-email 2.54.0.1013.g208068f2d8-goog
Message-ID: <20260601175437.3767283-11-hramamurthy@google.com>
Subject: [PATCH net-next 10/15] gve: add gve_ctrl_ops for gve
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
index 442e4622ab76..f8976017ca60 100644
--- a/drivers/net/ethernet/google/gve/gve.h
+++ b/drivers/net/ethernet/google/gve/gve.h
@@ -835,12 +835,24 @@ struct gve_device_info {
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
index 8f3a4e63cf37..a9752525d974 100644
--- a/drivers/net/ethernet/google/gve/gve_adminq.c
+++ b/drivers/net/ethernet/google/gve/gve_adminq.c
@@ -1352,8 +1352,7 @@ int gve_adminq_report_nic_ts(struct gve_priv *priv,
 	return gve_adminq_execute_cmd(priv, &cmd);
 }
 
-int gve_adminq_get_ptype_map_dqo(struct gve_priv *priv,
-				 struct gve_ptype_lut *ptype_lut)
+int gve_adminq_get_ptype_map_dqo(struct gve_priv *priv)
 {
 	struct gve_ptype_map *ptype_map;
 	union gve_adminq_command cmd;
@@ -1379,9 +1378,9 @@ int gve_adminq_get_ptype_map_dqo(struct gve_priv *priv,
 
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
index 953da0f2b0e4..e783589c5ed6 100644
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
2.54.0.669.g59709faab0-goog

