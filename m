Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F1444CC294
	for <bpf@vger.kernel.org>; Fri, 25 Sep 2026 15:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790351678; cv=none; b=OTV5glHvJOJDrtO6K1s2qyyEHYlHEpPpIMiKadxs7LBjR3gbEFtMq9Z1Q2qyMi3OOJd3ybxL7f7B5wU8V4Kl/0k+Gm9pRXP/Ea7jpNryhQFgHAKxJw7F5r+oLAPin+GJPKk4nnBQZxTlb1kn+wsVZzwtfPCnlRaWrFiDtEsKJEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790351678; c=relaxed/simple;
	bh=PDsF+Jmww2Rv+p/xKE/1nlOlbFcj2ig/l46kpBFesqI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=HAO3GVXFyOk9/fgp2VJs9cup8pEG0Mz9Yb6B2Y4PbEFnG+ntClcl6sWfjQiS6AMlPduSANy1xl7moE3XGZlO/frbvdQ2lvSDWC+0HxiYSJ0lxkaYHJ46NtWOI5hWeQwdSD1OJgYs3WZnJ+6uUdJWDcs1ga13noINslPOf8wfCKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KkkpwkKp; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=gt3/GrWt; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KkkpwkKp";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gt3/GrWt"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68PA4SNa609540
	for <bpf@vger.kernel.org>; Fri, 25 Sep 2026 15:54:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=k3pBNULljxFqavqzf5bIsc
	7svxX6l9nSf1+vZLbUXTI=; b=KkkpwkKpWNwyXVcx7dlkFZvWGqxy3xOwqd+xYj
	ROEGKBy97MOrgwW9y/kEPKRokVe1/Q9KATNRlvA0Ep0IJpj8wBrd4cP/3IwrRzIo
	FpyqAhQsJekaLO1b3ph87t2oZA4UbEZLGZDfQYV62xbY05vzGWhvNy7gC5cPId4+
	essK1hqoiIuPoP4zGFMF2OQOtdacVhRktYNmFzl/INvTFTEhSI9ViLu5laYXWmhT
	/hwsokPB1S7fyZzKTgGLCS26BqtD+GeDvDEW3A5ZzrbHcPSPBV/yjAgipNIBr0CO
	lxcN4AuGV+sQmr5fAgnWNz2BNC/+7NU1JTAo73SqiblrrGjg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gwpvns67a-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Fri, 25 Sep 2026 15:54:35 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93a0050a554so216552885a.1
        for <bpf@vger.kernel.org>; Fri, 25 Sep 2026 08:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790351675; x=1790956475; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=k3pBNULljxFqavqzf5bIsc7svxX6l9nSf1+vZLbUXTI=;
        b=gt3/GrWtk4pPpYytKjBxNAsVtnpJQr8hHRCSqqHCgu6fvqvIxkHwNlVHXBLy3GdksV
         sOTt3WFdw3j9NYlGEfGLshIv4OfTrfFOip1xsfONTbbyLFx1P64QjfpwLU0wMk4+NrKZ
         RpM9F5MO9BIyNveorcyX8W+q0z1VTUyODA9kqdQ2PwtRJKlg5/RJTsUcFmCHR3iCl9vz
         yxSy7OzEKHiuTKw7iZDZc/6eFdaV5zySpfRCXAYvCj5rFDtWGQbV6GhV/oJnlcfJtZJy
         prXWFJvJJVLpL2oKN5TKHhJWpyz4z3CnQMGhghSGx8u8i20YFJvyEusP7H3NFFbsTa3a
         cKag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790351675; x=1790956475;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=k3pBNULljxFqavqzf5bIsc7svxX6l9nSf1+vZLbUXTI=;
        b=BJTjyex/F0vYF2S7NL655E9LT8BQtKg9+LjI72yOYEWxsNAjcugFQ6D+YG7zgIdyVW
         2BTUaJGINjGSJhHFgHtVTqQpDh9so1RaMDqlmtFPm2wfvP+JrZEnw8jbA62qoYWejite
         i77TU59FtavJdikWVADpGdPqmoFZlWLne458Wj0xk0gkM8rMy1X1wp+O/YQ5CRyXrrwe
         0TwFfyOAZP+jyTDRMxY+w4bSomfpGO6QdrmGd7hoorup6Ap2WvcXtJJdLbOIR4SWrPMI
         kNUVX2qoAQvwhgDtVEZGWTy3XNjwwgvfN7zl7SSufX4/JKEUC6qNXYcqZnx6AksmplAO
         Sdmw==
