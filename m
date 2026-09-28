Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F33A950E5B1;
	Mon, 28 Sep 2026 19:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790624021; cv=none; b=QH0cr1M0IOgYKZM8DHPVieZB3Nz1kGJ2lUpLS9qZKzTTLRLyo/GfaoS75Qj26fW0/k0Noqr/LI8nFFFbmOdZCngNcQIliV3KAY3aYa9xa6mIFq3GQBb+zCRlxPaWcD0C5XuznNWSldZ63vlx/yraT9CZ44T3ZoVAn8PN8/xV4Dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790624021; c=relaxed/simple;
	bh=pGR7i7vKpqRNc9vGubTZLDoyFujs97jb/TlsjbSuprY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=CcEHhrNPwcoz9057ODCyfCaDCm4HGb4ZvK4BHRtJAnEW5LbNl3N7s3p/23Q5q+GXUvuRJgC9ZVKQsfe2Zk0GKmCx6sws6j36N4szqmRi4T2O8RVj6rwEfajr4TE+7VpsA4EUGRwbGODHJwG9R0X0SPx6wGxyqyAOw3GW8Vs9xBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=017w5NMO; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="017w5NMO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1790624025; x=1822160025;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=pGR7i7vKpqRNc9vGubTZLDoyFujs97jb/TlsjbSuprY=;
  b=017w5NMOmefPdvNMH/S6Vt3dib9ho+ok1qM6yVAMrP6xKF6L5ONQYsOU
   sXwIJQZLqoeIbMruXSS1gyxJa4oLLGeTE8r7rTBn3O7Q4ZhWWlAeEuTNI
   u///dzFo1O7mq1GXUaZxqd2Pwe1BqG8tGT8Qbt1rU5llkerpJXWH+u4EB
   X56/anQO0reNh7VRHtnG2ba7rFcg09C0E5JvDO9w158G70Y3uLltL5ib1
   Z5irT/cdrz5p99j/Jxb3Vwed0+K8keDQ7mFSGNrTpo1RsLvrT7d/kjS7s
   ChoBbHXm281gbnmaH+7lGhIbhFNPnRJCpXAOoON8m+bBmv8JWKbOx4nYu
   A==;
X-CSE-ConnectionGUID: js5/hRQbSi2Oc7AOIwE8Og==
X-CSE-MsgGUID: r4hgFR5jQTWj6EM2Eh/qbg==
X-IronPort-AV: E=Sophos;i="6.27,129,1787036400"; 
   d="scan'208";a="63340456"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Sep 2026 12:33:44 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Mon, 28 Sep 2026 12:33:38 -0700
