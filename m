Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A7D352D2A1
	for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 13:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789651370; cv=none; b=fuOOgo/0NMW58idTPUBuKjtKhmpGuRHMZmyPCb96sv7/m1jLY/2jjAsa6kdlfNmewrOWE8Rq4x5Mqk4BldZ4LWdWj1hT1WvY8tOEsHa9W0aW+KUynZ0fXLLxWc1mG/aOLN6NB1Oav0wNfkB4PvgXMl9ueRGzaDcZj/4E1UKXUd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789651370; c=relaxed/simple;
	bh=eUFZj7HdiNssWy2NTZ7R6ChYmtk7obu+WhbPxWvm/oE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=sMubAt4TIaKjbPP9ArjhYIpU6Uo2fQi4A/KmsahzbFQNRBdnHsTNRIe7jPMxevSUo497BV87LOEiYlfBeoZDRVEF3Uq2Vz7uyWhBS+3+uoEcXsxpbSusZxLvXc2bfXf2qrJC5a8fFnxcgxEcAsEdakt1pfjtW/HEhwbTIeVKEGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=L/Feg6bt; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=U6oj7n+e; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="L/Feg6bt";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="U6oj7n+e"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68H9ZXO7576867
	for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 13:22:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=CflkOAT9fCKQ7PMjFcNJ2k
	iw8Vw7bCScxaeZQVMpyoI=; b=L/Feg6btTKnpBE/i54fr0iB++Wii5prBd4wavK
	v0hHE1w+YXFsJGJQ1LGTrWFImyruaOyg3i3/XJSGWJrzDtPxdM/weFsTF9wnDMS5
	GnF08wEQA6AWs/IeuMFc26b9VU5E/DM8oCEb3VdtVD07jORrIVSmTlWYQNVoYqvB
	fvrDb0R5g5rylkV880t6BIjBFKjKVXYqQzrB1gyfzHwFeG2q9LNrRM3ga//nvhVi
	8sKh9ULVAd3DnqIsFDhjR+wogdfQVMQWeAkv95FHLCpBo8hLscWMezqns034noNG
	WfwO0u35pVXo1sDTGXRNv7EFSsHzmFrBxMHvD4YnFOvS7Hkw==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gr8uw27d7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 13:22:47 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-91051512080so13699186d6.3
        for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 06:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789651367; x=1790256167; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=CflkOAT9fCKQ7PMjFcNJ2kiw8Vw7bCScxaeZQVMpyoI=;
        b=U6oj7n+erQOFa1W7wBVj3TheBPlmFpdzTP7mrRcgZtXio9cYftNq6AKfPAdNT3P4SC
         jaEb0jT5MCT02J0zD7L8BpQUm2AaFh7W4mPOBePqwvapJXmb1Y6rzv3oCVZWxK7hA+j0
         SJGMoPrIqclaJKcpIC5dHpQfHdCNHuh4QurNLTkP2AS0R/BU6XftAorjfVQRSGl1WZvT
         iZQX6URQUjY0ILkcCK+S4JSls15YRI5IyEb+3TCwhEGP+A55myCQv0WlgVnwRXNt4uRx
         3hmn/V2E1jzpcunTWMx5eAlK9xYrurMCf4Du8gpj7jAM0GAprfbLSpd2aqtMeETjx0HJ
         6JHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789651367; x=1790256167;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=CflkOAT9fCKQ7PMjFcNJ2kiw8Vw7bCScxaeZQVMpyoI=;
        b=aszOYb18S07kMCSTUciV2KpetY9r/P52BLl6iSpuHlB0HjPzUe1ceDtq/OXmOsknRX
         PzZEJ21hQIlNxMCcd3mYWKVfE3FVCgx1aEOTgt2aTRwvSBqYvEcDASvSHcvSXVgVU2+D
         OOUuDJWR9o7wxyuIGV9wKmHcEajihJd7SsnJSbFNrpjaRqtAIfTUlYV9LAC6dhyU7QYz
         9WYtDE5to19us1DC5xcAd9WNGwhkX7ENbGpzOrhY0zbc07GNQTzIbN1QuAnebFrbGQbX
         QqX2hroWS3//w9mRqgESK0jE0JqMiO88gSar1olecMD4blMO9I4cyq87zynS3y5wqUMp
         ocYw==
X-Forwarded-Encrypted: i=1; AKwUvBzDdsIiWKCqxej6j4dr4aBdQ7FBXnXjWIl+cGAtNgLazgPmmFkxNwttEvo2EwdDqxmlwLo=@vger.kernel.org
X-Gm-Message-State: AFuF++nVt/RrMW1FxR/Z9K85CEc91i4kR9Rry1haBnmTUphD7hh0BD4/
	06sn01jrHVx1dV2JTWWWYMTFJEALRANzDPhmYfaGbuF37j6tOzDt7t0gq5MJewU9BG76zFkqe+1
	28f+RFYHzSMrYPhv5KGO+U151CZqWHOOCT+ME2yzKbCYMSDbysh2IzrDycu6E0Tw=
