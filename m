Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 174B83E833D
	for <bpf@vger.kernel.org>; Mon,  1 Jun 2026 17:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780336494; cv=none; b=WAXVaVtiXeSWaA96AD42vU3qY3rHck4wpPOgTLsFCVFYQ8fJYlLh13F9tVCXqpqE94tXSj8flM9nVptrnzZ3+IP/ESC+b9DVE1qYiSHJUJ0vNZxIOGIpIK4uJ3HxPXoopVScw7lQCZPe0xmo02a9RjyOHud+MGQQOMsCG1HDm/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780336494; c=relaxed/simple;
	bh=DaaUDYb14AbxXDSG3GajKEistk5ab2cZr9oWRTPGei8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dQTnmwK7/fSpo6gnoJBF65tg1ML+/kqUEKzSGh8fCuYnKC0E3IKcTYoK7MkYJjySAU3hQCy29JzEFK8ruxCZGwcBcloqtvJIsC0RzofyOLGcMEgC5FDIgJOPEGannjl20SAzlIioqU2XtrYNNz3bKJfddbNUHzeBqxlws8qp59c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FVYdJrYC; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FVYdJrYC"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2c0c32f4b1bso18116965ad.2
        for <bpf@vger.kernel.org>; Mon, 01 Jun 2026 10:54:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780336490; x=1780941290; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=IJUyKllpvSpdWZxcbGcFBQ57vMGzd+2g9rnoMrkdHYE=;
        b=FVYdJrYCMFk39g/eoHP+h1fcLjRCJv0n7Enc1gYKIiJ1nlP53A9eDLeAgFUy0X/x2t
         iloOsygrBw8kEqRT2vvL0LPOdxwej2Kl4MmliYrckVKruEd3Dfhf1PU9NC9CFtxywr+/
         7cGlq1fdLAkFXMToCu50p1I7GjgkzmWojSV7wz2GUkaj/t4Djhm4yd80bujx5icQe4hb
         odjWrlqs7C8Xg8ZGH+b9ICQtgwiScSQ8RGzR+NM2zXBu/UqSsH/5zdbWzUuIA8c47NOh
         c+xm6plWdoQNjjkTWGL1Qo8rXSNacGIfMno42FYjw87HLaijy8V9qRm1oRFeKY3lssLO
         r3NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780336490; x=1780941290;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IJUyKllpvSpdWZxcbGcFBQ57vMGzd+2g9rnoMrkdHYE=;
        b=f+I6T44OAwG+wAggbj7AovtLvLeQl7ykI4KHku11A9INWu4qB/UqkoPELygzrgW0dx
         yUr4tPGWwtzGS9zk0jWlpFq2DehYeCIsDhIsGv1vwly04rVGne3oxmBbZRu5lw1SDlon
         1khQnLfim6GGiHMNi2vkDCb6iIDczaW0escRCEeD+jzo5VvMZSTo7LWLHnNRELmqnoGB
         dFDWZDUPbkTAvGKveNP95yoD5JMDznsqIH/SZr2mDt/jMztRl1rhFNtMj1wlVa8xeS+u
         i7An6QQSVAs1cKtValJB6bcz56mwOy0xTdaML2Sv4TomUoztqxas31xxBZMgWQcIYA4i
         aPkA==
X-Forwarded-Encrypted: i=1; AFNElJ8t9dR54pbZ+yiiSBs9It08EVBzJwiAx73HCdn/kt8TH+pVdZH/ol1vwxzUIKhZqr7my9A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3JbaUh4hLd3KXXNeXVwGKkLTMMoM/zHqh+2QCXjfJfjjHnw5p
	GuVbUtk2462NRQBGTHzPaMiH+zWFZ1y985NHI8ETLGbTTFbUMSKhRk3Q0mViL0DPBXvGBfKbqWF
	BplgHiKfB0OupMFaVT6k/bhi/BQ==
X-Received: from plbt6.prod.google.com ([2002:a17:903:c86:b0:2bf:522:6125])
 (user=hramamurthy job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:d4c5:b0:2c1:ef9:4516 with SMTP id d9443c01a7336-2c10ef96145mr1275375ad.35.1780336490052;
 Mon, 01 Jun 2026 10:54:50 -0700 (PDT)
Date: Mon,  1 Jun 2026 17:54:35 +0000
In-Reply-To: <20260601175437.3767283-1-hramamurthy@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260601175437.3767283-1-hramamurthy@google.com>
X-Mailer: git-send-email 2.54.0.1013.g208068f2d8-goog
Message-ID: <20260601175437.3767283-14-hramamurthy@google.com>
Subject: [PATCH net-next 13/15] gve: setup and teardown management interrupts
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
index 2cc66dfb6098..bb661e3b528f 100644
--- a/drivers/net/ethernet/google/gve/gve.h
+++ b/drivers/net/ethernet/google/gve/gve.h
@@ -838,6 +838,8 @@ struct gve_device_info {
  *                     initialization.
  * @request_db_info: Request and store doorbell information into @priv
  * @free_db_resources: Free DMA memory holding doorbell info (AdminQ only)
+ * @setup_mgmt_irq: Setup control plane IRQ
+ * @teardown_mgmt_irq: Teardown control plane IRQ
  * @get_ptype_map: Learn packet type map from device and store it in @priv
  * @configure_rss: Set up default RSS configuration
  * @setup_stats_report: Set up DMA region for stats report (AdminQ only)
@@ -850,6 +852,8 @@ struct gve_ctrl_ops {
 	int (*set_num_ntfy_blks)(struct gve_priv *priv);
 	int (*request_db_info)(struct gve_priv *priv);
 	void (*free_db_resources)(struct gve_priv *priv);
+	int (*setup_mgmt_irq)(struct gve_priv *priv);
+	void (*teardown_mgmt_irq)(struct gve_priv *priv);
 	int (*get_ptype_map)(struct gve_priv *priv);
 	int (*configure_rss)(struct gve_priv *priv,
 			     struct ethtool_rxfh_param *param);
diff --git a/drivers/net/ethernet/google/gve/gve_adminq.c b/drivers/net/ethernet/google/gve/gve_adminq.c
index 966b1776ae44..5c95c737f2fd 100644
--- a/drivers/net/ethernet/google/gve/gve_adminq.c
+++ b/drivers/net/ethernet/google/gve/gve_adminq.c
@@ -1815,3 +1815,35 @@ void gve_adminq_free_db_resources(struct gve_priv *priv)
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
index 948bd3b17496..0c5d14c46ee8 100644
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
2.54.0.669.g59709faab0-goog

