Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12D844E9C12
	for <bpf@vger.kernel.org>; Wed, 14 Oct 2026 13:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791983403; cv=none; b=W4Rd4KInt6fhjehwHcls0DG/mRCYkm2G7nq6vCxc/hj/N7MhK0BtHyJlhBE8jaqLU+GZxXEn0PL8jQxoeQye8hgeWXu99A7Sb3s/XikgQMEDymJWIx7BF8z6YSFLrMMHUEv9ilSHZOARh7s63rSkVDuMhH8jF9j8DlNytlyJVWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791983403; c=relaxed/simple;
	bh=ULM+TPq1QRua0r7KugW9vSANeUcVvwwH/Z3MUe21LLE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WlMF11/FF8p212b0+1K3VDGIdHwXeQXsiT+UPSRA3cmEFSJJgB/DGRvvpvVq4EZ9PZAaemB6eu+GB3CrxsO9jcAaa75sdDIkHjT5Ghs6d6H0z8qEqDQBUDMc3TxaU5sub4Jtlb6ZCsGQ6TEY2tlR9/cDhrROEbmkRNsZApL72uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XUhfRrSN; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ToiHbvNU; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XUhfRrSN";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ToiHbvNU"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69E7VI1M2874162
	for <bpf@vger.kernel.org>; Wed, 14 Oct 2026 13:10:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/M5NnOjUNxwzJe64yCg4dQMGH9jNm9FmAahLCCnknSs=; b=XUhfRrSNI6K7JEtH
	Xj8al2ZuCdt+1nGywiaamP4ppp29UXkdbSWJabVA/TVo3OlwIZqDCsaBJRK6JdjG
	OF3isxHjx0gWc5cHEtLvUAJAA35QgcITy/b2kWssjRfSTRbIENVAKktMotLYEAYv
	WFwqMw2ku30dthlRHEXxUo9lzOU+oSdkksLBayj7yG+efARYG9kkhsEsP0S3X+N1
	505s3bOr/Hon8xgVBkmZulsxsa2sQ5n5SPdsOfLA6l7yeS6lDfTnyIc9oJC3QQqr
	OVv5A/IvcJnIlqsryLRIPSuY98oDCf5G9iiz4GqQu44YLhjP9qiS8pUhNXhuG5k1
	dGlp1w==
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com [209.85.217.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h9yphjp3d-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Wed, 14 Oct 2026 13:10:00 +0000 (GMT)
Received: by mail-vs1-f70.google.com with SMTP id ada2fe7eead31-7b206156cc6so3392742137.1
        for <bpf@vger.kernel.org>; Wed, 14 Oct 2026 06:10:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791983400; x=1792588200; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/M5NnOjUNxwzJe64yCg4dQMGH9jNm9FmAahLCCnknSs=;
        b=ToiHbvNUPHf6fFtwufqrCGkz5jegqJV9WmzreJmOPbpll25oBoR42HOSA+9B8jAsm7
         Q1q/UYkZf8Ro74/7oGJN05YmtGs55E+Kc7P+L8W9hoktw3Yd2Yci2RU9Mon0brmcGRq3
         xGS5maJCYBEyagiKrskKbqBykAye+20PN4d/jP5twF1VMW4eFbfNQXW/zLWZy4m6srQM
         KFr/r39Gsa+WEslPtseqEG2erM9uBEvF0k5wee6ycjCft25fA7b223IatCfPoNxJt3up
         8DQiqWsAtcT7Wd77nlNL1HZlJD46ehcze0S0Ftt5vGZ9H4bPBaieb3TA7Lwm22tNIkyH
         e+lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791983400; x=1792588200;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/M5NnOjUNxwzJe64yCg4dQMGH9jNm9FmAahLCCnknSs=;
        b=RO2ZecN1iNIlWVuQv3ksrhhEhyB3EjIYHvz2ofdFMF01V+GK2GLOCdV3t1Vrty7/Ng
         gnz3k37/yLjtmcT9K4SMsudsGHeJv5KxtVhfm7NAC/7fPYgCA+CuvFTs7oUJyw8wMp+V
         Dq94kxOnTy3zs3LhIbCqWs8SuBZag9E2c/EJJ52HYIzOiBoXM3gYGm5f++tN8ly4asaq
         88C/20K22BOYWR4SxL3xJ7ArKYGuUAFlnE2haNB3lW2OqYAwhsHBRnUNlj8CzdsoHoLG
         TBXWtMZ1K0s2+VW1KdZXWs5dCz6Q39E2cdarE3kiFC6tbQEyEWwoC6UXBbTD7UcooaOS
         QpVw==
X-Forwarded-Encrypted: i=1; AKwUvBxOy0/ix0CXtkTlpNvGH4wBvYKYhyRzVQkFFLp5cFeP43/MPopYcQ3UoT2UjQqQ141O9OM=@vger.kernel.org
X-Gm-Message-State: AFq9FYI9gnEts1MFSJKE7Z+GXjEF/VssjKfET5LlMxPii36WF3y/YXnz
	gausMaL3UFnauRnz0Gzp5f8RGQnLjKjZfswBDHoHEzmN3y+BdRf8ase/zTojR9MznR5PY2b4zqP
	mGWrig8uTab3sAdAqSjVfVrBTeTMfNNLqw/y4wBpMzNxepYAF2+Q63ns=
X-Gm-Gg: AYBFou2rJltMi4Y9E87ktlzc2XqewO8gDJB872lHTEJHZIIBJ3xr2RcuSWq6hB3CuUn
	hMWIlCk+BPY8GAN2xHfgiG+gC2/9wlmdhV6WFYwt24/zyvwjkET/hTgh2ms9rcV42bXIsHPZot9
	0t2v60N/1frN0GH4Kn1DNgCM6Brr34Rrd34nDVPGs+puR3UCRSKGD//m/t0EVqM7jBDwdxYSnfg
	u2AxPCFyl2kSFUUJnDHu0YV70xDJpJ/3zWAidQr5bP8rFiapafOQM2PLsq6QnZSiv5ldCYLa34N
	S8gjVrpG1N87p2KeqrmzOMnz2iLDi5exeH3NAWMSTIa3geoIVGUahwI79XlTtGJesepxrwWnozZ
	dKcBAJu2q7Ab9XA==
X-Received: by 2002:a05:6102:5cc7:b0:7b2:7aac:8ccf with SMTP id ada2fe7eead31-7cb373e1426mr5095268137.29.1791983400009;
        Wed, 14 Oct 2026 06:10:00 -0700 (PDT)
X-Received: by 2002:a05:6102:5cc7:b0:7b2:7aac:8ccf with SMTP id ada2fe7eead31-7cb373e1426mr5095254137.29.1791983399314;
        Wed, 14 Oct 2026 06:09:59 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1b489742csm34280125e9.2.2026.10.14.06.09.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 06:09:58 -0700 (PDT)
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Date: Wed, 14 Oct 2026 15:09:37 +0200
Subject: [PATCH net-next v7 3/4] net: stmmac: drop multi-buffer frames in
 XDP mode
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261014-stmmac-rx-mb-v7-3-5d2d70f052cd@oss.qualcomm.com>
References: <20261014-stmmac-rx-mb-v7-0-5d2d70f052cd@oss.qualcomm.com>
In-Reply-To: <20261014-stmmac-rx-mb-v7-0-5d2d70f052cd@oss.qualcomm.com>
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
X-Proofpoint-GUID: bgEcoIvoavXAK_EyuKI_aZg9gVdHOGjO
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDA1MiBTYWx0ZWRfX/CEKlJFuZRDp
 NSiIFlLLj7RV5jOiIymcuKcaMBZPkyCVrm73zpCGhQMF7NNmaj0Tdt199zLyJfsxwsRPZRiD480
 CNjSjPTyCPWM/wLK5aop3/7dn07jG9g=
X-Proofpoint-ORIG-GUID: bgEcoIvoavXAK_EyuKI_aZg9gVdHOGjO
X-Authority-Analysis: v=2.4 cv=Uv72pOwB c=1 sm=1 tr=0 ts=6acf7f28 cx=c_pps
 a=N1BjEkVkxJi3uNfLdpvX3g==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=b-cMl9P36as69-4SBTgA:9 a=QEXdDO2ut3YA:10
 a=crWF4MFLhNY0qMRaF8an:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDA1MiBTYWx0ZWRfX/93h26DI/9i5
 4U/yWenusbuWn6JfDooPxECBAmguIKALHC34cVhPgBWlhbgG4XzZWdzu/Cq1DNPG9ew4X5IWTvq
 nQsQjdrVtOX8TEPnGHf/zcZubnyST4grsm2FLlasj/jWdQiaYIk72IzGktYGCMB9Ld/QA/6d7LG
 rWnEqFHhuvAGRrWfqeUjZuDIixv/HVzQJIsDzhZ+4JxeFnTfsm93IVRvjzlaPIVz97X+v3rgMnM
 WuvFs12ripxGynihf4JlhPsegdR1JvVIOvb8ZBtCq+Pt00BQOoSYvZr4Awq+lR8pPjOsLjceN1n
 /fLKXAEMZWCdU0eeiMvdsymN2sGwqPBr35c2zc5zyJQmIpu7ERSv/bvK0b2cwbKkCKDhkPpF8LY
 9kDQtWhLXp6wTGUEsuXCVaAworAWrS7NWi6a0C9AjR/I74J/SMJKcky4hU8wKhZZdCgquDvTF0X
 AB6WtFsDY2SG7lEhjmA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 clxscore=1015 priorityscore=1501
 suspectscore=0 malwarescore=0 spamscore=0 adultscore=0 bulkscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610140052

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
index 10ea72cbf889..f4beb0ff6fd2 100644
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

