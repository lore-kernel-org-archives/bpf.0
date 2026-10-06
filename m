Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98C373DD52F
	for <bpf@vger.kernel.org>; Tue,  6 Oct 2026 10:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791280980; cv=none; b=OFazsRBXZsGwPO7A7kTzDYGA29n5YQeAsDh3ja3Fs3O6Ue7jtKBpR20Ub2L8OoxcnVKzhtGgTTgF9YwF1iosX/kf88A/61Pi9MJH41eSsVOKC2FdsV/VG7tg2LJOaR8ml/v3NHNIjmOng5AqTIunziP3ZqSLaOBGLoBXCSEcmFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791280980; c=relaxed/simple;
	bh=a8mYNKv/6C/ol7fNCVlFzgmjbE3CW4t6hwcDGAqT47I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YXcCWpuaYpXKY82qly1qju/bzQZ9UfK6mt7KsZ1VqlEbf/lKP9jo9QvRwfQA8iYGMCnQnrnkDI7EBLkfE/Ned63rNFv/PD/tG2Enaj60pfnZE6pd6r1QESA285JIabxUua9KU2wswpJpq3JOHdVPTRGXWL2Hu+viPAcCO3Rgrww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lbaf0yuI; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=TAQkLecB; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lbaf0yuI";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TAQkLecB"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6969ROKM423857
	for <bpf@vger.kernel.org>; Tue, 6 Oct 2026 10:02:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	oN5c5C6mMFvL5ZPcPquH7i2hkaLLpvXIcmDHaSD6DKg=; b=lbaf0yuIoc7/Xhua
	2E7x0tB7/UVjy+2vHp164jVYHcqc2SgXiAhaqd9AVFmcshBiPcklrIAm3PL3iAVT
	2LQVCaRfXxsEz1W4wQrl8mthsLkhVTgxEUeiCTXT6We9aTXIqieWl5/sku5c1JP5
	Lrm71EAQpMGFpTtgToTm96ofmA5zZgHk9KsF8kuCr620X1WLZ801xoetq+MxVKyD
	9Hjlad/LxfrkZbBbJGkdKzRi8db5YqtBY3Wlu5rJQhSMy6sN347AJ4jy9LjR+KnT
	ve0b5wOzb6EYyYX1w86i4KeIyAIKxZMqSpn9yOVwfF1NfQ6uqxCZ8NvWF39hFJwZ
	KkyUOQ==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com [209.85.217.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h4xc9r462-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Tue, 06 Oct 2026 10:02:57 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id ada2fe7eead31-7c39a674d83so717474137.1
        for <bpf@vger.kernel.org>; Tue, 06 Oct 2026 03:02:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791280977; x=1791885777; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oN5c5C6mMFvL5ZPcPquH7i2hkaLLpvXIcmDHaSD6DKg=;
        b=TAQkLecByt3o33z8RZ8nqXLklfIokYyVHMqIF8Z5kl5JI8w1sZnCa2THUW4rYD4mpY
         6HZdJ+pxXimB9MzcecTjboyM6UNamI5NIK94jwuBps6T52sN6Q0ESRkolE6TNvYPLxs4
         XrVe9FAytWTcBqieVZospmH13kWtJyEOYGtlrrn46ZJ57irrbOaryEfM6G0tzgSjxtOM
         a5Ie6g/LYbhp3yneYXtPQzMTlD5P5miYQptC+2WnuY2hdVm5SjY1H7f0KytK59gXyWIs
         VLrwR4pLKU/rWfGQ5NxSzVHqQifTIPuelncx8mh0PM1ue1HMr7ccirdSN8Fv6EDfBCll
         vZ+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791280977; x=1791885777;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oN5c5C6mMFvL5ZPcPquH7i2hkaLLpvXIcmDHaSD6DKg=;
        b=i/GHTv/ahT/D5L4Ea6uufOcNvYLySDPjbOKjOTIhq5dE39YoIOA8LOx3P0VmukMrHB
         QUHRkwvv99a4wC8sM0RTv6HwESHBb19BtZ7OeiIxb98STCrkcJCt92wL5SbaGzycuaCF
         duUz99mIPqEXpiVvSA8Ke7uQnban2NDq0qTfnGir5P+xYcwUc3+skJ5ebXr8hQa0gr4u
         z4rf0+EAQyOml+igKjl4iavM6XJ+h6U49TwgoWG3hS+Rcr8TvUTOoZ05Al2jNKglhg/O
         V4Ps1Zt86aC9uBhz6p6Ys9zCE70XXCn6z5ls3f9Zu8QptHyMAMzf2SegUNH5jY9bXTzj
         k9uA==
X-Forwarded-Encrypted: i=1; AKwUvByyBf6TQZiOveTj3sxQPQahVzXNTPodSfktkiL56UcbxMf2PqKJZXXzDNCNcUWO9owV0Cw=@vger.kernel.org
X-Gm-Message-State: AFuF++kRopfHQqT9LqrAuijx/5cK0kjaErrph2JIy20ppxE5S9RcfvFe
	5qAIcO1jUcb0pYL7InCuIm2KYT5p/YDNlrvwAWuLOs/26P17k3Id/+Ol9SicsU5bioY5Mex/mef
	QzlAD1DtYryMg4jxLLYY/+B2i/+yaateFVJJmRoGQSBEL2fvQjV93IMg=
X-Gm-Gg: AYBFou2BwbgJyYqA1EGOP4GZ5bLIasEcbV+k1tRAHWBKwSlyy60Bk2jklFjGCPnJA93
	b1raE/wHDO+QQ/aRhY9F+WGOL9WcfE5ke+2NO7YU3iu118nn97A7m28tdAcMHllBPAqY3WIEwLK
	OZTLnMIFEIsC7doRcASzokBzUb9LnAwB7c/E0By4X8zuvQs+0ECpsTi/DgVN/wlwU3up5HE5xf1
	2eh/I+sVjwFU4Y3ILxvtJ6186/H87NBTxSH1UuyYZsQZvQT3lTERg01i4cj4c03AIu1CAv5/uQj
	1AqbuSHSsAiMJ99GRbFZ8FGhrEiFT794in29KRWaY34zk3BpJmxz8lgSh7FcTSHpvRec6WaDWXY
	q7b0iInWObtQIZA==
X-Received: by 2002:a05:6102:8485:10b0:7bc:58ff:2cc0 with SMTP id ada2fe7eead31-7c7e0d78062mr411811137.22.1791280976528;
        Tue, 06 Oct 2026 03:02:56 -0700 (PDT)
X-Received: by 2002:a05:6102:8485:10b0:7bc:58ff:2cc0 with SMTP id ada2fe7eead31-7c7e0d78062mr411790137.22.1791280975979;
        Tue, 06 Oct 2026 03:02:55 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48c6229ee60sm8939711f8f.34.2026.10.06.03.02.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 03:02:55 -0700 (PDT)
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Date: Tue, 06 Oct 2026 12:02:20 +0200
Subject: [PATCH net-next v4 1/2] net: stmmac: take ownership of saved RX
 state at poll entry
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261006-stmmac-rx-mb-v4-1-efa4ca974e3d@oss.qualcomm.com>
References: <20261006-stmmac-rx-mb-v4-0-efa4ca974e3d@oss.qualcomm.com>
In-Reply-To: <20261006-stmmac-rx-mb-v4-0-efa4ca974e3d@oss.qualcomm.com>
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
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org,
        James Hilliard <james.hilliard1@gmail.com>,
        Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Authority-Analysis: v=2.4 cv=ctMOAF4i c=1 sm=1 tr=0 ts=6ac4c751 cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=C0-oZMIz0aWSf3JA_4MA:9 a=QEXdDO2ut3YA:10
 a=gYDTvv6II1OnSo0itH1n:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA2MDAzOSBTYWx0ZWRfX+Rn5UZH06smy
 u6vZpZfC88uvaQEeP5xL1I3wsBb/afiUMHmeKQgtYP+YAsXIm2YZFtiwyf3d+1tWfEqd7F6D+zH
 WMrZ2+MkDurvMuo+ukBUfx1XSGnZp1M=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA2MDAzOSBTYWx0ZWRfX/wO363S+aAAA
 Y1sOt7FEZHjPoFU+Isu5jaZjUUPTTfQsWSsWbbF9/zyChafJk3LEBWrWGhcgGgDBQxaxmwqDlr1
 RoDGGPtQdslvJYKKqglw38TSbgeobEqiltVGkQfoEjWHGyWgvuy6rIYCuemEwgxKm8jGazEQxLb
 6eA/ULSuJRKdos50iQPJ54LV80CtN6lp+THpEsEJHm2HYCf9xuh6K0McSXwvP1MwqsKn2XsfC3p
 Eq2F92fvzGb6OXbHmkDcmoB7Pb0UEnA1Uq5g/qe4NjtzLm1yZvJKiTu0omiTDmhEMnuGTpLkQVW
 wGipRlr967FnImZcNRmRw/E49W3tEt/lf9Y2d7YGyYeiBEJ1q+NizY5miIjx4lEdu5TjQQcYbqI
 JB5WSc49Cdfp8ELbuzwSfBU3ux7Qc/BM3V879RQDeHe7hDMZ6cXCzSQ2IE1zipkqkgzC1Ss+sJO
 MluxFYHEIwJeA5MdO6w==
X-Proofpoint-ORIG-GUID: j_r0XEe6ylna3-o4h3D9dQhFs9uajNlX
X-Proofpoint-GUID: j_r0XEe6ylna3-o4h3D9dQhFs9uajNlX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-06_02,2026-10-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015
 bulkscore=0 suspectscore=0 spamscore=0 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610060039

From: James Hilliard <james.hilliard1@gmail.com>

When a saved partial packet completes with a poll budget of one, the
old loop can leave state_saved and state.skb pointing at an skb that
has already been delivered or freed. The next poll then reuses that
pointer, causing a use-after-free or double free.

Take the saved state at poll entry and clear the stored ownership
immediately. Save it again only if the packet remains incomplete,
including when the next descriptor is still DMA-owned.

The saved state is also dropped when the queue parameters are reset, not
only when the ring is destroyed: stmmac_reset_rx_queue() is reached from
__stmmac_open(), stmmac_xdp_open(), stmmac_resume() and
stmmac_enable_rx_queue(). Otherwise a partial frame saved before suspend
(or before a queue is disabled and re-enabled) survives while cur_rx and
dirty_rx are re-armed, and the first poll resumes that stale skb with
descriptors from the freshly initialized ring. Teardown still releases it
in __free_dma_rx_desc_resources().

Apply the same state handling to stmmac_rx_zc(), which also leaves
state_saved set when a saved frame finishes at the budget boundary.
That path saves only error and length bookkeeping, not an skb pointer.
Track whether a frame remains incomplete independently of the status
read from the next descriptor, so a DMA-owned descriptor does not erase
the continuation state.

Fixes: ec222003bd94 ("net: stmmac: Prepare to add Split Header support")
Fixes: bba2556efad6 ("net: stmmac: Enable RX via AF_XDP zero-copy")
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 85 ++++++++++++-----------
 1 file changed, 44 insertions(+), 41 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 0cfd14d24002..28e9f8438f93 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -2180,6 +2180,9 @@ static void __free_dma_rx_desc_resources(struct stmmac_priv *priv,
 	else
 		dma_free_rx_skbufs(priv, dma_conf, queue);
 
+	dev_kfree_skb_any(rx_q->state.skb);
+	rx_q->state.skb = NULL;
+	rx_q->state_saved = false;
 	rx_q->buf_alloc_num = 0;
 	rx_q->xsk_pool = NULL;
 
@@ -5580,12 +5583,12 @@ static int stmmac_rx_zc(struct stmmac_priv *priv, int limit, u32 queue)
 	unsigned int count = 0, error = 0, len = 0;
 	int dirty = stmmac_rx_dirty(priv, queue);
 	unsigned int next_entry = rx_q->cur_rx;
+	bool in_progress = rx_q->state_saved;
 	u32 rx_errors = 0, rx_dropped = 0;
 	unsigned int desc_size;
 	struct bpf_prog *prog;
 	bool failure = false;
 	int xdp_status = 0;
-	int status = 0;
 
 	if (netif_msg_rx_status(priv)) {
 		void *rx_head = stmmac_get_rx_desc(priv, rx_q, 0);
@@ -5596,23 +5599,25 @@ static int stmmac_rx_zc(struct stmmac_priv *priv, int limit, u32 queue)
 		stmmac_display_ring(priv, rx_head, priv->dma_conf.dma_rx_size, true,
 				    rx_q->dma_rx_phy, desc_size);
 	}
+
+	if (rx_q->state_saved) {
+		error = rx_q->state.error;
+		len = rx_q->state.len;
+		rx_q->state_saved = false;
+	}
+
 	while (count < limit) {
 		struct stmmac_rx_buffer *buf;
 		struct stmmac_xdp_buff *ctx;
 		unsigned int buf1_len = 0;
 		struct dma_desc *np, *p;
-		int entry;
+		int entry, status;
 		int res;
 
-		if (!count && rx_q->state_saved) {
-			error = rx_q->state.error;
-			len = rx_q->state.len;
-		} else {
-			rx_q->state_saved = false;
+		if (!in_progress) {
 			error = 0;
 			len = 0;
 		}
-
 read_again:
 		if (count >= limit)
 			break;
@@ -5651,6 +5656,8 @@ static int stmmac_rx_zc(struct stmmac_priv *priv, int limit, u32 queue)
 		if (!buf->xdp)
 			break;
 
+		in_progress = status & rx_not_ls;
+
 		if (priv->extend_desc)
 			stmmac_rx_extended_status(priv, &priv->xstats,
 						  rx_q->dma_erx + entry);
@@ -5665,6 +5672,7 @@ static int stmmac_rx_zc(struct stmmac_priv *priv, int limit, u32 queue)
 
 		if (unlikely(error && (status & rx_not_ls)))
 			goto read_again;
+
 		if (unlikely(error)) {
 			count++;
 			continue;
@@ -5723,7 +5731,7 @@ static int stmmac_rx_zc(struct stmmac_priv *priv, int limit, u32 queue)
 		count++;
 	}
 
-	if (status & rx_not_ls) {
+	if (in_progress) {
 		rx_q->state_saved = true;
 		rx_q->state.error = error;
 		rx_q->state.len = len;
@@ -5765,9 +5773,10 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
 	struct stmmac_rx_queue *rx_q = &priv->dma_conf.rx_queue[queue];
 	struct stmmac_channel *ch = &priv->channel[queue];
 	unsigned int count = 0, error = 0, len = 0;
-	int status = 0, coe = priv->hw->rx_csum;
 	unsigned int next_entry = rx_q->cur_rx;
+	bool in_progress = rx_q->state_saved;
 	enum dma_data_direction dma_dir;
+	int coe = priv->hw->rx_csum;
 	unsigned int desc_size;
 	struct sk_buff *skb = NULL;
 	struct stmmac_xdp_buff ctx;
@@ -5787,25 +5796,28 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
 		stmmac_display_ring(priv, rx_head, priv->dma_conf.dma_rx_size, true,
 				    rx_q->dma_rx_phy, desc_size);
 	}
+
+	if (rx_q->state_saved) {
+		skb = rx_q->state.skb;
+		error = rx_q->state.error;
+		len = rx_q->state.len;
+		rx_q->state.skb = NULL;
+		rx_q->state_saved = false;
+	}
+
 	while (count < limit) {
 		unsigned int buf1_len = 0, buf2_len = 0;
 		enum pkt_hash_types hash_type;
 		struct stmmac_rx_buffer *buf;
 		struct dma_desc *np, *p;
-		int entry;
+		int entry, status;
 		u32 hash;
 
-		if (!count && rx_q->state_saved) {
-			skb = rx_q->state.skb;
-			error = rx_q->state.error;
-			len = rx_q->state.len;
-		} else {
-			rx_q->state_saved = false;
+		if (!in_progress) {
 			skb = NULL;
 			error = 0;
 			len = 0;
 		}
-
 read_again:
 		if (count >= limit)
 			break;
@@ -5834,6 +5846,8 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
 
 		prefetch(np);
 
+		in_progress = status & rx_not_ls;
+
 		if (priv->extend_desc)
 			stmmac_rx_extended_status(priv, &priv->xstats, rx_q->dma_erx + entry);
 		if (unlikely(status == discard_frame)) {
@@ -5846,11 +5860,10 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
 
 		if (unlikely(error && (status & rx_not_ls)))
 			goto read_again;
+
 		if (unlikely(error)) {
 			dev_kfree_skb(skb);
-			skb = NULL;
-			count++;
-			continue;
+			goto next;
 		}
 
 		/* Buffer is good. Go on. */
@@ -5909,24 +5922,12 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
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
 					buf->page = NULL;
-					skb = NULL;
-					count++;
-					continue;
+					goto next;
 				}
 			}
 		}
@@ -5983,10 +5984,8 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
 		/* Remove FCS if needed */
 		if (!fcs_stripped && pskb_trim(skb, len)) {
 			dev_kfree_skb_any(skb);
-			skb = NULL;
 			rx_dropped++;
-			count++;
-			continue;
+			goto next;
 		}
 
 		stmmac_get_rx_hwtstamp(priv, p, np, skb);
@@ -6011,14 +6010,15 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
 
 		skb_record_rx_queue(skb, queue);
 		napi_gro_receive(&ch->rx_napi, skb);
-		skb = NULL;
-
 		rx_packets++;
 		rx_bytes += len;
+next:
+		in_progress = false;
+		skb = NULL;
 		count++;
 	}
 
-	if (status & rx_not_ls || skb) {
+	if (in_progress || skb) {
 		rx_q->state_saved = true;
 		rx_q->state.skb = skb;
 		rx_q->state.error = error;
@@ -8338,6 +8338,9 @@ static void stmmac_reset_rx_queue(struct stmmac_priv *priv, u32 queue)
 {
 	struct stmmac_rx_queue *rx_q = &priv->dma_conf.rx_queue[queue];
 
+	dev_kfree_skb_any(rx_q->state.skb);
+	rx_q->state.skb = NULL;
+	rx_q->state_saved = false;
 	rx_q->cur_rx = 0;
 	rx_q->dirty_rx = 0;
 }

-- 
2.55.0

