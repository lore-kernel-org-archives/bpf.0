Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBD963DC4B3
	for <bpf@vger.kernel.org>; Fri,  1 May 2026 15:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777650893; cv=none; b=mMWbuM8iyhCkK1nu2JH5ey+gsiSywHKTIOZvR121zmy7q6mTF5FTPw3HHa7OY5Xk/KxmeXsl2F0aQvEJGDsmtJ5SYqMzHN0x/5zGa9ljUMaMNY7Qt7rv3phbDYcl3lfIquGAG1oaeDfG+c7nPx0mk3AimNszVwOqvVJ9cEBT4/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777650893; c=relaxed/simple;
	bh=sdVoEALgUHLLwTph3KA4x290Mapqipjj87aWWehudsk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VsoZ+ktdSv/uKi7mU1VGt3Hcq1djHnAw8WO44b3RYo/dLAgHoWXJ6GIPhDO8cEczVPglBK5/PQlYYfh1XIrOz1oOL9ws0FkIj/FdiIHqkCkPfAX6TjOMfdJERVxx+M7yIfbIHutibPKmaCUD96xswW8F1VGVF2k33MH/GHedxgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b=JOF3DMg8; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="JOF3DMg8"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-8a210c813f8so13842986d6.0
        for <bpf@vger.kernel.org>; Fri, 01 May 2026 08:54:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1777650891; x=1778255691; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8RGGmioeApSW4Mpcfugq/UHupyYC8IBT0gCB0CxHGJA=;
        b=JOF3DMg8AnITnSLlbsITV4GJ1SJJXvN9eI9iCkMITDyCW+wnTUiLDdq8H2hw2FvvXG
         7S1HiDJU/lzu2K2f/ojbj2+nWLRfN/tT5I7m5lHza+oUD8hngS2Y/iJQTcvCbTlFSgwR
         OL+OPBVwgma0zHpy10xiFDnrDiFCltTE8VE7VGLNXuYwTtF+QcQA8qUcZCZwfj2JK9pi
         lKJ30zHs18eNlEfs3+MnlxBFZ3jg8dvjcxa1K0z82pDmC+1A1+UHLzQ1V9HgHnzwoUtD
         6yWYAjJ9P5oaRhQPwo1gZde9rjg4jPacD/sdMLQjSjJo32qudwdvDx+YBjQ7sgGbsMPV
         sUzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777650891; x=1778255691;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8RGGmioeApSW4Mpcfugq/UHupyYC8IBT0gCB0CxHGJA=;
        b=aTj3XofHnD18ioU2DuJ1/G18/8ZO6WHlgRf5GROed0LKSD4kaGgFKiRct+L6jpzcTX
         EbSAIlC8E8XWMpOokLaoj4jQ3pzU4o5t6rexbPk1T7kmR5UOH8zvspfmfcW/jNv35+wi
         x3zxtA5iuUzIgwuRdbRPRPOAYAPYh+DLIBi0z5gRy0w1ErTi2nWwPK0ATBxx9g22BRQW
         xyKw13Tic0+8XQRk4JGfi4VGUSlZjCeKEUFNCjat3dMPHIgKjkxqIDGlP+h9I7NUD9MD
         HfHwfVOtavzpEY+XjU65FF6PI6PHlAOTArVMvTgCal4e82ax7GiH1ZWskQjzuu2hePsa
         PYCg==
X-Forwarded-Encrypted: i=1; AFNElJ+mZyjIkzxuiw+j3jE3YVI699tLK3UZYEo/789j4wyMIOWQ9h6FYsQfds5stQo1OQttIEE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRwSiOgVVsNmboAg9ewaNDPYJrF8SMhvRZuYUOK9KPYww+BfMw
	P3auYlmwmxi5ovOeoSTXNZIozohGkQMH5blqokJ2Zuylzla5PdwzBN72xIIi/Q26eX0=
