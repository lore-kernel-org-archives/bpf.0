Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3014C3DA7ED
	for <bpf@vger.kernel.org>; Tue,  2 Jun 2026 23:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780444758; cv=none; b=ouY77SvVOnDYUJwHRWqKgKut2BCIaqNF9VZWt0eLMfeJbT5YBm3BcFRpfWxqR2ncu15+uMqaO6aNG0Vkwg7U1Y+3Dwodn8DEwlAoojmwbBZPT7bHqhQKeApYJImL4xy30O8HCCeNYi/9pKMUb6c6oUcKUXwNa2J9GdhMYl8BdFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780444758; c=relaxed/simple;
	bh=k+vW0mqd6P/RhkJ7A6+QLcND4y/aqaRRAmep9jb9nSI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Q8+bk5oW8p0JEdCLICr+EZzON0Q/K+gY5DccbDEiL0GrAI8oc9K2IIKXRqkzkLU03p15iFtBnNi79yaBrz8Nv35NTvuKR4EriGQXfjPAA+2tL4MvE11oJQWZ5MevIssRp9cy0dg/djJH1qij5MjLtiWKsLCA8d8xsyULQEWDRMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=s7dVpzcH; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="s7dVpzcH"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-36d982d932aso4105972a91.0
        for <bpf@vger.kernel.org>; Tue, 02 Jun 2026 16:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780444754; x=1781049554; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Rd39dBYhCZtI0L93Tr3ikSirnGLJysTcXvZ5qialSWU=;
        b=s7dVpzcHGB357EdISEIJraKTW8uivOF+y0PvdvOg1tYioHLsu+ancE4QY6f99MaCLC
         LyPakCOyd01r/GQ2iule9QePIt2O4CaUr2/MmRSuhGZxlcv3qj/Pt7xQPmB0EghIsyOV
         JVHF6RG3rH/XOqxZUjZV+TYH0sTPqK66TcpKzipdHRQeTR5YSW6VkLlnGVb6wc/q7n0K
         Dx/mwUREEK5Lx52WDii8gu0Fa84ZKyzgeg5xczbZt6eG4FftgWPUZh9jhLAisc5UmzZL
         OvJ8rECqGPO4I+Z32823AexW0opV8+psxNgo9JyVZi1L9I7vBKNufZ+KWWTriPYy0Gfu
         dZHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780444754; x=1781049554;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Rd39dBYhCZtI0L93Tr3ikSirnGLJysTcXvZ5qialSWU=;
        b=MJhoNm3Lw5zou8By2NXx7B3xb5pUHs8k+wgGxy1eu6PVF6E2dRB+l7bmhBMguHORs5
         PXV2NLpXsvOn879oKiETZ8Csb+7tTNe5IUvla+M4zA3Vn1VfPV7086ECXHxUrPkM7Hmp
         rHutaLhWRRcQNCx7eoy7UX+UHuJUlpRLk6L/5jHTGNatq1nPZnirrMBKwD+BDlwLKfzb
         4s/zjNMmQuVucYYGKjwmsuW8Y27GPuT83chxUd4tGqzZJ3PceyZ9ND6Mrz1xp1kPhXLH
         XG0FB4addu0NeR28iWu+ULr8AkacZOKghz1nvFBWnprj3TWYgy7Y8bgUfFCv692rgYUw
         8EIQ==
X-Forwarded-Encrypted: i=1; AFNElJ874lqFONfLn1CzILQmTdKrcTImHmYqI4+28VftYIpe2QWCxDUYf0Fl+tgYmtgTh5lEYSQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtYrSEGPBjvABJdCThixp52Q0IxEk5NZ/yW/y85RoK4wCNWyk2
	Iiz7Av0r+uZLxApHY9ymViTW25PJDciBQ8gXaUt8ojyIR1tB6qrvUp0RzV7PzrS1QI2B3SDrmfb
	IMu8MvOou7jYVB2jz32b+ZHdmsQ==
