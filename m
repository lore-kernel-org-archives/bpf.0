Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794920339;
	b=k9bznEphfQQkBdaTldCJrOon9Xoz87oQPbyck4QQMfFaLFW6WM3r9czQCiXrVxbBfW5d
	 JzQD1pKQj+qo3h26fxMK57KxSlFo/eoYWoKrVZgYQYlH/qMI4wW0imkNGEwEy5Jy/qkxm
	 B7AQYCNlWki3XWhfNKPfNcxKw3vDBzF2SywPxdxgMrV5FkejAAB60Pg0W6YEp4L8vHSWe
	 eIfaaBNi3btQX+kYvMGAtIHe+Vx8h3CqQJ1+4usC9+kHR+Ei8t90Lin513GRrQzJOD/az
	 0P2V8wriif4oNF9YUfnlwDwAb52ghuB+XsdEuHsavqGMr4u+STszRYcr5RdJSR57u0w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794920339;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=heUKnejAm5jGj5TLnTY1uaqlIyiHEz5k7ilXGa71fFc=;
	b=eUD1SWP1ze0Sdy14orEifOZvIfSnph3Z7Qn1G7eaEgrsif90A/MHMFyquMg8gn3+s6UJ
	 6lV8ro0Usk0BV+buk5KCNYOMdGn7CHiNpBxckxKVJFvZ6S6FHEB/QDs0bJoZ7ytY8d1aM
	 UJpDzVIV0tWSS7mGaS6qyLVY6qYyUKFprI/Q3OKyYiKfavFTUYOfP1TH94nNdgeQyKQcQ
	 LwQcw7AB69yZsNrqBrB7gecEJI88pq1yDf3Plw2sbyWrajHt1j92ersW1A2G7jI4XJEpW
	 ChCZZMxY15/vaeP6XIhjxl9unaMhCSn77tudiZGasa9oAJiEMxjK07kiFQgCXd/IXUg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b="KQQi5/oR";
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=jC1NOODG;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2FFB606A89D
	for <bpf@vger.kernel.org>; Tue, 17 Nov 2026 12:58:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D2FFB606A89D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=KQQi5/oR;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=jC1NOODG
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AHC1L2R686550
	for <bpf@vger.kernel.org>; Tue, 17 Nov 2026 12:58:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	heUKnejAm5jGj5TLnTY1uaqlIyiHEz5k7ilXGa71fFc=; b=KQQi5/oRWvB62OxA
	M9dhh1/XSNzwLUcrvTvdkr/g75f8xuXqKO2vi0eTx0xAkAQ7mzmAS1hf5PNFh8T4
	iBRHOKkcTQQ1ch3mL0XWLmX3Ydlr+Q2M9T887ttU5nOB/w5svUDlohMQdIHw4Czp
	Cn7c2lskk2O5CL7joAMi7C4jm6AiF2kRzdYai+cWuMQLb1xkHWs4WcvLWyxuPXub
	aYtbfMbuVPgLxO8Ou9o48o4mPTnabt5oBtXb5YOi87S66DT6o37t96XltbCIJ9WZ
	eS81xG8cdm4gn4pNSN5R3K2x0/M1Ohkott/WBxHTZRG5kW+Fl7mXRDa3KnJxs/2p
	AeZjSg==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j07reknu7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Tue, 17 Nov 2026 12:58:57 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-9210ad74fdeso5689426d6.0
        for <bpf@vger.kernel.org>; Tue, 17 Nov 2026 04:58:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794920337; x=1795525137; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=heUKnejAm5jGj5TLnTY1uaqlIyiHEz5k7ilXGa71fFc=;
        b=jC1NOODGXSUqSB1o3x6jRvygHRTt4ohcg1hdwXm+IPzOxo4qvu1OrytSH56DwD+Xw+
         TFgMRVXENSKH9cfY6tlEIU5jq62K+7LsjlFWYDuWADSiGxFKh7ayBkq4FX1bJb207Wxq
         0B9wEhYJhb5pSzLfbbNoXVPLXrNhmaz8gqrb++kPzNhqU1CxYAo2kh9+7UNFwR//pJPO
         Q4q9n5okHVhH0FkenVthQxTmmPdzJZOxoA1XEIdYrdvt5KOF3cZiM5KAStbCjiAYAv4x
         hayIurit7nuZ0kDGohn8MIMV0NW6pRI/2RtqFVev6kCwTyrfIyfL4wRfJaG2dSo128EB
         5Snw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794920337; x=1795525137;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=heUKnejAm5jGj5TLnTY1uaqlIyiHEz5k7ilXGa71fFc=;
        b=2JY7jC/T33VegYXIWknIVqFJhUOzmQLKZZGHqdDPgLvmjlmejhao9CwPiXFkSU5uFe
         VxFyDiNTaswoRbJPqPYQAGDmE6OGIQi8HF4n2XKc+Q9DAi1k7FvvRZKfWivNgTAfZmmV
         NBGSCp/ORdpO7yGNWOgi5+mMdbls2yMpXXAn+PFv52fISE2enKtKS/80HCBnAkg9vITN
         JF0a0Ukl3GdiKiubI0v5x/EPUn9JryK2lg6JHeF++TEN1e8xRFeM6uJsqNlIHH35yW8W
         rTILu34bjv/ZbxgBt2RsdA9MagdIK1WaNnZQfApVSwNJaCn5y4ZGbFm8D4lKdSCIC9yU
         /kFA==
