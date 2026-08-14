Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F5E43D7A07
	for <bpf@vger.kernel.org>; Fri, 14 Aug 2026 02:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786673656; cv=none; b=Jppcpc5d6p+SGWcOcPWHPv9yNbN7BFY0+Dg5OYSWV+72pZK49VSPAssQ/hjZa8u+GEGIS6yMCg2t5eZO+Gm9IOxlySBP2rxN6n5GC+2Xo8voGtjVh0WfNAgnjJQYEy24PQXtNqS7p1E7KMedYxJbOKdKIYsAk0/ZkI2vgWDb/DQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786673656; c=relaxed/simple;
	bh=DEpv/MGneuehFAo0VsMRN5K8MSsz0FGILv5QeaJRt3Y=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ozWcA+g7C09Tl5LrT3FnUn83i2UkeJfblD2yCLWRdvTlHAWpktDVuWbOvKqDbgCkjzZ8zq8P2Aeb5K0EE66xytksQHabcTWwyRGdvkZCoQK+JllNBHYTeSqvkJNVbS469mcc/S2KTfQHVe8yFJcusmgxlz0whq6u7myfxZhTAUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=k/3kiNSl; arc=none smtp.client-ip=209.85.210.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="k/3kiNSl"
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-8484ba00601so445944b3a.1
        for <bpf@vger.kernel.org>; Thu, 13 Aug 2026 19:14:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786673653; x=1787278453; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6G24MIyWAtQWdwpz6/fmx+JplW+QI9ucp5D1qb1r0j8=;
        b=k/3kiNSlSK2y9uld2Q6/1fUPW7UYDQq5WNe4tP8uFQ5hBhGk5KLrGK4UFBSmCUAoKc
         pw2O9wQVCgyLMp1Wio17yIPDaiS7urd+MGwHf3e7+kMkZOIwziKBBT6LlRQa6YydxYHR
         s4WexoSyIK8/w/JfY/6VCaao1cibSD/l4GgKmtp7KdO4vNpA2lKgJc4mu8AxbH8W7opI
         sS78qOOVLlXRFoBYLEPRCKw1wnEZ15YoYbGk0Dqct4H/FhRR9tO2HmxRuwOx004yQGOf
         YRC8y/31ttVFjWC8OjwhAXfvNmYCz6dFVLzmICAaLD2LC0hQvA4qVhrpBqpvrWfMFbMM
         /idg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786673653; x=1787278453;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6G24MIyWAtQWdwpz6/fmx+JplW+QI9ucp5D1qb1r0j8=;
        b=kD8FDtC7wlJKH9YNMBwdyg1ckFBM+3drn6pCT1pMFrmqr/70ngCR4yYBoWxjI4OKM3
         R3wfTvB8JhsonA+/Nuk7VsCAIgXEYovBfm3V1QVNG+kU6po0BNgDEwCztobMmfqIXRd0
         xu5laVgwxd8ESNtQ5bTBby5KS+BMF3qHwXDaegiGVxsMzo8+p4azsRxQ707zn0q2lV3f
         cf4qtnr8QMWRyTMqI/y+dOrfIbWnEJii5IUzXrmDQpXCQqI2cZYwj6NCV5r6h/Em2Qzt
         D8DdhdzdX2DS4PVFuZYrdJhMe4M7sl/LpXCcW8piBainbtXkD5RiVC6oSUrMG8QH+u2O
         gAyA==
X-Forwarded-Encrypted: i=1; AHgh+Rp5224y9FC8cJScc0FssW15GQYNsYqFmIDzKsFt0zUqstuN7/lIQ1l8eCNEHjAthcuuWTI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJNHvkP3/tXlEmvNclJPr7Bddqq3o3nmb/GvX0UmdIaYtSFBSf
	E83e9/lBcOTQOygiXv9MEGChqHR2ItZwS3r5VTJjK8Q/ptdESarq67Sc1hW8F1tC9QvACiNVRw/
	cex9gPZVETaDqmfNnTblgVUO1zw==
