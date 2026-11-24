Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795559424;
	b=AZk9PmBGVVYoaMbJKFxWHzELbe8xT2iCpmY+MelbfEY7x/S1VjkoIIEYDRZqHGHCyeq/
	 mnKJ5ol8Yfc8haXV21NcoKrbQmfEHM0SJm1ETbpyzndodfwd+IwxhVlcJx4bsWFEhR2Fe
	 0H8scOfi7LxDqw9Hn9YpUijHXqxl+H7YUOapcakbVKEuFLOEcxIEr9SAGXoelPAMTx6Fl
	 5licvRsP+YPByHxPBRswEGlQobWvpNShcPRIE2FpkhS10OQZi1Iw81+33vKb+1qN8klGA
	 OgDwmXrRtQKnAO3xFKHBkkVCKeWIE2mnyL4z4TvFHctzR/Vcb8SrJ+wNwqpt17ArsDg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795559424;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:Mime-Version:
	 X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=ycxX1BdIyqk5KPu/81NCSXj9/1Fa8M/RreVYaVwcZRQ=;
	b=CxCYXwuy9zQpFOgAryjdOeZOyIwGiW1yeuJ/TCi8maAaEIx3pihvuwwYc8PKC/+b+vLq
	 GCUjZbLK8GW9lq/g7QsXtC2okZ0ct1Ut+FP21qAhVNsKx9GRxilkUdCSaIG2ycKqCocwb
	 gO2cGrmZMchn+LANympyCzM3BVuChd071RAS7m32YLN/9DhKXhBtw36nmqQTzfBmzzj4z
	 gQ3nFRvebV//Y5brcybBHO/x/VuVT+25puwZP7Fr81YPButehenD89OpsGjl1i2bQFGfQ
	 9yMIngtxyCtvEijfi1nsSTGa9oHGCW82mMZ0GlmcaQBKBDJOi4sjGY9kXuePpws6rSA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--joshwash.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=kquJf229;
	arc=none smtp.remote-ip=209.85.214.200
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82786606A321
	for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 22:30:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 82786606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--joshwash.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=kquJf229
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2ed2c307e62so63955625ad.0
        for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 14:30:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795559424; x=1796164224; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ycxX1BdIyqk5KPu/81NCSXj9/1Fa8M/RreVYaVwcZRQ=;
        b=kquJf229EjCKKi4CkyfAgAQyS8BYji+nruMNvy6PNPF8bkei7ATbVRk2sAEe6Gl8i6
         7oZrBF26dU8yhgZqw7W+21TxTbDDRTLwH/UhHREnpmN3GyS8BHancBGYwwL+jINBNKTe
         o3aGdUTmHWqJEWk8dT3zz6dlWwn1m+pFIvJq2DPq59Y3zIOU3xnqJoq2XgVbIJs0MNG6
         7oaW7YrNuV1EQDuxKxmHiL2W5RIcI59utNRzOozNnrbNIH1AAflfVTfOWqC22meeJ8G1
         9Ood9m2KPsEoNeWrBTov/5NCdJ9K5SfXwF1lfE64OUc1DMJ3xTcXiHUWhQAKm6LzZU64
         SUWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795559424; x=1796164224;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ycxX1BdIyqk5KPu/81NCSXj9/1Fa8M/RreVYaVwcZRQ=;
        b=IkA8fT3HiF6SyjD9YMKt1AXwjF1LXWL9vTaOrA6FB9vHwDcn0fkH6UZeboNyTMAHmH
         /wzAzHQ5/eBBdcMIV9hNnsBWgi7IJCY8buMmDp8Xg7kp/Qf+6h9VhKrUrWzXenXZ0JJI
         AMuPZgP0DmKUdkwZYri9wK6kBtm91MSj8caLt/0yWIEMRZp8c6y68CInobHBRMDT7KMF
         a+aMBzaFXQ3PVsoqk3yd1iJgSScwM4Ay61z8iaEbSuHcba6te7R0TbWaTRs6gE4mVDrg
         6l/7hdKuqJl5shB3EDMjxIZUbZ6Itq+6MZzPdwJE5r0iWVOSbmxtvRTUJwH0sKSXiW+W
         IORQ==
