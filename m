Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C65C04EE86F;
	Fri, 18 Sep 2026 11:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789731303; cv=none; b=oNAMl7/X072IDJDMfL3acd2mYvSq7QHN6rFJnpnHXRWpw2BmRxVjcADH+LFdD+ORoVXN5L8r2i7DNKZSSBnnGrTbO1cP95UwqDiGAVa+Pf+NpqLZy1VeymrMh5b2KDWi0rqI7qX/7iRXnWIEf7v4ROLCM8xKBSFFhCor275srw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789731303; c=relaxed/simple;
	bh=gjDctCrjO9fidz08IBjObtAdUqa2xLyuwM6VEhU+n/8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=Gbuz5565mEvNK+s64mFoFgSdnmiN6E7g65rTx355xDFirG/0gjod8COly2n9RWYlaE8jMawRtlBqdtJ6Ka6+ZfkU8Cyto7rJpRuexHXGwmvbWMfpFPyo6JD+3LL0ZRpOXHf82Sg7FHmDYDSqp1aARufRVr2dr8ElmOR6Ve5G/h8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=ei7KFeMQ; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="ei7KFeMQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1789731301; x=1821267301;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=gjDctCrjO9fidz08IBjObtAdUqa2xLyuwM6VEhU+n/8=;
  b=ei7KFeMQWR/t+1MdtK2lXnqm+qo2xzNKv3O8U7yNAft1xtsSfN1oC6yF
   WwNDW+dgM0catcYjlz0xQ9dZMDDWuRQYli/F/g9J8ZmZ5fwNk9+93lNU9
   S15fis0vKh4QF+KZNqb57SLBt++NWRR9QmsQ5FVYAyXxfrsksxh6ZTDS4
   XTu13ovEzRcT09EJOqnrBreFaIEKJzqftN+jPkTHiwZ3HphOAa8HhQ6Pp
   6/h9iYdhOhL2CjcdnlJmHE/bnfc244XRxx5EDcohufxTFidC859aJyjgL
   eEvNBzIATn5DzZXlQF2LB5dKi3BmZmqIpaXFwYyQUjXB57Fe23u1sg/SL
   w==;
X-CSE-ConnectionGUID: AsnkTzQTSr6bQnIhn1UHIQ==
X-CSE-MsgGUID: hu29enfvRku9PAsyQBSLLQ==
X-IronPort-AV: E=Sophos;i="6.27,108,1787036400"; 
   d="scan'208";a="295223745"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 18 Sep 2026 04:35:00 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Fri, 18 Sep 2026 04:34:59 -0700
Received: from DEN-DL-M70577.microsemi.net (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Fri, 18 Sep 2026 04:34:55 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Date: Fri, 18 Sep 2026 13:34:04 +0200
Subject: [PATCH net-next v7 12/14] net: lan966x: add PCIe FDMA XDP support
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260918-lan966x-pci-fdma-v7-12-0ecc179c8a2c@microchip.com>
References: <20260918-lan966x-pci-fdma-v7-0-0ecc179c8a2c@microchip.com>
In-Reply-To: <20260918-lan966x-pci-fdma-v7-0-0ecc179c8a2c@microchip.com>
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
	<mohsin.bashr@gmail.com>
CC: Richard Cochran <richardcochran@gmail.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>
X-Mailer: b4 0.14.3

Add XDP support for the PCIe FDMA path. The implementation operates on
contiguous ATU-mapped buffers with memcpy-based XDP_TX, unlike the
platform path which uses page_pool.

XDP sees the frame with IFH and FCS stripped. These are removed in
lan966x_fdma_pci_rx_check_frame() before the BPF program runs, because
after the program returns the driver cannot tell whether the tail
region was modified. The skb_pull/skb_trim previously done in
lan966x_fdma_pci_rx_get_frame() are removed for the same reason; the
frame pointer and length are pre-computed by rx_check_frame() and
passed through rx_get_frame() and lan966x_xdp_pci_run() to the caller.

lan966x_fdma_pci_xmit_xdpf() handles XDP_TX: it rebuilds a fresh IFH
in the TX slot, copies the post-XDP frame after it, and lets HW insert
a new FCS.

lan966x_xdp_setup() is extended so the PCIe path skips the page_pool
reload that the platform path needs.

Only XDP_ACT_BASIC is supported.

Tested-by: Herve Codina <herve.codina@bootlin.com>
Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
---
 .../ethernet/microchip/lan966x/lan966x_fdma_pci.c  | 167 ++++++++++++++++++---
 .../net/ethernet/microchip/lan966x/lan966x_main.c  |  12 +-
 .../net/ethernet/microchip/lan966x/lan966x_xdp.c   |  12 +-
 3 files changed, 160 insertions(+), 31 deletions(-)

diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_fdma_pci.c b/drivers/net/ethernet/microchip/lan966x/lan966x_fdma_pci.c
index 940425beec2f..e833dbb4fcf0 100644
--- a/drivers/net/ethernet/microchip/lan966x/lan966x_fdma_pci.c
+++ b/drivers/net/ethernet/microchip/lan966x/lan966x_fdma_pci.c
@@ -1,5 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0+
 
+#include <linux/bpf_trace.h>
+
 #include "fdma_api.h"
 #include "lan966x_main.h"
 
@@ -136,7 +138,123 @@ static bool lan966x_fdma_pci_rx_size_fits(struct fdma *fdma, u32 blockl)
 	       blockl <= fdma->db_size - XDP_PACKET_HEADROOM;
 }
 