X-Received: from pgly2.prod.google.com ([2002:a63:1802:0:b0:c79:2fa5:7c6e])
 (user=hramamurthy job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:5345:b0:36d:635a:ac1b with SMTP id 98e67ed59e1d1-36e34292d44mr919317a91.22.1780444754133;
 Tue, 02 Jun 2026 16:59:14 -0700 (PDT)
Date: Tue,  2 Jun 2026 23:58:58 +0000
In-Reply-To: <20260602235900.3050782-1-hramamurthy@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260602235900.3050782-1-hramamurthy@google.com>
X-Mailer: git-send-email 2.54.0.1013.g208068f2d8-goog
Message-ID: <20260602235900.3050782-15-hramamurthy@google.com>
Subject: [PATCH net-next v2 14/15] gve: add ctrl ops to for queue operations
From: Harshitha Ramamurthy <hramamurthy@google.com>
To: netdev@vger.kernel.org
Cc: joshwash@google.com, hramamurthy@google.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org, 
	john.fastabend@gmail.com, sdf@fomichev.me, willemb@google.com, 
	jordanrhee@google.com, jfraker@google.com, nktgrg@google.com, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Add the next few control ops to

- create queues
- destroy queues

These changes are just moving existing code into ops, no functional
change.

Reviewed-by: Willem de Bruijn <willemb@google.com>
Reviewed-by: Jordan Rhee <jordanrhee@google.com>
Signed-off-by: Harshitha Ramamurthy <hramamurthy@google.com>
---
Changes in v2:
- Fixed typo in commit message (exisiting -> existing)

 drivers/net/ethernet/google/gve/gve.h        |  4 ++
 drivers/net/ethernet/google/gve/gve_adminq.c | 50 ++++++++++++++++++++
 drivers/net/ethernet/google/gve/gve_adminq.h |  3 +-
 drivers/net/ethernet/google/gve/gve_main.c   | 41 ++++------------
 4 files changed, 65 insertions(+), 33 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve.h b/drivers/net/ethernet/google/gve/gve.h
index b2e578b3d450..4283cb9b49de 100644
--- a/drivers/net/ethernet/google/gve/gve.h
+++ b/drivers/net/ethernet/google/gve/gve.h
@@ -841,6 +841,8 @@ struct gve_device_info {
  * @configure_rss: Set up default RSS configuration
  * @setup_stats_report: Set up DMA region for stats report (AdminQ only)
  * @reset_flow_rules: Flush all flow rules from device
+ * @create_queues: Sends commands to the device to create TX/RX queues.
+ * @destroy_queues: Sends commands to the device to destroy TX/RX queues.
  */
 struct gve_ctrl_ops {
 	int (*map_db_bar)(struct gve_priv *priv);
@@ -859,6 +861,8 @@ struct gve_ctrl_ops {
 				  dma_addr_t stats_report_addr,
 				  u64 interval_ms); /* AQ-specific */
 	int (*reset_flow_rules)(struct gve_priv *priv);
+	int (*create_queues)(struct gve_priv *priv);
+	int (*destroy_queues)(struct gve_priv *priv);
 };
 
 struct gve_priv {
diff --git a/drivers/net/ethernet/google/gve/gve_adminq.c b/drivers/net/ethernet/google/gve/gve_adminq.c
index 5dc5c63cee32..799381d24c71 100644
--- a/drivers/net/ethernet/google/gve/gve_adminq.c
+++ b/drivers/net/ethernet/google/gve/gve_adminq.c
@@ -941,6 +941,30 @@ static void gve_set_default_rss_sizes(struct gve_priv *priv)
 	}
 }
 
+int gve_adminq_destroy_queues(struct gve_priv *priv)
+{
+	int num_tx_queues = gve_num_tx_queues(priv);
+	int err;
+
+	err = gve_adminq_destroy_tx_queues(priv, 0, num_tx_queues);
+	if (err) {
+		netif_err(priv, drv, priv->dev,
+			  "failed to destroy tx queues\n");
+		/* This failure will trigger a reset - no need to clean up */
+		return err;
+	}
+	netif_dbg(priv, drv, priv->dev, "destroyed tx queues\n");
+	err = gve_adminq_destroy_rx_queues(priv, priv->rx_cfg.num_queues);
+	if (err) {
+		netif_err(priv, drv, priv->dev,
+			  "failed to destroy rx queues\n");
+		/* This failure will trigger a reset - no need to clean up */
+		return err;
+	}
+	netif_dbg(priv, drv, priv->dev, "destroyed rx queues\n");
+	return err;
+}
+
 static void gve_enable_supported_features(struct gve_priv *priv,
 					  u32 supported_features_mask,
 					  const struct gve_device_option_jumbo_frames
@@ -1822,3 +1846,29 @@ void gve_adminq_teardown_mgmt_irq(struct gve_priv *priv)
 		priv->mgmt_irq_requested = false;
 	}
 }
+
+int gve_adminq_create_queues(struct gve_priv *priv)
+{
+	int num_tx_queues = gve_num_tx_queues(priv);
+	int err;
+
+	err = gve_adminq_create_tx_queues(priv, 0, num_tx_queues);
+	if (err) {
+		netif_err(priv, drv, priv->dev, "failed to create %d tx queues\n",
+			  num_tx_queues);
+		return err;
+	}
+	netif_dbg(priv, drv, priv->dev, "created %d tx queues\n",
+		  num_tx_queues);
+
+	err = gve_adminq_create_rx_queues(priv, priv->rx_cfg.num_queues);
+	if (err) {
+		netif_err(priv, drv, priv->dev, "failed to create %d rx queues\n",
+			  priv->rx_cfg.num_queues);
+		return err;
+	}
+	netif_dbg(priv, drv, priv->dev, "created %d rx queues\n",
+		  priv->rx_cfg.num_queues);
+
+	return err;
+}
diff --git a/drivers/net/ethernet/google/gve/gve_adminq.h b/drivers/net/ethernet/google/gve/gve_adminq.h
index ff656fb4f113..03e8318f7327 100644
--- a/drivers/net/ethernet/google/gve/gve_adminq.h
+++ b/drivers/net/ethernet/google/gve/gve_adminq.h
@@ -628,6 +628,8 @@ int gve_adminq_configure_device_resources(struct gve_priv *priv,
 					  dma_addr_t db_array_bus_addr,
 					  u32 num_ntfy_blks);
 int gve_adminq_deconfigure_device_resources(struct gve_priv *priv);
