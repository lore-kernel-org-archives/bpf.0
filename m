Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793108949;
	b=MoSOtsgUPKMSVtWoTB2dFWK5+sZZsOGelHraNAGgMyIS5+Wle6PtTzAeVYcEgwFmKuy9
	 KDk4t8vzacI/AKrEzRF5wZwdLlu3Lz2lpptN9B9EKKOuv/woLJVrLRs6NNhjTXOnoJnr1
	 iVxH1MarkoY0lDPH7xOxB8OntcpVCVmz7pVrpkg5i0PDpD6H4g7bMOgq7ccKsFfhmDkwa
	 RfN8LHZKPaTLMkuUUHPKyd+1QjOBWC8yTX18HBHNPzloj2IhbL8g+hJZSOc9+hrsuy3zg
	 G7krSwCwP1uiyctAuXP8gPpIIdAg33+NWrMHJf++76GwHbuTqhIfKWzAOt2RUbCr6Pg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793108949;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=LZ4WRLlBWNlzgKoZ6xjmyCXgKrbMPKnWr5tgehi8fhg=;
	b=IN+yTZF9a3FbcZOV5RALS3QH4Qed5dwPfuMCW6PRzA6OLIi8CTFdKEcpFTVp9VlBH3QD
	 vn54KCtdvbWT0fPu1u4NlPW2UzpTZkBw4oiYsoBcQBs36Klh06TNY6d1y1tN7Qr7LYnfS
	 3Jw1JQ1bUUAKG43OxDixygYUK8L/mhVtCdoemlRc5MroyUwMn1d9FzGnhDKJbTKk0lpg5
	 VHL5hwvJNli9NSifslN9C+bcQO6MxOMjqn/NxL95i2cL0Ulgces38rvKGJ6DDcdhDqmn5
	 laDNgCa/eXhp2ZadDqGRGxkI0MltcSBxoiugrz+1ikY+q4XdqXkW+/+D/4ShRuV49jA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Y3vVEUsN;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=j3jhpb1R;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B946D606A32E
	for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 13:49:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B946D606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Y3vVEUsN;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=j3jhpb1R
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69RAdxT92458143
	for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 13:48:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	LZ4WRLlBWNlzgKoZ6xjmyCXgKrbMPKnWr5tgehi8fhg=; b=Y3vVEUsNC330BLEp
	JM0cQuSacvAwmVnVp/VCR0EEQihekahq5pngYSHdDr9MXc937gqUS5o3kIpBgRns
	lJKWiylUA4bfLfGXugfQOCL8hpYqtlk8PQKPwThLAmePpKf/r9Aj8YA1yTxoNu0Q
	/AfwSNaK9WVfYQzExYDc3hX7CmBPN9l1ls5Yy6D5WJdTDwtroQAOlc0Itoc09Td8
	A0Vzk1TlZ++3Mzm/FcVSczhxYRwEPlJaTFgbts7eJCRFyqpf/8MLclCeW39lYF44
	k81/Nc0rCyS7rr0TVaF+o74VsuS4Ku6Fcwn44zjuxZbH6NBuIl3gIaINGMXdfgps
	b/37hA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hjjbtajj9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 13:48:59 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-93f2005ce21so690571585a.3
        for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 06:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793108939; x=1793713739; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LZ4WRLlBWNlzgKoZ6xjmyCXgKrbMPKnWr5tgehi8fhg=;
        b=j3jhpb1RnQUWJfpGIsDAVpssfFGpayn2xGE1X308fPm16IW16YJOs0NTdmSPuRAemh
         WkokmQ3kA0BSSpOaU69c5n+JXxawkt1kFybjf3Wy7zYm2xg/jlYZjoaPj4jJwBy6GBIa
         tV2GZ50hmfZFfR/5qb1WH1rEs4ajZLaiqV4JzzzXfSX+gZsmsk9zvRvVUJvsVpEb+aEK
         i7KEiwrqfDY0ecYBMU2eqvQb2ML6Sr+odRlWI9q+v7AWPMf7eB5uhXzHuWK88QunbTUB
         G4K3kpLL6ieC9VhMMB79e1YvP1l5jOvcPeTVj4nuTCNXLlnFUonMzNlpxf1+DJJy8Yu0
         6tQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793108939; x=1793713739;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LZ4WRLlBWNlzgKoZ6xjmyCXgKrbMPKnWr5tgehi8fhg=;
        b=m+gsyzhbD7jZ3CNj2Y2w5HgCEZ6p8XjQyzomScdKv2ZGRxr1Dy1WryTjzRg5QZz1a9
         0RIXp8XZzL6wHKeGH7O09PVQ9JZA55A0ZwaWD0v++/FOD/nqlgwD4iZNhkuyc8RsoiqZ
         hUANW8Tr87hD++DG78FaR2AuEESwpdOQ25nLiUXLQ9auxByCXi6P0/IRjRjlOMOfTtJ4
         /xyDeoEvSqEyQzOnOVefQKOXYpU6DSw+GUPJqKjVrBQCXH9zbq0VRZWTYfdq8YReGTZ1
         cdbOHob8XOFB1BOAZ+7l9iO4bYQxTx6+hrr+B4a0w1kh+Wm9oy2XofSHD7/4Cge6oXIo
         vWcg==
