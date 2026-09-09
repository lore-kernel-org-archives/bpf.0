Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E7D83B101C
	for <bpf@vger.kernel.org>; Wed,  9 Sep 2026 19:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788981112; cv=none; b=Kh8zLisl69qldP/fwogAr2pgMyBXSJFEF5vni9OJTVILYLgkNY6eGSqBsZX1+vu/YnmJPsgkyBOZ+GiXW2ZbPLdO7FP+1K/OBvt1ifuiUSru2Mcokpsva5zlNXE65YAHvJHulx6XlpG6MPnF7pL4ZqlzfQNYkhySQ1UzLb9KlJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788981112; c=relaxed/simple;
	bh=C3Ksr/Ys+AJCkXFSC/mlrZvpwinbE6uMNSWRGYQVdE4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tJNLo0Sty8TmfWISQhgxWPEOQcxZM9bZYH8a9WgAnYdhp+yVQaaSN6smpo+kXBN38CmRjhaXDgO7wQV0pvlChsKQJBPfes8FUPkyOXtF6anR+4i5jjuMWt9U49vi2h4pIFr1/rfplf230Xa1LFYwPyyG4KC/fRnpqyR05iyRRm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jLz34bcs; arc=none smtp.client-ip=209.85.215.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jLz34bcs"
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cc435388657so4621586a12.3
        for <bpf@vger.kernel.org>; Wed, 09 Sep 2026 12:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788981105; x=1789585905; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Oe8I1pwhrEJpQdRTioweQKfQSZy9DRot7kKfh6Zuylk=;
        b=jLz34bcsrPOh+ny7As5q1PhMxNhiuQgkTJc30xaWWD/p0J0zmlZ9FazUwb4+itTHV9
         PQWCvwULyWzREXHWJXWhp7HYKxnsrt0vIvsc5/MATf2Z6+XXxyq13T01SaSdtvv5E0yf
         MgPeGjX8zqnAiUlVqXtyhxg7q5DnNt8VrujGdDg8DRe/6FTmdxaT/xUZsw2vscFxZyaR
         4oEscz49dYdqFngWUPxZX6K7gC+wADRQK+H8LRp1c8PI1zUpkKaomJBVFmYB/2EeReFC
         W71L2hiUVLnec771CIRxEf7fz1tVT4fP963EadHwMFqAEDbdxsu9udIGnoLDYd7Kxk7N
         F5CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788981105; x=1789585905;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Oe8I1pwhrEJpQdRTioweQKfQSZy9DRot7kKfh6Zuylk=;
        b=a81vyn74T7ThZVQ82e282B1y5ussZtlvBEP5plpJ9ydDMjLKI4f29ucC+2gWfsfAXr
         QfUmIjyLK83+LrpN4HPeHAASeTmrj5LWHz/VfGyYuzTQLARTDJ9TjFTBMKaRUQ6OjCCr
         Iuau2H7Ke4bglsilldIa3ezDJlj4POVKPY/sdu1PF5b+1hMY4dfraVnZOsla+besnt+T
         MqpEz4+FwOPpS+x/aNTLNqg+3joodSNkWnseoDIGzJif0hq4k7pVkZDcgje91HpKlX+f
         6pTStYz9wmJ4j6pXtpDV5wawz6PptCDsWO5jMGTuWYeBz8+9RWS5WQaxeV2UFlTjjb/J
         oDdA==
X-Forwarded-Encrypted: i=1; AKwUvByRPlDxH12EEXbFmXIqBUdbqXDN1Y2R0WR6xFAXYrbh98/ZAiPHnQZpnTGh/CqOGu7tpXk=@vger.kernel.org
X-Gm-Message-State: AFuF++mcswW4tIpEu3qXQp/+6SXxUYqX2+LJCe2O3HU4cSkSDq0nP8Ya
	UXiP2zjyBE0BwzKfS1jZqjH5ylwoVQkNI0l3vvAoOsjFRGWI4CGHCQdppEaDQgMuzXEmxTzbJCG
	inQem+LewoK5XD9DDJT/IiUov0A==
