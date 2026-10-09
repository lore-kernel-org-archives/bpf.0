Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C63AE4D0A12
	for <bpf@vger.kernel.org>; Fri,  9 Oct 2026 11:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791545734; cv=none; b=IfB8aHlH9KBWbv3hqmd68VuKOQ4sl6nzbEOQSGH0cNHdvaqY77lxeFx0tUnOYpeje1pEtYQ+Zro6Cd/k+Y5DrW0i0+EpP4ELZsyRlPxPVwoaVYvyrxzEbUcr7aR/0ZXdPvd7fcJd5AWa6lDx9mbpIeOpCVyrPIsc6CXwBeCUEtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791545734; c=relaxed/simple;
	bh=eRG8WvF1bsjLPC0MjjmZR0uNw9zvAMam79yEOqb8sT8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BdNbMH4Uf//DbhegpYoQgFHN2OsZ0ZYeDUvXM15K/rjiG4jEim50cy2l2yi0STsY/knG2y8oyYI6RCYDvG40SxVp35Sr8OF93VQ6UCvSE16XQDYEheGTEd64DeJTLBrgp8cJ7A970bypMi/kSgL8qfy4khlpEImzb3Uf1zcWTcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=adjVrIgd; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="adjVrIgd"
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-6dde81a6820so4785003eaf.2
        for <bpf@vger.kernel.org>; Fri, 09 Oct 2026 04:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791545721; x=1792150521; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DS9A7YoCLm+UzG8nxic/xw1Qa1nYtCBqz/7ErKQAzHI=;
        b=adjVrIgd83y8cPrUJst7eS0b69LiziPK1/vSXia7tR3O5dqu+hCm9IRTNPTVvoPYiF
         2zBtKfNp7ffHSHsK6LZ08wGF5HANaS9cdTvg8mzMjVxiC7WeZ1n3J+x3rWI12VSirud5
         FrGbUfkYu9Ub3dQUrmfFg7EHcQozJs9GTxj0vZLxpbi+4IC1am5Z7miicVjJLS2IA2zE
         fjs6t9IFAsgTIlzZ+2qs5MaAIlhZhEDbAia9eYbT0zMDj/GByN6hiYlGwYy6tJpJwS10
         mLsyMVHNshDc8DqPwWT28YnPEJwK5nfjeGPdrY603NGqEvgG9hL89pbgIp414wlaxSa/
         gvjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791545721; x=1792150521;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DS9A7YoCLm+UzG8nxic/xw1Qa1nYtCBqz/7ErKQAzHI=;
        b=wxshoo8K61Uhufc0MQKvYituir2muFdASicpSC3DJ2iZaNbD1qNq3baRWPuwZrXkdo
         yacE+WvQSShdGr8I3N1850Qjb6+CrNBa19+CASiMMOiOO4tZuiRGzKr5Y/q2OXZuJbMk
         ViyROVAfwj+vkJk0kJA45s60TlS4Fmqn3iVxM0lc/n7pU6e5GJOH3AW8WwDnqP1Y7iyN
         A3HMJeTyZNt+JOoyvI7+imMnV08HEgNlwBotkni3v6fF0JMUfHc0BQ/sejypgBJceKw+
         zkw955LkkwIRCcVYtU71OSsTEJU2IAuvxE0TQO+hja0n3+LxryukSHpVkH+7BMq25Nhj
         +How==
X-Forwarded-Encrypted: i=1; AKwUvBzb2ZcnurVCLCjqQyJmfnVfdEj9VoRapPNfCqNz4KGY+InoQCN8MnKdrOJ7kG3lywCPz4g=@vger.kernel.org
X-Gm-Message-State: AFuF++lIiz6w+vy6t6sHbZHOkF1R/1GRrWr61SQsoSxY/CFCBUuMQW1s
	otBj+tWj7KolKZc7n30c9B+NLBxLo6dHC6ojrnBUFZxE9/NlJxkW36pS
X-Gm-Gg: AYBFou2hY4ZGk9dUGBuN05A86DVLjONTCXug/yUDrVkvgsK/zuyXMzjy4S3myX09jzP
	tTHQtSY24kcsGk2WVfiSNQG7xKbnoE1XhX1G1wG2o8XnfLIw7wGKImlrs/uIoGSGXndxiBxtEpI
	J5aa+DLgHT7s9VFw7PrsPmBqcgoUHRKDs4kV9lN8eZ+uBxIctmSLK8hfoe61Ss2H/WXiSQqzjte
	KLwpeIG/GrZQBkSnxkK9KaF60H5VSs3dR+0GBAOvRdkOFcJNk10vBsrz7Qy6FFUTHm/VTPBRkuN
	samZUe9kwLaSg37byS1cHQpWygJPubN/CABGnRQeks8/Idqw40OYsBvuAw1rRkeBiLapCbsm3ut
	N1NE9UWhN0TghyIASMf408vAtPC7YxIqHVu54dwbfChI0avtmC9ZOD1+Bq/amYyf0B7Cg8vTvze
	DLVJy15UWq+LI+iBYXbUPlTcjPHVFNKb4Tp8FpjjJMMmQVAiwFV5G9WZwuSbI2u/iTKNyc
