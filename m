Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794306156;
	b=ITPj3NhNPDC3xgiiVNU5p+EdXIVGXUvCPUO3FuimZsdA7w0OxJCV98drANoty5ZV9FHM
	 cEax+DdpEkiQK0tXfhWo9/ixi+FykfIK8iUi4BYtdWCVPp38LwGJxZm6nE5D9muij7B+2
	 qpakiOjLm+hnYMoxnZzdIg2CljrKgf/QUDri0rFcgxbzVCgq/5MyMu2SJGKl/ClsPeNYM
	 4ksaB99O3BnNd5+NcZJtEX5tYy31PdDcRiV5zas35VKDyEreHIzk/fyPkC+dHLxYjd8PZ
	 GkhWlMmIo6Rk8PHiOM++EFC9FIQKShQ+D/VhX1K7WHvyqR85qfsMZjUWuMmbFDaBunw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794306156;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=1e6DVTljXERx8smXNRbNpkbEhVNscjVC5NRjL9uaXAs=;
	b=PGv/IshzlR6m94p7ob36nkVsfA3kdlBdqA+NKgTLu6MPjubI4yvk9q3AM+Bgyv797QcR
	 DyFtMm5re6Q5n+dDYJOeAS4epSNpdlPutQblWvyQI3hP/t65uK6/qAmKaRlT83wX59cWt
	 A2uC72KpyJHTzirlpbomdXAPre3isMsb5Wd1ob2PPd4w2RLuP8dFzK2HMHlhDd1iwvQyy
	 H8RsmDCea9NUCUpMfsJkOfncVu1RTEpay1iwZHsFpeM+MfE+TIpvLXDEiZ4eYM5lXp6j4
	 qMApCzo5jQ1qUEghusWKDSL4Qp8pBZHTIHqgpo64YnW+fQ/FIyoMv0KitE3vSCM5iyQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=R93oryGj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B1F960710E6;
	Tue, 10 Nov 2026 10:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=R93oryGj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBB471F008A1;
	Tue, 10 Nov 2026 10:22:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794306155;
	bh=1e6DVTljXERx8smXNRbNpkbEhVNscjVC5NRjL9uaXAs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=R93oryGj5htl4W8c1CzKYp0IBhutiayu1Ukz6Tc5inNCSBWZ9ZmXPYsDY8f5ptTvd
	 4v1UiTNuA36PQQShTaOBQNEJcgPMitEPS0qqZSHJWYtF330pHUl3+cHqDnS14tknD7
	 5ftX0E+6TaN4TdoLBodAiK0otMTAwhF59P6tC8ETnzVXDGYhVctl6IurTCRU4DJuHa
	 4ucXrVoxGMhl1LteiqenfIjSb02RUhJ8hWK6qUjB2MUyxhwg7usd9KbiGhvCvOlfvs
	 PCdwVp5o84P7eeCdE8x4NbYHbrv/YmWQOf7K7mMZnohpXqLzc4Y74L7aAKMnV3YAr9
	 fqeBnDWJ7GVHQ==
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
	io-uring@vger.kernel.org,
	Mina Almasry <almasrymina@google.com>
Cc: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	"Mike Marciniszyn (Meta)" <mike.marciniszyn@gmail.com>,
	Weiming Shi <bestswngs@gmail.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	David Wei <dw@davidwei.uk>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stuart Clark <stuclar@meta.com>
Subject: [PATCH net-next v1 11/11] eth: fbnic: Support AF_XDP page pool zero copy
Date: Tue, 10 Nov 2026 11:20:32 +0100
Message-ID: <20261110102039.1002605-12-bjorn@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261110102039.1002605-1-bjorn@kernel.org>
References: <20261110102039.1002605-1-bjorn@kernel.org>
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

Header and payload rings share one provider page pool, so refills even
them out, and a short pool does not starve one of them. Payload
buffers start at chunk offset 0, and the UMEM headroom rules require
headroom only in the first buffer. A chunk is one 4 KiB device page,
also with larger kernel pages, so rings fed by the provider post one
descriptor per chunk.

Socket TX shares the XDP TX ring and runs after RX: XDP_TX drops
frames that do not fit, while socket descriptors can wait. The TX
need_wakeup flag stays set, as for ice, since clearing it can miss the
last wakeup.

Signed-off-by: Björn Töpel <bjorn@kernel.org>
---
 Documentation/networking/af_xdp.rst           |  58 +++
 .../net/ethernet/meta/fbnic/fbnic_netdev.c    |  18 +
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.c  | 428 ++++++++++++++----
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.h  |  25 +-
 4 files changed, 446 insertions(+), 83 deletions(-)

diff --git a/Documentation/networking/af_xdp.rst b/Documentation/networking/af_xdp.rst
index e73a0005e169..f152ae8812d1 100644
--- a/Documentation/networking/af_xdp.rst
+++ b/Documentation/networking/af_xdp.rst
@@ -346,6 +346,64 @@ Note that a UMEM can be shared between sockets on the same queue id
 and device, as well as between queues on the same device and between
 devices at the same time.
 
