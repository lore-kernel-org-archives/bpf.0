Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2113566C78;
	Wed,  9 Sep 2026 13:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788958862; cv=none; b=ARkrCncKjB3gRXVBFZQHTsura7TJYQqxmId6anmPY9oC2Awo2npMRhN5Xt7pQSy4lVUqOcBKNDlVSb8NLSVDZCnga/pykH5l2/JsSZwkzVHri2MjRd9r1Cbp7Xw1jFiN6BBkOvVqZiD+Kqj6SLXvbTrzmTyFT7B7O3hNEuRba1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788958862; c=relaxed/simple;
	bh=//1Sej3ygsAUOeV8Xbw9m53S52nHYA3SXR8Urfm05bw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=iotObJt4TtJKJUQZyZSx/DyZlSk/Nepf8HSUf6GDjzYdDBlZSLVbaHaNUWgOcxm1aITq+2KezgWKhcUOEwDtx2++K8mtGxpqzunTPYWFHbMNz1I9pBOmdHQ3flbGaiqvwaHa+wFa0pb1iWWTTdaoSGDQnxNAXBkRxJlFZwYGBb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Vo/gdgSb; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Vo/gdgSb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1788958861; x=1820494861;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=//1Sej3ygsAUOeV8Xbw9m53S52nHYA3SXR8Urfm05bw=;
  b=Vo/gdgSbsWzeFrPfmsq7L8QyhoiKN77V8WWR56PQkYd/sATFWyYOgPNh
   IPvDfQuM4FkKVPZdvM8cPzDyLtnqOYZHbQfBBY2vLVgQd9ESrqoCx7c/U
   HEh6ltop7mBbgV3FKjiPWiDr2+ktyb/800XiVYF/aMwhClb0AOvOkhj22
   v6DgoogRrUYjtEGDaTEXicpMetQmnrQNuej/qKBu4g+ZVWQ396TWY9A8r
   rxPJFCrQZQDgxGuAbT8fWpJHaoRT1t+0vThAYocdrpn2S6z4zDyzxX+C2
   SS8r9TDokZGND3BM2wpWbxDnGJwT1gfqjTnXKrMrQZR9nARX3qVn1AOUn
   A==;
