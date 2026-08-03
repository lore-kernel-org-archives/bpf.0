Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C108F433E7E
	for <bpf@vger.kernel.org>; Mon,  3 Aug 2026 18:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785782800; cv=none; b=MDTCly5RstOBKYGX/iwCU6dl85GnlbIysVnCRzbzgw7U/rG4BDjZ8okNp9tRrL2okqWF+Pju2lwN9Qw06ZZ59ppEgraLPob/JX9joYeRKuHyMyp1Mm2SnpijEPsQrqyEMdKAppuFORlGoU844X3gb32yR0/cOB9370ASBHZPo+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785782800; c=relaxed/simple;
	bh=jbKjjaCQnP0pxgEOJNcMtgqJV0Fdpyc3gfnnGlCv9f8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PDRdsW2QukcrGzMs8kIpzGiqurN10ttAEwaQ62Wia8SkbBFSgsKA96YbgW6kop6TCnVsRrzEmMTpJwVmrNpNmi5ALMcLusvVm9exYFmdtrfS/VJZUZ+YXS44S8Gx/FdIBuNHC7ltXQvWtFklrmmYeUvFDugvcVcf0/0VnO7/KUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bPIzFhH7; arc=none smtp.client-ip=209.85.210.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bPIzFhH7"
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-8486ffba174so6803808b3a.1
        for <bpf@vger.kernel.org>; Mon, 03 Aug 2026 11:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785782794; x=1786387594; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=n6Z+knL/Vym2bTZhQ2MmdO9vfyLJl3tvT3HruMB1kzI=;
        b=bPIzFhH7wqDlPVpzCIOpOKoLGUgaKdHAovxzMFb1T1nuIr6I08SydH/kvr+BkEOc2O
         J62hneiDts2szA7j5+3VEhddlnZmWuKiYwajOfkAIoJBLOd1XUHMziDqqAbi3X3arL7f
         MN0UjXca9vIhRPyQizslhbcNjCWpndJZKemgczts82mONVrLL342Zghjl8mxHflqlKdm
         yo5CdO310AQjmtS8MhWKlpk6SOKUdTBehgjUD9/y5NYLRz5CzDsJK90043AuqMXWfWkO
         1aU+SsAMW52uIhF5XCls3EyBy1+HJBIxmYjuhclEksNpDdCSSlhYXhef6K5Dc7k4KMni
         Z41g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785782794; x=1786387594;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=n6Z+knL/Vym2bTZhQ2MmdO9vfyLJl3tvT3HruMB1kzI=;
        b=g+nQoA1HusO75UHxKlnKw8chS7KX8NvoMxzrgt0bZKpOFFBXyzJsG7jnzl27o2VpIP
         XS/q4lWMPs65GqEt23AP6CqZjdwEDD8YqQSMWmiU71g172lnmiZN0TxDYhoqEx4SqPsU
         fS0AAT1L1BBHHYgaEGTHscj2ZEKmk1v7qK/PZaRaM+0ZxH5QBh7yn8j0SuJInAqLf3/U
         mfSHHMZQytMmago/Aq4FEwwPjNMb+7I/Esyj7ecUnTliaid1zErY+jGEZri1NshZkwvB
         gLc78XxXSkLNFcHA/NrwXU08sS0Ar3mjtn7/Cu+JdPEHpVEGiyF86ztaTvf17d17L9hM
         sOBA==
X-Forwarded-Encrypted: i=1; AHgh+RoI6SfFg7frmI1m0HaWWnKKn6TC93gCelsrbrV8sF0d/qWQMHhchkS8ELCvCfHeCmIsBBI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFj5La61qYmXO3nAs/jmMZWLvjt0+FJpsvnu223KQVUOVhEWl5
	bnXoAjnmRs/YyN42s2dW1vXuJi6dSGsiOpPhkCJ+s22Eq34H9O+AmyUBl9f71US8a1TCpROWQHk
	HO0oMVoq6IiC0p2ucdwsR0SnzyQ==
