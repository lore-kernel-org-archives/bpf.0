Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794306089;
	b=Zc9tltpbz3mKCHMTXYK69xCrMm15AuxUkQ7zGnu3vw7H4deRNnjqrz233JHymljeU5pe
	 qwNVM0RSItqh3VVbu5qwf+qYyb+I5UXz1c1B9JWWpI11jUXTpbSZjGLAPJ8a/SXd4V6yY
	 tj8fZ81GgLJdj3OMdUmPo3dI/dJZrekm2NopeZl2nuZzXn5OpIag3xrcKX5AR5hPRMN3V
	 nUsMzCr/8qIdh7lw6rSa0/aQaDTPagBmTvGnlB4TvxQWmLOOy8rZ10WpFAu3+hq1sVnJt
	 Zcf8I7PRp8axwNho8VUi4MxxDJt51ix73uDXfYU/nbkRs2f8BpZmCxjpVSfTaslfvWw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794306089;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=3EhYz0LV+XgzV+iKzAI6YUF5VDNk4UHaeAjsQNOiOZE=;
	b=21La4xrd+kKfW4Q+LEIscgylTs61k/3fKVazyJS0hEiY0d9NBrKDuFNynZ57sP4k2+wD
	 r3NTWLwJgMTgSQ6H1YmkOLjDGyvboY1PcpxFZTyUTdptDjuJ4lODqroEM6oTqocL/i+/4
	 9YQxudSdIpr/JlShbr/H5o45sINitR6vCWMsbE3WuT03h8/7dlLOELwGDuIwNbsO7QgUb
	 Z6xC2CPPvlMAQFhK5PGusVnI8ZmZgUDhBKrNawyf9XT/Q+kqlmldQphPncW6w8fCW4IhB
	 iwGwvROsdX6Fg6hGHr6S7ggPjvPUW/Ux0JEo948y02KGEoa0hn2wz2RQg4dFkH+G6ww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WfSQTExS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 890B2606A436;
	Tue, 10 Nov 2026 10:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WfSQTExS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 565561F008A1;
	Tue, 10 Nov 2026 10:21:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794306089;
	bh=3EhYz0LV+XgzV+iKzAI6YUF5VDNk4UHaeAjsQNOiOZE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WfSQTExSq8Y+L4DPs4x0KIcmf45/g8mXQgth7hFvHK9zO/r28+ogycIQvR2KqdLFn
	 1te8S7qzO6Sx5cC7fkni3AyemNQ7ToMsfzD3yROLs+CgfBJRgBOmCn5lRw5sK0tfWm
	 YAALXaGDA1tszJb35SUlRuYRmhV2twlZ8RYfc7A8gXauRUEhqSRjkIhAaeIsNv8mp2
	 MKx+p6yTr1cnRs/7CexrSX+EZXljouzjDg6LguxyOA5BiAtCiQyTQGc7bpsDSVBwTP
	 aDkqBoKGtsD//7EIhui9KXhJccbsmIYAP6CuFHqPrCC6giKvXtLv/fjlxMb8j2Pssw
	 rLjc82cz8YI+g==
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
Subject: [PATCH net-next v1 04/11] xsk: Allocate UMEM chunks through page_pool
Date: Tue, 10 Nov 2026 11:20:25 +0100
Message-ID: <20261110102039.1002605-5-bjorn@kernel.org>
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

AF_XDP zero copy needs a second RX allocator in every driver. A
page_pool driver can take UMEM chunks from a memory provider instead,
and keep its refill, recycling and DMA sync code.

Each aligned chunk becomes a net_iov, whose address netmem_address()
finds without calling the provider. Userspace may post a chunk that
the kernel still owns, so the provider tracks the owner of each chunk
and drops such FILL entries. Chunks that a page pool releases stay in
the kernel for reuse. Nothing installs the provider yet.

Signed-off-by: Björn Töpel <bjorn@kernel.org>
---
 include/net/netmem.h |  25 ++++-
 include/net/xdp.h    |   2 +-
 net/xdp/Kconfig      |   1 +
 net/xdp/Makefile     |   2 +-
 net/xdp/xsk.h        |   6 ++
 net/xdp/xsk_pp.c     | 246 +++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 279 insertions(+), 3 deletions(-)
 create mode 100644 net/xdp/xsk_pp.c

diff --git a/include/net/netmem.h b/include/net/netmem.h
index b986ad616334..a3b67ef32b21 100644
--- a/include/net/netmem.h
+++ b/include/net/netmem.h
@@ -69,6 +69,7 @@ DECLARE_STATIC_KEY_FALSE(page_pool_restricted);
 enum net_iov_type {
 	NET_IOV_DMABUF,
 	NET_IOV_IOURING,
+	NET_IOV_XSK,
 };
 
 /* A memory descriptor representing abstract networking I/O vectors.
@@ -107,6 +108,10 @@ struct net_iov_area {
 	size_t num_niovs;
 	/* Each net_iov covers 1 << niov_shift bytes. */
 	unsigned int niov_shift;
