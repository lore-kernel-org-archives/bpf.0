Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795282121;
	b=Gs77caFbTzg5kudyGs0xQ7P7erUzOJQvMCLoT62mU/O7iIYuaKeIUcvegpEjLRDUK8HJ
	 T/bXzn/61VqphRCsSpL02YTeEHBe4qdcmHRX4jsMndphCp0lAv0W1WnoHIs6SdqRFBMbk
	 ct4bdmDHyIGGg2wLgh/CRgzBYZI3EYBzS5Cigr7edE3P4ffe4cRNaKncpJaeKvGdteZsx
	 5chccO4uIiQrJP9qSZDj4VHWGxm7k5J6smLRx7HxkQZz0cLusi9Om65gGYnOXUrXQ+ZKm
	 lQB32f/6ET9UQ6hqQ+7JK7WDSAnYODznIUaOFqO59X0qmspqiZFVxWnB3/tBYuf/mfA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795282121;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=s/2ub0vL3CaIDBF+BZvv9xMGDewjeSC4WNdbIVGz2Qk=;
	b=3M43OgmoxCOWpnHjf6XN78pYI/IWqn4nxAM3at4N/OWxk+8mYTsPc97csDVX9BGDMTao
	 g40hl3NWTV9Nior8Q5vG+Xe3dugpxkLCd7oOA1EAyyeJxlcvx8082yKNQ2zV7+ISJpZGI
	 Z79Sz1p9+XasNCC2qkyfJ672MTfW0wlVLoM5gvtDOipJC0CE7rlrUIr6WTPnmngSlCTME
	 eFp5dym/RnRBjccUXN0zxvFa69YJD0CeapZQVeYKE++fNWCNl98Sgw7r8qEXILuqNTQ7j
	 VVq5qlSxlG0urSOgTvNKNzKGUQZeVp6beNTuyo/RxUtpqZcVmzELsPCMlZQmHj/tyfw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b="ncRMs/Fx";
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=M2pzVLDo;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E18BC606A32A
	for <bpf@vger.kernel.org>; Sat, 21 Nov 2026 17:28:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E18BC606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ncRMs/Fx;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=M2pzVLDo
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ALFa0wh3174093
	for <bpf@vger.kernel.org>; Sat, 21 Nov 2026 17:28:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	s/2ub0vL3CaIDBF+BZvv9xMGDewjeSC4WNdbIVGz2Qk=; b=ncRMs/FxRq70fumZ
	bEH25c6rwXs9WizSy/k0JdP6pwiHYY7dU0XW9FkB1pNfjacWPy8gtsnCvuuWQM1m
	HMwH70Pn8pumdexGMsqF1pbQSf11FbwZ2glxqfGn4cmK8OtRBcXN9d5xFXUZgtY0
	P0oswngXpWAhhleN4xae/RgjEPgjhWWVWHYA5DO6Tc73fsjXZD8muhD9fjC6K1hg
	9PGm3xbvZZFaWmV2nlIBNcMgILDY9MDUArKXwYRC3no2++apvdhGm/WgJ2j4ybeE
	3ncz0MbOndqoFFRM7nIzpJjoyPdnzu4t34nVjilrbruJntK6rHLW2qSxXHTT4Z2m
	pRamYQ==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j30nnt0tw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Sat, 21 Nov 2026 17:28:39 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-9212d968d19so38198886d6.3
        for <bpf@vger.kernel.org>; Sat, 21 Nov 2026 09:28:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795282119; x=1795886919; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=s/2ub0vL3CaIDBF+BZvv9xMGDewjeSC4WNdbIVGz2Qk=;
        b=M2pzVLDoKWn4UjdY+zZzDKAK7iIdciKonagGMToU14jvF4G3bf4RAlazO6VVrF9QRs
         9sYL3pEi6v3avZ9HQSk2qmKdb/Cq/R9VeMURD8YbaVwA2sGfJR5uT20Ep8e4NrvItaRP
         C2zApUFseXvrg2RIf9RUtiNqapXd/OiwVyhRPt66jo6fQYxFBQBuTPMKGl1jxmBZsxdC
         SUxXNUAzuBZcv/YpJvkI8HXVjGq7RkwG4CiHQKFDWPf38SM/Kpx6eTgrs+I1IMVIbF+p
         5h92PE4kODIKmkVQ5T8W7uBNWbS4Kcokt2PGBZ35q/Zpr3s8hz+yg7thgBu/jdS9usaM
         WtSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795282119; x=1795886919;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=s/2ub0vL3CaIDBF+BZvv9xMGDewjeSC4WNdbIVGz2Qk=;
        b=mKzduGHY9mGE0Cf9AFz4CCe8R/+87gDkZo43bl74NPTAWpz1QPstZK7KGX0PFWG5D4
         B8AfD+FUhQExYMCblDdoywdX+hMZ1SvPV4GUMbsZHTDXNxTn1WQukd6P4j2Ufl/fvkdP
         ceP78HMy/ttkuqx3JtGOCSeo+cniiqlw2h82x22ov0tnO9bU8Ab7MQgVi0y9LNS2/2av
         eXyD06kS9KH6s5u/rC6MVIy1XoZMsTGENlLPLuwJejJwc7yRNljb6mG5cWpb9meevGKP
         crwkuG9FzG9j/jZO6hQ6WIun+ZE+jpamOe2WkMfuoAhhP8SRcyimtKlw2IGUtwkg3YKi
         9/jA==
