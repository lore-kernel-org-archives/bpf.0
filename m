Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB4E5525A75
	for <bpf@vger.kernel.org>; Wed, 16 Sep 2026 16:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789577756; cv=none; b=cv+RwTe6ClntCffFypw3CJ1AgLyKZdXb51gEh7/7bWSqx1CTC18MwnIWRTcWa3JsN0kStuxZ9+cdOyMq3fxEnml8R87DpsuR+6n2vrM8DhPOS5VSHWv8L7+X7n8xuQGalyVeC9Yc2MySY28ed9bcW/W+sj/MKpT91fTuChog8R4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789577756; c=relaxed/simple;
	bh=xR1Q5sLExuzFz90i0r37pdp/QCv0lmQXVS/evaGADok=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KXLaEBOFRgxfkvHckdr3w84RGS/FjO4KGfoTr6MlVVtxkOqsg1ltwoZsb+1RFPUVTHUCG2yG3PiDF5Ngl+ZHb4RxSxyAbv3mhL+HHxPHRWhIrU2dw0GNGTTOzxm5m1GdjA3r0f6yFqTjkv19Tb8HHeeTNtIUwg5O8zaHS7LU/ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KOP+BASp; arc=none smtp.client-ip=209.85.216.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KOP+BASp"
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-39b77130a7fso10800427a91.2
        for <bpf@vger.kernel.org>; Wed, 16 Sep 2026 09:55:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789577749; x=1790182549; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=v2zfHDxBJPbd3tuhOHOKrEkYplQhAkOIknYzlGp9ds4=;
        b=KOP+BASp3DFtDzXZfXD5xBM6rRMQXV+flBghx+gNbSkRRVSkHLIbTPizXC3jOqri7c
         2mQcR2m+HINRU7B7xFBg5/VaRzyMUdgUIVjMrdO/qtIiRgqidrA+nQRLKw9KbssMgtPw
         ypTrAI/DyweRGvGuidV9TR8/bhXKqrEX3qc5l8f4Uk7rFcRCYJ57bgx2MWuM6heXzKUJ
         qU6+mzm+j50YIHxZCQnZ8dIIdgXEkVqRkR2zEg5c5BBfcs/eNPMN5Vq5RQURQVhGU9OO
         mOOZQgKzf/Nuj5PoH0gCG9MLvVCVXWycjxbILsoFU9060/dnB0t4noY7lvVWYvEBhTyY
         RoGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789577749; x=1790182549;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=v2zfHDxBJPbd3tuhOHOKrEkYplQhAkOIknYzlGp9ds4=;
        b=c9MfXUSaEb/wtVCH8j+gBCX7emMLbdwwxl9iLk+ya9Ttb3+pyddK37FY/D5ibiUQIR
         xHXdSDfsw/eixPd2l0D5/TWZqrW1qM148KROyRK7E+G9/EPiiFulyurmbllqNI1tZOBJ
         YaQvgUKeZABczEOzeFFVqbNcoxU6akmyc79QMlzeijG3J7OIqYYNSdKsixn0jBRrP+9Z
         L0foFKG3dMBipbobsYBCUoOIiRdEVkvkp2R2HaqBg4LuqE1OjVzyAbfAbbZX5+vKhVGx
         L0fshuD7jkjSOHwyxxAMnwiV8FVUYMIU/riPeoskkYHsa9E2glNI/Z9aD7C/8g4X9n5A
         /3kg==
X-Forwarded-Encrypted: i=1; AKwUvBwuAs27jooy22Y03omO1BOHAX8+C/UPjQw9/OIGwS5MrNGNWbfs5vG6y4EqY9iuc7P+UZ0=@vger.kernel.org
X-Gm-Message-State: AFuF++lyRTtc80Gmm8hL+jpcMxRxrrb+ZGVbHgWnLj2Adylw2oHp+0L+
	jUPOZMn020hKrVqFDMoLpiHfqvaMZoemrz702RDEjWMzeQTV1yC7Gx10hlXvktpmDMcGwb/crcg
	AdFgb+ICgFwgM8TeBQfZWA0+aHQ==
