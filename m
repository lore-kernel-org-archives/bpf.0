Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB0223EA94C;
	Fri,  2 Oct 2026 19:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790967707; cv=none; b=QwI5OkLgPGEv9KHywHn4QeP+ADWW2QFIz/SsVTDtRvvx2kuGVNXHfhgNEg9Zba8wtB2qUnIMw09xbVnTv/xPg/bFUimd4q6WNNoJyb7WDoTLBFVR49F4u3oezMqlpHHDuc332Jc125zBOTFcBjbbL4lWqQ3jdOiqqH2qOO+hiEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790967707; c=relaxed/simple;
	bh=Apa8c/lFgM8zzC1XwiLn8s9WzZFZ1VYRNmY1/zAAS5M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pwt25n7uqmGP9JDArB/nOHGujgMjEdt8IBlvj9V7TwZIdJ3qS36JXqU6zGeBnkeD+J9RK9rnvl7H3WTC+vDhae7hfJq5S2blSXyBvAHQtzQSfB4BvyY8hfiHY7AxsrwnwEfDkN9+rH5W8Vb0WNGbcQD5ou1oKB3v8YtKs0hnPDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aj/+x1oR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aj/+x1oR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B98E1F00898;
	Fri,  2 Oct 2026 19:01:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790967704;
	bh=X4y5IxTHho5PwHl+hC9d12/WBTJbnEb/2W25pIG9Rtg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aj/+x1oRymQQMra1EEcr5vUN26xgshiU7TFLBq1JamQb7Dyim8xK/ijRwF3FYm17y
	 BJ33R4AJDff2SYoYArw3JhBFl/QGbPX0OhFJ0iq+URTy9YUE5atbQqkZ3SQupxDyY6
	 m6Ou1SIxjbVDe0lAhI/ENgTs4JGtTCz3WrJWpfNt8pb7e6dffR9UeJLCCABCk2eE6+
	 GVCTA7PvHscrCDs/6BDRCyU4ZkCB0KKiOdKRFRFItI8fkieupy7wNVD7Tkd0AzPsca
	 G4e0JMhP2U60PIhR5QaQMdMl+622OdbMNCHmqGgnQj2plm93WOiPvAUzOevEbuK20w
	 sTIUpfuDiPqCA==
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
Subject: [RFC net-next 09/15] xsk: Add a page-pool memory provider for UMEM
Date: Fri,  2 Oct 2026 21:00:10 +0200
Message-ID: <20261002190018.696925-10-bjorn@kernel.org>
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

AF_XDP zero-copy drivers get RX buffers from an xsk_buff_pool. A
driver built on page_pool would need a second RX allocator for that.
Instead, let an XSK buffer pool act as a page-pool memory provider.
It hands out UMEM chunks as NET_IOV_XSK net_iovs, and the driver
uses the normal page_pool API.

A driver calls xsk_pool_setup_page_pool() for XDP_SETUP_XSK_POOL.
For now only 4 KiB pages and aligned UMEM with 4 KiB chunks work;
other setups get -EOPNOTSUPP. A bind without XDP_ZEROCOPY then falls
back to copy mode, as before. The exception is a failed setup that
leaves an old page pool being destroyed. That page pool still uses
the DMA mapping, so the bind fails.

The provider reads the FILL ring in batches of the page-pool cache
refill size, and it handles RX need-wakeup. Each allocation reads at
most one batch, which limits the work spent on bad descriptors in
NAPI. Addresses outside the UMEM, and addresses that are already in
use, count as invalid descriptors and are dropped. refill_done keeps
NAPI scheduled while the FILL ring has entries. When the ring is
empty, it sets NEED_WAKEUP and then checks the ring once more.

The provider asks for page-sized buffers with the UMEM headroom plus
XDP_PACKET_HEADROOM. It refuses a page pool whose DMA sync range
goes past the chunk.

During a queue restart, two page pools can use one provider at the
same time. A provider lock protects the FILL ring, the reuse stack
and need-wakeup. Allocation takes it once per page-pool cache refill
of up to 64 buffers. A packet that is copied into a socket with a
provider takes it once per packet, because the copy also reads the
FILL ring.

A buffer has one owner at a time, as a normal page-pool page does.
Allocation claims a buffer by setting its page pool under the
provider lock. Release clears the link, so destroying the provider
does not need to scan the UMEM.

Generic XDP and synthetic RX queues, such as CPUMAP, would write to
the socket RX ring outside the queue's NAPI. While the provider is
installed, generic XDP drops such packets and counts them in
rx_dropped, and synthetic queues get -EINVAL. Classic zero-copy
sockets do not change.

A failed queue restart can leave the old page pool draining. Keep
the UMEM, the DMA mapping and the netdev until the provider's last
page pool is destroyed. Charge the provider arrays, whose size grows
with the UMEM, to the memory cgroup of the socket owner.
XDP_SOCKETS now selects PAGE_POOL.

Signed-off-by: Björn Töpel <bjorn@kernel.org>
---
 include/net/xdp_sock_drv.h  |  12 +
 include/net/xsk_buff_pool.h |   6 +-
 net/core/page_pool.c        |   4 +-
 net/xdp/Kconfig             |   1 +
 net/xdp/xsk.c               |  50 ++-
 net/xdp/xsk.h               |  58 ++++
 net/xdp/xsk_buff_pool.c     | 654 +++++++++++++++++++++++++++++++++++-
 7 files changed, 756 insertions(+), 29 deletions(-)

