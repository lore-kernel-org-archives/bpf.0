Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE7873D905F
	for <bpf@vger.kernel.org>; Fri,  1 May 2026 15:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777650892; cv=none; b=d8mBewGNbxu/HtdUh2ija9oAl8r2+ga4PahtJ3BaWzqzX/x3ItBUhBvufhROSHcFwARPos8iyKretKPefiDJDEMU+SK+E8e8urDYDSbtiY/cg2TLhCTT7AQD4hqel0b+vFGH/nQv+jqmqWWtxQf2nRyvMU/ddlYHM3cGVitpyzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777650892; c=relaxed/simple;
	bh=9daJEeYnL/520gIUs2ya+tNWpekA/4sc3weLpZydFsA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tGhM9yLG5vxIJ1eR3NcXxaBfzy7Mibm0QFBjlUth77z6aK/OBn3fvWhCTZBGdrw7evcCk2vUxWUzFNRFbteBObffngfuKXEVqAAVDqDxje6OR7Tl7VtCbxB/GoiH7jTMCMOXSWYZprABUEa0zdLDCdDfguqMC78PmzaEYsltwwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b=OrjKZ4BA; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="OrjKZ4BA"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-8b5cda2dab9so3445366d6.0
        for <bpf@vger.kernel.org>; Fri, 01 May 2026 08:54:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1777650888; x=1778255688; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IjvnjhHrTVfCoXWYYCjuP2ueQSiOCln/+g460j3fdpQ=;
        b=OrjKZ4BAjy3Ftg9XlHRlEl9gBtqn2ck5LmClDYn6M1br5cggYvJA5YFATjlgPYkBIp
         B2/iCfj61qsYpAgBmrmvpMEJ2yV0S6FTM9JwcpxWhvKgEtL7vtU8aLYcgRf+aozQ/xDk
         j5ms8JvOqz+txUikawOUcyd6j+2cJjPnfS3Lq+7TaGbkmF2rxE7pxtpIZO1A2pXfBiVJ
         Oq+cFL6Ujnh5rLfCvN9FN5xObTvDQWaNLOAPz2MSvCtSTjSm8xKgpBAghSFrEmt0kM5h
         913a6wO6GcnHWkC9Vnr9bzv8E4NcGb6ODo49+q7z8oqCFIvxuBLQJdoC1xyo4PCXhGDN
         nRZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777650888; x=1778255688;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IjvnjhHrTVfCoXWYYCjuP2ueQSiOCln/+g460j3fdpQ=;
        b=DOBMPq1jweSIkGu+w8TqiuC1t376gqTuvxSP8Soswmu/QyYXXkXDS4NF9dgmQfu1EL
         wE74nzaVbrwlfuvFhzDlh1fH1ptLuAcadh5s9qYd2lvhF0x41i7YDJr7KUpah5/h5gah
         9jBHAdlFNOFcw5gZeUW0T0B6Owws8pTgt53fcvHTS3cn4qZVg3v7K3AJNP6REvOsuffW
         LQAlYw+ZXknNj9xnyBCJFeU3nLwSvLFwZiHMJxF+FmuqZCV/wx7H7GKaEn8YP3nTQBEp
         naZCt3UYPVI7s1lykmkgk9FTJ+dO7BX1+A7CDsjlzojQUfE8LXGSAXk6pxV2qzPm9zrh
         +7Pw==
X-Forwarded-Encrypted: i=1; AFNElJ+QG+UwmiyaWVcn2hHYYWHyw4jg/QO3nSUhIwOJeA8+rglBLcJgzvQr6PYsiYLHdfcMLBw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxM8JafeGQR/ut4uEPXgbiiXfVaETWkGXgLZmihR2DENY2P47G2
	en9BlHItCcnvvDSPPCulcQfg33YZ34CBt+MTkkKP0fS5dSZmFTUQY10MlocCZKskNz0=
