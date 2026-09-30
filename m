Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02BA73EA959
	for <bpf@vger.kernel.org>; Wed, 30 Sep 2026 19:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790795084; cv=none; b=qe1jfPf2fk5vdmqMXcvfYs2HWNwbkla9Qvh7oAM4BrynJ8dznZk48kD+/J6/jdOc9+Tjn/wTt2DXBARYnXO1tYntPfOK3Ee9w9G4Qko/cQj2E0Q6u/mh+pjc9E7bC5m1QdJWpka4Oy9qk0IwNVgJmm+KOg4CbjF5nCx3ThfxG3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790795084; c=relaxed/simple;
	bh=16VNDv36U7RnJ32UVQkm+SpC6F2UeOEDhcLoFWBb+BY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ITBgHS2fDKqMk0rggHd6SOshaHIObZoErUry7eRVRyNmD/YhEWOzycX+1ooK/o85ngZT8QV7E1FicwBkUpbW52cidS9tyNuEZmaon9ypwd/ppcubOr1nEndfisFEt7LHWLNjmckcOx2lJJB8qYID2vnWMRVnzlPq1mMlkH5kg38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SWqp78/S; arc=none smtp.client-ip=209.85.215.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SWqp78/S"
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cb11535e6a1so3376172a12.0
        for <bpf@vger.kernel.org>; Wed, 30 Sep 2026 12:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790795079; x=1791399879; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TB2352dXpaGgujA48cCmeZiOOZk9ZNkvEgcF/lLxuDw=;
        b=SWqp78/SaEwOfZYZEGs+pvJfu9O+8DDy0amNq/0tTjzc32wjxgivPX3G75Up0VZLGC
         ItMbmEh8AbNRiabklztXxXx7N8On88cGA+V/O8vTAUkSXTV/InCf1KbmlAFxBjAdGG8g
         M8KBNve60mQ82/4JVAHVslMG50KIL0VllTWdtOML6VENqehTBZ7F8S9iHmarfopB5Mp7
         w0rBJvROUbbG2P83ZrQBPcrlHMuFk5TjdvndmZXfmDKv41sfflb4H9xIbg4nKvVlSUrA
         LOF/WeVJ1mysSSVh3F1fiFMWRoCiz0/EryLMjrdXyKbDZwelZKDJ2YpscwcisOka7idN
         fOrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790795079; x=1791399879;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TB2352dXpaGgujA48cCmeZiOOZk9ZNkvEgcF/lLxuDw=;
        b=j5HHJmdIJ0NzLON5M+TcS+i/dlyDCCz3XWVax+gkR1u7QnoxxCBx6DUPqOQoRPJv0E
         FY75nEQzLHzYPJkB3F/t6uoMlWauAvsJa/MP5Qx3Ry9/75Hvs5nL6ykkeOfIUrp6GgTr
         x7tHVD67nkCTzLqmM523AJCF8bH2/SjxAfvXU+pZO49+v8jT9Iv7VR3s8RrN5Nfw9Upp
         qPGBKxjGhwrEz6AIOPkJEWtOdAc76Z5sdyaSv5I/OLZKTx8veI0Qa1dbPayc5FoONJAe
         nKH3x2V1URDdtvbFwL1n/tjoxHgUO5EszJxN9+NCWqOXzFxILOj2vrpDnETpauG3SLeM
         JChg==
X-Forwarded-Encrypted: i=1; AKwUvByzpnYV4dJYNG++fpDvdghxlRnWMU42H/WaA9r3vYpDu8/ZN0NQUw8OmqZY4cz5IfpWJQM=@vger.kernel.org
X-Gm-Message-State: AFuF++l0lStQ+cITfnqQcJAn031Fkb8Nhcsl7wJtGIfqDCO/eAXrB683
	5Fzlpee7SiVDwyzveV36GSRusmBc/3/15A2z3jFxfcfw3vsl/kSF39XvdRYv10um47QQyiZbY3q
	Txgk/yk0qMgEVPX9dLacGUJzuGQ==
X-Received: from pgbfu14.prod.google.com ([2002:a05:6a02:4a8e:b0:cc7:c945:40ba])
 (user=hramamurthy job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6300:141:b0:3dd:a195:dd60 with SMTP id adf61e73a8af0-3de9eb85144mr2358902637.66.1790795079200;
 Wed, 30 Sep 2026 12:04:39 -0700 (PDT)
Date: Wed, 30 Sep 2026 19:04:25 +0000
In-Reply-To: <20260930190428.1130007-1-hramamurthy@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260930190428.1130007-1-hramamurthy@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260930190428.1130007-10-hramamurthy@google.com>
Subject: [PATCH net-next v9 09/12] gve: introduce new methods to handle IRQ doorbells
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
Admin Queue and Mailbox modes. All behaviors related to the IRQ doorbell
indices will be managed by these new methods instead of occurring
directly in notify_block setup/teardown methods. Similarly, GQ ring
counters will be managed in `request_db_info`.

Reviewed-by: Willem de Bruijn <willemb@google.com>
Reviewed-by: Jordan Rhee <jordanrhee@google.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Joshua Washington <joshwash@google.com>
Signed-off-by: Harshitha Ramamurthy <hramamurthy@google.com>
---
v6:
- update commit message

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

 drivers/net/ethernet/google/gve/gve.h        |  10 ++
 drivers/net/ethernet/google/gve/gve_adminq.c |  37 +++++++
 drivers/net/ethernet/google/gve/gve_adminq.h |   2 +
 drivers/net/ethernet/google/gve/gve_main.c   | 101 +++++++++----------
 4 files changed, 99 insertions(+), 51 deletions(-)

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
index 01a271680d78..d8fafe56f5b8 100644
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
@@ -428,15 +452,6 @@ int gve_napi_poll_dqo(struct napi_struct *napi, int budget)
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
@@ -493,24 +508,14 @@ static int gve_alloc_notify_blocks(struct gve_priv *priv)
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
@@ -530,13 +535,14 @@ static void gve_teardown_notify_blocks(struct gve_priv *priv)
 
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
 		block->irq_requested = false;
 	}
 }
