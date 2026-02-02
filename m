Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D24A930748B
	for <bpf@vger.kernel.org>; Mon,  2 Feb 2026 19:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770061180; cv=none; b=c9jQEr4Xh7DLPS5afdSpnfYVuSBWoHxHtYfR1/U1Ih0OyAuDi/g9wJWmeTOeIbzwbrF3hXasHJ4sScW33VwNba1Vur50nJGOU7zfG34QFfg7qMLa6X8mGjv6KxJX2bqIUvUgAbLK6ngDQ77rF5fJ6S6EfAtKR9dz9HpU1yqLKDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770061180; c=relaxed/simple;
	bh=n6E9zvFMWoY03F3m73ZI1gx6xlels/hxNGufX6evA1g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NpCXVFOepq1OqqQoIXEYF3lNtbZVhyFetiCBSpmdZFZnqTnZSgpLA32HlP9tzA3D0GIupBQpHKJzrbjxeB+f3R9J9cCRgeYNKfjKT2okQIjoKCTyDq4iJ9R2J87MY8tQ9W22u6prcj54ve30Bmyy9DgiKrGrp7I64O4ZJVBf0TU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JSQCeXBB; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JSQCeXBB"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2a377e15716so128803815ad.3
        for <bpf@vger.kernel.org>; Mon, 02 Feb 2026 11:39:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770061178; x=1770665978; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=sq8UgQHMkDt9URltVgoRQ8Smj0jrcUPq0dpsGS66bCA=;
        b=JSQCeXBBA8DPCXpZzgvVKmiTIwHypuwAr/vKsFpQQUFkLvZHy6F/Pag9l85UAmN7Al
         JcweXrfDTaQmRxyKO0YckBAmQVN0dlpadq5EmeZTTB+32Ln24HXbKKuu268w7vjIjvqn
         bUT+zqLxI8vgfdfsOo/NkvkgaZ14KLV51g/yf5GiG90vRBCBpHrBH6kRET//3alm9LHL
         i0qRq2ousufwcSLd46mNRN08Q2Rntacn/PB+/vyTtzqN+QKJDITTXLEDGkVzWGYR1Djh
         4YYFs4Hdy8qCJesqzgkkjsBm1lSifaExcQt7SN/sCkvPk5nKSG0KpMOmUDsiA0ff5Xry
         tnQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770061178; x=1770665978;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sq8UgQHMkDt9URltVgoRQ8Smj0jrcUPq0dpsGS66bCA=;
        b=uWPxuffmLWot5jdG1kBZFNMnHNWeQFItu69oGDuy78ONukcENMUL0x5ZJSzaMt9kad
         ony/b+LBSMM0ql0dpnTMHGLPeAKZU7BVy3a5NmYtpSL8CRtivFlKhiZXlq0MzcsVzNVE
         sLx2pInAzUY7FsEkDBdyFjwxLfzAGYB3smZiK8Hjh9F4kANg7b8uW8tIfDVSYgDkb/Xt
         ObHV3M6zvrQx5fi2CJaygctKiM4BA6RCibnDTm+BL/+2Jar8VtAjzDNklKhjWoK8ctOs
         NKwljd2o/eHeosevDiEnATk7qKP4g5/C+EDBIBfRFHr+tZTxms3UvUdevfG0j3UYLf6T
         vg1A==
X-Forwarded-Encrypted: i=1; AJvYcCXvcvPdIGYBXQN1nzldCZV7l3wMp8VJWeQRd03UdalHUKk5T4nlsk5eWak86Dzcms17hWA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw73hbdcULCjETVW4UIkH+8Ki3uayHBDfiNhucdJ1PZiVuduSjj
	e17l2jg5DYYXl7ol2qCVNa4/Bty0Xt7d+vxC9wgcdbncHfLFsQhZ211Es8rytsR5IMJXU8V/t0u
	1bISTUrWxB2hOsHMxK7HTyX7okA==