X-Forwarded-Encrypted: i=1; AL+hErGXm/z+9tpYWUPepmt03utJlHlfWT0u4kp9Xr4TvMuDs3HmJeFbBXlPaAP+OHhkUj2cg+k=@vger.kernel.org
X-Gm-Message-State: APuU4Z87rrPd3O3zFY8Xcc29avDMA+YvN1qLjLuRefYmVNUsoISyUrUU
	bm6uVrPYxnvDC+u/5W7SF6L2paqz/CgTGR6LaMVjkXeVWUYuU9EPoE8WAfuLbzIlwrMNhfvxLl/
	p7aaFXZgl2yLWQ4nMu3VwmdzA3BVAU3ua07jMdmv7x8GnoKQNS271Lbo=
X-Gm-Gg: AYBFou1+H+iQfU13kSw6PjikGsv++jFpb4nTeU40RV6AArCYUgLFZAvrItYdpYwKRB4
	n6GBdXT8/KuTN8kAGWnw1K50zD89MeMWqirAVuX+sdNkWabp9Dhtz1UDLAZnPpd/kr2Beq4bwmq
	2gxSE6XWN4frLJaw7muQXpntXICY3EDzG3uA8xY2W4scK/c051uNZM6qjkOCI6b8Ap7wdeXTyPd
	E6wG7CtW7NMOp9Vlhd7AWW759OdYHt9NMITObBDsppd1cyv1SiaUtgeGL6Pd1NHnQXvMxC3Yttl
	yHBHbTKErYbfhtPn2hDJc3KkrDS43n2Wcnv4DRENfevapt0LkPQMGZr/P7wmyB1x5vLdeRBsP9X
	istljZQFGdcmefd9sA01bBkB2SuLVf+YrfxtaxLchxc0O5FrtqY0XN9j7OuG9Xs0P/EgCT9tgZl
	VYEu0RiD7mMu1p4jDzmBKSyBwewRI=
X-Received: by 2002:a05:620a:684a:b0:93f:3358:3ed7 with SMTP id af79cd13be357-9494bb399acmr1976655185a.54.1794920336367;
        Tue, 17 Nov 2026 04:58:56 -0800 (PST)
X-Received: by 2002:a05:620a:684a:b0:93f:3358:3ed7 with SMTP id af79cd13be357-9494bb399acmr1976651185a.54.1794920335795;
        Tue, 17 Nov 2026 04:58:55 -0800 (PST)
