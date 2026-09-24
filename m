Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE7454A6CF5;
	Thu, 24 Sep 2026 19:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790279867; cv=none; b=RVXXG1uC8EEKzt0svh7NIfLuIqjGphLrqIh/KePyuXHVfaiVXoRi1Y4C1REkp0Fo+Ahv1LHriQs7FBMUsdGuHnFm6Q7xyFltfHzuFUbKqVAL0OZo+hA+R1jysweQTa9H8njKyRz841oKwk1w0k91p3m1Dt+ridoPZQk+1pKPaMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790279867; c=relaxed/simple;
	bh=p2Q25QixnWjEL0MXvUBXiM484P+nmYzwCzZV7OoKTJE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=eT4AyBGwTVTteqmr71V275ef7I5YjWtcdOVPAfR2z0TXoKTJR71hSLN3HLrAkHcZlnePGpLG08/5m+Vyc3KO6yFS9GIIjJJfKJXdUk8shhIRa2MG0oLhMdc8o1qhVAmyFYGK79hs4VU05I1zYmZ8Jbiu5Zbk4jtK7budJomk0Ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=JKHTWCXC; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="JKHTWCXC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1790279862; x=1821815862;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=p2Q25QixnWjEL0MXvUBXiM484P+nmYzwCzZV7OoKTJE=;
  b=JKHTWCXCo8UvaritGngpPCO5G1cGRbVZqehhO6vrpnjYW3vHB8VOFCg4
   pQtx9ff/NRJ0la2sENrqPrFRVf/las1LOxRtGwngrC979h7TIPRoTUd6w
   yLyRqqh+ss8RzLtF+4MiABLz9JRUOrZ4kUouNUmMGzLattR97ofurPFiP
   g/AyGAUbsSfqI2P1s9Y/bO42UwvwljWQuDMQ2tUF0sjsAVweGPrNKZcQm
   +CeKxxF9LtaHCyJWgNWhVPLAXtRXYiO+Ps+pvuHCZKUynG2W49yQU5re2
   IULJbT0r/SEhv4ZPXKzrdAX0V03128n3JHnb5bgGVQAnP7pKIvTGhKJSU
   Q==;
X-CSE-ConnectionGUID: YlbJLw4xSB6HhUP/TLzRYQ==
X-CSE-MsgGUID: vNkeohRQSpaFCdMdiBUmlA==
X-IronPort-AV: E=Sophos;i="6.27,121,1787036400"; 
   d="scan'208";a="231239482"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Sep 2026 12:57:37 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Thu, 24 Sep 2026 12:57:36 -0700
Received: from DEN-DL-M70577.microsemi.net (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Thu, 24 Sep 2026 12:57:32 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Date: Thu, 24 Sep 2026 21:56:56 +0200
Subject: [PATCH net-next v8 08/15] net: lan966x: add FDMA ops dispatch for
 PCIe support
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260924-lan966x-pci-fdma-v8-8-201c7b707d8b@microchip.com>
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

Introduce lan966x_fdma_ops to support different FDMA implementations
for platform and PCIe. Plumb fdma_init, fdma_deinit, fdma_xmit,
fdma_poll and fdma_resize through the ops table, and select the
implementation at probe time. Only the platform implementation exists
at this point; the PCIe implementation is added in a later patch.

Tested-by: Herve Codina <herve.codina@bootlin.com>
Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
Reviewed-by: Simon Horman <horms@kernel.org>
---
 .../net/ethernet/microchip/lan966x/lan966x_fdma.c    |  2 +-
 .../net/ethernet/microchip/lan966x/lan966x_main.c    | 20 +++++++++++++++-----
 .../net/ethernet/microchip/lan966x/lan966x_main.h    | 13 +++++++++++++
 3 files changed, 29 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c b/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c
index ae6e5aec5e13..5f46166cbfe4 100644
--- a/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c
+++ b/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c
@@ -948,7 +948,7 @@ void lan966x_fdma_netdev_init(struct lan966x *lan966x, struct net_device *dev)
 		return;
 
 	lan966x->fdma_ndev = dev;
-	netif_napi_add(dev, &lan966x->napi, lan966x_fdma_napi_poll);
+	netif_napi_add(dev, &lan966x->napi, lan966x->ops->fdma_poll);
 	napi_enable(&lan966x->napi);
 }
 
diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_main.c b/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
index 2741f7c9fa4c..6e6c08bb8eea 100644
--- a/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
+++ b/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
@@ -27,6 +27,14 @@
 
 #define IO_RANGES 2
 
