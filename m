Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.72.3
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793113625;
	b=rXcnk+GfBnZOxvgbhhE8e2V1IdWFiZxT+CCFBsFw0lMZcJo9YNR+EMdaa2PLanNwISrn
	 YQmuQnMvgUgVHEegTJfM4tzotxEdE+scm1LmfIg3wKpPVyw7am8XDisd4NzpZjcE9UPSg
	 iLjD0I35M39txX+Q8MeTGz8UWASjQeiEQcvWufTl4wk96Tw4yHNJ54tmphjkQZ/4wbgPT
	 5lS0tG4U5RQxvWxM+MuAqsVjLJ+mLI/0chCN9UdXhB2mkv/g5MZ0B9HJjbskNksdmNIJ9
	 ymjfahyTthvORV2Yy0SSl83R5R5zQbP+e/iDb45PWG9vEoURsrA4/LMpEtu2CU87v4g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793113625;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:Content-Type:
	 X-Originating-IP:X-ClientProxiedBy:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=ef+5QiXjgOgYRxWhtr5Pf1hnaNoPslQuqmd0dWf3cMo=;
	b=zj2lHBFJy8qCvB+Npmtv+EjCwcBTynb7cs4RVK7fY64kA2z0fBE+e3FrxFifyCFQrcs8
	 AApzeHYV51a1UzR0v3l2acqU2oNIyEqZWKXnZFQyRQB0EfbvTB0WgsoxN/Fem1Hc7e6zB
	 Et5fl95tQctbIAWZO697TDSLw99SRwGnDORxvbU80NpfFVO/nzLoc/OYwn5WB2TQJ3ZKS
	 p8vyWEdcBpobaV/saiXtZLxmIMWJcGcA4l/6Zc3ahXoCyb0uvkV6e3vh26vDxBgcEx95C
	 rmD+INd1p+u48OqYHpOVTwu6O+CQiiFjABNc5ZOiaIXIM+lOzghdVJjt05JGii6ud/w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=foss.st.com;
	spf=pass smtp.mailfrom=foss.st.com;
	dkim=pass header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=G5EuOI7m;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.72.3
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013003.outbound.protection.outlook.com [52.101.72.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C47D3606A31A;
	Tue, 27 Oct 2026 15:07:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C47D3606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=G5EuOI7m
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h1SvEmnRiSG/hRgmHomeVMNngw/wAXs9BKmxB0Q6emCfKubQzqT9UQGDntsyjg+AIkSKMjOSzwfoGxeM25FvbUu/GDiTHjkekYJ1vPM5d6XkNZl9pF/9wzAwaoFT7UqzYfu1o79H2qncX73BtrVxwGqKWe2ZUWyT9ZFI/H7hRg+ukyBmO+jX0mdxS1k5dCHC/hz4XdPk45eoGs7YfHCKihaMhMR4vEckHJl+qsG4ou38hMrG9Od83zXpOBzLzW5oGqu5mrj75J0sTU1XNlsQVfJ/fNxWebWbZryEtoJ4byqsHolEPNVJIVeO6YHKxMfdRwZRKz88ej2fJ5rphO2Zfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ef+5QiXjgOgYRxWhtr5Pf1hnaNoPslQuqmd0dWf3cMo=;
 b=aDf3i6Ez4+H6Fqu2fmd+oLiRf3CAVRI952oXu05jUx1EP2jQ9zmd54FKHKb8WviS84r1dtgIRV0Y4zGsKzCLofFvuzMrPc1KEPD7CQvjeWqthEwfydRsoxkKg+IMor2IxBl5gcqaTMsLcZ+PR/uSz07anyCaRJ0zx+RWbS7JDLK6mStZNfCiVDTsCTjw67xeoTTP0JA2UJSQVhMQwqzuhLogf6tfsKQteNv3TeLt14lzgntP8FthdU5BhSuJ/o5/ucHxCj2+lkOr2jssnXQCxQNKSq5tGoHiIj49ECAtJo6eWo6ZpwbPsPbSO+QBM4KhRB9HVl5epzO5PjPnCf/PsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=bootlin.com smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ef+5QiXjgOgYRxWhtr5Pf1hnaNoPslQuqmd0dWf3cMo=;
 b=G5EuOI7mZQvFz6bYKo93+vZxgs68FyGMNlTvQEjvxbSeaA+b7+53iMaRJg3cW0i2sV56ZYQK0qVzLgGuVWEkol4Rv9V9BZWzaQFS+RjifTXkKeCmIflEGJxgQkGzBVzpBx+bkjdO+8th4B7rgpMqmdResHeS2XroANGEGNjs+LyGGA+Op7Lu4GHE4IhuGYLMYr79jU+XtV/T6poawnBu6hbftI3dGO+7WmuidHc6PS2Pts5tZb66Y+P/OL+1vKPVeUoxZwa46nZxmfP4uA/augPw2deLeAtETuevL+tAurfbUcRPVEWMZ/6fwUDssiEtgdt6TZky7NlMS3GVclEacA==
Received: from PR3P191CA0041.EURP191.PROD.OUTLOOK.COM (2603:10a6:102:55::16)
 by PAVPR10MB7114.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:318::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.7; Tue, 27 Oct
 2026 15:07:00 +0000
Received: from MI3PEPF00008555.eurprd05.prod.outlook.com
 (2603:10a6:102:55:cafe::69) by PR3P191CA0041.outlook.office365.com
 (2603:10a6:102:55::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.22 via Frontend Transport; Tue,
 27 Oct 2026 15:07:00 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 164.130.1.60) smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 MI3PEPF00008555.mail.protection.outlook.com (10.167.240.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Tue, 27 Oct 2026 15:07:00 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 27 Oct
 2026 16:07:20 +0100
Received: from localhost (10.48.86.230) by STKDAG1NODE1.st.com (10.75.128.132)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 27 Oct
 2026 16:06:39 +0100
From: Thomas Bourgoin <thomas.bourgoin@foss.st.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, "Alexandre
 Torgue" <alexandre.torgue@foss.st.com>, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer
	<hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, "Stanislav
 Fomichev" <sdf@fomichev.me>, Lorenzo Bianconi
	<lorenzo.bianconi@oss.qualcomm.com>, Christophe Roullier
	<christophe.roullier@foss.st.com>
CC: <netdev@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<bpf@vger.kernel.org>, Thomas Bourgoin <thomas.bourgoin@foss.st.com>
Subject: [PATCH 1/1] net: stmmac: rebuild RX descriptors before restarting DMA on resume
Date: Tue, 27 Oct 2026 16:05:56 +0100
Message-ID: <20261027150556.51209-2-thomas.bourgoin@foss.st.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261027150556.51209-1-thomas.bourgoin@foss.st.com>
References: <20261027150556.51209-1-thomas.bourgoin@foss.st.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE1.st.com
 (10.75.128.132)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MI3PEPF00008555:EE_|PAVPR10MB7114:EE_
X-MS-Office365-Filtering-Correlation-Id: 7fa953c8-89aa-483a-1538-08df343bf373
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|23010399003|376014|7416014|1800799024|18002099003|22082099003|921020|11063799006|5023799004|56012099006|261026140227099003|261021121427099003|10067099003|261021123027099003|261009221227099003|261009223327099003|261009223027099003|261009220027099003|261009221727099003|261022105027099003|261022075727099003;
X-Microsoft-Antispam-Message-Info:
	nR9G1MpjPthTxpaMBrpvrllt/35j5VQlNeWvtr5CY2PU5ym7wivAGkawI8bF4uKwQu8MAirpcfF9+9dAyNU2S3jIHicf40ifAVphX47RhlpVlDJCMdt1dHwgAIdWN+HNJpCxjcDjA9v24uu7cOHuNLVXkCDC8z0M3dUrxP7HKYNEgD78b2QF/1yOgAG/rj6kklvjqyeydP5IK9+NOzKqlPMt6BAvaFbiMAAofYCA/9G4TqY2td29ZAy6scrH1JwaBk2TSV6YHQpKhrzSXRrTigNXbD5/OxhGr14hY+yS+yUixXFLyQsC1k25YtVvUzbQjNlXG+EOivF/ArXuQMira6elLLETcL/a3XRvsfMsiTKSSWPzcqhIUx8Hsrjl80oXgJ9TJd6oiUPnlHrFaK/5v5nJTFvarURasb1yGbHdfcfdmHEhx0vuXE4oP/NrwPCCn9FWuOXmPpWx276FupESkWvmyQxuAXfwZ1xyw8y3u5YgoFn80uxCp9iaqgsWre8ibbdlmRhvOtufAPTKO3motD+pZa7COMN33wcb2EoWHRzSgKrb1q7Jf4leehd4E5oKEI6/DA64EKNf3j2hsGi3HBd+hAQz1jZIMn28fCVhM27j4ILx9Pl7VqoTZnzfOz/z9Hr+fKXxA7W9FmICHrU0K4cfdQT2TI385HfxTgJ1R2cZHL3myP45GMsLviNmnuSE3jHqZ32BjqOkWMdBUOR+FrW3hyye1awKTboC2M7fbtUUJARNF3GTxTvEHwhOfvHA
X-Forefront-Antispam-Report:
	CIP:164.130.1.60;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(23010399003)(376014)(7416014)(1800799024)(18002099003)(22082099003)(921020)(11063799006)(5023799004)(56012099006)(261026140227099003)(261021121427099003)(10067099003)(261021123027099003)(261009221227099003)(261009223327099003)(261009223027099003)(261009220027099003)(261009221727099003)(261022105027099003)(261022075727099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	5rvPoeIca6UFUHYapw0CLefQRdxrC1LTwD2tG4yPW1HOE2+GhR8nF3ElIgaDamVA942qxtGeXyDhJU3cKXn+KoX78NAmH/Fpofank4Xbm9xvFSrYHAmJowyq2UGGg1pw1A6mqK0VHJCn4gwia5JVcAkM/ACmrJmO4E6tbCDjX2j3QiyIUxq3NB4Jyy2vbt5x65tuomA3l7gjcH1h15m/cq7TcsChXoLNAumnzXd3QEpyV6lz18na/7oqigD9D+SrcOoK6nWFl1blSqPUg32F+FiFoZtdNeCRFbFEp+qoUew/c6VeMNT1zVuabgBewTYZiEeLTW5gB1KgfXcu/HlON4cXLNP5YghCJB0lO4hR1itJbg1xPc0S6t/Lk99+XxVos/TptIbJbkZALTIVw5oFQ1F+byb1QLmOxxgAqncthzgJCghR2SJf1bJ416YWzbDv
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 15:07:00.1265
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fa953c8-89aa-483a-1538-08df343bf373
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.60];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MI3PEPF00008555.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR10MB7114

An RX descriptor can be written back by the DMA before suspend without
being processed by NAPI. Its buffer address fields then contain receive
status rather than DMA addresses.

On resume, stmmac_clear_descriptors() returns RX descriptors to the DMA
without restoring their buffer addresses. On DWMAC4, the DMA will
therefore consider a descriptor for the application as one for the DMA.
This can lead to illegal access from the DMA anywhere.
For example, on STM32MP21 the DMA address bus is 40 bits, thus the
extended status from the write-back descriptor is read as an high
address by the DMA. DMA will then try to write in the DDR at 0x100000000
whereas on STM32MP215f-dk DDR is only 2Gb from 0x8000 0000 to
0xffff ffff and nothing is mapped at 0x100000000.

To fix this, reconstruct the entire RX ring before rearming descriptors
and restarting the DMA. Reuse existing buffers, allocate missing ones,
and restore their DMA addresses independently of the saved RX producer
and consumer indices. Reset the queue indices only after descriptor
reconstruction succeeds.

Update stmmac_init_rx_buffers() to preserve an existing split-header
secondary page and restore its DMA address. Fold TX buffer cleanup into
the descriptor resume helper before clearing the TX descriptors.

Signed-off-by: Thomas Bourgoin <thomas.bourgoin@foss.st.com>
---
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 86 +++++++++++++++----
 1 file changed, 68 insertions(+), 18 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 9ded31150fbe..198629265c90 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -1700,8 +1700,10 @@ static int stmmac_init_rx_buffers(struct stmmac_priv *priv,
 		buf->page_offset = stmmac_rx_offset(priv);
 	}
 
-	if (stmmac_rx_check_buf2_cap(priv) && !buf->sec_page) {
-		buf->sec_page = page_pool_alloc_pages(rx_q->page_pool, gfp);
+	if (stmmac_rx_check_buf2_cap(priv)) {
+		if (!buf->sec_page)
+			buf->sec_page = page_pool_alloc_pages(rx_q->page_pool,
+							      gfp);
 		if (!buf->sec_page)
 			return -ENOMEM;
 
@@ -2149,19 +2151,6 @@ static void dma_free_tx_skbufs(struct stmmac_priv *priv,
 	}
 }
 
-/**
- * stmmac_free_tx_skbufs - free TX skb buffers
- * @priv: private structure
- */
-static void stmmac_free_tx_skbufs(struct stmmac_priv *priv)
-{
-	u8 tx_queue_cnt = priv->plat->tx_queues_to_use;
-	u8 queue;
-
-	for (queue = 0; queue < tx_queue_cnt; queue++)
-		dma_free_tx_skbufs(priv, &priv->dma_conf, queue);
-}
-
 /**
  * __free_dma_rx_desc_resources - free RX dma desc resources (per queue)
  * @priv: private structure
@@ -8425,6 +8414,63 @@ static void stmmac_reset_rx_queue(struct stmmac_priv *priv, u32 queue)
 	rx_q->dirty_rx = 0;
 }
 
+static int stmmac_resume_rx_descriptors(struct stmmac_priv *priv,
+					struct stmmac_dma_conf *dma_conf,
+					u32 queue)
+{
+	struct stmmac_rx_queue *rx_q = &dma_conf->rx_queue[queue];
+	int i;
+	int ret;
+
+	for (i = 0; i < dma_conf->dma_rx_size; i++) {
+		struct dma_desc *p = stmmac_get_rx_desc(priv, rx_q, i);
+		struct stmmac_rx_buffer *buf = &rx_q->buf_pool[i];
+		dma_addr_t dma_addr;
+
+		if (rx_q->xsk_pool) {
+			if (!buf->xdp) {
+				buf->xdp = xsk_buff_alloc(rx_q->xsk_pool);
+				if (!buf->xdp)
+					return -ENOMEM;
+				}
+			dma_addr = xsk_buff_xdp_get_dma(buf->xdp);
+			stmmac_set_desc_addr(priv, p, dma_addr);
+			stmmac_set_desc_sec_addr(priv, p, 0, false);
+		} else {
+			ret = stmmac_init_rx_buffers(priv, dma_conf, p, i,
+						     GFP_KERNEL, queue);
+			if (ret)
+				return ret;
+		}
+	}
+
+	return 0;
+}
+
+static int stmmac_resume_descriptors(struct stmmac_priv *priv,
+				     struct stmmac_dma_conf *dma_conf)
+{
+	u32 rx_queue_cnt = priv->plat->rx_queues_to_use;
+	u32 tx_queue_cnt = priv->plat->tx_queues_to_use;
+	u32 queue;
+	int ret;
+
+	for (queue = 0; queue < rx_queue_cnt; queue++) {
+		ret = stmmac_resume_rx_descriptors(priv, dma_conf, queue);
+		if (ret)
+			return ret;
+
+		stmmac_clear_rx_descriptors(priv, dma_conf, queue);
+	}
+
+	for (queue = 0; queue < tx_queue_cnt; queue++) {
+		dma_free_tx_skbufs(priv, &priv->dma_conf, queue);
+		stmmac_clear_tx_descriptors(priv, dma_conf, queue);
+	}
+
+	return 0;
+}
+
 static void stmmac_reset_tx_queue(struct stmmac_priv *priv, u32 queue)
 {
 	struct stmmac_tx_queue *tx_q = &priv->dma_conf.tx_queue[queue];
@@ -8507,10 +8553,14 @@ int stmmac_resume(struct device *dev)
 
 	mutex_lock(&priv->lock);
 
-	stmmac_reset_queues_param(priv);
+	ret = stmmac_resume_descriptors(priv, &priv->dma_conf);
+	if (ret < 0) {
+		netdev_err(priv->dev, "%s: Resume descriptor failed\n",
+			   __func__);
+		goto error_unlock;
+	}
 
-	stmmac_free_tx_skbufs(priv);
-	stmmac_clear_descriptors(priv, &priv->dma_conf);
+	stmmac_reset_queues_param(priv);
 
 	ret = stmmac_hw_setup(ndev);
 	if (ret < 0) {
-- 
2.43.0

