Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792743040;
	b=HMIZ/OdAUQILKIoCMtJrD6RDWBTceIV1BS1tN5SZycskqDDmgOThCpnaee1T0jQz1qq+
	 lXPbiizRE/yZ0PTe8d5DzPUTycJpqzJjYCmpCGSywEXSNtvz1o12zBA/FI0TxoP3VNumj
	 1mBABJ9bhF7LJb1W1addtMPJJ00POzmXsy1TdInIvTtssfBzOaBpNtheQlkVXH/e7b5eb
	 APAk3o0OIiPqQNCJw8vtACzbRAPNYCi/QkV07BTd9Sy71G3lXP5t3J7yGwdQZg7/fy3TH
	 RepU0k9sSbm2Y5FlfmsyUxiCJbKn4Srfc/IewKAG/Uv9/ZSRP+y7xl3kD0Oq0e3Xq6Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792743040;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=1pRFcQEcu8s5P1EJubsYrvBbAclreG07J1NNugAiMfM=;
	b=0yGAKn78JZ9DSkCUAdf8+YwLiWpRaox2BNVyrRsJoxV33HWEeROjdefAi2RalRUEldXg
	 M4048wMiWX6McyAYnCAULbIdI+jUJrG7vTFLWz0/YdNsWNhg15WUOAOfGoJ8KgxajvX+i
	 r81pH3c0IaYki4FDk/xU/nIAcSGtPmvVmwpF+n9WnDLZ73+UzinAQkwPoLxqzlM17ImV7
	 N8JXjJANJha1T/TbsaDHfDvrjAgRyjIFTYVCs5tX0ogLvHYu2wtCaMpUJ4uAKOddzgb8W
	 Zp3XsvijKDujZhbJs6R1cDd7gwlGdQLThELnUA0RhElnoeFYuHstVOk5+EVpQlnr5hA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=P3xbbkAj;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=McNFQ2QS;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08863606A324
	for <bpf@vger.kernel.org>; Fri, 23 Oct 2026 08:10:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 08863606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=P3xbbkAj;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=McNFQ2QS
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69N7FD9X2092868
	for <bpf@vger.kernel.org>; Fri, 23 Oct 2026 08:10:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1pRFcQEcu8s5P1EJubsYrvBbAclreG07J1NNugAiMfM=; b=P3xbbkAjSM6PTpwT
	25b+uEaHBDAV6siqu+2b0KoO3acB7nnNcruCCFiNlszL9xnhNTOIDqnRQCllPR6f
	3epEogKOiDQhNlpAiChTX/PzipfYVVmw4JICO6S7x3iXm2DxuTuyMyW7POXQoNFj
	e+Q2a6LjaBCp2bUfCR0U50dtpcgrNTRluSX+zEhNll71P68RJ6QE5eE7BupSeF/d
	Luygs+q4gOs6okZ4T/UxiHI5i5c4PMuiGxwW8UVYMJUkbZcK5Xltjpi5If2W9K8n
	PJlDnmgSGv8YvAQEbwCXIAqanx9Ry2I5Bxo8N0ZAKC5+fCPqTrytQscaGaQhs1Y8
	4rKPEA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hftyg9uyp-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Fri, 23 Oct 2026 08:10:39 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-93f1e62510cso135300985a.1
        for <bpf@vger.kernel.org>; Fri, 23 Oct 2026 01:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792743038; x=1793347838; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1pRFcQEcu8s5P1EJubsYrvBbAclreG07J1NNugAiMfM=;
        b=McNFQ2QSaTaT1Ye/FqZguoiyjIycPYSMtNu3MWcYlWnJtnJsYv14BxHj/jWBDlxlMk
         TfeNHb0T8zjx3OQZ6QSuPqdYc7SqcoX/fmxeYEIWStiwgo9/T1WFi3IPDpHjUrYIwih7
         UyRAOO5rkUzAws0OIHpt78/FWNeVqIDTIM0OnWS0cNYXBKhfdqCXpZIr86hZvtXFTVAK
         gQCM5mCVO3oywhfE7YcWEomOowSPwMCJ/7SnPBY0ycyU2rsepCPkXG/0ca6veoF8mhN6
         CXscEc+kjL2JcdBBpcFX89jmfzWjDJcqSUL+wF4iMNH06PqmuQZMQIPtnIEDxUtncDY1
         Ahng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792743038; x=1793347838;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1pRFcQEcu8s5P1EJubsYrvBbAclreG07J1NNugAiMfM=;
        b=Zlm0ScDhex+0HXFJQH6HMRJU7zen99cfiOio6z+gW77rlUIUcg8Ac1FKfyPoxkctzq
         K9Q7tFEgJo0q+Or4vrgEwc914SpUHa3lrgyo5xxXzs5u/LJiHxvyGMA0LHFl1giIpRFh
         eRvIKx7mslSdBbWstE+VKF0qhokSbr4Pjf7a+Zg6e8BVRd/QsEPtLMlJliE4Lce8726g
         LKHs1fwAhA37b2AZmbMR7U+uuRG9UlesKebP40g2UAETI4NL2uTeiOi67v73tBQ9zpJa
         4io/ML09B7bEomJLXPUu8YcXcUrljVbTvBPC9bxaEU3XQqYVY3DrtQxUTKvCMNumCfM6
         ERuw==