X-Forwarded-Encrypted: i=1; AL+hErHkQ2bEHgQ40LCkbXIjXveXQuBnKfE+kG3hUKXlL7vjTPGpt5v1qBwNryQu+Z8od5fiYng=@vger.kernel.org
X-Gm-Message-State: APuU4Z9r52SJHPmG1Gi9IvblFtK5S+vbSp4VBG0BLGI2rW6mfeUWTBf+
	fTLnaGN1lbBcLDRp6+3ebh2pIdQzdmLcLWPEtfQZUHgV+bTN809+qZPJMrhC470yYmTEtRJ7RLS
	TMSdJjzpqisxZCQ==
X-Received: from plbaz1.prod.google.com ([2002:a17:902:a581:b0:2ef:d0d7:afa3])
 (user=joshwash job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:41c6:b0:2ed:f9c:3e5b with SMTP id d9443c01a7336-2f03f17d5e7mr167576995ad.52.1795559423515;
 Tue, 24 Nov 2026 14:30:23 -0800 (PST)
Date: Tue, 24 Nov 2026 14:30:09 -0800
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.1.839.g22a8290db9-goog
Message-ID: <20261124223009.331936-1-joshwash@google.com>
Subject: [PATCH net-next] gve: add rx_critical_low_bufs ethtool statistic
From: Joshua Washington <joshwash@google.com>
To: netdev@vger.kernel.org
Cc: Joshua Washington <joshwash@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Jordan Rhee <jordanrhee@google.com>, 
	Willem de Bruijn <willemb@google.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
	Matt Olson <maolson@google.com>, Jacob Keller <jacob.e.keller@intel.com>, 
	Debarghya Kundu <debarghyak@google.com>, Ankit Garg <nktgrg@google.com>, 
	Eddie Phillips <eddiephillips@google.com>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Eddie Phillips <eddiephillips@google.com>

Commit b65352a1bac6 ("gve: fix Rx queue stall on alloc failure") added a
starvation recovery timer to the DQO Rx path to prevent permanent queue
stalls under severe memory pressure.

Existing allocation failure counters (such as rx_buf_alloc_fail and
netdev queue alloc_fail) count every individual failed buffer allocation
and do not distinguish transient, recoverable failures from severe
buffer exhaustion where fewer than GVE_RX_BUF_THRESH_DQO (32) buffers
remain available to hardware and starvation recovery is required.

Add a new "rx_critical_low_bufs" ethtool statistic for the DQO Rx path
in gve_rx_post_buffers_dqo(). The counter increments on each refill
attempt that leaves fewer than GVE_RX_BUF_THRESH_DQO buffers available
to hardware and arms or reschedules the starvation recovery timer via
mod_timer(). It is exposed both per-queue (rx_critical_low_bufs[%u]) and
as an interface-wide aggregate (rx_critical_low_bufs).

Signed-off-by: Eddie Phillips <eddiephillips@google.com>
Signed-off-by: Jordan Rhee <jordanrhee@google.com>
Signed-off-by: Joshua Washington <joshwash@google.com>
---
 drivers/net/ethernet/google/gve/gve.h         |  1 +
 drivers/net/ethernet/google/gve/gve_ethtool.c | 17 ++++++++++++++---
 drivers/net/ethernet/google/gve/gve_rx_dqo.c  |  3 +++
 3 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve.h b/drivers/net/ethernet/google/gve/gve.h
index 143d8cd595aa..90b633eb39ea 100644
--- a/drivers/net/ethernet/google/gve/gve.h
+++ b/drivers/net/ethernet/google/gve/gve.h
@@ -327,6 +327,7 @@ struct gve_rx_ring {
 	u64 rx_frag_flip_cnt; /* free-running count of rx segments where page_flip was used */
 	u64 rx_frag_copy_cnt; /* free-running count of rx segments copied */
 	u64 rx_frag_alloc_cnt; /* free-running count of rx page allocations */
+	u64 rx_critical_low_bufs; /* count of critical low buffer events */
 	u64 xdp_tx_errors;
 	u64 xdp_redirect_errors;
 	u64 xdp_alloc_fails;
diff --git a/drivers/net/ethernet/google/gve/gve_ethtool.c b/drivers/net/ethernet/google/gve/gve_ethtool.c
index a3220c651438..f04d06ffd673 100644
--- a/drivers/net/ethernet/google/gve/gve_ethtool.c
+++ b/drivers/net/ethernet/google/gve/gve_ethtool.c
@@ -43,7 +43,7 @@ static const char gve_gstrings_main_stats[][ETH_GSTRING_LEN] = {
 	"rx_packets", "rx_hsplit_pkt", "tx_packets", "rx_bytes",
 	"tx_bytes", "rx_dropped", "tx_dropped", "tx_timeouts",
 	"rx_skb_alloc_fail", "rx_buf_alloc_fail", "rx_desc_err_dropped_pkt",
-	"rx_hsplit_unsplit_pkt",
+	"rx_hsplit_unsplit_pkt", "rx_critical_low_bufs",
 	"interface_up_cnt", "interface_down_cnt", "reset_cnt",
 	"page_alloc_fail", "dma_mapping_error", "stats_report_trigger_cnt",
 };
@@ -52,6 +52,7 @@ static const char gve_gstrings_rx_stats[][ETH_GSTRING_LEN] = {
 	"rx_posted_desc[%u]", "rx_completed_desc[%u]", "rx_consumed_desc[%u]",
 	"rx_bytes[%u]", "rx_hsplit_bytes[%u]", "rx_cont_packet_cnt[%u]",
 	"rx_frag_flip_cnt[%u]", "rx_frag_copy_cnt[%u]", "rx_frag_alloc_cnt[%u]",
+	"rx_critical_low_bufs[%u]",
 	"rx_dropped_pkt[%u]", "rx_copybreak_pkt[%u]", "rx_copied_pkt[%u]",
 	"rx_queue_drop_cnt[%u]", "rx_no_buffers_posted[%u]",
 	"rx_drops_packet_over_mru[%u]", "rx_drops_invalid_checksum[%u]",
@@ -152,11 +153,13 @@ gve_get_ethtool_stats(struct net_device *netdev,
 	u64 tmp_rx_pkts, tmp_rx_hsplit_pkt, tmp_rx_bytes, tmp_rx_hsplit_bytes,
 		tmp_rx_skb_alloc_fail, tmp_rx_buf_alloc_fail,
 		tmp_rx_desc_err_dropped_pkt, tmp_rx_hsplit_unsplit_pkt,
+		tmp_rx_critical_low_bufs,
 		tmp_tx_pkts, tmp_tx_bytes,
 		tmp_xdp_tx_errors, tmp_xdp_redirect_errors;
 	u64 rx_buf_alloc_fail, rx_desc_err_dropped_pkt, rx_hsplit_unsplit_pkt,
-		rx_pkts, rx_hsplit_pkt, rx_skb_alloc_fail, rx_bytes, tx_pkts, tx_bytes,
-		tx_dropped, xdp_tx_errors, xdp_redirect_errors;
+		rx_critical_low_bufs, rx_pkts, rx_hsplit_pkt, rx_skb_alloc_fail,
+		rx_bytes, tx_pkts, tx_bytes, tx_dropped, xdp_tx_errors,
+		xdp_redirect_errors;
 	int rx_base_stats_idx, max_rx_stats_idx, max_tx_stats_idx;
 	int stats_idx, stats_region_len, nic_stats_len;
 	struct stats *report_stats;
@@ -198,6 +201,7 @@ gve_get_ethtool_stats(struct net_device *netdev,
 	for (rx_pkts = 0, rx_bytes = 0, rx_hsplit_pkt = 0,
 	     rx_skb_alloc_fail = 0, rx_buf_alloc_fail = 0,
 	     rx_desc_err_dropped_pkt = 0, rx_hsplit_unsplit_pkt = 0,
+	     rx_critical_low_bufs = 0,
 	     xdp_tx_errors = 0, xdp_redirect_errors = 0,
 	     ring = 0;
 	     ring < priv->rx_cfg.num_queues; ring++) {
@@ -216,6 +220,8 @@ gve_get_ethtool_stats(struct net_device *netdev,
 					rx->rx_desc_err_dropped_pkt;
 				tmp_rx_hsplit_unsplit_pkt =
 					rx->rx_hsplit_unsplit_pkt;
+				tmp_rx_critical_low_bufs =
+					rx->rx_critical_low_bufs;
 				tmp_xdp_tx_errors = rx->xdp_tx_errors;
 				tmp_xdp_redirect_errors =
 					rx->xdp_redirect_errors;
@@ -228,6 +234,7 @@ gve_get_ethtool_stats(struct net_device *netdev,
 			rx_buf_alloc_fail += tmp_rx_buf_alloc_fail;
 			rx_desc_err_dropped_pkt += tmp_rx_desc_err_dropped_pkt;
 			rx_hsplit_unsplit_pkt += tmp_rx_hsplit_unsplit_pkt;
+			rx_critical_low_bufs += tmp_rx_critical_low_bufs;
 			xdp_tx_errors += tmp_xdp_tx_errors;
 			xdp_redirect_errors += tmp_xdp_redirect_errors;
 		}
@@ -263,6 +270,7 @@ gve_get_ethtool_stats(struct net_device *netdev,
 	data[i++] = rx_buf_alloc_fail;
 	data[i++] = rx_desc_err_dropped_pkt;
 	data[i++] = rx_hsplit_unsplit_pkt;
+	data[i++] = rx_critical_low_bufs;
 	data[i++] = priv->interface_up_cnt;
 	data[i++] = priv->interface_down_cnt;
 	data[i++] = priv->reset_cnt;
@@ -335,6 +343,8 @@ gve_get_ethtool_stats(struct net_device *netdev,
 				tmp_rx_buf_alloc_fail = rx->rx_buf_alloc_fail;
 				tmp_rx_desc_err_dropped_pkt =
 					rx->rx_desc_err_dropped_pkt;
+				tmp_rx_critical_low_bufs =
+					rx->rx_critical_low_bufs;
 				tmp_xdp_tx_errors = rx->xdp_tx_errors;
 				tmp_xdp_redirect_errors =
 					rx->xdp_redirect_errors;
@@ -346,6 +356,7 @@ gve_get_ethtool_stats(struct net_device *netdev,
 			data[i++] = rx->rx_frag_flip_cnt;
 			data[i++] = rx->rx_frag_copy_cnt;
 			data[i++] = rx->rx_frag_alloc_cnt;
+			data[i++] = tmp_rx_critical_low_bufs;
 			/* rx dropped packets */
 			data[i++] = tmp_rx_skb_alloc_fail +
 				    tmp_rx_desc_err_dropped_pkt +
diff --git a/drivers/net/ethernet/google/gve/gve_rx_dqo.c b/drivers/net/ethernet/google/gve/gve_rx_dqo.c
index 82ed5e48b00a..ff535c421118 100644
--- a/drivers/net/ethernet/google/gve/gve_rx_dqo.c
+++ b/drivers/net/ethernet/google/gve/gve_rx_dqo.c
@@ -437,6 +437,9 @@ void gve_rx_post_buffers_dqo(struct gve_rx_ring *rx)
 		 bufq->head) & bufq->mask;
 
 	if (num_bufs_avail_to_hw < GVE_RX_BUF_THRESH_DQO) {
+		u64_stats_update_begin(&rx->statss);
+		rx->rx_critical_low_bufs++;
+		u64_stats_update_end(&rx->statss);
 		mod_timer(&rx->starvation_timer,
 			  jiffies + msecs_to_jiffies(GVE_RX_NAPI_RESCHED_MS));
 	}

base-commit: 57f165ff2f30491bc3511d24a52ca516751a268b
-- 
2.56.1.831.g720f3f5937-goog

