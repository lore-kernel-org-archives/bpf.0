Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793108945;
	b=ylXjPsdhoOblHCRbtqeUbHMKMo494sd7wvwCwmyXT/14h7Jdg1iEJSAGoowXLoPESH+8
	 dW6KCN/9ZK7OWXGlwRK9IBIIM0N3oEzKAIee5V1eFZ8LrTytcqO0F2yddBQo5XmMJInMe
	 kGqLy/HE3oW1ugugOA/ws+9ei6UlOVwS4CFR9uTS66ScBiLBLWezJ7ZlmKJWQTmCUwIrH
	 y/1XS5U5peUrLYgGxfX/4/YpoxRVGOh+y06hDKhOkgnS4h7iD5MYwVlJdbO1RDKFE+42w
	 wDS3IRyptHTv3rFN+Me+LkR5/3qvv5+6AVOjn7WP95K/CWbqJYOz3k/VqMUDBYeYQtQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793108945;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=/rk6zsEoSC9vyEa7aELMlRYShi+YOe7ujM2O0/y5nRs=;
	b=JCFXJ/Sk+4bOtsGeMsiJHZG781nrx/0pzaYJXa5LMHjBUL7hQREfz6aaw1expXbGGp4p
	 Z989h3jnfZHocxenYgYdeukKQdBiZP3z5EheZh2Nt5iWJUCodUx2gJnCHJBmO6AhUYp4E
	 6ZlvBoVn+PbItmT34Xc4Vxd/Fs1cDUuJt4L4Rl1mOTTL7vZ8o6iv388Hu8ZkobBeSWDg7
	 gMt51i5wxeUQq7fZ99dvDwjbK7lva1kTrJbMf3kxVcof13XF5bzbOCvF/R2OGgLzcHd6a
	 QIBoxhAw9bunFfal+EWpSkmPucK2P7afDKyUB1aI5TSjLDsSvOl6fPh2FtA2Ct8KRkA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=GJtwWxEG;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b="GDaP/36T";
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B36D606A33C
	for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 13:49:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0B36D606A33C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=GJtwWxEG;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=GDaP/36T
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69RAe3nZ1935891
	for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 13:49:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/rk6zsEoSC9vyEa7aELMlRYShi+YOe7ujM2O0/y5nRs=; b=GJtwWxEG9BWyuIF0
	OZmt83Pz8xiqShipwY/KqIKoUpMQ6HoP5r4/KEsv2rB8R/sUi0OUewC9yz/15ZJn
	JJTZgXolj9EWoGV5YaigdFNXeZeLAtrwZRTujVL8DJ/PDYTE8FCI024Mg0gn4skW
	XbYZEe5yMCqEKgU8ocUSTRlzzDI2veGGk/UJ5hdAVBnDTFdXR2R+grKa5GiN3Eyj
	sTVQXAXiL60KmQMl15YzrzTTqHVryVXUZjMHO4iUp1IX651O3TnjKpWAmqkzHslz
	RIMeQpP4ul6PYFhf8GcTZ8jFq8CsyS5u65piLhA0bLOcL+U4cq9Am5rNeGcMW2T1
	qfTaQA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hjfavu55a-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 13:49:03 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93f32050e72so984378785a.1
        for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 06:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793108943; x=1793713743; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/rk6zsEoSC9vyEa7aELMlRYShi+YOe7ujM2O0/y5nRs=;
        b=GDaP/36TCWjLNuC6WZLLxtLBps1jWxe+7ErRnxmKnXtuU0xjSWH+pCnqsLbz4UHPRO
         mGFzf0IXRNHF7Xvl0g7+ljvRQRuyUnZZf5oNqPuImBCMqu9E0moqByFjPFfsTphHHfpo
         dD1IXcprk/RHbf9qyO2MvET/nG4DBNn2yq2FjK/3qPF4cidwHNC08XVkf9dyEqtPP+5G
         8Rg1EVx7qhN89LFVzWG4ZEn9lSDenIRuyGcH/xzF/nS2rbPzGm2HjpLUBDePW5u3yVQp
         BdUBMLMDnJSGT2tbGLVHB956EsZ4QNNy6KKPaeImCSOzx4vMgUTP84ySt0eq6T1hjZin
         F+Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793108943; x=1793713743;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/rk6zsEoSC9vyEa7aELMlRYShi+YOe7ujM2O0/y5nRs=;
        b=e6eOqVP3Zj/TM4kVLMeU4oJRNHqv2wKmeODXZyiK6RMKoPB19snl865Fxn/a3Ekjz4
         +nM1umvEg74HJ14GFDcF0X8VFyw5BdpZf3yJr3ofvmGqf10+5WXvjg5SSYJsiG7mVBZE
         mO2QSTOdwXXJXGx0T3n9kA9POetXqKVt/DYKxnvapMg8869vo0CsgyBNRQFES5BPj00Z
         T1sWN/zXoGPzgwEhOgpDUsavr6H6wai6u/wkd6DWOQwDfBPQQSOkIjmQCFsvgwrC4YTo
         k6HPCMP6UeMcaNjPtJ6Cgo355NB2OgXQ3ZH69QJP5vKN3ARqL3am4B1OY6Oxt6sXf0ms
         X1xg==
X-Forwarded-Encrypted: i=1; AKwUvBwz0ZNuiZxwPsyuFWhZwYsau2ioH5zr9Qg4v2vP0uXdowR9KWnj9QL2OK1eepeJQtYDGdQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYLoyX8W9f7opqX/H7hdn3e0r2F4lqeeV71StI+KxVFj/TX6Ro5s
	H7bmh04tujPRHVKa5Rz+k7sYjGCIu9Uz2XOIvZaE9G00v9eC0IAKj+Cb9e26iVkqNpp1WLr6IHT
	U6NfD28euqxYQDEe5030knWhcQ9dagEyWBj++AS9RAB6iRyn9sePPaaw=
