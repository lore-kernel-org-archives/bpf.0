Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6452B3E5A2A
	for <bpf@vger.kernel.org>; Sun, 18 Oct 2026 17:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792343244; cv=none; b=saOuqiDVMtHB3WWMMGY+WDXBdn+j6YpLnUPl/6kTLKX8YoupRPjtfBzr0lyvXX4zAcSDYyQ414fOAswaJXEwhQANxFwQckRdLOJv4sQlUv6xy/LduBcov4ryMxcc4H6DFDsfpPhBlhbuDHKtxdi17/8fs5gEDQ/8SvDSz1ty2jU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792343244; c=relaxed/simple;
	bh=oBFOCkij2c8e4c3gm8CMbz/B/JG/gHD8XcmKmFhABzE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mzg43KjRKhdMzYHI+gm+bGVNq0RhAn4bfx4Pti9TU6dbbS4LhaNHV+9+EKFYAfXJ5FEPBvyGHepVMmDQInsYXX7cVBCXhUuPR2FMIOUAwh2eyp9F083/DhUfVSIASUdA9sBoeau16XnZcn7nEJwMHwGIc3O+RSvo2gn3ZK580e4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jydJDW5b; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=A5NYrJTf; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jydJDW5b";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="A5NYrJTf"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69IF7kuN3702541
	for <bpf@vger.kernel.org>; Sun, 18 Oct 2026 17:07:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	fzCxI4jlYWw6JP8PMFSSVZEyEtQxd97FuaOsRZrDWwY=; b=jydJDW5bcVLWC23I
	sy/G/Jx3AwFST64md+v6aPFSnyIH96Q+NdobUrwQNYceqbZypknU/P7fJoRBOzgU
	D1usDxST2SLbuMwgbPe/D+ZGM9Med1Mwu2/6sl/ydypqudFxyiTy9fxQxQeoiS4u
	jxoPsFnyXA+/MCP9Qm0KbiJGIRIxyWq9rBGjOzsOkDSvb9rSOBV9Q/drz+v2Xl68
	QNTqi0fZfO1H/j442oAdGD9wi+LHSbMwV4nqPuXNSHtPgPPRSEOHPIE7X++yZXrD
	j5C7a2LJo1wzhH84FgY+RopMyKXSjJPf3ZP4Ii7Y52Maz7ozk91DyVdr6r8MqAY2
	/T806A==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hc1se3es6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Sun, 18 Oct 2026 17:07:22 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93f32050e72so348276585a.1
        for <bpf@vger.kernel.org>; Sun, 18 Oct 2026 10:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792343241; x=1792948041; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fzCxI4jlYWw6JP8PMFSSVZEyEtQxd97FuaOsRZrDWwY=;
        b=A5NYrJTfJHWfFuxV0ax2pqdwKfqV/K5Oi7lCK1VoTFbcbNAHgh0i2cPoYexf8zBle+
         dlvUVW6B8UceFXtiTCsUO7DXA6xPWLlLHmT+fZVTeQHaY1Jdr3JwlCQUm18kPa8xB4dK
         snPBcQee3mJLyf2ccRYX8ic/gw6q2ZfRWwYJDBYNaLBNyRRVLkUA3MNQ7TbxDXUFux/C
         BATA/bUUa+ZedcG2O9wkrTlPyVKXSKcQgN7SZ27t+u5ti+33IghOwTjri6/PWWvWd82q
         76Z2tAdypDwPErD+pnbe+xE1CHeD9orjAaeGaSl/rtW+MUyNmKou1uWV+X0P/QXfanXv
         qEog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792343241; x=1792948041;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fzCxI4jlYWw6JP8PMFSSVZEyEtQxd97FuaOsRZrDWwY=;
        b=0nIUiM7+QgzdDAPat+5tuXrjQxMPWTbWLNFBJCQ8BE/zJBmfseStUUlx9CdAycWz5A
         KEBHNjhZLiyTwZuJlv33R9TTbRVhLdY1D+1CPhuzJsq7jWPuHdxDx+lYGocxJIBnfKVZ
         btWoSiqef1HcH5GMcEuWoR3DlvVAH87U7ddrdvflfj01Oe9A8cKrsTOy3gPKIi8gAg6K
         wKSycrriC+ZBq6S1mMg7NPULLqcOQDOCiSxiL6cCp4h9BIYj85bAq8vZ5AjQjDqUtCXd
         dldvd4pjBsRF2JO9rYh22Pka2Hz8gm8EktS0wFJqDGHTzaF0s+b9yGO96IOHjs9U8qep
         vQzg==
