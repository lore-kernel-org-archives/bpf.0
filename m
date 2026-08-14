Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1DB93D88FA
	for <bpf@vger.kernel.org>; Fri, 14 Aug 2026 02:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786673676; cv=none; b=IKsKWwTlfO+tcKMbOX1Nv3/YxpmeSNnCFpg3VXA3RX19pB+tlPYKM/guwoA5teU7g+Rb9MwUvoWvrYJI0hoAcW8Mz5G1+fGG6tRwugXOwaZXdIITDF3Qk2YpRzOKKl5XEpetCm8vGmahka0yHq68SEX4etSvJFnaFOjxYRZlPxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786673676; c=relaxed/simple;
	bh=1P7SL3ELHkjZcrK0AeZK45hx1kS2gBmSauo7k457i+Y=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NrtWEB1LARXZBsw8z8B3NCVqEdA+4ZjJIVL61iaTE7A+5gAsFSXN4Ad2LpeAiqrg/24POgwkZdcacgtw1g16jaTBuFWsle3ccxq1I6x3uNkgMT3s3SGUaS06G+8g3Dvbpk7qPLYZ5kEJCPC0x1JFa1gEzO7Z6b6QjRRxptE0E5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TfN2Y9ML; arc=none smtp.client-ip=209.85.214.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TfN2Y9ML"
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2d004f13426so7350835ad.3
        for <bpf@vger.kernel.org>; Thu, 13 Aug 2026 19:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786673671; x=1787278471; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DcmK68FKuTMXuuhHVbS8GLAbni4+3r6YXbJXIx5kwSg=;
        b=TfN2Y9MLofoksDzo5j67cy3/Z6pAnXbZcyxsUdpVd/JPK89iLHpYMNyY6cHjUg2dWu
         kA+fMMWTAZdadiyo67COfBOkz4k6+6zDmCvANl6K4bapTTUvbIgfyWmLVIiASW+MVYvZ
         GXE9adCcGY6TpRzF2/A6PMlRDxzDrxE6JDCSWzPPOhQNfT2jGdUFvwlwC6dSjSe+I5MR
         jrAWE9dt+zkQM8sS9LQ7Oi8x6fuaVUK4/V7AXK8EdsYhIIHoipoxZFMcwI4DOKdFFgZD
         HE1Hieg+QmkiUj9hgOMFh5GYbFjObPeen4ZOuu2ISLvAmWP1/BpEbn7zGnMm7UKSw5dK
         jgyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786673671; x=1787278471;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DcmK68FKuTMXuuhHVbS8GLAbni4+3r6YXbJXIx5kwSg=;
        b=QSj4SgoHCtpQGdcYtPkxhA490hcbgIxzbdJVsv46hr3LiiPA+Hcr6DXWgGJLpoQRYX
         0GYWWb+vEE0F6olcIB1tzXb/UZiMcOtRLw/kkJ4xXrSrp1BYHa+FsVsWkAKQXQ4fN9eS
         VaDj/8WcJoU3IKFuZHIMpgsgL1X5DinvkTICFPcYekbbgTyGIyHO5PX2hqu9bDrmo7W/
         sAHaQmXZcX3FE/p9HwF2ApKqeqayjIb+1hl9OQ61OBPlAYF/0vqzucy9QagNQUtM1vT4
         dOxkTVXcgDpm2Ie1WrFlkYVKwJuq+TnR0bF8bRuNSrSPjx37uXiWjPBPKoWa+IWCDzhe
         abAQ==
X-Forwarded-Encrypted: i=1; AHgh+Rpmqvr3dDo90/Kujadz2n6wX5ObID33xhrhfGuNAvb2VJpqyO5TMTPkUtX5wEH6QUJdTOc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yww+onF4wXLJjswsw2g97ssbQ7yg7SKcQlA7+kfHnWByjoyeAC5
	WFI69Ye7Z/8J6wBBozIMVOGtL1ZqDZZQ634Q8FQk9ncXDYddS4I6ep9oywRZgj1RaTOOECsQP6H
	MXYoYGYsNu4K4A93yKaM1s4ySdA==