-static int lan966x_fdma_pci_rx_check_frame(struct lan966x_rx *rx, u64 *src_port)
+static int lan966x_fdma_pci_xmit_xdpf(struct lan966x_port *port,
+				      void *ptr, u32 len)
+{
+	struct lan966x *lan966x = port->lan966x;
+	struct lan966x_tx *tx = &lan966x->tx;
+	struct fdma *fdma = &tx->fdma;
+	int next_to_use, ret = 0;
+	void *virt_addr;
+
+	spin_lock(&lan966x->tx_lock);
+
+	next_to_use = lan966x_fdma_pci_get_next_dcb(fdma);
+
+	if (next_to_use < 0) {
+		netif_stop_queue(port->dev);
+		port->dev->stats.tx_dropped++;
+		ret = NETDEV_TX_BUSY;
+		goto out;
+	}
+
+	/* Only the upper bound is enforced: XDP owns the frame contents and
+	 * length, so a program that shrinks below ETH_ZLEN gets what it asked
+	 * for.
+	 */
+	if (!lan966x_fdma_pci_tx_size_fits(fdma, len)) {
+		port->dev->stats.tx_dropped++;
+		ret = -EINVAL;
+		goto out;
+	}
+
+	/* virt_addr points to the IFH. */
+	virt_addr = fdma_dataptr_virt_addr_contiguous(fdma, next_to_use, 0);
+
+	/* Construct a fresh IFH. */
+	memset(virt_addr, 0, IFH_LEN_BYTES);
+	lan966x_ifh_set_bypass(virt_addr, 1);
+	lan966x_ifh_set_port(virt_addr, BIT_ULL(port->chip_port));
+
+	/* Copy the (post-XDP) frame after the IFH. */
+	memcpy(virt_addr + IFH_LEN_BYTES, ptr, len);
+
+	/* Order frame write before DCB status write below. */
+	dma_wmb();
+
+	/* Reserve ETH_FCS_LEN for the HW-inserted FCS (len is FCS-stripped). */
+	fdma_dcb_add(fdma,
+		     next_to_use,
+		     0,
+		     FDMA_DCB_STATUS_INTR |
+		     FDMA_DCB_STATUS_SOF |
+		     FDMA_DCB_STATUS_EOF |
+		     FDMA_DCB_STATUS_BLOCKO(0) |
+		     FDMA_DCB_STATUS_BLOCKL(IFH_LEN_BYTES + len + ETH_FCS_LEN));
+
+	/* Start the transmission. */
+	lan966x_fdma_tx_start(tx);
+
+	port->dev->stats.tx_bytes += len;
+	port->dev->stats.tx_packets++;
+
+out:
+	spin_unlock(&lan966x->tx_lock);
+
+	return ret;
+}
+
+static int lan966x_xdp_pci_run(struct lan966x_port *port, void *data,
+			       u32 data_len, void **xdp_data, u32 *xdp_len)
+{
+	/* Read once so the NULL check and bpf_prog_run_xdp() see the same
+	 * pointer.
+	 */
+	struct bpf_prog *xdp_prog = READ_ONCE(port->xdp_prog);
+	struct lan966x *lan966x = port->lan966x;
+	struct fdma *fdma = &lan966x->rx.fdma;
+	struct xdp_buff xdp;
+	u32 act;
+
+	if (!xdp_prog)
+		return FDMA_PASS;
+
+	xdp_init_buff(&xdp, fdma->db_size, &port->xdp_rxq);
+
+	/* hard_start is set to slot start (virt_addr is XDP_PACKET_HEADROOM
+	 * into the slot). Headroom includes the IFH; BPF may grow into it
+	 * via adjust_head. IFH is rebuilt on XDP_TX and unread on XDP_PASS.
+	 */
+	xdp_prepare_buff(&xdp,
+			 data - XDP_PACKET_HEADROOM,
+			 XDP_PACKET_HEADROOM + IFH_LEN_BYTES,
+			 data_len,
+			 false);
+
+	act = bpf_prog_run_xdp(xdp_prog, &xdp);
+
+	*xdp_data = xdp.data;
+	*xdp_len = xdp.data_end - xdp.data;
+
+	switch (act) {
+	case XDP_PASS:
+		return FDMA_PASS;
+	case XDP_TX:
+		return lan966x_fdma_pci_xmit_xdpf(port, *xdp_data, *xdp_len) ?
+		       FDMA_DROP : FDMA_TX;
+	default:
+		bpf_warn_invalid_xdp_action(port->dev, xdp_prog, act);
+		fallthrough;
+	case XDP_ABORTED:
+		trace_xdp_exception(port->dev, xdp_prog, act);
+		fallthrough;
+	case XDP_DROP:
+		return FDMA_DROP;
+	}
+}
+
+static int lan966x_fdma_pci_rx_check_frame(struct lan966x_rx *rx, u64 *src_port,
+					   void **data, u32 *data_len)
 {
 	struct lan966x *lan966x = rx->lan966x;
 	struct fdma *fdma = &rx->fdma;
@@ -168,38 +286,33 @@ static int lan966x_fdma_pci_rx_check_frame(struct lan966x_rx *rx, u64 *src_port)
 	if (!lan966x_fdma_pci_rx_size_fits(fdma, blockl))
 		return FDMA_ERROR;
 
-	return FDMA_PASS;
+	/* Present the Ethernet frame (no IFH, no FCS). HW re-inserts the
+	 * FCS on TX; see lan966x_fdma_pci_xmit_xdpf(). May be overridden
+	 * by XDP. The FCS strip is unconditional because NETIF_F_RXFCS
+	 * is not advertised in hw_features.
+	 */
+	*data = virt_addr + IFH_LEN_BYTES;
+	*data_len = blockl - IFH_LEN_BYTES - ETH_FCS_LEN;
+
+	return lan966x_xdp_pci_run(port, virt_addr, *data_len, data, data_len);
 }
 
 static struct sk_buff *lan966x_fdma_pci_rx_get_frame(struct lan966x_rx *rx,
-						     u64 src_port)
+						     u64 src_port, void *data,
+						     u32 data_len)
 {
 	struct lan966x *lan966x = rx->lan966x;
-	struct fdma *fdma = &rx->fdma;
 	struct sk_buff *skb;
-	struct fdma_db *db;
-	u32 data_len;
-
-	/* Get the received frame and create an SKB for it. */
-	db = fdma_db_next_get(fdma);
-	data_len = FDMA_DCB_STATUS_BLOCKL(db->status);
 
 	skb = napi_alloc_skb(&lan966x->napi, data_len);
 	if (unlikely(!skb))
 		return NULL;
 
-	memcpy(skb->data,
-	       fdma_dataptr_virt_addr_contiguous(fdma,
-						 fdma->dcb_index,
-						 fdma->db_index),
-						 data_len);
+	memcpy(skb->data, data, data_len);
 
 	skb_put(skb, data_len);
 
 	skb->dev = lan966x->ports[src_port]->dev;
-	skb_pull(skb, IFH_LEN_BYTES);
-
-	skb_trim(skb, skb->len - ETH_FCS_LEN);
 
 	skb->protocol = eth_type_trans(skb, skb->dev);
 
@@ -287,6 +400,8 @@ static int lan966x_fdma_pci_napi_poll(struct napi_struct *napi, int weight)
 	struct sk_buff *skb;
 	int counter = 0;
 	u64 src_port;
+	u32 data_len;
+	void *data;
 
 	/* Wake any stopped TX queues if a TX DCB is available. */
 	spin_lock(&lan966x->tx_lock);
@@ -303,7 +418,10 @@ static int lan966x_fdma_pci_napi_poll(struct napi_struct *napi, int weight)
 		/* Order DONE read before DCB/frame reads below. */
 		dma_rmb();
 		counter++;
-		switch (lan966x_fdma_pci_rx_check_frame(rx, &src_port)) {
+		switch (lan966x_fdma_pci_rx_check_frame(rx,
+							&src_port,
+							&data,
+							&data_len)) {
 		case FDMA_PASS:
 			break;
 		case FDMA_ERROR:
@@ -312,8 +430,17 @@ static int lan966x_fdma_pci_napi_poll(struct napi_struct *napi, int weight)
 			 */
 			fdma_dcb_advance(fdma);
 			continue;
+		case FDMA_TX:
+			fdma_dcb_advance(fdma);
+			continue;
+		case FDMA_DROP:
+			fdma_dcb_advance(fdma);
+			continue;
 		}
-		skb = lan966x_fdma_pci_rx_get_frame(rx, src_port);
+		skb = lan966x_fdma_pci_rx_get_frame(rx,
+						    src_port,
+						    data,
+						    data_len);
 		fdma_dcb_advance(fdma);
 		if (!skb) {
 			lan966x->ports[src_port]->dev->stats.rx_dropped++;
diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_main.c b/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
index 2177e2bbfbd3..7812d495f753 100644
--- a/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
+++ b/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
@@ -875,11 +875,13 @@ static int lan966x_probe_port(struct lan966x *lan966x, u32 p,
 
 	port->phylink = phylink;
 
-	/* XDP is not supported on the PCIe FDMA path. */
-	if (lan966x->fdma && !lan966x_is_pci(lan966x))
-		dev->xdp_features = NETDEV_XDP_ACT_BASIC |
-				    NETDEV_XDP_ACT_REDIRECT |
-				    NETDEV_XDP_ACT_NDO_XMIT;
+	if (lan966x->fdma) {
+		dev->xdp_features = NETDEV_XDP_ACT_BASIC;
+
+		if (!lan966x_is_pci(lan966x))
+			dev->xdp_features |= NETDEV_XDP_ACT_REDIRECT |
+					     NETDEV_XDP_ACT_NDO_XMIT;
+	}
 
 	err = register_netdev(dev);
 	if (err) {
diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_xdp.c b/drivers/net/ethernet/microchip/lan966x/lan966x_xdp.c
index e63634887f64..b98426afc785 100644
--- a/drivers/net/ethernet/microchip/lan966x/lan966x_xdp.c
+++ b/drivers/net/ethernet/microchip/lan966x/lan966x_xdp.c
@@ -20,16 +20,16 @@ static int lan966x_xdp_setup(struct net_device *dev, struct netdev_bpf *xdp)
 		return -EOPNOTSUPP;
 	}
 
-	if (lan966x_is_pci(lan966x)) {
-		NL_SET_ERR_MSG_MOD(xdp->extack,
-				   "XDP is not supported on the PCIe FDMA path");
-		return -EOPNOTSUPP;
-	}
-
 	old_xdp = lan966x_xdp_present(lan966x);
 	old_prog = xchg(&port->xdp_prog, xdp->prog);
 	new_xdp = lan966x_xdp_present(lan966x);
 
+	/* PCIe FDMA uses contiguous buffers, so no page_pool reload
+	 * is needed.
+	 */
+	if (lan966x_is_pci(lan966x))
+		goto out;
+
 	if (old_xdp == new_xdp)
 		goto out;
 

-- 
2.34.1

