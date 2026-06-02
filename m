Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43E673D9DA8
	for <bpf@vger.kernel.org>; Tue,  2 Jun 2026 23:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780444756; cv=none; b=uQ/VJq7w8OLzMJH93d+491BvgKemthnQXE6H9FDG00zM4r4e+4iXfvWOBTyR1yGum8/WVlQKmfRBOQ8aVM8DFQVsEAvnf9GHMam9bh3cQRf9XRsZfp1CG5JDqrTiZ676nHaJWFKYf/+5RJUbZbCzFUk6heUSJ8jhBRxyogi3j9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780444756; c=relaxed/simple;
	bh=dY8+lKHhV2rHhovPTI1TDqg9U0WqdNSAPj353183+us=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=d1QfoUyFpTFKpKkoJRJHT51ktTUDk1LCy5zmvO4ATw6R0tiFsav0EqkzWLX77UPm2O+RS3YkjnETcd6Bpi8PplZyRa+DbP/aXqBa/a0SE0ZdPa86qhiT29JRybVMlvQuxz6SAQAFsymTOZSzcskjc9bU7/B5JXlUUb3AeC2vvVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=e1TU3EIu; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="e1TU3EIu"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2c0c36f1cc0so55062255ad.3
        for <bpf@vger.kernel.org>; Tue, 02 Jun 2026 16:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780444753; x=1781049553; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=nINQiEO0FTPKhvz31pc2aYp3CuLYfvtT99Woxa/XmsI=;
        b=e1TU3EIufFTqZZ4DyzRUBhQQtJDsdlCQHAvXrL3rv637w88Y7BKXzzOvxnsg2FmTYY
         k7xla1IYLvmcNZRcnfvv66QVSpnxW+qPGVyV38e551m6HIBV5gpDIZ13de7F+bXpzaeu
         d1JVtEUVLmNMJMF0dFhCw52CmmCsAAfhTpgLCxgUc1z72v4ab9Bnd7B2m1UTWdoLVLAz
         4IRipdxqVi20BCXulgs4vRz6xUt3joG1YBRXTeA3PVezcEPcTbgOLBL2LK+2pnacvowF
         Amg4SkvkruCMjconOsicRHNa1VajyjquNcQYETCWp4bYhC3pPIK7J2IGhm+qHWrlZWNw
         zCyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780444753; x=1781049553;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nINQiEO0FTPKhvz31pc2aYp3CuLYfvtT99Woxa/XmsI=;
        b=lppT+HbSSahNyDfeQ1upwKbvlK7aD7AfrA3SkWZkPrB4PFFGqFzQmtVYG9G2a8I11Q
         /VO1dPtCOVZJGn0eULZbZGZuUwG+gl+SzJ4Bdz9obpDrP6aKPMEBDqwrqRN2Tw741ukW
         w9pbg8DTavNzbdrl41w6SiEQXEGH2ggmBTDvJ2/rsLcd1lywoW6fr+r4Pk5kEb083MLD
         57NhoXRv8bA82NXiSM0MbG+C6Z6IAFqdUVVnqbWwgImTxlYl/It8wRMGmd0IGreCrF7B
         IxXeKvPdoTj5EWgYL1wvRg7VwVEki7zNDBoW1ycsN2qkxLodCIYfEOYzJqH/3aE4uNm+
         oB3g==
X-Forwarded-Encrypted: i=1; AFNElJ85xIor1lF6IrJGSpS6djWi98nspEG8sCq/rUYYvtmMbP57SMJdKuoXpnCsIfkiKlYoSJ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFbcfqdI0/79QmpJJu5atlFnCAN2h/RfdjBZzSGVweA/mUgcK7
	3YN/sNONAn8fWRA0lcixQFlGwfEHijvbR+RIuBssAXNRJliSTxj0IpkoQp6tdrKmpQqHwcBJXHU
	U8Qtd4NdREceK+fEGG2P5xhqbqw==
