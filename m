Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A9B838910B
	for <bpf@vger.kernel.org>; Tue,  3 Mar 2026 19:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772567759; cv=none; b=gRtM8+pJQHr/3V/8NiHSiRCVqgKC8Iqq8LSb89CgCOO0UJkFNJ5TutB1XXN8KVi+4riw/2EYof8ScFDpNkhgr7uMmBIqb1tl7kHx8KKq7INth1FCanRG9s9WQwtobTDGydpyQHqUOQyxHVo17cXnV/jIgxnP3nQYN+upuOrDufY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772567759; c=relaxed/simple;
	bh=tBrXfsph2RTre7AKwb6XSwlXm3BvBH5Y/qhSnej/G7o=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MsZ25inklcZw+675BCruWswzjc/UTWZU09JcIQmvfTcr0p1slqKdqlZXxaw5QWmJMks4+tTE56eCa/GKd+Vxz45gsZhomEPUzGslmTqjrDsByKpZ/nC+QEkc2c1jCiJ8rZOghfhm+ZRz+oyE0dWJOfaqgy1SWAYIqNeONLSOef4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--joshwash.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vTLl3mpW; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--joshwash.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vTLl3mpW"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-354490889b6so21359925a91.3
        for <bpf@vger.kernel.org>; Tue, 03 Mar 2026 11:55:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772567755; x=1773172555; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=js0eM5dF9ShUt2Ha+FRxZ4vQ9tkmpGaVXJ30nrzMkdw=;
        b=vTLl3mpWvmnFfDugWK5CCJFJ4FQ7HhIriT4V3Srsy/JSakcJQEKy7q4xNyPPIq7THH
         gCu3UyxEnqiwGNE5T/evY/rP1QsNioaZXnbNVFHv7nRM/vwaEYESLvTR5ShupWzXijaI
         7PB43c4BeD6yWD8sLmt4+v9aJL0Du9SN3PEnlYf78oWnsaFpz6D7J1JQsBzyR5xllQn2
         B+vsQ6KwCut9QO4pyO7A8BZH8DXWYxEY7NrvxM5FDL7o0mXoYpQ4cFGgYp0Gq9Sujzmp
         RIuQTvQy1RxcJeaLdLKF7kUi/Fv4cRoKTUqLe6OCwp0leufUhr58V92sRJO8PqexpWy3
         W9zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772567755; x=1773172555;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=js0eM5dF9ShUt2Ha+FRxZ4vQ9tkmpGaVXJ30nrzMkdw=;
        b=c/LjYN/XUu8lmKoxONAMzKXwci8YQwjpxG/krNi8agu4Pfx1C4IQBQk6Cdm63sB1cM
         LAWZ8w5L4tojoh4e7u5FTax7xMfVh88pctDwO/oKBiEIcqVe8GS+RyGg0w/saDjHU610
         zCfmAfOM4Z/yQnFhtNNxH67MylZknxciVNd1KatmPh5Uy0rVIhupkFx6fFfLs/YlciGX
         U8/+xpHGYF5aHvNV94k3MTCZF2Lm0L0e6uI7eBog7sApvq+qa08kDRz+aKddVRNAQ9l6
         wDPyO1YBdb8VSB1Hs/VCQ9mrUb3Juu5zSpSvHkCIyXKQPjonGETrx9pRyq1M1dxdRuDG
         FADg==
X-Forwarded-Encrypted: i=1; AJvYcCWNuxlhLIToInk8CCbtbfkhcKPrwIdCoiBRRdI40fHcMfwz8zbVqQI4dJl8uzxnVWh+sJc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3pYu4Jq0SSIGVFQRMF7cP5kfKszdlw5H8OPixIWhJhQgcGnQ6
	2pVtPQQW0dFbWjipuJwW0bsDoxm0Sw4WRmJK2dhqbIelaSlTT1zAipp1TtMjRRTsFLJFqfdlJ0V
	SlgOAcPx93L9wSA==
