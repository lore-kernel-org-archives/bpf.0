Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEBA24CEE4D
	for <bpf@vger.kernel.org>; Thu,  1 Oct 2026 09:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790846804; cv=none; b=COnZszdMhh016iQYshBHlSv1jA9kNlqvPqX9/vQgrW/d5XsGX0H6A7KadIliSNO1zBnXluHbmwnLzrDPzbfZwGQBKaqmd1Q7PE496t+xxKsB+jfMDMTHDmTKQg60XYwNZFCaN+PNyfgFCpry4dWj3m+FwYZ+ZMEW7de6qC5hfC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790846804; c=relaxed/simple;
	bh=e3oXcS7+K1HRYAoj42uAUlJEEBG3L+4F57mJ3fec7Xo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sG+H3y0m2u2zfGlzQexlx49Iy4upGPttVQ2d1g6ESWdGCs+6UE6m31pcGNOs0Zox/VYL3nHOCjchPoai7aETKmT/81GwK6+cfaqz3rEfYpsZGqQF50HGbqvrhHdT/tEhBKFiWVPO5U0YoNVqGNzkcy56zHKTkxIkp/FN7BFfCsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Tp2Babzk; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=cpYALioB; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Tp2Babzk";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cpYALioB"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6916xUIk1933152
	for <bpf@vger.kernel.org>; Thu, 1 Oct 2026 09:26:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4crrq+kperLPKrz6unSPTu6Yz68NeVuDjB50rFifJ1s=; b=Tp2BabzkHq9z9vYo
	q8Z0L7YolKT/pK3m+ytWofLtyiIkzRmbJt6QP19Xskob2jDb3y+zRc84q1q4CTfq
	fJHDnIk8igUspsHxKLzvfaQDzZlpIapSDqEKBNxJW5NTsCQ2JARfevP4M3GBPuFQ
	T3HeHgRHjOg8z7gSFkzY37v5oruQWIOu8EnfDEiEresi/V9i9jQns7Ce1sMBkZpj
	PjRzUn3s3wBvYWoCGXR/ze9VLaMYo7ZhA86o1rh7V95cU6j37dnBnQgpoNBOeH10
	xdbogkVk7AsMv3NAW30Wsxywah1Ivl6RSlUYsKPbtT5nCkYod6WwwlJeXp619mps
	Maz/Og==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h1jcfrpf5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Thu, 01 Oct 2026 09:26:36 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-939f3426a7cso1395327485a.0
        for <bpf@vger.kernel.org>; Thu, 01 Oct 2026 02:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790846796; x=1791451596; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4crrq+kperLPKrz6unSPTu6Yz68NeVuDjB50rFifJ1s=;
        b=cpYALioBQYVTz6yK9LEhSE/3YTIpJ1GfVbWbelAd5VtLF6pvfJ+rR0CxOtx7mNCT4Y
         k6Im+SDmv1c/eWcLXP+SdAdiuJvZWMx5NuajNjjnxcbpaH1d4N9fKdkz/mVTmlEhgLnB
         +S4R8hux4L19v6NxBvnlWMsLfkh2Ip5WquRlspCTzQPmrQvUMDGW3I1l9paIRoYV7o70
         ibfD5GvrkvIYdJr0LiYCrvpWxpJXyvNbJebpDhED1Mv5Ut42Dz+GQNpCujGcm5xoVZK3
         MROhzLrXQhlALRn2lov5gMoEhVPxwxRLj96JoEJ49jI2I8k7zPkJVlCVK80mOL1TkXIM
         Duwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790846796; x=1791451596;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4crrq+kperLPKrz6unSPTu6Yz68NeVuDjB50rFifJ1s=;
        b=1d2c0krlIac25pnUCPpGIT6lec9LmiA7DWYxktOv4quufUHiK3MavjXVOoLiAExsoZ
         BZktYrTKlJiCcXQV5OVl6o7ImIK3a52qmarJO2unYGTcXmFIYwDOXe3SyhQCrkEG4CaE
         +wmambk3E0WfkFQDPcd6hi/LiIQ+h+idGHphQRqIYlRXwpFZ0Ad+xHLQAjxh1ZJA46LV
         ySOZJQPr6vwlWrnYzW8HJOj6vxmiF74EIDB7anuyYaCDf8BH/QUv+moBl8PHn9QVHuwO
         z1Nq7tRI7fYOXPlmmuFraTxbub4jMaojYPFjXk4+X+tX2th+rLu0ePWCXVLaPBDlbp9o
         3zLw==
