Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58EDB4B1CF4
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 18:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790276007; cv=none; b=hCGQ4Pqsr8fH6sRK7JgaKORTUoPp44K1bJniJuZ6ed/AIrtsm9p8oEwEhr6lyKmGdrhLCNX7YOi7BihJpURoDSPIFTyskkfUvpcqOMScyFSBoNJk1ngoMtAekQgb2IRxt4pXLX5HuZi2fposvRkfrSVGP7VeKqrZnHVrYufHUCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790276007; c=relaxed/simple;
	bh=AcgjBhJ9m5NwpuZE0QNn/9zHvCH3mRzfjtWt31Iur7k=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=UF1xVEwn3JyCZ3DdTV3uT34uU03kbdm0xuVXpmZnpXHM212RCrMgM2ZM2HwTQep2tUH191L2aN/fdEMGeMi+9PNmPl5heG7VDK2bN9E7QGM1XdP0R8+3YhfVulYPfdSw1Qv4Keo/fo47gFBsYoFJOpBwIIo3G6AESCkSy4xA448=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=d+S88Gug; arc=none smtp.client-ip=209.85.210.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="d+S88Gug"
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-86261e66700so128481b3a.3
        for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 11:53:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790276000; x=1790880800; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=veFk5AIrmc3iheWbj6eDN8FogiWiRrP4CnAk1Gi5C/g=;
        b=d+S88Gug9J1e9pN49gO/0UgTZW/EJGtZ//fSO7ed9c1Mto4paOhvvNFjT+Ouep/a0t
         s2hoQV9DkveHRyaQxVeZDiImIyazsRrkY21QxK1nrSoVnxxStrRB5dhSpa+DEQ19vkxD
         L5YbpZFRMpa9le2Dl15t7aox1QpXDt6TgzJmtEZ/yXqfklFmCw+6+VltvAhfWjC1lw1a
         szDs3xwgHY3U59au9FEx4rfhH4mkXjXJth5jF8arUqY7oRrAd8ustkFpfz1QfeMNKFLg
         HCx6TIevL2OQ+xfqP5jN424OR5fIHtWxnuj5TP0qnm3gm6zksIPsV1KQIRK4aYEMbOGW
         Ac6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790276000; x=1790880800;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=veFk5AIrmc3iheWbj6eDN8FogiWiRrP4CnAk1Gi5C/g=;
        b=jgUQPj7AgOWoo9LcxtqFE+7N2lNxm/n31myQCVcup9If3tydowbX9Zzzz36/RgPOVz
         isTsD0f7YqcWmWqNoaKz2N/r/L43A8vMhGjlWUZf1UCLp/9vJziQZBqFziZbQwPtwuyD
         ZeLvY/cAPWKynzIY1cS3QL2s3YzGcj4nv/fSSjA4QagXw1I0KPK0ftm4+WsDPO5ZCF4t
         +0Lwio4y/AqMfruZMijP6oQqWuvC4N7TYCw9GRGQxIIEAiCCQWPr0iikDCEvgAhDMtu9
         V3LHYHIbFX3viBsA9nwDPES/psxpeVkKcgTLcjQU4wNoVb92xzcMktzo+s5IrKmbtq2s
         wEeA==
X-Forwarded-Encrypted: i=1; AKwUvBzIEzYk8jft/GBHnHWl3cruUST5euGwXEgWLAzrf6aiLbKSVH7Zxi4qYSj5fZBr+vMlCkU=@vger.kernel.org
X-Gm-Message-State: AFuF++kga6PL0yMEeMspwf+JOOdu+isBUjC0dL3xTZ17CH6MO60ywNDt
	VLcKOftBI/m52wNkyWa+p+Mwuxyrg1AcvOxR2OO38y4yxCGLX9ninnQvJevaHGKGH6B6QGhEZ6L
	eK7v+vBELSaJCfQPvopWadHX3yg==
X-Received: from pfbdo14.prod.google.com ([2002:a05:6a00:4a0e:b0:876:327e:ca73])
 (user=hramamurthy job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:3cc5:b0:877:dcd8:41c8 with SMTP id d2e1a72fcca58-87e98693f32mr2968850b3a.2.1790275999548;
 Thu, 24 Sep 2026 11:53:19 -0700 (PDT)
Date: Thu, 24 Sep 2026 18:53:05 +0000
In-Reply-To: <20260924185316.2831077-1-hramamurthy@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260924185316.2831077-1-hramamurthy@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260924185316.2831077-2-hramamurthy@google.com>
Subject: [PATCH net-next v8 01/12] gve: add struct gve_device_info to hold
 device properties
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

Most of these changes are refactors only, except for one:
with the introduction of the central struct gve_device_info,
in AdminQ mode, gve_set_mtu() now also validates the device
provided mtu value from jumbo frames device option. This sets
up the driver nicely for the MailboxQ mode where both the
default and the maximum mtu are provided at once and they
are validated in gve_set_mtu().

Reviewed-by: Willem de Bruijn <willemb@google.com>
Reviewed-by: Jordan Rhee <jordanrhee@google.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Harshitha Ramamurthy <hramamurthy@google.com>
---
v6:
- update commit message to call out change in device provided MTU
  validation (Sashiko)

v5:
- ensure using default_tx/rx_queues (Sashiko)
- honor device provided rx buffer size correctly (Sashiko)

v4:
- reuse mtu variable

v3:
- Read default_min_ring_size from device info instead of priv

 drivers/net/ethernet/google/gve/gve.h        |  29 ++++++
 drivers/net/ethernet/google/gve/gve_adminq.c | 128 ++++++++++++++++-----------
 drivers/net/ethernet/google/gve/gve_adminq.h |   6 --
 drivers/net/ethernet/google/gve/gve_main.c   |  86 +++++++++++++-----
 4 files changed, 169 insertions(+), 80 deletions(-)

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
index f05f4895f4c7..512349c5517f 100644
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
@@ -922,10 +922,13 @@ out:
 
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
@@ -1595,6 +1618,8 @@ int gve_set_num_ntfy_blks(struct gve_priv *priv)
 
 void gve_set_num_queues(struct gve_priv *priv)
 {
+	struct gve_device_info *device_info = &priv->device_info;
+
 	priv->tx_cfg.max_queues =
 		min_t(int, priv->tx_cfg.max_queues, priv->num_ntfy_blks / 2);
 	priv->rx_cfg.max_queues =
@@ -1602,10 +1627,13 @@ void gve_set_num_queues(struct gve_priv *priv)
 
 	priv->tx_cfg.num_queues = priv->tx_cfg.max_queues;
 	priv->rx_cfg.num_queues = priv->rx_cfg.max_queues;
-	if (priv->default_num_queues > 0) {
-		priv->tx_cfg.num_queues = min_t(int, priv->default_num_queues,
+	if (device_info->default_tx_queues > 0)
+		priv->tx_cfg.num_queues = min_t(int,
+						device_info->default_tx_queues,
 						priv->tx_cfg.num_queues);
-		priv->rx_cfg.num_queues = min_t(int, priv->default_num_queues,
+
+	if (device_info->default_rx_queues > 0)
+		priv->rx_cfg.num_queues = min_t(int,
+						device_info->default_rx_queues,
 						priv->rx_cfg.num_queues);
-	}
 }
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
index 9cc343a16271..d3882de584e3 100644
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
+	if (device_info->max_rx_buffer_size)
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
@@ -2507,12 +2523,34 @@ static int gve_init_priv(struct gve_priv *priv, bool skip_describe_device)
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
2.56.0.rc1.310.g51773c2048-goog

