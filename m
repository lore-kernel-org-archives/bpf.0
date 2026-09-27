Received: from mail-oo2-f37.google.com (mail-oo2-f37.google.com [74.125.231.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 251594483A5
	for <bpf@vger.kernel.org>; Sun, 27 Sep 2026 22:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790546432; cv=none; b=jjbHb9yjjDH2kk7Zpy98blU9A6x7cLs7PprtmdJXbCje4dSVPLr0YL3Ns2ZfIimRmKf4mBkTHBxkliYMOIGYrJ0NYuxctEh0UjXVHY9ILA2ox+1fM39lo6xQ96gajqiiNjXMEo9uWidb6XR7wsU1cJdPqoM63M9uCkAYfpwb0lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790546432; c=relaxed/simple;
	bh=QWxwEYT1xCLk0umqPrhGcUEXQqmPg5rlyOIWP2WAMEM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ENrJEALbd0ZP4VK53xv7vj7XctwLR/EzLPkufN0xzRgsZj4cMp5GHrE8483HmbnUyyUtDi1Gp1hMejGb43W2pkuY0+QKmI1fwZcU22VMZdyVlUhPAV1hwu9waxe7Q9VT96T+z7xkpPlCosGPVMa1GCupUHs1MMPvAZqG2W0vUH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bwy44Xbn; arc=none smtp.client-ip=74.125.231.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bwy44Xbn"
Received: by mail-oo2-f37.google.com with SMTP id 46e09a7af769-8137b129131so1605035a34.2
        for <bpf@vger.kernel.org>; Sun, 27 Sep 2026 15:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790546421; x=1791151221; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vRtKt7akqjsQC1fbwJmITQLzcvUhxZC/q7S47VdnwNU=;
        b=Bwy44Xbnh4b8RE5AlDXTZZQP/E4we0VcjrPPcGVMIfdLAfGpG2y0nTOzNEsRKNfyi+
         K1/dyWw93IyhDPLFI1cn5tiUEye1z47+VyQ5y/iuhQoLVmldhelyhtB9Cc04pQEKeKJp
         ghgj6VzKxrxJHqBkVSgBUz283EPSOLdAClRsuNLskHAkat0aw/maZI2BDztNiba9a7uC
         3gDFq0Al1ceQbSO9Fg5rWYnQZGDV72ZWSvKD5LMsmbOauPAhKyQ9+gnB4ZA7aNySGhMw
         +Zy4OXnOTVnB/qFozHSfUntW5O65ChhJtNwhpsR+nkQeHH6cIqphy6ZbDSorYcsmqTil
         2t2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790546421; x=1791151221;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vRtKt7akqjsQC1fbwJmITQLzcvUhxZC/q7S47VdnwNU=;
        b=P4bp4trQbvXm90BIRzzB4MY/29bBXt18haJOClQxob3ULrfcYbAMQKlQgXzzVu0wIc
         ymEpqexUGpb76CUghkTLC2jDBafmm7q05l1XaRdCcqccgni6/nhS+jB3R6rXb1cEwFZD
         RvypYa8vdlYViXvx1/PW9RZ5EmyQ8JwBi3NX03AoOcg1J4izKJEDv011iUV6/wpWRgc3
         t9UHbIPcBJb9iufW95bL9XQu7zMyPMlhT2r4MYIgMzFL7CDg3v7GNQ7rAfZB4n5zBwmO
         lhUq1x6gFyXOfPuSXeGnw6WUTwKudTq1ZLBe1449JGz7YMBkcjjvJle72QBIGUNUE29d
         0D/w==
X-Forwarded-Encrypted: i=1; AKwUvBxrHps0CMFZlHs79DSX3Ql5yAZDTkB3PJ04frsKY0UkoqUkf2MLiIYcIYAJVsMQsqKv250=@vger.kernel.org
X-Gm-Message-State: AFuF++n1wugxD7F5oC4iq1pIYQ/U2Z4xDsQruN3mG/fUvoRbJLqhF2+B
	yoLB6BlwIn/GBhWtySd7+bSe0n9Uo005UaaaFhvT6YG0h7iNrjUOVMnF
X-Gm-Gg: AYBFou06tg97EqQ3XjHMMbPTofyZq4YJV60vb8PXiYwcR/wmyMGWKJL324L73oFRLgO
	GOGX8Zb6gNYkL9M8eoFYywunb0MPFQE7KTDR2q8q+ioAGPcxzyavM7w6WoZyO5/fieaxtZqrfU9
	jCSO3HvdWpFwL8h6UpnGVfKwpD3WfEt5Iyo8VLFsx16upyKg12syBkBw3Y2DwJ5wcRQCANQAN4V
	jGbaHoTo6KdQy8NxsgECcSXrrupwVw8KjFwJx8KE7TsjLWNa+we/BCfcXd1XSlrUK+gwFT0BoJl
	DxWdN0y7Mz4gUlQPb8J67Bpla49RZE3xTERcRq/Nmh4Gv6qwqI1n0Ldzy8TcgoFjZrRRBMiMO9+
	OLXBTqFML/tlyWSGbtEnfzA5sWgmj3e/peApDMg7qGj8kSQfHIkA3NM7EgKpmY5gsMDr2Npwd6M
	Mm39bU5PEgwz3zkVR1Y6+7RplSdv+A8M9C8i8JEINrojiw9Y4aQOG8KvrIkXExDvLQlFagwVOS4
	W0H2LJeDZjp1IezEJn2+xQxw38UWOmnzCIWXgsU9AtK1Oh2sSzjokgls5bvONRfhRljrBgeSNWY
	Ohu68GVrJ+geCxd10O5c4Hx8pJPHET8vqabDsBJniLJWsMxAq2Lj210d/sTzPoh/Gj35s2XAN55
	82g9qcr0Bjv29ayqh4dtAxjvM6cOACHE=
X-Received: by 2002:a05:6830:1510:b0:819:28cc:637f with SMTP id 46e09a7af769-81928dbb649mr6318897a34.0.1790546420598;
        Sun, 27 Sep 2026 15:00:20 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-81b3de6f7e1sm4874147a34.22.2026.09.27.15.00.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 15:00:19 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sun, 27 Sep 2026 15:59:48 -0600
Subject: [PATCH net-next v5 13/19] net: stmmac: track datapath and power
 ownership across failed reopening
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260927-submit-stmmac-reset-fixes-v1-v5-13-feec6c14dd06@gmail.com>
References: <20260927-submit-stmmac-reset-fixes-v1-v5-0-feec6c14dd06@gmail.com>
In-Reply-To: <20260927-submit-stmmac-reset-fixes-v1-v5-0-feec6c14dd06@gmail.com>
To: Russell King <linux@armlinux.org.uk>, Andrew Lunn <andrew@lunn.ch>, 
 Heiner Kallweit <hkallweit1@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Christian Marangi <ansuelsmth@gmail.com>, 
 Tiezhu Yang <yangtiezhu@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, Serge Semin <fancer.lancer@gmail.com>, 
 Suraj Jaiswal <quic_jsuraj@quicinc.com>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Joao Pinto <Joao.Pinto@synopsys.com>, 
 Vladimir Oltean <vladimir.oltean@nxp.com>, 
 Ong Boon Leong <boon.leong.ong@intel.com>, 
 Voon Weifeng <weifeng.voon@intel.com>, 
 "Song, Yoong Siang" <yoong.siang.song@intel.com>, 
 Linus Walleij <linusw@kernel.org>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Magnus Karlsson <magnus.karlsson@intel.com>, 
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>, 
 Simon Horman <horms@kernel.org>, 
 =?utf-8?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn@kernel.org>, 
 Thierry Reding <thierry.reding@kernel.org>, 
 Jonathan Hunter <jonathanh@nvidia.com>, Chen-Yu Tsai <wens@kernel.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, Jose Abreu <Jose.Abreu@synopsys.com>, 
 Yao Zi <me@ziyao.cc>, Philipp Zabel <p.zabel@pengutronix.de>
Cc: Richard Genoud <richard.genoud@bootlin.com>, 
 Alastair D'Silva <alastair@d-silva.org>, Maxime Ripard <mripard@kernel.org>, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org, 
 ZhaoJinming <zhaojinming@uniontech.com>, 
 Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>, 
 Ding Hui <dinghui1111@163.com>, Linkui Xiao <xiaolinkui@kylinos.cn>, 
 Linkui Xiao <xiaolinkui@126.com>, linux-tegra@vger.kernel.org, 
 linux-sunxi@lists.linux.dev, James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.15.2

Track allocated rings, IRQs and NAPI independently of IFF_UP and of
system sleep. Leave failed live reopening detached while the successful
ndo_open still owns its PHY attachment and runtime-PM reference;
ordinary down/up can recover without duplicate NAPI shutdown or PM puts.

Convert every live reopen consumer together: MTU, XDP program changes
and ethtool ring/channel changes. Restore old settings on error and
publish queue counts only after setup succeeds. XDP removal must release
its program even if rebuilding the non-XDP datapath fails. Use phylink
link replay for successful XDP rebuilding so the PHY is not stopped or
renegotiated.

Keep core sleep cleanup separate from platform and clock restoration.
Serialize noirq clock ownership and retry pending power transitions
before accessing MMIO. If restoration fails, block MAC, MDIO, PCS, IRQ
and PHC register accesses and finish only software cleanup. Check MAC
WoL viability before skipping an already completed core sleep sequence.

A level PMT interrupt can arrive before the IRQ subsystem suspends the
handlers, or when it reenables them before normal device resume. Keep
platform MAC-WoL register, receive and timestamp clocks powered throughout
those windows, instead of returning without acknowledging an asserted
interrupt. Separate optional wake-resource hooks from BSP power removal;
STM32 enables its stop-mode clock without dropping the live clocks.
Tegra retains its private clocks and reset state, and tracks actual clock
ownership across failed recovery. Publish wake handling before arming PMT.
Acknowledge timestamp status even while the PHC is blocked, without
delivering clock events; a new timestamp can arrive after PMT is disarmed
but before the reset or recovery completes.

PCI keeps its existing PME/D3 policy, but runs the BSP power transition
inside the noirq window. Restore register access before handlers run.
If restoration fails, mask the function's INTx assertion through PCI
configuration space, leaving a shared controller line usable by other
devices. Restore INTx after a successful datapath restart. Balance pending
wake resources during resume or close, and undo core sleep if a suspend
callback itself fails.

Close must reattach the netdev so ndo_open can retry power restoration.
Reject ethtool, timestamp, MAC-address, feature and qdisc installation
requests while registers remain inaccessible. Drain receive-filter work
under the address lock before power removal. VLAN and qdisc teardown
still clear their software state without touching unpowered registers.

Permit flower and u32 destruction while down or detached, clearing cached
rules without disabling already-stopped NAPI or accessing registers. TC
forgets deleted filters even when the driver returns an error, so rejecting
destruction would leave stale rules to be replayed on recovery. Keep
installation-only feature and RSS checks out of the destruction path.

Guard non-netdev-detach consumers, including TC, descriptor readback,
XDP transmission and reset work. Freeze deferred XSK teardown before
sleep through the prerequisite XSK change. Preserve PHY ownership on
failed ethtool reopen and stop a PHY temporarily resumed to supply the
MAC reset clock.

Fixes: 3470079687448 ("net: ethernet: stmicro: stmmac: permit MTU change with interface up")
Fixes: 6896c2449a18 ("net: stmmac: Check stmmac_hw_setup() in stmmac_resume()")
Fixes: ac746c8520d9 ("net: stmmac: enhance XDP ZC driver level switching performance")
Fixes: aa042f60e496 ("net: stmmac: Add support to Ethtool get/set ring parameters")
Fixes: 0366f7e06a6b ("net: stmmac: add ethtool support for get/set channels")
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c  |   2 +-
 .../net/ethernet/stmicro/stmmac/dwmac-loongson.c   |   2 +-
 .../net/ethernet/stmicro/stmmac/dwmac-motorcomm.c  |   2 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c  |  18 +
 drivers/net/ethernet/stmicro/stmmac/dwmac-tegra.c  |  27 +-
 .../net/ethernet/stmicro/stmmac/dwmac1000_core.c   |   4 +
 drivers/net/ethernet/stmicro/stmmac/stmmac.h       |  33 +
 .../net/ethernet/stmicro/stmmac/stmmac_ethtool.c   |  11 +
 .../net/ethernet/stmicro/stmmac/stmmac_hwtstamp.c  |  10 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  | 697 ++++++++++++++++++---
 drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c  |  15 +
 drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c   |   2 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_pcs.c   |   3 +-
 .../net/ethernet/stmicro/stmmac/stmmac_platform.c  |  40 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c    |  98 +--
 drivers/net/ethernet/stmicro/stmmac/stmmac_vlan.c  |   6 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_xdp.c   |  39 +-
 include/linux/stmmac.h                             |   7 +
 18 files changed, 831 insertions(+), 185 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
index f5f9fa67ecd7..ba1231852e10 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
@@ -1420,7 +1420,7 @@ static struct pci_driver intel_eth_pci_driver = {
 	.probe = intel_eth_pci_probe,
 	.remove = intel_eth_pci_remove,
 	.driver         = {
-		.pm     = &stmmac_simple_pm_ops,
+		.pm     = &stmmac_pci_pm_ops,
 	},
 };
 
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
index eb14c197d6ae..b91877d3d5fe 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
@@ -607,7 +607,7 @@ static struct pci_driver loongson_dwmac_driver = {
 	.probe = loongson_dwmac_probe,
 	.remove = loongson_dwmac_remove,
 	.driver = {
-		.pm = &stmmac_simple_pm_ops,
+		.pm = &stmmac_pci_pm_ops,
 	},
 };
 
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-motorcomm.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-motorcomm.c
index 124fcd55a429..b888b87bfd90 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-motorcomm.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-motorcomm.c
@@ -376,7 +376,7 @@ static struct pci_driver dwmac_motorcomm_pci_driver = {
 	.probe = motorcomm_probe,
 	.remove = motorcomm_remove,
 	.driver = {
-		.pm = &stmmac_simple_pm_ops,
+		.pm = &stmmac_pci_pm_ops,
 	},
 };
 
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c
index e1b260ed4790..9544925bc36f 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c
@@ -522,6 +522,22 @@ static int stm32_dwmac_resume(struct device *dev, void *bsp_priv)
 	return stm32_dwmac_init(priv->plat);
 }
 
+static int stm32_dwmac_suspend_wol(struct device *dev, void *bsp_priv)
+{
+	struct stm32_dwmac *dwmac = bsp_priv;
+
+	/* Enable the stop-mode wake clock without dropping the live clocks. */
+	return dwmac->ops->suspend ? dwmac->ops->suspend(dwmac) : 0;
+}
+
+static void stm32_dwmac_resume_wol(struct device *dev, void *bsp_priv)
+{
+	struct stm32_dwmac *dwmac = bsp_priv;
+
+	if (dwmac->ops->resume)
+		dwmac->ops->resume(dwmac);
+}
+
 static int stm32_dwmac_probe(struct platform_device *pdev)
 {
 	struct plat_stmmacenet_data *plat_dat;
@@ -561,6 +577,8 @@ static int stm32_dwmac_probe(struct platform_device *pdev)
 	plat_dat->bsp_priv = dwmac;
 	plat_dat->suspend = stm32_dwmac_suspend;
 	plat_dat->resume = stm32_dwmac_resume;
+	plat_dat->suspend_wol = stm32_dwmac_suspend_wol;
+	plat_dat->resume_wol = stm32_dwmac_resume_wol;
 
 	ret = stm32_dwmac_init(plat_dat);
 	if (ret)
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-tegra.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-tegra.c
index 4ede4420c93b..43d9f6119165 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-tegra.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-tegra.c
@@ -16,6 +16,7 @@ struct tegra_mgbe {
 	struct device *dev;
 
 	struct clk_bulk_data *clks;
+	bool suspended;
 
 	struct reset_control *rst_mac;
 	struct reset_control *rst_pcs;
@@ -54,18 +55,29 @@ struct tegra_mgbe {
 #define MAC_SBD_INTR			BIT(2)
 #define MGBE_WRAP_AXI_ASID0_CTRL	0x8400
 
+static int __maybe_unused tegra_mgbe_resume(struct device *dev);
+
 static int __maybe_unused tegra_mgbe_suspend(struct device *dev)
 {
 	struct tegra_mgbe *mgbe = get_stmmac_bsp_priv(dev);
+	struct stmmac_priv *priv = netdev_priv(dev_get_drvdata(dev));
 	int err;
 
 	err = stmmac_suspend(dev);
 	if (err)
 		return err;
 
+	/* MAC WoL needs the receiver and the register interface kept alive. */
+	if (priv->irq_wake || mgbe->suspended)
+		return 0;
+
 	clk_bulk_disable_unprepare(ARRAY_SIZE(mgbe_clks), mgbe->clks);
+	mgbe->suspended = true;
 
-	return reset_control_assert(mgbe->rst_mac);
+	err = reset_control_assert(mgbe->rst_mac);
+	if (err && tegra_mgbe_resume(dev))
+		dev_err(dev, "failed to restore device after suspend failure\n");
+	return err;
 }
 
 static int __maybe_unused tegra_mgbe_resume(struct device *dev)
@@ -74,13 +86,18 @@ static int __maybe_unused tegra_mgbe_resume(struct device *dev)
 	u32 value;
 	int err;
 
+	if (!mgbe->suspended)
+		return stmmac_resume(dev);
+
 	err = clk_bulk_prepare_enable(ARRAY_SIZE(mgbe_clks), mgbe->clks);
 	if (err < 0)
 		return err;
 
 	err = reset_control_deassert(mgbe->rst_mac);
-	if (err < 0)
+	if (err < 0) {
+		clk_bulk_disable_unprepare(ARRAY_SIZE(mgbe_clks), mgbe->clks);
 		return err;
+	}
 
 	/* Enable common interrupt at wrapper level */
 	writel(MAC_SBD_INTR, mgbe->regs + MGBE_WRAP_COMMON_INTR_ENABLE);
@@ -104,9 +121,11 @@ static int __maybe_unused tegra_mgbe_resume(struct device *dev)
 		return err;
 	}
 
+	mgbe->suspended = false;
 	err = stmmac_resume(dev);
-	if (err < 0)
-		clk_bulk_disable_unprepare(ARRAY_SIZE(mgbe_clks), mgbe->clks);
+	/* Core resume failure retains the suspended datapath for retry or
+	 * close. Keep its register interface powered until that cleanup.
+	 */
 
 	return err;
 }
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c b/drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c
index d4ace3924891..8945d93c6a05 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c
@@ -531,6 +531,10 @@ void dwmac1000_timestamp_interrupt(struct stmmac_priv *priv)
 	/* Clears the timestamp interrupt */
 	ts_status = readl(priv->ptpaddr + GMAC3_X_TIMESTAMP_STATUS);
 
+	/* A blocked PHC still needs its powered interrupt source cleared. */
+	if (READ_ONCE(priv->ptp_blocked))
+		return;
+
 	if (!(priv->plat->flags & STMMAC_FLAG_EXT_SNAPSHOT_EN))
 		return;
 
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac.h b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
index fa01070cbef3..6927afd01175 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac.h
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
@@ -258,6 +258,15 @@ struct stmmac_msi {
 	char int_name_tx_irq[MTL_MAX_TX_QUEUES][IFNAMSIZ + 18];
 };
 
+enum stmmac_datapath_state {
+	/* No IRQs or DMA allocations owned by a successful open. */
+	STMMAC_DATAPATH_DOWN,
+	/* Resources allocated, NAPI enabled. */
+	STMMAC_DATAPATH_RUNNING,
+	/* Resources retained, NAPI and DMA stopped; also after failed resume. */
+	STMMAC_DATAPATH_SUSPENDED,
+};
+
 struct stmmac_priv {
 	/* Frequently used values are kept adjacent for cache effect */
 	u32 tx_coal_frames[MTL_MAX_TX_QUEUES];
@@ -281,6 +290,21 @@ struct stmmac_priv {
 	struct mutex lock;
 
 	struct stmmac_dma_conf *dma_conf;
+	/* IRQ/DMA ownership and NAPI state, serialized by RTNL. */
+	enum stmmac_datapath_state datapath;
+	/* Core sleep sequence completed, independently of datapath ownership. */
+	bool hw_suspended;
+	/* System PM blocks MMIO until power restoration has completed. */
+	bool hw_unavailable;
+	bool bsp_suspended;
+	bool wol_suspended;
+	/* Function-local INTx mask after a failed PCI noirq power restoration. */
+	bool pci_intx_masked;
+	bool bus_clks_suspended;
+	bool ptp_clock_enabled;
+	bool ptp_clock_suspended;
+	/* Clock ownership can also change in noirq PM, without RTNL. */
+	struct mutex pm_mutex;
 
 	/* Generic channel for NAPI */
 	struct stmmac_channel channel[STMMAC_CH_MAX];
@@ -401,10 +425,12 @@ enum stmmac_state {
 };
 
 extern const struct dev_pm_ops stmmac_simple_pm_ops;
+extern const struct dev_pm_ops stmmac_pci_pm_ops;
 
 int stmmac_mdio_unregister(struct net_device *ndev);
 int stmmac_mdio_register(struct net_device *ndev);
 int stmmac_mdio_reset(struct mii_bus *mii);
+int stmmac_resume_clocks(struct stmmac_priv *priv);
 void stmmac_mdio_lock(struct stmmac_priv *priv);
 void stmmac_mdio_unlock(struct stmmac_priv *priv);
 int stmmac_pcs_setup(struct net_device *ndev);
@@ -440,6 +466,13 @@ static inline bool stmmac_xdp_is_enabled(struct stmmac_priv *priv)
 	return !!priv->xdp_prog;
 }
 
+/* RTNL serializes TC callbacks with datapath and power transitions. */
+static inline bool stmmac_tc_active(struct stmmac_priv *priv)
+{
+	return priv->datapath == STMMAC_DATAPATH_RUNNING &&
+	       netif_device_present(priv->dev) && !priv->hw_unavailable;
+}
+
 void stmmac_disable_rx_queue(struct stmmac_priv *priv, u32 queue);
 void stmmac_enable_rx_queue(struct stmmac_priv *priv, u32 queue);
 void stmmac_disable_tx_queue(struct stmmac_priv *priv, u32 queue);
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
index 1fdd63d6bba1..ffbb00bc6fc0 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
@@ -1089,7 +1089,18 @@ static void stmmac_get_mm_stats(struct net_device *ndev,
 	s->MACMergeHoldCount = mmc->mmc_tx_hold_req_cntr;
 }
 
+static int stmmac_ethtool_begin(struct net_device *dev)
+{
+	struct stmmac_priv *priv = netdev_priv(dev);
+
+	/* Close reattaches the netdev so open can retry power restoration.
+	 * Presence alone does not make registers accessible after failed resume.
+	 */
+	return priv->hw_unavailable ? -EHOSTDOWN : 0;
+}
+
 static const struct ethtool_ops stmmac_ethtool_ops = {
+	.begin = stmmac_ethtool_begin,
 	.supported_coalesce_params = ETHTOOL_COALESCE_USECS |
 				     ETHTOOL_COALESCE_MAX_FRAMES,
 	.get_drvinfo = stmmac_ethtool_getdrvinfo,
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_hwtstamp.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_hwtstamp.c
index b9a985fa772c..710bb6ad06d3 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_hwtstamp.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_hwtstamp.c
@@ -220,7 +220,8 @@ static void timestamp_interrupt(struct stmmac_priv *priv)
 	u64 ptp_time;
 	int i;
 
-	if (priv->plat->flags & STMMAC_FLAG_INT_SNAPSHOT_EN) {
+	if (!READ_ONCE(priv->ptp_blocked) &&
+	    (priv->plat->flags & STMMAC_FLAG_INT_SNAPSHOT_EN)) {
 		wake_up(&priv->tstamp_busy_wait);
 		return;
 	}
@@ -235,6 +236,13 @@ static void timestamp_interrupt(struct stmmac_priv *priv)
 	 */
 	ts_status = readl(priv->ioaddr + GMAC_TIMESTAMP_STATUS);
 
+	/* The powered register interface can still signal a level interrupt
+	 * while the PHC is unavailable. Acknowledge it, but do not report an
+	 * event from a clock which is being reset or shut down.
+	 */
+	if (READ_ONCE(priv->ptp_blocked))
+		return;
+
 	if (!(priv->plat->flags & STMMAC_FLAG_EXT_SNAPSHOT_EN))
 		return;
 
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 212bca73b9cf..ad5ed2c95af7 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -39,6 +39,7 @@
 #endif /* CONFIG_DEBUG_FS */
 #include <linux/net_tstamp.h>
 #include <linux/phylink.h>
+#include <linux/pci.h>
 #include <linux/udp.h>
 #include <linux/bpf_trace.h>
 #include <net/devlink.h>
@@ -656,6 +657,9 @@ static int stmmac_hwtstamp_set(struct net_device *dev,
 	u32 ts_master_en = 0;
 	u32 ts_event_en = 0;
 
+	if (priv->hw_unavailable)
+		return -EHOSTDOWN;
+
 	if (!priv->plat->clk_ptp_rate ||
 	    !(priv->dma_cap.time_stamp || priv->adv_ts)) {
 		NL_SET_ERR_MSG_MOD(extack, "No support for HW time stamping");
@@ -961,7 +965,10 @@ static int stmmac_setup_ptp(struct stmmac_priv *priv)
 	priv->ptp_extts = 0;
 	priv->ptp_blocked = false;
 
+	mutex_lock(&priv->pm_mutex);
 	ret = clk_prepare_enable(priv->plat->clk_ptp_ref);
+	priv->ptp_clock_enabled = !ret;
+	mutex_unlock(&priv->pm_mutex);
 	if (ret < 0) {
 		netdev_warn(priv->dev,
 			    "failed to enable PTP reference clock: %pe\n",
@@ -970,20 +977,25 @@ static int stmmac_setup_ptp(struct stmmac_priv *priv)
 	}
 
 	if (stmmac_init_ptp_clk_freq(priv)) {
-		clk_disable_unprepare(priv->plat->clk_ptp_ref);
-		return 0;
+		ret = 0;
+		goto disable_clock;
 	}
 
 	ret = stmmac_init_timestamping(priv);
-	if (ret) {
-		clk_disable_unprepare(priv->plat->clk_ptp_ref);
-		return ret;
-	}
+	if (ret)
+		goto disable_clock;
 
 	stmmac_ptp_register(priv);
 	priv->ptp_enabled = true;
 
 	return 0;
+
+disable_clock:
+	mutex_lock(&priv->pm_mutex);
+	clk_disable_unprepare(priv->plat->clk_ptp_ref);
+	priv->ptp_clock_enabled = false;
+	mutex_unlock(&priv->pm_mutex);
+	return ret;
 }
 
 static void stmmac_release_ptp(struct stmmac_priv *priv)
@@ -992,8 +1004,27 @@ static void stmmac_release_ptp(struct stmmac_priv *priv)
 		return;
 
 	stmmac_ptp_unregister(priv);
-	clk_disable_unprepare(priv->plat->clk_ptp_ref);
 	priv->ptp_enabled = false;
+	mutex_lock(&priv->pm_mutex);
+	if (priv->ptp_clock_enabled) {
+		clk_disable_unprepare(priv->plat->clk_ptp_ref);
+		priv->ptp_clock_enabled = false;
+	}
+	/* A later noirq resume must not reacquire a released reference. */
+	priv->ptp_clock_suspended = false;
+	mutex_unlock(&priv->pm_mutex);
+}
+
+/* ptp_mutex excludes configuration and crosstimestamp operations. The
+ * spinlock also excludes atomic clock reads while changing this gate.
+ */
+static void stmmac_block_ptp(struct stmmac_priv *priv, bool block)
+{
+	unsigned long flags;
+
+	write_lock_irqsave(&priv->ptp_lock, flags);
+	WRITE_ONCE(priv->ptp_blocked, block);
+	write_unlock_irqrestore(&priv->ptp_lock, flags);
 }
 
 static void stmmac_legacy_serdes_power_down(struct stmmac_priv *priv)
@@ -1098,6 +1129,9 @@ static void stmmac_mac_link_down(struct phylink_config *config,
 {
 	struct stmmac_priv *priv = netdev_priv(to_net_dev(config->dev));
 
+	if (READ_ONCE(priv->hw_unavailable))
+		return;
+
 	stmmac_mac_set(priv, priv->ioaddr, false);
 	if (priv->dma_cap.eee)
 		stmmac_set_eee_pls(priv, priv->hw, false);
@@ -1222,10 +1256,12 @@ static void stmmac_mac_disable_tx_lpi(struct phylink_config *config)
 	netdev_dbg(priv->dev, "disable EEE\n");
 	priv->eee_sw_timer_en = false;
 	timer_delete_sync(&priv->eee_ctrl_timer);
-	stmmac_set_lpi_mode(priv, priv->hw, STMMAC_LPI_DISABLE, false, 0);
 	priv->tx_path_in_lpi_mode = false;
 
-	stmmac_set_eee_timer(priv, priv->hw, 0, STMMAC_DEFAULT_TWT_LS);
+	if (!READ_ONCE(priv->hw_unavailable)) {
+		stmmac_set_lpi_mode(priv, priv->hw, STMMAC_LPI_DISABLE, false, 0);
+		stmmac_set_eee_timer(priv, priv->hw, 0, STMMAC_DEFAULT_TWT_LS);
+	}
 	mutex_unlock(&priv->lock);
 }
 
@@ -3849,10 +3885,6 @@ static int stmmac_hw_setup(struct net_device *dev)
 		stmmac_enable_tbs(priv, priv->ioaddr, enable, chan);
 	}
 
-	/* Configure real RX and TX queues */
-	netif_set_real_num_rx_queues(dev, priv->plat->rx_queues_to_use);
-	netif_set_real_num_tx_queues(dev, priv->plat->tx_queues_to_use);
-
 	/* Start the ball rolling... */
 	stmmac_start_all_dma(priv);
 
@@ -4140,6 +4172,16 @@ static int stmmac_request_irq_single(struct net_device *dev)
 	return ret;
 }
 
+static void stmmac_unmask_pci_irq(struct stmmac_priv *priv)
+{
+#ifdef CONFIG_PCI
+	if (priv->pci_intx_masked) {
+		priv->pci_intx_masked = false;
+		pci_intx(to_pci_dev(priv->device), true);
+	}
+#endif
+}
+
 static int stmmac_request_irq(struct net_device *dev)
 {
 	struct stmmac_priv *priv = netdev_priv(dev);
@@ -4151,9 +4193,38 @@ static int stmmac_request_irq(struct net_device *dev)
 	else
 		ret = stmmac_request_irq_single(dev);
 
+	if (!ret)
+		stmmac_unmask_pci_irq(priv);
+
 	return ret;
 }
 
+/* Drain registered handlers without disabling lines shared by other devices. */
+static void stmmac_synchronize_irq(struct stmmac_priv *priv)
+{
+	struct stmmac_msi *msi = priv->msi;
+	int irq = priv->dev->irq;
+	u32 i;
+
+	synchronize_irq(irq);
+	if (priv->wol_irq > 0 && priv->wol_irq != irq)
+		synchronize_irq(priv->wol_irq);
+	if (priv->sfty_irq > 0 && priv->sfty_irq != irq)
+		synchronize_irq(priv->sfty_irq);
+	if (!msi)
+		return;
+	if (msi->sfty_ce_irq > 0 && msi->sfty_ce_irq != irq)
+		synchronize_irq(msi->sfty_ce_irq);
+	if (msi->sfty_ue_irq > 0 && msi->sfty_ue_irq != irq)
+		synchronize_irq(msi->sfty_ue_irq);
+	for (i = 0; i < priv->plat->rx_queues_to_use; i++)
+		if (msi->rx_irq[i] > 0)
+			synchronize_irq(msi->rx_irq[i]);
+	for (i = 0; i < priv->plat->tx_queues_to_use; i++)
+		if (msi->tx_irq[i] > 0)
+			synchronize_irq(msi->tx_irq[i]);
+}
+
 /**
  *  stmmac_setup_dma_desc - Generate a dma_conf and allocate DMA queue
  *  @priv: driver private structure
@@ -4232,6 +4303,97 @@ stmmac_setup_dma_desc(struct stmmac_priv *priv, unsigned int mtu)
 	return ERR_PTR(ret);
 }
 
+/* The freezer excludes pool teardown and userspace from noirq callbacks.
+ * Outside system sleep these flags are changed under RTNL.
+ */
+int stmmac_resume_clocks(struct stmmac_priv *priv)
+{
+	int ret = 0;
+
+	mutex_lock(&priv->pm_mutex);
+	if (priv->bus_clks_suspended) {
+		ret = pm_runtime_force_resume(priv->device);
+		if (ret)
+			goto out;
+		priv->bus_clks_suspended = false;
+	}
+	if (priv->ptp_clock_suspended) {
+		ret = clk_prepare_enable(priv->plat->clk_ptp_ref);
+		if (ret)
+			goto out;
+		priv->ptp_clock_enabled = true;
+		priv->ptp_clock_suspended = false;
+	}
+out:
+	mutex_unlock(&priv->pm_mutex);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(stmmac_resume_clocks);
+
+static int stmmac_resume_power(struct stmmac_priv *priv, bool system_resume)
+{
+	bool pending = priv->bus_clks_suspended || priv->bsp_suspended ||
+		       priv->ptp_clock_suspended;
+	int ret;
+
+	ret = stmmac_resume_clocks(priv);
+	if (ret)
+		return ret;
+	if (priv->wol_suspended) {
+		priv->plat->resume_wol(priv->device, priv->plat->bsp_priv);
+		priv->wol_suspended = false;
+	}
+	if (priv->bsp_suspended && priv->plat->resume) {
+		ret = priv->plat->resume(priv->device, priv->plat->bsp_priv);
+		if (ret)
+			return ret;
+		priv->bsp_suspended = false;
+	}
+	/* A wrapper which powers the device outside these callbacks must
+	 * complete its own resume before core register access is possible.
+	 */
+	if (system_resume || pending)
+		WRITE_ONCE(priv->hw_unavailable, false);
+	return priv->hw_unavailable ? -EHOSTDOWN : 0;
+}
+
+/* Finish core sleep state only after its power dependencies are restored. */
+static int stmmac_resume_hw(struct stmmac_priv *priv)
+{
+	int ret;
+
+	if (!priv->hw_suspended)
+		return 0;
+	if (priv->hw_unavailable)
+		return -EHOSTDOWN;
+
+	/* Use the state installed by suspend, not a subsequently changed WoL
+	 * setting. Clear PMT even when a different device caused the wakeup.
+	 */
+	if (priv->irq_wake) {
+		mutex_lock(&priv->lock);
+		stmmac_pmt(priv, priv->hw, 0);
+		mutex_unlock(&priv->lock);
+		WRITE_ONCE(priv->irq_wake, 0);
+		/* Finish any timestamp handler admitted by the retained wake
+		 * clocks before resume resets the PHC or close unregisters it.
+		 */
+		stmmac_synchronize_irq(priv);
+	} else {
+		ret = pinctrl_pm_select_default_state(priv->device);
+		if (ret)
+			return ret;
+		if (priv->mii) {
+			ret = stmmac_mdio_reset(priv->mii);
+			if (ret)
+				return ret;
+		}
+	}
+	priv->hw_suspended = false;
+
+	return 0;
+}
+
 /**
  *  __stmmac_open - open entry point of the driver
  *  @dev : pointer to the device structure.
@@ -4266,12 +4428,12 @@ static int __stmmac_open(struct net_device *dev,
 	ret = stmmac_hw_setup(dev);
 	if (ret < 0) {
 		netdev_err(priv->dev, "%s: Hw setup failed\n", __func__);
-		return ret;
+		goto init_error;
 	}
 
 	ret = stmmac_setup_ptp(priv);
 	if (ret)
-		goto ptp_error;
+		goto init_error;
 
 	/* The core soft reset in stmmac_hw_setup() clears the MTL_EST
 	 * registers, so re-apply the taprio offload after PTP is up.
@@ -4282,34 +4444,43 @@ static int __stmmac_open(struct net_device *dev,
 
 	stmmac_init_coalesce(priv);
 
-	phylink_start(priv->phylink);
-
 	stmmac_vlan_restore(priv);
 
 	ret = stmmac_request_irq(dev);
 	if (ret)
 		goto irq_error;
 
+	/* Publish the topology only when no other fallible setup remains.
+	 * The combined setter restores the old counts if an increase fails.
+	 */
+	ret = netif_set_real_num_queues(dev, priv->plat->tx_queues_to_use,
+					priv->plat->rx_queues_to_use);
+	if (ret) {
+		stmmac_free_irq(dev, REQ_IRQ_ERR_ALL, 0);
+		goto irq_error;
+	}
+
 	stmmac_enable_all_queues(priv);
 	netif_tx_start_all_queues(priv->dev);
 	stmmac_enable_all_dma_irq(priv);
+	priv->datapath = STMMAC_DATAPATH_RUNNING;
+	phylink_start(priv->phylink);
 
 	return 0;
 
 irq_error:
-	phylink_stop(priv->phylink);
-
-	stmmac_stop_all_dma(priv);
-
 	for (chan = 0; chan < priv->plat->tx_queues_to_use; chan++)
 		hrtimer_cancel(&priv->dma_conf->tx_queue[chan].txtimer);
 
 est_error:
 	stmmac_release_ptp(priv);
-ptp_error:
+init_error:
+	/* Undo phylink_prepare_resume() even if hardware setup failed before
+	 * phylink_start(). Keep the PHY attachment and outer PM ownership.
+	 */
+	phylink_stop(priv->phylink);
 	stmmac_stop_all_dma(priv);
 	stmmac_mac_set(priv, priv->ioaddr, false);
-
 	return ret;
 }
 
@@ -4332,6 +4503,13 @@ static int stmmac_open(struct net_device *dev)
 	if (ret < 0)
 		goto err_dma_resources;
 
+	ret = stmmac_resume_power(priv, false);
+	if (ret)
+		goto err_runtime_pm;
+	ret = stmmac_resume_hw(priv);
+	if (ret)
+		goto err_runtime_pm;
+
 	ret = stmmac_init_phy(dev);
 	if (ret)
 		goto err_runtime_pm;
@@ -4395,23 +4573,36 @@ static void __stmmac_release(struct net_device *dev)
 {
 	struct stmmac_priv *priv = netdev_priv(dev);
 
+	/* A failed MTU reopen has already released the data path. */
+	if (priv->datapath == STMMAC_DATAPATH_DOWN)
+		return;
+
 	phylink_stop(priv->phylink);
-	stmmac_quiesce(priv);
+
+	/* Suspend retains the resources, but has already stopped activity. */
+	if (priv->datapath == STMMAC_DATAPATH_RUNNING)
+		stmmac_quiesce(priv);
+	priv->datapath = STMMAC_DATAPATH_DOWN;
 
 	/* Free the IRQ lines */
 	stmmac_free_irq(dev, REQ_IRQ_ERR_ALL, 0);
+
 	/* TX error IRQs can restart a queue after the first quiescence. */
 	stmmac_stop_tx_queues(priv);
 
-	/* Stop TX/RX DMA and clear the descriptors */
-	stmmac_stop_all_dma(priv);
+	/* Stop TX/RX DMA after draining IRQ handlers which can restart it. */
+	if (!priv->hw_unavailable) {
+		stmmac_stop_all_dma(priv);
+		/* Link resolution need not have reached mac_link_up() yet. */
+		stmmac_mac_set(priv, priv->ioaddr, false);
+	}
 
 	/* Release and free the Rx/Tx resources */
 	free_dma_desc_resources(priv, priv->dma_conf);
 
 	stmmac_release_ptp(priv);
 
-	if (stmmac_fpe_supported(priv))
+	if (!priv->hw_unavailable && stmmac_fpe_supported(priv))
 		ethtool_mmsv_stop(&priv->fpe_cfg.mmsv);
 }
 
@@ -4424,6 +4615,17 @@ static void __stmmac_release(struct net_device *dev)
 static int stmmac_release(struct net_device *dev)
 {
 	struct stmmac_priv *priv = netdev_priv(dev);
+	int ret;
+
+	/* Resume may have failed before restoring pins or disabling MAC wake.
+	 * Complete that cleanup without restarting the link or the datapath.
+	 * If it fails, keep hw_suspended set so a fresh open can retry it.
+	 */
+	ret = stmmac_resume_power(priv, false);
+	if (!ret)
+		ret = stmmac_resume_hw(priv);
+	if (ret)
+		netdev_err(dev, "failed to restore hardware sleep state: %d\n", ret);
 
 	/* If the PHY or MAC has WoL enabled, then the PHY will not be
 	 * suspended when phylink_stop() is called below. Set the PHY
@@ -4437,6 +4639,8 @@ static int stmmac_release(struct net_device *dev)
 	stmmac_legacy_serdes_power_down(priv);
 	phylink_disconnect_phy(priv->phylink);
 	pm_runtime_put(priv->device);
+	/* Allow a fresh open after a failed MTU reopen or resume. */
+	netif_device_attach(dev);
 
 	return 0;
 }
@@ -6266,6 +6470,9 @@ static void stmmac_set_rx_mode(struct net_device *dev)
 {
 	struct stmmac_priv *priv = netdev_priv(dev);
 
+	if (READ_ONCE(priv->hw_unavailable))
+		return;
+
 	stmmac_set_filter(priv, priv->hw, dev);
 }
 
@@ -6328,6 +6535,11 @@ static int stmmac_change_mtu(struct net_device *dev, int new_mtu)
 			priv->dma_conf = old_conf;
 			free_dma_desc_resources(priv, dma_conf);
 			kfree(dma_conf);
+			/*
+			 * Keep the administrative state and PHY/PM ownership until
+			 * ndo_stop(), but prevent use of the released data path.
+			 */
+			netif_device_detach(dev);
 			netdev_err(priv->dev, "failed reopening the interface after MTU change\n");
 			return ret;
 		}
@@ -6371,6 +6583,9 @@ static int stmmac_set_features(struct net_device *netdev,
 {
 	struct stmmac_priv *priv = netdev_priv(netdev);
 
+	if (priv->hw_unavailable)
+		return -EHOSTDOWN;
+
 	/* Keep the COE Type in case of csum is supporting */
 	if (features & NETIF_F_RXCSUM)
 		priv->hw->rx_csum = priv->plat->rx_coe;
@@ -6412,7 +6627,7 @@ static void stmmac_common_interrupt(struct stmmac_priv *priv)
 	xmac = dwmac_is_xmac(priv->plat->core_type);
 	queues_count = (rx_cnt > tx_cnt) ? rx_cnt : tx_cnt;
 
-	if (priv->irq_wake)
+	if (READ_ONCE(priv->irq_wake))
 		pm_wakeup_event(priv->device, 0);
 
 	if (priv->dma_cap.estsel)
@@ -6437,8 +6652,10 @@ static void stmmac_common_interrupt(struct stmmac_priv *priv)
 		for (queue = 0; queue < queues_count; queue++)
 			stmmac_host_mtl_irq_status(priv, priv->hw, queue);
 
-		if (!READ_ONCE(priv->ptp_blocked))
-			stmmac_timestamp_interrupt(priv, priv);
+		/* Powered handlers must acknowledge timestamp sources even while
+		 * PHC access is blocked. The callback then skips event delivery.
+		 */
+		stmmac_timestamp_interrupt(priv, priv);
 	}
 }
 
@@ -6458,6 +6675,12 @@ static irqreturn_t stmmac_interrupt(int irq, void *dev_id)
 	struct net_device *dev = (struct net_device *)dev_id;
 	struct stmmac_priv *priv = netdev_priv(dev);
 
+	if (READ_ONCE(priv->hw_unavailable)) {
+		if (priv->irq_wake)
+			pm_wakeup_event(priv->device, 0);
+		return IRQ_NONE;
+	}
+
 	/* Check if adapter is up */
 	if (test_bit(STMMAC_DOWN, &priv->state))
 		return IRQ_HANDLED;
@@ -6480,6 +6703,12 @@ static irqreturn_t stmmac_mac_interrupt(int irq, void *dev_id)
 	struct net_device *dev = (struct net_device *)dev_id;
 	struct stmmac_priv *priv = netdev_priv(dev);
 
+	if (READ_ONCE(priv->hw_unavailable)) {
+		if (priv->irq_wake)
+			pm_wakeup_event(priv->device, 0);
+		return IRQ_NONE;
+	}
+
 	/* Check if adapter is up */
 	if (test_bit(STMMAC_DOWN, &priv->state))
 		return IRQ_HANDLED;
@@ -6495,6 +6724,9 @@ static irqreturn_t stmmac_safety_interrupt(int irq, void *dev_id)
 	struct net_device *dev = (struct net_device *)dev_id;
 	struct stmmac_priv *priv = netdev_priv(dev);
 
+	if (READ_ONCE(priv->hw_unavailable))
+		return IRQ_NONE;
+
 	/* Check if adapter is up */
 	if (test_bit(STMMAC_DOWN, &priv->state))
 		return IRQ_HANDLED;
@@ -6512,6 +6744,9 @@ static irqreturn_t stmmac_msi_intr_tx(int irq, void *data)
 	int chan = ch->index;
 	int status;
 
+	if (READ_ONCE(priv->hw_unavailable))
+		return IRQ_NONE;
+
 	/* Check if adapter is up */
 	if (test_bit(STMMAC_DOWN, &priv->state))
 		return IRQ_HANDLED;
@@ -6534,6 +6769,9 @@ static irqreturn_t stmmac_msi_intr_rx(int irq, void *data)
 	struct stmmac_priv *priv = ch->priv_data;
 	int chan = ch->index;
 
+	if (READ_ONCE(priv->hw_unavailable))
+		return IRQ_NONE;
+
 	/* Check if adapter is up */
 	if (test_bit(STMMAC_DOWN, &priv->state))
 		return IRQ_HANDLED;
@@ -6565,13 +6803,40 @@ static int stmmac_ioctl(struct net_device *dev, struct ifreq *rq, int cmd)
 static int stmmac_setup_tc_block_cb(enum tc_setup_type type, void *type_data,
 				    void *cb_priv)
 {
+	struct flow_cls_common_offload *common = type_data;
 	struct stmmac_priv *priv = cb_priv;
+	bool active = stmmac_tc_active(priv);
 	int ret = -EOPNOTSUPP;
+	bool destroy;
 
-	if (!tc_cls_can_offload_and_chain0(priv->dev, type_data))
+	switch (type) {
+	case TC_SETUP_CLSU32:
+		destroy = ((struct tc_cls_u32_offload *)type_data)->command ==
+			  TC_CLSU32_DELETE_KNODE;
+		break;
+	case TC_SETUP_CLSFLOWER:
+		destroy = ((struct flow_cls_offload *)type_data)->command ==
+			  FLOW_CLS_DESTROY;
+		break;
+	default:
 		return ret;
+	}
 
-	__stmmac_disable_all_queues(priv);
+	if (common->chain_index) {
+		NL_SET_ERR_MSG(common->extack, "Driver supports only offload of chain 0");
+		return ret;
+	}
+	if (!destroy && !tc_can_offload_extack(priv->dev, common->extack))
+		return ret;
+	if (!destroy && !active)
+		return -ENETDOWN;
+
+	/* TC discards deleted filters regardless of the callback result. Clear
+	 * their cached state even while down or detached, without touching NAPI
+	 * or inaccessible registers. Recovery must not replay deleted rules.
+	 */
+	if (active)
+		__stmmac_disable_all_queues(priv);
 
 	switch (type) {
 	case TC_SETUP_CLSU32:
@@ -6584,7 +6849,8 @@ static int stmmac_setup_tc_block_cb(enum tc_setup_type type, void *type_data,
 		break;
 	}
 
-	stmmac_enable_all_queues(priv);
+	if (active)
+		stmmac_enable_all_queues(priv);
 	return ret;
 }
 
@@ -6621,6 +6887,9 @@ static int stmmac_set_mac_address(struct net_device *ndev, void *addr)
 	struct stmmac_priv *priv = netdev_priv(ndev);
 	int ret = 0;
 
+	if (priv->hw_unavailable)
+		return -EHOSTDOWN;
+
 	ret = pm_runtime_resume_and_get(priv->device);
 	if (ret < 0)
 		return ret;
@@ -6672,8 +6941,9 @@ static int stmmac_rings_status_show(struct seq_file *seq, void *v)
 	u8 rx_count, tx_count, queue;
 
 	rtnl_lock();
-	if ((dev->flags & IFF_UP) == 0)
+	if (priv->datapath == STMMAC_DATAPATH_DOWN)
 		goto out_unlock;
+
 	rx_count = priv->plat->rx_queues_to_use;
 	tx_count = priv->plat->tx_queues_to_use;
 
@@ -6999,7 +7269,7 @@ static int stmmac_vlan_update(struct stmmac_priv *priv, bool is_double)
 		hash = 0;
 	}
 
-	if (!netif_running(priv->dev))
+	if (!netif_running(priv->dev) || priv->hw_unavailable)
 		return 0;
 
 	return stmmac_update_vlan_hash(priv, priv->hw, hash, pmatch, is_double);
@@ -7015,6 +7285,9 @@ static int stmmac_vlan_rx_add_vid(struct net_device *ndev, __be16 proto, u16 vid
 	bool is_double = false;
 	int ret;
 
+	if (priv->hw_unavailable)
+		return -EHOSTDOWN;
+
 	ret = pm_runtime_resume_and_get(priv->device);
 	if (ret < 0)
 		return ret;
@@ -7057,9 +7330,12 @@ static int stmmac_vlan_rx_kill_vid(struct net_device *ndev, __be16 proto, u16 vi
 	bool is_double = false;
 	int ret;
 
-	ret = pm_runtime_resume_and_get(priv->device);
-	if (ret < 0)
-		return ret;
+	/* Removal must update the cached filters even if power cannot return. */
+	if (!priv->hw_unavailable) {
+		ret = pm_runtime_resume_and_get(priv->device);
+		if (ret < 0)
+			return ret;
+	}
 
 	if (be16_to_cpu(proto) == ETH_P_8021AD)
 		is_double = true;
@@ -7084,7 +7360,8 @@ static int stmmac_vlan_rx_kill_vid(struct net_device *ndev, __be16 proto, u16 vi
 	priv->num_double_vlans = num_double_vlans;
 
 del_vlan_error:
-	pm_runtime_put(priv->device);
+	if (!priv->hw_unavailable)
+		pm_runtime_put(priv->device);
 
 	return ret;
 }
@@ -7104,6 +7381,18 @@ static int stmmac_bpf(struct net_device *dev, struct netdev_bpf *bpf)
 {
 	struct stmmac_priv *priv = netdev_priv(dev);
 
+	if (bpf->command != XDP_SETUP_PROG &&
+	    bpf->command != XDP_SETUP_XSK_POOL)
+		return -EOPNOTSUPP;
+
+	/*
+	 * Pool removal must succeed even after a failed resume. Release the
+	 * suspended rings before their pool or XDP buffer layout can change.
+	 * Leave the interface detached until it is closed and reopened.
+	 */
+	if (priv->datapath == STMMAC_DATAPATH_SUSPENDED)
+		__stmmac_release(dev);
+
 	switch (bpf->command) {
 	case XDP_SETUP_PROG:
 		return stmmac_xdp_set_prog(priv, bpf->prog, bpf->extack);
@@ -7266,7 +7555,13 @@ void stmmac_xdp_release(struct net_device *dev)
 {
 	struct stmmac_priv *priv = netdev_priv(dev);
 
+	netif_device_detach(dev);
+	/* Pause MAC/PCS resolution, but keep the PHY and negotiation running.
+	 * stmmac_xdp_open() completes this replay under the same RTNL lock.
+	 */
+	phylink_replay_link_begin(priv->phylink);
 	stmmac_quiesce(priv);
+	priv->datapath = STMMAC_DATAPATH_DOWN;
 
 	/* Free the IRQ lines */
 	stmmac_free_irq(dev, REQ_IRQ_ERR_ALL, 0);
@@ -7285,7 +7580,13 @@ void stmmac_xdp_release(struct net_device *dev)
 	 * watchdogs during reset
 	 */
 	netif_trans_update(dev);
-	netif_carrier_off(dev);
+
+	if (stmmac_fpe_supported(priv))
+		ethtool_mmsv_stop(&priv->fpe_cfg.mmsv);
+
+	/* Keep PTP across the immediately following stmmac_xdp_open(). That
+	 * function releases it if reopening fails, before returning DOWN.
+	 */
 }
 
 int stmmac_xdp_open(struct net_device *dev)
@@ -7364,21 +7665,25 @@ int stmmac_xdp_open(struct net_device *dev)
 
 	/* Enable NAPI process*/
 	stmmac_enable_all_queues(priv);
-	netif_carrier_on(dev);
-	netif_tx_start_all_queues(dev);
 	stmmac_enable_all_dma_irq(priv);
+	priv->datapath = STMMAC_DATAPATH_RUNNING;
+	phylink_replay_link_end(priv->phylink);
+	netif_device_attach(dev);
 
 	return 0;
 
 irq_error:
+	stmmac_stop_tx_queues(priv);
 	stmmac_stop_all_dma(priv);
-
-	for (chan = 0; chan < priv->plat->tx_queues_to_use; chan++)
-		hrtimer_cancel(&priv->dma_conf->tx_queue[chan].txtimer);
+	stmmac_mac_set(priv, priv->ioaddr, false);
 
 init_error:
 	free_dma_desc_resources(priv, priv->dma_conf);
 dma_desc_error:
+	/* STOPPED keeps replay_end() from reconfiguring a failed MAC. */
+	phylink_stop(priv->phylink);
+	phylink_replay_link_end(priv->phylink);
+	stmmac_release_ptp(priv);
 	return ret;
 }
 
@@ -7500,6 +7805,9 @@ static void stmmac_reset_subtask(struct stmmac_priv *priv)
 	netdev_err(priv->dev, "Reset adapter.\n");
 
 	rtnl_lock();
+	if (!netif_device_present(priv->dev))
+		goto out_unlock;
+
 	netif_trans_update(priv->dev);
 	while (test_and_set_bit(STMMAC_RESETING, &priv->state))
 		usleep_range(1000, 2000);
@@ -7509,6 +7817,7 @@ static void stmmac_reset_subtask(struct stmmac_priv *priv)
 	dev_open(priv->dev, NULL);
 	clear_bit(STMMAC_DOWN, &priv->state);
 	clear_bit(STMMAC_RESETING, &priv->state);
+out_unlock:
 	rtnl_unlock();
 }
 
@@ -7780,13 +8089,37 @@ static void stmmac_napi_del(struct net_device *dev)
 	}
 }
 
-int stmmac_reinit_queues(struct net_device *dev, u8 rx_cnt, u8 tx_cnt)
+/* Rebuild only the datapath. The administratively-up device still owns its
+ * PHY attachment and runtime-PM reference, even if this reopen fails.
+ */
+static int stmmac_reopen(struct net_device *dev)
 {
 	struct stmmac_priv *priv = netdev_priv(dev);
-	int ret = 0, i;
+	struct stmmac_dma_conf *old_conf = priv->dma_conf;
+	struct stmmac_dma_conf *dma_conf;
+	int ret;
 
-	if (netif_running(dev))
-		stmmac_release(dev);
+	dma_conf = stmmac_setup_dma_desc(priv, dev->mtu);
+	if (IS_ERR(dma_conf))
+		return PTR_ERR(dma_conf);
+
+	ret = __stmmac_open(dev, dma_conf);
+	if (ret) {
+		priv->dma_conf = old_conf;
+		free_dma_desc_resources(priv, dma_conf);
+		kfree(dma_conf);
+		return ret;
+	}
+
+	kfree(old_conf);
+	netif_device_attach(dev);
+	return 0;
+}
+
+static void stmmac_set_queues(struct net_device *dev, u8 rx_cnt, u8 tx_cnt)
+{
+	struct stmmac_priv *priv = netdev_priv(dev);
+	int i;
 
 	stmmac_napi_del(dev);
 
@@ -7798,9 +8131,31 @@ int stmmac_reinit_queues(struct net_device *dev, u8 rx_cnt, u8 tx_cnt)
 									rx_cnt);
 
 	stmmac_napi_add(dev);
+}
+
+int stmmac_reinit_queues(struct net_device *dev, u8 rx_cnt, u8 tx_cnt)
+{
+	struct stmmac_priv *priv = netdev_priv(dev);
+	u8 old_rx = priv->plat->rx_queues_to_use;
+	u8 old_tx = priv->plat->tx_queues_to_use;
+	int ret = 0;
+
+	if (netif_running(dev)) {
+		if (!netif_device_present(dev))
+			return -ENETDOWN;
+		netif_device_detach(dev);
+		__stmmac_release(dev);
+	}
+
+	stmmac_set_queues(dev, rx_cnt, tx_cnt);
 
 	if (netif_running(dev))
-		ret = stmmac_open(dev);
+		ret = stmmac_reopen(dev);
+	if (ret) {
+		stmmac_set_queues(dev, old_rx, old_tx);
+		netdev_err(dev, "failed reopening after channel change: %pe; interface remains detached\n",
+			   ERR_PTR(ret));
+	}
 
 	return ret;
 }
@@ -7808,16 +8163,28 @@ int stmmac_reinit_queues(struct net_device *dev, u8 rx_cnt, u8 tx_cnt)
 int stmmac_reinit_ringparam(struct net_device *dev, u32 rx_size, u32 tx_size)
 {
 	struct stmmac_priv *priv = netdev_priv(dev);
+	u32 old_rx = priv->dma_conf->dma_rx_size;
+	u32 old_tx = priv->dma_conf->dma_tx_size;
 	int ret = 0;
 
-	if (netif_running(dev))
-		stmmac_release(dev);
+	if (netif_running(dev)) {
+		if (!netif_device_present(dev))
+			return -ENETDOWN;
+		netif_device_detach(dev);
+		__stmmac_release(dev);
+	}
 
 	priv->dma_conf->dma_rx_size = rx_size;
 	priv->dma_conf->dma_tx_size = tx_size;
 
 	if (netif_running(dev))
-		ret = stmmac_open(dev);
+		ret = stmmac_reopen(dev);
+	if (ret) {
+		priv->dma_conf->dma_rx_size = old_rx;
+		priv->dma_conf->dma_tx_size = old_tx;
+		netdev_err(dev, "failed reopening after ring change: %pe; interface remains detached\n",
+			   ERR_PTR(ret));
+	}
 
 	return ret;
 }
@@ -8234,6 +8601,7 @@ static int __stmmac_dvr_probe(struct device *device,
 
 	mutex_init(&priv->lock);
 	mutex_init(&priv->est_lock);
+	mutex_init(&priv->pm_mutex);
 	rwlock_init(&priv->ptp_lock);
 	mutex_init(&priv->ptp_mutex);
 
@@ -8379,41 +8747,71 @@ void stmmac_dvr_remove(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(stmmac_dvr_remove);
 
+static void stmmac_block_mmio(struct stmmac_priv *priv)
+{
+	/* Drain MDIO transactions and receive-filter updates before removing
+	 * register power. Both paths can run independently of RTNL.
+	 */
+	if (priv->mii)
+		mutex_lock(&priv->mii->mdio_lock);
+	netif_addr_lock_bh(priv->dev);
+	WRITE_ONCE(priv->hw_unavailable, true);
+	netif_addr_unlock_bh(priv->dev);
+	if (priv->mii)
+		mutex_unlock(&priv->mii->mdio_lock);
+}
+
 /**
- * stmmac_suspend - suspend callback
+ * __stmmac_suspend - suspend callback
  * @dev: device pointer
- * Description: this is the function to suspend the device and it is called
- * by the platform driver to stop the network queue, release the resources,
- * program the PMT register (for WoL), clean and release driver resources.
+ * @bsp_noirq: defer PCI power removal until IRQ handlers are suspended
+ * Description: stop network activity and program hardware for system sleep,
+ * preserving any datapath resources still owned for resume or close.
  */
-int stmmac_suspend(struct device *dev)
+static int __stmmac_suspend(struct device *dev, bool bsp_noirq)
 {
 	struct net_device *ndev = dev_get_drvdata(dev);
 	struct stmmac_priv *priv = netdev_priv(ndev);
+	bool accessible;
+	int ret = 0;
 
-	if (!ndev || !netif_running(ndev))
+	rtnl_lock();
+	if (!netif_running(ndev))
+		goto suspend_bsp;
+
+	/* A failed datapath cannot provide a working MAC wake path. It may
+	 * even have released its wake IRQ. Do not silently suspend without WoL.
+	 */
+	if (priv->wolopts && priv->datapath != STMMAC_DATAPATH_RUNNING) {
+		netdev_err(ndev, "cannot suspend failed datapath with MAC WoL enabled\n");
+		rtnl_unlock();
+		return -EBUSY;
+	}
+	if (priv->hw_suspended)
 		goto suspend_bsp;
 
 	mutex_lock(&priv->lock);
 
 	netif_device_detach(ndev);
 
-	stmmac_quiesce(priv);
+	if (priv->datapath == STMMAC_DATAPATH_RUNNING)
+		stmmac_quiesce(priv);
 
 	if (priv->eee_sw_timer_en) {
 		priv->tx_path_in_lpi_mode = false;
 		timer_delete_sync(&priv->eee_ctrl_timer);
 	}
 
-	/* Stop TX/RX DMA */
 	stmmac_stop_all_dma(priv);
 
-	stmmac_legacy_serdes_power_down(priv);
+	if (!priv->wolopts)
+		stmmac_legacy_serdes_power_down(priv);
 
 	/* Enable Power down mode by programming the PMT regs */
 	if (priv->wolopts) {
+		/* An interrupt can arrive as soon as PMT is armed. */
+		WRITE_ONCE(priv->irq_wake, 1);
 		stmmac_pmt(priv, priv->hw, priv->wolopts);
-		priv->irq_wake = 1;
 	} else {
 		stmmac_mac_set(priv, priv->ioaddr, false);
 		pinctrl_pm_select_sleep_state(priv->device);
@@ -8421,18 +8819,58 @@ int stmmac_suspend(struct device *dev)
 
 	mutex_unlock(&priv->lock);
 
-	rtnl_lock();
 	phylink_suspend(priv->phylink, !!priv->wolopts);
-	rtnl_unlock();
+	if (priv->datapath == STMMAC_DATAPATH_RUNNING)
+		priv->datapath = STMMAC_DATAPATH_SUSPENDED;
+	priv->hw_suspended = true;
 
 	if (stmmac_fpe_supported(priv))
 		ethtool_mmsv_stop(&priv->fpe_cfg.mmsv);
 
 suspend_bsp:
-	if (priv->plat->suspend)
-		return priv->plat->suspend(dev, priv->plat->bsp_priv);
+	accessible = !priv->hw_unavailable;
+	mutex_lock(&priv->ptp_mutex);
+	stmmac_block_ptp(priv, true);
+	mutex_unlock(&priv->ptp_mutex);
+	/* A level PMT interrupt must remain serviceable before suspend_noirq
+	 * and after resume_noirq. Platform MAC WoL retains power; PCI defers
+	 * its power transition to the noirq callbacks instead.
+	 */
+	if (!priv->irq_wake)
+		stmmac_block_mmio(priv);
+	if (priv->datapath == STMMAC_DATAPATH_SUSPENDED) {
+		stmmac_synchronize_irq(priv);
+		stmmac_stop_tx_queues(priv);
+		if (accessible)
+			stmmac_stop_all_dma(priv);
+	}
+	if (bsp_noirq)
+		goto out_unlock;
+	if (priv->irq_wake) {
+		if (priv->plat->suspend_wol && !priv->wol_suspended) {
+			ret = priv->plat->suspend_wol(dev, priv->plat->bsp_priv);
+			if (!ret)
+				priv->wol_suspended = true;
+		}
+	} else if (priv->plat->suspend && !priv->bsp_suspended) {
+		priv->bsp_suspended = true;
+		ret = priv->plat->suspend(dev, priv->plat->bsp_priv);
+	}
+out_unlock:
+	rtnl_unlock();
 
-	return 0;
+	/* The PM core will not resume a device whose suspend callback failed.
+	 * A failed rollback remains detached for ordinary down/up recovery.
+	 */
+	if (ret && stmmac_resume(dev))
+		netdev_err(ndev, "failed to restore device after suspend failure\n");
+
+	return ret;
+}
+
+int stmmac_suspend(struct device *dev)
+{
+	return __stmmac_suspend(dev, false);
 }
 EXPORT_SYMBOL_GPL(stmmac_suspend);
 
@@ -8484,41 +8922,39 @@ int stmmac_resume(struct device *dev)
 	struct stmmac_priv *priv = netdev_priv(ndev);
 	int ret;
 
-	if (priv->plat->resume) {
-		ret = priv->plat->resume(dev, priv->plat->bsp_priv);
-		if (ret)
-			return ret;
+	rtnl_lock();
+	ret = stmmac_resume_power(priv, true);
+	if (ret)
+		goto out_unlock;
+
+	if (!netif_running(ndev)) {
+		ret = 0;
+		goto out_unlock;
 	}
 
-	if (!netif_running(ndev))
-		return 0;
+	if (priv->hw_suspended) {
+		ret = stmmac_resume_hw(priv);
+		if (ret)
+			goto out_unlock;
 
-	/* Power Down bit, into the PM register, is cleared
-	 * automatically as soon as a magic packet or a Wake-up frame
-	 * is received. Anyway, it's better to manually clear
-	 * this bit because it can generate problems while resuming
-	 * from another devices (e.g. serial console).
-	 */
-	if (priv->wolopts) {
-		mutex_lock(&priv->lock);
-		stmmac_pmt(priv, priv->hw, 0);
-		mutex_unlock(&priv->lock);
-		priv->irq_wake = 0;
-	} else {
-		pinctrl_pm_select_default_state(priv->device);
-		/* reset the phy so that it's ready */
-		if (priv->mii)
-			stmmac_mdio_reset(priv->mii);
+		/* Terminate PM speed control without restarting a datapath
+		 * whose IRQs or rings were released before system sleep.
+		 */
+		if (priv->datapath != STMMAC_DATAPATH_SUSPENDED)
+			phylink_stop(priv->phylink);
+	}
+
+	if (priv->datapath != STMMAC_DATAPATH_SUSPENDED) {
+		ret = 0;
+		goto out_unlock;
 	}
 
 	if (!(priv->plat->flags & STMMAC_FLAG_SERDES_UP_AFTER_PHY_LINKUP)) {
 		ret = stmmac_legacy_serdes_power_up(priv);
 		if (ret < 0)
-			return ret;
+			goto out_unlock;
 	}
 
-	rtnl_lock();
-
 	/* Prepare the PHY to resume, ensuring that its clocks which are
 	 * necessary for the MAC DMA reset to complete are running
 	 */
@@ -8534,7 +8970,7 @@ int stmmac_resume(struct device *dev)
 	ret = stmmac_hw_setup(ndev);
 	if (ret < 0) {
 		netdev_err(priv->dev, "%s: Hw setup failed\n", __func__);
-		goto error_unlock;
+		goto error_stop_dma;
 	}
 
 	if (priv->ptp_enabled) {
@@ -8547,6 +8983,9 @@ int stmmac_resume(struct device *dev)
 	}
 
 init_coalesce:
+	mutex_lock(&priv->ptp_mutex);
+	stmmac_block_ptp(priv, false);
+	mutex_unlock(&priv->ptp_mutex);
 	ret = stmmac_setup_est(priv);
 	if (ret < 0)
 		goto error_stop_dma;
@@ -8560,6 +8999,7 @@ int stmmac_resume(struct device *dev)
 
 	stmmac_enable_all_queues(priv);
 	stmmac_enable_all_dma_irq(priv);
+	stmmac_unmask_pci_irq(priv);
 
 	mutex_unlock(&priv->lock);
 
@@ -8568,18 +9008,25 @@ int stmmac_resume(struct device *dev)
 	 * workqueue thread, which will race with initialisation.
 	 */
 	phylink_resume(priv->phylink);
-	rtnl_unlock();
-
+	priv->datapath = STMMAC_DATAPATH_RUNNING;
 	netif_device_attach(ndev);
+	rtnl_unlock();
 
 	return 0;
 
 error_stop_dma:
+	mutex_lock(&priv->ptp_mutex);
+	stmmac_block_ptp(priv, true);
+	mutex_unlock(&priv->ptp_mutex);
 	stmmac_stop_all_dma(priv);
 	stmmac_mac_set(priv, priv->ioaddr, false);
-error_unlock:
 	stmmac_legacy_serdes_power_down(priv);
 	mutex_unlock(&priv->lock);
+	/*
+	 * Keep the suspended data path detached. A later resume may retry, or
+	 * ndo_stop() can release its resources without disabling NAPI again.
+	 */
+out_unlock:
 	rtnl_unlock();
 
 	return ret;
@@ -8590,6 +9037,62 @@ EXPORT_SYMBOL_GPL(stmmac_resume);
 DEFINE_SIMPLE_DEV_PM_OPS(stmmac_simple_pm_ops, stmmac_suspend, stmmac_resume);
 EXPORT_SYMBOL_GPL(stmmac_simple_pm_ops);
 
+/* PCI config-space power transitions do not need device IRQ handlers. Keep
+ * them inside the noirq window, including PME-based WoL from D3, so the MAC
+ * interrupt can always be acknowledged whenever its handler can run.
+ */
+static int __maybe_unused stmmac_pci_suspend(struct device *dev)
+{
+	return __stmmac_suspend(dev, true);
+}
+
+static int __maybe_unused stmmac_pci_suspend_noirq(struct device *dev)
+{
+	struct stmmac_priv *priv = netdev_priv(dev_get_drvdata(dev));
+	bool unavailable = priv->hw_unavailable;
+	int ret = 0;
+
+	stmmac_block_mmio(priv);
+	if (priv->plat->suspend && !priv->bsp_suspended) {
+		ret = priv->plat->suspend(dev, priv->plat->bsp_priv);
+		if (!ret)
+			priv->bsp_suspended = true;
+		else
+			WRITE_ONCE(priv->hw_unavailable, unavailable);
+	}
+	return ret;
+}
+
+static int __maybe_unused stmmac_pci_resume_noirq(struct device *dev)
+{
+	struct stmmac_priv *priv = netdev_priv(dev_get_drvdata(dev));
+	int ret;
+
+	ret = stmmac_resume_power(priv, true);
+#ifdef CONFIG_PCI
+	if (ret || priv->pci_intx_masked) {
+		struct pci_dev *pdev = to_pci_dev(dev);
+
+		/* Failed restoration must not expose a level PMT interrupt whose
+		 * registers cannot be acknowledged. Mask only this PCI function,
+		 * not the shared controller line, until the datapath recovers.
+		 * MSI/MSI-X are message interrupts, not asserted level lines.
+		 */
+		if (!pdev->msi_enabled && !pdev->msix_enabled) {
+			pci_intx(pdev, false);
+			priv->pci_intx_masked = true;
+		}
+	}
+#endif
+	return ret;
+}
+
+const struct dev_pm_ops stmmac_pci_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(stmmac_pci_suspend, stmmac_resume)
+	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(stmmac_pci_suspend_noirq, stmmac_pci_resume_noirq)
+};
+EXPORT_SYMBOL_GPL(stmmac_pci_pm_ops);
+
 #ifndef MODULE
 static int __init stmmac_cmdline_opt(char *str)
 {
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
index 63287ad9652f..092b244aa04c 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
@@ -135,6 +135,9 @@ static int stmmac_xgmac2_mdio_read_c22(struct mii_bus *bus, int phyaddr,
 	struct stmmac_priv *priv = netdev_priv(bus->priv);
 	u32 addr;
 
+	if (READ_ONCE(priv->hw_unavailable))
+		return -EHOSTDOWN;
+
 	/* Until ver 2.20 XGMAC does not support C22 addr >= 4 */
 	if (priv->synopsys_id < DWXGMAC_CORE_2_20 &&
 	    phyaddr > MII_XGMAC_MAX_C22ADDR)
@@ -151,6 +154,9 @@ static int stmmac_xgmac2_mdio_read_c45(struct mii_bus *bus, int phyaddr,
 	struct stmmac_priv *priv = netdev_priv(bus->priv);
 	u32 addr;
 
+	if (READ_ONCE(priv->hw_unavailable))
+		return -EHOSTDOWN;
+
 	stmmac_xgmac2_c45_format(priv, phyaddr, devad, phyreg, &addr);
 
 	return stmmac_xgmac2_mdio_read(priv, addr, MII_XGMAC_BUSY);
@@ -198,6 +204,9 @@ static int stmmac_xgmac2_mdio_write_c22(struct mii_bus *bus, int phyaddr,
 	struct stmmac_priv *priv = netdev_priv(bus->priv);
 	u32 addr;
 
+	if (READ_ONCE(priv->hw_unavailable))
+		return -EHOSTDOWN;
+
 	/* Until ver 2.20 XGMAC does not support C22 addr >= 4 */
 	if (priv->synopsys_id < DWXGMAC_CORE_2_20 &&
 	    phyaddr > MII_XGMAC_MAX_C22ADDR)
@@ -215,6 +224,9 @@ static int stmmac_xgmac2_mdio_write_c45(struct mii_bus *bus, int phyaddr,
 	struct stmmac_priv *priv = netdev_priv(bus->priv);
 	u32 addr;
 
+	if (READ_ONCE(priv->hw_unavailable))
+		return -EHOSTDOWN;
+
 	stmmac_xgmac2_c45_format(priv, phyaddr, devad, phyreg, &addr);
 
 	return stmmac_xgmac2_mdio_write(priv, addr, MII_XGMAC_BUSY,
@@ -248,6 +260,9 @@ static int stmmac_mdio_access(struct stmmac_priv *priv, unsigned int pa,
 	u32 addr;
 	int ret;
 
+	if (READ_ONCE(priv->hw_unavailable))
+		return -EHOSTDOWN;
+
 	ret = pm_runtime_resume_and_get(priv->device);
 	if (ret < 0)
 		return ret;
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c
index d584fd2daa6f..c5fcd4e433a7 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c
@@ -215,7 +215,7 @@ static struct pci_driver stmmac_pci_driver = {
 	.probe = stmmac_pci_probe,
 	.remove = stmmac_pci_remove,
 	.driver         = {
-		.pm     = &stmmac_simple_pm_ops,
+		.pm     = &stmmac_pci_pm_ops,
 	},
 };
 
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_pcs.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_pcs.c
index df37af5ab837..7de83fb8f06f 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_pcs.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_pcs.c
@@ -60,7 +60,8 @@ static void dwmac_integrated_pcs_disable(struct phylink_pcs *pcs)
 {
 	struct stmmac_pcs *spcs = phylink_pcs_to_stmmac_pcs(pcs);
 
-	stmmac_mac_irq_modify(spcs->priv, spcs->int_mask, 0);
+	if (!READ_ONCE(spcs->priv->hw_unavailable))
+		stmmac_mac_irq_modify(spcs->priv, spcs->int_mask, 0);
 }
 
 static void dwmac_integrated_pcs_get_state(struct phylink_pcs *pcs,
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
index 3ea16d618215..2f98df3f7147 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
@@ -968,15 +968,23 @@ static int __maybe_unused stmmac_pltfr_noirq_suspend(struct device *dev)
 	if (!netif_running(ndev))
 		return 0;
 
-	if (!priv->wolopts) {
-		/* Disable clock in case of PWM is off */
-		if (priv->ptp_enabled)
+	mutex_lock(&priv->pm_mutex);
+	if (!priv->irq_wake) {
+		/* A detached datapath may already have released its PTP clock. */
+		if (priv->ptp_clock_enabled) {
 			clk_disable_unprepare(priv->plat->clk_ptp_ref);
+			priv->ptp_clock_enabled = false;
+			priv->ptp_clock_suspended = true;
+		}
 
+		priv->bus_clks_suspended = true;
 		ret = pm_runtime_force_suspend(dev);
-		if (ret)
+		if (ret) {
+			mutex_unlock(&priv->pm_mutex);
 			return ret;
+		}
 	}
+	mutex_unlock(&priv->pm_mutex);
 
 	return 0;
 }
@@ -985,30 +993,8 @@ static int __maybe_unused stmmac_pltfr_noirq_resume(struct device *dev)
 {
 	struct net_device *ndev = dev_get_drvdata(dev);
 	struct stmmac_priv *priv = netdev_priv(ndev);
-	int ret;
 
-	if (!netif_running(ndev))
-		return 0;
-
-	if (!priv->wolopts) {
-		/* enable the clk previously disabled */
-		ret = pm_runtime_force_resume(dev);
-		if (ret)
-			return ret;
-
-		if (!priv->ptp_enabled)
-			return 0;
-
-		ret = clk_prepare_enable(priv->plat->clk_ptp_ref);
-		if (ret < 0) {
-			netdev_warn(priv->dev,
-				    "failed to enable PTP reference clock: %pe\n",
-				    ERR_PTR(ret));
-			return ret;
-		}
-	}
-
-	return 0;
+	return stmmac_resume_clocks(priv);
 }
 
 const struct dev_pm_ops stmmac_pltfr_pm_ops = {
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
index 839a93166520..cac2b6e34c94 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
@@ -12,6 +12,17 @@
 #include "stmmac.h"
 #include "stmmac_est.h"
 
+static int tc_config_preemption(struct stmmac_priv *priv,
+				struct netlink_ext_ack *extack, u32 preemptible_tcs)
+{
+	/* Qdisc teardown must not access unpowered registers. */
+	if (priv->hw_unavailable)
+		return 0;
+
+	return stmmac_fpe_map_preemption_class(priv, priv->dev, extack,
+					      preemptible_tcs);
+}
+
 static void tc_fill_all_pass_entry(struct stmmac_tc_entry *entry)
 {
 	memset(entry, 0, sizeof(*entry));
@@ -172,18 +183,16 @@ static int tc_fill_entry(struct stmmac_priv *priv,
 static void tc_unfill_entry(struct stmmac_priv *priv,
 			    struct tc_cls_u32_offload *cls)
 {
-	struct stmmac_tc_entry *entry;
+	struct stmmac_tc_entry *entry, *frag;
 
 	entry = tc_find_entry(priv, cls, false);
 	if (!entry)
 		return;
 
-	entry->in_use = false;
-	if (entry->frag_ptr) {
-		entry = entry->frag_ptr;
-		entry->is_frag = false;
-		entry->in_use = false;
-	}
+	frag = entry->frag_ptr;
+	if (frag)
+		memset(frag, 0, sizeof(*frag));
+	memset(entry, 0, sizeof(*entry));
 }
 
 static int tc_config_knode(struct stmmac_priv *priv,
@@ -213,6 +222,9 @@ static int tc_delete_knode(struct stmmac_priv *priv,
 	/* Set entry and fragments as not used */
 	tc_unfill_entry(priv, cls);
 
+	if (!stmmac_tc_active(priv))
+		return 0;
+
 	return stmmac_rxp_config(priv, priv->hw->pcsr, priv->tc_entries,
 				 priv->tc_entries_max);
 }
@@ -346,6 +358,8 @@ static int tc_setup_cbs(struct stmmac_priv *priv,
 		return -EINVAL;
 	if (!priv->dma_cap.av)
 		return -EOPNOTSUPP;
+	if (priv->hw_unavailable && qopt->enable)
+		return -EHOSTDOWN;
 
 	port_transmit_rate_kbps = qopt->idleslope - qopt->sendslope;
 
@@ -381,10 +395,12 @@ static int tc_setup_cbs(struct stmmac_priv *priv,
 
 		priv->plat->tx_queues_cfg[queue].mode_to_use = MTL_QUEUE_AVB;
 	} else if (!qopt->enable) {
-		ret = stmmac_dma_qmode(priv, priv->ioaddr, queue,
-				       MTL_QUEUE_DCB);
-		if (ret)
-			return ret;
+		if (!priv->hw_unavailable) {
+			ret = stmmac_dma_qmode(priv, priv->ioaddr, queue,
+					       MTL_QUEUE_DCB);
+			if (ret)
+				return ret;
+		}
 
 		priv->plat->tx_queues_cfg[queue].mode_to_use = MTL_QUEUE_DCB;
 		return 0;
@@ -646,23 +662,21 @@ static int tc_del_flow(struct stmmac_priv *priv,
 		       struct flow_cls_offload *cls)
 {
 	struct stmmac_flow_entry *entry = tc_find_flow(priv, cls, false);
-	int ret;
+	int ret = 0;
 
 	if (!entry || !entry->in_use)
 		return -ENOENT;
 
-	if (entry->is_l4) {
-		ret = stmmac_config_l4_filter(priv, priv->hw, entry->idx, false,
-					      false, false, false, 0);
-	} else {
-		ret = stmmac_config_l3_filter(priv, priv->hw, entry->idx, false,
-					      false, false, false, 0);
+	if (stmmac_tc_active(priv)) {
+		if (entry->is_l4)
+			ret = stmmac_config_l4_filter(priv, priv->hw, entry->idx,
+						      false, false, false, false, 0);
+		else
+			ret = stmmac_config_l3_filter(priv, priv->hw, entry->idx,
+						      false, false, false, false, 0);
 	}
 
-	entry->in_use = false;
-	entry->cookie = 0;
-	entry->is_l4 = false;
-	entry->action = 0;
+	*entry = (struct stmmac_flow_entry) { .idx = entry->idx };
 	return ret;
 }
 
@@ -745,7 +759,8 @@ static int tc_del_vlan_flow(struct stmmac_priv *priv,
 	if (!entry || !entry->in_use || entry->type != STMMAC_RFS_T_VLAN)
 		return -ENOENT;
 
-	stmmac_rx_queue_prio(priv, priv->hw, 0, entry->tc);
+	if (stmmac_tc_active(priv))
+		stmmac_rx_queue_prio(priv, priv->hw, 0, entry->tc);
 
 	entry->in_use = false;
 	entry->cookie = 0;
@@ -841,13 +856,13 @@ static int tc_del_ethtype_flow(struct stmmac_priv *priv,
 
 	switch (entry->etype) {
 	case ETH_P_LLDP:
-		stmmac_rx_queue_routing(priv, priv->hw,
-					PACKET_DCBCPQ, 0);
+		if (stmmac_tc_active(priv))
+			stmmac_rx_queue_routing(priv, priv->hw, PACKET_DCBCPQ, 0);
 		priv->rfs_entries_cnt[STMMAC_RFS_T_LLDP]--;
 		break;
 	case ETH_P_1588:
-		stmmac_rx_queue_routing(priv, priv->hw,
-					PACKET_PTPQ, 0);
+		if (stmmac_tc_active(priv))
+			stmmac_rx_queue_routing(priv, priv->hw, PACKET_PTPQ, 0);
 		priv->rfs_entries_cnt[STMMAC_RFS_T_1588]--;
 		break;
 	default:
@@ -902,12 +917,12 @@ static int tc_setup_cls(struct stmmac_priv *priv,
 {
 	int ret = 0;
 
-	/* When RSS is enabled, the filtering will be bypassed */
-	if (priv->rss.enable)
-		return -EBUSY;
-
 	switch (cls->command) {
 	case FLOW_CLS_REPLACE:
+		/* When RSS is enabled, the filtering will be bypassed. */
+		if (priv->rss.enable)
+			return -EBUSY;
+
 		ret = tc_add_flow_cls(priv, cls);
 		break;
 	case FLOW_CLS_DESTROY:
@@ -1021,6 +1036,10 @@ static int tc_taprio_configure(struct stmmac_priv *priv,
 
 	if (qopt->cmd == TAPRIO_CMD_DESTROY)
 		goto disable;
+	if (priv->hw_unavailable) {
+		ret = -EHOSTDOWN;
+		goto unlock;
+	}
 
 	if (qopt->num_entries > dep) {
 		ret = -EINVAL;
@@ -1092,8 +1111,7 @@ static int tc_taprio_configure(struct stmmac_priv *priv,
 	if (ret)
 		goto disable;
 
-	ret = stmmac_fpe_map_preemption_class(priv, priv->dev, extack,
-					      qopt->mqprio.preemptible_tcs);
+	ret = tc_config_preemption(priv, extack, qopt->mqprio.preemptible_tcs);
 	if (ret)
 		goto disable;
 
@@ -1106,15 +1124,16 @@ static int tc_taprio_configure(struct stmmac_priv *priv,
 
 disable:
 	priv->est.enable = false;
-	stmmac_est_configure(priv, priv, &priv->est,
-			     priv->plat->clk_ptp_rate, false);
+	if (!priv->hw_unavailable)
+		stmmac_est_configure(priv, priv, &priv->est,
+				     priv->plat->clk_ptp_rate, false);
 	/* Reset taprio status */
 	for (i = 0; i < priv->plat->tx_queues_to_use; i++) {
 		priv->xstats.max_sdu_txq_drop[i] = 0;
 		priv->xstats.mtl_est_txq_hlbf[i] = 0;
 		priv->xstats.mtl_est_txq_hlbs[i] = 0;
 	}
-	i = stmmac_fpe_map_preemption_class(priv, priv->dev, extack, 0);
+	i = tc_config_preemption(priv, extack, 0);
 	if (qopt->cmd == TAPRIO_CMD_DESTROY)
 		ret = i;
 free_gcl:
@@ -1269,7 +1288,7 @@ static int stmmac_reset_tc_mqprio(struct net_device *ndev,
 	netdev_reset_tc(ndev);
 	netif_set_real_num_tx_queues(ndev, priv->plat->tx_queues_to_use);
 
-	return stmmac_fpe_map_preemption_class(priv, ndev, extack, 0);
+	return tc_config_preemption(priv, extack, 0);
 }
 
 static int tc_setup_dwmac510_mqprio(struct stmmac_priv *priv,
@@ -1286,6 +1305,8 @@ static int tc_setup_dwmac510_mqprio(struct stmmac_priv *priv,
 
 	if (!qopt->num_tc)
 		return stmmac_reset_tc_mqprio(ndev, extack);
+	if (priv->hw_unavailable)
+		return -EHOSTDOWN;
 
 	if (qopt->num_tc > ARRAY_SIZE(tc_to_txq))
 		return -EINVAL;
@@ -1315,8 +1336,7 @@ static int tc_setup_dwmac510_mqprio(struct stmmac_priv *priv,
 	if (err)
 		goto error_reset_tc;
 
-	err = stmmac_fpe_map_preemption_class(priv, ndev, extack,
-					      mqprio->preemptible_tcs);
+	err = tc_config_preemption(priv, extack, mqprio->preemptible_tcs);
 	if (err)
 		goto error_reset_num_tx_queues;
 
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_vlan.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_vlan.c
index e24efe3bfedb..006882c14a8d 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_vlan.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_vlan.c
@@ -114,6 +114,8 @@ static int vlan_del_hw_rx_fltr(struct net_device *dev,
 			       struct mac_device_info *hw,
 			       __be16 proto, u16 vid)
 {
+	struct stmmac_priv *priv = netdev_priv(dev);
+	bool update_hw = netif_running(dev) && !priv->hw_unavailable;
 	int i, ret = 0;
 
 	/* Single Rx VLAN Filter */
@@ -121,7 +123,7 @@ static int vlan_del_hw_rx_fltr(struct net_device *dev,
 		if ((hw->vlan_filter[0] & VLAN_TAG_VID) == vid) {
 			hw->vlan_filter[0] = 0;
 
-			if (netif_running(dev))
+			if (update_hw)
 				vlan_write_single(dev, 0);
 		}
 		return 0;
@@ -132,7 +134,7 @@ static int vlan_del_hw_rx_fltr(struct net_device *dev,
 		if ((hw->vlan_filter[i] & VLAN_TAG_DATA_VEN) &&
 		    ((hw->vlan_filter[i] & VLAN_TAG_DATA_VID) == vid)) {
 
-			if (netif_running(dev)) {
+			if (update_hw) {
 				ret = vlan_write_filter(dev, hw, i, 0);
 				if (ret)
 					return ret;
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_xdp.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_xdp.c
index d7e4db7224b0..7ecb7addd2ea 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_xdp.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_xdp.c
@@ -31,7 +31,8 @@ static int stmmac_xdp_enable_pool(struct stmmac_priv *priv,
 		return err;
 	}
 
-	need_update = netif_running(priv->dev) && stmmac_xdp_is_enabled(priv);
+	need_update = priv->datapath == STMMAC_DATAPATH_RUNNING &&
+		      stmmac_xdp_is_enabled(priv);
 
 	if (need_update) {
 		napi_disable(&ch->rx_napi);
@@ -69,7 +70,8 @@ static int stmmac_xdp_disable_pool(struct stmmac_priv *priv, u16 queue)
 	if (!pool)
 		return -EINVAL;
 
-	need_update = netif_running(priv->dev) && stmmac_xdp_is_enabled(priv);
+	need_update = priv->datapath == STMMAC_DATAPATH_RUNNING &&
+		      stmmac_xdp_is_enabled(priv);
 
 	if (need_update) {
 		napi_disable(&ch->rxtx_napi);
@@ -106,8 +108,9 @@ int stmmac_xdp_set_prog(struct stmmac_priv *priv, struct bpf_prog *prog,
 	struct bpf_prog *old_prog;
 	bool need_update;
 	bool if_running;
+	int ret;
 
-	if_running = netif_running(dev);
+	if_running = priv->datapath == STMMAC_DATAPATH_RUNNING;
 
 	if (prog && dev->mtu > ETH_DATA_LEN) {
 		/* For now, the driver doesn't support XDP functionality with
@@ -117,25 +120,41 @@ int stmmac_xdp_set_prog(struct stmmac_priv *priv, struct bpf_prog *prog,
 		return -EOPNOTSUPP;
 	}
 
-	if (!prog)
-		xdp_features_clear_redirect_target(dev);
-
 	need_update = !!priv->xdp_prog != !!prog;
 	if (if_running && need_update)
 		stmmac_xdp_release(dev);
 
 	old_prog = xchg(&priv->xdp_prog, prog);
-	if (old_prog)
-		bpf_prog_put(old_prog);
 
 	/* Disable RX SPH for XDP operation */
 	priv->sph_active = priv->sph_capable && !stmmac_xdp_is_enabled(priv);
 
-	if (if_running && need_update)
-		stmmac_xdp_open(dev);
+	if (if_running && need_update) {
+		ret = stmmac_xdp_open(dev);
+		if (ret) {
+			netdev_err(dev, "failed reopening after XDP change: %pe; interface remains detached\n",
+				   ERR_PTR(ret));
+			if (prog) {
+				/* The core retains the old program on error and drops
+				 * the reference it passed for the proposed program.
+				 */
+				xchg(&priv->xdp_prog, old_prog);
+				priv->sph_active = priv->sph_capable && !old_prog;
+				return ret;
+			}
+			/* Uninstalling a BPF link must release its program even
+			 * if the non-XDP datapath cannot be restarted.
+			 */
+		}
+	}
+
+	if (old_prog)
+		bpf_prog_put(old_prog);
 
 	if (prog)
 		xdp_features_set_redirect_target(dev, false);
+	else
+		xdp_features_clear_redirect_target(dev);
 
 	return 0;
 }
diff --git a/include/linux/stmmac.h b/include/linux/stmmac.h
index 00be2df63d22..17c54afc415a 100644
--- a/include/linux/stmmac.h
+++ b/include/linux/stmmac.h
@@ -291,6 +291,13 @@ struct plat_stmmacenet_data {
 	void (*exit)(struct device *dev, void *priv);
 	int (*suspend)(struct device *dev, void *priv);
 	int (*resume)(struct device *dev, void *priv);
+	/* MAC WoL retains register/receive/timestamp clocks and power. These
+	 * hooks only prepare/undo additional wake resources, without gating
+	 * register access. Set both hooks together; a failed preparation must
+	 * unwind its own resources.
+	 */
+	int (*suspend_wol)(struct device *dev, void *priv);
+	void (*resume_wol)(struct device *dev, void *priv);
 	int (*mac_setup)(void *priv, struct mac_device_info *mac);
 	int (*clks_config)(void *priv, bool enabled);
 	int (*crosststamp)(ktime_t *device, struct system_counterval_t *system,

-- 
2.53.0

