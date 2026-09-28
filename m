Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88FFA4F93BD;
	Mon, 28 Sep 2026 19:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790624034; cv=none; b=bJtGstPRpfTDJ1B/tKzONxXKMwJHTNT5Ao29x/gYbsASIZcinIrTjzUEYGC7YZ8HhUhAVCRTfSY/1agkZDoM+9ineZdxnyPbfPyDlARyeiBISKY9DKMEk6s3pj0j23tOkjZSlaL9MIT8RGbi141WRiCxFlSpSNl+aQlkUyY2Vpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790624034; c=relaxed/simple;
	bh=TnsOxFY0wiBqZcAeAEHi02HOZ0LfY5fshoRRQmJHLPs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=qDL///XhQfbsvGBpidv0icDURM5LwsJeKfqKw4zLZSPTfMFFHYljiEpsbdpbS+Tc5fR28tIKIbk1FUxC0Kx7GCeW2V6FTLxxVKcLCdGWS4Go6eid0NQTUm1Wkp59otEoHdDZrofmy7BfRa+vAgs9sGmOADOjkIU6lWTUYpDI4lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=HvBIqW7L; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="HvBIqW7L"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1790624032; x=1822160032;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=TnsOxFY0wiBqZcAeAEHi02HOZ0LfY5fshoRRQmJHLPs=;
  b=HvBIqW7LTCDAsJ2hOIWvTFIl0gNGOjtUdpnfmCN6PUWM5Mwj9ySfpZSQ
   ZbTVOpkkUoFlo9DXlSy7NRG26KBoe3RG9aqzkOnFa/IX38Qj5djYyBrwT
   +Mh1jPZuQP1KDAiTJ5iFs2TxPylQtM3mQrxzh33NdtQc+jLbcwdTNVjCv
   K+n8xZTcgF7rW1PhY8kiWsSt+mbWrGDNJ+o9UL+wSoCl/lZbJUORCgsXy
   UtkU5SzAMjMLw6SJtZ3DqDQB8/d0VyuykjWbzoTE56iffLlhgZptRW5D4
   jdIGfa3nWsoPkZ8kn8yECo1jv8cxXk9XSzfMNuJPxh/FVtsMGtYx1tPlO
   w==;
X-CSE-ConnectionGUID: yDMBiLazTSKTgU5MD1NK3A==
X-CSE-MsgGUID: VzrlhFOaTkaKJ7ldCG5+IQ==
X-IronPort-AV: E=Sophos;i="6.27,129,1787036400"; 
   d="scan'208";a="231389936"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2026 12:33:51 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex4.mchp-main.com (10.10.87.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.49; Mon, 28 Sep 2026 12:33:51 -0700
Received: from DEN-DL-M70577.microsemi.net (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Mon, 28 Sep 2026 12:33:47 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Date: Mon, 28 Sep 2026 21:33:01 +0200
Subject: [PATCH net-next v9 13/15] net: lan966x: add PCIe FDMA XDP support
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260928-lan966x-pci-fdma-v9-13-a17caf60f89a@microchip.com>
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
Reviewed-by: Simon Horman <horms@kernel.org>
---
 .../ethernet/microchip/lan966x/lan966x_fdma_pci.c  | 166 ++++++++++++++++++---
 .../net/ethernet/microchip/lan966x/lan966x_main.c  |  12 +-
 .../net/ethernet/microchip/lan966x/lan966x_xdp.c   |  12 +-
 3 files changed, 159 insertions(+), 31 deletions(-)

diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_fdma_pci.c b/drivers/net/ethernet/microchip/lan966x/lan966x_fdma_pci.c
index 758554c951c5..949994874ed9 100644
--- a/drivers/net/ethernet/microchip/lan966x/lan966x_fdma_pci.c
+++ b/drivers/net/ethernet/microchip/lan966x/lan966x_fdma_pci.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0+
 
+#include <linux/bpf_trace.h>
 #include <linux/ip.h>
 #include <net/addrconf.h>
 
@@ -139,7 +140,123 @@ static bool lan966x_fdma_pci_rx_size_fits(struct fdma *fdma, u32 blockl)
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
@@ -171,7 +288,15 @@ static int lan966x_fdma_pci_rx_check_frame(struct lan966x_rx *rx, u64 *src_port)
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
 
 static bool lan966x_fdma_pci_hw_offload(struct lan966x *lan966x, u32 port,
@@ -206,34 +331,21 @@ static bool lan966x_fdma_pci_hw_offload(struct lan966x *lan966x, u32 port,
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
-	data_len = fdma_db_len_get(db);
 
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
 
@@ -324,6 +436,8 @@ static int lan966x_fdma_pci_napi_poll(struct napi_struct *napi, int weight)
 	struct sk_buff *skb;
 	int counter = 0;
 	u64 src_port;
+	u32 data_len;
+	void *data;
 
 	/* Wake any stopped TX queues if a TX DCB is available. */
 	spin_lock(&lan966x->tx_lock);
@@ -340,7 +454,10 @@ static int lan966x_fdma_pci_napi_poll(struct napi_struct *napi, int weight)
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
@@ -349,8 +466,17 @@ static int lan966x_fdma_pci_napi_poll(struct napi_struct *napi, int weight)
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
index c3afc4cc597f..e4c9c5812cca 100644
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

