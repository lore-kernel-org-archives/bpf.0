Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8216E429036;
	Thu, 24 Sep 2026 19:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790279859; cv=none; b=ZTitkuwQziLBuvVlRGGgqjd+ESOJRkA7e7Y4QVZkGjP22c8C0clClGARDfzYXfO2VPs6Qw2d/hlkgehUZN5OSPHUG4lV0R0MR2cj1HYp8FnQcNeuDjoaWH53FXtAcYOPsIrAUaqLWXbS0JBhhk8RMafH17cK0RIXQL+jSVz7zkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790279859; c=relaxed/simple;
	bh=7SJDHiTNZUVrA2+aUWyf6Kg0AVhJfh5JdWvOY32Bbt0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=EvXS7nYIaRj6XfcLXaLQJyJzEMDDxJcCwQBWaKlB+gOn01VMJcxPr/nhn3Mcyn4WPTxx7GZCThuoYRr/hTVtlHzIP3yQn0eyscYN8raGLPKLmYhjSrSUanq3MhGcIVzGRDhNA+TDWd3X8Z6Xqfi9a54QriGZN4lBUkss53k9ihM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=zTWd0o+r; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="zTWd0o+r"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1790279855; x=1821815855;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=7SJDHiTNZUVrA2+aUWyf6Kg0AVhJfh5JdWvOY32Bbt0=;
  b=zTWd0o+rs9d+6pLjXi0e5VrOUykp1LZwSE2Kr/oCck491Vol1hI7HYZ9
   uYg9/6AhZXAX7qUaeW75q5SlPjhBxOdHHVPmQHdrQ0ZxXDZ4mwWwmU6fo
   +dA9VhQpWly6C5zDirRvG6Bqq8gY+Mswd3b3O5N2BbUpBeXlQUHTUoIIG
   rcRHpCoT2jvK/nqepjP8sMwAzsQzG4m52hZb5Cama75UZZUlt2V4ipTo2
   rBd9AgCSuNdjR4sO7N/0iDSRiB5QoJYLL5Locct2gfxR4ZhSRSWgS9/fo
   MpZ+DmFKR5DNrDciR7ZhEB+WwL10nS50k4HgdEjOpmqWgdqdlmK2xVunO
   Q==;
X-CSE-ConnectionGUID: /PA5yiZ3SiimKIT/ka/hMg==
X-CSE-MsgGUID: Dj9Q2I9MR1emHWK57xauyw==
X-IronPort-AV: E=Sophos;i="6.27,121,1787036400"; 
   d="scan'208";a="64420633"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2026 12:57:33 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.87.151) by
 chn-vm-ex2.mchp-main.com (10.10.87.31) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.49; Thu, 24 Sep 2026 12:57:32 -0700
