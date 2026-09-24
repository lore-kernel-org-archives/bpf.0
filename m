Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04A134A21
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 12:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790253286; cv=none; b=giU0vMSmdfFgQwx1AHKqikEm3YjQxoKyG/j+TU6fjnW5rEKn6jBNwS6+TnmvJbqDbLokaIiHs0JhMFBy1zb5RE1fnZ89JPMyxXkdmeOyLrC8F2oqftx9W7lrVix6ajd8KkvPVVhGsjlESsV/FrfN4loURPQn0rnnNpXRrdfCeh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790253286; c=relaxed/simple;
	bh=hjMZl/g2eoOhnTT7kJwVKNA9u2VQfs2qMlZIoR417J0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=iJZIWvWr9Qc1CkqdiyCq3erYTCCs0eSDWo0DED4TeI8MIaoGuiLQPwddSmVoiR+i9IqDjbKcQIkgcNbC283gmWPfPBdhkTEsESSsUDtWSHMP9oOmv0tLpEEDOcQ3stgbueYeBLgjdizNFgfGHHP0vS3sw3Hzqkos6VgpC7ZDDAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NRJSdYBn; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Gc65U0jQ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NRJSdYBn";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Gc65U0jQ"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68OC4wlw2002331
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 12:34:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=hAWT8Ciayk6jCv1TOsDfit
	ytwzy27gxf+SVO9yuGpAY=; b=NRJSdYBni0Cyjcjl9wIjsZhuKkyZr3AGesJg8r
	e9VPo5AMy7W4hnNkMyacnRmAeckXxmmu7CSQT8uBhKiHcFg0PKf6OYgnni22CzGx
	BXRqQiUjVYzO0Y4ZJv3ohuK2rdLo4e4d8UqSTqcCEo8j/KUyC1sZqa0OvkLvZ/x0
	kh+usyFvh0BWC0HQt/L53itfWTbBiFaxs2wwALHbI8ELZWU+aqvKQllUmRq4hQnd
	WBFYpqxYz7XYnM5XVRcTbDaNu/hnSDG3Oh9AlwCXRdw7ocF+lurYM8jhmtcH/hmc
	TWcg1LC7VC09LARiFjFw8H7XZXIDZvxLaGjCvNXvUJANL5uw==
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com [209.85.217.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gvmrrbhcu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 12:34:43 +0000 (GMT)
Received: by mail-vs1-f71.google.com with SMTP id ada2fe7eead31-79129463bb2so640070137.0
        for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 05:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790253283; x=1790858083; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=hAWT8Ciayk6jCv1TOsDfitytwzy27gxf+SVO9yuGpAY=;
        b=Gc65U0jQ0AEPX8zPJE6ptzTR3WXLAH14Z1SnvOr3dydN/7xAaMhVQS7hFVhknsm6+5
         eVwurMIo+2uiP5NxBYs1GeOCSawiF/B8EDBfpkCFQy7YzdmIJ/n0qBIaDtJHTDqmEMqF
         H0VqkAQjkvuJasEqQe4lecFDOPLNHndG7LK8XohhY9Ih51L9DW0XiI2pFa6SlnwS7bJ6
         3rx55mRo3ynlGxJk2cOfQwaOtipc9vX3CSM1ewAZ7ckj0bRIduMAKHPlDMs5yuW2biSQ
         2vPlZO6VJ3TNJhIHJ6sehWTxKG+lI0r6hMyHIWIzpOqKiW8mIAR5VWfyknR55IB87KJX
         PuHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790253283; x=1790858083;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=hAWT8Ciayk6jCv1TOsDfitytwzy27gxf+SVO9yuGpAY=;
        b=AyACQBMjOxNk8M2jP+MuqE7IhbY407DeB1v/GRn+Y12JeBwVA97qIeMLyKNb8xN4e2
         wuW2XZza5kQ7VFT+rslBMXgaQcLMgkZ67owutb5R/lUMbkUMhT77tob/dXMH11Y5iwei
         NMET8kJvtf7ARoj138x25yYrh5YFsoXCuzctu52GaAmttK3pKdFFjc4Gb/PV3CaKdRSu
         xAWHrgi2BZBxrB/HEi1SI1HwKTyQutbZVXtfYYLhh/utpqG319eEUm/3whgJj2onEKLw
         tSoSus1teTaUdS93KUvTd2dzdSv0sGeTmSAe7UK4sVRfmKbSM1Ff8Yu9JA7TdLKO+B+R
         OJTw==
X-Forwarded-Encrypted: i=1; AKwUvBxKN3UCc158tFMngleWnOpnSWeA47pjA2eHoyaDS0c7R0SNXFcAFPnY+BhFGv8xLvIqJPQ=@vger.kernel.org
X-Gm-Message-State: AFuF++klSj8OWjoqQ9dna+u96PGXeq21yo+WQ7J3KXGUjrSgppiS+eIQ
	YUDrjS0haG0Z55qoMyt32RGiQrO+nSKF6qVZi2sptJv8itf1nd1rxAXreV0UKpzDh1Hv0HlEJyl
	sNdnrl+U+rGUL9aJSXs+CMJxDf+KLPLuLlHDGWOVFqEnlA1f6nc4a3D4=
X-Gm-Gg: AYBFou3IwoL88M1hSBp2WiqtXtFZfOo7xZxaro9nN4uHdcvKLhVnBPn0+E9bMabPX9N
	JAwV3Sc9erHAxxnciByVegkRMQmeJQaS8+W8SErHdIVxjFFPglEuV9NvzG6Zwl/LbiZYMXSuhbM
	qj9PMJacMQeVFzwIS5O7aL/FepnCdD744HewaNjYD65tcbdthW8Ak8tHgA+HdJGRSoW9tgAYIYh
	B0ZyPIptSNKUi8xgmjTgOWFBPO2YE96lpGEYPIkYRYh8Kh3lKP0w552ldztTBSFScK8YjNVNfYL
	mh1h4ZXMQ1xG1L4UMpRSEKBiSjPRyqdHTe/mgD7wTGDRdjkTPZ+xwFJrPpR5wO8+c1tG73tgQav
	HbRPpYJhdRWpXQQ==
X-Received: by 2002:a05:6102:e10:b0:790:c7bb:43fd with SMTP id ada2fe7eead31-7af1c58e8a4mr986336137.8.1790253282711;
        Thu, 24 Sep 2026 05:34:42 -0700 (PDT)
X-Received: by 2002:a05:6102:e10:b0:790:c7bb:43fd with SMTP id ada2fe7eead31-7af1c58e8a4mr986317137.8.1790253282074;
        Thu, 24 Sep 2026 05:34:42 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-488682673bdsm14309616f8f.2.2026.09.24.05.34.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 05:34:41 -0700 (PDT)
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Date: Thu, 24 Sep 2026 14:34:18 +0200
Subject: [PATCH net-next v2] net: stmmac: add XDP multi-buff support for TX
 side
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260924-b4-stmmac-xmit-mb-v2-1-003347b7bc25@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/22NwQrCMBBEf0X27JZmjW315H9ID0nc2oBJNImlU
 vrvhuLRy8BjmDcLJI6WE5x3C0SebLLBF6D9Dsyo/J3R3goD1dTUJyLUElN2Thmcnc3oNGrddlw
 3nTSDhLJ7Rh7svDmv4Dmj5zlDX5rRphziZzubxNb/vIc/3kmgQNUKJcyRSEi6hJSq11s9THCuK
 gH9uq5fmb0dGcMAAAA=
X-Change-ID: 20260922-b4-stmmac-xmit-mb-bb78e0684cf4
To: Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Stanislav Fomichev <sdf@fomichev.me>
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org,
        Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDA1MiBTYWx0ZWRfXxrw2YCJcRX06
 3M00btPndptdux6k33a9mW/Hcwdbuw7r82KNON6bkXFMwZERHV5f6CWhTNkYxaoAh1l2+IySG2B
 Sp6Ula9NsRsONAKWNkxvM3TA6Fu/AWdr5XOGJb16/m7U1faDkl+48pFA897L41IrowIDsylucCq
 elPkjFhny9lHX4WiMG4EMERt5cFdyCQzgtBGHbuxowW1zQoFADtrRk6sm/lU1xL3OD+XGb2qfJT
 axfDSP9Yu6VQWaxm1QiXWo9S1nQMHKULbbVmQI8sWBjo8P7IP7BX0DZQSthaUpzcbYiNV1h4W+j
 Q7Rt7w0ERam5v8R0pwhTqVcyLGCBUpgN9Fq9DWrNiYOPWKn6BN0DZtCTEEgYBHxdfvLtDFxVD6r
 5OvHTZY2IUIEkphitPYAUS4cMoJzPWXeci//BNHqk9Oe3CRDKApp+NRp25LQH8dhYBLoATTwLcN
 T3EDrykTqVLXCCR3aqg==
X-Authority-Analysis: v=2.4 cv=TYwDJhQh c=1 sm=1 tr=0 ts=6ab518e3 cx=c_pps
 a=P2rfLEam3zuxRRdjJWA2cw==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=r9eGS2uEWaK6AkG2OsoA:9 a=QEXdDO2ut3YA:10
 a=ODZdjJIeia2B_SHc_B0f:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDA1MiBTYWx0ZWRfX0IK+sYRCzAh+
 Wd58qluXEGPWbkNhzGt18piqApkpDdf44svzkB/oNwEpls8hUme9aIhf+lMqRhmCABQNBYIz77x
 cIZsVXER67hB8d8+o6CgptkZSlnATzA=
X-Proofpoint-GUID: bEvrIis_8cHBr_-EWMsg2Nqjj06g-zMN
X-Proofpoint-ORIG-GUID: bEvrIis_8cHBr_-EWMsg2Nqjj06g-zMN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-24_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 phishscore=0 spamscore=0 lowpriorityscore=0
 bulkscore=0 clxscore=1015 adultscore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609240052

Extend stmmac_xdp_xmit_xdpf() to transmit XDP frames with fragments
(multi-buff). Each buffer, i.e. the frame head and every frag, is mapped
and programmed into a dedicated TX descriptor.

Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
---
Changes in v2:
- Fix Tx coalescing logic in stmmac_xdp_xmit_xdpf()
- Consider the max between STMMAC_TX_THRESH() and num_frames as
  threshold in stmmac_xdp_xmit_xdpf().
- Link to v1: https://lore.kernel.org/r/20260923-b4-stmmac-xmit-mb-v1-1-a71a1c522142@oss.qualcomm.com
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 126 ++++++++++++++--------
 1 file changed, 83 insertions(+), 43 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index bf9e7e4cb1c3..089281ef9e61 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -5239,77 +5239,117 @@ static unsigned int stmmac_rx_buf2_len(struct stmmac_priv *priv,
 static int stmmac_xdp_xmit_xdpf(struct stmmac_priv *priv, int queue,
 				struct xdp_frame *xdpf, bool dma_map)
 {
-	struct stmmac_txq_stats *txq_stats = &priv->xstats.txq_stats[queue];
+	struct skb_shared_info *sinfo = xdp_get_shared_info_from_frame(xdpf);
 	struct stmmac_tx_queue *tx_q = &priv->dma_conf.tx_queue[queue];
 	bool csum = !priv->plat->tx_queues_cfg[queue].coe_unsupported;
+	unsigned int txq_thr = STMMAC_TX_THRESH(priv);
+	unsigned int first_entry = tx_q->cur_tx;
 	unsigned int entry = tx_q->cur_tx;
-	enum stmmac_txbuf_type buf_type;
-	struct dma_desc *tx_desc;
-	dma_addr_t dma_addr;
-	bool set_ic;
+	unsigned int num_frames = 1;
+	struct dma_desc *desc;
+	int i = 0;
 
-	if (stmmac_tx_avail(priv, queue) < STMMAC_TX_THRESH(priv))
+	if (unlikely(xdp_frame_has_frags(xdpf)))
+		num_frames += sinfo->nr_frags;
+
+	if (stmmac_tx_avail(priv, queue) < max(num_frames, txq_thr))
 		return STMMAC_XDP_CONSUMED;
 
 	if (priv->est && priv->est->enable &&
 	    priv->est->max_sdu[queue] &&
-	    xdpf->len > priv->est->max_sdu[queue]) {
+	    xdp_get_frame_len(xdpf) > priv->est->max_sdu[queue]) {
 		priv->xstats.max_sdu_txq_drop[queue]++;
 		return STMMAC_XDP_CONSUMED;
 	}
 
-	tx_desc = stmmac_get_tx_desc(priv, tx_q, entry);
-	if (dma_map) {
-		dma_addr = dma_map_single(priv->device, xdpf->data,
-					  xdpf->len, DMA_TO_DEVICE);
-		if (dma_mapping_error(priv->device, dma_addr))
-			return STMMAC_XDP_CONSUMED;
-
-		buf_type = STMMAC_TXBUF_T_XDP_NDO;
-	} else {
-		struct page *page = virt_to_page(xdpf->data);
-
-		dma_addr = page_pool_get_dma_addr(page) + sizeof(*xdpf) +
-			   xdpf->headroom;
-		dma_sync_single_for_device(priv->device, dma_addr,
-					   xdpf->len, DMA_BIDIRECTIONAL);
+	while (true) {
+		skb_frag_t *frag = i ? &sinfo->frags[i - 1] : NULL;
+		int len = frag ? skb_frag_size(frag) : xdpf->len;
+		bool last_frame = i == num_frames - 1;
+		enum stmmac_txbuf_type buf_type;
+		dma_addr_t dma_addr;
 
-		buf_type = STMMAC_TXBUF_T_XDP_TX;
-	}
+		desc = stmmac_get_tx_desc(priv, tx_q, entry);
+		if (dma_map) {
+			if (frag)
+				dma_addr = skb_frag_dma_map(priv->device,
+							    frag, 0, len,
+							    DMA_TO_DEVICE);
+			else
+				dma_addr = dma_map_single(priv->device,
+							  xdpf->data, len,
+							  DMA_TO_DEVICE);
+			if (dma_mapping_error(priv->device, dma_addr))
+				goto error_dma_unmap;
 
-	stmmac_set_tx_dma_entry(tx_q, entry, buf_type, dma_addr, xdpf->len,
-				false);
-	stmmac_set_tx_dma_last_segment(tx_q, entry);
+			buf_type = STMMAC_TXBUF_T_XDP_NDO;
+		} else {
+			struct page *page;
 
-	tx_q->xdpf[entry] = xdpf;
+			page = frag ? skb_frag_page(frag)
+				    : virt_to_page(xdpf->data);
+			dma_addr = page_pool_get_dma_addr(page);
+			if (frag)
+				dma_addr += skb_frag_off(frag);
+			else
+				dma_addr += sizeof(*xdpf) + xdpf->headroom;
+			dma_sync_single_for_device(priv->device, dma_addr,
+						   len, DMA_BIDIRECTIONAL);
+			buf_type = STMMAC_TXBUF_T_XDP_TX;
+		}
 
-	stmmac_set_desc_addr(priv, tx_desc, dma_addr);
+		stmmac_set_tx_dma_entry(tx_q, entry, buf_type, dma_addr, len,
+					dma_map && frag);
+		stmmac_set_desc_addr(priv, desc, dma_addr);
+		stmmac_prepare_tx_desc(priv, desc, !i, len, csum,
+				       priv->descriptor_mode, !!i, last_frame,
+				       xdp_get_frame_len(xdpf));
+		tx_q->xdpf[entry] = last_frame ? xdpf : NULL;
+		if (last_frame) {
+			stmmac_set_tx_dma_last_segment(tx_q, entry);
+			break;
+		}
 
-	stmmac_prepare_tx_desc(priv, tx_desc, 1, xdpf->len,
-			       csum, priv->descriptor_mode, true, true,
-			       xdpf->len);
+		entry = STMMAC_NEXT_ENTRY(entry, priv->dma_conf.dma_tx_size);
+		i++;
+	}
+	tx_q->tx_count_frames += num_frames;
 
-	tx_q->tx_count_frames++;
+	if (priv->tx_coal_frames[queue] &&
+	    (tx_q->tx_count_frames % priv->tx_coal_frames[queue]) < num_frames) {
+		struct stmmac_txq_stats *txq_stats;
 
-	if (tx_q->tx_count_frames % priv->tx_coal_frames[queue] == 0)
-		set_ic = true;
-	else
-		set_ic = false;
-
-	if (set_ic) {
+		desc = stmmac_get_tx_desc(priv, tx_q, entry);
+		stmmac_set_tx_ic(priv, desc);
 		tx_q->tx_count_frames = 0;
-		stmmac_set_tx_ic(priv, tx_desc);
+
+		txq_stats = &priv->xstats.txq_stats[queue];
 		u64_stats_update_begin(&txq_stats->q_syncp);
 		u64_stats_inc(&txq_stats->q.tx_set_ic_bit);
 		u64_stats_update_end(&txq_stats->q_syncp);
 	}
 
+	/* Set the OWN bit on the first descriptor now that all descriptors
+	 * for this skb are populated.
+	 */
+	desc = stmmac_get_tx_desc(priv, tx_q, first_entry);
+	stmmac_set_tx_owner(priv, desc);
+	tx_q->cur_tx = STMMAC_NEXT_ENTRY(entry, priv->dma_conf.dma_tx_size);
 	stmmac_enable_dma_transmission(priv, priv->ioaddr, queue);
 
-	entry = STMMAC_NEXT_ENTRY(entry, priv->dma_conf.dma_tx_size);
-	tx_q->cur_tx = entry;
-
 	return STMMAC_XDP_TX;
+
+error_dma_unmap:
+	while (first_entry != entry) {
+		desc = stmmac_get_tx_desc(priv, tx_q, first_entry);
+		stmmac_release_tx_desc(priv, desc, priv->descriptor_mode);
+		stmmac_free_tx_buffer(priv, &priv->dma_conf, queue,
+				      first_entry);
+		first_entry = STMMAC_NEXT_ENTRY(first_entry,
+						priv->dma_conf.dma_tx_size);
+	}
+
+	return STMMAC_XDP_CONSUMED;
 }
 
 static int stmmac_xdp_get_tx_queue(struct stmmac_priv *priv,

---
base-commit: 1c85ea5df86bed136589a2866c22f394020d3fdf
change-id: 20260922-b4-stmmac-xmit-mb-bb78e0684cf4

Best regards,
-- 
Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>

