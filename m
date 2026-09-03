Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E131643849A
	for <bpf@vger.kernel.org>; Thu,  3 Sep 2026 21:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788472579; cv=none; b=NUfG7ObK2GbR7aYhaUVMiA3ur59wwecchA5dJSBdwzjvamsAHltru7IhCZ8TqBzR5DSB13MyaaZ25lFnHjk0wJsv6PiWZ23bTWRNn1sVw8W0SN4nX77c/Tt/Gg6wXWKHVTSNOJiDCNWHIB72y/cX6SnZQSoKYURXJXbJPoTzELU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788472579; c=relaxed/simple;
	bh=mwE2Oun7z8jzz6V//FWI4B+Z7Qd5Ezv6A+HF6TBy/0I=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QcC2U6so7gjVJd1pvk3LVTF4U8BIqAJIZiy8vv/cZTXzxovA7935FbrYiPXBEHI3LQQ4VcykY1sMCPmnOh29GJqDbnay62/gP9I2Z6BNGw49naImKCyGACxc9W2qhAcF4naxU0ncv5NT9/VEvxqWwJs3+DJWpV+TXNKXGqpvWf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NUAQObcX; arc=none smtp.client-ip=209.85.214.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NUAQObcX"
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2d54187d8b0so9438555ad.0
        for <bpf@vger.kernel.org>; Thu, 03 Sep 2026 14:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788472576; x=1789077376; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=E4ghh9tuxvrR3CfO46i2D/h+X9aiPc5GRPuwzecUql0=;
        b=NUAQObcXy5May/f9gLvjm6ZwpaiWRx5NnEttHo4T8XckNjJzxgpBupPbegb1jrbDjb
         W+jo0O8uh+Tf1Msz/u6U0PDHkcNaIUnJeU00ntJTSaf6Rllpvi+mb1KvLgnjBYcqrerh
         CuOU3Y4JTgJ79sC2f+vRtGN2oRMyx69CN51Uljcxr+ESPwkRVn0Tf8nLwNYa9jVX2meL
         Yz15RcmbH6KqrxIYFqTikDTCMBAz6978tLO3cVlhnwtYfDfNDCoEqjFAE5cN71UpXMV/
         CoaZC5UfKo+bIUFmrlIwKTBtBCzE4Pl/D3OALqdvu7Gi0GNrOJtgDf6gQaPfLe8z3t5J
         wooA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788472576; x=1789077376;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=E4ghh9tuxvrR3CfO46i2D/h+X9aiPc5GRPuwzecUql0=;
        b=Mhe22XuK6iqfD6kv91XK4bLF2/bLrj3IjgZNkqQnj0vqH7txhQYXCnvaKvipn7I7q/
         sIkgxkV8QQ2I7RVmM0EC6rHHx46VBaVNwKCniHAYa18V/KvqpV9c0xul1/S1W2RYB8DQ
         R1I/3WqzsHKE9dGf7kAhcMr+IMh2AGuIcRgj66eeKGDl4ah9Ez8yyQX0R4tEIo7iFhUL
         B2Ctfk8p7QBZR+Lwa+3gjjTOGe78OU9mDH7+iiPklJM95miaxrPQ5fspTSAo+U/xmqKG
         Er+5Bkwp/aM9cX/4CgCc41wOHY+c/Bsgi9ZfONdcBB2hvrwE7vHg+5da55NjQ1KJ+hrk
         4G5w==
X-Forwarded-Encrypted: i=1; AKwUvBxwx2OsEldc3Gw7zapo+c7eqXvEiLWI0ZU6eltx0oGiIXo1j4lrjsyWhCmFnMW9Sqn9yFc=@vger.kernel.org
X-Gm-Message-State: AFuF++kZ2/CDcMq3m2hDAOkCLyYl5Yi+q9l6RE79aiYMQPn15ZAm0znV
	ZjRcPVDCH37Pc1yOeoaCG90a/Vz6o+XCA112+IkAWQgsGJ+5aXA+EB/b86m7g5GiYECTZs88b4f
	wlxSpI/4T3tnCGxrDxChzbAnGwQ==