+static const struct lan966x_fdma_ops lan966x_fdma_ops = {
+	.fdma_init = &lan966x_fdma_init,
+	.fdma_deinit = &lan966x_fdma_deinit,
+	.fdma_xmit = &lan966x_fdma_xmit,
+	.fdma_poll = &lan966x_fdma_napi_poll,
+	.fdma_resize = &lan966x_fdma_change_mtu,
+};
+
 static const struct of_device_id lan966x_match[] = {
 	{ .compatible = "microchip,lan966x-switch" },
 	{ }
@@ -392,7 +400,7 @@ static netdev_tx_t lan966x_port_xmit(struct sk_buff *skb,
 
 	spin_lock(&lan966x->tx_lock);
 	if (port->lan966x->fdma)
-		err = lan966x_fdma_xmit(skb, ifh, dev);
+		err = lan966x->ops->fdma_xmit(skb, ifh, dev);
 	else
 		err = lan966x_port_ifh_xmit(skb, ifh, dev);
 	spin_unlock(&lan966x->tx_lock);
@@ -414,7 +422,7 @@ static int lan966x_port_change_mtu(struct net_device *dev, int new_mtu)
 	if (!lan966x->fdma)
 		return 0;
 
-	err = lan966x_fdma_change_mtu(lan966x);
+	err = lan966x->ops->fdma_resize(lan966x);
 	if (err) {
 		lan_wr(DEV_MAC_MAXLEN_CFG_MAX_LEN_SET(LAN966X_HW_MTU(old_mtu)),
 		       lan966x, DEV_MAC_MAXLEN_CFG(port->chip_port));
@@ -1111,6 +1119,8 @@ static int lan966x_probe(struct platform_device *pdev)
 	lan966x->dev = &pdev->dev;
 	lan966x->dma_dev = lan966x_get_dma_dev(lan966x->dev);
 
+	lan966x->ops = &lan966x_fdma_ops;
+
 	if (!device_get_mac_address(&pdev->dev, mac_addr)) {
 		ether_addr_copy(lan966x->base_mac, mac_addr);
 	} else {
@@ -1250,7 +1260,7 @@ static int lan966x_probe(struct platform_device *pdev)
 	if (err)
 		goto cleanup_fdb;
 
-	err = lan966x_fdma_init(lan966x);
+	err = lan966x->ops->fdma_init(lan966x);
 	if (err)
 		goto cleanup_ptp;
 
@@ -1263,7 +1273,7 @@ static int lan966x_probe(struct platform_device *pdev)
 	return 0;
 
 cleanup_fdma:
-	lan966x_fdma_deinit(lan966x);
+	lan966x->ops->fdma_deinit(lan966x);
 
 cleanup_ptp:
 	lan966x_ptp_deinit(lan966x);
@@ -1291,7 +1301,7 @@ static void lan966x_remove(struct platform_device *pdev)
 
 	lan966x_taprio_deinit(lan966x);
 	lan966x_vcap_deinit(lan966x);
-	lan966x_fdma_deinit(lan966x);
+	lan966x->ops->fdma_deinit(lan966x);
 	lan966x_cleanup_ports(lan966x);
 
 	cancel_delayed_work_sync(&lan966x->stats_work);
diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_main.h b/drivers/net/ethernet/microchip/lan966x/lan966x_main.h
index 3f09f8ddf620..aab5e53ed059 100644
--- a/drivers/net/ethernet/microchip/lan966x/lan966x_main.h
+++ b/drivers/net/ethernet/microchip/lan966x/lan966x_main.h
@@ -193,6 +193,17 @@ enum vcap_is1_port_sel_rt {
 	VCAP_IS1_PS_RT_FOLLOW_OTHER = 7,
 };
 
+struct lan966x;
+
+struct lan966x_fdma_ops {
+	int (*fdma_init)(struct lan966x *lan966x);
+	void (*fdma_deinit)(struct lan966x *lan966x);
+	int (*fdma_xmit)(struct sk_buff *skb, __be32 *ifh,
+			 struct net_device *dev);
+	int (*fdma_poll)(struct napi_struct *napi, int weight);
+	int (*fdma_resize)(struct lan966x *lan966x);
+};
+
 struct lan966x_port;
 
 struct lan966x_rx {
@@ -273,6 +284,8 @@ struct lan966x {
 	/* Device used for DMA; the PCIe endpoint when enumerated over PCIe. */
 	struct device *dma_dev;
 
+	const struct lan966x_fdma_ops *ops;
+
 	u8 num_phys_ports;
 	struct lan966x_port **ports;
 

-- 
2.34.1