X-Gm-Gg: AeBDievu4F0yKcUSax5TUasBMcoeDdINatmXKLIO2ydE4mlzlkvRMMiKCg/ewKlKo12
	ji9EzAhVfaIW2x0aq9wa9P6tA9xce49LBiqEVw+e1twbEXM9NY2/oTrm/1XJ7GM0D/6YGDqH0Ll
	eVpaQTtl6kl/+0zWgsN6XIbhhyplR8Xwj1em3joUDfsLAGfp4Gc9c7ZBsmY8iZu+uUCBDnjoo1M
	sWxI3uZuQaUg9820df6syY75MSiqmgTbgstPOO2DmDqNkz3K7YmG4GoXvp9QC9eseBmkE8XMmLY
	9yTt5jp0AjfBhvgZzTzep1VRyWwXMfBnRnQQlqgWudwQjWPtq/NgptNIZKrYGX3OH3WpRO4ndPz
	zegTlrcENvRCguO0nsFKf5+xqrBth57x5AWf6DvbZ6tD85I6GOFCQbgVCihzZnRvwhtip9fS7LW
	7qk/g/Jxaob2tddbPToWXEhRwzp49HJnNCCQifFl8UBGeLE4T3WR35UUDRD7QOlYAxbpBePiDBP
	Dzj4w==
X-Received: by 2002:a05:6214:3d12:b0:899:fdeb:6ace with SMTP id 6a1803df08f44-8b400081541mr103035466d6.23.1777650887865;
        Fri, 01 May 2026 08:54:47 -0700 (PDT)
Received: from zippy.localdomain (c-75-72-117-212.hsd1.mn.comcast.net. [75.72.117.212])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b539aa7293sm26615406d6.22.2026.05.01.08.54.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2026 08:54:47 -0700 (PDT)
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
Subject: [PATCH net-next 06/12] net: stmmac: dwxgmac2: Add XGMAC 3.01a support
Date: Fri,  1 May 2026 10:54:14 -0500
Message-ID: <20260501155421.3329862-7-elder@riscstar.com>
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

XGMAC 2.x and 3.x are architecturally very similar.  That means that
for everything except one erratum we can simply use the XGMAC 2.x
callback functions in the stmmac_dma_ops structure.

Only the set_rx_ring_len callback is specific to XGMAC 3.01.  It
limits the number of outstanding write requests that can be serviced
per DMA.

The other erratum addressed in this patch is simply a comment to
ensure that a feature that stmmac doesn't currently use is not enabled
without contemplating the errata.

Signed-off-by: Daniel Thompson <daniel@riscstar.com>
Signed-off-by: Alex Elder <elder@riscstar.com>
---
 .../net/ethernet/stmicro/stmmac/dwxgmac2.h    |  3 ++
 .../ethernet/stmicro/stmmac/dwxgmac2_dma.c    | 52 +++++++++++++++++++
 2 files changed, 55 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
index 9b0b5cc619556..bcf59ad8a1939 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
@@ -374,6 +374,8 @@
 #define XGMAC_DMA_CH_RxDESC_TAIL_LPTR(x)	(0x0000312c + (0x80 * (x)))
 #define XGMAC_DMA_CH_TxDESC_RING_LEN(x)		(0x00003130 + (0x80 * (x)))
 #define XGMAC_DMA_CH_RxDESC_RING_LEN(x)		(0x00003134 + (0x80 * (x)))
+#define XGMAC_OWRQ			GENMASK(25, 24)
+#define XGMAC_RDRL			GENMASK(15, 0)
 #define XGMAC_DMA_CH_INT_EN(x)		(0x00003138 + (0x80 * (x)))
 #define XGMAC_NIE			BIT(15)
 #define XGMAC_AIE			BIT(14)
@@ -463,6 +465,7 @@
 extern const struct stmmac_ops dwxgmac210_ops;
 extern const struct stmmac_ops dwxlgmac2_ops;
 extern const struct stmmac_dma_ops dwxgmac210_dma_ops;
