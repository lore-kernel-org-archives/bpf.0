Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED2D33CBE7A
	for <bpf@vger.kernel.org>; Tue,  2 Jun 2026 23:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780444748; cv=none; b=Wnkcf+JqMDUemYJ0VG31pjjziV//3om0AyoeGRHuIhbI1hZI5lg0e5M6Tc89leVxtRC0otM1GRubiCUoZvnsl2ka2CbCE9X9Mu8ur79bKuczrfGXlaopSpuv97quq+VS0Yhxs4sNliNqj574teT4huClwJPUdh6s0iXY4QE4uI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780444748; c=relaxed/simple;
	bh=fH1rldMVm/p0+7buqgj8QdnCbb2w0Q4Q4kYREg9P/Mc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZVi0Z5u052Olh8Fqh9G8YBGi/5Ly7/MK3tU5Wn54TFp4LqlWk0tk18z6ztMymr4OYYgLmRxzoaD8E8l4+dmkJ/bJaqoLi2+HUyv4ZSffMOG2LQSk/cCDvdJbGM1yLOxl7+HR1TqS6HqWO/IiaekS+UwUfGcfGdNLLVRW69TVBK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LtI34trX; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LtI34trX"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-36d992fa39eso4039426a91.3
        for <bpf@vger.kernel.org>; Tue, 02 Jun 2026 16:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780444744; x=1781049544; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=JTHN+ncLuFZ47q8BiVAGO1PaS6eMNaA/XSXGliZHi5s=;
        b=LtI34trXlPV4kiZ0uNYFFTn8/OJD6xfGxcQ3FHUNlzxqTEq3fkl321mBheZSQemp4U
         8deV3hwZza7cZ9hfiuXUbOx5fW1obDI/Wb9kR3zfTR38sJD8+P6BZo/B/vdFt/92iGWy
         R8wkiD9HupaGQRwJW0IPN1f2dZE4sQ57CDBrse2tNmqpriW7Omy2cQKZNAZYEUmC4dAU
         P8nF2DyPQhz4xV07C/VV37MitHsZW/CK4X8r3vya6OfTbBLscSlxPAOlbKtQwrvc9vAm
         eiit3wk89r7iDH66Ygx8kZ3eSn4uuOz0Vzns3jQRhnlLXvTmA/da2C717HA4rdHhTR3H
         mJSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780444744; x=1781049544;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JTHN+ncLuFZ47q8BiVAGO1PaS6eMNaA/XSXGliZHi5s=;
        b=HEmbaG7m09XOjo9VZaHwlpoUORo4LLn3YQeRC7JxZ74C0MjweQd2tkmCh8MG5Jpo7k
         BmPmAStX3XkyCTTqhQ99XUd6HLJf9oPqMe3+GQfQTI/xuJ74d5fufLwyZg65FUCxfGAB
         2Wr1XnLZa5lR35tobYTMYKhZp6Z4KBEsix1AvJVDeSHfi3E12E+vs6zODr5Y0nrUvluD
         I3wfnlhZTvQb+WMfxxPjNICKIEV4kDImwRvsSSV+TBE59j0C2HTtvzKtdJFZx/4xZpwO
         A5WHcMNKLpBb6cCw2yrggXEisq2jXZZSnRw1Znk3+6SP4IZO6xG4QDvwA9t9R4mQV8wm
         DVHA==
X-Forwarded-Encrypted: i=1; AFNElJ8uo1b+0LsYcLsZ5Up5Q9Y8FmU/YcVsb5/YlVl+NbBCalFMMrGNwu9TmnKoTHzWM6ec45U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjaLg40aZhVVmeUwNwS7jRrU/S8WZ5DLaZq2sFsLiEcNpUwFer
	k9ZEr/Y4zEQjhsm7RWmlmPe6x4SNSXv7He1+PPBdIuXcF5b14VC0AR2aDXbdRbl7DQF9yDVD2GD
	T41C5k60J95hXxgRPc6xSWRfyQg==
