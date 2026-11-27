Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795758830;
	b=Q4ur/R2GOI7ZJ/nd1kpGGfz23xrQCTtgNHsvZBW9+qKo/5eGXco8qFXTrPPrLnd83CoP
	 OXO2471DgIKM3p5sinzz1g6h6aiT6i3KhCqFU/Yr04BTeJ4I7v9ppINL6b+5JgTw2/eQ/
	 3DvPH+dbfovNtamqGW4AtgWBOye4zRcB2grdg2AzedOU3+8YUp+Nxq2qTnZku5bRFJr8m
	 dmStYyMTuqM8/FD4d3y6FJW6oOvT2jSrM6dNMOWGQ0CaksfeDunSRUQMZuZCDqrhqYQfv
	 17VY3Pj9pUS3BF1XGjxMqM2PRQixQRUu1lvz6iybYBbxHsjzgjzeSQ/tOK5i5R6RvpQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795758830;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=JrUvEB9bKJ/BNC3KUGPkt1IQIMmXxUgGHDAUEm/+p4g=;
	b=hm1mOIWOnptb472LlpWXZlIF5vH9y9q9IAj79zrBLDOCw5klPxTmzPOiJ2N7Z2yYQEi5
	 q8RkkuLYTTMqONnS0vprusMn2LqXje22lpl1gN2r0vM7wi1N+o51EegEukl2F0C2xF11b
	 YC9jbbQk+NaBB2Mi7B3i0DUxMZ8eyVqpudFWhGa84U/jwbZ8LghY3TyJXDWZ3X2xsD+jv
	 Wg4bAGr3oKrfTLalX3jrvOwaIsxb4tY7xPn/liQEPdKf3s5dRxo+g/Dca6jP8vYwjMK94
	 ZzUQvRO3sk6JrZu3liWyNhwI3FyFRQu5x7+VRgTdj4K0oIBRctXiXMRCk2QnXtArixA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Nk8Bv3Ih;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25FEC606A31E;
	Fri, 27 Nov 2026 05:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Nk8Bv3Ih
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF2C61F00893;
	Fri, 27 Nov 2026 05:53:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795758829;
	bh=JrUvEB9bKJ/BNC3KUGPkt1IQIMmXxUgGHDAUEm/+p4g=;
	h=From:To:Cc:Subject:Date;
	b=Nk8Bv3Ih9yrsmEYJyuitgiLr8W1ZkwCY+r0HW3grzEQft4VtQ4XSsvYzrzXu7O3yu
	 YQw4KKnWNVy8WVnFCVq1CVHZnCnvl5K7kXQUOG4AKxmYaNtg4kH3ljhk8D9OFoLRO8
	 Y2A2KuXL4mRG44/vI0l08KDHC89vAJEUhmDmrNQPAz+EpCe9BkyaIArZEfJ87K5Fhz
	 aOh46GRefK+KEEea0u7Y1EJD91kip7UBgtOj50nZyKaxFOGWKcSMTdaHALr85/QWSP
	 TIXvho1NVxI29D+YhP+sIKliZp0DGiMzM8hBnOUhrqfqGvJg1joGWQWrxNmPU90eDe
	 S1rkyfz2eZkag==
From: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>
To: Alexander Duyck <alexanderduyck@fb.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org
Cc: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	kernel-team@meta.com,
	Stanislav Fomichev <sdf@fomichev.me>,
	Simon Horman <horms@kernel.org>,
	Dimitri Daskalakis <dimitri.daskalakis1@gmail.com>,
	Bobby Eshleman <bobbyeshleman@meta.com>,
	Daniel Zahka <daniel.zahka@gmail.com>,
	"Mike Marciniszyn (Meta)" <mike.marciniszyn@gmail.com>,
	Mohsin Bashir <hmohsin@meta.com>,
	Breno Leitao <leitao@debian.org>
Subject: [PATCH net-next] eth: fbnic: Support XDP redirect
Date: Fri, 27 Nov 2026 06:53:32 +0100
Message-ID: <20261127055334.3156389-1-bjorn@kernel.org>
X-Mailer: git-send-email 2.56.1
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

fbnic treats XDP_REDIRECT as an invalid action: it warns and drops the
packet, so programs on fbnic cannot redirect to devmap, cpumap or
AF_XDP sockets.

