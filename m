Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794306071;
	b=e0tlQxRh04D8zEiy8WyrADCGe80SPaPjypBlda1v2J7L/cZ3p/VYAfL3X8TtIo3INZXB
	 XJx14Asjfri6JGndek35Ki+0ukO1hQ9OBUiXBXpIJ6yeI3FORMMMWT6HWOs3ykOZr0XcD
	 Inz6dpj3Mo/RmPIAFivvXfvQNBHSbvm9AK3lwUDCcfwB5sHuDQpc6/9UG+06ZSz9QRoQD
	 PUNHNAFAIJ1IAmAp/uoIMj21d76lnTraEglRSLmW+Kq/u7r2IT5BfStEwGbYg6iqB9KNK
	 QEMLYC9aifblLOPAJPxISWpA89cOWJpd+65J6on0mJc14rIyObPrasTgEDfZhVVhYhw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794306071;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=R1hap9nzJEoggZoxWzvPk4o6CjKXiYGLdrpOjrIMfXA=;
	b=J/KsUUZ6u90M8mg+UYKtCF/5PE4oSfrtQVU5kz8Pn3qY0C99LOYlrvsBAGW9tInDHIGX
	 xjolLSh5UJU4ZkfyK75VDCCXBGKk8vhNEtcSA8xOsrJZHD22l3CQRlAV78NzPpea/vk/0
	 kBePoIKqgr2yaIkuO8sxYCFpU1aVFTseG2nn+FAiNudxbeYE8cUVStsGoMx2cZENCA2YG
	 lSDuRF4lR52V/v0bUpjHMEAhos09DBtFz948M4x14iKWZnrGw3WCHFG9uo1t2XNpu1oSy
	 A4G71fyxoDmYT70knNtSIeOHYjDqM1Saeu8P+rZhf27XMhxlOyLWj/eitAV1nvOLhag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D92GPw4D;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E60A60A6F45;
	Tue, 10 Nov 2026 10:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D92GPw4D
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 462431F0089F;
	Tue, 10 Nov 2026 10:21:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794306070;
	bh=R1hap9nzJEoggZoxWzvPk4o6CjKXiYGLdrpOjrIMfXA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=D92GPw4DSyaddSMBA/fUifmA1xEnUhLjtzInEH+6r3my7NVWgWv0O9ig/KHX8eGTz
	 +iwSucOnYpfFZRNk42b92PKouuh1T4KC4HBCl16I0hjsSMPzgE5hRUWD1ON8NgjleJ
	 ApfOhdbSHWsJDolkO7mLu78Ia4Qy6pE5A5k75qj/A3tYJCbX2GX0Xhbow0WR7fr88K
	 gG7j3P7O4WlHZkTaSQ4uggGi6CHKvG7xaJAIcwZymEXbz+LBSOLlxuE9j63BhA+Vuu
	 meg7kR37nPMsLaz/9kgtGxgPN5nR03G67nxfe8vEPUQOOos6b8FfscYZzjxz/aiw/P
	 iTO1Sy9c6pAwg==
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
Subject: [PATCH net-next v1 02/11] net: Add memory provider capabilities
Date: Tue, 10 Nov 2026 11:20:23 +0100
Message-ID: <20261110102039.1002605-3-bjorn@kernel.org>
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

The core treats every memory provider as unreadable: installing one
needs header split and no XDP program, and any page pool that allows
unreadable netmem takes it. An AF_XDP UMEM provider is readable, needs
XDP, and hands out whole buffers.

Describe providers by MP_CAP_READABLE and MP_CAP_FRAG; devmem and
io_uring keep their behavior with MP_CAP_FRAG. A page pool takes a
readable provider only with the new PP_FLAG_MEM_PROVIDER:
PP_FLAG_ALLOW_UNREADABLE_NETMEM says that a driver handles unreadable
netmem, not that it handles any provider.

