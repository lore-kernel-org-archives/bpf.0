Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E07D3F88A2
	for <bpf@vger.kernel.org>; Sun, 18 Oct 2026 17:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792343241; cv=none; b=Wi0WHebTP5wmJsQwL8fHA1Xspnrqq3ExtvQJUSSRLEOc+gA2QqzsrMVTQPHo8G6wUSPWAHnAW+e/ezejCMm4wpaoXDPC8d/SSGbF/cEOkjuTvycvaGHMD9HHscgTXAOp0PN4Mx7/6/jAuZYJwr1fsxJi35Uerw5KDek00dW4s5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792343241; c=relaxed/simple;
	bh=YxfkgftTmf46hLMc0BUCfFj5SdsNubTgI86ZFe8eFHs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FGWvIMeGnCQmgxWIB9z+zE+h3FnPShdjIVBKNNnbPPGtkr6OcwicX4FYyMxd9bBzzJAJl68JIdhJPtnehY1hjNBSJo9i9TGRCk00w0mCfhkMUM3P3TagU5DSHyiW4qUbrf24FjZINbkoQ+igNsxupQYqg6Sa82/IhLonW3QDeTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WAdBZpIE; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=M7JHvWaC; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WAdBZpIE";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="M7JHvWaC"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69IF73Do3393537
	for <bpf@vger.kernel.org>; Sun, 18 Oct 2026 17:07:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Pr0BIM1b/ftIENJIu/PmddyoAADq6kKkfV88iiNDJVA=; b=WAdBZpIE+0qKeZn6
	DYj0MmPwjU2sS4oJpIkDg1+Y8aJ6DUUNGJ+UEqhzRcTYJmv7H6fDXf4uhLK0Gyzu
	Vzffwbf3tKNbk6za+npei3oG7ho+DQl3EGv+tXjq0oDvWwmH7rRXlM7znS4VvWsn
	huy9QNKxBU6Xv3F190ZpIzB9xuN43vydboNqC4u5V6fdFPzXaJd9WdbSm0dyiqaL
	UPDsTf1kVVxbP/grN11vnRR1/VtuWDEFyGo2X0c8bssBby+AJ/Kze/XSTIGEB7d1
	9fm9l14NSD5oPx6QSarRqzyPYyJj4Epqo0bAieWb71qJuztTcj9bUM4tZziJ2prQ
	oVvs8g==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hc2a9kcjm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Sun, 18 Oct 2026 17:07:19 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-93f33438950so274714285a.1
        for <bpf@vger.kernel.org>; Sun, 18 Oct 2026 10:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792343238; x=1792948038; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Pr0BIM1b/ftIENJIu/PmddyoAADq6kKkfV88iiNDJVA=;
        b=M7JHvWaCQUX7fDh5eHvhWWYsRPKuJkDUQgfOBP1jfKXvkujs+NpxBKAh+eRhz07Nop
         YzNLHDsBEpK55rpF3at6ax8UPUhwfwpob2YyKd72RotMqvtR13uFbU8q3RtFMzaFThUJ
         Hutvm6UADvwXAMdqxqpVuTYNWsWu5oE8wMCDJczWHuLbUiB04TytPhWHuJJXik1FLuA9
         6FrGMhI9Zv07TNtEJqMy6HkFkTNCnH/4PuTZlLOB4IzJyR4pObBQ9YQ0hIU6Kf8PNIdO
         5ehQOFUvvsNWUBS6B8yEiGINdnckESrDiH7iT53Nzvg8UepvZ54mS+ZXCbDD0V76ORdZ
         GlWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792343238; x=1792948038;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Pr0BIM1b/ftIENJIu/PmddyoAADq6kKkfV88iiNDJVA=;
        b=dkJSwZL76AQLU8pCwB74OkkOvUlHSu9/wonAEOPCdRER7GTyu3lOEfIyo0nLu2YJof
         4ZMhtBUoXYkF9v1nHSyFmAd5HtICjd++j7PRfXIgnVqgNrYKsGY3nr+o5DJfBkviJSWt
         LcZJJvTixsRbfJjy+9CbkLBYibckvv8FZ5xFLDP/PtANss5sYg3u7Y0DhBToHRt1oo8l
         F3iO5ix7s3GM4fqxFqPolBrYOkb2f5Ff7yNpN3LfexuNq+vmktD/YP8Wp2B/Ow9b377h
         qRuFVaMrqKa5crT870tlQLMCnb6yDrpxXpBn8V4xDj1GaQi2M/BIQybeRLjBPtmKWAex
         qDMw==
X-Forwarded-Encrypted: i=1; AKwUvByaMmvqT8ZXqL6euWZ5TQ9nVj7c2pXlpw1+1PHoD9tSflBLuFAFk8MGLDRd3TDzGcaJfXg=@vger.kernel.org
X-Gm-Message-State: AFq9FYIdp9zQuTpD8rGJDMwUCQ/4ozAL2RHf0sSRq+kGg+S9g8IICx3v
	Nz19BXea+njt8vcvUrBcK81qxvVjU7SrPZ5wg+s/g6iJsX837cXcnhY9tCvMFDhpVk/cpEqlHt+
	SM3p4FvavIcLcwXL0wlEX+VcK+Lojx7Y3FAxIYLa3gIRcnF0/KS96wRA=
