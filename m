Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6305B375F76
	for <bpf@vger.kernel.org>; Mon,  1 Jun 2026 17:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780336485; cv=none; b=G0vOIhD7HoEuh8oF9P8tvbZDFDyX6phD87tivTNKfK66XzlTvf4w8WwbZoSyhB0Mke/zVL+yY6zMJSsNEQkooE0Ho6UMNvznBXJ1eEKN06mtQFo6PEt0RNH6FC4LiMYrePzccjKWpdqrXxbC5o2PNkiVLBlo85DNxV2+z1kDEng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780336485; c=relaxed/simple;
	bh=NVn9LwPDnlsQON3swgwliR2ZNWfHvu5p5Ixmos9M6tk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=AuH4UHDbpvnwqGhR6FS2tDXfdyMl8pU/JSVr3HGMgsUgKObwM9LLOU593twrPclweBUuNNYmcQ/WNbSZ8OMEZa2fqYWqSjxWZnPFCvTlXCzJ0vvi+sRzqbGjxJ4lYb/tMP/ESbmFai82uMMRlr27AksKObeSaRT7VU+r1gAzWdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tgn1iM4o; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tgn1iM4o"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2bf335549b8so38435725ad.1
        for <bpf@vger.kernel.org>; Mon, 01 Jun 2026 10:54:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780336483; x=1780941283; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8gUNOhawh414/8060FOqpH+YpRhOk1KgnFcLIhcQnxw=;
        b=tgn1iM4oJsKFAvOB3iNYxQhphmfcWEfQC8hxlrkbZzAa3qr3z7tsUATqZbGR+ChrDU
         vqXZO3n6XWvxjG1RjQUC1wM9tEEfrX6dJcU4HbzL2gtA6vGkqtiPomL/8dyFa74j9Nvd
         DXGunYOgJg5UuT2X0IoYzrdOSQbmPbcAWP7S1KWJTLqIPPIcXArU1AeqphUIf085X778
         5bBpy50Y0vSlfcfPsxwSYUpCNx/KPrq9GQubkfNoyLi2rDyrS8ttVMVjPX/mPPCyYANE
         4MiWKgY0e/jPJzwPclM5zPY7YXvF61/8cUVyxE6aQzsNjl8HvRlqeHHW4CVcKBfDgFwO
         ZUMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780336483; x=1780941283;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8gUNOhawh414/8060FOqpH+YpRhOk1KgnFcLIhcQnxw=;
        b=mS2FYZhZibmm0hTRYwnFGHTmV6CsKKD0uHnUOzVSxQ3W5BqG9Z8PG8yv/e+NAWPWs5
         HQHMoH3UPRIJ2D3tHlfzIxiec5OlSEM3Qon8GI6uSN+8Cf7L/ATzlTz6z/2ys+K7QTPn
         qeLT3I5+CZHW8E7ZtRUGHdVwOU6/Dwh24sQvVWAX8b1/iEOzzZmHEJvD9ldXh9AKXYDT
         hwk5+ftDdW1J3mx/BZyqrEP1dh6joQGAUfRZBZL6SRBtwAbZ9+Lb5otiI8Oo0WzavQpr
         gbvfrwmhGNl3vd3AdqJ+olE6nKdpSrAOnuuHFE8qlJuCIF4u8hVFJYafWgA5pj6TzSad
         Va7g==
X-Forwarded-Encrypted: i=1; AFNElJ/VABC43XIqh8gLr1sUaVAO45K7BMPVYtAs98RpZRmYjZMdbcil2Yl1n5yk4pw9ym/Tw4c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw83x/TheWBNGdI2rJu2hmEpUUck5wnk2whJ0wtrBOnxjgmjmZK
	oYlLSD/+sUDUmy0hWSh6ussAzdIxsAki/aDVGdPMlklzTQJQrmNN/m/xxfKqv0LMe50HWTgJ8NP
	4r/8X/Jg5/T/FbmKY11lSsGrR/A==