X-Received: from pjop12.prod.google.com ([2002:a17:90a:930c:b0:359:79d6:387a])
 (user=joshwash job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:2496:b0:359:8726:3fb0 with SMTP id 98e67ed59e1d1-3598726419dmr4606668a91.22.1772567755368;
 Tue, 03 Mar 2026 11:55:55 -0800 (PST)
Date: Tue,  3 Mar 2026 11:55:46 -0800
In-Reply-To: <20260303195549.2679070-1-joshwash@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260303195549.2679070-1-joshwash@google.com>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260303195549.2679070-2-joshwash@google.com>
Subject: [PATCH net-next 1/4] gve: Advertise NETIF_F_GRO_HW instead of NETIF_F_LRO
From: Joshua Washington <joshwash@google.com>
To: netdev@vger.kernel.org
Cc: Joshua Washington <joshwash@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Willem de Bruijn <willemb@google.com>, 
	Jordan Rhee <jordanrhee@google.com>, Ankit Garg <nktgrg@google.com>, 
	John Fraker <jfraker@google.com>, Ziwei Xiao <ziweixiao@google.com>, 
	Matt Olson <maolson@google.com>, Praveen Kaligineedi <pkaligineedi@google.com>, 
	Tim Hostetler <thostet@google.com>, linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Ankit Garg <nktgrg@google.com>

The device behind DQO format has always coalesced packets per stricter
hardware GRO spec even though it was being advertised as LRO.

Update advertised capability to match device behavior.

Signed-off-by: Ankit Garg <nktgrg@google.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
Reviewed-by: Harshitha Ramamurthy <hramamurthy@google.com>
Signed-off-by: Joshua Washington <joshwash@google.com>
---
 drivers/net/ethernet/google/gve/gve_adminq.c |  6 +++---
 drivers/net/ethernet/google/gve/gve_main.c   | 15 ++++++++-------
 2 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve_adminq.c b/drivers/net/ethernet/google/gve/gve_adminq.c
index b72cc0fa..873672f6 100644
--- a/drivers/net/ethernet/google/gve/gve_adminq.c
+++ b/drivers/net/ethernet/google/gve/gve_adminq.c
@@ -791,7 +791,7 @@ static void gve_adminq_get_create_rx_queue_cmd(struct gve_priv *priv,
 		cmd->create_rx_queue.rx_buff_ring_size =
 			cpu_to_be16(priv->rx_desc_cnt);
 		cmd->create_rx_queue.enable_rsc =
-			!!(priv->dev->features & NETIF_F_LRO);
+			!!(priv->dev->features & NETIF_F_GRO_HW);
 		if (priv->header_split_enabled)
 			cmd->create_rx_queue.header_buffer_size =
 				cpu_to_be16(priv->header_buf_size);
@@ -1127,9 +1127,9 @@ int gve_adminq_describe_device(struct gve_priv *priv)
 
 	gve_set_default_rss_sizes(priv);
 
-	/* DQO supports LRO. */
+	/* DQO supports HW-GRO. */
 	if (!gve_is_gqi(priv))
-		priv->dev->hw_features |= NETIF_F_LRO;
+		priv->dev->hw_features |= NETIF_F_GRO_HW;
 
 	priv->max_registered_pages =
 				be64_to_cpu(descriptor->max_registered_pages);
diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
index 0ee864b0..ee963c98 100644
--- a/drivers/net/ethernet/google/gve/gve_main.c
+++ b/drivers/net/ethernet/google/gve/gve_main.c
@@ -1718,9 +1718,9 @@ static int gve_verify_xdp_configuration(struct net_device *dev,
 	struct gve_priv *priv = netdev_priv(dev);
 	u16 max_xdp_mtu;
 
-	if (dev->features & NETIF_F_LRO) {
+	if (dev->features & NETIF_F_GRO_HW) {
 		NL_SET_ERR_MSG_MOD(extack,
-				   "XDP is not supported when LRO is on.");
+				   "XDP is not supported when HW-GRO is on.");
 		return -EOPNOTSUPP;
 	}
 
@@ -2137,12 +2137,13 @@ static int gve_set_features(struct net_device *netdev,
 
 	gve_get_curr_alloc_cfgs(priv, &tx_alloc_cfg, &rx_alloc_cfg);
 
-	if ((netdev->features & NETIF_F_LRO) != (features & NETIF_F_LRO)) {
-		netdev->features ^= NETIF_F_LRO;
-		if (priv->xdp_prog && (netdev->features & NETIF_F_LRO)) {
+	if ((netdev->features & NETIF_F_GRO_HW) !=
+	    (features & NETIF_F_GRO_HW)) {
+		netdev->features ^= NETIF_F_GRO_HW;
+		if (priv->xdp_prog && (netdev->features & NETIF_F_GRO_HW)) {
 			netdev_warn(netdev,
-				    "XDP is not supported when LRO is on.\n");
-			err =  -EOPNOTSUPP;
+				    "HW-GRO is not supported when XDP is on.");
+			err = -EOPNOTSUPP;
 			goto revert_features;
 		}
 		if (netif_running(netdev)) {
-- 
2.53.0.473.g4a7958ca14-goog