X-Forwarded-Encrypted: i=1; AKwUvByv9o3hzVgfx5Yxd7QyLzvXCTfLdm1kRr8IVLapN4sx5uOgOvQDkwMNBjVSr0xEn8cb8hw=@vger.kernel.org
X-Gm-Message-State: AFq9FYITl7S4NbDp7qcLAfPMC3Fww76/vbwBr2EbBpRHkYcMRDu0zKIp
	AveNHXWOFUDcDWKobmUQFl7H9pP7FP7eOz9TRkxQVpLJrMWHGGMpBNi08FIt9cJv52Ff/vBXEC3
	m01tSNyJB1eE7JFYOnO8NdnuSEn2e7Fu5dHTSzbmfb82py4Gvenca3G0=
X-Gm-Gg: AYBFou3ay0694SXRfcyyE2TkdJeQMbLMH5kEvXM6EMwMi5rqIuKVp6SPsSkg8G5989Y
	hHVqhq2YKABxkz9LVZ9o5a2QcUw51YKuq+wsklLD+8dNYHhBMZ5/rEEsseNHj2ua8vV4igl61W3
	wi+/IuSWNBhm9dJ36KPNykOVGVljRvJOKhhcbl1foWqibu3qrvO24dEeYti4FTEIQVEulYyeXfI
	+sCYy9uM2yRMeyOaa0C83td4ks2Dk2vPtwz1PAr38SVTFjpbbN8hIw+QbBflNk8qKNl7D6zTVCu
	N4Nk/iLafRxXrgmO0Rz5z1pdmcCMry9A0LUIRrvqDwbkgi/ntaerVFZ+EMOw7Oyu5rMaphGyvSN
	7NK5gSciksSr4h5C5UQlzn3sVeF9ZO2fDjAD0MKRFERkOv0xA
X-Received: by 2002:a05:620a:8389:b0:93c:c73b:39ed with SMTP id af79cd13be357-93f6f7c4facmr264311585a.39.1792743038197;
        Fri, 23 Oct 2026 01:10:38 -0700 (PDT)
X-Received: by 2002:a05:620a:8389:b0:93c:c73b:39ed with SMTP id af79cd13be357-93f6f7c4facmr264306885a.39.1792743037606;
        Fri, 23 Oct 2026 01:10:37 -0700 (PDT)
