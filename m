Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794306099;
	b=TU+vaXY0dNeyFmSKgHTN+gKG1TJeKqvn3vWVzykvl9mqCl3eeBgSXeCqFZCODUBLp1/0
	 Pm+Dx7cYxpUTMUhDtcNo5uEzkA4gsVZ0fezzT74Mbp97SS0YmsmkzqWHtLdFjTUs26gzi
	 AsHRAgCbfF5kpQJaxoCtR1U4vZLPBlfGF0D+Jv42nYCXCJlIslde2cOAyJvGjfgmcoxny
	 q50sv5AzqyWmlntcD6GHz5P50xBTmPw/Uh++95GjGNAJ6da7i90+C170ttcN9vq7HoTOC
	 +Gw/89xmiplsq4uVNVeF70ncJincsLZgiLBy+NfXQ8ORV0XcHoOMLiEmUNdhJyPcZBQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794306099;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=cOk4vb18XTI1th4SOmTgh9j8MxxvAbF21LTPow8gZes=;
	b=H6ZtWS6H1S1wG8lrGeiM86EDDAhKDTb3T7Wl0J8GK4SrHM8zGsh0XZ9l3xgnsO761ZqF
	 kaZFXS1MO+axkx3Nu4GU8CzVpEYXBFQpiCkAdMF6c5TB3sIOXAFiwvZAlD7XLL1Afit6I
	 gfusHjkbCgMfwep+sis0VXLwAWk7j+mWi4kRm8UIpepNmmBA8Cps18WRn7u15f673YCUB
	 MBNXC2fgU9ii/+XwlWWKojC77SbU9G6zenWRwIGFMeZ6Ep5+UC70omNZMlNjr1TyjAbnu
	 2wHecHKVyPtusRLGt8GBL23Omy6FIWGyFYYapfDz82xIQRSRMU/qC0E8/qmMq9f/HtA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VJvaykh9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66F5F606B9B2;
	Tue, 10 Nov 2026 10:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VJvaykh9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BD451F008A2;
	Tue, 10 Nov 2026 10:21:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794306098;
	bh=cOk4vb18XTI1th4SOmTgh9j8MxxvAbF21LTPow8gZes=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VJvaykh9qxtBF3F1D2zl1GjEGhgIYGbgCBzo6QIzaKZ9r5zlZPDkHFzdmtlnlPeRx
	 g5ioQg3k4HTWoRu32bettEI7B4SlG3QnA7l2oAl92Q5HImxdCDOwGv5j2rKlwZoQy8
	 DHEDFSqmk6P76mZFtG8Ph2aknqAfZQuexm8fTqhMllU8HTjt7SwAGTZCexFhl4jDZ6
	 xCVRK0r/aiiTE0+ctR6mBstgpuZEwXzECiNn1KxUyqFGKcaWP5SgInI5ngrnFwzdep
	 /8eg7blkiMVJc1f24BsGFJG5QvpQG1z2fjawPnCyV0rohrlbN8bn5yebKj9P4oifZS
	 9ohC4R6gDZBlg==
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
Subject: [PATCH net-next v1 05/11] xsk: Install UMEM page pool providers in the core
Date: Tue, 10 Nov 2026 11:20:26 +0100
Message-ID: <20261110102039.1002605-6-bjorn@kernel.org>
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

A page_pool driver should not need its own AF_XDP setup. When it sets
netdev_queue_mgmt_ops.xsk_page_pool, a zero-copy bind installs the
UMEM provider through the queue API, as devmem and io_uring do. The
driver only judges the chunk size, headroom and multi-buffer mode
against its MTU and XDP program, in XDP_VALIDATE_XSK_POOL; MTU and
program changes of a bound device get the same check. The UMEM
headroom belongs to the socket, so the queue gets it as rx_headroom,
next to rx_page_size.

After a queue restart, the core checks that the new page pools took
the provider. A readable provider must back the header pool, where an
unsplit packet lands, so pools declare the buffers they supply in
rx_roles. The old queue's pools carry the same provider during the
check, so a per-queue generation, mp_gen, tells the new ones apart.

Generic XDP runs outside the queue NAPI, so it cannot feed the socket.

The provider needs no xdp_buff_xsk per chunk. The buffer pool
allocates them only for copy mode and driver zero copy, which saves
128 bytes per chunk.

Signed-off-by: Björn Töpel <bjorn@kernel.org>
---
 include/linux/netdevice.h     |   8 ++
 include/net/netdev_queues.h   |  12 ++
 include/net/netdev_rx_queue.h |   2 +
 include/net/page_pool/types.h |  12 ++
 include/net/xdp_sock.h        |   4 +
 include/net/xdp_sock_drv.h    |  45 +++++++
 include/net/xsk_buff_pool.h   |   3 +
 net/core/dev.c                |  16 +++
 net/core/netdev_config.c      |   2 +
 net/core/netdev_rx_queue.c    |   9 +-
 net/core/page_pool.c          |   6 +-
 net/core/page_pool_user.c     |  25 ++--
 net/xdp/xsk.h                 |   7 +-
 net/xdp/xsk_buff_pool.c       |  69 ++++++++---
 net/xdp/xsk_pp.c              | 221 ++++++++++++++++++++++++++++++++++
 15 files changed, 410 insertions(+), 31 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 435be7880d7e..11e51e684003 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -77,6 +77,7 @@ struct udp_tunnel_info;
 struct udp_tunnel_nic_info;
 struct udp_tunnel_nic;
 struct bpf_prog;
