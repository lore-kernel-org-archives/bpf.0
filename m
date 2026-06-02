Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 380703D9DA6
	for <bpf@vger.kernel.org>; Tue,  2 Jun 2026 23:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780444757; cv=none; b=rmBsbhzRk19hWdHWTqlwJHTs06XFlhXFtwB3Mj2XxEn2u3z2nc1UFdJETJG1rC2EPAVSdxgMhSya88nblKJLUdOv+zt61m6FxlcRDJ6y5uRUEeOV2FlPUT4E/HS71CKTFOBK47+4N7J/y/C7IoVSRAIEtkNGNcauIHzsYUawBPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780444757; c=relaxed/simple;
	bh=qdUwWfqH2ScZ7OVPBHIwyGfGzSkBUL7CRJoOZbN0zTE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ncP4gvf9HTGuw2A9/RKl7AVS/rkL5YjhTAXny4PLDPx7kA4llSjtfDD2cROVF2c3tSWqXOpuYFqYrwtgdxkyD9o293zektCLtsnFV6we5lD7f2IJk5t2rkcSzE34GYz5JBp98K/YsQgfVxEoMkgnOCnV5SyrfRFcCfH9RWHuvU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ax4So56q; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ax4So56q"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2beff6b6e74so73860135ad.1
        for <bpf@vger.kernel.org>; Tue, 02 Jun 2026 16:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780444753; x=1781049553; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9FlKji3hm2NB+QDodIndkPfsEAgD6+iyL7xiAelQYGw=;
        b=Ax4So56q5k61i1vdoLW3n8+og9SmBUt7sisIU3DLWBqMAht0l3yn7usMlfi0IhGrSs
         2sQtiWNah56R57810d99CnQ78qMhbRcVrYHS9hPsA50QtIRMF0i6Ea/pNk03VROYPJwV
         ChnRbT7JpoQL5k74+K36bUlbEP3GGAeuZfZulLNVxLKbFN/+kd1nCFgbHZaENfintGrG
         OQPYBnGCmWLw8H1evA5h7xdaJ/z/b0PA8Vt3QF3/5ek8E1gilUycAYEGjFOJm2nIOhB/
         XxPIpcT/Go9ZJYeA8kNLgG3mZBs7J1zZXHNs2839yc1DO7iNGWvdrbI5dbz2RGHR/UV8
         LY9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780444753; x=1781049553;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9FlKji3hm2NB+QDodIndkPfsEAgD6+iyL7xiAelQYGw=;
        b=jvk8gwxhE0Yo8HebQb4cG/pCs42+owJZPA9h8ZqyfNBf8XJgqPyjq8IFZXf2KdSjSd
         zMk6rKsUpxZrE3hUg84MWPABelbh29ldBIvY8Us6A9oYLJFNNF6N6uCJiGPh5v+yKMxC
         zxKpd8+mhY0nS2UwakbRvPiso5e8gjg8AJs/PH940Q4b65St5uVZ6JD6v7ALEIkWI8Z0
         kELTfNc5/IrIgin4n/1saq9dw/BHzbGE4eXkUlp/hkc3FAe4qwex96DkXxo2F5v0bL4p
         UDjtkH4nzb0ddWxmMCTHQHVEa1eKSRqkIngZ0/4venSYUT94DlcvDbl2XeWDbVV5Cffi
         EOtg==
X-Forwarded-Encrypted: i=1; AFNElJ9u85usJrEAtCs/OGqUOd/tqKMaFcQTfsY5kkvsUze/4/Tb1V6pVBAOJ+boFLwdJ3/2Ndc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAdZKTPlBOucc3fr60rbb4zK6yIpceb2enKfrymV+jUSwFpddN
	rJmYVpFySOFfL7cS7XXThGToXNqtgvXv7pcZg67AS3SbHx0DzdkNaitdZn3AdvLi4l4O4Y91Odl
	4hHNO2IcB2TgbS0x7U3ViL2i6iA==
