Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794306108;
	b=GqsUyILdkfU1qDV0rkJnfQJmwspaLBTU2lX+5wW3KsMYC2oZWDnH79UlrQ9yu/dzoOHP
	 v4jKc1boGa2STvHt/4FPYrJW7xM/3UCfFlwFIMYgb0mjNeNTgm+DXyBMCemZnf0PVCTNs
	 V8k9boRqR9n/KZr6m+ls1PvcO6EdqEy+AFiU3UyTusd9YcF6eLEIeD8CXT/ruVOeVytHq
	 NrMx2WvsHietHmybi7KOki1f60oa3hiP5Bpz3olrn4eSZX5cLS2BBauJTEOAnTQ6wfuPv
	 rBLGc4E3//4tNq6nznH5qmh9RzU+WMBueJRNaTuwL+VcIUEYXEkKArclr9osFrkpopQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794306108;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=66CVXLPdSuOq1X5AAPjRfsou8hH5OizS/Qalj5QJ79M=;
	b=qm3mjlRxm0UEUpEAJrSZqnAdL8yBAUyicTSRpWwOP5VbEEUCHe1nWUIIDZmIodxjwIIB
	 jnUyxYqw4ZCVpKAdVjAMnGsv3FgBFmWh8PZTdqC+hhy+YtFDsWeLPDEJfRNaOIOEK+6hX
	 wUmhpPBxDA9Zv3qFk5ZTgod82JsKGmniEDK9wsq185wd/df8ZzeM8jY7SK7Zk0jL5wxDZ
	 N6MF0f9ZSYs89Wv67KMVwwEBZxIhGlrz1HZ5S7leDZrCPZHKqCQwhCOJWQThI4k0IG1yL
	 +5/6EZlpMFS1RkUo5VAjn65IBapDCdUmd9RENXu36jkUblrXKoCdmlnCg50NBYvlnZg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Tat1ud0r;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4A4E606B9B8;
	Tue, 10 Nov 2026 10:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Tat1ud0r
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A21DA1F0089F;
	Tue, 10 Nov 2026 10:21:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794306107;
	bh=66CVXLPdSuOq1X5AAPjRfsou8hH5OizS/Qalj5QJ79M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Tat1ud0rt0l5W7U3hDBcHTuuP/pqwFUemjcq182xdCMj2JKor4k1DWhzm2nb6iNr3
	 JqNFb3OK0xs6y8x5ePSTXmk1JK/Rv8mygXdm9FQVflgqSRbYhjMrMag9seNsBrKRZq
	 L6pYY8bzgnk0RDielX+HPlk7OCPCKVWIBcGllw8n0r8/P6Him8gx2SUBfm7UCdD0UP
	 hqJ1AWgwmClj4CKO56yr+N7JzkxzQkGtqdZgYmQx1NCR2EA+LXm8VCB6/x7eDon4ap
	 7YYmIUEcNXzcOZW6P+0gWssz6BQhPRPPiYYxU7T3YRi8uE9LpDOgHFLPGpig++Kn99
	 V5AYm5jJOMQmw==
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
Subject: [PATCH net-next v1 06/11] page_pool: Coordinate refill with memory providers
Date: Tue, 10 Nov 2026 11:20:27 +0100
Message-ID: <20261110102039.1002605-7-bjorn@kernel.org>
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

A UMEM has a fixed number of chunks. When a refill finds none, and the
chunks come back later, nothing schedules the queue again: RX stalls.
Kicks after each queue operation are easy to miss.

Drivers report the end of each refill with page_pool_refill_done().
The provider then asks for another poll, or wakes the queue later
through the NAPI that the core publishes while the queue runs. Socket
wakeups use that NAPI too, so such drivers need no ndo_xsk_wakeup.

With XDP_USE_NEED_WAKEUP, the FILL flag stays set: a flag set only
when starved can miss an entry posted at the same time.

