Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97D2A42D757
	for <bpf@vger.kernel.org>; Thu,  3 Sep 2026 21:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788472576; cv=none; b=neb4HNEUPoXJzvL7tKOPIWQBHmV9lLqBfElPGwMsqLMLbFYdn4BvHht4X6IyV5Mc1YnaD61/cm/yF0sOvmG5/r0wDvk4asymwQ1hOR5mQWTjxF1yA9bN9+jl4XR6UmP3LldwQbJNVFjbqyI2hmTeb1/G6xWPxueTwoD1BX+qG98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788472576; c=relaxed/simple;
	bh=3BXSCyAgHxEVmiJXvMK8WsCv8i09MSRVlOz/tGLyuw8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OfHDe43Q8uQmOUxYT1dETb9dewZSdGYBwnsdF3AiZtZ2nu0JtXVwcBbKAPx0sDgS0Om9Cb+vWAqDO+a2U+OiddD5YoDhwo3skk8KvPX6HHbzUD/k4JAtctuWOvzNMJifmOWMAEtjsxcU+DkNs7Ju7M0EAzQIIdzcCbeFIAk/IF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LiPU8NKN; arc=none smtp.client-ip=209.85.210.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LiPU8NKN"
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-84a251c2e3eso1968623b3a.1
        for <bpf@vger.kernel.org>; Thu, 03 Sep 2026 14:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788472573; x=1789077373; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wrOjqdn2k/Sh6hbeKx1aZs9Spx0aoJ4gt+SAmTBWj+A=;
        b=LiPU8NKNyPL8cpdwOZe11oUfZPWO9QspADrFxFz1bIUYRTMC7vOhIlIsqsyHXMvvIG
         e9jGQG4v3vpbwriggFAFKPX68uOWfea986JlFVMbyew99WoXCZfLWa2ocwhhqeViGK7K
         wqYqjrgS/cVypLFiqftudPtGvZ5o/Oc0EUocGRCMe6XmnAKOAd2b7ZUPzk0b0otXkKdx
         hvgR4j+m5p8Jpx0G6vzSyextNM6icdO0HnlyXSfXzaTTwjPI2mTl+vguq1p5LmLWfBsG
         LQ0C0il/ED3phBA8SzVyfrCCmKyvhkGEXRNUhqlgZ5g40TJl3LxXyyWZoQrez9R8+14c
         fqqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788472573; x=1789077373;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wrOjqdn2k/Sh6hbeKx1aZs9Spx0aoJ4gt+SAmTBWj+A=;
        b=cg8ClTNB/GEIDFuqk50Ow2c4+WifQAqoaqFmODIzkJ0YQjOEvnIAihHH+cUzbgrOyG
         o/4XJgUmSSiqRWRMWdEBN2r98GH0EQGcGlxjZZhGNu4fZWRbhavesfbfWCiQ6vqoiYSS
         aT0A/KTmhR3nlo4wfaZkFLIpBL6CIXD2QYjKgChrndnGTY3FgCxPtpmJU0xWDordvmpl
         1iLFEvzprDoSepkBZ3h4435wXiDDhP5ZpobXPP8UFiwGmL77Ef5iXKewX0+0euFA1LyC
         Bf9RoPpR/WdJKf5qyJJdFsMHW8KgPm/B3wnWK2Q+eac03cJC5L9GSQDCwqx9DZ+OtYDB
         zOKw==
X-Forwarded-Encrypted: i=1; AKwUvBw36DAhf3GDx+WWjG3ewGW/TZp5BCBQfnGYoTGZKU5IZ7rFHLFjGVsmPnWs13dQENSZ9bk=@vger.kernel.org
X-Gm-Message-State: AFuF++mU8HoHqGBKpsEtUXNS0OD9MXZl/nHpkUbsXMmMN8Lg4EnvV9J+
	2Tlw9uuCMuk63ds6gqh6LKc8XK0ptuvqbuxA7WrhjJh+7I96DdfdEmkUn+Hp4yr3fuKtBlWQ6hq
	SZvtXHuaktrPvKCu0oyTYZjID2A==
