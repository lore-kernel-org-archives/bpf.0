Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CC013ABD82
	for <bpf@vger.kernel.org>; Tue,  2 Jun 2026 23:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780444748; cv=none; b=ZXjbCPjzJC34HW6CwUxxcX+7u1amVWRcGFIECXsTVmtyzMZO18uqjGjO5QlFJOr9+ivJ1Sft33ye4rWvmuLZ9zUk4gknOqAMWyr2D5fcId1AF2f8TA2HAYC5KyaH5quEQ59TaNoNjBAspn1StTy8bbm5xXds2BkrILjjIJ9p0oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780444748; c=relaxed/simple;
	bh=HUIQ/G5dsO1Ug/sGdMGDyTDVpr9E2tnSQa4QM7hfAMc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TIad65E9vFaaJU6RW4eAsFbHe0QJRzFuYfolGSQqPasuswOZubjoJahl/SG9eJYr1SvHHq1miXQhLHQjn6hNShOqE5CSK1wISl2/U5hnTVp7nSq3YeUlDFYku8d7FTDvnQzPJ/FvAp34zw+4sJu965hWr2qt8lUrDoZoJufZKRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Sw/Bb8Qd; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Sw/Bb8Qd"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-36b982ec338so5744502a91.0
        for <bpf@vger.kernel.org>; Tue, 02 Jun 2026 16:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780444746; x=1781049546; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=4rPviAwWDHQ433P+7RhzOVcrCNAa7ojcKWDdm3tBNVc=;
        b=Sw/Bb8QdC0HHlbrHHt868NELwh+1YATmiNe6WzBfYPn7SmoDiYz+ihSeWrJiO2XQZM
         zC8iaEbhUQIeoGD/uBDsSM4XWP1H8RMTDqjgvHu4ytsPBqu2BY56nJPpNkXYzNr+xI52
         lRXyeXdq8+QCkw4y3gN9HLHf37rHBKrMCY2pWVGqmOyZotHTY3r4ZDH5JNrGLk6lCEP+
         hUNBxeU89fcg9Aa56FLy+MPQoT6LRH6kxiC7OrOoCYHS9jTNVHF+RKkWT1dhfU0mHHan
         yHNAVFHBUoPtzs/MxctUKzF3oheUU7JnYSV/DBN7Yo/udeITMjF3s2VZlGl8HFCDAgmj
         PWMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780444746; x=1781049546;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4rPviAwWDHQ433P+7RhzOVcrCNAa7ojcKWDdm3tBNVc=;
        b=ApPMeJ3K1IBusz82/zmer8RLafevkMJbFagigAwJLCE+Icx1yj/a1qFZIaAZ4Jr5Ld
         s8ayZinxbKW/tHKWtIHlVqZ27gEIGoO2aDDvUkZbiq3vetS1/smRq/LJEcfFM8rV+Z1V
         XDY79L4+uohcUROofpYbcWVCYyOnP7g4R5GUpvDd9RQ8ldhmu7drIHvjJereIMxxVpFj
         A6SsRGuY+enQeOgDc7tmRB/S16rewGTGOUG9u0LNTdyTfpgE0yKckazxKhI6bATW9fsf
         tYcjQZbRJAWIcMsRLG6ZcymLpViyu7HkACGgVTS5iwrJO3cAd3ZsyCVHD0QxnuYuyaVR
         2kBw==
X-Forwarded-Encrypted: i=1; AFNElJ9ojSoK1RCADGHuUkQu0fGQtOweEUiaCvmHe5NYigKtj9QPOu8OVDUPgGhmhK1WtfpQwV8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYpb3oXTcP47i1gUXOXjxNjcGKjXP3MctLiW7kv8iiV84y4MJA
	MD+nLQErhrDakhFeNgRgsi3PqFDJtasvFXXOucib+6U2/I9gORmj3aGlUMaqLjNRLTSqaUOh4IG
	fjLpjJ/VeUoTJ4NepfYRlfFQPFw==