Signed-off-by: Björn Töpel <bjorn@kernel.org>
---
 Documentation/networking/netmem.rst     | 10 +++
 include/net/netdev_rx_queue.h           |  6 ++
 include/net/page_pool/helpers.h         | 24 ++++++
 include/net/page_pool/memory_provider.h |  2 +
 include/net/page_pool/types.h           |  6 ++
 net/core/dev.c                          |  4 +
 net/core/dev.h                          |  4 +
 net/core/netdev_rx_queue.c              | 97 ++++++++++++++++++++++++-
 net/xdp/xsk.c                           |  4 +
 net/xdp/xsk.h                           |  1 +
 net/xdp/xsk_pp.c                        | 73 ++++++++++++++++++-
 11 files changed, 226 insertions(+), 5 deletions(-)

diff --git a/Documentation/networking/netmem.rst b/Documentation/networking/netmem.rst
index 39cb75339704..74c73d7d126e 100644
--- a/Documentation/networking/netmem.rst
+++ b/Documentation/networking/netmem.rst
@@ -136,6 +136,16 @@ Driver RX Requirements
    circulation times, such as when userspace holds a reference in zerocopy
    scenarios.
 
+8. After each RX ring refill, call page_pool_refill_done() once per page
+   pool, with PP_REFILL_FULL only if all rings that use the pool are full.
+   Rings of a queue that take buffers from one such provider share one
+   page pool. Keep buffers in each of them, first in a ring that every
+   packet needs, like a header ring, so that a provider with few buffers
+   does not leave them all in one ring. If the call returns false, poll
+   again soon, for example by returning the full NAPI budget. Register the
+   NAPI of each RX queue with netif_queue_set_napi(); the core schedules
+   it when provider buffers become available.
+
 Driver TX Requirements
 ======================
 
