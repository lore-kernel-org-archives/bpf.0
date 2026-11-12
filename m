Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794501291;
	b=G6vGjwTSbmaAUQv0Xztzyyay+TvKrbA40UcP7jF3LkluAAGX1mwRUf9tsQtEVHQjMT/f
	 PwvVkajVttMLfpYoH8B8/A2HPMrPLDSd5NNTivEghrocYQtKrdcBZ++LBi5Timxj65C0i
	 xogaMWOUbL8BWDkmXqYJS+w9tb4gMvmCzVI7KQRey02edm547AiEKlDwGM1Ry2geHKokd
	 aJ1Vj3dr/8giHgBw2H/5saQ2eShr1Uy0lbK2b5OX1OG631jIfbRew5K3rXvQcNU74lPZ7
	 eyQr3H5vQx6YQILmhsl5swnVtoVJNIG+7IY+72Ynm0rJ2fOOg8pOiUmEFMV8T9lBbCA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794501291;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=sWc95ycG40mAmX2MIf/ajSXRL+qWRNcMXx384bP8aTg=;
	b=bpw1FwBwe3u9L5Xdrl4hEz9L+EeJxp/6xMsKDtRm0wJUtQ1lhXd4eoPZu7DR29qnk/er
	 GyebJqC+hS65o6chA9xV9jBTTw2kmF5j/IDJrWNtcgTwXiXQk3TvK8cUeuK18MMXOQHIL
	 PdK9q85QIur37TOZxMZ5Kf6hmBUfm85VBhaDWzar2oIXMpurj5uWOIAAROWyeDwlvKhdB
	 ghlWq9XiQHMx0qAazwyF70lBV1HSRc62JNkQvRmb/6m4s+TfIqPpKhM9ham/U2KRqU5OX
	 wPk6iQFX3kbVGswKWyweKWuhIwE4w0JYhGBwDZitR2Oxd0nlItaGQYkHWclh5zyhcZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=bBa2kNd7;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=F3Cpm4mz;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F759606C2EF
	for <bpf@vger.kernel.org>; Thu, 12 Nov 2026 16:34:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8F759606C2EF
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=bBa2kNd7;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=F3Cpm4mz
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ACFZUoB3841249
	for <bpf@vger.kernel.org>; Thu, 12 Nov 2026 16:34:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	sWc95ycG40mAmX2MIf/ajSXRL+qWRNcMXx384bP8aTg=; b=bBa2kNd729GySv3f
	ujDeXzgP9zdEdp9CTYtaUN0QvEV5xnCkbv4J+oRRySrzSOk2TvH3EikCq3IGENgx
	fMZ8vV+qZfn0OJWOX4eQCZOvWya+5H8Vh3yvul1Wy/SK34RZj7FXdW8I0yyrzkY2
	JYDUGPXrny1avnMGLT51P3VlO5hvjXCe6n9FtfErmTAYXlQ5tKObPYkQ22TLK3gR
	KSYzGjhN+iRBS/kzHlyVexi2EDMKzSb5B2ndSXdYd2mR9wMKuW/hz9mOjMrQH9bl
	yaKrs5lUR5AYrhXFy2J93yp/AdH+H5+hwOzmej+ftjKCHvav8ap6alxKT7PXja/W
	KrcOzA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hw9e19wxj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Thu, 12 Nov 2026 16:34:49 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-945b0154705so683596285a.3
        for <bpf@vger.kernel.org>; Thu, 12 Nov 2026 08:34:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794501289; x=1795106089; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sWc95ycG40mAmX2MIf/ajSXRL+qWRNcMXx384bP8aTg=;
        b=F3Cpm4mzIeoElVrJuzIs9XsKGbWkqwMFhWPCpy8rxs+luODQE6tzQje9gpuWOy+d7j
         rZslCMNn21vDtTRRzfJAzd8oaYq2NuWMawzL36izu8hpyuwdD+jUDaB+EXVXUTZE9zap
         RoBXkZk4AxOpp535uwo0abZ56FSf4h6GvFAgJevfUZAdh9s/Hzs9at8xNvlp9QbDlOps
         tkgSz8fHFt+Z8quGe4zQ58H87yJNwIr+JXt/+FgiIopNCzj3R2JRy1MvvphZFLvrT5um
         ED5nDTHFhseBhLK/eY3yb1r1ColGsDtZ4ZHN/hMwBQQHKkPNpK/Q4/ctwephYJup4xbx
         j2Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794501289; x=1795106089;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sWc95ycG40mAmX2MIf/ajSXRL+qWRNcMXx384bP8aTg=;
        b=wWsWdvVoR8xWtN6SPR+vZ683L3trx3O0fNMWoqOUx8e3Gn8ZSvVi7bDljMtLX43c1z
         rCnp2s3Cgnp6Hvv7hxUysCZEuutZdiwv9Itm+NHZkXc7HECwximR3gZsg0AoxmaKpLoH
         G/MbqbugrLw49QdXNEMCvWYy8TNDh2sG3kpR8+oQ4RWPGUgkZ07dIi+gx6ra+yHHTkXC
         Tk/1tUQL6eiGuGp7LSU+Lm+DKDAW/Ud3YUrGNDm1aDfcZmZmMM81Ueb+uHeAnoN/wwi1
         cLOwwEKQ3KxSD2avgY5QfdbEllnoi7ZQuA5udlCViqNimSQL7DPgv/86bhlQnPZIluZb
         wGog==