+	/* CPU address of the first net_iov, or NULL if the CPU cannot read
+	 * the area.
+	 */
+	void *vaddr;
 };
 
 static inline struct net_iov_area *net_iov_owner(const struct net_iov *niov)
@@ -119,6 +124,18 @@ static inline unsigned int net_iov_idx(const struct net_iov *niov)
 	return niov - net_iov_owner(niov)->niovs;
 }
 
+static inline void *net_iov_address(const struct net_iov *niov)
+{
+	const struct net_iov_area *area = net_iov_owner(niov);
+	unsigned long off;
+
+	if (!area->vaddr)
+		return NULL;
+
+	off = (unsigned long)net_iov_idx(niov) << area->niov_shift;
+	return area->vaddr + off;
+}
+
 /* Initialize a niov: stamp the owning area, the memory provider type.
  */
 static inline void net_iov_init(struct net_iov *niov,
@@ -345,10 +362,16 @@ static inline void *__netmem_address(netmem_ref netmem)
 	return page_address(__netmem_to_page(netmem));
 }
 
+/**
+ * netmem_address - get the CPU address of the memory behind @netmem
+ * @netmem: netmem to get the address of
+ *
+ * Return: the address, or NULL if the CPU cannot read @netmem.
+ */
 static inline void *netmem_address(netmem_ref netmem)
 {
 	if (netmem_is_net_iov(netmem))
-		return NULL;
+		return net_iov_address(netmem_to_net_iov(netmem));
 
 	return __netmem_address(netmem);
 }
