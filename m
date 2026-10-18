Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D22D23CB561
	for <bpf@vger.kernel.org>; Sun, 18 Oct 2026 17:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792343243; cv=none; b=ej0XiJJB96N70YCGhdwCJKBIfj9hHZXAxNk4lk9MNqbuXqCOcj8l4wE7sgMhwCL0Hc2UuCwRcv/zNlsBv4ICF5mrwFgTklQSHQaaQHigFPiPmv9hV7K6S89DLuie++naJt01wh4VX6p38vAjTpsWx2C9XHfsRbNKRPBfjjEuNGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792343243; c=relaxed/simple;
	bh=jJQHiTUG8euxt4Rak3kLpfvHCYGWE7yiqaTyt75wefM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PSsckgQKbpmlmTXUfOOgyRhzNNv/1jc0DDJJ4sOnUo58c0iPq+JRCFg1CF7yQH/Gben4BckLw9tYgzdLf19nJjr+JzSovgFBZlxvu6WC9YV5UYdAOU87e4gT6VsXqyX0d8TGT1G64QZ+GnXDpkbri8domgY03EvDnNB4xynUmfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MNzblhRe; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LG/NK7W8; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MNzblhRe";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LG/NK7W8"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69IF6pM73392607
	for <bpf@vger.kernel.org>; Sun, 18 Oct 2026 17:07:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	HHmd60/I6Rn3BFHeK6JI59ohI+LrPrPqxSimo7k7Esk=; b=MNzblhRePkT0FdxP
	RYTjgd2NB/eoLIPOgYxF7GLHzMpO6ieEFkvJsPPkXZqkUFZlu8gYTQF1JnFH/tCa
	7jhcJD4q7ksoT1Smqwp3+VUaGmNVO54e68gNsJ0Se4zO8kJ8SfcOYBcEXvyXn83t
	bT2Vr2X7XqZQOEAYS7Ej+bxzsXhkS23pfi0eWccBRO9wFg/IhgFU7IRqfUWEnxUT
	PKImAb1JvEGFHxW/LU3CwxQghUrg97raM4O6oRhKT6T60nqn8Oe32PDTAhHx9z0k
	5tDHkUzo/aKVXEXPgDq2WBfJrXbgNc2mIBag1S03BCKwF2uIrCYP9VOzrTI1AtVQ
	ku/UQA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hc2a9kcjr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Sun, 18 Oct 2026 17:07:21 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-93caf7856ffso378588985a.3
        for <bpf@vger.kernel.org>; Sun, 18 Oct 2026 10:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792343240; x=1792948040; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HHmd60/I6Rn3BFHeK6JI59ohI+LrPrPqxSimo7k7Esk=;
        b=LG/NK7W8pLwG3NqfTrL9MMoe5v/AW2/qTPnWmoLhnGHB4kUzZjcUwPGbE+2MaSBSGE
         89GBMKNySWd4eoT4xs6urxRcHRiTXVRBEy1YkikhhUcypap/UnL7V+BzBuGi4gzgdUAR
         9v7Y6qSUdY8rx84RkdbCj4WFmM94fZk5fDAVfSef18Dd4Ss/NJJW0FAFobuK+MT/15XS
         ZguJwOhQmQkdJBE6pTOA7s3nW695zfYP2y+dCaPs/wAkyf5bJp21HC68mDGR7l+3TAGG
         iuIKdAEyDiZERFHahPBD0arFjy5OJdjt6/9DUsAAL0TWTc1EbQXiYilKyAIspPAowPaB
         3s9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792343240; x=1792948040;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HHmd60/I6Rn3BFHeK6JI59ohI+LrPrPqxSimo7k7Esk=;
        b=wDywePa8BiEDUKb5xgLKEdHK/j/ASU+dPjtwF+nf8SCYOporwFRFFIyMn+HGpFksUP
         ewXDvoc99VJlizW3QIE+0jhS3Wq+wicp3bdDhQDt15II5fco8NZA/YBudDwVtadGwV1N
         FRG4NgGlBrX0mnqYNUpOP1mTRByKjDDExR78w7C0U0I9Slx16/HsCZnzCmGNIGmXUYkB
         Yxp/t82m01nb6dp2tzOt427kW1DlS5PxbOsAgIf6hJfdzB1+s4ja+WJrvhCcywvJBhoU
         Q+503F+ZT5hQxC+Vd6li3c+Sp0zvpDbK0ucGPjYuokJ2xkzL1WMuEMN/XYJTICWpctw7
         bkag==
X-Forwarded-Encrypted: i=1; AKwUvBz3Nf9Igw/GnapOpBQQtI9iXghCyL0cZho02CKXSeZukaczDviCz02vj8MNiDmF7EX6qrk=@vger.kernel.org
X-Gm-Message-State: AFq9FYKPTQOzFelQ33ilD90TVnH8r5V1sGGTCexMMOIX2ZnCxOyD3XuM
	V5wbpWh792foQh9xK2Yqzd3udkPc6LqYIQAsVXtdu/nxHlPuZhbV3PyQSTCGZOnE3/HAok153PZ
	vsJw6OpKM7v/AV686KUgp9cMwB/Z5phqyNlIfFueL7Sd0WG7CqGf3Gj8=
