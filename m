Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 550563D3489
	for <bpf@vger.kernel.org>; Tue,  2 Jun 2026 23:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780444750; cv=none; b=A992E3SCGwbNrYYrdtZUgChxis/87Xtmoli7NKs/ZFWiLmsFgMJwwjAMLy/UjGNv/PlarFcK2wMCFncssXcOWyC9QbJe0geA/UBCJJwF3Jp7q2vXqEeQ5VnwyMSXCjmO/xT2aeiwZa+MfeESlZ5uiimMequCIaMlzodqegWZ6DU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780444750; c=relaxed/simple;
	bh=FwGXS8e6HUgTVB3w+vwLfDxMVnGT2dm1xGoUpgeqMYo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KAcVAbSuOnAtz7qqanyJeis/3GbcfDhw1ktNfuP8YD8wRoOSJiZyIJQkbXMbXtqxFE0e656sxETpBCEiFnmAX1yFsb83lMoAH7Fj5GepoOQ639G2ZgN7G6jGJEL5xpzzTAaB8aXoQdIyNaOPtYeffiJOAHNx1zJierBF4sXzUP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AAV6YedE; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AAV6YedE"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c857ebbb0easo56618a12.1
        for <bpf@vger.kernel.org>; Tue, 02 Jun 2026 16:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780444747; x=1781049547; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=SIbPdnvitqMPA6Y12Vag7sROSmwPcIYAij/Y31wBos8=;
        b=AAV6YedEMHMluSYNLpb2q5QtADdklMRbp7OEvqYWxA+cYJ0oNJRAPl3uviu2CI2Ks4
         ukEPGfEB+OdzcYT2fz59L0MuNIzkQP990Z0YAxQIFCgRtTJlvKAMtvCkibN4HnhHmUBx
         AF9pS4iF6gJ5NIRwA19JFvMmSm65H64H9y6cjaLixGcgBHllycjjwP3u7VODzVXwbbmC
         NhYUxjgQe35sO3y01SqgiuhxaaCOz3rQe+VuuJbRhvm4bW6PVU2UO6ilcxyiZnZDVOP8
         LInmHGBYO+9wZd67NT14ZwfCXoRKMOoKBCxourhVmR5cG9k7ZMlqQIHW/jbeGfoJrORL
         KlAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780444747; x=1781049547;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SIbPdnvitqMPA6Y12Vag7sROSmwPcIYAij/Y31wBos8=;
        b=g2VUyCAmBE79pdvJdUb3dMXzsAlOUJHQ0RwzEGCmYeYPaac0sYif40oBS1cP+k++yW
         bIKS2q4Y6GIM5l3J5YICgVYKRJynzyqDRdfXKzAiPB0qIZ55HzY/rQRqriQ7mFK/Fkuj
         UyCLfeABxOnsa0Toq8GrQJV01APAf+XWcxq80j5zWRigzz758l/s6peHjP83r0TEQC6y
         nPy3Tziny9nFDexOKAoomOJQ35Zd2hlL/iSS4x6ox8vy+E26c7x+K3VuZ6oAvCBzxHdj
         d8O3yAf9UU7pKlBvDEcf2UKRTQHGJo+ChaWIdxt0Hg04TlTIkyA7q1CjkVKyouUFYMJi
         Hn+w==
X-Forwarded-Encrypted: i=1; AFNElJ/pu1ODWDYyunlTzUQgdim8R9KjovjsjBbUDw/qD+/F8s7DKSj5pSkd6h/m4bAVXZfY0uo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUoh2q4UlcyzDBmOUmSUl5v0jK41glSce557oQKVljdxgSybcC
	tfSjwEJjaU3/FEgnBzpFKbrp6E3fj3FfhMuTSIpZsU5YwrlxeLujqYCYk7REYVNq9V71xqRWs+J
	BqYrkExCZx7hwD9Mna4u7bu2Swg==
