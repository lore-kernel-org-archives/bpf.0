Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0BF44E7814;
	Fri, 18 Sep 2026 11:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789731275; cv=none; b=TxX4ZcCZtZHI4FNdkoufAtEwSv73vnT1+Vqra6FPJ25DIeMi+eyb6dpb7yMwDOlxNIaj5yCTWvMuJk2Xy/DXFT4eVo6BnbNOxiBRQpgbMhtXYK6kxpOfb/kCKA2BUQ/qqpShYZoFhgJQCOq0ndQL8RLgBUEspERlCiHfgF8iMK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789731275; c=relaxed/simple;
	bh=GDJaLsAforcU9l7sYaMjbi5eINktR8k9y7Z6G10vv6o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=fzWe/PXTpKnlo0tAHSe7D4xfR9HA7Trj7pFgBBTlhplgwO9xj/4/5acIEc6wYBUy5ALOigmGPEYh0V9U2DnxGlN3kWeQmQsKGuMBmcdEV7wLwP8FjRztTJEG1IbjioYfPjPGTsQODyyBioj/vS6hKsTdnAppI5MUfNZvM/qmyco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=2dOy5uBa; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="2dOy5uBa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1789731274; x=1821267274;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=GDJaLsAforcU9l7sYaMjbi5eINktR8k9y7Z6G10vv6o=;
  b=2dOy5uBaArjJPnW0N0v4MFHrQKrhgVm9hLzt1N98MMyW/83zAkuohUuJ
   53R8Ixoniy8nCZ9k/Cb3ZgExSRWyyhFsxJFnJyUajOAH27GWWEP36u0Aa
   i/FFZCH3Bn8ahTpnXlN7EDFj3x90HWHWXmwSO/o3BSO3zSCaN7eriWH9o
   nFvjdq0AEnQeob/vrjAUlmNN3ROLtllJoqCdfq2vfCPh59aw1NFbgwsy9
   t07XmRYAmNsoXPwMH+cFbwfPwz8W2rhNm2NURKfoBZ6pQ+1QmS8PF/aRe
   1qyxwweRybnU64M/IYJQpnmtKV+Za6Z2dK3c3gj6R8R76SS56DhyVzB88
   g==;
X-CSE-ConnectionGUID: ndc2RRibRyenUA7wb6eCSw==
X-CSE-MsgGUID: Ftl15ZiIQbSwWWNba4mBpw==
X-IronPort-AV: E=Sophos;i="6.27,108,1787036400"; 
   d="scan'208";a="295223731"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 18 Sep 2026 04:34:32 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Fri, 18 Sep 2026 04:34:31 -0700
Received: from DEN-DL-M70577.microsemi.net (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Fri, 18 Sep 2026 04:34:27 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Date: Fri, 18 Sep 2026 13:33:57 +0200
Subject: [PATCH net-next v7 05/14] net: lan966x: export FDMA helpers for
 reuse
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260918-lan966x-pci-fdma-v7-5-0ecc179c8a2c@microchip.com>
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

Make shared FDMA helpers non-static, so they can be reused by the PCIe
FDMA implementation.

Tested-by: Herve Codina <herve.codina@bootlin.com>
Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
---
 .../net/ethernet/microchip/lan966x/lan966x_fdma.c  | 22 +++++++++++-----------
 .../net/ethernet/microchip/lan966x/lan966x_main.h  | 11 +++++++++++
 2 files changed, 22 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c b/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c
index b8344fd5e5ad..1311b79bd11f 100644
--- a/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c
+++ b/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c
@@ -109,8 +109,8 @@ static int lan966x_fdma_rx_alloc_page_pool(struct lan966x_rx *rx)
 	return 0;
 }
 
-static void lan966x_fdma_llp_configure(struct lan966x *lan966x, u64 addr,
-				       u8 channel_id)
+void lan966x_fdma_llp_configure(struct lan966x *lan966x, u64 addr,
+				u8 channel_id)
 {
 	lan_wr(lower_32_bits(addr), lan966x, FDMA_DCB_LLP(channel_id));
 	lan_wr(upper_32_bits(addr), lan966x, FDMA_DCB_LLP1(channel_id));
@@ -140,7 +140,7 @@ static int lan966x_fdma_rx_alloc(struct lan966x_rx *rx)
 	return 0;
 }
 
-static void lan966x_fdma_rx_start(struct lan966x_rx *rx)
+void lan966x_fdma_rx_start(struct lan966x_rx *rx)
 {
 	struct lan966x *lan966x = rx->lan966x;
 	struct fdma *fdma = &rx->fdma;
@@ -171,7 +171,7 @@ static void lan966x_fdma_rx_start(struct lan966x_rx *rx)
 		lan966x, FDMA_CH_ACTIVATE);
 }
 