X-Forwarded-Encrypted: i=1; AKwUvBylI/NV3pSM5fY0PSMgdBPsYvz5glpbBy/FnuJbPlmA6YmIEefcAyFBjt5GViV31UUBvK0=@vger.kernel.org
X-Gm-Message-State: AFuF++me5uztgY/3qL5uIcWID63XJ+A/ciaPZ648inK8iEi7MAKgys57
	nX/lwdYvbWVbFaMwUiB2ts69YdLJrmIPiy6PQqqXRRD29fkhK1JkmREuAV89DgNur2WiUdPeruH
	j0eCMv4l7IvpGV8VlmTdaYbvg/e9jEHwqZfszo9K9jq4PIKfmw2SExFg=
X-Gm-Gg: AYBFou0efvGkqmNNqZ/g6mRNIBcxvrg5j5NVwKA379nmP1N9N9mPQSyaQASYjBYAr34
	8+56mojMrEvSgx1IrHStCLLVO/BA//OVorArjb7Q5EJAy+bOKs/NTpJiCyfYnc9IVw9UpJMCX4S
	Cek7hTWJEDqS7ERPLay0i2m1CUXF0QyZy+ehxV4cvtFrYnDjMr1mkAMj4W94bFpdqaVtLMUDmKL
	pF41lhuwW43njzPPzBtgflywLOqAh1GS3T7QQt8c8zjkerpw2KtX7d9B3EJD++GFTLVR/uXsrnS
	l9tziDicrXe0uGBzwLzTugh6oVOvSXHNf+choRxJTAMDXTyN0IcRJr3zSZHfoYn/+xTqqlt7D+H
	l6FNP/QjVOhvHVw==
X-Received: by 2002:a05:620a:17aa:b0:93c:73a:3996 with SMTP id af79cd13be357-93ca977a317mr742131685a.57.1790846795787;
        Thu, 01 Oct 2026 02:26:35 -0700 (PDT)
X-Received: by 2002:a05:620a:17aa:b0:93c:73a:3996 with SMTP id af79cd13be357-93ca977a317mr742129085a.57.1790846795239;
        Thu, 01 Oct 2026 02:26:35 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a01f900c23sm34817125e9.1.2026.10.01.02.26.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 02:26:33 -0700 (PDT)
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Date: Thu, 01 Oct 2026 11:26:13 +0200
Subject: [PATCH net-next v4 2/2] net: stmmac: add XDP multi-buff support
 for TX side
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261001-b4-stmmac-xmit-mb-v4-2-664e0c3eb289@oss.qualcomm.com>
References: <20261001-b4-stmmac-xmit-mb-v4-0-664e0c3eb289@oss.qualcomm.com>
In-Reply-To: <20261001-b4-stmmac-xmit-mb-v4-0-664e0c3eb289@oss.qualcomm.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Stanislav Fomichev <sdf@fomichev.me>,
        Ong Boon Leong <boon.leong.ong@intel.com>
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org,
        Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDAzNyBTYWx0ZWRfX7HB+YnZYTvnP
 /NojZwuc9cInttm4JXxYz028qMEN9iwZVeXxpNJWmniMJU6twMV1BMKzPm7p4DVFM05QWpB176H
 fOsjesPY/X2+ifDcTqoS0EysE+Hnzvw=
