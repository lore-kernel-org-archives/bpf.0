Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C75B3EB7F0;
	Fri,  2 Oct 2026 19:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790967673; cv=none; b=Fq+fZzd6Djov9VREg6hNSJxkQ4vOP6sxVv6bR3cNrEKA2h+cOaIjG+3zQu6cVeiE0QT6qrQTq7xlZclWy5QUoR88MoUQ44/puHdDgeqUVCdd6LeGM6hO1UUkSk4T9lnQUzjXX92/j5EHNR6Shyf2zoTb91/HXGCVBNacyDVOq/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790967673; c=relaxed/simple;
	bh=Fe1DoKa/PhUxp5pvpCVduRWXiIiyULHYsQIZ/RQ1SeA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Pw6hiz6ZijyasoDoaX9y3gS9epOBcfgY2oNRZCR0bxv1pTKeP4AMjup9Fhy9FDeE6Ts7NkGgoezSkEvyfYRW2C/2RG+v7rGIR7GrVsdUfq9wrKsx0KwovC30Ff5Ws6UpjzdS2GXiaZxQRUkQSD0rdq1ZFg8plnOIvwKUn3uoQp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b4E/FqC2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b4E/FqC2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4ECC01F00898;
	Fri,  2 Oct 2026 19:00:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790967656;
	bh=+LixddtoWStKB8YM5SoOfsf8CF48GlMxqhc3dpO2Bvs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=b4E/FqC2FW4GT168/IyDtvl1a7j73c5XeL4KC5QlA+IhR6IH5EnUOICyIFHDUveSo
	 URdHUbdqAyWFJiU9xil0nYJp/BfozcJ2sywgtPlcALB3DCxgKws9yEv8kM+wKHVR1L
	 kE5a8r93MuAmrNscoOtSfU7gBsTV7wrVnl3clkyNnoa8bFsYnLbkMXvDyKDjSOjNR+
	 swGb8b9w91f09oVb6iz4/MO6voSsEv/f0EUsFnGWE+5vnEVhz9ZAWx1Pyk+SVuEYQm
	 gE1/MKN+2XHicu60tnUTZrpaECzDFBIeqsCF2ClMXWlkF0lf3ge0ClC8d8PCAZ7g1Q
	 OSnUpukpgWClw==
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
Subject: [RFC net-next 03/15] net: Add memory provider capabilities
Date: Fri,  2 Oct 2026 21:00:04 +0200
Message-ID: <20261002190018.696925-4-bjorn@kernel.org>
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

The current memory providers, devmem and io_uring zero-copy RX, give
memory that the CPU cannot read. The core allows them only on queues
with header-data split on, a zero header-split threshold, and no XDP
program. AF_XDP needs a provider that the CPU can read and that
works with XDP.

Add a capability field to the provider operations, with
MP_CAP_READABLE as the first flag. Apply the header-split and XDP
rules only to providers without it. A queue with an AF_XDP buffer
pool still rejects other providers, but it accepts the provider made
from that same pool.

Provider memory can become free while a queue is restarted, and no
device event reports it. After a restart, and after a failed restart
is rolled back, schedule the queue's NAPI if the queue has a
provider, so the driver tries to refill.

Signed-off-by: Björn Töpel <bjorn@kernel.org>
---
 Documentation/networking/netmem.rst     |  7 ++-
 include/net/page_pool/memory_provider.h | 11 +++++
 include/net/page_pool/types.h           |  7 +--
 net/core/dev.c                          |  4 +-
 net/core/netdev_rx_queue.c              | 57 ++++++++++++++++++++-----
 net/ethtool/rings.c                     | 18 +++-----
 net/xdp/xsk_buff_pool.c                 |  3 +-
 7 files changed, 78 insertions(+), 29 deletions(-)

diff --git a/Documentation/networking/netmem.rst b/Documentation/networking/netmem.rst
index 217869d1108d..aacd185843ac 100644
--- a/Documentation/networking/netmem.rst
+++ b/Documentation/networking/netmem.rst
@@ -48,8 +48,11 @@ Driver RX Requirements
    - PP_FLAG_DMA_SYNC_DEV: netmem dma addr is not necessarily dma-syncable
      by the driver. The driver must delegate the dma syncing to the page_pool,
      which knows when dma-syncing is (or is not) appropriate.
