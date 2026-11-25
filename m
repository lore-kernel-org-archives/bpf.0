Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=129.217.128.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795620227;
	b=3OF9W/YxNj4oMWu67bRfpD68sLNJtW/hRU2/VZiUv7vtlDhi1czIcLmTTEcnEveGMUwX
	 O40yGdVI7LlX6Mps8PJDzAvC1LHz0e/Ig6Qzh2/jVJtjIlJDug9JGMU1uOFmZrf1Mh0pP
	 jIxO21OQmIAXxJjZvSTAuZqHJ5IRnVcZMxx5V8am+Th+nMadwx9n807ecINX578Gw+8vC
	 2G19QU5XMzlgMl5kbIxIUYDJuXye9+wIJYcZIjys6LbdBNtJS2lOO3rq4Ff42JpeRUvaR
	 bTIV40sOYBnPUewjBozkJD3aXrcjdQEPLT62phWk2DhDfBkgCBp9KwPf4VpekKA7FsA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795620227;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=7lqxMl9LQqYx+IM7aMsw8LkEd2OcKYcJGIX+toZz4gI=;
	b=op5NpzzqFCKumc9maH+E4j1z/MdraJWug5LNr5p9y5+0SHPJ0qeU7/Sp/GKWw3G8rCqU
	 vaIs9NH5DKSGrdNURbq9IQmYAB523zGzkR/nuiPatzGU2x8xfqdyZdQMM/laVNPuXXlz9
	 MuYPpyQ1REncsgDfNrnluXYrwSAkkI8QC/hxbiKLtNij0TAgawLuyYVVon0HKi0z4v6gE
	 aut46r3FKjn4iJMm7oKhJjKBwkGlfeYy1arg7c+8418hF2A1pik7vZ8iELnzNt1RyVhI/
	 aAf0n+tst44uOs1JkaKaMqR5ZBgQnEGWwzahSVfAGZJIHShf7TqxIXtUZxzlQX/p1VQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=tu-dortmund.de;
	spf=pass smtp.mailfrom=tu-dortmund.de;
	dkim=pass header.d=tu-dortmund.de header.i=@tu-dortmund.de header.a=rsa-sha256 header.s=unimail header.b=oMXXhGa6;
	arc=none smtp.remote-ip=129.217.128.51
Received: from unimail.uni-dortmund.de (mx1.hrz.uni-dortmund.de [129.217.128.51])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A87F606A31E;
	Wed, 25 Nov 2026 15:23:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8A87F606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tu-dortmund.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tu-dortmund.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tu-dortmund.de header.i=@tu-dortmund.de header.a=rsa-sha256 header.s=unimail header.b=oMXXhGa6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tu-dortmund.de;
	s=unimail; t=1795620200;
	bh=7lqxMl9LQqYx+IM7aMsw8LkEd2OcKYcJGIX+toZz4gI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oMXXhGa6Pz9YwLcLMEvsUzRfNd0vuSx8r6LH1gd0iYeAIV/qUnfZuC93MhGTMATu6
	 j+hSIpontklgWBjGbD4qdumPffr1vHuSv71LBY8dwyzWxOijFFrShIUizV0LT/JwMM
	 KJ/ArCASgkDC83da9jbglh3nbXCIOnJ0aTKIJ0qs=
Received: from simon-Latitude-5450.cni.e-technik.tu-dortmund.de ([129.217.186.207])
	(authenticated bits=0)
	by unimail.uni-dortmund.de (8.19.0.2/8.19.0.2) with ESMTPSA id 6APFNERO004665
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 25 Nov 2026 16:23:18 +0100 (CET)
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
Subject: [PATCH net-next 2/3] veth: wake the peer txq in the middle of the NAPI poll
Date: Wed, 25 Nov 2026 16:23:10 +0100
Message-ID: <20261125152311.805325-3-simon.schippers@tu-dortmund.de>
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

