Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DC83475329
	for <bpf@vger.kernel.org>; Mon, 12 Oct 2026 12:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791806692; cv=none; b=TAKHBp0MbfIAp6qVLU3V7w/aIBR3/SW3i2oczPcl6g2FjNPSj/dKzKZ9f/iwX6tyDafnS/Cs8LM4ZCQUOqSjx72/nCtcctk2NEhbbcWDnjtclksKLbSa2BkFH0YgUps4zg74vDGJKG0N4P50pg4ulKFtrVkXHOBpXKElDmcMbgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791806692; c=relaxed/simple;
	bh=9nW6Bh1PgdPuuQR5klHrW14owJJtbgF3mJskvRJ3R5M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Vroe0L73Q8U8arFW5dKXd5jLHwARca0A8HrW9Rfvzoc8hIqhmaaYQeZN7l6vSmY8o9wXkYA7gvAkBOxE+9z1UO9/XSeJzAuy6orZJJ+yu8my/xiiAoyCv0pX9ojZHL9ByZc94cj3aN3/QZXGrChcNrxePoakrr+71lyXaMLsFD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZhwTOwZM; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZhwTOwZM"
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-82478760557so1720120a34.3
        for <bpf@vger.kernel.org>; Mon, 12 Oct 2026 05:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791806689; x=1792411489; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ujJ26e4g4Q8zD0vGziAVKRfs4865WuCNTOUFVgy1XLA=;
        b=ZhwTOwZM7TzO64nqyhTA1OLu9/mb9nfU4jdrvl60I30as92o+CYlLzfZ0LwXB6yNOv
         JQxa8a1rOFJbZ8SFyloLJbeC5NLv9xVA9cxclvjpwMEud2furrDcPbxMsUb8/A/ONV4S
         jdmVpIKcmWS5h4zOUfHOfpW0xoOY0d9WPkDq10yKKQDB8xVKijah/Yf/+k2QFW+IGHuL
         n7fdLpU5Qg9hLuzvGUK6NLW9957H7SR+aFTCy5CIPnMRdFTCRar/ILuveFTFi26sEoYs
         /FwLQpO6CncS0Lv4P0ME75o3ykq+TE84GHOatsfhN65VSoJKMHEPgcsMXzynmhdZaHkc
         mmag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791806689; x=1792411489;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ujJ26e4g4Q8zD0vGziAVKRfs4865WuCNTOUFVgy1XLA=;
        b=WY65Z1mA+/I+omfIHVGDRV4yBm/GgVFMmA7iNb46WsLgNlczKuQEV0qR+c7BxyV4D9
         F0CORorYb5IH429JHHBmYJSa+0qn88V2RvIxSj+Vp+jLRYM1XqzO1j+pXsLxG0BdpSnB
         SneDueuZ7GmMfqwKaBr2ZWaQUvPC29aPZBN2x3E0/J9c4B6kEov2id8X8WALYWiRcecB
         5DVaYmIoBfLHFZ5wViNduqZqoAO6IKhVew81+HbsYBoKaJnwKbbL7LJs58CRMzyVem2u
         B9IEg6E1jTBlH37EnPkeLmEMjW/fJz63UIjuXEhVg7KCkPeBdX4AZes7sy1K6ZxyErSO
         qobQ==
X-Forwarded-Encrypted: i=1; AKwUvBzjQTvAT4S+PtSRpjhyDVuxn9K4BKu7Le75LsMP8XSzVdwWuqeFF+KtQLMZSnRHUR1KM38=@vger.kernel.org
X-Gm-Message-State: AFq9FYI50yWYhser/Covt8X65bIYvut1zbMpbX9+FBUFsS/u9vmXgKbj
	eWUJsgn6J6tre6Yh5RAfviRdbtjmemLwapr+N5HQ+vEvkCSv28N2remc
