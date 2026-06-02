Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23E633D5647
	for <bpf@vger.kernel.org>; Tue,  2 Jun 2026 23:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780444752; cv=none; b=tGxoxOCUNK/IzXQXmV3bRy8+j2nfUTId7YnXry8Zw3HvIR90uKRGCrHuplLsUd+dyBwdtuAeffWmdruwr8dAzOEmcNk3IdUIL2p9tt9jA7oZTyCzCbQPQ6eS9PNZJ9WwdGDFf2+S0hArVsbUaIopooXVnCRHF3V5JlT4NNaf1ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780444752; c=relaxed/simple;
	bh=Na0SeIfyOd7yAAbMXxs/OfScfNP6TSwBD6oC5sbAqiE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bAU9CUXLCUNuMeXkK3yjl33DRv+HF4bd8yi62gFga04YBdZSXza7gNc+p9A/qXMYpF5rPe/6OZP0RwF8ockeYEHtDVgB9f1MLoku9Csfup0JvnRjIX+6FWQPs6VgpsJQzzwq/Q1VGNgVSkSmv+6dYEcahRl80xPRkMdNPOIrXbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bZNMPxZD; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bZNMPxZD"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c8531d89e59so76823a12.0
        for <bpf@vger.kernel.org>; Tue, 02 Jun 2026 16:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780444749; x=1781049549; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZyKin3epjmHjB+l3vFExCe2kv3656lDfwhSyk8bL+DU=;
        b=bZNMPxZDX42vvV66Sr7flQLuN3w+h6ImxSmkZOzv8KcCfmLqACGWR81J33/P3jvhiI
         xa6zglQwzSF/IfhqZezSf71mxoja5KIpUvIPdk/sDbKJ9JDtqy7vzrPJyGiMLjCT2bLo
         UyXi/M+a5LStvUOEpS9RCVT216qQhxSYvrFxe1YYU8Zb01g+omiG/AljUQQ2HGArncpz
         qZQQenwbVXQ6r8xhQ/dWtkfv0vLSwbkc5E6vSM9GMX/c3+zJvB6N5qtNYCBgScFlkW5I
         bnH7NfoIhL0ZY49OvQtJJP1FnZ0iZjaUEsPBOMJ8M4GutScSsFTkr1BN9wM2h+MgBdB9
         90hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780444749; x=1781049549;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZyKin3epjmHjB+l3vFExCe2kv3656lDfwhSyk8bL+DU=;
        b=oBD/XnMkyjglaFyEXUoulHuUFBGtAEQ4wXhkp2JioL/nwLrrmx5tecj+AryLIYB8/5
         7FTiqDeRf7hWFroCS01mpTOQamEt4Tr478LbGYmdc3ebNI52WB1takHyVdiWusLbHqz1
         Fx3sG2mIF1aqDB8vOhlzuFMRPfwJto1TkWwBUZi2NgDlHdM/lyJ3nbzea63L08iQ7cGL
         SaESjZNKApMT7maDzcwTjm/V8Thl7WQs1Gc/f4pN2kKVy9xm7MwRzmBvaLJkU0PRq9o3
         OlYrZXvK3oUlFOF54nCQK/GGJE9YFKkVgv8fciPuE3U6j3P2tPRROhxxxiU7WdgJPXl7
         Kx/Q==
X-Forwarded-Encrypted: i=1; AFNElJ/c1xfspADHiiwDXGQaGM+OdMXF7tVu7A+GZehltCPua7wGb6BNdhcC9XOgZvj00gJaWPw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5Lp5GtKOCTTeM51UeP5e7T9nABpHSOUI96/RqGCVzW7E1aUhY
	zt+cpDR6GEXDX9ga2RMUEEU/9jmd+9C4s0TmgRwUOLX4lcXoAa6rCwBHO6cmbETNG+rZEI5k36W
	mmBAuIkG3xvMI2j9GIEW62PkUjw==
