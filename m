Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FDF83D669D
	for <bpf@vger.kernel.org>; Fri, 14 Aug 2026 02:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786673651; cv=none; b=t4h/V0HQXLyoxXYkgAPZb7v1TVrEY3+SNBz89o4PKemE5udk+GlTjS7Fw6rYsfGQ6PsrVl52Zj67H0Y3vTFog31P/iQbnAcBj6+wpKdegUEuTVTKn++Rr9zKQKDiwaT4ZjHG0a5YN8ixALxvbFRjzJUQsZjKG4j+8eGkgO+9rkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786673651; c=relaxed/simple;
	bh=fR1+yOn1X/Oxt6Op0vFhWWNj9Hn06o6mXazJgaV86tI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=aWSx1vWZpUTK+F3m+LAxiM/jdRxaA4UP3ugkf88BlKQPMW5q4ETetuHwOuNQM3jKDfAruDPO9wOSJWTuMYtRmlMCdqgy9I4p/9lhE4LtGcWRMWzxCXUMwcnbh677TPHoGBZ1PLwNOr0OIwMZftHAlDPh8R6jHSeZqBmgLmw9nfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=STM93Zzy; arc=none smtp.client-ip=209.85.215.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="STM93Zzy"
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cbedfa3898aso337468a12.3
        for <bpf@vger.kernel.org>; Thu, 13 Aug 2026 19:14:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786673650; x=1787278450; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0mmSqbuVweBWGbqmxEm8QoJgEKbkKxRiioKgLKo7m1I=;
        b=STM93ZzynYOy9kE/FmX+DLLdMCTJQFsfNK9ywWqCgaixtSthbxOklmiS54EaZDjxVY
         gsC0JKHdSSaDyR+RnY2QvBRgfH6hNXaJLvg/IZxxiLW6rQ2TH61DHB8rIlhRWvozOpsP
         ZhVSofWC/CkeI54g9gwzGJnNBXm9Mo9PC3urQjBZLLD62iXC75bAr0LdPj8btU9bEUrM
         JPvLrI3z4ecLEUV37jcYoRXmE8sRWfwiGPjiBHj/7c1E4UpxOTnr4dQqmKC2atImqxrH
         qVMzCicYqqx3ZWBBGUKJjmyg8OCwtwyPSzl8cWo8yPB3zNGlJ0Zz+nQ54eRYDxp3lvZ4
         753A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786673650; x=1787278450;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0mmSqbuVweBWGbqmxEm8QoJgEKbkKxRiioKgLKo7m1I=;
        b=rI/jmuMVwKfsCPlywhaCraU1n3kW45CDAQFznY0N59pr7d2o30Owglk7SW6k1PdVVB
         wrdeR3YsFC4irTSom4tyPZ2rx6Lb4bgqg+/yBBTx4B+fRoBzIESbD1ltunI3ZI+GgNuI
         XMF3dZcH2ZVAnd1GOE7h/aBQJ4s/fgaJjA9jxtto3nITCZnrkpSYb5+C6FeJrONyMWIP
         cz0mySxluOrdZF+JNEhOItPCMG6HyW0Sv48Et0+gYDjkr3oVLSpoluW4Gs19J0qEazgd
         PQPksY7ONP/BlvQo2fSu3ZisX9LsLt6+AKiXfxNfpVVhEw2icfIYypZQq6gvRkojrKkw
         kGbA==
X-Forwarded-Encrypted: i=1; AHgh+Rp8jdA4k57jUqB4dkxDeZZQA6AKBDLmNBZTA2o4uYUzJjyL2lGt7wOC15SudzKhqescK4o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcE4RUz7+7GRK+UTweiaHs+Y7UFA39figQjCI+FU7QDSbMx9OX
	fZf8Lbi7EYxoBPFfpQ7JN5mCFkRDhqwirDTEi7z8EIpkyAAw3JBXbPHJbkEtgcAyg2KAhdXWxop
	0xet3A7OUE13TKmDJIJbg1p83LA==