X-Received: from pfblh9.prod.google.com ([2002:a05:6a00:7109:b0:868:fe3c:88e6])
 (user=hramamurthy job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:9f17:b0:3d3:ae0f:526d with SMTP id adf61e73a8af0-3da3a1f0463mr53446381637.25.1788981105078;
 Wed, 09 Sep 2026 12:11:45 -0700 (PDT)
Date: Wed,  9 Sep 2026 19:11:31 +0000
In-Reply-To: <20260909191136.3811892-1-hramamurthy@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260909191136.3811892-1-hramamurthy@google.com>
X-Mailer: git-send-email 2.55.0.1003.g10538fe699-goog
Message-ID: <20260909191136.3811892-9-hramamurthy@google.com>
Subject: [PATCH net-next v6 08/12] gve: split up notify block allocation and
 setup paths
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

From: Joshua Washington <joshwash@google.com>

Before this patch, notify block allocation and setup occurred in the same
method. This all occurred before gve_adminq_configure_device_resources,
which populates the irq_db_indicies array, a DMA region with BAR offsets
for MSI-X vectors.

The coming mailbox mode will require notify blocks to be set up only
after receiving the IRQ doorbell offsets, as the request does not work
with a supplied DMA buffer in the way that admin queue mode does. The
intended flow in that case would be:

1) allocate notify blocks
2) request doorbell information
3) set up MSI-X vectors based on doorbell info

This ordering also works for admin queue mode, so it will be updated to
match.

Reviewed-by: Willem de Bruijn <willemb@google.com>
Reviewed-by: Jordan Rhee <jordanrhee@google.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Joshua Washington <joshwash@google.com>
Signed-off-by: Harshitha Ramamurthy <hramamurthy@google.com>
---
v3:
- remove redundant call to gve_teardown_clock()

 drivers/net/ethernet/google/gve/gve.h      |   2 +
 drivers/net/ethernet/google/gve/gve_main.c | 155 +++++++++++----------
 2 files changed, 86 insertions(+), 71 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve.h b/drivers/net/ethernet/google/gve/gve.h
index e0583e8cd2cd..f624a3e385e4 100644
--- a/drivers/net/ethernet/google/gve/gve.h
+++ b/drivers/net/ethernet/google/gve/gve.h
@@ -674,6 +674,7 @@ struct gve_notify_block {
 	struct gve_tx_ring *tx; /* tx rings on this block */
 	struct gve_rx_ring *rx; /* rx rings on this block */
 	u32 irq;
+	bool irq_requested;
 };
 
 /* Tracks allowed and current rx queue settings */
@@ -954,6 +955,7 @@ struct gve_priv {
 	u64 link_speed;
 	bool up_before_suspend; /* True if dev was up before suspend */
 
+	bool mgmt_irq_requested;
 	struct gve_ptype_lut *ptype_lut_dqo;
 
 	/* Must be a power of two. */
diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
index cc27141240fd..d2f974a0cc87 100644
--- a/drivers/net/ethernet/google/gve/gve_main.c
+++ b/drivers/net/ethernet/google/gve/gve_main.c
@@ -428,6 +428,24 @@ int gve_napi_poll_dqo(struct napi_struct *napi, int budget)
 	return work_done;
 }
 
