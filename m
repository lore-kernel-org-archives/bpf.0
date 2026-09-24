Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2D684BD34E
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 18:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790276031; cv=none; b=KbnkUGoPk5NlIxCkraXq5mDjNPI3egU448m5C6r2/3Zk6I2f8eUKFA0+jccCSh3HUZ+cslu8qDa0506ndDupURUB/DzS4ujwcVr2rHj9j7GeEmeaESY6jGAFncx0X8vSoC07SG13s1qVQ5JPwv5SIv0IDqDSrcWJJgYy6Wy5Lso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790276031; c=relaxed/simple;
	bh=hGSR9LQ+k5KQdDYTDdLPLABEeHO/1hIfXCq1QqnN/v8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ozjbRXSCa4L8n2+Mf1wckJd+5uf2tBSh0KoFGUWyg1KMdN++Hca75QXtX73bD6OeJddI2Xzs09dJADxQkXkFTGNhipmWL4aIwn6VFOEoKYr6nCRIXbr6RyeXQUE9lM6YgqE+nQqDAqtQh2wmx3kox1TNwd12Xm1g7SV5o2sZZzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mVbJEAKG; arc=none smtp.client-ip=209.85.214.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mVbJEAKG"
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2ce7dfd33ffso581635ad.0
        for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 11:53:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790276014; x=1790880814; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PFSVP12pfmeOhuKjpNkvvBADrf7uAjGGyCpzBwEnBsM=;
        b=mVbJEAKGsg7gypkQ2tMxtKFLxOtwrx5Wy7Iki+uoPoolRO0P9hlqq96/EQ5mLY5AfJ
         /PSSnde14EOEq111FUSqTMyzEH7UUxbZmqYRC1iLUI6zSPaWn8gsV8eLwe/ZtZTt++94
         YxbvWa5a6L6S92zQsJJAOmCpVupaFZRB1eqTJy++igB4MkB3BL+VRQtH/6jwIQhFb5Vn
         QESueKQ4VlORO17xVpjp0etMBei3ZKtE6w0A1l1h/7v6kFp88cEp0bxyo1X918htNnl6
         PFaN48Z2UERyi7fB9+QpkkFu+TnISZ4m4JVTp942pW9h8U4AGuWUaFX5JHsbp9H8s5wB
         S1Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790276014; x=1790880814;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PFSVP12pfmeOhuKjpNkvvBADrf7uAjGGyCpzBwEnBsM=;
        b=pnbQmFL3y2Vby2uDYdBlP7eVDrmoHFgT1x9TvU31dzyBxPUfDKPsQJualIiJLmRiz4
         IR1uwPp5OQ9niByVEfKawGTLfiuZfPbm9dTkwHvZOBhE1mPgvduE3vQL0cXMVgMQ+0wL
         7cKbiCGlN+87zEMmJdBRI2mymNpx3TUzlzbOKRee0e8cEZLzRwchd+7923ySncQg/VLO
         xvUOxmPla5DreBvQLK8DaSKoeyrC4uO+wogFMLWBhzpKT2zns46cBxN09y6UR9i09N7i
         MxFBUhn3rcJqda94mbgFXFtHOXuzn7ztWf0A/QWVlUdHUcTrsd7wQn8aRERzHsRfe9xH
         Wzxg==
X-Forwarded-Encrypted: i=1; AKwUvBwMgcIKBkSqpAJPx/998vq7MveR1BCr/Yhj5IqJaFX8SOz7g9L2MOpD+XdPTPp5YJbP2xg=@vger.kernel.org
X-Gm-Message-State: AFuF++mkVhBMF7q71f2P+R7TZ/fi0zaAeXrM2W/KWfiwIFSGysca6zG0
	usvodJTzCTfr388QbIJ6kB0cyt+X4IwDbJ2+zNhDQS1BGR9Oym6VhQjb9q0jT/PJ8c4iMoMr3tT
	NUhoboiEa0b//B8fVdkiddqdMVg==