X-Forwarded-Encrypted: i=1; AKwUvBxuzvzWs6fOWQXyJR9UzY9h8zwrQKZHAm4h68YCmmYBhsVqF25rdHwAooGd9w6dLWOsQcE=@vger.kernel.org
X-Gm-Message-State: AFq9FYL2uXqLsncEfqhAKmgr3f1KGbql071j9HMTINdiulytnu4wEwbP
	okHUXF+3TciIDCRdqr11WTETOnE9iDfwTxh9m4+uVTUudB9Ov6ljpRWl/TVi8c8MmTBp21jZ2vB
	xqX3HeUXB5MLLSr55hqyENybTv4Kcr4sBjnL3/NkoypHDvgBG0bf1dhs=
X-Gm-Gg: AYBFou3cezd4a2F6yPHuWsCq0i44cRtvI45a2Q2v3nM7OnjowEfBK4KdtCZ1AfFKuDZ
	qk42TiLDyhOBRYNmbzLtyUrFmkZyOQkRU/6MZL1zZ+fUoKimth6Sz0z9fQRKihq459uw2d7f8Pk
	1sffsoRRCYRgKoHe8LpCWoWP83Q9iunJY/Q8S63/W5KVAMJgmlnye6MUEAJPbHZvbibvkMhbMRD
	yiCQb/JmR4Z2f/twxoAfikOzK8zCxAGWDI5zWDeM1KcYFZEKNw0KMrR8ehkm6q+SlIdyHWrIip/
	FPmTE4bHIL5AwJJMOku+WslGJ7qfbKysmhdP2BrA/V2nkBPB4KA7e71RSls96B5Y/h3m6J5e9F3
	8ER4sOQNTlqml2Q==
X-Received: by 2002:a05:620a:438f:b0:93e:4c1e:cbbd with SMTP id af79cd13be357-93f29d5e5e6mr969042185a.53.1792343241475;
        Sun, 18 Oct 2026 10:07:21 -0700 (PDT)
