Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7208E3C7DF5
	for <bpf@vger.kernel.org>; Wed, 30 Sep 2026 19:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790795076; cv=none; b=RqLtBCME/fAd7nPTk7zGDJ8io1gF/yRH7Z5lI946UsF4laUMSsnByG2lzBHU6lAP4lhEftKSrKe7mbxJPtXKnIas5QZQHc1+iLCBr8/YYIaseNL+6wusQrfI0xmDimA6vLLEK8jyHCpfI2xwRrLR+pQcrlcIjcJCGwd1ou2Evdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790795076; c=relaxed/simple;
	bh=W74kj2DDiwH4Wp3u04RdkDhyypCxcjZzhIEwUm1e8rI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kqUuDKVyPzc9cuoNwjOrbTa/N7xn2wIABZYIXFzcJELC6wjcKYMH7J4L9qGvFAqFRlBepj8KFvNsuR3yLy9MwX0Ti15+OJKSV0uJCiwJSRUM0FGXzjRYGMVeNfSYIMxhWEvhP4Vz8rNTPty7GAvz/u0AdHs+GnQ9VEZ/XMrGDic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=i5L8fRlQ; arc=none smtp.client-ip=209.85.214.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="i5L8fRlQ"
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2d55d8cd938so87849095ad.1
        for <bpf@vger.kernel.org>; Wed, 30 Sep 2026 12:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790795074; x=1791399874; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Jhya2y811UV5AuuPbTYGgtyQ4U3Mw8uXlwcCn3nTITw=;
        b=i5L8fRlQGbOIVDEKRPCYa6zg05FNqwWp6S5lr9BJQdP40GqtfF1jBXTxnBbq2pRMM7
         mJOz2NGE5quowCZ/oFK+AE8wjd4G9r0KT7r9q+hAuBNVg8wWLuZFNkyGETstntpvoQLG
         y3a2yC9g/Ivhbv1xbEDDQtXHBYsQH4FRPwXsvh0ZZW9eg7oXUDNl2gvSHFW8sX+I34Zm
         1AHvrlfl4OVakhQQPX/1yXPxQc2meb1NJYHyfcJesQ22fskqXPUlIVg5xpISKz4gpCQk
         9W0rQL56bNLEhoxNPqtLmikfBpD/jfYcqMX5+wotB+v8pZo9vPU/dUxXkFcZprAmBfKV
         8hpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790795074; x=1791399874;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Jhya2y811UV5AuuPbTYGgtyQ4U3Mw8uXlwcCn3nTITw=;
        b=0u+IEgQ8ql9ASO6Sl7sM4j9WOXZq/nJFgdnPrLwj0PYi+Swi5y3XsF/Fut8NhlYPYx
         5Po6MutJRBGi+u520zoST3JukfIxdUK8UZIOW257ClPdpB4NHDPw3r4FA9FHOJBtfdi0
         BxFFrLI431aESvQs7cTnhzQQc/v4Jc2e+qxpIU+mEJCQ4cGJRCooskU3i/7Gt6fr1B6H
         31nYMk8rSuJOjBOeWaX7SGENBju7e6BBJH87t3w3s8DV6OmGQkfvvnzuF18gzR4XpHAf
         P8OHczOWPDUJfq+zBCxYuSf6ER3OsTPtZN7o1KxLqXxYNiDzNUoKhN56E11erZC7qWSB
         TIeQ==
X-Forwarded-Encrypted: i=1; AKwUvBxJn4aYKRMgMKMR4e01dHrNuu0BSaG643TnSsOeN4ZmI5A+j8BUhF/xFOYaKmswEcCQRtQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYLhLJV8EwDoZ6NZkWhTstEuUaKRaz9+ymVj3RurUn3nOgrLvNUJ
	UJJzsjXOtbPmyb1nM75uCzoG9eodyKWcVCfxxiKLKJyhycUles68agTQCMWqIR+cioPzwCoYHAJ
	4U6CHfIJXzMjIV9WYIRPsqIwKYg==
