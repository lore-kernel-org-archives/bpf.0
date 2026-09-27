Received: from mail-oo2-f37.google.com (mail-oo2-f37.google.com [74.125.231.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8892745560A
	for <bpf@vger.kernel.org>; Sun, 27 Sep 2026 22:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790546446; cv=none; b=Jj9Duvwh5mE3IQ0DPcFP8+/eCLahNSNE2BWBQ9fA8n3dD4OHvFRbXpOkwOjoVsV9XniZbHyf99EvNkcXkGo7uqZCe7+YE3PmeSwI/D1Rz3O8R4+8oZv9upMlJCZlBiCKS2jRukuKSPO6nm+IMhOWfBDz+qNuWEmV5XIdAGOrbkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790546446; c=relaxed/simple;
	bh=JSU5bMeMOc1Ae4rU26KH7bC3iQLlqYfv+EVGdzx+uPI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jlYgbadmwEDX7Bk2Jeb8rVncfye4P4WOq0H0VipCrg+ME2kOoj3ZcPpWPLyWSfsBRab2fr4dHI7cUkvI9DaCCDLxFdrZOqXP0Y9PLRmBbm1GOQv7013G16axDHNK8bVKe9CFMMmWHqlHFenUtv7lp3KAZxLKqZ0ktePi2C6czV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W3LKAOqk; arc=none smtp.client-ip=74.125.231.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W3LKAOqk"
Received: by mail-oo2-f37.google.com with SMTP id 46e09a7af769-805bf8c2661so1851505a34.3
        for <bpf@vger.kernel.org>; Sun, 27 Sep 2026 15:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790546433; x=1791151233; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=51fomzJNSQ/ppenripK1fZBpkHWWlSIr4Jj7yRPw3p8=;
        b=W3LKAOqkwLS6zFmctMFBNBN6ah7U9B4KSGf9jClBtIPrVeagBaoXYRL5MXQ1tD5bO2
         Ng1yBwAF1sdvd9Wi4/w8LSesvgl1bEVTDKJnp1PAWSvRTMzEBuL2t7dUY7aQ7WCpqTYi
         iaod0wyNpU95PLbm6fP3sOV0TMeuMVTeb/qRoLrx6e6vig0ygO77y+LjnEDWeZgXLBVU
         ZdJm8WCPIb75Cx4IywUnIg7oaaY0dnkXdNQCOuPUdF/YMPQyvOVCfdLkPoXaGQTyS9Jc
         6O3XE+Hi2JkIu4GxFqM71TKtfnGGstDYTFjz5Krjrx82bbwqWiDCN1pjMXNF/TLvLn39
         ozhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790546433; x=1791151233;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=51fomzJNSQ/ppenripK1fZBpkHWWlSIr4Jj7yRPw3p8=;
        b=WpgIu+Tz0343Tv0DOL+WxMNrICISYXODSsmboSSKdkBacoW2tY6Yl2G2IaJno9BUEy
         +BQm9ieuIYTIqLpOQ8CeFC8V6/15Yf/pRsjei1iM1o1hRyhGNNNhj6k3Tb/nxhEYzLVu
         5TNm8ACUSOErsrOxhwkum6I88pRxlDtF/naTUCYK6eQQWwEYgv2rr1OcqArewp0zNh7n
         pN2DdxnbLxEihpP+JjIbdNi1/cGmnmSDqabyY++vtVvi4uySDkuzBTZfxNDsgKP9Qsgk
         2JqWLnWKeCO5lt+BWW7tRhEaXNh/V1CAbQt6gjPNgU2zD4AhaRaWB+fvOzcupJFtKCNP
         HhJw==
X-Forwarded-Encrypted: i=1; AKwUvByK3pVEA8oGo7A0W7BVB2P3/c8vMxweT1TrXpsFSNmy+fVkLpmLe/uukghA38/mHSPvHrM=@vger.kernel.org
X-Gm-Message-State: AFuF++mb0MuMZsusSznsmvZU1VtivzQTf/10YuRdQQbShtWbxyFButh8
	1Aj40DJtFptjxw2ZU4erfCod42AVx+BYxG1UgZRLfBm65TRSK70fg2IX
X-Gm-Gg: AYBFou0VtjDqWu8GGPSbTwnO/i/wa46JPqLFyGigMd6LT308fwnkC9fhBF9HJhOXNjH
	F8X25zIrM3Yg3O+RF/zfaxUKIfiphr0VizY6GKmxERqTmEWycEiPoBTRlJpCiD8nxS+/C8HhOGV
	C4o7/ZC3n+tseLx8HeOenNpL9AxmaOpXMIm4sNAG5hQfUAwcN5JlsRBvFPYwJkJDBiI72nJyyug
	gjvbuCc4DAE/vsi6Xdf8H1P1E6rXoVaimrKJ1la6JCDySkUvMq10b4xPLIDBhoQgUpUlh1cKJuL
	iViCnrU/TpDgJemI4BEAB5Wm1cMZf3FPHhXgNJZqeDSUUjUp7Yf36BBbOj5sJIE+X64uhH5vo+V
	2z71edvddsp/M59aDAV08TMuEP52W4RWdpRBSFU5LEycdphYfzqNUpsgxgCTvHFG1kncbrNWjEl
	FukHQimxGPmjD9syWer/+pXSLl6GWFWpam9V2D19w6ynVCbNSya9WNsthkL4QFajUz2l1TwJTD2
	e9kwIMLifCoq0QD9xh9Y/CYK0N/B/NV5OPm+cbRJ9Co49CophbbkPON7RVyBisQrdTX9phCc/ay
	ILW2EgPuknIUUgOhiNYor2O4IlPE3oyzcsw9w2aBWirEJnBTPQnKBt+GOsjhvcsyV+Iz6xtU+hr
	IGrus0qDnaHttqz4RmNQ+Jw==
X-Received: by 2002:a05:6830:630c:b0:805:cd51:568a with SMTP id 46e09a7af769-8178059d3cemr14392769a34.2.1790546432254;
        Sun, 27 Sep 2026 15:00:32 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-81b3de6f7e1sm4874147a34.22.2026.09.27.15.00.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 15:00:31 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sun, 27 Sep 2026 15:59:52 -0600
Subject: [PATCH net-next v5 17/19] net: stmmac: retain DMA memory until
 hardware shutdown completes
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260927-submit-stmmac-reset-fixes-v1-v5-17-feec6c14dd06@gmail.com>
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

Clearing the DMA start bits requests a stop but need not complete an
in-flight frame or descriptor writeback. Ordinary release, live XDP/XSK
replacement and late open failures currently free the rings and buffers
immediately afterwards. An XSK socket can then unmap and unpin the UMEM
while hardware still has its addresses.

Wait for stopped process states on the legacy and Allwinner DMA engines.
For GMAC4 configurations represented by DSR0, also require its bus-busy
bits to clear. Fall back to a completed global reset if the idle wait
times out or the integration has no supported idle indication, including
XGMAC and GMAC4 configurations with more than three channels. Prepare
the PHY receive clock for that reset and restore PHC configuration
before a live XDP restart which required it. As with MTU reset,
continuous PHC time is not preserved on this fallback.

Track configurations exposed to DMA separately from software datapath
ownership. If both idle and reset fail, keep the rings, DMA mappings and
backing memory until a subsequent successful reset. Do not overwrite
retained buffers in an XDP reopen or change their ring/channel geometry.
Record failed open replacements too, including ones which are no longer
the active configuration pointer. A successful down/up reset retires
them.

Take independent XSK DMA/UMEM and buffer metadata references when
initializing RX rings. On failed shutdown, remove active pool pointers
but retain the RX buffer heads without returning them to the free list.
Socket teardown still completes. A later successful reset releases the
buffers and their references; pinning pages alone would not prevent an
active pool from reusing a frame that hardware could still overwrite.

Defer hard TX error recovery to process context instead of rewriting a
ring in the IRQ handler immediately after clearing ST. Likewise, move
resume-time TX cleanup and descriptor rebuilding after the reset
succeeds. Do not let queued recovery work reopen an administratively
closed device.

There is no generic, guaranteed isolation mechanism across all stmmac
integrations. If hardware still cannot stop or reset at removal,
deliberately retain the DMA allocations and report the quarantine rather
than expose recycled memory to DMA. Such an unrecoverable device can
therefore retain memory, including pinned UMEM, until reboot.

Rebuild retained RX descriptors after reset with buffer addresses and
chain links written before ownership. GMAC4 and XGMAC secondary-address
programming overwrites des3, so publishing OWN first would lose it.
Use this rebuild on system resume too: writeback status is not a valid
read-format descriptor. Fill missing page-pool buffers after reset, and
leave a failed refill detached. Recycle XSK buffers only after the reset
fence, accept empty or partial FILL rings, and publish ownership only for
populated descriptors.

Fixes: ac746c8520d9 ("net: stmmac: enhance XDP ZC driver level switching performance")
Fixes: bba2556efad6 ("net: stmmac: Enable RX via AF_XDP zero-copy")
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes in v5:
- Keep quarantined XSK RX buffers outside the pool free list until a
  successful shutdown/reset, including after socket teardown.
- Rebuild read-format RX descriptors on resume, not only MTU rollback.
  Refill page-pool holes and handle empty/partial XSK FILL rings without
  applying the page-pool-only rollback helper to XSK buffers.
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c  |  17 +
 .../net/ethernet/stmicro/stmmac/dwmac1000_dma.c    |   1 +
 drivers/net/ethernet/stmicro/stmmac/dwmac100_dma.c |   1 +
 drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c   |   2 +
 drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.h   |   6 +
 drivers/net/ethernet/stmicro/stmmac/dwmac4_lib.c   |  18 +
 drivers/net/ethernet/stmicro/stmmac/dwmac_dma.h    |   2 +
 drivers/net/ethernet/stmicro/stmmac/dwmac_lib.c    |  20 +
 drivers/net/ethernet/stmicro/stmmac/hwif.h         |   4 +
 drivers/net/ethernet/stmicro/stmmac/stmmac.h       |  11 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  | 459 ++++++++++++++++-----
 11 files changed, 445 insertions(+), 96 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
index 38d7e71de925..c9145441aab0 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
@@ -163,6 +163,7 @@ static const struct emac_variant emac_variant_h6 = {
 #define EMAC_TX_CUR_DESC        0xB4
 #define EMAC_TX_CUR_BUF 0xB8
 #define EMAC_RX_DMA_STA 0xC0
+#define EMAC_DMA_STATE_MASK GENMASK(2, 0)
 #define EMAC_RX_CUR_DESC        0xC4
 #define EMAC_RX_CUR_BUF 0xC8
 
@@ -425,6 +426,21 @@ static void sun8i_dwmac_dma_stop_rx(struct stmmac_priv *priv,
 	writel(v, ioaddr + EMAC_RX_CTL1);
 }
 
+static int sun8i_dwmac_dma_wait_idle(struct stmmac_priv *priv,
+				     void __iomem *ioaddr)
+{
+	u32 value;
+	int ret;
+
+	/* STOP (0) follows the frame transfer and descriptor close states. */
+	ret = readl_poll_timeout(ioaddr + EMAC_TX_DMA_STA, value,
+				 !(value & EMAC_DMA_STATE_MASK), 100, 100000);
+	if (ret)
+		return ret;
+	return readl_poll_timeout(ioaddr + EMAC_RX_DMA_STA, value,
+				 !(value & EMAC_DMA_STATE_MASK), 100, 100000);
+}
+
 static int sun8i_dwmac_dma_interrupt(struct stmmac_priv *priv,
 				     void __iomem *ioaddr,
 				     struct stmmac_extra_stats *x, u32 chan,
@@ -553,6 +569,7 @@ static void sun8i_dwmac_dma_operation_mode_tx(struct stmmac_priv *priv,
 
 static const struct stmmac_dma_ops sun8i_dwmac_dma_ops = {
 	.reset = sun8i_dwmac_dma_reset,
+	.wait_idle = sun8i_dwmac_dma_wait_idle,
 	.init = sun8i_dwmac_dma_init,
 	.init_rx_chan = sun8i_dwmac_dma_init_rx,
 	.init_tx_chan = sun8i_dwmac_dma_init_tx,
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac1000_dma.c b/drivers/net/ethernet/stmicro/stmmac/dwmac1000_dma.c
index 3ac7a7949529..4cb7e6c16bdd 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac1000_dma.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac1000_dma.c
@@ -252,6 +252,7 @@ static void dwmac1000_rx_watchdog(struct stmmac_priv *priv,
 
 const struct stmmac_dma_ops dwmac1000_dma_ops = {
 	.reset = dwmac_dma_reset,
+	.wait_idle = dwmac_dma_wait_idle,
 	.init_chan = dwmac1000_dma_init_channel,
 	.init_rx_chan = dwmac1000_dma_init_rx,
 	.init_tx_chan = dwmac1000_dma_init_tx,
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac100_dma.c b/drivers/net/ethernet/stmicro/stmmac/dwmac100_dma.c
index 12b2bf2d739a..5ffd3c1471c4 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac100_dma.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac100_dma.c
@@ -108,6 +108,7 @@ static void dwmac100_dma_diagnostic_fr(struct stmmac_extra_stats *x,
 
 const struct stmmac_dma_ops dwmac100_dma_ops = {
 	.reset = dwmac_dma_reset,
+	.wait_idle = dwmac_dma_wait_idle,
 	.init = dwmac100_dma_init,
 	.init_rx_chan = dwmac100_dma_init_rx,
 	.init_tx_chan = dwmac100_dma_init_tx,
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c b/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c
index 14ac3f0e51f7..d7928678dee1 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c
@@ -570,6 +570,7 @@ static int dwmac4_enable_tbs(struct stmmac_priv *priv, void __iomem *ioaddr,
 
 const struct stmmac_dma_ops dwmac4_dma_ops = {
 	.reset = dwmac4_dma_reset,
+	.wait_idle = dwmac4_dma_wait_idle,
 	.init = dwmac4_dma_init,
 	.init_chan = dwmac4_dma_init_channel,
 	.deinit_chan = dwmac4_dma_deinit_channel,
@@ -600,6 +601,7 @@ const struct stmmac_dma_ops dwmac4_dma_ops = {
 
 const struct stmmac_dma_ops dwmac410_dma_ops = {
 	.reset = dwmac4_dma_reset,
+	.wait_idle = dwmac4_dma_wait_idle,
 	.init = dwmac4_dma_init,
 	.init_chan = dwmac410_dma_init_channel,
 	.deinit_chan = dwmac410_dma_deinit_channel,
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.h b/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.h
index 43b036d4e95b..9352107204eb 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.h
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.h
@@ -10,6 +10,12 @@
 #ifndef __DWMAC4_DMA_H__
 #define __DWMAC4_DMA_H__
 
+int dwmac4_dma_wait_idle(struct stmmac_priv *priv, void __iomem *ioaddr);
+
+#define DMA_DEBUG_STATUS0	0x0000100c
+#define DMA_DEBUG_BUS_BUSY	GENMASK(1, 0)
+#define DMA_DEBUG_CH_STATE(ch)	(GENMASK(15, 8) << ((ch) * 8))
+
 /* Define the max channel number used for tx (also rx).
  * dwmac4 accepts up to 8 channels for TX (and also 8 channels for RX
  */
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4_lib.c b/drivers/net/ethernet/stmicro/stmmac/dwmac4_lib.c
index a0249715fafa..9af0565a9bca 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_lib.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_lib.c
@@ -26,6 +26,24 @@ int dwmac4_dma_reset(void __iomem *ioaddr)
 				 10000, 1000000);
 }
 
+int dwmac4_dma_wait_idle(struct stmmac_priv *priv, void __iomem *ioaddr)
+{
+	u32 channels = max(priv->plat->rx_queues_to_use,
+			   priv->plat->tx_queues_to_use);
+	u32 mask = DMA_DEBUG_BUS_BUSY;
+	u32 value, chan;
+
+	/* DSR0 describes channels 0..2 and outstanding AXI transactions.
+	 * Other debug-register layouts require a successful reset instead.
+	 */
+	if (channels > 3)
+		return -EOPNOTSUPP;
+	for (chan = 0; chan < channels; chan++)
+		mask |= DMA_DEBUG_CH_STATE(chan);
+	return readl_poll_timeout(ioaddr + DMA_DEBUG_STATUS0, value,
+				 !(value & mask), 100, 100000);
+}
+
 void dwmac4_set_rx_tail_ptr(struct stmmac_priv *priv, void __iomem *ioaddr,
 			    u32 tail_ptr, u32 chan)
 {
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac_dma.h b/drivers/net/ethernet/stmicro/stmmac/dwmac_dma.h
index e1c37ac2c99d..970495bccfd2 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac_dma.h
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac_dma.h
@@ -11,6 +11,8 @@
 #ifndef __DWMAC_DMA_H__
 #define __DWMAC_DMA_H__
 
+int dwmac_dma_wait_idle(struct stmmac_priv *priv, void __iomem *ioaddr);
+
 /* DMA CRS Control and Status Register Mapping */
 #define DMA_BUS_MODE		0x00001000	/* Bus Mode */
 
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac_lib.c b/drivers/net/ethernet/stmicro/stmmac/dwmac_lib.c
index a0383f9486c2..bb907db8fca1 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac_lib.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac_lib.c
@@ -27,6 +27,26 @@ int dwmac_dma_reset(void __iomem *ioaddr)
 				 10000, 200000);
 }
 
+int dwmac_dma_wait_idle(struct stmmac_priv *priv, void __iomem *ioaddr)
+{
+	u32 channels = max(priv->plat->rx_queues_to_use,
+			   priv->plat->tx_queues_to_use);
+	u32 value, chan;
+	int ret;
+
+	/* CSR5 process states, not the latched process-stopped interrupts.
+	 * Stopped is reached after the outstanding descriptor writeback.
+	 */
+	for (chan = 0; chan < channels; chan++) {
+		ret = readl_poll_timeout(ioaddr + DMA_CHAN_STATUS(chan), value,
+					 !(value & (DMA_STATUS_TS_MASK | DMA_STATUS_RS_MASK)),
+					 100, 100000);
+		if (ret)
+			return ret;
+	}
+	return 0;
+}
+
 /* CSR1 enables the transmit DMA to check for new descriptor */
 void dwmac_enable_dma_transmission(void __iomem *ioaddr, u32 chan)
 {
diff --git a/drivers/net/ethernet/stmicro/stmmac/hwif.h b/drivers/net/ethernet/stmicro/stmmac/hwif.h
index 1fd9f1ab316e..4b7381a6fcce 100644
--- a/drivers/net/ethernet/stmicro/stmmac/hwif.h
+++ b/drivers/net/ethernet/stmicro/stmmac/hwif.h
@@ -205,6 +205,8 @@ struct stmmac_dma_ops {
 			 u32 chan);
 	void (*stop_rx)(struct stmmac_priv *priv, void __iomem *ioaddr,
 			u32 chan);
+	/* Called after stopping every channel; must also drain bus accesses. */
+	int (*wait_idle)(struct stmmac_priv *priv, void __iomem *ioaddr);
 	int (*dma_interrupt)(struct stmmac_priv *priv, void __iomem *ioaddr,
 			     struct stmmac_extra_stats *x, u32 chan, u32 dir);
 	/* If supported then get the optional core features */
@@ -269,6 +271,8 @@ struct stmmac_dma_ops {
 	stmmac_do_void_callback(__priv, dma, start_rx, __priv, __args)
 #define stmmac_stop_rx(__priv, __args...) \
 	stmmac_do_void_callback(__priv, dma, stop_rx, __priv, __args)
+#define stmmac_dma_wait_idle(__priv, __args...) \
+	stmmac_do_callback(__priv, dma, wait_idle, __priv, __args)
 #define stmmac_dma_interrupt_status(__priv, __args...) \
 	stmmac_do_callback(__priv, dma, dma_interrupt, __priv, __args)
 #define stmmac_get_hw_feature(__priv, __args...) \
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac.h b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
index 04d08b2c1e3f..090d79aeb2ad 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac.h
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
@@ -120,6 +120,7 @@ struct stmmac_rx_queue {
 	u32 queue_index;
 	struct xdp_rxq_info xdp_rxq;
 	struct xsk_buff_pool *xsk_pool;
+	struct xsk_dma_ref *xsk_dma;
 	struct page_pool *page_pool;
 	struct stmmac_rx_buffer *buf_pool;
 	struct stmmac_priv *priv_data;
@@ -223,6 +224,10 @@ struct stmmac_rfs_entry {
 };
 
 struct stmmac_dma_conf {
+	/* RTNL: all configurations exposed to DMA survive until stop/reset. */
+	struct list_head list;
+	bool dma_owned;
+	bool retired;
 	unsigned int dma_buf_sz;
 
 	/* RX Queue */
@@ -266,11 +271,11 @@ struct stmmac_msi {
 };
 
 enum stmmac_datapath_state {
-	/* No IRQs or DMA allocations owned by a successful open. */
+	/* No IRQs or enabled NAPI; failed DMA shutdown may retain memory. */
 	STMMAC_DATAPATH_DOWN,
 	/* Resources allocated, NAPI enabled. */
 	STMMAC_DATAPATH_RUNNING,
-	/* Resources retained, NAPI and DMA stopped; also after failed resume. */
+	/* Resources retained, NAPI disabled, DMA stop requested. */
 	STMMAC_DATAPATH_SUSPENDED,
 };
 
@@ -297,6 +302,8 @@ struct stmmac_priv {
 	struct mutex lock;
 
 	struct stmmac_dma_conf *dma_conf;
+	struct list_head dma_confs;
+	bool dma_reset_needed;
 	/* IRQ/DMA ownership and NAPI state, serialized by RTNL. */
 	enum stmmac_datapath_state datapath;
 	/* Core sleep sequence completed, independently of datapath ownership. */
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index f5060924dae8..98dbc873e1c8 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -1027,6 +1027,25 @@ static void stmmac_block_ptp(struct stmmac_priv *priv, bool block)
 	write_unlock_irqrestore(&priv->ptp_lock, flags);
 }
 
+static int stmmac_restore_timestamping(struct stmmac_priv *priv)
+{
+	int ret;
+
+	if (!priv->ptp_enabled)
+		return 0;
+
+	ret = stmmac_init_ptp_clk_freq(priv);
+	if (ret)
+		return ret;
+
+	ret = stmmac_init_tstamp_counter(priv, priv->systime_flags);
+	if (ret)
+		return ret;
+	if (priv->plat->flags & STMMAC_FLAG_HWTSTAMP_CORRECT_LATENCY)
+		stmmac_hwtstamp_correct_latency(priv, priv);
+	return stmmac_ptp_restore(priv);
+}
+
 static void stmmac_legacy_serdes_power_down(struct stmmac_priv *priv)
 {
 	if (priv->plat->serdes_powerdown && priv->legacy_serdes_is_powered)
@@ -1704,24 +1723,10 @@ static void stmmac_clear_descriptors(struct stmmac_priv *priv,
 		stmmac_clear_tx_descriptors(priv, dma_conf, queue);
 }
 
-/**
- * stmmac_init_rx_buffers - init the RX descriptor buffer.
- * @priv: driver private structure
- * @dma_conf: structure to take the dma data
- * @p: descriptor pointer
- * @i: descriptor index
- * @flags: gfp flag
- * @queue: RX queue index
- * Description: this function is called to allocate a receive buffer, perform
- * the DMA mapping and init the descriptor.
- */
-static int stmmac_init_rx_buffers(struct stmmac_priv *priv,
-				  struct stmmac_dma_conf *dma_conf,
-				  struct dma_desc *p,
-				  int i, gfp_t flags, u32 queue)
+static int stmmac_alloc_rx_buffer(struct stmmac_priv *priv,
+				  struct stmmac_rx_queue *rx_q,
+				  struct stmmac_rx_buffer *buf)
 {
-	struct stmmac_rx_queue *rx_q = &dma_conf->rx_queue[queue];
-	struct stmmac_rx_buffer *buf = &rx_q->buf_pool[i];
 	gfp_t gfp = (GFP_ATOMIC | __GFP_NOWARN);
 
 	if (priv->dma_cap.host_dma_width <= 32)
@@ -1738,19 +1743,49 @@ static int stmmac_init_rx_buffers(struct stmmac_priv *priv,
 		buf->sec_page = page_pool_alloc_pages(rx_q->page_pool, gfp);
 		if (!buf->sec_page)
 			return -ENOMEM;
-
 		buf->sec_addr = page_pool_get_dma_addr(buf->sec_page);
-		stmmac_set_desc_sec_addr(priv, p, buf->sec_addr, true);
-	} else {
-		buf->sec_page = NULL;
-		stmmac_set_desc_sec_addr(priv, p, buf->sec_addr, false);
 	}
 
+	return 0;
+}
+
+static void stmmac_init_rx_buffer_desc(struct stmmac_priv *priv,
+				       struct stmmac_dma_conf *dma_conf,
+				       struct dma_desc *p,
+				       struct stmmac_rx_buffer *buf)
+{
+	if (buf->sec_page)
+		buf->sec_addr = page_pool_get_dma_addr(buf->sec_page);
+	stmmac_set_desc_sec_addr(priv, p, buf->sec_addr, !!buf->sec_page);
 	buf->addr = page_pool_get_dma_addr(buf->page) + buf->page_offset;
 
 	stmmac_set_desc_addr(priv, p, buf->addr);
 	if (dma_conf->dma_buf_sz == BUF_SIZE_16KiB)
 		stmmac_init_desc3(priv, p);
+}
+
+/**
+ * stmmac_init_rx_buffers - allocate a receive buffer and init its descriptor
+ * @priv: driver private structure
+ * @dma_conf: structure to take the dma data
+ * @p: descriptor pointer
+ * @i: descriptor index
+ * @flags: gfp flag
+ * @queue: RX queue index
+ */
+static int stmmac_init_rx_buffers(struct stmmac_priv *priv,
+				  struct stmmac_dma_conf *dma_conf,
+				  struct dma_desc *p,
+				  int i, gfp_t flags, u32 queue)
+{
+	struct stmmac_rx_queue *rx_q = &dma_conf->rx_queue[queue];
+	struct stmmac_rx_buffer *buf = &rx_q->buf_pool[i];
+	int ret;
+
+	ret = stmmac_alloc_rx_buffer(priv, rx_q, buf);
+	if (ret)
+		return ret;
+	stmmac_init_rx_buffer_desc(priv, dma_conf, p, buf);
 
 	return 0;
 }
@@ -1967,6 +2002,9 @@ static int __init_dma_rx_desc_rings(struct stmmac_priv *priv,
 	rx_q->xsk_pool = stmmac_get_xsk_pool(priv, queue);
 
 	if (rx_q->xsk_pool) {
+		rx_q->xsk_dma = xsk_pool_dma_get(rx_q->xsk_pool);
+		if (!rx_q->xsk_dma)
+			return -EINVAL;
 		ret = xdp_rxq_info_reg_mem_model(&rx_q->xdp_rxq,
 						 MEM_TYPE_XSK_BUFF_POOL, NULL);
 		if (ret)
@@ -2213,6 +2251,70 @@ static void stmmac_free_tx_skbufs(struct stmmac_priv *priv)
 		dma_free_tx_skbufs(priv, priv->dma_conf, queue);
 }
 
+/* Only after a successful DMA reset. MTU rollback has already filled holes;
+ * resume may need new page-pool buffers or a partially populated XSK ring.
+ */
+static int stmmac_reinit_dma_desc(struct stmmac_priv *priv)
+{
+	struct stmmac_dma_conf *dma_conf = priv->dma_conf;
+	u32 queue, i;
+	int ret;
+
+	stmmac_free_tx_skbufs(priv);
+	stmmac_reset_queues_param(priv);
+	init_dma_tx_desc_rings(priv->dev, dma_conf);
+	for (queue = 0; queue < priv->plat->tx_queues_to_use; queue++)
+		stmmac_clear_tx_descriptors(priv, dma_conf, queue);
+
+	for (queue = 0; queue < priv->plat->rx_queues_to_use; queue++) {
+		struct stmmac_rx_queue *rx_q = &dma_conf->rx_queue[queue];
+
+		if (rx_q->state_saved)
+			dev_kfree_skb_any(rx_q->state.skb);
+		rx_q->state.skb = NULL;
+		rx_q->state_saved = 0;
+		rx_q->rx_count_frames = 0;
+		rx_q->buf_alloc_num = 0;
+
+		/* Writeback format contains status, not buffer addresses. Rebuild
+		 * read format from software ownership before publishing any OWN.
+		 */
+		memset(stmmac_get_rx_desc(priv, rx_q, 0), 0,
+		       stmmac_get_rx_desc_size(priv) * dma_conf->dma_rx_size);
+		if (rx_q->xsk_pool) {
+			dma_free_rx_xskbufs(priv, dma_conf, queue);
+			/* Empty FILL rings are valid, including TX-only sockets. */
+			stmmac_alloc_rx_buffers_zc(priv, dma_conf, queue);
+		} else {
+			for (i = 0; i < dma_conf->dma_rx_size; i++) {
+				struct dma_desc *p = stmmac_get_rx_desc(priv, rx_q, i);
+
+				ret = stmmac_alloc_rx_buffer(priv, rx_q,
+							     &rx_q->buf_pool[i]);
+				if (ret)
+					return ret;
+				stmmac_init_rx_buffer_desc(priv, dma_conf, p,
+							   &rx_q->buf_pool[i]);
+				rx_q->buf_alloc_num++;
+			}
+		}
+
+		if (priv->descriptor_mode == STMMAC_CHAIN_MODE)
+			stmmac_mode_init(priv, stmmac_get_rx_desc(priv, rx_q, 0),
+					 rx_q->dma_rx_phy, dma_conf->dma_rx_size,
+					 priv->extend_desc);
+
+		dma_wmb();
+		for (i = 0; i < rx_q->buf_alloc_num; i++)
+			stmmac_init_rx_desc(priv, stmmac_get_rx_desc(priv, rx_q, i),
+					    priv->use_riwt, priv->descriptor_mode,
+					    i == dma_conf->dma_rx_size - 1,
+					    dma_conf->dma_buf_sz);
+	}
+
+	return 0;
+}
+
 /**
  * __free_dma_rx_desc_resources - free RX dma desc resources (per queue)
  * @priv: private structure
@@ -2228,9 +2330,10 @@ static void __free_dma_rx_desc_resources(struct stmmac_priv *priv,
 	void *addr;
 
 	/* Release the DMA RX socket buffers */
-	if (rx_q->xsk_pool) {
+	if (rx_q->xsk_pool || rx_q->xsk_dma) {
 		dma_free_rx_xskbufs(priv, dma_conf, queue);
-		xsk_pool_set_rxq_info(rx_q->xsk_pool, NULL);
+		if (rx_q->xsk_pool)
+			xsk_pool_set_rxq_info(rx_q->xsk_pool, NULL);
 	} else {
 		dma_free_rx_skbufs(priv, dma_conf, queue);
 	}
@@ -2260,6 +2363,9 @@ static void __free_dma_rx_desc_resources(struct stmmac_priv *priv,
 		xdp_rxq_info_unreg(&rx_q->xdp_rxq);
 
 	kfree(rx_q->buf_pool);
+	if (rx_q->xsk_dma)
+		xsk_pool_dma_put(rx_q->xsk_dma);
+	rx_q->xsk_dma = NULL;
 	rx_q->buf_pool = NULL;
 
 	if (rx_q->page_pool) {
@@ -2271,11 +2377,10 @@ static void __free_dma_rx_desc_resources(struct stmmac_priv *priv,
 static void free_dma_rx_desc_resources(struct stmmac_priv *priv,
 				       struct stmmac_dma_conf *dma_conf)
 {
-	u8 rx_count = priv->plat->rx_queues_to_use;
 	u8 queue;
 
 	/* Free RX queue resources */
-	for (queue = 0; queue < rx_count; queue++)
+	for (queue = 0; queue < MTL_MAX_RX_QUEUES; queue++)
 		__free_dma_rx_desc_resources(priv, dma_conf, queue);
 }
 
@@ -2324,11 +2429,10 @@ static void __free_dma_tx_desc_resources(struct stmmac_priv *priv,
 static void free_dma_tx_desc_resources(struct stmmac_priv *priv,
 				       struct stmmac_dma_conf *dma_conf)
 {
-	u8 tx_count = priv->plat->tx_queues_to_use;
 	u8 queue;
 
 	/* Free TX queue resources */
-	for (queue = 0; queue < tx_count; queue++)
+	for (queue = 0; queue < MTL_MAX_TX_QUEUES; queue++)
 		__free_dma_tx_desc_resources(priv, dma_conf, queue);
 }
 
@@ -2555,14 +2659,35 @@ static int alloc_dma_desc_resources(struct stmmac_priv *priv,
 	return ret;
 }
 
-/**
- * free_dma_desc_resources - free dma desc resources
- * @priv: private structure
- * @dma_conf: structure to take the dma data
- */
+static void stmmac_detach_xsk_buffers(struct stmmac_priv *priv,
+				      struct stmmac_dma_conf *dma_conf)
+{
+	u32 queue;
+
+	/* Socket teardown can complete, but the DMA references must retain both
+	 * the mapping and the buffer metadata. Do not put these frames on the
+	 * pool's free list while hardware can still overwrite them.
+	 */
+	for (queue = 0; queue < MTL_MAX_RX_QUEUES; queue++) {
+		struct stmmac_rx_queue *rx_q = &dma_conf->rx_queue[queue];
+
+		if (!rx_q->xsk_pool)
+			continue;
+		xsk_pool_set_rxq_info(rx_q->xsk_pool, NULL);
+		rx_q->xsk_pool = NULL;
+	}
+	for (queue = 0; queue < MTL_MAX_TX_QUEUES; queue++)
+		dma_conf->tx_queue[queue].xsk_pool = NULL;
+}
+
 static void free_dma_desc_resources(struct stmmac_priv *priv,
 				    struct stmmac_dma_conf *dma_conf)
 {
+	if (dma_conf->dma_owned) {
+		stmmac_detach_xsk_buffers(priv, dma_conf);
+		return;
+	}
+
 	/* Release the DMA TX socket buffers */
 	free_dma_tx_desc_resources(priv, dma_conf);
 
@@ -2572,6 +2697,42 @@ static void free_dma_desc_resources(struct stmmac_priv *priv,
 	free_dma_rx_desc_resources(priv, dma_conf);
 }
 
+static void stmmac_put_dma_conf(struct stmmac_priv *priv,
+				struct stmmac_dma_conf *dma_conf)
+{
+	free_dma_desc_resources(priv, dma_conf);
+	if (dma_conf->dma_owned) {
+		dma_conf->retired = true;
+		return;
+	}
+	list_del(&dma_conf->list);
+	kfree(dma_conf);
+}
+
+/* A successful global reset is also the retirement fence for configurations
+ * retained by a previous failed close, open, or MTU rollback.
+ */
+static void stmmac_dma_reset_complete(struct stmmac_priv *priv)
+{
+	struct stmmac_dma_conf *dma_conf, *next;
+
+	list_for_each_entry_safe(dma_conf, next, &priv->dma_confs, list) {
+		dma_conf->dma_owned = false;
+		if (dma_conf->retired)
+			stmmac_put_dma_conf(priv, dma_conf);
+	}
+}
+
+static bool stmmac_dma_busy(struct stmmac_priv *priv)
+{
+	struct stmmac_dma_conf *dma_conf;
+
+	list_for_each_entry(dma_conf, &priv->dma_confs, list)
+		if (dma_conf->dma_owned)
+			return true;
+	return false;
+}
+
 /**
  *  stmmac_mac_enable_rx_queues - Enable MAC rx queues
  *  @priv: driver private structure
@@ -2598,6 +2759,7 @@ static void stmmac_mac_enable_rx_queues(struct stmmac_priv *priv)
  */
 static void stmmac_start_rx_dma(struct stmmac_priv *priv, u32 chan)
 {
+	priv->dma_conf->dma_owned = true;
 	netdev_dbg(priv->dev, "DMA RX processes started in channel %d\n", chan);
 	stmmac_start_rx(priv, priv->ioaddr, chan);
 }
@@ -2611,6 +2773,7 @@ static void stmmac_start_rx_dma(struct stmmac_priv *priv, u32 chan)
  */
 static void stmmac_start_tx_dma(struct stmmac_priv *priv, u32 chan)
 {
+	priv->dma_conf->dma_owned = true;
 	netdev_dbg(priv->dev, "DMA TX processes started in channel %d\n", chan);
 	stmmac_start_tx(priv, priv->ioaddr, chan);
 }
@@ -3145,25 +3308,17 @@ static int stmmac_tx_clean(struct stmmac_priv *priv, int budget, u32 queue,
  * stmmac_tx_err - to manage the tx error
  * @priv: driver private structure
  * @chan: channel index
- * Description: it cleans the descriptors and restarts the transmission
- * in case of transmission errors.
+ * Description: stop submissions and request process-context DMA recovery.
  */
 static void stmmac_tx_err(struct stmmac_priv *priv, u32 chan)
 {
-	struct stmmac_tx_queue *tx_q = &priv->dma_conf->tx_queue[chan];
-
 	netif_tx_stop_queue(netdev_get_tx_queue(priv->dev, chan));
-
 	stmmac_stop_tx_dma(priv, chan);
-	dma_free_tx_skbufs(priv, priv->dma_conf, chan);
-	stmmac_clear_tx_descriptors(priv, priv->dma_conf, chan);
-	stmmac_reset_tx_queue(priv, chan);
-	stmmac_init_tx_chan(priv, priv->ioaddr, priv->plat->dma_cfg,
-			    tx_q->dma_tx_phy, chan);
-	stmmac_start_tx_dma(priv, chan);
-
 	priv->xstats.tx_errors++;
-	netif_tx_wake_queue(netdev_get_tx_queue(priv->dev, chan));
+	/* Recovery must wait for DMA before freeing or rewriting descriptors.
+	 * Use the process-context reset path, not teardown in hard IRQ context.
+	 */
+	stmmac_global_err(priv);
 }
 
 /**
@@ -3399,12 +3554,13 @@ static int stmmac_prereset_configure(struct stmmac_priv *priv)
 /**
  * stmmac_init_dma_engine - DMA init.
  * @priv: driver private structure
+ * @reinit: rebuild the retained rings after a successful reset
  * Description:
  * It inits the DMA invoking the specific MAC/GMAC callback.
  * Some DMA parameters can be passed from the platform;
  * in case of these are not passed a default is kept for the MAC or GMAC.
  */
-static int stmmac_init_dma_engine(struct stmmac_priv *priv)
+static int stmmac_init_dma_engine(struct stmmac_priv *priv, bool reinit)
 {
 	u8 rx_channels_count = priv->plat->rx_queues_to_use;
 	u8 tx_channels_count = priv->plat->tx_queues_to_use;
@@ -3423,6 +3579,17 @@ static int stmmac_init_dma_engine(struct stmmac_priv *priv)
 		netdev_err(priv->dev, "Failed to reset the dma\n");
 		return ret;
 	}
+	stmmac_dma_reset_complete(priv);
+	priv->dma_reset_needed = false;
+
+	if (reinit || priv->datapath == STMMAC_DATAPATH_SUSPENDED) {
+		/* Suspend only requested a stop. Do not modify its descriptors
+		 * or release pending TX buffers until this reset has completed.
+		 */
+		ret = stmmac_reinit_dma_desc(priv);
+		if (ret)
+			return ret;
+	}
 
 	/* DMA Configuration */
 	stmmac_dma_init(priv, priv->ioaddr, priv->plat->dma_cfg);
@@ -3773,6 +3940,8 @@ static bool stmmac_tso_channel_permitted(struct stmmac_priv *priv,
 /**
  * stmmac_hw_setup - setup mac in a usable state.
  *  @dev : pointer to the device structure.
+ *  @reinit: rebuild retained descriptor rings after the DMA reset
+ *  @keep_ptp: restore the registered PHC's configuration before starting DMA
  *  Description:
  *  this is the main function to setup the HW in a usable state because the
  *  dma engine is reset, the core registers are configured (e.g. AXI,
@@ -3782,7 +3951,7 @@ static bool stmmac_tso_channel_permitted(struct stmmac_priv *priv,
  *  0 on success and an appropriate (-)ve integer as defined in errno.h
  *  file on failure.
  */
-static int stmmac_hw_setup(struct net_device *dev)
+static int stmmac_hw_setup(struct net_device *dev, bool reinit, bool keep_ptp)
 {
 	struct stmmac_priv *priv = netdev_priv(dev);
 	u8 rx_cnt = priv->plat->rx_queues_to_use;
@@ -3804,7 +3973,7 @@ static int stmmac_hw_setup(struct net_device *dev)
 	phylink_rx_clk_stop_block(priv->phylink);
 
 	/* DMA initialization and SW reset */
-	ret = stmmac_init_dma_engine(priv);
+	ret = stmmac_init_dma_engine(priv, reinit);
 	if (ret < 0) {
 		phylink_rx_clk_stop_unblock(priv->phylink);
 		netdev_err(priv->dev, "%s: DMA engine initialization failed\n",
@@ -3896,6 +4065,15 @@ static int stmmac_hw_setup(struct net_device *dev)
 		stmmac_enable_tbs(priv, priv->ioaddr, enable, chan);
 	}
 
+	if (keep_ptp) {
+		ret = stmmac_restore_timestamping(priv);
+		if (ret)
+			return ret;
+		ret = stmmac_setup_est(priv);
+		if (ret)
+			return ret;
+	}
+
 	phylink_rx_clk_stop_block(priv->phylink);
 	stmmac_set_hw_vlan_mode(priv, priv->hw);
 	phylink_rx_clk_stop_unblock(priv->phylink);
@@ -4255,6 +4433,7 @@ stmmac_setup_dma_desc(struct stmmac_priv *priv, unsigned int mtu)
 			   __func__);
 		return ERR_PTR(-ENOMEM);
 	}
+	list_add_tail(&dma_conf->list, &priv->dma_confs);
 
 	len = mtu + ETH_HLEN + 2 * VLAN_HLEN + ETH_FCS_LEN;
 
@@ -4305,9 +4484,8 @@ stmmac_setup_dma_desc(struct stmmac_priv *priv, unsigned int mtu)
 	return dma_conf;
 
 init_error:
-	free_dma_desc_resources(priv, dma_conf);
 alloc_error:
-	kfree(dma_conf);
+	stmmac_put_dma_conf(priv, dma_conf);
 	return ERR_PTR(ret);
 }
 
@@ -4402,6 +4580,57 @@ static int stmmac_resume_hw(struct stmmac_priv *priv)
 	return 0;
 }
 
+/* NAPI, transmitters and IRQ handlers have already been drained. Clearing
+ * ST/SR only requests a stop: the current frame may still access memory.
+ * Keep the configuration DMA-owned unless hardware acknowledges idle/reset.
+ */
+static void stmmac_drain_dma(struct stmmac_priv *priv)
+{
+	struct stmmac_dma_conf *dma_conf;
+	int ret;
+
+	if (priv->hw_unavailable)
+		return;
+	stmmac_stop_all_dma(priv);
+	stmmac_mac_set(priv, priv->ioaddr, false);
+	if (!stmmac_dma_busy(priv))
+		return;
+
+	/* A failed replacement may have programmed a different topology. Only
+	 * a global reset can acknowledge all of those retired configurations.
+	 */
+	list_for_each_entry(dma_conf, &priv->dma_confs, list)
+		if (dma_conf != priv->dma_conf && dma_conf->dma_owned)
+			goto reset;
+
+	ret = stmmac_dma_wait_idle(priv, priv->ioaddr);
+	if (!ret) {
+		priv->dma_conf->dma_owned = false;
+		return;
+	}
+
+	/* Some integrations do not expose a usable idle indication. Reset is
+	 * also the fallback after a stop timeout. It needs the PHY RX clock,
+	 * even though phylink has already stopped link resolution.
+	 */
+reset:
+	phylink_prepare_resume(priv->phylink);
+	mutex_lock(&priv->ptp_mutex);
+	stmmac_block_ptp(priv, true);
+	priv->dma_reset_needed = true;
+	phylink_rx_clk_stop_block(priv->phylink);
+	ret = stmmac_prereset_configure(priv);
+	if (!ret)
+		ret = stmmac_reset(priv);
+	phylink_rx_clk_stop_unblock(priv->phylink);
+	if (!ret)
+		stmmac_dma_reset_complete(priv);
+	else
+		netdev_err(priv->dev, "DMA shutdown failed: %pe; retaining DMA memory\n",
+			   ERR_PTR(ret));
+	mutex_unlock(&priv->ptp_mutex);
+}
+
 /**
  *  __stmmac_open - open entry point of the driver
  *  @dev : pointer to the device structure.
@@ -4433,7 +4662,7 @@ static int __stmmac_open(struct net_device *dev,
 
 	stmmac_reset_queues_param(priv);
 
-	ret = stmmac_hw_setup(dev);
+	ret = stmmac_hw_setup(dev, false, false);
 	if (ret < 0) {
 		netdev_err(priv->dev, "%s: Hw setup failed\n", __func__);
 		goto init_error;
@@ -4487,8 +4716,9 @@ static int __stmmac_open(struct net_device *dev,
 	 * phylink_start(). Keep the PHY attachment and outer PM ownership.
 	 */
 	phylink_stop(priv->phylink);
-	stmmac_stop_all_dma(priv);
-	stmmac_mac_set(priv, priv->ioaddr, false);
+	stmmac_drain_dma(priv);
+	/* Reset fallback may have powered the stopped PHY up for its clock. */
+	phylink_stop(priv->phylink);
 	return ret;
 }
 
@@ -4532,7 +4762,7 @@ static int stmmac_open(struct net_device *dev)
 	if (ret)
 		goto err_serdes;
 
-	kfree(old_conf);
+	stmmac_put_dma_conf(priv, old_conf);
 
 	/* We may have called phylink_speed_down before */
 	phylink_speed_up(priv->phylink);
@@ -4547,8 +4777,7 @@ static int stmmac_open(struct net_device *dev)
 	pm_runtime_put(priv->device);
 err_dma_resources:
 	priv->dma_conf = old_conf;
-	free_dma_desc_resources(priv, dma_conf);
-	kfree(dma_conf);
+	stmmac_put_dma_conf(priv, dma_conf);
 	return ret;
 }
 
@@ -4595,23 +4824,19 @@ static void __stmmac_release(struct net_device *dev)
 	/* Free the IRQ lines */
 	stmmac_free_irq(dev, REQ_IRQ_ERR_ALL, 0);
 
-	/* TX error IRQs can restart a queue after the first quiescence. */
+	/* Drain any final IRQ-triggered network activity before DMA shutdown. */
 	stmmac_stop_tx_queues(priv);
+	if (!priv->hw_unavailable && stmmac_fpe_supported(priv))
+		ethtool_mmsv_stop(&priv->fpe_cfg.mmsv);
 
-	/* Stop TX/RX DMA after draining IRQ handlers which can restart it. */
-	if (!priv->hw_unavailable) {
-		stmmac_stop_all_dma(priv);
-		/* Link resolution need not have reached mac_link_up() yet. */
-		stmmac_mac_set(priv, priv->ioaddr, false);
-	}
+	/* Only confirmed hardware shutdown permits releasing DMA memory. */
+	stmmac_drain_dma(priv);
+	phylink_stop(priv->phylink);
 
 	/* Release and free the Rx/Tx resources */
 	free_dma_desc_resources(priv, priv->dma_conf);
 
 	stmmac_release_ptp(priv);
-
-	if (!priv->hw_unavailable && stmmac_fpe_supported(priv))
-		ethtool_mmsv_stop(&priv->fpe_cfg.mmsv);
 }
 
 /**
@@ -6541,8 +6766,7 @@ static int stmmac_change_mtu(struct net_device *dev, int new_mtu)
 		ret = __stmmac_open(dev, dma_conf);
 		if (ret) {
 			priv->dma_conf = old_conf;
-			free_dma_desc_resources(priv, dma_conf);
-			kfree(dma_conf);
+			stmmac_put_dma_conf(priv, dma_conf);
 			/*
 			 * Keep the administrative state and PHY/PM ownership until
 			 * ndo_stop(), but prevent use of the released data path.
@@ -6552,7 +6776,7 @@ static int stmmac_change_mtu(struct net_device *dev, int new_mtu)
 			return ret;
 		}
 
-		kfree(old_conf);
+		stmmac_put_dma_conf(priv, old_conf);
 
 		stmmac_set_rx_mode(dev);
 		netif_device_attach(dev);
@@ -7473,24 +7697,19 @@ void stmmac_xdp_release(struct net_device *dev)
 	/* Free the IRQ lines */
 	stmmac_free_irq(dev, REQ_IRQ_ERR_ALL, 0);
 	stmmac_stop_tx_queues(priv);
+	if (stmmac_fpe_supported(priv))
+		ethtool_mmsv_stop(&priv->fpe_cfg.mmsv);
 
-	/* Stop TX/RX DMA channels */
-	stmmac_stop_all_dma(priv);
+	stmmac_drain_dma(priv);
 
 	/* Release and free the Rx/Tx resources */
 	free_dma_desc_resources(priv, priv->dma_conf);
 
-	/* Disable the MAC Rx/Tx */
-	stmmac_mac_set(priv, priv->ioaddr, false);
-
 	/* set trans_start so we don't get spurious
 	 * watchdogs during reset
 	 */
 	netif_trans_update(dev);
 
-	if (stmmac_fpe_supported(priv))
-		ethtool_mmsv_stop(&priv->fpe_cfg.mmsv);
-
 	/* Keep PTP across the immediately following stmmac_xdp_open(). That
 	 * function releases it if reopening fails, before returning DOWN.
 	 */
@@ -7508,6 +7727,14 @@ int stmmac_xdp_open(struct net_device *dev)
 	u8 chan;
 	int ret;
 
+	/* The old rings cannot be overwritten after a failed shutdown. Pool
+	 * removal still completes, with their mappings held independently.
+	 */
+	if (stmmac_dma_busy(priv)) {
+		ret = -EBUSY;
+		goto dma_desc_error;
+	}
+
 	ret = alloc_dma_desc_resources(priv, priv->dma_conf);
 	if (ret < 0) {
 		netdev_err(dev, "%s: DMA descriptors allocation failed\n",
@@ -7523,6 +7750,21 @@ int stmmac_xdp_open(struct net_device *dev)
 	}
 
 	stmmac_reset_queues_param(priv);
+	if (priv->dma_reset_needed) {
+		phylink_prepare_resume(priv->phylink);
+		mutex_lock(&priv->ptp_mutex);
+		ret = stmmac_hw_setup(dev, false, true);
+		if (!ret)
+			stmmac_block_ptp(priv, false);
+		mutex_unlock(&priv->ptp_mutex);
+		if (ret) {
+			stmmac_drain_dma(priv);
+			goto init_error;
+		}
+		stmmac_set_rx_mode(dev);
+		stmmac_vlan_restore(priv);
+		goto setup_timers;
+	}
 
 	/* DMA CSR Channel configuration */
 	for (chan = 0; chan < dma_csr_ch; chan++) {
@@ -7559,15 +7801,17 @@ int stmmac_xdp_open(struct net_device *dev)
 
 		if (tx_q->tbs & STMMAC_TBS_AVAIL)
 			stmmac_enable_tbs(priv, priv->ioaddr, 1, chan);
-
-		hrtimer_setup(&tx_q->txtimer, stmmac_tx_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
 	}
 
 	/* Enable the MAC Rx/Tx */
 	stmmac_mac_set(priv, priv->ioaddr, true);
 
-	/* Start Rx & Tx DMA Channels */
+setup_timers:
+	/* The reset path has also restored filters, PTP and the EST schedule. */
 	stmmac_start_all_dma(priv);
+	for (chan = 0; chan < tx_cnt; chan++)
+		hrtimer_setup(&priv->dma_conf->tx_queue[chan].txtimer,
+			      stmmac_tx_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
 
 	ret = stmmac_request_irq(dev);
 	if (ret)
@@ -7584,8 +7828,7 @@ int stmmac_xdp_open(struct net_device *dev)
 
 irq_error:
 	stmmac_stop_tx_queues(priv);
-	stmmac_stop_all_dma(priv);
-	stmmac_mac_set(priv, priv->ioaddr, false);
+	stmmac_drain_dma(priv);
 
 init_error:
 	free_dma_desc_resources(priv, priv->dma_conf);
@@ -7715,7 +7958,7 @@ static void stmmac_reset_subtask(struct stmmac_priv *priv)
 	netdev_err(priv->dev, "Reset adapter.\n");
 
 	rtnl_lock();
-	if (!netif_device_present(priv->dev))
+	if (!netif_device_present(priv->dev) || !netif_running(priv->dev))
 		goto out_unlock;
 
 	netif_trans_update(priv->dev);
@@ -8016,12 +8259,11 @@ static int stmmac_reopen(struct net_device *dev)
 	ret = __stmmac_open(dev, dma_conf);
 	if (ret) {
 		priv->dma_conf = old_conf;
-		free_dma_desc_resources(priv, dma_conf);
-		kfree(dma_conf);
+		stmmac_put_dma_conf(priv, dma_conf);
 		return ret;
 	}
 
-	kfree(old_conf);
+	stmmac_put_dma_conf(priv, old_conf);
 	netif_device_attach(dev);
 	return 0;
 }
@@ -8056,6 +8298,8 @@ int stmmac_reinit_queues(struct net_device *dev, u8 rx_cnt, u8 tx_cnt)
 		netif_device_detach(dev);
 		__stmmac_release(dev);
 	}
+	if (stmmac_dma_busy(priv))
+		return -EBUSY;
 
 	stmmac_set_queues(dev, rx_cnt, tx_cnt);
 
@@ -8083,6 +8327,8 @@ int stmmac_reinit_ringparam(struct net_device *dev, u32 rx_size, u32 tx_size)
 		netif_device_detach(dev);
 		__stmmac_release(dev);
 	}
+	if (stmmac_dma_busy(priv))
+		return -EBUSY;
 
 	priv->dma_conf->dma_rx_size = rx_size;
 	priv->dma_conf->dma_tx_size = tx_size;
@@ -8268,8 +8514,20 @@ EXPORT_SYMBOL_GPL(stmmac_plat_dat_alloc);
 static void stmmac_free_dma_conf(void *data)
 {
 	struct stmmac_priv *priv = data;
+	struct stmmac_dma_conf *dma_conf, *next;
 
-	kfree(priv->dma_conf);
+	list_for_each_entry_safe(dma_conf, next, &priv->dma_confs, list) {
+		list_del(&dma_conf->list);
+		/* A permanently unresponsive device must not DMA into recycled
+		 * memory, even on unbind. There is no generic isolation mechanism
+		 * for all stmmac integrations. Deliberately retain these allocations.
+		 */
+		if (dma_conf->dma_owned) {
+			dev_err(priv->device, "DMA still active on removal; DMA memory quarantined\n");
+			continue;
+		}
+		kfree(dma_conf);
+	}
 }
 
 static int __stmmac_dvr_probe(struct device *device,
@@ -8296,10 +8554,12 @@ static int __stmmac_dvr_probe(struct device *device,
 	priv = netdev_priv(ndev);
 	priv->device = device;
 	priv->dev = ndev;
+	INIT_LIST_HEAD(&priv->dma_confs);
 	/* Keep ring sizes and per-queue settings even while the device is down. */
 	priv->dma_conf = kzalloc_obj(*priv->dma_conf);
 	if (!priv->dma_conf)
 		return -ENOMEM;
+	list_add_tail(&priv->dma_conf->list, &priv->dma_confs);
 	ret = devm_add_action_or_reset(device, stmmac_free_dma_conf, priv);
 	if (ret)
 		return ret;
@@ -8624,12 +8884,28 @@ void stmmac_dvr_remove(struct device *dev)
 {
 	struct net_device *ndev = dev_get_drvdata(dev);
 	struct stmmac_priv *priv = netdev_priv(ndev);
+	struct stmmac_dma_conf *dma_conf;
+	u32 queue;
 
 	netdev_info(priv->dev, "%s: removing driver", __func__);
 
 	pm_runtime_get_sync(dev);
 
 	unregister_netdev(ndev);
+	rtnl_lock();
+	/* A failed ndo_open has no matching ndo_stop. Its retained resources
+	 * still need retirement, or software-only disconnection on timeout.
+	 */
+	list_for_each_entry(dma_conf, &priv->dma_confs, list) {
+		free_dma_desc_resources(priv, dma_conf);
+		for (queue = 0; queue < MTL_MAX_RX_QUEUES; queue++) {
+			struct xdp_rxq_info *rxq = &dma_conf->rx_queue[queue].xdp_rxq;
+
+			if (xdp_rxq_info_is_reg(rxq))
+				xdp_rxq_info_unreg(rxq);
+		}
+	}
+	rtnl_unlock();
 
 #ifdef CONFIG_DEBUG_FS
 	stmmac_exit_fs(ndev);
@@ -8872,12 +9148,7 @@ int stmmac_resume(struct device *dev)
 
 	mutex_lock(&priv->lock);
 
-	stmmac_reset_queues_param(priv);
-
-	stmmac_free_tx_skbufs(priv);
-	stmmac_clear_descriptors(priv, priv->dma_conf);
-
-	ret = stmmac_hw_setup(ndev);
+	ret = stmmac_hw_setup(ndev, false, false);
 	if (ret < 0) {
 		netdev_err(priv->dev, "%s: Hw setup failed\n", __func__);
 		goto error_stop_dma;

-- 
2.53.0

