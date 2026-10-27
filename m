Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793108948;
	b=Wbd3AQqIshGzY8aCUuRKX4NSlRxY06xyS5QzrSEeR5JE2zD7rt+tivrin5SyrpwTO9Qf
	 aCUHZInQpnOkPVDHPSITJu359F0W9icqFrCOx90nFBATnCqjkTzXpoWDYDrOdedziHWFF
	 PDfNLFULBdFkKtcav6gZlQ4rBTcbI5G3/THimeN+LpN+wvZajtNlWneztb+IuuPjuE6HK
	 q4ScMd7Q2304dHrFTJ6a1siIArdL/7xhffOrStYeDt5GkW6R5TtyqaHYVjbYwqNo11iy1
	 obDM3gfJ1fMvWmMUkjxc20D9H27NPuIdJufMjtSmVjDqk96i4SrQrahhxnjW5N8gmTQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793108948;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=iPxat4g+OTXFQwTTu2kUXCx8GCZc+zr3xjEApU2VMJE=;
	b=M8RPtVcVh7uJVVBgEsK0aieLg8RI50oq+2qIEWcsBW/aUAFsvp9XMC5LV//RhMXNQ0cT
	 Z6KHhKRWAyYF+1La8BxZA+VF8N30BuZxFJFNcBIXaZq9PO1BpHeEHEYL0qdZ9cdRVRP/H
	 lkYcW3zf/lZhZtfMZPHbeEMmEz5AIHlL/7LrgcdSu0Aes6uBxXXjoIEAqq/p32cpCPC+S
	 2JAsV3Nzgq3hkCuO+bjvAdG1zPHLQmXBBksDHjVQwcnrdJCiecLctZujD9G0bgZ3n6JQw
	 Q4e89j3s5q0T4D0qLMY3mQoNg8YDEU7X/zI+mIN1bQr7EqmI+Au7pmBbkXhoPhS8a+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=QPGRtibF;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=fVJeGC3O;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23888606A324
	for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 13:49:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 23888606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=QPGRtibF;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=fVJeGC3O
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69RDW41X1276714
	for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 13:49:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	iPxat4g+OTXFQwTTu2kUXCx8GCZc+zr3xjEApU2VMJE=; b=QPGRtibFU+eibQkc
	NbVSU5xj6r+ZcA+S0wlq5h7OurqFzCKjoRqTJjO3VtsTo6RijKZaaDWOFQVdvJoI
	n+uhadNChPvjboamfMSZrfcRYVYugsNo8mo2krs+wbRki82xRAxgjYRej4Gx3yPx
	IFKkNlYnd0C65G5uUBPPXnrrzcTmqtP0L8y6hxGJ2xJUNdZhvSAc0kXmuKzp4Soj
	PAHUX32Nv5323l+FmGaQfeRMgAdD0/3hQFqPMgK5vMf87NEVYaTplcrpSRnp8deJ
	9PGCTJ4KVF48BlNm7bCaMkHIddn2QUbkwky2p7V0zaS/EBO7pPTV+xLIGMbkoYDz
	7+MWfQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hjux98ayu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 13:49:05 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-93f20addba1so815849885a.1
        for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 06:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793108945; x=1793713745; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iPxat4g+OTXFQwTTu2kUXCx8GCZc+zr3xjEApU2VMJE=;
        b=fVJeGC3OD04otN3/8cm/KkvZQmWRPEYrCm+4QkccBD9UWkh3PBxPQJDjHDAD5Cqo96
         W1GYx9Nx+nXxw6Dq3AYqAEgub2JuhP+VYXuoKZqNEVBcM2R/1VODfjmnF5HLVJGXm5Uz
         XOOpPxfY9plafHYWbAJkvoU7U7Gpwbsc3CF5HGhfKGlx8Rh+MXnuP1aDpamsTlEXrtf5
         7Kq1GuEbwQy9peC4insNcLdQPn7OiSxHCxoKoiHkszSnsouITghM02dWzBWjs1lHeQvO
         A3f7tJdwUnQBPVYS+o5Qotp+/zuc1Jgt4eQFgYic9ZBYOdWo8jYaDD2tTkFhzahYp0U7
         2CgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793108945; x=1793713745;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iPxat4g+OTXFQwTTu2kUXCx8GCZc+zr3xjEApU2VMJE=;
        b=kvheoZ9o19YW0Gdu+b6bNgJIKXgauE0C5tDzbrk0okd038zZcl6GK07+SA8sF1h0lN
         6zqzfdRHfRPh6ZdycWfU6wi4u8pZpM0vk6hOLI/dTKFdyskixR/K6UsDvsXECk995H4w
         KHU8etHtBVlfNUPZv04aghSuon/yoqeYaxmHdnEqMGtKfwQP0FQNCYUbrSit44Ae8Zrh
         fqCKJMHo3LQupN/RAw3ij9+hCPYmUHzsm4MsqitmttSRlh2mVJiL4Ya1wYMHXzDXTDiY
         WsHFoXIuVXkEPIDvK7yyXPCU3Jb/ZB5MGXBsXoRrzgLbhwligFSpG0q9V/Yq2L6QoRjQ
         Jniw==
