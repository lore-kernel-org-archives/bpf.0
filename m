Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB1883DC87B
	for <bpf@vger.kernel.org>; Mon,  1 Jun 2026 17:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780336484; cv=none; b=hA1A8goSrv0lYK9hEyYociZh608QYXs+iOyVzS+Mf9mlKGFo8h4xO2VPmcCKMv/m748VNoPGQX/g9XbKmQ8dAH9f/jyv9hiCQ1VwITsyydo0K+O6OXBI5Tw1psuayjhwfbZBFPujtLYMzp0khZCnmjR82nkGpzUgmhGTFdd/mCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780336484; c=relaxed/simple;
	bh=eQf9Z2+gvvZJpHRahhH/7VApHRBp1Qthj+l+tQIKWUE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=q1aNU8vi/B/zSwNb+UOSewX2UV94Rldj6qiWGcPKcbUCc77SHZeGREAa2eoX42nbEWmMdcMYS1d0Ff6Dvpkl16j5lubOhAY6jcsRHcyiZ6H5b18fYnCyEfHx0rCOuw3TwMiYKEXDudZSLfR8QzSJFoKGIfhQrGe5pa07mQjjx1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=luAGXxCh; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="luAGXxCh"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c85c530ddebso334371a12.1
        for <bpf@vger.kernel.org>; Mon, 01 Jun 2026 10:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780336481; x=1780941281; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=2gOYcjuJLEF0yTyJYYDBD/FirVLlUoDpnNHInCa8H2U=;
        b=luAGXxCh8HRjWamtgG8mjcljawVfDzFrjCeBmU4OdxcK5lURS93OS5Y+e3aV1HsBr9
         ZnlTyxe9PS5FS07IO22mKyxAi2hzHF5DgtrC+r8qNlVsiMWr7f37dXsnuL5PCPPS084I
         m2sfbtRefnMwdun/EkRxJU57oCNdF/U7m7DeSnFqPB3xTaA585fIbOEHPZvXLvg7Now0
         Kv5Twotpx8XYPORE3bFu8WnCyxHHuDz9B57ZACc/lJ+9WQaHNyECJV2uF5xOKz9tUzuk
         gYjo8Za2g1fkphyK9XeVFy9EPwXwNS2cSCQe4VkK0yU5n1Rmu0UVA57XHKIDAliPAP7i
         HejA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780336481; x=1780941281;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2gOYcjuJLEF0yTyJYYDBD/FirVLlUoDpnNHInCa8H2U=;
        b=W37brrnQKka8CJrysNlH38/3dZ1jKEdGz9fMkX1twGMiEaaqSkYK4aF4sMl5y9MQoW
         K270Pzd8J9vTQmN+tSNKYy/YQHs/mEaAl+kDpG/QA1uKdoW/Fn/mFOqfus6S1URRN7uJ
         zZTHYIWU7eNLD7n2ZfLTnGvF63j2hhpV8c/YJiPqfSUX6DJEdxMsd77fH7JdRU7HUzqn
         mw669kAsDz8ymnTiELB973xcBMODCJ+ZQ8YHwSV3UxEtFaulz+uKB2ICS1zuOa1Id5wt
         3vxzN9d++tcugd3V27uF9gMcwnXOfBJ69KPRPhEInilEiVK0VCSdZtFiI+lRgxZ8xF46
         vMwg==
X-Forwarded-Encrypted: i=1; AFNElJ/vf3+gxc5eANaRlwFFstkcaPrtr+jOm9BQrAp+Mqrw+t4btToFJIRdPxQlT7b/WKQdvu4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx32QOzZabixqTJIQoKWP8MP+cM6prNvmPx7yOltZ/Dti3nRjUO
	Cr4bQTGpw4AZfZfd55vY9WofNwfMY42F50a+xyis5fWr9dYdHziPSPxRD/XJWpNIWQZcHpyEMxn
	Rrc++oHecCNvWFddSq0RL+PxPjQ==
X-Received: from pgbfp14.prod.google.com ([2002:a05:6a02:2cee:b0:c7b:fdce:6626])
 (user=hramamurthy job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:ce44:b0:39b:fbb2:5e46 with SMTP id adf61e73a8af0-3b427fbf046mr12596515637.40.1780336480936;
 Mon, 01 Jun 2026 10:54:40 -0700 (PDT)
Date: Mon,  1 Jun 2026 17:54:24 +0000
In-Reply-To: <20260601175437.3767283-1-hramamurthy@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260601175437.3767283-1-hramamurthy@google.com>
X-Mailer: git-send-email 2.54.0.1013.g208068f2d8-goog
Message-ID: <20260601175437.3767283-3-hramamurthy@google.com>
Subject: [PATCH net-next 02/15] gve: refactor initialization with helper functions
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
index d8d47a0c19b4..f3227bb58ced 100644
--- a/drivers/net/ethernet/google/gve/gve_adminq.c
+++ b/drivers/net/ethernet/google/gve/gve_adminq.c
@@ -1142,14 +1142,6 @@ int gve_adminq_describe_device(struct gve_priv *priv)
 
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
2.54.0.669.g59709faab0-goog