diff --git a/include/net/netdev_rx_queue.h b/include/net/netdev_rx_queue.h
index 989120cbf452..ca12cbf7b825 100644
--- a/include/net/netdev_rx_queue.h
+++ b/include/net/netdev_rx_queue.h
@@ -33,6 +33,12 @@ struct netdev_rx_queue {
 	struct pp_memory_provider_params mp_params;
 	/* stamps the page pools of each queue allocation */
 	u32				mp_gen;
+	/* NAPI of the running queue, for memory provider wakeups. Set while
+	 * mp_armed, and if the provider has a refill_done op. Written under
+	 * the ops lock, read under RCU, see netif_mp_wake().
+	 */
+	struct napi_struct __rcu	*mp_napi;
+	bool				mp_armed;
 
 	/* If a queue is leased, then the lease pointer is always
 	 * valid. From the physical device it points to the virtual
diff --git a/include/net/page_pool/helpers.h b/include/net/page_pool/helpers.h
index 96e6b62cdebb..245a904e0b2b 100644
--- a/include/net/page_pool/helpers.h
+++ b/include/net/page_pool/helpers.h
@@ -523,6 +523,30 @@ static inline bool page_pool_is_unreadable(struct page_pool *pool)
 	return pool->mp_ops && !(pool->mp_ops->caps & MP_CAP_READABLE);
 }
 
+/**
+ * page_pool_refill_done() - report the end of an RX ring refill
+ * @pool: page pool of the rings
+ * @state: whether all rings that take buffers from @pool are full
+ *
+ * A memory provider with a fixed set of buffers must know when the rings
+ * are full, and when they wait for buffers. Call this once per page pool
+ * after each refill, also when the rings were full already.
+ *
+ * Context: the NAPI poll that allocates from @pool, or the driver while that
+ * NAPI is disabled, with IRQs enabled.
+ * Return: true if the refill is done, false if NAPI should retry it soon.
+ */
+static inline bool page_pool_refill_done(struct page_pool *pool,
+					 enum pp_refill state)
+{
+	const struct memory_provider_ops *ops = pool->mp_ops;
+
+	if (ops && ops->refill_done)
+		return ops->refill_done(pool, state);
+
+	return true;
+}
+
 /**
  * page_pool_supports_frag() - may page pool buffers be split
  * @pool: queried page pool
diff --git a/include/net/page_pool/memory_provider.h b/include/net/page_pool/memory_provider.h
index e732b21be9a2..daec73c9dcee 100644
--- a/include/net/page_pool/memory_provider.h
+++ b/include/net/page_pool/memory_provider.h
@@ -42,6 +42,7 @@ struct memory_provider_ops {
 	int (*nl_fill)(void *mp_priv, struct sk_buff *rsp,
 		       struct netdev_rx_queue *rxq);
 	void (*uninstall)(void *mp_priv, struct netdev_rx_queue *rxq);
+	bool (*refill_done)(struct page_pool *pool, enum pp_refill state);
 	u32 caps;
 };
 
@@ -55,6 +56,7 @@ int netif_mp_open_rxq(struct net_device *dev, unsigned int rxq_idx,
 int netif_mp_close_rxq(struct net_device *dev, unsigned int rxq_idx,
 		       const struct pp_memory_provider_params *old_p);
 bool netif_all_mps_have_cap(struct net_device *dev, u32 cap);
+bool netif_mp_wake(struct netdev_rx_queue *rxq);
 
 /**
   * net_mp_netmem_place_in_cache() - give a netmem to a page pool
diff --git a/include/net/page_pool/types.h b/include/net/page_pool/types.h
index e9f3af91e305..58ca414fa3d2 100644
--- a/include/net/page_pool/types.h
+++ b/include/net/page_pool/types.h
@@ -40,6 +40,12 @@
  */
 #define PP_FLAG_MEM_PROVIDER	BIT(4)
 
+/* Ring state after a refill, see page_pool_refill_done() */
+enum pp_refill {
+	PP_REFILL_PARTIAL,	/* some ring of the pool has room left */
+	PP_REFILL_FULL,		/* all rings of the pool are full */
+};
+
 /* RX buffers a page pool supplies, see page_pool_params.rx_roles */
 enum pp_rx_role {
 	PP_RX_ROLE_HEAD		= BIT(0),	/* packet headers */
diff --git a/net/core/dev.c b/net/core/dev.c
index 7e985fb82488..6033fc61a666 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -1771,6 +1771,7 @@ static int __dev_open(struct net_device *dev, struct netlink_ext_ack *extack)
 		dev_set_rx_mode(dev);
 		dev_activate(dev);
 		add_device_randomness(dev->dev_addr, dev->addr_len);
+		netif_mp_arm_dev(dev);
 	}
 
 	return ret;
@@ -1833,6 +1834,7 @@ static void __dev_close_many(struct list_head *head)
 
 		netdev_assert_locked_ops_compat(dev);
 
+		netif_mp_disarm_dev(dev);
 		if (ops->ndo_stop)
 			ops->ndo_stop(dev);
 
@@ -7559,6 +7561,7 @@ void netif_queue_set_napi(struct net_device *dev, unsigned int queue_index,
 	case NETDEV_QUEUE_TYPE_RX:
 		rxq = __netif_get_rx_queue(dev, queue_index);
 		rxq->napi = napi;
+		netif_mp_update_napi(rxq);
 		return;
 	case NETDEV_QUEUE_TYPE_TX:
 		txq = netdev_get_tx_queue(dev, queue_index);
@@ -7960,6 +7963,7 @@ void __netif_napi_del_locked(struct napi_struct *napi)
 	}
 
 	list_del_rcu(&napi->dev_list);
+	netif_mp_napi_del(napi);
 	napi_free_frags(napi);
 
 	gro_cleanup(&napi->gro);
diff --git a/net/core/dev.h b/net/core/dev.h
index e3337013ffc8..56386fd8c767 100644
--- a/net/core/dev.h
+++ b/net/core/dev.h
@@ -125,6 +125,10 @@ bool netif_is_queue_leasee(const struct net_device *dev);
 
 void __netif_mp_uninstall_rxq(struct netdev_rx_queue *rxq,
 			      const struct pp_memory_provider_params *p);
+void netif_mp_update_napi(struct netdev_rx_queue *rxq);
+void netif_mp_arm_dev(struct net_device *dev);
+void netif_mp_disarm_dev(struct net_device *dev);
+void netif_mp_napi_del(struct napi_struct *napi);
 
 void netif_rxq_cleanup_unlease(struct netdev_rx_queue *phys_rxq,
 			       struct netdev_rx_queue *virt_rxq);
diff --git a/net/core/netdev_rx_queue.c b/net/core/netdev_rx_queue.c
index 4e2f906fbc73..3fe904b56791 100644
--- a/net/core/netdev_rx_queue.c
+++ b/net/core/netdev_rx_queue.c
@@ -116,6 +116,94 @@ bool netif_all_mps_have_cap(struct net_device *dev, u32 cap)
 	return true;
 }
 