X-Received: from plbke7.prod.google.com ([2002:a17:903:3407:b0:2bf:190f:f93e])
 (user=hramamurthy job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:e985:b0:2c1:5a24:b4ed with SMTP id d9443c01a7336-2c1644d1a9bmr6069555ad.37.1780444752437;
 Tue, 02 Jun 2026 16:59:12 -0700 (PDT)
Date: Tue,  2 Jun 2026 23:58:56 +0000
In-Reply-To: <20260602235900.3050782-1-hramamurthy@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260602235900.3050782-1-hramamurthy@google.com>
X-Mailer: git-send-email 2.54.0.1013.g208068f2d8-goog
Message-ID: <20260602235900.3050782-13-hramamurthy@google.com>
Subject: [PATCH net-next v2 12/15] gve: introduce new methods to handle IRQ doorbells
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

Introduce `request_db_info` and `free_db_resources` to
`struct gve_ctrl_ops`. These encapsulate the configuration of device
resources (counter arrays and IRQ doorbell indices) which vary between
Admin Queue and Mailbox modes. All behaviors related to the IRQ doorbell
indices will be managed by these new methods instead of occurring
directly in notify_block setup/teardown methods. Similarly, GQ ring
counters will be managed in `request_db_info`.

Reviewed-by: Willem de Bruijn <willemb@google.com>
Reviewed-by: Jordan Rhee <jordanrhee@google.com>
Signed-off-by: Joshua Washington <joshwash@google.com>
Signed-off-by: Harshitha Ramamurthy <hramamurthy@google.com>
---
 drivers/net/ethernet/google/gve/gve.h        | 12 ++++
 drivers/net/ethernet/google/gve/gve_adminq.c | 71 ++++++++++++++++++++
 drivers/net/ethernet/google/gve/gve_adminq.h |  2 +
 drivers/net/ethernet/google/gve/gve_main.c   | 70 +++++--------------
 4 files changed, 103 insertions(+), 52 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve.h b/drivers/net/ethernet/google/gve/gve.h
index e173c14bdc08..6db5fbc0b321 100644
--- a/drivers/net/ethernet/google/gve/gve.h
+++ b/drivers/net/ethernet/google/gve/gve.h
@@ -833,6 +833,8 @@ struct gve_device_info {
  *                  structures stored in @priv to be used during initialization.
  * @set_num_ntfy_blks: Sets no. of vectors into @priv to be used during
  *                     initialization.
+ * @request_db_info: Request and store doorbell information into @priv
+ * @free_db_resources: Free DMA memory holding doorbell info (AdminQ only)
  * @get_ptype_map: Learn packet type map from device and store it in @priv
  * @configure_rss: Set up default RSS configuration
  * @setup_stats_report: Set up DMA region for stats report (AdminQ only)
@@ -843,6 +845,8 @@ struct gve_ctrl_ops {
 	void (*unmap_db_bar)(struct gve_priv *priv);
 	void (*set_num_queues)(struct gve_priv *priv);
 	int (*set_num_ntfy_blks)(struct gve_priv *priv);
+	int (*request_db_info)(struct gve_priv *priv);
+	void (*free_db_resources)(struct gve_priv *priv);
 	int (*get_ptype_map)(struct gve_priv *priv);
 	int (*configure_rss)(struct gve_priv *priv,
 			     struct ethtool_rxfh_param *param);
@@ -1163,6 +1167,11 @@ static inline u32 gve_rx_idx_to_ntfy(struct gve_priv *priv, u32 queue_idx)
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
@@ -1375,6 +1384,9 @@ int gve_adjust_queues(struct gve_priv *priv,
 		      struct gve_rx_queue_config new_rx_config,
 		      struct gve_tx_queue_config new_tx_config,
 		      bool reset_rss);
+/* Initialization sequence */
+int gve_alloc_counter_array(struct gve_priv *priv);
+void gve_free_counter_array(struct gve_priv *priv);
 /* flow steering rule */
 int gve_get_flow_rule_entry(struct gve_priv *priv, struct ethtool_rxnfc *cmd);
 int gve_get_flow_rule_ids(struct gve_priv *priv, struct ethtool_rxnfc *cmd, u32 *rule_locs);
diff --git a/drivers/net/ethernet/google/gve/gve_adminq.c b/drivers/net/ethernet/google/gve/gve_adminq.c
index d814108deeef..259dcd617216 100644
--- a/drivers/net/ethernet/google/gve/gve_adminq.c
+++ b/drivers/net/ethernet/google/gve/gve_adminq.c
@@ -1719,3 +1719,74 @@ void gve_adminq_set_num_queues(struct gve_priv *priv)
 						device_info->default_rx_queues,
 						priv->rx_cfg.num_queues);
 }
+
+int gve_adminq_request_db_info(struct gve_priv *priv)
+{
+	int err;
+	int i;
+
+	/* Alloc dma addrs needed for shm regions */
+	err = gve_alloc_counter_array(priv);
+	if (err) {
+		dev_err(&priv->pdev->dev,
+			"Failed to alloc db counter array.");
+		return err;
+	}
+
+	priv->irq_db_indices =
+		dma_alloc_coherent(&priv->pdev->dev,
+				   priv->num_ntfy_blks *
+				   sizeof(*priv->irq_db_indices),
+				   &priv->irq_db_indices_bus, GFP_KERNEL);
+	if (!priv->irq_db_indices) {
+		err = -ENOMEM;
+		goto abort_with_counter_array;
+	}
+
+	err = gve_adminq_configure_device_resources(priv,
+						    priv->counter_array_bus,
+						    priv->num_event_counters,
+						    priv->irq_db_indices_bus,
+						    priv->num_ntfy_blks);
+	if (unlikely(err)) {
+		dev_err(&priv->pdev->dev,
+			"could not setup device_resources: err=%d\n", err);
+		err = -ENXIO;
+		goto abort_with_irq_db_indices;
+	}
+
+	for (i = 0; i < priv->num_ntfy_blks; i++)
+		priv->ntfy_blocks[i].irq_db_index =
+			&priv->irq_db_indices[i].index;
+	return 0;
+
+abort_with_irq_db_indices:
+	dma_free_coherent(&priv->pdev->dev, priv->num_ntfy_blks *
+			  sizeof(*priv->irq_db_indices),
+			  priv->irq_db_indices, priv->irq_db_indices_bus);
+	priv->irq_db_indices = NULL;
+abort_with_counter_array:
+	gve_free_counter_array(priv);
+	return err;
+}
+
+void gve_adminq_free_db_resources(struct gve_priv *priv)
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
+
+	dma_free_coherent(&priv->pdev->dev, priv->num_ntfy_blks *
+			  sizeof(*priv->irq_db_indices),
+			  priv->irq_db_indices, priv->irq_db_indices_bus);
+	priv->irq_db_indices = NULL;
+	gve_free_counter_array(priv);
+}
diff --git a/drivers/net/ethernet/google/gve/gve_adminq.h b/drivers/net/ethernet/google/gve/gve_adminq.h
index d5f98a80be46..985b1aefea6e 100644
--- a/drivers/net/ethernet/google/gve/gve_adminq.h
+++ b/drivers/net/ethernet/google/gve/gve_adminq.h
@@ -657,5 +657,7 @@ int gve_adminq_map_db_bar(struct gve_priv *priv);
 void gve_adminq_unmap_db_bar(struct gve_priv *priv);
 int gve_adminq_set_num_ntfy_blks(struct gve_priv *priv);
 void gve_adminq_set_num_queues(struct gve_priv *priv);
