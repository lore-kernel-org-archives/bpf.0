Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795282116;
	b=suOw95UOXbjWn86GPHo3iYLgUr7r2NLY9MbkZizZiivN5CbxC0gr5qRDcaNoeyLeuBuM
	 +ToZb2Hyu5tcsS0Bsyh5Xq4l0cTaoU1fBRVUqlBiCnY3iGsUTfWegj6CAQZI67aGiYp3X
	 MSTV34PtP3sFNgbxKgBGHX8SxBmCo6edwgOouoRfVHKeVWquTb3Vdg3xHyYqM7O93fEhI
	 /RuD6A1FFmJ+3HMlBt5dYQDq4uQ2zoCYfwUFncV7d1jKb1/W/OmhkXJw8nNmzCcxKp4MU
	 An7BLWKKFm82BT/J3aiGLGUgeJEAr+qRVpNWKyxg1s2/1KYcuZA7+2lgfpQBDCje7SQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795282116;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=heUKnejAm5jGj5TLnTY1uaqlIyiHEz5k7ilXGa71fFc=;
	b=bmiIwU8DRfAJGD1jekkrWsgP3CisPr8+VomBOrHBwhwcqX39RYfUi+7hwkNblhqtffif
	 bjj5Z1glQxzukZSfgFcy4MpiBG+VadYuLp0g6d4aY2SILaLfGZN1OBwddTGx7ASH82qT8
	 hgnTP8WwmnFTDE1iu387OK9JWCaqsTZC73L5aO81DCewVsHcdMbtfzi2gIMoq9qe0Q49i
	 8h1p0n/YTCgsyyhjCYfKQn7lfiX8iqycTZ8cp7JmW1Vf6AxFfYs7Siw3VU9MIX5bxZuoC
	 gjNL4cqdPVdYLLgF2ienBTUmWx1KSQ0VXv2rYWoaxmYB81AtfbWfOX7RUEQJ5vEgkKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=gRiSyNEm;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=TfCw6UtO;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 855AB606A338
	for <bpf@vger.kernel.org>; Sat, 21 Nov 2026 17:28:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 855AB606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=gRiSyNEm;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=TfCw6UtO
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ALFa4Dx909109
	for <bpf@vger.kernel.org>; Sat, 21 Nov 2026 17:28:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	heUKnejAm5jGj5TLnTY1uaqlIyiHEz5k7ilXGa71fFc=; b=gRiSyNEmHndj6876
	96wz/7K9Z0Odna6gDmMRy9uLSoQqLAOM9YHag3+ctAPHwxRwtfmKb1HB02yZIYsn
	+l1J7Hzgjs2G7Wv2ZzX5eZkaGUGw5qVsf2T46PiWcBxkYZicW3bUQ4QEDSvVT32X
	cPBr6IbBwqk3NDfmwC9KEAEPyeCw5yTlZdpsZePShyvA8i5ojq+2mFYNHgGmebbv
	89PFa/3E4h+69co5QyANzsuy4dU9iBHDwTVbHrzho0hoF+C7EOn9b4LJsVaRqNQT
	Z1QfNw7FIRfdoRxvjpB4WILdXOK8Gvqr7SBu1XkIlzKQUQ2EwtsD8ga+UNcBI5ex
	cWG0yg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j33h31mrx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Sat, 21 Nov 2026 17:28:35 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-947a607ec40so198747185a.3
        for <bpf@vger.kernel.org>; Sat, 21 Nov 2026 09:28:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795282115; x=1795886915; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=heUKnejAm5jGj5TLnTY1uaqlIyiHEz5k7ilXGa71fFc=;
        b=TfCw6UtOz/LRgavta8xT9vmEZWwDd+Z5SkJGA567u0iaSL8+8QD67A8p3urEcyvksF
         PANcLIIeJUyocRY3NgTMOiRpNqoxCHqGFDEFDEj29bbcyUTaJcP95FMJ5L5hX17TnnTU
         7ywomoAX+cosr6woynliQUZyMRNuZf9biNtn9tT4hSluHl0aqsOLGzEdIzmjjyygPPH3
         MovBRP6EyuCtKCEYXeBgO8xbkbLQsBVAPvXRV5jNVCbe4UeY3fwUvdDPjH1ySzIJmbgd
         Ay3hhPqwfrlmFHf4PBG1DW86XXqjNN59OwHTEQqK7WXAblUmiWryzoEOnTWVR6AibS6K
         42bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795282115; x=1795886915;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=heUKnejAm5jGj5TLnTY1uaqlIyiHEz5k7ilXGa71fFc=;
        b=GcuQSqBpYj52LOK3QZtREajNb6F/f/lcfl+KhQKRNQV9nyW3GSCWVQuyYaZ8aMgYML
         98ZdCcvCUZiLsIRPT6CAPty5KqRr1MoZ8qDXSsVQYlm7TdFX81Qd4AFWU2nxx69j44yW
         pZeow7T9JxHOC+2oe8RAkNy6x0uA9MJlEFcba7ykIqD0GDJO/PvjbpAtuZZ94tTGZeYE
         seqTzCH/xB8/VTFyC5XF/6sP4k9WHqCu0UFk4NxIFMDxDoMETELlNwEYS63XC+syfNqj
         JtYa1trJuD9O50M/baBRI91OlVOXDy3eCgy0Bp4pjfmnBo0C5eRRqDwRB76avdf+fc2N
         pfJQ==