X-Received: from plrr9.prod.google.com ([2002:a17:902:c609:b0:2db:1a14:e0c8])
 (user=hramamurthy job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:1a70:b0:2de:834b:b594 with SMTP id d9443c01a7336-2df7dd8dafcmr29923875ad.74.1790276013697;
 Thu, 24 Sep 2026 11:53:33 -0700 (PDT)
Date: Thu, 24 Sep 2026 18:53:14 +0000
In-Reply-To: <20260924185316.2831077-1-hramamurthy@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260924185316.2831077-1-hramamurthy@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260924185316.2831077-11-hramamurthy@google.com>
Subject: [PATCH net-next v8 10/12] gve: setup and teardown management interrupts
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

Introduce control ops to setup/teardown control plane IRQs. Admin
queue-specific functionality is moved to admin queue files.

Reviewed-by: Willem de Bruijn <willemb@google.com>
Reviewed-by: Jordan Rhee <jordanrhee@google.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Joshua Washington <joshwash@google.com>
Signed-off-by: Harshitha Ramamurthy <hramamurthy@google.com>
---
 drivers/net/ethernet/google/gve/gve.h        |  4 ++++
 drivers/net/ethernet/google/gve/gve_adminq.c | 32 ++++++++++++++++++++++++++++
 drivers/net/ethernet/google/gve/gve_adminq.h |  2 ++
 drivers/net/ethernet/google/gve/gve_main.c   | 26 +++++++---------------
 4 files changed, 46 insertions(+), 18 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve.h b/drivers/net/ethernet/google/gve/gve.h
index 6c46c842070b..016e85ed91a5 100644
--- a/drivers/net/ethernet/google/gve/gve.h
+++ b/drivers/net/ethernet/google/gve/gve.h
@@ -837,6 +837,8 @@ struct gve_device_info {
  * @request_db_info: Request and store doorbell information into @priv
  * @release_db_resources: Release device hold on DMA memory holding doorbell
  *			  info (AdminQ only)
+ * @setup_mgmt_irq: Setup control plane IRQ
+ * @teardown_mgmt_irq: Teardown control plane IRQ
  * @get_ptype_map: Learn packet type map from device and store it in @priv
  * @configure_rss: Set up default RSS configuration
  * @setup_stats_report: Set up DMA region for stats report (AdminQ only)
@@ -849,6 +851,8 @@ struct gve_ctrl_ops {
 	int (*set_num_ntfy_blks)(struct gve_priv *priv);
 	int (*request_db_info)(struct gve_priv *priv);
 	void (*release_db_resources)(struct gve_priv *priv);
+	int (*setup_mgmt_irq)(struct gve_priv *priv);
+	void (*teardown_mgmt_irq)(struct gve_priv *priv);
 	int (*get_ptype_map)(struct gve_priv *priv);
 	int (*configure_rss)(struct gve_priv *priv,
 			     struct ethtool_rxfh_param *param);
diff --git a/drivers/net/ethernet/google/gve/gve_adminq.c b/drivers/net/ethernet/google/gve/gve_adminq.c
index b89825a85db8..05b011417bf3 100644
--- a/drivers/net/ethernet/google/gve/gve_adminq.c
+++ b/drivers/net/ethernet/google/gve/gve_adminq.c
@@ -1755,3 +1755,35 @@ void gve_adminq_release_db_resources(struct gve_priv *priv)
 			"Could not deconfigure device resources: err=%d\n",
 			err);
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
index db6ea715eccf..0cec289f89e4 100644
--- a/drivers/net/ethernet/google/gve/gve_main.c
+++ b/drivers/net/ethernet/google/gve/gve_main.c
@@ -291,14 +291,6 @@ static void gve_free_stats_report(struct gve_priv *priv)
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
@@ -523,12 +515,10 @@ abort:
 
 static void gve_teardown_notify_blocks(struct gve_priv *priv)
 {
+	const struct gve_ctrl_ops *ops = priv->ctrl_ops;
 	int i;
 
-	if (priv->mgmt_irq_requested) {
-		free_irq(priv->msix_vectors[priv->mgmt_msix_idx].vector, priv);
-		priv->mgmt_irq_requested = false;
-	}
+	ops->teardown_mgmt_irq(priv);
 
 	if (!priv->ntfy_blocks)
 		return;
@@ -549,21 +539,19 @@ static void gve_teardown_notify_blocks(struct gve_priv *priv)
 
 static int gve_setup_notify_blocks(struct gve_priv *priv)
 {
+	const struct gve_ctrl_ops *ops = priv->ctrl_ops;
 	const struct cpumask *node_mask;
 	unsigned int cur_cpu;
 	int i;
 	int err;
 
 	/* Setup Management Vector */
-	snprintf(priv->mgmt_msix_name, sizeof(priv->mgmt_msix_name),
-		 "gve-mgmnt@pci:%s", pci_name(priv->pdev));
-	err = request_irq(priv->msix_vectors[priv->mgmt_msix_idx].vector,
-			  gve_mgmnt_intr, 0, priv->mgmt_msix_name, priv);
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
@@ -2505,6 +2493,8 @@ static const struct gve_ctrl_ops gve_adminq_ops = {
 	.configure_rss		= gve_adminq_configure_rss,
 	.request_db_info	= gve_adminq_request_db_info,
 	.release_db_resources	= gve_adminq_release_db_resources,
+	.setup_mgmt_irq		= gve_adminq_setup_mgmt_irq,
+	.teardown_mgmt_irq	= gve_adminq_teardown_mgmt_irq,
 };
 
 static int gve_init_priv(struct gve_priv *priv)
-- 
2.56.0.rc1.310.g51773c2048-goog