X-Received: from pjez16.prod.google.com ([2002:a17:90a:150:b0:36b:cff1:e69e])
 (user=hramamurthy job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:1d44:b0:368:6159:980c with SMTP id 98e67ed59e1d1-36e32949e4dmr811053a91.20.1780444745398;
 Tue, 02 Jun 2026 16:59:05 -0700 (PDT)
Date: Tue,  2 Jun 2026 23:58:48 +0000
In-Reply-To: <20260602235900.3050782-1-hramamurthy@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260602235900.3050782-1-hramamurthy@google.com>
X-Mailer: git-send-email 2.54.0.1013.g208068f2d8-goog
Message-ID: <20260602235900.3050782-5-hramamurthy@google.com>
Subject: [PATCH net-next v2 04/15] gve: add a few helper functions to set
 device properties
From: Harshitha Ramamurthy <hramamurthy@google.com>
To: netdev@vger.kernel.org
Cc: joshwash@google.com, hramamurthy@google.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org, 
	john.fastabend@gmail.com, sdf@fomichev.me, willemb@google.com, 
	jordanrhee@google.com, jfraker@google.com, nktgrg@google.com, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For the mailbox ABI, device properties will come from a different
source compared to the AdminQ mode. To accommodate the new source
when the mailbox ABI is added, add a few helper functions to set a
few device properties. Those functions are:

- gve_set_queue_properties() to set no. of pages for QPL mode and
  number of queues in general
- gve_set_mtu()
- gve_set_mac()

This is just code movement, no functional change.

Reviewed-by: Willem de Bruijn <willemb@google.com>
Reviewed-by: Jordan Rhee <jordanrhee@google.com>
Signed-off-by: Harshitha Ramamurthy <hramamurthy@google.com>
---
 drivers/net/ethernet/google/gve/gve_adminq.c | 38 +++-------------
 drivers/net/ethernet/google/gve/gve_adminq.h |  6 +++
 drivers/net/ethernet/google/gve/gve_main.c   | 46 ++++++++++++++++++++
 3 files changed, 59 insertions(+), 31 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve_adminq.c b/drivers/net/ethernet/google/gve/gve_adminq.c
index 860d43650c6a..77203184efbd 100644
--- a/drivers/net/ethernet/google/gve/gve_adminq.c
+++ b/drivers/net/ethernet/google/gve/gve_adminq.c
@@ -920,19 +920,6 @@ int gve_adminq_destroy_rx_queues(struct gve_priv *priv, u32 num_queues)
 	return err;
 }
 