X-Forwarded-Encrypted: i=1; AKwUvBxNeBpjkE48hUVbrRAC29BYClFcz8Js5RSYt1c5pyq3D7+FKNd0HQLhMuS/xk4KGmPdAPQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYLEJGgPTDqPkq2gEXd+U4mAIits6SrUjg+fYICbx0KENypTXZBE
	JEpB00Yz7jjUqCiZXW//x/t6gEmU3s82352y6xoiu1SfoEixTs0n6BtlEJBkAO9b7jvbJsOkWMm
	Q2ko28wSY2eUj3utMPg1d3VCONNvds5NxcohwFyGa0XKfekMsuAuT/DM=
X-Gm-Gg: AYBFou0XvQeZITC+m9oWjbWsyAzpzKtjsmvdAPu9ywpUNn/uNuZUCfKzc3p2dh07IBf
	rsw2T7mlqOfIPQ1fewFMshIJs08Lj2x6kr77ttIcLxkOFjEivPaQo3xZeCmR3/l8AA2RlZSxYoR
	rNB0Voro/ujnZ6Mh5Mvi4OMVULdUgYEM7fkiXsqUDKFi3KD7hgT+KlAYsrqfAG/f3ZdWQGENyuE
	ZEWn7XNfKIuMk5TffdTqnIRXtMq85u6vFz4bdsCDCHgKxp6VKsdkAn6wf8BK7DKf4UqEjxteW/T
	SN13fUgmCI2LROnKBDqhNKVe1llmSLENytCeWg5zbP/OpmKHR/elmExq4IP5Diui86aLfkYwzI1
	0p678xeboIx8=
X-Received: by 2002:a05:620a:4725:b0:93e:94f2:ada5 with SMTP id af79cd13be357-940ef914f06mr1534343285a.25.1793108938577;
        Tue, 27 Oct 2026 06:48:58 -0700 (PDT)
X-Received: by 2002:a05:620a:4725:b0:93e:94f2:ada5 with SMTP id af79cd13be357-940ef914f06mr1534336485a.25.1793108937851;
        Tue, 27 Oct 2026 06:48:57 -0700 (PDT)
Received: from localhost ([93.144.6.81])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c46bd77e1e9sm459291666b.67.2026.10.27.06.48.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 06:48:57 -0700 (PDT)
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Date: Tue, 27 Oct 2026 14:48:36 +0100
Subject: [PATCH net v2 1/6] net: stmmac: take ownership of saved RX state
 at poll entry
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
Message-Id: <20261027-stmmac-xdp-fixes-v2-1-10eae8a093a8@oss.qualcomm.com>
References: <20261027-stmmac-xdp-fixes-v2-0-10eae8a093a8@oss.qualcomm.com>
In-Reply-To: <20261027-stmmac-xdp-fixes-v2-0-10eae8a093a8@oss.qualcomm.com>
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
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Cc: netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        bpf@vger.kernel.org, James Hilliard <james.hilliard1@gmail.com>,
        Nicolai Buchwitz <nb@tipi-net.de>
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDA1NCBTYWx0ZWRfX+IQDM13ccFZG
 V9IM8Q/UhxHuOve0YO8Zq8mrI+jNjUUczYqMDWMIqXtU/zJxDhLPG0i6nAqZuUnffkhwRYLmUvx
 OvAnb9QwgQEVA53vE7o33ne0UUTiW38=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA1NCBTYWx0ZWRfX12CDjTNtoD0k
 x/k9KHjDupEYR7aCfjTe6y8zFmZzLVPhcFEOn89BTj4qEOAR1FHLrgoRty9W0O9RKPltN1/EfJm
 UO6Gq+GsDWZlV5nOBmp6G3HSvnYbTHaTFm/ecck4Vj+WWzWDTl4GcwHtp6kqT0nmBmMzctAj1oU
 ZNiN0DPniPuNYUeA1mSg9cvkg4+vlwq8tcnOAsxbQdGBW3HKplrOWyTKwyuXEd1IPqQOvZESXb1
 ImrP0b8ORKRlf6g1BRXQ6ANG42IiLWNZN3c73r7z/+FjUkZBp6bDOFKNTP6ewiMCiyegW/tl85c
 Hr20HZtBRrbxiGERessXUlNB6ozKugtr6ExxbNWWzRsT90K9B0BKppZwV4ZRB7BuYm9m6ZUkkRb
 +ZnzMg/TkWqrmm9OgAWAIofA82woAF7AqoIvkUcGd/p7WAv8pV5k+J+RCnDARwbxiHMZ6C4YKNX
 tr0ZvzUZhwIf8yl1PDA==