@@ -548,7 +554,7 @@ static int gve_setup_notify_blocks(struct gve_priv *priv)
 	int i;
 	int err;
 
-	/* Setup Management Vector  - the last vector */
+	/* Setup Management Vector */
 	snprintf(priv->mgmt_msix_name, sizeof(priv->mgmt_msix_name),
 		 "gve-mgmnt@pci:%s", pci_name(priv->pdev));
 	err = request_irq(priv->msix_vectors[priv->mgmt_msix_idx].vector,
@@ -559,12 +565,11 @@ static int gve_setup_notify_blocks(struct gve_priv *priv)
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
@@ -574,14 +579,13 @@ static int gve_setup_notify_blocks(struct gve_priv *priv)
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
@@ -598,7 +602,6 @@ static int gve_setup_notify_blocks(struct gve_priv *priv)
 	return err;
 }
 
-
 static void gve_tx_get_curr_alloc_cfg(struct gve_priv *priv,
 				      struct gve_tx_alloc_rings_cfg *cfg)
 {
@@ -665,9 +668,10 @@ static void gve_free_control_plane_resources(struct gve_priv *priv)
 	priv->ptype_lut_dqo = NULL;
 
 	gve_teardown_clock(priv);
-	gve_free_stats_report(priv);
-	gve_free_notify_blocks(priv);
+	gve_free_irq_db_indices(priv);
 	gve_free_counter_array(priv);
+	gve_free_notify_blocks(priv);
+	gve_free_stats_report(priv);
 	gve_free_rss_config_cache(priv);
 	gve_free_flow_rule_caches(priv);
 }
@@ -680,15 +684,18 @@ static int gve_alloc_control_plane_resources(struct gve_priv *priv)
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
 
@@ -718,15 +725,9 @@ static int gve_setup_control_plane_resources(struct gve_priv *priv)
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
 
@@ -735,7 +736,7 @@ static int gve_setup_control_plane_resources(struct gve_priv *priv)
 		if (err) {
 			dev_err(&priv->pdev->dev,
 				"Failed to get ptype map: err=%d\n", err);
-			goto deconfigure_device;
+			goto release_db_resources;
 		}
 	}
 
@@ -750,7 +751,7 @@ static int gve_setup_control_plane_resources(struct gve_priv *priv)
 	err = gve_init_rss_config(priv, priv->rx_cfg.num_queues);
 	if (err) {
 		dev_err(&priv->pdev->dev, "Failed to init RSS config");
-		goto deconfigure_device;
+		goto release_db_resources;
 	}
 
 	err = ops->setup_stats_report(priv, priv->stats_report_len,
@@ -763,8 +764,8 @@ static int gve_setup_control_plane_resources(struct gve_priv *priv)
 	gve_set_device_resources_ok(priv);
 	return 0;
 
-deconfigure_device:
-	gve_adminq_deconfigure_device_resources(priv);
+release_db_resources:
+	ops->release_db_resources(priv);
 	return err;
 }
 
@@ -799,11 +800,7 @@ static void gve_teardown_control_plane_resources(struct gve_priv *priv)
 		if (err)
 			dev_err(&priv->pdev->dev,
 				"Failed to detach stats report: err=%d\n", err);
-		err = gve_adminq_deconfigure_device_resources(priv);
-		if (err)
-			dev_err(&priv->pdev->dev,
-				"Could not deconfigure device resources: err=%d\n",
-				err);
+		ops->release_db_resources(priv);
 	}
 
 	gve_clear_device_resources_ok(priv);
@@ -2507,6 +2504,8 @@ static const struct gve_ctrl_ops gve_adminq_ops = {
 	.reset_flow_rules	= gve_adminq_reset_flow_rules,
 	.setup_stats_report	= gve_adminq_report_stats,
 	.configure_rss		= gve_adminq_configure_rss,
+	.request_db_info	= gve_adminq_request_db_info,
+	.release_db_resources	= gve_adminq_release_db_resources,
 };
 
 static int gve_init_priv(struct gve_priv *priv)
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