X-Gm-Gg: AeBDieuUH60Vzm+i3Oyqpaou6A22PEdmeOQlQ5+ziV6ICvSv+NEU8egIkwLavURFWBf
	ZVATTx2WLMtnvYoamawHo0Pt+gGXg3bT1YHiKBfPaaiiT3E55NsWpZ0MuNK40AsMF5E+lbq80Cp
	f4P7UeqktBTEk+r9tYo24DVcgw0iAsnj1FQYYnbAiziTW19njnfVZ6hwHGIC98ww7g/lumRVUs0
	RseHu8nTvlJfu6wAMon2mFXYRGXSX9QLM3lkgiJQoZPFbTI2coPYjVWNXCCUNuE7iVeUW0CDalO
	usGmedqAbWqmM7nl7Ip4tinnroMPHkLuzxUhskHkokAuzZ4PUJwqRdP7wHOviiHd3gkVA1E3cR2
	WQohws75kpAdDaD5SEdibFY5quknMs3FGNOigiZ5nj6hwxFB77WY0xfnaGPXgoX4/HeyXwQW8YJ
	dHKOvMuJRqzTsWMKtDJZcJiLndr5h6N2X6a7Uag8lIlosJBSrVXwXBycy+ZEZurzAZIuKHqeEGO
	2rVDH6wEAbLPqXq
X-Received: by 2002:a05:6214:dc3:b0:8b4:6df4:87e8 with SMTP id 6a1803df08f44-8b6699cc88fmr282706d6.49.1777650890881;
        Fri, 01 May 2026 08:54:50 -0700 (PDT)
Received: from zippy.localdomain (c-75-72-117-212.hsd1.mn.comcast.net. [75.72.117.212])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b539aa7293sm26615406d6.22.2026.05.01.08.54.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2026 08:54:50 -0700 (PDT)
From: Alex Elder <elder@riscstar.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	maxime.chevallier@bootlin.com,
	rmk+kernel@armlinux.org.uk,
	andersson@kernel.org,
	konradybcio@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linusw@kernel.org,
	brgl@kernel.org,
	arnd@arndb.de,
	gregkh@linuxfoundation.org
Cc: Daniel Thompson <daniel@riscstar.com>,
	elder@riscstar.com,
	mohd.anwar@oss.qualcomm.com,
	a0987203069@gmail.com,
	alexandre.torgue@foss.st.com,
	ast@kernel.org,
	boon.khai.ng@altera.com,
	chenchuangyu@xiaomi.com,
	chenhuacai@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	hkallweit1@gmail.com,
	inochiama@gmail.com,
	john.fastabend@gmail.com,
	julianbraha@gmail.com,
	livelycarpet87@gmail.com,
	matthew.gerlach@altera.com,
	mcoquelin.stm32@gmail.com,
	me@ziyao.cc,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	richardcochran@gmail.com,
	rohan.g.thomas@altera.com,
	sdf@fomichev.me,
	siyanteng@cqsoftware.com.cn,
	weishangjuan@eswincomputing.com,
	wens@kernel.org,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 07/12] net: stmmac: dwxgmac2: export symbols for XGMAC 3.01a DMA
Date: Fri,  1 May 2026 10:54:15 -0500
Message-ID: <20260501155421.3329862-8-elder@riscstar.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260501155421.3329862-1-elder@riscstar.com>
References: <20260501155421.3329862-1-elder@riscstar.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Daniel Thompson <daniel@riscstar.com>

Toshiba TC956x is an Ethernet-AVB/TSN bridge and is essentially a
small-and-highly-specialised SoC. Ethernet on this chip is provided
by a DesignWare XGMAC.

One consequence of the SoC-like design is that the internal AXI bus
(used by the XGMAC for DMA) maps the PCI DMA space with a non-zero base
address. This requires a translation step (happily just simple addition)
to convert the PCI DMA address to the hardware DMA address.

This is pretty funky so rather than push that translation logic into
the core driver we intend to keep that logic inside the TC956x
platform code. In order to do that we need to export a few symbols
to allow us to override some of the DMA and descriptor op tables.

FWIW this approach to overriding the ops tables is similar to the
mechanism currently found in dwmac-loongson.c (with the exception
that we have also exported a couple of functions so we don't
have to replicate their content in the TC956x platform code).

Signed-off-by: Daniel Thompson <daniel@riscstar.com>
Signed-off-by: Alex Elder <elder@riscstar.com>
---
 drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h |  7 +++++++
 .../ethernet/stmicro/stmmac/dwxgmac2_core.c    |  1 +
 .../ethernet/stmicro/stmmac/dwxgmac2_descs.c   |  1 +
 .../net/ethernet/stmicro/stmmac/dwxgmac2_dma.c | 18 ++++++++++--------
 4 files changed, 19 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
index bcf59ad8a1939..8cecde1bef8a1 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
@@ -468,4 +468,11 @@ extern const struct stmmac_dma_ops dwxgmac210_dma_ops;
 extern const struct stmmac_dma_ops dwxgmac301_dma_ops;
 extern const struct stmmac_desc_ops dwxgmac210_desc_ops;
 