X-Received: from pgmu38.prod.google.com ([2002:a63:2366:0:b0:c99:90dc:7b3f])
 (user=hramamurthy job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6300:2289:b0:3cb:e8b4:f03b with SMTP id adf61e73a8af0-3cc71ca5ad5mr2577505637.17.1786673649389;
 Thu, 13 Aug 2026 19:14:09 -0700 (PDT)
Date: Fri, 14 Aug 2026 02:13:52 +0000
In-Reply-To: <20260814021406.3044324-1-hramamurthy@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260814021406.3044324-1-hramamurthy@google.com>
X-Mailer: git-send-email 2.55.0.691.gc56d675ccc-goog
Message-ID: <20260814021406.3044324-3-hramamurthy@google.com>
Subject: [PATCH net-next v4 02/15] gve: refactor initialization with helper functions
From: Harshitha Ramamurthy <hramamurthy@google.com>
To: netdev@vger.kernel.org
Cc: joshwash@google.com, hramamurthy@google.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org, 
	john.fastabend@gmail.com, sdf@fomichev.me, jordanrhee@google.com, 
	willemb@google.com, nktgrg@google.com, maolson@google.com, thostet@google.com, 
	jacob.e.keller@intel.com, przemyslaw.kitszel@intel.com, debarghyak@google.com, 
	kees@kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org
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
v4:
- move the new functions to gve_adminq.c since that will be their final
  home in the following patches (Przemek Kitszel)
v2:
- ensure to call verify driver compatibility in reset path

 drivers/net/ethernet/google/gve/gve_adminq.c | 49 ++++++++++++++---
 drivers/net/ethernet/google/gve/gve_adminq.h |  2 +
 drivers/net/ethernet/google/gve/gve_main.c   | 58 +++++++-------------
 3 files changed, 62 insertions(+), 47 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve_adminq.c b/drivers/net/ethernet/google/gve/gve_adminq.c
index 70ffed8b52c3..fe0dedfb25d7 100644
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
@@ -1600,3 +1592,44 @@ int gve_adminq_query_rss_config(struct gve_priv *priv, struct ethtool_rxfh_param
 	dma_pool_free(priv->adminq_pool, descriptor, descriptor_bus);
 	return err;
 }
+
+int gve_set_num_ntfy_blks(struct gve_priv *priv)
+{
+	int num_ntfy;
+
+	num_ntfy = pci_msix_vec_count(priv->pdev);
+	if (num_ntfy <= 0) {
+		dev_err(&priv->pdev->dev,
+			"could not count MSI-x vectors: err=%d\n", num_ntfy);
+		return num_ntfy;
+	} else if (num_ntfy < GVE_MIN_MSIX) {
+		dev_err(&priv->pdev->dev, "gve needs at least %d MSI-x vectors, but only has %d\n",
+			GVE_MIN_MSIX, num_ntfy);
+		return -EINVAL;
+	}
+
+	/* gvnic has one Notification Block per MSI-x vector, except for the
+	 * management vector
+	 */
+	priv->num_ntfy_blks = (num_ntfy - 1) & ~0x1;
+	priv->mgmt_msix_idx = priv->num_ntfy_blks;
+
+	return 0;
+}
+
+void gve_set_num_queues(struct gve_priv *priv)
+{
+	priv->tx_cfg.max_queues =
+		min_t(int, priv->tx_cfg.max_queues, priv->num_ntfy_blks / 2);
+	priv->rx_cfg.max_queues =
+		min_t(int, priv->rx_cfg.max_queues, priv->num_ntfy_blks / 2);
+
+	priv->tx_cfg.num_queues = priv->tx_cfg.max_queues;
+	priv->rx_cfg.num_queues = priv->rx_cfg.max_queues;
+	if (priv->default_num_queues > 0) {
+		priv->tx_cfg.num_queues = min_t(int, priv->default_num_queues,
+						priv->tx_cfg.num_queues);
+		priv->rx_cfg.num_queues = min_t(int, priv->default_num_queues,
+						priv->rx_cfg.num_queues);
+	}
+}
diff --git a/drivers/net/ethernet/google/gve/gve_adminq.h b/drivers/net/ethernet/google/gve/gve_adminq.h
index 8e80f36116ec..82b52424a63f 100644
--- a/drivers/net/ethernet/google/gve/gve_adminq.h
+++ b/drivers/net/ethernet/google/gve/gve_adminq.h
@@ -656,5 +656,7 @@ int gve_adminq_report_nic_ts(struct gve_priv *priv,
 struct gve_ptype_lut;
 int gve_adminq_get_ptype_map_dqo(struct gve_priv *priv,
 				 struct gve_ptype_lut *ptype_lut);
+int gve_set_num_ntfy_blks(struct gve_priv *priv);
+void gve_set_num_queues(struct gve_priv *priv);
 
 #endif /* _GVE_ADMINQ_H */
diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
index 30bf6df4ebc5..37e6205e2eef 100644
--- a/drivers/net/ethernet/google/gve/gve_main.c
+++ b/drivers/net/ethernet/google/gve/gve_main.c
@@ -2400,7 +2400,6 @@ static const struct xdp_metadata_ops gve_xdp_metadata_ops = {
 
 static int gve_init_priv(struct gve_priv *priv, bool skip_describe_device)
 {
-	int num_ntfy;
 	int err;
 
 	/* Set up the adminq */
@@ -2431,57 +2430,38 @@ static int gve_init_priv(struct gve_priv *priv, bool skip_describe_device)
 			"Could not get device information: err=%d\n", err);
 		goto err;
 	}
-	priv->dev->mtu = priv->dev->max_mtu;
-	num_ntfy = pci_msix_vec_count(priv->pdev);
-	if (num_ntfy <= 0) {
+
+	err = gve_set_num_ntfy_blks(priv);
+	if (err) {
 		dev_err(&priv->pdev->dev,
-			"could not count MSI-x vectors: err=%d\n", num_ntfy);
-		err = num_ntfy;
+			"Could not setup notify blocks: err=%d\n", err);
 		goto err;
-	} else if (num_ntfy < GVE_MIN_MSIX) {
-		dev_err(&priv->pdev->dev, "gve needs at least %d MSI-x vectors, but only has %d\n",
-			GVE_MIN_MSIX, num_ntfy);
-		err = -EINVAL;
-		goto err;
-	}
-
-	/* Big TCP is only supported on DQO */
-	if (!gve_is_gqi(priv))
-		netif_set_tso_max_size(priv->dev, GVE_DQO_TX_MAX);
-
-	priv->rx_copybreak = GVE_DEFAULT_RX_COPYBREAK;
-	/* gvnic has one Notification Block per MSI-x vector, except for the
-	 * management vector
-	 */
-	priv->num_ntfy_blks = (num_ntfy - 1) & ~0x1;
-	priv->mgmt_msix_idx = priv->num_ntfy_blks;
-	priv->numa_node = dev_to_node(&priv->pdev->dev);
-
-	priv->tx_cfg.max_queues =
-		min_t(int, priv->tx_cfg.max_queues, priv->num_ntfy_blks / 2);
-	priv->rx_cfg.max_queues =
-		min_t(int, priv->rx_cfg.max_queues, priv->num_ntfy_blks / 2);
-
-	priv->tx_cfg.num_queues = priv->tx_cfg.max_queues;
-	priv->rx_cfg.num_queues = priv->rx_cfg.max_queues;
-	if (priv->default_num_queues > 0) {
-		priv->tx_cfg.num_queues = min_t(int, priv->default_num_queues,
-						priv->tx_cfg.num_queues);
-		priv->rx_cfg.num_queues = min_t(int, priv->default_num_queues,
-						priv->rx_cfg.num_queues);
 	}
-	priv->tx_cfg.num_xdp_queues = 0;
 
+	gve_set_num_queues(priv);
 	dev_info(&priv->pdev->dev, "TX queues %d, RX queues %d\n",
 		 priv->tx_cfg.num_queues, priv->rx_cfg.num_queues);
 	dev_info(&priv->pdev->dev, "Max TX queues %d, Max RX queues %d\n",
 		 priv->tx_cfg.max_queues, priv->rx_cfg.max_queues);
 
-	if (!gve_is_gqi(priv)) {
+	if (gve_is_dqo(priv)) {
+		/* DQO supports HW-GRO and UDP_GSO */
+		u64 additional_features = NETIF_F_GRO_HW | NETIF_F_GSO_UDP_L4;
+
+		priv->dev->hw_features |= additional_features;
+		priv->dev->features |= additional_features;
+
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
2.55.0.691.gc56d675ccc-goog