+int gve_adminq_request_db_info(struct gve_priv *priv);
+void gve_adminq_free_db_resources(struct gve_priv *priv);
 
 #endif /* _GVE_ADMINQ_H */
diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
index 98970508ae54..55f48aee125e 100644
--- a/drivers/net/ethernet/google/gve/gve_main.c
+++ b/drivers/net/ethernet/google/gve/gve_main.c
@@ -179,7 +179,7 @@ static void gve_free_rss_config_cache(struct gve_priv *priv)
 	memset(rss_config, 0, sizeof(*rss_config));
 }
 
-static int gve_alloc_counter_array(struct gve_priv *priv)
+int gve_alloc_counter_array(struct gve_priv *priv)
 {
 	priv->counter_array =
 		dma_alloc_coherent(&priv->pdev->dev,
@@ -192,7 +192,7 @@ static int gve_alloc_counter_array(struct gve_priv *priv)
 	return 0;
 }
 
-static void gve_free_counter_array(struct gve_priv *priv)
+void gve_free_counter_array(struct gve_priv *priv)
 {
 	if (!priv->counter_array)
 		return;
@@ -428,15 +428,6 @@ int gve_napi_poll_dqo(struct napi_struct *napi, int budget)
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
@@ -493,24 +484,14 @@ static int gve_alloc_notify_blocks(struct gve_priv *priv)
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
@@ -525,13 +506,14 @@ static void gve_teardown_notify_blocks(struct gve_priv *priv)
 
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
@@ -560,12 +542,11 @@ static int gve_setup_notify_blocks(struct gve_priv *priv)
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
@@ -575,14 +556,13 @@ static int gve_setup_notify_blocks(struct gve_priv *priv)
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
@@ -599,7 +579,6 @@ static int gve_setup_notify_blocks(struct gve_priv *priv)
 	return err;
 }
 
-
 static void gve_free_control_plane_resources(struct gve_priv *priv)
 {
 	bitmap_free(priv->xsk_pools);
@@ -608,9 +587,8 @@ static void gve_free_control_plane_resources(struct gve_priv *priv)
 	kvfree(priv->ptype_lut_dqo);
 	priv->ptype_lut_dqo = NULL;
 
-	gve_free_stats_report(priv);
 	gve_free_notify_blocks(priv);
-	gve_free_counter_array(priv);
+	gve_free_stats_report(priv);
 	gve_free_rss_config_cache(priv);
 	gve_free_flow_rule_caches(priv);
 }
@@ -623,9 +601,6 @@ static int gve_alloc_control_plane_resources(struct gve_priv *priv)
 	if (err)
 		return err;
 	err = gve_alloc_rss_config_cache(priv);
-	if (err)
-		goto abort;
-	err = gve_alloc_counter_array(priv);
 	if (err)
 		goto abort;
 	err = gve_alloc_notify_blocks(priv);
@@ -661,15 +636,9 @@ static int gve_setup_control_plane_resources(struct gve_priv *priv)
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
 
@@ -678,7 +647,7 @@ static int gve_setup_control_plane_resources(struct gve_priv *priv)
 		if (err) {
 			dev_err(&priv->pdev->dev,
 				"Failed to get ptype map: err=%d\n", err);
-			goto deconfigure_device;
+			goto free_db_resources;
 		}
 	}
 