X-Forwarded-Encrypted: i=1; AL+hErEoBEg0oVWUQA/YwYYsKhUQ2mfVxtHwd3WsWab+yaxmkW+QNYTSKR0k2fqmBSJFhFQBSN0=@vger.kernel.org
X-Gm-Message-State: APuU4Z/lR3JhvchEeWEtvQB5o2CzmJt8+ob/4wR4K6r0InMNP2THGXXk
	fokbsNe6GqQqRpWzk3RHIUwvPtZLgtPM+3ytIv6nf/iftrbaRZjtewYHPg0ugV2OD+E2ts53Adb
	/6+hbOXjBz/gFK9oqXwh+KMjieQRaxEjIAldK2dqHBZ5eg9bw2h2fikI=
X-Gm-Gg: AZFdTZcUfJDsWN+Nv4WugjSzDKSS/Ol2AVZUII6rq1cO5hPKQXyePNkw/5rHnjkvp6J
	YPfF6ZsbSXkT5tJLjiOpwgqag+lvWyVohYFiCb9xWg5F0HQbsmBQAhTWivQ0t38rRZnufpS83Xt
	83KrReKCqvptsTuZn3G3guQKPpqKb+918SMQEw3yRaY4sb6M9CVv/i193nugYU4ueEEh3V5kZAx
	3hF90K6tuWJwWxcxqq6pLwXwYD92ceeeVK/6SdXgns6ar0Z6ex6xJPGS7cKQFEptcWHqQLP1byl
	6xQ6x5zQG5TQuX61Er5tipuVMFmgteHZnOxyklK2pUKhXJ6NMJb2VAGdYnVYo2XmrPyFaTvfEL+
	4S/2SpJGR6OYH8MtsKFEhqRwOtt0t3JsMAzdNKpojE6skWFDweAQci+EPOjDg/wM=
X-Received: by 2002:a05:620a:4446:b0:949:70f1:de2f with SMTP id af79cd13be357-949ba8260f2mr1052545585a.8.1795282114598;
        Sat, 21 Nov 2026 09:28:34 -0800 (PST)
X-Received: by 2002:a05:620a:4446:b0:949:70f1:de2f with SMTP id af79cd13be357-949ba8260f2mr1052542085a.8.1795282114034;
        Sat, 21 Nov 2026 09:28:34 -0800 (PST)
Received: from localhost ([188.152.73.83])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb85399d52sm199723775e9.6.2026.11.21.09.28.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 09:28:33 -0800 (PST)
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Date: Sat, 21 Nov 2026 18:28:12 +0100
Subject: [PATCH net-next v12 1/4] net: xdp: add __xdp_build_skb_from_buff()
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
Message-Id: <20261121-stmmac-rx-mb-v12-1-3ae2f3bce174@oss.qualcomm.com>
References: <20261121-stmmac-rx-mb-v12-0-3ae2f3bce174@oss.qualcomm.com>
In-Reply-To: <20261121-stmmac-rx-mb-v12-0-3ae2f3bce174@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=EsxHPicA c=1 sm=1 tr=0 ts=6b01d4c3 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=mlS0om9xteqVCAF/aDpb2g==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=Tg0PG1yVOJps9yXbb-UA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-ORIG-GUID: PHr_PfaCN8dtZUwxHZSCJtEjVgE2jNfl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIxMDA2OSBTYWx0ZWRfXwKVtbLmFjRl+
 BP+y2opC/dIV/jCGcl3+MpKD//HNdXaKkNN6GJHi1sBfbfTeA+E2Kwk1g7K4gk13+5R0gZJACmN
 yRE6QDMRi7k9HlHI6v4reatiCzVbrP2c8O9+xUGVwKELZQBtQEsP5lTu9nfexpvsBXDY0k7oqr3
 tg9jtMBpCKvThjGxwTBr8/Me0XOZ60pj5qxsgb7xXg2ChFvTqCh8ZFu0sUoHd7oWMkXJ5XrZSDD
 CWvE3ROH+1s8EBQ7rUzzXvPwsFzBAlyBXIyQ/uauzbZuALb1QEcJHLa02GgH8tKxJKRaeUeCKwr
 pWnSb2Ao5aiJrh+9DR3AF5Q/ckQiuEMWDlnkaL4UjUIzyumyl42bDYv65p1soQV99vcBFni4lah
 bFKaE4vcKN8nMsnkkZGMck9eMYX6sSX6p/GfeaKyabhwWaF5Lc1//2e2Y6+1TPQeiHvs7sstfNl
 23jaeRd0PoC9jv6/1dw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIxMDA2OSBTYWx0ZWRfX5JebCg6jEbtZ
 UCkcFbnOfRN6vwOHf1fJtPckUEhNEkTZl2JmpZFLkNJFCUsqC2dpPvSDh7gSNutH1VosU/Hx0qh
 wcA7rVNsXIb1JaqbO/TA4j3lGffn0yw=
X-Proofpoint-GUID: PHr_PfaCN8dtZUwxHZSCJtEjVgE2jNfl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-21_04,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 suspectscore=0 clxscore=1015
 adultscore=0 spamscore=0 impostorscore=0 phishscore=0 bulkscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611210069

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