Support the verdict and advertise NETDEV_XDP_ACT_REDIRECT. The buffers
of a redirected packet go to the target, and a failed redirect drops
the packet as XDP_ABORTED does. Each RX queue flushes its redirects
once per poll.

The NAPI vector, not a variable of the RX loop, notes that a flush is
due, as one more live variable in that loop costs XDP_DROP six
instructions per packet.

Signed-off-by: Björn Töpel <bjorn@kernel.org>
---
 drivers/net/ethernet/meta/fbnic/fbnic_netdev.c |  3 ++-
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.c   | 13 +++++++++++++
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.h   |  1 +
 3 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
index 52244219d166..9f0d8c070d1c 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
@@ -822,7 +822,8 @@ struct net_device *fbnic_netdev_alloc(struct fbnic_dev *fbd)
 	netdev->hw_enc_features |= netdev->features;
 	netdev->features |= NETIF_F_NTUPLE;
 
-	netdev->xdp_features = NETDEV_XDP_ACT_BASIC | NETDEV_XDP_ACT_RX_SG;
+	netdev->xdp_features = NETDEV_XDP_ACT_BASIC | NETDEV_XDP_ACT_REDIRECT |
+			       NETDEV_XDP_ACT_RX_SG;
 
 	netdev->min_mtu = IPV6_MIN_MTU;
 	netdev->max_mtu = FBNIC_MAX_JUMBO_FRAME_SIZE - ETH_HLEN;
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
index 07d4b2e92362..da38ac1146c0 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
@@ -22,6 +22,7 @@ enum {
 	FBNIC_XDP_PASS = 0,
 	FBNIC_XDP_CONSUME,
 	FBNIC_XDP_TX,
+	FBNIC_XDP_REDIRECT,
 	FBNIC_XDP_LEN_ERR,
 };
 
@@ -1211,10 +1212,15 @@ static struct sk_buff *fbnic_run_xdp(struct fbnic_napi_vector *nv,
 		return fbnic_build_skb(nv, pkt);
 	case XDP_TX:
 		return ERR_PTR(fbnic_pkt_tx(nv, pkt));
+	case XDP_REDIRECT:
+		if (xdp_do_redirect(nv->napi.dev, &pkt->buff, xdp_prog))
+			goto xdp_exception;
+		return ERR_PTR(-FBNIC_XDP_REDIRECT);
 	default:
 		bpf_warn_invalid_xdp_action(nv->napi.dev, xdp_prog, act);
 		fallthrough;
 	case XDP_ABORTED:
+xdp_exception:
 		trace_xdp_exception(nv->napi.dev, xdp_prog, act);
 		fallthrough;
 	case XDP_DROP:
@@ -1334,6 +1340,8 @@ static int fbnic_clean_rcq(struct fbnic_napi_vector *nv,
 				napi_gro_receive(&nv->napi, skb);
 			} else if (skb == ERR_PTR(-FBNIC_XDP_TX)) {
 				pkt_tail = nv->qt[0].sub1.tail;
+			} else if (skb == ERR_PTR(-FBNIC_XDP_REDIRECT)) {
+				nv->xdp_flush = true;
 			} else if (PTR_ERR(skb) == -FBNIC_XDP_CONSUME) {
 				fbnic_put_pkt_buff(qt, pkt, 1);
 			} else {
@@ -1387,6 +1395,11 @@ static int fbnic_clean_rcq(struct fbnic_napi_vector *nv,
 		fbnic_clean_bdq(&qt->sub1, head1, budget);
 	fbnic_fill_bdq(&qt->sub1);
 
+	if (nv->xdp_flush) {
+		nv->xdp_flush = false;
+		xdp_do_flush();
+	}
+
 	/* Record the current head/tail of the queue */
 	if (rcq->head != head) {
 		rcq->head = head;
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.h b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.h
index 6ee3cce3d942..7bc0c25ac50b 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.h
@@ -173,6 +173,7 @@ struct fbnic_napi_vector {
 	u16 v_idx;
 	u8 txt_count;
 	u8 rxt_count;
+	bool xdp_flush;		/* An XDP redirect awaits xdp_do_flush() */
 
 	struct fbnic_q_triad qt[];
 };

base-commit: ccb81d5e317b0ae2cc66ca1c628c0ca907928f94
-- 
2.56.1

