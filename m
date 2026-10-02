Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED4A83EDAB3;
	Fri,  2 Oct 2026 19:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790967677; cv=none; b=Jb+INQEwqkYD2jsV/XZR93nQ8fBOAckTaBwPpQutfuKDfau+QdSSvhqRei2cSDB/VxO2FuUwZ7OvtCrl3M4tWRmnnfWiFcUbyPsUfvwILhUXOB5YjEu+mIYN45XQNPZ7ArEWMSnPwxXzbkOFas+26c08EcF/W47HbZtJCMbYA44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790967677; c=relaxed/simple;
	bh=NoAsYjqqkTCVmeJlMbaJVrM7ZpXMRUgtYWb57Rz+jhY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N659EZJpf3b83TagHVlfjvtWfK9sgg6yY/DcpNRRKnWl11eAi52NJuCPIG8og0w/HU78YWgRFvRasjwxDMaJ53ezJ1Lk/qcsDJou/CyafQZGIoKwBTVB3cHH+AdCpC95eaPJenj/c43XirENzOeMg8iFqCt9kQyheGdHnW0iXtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AeSSalL9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AeSSalL9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 163F01F00893;
	Fri,  2 Oct 2026 19:01:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790967672;
	bh=1VSnA8bBLm/1B6ZMOFTIolNf7TlyUS9LbLt2gUT91GM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AeSSalL9WxlaXeeNVyAJ8P62o+BgPpj4bLGMVDKhY9lTyaPQInmespDhAwBREWadX
	 gf1oiPrNnBVCcFk1KyzzSCYfcIWro4Yte5fXxAGDm17PSi7SgQab0q4fYUfFdvoXNc
	 40yE2LnFScr5CjN+XX+MiJDUvyG5/mEIqt82TGtzaA4X4vbqj1DCzv53Xjs0TubjJS
	 YSxpzqS6TNXVLX6SnSIR6sAUEPf+BmN68sI8I9moidyAYzdKc1UtXns6yxKmrfiquh
	 rVjjxBE+Zz+ac7LNvH3QokT6eAoWLjCu9aXoD13YlVo3KVd1h/UErzlWWza3ZBdNju
	 9+mTWqHyB6ADw==
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
Subject: [RFC net-next 05/15] page_pool: Extend memory provider operations
Date: Fri,  2 Oct 2026 21:00:06 +0200
Message-ID: <20261002190018.696925-6-bjorn@kernel.org>
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

The current memory providers give memory that the CPU cannot read,
and they can always refill. An AF_XDP provider is different. The CPU
can read its memory, it has only the buffers that userspace puts in
the FILL ring, and its buffers go back to userspace instead of being
freed. It needs four things from page_pool:

- A CPU address for each net_iov. A provider can set the address of
  the first net_iov in its net_iov_area and the size each net_iov
  covers. netmem_address() then computes the address without a call
  into the provider; drivers call it for every packet. A
  net_iov_area without an address stays unreadable.
  page_pool_is_unreadable() is false for a readable provider.

- A way to say that the refill is not done. The new refill_done
  callback tells the driver whether it may stop refilling. A
  provider that still has buffers returns false, and the driver
  keeps NAPI scheduled.

- A way to give up a buffer without freeing it. Add a batched call
  that ends page_pool ownership of buffers that leave through the
  provider, for example to userspace. It clears the page_pool link,
  so a later page pool can take the buffer. Add the matching batched
  call that sets the link, and a DMA sync helper for drivers that
  post a buffer again directly.

- No buffer splitting, because a split buffer has several owners.
  Add MP_CAP_FRAG. page_pool refuses fragment allocation from a
  provider without it.

devmem and io_uring set MP_CAP_FRAG and keep their fragment
behaviour. Their refill paths now use the batched call that sets the
link.