+static void gve_free_notify_blocks(struct gve_priv *priv)
+{
+	pci_disable_msix(priv->pdev);
+	if (priv->irq_db_indices) {
+		dma_free_coherent(&priv->pdev->dev,
+				  priv->num_ntfy_blks *
+				  sizeof(*priv->irq_db_indices),
+				  priv->irq_db_indices,
+				  priv->irq_db_indices_bus);
+		priv->irq_db_indices = NULL;
+	}
+
+	kvfree(priv->ntfy_blocks);
+	priv->ntfy_blocks = NULL;
+	kvfree(priv->msix_vectors);
+	priv->msix_vectors = NULL;
+}
+
 static const struct cpumask *gve_get_node_mask(struct gve_priv *priv)
 {
 	if (priv->numa_node == NUMA_NO_NODE)
@@ -439,11 +457,9 @@ static const struct cpumask *gve_get_node_mask(struct gve_priv *priv)
 static int gve_alloc_notify_blocks(struct gve_priv *priv)
 {
 	int num_vecs_requested = priv->num_ntfy_blks + 1;
-	const struct cpumask *node_mask;
-	unsigned int cur_cpu;
 	int vecs_enabled;
-	int i, j;
 	int err;
+	int i;
 
 	priv->msix_vectors = kvzalloc_objs(*priv->msix_vectors,
 					   num_vecs_requested);
@@ -457,7 +473,7 @@ static int gve_alloc_notify_blocks(struct gve_priv *priv)
 		dev_err(&priv->pdev->dev, "Could not enable min msix %d/%d\n",
 			GVE_MIN_MSIX, vecs_enabled);
 		err = vecs_enabled;
-		goto abort_with_msix_vectors;
+		goto abort;
 	}
 	if (vecs_enabled != num_vecs_requested) {
 		int new_num_ntfy_blks = (vecs_enabled - 1) & ~0x1;
@@ -480,15 +496,6 @@ static int gve_alloc_notify_blocks(struct gve_priv *priv)
 			priv->rx_cfg.num_queues = priv->rx_cfg.max_queues;
 	}
 
-	/* Setup Management Vector  - the last vector */
-	snprintf(priv->mgmt_msix_name, sizeof(priv->mgmt_msix_name), "gve-mgmnt@pci:%s",
-		 pci_name(priv->pdev));
-	err = request_irq(priv->msix_vectors[priv->mgmt_msix_idx].vector,
-			  gve_mgmnt_intr, 0, priv->mgmt_msix_name, priv);
-	if (err) {
-		dev_err(&priv->pdev->dev, "Did not receive management vector.\n");
-		goto abort_with_msix_enabled;
-	}
 	priv->irq_db_indices =
 		dma_alloc_coherent(&priv->pdev->dev,
 				   priv->num_ntfy_blks *
@@ -496,15 +503,65 @@ static int gve_alloc_notify_blocks(struct gve_priv *priv)
 				   &priv->irq_db_indices_bus, GFP_KERNEL);
 	if (!priv->irq_db_indices) {
 		err = -ENOMEM;
-		goto abort_with_mgmt_vector;
+		goto abort;
 	}
 
 	priv->ntfy_blocks = kvzalloc(priv->num_ntfy_blks *
 				     sizeof(*priv->ntfy_blocks), GFP_KERNEL);
 	if (!priv->ntfy_blocks) {
 		err = -ENOMEM;
-		goto abort_with_irq_db_indices;
+		goto abort;
+	}
+	return 0;
+
+abort:
+	gve_free_notify_blocks(priv);
+	return err;
+}
+
+static void gve_teardown_notify_blocks(struct gve_priv *priv)
+{
+	int i;
+
+	if (!priv->ntfy_blocks)
+		return;
+
+	for (i = 0; i < priv->num_ntfy_blks; i++) {
+		struct gve_notify_block *block = &priv->ntfy_blocks[i];
+
+		if (!block->irq_requested)
+			continue;
+
+		irq_set_affinity_hint(priv->msix_vectors[i].vector,
+				      NULL);
+		free_irq(priv->msix_vectors[i].vector, block);
+		block->irq = 0;
+		block->irq_requested = false;
+	}
+
+	if (priv->mgmt_irq_requested) {
+		free_irq(priv->msix_vectors[priv->mgmt_msix_idx].vector, priv);
+		priv->mgmt_irq_requested = false;
+	}
+}
+
+static int gve_setup_notify_blocks(struct gve_priv *priv)
+{
+	const struct cpumask *node_mask;
+	unsigned int cur_cpu;
+	int i;
+	int err;
+
+	/* Setup Management Vector  - the last vector */
+	snprintf(priv->mgmt_msix_name, sizeof(priv->mgmt_msix_name),
+		 "gve-mgmnt@pci:%s", pci_name(priv->pdev));
+	err = request_irq(priv->msix_vectors[priv->mgmt_msix_idx].vector,
+			  gve_mgmnt_intr, 0, priv->mgmt_msix_name, priv);
+	if (err) {
+		dev_err(&priv->pdev->dev, "Did not receive management vector.\n");
+		return err;
 	}
+	priv->mgmt_irq_requested = true;
 
 	/* Setup the other blocks - the first n-1 vectors */
 	node_mask = gve_get_node_mask(priv);
@@ -522,9 +579,10 @@ static int gve_alloc_notify_blocks(struct gve_priv *priv)
 		if (err) {
 			dev_err(&priv->pdev->dev,
 				"Failed to receive msix vector %d\n", i);
-			goto abort_with_some_ntfy_blocks;
+			goto abort;
 		}
 		block->irq = priv->msix_vectors[msix_idx].vector;
+		block->irq_requested = true;
 		irq_set_affinity_and_hint(block->irq,
 					  cpumask_of(cur_cpu));
 		block->irq_db_index = &priv->irq_db_indices[i].index;
@@ -538,61 +596,12 @@ static int gve_alloc_notify_blocks(struct gve_priv *priv)
 			cur_cpu = cpumask_first(node_mask);
 	}
 	return 0;