X-Gm-Gg: AYBFou1bDhGn/nPeAQ1VCGkSYAK5Mts0hXJsLvvXpSIoJ/r8c7a9TRQF+G2I990HKft
	AyIhXjeYRImIrdX2lCZOA7SIcP9RoUbEqdrDQsBGaqwA9DetQEyVYKc59gya0+ujhthr7nYPWvS
	vHE4wauxddUz+pGhZqJCoqC1tYRTXthOzPPhMNjPr7jb8TjT/2/9li7yi3f0u+ZvBOsy5WnLKSd
	MKd7xq391eX0CDlPYcIhG19WzgqK45RtOblENwUxyFwovVmnczlD3SmsgLJFpB6+BerU19VrXEI
	M+zQt4IbX6/sztf8B8BK18DbntBpviI4h71OIfyBno+88tRB6UVB+Igo7aTUtb8Ojy8n/OmaeB/
	Y1W5Iesz18+iwaw==
X-Received: by 2002:a05:620a:2550:b0:93f:22f1:97be with SMTP id af79cd13be357-93f29df1d34mr948993185a.72.1792343238184;
        Sun, 18 Oct 2026 10:07:18 -0700 (PDT)
X-Received: by 2002:a05:620a:2550:b0:93f:22f1:97be with SMTP id af79cd13be357-93f29df1d34mr948989185a.72.1792343237661;
        Sun, 18 Oct 2026 10:07:17 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1d7659805sm177655965e9.7.2026.10.18.10.07.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 10:07:16 -0700 (PDT)
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Date: Sun, 18 Oct 2026 19:07:00 +0200
Subject: [PATCH net-next v8 2/5] net: stmmac: drop split frames on AF_XDP
 zero-copy RX
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261018-stmmac-rx-mb-v8-2-5f58c0b25849@oss.qualcomm.com>
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
        bpf@vger.kernel.org, Nicolai Buchwitz <nb@tipi-net.de>,
        Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE4MDA2OCBTYWx0ZWRfXxMaSIJxekaa1
 nOnJhuQ01UnhQNrCwnXT4vtzc8oAWlPwPIwbTggfxnsCv03b8yXnPtQF23z0AgK8BBoM1QoWQzv
 oHbU0ME7N8FzBR7GWHU4mdTQbwnlJuE=
X-Proofpoint-GUID: Gcp0S6Zx_LlN-xwGBe6Jy9m990EvPXAE
X-Proofpoint-ORIG-GUID: Gcp0S6Zx_LlN-xwGBe6Jy9m990EvPXAE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE4MDA2OCBTYWx0ZWRfX/PSX05fS1r40
 Ytge1LBGfA1AJwty1324i6r/2fqPEFlxIqqQfkYdzekOUkCVMcBO6p09wfe6mwynea51DTb4pEL
 /ekvQ7EzOYJ3BQKWDbTycPYlsF6BMgz/1bpLdkudr2KjE49K/OS4jCSxPgy0PQQR1em0sKQAXl6
 I1qcx/txWE07aZrMkq/XtyTFoyPNInFbufjbl6CfOdzly0YQTLWzSTVj4S0hsdGsTcb+rcSCvFH
 AG3IHaEixujYWDuXazyCYJBPivpzPGTb6YJ3OPgy613J7nlgv9fektWCBvl/wXj1mDKJzj4W4xq
 ORHPaHaEFxSi2xNE+w9jrLvlUaqf3Q6gKAAy+Dq+E+O5/cENrwWLXsAlTiUhUKR0JmoqcPA/xkc
 nLTbd5YiUegejcJjPvEEiY2qT9O0gyKsJSXnD/VwQ81wvJQkWPqZq3IDzC7O7urusqWkynSwAKZ
 dVuGOwoBmFWVq6YXvzw==
X-Authority-Analysis: v=2.4 cv=PMeaavqC c=1 sm=1 tr=0 ts=6ad4fcc7 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=CzSfKeaMSJ9arFq4QbgA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-18_03,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 spamscore=0 clxscore=1015 suspectscore=0
 priorityscore=1501 adultscore=0 malwarescore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610180068

stmmac_rx_zc() assumes a 1:1 mapping between a received frame and an
XSK pool buffer and drops any frame that spans more than one RX
descriptor:

        /* XSK pool expects RX frame 1:1 mapped to XSK buffer */
        if (likely(status & rx_not_ls)) {
                xsk_buff_free(buf->xdp);
                buf->xdp = NULL;
                dirty++;
                count++;
                goto read_again;
        }

