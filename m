Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 693E847FB0F
	for <bpf@vger.kernel.org>; Sun,  4 Oct 2026 20:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791146575; cv=none; b=NqLlMuTpru8QhbC2aV40x4VtJ7Eaik52CDqDTdozqNGTxp+rZVAA9nfzElyUmUbNSI2dy7M3KVK9MoO7GaxFBzv4KG4DRH8vllVmKHzvlEd2yWG5sYSHMJD9WFolYHBBvUh2lt0vXJw50H6sb9JYMgj/m3IMp+xvn9Cl/xQs8S8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791146575; c=relaxed/simple;
	bh=N5A2hxg7Zk8y9ILY4x5Gqxxt/ha/bmrvPm66Id7q22s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pENwsUe1w1vzRpPjXPdWanNyl1AdQX8gYoJneunuYjO7U2/hRNDEiS3w5kktWS+Pic/Yt9DkKxQEL3SBiumBipsGAM2d42EMSXL7/ajpNRdsskV95/eMxuJbgXQmUvRyjn/ROSc0ZbRS9fLxBA22MN9Z8KAPi7+sfjEf4dFl6Go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ee//qSgm; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=e02gPhed; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ee//qSgm";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="e02gPhed"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 694II58h3673725
	for <bpf@vger.kernel.org>; Sun, 4 Oct 2026 20:42:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	MFLLUGu2HiBjJj5EPsQ0wYfXMvvqmqcb0LYvPjjspzA=; b=ee//qSgmhlyap/nX
	bGJ5dFdrAImlu1oN38GGoFftuBf709oKkZ7sKK+p2svzEwCYamY9dyDuAvO9U5yQ
	0MhcZ8NfFaTHVMUGUVJ3RXTOwHs8ZgK35sv5eh0XJpZ7S541/ifKOkezoWGRtgE1
	K/LvfiBRrJRw65ImwxPpA/VepFP1M8sE9sbfkAJvo0sPNn5t0yhyBh7yhzzEP1j6
	i9+PBlmkwIqEzJq9HQ8DzixV4CVezxLsAODcJga04oG4w0ysWJE+50yz2OmsvJlo
	upDbUW72YgTUtgw+O69EpTtm7iPt/EaqTcFb22+7GPWImQEDJKzIO3Wr4Ktcxpve
	U7N4YQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h2t06uqnd-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Sun, 04 Oct 2026 20:42:53 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-936aa34873bso226819985a.3
        for <bpf@vger.kernel.org>; Sun, 04 Oct 2026 13:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791146573; x=1791751373; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MFLLUGu2HiBjJj5EPsQ0wYfXMvvqmqcb0LYvPjjspzA=;
        b=e02gPhedVZ4A94qe+eH1GaPihtNTcB7xp3804vmdHg0RQMRUwFc6FISClPJoUa8WnD
         sRyu/jWqMU4CQf4tknWjhV093Nzp7FDD9uLVXXauTzECtZZJyJ3Sfx0Lyph722Y3zIK3
         jFAid4p+0Jnu7PBNO/m2y95FzLb6JVLs2EH8+LbvWrUrHoS21Gnt588upTHbqZea5Q4H
         WQ6RHl0UNcrUWLIm5HJWfTZnZt+ZjMl0cxpDy7qLvrgEvbpGh/aITn8drR792e4QoEMC
         rwuNuakB2CyXgEzuxNJ40tuhuRtj3axFZur+9L2HCTt7G7VlB9VCIuxksDI+WTJ79bHu
         HiaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791146573; x=1791751373;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MFLLUGu2HiBjJj5EPsQ0wYfXMvvqmqcb0LYvPjjspzA=;
        b=SDNdN0qtey1e+BM42kfPgyMFKHoCa3jWAMBYVEqlp0+BlC3Yw05gsMBmT8wGDmcpKh
         Z84/JkLtCgHZxUcHI96jFvZzuUKTZXFLSjJRQ700FeUWtZw0FH1quScyllp4jf9bjm44
         ogmzLdwYgalu+kziT+GvuByv8X7mGQWhAiuE4p6Sj4pmzX2rjoV0WWCJKT2xp43vyoWS
         bKurFB0ySeEB4cL2CIZIsgoIzsASWe2zAk4IVMRsjx9gsVNfTmGnkau3WpPI4M7Rfpiz
         xukaFoarOjEJWSmmes28NZSyZ8RZoqQjWkBx60sNz0QxEYtvnv01u/g28tK+UHwYbuOA
         dPuA==
