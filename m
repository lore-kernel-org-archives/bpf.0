Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BAB94CB8AC;
	Thu, 24 Sep 2026 19:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790279853; cv=none; b=nOF5TNFEy6wlyLd0DZ+NWfzTwCKvAlnfA1ZOtLMkiWZ4blbLe9PvXLxC+scUBQ48AtYkP9i2bKssE9LPmRs5W6ScT9nCNBpz8KtY/SqWEd1kc8wo5P/hvxjKaGVCiQXK6GyMhDrepIRCkO84V1T/bJ/+sVg33dBs7lUpIPz6qHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790279853; c=relaxed/simple;
	bh=bTmIpqNrNvU3IHtPezg+HL5Y1+Y1opzwgINLmoX0OYI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=ZlXfRULGGS9FgUadO3t5rJAE8r6X8zHi16ky37+ig3/LT/l1WdTedppW0UW6TDGSk6IhflG6Xfu3SiX6khngUDrWZqiFe+8Z9gciKvpPKet62PiUcYdCpUrRAxE8IOKl5ajcPKkS87NgSIQllpplLYkZt0KdseHo0/J0HntKSE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=0UacfMOH; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="0UacfMOH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1790279850; x=1821815850;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=bTmIpqNrNvU3IHtPezg+HL5Y1+Y1opzwgINLmoX0OYI=;
  b=0UacfMOH4q0Rbv6cl/+H1l3MkUdoNL3fjc5He6ISu/qELtFtumaD+Gnr
   L1FS63y4oIpTKopntd1nAV26LrND1G74NFvrp86wzF8LdcQWFCg27ccNz
   X/w/pVUfTpOUpMc33r2GU2Nv+GG1aoCYqgg/7X6W1c9mN24frIWjEkgMU
   CKIIUnByXFyRe8jUS5i9hIxuydVRL0YcGRd/BUsOrV847gFcWoDwt7Fy0
   kO2tRt7tav6xdED2LTFclgOgnzfUE1orWNkrwx5qf0ddRH/hVSwKEOHO3
   7khnbDXe0jT36VnIPKPzzqM13orcd1S8Y8wm90M8nmY7W+l3mhc/61Wsw
   w==;
X-CSE-ConnectionGUID: 4e95//WWTUedOtgVIwaRxw==
X-CSE-MsgGUID: tyP16sZBRs28XDKQe879rA==
X-IronPort-AV: E=Sophos;i="6.27,121,1787036400"; 
   d="scan'208";a="64420630"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Sep 2026 12:57:24 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Thu, 24 Sep 2026 12:57:23 -0700
Received: from DEN-DL-M70577.microsemi.net (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Thu, 24 Sep 2026 12:57:19 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Date: Thu, 24 Sep 2026 21:56:53 +0200
Subject: [PATCH net-next v8 05/15] net: lan966x: add FDMA LLP register
 write helper
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260924-lan966x-pci-fdma-v8-5-201c7b707d8b@microchip.com>
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
Reviewed-by: Simon Horman <horms@kernel.org>
---
 .../net/ethernet/microchip/lan966x/lan966x_fdma.c  | 30 ++++++++++------------
 1 file changed, 14 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c b/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c
index 68fd454ebc98..1c5484a506ff 100644
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
@@ -877,6 +872,9 @@ static int lan966x_fdma_reload(struct lan966x *lan966x, int new_mtu)
 					   MEM_TYPE_PAGE_POOL, page_pool);
 	}
 
+	lan966x_fdma_llp_configure(lan966x, lan966x->rx.fdma.dma,
+				   lan966x->rx.fdma.channel_id);
+
 	lan966x_fdma_rx_start(&lan966x->rx);
 
 	lan966x_fdma_wakeup_netdev(lan966x);

-- 
2.34.1

