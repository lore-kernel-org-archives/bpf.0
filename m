Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F4C44322E7
	for <bpf@vger.kernel.org>; Mon,  3 Aug 2026 18:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785782802; cv=none; b=J+w8sSgPDtlWlUbp50ri/UMQZROC731S2PifODbUHaX/AjRus27JZKzUvBo8wNDpWTvDF8Y8XvtC+xM+JDFQ6PBeXlyKoNN6IhitJ4N+/b8wFAJe401PuX/2gpPRy9aXUM4d/xdIZ3bZbqkiEFleScnKIS0KlrpsTG69kRDBkQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785782802; c=relaxed/simple;
	bh=1uzoRqTMdqVMflAU37K8DRbZlGfidd6mc2WfPRpa6mo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CDsFB3yvuwVVXsH+BzNc2/LHPF+hgkz2MuuQ+FFV7e03pHSs6xxW+sNibnWDn9AaiEK5v3rJnS4zAFw3ddLApONXRAB+FhZQDwsyxqgRmKE0g20iWUKuQNDO07LXO8w/7C7N2FS1YH7P5aok7SxKtmVCiTuPXHAExMS2rZk5VJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Js7c/+zD; arc=none smtp.client-ip=209.85.214.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Js7c/+zD"
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2caf4173b1cso77764405ad.3
        for <bpf@vger.kernel.org>; Mon, 03 Aug 2026 11:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785782797; x=1786387597; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9Ykco/UIbXJhQGzB6LylG7Ki+XX+QafHm/6QOILOpK0=;
        b=Js7c/+zDKS/LH0FrexKQ642/9ms7NwO96PRi5oXrGrrbC8XrN+RKfcJBIEO+r7eb7h
         e3JZpZehPoh5frMmlSpEks64pe/F0QkJAF7Lo23c4OuiHco4JCkGBrw0tUD7cTKY2GPf
         d9VdU3UyEBiB0yQRsKJ7WBWOCoBhox6yeIKi74vxrhf55gItW0WpBp2cfiHDR2U3KNIR
         9yBF9kCSKYzjdHNF3h64JB9eq6qFrWhTxmBPPCPaD6QSFx/zhaxGOCwmp+KujEaFRhnQ
         ekLW7UhanGZyBqYz3cUkoCw1Y0Svhuwzfe72tuOA9omvi8rfQH4ORNglDr+MiACL1aOR
         oCAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785782797; x=1786387597;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9Ykco/UIbXJhQGzB6LylG7Ki+XX+QafHm/6QOILOpK0=;
        b=HYIffVfLF+ytliMXF0xOGhMz+5cTKmxcn3I8U/ELvVq/YpuHsqEc3U1L0MKGRBZh/i
         xc1CP61t7WNSFb1B5qMlblNeyI6tbrt2TPp/f+z+8sScghZ2CjR8NvPZC4LV9kMVIEOn
         3X4IQvEEHSKQYFvBpZRsyUETRQalt4zNCKFez7V60GCAALoioXYkrGXztHWsiF4tjQsG
         aBdPn47F0mlIRYmCKGECRIuSBBiXeumdD8WiC+HpqjFSaNC1cpsyhA1IHUw+uiFgEaO9
         qyDwbh23DFhcGDrttnFVr30mAOxWdCIrhu9oJ1jXkRFymeIIl2SLsUvSaenOBu39tuQO
         at3Q==
X-Forwarded-Encrypted: i=1; AHgh+Ro1bCJYSInr6xRJ6NMCZtUvLIOQPbpsjlXkmjSXGZPPD46uNYfGBK0vgvjq0/VWPSF1cWo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCBSC0btOlNa5aCokoNX6OYPQdbxmTMo5pfrzEmiwg2YYlM4E3
	lCI5BH3JNmxIhFvUIJ5aClkasKd5gNh0XQcI/B/p3CwIbWZOr6uJW/RBOKJ3SL6XYFZxdeug+48
	RKVuVCN18nbFYCTkQtSRC+l7Jfg==