X-Forwarded-Encrypted: i=1; AL+hErHv4blg2CA7NeqWPYzncezSMFRMoxZpO+IDCxQeCPf543ui3Exjq8lQDYYbaauBiPGOUHQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z/chkv13o9HDpVLDZ6B5/oPkr5/EfwZHtRlJxk0iM/gCimKsy4T
	QXxafFzRH4jJk+H0wXM7Iu/+Knc2t281OhC7aCsoPQY/tVdkME9JHYRFE5OGPlx2gurhmJF5G5F
	tc7+mhNFj0OaquyOAXP6z921GLmfcEP8ukFFDbL1FP4Lfc18q7EkQ8Lk=
X-Gm-Gg: AYBFou0UfuHo0qQ/xTReBUYojbCehjUfrdMTfv2MPWgtxPd8FBdU9MENeH8TY319AZg
	KrSyk/Z5qL+XBCvkwQWXuAUaKIdco7sLXjmTyFmVZ/HqDEeXnwTq9oAm8iGx8yKEap39iD3+u+R
	53yHwbFt2hi+GpBpbBiw172VutA21g3L+KH9vpG55a47qe4WPGzeFZWbgbVGYaOtQBDKlQ9T1bA
	cFznYOOyYDiapXxlRxhgUrg/uocGzMBg6+jx8Hl38FxuwKEL/qmv/bPmpGIsCm2mpYwf/n/mPDB
	O3rgkggCTSma2FK3alTDKSYAIzjhZqB72duQP2mYO0gs7m38M5OuorXD6K0AIojRbvgg0oJ0+BU
	OkoyGdAimQRUlkBStRWXYxkyuBHIOdv3/SZV1i4f2m9JBMD8Ym8lkbS+JpRxuQ+E=
X-Received: by 2002:a05:620a:808d:b0:939:b099:d52f with SMTP id af79cd13be357-947afff4569mr974882385a.20.1794501288817;
        Thu, 12 Nov 2026 08:34:48 -0800 (PST)
X-Received: by 2002:a05:620a:808d:b0:939:b099:d52f with SMTP id af79cd13be357-947afff4569mr974877585a.20.1794501288257;
        Thu, 12 Nov 2026 08:34:48 -0800 (PST)
Received: from localhost ([93.66.104.131])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c5f1c0d7esm197476f8f.12.2026.11.12.08.34.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 08:34:47 -0800 (PST)
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Date: Thu, 12 Nov 2026 17:34:12 +0100
Subject: [PATCH net-next v10 3/4] net: xdp: add __xdp_return_buff() helper
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
Message-Id: <20261112-stmmac-rx-mb-v10-3-d3d04b65c6bc@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEyMDA2NiBTYWx0ZWRfX6sqflZSLjz0P
 cAESE019Y9C90t4qn2sGvVbXLFoYv2hEINSol80meO39K/LTCbcufcuyz5gs/sMGZteNa5BJBji
 v3SThcZbLkKxUGxXGF2qURb+NhKm3EWUIibUdgzQO+pvUANq9jO2AJpdoOB0+KzY1oGB8wFWITL
 VsvifwgSNdF3koOxD5V10teVp+t3gdcQdHFaBmrb38QVUjpinlqu2qBc4wZHU/NVlI87UqHICtz
 RcikwA4Ljcp5EDq9dez9LnegAZI2N7mB2PM84cNH7ciUw9Vij5HpJsiPTWcLNzjW0YNqeLp+091
 xudK27pO4V4WR8Wl8EpWe7izLZSTkknMQ6UsEe5CeIrhXwKcRE3pDqa5kcUNo/DTrTfKjfezfE9
 0N9wT2xmJHvU0fVfUnfaqY3C8pq6JRLCVRdti/vubKQY/YwgEWtTp7n4v9YJc3+Tgs1jWlCVt1p
 4ioQL/ZfOBK25QZRpBg==
