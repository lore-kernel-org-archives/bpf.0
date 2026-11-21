Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795282119;
	b=SLx1udoBV+flhFdoVJtgL00uI7zPwtp87XurIkSQ9kDXxKuMIxAfGuLSWQSDAdkTtBZV
	 xBFwsxPTrVtI1jnFdB2O6MdhuJEKd577lePdfAICEuxDROdyx/oiZYUL6TVVxapjRfev2
	 PGmL2eGT9GMc0g2Ry+Bt6sDYYMzU+7U1tApskZZ0B5J4ZM0vmhy5U14Het/Hy0N9MedUN
	 okR6V2OgnW1aK2NVV4eXgSEdfk8/7W9pD6vCNeO5MVDZezd4J6sEoktDXLtEy3K+UhhJy
	 VSDRA6A3dxlsWF/CgShWXborE6mGL7PYdaYrxh0E98TCbFIvMjzCgl4+UBp0jery/rg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795282119;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=VSSSORsiisY1CsQn0K2p7M1sRt5FkQmSwTkw4vbiEU4=;
	b=p7YtFhtpewTwLWvtcZVmFZdnpCCdolnB4i8Tv8knzpLBYiwGALWMhsZPXWLRa2oMnu0b
	 0I2FzCtHFQITf9CFzXOnPQ3T32PBCCADlLjjhDNJz6OZWJjGqykHdilA0eMu4wYWPuVEI
	 Q1B2OS/fZxP3in7iWLgHjT6mBkVYEyXlmCwWCIKg1VQnVb5+eWB9Y1VgGxouvJIOOVtcK
	 vgbcW13/Bk5slmDB8WON3s8fsCEv6UArkQBgosv+QlEUwD6x6SsR69N0BRfukAtuP9lBF
	 8A0VfrNWOUQanmzulN2/33G9QNVL9rt5RpqrvgNXNkhpLurafpNzl7xHWV6aAZDlyGA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=btv88EO4;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=hvNpOUWj;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE5AB606A32C
	for <bpf@vger.kernel.org>; Sat, 21 Nov 2026 17:28:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EE5AB606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=btv88EO4;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=hvNpOUWj
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ALFa6WI977833
	for <bpf@vger.kernel.org>; Sat, 21 Nov 2026 17:28:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	VSSSORsiisY1CsQn0K2p7M1sRt5FkQmSwTkw4vbiEU4=; b=btv88EO4gLrE/wpV
	APU4YEKHiGrjzbTl3s7A9Xdg4MR92ZdUmE8JgJZ/pIIxZoHF6+zgW17giNC2zrIC
	oZXFUeB9DYA8dyMw3OinB27J5b9ng316zd1bx8EP9uFVCkyaguYb+WcdnSLf5IlP
	l8IwZRRUy1CcQl7G9yYOUdPeEvbLmK3tE1OXqatFm4XqdvtioJa0+qRHDXcV7vl5
	eKwryv7vxbpNrfXXOCkxF/BNQnV65wZQ5nO6JesplMl3D/2wT4k9DkDSRTTMbbNr
	X55RzipZmnoB4HFurSTpBhyDGMn79JqYpiSoB/bcvO7pTpMHbW8JVy8LEw5jzTMX
	hxRkCw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j33cu1ndu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Sat, 21 Nov 2026 17:28:37 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93f2005ce21so331545085a.3
        for <bpf@vger.kernel.org>; Sat, 21 Nov 2026 09:28:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795282117; x=1795886917; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VSSSORsiisY1CsQn0K2p7M1sRt5FkQmSwTkw4vbiEU4=;
        b=hvNpOUWj2mOLQgeVjCGfb3oWAQh/+/DyJ7V8rIhRDHu90XLyze1fZKa3GvCIHw061o
         VQNCkVE2TvN7bfDibklADLl+F4m9gmIro4eqJLOXKM/Zu4Cggg0eqyFxw7ecVoC4gPes
         s/ojNSzCfjerEw1ggNZtxgtQDbGl7ojzVn4cXnZGRHVSQ1ZA7zLbXyHabqWElzkfKvHU
         hZ6EqxYx+/s9fkAwOv5ACTaLRDnmc0SqzPNQGLH5N2+zzxSxLow7S5DOc3WvFNGhjLvl
         Zt/I4zftLAGiQfF/Lhq1b7c2+xHyMFyaf8OvcWFo9zseDY2nj97VfFvn1cGCLAxfu4U9
         I6XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795282117; x=1795886917;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VSSSORsiisY1CsQn0K2p7M1sRt5FkQmSwTkw4vbiEU4=;
        b=sz/znMH4y0e1b8coF3D0QV5P0uDlNB5GL3KvCg2eGfc6vn81m/Nfk1WQX7agC3r7pm
         a8t9oV5PZ2uR5TTPc8LVxTNgrATkeIjQdp/Zo/251JpMGqJCpKZibAYgz1GZo9MxpVaH
         Q4a5A3/v/jZQoLqZmLP8Q6cL+Wjn9y8Z7a5u0IEEH32t++uNuajsFerXqxT4Z4wLnW3q
         DHwKi18c4A1Fw4fYaxRc+EUq4GE8NDeAAI01XrgmxSB2Rnj7V6GpNqXyNSGql5Vxk6XE
         OITtECgfaa4Kvo+Kr6YxL4fDahJwdCmrXqwpUbKgO7gXA1pZ2cES0FAzAdpfOh8818IK
         PZhw==