+int gve_adminq_create_queues(struct gve_priv *priv);
+int gve_adminq_destroy_queues(struct gve_priv *priv);
 int gve_adminq_create_tx_queues(struct gve_priv *priv, u32 start_id, u32 num_queues);
 int gve_adminq_destroy_tx_queues(struct gve_priv *priv, u32 start_id, u32 num_queues);
 int gve_adminq_create_single_rx_queue(struct gve_priv *priv, u32 queue_index);
@@ -661,5 +663,4 @@ int gve_adminq_request_db_info(struct gve_priv *priv);
 void gve_adminq_free_db_resources(struct gve_priv *priv);
 int gve_adminq_setup_mgmt_irq(struct gve_priv *priv);
 void gve_adminq_teardown_mgmt_irq(struct gve_priv *priv);
-
 #endif /* _GVE_ADMINQ_H */
diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
index 9d00093826e3..dfc734d8bec9 100644
--- a/drivers/net/ethernet/google/gve/gve_main.c
+++ b/drivers/net/ethernet/google/gve/gve_main.c
@@ -841,33 +841,18 @@ static int gve_unregister_qpls(struct gve_priv *priv)
 
 static int gve_create_rings(struct gve_priv *priv)
 {
-	int num_tx_queues = gve_num_tx_queues(priv);
 	int err;
 	int i;
 
-	err = gve_adminq_create_tx_queues(priv, 0, num_tx_queues);
+	err = priv->ctrl_ops->create_queues(priv);
 	if (err) {
-		netif_err(priv, drv, priv->dev, "failed to create %d tx queues\n",
-			  num_tx_queues);
-		/* This failure will trigger a reset - no need to clean
-		 * up
-		 */
-		return err;
-	}
-	netif_dbg(priv, drv, priv->dev, "created %d tx queues\n",
-		  num_tx_queues);
-
-	err = gve_adminq_create_rx_queues(priv, priv->rx_cfg.num_queues);
-	if (err) {
-		netif_err(priv, drv, priv->dev, "failed to create %d rx queues\n",
-			  priv->rx_cfg.num_queues);
+		netif_err(priv, drv, priv->dev,
+			  "failed to create queues\n");
 		/* This failure will trigger a reset - no need to clean
 		 * up
 		 */
 		return err;
 	}
-	netif_dbg(priv, drv, priv->dev, "created %d rx queues\n",
-		  priv->rx_cfg.num_queues);
 
 	if (gve_is_gqi(priv)) {
 		/* Rx data ring has been prefilled with packet buffers at queue
@@ -1022,26 +1007,16 @@ static int gve_queues_mem_alloc(struct gve_priv *priv,
 
 static int gve_destroy_rings(struct gve_priv *priv)
 {
-	int num_tx_queues = gve_num_tx_queues(priv);
 	int err;
 
-	err = gve_adminq_destroy_tx_queues(priv, 0, num_tx_queues);
+	err = priv->ctrl_ops->destroy_queues(priv);
+
 	if (err) {
-		netif_err(priv, drv, priv->dev,
-			  "failed to destroy tx queues\n");
 		/* This failure will trigger a reset - no need to clean up */
-		return err;
-	}
-	netif_dbg(priv, drv, priv->dev, "destroyed tx queues\n");
-	err = gve_adminq_destroy_rx_queues(priv, priv->rx_cfg.num_queues);
-	if (err) {
 		netif_err(priv, drv, priv->dev,
-			  "failed to destroy rx queues\n");
-		/* This failure will trigger a reset - no need to clean up */
-		return err;
+			  "failed to destroy queues\n");
 	}
-	netif_dbg(priv, drv, priv->dev, "destroyed rx queues\n");
-	return 0;
+	return err;
 }
 
 static void gve_queues_mem_free(struct gve_priv *priv,
@@ -2450,6 +2425,8 @@ static const struct gve_ctrl_ops gve_adminq_ops = {
 	.free_db_resources	= gve_adminq_free_db_resources,
 	.setup_mgmt_irq		= gve_adminq_setup_mgmt_irq,
 	.teardown_mgmt_irq	= gve_adminq_teardown_mgmt_irq,
+	.create_queues		= gve_adminq_create_queues,
+	.destroy_queues		= gve_adminq_destroy_queues,
 };
 
 static int gve_init_priv(struct gve_priv *priv)
-- 
2.54.0.1013.g208068f2d8-goog

