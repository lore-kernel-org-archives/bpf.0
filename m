Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C205B439F8F
	for <bpf@vger.kernel.org>; Mon,  3 Aug 2026 18:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785782808; cv=none; b=u9C30IrfRxWOMbbKpzfsP+NguDBAQfubmPZgqShMNzvpiedyFJW169/mGOl+3feX+17C8nd1CNYOfjzqlJFM9K6aCRTNAYV6LGE4x/28YKnK0QEcwa3iLlb3Uu87zmyy6/3/9OunIcgGRJxVNl3MP4OaRiyTJLil7LHelPoxEqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785782808; c=relaxed/simple;
	bh=t6HBq+w6rky5CjIGVie+Ul/ENCeEYFN/jda0PTWlOuU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=uTeCuL24TKcrjykF2YrYCVePJKRpkg4XVdbX7DmYJjCjeqfjI7qRXtCcsUESVyfiZ+/ILu4k+c0bHTNcH1T7X+4oZuLvU2FNSrBDwwTMqlUFsJmRQ1pr1AHrigofyXC+3tgYdLApGKNC1KfxhSj2zcsUUfA11NcDIEb0MAGZ/9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ECfEZKrW; arc=none smtp.client-ip=209.85.210.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ECfEZKrW"
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-84e04598adeso3111721b3a.2
        for <bpf@vger.kernel.org>; Mon, 03 Aug 2026 11:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785782805; x=1786387605; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=R1tOCOGQChFEvfXheFlEBUxLZ6TJFnKo2WVfob4bak4=;
        b=ECfEZKrWiYCHAT3fir0MNBNQTLdsDvMbsZmvPwlzTptHMT9Qtq3gKJ8sZIKC3f3Ofk
         TG4ijSsPpxf7qphmqblOWiuWT6fqL65ZZcQkKaRBUFjl04OwRX6Qi1oYEg9l+SIxrzJX
         AxUplpCugRsOLJJwhofo/zo9SU18v2fNfJdRVnfIaeey3NWqPN5hxf6mTETBfRVbl8xM
         TAoH850m1BV7xl9vtfPR3H+iehCqKWbmEpWC8jVuCRxo4tCjWqhhEtvL2Tiq22qQuZa+
         uy9KYZP4zCgoTO9NgbH5mdyXiTPutaTnc/wYlb2aaytxkH8p1CTxSL2lOtbU0PE3flya
         SKjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785782805; x=1786387605;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=R1tOCOGQChFEvfXheFlEBUxLZ6TJFnKo2WVfob4bak4=;
        b=QjekasQDoXonEemmRvxDZror0s6taDKnzxF5Le5y0prZjKhsCd1eUDpZnauVTGvW6s
         3mrBcPiU6shkhvacnV9HUpRb8ekuE8fAjBbxvAxSrNl2VXkbtczQMha03a86bFURpI9e
         gtyBSgADJUMoZ02Sdb7cJnxYD9hkCAaSl0bz5dr/E9X6pLn6fV8/PVM+4nC4PVR1odzR
         3OK4ou0jElJGcwF2nQ4hSut7/0Ll1tuQrVnC45PwtnFRIZ+PBoxIkx44PFpQ5+cm7zQZ
         NZNT7wW+0F/l+fmNRg6kY7G5gVaNZ/2s/Mczg6HHshay9On/qYur9/DJfRfrtzOzo34P
         kwag==
X-Forwarded-Encrypted: i=1; AHgh+RrhptMtToCvM9CEP1PDOnGNBT0eVTxs9I6YcKf+J3diyAYsnQXjqWmXN7aMUY+WlS6naDs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVNa7iB187RCMZF1d2ZVbgSC865+HW+rPliBxuerJGq9czJACx
	K+ViNegp3Iw9MsoVyHx59XcLy5Df9U/jEwMfC8G6FFpOTvWUEvhNX4u8RTgyi8+tyF/q9BXqxOJ
	YOC7g66GzPKTSSBqLVF6VJyN7Yw==
