Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E4B34E3EDA;
	Thu, 24 Sep 2026 19:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790279887; cv=none; b=Dz198Tvy9rot/TDj1sPOkoWlovuAfM5GfSlSOY15ezKLbqIwSNZLwDbjgcN1s5IxAMDu3Nr4enL4R8PvaKbf3vZRwdfBUtK0rpSdZhjT8ffYRXho9pR+2Rje57YQOT6pgLYAiUCEyKhJsDDuNMcHklKSLC5Ju/TJs2lz721gUsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790279887; c=relaxed/simple;
	bh=yHAHGaIw7xWHbLsBatGbI8K42D/OICCxEX464FUuDgA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=PtDhbbmp/zP2DqCMwR5dsIBgcMgb0whtqstv7FTFYgw71EPTUAjg898T2MkQVwfg9P5/t5vc/t0zTO429se+72Tp3HMjf8KalmyV7VoxD3TY4k5pZqvg1rIdpNAm8t0eu1w/Gu2uewbPpwTvlCS6+94NleaO1uFQUcnxZLAylT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Z8Apogkw; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Z8Apogkw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1790279882; x=1821815882;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=yHAHGaIw7xWHbLsBatGbI8K42D/OICCxEX464FUuDgA=;
  b=Z8Apogkw7VFMalbmq8KLVXAPtf93ERRDQPMKK+tUMZPsR8YUupneu1Ri
   hTmLt3wbSt2UdcKg1Lk+9V4Rv/7on1F5TJmnxL9RcBQTjL0NpbQ2d4lWC
   EK7+MdOhsooUt2iRb4Q+TbHl/vRiIt+Ga1f9WkDp+mtwVvdfMTQjW0nD3
   MvU9Q6ar9SyI2ItouuimUCg5/IG95sqN8Z+e1xfV/eduLjl9nMR5sJWd+
   aAaodKmB8Aylmv+unHB7UvyJYOwwAaA+7PAGp7jyCjN0BFtUWjKlHXfZ1
   eDMVbF/sIIXJFa52RoQmO+oFO5JsRmjdTCTCEYR72J+d3m9SRpoqxzzyp
   Q==;
X-CSE-ConnectionGUID: upnDy4IjTCS1vuGFhbKIug==
X-CSE-MsgGUID: x+QhZdkbQGem6zDsufeN5g==
X-IronPort-AV: E=Sophos;i="6.27,121,1787036400"; 
   d="scan'208";a="295533230"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Sep 2026 12:57:56 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Thu, 24 Sep 2026 12:57:54 -0700
