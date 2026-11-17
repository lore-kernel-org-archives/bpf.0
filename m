Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794920343;
	b=RH9QKaBRinoWikbbheY8Qq63C3MvsynaaLNM1NpIxFj2xxlFt+YzeIfsUAn6fG6yE61Z
	 gyPcpRN92KSulLRAVh1/q7pE58qD1om3PVyRb9wF2/bgqm13jldz+fKRcICzRo1ngalOZ
	 FX9Tf61rKEjPLls7sqgVOvCiSwPdxuRXP6rycxrFq44MDlzwgqBQmbLRInJHz77xs8CkO
	 LitqVscB1er6VaU+rULmBrZuoHEe6HFxX4XPVQwe9dNU4CjX+G9VKx80PY2mMBH+TkHwv
	 PIhcHJo4lwjyHHdAOnGzGXeqBHoDp6gAzBvJOpypdODRnuYC4ff5EGQs0wQCi812j5Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794920343;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=s/2ub0vL3CaIDBF+BZvv9xMGDewjeSC4WNdbIVGz2Qk=;
	b=V6VSLc+wlcBnZAmOEtlfKZ2qeIABWAMY7BnK8N0Y/Xmf9FxZPiOT1f4AE9w+Te54IhJL
	 J0kC6SfnHwJ3s1QaEVJ86CGxOunlIGrjvrKP3XxwTfRUYBHCoewRfXOQAMBAYo2Fp9YRA
	 11jYtr4AoaFtTtryc/Bz3FK6f9IRxYrAgzxWne4bNvtSCdH/3E8pDgevVe9Em059LfR48
	 V43ZJnps9uHBql0wRkr2wZ+Z9iVHCUkih2+IUZEik9d/0J61hZeCfNjZyUMY3wvPiyDMe
	 yG0YW52XVC2R1SBCy7db20ScYmTW0PO0e+Kxx3L6w80EUvQB1ok7jRw9oe/bTrVMlrQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=erLzjBQS;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=kcjRH1tF;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30B33606A33F
	for <bpf@vger.kernel.org>; Tue, 17 Nov 2026 12:59:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 30B33606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=erLzjBQS;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=kcjRH1tF
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AHC3wer2096581
	for <bpf@vger.kernel.org>; Tue, 17 Nov 2026 12:59:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	s/2ub0vL3CaIDBF+BZvv9xMGDewjeSC4WNdbIVGz2Qk=; b=erLzjBQSTtFHGQmt
	0smMLSZgebGlfltudacnsNitWoc7RXJVmij2ba1QWpLNBOxdkmHSQnHltnA1wOth
	aikZGjDLg2jElOF4GMUjP78Q+Qshe4jKQM3TObScq3pmShFxbX7MMw2Sr4Co7wRs
	LwZX/2VLc4Sz5Z6vabUSLQ7K3CfWd4oF3Gya+t6zSY1XlM7JWd7XNz2i5hbAvW6c
	GTXBdhlnGcFjea9hPX/Xny/Nu999SVFCbh4uJzvOj/iR+7Y51T5T2KvzoaZ88fZa
	LvxIXYhpkMbAnOq+0HjoXEFHbOAdQOmaMl99h519x01vUSS6a7nSpw6mC1metISU
	Pp/w9g==
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com [209.85.222.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j0c7h2m8h-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Tue, 17 Nov 2026 12:59:01 +0000 (GMT)
Received: by mail-ua1-f69.google.com with SMTP id a1e0cc1a2514c-99e0ee0db35so2126898241.2
        for <bpf@vger.kernel.org>; Tue, 17 Nov 2026 04:59:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794920340; x=1795525140; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=s/2ub0vL3CaIDBF+BZvv9xMGDewjeSC4WNdbIVGz2Qk=;
        b=kcjRH1tFfIku/wDI+VnQVkXlmA5MGxNknPXxQJW8B8sJ0xJn4oIL2Z/n4feAgFa+iV
         6gM7ifYG+NIUiNegJ6A4Py1EPvgC7PWTXxrBSrNtNSScrJP0OkGjbB4KzZRITmwVbtOb
         55IywC30qDQufIihVQiZ2gpOP7hsYOhuMlc9LdOIM5NGNqigP8/wK7NrCuYG+99ptcKO
         AL8SrGcZioFcJxKYDWm/zwwW69R2wSMJHo5X8qDE1ORQO9oKe6WB6vRYGsGLdBBWL4ST
         0gNXpt+HECd/oEnWcqybKAlMzkPHuLkxEwfenZ+Q5Do68bjjFlgJNvPjwY9IuNMW3gT/
         dXmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794920340; x=1795525140;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=s/2ub0vL3CaIDBF+BZvv9xMGDewjeSC4WNdbIVGz2Qk=;
        b=A1/xVWBnT/YB/6qYs5C0YmpBnPpg8FO84iweBskJscrrecqNw5QfASjamdMOKzBlnN
         ZH0e2TH1cktZVEdfa0tF3fP4nszXa2hqVhOeQdY1brFAMNZDd9fG0FSdbYUj3a6p9GoA
         0HXoUph+ovGNIVKyQ0fiYsKVujPny5MCeeIiKCncWU6BwXcJ6fatXRWmAKGZ4HKW4S/+
         TP89WcZa7PXYYVFoRSC8BtoFh7/NSM0ySAuvbjeEn4OFYhYBik1HXsdJwY5Ag5nYSp+7
         WDVzmBMGkjl9INMfVKUcdkocn9B0o+Pw5nueauJjyZ/BWqPIEeOOO5fnB8Iq1vp+AEic
         tpJg==
X-Forwarded-Encrypted: i=1; AL+hErFeI9YW+IaYODA+7CfvKFNQLNaAo/Ym9WwTqW87AlTF+NsvWrPpjKsrSde/VueIg6kCgVI=@vger.kernel.org
X-Gm-Message-State: APuU4Z8aHpl+63kSJFE0hnlSoQX4qnuyeIwXjLmi1Hbby0MRzK0/tFD5
	mLtc0vhCJcbMiGnHoryA+zxNd4gPnquCMNF1XPWwiOmRgZS4TTbjYMnBQWQQePLkr/dgczUmYzq
	i40Prk2P5/TsCbi+e2hP997JLv23vdBS0JUgA2DVNRNBu9Yb3yb9v308=
X-Gm-Gg: AYBFou3RzwD5tZvBA3XA8YIM+VeHMUN7j+pYwMKw7WNdfeCS9ttXll+aZGexLJ8y/tj
	YUAXax9jiAqSwZ/juG5JDCluhoXGbQ/Q2tVuf+C1YWy5QwBfeoD/Bv9KGnEqGjlle/pAfACCzty
	IjJV6p20lTFzl+dp4tzH3jpllg8tgz9lfGm421ngaWvHi6jp/nlOeHDhw4XMmzYuO+vlJWggsuk
	DIypE3MtsnJyCSPY39d/pHfO9xGnFzEaY4HHqRpQZUyKWsrUOXaFdA7SMxxbXsV5RJMmXmBFn89
	2p5qBQNaPTcO4Iwoh/TPlL0wvEFc8cNhb+19RouWN8zQyQvY2L2/MytzSZvL7z7jAc7q/Oo1rN/
	YG4TKnE8alRY1F5LaitjS/iKSe3GsaAkygb8t+XxSbaspKCKhXLDs+kE4GWPJVYU=
X-Received: by 2002:a05:6102:548c:b0:7ce:6289:314 with SMTP id ada2fe7eead31-7d64d72b1demr5233249137.14.1794920340270;
        Tue, 17 Nov 2026 04:59:00 -0800 (PST)
X-Received: by 2002:a05:6102:548c:b0:7ce:6289:314 with SMTP id ada2fe7eead31-7d64d72b1demr5233222137.14.1794920339653;
        Tue, 17 Nov 2026 04:58:59 -0800 (PST)
Received: from localhost ([188.152.73.83])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb7838c912sm60545435e9.4.2026.11.17.04.58.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 04:58:58 -0800 (PST)
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Date: Tue, 17 Nov 2026 13:58:29 +0100
Subject: [PATCH net-next v11 3/4] net: xdp: add __xdp_return_buff() helper
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
Message-Id: <20261117-stmmac-rx-mb-v11-3-9fa5c34ef245@oss.qualcomm.com>
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
X-Proofpoint-GUID: fwxa_SmY76M_O_2176nuu9-AfrzRNZ3J
X-Proofpoint-ORIG-GUID: fwxa_SmY76M_O_2176nuu9-AfrzRNZ3J
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE3MDA1MSBTYWx0ZWRfX1RuxZ448OAkR
 OL3siQUB43KoITt1DGGjQpOAhYgJaA+MS2pGmfWPQoS2OMYKHCwB8BdUfIqcwgOs6vmL0e07Aqw
 WymeNHm6E/4LYU6mIaqSqLTrXqW/Xm3mVYSlEJgNUWun2FGQwrQ44Ul4i4Be00RBm9qBGvgaZZ+
 g6gZBrcyY92y3lHEy9IFwhw431xRBZLiRuYH/UCtw+ooDyhqB30tNhOifeTQuYhifOf5qJAEaeu
 hiDuyRSGpkO6piaCRu/9vQlvSDfEyqVdurW2B5vF0ksDwzYwKwkQa8wzJ4ImoTfNqzjSoR9KbbO
 vTZg/xeUcXeBdSyRPtSuRpIQV/EfFQAFUdj0z6DOeRKzGjVywnf8Z9+KNnaOJGzHnVSY45Sm6yb
 IwQEoEEkiQ+HbqzIpNL//jJWcw69UYOCzzCCKNPrG7PNUBzItB/GbHPE+obnOQDMK1lZP5EagCl
 W+9+U/nDjJ0xjtailSA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE3MDA1MSBTYWx0ZWRfX4wuQjKGu1OEN
 7A7ggkYG4xhzQa3bxs0VLeQjLCJ1Teqenr/RbImMKNOJHVZDwJZkhim6YQ7tZBgeZaX+0LFlVdB
 I/7s02aP6PD/5yy10Uz6siBr2rQala4=
X-Authority-Analysis: v=2.4 cv=bobZl0ai c=1 sm=1 tr=0 ts=6afc4f95 cx=c_pps
 a=UbhLPJ621ZpgOD2l3yZY1w==:117 a=mlS0om9xteqVCAF/aDpb2g==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=EPvaxb3vtNQ3FCvCQEgA:9 a=QEXdDO2ut3YA:10
 a=TOPH6uDL9cOC6tEoww4z:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-17_02,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 lowpriorityscore=0 adultscore=0 suspectscore=0
 priorityscore=1501 phishscore=0 clxscore=1015 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611170051

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
index 3400775d179b..2fc972f71509 100644
--- a/include/net/xdp.h
+++ b/include/net/xdp.h
@@ -484,7 +484,12 @@ void __xdp_return(netmem_ref netmem, enum xdp_mem_type mem_type,
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
index acad82982d77..1dbcec0b31ff 100644
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
2.56.1