+void dwxgmac2_dma_init_rx_chan(struct stmmac_priv *priv, void __iomem *ioaddr,
+			       struct stmmac_dma_cfg *dma_cfg, dma_addr_t phy,
+			       u32 chan);
+void dwxgmac2_dma_init_tx_chan(struct stmmac_priv *priv, void __iomem *ioaddr,
+			       struct stmmac_dma_cfg *dma_cfg, dma_addr_t phy,
+			       u32 chan);
+
 #endif /* __STMMAC_DWXGMAC2_H__ */
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
index f02b434bbd505..c9547dc6912a3 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
@@ -1556,6 +1556,7 @@ int dwxgmac2_setup(struct stmmac_priv *priv)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(dwxgmac2_setup);
 
 int dwxlgmac2_setup(struct stmmac_priv *priv)
 {
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_descs.c b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_descs.c
index b5f200a874840..cc67d8e1a920a 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_descs.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_descs.c
@@ -368,3 +368,4 @@ const struct stmmac_desc_ops dwxgmac210_desc_ops = {
 	.set_vlan = dwxgmac2_set_vlan,
 	.set_tbs = dwxgmac2_set_tbs,
 };
+EXPORT_SYMBOL_GPL(dwxgmac210_desc_ops);
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
index dc2897e9931d1..ec365e66276f1 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
@@ -62,10 +62,10 @@ static void dwxgmac2_dma_init_chan(struct stmmac_priv *priv,
 	writel(XGMAC_DMA_INT_DEFAULT_EN, ioaddr + XGMAC_DMA_CH_INT_EN(chan));
 }
 
-static void dwxgmac2_dma_init_rx_chan(struct stmmac_priv *priv,
-				      void __iomem *ioaddr,
-				      struct stmmac_dma_cfg *dma_cfg,
-				      dma_addr_t phy, u32 chan)
+void dwxgmac2_dma_init_rx_chan(struct stmmac_priv *priv,
+			       void __iomem *ioaddr,
+			       struct stmmac_dma_cfg *dma_cfg,
+			       dma_addr_t phy, u32 chan)
 {
 	u32 rxpbl = dma_cfg->rxpbl ?: dma_cfg->pbl;
 	u32 value;
@@ -77,11 +77,11 @@ static void dwxgmac2_dma_init_rx_chan(struct stmmac_priv *priv,
 	writel(upper_32_bits(phy), ioaddr + XGMAC_DMA_CH_RxDESC_HADDR(chan));
 	writel(lower_32_bits(phy), ioaddr + XGMAC_DMA_CH_RxDESC_LADDR(chan));
 }
+EXPORT_SYMBOL_GPL(dwxgmac2_dma_init_rx_chan);
 
-static void dwxgmac2_dma_init_tx_chan(struct stmmac_priv *priv,
-				      void __iomem *ioaddr,
-				      struct stmmac_dma_cfg *dma_cfg,
-				      dma_addr_t phy, u32 chan)
+void dwxgmac2_dma_init_tx_chan(struct stmmac_priv *priv, void __iomem *ioaddr,
+			       struct stmmac_dma_cfg *dma_cfg, dma_addr_t phy,
+			       u32 chan)
 {
 	u32 txpbl = dma_cfg->txpbl ?: dma_cfg->pbl;
 	u32 value;
@@ -93,6 +93,7 @@ static void dwxgmac2_dma_init_tx_chan(struct stmmac_priv *priv,
 	writel(upper_32_bits(phy), ioaddr + XGMAC_DMA_CH_TxDESC_HADDR(chan));
 	writel(lower_32_bits(phy), ioaddr + XGMAC_DMA_CH_TxDESC_LADDR(chan));
 }
+EXPORT_SYMBOL_GPL(dwxgmac2_dma_init_tx_chan);
 
 static void dwxgmac2_dma_axi(void __iomem *ioaddr, struct stmmac_axi *axi)
 {
@@ -671,3 +672,4 @@ const struct stmmac_dma_ops dwxgmac301_dma_ops = {
 	.enable_sph = dwxgmac2_enable_sph,
 	.enable_tbs = dwxgmac2_enable_tbs,
 };
+EXPORT_SYMBOL_GPL(dwxgmac301_dma_ops);
-- 
2.51.0