Received: from DEN-DL-M70577.microsemi.net (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Thu, 24 Sep 2026 12:57:50 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Date: Thu, 24 Sep 2026 21:57:00 +0200
Subject: [PATCH net-next v8 12/15] net: lan966x: add PCIe FDMA MTU change
 support
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260924-lan966x-pci-fdma-v8-12-201c7b707d8b@microchip.com>
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

Add MTU change support for the PCIe FDMA path: on an MTU change, the
contiguous ATU-mapped RX and TX buffers are reallocated at the new
size, falling back to the existing buffers on failure.

Cap the PCIe DCB ring at 256 (FDMA_PCI_DCB_MAX): 512 DCBs would
overflow MAX_PAGE_ORDER at jumbo MTU.

The ring must fit one MAX_PAGE_ORDER block after ATU padding, and
db_size is handed to the FDMA in the 16-bit DCB DATAL field.
Advertise the resulting limit in dev->max_mtu (FDMA_PCI_MAX_MTU)
when the FDMA is in use - a switch with no "fdma" interrupt named
uses the unconstrained register-based path instead, so the cap is
gated on lan966x->fdma, not lan966x_is_pci() alone. On a 4KB-page,
MAX_PAGE_ORDER=10 build this is MTU 15498; the overhead is shared
with lan966x_fdma_get_max_frame() via FDMA_OVERHEAD.

Skip the resize until lan966x_fdma_pci_init() has built the rings;
it runs after the netdevs register and sizes them from
DEV_MAC_MAXLEN_CFG, already programmed by the caller.

Tested-by: Herve Codina <herve.codina@bootlin.com>
Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
Reviewed-by: Simon Horman <horms@kernel.org>
---
 .../net/ethernet/microchip/lan966x/lan966x_fdma.c  |   6 +-
 .../ethernet/microchip/lan966x/lan966x_fdma_pci.c  | 153 ++++++++++++++++++++-
 .../net/ethernet/microchip/lan966x/lan966x_main.c  |   3 +-
 .../net/ethernet/microchip/lan966x/lan966x_main.h  |  28 ++++
 4 files changed, 181 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c b/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c
index 2e8f786d6fee..a7940eca5df3 100644
--- a/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c
+++ b/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c
@@ -890,11 +890,7 @@ static int lan966x_fdma_reload(struct lan966x *lan966x, int new_mtu)
 
 int lan966x_fdma_get_max_frame(struct lan966x *lan966x)
 {
-	return lan966x_fdma_get_max_mtu(lan966x) +
-	       IFH_LEN_BYTES +
-	       SKB_DATA_ALIGN(sizeof(struct skb_shared_info)) +
-	       VLAN_HLEN * 2 +
-	       XDP_PACKET_HEADROOM;
+	return lan966x_fdma_get_max_mtu(lan966x) + FDMA_OVERHEAD;
 }
 
 static int __lan966x_fdma_reload(struct lan966x *lan966x, int max_mtu)
diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_fdma_pci.c b/drivers/net/ethernet/microchip/lan966x/lan966x_fdma_pci.c
index bccd1b8590d7..7185e65dda43 100644
--- a/drivers/net/ethernet/microchip/lan966x/lan966x_fdma_pci.c
+++ b/drivers/net/ethernet/microchip/lan966x/lan966x_fdma_pci.c
@@ -358,7 +358,7 @@ static int lan966x_fdma_pci_init(struct lan966x *lan966x)
 	lan966x->rx.lan966x = lan966x;
 	lan966x->rx.max_mtu = lan966x_fdma_get_max_frame(lan966x);
 	rx_fdma->channel_id = FDMA_XTR_CHANNEL;
-	rx_fdma->n_dcbs = FDMA_DCB_MAX;
+	rx_fdma->n_dcbs = FDMA_PCI_DCB_MAX;
 	rx_fdma->n_dbs = FDMA_RX_DCB_MAX_DBS;
 	rx_fdma->priv = lan966x;
 	rx_fdma->db_size = FDMA_PCI_DB_SIZE(lan966x->rx.max_mtu);
@@ -368,7 +368,7 @@ static int lan966x_fdma_pci_init(struct lan966x *lan966x)
 
 	lan966x->tx.lan966x = lan966x;
 	tx_fdma->channel_id = FDMA_INJ_CHANNEL;
-	tx_fdma->n_dcbs = FDMA_DCB_MAX;
+	tx_fdma->n_dcbs = FDMA_PCI_DCB_MAX;
 	tx_fdma->n_dbs = FDMA_TX_DCB_MAX_DBS;
 	tx_fdma->priv = lan966x;
 	tx_fdma->db_size = FDMA_PCI_DB_SIZE(lan966x->rx.max_mtu);
@@ -391,9 +391,156 @@ static int lan966x_fdma_pci_init(struct lan966x *lan966x)
 	return 0;
 }
 