Received: from DEN-DL-M70577.microsemi.net (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Thu, 24 Sep 2026 12:57:28 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Date: Thu, 24 Sep 2026 21:56:55 +0200
Subject: [PATCH net-next v8 07/15] net: lan966x: use a dedicated device for
 DMA operations
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260924-lan966x-pci-fdma-v8-7-201c7b707d8b@microchip.com>
References: <20260924-lan966x-pci-fdma-v8-0-201c7b707d8b@microchip.com>
In-Reply-To: <20260924-lan966x-pci-fdma-v8-0-201c7b707d8b@microchip.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Horatiu Vultur
	<horatiu.vultur@microchip.com>, Steen Hegelund
	<steen.hegelund@microchip.com>, <UNGLinuxDriver@microchip.com>, "Alexei
 Starovoitov" <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
	"Jesper Dangaard Brouer" <hawk@kernel.org>, John Fastabend
	<john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, Herve
 Codina <herve.codina@bootlin.com>, Arnd Bergmann <arnd@arndb.de>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Mohsin Bashir
	<mohsin.bashr@gmail.com>, "Simon Horman" <horms@kernel.org>
CC: Richard Cochran <richardcochran@gmail.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>
X-Mailer: b4 0.14.3

In preparation for the PCIe FDMA implementation, add lan966x->dma_dev,
resolved once at probe time, and use it for every DMA operation the
FDMA path performs: coherent allocations, streaming mappings and the RX
page pool. Natively, dma_dev is lan966x->dev, so there is no functional
change.

Since dma_dev differs from dev only on the PCIe path, add
lan966x_is_pci() on top of it, for the later PCIe patches to key off.

Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
Reviewed-by: Simon Horman <horms@kernel.org>
---
 .../net/ethernet/microchip/lan966x/lan966x_fdma.c  | 30 +++++++++++-----------
 .../net/ethernet/microchip/lan966x/lan966x_main.c  | 16 ++++++++++++
 .../net/ethernet/microchip/lan966x/lan966x_main.h  | 10 ++++++++
 3 files changed, 41 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c b/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c
index 651ea03eede7..ae6e5aec5e13 100644
--- a/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c
+++ b/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c
@@ -80,7 +80,7 @@ static int lan966x_fdma_rx_alloc_page_pool(struct lan966x_rx *rx)
 		.flags = PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV,
 		.pool_size = rx->fdma.n_dcbs,
 		.nid = NUMA_NO_NODE,
-		.dev = lan966x->dev,
+		.dev = lan966x->dma_dev,
 		.dma_dir = DMA_FROM_DEVICE,
 		.offset = XDP_PACKET_HEADROOM,
 		.max_len = rx->max_mtu -
@@ -126,7 +126,7 @@ static int lan966x_fdma_rx_alloc(struct lan966x_rx *rx)
 	if (err)
 		return err;
 
-	err = fdma_alloc_coherent(lan966x->dev, fdma);
+	err = fdma_alloc_coherent(lan966x->dma_dev, fdma);
 	if (err) {
 		page_pool_destroy(rx->page_pool);
 		return err;
@@ -210,7 +210,7 @@ static int lan966x_fdma_tx_alloc(struct lan966x_tx *tx)
 	if (!tx->dcbs_buf)
 		return -ENOMEM;
 
-	err = fdma_alloc_coherent(lan966x->dev, fdma);
+	err = fdma_alloc_coherent(lan966x->dma_dev, fdma);
 	if (err)
 		goto out;
 
@@ -230,7 +230,7 @@ static void lan966x_fdma_tx_free(struct lan966x_tx *tx)
 	struct lan966x *lan966x = tx->lan966x;
 
 	kfree(tx->dcbs_buf);
-	fdma_free_coherent(lan966x->dev, &tx->fdma);
+	fdma_free_coherent(lan966x->dma_dev, &tx->fdma);
 }
 
 static void lan966x_fdma_tx_activate(struct lan966x_tx *tx)
@@ -355,7 +355,7 @@ static void lan966x_fdma_tx_clear_buf(struct lan966x *lan966x, int weight)
 
 		dcb_buf->used = false;
 		if (dcb_buf->use_skb) {
-			dma_unmap_single(lan966x->dev,
+			dma_unmap_single(lan966x->dma_dev,
 					 dcb_buf->dma_addr,
 					 dcb_buf->len,
 					 DMA_TO_DEVICE);
@@ -364,7 +364,7 @@ static void lan966x_fdma_tx_clear_buf(struct lan966x *lan966x, int weight)
 				napi_consume_skb(dcb_buf->data.skb, weight);
 		} else {
 			if (dcb_buf->xdp_ndo)
-				dma_unmap_single(lan966x->dev,
+				dma_unmap_single(lan966x->dma_dev,
 						 dcb_buf->dma_addr,
 						 dcb_buf->len,
 						 DMA_TO_DEVICE);
@@ -400,7 +400,7 @@ static int lan966x_fdma_rx_check_frame(struct lan966x_rx *rx, u64 *src_port)
 	if (unlikely(!page))
 		return FDMA_ERROR;
 
-	dma_sync_single_for_cpu(lan966x->dev,
+	dma_sync_single_for_cpu(lan966x->dma_dev,
 				(dma_addr_t)fdma_db_dataptr_get(db) +
 				XDP_PACKET_HEADROOM,
 				fdma_db_len_get(db),
@@ -636,11 +636,11 @@ int lan966x_fdma_xmit_xdpf(struct lan966x_port *port, void *ptr, u32 len)
 		lan966x_ifh_set_bypass(ifh, 1);
 		lan966x_ifh_set_port(ifh, BIT_ULL(port->chip_port));
 
-		dma_addr = dma_map_single(lan966x->dev,
+		dma_addr = dma_map_single(lan966x->dma_dev,
 					  xdpf->data - IFH_LEN_BYTES,
 					  xdpf->len + IFH_LEN_BYTES,
 					  DMA_TO_DEVICE);
-		if (dma_mapping_error(lan966x->dev, dma_addr)) {
+		if (dma_mapping_error(lan966x->dma_dev, dma_addr)) {
 			ret = NETDEV_TX_OK;
 			goto out;
 		}
@@ -656,7 +656,7 @@ int lan966x_fdma_xmit_xdpf(struct lan966x_port *port, void *ptr, u32 len)
 		lan966x_ifh_set_port(ifh, BIT_ULL(port->chip_port));
 
 		dma_addr = page_pool_get_dma_addr(page);
-		dma_sync_single_for_device(lan966x->dev,
+		dma_sync_single_for_device(lan966x->dma_dev,
 					   dma_addr + XDP_PACKET_HEADROOM,
 					   len + IFH_LEN_BYTES,
 					   DMA_TO_DEVICE);
@@ -735,9 +735,9 @@ int lan966x_fdma_xmit(struct sk_buff *skb, __be32 *ifh, struct net_device *dev)
 	memcpy(skb->data, ifh, IFH_LEN_BYTES);
 	skb_put(skb, 4);
 
-	dma_addr = dma_map_single(lan966x->dev, skb->data, skb->len,
+	dma_addr = dma_map_single(lan966x->dma_dev, skb->data, skb->len,
 				  DMA_TO_DEVICE);
-	if (dma_mapping_error(lan966x->dev, dma_addr)) {
+	if (dma_mapping_error(lan966x->dma_dev, dma_addr)) {
 		dev->stats.tx_dropped++;
 		err = NETDEV_TX_OK;
 		goto release;
@@ -843,7 +843,7 @@ static int lan966x_fdma_reload(struct lan966x *lan966x, int new_mtu)
 			page_pool_put_full_page(page_pool,
 						old_pages[i][j], false);
 
-	fdma_free_coherent(lan966x->dev, &fdma_rx_old);
+	fdma_free_coherent(lan966x->dma_dev, &fdma_rx_old);
 
 	page_pool_destroy(page_pool);
 
@@ -993,7 +993,7 @@ int lan966x_fdma_init(struct lan966x *lan966x)
 
 	err = lan966x_fdma_tx_alloc(&lan966x->tx);
 	if (err) {
-		fdma_free_coherent(lan966x->dev, &lan966x->rx.fdma);
+		fdma_free_coherent(lan966x->dma_dev, &lan966x->rx.fdma);
 		page_pool_destroy(lan966x->rx.page_pool);
 		return err;
 	}
@@ -1015,7 +1015,7 @@ void lan966x_fdma_deinit(struct lan966x *lan966x)
 	napi_disable(&lan966x->napi);
 
 	lan966x_fdma_rx_free_pages(&lan966x->rx);
-	fdma_free_coherent(lan966x->dev, &lan966x->rx.fdma);
+	fdma_free_coherent(lan966x->dma_dev, &lan966x->rx.fdma);
 	page_pool_destroy(lan966x->rx.page_pool);
 	lan966x_fdma_tx_free(&lan966x->tx);
 }
diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_main.c b/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
index 1179a6e127c5..2741f7c9fa4c 100644
--- a/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
+++ b/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
@@ -7,6 +7,7 @@
 #include <linux/ip.h>
 #include <linux/of.h>
 #include <linux/of_net.h>
+#include <linux/pci.h>
 #include <linux/phy/phy.h>
 #include <linux/platform_device.h>
 #include <linux/reset.h>
@@ -1081,6 +1082,20 @@ static int lan966x_reset_switch(struct lan966x *lan966x)
 	return 0;
 }
 
+/* When enumerated over PCIe, dev is a platform device with no
+ * iommus/dma-ranges of its own, so DMA must target the PCIe endpoint instead.
+ * The result differs from dev only in that case; lan966x_is_pci() relies on it.
+ */
+static struct device *lan966x_get_dma_dev(struct device *dev)
+{
+	for (struct device *p = dev->parent; p; p = p->parent) {
+		if (dev_is_pci(p))
+			return p;
+	}
+
+	return dev;
+}
+
 static int lan966x_probe(struct platform_device *pdev)
 {
 	struct fwnode_handle *ports, *portnp;
@@ -1094,6 +1109,7 @@ static int lan966x_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, lan966x);
 	lan966x->dev = &pdev->dev;
+	lan966x->dma_dev = lan966x_get_dma_dev(lan966x->dev);
 
 	if (!device_get_mac_address(&pdev->dev, mac_addr)) {
 		ether_addr_copy(lan966x->base_mac, mac_addr);
diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_main.h b/drivers/net/ethernet/microchip/lan966x/lan966x_main.h
index 83c361abb789..3f09f8ddf620 100644
--- a/drivers/net/ethernet/microchip/lan966x/lan966x_main.h
+++ b/drivers/net/ethernet/microchip/lan966x/lan966x_main.h
@@ -270,6 +270,9 @@ struct lan966x_skb_cb {
 struct lan966x {
 	struct device *dev;
 
+	/* Device used for DMA; the PCIe endpoint when enumerated over PCIe. */
+	struct device *dma_dev;
+
 	u8 num_phys_ports;
 	struct lan966x_port **ports;
 
@@ -573,6 +576,13 @@ void lan966x_fdma_wakeup_netdev(struct lan966x *lan966x);
 int lan966x_fdma_get_max_frame(struct lan966x *lan966x);
 int lan966x_qsys_sw_status(struct lan966x *lan966x);
 
+/* dma_dev differs from dev only on the PCIe path. */
+static inline bool lan966x_is_pci(struct lan966x *lan966x)
+{
+	return IS_ENABLED(CONFIG_MCHP_LAN966X_PCI) &&
+	       lan966x->dma_dev != lan966x->dev;
+}
+
 int lan966x_lag_port_join(struct lan966x_port *port,
 			  struct net_device *brport_dev,
 			  struct net_device *bond,

-- 
2.34.1