X-Received: from pllh10.prod.google.com ([2002:a17:902:748a:b0:2be:ff74:e5e5])
 (user=hramamurthy job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:2389:b0:2b4:656b:aeb0 with SMTP id d9443c01a7336-2bf3685af15mr148148335ad.35.1780336482581;
 Mon, 01 Jun 2026 10:54:42 -0700 (PDT)
Date: Mon,  1 Jun 2026 17:54:26 +0000
In-Reply-To: <20260601175437.3767283-1-hramamurthy@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260601175437.3767283-1-hramamurthy@google.com>
X-Mailer: git-send-email 2.54.0.1013.g208068f2d8-goog
Message-ID: <20260601175437.3767283-5-hramamurthy@google.com>
Subject: [PATCH net-next 04/15] gve: add a few helper functions to set device properties
From: Harshitha Ramamurthy <hramamurthy@google.com>
To: netdev@vger.kernel.org
Cc: joshwash@google.com, hramamurthy@google.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org, 
	john.fastabend@gmail.com, sdf@fomichev.me, willemb@google.com, 
	jordanrhee@google.com, jfraker@google.com, nktgrg@google.com, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For the mailbox ABI, device properties will come from a different
source compared to the AdminQ mode. To accommodate the new source
when the mailbox ABI is added, add a few helper functions to set a
few device properties. Those functions are:

- gve_set_queue_properties() to set no. of pages for QPL mode and
  number of queues in general
- gve_set_mtu()
- gve_set_mac()

This is just code movement, no functional change.

Reviewed-by: Willem de Bruijn <willemb@google.com>
Reviewed-by: Jordan Rhee <jordanrhee@google.com>
Signed-off-by: Harshitha Ramamurthy <hramamurthy@google.com>
---
 drivers/net/ethernet/google/gve/gve_adminq.c | 38 +++-------------
 drivers/net/ethernet/google/gve/gve_adminq.h |  6 +++
 drivers/net/ethernet/google/gve/gve_main.c   | 46 ++++++++++++++++++++
 3 files changed, 59 insertions(+), 31 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve_adminq.c b/drivers/net/ethernet/google/gve/gve_adminq.c
index c102f707e284..ac546a245ef3 100644
--- a/drivers/net/ethernet/google/gve/gve_adminq.c
+++ b/drivers/net/ethernet/google/gve/gve_adminq.c
@@ -945,19 +945,6 @@ int gve_adminq_destroy_rx_queues(struct gve_priv *priv, u32 num_queues)
 	return err;
 }
 