X-Forwarded-Encrypted: i=1; AKwUvBz3sztg9G7u0z5mQWUvwgZEfMYlDCaFI6fFylJbWyJg9YBzBvTWUnoVxOMBNdvDO4Gh6Z0=@vger.kernel.org
X-Gm-Message-State: AFuF++m80CSZ8KlXvvhnyu/iGI6qY0sIohrP6WWNSRiB4UhXincDlSC0
	k9tqMZTf0+gzFb4AXywFlqPiblRcmhciz9++W2WGSt4C1/NlGSiYaU6oqVh5/fGyMQmgO/tY0vj
	DONl+jcL6oFDD19Rada2z+hAj891AGJBljnlb3ucnkMRX0+Nre4WaOwc=
X-Gm-Gg: AYBFou0k3N7elKmhtm7JB0Fuvt7SjCguhO3woJl5Ov63B5oNOqAZB0i3/yBzpI5OpHL
	c/fgp+o4pwBlR3rpugtjDHqJYo/zC74hFGbsTuG+fZsLN/cAPhfcctfrasjzoO3VI0KZyPTA2P4
	B6KnRhXpio578xfu/2XlylughC8lJP18gX53F4/dvicQDwgI2UE9iqXOrZxvTeQ2WznxEsQlJBU
	PTf2FJN4TPKv6oLFveabSiPDSJ5P4AKPon3hPY8TLCLNeloPvWWO+5O0gHHhDMZUwSc4/NWhtvi
	bs/YpoO+Aqghcew0OJDkNYDMHRBRDdV1+sVfw2E4edkOyIjhdRLg110lF57kQd2VKxfmoc0nYZR
	hkXiTbGDzVTtIZg==
X-Received: by 2002:a05:620a:1a1d:b0:939:8373:b552 with SMTP id af79cd13be357-93c43b7e879mr515646985a.1.1790351674460;
        Fri, 25 Sep 2026 08:54:34 -0700 (PDT)