X-CSE-ConnectionGUID: 7eRe6HgDTF2R+8/Z6zeXFg==
X-CSE-MsgGUID: 7LG8u9CqT2SlIST+25QDLA==
X-IronPort-AV: E=Sophos;i="6.25,270,1779174000"; 
   d="scan'208";a="294759147"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2026 06:01:00 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex3.mchp-main.com (10.10.87.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.45; Wed, 9 Sep 2026 06:00:59 -0700
Received: from DEN-DL-M70577.microsemi.net (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Wed, 9 Sep 2026 06:00:55 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Date: Wed, 9 Sep 2026 15:00:11 +0200
Subject: [PATCH net-next v6 09/14] net: lan966x: add shutdown callback to
 stop FDMA on reboot
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260909-lan966x-pci-fdma-v6-9-6f48dab9d671@microchip.com>
References: <20260909-lan966x-pci-fdma-v6-0-6f48dab9d671@microchip.com>
In-Reply-To: <20260909-lan966x-pci-fdma-v6-0-6f48dab9d671@microchip.com>
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

When lan966x is used as a PCIe endpoint, the FDMA engine runs on the
card and survives a host reboot. Without a shutdown callback, channels
stay active and interrupt sources stay armed across the reset, causing
the shared PCIe INTx to assert before the driver has re-probed.

Add a shutdown callback, shared by the platform and PCI paths, that
disables NAPI and stops the netdev TX queues, then disables the RX and
TX channels, and finally masks the interrupt sources that share the PCIe
INTx: FDMA (FDMA_INTR_ENA and FDMA_INTR_DB_ENA) and the analyzer
(ANA_ANAINTR), which lan966x_init() arms unconditionally.

Masking is only required on this path: on reboot the kernel calls
device_shutdown(), so shutdown() is the only callback that runs. On
unbind, fdma_deinit() disables both channels and waits for them to go
idle before lan966x_cleanup_ports() releases the FDMA interrupt handler,
so the engine cannot assert the shared line once the handler is gone.

FDMA_INTR_ENA persists on the card across a warm reboot, so also
restore the full enable in lan966x_fdma_rx_start() to re-arm interrupts
after a previous shutdown(). rx_start() runs after both the RX and TX
rings are allocated, so the same single-site re-arm works for both the
platform and PCIe backends.

Tested-by: Herve Codina <herve.codina@bootlin.com>
Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
---
 .../net/ethernet/microchip/lan966x/lan966x_fdma.c  | 19 ++++++++++++++++
 .../net/ethernet/microchip/lan966x/lan966x_main.c  | 26 ++++++++++++++++++++++
 .../net/ethernet/microchip/lan966x/lan966x_main.h  |  1 +
 .../net/ethernet/microchip/lan966x/lan966x_regs.h  | 15 +++++++++++++
 4 files changed, 61 insertions(+)

diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c b/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c
index 2695bc41e52a..5793a83268fc 100644
--- a/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c
+++ b/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c
@@ -146,6 +146,10 @@ void lan966x_fdma_rx_start(struct lan966x_rx *rx)
 	struct fdma *fdma = &rx->fdma;
 	u32 mask;
 
+	lan_wr(FDMA_INTR_ENA_INTR_PORT_ENA_SET(GENMASK(1, 0)) |
+	       FDMA_INTR_ENA_INTR_CH_ENA_SET(GENMASK(7, 0)),
+	       lan966x, FDMA_INTR_ENA);
+
 	lan_wr(FDMA_CH_CFG_CH_DCB_DB_CNT_SET(fdma->n_dbs) |
 	       FDMA_CH_CFG_CH_INTR_DB_EOF_ONLY_SET(1) |
 	       FDMA_CH_CFG_CH_INJ_PORT_SET(0) |
@@ -325,6 +329,21 @@ static void lan966x_fdma_stop_netdev(struct lan966x *lan966x)
 	}
 }
 
+/* Drain in-flight xmit callers and stop all TX queues on every port. */
+void lan966x_fdma_tx_disable_netdev(struct lan966x *lan966x)
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
 static void lan966x_fdma_tx_clear_buf(struct lan966x *lan966x, int weight)
 {
 	struct lan966x_tx *tx = &lan966x->tx;
diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_main.c b/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
index 11094a381ec2..d6ce1e3e373f 100644
--- a/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
+++ b/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
@@ -1324,9 +1324,35 @@ static void lan966x_remove(struct platform_device *pdev)
 	debugfs_remove_recursive(lan966x->debugfs_root);
 }
 
+static void lan966x_shutdown(struct platform_device *pdev)
+{
+	struct lan966x *lan966x = platform_get_drvdata(pdev);
+
+	if (!lan966x->fdma)
+		return;
+
+	/* The reload paths disable this NAPI under rtnl; serialize with them. */
+	rtnl_lock();
+
+	if (lan966x->fdma_ndev)
+		napi_disable(&lan966x->napi);
+
+	lan966x_fdma_tx_disable_netdev(lan966x);
+
+	lan966x_fdma_rx_disable(&lan966x->rx);
+	lan966x_fdma_tx_disable(&lan966x->tx);
+
+	lan_wr(0, lan966x, FDMA_INTR_ENA);
+	lan_wr(0, lan966x, FDMA_INTR_DB_ENA);
+	lan_wr(0, lan966x, ANA_ANAINTR);
+
+	rtnl_unlock();
+}
+
 static struct platform_driver lan966x_driver = {
 	.probe = lan966x_probe,
 	.remove = lan966x_remove,
+	.shutdown = lan966x_shutdown,
 	.driver = {
 		.name = "lan966x-switch",
 		.of_match_table = lan966x_match,
diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_main.h b/drivers/net/ethernet/microchip/lan966x/lan966x_main.h
index aab5e53ed059..b7e3ce4f0355 100644
--- a/drivers/net/ethernet/microchip/lan966x/lan966x_main.h
+++ b/drivers/net/ethernet/microchip/lan966x/lan966x_main.h
@@ -586,6 +586,7 @@ void lan966x_fdma_rx_reload(struct lan966x_rx *rx);
 void lan966x_fdma_tx_start(struct lan966x_tx *tx);
 void lan966x_fdma_tx_disable(struct lan966x_tx *tx);
 void lan966x_fdma_wakeup_netdev(struct lan966x *lan966x);
+void lan966x_fdma_tx_disable_netdev(struct lan966x *lan966x);
 int lan966x_fdma_get_max_frame(struct lan966x *lan966x);
 int lan966x_qsys_sw_status(struct lan966x *lan966x);
 
diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_regs.h b/drivers/net/ethernet/microchip/lan966x/lan966x_regs.h
index 4b553927d2e0..aba0d36ae6b5 100644
--- a/drivers/net/ethernet/microchip/lan966x/lan966x_regs.h
+++ b/drivers/net/ethernet/microchip/lan966x/lan966x_regs.h
@@ -1039,6 +1039,21 @@ enum lan966x_target {
 /*      FDMA:FDMA:FDMA_INTR_ERR */
 #define FDMA_INTR_ERR             __REG(TARGET_FDMA, 0, 1, 8, 0, 1, 428, 400, 0, 1, 4)
 
+/*      FDMA:FDMA:FDMA_INTR_ENA */
+#define FDMA_INTR_ENA             __REG(TARGET_FDMA, 0, 1, 8, 0, 1, 428, 404, 0, 1, 4)
+
+#define FDMA_INTR_ENA_INTR_PORT_ENA              GENMASK(9, 8)
+#define FDMA_INTR_ENA_INTR_PORT_ENA_SET(x)\
+	FIELD_PREP(FDMA_INTR_ENA_INTR_PORT_ENA, x)
+#define FDMA_INTR_ENA_INTR_PORT_ENA_GET(x)\
+	FIELD_GET(FDMA_INTR_ENA_INTR_PORT_ENA, x)
+
+#define FDMA_INTR_ENA_INTR_CH_ENA                GENMASK(7, 0)
+#define FDMA_INTR_ENA_INTR_CH_ENA_SET(x)\
+	FIELD_PREP(FDMA_INTR_ENA_INTR_CH_ENA, x)
+#define FDMA_INTR_ENA_INTR_CH_ENA_GET(x)\
+	FIELD_GET(FDMA_INTR_ENA_INTR_CH_ENA, x)
+
 /*      FDMA:FDMA:FDMA_ERRORS */
 #define FDMA_ERRORS               __REG(TARGET_FDMA, 0, 1, 8, 0, 1, 428, 412, 0, 1, 4)
 

-- 
2.34.1

