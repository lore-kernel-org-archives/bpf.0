Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6ACB3D88F9
	for <bpf@vger.kernel.org>; Fri,  1 May 2026 15:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777650888; cv=none; b=oYxamK6z8ksf/Fm3K4BKQn2rCcx/cyULgLKDHUK5QT1rkMYO1sbLmFVy/q7CMiSyOKXonPGwyb7OoDyRsgrjSuXzNClJ2yq1LShKWsl6PppQ8UeVAl0iFO14Eab7qRGKVMPiycaQUkX42vEeX1zthky16w7hyiVnmR6NUEL0ahg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777650888; c=relaxed/simple;
	bh=rWJMdH+guxvVRg/fYfPqNZhV8vkxgoYK2GCfMJpBrRQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tkyOm5Zfc85eV/+x1t43/ZAS9+v1J0/qkcrRw/PDShZ1sYrcFMLBzn/+m9stm2Vo07cybEEc32H5IN65mVqxDb44/JfvboBp6RMnNWvCmrIm2p3QDpFoXafz45cg01FRiME7hSDSoxolyhIrO63R8Xfwj+tK/HKIMXXUHlpcuDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b=U/FsVG6P; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="U/FsVG6P"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-50d6b9bca48so26156611cf.2
        for <bpf@vger.kernel.org>; Fri, 01 May 2026 08:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1777650886; x=1778255686; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lJZ0RqgIk8/DP02YY4aEMI6Gbsvdjs3yNWLkzeFClOw=;
        b=U/FsVG6PzyZt6PaiHwol1aUL60lqQbkzo/5IRLlwPh/F+u9Q6oJpp406tWYXgCB5xq
         2sOnKYSK1tZTXw1E7WCFzXPVm2984ZKyN2dKc2NcleWjXoKRc67HNhuPjRWkR5c/HH5D
         uOXdYVzfHdC5rkwrDRvQ4VaZyRh/McRSXU0l5usj1yR8wLlrs/r1gx2KZvNrztV3Sxbs
         1WhLNM4+MITbHZRfcCAa9dM8esWiT4DIbxkPmd1n/WD2sDyc4NJzhH/4ALY7goLcCPUx
         3eOQm8sSfdHkdcl8Oj6UFDiE8EP7YAuN1Jrd6S9c5W+2SKmVTaCFJ6n7AfqrjeiIb8SM
         x++A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777650886; x=1778255686;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lJZ0RqgIk8/DP02YY4aEMI6Gbsvdjs3yNWLkzeFClOw=;
        b=pr1WLaPeD3vP1Ko6+c2sNFpsbzvMpuDi0B1fW6muK5PENUEX9Z7j3ooKF0qvgu8SsG
         Ttwqrn33oAxAOa0GCsn6W+VRVCw6j1BeMbenkPK/RbiN4yywK515NgEgSjf54OHJpKVO
         vBrf/NrpuZ/sqxx72e/AkrMsm3cnKPaWpBTHfznE006FN409NiD36WlUb4611ii46Xrf
         M7PG0Sy1XCAERrs9sWPvsHTDv/Qs9fNDQuuQ2HdOEg6j1Kp/rtqqTplrNfr6n6qiCfeS
         uIgDB2MKTL9VCIp73iRgjsDVKtr2jM5nRHaMCtqKrwqM4HCfC5TTK+XtAODD/EoKP/jS
         /t7w==
X-Forwarded-Encrypted: i=1; AFNElJ9w098wN3whd+SKEedVAkLGubAxOwo73JLOXXniiw6vyp2SE1+6Oj15EY205xPzL0modT4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJ7RWK7thBu5T5EZzZorz/LRCzRSTH7TKF01piAHuoW4q5oMnY
	f6ppf+6FcOmEjDxzH05YzCGipziHNPi7MI087X2vOhYJ9Wsv28CWoRBMaVf1SsfohF0=