+Zero-copy through page pool
+---------------------------
+
+Some drivers, for example fbnic, receive into the UMEM through a page
+pool memory provider instead of their own allocator. The socket API
+does not change: zero-copy mode is selected as before, and XDP_OPTIONS
+reports it.
+
+The requirements are:
+
+* Aligned chunks of a size the driver supports, 4 KiB for fbnic.
+* The queue id has an RX queue, also for a socket that only transmits.
+  Such a socket needs the FILL and COMPLETION rings, like any other.
+* The driver accepts the headroom, MTU and XDP program. fbnic accepts
+  a UMEM headroom of 0, 128 or 256 bytes. An MTU larger than its header
+  buffer needs XDP_USE_SG, and frags support in an XDP program. The
+  first buffer of a larger frame may hold only its headers, and the
+  other buffers start at offset 0 of their chunk. Such a frame can take
+  one chunk more than in copy mode.
+
+If the device cannot do zero-copy for the socket, a bind with
+XDP_ZEROCOPY fails with EOPNOTSUPP, while a bind without it falls back
+to copy mode. MTU and XDP program changes that a bound socket cannot
+handle are refused.
+
+Binding restarts the RX queue. The queue takes chunks from the FILL
+ring and returns them on the RX ring. A FILL entry for a chunk that
+the RX side still owns is dropped; TX chunks stay with userspace until
+their completion, as before. XDP_PASS copies the packet. Redirects to
+anything but a socket copy single-buffer packets and drop others. A
+redirect to a socket of another queue fails, and generic XDP cannot
+redirect to the socket.
+
+When the queue has no chunks left to post, RX waits for the FILL ring.
+With XDP_USE_NEED_WAKEUP, the flag on the FILL ring stays set, and
+userspace must call poll(), or recvfrom() with an RX ring or sendto()
+with a TX ring, after it posts entries. Without the flag, the queue
+polls the FILL ring, which costs CPU time while the ring is empty.
+Post FILL entries before bind() if possible.
+
+A driver supports this mode when it:
+
+* uses netmem for header buffers and XDP_TX, and handles page pools
+  whose buffers cannot be split (see page_pool_supports_frag()),
+* selects the provider with PP_FLAG_MEM_PROVIDER and pp_rx_role for
+  one page pool of each queue, and honours the rx_headroom queue
+  configuration,
+* calls page_pool_refill_done() after each refill,
+* sends socket TX descriptors from the NAPI of the RX queue, with
+  xsk_tx_peek_release_desc_batch() for the pool that xsk_rxq_pool()
+  returns,
+* advertises NETDEV_XDP_ACT_XSK_ZEROCOPY and xdp_zc_max_segs,
+* checks the setup in XDP_VALIDATE_XSK_POOL, and sets xsk_page_pool
+  in its netdev_queue_mgmt_ops.
+
+The core schedules that NAPI for RX and TX wakeups, so no
+ndo_xsk_wakeup is needed.
+
 XDP_USE_NEED_WAKEUP bind flag
 -----------------------------
 
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
index ae2585508690..8cb5b5b93c70 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
@@ -5,6 +5,7 @@
 #include <linux/ipv6.h>
 #include <linux/types.h>
 #include <net/netdev_queues.h>
+#include <net/xdp_sock_drv.h>
 
 #include "fbnic.h"
 #include "fbnic_netdev.h"