X-Received: by 2002:a05:6820:c95:b0:6e0:1917:42f9 with SMTP id 006d021491bc7-6ef11839a31mr1124128eaf.51.1791545721421;
        Fri, 09 Oct 2026 04:35:21 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:75::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-83039a3e016sm1452342a34.17.2026.10.09.04.35.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 04:35:20 -0700 (PDT)
From: Daniel Zahka <daniel.zahka@gmail.com>
Date: Fri, 09 Oct 2026 04:35:06 -0700
Subject: [PATCH net-next 3/4] eth: mpnic: count Tx queue stops and wakes
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261009-mpnic-counters3-v1-3-7dc7644cc500@gmail.com>
References: <20261009-mpnic-counters3-v1-0-7dc7644cc500@gmail.com>
In-Reply-To: <20261009-mpnic-counters3-v1-0-7dc7644cc500@gmail.com>
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

Count how often a Tx queue is stopped for lack of descriptors and woken
again by completions, and report the counts through the queue stats API.

Stops are counted on the TWQ from the xmit path and wakes on the TCQ
from mpnic_poll(), keeping a single writer context for each.

Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>
---
 drivers/net/ethernet/meta/mpnic/mpnic_netdev.c | 13 ++++++++-
 drivers/net/ethernet/meta/mpnic/mpnic_netdev.h |  2 ++
 drivers/net/ethernet/meta/mpnic/mpnic_txrx.c   | 37 +++++++++++++++++++-------
 drivers/net/ethernet/meta/mpnic/mpnic_txrx.h   |  2 ++
 4 files changed, 44 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/meta/mpnic/mpnic_netdev.c b/drivers/net/ethernet/meta/mpnic/mpnic_netdev.c