X-Gm-Gg: AeBDieuPWyW4S2qXcE4ro6iFnN5B0SfJFjzKh3h1YvKA5h5EYr4STP6XOAUN8ajlmZm
	/piUPx956bIAC6MW6Y2EQ9aywtVwXN8IpYNfTUO+48L4qXdhNXTtNloAcr9K48T52N3/ZMU8p6M
	lyLSZ252kyvMSK/7TJnzoXJGy7JXCJtbvGujUViG3b/VybKoFe9dJdLgtwQ1YnyU67TIH5TibNm
	BAjA6UT3a605bagGPQ7O1Rh35gvl6zitmD2hlS5/w0RMfzJ+2/XfORljkRQIgSNGRmIS6d8N0iq
	0k3ICymoOODPenbkRoDr0C5OgMuHiXRtDiI+AL1ra+re/pVil6nfzacsciXV6kHy5A9gmuz2f00
	SsdhHzH2jdzuBx7AmLCFoqEm5+Wxn9WCRaXcGzdv6U+i9mzljbECYAXTtrgj0JQ4E8FYTwZEoWI
	6DcKOQVP5TSg2ExRSIP+H7Hcu9CsXBEcyQOD/bVVKG5acZ3l0smaKxOBYGpEiSq0XELrBDvMS82
	BrKQA==
X-Received: by 2002:ac8:5d07:0:b0:50b:6b21:2bf7 with SMTP id d75a77b69052e-5102a940d0amr119383461cf.0.1777650884691;
        Fri, 01 May 2026 08:54:44 -0700 (PDT)
Received: from zippy.localdomain (c-75-72-117-212.hsd1.mn.comcast.net. [75.72.117.212])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b539aa7293sm26615406d6.22.2026.05.01.08.54.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2026 08:54:44 -0700 (PDT)
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
Subject: [PATCH net-next 05/12] net: stmmac: dwxgmac2: Add multi MSI interrupt mode
Date: Fri,  1 May 2026 10:54:13 -0500
Message-ID: <20260501155421.3329862-6-elder@riscstar.com>
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

Currently there are no XGMAC platforms integrated using the multi MSI
interrupt mode. In other words no existing driver sets both
DWMAC_CORE_XGMAC and STMMAC_FLAG_MULTI_MSI_EN.

In order to support systems that do enable both options (such as the
Toshiba TC9564 whose driver is currently being developed) we need to
add logic to the XGMAC DMA callbacks. Happily we can simply
replicate similar code from GMAC4. Let's do that!

Signed-off-by: Daniel Thompson <daniel@riscstar.com>
Signed-off-by: Alex Elder <elder@riscstar.com>
---
 drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h     | 2 ++
 drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c | 8 ++++++++
 2 files changed, 10 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
index 51943705a2b03..9b0b5cc619556 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
@@ -320,6 +320,8 @@
 /* DMA Registers */
 #define XGMAC_DMA_MODE			0x00003000
 #define XGMAC_SWR			BIT(0)
+#define XGMAC_INTM_MASK			GENMASK(13, 12)
+#define XGMAC_INTM_MODE1		0x1
 #define XGMAC_DMA_SYSBUS_MODE		0x00003004
 #define XGMAC_WR_OSR_LMT		GENMASK(29, 24)
 #define XGMAC_RD_OSR_LMT		GENMASK(21, 16)
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
index 03437f1cf3df3..a84601ac32153 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
@@ -31,6 +31,14 @@ static void dwxgmac2_dma_init(void __iomem *ioaddr,
 		value |= XGMAC_EAME;
 
 	writel(value, ioaddr + XGMAC_DMA_SYSBUS_MODE);
+
+	value = readl(ioaddr + XGMAC_DMA_MODE);
+
+	if (dma_cfg->multi_msi_en)
+		value = u32_replace_bits(value, XGMAC_INTM_MODE1,
+					 XGMAC_INTM_MASK);
+
+	writel(value, ioaddr + XGMAC_DMA_MODE);
 }
 
 static void dwxgmac2_dma_init_chan(struct stmmac_priv *priv,
-- 
2.51.0