X-Gm-Gg: AYBFou1jut7kp1biq9N4Kum1D3Dpngk7+UaO3chRjqZqS4TpCS+AnLm7Yvo0dJTiY8t
	X49DFKZhl/2xplrPRu9vTtKOkHnnoTeUmuZ1I11Vq0vbJy1xkUwWOHewXBaxI0kggtV0r6HAanM
	QZ2wHo86bohjmU2p6V7lP4aXi8KUA1JG5g3AFCVByu4ni3kuA/djOoWn6rny0KIZEr1HZUaqhMi
	3oGOtrgowzxLPuUKHdR9ieYekvjO+DVvG0UzsJjNOTlvxw3t72WDA08LosCb9zzsDdy+KTJyKsS
	XOOSUiy55o1rWM9HMp5TVp/bp3O76ENTZQQXQqfk+9JHei/9/bXlpdxT6Aup+zrSWBcxmbKMJS7
	AmtFvAAJbWKI=
X-Received: by 2002:a05:620a:27cd:b0:93e:c12c:fbbf with SMTP id af79cd13be357-940ef96ee50mr1550616685a.76.1793108943012;
        Tue, 27 Oct 2026 06:49:03 -0700 (PDT)
X-Received: by 2002:a05:620a:27cd:b0:93e:c12c:fbbf with SMTP id af79cd13be357-940ef96ee50mr1550612685a.76.1793108942481;
        Tue, 27 Oct 2026 06:49:02 -0700 (PDT)
Received: from localhost ([93.144.6.81])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c46bd4e89cesm464714066b.13.2026.10.27.06.49.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 06:49:01 -0700 (PDT)
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Date: Tue, 27 Oct 2026 14:48:39 +0100
Subject: [PATCH net v2 4/6] net: stmmac: copy XDP metadata in AF_XDP
 zero-copy RX
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
Message-Id: <20261027-stmmac-xdp-fixes-v2-4-10eae8a093a8@oss.qualcomm.com>
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
        bpf@vger.kernel.org
X-Mailer: b4 0.14.3
X-Proofpoint-GUID: SEXUfwYs9PN99aDSn_G9kQ2Q0X4hSvOk
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDA1NCBTYWx0ZWRfXyfY7Ubxv8oIO
 MDJnVjy/ijEl9CooREzltpKKMd16dM+AC7jj7UKcxZaernOLC24UG1Nv30Ff6O6wVtHaYbFm9VO
 tb84e/6kkszm1mQQqa/SMIHknnle+mo=
X-Authority-Analysis: v=2.4 cv=EIeTQFZC c=1 sm=1 tr=0 ts=6ae0abcf cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=7fYLNvKHbgS61GKHX+yayQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=9RzD3mWewD2guqUcLtsA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-ORIG-GUID: SEXUfwYs9PN99aDSn_G9kQ2Q0X4hSvOk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA1NCBTYWx0ZWRfXxtnKREYSU6KR
 36Dun+5vPMYLZw/sUMoy12Y8MzwmK4NUTqQs/fIW1W6Ez/L0wzW7kCePCHZnyCJF4TjrA/ibQ4f
 6I6ZpbHRj6P+MDH3bNnNwSRTQYOlreN8G8c31aw1ZM1PqhivtbuOutTHk18AfwQvKsKoK48YU6l
 rfb0++K/SebovsanQJ4XGd9vC8Nave+4It3EdzCYZA1s7NJuEV1aJNLvd2jn2orr+TvBpoBPvBg
 9OpuJyzQiEXAZGHHvpjrVOYCvlovqsN49wqe/cS3ivFXhw3/pqPLXjN4jCP7YiyokteS9Bdo4zT
 BG5o3rSDhwlKI3l68pkAcDXW4V+hRE3lZD8R1HlX0WiG3YObymKls/6guTeD/WaSkayoe1GAVJ2
 e9aeXxldZHYbXip3pxYnRnTDrrrSexxdUsLDEQb7+C5TUIZv1SLRSZIGmV/nQf9tjwxRHkLxiQf
 pAZUgCRTDAuN2z5LfLA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 suspectscore=0 spamscore=0 phishscore=0
 bulkscore=0 malwarescore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610270054

stmmac_construct_skb_zc() reserves headroom for the XDP metadata and
records the length reported by the XDP program, but only copies the
packet data starting at xdp->data. The bytes in
[xdp->data_meta, xdp->data) are never copied into the new skb, so the
skb advertises metadata that is not there: after eth_type_trans()
anchors mac_header, data_meta points at uninitialized headroom instead
of what the program wrote.

Copy the metadata together with the packet data starting at
xdp->data_meta, leaving skb->data at the start of the frame and the
metadata immediately before it, and record its length. This keeps
data_meta valid for the stack and TC BPF after eth_type_trans() anchors
mac_header.

Fixes: bba2556efad6 ("net: stmmac: Enable RX via AF_XDP zero-copy")
Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 71858af6fd66..d9fc2464a160 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -5519,7 +5519,8 @@ static struct sk_buff *stmmac_construct_skb_zc(struct stmmac_channel *ch,
 		return NULL;
 
 	skb_reserve(skb, xdp->data - xdp->data_hard_start);
-	memcpy(__skb_put(skb, datasize), xdp->data, datasize);
+	__skb_put(skb, datasize);
+	memcpy(skb->data - metasize, xdp->data_meta, datasize + metasize);
 	if (metasize)
 		skb_metadata_set(skb, metasize);
 

-- 
2.56.0