X-Received: by 2002:a05:620a:438f:b0:93e:4c1e:cbbd with SMTP id af79cd13be357-93f29d5e5e6mr969035985a.53.1792343240865;
        Sun, 18 Oct 2026 10:07:20 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48dfd510d60sm17188394f8f.58.2026.10.18.10.07.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 10:07:20 -0700 (PDT)
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Date: Sun, 18 Oct 2026 19:07:02 +0200
Subject: [PATCH net-next v8 4/5] net: stmmac: fix VLAN tag stripping on
 non-linear RX frames
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261018-stmmac-rx-mb-v8-4-5f58c0b25849@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: n6iIkBA1gfA_5TYWm85DYKCSfaPJnK-l
X-Authority-Analysis: v=2.4 cv=A4z5rKWG c=1 sm=1 tr=0 ts=6ad4fcca cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=6Uo0uaPXZjLRJ0J4tPYA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-GUID: n6iIkBA1gfA_5TYWm85DYKCSfaPJnK-l
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE4MDA2OCBTYWx0ZWRfX/c+cW+SGz77G
 q6giqmo+WAcrPYNHZD2k1p4PVJsEj1RdqVt2cyluJZd8QeNYmUqcQXwY7miltdWypdZPdfOO1PM
 2iWk618/cAuev/W14k7ZICRRSwhBsQM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE4MDA2OCBTYWx0ZWRfX4DKZI7YCD17k
 fb1Scja0h3e/qkpx5lbR7c9WEneAILbRh0oZGbSNBGYHHI8kvS/wfgCg6fWN/nhTBRmIXIZbiWH
 So67dCNNIVcHQOxwkWy3F5aIOVGRxqHFwj43tFZiUV+3VWoQmdZI1qkRPwyRiQT/h9gGYer7fGm
 JsI5FXlk0xcz7HKZnfVFYYxOdSqjnp2qyOr7MubxrNvgQ2e9b5bOmxj8X6d8VlJDDXhD75+s547
 MXCBrXDc8GSNswtJ5WmDUhS0YaekK6D47sAv8mu4zcVFAw2RFKE+HoGLLA4WGvuwMGuSpmK47Al
 clez6r6qEZ3pm+VcywhRpPOrdho+V5m4vNneDlV5FqfFL8RVigE6SKwIq0+X9Jv2ewCQ70/R7mT
 vibywUCP56diZzRweKazMRGDh3xTWRVDctip/ikTvsFfAp5KwTMnjT4EcnXfQt5erPwyWYnAZZx
 /OGzICMkbBQU0lRzFxg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-18_03,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 impostorscore=0 lowpriorityscore=0 adultscore=0 priorityscore=1501
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610180068

stmmac_rx_vlan() reads the VLAN header straight from skb->data and
removes it with skb_pull(), assuming the header is always in the linear
part of the skb. That is not true once non-linear skbs can reach it: a
program loaded with BPF_F_XDP_HAS_FRAGS can pass up a fragmented frame
whose linear head has been shortened to as little as ETH_HLEN by
bpf_xdp_adjust_head(), and the unguarded skb_pull() then drives skb->len
below skb->data_len, tripping BUG() in __skb_pull().

Pull the VLAN header into the linear part with pskb_may_pull() before
touching it and re-derive the header pointer afterwards, as
pskb_may_pull() may reallocate the skb head. Also move the XDP metadata
written with bpf_xdp_adjust_meta() together with the MAC header when the
tag is popped, so data_meta still points at the metadata after
eth_type_trans() anchors mac_header, instead of at the first bytes of
the destination MAC. Return an error so the callers can drop the frame
when the header cannot be pulled.

Fixes: bba2556efad6 ("net: stmmac: Enable RX via AF_XDP zero-copy")
Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 45 +++++++++++++++--------
 1 file changed, 29 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index e929cc0f2312..04dc6dcaa435 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -5095,22 +5095,30 @@ static netdev_features_t stmmac_features_check(struct sk_buff *skb,
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
+	if (!pskb_may_pull(skb, VLAN_ETH_HLEN))
+		return -EINVAL;
+
+	veth = skb_vlan_eth_hdr(skb);
+	if ((veth->h_vlan_proto == htons(ETH_P_8021Q) &&
 	     dev->features & NETIF_F_HW_VLAN_CTAG_RX) ||
-	    (vlan_proto == htons(ETH_P_8021AD) &&
+	    (veth->h_vlan_proto == htons(ETH_P_8021AD) &&
 	     dev->features & NETIF_F_HW_VLAN_STAG_RX)) {
+		__be16 vlan_proto = veth->h_vlan_proto;
+		u16 vlanid = ntohs(veth->h_vlan_TCI);
+		u8 meta_len = skb_metadata_len(skb);
+
 		/* pop the vlan tag */
-		vlanid = ntohs(veth->h_vlan_TCI);
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
@@ -5530,12 +5538,15 @@ static void stmmac_dispatch_skb_zc(struct stmmac_priv *priv, u32 queue,
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
@@ -6041,12 +6052,14 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
 
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

