Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794501288;
	b=ywYp18uY06gU6WMJ2F1O0H8TqNMh271BaBhVTHHa7zLq39ykvH4yj0rfXNiJwVqSqUy0
	 x6shObymoGr5fDlP610kPuYCvSIRMtscGSkhgamW80n6BbptKetGDtntx7UVJXFsZdgLb
	 gh7Fzmb7LuZluT1HxBVCnqUy4QTBfHTAdZVsyRdxy1WoHvfER249/bxYOoERAd0Utouiv
	 XKqy2mfWaagjWSEIdR3PW0xcB7sO5ClhW1wNVImfC3URNp2WTm/d20ctn/OoxP3fZqs33
	 y2e839YdNRdB+bB5aqElKI5UG9Vl+cC7qN+28s+vddcQRC/yt1MoAUvURlFfMiig6wA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794501288;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=ht9dr7DTrvc5N3Sijprb8a3IFfZmsbP7xbKAQ2/ikn8=;
	b=oFPso1BpSnMYyLPITqVcOG6T/6V82Nh2+2HP9dxz4Hj9d5TRrAF6D9JnLPx92X4Rfb+k
	 bO4VBPMmlU13XI4ACVgtd7ojlt7oAPUSNo8dwr2fZeCXQqNDf+3XZjGmm3hEqwsYOHHLY
	 WmDP/gmdaKb2m7W25sbNpVc+jgRyVJ5pafjwehkKOuLzAj0jLFVJOjuEjwt+lxiG52U3u
	 5qWSLpbTex96QdQuu9ALp7PaEUK+V634OfcU/l2lg7WWV8DqWpv5+1KcGK1v4044GiZTq
	 T15A+4qmoSXwr0nlHkS/Hx+08jgh3I5QgSbG2Cn/zf14di5eoiFykMFnmFG9EMDvryQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=jQCB+TdO;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=dAJz6Srn;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9142D606A8A2
	for <bpf@vger.kernel.org>; Thu, 12 Nov 2026 16:34:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9142D606A8A2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=jQCB+TdO;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=dAJz6Srn
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ACFZkA13181003
	for <bpf@vger.kernel.org>; Thu, 12 Nov 2026 16:34:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ht9dr7DTrvc5N3Sijprb8a3IFfZmsbP7xbKAQ2/ikn8=; b=jQCB+TdO9HvPNp0E
	q4v5lmgSswC2h7Spqpk5ruzI5e4LHB9uJjkwMFCcEekKUZyej6K1sOnPBVrJzHNC
	c2ojSkGPNzD6Ep/qyZwDewP3Ulat34rgrq1Da9rBXKXU/D4XW5LwK1eMlZbOLbgs
	MlXShAKJySgUCE4/75lDBSJhHeN/dIteMelt+ZLF84kp4gGFmhdHYSe4odw+BegI
	XPJNDUudYqk0t6iOpWnVZCAvC+lzWBRlDoGo3wz9ueyY1yscyL1Cg21K2BF2B8wR
	ufqThHxLq1KlLrk/t15NyfCLJY4fhYvRcX6tcASNu7T6bleqldQnIGLreSe0FMy5
	RIykYQ==
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com [209.85.222.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hwc1j18v8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Thu, 12 Nov 2026 16:34:46 +0000 (GMT)
Received: by mail-ua1-f70.google.com with SMTP id a1e0cc1a2514c-97e8be2221eso13257241.2
        for <bpf@vger.kernel.org>; Thu, 12 Nov 2026 08:34:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794501285; x=1795106085; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ht9dr7DTrvc5N3Sijprb8a3IFfZmsbP7xbKAQ2/ikn8=;
        b=dAJz6SrnxJI6qh1WWjsuH8CiOeWsiG8sDVamOnklBO35qCal5FElbRjKL7LEeyDBez
         7/tDBfNPkw+8yB+9zSB0rgeOIBzgnzDfxKQ1adBf693M50MToBfeliX24GNAJB351iUm
         QQ+WEeLxJKuwRo+gDYOe/vL5HRDii6ln7KeD55tFAZG7JZHPxVwEILX2BE0rvkOXYERr
         BDF2wfFR3h9yxQom92cBUbQrcfWFKHuidryokB6fBT4Nsm8FREwE3GUhfZi3RpS6GQZq
         g1nEvpPa+xgLqT1fh/mNeS0YLO6oY/iBT3gQpM97iqoc4vpZIlhgxLK+BKNRPTMAPMTf
         ps4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794501285; x=1795106085;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ht9dr7DTrvc5N3Sijprb8a3IFfZmsbP7xbKAQ2/ikn8=;
        b=wMQTSrqWBFAOKS25263HdGrlbN/tUMyS/l5K0ZxcRUXsQl2S3a6+aqtUVcbRWo+QVO
         A6TIAN9YMqwl2QGF1HT3mY6ynsK58NEayoLkUQGUyMDftDBZsJeG1xJJxC5G08nPOHtX
         Ag7XUNLx9rNya8WO2nZvoCr1ixSDeHiyQDlP/CGb948N0jtGVHAtY/XYvp6ESeLuE483
         9i3a9Ba/+ZitWjAJc8qb2G55WXKUG89YaaskjQH+1wmGBpWX5yK7oiLXhYS6HSDQ1Ktw
         VUM3msEyh6pa0+uWzxjzVXQh60zJheI29F50yrD6ELJcRhPCahr2mt92lhDM3k1TDxqa
         cszw==
X-Forwarded-Encrypted: i=1; AL+hErGLVuBmQzx4mdFUvZF1pnkDaXIFdd94UIkxhL0C3ORIgZVOC/8m0xBgFtZcvvBh+tM7TdU=@vger.kernel.org
X-Gm-Message-State: APuU4Z8r2J5oo+iTokcjfButxTlDLjYF8d/QiCYYgvFde02WWYSqBfOi
	StSrXp3tejFOulG5aJzpZkmyZVR4ai8NLhxvDuHULrVJpfllDXWe166qZ0BrzB5n27Eoxjm/XLi
	h8B4XnQcjZHtn7J5Imn1zDJpsEcb/+3EjpbzVGcOVeI0mdAtzjI2pHSc=
X-Gm-Gg: AYBFou3W+1mGu8AU1Y+n+X3FQKpTVc+/wlPWhuy/wQJG2ZCdgQJj1GWHyOAMfrdEg1w
	qgL+UB8BVgZgbvzsoFahWqbL6ERHutLlWl16Z5k1hVeOl+9jV15mxZtL0cGKUBpucNSQtWx5blU
	gi1BPW6f7jkId5tMSYrzj9Z4IGymiL9qbExgAsug57Gf4ukyEuevtUbr0okZ5kbuHieihg2lMjk
	fP2KON0783j7FrwKUaz2zPmuOKRA41dcVZtk7KDVO26/L6cgJl88JlpLzgha9L8i9SrU8tSHI17
	QpUWcjsavJfR/vHtW53dT3hPC9v9SO/fk7QpgzUPknqHY/izh+WPCdKbveG2jNnhp6L/6ZAJ7gt
	/7sLaxlvzUqVCCuc5F0sx20UrGPG7PCSyPGY++JDKymxNPjlNOobxiu1YJJShEzY=
X-Received: by 2002:a05:6102:2928:b0:7cc:95ed:3147 with SMTP id ada2fe7eead31-7d5061e6d3bmr2487626137.34.1794501285341;
        Thu, 12 Nov 2026 08:34:45 -0800 (PST)
X-Received: by 2002:a05:6102:2928:b0:7cc:95ed:3147 with SMTP id ada2fe7eead31-7d5061e6d3bmr2487585137.34.1794501284694;
        Thu, 12 Nov 2026 08:34:44 -0800 (PST)
Received: from localhost ([93.66.104.131])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb4e2538b9sm144499035e9.1.2026.11.12.08.34.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 08:34:43 -0800 (PST)
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Date: Thu, 12 Nov 2026 17:34:10 +0100
Subject: [PATCH net-next v10 1/4] net: xdp: add __xdp_build_skb_from_buff()
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
Message-Id: <20261112-stmmac-rx-mb-v10-1-d3d04b65c6bc@oss.qualcomm.com>
References: <20261112-stmmac-rx-mb-v10-0-d3d04b65c6bc@oss.qualcomm.com>
In-Reply-To: <20261112-stmmac-rx-mb-v10-0-d3d04b65c6bc@oss.qualcomm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEyMDA2NSBTYWx0ZWRfX9LVFvrha3Z0Z
 bY5ZYGNvxyBSXUKFbzsp9e7Z46IuLYdWeXcNqpQmEOKAu4Rs6Zt54T9TVdGKHhzPuJf/NE8/Y0X
 JWXNezRlzDYIDEyhhsvJPJtgXS9YC6Y=
X-Proofpoint-ORIG-GUID: NKO45KVwnbuy38AZ6drjeIhFkyBYwMWe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEyMDA2NSBTYWx0ZWRfX4RAuOYxt7Xaw
 9jttNVETjd3shUZ5FmTuGvYL0elwt3WdQkoWlBaiJ/l4HulnIai2XDgDW7zAFuoKlXtPSEfgArZ
 VLB/UG8tiH33uO98NkndCmJVgFspKpCwSY+cv81gLQQ9FXwVxdsIMt6DM0GG9cf1s9nehgtezm4
 Yxaw78jPrt8J1cGq2ao6J0G+g+cHnqZYQacW9Ulj6yD6Bl0JivuBEE5wU+5e124AFwSXUpHq4bW
 JV7Rd+7ssps45Y7b9n9yjzM4wxANwgGV36G/ipDnSfueczkBjPFvDq0dAs7a3GR6VkS+BO5sWS4
 lNOKxort66nNQQHFBYa8PdCADCRyou+r1R9ay2+Zl0rhWZAmjI/So585R1bd0AVeJvcL9iaGagq
 duUc9pfWHJ0Sd9uO2Pv8kHzSJX8gQdA66HRrTp9zMEw8LQdaXZzjcHzPxWPdZcvezejHeT+hth5
 0RR6umbpwgZjixP4duw==
X-Proofpoint-GUID: NKO45KVwnbuy38AZ6drjeIhFkyBYwMWe
X-Authority-Analysis: v=2.4 cv=Vqe2kO2n c=1 sm=1 tr=0 ts=6af5eaa6 cx=c_pps
 a=R6oCqFB+Yf/t2GF8e0/dFg==:117 a=cAAIdyqZgEis9HJxay2Blw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=ksGhbug9fU3i8ddnHjYA:9 a=QEXdDO2ut3YA:10
 a=TD8TdBvy0hsOASGTdmB-:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-12_02,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 priorityscore=1501 spamscore=0 adultscore=0
 bulkscore=0 impostorscore=0 malwarescore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611120065

xdp_build_skb_from_buff() always calls eth_type_trans() on the skb it
builds, which consumes the Ethernet header and advances skb->data.
Drivers that still need to process the L2 header before protocol parsing
therefore cannot use the helper.

stmmac is such a driver: its software VLAN path (stmmac_rx_vlan()) reads
the tag at skb->data and shifts the MAC addresses, so it has to run
before eth_type_trans().

Split the implementation into __xdp_build_skb_from_buff(), which builds
the skb (including the recycle mark, the Rx queue index and the frags
info) but leaves protocol parsing to the caller, and make
xdp_build_skb_from_buff() an inline wrapper that still calls
eth_type_trans() as before. There is no functional change for existing
users; a follow-up patch will let stmmac use the underscore variant.

Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
---
 include/net/xdp.h | 17 ++++++++++++++++-
 net/core/xdp.c    | 11 +++++------
 2 files changed, 21 insertions(+), 7 deletions(-)

diff --git a/include/net/xdp.h b/include/net/xdp.h
index 07231adfb5f8..3a25307e1d67 100644
--- a/include/net/xdp.h
+++ b/include/net/xdp.h
@@ -379,7 +379,22 @@ xdp_update_skb_frags_info(struct sk_buff *skb, u8 nr_frags,
 void xdp_warn(const char *msg, const char *func, const int line);
 #define XDP_WARN(msg) xdp_warn(msg, __func__, __LINE__)
 
-struct sk_buff *xdp_build_skb_from_buff(const struct xdp_buff *xdp);
+struct sk_buff *__xdp_build_skb_from_buff(const struct xdp_buff *xdp);
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
index 1d679e8fd649..470bf90d93ef 100644
--- a/net/core/xdp.c
+++ b/net/core/xdp.c
@@ -620,17 +620,18 @@ void xdp_warn(const char *msg, const char *func, const int line)
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
+ * PP-backed, record the Rx queue index and update frags info. Protocol
+ * parsing is left to the caller.
  *
  * Return: new &sk_buff on success, %NULL on error.
  */
-struct sk_buff *xdp_build_skb_from_buff(const struct xdp_buff *xdp)
+struct sk_buff *__xdp_build_skb_from_buff(const struct xdp_buff *xdp)
 {
 	const struct xdp_rxq_info *rxq = xdp->rxq;
 	const struct skb_shared_info *sinfo;
@@ -667,11 +668,9 @@ struct sk_buff *xdp_build_skb_from_buff(const struct xdp_buff *xdp)
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
2.56.0