X-Forwarded-Encrypted: i=1; AKwUvBwF6RjV6JIQvZ7DvXickBuCcTqy9eQHvD5gFveCNeprFL7obLagf+WSi/ePq2DV7cNTZrc=@vger.kernel.org
X-Gm-Message-State: AFq9FYL6igy/pLATF9lCgbtMtRUYZ4nGRq5/pXLgWs5b7BYEyBlRDT7b
	uAV7rypPP3V6cBvUMPJzDvPA3xRZMV+Ahyy+GBARfCja/b1B1ADZMgRwJp/HrDMv73HfmD91df7
	sGUSBld5tb76xplgtfLeaSsOSLyqC4023yYGUB+AJT9u7CiQLMFJ9260=
X-Gm-Gg: AYBFou0yi83IhTmoFiguEjOerWc8+r3aYpuw6kILyGMuAhw2BjfckcU5nSHHXE0fAXh
	GSkuAomJHFu1qkV73/OrEatlsoMbgeftx/hIKRMQqo0J+j28y3u4arGspE/yH2/AMrAvG1qH5qj
	tlCwP6Rv210LLkJka/D5nSCAXF7dCWpS59IQ5A6CW1h7y3pIueuLbmXQaKGBIhaeJaQ8vnpCd/C
	boPMdzqD2/vP4LmTNyxs0ad9YoAUCxS9efxOTdyzCQJlOO4qH9siU4cR1J8HT7ULuijvqHIKW0a
	xrMSLaNy+jYxdinrppI61iI5I0YFIJaQnUYaumHqcmau/Q5mZxMMXx4fEOQw9IgHnOOaDWboG6h
	tFKIng/9YOkI=
X-Received: by 2002:a05:620a:198e:b0:939:de6c:cb45 with SMTP id af79cd13be357-940ef94d07fmr1553252285a.47.1793108944880;
        Tue, 27 Oct 2026 06:49:04 -0700 (PDT)
X-Received: by 2002:a05:620a:198e:b0:939:de6c:cb45 with SMTP id af79cd13be357-940ef94d07fmr1553246685a.47.1793108944232;
        Tue, 27 Oct 2026 06:49:04 -0700 (PDT)
Received: from localhost ([93.144.6.81])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c46bd79683csm454696566b.69.2026.10.27.06.49.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 06:49:03 -0700 (PDT)
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Date: Tue, 27 Oct 2026 14:48:40 +0100
Subject: [PATCH net v2 5/6] net: stmmac: fix VLAN tag stripping on short
 and non-linear RX frames
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
Message-Id: <20261027-stmmac-xdp-fixes-v2-5-10eae8a093a8@oss.qualcomm.com>
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
        bpf@vger.kernel.org, Nicolai Buchwitz <nb@tipi-net.de>
X-Mailer: b4 0.14.3
X-Authority-Analysis: v=2.4 cv=GYyCDgXL c=1 sm=1 tr=0 ts=6ae0abd1 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=7fYLNvKHbgS61GKHX+yayQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=hePLJVBFsHslUFHqtFkA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-ORIG-GUID: sPbVSWCkXQhla-Fu3peOvhO-ScqG9FSL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA1NCBTYWx0ZWRfX9rd0IPjRNC/v
 qQWsPfXpv2gWpt0AZeI1c23I+gFtHtj2aFim952JaVC/JTPHCGYJld8Vo7ljAH9y/3oIFaaNGee
 dV3E6b64o4RoLwGmcXqrit5L5LMdcU2iG78LQ3MtwB8fBY+wz6i+haqwhP240nesfYG15WSOfkj
 j0zZ2d/+zJJuNI+RUQojk5ZGrRRpg79xnZhCc6hJa2DtxcooBMEG/72DP1MGqwcCQb3JCtsEz2h
 NkUl3osys6ejHW8BUKYl38I6AibkBWneSkf9RW6OWisit6VIUcP+n9YcVzsmHm3WxRttpkzYJEg
 1sh9EN6C1SbzgyS+Erfy5Dijtki50e80Ri4iu4+qR+FiV9Rz/ISDRyEJkKrKRpS501vugnaViyn
 fJ756dphbqMt+r/upKcFiMOls2vfqo5du7DdNNTI4qrL5ZcP5TZUunY/p5iaoCZlwXVuiWkuywG
 Z2MMZ/CeoIgl6oMp1AQ==
X-Proofpoint-GUID: sPbVSWCkXQhla-Fu3peOvhO-ScqG9FSL
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDA1NCBTYWx0ZWRfX8DrLefMHx3R4
 tIXbJg0alzOId5xs9MpO2EtllLH+zVVkWyGN4NyHB8xpV0+YwJ08tUcPPp/v3UTdTAYs/Ays35c
 EHAKDL3yFD+W4tTg+IgciD9zdJbhCJQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 lowpriorityscore=0 adultscore=0 bulkscore=0
 malwarescore=0 impostorscore=0 phishscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610270054

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
provide the full header. This also drops and counts frames shorter than
ETH_HLEN in rx_dropped, even when VLAN RX offload is disabled;
bpf_xdp_adjust_head() and bpf_xdp_adjust_tail() cannot produce such a
frame, so it only affects a runt that reaches the driver, and dropping it
is safer than handing it to eth_type_trans().

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
index d9fc2464a160..fb3b7174599e 100644
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
@@ -6066,12 +6082,14 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
 
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