-static void lan966x_fdma_rx_disable(struct lan966x_rx *rx)
+void lan966x_fdma_rx_disable(struct lan966x_rx *rx)
 {
 	struct lan966x *lan966x = rx->lan966x;
 	struct fdma *fdma = &rx->fdma;
@@ -191,7 +191,7 @@ static void lan966x_fdma_rx_disable(struct lan966x_rx *rx)
 		lan966x, FDMA_CH_DB_DISCARD);
 }
 
-static void lan966x_fdma_rx_reload(struct lan966x_rx *rx)
+void lan966x_fdma_rx_reload(struct lan966x_rx *rx)
 {
 	struct lan966x *lan966x = rx->lan966x;
 
@@ -264,7 +264,7 @@ static void lan966x_fdma_tx_activate(struct lan966x_tx *tx)
 		lan966x, FDMA_CH_ACTIVATE);
 }
 
-static void lan966x_fdma_tx_disable(struct lan966x_tx *tx)
+void lan966x_fdma_tx_disable(struct lan966x_tx *tx)
 {
 	struct lan966x *lan966x = tx->lan966x;
 	struct fdma *fdma = &tx->fdma;
@@ -296,7 +296,7 @@ static void lan966x_fdma_tx_reload(struct lan966x_tx *tx)
 		lan966x, FDMA_CH_RELOAD);
 }
 
-static void lan966x_fdma_wakeup_netdev(struct lan966x *lan966x)
+void lan966x_fdma_wakeup_netdev(struct lan966x *lan966x)
 {
 	struct lan966x_port *port;
 	int i;
@@ -470,7 +470,7 @@ static struct sk_buff *lan966x_fdma_rx_get_frame(struct lan966x_rx *rx,
 	return NULL;
 }
 
-static int lan966x_fdma_napi_poll(struct napi_struct *napi, int weight)
+int lan966x_fdma_napi_poll(struct napi_struct *napi, int weight)
 {
 	struct lan966x *lan966x = container_of(napi, struct lan966x, napi);
 	struct lan966x_rx *rx = &lan966x->rx;
@@ -583,7 +583,7 @@ static int lan966x_fdma_get_next_dcb(struct lan966x_tx *tx)
 	return -1;
 }
 
-static void lan966x_fdma_tx_start(struct lan966x_tx *tx)
+void lan966x_fdma_tx_start(struct lan966x_tx *tx)
 {
 	struct lan966x *lan966x = tx->lan966x;
 
@@ -801,7 +801,7 @@ static int lan966x_fdma_get_max_mtu(struct lan966x *lan966x)
 	return max_mtu;
 }
 
-static int lan966x_qsys_sw_status(struct lan966x *lan966x)
+int lan966x_qsys_sw_status(struct lan966x *lan966x)
 {
 	return lan_rd(lan966x, QSYS_SW_STATUS(CPU_PORT));
 }
@@ -883,7 +883,7 @@ static int lan966x_fdma_reload(struct lan966x *lan966x, int new_mtu)
 	return err;
 }
 
-static int lan966x_fdma_get_max_frame(struct lan966x *lan966x)
+int lan966x_fdma_get_max_frame(struct lan966x *lan966x)
 {
 	return lan966x_fdma_get_max_mtu(lan966x) +
 	       IFH_LEN_BYTES +
diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_main.h b/drivers/net/ethernet/microchip/lan966x/lan966x_main.h
index eea286c29474..83c361abb789 100644
--- a/drivers/net/ethernet/microchip/lan966x/lan966x_main.h
+++ b/drivers/net/ethernet/microchip/lan966x/lan966x_main.h
@@ -561,6 +561,17 @@ int lan966x_fdma_init(struct lan966x *lan966x);
 void lan966x_fdma_deinit(struct lan966x *lan966x);
 irqreturn_t lan966x_fdma_irq_handler(int irq, void *args);
 int lan966x_fdma_reload_page_pool(struct lan966x *lan966x);
+int lan966x_fdma_napi_poll(struct napi_struct *napi, int weight);
+void lan966x_fdma_llp_configure(struct lan966x *lan966x, u64 addr,
+				u8 channel_id);
+void lan966x_fdma_rx_start(struct lan966x_rx *rx);
+void lan966x_fdma_rx_disable(struct lan966x_rx *rx);
+void lan966x_fdma_rx_reload(struct lan966x_rx *rx);
+void lan966x_fdma_tx_start(struct lan966x_tx *tx);
+void lan966x_fdma_tx_disable(struct lan966x_tx *tx);
+void lan966x_fdma_wakeup_netdev(struct lan966x *lan966x);
+int lan966x_fdma_get_max_frame(struct lan966x *lan966x);
+int lan966x_qsys_sw_status(struct lan966x *lan966x);
 
 int lan966x_lag_port_join(struct lan966x_port *port,
 			  struct net_device *brport_dev,

-- 
2.34.1