X-Received: from pgwc1.prod.google.com ([2002:a65:66c1:0:b0:cbe:408a:5051])
 (user=hramamurthy job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:4d8f:b0:3d3:ad6e:9ce0 with SMTP id adf61e73a8af0-3da3c0a5a04mr724443637.14.1788472572598;
 Thu, 03 Sep 2026 14:56:12 -0700 (PDT)
Date: Thu,  3 Sep 2026 21:55:59 +0000
In-Reply-To: <20260903215606.31633-1-hramamurthy@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260903215606.31633-1-hramamurthy@google.com>
X-Mailer: git-send-email 2.55.0.979.g7e5102b832-goog
Message-ID: <20260903215606.31633-6-hramamurthy@google.com>
Subject: [PATCH net-next v5 05/12] gve: refactor gve_init_priv for reset path
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

The driver does not need to renegotiate all properties with
the device on a reset since those should stay constant through
a reset. Hence change gve_init_priv() into a method that only
sets these properties into the priv structure and hence needs
to be only called once during gve_probe().

To achieve this end state of gve_init_priv(), do the following:
- introduce gve_adminq_init() which writes the driver version register
  and allocates the AdminQ and call it in gve_probe()
- call gve_adminq_get_device_properties() into gve_probe() to learn device
  properties
- introduce gve_setup_device() which deals with device setup logic and
  call it in gve_probe()
- resetting no. of registered pages is moved into gve_setup_device() since
  that needs to be reset every time queues are re-created.

With these changes, gve_adminq_get_device_properties() and
gve_init_priv() are only called once during gve_probe.
gve_reset_recovery() now calls targeted setup functions directly.

This prepares the driver to add mailbox mode's control plane
initialization and device properties negotiation in the same place
as is done in AdminQ mode in the upcoming patches when adding the
mailbox ABI.

These changes are only code movement, no functional change.

Reviewed-by: Willem de Bruijn <willemb@google.com>
Reviewed-by: Jordan Rhee <jordanrhee@google.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Harshitha Ramamurthy <hramamurthy@google.com>
---
v3:
 - gve_reset_recovery also calls verify driver compatibility
 - don't free device resources if gve_open() fails in the reset path
 - move resetting no. of registered pages to gve_setup_device()

 drivers/net/ethernet/google/gve/gve.h        |   2 +
 drivers/net/ethernet/google/gve/gve_adminq.c |  12 +-
 drivers/net/ethernet/google/gve/gve_adminq.h |   2 +-
 drivers/net/ethernet/google/gve/gve_main.c   | 146 ++++++++++---------
 4 files changed, 95 insertions(+), 67 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve.h b/drivers/net/ethernet/google/gve/gve.h
index 1bc5e32b6618..48cc8a6be186 100644
--- a/drivers/net/ethernet/google/gve/gve.h
+++ b/drivers/net/ethernet/google/gve/gve.h
@@ -1253,6 +1253,8 @@ static inline bool gve_is_clock_enabled(struct gve_priv *priv)
 	return priv->nic_ts_report;
 }
 
+void gve_adminq_write_version(u8 __iomem *driver_version_register);
+
 /* gqi napi handler defined in gve_main.c */
 int gve_napi_poll(struct napi_struct *napi, int budget);
 
diff --git a/drivers/net/ethernet/google/gve/gve_adminq.c b/drivers/net/ethernet/google/gve/gve_adminq.c
index f420a8e1dd3d..a62cb7a921d0 100644
--- a/drivers/net/ethernet/google/gve/gve_adminq.c
+++ b/drivers/net/ethernet/google/gve/gve_adminq.c
@@ -298,8 +298,10 @@ gve_process_device_options(struct gve_priv *priv,
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
@@ -355,6 +357,14 @@ int gve_adminq_alloc(struct device *dev, struct gve_priv *priv)
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
index 2ab68c822e22..78eee3b5cb7f 100644
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
index 08859611a96e..16ce55c6d74f 100644
--- a/drivers/net/ethernet/google/gve/gve_main.c
+++ b/drivers/net/ethernet/google/gve/gve_main.c
@@ -2415,6 +2415,35 @@ static void gve_set_buf_sizes(struct gve_priv *priv)
 		priv->header_buf_size = device_info->header_buf_size;
 }
 