X-Received: from pfbbx16.prod.google.com ([2002:a05:6a00:4290:b0:847:9199:e06])
 (user=hramamurthy job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:4fca:b0:848:2f6e:e532 with SMTP id d2e1a72fcca58-84ee48fb3f5mr9012046b3a.70.1785782794280;
 Mon, 03 Aug 2026 11:46:34 -0700 (PDT)
Date: Mon,  3 Aug 2026 18:46:17 +0000
In-Reply-To: <20260803184630.3813311-1-hramamurthy@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260803184630.3813311-1-hramamurthy@google.com>
X-Mailer: git-send-email 2.55.0.571.g244d577d93-goog
Message-ID: <20260803184630.3813311-3-hramamurthy@google.com>
Subject: [PATCH net-next v3 02/15] gve: refactor initialization with helper functions
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

In the interest of commonizing code, refactor gve_probe()
and gve_init_priv() with a few helper functions that can
be expanded and utilized in upcoming patches that add the
mailbox ABI to the driver. The helper functions are:

- gve_set_num_ntfy_blks()
- gve_set_num_queues()

Reorder code to combine lines that accomplish a similar objective
like setting defaults. Move setting HW-GRO and UDP GSO support out
of an Adminq method into gve_init_priv().

These changes are just code movement, no functional change.

Reviewed-by: Willem de Bruijn <willemb@google.com>
Reviewed-by: Jordan Rhee <jordanrhee@google.com>
Signed-off-by: Harshitha Ramamurthy <hramamurthy@google.com>
---
Changes in v3:
- ensure to call verify driver compatibility in reset path

 drivers/net/ethernet/google/gve/gve_adminq.c |   8 --
 drivers/net/ethernet/google/gve/gve_main.c   | 104 +++++++++++--------
 2 files changed, 63 insertions(+), 49 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve_adminq.c b/drivers/net/ethernet/google/gve/gve_adminq.c
index 70ffed8b52c3..dfeabddfb396 100644
--- a/drivers/net/ethernet/google/gve/gve_adminq.c
+++ b/drivers/net/ethernet/google/gve/gve_adminq.c
@@ -1117,14 +1117,6 @@ int gve_adminq_describe_device(struct gve_priv *priv)
 
 	gve_set_default_rss_sizes(priv);
 
-	/* DQO supports HW-GRO and UDP_GSO */
-	if (gve_is_dqo(priv)) {
-		u64 additional_features = NETIF_F_GRO_HW | NETIF_F_GSO_UDP_L4;
-
-		priv->dev->hw_features |= additional_features;
-		priv->dev->features |= additional_features;
-	}
-
 	priv->max_registered_pages =
 				be64_to_cpu(descriptor->max_registered_pages);
 	mtu = be16_to_cpu(descriptor->mtu);
diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
index 30bf6df4ebc5..6510aea62b92 100644
--- a/drivers/net/ethernet/google/gve/gve_main.c
+++ b/drivers/net/ethernet/google/gve/gve_main.c
@@ -2398,9 +2398,54 @@ static const struct xdp_metadata_ops gve_xdp_metadata_ops = {
 	.xmo_rx_timestamp	= gve_xdp_rx_timestamp,
 };
 
-static int gve_init_priv(struct gve_priv *priv, bool skip_describe_device)
+static int gve_set_num_ntfy_blks(struct gve_priv *priv)
 {
 	int num_ntfy;
+
+	num_ntfy = pci_msix_vec_count(priv->pdev);
+	if (num_ntfy <= 0) {
+		dev_err(&priv->pdev->dev,
+			"could not count MSI-x vectors: err=%d\n", num_ntfy);
+		return num_ntfy;
+	} else if (num_ntfy < GVE_MIN_MSIX) {
+		dev_err(&priv->pdev->dev, "gve needs at least %d MSI-x vectors, but only has %d\n",
+			GVE_MIN_MSIX, num_ntfy);
+		return -EINVAL;
+	}
+
+	/* gvnic has one Notification Block per MSI-x vector, except for the
+	 * management vector
+	 */
+	priv->num_ntfy_blks = (num_ntfy - 1) & ~0x1;
+	priv->mgmt_msix_idx = priv->num_ntfy_blks;
+
+	return 0;
+}
+
+static void gve_set_num_queues(struct gve_priv *priv)
+{
+	priv->tx_cfg.max_queues =
+		min_t(int, priv->tx_cfg.max_queues, priv->num_ntfy_blks / 2);
+	priv->rx_cfg.max_queues =
+		min_t(int, priv->rx_cfg.max_queues, priv->num_ntfy_blks / 2);
+
+	priv->tx_cfg.num_queues = priv->tx_cfg.max_queues;
+	priv->rx_cfg.num_queues = priv->rx_cfg.max_queues;
+	if (priv->default_num_queues > 0) {
+		priv->tx_cfg.num_queues = min_t(int, priv->default_num_queues,
+						priv->tx_cfg.num_queues);
+		priv->rx_cfg.num_queues = min_t(int, priv->default_num_queues,
+						priv->rx_cfg.num_queues);
+	}
+
+	dev_info(&priv->pdev->dev, "TX queues %d, RX queues %d\n",
+		 priv->tx_cfg.num_queues, priv->rx_cfg.num_queues);
+	dev_info(&priv->pdev->dev, "Max TX queues %d, Max RX queues %d\n",
+		 priv->tx_cfg.max_queues, priv->rx_cfg.max_queues);
+}
+
+static int gve_init_priv(struct gve_priv *priv, bool skip_describe_device)
+{
 	int err;
 
 	/* Set up the adminq */
@@ -2431,57 +2476,34 @@ static int gve_init_priv(struct gve_priv *priv, bool skip_describe_device)
 			"Could not get device information: err=%d\n", err);
 		goto err;
 	}
