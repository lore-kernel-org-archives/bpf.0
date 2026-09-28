Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B31750EBFF;
	Mon, 28 Sep 2026 19:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790624026; cv=none; b=r5TQ9PhIHlVo+IO9NYbfKeq3YGTeQ/vHHkAD5thMfb1KwwmM/lnbbXvCQDL4ah8Amw38xsipKw8Lb8k5rwD3FDVTn1pHd0iomyVLbA/9FOcuHEm6X8ZK26B5jTXoqxgpLTN2kQeIfUQV6hPA3GumdKyQDyCFXVUFQR17ohNNgnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790624026; c=relaxed/simple;
	bh=pS9X63bayUypbA7J5mVLJRXn3jzBZK8Kzlazdx7vdEY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=akYDym4F6fPX1a/QFsn0ItNPl6To3BkSSuS0LC/gsvoJ8v/UTNxWnO678XsEt9xmvLQlg3JCq03uS/aI4PUJV47bW6mbEV76t2EI7cEHCgvWS4j6Haa+fIq6ErUd0SjtF+qjHWw9v2/jA95K+e6WBj7SKZ5KHzrOxbKG/qditso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=E8bncuij; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="E8bncuij"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1790624025; x=1822160025;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=pS9X63bayUypbA7J5mVLJRXn3jzBZK8Kzlazdx7vdEY=;
  b=E8bncuijq3jXMRgc3YBgTK1SD70QNtyYDS3sMvsPs6ZaWyV6kfh6bBsx
   DvkBp3uJoqaFh86Y0uORTotIgZrC1VnJ8Y0kdGDpEkJzr9uBsJHa4zZkU
   GrddyL+QI7z68TMJ2aiQ/beDYoHGWQHGqKOPs8E60opWKTBY4uSX5RFai
   e4v6WBbF7OTldKgHnYZb9b8QD779CGoRK+TrKxXzS8ODEl0k8jvpdG8SN
   N2e+29WCzBU3yWRnpc0ypPs0terLNBxwbyU3INnj8t8yTdKNAfAXuqN7Y
   J/xlEU+Xw+9venKZvLayiH1RP8SsB9uatrGcO8UDjBFhD9F+oeVwZfQ0g
   g==;