-static void gve_set_default_desc_cnt(struct gve_priv *priv,
-			const struct gve_device_descriptor *descriptor)
-{
-	priv->tx_desc_cnt = be16_to_cpu(descriptor->tx_queue_entries);
-	priv->rx_desc_cnt = be16_to_cpu(descriptor->rx_queue_entries);
-
-	/* set default ranges */
-	priv->max_tx_desc_cnt = priv->tx_desc_cnt;
-	priv->max_rx_desc_cnt = priv->rx_desc_cnt;
-	priv->min_tx_desc_cnt = priv->tx_desc_cnt;
-	priv->min_rx_desc_cnt = priv->rx_desc_cnt;
-}
-
 static void gve_set_default_rss_sizes(struct gve_priv *priv)
 {
 	if (!gve_is_gqi(priv)) {
@@ -1049,8 +1036,6 @@ int gve_adminq_describe_device(struct gve_priv *priv)
 	union gve_adminq_command cmd;
 	dma_addr_t descriptor_bus;
 	int err = 0;
-	u8 *mac;
-	u16 mtu;
 
 	memset(&cmd, 0, sizeof(cmd));
 	descriptor = dma_pool_alloc(priv->adminq_pool, GFP_KERNEL,
@@ -1112,26 +1097,17 @@ int gve_adminq_describe_device(struct gve_priv *priv)
 			 "Driver is running with GQI QPL queue format.\n");
 	}
 
-	/* set default descriptor counts */
-	gve_set_default_desc_cnt(priv, descriptor);
-
 	gve_set_default_rss_sizes(priv);
 
-	priv->max_registered_pages =
-				be64_to_cpu(descriptor->max_registered_pages);
-	mtu = be16_to_cpu(descriptor->mtu);
-	if (mtu < ETH_MIN_MTU) {
-		dev_err(&priv->pdev->dev, "MTU %d below minimum MTU\n", mtu);
-		err = -EINVAL;
+	err = gve_set_mtu(priv, descriptor);
+	if (err)
 		goto free_device_descriptor;
-	}
-	priv->dev->max_mtu = mtu;
+
 	priv->num_event_counters = be16_to_cpu(descriptor->counters);
-	eth_hw_addr_set(priv->dev, descriptor->mac);
-	mac = descriptor->mac;
-	dev_info(&priv->pdev->dev, "MAC addr: %pM\n", mac);
-	priv->tx_pages_per_qpl = be16_to_cpu(descriptor->tx_pages_per_qpl);
-	priv->default_num_queues = be16_to_cpu(descriptor->default_num_queues);
+
+	gve_set_mac(priv, descriptor);
+
+	gve_set_queue_properties(priv, descriptor);
 
 	gve_enable_supported_features(priv, supported_features_mask,
 				      dev_op_jumbo_frames, dev_op_dqo_qpl,
diff --git a/drivers/net/ethernet/google/gve/gve_adminq.h b/drivers/net/ethernet/google/gve/gve_adminq.h
index 831759d30f44..ed5cb052a52d 100644
--- a/drivers/net/ethernet/google/gve/gve_adminq.h
+++ b/drivers/net/ethernet/google/gve/gve_adminq.h
@@ -655,5 +655,11 @@ int gve_adminq_report_nic_ts(struct gve_priv *priv,
 struct gve_ptype_lut;
 int gve_adminq_get_ptype_map_dqo(struct gve_priv *priv,
 				 struct gve_ptype_lut *ptype_lut);
+void gve_set_queue_properties(struct gve_priv *priv,
+			      struct gve_device_descriptor *descriptor);
+int gve_set_mtu(struct gve_priv *priv,
+		struct gve_device_descriptor *descriptor);
+void gve_set_mac(struct gve_priv *priv,
+		 struct gve_device_descriptor *descriptor);
 
 #endif /* _GVE_ADMINQ_H */
diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
index eb2d768e5881..338dc0b3249a 100644
--- a/drivers/net/ethernet/google/gve/gve_main.c
+++ b/drivers/net/ethernet/google/gve/gve_main.c
@@ -2400,6 +2400,52 @@ static void gve_set_num_queues(struct gve_priv *priv)
 		 priv->tx_cfg.max_queues, priv->rx_cfg.max_queues);
 }
 
+static void gve_set_default_desc_cnt(struct gve_priv *priv,
+				     const struct gve_device_descriptor *descriptor)
+{
+	priv->tx_desc_cnt = be16_to_cpu(descriptor->tx_queue_entries);
+	priv->rx_desc_cnt = be16_to_cpu(descriptor->rx_queue_entries);
+
+	/* set default ranges */
+	priv->max_tx_desc_cnt = priv->tx_desc_cnt;
+	priv->max_rx_desc_cnt = priv->rx_desc_cnt;
+	priv->min_tx_desc_cnt = priv->tx_desc_cnt;
+	priv->min_rx_desc_cnt = priv->rx_desc_cnt;
+}
+
+void gve_set_queue_properties(struct gve_priv *priv,
+			      struct gve_device_descriptor *descriptor)
+{
+	/* set default descriptor counts */
+	gve_set_default_desc_cnt(priv, descriptor);
+
+	priv->max_registered_pages = be64_to_cpu(descriptor->max_registered_pages);
+	priv->tx_pages_per_qpl = be16_to_cpu(descriptor->tx_pages_per_qpl);
+	priv->default_num_queues = be16_to_cpu(descriptor->default_num_queues);
+}
+
+int gve_set_mtu(struct gve_priv *priv,
+		struct gve_device_descriptor *descriptor)
+{
+	u16 mtu;
+
+	mtu = be16_to_cpu(descriptor->mtu);
+	if (mtu < ETH_MIN_MTU) {
+		dev_err(&priv->pdev->dev, "MTU %d below minimum MTU\n", mtu);
+		return -EINVAL;
+	}
+	priv->dev->max_mtu = mtu;
+
+	return 0;
+}
+
+void gve_set_mac(struct gve_priv *priv,
+		 struct gve_device_descriptor *descriptor)
+{
+	eth_hw_addr_set(priv->dev, descriptor->mac);
+	dev_info(&priv->pdev->dev, "MAC addr: %pM\n", descriptor->mac);
+}
+
 static int gve_init_priv(struct gve_priv *priv, bool skip_describe_device)
 {
 	int err;
-- 
2.54.0.1013.g208068f2d8-goog