X-Forwarded-Encrypted: i=1; AL+hErGo6cAFgWf2bxQCF6ipfEuMId1e2reH4kBZAsFoEYH+yrXvwXd41UqHf5QwhzmbI4LPJTk=@vger.kernel.org
X-Gm-Message-State: APuU4Z/UryaBtJJvFzOfzop3p9A7erBUrko5RRjX8aAa74TU+Mx/uDyJ
	LuYIYF1cQtnSlNInmNgOPkSlAn6oKsRKXrybITe6lnolW+XuNLn5hlwoKHqnR5Fn2TtdtBNJvk1
	gYh6BEmNXoHM0QSEdwV8sSDWAMxsqlahOB48PNNjWulk4ZwFuddm9Vz4=
X-Gm-Gg: AZFdTZdVp8N+M1A8JFeax1qxA/1Vfo4dpF/Sa0j9QeqGMiNJFn+LCz1OjaBroFIIZnn
	X8qIWQlSpwYTDHQb9GGXMVjoEmsfcwTvklrb2Xhiufu4t4BcXHw98FwSlG40v+DMga0BWPV1tBG
	oNjZ67sJojW7bZzykG5pcFWr/s99rqAfc8SgRNBSBjYxZc49FNtoFLx6rKERg09k18QUl2RqVee
	NcNjO0gEVRm0TYM0fb9jhOZ98rcvNCq9Kg/pw8ChZvsbA6CEGBx4lYZlSHWGoDSmptlRvSvBkeV
	KWSvjTO3OTn/PK/90Sk4UEOntxj2XvQ5e6K7d7Dgxfri4XTeadJ/HHjyYgus+FF8bxgQEn9P2nI
	HK2ovbZMAeNsph/jSzpOHZwlTVMjAGsrWjcIJSrpH8lPo069h3KboxbvALGa3y2CG3WsM9BGffR
	TXyBKl68A/TPrM75VwuWhK1hKULIc=
X-Received: by 2002:a05:620a:6508:b0:949:6e1b:7cc6 with SMTP id af79cd13be357-949ba690a5fmr1084229985a.0.1795282116863;
        Sat, 21 Nov 2026 09:28:36 -0800 (PST)
X-Received: by 2002:a05:620a:6508:b0:949:6e1b:7cc6 with SMTP id af79cd13be357-949ba690a5fmr1084226785a.0.1795282116313;
        Sat, 21 Nov 2026 09:28:36 -0800 (PST)
Received: from localhost (net-188-152-73-83.cust.dsl.teletu.it. [188.152.73.83])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6c248b75sm12685687f8f.54.2026.11.21.09.28.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 09:28:34 -0800 (PST)
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Date: Sat, 21 Nov 2026 18:28:13 +0100
Subject: [PATCH net-next v12 2/4] net: xdp: add xdp_buff_shrink_tail()
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
Message-Id: <20261121-stmmac-rx-mb-v12-2-3ae2f3bce174@oss.qualcomm.com>
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
X-Proofpoint-GUID: 2UgGrPoTXGkiCdzTRTfwuzJZXinuHpAm
X-Proofpoint-ORIG-GUID: 2UgGrPoTXGkiCdzTRTfwuzJZXinuHpAm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIxMDA2OSBTYWx0ZWRfXz6pTkGhRUVxh
 F5hE3PdEsK2Ix3/AIEgcp5tubm5qWPO+QnMGvUB1cGQ1fXVhpPUVBonqZCmLQeTUYzqVZPUzjkK
 3GUe8bsUmkl+bGF0cGDVdZqD0TodVckfvLUmEt5JRqvfoHbJ4l01EzdjlJsJVHZ5mPXjOLvXnNm
 PE35dGakbfxxjANtj9PJqFPUL242WpV2N0fmEiz7CcPwOoIjsCwD7L1yFO2UfAZNOI8DobFLIB4
 n3ysBQolD36T61BwJZZZIiSqDjP0+8gBV0eUUgHKkvdW21jasCGdJmh7rXSwBOmdZy0sXI6QCVy
 Kr6iUd16tZTcCL/gTtUdoNL1PVptYQ/Aw1xpQ7IYsRH8PM2kZeQqWid94LjfcNEPPw0/khdXS7Z
 uba/ZSZztuAiNTsHt37nM6bjr2dYgK3GWY0VjcQjzcvjF+YSDPhFEqUjOEIZREtBAK2H/NJVOSl
 XNkevjRb8Og7FjYWubA==