+struct xsk_rx_check;
 struct xdp_buff;
 struct xdp_frame;
 struct xdp_metadata_ops;
@@ -1010,6 +1011,8 @@ enum bpf_netdev_command {
 	BPF_OFFLOAD_MAP_ALLOC,
 	BPF_OFFLOAD_MAP_FREE,
 	XDP_SETUP_XSK_POOL,
+	/* Check an AF_XDP page pool setup, see netdev_queue_mgmt_ops */
+	XDP_VALIDATE_XSK_POOL,
 };
 
 struct bpf_prog_offload_ops;
@@ -1048,6 +1051,11 @@ struct netdev_bpf {
 			struct xsk_buff_pool *pool;
 			u16 queue_id;
 		} xsk;
+		/* XDP_VALIDATE_XSK_POOL */
+		struct {
+			const struct xsk_rx_check *check;
+			struct netlink_ext_ack *extack;
+		} xsk_check;
 	};
 };
 
diff --git a/include/net/netdev_queues.h b/include/net/netdev_queues.h
index c5335e935b7d..ad5f0420c21d 100644
--- a/include/net/netdev_queues.h
+++ b/include/net/netdev_queues.h
@@ -45,12 +45,15 @@ struct netdev_config {
 /**
  * struct netdev_queue_config - rendered configuration for an RX queue
  * @rx_page_size:	Size of one RX page-pool allocation.
+ * @rx_headroom:	Space before the packet in a head buffer, including
+ *			XDP_PACKET_HEADROOM. Zero selects the driver default.
  * @rx_ring_size:	Configured size of the regular RX ring.
  * @rx_mini_ring_size:	Configured size of the RX mini ring.
  * @rx_jumbo_ring_size:	Configured size of the RX jumbo ring.
  */
 struct netdev_queue_config {
 	u32	rx_page_size;
+	u32	rx_headroom;
 	u32	rx_ring_size;
 	u32	rx_mini_ring_size;
 	u32	rx_jumbo_ring_size;
@@ -156,6 +159,8 @@ void netdev_stat_queue_sum(struct net_device *netdev,
 enum {
 	/* The queue checks and honours the page size qcfg parameter */
 	QCFG_RX_PAGE_SIZE	= 0x1,
+	/* The queue checks and honours the headroom qcfg parameter */
+	QCFG_RX_HEADROOM	= 0x2,
 };
 
 /**
@@ -199,6 +204,12 @@ enum {
  *
  * @supported_params:	Bitmask of supported parameters, see QCFG_*.
  *
+ * @xsk_page_pool:	AF_XDP zero copy installs the UMEM as the page pool
+ *			memory provider of the RX queue. The driver selects it
+ *			with PP_FLAG_MEM_PROVIDER and PP_RX_ROLE_HEAD, honours
+ *			whole buffers and QCFG_RX_HEADROOM, and accepts or
+ *			rejects the setup in XDP_VALIDATE_XSK_POOL.
+ *
  * Note that @ndo_queue_mem_alloc and @ndo_queue_mem_free may be called while
  * the interface is closed. @ndo_queue_start and @ndo_queue_stop will only
  * be called for an interface which is open.
@@ -229,6 +240,7 @@ struct netdev_queue_mgmt_ops {
 				    struct netlink_ext_ack *extack);
 
 	unsigned int supported_params;
+	bool xsk_page_pool;
 };
 
 void netdev_queue_config(struct net_device *dev, int rxq,
diff --git a/include/net/netdev_rx_queue.h b/include/net/netdev_rx_queue.h
index 9415a94d333d..989120cbf452 100644
--- a/include/net/netdev_rx_queue.h
+++ b/include/net/netdev_rx_queue.h
@@ -31,6 +31,8 @@ struct netdev_rx_queue {
 	struct napi_struct		*napi;
 	struct netdev_queue_config	qcfg;
 	struct pp_memory_provider_params mp_params;
+	/* stamps the page pools of each queue allocation */
+	u32				mp_gen;
 
 	/* If a queue is leased, then the lease pointer is always
 	 * valid. From the physical device it points to the virtual
diff --git a/include/net/page_pool/types.h b/include/net/page_pool/types.h
index 0d48c05f1462..e9f3af91e305 100644
--- a/include/net/page_pool/types.h
+++ b/include/net/page_pool/types.h
@@ -40,6 +40,12 @@
  */
 #define PP_FLAG_MEM_PROVIDER	BIT(4)
 
+/* RX buffers a page pool supplies, see page_pool_params.rx_roles */
+enum pp_rx_role {
+	PP_RX_ROLE_HEAD		= BIT(0),	/* packet headers */
+	PP_RX_ROLE_PAYLOAD	= BIT(1),	/* payload after header split */
+};
+
 #define PP_FLAG_ALL		(PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV | \
 				 PP_FLAG_SYSTEM_POOL | \
 				 PP_FLAG_ALLOW_UNREADABLE_NETMEM | \
@@ -94,6 +100,8 @@ struct pp_alloc_cache {
  * @queue_idx:	queue idx this page_pool is being created for.
  * @flags:	PP_FLAG_DMA_MAP, PP_FLAG_DMA_SYNC_DEV, PP_FLAG_SYSTEM_POOL,
  *		PP_FLAG_ALLOW_UNREADABLE_NETMEM, PP_FLAG_MEM_PROVIDER.
+ * @rx_roles:	&enum pp_rx_role mask, for pools that select a memory
+ *		provider. Zero means payload buffers.
  */
 struct page_pool_params {
 	struct_group_tagged(page_pool_params_fast, fast,
@@ -110,6 +118,7 @@ struct page_pool_params {
 		struct net_device *netdev;
 		unsigned int queue_idx;
 		unsigned int	flags;
+		unsigned int	rx_roles;
 /* private: used by test code only */
 		void (*init_callback)(netmem_ref netmem, void *arg);
 		void *init_arg;
@@ -182,6 +191,7 @@ struct pp_memory_provider_params {
 	void *mp_priv;
 	const struct memory_provider_ops *mp_ops;
 	u32 rx_page_size;
+	u32 rx_headroom;
 };
 
 struct page_pool {
@@ -245,6 +255,8 @@ struct page_pool {
 
 	void *mp_priv;
 	const struct memory_provider_ops *mp_ops;
+	/* queue allocation that selected the provider */
+	u32 mp_gen;
 
 	struct xarray dma_mapped;
 
diff --git a/include/net/xdp_sock.h b/include/net/xdp_sock.h
index 6e70b320b399..e0e22ef839e1 100644
--- a/include/net/xdp_sock.h
+++ b/include/net/xdp_sock.h
@@ -19,6 +19,10 @@
 struct net_device;
 struct xsk_queue;
 struct xdp_buff;
+struct memory_provider_ops;
+
+/* The memory provider of AF_XDP page pool zero copy */
+extern const struct memory_provider_ops xsk_pp_ops;
 
 struct xdp_umem {
 	void *addrs;
diff --git a/include/net/xdp_sock_drv.h b/include/net/xdp_sock_drv.h
index d94aeb506379..5bb1949a0aa7 100644
--- a/include/net/xdp_sock_drv.h
+++ b/include/net/xdp_sock_drv.h
@@ -22,8 +22,29 @@ struct xsk_cb_desc {
 	u8 bytes;
 };
 
+/**
+ * struct xsk_rx_check - AF_XDP page pool RX setup a driver must accept
+ * @buf_size: size of each RX buffer
+ * @headroom: space before the packet in a head buffer, including
+ *	XDP_PACKET_HEADROOM. The UMEM headroom is the rest.
+ * @mtu: MTU of the device
+ * @sg: the socket takes packets in more than one buffer
+ * @prog: XDP program to check, or NULL for the current one
+ */
+struct xsk_rx_check {
+	u32 buf_size;
+	u32 headroom;
+	unsigned int mtu;
+	bool sg;
+	struct bpf_prog *prog;
+};
+
 #ifdef CONFIG_XDP_SOCKETS
 
+int xsk_validate_dev(struct net_device *dev, unsigned int mtu,
+		     struct bpf_prog *prog, enum bpf_xdp_mode mode,
+		     struct netlink_ext_ack *extack);
+struct xsk_buff_pool *xsk_rxq_pool(struct net_device *dev, u16 queue_id);
 void xsk_tx_completed(struct xsk_buff_pool *pool, u32 nb_entries);
 bool xsk_tx_peek_desc(struct xsk_buff_pool *pool, struct xdp_desc *desc);
 u32 xsk_tx_peek_release_desc_batch(struct xsk_buff_pool *pool, u32 max);
@@ -36,6 +57,11 @@ void xsk_clear_rx_need_wakeup(struct xsk_buff_pool *pool);
 void xsk_clear_tx_need_wakeup(struct xsk_buff_pool *pool);
 bool xsk_uses_need_wakeup(struct xsk_buff_pool *pool);
 
+static inline bool xsk_pool_uses_sg(struct xsk_buff_pool *pool)
+{
+	return pool->umem->flags & XDP_UMEM_SG_FLAG;
+}
+
 static inline u32 xsk_pool_get_headroom(struct xsk_buff_pool *pool)
 {
 	return XDP_PACKET_HEADROOM + pool->headroom;
@@ -351,6 +377,20 @@ static inline void xsk_buff_raw_dma_sync_for_device(struct xsk_buff_pool *pool,
 
 #else
 
+static inline int xsk_validate_dev(struct net_device *dev, unsigned int mtu,
+				   struct bpf_prog *prog,
+				   enum bpf_xdp_mode mode,
+				   struct netlink_ext_ack *extack)
+{
+	return 0;
+}
+
+static inline struct xsk_buff_pool *xsk_rxq_pool(struct net_device *dev,
+						 u16 queue_id)
+{
+	return NULL;
+}
+
 static inline void xsk_tx_completed(struct xsk_buff_pool *pool, u32 nb_entries)
 {
 }
@@ -397,6 +437,11 @@ static inline bool xsk_uses_need_wakeup(struct xsk_buff_pool *pool)
 	return false;
 }
 
+static inline bool xsk_pool_uses_sg(struct xsk_buff_pool *pool)
+{
+	return false;
+}
+
 static inline u32 xsk_pool_get_headroom(struct xsk_buff_pool *pool)
 {
 	return 0;
diff --git a/include/net/xsk_buff_pool.h b/include/net/xsk_buff_pool.h
index 02e89350faf9..6d7cfdf99a8b 100644
--- a/include/net/xsk_buff_pool.h
+++ b/include/net/xsk_buff_pool.h
@@ -11,6 +11,7 @@
 #include <net/xdp.h>
 
 struct xsk_buff_pool;
+struct xsk_pp;
 struct xdp_rxq_info;
 struct xsk_cb_desc;
 struct xsk_queue;
@@ -54,6 +55,8 @@ struct xsk_buff_pool {
 	spinlock_t xsk_tx_list_lock;
 	refcount_t users;
 	struct xdp_umem *umem;
+	/* page pool memory provider, see net/xdp/xsk_pp.c */
+	struct xsk_pp *pp;
 	struct work_struct work;
 	/* Protects generic receive in shared and non-shared umem mode. */
 	spinlock_t rx_lock;
diff --git a/net/core/dev.c b/net/core/dev.c
index 663fe3e32ea0..7e985fb82488 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -163,6 +163,7 @@
 #include <net/page_pool/types.h>
 #include <net/page_pool/helpers.h>
 #include <net/page_pool/memory_provider.h>
+#include <net/xdp_sock_drv.h>
 #include <net/rps.h>
 #include <linux/phy_link_topology.h>
 
@@ -10535,6 +10536,8 @@ u8 dev_xdp_sb_prog_count(struct net_device *dev)
 
 int netif_xdp_propagate(struct net_device *dev, struct netdev_bpf *bpf)
 {
+	int err;
+
 	if (!dev->netdev_ops->ndo_bpf)
 		return -EOPNOTSUPP;
 
@@ -10552,6 +10555,13 @@ int netif_xdp_propagate(struct net_device *dev, struct netdev_bpf *bpf)
 		return -EBUSY;
 	}
 
+	if (bpf->command == XDP_SETUP_PROG && bpf->prog) {
+		err = xsk_validate_dev(dev, dev->mtu, bpf->prog, XDP_MODE_DRV,
+				       bpf->extack);
+		if (err)
+			return err;
+	}
+
 	return dev->netdev_ops->ndo_bpf(dev, bpf);
 }
 EXPORT_SYMBOL_GPL(netif_xdp_propagate);
@@ -10629,6 +10639,12 @@ static int dev_xdp_install(struct net_device *dev, enum bpf_xdp_mode mode,
 		return -EBUSY;
 	}
 
+	if (mode != XDP_MODE_HW && prog) {
+		err = xsk_validate_dev(dev, dev->mtu, prog, mode, extack);
+		if (err)
+			return err;
+	}
+
 	memset(&xdp, 0, sizeof(xdp));
 	xdp.command = mode == XDP_MODE_HW ? XDP_SETUP_PROG_HW : XDP_SETUP_PROG;
 	xdp.extack = extack;
diff --git a/net/core/netdev_config.c b/net/core/netdev_config.c
index 1975de42a60d..97e33764737b 100644
--- a/net/core/netdev_config.c
+++ b/net/core/netdev_config.c
@@ -88,6 +88,8 @@ static int __netdev_queue_config(struct net_device *dev, int rxq_idx,
 	mpp = &__netif_get_rx_queue(dev, rxq_idx)->mp_params;
 	if (mpp->rx_page_size)
 		qcfg->rx_page_size = mpp->rx_page_size;
+	if (mpp->rx_headroom)
+		qcfg->rx_headroom = mpp->rx_headroom;
 	err = validate_cb(dev, qcfg, extack);
 	if (err)
 		return err;
diff --git a/net/core/netdev_rx_queue.c b/net/core/netdev_rx_queue.c
index 9e14a747f9b5..4e2f906fbc73 100644
--- a/net/core/netdev_rx_queue.c
+++ b/net/core/netdev_rx_queue.c
@@ -6,6 +6,7 @@
 #include <net/netdev_queues.h>
 #include <net/netdev_rx_queue.h>
 #include <net/page_pool/memory_provider.h>
+#include <net/xdp_sock.h>
 
 #include "dev.h"
 #include "page_pool_priv.h"
@@ -141,6 +142,7 @@ static int netdev_rx_queue_reconfig(struct net_device *dev,
 		goto err_free_new_mem;
 	}
 
+	rxq->mp_gen++;
 	err = qops->ndo_queue_mem_alloc(dev, qcfg_new, new_mem, rxq_idx);
 	if (err)
 		goto err_free_old_mem;
@@ -235,6 +237,10 @@ static int __netif_mp_open_rxq(struct net_device *dev, unsigned int rxq_idx,
 		NL_SET_ERR_MSG(extack, "device does not support: rx_page_size");
 		return -EOPNOTSUPP;
 	}
+	if (p->rx_headroom && !(qops->supported_params & QCFG_RX_HEADROOM)) {
+		NL_SET_ERR_MSG(extack, "device does not support: rx_headroom");
+		return -EOPNOTSUPP;
+	}
 
 	rxq = __netif_get_rx_queue(dev, rxq_idx);
 	if (rxq->mp_params.mp_ops) {
@@ -242,7 +248,8 @@ static int __netif_mp_open_rxq(struct net_device *dev, unsigned int rxq_idx,
 		return -EEXIST;
 	}
 #ifdef CONFIG_XDP_SOCKETS
-	if (rxq->pool) {
+	/* An AF_XDP pool owns the queue, unless it installs its provider. */
+	if (rxq->pool && p->mp_ops != &xsk_pp_ops) {
 		NL_SET_ERR_MSG(extack, "designated queue already in use by AF_XDP");
 		return -EBUSY;
 	}
diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index 8237fda598ab..e897e79d31f1 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -215,7 +215,8 @@ bool netmem_can_retain(netmem_ref netmem)
 EXPORT_SYMBOL(netmem_can_retain);
 
 static int page_pool_select_mp(struct page_pool *pool,
-			       const struct pp_memory_provider_params *mpp)
+			       const struct pp_memory_provider_params *mpp,
+			       u32 rxq_mp_gen)
 {
 	const struct memory_provider_ops *ops = mpp->mp_ops;
 	unsigned int flags = pool->slow.flags;
@@ -234,6 +235,7 @@ static int page_pool_select_mp(struct page_pool *pool,
 
 	pool->mp_priv = mpp->mp_priv;
 	pool->mp_ops = ops;
+	pool->mp_gen = rxq_mp_gen;
 	return 0;
 }
 
@@ -326,7 +328,7 @@ static int page_pool_init(struct page_pool *pool,
 		netdev_assert_locked(pool->slow.netdev);
 		rxq = __netif_get_rx_queue(pool->slow.netdev,
 					   pool->slow.queue_idx);
-		err = page_pool_select_mp(pool, &rxq->mp_params);
+		err = page_pool_select_mp(pool, &rxq->mp_params, rxq->mp_gen);
 		if (err)
 			goto free_ptr_ring;
 	}
diff --git a/net/core/page_pool_user.c b/net/core/page_pool_user.c
index f30f3779624c..b69da0f74756 100644
--- a/net/core/page_pool_user.c
+++ b/net/core/page_pool_user.c
@@ -398,28 +398,37 @@ void page_pool_unlist(struct page_pool *pool)
 	mutex_unlock(&page_pools_lock);
 }
 
+/* Check that the queue allocation that just ran put the provider in every
+ * pool role it needs: headers for a readable provider, payload otherwise.
+ * Pools of earlier allocations do not count.
+ */
 int page_pool_check_memory_provider(struct net_device *dev,
 				    struct netdev_rx_queue *rxq)
 {
-	void *binding = rxq->mp_params.mp_priv;
+	const struct memory_provider_ops *ops = rxq->mp_params.mp_ops;
+	void *mp_priv = rxq->mp_params.mp_priv;
+	unsigned int need, have = 0;
 	struct page_pool *pool;
 	struct hlist_node *n;
 
-	if (!binding)
+	if (!mp_priv)
 		return 0;
 
+	need = PP_RX_ROLE_PAYLOAD;
+	if (ops->caps & MP_CAP_READABLE)
+		need = PP_RX_ROLE_HEAD;
+
 	mutex_lock(&page_pools_lock);
 	hlist_for_each_entry_safe(pool, n, &dev->page_pools, user.list) {
-		if (pool->mp_priv != binding)
+		if (pool->mp_priv != mp_priv || pool->mp_gen != rxq->mp_gen ||
+		    pool->slow.queue_idx != get_netdev_rx_queue_index(rxq))
 			continue;
 
-		if (pool->slow.queue_idx == get_netdev_rx_queue_index(rxq)) {
-			mutex_unlock(&page_pools_lock);
-			return 0;
-		}
+		have |= pool->slow.rx_roles ? : PP_RX_ROLE_PAYLOAD;
 	}
 	mutex_unlock(&page_pools_lock);
-	return -ENODATA;
+
+	return (have & need) == need ? 0 : -ENODATA;
 }
 
 static void page_pool_unreg_netdev_wipe(struct net_device *netdev)
diff --git a/net/xdp/xsk.h b/net/xdp/xsk.h
index 4dab7b9a1487..9699e9a499a3 100644
--- a/net/xdp/xsk.h
+++ b/net/xdp/xsk.h
@@ -36,10 +36,13 @@ void xsk_map_try_sock_delete(struct xsk_map *map, struct xdp_sock *xs,
 			     struct xdp_sock __rcu **map_entry);
 struct xsk_pp;
 
-extern const struct memory_provider_ops xsk_pp_ops;
-
 struct xsk_pp *xsk_pp_create(struct xsk_buff_pool *pool);
 void xsk_pp_put(struct xsk_pp *pp);
+bool xsk_pp_supported(struct net_device *dev);
+int xsk_pp_bind(struct xsk_buff_pool *pool, struct net_device *dev,
+		u16 queue_id);
+void xsk_pp_unbind(struct xsk_buff_pool *pool);
+int xp_alloc_heads(struct xsk_buff_pool *pool);
 void xsk_clear_pool_at_qid(struct net_device *dev, u16 queue_id);
 int xsk_reg_pool_at_qid(struct net_device *dev, struct xsk_buff_pool *pool,
 			u16 queue_id);
diff --git a/net/xdp/xsk_buff_pool.c b/net/xdp/xsk_buff_pool.c
index 18966bbdb5b7..c620a0c32c17 100644
--- a/net/xdp/xsk_buff_pool.c
+++ b/net/xdp/xsk_buff_pool.c
@@ -38,6 +38,8 @@ void xp_destroy(struct xsk_buff_pool *pool)
 	if (!pool)
 		return;
 
+	if (pool->pp)
+		xsk_pp_put(pool->pp);
 	kvfree(pool->tx_descs);
 	kvfree(pool->heads);
 	kvfree(pool);
@@ -62,18 +64,13 @@ struct xsk_buff_pool *xp_create_and_assign_umem(struct xdp_sock *xs,
 {
 	bool unaligned = umem->flags & XDP_UMEM_UNALIGNED_CHUNK_FLAG;
 	struct xsk_buff_pool *pool;
-	struct xdp_buff_xsk *xskb;
-	u32 i, entries;
+	u32 entries;
 
 	entries = unaligned ? umem->chunks : 0;
 	pool = kvzalloc_flex(*pool, free_heads, entries);
 	if (!pool)
 		goto out;
 
-	pool->heads = kvzalloc_objs(*pool->heads, umem->chunks);
-	if (!pool->heads)
-		goto out;
-
 	if (xs->tx)
 		if (xp_alloc_tx_descs(pool, xs, max_segs))
 			goto out;
@@ -104,10 +101,30 @@ struct xsk_buff_pool *xp_create_and_assign_umem(struct xdp_sock *xs,
 	pool->fq = xs->fq_tmp;
 	pool->cq = xs->cq_tmp;
 
-	for (i = 0; i < pool->free_heads_cnt; i++) {
+	return pool;
+
+out:
+	xp_destroy(pool);
+	return NULL;
+}
+
+/* Only copy mode and driver zero copy use heads */
+int xp_alloc_heads(struct xsk_buff_pool *pool)
+{
+	struct xdp_buff_xsk *xskb;
+	u32 i;
+
+	if (pool->heads)
+		return 0;
+
+	pool->heads = kvzalloc_objs(*pool->heads, pool->heads_cnt);
+	if (!pool->heads)
+		return -ENOMEM;
+
+	for (i = 0; i < pool->heads_cnt; i++) {
 		xskb = &pool->heads[i];
 		xskb->pool = pool;
-		xskb->xdp.frame_sz = umem->chunk_size - umem->headroom;
+		xskb->xdp.frame_sz = pool->chunk_size - pool->headroom;
 		INIT_LIST_HEAD(&xskb->list_node);
 		if (pool->unaligned)
 			pool->free_heads[i] = xskb;
@@ -115,11 +132,7 @@ struct xsk_buff_pool *xp_create_and_assign_umem(struct xdp_sock *xs,
 			xp_init_xskb_addr(xskb, pool, (u64)i * pool->chunk_size);
 	}
 
-	return pool;
-
-out:
-	xp_destroy(pool);
-	return NULL;
+	return 0;
 }
 
 void xp_set_rxq_info(struct xsk_buff_pool *pool, struct xdp_rxq_info *rxq)
@@ -212,9 +225,24 @@ int xp_assign_dev(struct xsk_buff_pool *pool,
 	 */
 	hlist_add_head(&pool->dev_node, &netdev->xsk_pools);
 
-	if (force_copy)
+	if (force_copy) {
 		/* For copy-mode, we are done. */
+		err = xp_alloc_heads(pool);
+		goto out;
+	}
+
+	if (xsk_pp_supported(netdev)) {
+		err = xsk_pp_bind(pool, netdev, queue_id);
+		if (err)
+			goto err_unreg_pool;
+
+		pool->umem->zc = true;
 		return 0;
+	}
+
+	err = xp_alloc_heads(pool);
+	if (err)
+		goto out;
 
 	if ((netdev->xdp_features & NETDEV_XDP_ACT_XSK) != NETDEV_XDP_ACT_XSK) {
 		err = -EOPNOTSUPP;
@@ -267,8 +295,10 @@ int xp_assign_dev(struct xsk_buff_pool *pool,
 err_unreg_xsk:
 	xp_disable_drv_zc(pool);
 err_unreg_pool:
-	if (!force_zc)
-		err = 0; /* fallback to copy mode */
+	/* An old page pool may still own chunks of a failed provider. */
+	if (!force_zc && !pool->pp)
+		err = xp_alloc_heads(pool); /* fallback to copy mode */
+out:
 	if (err) {
 		pool->umem->flags = umem_flags;
 		xsk_clear_pool_at_qid(netdev, queue_id);
@@ -301,7 +331,10 @@ static void __xp_clear_dev(struct xsk_buff_pool *pool)
 	struct net_device *netdev = pool->netdev;
 
 	netdev_assert_locked_ops_compat(netdev);
-	xp_disable_drv_zc(pool);
+	if (pool->pp)
+		xsk_pp_unbind(pool);
+	else
+		xp_disable_drv_zc(pool);
 	xsk_clear_pool_at_qid(netdev, pool->queue_id);
 	hlist_del(&pool->dev_node);
 	pool->netdev = NULL;
@@ -474,7 +507,7 @@ static void xp_check_dma_contiguity(struct xsk_dma_map *dma_map)
 
 static int xp_init_dma_info(struct xsk_buff_pool *pool, struct xsk_dma_map *dma_map)
 {
-	if (!pool->unaligned) {
+	if (!pool->unaligned && pool->heads) {
 		u32 i;
 
 		for (i = 0; i < pool->heads_cnt; i++) {
diff --git a/net/xdp/xsk_pp.c b/net/xdp/xsk_pp.c
index fdd55265a6cd..c2214e718cdb 100644
--- a/net/xdp/xsk_pp.c
+++ b/net/xdp/xsk_pp.c
@@ -8,6 +8,9 @@
  *       +-----RX ring-------+
  */
 
+#include <net/netdev_lock.h>
+#include <net/netdev_queues.h>
+#include <net/netdev_rx_queue.h>
 #include <net/page_pool/helpers.h>
 #include <net/page_pool/memory_provider.h>
 #include <net/xdp_sock_drv.h>
@@ -15,6 +18,8 @@
 #include "xsk.h"
 #include "xsk_queue.h"
 
+#define XSK_PP_DMA_ATTR	(DMA_ATTR_WEAK_ORDERING | DMA_ATTR_SKIP_CPU_SYNC)
+
 enum xsk_pp_chunk {
 	XSK_PP_USER,	/* owned by userspace */
 	XSK_PP_POOL,	/* owned by a page pool */
@@ -30,6 +35,8 @@ struct xsk_pp {
 	refcount_t refs;
 	u32 nr_pools;
 	bool dma_need_sync;
+	/* RX queue of the provider, NULL once it is removed */
+	struct netdev_rx_queue *rxq;
 	u8 *state;
 	u32 reuse_cnt;
 	u32 reuse[];
@@ -236,11 +243,225 @@ static int xsk_pp_nl_fill(void *mp_priv, struct sk_buff *rsp,
 	return 0;
 }
 
+/* The queue no longer uses the provider, and its DMA stopped */
+static void xsk_pp_detach(struct xsk_pp *pp)
+{
+	pp->rxq = NULL;
+	spin_lock_bh(&pp->lock);
+	pp->fq = NULL;
+	spin_unlock_bh(&pp->lock);
+	xp_dma_unmap(pp->pool, XSK_PP_DMA_ATTR);
+}
+
+/* The device unregisters, and is closed */
+static void xsk_pp_uninstall(void *mp_priv, struct netdev_rx_queue *rxq)
+{
+	xsk_pp_detach(mp_priv);
+}
+
 const struct memory_provider_ops xsk_pp_ops = {
 	.init		= xsk_pp_init,
 	.destroy	= xsk_pp_destroy,
 	.alloc_netmems	= xsk_pp_alloc_netmems,
 	.release_netmem	= xsk_pp_release_netmem,
 	.nl_fill	= xsk_pp_nl_fill,
+	.uninstall	= xsk_pp_uninstall,
 	.caps		= MP_CAP_READABLE,
 };
+
+static bool xsk_pp_abandon(struct xsk_pp *pp)
+{
+	struct xsk_buff_pool *pool = pp->pool;
+	bool busy;
+	u32 idx;
+
+	spin_lock_bh(&pp->lock);
+	busy = pp->nr_pools;
+	while (!busy && pp->reuse_cnt) {
+		idx = pp->reuse[--pp->reuse_cnt];
+		pp->state[idx] = XSK_PP_USER;
+		xp_free(&pool->heads[idx]);
+	}
+	spin_unlock_bh(&pp->lock);
+
+	return !busy;
+}
+
+static int xsk_pp_validate(struct net_device *dev, struct xsk_buff_pool *pool,
+			   unsigned int mtu, struct bpf_prog *prog,
+			   struct netlink_ext_ack *extack)
+{
+	struct xsk_rx_check check = {
+		.buf_size = pool->chunk_size,
+		.headroom = xsk_pool_get_headroom(pool),
+		.mtu = mtu,
+		.sg = xsk_pool_uses_sg(pool),
+		.prog = prog,
+	};
+	struct netdev_bpf bpf = {
+		.command = XDP_VALIDATE_XSK_POOL,
+		.xsk_check.check = &check,
+		.xsk_check.extack = extack,
+	};
+
+	return dev->netdev_ops->ndo_bpf(dev, &bpf);
+}
+
+/**
+ * xsk_validate_dev - check AF_XDP page pool queues against a new setting
+ * @dev: device of the queues
+ * @mtu: MTU to check
+ * @prog: XDP program to check, or NULL for the current one
+ * @mode: XDP mode of @prog
+ * @extack: netlink extended ack
+ *
+ * Context: holds the instance lock of @dev, or RTNL for a device without it.
+ * Return: 0 if the driver accepts all queues of @dev that have an AF_XDP
+ * memory provider, or its error.
+ */
+int xsk_validate_dev(struct net_device *dev, unsigned int mtu,
+		     struct bpf_prog *prog, enum bpf_xdp_mode mode,
+		     struct netlink_ext_ack *extack)
+{
+	struct netdev_rx_queue *rxq;
+	struct xsk_pp *pp;
+	unsigned int i;
+	int err;
+
+	netdev_assert_locked_ops_compat(dev);
+
+	for (i = 0; i < dev->real_num_rx_queues; i++) {
+		rxq = __netif_get_rx_queue(dev, i);
+		if (rxq->mp_params.mp_ops != &xsk_pp_ops)
+			continue;
+
+		/* Generic XDP runs outside the queue NAPI */
+		if (mode == XDP_MODE_SKB) {
+			NL_SET_ERR_MSG(extack,
+				       "generic XDP cannot feed an AF_XDP page pool socket");
+			return -EBUSY;
+		}
+
+		pp = rxq->mp_params.mp_priv;
+		err = xsk_pp_validate(dev, pp->pool, mtu, prog, extack);
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(xsk_validate_dev);
+
+/**
+ * xsk_rxq_pool - get the AF_XDP pool that provides memory to an RX queue
+ * @dev: device of the queue
+ * @queue_id: RX queue
+ *
+ * The pool stays valid while the queue that the caller allocates runs.
+ *
+ * Context: holds the instance lock of @dev.
+ * Return: the buffer pool, or NULL.
+ */
+struct xsk_buff_pool *xsk_rxq_pool(struct net_device *dev, u16 queue_id)
+{
+	struct netdev_rx_queue *rxq;
+	struct xsk_pp *pp;
+
+	netdev_assert_locked(dev);
+
+	if (queue_id >= dev->real_num_rx_queues)
+		return NULL;
+
+	rxq = __netif_get_rx_queue(dev, queue_id);
+	if (rxq->mp_params.mp_ops != &xsk_pp_ops)
+		return NULL;
+
+	pp = rxq->mp_params.mp_priv;
+	return pp->pool;
+}
+EXPORT_SYMBOL_GPL(xsk_rxq_pool);
+
+bool xsk_pp_supported(struct net_device *dev)
+{
+	const struct netdev_queue_mgmt_ops *qops = dev->queue_mgmt_ops;
+
+	return qops && qops->xsk_page_pool;
+}
+
+/* Called with RTNL and the instance lock of @dev. On error, @pool->pp stays
+ * set if an old page pool still owns chunks; copy mode must not take the pool.
+ */
+int xsk_pp_bind(struct xsk_buff_pool *pool, struct net_device *dev,
+		u16 queue_id)
+{
+	struct pp_memory_provider_params mp = { .mp_ops = &xsk_pp_ops };
+	struct device *dma_dev;
+	struct xsk_pp *pp;
+	int err;
+
+	if (queue_id >= dev->real_num_rx_queues || pool->unaligned)
+		return -EOPNOTSUPP;
+	if ((dev->xdp_features & NETDEV_XDP_ACT_XSK) != NETDEV_XDP_ACT_XSK ||
+	    (xsk_pool_uses_sg(pool) && dev->xdp_zc_max_segs == 1))
+		return -EOPNOTSUPP;
+	if (dev_xdp_prog_id(dev, XDP_MODE_SKB))
+		return -EOPNOTSUPP;
+	if (!netif_all_mps_have_cap(dev, MP_CAP_READABLE))
+		return -EBUSY;
+
+	err = xsk_pp_validate(dev, pool, dev->mtu, NULL, NULL);
+	if (err)
+		return err;
+
+	dma_dev = netdev_queue_get_dma_dev(dev, queue_id, NETDEV_QUEUE_TYPE_RX);
+	if (!dma_dev)
+		return -EOPNOTSUPP;
+
+	err = xp_dma_map(pool, dma_dev, XSK_PP_DMA_ATTR, pool->umem->pgs,
+			 pool->umem->npgs);
+	if (err)
+		return err;
+
+	pp = xsk_pp_create(pool);
+	if (IS_ERR(pp)) {
+		xp_dma_unmap(pool, XSK_PP_DMA_ATTR);
+		return PTR_ERR(pp);
+	}
+
+	mp.mp_priv = pp;
+	mp.rx_page_size = pool->chunk_size;
+	mp.rx_headroom = xsk_pool_get_headroom(pool);
+	err = netif_mp_open_rxq(dev, queue_id, &mp, NULL);
+	if (!err) {
+		pp->rxq = __netif_get_rx_queue(dev, queue_id);
+		pool->pp = pp;
+		pool->xdp_zc_max_segs = dev->xdp_zc_max_segs;
+		return 0;
+	}
+
+	xp_dma_unmap(pool, XSK_PP_DMA_ATTR);
+	/* Copy mode takes the chunks that the provider holds */
+	if (!xp_alloc_heads(pool) && xsk_pp_abandon(pp))
+		xsk_pp_put(pp);
+	else
+		pool->pp = pp;
+
+	return err;
+}
+
+/* Called with RTNL and the instance lock of the device */
+void xsk_pp_unbind(struct xsk_buff_pool *pool)
+{
+	struct xsk_pp *pp = pool->pp;
+	struct pp_memory_provider_params mp = {
+		.mp_ops = &xsk_pp_ops,
+		.mp_priv = pp,
+	};
+
+	/* Unregister removed the provider already */
+	if (!pp->rxq)
+		return;
+
+	netif_mp_close_rxq(pool->netdev, pool->queue_id, &mp);
+	xsk_pp_detach(pp);
+}
-- 
2.56.0