-   - PP_FLAG_ALLOW_UNREADABLE_NETMEM. The driver must specify this flag iff
-     tcp-data-split is enabled.
+   - PP_FLAG_ALLOW_UNREADABLE_NETMEM. This opts the page pool into the memory
+     provider configured on its RX queue. For a provider without
+     MP_CAP_READABLE, the driver must specify it only for a payload pool
+     with tcp-data-split enabled. A readable provider may also back a
+     regular or header pool.
 
 5. The driver must not assume the netmem is readable and/or backed by pages.
    The netmem returned by the page_pool may be unreadable, in which case
diff --git a/include/net/page_pool/memory_provider.h b/include/net/page_pool/memory_provider.h
index 255ce4cfd975..d18ec079ffe2 100644
--- a/include/net/page_pool/memory_provider.h
+++ b/include/net/page_pool/memory_provider.h
@@ -9,6 +9,15 @@ struct netdev_rx_queue;
 struct netlink_ext_ack;
 struct sk_buff;
 
+/**
+ * enum mp_caps - memory provider capabilities
+ * @MP_CAP_READABLE: The CPU can access provider buffers. They may back
+ *	header and regular page pools, and XDP programs may run on them.
+ */
+enum mp_caps {
+	MP_CAP_READABLE		= BIT(0),
+};
+
 struct memory_provider_ops {
 	netmem_ref (*alloc_netmems)(struct page_pool *pool, gfp_t gfp);
 	bool (*release_netmem)(struct page_pool *pool, netmem_ref netmem);
@@ -17,11 +26,13 @@ struct memory_provider_ops {
 	int (*nl_fill)(void *mp_priv, struct sk_buff *rsp,
 		       struct netdev_rx_queue *rxq);
 	void (*uninstall)(void *mp_priv, struct netdev_rx_queue *rxq);
+	u32 caps;
 };
 
 bool net_mp_niov_set_dma_addr(struct net_iov *niov, dma_addr_t addr);
 void net_mp_niov_set_page_pool(struct page_pool *pool, struct net_iov *niov);
 void net_mp_niov_clear_page_pool(struct net_iov *niov);
+bool netif_mp_lacks_cap(struct net_device *dev, u32 cap);
 
 int netif_mp_open_rxq(struct net_device *dev, unsigned int rxq_idx,
 		      const struct pp_memory_provider_params *p,
diff --git a/include/net/page_pool/types.h b/include/net/page_pool/types.h
index 03da138722f5..a96376613dda 100644
--- a/include/net/page_pool/types.h
+++ b/include/net/page_pool/types.h
@@ -22,9 +22,10 @@
 					*/
 #define PP_FLAG_SYSTEM_POOL	BIT(2) /* Global system page_pool */
 
-/* Allow unreadable (net_iov backed) netmem in this page_pool. Drivers setting
- * this must be able to support unreadable netmem, where netmem_address() would
- * return NULL. This flag should not be set for header page_pools.
+/* Allow memory-provider (net_iov backed) netmem in this page_pool. Drivers
+ * setting this must honor the provider's capabilities. Unless the provider has
+ * MP_CAP_READABLE, netmem_address() returns NULL, and the flag must not be set
+ * for a header page_pool.
  *
  * If the driver sets PP_FLAG_ALLOW_UNREADABLE_NETMEM, it should also set
  * page_pool_params.slow.queue_idx.
diff --git a/net/core/dev.c b/net/core/dev.c
index 5ac08da8b9d7..12b532c09a9c 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -10423,7 +10423,7 @@ int netif_xdp_propagate(struct net_device *dev, struct netdev_bpf *bpf)
 		return -EBUSY;
 	}
 
-	if (dev_get_min_mp_channel_count(dev)) {
+	if (netif_mp_lacks_cap(dev, MP_CAP_READABLE)) {
 		NL_SET_ERR_MSG(bpf->extack, "unable to propagate XDP to device using memory provider");
 		return -EBUSY;
 	}
@@ -10499,7 +10499,7 @@ static int dev_xdp_install(struct net_device *dev, enum bpf_xdp_mode mode,
 		return -EBUSY;
 	}
 
-	if (dev_get_min_mp_channel_count(dev)) {
+	if (netif_mp_lacks_cap(dev, MP_CAP_READABLE)) {
 		NL_SET_ERR_MSG(extack, "unable to install XDP to device using memory provider");
 		return -EBUSY;
 	}
diff --git a/net/core/netdev_rx_queue.c b/net/core/netdev_rx_queue.c
index 00a7011eb4d5..610e31d1a717 100644
--- a/net/core/netdev_rx_queue.c
+++ b/net/core/netdev_rx_queue.c
@@ -82,8 +82,12 @@ __netif_get_rx_queue_lease(struct net_device **dev, unsigned int *rxq_idx,
 /* See also page_pool_is_unreadable() */
 bool netif_rxq_has_unreadable_mp(struct net_device *dev, unsigned int rxq_idx)
 {
-	if (rxq_idx < dev->real_num_rx_queues)
-		return __netif_get_rx_queue(dev, rxq_idx)->mp_params.mp_ops;
+	const struct memory_provider_ops *ops;
+
+	if (rxq_idx < dev->real_num_rx_queues) {
+		ops = __netif_get_rx_queue(dev, rxq_idx)->mp_params.mp_ops;
+		return ops && !(ops->caps & MP_CAP_READABLE);
+	}
 	return false;
 }
 EXPORT_SYMBOL(netif_rxq_has_unreadable_mp);
@@ -95,6 +99,32 @@ bool netif_rxq_has_mp(struct net_device *dev, unsigned int rxq_idx)
 	return false;
 }
 
+/* Return true if an installed memory provider lacks @cap. */
+bool netif_mp_lacks_cap(struct net_device *dev, u32 cap)
+{
+	const struct memory_provider_ops *ops;
+	int i;
+
+	netdev_assert_locked_ops_compat(dev);
+
+	for (i = dev->real_num_rx_queues - 1; i >= 0; i--) {
+		ops = dev->_rx[i].mp_params.mp_ops;
+		if (ops && (ops->caps & cap) != cap)
+			return true;
+	}
+
+	return false;
+}
+
+/* Provider memory may become available while the queue is replaced,
+ * without a device event to report it.
+ */
+static void netdev_rx_queue_kick(struct netdev_rx_queue *rxq)
+{
+	if (rxq->mp_params.mp_ops && rxq->napi)
+		napi_schedule(rxq->napi);
+}
+
 static int netdev_rx_queue_reconfig(struct net_device *dev,
 				    unsigned int rxq_idx,
 				    struct netdev_queue_config *qcfg_old,
@@ -142,6 +172,8 @@ static int netdev_rx_queue_reconfig(struct net_device *dev,
 	}
 
 	qops->ndo_queue_mem_free(dev, old_mem);
+	if (netif_running(dev))
+		netdev_rx_queue_kick(rxq);
 
 	kvfree(old_mem);
 	kvfree(new_mem);
@@ -165,6 +197,11 @@ static int netdev_rx_queue_reconfig(struct net_device *dev,
 
 err_free_new_queue_mem:
 	qops->ndo_queue_mem_free(dev, new_mem);
+	/* Freeing the replacement can hand provider memory back to the old
+	 * queue, which still runs unless the rollback failed.
+	 */
+	if (err != -ENETDOWN && netif_running(dev))
+		netdev_rx_queue_kick(rxq);
 
 err_free_old_mem:
 	kvfree(old_mem);
@@ -189,6 +226,7 @@ static int __netif_mp_open_rxq(struct net_device *dev, unsigned int rxq_idx,
 			       struct netlink_ext_ack *extack)
 {
 	const struct netdev_queue_mgmt_ops *qops = dev->queue_mgmt_ops;
+	u32 caps = p->mp_ops->caps;
 	struct netdev_queue_config qcfg[2];
 	struct netdev_rx_queue *rxq;
 	int ret;
@@ -196,15 +234,13 @@ static int __netif_mp_open_rxq(struct net_device *dev, unsigned int rxq_idx,
 	if (!qops)
 		return -EOPNOTSUPP;
 
-	if (dev->cfg->hds_config != ETHTOOL_TCP_DATA_SPLIT_ENABLED) {
-		NL_SET_ERR_MSG(extack, "tcp-data-split is disabled");
+	if ((dev->cfg->hds_config != ETHTOOL_TCP_DATA_SPLIT_ENABLED ||
+	     dev->cfg->hds_thresh) && !(caps & MP_CAP_READABLE)) {
+		NL_SET_ERR_MSG(extack,
+			       "memory provider does not support current tcp-data-split configuration");
 		return -EINVAL;
 	}
-	if (dev->cfg->hds_thresh) {
-		NL_SET_ERR_MSG(extack, "hds-thresh is not zero");
-		return -EINVAL;
-	}
-	if (dev_xdp_prog_count(dev)) {
+	if (dev_xdp_prog_count(dev) && !(caps & MP_CAP_READABLE)) {
 		NL_SET_ERR_MSG(extack, "unable to custom memory provider to device with XDP program attached");
 		return -EEXIST;
 	}
@@ -219,7 +255,8 @@ static int __netif_mp_open_rxq(struct net_device *dev, unsigned int rxq_idx,
 		return -EEXIST;
 	}
 #ifdef CONFIG_XDP_SOCKETS
-	if (rxq->pool) {
+	/* An AF_XDP pool owns the queue unless it is this provider. */
+	if (rxq->pool && rxq->pool != p->mp_priv) {
 		NL_SET_ERR_MSG(extack, "designated queue already in use by AF_XDP");
 		return -EBUSY;
 	}
diff --git a/net/ethtool/rings.c b/net/ethtool/rings.c
index e3810c0320e3..789d0e328b77 100644
--- a/net/ethtool/rings.c
+++ b/net/ethtool/rings.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only
 
 #include <net/netdev_queues.h>
+#include <net/page_pool/memory_provider.h>
 
 #include "common.h"
 #include "netlink.h"
@@ -258,17 +259,12 @@ ethnl_set_rings(struct ethnl_req_info *req_info, struct genl_info *info)
 		return -EINVAL;
 	}
 
-	if (dev_get_min_mp_channel_count(dev)) {
-		if (kernel_ringparam.tcp_data_split !=
-		    ETHTOOL_TCP_DATA_SPLIT_ENABLED) {
-			NL_SET_ERR_MSG(info->extack,
-				       "can't disable tcp-data-split while device has memory provider enabled");
-			return -EINVAL;
-		} else if (kernel_ringparam.hds_thresh) {
-			NL_SET_ERR_MSG(info->extack,
-				       "can't set non-zero hds_thresh while device is memory provider enabled");
-			return -EINVAL;
-		}
+	if ((kernel_ringparam.tcp_data_split !=
+	     ETHTOOL_TCP_DATA_SPLIT_ENABLED || kernel_ringparam.hds_thresh) &&
+	    netif_mp_lacks_cap(dev, MP_CAP_READABLE)) {
+		NL_SET_ERR_MSG(info->extack,
+			       "memory provider does not support requested tcp-data-split configuration");
+		return -EINVAL;
 	}
 
 	/* ensure new ring parameters are within limits */
diff --git a/net/xdp/xsk_buff_pool.c b/net/xdp/xsk_buff_pool.c
index 9d2d94f1fb75..f01e1de7360e 100644
--- a/net/xdp/xsk_buff_pool.c
+++ b/net/xdp/xsk_buff_pool.c
@@ -2,6 +2,7 @@
 
 #include <linux/netdevice.h>
 #include <net/netdev_lock.h>
+#include <net/page_pool/memory_provider.h>
 #include <net/xsk_buff_pool.h>
 #include <net/xdp_sock.h>
 #include <net/xdp_sock_drv.h>
@@ -235,7 +236,7 @@ int xp_assign_dev(struct xsk_buff_pool *pool,
 		goto err_unreg_pool;
 	}
 
-	if (dev_get_min_mp_channel_count(netdev)) {
+	if (netif_mp_lacks_cap(netdev, MP_CAP_READABLE)) {
 		err = -EBUSY;
 		goto err_unreg_pool;
 	}
-- 
2.55.0