X-Received: by 2002:a05:620a:1a1d:b0:939:8373:b552 with SMTP id af79cd13be357-93c43b7e879mr515639085a.1.1790351673777;
        Fri, 25 Sep 2026 08:54:33 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49ff42b7074sm42234815e9.6.2026.09.25.08.54.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 08:54:32 -0700 (PDT)
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Date: Fri, 25 Sep 2026 17:54:21 +0200
Subject: [PATCH net-next v3] net: stmmac: add XDP multi-buff support for TX
 side
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260925-b4-stmmac-xmit-mb-v3-1-ca08f029e81c@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/23NTQrCMBAF4KuUWTslmaY/uvIe4iKJqQ2YRpNYK
 qV3NxQXLroZeDzeNwtEE6yJcCoWCGay0foxh+pQgB7keDdobzkDMWrYkQiVwJickxpnZxM6hUq
 1nWFNJ3QvIO+ewfR23swLjCbhaOYE19wMNiYfPtuziW/9z6123IkjR9lyyXVNxAWdfYzl6y0f2
 jtX5rOhE/1DYg+iDDFWVaJVrdJU70Drun4BwaqQyAwBAAA=
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
X-Proofpoint-ORIG-GUID: Ejlb1fUntC2lnq8hHZUuArPOMR9xANWD
X-Proofpoint-GUID: Ejlb1fUntC2lnq8hHZUuArPOMR9xANWD
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDA2MyBTYWx0ZWRfX32C9B3Vackm+
 6SAuuGgX45hMY3mG4RWl9GwKc4k+gwyIiOBgpg9EGwrUNWPuvHwje7L63VYS2VEmDPzCk6zrL7h
 KwwM3Tzi2dqxXWA0DZyCd/8cSqBvKEo=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDA2MyBTYWx0ZWRfXxsAePhpExbXP
 SnYajb7MTH+OW94ZeuQuHu4lTnYNd6gZcWZtfJJR18wIaMtEIFw2SUUumMH5BDBgXTD8zM40OEi
 oaZvy0mDrnIyHHwrO5x33WBYIVm5KMlpP+hUAthFRp5jnvkNI4VQmXWB5aMuFPArxLwEwHl/gu4
 X2qP/9iNQJc7IbTieVAciXALRkB5dTx+SBkctw96oMl4WKoB0smF1t+2VZ8R0HGNxg0F7/eUVUl
 yTnw/JmVmcOkcFNMorlLPEVlJPcApyx4/CfyCIq42B3KlNaIIANOnWZ/i+DrsNUMCHMphJ/j2z9
 IEIFJraGd07bBoRuEbumIAUEEkPcI1HTOu3rq8B/gsbxUZ8h0eTxC03y7cnnZgtFLk9tj528XG8
 FjH6gu/7VJh5ZnZP7jYCg+zL1ZhBL25PbPHCssM9cdp8zdT5SiGGtejuLMV7+5/WUGtFyoREsBT
 3YYTM3LqgJY9zdXp2FQ==
X-Authority-Analysis: v=2.4 cv=eNmGH3p1 c=1 sm=1 tr=0 ts=6ab6993b cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=tCc0xJYVa54DUFqMxLAA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 lowpriorityscore=0
 phishscore=0 clxscore=1015 spamscore=0 bulkscore=0 impostorscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609250063

Extend stmmac_xdp_xmit_xdpf() to transmit XDP frames with fragments
(multi-buff). Each buffer, i.e. the frame head and every frag, is mapped
and programmed into a dedicated TX descriptor.

Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
---
Changes in v3:
- Advertise NETDEV_XDP_ACT_NDO_XMIT_SG capability.
- Add missing dma_wmb() before setting OWN bit of the first descriptor.
- Link to v2: https://lore.kernel.org/r/20260924-b4-stmmac-xmit-mb-v2-1-003347b7bc25@oss.qualcomm.com

Changes in v2:
- Fix Tx coalescing logic in stmmac_xdp_xmit_xdpf()
- Consider the max between STMMAC_TX_THRESH() and num_frames as
  threshold in stmmac_xdp_xmit_xdpf().
- Link to v1: https://lore.kernel.org/r/20260923-b4-stmmac-xmit-mb-v1-1-a71a1c522142@oss.qualcomm.com
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 127 ++++++++++++++--------
 drivers/net/ethernet/stmicro/stmmac/stmmac_xdp.c  |   2 +-
 2 files changed, 85 insertions(+), 44 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 3ad9252bf6ae..f1e9ac2f9859 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -5241,77 +5241,118 @@ static unsigned int stmmac_rx_buf2_len(struct stmmac_priv *priv,
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
 
-	if (tx_q->tx_count_frames % priv->tx_coal_frames[queue] == 0)
-		set_ic = true;
-	else
-		set_ic = false;
+	if (priv->tx_coal_frames[queue] &&
+	    (tx_q->tx_count_frames % priv->tx_coal_frames[queue]) < num_frames) {
+		struct stmmac_txq_stats *txq_stats;
 
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

---
base-commit: 42a9fb3382fc2573e92f41d203b095d9a372cfc9
change-id: 20260922-b4-stmmac-xmit-mb-bb78e0684cf4

Best regards,
-- 
Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>