X-Received: from ploh14.prod.google.com ([2002:a17:902:f70e:b0:2d7:b1a:879e])
 (user=hramamurthy job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:19cc:b0:2d7:1cee:3682 with SMTP id d9443c01a7336-2db125cd39dmr32568085ad.5.1788472575997;
 Thu, 03 Sep 2026 14:56:15 -0700 (PDT)
Date: Thu,  3 Sep 2026 21:56:03 +0000
In-Reply-To: <20260903215606.31633-1-hramamurthy@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260903215606.31633-1-hramamurthy@google.com>
X-Mailer: git-send-email 2.55.0.979.g7e5102b832-goog
Message-ID: <20260903215606.31633-10-hramamurthy@google.com>
Subject: [PATCH net-next v5 09/12] gve: introduce new methods to handle IRQ doorbells
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

Introduce `request_db_info` and `release_db_resources` to
`struct gve_ctrl_ops`. These encapsulate the configuration of device
resources (counter arrays and IRQ doorbell indices) which vary between
Admin Queue and Mailbox modes. Registration and de-registratino of IRQ
dorrbell indices with the device will be managed by these new methods
instead of occurring directly in notify_block setup/teardown methods.
Similarly, GQ ring counters will be managed in `request_db_info`.

Reviewed-by: Willem de Bruijn <willemb@google.com>
Reviewed-by: Jordan Rhee <jordanrhee@google.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Joshua Washington <joshwash@google.com>
Signed-off-by: Harshitha Ramamurthy <hramamurthy@google.com>
---
v4:
  - propagate code changes as specified by v3.
v3:
  - move allocation of IRQ DB indices and counter array back into
    gve_alloc_control_plane_resources() from
    gve_adminq_request_db_info().
  - Similar to above, move free logic out of
    gve_adminq_free_db_resources() and rename all introduced methods
    from *free_db_resources to *release_db_resources to reflect the
    behavioral change.

 drivers/net/ethernet/google/gve/gve.h        | 10 ++
 drivers/net/ethernet/google/gve/gve_adminq.c | 37 ++++++++
 drivers/net/ethernet/google/gve/gve_adminq.h |  2 +
 drivers/net/ethernet/google/gve/gve_main.c   | 98 ++++++++++----------
 4 files changed, 97 insertions(+), 50 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve.h b/drivers/net/ethernet/google/gve/gve.h
index f624a3e385e4..6c46c842070b 100644
--- a/drivers/net/ethernet/google/gve/gve.h
+++ b/drivers/net/ethernet/google/gve/gve.h
@@ -834,6 +834,9 @@ struct gve_device_info {
  *                  structures stored in @priv to be used during initialization.
  * @set_num_ntfy_blks: Sets no. of vectors into @priv to be used during
  *                     initialization.
+ * @request_db_info: Request and store doorbell information into @priv
+ * @release_db_resources: Release device hold on DMA memory holding doorbell
+ *			  info (AdminQ only)
  * @get_ptype_map: Learn packet type map from device and store it in @priv
  * @configure_rss: Set up default RSS configuration
  * @setup_stats_report: Set up DMA region for stats report (AdminQ only)
@@ -844,6 +847,8 @@ struct gve_ctrl_ops {
 	void (*unmap_db_bar)(struct gve_priv *priv);
 	void (*set_num_queues)(struct gve_priv *priv);
 	int (*set_num_ntfy_blks)(struct gve_priv *priv);
+	int (*request_db_info)(struct gve_priv *priv);
+	void (*release_db_resources)(struct gve_priv *priv);
 	int (*get_ptype_map)(struct gve_priv *priv);
 	int (*configure_rss)(struct gve_priv *priv,
 			     struct ethtool_rxfh_param *param);
@@ -1164,6 +1169,11 @@ static inline u32 gve_rx_idx_to_ntfy(struct gve_priv *priv, u32 queue_idx)
 	return (priv->num_ntfy_blks / 2) + queue_idx;
 }
 
+static inline u32 gve_ntfy_to_msix_idx(struct gve_priv *priv, u32 ntfy_blk_idx)
+{
+	return ntfy_blk_idx;
+}
+
 static inline bool gve_is_qpl(struct gve_priv *priv)
 {
 	return priv->queue_format == GVE_GQI_QPL_FORMAT ||
diff --git a/drivers/net/ethernet/google/gve/gve_adminq.c b/drivers/net/ethernet/google/gve/gve_adminq.c
index 1176e13fafc0..b89825a85db8 100644
--- a/drivers/net/ethernet/google/gve/gve_adminq.c
+++ b/drivers/net/ethernet/google/gve/gve_adminq.c
@@ -1718,3 +1718,40 @@ void gve_adminq_unmap_db_bar(struct gve_priv *priv)
 
 	pci_iounmap(pdev, priv->db_bar2);
 }
+
+int gve_adminq_request_db_info(struct gve_priv *priv)
+{
+	int err;
+	int i;
+
+	err = gve_adminq_configure_device_resources(priv,
+						    priv->counter_array_bus,
+						    priv->num_event_counters,
+						    priv->irq_db_indices_bus,
+						    priv->num_ntfy_blks);
+	if (unlikely(err)) {
+		dev_err(&priv->pdev->dev,
+			"could not setup device_resources: err=%d\n", err);
+		return -ENXIO;
+	}
+
+	for (i = 0; i < priv->num_ntfy_blks; i++)
+		priv->ntfy_blocks[i].irq_db_index =
+			&priv->irq_db_indices[i].index;
+	return 0;
+}
+
+void gve_adminq_release_db_resources(struct gve_priv *priv)
+{
+	int err;
+
+	/* Log error in deconfigure device, but don't fail. This is only ever
+	 * called as a reset is about to be triggered, so it would be redundant
+	 * to trigger a reset.
+	 */
+	err = gve_adminq_deconfigure_device_resources(priv);
+	if (err)
+		dev_err(&priv->pdev->dev,
+			"Could not deconfigure device resources: err=%d\n",
+			err);
+}
diff --git a/drivers/net/ethernet/google/gve/gve_adminq.h b/drivers/net/ethernet/google/gve/gve_adminq.h
index 5e51c060e237..52172bf228eb 100644
--- a/drivers/net/ethernet/google/gve/gve_adminq.h
+++ b/drivers/net/ethernet/google/gve/gve_adminq.h
@@ -657,4 +657,6 @@ int gve_adminq_set_num_ntfy_blks(struct gve_priv *priv);
 void gve_adminq_set_num_queues(struct gve_priv *priv);
 int gve_adminq_map_db_bar(struct gve_priv *priv);
 void gve_adminq_unmap_db_bar(struct gve_priv *priv);
+int gve_adminq_request_db_info(struct gve_priv *priv);
+void gve_adminq_release_db_resources(struct gve_priv *priv);
 #endif /* _GVE_ADMINQ_H */
diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
index 619ef46a7b30..a160d36f718b 100644
--- a/drivers/net/ethernet/google/gve/gve_main.c
+++ b/drivers/net/ethernet/google/gve/gve_main.c
@@ -203,6 +203,30 @@ static void gve_free_counter_array(struct gve_priv *priv)
 	priv->counter_array = NULL;
 }
 
+static int gve_alloc_irq_db_indices(struct gve_priv *priv)
+{
+	priv->irq_db_indices =
+		dma_alloc_coherent(&priv->pdev->dev,
+				   priv->num_ntfy_blks *
+				   sizeof(*priv->irq_db_indices),
+				   &priv->irq_db_indices_bus, GFP_KERNEL);
+	if (!priv->irq_db_indices)
+		return -ENOMEM;
+
+	return 0;
+}
+
+static void gve_free_irq_db_indices(struct gve_priv *priv)
+{
+	if (!priv->irq_db_indices)
+		return;
+
+	dma_free_coherent(&priv->pdev->dev, priv->num_ntfy_blks *
+			  sizeof(*priv->irq_db_indices),
+			  priv->irq_db_indices, priv->irq_db_indices_bus);
+	priv->irq_db_indices = NULL;
+}
+
 /* NIC requests to report stats */
 static void gve_stats_report_task(struct work_struct *work)
 {
@@ -431,15 +455,6 @@ int gve_napi_poll_dqo(struct napi_struct *napi, int budget)
 static void gve_free_notify_blocks(struct gve_priv *priv)
 {
 	pci_disable_msix(priv->pdev);
-	if (priv->irq_db_indices) {
-		dma_free_coherent(&priv->pdev->dev,
-				  priv->num_ntfy_blks *
-				  sizeof(*priv->irq_db_indices),
-				  priv->irq_db_indices,
-				  priv->irq_db_indices_bus);
-		priv->irq_db_indices = NULL;
-	}
-
 	kvfree(priv->ntfy_blocks);
 	priv->ntfy_blocks = NULL;
 	kvfree(priv->msix_vectors);
@@ -496,24 +511,14 @@ static int gve_alloc_notify_blocks(struct gve_priv *priv)
 			priv->rx_cfg.num_queues = priv->rx_cfg.max_queues;
 	}
 
-	priv->irq_db_indices =
-		dma_alloc_coherent(&priv->pdev->dev,
-				   priv->num_ntfy_blks *
-				   sizeof(*priv->irq_db_indices),
-				   &priv->irq_db_indices_bus, GFP_KERNEL);
-	if (!priv->irq_db_indices) {
-		err = -ENOMEM;
-		goto abort;
-	}
-
 	priv->ntfy_blocks = kvzalloc(priv->num_ntfy_blks *
 				     sizeof(*priv->ntfy_blocks), GFP_KERNEL);
 	if (!priv->ntfy_blocks) {
 		err = -ENOMEM;
 		goto abort;
 	}
-	return 0;
 
+	return 0;
 abort:
 	gve_free_notify_blocks(priv);
 	return err;
@@ -528,13 +533,14 @@ static void gve_teardown_notify_blocks(struct gve_priv *priv)
 
 	for (i = 0; i < priv->num_ntfy_blks; i++) {
 		struct gve_notify_block *block = &priv->ntfy_blocks[i];
+		int msix_idx = gve_ntfy_to_msix_idx(priv, i);
 
 		if (!block->irq_requested)
 			continue;
 
-		irq_set_affinity_hint(priv->msix_vectors[i].vector,
+		irq_set_affinity_hint(priv->msix_vectors[msix_idx].vector,
 				      NULL);
-		free_irq(priv->msix_vectors[i].vector, block);
+		free_irq(priv->msix_vectors[msix_idx].vector, block);
 		block->irq = 0;
 		block->irq_requested = false;
 	}
@@ -563,12 +569,11 @@ static int gve_setup_notify_blocks(struct gve_priv *priv)
 	}
 	priv->mgmt_irq_requested = true;
 
-	/* Setup the other blocks - the first n-1 vectors */
 	node_mask = gve_get_node_mask(priv);
 	cur_cpu = cpumask_first(node_mask);
 	for (i = 0; i < priv->num_ntfy_blks; i++) {
 		struct gve_notify_block *block = &priv->ntfy_blocks[i];
-		int msix_idx = i;
+		int msix_idx = gve_ntfy_to_msix_idx(priv, i);
 
 		snprintf(block->name, sizeof(block->name), "gve-ntfy-blk%d@pci:%s",
 			 i, pci_name(priv->pdev));
@@ -578,14 +583,13 @@ static int gve_setup_notify_blocks(struct gve_priv *priv)
 				  IRQF_NO_AUTOEN, block->name, block);
 		if (err) {
 			dev_err(&priv->pdev->dev,
-				"Failed to receive msix vector %d\n", i);
+				"Failed to receive msix vector %d\n", msix_idx);
 			goto abort;
 		}
 		block->irq = priv->msix_vectors[msix_idx].vector;
 		block->irq_requested = true;
 		irq_set_affinity_and_hint(block->irq,
 					  cpumask_of(cur_cpu));
-		block->irq_db_index = &priv->irq_db_indices[i].index;
 
 		cur_cpu = cpumask_next(cur_cpu, node_mask);
 		/* Wrap once CPUs in the node have been exhausted, or when
@@ -602,7 +606,6 @@ static int gve_setup_notify_blocks(struct gve_priv *priv)
 	return err;
 }
 
-
 static void gve_free_control_plane_resources(struct gve_priv *priv)
 {
 	bitmap_free(priv->xsk_pools);
@@ -611,9 +614,10 @@ static void gve_free_control_plane_resources(struct gve_priv *priv)
 	kvfree(priv->ptype_lut_dqo);
 	priv->ptype_lut_dqo = NULL;
 
-	gve_free_stats_report(priv);
-	gve_free_notify_blocks(priv);
+	gve_free_irq_db_indices(priv);
 	gve_free_counter_array(priv);
+	gve_free_notify_blocks(priv);
+	gve_free_stats_report(priv);
 	gve_free_rss_config_cache(priv);
 	gve_free_flow_rule_caches(priv);
 }
@@ -626,15 +630,18 @@ static int gve_alloc_control_plane_resources(struct gve_priv *priv)
 	if (err)
 		return err;
 	err = gve_alloc_rss_config_cache(priv);
-	if (err)
-		goto abort;
-	err = gve_alloc_counter_array(priv);
 	if (err)
 		goto abort;
 	err = gve_alloc_notify_blocks(priv);
 	if (err)
 		goto abort;
 	err = gve_alloc_stats_report(priv);
+	if (err)
+		goto abort;
+	err = gve_alloc_counter_array(priv);
+	if (err)
+		goto abort;
+	err = gve_alloc_irq_db_indices(priv);
 	if (err)
 		goto abort;
 
@@ -664,15 +671,9 @@ static int gve_setup_control_plane_resources(struct gve_priv *priv)
 	const struct gve_ctrl_ops *ops = priv->ctrl_ops;
 	int err;
 
-	err = gve_adminq_configure_device_resources(priv,
-						    priv->counter_array_bus,
-						    priv->num_event_counters,
-						    priv->irq_db_indices_bus,
-						    priv->num_ntfy_blks);
-	if (unlikely(err)) {
-		dev_err(&priv->pdev->dev,
-			"could not setup device_resources: err=%d\n", err);
-		err = -ENXIO;
+	err = ops->request_db_info(priv);
+	if (err) {
+		dev_err(&priv->pdev->dev, "Failed to get db info");
 		return err;
 	}
 
@@ -681,7 +682,7 @@ static int gve_setup_control_plane_resources(struct gve_priv *priv)
 		if (err) {
 			dev_err(&priv->pdev->dev,
 				"Failed to get ptype map: err=%d\n", err);
-			goto deconfigure_device;
+			goto release_db_resources;
 		}
 	}
 
@@ -711,8 +712,8 @@ static int gve_setup_control_plane_resources(struct gve_priv *priv)
 
 teardown_clock:
 	gve_teardown_clock(priv);
-deconfigure_device:
-	gve_adminq_deconfigure_device_resources(priv);
+release_db_resources:
+	ops->release_db_resources(priv);
 	return err;
 }
 
@@ -745,12 +746,7 @@ static void gve_teardown_control_plane_resources(struct gve_priv *priv)
 			dev_err(&priv->pdev->dev,
 				"Failed to detach stats report: err=%d\n", err);
 		gve_teardown_clock(priv);
-
-		err = gve_adminq_deconfigure_device_resources(priv);
-		if (err)
-			dev_err(&priv->pdev->dev,
-				"Could not deconfigure device resources: err=%d\n",
-				err);
+		ops->release_db_resources(priv);
 	}
 
 	gve_clear_device_resources_ok(priv);
@@ -2502,6 +2498,8 @@ static const struct gve_ctrl_ops gve_adminq_ops = {
 	.reset_flow_rules	= gve_adminq_reset_flow_rules,
 	.setup_stats_report	= gve_adminq_report_stats,
 	.configure_rss		= gve_adminq_configure_rss,
+	.request_db_info	= gve_adminq_request_db_info,
+	.release_db_resources	= gve_adminq_release_db_resources,
 };
 
 static int gve_init_priv(struct gve_priv *priv)
-- 
2.55.0.979.g7e5102b832-goog