X-Received: from pfgs25.prod.google.com ([2002:a05:6a00:1799:b0:848:4460:aed3])
 (user=hramamurthy job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:4b45:b0:847:9c3a:b77f with SMTP id d2e1a72fcca58-84ee48eac4fmr10278505b3a.35.1785782804441;
 Mon, 03 Aug 2026 11:46:44 -0700 (PDT)
Date: Mon,  3 Aug 2026 18:46:29 +0000
In-Reply-To: <20260803184630.3813311-1-hramamurthy@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260803184630.3813311-1-hramamurthy@google.com>
X-Mailer: git-send-email 2.55.0.571.g244d577d93-goog
Message-ID: <20260803184630.3813311-15-hramamurthy@google.com>
Subject: [PATCH net-next v3 14/15] gve: add ctrl ops to for queue operations
From: Harshitha Ramamurthy <hramamurthy@google.com>
To: netdev@vger.kernel.org
Cc: joshwash@google.com, hramamurthy@google.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org, 
	john.fastabend@gmail.com, sdf@fomichev.me, jordanrhee@google.com, 
	willemb@google.com, nktgrg@google.com, maolson@google.com, thostet@google.com, 
	jacob.e.keller@intel.com, debarghyak@google.com, kees@kernel.org, 
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
Changes in v3:
- remove double logging in the create queues path

 drivers/net/ethernet/google/gve/gve.h        |  4 ++
 drivers/net/ethernet/google/gve/gve_adminq.c | 50 ++++++++++++++++++++
 drivers/net/ethernet/google/gve/gve_adminq.h |  3 +-
 drivers/net/ethernet/google/gve/gve_dqo.h    |  2 +-
 drivers/net/ethernet/google/gve/gve_main.c   | 48 +++++--------------
 5 files changed, 68 insertions(+), 39 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve.h b/drivers/net/ethernet/google/gve/gve.h
index 352755660138..38b93238e2ca 100644
--- a/drivers/net/ethernet/google/gve/gve.h
+++ b/drivers/net/ethernet/google/gve/gve.h
@@ -844,6 +844,8 @@ struct gve_device_info {
  * @configure_rss: Set up default RSS configuration
  * @setup_stats_report: Set up DMA region for stats report (AdminQ only)
  * @reset_flow_rules: Flush all flow rules from device
+ * @create_queues: Sends commands to the device to create TX/RX queues.
+ * @destroy_queues: Sends commands to the device to destroy TX/RX queues.
  */
 struct gve_ctrl_ops {
 	int (*map_db_bar)(struct gve_priv *priv);
@@ -862,6 +864,8 @@ struct gve_ctrl_ops {
 				  dma_addr_t stats_report_addr,
 				  u64 interval_ms); /* AQ-specific */
 	int (*reset_flow_rules)(struct gve_priv *priv);
+	int (*create_queues)(struct gve_priv *priv);
+	int (*destroy_queues)(struct gve_priv *priv);
 };
 
 struct gve_priv {
diff --git a/drivers/net/ethernet/google/gve/gve_adminq.c b/drivers/net/ethernet/google/gve/gve_adminq.c
index 4299a3931789..b04968257355 100644
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
@@ -1784,3 +1808,29 @@ void gve_adminq_teardown_mgmt_irq(struct gve_priv *priv)
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
index f2dd82f6c254..484f5a54a408 100644
--- a/drivers/net/ethernet/google/gve/gve_main.c
+++ b/drivers/net/ethernet/google/gve/gve_main.c
@@ -871,33 +871,15 @@ static int gve_unregister_qpls(struct gve_priv *priv)
 
 static int gve_create_rings(struct gve_priv *priv)
 {
-	int num_tx_queues = gve_num_tx_queues(priv);
 	int err;
 	int i;
 
-	err = gve_adminq_create_tx_queues(priv, 0, num_tx_queues);
-	if (err) {
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
-		/* This failure will trigger a reset - no need to clean
-		 * up
-		 */
+	err = priv->ctrl_ops->create_queues(priv);
+	/* This failure will trigger a reset - no need to clean
+	 * up
+	 */
+	if (err)
 		return err;
-	}
-	netif_dbg(priv, drv, priv->dev, "created %d rx queues\n",
-		  priv->rx_cfg.num_queues);
 
 	if (gve_is_gqi(priv)) {
 		/* Rx data ring has been prefilled with packet buffers at queue
@@ -1052,26 +1034,16 @@ static int gve_queues_mem_alloc(struct gve_priv *priv,
 
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
@@ -2482,6 +2454,8 @@ static const struct gve_ctrl_ops gve_adminq_ops = {
 	.free_db_resources	= gve_adminq_free_db_resources,
 	.setup_mgmt_irq		= gve_adminq_setup_mgmt_irq,
 	.teardown_mgmt_irq	= gve_adminq_teardown_mgmt_irq,
+	.create_queues		= gve_adminq_create_queues,
+	.destroy_queues		= gve_adminq_destroy_queues,
 };
 
 static int gve_init_priv(struct gve_priv *priv)
-- 
2.55.0.571.g244d577d93-goog

