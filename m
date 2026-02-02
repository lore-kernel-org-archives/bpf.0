Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AE5B3081C2
	for <bpf@vger.kernel.org>; Mon,  2 Feb 2026 19:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770061178; cv=none; b=Z0bt/xuOUAVWRfM12YodY83JNVA4esPGo8XoavinL4N2k9Dte7DJje4j/awXBImPZPg123Bl/H8GETEvV2lGHx00Klh6p53KDqGOO6GieDLsmfvhwJZUwg1Xy5Y+MBFc71AWHRtAwgOKmsDOBcs0PvUcIvVSKWDMaSwWNq7in08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770061178; c=relaxed/simple;
	bh=Kj/aQaeo40aHx4bU8TOzNUGtrh5jbNnKO61YTbpPSwc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jJ8hsv0YUgtXlYNcuhn/B6xxVWsoEYUc8mvOSovY5e/ikdaL90sUTK57vy8RBqKF7KZiPFzs40SepvvE/LNkoAmTlk7l05Sk/sm2GRA3vYnDf5WnjPQPYjqv/pluS949kCgN8ly4k+SZjFPamFknznD5LEPaPZoLM/9ZNc0VyoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RIlN9lQE; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RIlN9lQE"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2a79164b686so48913635ad.0
        for <bpf@vger.kernel.org>; Mon, 02 Feb 2026 11:39:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770061176; x=1770665976; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=SQ5kxBUBFp+SLAVCVX+2wUd953i/3Otxj9GkhrTs9Bw=;
        b=RIlN9lQEX7MBpiCM7elMCi5ZOgkuKnRtzcxjgi5fZTewvCUBtgi7Cymn3QHXt/6eVL
         cRSiBSF2/cKK2Xagd5hpVLl25ZQut7tiTAak1m+KgytdNFJM8oPahAej7N9PSW7P3+oW
         OjjfKKvAAhYBXbvY3kU8eLJTEbiLkHoUU6IQXLzaFLtSnRRWggJc7gb4dIrDFP4q8EOP
         68IVpyTXD9ugRRUfDqKRjacFBSj+0JzzFeQ9CcG1T2OtXldsB6ZPV0X+kiDX1QUOz5kf
         ijHVek/2lm5DrQelJHuGFM0/VtIWzkwyALdUd4TP6mY5zzMTuZjV+svYatNg1nB9D/r5
         LtVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770061176; x=1770665976;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SQ5kxBUBFp+SLAVCVX+2wUd953i/3Otxj9GkhrTs9Bw=;
        b=QyPfUCX9hXCXN7WNdHMG/v/P6Dag6KhifqXaCqme4Q5VFZvRX8VyBzM7Ff+79qVo4T
         IE6olqUZTSXmkyFlcahqBEVZSGeUzFe9oy/LKXreypjceTc5Sw1dMbDbYKAWVok5S/ub
         qiKJyD9oGmpi0fX9DEYskPTHvqIpJw+O8RmxqO05SGu1XYoO7ujptVJuQdfzjkPj+sm4
         /ivagRcf5nq23WbbT+hmqpyEZ9lsPc2m/RB+YoRGoi3aEdvf7EahFsE9JPcnYd2lMiUR
         5hb8MPvOVN63LRmguplDAKIX6uwKPaetkcClIxBtapru/q/KUHM1UnJDlA4bWHawne7A
         h5tw==
X-Forwarded-Encrypted: i=1; AJvYcCWFR6nB47ljPXJVXs0Oa4urIqZnu/WHW26r0KSvUtRbHGXByRQsMekgCakCyTCy4UqvAWQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy70i6WsYoDGQ75wP2WulVeeVNF6rAjWBrNY3rESTLuK7EH7KtP
	a5PGhDAZRGrlTrDj9B/dWh/wJZhSh/LJWiT8HxHiN/tqHwFLj8r///Oky1J/x/c0cE4oOOIAeWe
	h2GufNWhSRvnGp4hxDFCOcw56VQ==
