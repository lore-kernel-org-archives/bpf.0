Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6631C4756B3
	for <bpf@vger.kernel.org>; Fri,  9 Oct 2026 10:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791541612; cv=none; b=Iq6KhM7Wy3tYHwuzSwZ1b0IiZRrNsy/O+Oq5M3MC3LO608l7paY/HyJWB2SuJsQfsAYEcDfXMuEPPv0E+jYPaaj9/n8jcWtlkw66gEwrriQmVyo6a5qDwoAxTU/9S+4Ya2SGkQDhEL2ELgrVxeSi0oGL9yXS649VlPerf4ORsWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791541612; c=relaxed/simple;
	bh=Nk2oHc0S+an0SJbWa87nOo/M/OGV44NOYo0Hc2tbvIQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XiMeNwo/Y7dcH9U5DeXL4wa6/6/pigpNHZ7rbgJFdojF8YdPUXcKv+fdzUxkL+xW4A1r3YnvWotmq618Pp5bQ+U2X/Zkm1k/feqOr+WFAdCNPBf+kt1SHowjkYdsrJajEPePaSwSjWCOPurPe5m+HhIrieaWhsrhN96uogo4gyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dw1ldf14; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ZfiFSy6C; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dw1ldf14";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZfiFSy6C"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6998KOj83977815
	for <bpf@vger.kernel.org>; Fri, 9 Oct 2026 10:26:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	mbx0B8E4rswN7y1i29QZmuCEkbeS+5J7m8P2MfSnmDY=; b=dw1ldf14G3IGkyyM
	4AWcy6cGpqOY/9Wr2UrP8m/vXnlDZK6g0mYmc31qtbuzqYY9FA5Z5jOq4OdHUedm
	PJ9ldk9iF1g1GyARflJxvV3JH7V1dYiH+52UtrIo77+rrhEUN1tzj3UfxxVWulrr
	UE/iMEHmkgbB4Jfd/uxN1CBMNxB+4EAxU+o6PGSW0w+6PCCsfwNkMqAPa3spdK2W
	nvD0UxmcXgjXUsSsjiQU7TrvMBZ0iMKYKsG+m1krnnSxjpZSlKd+ZKtNi3qA4ZgG
	juHKv/q5qxWQgIUsBVUl4CXxURzJjRgRbQ61WTLgiQyC7C8Atwatz7sIx2+1/8jh
	dg80jg==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h6ev5bcnh-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Fri, 09 Oct 2026 10:26:50 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-93e46b4b700so1086647485a.1
        for <bpf@vger.kernel.org>; Fri, 09 Oct 2026 03:26:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791541609; x=1792146409; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mbx0B8E4rswN7y1i29QZmuCEkbeS+5J7m8P2MfSnmDY=;
        b=ZfiFSy6CQLmz79m9JARpoFRfcKEM/+E/Ao7wYapuEeBJZoc0sF9vvlXFR2Pxe9PThd
         ewVLHkLFRzzLm3oO0laYupfbh0xyBE/kc5VXArH0rLRBSCU6pQM7JjSjhGBIBoX8eKVh
         lvDNFgFZEGMfZZ6720BMgDQmUnDHA3GUQ1dVJ4SXAZ82LddXgDavYlgIS8ixIYgVXYhY
         3ezda/e4FnAnD8uOzKd7S/k7qjR5SdU6s02WnK5F9li+ajUaetsx8VvUuFLO5jFu60AD
         dVyIumwENopp2zkXGokrzBtGsAgbtus3WSX0J+ZpVKeq2rjBz0db5gVl5M9xRnREHorc
         3h5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791541609; x=1792146409;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mbx0B8E4rswN7y1i29QZmuCEkbeS+5J7m8P2MfSnmDY=;
        b=IpbJLMabnMj4EHQ0bd51ptdcLyvbkqIuis90DTDxxWrnbd4stAZBv1DygIh8aKHDDn
         JhR1JqqqXQBBhUJdLg37mm8nv1W7xd/EI3HGlEbNOOA1jMYJX4PT853JwCr5FOUxYoZo
         c5cTfdbEda/780UuI0mNYqx//ii95QBf/lz5a6dAB3NfEkm7E+RNQpjFKmv5Hu/DDyU1
         XyTmVO3fz867X2L/2RBbn2Sv7Uzz/761YxNgNktG6sedMDgnXr2vyuWtLGATAxReiDYB
         GV2rVirnHPxtK1KCHYnudHX71j0oq7xvUNuweNEo+tE1c+DvV2MdKYYc/c+qw2/6DjXa
         e5hg==
X-Forwarded-Encrypted: i=1; AKwUvBzghMzaf/3HwMji/zip/YHRNR+dA2KzcrIM4ses1nQBnvaFlTT7qw4wbOGEJwM+vst/aQo=@vger.kernel.org
X-Gm-Message-State: AFuF++kemHH/28AfK7TaLAF/L4OKAuVUA4yxazZl77+63ZDLVwbsRvm0
	AUMOOyBYDZeDTW7Z1Oh0IvasGsSGtGKc25Gq7LzFXy07+7JP5s3gHBIM0TQ+tEqsF4X3JWw6eCU
	LZB8SF3LjMCRoCoB7ihfW7mXMfLD4J8hNVF8xnmeLvtcnOzSvhTUid3c=
