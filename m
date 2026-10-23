Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792743044;
	b=ynt4Ug13Pn1xhtuxnRVM7VweKxMSYkCsMz2EBHuWZlMxKEu/eUhkm25ezXd3kGPl+LjL
	 Am2KifzTFqfoLyF0jfK8kievpeBhGDFTgWasQLrj5QRIhBqk8wuQzKHgJ88b9jq32jaUU
	 nvxHmX2WU8vM4+UwjIeprLzWBG/2Bim50j5wDfJkSTykm8RZh8r+U5uwVNJNITFDMnLEe
	 rk8JWL9empl7/M6TXvw8tlnLjczYam2XqspnN3aa0w9VdqwGIi/6UHPcCBO6zWRttxiFh
	 ry1LYkkeQrpcbFwLrM6V5kvTBafDjhgCUXHny5JJ7e7HnjkYVnQ3tFhhHQf53p/SCGw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792743044;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=9KJNqo+cb4atWzlkr/WtQbdQlvV6rs4JVgcVN9uUPgw=;
	b=ZnpfOUI3rh9phRjmlvzMxFZZSHvobf2ZVjVNasE0zStjtWMJsM9muOkqDsLHxegvYLeq
	 JmkzgmSNlZgWMhbhNM9/aiNlNqc96dY4XBi28ek5Gnjsn7wz5GnmvXPj6hsfkaZO8N7T7
	 Yhc1utRT6uEO6xQ25ycfD/ib4XYjciPevspvHAZEFBE3QD1LipwdD6bBuQK5eIshGz+xG
	 XU0rK8t6YFS05Mh9Qkyylz29lW6ibEuGzdAgIXmlPyy9BwH5TdcBQnNLp/1AdS5wVUYiE
	 fHewGziU0jYUK6LXDfRIzmX2WI5SOYNJotoQcrzBf6FYTLUbO49iee2HyFxKeCHU/sA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=CzW6AGf3;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b="VzM/vIrG";
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 846A3606A338
	for <bpf@vger.kernel.org>; Fri, 23 Oct 2026 08:10:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 846A3606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=CzW6AGf3;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=VzM/vIrG
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69N7FFuk1767407
	for <bpf@vger.kernel.org>; Fri, 23 Oct 2026 08:10:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	9KJNqo+cb4atWzlkr/WtQbdQlvV6rs4JVgcVN9uUPgw=; b=CzW6AGf3CPsjQ3+X
	tK2w9rMlmIjzHFoQV2ls9lGngjkxh9ePJstID6lovQnlgqlu6x5SMP7QKX/qj5f+
	AkDr1X24++AoEVscHBeVeTsQr3V9kH1yhbZQ4rxYJ85PXbvjxmFV9EBpoapWTptI
	hYVFKM3Lsj0shwgVN23FF0btPdVHB6cNLLJghAo4iwbEwqNQdXiyyOwLnAlUbi9E
	s4Kzx+2dClDnP03PHoQeSPtVBZ6jbEEgkolxnm6jayBtnVZKDJQVAhb9geJGuuKX
	Mv7ZIug+QDaoJqB0RxigT7HEtSw4NhO3QcxnqtJGTdBnhdZqnMHikFXOOuQnJpDY
	PgMmVQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfpahu3e1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Fri, 23 Oct 2026 08:10:42 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-92e82060977so124069985a.1
        for <bpf@vger.kernel.org>; Fri, 23 Oct 2026 01:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792743042; x=1793347842; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9KJNqo+cb4atWzlkr/WtQbdQlvV6rs4JVgcVN9uUPgw=;
        b=VzM/vIrGyOjAT7aivcYQ8h83tKdkML6zonI0w8Q8bF8ITupk3xpjXM0pozNUvG//Ph
         RxiDmv/yRlezSGVDTqGTJVGIc7V4GO3RNaYJ+JSW1OV/OfONL6GPKUY2ikZ2JqFEJ2qT
         CaC5AeJpDM2/t3LSFcW76raIUPhdTovc9Apr9ZpNGbcUIPuU/QfDKswSrLxUi0IPR9sH
         9NimrGRRIB2Bu7ZOm/e9jfGl0Xd6jCCEI5pOWBPJ6trvIM1jJRDRUuQM4g0OswfrserL
         v1Nuq5g2owHq4PBsmrMthtF5+GNT//XomJ+6NOfGbTo/D8dqwkBBS+fNSNbHHMcZTvva
         9juw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792743042; x=1793347842;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9KJNqo+cb4atWzlkr/WtQbdQlvV6rs4JVgcVN9uUPgw=;
        b=JM1yoXUQMFunIZ1fLCgkKQTpT5jmVYEfycudtGGKwLzURq9qW+OXy6t6WbB5JT4Fmo
         KmQAYDN1I40V9lIgS5jW/tzkiSKeGNSdBT5qUe3KN8cFdSXB8SaLADIKlaY8PCdHb4a7
         3FcrL8KnnFj3Nv6Fs+tPIy2YpMYxxr/Kxq1fnnEf/L9s0qeDiC7ibbUo+EQ+3wCR4AIH
         392NGY8cXmeABH+trpYe6wJgWkN/X2RjwKKokmfOE7EgmH/3cBuUhfTWLhn7L9OJu2Ov
         MaH2qkqZkEF2t3V2oNRX6X40fvhu3i0qA1UoQgxTt+CmIU3SSiL/dztHQiY7fMlQvway
         uQeA==
