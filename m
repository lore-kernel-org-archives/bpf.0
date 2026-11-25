Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=129.217.128.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795620227;
	b=b+FI0rIelTaiD0bNpAri6NLsQ7bVVL9rfCLeJJRpNy5t1hD+yEH/Zs8yHrMKmYkvC0dc
	 dyZWuWvsYNKymfiPLLupJky1nbLVmE+JQM/5aY9n49H/syFg8ilj9828kAYafO00m/Gwr
	 p0KbH1rQJOH15uIFn9oCFaBao4F/m4ZpGaNJRk+IESLfvDOzVoq5CEgFx7bup/MM1JulW
	 7MzBsUdP1OFDcddZPpqVl7nAlH4FRwTLyf08spcZvn2v8uSPWXubLemOmsBjd0LgMqr3m
	 nqVEFxxA3eZ3SE0L+zBBYLBe1nm9jeRnLcUnuR/FCkG0a/PEEqzZaAy2SesozBI2+Ag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795620227;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=i8WL8KVOFFwJaUNqpb8Y5QPC+4OxinZ301w/l2clA6k=;
	b=L1PS9jrKZ094piofFM+kGtnLuRp2dLiRxLx76/E/+Kw9XzgBTEW1fr6lH4UjQRy6wmL2
	 bsWHMb9nIYj1X190LrwETlCL4s8eN2eU8AnGa1+WGlo3gx+6JS2GikNNENnTcmMR0a/V0
	 r65dQjDWcIpeElbK9HoKsEEZpJD5wjEBEdiGNNvSenLOjmTdjiCxc7T9JKN2lLS53gRkS
	 gStFYY2gvlC8Hkbqwf7Jien3U/Lksb5okJy+cXJyPVH35yP4nBU1tvp+ePO8IihGyxgcJ
	 EhEmMFHQ5Cgg8yD/z2Dp2nF6A7LPD0EMQ3qDncY9W6PlTvvuGlkO/4NeSz9IYXfVioA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=tu-dortmund.de;
	spf=pass smtp.mailfrom=tu-dortmund.de;
	dkim=pass header.d=tu-dortmund.de header.i=@tu-dortmund.de header.a=rsa-sha256 header.s=unimail header.b=FPnoMXV9;
	arc=none smtp.remote-ip=129.217.128.51
Received: from unimail.uni-dortmund.de (mx1.hrz.uni-dortmund.de [129.217.128.51])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DE76606A321;
	Wed, 25 Nov 2026 15:23:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6DE76606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tu-dortmund.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tu-dortmund.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=tu-dortmund.de header.i=@tu-dortmund.de header.a=rsa-sha256 header.s=unimail header.b=FPnoMXV9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tu-dortmund.de;
	s=unimail; t=1795620201;
	bh=i8WL8KVOFFwJaUNqpb8Y5QPC+4OxinZ301w/l2clA6k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FPnoMXV90YdHIuiVRrB5NvAJOaRLZrtwR3WQMGS2T3cQOtnSZylxpMIlYxfEgn/n0
	 6OFqx1iZxrs3t5pR7BUwjALRyKcnefWnuteKLxqBhsnmB9aFDb0FYAyKW0LHVFC/0O
	 UuH/DzJw/CniCOyfQXFNriMS+yuspOB97sh8+b+g=
Received: from simon-Latitude-5450.cni.e-technik.tu-dortmund.de ([129.217.186.207])
	(authenticated bits=0)
	by unimail.uni-dortmund.de (8.19.0.2/8.19.0.2) with ESMTPSA id 6APFNERQ004665
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 25 Nov 2026 16:23:20 +0100 (CET)
From: Simon Schippers <simon.schippers@tu-dortmund.de>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Tim Gebauer <tim.gebauer@tu-dortmund.de>,
        =?UTF-8?q?Jonas=20K=C3=B6ppeler?= <j.koeppeler@tu-berlin.de>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowangio@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Stanislav Fomichev <sdf@fomichev.me>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Simon Schippers <simon.schippers@tu-dortmund.de>
Subject: [PATCH net-next 3/3] veth: stop the txq as soon as the ptr_ring is full
Date: Wed, 25 Nov 2026 16:23:11 +0100
Message-ID: <20261125152311.805325-4-simon.schippers@tu-dortmund.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261125152311.805325-1-simon.schippers@tu-dortmund.de>
References: <20261125152311.805325-1-simon.schippers@tu-dortmund.de>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