X-Gm-Gg: AYBFou1HSclIK7mIdm/OVjF2iTL6ABS3rJwPOn3Uh4C7tI3/gqIZYFW1mbbl0aG/dmN
	8LsP+CA3r+RkACve5RKb7biyLxbbNZPNan+vpJp91k2RkWzN15GH31aiTL+xmI4opNdWnMggRWf
	VVcU8Gv5NNYR8000dlbGVhrAPMrlY4rBlcJHzUvjpLIuZV2fF1sTtrzlIT4oXmWwxucAH6REpk4
	bvssto+3Al7zSUChSDXKovZ216S3bRrOddysOtT2Nk7lQNOtK7AyptvrFGlZIxfUsX9Kp9ziptD
	iSijCwDAgNevO2gI5aRoVuRtRJcXxqZvxr+5nF1OZfRPvrJxgb901XnkuzrkfrlutIEpwthiQpU
	M5fMhm7hQJwvHTA==
X-Received: by 2002:a05:620a:45ac:b0:93a:2bdc:cd57 with SMTP id af79cd13be357-93ebd0c321amr203036985a.2.1791541609306;
        Fri, 09 Oct 2026 03:26:49 -0700 (PDT)
X-Received: by 2002:a05:620a:45ac:b0:93a:2bdc:cd57 with SMTP id af79cd13be357-93ebd0c321amr203032485a.2.1791541608671;
        Fri, 09 Oct 2026 03:26:48 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a18bf3e044sm47679055e9.14.2026.10.09.03.26.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 03:26:47 -0700 (PDT)
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Date: Fri, 09 Oct 2026 12:26:31 +0200
Subject: [PATCH net-next v5 1/3] net: stmmac: take ownership of saved RX
 state at poll entry
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261009-stmmac-rx-mb-v5-1-c38fa4eaa138@oss.qualcomm.com>
References: <20261009-stmmac-rx-mb-v5-0-c38fa4eaa138@oss.qualcomm.com>
In-Reply-To: <20261009-stmmac-rx-mb-v5-0-c38fa4eaa138@oss.qualcomm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDA0MSBTYWx0ZWRfXw6qP8WY/TOMR
 gvvbIWfJR1Ty4YPCCXmGuT41AZG7jE+QqWXVwaXVWhp266xINqo5esnDu1STzHK7Klq3dTftg2H
 SqR9Sx41G6xiZFgHqc9H8GtN4tnGTBI=
X-Authority-Analysis: v=2.4 cv=MMT1C8Zl c=1 sm=1 tr=0 ts=6ac8c16a cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=_b2bW2Sm9mUrZvQRzj4A:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-GUID: -xxucpW52Upv5osA6imrtGp8ne5jfLHf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDA0MSBTYWx0ZWRfX+g83FiaZOS30
 CvxhYrJat6MCVBWjUI1BE/Cag+OytXzPCT1dOSJv19tYlXa3ijSptaoKOLExV88/77GhZxnbVH3
 mXO+kMPIEjgN6I6jUd/QEX0DlN5+D9nqWp6lvrAgNS8mpoi9LrnhwpHfb5ykjpO7NVgxAMeVSSc
 jkd60wvlAPCSfTehy1dgVOxvbiLJoIHr96LrL9/kG6yT9I+lz5weDqTcUpDrvA0dKFHSMnUfVbi
 DTa/H2h3/rgMQFtckfnc4AEs55ePzvnM2w54arGxCJNAJ/rZFMaHEeTJbNVUIKHgLtXV9ArW3GX
 u1a338xJ8mDQk3y5sXJN9iXVGFi5RGcecRzGYymcCyZ3gshL5sbyIZKyKFmwDAO1mGwokJD2jIP
 X+JYdMD719JeOxAOh4FoK++V4dEgigvNT9omwlf52K2huIPcYOdTRJMVloPyvlGdZDd1wTcHx8q
 hSZfe3/DpKSWYhKVVUg==
X-Proofpoint-ORIG-GUID: -xxucpW52Upv5osA6imrtGp8ne5jfLHf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-09_03,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 phishscore=0 clxscore=1015 spamscore=0
 lowpriorityscore=0 adultscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610090041

From: James Hilliard <james.hilliard1@gmail.com>

When a saved partial packet completes with a poll budget of one, the
old loop can leave state_saved and state.skb pointing at an skb that
has already been delivered or freed. The next poll then reuses that
pointer, causing a use-after-free or double free.

Take the saved state at poll entry and clear the stored ownership
immediately. Save it again only if the packet remains incomplete,
including when the next descriptor is still DMA-owned.

