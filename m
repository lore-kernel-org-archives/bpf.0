Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 286353E638D;
	Fri,  2 Oct 2026 19:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790967738; cv=none; b=p/0xp5nGTPC0QpOWkZuj6EaHw1V6vRWsXHNXRClhQ5NRRpjwkAHaWjXv/Hi82QoOYD1tGMW1ZZ1uiZmc/KymFuCm55ZnyFuV6VnB5vZlPsFq4kN57P6U/SEZ41ZwoBxHCT9De5X1HFe1acs1TmdrdIddiPe1sjZwn26QDM8t+3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790967738; c=relaxed/simple;
	bh=l1W14HpbkML/eL1Dw1Xpq5xEjzHPFiPaFF3USGmSX+Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rfaJIQHabYzppWbel4TftqipI/9xGm8nwXkLPPD2/DQ4D/1HNJa04+pxj0/uAGDe0sQop89RIovsxxt5fMxsCRegYt5m0zukXGgNf+t03eaJVLTXY8n5ImN6BBy1mFtci1XL+AOLYkRi1Yi+hsbyLqQpqkUP7g4quT/crevi4VY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bQ+nGKBc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bQ+nGKBc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E2E11F000FF;
	Fri,  2 Oct 2026 19:02:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790967735;
	bh=plbQcCJH6GhLaEJ5nAKr3MAVd8XbEMlPNRbrzYrmaVk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bQ+nGKBcpXtydufjmG0cPEQUmLhV5t7SZWZK9qH1jGdjeK3D3pap7dTN0WmMNVRN/
	 PrcZBgywtevp22t/YyLQVVWBrGlNdRDMuxFNmMmUlzc8bQAOICnSRiP7vpiU1PCtbg
	 paBJc0PbiJPpfK/99kQWIHg+7brRfYGcH3gfKTWDlcGhGe3Ej+6gVIPLZuq3wCXXXq
	 72FzZ8tA68EwRv8nFS+PbuucpMizCnPfCe6RLBieRjSvGVnklMv50ddwfYwKl70o14
	 taSFZb7nVS1a31/DgFLTIN8aQvpjWsXCHTKspcz46JmohAtxgFzsGpDR47YQbsLPnM
	 n9dJ3c6T/QjQA==
From: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>
To: Magnus Karlsson <magnus.karlsson@intel.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Alexander Duyck <alexanderduyck@fb.com>,
	kernel-team@meta.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Pavel Begunkov <asml.silence@gmail.com>,
	Jens Axboe <axboe@kernel.dk>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	io-uring@vger.kernel.org
Cc: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	"Mike Marciniszyn (Meta)" <mike.marciniszyn@gmail.com>,
	Weiming Shi <bestswngs@gmail.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	David Wei <dw@davidwei.uk>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mina Almasry <almasrymina@google.com>
Subject: [RFC net-next 13/15] eth: fbnic: Support AF_XDP zero-copy receive
Date: Fri,  2 Oct 2026 21:00:14 +0200
Message-ID: <20261002190018.696925-14-bjorn@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261002190018.696925-1-bjorn@kernel.org>
References: <20261002190018.696925-1-bjorn@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

fbnic gets RX buffers from page_pool. Use the XSK buffer pool as the
RX queue's page-pool memory provider, so allocation, DMA sync,
recycling and refill stay in page_pool. Only aligned 4 KiB UMEM
chunks are supported.

Each UMEM frame on the header queue must hold one packet. Raise the
header-split threshold to at least 3072 bytes, more than half of a
4 KiB page, so the device finishes the frame after one header. Cap
it to the space left in the frame after the headroom. An MTU above
the threshold needs a socket with XDP_USE_SG and an XDP program with
frags support. With XDP_USE_SG, the payload queue also uses UMEM
frames, and the device uses each frame for one descriptor only.
Without it, the payload queue uses a normal page pool. If the device
does not finish a provider frame after one descriptor, drop the
packet.

The BDQ refill loop now alternates header and payload buffers on all
queues, so two rings that share one finite provider stay balanced.
It keeps NAPI scheduled while the provider still has buffers.

Provider frames are never split, so they get no fragment bias. A
redirected frame can be recycled before its old BDQ slot is cleaned,
and a stale bias would corrupt the new allocation.

The headroom comes from the queue configuration. It must be at least
XDP_PACKET_HEADROOM, a multiple of 128 bytes, and fit the hardware
field; otherwise queue validation fails. MTU, ring parameter and XDP
program changes that do not fit an active provider are rejected.

fbnic did not support XDP_REDIRECT. Add it, with xdp_do_flush(), and
advertise it. This also enables copy-mode AF_XDP and the other
redirect targets on fbnic. Do not advertise AF_XDP zero copy until
TX support is added.

Signed-off-by: Björn Töpel <bjorn@kernel.org>
---
 .../net/ethernet/meta/fbnic/fbnic_ethtool.c   |   5 +
 .../net/ethernet/meta/fbnic/fbnic_netdev.c    | 140 ++++++-
 .../net/ethernet/meta/fbnic/fbnic_netdev.h    |   4 +
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.c  | 350 +++++++++++++-----
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.h  |   6 +
 5 files changed, 402 insertions(+), 103 deletions(-)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c b/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
index e774740fcb5d..188abe0ead14 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
@@ -385,6 +385,11 @@ fbnic_set_ringparam(struct net_device *netdev, struct ethtool_ringparam *ring,
 		return -EINVAL;
 	}
 