X-Received: from pfbbw6.prod.google.com ([2002:a05:6a00:4086:b0:84a:3b83:9673])
 (user=hramamurthy job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:4395:b0:845:31a6:d84d with SMTP id d2e1a72fcca58-84fde14ffecmr2512510b3a.7.1786673652429;
 Thu, 13 Aug 2026 19:14:12 -0700 (PDT)
Date: Fri, 14 Aug 2026 02:13:54 +0000
In-Reply-To: <20260814021406.3044324-1-hramamurthy@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260814021406.3044324-1-hramamurthy@google.com>
X-Mailer: git-send-email 2.55.0.691.gc56d675ccc-goog
Message-ID: <20260814021406.3044324-5-hramamurthy@google.com>
Subject: [PATCH net-next v4 04/15] gve: add struct gve_device_info to hold
 device properties
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

In the current AdminQ mode, device properties are written into
struct gve_device_descriptor that is allocated in shared memory
between the driver and device. In the upcoming MailboxQ mode,
these properties will be returned in the response of a mailbox
message. Hence, add struct gve_device_info as the structure that
holds all the properties that are negotiated with the device in
either mode.

Change the AdminQ mode method gve_adminq_describe_device()
and its children to fill up device information into this newly
introduced struct gve_device_info. Move a few helper functions
and code that set device properties in the priv structure into
gve_init_priv(). So now gve_init_priv() calls/does the following:

- gve_set_mtu()
- gve_set_mac()
- gve_set_queue_properties()
- gve_set_buf_sizes()
- set flow steering and RSS properties
- set other priv properties

When MailboxQ support is added, device information will be filled
into the same structure and the same gve_init_priv() path would be
used to set device properties to ensure common code reusage.

These changes are refactors only, no functional change.

Reviewed-by: Willem de Bruijn <willemb@google.com>
Reviewed-by: Jordan Rhee <jordanrhee@google.com>
Signed-off-by: Harshitha Ramamurthy <hramamurthy@google.com>
---
v4:
- reuse mtu variable
v3:
- Read default_min_ring_size from device info instead of priv

 drivers/net/ethernet/google/gve/gve.h        |  29 +++++
 drivers/net/ethernet/google/gve/gve_adminq.c | 115 +++++++++++--------
 drivers/net/ethernet/google/gve/gve_adminq.h |   6 -
 drivers/net/ethernet/google/gve/gve_main.c   |  86 ++++++++++----
 4 files changed, 160 insertions(+), 76 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve.h b/drivers/net/ethernet/google/gve/gve.h
index c280ff35ee77..021adb9108df 100644
--- a/drivers/net/ethernet/google/gve/gve.h
+++ b/drivers/net/ethernet/google/gve/gve.h
@@ -797,6 +797,34 @@ struct gve_ptp {
 	struct gve_priv *priv;
 };
 
+struct gve_device_info {
+	enum gve_queue_format queue_format;
+	u16 default_tx_queues;
+	u16 default_rx_queues;
+	u16 max_tx_queues;
+	u16 max_rx_queues;
+	u16 default_tx_ring_size;
+	u16 default_rx_ring_size;
+	u16 max_tx_ring_size;
+	u16 max_rx_ring_size;
+	u16 min_tx_ring_size;
+	u16 min_rx_ring_size;
+	u16 max_mtu;
+	u8 mac[ETH_ALEN];
+	u16 max_rx_buffer_size;
+	u16 header_buf_size;
+	u32 max_flow_rules;
+	u16 rss_key_size;
+	u16 rss_lut_size;
+	u16 tx_pages_per_qpl;
+	u16 num_event_counters;
+	u64 max_registered_pages;
+	bool default_min_ring_size;
+	bool nic_timestamp_supported;
+	bool modify_ring_size_enabled;
+	bool cache_rss_config;
+};
+
 struct gve_priv {
 	struct net_device *dev;
 	struct gve_tx_ring *tx; /* array of tx_cfg.num_queues */
@@ -929,6 +957,7 @@ struct gve_priv {
 	struct gve_nic_ts_report *nic_ts_report;
 	dma_addr_t nic_ts_report_bus;
 	u64 last_sync_nic_counter; /* Clock counter from last NIC TS report */
+	struct gve_device_info device_info;
 };
 
 enum gve_service_task_flags_bit {
diff --git a/drivers/net/ethernet/google/gve/gve_adminq.c b/drivers/net/ethernet/google/gve/gve_adminq.c
index 8156c6f8c3b0..3fc35cc98200 100644
--- a/drivers/net/ethernet/google/gve/gve_adminq.c
+++ b/drivers/net/ethernet/google/gve/gve_adminq.c
@@ -70,7 +70,7 @@ void gve_parse_device_option(struct gve_priv *priv,
 
 		dev_info(&priv->pdev->dev,
 			 "Gqi raw addressing device option enabled.\n");
-		priv->queue_format = GVE_GQI_RDA_FORMAT;
+		priv->device_info.queue_format = GVE_GQI_RDA_FORMAT;
 		break;
 	case GVE_DEV_OPT_ID_GQI_RDA:
 		if (option_length < sizeof(**dev_op_gqi_rda) ||
@@ -190,7 +190,7 @@ void gve_parse_device_option(struct gve_priv *priv,
 
 		/* device has not provided min ring size */
 		if (option_length == GVE_DEVICE_OPTION_NO_MIN_RING_SIZE)
-			priv->default_min_ring_size = true;
+			priv->device_info.default_min_ring_size = true;
 		break;
 	case GVE_DEV_OPT_ID_FLOW_STEERING:
 		if (option_length < sizeof(**dev_op_flow_steering) ||
@@ -922,10 +922,13 @@ int gve_adminq_destroy_rx_queues(struct gve_priv *priv, u32 num_queues)
 
 static void gve_set_default_rss_sizes(struct gve_priv *priv)
 {
-	if (!gve_is_gqi(priv)) {
-		priv->rss_key_size = GVE_RSS_KEY_SIZE;
-		priv->rss_lut_size = GVE_RSS_INDIR_SIZE;
-		priv->cache_rss_config = true;
+	struct gve_device_info *device_info = &priv->device_info;
+
+	if (device_info->queue_format == GVE_DQO_RDA_FORMAT ||
+	    device_info->queue_format == GVE_DQO_QPL_FORMAT) {
+		device_info->rss_key_size = GVE_RSS_KEY_SIZE;
+		device_info->rss_lut_size = GVE_RSS_INDIR_SIZE;
+		device_info->cache_rss_config = true;
 	}
 }
 
@@ -946,77 +949,105 @@ static void gve_enable_supported_features(struct gve_priv *priv,
 					  const struct gve_device_option_modify_ring
 					  *dev_op_modify_ring)
 {
+	struct gve_device_info *info = &priv->device_info;
+
 	/* Before control reaches this point, the page-size-capped max MTU from
 	 * the gve_device_descriptor field has already been stored in
-	 * priv->dev->max_mtu. We overwrite it with the true max MTU below.
+	 * device_info->max_mtu. We overwrite it with the true max MTU below.
 	 */
 	if (dev_op_jumbo_frames &&
 	    (supported_features_mask & GVE_SUP_JUMBO_FRAMES_MASK)) {
 		dev_info(&priv->pdev->dev,
 			 "JUMBO FRAMES device option enabled.\n");
-		priv->dev->max_mtu = be16_to_cpu(dev_op_jumbo_frames->max_mtu);
+		info->max_mtu = be16_to_cpu(dev_op_jumbo_frames->max_mtu);
 	}
 
 	if (dev_op_buffer_sizes &&
 	    (supported_features_mask & GVE_SUP_BUFFER_SIZES_MASK)) {
-		priv->max_rx_buffer_size =
+		info->max_rx_buffer_size =
 			be16_to_cpu(dev_op_buffer_sizes->packet_buffer_size);
-		priv->header_buf_size =
+		info->header_buf_size =
 			be16_to_cpu(dev_op_buffer_sizes->header_buffer_size);
 		dev_info(&priv->pdev->dev,
 			 "BUFFER SIZES device option enabled with max_rx_buffer_size of %u, header_buf_size of %u.\n",
-			 priv->max_rx_buffer_size, priv->header_buf_size);
-		if (gve_is_dqo(priv) &&
-		    priv->max_rx_buffer_size > GVE_DEFAULT_RX_BUFFER_SIZE)
-			priv->rx_cfg.packet_buffer_size =
-				priv->max_rx_buffer_size;
+			 info->max_rx_buffer_size, info->header_buf_size);
 	}
 
 	/* Read and store ring size ranges given by device */
 	if (dev_op_modify_ring &&
 	    (supported_features_mask & GVE_SUP_MODIFY_RING_MASK)) {
-		priv->modify_ring_size_enabled = true;
-		priv->max_rx_desc_cnt =
+		info->modify_ring_size_enabled = true;
+		info->max_rx_ring_size =
 			be16_to_cpu(dev_op_modify_ring->max_rx_ring_size);
-		priv->max_tx_desc_cnt =
+		info->max_tx_ring_size =
 			be16_to_cpu(dev_op_modify_ring->max_tx_ring_size);
-		if (priv->default_min_ring_size) {
+		if (info->default_min_ring_size) {
 			/* If device hasn't provided minimums, use default minimums */
-			priv->min_tx_desc_cnt = GVE_DEFAULT_MIN_TX_RING_SIZE;
-			priv->min_rx_desc_cnt = GVE_DEFAULT_MIN_RX_RING_SIZE;
+			info->min_tx_ring_size = GVE_DEFAULT_MIN_TX_RING_SIZE;
+			info->min_rx_ring_size = GVE_DEFAULT_MIN_RX_RING_SIZE;
 		} else {
-			priv->min_rx_desc_cnt = be16_to_cpu(dev_op_modify_ring->min_rx_ring_size);
-			priv->min_tx_desc_cnt = be16_to_cpu(dev_op_modify_ring->min_tx_ring_size);
+			info->min_rx_ring_size =
+				be16_to_cpu(dev_op_modify_ring->min_rx_ring_size);
+			info->min_tx_ring_size =
+				be16_to_cpu(dev_op_modify_ring->min_tx_ring_size);
 		}
 	}
 
 	if (dev_op_flow_steering &&
 	    (supported_features_mask & GVE_SUP_FLOW_STEERING_MASK)) {
 		if (dev_op_flow_steering->max_flow_rules) {
-			priv->max_flow_rules =
+			info->max_flow_rules =
 				be32_to_cpu(dev_op_flow_steering->max_flow_rules);
-			priv->dev->hw_features |= NETIF_F_NTUPLE;
 			dev_info(&priv->pdev->dev,
 				 "FLOW STEERING device option enabled with max rule limit of %u.\n",
-				 priv->max_flow_rules);
+				 info->max_flow_rules);
 		}
 	}
 
 	if (dev_op_rss_config &&
 	    (supported_features_mask & GVE_SUP_RSS_CONFIG_MASK)) {
-		priv->rss_key_size =
+		info->rss_key_size =
 			be16_to_cpu(dev_op_rss_config->hash_key_size);
-		priv->rss_lut_size =
+		info->rss_lut_size =
 			be16_to_cpu(dev_op_rss_config->hash_lut_size);
-		priv->cache_rss_config = false;
+		info->cache_rss_config = false;
 		dev_dbg(&priv->pdev->dev,
 			"RSS device option enabled with key size of %u, lut size of %u.\n",
-			priv->rss_key_size, priv->rss_lut_size);
+			info->rss_key_size, info->rss_lut_size);
 	}
 
 	if (dev_op_nic_timestamp &&
 	    (supported_features_mask & GVE_SUP_NIC_TIMESTAMP_MASK))
-		priv->nic_timestamp_supported = true;
+		info->nic_timestamp_supported = true;
+}
+
+static void gve_fill_device_info(struct gve_priv *priv,
+				 struct gve_device_descriptor *descriptor)
+{
+	struct gve_device_info *device_info = &priv->device_info;
+	u16 default_num_queues;
+
+	device_info->tx_pages_per_qpl =
+				be16_to_cpu(descriptor->tx_pages_per_qpl);
+	device_info->max_registered_pages =
+				be64_to_cpu(descriptor->max_registered_pages);
+	device_info->num_event_counters = be16_to_cpu(descriptor->counters);
+	ether_addr_copy(device_info->mac, descriptor->mac);
+	device_info->max_mtu =  be16_to_cpu(descriptor->mtu);
+
+	default_num_queues = be16_to_cpu(descriptor->default_num_queues);
+	device_info->default_tx_queues = default_num_queues;
+	device_info->default_rx_queues = default_num_queues;
+	device_info->default_tx_ring_size =
+				be16_to_cpu(descriptor->tx_queue_entries);
+	device_info->default_rx_ring_size =
+				be16_to_cpu(descriptor->rx_queue_entries);
+
+	/* set default ranges */
+	device_info->max_tx_ring_size = device_info->default_tx_ring_size;
+	device_info->max_rx_ring_size = device_info->default_rx_ring_size;
+	device_info->min_tx_ring_size = device_info->default_tx_ring_size;
+	device_info->min_rx_ring_size = device_info->default_rx_ring_size;
 }
 
 int gve_adminq_describe_device(struct gve_priv *priv)
@@ -1027,6 +1058,7 @@ int gve_adminq_describe_device(struct gve_priv *priv)
 	struct gve_device_option_jumbo_frames *dev_op_jumbo_frames = NULL;
 	struct gve_device_option_modify_ring *dev_op_modify_ring = NULL;
 	struct gve_device_option_rss_config *dev_op_rss_config = NULL;
+	struct gve_device_info *device_info = &priv->device_info;
 	struct gve_device_option_gqi_rda *dev_op_gqi_rda = NULL;
 	struct gve_device_option_gqi_qpl *dev_op_gqi_qpl = NULL;
 	struct gve_device_option_dqo_rda *dev_op_dqo_rda = NULL;
@@ -1070,26 +1102,26 @@ int gve_adminq_describe_device(struct gve_priv *priv)
 	 * DqoRda, DqoQpl, GqiRda, GqiQpl. Use GqiQpl as default.
 	 */
 	if (dev_op_dqo_rda) {
-		priv->queue_format = GVE_DQO_RDA_FORMAT;
+		device_info->queue_format = GVE_DQO_RDA_FORMAT;
 		dev_info(&priv->pdev->dev,
 			 "Driver is running with DQO RDA queue format.\n");
 		supported_features_mask =
 			be32_to_cpu(dev_op_dqo_rda->supported_features_mask);
 	} else if (dev_op_dqo_qpl) {
-		priv->queue_format = GVE_DQO_QPL_FORMAT;
+		device_info->queue_format = GVE_DQO_QPL_FORMAT;
 		supported_features_mask =
 			be32_to_cpu(dev_op_dqo_qpl->supported_features_mask);
 	}  else if (dev_op_gqi_rda) {
-		priv->queue_format = GVE_GQI_RDA_FORMAT;
+		device_info->queue_format = GVE_GQI_RDA_FORMAT;
 		dev_info(&priv->pdev->dev,
 			 "Driver is running with GQI RDA queue format.\n");
 		supported_features_mask =
 			be32_to_cpu(dev_op_gqi_rda->supported_features_mask);
-	} else if (priv->queue_format == GVE_GQI_RDA_FORMAT) {
+	} else if (device_info->queue_format == GVE_GQI_RDA_FORMAT) {
 		dev_info(&priv->pdev->dev,
 			 "Driver is running with GQI RDA queue format.\n");
 	} else {
-		priv->queue_format = GVE_GQI_QPL_FORMAT;
+		device_info->queue_format = GVE_GQI_QPL_FORMAT;
 		if (dev_op_gqi_qpl)
 			supported_features_mask =
 				be32_to_cpu(dev_op_gqi_qpl->supported_features_mask);
@@ -1097,18 +1129,9 @@ int gve_adminq_describe_device(struct gve_priv *priv)
 			 "Driver is running with GQI QPL queue format.\n");
 	}
 
+	gve_fill_device_info(priv, descriptor);
 	gve_set_default_rss_sizes(priv);
 
-	err = gve_set_mtu(priv, descriptor);
-	if (err)
-		goto free_device_descriptor;
-
-	priv->num_event_counters = be16_to_cpu(descriptor->counters);
-
-	gve_set_mac(priv, descriptor);
-
-	gve_set_queue_properties(priv, descriptor);
-
 	gve_enable_supported_features(priv, supported_features_mask,
 				      dev_op_jumbo_frames, dev_op_dqo_qpl,
 				      dev_op_buffer_sizes, dev_op_flow_steering,
diff --git a/drivers/net/ethernet/google/gve/gve_adminq.h b/drivers/net/ethernet/google/gve/gve_adminq.h
index 68c63ce75505..a17af755b454 100644
--- a/drivers/net/ethernet/google/gve/gve_adminq.h
+++ b/drivers/net/ethernet/google/gve/gve_adminq.h
@@ -658,10 +658,4 @@ int gve_adminq_get_ptype_map_dqo(struct gve_priv *priv,
 				 struct gve_ptype_lut *ptype_lut);
 int gve_set_num_ntfy_blks(struct gve_priv *priv);
 void gve_set_num_queues(struct gve_priv *priv);
-void gve_set_queue_properties(struct gve_priv *priv,
-			      struct gve_device_descriptor *descriptor);
-int gve_set_mtu(struct gve_priv *priv,
-		struct gve_device_descriptor *descriptor);
-void gve_set_mac(struct gve_priv *priv,
-		 struct gve_device_descriptor *descriptor);
 #endif /* _GVE_ADMINQ_H */
diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
index dc6c2d08540f..792c9b281185 100644
--- a/drivers/net/ethernet/google/gve/gve_main.c
+++ b/drivers/net/ethernet/google/gve/gve_main.c
@@ -2398,57 +2398,71 @@ static const struct xdp_metadata_ops gve_xdp_metadata_ops = {
 	.xmo_rx_timestamp	= gve_xdp_rx_timestamp,
 };
 
-static void gve_set_default_desc_cnt(struct gve_priv *priv,
-				     const struct gve_device_descriptor *descriptor)
+static void gve_set_desc_cnt(struct gve_priv *priv)
 {
-	priv->tx_desc_cnt = be16_to_cpu(descriptor->tx_queue_entries);
-	priv->rx_desc_cnt = be16_to_cpu(descriptor->rx_queue_entries);
+	struct gve_device_info *device_info = &priv->device_info;
 
-	/* set default ranges */
-	priv->max_tx_desc_cnt = priv->tx_desc_cnt;
-	priv->max_rx_desc_cnt = priv->rx_desc_cnt;
-	priv->min_tx_desc_cnt = priv->tx_desc_cnt;
-	priv->min_rx_desc_cnt = priv->rx_desc_cnt;
+	priv->tx_desc_cnt = device_info->default_tx_ring_size;
+	priv->rx_desc_cnt = device_info->default_rx_ring_size;
+	priv->max_tx_desc_cnt = device_info->max_tx_ring_size;
+	priv->max_rx_desc_cnt = device_info->max_rx_ring_size;
+	priv->min_tx_desc_cnt = device_info->min_tx_ring_size;
+	priv->min_rx_desc_cnt = device_info->min_rx_ring_size;
 }
 
-void gve_set_queue_properties(struct gve_priv *priv,
-			      struct gve_device_descriptor *descriptor)
+static void gve_set_queue_properties(struct gve_priv *priv)
 {
-	/* set default descriptor counts */
-	gve_set_default_desc_cnt(priv, descriptor);
+	struct gve_device_info *device_info = &priv->device_info;
 
-	priv->max_registered_pages = be64_to_cpu(descriptor->max_registered_pages);
-	priv->tx_pages_per_qpl = be16_to_cpu(descriptor->tx_pages_per_qpl);
-	priv->default_num_queues = be16_to_cpu(descriptor->default_num_queues);
+	gve_set_desc_cnt(priv);
+	priv->max_registered_pages = device_info->max_registered_pages;
+	priv->tx_pages_per_qpl = device_info->tx_pages_per_qpl;
 }
 
-int gve_set_mtu(struct gve_priv *priv,
-		struct gve_device_descriptor *descriptor)
+static int gve_set_mtu(struct gve_priv *priv)
 {
+	struct gve_device_info *device_info = &priv->device_info;
 	u16 mtu;
 
-	mtu = be16_to_cpu(descriptor->mtu);
+	mtu = device_info->max_mtu;
 	if (mtu < ETH_MIN_MTU) {
 		dev_err(&priv->pdev->dev, "MTU %d below minimum MTU\n", mtu);
 		return -EINVAL;
 	}
 	priv->dev->max_mtu = mtu;
+	priv->dev->mtu = mtu;
 
 	return 0;
 }
 
-void gve_set_mac(struct gve_priv *priv,
-		 struct gve_device_descriptor *descriptor)
+static void gve_set_mac(struct gve_priv *priv)
 {
+	struct gve_device_info *device_info = &priv->device_info;
 	u8 *mac;
 
-	mac = descriptor->mac;
+	mac = device_info->mac;
 	eth_hw_addr_set(priv->dev, mac);
 	dev_info(&priv->pdev->dev, "MAC addr: %pM\n", mac);
 }
 
+static void gve_set_buf_sizes(struct gve_priv *priv)
+{
+	struct gve_device_info *device_info = &priv->device_info;
+
+	if (device_info->max_rx_buffer_size > priv->max_rx_buffer_size)
+		priv->max_rx_buffer_size = device_info->max_rx_buffer_size;
+
+	if (gve_is_dqo(priv) &&
+	    priv->max_rx_buffer_size > GVE_DEFAULT_RX_BUFFER_SIZE)
+		priv->rx_cfg.packet_buffer_size = priv->max_rx_buffer_size;
+
+	if (device_info->header_buf_size)
+		priv->header_buf_size = device_info->header_buf_size;
+}
+
 static int gve_init_priv(struct gve_priv *priv, bool skip_describe_device)
 {
+	struct gve_device_info *device_info = &priv->device_info;
 	int err;
 
 	/* Set up the adminq */
@@ -2471,7 +2485,7 @@ static int gve_init_priv(struct gve_priv *priv, bool skip_describe_device)
 	if (skip_describe_device)
 		goto setup_device;
 
-	priv->queue_format = GVE_QUEUE_FORMAT_UNSPECIFIED;
+	device_info->queue_format = GVE_QUEUE_FORMAT_UNSPECIFIED;
 	/* Get the initial information we need from the device */
 	err = gve_adminq_describe_device(priv);
 	if (err) {
@@ -2480,6 +2494,8 @@ static int gve_init_priv(struct gve_priv *priv, bool skip_describe_device)
 		goto err;
 	}
 
+	priv->queue_format = priv->device_info.queue_format;
+
 	err = gve_set_num_ntfy_blks(priv);
 	if (err) {
 		dev_err(&priv->pdev->dev,
@@ -2503,12 +2519,34 @@ static int gve_init_priv(struct gve_priv *priv, bool skip_describe_device)
 		netif_set_tso_max_size(priv->dev, GVE_DQO_TX_MAX);
 	}
 
-	priv->dev->mtu = priv->dev->max_mtu;
+	if (gve_set_mtu(priv)) {
+		err = -EINVAL;
+		goto err;
+	}
+
+	priv->num_event_counters = device_info->num_event_counters;
+
+	gve_set_mac(priv);
+
+	gve_set_queue_properties(priv);
+	priv->modify_ring_size_enabled = device_info->modify_ring_size_enabled;
+
+	gve_set_buf_sizes(priv);
+
+	priv->max_flow_rules = device_info->max_flow_rules;
+	if (priv->max_flow_rules)
+		priv->dev->hw_features |= NETIF_F_NTUPLE;
+
+	priv->rss_key_size = device_info->rss_key_size;
+	priv->rss_lut_size = device_info->rss_lut_size;
+	priv->cache_rss_config = device_info->cache_rss_config;
+
 	priv->numa_node = dev_to_node(&priv->pdev->dev);
 	priv->tx_cfg.num_xdp_queues = 0;
 	priv->rx_copybreak = GVE_DEFAULT_RX_COPYBREAK;
 	priv->ts_config.tx_type = HWTSTAMP_TX_OFF;
 	priv->ts_config.rx_filter = HWTSTAMP_FILTER_NONE;
+	priv->nic_timestamp_supported = device_info->nic_timestamp_supported;
 
 setup_device:
 	priv->xsk_pools = bitmap_zalloc(priv->rx_cfg.max_queues, GFP_KERNEL);
-- 
2.55.0.691.gc56d675ccc-goog