X-Received: from plqu4.prod.google.com ([2002:a17:902:a604:b0:2a7:cf29:aee1])
 (user=hramamurthy job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:ef43:b0:296:2b7a:90cd with SMTP id d9443c01a7336-2a8d990aaebmr132572965ad.32.1770061176414;
 Mon, 02 Feb 2026 11:39:36 -0800 (PST)
Date: Mon,  2 Feb 2026 19:39:24 +0000
In-Reply-To: <20260202193925.3106272-1-hramamurthy@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260202193925.3106272-1-hramamurthy@google.com>
X-Mailer: git-send-email 2.53.0.rc1.225.gd81095ad13-goog
Message-ID: <20260202193925.3106272-2-hramamurthy@google.com>
Subject: [PATCH net 1/2] gve: Fix stats report corruption on queue count change
From: Harshitha Ramamurthy <hramamurthy@google.com>
To: netdev@vger.kernel.org
Cc: joshwash@google.com, hramamurthy@google.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	willemb@google.com, ziweixiao@google.com, jordanrhee@google.com, 
	nktgrg@google.com, kuozhao@google.com, yangchun@google.com, 
	awogbemila@google.com, maolson@google.com, ast@kernel.org, 
	daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com, 
	sdf@fomichev.me, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.com, Debarghya Kundu <debarghyak@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Debarghya Kundu <debarghyak@google.com>

The driver and the NIC share a region in memory for stats reporting.
The NIC calculates its offset into this region based on the total size
of the stats region and the size of the NIC's stats.

When the number of queues is changed, the driver's stats region is
resized. If the queue count is increased, the NIC can write past
the end of the allocated stats region, causing memory corruption.
If the queue count is decreased, there is a gap between the driver
and NIC stats, leading to incorrect stats reporting.

This change fixes the issue by allocating stats region with maximum
size, and the offset calculation for NIC stats is changed to match
with the calculation of the NIC.

Cc: stable@vger.kernel.org
Fixes: 24aeb56f2d38 ("gve: Add Gvnic stats AQ command and ethtool show/set-priv-flags.")
Signed-off-by: Debarghya Kundu <debarghyak@google.com>
Reviewed-by: Joshua Washington <joshwash@google.com>
Signed-off-by: Harshitha Ramamurthy <hramamurthy@google.com>
---
 drivers/net/ethernet/google/gve/gve_ethtool.c | 54 +++++++++++++++++++++++++---------------
 drivers/net/ethernet/google/gve/gve_main.c    |  4 +--
 2 files changed, 36 insertions(+), 22 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve_ethtool.c b/drivers/net/ethernet/google/gve/gve_ethtool.c
index 52500ae8..f7864ae7 100644
--- a/drivers/net/ethernet/google/gve/gve_ethtool.c
+++ b/drivers/net/ethernet/google/gve/gve_ethtool.c
@@ -156,7 +156,8 @@ gve_get_ethtool_stats(struct net_device *netdev,
 	u64 rx_buf_alloc_fail, rx_desc_err_dropped_pkt, rx_hsplit_unsplit_pkt,
 		rx_pkts, rx_hsplit_pkt, rx_skb_alloc_fail, rx_bytes, tx_pkts, tx_bytes,
 		tx_dropped;
-	int stats_idx, base_stats_idx, max_stats_idx;
+	int rx_base_stats_idx, max_rx_stats_idx, max_tx_stats_idx;
+	int stats_idx, stats_region_len, nic_stats_len;
 	struct stats *report_stats;
 	int *rx_qid_to_stats_idx;
 	int *tx_qid_to_stats_idx;
@@ -265,20 +266,38 @@ gve_get_ethtool_stats(struct net_device *netdev,
 	data[i++] = priv->stats_report_trigger_cnt;
 	i = GVE_MAIN_STATS_LEN;
 
-	/* For rx cross-reporting stats, start from nic rx stats in report */
-	base_stats_idx = GVE_TX_STATS_REPORT_NUM * num_tx_queues +
-		GVE_RX_STATS_REPORT_NUM * priv->rx_cfg.num_queues;
-	/* The boundary between driver stats and NIC stats shifts if there are
-	 * stopped queues.
-	 */
-	base_stats_idx += NIC_RX_STATS_REPORT_NUM * num_stopped_rxqs +
-		NIC_TX_STATS_REPORT_NUM * num_stopped_txqs;
-	max_stats_idx = NIC_RX_STATS_REPORT_NUM *
-		(priv->rx_cfg.num_queues - num_stopped_rxqs) +
-		base_stats_idx;
+	rx_base_stats_idx = 0;
+	max_rx_stats_idx = 0;
+	max_tx_stats_idx = 0;
+	stats_region_len = priv->stats_report_len -
+				sizeof(struct gve_stats_report);
+	nic_stats_len = (NIC_RX_STATS_REPORT_NUM * priv->rx_cfg.num_queues +
+		NIC_TX_STATS_REPORT_NUM * num_tx_queues) * sizeof(struct stats);
+	if (unlikely((stats_region_len -
+				nic_stats_len) % sizeof(struct stats))) {
+		net_err_ratelimited("Starting index of NIC stats should be multiple of stats size");
+	} else {
+		/* For rx cross-reporting stats,
+		 * start from nic rx stats in report
+		 */
+		rx_base_stats_idx = (stats_region_len - nic_stats_len) /
+							sizeof(struct stats);
+		/* The boundary between driver stats and NIC stats
+		 * shifts if there are stopped queues
+		 */
+		rx_base_stats_idx += NIC_RX_STATS_REPORT_NUM *
+			num_stopped_rxqs + NIC_TX_STATS_REPORT_NUM *
+			num_stopped_txqs;
+		max_rx_stats_idx = NIC_RX_STATS_REPORT_NUM *
+			(priv->rx_cfg.num_queues - num_stopped_rxqs) +
+			rx_base_stats_idx;
+		max_tx_stats_idx = NIC_TX_STATS_REPORT_NUM *
+			(num_tx_queues - num_stopped_txqs) +
+			max_rx_stats_idx;
+	}
 	/* Preprocess the stats report for rx, map queue id to start index */
 	skip_nic_stats = false;
-	for (stats_idx = base_stats_idx; stats_idx < max_stats_idx;
+	for (stats_idx = rx_base_stats_idx; stats_idx < max_rx_stats_idx;
 		stats_idx += NIC_RX_STATS_REPORT_NUM) {
 		u32 stat_name = be32_to_cpu(report_stats[stats_idx].stat_name);
 		u32 queue_id = be32_to_cpu(report_stats[stats_idx].queue_id);
@@ -354,14 +373,9 @@ gve_get_ethtool_stats(struct net_device *netdev,
 		i += priv->rx_cfg.num_queues * NUM_GVE_RX_CNTS;
 	}
 
-	/* For tx cross-reporting stats, start from nic tx stats in report */
-	base_stats_idx = max_stats_idx;
-	max_stats_idx = NIC_TX_STATS_REPORT_NUM *
-		(num_tx_queues - num_stopped_txqs) +
-		max_stats_idx;
-	/* Preprocess the stats report for tx, map queue id to start index */
 	skip_nic_stats = false;
-	for (stats_idx = base_stats_idx; stats_idx < max_stats_idx;
+	/* NIC TX stats start right after NIC RX stats */
+	for (stats_idx = max_rx_stats_idx; stats_idx < max_tx_stats_idx;
 		stats_idx += NIC_TX_STATS_REPORT_NUM) {
 		u32 stat_name = be32_to_cpu(report_stats[stats_idx].stat_name);
 		u32 queue_id = be32_to_cpu(report_stats[stats_idx].queue_id);
diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
index a7a088a7..5a747603 100644
--- a/drivers/net/ethernet/google/gve/gve_main.c
+++ b/drivers/net/ethernet/google/gve/gve_main.c
@@ -283,9 +283,9 @@ static int gve_alloc_stats_report(struct gve_priv *priv)
 	int tx_stats_num, rx_stats_num;
 
 	tx_stats_num = (GVE_TX_STATS_REPORT_NUM + NIC_TX_STATS_REPORT_NUM) *
-		       gve_num_tx_queues(priv);
+				priv->tx_cfg.max_queues;
 	rx_stats_num = (GVE_RX_STATS_REPORT_NUM + NIC_RX_STATS_REPORT_NUM) *
-		       priv->rx_cfg.num_queues;
+				priv->rx_cfg.max_queues;
 	priv->stats_report_len = struct_size(priv->stats_report, stats,
 					     size_add(tx_stats_num, rx_stats_num));
 	priv->stats_report =
-- 
2.53.0.rc1.225.gd81095ad13-goog

