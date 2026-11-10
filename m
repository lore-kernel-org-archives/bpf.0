Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794306117;
	b=c5poWv1q0qyge9ZKC2j2YYAz7gO0mognrC6LuzYA/ITp/LGD0od7d3wNIoP/s9smg9f2
	 SdErgqLixwFT9s23/pSpRcCH7q1X9Jj2jhpoWKnhpoZorESI5utjNUWeSQkotfwvLL9je
	 1NwFxJTedfShVQQ58yAjNpmlvodInWlfH11R04bjGoM4YnUdJbM+S0mo8rAJpN99yNj7B
	 8Wbf84kS6sK+5rBk6gF1zxlo+aBwyP/dvik2NxWusN0+MhWPQWxM+0i0Hgoib7BZELJ83
	 PQ2Ofvc6eXlZlTzE70m7VkhiCBQIF4b6TjaeOIUrnmY+OF1Nz+DlOAmQ1OqTnYVrc+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794306117;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=G5gbx2f9v0sLZlMcF2z3zyvFJHQx55cXMBAXIFVMQfs=;
	b=wX2GyZZG/KuaY+gvTISoXYNosMp3pdbeWQKRczeYga3pRhBGYziZzmi1Viyo9ijrZ6QG
	 bxu+WVi/oN7qxIB4IbyySY9W5dJDB1Ce7btlfK9VrL/ciUdWB7NQCjB+fBdRfULBi65Yq
	 O9kxGxgUhycO56zyX/1baaplLAjnODo3YF5lvk+wtfhhdVDR4zn/rxuEVCOSEJ9VmzpTf
	 jRLYACHC4UBtCn3nfxWc6NXNfNsh8295JjxoBXRgAEt6Rm11kohNp3sD1zA2T9IXOkEGC
	 FH05YNN/zP7hDOMfT5xCQz9Q5h6tbZvhAOhKbT/DVBtUGY1kZXnbpzAEZYjklBoddJA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U98rnkEu;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49E6660A382D;
	Tue, 10 Nov 2026 10:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U98rnkEu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F33171F008A1;
	Tue, 10 Nov 2026 10:21:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794306117;
	bh=G5gbx2f9v0sLZlMcF2z3zyvFJHQx55cXMBAXIFVMQfs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=U98rnkEu7VUsF2oVyCoCB33S9xKUpN+ACPanqJ2EFEJxo8c+A3dVSkQPAZQkDsLlZ
	 gStx2nX9mc2cSFIKY73BAooEnQ77+R1b2k5K3hOvgQoiuclFSC2pn/Wm3WSQnh3J1U
	 xePowUdFkEFmP9KY4Jt0LSeimljPbY6/J3sCFek8Oc0lSj7bPBEcldaDHAK+E972hM
	 8UzXC0nKkz4nCrjBgcOGn1Qs+V6IFwpfoh3bNcFdyDRO2vxO1RrMiWX8ZqEPBvjn10
	 tAW4OdqoP6Q1Oz3S38Vz2++35g9ujAwoEm25nYOX9KmVPbvLP8+x4gQng8j7j86ILL
	 TcNnAoQGwXEEA==
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
Subject: [PATCH net-next v1 07/11] xsk: Deliver provider chunks without copying
Date: Tue, 10 Nov 2026 11:20:28 +0100
Message-ID: <20261110102039.1002605-8-bjorn@kernel.org>
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

A provider socket still receives through the copy path, which takes
FILL entries without the provider's ownership checks: a chunk that a
page pool holds could be handed out twice. No driver opts in yet.

Put packets whose buffers all belong to the socket's provider on the
RX ring as they are, and copy others into chunks the provider claims.
Only the queue NAPI may produce to such a socket, so generic XDP and
CPUMAP redirects to it are dropped.

A device may place payload at chunk offset 0, as fbnic does, so only
the first buffer of a packet keeps the UMEM headroom. Such buffers may
be sent back as they are, so only descriptors with XDP_TX_METADATA
need room for TX metadata in front.

Signed-off-by: Björn Töpel <bjorn@kernel.org>
---
 Documentation/networking/af_xdp.rst          |   6 +-
 Documentation/networking/xsk-tx-metadata.rst |   3 +-
 include/net/page_pool/memory_provider.h      |   2 +
 net/core/page_pool.c                         |  34 +++-
 net/xdp/xsk.c                                |  82 ++++++++-
 net/xdp/xsk.h                                |   5 +
 net/xdp/xsk_pp.c                             | 165 +++++++++++++++++++
 net/xdp/xsk_queue.h                          |  18 +-
 8 files changed, 304 insertions(+), 11 deletions(-)

