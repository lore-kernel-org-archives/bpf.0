Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D3EF436BF8
	for <bpf@vger.kernel.org>; Mon,  3 Aug 2026 18:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785782802; cv=none; b=lUb0N5sTEiM2E1PVXACzLDXOtpmaum1IgCFF4PmJjutI2io9GJFIsrkyYd1jcEyAKU2SBIIYWReGcDy7JsieaCeV/eosY2pHp0VA8ECliWULukseWBPIam81S0QVmYTdyyH2A9qw5+q/WZw0TzwvZAKAq9x69lky8UG+oXmlb3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785782802; c=relaxed/simple;
	bh=h6xQGct/nhkoVeBbYmUudD+rEMij2bI8q98OiZMkgBk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FaBvFMyHVEAerSCR5PTIoVZE7X7hDSYA5qnEcxMw8nvmCtQ7Q6J213f3H2pHyA4fLgdN/OVutjGcA/Z+H81Cd+MYEObXtFIl2mUBU5Az9dByNnxbi+84QXjPgYPEw14WI5rzGZLMYDQK4dWaLmkujU+SuxeNmN98HldV6mISkkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rNuCxLJv; arc=none smtp.client-ip=209.85.210.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rNuCxLJv"
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-8488ac68185so9626707b3a.2
        for <bpf@vger.kernel.org>; Mon, 03 Aug 2026 11:46:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785782798; x=1786387598; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HfUfOCq7/2QIqfYje0VU1xxGfohZ1YP9PuYwb3/VuQM=;
        b=rNuCxLJvdOWlqZFzGY/AacGwtj/icfh9QGhIJxegUvLVajk0g2lH9eqVidFW1cNkCE
         hfZ6rXtsCoOA+0KnlH7K2y1y/B/0Zyou7+Ko9LIpkNWoXqT+yimeroFl2747+gI9cCoP
         2TU26/Piin2clBEVtWFsBQm5M1o0EWzq0ZxT0UTd+JyRRaCjDCNS+K4QvUmniPsRwkuT
         nzmDOanDUae1b8sUR741SGhl7C4A8oFrlL0uHXhsga22YViY0oEQDIe82qnYnjqpMOMs
         0ZJSYE3pHSEKzy9dbg1vYfhwsC0sWErF8DA7SsnuIjJVxyi0IQ1ONx7efUaKqKjaJGK3
         B7+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785782798; x=1786387598;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HfUfOCq7/2QIqfYje0VU1xxGfohZ1YP9PuYwb3/VuQM=;
        b=Pcz/ht3VJhm6wzs2DJshE9cyRE4fERkvKtQ7k8AbO7zjPZCtNC0LMjrlbYQvhRx4mX
         3Nr4vZIbb9qxlFK5jT8N6zIZd5WXnolSUGg1uA92YMnXI7+pVWcIYgKBSKU/AmiOFNmW
         YH/6SKivmji52QCS66P+15WCpOnHgRBQiZC13rtDjMsYhm6l2/+S928g1YMyle6auT/R
         T+H7GhzLWWfHD7+E3ggCiiyN+pt8q63+S3dMptbNQxJvAK0turj5tFJ/BjwLz80GGHHW
         YMIvyrbHImBdBzOs3DP07ggBDkuAMYps7b7C0COtMU/PHU+EAzWiZxaMC+nVzzQoGyC4
         RRuA==
X-Forwarded-Encrypted: i=1; AHgh+RomJInD/P9+/1tqBRQ+2kOj4QV/8FdigHmnL0YCpLuB0N3eSxoz5UIGo7xHoq87IE7lrFU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8ONWO2VWeUR4uSnl6DgAfdXeLSPoZipQX6BKb014ZcapKj+8N
	R3lF9+8ODvFZWOHAe63BA0JrRcY83e5yooOJmYx6B+iUzUuv3MpD3YkwEPI628A4ejcFBP9Hrtx
	DBcSRvfHOG2VDPI82uR8Cq0PYmQ==