@@ -276,6 +277,7 @@ static int fbnic_set_mac(struct net_device *netdev, void *p)
 static int fbnic_change_mtu(struct net_device *dev, int new_mtu)
 {
 	struct fbnic_net *fbn = netdev_priv(dev);
+	int err;
 
 	if (fbnic_check_split_frames(fbn->xdp_prog, new_mtu, fbn->hds_thresh)) {
 		dev_err(&dev->dev,
@@ -285,6 +287,13 @@ static int fbnic_change_mtu(struct net_device *dev, int new_mtu)
 		return -EINVAL;
 	}
 
+	err = xsk_validate_dev(dev, new_mtu, NULL, XDP_MODE_DRV, NULL);
+	if (err) {
+		dev_err(&dev->dev, "MTU %d does not fit a bound AF_XDP socket\n",
+			new_mtu);
+		return err;
+	}
+
 	WRITE_ONCE(dev->mtu, new_mtu);
 
 	return 0;
@@ -538,6 +547,13 @@ static int fbnic_bpf(struct net_device *netdev, struct netdev_bpf *bpf)
 {
 	struct bpf_prog *prog = bpf->prog, *prev_prog;
 	struct fbnic_net *fbn = netdev_priv(netdev);
+	const struct xsk_rx_check *check;
+
+	if (bpf->command == XDP_VALIDATE_XSK_POOL) {
+		check = bpf->xsk_check.check;
+		prog = check->prog ? : READ_ONCE(fbn->xdp_prog);
+		return fbnic_xsk_validate(check, prog, bpf->xsk_check.extack);
+	}
 
 	if (bpf->command != XDP_SETUP_PROG)
 		return -EINVAL;
@@ -825,6 +841,8 @@ struct net_device *fbnic_netdev_alloc(struct fbnic_dev *fbd)
 	netdev->xdp_features = NETDEV_XDP_ACT_BASIC |
 			       NETDEV_XDP_ACT_REDIRECT |
 			       NETDEV_XDP_ACT_RX_SG;
+	netdev->xdp_features |= NETDEV_XDP_ACT_XSK_ZEROCOPY;
+	netdev->xdp_zc_max_segs = FBNIC_MAX_RX_BUFS;
 
 	netdev->min_mtu = IPV6_MIN_MTU;
 	netdev->max_mtu = FBNIC_MAX_JUMBO_FRAME_SIZE - ETH_HLEN;
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
index d96c957d6fba..c358003f053b 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
@@ -12,6 +12,7 @@
 #include <net/page_pool/helpers.h>
 #include <net/tcp.h>
 #include <net/xdp.h>
+#include <net/xdp_sock_drv.h>
 
 #include "fbnic.h"
 #include "fbnic_csr.h"
@@ -43,6 +44,8 @@ struct fbnic_xmit_cb {
 
 #define FBNIC_XMIT_NOUNMAP	((void *)1)
 
+#define FBNIC_XSK_TX_BUDGET	64
+
 u32 __iomem *fbnic_ring_csr_base(const struct fbnic_ring *ring)
 {
 	unsigned long csr_base = (unsigned long)ring->doorbell;
@@ -657,22 +660,45 @@ static void fbnic_clean_twq0(struct fbnic_napi_vector *nv, int napi_budget,
 	}
 }
 
+struct fbnic_xsk_done {
+	struct xsk_buff_pool *pool;
+	u32 descs;
+};
+
+static void fbnic_xsk_done_flush(struct fbnic_xsk_done *done)
+{
+	if (done->descs)
+		xsk_tx_completed(done->pool, done->descs);
+	done->descs = 0;
+}
+
+static void fbnic_xsk_done_add(struct fbnic_xsk_done *done,
+			       struct xsk_buff_pool *pool)
+{
+	if (done->pool != pool) {
+		fbnic_xsk_done_flush(done);
+		done->pool = pool;
+	}
+	done->descs++;
+}
+
 static void fbnic_clean_twq1(struct fbnic_napi_vector *nv, bool pp_allow_direct,
 			     struct fbnic_ring *ring, bool discard,
 			     unsigned int hw_head)
 {
 	u64 total_bytes = 0, total_packets = 0;
+	struct fbnic_xsk_done done = {};
 	unsigned int head = ring->head;
 
 	while (hw_head != head) {
-		netmem_ref netmem;
+		struct fbnic_xdp_tx_buf *buf;
 		u64 twd;
 
 		if (unlikely(!(ring->desc[head] & FBNIC_TWD_TYPE(AL))))
 			goto next_desc;
 
 		twd = le64_to_cpu(ring->desc[head]);
-		netmem = ring->tx_netmem[head];
+		buf = &ring->xdp_buf[head];
 
 		/* TYPE_AL is 2, TYPE_LAST_AL is 3. So this trick gives
 		 * us one increment per packet, with no branches.
@@ -681,13 +707,18 @@ static void fbnic_clean_twq1(struct fbnic_napi_vector *nv, bool pp_allow_direct,
 				 FBNIC_TWD_TYPE_AL;
 		total_bytes += FIELD_GET(FBNIC_TWD_LEN_MASK, twd);
 
-		page_pool_put_netmem(netmem_get_pp(netmem), netmem, -1,
-				     pp_allow_direct);
+		if (buf->xsk)
+			fbnic_xsk_done_add(&done, buf->xsk);
+		else
+			page_pool_put_netmem(netmem_get_pp(buf->netmem),
+					     buf->netmem, -1, pp_allow_direct);
 next_desc:
 		head++;
 		head &= ring->size_mask;
 	}
 
+	fbnic_xsk_done_flush(&done);
+
 	if (!total_bytes)
 		return;
 
@@ -938,66 +969,146 @@ static void fbnic_bd_prep(struct fbnic_ring *bdq, u16 id, netmem_ref netmem)
 	} while (--i);
 }
 
+static bool fbnic_fill_bdq_one(struct fbnic_ring *bdq, unsigned int *tail)
+{
+	netmem_ref netmem;
+
+	netmem = page_pool_dev_alloc_netmems(bdq->page_pool);
+	if (!netmem) {
+		u64_stats_update_begin(&bdq->stats.syncp);
+		bdq->stats.bdq.alloc_failed++;
+		u64_stats_update_end(&bdq->stats.syncp);
+
+		return false;
+	}
+
+	fbnic_page_pool_init(bdq, *tail, netmem);
+	fbnic_bd_prep(bdq, *tail, netmem);
+
+	*tail = (*tail + 1) & bdq->size_mask;
+	return true;
+}
+
+static void fbnic_fill_bdq_done(struct fbnic_ring *bdq, unsigned int tail)
+{
+	if (bdq->tail == tail)
+		return;
+
+	bdq->tail = tail;
+
+	/* Force DMA writes to flush before writing to tail */
+	dma_wmb();
+
+	writel(tail * fbnic_bd_page_count(bdq), bdq->doorbell);
+}
+
+static enum pp_refill fbnic_bdq_state(struct fbnic_ring *bdq)
+{
+	return fbnic_desc_unused(bdq) ? PP_REFILL_PARTIAL : PP_REFILL_FULL;
+}
+
 static void fbnic_fill_bdq(struct fbnic_ring *bdq)
 {
 	unsigned int count = fbnic_desc_unused(bdq);
-	unsigned int i = bdq->tail;
+	unsigned int tail = bdq->tail;
 
-	if (!count)
-		return;
+	while (count-- && fbnic_fill_bdq_one(bdq, &tail))
+		;
 
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
-	}
+	fbnic_fill_bdq_done(bdq, tail);
 }
 
-static unsigned int fbnic_hdr_pg_start(unsigned int pg_off)
+/* Buffers each ring of a shared page pool gets first */
+#define FBNIC_SHARED_BDQ_MIN	NAPI_POLL_WEIGHT
+
+/* Until both rings hold FBNIC_SHARED_BDQ_MIN buffers, the one with fewer
+ * gets the next buffer. Then the one with the smaller share of its capacity
+ * posted does, so a ring that uses more buffers gets more.
+ */
+static bool fbnic_hpq_takes_next(const struct fbnic_ring *hpq,
+				 unsigned int hpq_cnt,
+				 const struct fbnic_ring *ppq,
+				 unsigned int ppq_cnt)
 {
-	/* The headroom of the first header may be larger than FBNIC_RX_HROOM
+	u64 hpq_posted = hpq->size_mask - hpq_cnt;
+	u64 ppq_posted = ppq->size_mask - ppq_cnt;
+
+	if (!hpq_cnt)
+		return false;
+	if (!ppq_cnt)
+		return true;
+	if (min(hpq_posted, ppq_posted) < FBNIC_SHARED_BDQ_MIN)
+		return hpq_posted <= ppq_posted;
+
+	return hpq_posted * ppq->size_mask <= ppq_posted * hpq->size_mask;
+}
+
+static void fbnic_fill_shared_bdqs(struct fbnic_ring *hpq,
+				   struct fbnic_ring *ppq)
+{
+	unsigned int hpq_cnt = fbnic_desc_unused(hpq);
+	unsigned int ppq_cnt = fbnic_desc_unused(ppq);
+	unsigned int hpq_tail = hpq->tail;
+	unsigned int ppq_tail = ppq->tail;
+	bool more = true;
+
+	while (more && (hpq_cnt || ppq_cnt)) {
+		if (fbnic_hpq_takes_next(hpq, hpq_cnt, ppq, ppq_cnt)) {
+			more = fbnic_fill_bdq_one(hpq, &hpq_tail);
+			hpq_cnt -= more;
+		} else {
+			more = fbnic_fill_bdq_one(ppq, &ppq_tail);
+			ppq_cnt -= more;
+		}
+	}
+
+	fbnic_fill_bdq_done(hpq, hpq_tail);
+	fbnic_fill_bdq_done(ppq, ppq_tail);
+}
+
+static bool fbnic_fill_bdqs(struct fbnic_q_triad *qt)
+{
+	struct fbnic_ring *hpq = &qt->sub0, *ppq = &qt->sub1;
+	enum pp_refill state;
+	bool done;
+
+	if (hpq->page_pool == ppq->page_pool) {
+		fbnic_fill_shared_bdqs(hpq, ppq);
+		state = fbnic_bdq_state(hpq);
+		if (state == PP_REFILL_FULL)
+			state = fbnic_bdq_state(ppq);
+		return page_pool_refill_done(hpq->page_pool, state);
+	}
+
+	fbnic_fill_bdq(hpq);
+	fbnic_fill_bdq(ppq);
+	done = page_pool_refill_done(hpq->page_pool, fbnic_bdq_state(hpq));
+	done &= page_pool_refill_done(ppq->page_pool, fbnic_bdq_state(ppq));
+	return done;
+}
+
+static unsigned int fbnic_hdr_pg_start(const struct fbnic_q_triad *qt,
+				       unsigned int pg_off)
+{
+	/* The headroom of the first header may be larger than rx_hroom
 	 * due to alignment. So account for that by just making the page
 	 * offset 0 if we are starting at the first header.
 	 */
-	if (ALIGN(FBNIC_RX_HROOM, 128) > FBNIC_RX_HROOM &&
-	    pg_off == ALIGN(FBNIC_RX_HROOM, 128))
+	if (pg_off == qt->rx_hdr_first)
 		return 0;
 
-	return pg_off - FBNIC_RX_HROOM;
+	return pg_off - qt->rx_hroom;
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
+	return ALIGN(pg_off, 128) - hroom;
 }
 
 /* A buffer that cannot be split has one reference and takes one descriptor */
@@ -1043,8 +1154,11 @@ static void fbnic_pkt_prepare(struct fbnic_napi_vector *nv, u64 rcd,
 
 	/* Short-cut the end calculation if we know page is fully consumed */
 	hdr_pg_end = FIELD_GET(FBNIC_RCD_AL_PAGE_FIN, rcd) ?
-		     FBNIC_BD_PAGE_SIZE : fbnic_hdr_pg_end(hdr_pg_off, len);
-	hdr_pg_start = fbnic_hdr_pg_start(hdr_pg_off);
+		     FBNIC_BD_PAGE_SIZE :
+		     fbnic_hdr_pg_end(hdr_pg_off, len, qt->rx_hroom);
+	hdr_pg_start = fbnic_hdr_pg_start(qt, hdr_pg_off);
+	/* The frame starts after the UMEM headroom */
+	hdr_pg_start += qt->rx_frame_off;
 
 	headroom = hdr_pg_off - hdr_pg_start + FBNIC_RX_PAD;
 	frame_sz = hdr_pg_end - hdr_pg_start;
@@ -1189,7 +1303,8 @@ static long fbnic_pkt_tx(struct fbnic_napi_vector *nv,
 						 DMA_BIDIRECTIONAL);
 		dma += offset;
 
-		ring->tx_netmem[tail] = netmem;
+		ring->xdp_buf[tail].netmem = netmem;
+		ring->xdp_buf[tail].xsk = NULL;
 
 		twd = &ring->desc[tail];
 		*twd = cpu_to_le64(FIELD_PREP(FBNIC_TWD_ADDR_MASK, dma) |
@@ -1327,6 +1442,7 @@ static int fbnic_clean_rcq(struct fbnic_napi_vector *nv,
 	__le64 *raw_rcd, done;
 	bool redirect = false;
 	u32 head = rcq->head;
+	bool filled;
 
 	done = (head & (rcq->size_mask + 1)) ? cpu_to_le64(FBNIC_RCD_DONE) : 0;
 	raw_rcd = &rcq->desc[head & rcq->size_mask];
@@ -1439,11 +1555,10 @@ static int fbnic_clean_rcq(struct fbnic_napi_vector *nv,
 	/* Unmap and free processed buffers */
 	if (head0 >= 0)
 		fbnic_clean_bdq(&qt->sub0, head0, budget);
-	fbnic_fill_bdq(&qt->sub0);
-
 	if (head1 >= 0)
 		fbnic_clean_bdq(&qt->sub1, head1, budget);
-	fbnic_fill_bdq(&qt->sub1);
+	/* Netpoll has no budget and receives nothing */
+	filled = !budget || fbnic_fill_bdqs(qt);
 
 	/* Record the current head/tail of the queue */
 	if (rcq->head != head) {
@@ -1451,7 +1566,8 @@ static int fbnic_clean_rcq(struct fbnic_napi_vector *nv,
 		writel(head & rcq->size_mask, rcq->doorbell);
 	}
 
-	return packets;
+	/* A full budget polls again, to retry the refill */
+	return filled ? packets : budget;
 }
 
 static void fbnic_nv_irq_disable(struct fbnic_napi_vector *nv)
@@ -1471,6 +1587,75 @@ static void fbnic_nv_irq_rearm(struct fbnic_napi_vector *nv)
 		   FBNIC_INTR_CQ_REARM_INTR_UNMASK);
 }
 
+static bool fbnic_xsk_tx_pool(struct fbnic_ring *ring,
+			      struct xsk_buff_pool *pool)
+{
+	unsigned int budget, tail = ring->tail;
+	struct xdp_desc *desc;
+	u32 i, count = 0;
+	dma_addr_t dma;
+	u64 type;
+
+	/* As for ice: a flag cleared with descriptors in flight can miss one */
+	if (xsk_uses_need_wakeup(pool))
+		xsk_set_tx_need_wakeup(pool);
+
+	budget = min(fbnic_desc_unused(ring), FBNIC_XSK_TX_BUDGET);
+	if (budget)
+		count = xsk_tx_peek_release_desc_batch(pool, budget);
+
+	for (i = 0; i < count; i++) {
+		desc = &pool->tx_descs[i];
+		dma = xsk_buff_raw_get_dma(pool, desc->addr);
+		xsk_buff_raw_dma_sync_for_device(pool, dma, desc->len);
+
+		ring->xdp_buf[tail].netmem = 0;
+		ring->xdp_buf[tail].xsk = pool;
+
+		type = xsk_is_eop_desc(desc) ? FBNIC_TWD_TYPE_LAST_AL :
+					       FBNIC_TWD_TYPE_AL;
+		ring->desc[tail] =
+			cpu_to_le64(FIELD_PREP(FBNIC_TWD_ADDR_MASK, dma) |
+				    FIELD_PREP(FBNIC_TWD_LEN_MASK, desc->len) |
+				    FIELD_PREP(FBNIC_TWD_TYPE_MASK, type));
+
+		tail++;
+		tail &= ring->size_mask;
+	}
+	ring->tail = tail;
+
+	/* The batch stops before a packet that does not fit the budget */
+	return !count || budget - count >= pool->xdp_zc_max_segs;
+}
+
+/* After RX: XDP_TX drops frames that do not fit, socket descriptors wait */
+static bool fbnic_xsk_tx(struct fbnic_napi_vector *nv)
+{
+	struct fbnic_ring *ring = &nv->qt[0].sub1;
+	unsigned int tail = ring->tail;
+	struct xsk_buff_pool *pool;
+	unsigned int i, t;
+	bool done = true;
+
+	for (i = 0; i < nv->rxt_count; i++) {
+		t = (nv->xsk_tx_next + i) % nv->rxt_count;
+		pool = nv->qt[nv->txt_count + t].xsk_pool;
+		if (pool && !fbnic_xsk_tx_pool(ring, pool))
+			done = false;
+	}
+	if (nv->rxt_count)
+		nv->xsk_tx_next = (nv->xsk_tx_next + 1) % nv->rxt_count;
+
+	if (tail != ring->tail) {
+		/* Force DMA writes to flush before writing to tail */
+		dma_wmb();
+
+		writel(ring->tail, ring->doorbell);
+	}
+
+	return done;
+}
+
 static int fbnic_poll(struct napi_struct *napi, int budget)
 {
 	struct fbnic_napi_vector *nv = container_of(napi,
@@ -1484,6 +1669,9 @@ static int fbnic_poll(struct napi_struct *napi, int budget)
 	for (j = 0; j < nv->rxt_count; j++, i++)
 		work_done += fbnic_clean_rcq(nv, &nv->qt[i], budget);
 
+	if (budget && !fbnic_xsk_tx(nv))
+		work_done = budget;
+
 	if (work_done >= budget)
 		return budget;
 
@@ -1650,6 +1838,16 @@ void fbnic_free_napi_vectors(struct fbnic_net *fbn)
 			fbnic_free_napi_vector(fbn, fbn->napi[i]);
 }
 
+static u8 fbnic_bdq_page_shift(u32 page_size)
+{
+	return ilog2(page_size / FBNIC_BD_PAGE_SIZE);
+}
+
+static void fbnic_bdq_set_page_size(struct fbnic_ring *bdq, u32 page_size)
+{
+	bdq->bd_page_shift = fbnic_bdq_page_shift(page_size);
+}
+
 /* No second header fits behind the first in a whole buffer */
 static u32 fbnic_whole_hdr_max(u32 hroom)
 {
@@ -1657,10 +1855,39 @@ static u32 fbnic_whole_hdr_max(u32 hroom)
 	       FBNIC_RX_TROOM - FBNIC_RX_PAD;
 }
 
+int fbnic_xsk_validate(const struct xsk_rx_check *check,
+		       struct bpf_prog *prog, struct netlink_ext_ack *extack)
+{
+	if (check->buf_size != FBNIC_BD_PAGE_SIZE) {
+		NL_SET_ERR_MSG_MOD(extack, "AF_XDP chunks must be 4 KiB");
+		return -EOPNOTSUPP;
+	}
+	if (check->headroom > FBNIC_RX_HROOM_MAX ||
+	    !IS_ALIGNED(check->headroom, FBNIC_RX_HDR_ALIGN)) {
+		NL_SET_ERR_MSG_MOD(extack, "AF_XDP headroom is not supported");
+		return -EOPNOTSUPP;
+	}
+
+	/* Frames of the MTU, with two VLAN tags, fit one header buffer */
+	if (check->mtu + ETH_HLEN + 2 * VLAN_HLEN <=
+	    fbnic_whole_hdr_max(check->headroom))
+		return 0;
+
+	if (!check->sg || (prog && !prog->aux->xdp_has_frags)) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "MTU needs XDP_USE_SG, and frags in an XDP program");
+		return -EOPNOTSUPP;
+	}
+
+	return 0;
+}
+
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
@@ -1674,8 +1901,29 @@ fbnic_alloc_qt_page_pools(struct fbnic_net *fbn, struct fbnic_q_triad *qt,
 		.netdev	= fbn->netdev,
 		.queue_idx = rxq_idx,
 	};
+	struct xsk_buff_pool *xsk;
 	struct page_pool *pp;
 
+	qt->rx_hroom = FBNIC_RX_HROOM;
+	qt->rx_frame_off = 0;
+	if (qcfg->rx_headroom) {
+		qt->rx_hroom = qcfg->rx_headroom;
+		qt->rx_frame_off = qcfg->rx_headroom - XDP_PACKET_HEADROOM;
+	}
+	qt->rx_hdr_first = ALIGN(qt->rx_hroom, FBNIC_RX_HDR_ALIGN);
+
+	/* Payload buffers come from UMEM only for multi-buffer sockets */
+	xsk = xsk_rxq_pool(fbn->netdev, rxq_idx);
+	qt->xsk_pool = xsk;
+	if (xsk) {
+		pp_params.flags |= PP_FLAG_MEM_PROVIDER;
+		pp_params.rx_roles = PP_RX_ROLE_HEAD;
+		/* A chunk can be smaller than a page */
+		pp_params.max_len = rx_page_size;
+		if (xsk_pool_uses_sg(xsk))
+			pp_params.rx_roles |= PP_RX_ROLE_PAYLOAD;
+	}
+
 	/* Page pool cannot exceed a size of 32768. This doesn't limit the
 	 * pages on the ring but the number we can have cached waiting on
 	 * the next use.
@@ -1693,15 +1941,25 @@ fbnic_alloc_qt_page_pools(struct fbnic_net *fbn, struct fbnic_q_triad *qt,
 		return PTR_ERR(pp);
 
 	qt->sub0.page_pool = pp;
+	fbnic_bdq_set_page_size(&qt->sub0, xsk ? rx_page_size : PAGE_SIZE);
 	qt->hdr_max = 0;
 	if (!page_pool_supports_frag(pp))
-		qt->hdr_max = fbnic_whole_hdr_max(FBNIC_RX_HROOM);
+		qt->hdr_max = fbnic_whole_hdr_max(qt->rx_hroom);
 	if (netif_rxq_has_unreadable_mp(fbn->netdev, rxq_idx)) {
 		pp_params.order = get_order(rx_page_size);
 		pp_params.max_len = rx_page_size;
 		pp_params.flags |= PP_FLAG_ALLOW_UNREADABLE_NETMEM;
 		pp_params.dma_dir = DMA_FROM_DEVICE;
 
+		pp = page_pool_create(&pp_params);
+		if (IS_ERR(pp))
+			goto err_destroy_sub0;
+	} else if (xsk && !xsk_pool_uses_sg(xsk)) {
+		pp_params.flags &= ~PP_FLAG_MEM_PROVIDER;
+		pp_params.rx_roles = 0;
+		pp_params.max_len = PAGE_SIZE;
+		rx_page_size = PAGE_SIZE;
+
 		pp = page_pool_create(&pp_params);
 		if (IS_ERR(pp))
 			goto err_destroy_sub0;
@@ -1709,6 +1967,7 @@ fbnic_alloc_qt_page_pools(struct fbnic_net *fbn, struct fbnic_q_triad *qt,
 		page_pool_get(pp);
 	}
 	qt->sub1.page_pool = pp;
+	fbnic_bdq_set_page_size(&qt->sub1, rx_page_size);
 
 	return 0;
 
@@ -1717,16 +1976,6 @@ fbnic_alloc_qt_page_pools(struct fbnic_net *fbn, struct fbnic_q_triad *qt,
 	return PTR_ERR(pp);
 }
 
-static u8 fbnic_bdq_page_shift(u32 page_size)
-{
-	return ilog2(page_size / FBNIC_BD_PAGE_SIZE);
-}
-
-static void fbnic_bdq_set_page_size(struct fbnic_ring *bdq, u32 page_size)
-{
-	bdq->bd_page_shift = fbnic_bdq_page_shift(page_size);
-}
-
 static void fbnic_ring_init(struct fbnic_ring *ring, u32 __iomem *doorbell,
 			    int q_idx, u8 flags)
 {
@@ -1830,7 +2079,8 @@ static int fbnic_alloc_napi_vector(struct fbnic_dev *fbd, struct fbnic_net *fbn,
 		if (xdp_count > 0) {
 			unsigned int xdp_idx = FBNIC_MAX_TXQS + rxq_idx;
 
-			fbnic_ring_init(&qt->sub1, db, xdp_idx, flags);
+			fbnic_ring_init(&qt->sub1, db, xdp_idx,
+					flags | FBNIC_RING_F_XDP);
 			fbn->tx[xdp_idx] = &qt->sub1;
 			xdp_count--;
 		} else {
@@ -1977,6 +2227,9 @@ static int fbnic_alloc_tx_ring_buffer(struct fbnic_ring *txr)
 {
 	size_t size = array_size(sizeof(*txr->tx_buf), txr->size_mask + 1);
 
+	if (txr->flags & FBNIC_RING_F_XDP)
+		size = array_size(sizeof(*txr->xdp_buf), txr->size_mask + 1);
+
 	txr->tx_buf = kvzalloc(size, GFP_KERNEL | __GFP_NOWARN);
 
 	return txr->tx_buf ? 0 : -ENOMEM;
@@ -2126,20 +2379,19 @@ static int fbnic_alloc_tx_qt_resources(struct fbnic_net *fbn,
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
-
 	err = xdp_rxq_info_reg(&qt->xdp_rxq, fbn->netdev, qt->cmpl.q_idx,
 			       nv->napi.napi_id);
 	if (err)
@@ -2203,8 +2455,7 @@ static int fbnic_alloc_nv_resources(struct fbnic_net *fbn,
 		struct netdev_queue_config qcfg;
 
 		netdev_queue_config(fbn->netdev, nv->qt[i].cmpl.q_idx, &qcfg);
-		err = fbnic_alloc_rx_qt_resources(fbn, nv, &nv->qt[i],
-						  qcfg.rx_page_size);
+		err = fbnic_alloc_rx_qt_resources(fbn, nv, &nv->qt[i], &qcfg);
 		if (err)
 			goto free_qt_resources;
 	}
@@ -2598,9 +2849,8 @@ static void fbnic_nv_fill(struct fbnic_napi_vector *nv)
 	for (j = 0, t = nv->txt_count; j < nv->rxt_count; j++, t++) {
 		struct fbnic_q_triad *qt = &nv->qt[t];
 
-		/* Populate the header and payload BDQs */
-		fbnic_fill_bdq(&qt->sub0);
-		fbnic_fill_bdq(&qt->sub1);
+		/* Populate the header and payload BDQs; NAPI retries */
+		fbnic_fill_bdqs(qt);
 	}
 }
 
@@ -2736,14 +2986,20 @@ static void fbnic_config_drop_mode_rcq(struct fbnic_napi_vector *nv,
 				       struct fbnic_ring *rcq, bool tx_pause,
 				       bool hdr_split)
 {
+	struct fbnic_q_triad *qt = container_of_const(rcq, struct fbnic_q_triad,
+						     cmpl);
 	struct fbnic_net *fbn = netdev_priv(nv->napi.dev);
-	u32 drop_mode, rcq_ctl;
+	u32 drop_mode, hroom, rcq_ctl;
+
+	/* The device aligns the maximum value up to FBNIC_RX_HROOM_MAX. */
+	hroom = min_t(u32, qt->rx_hroom,
+		      FIELD_MAX(FBNIC_QUEUE_RDE_CTL0_MIN_HROOM_MASK));
 
 	drop_mode = fbnic_drop_mode(fbn, tx_pause);
 
 	/* Specify packet layout */
 	rcq_ctl = FIELD_PREP(FBNIC_QUEUE_RDE_CTL0_DROP_MODE_MASK, drop_mode) |
-	    FIELD_PREP(FBNIC_QUEUE_RDE_CTL0_MIN_HROOM_MASK, FBNIC_RX_HROOM) |
+	    FIELD_PREP(FBNIC_QUEUE_RDE_CTL0_MIN_HROOM_MASK, hroom) |
 	    FIELD_PREP(FBNIC_QUEUE_RDE_CTL0_MIN_TROOM_MASK, FBNIC_RX_TROOM) |
 	    FIELD_PREP(FBNIC_QUEUE_RDE_CTL0_EN_HDR_SPLIT, hdr_split);
 
@@ -3028,8 +3284,7 @@ static int fbnic_queue_mem_alloc(struct net_device *dev,
 	struct fbnic_napi_vector *nv;
 
 	if (!netif_running(dev))
-		return fbnic_alloc_qt_page_pools(fbn, qt, idx,
-						 qcfg->rx_page_size);
+		return fbnic_alloc_qt_page_pools(fbn, qt, idx, qcfg);
 
 	/* A failed PCIe recovery or resume can leave the datapath torn down
 	 * while netif_running() is still true.  This ndo runs before
@@ -3049,7 +3304,7 @@ static int fbnic_queue_mem_alloc(struct net_device *dev,
 	fbnic_ring_init(&qt->cmpl, real->cmpl.doorbell, real->cmpl.q_idx,
 			real->cmpl.flags);
 
-	return fbnic_alloc_rx_qt_resources(fbn, nv, qt, qcfg->rx_page_size);
+	return fbnic_alloc_rx_qt_resources(fbn, nv, qt, qcfg);
 }
 
 static void fbnic_default_qcfg(struct net_device *dev,
@@ -3086,6 +3341,14 @@ static int fbnic_validate_qcfg(struct net_device *dev,
 		return -EINVAL;
 	}
 
+	if (qcfg->rx_headroom &&
+	    (qcfg->rx_headroom < XDP_PACKET_HEADROOM ||
+	     qcfg->rx_headroom > FBNIC_RX_HROOM_MAX ||
+	     !IS_ALIGNED(qcfg->rx_headroom, FBNIC_RX_HDR_ALIGN))) {
+		NL_SET_ERR_MSG_MOD(extack, "rx_headroom is not supported");
+		return -EINVAL;
+	}
+
 	/* Payload fragments occupy multiples of FBNIC_RX_PAYLD_ALIGN bytes.
 	 * Keep at least one reference in the bias until fbnic_clean_bdq()
 	 * observes a completion from a subsequent allocation.
@@ -3216,5 +3479,6 @@ const struct netdev_queue_mgmt_ops fbnic_queue_mgmt_ops = {
 	.ndo_queue_stop		= fbnic_queue_stop,
 	.ndo_default_qcfg	= fbnic_default_qcfg,
 	.ndo_validate_qcfg	= fbnic_validate_qcfg,
-	.supported_params	= QCFG_RX_PAGE_SIZE,
+	.supported_params	= QCFG_RX_PAGE_SIZE | QCFG_RX_HEADROOM,
+	.xsk_page_pool		= true,
 };
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.h b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.h
index 3077d9bbd587..b4baaa914585 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.h
@@ -14,7 +14,11 @@
 
 #include "fbnic_csr.h"
 
+struct bpf_prog;
 struct fbnic_net;
+struct netlink_ext_ack;
+struct xsk_buff_pool;
+struct xsk_rx_check;
 
 /* Guarantee we have space needed for storing the buffer
  * To store the buffer we need:
@@ -36,6 +40,8 @@ struct fbnic_net;
  */
 #define FBNIC_MAX_RX_PKT_DESC	7
 #define FBNIC_RX_DESC_MIN	roundup_pow_of_two(FBNIC_MAX_RX_PKT_DESC * 2)
+/* All descriptors of a packet but the two metadata ones */
+#define FBNIC_MAX_RX_BUFS	(FBNIC_MAX_RX_PKT_DESC - 2)
 
 #define FBNIC_MAX_TXQS			128u
 #define FBNIC_MAX_RXQS			128u
@@ -66,6 +72,9 @@ struct fbnic_net;
 	(ALIGN(FBNIC_RX_TROOM + FBNIC_RX_HROOM_PAD, 128) - FBNIC_RX_TROOM)
 #define FBNIC_RX_PAD			0
 #define FBNIC_RX_HDR_ALIGN		128
+#define FBNIC_RX_HROOM_MAX \
+	ALIGN(FIELD_MAX(FBNIC_QUEUE_RDE_CTL0_MIN_HROOM_MASK), \
+	      FBNIC_RX_HDR_ALIGN)
 #define FBNIC_RX_PAYLD_ALIGN		128
 #define FBNIC_RX_PAYLD_OFFSET		0
 #define FBNIC_RX_PAYLD_PG_CL		0
@@ -73,6 +82,7 @@ struct fbnic_net;
 #define FBNIC_RING_F_DISABLED		BIT(0)
 #define FBNIC_RING_F_CTX		BIT(1)
 #define FBNIC_RING_F_STATS		BIT(2)	/* Ring's stats may be used */
+#define FBNIC_RING_F_XDP		BIT(3)	/* XDP TX ring */
 
 #define FBNIC_HDS_THRESH_MAX \
 	(4096 - FBNIC_RX_HROOM - FBNIC_RX_TROOM - FBNIC_RX_PAD)
@@ -121,12 +131,18 @@ struct fbnic_rx_buf {
 	long pagecnt_bias;
 };
 
+/* XDP TX ring entry: an XDP_TX buffer, or an AF_XDP TX descriptor */
+struct fbnic_xdp_tx_buf {
+	netmem_ref netmem;
+	struct xsk_buff_pool *xsk;
+};
+
 struct fbnic_ring {
 	/* Pointer to buffer specific info */
 	union {
 		struct fbnic_pkt_buff *pkt;	/* RCQ */
 		struct fbnic_rx_buf *rx_buf;	/* BDQ */
-		netmem_ref *tx_netmem;		/* TWQ1 */
+		struct fbnic_xdp_tx_buf *xdp_buf; /* TWQ1 */
 		void **tx_buf;			/* TWQ */
 		void *buffer;			/* Generic pointer */
 	};
@@ -167,6 +183,10 @@ struct fbnic_q_triad {
 	struct fbnic_ring sub0, sub1, cmpl;
 	struct xdp_rxq_info xdp_rxq;
 	u16 hdr_max;	/* Header bytes for whole header buffers, or 0 */
+	u16 rx_hroom;	/* Headroom before a header */
+	u16 rx_hdr_first; /* Offset of the first header in a buffer */
+	u16 rx_frame_off; /* Offset of the frame in a header buffer */
+	struct xsk_buff_pool *xsk_pool;	/* AF_XDP pool of an RX queue */
 };
 
 struct fbnic_napi_vector {
@@ -178,6 +198,7 @@ struct fbnic_napi_vector {
 	u16 v_idx;
 	u8 txt_count;
 	u8 rxt_count;
+	u8 xsk_tx_next;		/* RX queue that sends socket TX first */
 
 	struct fbnic_q_triad qt[];
 };
@@ -203,6 +224,8 @@ void fbnic_aggregate_ring_tx_counters(struct fbnic_net *fbn,
 void fbnic_aggregate_ring_xdp_counters(struct fbnic_net *fbn,
 				       struct fbnic_ring *xdpr);
 
+int fbnic_xsk_validate(const struct xsk_rx_check *check,
+		       struct bpf_prog *prog, struct netlink_ext_ack *extack);
 int fbnic_alloc_napi_vectors(struct fbnic_net *fbn);
 void fbnic_free_napi_vectors(struct fbnic_net *fbn);
 int fbnic_alloc_resources(struct fbnic_net *fbn);
-- 
2.56.0