X-Gm-Gg: AYBFou2BV6VFKDMqUDEsSgHxF/XY8j5INJ+7UdSc10iVQ0Hz78kEaDlHZG21kPOucZj
	0NrTjJd/w9/rDfAPr9GfS/IGJbcqtW5O3dRizXNTkLikcvVnCgNMgSe0YyJzQ7pSiYpqfnI1knU
	xEwkzIWth+EIfg8w6jgOzdq4r9qp9q21RZG/gY1bUFBPFFm2zO6yi0iZDpzyzi04YDcMTbkPe2l
	rkhtoKOOAt2Ov1OvOknSg8V3a9l4i3zvmqTsqvWRhYfJ4MZAD245Z5Cecaj3j6Ou3IwE3gC8pQP
	ZGU/TXclllnurma9VcZzuoU/BLpBSEO95oEczLH7oYMQ9c13/mDvR+VIs1UtV1FrcmHzSzOPL1W
	nLwWZ82uyH/whco2xj23CJXr0NK6kxI4qar1JkgSwtsMNw3bFOShgEcU/6pqprq5nyOuIqzHzdj
	MHKkD5bnPkf2QtEQf45oW9ukmeWd598LuqyowY0j1FD2AzR+7dENo6m02P3e/xGFf/ZQM=
X-Received: by 2002:a05:6830:718d:b0:81b:8032:716d with SMTP id 46e09a7af769-83096db95fcmr8352737a34.20.1791806688926;
        Mon, 12 Oct 2026 05:04:48 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:6::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-83038f82468sm9692429a34.11.2026.10.12.05.04.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 05:04:48 -0700 (PDT)
From: Daniel Zahka <daniel.zahka@gmail.com>
Date: Mon, 12 Oct 2026 05:04:34 -0700
Subject: [PATCH net-next v2 1/4] eth: mpnic: count packets, bytes, and
 drops per ring
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261012-mpnic-counters3-v2-1-8afba81c2d5a@gmail.com>
References: <20261012-mpnic-counters3-v2-0-8afba81c2d5a@gmail.com>
In-Reply-To: <20261012-mpnic-counters3-v2-0-8afba81c2d5a@gmail.com>
To: Alexander Duyck <alexanderduyck@fb.com>, 
 Jakub Kicinski <kuba@kernel.org>, kernel-team@meta.com, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, Eric Dumazet <edumazet@kernel.org>, 
 Eric Dumazet <edumazet@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org
X-Mailer: b4 0.13.0

Keep packet, byte and drop counters on each Tx work, Tx completion, and
Rx completion queue. Report them to the core via the rtnl_link_stats64
interface.

Rx completion queues also count errors. Frames the device marked with an
uncorrectable error are counted as errors, and frames that fail for any
other reason are counted as drops.

All packets cleaned from the TWQ during mpnic_flush() are counted as
drops, though completions for some of them may have been DMA'd into
the completion ring between the time mpnic_poll() last ran and before
mpnic_wait_all_queues_idle() returns. This is done for code simplicity.

An RCU approach is used because ndo_get_stats64 is not called with the
instance lock.

Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>

---
v2:
- count Rx frames dropped by the driver in rx_packets and rx_bytes
- disable BH instead of preemption around the Tx flush stats update
---
 drivers/net/ethernet/meta/mpnic/mpnic_netdev.c |  76 +++++++++++++++
 drivers/net/ethernet/meta/mpnic/mpnic_netdev.h |  26 ++++++
 drivers/net/ethernet/meta/mpnic/mpnic_txrx.c   | 123 +++++++++++++++++++++++--
 drivers/net/ethernet/meta/mpnic/mpnic_txrx.h   |  24 +++++
 4 files changed, 241 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/meta/mpnic/mpnic_netdev.c b/drivers/net/ethernet/meta/mpnic/mpnic_netdev.c
index bd10df4a9d46..5164475a0f94 100644
--- a/drivers/net/ethernet/meta/mpnic/mpnic_netdev.c
+++ b/drivers/net/ethernet/meta/mpnic/mpnic_netdev.c
@@ -28,6 +28,8 @@ static int mpnic_open(struct net_device *netdev)
 	if (err)
 		goto err_free_resources;
 
+	mpnic_stats_attach_rings(mpn);
+
 	mpnic_enable(mpn);
 	mpnic_fill(mpn);
 	mpnic_napi_enable(mpn);
@@ -60,6 +62,8 @@ static int mpnic_stop(struct net_device *netdev)
 	mpnic_wait_all_queues_idle(mpn->mpd);
 	mpnic_flush(mpn);
 
+	mpnic_stats_fold_rings(mpn);
+
 	mpnic_reset_netif_queues(mpn);
 	mpnic_free_resources(mpn);
 	mpnic_free_napi_vectors(mpn);
@@ -67,11 +71,79 @@ static int mpnic_stop(struct net_device *netdev)
 	return 0;
 }
 