X-Received: from pgif14.prod.google.com ([2002:a63:f10e:0:b0:c85:735b:ca4a])
 (user=hramamurthy job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:180f:b0:845:ebe2:c656 with SMTP id d2e1a72fcca58-84ee49549eemr9477099b3a.47.1785782797639;
 Mon, 03 Aug 2026 11:46:37 -0700 (PDT)
Date: Mon,  3 Aug 2026 18:46:21 +0000
In-Reply-To: <20260803184630.3813311-1-hramamurthy@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260803184630.3813311-1-hramamurthy@google.com>
X-Mailer: git-send-email 2.55.0.571.g244d577d93-goog
Message-ID: <20260803184630.3813311-7-hramamurthy@google.com>
Subject: [PATCH net-next v3 06/15] gve: introduce ctrl ops to set vectors and Qs
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

Introduce following ctrl ops for Adminq mode. This change does
not introduce any functional change, just movement of code into
ops.

- set_num_queues to set maximum and default TX/RX queues in the
  alloc structures used in the initialization flow.
- set_num_ntfy_blks op to set number of vectors(ntfy_blks) in the
  initialization flow.

Reviewed-by: Willem de Bruijn <willemb@google.com>
Reviewed-by: Jordan Rhee <jordanrhee@google.com>
Signed-off-by: Harshitha Ramamurthy <hramamurthy@google.com>
---
 drivers/net/ethernet/google/gve/gve.h        |  6 ++
 drivers/net/ethernet/google/gve/gve_adminq.c | 45 ++++++++++++++
 drivers/net/ethernet/google/gve/gve_adminq.h |  2 +
 drivers/net/ethernet/google/gve/gve_main.c   | 64 +++-----------------
 4 files changed, 63 insertions(+), 54 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve.h b/drivers/net/ethernet/google/gve/gve.h
index 56148ea3cfbf..1bc5e32b6618 100644
--- a/drivers/net/ethernet/google/gve/gve.h
+++ b/drivers/net/ethernet/google/gve/gve.h
@@ -829,10 +829,16 @@ struct gve_device_info {
  * struct gve_ctrl_ops - Control plane operations structure
  * @map_db_bar: Maps the doorbell BAR for the device and store in @priv.
  * @unmap_db_bar: Unmaps the doorbell BAR previously mapped by @map_db_bar.
+ * @set_num_queues: Sets default and max TX/RX queues into allocation
+ *                  structures stored in @priv to be used during initialization.
+ * @set_num_ntfy_blks: Sets no. of vectors into @priv to be used during
+ *                     initialization.
  */
 struct gve_ctrl_ops {
 	int (*map_db_bar)(struct gve_priv *priv);
 	void (*unmap_db_bar)(struct gve_priv *priv);
+	void (*set_num_queues)(struct gve_priv *priv);
+	int (*set_num_ntfy_blks)(struct gve_priv *priv);
 };
 
 struct gve_priv {
diff --git a/drivers/net/ethernet/google/gve/gve_adminq.c b/drivers/net/ethernet/google/gve/gve_adminq.c
index 9c3ebdb547cf..1d9ae601cdeb 100644
--- a/drivers/net/ethernet/google/gve/gve_adminq.c
+++ b/drivers/net/ethernet/google/gve/gve_adminq.c
@@ -1612,3 +1612,48 @@ void gve_adminq_unmap_db_bar(struct gve_priv *priv)
 
 	pci_iounmap(pdev, priv->db_bar2);
 }
+
+int gve_adminq_set_num_ntfy_blks(struct gve_priv *priv)
+{
+	int num_ntfy;
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
+void gve_adminq_set_num_queues(struct gve_priv *priv)
+{
+	struct gve_device_info *device_info = &priv->device_info;
+
+	priv->tx_cfg.max_queues =
+		min_t(int, priv->tx_cfg.max_queues, priv->num_ntfy_blks / 2);
+	priv->rx_cfg.max_queues =
+		min_t(int, priv->rx_cfg.max_queues, priv->num_ntfy_blks / 2);
+
+	priv->tx_cfg.num_queues = priv->tx_cfg.max_queues;
+	priv->rx_cfg.num_queues = priv->rx_cfg.max_queues;
+	if (device_info->default_tx_queues > 0)
+		priv->tx_cfg.num_queues = min_t(int,
+						device_info->default_tx_queues,
+						priv->tx_cfg.num_queues);
+	if (device_info->default_rx_queues > 0)
+		priv->rx_cfg.num_queues = min_t(int,
+						device_info->default_rx_queues,
+						priv->rx_cfg.num_queues);
+}
diff --git a/drivers/net/ethernet/google/gve/gve_adminq.h b/drivers/net/ethernet/google/gve/gve_adminq.h
index 2a184e051202..52fe4a9f7b87 100644
--- a/drivers/net/ethernet/google/gve/gve_adminq.h
+++ b/drivers/net/ethernet/google/gve/gve_adminq.h
@@ -658,5 +658,7 @@ int gve_adminq_get_ptype_map_dqo(struct gve_priv *priv,
 				 struct gve_ptype_lut *ptype_lut);
 int gve_adminq_map_db_bar(struct gve_priv *priv);
 void gve_adminq_unmap_db_bar(struct gve_priv *priv);
+int gve_adminq_set_num_ntfy_blks(struct gve_priv *priv);
+void gve_adminq_set_num_queues(struct gve_priv *priv);
 
 #endif /* _GVE_ADMINQ_H */
diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
index fff63b90dcbb..ce55f845a6f9 100644
--- a/drivers/net/ethernet/google/gve/gve_main.c
+++ b/drivers/net/ethernet/google/gve/gve_main.c
@@ -2398,56 +2398,6 @@ static const struct xdp_metadata_ops gve_xdp_metadata_ops = {
 	.xmo_rx_timestamp	= gve_xdp_rx_timestamp,
 };
 
-static int gve_set_num_ntfy_blks(struct gve_priv *priv)
-{
-	int num_ntfy;
-
-	num_ntfy = pci_msix_vec_count(priv->pdev);
-	if (num_ntfy <= 0) {
-		dev_err(&priv->pdev->dev,
-			"could not count MSI-x vectors: err=%d\n", num_ntfy);
-		return num_ntfy;
-	} else if (num_ntfy < GVE_MIN_MSIX) {
-		dev_err(&priv->pdev->dev, "gve needs at least %d MSI-x vectors, but only has %d\n",
-			GVE_MIN_MSIX, num_ntfy);
-		return -EINVAL;
-	}
-
-	/* gvnic has one Notification Block per MSI-x vector, except for the
-	 * management vector
-	 */
-	priv->num_ntfy_blks = (num_ntfy - 1) & ~0x1;
-	priv->mgmt_msix_idx = priv->num_ntfy_blks;
-
-	return 0;
-}
-
-static void gve_set_num_queues(struct gve_priv *priv)
-{
-	struct gve_device_info *device_info = &priv->device_info;
-
-	priv->tx_cfg.max_queues =
-		min_t(int, priv->tx_cfg.max_queues, priv->num_ntfy_blks / 2);
-	priv->rx_cfg.max_queues =
-		min_t(int, priv->rx_cfg.max_queues, priv->num_ntfy_blks / 2);
-
-	priv->tx_cfg.num_queues = priv->tx_cfg.max_queues;
-	priv->rx_cfg.num_queues = priv->rx_cfg.max_queues;
-	if (device_info->default_tx_queues > 0)
-		priv->tx_cfg.num_queues = min_t(int,
-						device_info->default_tx_queues,
-						priv->tx_cfg.num_queues);
-	if (device_info->default_rx_queues > 0)
-		priv->rx_cfg.num_queues = min_t(int,
-						device_info->default_rx_queues,
-						priv->rx_cfg.num_queues);
-
-	dev_info(&priv->pdev->dev, "TX queues %d, RX queues %d\n",
-		 priv->tx_cfg.num_queues, priv->rx_cfg.num_queues);
-	dev_info(&priv->pdev->dev, "Max TX queues %d, Max RX queues %d\n",
-		 priv->tx_cfg.max_queues, priv->rx_cfg.max_queues);
-}
-
 static void gve_set_desc_cnt(struct gve_priv *priv)
 {
 	struct gve_device_info *device_info = &priv->device_info;
@@ -2509,8 +2459,10 @@ static void gve_set_buf_sizes(struct gve_priv *priv)
 }
 
 static const struct gve_ctrl_ops gve_adminq_ops = {
-	.map_db_bar	 = gve_adminq_map_db_bar,
-	.unmap_db_bar	 = gve_adminq_unmap_db_bar,
+	.map_db_bar		= gve_adminq_map_db_bar,
+	.unmap_db_bar		= gve_adminq_unmap_db_bar,
+	.set_num_queues		= gve_adminq_set_num_queues,
+	.set_num_ntfy_blks	= gve_adminq_set_num_ntfy_blks,
 };
 
 static int gve_init_priv(struct gve_priv *priv, bool skip_describe_device)
@@ -2549,14 +2501,18 @@ static int gve_init_priv(struct gve_priv *priv, bool skip_describe_device)
 
 	priv->queue_format = priv->device_info.queue_format;
 
-	err = gve_set_num_ntfy_blks(priv);
+	err = priv->ctrl_ops->set_num_ntfy_blks(priv);
 	if (err) {
 		dev_err(&priv->pdev->dev,
 			"Could not setup notify blocks: err=%d\n", err);
 		goto err;
 	}
 
-	gve_set_num_queues(priv);
+	priv->ctrl_ops->set_num_queues(priv);
+	dev_info(&priv->pdev->dev, "TX queues %d, RX queues %d\n",
+		 priv->tx_cfg.num_queues, priv->rx_cfg.num_queues);
+	dev_info(&priv->pdev->dev, "Max TX queues %d, Max RX queues %d\n",
+		 priv->tx_cfg.max_queues, priv->rx_cfg.max_queues);
 
 	if (gve_is_dqo(priv)) {
 		/* DQO supports HW-GRO and UDP_GSO */
-- 
2.55.0.571.g244d577d93-goog