diff --git a/include/net/xdp_sock_drv.h b/include/net/xdp_sock_drv.h
index d94aeb506379..b9288f5dd48b 100644
--- a/include/net/xdp_sock_drv.h
+++ b/include/net/xdp_sock_drv.h
@@ -9,6 +9,8 @@
 #include <net/xdp_sock.h>
 #include <net/xsk_buff_pool.h>
 
+struct netlink_ext_ack;
+
 #define XDP_UMEM_MIN_CHUNK_SHIFT 11
 #define XDP_UMEM_MIN_CHUNK_SIZE (1 << XDP_UMEM_MIN_CHUNK_SHIFT)
 
@@ -28,6 +30,8 @@ void xsk_tx_completed(struct xsk_buff_pool *pool, u32 nb_entries);
 bool xsk_tx_peek_desc(struct xsk_buff_pool *pool, struct xdp_desc *desc);
 u32 xsk_tx_peek_release_desc_batch(struct xsk_buff_pool *pool, u32 max);
 void xsk_tx_release(struct xsk_buff_pool *pool);
+int xsk_pool_setup_page_pool(struct net_device *dev, struct xsk_buff_pool *pool,
+			     u16 queue_id, struct netlink_ext_ack *extack);
 struct xsk_buff_pool *xsk_get_pool_from_qid(struct net_device *dev,
 					    u16 queue_id);
 void xsk_set_rx_need_wakeup(struct xsk_buff_pool *pool);
@@ -370,6 +374,14 @@ static inline void xsk_tx_release(struct xsk_buff_pool *pool)
 {
 }
 