Signed-off-by: Björn Töpel <bjorn@kernel.org>
---
 Documentation/networking/netmem.rst     |  5 ++++
 drivers/net/netkit.c                    |  3 +-
 include/net/page_pool/helpers.h         | 14 +++++++++-
 include/net/page_pool/memory_provider.h | 14 ++++++++++
 include/net/page_pool/types.h           | 15 ++++++++--
 io_uring/zcrx.c                         |  1 +
 net/core/dev.c                          | 10 ++++---
 net/core/devmem.c                       |  1 +
 net/core/netdev_rx_queue.c              | 37 ++++++++++++++++++++-----
 net/core/page_pool.c                    | 34 +++++++++++++++++++++--
 net/ethtool/rings.c                     |  7 +++--
 net/xdp/xsk_buff_pool.c                 |  3 +-
 12 files changed, 122 insertions(+), 22 deletions(-)

diff --git a/Documentation/networking/netmem.rst b/Documentation/networking/netmem.rst
index 6871dcdd700c..39cb75339704 100644
--- a/Documentation/networking/netmem.rst
+++ b/Documentation/networking/netmem.rst
@@ -103,6 +103,11 @@ Driver RX Requirements
      which knows when dma-syncing is (or is not) appropriate.
    - PP_FLAG_ALLOW_UNREADABLE_NETMEM. The driver must specify this flag iff
      tcp-data-split is enabled.
+   - PP_FLAG_MEM_PROVIDER. The page pool takes memory from the memory
+     provider of its RX queue, readable or not. Page pool creation fails if
+     the provider is unreadable and PP_FLAG_ALLOW_UNREADABLE_NETMEM is not
+     set, so do not set it on header page pools of such a queue. Without it,
+     PP_FLAG_ALLOW_UNREADABLE_NETMEM selects unreadable providers only.
 
 5. The driver must not assume the netmem is readable and/or backed by pages.
    The netmem returned by the page_pool may be unreadable, in which case
diff --git a/drivers/net/netkit.c b/drivers/net/netkit.c
index 82e608e733d9..df672ed5ffcc 100644
--- a/drivers/net/netkit.c
+++ b/drivers/net/netkit.c
@@ -12,6 +12,7 @@
 #include <net/netdev_lock.h>
 #include <net/netdev_queues.h>
 #include <net/netdev_rx_queue.h>
+#include <net/page_pool/memory_provider.h>
 #include <net/xdp_sock_drv.h>
 #include <net/netkit.h>
 #include <net/dst.h>
@@ -289,7 +290,7 @@ static int netkit_xsk(struct net_device *dev, struct netdev_bpf *xdp)
 		ret = -EOPNOTSUPP;
 		goto out;
 	}
-	if (!create || !dev_get_min_mp_channel_count(phys))
+	if (!create || netif_all_mps_have_cap(phys, MP_CAP_READABLE))
 		ret = phys->netdev_ops->ndo_bpf(phys, &xdp_lower);
 out:
 	netdev_unlock(phys);
diff --git a/include/net/page_pool/helpers.h b/include/net/page_pool/helpers.h
index 28635ce9454e..96e6b62cdebb 100644
--- a/include/net/page_pool/helpers.h
+++ b/include/net/page_pool/helpers.h
@@ -62,6 +62,7 @@
 
 #include <linux/dma-mapping.h>
 
+#include <net/page_pool/memory_provider.h>
 #include <net/page_pool/types.h>
 #include <net/net_debug.h>
 #include <net/netmem.h>
@@ -519,7 +520,18 @@ static inline void page_pool_nid_changed(struct page_pool *pool, int new_nid)
  */
 static inline bool page_pool_is_unreadable(struct page_pool *pool)
 {
-	return !!pool->mp_ops;
+	return pool->mp_ops && !(pool->mp_ops->caps & MP_CAP_READABLE);
+}
+
+/**
+ * page_pool_supports_frag() - may page pool buffers be split
+ * @pool: queried page pool
+ *
+ * Return: false if the memory provider of @pool hands out whole buffers only
+ */
+static inline bool page_pool_supports_frag(const struct page_pool *pool)
+{
+	return !pool->mp_ops || pool->mp_ops->caps & MP_CAP_FRAG;
 }
 
 #endif /* _NET_PAGE_POOL_HELPERS_H */
