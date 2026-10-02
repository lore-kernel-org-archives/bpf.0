Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 188893EA94C;
	Fri,  2 Oct 2026 19:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790967745; cv=none; b=iQyKWr/QdJRRBc24Oy2/zUZQv48vPXj7/5iNXyLcPdS9sMrTGN2wRYqGwOdf3KdfidpkDfRbcEz7HDSj2FZB+7CLACYkcfEC7QDFsK2dR46VVWa81Cad+mFXU73nbKHEG/0X02NdLdJgm1JlQnzpPTS9e1a+fNijlX4WEIGGvuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790967745; c=relaxed/simple;
	bh=8jUA3JAFViYdMqlsRxcwgphsrbTxI7GGBPRSGQIvus8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EHvSCDADULZlodM6HzEXy8F/PL7oYn2z4no2MkDtelqnV2uMbRE5Ob+pnDaTJiEm95iAzk/TKZYcDOd4JD/dHsYzDYGIwOwmAiay1kKEoMaljJoSe/nwnuhIbJ+kuMO23/S9wgby90aX5zHNRpOnm1hvxIZ85wfkOaEAtwYTDic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UWXrE8WK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UWXrE8WK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 403A41F00893;
	Fri,  2 Oct 2026 19:02:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790967743;
	bh=FsUGkNLCpR92ufmFZWhJaVPA0EE2+xehQ5oNNxRQbYI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UWXrE8WKmUlyMqSNurrOB7zz9GgN7TA2D5UN/ZjPH1sHYqy6aBEqnf0GU/DYf3tvX
	 uLYj2OeTd8dDl1o0dytcqsDoJtmPvTUlUlJ6iAVJPabeaxQI/AneopIeGDleeuqpQV
	 9OmgD9mDeVIGs3b7OmC8+AABPmjxnHYFvDLg5+VfzGb0eiqcWlHQSENdRE0nThPCGN
	 1+XhvY4bFiLEkk4+zpGAHUSyNXQaA1cbTUVqf8/q8A92erNr6p4mqvPvwlahLiOLZd
	 wcHtsmXu0kfoNHG5QEhp9X9+j810vItRvrG0BWLQsz5/UUkOJbcP31yLbGtSE0+mNW
	 taaU0X0/PxlxA==
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
Subject: [RFC net-next 14/15] eth: fbnic: Support AF_XDP zero-copy transmit
Date: Fri,  2 Oct 2026 21:00:15 +0200
Message-ID: <20261002190018.696925-15-bjorn@kernel.org>
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

AF_XDP zero copy cannot be advertised until fbnic can send socket TX
descriptors and report their completion.

Send socket descriptors from the RX NAPI poll, and add
ndo_xsk_wakeup to schedule that poll. Record the type of each XDP TX
ring entry. On completion, page-pool buffers go back to page_pool
and UMEM frames go to the AF_XDP completion ring. XDP_TX of provider
RX buffers uses the same records.

Each poll sends at most 64 descriptors per socket, so the
application and NAPI can run at the same time. When a vector has
several sockets, the first one served changes on each poll. The
batch helper does not take a multi-buffer packet that does not fit
the budget left. If a batch was sent and the budget left is smaller
than a maximum-size packet, keep NAPI scheduled.

Socket TX shares the XDP TX ring with XDP_TX. Do socket TX after RX:
XDP_TX drops a frame that does not fit, but a socket descriptor
waits in the socket TX ring.

Advertise AF_XDP zero copy on systems with 4 KiB pages, now that RX
and TX both work.

Signed-off-by: Björn Töpel <bjorn@kernel.org>
---
 .../net/ethernet/meta/fbnic/fbnic_netdev.c    |  30 +++
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.c  | 209 ++++++++++++++++--
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.h  |  18 ++
 3 files changed, 238 insertions(+), 19 deletions(-)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
index 038e91ef14e4..f8495b665d97 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
@@ -666,6 +666,31 @@ static int fbnic_bpf(struct net_device *netdev, struct netdev_bpf *bpf)
 	}
 }
 