X-Proofpoint-GUID: Hq76acaDAyhe6vDqPedtSZvi8oj-vpoj
X-Authority-Analysis: v=2.4 cv=b4YncdGx c=1 sm=1 tr=0 ts=6abe274c cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=JYNNWCGdvEbVgmh2GQ0A:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-ORIG-GUID: Hq76acaDAyhe6vDqPedtSZvi8oj-vpoj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDAzNyBTYWx0ZWRfX29qxEGzoY8jw
 gLUYGokRQHJkPYbKhRPN2Ace84wUE3jhRrfElz9YUJukezGzFqSlvldYqHQyONYs8B95AjvtueR
 HhS5eqBOt5TCMTiXASi8JvTwmJuyItydppk+xHk/XetxLHQBIF2BJc+fcd25YWzq+sY8kXCE5h8
 sXpQOQnX+b3yM2x5XrfzlNQ3XeTHUun++WfNEcfg+qqCEQQKPI/q5qS8tCYV/cg81S8fSwIs+Xr
 SrYauUGKtSDHzVo/Y56MkAeQbtA2YuoiCh1ajbAxJ9GlII5aH1gok0tbcx3TZ43t6iSYzwkio0B
 OwqUbnFwRtzQ82a3jMZQzWC7284wH+cQl9/5FPKlcqhQcQ28OblRarP1K7pZrj0mHc0u1FYa8sA
 E9s4ynLORjxNVMF1I4ExZlcmv4Z/o5gOXC/fpWh4w6T9zXm5oIrRD22jcckivIF0Nmn2EVDaHRF
 SwtkgXzuHTAbZgjUywA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 spamscore=0 suspectscore=0 malwarescore=0
 priorityscore=1501 bulkscore=0 impostorscore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610010037

Extend stmmac_xdp_xmit_xdpf() to transmit XDP frames with fragments
(multi-buff). Each buffer, i.e. the frame head and every frag, is mapped
and programmed into a dedicated TX descriptor.

Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 122 +++++++++++++++-------
 drivers/net/ethernet/stmicro/stmmac/stmmac_xdp.c  |   2 +-
 2 files changed, 85 insertions(+), 39 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index df6a329fdb80..508e865f9387 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -5249,73 +5249,119 @@ static unsigned int stmmac_rx_buf2_len(struct stmmac_priv *priv,
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
+	unsigned int num_frames = 1;
+	struct dma_desc *desc;
 	u32 tx_coal;
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
-
-		buf_type = STMMAC_TXBUF_T_XDP_TX;
-	}
+	while (true) {
+		skb_frag_t *frag = i ? &sinfo->frags[i - 1] : NULL;
+		int len = frag ? skb_frag_size(frag) : xdpf->len;
+		bool last_frame = i == num_frames - 1;
+		enum stmmac_txbuf_type buf_type;
+		dma_addr_t dma_addr;
 
-	stmmac_set_tx_dma_entry(tx_q, entry, buf_type, dma_addr, xdpf->len,
-				false);
-	stmmac_set_tx_dma_last_segment(tx_q, entry);
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
 
-	tx_q->xdpf[entry] = xdpf;
+			buf_type = STMMAC_TXBUF_T_XDP_NDO;
+		} else {
+			struct page *page;
 
-	stmmac_set_desc_addr(priv, tx_desc, dma_addr);
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
 
-	stmmac_prepare_tx_desc(priv, tx_desc, 1, xdpf->len,
-			       csum, priv->descriptor_mode, true, true,
-			       xdpf->len);
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
 
-	tx_q->tx_count_frames++;
+		entry = STMMAC_NEXT_ENTRY(entry, priv->dma_conf.dma_tx_size);
+		i++;
+	}
+	tx_q->tx_count_frames += num_frames;
 
 	tx_coal = READ_ONCE(priv->tx_coal_frames[queue]);
-	if (tx_coal && !(tx_q->tx_count_frames % tx_coal)) {
+	if (tx_coal && (tx_q->tx_count_frames % tx_coal) < num_frames) {
+		struct stmmac_txq_stats *txq_stats;
+
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
+	 * for this xdp_frame are populated.
+	 */
+	desc = stmmac_get_tx_desc(priv, tx_q, first_entry);
+	dma_wmb();
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
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_xdp.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_xdp.c
index d7e4db7224b0..9af9e0cb366c 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_xdp.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_xdp.c
@@ -135,7 +135,7 @@ int stmmac_xdp_set_prog(struct stmmac_priv *priv, struct bpf_prog *prog,
 		stmmac_xdp_open(dev);
 
 	if (prog)
-		xdp_features_set_redirect_target(dev, false);
+		xdp_features_set_redirect_target(dev, true);
 
 	return 0;
 }

-- 
2.55.0