diff --git a/include/net/page_pool/memory_provider.h b/include/net/page_pool/memory_provider.h
index bceb5f7740e2..4417e54a0f81 100644
--- a/include/net/page_pool/memory_provider.h
+++ b/include/net/page_pool/memory_provider.h
@@ -19,6 +19,18 @@ struct sk_buff;
  * Per-provider custom logic must be delegated to memory_provider_ops rather
  * than handled directly in page_pool core code.
  */
+
+/**
+ * enum mp_caps - memory provider capabilities
+ * @MP_CAP_READABLE: The CPU can access provider memory. It may back header
+ *	page pools, and XDP programs may run on it.
+ * @MP_CAP_FRAG: Page pool fragments may split provider buffers.
+ */
+enum mp_caps {
+	MP_CAP_READABLE		= BIT(0),
+	MP_CAP_FRAG		= BIT(1),
+};
+
 struct memory_provider_ops {
 	netmem_ref (*alloc_netmems)(struct page_pool *pool, gfp_t gfp);
 	bool (*release_netmem)(struct page_pool *pool, netmem_ref netmem);
@@ -27,6 +39,7 @@ struct memory_provider_ops {
 	int (*nl_fill)(void *mp_priv, struct sk_buff *rsp,
 		       struct netdev_rx_queue *rxq);
 	void (*uninstall)(void *mp_priv, struct netdev_rx_queue *rxq);
+	u32 caps;
 };
 
 bool net_mp_niov_set_dma_addr(struct net_iov *niov, dma_addr_t addr);
@@ -38,6 +51,7 @@ int netif_mp_open_rxq(struct net_device *dev, unsigned int rxq_idx,
 		      struct netlink_ext_ack *extack);
 int netif_mp_close_rxq(struct net_device *dev, unsigned int rxq_idx,
 		       const struct pp_memory_provider_params *old_p);
+bool netif_all_mps_have_cap(struct net_device *dev, u32 cap);
 
 /**
   * net_mp_netmem_place_in_cache() - give a netmem to a page pool
diff --git a/include/net/page_pool/types.h b/include/net/page_pool/types.h
index 6d543076a0c0..0d48c05f1462 100644
--- a/include/net/page_pool/types.h
+++ b/include/net/page_pool/types.h
@@ -31,8 +31,19 @@
  */
 #define PP_FLAG_ALLOW_UNREADABLE_NETMEM BIT(3)
 
+/* Take memory from the memory provider of the RX queue, if one is installed.
+ * Set page_pool_params.slow.netdev and queue_idx, and create the pool under
+ * the instance lock of the netdev.
+ * An unreadable provider also needs PP_FLAG_ALLOW_UNREADABLE_NETMEM, or page
+ * pool creation fails. Without this flag, PP_FLAG_ALLOW_UNREADABLE_NETMEM
+ * selects unreadable providers only.
+ */
+#define PP_FLAG_MEM_PROVIDER	BIT(4)
+
 #define PP_FLAG_ALL		(PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV | \
-				 PP_FLAG_SYSTEM_POOL | PP_FLAG_ALLOW_UNREADABLE_NETMEM)
+				 PP_FLAG_SYSTEM_POOL | \
+				 PP_FLAG_ALLOW_UNREADABLE_NETMEM | \
+				 PP_FLAG_MEM_PROVIDER)
 
 /* Index limit to stay within PP_DMA_INDEX_BITS for DMA indices */
 #define PP_DMA_INDEX_LIMIT XA_LIMIT(1, BIT(PP_DMA_INDEX_BITS) - 1)