+static int fbnic_xsk_wakeup(struct net_device *netdev, u32 queue_id,
+			    u32 __always_unused flags)
+{
+	struct fbnic_net *fbn = netdev_priv(netdev);
+	struct xsk_buff_pool *pool;
+	struct napi_struct *napi;
+
+	if (queue_id >= fbn->num_rx_queues)
+		return -EINVAL;
+	if (!netif_running(netdev))
+		return -ENETDOWN;
+	pool = xsk_get_pool_from_rxq(netdev, queue_id);
+	if (!pool)
+		return -EINVAL;
+
+	napi = __netif_get_rx_queue(netdev, queue_id)->napi;
+	if (WARN_ON_ONCE(!napi))
+		return -EINVAL;
+
+	if (!napi_if_scheduled_mark_missed(napi))
+		napi_schedule(napi);
+
+	return 0;
+}
+
 static const struct net_device_ops fbnic_netdev_ops = {
 	.ndo_open		= fbnic_open,
 	.ndo_stop		= fbnic_stop,
@@ -677,6 +702,7 @@ static const struct net_device_ops fbnic_netdev_ops = {
 	.ndo_set_rx_mode_async	= fbnic_set_rx_mode,
 	.ndo_get_stats64	= fbnic_get_stats64,
 	.ndo_bpf		= fbnic_bpf,
+	.ndo_xsk_wakeup		= fbnic_xsk_wakeup,
 	.ndo_hwtstamp_get	= fbnic_hwtstamp_get,
 	.ndo_hwtstamp_set	= fbnic_hwtstamp_set,
 };
@@ -935,6 +961,10 @@ struct net_device *fbnic_netdev_alloc(struct fbnic_dev *fbd)
 	netdev->xdp_features = NETDEV_XDP_ACT_BASIC |
 			       NETDEV_XDP_ACT_REDIRECT |
 			       NETDEV_XDP_ACT_RX_SG;
+	if (PAGE_SIZE == FBNIC_BD_PAGE_SIZE) {
+		netdev->xdp_features |= NETDEV_XDP_ACT_XSK_ZEROCOPY;
+		netdev->xdp_zc_max_segs = FBNIC_MAX_RX_DATA_DESC;
+	}
 
 	netdev->min_mtu = IPV6_MIN_MTU;
 	netdev->max_mtu = FBNIC_MAX_JUMBO_FRAME_SIZE - ETH_HLEN;
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
index e6043607d4e2..6990a7e0fe2f 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
@@ -42,6 +42,7 @@ struct fbnic_xmit_cb {
 #define FBNIC_XMIT_CB(__skb) ((struct fbnic_xmit_cb *)((__skb)->cb))
 
 #define FBNIC_XMIT_NOUNMAP	((void *)1)
+#define FBNIC_XSK_TX_BUDGET	64
 
 u32 __iomem *fbnic_ring_csr_base(const struct fbnic_ring *ring)
 {
@@ -657,22 +658,79 @@ static void fbnic_clean_twq0(struct fbnic_napi_vector *nv, int napi_budget,
 	}
 }
 
-static void fbnic_clean_twq1(struct fbnic_napi_vector *nv, bool pp_allow_direct,
+struct fbnic_xsk_tx_complete {
+	struct xsk_buff_pool *pool;
+	u32 descs;
+};
+
+enum fbnic_pp_recycle_mode {
+	FBNIC_PP_RECYCLE_DEFERRED,
+	FBNIC_PP_RECYCLE_DIRECT,
+};
+
+static void
+fbnic_xsk_tx_complete_flush(struct fbnic_xsk_tx_complete *complete)
+{
+	if (!complete->descs)
+		return;
+
+	xsk_tx_completed(complete->pool, complete->descs);
+	complete->descs = 0;
+}
+
+static void
+fbnic_xsk_tx_complete_count(struct fbnic_xsk_tx_complete *complete,
+			    struct xsk_buff_pool *pool)
+{
+	if (complete->pool != pool) {
+		fbnic_xsk_tx_complete_flush(complete);
+		complete->pool = pool;
+	}
+
+	complete->descs++;
+}
+
+static void
+fbnic_clean_twq1_buf(struct fbnic_xdp_tx_buf *buf,
+		     struct fbnic_xsk_tx_complete *complete,
+		     enum fbnic_pp_recycle_mode mode)
+{
+	switch (buf->type) {
+	case FBNIC_XDP_TX_BUF_NETMEM:
+		page_pool_put_full_netmem(netmem_get_pp(buf->netmem),
+					  buf->netmem,
+					  mode == FBNIC_PP_RECYCLE_DIRECT);
+		break;
+	case FBNIC_XDP_TX_BUF_XSK:
+		fbnic_xsk_tx_complete_count(complete, buf->xsk_pool);
+		break;
+	default:
+		WARN_ON_ONCE(buf->type != FBNIC_XDP_TX_BUF_NONE);
+		break;
+	}
+
+	buf->netmem = 0;
+	buf->type = FBNIC_XDP_TX_BUF_NONE;
+}
+
+static void fbnic_clean_twq1(struct fbnic_napi_vector *nv,
+			     enum fbnic_pp_recycle_mode mode,
 			     struct fbnic_ring *ring, bool discard,
 			     unsigned int hw_head)
 {
+	struct fbnic_xsk_tx_complete complete = { };
 	u64 total_bytes = 0, total_packets = 0;
 	unsigned int head = ring->head;
 
 	while (hw_head != head) {
-		struct page *page;
+		struct fbnic_xdp_tx_buf *buf;
 		u64 twd;
 
 		if (unlikely(!(ring->desc[head] & FBNIC_TWD_TYPE(AL))))
 			goto next_desc;
 
 		twd = le64_to_cpu(ring->desc[head]);
-		page = ring->tx_buf[head];
+		buf = &ring->xdp_buf[head];
 
 		/* TYPE_AL is 2, TYPE_LAST_AL is 3. So this trick gives
 		 * us one increment per packet, with no branches.
@@ -681,13 +739,14 @@ static void fbnic_clean_twq1(struct fbnic_napi_vector *nv, bool pp_allow_direct,
 				 FBNIC_TWD_TYPE_AL;
 		total_bytes += FIELD_GET(FBNIC_TWD_LEN_MASK, twd);
 
-		page_pool_put_page(pp_page_to_nmdesc(page)->pp, page, -1,
-				   pp_allow_direct);
+		fbnic_clean_twq1_buf(buf, &complete, mode);
 next_desc:
 		head++;
 		head &= ring->size_mask;
 	}
 
+	fbnic_xsk_tx_complete_flush(&complete);
+
 	if (!total_bytes)
 		return;
 
@@ -821,7 +880,8 @@ static void fbnic_clean_twq(struct fbnic_napi_vector *nv, int napi_budget,
 	if (head1 >= 0) {
 		qt->cmpl.deferred_head = -1;
 		if (napi_budget)
-			fbnic_clean_twq1(nv, true, &qt->sub1, false, head1);
+			fbnic_clean_twq1(nv, FBNIC_PP_RECYCLE_DIRECT, &qt->sub1,
+					 false, head1);
 		else
 			qt->cmpl.deferred_head = head1;
 	}
@@ -1203,7 +1263,7 @@ static long fbnic_pkt_tx(struct fbnic_napi_vector *nv,
 	unsigned int tail = ring->tail;
 	struct skb_shared_info *shinfo;
 	skb_frag_t *frag = NULL;
-	struct page *page;
+	netmem_ref netmem;
 	dma_addr_t dma;
 	__le64 *twd;
 
@@ -1221,18 +1281,21 @@ static long fbnic_pkt_tx(struct fbnic_napi_vector *nv,
 		return -FBNIC_XDP_CONSUME;
 	}
 
-	page = virt_to_page(pkt->buff.data_hard_start);
-	offset = offset_in_page(pkt->buff.data);
-	dma = page_pool_get_dma_addr(page);
-
+	netmem = xdp_buff_get_netmem(&pkt->buff);
+	offset = (u8 *)pkt->buff.data -
+		 (u8 *)netmem_address(netmem);
+	dma = page_pool_get_dma_addr_netmem(netmem);
 	size = pkt->buff.data_end - pkt->buff.data;
 
 	while (nsegs--) {
+		struct fbnic_xdp_tx_buf *buf = &ring->xdp_buf[tail];
+
 		dma_sync_single_range_for_device(nv->dev, dma, offset, size,
 						 DMA_BIDIRECTIONAL);
 		dma += offset;
 
-		ring->tx_buf[tail] = page;
+		buf->netmem = netmem;
+		buf->type = FBNIC_XDP_TX_BUF_NETMEM;
 
 		twd = &ring->desc[tail];
 		*twd = cpu_to_le64(FIELD_PREP(FBNIC_TWD_ADDR_MASK, dma) |
@@ -1247,8 +1310,8 @@ static long fbnic_pkt_tx(struct fbnic_napi_vector *nv,
 			break;
 
 		offset = skb_frag_off(frag);
-		page = skb_frag_page(frag);
-		dma = page_pool_get_dma_addr(page);
+		netmem = skb_frag_netmem(frag);
+		dma = page_pool_get_dma_addr_netmem(netmem);
 
 		size = skb_frag_size(frag);
 		data_len -= size;
@@ -1490,6 +1553,102 @@ static int fbnic_clean_rcq(struct fbnic_napi_vector *nv,
 	return complete ? packets : budget;
 }
 
+static bool fbnic_xsk_tx_pool(struct fbnic_ring *ring,
+			      struct xsk_buff_pool *pool)
+{
+	unsigned int budget, tail = ring->tail;
+	struct xdp_desc *descs;
+	bool complete = true;
+	bool need_wakeup;
+	u32 i, count;
+
+	need_wakeup = xsk_uses_need_wakeup(pool);
+	if (need_wakeup && ring->head == ring->tail)
+		xsk_set_tx_need_wakeup(pool);
+
+	budget = min_t(unsigned int, fbnic_desc_unused(ring),
+		       FBNIC_XSK_TX_BUDGET);
+	if (!budget)
+		goto wake;
+
+	count = xsk_tx_peek_release_desc_batch(pool, budget);
+	/* A shared UMEM bind can allocate the array after pool creation. */
+	descs = pool->tx_descs;
+	for (i = 0; i < count; i++) {
+		struct fbnic_xdp_tx_buf *buf = &ring->xdp_buf[tail];
+		struct xdp_desc_ctx ctx;
+		struct xdp_desc *desc;
+		unsigned int type;
+
+		desc = &descs[i];
+		ctx = xsk_buff_raw_get_ctx(pool, desc->addr, desc->options);
+		xsk_buff_raw_dma_sync_for_device(pool, ctx.dma, desc->len);
+
+		buf->xsk_pool = pool;
+		buf->type = FBNIC_XDP_TX_BUF_XSK;
+		type = xsk_is_eop_desc(desc) ? FBNIC_TWD_TYPE_LAST_AL :
+					       FBNIC_TWD_TYPE_AL;
+		ring->desc[tail] =
+			cpu_to_le64(FIELD_PREP(FBNIC_TWD_ADDR_MASK, ctx.dma) |
+				    FIELD_PREP(FBNIC_TWD_LEN_MASK, desc->len) |
+				    FIELD_PREP(FBNIC_TWD_TYPE_MASK, type));
+
+		tail++;
+		tail &= ring->size_mask;
+	}
+
+	if (count)
+		ring->tail = tail;
+	/* The batch helper stops before a partial multi-buffer packet. Keep
+	 * polling if the unused budget was too small for one maximum packet.
+	 */
+	complete = !count || budget - count >= pool->xdp_zc_max_segs;
+
+wake:
+	if (need_wakeup && ring->head != ring->tail)
+		xsk_clear_tx_need_wakeup(pool);
+
+	return complete;
+}
+
+static bool fbnic_xsk_tx(struct fbnic_napi_vector *nv)
+{
+	struct fbnic_ring *ring = &nv->qt[0].sub1;
+	unsigned int tail = ring->tail;
+	unsigned int i, queue;
+	bool complete = true;
+
+	if (!nv->rxt_count)
+		return true;
+
+	queue = nv->xsk_tx_start;
+	do {
+		struct xsk_buff_pool *pool;
+
+		i = nv->txt_count + queue;
+		pool = nv->qt[i].xsk_pool;
+		if (pool)
+			complete &= fbnic_xsk_tx_pool(ring, pool);
+
+		queue++;
+		if (queue == nv->rxt_count)
+			queue = 0;
+	} while (queue != nv->xsk_tx_start);
+
+	nv->xsk_tx_start++;
+	if (nv->xsk_tx_start == nv->rxt_count)
+		nv->xsk_tx_start = 0;
+
+	if (tail != ring->tail) {
+		/* Force DMA writes to flush before writing to tail */
+		dma_wmb();
+
+		writel(ring->tail, ring->doorbell);
+	}
+
+	return complete;
+}
+
 static void fbnic_nv_irq_disable(struct fbnic_napi_vector *nv)
 {
 	struct fbnic_dev *fbd = nv->fbd;
@@ -1512,6 +1671,7 @@ static int fbnic_poll(struct napi_struct *napi, int budget)
 	struct fbnic_napi_vector *nv = container_of(napi,
 						    struct fbnic_napi_vector,
 						    napi);
+	bool xsk_complete = true;
 	int i, j, work_done = 0;
 
 	for (i = 0; i < nv->txt_count; i++)
@@ -1520,7 +1680,14 @@ static int fbnic_poll(struct napi_struct *napi, int budget)
 	for (j = 0; j < nv->rxt_count; j++, i++)
 		work_done += fbnic_clean_rcq(nv, &nv->qt[i], budget);
 
-	if (work_done >= budget)
+	/* XDP_TX shares this ring and drops frames that do not fit, while
+	 * socket TX descriptors wait in the socket's TX ring. Serve XDP_TX
+	 * first.
+	 */
+	if (budget && nv->rxt_count)
+		xsk_complete = fbnic_xsk_tx(nv);
+
+	if (work_done >= budget || !xsk_complete)
 		return budget;
 
 	if (likely(napi_complete_done(napi, work_done)))
@@ -1884,7 +2051,8 @@ static int fbnic_alloc_napi_vector(struct fbnic_dev *fbd, struct fbnic_net *fbn,
 		if (xdp_count > 0) {
 			unsigned int xdp_idx = FBNIC_MAX_TXQS + rxq_idx;
 
-			fbnic_ring_init(&qt->sub1, db, xdp_idx, flags);
+			fbnic_ring_init(&qt->sub1, db, xdp_idx,
+					flags | FBNIC_RING_F_XDP);
 			fbn->tx[xdp_idx] = &qt->sub1;
 			xdp_count--;
 		} else {
@@ -2031,9 +2199,12 @@ static int fbnic_alloc_tx_ring_buffer(struct fbnic_ring *txr)
 {
 	size_t size = array_size(sizeof(*txr->tx_buf), txr->size_mask + 1);
 
-	txr->tx_buf = kvzalloc(size, GFP_KERNEL | __GFP_NOWARN);
+	if (txr->flags & FBNIC_RING_F_XDP)
+		size = array_size(sizeof(*txr->xdp_buf), txr->size_mask + 1);
 
-	return txr->tx_buf ? 0 : -ENOMEM;
+	txr->buffer = kvzalloc(size, GFP_KERNEL | __GFP_NOWARN);
+
+	return txr->buffer ? 0 : -ENOMEM;
 }
 
 static int fbnic_alloc_tx_ring_resources(struct fbnic_net *fbn,
@@ -2602,7 +2773,7 @@ static void fbnic_nv_flush(struct fbnic_napi_vector *nv)
 
 		/* Clean the work queues of unprocessed work */
 		fbnic_clean_twq0(nv, 0, &qt->sub0, true, qt->sub0.tail);
-		fbnic_clean_twq1(nv, false, &qt->sub1, true,
+		fbnic_clean_twq1(nv, FBNIC_PP_RECYCLE_DEFERRED, &qt->sub1, true,
 				 qt->sub1.tail);
 
 		/* Reset completion queue descriptor ring */
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.h b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.h
index abc96a12ea5c..2fcfe6ac0232 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.h
@@ -36,6 +36,7 @@ struct xsk_buff_pool;
  *	+ 4 descriptors for payload
  */
 #define FBNIC_MAX_RX_PKT_DESC	7
+#define FBNIC_MAX_RX_DATA_DESC	(FBNIC_MAX_RX_PKT_DESC - 2)
 #define FBNIC_RX_DESC_MIN	roundup_pow_of_two(FBNIC_MAX_RX_PKT_DESC * 2)
 
 #define FBNIC_MAX_TXQS			128u
@@ -73,6 +74,7 @@ struct xsk_buff_pool;
 #define FBNIC_RING_F_DISABLED		BIT(0)
 #define FBNIC_RING_F_CTX		BIT(1)
 #define FBNIC_RING_F_STATS		BIT(2)	/* Ring's stats may be used */
+#define FBNIC_RING_F_XDP		BIT(3)
 
 #define FBNIC_HDS_THRESH_MAX \
 	(4096 - FBNIC_RX_HROOM - FBNIC_RX_TROOM - FBNIC_RX_PAD)
@@ -121,11 +123,26 @@ struct fbnic_rx_buf {
 	long pagecnt_bias;
 };
 
+enum fbnic_xdp_tx_buf_type {
+	FBNIC_XDP_TX_BUF_NONE	= 0,
+	FBNIC_XDP_TX_BUF_NETMEM,
+	FBNIC_XDP_TX_BUF_XSK,
+};
+
+struct fbnic_xdp_tx_buf {
+	union {
+		struct xsk_buff_pool *xsk_pool;
+		netmem_ref netmem;
+	};
+	u8 type;
+};
+
 struct fbnic_ring {
 	/* Pointer to buffer specific info */
 	union {
 		struct fbnic_pkt_buff *pkt;	/* RCQ */
 		struct fbnic_rx_buf *rx_buf;	/* BDQ */
+		struct fbnic_xdp_tx_buf *xdp_buf; /* TWQ1 */
 		void **tx_buf;			/* TWQ */
 		void *buffer;			/* Generic pointer */
 	};
@@ -179,6 +196,7 @@ struct fbnic_napi_vector {
 	u16 v_idx;
 	u8 txt_count;
 	u8 rxt_count;
+	u8 xsk_tx_start;
 
 	struct fbnic_q_triad qt[];
 };
-- 
2.55.0