index c2f4a326a8f0..9e262f939c79 100644
--- a/drivers/net/ethernet/meta/mpnic/mpnic_netdev.c
+++ b/drivers/net/ethernet/meta/mpnic/mpnic_netdev.c
@@ -176,9 +176,9 @@ static void mpnic_get_queue_stats_tx(struct net_device *dev, int idx,
 	struct mpnic_net *mpn = netdev_priv(dev);
 	struct mpnic_ring *txr = mpn->tx[idx];
 	struct mpnic_queue_stats *stats;
+	u64 bytes, packets, stop, wake;
 	struct mpnic_q_triad *qt;
 	unsigned int start;
-	u64 bytes, packets;
 
 	if (!txr)
 		return;
@@ -190,10 +190,19 @@ static void mpnic_get_queue_stats_tx(struct net_device *dev, int idx,
 		start = u64_stats_fetch_begin(&stats->syncp);
 		bytes = u64_stats_read(&stats->tcq.bytes);
 		packets = u64_stats_read(&stats->tcq.packets);
+		wake = u64_stats_read(&stats->tcq.wake);
+	} while (u64_stats_fetch_retry(&stats->syncp, start));
+
+	stats = &txr->stats;
+	do {
+		start = u64_stats_fetch_begin(&stats->syncp);
+		stop = u64_stats_read(&stats->twq.stop);
 	} while (u64_stats_fetch_retry(&stats->syncp, start));
 
 	tx->bytes = bytes;
 	tx->packets = packets;
+	tx->stop = stop;
+	tx->wake = wake;
 }
 
 static void mpnic_get_base_stats(struct net_device *dev,
@@ -207,6 +216,8 @@ static void mpnic_get_base_stats(struct net_device *dev,
 
 	tx->bytes = base->tx.bytes;
 	tx->packets = base->tx.packets;
+	tx->stop = base->tx.stop;
+	tx->wake = base->tx.wake;
 
 	rx->bytes = base->rx.bytes;
 	rx->packets = base->rx.packets;
diff --git a/drivers/net/ethernet/meta/mpnic/mpnic_netdev.h b/drivers/net/ethernet/meta/mpnic/mpnic_netdev.h
index a61249d12a04..0d1ee66dd86c 100644
--- a/drivers/net/ethernet/meta/mpnic/mpnic_netdev.h
+++ b/drivers/net/ethernet/meta/mpnic/mpnic_netdev.h
@@ -16,6 +16,8 @@ struct mpnic_base_stats {
 		u64 packets;
 		u64 bytes;
 		u64 dropped;
+		u64 stop;
+		u64 wake;
 	} tx;
 	struct {
 		u64 packets;
diff --git a/drivers/net/ethernet/meta/mpnic/mpnic_txrx.c b/drivers/net/ethernet/meta/mpnic/mpnic_txrx.c
index 4bf640494115..35129fc149e2 100644
--- a/drivers/net/ethernet/meta/mpnic/mpnic_txrx.c
+++ b/drivers/net/ethernet/meta/mpnic/mpnic_txrx.c
@@ -68,6 +68,23 @@ static struct netdev_queue *mpnic_txring_txq(const struct net_device *dev,
 	return netdev_get_tx_queue(dev, ring->q_idx);
 }
 
+static bool
+mpnic_maybe_stop_tx(const struct net_device *dev, struct mpnic_ring *ring)
+{
+	int res;
+
+	res = netif_txq_maybe_stop(mpnic_txring_txq(dev, ring),
+				   mpnic_desc_unused(ring), MPNIC_MAX_SKB_DESC,
+				   MPNIC_TX_DESC_WAKEUP);
+	if (!res) {
+		u64_stats_update_begin(&ring->stats.syncp);
+		u64_stats_inc(&ring->stats.twq.stop);
+		u64_stats_update_end(&ring->stats.syncp);
+	}
+
+	return !res;
+}
+
 static void mpnic_tx_doorbell(struct mpnic_ring *ring, __le64 *meta)
 {
 	*meta |= cpu_to_le64(MPNIC_TWD_FLAG_REQ_COMPLETION);
@@ -164,9 +181,7 @@ mpnic_tx_map(struct mpnic_ring *ring, struct sk_buff *skb, __le64 *meta)
 	ring->tail = tail;
 
 	/* Verify there is room for another packet */
-	netif_txq_maybe_stop(mpnic_txring_txq(skb->dev, ring),
-			     mpnic_desc_unused(ring), MPNIC_MAX_SKB_DESC,
-			     MPNIC_TX_DESC_WAKEUP);
+	mpnic_maybe_stop_tx(skb->dev, ring);
 
 	if (__netdev_tx_sent_queue(mpnic_txring_txq(skb->dev, ring),
 				   MPNIC_XMIT_CB(skb)->bytecount,
@@ -204,9 +219,7 @@ static netdev_tx_t mpnic_xmit_frame_ring(struct sk_buff *skb,
 	if (skb_put_padto(skb, MPNIC_MIN_FRAME_LEN))
 		goto err_drop;
 
-	if (!netif_txq_maybe_stop(mpnic_txring_txq(skb->dev, ring),
-				  mpnic_desc_unused(ring), MPNIC_MAX_SKB_DESC,
-				  MPNIC_TX_DESC_WAKEUP)) {
+	if (mpnic_maybe_stop_tx(skb->dev, ring)) {
 		mpnic_tx_flush_doorbell(ring);
 		return NETDEV_TX_BUSY;
 	}
@@ -310,9 +323,13 @@ static void mpnic_clean_twq0(struct mpnic_napi_vector *nv, int napi_budget,
 	u64_stats_update_end(&cmpl->stats.syncp);
 
 	txq = mpnic_txring_txq(nv->napi.dev, ring);
-	netif_txq_completed_wake(txq, total_packets, total_bytes,
-				 mpnic_desc_unused(ring),
-				 MPNIC_TX_DESC_WAKEUP);
+	if (!netif_txq_completed_wake(txq, total_packets, total_bytes,
+				      mpnic_desc_unused(ring),
+				      MPNIC_TX_DESC_WAKEUP)) {
+		u64_stats_update_begin(&cmpl->stats.syncp);
+		u64_stats_inc(&cmpl->stats.tcq.wake);
+		u64_stats_update_end(&cmpl->stats.syncp);
+	}
 }
 
 static void mpnic_commit_cq_head(struct mpnic_ring *cmpl)
@@ -699,6 +716,7 @@ static void mpnic_aggregate_ring_twq_counters(struct mpnic_base_stats *base,
 					      struct mpnic_ring *twq)
 {
 	base->tx.dropped += u64_stats_read(&twq->stats.twq.dropped);
+	base->tx.stop += u64_stats_read(&twq->stats.twq.stop);
 }
 
 static void mpnic_aggregate_ring_tcq_counters(struct mpnic_base_stats *base,
@@ -706,6 +724,7 @@ static void mpnic_aggregate_ring_tcq_counters(struct mpnic_base_stats *base,
 {
 	base->tx.packets += u64_stats_read(&tcq->stats.tcq.packets);
 	base->tx.bytes += u64_stats_read(&tcq->stats.tcq.bytes);
+	base->tx.wake += u64_stats_read(&tcq->stats.tcq.wake);
 }
 
 static void mpnic_aggregate_ring_rcq_counters(struct mpnic_base_stats *base,
diff --git a/drivers/net/ethernet/meta/mpnic/mpnic_txrx.h b/drivers/net/ethernet/meta/mpnic/mpnic_txrx.h
index 7b44cf700e5b..764e78918b8f 100644
--- a/drivers/net/ethernet/meta/mpnic/mpnic_txrx.h
+++ b/drivers/net/ethernet/meta/mpnic/mpnic_txrx.h
@@ -89,10 +89,12 @@ struct mpnic_queue_stats {
 	union {
 		struct {
 			u64_stats_t dropped;
+			u64_stats_t stop;
 		} twq;
 		struct {
 			u64_stats_t packets;
 			u64_stats_t bytes;
+			u64_stats_t wake;
 		} tcq;
 		struct {
 			u64_stats_t packets;

-- 
2.52.0