X-Forwarded-Encrypted: i=1; AKwUvBzKX+T/07geTQKP+Lm12UZyZKHsiupHZ0PJUQweyVhOEAKl+bAFg8Vy55kNlaOywcwpEr4=@vger.kernel.org
X-Gm-Message-State: AFq9FYKFOvRKe0qF2KgUecj7EBq6nl2M7YQjsM1CgVejZmtl2XpDNZfb
	LABfsUhgpel719UQSC9acg2GBUY2tlQ1XaiezVFoUBIi3Uk1zL5pyZXFG/Utjt3VXAMb9LQcG6l
	dqdbHPVPc96vkD4E58b7oY5bFxIhnU/+ctozXxJRNSss98ujOvUH8WO4=
X-Gm-Gg: AYBFou099XssByaZuDM/sEIF0TgTXFi6wvPObyJ3xuDyFXaOz4KCS9qQyRQ9VrFFJIV
	1Vxj9japrBzcHJ41v1y47miRTb1tvlCT3EOtgQM6WlDOqApuuEakuGLjmyO9GQxvWXaywe51RV/
	f3ObTY7dryPNWP+QRXd6Vq6SpzSYzmFZV/ZlZeYaEb5/NoFn6dww+sHAKDBz1zp/vHBMWqje78q
	Tgxp53POaN1RC4SNUhqiP/BZmkr+3Bv/w59Hyr7bwEV6D5qhJze1/SAHYlr/M4b/d8NIOdttv18
	+az+mkBO7jsiypCXY8kXPfgd8NoXyGaBw6KcheZfpK/g/6SGfGzllTJntFrCBUyhVUqKZtY+A/4
	ERdzY1kiWxLY=
X-Received: by 2002:a05:620a:2620:b0:93e:c12d:4ecc with SMTP id af79cd13be357-93f627ef31fmr720541685a.44.1792743041528;
        Fri, 23 Oct 2026 01:10:41 -0700 (PDT)
X-Received: by 2002:a05:620a:2620:b0:93e:c12d:4ecc with SMTP id af79cd13be357-93f627ef31fmr720539085a.44.1792743040971;
        Fri, 23 Oct 2026 01:10:40 -0700 (PDT)