X-Proofpoint-GUID: RQUW3ypQ8jJxoWdWuD3TuW4VzpDM1WG6
X-Proofpoint-ORIG-GUID: RQUW3ypQ8jJxoWdWuD3TuW4VzpDM1WG6
X-Authority-Analysis: v=2.4 cv=F6fC5ahN c=1 sm=1 tr=0 ts=6af5eaa9 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=cAAIdyqZgEis9HJxay2Blw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=EPvaxb3vtNQ3FCvCQEgA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEyMDA2NiBTYWx0ZWRfX0tZyO7GProKv
 yQ1/8rxAJaIV+VAB0aUWljz2S44+J+3HbywiJHSE8Iz320YV6afM9bpnlWW8g4QO/o9DzfuVKPh
 nbmvYE6xWXik6xj6uWD7MiHjK7MZHQg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-12_02,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 malwarescore=0 spamscore=0 clxscore=1015
 bulkscore=0 phishscore=0 lowpriorityscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611120066

xdp_return_buff() always releases the fragments and the head with
napi_direct = true, which is only valid when the caller runs in the NAPI
context that owns the page pool. Drivers also need to release an
xdp_buff while tearing down or resetting a queue, where NAPI is not
running and direct recycling must be disabled.

Split the implementation into __xdp_return_buff(), which takes the
napi_direct argument and is exported for drivers, and keep
xdp_return_buff() as an inline wrapper that passes true, preserving the
behavior of the existing callers.

This lets stmmac use the common helper with napi_direct = false on the
teardown paths.

Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
---
 include/net/xdp.h | 7 ++++++-
 net/core/xdp.c    | 9 +++++----
 2 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/include/net/xdp.h b/include/net/xdp.h
index 1ec49f7a9d7a..fc6c350dca31 100644
--- a/include/net/xdp.h
+++ b/include/net/xdp.h
@@ -472,7 +472,12 @@ void __xdp_return(netmem_ref netmem, enum xdp_mem_type mem_type,
 		  bool napi_direct, struct xdp_buff *xdp);
 void xdp_return_frame(struct xdp_frame *xdpf);
 void xdp_return_frame_rx_napi(struct xdp_frame *xdpf);
-void xdp_return_buff(struct xdp_buff *xdp);
+void __xdp_return_buff(struct xdp_buff *xdp, bool napi_direct);
+static inline void xdp_return_buff(struct xdp_buff *xdp)
+{
+	__xdp_return_buff(xdp, true);
+}
+
 void xdp_return_frame_bulk(struct xdp_frame *xdpf,
 			   struct xdp_frame_bulk *bq);
 
diff --git a/net/core/xdp.c b/net/core/xdp.c
index 7c98dbc2a770..bb8e157bf0a7 100644
--- a/net/core/xdp.c
+++ b/net/core/xdp.c
@@ -546,7 +546,7 @@ void xdp_return_frag(netmem_ref netmem, const struct xdp_buff *xdp)
 }
 EXPORT_SYMBOL_GPL(xdp_return_frag);
 
-void xdp_return_buff(struct xdp_buff *xdp)
+void __xdp_return_buff(struct xdp_buff *xdp, bool napi_direct)
 {
 	struct skb_shared_info *sinfo;
 
@@ -556,12 +556,13 @@ void xdp_return_buff(struct xdp_buff *xdp)
 	sinfo = xdp_get_shared_info_from_buff(xdp);
 	for (u32 i = 0; i < sinfo->nr_frags; i++)
 		__xdp_return(skb_frag_netmem(&sinfo->frags[i]),
-			     xdp->rxq->mem.type, true, xdp);
+			     xdp->rxq->mem.type, napi_direct, xdp);
 
 out:
-	__xdp_return(virt_to_netmem(xdp->data), xdp->rxq->mem.type, true, xdp);
+	__xdp_return(virt_to_netmem(xdp->data), xdp->rxq->mem.type,
+		     napi_direct, xdp);
 }
-EXPORT_SYMBOL_GPL(xdp_return_buff);
+EXPORT_SYMBOL_GPL(__xdp_return_buff);
 
 void xdp_attachment_setup(struct xdp_attachment_info *info,
 			  struct netdev_bpf *bpf)

-- 
2.56.0