X-Received: from plbmi7.prod.google.com ([2002:a17:902:fcc7:b0:2bc:fd14:b4f1])
 (user=hramamurthy job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:28c:b0:2bf:1fbd:b946 with SMTP id d9443c01a7336-2c1636143fbmr8559035ad.0.1780444753308;
 Tue, 02 Jun 2026 16:59:13 -0700 (PDT)
Date: Tue,  2 Jun 2026 23:58:57 +0000
In-Reply-To: <20260602235900.3050782-1-hramamurthy@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260602235900.3050782-1-hramamurthy@google.com>
X-Mailer: git-send-email 2.54.0.1013.g208068f2d8-goog
Message-ID: <20260602235900.3050782-14-hramamurthy@google.com>
Subject: [PATCH net-next v2 13/15] gve: setup and teardown management interrupts
From: Harshitha Ramamurthy <hramamurthy@google.com>
To: netdev@vger.kernel.org
Cc: joshwash@google.com, hramamurthy@google.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org, 
	john.fastabend@gmail.com, sdf@fomichev.me, willemb@google.com, 
	jordanrhee@google.com, jfraker@google.com, nktgrg@google.com, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Joshua Washington <joshwash@google.com>

Introduce control ops to setup/teardown control plane IRQs. Admin
queue-specific functionality is moved to admin queue files.

Reviewed-by: Willem de Bruijn <willemb@google.com>
Reviewed-by: Jordan Rhee <jordanrhee@google.com>
Signed-off-by: Joshua Washington <joshwash@google.com>
Signed-off-by: Harshitha Ramamurthy <hramamurthy@google.com>
---
 drivers/net/ethernet/google/gve/gve.h        |  4 +++
 drivers/net/ethernet/google/gve/gve_adminq.c | 32 ++++++++++++++++++++
 drivers/net/ethernet/google/gve/gve_adminq.h |  2 ++
 drivers/net/ethernet/google/gve/gve_main.c   | 28 ++++++-----------
 4 files changed, 47 insertions(+), 19 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve.h b/drivers/net/ethernet/google/gve/gve.h
index 6db5fbc0b321..b2e578b3d450 100644
--- a/drivers/net/ethernet/google/gve/gve.h
+++ b/drivers/net/ethernet/google/gve/gve.h
@@ -835,6 +835,8 @@ struct gve_device_info {
  *                     initialization.
  * @request_db_info: Request and store doorbell information into @priv
  * @free_db_resources: Free DMA memory holding doorbell info (AdminQ only)
+ * @setup_mgmt_irq: Setup control plane IRQ
+ * @teardown_mgmt_irq: Teardown control plane IRQ
  * @get_ptype_map: Learn packet type map from device and store it in @priv
  * @configure_rss: Set up default RSS configuration
  * @setup_stats_report: Set up DMA region for stats report (AdminQ only)
@@ -847,6 +849,8 @@ struct gve_ctrl_ops {
 	int (*set_num_ntfy_blks)(struct gve_priv *priv);
 	int (*request_db_info)(struct gve_priv *priv);
 	void (*free_db_resources)(struct gve_priv *priv);
+	int (*setup_mgmt_irq)(struct gve_priv *priv);
+	void (*teardown_mgmt_irq)(struct gve_priv *priv);
 	int (*get_ptype_map)(struct gve_priv *priv);
 	int (*configure_rss)(struct gve_priv *priv,
 			     struct ethtool_rxfh_param *param);
diff --git a/drivers/net/ethernet/google/gve/gve_adminq.c b/drivers/net/ethernet/google/gve/gve_adminq.c
index 259dcd617216..5dc5c63cee32 100644
--- a/drivers/net/ethernet/google/gve/gve_adminq.c
+++ b/drivers/net/ethernet/google/gve/gve_adminq.c
@@ -1790,3 +1790,35 @@ void gve_adminq_free_db_resources(struct gve_priv *priv)
 	priv->irq_db_indices = NULL;
 	gve_free_counter_array(priv);
 }
+
+static irqreturn_t gve_mgmnt_intr(int irq, void *arg)
+{
+	struct gve_priv *priv = arg;
+
+	queue_work(priv->gve_wq, &priv->service_task);
+	return IRQ_HANDLED;
+}
+
+int gve_adminq_setup_mgmt_irq(struct gve_priv *priv)
+{
+	int err;
+
+	snprintf(priv->mgmt_msix_name, sizeof(priv->mgmt_msix_name),
+		 "gve-mgmnt@pci:%s", pci_name(priv->pdev));
+	err = request_irq(priv->msix_vectors[priv->mgmt_msix_idx].vector,
+			  gve_mgmnt_intr, 0, priv->mgmt_msix_name, priv);
+	if (err)
+		return err;
+
+	priv->mgmt_irq_requested = true;
+
+	return 0;
+}
+
+void gve_adminq_teardown_mgmt_irq(struct gve_priv *priv)
+{
+	if (priv->mgmt_irq_requested) {
+		free_irq(priv->msix_vectors[priv->mgmt_msix_idx].vector, priv);
+		priv->mgmt_irq_requested = false;
+	}
+}
diff --git a/drivers/net/ethernet/google/gve/gve_adminq.h b/drivers/net/ethernet/google/gve/gve_adminq.h
index 985b1aefea6e..ff656fb4f113 100644
--- a/drivers/net/ethernet/google/gve/gve_adminq.h
+++ b/drivers/net/ethernet/google/gve/gve_adminq.h
@@ -659,5 +659,7 @@ int gve_adminq_set_num_ntfy_blks(struct gve_priv *priv);
 void gve_adminq_set_num_queues(struct gve_priv *priv);
 int gve_adminq_request_db_info(struct gve_priv *priv);
 void gve_adminq_free_db_resources(struct gve_priv *priv);
+int gve_adminq_setup_mgmt_irq(struct gve_priv *priv);
+void gve_adminq_teardown_mgmt_irq(struct gve_priv *priv);
 
 #endif /* _GVE_ADMINQ_H */
diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
index 55f48aee125e..9d00093826e3 100644
--- a/drivers/net/ethernet/google/gve/gve_main.c
+++ b/drivers/net/ethernet/google/gve/gve_main.c
@@ -267,14 +267,6 @@ static void gve_free_stats_report(struct gve_priv *priv)
 	priv->stats_report = NULL;
 }
 
-static irqreturn_t gve_mgmnt_intr(int irq, void *arg)
-{
-	struct gve_priv *priv = arg;
-
-	queue_work(priv->gve_wq, &priv->service_task);
-	return IRQ_HANDLED;
-}
-
 static irqreturn_t gve_intr(int irq, void *arg)
 {
 	struct gve_notify_block *block = arg;
@@ -499,6 +491,7 @@ static int gve_alloc_notify_blocks(struct gve_priv *priv)
 
 static void gve_teardown_notify_blocks(struct gve_priv *priv)
 {
+	const struct gve_ctrl_ops *ops = priv->ctrl_ops;
 	int i;
 
 	if (!priv->ntfy_blocks)
@@ -518,29 +511,24 @@ static void gve_teardown_notify_blocks(struct gve_priv *priv)
 		block->irq_requested = false;
 	}
 
-	if (priv->mgmt_irq_requested) {
-		free_irq(priv->msix_vectors[priv->mgmt_msix_idx].vector, priv);
-		priv->mgmt_irq_requested = false;
-	}
+	ops->teardown_mgmt_irq(priv);
 }
 
 static int gve_setup_notify_blocks(struct gve_priv *priv)
 {
+	const struct gve_ctrl_ops *ops = priv->ctrl_ops;
 	const struct cpumask *node_mask;
 	unsigned int cur_cpu;
 	int i;
 	int err;
 
-	/* Setup Management Vector  - the last vector */
-	snprintf(priv->mgmt_msix_name, sizeof(priv->mgmt_msix_name),
-		 "gve-mgmnt@pci:%s", pci_name(priv->pdev));
-	err = request_irq(priv->msix_vectors[priv->mgmt_msix_idx].vector,
-			  gve_mgmnt_intr, 0, priv->mgmt_msix_name, priv);
+	/* Setup Management Vector */
+	err = ops->setup_mgmt_irq(priv);
 	if (err) {
-		dev_err(&priv->pdev->dev, "Did not receive management vector.\n");
+		dev_err(&priv->pdev->dev,
+			"Did not receive management vector.\n");
 		return err;
 	}
-	priv->mgmt_irq_requested = true;
 
 	node_mask = gve_get_node_mask(priv);
 	cur_cpu = cpumask_first(node_mask);
@@ -2460,6 +2448,8 @@ static const struct gve_ctrl_ops gve_adminq_ops = {
 	.configure_rss		= gve_adminq_configure_rss,
 	.request_db_info	= gve_adminq_request_db_info,
 	.free_db_resources	= gve_adminq_free_db_resources,
+	.setup_mgmt_irq		= gve_adminq_setup_mgmt_irq,
+	.teardown_mgmt_irq	= gve_adminq_teardown_mgmt_irq,
 };
 
 static int gve_init_priv(struct gve_priv *priv)
-- 
2.54.0.1013.g208068f2d8-goog