X-Received: from plbjw4.prod.google.com ([2002:a17:903:2784:b0:2a0:f5f5:419d])
 (user=hramamurthy job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:d4c5:b0:2a9:4c2:e47 with SMTP id d9443c01a7336-2a904c241c5mr61022835ad.56.1770061178166;
 Mon, 02 Feb 2026 11:39:38 -0800 (PST)
Date: Mon,  2 Feb 2026 19:39:25 +0000
In-Reply-To: <20260202193925.3106272-1-hramamurthy@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260202193925.3106272-1-hramamurthy@google.com>
X-Mailer: git-send-email 2.53.0.rc1.225.gd81095ad13-goog
Message-ID: <20260202193925.3106272-3-hramamurthy@google.com>
Subject: [PATCH net 2/2] gve: Correct ethtool rx_dropped calculation
From: Harshitha Ramamurthy <hramamurthy@google.com>
To: netdev@vger.kernel.org
Cc: joshwash@google.com, hramamurthy@google.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	willemb@google.com, ziweixiao@google.com, jordanrhee@google.com, 
	nktgrg@google.com, kuozhao@google.com, yangchun@google.com, 
	awogbemila@google.com, maolson@google.com, ast@kernel.org, 
	daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com, 
	sdf@fomichev.me, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.com, Max Yuan <maxyuan@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Max Yuan <maxyuan@google.com>

The gve driver's "rx_dropped" statistic, exposed via `ethtool -S`,
incorrectly includes `rx_buf_alloc_fail` counts. These failures
represent an inability to allocate receive buffers, not true packet
drops where a received packet is discarded. This misrepresentation can
lead to inaccurate diagnostics.

This patch rectifies the ethtool "rx_dropped" calculation. It removes
`rx_buf_alloc_fail` from the total and adds `xdp_tx_errors` and
`xdp_redirect_errors`, which represent legitimate packet drops within
the XDP path.

Cc: stable@vger.kernel.org
Fixes: 433e274b8f7b ("gve: Add stats for gve.")
Signed-off-by: Max Yuan <maxyuan@google.com>
Reviewed-by: Jordan Rhee <jordanrhee@google.com>
Reviewed-by: Joshua Washington <joshwash@google.com>
Reviewed-by: Matt Olson <maolson@google.com>
Signed-off-by: Harshitha Ramamurthy <hramamurthy@google.com>
---
 drivers/net/ethernet/google/gve/gve_ethtool.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve_ethtool.c b/drivers/net/ethernet/google/gve/gve_ethtool.c
index f7864ae7..9fd954d1 100644
--- a/drivers/net/ethernet/google/gve/gve_ethtool.c
+++ b/drivers/net/ethernet/google/gve/gve_ethtool.c
@@ -152,10 +152,11 @@ gve_get_ethtool_stats(struct net_device *netdev,
 	u64 tmp_rx_pkts, tmp_rx_hsplit_pkt, tmp_rx_bytes, tmp_rx_hsplit_bytes,
 		tmp_rx_skb_alloc_fail, tmp_rx_buf_alloc_fail,
 		tmp_rx_desc_err_dropped_pkt, tmp_rx_hsplit_unsplit_pkt,
-		tmp_tx_pkts, tmp_tx_bytes;
+		tmp_tx_pkts, tmp_tx_bytes,
+		tmp_xdp_tx_errors, tmp_xdp_redirect_errors;
 	u64 rx_buf_alloc_fail, rx_desc_err_dropped_pkt, rx_hsplit_unsplit_pkt,
 		rx_pkts, rx_hsplit_pkt, rx_skb_alloc_fail, rx_bytes, tx_pkts, tx_bytes,
-		tx_dropped;
+		tx_dropped, xdp_tx_errors, xdp_redirect_errors;
 	int rx_base_stats_idx, max_rx_stats_idx, max_tx_stats_idx;
 	int stats_idx, stats_region_len, nic_stats_len;
 	struct stats *report_stats;
@@ -199,6 +200,7 @@ gve_get_ethtool_stats(struct net_device *netdev,
 	for (rx_pkts = 0, rx_bytes = 0, rx_hsplit_pkt = 0,
 	     rx_skb_alloc_fail = 0, rx_buf_alloc_fail = 0,
 	     rx_desc_err_dropped_pkt = 0, rx_hsplit_unsplit_pkt = 0,
+	     xdp_tx_errors = 0, xdp_redirect_errors = 0,
 	     ring = 0;
 	     ring < priv->rx_cfg.num_queues; ring++) {
 		if (priv->rx) {
@@ -216,6 +218,9 @@ gve_get_ethtool_stats(struct net_device *netdev,
 					rx->rx_desc_err_dropped_pkt;
 				tmp_rx_hsplit_unsplit_pkt =
 					rx->rx_hsplit_unsplit_pkt;
+				tmp_xdp_tx_errors = rx->xdp_tx_errors;
+				tmp_xdp_redirect_errors =
+					rx->xdp_redirect_errors;
 			} while (u64_stats_fetch_retry(&priv->rx[ring].statss,
 						       start));
 			rx_pkts += tmp_rx_pkts;
@@ -225,6 +230,8 @@ gve_get_ethtool_stats(struct net_device *netdev,
 			rx_buf_alloc_fail += tmp_rx_buf_alloc_fail;
 			rx_desc_err_dropped_pkt += tmp_rx_desc_err_dropped_pkt;
 			rx_hsplit_unsplit_pkt += tmp_rx_hsplit_unsplit_pkt;
+			xdp_tx_errors += tmp_xdp_tx_errors;
+			xdp_redirect_errors += tmp_xdp_redirect_errors;
 		}
 	}
 	for (tx_pkts = 0, tx_bytes = 0, tx_dropped = 0, ring = 0;
@@ -250,8 +257,8 @@ gve_get_ethtool_stats(struct net_device *netdev,
 	data[i++] = rx_bytes;
 	data[i++] = tx_bytes;
 	/* total rx dropped packets */
-	data[i++] = rx_skb_alloc_fail + rx_buf_alloc_fail +
-		    rx_desc_err_dropped_pkt;
+	data[i++] = rx_skb_alloc_fail + rx_desc_err_dropped_pkt +
+		    xdp_tx_errors + xdp_redirect_errors;
 	data[i++] = tx_dropped;
 	data[i++] = priv->tx_timeo_cnt;
 	data[i++] = rx_skb_alloc_fail;
@@ -330,6 +337,9 @@ gve_get_ethtool_stats(struct net_device *netdev,
 				tmp_rx_buf_alloc_fail = rx->rx_buf_alloc_fail;
 				tmp_rx_desc_err_dropped_pkt =
 					rx->rx_desc_err_dropped_pkt;
+				tmp_xdp_tx_errors = rx->xdp_tx_errors;
+				tmp_xdp_redirect_errors =
+					rx->xdp_redirect_errors;
 			} while (u64_stats_fetch_retry(&priv->rx[ring].statss,
 						       start));
 			data[i++] = tmp_rx_bytes;
@@ -340,8 +350,9 @@ gve_get_ethtool_stats(struct net_device *netdev,
 			data[i++] = rx->rx_frag_alloc_cnt;
 			/* rx dropped packets */
 			data[i++] = tmp_rx_skb_alloc_fail +
-				tmp_rx_buf_alloc_fail +
-				tmp_rx_desc_err_dropped_pkt;
+				    tmp_rx_desc_err_dropped_pkt +
+				    tmp_xdp_tx_errors +
+				    tmp_xdp_redirect_errors;
 			data[i++] = rx->rx_copybreak_pkt;
 			data[i++] = rx->rx_copied_pkt;
 			/* stats from NIC */
-- 
2.53.0.rc1.225.gd81095ad13-goog