X-Gm-Gg: AYBFou1XwW4Ai6qcs+Yv+z/nk437CFeZSyJzu9ox5Uc/sQGgBgIJiiN3nSKg2df95aB
	//5Ztj+JB+S/DIyAyRXMcDofhiavbbRkplBq5/VeL8z+wexeYgKziM2LdSm3fYswsd2v2i+Zv5p
	GhYqJMRInrL97i61aUVwuU490xmz7rPYkZAzu7oYLi35Tj1jlE1dkCH3WiO09Lu8cq2OHo9m8y3
	GTz5v5K4OzM5KODF2T0irxQ3Lob3GNZC8c+BQ3dauAKmJoBWzzEZodck1Vkd7nJtbuDiQ+xt3/f
	tvtuvYE/1GfqCMYi2yzbb/sCmmJLl2Fv69dwIKClbRtfxieQHKJXwmHDjUHIJ7ulIX9S7vxRMZo
	S7RyM7iexoS3ekw==
X-Received: by 2002:a05:620a:7087:b0:93b:d7a0:d9ea with SMTP id af79cd13be357-93bd7a0f070mr53259485a.68.1789651366479;
        Thu, 17 Sep 2026 06:22:46 -0700 (PDT)
X-Received: by 2002:a05:620a:7087:b0:93b:d7a0:d9ea with SMTP id af79cd13be357-93bd7a0f070mr53253985a.68.1789651365901;
        Thu, 17 Sep 2026 06:22:45 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fbd23f4e6sm91451705e9.8.2026.09.17.06.22.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 06:22:45 -0700 (PDT)
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Date: Thu, 17 Sep 2026 15:22:29 +0200
Subject: [PATCH net-next] net: mvneta: rely on napi_build_skb() in
 mvneta_swbm_build_skb()
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260917-mvneta-napi-poll-v1-1-fb57604932d3@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2MwQ5AMBAFf0X2bJNyQP2KOBQPm7CaVkQi/l3jO
 MnMPBQRBJHa7KGAS6IcmqDIMxpXpwtYpsRUmrIytqh5vxSnY3Ve2B/bxraphwbWYTaglPmAWe5
 /2VFyWXGf1L/vBy4pxyJsAAAA
X-Change-ID: 20260917-mvneta-napi-poll-987b8e9aef0e
To: Marcin Wojtas <marcin.s.wojtas@gmail.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Stanislav Fomichev <sdf@fomichev.me>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org,
        Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-ORIG-GUID: YOrC22WOX7cO-02On4JtQ9cjs5hwHG3D
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE3MDE4NyBTYWx0ZWRfX+kji6wBklieI
 3d6AvfX5kDxvtsKLvH63elFucLhsim0tTpQGMq7/AqgJelaKVevUegdT3NSIZ6TXTUW6Kf/LGYw
 OAB4QXO7tOqpNUs/SpcnCRxY2MS7/tKUIn30r5qapgLcL/at04JS8zBtBSpZoVR2WarA8Xm0XJ6
 yCGue2NaghharoTer7kzIguIC0z8kfS8zZL2iag3wTh+guwCEDRgrvL8Jb3GfMh7ROBfrE42W8F
 rd4AUpSCvqWfA//BH+WDLi2q1H3uvm7CWx0t6sUnew8Emb+y6cKL8yJIhtRJopKIt1vNOlSFS60
 xZ6R5ZuSSP4DgFTsKCpMiIRDNgbn0bqbLriBoeiCV78U3BrRGOkSLXmMxolmlf37Fma0WBvWj1u
 gBaE+ptsLQToODsaTTtZPPggpIQ8VesVGp2/8BR9S3AW67COyZ144rMhe/bT7hGTg6t0sE6go54
 SKDHjNL/W56QTe/WkXg==
X-Proofpoint-GUID: YOrC22WOX7cO-02On4JtQ9cjs5hwHG3D
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE3MDE4NyBTYWx0ZWRfX3jV7EpEtSUFA
 zwVkqSA6Z6s08/X/3ZosVKiQDDVkNBW9U/wJX4YO/yK7ZroRLvJCnpTBWReA/L4o2bQ99ZbScFX
 Uotq0YyNf+ompyzdBD8uD+65OCdEslo=
X-Authority-Analysis: v=2.4 cv=dMUzC+Zb c=1 sm=1 tr=0 ts=6aabe9a7 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=wB1r_q1jRA9oiTqnZLwA:9 a=QEXdDO2ut3YA:10
 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-17_02,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 bulkscore=0 impostorscore=0 suspectscore=0
 spamscore=0 phishscore=0 adultscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609170187

mvneta_swbm_build_skb() is only invoked from mvneta_poll(), the NAPI
poll routine, so it always runs in NAPI context. Use napi_build_skb()
instead of build_skb() to source the skb head from the per-CPU NAPI
cache, avoiding a per-packet kmem_cache_alloc() of the skb head.

Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
---
 drivers/net/ethernet/marvell/mvneta.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/mvneta.c b/drivers/net/ethernet/marvell/mvneta.c
index 543e566425c1..c2b1098d8d1d 100644
--- a/drivers/net/ethernet/marvell/mvneta.c
+++ b/drivers/net/ethernet/marvell/mvneta.c
@@ -2403,7 +2403,7 @@ mvneta_swbm_build_skb(struct mvneta_port *pp, struct page_pool *pool,
 	if (unlikely(xdp_buff_has_frags(xdp)))
 		num_frags = sinfo->nr_frags;
 
-	skb = build_skb(xdp->data_hard_start, PAGE_SIZE);
+	skb = napi_build_skb(xdp->data_hard_start, PAGE_SIZE);
 	if (!skb)
 		return ERR_PTR(-ENOMEM);
 

---
base-commit: 859e40055c19ceb8b8215f3269e57075023b72b4
change-id: 20260917-mvneta-napi-poll-987b8e9aef0e

Best regards,
-- 
Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>