X-Received: from plbaz8.prod.google.com ([2002:a17:902:a588:b0:2d3:768a:b66c])
 (user=hramamurthy job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:cf07:b0:2cf:ba10:6d6 with SMTP id d9443c01a7336-2d3b07f77c0mr30625015ad.4.1786673670683;
 Thu, 13 Aug 2026 19:14:30 -0700 (PDT)
Date: Fri, 14 Aug 2026 02:14:03 +0000
In-Reply-To: <20260814021406.3044324-1-hramamurthy@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260814021406.3044324-1-hramamurthy@google.com>
X-Mailer: git-send-email 2.55.0.691.gc56d675ccc-goog
Message-ID: <20260814021406.3044324-14-hramamurthy@google.com>
Subject: [PATCH net-next v4 13/15] gve: setup and teardown management interrupts
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

From: Joshua Washington <joshwash@google.com>

Introduce control ops to setup/teardown control plane IRQs. Admin
queue-specific functionality is moved to admin queue files.

Reviewed-by: Willem de Bruijn <willemb@google.com>
Reviewed-by: Jordan Rhee <jordanrhee@google.com>
Signed-off-by: Joshua Washington <joshwash@google.com>
Signed-off-by: Harshitha Ramamurthy <hramamurthy@google.com>
---
 drivers/net/ethernet/google/gve/gve.h        |  4 +++
 drivers/net/ethernet/google/gve/gve_adminq.c | 36 ++++++++++++++++++++
 drivers/net/ethernet/google/gve/gve_adminq.h |  2 ++
 drivers/net/ethernet/google/gve/gve_main.c   | 32 +++++------------
 4 files changed, 51 insertions(+), 23 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve.h b/drivers/net/ethernet/google/gve/gve.h
index 2d869d249cdd..c9fffc727eb3 100644
--- a/drivers/net/ethernet/google/gve/gve.h
+++ b/drivers/net/ethernet/google/gve/gve.h
@@ -839,6 +839,8 @@ struct gve_device_info {
  * @request_db_info: Request and store doorbell information into @priv
  * @release_db_resources: Release device hold on DMA memory holding doorbell
  *			  info (AdminQ only)
+ * @setup_mgmt_irq: Setup control plane IRQ
+ * @teardown_mgmt_irq: Teardown control plane IRQ
  * @get_ptype_map: Learn packet type map from device and store it in @priv
  * @configure_rss: Set up default RSS configuration
  * @setup_stats_report: Set up DMA region for stats report (AdminQ only)
@@ -851,6 +853,8 @@ struct gve_ctrl_ops {
 	int (*set_num_ntfy_blks)(struct gve_priv *priv);
 	int (*request_db_info)(struct gve_priv *priv);
 	void (*release_db_resources)(struct gve_priv *priv);
+	int (*setup_mgmt_irq)(struct gve_priv *priv);
+	void (*teardown_mgmt_irq)(struct gve_priv *priv);
 	int (*get_ptype_map)(struct gve_priv *priv);
 	int (*configure_rss)(struct gve_priv *priv,
 			     struct ethtool_rxfh_param *param);
diff --git a/drivers/net/ethernet/google/gve/gve_adminq.c b/drivers/net/ethernet/google/gve/gve_adminq.c
index 3fdc3575c077..9a06af652533 100644
--- a/drivers/net/ethernet/google/gve/gve_adminq.c
+++ b/drivers/net/ethernet/google/gve/gve_adminq.c
@@ -1748,3 +1748,39 @@ void gve_adminq_release_db_resources(struct gve_priv *priv)
 			"Could not deconfigure device resources: err=%d\n",
 			err);
 }
+
+static irqreturn_t gve_mgmnt_intr(int irq, void *arg)
+{
+	struct gve_priv *priv = arg;
+
+	/* Device resources are not okay; consider the interrupt spurious. */
+	if (!gve_get_device_resources_ok(priv))
+		return IRQ_NONE;
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
index 52172bf228eb..0b48e9f2a82a 100644
--- a/drivers/net/ethernet/google/gve/gve_adminq.h
+++ b/drivers/net/ethernet/google/gve/gve_adminq.h
@@ -659,4 +659,6 @@ int gve_adminq_map_db_bar(struct gve_priv *priv);
 void gve_adminq_unmap_db_bar(struct gve_priv *priv);
 int gve_adminq_request_db_info(struct gve_priv *priv);
 void gve_adminq_release_db_resources(struct gve_priv *priv);
+int gve_adminq_setup_mgmt_irq(struct gve_priv *priv);
+void gve_adminq_teardown_mgmt_irq(struct gve_priv *priv);
 #endif /* _GVE_ADMINQ_H */
diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
index e57c8596fca4..eecc98807395 100644
--- a/drivers/net/ethernet/google/gve/gve_main.c
+++ b/drivers/net/ethernet/google/gve/gve_main.c
@@ -291,18 +291,6 @@ static void gve_free_stats_report(struct gve_priv *priv)
 	priv->stats_report = NULL;
 }
 
-static irqreturn_t gve_mgmnt_intr(int irq, void *arg)
-{
-	struct gve_priv *priv = arg;
-
-	/* Device resources are not okay; consider the interrupt spurious. */
-	if (!gve_get_device_resources_ok(priv))
-		return IRQ_NONE;
-
-	queue_work(priv->gve_wq, &priv->service_task);
-	return IRQ_HANDLED;
-}
-
 static irqreturn_t gve_intr(int irq, void *arg)
 {
 	struct gve_notify_block *block = arg;
@@ -527,6 +515,7 @@ static int gve_alloc_notify_blocks(struct gve_priv *priv)
 
 static void gve_teardown_notify_blocks(struct gve_priv *priv)
 {
+	const struct gve_ctrl_ops *ops = priv->ctrl_ops;
 	int i;
 
 	if (!priv->ntfy_blocks)
@@ -546,29 +535,24 @@ static void gve_teardown_notify_blocks(struct gve_priv *priv)
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
@@ -2501,6 +2485,8 @@ static const struct gve_ctrl_ops gve_adminq_ops = {
 	.configure_rss		= gve_adminq_configure_rss,
 	.request_db_info	= gve_adminq_request_db_info,
 	.release_db_resources	= gve_adminq_release_db_resources,
+	.setup_mgmt_irq		= gve_adminq_setup_mgmt_irq,
+	.teardown_mgmt_irq	= gve_adminq_teardown_mgmt_irq,
 };
 
 static int gve_init_priv(struct gve_priv *priv)
-- 
2.55.0.691.gc56d675ccc-goog