X-Received: from pjtz23.prod.google.com ([2002:a17:90a:cb17:b0:368:bb57:bcb7])
 (user=hramamurthy job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:5345:b0:36d:635a:ac1b with SMTP id 98e67ed59e1d1-36e34292d44mr918795a91.22.1780444743712;
 Tue, 02 Jun 2026 16:59:03 -0700 (PDT)
Date: Tue,  2 Jun 2026 23:58:46 +0000
In-Reply-To: <20260602235900.3050782-1-hramamurthy@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260602235900.3050782-1-hramamurthy@google.com>
X-Mailer: git-send-email 2.54.0.1013.g208068f2d8-goog
Message-ID: <20260602235900.3050782-3-hramamurthy@google.com>
Subject: [PATCH net-next v2 02/15] gve: refactor initialization with helper functions
From: Harshitha Ramamurthy <hramamurthy@google.com>
To: netdev@vger.kernel.org
Cc: joshwash@google.com, hramamurthy@google.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org, 
	john.fastabend@gmail.com, sdf@fomichev.me, willemb@google.com, 
	jordanrhee@google.com, jfraker@google.com, nktgrg@google.com, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

In the interest of commonizing code, refactor gve_probe()
and gve_init_priv() with a few helper functions that can
be expanded and utilized in upcoming patches that add the
mailbox ABI to the driver. The helper functions are:

- gve_set_num_ntfy_blks()
- gve_set_num_queues()

Reorder code to combine lines that accomplish a similar objective
like setting defaults. Move setting HW-GRO and UDP GSO support out
of an Adminq method into gve_init_priv().

These changes are just code movement, no functional change.

Reviewed-by: Willem de Bruijn <willemb@google.com>
Reviewed-by: Jordan Rhee <jordanrhee@google.com>
Signed-off-by: Harshitha Ramamurthy <hramamurthy@google.com>
---
 drivers/net/ethernet/google/gve/gve_adminq.c |   8 --
 drivers/net/ethernet/google/gve/gve_main.c   | 108 +++++++++++--------
 2 files changed, 65 insertions(+), 51 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve_adminq.c b/drivers/net/ethernet/google/gve/gve_adminq.c
index 70ffed8b52c3..dfeabddfb396 100644
--- a/drivers/net/ethernet/google/gve/gve_adminq.c
+++ b/drivers/net/ethernet/google/gve/gve_adminq.c
@@ -1117,14 +1117,6 @@ int gve_adminq_describe_device(struct gve_priv *priv)
 
 	gve_set_default_rss_sizes(priv);
 
-	/* DQO supports HW-GRO and UDP_GSO */
-	if (gve_is_dqo(priv)) {
-		u64 additional_features = NETIF_F_GRO_HW | NETIF_F_GSO_UDP_L4;
-
-		priv->dev->hw_features |= additional_features;
-		priv->dev->features |= additional_features;
-	}
-
 	priv->max_registered_pages =
 				be64_to_cpu(descriptor->max_registered_pages);
 	mtu = be16_to_cpu(descriptor->mtu);
diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
index 30bf6df4ebc5..b9542ef36b29 100644
--- a/drivers/net/ethernet/google/gve/gve_main.c
+++ b/drivers/net/ethernet/google/gve/gve_main.c
@@ -2398,65 +2398,32 @@ static const struct xdp_metadata_ops gve_xdp_metadata_ops = {
 	.xmo_rx_timestamp	= gve_xdp_rx_timestamp,
 };
 
-static int gve_init_priv(struct gve_priv *priv, bool skip_describe_device)
+static int gve_set_num_ntfy_blks(struct gve_priv *priv)
 {
 	int num_ntfy;
-	int err;
-
-	/* Set up the adminq */
-	err = gve_adminq_alloc(&priv->pdev->dev, priv);
-	if (err) {
-		dev_err(&priv->pdev->dev,
-			"Failed to alloc admin queue: err=%d\n", err);
-		return err;
-	}
-
-	err = gve_verify_driver_compatibility(priv);
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
 
-	priv->queue_format = GVE_QUEUE_FORMAT_UNSPECIFIED;
-	/* Get the initial information we need from the device */
-	err = gve_adminq_describe_device(priv);
-	if (err) {
-		dev_err(&priv->pdev->dev,
-			"Could not get device information: err=%d\n", err);
-		goto err;
-	}
-	priv->dev->mtu = priv->dev->max_mtu;
 	num_ntfy = pci_msix_vec_count(priv->pdev);
 	if (num_ntfy <= 0) {
 		dev_err(&priv->pdev->dev,
 			"could not count MSI-x vectors: err=%d\n", num_ntfy);
-		err = num_ntfy;
-		goto err;
+		return num_ntfy;
 	} else if (num_ntfy < GVE_MIN_MSIX) {
 		dev_err(&priv->pdev->dev, "gve needs at least %d MSI-x vectors, but only has %d\n",
 			GVE_MIN_MSIX, num_ntfy);
-		err = -EINVAL;
-		goto err;
+		return -EINVAL;
 	}
 
-	/* Big TCP is only supported on DQO */
-	if (!gve_is_gqi(priv))
-		netif_set_tso_max_size(priv->dev, GVE_DQO_TX_MAX);
-
-	priv->rx_copybreak = GVE_DEFAULT_RX_COPYBREAK;
 	/* gvnic has one Notification Block per MSI-x vector, except for the
 	 * management vector
 	 */
 	priv->num_ntfy_blks = (num_ntfy - 1) & ~0x1;
 	priv->mgmt_msix_idx = priv->num_ntfy_blks;
-	priv->numa_node = dev_to_node(&priv->pdev->dev);
 
+	return 0;
+}
+
+static void gve_set_num_queues(struct gve_priv *priv)
+{
 	priv->tx_cfg.max_queues =
 		min_t(int, priv->tx_cfg.max_queues, priv->num_ntfy_blks / 2);
 	priv->rx_cfg.max_queues =
@@ -2470,18 +2437,73 @@ static int gve_init_priv(struct gve_priv *priv, bool skip_describe_device)
 		priv->rx_cfg.num_queues = min_t(int, priv->default_num_queues,
 						priv->rx_cfg.num_queues);
 	}
-	priv->tx_cfg.num_xdp_queues = 0;
 
 	dev_info(&priv->pdev->dev, "TX queues %d, RX queues %d\n",
 		 priv->tx_cfg.num_queues, priv->rx_cfg.num_queues);
 	dev_info(&priv->pdev->dev, "Max TX queues %d, Max RX queues %d\n",
 		 priv->tx_cfg.max_queues, priv->rx_cfg.max_queues);
+}
+
+static int gve_init_priv(struct gve_priv *priv, bool skip_describe_device)
+{
+	int err;
+
+	/* Set up the adminq */
+	err = gve_adminq_alloc(&priv->pdev->dev, priv);
+	if (err) {
+		dev_err(&priv->pdev->dev,
+			"Failed to alloc admin queue: err=%d\n", err);
+		return err;
+	}
+
+	priv->num_registered_pages = 0;
+
+	if (skip_describe_device)
+		goto setup_device;
+
+	err = gve_verify_driver_compatibility(priv);
+	if (err) {
+		dev_err(&priv->pdev->dev,
+			"Could not verify driver compatibility: err=%d\n", err);
+		goto err;
+	}
+
+	/* Get the initial information we need from the device */
+	priv->queue_format = GVE_QUEUE_FORMAT_UNSPECIFIED;
+	err = gve_adminq_describe_device(priv);
+	if (err) {
+		dev_err(&priv->pdev->dev,
+			"Could not get device information: err=%d\n", err);
+		goto err;
+	}
+
+	err = gve_set_num_ntfy_blks(priv);
+	if (err) {
+		dev_err(&priv->pdev->dev,
+			"Could not setup notify blocks: err=%d\n", err);
+		goto err;
+	}
+
+	gve_set_num_queues(priv);
+
+	if (gve_is_dqo(priv)) {
+		/* DQO supports HW-GRO and UDP_GSO */
+		u64 additional_features = NETIF_F_GRO_HW | NETIF_F_GSO_UDP_L4;
+
+		priv->dev->hw_features |= additional_features;
+		priv->dev->features |= additional_features;
 
-	if (!gve_is_gqi(priv)) {
 		priv->tx_coalesce_usecs = GVE_TX_IRQ_RATELIMIT_US_DQO;
 		priv->rx_coalesce_usecs = GVE_RX_IRQ_RATELIMIT_US_DQO;
+
+		/* Big TCP is only supported on DQO */
+		netif_set_tso_max_size(priv->dev, GVE_DQO_TX_MAX);
 	}
 
+	priv->dev->mtu = priv->dev->max_mtu;
+	priv->numa_node = dev_to_node(&priv->pdev->dev);
+	priv->tx_cfg.num_xdp_queues = 0;
+	priv->rx_copybreak = GVE_DEFAULT_RX_COPYBREAK;
 	priv->ts_config.tx_type = HWTSTAMP_TX_OFF;
 	priv->ts_config.rx_filter = HWTSTAMP_FILTER_NONE;
 
-- 
2.54.0.1013.g208068f2d8-goog

