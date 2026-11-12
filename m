Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794501290;
	b=iLbErKIaXTR6o+Qa1UNHZBD+7/WFUp7aJqUeTTV1mRODQH7zqxtGM8cwPgrMYgxI18LD
	 EKZfR3AOHkWrCXSFHhVbqaDl/i8EIziHAOgN9HhJJDHygFItuwD2O2FZJutIHKKT3Wsfd
	 iBnp8/5VR5VwbR3SVStlUaRNg6XUPAMnUS6D3OJYzPd9WdEyvaW3LbC9SFEGhuUSIQMtf
	 hH/DW+siNw/mf6mCGijKHRojEUmZlYZlwLBK0pHX/n84GQENlGaXN14RWRY1Hgxosc5t4
	 AbaUIcLULciitRnq0dmy2bxGe5YpYyeoMbZVFLmCG6U6UEh9V+CAi1cxkIdwRkCsBTg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794501290;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=wusg38HgCb4IaOp5BRSapHlon+L+ha7WNeunLyBc97o=;
	b=vPBsbkXMN7VniSAJZ45ESbwKNd3q50QI3AC/jSXVGSza4HxzGdz8I39IxUoXmsOWMbPf
	 /LLoQ/OixH3fy6P0fQ3jDnMXXRxqRYxjlax55pnmNj86Fbb9C/knwAnGwdaNeGs8IJ6Jf
	 6nfO62zzetGxtsgW0erChFunu5q0my5C8Ra9XJs8+6hLbTUDHQykLaU7J0UOrVLAHntdR
	 xgfhgrv9HDFrV5/SRojzDaY36YNwI3ZZhvvhm6+HNxaePCVQAwjWwYXO5NC5T93jO15eN
	 nxC5pn72WrJ1e6QY569lotRhK7pF7Ur4PdX6GTF6u4ZjFBEAGAQgUWLDS3W+payH8Lw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=NMOTIcR+;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=O51bu1cv;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8A54606A8B9
	for <bpf@vger.kernel.org>; Thu, 12 Nov 2026 16:34:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E8A54606A8B9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=NMOTIcR+;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=O51bu1cv
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ACFaNtP1593451
	for <bpf@vger.kernel.org>; Thu, 12 Nov 2026 16:34:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	wusg38HgCb4IaOp5BRSapHlon+L+ha7WNeunLyBc97o=; b=NMOTIcR+krVHn61y
	LKpFviS9NKCyKuBdi4dH0rTrbJmDpQtw5A+t44i3oCzYTZwzdBizBZSCozLNZ/Ad
	jRokNnn01vJwvhypnq/AL0Svphb4IPMfx06lfUbobQ6sIH/lUjiMfH9gFzIuQNsL
	7kTUBEDPo2dRHosoRAU5Q8oXZQt1olTF6nbq+WnY2IyCtekO839acQgsr5bnirlF
	lRhLjv5PwZvcLlUdwj/WXrkAY17QkZZ006V+h7WRCCegfRB+I9Clv9CX6iI2wLlY
	cCthBbfgF22SgnwsvTIB2f432HgYeYXPRRNHGhLxKNj9bnehicaOVBikJCJLinxN
	cDoU3w==
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com [209.85.222.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hw0m8kr6h-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Thu, 12 Nov 2026 16:34:48 +0000 (GMT)
Received: by mail-ua1-f71.google.com with SMTP id a1e0cc1a2514c-99be6943b20so44676241.0
        for <bpf@vger.kernel.org>; Thu, 12 Nov 2026 08:34:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794501287; x=1795106087; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wusg38HgCb4IaOp5BRSapHlon+L+ha7WNeunLyBc97o=;
        b=O51bu1cvRcE20SVZ626zDHnPeLuwbqCKacL/b66t2ykRuBEkrYE6oKi8WFbH/NKobX
         yOhJN9ZMF+GcGJhdJJpmLiZIEsQSQg2cQBXOTRWsSZZOrDTC6+yq0jk5Pi+Q86z7zI0B
         ykTAfHYobC/rs2QlKAytkCeubiSmziuB7VflhmqqMOmpLh0JvW4qeSd/tWQzuiEpmLFq
         DLrQWF8s6tF+bwlpf6vTLKAl7JwoS99c2qkKo2YM8VOFd3GIzxg7bU3c7W173SJ/HHmE
         m5XEcH5EIKmBKTzYIndLtBTB/Z/wdTaBlGunOj3dbj+F5nU+uUBP1Thg95b5+nyRLlcj
         9Lzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794501287; x=1795106087;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wusg38HgCb4IaOp5BRSapHlon+L+ha7WNeunLyBc97o=;
        b=hVeJeAyp7pt8E5If5DZe4Y/W5zfxkobVEoSsERCAlGmdR3gDg26Wv+rZFtyAOZL3//
         Px7GePlMNFgwRAAzTWfjq6yjup1B7Rh0QgLTJ1piIJE3eLkKYtJikoLj7Q3t1me3v3IY
         CxHyPMboKFGAsovTpQpc/x67XzKcAVf8iV/mxpJOdsPzgPyVbuIr3I0cA/aU85GpS0It
         4D+HC7On+g+Xwon5DmXg1PPbdZSDaT6lBeo0rZt0xfF7GQGJMyZrc7MNapqr3HeOt9J5
         EGJ1t6jOPHbcv19M4af24edzu7WcvmJI/j5n5aoHyFNeizjLvPwYHPbQP6KyJuQVl7Ou
         PYAQ==
X-Forwarded-Encrypted: i=1; AL+hErH79lWxpIQE+Dw7IdbN5o1vrUEVUKlX95dSQX1oYlTC9vChTYCyATnznkXG89jIvBQHRSo=@vger.kernel.org
X-Gm-Message-State: APuU4Z9Jm0lKBNXHK25QyAp1NArWOWs9H+kZfNfwo34QoH/I1IuKPEOr
	nqe7iyWErRsRlXi9xoxJF+928fLHHOqN2xVW6p36LkE/wU4xYfJM4TaFYUiLAi/d07MsuyCOe5G
	vjsOoE6MytDyN0LG1IZLlyJC4yu9faOl8AHaThmyJHSMU3wxZcDjvhYw=
X-Gm-Gg: AYBFou0k9cB5ktNFfA/5NomIbVw8tPvKB6cG8XlGH0jcHNJMVRCi+pOmuGseheNd62D
	zFkYMr0jYIhJ+xA5SKIZMqHoLNuxHD7L8PPZh3wZEwTyYTJdmXQPje+J/8PTDmR2p1L6YNiSpsP
	JVHYdLB5E3wcJ7qoD0wf+gLPK/nHrbhjYZ7lvqfOj+SRMtJ+BG5uV4W9VPpn9xoBAHMNgtE8g5a
	VAOi3IGdotV7YT/bysYtIFqG6LjzEqFm5wQzmwPV4UEkCPkY3w5wYcwY7STkMhtTRc65NDIGH0o
	1dUt/s/I4oDoz+m5ChiPzm7RrAev3ohJaTrWrAnuZNUT7TQuKNAeosj5Ob9HyEsTQUfbSjDaDNY
	8qglfZmpSTccMshR0DHVWhsXRbmVQ+rLagK9qrUz1bDln29pzEZTHvbuA9XWFmwk=
X-Received: by 2002:a05:6102:6051:b0:7cc:56a:58d3 with SMTP id ada2fe7eead31-7d5061fc3c3mr2720223137.31.1794501286890;
        Thu, 12 Nov 2026 08:34:46 -0800 (PST)
X-Received: by 2002:a05:6102:6051:b0:7cc:56a:58d3 with SMTP id ada2fe7eead31-7d5061fc3c3mr2720208137.31.1794501286355;
        Thu, 12 Nov 2026 08:34:46 -0800 (PST)
Received: from localhost ([93.66.104.131])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c603f4d29sm130165f8f.35.2026.11.12.08.34.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 08:34:45 -0800 (PST)
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Date: Thu, 12 Nov 2026 17:34:11 +0100
Subject: [PATCH net-next v10 2/4] net: xdp: add xdp_buff_shrink_tail()
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
Message-Id: <20261112-stmmac-rx-mb-v10-2-d3d04b65c6bc@oss.qualcomm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEyMDA2NiBTYWx0ZWRfX0cbtomFV5Y4T
 9caaf46sQbRRpWCrVTByN203kt7GdZ+mAelWHzdJ7OPDSgjJ0/nQ0FQw4ECPZL9kcj3TWdzP59u
 EfL+GPFzcIUpJWtFCkiLzbCCkNLmb9Y=
X-Proofpoint-GUID: UBwjX5fJdwP_cj_S_eihUlwEZmFQCfT1
X-Proofpoint-ORIG-GUID: UBwjX5fJdwP_cj_S_eihUlwEZmFQCfT1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEyMDA2NiBTYWx0ZWRfX1OTl1+0/koYz
 u/bERgam64Q4NZAJmaWDwLbJcQ1vAQmurURKktMsZ/ayT9QJ6VTosn0z6A9PxuzxLVh4kVs3Xo+
 kS1tSd0BIbnjNXCW/mtUqHgSG95Q69dzYmJ2oIScszWgctvY6u6HgHJN1zh5h8ZoB24C6wrSiX+
 WzZP4+yU4tDn8UmLr58a9zEceCD6PGbwx/M31SWHNgshnsyjzeq04eDF2x54+pfHP0jCprN3VNM
 jln1CNtPHYEGv9nPo+Ctfo37QzLoGyKW1IFrX+a0Ryi6hOWKrptvXaK4Lg/WngxymVf4P1vmrUK
 a/DZ47kfa2Y2ETW3arKjPlmTj7IgRHYhHvsyXVo2/7t7cBzJbnswVbPIdTB2EkAQOuAtvdI1MaS
 AXCYyI6JaxJ0TnquBT5mt06j57D9NpvGmFgvbCQn3MA3b730+mTU+T19fOpSpprqcrWsaL2IQtP
 M0tdVOSSwT3M3hjJWlw==
X-Authority-Analysis: v=2.4 cv=Q9dHcI2a c=1 sm=1 tr=0 ts=6af5eaa8 cx=c_pps
 a=KB4UBwrhAZV1kjiGHFQexw==:117 a=cAAIdyqZgEis9HJxay2Blw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=7V0IxQAAFVITDsu0YkUA:9 a=QEXdDO2ut3YA:10
 a=o1xkdb1NAhiiM49bd1HK:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-12_02,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 impostorscore=0 adultscore=0 bulkscore=0
 suspectscore=0 priorityscore=1501 spamscore=0 clxscore=1015
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611120066

Move the XDP tail-shrink logic out of bpf_xdp_adjust_tail() into
net/core/xdp.c so it can be shared with drivers. The frag helpers
(bpf_xdp_shrink_data_zc(), bpf_xdp_shrink_data() and
bpf_xdp_frags_shrink_tail()) move along with it; the latter two are
renamed to xdp_buff_shrink_data() and xdp_frags_shrink_tail().

Add xdp_buff_shrink_tail(), which handles the linear case too and is
exported with EXPORT_SYMBOL_GPL() for driver use. Unlike
bpf_xdp_adjust_tail(), it takes the number of bytes to remove as a
positive value; bpf_xdp_adjust_tail() keeps its signed offset ABI and
passes -offset for the shrink case. Negative offsets are rejected.

bpf_xdp_pull_data() keeps using the frag helper under its new name.
Behavior for valid offsets is unchanged.

This lets stmmac use the common helper to strip the Ethernet FCS from
the xdp_buff it accumulates for a multi-descriptor frame.

Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
---
 include/net/xdp.h |  3 ++
 net/core/filter.c | 83 +++-----------------------------------------------
 net/core/xdp.c    | 91 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 98 insertions(+), 79 deletions(-)

diff --git a/include/net/xdp.h b/include/net/xdp.h
index 3a25307e1d67..1ec49f7a9d7a 100644
--- a/include/net/xdp.h
+++ b/include/net/xdp.h
@@ -403,6 +403,9 @@ struct sk_buff *__xdp_build_skb_from_frame(struct xdp_frame *xdpf,
 struct sk_buff *xdp_build_skb_from_frame(struct xdp_frame *xdpf,
 					 struct net_device *dev);
 struct xdp_frame *xdpf_clone(struct xdp_frame *xdpf);
+int xdp_buff_shrink_tail(struct xdp_buff *xdp, int offset);
+bool xdp_buff_shrink_data(struct xdp_buff *xdp, skb_frag_t *frag,
+			  int shrink, bool tail);
 
 static inline
 void xdp_convert_frame_to_buff(const struct xdp_frame *frame,
diff --git a/net/core/filter.c b/net/core/filter.c
index 9b8d5191c4ba..5ea45dfce7a2 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -4438,96 +4438,21 @@ static int bpf_xdp_frags_increase_tail(struct xdp_buff *xdp, int offset)
 	return 0;
 }
 
-static struct xdp_buff *bpf_xdp_shrink_data_zc(struct xdp_buff *xdp, int shrink,
-					       bool tail, bool release)
-{
-	struct xdp_buff *zc_frag = tail ? xsk_buff_get_tail(xdp) :
-					  xsk_buff_get_head(xdp);
-
-	if (release) {
-		xsk_buff_del_frag(zc_frag);
-	} else {
-		if (tail)
-			zc_frag->data_end -= shrink;
-		else
-			zc_frag->data += shrink;
-	}
-
-	return zc_frag;
-}
-
-static bool bpf_xdp_shrink_data(struct xdp_buff *xdp, skb_frag_t *frag,
-				int shrink, bool tail)
-{
-	enum xdp_mem_type mem_type = xdp->rxq->mem.type;
-	bool release = skb_frag_size(frag) == shrink;
-	netmem_ref netmem = skb_frag_netmem(frag);
-	struct xdp_buff *zc_frag = NULL;
-
-	if (mem_type == MEM_TYPE_XSK_BUFF_POOL) {
-		netmem = 0;
-		zc_frag = bpf_xdp_shrink_data_zc(xdp, shrink, tail, release);
-	}
-
-	if (release) {
-		__xdp_return(netmem, mem_type, false, zc_frag);
-	} else {
-		if (!tail)
-			skb_frag_off_add(frag, shrink);
-		skb_frag_size_sub(frag, shrink);
-	}
-
-	return release;
-}
-
-static int bpf_xdp_frags_shrink_tail(struct xdp_buff *xdp, int offset)
-{
-	struct skb_shared_info *sinfo = xdp_get_shared_info_from_buff(xdp);
-	int i, n_frags_free = 0, len_free = 0;
-
-	if (unlikely(offset > (int)xdp_get_buff_len(xdp) - ETH_HLEN))
-		return -EINVAL;
-
-	for (i = sinfo->nr_frags - 1; i >= 0 && offset > 0; i--) {
-		skb_frag_t *frag = &sinfo->frags[i];
-		int shrink = min_t(int, offset, skb_frag_size(frag));
-
-		len_free += shrink;
-		offset -= shrink;
-		if (bpf_xdp_shrink_data(xdp, frag, shrink, true))
-			n_frags_free++;
-	}
-	sinfo->nr_frags -= n_frags_free;
-	sinfo->xdp_frags_size -= len_free;
-
-	if (unlikely(!sinfo->nr_frags)) {
-		xdp_buff_clear_frags_flag(xdp);
-		xdp_buff_clear_frag_pfmemalloc(xdp);
-		xdp->data_end -= offset;
-	}
-
-	return 0;
-}
-
 BPF_CALL_2(bpf_xdp_adjust_tail, struct xdp_buff *, xdp, int, offset)
 {
 	void *data_hard_end = xdp_data_hard_end(xdp); /* use xdp->frame_sz */
 	void *data_end = xdp->data_end + offset;
 
-	if (unlikely(xdp_buff_has_frags(xdp))) { /* non-linear xdp buff */
-		if (offset < 0)
-			return bpf_xdp_frags_shrink_tail(xdp, -offset);
+	if (offset < 0)
+		return xdp_buff_shrink_tail(xdp, -offset);
 
+	if (unlikely(xdp_buff_has_frags(xdp))) /* non-linear xdp buff */
 		return bpf_xdp_frags_increase_tail(xdp, offset);
-	}
 
 	/* Notice that xdp_data_hard_end have reserved some tailroom */
 	if (unlikely(data_end > data_hard_end))
 		return -EINVAL;
 
-	if (unlikely(data_end < xdp->data + ETH_HLEN))
-		return -EINVAL;
-
 	/* Clear memory area on grow, can contain uninit kernel memory */
 	if (offset > 0)
 		memset(xdp->data_end, 0, offset);
@@ -12839,7 +12764,7 @@ __bpf_kfunc int bpf_xdp_pull_data(struct xdp_md *x, u32 len)
 		xdp->data_end += shrink;
 		sinfo->xdp_frags_size -= shrink;
 		delta -= shrink;
-		if (bpf_xdp_shrink_data(xdp, frag, shrink, false))
+		if (xdp_buff_shrink_data(xdp, frag, shrink, false))
 			n_frags_free++;
 	}
 
diff --git a/net/core/xdp.c b/net/core/xdp.c
index 470bf90d93ef..7c98dbc2a770 100644
--- a/net/core/xdp.c
+++ b/net/core/xdp.c
@@ -672,6 +672,97 @@ struct sk_buff *__xdp_build_skb_from_buff(const struct xdp_buff *xdp)
 }
 EXPORT_SYMBOL_GPL(__xdp_build_skb_from_buff);
 
+static struct xdp_buff *xdp_buff_shrink_data_zc(struct xdp_buff *xdp,
+						int shrink, bool tail,
+						bool release)
+{
+	struct xdp_buff *zc_frag = tail ? xsk_buff_get_tail(xdp) :
+					  xsk_buff_get_head(xdp);
+
+	if (release) {
+		xsk_buff_del_frag(zc_frag);
+	} else {
+		if (tail)
+			zc_frag->data_end -= shrink;
+		else
+			zc_frag->data += shrink;
+	}
+
+	return zc_frag;
+}
+
+bool xdp_buff_shrink_data(struct xdp_buff *xdp, skb_frag_t *frag,
+			  int shrink, bool tail)
+{
+	enum xdp_mem_type mem_type = xdp->rxq->mem.type;
+	bool release = skb_frag_size(frag) == shrink;
+	netmem_ref netmem = skb_frag_netmem(frag);
+	struct xdp_buff *zc_frag = NULL;
+
+	if (mem_type == MEM_TYPE_XSK_BUFF_POOL) {
+		netmem = 0;
+		zc_frag = xdp_buff_shrink_data_zc(xdp, shrink, tail, release);
+	}
+
+	if (release) {
+		__xdp_return(netmem, mem_type, false, zc_frag);
+	} else {
+		if (!tail)
+			skb_frag_off_add(frag, shrink);
+		skb_frag_size_sub(frag, shrink);
+	}
+
+	return release;
+}
+
+static int xdp_frags_shrink_tail(struct xdp_buff *xdp, int offset)
+{
+	struct skb_shared_info *sinfo = xdp_get_shared_info_from_buff(xdp);
+	int i, n_frags_free = 0, len_free = 0;
+
+	if (unlikely(offset > (int)xdp_get_buff_len(xdp) - ETH_HLEN))
+		return -EINVAL;
+
+	for (i = sinfo->nr_frags - 1; i >= 0 && offset > 0; i--) {
+		skb_frag_t *frag = &sinfo->frags[i];
+		int shrink = min_t(int, offset, skb_frag_size(frag));
+
+		len_free += shrink;
+		offset -= shrink;
+		if (xdp_buff_shrink_data(xdp, frag, shrink, true))
+			n_frags_free++;
+	}
+	sinfo->nr_frags -= n_frags_free;
+	sinfo->xdp_frags_size -= len_free;
+
+	if (unlikely(!sinfo->nr_frags)) {
+		xdp_buff_clear_frags_flag(xdp);
+		xdp_buff_clear_frag_pfmemalloc(xdp);
+		xdp->data_end -= offset;
+	}
+
+	return 0;
+}
+
+int xdp_buff_shrink_tail(struct xdp_buff *xdp, int offset)
+{
+	void *data_end = xdp->data_end - offset;
+
+	if (unlikely(offset < 0))
+		return -EINVAL;
+
+	if (unlikely(xdp_buff_has_frags(xdp))) /* non-linear xdp buff */
+		return xdp_frags_shrink_tail(xdp, offset);
+
+	if (unlikely(data_end < xdp->data + ETH_HLEN))
+		return -EINVAL;
+
+	xdp->data_end = data_end;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(xdp_buff_shrink_tail);
+
 /**
  * xdp_copy_frags_from_zc - copy frags from XSk buff to skb
  * @skb: skb to copy frags to

-- 
2.56.0