Received: from localhost ([93.144.6.81])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a21046b92esm52603085e9.10.2026.10.23.01.10.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 01:10:40 -0700 (PDT)
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Date: Fri, 23 Oct 2026 10:09:57 +0200
Subject: [PATCH net 5/6] net: stmmac: fix VLAN tag stripping on short and
 non-linear RX frames
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
Message-Id: <20261023-stmmac-xdp-fixes-v1-5-efb37e19f5bd@oss.qualcomm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDAzMiBTYWx0ZWRfX6rvqI+bpeHJR
 ay2e/rUQDtfm5FyJqEouJyWLajk5c1QOp78wBWuK6QkpBC0oR1P3D4GKaFFoKnCwn9cHy2HUo8p
 b3ze5ubjjBpkthQGsNTSsJHGcsB4eTk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDAzMiBTYWx0ZWRfX2LA+QV7Dtlsq
 Iv3vcPwHomJ3wQNTOUxbn3EJVEW6co1Pj3c+4LDi/eqMz2rhGmeVd5NAXC6eHjDEr6UP9vuxuG5
 WGiiX7g0UlPMJQtWQOy+5Trvbxd805IwXfBIgncQtmYCsFURGSdB/Y747ohpnGHLNy1L3YX1BzC
 EbipvJG6NfzJP/znq2TqpNdDhXx1FvHregF8rXxWa8K7r8SwitMNLaOwz6VibfpbHUEAVQ610dn
 td+WsI3dt1oUQJsFIJKq2D4ssrZHH14fQkv3oUKW9QzA4/kSDgETKBwDEvs6IB5NcYra2dFNWUG
 FgQUN0HFXGXFXoPp7bsJGE59gQ123Dr9jcqAq0WnZZrWkLU9gfSU4sXjWMmhpRXa7gMl9rhKXt3
 Wib3y83ciwFj1/ghnfR63bns0SKSboAj5jBhlRMSll3sMpasy6+1HjiPFOXWm9rjcI7/ukmSnNb
 GoljlpuPIZALxkd4sxw==
X-Proofpoint-GUID: brXmpuuMFiVCY20a82uZ8s9hXaiqSFEl
X-Authority-Analysis: v=2.4 cv=YIMKWhGx c=1 sm=1 tr=0 ts=6adb1682 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=7fYLNvKHbgS61GKHX+yayQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=hePLJVBFsHslUFHqtFkA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-ORIG-GUID: brXmpuuMFiVCY20a82uZ8s9hXaiqSFEl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0
 impostorscore=0 bulkscore=0 suspectscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610230032

stmmac_rx_vlan() reads the VLAN header straight from skb->data and
removes it with skb_pull(), assuming the header is fully present in the
linear part of the skb. XDP can change the frame length and head layout
before the tag is stripped.

An XDP program can use bpf_xdp_adjust_tail() to shrink a frame to as
little as ETH_HLEN while bytes 12-13 still contain a VLAN ethertype. The
driver then reads h_vlan_TCI past skb->len and pops the tag, leaving less
than ETH_HLEN in the skb. eth_type_trans() cannot pull the MAC header, so
a malformed skb is passed up. The TCI is also read from the wrong place
when the tag is not fully in the linear head, e.g. when it spans into a
frag.

Read h_vlan_proto after pulling ETH_HLEN into the linear part, and check
it together with the device features. Only if the tag is actually going
to be popped, pull VLAN_ETH_HLEN and re-derive the header pointer
afterwards, as pskb_may_pull() may reallocate the skb head. Return an
error so the callers can drop a frame that claims a VLAN tag but cannot
provide the full header; untagged frames, including short ones, are left
untouched.

Also move the XDP metadata written with bpf_xdp_adjust_meta() together
with the MAC header when the tag is popped, so data_meta still points at
the metadata after eth_type_trans() anchors mac_header, instead of at the
first bytes of the destination MAC.