@@ -82,7 +93,7 @@ struct pp_alloc_cache {
  * @netdev:	netdev this pool will serve (leave as NULL if none or multiple)
  * @queue_idx:	queue idx this page_pool is being created for.
  * @flags:	PP_FLAG_DMA_MAP, PP_FLAG_DMA_SYNC_DEV, PP_FLAG_SYSTEM_POOL,
- *		PP_FLAG_ALLOW_UNREADABLE_NETMEM.
+ *		PP_FLAG_ALLOW_UNREADABLE_NETMEM, PP_FLAG_MEM_PROVIDER.
  */
 struct page_pool_params {
 	struct_group_tagged(page_pool_params_fast, fast,
diff --git a/io_uring/zcrx.c b/io_uring/zcrx.c
index 555f27e6c1ba..3b5bf97aa203 100644
--- a/io_uring/zcrx.c
+++ b/io_uring/zcrx.c
@@ -1478,6 +1478,7 @@ static const struct memory_provider_ops io_uring_pp_zc_ops = {
 	.destroy		= io_pp_zc_destroy,
 	.nl_fill		= io_pp_nl_fill,
 	.uninstall		= io_pp_uninstall,
+	.caps			= MP_CAP_FRAG,
 };
 
 static unsigned zcrx_parse_rq(netmem_ref *netmem_array, unsigned nr,
diff --git a/net/core/dev.c b/net/core/dev.c
index 3b60b15e2175..663fe3e32ea0 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -10546,8 +10546,9 @@ int netif_xdp_propagate(struct net_device *dev, struct netdev_bpf *bpf)
 		return -EBUSY;
 	}
 
-	if (dev_get_min_mp_channel_count(dev)) {
-		NL_SET_ERR_MSG(bpf->extack, "unable to propagate XDP to device using memory provider");
+	if (!netif_all_mps_have_cap(dev, MP_CAP_READABLE)) {
+		NL_SET_ERR_MSG(bpf->extack,
+			       "unable to propagate XDP to device using unreadable memory provider");
 		return -EBUSY;
 	}
 
@@ -10622,8 +10623,9 @@ static int dev_xdp_install(struct net_device *dev, enum bpf_xdp_mode mode,
 		return -EBUSY;
 	}
 
-	if (dev_get_min_mp_channel_count(dev)) {
-		NL_SET_ERR_MSG(extack, "unable to install XDP to device using memory provider");
+	if (!netif_all_mps_have_cap(dev, MP_CAP_READABLE)) {
+		NL_SET_ERR_MSG(extack,
+			       "unable to install XDP to device using unreadable memory provider");
 		return -EBUSY;
 	}
 
diff --git a/net/core/devmem.c b/net/core/devmem.c
index b9146b1f294a..8f190b574beb 100644
--- a/net/core/devmem.c
+++ b/net/core/devmem.c
@@ -698,4 +698,5 @@ static const struct memory_provider_ops dmabuf_devmem_ops = {
 	.release_netmem		= mp_dmabuf_devmem_release_page,
 	.nl_fill		= mp_dmabuf_devmem_nl_fill,
 	.uninstall		= mp_dmabuf_devmem_uninstall,
+	.caps			= MP_CAP_FRAG,
 };
diff --git a/net/core/netdev_rx_queue.c b/net/core/netdev_rx_queue.c
index a7261fedd5e7..9e14a747f9b5 100644
--- a/net/core/netdev_rx_queue.c
+++ b/net/core/netdev_rx_queue.c
@@ -82,9 +82,13 @@ __netif_get_rx_queue_lease(struct net_device **dev, unsigned int *rxq_idx,
 /* See also page_pool_is_unreadable() */
 bool netif_rxq_has_unreadable_mp(struct net_device *dev, unsigned int rxq_idx)
 {
-	if (rxq_idx < dev->real_num_rx_queues)
-		return __netif_get_rx_queue(dev, rxq_idx)->mp_params.mp_ops;
-	return false;
+	const struct memory_provider_ops *ops;
+
+	if (rxq_idx >= dev->real_num_rx_queues)
+		return false;
+
+	ops = __netif_get_rx_queue(dev, rxq_idx)->mp_params.mp_ops;
+	return ops && !(ops->caps & MP_CAP_READABLE);
 }
 EXPORT_SYMBOL(netif_rxq_has_unreadable_mp);
 
@@ -95,6 +99,22 @@ bool netif_rxq_has_mp(struct net_device *dev, unsigned int rxq_idx)
 	return false;
 }
 
+bool netif_all_mps_have_cap(struct net_device *dev, u32 cap)
+{
+	const struct memory_provider_ops *ops;
+	unsigned int i;
+
+	netdev_assert_locked_ops_compat(dev);
+
+	for (i = 0; i < dev->real_num_rx_queues; i++) {
+		ops = dev->_rx[i].mp_params.mp_ops;
+		if (ops && (ops->caps & cap) != cap)
+			return false;
+	}
+
+	return true;
+}
+
 static int netdev_rx_queue_reconfig(struct net_device *dev,
 				    unsigned int rxq_idx,
 				    struct netdev_queue_config *qcfg_old,
@@ -189,6 +209,7 @@ static int __netif_mp_open_rxq(struct net_device *dev, unsigned int rxq_idx,
 			       struct netlink_ext_ack *extack)
 {
 	const struct netdev_queue_mgmt_ops *qops = dev->queue_mgmt_ops;
+	bool unreadable = !(p->mp_ops->caps & MP_CAP_READABLE);
 	struct netdev_queue_config qcfg[2];
 	struct netdev_rx_queue *rxq;
 	int ret;
@@ -196,16 +217,18 @@ static int __netif_mp_open_rxq(struct net_device *dev, unsigned int rxq_idx,
 	if (!qops)
 		return -EOPNOTSUPP;
 
-	if (dev->cfg->hds_config != ETHTOOL_TCP_DATA_SPLIT_ENABLED) {
+	if (unreadable &&
+	    dev->cfg->hds_config != ETHTOOL_TCP_DATA_SPLIT_ENABLED) {
 		NL_SET_ERR_MSG(extack, "tcp-data-split is disabled");
 		return -EINVAL;
 	}
-	if (dev->cfg->hds_thresh) {
+	if (unreadable && dev->cfg->hds_thresh) {
 		NL_SET_ERR_MSG(extack, "hds-thresh is not zero");
 		return -EINVAL;
 	}
-	if (dev_xdp_prog_count(dev)) {
-		NL_SET_ERR_MSG(extack, "unable to custom memory provider to device with XDP program attached");
+	if (unreadable && dev_xdp_prog_count(dev)) {
+		NL_SET_ERR_MSG(extack,
+			       "unable to use unreadable memory provider with XDP program attached");
 		return -EEXIST;
 	}
 	if (p->rx_page_size && !(qops->supported_params & QCFG_RX_PAGE_SIZE)) {
diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index d7c88c0b67e5..d88a3ea528d4 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -188,6 +188,29 @@ static void page_pool_struct_check(void)
 				    PAGE_POOL_FRAG_GROUP_ALIGN);
 }
 
+static int page_pool_select_mp(struct page_pool *pool,
+			       const struct pp_memory_provider_params *mpp)
+{
+	const struct memory_provider_ops *ops = mpp->mp_ops;
+	unsigned int flags = pool->slow.flags;
+	bool readable;
+
+	if (!ops)
+		return 0;
+
+	readable = ops->caps & MP_CAP_READABLE;
+	if (flags & PP_FLAG_MEM_PROVIDER) {
+		if (!readable && !(flags & PP_FLAG_ALLOW_UNREADABLE_NETMEM))
+			return -EOPNOTSUPP;
+	} else if (readable) {
+		return 0;
+	}
+
+	pool->mp_priv = mpp->mp_priv;
+	pool->mp_ops = ops;
+	return 0;
+}
+
 static int page_pool_init(struct page_pool *pool,
 			  const struct page_pool_params *params,
 			  int cpuid)
@@ -272,12 +295,14 @@ static int page_pool_init(struct page_pool *pool,
 
 	xa_init_flags(&pool->dma_mapped, XA_FLAGS_ALLOC1);
 
-	if (pool->slow.flags & PP_FLAG_ALLOW_UNREADABLE_NETMEM) {
+	if (pool->slow.flags & (PP_FLAG_MEM_PROVIDER |
+				PP_FLAG_ALLOW_UNREADABLE_NETMEM)) {
 		netdev_assert_locked(pool->slow.netdev);
 		rxq = __netif_get_rx_queue(pool->slow.netdev,
 					   pool->slow.queue_idx);
-		pool->mp_priv = rxq->mp_params.mp_priv;
-		pool->mp_ops = rxq->mp_params.mp_ops;
+		err = page_pool_select_mp(pool, &rxq->mp_params);
+		if (err)
+			goto free_ptr_ring;
 	}
 
 	if (pool->mp_ops) {
@@ -1070,6 +1095,9 @@ netmem_ref page_pool_alloc_frag_netmem(struct page_pool *pool,
 	unsigned int max_size = PAGE_SIZE << pool->p.order;
 	netmem_ref netmem = pool->frag_page;
 
+	if (static_branch_unlikely(&page_pool_mem_providers) &&
+	    WARN_ON_ONCE(!page_pool_supports_frag(pool)))
+		return 0;
 	if (WARN_ON(size > max_size))
 		return 0;
 
diff --git a/net/ethtool/rings.c b/net/ethtool/rings.c
index e3810c0320e3..378e171d4e10 100644
--- a/net/ethtool/rings.c
+++ b/net/ethtool/rings.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only
 
 #include <net/netdev_queues.h>
+#include <net/page_pool/memory_provider.h>
 
 #include "common.h"
 #include "netlink.h"
@@ -258,15 +259,15 @@ ethnl_set_rings(struct ethnl_req_info *req_info, struct genl_info *info)
 		return -EINVAL;
 	}
 
-	if (dev_get_min_mp_channel_count(dev)) {
+	if (!netif_all_mps_have_cap(dev, MP_CAP_READABLE)) {
 		if (kernel_ringparam.tcp_data_split !=
 		    ETHTOOL_TCP_DATA_SPLIT_ENABLED) {
 			NL_SET_ERR_MSG(info->extack,
-				       "can't disable tcp-data-split while device has memory provider enabled");
+				       "can't disable tcp-data-split while device has unreadable memory provider enabled");
 			return -EINVAL;
 		} else if (kernel_ringparam.hds_thresh) {
 			NL_SET_ERR_MSG(info->extack,
-				       "can't set non-zero hds_thresh while device is memory provider enabled");
+				       "can't set non-zero hds_thresh while device has unreadable memory provider enabled");
 			return -EINVAL;
 		}
 	}
diff --git a/net/xdp/xsk_buff_pool.c b/net/xdp/xsk_buff_pool.c
index 7750d2ec4ee2..18966bbdb5b7 100644
--- a/net/xdp/xsk_buff_pool.c
+++ b/net/xdp/xsk_buff_pool.c
@@ -2,6 +2,7 @@
 
 #include <linux/netdevice.h>
 #include <net/netdev_lock.h>
+#include <net/page_pool/memory_provider.h>
 #include <net/xsk_buff_pool.h>
 #include <net/xdp_sock.h>
 #include <net/xdp_sock_drv.h>
@@ -241,7 +242,7 @@ int xp_assign_dev(struct xsk_buff_pool *pool,
 		goto err_unreg_pool;
 	}
 
-	if (dev_get_min_mp_channel_count(netdev)) {
+	if (!netif_all_mps_have_cap(netdev, MP_CAP_READABLE)) {
 		err = -EBUSY;
 		goto err_unreg_pool;
 	}
-- 
2.56.0