Received: from localhost (net-93-144-6-81.cust.dsl.teletu.it. [93.144.6.81])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e38062dc6sm3347597f8f.55.2026.10.23.01.10.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 01:10:36 -0700 (PDT)
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Date: Fri, 23 Oct 2026 10:09:55 +0200
Subject: [PATCH net 3/6] net: stmmac: drop multi-buffer frames in XDP mode
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261023-stmmac-xdp-fixes-v1-3-efb37e19f5bd@oss.qualcomm.com>
References: <20261023-stmmac-xdp-fixes-v1-0-efb37e19f5bd@oss.qualcomm.com>
In-Reply-To: <20261023-stmmac-xdp-fixes-v1-0-efb37e19f5bd@oss.qualcomm.com>
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
        Jose Abreu <Jose.Abreu@synopsys.com>,
        Ong Boon Leong <boon.leong.ong@intel.com>,
        Oleksij Rempel <o.rempel@pengutronix.de>
Cc: netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        bpf@vger.kernel.org, Nicolai Buchwitz <nb@tipi-net.de>,
        Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Authority-Analysis: v=2.4 cv=cZpHPXDM c=1 sm=1 tr=0 ts=6adb167f cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=7fYLNvKHbgS61GKHX+yayQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=VR_YHCPEGhNri-7XuWcA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDAzMiBTYWx0ZWRfXykn2DQp8zztV
 +klkO3mZ+zWXF0haLPj5pVLzD9lZd8GsGOM1EtaH5MuoMQQ08QSvu5tEaZhXbdpeSj9ozAVuWLB
 fo86cOl12rSC1uK/19T2wfh9P+aq4zs=
X-Proofpoint-GUID: qOll7JSsPWPjEyGmABXDYN2Ll2rHpPzL
X-Proofpoint-ORIG-GUID: qOll7JSsPWPjEyGmABXDYN2Ll2rHpPzL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDAzMiBTYWx0ZWRfX8Of/G9tyPRN1
 IAkgrCDHkRt2NsIDT551lWmvEI5KoKI05mG9lVtKuNOE/Du2deC5+JFvQWUJQ2Y/qrxXlrqg3Au
 6c6T8lnZgPmzmNVfn4/zW6Y5BLgeJG+8nbN3NsDeq4fLk+kDsbgkvhef3JEWtKBwttQMvKjxd/F
 SN9qB0QucfLsQkAFnpwrh21nvGqTLfW+rX7bEvbbDXFOcep2iprMEfbqoiRvyPkUSVYGHVpUBX4
 A9B136aCUbbdRWEHSk1+g8O/EWXIWZOT4M8bMiiWVSsxyG3ZXJtPEuONUxA+IW5udEfdIfignN0
 Cc3PQOWXdLs/Hj/03Ib1QNZf51bRHiv0x9ANV1dKrwYOSHRZV6l9MwfYCJXxWSJ5hZqLg/puGPa
 JISCYTqVfiVjkdsJ2bSvrUGZ9Q6dnlgL9xOgtoBhUAZu1FtOtZ1sG9Hgaf3VmcQcQkZ/pvaDxIl
 ANvDD5NHcJ7xfAv/krQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 malwarescore=0 adultscore=0 priorityscore=1501
 clxscore=1015 spamscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610230032

stmmac_rx() runs the XDP program once per descriptor buffer and uses
skb == NULL as the only marker for the start of a frame. A frame larger
than one buffer is split by the hardware across several descriptors;
GMAC4 enables jumbo frames unconditionally (GMAC_CONFIG_JE in
GMAC_CORE_INIT), so an on-link peer can deliver such a frame even when
the interface MTU is left at 1500.

When an XDP verdict ends a non-last descriptor, skb is cleared and the
next descriptor of the same hardware frame is parsed as a new frame.
For XDP_CONSUMED this happens via read_again with len preserved, so
stmmac_rx_buf1_len() then returns min(dma_buf_sz, plen - len) for the
last descriptor, which can be as small as 0-3 bytes. buf1_len -=
ETH_FCS_LEN underflows and xdp_prepare_buff() puts data_end far past
data; on XDP_PASS this produces an skb whose length is close to 4G that
reaches the network stack (skb->tail and skb->len are 32-bit and wrap
below skb->end, so skb_over_panic() does not fire). A 4+ byte tail is
instead offered to the XDP program and delivered as a standalone
mid-payload Ethernet frame on XDP_PASS. XDP_TX/XDP_REDIRECT instead
falls through to the next iteration, resetting the running length, so
the tail is re-parsed as a full-size new frame.