X-Received: from pjzv17.prod.google.com ([2002:a17:90b:411:b0:38e:bc7d:7164])
 (user=hramamurthy job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:1c86:b0:38d:ef48:b04 with SMTP id 98e67ed59e1d1-38fbc4249efmr10521937a91.10.1785782796767;
 Mon, 03 Aug 2026 11:46:36 -0700 (PDT)
Date: Mon,  3 Aug 2026 18:46:20 +0000
In-Reply-To: <20260803184630.3813311-1-hramamurthy@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260803184630.3813311-1-hramamurthy@google.com>
X-Mailer: git-send-email 2.55.0.571.g244d577d93-goog
Message-ID: <20260803184630.3813311-6-hramamurthy@google.com>
Subject: [PATCH net-next v3 05/15] gve: introduce control plane operations structure
From: Harshitha Ramamurthy <hramamurthy@google.com>
To: netdev@vger.kernel.org
Cc: joshwash@google.com, hramamurthy@google.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org, 
	john.fastabend@gmail.com, sdf@fomichev.me, jordanrhee@google.com, 
	willemb@google.com, nktgrg@google.com, maolson@google.com, thostet@google.com, 
	jacob.e.keller@intel.com, debarghyak@google.com, kees@kernel.org, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

To abstract out the difference in implementation of control
plane operations between the existing Adminq ABI and the upcoming
Mailbox ABI, introduce a new gve_ctrl_ops structure which will
contain the basic operations. At probe, these ops will be set based
on the ABI and the corresponding ops will be called in relevant
places.

As of this patch, only Adminq ops are set. In future patches,
corresponding ops will be set for the new mailbox mode.

Implement a ctrl op to map/unmap the doorbell bar. Since this
functionality has moved to a control op, call this op after control
ops are set for AdminQ mode.

Reviewed-by: Willem de Bruijn <willemb@google.com>
Reviewed-by: Jordan Rhee <jordanrhee@google.com>
Signed-off-by: Harshitha Ramamurthy <hramamurthy@google.com>
---
 drivers/net/ethernet/google/gve/gve.h        | 11 ++++++
 drivers/net/ethernet/google/gve/gve_adminq.c | 21 ++++++++++++
 drivers/net/ethernet/google/gve/gve_adminq.h |  2 ++
 drivers/net/ethernet/google/gve/gve_main.c   | 36 +++++++++++---------
 4 files changed, 54 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve.h b/drivers/net/ethernet/google/gve/gve.h
index 021adb9108df..56148ea3cfbf 100644
--- a/drivers/net/ethernet/google/gve/gve.h
+++ b/drivers/net/ethernet/google/gve/gve.h
@@ -825,6 +825,16 @@ struct gve_device_info {
 	bool cache_rss_config;
 };
 
+/**
+ * struct gve_ctrl_ops - Control plane operations structure
+ * @map_db_bar: Maps the doorbell BAR for the device and store in @priv.
+ * @unmap_db_bar: Unmaps the doorbell BAR previously mapped by @map_db_bar.
+ */
+struct gve_ctrl_ops {
+	int (*map_db_bar)(struct gve_priv *priv);
+	void (*unmap_db_bar)(struct gve_priv *priv);
+};
+
 struct gve_priv {
 	struct net_device *dev;
 	struct gve_tx_ring *tx; /* array of tx_cfg.num_queues */
@@ -958,6 +968,7 @@ struct gve_priv {
 	dma_addr_t nic_ts_report_bus;
 	u64 last_sync_nic_counter; /* Clock counter from last NIC TS report */
 	struct gve_device_info device_info;
+	const struct gve_ctrl_ops *ctrl_ops;
 };
 
 enum gve_service_task_flags_bit {
diff --git a/drivers/net/ethernet/google/gve/gve_adminq.c b/drivers/net/ethernet/google/gve/gve_adminq.c
index bb18e5af958b..9c3ebdb547cf 100644
--- a/drivers/net/ethernet/google/gve/gve_adminq.c
+++ b/drivers/net/ethernet/google/gve/gve_adminq.c
@@ -1591,3 +1591,24 @@ int gve_adminq_query_rss_config(struct gve_priv *priv, struct ethtool_rxfh_param
 	dma_pool_free(priv->adminq_pool, descriptor, descriptor_bus);
 	return err;
 }
+
+int gve_adminq_map_db_bar(struct gve_priv *priv)
+{
+	struct pci_dev *pdev = priv->pdev;
+	void __iomem *db_bar;
+
+	db_bar = pci_iomap(pdev, GVE_DOORBELL_BAR, 0);
+	if (!db_bar) {
+		dev_err(&pdev->dev, "Failed to map doorbell bar!\n");
+		return -ENOMEM;
+	}
+	priv->db_bar2 = db_bar;
+	return 0;
+}
+
+void gve_adminq_unmap_db_bar(struct gve_priv *priv)
+{
+	struct pci_dev *pdev = priv->pdev;
+
+	pci_iounmap(pdev, priv->db_bar2);
+}
diff --git a/drivers/net/ethernet/google/gve/gve_adminq.h b/drivers/net/ethernet/google/gve/gve_adminq.h
index 8e80f36116ec..2a184e051202 100644
--- a/drivers/net/ethernet/google/gve/gve_adminq.h
+++ b/drivers/net/ethernet/google/gve/gve_adminq.h
@@ -656,5 +656,7 @@ int gve_adminq_report_nic_ts(struct gve_priv *priv,
 struct gve_ptype_lut;
 int gve_adminq_get_ptype_map_dqo(struct gve_priv *priv,
 				 struct gve_ptype_lut *ptype_lut);
+int gve_adminq_map_db_bar(struct gve_priv *priv);
+void gve_adminq_unmap_db_bar(struct gve_priv *priv);
 
 #endif /* _GVE_ADMINQ_H */
diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
index 9a484fa15abe..fff63b90dcbb 100644
--- a/drivers/net/ethernet/google/gve/gve_main.c
+++ b/drivers/net/ethernet/google/gve/gve_main.c
@@ -2508,6 +2508,11 @@ static void gve_set_buf_sizes(struct gve_priv *priv)
 		priv->header_buf_size = device_info->header_buf_size;
 }
 
+static const struct gve_ctrl_ops gve_adminq_ops = {
+	.map_db_bar	 = gve_adminq_map_db_bar,
+	.unmap_db_bar	 = gve_adminq_unmap_db_bar,
+};
+
 static int gve_init_priv(struct gve_priv *priv, bool skip_describe_device)
 {
 	struct gve_device_info *device_info = &priv->device_info;
@@ -2905,7 +2910,6 @@ static int gve_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 {
 	int max_tx_queues, max_rx_queues;
 	struct net_device *dev;
-	__be32 __iomem *db_bar;
 	struct gve_registers __iomem *reg_bar;
 	struct gve_priv *priv;
 	int err;
@@ -2933,13 +2937,6 @@ static int gve_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		goto abort_with_pci_region;
 	}
 
-	db_bar = pci_iomap(pdev, GVE_DOORBELL_BAR, 0);
-	if (!db_bar) {
-		dev_err(&pdev->dev, "Failed to map doorbell bar!\n");
-		err = -ENOMEM;
-		goto abort_with_reg_bar;
-	}
-
 	gve_write_version(&reg_bar->driver_version);
 	/* Get max queues to alloc etherdev */
 	max_tx_queues = ioread32be(&reg_bar->max_tx_queues);
@@ -2949,7 +2946,7 @@ static int gve_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (!dev) {
 		dev_err(&pdev->dev, "could not allocate netdev\n");
 		err = -ENOMEM;
-		goto abort_with_db_bar;
+		goto abort_with_reg_bar;
 	}
 	SET_NETDEV_DEV(dev, &pdev->dev);
 	pci_set_drvdata(pdev, dev);
@@ -2981,19 +2978,27 @@ static int gve_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	priv->pdev = pdev;
 	priv->msg_enable = DEFAULT_MSG_LEVEL;
 	priv->reg_bar0 = reg_bar;
-	priv->db_bar2 = db_bar;
 	priv->service_task_flags = 0x0;
 	priv->state_flags = 0x0;
 	priv->ethtool_flags = 0x0;
 	priv->rx_cfg.packet_buffer_size = GVE_DEFAULT_RX_BUFFER_SIZE;
 	priv->max_rx_buffer_size = GVE_DEFAULT_RX_BUFFER_SIZE;
 
+	/* Set adminq ctrl ops */
+	priv->ctrl_ops = &gve_adminq_ops;
+
+	err = priv->ctrl_ops->map_db_bar(priv);
+	if (err) {
+		err = -ENOMEM;
+		goto abort_with_netdev;
+	}
+
 	gve_set_probe_in_progress(priv);
 	priv->gve_wq = alloc_ordered_workqueue("gve", 0);
 	if (!priv->gve_wq) {
 		dev_err(&pdev->dev, "Could not allocate workqueue");
 		err = -ENOMEM;
-		goto abort_with_netdev;
+		goto abort_with_unmap_db_bar;
 	}
 	INIT_WORK(&priv->service_task, gve_service_task);
 	INIT_WORK(&priv->stats_report_task, gve_stats_report_task);
@@ -3023,12 +3028,12 @@ static int gve_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 abort_with_wq:
 	destroy_workqueue(priv->gve_wq);
 
+abort_with_unmap_db_bar:
+	priv->ctrl_ops->unmap_db_bar(priv);
+
 abort_with_netdev:
 	free_netdev(dev);
 
-abort_with_db_bar:
-	pci_iounmap(pdev, db_bar);
-
 abort_with_reg_bar:
 	pci_iounmap(pdev, reg_bar);
 
@@ -3044,14 +3049,13 @@ static void gve_remove(struct pci_dev *pdev)
 {
 	struct net_device *netdev = pci_get_drvdata(pdev);
 	struct gve_priv *priv = netdev_priv(netdev);
-	__be32 __iomem *db_bar = priv->db_bar2;
 	void __iomem *reg_bar = priv->reg_bar0;
 
 	unregister_netdev(netdev);
 	gve_teardown_priv_resources(priv);
 	destroy_workqueue(priv->gve_wq);
+	priv->ctrl_ops->unmap_db_bar(priv);
 	free_netdev(netdev);
-	pci_iounmap(pdev, db_bar);
 	pci_iounmap(pdev, reg_bar);
 	pci_release_regions(pdev);
 	pci_disable_device(pdev);
-- 
2.55.0.571.g244d577d93-goog