-static void gve_set_default_desc_cnt(struct gve_priv *priv,
-			const struct gve_device_descriptor *descriptor)
-{
-	priv->tx_desc_cnt = be16_to_cpu(descriptor->tx_queue_entries);
-	priv->rx_desc_cnt = be16_to_cpu(descriptor->rx_queue_entries);
-
-	/* set default ranges */
-	priv->max_tx_desc_cnt = priv->tx_desc_cnt;
-	priv->max_rx_desc_cnt = priv->rx_desc_cnt;
-	priv->min_tx_desc_cnt = priv->tx_desc_cnt;
-	priv->min_rx_desc_cnt = priv->rx_desc_cnt;
-}
-
 static void gve_set_default_rss_sizes(struct gve_priv *priv)
 {
 	if (!gve_is_gqi(priv)) {
@@ -1074,8 +1061,6 @@ int gve_adminq_describe_device(struct gve_priv *priv)
 	union gve_adminq_command cmd;
 	dma_addr_t descriptor_bus;
 	int err = 0;
-	u8 *mac;
-	u16 mtu;
 
 	memset(&cmd, 0, sizeof(cmd));
 	descriptor = dma_pool_alloc(priv->adminq_pool, GFP_KERNEL,
@@ -1137,26 +1122,17 @@ int gve_adminq_describe_device(struct gve_priv *priv)
 			 "Driver is running with GQI QPL queue format.\n");
 	}
 
-	/* set default descriptor counts */
-	gve_set_default_desc_cnt(priv, descriptor);
-
 	gve_set_default_rss_sizes(priv);
 
-	priv->max_registered_pages =
-				be64_to_cpu(descriptor->max_registered_pages);
-	mtu = be16_to_cpu(descriptor->mtu);
-	if (mtu < ETH_MIN_MTU) {
-		dev_err(&priv->pdev->dev, "MTU %d below minimum MTU\n", mtu);
-		err = -EINVAL;
+	err = gve_set_mtu(priv, descriptor);
+	if (err)
 		goto free_device_descriptor;
-	}
-	priv->dev->max_mtu = mtu;
+
 	priv->num_event_counters = be16_to_cpu(descriptor->counters);
-	eth_hw_addr_set(priv->dev, descriptor->mac);
-	mac = descriptor->mac;
-	dev_info(&priv->pdev->dev, "MAC addr: %pM\n", mac);
-	priv->tx_pages_per_qpl = be16_to_cpu(descriptor->tx_pages_per_qpl);
-	priv->default_num_queues = be16_to_cpu(descriptor->default_num_queues);
+
+	gve_set_mac(priv, descriptor);
+
+	gve_set_queue_properties(priv, descriptor);
 
 	gve_enable_supported_features(priv, supported_features_mask,
 				      dev_op_jumbo_frames, dev_op_dqo_qpl,
diff --git a/drivers/net/ethernet/google/gve/gve_adminq.h b/drivers/net/ethernet/google/gve/gve_adminq.h
index 107c21b7b047..53ac1a28b26a 100644
--- a/drivers/net/ethernet/google/gve/gve_adminq.h
+++ b/drivers/net/ethernet/google/gve/gve_adminq.h
@@ -655,5 +655,11 @@ int gve_adminq_report_nic_ts(struct gve_priv *priv,
 struct gve_ptype_lut;
 int gve_adminq_get_ptype_map_dqo(struct gve_priv *priv,
 				 struct gve_ptype_lut *ptype_lut);
+void gve_set_queue_properties(struct gve_priv *priv,
+			      struct gve_device_descriptor *descriptor);
+int gve_set_mtu(struct gve_priv *priv,
+		struct gve_device_descriptor *descriptor);
+void gve_set_mac(struct gve_priv *priv,
+		 struct gve_device_descriptor *descriptor);
 
 #endif /* _GVE_ADMINQ_H */
diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
index eb2d768e5881..338dc0b3249a 100644
--- a/drivers/net/ethernet/google/gve/gve_main.c
+++ b/drivers/net/ethernet/google/gve/gve_main.c
@@ -2400,6 +2400,52 @@ static void gve_set_num_queues(struct gve_priv *priv)
 		 priv->tx_cfg.max_queues, priv->rx_cfg.max_queues);
 }
 
+static void gve_set_default_desc_cnt(struct gve_priv *priv,
+				     const struct gve_device_descriptor *descriptor)
+{
+	priv->tx_desc_cnt = be16_to_cpu(descriptor->tx_queue_entries);
+	priv->rx_desc_cnt = be16_to_cpu(descriptor->rx_queue_entries);
+
+	/* set default ranges */
+	priv->max_tx_desc_cnt = priv->tx_desc_cnt;
+	priv->max_rx_desc_cnt = priv->rx_desc_cnt;
+	priv->min_tx_desc_cnt = priv->tx_desc_cnt;
+	priv->min_rx_desc_cnt = priv->rx_desc_cnt;
+}
+
+void gve_set_queue_properties(struct gve_priv *priv,
+			      struct gve_device_descriptor *descriptor)
+{
+	/* set default descriptor counts */
+	gve_set_default_desc_cnt(priv, descriptor);
+
+	priv->max_registered_pages = be64_to_cpu(descriptor->max_registered_pages);
+	priv->tx_pages_per_qpl = be16_to_cpu(descriptor->tx_pages_per_qpl);
+	priv->default_num_queues = be16_to_cpu(descriptor->default_num_queues);
+}
+
+int gve_set_mtu(struct gve_priv *priv,
+		struct gve_device_descriptor *descriptor)
+{
+	u16 mtu;
+
+	mtu = be16_to_cpu(descriptor->mtu);
+	if (mtu < ETH_MIN_MTU) {
+		dev_err(&priv->pdev->dev, "MTU %d below minimum MTU\n", mtu);
+		return -EINVAL;
+	}
+	priv->dev->max_mtu = mtu;
+
+	return 0;
+}
+
+void gve_set_mac(struct gve_priv *priv,
+		 struct gve_device_descriptor *descriptor)
+{
+	eth_hw_addr_set(priv->dev, descriptor->mac);
+	dev_info(&priv->pdev->dev, "MAC addr: %pM\n", descriptor->mac);
+}
+
 static int gve_init_priv(struct gve_priv *priv, bool skip_describe_device)
 {
 	int err;
-- 
2.54.0.669.g59709faab0-goog