veth_xmit() stops the txq only once a produce has failed. The skb is
then returned with NETDEV_TX_BUSY and requeued by the qdisc. Under a
flood every refill of the ring after a wake ends this way, with a failed
produce and a requeue.

Check under the producer lock whether the produce has filled the ring,
and stop the txq then, as for NETDEV_TX_BUSY but with the skb sent. The
next skb waits in the qdisc and is not requeued. NETDEV_TX_BUSY stays
for a ring that another producer, like XDP redirect, has filled.

The stop is ordered as in the NETDEV_TX_BUSY path. The stop bit is set
before the smp_mb() in __veth_xdp_flush(), which pairs with the
smp_store_mb() in veth_poll(). Either the producer finds NAPI idle and
schedules it, or the poll sees the stopped txq and wakes it.

Same setup as in the previous patch, an AMD Ryzen 9 9950X with all
cores on the same CCX at a fixed 4.3 GHz, compared to it:

  threaded NAPI     before          after           requeues
  pktgen            1343008 pps      +0.2 +-0.4%     210594 -> 0
  iperf3 TCP          33113 Mbit/s   +0.1 +-0.4%       4587 -> 3213
  iperf3 UDP            363 Mbit/s   +1.2 +-0.6%         14 -> 14

iperf3 TCP keeps its requeues, the change is within noise. When the txq
stops in the middle of a GSO segment list, the rest of the list goes
back to the qdisc, and each segment counts as a requeue. The few UDP
requeues show up with every kernel, also without this series.

With softirq NAPI and a single sender the ring does not fill, and the
only change on that path is the __ptr_ring_check_produce() check.
iperf3 changes by -0.1% to +0.4% there, with confidence intervals of
0.4% to 0.9%.
pktgen is 1.4 +-0.5% slower. The patch also moves the code of net/ by
16 bytes, as veth is linked before it, and I could not separate the
two.

With the two iperf3 senders on one queue from the previous patch,
throughput stays within 1.2% of it. The UDP requeues with threaded NAPI
drop from 81520 to 48929 per run.

Signed-off-by: Simon Schippers <simon.schippers@tu-dortmund.de>
---
 drivers/net/veth.c | 25 ++++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/drivers/net/veth.c b/drivers/net/veth.c
index 02ffc7ba59ab2..911da9893e82d 100644
--- a/drivers/net/veth.c
+++ b/drivers/net/veth.c
@@ -40,6 +40,11 @@
 #define VETH_XDP_TX_BULK_SIZE	16
 #define VETH_XDP_BATCH		16
 
+/* Returned by veth_xdp_rx() when the skb filled the ring. Internal to
+ * veth, veth_xmit() returns NETDEV_TX_OK for it.
+ */
+#define VETH_RING_FULL		0x20
+
 struct veth_stats {
 	u64	rx_drops;
 	/* xdp */
@@ -312,10 +317,17 @@ static void __veth_xdp_flush(struct veth_rq *rq)
 
 static int veth_xdp_rx(struct veth_rq *rq, struct sk_buff *skb)
 {
-	if (unlikely(ptr_ring_produce(&rq->xdp_ring, skb)))
-		return NETDEV_TX_BUSY; /* signal qdisc layer */
+	struct ptr_ring *ring = &rq->xdp_ring;
+	int ret = NET_RX_SUCCESS; /* same as NETDEV_TX_OK */
 
-	return NET_RX_SUCCESS; /* same as NETDEV_TX_OK */
+	spin_lock(&ring->producer_lock);
+	if (__ptr_ring_produce(ring, skb))
+		ret = NETDEV_TX_BUSY; /* signal qdisc layer */
+	else if (__ptr_ring_check_produce(ring) == -ENOSPC)
+		ret = VETH_RING_FULL;
+	spin_unlock(&ring->producer_lock);
+
+	return ret;
 }
 
 static int veth_forward_skb(struct net_device *dev, struct sk_buff *skb,
@@ -388,6 +400,13 @@ static netdev_tx_t veth_xmit(struct sk_buff *skb, struct net_device *dev)
 		else
 			__veth_xdp_flush(rq);
 		break;
+	case VETH_RING_FULL:
+		txq = netdev_get_tx_queue(dev, rxq);
+		if (!qdisc_txq_has_no_queue(txq))
+			netif_tx_stop_queue(txq);
+		__veth_xdp_flush(rq);
+		ret = NETDEV_TX_OK;
+		break;
 	case NETDEV_TX_BUSY:
 		/* If a qdisc is attached to our virtual device, returning
 		 * NETDEV_TX_BUSY is allowed.
-- 
2.43.0