diff --git a/include/net/xdp.h b/include/net/xdp.h
index 1105bb9e3292..5ab7802ac4e1 100644
--- a/include/net/xdp.h
+++ b/include/net/xdp.h
@@ -368,7 +368,7 @@ static inline bool xdp_buff_add_frag(struct xdp_buff *xdp, netmem_ref netmem,
 
 	if (unlikely(netmem_is_pfmemalloc(netmem)))
 		xdp_buff_set_frag_pfmemalloc(xdp);
-	if (unlikely(netmem_is_net_iov(netmem)))
+	if (unlikely(netmem_is_net_iov(netmem) && !netmem_address(netmem)))
 		xdp_buff_set_frag_unreadable(xdp);
 
 	return true;
diff --git a/net/xdp/Kconfig b/net/xdp/Kconfig
index 71af2febe72a..c9c68d3b3712 100644
--- a/net/xdp/Kconfig
+++ b/net/xdp/Kconfig
@@ -2,6 +2,7 @@
 config XDP_SOCKETS
 	bool "XDP sockets"
 	depends on BPF_SYSCALL
+	select PAGE_POOL
 	default n
 	help
 	  XDP sockets allows a channel between XDP programs and
diff --git a/net/xdp/Makefile b/net/xdp/Makefile
index 30cdc4315f42..6e9d60f9f7f1 100644
--- a/net/xdp/Makefile
+++ b/net/xdp/Makefile
@@ -1,4 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0-only
 obj-$(CONFIG_XDP_SOCKETS) += xsk.o xdp_umem.o xsk_queue.o xskmap.o
-obj-$(CONFIG_XDP_SOCKETS) += xsk_buff_pool.o
+obj-$(CONFIG_XDP_SOCKETS) += xsk_buff_pool.o xsk_pp.o
 obj-$(CONFIG_XDP_SOCKETS_DIAG) += xsk_diag.o
diff --git a/net/xdp/xsk.h b/net/xdp/xsk.h
index 7c811b5cce76..4dab7b9a1487 100644
--- a/net/xdp/xsk.h
+++ b/net/xdp/xsk.h
@@ -34,6 +34,12 @@ static inline struct xdp_sock *xdp_sk(struct sock *sk)
 
 void xsk_map_try_sock_delete(struct xsk_map *map, struct xdp_sock *xs,
 			     struct xdp_sock __rcu **map_entry);
+struct xsk_pp;
+
+extern const struct memory_provider_ops xsk_pp_ops;
+
+struct xsk_pp *xsk_pp_create(struct xsk_buff_pool *pool);
+void xsk_pp_put(struct xsk_pp *pp);
 void xsk_clear_pool_at_qid(struct net_device *dev, u16 queue_id);
 int xsk_reg_pool_at_qid(struct net_device *dev, struct xsk_buff_pool *pool,
 			u16 queue_id);
diff --git a/net/xdp/xsk_pp.c b/net/xdp/xsk_pp.c
new file mode 100644
index 000000000000..fdd55265a6cd
--- /dev/null
+++ b/net/xdp/xsk_pp.c
@@ -0,0 +1,246 @@
+// SPDX-License-Identifier: GPL-2.0
+/* AF_XDP UMEM as a page pool memory provider
+ *
+ * Each aligned UMEM chunk is a readable net_iov with one owner at a time:
+ *
+ *   userspace --FILL--> page pool --release--> reuse --alloc--> page pool
+ *       ^                   |
+ *       +-----RX ring-------+
+ */
+
+#include <net/page_pool/helpers.h>
+#include <net/page_pool/memory_provider.h>
+#include <net/xdp_sock_drv.h>
+
+#include "xsk.h"
+#include "xsk_queue.h"
+
+enum xsk_pp_chunk {
+	XSK_PP_USER,	/* owned by userspace */
+	XSK_PP_POOL,	/* owned by a page pool */
+	XSK_PP_REUSE,	/* on the reuse stack */
+};
+
+struct xsk_pp {
+	struct net_iov_area area;
+	struct xsk_buff_pool *pool;
+	/* Protects fq, state and reuse */
+	spinlock_t lock;
+	struct xsk_queue *fq;
+	refcount_t refs;
+	u32 nr_pools;
+	bool dma_need_sync;
+	u8 *state;
+	u32 reuse_cnt;
+	u32 reuse[];
+};
+
+static void xsk_pp_free(struct xsk_pp *pp)
+{
+	kvfree(pp->state);
+	kvfree(pp->area.niovs);
+	kvfree(pp);
+}
+
+void xsk_pp_put(struct xsk_pp *pp)
+{
+	if (refcount_dec_and_test(&pp->refs))
+		xsk_pp_free(pp);
+}
+
+/* @pool must be DMA mapped and have aligned chunks. The provider must be
+ * the only consumer of its FILL ring.
+ */
+struct xsk_pp *xsk_pp_create(struct xsk_buff_pool *pool)
+{
+	struct net_iov *niov;
+	struct xsk_pp *pp;
+	dma_addr_t dma;
+	u32 i;
+
+	pp = kvzalloc_flex(*pp, reuse, pool->heads_cnt, GFP_KERNEL_ACCOUNT);
+	if (!pp)
+		return ERR_PTR(-ENOMEM);
+
+	pp->area.niovs = kvzalloc_objs(*pp->area.niovs, pool->heads_cnt,
+				       GFP_KERNEL_ACCOUNT);
+	pp->state = kvzalloc(pool->heads_cnt, GFP_KERNEL_ACCOUNT);
+	if (!pp->area.niovs || !pp->state) {
+		xsk_pp_free(pp);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	pp->area.num_niovs = pool->heads_cnt;
+	pp->area.niov_shift = pool->chunk_shift;
+	pp->area.vaddr = pool->addrs;
+	pp->pool = pool;
+	pp->fq = pool->fq;
+	pp->dma_need_sync = dma_dev_need_sync(pool->dev);
+	spin_lock_init(&pp->lock);
+	refcount_set(&pp->refs, 1);
+
+	for (i = 0; i < pp->area.num_niovs; i++) {
+		niov = &pp->area.niovs[i];
+		dma = xp_raw_get_dma(pool, (u64)i << pool->chunk_shift);
+		net_iov_init(niov, &pp->area, NET_IOV_XSK);
+		if (net_mp_niov_set_dma_addr(niov, dma)) {
+			xsk_pp_free(pp);
+			return ERR_PTR(-ERANGE);
+		}
+	}
+
+	return pp;
+}
+
+static int xsk_pp_init(struct page_pool *pool)
+{
+	struct xsk_pp *pp = pool->mp_priv;
+
+	if (pool->p.order || pool->p.dma_dir != DMA_BIDIRECTIONAL ||
+	    pool->p.dev != pp->pool->dev)
+		return -EINVAL;
+	if (pool->p.max_len > pp->pool->chunk_size ||
+	    pool->p.offset > pp->pool->chunk_size - pool->p.max_len)
+		return -EINVAL;
+
+	refcount_inc(&pp->refs);
+	spin_lock_bh(&pp->lock);
+	pp->nr_pools++;
+	spin_unlock_bh(&pp->lock);
+	return 0;
+}
+
+static void xsk_pp_destroy(struct page_pool *pool)
+{
+	struct xsk_pp *pp = pool->mp_priv;
+
+	spin_lock_bh(&pp->lock);
+	pp->nr_pools--;
+	spin_unlock_bh(&pp->lock);
+	xsk_pp_put(pp);
+}
+
+static bool xsk_pp_claim(struct xsk_pp *pp, u32 idx, enum xsk_pp_chunk from)
+{
+	lockdep_assert_held(&pp->lock);
+
+	if (pp->state[idx] != from)
+		return false;
+
+	pp->state[idx] = XSK_PP_POOL;
+	return true;
+}
+
+static u32 xsk_pp_alloc_reuse(struct xsk_pp *pp, netmem_ref *netmems, u32 max)
+{
+	u32 idx, n = 0;
+
+	while (n < max && pp->reuse_cnt) {
+		idx = pp->reuse[--pp->reuse_cnt];
+		if (WARN_ON_ONCE(!xsk_pp_claim(pp, idx, XSK_PP_REUSE)))
+			continue;
+		netmems[n++] = net_iov_to_netmem(&pp->area.niovs[idx]);
+	}
+
+	return n;
+}
+
+static u32 xsk_pp_alloc_fill(struct xsk_pp *pp, netmem_ref *netmems, u32 max)
+{
+	struct xsk_buff_pool *pool = pp->pool;
+	struct xsk_queue *fq = pp->fq;
+	u32 i, entries, cons, idx, n = 0;
+	u64 addr;
+
+	if (!fq || !max)
+		return 0;
+
+	entries = xskq_cons_nb_entries(fq, max);
+	if (!entries) {
+		fq->queue_empty_descs++;
+		return 0;
+	}
+
+	cons = fq->cached_cons;
+	for (i = 0; i < entries; i++) {
+		__xskq_cons_read_addr_unchecked(fq, cons++, &addr);
+		addr &= pool->chunk_mask;
+		idx = addr >> pp->area.niov_shift;
+		if (unlikely(addr >= pool->addrs_cnt ||
+			     !xsk_pp_claim(pp, idx, XSK_PP_USER))) {
+			fq->invalid_descs++;
+			continue;
+		}
+		netmems[n++] = net_iov_to_netmem(&pp->area.niovs[idx]);
+	}
+
+	xskq_cons_release_n(fq, entries);
+	__xskq_cons_release(fq);
+	return n;
+}
+
+static netmem_ref xsk_pp_alloc_netmems(struct page_pool *pool, gfp_t gfp)
+{
+	netmem_ref *netmems = pool->alloc.cache;
+	struct xsk_pp *pp = pool->mp_priv;
+	struct net_iov *niov;
+	dma_addr_t dma;
+	u32 i, n;
+
+	if (WARN_ON_ONCE(pool->alloc.count))
+		return 0;
+
+	spin_lock_bh(&pp->lock);
+	n = xsk_pp_alloc_reuse(pp, netmems, PP_ALLOC_CACHE_REFILL);
+	n += xsk_pp_alloc_fill(pp, netmems + n, PP_ALLOC_CACHE_REFILL - n);
+	spin_unlock_bh(&pp->lock);
+	if (!n)
+		return 0;
+
+	for (i = 0; i < n; i++) {
+		niov = netmem_to_net_iov(netmems[i]);
+		dma = page_pool_get_dma_addr_netmem(netmems[i]);
+		if (pp->dma_need_sync)
+			dma_sync_single_range_for_device(pool->p.dev, dma,
+							 pool->p.offset,
+							 pool->p.max_len,
+							 pool->p.dma_dir);
+		net_mp_niov_set_page_pool(pool, niov);
+	}
+
+	pool->alloc.count = n - 1;
+	return netmems[n - 1];
+}
+
+static bool xsk_pp_release_netmem(struct page_pool *pool, netmem_ref netmem)
+{
+	struct net_iov *niov = netmem_to_net_iov(netmem);
+	struct xsk_pp *pp = pool->mp_priv;
+	u32 idx = net_iov_idx(niov);
+
+	spin_lock_bh(&pp->lock);
+	net_mp_niov_clear_page_pool(niov);
+	if (!WARN_ON_ONCE(pp->state[idx] != XSK_PP_POOL ||
+			  pp->reuse_cnt == pp->area.num_niovs)) {
+		pp->state[idx] = XSK_PP_REUSE;
+		pp->reuse[pp->reuse_cnt++] = idx;
+	}
+	spin_unlock_bh(&pp->lock);
+
+	return false;
+}
+
+static int xsk_pp_nl_fill(void *mp_priv, struct sk_buff *rsp,
+			  struct netdev_rx_queue *rxq)
+{
+	return 0;
+}
+
+const struct memory_provider_ops xsk_pp_ops = {
+	.init		= xsk_pp_init,
+	.destroy	= xsk_pp_destroy,
+	.alloc_netmems	= xsk_pp_alloc_netmems,
+	.release_netmem	= xsk_pp_release_netmem,
+	.nl_fill	= xsk_pp_nl_fill,
+	.caps		= MP_CAP_READABLE,
+};
-- 
2.56.0