Signed-off-by: Björn Töpel <bjorn@kernel.org>
---
 include/net/netmem.h                    | 31 ++++++++++-
 include/net/page_pool/helpers.h         | 62 +++++++++++++++++++++-
 include/net/page_pool/memory_provider.h | 28 +++++-----
 io_uring/zcrx.c                         |  4 +-
 net/core/devmem.c                       |  7 ++-
 net/core/page_pool.c                    | 68 ++++++++++++++++++++-----
 6 files changed, 165 insertions(+), 35 deletions(-)

diff --git a/include/net/netmem.h b/include/net/netmem.h
index cc97611632dc..e6dff0b01581 100644
--- a/include/net/netmem.h
+++ b/include/net/netmem.h
@@ -105,6 +105,12 @@ struct net_iov_area {
 
 	/* Offset into the dma-buf where this chunk starts.  */
 	unsigned long base_virtual;
+
+	/* CPU address of the first net_iov's memory, or NULL when the CPU
+	 * cannot read the area. Each net_iov covers 1 << @niov_shift bytes.
+	 */
+	void *vaddr;
+	u8 niov_shift;
 };
 
 static inline struct net_iov_area *net_iov_owner(const struct net_iov *niov)
@@ -117,6 +123,23 @@ static inline unsigned int net_iov_idx(const struct net_iov *niov)
 	return niov - net_iov_owner(niov)->niovs;
 }
 
+static inline bool net_iov_is_readable(const struct net_iov *niov)
+{
+	return net_iov_owner(niov)->vaddr;
+}
+
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
@@ -335,10 +358,16 @@ static inline void *__netmem_address(netmem_ref netmem)
 	return page_address(__netmem_to_page(netmem));
 }
 
+/**
+ * netmem_address - get pointer to the memory backing @netmem
+ * @netmem: netmem reference to get the pointer for
+ *
+ * Return: pointer to the memory, or NULL if the CPU cannot read @netmem.
+ */
 static inline void *netmem_address(netmem_ref netmem)
 {
 	if (netmem_is_net_iov(netmem))
-		return NULL;
+		return net_iov_address(netmem_to_net_iov(netmem));
 
 	return __netmem_address(netmem);
 }
diff --git a/include/net/page_pool/helpers.h b/include/net/page_pool/helpers.h
index cd021832c3fa..7a63671aaceb 100644
--- a/include/net/page_pool/helpers.h
+++ b/include/net/page_pool/helpers.h
@@ -54,6 +54,7 @@
 
 #include <linux/dma-mapping.h>
 
+#include <net/page_pool/memory_provider.h>
 #include <net/page_pool/types.h>
 #include <net/net_debug.h>
 #include <net/netmem.h>
@@ -427,6 +428,26 @@ static inline dma_addr_t page_pool_get_dma_addr_netmem(netmem_ref netmem)
 	return netmem_dma_addr_decode(netmem_get_dma_addr(netmem));
 }
 
