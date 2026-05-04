Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA39C3E0C50;
	Mon,  4 May 2026 14:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777904648; cv=none; b=P+DaME8OKJi9ozKQlozXkkia/D62pWMlf40h6M6EV1mhGkkdmmEO4na2tnQL0/nvXnCXGtGvQx45NlXAx1gdb3fuczRNPCYpmx2O+jmzRxlaMCDEvONBYa4qRW2FybT2sDRBYQqZgkJlYf4xPKzbj8oyUn7+hIY0BHb81mMHBuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777904648; c=relaxed/simple;
	bh=4m9UwlMVsJgfdfVuYRQ5q8r0FAqsC574/KEoStxXQnU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=hNLjMM+Tkg8to8SsB6J4xrGuKgo4SXahRyDiTl3xF+DXtsbaKDdqim8gRIXwKe3QiQh6hrYgdfpo5AeEh+EQN6mSRCjrEG0KRwWaZf2lkpqNz6Fox5Hh/pJ3BouHCWZxCuZe0L8uFJaEBz3Z0BbVFo78AvFwOfNqBKUujI9RjUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=H7OrnUc/; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="H7OrnUc/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1777904647; x=1809440647;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=4m9UwlMVsJgfdfVuYRQ5q8r0FAqsC574/KEoStxXQnU=;
  b=H7OrnUc/vhwFUsCsGTdhmcQfyzd/TPTGiXOU/pc5u/4X0vRXpJm8MHgy
   bGpC0wb+VkJ0IMlvBkTuHIxBNAPkjVlQM8ZiNeKRzPRSvhw+P1ruonZtf
   6MVgFaZ2EsPMPGIZIgs9qWrqT5tS1oxt75yGAhz8HPkUVAw0WnppXhPKA
   rfjMU8Tf1U4fmTo3QoNxM6zASF8Xgzr/8ilxpebRlmyv6sT0MXxly59lQ
   +KYfYHoaXpe4oDwDHrujfBDxn3YXnkKofPFnbcmIMPZplKrN5hKYFauXu
   pjI+4eLFwaN7WT/DARlR4DnqCZKnjmcX+zeg2A0p+52Jv5Ia9UxY0usdO
   w==;
X-CSE-ConnectionGUID: 8JAzyZQeTOicKXPNwhcXLg==
X-CSE-MsgGUID: ThdsocGGQAaNsoKqOb+GJw==
X-IronPort-AV: E=Sophos;i="6.23,215,1770620400"; 
   d="scan'208";a="56221199"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 May 2026 07:24:06 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Mon, 4 May 2026 07:24:05 -0700
Received: from DEN-DL-M70577.microsemi.net (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Mon, 4 May 2026 07:24:02 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Date: Mon, 4 May 2026 16:23:21 +0200
Subject: [PATCH net-next v3 08/13] net: lan966x: add shutdown callback to
 stop FDMA on reboot
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260504-lan966x-pci-fdma-v3-8-a56f5740d870@microchip.com>
References: <20260504-lan966x-pci-fdma-v3-0-a56f5740d870@microchip.com>
In-Reply-To: <20260504-lan966x-pci-fdma-v3-0-a56f5740d870@microchip.com>
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
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<bpf@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
X-Mailer: b4 0.14.3

When lan966x is used as a PCIe endpoint, the FDMA engine runs on the
card and survives a host reboot. Without a shutdown callback, channels
stay active and interrupt sources stay armed across the reset, causing
the shared PCIe INTx to assert before the driver has re-probed.

Add a shutdown callback, shared by the platform and PCI paths, that
masks FDMA interrupts (FDMA_INTR_ENA and FDMA_INTR_DB_ENA) and disables
the RX and TX channels.

FDMA_INTR_ENA persists on the card across a warm reboot, so also
restore the full enable in lan966x_fdma_rx_start() to re-arm interrupts
after a previous shutdown(). rx_start() runs after both the RX and TX
rings are allocated, so the same single-site re-arm works for both the
platform and PCIe backends.

Tested-by: Herve Codina <herve.codina@bootlin.com>
Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
---
 drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c |  4 ++++
 drivers/net/ethernet/microchip/lan966x/lan966x_main.c | 18 ++++++++++++++++++
 drivers/net/ethernet/microchip/lan966x/lan966x_regs.h | 15 +++++++++++++++
 3 files changed, 37 insertions(+)

diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c b/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c
index 9bb40383aa56..493aef5ba8d1 100644
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
diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_main.c b/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
index b3701953b090..271c023900db 100644
--- a/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
+++ b/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
@@ -1311,9 +1311,27 @@ static void lan966x_remove(struct platform_device *pdev)
 	debugfs_remove_recursive(lan966x->debugfs_root);
 }
 
+static void lan966x_shutdown(struct platform_device *pdev)
+{
+	struct lan966x *lan966x = platform_get_drvdata(pdev);
+
+	if (!lan966x->fdma)
+		return;
+
+	lan966x_fdma_rx_disable(&lan966x->rx);
+	lan966x_fdma_tx_disable(&lan966x->tx);
+
+	napi_synchronize(&lan966x->napi);
+	napi_disable(&lan966x->napi);
+
+	lan_wr(0, lan966x, FDMA_INTR_ENA);
+	lan_wr(0, lan966x, FDMA_INTR_DB_ENA);
+}
+
 static struct platform_driver lan966x_driver = {
 	.probe = lan966x_probe,
 	.remove = lan966x_remove,
+	.shutdown = lan966x_shutdown,
 	.driver = {
 		.name = "lan966x-switch",
 		.of_match_table = lan966x_match,
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