X-Authority-Analysis: v=2.4 cv=MM71C8Zl c=1 sm=1 tr=0 ts=6b01d4c5 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=mlS0om9xteqVCAF/aDpb2g==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=7V0IxQAAFVITDsu0YkUA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIxMDA2OSBTYWx0ZWRfX4Rq+SeHSLd86
 3qsLK06ZqlU79zPPX63VdpIMxrtKaLUwIhzFWx1Fc4/SxXuT7mP0YcPoDBQ+5BMX7hBJ0FBC6rX
 XVq2uCbiEYL7WS07guQUtd3n8ZzJmbk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-21_04,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 priorityscore=1501 phishscore=0 spamscore=0
 bulkscore=0 impostorscore=0 suspectscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611210069

Move the XDP tail-shrink logic out of bpf_xdp_adjust_tail() into
net/core/xdp.c so it can be shared with drivers. The frag helpers
(bpf_xdp_shrink_data_zc(), bpf_xdp_shrink_data() and
bpf_xdp_frags_shrink_tail()) move along with it and are renamed to
xdp_buff_shrink_data_zc(), xdp_buff_shrink_data() and
xdp_frags_shrink_tail().

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
 net/core/filter.c | 80 +++----------------------------------------------
 net/core/xdp.c    | 89 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 96 insertions(+), 76 deletions(-)

diff --git a/include/net/xdp.h b/include/net/xdp.h
index 054748b37d7d..3400775d179b 100644
--- a/include/net/xdp.h
+++ b/include/net/xdp.h
@@ -415,6 +415,9 @@ struct sk_buff *__xdp_build_skb_from_frame(struct xdp_frame *xdpf,
 struct sk_buff *xdp_build_skb_from_frame(struct xdp_frame *xdpf,
 					 struct net_device *dev);
 struct xdp_frame *xdpf_clone(struct xdp_frame *xdpf);
+int xdp_buff_shrink_tail(struct xdp_buff *xdp, int offset);
+bool xdp_buff_shrink_data(struct xdp_buff *xdp, skb_frag_t *frag,
+			  int shrink, bool tail);
 
 static inline
 void xdp_convert_frame_to_buff(const struct xdp_frame *frame,
diff --git a/net/core/filter.c b/net/core/filter.c
index f42ecfb5841f..cdbb54a10b0b 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -4438,88 +4438,16 @@ static int bpf_xdp_frags_increase_tail(struct xdp_buff *xdp, int offset)
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
@@ -12840,7 +12768,7 @@ __bpf_kfunc int bpf_xdp_pull_data(struct xdp_md *x, u32 len)
 		xdp->data_end += shrink;
 		sinfo->xdp_frags_size -= shrink;
 		delta -= shrink;
-		if (bpf_xdp_shrink_data(xdp, frag, shrink, false))
+		if (xdp_buff_shrink_data(xdp, frag, shrink, false))
 			n_frags_free++;
 	}
 
diff --git a/net/core/xdp.c b/net/core/xdp.c
index 0db2f68afc5c..acad82982d77 100644
--- a/net/core/xdp.c
+++ b/net/core/xdp.c
@@ -676,6 +676,95 @@ struct sk_buff *__xdp_build_skb_from_buff(const struct xdp_buff *xdp)
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
+	if (unlikely(offset < 0))
+		return -EINVAL;
+
+	if (unlikely(xdp_buff_has_frags(xdp))) /* non-linear xdp buff */
+		return xdp_frags_shrink_tail(xdp, offset);
+
+	if (unlikely(offset > xdp->data_end - xdp->data - ETH_HLEN))
+		return -EINVAL;
+
+	xdp->data_end = xdp->data_end - offset;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(xdp_buff_shrink_tail);
+
 /**
  * xdp_copy_frags_from_zc - copy frags from XSk buff to skb
  * @skb: skb to copy frags to

-- 
2.56.1