X-Received: from pjbqi13.prod.google.com ([2002:a17:90b:274d:b0:39d:9fd8:ce01])
 (user=hramamurthy job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:4e88:b0:398:cb56:e92 with SMTP id 98e67ed59e1d1-39e1e30ba45mr8188161a91.11.1789577748138;
 Wed, 16 Sep 2026 09:55:48 -0700 (PDT)
Date: Wed, 16 Sep 2026 16:55:32 +0000
In-Reply-To: <20260916165533.2187434-1-hramamurthy@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260916165533.2187434-1-hramamurthy@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260916165533.2187434-12-hramamurthy@google.com>
Subject: [PATCH net-next v7 11/12] gve: add ctrl ops for queue operations
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

Add the next few control ops to

- create queues
- destroy queues

These changes are just moving existing code into ops, no functional
change.

Reviewed-by: Willem de Bruijn <willemb@google.com>
Reviewed-by: Jordan Rhee <jordanrhee@google.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Harshitha Ramamurthy <hramamurthy@google.com>
---
v6:
- drop unintentional change of gve_priv from const to non-const

v5:
- remove double logging during queue creation/destruction on err also (Sashiko)

 drivers/net/ethernet/google/gve/gve.h        |  4 ++
 drivers/net/ethernet/google/gve/gve_adminq.c | 50 ++++++++++++++++++++
 drivers/net/ethernet/google/gve/gve_adminq.h |  2 +
 drivers/net/ethernet/google/gve/gve_main.c   | 43 +++--------------
 4 files changed, 63 insertions(+), 36 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve.h b/drivers/net/ethernet/google/gve/gve.h
index 016e85ed91a5..00966b6a730f 100644
--- a/drivers/net/ethernet/google/gve/gve.h
+++ b/drivers/net/ethernet/google/gve/gve.h
@@ -843,6 +843,8 @@ struct gve_device_info {
  * @configure_rss: Set up default RSS configuration
  * @setup_stats_report: Set up DMA region for stats report (AdminQ only)
  * @reset_flow_rules: Flush all flow rules from device
+ * @create_queues: Sends commands to the device to create TX/RX queues.
+ * @destroy_queues: Sends commands to the device to destroy TX/RX queues.
  */
 struct gve_ctrl_ops {
 	int (*map_db_bar)(struct gve_priv *priv);
@@ -861,6 +863,8 @@ struct gve_ctrl_ops {
 				  dma_addr_t stats_report_addr,
 				  u64 interval_ms); /* AQ-specific */
 	int (*reset_flow_rules)(struct gve_priv *priv);
+	int (*create_queues)(struct gve_priv *priv);
+	int (*destroy_queues)(struct gve_priv *priv);
 };
 
 struct gve_priv {
diff --git a/drivers/net/ethernet/google/gve/gve_adminq.c b/drivers/net/ethernet/google/gve/gve_adminq.c
index f0218d78bc5d..450341b70968 100644
--- a/drivers/net/ethernet/google/gve/gve_adminq.c
+++ b/drivers/net/ethernet/google/gve/gve_adminq.c
@@ -943,6 +943,30 @@ static void gve_set_default_rss_sizes(struct gve_priv *priv)
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
@@ -1791,3 +1815,29 @@ void gve_adminq_teardown_mgmt_irq(struct gve_priv *priv)
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
diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
index 44669b2f25d7..33af1437b3c0 100644
--- a/drivers/net/ethernet/google/gve/gve_main.c
+++ b/drivers/net/ethernet/google/gve/gve_main.c
@@ -886,33 +886,16 @@ static int gve_unregister_qpls(struct gve_priv *priv)
 
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
 		/* This failure will trigger a reset - no need to clean
 		 * up
 		 */
 		return err;
 	}
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
-		return err;
-	}
-	netif_dbg(priv, drv, priv->dev, "created %d rx queues\n",
-		  priv->rx_cfg.num_queues);
 
 	if (gve_is_gqi(priv)) {
 		/* Rx data ring has been prefilled with packet buffers at queue
@@ -1067,26 +1050,12 @@ static int gve_queues_mem_alloc(struct gve_priv *priv,
 
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
@@ -2498,6 +2467,8 @@ static const struct gve_ctrl_ops gve_adminq_ops = {
 	.release_db_resources	= gve_adminq_release_db_resources,
 	.setup_mgmt_irq		= gve_adminq_setup_mgmt_irq,
 	.teardown_mgmt_irq	= gve_adminq_teardown_mgmt_irq,
+	.create_queues		= gve_adminq_create_queues,
+	.destroy_queues		= gve_adminq_destroy_queues,
 };
 
 static int gve_init_priv(struct gve_priv *priv)
-- 
2.55.0.1032.g73a4cd73de-goog