+extern const struct stmmac_dma_ops dwxgmac301_dma_ops;
 extern const struct stmmac_desc_ops dwxgmac210_desc_ops;
 
 #endif /* __STMMAC_DWXGMAC2_H__ */
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
index a84601ac32153..dc2897e9931d1 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
@@ -38,6 +38,14 @@ static void dwxgmac2_dma_init(void __iomem *ioaddr,
 		value = u32_replace_bits(value, XGMAC_INTM_MODE1,
 					 XGMAC_INTM_MASK);
 
+	/*
+	 * A friendly warning to future adventurers. If Descriptor Posted
+	 * Write support, which is off by default, is ever enabled then be sure
+	 * to make it optional. This is required by errata for at least XGMAC
+	 * 3.01A... and the XGMAC 2.x and 3.x are architecturally similar so we
+	 * use dwxgmac2 support for the 3.x family as well.
+	 */
+
 	writel(value, ioaddr + XGMAC_DMA_MODE);
 }
 
@@ -490,6 +498,20 @@ static void dwxgmac2_set_rx_ring_len(struct stmmac_priv *priv,
 	writel(len, ioaddr + XGMAC_DMA_CH_RxDESC_RING_LEN(chan));
 }
 
+static void dwxgmac301_set_rx_ring_len(struct stmmac_priv *priv,
+				       void __iomem *ioaddr, u32 len, u32 chan)
+{
+	u32 val = FIELD_PREP(XGMAC_RDRL, len);
+
+	/*
+	 * Reduce the number of outstanding write requests to 3 (from default
+	 * of 4). This is an errata workaround for XGMAC 3.01a.
+	 */
+	val |= FIELD_PREP(XGMAC_OWRQ, 3);
+
+	writel(val, ioaddr + XGMAC_DMA_CH_RxDESC_RING_LEN(chan));
+}
+
 static void dwxgmac2_set_tx_ring_len(struct stmmac_priv *priv,
 				     void __iomem *ioaddr, u32 len, u32 chan)
 {
@@ -619,3 +641,33 @@ const struct stmmac_dma_ops dwxgmac210_dma_ops = {
 	.enable_sph = dwxgmac2_enable_sph,
 	.enable_tbs = dwxgmac2_enable_tbs,
 };
+
+const struct stmmac_dma_ops dwxgmac301_dma_ops = {
+	.reset = dwxgmac2_dma_reset,
+	.init = dwxgmac2_dma_init,
+	.init_chan = dwxgmac2_dma_init_chan,
+	.init_rx_chan = dwxgmac2_dma_init_rx_chan,
+	.init_tx_chan = dwxgmac2_dma_init_tx_chan,
+	.axi = dwxgmac2_dma_axi,
+	.dump_regs = dwxgmac2_dma_dump_regs,
+	.dma_rx_mode = dwxgmac2_dma_rx_mode,
+	.dma_tx_mode = dwxgmac2_dma_tx_mode,
+	.enable_dma_irq = dwxgmac2_enable_dma_irq,
+	.disable_dma_irq = dwxgmac2_disable_dma_irq,
+	.start_tx = dwxgmac2_dma_start_tx,
+	.stop_tx = dwxgmac2_dma_stop_tx,
+	.start_rx = dwxgmac2_dma_start_rx,
+	.stop_rx = dwxgmac2_dma_stop_rx,
+	.dma_interrupt = dwxgmac2_dma_interrupt,
+	.get_hw_feature = dwxgmac2_get_hw_feature,
+	.rx_watchdog = dwxgmac2_rx_watchdog,
+	.set_rx_ring_len = dwxgmac301_set_rx_ring_len,
+	.set_tx_ring_len = dwxgmac2_set_tx_ring_len,
+	.set_rx_tail_ptr = dwxgmac2_set_rx_tail_ptr,
+	.set_tx_tail_ptr = dwxgmac2_set_tx_tail_ptr,
+	.enable_tso = dwxgmac2_enable_tso,
+	.qmode = dwxgmac2_qmode,
+	.set_bfsize = dwxgmac2_set_bfsize,
+	.enable_sph = dwxgmac2_enable_sph,
+	.enable_tbs = dwxgmac2_enable_tbs,
+};
-- 
2.51.0

