Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795618163;
	b=xYwix+Yzxx8Iwrj1TypDnniAjxQBtFfCxbBYqngnjYq6bX8G91RawebVWqbMY9QcU6KS
	 00YRs8q3sqAt9wROP7/R/QMyNM3Y0RCyjRckmYsy+UK0yeKvJhO2Z/R13Bh7JBHfVkuo3
	 thkTrlOwNZWBGPtQAegjQ03CKrcdFYVEWhtxvuSyF1thGLrHDNMGm3Qj/faAd3yXiR6PG
	 lmLTb2I31BIY2SiFD1tMK0YM0YOs7SdoJ9sXEzCHTo2pOqUFnNEMshm4S3pWe02gxjumt
	 GtUH0KeJFdopqBNguti3QXm5Zgso2R+gCEN9IQAfzOyNWCMCl33QkE313PuoZiNVRyA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795618163;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=5bA2dLmzqgo3bDop9DwrX5y7CzbVAF3y/Ym4vkMUybI=;
	b=vc2vCHjkM70MBsuSKJWpHcgchSHJ3gi5SloQN3b0MhE3JlyTaA5r6z/t14lM1mYeGE23
	 SErzlFbfnqdcrm99euVqbdDMiz+/CcN8Wd0YG/0NVEZb00sjPZDem33y002axtXNsuHLf
	 OVZB6M8f5qUlVCCx1FyOsY7pHLCifDytuC9jZekLN/5igu+QUBMtQ3cupiMonQxxdiW15
	 RRzKKXNd/+ANZ0DSiM/9Rgvr/9WfPUjixSuUgUMBqyERa/ait4848APAwNOQxUlQFoV8U
	 I45zhR9QzwLkjHLSsXvAm/SGCDb4kcqdUKXOvloZSVQz28Jrb7X1GQphyLJsoYH7YqQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=nN5HuPAe;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=eqikgZkW;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D60A606A336
	for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 14:49:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9D60A606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=nN5HuPAe;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=eqikgZkW
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6APELtkh3725641
	for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 14:49:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	5bA2dLmzqgo3bDop9DwrX5y7CzbVAF3y/Ym4vkMUybI=; b=nN5HuPAep8TQmsUz
	XdjqnsWFEgrmwYw66IBMyL1fbRjmBC9cG3Dzo+82Md8geoDLRIGPw2hjZQKphbx3
	YmTztth9BBm2pLcZBKO+gdDEOSWhUymmwdPN2LnQc1km5UHaLa7aCOsryf0cxj/n
	mQ3llFhrsOlM0XalDktbU/iUIeZquze6ne5pTs7eGVmaPQb+q4Tcum8NBC218JWy
	m/1L2QfbgA+WpzR4K14L1vUS4cH0JLIes56ahlF2+WW83Ur6jwZKSToMhwk6qB8S
	8kR5SzqEmSXAvOprGd/aZLqIK4AmsweKVHXDwtteL6A/eAwTsXUk/jM57kxMCaZb
	Y4K3qA==
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com [209.85.221.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j61af047t-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 14:49:21 +0000 (GMT)
Received: by mail-vk1-f198.google.com with SMTP id 71dfb90a1353d-5eac42e83e0so1073167e0c.2
        for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 06:49:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795618161; x=1796222961; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5bA2dLmzqgo3bDop9DwrX5y7CzbVAF3y/Ym4vkMUybI=;
        b=eqikgZkWMkzAeEqq9lsgeCjw+aspioU17NUdcOltDMeV9G911NzBSK9haz/yWqxfZg
         95YT0mA2t2etQO0HVugly9YcKgJpqVjk+csfUq3cb4MOM0QHdoEdPyG9Fgww1PTYRNr1
         C+L+q8FnyFT0XNsZ3U3TUVDguxEg8WHzHEkFcK+439xjvU3A6pIepj+Mc1+SJCchz29C
         vzmRsyhTYItgBtu5odRxZ8lxQTnf2CCwgeCPi5BFzpH2lgqCKaSuc/eM/BVX2uG8CBRh
         M0+NnuHu/Iu/zS5iOo7pRmk/h6Tqfdd78Gq6gAM5nlGirZS9hnvsYWoraC2bpV5hHs9g
         aOEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795618161; x=1796222961;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5bA2dLmzqgo3bDop9DwrX5y7CzbVAF3y/Ym4vkMUybI=;
        b=fPnyvhUtbwDR+yqObfZOQy2XdwyY70ljWXUmPcPgtyK8RJAlZWw8QRmZTEGtusIUe4
         pgHcujwbxKFcog6uyk77M5kuykWyNKrzmuiK/ONBZlaARpRiT2UG6bDaVQ/nrOPnhgvF
         W9mmEyUxFIGEIjOOzv88yvIf/nMOCPPIou9DkHNdqAFdg0Oa1iY0lKiGGCL/c4YmafFL
         95NP+d8EF2NvfdlSQOoPg7UPihiIcd4nF35JQWT4t4bpNW37G0tvypbqG3PIhntISann
         oNNLoOuBUb/PrTMLbCJ6M2+fh3q5EELrJO0qzlc582iLAZEfVcU0HoeKslRgHAbzNz+p
         f3yw==
X-Forwarded-Encrypted: i=1; AL+hErELYztb8lVeI/J7T3Mazlw9Tz3PoUo9VGF/4YHDltWrlcd3KaPcLbqUDFKPqUDBqaPnmio=@vger.kernel.org
X-Gm-Message-State: APuU4Z/ES161upEarU1KmEos+pAIRDaNZOMVd2O5cmlxZNzADS1ybFz7
	9uSnaJ6Fgxx7tWLoqXWJnskZ/ioetKwblxJQ2rVL53hZMy0i1D9a83KKMM270u17tiKWWS66/Zl
	HBfrYKrtb/HplJtWfdIkAY+oVw2Eb2qYmCnnlujW+NCe8yEefRzn/67I=
X-Gm-Gg: AZFdTZeKxjzR62cReZ5J2sk82GG/6D6Y5tZ8cgt/fSYlcNYGdBQW/RzcW0PpW24512w
	5qirLpAjo6Au7IrVAdkq2KQoCUQelQOzdMXOL/uofFKVKgq4/14HThoHQ2e5C2jPNS/WzSfv28g
	/wPb0JMOpHJE3Y2P335mnIj9Iq4+aa5iLXyHygBrgvcq4Zer7F1DygHfGB3uoMG3JMlV0e1WAvd
	wFgJaYL6+K0L9F9jPhwsMGftXTRpy06OYu8I16rfmav7+GpCkI7y4DTJ6qlpkLPE/19GElI5tgM
	009ImIw3fCVag4u0Z8if6FhSnuxLCTpNjL7Zc4WUUQ/w4M7WnERbZT8DXPKI0vv53yxshSP2HqM
	x/JZOhPKb1IdCvEGvNkVSHRbSOlxBVZPOU+cAYSiR6fR79TeU9gnEAojaQRtwWAzZ4A1Cj2xadI
	1C8H4m5BKx7KvFvtU3V/QOU5H9X3k=
X-Received: by 2002:a05:6122:4f97:b0:5df:682a:5d14 with SMTP id 71dfb90a1353d-5ee8aeb79bcmr10154533e0c.4.1795618160437;
        Wed, 25 Nov 2026 06:49:20 -0800 (PST)
X-Received: by 2002:a05:6122:4f97:b0:5df:682a:5d14 with SMTP id 71dfb90a1353d-5ee8aeb79bcmr10154418e0c.4.1795618159458;
        Wed, 25 Nov 2026 06:49:19 -0800 (PST)
Received: from localhost (net-188-152-73-83.cust.dsl.teletu.it. [188.152.73.83])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb853a12acsm554109195e9.8.2026.11.25.06.49.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 06:49:18 -0800 (PST)
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Date: Wed, 25 Nov 2026 15:48:49 +0100
Subject: [PATCH net-next v13 4/5] net: xdp: add __xdp_return_buff() helper
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
Message-Id: <20261125-stmmac-rx-mb-v13-4-0f6bac53e8d5@oss.qualcomm.com>
References: <20261125-stmmac-rx-mb-v13-0-0f6bac53e8d5@oss.qualcomm.com>
In-Reply-To: <20261125-stmmac-rx-mb-v13-0-0f6bac53e8d5@oss.qualcomm.com>
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
        Ihor Solodrai <ihor.solodrai@linux.dev>,
        Matthew Gerlach <matthew.gerlach@altera.com>,
        Boon Khai Ng <boon.khai.ng@altera.com>
Cc: netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        bpf@vger.kernel.org,
        Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI1MDA1OCBTYWx0ZWRfX8Y5fCAE7Ly08
 XX6bWAfPbx2vpNConuqxWnsNnRShotu6InigN4VFhSOj12AFi82vDZMa+7MamLyUDjCc3hB8jNb
 jNJkWpG1jl73GRx3Z/AkK9mZZ8QH7VY=
X-Authority-Analysis: v=2.4 cv=PdhqFShd c=1 sm=1 tr=0 ts=6b06f571 cx=c_pps
 a=1Os3MKEOqt8YzSjcPV0cFA==:117 a=mlS0om9xteqVCAF/aDpb2g==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=EPvaxb3vtNQ3FCvCQEgA:9 a=QEXdDO2ut3YA:10
 a=hhpmQAJR8DioWGSBphRh:22
X-Proofpoint-GUID: xQZNobQUJOiQBhoOSFX6BYbhazmMVXQn
X-Proofpoint-ORIG-GUID: xQZNobQUJOiQBhoOSFX6BYbhazmMVXQn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI1MDA1OCBTYWx0ZWRfX29+XZLKlu5LC
 849AVGlnBu8x7u4sKih8MMFoe7beOaf/BTH1uS+NK94spKwqG9vjJrJT0geKSIopFR7inS1wjlk
 QXsJGowjkpZiZJbLSGkfuJnp+GR1gicJN+1Zd5TqMtapSlc9FkUgIKiKttHRCFnoqdmdj068S7B
 BffLL68rCFh1BLxaLj3Nh18eEyxZQbC27Yg0ykmnLwnsCgVJljB9cGUG3a8E9dRwQpyb1mUjGhc
 FyofBk2TvHvIGKoy+s9I7uMRLHw9kXieeccVQe9sYQmtxUnrcHdizaq4QZmyOimeqsWwDJ6zi7r
 UNMGT/045vy+yldZM4kwBUQXq+3mwjVLkMwoJZB0Xo8Q1pWCOX7NLvcJRVpIVLBbBxmk21rDGoy
 BolGVy0do67ABZ6UD+hNrPeDrX5m/QNj8SHXVHKX/O5AcTxPZkgb/WzGHeYZcldc95bJZxT1gUw
 a+ma/NrlQDc2LHj0Edw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-25_04,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 priorityscore=1501 suspectscore=0 clxscore=1015
 lowpriorityscore=0 bulkscore=0 malwarescore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611250058

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
index 02289028044c..f0946500c487 100644
--- a/include/net/xdp.h
+++ b/include/net/xdp.h
@@ -457,7 +457,12 @@ void __xdp_return(netmem_ref netmem, enum xdp_mem_type mem_type,
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
index 055931263413..f35ae7e118f5 100644
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