@@ -708,8 +677,8 @@ static int gve_setup_control_plane_resources(struct gve_priv *priv)
 
 teardown_clock:
 	gve_teardown_clock(priv);
-deconfigure_device:
-	gve_adminq_deconfigure_device_resources(priv);
+free_db_resources:
+	ops->free_db_resources(priv);
 	return err;
 }
 
@@ -739,12 +708,7 @@ static void gve_teardown_control_plane_resources(struct gve_priv *priv)
 			dev_err(&priv->pdev->dev,
 				"Failed to detach stats report: err=%d\n", err);
 		gve_teardown_clock(priv);
-
-		err = gve_adminq_deconfigure_device_resources(priv);
-		if (err)
-			dev_err(&priv->pdev->dev,
-				"Could not deconfigure device resources: err=%d\n",
-				err);
+		ops->free_db_resources(priv);
 	}
 
 	gve_clear_device_resources_ok(priv);
@@ -2494,6 +2458,8 @@ static const struct gve_ctrl_ops gve_adminq_ops = {
 	.reset_flow_rules	= gve_adminq_reset_flow_rules,
 	.setup_stats_report	= gve_adminq_report_stats,
 	.configure_rss		= gve_adminq_configure_rss,
+	.request_db_info	= gve_adminq_request_db_info,
+	.free_db_resources	= gve_adminq_free_db_resources,
 };
 
 static int gve_init_priv(struct gve_priv *priv)
-- 
2.54.0.1013.g208068f2d8-goog