Received: from localhost (net-188-152-73-83.cust.dsl.teletu.it. [188.152.73.83])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4a32155283bsm5688357f8f.37.2026.11.17.04.58.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 04:58:55 -0800 (PST)
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Date: Tue, 17 Nov 2026 13:58:27 +0100
Subject: [PATCH net-next v11 1/4] net: xdp: add __xdp_build_skb_from_buff()
 helper
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
Message-Id: <20261117-stmmac-rx-mb-v11-1-9fa5c34ef245@oss.qualcomm.com>
References: <20261117-stmmac-rx-mb-v11-0-9fa5c34ef245@oss.qualcomm.com>
In-Reply-To: <20261117-stmmac-rx-mb-v11-0-9fa5c34ef245@oss.qualcomm.com>
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
        Simon Horman <horms@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Eduard Zingerman <eddyz87@gmail.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
        Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
        Emil Tsalapatis <emil@etsalapatis.com>,
        Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        bpf@vger.kernel.org,
        Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE3MDA1MSBTYWx0ZWRfX5/v0LYAVgssD
 Wrwe8asCOshK9hUdW6Tc1ns0Ae2HM2js9ZV/1WzdKaJ97C4bHndYo5Bx3p93NcmY2kwE1cEGggL
 ap7Fkgod/vGqfnWecfX1XrTbVS9tfZY=
X-Proofpoint-ORIG-GUID: RUrKDpECbIEcKudWv4bm-VS3UIMSovOP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE3MDA1MSBTYWx0ZWRfX2A8hkyrqXSvt
 BJzMrbshedeWkTUhx6vfR6H+RyoLWcQCQle4vcnmBk6jI2sU/L7kY1ObVe+hnsxhG/narSrIjix
 Vxxg8EP1HT12d2m6aHryn5XoBtek2JXP9EG+m3yruLYdkbq4nyeNN7he/6GwHAI8oTJ41RPwa9U
 ymNoJdEuqGtL7Tsu6hdEyK85Jdh79VasZo1vxSSTxKqPU7DUq9/O8ABx8jvqYD4J6fgiC5e9hqv
 oi2H+Xkx+wxywVBOMC7xVkx0XtVLevlISnhZAYJEuaTLoMQaJMpaU6gdg695dwosgKDi2eSU+DN
 j7TGlhftafka0ayhwoInvQTSOkeTTA/shRsOjG9af+x0fB4pFjVymXA3ul2E9GEhjIiJCq8P06h
 ijNxO5gc7aCvHWpowYe9r6Zq3al10oJAHI7/MYc8ac7i4V/rKxg3P/exFZzOYJaalNQZ78H4BGH
 XhmB+OxcnpHeDLFDhcA==
X-Proofpoint-GUID: RUrKDpECbIEcKudWv4bm-VS3UIMSovOP
X-Authority-Analysis: v=2.4 cv=R9uWitRX c=1 sm=1 tr=0 ts=6afc4f91 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=mlS0om9xteqVCAF/aDpb2g==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=Tg0PG1yVOJps9yXbb-UA:9 a=QEXdDO2ut3YA:10
 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-17_02,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 malwarescore=0 phishscore=0 priorityscore=1501
 adultscore=0 impostorscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611170051

xdp_build_skb_from_buff() always calls eth_type_trans() on the skb it
builds, which pulls the Ethernet header and advances skb->data. Drivers
that still need to process the L2 header before protocol parsing
therefore cannot use the helper.

stmmac is such a driver: its software VLAN path (stmmac_rx_vlan()) reads
the VLAN tag at skb->data and shifts the MAC addresses over it, so it has
to run before eth_type_trans().

Split the implementation into __xdp_build_skb_from_buff(), which builds
the skb (including the recycle mark, the Rx queue index and the frags
info) but leaves skb->dev, skb->protocol, skb->pkt_type and the mac
header unset, so the caller must initialize them, usually by calling
eth_type_trans(). Make xdp_build_skb_from_buff() a static inline wrapper
that still calls eth_type_trans() as before, preserving the behavior of
existing in-tree users. A follow-up patch will let stmmac use it.

Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
---
 include/net/xdp.h | 29 ++++++++++++++++++++++++++++-
 net/core/xdp.c    | 15 +++++++++------
 2 files changed, 37 insertions(+), 7 deletions(-)

diff --git a/include/net/xdp.h b/include/net/xdp.h
index 07231adfb5f8..054748b37d7d 100644
--- a/include/net/xdp.h
+++ b/include/net/xdp.h
@@ -7,6 +7,7 @@
 #define __LINUX_NET_XDP_H__
 
 #include <linux/bitfield.h>