+/* Reset existing rx and tx buffers. */
+static void lan966x_fdma_pci_reset_mem(struct lan966x *lan966x)
+{
+	struct lan966x_rx *rx = &lan966x->rx;
+	struct lan966x_tx *tx = &lan966x->tx;
+
+	memset(rx->fdma.dcbs, 0, rx->fdma.size);
+	memset(tx->fdma.dcbs, 0, tx->fdma.size);
+
+	fdma_dcbs_init(&rx->fdma,
+		       FDMA_DCB_INFO_DATAL(rx->fdma.db_size - XDP_PACKET_HEADROOM),
+		       FDMA_DCB_STATUS_INTR);
+
+	fdma_dcbs_init(&tx->fdma,
+		       FDMA_DCB_INFO_DATAL(tx->fdma.db_size),
+		       FDMA_DCB_STATUS_DONE);
+
+	lan966x_fdma_llp_configure(lan966x,
+				   tx->fdma.atu_region->base_addr,
+				   tx->fdma.channel_id);
+	lan966x_fdma_llp_configure(lan966x,
+				   rx->fdma.atu_region->base_addr,
+				   rx->fdma.channel_id);
+}
+
+/* Wake all TX queues on every port (undoes lan966x_fdma_tx_disable_netdev). */
+static void lan966x_fdma_pci_wakeup_netdev(struct lan966x *lan966x)
+{
+	for (int i = 0; i < lan966x->num_phys_ports; ++i) {
+		struct lan966x_port *port = lan966x->ports[i];
+
+		if (port)
+			netif_tx_wake_all_queues(port->dev);
+	}
+}
+
+static int lan966x_fdma_pci_reload(struct lan966x *lan966x, int new_mtu)
+{
+	struct fdma tx_fdma_old = lan966x->tx.fdma;
+	struct fdma rx_fdma_old = lan966x->rx.fdma;
+	u32 old_mtu = lan966x->rx.max_mtu;
+	int err;
+
+	napi_disable(&lan966x->napi);
+	lan966x_fdma_tx_disable_netdev(lan966x);
+	lan966x_fdma_rx_disable(&lan966x->rx);
+	lan966x_fdma_tx_disable(&lan966x->tx);
+
+	lan966x->rx.max_mtu = new_mtu;
+
+	/* Must be NULL'ed in order to realloc them. */
+	lan966x->rx.fdma.atu_region = NULL;
+	lan966x->tx.fdma.atu_region = NULL;
+
+	lan966x->tx.fdma.db_size = FDMA_PCI_DB_SIZE(lan966x->rx.max_mtu);
+	lan966x->tx.fdma.size = fdma_get_size_contiguous(&lan966x->tx.fdma);
+	lan966x->rx.fdma.db_size = FDMA_PCI_DB_SIZE(lan966x->rx.max_mtu);
+	lan966x->rx.fdma.size = fdma_get_size_contiguous(&lan966x->rx.fdma);
+
+	err = lan966x_fdma_pci_rx_alloc(&lan966x->rx);
+	if (err)
+		goto restore;
+
+	err = lan966x_fdma_pci_tx_alloc(&lan966x->tx);
+	if (err) {
+		fdma_free_coherent_and_unmap(lan966x->dma_dev,
+					     &lan966x->rx.fdma);
+		goto restore;
+	}
+
+	/* Free and unmap old memory. */
+	fdma_free_coherent_and_unmap(lan966x->dma_dev, &rx_fdma_old);
+	fdma_free_coherent_and_unmap(lan966x->dma_dev, &tx_fdma_old);
+
+	/* Order matters: napi_enable() must precede the wakes, or a TX that
+	 * completes first clears FDMA_INTR_DB_ENA with nothing scheduled to
+	 * restore it, leaving RX dead until the next reload.
+	 */
+	napi_enable(&lan966x->napi);
+	lan966x_fdma_rx_start(&lan966x->rx);
+	lan966x_fdma_pci_wakeup_netdev(lan966x);
+
+	return err;
+restore:
+
+	/* No new buffers are allocated at this point. Use the old buffers,
+	 * but reset them before starting the FDMA again.
+	 */
+
+	memcpy(&lan966x->tx.fdma, &tx_fdma_old, sizeof(struct fdma));
+	memcpy(&lan966x->rx.fdma, &rx_fdma_old, sizeof(struct fdma));
+
+	lan966x->rx.max_mtu = old_mtu;
+
+	lan966x_fdma_pci_reset_mem(lan966x);
+
+	napi_enable(&lan966x->napi);
+	lan966x_fdma_rx_start(&lan966x->rx);
+	lan966x_fdma_pci_wakeup_netdev(lan966x);
+
+	return err;
+}
+
+static int __lan966x_fdma_pci_reload(struct lan966x *lan966x, int max_mtu)
+{
+	int err;
+	u32 val;
+
+	/* Disable the CPU port. */
+	lan_rmw(QSYS_SW_PORT_MODE_PORT_ENA_SET(0),
+		QSYS_SW_PORT_MODE_PORT_ENA,
+		lan966x, QSYS_SW_PORT_MODE(CPU_PORT));
+
+	/* Flush the CPU queues. */
+	readx_poll_timeout(lan966x_qsys_sw_status,
+			   lan966x,
+			   val,
+			   !(QSYS_SW_STATUS_EQ_AVAIL_GET(val)),
+			   READL_SLEEP_US, READL_TIMEOUT_US);
+
+	/* Add a sleep in case there are frames between the queues and the CPU
+	 * port
+	 */
+	usleep_range(USEC_PER_MSEC, 2 * USEC_PER_MSEC);
+
+	err = lan966x_fdma_pci_reload(lan966x, max_mtu);
+
+	/* Enable back the CPU port. */
+	lan_rmw(QSYS_SW_PORT_MODE_PORT_ENA_SET(1),
+		QSYS_SW_PORT_MODE_PORT_ENA,
+		lan966x, QSYS_SW_PORT_MODE(CPU_PORT));
+
+	return err;
+}
+
 static int lan966x_fdma_pci_resize(struct lan966x *lan966x)
 {
-	return -EOPNOTSUPP;
+	int max_mtu;
+
+	/* Nothing to resize until fdma_pci_init() has built the rings; it
+	 * sizes them from DEV_MAC_MAXLEN_CFG, which the caller already set.
+	 */
+	if (!lan966x->rx.lan966x)
+		return 0;
+
+	max_mtu = lan966x_fdma_get_max_frame(lan966x);
+	if (max_mtu == lan966x->rx.max_mtu)
+		return 0;
+
+	return __lan966x_fdma_pci_reload(lan966x, max_mtu);
 }
 
 static void lan966x_fdma_pci_deinit(struct lan966x *lan966x)
diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_main.c b/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
index de2202786826..c3afc4cc597f 100644
--- a/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
+++ b/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
@@ -823,7 +823,8 @@ static int lan966x_probe_port(struct lan966x *lan966x, u32 p,
 	port->chip_port = p;
 	lan966x->ports[p] = port;
 
-	dev->max_mtu = ETH_MAX_MTU;
+	dev->max_mtu = lan966x_is_pci(lan966x) && lan966x->fdma ?
+		       FDMA_PCI_MAX_MTU : ETH_MAX_MTU;
 
 	dev->netdev_ops = &lan966x_port_netdev_ops;
 	dev->ethtool_ops = &lan966x_ethtool_ops;
diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_main.h b/drivers/net/ethernet/microchip/lan966x/lan966x_main.h
index 16bc28c8f11f..1877f1916d71 100644
--- a/drivers/net/ethernet/microchip/lan966x/lan966x_main.h
+++ b/drivers/net/ethernet/microchip/lan966x/lan966x_main.h
@@ -7,6 +7,7 @@
 #include <linux/etherdevice.h>
 #include <linux/if_vlan.h>
 #include <linux/jiffies.h>
+#include <linux/mmzone.h>
 #include <linux/phy.h>
 #include <linux/phylink.h>
 #include <linux/ptp_clock_kernel.h>
@@ -87,6 +88,33 @@
 #define FDMA_INJ_CHANNEL		0
 #define FDMA_DCB_MAX			512
 
+/* Ring must fit in one MAX_PAGE_ORDER DMA block; 512 DCBs overflows
+ * at jumbo MTU.
+ */
+#define FDMA_PCI_DCB_MAX		256
+
+#define FDMA_OVERHEAD							\
+	(IFH_LEN_BYTES +						\
+	 SKB_DATA_ALIGN(sizeof(struct skb_shared_info)) +		\
+	 VLAN_HLEN * 2 +						\
+	 XDP_PACKET_HEADROOM)
+
+/* Largest db_size keeping the ATU-padded ring inside one MAX_PAGE_ORDER
+ * block and within the 16-bit DCB DATAL field. Inverts ALIGN(x, R) <= L
+ * into x <= ALIGN_DOWN(L, R) to bound x directly.
+ */
+#define FDMA_PCI_DB_SIZE_MAX						\
+	MIN_T(u32,							\
+	      (ALIGN_DOWN(PAGE_SIZE << MAX_PAGE_ORDER,			\
+			  FDMA_PCI_ATU_REGION_ALIGN) -			\
+	       FDMA_PCI_DCB_MAX * sizeof(struct fdma_dcb)) /		\
+	      (FDMA_PCI_DCB_MAX * FDMA_RX_DCB_MAX_DBS),			\
+	      ALIGN_DOWN(GENMASK(15, 0), FDMA_PCI_DB_ALIGN))
+
+#define FDMA_PCI_MAX_MTU						\
+	(FDMA_PCI_DB_SIZE_MAX - FDMA_OVERHEAD -				\
+	 (ETH_HLEN + ETH_FCS_LEN))
+
 #define SE_IDX_QUEUE			0  /* 0-79 : Queue scheduler elements */
 #define SE_IDX_PORT			80 /* 80-89 : Port schedular elements */
 

-- 
2.34.1