Since commit dc82a33297fc ("veth: apply qdisc backpressure on full
ptr_ring to reduce TX drops") veth_poll() wakes a stopped peer txq at the
end of every poll. netif_tx_wake_queue() raises NET_TX_SOFTIRQ on the
local CPU, and it runs right after the poll when BHs are enabled again.
The consumer CPU then dequeues from the qdisc and refills the ring
itself, while the producer finds the qdisc running or the txq stopped
again. Under a flood the consumer spends that time on the refill instead
of on consuming.

Wake the txq after PTR_RING_BATCH entries of the poll instead, if it
was stopped when the poll started. That is 16 on 64-bit architectures
with 64 byte cache lines. The softirq then stays pending until the poll
ends, and the producer refills the ring on its own CPU while the
consumer goes on. All entries consumed by then were consumed after the
stop, so the ptr_ring has freed at least one batch of slots and the
producer does not find it full again right away.

At the end of the poll the txq is woken only when the ring has run dry,
so that NAPI does not go idle with the txq stopped. A stop during a poll
is picked up by the next one. Budgets up to PTR_RING_BATCH, as with busy
polling, cannot consume a batch before the wake and keep the wake at the
end of every poll.

The position of the wake is what matters. Waking only at the end of a
poll, once 128 entries had been consumed with the txq stopped, gave
about 3% in a short pktgen test, against about 25% for the wake in the
middle of the poll.

pktgen (64 byte UDP, queue_xmit) and iperf3 into fq_codel on a veth pair
with GRO on and TSO off, so that all traffic takes the NAPI ptr_ring
path, as with an XDP program on the peer. In a virtme-ng VM with 4 vCPUs
pinned to isolated cores of an AMD Ryzen 9 9950X, all on the same CCX,
at a fixed 4.3 GHz. 50 boots per kernel, 95% confidence intervals, with
the qdisc requeues per 10 s run:

  threaded NAPI     before          after           requeues
  pktgen            1078122 pps     +24.6 +-0.5%     169038 -> 210594
  iperf3 TCP          32682 Mbit/s   +1.3 +-0.7%     579184 -> 4587
  iperf3 UDP            362 Mbit/s   +0.2 +-0.5%         14 -> 14

pktgen requeues one skb per 64 packets, before and after. The next patch
removes these requeues.

With softirq NAPI and a single sender the consumer runs on the sender's
CPU and the ring does not fill. The changes of pktgen and iperf3 there
range from -0.7% to +0.4%, with confidence intervals of 0.4% to 0.9%.

With two iperf3 senders on one queue, each on its own CPU, the ring
fills with softirq NAPI too. 40 boots per kernel, 6 vCPUs:

  two senders       before          after           requeues
  TCP, softirq        25798 Mbit/s  +52.1 +-0.9%    6024998 -> 799805
  TCP, threaded       22480 Mbit/s  +16.4 +-1.8%    6741008 -> 5910785
  UDP, threaded         701 Mbit/s  +14.4 +-0.5%     152298 -> 81520

With softirq NAPI, TCP through fq_codel was 36% slower than with
noqueue before and is 2% slower after.

A wake after 32 entries instead of 16 gave the same throughput, except
for TCP with two senders and threaded NAPI, which gained only 8.3%.

Signed-off-by: Simon Schippers <simon.schippers@tu-dortmund.de>
---
 drivers/net/veth.c | 27 ++++++++++++++++++++++-----
 1 file changed, 22 insertions(+), 5 deletions(-)

diff --git a/drivers/net/veth.c b/drivers/net/veth.c
index 2051f6e044327..02ffc7ba59ab2 100644
--- a/drivers/net/veth.c
+++ b/drivers/net/veth.c
@@ -912,11 +912,19 @@ static struct sk_buff *veth_xdp_rcv_skb(struct veth_rq *rq,
 
 static int veth_xdp_rcv(struct veth_rq *rq, int budget,
 			struct veth_xdp_tx_bq *bq,
-			struct veth_stats *stats)
+			struct veth_stats *stats,
+			struct netdev_queue *peer_txq)
 {
-	int i, done = 0, n_xdpf = 0;
+	int i, done = 0, n_xdpf = 0, wake_at = 0;
 	void *xdpf[VETH_XDP_BATCH];
 
+	/* Wake a stopped peer txq in the middle of the poll, so that the
+	 * producer refills the ring while this poll goes on.
+	 */
+	if (budget > PTR_RING_BATCH && peer_txq &&
+	    netif_tx_queue_stopped(peer_txq))
+		wake_at = PTR_RING_BATCH;
+
 	for (i = 0; i < budget; i++) {
 		void *ptr = __ptr_ring_consume(&rq->xdp_ring);
 
@@ -952,6 +960,11 @@ static int veth_xdp_rcv(struct veth_rq *rq, int budget,
 			}
 		}
 		done++;
+
+		if (done == wake_at) {
+			txq_trans_cond_update(peer_txq);
+			netif_tx_wake_queue(peer_txq);
+		}
 	}
 
 	if (n_xdpf)
@@ -988,7 +1001,7 @@ static int veth_poll(struct napi_struct *napi, int budget)
 		   netdev_get_tx_queue(peer_dev, queue_idx) : NULL;
 
 	xdp_set_return_frame_no_direct();
-	done = veth_xdp_rcv(rq, budget, &bq, &stats);
+	done = veth_xdp_rcv(rq, budget, &bq, &stats, peer_txq);
 
 	if (stats.xdp_redirect > 0)
 		xdp_do_flush();
@@ -1007,9 +1020,13 @@ static int veth_poll(struct napi_struct *napi, int budget)
 		}
 	}
 
-	/* Release backpressure per NAPI poll */
+	/* Release backpressure before NAPI may go idle, and after every poll
+	 * that veth_xdp_rcv() cannot wake in the middle of
+	 */
 	smp_rmb(); /* Paired with netif_tx_stop_queue set_bit */
-	if (peer_txq && netif_tx_queue_stopped(peer_txq)) {
+	if (peer_txq && netif_tx_queue_stopped(peer_txq) &&
+	    (budget <= PTR_RING_BATCH || done < budget ||
+	     __ptr_ring_empty(&rq->xdp_ring))) {
 		txq_trans_cond_update(peer_txq);
 		netif_tx_wake_queue(peer_txq);
 	}
-- 
2.43.0