X-Received: from pgc4.prod.google.com ([2002:a05:6a02:2f84:b0:c74:497:507e])
 (user=hramamurthy job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:d492:b0:3b4:613f:90b1 with SMTP id adf61e73a8af0-3b498903549mr726413637.16.1780444749011;
 Tue, 02 Jun 2026 16:59:09 -0700 (PDT)
Date: Tue,  2 Jun 2026 23:58:52 +0000
In-Reply-To: <20260602235900.3050782-1-hramamurthy@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260602235900.3050782-1-hramamurthy@google.com>
X-Mailer: git-send-email 2.54.0.1013.g208068f2d8-goog
Message-ID: <20260602235900.3050782-9-hramamurthy@google.com>
Subject: [PATCH net-next v2 08/15] gve: refactor gve_init_priv for reset path
From: Harshitha Ramamurthy <hramamurthy@google.com>
To: netdev@vger.kernel.org
Cc: joshwash@google.com, hramamurthy@google.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org, 
	john.fastabend@gmail.com, sdf@fomichev.me, willemb@google.com, 
	jordanrhee@google.com, jfraker@google.com, nktgrg@google.com, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The driver does not need to renegotiate all properties with
the device on a reset since those should stay constant through
a reset. Hence change gve_init_priv() into a method that only
sets these properties into the priv structure and hence needs
to be only called once during gve_probe().

To achieve this end state of gve_init_priv(), do the following:
- introduce gve_adminq_init() which writes the driver version register
  and allocates the AdminQ and call it in gve_probe()
- move gve_adminq_get_device_properties() into gve_probe()
- introduce gve_setup_device() which deals with device setup logic and
  call it in gve_probe()
- resetting no. of registered pages is moved into gve_register_qpls()
  since that is a QPL specific property.

With these changes, gve_adminq_get_device_properties() and
gve_init_priv() are only called once during gve_probe.
gve_reset_recovery() can now bypass full initialization and call these
targeted setup functions directly.

This prepares the driver to add mailbox mode's control plane
initialization and device properties negotiation in the same place
as is done in AdminQ mode in the upcoming patches when adding the
mailbox ABI.

These changes are only code movement, no functional change.

Reviewed-by: Willem de Bruijn <willemb@google.com>
Reviewed-by: Jordan Rhee <jordanrhee@google.com>
Signed-off-by: Harshitha Ramamurthy <hramamurthy@google.com>
---
 drivers/net/ethernet/google/gve/gve.h        |   2 +
 drivers/net/ethernet/google/gve/gve_adminq.c |  12 +-
 drivers/net/ethernet/google/gve/gve_adminq.h |   2 +-
 drivers/net/ethernet/google/gve/gve_main.c   | 132 +++++++++++--------
 4 files changed, 92 insertions(+), 56 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve.h b/drivers/net/ethernet/google/gve/gve.h
index bd48c3d7a2b2..72588d201e5d 100644
--- a/drivers/net/ethernet/google/gve/gve.h
+++ b/drivers/net/ethernet/google/gve/gve.h
@@ -1252,6 +1252,8 @@ static inline bool gve_is_clock_enabled(struct gve_priv *priv)
 	return priv->nic_ts_report;
 }
 
+void gve_adminq_write_version(u8 __iomem *driver_version_register);
+
 /* gqi napi handler defined in gve_main.c */
 int gve_napi_poll(struct napi_struct *napi, int budget);
 
diff --git a/drivers/net/ethernet/google/gve/gve_adminq.c b/drivers/net/ethernet/google/gve/gve_adminq.c
index 923a5c737258..e7956d2768b6 100644
--- a/drivers/net/ethernet/google/gve/gve_adminq.c
+++ b/drivers/net/ethernet/google/gve/gve_adminq.c
@@ -296,8 +296,10 @@ gve_process_device_options(struct gve_priv *priv,
 	return 0;
 }
 
-int gve_adminq_alloc(struct device *dev, struct gve_priv *priv)
+static int gve_adminq_alloc(struct gve_priv *priv)
 {
+	struct device *dev = &priv->pdev->dev;
+
 	priv->adminq_pool = dma_pool_create("adminq_pool", dev,
 					    GVE_ADMINQ_BUFFER_SIZE, 0, 0);
 	if (unlikely(!priv->adminq_pool))
@@ -353,6 +355,14 @@ int gve_adminq_alloc(struct device *dev, struct gve_priv *priv)
 	return 0;
 }
 