X-Received: from pggu23.prod.google.com ([2002:a63:df17:0:b0:c85:8297:df9b])
 (user=hramamurthy job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:c996:b0:3b3:d656:b470 with SMTP id adf61e73a8af0-3b4989416bamr769252637.27.1780444747266;
 Tue, 02 Jun 2026 16:59:07 -0700 (PDT)
Date: Tue,  2 Jun 2026 23:58:50 +0000
In-Reply-To: <20260602235900.3050782-1-hramamurthy@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260602235900.3050782-1-hramamurthy@google.com>
X-Mailer: git-send-email 2.54.0.1013.g208068f2d8-goog
Message-ID: <20260602235900.3050782-7-hramamurthy@google.com>
Subject: [PATCH net-next v2 06/15] gve: introduce control plane operations structure
From: Harshitha Ramamurthy <hramamurthy@google.com>
To: netdev@vger.kernel.org
Cc: joshwash@google.com, hramamurthy@google.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org, 
	john.fastabend@gmail.com, sdf@fomichev.me, willemb@google.com, 
	jordanrhee@google.com, jfraker@google.com, nktgrg@google.com, 
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
index 086a315f42c1..c1e118241d2b 100644
--- a/drivers/net/ethernet/google/gve/gve.h
+++ b/drivers/net/ethernet/google/gve/gve.h
@@ -824,6 +824,16 @@ struct gve_device_info {
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
@@ -957,6 +967,7 @@ struct gve_priv {
 	dma_addr_t nic_ts_report_bus;
 	u64 last_sync_nic_counter; /* Clock counter from last NIC TS report */
 	struct gve_device_info device_info;
+	const struct gve_ctrl_ops *ctrl_ops;
 };
 
 enum gve_service_task_flags_bit {
diff --git a/drivers/net/ethernet/google/gve/gve_adminq.c b/drivers/net/ethernet/google/gve/gve_adminq.c
index 06db2ccd0b89..4617489d8714 100644
--- a/drivers/net/ethernet/google/gve/gve_adminq.c
+++ b/drivers/net/ethernet/google/gve/gve_adminq.c
@@ -1645,3 +1645,24 @@ int gve_adminq_query_rss_config(struct gve_priv *priv, struct ethtool_rxfh_param
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
index 831759d30f44..bc76976eb00f 100644
--- a/drivers/net/ethernet/google/gve/gve_adminq.h
+++ b/drivers/net/ethernet/google/gve/gve_adminq.h
@@ -655,5 +655,7 @@ int gve_adminq_report_nic_ts(struct gve_priv *priv,
 struct gve_ptype_lut;
 int gve_adminq_get_ptype_map_dqo(struct gve_priv *priv,
 				 struct gve_ptype_lut *ptype_lut);
+int gve_adminq_map_db_bar(struct gve_priv *priv);
+void gve_adminq_unmap_db_bar(struct gve_priv *priv);
 
 #endif /* _GVE_ADMINQ_H */
diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
index 1aeee916471f..51dd4f9b3022 100644
--- a/drivers/net/ethernet/google/gve/gve_main.c
+++ b/drivers/net/ethernet/google/gve/gve_main.c
@@ -2464,6 +2464,11 @@ static void gve_set_buf_sizes(struct gve_priv *priv)
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
@@ -2850,7 +2855,6 @@ static int gve_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 {
 	int max_tx_queues, max_rx_queues;
 	struct net_device *dev;
-	__be32 __iomem *db_bar;
 	struct gve_registers __iomem *reg_bar;
 	struct gve_priv *priv;
 	int err;
@@ -2878,13 +2882,6 @@ static int gve_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
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
@@ -2894,7 +2891,7 @@ static int gve_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (!dev) {
 		dev_err(&pdev->dev, "could not allocate netdev\n");
 		err = -ENOMEM;
-		goto abort_with_db_bar;
+		goto abort_with_reg_bar;
 	}
 	SET_NETDEV_DEV(dev, &pdev->dev);
 	pci_set_drvdata(pdev, dev);
@@ -2926,19 +2923,27 @@ static int gve_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
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
@@ -2968,12 +2973,12 @@ static int gve_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
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
 
@@ -2989,14 +2994,13 @@ static void gve_remove(struct pci_dev *pdev)
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
2.54.0.1013.g208068f2d8-goog