X-Proofpoint-ORIG-GUID: KFh1U2F1Yq1aqyLX7Lx25objsAWl8ZBg
X-Proofpoint-GUID: KFh1U2F1Yq1aqyLX7Lx25objsAWl8ZBg
X-Authority-Analysis: v=2.4 cv=XaIcX455 c=1 sm=1 tr=0 ts=6ae0abcb cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=7fYLNvKHbgS61GKHX+yayQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=-gjLCbu4MZEjzEcwt_QA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 spamscore=0 bulkscore=0 priorityscore=1501
 clxscore=1015 lowpriorityscore=0 suspectscore=0 impostorscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610270054

From: James Hilliard <james.hilliard1@gmail.com>

When a saved partial packet completes with a poll budget of one, the
old loop can leave state_saved and state.skb pointing at an skb that
has already been delivered or freed. The next poll then reuses that
pointer, causing a use-after-free or double free.

Take the saved state at poll entry and clear the stored ownership
immediately. Save it again only if the packet remains incomplete,
including when the next descriptor is still DMA-owned.

Track the frame-in-progress flag independently of the status read from
the next descriptor. The old code keyed the save on the status of the
last descriptor looked at, so a loop stopped at a DMA-owned descriptor
(rx status not yet valid) could drop the saved error/length bookkeeping
in stmmac_rx_zc().

Drop the saved state both when the queue parameters are reset and when
the ring is destroyed. stmmac_reset_rx_queue() is reached from
__stmmac_open(), stmmac_xdp_open(), stmmac_resume() and
stmmac_enable_rx_queue(); without draining it there, a partial frame
saved before suspend (or before a queue is disabled and re-enabled)
survives while cur_rx and dirty_rx are rewound to zero. On the resume
path the ring is only re-armed in place: stmmac_clear_descriptors()
sets the ownership bits and stmmac_init_dma_engine() restores the tail
pointer, but the RX buffer addresses are not reprogrammed. The first
poll would then resume the stale skb against a ring position that no
longer matches the descriptors it was built from.
__free_dma_rx_desc_resources() releases it on teardown.

Apply the same state handling to stmmac_rx_zc(), which also leaves
state_saved set when a saved frame finishes at the budget boundary.
That path saves only error and length bookkeeping, not an skb pointer.

Fixes: ec222003bd94 ("net: stmmac: Prepare to add Split Header support")
Fixes: bba2556efad6 ("net: stmmac: Enable RX via AF_XDP zero-copy")
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>
Co-developed-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 72 +++++++++++++----------
 1 file changed, 42 insertions(+), 30 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 9ded31150fbe..fa7108919e90 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -2182,6 +2182,9 @@ static void __free_dma_rx_desc_resources(struct stmmac_priv *priv,
 	else
 		dma_free_rx_skbufs(priv, dma_conf, queue);
 
+	dev_kfree_skb_any(rx_q->state.skb);
+	rx_q->state.skb = NULL;
+	rx_q->state_saved = false;
 	rx_q->buf_alloc_num = 0;
 	rx_q->xsk_pool = NULL;
 
@@ -5629,12 +5632,12 @@ static int stmmac_rx_zc(struct stmmac_priv *priv, int limit, u32 queue)
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
@@ -5645,23 +5648,25 @@ static int stmmac_rx_zc(struct stmmac_priv *priv, int limit, u32 queue)
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
@@ -5700,6 +5705,8 @@ static int stmmac_rx_zc(struct stmmac_priv *priv, int limit, u32 queue)
 		if (!buf->xdp)
 			break;
 
+		in_progress = status & rx_not_ls;
+
 		if (priv->extend_desc) {
 			/* Read the extended status after the own bit */
 			dma_rmb();
@@ -5776,7 +5783,7 @@ static int stmmac_rx_zc(struct stmmac_priv *priv, int limit, u32 queue)
 		count++;
 	}
 
-	if (status & rx_not_ls) {
+	if (in_progress) {
 		rx_q->state_saved = true;
 		rx_q->state.error = error;
 		rx_q->state.len = len;
@@ -5818,9 +5825,10 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
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
@@ -5840,25 +5848,28 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
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
@@ -5887,6 +5898,8 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
 
 		prefetch(np);
 
+		in_progress = status & rx_not_ls;
+
 		if (priv->extend_desc) {
 			/* Read the extended status after the own bit */
 			dma_rmb();
@@ -5904,11 +5917,10 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
 
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
@@ -5982,9 +5994,7 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
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
@@ -6041,10 +6051,8 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
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
@@ -6069,14 +6077,15 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
 
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
@@ -8421,6 +8430,9 @@ static void stmmac_reset_rx_queue(struct stmmac_priv *priv, u32 queue)
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