diff --git a/Documentation/networking/af_xdp.rst b/Documentation/networking/af_xdp.rst
index cc3f0d16b28f..e73a0005e169 100644
--- a/Documentation/networking/af_xdp.rst
+++ b/Documentation/networking/af_xdp.rst
@@ -428,8 +428,10 @@ area and that your largest packet size can be 2K.
 There is also an option to set the headroom of each single buffer in
 the UMEM. If you set this to N bytes, it means that the packet will
 start N bytes into the buffer leaving the first N bytes for the
-application to use. The final option is the flags field, but it will
-be dealt with in separate sections for each UMEM flag.
+application to use. In a multi-buffer packet, only the first buffer is
+guaranteed this headroom; the others may start at offset 0 of their
+chunk. The final option is the flags field, but it will be dealt with
+in separate sections for each UMEM flag.
 
 SO_BINDTODEVICE setsockopt
 --------------------------
diff --git a/Documentation/networking/xsk-tx-metadata.rst b/Documentation/networking/xsk-tx-metadata.rst
index f240930ca1df..8bb74a569c26 100644
--- a/Documentation/networking/xsk-tx-metadata.rst
+++ b/Documentation/networking/xsk-tx-metadata.rst
@@ -59,7 +59,8 @@ The flags field enables the particular offload:
 Besides the flags above, in order to trigger the offloads, the first
 packet's ``struct xdp_desc`` descriptor should set ``XDP_TX_METADATA``
 bit in the ``options`` field. Also note that in a multi-buffer packet
-only the first chunk should carry the metadata.
+only the first chunk should carry the metadata. Only a descriptor with
+``XDP_TX_METADATA`` needs ``tx_metadata_len`` bytes in front of it.
 
 Software TX Checksum
 ====================
diff --git a/include/net/page_pool/memory_provider.h b/include/net/page_pool/memory_provider.h
index daec73c9dcee..849db08513b8 100644
--- a/include/net/page_pool/memory_provider.h
+++ b/include/net/page_pool/memory_provider.h
@@ -49,6 +49,8 @@ struct memory_provider_ops {
 bool net_mp_niov_set_dma_addr(struct net_iov *niov, dma_addr_t addr);
 void net_mp_niov_set_page_pool(struct page_pool *pool, struct net_iov *niov);
 void net_mp_niov_clear_page_pool(struct net_iov *niov);
+void net_mp_release_page_pool_bulk(struct page_pool *pool,
+				   netmem_ref *netmems, u32 count);
 
 int netif_mp_open_rxq(struct net_device *dev, unsigned int rxq_idx,
 		      const struct pp_memory_provider_params *p,
diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index e897e79d31f1..56c299f2280d 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -1401,7 +1401,7 @@ bool net_mp_niov_set_dma_addr(struct net_iov *niov, dma_addr_t addr)
 }
 
 /* Associate a niov with a page pool. Should follow with a matching
- * net_mp_niov_clear_page_pool()
+ * net_mp_niov_clear_page_pool() or net_mp_release_page_pool_bulk()
  */
 void net_mp_niov_set_page_pool(struct page_pool *pool, struct net_iov *niov)
 {
@@ -1422,3 +1422,35 @@ void net_mp_niov_clear_page_pool(struct net_iov *niov)
 
 	page_pool_clear_pp_info(netmem);
 }
+
+/**
+ * net_mp_release_page_pool_bulk() - take net_iovs back from a page pool
+ * @pool: page pool that holds one reference to each net_iov
+ * @netmems: net_iovs of the memory provider of @pool
+ * @count: number of entries in @netmems
+ *
+ * A memory provider takes net_iovs out of a page pool without
+ * ->release_netmem(), for example to give them to userspace. @pool may be
+ * freed on return.
+ */
+void net_mp_release_page_pool_bulk(struct page_pool *pool,
+				   netmem_ref *netmems, u32 count)
+{
+	bool trace = trace_page_pool_state_release_enabled();
+	atomic_t *release_cnt = &pool->pages_state_release_cnt;
+	int released;
+	u32 i;
+
+	for (i = 0; i < count; i++) {
+		DEBUG_NET_WARN_ON_ONCE(netmem_get_pp(netmems[i]) != pool);
+		page_pool_clear_pp_info(netmems[i]);
+		if (!trace)
+			continue;
+
+		released = atomic_inc_return_relaxed(release_cnt);
+		trace_page_pool_state_release(pool, netmems[i], released);
+	}
+
+	if (!trace)
+		atomic_add(count, release_cnt);
+}
diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index 113b0b08356d..b419c673e3f1 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -386,6 +386,54 @@ static int __xsk_rcv(struct xdp_sock *xs, struct xdp_buff *xdp, u32 len)
 	return -ENOMEM;
 }
 