X-Forwarded-Encrypted: i=1; AKwUvByYMfGppEmAExCPSoUWERRcsUuzcYB9143GXQsZsygoqPbefQNO2hDNuyUmqAid20SlY1E=@vger.kernel.org
X-Gm-Message-State: AFuF++nSseo6eLqZnz4ePyhaz+5082UBbLaIBJP6qEuUN0DynuR5EiIH
	HgOw4B5cP6FUMG9FPz869QqAgoLzPzhbfJo/1NgdypC10vubPC2/6j1p0umnANdnjlV0NADqXHI
	CCburCeSreFWIZ+LChapmgxqNyvXQJs8GPl9q2wN4euzrSKl5maJj0CDowItNZEg=
X-Gm-Gg: AYBFou28+gPLZ+YF+X4K/ALfCzrDJoWeCPjY/ig0kSPZ6lG1D9rjy+uPZe85xnS2nDo
	T6gTJ/SKYraCWj7eRO6lwO2sIWf3Qw2w+1D30B9otCludWkyYwpCYgv5vKIPiontAeEK7VA1g6G
	mno8E2T+QwNd4QHgGKw6D5gj7TgNNQC5husGhYJjw3oquiOnQtqTQGRvt5ofnV4nXI3agTFYB3r
	v3EkaoiqNOCT8z3U3yyCpmZMWpFOJp8mkrAWbiDvhF5qf9QRFIJPu2flHRrwyHEbCWE6smj7Abq
	ZHyaE3PyUxfnKYwEurLCZxOhJbZ+t93oLtpegqFkn1G8Ce/eADm3W3nUCgJU/sGryFLOL7Wl3Qd
	O3qEHjZAh9dkvLg==
X-Received: by 2002:a05:620a:710e:b0:939:1222:b9f1 with SMTP id af79cd13be357-93e50bea455mr981063285a.0.1791146572510;
        Sun, 04 Oct 2026 13:42:52 -0700 (PDT)
X-Received: by 2002:a05:620a:710e:b0:939:1222:b9f1 with SMTP id af79cd13be357-93e50bea455mr981060085a.0.1791146572001;
        Sun, 04 Oct 2026 13:42:52 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a16bcb9a21sm227604135e9.10.2026.10.04.13.42.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2026 13:42:51 -0700 (PDT)
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Date: Sun, 04 Oct 2026 22:42:01 +0200
Subject: [PATCH net-next v3 1/2] net: stmmac: take ownership of saved RX
 state at poll entry
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261004-stmmac-rx-mb-v3-1-50fa171af9ec@oss.qualcomm.com>
References: <20261004-stmmac-rx-mb-v3-0-50fa171af9ec@oss.qualcomm.com>
In-Reply-To: <20261004-stmmac-rx-mb-v3-0-50fa171af9ec@oss.qualcomm.com>
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
        James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.14.3