-	priv->dev->mtu = priv->dev->max_mtu;
-	num_ntfy = pci_msix_vec_count(priv->pdev);
-	if (num_ntfy <= 0) {
+
+	err = gve_set_num_ntfy_blks(priv);
+	if (err) {
 		dev_err(&priv->pdev->dev,
-			"could not count MSI-x vectors: err=%d\n", num_ntfy);
-		err = num_ntfy;
-		goto err;
-	} else if (num_ntfy < GVE_MIN_MSIX) {
-		dev_err(&priv->pdev->dev, "gve needs at least %d MSI-x vectors, but only has %d\n",
-			GVE_MIN_MSIX, num_ntfy);
-		err = -EINVAL;
+			"Could not setup notify blocks: err=%d\n", err);
 		goto err;
 	}
 
-	/* Big TCP is only supported on DQO */
-	if (!gve_is_gqi(priv))
-		netif_set_tso_max_size(priv->dev, GVE_DQO_TX_MAX);
-
-	priv->rx_copybreak = GVE_DEFAULT_RX_COPYBREAK;
-	/* gvnic has one Notification Block per MSI-x vector, except for the
-	 * management vector
-	 */
-	priv->num_ntfy_blks = (num_ntfy - 1) & ~0x1;
-	priv->mgmt_msix_idx = priv->num_ntfy_blks;
-	priv->numa_node = dev_to_node(&priv->pdev->dev);
-
-	priv->tx_cfg.max_queues =
-		min_t(int, priv->tx_cfg.max_queues, priv->num_ntfy_blks / 2);
-	priv->rx_cfg.max_queues =
-		min_t(int, priv->rx_cfg.max_queues, priv->num_ntfy_blks / 2);
+	gve_set_num_queues(priv);
 
-	priv->tx_cfg.num_queues = priv->tx_cfg.max_queues;
-	priv->rx_cfg.num_queues = priv->rx_cfg.max_queues;
-	if (priv->default_num_queues > 0) {
-		priv->tx_cfg.num_queues = min_t(int, priv->default_num_queues,
-						priv->tx_cfg.num_queues);
-		priv->rx_cfg.num_queues = min_t(int, priv->default_num_queues,
-						priv->rx_cfg.num_queues);
-	}
-	priv->tx_cfg.num_xdp_queues = 0;
+	if (gve_is_dqo(priv)) {
+		/* DQO supports HW-GRO and UDP_GSO */
+		u64 additional_features = NETIF_F_GRO_HW | NETIF_F_GSO_UDP_L4;
 
-	dev_info(&priv->pdev->dev, "TX queues %d, RX queues %d\n",
-		 priv->tx_cfg.num_queues, priv->rx_cfg.num_queues);
-	dev_info(&priv->pdev->dev, "Max TX queues %d, Max RX queues %d\n",
-		 priv->tx_cfg.max_queues, priv->rx_cfg.max_queues);
+		priv->dev->hw_features |= additional_features;
+		priv->dev->features |= additional_features;
 
-	if (!gve_is_gqi(priv)) {
 		priv->tx_coalesce_usecs = GVE_TX_IRQ_RATELIMIT_US_DQO;
 		priv->rx_coalesce_usecs = GVE_RX_IRQ_RATELIMIT_US_DQO;
+
+		/* Big TCP is only supported on DQO */
+		netif_set_tso_max_size(priv->dev, GVE_DQO_TX_MAX);
 	}
 
+	priv->dev->mtu = priv->dev->max_mtu;
+	priv->numa_node = dev_to_node(&priv->pdev->dev);
+	priv->tx_cfg.num_xdp_queues = 0;
+	priv->rx_copybreak = GVE_DEFAULT_RX_COPYBREAK;
 	priv->ts_config.tx_type = HWTSTAMP_TX_OFF;
 	priv->ts_config.rx_filter = HWTSTAMP_FILTER_NONE;
 
-- 
2.55.0.571.g244d577d93-goog