X-CSE-ConnectionGUID: 9IuVJ6rCSKWFg+Wzh4L0+g==
X-CSE-MsgGUID: Kpme5CjFTUy8yW9CGUJdtw==
X-IronPort-AV: E=Sophos;i="6.27,129,1787036400"; 
   d="scan'208";a="295688375"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2026 12:33:44 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex4.mchp-main.com (10.10.87.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.49; Mon, 28 Sep 2026 12:33:42 -0700
Received: from DEN-DL-M70577.microsemi.net (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Mon, 28 Sep 2026 12:33:39 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Date: Mon, 28 Sep 2026 21:32:59 +0200
Subject: [PATCH net-next v9 11/15] net: lan966x: add PCIe FDMA support
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260928-lan966x-pci-fdma-v9-11-a17caf60f89a@microchip.com>
References: <20260928-lan966x-pci-fdma-v9-0-a17caf60f89a@microchip.com>
In-Reply-To: <20260928-lan966x-pci-fdma-v9-0-a17caf60f89a@microchip.com>
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

Add PCIe FDMA support for lan966x. The PCIe FDMA path uses contiguous
DMA buffers mapped through the endpoint's ATU, with memcpy-based frame
transfer instead of per-page DMA mappings.

With PCIe FDMA, throughput increases from ~33 Mbps (register-based I/O)
to ~620 Mbps on an Intel x86 host with a lan966x PCIe card.

The RX path uses its own copy of lan966x_hw_offload() that reports back
when skb_vlan_untag() frees the skb, so the caller can drop the frame
instead of touching it.

XDP is not supported on this path yet, so do not advertise xdp_features
and reject program attach for PCIe instances.

Tested-by: Herve Codina <herve.codina@bootlin.com>
Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
---
 drivers/net/ethernet/microchip/lan966x/Makefile    |   4 +
 .../ethernet/microchip/lan966x/lan966x_fdma_pci.c  | 458 +++++++++++++++++++++
 .../net/ethernet/microchip/lan966x/lan966x_main.c  |  11 +-
 .../net/ethernet/microchip/lan966x/lan966x_main.h  |   7 +
 .../net/ethernet/microchip/lan966x/lan966x_regs.h  |  10 +
 .../net/ethernet/microchip/lan966x/lan966x_xdp.c   |   6 +
 6 files changed, 493 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/microchip/lan966x/Makefile b/drivers/net/ethernet/microchip/lan966x/Makefile
index 4cdbe263502c..02db4d4d9826 100644
--- a/drivers/net/ethernet/microchip/lan966x/Makefile
+++ b/drivers/net/ethernet/microchip/lan966x/Makefile
@@ -18,6 +18,10 @@ lan966x-switch-objs  := lan966x_main.o lan966x_phylink.o lan966x_port.o \
 lan966x-switch-$(CONFIG_LAN966X_DCB) += lan966x_dcb.o
 lan966x-switch-$(CONFIG_DEBUG_FS) += lan966x_vcap_debugfs.o
 
+ifneq ($(CONFIG_MCHP_LAN966X_PCI),)
+lan966x-switch-y += lan966x_fdma_pci.o
+endif
+
 # Provide include files
 ccflags-y += -I$(srctree)/drivers/net/ethernet/microchip/vcap
 ccflags-y += -I$(srctree)/drivers/net/ethernet/microchip/fdma
diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_fdma_pci.c b/drivers/net/ethernet/microchip/lan966x/lan966x_fdma_pci.c
new file mode 100644
index 000000000000..f511e7061314
--- /dev/null
+++ b/drivers/net/ethernet/microchip/lan966x/lan966x_fdma_pci.c
@@ -0,0 +1,458 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+#include <linux/ip.h>
+#include <net/addrconf.h>
+
+#include "fdma_api.h"
+#include "lan966x_main.h"
+
+static int lan966x_fdma_pci_dataptr_cb(struct fdma *fdma, int dcb, int db,
+				       u64 *dataptr)
+{
+	u64 addr;
+
+	addr = fdma_dataptr_dma_addr_contiguous(fdma, dcb, db);
+
+	*dataptr = fdma_pci_atu_translate_addr(fdma->atu_region, addr);
+
+	return 0;
+}
+
+static int lan966x_fdma_pci_nextptr_cb(struct fdma *fdma, int dcb, u64 *nextptr)
+{
+	u64 addr;
+
+	fdma_nextptr_cb(fdma, dcb, &addr);
+
+	*nextptr = fdma_pci_atu_translate_addr(fdma->atu_region, addr);
+
+	return 0;
+}
+
+/* Stop the TX queues on every port, so nothing feeds the injection channel
+ * while it is torn down or resized.
+ */
+static void lan966x_fdma_tx_disable_netdev(struct lan966x *lan966x)
+{
+	struct lan966x_port *port;
+	int i;
+
+	for (i = 0; i < lan966x->num_phys_ports; ++i) {
+		port = lan966x->ports[i];
+		if (!port)
+			continue;
+
+		netif_tx_disable(port->dev);
+	}
+}
+
+static int lan966x_fdma_pci_rx_alloc(struct lan966x_rx *rx)
+{
+	struct lan966x *lan966x = rx->lan966x;
+	struct fdma *fdma = &rx->fdma;
+	int err;
+
+	err = fdma_alloc_coherent_and_map(lan966x->dma_dev, fdma,
+					  &lan966x->atu);
+	if (err)
+		return err;
+
+	err = fdma_dcbs_init(fdma,
+			     FDMA_DCB_INFO_DATAL(fdma->db_size - XDP_PACKET_HEADROOM),
+			     FDMA_DCB_STATUS_INTR);
+	if (err) {
+		fdma_free_coherent_and_unmap(lan966x->dma_dev, fdma);
+		return err;
+	}
+
+	lan966x_fdma_llp_configure(lan966x,
+				   fdma->atu_region->base_addr,
+				   fdma->channel_id);
+
+	return 0;
+}
+
+static int lan966x_fdma_pci_tx_alloc(struct lan966x_tx *tx)
+{
+	struct lan966x *lan966x = tx->lan966x;
+	struct fdma *fdma = &tx->fdma;
+	int err;
+
+	err = fdma_alloc_coherent_and_map(lan966x->dma_dev, fdma,
+					  &lan966x->atu);
+	if (err)
+		return err;
+
+	err = fdma_dcbs_init(fdma,
+			     FDMA_DCB_INFO_DATAL(fdma->db_size),
+			     FDMA_DCB_STATUS_DONE);
+	if (err) {
+		fdma_free_coherent_and_unmap(lan966x->dma_dev, fdma);
+		return err;
+	}
+
+	lan966x_fdma_llp_configure(lan966x,
+				   fdma->atu_region->base_addr,
+				   fdma->channel_id);
+
+	return 0;
+}
+
+static int lan966x_fdma_pci_get_next_dcb(struct fdma *fdma)
+{
+	struct fdma_db *db;
+
+	for (int i = 0; i < fdma->n_dcbs; i++) {
+		db = fdma_db_get(fdma, i, 0);
+
+		if (!fdma_db_is_done(db))
+			continue;
+		if (fdma_is_last(fdma, &fdma->dcbs[i]))
+			continue;
+
+		return i;
+	}
+
+	return -ENOSPC;
+}
+
+/* TX slot layout (sizes in bytes):
+ *
+ *  +---------------------+-----+---------+-----+
+ *  | XDP_PACKET_HEADROOM | IFH | payload | FCS |
+ *  |         256         |  28 |   len   |   4 |
+ *  +---------------------+-----+---------+-----+
+ *  |<---------------- db_size ----------------->|
+ *
+ * Return true if the frame plus required overhead fits.
+ */
+static bool lan966x_fdma_pci_tx_size_fits(struct fdma *fdma, u32 len)
+{
+	return XDP_PACKET_HEADROOM + IFH_LEN_BYTES + len + ETH_FCS_LEN <=
+	       fdma->db_size;
+}
+
+/* Return true if blockl is a valid RX frame size. */
+static bool lan966x_fdma_pci_rx_size_fits(struct fdma *fdma, u32 blockl)
+{
+	return blockl >= IFH_LEN_BYTES + ETH_HLEN + ETH_FCS_LEN &&
+	       blockl <= fdma->db_size - XDP_PACKET_HEADROOM;
+}
+
+static int lan966x_fdma_pci_rx_check_frame(struct lan966x_rx *rx, u64 *src_port)
+{
+	struct lan966x *lan966x = rx->lan966x;
+	struct fdma *fdma = &rx->fdma;
+	struct lan966x_port *port;
+	struct fdma_db *db;
+	void *virt_addr;
+	u32 blockl;
+
+	/* virt_addr points to the IFH. */
+	virt_addr = fdma_dataptr_virt_addr_contiguous(fdma,
+						      fdma->dcb_index,
+						      fdma->db_index);
+
+	lan966x_ifh_get_src_port(virt_addr, src_port);
+
+	if (*src_port >= lan966x->num_phys_ports)
+		return FDMA_ERROR;
+
+	port = lan966x->ports[*src_port];
+	if (!port)
+		return FDMA_ERROR;
+
+	db = fdma_db_next_get(fdma);
+
+	/* BLOCKL is a 16-bit HW-populated field; reject obviously-bad
+	 * values before they feed memcpy/XDP sizes.
+	 */
+	blockl = fdma_db_len_get(db);
+	if (!lan966x_fdma_pci_rx_size_fits(fdma, blockl))
+		return FDMA_ERROR;
+
+	return FDMA_PASS;
+}
+
+static bool lan966x_fdma_pci_hw_offload(struct lan966x *lan966x, u32 port,
+					struct sk_buff **pskb)
+{
+	struct sk_buff *skb = *pskb;
+	u32 val;
+
+	val = lan_rd(lan966x, ANA_CPU_FWD_CFG(port));
+	if (!(val & (ANA_CPU_FWD_CFG_IGMP_REDIR_ENA |
+		     ANA_CPU_FWD_CFG_MLD_REDIR_ENA)))
+		return true;
+
+	if (eth_type_vlan(skb->protocol)) {
+		skb = skb_vlan_untag(skb);
+		*pskb = skb;
+		if (unlikely(!skb))
+			return false;
+	}
+
+	if (skb->protocol == htons(ETH_P_IP) &&
+	    ip_hdr(skb)->protocol == IPPROTO_IGMP)
+		return false;
+
+	if (IS_ENABLED(CONFIG_IPV6) &&
+	    skb->protocol == htons(ETH_P_IPV6) &&
+	    ipv6_addr_is_multicast(&ipv6_hdr(skb)->daddr) &&
+	    !ipv6_mc_check_mld(skb))
+		return false;
+
+	return true;
+}
+
+static struct sk_buff *lan966x_fdma_pci_rx_get_frame(struct lan966x_rx *rx,
+						     u64 src_port)
+{
+	struct lan966x *lan966x = rx->lan966x;
+	struct fdma *fdma = &rx->fdma;
+	struct sk_buff *skb;
+	struct fdma_db *db;
+	u32 data_len;
+
+	/* Get the received frame and create an SKB for it. */
+	db = fdma_db_next_get(fdma);
+	data_len = fdma_db_len_get(db);
+
+	skb = napi_alloc_skb(&lan966x->napi, data_len);
+	if (unlikely(!skb))
+		return NULL;
+
+	memcpy(skb->data,
+	       fdma_dataptr_virt_addr_contiguous(fdma,
+						 fdma->dcb_index,
+						 fdma->db_index),
+						 data_len);
+
+	skb_put(skb, data_len);
+
+	skb->dev = lan966x->ports[src_port]->dev;
+	skb_pull(skb, IFH_LEN_BYTES);
+
+	skb_trim(skb, skb->len - ETH_FCS_LEN);
+
+	skb->protocol = eth_type_trans(skb, skb->dev);
+
+	if (lan966x->bridge_mask & BIT(src_port)) {
+		skb->offload_fwd_mark = 1;
+
+		skb_reset_network_header(skb);
+		if (!lan966x_fdma_pci_hw_offload(lan966x, src_port, &skb)) {
+			if (unlikely(!skb))
+				return NULL;
+			skb->offload_fwd_mark = 0;
+		}
+	}
+
+	skb->dev->stats.rx_bytes += skb->len;
+	skb->dev->stats.rx_packets++;
+
+	return skb;
+}
+
+static int lan966x_fdma_pci_xmit(struct sk_buff *skb, __be32 *ifh,
+				 struct net_device *dev)
+{
+	struct lan966x_port *port = netdev_priv(dev);
+	struct lan966x *lan966x = port->lan966x;
+	struct lan966x_tx *tx = &lan966x->tx;
+	struct fdma *fdma = &tx->fdma;
+	int next_to_use;
+	void *virt_addr;
+
+	next_to_use = lan966x_fdma_pci_get_next_dcb(fdma);
+
+	if (next_to_use < 0) {
+		netif_stop_queue(dev);
+		return NETDEV_TX_BUSY;
+	}
+
+	if (skb_put_padto(skb, ETH_ZLEN)) {
+		dev->stats.tx_dropped++;
+		return NETDEV_TX_OK;
+	}
+
+	if (!lan966x_fdma_pci_tx_size_fits(fdma, skb->len)) {
+		dev_kfree_skb_any(skb);
+		dev->stats.tx_dropped++;
+		return NETDEV_TX_OK;
+	}
+
+	skb_tx_timestamp(skb);
+
+	/* virt_addr points to the IFH. */
+	virt_addr = fdma_dataptr_virt_addr_contiguous(fdma, next_to_use, 0);
+	memcpy(virt_addr, ifh, IFH_LEN_BYTES);
+	memcpy(virt_addr + IFH_LEN_BYTES, skb->data, skb->len);
+
+	/* Order frame write before DCB status write below. */
+	dma_wmb();
+
+	fdma_dcb_add(fdma,
+		     next_to_use,
+		     0,
+		     FDMA_DCB_STATUS_INTR |
+		     FDMA_DCB_STATUS_SOF |
+		     FDMA_DCB_STATUS_EOF |
+		     FDMA_DCB_STATUS_BLOCKO(0) |
+		     FDMA_DCB_STATUS_BLOCKL(IFH_LEN_BYTES + skb->len + ETH_FCS_LEN));
+
+	/* Start the transmission. */
+	lan966x_fdma_tx_start(tx);
+
+	dev->stats.tx_bytes += skb->len;
+	dev->stats.tx_packets++;
+
+	/* Safe to free: PTP is not supported on the PCIe path yet,
+	 * so lan966x->ptp is always 0 here.
+	 */
+	dev_consume_skb_any(skb);
+
+	return NETDEV_TX_OK;
+}
+
+static int lan966x_fdma_pci_napi_poll(struct napi_struct *napi, int weight)
+{
+	struct lan966x *lan966x = container_of(napi, struct lan966x, napi);
+	struct lan966x_rx *rx = &lan966x->rx;
+	struct fdma *fdma = &rx->fdma;
+	int dcb_reload, old_dcb;
+	struct sk_buff *skb;
+	int counter = 0;
+	u64 src_port;
+
+	/* Wake any stopped TX queues if a TX DCB is available. */
+	spin_lock(&lan966x->tx_lock);
+	if (lan966x_fdma_pci_get_next_dcb(&lan966x->tx.fdma) >= 0)
+		lan966x_fdma_wakeup_netdev(lan966x);
+	spin_unlock(&lan966x->tx_lock);
+
+	dcb_reload = fdma->dcb_index;
+
+	/* Get all received skbs. */
+	while (counter < weight) {
+		if (!fdma_has_frames(fdma))
+			break;
+		/* Order DONE read before DCB/frame reads below. */
+		dma_rmb();
+		counter++;
+		switch (lan966x_fdma_pci_rx_check_frame(rx, &src_port)) {
+		case FDMA_PASS:
+			break;
+		case FDMA_ERROR:
+			/* No rx_dropped increment here because src_port is
+			 * invalid.
+			 */
+			fdma_dcb_advance(fdma);
+			continue;
+		}
+		skb = lan966x_fdma_pci_rx_get_frame(rx, src_port);
+		fdma_dcb_advance(fdma);
+		if (!skb) {
+			lan966x->ports[src_port]->dev->stats.rx_dropped++;
+			continue;
+		}
+
+		napi_gro_receive(&lan966x->napi, skb);
+	}
+	while (dcb_reload != fdma->dcb_index) {
+		old_dcb = dcb_reload;
+		dcb_reload++;
+		dcb_reload &= fdma->n_dcbs - 1;
+
+		fdma_dcb_add(fdma,
+			     old_dcb,
+			     FDMA_DCB_INFO_DATAL(fdma->db_size - XDP_PACKET_HEADROOM),
+			     FDMA_DCB_STATUS_INTR);
+
+		lan966x_fdma_rx_reload(rx);
+	}
+
+	if (counter < weight && napi_complete_done(napi, counter))
+		lan_wr(0xff, lan966x, FDMA_INTR_DB_ENA);
+
+	return counter;
+}
+
+static int lan966x_fdma_pci_init(struct lan966x *lan966x)
+{
+	struct fdma *rx_fdma = &lan966x->rx.fdma;
+	struct fdma *tx_fdma = &lan966x->tx.fdma;
+	int err;
+
+	if (!lan966x->fdma)
+		return 0;
+
+	lan_wr(FDMA_CTRL_NRESET_SET(0), lan966x, FDMA_CTRL);
+	lan_wr(FDMA_CTRL_NRESET_SET(1), lan966x, FDMA_CTRL);
+
+	fdma_pci_atu_init(&lan966x->atu, lan966x->regs[TARGET_PCIE_DBI]);
+
+	lan966x->rx.lan966x = lan966x;
+	lan966x->rx.max_mtu = lan966x_fdma_get_max_frame(lan966x);
+	rx_fdma->channel_id = FDMA_XTR_CHANNEL;
+	rx_fdma->n_dcbs = FDMA_DCB_MAX;
+	rx_fdma->n_dbs = FDMA_RX_DCB_MAX_DBS;
+	rx_fdma->priv = lan966x;
+	rx_fdma->db_size = FDMA_PCI_DB_SIZE(lan966x->rx.max_mtu);
+	rx_fdma->size = fdma_get_size_contiguous(rx_fdma);
+	rx_fdma->ops.nextptr_cb = &lan966x_fdma_pci_nextptr_cb;
+	rx_fdma->ops.dataptr_cb = &lan966x_fdma_pci_dataptr_cb;
+
+	lan966x->tx.lan966x = lan966x;
+	tx_fdma->channel_id = FDMA_INJ_CHANNEL;
+	tx_fdma->n_dcbs = FDMA_DCB_MAX;
+	tx_fdma->n_dbs = FDMA_TX_DCB_MAX_DBS;
+	tx_fdma->priv = lan966x;
+	tx_fdma->db_size = FDMA_PCI_DB_SIZE(lan966x->rx.max_mtu);
+	tx_fdma->size = fdma_get_size_contiguous(tx_fdma);
+	tx_fdma->ops.nextptr_cb = &lan966x_fdma_pci_nextptr_cb;
+	tx_fdma->ops.dataptr_cb = &lan966x_fdma_pci_dataptr_cb;
+
+	err = lan966x_fdma_pci_rx_alloc(&lan966x->rx);
+	if (err)
+		return err;
+
+	err = lan966x_fdma_pci_tx_alloc(&lan966x->tx);
+	if (err) {
+		fdma_free_coherent_and_unmap(lan966x->dma_dev, rx_fdma);
+		return err;
+	}
+
+	lan966x_fdma_rx_start(&lan966x->rx);
+
+	return 0;
+}
+
+static int lan966x_fdma_pci_resize(struct lan966x *lan966x)
+{
+	return -EOPNOTSUPP;
+}
+
+static void lan966x_fdma_pci_deinit(struct lan966x *lan966x)
+{
+	if (!lan966x->fdma)
+		return;
+
+	if (lan966x->fdma_ndev)
+		napi_disable(&lan966x->napi);
+
+	lan966x_fdma_tx_disable_netdev(lan966x);
+	lan966x_fdma_rx_disable(&lan966x->rx);
+	lan966x_fdma_tx_disable(&lan966x->tx);
+
+	fdma_free_coherent_and_unmap(lan966x->dma_dev, &lan966x->rx.fdma);
+	fdma_free_coherent_and_unmap(lan966x->dma_dev, &lan966x->tx.fdma);
+}
+
+const struct lan966x_fdma_ops lan966x_fdma_pci_ops = {
+	.fdma_init = &lan966x_fdma_pci_init,
+	.fdma_deinit = &lan966x_fdma_pci_deinit,
+	.fdma_xmit = &lan966x_fdma_pci_xmit,
+	.fdma_poll = &lan966x_fdma_pci_napi_poll,
+	.fdma_resize = &lan966x_fdma_pci_resize,
+};
diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_main.c b/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
index 024ce9f9916c..de2202786826 100644
--- a/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
+++ b/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
@@ -50,6 +50,7 @@ struct lan966x_main_io_resource {
 static const struct lan966x_main_io_resource lan966x_main_iomap[] =  {
 	{ TARGET_CPU,                   0xc0000, 0 }, /* 0xe00c0000 */
 	{ TARGET_FDMA,                  0xc0400, 0 }, /* 0xe00c0400 */
+	{ TARGET_PCIE_DBI,             0x400000, 0 }, /* 0xe0400000 */
 	{ TARGET_ORG,                         0, 1 }, /* 0xe2000000 */
 	{ TARGET_GCB,                    0x4000, 1 }, /* 0xe2004000 */
 	{ TARGET_QS,                     0x8000, 1 }, /* 0xe2008000 */
@@ -873,7 +874,8 @@ static int lan966x_probe_port(struct lan966x *lan966x, u32 p,
 
 	port->phylink = phylink;
 
-	if (lan966x->fdma)
+	/* XDP is not supported on the PCIe FDMA path. */
+	if (lan966x->fdma && !lan966x_is_pci(lan966x))
 		dev->xdp_features = NETDEV_XDP_ACT_BASIC |
 				    NETDEV_XDP_ACT_REDIRECT |
 				    NETDEV_XDP_ACT_NDO_XMIT;
@@ -1128,7 +1130,8 @@ static int lan966x_probe(struct platform_device *pdev)
 	lan966x->dev = &pdev->dev;
 	lan966x->dma_dev = lan966x_get_dma_dev(lan966x->dev);
 
-	lan966x->ops = &lan966x_fdma_ops;
+	lan966x->ops = lan966x_is_pci(lan966x) ? &lan966x_fdma_pci_ops :
+						 &lan966x_fdma_ops;
 
 	if (!device_get_mac_address(&pdev->dev, mac_addr)) {
 		ether_addr_copy(lan966x->base_mac, mac_addr);
@@ -1187,7 +1190,9 @@ static int lan966x_probe(struct platform_device *pdev)
 		if (err)
 			return dev_err_probe(&pdev->dev, err, "Unable to use ptp irq");
 
-		lan966x->ptp = 1;
+		/* PTP is not supported on the PCIe path yet. */
+		if (!lan966x_is_pci(lan966x))
+			lan966x->ptp = 1;
 	}
 
 	lan966x->fdma_irq = platform_get_irq_byname(pdev, "fdma");
diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_main.h b/drivers/net/ethernet/microchip/lan966x/lan966x_main.h
index aab5e53ed059..16bc28c8f11f 100644
--- a/drivers/net/ethernet/microchip/lan966x/lan966x_main.h
+++ b/drivers/net/ethernet/microchip/lan966x/lan966x_main.h
@@ -17,6 +17,7 @@
 #include <net/xdp.h>
 
 #include <fdma_api.h>
+#include <fdma_pci.h>
 #include <vcap_api.h>
 #include <vcap_api_client.h>
 
@@ -291,6 +292,10 @@ struct lan966x {
 
 	void __iomem *regs[NUM_TARGETS];
 
+#if IS_ENABLED(CONFIG_MCHP_LAN966X_PCI)
+	struct fdma_pci_atu atu;
+#endif
+
 	int shared_queue_sz;
 
 	u8 base_mac[ETH_ALEN];
@@ -589,6 +594,8 @@ void lan966x_fdma_wakeup_netdev(struct lan966x *lan966x);
 int lan966x_fdma_get_max_frame(struct lan966x *lan966x);
 int lan966x_qsys_sw_status(struct lan966x *lan966x);
 
+extern const struct lan966x_fdma_ops lan966x_fdma_pci_ops;
+
 /* dma_dev differs from dev only on the PCIe path. */
 static inline bool lan966x_is_pci(struct lan966x *lan966x)
 {
diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_regs.h b/drivers/net/ethernet/microchip/lan966x/lan966x_regs.h
index aba0d36ae6b5..4778ea217673 100644
--- a/drivers/net/ethernet/microchip/lan966x/lan966x_regs.h
+++ b/drivers/net/ethernet/microchip/lan966x/lan966x_regs.h
@@ -20,6 +20,7 @@ enum lan966x_target {
 	TARGET_FDMA = 21,
 	TARGET_GCB = 27,
 	TARGET_ORG = 36,
+	TARGET_PCIE_DBI = 40,
 	TARGET_PTP = 41,
 	TARGET_QS = 42,
 	TARGET_QSYS = 46,
@@ -1009,6 +1010,15 @@ enum lan966x_target {
 #define FDMA_CH_CFG_CH_MEM_GET(x)\
 	FIELD_GET(FDMA_CH_CFG_CH_MEM, x)
 
+/*      FDMA:FDMA:FDMA_CTRL */
+#define FDMA_CTRL                 __REG(TARGET_FDMA, 0, 1, 8, 0, 1, 428, 424, 0, 1, 4)
+
+#define FDMA_CTRL_NRESET                         BIT(0)
+#define FDMA_CTRL_NRESET_SET(x)\
+	FIELD_PREP(FDMA_CTRL_NRESET, x)
+#define FDMA_CTRL_NRESET_GET(x)\
+	FIELD_GET(FDMA_CTRL_NRESET, x)
+
 /*      FDMA:FDMA:FDMA_PORT_CTRL */
 #define FDMA_PORT_CTRL(r)         __REG(TARGET_FDMA, 0, 1, 8, 0, 1, 428, 376, r, 2, 4)
 
diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_xdp.c b/drivers/net/ethernet/microchip/lan966x/lan966x_xdp.c
index 9ee61db8690b..e63634887f64 100644
--- a/drivers/net/ethernet/microchip/lan966x/lan966x_xdp.c
+++ b/drivers/net/ethernet/microchip/lan966x/lan966x_xdp.c
@@ -20,6 +20,12 @@ static int lan966x_xdp_setup(struct net_device *dev, struct netdev_bpf *xdp)
 		return -EOPNOTSUPP;
 	}
 
+	if (lan966x_is_pci(lan966x)) {
+		NL_SET_ERR_MSG_MOD(xdp->extack,
+				   "XDP is not supported on the PCIe FDMA path");
+		return -EOPNOTSUPP;
+	}
+
 	old_xdp = lan966x_xdp_present(lan966x);
 	old_prog = xchg(&port->xdp_prog, xdp->prog);
 	new_xdp = lan966x_xdp_present(lan966x);

-- 
2.34.1