+static void
+mpnic_get_stats64(struct net_device *dev, struct rtnl_link_stats64 *stats64)
+{
+	struct mpnic_net *mpn = netdev_priv(dev);
+	u64 bytes, packets, dropped, errors;
+	struct mpnic_queue_stats *stats;
+	struct mpnic_base_stats *base;
+	unsigned int start, i;
+
+	rcu_read_lock();
+
+	base = rcu_dereference(mpn->stats.base);
+
+	stats64->tx_bytes = base->tx.bytes;
+	stats64->tx_packets = base->tx.packets;
+	stats64->tx_dropped = base->tx.dropped;
+
+	stats64->rx_bytes = base->rx.bytes;
+	stats64->rx_packets = base->rx.packets;
+	stats64->rx_dropped = base->rx.dropped;
+	stats64->rx_errors = base->rx.errors;
+
+	for (i = 0; i < base->num_tx_queues; i++) {
+		struct mpnic_ring *txr = base->txr[i];
+		struct mpnic_q_triad *qt;
+
+		qt = container_of(txr, struct mpnic_q_triad, sub0);
+
+		stats = &qt->cmpl.stats;
+		do {
+			start = u64_stats_fetch_begin(&stats->syncp);
+			bytes = u64_stats_read(&stats->tcq.bytes);
+			packets = u64_stats_read(&stats->tcq.packets);
+		} while (u64_stats_fetch_retry(&stats->syncp, start));
+
+		stats = &txr->stats;
+		do {
+			start = u64_stats_fetch_begin(&stats->syncp);
+			dropped = u64_stats_read(&stats->twq.dropped);
+		} while (u64_stats_fetch_retry(&stats->syncp, start));
+
+		stats64->tx_bytes += bytes;
+		stats64->tx_packets += packets;
+		stats64->tx_dropped += dropped;
+	}
+
+	for (i = 0; i < base->num_rx_queues; i++) {
+		struct mpnic_ring *rxr = base->rxr[i];
+
+		stats = &rxr->stats;
+		do {
+			start = u64_stats_fetch_begin(&stats->syncp);
+			bytes = u64_stats_read(&stats->rcq.bytes);
+			packets = u64_stats_read(&stats->rcq.packets);
+			dropped = u64_stats_read(&stats->rcq.dropped);
+			errors = u64_stats_read(&stats->rcq.errors);
+		} while (u64_stats_fetch_retry(&stats->syncp, start));
+
+		stats64->rx_bytes += bytes;
+		stats64->rx_packets += packets;
+		stats64->rx_dropped += dropped;
+		stats64->rx_errors += errors;
+	}
+
+	rcu_read_unlock();
+}
+
 static const struct net_device_ops mpnic_netdev_ops = {
 	.ndo_open		= mpnic_open,
 	.ndo_stop		= mpnic_stop,
 	.ndo_validate_addr	= eth_validate_addr,
 	.ndo_start_xmit		= mpnic_xmit_frame,
+	.ndo_get_stats64	= mpnic_get_stats64,
 };
 
 /**
@@ -110,6 +182,10 @@ struct net_device *mpnic_netdev_alloc(struct mpnic_dev *mpd)
 	mpn->netdev = netdev;
 	mpn->mpd = mpd;
 
+	mpn->stats.buf[0].txr = mpn->tx;
+	mpn->stats.buf[0].rxr = mpn->rx;
+	RCU_INIT_POINTER(mpn->stats.base, &mpn->stats.buf[0]);
+
 	mpn->txq_size = MPNIC_TXQ_SIZE_DEFAULT;
 	mpn->hpq_size = MPNIC_HPQ_SIZE_DEFAULT;
 	mpn->ppq_size = MPNIC_PPQ_SIZE_DEFAULT;
diff --git a/drivers/net/ethernet/meta/mpnic/mpnic_netdev.h b/drivers/net/ethernet/meta/mpnic/mpnic_netdev.h
index ccb0929f9180..a61249d12a04 100644
--- a/drivers/net/ethernet/meta/mpnic/mpnic_netdev.h
+++ b/drivers/net/ethernet/meta/mpnic/mpnic_netdev.h
@@ -4,11 +4,32 @@
 #ifndef _MPNIC_NETDEV_H_
 #define _MPNIC_NETDEV_H_
 
+#include <linux/netdevice.h>
+#include <linux/rcupdate.h>
 #include <linux/types.h>
 
 #include "mpnic.h"
 #include "mpnic_txrx.h"
 
+struct mpnic_base_stats {
+	struct {
+		u64 packets;
+		u64 bytes;
+		u64 dropped;
+	} tx;
+	struct {
+		u64 packets;
+		u64 bytes;
+		u64 dropped;
+		u64 errors;
+	} rx;
+
+	unsigned int num_tx_queues;
+	unsigned int num_rx_queues;
+	struct mpnic_ring **txr;
+	struct mpnic_ring **rxr;
+};
+
 struct mpnic_net {
 	struct mpnic_ring *tx[MPNIC_MAX_TXQS];
 	struct mpnic_ring *rx[MPNIC_MAX_RXQS];
@@ -26,6 +47,11 @@ struct mpnic_net {
 	u16 num_napi;
 	u16 num_tx_queues;
 	u16 num_rx_queues;
+
+	struct {
+		struct mpnic_base_stats __rcu *base;
+		struct mpnic_base_stats buf[2];
+	} stats;
 };
 
 struct net_device *mpnic_netdev_alloc(struct mpnic_dev *mpd);
diff --git a/drivers/net/ethernet/meta/mpnic/mpnic_txrx.c b/drivers/net/ethernet/meta/mpnic/mpnic_txrx.c
index 5495e9a9aa65..d5185e64f804 100644
--- a/drivers/net/ethernet/meta/mpnic/mpnic_txrx.c
+++ b/drivers/net/ethernet/meta/mpnic/mpnic_txrx.c
@@ -6,6 +6,7 @@
 #include <linux/iopoll.h>
 #include <linux/pci.h>
 #include <linux/slab.h>
+#include <net/netdev_lock.h>
 #include <net/page_pool/helpers.h>
 
 #include "mpnic.h"
@@ -228,6 +229,10 @@ static netdev_tx_t mpnic_xmit_frame_ring(struct sk_buff *skb,
 err_drop:
 	mpnic_tx_flush_doorbell(ring);
 
+	u64_stats_update_begin(&ring->stats.syncp);
+	u64_stats_inc(&ring->stats.twq.dropped);
+	u64_stats_update_end(&ring->stats.syncp);
+
 	return NETDEV_TX_OK;
 }
 
@@ -239,10 +244,12 @@ netdev_tx_t mpnic_xmit_frame(struct sk_buff *skb, struct net_device *dev)
 }
 
 static void mpnic_clean_twq0(struct mpnic_napi_vector *nv, int napi_budget,
-			     struct mpnic_ring *ring, bool discard,
+			     struct mpnic_q_triad *qt, bool discard,
 			     unsigned int hw_head)
 {
 	u64 total_bytes = 0, total_packets = 0;
+	struct mpnic_ring *ring = &qt->sub0;
+	struct mpnic_ring *cmpl = &qt->cmpl;
 	unsigned int head = ring->head;
 	struct netdev_queue *txq;
 	unsigned int clean_desc;
@@ -288,8 +295,19 @@ static void mpnic_clean_twq0(struct mpnic_napi_vector *nv, int napi_budget,
 
 	ring->head = head;
 
-	if (discard)
+	if (discard) {
+		local_bh_disable();
+		u64_stats_update_begin(&ring->stats.syncp);
+		u64_stats_add(&ring->stats.twq.dropped, total_packets);
+		u64_stats_update_end(&ring->stats.syncp);
+		local_bh_enable();
 		return;
+	}
+
+	u64_stats_update_begin(&cmpl->stats.syncp);
+	u64_stats_add(&cmpl->stats.tcq.bytes, total_bytes);
+	u64_stats_add(&cmpl->stats.tcq.packets, total_packets);
+	u64_stats_update_end(&cmpl->stats.syncp);
 
 	txq = mpnic_txring_txq(nv->napi.dev, ring);
 	netif_txq_completed_wake(txq, total_packets, total_bytes,
@@ -346,7 +364,7 @@ static void mpnic_clean_tcq(struct mpnic_napi_vector *nv,
 	cmpl->head = head;
 
 	if (head0 >= 0)
-		mpnic_clean_twq0(nv, napi_budget, &qt->sub0, false, head0);
+		mpnic_clean_twq0(nv, napi_budget, qt, false, head0);
 }
 
 static void mpnic_bd_prep(struct mpnic_ring *bdq, u32 idx, struct page *page)
@@ -560,9 +578,9 @@ static void mpnic_put_pkt_buff(struct mpnic_pkt_ctxt *ctxt, bool napi)
 static int mpnic_clean_rcq(struct mpnic_napi_vector *nv,
 			   struct mpnic_q_triad *qt, int budget)
 {
+	unsigned int packets = 0, bytes = 0, dropped = 0, errors = 0;
 	struct mpnic_ring *rcq = &qt->cmpl;
 	struct mpnic_rcq_state *state;
-	unsigned int packets = 0;
 	__le64 *raw_rcd, done;
 	u32 head = rcq->head;
 
@@ -594,13 +612,20 @@ static int mpnic_clean_rcq(struct mpnic_napi_vector *nv,
 
 			if (likely(!(rcd &
 				     MPNIC_RCD_META_UNCORRECTABLE_ERR_MASK) &&
-				   !state->pkt.add_frag_failed))
+				   !state->pkt.add_frag_failed)) {
+				bytes += xdp_get_buff_len(&state->pkt.buff);
 				skb = xdp_build_skb_from_buff(&state->pkt.buff);
+			}
 
-			if (likely(skb))
+			if (likely(skb)) {
 				napi_gro_receive(&nv->napi, skb);
-			else
+			} else {
 				mpnic_put_pkt_buff(&state->pkt, true);
+				if (rcd & MPNIC_RCD_META_UNCORRECTABLE_ERR_MASK)
+					errors++;
+				else
+					dropped++;
+			}
 
 			state->pkt.buff.data_hard_start = NULL;
 			packets++;
@@ -619,6 +644,13 @@ static int mpnic_clean_rcq(struct mpnic_napi_vector *nv,
 
 	rcq->head = head;
 
+	u64_stats_update_begin(&rcq->stats.syncp);
+	u64_stats_add(&rcq->stats.rcq.packets, packets - errors);
+	u64_stats_add(&rcq->stats.rcq.bytes, bytes);
+	u64_stats_add(&rcq->stats.rcq.dropped, dropped);
+	u64_stats_add(&rcq->stats.rcq.errors, errors);
+	u64_stats_update_end(&rcq->stats.syncp);
+
 	/* Allocate buffers, force dma_wmb(), and then start writing tails */
 	mpnic_fill_qt_bdqs(qt);
 
