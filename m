Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92D0E3D47D3
	for <bpf@vger.kernel.org>; Tue,  2 Jun 2026 23:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780444751; cv=none; b=C8onEubMgGzlqlol9Jk92+pAtkZQhUKe7S4tTsxVBwrNr5JrzK8pS6FmrHvw60FQQOYOrjOwnXTPfWtE24nVNXuueJCM3RAiB3ROcMv6Z2qBYLc7QG0z8A9Ys54TUEOXA6y+KA5x06e9U3eN/kBOl8uNG1TicX5qsk4y5dkE0eM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780444751; c=relaxed/simple;
	bh=Jid2mZV9AdafsjyRc+X2ZCHCA2HF8RZcuwocaQdhGfQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=SFi2+Wvb9Laxi8370ipJnhegEGNcpQEM7EjlL0WlP3nuFGa1Fiey9WznMjBIotMWvg7Htl+LtHd3fK5Xe89hUhFYgUTb81T2er+UH34PgyEnWXgRJJWn0MQ8ab4Clc9SitBmOXj5Tghm+bBs3eQQ3E1ZwPY92q+tdbrgCa+LhAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UgHguelk; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UgHguelk"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2beff6b6e74so73859445ad.1
        for <bpf@vger.kernel.org>; Tue, 02 Jun 2026 16:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780444749; x=1781049549; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=xpIUEsUWU8etm6zUAiNt4A561F4DqethgQmhV6MgVco=;
        b=UgHguelkeiBBANTRRSqG5UcBkJSaVqKbKZdUoun3xMEyULxCFhefskYfHwIsFuWRC+
         V9bY2ZmWunXoH7Dl9MAZHZrazxTrc87aYR5G1N0r7I6CT3wL5cWfJf5xt83sv3N+NzOO
         7PoYj7LnP41oTh+XBqoNRR6MRG5DhZGtSKkvlx01QLO5HGMzel7DvlhKSbMzKFVgFMJ1
         wqH43kwB/laea6v1nbMeezNLgNwdjDfRsPe7pJ02sGAWJq7ewjwQ6qAj5mn7VUDTa/eT
         Qfo3ioQZ7SBgTZm7bqzmG03IiAyVuweMrwjnrQs0qUHq6Lv8BqXLeLEeLHQHeAzq4igr
         4K0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780444749; x=1781049549;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xpIUEsUWU8etm6zUAiNt4A561F4DqethgQmhV6MgVco=;
        b=EQPB8vA6Gz3DAS6sjmT153dL2LkK7aJOywK6VxMma3kNa4pVKHj6pGhv06RoySRkEH
         F135a5MWa3qcaKgSh7+CZ35rwKvcELTdsO4MXM/KlZJ/AhQ5o0iKV//mHj0GePLCyeiE
         Qkc5zPr2ZXZThIpvZwrcU3zno37q8gT4aFzjKSNPD1KUtLu22fUtzH1UFCIMflxxmisO
         O2miuNae6jcRO8m68qVCtMe/PSqU3bccaIOY3juPozM8CA1665Afe9HqKvN7B/aTSFlv
         FvyTVXRoefXpUZWbljyfWdbUKle8TeELJQf81lagwo4gE5XwTnZUSVfGObFaWg3+xorB
         jUjA==
X-Forwarded-Encrypted: i=1; AFNElJ9ugKOdNbmNWbwKa8/wKGJqmjEuOtCTevo/s4ixYaV8hpAP5qUSH1FnWJZvWCruPjuFOi4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMwQvWMvzviyKfXK1P4CRJndddK2QKkIyVNdIJxVGA0ovmoRJb
	G0UOOTHS8v7L+CYaNVgL2hMhkTZpujGh/d/Rm+vRn9ldBI6ZFF9+mgJaUZPujoWw9BRkG7TQuNX
	mSQgwmpLnAfv70EqorESIzaqwZA==