+#include <linux/etherdevice.h>
 #include <linux/filter.h>
 #include <linux/netdevice.h>
 #include <linux/skbuff.h> /* skb_shared_info */
@@ -379,7 +380,33 @@ xdp_update_skb_frags_info(struct sk_buff *skb, u8 nr_frags,
 void xdp_warn(const char *msg, const char *func, const int line);
 #define XDP_WARN(msg) xdp_warn(msg, __func__, __LINE__)
 
-struct sk_buff *xdp_build_skb_from_buff(const struct xdp_buff *xdp);
+struct sk_buff *__xdp_build_skb_from_buff(const struct xdp_buff *xdp);
+
+/**
+ * xdp_build_skb_from_buff - create an skb from &xdp_buff
+ * @xdp: &xdp_buff to convert to an skb
+ *
+ * Same as __xdp_build_skb_from_buff(), but also calls eth_type_trans(),
+ * which sets skb->dev, skb->protocol and skb->pkt_type, resets the mac
+ * header and pulls the Ethernet header.
+ *
+ * Return: new &sk_buff on success, %NULL on error.
+ */
+static inline
+struct sk_buff *xdp_build_skb_from_buff(const struct xdp_buff *xdp)
+{
+	const struct xdp_rxq_info *rxq = xdp->rxq;
+	struct sk_buff *skb;
+
+	skb = __xdp_build_skb_from_buff(xdp);
+	if (!skb)
+		return NULL;
+
+	skb->protocol = eth_type_trans(skb, rxq->dev);
+
+	return skb;
+}
+
 struct sk_buff *xdp_build_skb_from_zc(struct xdp_buff *xdp);
 struct xdp_frame *xdp_convert_zc_to_xdp_frame(struct xdp_buff *xdp);
 struct sk_buff *__xdp_build_skb_from_frame(struct xdp_frame *xdpf,
diff --git a/net/core/xdp.c b/net/core/xdp.c
index 1d679e8fd649..0db2f68afc5c 100644
--- a/net/core/xdp.c
+++ b/net/core/xdp.c
@@ -620,17 +620,22 @@ void xdp_warn(const char *msg, const char *func, const int line)
 EXPORT_SYMBOL_GPL(xdp_warn);
 
 /**
- * xdp_build_skb_from_buff - create an skb from &xdp_buff
+ * __xdp_build_skb_from_buff - create an skb from &xdp_buff
  * @xdp: &xdp_buff to convert to an skb
  *
  * Perform common operations to create a new skb to pass up the stack from
  * &xdp_buff: allocate an skb head from the NAPI percpu cache, initialize
  * skb data pointers and offsets, set the recycle bit if the buff is
- * PP-backed, Rx queue index, protocol and update frags info.
+ * PP-backed, record the Rx queue index and update frags info.
+ *
+ * This routine does not call eth_type_trans(), so skb->dev,
+ * skb->protocol, skb->pkt_type and the mac header are left unset.
+ * Callers must initialize this state themselves, usually by calling
+ * eth_type_trans(), before passing the skb up the stack.
  *
  * Return: new &sk_buff on success, %NULL on error.
  */
-struct sk_buff *xdp_build_skb_from_buff(const struct xdp_buff *xdp)
+struct sk_buff *__xdp_build_skb_from_buff(const struct xdp_buff *xdp)
 {
 	const struct xdp_rxq_info *rxq = xdp->rxq;
 	const struct skb_shared_info *sinfo;
@@ -667,11 +672,9 @@ struct sk_buff *xdp_build_skb_from_buff(const struct xdp_buff *xdp)
 					  tsize, xdp_buff_get_skb_flags(xdp));
 	}
 
-	skb->protocol = eth_type_trans(skb, rxq->dev);
-
 	return skb;
 }
-EXPORT_SYMBOL_GPL(xdp_build_skb_from_buff);
+EXPORT_SYMBOL_GPL(__xdp_build_skb_from_buff);
 
 /**
  * xdp_copy_frags_from_zc - copy frags from XSk buff to skb

-- 
2.56.1