X-Received: from plao6.prod.google.com ([2002:a17:903:3006:b0:2e2:c7fc:344f])
 (user=hramamurthy job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:c943:b0:2dd:c053:9c6b with SMTP id d9443c01a7336-2e2e49ce550mr18247455ad.33.1790795073380;
 Wed, 30 Sep 2026 12:04:33 -0700 (PDT)
Date: Wed, 30 Sep 2026 19:04:18 +0000
In-Reply-To: <20260930190428.1130007-1-hramamurthy@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260930190428.1130007-1-hramamurthy@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260930190428.1130007-3-hramamurthy@google.com>
Subject: [PATCH net-next v9 02/12] gve: introduce control plane operations structure
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
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Harshitha Ramamurthy <hramamurthy@google.com>
---
v6:
- plumb through map_db_bar error instead of overwriting it

 drivers/net/ethernet/google/gve/gve.h        | 11 +++++++
 drivers/net/ethernet/google/gve/gve_adminq.c | 21 ++++++++++++
 drivers/net/ethernet/google/gve/gve_adminq.h |  2 ++
 drivers/net/ethernet/google/gve/gve_main.c   | 34 +++++++++++---------
 4 files changed, 52 insertions(+), 16 deletions(-)

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
index 512349c5517f..08d8e49d563e 100644
--- a/drivers/net/ethernet/google/gve/gve_adminq.c
+++ b/drivers/net/ethernet/google/gve/gve_adminq.c
@@ -1637,3 +1637,24 @@ void gve_set_num_queues(struct gve_priv *priv)
 						device_info->default_rx_queues,
 						priv->rx_cfg.num_queues);
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
index a17af755b454..93d3cabb67f1 100644
--- a/drivers/net/ethernet/google/gve/gve_adminq.h
+++ b/drivers/net/ethernet/google/gve/gve_adminq.h
@@ -658,4 +658,6 @@ int gve_adminq_get_ptype_map_dqo(struct gve_priv *priv,
 				 struct gve_ptype_lut *ptype_lut);
 int gve_set_num_ntfy_blks(struct gve_priv *priv);
 void gve_set_num_queues(struct gve_priv *priv);
+int gve_adminq_map_db_bar(struct gve_priv *priv);
+void gve_adminq_unmap_db_bar(struct gve_priv *priv);
 #endif /* _GVE_ADMINQ_H */
diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
index d3882de584e3..d721347e54b4 100644
--- a/drivers/net/ethernet/google/gve/gve_main.c
+++ b/drivers/net/ethernet/google/gve/gve_main.c
@@ -2460,6 +2460,11 @@ static void gve_set_buf_sizes(struct gve_priv *priv)
 		priv->header_buf_size = device_info->header_buf_size;
 }
 
+static const struct gve_ctrl_ops gve_adminq_ops = {
+	.map_db_bar		= gve_adminq_map_db_bar,
+	.unmap_db_bar		= gve_adminq_unmap_db_bar,
+};
+
 static int gve_init_priv(struct gve_priv *priv, bool skip_describe_device)
 {
 	struct gve_device_info *device_info = &priv->device_info;
@@ -2861,7 +2866,6 @@ static int gve_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 {
 	int max_tx_queues, max_rx_queues;
 	struct net_device *dev;
-	__be32 __iomem *db_bar;
 	struct gve_registers __iomem *reg_bar;
 	struct gve_priv *priv;
 	int err;
@@ -2889,13 +2893,6 @@ static int gve_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
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
@@ -2905,7 +2902,7 @@ static int gve_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (!dev) {
 		dev_err(&pdev->dev, "could not allocate netdev\n");
 		err = -ENOMEM;
-		goto abort_with_db_bar;
+		goto abort_with_reg_bar;
 	}
 	SET_NETDEV_DEV(dev, &pdev->dev);
 	pci_set_drvdata(pdev, dev);
@@ -2937,19 +2934,25 @@ static int gve_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
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
+	if (err)
+		goto abort_with_netdev;
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
@@ -2979,12 +2982,12 @@ static int gve_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
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
 
@@ -3000,14 +3003,13 @@ static void gve_remove(struct pci_dev *pdev)
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
2.56.0.rc1.315.gc6ed9934b7-goog