+/**
+ * page_pool_refill_done - finish a provider-backed RX ring refill
+ * @pool: page pool used by the RX ring
+ * @full: all RX rings sharing this page pool were refilled
+ *
+ * Return: true if the caller may stop retrying the refill.
+ */
+static inline bool page_pool_refill_done(struct page_pool *pool, bool full)
+{
+	if (unlikely(pool->mp_ops && pool->mp_ops->refill_done))
+		return pool->mp_ops->refill_done(pool, full);
+
+	return true;
+}
+
+static inline bool page_pool_supports_frag(const struct page_pool *pool)
+{
+	return !pool->mp_ops || pool->mp_ops->caps & MP_CAP_FRAG;
+}
+
 /**
  * page_pool_get_dma_addr() - Retrieve the stored DMA address.
  * @page:	page allocated from a page pool
@@ -481,6 +502,45 @@ page_pool_dma_sync_netmem_for_cpu(const struct page_pool *pool,
 				     offset, dma_sync_size);
 }
 
+/**
+ * page_pool_dma_sync_netmem_for_device - sync netmem before giving it to HW
+ * @pool: page pool the netmem belongs to
+ * @netmem: netmem to sync
+ * @offset: offset from the pool's DMA sync start
+ * @dma_sync_size: size of the memory area to sync
+ *
+ * Use when a driver reposts a netmem directly instead of returning it through
+ * page_pool_put_netmem().
+ */
+static inline void
+page_pool_dma_sync_netmem_for_device(const struct page_pool *pool,
+				     const netmem_ref netmem, u32 offset,
+				     u32 dma_sync_size)
+{
+#if defined(CONFIG_HAS_DMA) && defined(CONFIG_DMA_NEED_SYNC)
+	dma_addr_t dma_addr;
+
+	if (!pool->dma_sync || !dma_dev_need_sync(pool->p.dev))
+		return;
+
+	rcu_read_lock();
+	/* Recheck under RCU to synchronize with page_pool_scrub(). */
+	if (pool->dma_sync) {
+		if (WARN_ON_ONCE(offset > pool->p.max_len))
+			goto out;
+
+		dma_addr = page_pool_get_dma_addr_netmem(netmem);
+		dma_sync_size = min(dma_sync_size, pool->p.max_len - offset);
+		dma_sync_single_range_for_device(pool->p.dev, dma_addr,
+						 offset + pool->p.offset,
+						 dma_sync_size,
+						 pool->p.dma_dir);
+	}
+out:
+	rcu_read_unlock();
+#endif
+}
+
 static inline void page_pool_get(struct page_pool *pool)
 {
 	refcount_inc(&pool->user_cnt);
@@ -511,7 +571,7 @@ static inline void page_pool_nid_changed(struct page_pool *pool, int new_nid)
  */
 static inline bool page_pool_is_unreadable(struct page_pool *pool)
 {
-	return !!pool->mp_ops;
+	return pool->mp_ops && !(pool->mp_ops->caps & MP_CAP_READABLE);
 }
 
 #endif /* _NET_PAGE_POOL_HELPERS_H */
diff --git a/include/net/page_pool/memory_provider.h b/include/net/page_pool/memory_provider.h
index d18ec079ffe2..61768f2592c9 100644
--- a/include/net/page_pool/memory_provider.h
+++ b/include/net/page_pool/memory_provider.h
@@ -13,14 +13,22 @@ struct sk_buff;
  * enum mp_caps - memory provider capabilities
  * @MP_CAP_READABLE: The CPU can access provider buffers. They may back
  *	header and regular page pools, and XDP programs may run on them.
+ * @MP_CAP_FRAG: Page pool fragments may split provider buffers. A
+ *	provider without it hands out objects with a reference count of one.
  */
 enum mp_caps {
 	MP_CAP_READABLE		= BIT(0),
+	MP_CAP_FRAG		= BIT(1),
 };
 
 struct memory_provider_ops {
 	netmem_ref (*alloc_netmems)(struct page_pool *pool, gfp_t gfp);
 	bool (*release_netmem)(struct page_pool *pool, netmem_ref netmem);
+	/* Called after RX refill. @full says that the caller reached its refill
+	 * target. Return true when NAPI may complete, or false to keep it
+	 * scheduled even without packet completions.
+	 */
+	bool (*refill_done)(struct page_pool *pool, bool full);
 	int (*init)(struct page_pool *pool);
 	void (*destroy)(struct page_pool *pool);
 	int (*nl_fill)(void *mp_priv, struct sk_buff *rsp,
@@ -30,7 +38,10 @@ struct memory_provider_ops {
 };
 
 bool net_mp_niov_set_dma_addr(struct net_iov *niov, dma_addr_t addr);
-void net_mp_niov_set_page_pool(struct page_pool *pool, struct net_iov *niov);
+void net_mp_netmem_set_page_pool_bulk(struct page_pool *pool,
+				      netmem_ref *netmems, u32 count);
+void net_mp_release_page_pool_bulk(struct page_pool *pool,
+				   netmem_ref *netmems, u32 count);
 void net_mp_niov_clear_page_pool(struct net_iov *niov);
 bool netif_mp_lacks_cap(struct net_device *dev, u32 cap);
 
@@ -40,19 +51,4 @@ int netif_mp_open_rxq(struct net_device *dev, unsigned int rxq_idx,
 void netif_mp_close_rxq(struct net_device *dev, unsigned int rxq_idx,
 			const struct pp_memory_provider_params *old_p);
 
-/**
-  * net_mp_netmem_place_in_cache() - give a netmem to a page pool
-  * @pool:      the page pool to place the netmem into
-  * @netmem:    netmem to give
-  *
-  * Push an accounted netmem into the page pool's allocation cache. The caller
-  * must ensure that there is space in the cache. It should only be called off
-  * the mp_ops->alloc_netmems() path.
-  */
-static inline void net_mp_netmem_place_in_cache(struct page_pool *pool,
-						netmem_ref netmem)
-{
-	pool->alloc.cache[pool->alloc.count++] = netmem;
-}
-
 #endif
diff --git a/io_uring/zcrx.c b/io_uring/zcrx.c
index 86d580d4410d..ffffbccd517f 100644
--- a/io_uring/zcrx.c
+++ b/io_uring/zcrx.c
@@ -1315,10 +1315,11 @@ static unsigned io_zcrx_refill_slow(struct page_pool *pp, struct io_zcrx_ifq *if
 			continue;
 		}
 
-		net_mp_niov_set_page_pool(pp, niov);
 		netmems[allocated] = net_iov_to_netmem(niov);
 		allocated++;
 	}
+	if (allocated)
+		net_mp_netmem_set_page_pool_bulk(pp, netmems, allocated);
 	return allocated;
 }
 
@@ -1476,6 +1477,7 @@ static const struct memory_provider_ops io_uring_pp_zc_ops = {
 	.destroy		= io_pp_zc_destroy,
 	.nl_fill		= io_pp_nl_fill,
 	.uninstall		= io_pp_uninstall,
+	.caps			= MP_CAP_FRAG,
 };
 
 static unsigned zcrx_parse_rq(netmem_ref *netmem_array, unsigned nr,
diff --git a/net/core/devmem.c b/net/core/devmem.c
index 71c83730d73d..aeb804662668 100644
--- a/net/core/devmem.c
+++ b/net/core/devmem.c
@@ -459,7 +459,7 @@ netmem_ref mp_dmabuf_devmem_alloc_netmems(struct page_pool *pool, gfp_t gfp)
 {
 	struct net_devmem_dmabuf_binding *binding = pool->mp_priv;
 	netmem_ref *netmems = pool->alloc.cache;
-	unsigned int allocated, i;
+	unsigned int allocated;
 
 	if (WARN_ON_ONCE(pool->alloc.count))
 		return 0;
@@ -469,9 +469,7 @@ netmem_ref mp_dmabuf_devmem_alloc_netmems(struct page_pool *pool, gfp_t gfp)
 	if (unlikely(!allocated))
 		return 0;
 
-	for (i = 0; i < allocated; i++)
-		net_mp_niov_set_page_pool(pool,
-					  netmem_to_net_iov(netmems[i]));
+	net_mp_netmem_set_page_pool_bulk(pool, netmems, allocated);
 
 	/* Return the last one, the rest stay in the page_pool cache. */
 	allocated--;
@@ -540,4 +538,5 @@ static const struct memory_provider_ops dmabuf_devmem_ops = {
 	.release_netmem		= mp_dmabuf_devmem_release_page,
 	.nl_fill		= mp_dmabuf_devmem_nl_fill,
 	.uninstall		= mp_dmabuf_devmem_uninstall,
+	.caps			= MP_CAP_FRAG,
 };
diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index d7c88c0b67e5..e36ae6123adf 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -726,11 +726,9 @@ void page_pool_set_pp_info(struct page_pool *pool, netmem_ref netmem)
 	netmem_set_pp(netmem, pool);
 	netmem_or_pp_magic(netmem, PP_SIGNATURE);
 
-	/* Ensuring all pages have been split into one fragment initially:
-	 * page_pool_set_pp_info() is only called once for every page when it
-	 * is allocated from the page allocator and page_pool_fragment_page()
-	 * is dirtying the same cache line as the page->pp_magic above, so
-	 * the overhead is negligible.
+	/* Ensure all netmem starts with one fragment. The refcount and
+	 * page-pool state initialized above share a cache line, so the overhead
+	 * is negligible when an object is first associated with the pool.
 	 */
 	page_pool_fragment_netmem(netmem, 1);
 	if (pool->has_init_callback)
@@ -1070,6 +1068,9 @@ netmem_ref page_pool_alloc_frag_netmem(struct page_pool *pool,
 	unsigned int max_size = PAGE_SIZE << pool->p.order;
 	netmem_ref netmem = pool->frag_page;
 
+	if (static_branch_unlikely(&page_pool_mem_providers) &&
+	    WARN_ON_ONCE(!page_pool_supports_frag(pool)))
+		return 0;
 	if (WARN_ON(size > max_size))
 		return 0;
 
@@ -1340,17 +1341,60 @@ bool net_mp_niov_set_dma_addr(struct net_iov *niov, dma_addr_t addr)
 	return page_pool_set_dma_addr_netmem(net_iov_to_netmem(niov), addr);
 }
 
-/* Associate a niov with a page pool. Should follow with a matching
- * net_mp_niov_clear_page_pool()
+/* Associate a batch of niovs with a page pool. Each needs a matching
+ * net_mp_niov_clear_page_pool() or net_mp_release_page_pool_bulk().
  */
-void net_mp_niov_set_page_pool(struct page_pool *pool, struct net_iov *niov)
+void net_mp_netmem_set_page_pool_bulk(struct page_pool *pool,
+				      netmem_ref *netmems, u32 count)
 {
-	netmem_ref netmem = net_iov_to_netmem(niov);
+	bool trace = trace_page_pool_state_hold_enabled();
+	netmem_ref netmem;
+	u32 i;
 
-	page_pool_set_pp_info(pool, netmem);
+	for (i = 0; i < count; i++) {
+		netmem = netmems[i];
+		page_pool_set_pp_info(pool, netmem);
+		if (!trace)
+			continue;
 
-	pool->pages_state_hold_cnt++;
-	trace_page_pool_state_hold(pool, netmem, pool->pages_state_hold_cnt);
+		pool->pages_state_hold_cnt++;
+		trace_page_pool_state_hold(pool, netmem,
+					   pool->pages_state_hold_cnt);
+	}
+	if (!trace)
+		pool->pages_state_hold_cnt += count;
+}
+
+/* Release page_pool ownership of netmems which a provider hands out of the
+ * page pool, for example to userspace. All netmems in the batch must belong
+ * to @pool. The pool may be freed once the last release is accounted.
+ */
+void net_mp_release_page_pool_bulk(struct page_pool *pool,
+				   netmem_ref *netmems, u32 count)
+{
+	bool trace = trace_page_pool_state_release_enabled();
+	atomic_t *release_cnt;
+	netmem_ref netmem;
+	int released;
+	u32 i;
+
+	if (WARN_ON_ONCE(!pool || !count))
+		return;
+
+	release_cnt = &pool->pages_state_release_cnt;
+
+	for (i = 0; i < count; i++) {
+		netmem = netmems[i];
+		DEBUG_NET_WARN_ON_ONCE(netmem_get_pp(netmem) != pool);
+		page_pool_clear_pp_info(netmem);
+		if (!trace)
+			continue;
+
+		released = atomic_inc_return_relaxed(release_cnt);
+		trace_page_pool_state_release(pool, netmem, released);
+	}
+	if (!trace)
+		atomic_add(count, release_cnt);
 }
 
 /* Disassociate a niov from a page pool. Should only be used in the
-- 
2.55.0