The non-last descriptors are freed and dropped, but the frame is not
marked as errored. When the poll reaches the last descriptor of the
same frame, error is still 0, so the fragment is handled as a complete
frame: it is passed to the XDP program, copied into an skb on XDP_PASS,
or converted for XDP_TX. The tail starts in the middle of the original
payload at a predictable offset and, parsed as a fresh frame (len == 0),
stmmac_rx_buf1_len() reports the full dma_buf_sz length for it even
though the DMA engine only wrote the tail remainder into that buffer, so
the reads extend past the received bytes and can reach beyond the end of
the XSK pool buffer. GMAC4 always enables jumbo frames (GMAC_CONFIG_JE
in GMAC_CORE_INIT), so an on-link peer can trigger such a split even
when the interface MTU is left at 1500.

Set error when the 1:1 mapping check drops a descriptor, so the
remaining descriptors of the frame - including the last one - are
drained and released with xsk_buff_free() instead of being processed as
a new frame. Account every freed buffer with dirty and count the
dropped frame once in the poll budget / rx_pkt_n. The direct 1:1
mapping drop also increments rx_dropped.

Normalize the legacy normal and enhanced descriptor callbacks to report
rx_not_ls together with discard_frame for non-last descriptors. This
allows both stmmac_rx_zc() and stmmac_rx() to drain split frames on
dwmac100 and dwmac1000 instead of reparsing the final fragment as a new
packet.

Fixes: bba2556efad6 ("net: stmmac: Enable RX via AF_XDP zero-copy")
Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>
Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
---
 drivers/net/ethernet/stmicro/stmmac/enh_desc.c    |  2 +-
 drivers/net/ethernet/stmicro/stmmac/norm_desc.c   |  2 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 21 +++++++++++++--------
 3 files changed, 15 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/enh_desc.c b/drivers/net/ethernet/stmicro/stmmac/enh_desc.c
index 051253601225..297e2428a8f9 100644
--- a/drivers/net/ethernet/stmicro/stmmac/enh_desc.c
+++ b/drivers/net/ethernet/stmicro/stmmac/enh_desc.c
@@ -184,7 +184,7 @@ static int enh_desc_get_rx_status(struct stmmac_extra_stats *x,
 
 	if (unlikely(!(rdes0 & RDES0_LAST_DESCRIPTOR))) {
 		x->rx_length++;
-		return discard_frame;
+		return discard_frame | rx_not_ls;
 	}
 
 	if (unlikely(rdes0 & RDES0_ERROR_SUMMARY)) {
diff --git a/drivers/net/ethernet/stmicro/stmmac/norm_desc.c b/drivers/net/ethernet/stmicro/stmmac/norm_desc.c
index c4b613564f87..d19bf7ca4db3 100644
--- a/drivers/net/ethernet/stmicro/stmmac/norm_desc.c
+++ b/drivers/net/ethernet/stmicro/stmmac/norm_desc.c
@@ -70,7 +70,7 @@ static int ndesc_get_rx_status(struct stmmac_extra_stats *x,
 
 	if (unlikely(!(rdes0 & RDES0_LAST_DESCRIPTOR))) {
 		x->rx_length++;
-		return discard_frame;
+		return discard_frame | rx_not_ls;
 	}
 
 	if (unlikely(rdes0 & RDES0_ERROR_SUMMARY)) {
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 8fd2acb25fb6..efa88cd359da 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -5695,18 +5695,21 @@ static int stmmac_rx_zc(struct stmmac_priv *priv, int limit, u32 queue)
 		if (priv->extend_desc)
 			stmmac_rx_extended_status(priv, &priv->xstats,
 						  rx_q->dma_erx + entry);
-		if (unlikely(status == discard_frame)) {
-			xsk_buff_free(buf->xdp);
-			buf->xdp = NULL;
-			dirty++;
+
+		if (unlikely(status & discard_frame)) {
 			error = 1;
 			if (!priv->hwts_rx_en)
 				rx_errors++;
 		}
 
-		if (unlikely(error && (status & rx_not_ls)))
-			goto read_again;
 		if (unlikely(error)) {
+			xsk_buff_free(buf->xdp);
+			buf->xdp = NULL;
+			dirty++;
+
+			if (status & rx_not_ls)
+				goto read_again;
+
 			count++;
 			continue;
 		}
@@ -5715,8 +5718,9 @@ static int stmmac_rx_zc(struct stmmac_priv *priv, int limit, u32 queue)
 		if (likely(status & rx_not_ls)) {
 			xsk_buff_free(buf->xdp);
 			buf->xdp = NULL;
+			rx_dropped++;
+			error = 1;
 			dirty++;
-			count++;
 			goto read_again;
 		}
 
@@ -5883,7 +5887,8 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
 
 		if (priv->extend_desc)
 			stmmac_rx_extended_status(priv, &priv->xstats, rx_q->dma_erx + entry);
-		if (unlikely(status == discard_frame)) {
+
+		if (unlikely(status & discard_frame)) {
 			page_pool_put_page(rx_q->page_pool, buf->page, 0, true);
 			buf->page = NULL;
 			error = 1;

-- 
2.56.0

