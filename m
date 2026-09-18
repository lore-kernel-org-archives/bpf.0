Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 442454E4C4C;
	Fri, 18 Sep 2026 11:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789731271; cv=none; b=dwmZFehFlfFFDp/CwkcI4ho/xcExmsHIiuEn8nWBqCvthlzSTjzIdW6IN04oGMZV++7QgAyxWAcjoRzQ0u3JqiMC4ykjBOAMNB0amU3fWUtGyfbDHpNiutzwgmlz/VYe/OZuwEWEynz9p6J7Il4DfKiovJuAa6Fj0RQvKJvZGDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789731271; c=relaxed/simple;
	bh=QYGrFqOkLMGg0egcUveRB4ur4cCoutEpPPiq+t5aHao=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=szYzskqYrN6yb8kL0C6zniumKs8ruxU4OA6KCcEFmhRNC22cYeKnKcstszGlq8PR28BeDF6yCS1Pv/cv7HAD9mGohkfZ6J5xUlWlOU37TbLST30gxQvVr434ecs6emOpDsz/9cvNzxMXwTXjLgPA9IkFK0j/GqXlIWlqvJyLnNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=0t6ZDKS2; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="0t6ZDKS2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1789731270; x=1821267270;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=QYGrFqOkLMGg0egcUveRB4ur4cCoutEpPPiq+t5aHao=;
  b=0t6ZDKS2d3tsohExScV77p0HrEJvsBRQQXHID7kewpnnlt0oTwanS8Hz
   wwfEocH7312Sgo2I5PX30ihFdKX/296fbWrvcKESYxBVQjPEt8V3dMYyO
   CUtjxnlmWvMQGXWOQaCSDdF9QFZTTcbnXYP44ShaxFVPD9v6jJuiTYWew
   dSHRq/+SRhfs+YWVaQisL23RMFxgRl72uzPvG3/ZlsAMT4fdnzEdCayX8
   w2I+E8JnTKw6wAcqCCQ5ktrddoEMhAJUuFnv4zXOlBtsJUk+wGYtkcVXo
   34jAgZjRJM/SU/Q1EySCfoEb68M8Frv+ovWORE41G2q8gLny0Z5+rLfxL
   Q==;
X-CSE-ConnectionGUID: uo6KZvGdTLa58gFarbPKYA==
X-CSE-MsgGUID: U1RNkHnpQXi54m3bcOSe6Q==
X-IronPort-AV: E=Sophos;i="6.27,108,1787036400"; 
   d="scan'208";a="295223728"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2026 04:34:28 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.87.151) by
 chn-vm-ex4.mchp-main.com (10.10.87.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.49; Fri, 18 Sep 2026 04:34:27 -0700
Received: from DEN-DL-M70577.microsemi.net (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Fri, 18 Sep 2026 04:34:23 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Date: Fri, 18 Sep 2026 13:33:56 +0200
Subject: [PATCH net-next v7 04/14] net: lan966x: add FDMA LLP register
 write helper
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260918-lan966x-pci-fdma-v7-4-0ecc179c8a2c@microchip.com>
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

The FDMA Link List Pointer (LLP) register points to the first DCB in the
chain and must be written before the channel is activated. This tells
the FDMA engine where to begin DMA transfers.

Move the LLP register writes from the channel start/activate functions
into the allocation functions and introduce a shared
lan966x_fdma_llp_configure() helper. This is needed because the upcoming
PCIe FDMA path writes ATU-translated addresses to the LLP registers
instead of DMA addresses. Keeping the writes in the shared
start/activate path would overwrite these translated addresses.

Tested-by: Herve Codina <herve.codina@bootlin.com>
Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
---
 .../net/ethernet/microchip/lan966x/lan966x_fdma.c  | 30 ++++++++++------------
 1 file changed, 14 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c b/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c
index 41d4ec7f2f57..b8344fd5e5ad 100644
--- a/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c
+++ b/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c
@@ -109,6 +109,13 @@ static int lan966x_fdma_rx_alloc_page_pool(struct lan966x_rx *rx)
 	return 0;
 }
 
+static void lan966x_fdma_llp_configure(struct lan966x *lan966x, u64 addr,
+				       u8 channel_id)
+{
+	lan_wr(lower_32_bits(addr), lan966x, FDMA_DCB_LLP(channel_id));
+	lan_wr(upper_32_bits(addr), lan966x, FDMA_DCB_LLP1(channel_id));
+}
+
 static int lan966x_fdma_rx_alloc(struct lan966x_rx *rx)
 {
 	struct lan966x *lan966x = rx->lan966x;
@@ -128,6 +135,8 @@ static int lan966x_fdma_rx_alloc(struct lan966x_rx *rx)
 	fdma_dcbs_init(fdma, FDMA_DCB_INFO_DATAL(fdma->db_size),
 		       FDMA_DCB_STATUS_INTR);
 
+	lan966x_fdma_llp_configure(lan966x, fdma->dma, fdma->channel_id);
+
 	return 0;
 }
 
@@ -137,14 +146,6 @@ static void lan966x_fdma_rx_start(struct lan966x_rx *rx)
 	struct fdma *fdma = &rx->fdma;
 	u32 mask;
 
-	/* When activating a channel, first is required to write the first DCB
-	 * address and then to activate it
-	 */
-	lan_wr(lower_32_bits((u64)fdma->dma), lan966x,
-	       FDMA_DCB_LLP(fdma->channel_id));
-	lan_wr(upper_32_bits((u64)fdma->dma), lan966x,
-	       FDMA_DCB_LLP1(fdma->channel_id));
-
 	lan_wr(FDMA_CH_CFG_CH_DCB_DB_CNT_SET(fdma->n_dbs) |
 	       FDMA_CH_CFG_CH_INTR_DB_EOF_ONLY_SET(1) |
 	       FDMA_CH_CFG_CH_INJ_PORT_SET(0) |
@@ -215,6 +216,8 @@ static int lan966x_fdma_tx_alloc(struct lan966x_tx *tx)
 
 	fdma_dcbs_init(fdma, 0, 0);
 
+	lan966x_fdma_llp_configure(lan966x, fdma->dma, fdma->channel_id);
+
 	return 0;
 
 out:
@@ -236,14 +239,6 @@ static void lan966x_fdma_tx_activate(struct lan966x_tx *tx)
 	struct fdma *fdma = &tx->fdma;
 	u32 mask;
 
-	/* When activating a channel, first is required to write the first DCB
-	 * address and then to activate it
-	 */
-	lan_wr(lower_32_bits((u64)fdma->dma), lan966x,
-	       FDMA_DCB_LLP(fdma->channel_id));
-	lan_wr(upper_32_bits((u64)fdma->dma), lan966x,
-	       FDMA_DCB_LLP1(fdma->channel_id));
-
 	lan_wr(FDMA_CH_CFG_CH_DCB_DB_CNT_SET(fdma->n_dbs) |
 	       FDMA_CH_CFG_CH_INTR_DB_EOF_ONLY_SET(1) |
 	       FDMA_CH_CFG_CH_INJ_PORT_SET(0) |
@@ -876,6 +871,9 @@ static int lan966x_fdma_reload(struct lan966x *lan966x, int new_mtu)
 					   MEM_TYPE_PAGE_POOL, page_pool);
 	}
 
+	lan966x_fdma_llp_configure(lan966x, lan966x->rx.fdma.dma,
+				   lan966x->rx.fdma.channel_id);
+
 	lan966x_fdma_rx_start(&lan966x->rx);
 
 	lan966x_fdma_wakeup_netdev(lan966x);

-- 
2.34.1