+static int gve_setup_device(struct gve_priv *priv)
+{
+	int err;
+
+	priv->num_registered_pages = 0;
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
@@ -2422,47 +2451,18 @@ static const struct gve_ctrl_ops gve_adminq_ops = {
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
-	err = gve_adminq_verify_driver_compatibility(priv);
-	if (err) {
-		dev_err(&priv->pdev->dev,
-			"Could not verify driver compatibility: err=%d\n", err);
-		goto err;
-	}
-
-	priv->num_registered_pages = 0;
-
-	if (skip_describe_device)
-		goto setup_device;
-
-	device_info->queue_format = GVE_QUEUE_FORMAT_UNSPECIFIED;
-	/* Get the initial information we need from the device */
-	err = gve_adminq_describe_device(priv);
-	if (err) {
-		dev_err(&priv->pdev->dev,
-			"Could not get device information: err=%d\n", err);
-		goto err;
-	}
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
@@ -2485,10 +2485,8 @@ static int gve_init_priv(struct gve_priv *priv, bool skip_describe_device)
 		netif_set_tso_max_size(priv->dev, GVE_DQO_TX_MAX);
 	}
 
-	if (gve_set_mtu(priv)) {
-		err = -EINVAL;
-		goto err;
-	}
+	if (gve_set_mtu(priv))
+		return -EINVAL;
 
 	priv->num_event_counters = device_info->num_event_counters;
 
@@ -2513,30 +2511,7 @@ static int gve_init_priv(struct gve_priv *priv, bool skip_describe_device)
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
@@ -2566,15 +2541,32 @@ static int gve_reset_recovery(struct gve_priv *priv, bool was_up)
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
+	err = gve_adminq_verify_driver_compatibility(priv);
+	if (err) {
+		dev_err(&priv->pdev->dev,
+			"Could not verify driver compatibility: err=%d\n", err);
+		goto err_free_adminq;
+	}
+
+	err = gve_setup_device(priv);
+	if (err)
+		goto err_free_adminq;
 	if (was_up) {
 		err = gve_open(priv->dev);
 		if (err)
-			goto err;
+			return err;
 	}
 	return 0;
+
+err_free_adminq:
+	gve_adminq_free(priv);
 err:
 	dev_err(&priv->pdev->dev, "Reset failed! !!! DISABLING ALL QUEUES !!!\n");
 	gve_turndown(priv);
@@ -2617,7 +2609,7 @@ int gve_reset(struct gve_priv *priv, bool attempt_teardown)
 	return err;
 }
 
-static void gve_write_version(u8 __iomem *driver_version_register)
+void gve_adminq_write_version(u8 __iomem *driver_version_register)
 {
 	const char *c = gve_version_prefix;
 
@@ -2850,7 +2842,6 @@ static int gve_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		goto abort_with_pci_region;
 	}
 
-	gve_write_version(&reg_bar->driver_version);
 	/* Get max queues to alloc etherdev */
 	max_tx_queues = ioread32be(&reg_bar->max_tx_queues);
 	max_rx_queues = ioread32be(&reg_bar->max_rx_queues);
@@ -2897,13 +2888,28 @@ static int gve_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
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
@@ -2918,10 +2924,17 @@ static int gve_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
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
 
@@ -2944,6 +2957,9 @@ static int gve_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 abort_with_unmap_db_bar:
 	priv->ctrl_ops->unmap_db_bar(priv);
 
+abort_with_adminq:
+	gve_adminq_free(priv);
+
 abort_with_netdev:
 	free_netdev(dev);
 
-- 
2.55.0.979.g7e5102b832-goog

