Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 534A03D9547
	for <bpf@vger.kernel.org>; Fri, 14 Aug 2026 02:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786673676; cv=none; b=flc9veo/RCMPuOY9mxqoT33u2MqE+Qdq6XZbou0t5xq28z52sOrz2XToCaDI4a0MmTeNjhNt+1di3OTor+Ds6XIYrw86QwCBp0+8IAdw2UIw1DWg8iJjuKF4eBfVZLTE+7EE8qzM2n3tcFp4kHrVV+poH57Yu3sv0FsfKbVjhBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786673676; c=relaxed/simple;
	bh=dIWCdzON43WeWi/w81JWueeg3K4aIdgSaKgL7gqOx9k=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=eTY1HRoVtXrQbvGNb7gcq3v0C/QVJHpxx+PZoT17spYyR31+xg7YqJT5/YXOza1NdxZJ66kD8Ijy+UOQy1gEj9jGFEFObY4OjFvjdyVhtd3OUmLvMstfQ3+muUBrDamBc6HoT/uq4RQt2g9aEMUfaaOWQqJoEtwSCP2nZ5ZlFjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=W5zeJzNR; arc=none smtp.client-ip=209.85.210.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="W5zeJzNR"
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-84e048a801dso503084b3a.3
        for <bpf@vger.kernel.org>; Thu, 13 Aug 2026 19:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786673672; x=1787278472; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hE+ZCvB5lEwORzmHngDhGbFSC5TIveq/opNXG6+pkEE=;
        b=W5zeJzNRLLo8ybdHDFhs4CB9ERGdb+Do0CiCj9l+E03uPxFnQblxaddkKkr3ianeUj
         LkAlwBLTMI1KEPPF647L6sTZN8q2RTiL8q1xlzoMFj+Qb39xHtSf3J6CTzKhen7ScxIX
         OzCdZuNcY3KDbN3Y8tHm2/fNu0hHTWE4Gy/yIaIuXzslVXCzUMJmPxFKBTKVjxwB5/fU
         jV3k46EHuyB6BVq1xtDrDlxfGBJtbHuH/jDdOED1XMYDrFO5kyvk2sT+xY691WVed96W
         hVThlxRvGddYK/3jHHphZ9wOKP8ltOFaN/NBg5TWMp5K6SSUH9t8mf5KDwref5ErTnNW
         fe7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786673672; x=1787278472;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hE+ZCvB5lEwORzmHngDhGbFSC5TIveq/opNXG6+pkEE=;
        b=UuZ6Uc2lXVlywnvNa8qMKlpNsbr8ASiGjOvAOKwD4bbmF2UhvQgQN9J2thrTqI+XS+
         RU3NbnSPXsgfhJI/1zH38/ykTgZI4Scz8pTtl+wgM448TLjL6PPdqC+idQWs/owe6HEV
         h9Vfv0AKPd0JKgye0eLjBBNFuDSxYhKsm0xnbP7gFsZFY49j3iGvU5UYc+ZBwQT/4uIv
         PUK2gOuCiMFISkE9BRyd6hYohO9cTGWP0GhQWaK2P0U0eMdu3s/ya7uY1TSx56PQWm7H
         VCbAA48IgC0hUVuxw9HMc0H+Gg9XmL3SHUOXGI7QkmRl/JYJWR6f9Od5466BTV/YQtjs
         KKHw==
X-Forwarded-Encrypted: i=1; AHgh+Rou56isp37cBu1q1GnMkZCDSGxwMM0R8MsmXamCKuzO+1jLm90jhEFv6wlvZrku9DvW4lk=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywy2M++gHQb6dtvQ/iAwkkPGYzCZQCyoD2cfBQrFcqFe2yKuVc/
	i6olTsz39FpCKQ/pA9LberB6859w15IS/ItGxs1gYzQ7WykOID8Rg8W70Dks+BjGprPmVY0iFiM
	7isLUQD21ktGRwGjsMTrpNKb9lw==
