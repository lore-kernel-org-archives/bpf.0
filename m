Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ACA24ED186
	for <bpf@vger.kernel.org>; Wed, 14 Oct 2026 13:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791983401; cv=none; b=JJ36fpjEfOiWNP8GdyzLYoBZeRXGqs17bCJW4jf4h9qFLSNnp84bEFzq1Y2a5muSKv/d7fE2Xix84Gz+PR1H7OBl3Vfv7iYrnOMH7fAivMU8fMGEPH5CM052R3e/GJ3uah4PA7Q8TUqFJ6KOajHWgoeyqSDApwd/pT1BBLsGy3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791983401; c=relaxed/simple;
	bh=qH17lBmgiVluKz5vouUMh+s0kY40L+S6WMyX+1BJDBY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kkgHm73QVIzv1ZS6Ty/smYlxqcP+6jPZdlMIdQKH+ZskcRwHLVKUk+626sW4xDtdrWvpAgv3rP4RtzxQpe+w2YcdyLk84/ftajJx2hAWMmBctxeHkQp0nbWQOHEpP2LWxhxYbpuxSh6BN1nQUOeOdTFzr6z0nadcZ6dAauqOxEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NJVrRUys; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=jJpdsje0; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NJVrRUys";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jJpdsje0"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69EBK9bT3951552
	for <bpf@vger.kernel.org>; Wed, 14 Oct 2026 13:09:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1VCwModZDCtBhM3y4K1tnj8cU+tnsu+uFycA0xv3Trc=; b=NJVrRUysbB17dyLJ
	IayeCz8/x52ovPqtRHaoVKrSx6jZ+ORObHAy4JN2OGF7BPdBhY+HmbEX04KDy1Aa
	KI/k1JB72Vy4E+F1hmgXXETGKRQGRpnr+If6XyCKhKKvhnk0yY8lmDwDT8SQXCXM
	9G1M7tNhtZisPOnSJPUvf/3ALKWhFIrXkLx1LmvT1i6vPuMnVJB3HmRzyOWTcGif
	UqHowTzsjUSbYl0cXutXVMSNKa7Tm18sKD7t5Ksi7NlV+r2N1xrY50q36foVdWtz
	MwieIOkyhBw9/Za4j58A7WiolIzAcsOYdKoKc9mt0IFKe1jxA2HQtmPEo5sY+6+D
	JB7cCw==
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com [209.85.222.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ha42p1qw5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Wed, 14 Oct 2026 13:09:59 +0000 (GMT)
Received: by mail-ua1-f70.google.com with SMTP id a1e0cc1a2514c-98a829c43f3so283745241.1
        for <bpf@vger.kernel.org>; Wed, 14 Oct 2026 06:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791983398; x=1792588198; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1VCwModZDCtBhM3y4K1tnj8cU+tnsu+uFycA0xv3Trc=;
        b=jJpdsje0dQX33epjfj/sEHsyqxtSRsDzDZP+sh481z6W8E57lKGhW2E2sHaTlBK26g
         WmqqmdwOUZHic3FPgtTePvv+ZILENR2qR+HpnzJ9XgI7h1+H+SHa2M2enUtEp0QtM+LK
         OWjqgQV9iTouXH5iDsudjWRNeIlhZV4kWF0Wqny7kGbpXKdZAD+3Wn39HYUcU3Mh3fUc
         JNBZU04haaHKnSV+wt0ZTUHtV8DGpTDKIogj9j5Y19G8NVxCBTMvtTi9HxbndHNlJAB1
         4gpK/btI5t4FO1cVZ/KMu7y6aVp8IzK8LGrTVlMTA8a1Q/4j4R7W04RTUR15ZTj06CSi
         nHGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791983398; x=1792588198;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1VCwModZDCtBhM3y4K1tnj8cU+tnsu+uFycA0xv3Trc=;
        b=wsdOnw4y7opodBfic9T3++05UmctOirJIdzrDwQbE5blJl8l1Dj8A59LCQUBrWnLav
         IJr+sw5o6qUiCSIYhpI88PNU0DANmuuxWQhd8hwnYlSBUoOjTbJZx1ZtgEKZWhnqTUo1
         LGocOQCLsn8zmsQ5hdUNbEgD1dPaCaYgFVCvgY9lmAeJ20VO13eFpMmbduGavm+j2k21
         4WHaNcXxBfETK4DRHlfb4iQ1+2Z/qmHupzZA8rqtWTW2YYBZMQKlu3+db4S6u+6JtPBU
         PM9Zn8/rtTINnzf5Bs/VuMZkYnQa8ikq+MKSbaZMh+2CP1IMiSEtQUF8JIOm6PMUtKe6
         JpCw==
X-Forwarded-Encrypted: i=1; AKwUvBxTrPEgP13GpRo/Wx+QmKkWfpIzen14sfyQV+5yRnka30pMQCH2RW8pSDgnB1kvqxEhHZc=@vger.kernel.org
X-Gm-Message-State: AFq9FYK8zHgnmIUedxCSsQ5VXLzf6jGXaopu5rpOVu9sA8OL75uBxfk6
	NqTToJZGf5Fg5VBA5HAZijn4f9nRnEpjltUTN5Sl3xR3OKKHx8rk0Aoh2FUwfGvLJE8EQGnR16l
	NT8zmB8tgTR0Q8H8QI5bzv84ZVdxHxnAGo6x+2T8CswhPoVU3cg4PEnY=
X-Gm-Gg: AYBFou3zwTXc2/BR4S0mCEZtAOyO76Y8s0LYiEfF3qW/wItzzQYRZXcX5xVaipDSWZc
	NfHF3OjL8A4I4YBzC66ClgCyBNq8hRx9u6Z8yQdvjAKH5FlnBmYxxJfy9ii8A6P5rOMagxD1igJ
	WP5TNS8xQ6fdVX6gyRA84eiteUVp78FrsDwKB6YCuEcEMQD/CD3xgueLI6m7NOxmzK8ElDeYsr9
	xEMXdDJueUbGo9NeT/nTNpatssL3JKxHjSgUp4blplixdF12Bfq9DXn1m4jcCwDf6tZZRrzP+Dv
	gZBqkJqJlGG7rCWD4UHCWyl1rqgoBk97rNOCql65VWMp4y4F5vtooFXDR0Fhf75uaQbXIOnTDB/
	m3kBVEgrA9lWxDQ==
X-Received: by 2002:a05:6102:1609:b0:7c3:7286:b7ea with SMTP id ada2fe7eead31-7cb372de97dmr3646949137.17.1791983398183;
        Wed, 14 Oct 2026 06:09:58 -0700 (PDT)
X-Received: by 2002:a05:6102:1609:b0:7c3:7286:b7ea with SMTP id ada2fe7eead31-7cb372de97dmr3646922137.17.1791983397411;
        Wed, 14 Oct 2026 06:09:57 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1b2ec47fcsm55844895e9.1.2026.10.14.06.09.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 06:09:56 -0700 (PDT)
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Date: Wed, 14 Oct 2026 15:09:36 +0200
Subject: [PATCH net-next v7 2/4] net: stmmac: drop split frames on AF_XDP
 zero-copy RX
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261014-stmmac-rx-mb-v7-2-5d2d70f052cd@oss.qualcomm.com>
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
        bpf@vger.kernel.org, Nicolai Buchwitz <nb@tipi-net.de>,
        Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDA1MiBTYWx0ZWRfX/ct3XKqkmU53
 7+32b3oMoBJs9qeZbWZ9r6Xul9kEdkKbIJB6k2ivbpuntqdJ1K66Zr1fYbYZfoyXCGrRK6Z5VZB
 eIq8Ul58gWkO+QgF/tayi7zFo9P88Vo=
X-Proofpoint-ORIG-GUID: OWoh8fGoXngOsMYBggNr6oG6VeatRJoJ
X-Authority-Analysis: v=2.4 cv=aeb0Dhot c=1 sm=1 tr=0 ts=6acf7f27 cx=c_pps
 a=R6oCqFB+Yf/t2GF8e0/dFg==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=CzSfKeaMSJ9arFq4QbgA:9 a=QEXdDO2ut3YA:10
 a=TD8TdBvy0hsOASGTdmB-:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDA1MiBTYWx0ZWRfX8CiB9CR4SzCA
 HRx74S448MHjUy2ljFEuvQdmkwpMtwUw/jdLOVBNxbWYvtmu2buSnvOhRTXwadQk6q4lTt69bs7
 os/teYNZqnUJXmZHvKV/VgDxY2upHyxlazr2PGjQOQjfhOA7k73ev/gE7Gs0UfiBAej9KV3nhJD
 8QEAEclySpAvuoqRatiVP6jCRf6GSQYsDqeSNmiKrfMNRehrdPKoAYH1ZffEAPNhMM/a9znfQoT
 OuFStU1T0wRsvACIS4KeyDwvPy2XLnRep40Xov4dZ4yipqvkk0dISBr0Hawys3ouXovts5CySBj
 FR+5X4ptZdC364tqW/agk4vrZRSCYckxrWoJMYH+KtcUERznQ1JtjdR9ZaIWufqXOxVxnQ7EFcC
 QObRMK/oCtH8GJnzs9tUp8fiFUwZA26WXt/A6BNWrIRsngXMdnID3NrhpEY5YL8aKZF1ViM1mS6
 x3rH6nqEFEz21cBAxDg==
X-Proofpoint-GUID: OWoh8fGoXngOsMYBggNr6oG6VeatRJoJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0
 spamscore=0 priorityscore=1501 malwarescore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610140052

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
index f0835be2f65a..10ea72cbf889 100644
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