+int gve_adminq_init(struct gve_priv *priv)
+{
+	struct gve_registers __iomem *reg_bar = priv->reg_bar0;
+
+	gve_adminq_write_version(&reg_bar->driver_version);
+	return gve_adminq_alloc(priv);
+}
+
 void gve_adminq_release(struct gve_priv *priv)
 {
 	int i = 0;
diff --git a/drivers/net/ethernet/google/gve/gve_adminq.h b/drivers/net/ethernet/google/gve/gve_adminq.h
index ac3ef9fd8d24..d07e9c6f279d 100644
--- a/drivers/net/ethernet/google/gve/gve_adminq.h
+++ b/drivers/net/ethernet/google/gve/gve_adminq.h
@@ -619,7 +619,7 @@ union gve_adminq_command {
 
 static_assert(sizeof(union gve_adminq_command) == 64);
 
-int gve_adminq_alloc(struct device *dev, struct gve_priv *priv);
+int gve_adminq_init(struct gve_priv *priv);
 void gve_adminq_free(struct gve_priv *priv);
 void gve_adminq_release(struct gve_priv *priv);
 int gve_adminq_describe_device(struct gve_priv *priv);
diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
index d693caed7e3d..746ff69a28dd 100644
--- a/drivers/net/ethernet/google/gve/gve_main.c
+++ b/drivers/net/ethernet/google/gve/gve_main.c
@@ -797,6 +797,8 @@ static int gve_register_qpls(struct gve_priv *priv)
 	int err;
 	int i;
 
+	priv->num_registered_pages = 0;
+
 	num_tx_qpls = gve_num_tx_qpls(&priv->tx_cfg, gve_is_qpl(priv));
 	num_rx_qpls = gve_num_rx_qpls(&priv->rx_cfg, gve_is_qpl(priv));
 
@@ -2414,6 +2416,33 @@ static void gve_set_buf_sizes(struct gve_priv *priv)
 		priv->header_buf_size = device_info->header_buf_size;
 }
 
+static int gve_setup_device(struct gve_priv *priv)
+{
+	int err;
+
+	priv->xsk_pools = bitmap_zalloc(priv->rx_cfg.max_queues, GFP_KERNEL);
+	if (!priv->xsk_pools) {
+		err = -ENOMEM;
+		goto err;
+	}
+
+	gve_set_netdev_xdp_features(priv);
+	if (!gve_is_gqi(priv))
+		priv->dev->xdp_metadata_ops = &gve_xdp_metadata_ops;
+
+	err = gve_setup_device_resources(priv);
+	if (err)
+		goto err_free_xsk_bitmap;
+
+	return 0;
+
+err_free_xsk_bitmap:
+	bitmap_free(priv->xsk_pools);
+	priv->xsk_pools = NULL;
+err:
+	return err;
+}
+
 static const struct gve_ctrl_ops gve_adminq_ops = {
 	.map_db_bar		= gve_adminq_map_db_bar,
 	.unmap_db_bar		= gve_adminq_unmap_db_bar,
@@ -2421,36 +2450,18 @@ static const struct gve_ctrl_ops gve_adminq_ops = {
 	.set_num_ntfy_blks	= gve_adminq_set_num_ntfy_blks,
 };
 
-static int gve_init_priv(struct gve_priv *priv, bool skip_describe_device)
+static int gve_init_priv(struct gve_priv *priv)
 {
 	struct gve_device_info *device_info = &priv->device_info;
 	int err;
 
-	/* Set up the adminq */
-	err = gve_adminq_alloc(&priv->pdev->dev, priv);
-	if (err) {
-		dev_err(&priv->pdev->dev,
-			"Failed to alloc admin queue: err=%d\n", err);
-		return err;
-	}
-
-	priv->num_registered_pages = 0;
-
-	if (skip_describe_device)
-		goto setup_device;
-
-	device_info->queue_format = GVE_QUEUE_FORMAT_UNSPECIFIED;
-	err = gve_adminq_get_device_properties(priv);
-	if (err)
-		goto err;
-
 	priv->queue_format = priv->device_info.queue_format;
 
 	err = priv->ctrl_ops->set_num_ntfy_blks(priv);
 	if (err) {
 		dev_err(&priv->pdev->dev,
 			"Could not setup notify blocks: err=%d\n", err);
-		goto err;
+		return err;
 	}
 
 	priv->ctrl_ops->set_num_queues(priv);
@@ -2473,10 +2484,8 @@ static int gve_init_priv(struct gve_priv *priv, bool skip_describe_device)
 		netif_set_tso_max_size(priv->dev, GVE_DQO_TX_MAX);
 	}
 
-	if (gve_set_mtu(priv)) {
-		err = -EINVAL;
-		goto err;
-	}
+	if (gve_set_mtu(priv))
+		return -EINVAL;
 
 	priv->num_event_counters = device_info->num_event_counters;
 
@@ -2501,30 +2510,7 @@ static int gve_init_priv(struct gve_priv *priv, bool skip_describe_device)
 	priv->ts_config.tx_type = HWTSTAMP_TX_OFF;
 	priv->ts_config.rx_filter = HWTSTAMP_FILTER_NONE;
 	priv->nic_timestamp_supported = device_info->nic_timestamp_supported;
-
-setup_device:
-	priv->xsk_pools = bitmap_zalloc(priv->rx_cfg.max_queues, GFP_KERNEL);
-	if (!priv->xsk_pools) {
-		err = -ENOMEM;
-		goto err;
-	}
-
-	gve_set_netdev_xdp_features(priv);
-	if (!gve_is_gqi(priv))
-		priv->dev->xdp_metadata_ops = &gve_xdp_metadata_ops;
-
-	err = gve_setup_device_resources(priv);
-	if (err)
-		goto err_free_xsk_bitmap;
-
 	return 0;
-
-err_free_xsk_bitmap:
-	bitmap_free(priv->xsk_pools);
-	priv->xsk_pools = NULL;
-err:
-	gve_adminq_free(priv);
-	return err;
 }
 
 static void gve_teardown_priv_resources(struct gve_priv *priv)
@@ -2554,15 +2540,29 @@ static int gve_reset_recovery(struct gve_priv *priv, bool was_up)
 {
 	int err;
 
-	err = gve_init_priv(priv, true);
-	if (err)
+	err = gve_adminq_init(priv);
+	if (err) {
+		dev_err(&priv->pdev->dev,
+			"Failed to alloc admin queue: err=%d\n", err);
 		goto err;
+	}
+
+	err = gve_setup_device(priv);
+	if (err)
+		goto err_free_adminq;
 	if (was_up) {
 		err = gve_open(priv->dev);
 		if (err)
-			goto err;
+			goto err_free_device;
 	}
 	return 0;
+
+err_free_device:
+	gve_teardown_device_resources(priv);
+	bitmap_free(priv->xsk_pools);
+	priv->xsk_pools = NULL;
+err_free_adminq:
+	gve_adminq_free(priv);
 err:
 	dev_err(&priv->pdev->dev, "Reset failed! !!! DISABLING ALL QUEUES !!!\n");
 	gve_turndown(priv);
@@ -2605,7 +2605,7 @@ int gve_reset(struct gve_priv *priv, bool attempt_teardown)
 	return err;
 }
 
-static void gve_write_version(u8 __iomem *driver_version_register)
+void gve_adminq_write_version(u8 __iomem *driver_version_register)
 {
 	const char *c = gve_version_prefix;
 
@@ -2838,7 +2838,6 @@ static int gve_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		goto abort_with_pci_region;
 	}
 
-	gve_write_version(&reg_bar->driver_version);
 	/* Get max queues to alloc etherdev */
 	max_tx_queues = ioread32be(&reg_bar->max_tx_queues);
 	max_rx_queues = ioread32be(&reg_bar->max_rx_queues);
@@ -2885,13 +2884,28 @@ static int gve_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	priv->rx_cfg.packet_buffer_size = GVE_DEFAULT_RX_BUFFER_SIZE;
 	priv->max_rx_buffer_size = GVE_DEFAULT_RX_BUFFER_SIZE;
 
+	err = gve_adminq_init(priv);
+	if (err) {
+		dev_err(&priv->pdev->dev,
+			"Failed to alloc admin queue: err=%d\n", err);
+		goto abort_with_netdev;
+	}
+
+	priv->device_info.queue_format = GVE_QUEUE_FORMAT_UNSPECIFIED;
+	err = gve_adminq_get_device_properties(priv);
+	if (err) {
+		dev_err(&priv->pdev->dev,
+			"Could not get device information: err=%d\n", err);
+		goto abort_with_adminq;
+	}
+
 	/* Set adminq ctrl ops */
 	priv->ctrl_ops = &gve_adminq_ops;
 
 	err = priv->ctrl_ops->map_db_bar(priv);
 	if (err) {
 		err = -ENOMEM;
-		goto abort_with_netdev;
+		goto abort_with_adminq;
 	}
 
 	gve_set_probe_in_progress(priv);
@@ -2906,10 +2920,17 @@ static int gve_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	priv->tx_cfg.max_queues = max_tx_queues;
 	priv->rx_cfg.max_queues = max_rx_queues;
 
-	err = gve_init_priv(priv, false);
+	err = gve_init_priv(priv);
 	if (err)
 		goto abort_with_wq;
 
+	err = gve_setup_device(priv);
+	if (err) {
+		dev_err(&priv->pdev->dev,
+			"Could not setup device: err=%d\n", err);
+		goto abort_with_wq;
+	}
+
 	if (!gve_is_gqi(priv) && !gve_is_qpl(priv))
 		dev->netmem_tx = NETMEM_TX_DMA;
 
@@ -2932,6 +2953,9 @@ static int gve_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 abort_with_unmap_db_bar:
 	priv->ctrl_ops->unmap_db_bar(priv);
 
+abort_with_adminq:
+	gve_adminq_free(priv);
+
 abort_with_netdev:
 	free_netdev(dev);
 
-- 
2.54.0.1013.g208068f2d8-goog