Fixes: 5fabb01207a2 ("net: stmmac: Add initial XDP support")
Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>
Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 48 ++++++++++++++++-------
 1 file changed, 33 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 8a2faf50d695..32b2c5834c34 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -5102,22 +5102,35 @@ static netdev_features_t stmmac_features_check(struct sk_buff *skb,
 	return vlan_features_check(skb, features);
 }
 
-static void stmmac_rx_vlan(struct net_device *dev, struct sk_buff *skb)
+static int stmmac_rx_vlan(struct net_device *dev, struct sk_buff *skb)
 {
-	struct vlan_ethhdr *veth = skb_vlan_eth_hdr(skb);
-	__be16 vlan_proto = veth->h_vlan_proto;
-	u16 vlanid;
+	struct vlan_ethhdr *veth;
 
-	if ((vlan_proto == htons(ETH_P_8021Q) &&
+	if (!pskb_may_pull(skb, ETH_HLEN))
+		return -EINVAL;
+
+	veth = skb_vlan_eth_hdr(skb);
+	if ((veth->h_vlan_proto == htons(ETH_P_8021Q) &&
 	     dev->features & NETIF_F_HW_VLAN_CTAG_RX) ||
-	    (vlan_proto == htons(ETH_P_8021AD) &&
+	    (veth->h_vlan_proto == htons(ETH_P_8021AD) &&
 	     dev->features & NETIF_F_HW_VLAN_STAG_RX)) {
+		__be16 vlan_proto = veth->h_vlan_proto;
+		u8 meta_len = skb_metadata_len(skb);
+		u16 vlanid;
+
 		/* pop the vlan tag */
+		if (!pskb_may_pull(skb, VLAN_ETH_HLEN))
+			return -EINVAL;
+
+		veth = skb_vlan_eth_hdr(skb);
 		vlanid = ntohs(veth->h_vlan_TCI);
-		memmove(skb->data + VLAN_HLEN, veth, ETH_ALEN * 2);
+		memmove(skb->data - meta_len + VLAN_HLEN,
+			skb->data - meta_len, meta_len + ETH_ALEN * 2);
 		skb_pull(skb, VLAN_HLEN);
 		__vlan_hwaccel_put_tag(skb, vlan_proto, vlanid);
 	}
+
+	return 0;
 }
 
 static bool stmmac_rx_need_ic(struct stmmac_priv *priv,
@@ -5546,12 +5559,15 @@ static void stmmac_dispatch_skb_zc(struct stmmac_priv *priv, u32 queue,
 	}
 
 	stmmac_get_rx_hwtstamp(priv, p, np, skb);
-	if (priv->hw->hw_vlan_en)
+	if (priv->hw->hw_vlan_en) {
 		/* MAC level stripping. */
 		stmmac_rx_hw_vlan(priv, priv->hw, p, skb);
-	else
-		/* Driver level stripping. */
-		stmmac_rx_vlan(priv->dev, skb);
+	} else if (stmmac_rx_vlan(priv->dev, skb)) {
+		dev_kfree_skb_any(skb);
+		priv->xstats.rx_dropped++;
+		return;
+	}
+
 	skb->protocol = eth_type_trans(skb, priv->dev);
 
 	if (unlikely(!coe) || !stmmac_has_ip_ethertype(skb))
@@ -6057,12 +6073,14 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
 
 		stmmac_get_rx_hwtstamp(priv, p, np, skb);
 
-		if (priv->hw->hw_vlan_en)
+		if (priv->hw->hw_vlan_en) {
 			/* MAC level stripping. */
 			stmmac_rx_hw_vlan(priv, priv->hw, p, skb);
-		else
-			/* Driver level stripping. */
-			stmmac_rx_vlan(priv->dev, skb);
+		} else if (stmmac_rx_vlan(priv->dev, skb)) {
+			dev_kfree_skb_any(skb);
+			rx_dropped++;
+			goto next;
+		}
 
 		skb->protocol = eth_type_trans(skb, priv->dev);
 

-- 
2.56.0