X-Authority-Analysis: v=2.4 cv=cf5HPXDM c=1 sm=1 tr=0 ts=6ac2ba4d cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=pGLkceISAAAA:8 a=Wh313J_-GvSRXK7hiU8A:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-ORIG-GUID: ZQIr4vubeNq5_aLlaJ5bvsvCHmFmnbw_
X-Proofpoint-GUID: ZQIr4vubeNq5_aLlaJ5bvsvCHmFmnbw_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA0MDA4MiBTYWx0ZWRfX6+CBtB40LHFT
 9rubq7CisdK4x7mlrW+941SJKGZhsU6msnDhKKpidgIr6ogpKit4us6krBq8qU0B3bbDyT+/CUx
 XaNctaEmMjgdcJHfTvjCecYKRQa5aJbfGUpztqQEYimPhsNneSS7OLrKdloswbnFSIqAMgM0zlb
 n5cbxLPHHzF6zR6rRK7UUW3wEFBm7tTBFg2YZutZ77VZAAdqFkAG6xnwbKn9goyHabtOwvadpCv
 kSPwSyTSotDh+lF7T7+RBN0CXJ9OMfGqJsXbuh9GkGBm8rCW8UxjL0dHR/jdPW8M2hdg/tslDp5
 aE4o9XCY7+JxDhscXygC7GOTKTTj84MjRWiftpUJnGncEdzQMWRxJh9s3aD1P3qeQUZfj9b4gk8
 4h7gMxMPYT/ANBRvh6D8IiAtcnm3wQ/bpumJE3vOIc/pnRNOF1pfKjd95AspPNR4iVYsxKmCz5z
 wVk9LPHm49ofWQaRDyw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA0MDA4MiBTYWx0ZWRfX5fbfzoQFTVQN
 T2iKJNKwzP1y3Z1lfGVsv7nE5ArgMdcsc0wss/5Vqwp9o3EIzvHgDeFWxGpdfdrUFRgvQ9pbEvt
 xWTqDO3GF4OMljPHWXdBn2Eo6IhSneA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-04_05,2026-10-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0
 priorityscore=1501 clxscore=1015 adultscore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610040082

From: James Hilliard <james.hilliard1@gmail.com>

When a saved partial packet completes with a poll budget of one, the
old loop can leave state_saved and state.skb pointing at an skb that
has already been delivered or freed. The next poll then reuses that
pointer, causing a use-after-free or double free.

Take the saved state at poll entry and clear the stored ownership
immediately. Save it again only if the packet remains incomplete,
including when the next descriptor is still DMA-owned. Release a
saved partial skb when the RX ring is destroyed.

Apply the same state handling to stmmac_rx_zc(), which also leaves
state_saved set when a saved frame finishes at the budget boundary.
That path saves only error and length bookkeeping, not an skb pointer.
Track whether a frame remains incomplete independently of the status
read from the next descriptor, so a DMA-owned descriptor does not erase
the continuation state.

Fixes: ec222003bd94 ("net: stmmac: Prepare to add Split Header support")
Fixes: bba2556efad6 ("net: stmmac: Enable RX via AF_XDP zero-copy")
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 54 +++++++++++++++--------
 1 file changed, 35 insertions(+), 19 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 0c381ae0d0ff..b2d20628ed21 100644
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
 
@@ -5581,12 +5584,12 @@ static int stmmac_rx_zc(struct stmmac_priv *priv, int limit, u32 queue)
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
@@ -5597,23 +5600,25 @@ static int stmmac_rx_zc(struct stmmac_priv *priv, int limit, u32 queue)
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
@@ -5652,6 +5657,8 @@ static int stmmac_rx_zc(struct stmmac_priv *priv, int limit, u32 queue)
 		if (!buf->xdp)
 			break;
 
+		in_progress = status & rx_not_ls;
+
 		if (priv->extend_desc)
 			stmmac_rx_extended_status(priv, &priv->xstats,
 						  rx_q->dma_erx + entry);
@@ -5724,7 +5731,7 @@ static int stmmac_rx_zc(struct stmmac_priv *priv, int limit, u32 queue)
 		count++;
 	}
 
-	if (status & rx_not_ls) {
+	if (in_progress) {
 		rx_q->state_saved = true;
 		rx_q->state.error = error;
 		rx_q->state.len = len;
@@ -5766,9 +5773,10 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
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
@@ -5788,25 +5796,28 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
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
@@ -5835,6 +5846,8 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
 
 		prefetch(np);
 
+		in_progress = status & rx_not_ls;
+
 		if (priv->extend_desc)
 			stmmac_rx_extended_status(priv, &priv->xstats, rx_q->dma_erx + entry);
 		if (unlikely(status == discard_frame)) {
@@ -6019,7 +6032,7 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
 		count++;
 	}
 
-	if (status & rx_not_ls || skb) {
+	if (in_progress || skb) {
 		rx_q->state_saved = true;
 		rx_q->state.skb = skb;
 		rx_q->state.error = error;
@@ -8339,6 +8352,9 @@ static void stmmac_reset_rx_queue(struct stmmac_priv *priv, u32 queue)
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