The same fault exists when a single descriptor uses its second buffer:
GMAC4/XGMAC always provide a second data buffer per descriptor, so a
frame up to 2 * dma_buf_sz can land on a single descriptor while the XDP
program still only sees the first buffer. XDP_TX then transmits a
truncated frame, and XDP_PASS appends the second buffer only after the
program has already run over the first one.

XDP does not support scatter-gather frames until the multi-buffer
rework, so drop the whole frame instead. When a non-last descriptor is
seen while an XDP program is attached, mark the frame as errored and
drain the remaining descriptors, including the last. A descriptor that
uses its second buffer is dropped directly before the program runs as
well; in XDP mode it is necessarily the last descriptor of the frame,
so it does not need the error marker. Removing the re-parse lets both
XDP verdict branches simply complete the packet via next.

The buffers consumed by the discard path are no longer returned to the
page pool, and the new SG and second-buffer drops do not return them
either. They stay in rx_q->buf_pool[] and stmmac_rx_refill() reuses them
in place, allocating only when a slot is empty. This is safe because the
drop checks run before the buffer is synced for CPU access or
prefetched. The discard-path change and the in-place reuse apply with or
without an XDP program attached.

The !error guard on the discard check also changes the accounting for
errored multi-descriptor frames on dwmac100/dwmac1000: rx_errors is
incremented once per frame instead of once per descriptor. This too is
independent of XDP mode.

Note: the subsequent "net: stmmac: rework stmmac_rx to support XDP rx
multi-buff" accumulates the whole frame into a single xdp_buff and
supersedes this patch; the fix is kept so the net portion of the series
stands on its own.

Fixes: 5fabb01207a2 ("net: stmmac: Add initial XDP support")
Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>
Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 35 ++++++++++++-----------
 1 file changed, 19 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 3fa2c15222d8..30a2774d722b 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -5903,18 +5903,23 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
 		if (priv->extend_desc)
 			stmmac_rx_extended_status(priv, &priv->xstats, rx_q->dma_erx + entry);
 
-		if (unlikely(status & discard_frame)) {
-			page_pool_put_page(rx_q->page_pool, buf->page, 0, true);
-			buf->page = NULL;
+		if (unlikely(!error && (status & discard_frame))) {
 			error = 1;
 			if (!priv->hwts_rx_en)
 				rx_errors++;
 		}
 
-		if (unlikely(error && (status & rx_not_ls)))
-			goto read_again;
+		/* We do not support SG in XDP mode */
+		if (unlikely(!error && (status & rx_not_ls) &&
+			     stmmac_xdp_is_enabled(priv))) {
+			rx_dropped++;
+			error = 1;
+		}
 
 		if (unlikely(error)) {
+			if (status & rx_not_ls)
+				goto read_again;
+
 			dev_kfree_skb(skb);
 			goto next;
 		}
@@ -5926,6 +5931,14 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
 		buf2_len = stmmac_rx_buf2_len(priv, p, status, len);
 		len += buf2_len;
 
+		/* Drop the packet if it is split over buf1 and buf2 on a
+		 * single descriptor if the interface is running in XDP mode.
+		 */
+		if (unlikely(stmmac_xdp_is_enabled(priv) && buf2_len)) {
+			rx_dropped++;
+			goto next;
+		}
+
 		/* ACS is disabled; strip manually. */
 		if (likely(!(status & rx_not_ls)))
 			len -= ETH_FCS_LEN;
@@ -5975,17 +5988,7 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
 							   sync_len, true);
 					buf->page = NULL;
 					rx_dropped++;
-
-					/* Clear skb as it was set as
-					 * status by XDP program.
-					 */
-					skb = NULL;
-
-					if (unlikely((status & rx_not_ls)))
-						goto read_again;
-
-					count++;
-					continue;
+					goto next;
 				} else if (xdp_res & (STMMAC_XDP_TX |
 						      STMMAC_XDP_REDIRECT)) {
 					xdp_status |= xdp_res;

-- 
2.56.0