X-Received: from pfbfh36.prod.google.com ([2002:a05:6a00:3924:b0:84e:7be:bd38])
 (user=hramamurthy job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:4004:b0:847:99bb:b6d8 with SMTP id d2e1a72fcca58-84fde251c75mr2608581b3a.26.1786673671858;
 Thu, 13 Aug 2026 19:14:31 -0700 (PDT)
Date: Fri, 14 Aug 2026 02:14:04 +0000
In-Reply-To: <20260814021406.3044324-1-hramamurthy@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260814021406.3044324-1-hramamurthy@google.com>
X-Mailer: git-send-email 2.55.0.691.gc56d675ccc-goog
Message-ID: <20260814021406.3044324-15-hramamurthy@google.com>
Subject: [PATCH net-next v4 14/15] gve: add ctrl ops to for queue operations
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

Add the next few control ops to

- create queues
- destroy queues

These changes are just moving existing code into ops, no functional
change.

Reviewed-by: Willem de Bruijn <willemb@google.com>
Reviewed-by: Jordan Rhee <jordanrhee@google.com>
Signed-off-by: Harshitha Ramamurthy <hramamurthy@google.com>
---
v4
- remove double logging in destroy path

v3
- remove double logging in the create queues path

 drivers/net/ethernet/google/gve/gve.h        |  4 ++
 drivers/net/ethernet/google/gve/gve_adminq.c | 50 ++++++++++++++++++++
 drivers/net/ethernet/google/gve/gve_adminq.h |  2 +
 drivers/net/ethernet/google/gve/gve_dqo.h    |  2 +-
 drivers/net/ethernet/google/gve/gve_main.c   | 45 ++++--------------
 5 files changed, 66 insertions(+), 37 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve.h b/drivers/net/ethernet/google/gve/gve.h
index c9fffc727eb3..f3906be810d8 100644
--- a/drivers/net/ethernet/google/gve/gve.h
+++ b/drivers/net/ethernet/google/gve/gve.h
@@ -845,6 +845,8 @@ struct gve_device_info {
  * @configure_rss: Set up default RSS configuration
  * @setup_stats_report: Set up DMA region for stats report (AdminQ only)
  * @reset_flow_rules: Flush all flow rules from device
+ * @create_queues: Sends commands to the device to create TX/RX queues.
+ * @destroy_queues: Sends commands to the device to destroy TX/RX queues.
  */
 struct gve_ctrl_ops {
 	int (*map_db_bar)(struct gve_priv *priv);
@@ -863,6 +865,8 @@ struct gve_ctrl_ops {
 				  dma_addr_t stats_report_addr,
 				  u64 interval_ms); /* AQ-specific */
 	int (*reset_flow_rules)(struct gve_priv *priv);
+	int (*create_queues)(struct gve_priv *priv);
+	int (*destroy_queues)(struct gve_priv *priv);
 };
 
 struct gve_priv {
diff --git a/drivers/net/ethernet/google/gve/gve_adminq.c b/drivers/net/ethernet/google/gve/gve_adminq.c
index d6d3c0aacc4c..3635e81e936a 100644
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
@@ -1789,3 +1813,29 @@ void gve_adminq_teardown_mgmt_irq(struct gve_priv *priv)
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
index 0b48e9f2a82a..d696e4932a8b 100644
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
diff --git a/drivers/net/ethernet/google/gve/gve_dqo.h b/drivers/net/ethernet/google/gve/gve_dqo.h
index 5871f773f0c7..ce402020dff6 100644
--- a/drivers/net/ethernet/google/gve/gve_dqo.h
+++ b/drivers/net/ethernet/google/gve/gve_dqo.h
@@ -66,7 +66,7 @@ void gve_rx_write_doorbell_dqo(const struct gve_priv *priv, int queue_idx);
 void gve_xdp_tx_flush_dqo(struct gve_priv *priv, u32 xdp_qid);
 
 static inline void
-gve_tx_put_doorbell_dqo(const struct gve_priv *priv,
+gve_tx_put_doorbell_dqo(struct gve_priv *priv,
 			const struct gve_queue_resources *q_resources, u32 val)
 {
 	u64 index;
diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
index eecc98807395..500247b0e34a 100644
--- a/drivers/net/ethernet/google/gve/gve_main.c
+++ b/drivers/net/ethernet/google/gve/gve_main.c
@@ -874,33 +874,18 @@ static int gve_unregister_qpls(struct gve_priv *priv)
 
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
@@ -1055,26 +1040,12 @@ static int gve_queues_mem_alloc(struct gve_priv *priv,
 
 static int gve_destroy_rings(struct gve_priv *priv)
 {
-	int num_tx_queues = gve_num_tx_queues(priv);
 	int err;
 
-	err = gve_adminq_destroy_tx_queues(priv, 0, num_tx_queues);
-	if (err) {
-		netif_err(priv, drv, priv->dev,
-			  "failed to destroy tx queues\n");
-		/* This failure will trigger a reset - no need to clean up */
-		return err;
-	}
-	netif_dbg(priv, drv, priv->dev, "destroyed tx queues\n");
-	err = gve_adminq_destroy_rx_queues(priv, priv->rx_cfg.num_queues);
-	if (err) {
-		netif_err(priv, drv, priv->dev,
-			  "failed to destroy rx queues\n");
-		/* This failure will trigger a reset - no need to clean up */
-		return err;
-	}
-	netif_dbg(priv, drv, priv->dev, "destroyed rx queues\n");
-	return 0;
+	err = priv->ctrl_ops->destroy_queues(priv);
+
+	/* A failure will trigger a reset - no need to clean up */
+	return err;
 }
 
 static void gve_queues_mem_free(struct gve_priv *priv,
@@ -2487,6 +2458,8 @@ static const struct gve_ctrl_ops gve_adminq_ops = {
 	.release_db_resources	= gve_adminq_release_db_resources,
 	.setup_mgmt_irq		= gve_adminq_setup_mgmt_irq,
 	.teardown_mgmt_irq	= gve_adminq_teardown_mgmt_irq,
+	.create_queues		= gve_adminq_create_queues,
+	.destroy_queues		= gve_adminq_destroy_queues,
 };
 
 static int gve_init_priv(struct gve_priv *priv)
-- 
2.55.0.691.gc56d675ccc-goog

