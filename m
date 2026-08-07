Received: from out162-62-57-87.mail.qq.com (out162-62-57-87.mail.qq.com [162.62.57.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 899D4137923;
	Fri,  7 Aug 2026 08:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786093004; cv=none; b=YF7WXIiUuGYbj21KvD2CMI5Rf7pnJnmygMzpfDvIL3uecuUO0UtTKqXYhm/MwTVAqeRDYODeaG6YvAjjbG8ldf2zkuvjlxLaVPdBfMtjrPz4ZE13FcT7/JtDMryZvbFRb02x/J09knQpIcdUvIT256rabeiQFhDCreBEX1f9Co0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786093004; c=relaxed/simple;
	bh=bAlOQQWuRKPiwwC4SBiCdbEKOBL+oBD7kx6cWNZMMbs=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=g4ChCf4WZP8O7zu1cX0FDTkKLJmlVtqLTNbiCpwZdA/ha+fNwaJB83/OaGOvYEHmo+E1fRQKWcrNoROSQrDFiYNSh7mwyTQ2XK7Vw6VT5OU5O/W8r/qDBLR3/kvvglTccyNmfOfBKIRYANFd6XlKG011DidjGIf/zBeX4b/Fg3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name; spf=pass smtp.mailfrom=cyyself.name; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=vOjGgRoM; arc=none smtp.client-ip=162.62.57.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyyself.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="vOjGgRoM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1786092989; bh=dvRZgNuehZEvlzQWMiFKWhJGXz1phNRqTZyCDew0fgg=;
	h=From:To:Cc:Subject:Date;
	b=vOjGgRoMLwCO11sJfzEn/bQDJEN20OF2EN/HDuMd/p4EJEsmj1jEm6kYh/NkRRxa/
	 o4xhfVEqHAa5ZnQBggITzvEPkk3ok1jATnkMepw8B+LrIaTuRvP1QlymVZlNdr6Mv5
	 xHM/kcVKY84Yv6Yt+uT6il8X6cOQtF/76asQhDdQ=
Received: from halo.lan ([240e:379:220c:dc00:8d2f:7479:ac61:5053])
	by newxmesmtplogicsvrszb51-0.qq.com (NewEsmtp) with SMTP
	id E1920841; Fri, 07 Aug 2026 16:56:25 +0800
X-QQ-mid: xmsmtpt1786092985tye7qdjny
Message-ID: <tencent_F771B81731B921458D6F7CBF82ECDA888E08@qq.com>
X-QQ-XMAILINFO: MyzM/wvJS/650tdk8qprsJORclmH+w0WhjG3g0mVuWVmK+4I9pZv7xq9iiE5vo
	 8IuMxzeHKmYrKaIBnGNJ3ouu1G4T9LpdVjOCZwu6aaeQm77Eev0M1NPhBVBHJ4qLSONGDCTF5NI2
	 st2e4VRT8Ppv0soP7SEEBaXnZhS3xV3VP1zh7DkbH0pLLbhwibM776zM1Dsn6+rnrGT0vlxm4D97
	 nWWNi8iVtooG5Ul6Au79JN8ui34R2UpxkGkxzMJY4RV0NNjQmNWfz/i9i49l3pDbS3G2kfJTlNZm
	 XuleMSOzq6niKg/tcbKSol9ISdxLVtnfZ46iAnAXvQhvlGQTbQKdFh/GCT4V5kvFvCDloQBDbSPN
	 FUQtrHKkJgTWDnpj+VjPCxYBBFkkTZe3qP8hC2YE7qiS6ksKmsAJCfwv2d3ba2dZ7d/gVGIgpFoq
	 8Rj+fHHv1XLBPNUqzxLJ6vJIz5DWMom95foMsNgjDUYsMZEy7mR63MEsRsvG2mAmoo+T21eqbypC
	 N/qsBE7HqnzpXTWKZ4AgNIgh5zmdwJwkg1wBN9y4G+Esd17arKaDTcvU5l7VV3n5iV3DTT/xA2TU
	 OrTM57qM6sWtytRMjRm7YzlpCTwIuXnG2fkvzb2PJH2TFafyFqbdm8YoiG4yURW5QvsX/ILD88Sp
	 I+RhF+tzRHAeV09iH/jeRBMTybpHS97ecYuBM7tWEUT9V+6m05rmFjd/UnMPzEl3i/25DkNeCWtz
	 qLOmZJsSnqlvtzqPNomEYGDHvjj6aa7XlOX44VBOyr0txXww10xLqtJXSE981K4Ia2AHGA5cHYlS
	 0ySqOUdjz85pR+OhZBUcaV9iX57j+nxHWP8AnGOc7+10E7AGus5N+zwjhj6HL5NjGehahcFiOm0p
	 SN4TPK01dlPS7TD4Df7o5H6/DBe3FRJ3Xdvs2aXFJg3vvqLkBxZk8uwCMf6N4bJ9LhTy+Vc59Zu/
	 wWQyw25rr3F3L5+XyK91OlaapuJUDkq12vBKQFSrGftiFbpE0cIdOokOBv74sZElrcbeYxfX2zIA
	 RRo4u6LKqnEoqPVi81rwd8xKoS3icm6PHkA+3URgaWAm6wGYuu17mulKH6yCYeqxd8EivlsxPXMO
	 b3ugbA4cOEJ/3ybsY=
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
From: Yangyu Chen <cyy@cyyself.name>
To: Sukhdeep Singh <sukhdeeps@marvell.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Mina Almasry <almasrymina@google.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yangyu Chen <cyy@cyyself.name>
Subject: [PATCH net-next v3] net: atlantic: convert RX path to page_pool
Date: Fri,  7 Aug 2026 16:56:09 +0800
X-OQ-MSGID: <20260807085609.222279-1-cyy@cyyself.name>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The driver currently allocates RX buffers with dev_alloc_pages(), maps
them with dma_map_page(), and uses a hand-rolled page-flip scheme to
subdivide high-order pages. Behind an IOMMU, the map/unmap churn is a
major RX cost: on a Thunderbolt-attached QNAP QNA-T310G1S, iperf3 -R
over IPv6 tops out at about 2.2 Gbit/s over MTU 1500.

Convert RX buffers to page_pool fragments. Pages are DMA-mapped once
when entering the pool and recycled through the stack or XDP via the
MEM_TYPE_PAGE_POOL memory model. This removes the custom page-flip
accounting, lets page_pool handle fragment reuse, and ensures every RX
path either keeps the ring's fragment reference for reposting or hands
it to the skb/xdp_buff for later recycling.

Register the PTP RX ring's xdp_rxq as well, since it shares the RX
clean paths. Drop the ethtool PageFlips/PageReuses/PageFrees counters
which only described the old scheme.

On the QNA-T310G1S, MTU 1500, TCP over IPv6, iperf3 -R improves from
2.24 Gbit/s to 9.14 Gbit/s. The module was also smoke-tested with native
XDP PASS, DROP, and ABORTED actions; carrier recovered after each
attach/detach cycle and dmesg showed no page_pool/DMA warnings.

Reviewed-by: Sukhdeep Singh <sukhdeeps@marvell.com>
Assisted-by: Claude:claude-fable-5
Signed-off-by: Yangyu Chen <cyy@cyyself.name>
---

Notes:
    v2 -> v3:
     - rebase on net-next; patches 1 and 2 of v2 (the ring teardown leak
       fixes) went in via net, so only the conversion is left
    
    v2: https://lore.kernel.org/lkml/tencent_1F173E0FC1606D2AC704DC9C98AF10984607@qq.com/
    v1: https://lore.kernel.org/lkml/tencent_7DB01BE7F8FA056BB5F11D3570CF636C4309@qq.com/

 drivers/net/ethernet/aquantia/Kconfig         |   1 +
 .../ethernet/aquantia/atlantic/aq_ethtool.c   |   3 -
 .../net/ethernet/aquantia/atlantic/aq_ptp.c   |  18 +-
 .../net/ethernet/aquantia/atlantic/aq_ring.c  | 210 +++++++-----------
 .../net/ethernet/aquantia/atlantic/aq_ring.h  |   6 +-
 .../net/ethernet/aquantia/atlantic/aq_vec.c   |  21 +-
 6 files changed, 120 insertions(+), 139 deletions(-)

diff --git a/drivers/net/ethernet/aquantia/Kconfig b/drivers/net/ethernet/aquantia/Kconfig
index cec2018c84a9..c8fb7b33e5b7 100644
--- a/drivers/net/ethernet/aquantia/Kconfig
+++ b/drivers/net/ethernet/aquantia/Kconfig
@@ -20,6 +20,7 @@ config AQTION
 	tristate "aQuantia AQtion(tm) Support"
 	depends on PCI
 	depends on MACSEC || MACSEC=n
+	select PAGE_POOL
 	help
 	  This enables the support for the aQuantia AQtion(tm) Ethernet card.
 
diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_ethtool.c b/drivers/net/ethernet/aquantia/atlantic/aq_ethtool.c
index 420af958d486..0f5125bd2315 100644
--- a/drivers/net/ethernet/aquantia/atlantic/aq_ethtool.c
+++ b/drivers/net/ethernet/aquantia/atlantic/aq_ethtool.c
@@ -100,9 +100,6 @@ static const char * const aq_ethtool_queue_rx_stat_names[] = {
 	"%sQueue[%d] AllocFails",
 	"%sQueue[%d] SkbAllocFails",
 	"%sQueue[%d] Polls",
-	"%sQueue[%d] PageFlips",
-	"%sQueue[%d] PageReuses",
-	"%sQueue[%d] PageFrees",
 	"%sQueue[%d] XdpAbort",
 	"%sQueue[%d] XdpDrop",
 	"%sQueue[%d] XdpPass",
diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_ptp.c b/drivers/net/ethernet/aquantia/atlantic/aq_ptp.c
index 558ac9237f75..3a40d986cd67 100644
--- a/drivers/net/ethernet/aquantia/atlantic/aq_ptp.c
+++ b/drivers/net/ethernet/aquantia/atlantic/aq_ptp.c
@@ -13,6 +13,7 @@
 #include <linux/ptp_classify.h>
 #include <linux/interrupt.h>
 #include <linux/clocksource.h>
+#include <net/xdp.h>
 
 #include "aq_nic.h"
 #include "aq_ptp.h"
@@ -1192,12 +1193,23 @@ int aq_ptp_ring_alloc(struct aq_nic_s *aq_nic)
 	if (err)
 		goto err_exit_ptp_tx;
 
+	err = xdp_rxq_info_reg(&aq_ptp->ptp_rx.xdp_rxq, aq_nic->ndev,
+			       rx_ring_idx, aq_ptp->napi.napi_id);
+	if (err < 0)
+		goto err_exit_ptp_rx;
+
+	err = xdp_rxq_info_reg_mem_model(&aq_ptp->ptp_rx.xdp_rxq,
+					 MEM_TYPE_PAGE_POOL,
+					 aq_ptp->ptp_rx.pg_pool);
+	if (err < 0)
+		goto err_exit_xdp_rxq;
+
 	if (aq_ptp->a1_ptp) {
 		err = aq_ring_hwts_rx_alloc(&aq_ptp->hwts_rx, aq_nic, PTP_HWST_RING_IDX,
 					    aq_nic->aq_nic_cfg.rxds,
 					    aq_nic->aq_nic_cfg.aq_hw_caps->rxd_size);
 		if (err)
-			goto err_exit_ptp_rx;
+			goto err_exit_xdp_rxq;
 	}
 
 	err = aq_ptp_skb_ring_init(&aq_ptp->skb_ring, aq_nic->aq_nic_cfg.rxds);
@@ -1217,6 +1229,8 @@ int aq_ptp_ring_alloc(struct aq_nic_s *aq_nic)
 err_exit_hwts_rx:
 	if (aq_ptp->a1_ptp)
 		aq_ring_hwts_rx_free(&aq_ptp->hwts_rx);
+err_exit_xdp_rxq:
+	xdp_rxq_info_unreg(&aq_ptp->ptp_rx.xdp_rxq);
 err_exit_ptp_rx:
 	aq_ring_free(&aq_ptp->ptp_rx);
 err_exit_ptp_tx:
@@ -1233,6 +1247,8 @@ void aq_ptp_ring_free(struct aq_nic_s *aq_nic)
 		return;
 
 	aq_ring_free(&aq_ptp->ptp_tx);
+	if (xdp_rxq_info_is_reg(&aq_ptp->ptp_rx.xdp_rxq))
+		xdp_rxq_info_unreg(&aq_ptp->ptp_rx.xdp_rxq);
 	aq_ring_free(&aq_ptp->ptp_rx);
 	if (aq_ptp->a1_ptp)
 		aq_ring_hwts_rx_free(&aq_ptp->hwts_rx);
diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_ring.c b/drivers/net/ethernet/aquantia/atlantic/aq_ring.c
index e1193c6719d9..9dd881710594 100644
--- a/drivers/net/ethernet/aquantia/atlantic/aq_ring.c
+++ b/drivers/net/ethernet/aquantia/atlantic/aq_ring.c
@@ -14,120 +14,37 @@
 #include "aq_vec.h"
 #include "aq_main.h"
 
+#include <net/page_pool/helpers.h>
 #include <net/xdp.h>
 #include <linux/filter.h>
 #include <linux/bpf_trace.h>
 #include <linux/netdevice.h>
 #include <linux/etherdevice.h>
 
-static void aq_get_rxpages_xdp(struct aq_ring_buff_s *buff,
-			       struct xdp_buff *xdp)
-{
-	struct skb_shared_info *sinfo;
-	int i;
-
-	if (xdp_buff_has_frags(xdp)) {
-		sinfo = xdp_get_shared_info_from_buff(xdp);
-
-		for (i = 0; i < sinfo->nr_frags; i++) {
-			skb_frag_t *frag = &sinfo->frags[i];
-
-			page_ref_inc(skb_frag_page(frag));
-		}
-	}
-	page_ref_inc(buff->rxdata.page);
-}
-
-static inline void aq_free_rxpage(struct aq_rxpage *rxpage, struct device *dev)
-{
-	unsigned int len = PAGE_SIZE << rxpage->order;
-
-	dma_unmap_page(dev, rxpage->daddr, len, DMA_FROM_DEVICE);
-
-	/* Drop the ref for being in the ring. */
-	__free_pages(rxpage->page, rxpage->order);
-	rxpage->page = NULL;
-}
-
-static int aq_alloc_rxpages(struct aq_rxpage *rxpage, struct aq_ring_s *rx_ring)
-{
-	struct device *dev = aq_nic_get_dev(rx_ring->aq_nic);
-	unsigned int order = rx_ring->page_order;
-	struct page *page;
-	int ret = -ENOMEM;
-	dma_addr_t daddr;
-
-	page = dev_alloc_pages(order);
-	if (unlikely(!page))
-		goto err_exit;
-
-	daddr = dma_map_page(dev, page, 0, PAGE_SIZE << order,
-			     DMA_FROM_DEVICE);
-
-	if (unlikely(dma_mapping_error(dev, daddr)))
-		goto free_page;
-
-	rxpage->page = page;
-	rxpage->daddr = daddr;
-	rxpage->order = order;
-	rxpage->pg_off = rx_ring->page_offset;
-
-	return 0;
-
-free_page:
-	__free_pages(page, order);
-
-err_exit:
-	return ret;
-}
-
 static int aq_get_rxpages(struct aq_ring_s *self, struct aq_ring_buff_s *rxbuf)
 {
-	unsigned int order = self->page_order;
-	u16 page_offset = self->page_offset;
-	u16 frame_max = self->frame_max;
-	u16 tail_size = self->tail_size;
-	int ret;
+	unsigned int size = self->page_offset + self->frame_max +
+			    self->tail_size;
+	unsigned int pg_off;
+	struct page *page;
 
-	if (rxbuf->rxdata.page) {
-		/* One means ring is the only user and can reuse */
-		if (page_ref_count(rxbuf->rxdata.page) > 1) {
-			/* Try reuse buffer */
-			rxbuf->rxdata.pg_off += frame_max + page_offset +
-						tail_size;
-			if (rxbuf->rxdata.pg_off + frame_max + tail_size <=
-			    (PAGE_SIZE << order)) {
-				u64_stats_update_begin(&self->stats.rx.syncp);
-				self->stats.rx.pg_flips++;
-				u64_stats_update_end(&self->stats.rx.syncp);
+	/* Buffers whose page was not passed up the stack are reposted
+	 * with the data they already carry discarded.
+	 */
+	if (rxbuf->rxdata.page)
+		return 0;
 
-			} else {
-				/* Buffer exhausted. We have other users and
-				 * should release this page and realloc
-				 */
-				aq_free_rxpage(&rxbuf->rxdata,
-					       aq_nic_get_dev(self->aq_nic));
-				u64_stats_update_begin(&self->stats.rx.syncp);
-				self->stats.rx.pg_losts++;
-				u64_stats_update_end(&self->stats.rx.syncp);
-			}
-		} else {
-			rxbuf->rxdata.pg_off = page_offset;
-			u64_stats_update_begin(&self->stats.rx.syncp);
-			self->stats.rx.pg_reuses++;
-			u64_stats_update_end(&self->stats.rx.syncp);
-		}
+	page = page_pool_dev_alloc_frag(self->pg_pool, &pg_off, size);
+	if (unlikely(!page)) {
+		u64_stats_update_begin(&self->stats.rx.syncp);
+		self->stats.rx.alloc_fails++;
+		u64_stats_update_end(&self->stats.rx.syncp);
+		return -ENOMEM;
 	}
 
-	if (!rxbuf->rxdata.page) {
-		ret = aq_alloc_rxpages(&rxbuf->rxdata, self);
-		if (ret) {
-			u64_stats_update_begin(&self->stats.rx.syncp);
-			self->stats.rx.alloc_fails++;
-			u64_stats_update_end(&self->stats.rx.syncp);
-		}
-		return ret;
-	}
+	rxbuf->rxdata.page = page;
+	rxbuf->rxdata.daddr = page_pool_get_dma_addr(page);
+	rxbuf->rxdata.pg_off = pg_off + self->page_offset;
 
 	return 0;
 }
@@ -179,6 +96,15 @@ int aq_ring_rx_alloc(struct aq_ring_s *self,
 		     unsigned int idx,
 		     struct aq_nic_cfg_s *aq_nic_cfg)
 {
+	struct page_pool_params pp_params = {
+		.flags = PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV,
+		.pool_size = aq_nic_cfg->rxds,
+		.nid = NUMA_NO_NODE,
+		.dev = aq_nic_get_dev(aq_nic),
+		.dma_dir = DMA_FROM_DEVICE,
+	};
+	struct page_pool *pool;
+
 	self->aq_nic = aq_nic;
 	self->idx = idx;
 	self->size = aq_nic_cfg->rxds;
@@ -200,6 +126,18 @@ int aq_ring_rx_alloc(struct aq_ring_s *self,
 		self->tail_size = 0;
 	}
 
+	pp_params.order = self->page_order;
+	pp_params.max_len = PAGE_SIZE << self->page_order;
+
+	pool = page_pool_create(&pp_params);
+	if (IS_ERR(pool))
+		return PTR_ERR(pool);
+
+	self->pg_pool = pool;
+
+	/* On failure aq_ring_alloc() calls aq_ring_free(), which also
+	 * destroys the page pool.
+	 */
 	return aq_ring_alloc(self, aq_nic);
 }
 
@@ -346,7 +284,11 @@ bool aq_ring_tx_clean(struct aq_ring_s *self)
 			++self->stats.tx.packets;
 			self->stats.tx.bytes += xdp_get_frame_len(buff->xdpf);
 			u64_stats_update_end(&self->stats.tx.syncp);
-			xdp_return_frame_rx_napi(buff->xdpf);
+			/* Frames queued via ndo_xdp_xmit() may come from a
+			 * page pool owned by another NAPI context: no direct
+			 * recycling.
+			 */
+			xdp_return_frame(buff->xdpf);
 		}
 
 out:
@@ -437,22 +379,15 @@ int aq_xdp_xmit(struct net_device *dev, int num_frames,
 }
 
 static struct sk_buff *aq_xdp_build_skb(struct xdp_buff *xdp,
-					struct net_device *dev,
-					struct aq_ring_buff_s *buff)
+					struct net_device *dev)
 {
 	struct xdp_frame *xdpf;
-	struct sk_buff *skb;
 
 	xdpf = xdp_convert_buff_to_frame(xdp);
 	if (unlikely(!xdpf))
 		return NULL;
 
-	skb = xdp_build_skb_from_frame(xdpf, dev);
-	if (!skb)
-		return NULL;
-
-	aq_get_rxpages_xdp(buff, xdp);
-	return skb;
+	return xdp_build_skb_from_frame(xdpf, dev);
 }
 
 static struct sk_buff *aq_xdp_run_prog(struct aq_nic_s *aq_nic,
@@ -473,8 +408,16 @@ static struct sk_buff *aq_xdp_run_prog(struct aq_nic_s *aq_nic,
 	u64_stats_update_end(&rx_ring->stats.rx.syncp);
 
 	prog = READ_ONCE(rx_ring->xdp_prog);
-	if (!prog)
-		return aq_xdp_build_skb(xdp, aq_nic->ndev, buff);
+	if (!prog) {
+		skb = aq_xdp_build_skb(xdp, aq_nic->ndev);
+		/* The ring has already handed its page pool reference to the
+		 * xdp_buff, so if the skb could not be built the buffer must
+		 * be returned to the pool here or its fragments would leak.
+		 */
+		if (!skb)
+			xdp_return_buff(xdp);
+		return skb;
+	}
 
 	prefetchw(xdp->data_hard_start); /* xdp_frame write */
 
@@ -485,7 +428,7 @@ static struct sk_buff *aq_xdp_run_prog(struct aq_nic_s *aq_nic,
 	act = bpf_prog_run_xdp(prog, xdp);
 	switch (act) {
 	case XDP_PASS:
-		skb = aq_xdp_build_skb(xdp, aq_nic->ndev, buff);
+		skb = aq_xdp_build_skb(xdp, aq_nic->ndev);
 		if (!skb)
 			goto out_aborted;
 		u64_stats_update_begin(&rx_ring->stats.rx.syncp);
@@ -503,7 +446,6 @@ static struct sk_buff *aq_xdp_run_prog(struct aq_nic_s *aq_nic,
 		u64_stats_update_begin(&rx_ring->stats.rx.syncp);
 		++rx_ring->stats.rx.xdp_tx;
 		u64_stats_update_end(&rx_ring->stats.rx.syncp);
-		aq_get_rxpages_xdp(buff, xdp);
 		break;
 	case XDP_REDIRECT:
 		if (xdp_do_redirect(aq_nic->ndev, xdp, prog) < 0)
@@ -512,7 +454,6 @@ static struct sk_buff *aq_xdp_run_prog(struct aq_nic_s *aq_nic,
 		u64_stats_update_begin(&rx_ring->stats.rx.syncp);
 		++rx_ring->stats.rx.xdp_redirect;
 		u64_stats_update_end(&rx_ring->stats.rx.syncp);
-		aq_get_rxpages_xdp(buff, xdp);
 		break;
 	default:
 		fallthrough;
@@ -523,11 +464,13 @@ static struct sk_buff *aq_xdp_run_prog(struct aq_nic_s *aq_nic,
 		u64_stats_update_end(&rx_ring->stats.rx.syncp);
 		trace_xdp_exception(aq_nic->ndev, prog, act);
 		bpf_warn_invalid_xdp_action(aq_nic->ndev, prog, act);
+		xdp_return_buff(xdp);
 		break;
 	case XDP_DROP:
 		u64_stats_update_begin(&rx_ring->stats.rx.syncp);
 		++rx_ring->stats.rx.xdp_drop;
 		u64_stats_update_end(&rx_ring->stats.rx.syncp);
+		xdp_return_buff(xdp);
 		break;
 	}
 
@@ -546,8 +489,11 @@ static bool aq_add_rx_fragment(struct device *dev,
 	do {
 		skb_frag_t *frag;
 
-		if (unlikely(sinfo->nr_frags >= MAX_SKB_FRAGS))
+		if (unlikely(sinfo->nr_frags >= MAX_SKB_FRAGS)) {
+			/* Attached frags must reach xdp_return_buff() */
+			xdp_buff_set_frags_flag(xdp);
 			return true;
+		}
 
 		frag = &sinfo->frags[sinfo->nr_frags++];
 		buff_ = &ring->buff_ring[buff_->next];
@@ -571,6 +517,11 @@ static bool aq_add_rx_fragment(struct device *dev,
 		if (page_is_pfmemalloc(buff_->rxdata.page))
 			xdp_buff_set_frag_pfmemalloc(xdp);
 
+		/* The frag's page pool reference is owned by the xdp_buff
+		 * from now on.
+		 */
+		buff_->rxdata.page = NULL;
+
 	} while (!buff_->is_eop);
 
 	xdp_buff_set_frags_flag(xdp);
@@ -674,6 +625,7 @@ static int __aq_ring_rx_clean(struct aq_ring_s *self, struct napi_struct *napi,
 			err = -ENOMEM;
 			goto err_exit;
 		}
+		skb_mark_for_recycle(skb);
 		if (is_ptp_ring)
 			buff->len -=
 				aq_ptp_extract_ts(self->aq_nic, skb_hwtstamps(skb),
@@ -694,7 +646,7 @@ static int __aq_ring_rx_clean(struct aq_ring_s *self, struct napi_struct *napi,
 					buff->rxdata.pg_off + hdr_len,
 					buff->len - hdr_len,
 					self->frame_max);
-			page_ref_inc(buff->rxdata.page);
+			buff->rxdata.page = NULL;
 		}
 
 		if (!buff->is_eop) {
@@ -713,7 +665,7 @@ static int __aq_ring_rx_clean(struct aq_ring_s *self, struct napi_struct *napi,
 						buff_->rxdata.pg_off,
 						buff_->len,
 						self->frame_max);
-				page_ref_inc(buff_->rxdata.page);
+				buff_->rxdata.page = NULL;
 				buff_->is_cleaned = 1;
 
 				buff->is_ip_cso &= buff_->is_ip_cso;
@@ -851,6 +803,11 @@ static int __aq_ring_xdp_clean(struct aq_ring_s *rx_ring,
 		xdp_init_buff(&xdp, frame_sz, &rx_ring->xdp_rxq);
 		xdp_prepare_buff(&xdp, hard_start, rx_ring->page_offset,
 				 buff->len, false);
+		/* The xdp_buff owns the buffer's page pool reference from
+		 * here on; it comes back through the MEM_TYPE_PAGE_POOL
+		 * memory model on every XDP verdict.
+		 */
+		buff->rxdata.page = NULL;
 		if (!buff->is_eop) {
 			if (aq_add_rx_fragment(dev, rx_ring, buff, &xdp)) {
 				u64_stats_update_begin(&rx_ring->stats.rx.syncp);
@@ -858,6 +815,7 @@ static int __aq_ring_xdp_clean(struct aq_ring_s *rx_ring,
 				rx_ring->stats.rx.bytes += xdp_get_buff_len(&xdp);
 				++rx_ring->stats.rx.xdp_aborted;
 				u64_stats_update_end(&rx_ring->stats.rx.syncp);
+				xdp_return_buff(&xdp);
 				continue;
 			}
 		}
@@ -969,7 +927,9 @@ void aq_ring_rx_deinit(struct aq_ring_s *self)
 		if (!buff->rxdata.page)
 			continue;
 
-		aq_free_rxpage(&buff->rxdata, aq_nic_get_dev(self->aq_nic));
+		page_pool_put_full_page(self->pg_pool, buff->rxdata.page,
+					false);
+		buff->rxdata.page = NULL;
 	}
 
 	self->sw_head = self->sw_tail;
@@ -983,6 +943,11 @@ void aq_ring_free(struct aq_ring_s *self)
 	kfree(self->buff_ring);
 	self->buff_ring = NULL;
 
+	if (self->pg_pool) {
+		page_pool_destroy(self->pg_pool);
+		self->pg_pool = NULL;
+	}
+
 	if (self->dx_ring) {
 		dma_free_coherent(aq_nic_get_dev(self->aq_nic),
 				  self->size * self->dx_size, self->dx_ring,
@@ -1021,9 +986,6 @@ unsigned int aq_ring_fill_stats_data(struct aq_ring_s *self, u64 *data)
 			data[++count] = self->stats.rx.alloc_fails;
 			data[++count] = self->stats.rx.skb_alloc_fails;
 			data[++count] = self->stats.rx.polls;
-			data[++count] = self->stats.rx.pg_flips;
-			data[++count] = self->stats.rx.pg_reuses;
-			data[++count] = self->stats.rx.pg_losts;
 			data[++count] = self->stats.rx.xdp_aborted;
 			data[++count] = self->stats.rx.xdp_drop;
 			data[++count] = self->stats.rx.xdp_pass;
diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_ring.h b/drivers/net/ethernet/aquantia/atlantic/aq_ring.h
index 6431cc62962f..58bcadb3e3cc 100644
--- a/drivers/net/ethernet/aquantia/atlantic/aq_ring.h
+++ b/drivers/net/ethernet/aquantia/atlantic/aq_ring.h
@@ -17,12 +17,12 @@
 #define AQ_XDP_TAILROOM		SKB_DATA_ALIGN(sizeof(struct skb_shared_info))
 
 struct page;
+struct page_pool;
 struct aq_nic_cfg_s;
 
 struct aq_rxpage {
 	struct page *page;
 	dma_addr_t daddr;
-	unsigned int order;
 	unsigned int pg_off;
 };
 
@@ -105,9 +105,6 @@ struct aq_ring_stats_rx_s {
 	u64 alloc_fails;
 	u64 skb_alloc_fails;
 	u64 polls;
-	u64 pg_losts;
-	u64 pg_flips;
-	u64 pg_reuses;
 	u64 xdp_aborted;
 	u64 xdp_drop;
 	u64 xdp_pass;
@@ -151,6 +148,7 @@ struct aq_ring_s {
 	u16 tail_size;
 	union aq_ring_stats_s stats;
 	dma_addr_t dx_ring_pa;
+	struct page_pool *pg_pool;
 	struct bpf_prog *xdp_prog;
 	enum atl_ring_type ring_type;
 	struct xdp_rxq_info xdp_rxq;
diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_vec.c b/drivers/net/ethernet/aquantia/atlantic/aq_vec.c
index 05814fea0f5f..8e15405d4941 100644
--- a/drivers/net/ethernet/aquantia/atlantic/aq_vec.c
+++ b/drivers/net/ethernet/aquantia/atlantic/aq_vec.c
@@ -146,25 +146,32 @@ int aq_vec_ring_alloc(struct aq_vec_s *self, struct aq_nic_s *aq_nic,
 		aq_nic_set_tx_ring(aq_nic, idx_ring, ring);
 
 		ring = &self->ring[i][AQ_VEC_RX_ID];
+		/* Registering the MEM_TYPE_PAGE_POOL memory model below needs
+		 * the page pool created by aq_ring_rx_alloc(), so the ring is
+		 * allocated first. If a registration fails, the ring has to be
+		 * freed explicitly: rx_rings is not incremented yet, so the
+		 * unwind through aq_vec_ring_free() would not cover it.
+		 */
+		err = aq_ring_rx_alloc(ring, aq_nic, idx_ring, aq_nic_cfg);
+		if (err)
+			goto err_exit;
+
 		if (xdp_rxq_info_reg(&ring->xdp_rxq,
 				     aq_nic->ndev, idx,
 				     self->napi.napi_id) < 0) {
+			aq_ring_free(ring);
 			err = -ENOMEM;
 			goto err_exit;
 		}
 		if (xdp_rxq_info_reg_mem_model(&ring->xdp_rxq,
-					       MEM_TYPE_PAGE_SHARED, NULL) < 0) {
+					       MEM_TYPE_PAGE_POOL,
+					       ring->pg_pool) < 0) {
 			xdp_rxq_info_unreg(&ring->xdp_rxq);
+			aq_ring_free(ring);
 			err = -ENOMEM;
 			goto err_exit;
 		}
 
-		err = aq_ring_rx_alloc(ring, aq_nic, idx_ring, aq_nic_cfg);
-		if (err) {
-			xdp_rxq_info_unreg(&ring->xdp_rxq);
-			goto err_exit;
-		}
-
 		++self->rx_rings;
 	}
 

base-commit: 4fa4977a0d900f936bcae5cd2c510be5554e8dd6
-- 
2.47.3