-abort_with_some_ntfy_blocks:
-	for (j = 0; j < i; j++) {
-		struct gve_notify_block *block = &priv->ntfy_blocks[j];
-		int msix_idx = j;
 
-		irq_set_affinity_hint(priv->msix_vectors[msix_idx].vector,
-				      NULL);
-		free_irq(priv->msix_vectors[msix_idx].vector, block);
-		block->irq = 0;
-	}
-	kvfree(priv->ntfy_blocks);
-	priv->ntfy_blocks = NULL;
-abort_with_irq_db_indices:
-	dma_free_coherent(&priv->pdev->dev, priv->num_ntfy_blks *
-			  sizeof(*priv->irq_db_indices),
-			  priv->irq_db_indices, priv->irq_db_indices_bus);
-	priv->irq_db_indices = NULL;
-abort_with_mgmt_vector:
-	free_irq(priv->msix_vectors[priv->mgmt_msix_idx].vector, priv);
-abort_with_msix_enabled:
-	pci_disable_msix(priv->pdev);
-abort_with_msix_vectors:
-	kvfree(priv->msix_vectors);
-	priv->msix_vectors = NULL;
+abort:
+	gve_teardown_notify_blocks(priv);
 	return err;
 }
 
-static void gve_free_notify_blocks(struct gve_priv *priv)
-{
-	int i;
-
-	if (!priv->msix_vectors)
-		return;
-
-	/* Free the irqs */
-	for (i = 0; i < priv->num_ntfy_blks; i++) {
-		struct gve_notify_block *block = &priv->ntfy_blocks[i];
-		int msix_idx = i;
-
-		irq_set_affinity_hint(priv->msix_vectors[msix_idx].vector,
-				      NULL);
-		free_irq(priv->msix_vectors[msix_idx].vector, block);
-		block->irq = 0;
-	}
-	free_irq(priv->msix_vectors[priv->mgmt_msix_idx].vector, priv);
-	kvfree(priv->ntfy_blocks);
-	priv->ntfy_blocks = NULL;
-	dma_free_coherent(&priv->pdev->dev, priv->num_ntfy_blks *
-			  sizeof(*priv->irq_db_indices),
-			  priv->irq_db_indices, priv->irq_db_indices_bus);
-	priv->irq_db_indices = NULL;
-	pci_disable_msix(priv->pdev);
-	kvfree(priv->msix_vectors);
-	priv->msix_vectors = NULL;
-}
 
 static void gve_free_control_plane_resources(struct gve_priv *priv)
 {
@@ -749,6 +758,7 @@ static void gve_teardown_control_plane_resources(struct gve_priv *priv)
 
 static void gve_teardown_device(struct gve_priv *priv)
 {
+	gve_teardown_notify_blocks(priv);
 	gve_teardown_control_plane_resources(priv);
 	gve_adminq_free(priv);
 	/*
@@ -2471,13 +2481,16 @@ static int gve_setup_device(struct gve_priv *priv)
 
 	err = gve_alloc_control_plane_resources(priv);
 	if (err)
-		goto err;
+		return err;
+
 	err = gve_setup_control_plane_resources(priv);
 	if (err)
-		goto err;
+		return err;
+
+	err = gve_setup_notify_blocks(priv);
+	if (err)
+		return err;
 	return 0;
-err:
-	return err;
 }
 
 static const struct gve_ctrl_ops gve_adminq_ops = {
-- 
2.55.0.979.g7e5102b832-goog