X-Gm-Gg: AYBFou2oQn9UczYfxdSubFrtlXViLL58YNo7+AlHAiXLkFdkf/BNkUcy4ARj0q8geF1
	/X+t7q95cbnCL/AwRhW2wawmRGuw/1smIY18W6tC4brMyH3d1KgTh2kex/TvZGBpWgHmB1/IJkL
	H0UBxoJA3BxFYzDEgDQALIlo4ExzylnTtqTnV8joylnTOwrWe8n3jhOHKSP9+Kf0dzQgs4n5fQ5
	6AmaynZ0LEcijZGal6Xs8GbjDtlf3cebWYfnSkSatNl+grtSdyd5hZQeD2GvypEKzKjQg7nDHes
	QBcyOz6RjUqOOv+n2CcwakPPC/Weh+ub/d2ixDUa23YHKu1BD3zDQPYig8Q4pY9gepbO0IuKEJX
	zymHD1foHvFPI1w==
X-Received: by 2002:a05:620a:28c4:b0:93b:e6d3:3145 with SMTP id af79cd13be357-93f29d54479mr900026685a.64.1792343239862;
        Sun, 18 Oct 2026 10:07:19 -0700 (PDT)
X-Received: by 2002:a05:620a:28c4:b0:93b:e6d3:3145 with SMTP id af79cd13be357-93f29d54479mr900021385a.64.1792343239240;
        Sun, 18 Oct 2026 10:07:19 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1c8ddde4esm262440925e9.12.2026.10.18.10.07.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 10:07:18 -0700 (PDT)
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Date: Sun, 18 Oct 2026 19:07:01 +0200
Subject: [PATCH net-next v8 3/5] net: stmmac: drop multi-buffer frames in
 XDP mode
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261018-stmmac-rx-mb-v8-3-5f58c0b25849@oss.qualcomm.com>
References: <20261018-stmmac-rx-mb-v8-0-5f58c0b25849@oss.qualcomm.com>
In-Reply-To: <20261018-stmmac-rx-mb-v8-0-5f58c0b25849@oss.qualcomm.com>
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
        Ong Boon Leong <boon.leong.ong@intel.com>
Cc: netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        bpf@vger.kernel.org,
        Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE4MDA2OCBTYWx0ZWRfXzdNt04f29Mxz
 fzED/9pLJvsqtd818tdYs5xHUI0neG41BikwZwWMzLpkNwveMooE5dyNk4XVB1U9j98qWtU+OG7
 2kUoJSXmRjMTXZx3nuSAKx/3Y/ErSbs=
X-Proofpoint-GUID: CByQ_QudCKbX-cW5397MsZRhe9Yo65_8
X-Proofpoint-ORIG-GUID: CByQ_QudCKbX-cW5397MsZRhe9Yo65_8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE4MDA2OCBTYWx0ZWRfX8cqNLsJE0gjo
 HSSFcBA+SObKGaVzX4IoBlIWhmng0p/mqTt70c5IggKppuHJ+CczL/8p/+T6VOHrxLKsrGBdPYx
 WmKigKeYtC7RF8+n89krhzeAPizq/ROX9qLx6zADDRpucrtqj7bkd8Tq9cFif6/U/EhcRy45ck4
 Hs1Ha/xHEoARono5e0l96yKopcpyIduHB7R3Ppqh71yUu2UGqtOcpwJ01FlEtHnTdXZ2zUwDrI/
 up+yrz7ZzCBzBD91/QipZ4eQEzT1cUPgvP4D/anHq0ANneDzWFknuWQ3+Eoh9ynpEJkpj5AlIvL
 oWPCiRkWS1Cl9eW0LM8cuZVOrA+BzZL4rqichmm9v0HKp6whm9A+Mqq23gtBJmnG8sDY6eF8rUU
 U+TqWc1Usteq1dlvbPKfe7BW5Xz3pTJ9EydIByWusohCJOayM8/hZn97mb0T/JM0RajE/RwL/QX
 ibBAtqRR+aC2AO6GT+Q==
X-Authority-Analysis: v=2.4 cv=PMeaavqC c=1 sm=1 tr=0 ts=6ad4fcc9 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=b-cMl9P36as69-4SBTgA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-18_03,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 spamscore=0 clxscore=1015 suspectscore=0
 priorityscore=1501 adultscore=0 malwarescore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610180068

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
rework, so drop the whole frame instead: mark it as errored as soon as
a non-last descriptor, or a descriptor using its second buffer, is seen
while an XDP program is attached, drain and release every descriptor -
including the last. Removing the re-parse lets both XDP verdict branches
simply complete the packet via next.

Note: the subsequent "net: stmmac: rework stmmac_rx to support XDP rx
multi-buff" accumulates the whole frame into a single xdp_buff and
supersedes this patch; the fix is kept so the net portion of the series
stands on its own.

Fixes: 5fabb01207a2 ("net: stmmac: Add initial XDP support")
Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 35 ++++++++++++-----------
 1 file changed, 19 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index efa88cd359da..e929cc0f2312 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -5888,18 +5888,23 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
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
@@ -5911,6 +5916,14 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
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
@@ -5960,17 +5973,7 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
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