+static int xsk_pp_rcv_copy(struct xdp_sock *xs, struct xdp_buff *xdp, u32 len)
+{
+	u32 frame_size = __xsk_pool_get_rx_frame_size(xs->pool);
+	u32 headroom = xsk_pool_get_headroom(xs->pool);
+	void *copy_from = xsk_copy_xdp_start(xdp);
+	u32 from_len, meta_len, rem, num_desc, i;
+	u64 addrs[MAX_SKB_FRAGS + 1];
+	skb_frag_t *frag = NULL;
+	u32 to_len, copied;
+	void *to;
+
+	from_len = xdp->data_end - copy_from;
+	meta_len = xdp->data - copy_from;
+	rem = len + meta_len;
+
+	num_desc = (len - 1) / frame_size + 1;
+	if (num_desc > ARRAY_SIZE(addrs)) {
+		xs->rx_dropped++;
+		return -ENOSPC;
+	}
+	if (xskq_prod_nb_free(xs->rx, num_desc) < num_desc) {
+		xs->rx_queue_full++;
+		return -ENOBUFS;
+	}
+	if (!xsk_pp_claim_copy(xs->pool->pp, addrs, num_desc)) {
+		xs->rx_dropped++;
+		return -ENOMEM;
+	}
+
+	if (xdp_buff_has_frags(xdp))
+		frag = &xdp_get_shared_info_from_buff(xdp)->frags[0];
+
+	for (i = 0; rem && i < num_desc; i++) {
+		to = xp_raw_get_data(xs->pool, addrs[i] + headroom) - meta_len;
+		to_len = frame_size + meta_len;
+		copied = xsk_copy_xdp(to, &copy_from, to_len, &from_len, &frag,
+				      rem);
+		rem -= copied;
+
+		__xskq_prod_reserve_desc(xs->rx, addrs[i] + headroom,
+					 copied - meta_len,
+					 rem ? XDP_PKT_CONTD : 0);
+		meta_len = 0;
+	}
+
+	return 0;
+}
+
 static bool xsk_tx_writeable(struct xdp_sock *xs)
 {
 	if (xskq_cons_present_entries(xs->tx) > xs->tx->nentries / 2)
@@ -453,8 +501,14 @@ static int xsk_rcv_check(struct xdp_sock *xs, struct xdp_buff *xdp, u32 len)
 
 static void xsk_flush(struct xdp_sock *xs)
 {
+	struct xsk_pp *pp = xs->pool->pp;
+
+	if (pp)
+		xsk_pp_flush(pp);
 	xskq_prod_submit(xs->rx);
-	__xskq_cons_release(xs->pool->fq);
+	/* A provider releases FILL entries under its lock. */
+	if (!pp)
+		__xskq_cons_release(xs->pool->fq);
 	sock_def_readable(&xs->sk);
 }
 
@@ -464,6 +518,11 @@ int xsk_generic_rcv(struct xdp_sock *xs, struct xdp_buff *xdp)
 	int err;
 
 	err = xsk_rcv_check(xs, xdp, len);
+	/* Only the NAPI of the queue feeds a memory provider socket. */
+	if (!err && xs->pool->pp) {
+		xs->rx_dropped++;
+		err = -EOPNOTSUPP;
+	}
 	if (!err) {
 		spin_lock_bh(&xs->pool->rx_lock);
 		err = __xsk_rcv(xs, xdp, len);
@@ -488,7 +547,26 @@ static int xsk_rcv(struct xdp_sock *xs, struct xdp_buff *xdp)
 		return xsk_rcv_zc(xs, xdp, len);
 	}
 
-	err = __xsk_rcv(xs, xdp, len);
+	if (!xs->pool->pp) {
+		err = __xsk_rcv(xs, xdp, len);
+	} else {
+		/* A CPUMAP program runs XDP on another CPU, not in NAPI. */
+		if (unlikely(!xdp_rxq_info_is_reg(xdp->rxq))) {
+			xs->rx_dropped++;
+			return -EINVAL;
+		}
+
+		err = xsk_pp_rcv_zc(xs->pool->pp, xs, xdp);
+		if (err != -EXDEV)
+			return err;
+
+		/* Copy only packets of the queue, from its NAPI */
+		if (unlikely(!xsk_pp_queue_buf(xs->pool->pp, xdp))) {
+			xs->rx_dropped++;
+			return -EINVAL;
+		}
+		err = xsk_pp_rcv_copy(xs, xdp, len);
+	}
 	if (!err)
 		xdp_return_buff(xdp);
 	return err;
diff --git a/net/xdp/xsk.h b/net/xdp/xsk.h
index d7d6bcf0a893..a5f52ef382a6 100644
--- a/net/xdp/xsk.h
+++ b/net/xdp/xsk.h
@@ -43,6 +43,11 @@ int xsk_pp_bind(struct xsk_buff_pool *pool, struct net_device *dev,
 		u16 queue_id);
 void xsk_pp_unbind(struct xsk_buff_pool *pool);
 int xsk_pp_wakeup(struct xsk_pp *pp);
+void xsk_pp_flush(struct xsk_pp *pp);
+bool xsk_pp_queue_buf(struct xsk_pp *pp, struct xdp_buff *xdp);
+int xsk_pp_rcv_zc(struct xsk_pp *pp, struct xdp_sock *xs,
+		  struct xdp_buff *xdp);
+bool xsk_pp_claim_copy(struct xsk_pp *pp, u64 *addrs, u32 n);
 int xp_alloc_heads(struct xsk_buff_pool *pool);
 void xsk_clear_pool_at_qid(struct net_device *dev, u16 queue_id);
 int xsk_reg_pool_at_qid(struct net_device *dev, struct xsk_buff_pool *pool,
diff --git a/net/xdp/xsk_pp.c b/net/xdp/xsk_pp.c
index a77213f7fef6..a1c2ca00f016 100644
--- a/net/xdp/xsk_pp.c
+++ b/net/xdp/xsk_pp.c
@@ -19,11 +19,13 @@
 #include "xsk_queue.h"
 
 #define XSK_PP_DMA_ATTR	(DMA_ATTR_WEAK_ORDERING | DMA_ATTR_SKIP_CPU_SYNC)
+#define XSK_PP_BATCH	64
 
 enum xsk_pp_chunk {
 	XSK_PP_USER,	/* owned by userspace */
 	XSK_PP_POOL,	/* owned by a page pool */
 	XSK_PP_REUSE,	/* on the reuse stack */
+	XSK_PP_COPY,	/* copied into, not yet on the RX ring */
 };
 
 struct xsk_pp {
@@ -38,6 +40,9 @@ struct xsk_pp {
 	/* RX queue of the provider, NULL once it is removed */
 	struct netdev_rx_queue __rcu *rxq;
 	bool starved;
+	/* Chunks of unpublished RX descriptors, NAPI only */
+	u32 pending_cnt;
+	netmem_ref pending[XSK_PP_BATCH];
 	u8 *state;
 	u32 reuse_cnt;
 	u32 reuse[];
@@ -294,6 +299,166 @@ static bool xsk_pp_refill_done(struct page_pool *pool, enum pp_refill state)
 	return !more && wait;
 }
 
+static u32 xsk_pp_chunk_idx(netmem_ref netmem)
+{
+	return net_iov_idx(netmem_to_net_iov(netmem));
+}
+
+/* Called from the queue NAPI, before the RX ring publishes the descriptors */
+void xsk_pp_flush(struct xsk_pp *pp)
+{
+	struct page_pool *pool;
+	u32 i, j, n = 0;
+	u32 idx;
+
+	if (!pp->pending_cnt)
+		return;
+
+	spin_lock_bh(&pp->lock);
+	for (i = 0; i < pp->pending_cnt; i++) {
+		idx = xsk_pp_chunk_idx(pp->pending[i]);
+		if (pp->state[idx] == XSK_PP_COPY) {
+			pp->state[idx] = XSK_PP_USER;
+			continue;
+		}
+
+		DEBUG_NET_WARN_ON_ONCE(pp->state[idx] != XSK_PP_POOL);
+		pp->pending[n++] = pp->pending[i];
+	}
+
+	/* A queue restart may change the page pool within a batch. */
+	for (i = 0; i < n; i = j) {
+		pool = netmem_get_pp(pp->pending[i]);
+		for (j = i + 1; j < n; j++)
+			if (netmem_get_pp(pp->pending[j]) != pool)
+				break;
+
+		net_mp_release_page_pool_bulk(pool, pp->pending + i, j - i);
+		while (i < j) {
+			idx = xsk_pp_chunk_idx(pp->pending[i++]);
+			pp->state[idx] = XSK_PP_USER;
+		}
+	}
+	pp->pending_cnt = 0;
+	spin_unlock_bh(&pp->lock);
+}
+
+bool xsk_pp_queue_buf(struct xsk_pp *pp, struct xdp_buff *xdp)
+{
+	netmem_ref head = xdp_buff_head_netmem(xdp);
+	struct netdev_rx_queue *rxq;
+	struct page_pool *pool;
+	bool ours = false;
+
+	/* An XDP test run for the queue brings buffers of its own */
+	if (!netmem_is_net_iov(head))
+		return false;
+
+	pool = netmem_get_pp(head);
+	rcu_read_lock();
+	rxq = rcu_dereference(pp->rxq);
+	if (pool && rxq)
+		ours = pool->slow.netdev == rxq->dev &&
+		       pool->slow.queue_idx == get_netdev_rx_queue_index(rxq);
+	rcu_read_unlock();
+
+	return ours;
+}
+
+static bool xsk_pp_owns(struct xsk_pp *pp, netmem_ref netmem)
+{
+	struct page_pool *pool;
+
+	if (!netmem_is_net_iov(netmem))
+		return false;
+
+	pool = netmem_get_pp(netmem);
+	return pool && pool->mp_priv == pp;
+}
+
+/* Returns -EXDEV for a packet that must be copied. Called from the NAPI. */
+int xsk_pp_rcv_zc(struct xsk_pp *pp, struct xdp_sock *xs,
+		  struct xdp_buff *xdp)
+{
+	struct skb_shared_info *sinfo = NULL;
+	void *umem = xs->pool->addrs;
+	u32 i, nr_frags = 0, num_desc;
+	netmem_ref head;
+	skb_frag_t *frag;
+
+	head = xdp_buff_head_netmem(xdp);
+	if (!xsk_pp_owns(pp, head))
+		return -EXDEV;
+
+	if (unlikely(xdp_buff_has_frags(xdp))) {
+		if (!xs->sg)
+			return -EXDEV;
+
+		sinfo = xdp_get_shared_info_from_buff(xdp);
+		nr_frags = sinfo->nr_frags;
+		for (i = 0; i < nr_frags; i++)
+			if (!xsk_pp_owns(pp, skb_frag_netmem(&sinfo->frags[i])))
+				return -EXDEV;
+	}
+
+	num_desc = nr_frags + 1;
+	if (xskq_prod_nb_free(xs->rx, num_desc) < num_desc) {
+		xs->rx_queue_full++;
+		return -ENOBUFS;
+	}
+	if (pp->pending_cnt + num_desc > XSK_PP_BATCH)
+		xsk_pp_flush(pp);
+
+	__xskq_prod_reserve_desc(xs->rx, xdp->data - umem,
+				 xdp->data_end - xdp->data,
+				 nr_frags ? XDP_PKT_CONTD : 0);
+	pp->pending[pp->pending_cnt++] = head;
+
+	for (i = 0; i < nr_frags; i++) {
+		frag = &sinfo->frags[i];
+		__xskq_prod_reserve_desc(xs->rx, skb_frag_address(frag) - umem,
+					 skb_frag_size(frag),
+					 i + 1 < nr_frags ? XDP_PKT_CONTD : 0);
+		pp->pending[pp->pending_cnt++] = skb_frag_netmem(frag);
+	}
+
+	return 0;
+}
+
+/* The chunks go to userspace with the next xsk_pp_flush(). Called from the
+ * NAPI. On failure the chunks taken from FILL stay with the provider.
+ */
+bool xsk_pp_claim_copy(struct xsk_pp *pp, u64 *addrs, u32 n)
+{
+	netmem_ref *netmems;
+	u32 i, got, idx;
+
+	BUILD_BUG_ON(MAX_SKB_FRAGS + 1 > XSK_PP_BATCH);
+	if (pp->pending_cnt + n > XSK_PP_BATCH)
+		xsk_pp_flush(pp);
+
+	netmems = pp->pending + pp->pending_cnt;
+	spin_lock_bh(&pp->lock);
+	got = xsk_pp_alloc_reuse(pp, netmems, n);
+	got += xsk_pp_alloc_fill(pp, netmems + got, n - got);
+	for (i = 0; i < got; i++) {
+		idx = xsk_pp_chunk_idx(netmems[i]);
+		if (got < n) {
+			pp->state[idx] = XSK_PP_REUSE;
+			pp->reuse[pp->reuse_cnt++] = idx;
+			continue;
+		}
+
+		pp->state[idx] = XSK_PP_COPY;
+		addrs[i] = (u64)idx << pp->area.niov_shift;
+	}
+	if (got == n)
+		pp->pending_cnt += n;
+	spin_unlock_bh(&pp->lock);
+
+	return got == n;
+}
+
 static int xsk_pp_nl_fill(void *mp_priv, struct sk_buff *rsp,
 			  struct netdev_rx_queue *rxq)
 {
diff --git a/net/xdp/xsk_queue.h b/net/xdp/xsk_queue.h
index 1bc42c8902f4..b9464b917a88 100644
--- a/net/xdp/xsk_queue.h
+++ b/net/xdp/xsk_queue.h
@@ -156,17 +156,24 @@ static inline bool xp_unused_options_set(u32 options)
 	return options & ~(XDP_PKT_CONTD | XDP_TX_METADATA);
 }
 
+static inline u32 xp_desc_meta_len(struct xsk_buff_pool *pool,
+				   struct xdp_desc *desc)
+{
+	return desc->options & XDP_TX_METADATA ? pool->tx_metadata_len : 0;
+}
+
 static inline bool xp_aligned_validate_desc(struct xsk_buff_pool *pool,
 					    struct xdp_desc *desc)
 {
+	u32 meta = xp_desc_meta_len(pool, desc);
 	u64 len = desc->len;
 	u64 addr, offset;
 
 	if (!len)
 		return false;
 
-	/* Can overflow if desc->addr < pool->tx_metadata_len */
-	if (check_sub_overflow(desc->addr, pool->tx_metadata_len, &addr))
+	/* Can overflow if desc->addr < meta */
+	if (check_sub_overflow(desc->addr, meta, &addr))
 		return false;
 
 	offset = addr & (pool->chunk_size - 1);
@@ -176,7 +183,7 @@ static inline bool xp_aligned_validate_desc(struct xsk_buff_pool *pool,
 	 * (pool->chunk_size is ``u32``), @len is guaranteed
 	 * to be <= ``U32_MAX``.
 	 */
-	if (offset + len + pool->tx_metadata_len > pool->chunk_size)
+	if (offset + len + meta > pool->chunk_size)
 		return false;
 
 	if (addr >= pool->addrs_cnt)
@@ -191,6 +198,7 @@ static inline bool xp_aligned_validate_desc(struct xsk_buff_pool *pool,
 static inline bool xp_unaligned_validate_desc(struct xsk_buff_pool *pool,
 					      struct xdp_desc *desc)
 {
+	u32 meta = xp_desc_meta_len(pool, desc);
 	u64 len = desc->len;
 	u64 addr, end;
 
@@ -198,13 +206,13 @@ static inline bool xp_unaligned_validate_desc(struct xsk_buff_pool *pool,
 		return false;
 
 	/* Can't overflow: @len is guaranteed to be <= ``U32_MAX`` */
-	len += pool->tx_metadata_len;
+	len += meta;
 	if (len > pool->chunk_size)
 		return false;
 
 	/* Can overflow if desc->addr is close to 0 */
 	if (check_sub_overflow(xp_unaligned_add_offset_to_addr(desc->addr),
-			       pool->tx_metadata_len, &addr))
+			       meta, &addr))
 		return false;
 
 	if (addr >= pool->addrs_cnt)
-- 
2.56.0