+	err = fbnic_xsk_validate(fbn, fbn->xdp_prog, netdev->mtu,
+				 kernel_ring->hds_thresh, extack);
+	if (err)
+		return err;
+
 	if (!netif_running(netdev)) {
 		fbnic_set_rings(fbn, ring, kernel_ring);
 		return 0;
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
index 8a6703afca38..038e91ef14e4 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
@@ -5,6 +5,8 @@
 #include <linux/ipv6.h>
 #include <linux/types.h>
 #include <net/netdev_queues.h>
+#include <net/netdev_rx_queue.h>
+#include <net/xdp_sock_drv.h>
 
 #include "fbnic.h"
 #include "fbnic_netdev.h"
@@ -276,6 +278,8 @@ static int fbnic_set_mac(struct net_device *netdev, void *p)
 static int fbnic_change_mtu(struct net_device *dev, int new_mtu)
 {
 	struct fbnic_net *fbn = netdev_priv(dev);
+	struct netlink_ext_ack extack = {};
+	int err;
 
 	if (fbnic_check_split_frames(fbn->xdp_prog, new_mtu, fbn->hds_thresh)) {
 		dev_err(&dev->dev,
@@ -285,6 +289,15 @@ static int fbnic_change_mtu(struct net_device *dev, int new_mtu)
 		return -EINVAL;
 	}
 
+	err = fbnic_xsk_validate(fbn, fbn->xdp_prog, new_mtu,
+				 fbn->hds_thresh, &extack);
+	if (err) {
+		if (extack._msg)
+			netdev_err(dev, "%s\n", extack._msg);
+
+		return err;
+	}
+
 	WRITE_ONCE(dev->mtu, new_mtu);
 
 	return 0;
@@ -534,26 +547,123 @@ bool fbnic_check_split_frames(struct bpf_prog *prog, unsigned int mtu,
 	return mtu + ETH_HLEN > hds_thresh;
 }
 
+u32 fbnic_xsk_hds_thresh(u32 headroom, u32 hds_thresh)
+{
+	u32 max_hds;
+
+	/* Reserve more than half a device page for each header so the device
+	 * retires the provider frame after one descriptor.
+	 */
+	static_assert(2 * FBNIC_XSK_HDS_THRESH > FBNIC_BD_PAGE_SIZE);
+
+	max_hds = FBNIC_BD_PAGE_SIZE - headroom - FBNIC_RX_TROOM -
+		  FBNIC_RX_PAD;
+
+	return min(max_t(u32, hds_thresh, FBNIC_XSK_HDS_THRESH), max_hds);
+}
+
+static int fbnic_xsk_validate_frames(struct xsk_buff_pool *pool,
+				     struct bpf_prog *prog,
+				     unsigned int mtu, u32 hds_thresh,
+				     struct netlink_ext_ack *extack)
+{
+	u32 xsk_hds_thresh;
+
+	xsk_hds_thresh = fbnic_xsk_hds_thresh(xsk_pool_get_headroom(pool),
+					      hds_thresh);
+
+	if (mtu + ETH_HLEN <= xsk_hds_thresh)
+		return 0;
+
+	if (!xsk_pool_uses_sg(pool)) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "AF_XDP zero-copy socket requires XDP_USE_SG");
+		return -EOPNOTSUPP;
+	}
+
+	if (fbnic_check_split_frames(prog, mtu, xsk_hds_thresh)) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "AF_XDP zero-copy socket requires XDP frags");
+		return -EOPNOTSUPP;
+	}
+
+	return 0;
+}
+
+int fbnic_xsk_validate(struct fbnic_net *fbn, struct bpf_prog *prog,
+		       unsigned int mtu, u32 hds_thresh,
+		       struct netlink_ext_ack *extack)
+{
+	struct net_device *netdev = fbn->netdev;
+	struct xsk_buff_pool *pool;
+	unsigned int qid;
+	int err;
+
+	for (qid = 0; qid < fbn->num_rx_queues; qid++) {
+		pool = xsk_get_pool_from_rxq(netdev, qid);
+		if (!pool)
+			continue;
+
+		err = fbnic_xsk_validate_frames(pool, prog, mtu, hds_thresh,
+						extack);
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
+
+static int fbnic_xsk_setup_pool(struct net_device *netdev,
+				struct xsk_buff_pool *pool, u16 queue_id,
+				struct netlink_ext_ack *extack)
+{
+	struct fbnic_net *fbn = netdev_priv(netdev);
+	int err;
+
+	if (queue_id >= fbn->num_rx_queues)
+		return -EINVAL;
+
+	if (!pool)
+		return xsk_pool_setup_page_pool(netdev, NULL, queue_id, extack);
+
+	err = fbnic_xsk_validate_frames(pool, fbn->xdp_prog, netdev->mtu,
+					fbn->hds_thresh, extack);
+	if (err)
+		return err;
+
+	return xsk_pool_setup_page_pool(netdev, pool, queue_id, extack);
+}
+
 static int fbnic_bpf(struct net_device *netdev, struct netdev_bpf *bpf)
 {
 	struct bpf_prog *prog = bpf->prog, *prev_prog;
 	struct fbnic_net *fbn = netdev_priv(netdev);
+	int err;
 
-	if (bpf->command != XDP_SETUP_PROG)
+	switch (bpf->command) {
+	case XDP_SETUP_PROG:
+		if (fbnic_check_split_frames(prog, netdev->mtu,
+					     fbn->hds_thresh)) {
+			NL_SET_ERR_MSG_MOD(bpf->extack,
+					   "MTU too high, or HDS threshold is too low for single buffer XDP");
+			return -EOPNOTSUPP;
+		}
+
+		err = fbnic_xsk_validate(fbn, prog, netdev->mtu,
+					 fbn->hds_thresh, bpf->extack);
+		if (err)
+			return err;
+
+		prev_prog = xchg(&fbn->xdp_prog, prog);
+		if (prev_prog)
+			bpf_prog_put(prev_prog);
+		return 0;
+	case XDP_SETUP_XSK_POOL:
+		return fbnic_xsk_setup_pool(netdev, bpf->xsk.pool,
+					    bpf->xsk.queue_id, bpf->extack);
+	default:
 		return -EINVAL;
-
-	if (fbnic_check_split_frames(prog, netdev->mtu,
-				     fbn->hds_thresh)) {
-		NL_SET_ERR_MSG_MOD(bpf->extack,
-				   "MTU too high, or HDS threshold is too low for single buffer XDP");
-		return -EOPNOTSUPP;
 	}
-
-	prev_prog = xchg(&fbn->xdp_prog, prog);
-	if (prev_prog)
-		bpf_prog_put(prev_prog);
-
-	return 0;
 }
 
 static const struct net_device_ops fbnic_netdev_ops = {
@@ -822,7 +932,9 @@ struct net_device *fbnic_netdev_alloc(struct fbnic_dev *fbd)
 	netdev->hw_enc_features |= netdev->features;
 	netdev->features |= NETIF_F_NTUPLE;
 
-	netdev->xdp_features = NETDEV_XDP_ACT_BASIC | NETDEV_XDP_ACT_RX_SG;
+	netdev->xdp_features = NETDEV_XDP_ACT_BASIC |
+			       NETDEV_XDP_ACT_REDIRECT |
+			       NETDEV_XDP_ACT_RX_SG;
 
 	netdev->min_mtu = IPV6_MIN_MTU;
 	netdev->max_mtu = FBNIC_MAX_JUMBO_FRAME_SIZE - ETH_HLEN;
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.h b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.h
index eded20b0e9e4..ba425302ccfd 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.h
@@ -116,4 +116,8 @@ int fbnic_phylink_init(struct net_device *netdev);
 void fbnic_phylink_pmd_training_complete_notify(struct net_device *netdev);
 bool fbnic_check_split_frames(struct bpf_prog *prog,
 			      unsigned int mtu, u32 hds_threshold);
+int fbnic_xsk_validate(struct fbnic_net *fbn, struct bpf_prog *prog,
+		       unsigned int mtu, u32 hds_thresh,
+		       struct netlink_ext_ack *extack);
+u32 fbnic_xsk_hds_thresh(u32 headroom, u32 hds_thresh);
 #endif /* _FBNIC_NETDEV_H_ */
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
index 0c7b1ea002d8..e6043607d4e2 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
@@ -12,6 +12,7 @@
 #include <net/page_pool/helpers.h>
 #include <net/tcp.h>
 #include <net/xdp.h>
+#include <net/xdp_sock_drv.h>
 
 #include "fbnic.h"
 #include "fbnic_csr.h"
@@ -22,6 +23,7 @@ enum {
 	FBNIC_XDP_PASS = 0,
 	FBNIC_XDP_CONSUME,
 	FBNIC_XDP_TX,
+	FBNIC_XDP_REDIRECT,
 	FBNIC_XDP_LEN_ERR,
 };
 
@@ -758,21 +760,29 @@ static void fbnic_page_pool_init(struct fbnic_ring *ring, unsigned int idx,
 				 netmem_ref netmem)
 {
 	struct fbnic_rx_buf *rx_buf = &ring->rx_buf[idx];
+	unsigned int pagecnt_bias;
 
-	page_pool_fragment_netmem(netmem, FBNIC_PAGECNT_BIAS_MAX);
-	rx_buf->pagecnt_bias = FBNIC_PAGECNT_BIAS_MAX;
+	/* Unsplittable provider frames can be recycled before the BDQ entry is
+	 * cleaned.
+	 */
+	if (page_pool_supports_frag(ring->page_pool)) {
+		pagecnt_bias = FBNIC_PAGECNT_BIAS_MAX;
+		page_pool_fragment_netmem(netmem, pagecnt_bias);
+	} else {
+		pagecnt_bias = 1;
+	}
+	rx_buf->pagecnt_bias = pagecnt_bias;
 	rx_buf->netmem = netmem;
 }
 
-static struct page *
+static netmem_ref
 fbnic_page_pool_get_head(struct fbnic_q_triad *qt, unsigned int idx)
 {
 	struct fbnic_rx_buf *rx_buf = &qt->sub0.rx_buf[idx];
 
 	rx_buf->pagecnt_bias--;
 
-	/* sub0 is always fed system pages, from the NAPI-level page_pool */
-	return netmem_to_page(rx_buf->netmem);
+	return rx_buf->netmem;
 }
 
 static netmem_ref
@@ -791,7 +801,8 @@ static void fbnic_page_pool_drain(struct fbnic_ring *ring, unsigned int idx,
 	struct fbnic_rx_buf *rx_buf = &ring->rx_buf[idx];
 	netmem_ref netmem = rx_buf->netmem;
 
-	if (!page_pool_unref_netmem(netmem, rx_buf->pagecnt_bias))
+	if (rx_buf->pagecnt_bias &&
+	    !page_pool_unref_netmem(netmem, rx_buf->pagecnt_bias))
 		page_pool_put_unrefed_netmem(ring->page_pool, netmem, -1,
 					     !!budget);
 
@@ -930,66 +941,121 @@ static void fbnic_bd_prep(struct fbnic_ring *bdq, u16 id, netmem_ref netmem)
 	} while (--i);
 }
 
-static void fbnic_fill_bdq(struct fbnic_ring *bdq)
+static bool fbnic_fill_bdq_one(struct fbnic_ring *bdq, unsigned int *tail)
 {
-	unsigned int count = fbnic_desc_unused(bdq);
-	unsigned int i = bdq->tail;
+	netmem_ref netmem;
 
-	if (!count)
-		return;
-
-	do {
-		netmem_ref netmem;
-
-		netmem = page_pool_dev_alloc_netmems(bdq->page_pool);
-		if (!netmem) {
-			u64_stats_update_begin(&bdq->stats.syncp);
-			bdq->stats.bdq.alloc_failed++;
-			u64_stats_update_end(&bdq->stats.syncp);
-
-			break;
-		}
-
-		fbnic_page_pool_init(bdq, i, netmem);
-		fbnic_bd_prep(bdq, i, netmem);
-
-		i++;
-		i &= bdq->size_mask;
-
-		count--;
-	} while (count);
-
-	if (bdq->tail != i) {
-		bdq->tail = i;
-
-		/* Force DMA writes to flush before writing to tail */
-		dma_wmb();
-
-		writel(i * fbnic_bd_page_count(bdq), bdq->doorbell);
+	netmem = page_pool_dev_alloc_netmems(bdq->page_pool);
+	if (!netmem) {
+		u64_stats_update_begin(&bdq->stats.syncp);
+		bdq->stats.bdq.alloc_failed++;
+		u64_stats_update_end(&bdq->stats.syncp);
+		return false;
 	}
+
+	fbnic_page_pool_init(bdq, *tail, netmem);
+	fbnic_bd_prep(bdq, *tail, netmem);
+	*tail = (*tail + 1) & bdq->size_mask;
+
+	return true;
 }
 
-static unsigned int fbnic_hdr_pg_start(unsigned int pg_off)
+static void fbnic_fill_bdq_done(struct fbnic_ring *bdq, unsigned int tail)
+{
+	if (tail == bdq->tail)
+		return;
+
+	bdq->tail = tail;
+
+	/* Force DMA writes to flush before writing to tail */
+	dma_wmb();
+	writel(tail * fbnic_bd_page_count(bdq), bdq->doorbell);
+}
+
+static bool fbnic_fill_bdqs(struct fbnic_q_triad *qt)
+{
+	unsigned int hpq_count = fbnic_desc_unused(&qt->sub0);
+	unsigned int ppq_count = fbnic_desc_unused(&qt->sub1);
+	unsigned int hpq_tail = qt->sub0.tail;
+	unsigned int ppq_tail = qt->sub1.tail;
+	bool same_pool = qt->sub0.page_pool == qt->sub1.page_pool;
+	bool hpq_alloc = true;
+	bool ppq_alloc = true;
+	bool complete;
+
+	while ((hpq_alloc && hpq_count) || (ppq_alloc && ppq_count)) {
+		if (hpq_alloc && hpq_count) {
+			hpq_alloc = fbnic_fill_bdq_one(&qt->sub0, &hpq_tail);
+			hpq_count--;
+		}
+		if (ppq_alloc && ppq_count) {
+			ppq_alloc = fbnic_fill_bdq_one(&qt->sub1, &ppq_tail);
+			ppq_count--;
+		}
+	}
+
+	fbnic_fill_bdq_done(&qt->sub0, hpq_tail);
+	fbnic_fill_bdq_done(&qt->sub1, ppq_tail);
+
+	if (same_pool)
+		return page_pool_refill_done(qt->sub0.page_pool,
+					     !fbnic_desc_unused(&qt->sub0) &&
+					     !fbnic_desc_unused(&qt->sub1));
+
+	complete = page_pool_refill_done(qt->sub0.page_pool,
+					 !fbnic_desc_unused(&qt->sub0));
+	complete &= page_pool_refill_done(qt->sub1.page_pool,
+					  !fbnic_desc_unused(&qt->sub1));
+
+	return complete;
+}
+
+static unsigned int fbnic_hdr_pg_start(unsigned int pg_off,
+				       unsigned int hroom)
 {
 	/* The headroom of the first header may be larger than FBNIC_RX_HROOM
 	 * due to alignment. So account for that by just making the page
 	 * offset 0 if we are starting at the first header.
 	 */
-	if (ALIGN(FBNIC_RX_HROOM, 128) > FBNIC_RX_HROOM &&
-	    pg_off == ALIGN(FBNIC_RX_HROOM, 128))
+	if (ALIGN(hroom, FBNIC_RX_HROOM_PAD) > hroom &&
+	    pg_off == ALIGN(hroom, FBNIC_RX_HROOM_PAD))
 		return 0;
 
-	return pg_off - FBNIC_RX_HROOM;
+	return pg_off - hroom;
 }
 
-static unsigned int fbnic_hdr_pg_end(unsigned int pg_off, unsigned int len)
+static unsigned int fbnic_hdr_pg_end(unsigned int pg_off, unsigned int len,
+				     unsigned int hroom)
 {
 	/* Determine the end of the buffer by finding the start of the next
 	 * and then subtracting the headroom from that frame.
 	 */
-	pg_off += len + FBNIC_RX_TROOM + FBNIC_RX_HROOM;
+	pg_off += len + FBNIC_RX_TROOM + hroom;
 
-	return ALIGN(pg_off, 128) - FBNIC_RX_HROOM;
+	return ALIGN(pg_off, FBNIC_RX_HROOM_PAD) - hroom;
+}
+
+static bool
+fbnic_netmem_page_finished(struct fbnic_napi_vector *nv,
+			   struct fbnic_ring *bdq, unsigned int q_idx, u64 rcd)
+{
+	unsigned int idx = fbnic_rcd_bd_idx(bdq, rcd);
+	long bias = bdq->rx_buf[idx].pagecnt_bias;
+	bool page_finished;
+
+	page_finished = FIELD_GET(FBNIC_RCD_AL_PAGE_FIN, rcd);
+
+	/* Fragmentable pages start with a bias greater than one. */
+	if (bias > 1 || (bias == 1 && page_finished))
+		return true;
+
+	netdev_err_once(nv->napi.dev,
+			"Provider buffer not retired: queue %u id %u offset %llu len %llu\n",
+			q_idx, idx,
+			FIELD_GET(FBNIC_RCD_AL_BUFF_OFF_MASK, rcd),
+			FIELD_GET(FBNIC_RCD_AL_BUFF_LEN_MASK, rcd));
+
+	return false;
 }
 
 static void fbnic_pkt_prepare(struct fbnic_napi_vector *nv, u64 rcd,
@@ -1001,36 +1067,44 @@ static void fbnic_pkt_prepare(struct fbnic_napi_vector *nv, u64 rcd,
 	unsigned int hdr_pg_idx = fbnic_rcd_bd_idx(&qt->sub0, rcd);
 	unsigned int frame_sz, hdr_pg_start, hdr_pg_end, headroom;
 	unsigned char *hdr_start;
-	struct page *page;
+	netmem_ref netmem;
 
 	/* data_hard_start should always be NULL when this is called */
 	WARN_ON_ONCE(pkt->buff.data_hard_start);
+	pkt->add_frag_failed = false;
+	if (unlikely(!fbnic_netmem_page_finished(nv, &qt->sub0,
+						 qt->cmpl.q_idx, rcd))) {
+		pkt->add_frag_failed = true;
+		return;
+	}
 
-	page = fbnic_page_pool_get_head(qt, hdr_pg_idx);
+	netmem = fbnic_page_pool_get_head(qt, hdr_pg_idx);
 
 	/* Short-cut the end calculation if we know page is fully consumed */
 	hdr_pg_end = FIELD_GET(FBNIC_RCD_AL_PAGE_FIN, rcd) ?
-		     FBNIC_BD_PAGE_SIZE : fbnic_hdr_pg_end(hdr_pg_off, len);
-	hdr_pg_start = fbnic_hdr_pg_start(hdr_pg_off);
+		     FBNIC_BD_PAGE_SIZE :
+		     fbnic_hdr_pg_end(hdr_pg_off, len, qt->rx_hroom);
+	hdr_pg_start = fbnic_hdr_pg_start(hdr_pg_off, qt->rx_hroom);
+	hdr_start = netmem_address(netmem);
+	hdr_pg_start += qt->rx_frame_off;
 
 	headroom = hdr_pg_off - hdr_pg_start + FBNIC_RX_PAD;
 	frame_sz = hdr_pg_end - hdr_pg_start;
-	xdp_init_buff(&pkt->buff, frame_sz, &qt->xdp_rxq);
+	xdp_init_buff_from_netmem(&pkt->buff, frame_sz, &qt->xdp_rxq,
+				  netmem, &pkt->sinfo);
 	hdr_pg_start += fbnic_rcd_bd_page_offset(&qt->sub0, rcd);
 
 	/* Sync DMA buffer */
-	dma_sync_single_range_for_cpu(nv->dev, page_pool_get_dma_addr(page),
-				      hdr_pg_start, frame_sz,
-				      DMA_BIDIRECTIONAL);
+	page_pool_dma_sync_netmem_for_cpu(qt->sub0.page_pool, netmem,
+					  hdr_pg_start, frame_sz);
 
 	/* Build frame around buffer */
-	hdr_start = page_address(page) + hdr_pg_start;
+	hdr_start += hdr_pg_start;
 	net_prefetch(pkt->buff.data);
 	xdp_prepare_buff(&pkt->buff, hdr_start, headroom,
 			 len - FBNIC_RX_PAD, true);
 
 	pkt->hwtstamp = 0;
-	pkt->add_frag_failed = false;
 }
 
 static void fbnic_add_rx_frag(struct fbnic_napi_vector *nv, u64 rcd,
@@ -1044,6 +1118,12 @@ static void fbnic_add_rx_frag(struct fbnic_napi_vector *nv, u64 rcd,
 	netmem_ref netmem;
 	bool added;
 
+	if (unlikely(!fbnic_netmem_page_finished(nv, &qt->sub1,
+						 qt->cmpl.q_idx, rcd))) {
+		pkt->add_frag_failed = true;
+		return;
+	}
+
 	netmem = fbnic_page_pool_get_data(qt, pg_idx);
 
 	truesize = FIELD_GET(FBNIC_RCD_AL_PAGE_FIN, rcd) ?
@@ -1052,6 +1132,12 @@ static void fbnic_add_rx_frag(struct fbnic_napi_vector *nv, u64 rcd,
 
 	pg_off += fbnic_rcd_bd_page_offset(&qt->sub1, rcd);
 
+	/* The head buffer cannot safely hold fragment metadata. */
+	if (unlikely(pkt->add_frag_failed)) {
+		page_pool_put_full_netmem(qt->sub1.page_pool, netmem, true);
+		return;
+	}
+
 	/* Sync DMA buffer */
 	page_pool_dma_sync_netmem_for_cpu(qt->sub1.page_pool, netmem,
 					  pg_off, truesize);
@@ -1071,8 +1157,6 @@ static void fbnic_add_rx_frag(struct fbnic_napi_vector *nv, u64 rcd,
 static void fbnic_put_pkt_buff(struct fbnic_q_triad *qt,
 			       struct fbnic_pkt_buff *pkt, int budget)
 {
-	struct page *page;
-
 	if (!pkt->buff.data_hard_start)
 		return;
 
@@ -1091,8 +1175,8 @@ static void fbnic_put_pkt_buff(struct fbnic_q_triad *qt,
 		}
 	}
 
-	page = virt_to_page(pkt->buff.data_hard_start);
-	page_pool_put_full_page(qt->sub0.page_pool, page, !!budget);
+	page_pool_put_full_netmem(qt->sub0.page_pool,
+				  xdp_buff_get_netmem(&pkt->buff), !!budget);
 }
 
 static struct sk_buff *fbnic_build_skb(struct fbnic_napi_vector *nv,
@@ -1211,6 +1295,10 @@ static struct sk_buff *fbnic_run_xdp(struct fbnic_napi_vector *nv,
 		return fbnic_build_skb(nv, pkt);
 	case XDP_TX:
 		return ERR_PTR(fbnic_pkt_tx(nv, pkt));
+	case XDP_REDIRECT:
+		if (xdp_do_redirect(nv->napi.dev, &pkt->buff, xdp_prog))
+			break;
+		return ERR_PTR(-FBNIC_XDP_REDIRECT);
 	default:
 		bpf_warn_invalid_xdp_action(nv->napi.dev, xdp_prog, act);
 		fallthrough;
@@ -1280,6 +1368,8 @@ static int fbnic_clean_rcq(struct fbnic_napi_vector *nv,
 	struct fbnic_ring *rcq = &qt->cmpl;
 	struct fbnic_pkt_buff *pkt;
 	__le64 *raw_rcd, done;
+	bool redirect = false;
+	bool complete;
 	u32 head = rcq->head;
 
 	done = (head & (rcq->size_mask + 1)) ? cpu_to_le64(FBNIC_RCD_DONE) : 0;
@@ -1334,6 +1424,8 @@ static int fbnic_clean_rcq(struct fbnic_napi_vector *nv,
 				napi_gro_receive(&nv->napi, skb);
 			} else if (skb == ERR_PTR(-FBNIC_XDP_TX)) {
 				pkt_tail = nv->qt[0].sub1.tail;
+			} else if (skb == ERR_PTR(-FBNIC_XDP_REDIRECT)) {
+				redirect = true;
 			} else if (PTR_ERR(skb) == -FBNIC_XDP_CONSUME) {
 				fbnic_put_pkt_buff(qt, pkt, 1);
 			} else {
@@ -1377,15 +1469,17 @@ static int fbnic_clean_rcq(struct fbnic_napi_vector *nv,
 
 	if (pkt_tail >= 0)
 		fbnic_pkt_commit_tail(nv, pkt_tail);
+	if (redirect)
+		xdp_do_flush();
 
 	/* Unmap and free processed buffers */
 	if (head0 >= 0)
 		fbnic_clean_bdq(&qt->sub0, head0, budget);
-	fbnic_fill_bdq(&qt->sub0);
 
 	if (head1 >= 0)
 		fbnic_clean_bdq(&qt->sub1, head1, budget);
-	fbnic_fill_bdq(&qt->sub1);
+
+	complete = fbnic_fill_bdqs(qt);
 
 	/* Record the current head/tail of the queue */
 	if (rcq->head != head) {
@@ -1393,7 +1487,7 @@ static int fbnic_clean_rcq(struct fbnic_napi_vector *nv,
 		writel(head & rcq->size_mask, rcq->doorbell);
 	}
 
-	return packets;
+	return complete ? packets : budget;
 }
 
 static void fbnic_nv_irq_disable(struct fbnic_napi_vector *nv)
@@ -1594,8 +1688,10 @@ void fbnic_free_napi_vectors(struct fbnic_net *fbn)
 
 static int
 fbnic_alloc_qt_page_pools(struct fbnic_net *fbn, struct fbnic_q_triad *qt,
-			  unsigned int rxq_idx, u32 rx_page_size)
+			  unsigned int rxq_idx,
+			  const struct netdev_queue_config *qcfg)
 {
+	u32 rx_page_size = qcfg->rx_page_size;
 	struct page_pool_params pp_params = {
 		.order = 0,
 		.flags = PP_FLAG_DMA_MAP |
@@ -1609,7 +1705,12 @@ fbnic_alloc_qt_page_pools(struct fbnic_net *fbn, struct fbnic_q_triad *qt,
 		.netdev	= fbn->netdev,
 		.queue_idx = rxq_idx,
 	};
+	struct xsk_buff_pool *xsk_pool = NULL;
 	struct page_pool *pp;
+	bool xsk_sg = false;
+
+	qt->rx_hroom = FBNIC_RX_HROOM;
+	qt->rx_frame_off = 0;
 
 	/* Page pool cannot exceed a size of 32768. This doesn't limit the
 	 * pages on the ring but the number we can have cached waiting on
@@ -1623,6 +1724,21 @@ fbnic_alloc_qt_page_pools(struct fbnic_net *fbn, struct fbnic_q_triad *qt,
 	if (pp_params.pool_size > 32768)
 		pp_params.pool_size = 32768;
 
+	xsk_pool = xsk_get_pool_from_rxq(fbn->netdev, rxq_idx);
+	qt->xsk_pool = xsk_pool;
+	if (xsk_pool) {
+		xsk_sg = xsk_pool_uses_sg(xsk_pool);
+		pp_params.flags |= PP_FLAG_ALLOW_UNREADABLE_NETMEM;
+	}
+
+	/* A memory provider reserves headroom in front of the XDP headroom.
+	 * The frame, and data_hard_start, begin after it.
+	 */
+	if (qcfg->rx_headroom) {
+		qt->rx_hroom = qcfg->rx_headroom;
+		qt->rx_frame_off = qcfg->rx_headroom - XDP_PACKET_HEADROOM;
+	}
+
 	pp = page_pool_create(&pp_params);
 	if (IS_ERR(pp))
 		return PTR_ERR(pp);
@@ -1634,6 +1750,12 @@ fbnic_alloc_qt_page_pools(struct fbnic_net *fbn, struct fbnic_q_triad *qt,
 		pp_params.flags |= PP_FLAG_ALLOW_UNREADABLE_NETMEM;
 		pp_params.dma_dir = DMA_FROM_DEVICE;
 
+		pp = page_pool_create(&pp_params);
+		if (IS_ERR(pp))
+			goto err_destroy_sub0;
+	} else if (xsk_pool && !xsk_sg) {
+		pp_params.flags &= ~PP_FLAG_ALLOW_UNREADABLE_NETMEM;
+
 		pp = page_pool_create(&pp_params);
 		if (IS_ERR(pp))
 			goto err_destroy_sub0;
@@ -2058,19 +2180,20 @@ static int fbnic_alloc_tx_qt_resources(struct fbnic_net *fbn,
 	return err;
 }
 
-static int fbnic_alloc_rx_qt_resources(struct fbnic_net *fbn,
-				       struct fbnic_napi_vector *nv,
-				       struct fbnic_q_triad *qt,
-				       u32 rx_page_size)
+static int
+fbnic_alloc_rx_qt_resources(struct fbnic_net *fbn,
+			    struct fbnic_napi_vector *nv,
+			    struct fbnic_q_triad *qt,
+			    const struct netdev_queue_config *qcfg)
 {
 	struct device *dev = fbn->netdev->dev.parent;
 	int err;
 
-	err = fbnic_alloc_qt_page_pools(fbn, qt, qt->cmpl.q_idx, rx_page_size);
+	err = fbnic_alloc_qt_page_pools(fbn, qt, qt->cmpl.q_idx, qcfg);
 	if (err)
 		return err;
 
-	fbnic_bdq_set_page_size(&qt->sub1, rx_page_size);
+	fbnic_bdq_set_page_size(&qt->sub1, qcfg->rx_page_size);
 
 	err = xdp_rxq_info_reg(&qt->xdp_rxq, fbn->netdev, qt->cmpl.q_idx,
 			       nv->napi.napi_id);
@@ -2135,8 +2258,7 @@ static int fbnic_alloc_nv_resources(struct fbnic_net *fbn,
 		struct netdev_queue_config qcfg;
 
 		netdev_queue_config(fbn->netdev, nv->qt[i].cmpl.q_idx, &qcfg);
-		err = fbnic_alloc_rx_qt_resources(fbn, nv, &nv->qt[i],
-						  qcfg.rx_page_size);
+		err = fbnic_alloc_rx_qt_resources(fbn, nv, &nv->qt[i], &qcfg);
 		if (err)
 			goto free_qt_resources;
 	}
@@ -2531,8 +2653,7 @@ static void fbnic_nv_fill(struct fbnic_napi_vector *nv)
 		struct fbnic_q_triad *qt = &nv->qt[t];
 
 		/* Populate the header and payload BDQs */
-		fbnic_fill_bdq(&qt->sub0);
-		fbnic_fill_bdq(&qt->sub1);
+		fbnic_fill_bdqs(qt);
 	}
 }
 
@@ -2660,8 +2781,14 @@ static void fbnic_config_drop_mode_rcq(struct fbnic_napi_vector *nv,
 				       struct fbnic_ring *rcq, bool tx_pause,
 				       bool hdr_split)
 {
+	struct fbnic_q_triad *qt = container_of(rcq, struct fbnic_q_triad,
+					       cmpl);
 	struct fbnic_net *fbn = netdev_priv(nv->napi.dev);
-	u32 drop_mode, rcq_ctl;
+	u32 drop_mode, hroom, rcq_ctl;
+
+	/* The maximum field value rounds up to one aligned unit more. */
+	hroom = min_t(u32, qt->rx_hroom,
+		      FIELD_MAX(FBNIC_QUEUE_RDE_CTL0_MIN_HROOM_MASK));
 
 	if (!tx_pause && fbn->num_rx_queues > 1)
 		drop_mode = FBNIC_QUEUE_RDE_CTL0_DROP_IMMEDIATE;
@@ -2670,25 +2797,40 @@ static void fbnic_config_drop_mode_rcq(struct fbnic_napi_vector *nv,
 
 	/* Specify packet layout */
 	rcq_ctl = FIELD_PREP(FBNIC_QUEUE_RDE_CTL0_DROP_MODE_MASK, drop_mode) |
-	    FIELD_PREP(FBNIC_QUEUE_RDE_CTL0_MIN_HROOM_MASK, FBNIC_RX_HROOM) |
+	    FIELD_PREP(FBNIC_QUEUE_RDE_CTL0_MIN_HROOM_MASK, hroom) |
 	    FIELD_PREP(FBNIC_QUEUE_RDE_CTL0_MIN_TROOM_MASK, FBNIC_RX_TROOM) |
 	    FIELD_PREP(FBNIC_QUEUE_RDE_CTL0_EN_HDR_SPLIT, hdr_split);
 
 	fbnic_ring_wr32(rcq, FBNIC_QUEUE_RDE_CTL0, rcq_ctl);
 }
 
+static u32 fbnic_rcq_hds_thresh(const struct fbnic_net *fbn,
+				const struct fbnic_ring *rcq)
+{
+	const struct fbnic_q_triad *qt;
+	u32 hds_thresh = fbn->hds_thresh;
+
+	/* Link-up calls this without the netdev lock. Use the headroom
+	 * cached in the queue; the pool may be going away.
+	 */
+	qt = container_of(rcq, const struct fbnic_q_triad, cmpl);
+	if (qt->xsk_pool)
+		hds_thresh = fbnic_xsk_hds_thresh(qt->rx_hroom, hds_thresh);
+
+	return hds_thresh;
+}
+
 void fbnic_config_drop_mode(struct fbnic_net *fbn, bool txp)
 {
-	bool hds;
 	int i, t;
 
-	hds = fbn->hds_thresh < FBNIC_HDR_BYTES_MIN;
-
 	for (i = 0; i < fbn->num_napi; i++) {
 		struct fbnic_napi_vector *nv = fbn->napi[i];
 
 		for (t = 0; t < nv->rxt_count; t++) {
 			struct fbnic_q_triad *qt = &nv->qt[nv->txt_count + t];
+			u32 hds_thresh = fbnic_rcq_hds_thresh(fbn, &qt->cmpl);
+			bool hds = hds_thresh < FBNIC_HDR_BYTES_MIN;
 
 			fbnic_config_drop_mode_rcq(nv, &qt->cmpl, txp, hds);
 		}
@@ -2755,26 +2897,38 @@ void fbnic_config_rx_frames(struct fbnic_napi_vector *nv)
 static void fbnic_enable_rcq(struct fbnic_napi_vector *nv,
 			     struct fbnic_ring *rcq)
 {
+	struct fbnic_q_triad *qt = container_of(rcq, struct fbnic_q_triad,
+					       cmpl);
 	struct fbnic_net *fbn = netdev_priv(nv->napi.dev);
+	u32 payld_pg_cl = FBNIC_RX_PAYLD_PG_CL;
+	u32 payld_off = FBNIC_RX_PAYLD_OFFSET;
 	u32 log_size = fls(rcq->size_mask);
 	u32 rcq_ctl = 0;
 	bool hdr_split;
 	u32 hds_thresh;
 
+	if (!page_pool_supports_frag(qt->sub1.page_pool)) {
+		/* Align and retire each payload provider frame after one
+		 * descriptor.
+		 */
+		payld_pg_cl = ilog2(FBNIC_BD_PAGE_SIZE / FBNIC_RX_PAYLD_ALIGN);
+		payld_off = ilog2(FBNIC_BD_PAGE_SIZE / FBNIC_RX_PAYLD_ALIGN);
+	}
+
 	/* Force lower bound on MAX_HEADER_BYTES. Below this, all frames should
 	 * be split at L4. It would also result in the frames being split at
 	 * L2/L3 depending on the frame size.
 	 */
-	hdr_split = fbn->hds_thresh < FBNIC_HDR_BYTES_MIN;
+	hds_thresh = fbnic_rcq_hds_thresh(fbn, rcq);
+	hdr_split = hds_thresh < FBNIC_HDR_BYTES_MIN;
 	fbnic_config_drop_mode_rcq(nv, rcq, fbn->tx_pause, hdr_split);
 
-	hds_thresh = max(fbn->hds_thresh, FBNIC_HDR_BYTES_MIN);
+	hds_thresh = max(hds_thresh, FBNIC_HDR_BYTES_MIN);
 	rcq_ctl |= FIELD_PREP(FBNIC_QUEUE_RDE_CTL1_PADLEN_MASK, FBNIC_RX_PAD) |
 		   FIELD_PREP(FBNIC_QUEUE_RDE_CTL1_MAX_HDR_MASK, hds_thresh) |
-		   FIELD_PREP(FBNIC_QUEUE_RDE_CTL1_PAYLD_OFF_MASK,
-			      FBNIC_RX_PAYLD_OFFSET) |
+		   FIELD_PREP(FBNIC_QUEUE_RDE_CTL1_PAYLD_OFF_MASK, payld_off) |
 		   FIELD_PREP(FBNIC_QUEUE_RDE_CTL1_PAYLD_PG_CL_MASK,
-			      FBNIC_RX_PAYLD_PG_CL);
+			      payld_pg_cl);
 	fbnic_ring_wr32(rcq, FBNIC_QUEUE_RDE_CTL1, rcq_ctl);
 
 	/* Reset head/tail */
@@ -2931,8 +3085,7 @@ static int fbnic_queue_mem_alloc(struct net_device *dev,
 	struct fbnic_napi_vector *nv;
 
 	if (!netif_running(dev))
-		return fbnic_alloc_qt_page_pools(fbn, qt, idx,
-						 qcfg->rx_page_size);
+		return fbnic_alloc_qt_page_pools(fbn, qt, idx, qcfg);
 
 	/* A failed PCIe recovery or resume can leave the datapath torn down
 	 * while netif_running() is still true.  This ndo runs before
@@ -2952,7 +3105,7 @@ static int fbnic_queue_mem_alloc(struct net_device *dev,
 	fbnic_ring_init(&qt->cmpl, real->cmpl.doorbell, real->cmpl.q_idx,
 			real->cmpl.flags);
 
-	return fbnic_alloc_rx_qt_resources(fbn, nv, qt, qcfg->rx_page_size);
+	return fbnic_alloc_rx_qt_resources(fbn, nv, qt, qcfg);
 }
 
 static void fbnic_default_qcfg(struct net_device *dev,
@@ -2961,6 +3114,20 @@ static void fbnic_default_qcfg(struct net_device *dev,
 	qcfg->rx_page_size = PAGE_SIZE;
 }
 
+/* Header starts are rounded up to the hardware alignment, and XDP needs its
+ * own headroom.
+ */
+static bool fbnic_rx_headroom_valid(u32 hroom)
+{
+	u32 max_hroom;
+
+	max_hroom = ALIGN(FIELD_MAX(FBNIC_QUEUE_RDE_CTL0_MIN_HROOM_MASK),
+			  FBNIC_RX_HROOM_PAD);
+
+	return hroom >= XDP_PACKET_HEADROOM && hroom <= max_hroom &&
+	       IS_ALIGNED(hroom, FBNIC_RX_HROOM_PAD);
+}
+
 static int fbnic_validate_qcfg(struct net_device *dev,
 			       struct netdev_queue_config *qcfg,
 			       struct netlink_ext_ack *extack)
@@ -2989,6 +3156,11 @@ static int fbnic_validate_qcfg(struct net_device *dev,
 		return -EINVAL;
 	}
 
+	if (qcfg->rx_headroom && !fbnic_rx_headroom_valid(qcfg->rx_headroom)) {
+		NL_SET_ERR_MSG_MOD(extack, "rx_headroom is not supported");
+		return -EINVAL;
+	}
+
 	/* Payload fragments occupy multiples of FBNIC_RX_PAYLD_ALIGN bytes.
 	 * Keep at least one reference in the bias until fbnic_clean_bdq()
 	 * observes a completion from a subsequent allocation.
@@ -3119,5 +3291,5 @@ const struct netdev_queue_mgmt_ops fbnic_queue_mgmt_ops = {
 	.ndo_queue_stop		= fbnic_queue_stop,
 	.ndo_default_qcfg	= fbnic_default_qcfg,
 	.ndo_validate_qcfg	= fbnic_validate_qcfg,
-	.supported_params	= QCFG_RX_PAGE_SIZE,
+	.supported_params	= QCFG_RX_PAGE_SIZE | QCFG_RX_HEADROOM,
 };
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.h b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.h
index 6ee3cce3d942..abc96a12ea5c 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.h
@@ -15,6 +15,7 @@
 #include "fbnic_csr.h"
 
 struct fbnic_net;
+struct xsk_buff_pool;
 
 /* Guarantee we have space needed for storing the buffer
  * To store the buffer we need:
@@ -77,12 +78,14 @@ struct fbnic_net;
 	(4096 - FBNIC_RX_HROOM - FBNIC_RX_TROOM - FBNIC_RX_PAD)
 #define FBNIC_HDS_THRESH_DEFAULT \
 	(1536 - FBNIC_RX_PAD)
+#define FBNIC_XSK_HDS_THRESH		3072
 #define FBNIC_HDR_BYTES_MIN		256
 
 struct fbnic_pkt_buff {
 	struct xdp_buff buff;
 	ktime_t hwtstamp;
 	bool add_frag_failed;
+	struct skb_shared_info sinfo;
 };
 
 struct fbnic_queue_stats {
@@ -162,6 +165,9 @@ struct fbnic_ring {
 struct fbnic_q_triad {
 	struct fbnic_ring sub0, sub1, cmpl;
 	struct xdp_rxq_info xdp_rxq;
+	struct xsk_buff_pool *xsk_pool;
+	u16 rx_hroom;
+	u16 rx_frame_off;
 };
 
 struct fbnic_napi_vector {
-- 
2.55.0