@@ -661,6 +693,80 @@ static irqreturn_t mpnic_msix_clean_rings(int __always_unused irq, void *data)
 	return IRQ_HANDLED;
 }
 
+static void mpnic_aggregate_ring_twq_counters(struct mpnic_base_stats *base,
+					      struct mpnic_ring *twq)
+{
+	base->tx.dropped += u64_stats_read(&twq->stats.twq.dropped);
+}
+
+static void mpnic_aggregate_ring_tcq_counters(struct mpnic_base_stats *base,
+					      struct mpnic_ring *tcq)
+{
+	base->tx.packets += u64_stats_read(&tcq->stats.tcq.packets);
+	base->tx.bytes += u64_stats_read(&tcq->stats.tcq.bytes);
+}
+
+static void mpnic_aggregate_ring_rcq_counters(struct mpnic_base_stats *base,
+					      struct mpnic_ring *rcq)
+{
+	base->rx.packets += u64_stats_read(&rcq->stats.rcq.packets);
+	base->rx.bytes += u64_stats_read(&rcq->stats.rcq.bytes);
+	base->rx.dropped += u64_stats_read(&rcq->stats.rcq.dropped);
+	base->rx.errors += u64_stats_read(&rcq->stats.rcq.errors);
+}
+
+static struct mpnic_base_stats *mpnic_base_stats_prepare(struct mpnic_net *mpn)
+{
+	struct mpnic_base_stats *old, *new;
+
+	old = netdev_lock_dereference(mpn->stats.base, mpn->netdev);
+	new = &mpn->stats.buf[old == &mpn->stats.buf[0]];
+	*new = *old;
+
+	return new;
+}
+
+void mpnic_stats_fold_rings(struct mpnic_net *mpn)
+{
+	struct mpnic_base_stats *new;
+	int i, j, t;
+
+	new = mpnic_base_stats_prepare(mpn);
+	new->num_tx_queues = 0;
+	new->num_rx_queues = 0;
+
+	for (i = 0; i < mpn->num_napi; i++) {
+		struct mpnic_napi_vector *nv = mpn->napi[i];
+
+		if (!nv)
+			continue;
+
+		for (t = 0; t < nv->txt_count; t++) {
+			struct mpnic_q_triad *qt = &nv->qt[t];
+
+			mpnic_aggregate_ring_twq_counters(new, &qt->sub0);
+			mpnic_aggregate_ring_tcq_counters(new, &qt->cmpl);
+		}
+
+		for (j = 0; j < nv->rxt_count; j++, t++)
+			mpnic_aggregate_ring_rcq_counters(new, &nv->qt[t].cmpl);
+	}
+
+	rcu_assign_pointer(mpn->stats.base, new);
+	synchronize_net();
+}
+
+void mpnic_stats_attach_rings(struct mpnic_net *mpn)
+{
+	struct mpnic_base_stats *new;
+
+	new = mpnic_base_stats_prepare(mpn);
+	new->num_tx_queues = mpn->num_tx_queues;
+	new->num_rx_queues = mpn->num_rx_queues;
+	rcu_assign_pointer(mpn->stats.base, new);
+	synchronize_net();
+}
+
 static void mpnic_free_napi_vector(struct mpnic_net *mpn,
 				   struct mpnic_napi_vector *nv)
 {
@@ -692,6 +798,7 @@ static void mpnic_ring_init(struct mpnic_ring *ring, u32 __iomem *doorbell,
 {
 	ring->doorbell = doorbell;
 	ring->q_idx = q_idx;
+	u64_stats_init(&ring->stats.syncp);
 }
 
 static int mpnic_alloc_napi_vector(struct mpnic_dev *mpd,
@@ -1326,7 +1433,7 @@ void mpnic_flush(struct mpnic_net *mpn)
 			struct netdev_queue *txq;
 
 			/* Clean the work queue of unprocessed work */
-			mpnic_clean_twq0(nv, 0, &qt->sub0, true, qt->sub0.tail);
+			mpnic_clean_twq0(nv, 0, qt, true, qt->sub0.tail);
 
 			txq = netdev_get_tx_queue(mpn->netdev, qt->sub0.q_idx);
 			netdev_tx_reset_queue(txq);
diff --git a/drivers/net/ethernet/meta/mpnic/mpnic_txrx.h b/drivers/net/ethernet/meta/mpnic/mpnic_txrx.h
index 767d87a36c35..7b44cf700e5b 100644
--- a/drivers/net/ethernet/meta/mpnic/mpnic_txrx.h
+++ b/drivers/net/ethernet/meta/mpnic/mpnic_txrx.h
@@ -8,6 +8,7 @@
 #include <linux/netdevice.h>
 #include <linux/skbuff.h>
 #include <linux/types.h>
+#include <linux/u64_stats_sync.h>
 #include <net/netdev_queues.h>
 #include <net/xdp.h>
 
@@ -84,6 +85,25 @@ struct mpnic_rcq_state {
 	struct mpnic_pg_ctxt payld;
 };
 
+struct mpnic_queue_stats {
+	union {
+		struct {
+			u64_stats_t dropped;
+		} twq;
+		struct {
+			u64_stats_t packets;
+			u64_stats_t bytes;
+		} tcq;
+		struct {
+			u64_stats_t packets;
+			u64_stats_t bytes;
+			u64_stats_t dropped;
+			u64_stats_t errors;
+		} rcq;
+	};
+	struct u64_stats_sync syncp;
+};
+
 struct mpnic_ring {
 	union {
 		struct mpnic_rcq_state *state;	/* RCQ */
@@ -110,6 +130,8 @@ struct mpnic_ring {
 		s32 deferred_meta;
 	};
 
+	struct mpnic_queue_stats stats;
+
 	/* Slow path fields follow */
 	dma_addr_t dma;			/* Phys addr of descriptor memory */
 	size_t size;			/* Size of descriptor ring in memory */
@@ -142,6 +164,8 @@ struct mpnic_napi_vector {
 netdev_tx_t mpnic_xmit_frame(struct sk_buff *skb, struct net_device *dev);
 int mpnic_alloc_napi_vectors(struct mpnic_net *mpn);
 void mpnic_free_napi_vectors(struct mpnic_net *mpn);
+void mpnic_stats_attach_rings(struct mpnic_net *mpn);
+void mpnic_stats_fold_rings(struct mpnic_net *mpn);
 int mpnic_alloc_resources(struct mpnic_net *mpn);
 void mpnic_free_resources(struct mpnic_net *mpn);
 int mpnic_set_netif_queues(struct mpnic_net *mpn);

-- 
2.52.0