Drop the saved state both when the queue parameters are reset and when
the ring is destroyed. stmmac_reset_rx_queue() is reached from
__stmmac_open(), stmmac_xdp_open(), stmmac_resume() and
stmmac_enable_rx_queue(); without draining it there, a partial frame
saved before suspend (or before a queue is disabled and re-enabled)
survives while cur_rx and dirty_rx are re-armed, and the first poll
resumes that stale skb with descriptors from the freshly initialized
ring. __free_dma_rx_desc_resources() releases it on teardown.

Apply the same state handling to stmmac_rx_zc(), which also leaves
state_saved set when a saved frame finishes at the budget boundary.
That path saves only error and length bookkeeping, not an skb pointer.
Track whether a frame remains incomplete independently of the status
read from the next descriptor, so a DMA-owned descriptor does not erase
the continuation state.

Keep the running frame length when an XDP verdict ends a descriptor
early. The old loop returned to read_again for STMMAC_XDP_CONSUMED while
rx_not_ls was set, but the STMMAC_XDP_TX/STMMAC_XDP_REDIRECT path fell
through to the next iteration. Resetting the frame state there makes the
remaining descriptors of the same hardware frame get parsed as a new
frame; on cores with a second RX buffer this makes stmmac_rx_buf2_len()
report more bytes than the buffer holds and read past the page. Route
both verdicts back to read_again while rx_not_ls is set, clearing skb
first since it holds the XDP status rather than a packet.

Fixes: ec222003bd94 ("net: stmmac: Prepare to add Split Header support")
Fixes: bba2556efad6 ("net: stmmac: Enable RX via AF_XDP zero-copy")
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 91 +++++++++++++----------
 1 file changed, 52 insertions(+), 39 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index b8b4de4c5b1a..6128e6d9504c 100644
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
 
@@ -5620,12 +5623,12 @@ static int stmmac_rx_zc(struct stmmac_priv *priv, int limit, u32 queue)
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
@@ -5636,23 +5639,25 @@ static int stmmac_rx_zc(struct stmmac_priv *priv, int limit, u32 queue)
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
@@ -5691,6 +5696,8 @@ static int stmmac_rx_zc(struct stmmac_priv *priv, int limit, u32 queue)
 		if (!buf->xdp)
 			break;
 
+		in_progress = status & rx_not_ls;
+
 		if (priv->extend_desc)
 			stmmac_rx_extended_status(priv, &priv->xstats,
 						  rx_q->dma_erx + entry);
@@ -5705,6 +5712,7 @@ static int stmmac_rx_zc(struct stmmac_priv *priv, int limit, u32 queue)
 
 		if (unlikely(error && (status & rx_not_ls)))
 			goto read_again;
+
 		if (unlikely(error)) {
 			count++;
 			continue;
@@ -5763,7 +5771,7 @@ static int stmmac_rx_zc(struct stmmac_priv *priv, int limit, u32 queue)
 		count++;
 	}
 
-	if (status & rx_not_ls) {
+	if (in_progress) {
 		rx_q->state_saved = true;
 		rx_q->state.error = error;
 		rx_q->state.len = len;
@@ -5805,9 +5813,10 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
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
@@ -5827,25 +5836,28 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
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
@@ -5874,6 +5886,8 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
 
 		prefetch(np);
 
+		in_progress = status & rx_not_ls;
+
 		if (priv->extend_desc)
 			stmmac_rx_extended_status(priv, &priv->xstats, rx_q->dma_erx + entry);
 		if (unlikely(status == discard_frame)) {
@@ -5886,11 +5900,10 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
 
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
@@ -5950,23 +5963,21 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
 					buf->page = NULL;
 					rx_dropped++;
 
-					/* Clear skb as it was set as
-					 * status by XDP program.
-					 */
-					skb = NULL;
-
-					if (unlikely((status & rx_not_ls)))
+					if (unlikely((status & rx_not_ls))) {
+						skb = NULL;
 						goto read_again;
-
-					count++;
-					continue;
+					}
+					goto next;
 				} else if (xdp_res & (STMMAC_XDP_TX |
 						      STMMAC_XDP_REDIRECT)) {
 					xdp_status |= xdp_res;
 					buf->page = NULL;
-					skb = NULL;
-					count++;
-					continue;
+
+					if (unlikely((status & rx_not_ls))) {
+						skb = NULL;
+						goto read_again;
+					}
+					goto next;
 				}
 			}
 		}
@@ -6023,10 +6034,8 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
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
@@ -6051,14 +6060,15 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
 
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
@@ -8378,6 +8388,9 @@ static void stmmac_reset_rx_queue(struct stmmac_priv *priv, u32 queue)
 {
 	struct stmmac_rx_queue *rx_q = &priv->dma_conf.rx_queue[queue];
 
+	dev_kfree_skb_any(rx_q->state.skb);
+	rx_q->state.skb = NULL;
+	rx_q->state_saved = false;
 	rx_q->cur_rx = 0;
 	rx_q->dirty_rx = 0;
 }

-- 
2.56.0