X-Forwarded-Encrypted: i=1; AL+hErFoJaxXEt1U4hTnIlbYkTtFHiuV2gOPvYqFbBaH7NXny7sQpAOaKntTxqGaMikkQXl6e/k=@vger.kernel.org
X-Gm-Message-State: APuU4Z8KcxGWOICK2Gx2BiCWWrwx0+p2sCuvwUIO7Aza4rcqpaYYJVv2
	80BRnkbdBf8cIlYcO0tiJYSXdGqsj4hlQWj9CALNQ8BOIj3gbbSETa8Apttk1R4F/xuqE3x/fXY
	j2am/0atMk/hdlAW3HBa4WGUd3taphMlFufMnu419DGlUkZHYQ/YBfvs=
X-Gm-Gg: AZFdTZe9mLze+jQ4uqpgCqdIFARomXzvqf8LgkKhaAdccDN+ayIU1VxRfAh/IHQf6/C
	5YqAEyZMbHXYuPSMlQptSG1hEEzMfxFtgOKqV3Yuvoe3JrP2q+fcblWAdsMloCMU+9q6LwgQYQ5
	tWDCJZYyRyu5W8iRw2i8CYjKX0we5UCPLQFKEGcg+GIV36hlO5zXoRHnzwZiYLpsAhj0fw1wlq3
	fpVNw5weMTk1tBu5w6mJC27XsOMLXAhqbcL4TUUTkG6Z28DXrDE9Qe6slYlHHea2ZNAkF9x5d+n
	rtGoR/E1cfX+WxlG3rNIgp7OMgPGnoBxDyk0CYrYM3K3e43UhJgRJJ+lJYiLEzLCAcyv4XtRy+i
	7wEst4CWVcafG9CVaGaDxVRiS8isjBc1uBh8+14sQKR2CBYkBo0ETl/nr6IF0SL1NXM0AzbWbbi
	MbxaPV8adgeAiOQeopAq/ECzZNTbY=
X-Received: by 2002:a05:620a:40c1:b0:949:5708:3cb1 with SMTP id af79cd13be357-949ba67d397mr1120422785a.0.1795282119000;
        Sat, 21 Nov 2026 09:28:39 -0800 (PST)
X-Received: by 2002:a05:620a:40c1:b0:949:5708:3cb1 with SMTP id af79cd13be357-949ba67d397mr1120416885a.0.1795282118477;
        Sat, 21 Nov 2026 09:28:38 -0800 (PST)
Received: from localhost (net-188-152-73-83.cust.dsl.teletu.it. [188.152.73.83])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6b2052c8sm12146461f8f.41.2026.11.21.09.28.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 09:28:37 -0800 (PST)
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Date: Sat, 21 Nov 2026 18:28:14 +0100
Subject: [PATCH net-next v12 3/4] net: xdp: add __xdp_return_buff() helper
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
Message-Id: <20261121-stmmac-rx-mb-v12-3-3ae2f3bce174@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIxMDA2OSBTYWx0ZWRfX5mG7YJ7axWdY
 CSRryQsa5mekujr6T/Rhgk3DX6PPweBfZ1atQ8FDMibu2y8uSBcsCFmFspTM3zvgB2Uu7Xr/Vrn
 SSKK61YvHBYSMN/lxgELOEJ1nT/mM+33MPGCeSs52x9Cb3twUDAV1R9/FnfA44X/l7DuHVeOB1c
 TLJauNSbDIrSUnpiZvMuD+H+JHNOiwuoqpGHMc5ur4HU7CgWLKuEO2FcgOOMESS/8SNyDxfgt7f
 Hqgekg/JtiH3DGfVRHEtasvO3f3lWMxDK8mAeOq6WZ9x9rv2KYEo9qnzxTr9KR/swleDMwTcWWH
 f75/CRJqTZYuGJ/+mt8d5FeQWx+lQRa/yhPKEwO1wfTbyzqXXrzMPJj6jKFtci0ODoewggxgatw
 c/3bfZdERXfqWsmXhFG4XI+XZf2IHRtUhLVbg3JVmKdeD2o1evFxxqr3VzZYMsUc02BMl/TtvUt
 IbUsh+L3smGfSw2HPDA==
X-Proofpoint-ORIG-GUID: D7YSTU2VDhSxIVunZ53TQfe3FDTy-aBy
X-Authority-Analysis: v=2.4 cv=LITz05W9 c=1 sm=1 tr=0 ts=6b01d4c7 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=mlS0om9xteqVCAF/aDpb2g==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=EPvaxb3vtNQ3FCvCQEgA:9 a=QEXdDO2ut3YA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIxMDA2OSBTYWx0ZWRfX2Sw2yBhvD6fr
 Q/+v6KVQ8Pu8MV1wwoUlDYjduNn3QPATSoVFup0y5Ieu9ZfNOPbJMSV8ri1dskFIh8R/eu3aJpj
 iz9UOalR+xynYVdH8Ijg+Q2FoyQ6qqk=
X-Proofpoint-GUID: D7YSTU2VDhSxIVunZ53TQfe3FDTy-aBy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-21_04,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 phishscore=0 bulkscore=0 adultscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611210069

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