Received: from DEN-DL-M70577.microsemi.net (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Mon, 28 Sep 2026 12:33:35 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Date: Mon, 28 Sep 2026 21:32:58 +0200
Subject: [PATCH net-next v9 10/15] net: lan966x: add shutdown callback to
 stop the FDMA on reboot
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260928-lan966x-pci-fdma-v9-10-a17caf60f89a@microchip.com>
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

As a PCIe endpoint, lan966x is not reset by a host reboot: its FDMA
channels and interrupt sources stay armed, and the OIC ORs every
source into the shared PCIe INTx, asserted before the driver has
re-probed. A still-active channel also keeps write access to host
memory the next kernel will reuse.

Add a shutdown callback that:
- frees the ana, xtr and FDMA irqs, masking and unmapping them at
  the OIC (disable_irq() would leave both set - the OIC has no
  irq_disable())
- masks the analyzer source, armed unconditionally by lan966x_init()
  and re-armed by the MAC table's age timer
- stops and detaches the netdevs, draining in-flight xmit and
  clearing netif_device_present() so ndo_open/ndo_change_mtu cannot
  re-enter the FDMA against a disabled NAPI
- disables both FDMA channels and masks their interrupts
- unmaps the outbound ATU windows, leaving none armed (the windows
  are mapped by the PCIe FDMA backend added later in this series)

NAPI is skipped when fdma_ndev is unset (a probed switch with no
usable port never adds one), and XDP attach cannot re-enter the FDMA
either: on PCIe, lan966x_xdp_setup() returns before the page pool
reload, which is the only point where it touches the FDMA.

Only the PCIe instantiation needs this - the SoC one resets with the
chip - so the callback returns early on a platform device; the check
is at runtime since .shutdown belongs to the driver, and a
PCIe-enabled kernel binds both.

FDMA_INTR_ENA persists across a warm reboot, so also restore the
full enable in lan966x_fdma_rx_start(), run after both rings are
allocated. The PCIe FDMA backend added later in this series starts
RX through the same function, so both backends are re-armed from
one site.

Tested-by: Herve Codina <herve.codina@bootlin.com>
Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
Reviewed-by: Simon Horman <horms@kernel.org>
---
 .../net/ethernet/microchip/lan966x/lan966x_fdma.c  |  4 ++
 .../net/ethernet/microchip/lan966x/lan966x_main.c  | 56 ++++++++++++++++++++++
 .../net/ethernet/microchip/lan966x/lan966x_regs.h  | 15 ++++++
 3 files changed, 75 insertions(+)

diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c b/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c
index 5f46166cbfe4..2e8f786d6fee 100644
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
index 259d81e75907..024ce9f9916c 100644
--- a/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
+++ b/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
@@ -1324,9 +1324,65 @@ static void lan966x_remove(struct platform_device *pdev)
 	debugfs_remove_recursive(lan966x->debugfs_root);
 }
 
+static void lan966x_shutdown(struct platform_device *pdev)
+{
+	struct lan966x *lan966x = platform_get_drvdata(pdev);
+
+	/* As a PCIe endpoint the switch is not reset by the host reboot, so it
+	 * has to be quiesced here:
+	 *
+	 *   Free the irqs and mask the sources: no source can assert INTx.
+	 *   Disable NAPI: the teardown must not race a poll.
+	 *   Stop and detach the netdevs: drains xmit, closes ndo_open and MTU.
+	 *   Stop the FDMA channels: waits for the engine to go idle.
+	 *   Unmap the ATU windows: revokes the engine's access to host memory.
+	 */
+	if (!lan966x_is_pci(lan966x))
+		return;
+
+	if (lan966x->xtr_irq > 0)
+		devm_free_irq(lan966x->dev, lan966x->xtr_irq, lan966x);
+	if (lan966x->ana_irq > 0)
+		devm_free_irq(lan966x->dev, lan966x->ana_irq, lan966x);
+	if (lan966x->fdma_irq > 0)
+		devm_free_irq(lan966x->dev, lan966x->fdma_irq, lan966x);
+
+	lan_wr(0, lan966x, ANA_ANAINTR);
+
+	if (!lan966x->fdma)
+		return;
+
+	rtnl_lock();
+
+	if (lan966x->fdma_ndev)
+		napi_disable(&lan966x->napi);
+
+	for (int p = 0; p < lan966x->num_phys_ports; p++) {
+		if (!lan966x->ports[p] || !lan966x->ports[p]->dev)
+			continue;
+
+		netif_tx_disable(lan966x->ports[p]->dev);
+		netif_device_detach(lan966x->ports[p]->dev);
+	}
+
+	lan966x_fdma_rx_disable(&lan966x->rx);
+	lan966x_fdma_tx_disable(&lan966x->tx);
+
+	lan_wr(0, lan966x, FDMA_INTR_ENA);
+	lan_wr(0, lan966x, FDMA_INTR_DB_ENA);
+
+#if IS_ENABLED(CONFIG_MCHP_LAN966X_PCI)
+	fdma_pci_atu_region_unmap(lan966x->rx.fdma.atu_region);
+	fdma_pci_atu_region_unmap(lan966x->tx.fdma.atu_region);
+#endif
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