X-Received: from plao13.prod.google.com ([2002:a17:903:300d:b0:2bd:c925:e1dc])
 (user=hramamurthy job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:bd1:b0:2c1:20fe:9d5a with SMTP id d9443c01a7336-2c1644cd036mr6232295ad.35.1780444748116;
 Tue, 02 Jun 2026 16:59:08 -0700 (PDT)
Date: Tue,  2 Jun 2026 23:58:51 +0000
In-Reply-To: <20260602235900.3050782-1-hramamurthy@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260602235900.3050782-1-hramamurthy@google.com>
X-Mailer: git-send-email 2.54.0.1013.g208068f2d8-goog
Message-ID: <20260602235900.3050782-8-hramamurthy@google.com>
Subject: [PATCH net-next v2 07/15] gve: introduce ctrl ops to set vectors and Qs
From: Harshitha Ramamurthy <hramamurthy@google.com>
To: netdev@vger.kernel.org
Cc: joshwash@google.com, hramamurthy@google.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org, 
	john.fastabend@gmail.com, sdf@fomichev.me, willemb@google.com, 
	jordanrhee@google.com, jfraker@google.com, nktgrg@google.com, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Introduce following ctrl ops for Adminq mode. This change does
not introduce any functional change, just movement of code into
ops.

- set_num_queues to set maximum and default TX/RX queues in the
  alloc structures used in the initialization flow.
- set_num_ntfy_blks op to set number of vectors(ntfy_blks) in the
  initialization flow.

Reviewed-by: Willem de Bruijn <willemb@google.com>
Reviewed-by: Jordan Rhee <jordanrhee@google.com>
Signed-off-by: Harshitha Ramamurthy <hramamurthy@google.com>
---
 drivers/net/ethernet/google/gve/gve.h        |  6 ++
 drivers/net/ethernet/google/gve/gve_adminq.c | 45 ++++++++++++++
 drivers/net/ethernet/google/gve/gve_adminq.h |  2 +
 drivers/net/ethernet/google/gve/gve_main.c   | 64 +++-----------------
 4 files changed, 63 insertions(+), 54 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve.h b/drivers/net/ethernet/google/gve/gve.h
index c1e118241d2b..bd48c3d7a2b2 100644
--- a/drivers/net/ethernet/google/gve/gve.h
+++ b/drivers/net/ethernet/google/gve/gve.h
@@ -828,10 +828,16 @@ struct gve_device_info {
  * struct gve_ctrl_ops - Control plane operations structure
  * @map_db_bar: Maps the doorbell BAR for the device and store in @priv.
  * @unmap_db_bar: Unmaps the doorbell BAR previously mapped by @map_db_bar.
+ * @set_num_queues: Sets default and max TX/RX queues into allocation
+ *                  structures stored in @priv to be used during initialization.
+ * @set_num_ntfy_blks: Sets no. of vectors into @priv to be used during
+ *                     initialization.
  */
 struct gve_ctrl_ops {
 	int (*map_db_bar)(struct gve_priv *priv);
 	void (*unmap_db_bar)(struct gve_priv *priv);
+	void (*set_num_queues)(struct gve_priv *priv);
+	int (*set_num_ntfy_blks)(struct gve_priv *priv);
 };
 
 struct gve_priv {
diff --git a/drivers/net/ethernet/google/gve/gve_adminq.c b/drivers/net/ethernet/google/gve/gve_adminq.c
index 4617489d8714..923a5c737258 100644
--- a/drivers/net/ethernet/google/gve/gve_adminq.c
+++ b/drivers/net/ethernet/google/gve/gve_adminq.c
@@ -1666,3 +1666,48 @@ void gve_adminq_unmap_db_bar(struct gve_priv *priv)
 
 	pci_iounmap(pdev, priv->db_bar2);
 }
+
+int gve_adminq_set_num_ntfy_blks(struct gve_priv *priv)
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
+void gve_adminq_set_num_queues(struct gve_priv *priv)
+{
+	struct gve_device_info *device_info = &priv->device_info;
+
+	priv->tx_cfg.max_queues =
+		min_t(int, priv->tx_cfg.max_queues, priv->num_ntfy_blks / 2);
+	priv->rx_cfg.max_queues =
+		min_t(int, priv->rx_cfg.max_queues, priv->num_ntfy_blks / 2);
+
+	priv->tx_cfg.num_queues = priv->tx_cfg.max_queues;
+	priv->rx_cfg.num_queues = priv->rx_cfg.max_queues;
+	if (device_info->default_tx_queues > 0)
+		priv->tx_cfg.num_queues = min_t(int,
+						device_info->default_tx_queues,
+						priv->tx_cfg.num_queues);
+	if (device_info->default_rx_queues > 0)
+		priv->rx_cfg.num_queues = min_t(int,
+						device_info->default_rx_queues,
+						priv->rx_cfg.num_queues);
+}
diff --git a/drivers/net/ethernet/google/gve/gve_adminq.h b/drivers/net/ethernet/google/gve/gve_adminq.h
index bc76976eb00f..ac3ef9fd8d24 100644
--- a/drivers/net/ethernet/google/gve/gve_adminq.h
+++ b/drivers/net/ethernet/google/gve/gve_adminq.h
@@ -657,5 +657,7 @@ int gve_adminq_get_ptype_map_dqo(struct gve_priv *priv,
 				 struct gve_ptype_lut *ptype_lut);
 int gve_adminq_map_db_bar(struct gve_priv *priv);
 void gve_adminq_unmap_db_bar(struct gve_priv *priv);
+int gve_adminq_set_num_ntfy_blks(struct gve_priv *priv);
+void gve_adminq_set_num_queues(struct gve_priv *priv);
 
 #endif /* _GVE_ADMINQ_H */
diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
index 51dd4f9b3022..d693caed7e3d 100644
--- a/drivers/net/ethernet/google/gve/gve_main.c
+++ b/drivers/net/ethernet/google/gve/gve_main.c
@@ -2354,56 +2354,6 @@ static const struct xdp_metadata_ops gve_xdp_metadata_ops = {
 	.xmo_rx_timestamp	= gve_xdp_rx_timestamp,
 };
 
-static int gve_set_num_ntfy_blks(struct gve_priv *priv)
-{
-	int num_ntfy;
-
-	num_ntfy = pci_msix_vec_count(priv->pdev);
-	if (num_ntfy <= 0) {
-		dev_err(&priv->pdev->dev,
-			"could not count MSI-x vectors: err=%d\n", num_ntfy);
-		return num_ntfy;
-	} else if (num_ntfy < GVE_MIN_MSIX) {
-		dev_err(&priv->pdev->dev, "gve needs at least %d MSI-x vectors, but only has %d\n",
-			GVE_MIN_MSIX, num_ntfy);
-		return -EINVAL;
-	}
-
-	/* gvnic has one Notification Block per MSI-x vector, except for the
-	 * management vector
-	 */
-	priv->num_ntfy_blks = (num_ntfy - 1) & ~0x1;
-	priv->mgmt_msix_idx = priv->num_ntfy_blks;
-
-	return 0;
-}
-
-static void gve_set_num_queues(struct gve_priv *priv)
-{
-	struct gve_device_info *device_info = &priv->device_info;
-
-	priv->tx_cfg.max_queues =
-		min_t(int, priv->tx_cfg.max_queues, priv->num_ntfy_blks / 2);
-	priv->rx_cfg.max_queues =
-		min_t(int, priv->rx_cfg.max_queues, priv->num_ntfy_blks / 2);
-
-	priv->tx_cfg.num_queues = priv->tx_cfg.max_queues;
-	priv->rx_cfg.num_queues = priv->rx_cfg.max_queues;
-	if (device_info->default_tx_queues > 0)
-		priv->tx_cfg.num_queues = min_t(int,
-						device_info->default_tx_queues,
-						priv->tx_cfg.num_queues);
-	if (device_info->default_rx_queues > 0)
-		priv->rx_cfg.num_queues = min_t(int,
-						device_info->default_rx_queues,
-						priv->rx_cfg.num_queues);
-
-	dev_info(&priv->pdev->dev, "TX queues %d, RX queues %d\n",
-		 priv->tx_cfg.num_queues, priv->rx_cfg.num_queues);
-	dev_info(&priv->pdev->dev, "Max TX queues %d, Max RX queues %d\n",
-		 priv->tx_cfg.max_queues, priv->rx_cfg.max_queues);
-}
-
 static void gve_set_desc_cnt(struct gve_priv *priv)
 {
 	struct gve_device_info *device_info = &priv->device_info;
@@ -2465,8 +2415,10 @@ static void gve_set_buf_sizes(struct gve_priv *priv)
 }
 
 static const struct gve_ctrl_ops gve_adminq_ops = {
-	.map_db_bar	 = gve_adminq_map_db_bar,
-	.unmap_db_bar	 = gve_adminq_unmap_db_bar,
+	.map_db_bar		= gve_adminq_map_db_bar,
+	.unmap_db_bar		= gve_adminq_unmap_db_bar,
+	.set_num_queues		= gve_adminq_set_num_queues,
+	.set_num_ntfy_blks	= gve_adminq_set_num_ntfy_blks,
 };
 
 static int gve_init_priv(struct gve_priv *priv, bool skip_describe_device)
@@ -2494,14 +2446,18 @@ static int gve_init_priv(struct gve_priv *priv, bool skip_describe_device)
 
 	priv->queue_format = priv->device_info.queue_format;
 
-	err = gve_set_num_ntfy_blks(priv);
+	err = priv->ctrl_ops->set_num_ntfy_blks(priv);
 	if (err) {
 		dev_err(&priv->pdev->dev,
 			"Could not setup notify blocks: err=%d\n", err);
 		goto err;
 	}
 
-	gve_set_num_queues(priv);
+	priv->ctrl_ops->set_num_queues(priv);
+	dev_info(&priv->pdev->dev, "TX queues %d, RX queues %d\n",
+		 priv->tx_cfg.num_queues, priv->rx_cfg.num_queues);
+	dev_info(&priv->pdev->dev, "Max TX queues %d, Max RX queues %d\n",
+		 priv->tx_cfg.max_queues, priv->rx_cfg.max_queues);
 
 	if (gve_is_dqo(priv)) {
 		/* DQO supports HW-GRO and UDP_GSO */
-- 
2.54.0.1013.g208068f2d8-goog