+/**
+ * netif_mp_wake - schedule the NAPI that refills a memory provider queue
+ * @rxq: physical RX queue of the provider
+ *
+ * Context: IRQs enabled, not in hardirq. The caller keeps the device of
+ * @rxq alive.
+ *
+ * Return: false if no NAPI refills the queue.
+ */
+bool netif_mp_wake(struct netdev_rx_queue *rxq)
+{
+	struct napi_struct *napi;
+	bool running = false;
+
+	rcu_read_lock();
+	napi = rcu_dereference(rxq->mp_napi);
+	if (napi) {
+		local_bh_disable();
+		napi_schedule(napi);
+		local_bh_enable();
+		running = true;
+	}
+	rcu_read_unlock();
+
+	return running;
+}
+
+/* Point wakeups at the NAPI of the running queue, and schedule it once: a
+ * refill during the start may have found no buffers.
+ */
+void netif_mp_update_napi(struct netdev_rx_queue *rxq)
+{
+	const struct memory_provider_ops *ops = rxq->mp_params.mp_ops;
+	struct napi_struct *napi = NULL;
+
+	if (rxq->mp_armed && ops && ops->refill_done)
+		napi = rxq->napi;
+	if (rcu_access_pointer(rxq->mp_napi) == napi)
+		return;
+
+	rcu_assign_pointer(rxq->mp_napi, napi);
+	if (napi)
+		netif_mp_wake(rxq);
+}
+
+static void netif_mp_arm_napi(struct netdev_rx_queue *rxq)
+{
+	rxq->mp_armed = true;
+	netif_mp_update_napi(rxq);
+}
+
+static void netif_mp_disarm_napi(struct netdev_rx_queue *rxq)
+{
+	rxq->mp_armed = false;
+	RCU_INIT_POINTER(rxq->mp_napi, NULL);
+}
+
+void netif_mp_arm_dev(struct net_device *dev)
+{
+	unsigned int i;
+
+	for (i = 0; i < dev->real_num_rx_queues; i++)
+		netif_mp_arm_napi(__netif_get_rx_queue(dev, i));
+}
+
+void netif_mp_disarm_dev(struct net_device *dev)
+{
+	unsigned int i;
+
+	for (i = 0; i < dev->num_rx_queues; i++)
+		netif_mp_disarm_napi(&dev->_rx[i]);
+}
+
+/* The grace period of netif_napi_del() covers wakeups that found @napi. */
+void netif_mp_napi_del(struct napi_struct *napi)
+{
+	struct net_device *dev = napi->dev;
+	unsigned int i;
+
+	/* free_netdev() frees the queues before it deletes the last NAPIs */
+	if (dev->reg_state != NETREG_REGISTERED)
+		return;
+
+	for (i = 0; i < dev->num_rx_queues; i++)
+		if (rcu_access_pointer(dev->_rx[i].mp_napi) == napi)
+			RCU_INIT_POINTER(dev->_rx[i].mp_napi, NULL);
+}
+
 static int netdev_rx_queue_reconfig(struct net_device *dev,
 				    unsigned int rxq_idx,
 				    struct netdev_queue_config *qcfg_old,
@@ -152,13 +240,15 @@ static int netdev_rx_queue_reconfig(struct net_device *dev,
 		goto err_free_new_queue_mem;
 
 	if (netif_running(dev)) {
+		netif_mp_disarm_napi(rxq);
 		err = qops->ndo_queue_stop(dev, old_mem, rxq_idx);
 		if (err)
-			goto err_free_new_queue_mem;
+			goto err_arm_old_queue;
 
 		err = qops->ndo_queue_start(dev, qcfg_new, new_mem, rxq_idx);
 		if (err)
 			goto err_start_queue;
+		netif_mp_arm_napi(rxq);
 	} else {
 		swap(new_mem, old_mem);
 	}
@@ -183,8 +273,13 @@ static int netdev_rx_queue_reconfig(struct net_device *dev,
 		     "Failed to restart old queue in error path. RX queue %d may be unhealthy.",
 		     rxq_idx);
 		qops->ndo_queue_mem_free(dev, old_mem);
+		goto err_free_new_queue_mem;
 	}
 
+err_arm_old_queue:
+	/* The old queue may run */
+	netif_mp_arm_napi(rxq);
+
 err_free_new_queue_mem:
 	qops->ndo_queue_mem_free(dev, new_mem);
 
diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index 781ba46eb152..113b0b08356d 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -794,6 +794,10 @@ static int xsk_wakeup(struct xdp_sock *xs, u8 flags)
 {
 	struct net_device *dev = xs->dev;
 
+	/* The core wakes the queue for both RX and TX. */
+	if (xs->pool->pp)
+		return xsk_pp_wakeup(xs->pool->pp);
+
 	return dev->netdev_ops->ndo_xsk_wakeup(dev, xs->queue_id, flags);
 }
 
diff --git a/net/xdp/xsk.h b/net/xdp/xsk.h
index 9699e9a499a3..d7d6bcf0a893 100644
--- a/net/xdp/xsk.h
+++ b/net/xdp/xsk.h
@@ -42,6 +42,7 @@ bool xsk_pp_supported(struct net_device *dev);
 int xsk_pp_bind(struct xsk_buff_pool *pool, struct net_device *dev,
 		u16 queue_id);
 void xsk_pp_unbind(struct xsk_buff_pool *pool);
+int xsk_pp_wakeup(struct xsk_pp *pp);
 int xp_alloc_heads(struct xsk_buff_pool *pool);
 void xsk_clear_pool_at_qid(struct net_device *dev, u16 queue_id);
 int xsk_reg_pool_at_qid(struct net_device *dev, struct xsk_buff_pool *pool,
diff --git a/net/xdp/xsk_pp.c b/net/xdp/xsk_pp.c
index c2214e718cdb..a77213f7fef6 100644
--- a/net/xdp/xsk_pp.c
+++ b/net/xdp/xsk_pp.c
@@ -36,7 +36,8 @@ struct xsk_pp {
 	u32 nr_pools;
 	bool dma_need_sync;
 	/* RX queue of the provider, NULL once it is removed */
-	struct netdev_rx_queue *rxq;
+	struct netdev_rx_queue __rcu *rxq;
+	bool starved;
 	u8 *state;
 	u32 reuse_cnt;
 	u32 reuse[];
@@ -219,11 +220,31 @@ static netmem_ref xsk_pp_alloc_netmems(struct page_pool *pool, gfp_t gfp)
 	return netmems[n - 1];
 }
 
+static bool xsk_pp_wake(struct xsk_pp *pp)
+{
+	struct netdev_rx_queue *rxq;
+	bool running = false;
+
+	rcu_read_lock();
+	rxq = rcu_dereference(pp->rxq);
+	if (rxq)
+		running = netif_mp_wake(rxq);
+	rcu_read_unlock();
+
+	return running;
+}
+
+int xsk_pp_wakeup(struct xsk_pp *pp)
+{
+	return xsk_pp_wake(pp) ? 0 : -ENETDOWN;
+}
+
 static bool xsk_pp_release_netmem(struct page_pool *pool, netmem_ref netmem)
 {
 	struct net_iov *niov = netmem_to_net_iov(netmem);
 	struct xsk_pp *pp = pool->mp_priv;
 	u32 idx = net_iov_idx(niov);
+	bool starved;
 
 	spin_lock_bh(&pp->lock);
 	net_mp_niov_clear_page_pool(niov);
@@ -232,11 +253,47 @@ static bool xsk_pp_release_netmem(struct page_pool *pool, netmem_ref netmem)
 		pp->state[idx] = XSK_PP_REUSE;
 		pp->reuse[pp->reuse_cnt++] = idx;
 	}
+	starved = pp->starved;
+	WRITE_ONCE(pp->starved, false);
 	spin_unlock_bh(&pp->lock);
 
+	/* A starved queue may wait for this release */
+	if (starved)
+		xsk_pp_wake(pp);
+
 	return false;
 }
 
+static bool xsk_pp_refill_done(struct page_pool *pool, enum pp_refill state)
+{
+	struct xsk_pp *pp = pool->mp_priv;
+	struct xsk_buff_pool *xp = pp->pool;
+	bool wait = xp->uses_need_wakeup;
+	bool more;
+
+	if (state == PP_REFILL_FULL && !READ_ONCE(pp->starved))
+		return true;
+
+	spin_lock_bh(&pp->lock);
+	if (!pp->fq) {
+		spin_unlock_bh(&pp->lock);
+		return true;
+	}
+
+	if (state == PP_REFILL_FULL) {
+		WRITE_ONCE(pp->starved, false);
+		spin_unlock_bh(&pp->lock);
+		return true;
+	}
+
+	/* With need_wakeup, userspace wakes the queue after it posts FILL */
+	more = pp->reuse_cnt || xskq_cons_nb_entries(pp->fq, 1);
+	WRITE_ONCE(pp->starved, !more);
+	spin_unlock_bh(&pp->lock);
+
+	return !more && wait;
+}
+
 static int xsk_pp_nl_fill(void *mp_priv, struct sk_buff *rsp,
 			  struct netdev_rx_queue *rxq)
 {
@@ -246,10 +303,12 @@ static int xsk_pp_nl_fill(void *mp_priv, struct sk_buff *rsp,
 /* The queue no longer uses the provider, and its DMA stopped */
 static void xsk_pp_detach(struct xsk_pp *pp)
 {
-	pp->rxq = NULL;
+	RCU_INIT_POINTER(pp->rxq, NULL);
 	spin_lock_bh(&pp->lock);
 	pp->fq = NULL;
 	spin_unlock_bh(&pp->lock);
+	/* Wait for wakeups that found the queue */
+	synchronize_net();
 	xp_dma_unmap(pp->pool, XSK_PP_DMA_ATTR);
 }
 
@@ -266,6 +325,7 @@ const struct memory_provider_ops xsk_pp_ops = {
 	.release_netmem	= xsk_pp_release_netmem,
 	.nl_fill	= xsk_pp_nl_fill,
 	.uninstall	= xsk_pp_uninstall,
+	.refill_done	= xsk_pp_refill_done,
 	.caps		= MP_CAP_READABLE,
 };
 
@@ -428,17 +488,22 @@ int xsk_pp_bind(struct xsk_buff_pool *pool, struct net_device *dev,
 		return PTR_ERR(pp);
 	}
 
+	rcu_assign_pointer(pp->rxq, __netif_get_rx_queue(dev, queue_id));
 	mp.mp_priv = pp;
 	mp.rx_page_size = pool->chunk_size;
 	mp.rx_headroom = xsk_pool_get_headroom(pool);
 	err = netif_mp_open_rxq(dev, queue_id, &mp, NULL);
 	if (!err) {
-		pp->rxq = __netif_get_rx_queue(dev, queue_id);
 		pool->pp = pp;
 		pool->xdp_zc_max_segs = dev->xdp_zc_max_segs;
+		/* See xsk_pp_refill_done() */
+		if (pool->uses_need_wakeup)
+			xsk_set_rx_need_wakeup(pool);
 		return 0;
 	}
 
+	RCU_INIT_POINTER(pp->rxq, NULL);
+	synchronize_net();
 	xp_dma_unmap(pool, XSK_PP_DMA_ATTR);
 	/* Copy mode takes the chunks that the provider holds */
 	if (!xp_alloc_heads(pool) && xsk_pp_abandon(pp))
@@ -459,7 +524,7 @@ void xsk_pp_unbind(struct xsk_buff_pool *pool)
 	};
 
 	/* Unregister removed the provider already */
-	if (!pp->rxq)
+	if (!rcu_access_pointer(pp->rxq))
 		return;
 
 	netif_mp_close_rxq(pool->netdev, pool->queue_id, &mp);
-- 
2.56.0