+static inline int xsk_pool_setup_page_pool(struct net_device *dev,
+					   struct xsk_buff_pool *pool,
+					   u16 queue_id,
+					   struct netlink_ext_ack *extack)
+{
+	return -EOPNOTSUPP;
+}
+
 static inline struct xsk_buff_pool *
 xsk_get_pool_from_qid(struct net_device *dev, u16 queue_id)
 {
diff --git a/include/net/xsk_buff_pool.h b/include/net/xsk_buff_pool.h
index 77264c4902c0..9eed8796a356 100644
--- a/include/net/xsk_buff_pool.h
+++ b/include/net/xsk_buff_pool.h
@@ -11,6 +11,7 @@
 #include <net/xdp.h>
 
 struct xsk_buff_pool;
+struct xsk_pp;
 struct xdp_rxq_info;
 struct xsk_cb_desc;
 struct xsk_queue;
@@ -52,7 +53,8 @@ struct xsk_buff_pool {
 	spinlock_t xsk_tx_list_lock;
 	refcount_t users;
 	struct xdp_umem *umem;
-	struct work_struct work;
+	struct xsk_pp *pp;
+	struct delayed_work work;
 	/* Protects generic receive in shared and non-shared umem mode. */
 	spinlock_t rx_lock;
 	struct list_head free_list;
@@ -117,10 +119,8 @@ int xp_alloc_tx_descs(struct xsk_buff_pool *pool, struct xdp_sock *xs,
 void xp_destroy(struct xsk_buff_pool *pool);
 void xp_get_pool(struct xsk_buff_pool *pool);
 bool xp_put_pool(struct xsk_buff_pool *pool);
-void xp_clear_dev(struct xsk_buff_pool *pool);
 void xp_add_xsk(struct xsk_buff_pool *pool, struct xdp_sock *xs);
 void xp_del_xsk(struct xsk_buff_pool *pool, struct xdp_sock *xs);
-
 /* AF_XDP, and XDP core. */
 void xp_free(struct xdp_buff_xsk *xskb);
 
diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index e36ae6123adf..1f446e9a10d7 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -1397,8 +1397,8 @@ void net_mp_release_page_pool_bulk(struct page_pool *pool,
 		atomic_add(count, release_cnt);
 }
 
-/* Disassociate a niov from a page pool. Should only be used in the
- * ->release_netmem() path.
+/* Disassociate a niov from a page pool. Memory providers may do this either
+ * from ->release_netmem() or from ->destroy() after all objects were released.
  */
 void net_mp_niov_clear_page_pool(struct net_iov *niov)
 {
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
diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index b68dda9c37d1..90c98b42a18a 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -464,7 +464,9 @@ static int xsk_rcv_check(struct xdp_sock *xs, struct xdp_buff *xdp, u32 len)
 static void xsk_flush(struct xdp_sock *xs)
 {
 	xskq_prod_submit(xs->rx);
-	__xskq_cons_release(xs->pool->fq);
+	/* Provider pools publish FILL consumption under the provider lock. */
+	if (!READ_ONCE(xs->pool->pp))
+		__xskq_cons_release(xs->pool->fq);
 	sock_def_readable(&xs->sk);
 }
 
@@ -474,16 +476,40 @@ int xsk_generic_rcv(struct xdp_sock *xs, struct xdp_buff *xdp)
 	int err;
 
 	err = xsk_rcv_check(xs, xdp, len);
-	if (!err) {
-		spin_lock_bh(&xs->pool->rx_lock);
-		err = __xsk_rcv(xs, xdp, len);
-		xsk_flush(xs);
+	if (err)
+		return err;
+	spin_lock_bh(&xs->pool->rx_lock);
+	if (unlikely(READ_ONCE(xs->pool->pp))) {
+		xs->rx_dropped++;
 		spin_unlock_bh(&xs->pool->rx_lock);
+		return -EOPNOTSUPP;
 	}
+	err = __xsk_rcv(xs, xdp, len);
+	xsk_flush(xs);
+	spin_unlock_bh(&xs->pool->rx_lock);
 
 	return err;
 }
 
+/* Copy into the socket's UMEM. A provider-backed pool shares its FILL ring
+ * with provider allocation, which can run for another page pool of the queue
+ * while the queue is replaced.
+ */
+static int xsk_rcv_copy(struct xdp_sock *xs, struct xdp_buff *xdp, u32 len)
+{
+	struct xsk_pp *provider = READ_ONCE(xs->pool->pp);
+	int err;
+
+	if (likely(!provider))
+		return __xsk_rcv(xs, xdp, len);
+
+	spin_lock_bh(&provider->lock);
+	err = __xsk_rcv(xs, xdp, len);
+	__xskq_cons_release(xs->pool->fq);
+	spin_unlock_bh(&provider->lock);
+	return err;
+}
+
 static int xsk_rcv(struct xdp_sock *xs, struct xdp_buff *xdp)
 {
 	u32 len = xdp_get_buff_len(xdp);
@@ -498,7 +524,15 @@ static int xsk_rcv(struct xdp_sock *xs, struct xdp_buff *xdp)
 		return xsk_rcv_zc(xs, xdp, len);
 	}
 
-	err = __xsk_rcv(xs, xdp, len);
+	/* The socket RX ring has a single producer, the queue's poll context.
+	 * Reject synthetic RX queues before their remote context produces
+	 * into a provider-backed socket.
+	 */
+	if (unlikely(READ_ONCE(xs->pool->pp) &&
+		     !xdp_rxq_info_is_reg(xdp->rxq)))
+		return -EINVAL;
+
+	err = xsk_rcv_copy(xs, xdp, len);
 	if (!err)
 		xdp_return_buff(xdp);
 	return err;
@@ -2149,8 +2183,8 @@ static int xsk_notifier(struct notifier_block *this,
 
 				xsk_unbind_dev(xs);
 
-				/* Clear device references. */
-				xp_clear_dev(xs->pool);
+				/* Unregister cannot hold a device reference. */
+				xp_clear_dev(xs->pool, XSK_POOL_CLEAR_FORCE);
 			}
 			mutex_unlock(&xs->mutex);
 		}
diff --git a/net/xdp/xsk.h b/net/xdp/xsk.h
index 7c811b5cce76..8770778cd322 100644
--- a/net/xdp/xsk.h
+++ b/net/xdp/xsk.h
@@ -4,6 +4,64 @@
 #ifndef XSK_H_
 #define XSK_H_
 
+#include <net/netmem.h>
+
+struct xsk_buff_pool;
+
+enum xsk_pool_clear_mode {
+	XSK_POOL_CLEAR_NORMAL,
+	XSK_POOL_CLEAR_FORCE,
+};
+
+struct xsk_pp_info {
+	struct net_iov_area area;
+	struct xsk_buff_pool *pool;
+	u32 chunk_shift;
+};
+
+/* Keep page_pool descriptors independent from direct-driver XSK buffers.
+ * Queue replacement creates the new page_pool before it stops the old queue
+ * and destroys the old page_pool after the new queue started, so two
+ * page_pools can use one provider. @lock serializes the state they share.
+ * Generic XDP cannot deliver to a provider-backed socket.
+ */
+struct xsk_pp {
+	struct xsk_pp_info info;
+	struct xsk_queue __rcu *fq;
+	/* FILL consumers, @reuse and RX need_wakeup state */
+	spinlock_t lock;
+	u32 reuse_cnt;
+	u32 nr_pools;
+	u64 chunk_mask;
+	u64 addrs_cnt;
+	u8 release_retries;
+	bool dma_need_sync;
+	bool detached;
+	u32 reuse[];
+};
+
+void xp_clear_dev(struct xsk_buff_pool *pool, enum xsk_pool_clear_mode mode);
+
+static inline bool xp_netmem_is_xsk(netmem_ref netmem)
+{
+	return netmem_is_net_iov(netmem) &&
+	       netmem_to_net_iov(netmem)->type == NET_IOV_XSK;
+}
+
+static inline struct xsk_pp_info *xp_netmem_to_pp(netmem_ref netmem)
+{
+	struct net_iov *niov = netmem_to_net_iov(netmem);
+
+	return container_of(net_iov_owner(niov), struct xsk_pp_info, area);
+}
+
+static inline bool xp_netmem_is_from_pool(netmem_ref netmem,
+					  const struct xsk_buff_pool *pool)
+{
+	return xp_netmem_is_xsk(netmem) &&
+	       xp_netmem_to_pp(netmem)->pool == pool;
+}
+
 struct xdp_ring_offset_v1 {
 	__u64 producer;
 	__u64 consumer;
diff --git a/net/xdp/xsk_buff_pool.c b/net/xdp/xsk_buff_pool.c
index 244776a72961..e25347f8c208 100644
--- a/net/xdp/xsk_buff_pool.c
+++ b/net/xdp/xsk_buff_pool.c
@@ -1,7 +1,11 @@
 // SPDX-License-Identifier: GPL-2.0
 
 #include <linux/netdevice.h>
+#include <linux/sizes.h>
 #include <net/netdev_lock.h>
+#include <net/netdev_queues.h>
+#include <net/netdev_rx_queue.h>
+#include <net/page_pool/helpers.h>
 #include <net/page_pool/memory_provider.h>
 #include <net/xsk_buff_pool.h>
 #include <net/xdp_sock.h>
@@ -12,6 +16,20 @@
 #include "xsk.h"
 
 #define ETH_PAD_LEN (ETH_HLEN + 2 * VLAN_HLEN  + ETH_FCS_LEN)
+#define XSK_PAGE_POOL_DMA_ATTR	(DMA_ATTR_WEAK_ORDERING | \
+				 DMA_ATTR_SKIP_CPU_SYNC)
+#define XSK_POOL_RELEASE_RETRY_MAX	(60 * HZ)
+
+static bool xp_pp_teardown(struct xsk_buff_pool *pool);
+static void xp_pp_retry_release(struct xsk_buff_pool *pool);
+static void xp_destroy_unbound_deferred(struct work_struct *work);
+
+static void __xp_destroy(struct xsk_buff_pool *pool)
+{
+	kvfree(pool->tx_descs);
+	kvfree(pool->heads);
+	kvfree(pool);
+}
 
 void xp_add_xsk(struct xsk_buff_pool *pool, struct xdp_sock *xs)
 {
@@ -38,9 +56,22 @@ void xp_destroy(struct xsk_buff_pool *pool)
 	if (!pool)
 		return;
 
-	kvfree(pool->tx_descs);
-	kvfree(pool->heads);
-	kvfree(pool);
+	/* A failed queue replacement can leave a page_pool waiting for an
+	 * in-flight buffer.  Keep the UMEM and pool alive until its provider
+	 * destroy callback has run.
+	 */
+	if (pool->pp) {
+		rcu_assign_pointer(pool->pp->fq, NULL);
+		WRITE_ONCE(pool->fq, NULL);
+		WRITE_ONCE(pool->cq, NULL);
+		synchronize_net();
+		xdp_get_umem(pool->umem);
+		INIT_DELAYED_WORK(&pool->work, xp_destroy_unbound_deferred);
+		schedule_delayed_work(&pool->work, 0);
+		return;
+	}
+
+	__xp_destroy(pool);
 }
 
 int xp_alloc_tx_descs(struct xsk_buff_pool *pool, struct xdp_sock *xs,
@@ -167,6 +198,7 @@ int xp_assign_dev(struct xsk_buff_pool *pool,
 {
 	u32 needed = netdev->mtu + ETH_PAD_LEN;
 	u32 segs = netdev->xdp_zc_max_segs;
+	bool old_zc = pool->umem->zc;
 	bool mbuf = flags & XDP_USE_SG;
 	bool force_zc, force_copy;
 	struct netdev_bpf bpf;
@@ -250,23 +282,35 @@ int xp_assign_dev(struct xsk_buff_pool *pool,
 	if (err)
 		goto err_unreg_pool;
 
+	/* Record the successful driver install before validating its result so
+	 * the error path can issue the matching XDP_SETUP_XSK_POOL teardown.
+	 */
+	pool->umem->zc = true;
 	if (!pool->dma_pages) {
 		WARN(1, "Driver did not DMA map zero-copy buffers");
 		err = -EINVAL;
 		goto err_unreg_xsk;
 	}
-	pool->umem->zc = true;
 	pool->xdp_zc_max_segs = netdev->xdp_zc_max_segs;
 	return 0;
 
 err_unreg_xsk:
 	xp_disable_drv_zc(pool);
+	if (pool->pp)
+		pool->pp->detached = true;
+	pool->umem->zc = old_zc;
 err_unreg_pool:
-	if (!force_zc)
+	/* A provider whose page_pool destruction was deferred still owns the
+	 * DMA mapping.  Do not turn that failed zero-copy setup into copy mode.
+	 */
+	if (!force_zc && !pool->pp)
 		err = 0; /* fallback to copy mode */
 	if (err) {
 		xsk_clear_pool_at_qid(netdev, queue_id);
-		dev_put(netdev);
+		if (!pool->pp) {
+			pool->netdev = NULL;
+			dev_put(netdev);
+		}
 	}
 	return err;
 }
@@ -288,29 +332,75 @@ int xp_assign_dev_shared(struct xsk_buff_pool *pool, struct xdp_sock *umem_xs,
 	return xp_assign_dev(pool, dev, queue_id, flags);
 }
 
-void xp_clear_dev(struct xsk_buff_pool *pool)
+static void xp_pp_force_dma_unmap(struct xsk_buff_pool *pool)
+{
+	if (!pool->dma_map)
+		return;
+
+	pool->dma_map->netdev = NULL;
+	xsk_pool_dma_unmap(pool, XSK_PAGE_POOL_DMA_ATTR);
+}
+
+void xp_clear_dev(struct xsk_buff_pool *pool, enum xsk_pool_clear_mode mode)
 {
 	struct net_device *netdev = pool->netdev;
+	struct xsk_pp *provider = pool->pp;
 
-	if (!pool->netdev)
+	if (!netdev)
 		return;
+	/* Keep this reference after a normal detach. It keeps the netdev
+	 * identity stable for shared DMA-map lookup and lets unregister
+	 * invalidate that mapping while the old page_pool drains.
+	 */
+	if (provider && provider->detached) {
+		if (mode != XSK_POOL_CLEAR_FORCE)
+			return;
+		xp_pp_force_dma_unmap(pool);
+		pool->netdev = NULL;
+		dev_put(netdev);
+		return;
+	}
 
 	netdev_lock_ops(netdev);
 	xp_disable_drv_zc(pool);
 	xsk_clear_pool_at_qid(pool->netdev, pool->queue_id);
-	pool->netdev = NULL;
+	if (provider) {
+		provider->detached = true;
+		if (mode == XSK_POOL_CLEAR_FORCE) {
+			xp_pp_force_dma_unmap(pool);
+			pool->netdev = NULL;
+		}
+	} else {
+		pool->netdev = NULL;
+	}
 	netdev_unlock_ops(netdev);
-	dev_put(netdev);
+
+	if (!provider || mode == XSK_POOL_CLEAR_FORCE)
+		dev_put(netdev);
 }
 
 static void xp_release_deferred(struct work_struct *work)
 {
-	struct xsk_buff_pool *pool = container_of(work, struct xsk_buff_pool,
-						  work);
+	struct net_device *netdev = NULL;
+	struct xsk_buff_pool *pool;
+	bool teardown_done;
+
+	pool = container_of(to_delayed_work(work), struct xsk_buff_pool, work);
 
 	rtnl_lock();
-	xp_clear_dev(pool);
+	xp_clear_dev(pool, XSK_POOL_CLEAR_NORMAL);
+	teardown_done = xp_pp_teardown(pool);
+	if (teardown_done && pool->netdev) {
+		netdev = pool->netdev;
+		pool->netdev = NULL;
+	}
 	rtnl_unlock();
+	if (!teardown_done) {
+		xp_pp_retry_release(pool);
+		return;
+	}
+	if (netdev)
+		dev_put(netdev);
 
 	if (pool->fq) {
 		xskq_destroy(pool->fq);
@@ -323,7 +413,7 @@ static void xp_release_deferred(struct work_struct *work)
 	}
 
 	xdp_put_umem(pool->umem, false);
-	xp_destroy(pool);
+	__xp_destroy(pool);
 }
 
 void xp_get_pool(struct xsk_buff_pool *pool)
@@ -337,8 +427,8 @@ bool xp_put_pool(struct xsk_buff_pool *pool)
 		return false;
 
 	if (refcount_dec_and_test(&pool->users)) {
-		INIT_WORK(&pool->work, xp_release_deferred);
-		schedule_work(&pool->work);
+		INIT_DELAYED_WORK(&pool->work, xp_release_deferred);
+		schedule_delayed_work(&pool->work, 0);
 		return true;
 	}
 
@@ -514,6 +604,538 @@ int xp_dma_map(struct xsk_buff_pool *pool, struct device *dev,
 }
 EXPORT_SYMBOL(xp_dma_map);
 
+static void xp_pp_free(struct xsk_buff_pool *pool)
+{
+	struct xsk_pp *provider = pool->pp;
+	u32 idx;
+
+	if (!provider)
+		return;
+	if (WARN_ON_ONCE(READ_ONCE(provider->nr_pools)))
+		return;
+
+	/* A failed queue install may have consumed FILL entries before the
+	 * replacement queue failed to start. Preserve those frames for the
+	 * direct or copy-mode allocator selected by bind fallback.
+	 */
+	while (provider->reuse_cnt) {
+		idx = provider->reuse[--provider->reuse_cnt];
+		xp_free(&pool->heads[idx]);
+	}
+
+	spin_lock_bh(&pool->rx_lock);
+	WRITE_ONCE(pool->pp, NULL);
+	spin_unlock_bh(&pool->rx_lock);
+	kvfree(provider->info.area.niovs);
+	kvfree(provider);
+}
+
+static bool xp_pp_teardown(struct xsk_buff_pool *pool)
+{
+	struct xsk_pp *provider = pool->pp;
+	u32 busy;
+
+	if (!provider)
+		return true;
+	if (WARN_ON_ONCE(!provider->detached))
+		return false;
+	/* xp_pp_destroy() touches the provider until it drops the lock. */
+	spin_lock_bh(&provider->lock);
+	busy = provider->nr_pools;
+	spin_unlock_bh(&provider->lock);
+	if (busy)
+		return false;
+
+	xsk_pool_dma_unmap(pool, XSK_PAGE_POOL_DMA_ATTR);
+	xp_pp_free(pool);
+
+	return true;
+}
+
+static void xp_pp_retry_release(struct xsk_buff_pool *pool)
+{
+	struct xsk_pp *provider = pool->pp;
+	unsigned long delay = HZ;
+	u8 retries;
+
+	if (provider) {
+		retries = provider->release_retries;
+		if (retries < 6)
+			provider->release_retries++;
+		delay = min_t(unsigned long, HZ << retries,
+			      XSK_POOL_RELEASE_RETRY_MAX);
+	}
+	schedule_delayed_work(&pool->work, delay);
+}
+
+static void xp_destroy_unbound_deferred(struct work_struct *work)
+{
+	struct xsk_buff_pool *pool;
+	struct net_device *netdev;
+
+	pool = container_of(to_delayed_work(work), struct xsk_buff_pool, work);
+
+	rtnl_lock();
+	if (!xp_pp_teardown(pool)) {
+		rtnl_unlock();
+		xp_pp_retry_release(pool);
+		return;
+	}
+	netdev = pool->netdev;
+	pool->netdev = NULL;
+	rtnl_unlock();
+
+	if (netdev)
+		dev_put(netdev);
+	xdp_put_umem(pool->umem, false);
+	__xp_destroy(pool);
+}
+
+static struct xsk_pp *xp_pp_create(struct xsk_buff_pool *pool)
+{
+	struct xsk_pp *provider;
+	struct net_iov *niov;
+	dma_addr_t dma;
+	u64 addr;
+	u32 i;
+
+	/* The provider arrays scale with the UMEM; charge them like it. */
+	provider = kvzalloc_flex(*provider, reuse, pool->heads_cnt,
+				 GFP_KERNEL_ACCOUNT);
+	if (!provider)
+		return ERR_PTR(-ENOMEM);
+
+	provider->info.area.niovs =
+		kvzalloc_objs(*provider->info.area.niovs, pool->heads_cnt,
+			      GFP_KERNEL_ACCOUNT);
+	if (!provider->info.area.niovs) {
+		kvfree(provider);
+		return ERR_PTR(-ENOMEM);
+	}
+	provider->info.pool = pool;
+	RCU_INIT_POINTER(provider->fq, pool->fq);
+	spin_lock_init(&provider->lock);
+	provider->info.area.num_niovs = pool->heads_cnt;
+	provider->info.area.vaddr = pool->addrs;
+	provider->info.area.niov_shift = pool->chunk_shift;
+	provider->chunk_mask = pool->chunk_mask;
+	provider->addrs_cnt = pool->addrs_cnt;
+	provider->info.chunk_shift = pool->chunk_shift;
+	provider->dma_need_sync = dma_dev_need_sync(pool->dev);
+
+	for (i = 0; i < provider->info.area.num_niovs; i++) {
+		niov = &provider->info.area.niovs[i];
+		addr = (u64)i << provider->info.chunk_shift;
+		dma = (pool->dma_pages[addr >> PAGE_SHIFT] &
+		       ~XSK_NEXT_PG_CONTIG_MASK) + (addr & ~PAGE_MASK);
+
+		net_iov_init(niov, &provider->info.area, NET_IOV_XSK);
+		if (net_mp_niov_set_dma_addr(niov, dma))
+			goto err_free_niovs;
+	}
+
+	/* Exclude generic receive. It can run on another CPU after RPS and
+	 * would produce into the socket RX ring, which provider delivery
+	 * fills without a lock from the queue's poll context.
+	 */
+	spin_lock_bh(&pool->rx_lock);
+	WRITE_ONCE(pool->pp, provider);
+	spin_unlock_bh(&pool->rx_lock);
+	return provider;
+
+err_free_niovs:
+	kvfree(provider->info.area.niovs);
+	kvfree(provider);
+	return ERR_PTR(-ERANGE);
+}
+
+static int xp_pp_init(struct page_pool *pp)
+{
+	struct xsk_buff_pool *pool = pp->mp_priv;
+	struct xsk_pp *provider = pool->pp;
+	int err = 0;
+
+	if (!provider || !pool->dma_pages)
+		return -EINVAL;
+	if (pp->p.order)
+		return -E2BIG;
+	if (pp->p.dev != pool->dev ||
+	    pp->p.dma_dir != DMA_BIDIRECTIONAL)
+		return -EINVAL;
+	/* Each object is one UMEM chunk. Syncs and device writes described by
+	 * the page_pool must stay inside it.
+	 */
+	if (pp->p.offset + pp->p.max_len > pool->chunk_size)
+		return -EINVAL;
+
+	spin_lock_bh(&provider->lock);
+	if (provider->detached)
+		err = -ENODEV;
+	else
+		provider->nr_pools++;
+	spin_unlock_bh(&provider->lock);
+
+	return err;
+}
+
+static void xp_pp_destroy(struct page_pool *pp)
+{
+	struct xsk_buff_pool *pool = pp->mp_priv;
+	struct xsk_pp *provider = pool->pp;
+
+	/* Every object the page_pool held was released through
+	 * xp_pp_release_netmem() or handed to userspace, both of which clear
+	 * its page_pool association.
+	 */
+	spin_lock_bh(&provider->lock);
+	if (!WARN_ON_ONCE(!provider->nr_pools))
+		provider->nr_pools--;
+	spin_unlock_bh(&provider->lock);
+}
+
+static netmem_ref xp_pp_prepare_netmem(struct page_pool *pp,
+				       struct xsk_pp *provider,
+				       struct net_iov *niov)
+{
+	netmem_ref netmem = net_iov_to_netmem(niov);
+	dma_addr_t dma = page_pool_get_dma_addr_netmem(netmem);
+
+	if (provider->dma_need_sync)
+		dma_sync_single_range_for_device(pp->p.dev, dma,
+						 pp->p.offset, pp->p.max_len,
+						 pp->p.dma_dir);
+
+	return netmem;
+}
+
+/* A set pp marks an object a page pool owns. Repeated FILL addresses must
+ * not hand it out twice.
+ */
+static bool xp_pp_claim(struct page_pool *pp, struct net_iov *niov)
+{
+	if (unlikely(niov->desc.pp))
+		return false;
+
+	niov->desc.pp = pp;
+	return true;
+}
+
+static unsigned int
+xp_pp_alloc_reused(struct page_pool *pp, struct xsk_pp *provider,
+		   netmem_ref *netmems, unsigned int max)
+{
+	unsigned int entries;
+	unsigned int allocated = 0;
+	struct net_iov *niov;
+	unsigned int i;
+	u32 idx;
+
+	entries = min(max, provider->reuse_cnt);
+	for (i = 0; i < entries; i++) {
+		idx = provider->reuse[--provider->reuse_cnt];
+		niov = &provider->info.area.niovs[idx];
+		if (xp_pp_claim(pp, niov))
+			netmems[allocated++] = net_iov_to_netmem(niov);
+	}
+
+	/* page_pool normally synced these buffers before ->release_netmem(),
+	 * but page_pool teardown disables DMA sync before emptying its caches.
+	 * Conservatively prepare both reuse and FQ buffers below.
+	 */
+	return allocated;
+}
+
+static unsigned int xp_pp_alloc_fq(struct page_pool *pp,
+				   struct xsk_pp *provider,
+				   netmem_ref *netmems, unsigned int max)
+{
+	struct xsk_buff_pool *pool = provider->info.pool;
+	struct xsk_queue *fq;
+	struct net_iov *niov;
+	u64 addr;
+	unsigned int allocated = 0;
+	u32 cached_cons, entries;
+	u32 cons, idx;
+	u32 i;
+
+	rcu_read_lock_bh();
+	fq = rcu_dereference_bh(provider->fq);
+	if (!fq)
+		goto out;
+
+	entries = xskq_cons_nb_entries(fq, max);
+	if (!entries && pool->uses_need_wakeup) {
+		/* Publish NEED_WAKEUP before checking again. */
+		xsk_set_rx_need_wakeup(pool);
+		/* Pair the publication with the producer recheck. */
+		smp_mb();
+		entries = xskq_cons_nb_entries(fq, max);
+	}
+	if (!entries) {
+		fq->queue_empty_descs++;
+		goto out;
+	}
+
+	cached_cons = fq->cached_cons;
+	for (i = 0; i < entries; i++) {
+		cons = cached_cons++;
+		__xskq_cons_read_addr_unchecked(fq, cons, &addr);
+		addr &= provider->chunk_mask;
+		if (unlikely(addr >= provider->addrs_cnt)) {
+			fq->invalid_descs++;
+			continue;
+		}
+
+		idx = addr >> provider->info.chunk_shift;
+		niov = &provider->info.area.niovs[idx];
+		if (unlikely(!xp_pp_claim(pp, niov))) {
+			fq->invalid_descs++;
+			continue;
+		}
+		netmems[allocated++] = net_iov_to_netmem(niov);
+	}
+
+	xskq_cons_release_n(fq, entries);
+	__xskq_cons_release(fq);
+out:
+	rcu_read_unlock_bh();
+	return allocated;
+}
+
+static netmem_ref xp_pp_alloc_netmems(struct page_pool *pp, gfp_t gfp)
+{
+	struct xsk_buff_pool *pool = pp->mp_priv;
+	struct xsk_pp *provider = pool->pp;
+	netmem_ref *netmems = pp->alloc.cache;
+	unsigned int allocated;
+	unsigned int i;
+
+	if (WARN_ON_ONCE(pp->alloc.count))
+		return 0;
+
+	/* One lock round trip refills a whole page_pool allocation cache. */
+	spin_lock_bh(&provider->lock);
+	allocated = xp_pp_alloc_reused(pp, provider, netmems,
+				       PP_ALLOC_CACHE_REFILL);
+	if (allocated < PP_ALLOC_CACHE_REFILL)
+		allocated += xp_pp_alloc_fq(pp, provider, netmems + allocated,
+					    PP_ALLOC_CACHE_REFILL - allocated);
+	spin_unlock_bh(&provider->lock);
+	if (!allocated)
+		return 0;
+
+	/* The selected netmems now belong to @pp alone. Finish DMA and
+	 * page-pool setup without the lock before the driver sees them.
+	 */
+	for (i = 0; i < allocated; i++) {
+		struct net_iov *niov = netmem_to_net_iov(netmems[i]);
+
+		netmems[i] = xp_pp_prepare_netmem(pp, provider, niov);
+	}
+	net_mp_netmem_set_page_pool_bulk(pp, netmems, allocated);
+
+	allocated--;
+	pp->alloc.count = allocated;
+	return netmems[allocated];
+}
+
+static bool xp_pp_release_netmem(struct page_pool *pp, netmem_ref netmem)
+{
+	struct xsk_buff_pool *pool = pp->mp_priv;
+	struct xsk_pp *provider = pool->pp;
+	struct net_iov *niov = netmem_to_net_iov(netmem);
+	u32 idx = net_iov_idx(niov);
+
+	/* page_pool calls this on ptr_ring overflow and from its destroy and
+	 * release-retry paths, which can run while another page_pool of this
+	 * provider allocates. Clear the association before the object becomes
+	 * visible to that page_pool.
+	 */
+	net_mp_niov_clear_page_pool(niov);
+	spin_lock_bh(&provider->lock);
+	if (likely(provider->reuse_cnt < provider->info.area.num_niovs))
+		provider->reuse[provider->reuse_cnt++] = idx;
+	spin_unlock_bh(&provider->lock);
+
+	return false;
+}
+
+static bool xp_pp_refill_done(struct page_pool *pp, bool full)
+{
+	struct xsk_buff_pool *pool = pp->mp_priv;
+	struct xsk_pp *provider = pool->pp;
+	bool need_wakeup = pool->uses_need_wakeup;
+	struct xsk_queue *fq;
+	bool pending;
+
+	if (likely(full) &&
+	    (!need_wakeup || !(pool->cached_need_wakeup & XDP_WAKEUP_RX)))
+		return true;
+
+	spin_lock_bh(&provider->lock);
+	fq = rcu_dereference_bh(provider->fq);
+	if (!fq) {
+		spin_unlock_bh(&provider->lock);
+		return true;
+	}
+
+	if (full) {
+		if (need_wakeup)
+			xsk_clear_rx_need_wakeup(pool);
+		spin_unlock_bh(&provider->lock);
+		return true;
+	}
+
+	pending = xskq_cons_nb_entries(fq, 1);
+	if (!pending && need_wakeup) {
+		xsk_set_rx_need_wakeup(pool);
+		smp_mb(); /* Order NEED_WAKEUP before the producer recheck. */
+		pending = xskq_cons_nb_entries(fq, 1);
+	}
+	spin_unlock_bh(&provider->lock);
+
+	return pending ? false : need_wakeup;
+}
+
+static int xp_pp_nl_fill(void *mp_priv, struct sk_buff *rsp,
+			 struct netdev_rx_queue *rxq)
+{
+	return 0;
+}
+
+static void xp_pp_uninstall(void *mp_priv, struct netdev_rx_queue *rxq)
+{
+	struct xsk_buff_pool *pool = mp_priv;
+	struct xsk_pp *provider = pool->pp;
+	struct net_device *netdev = pool->netdev;
+
+	if (!netdev)
+		goto clear_rxq;
+
+	/* Unregister uninstalls providers before the AF_XDP notifier runs. */
+	xsk_clear_pool_at_qid(netdev, pool->queue_id);
+	if (provider)
+		provider->detached = true;
+	else
+		WARN_ON_ONCE(1);
+	if (pool->dma_map) {
+		pool->dma_map->netdev = NULL;
+		xsk_pool_dma_unmap(pool, XSK_PAGE_POOL_DMA_ATTR);
+	}
+	pool->netdev = NULL;
+	dev_put(netdev);
+
+clear_rxq:
+	/* Existing page_pools retain their private pool pointer until their
+	 * deferred destruction; the device queue is no longer operational.
+	 */
+	memset(&rxq->mp_params, 0, sizeof(rxq->mp_params));
+}
+
+static const struct memory_provider_ops xsk_pp_ops = {
+	.init			= xp_pp_init,
+	.destroy		= xp_pp_destroy,
+	.alloc_netmems		= xp_pp_alloc_netmems,
+	.release_netmem		= xp_pp_release_netmem,
+	.refill_done		= xp_pp_refill_done,
+	.nl_fill		= xp_pp_nl_fill,
+	.uninstall		= xp_pp_uninstall,
+	.caps			= MP_CAP_READABLE,
+};
+
+static int xsk_pool_validate_page_pool(struct xsk_buff_pool *pool,
+				       struct netlink_ext_ack *extack)
+{
+	if (PAGE_SIZE != SZ_4K) {
+		NL_SET_ERR_MSG(extack,
+			       "page pool UMEM requires 4 KiB base pages");
+		return -EOPNOTSUPP;
+	}
+	if (pool->unaligned) {
+		NL_SET_ERR_MSG(extack,
+			       "page pool UMEM requires aligned chunks");
+		return -EOPNOTSUPP;
+	}
+	/* Each provider object represents one complete UMEM chunk. */
+	if (pool->chunk_size != PAGE_SIZE) {
+		NL_SET_ERR_MSG(extack,
+			       "page pool UMEM requires page-sized chunks");
+		return -EOPNOTSUPP;
+	}
+
+	return 0;
+}
+
+int xsk_pool_setup_page_pool(struct net_device *dev, struct xsk_buff_pool *pool,
+			     u16 queue_id, struct netlink_ext_ack *extack)
+{
+	struct xsk_pp *provider;
+	struct device *dma_dev;
+	struct pp_memory_provider_params mp = {
+		.mp_ops = &xsk_pp_ops,
+	};
+	int err;
+
+	ASSERT_RTNL();
+
+	if (!pool) {
+		pool = xsk_get_pool_from_qid(dev, queue_id);
+		if (!pool)
+			return -EINVAL;
+
+		mp.mp_priv = pool;
+		netif_mp_close_rxq(dev, queue_id, &mp);
+		return 0;
+	}
+	if (xsk_get_pool_from_qid(dev, queue_id) != pool) {
+		NL_SET_ERR_MSG(extack,
+			       "designated queue has no matching XSK pool");
+		return -EINVAL;
+	}
+	err = xsk_pool_validate_page_pool(pool, extack);
+	if (err)
+		return err;
+
+	dma_dev = netdev_queue_get_dma_dev(dev, queue_id,
+					   NETDEV_QUEUE_TYPE_RX);
+	if (!dma_dev) {
+		NL_SET_ERR_MSG(extack, "RX queue has no DMA device");
+		return -EOPNOTSUPP;
+	}
+
+	err = xsk_pool_dma_map(pool, dma_dev, XSK_PAGE_POOL_DMA_ATTR);
+	if (err)
+		return err;
+
+	provider = xp_pp_create(pool);
+	if (IS_ERR(provider)) {
+		err = PTR_ERR(provider);
+		goto err_unmap;
+	}
+
+	mp.mp_priv = pool;
+	mp.rx_page_size = pool->chunk_size;
+	mp.rx_headroom = xsk_pool_get_headroom(pool);
+	err = netif_mp_open_rxq(dev, queue_id, &mp, extack);
+	if (err)
+		goto err_free_provider;
+
+	return 0;
+
+err_free_provider:
+	provider->detached = true;
+	/* A deferred page_pool destroy keeps pool->pp installed. That state
+	 * suppresses copy-mode fallback in xp_assign_dev(), while xp_destroy()
+	 * keeps the UMEM alive until the provider destroy callback completes.
+	 */
+	xp_pp_teardown(pool);
+	return err;
+err_unmap:
+	xsk_pool_dma_unmap(pool, XSK_PAGE_POOL_DMA_ATTR);
+	return err;
+}
+EXPORT_SYMBOL_GPL(xsk_pool_setup_page_pool);
+
 static bool xp_addr_crosses_non_contig_pg(struct xsk_buff_pool *pool,
 					  u64 addr)
 {
-- 
2.55.0

