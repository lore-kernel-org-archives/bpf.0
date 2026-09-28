Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84C48374E73
	for <bpf@vger.kernel.org>; Mon, 28 Sep 2026 07:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790580216; cv=none; b=J76rOy+p/H4q+Q8pNkkxk+LWmBSfVDUdW6wYNP0Hywb+rYBKLvYUlkO03ciMO0qvSvWbTuHKu6qMynvGtqGzY2ezy2lMRITUrgMtP04Sg3gwmx5r1yhcxXeemmAAojSbDCJZcmXKyj5bX7H13Vql6ewMJVRschtIuIdojj/INjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790580216; c=relaxed/simple;
	bh=KYZFP0gPWy/Wd7obFLKDxyqHNqvG5d6OlBTK+GoIZAw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=HFbI5QKq4s0SMFu1woFHBnpNRZ0omwHLMjumMsdgudW9UBJ/5wBVjdOoE0f1WOUOiaQWV0WDb2p5fq0TK4Ce3NNldNNrfiwgI2Rz1WhOqzc7mdLrfIEHiezB7BMfiqUKDdFpPY9+v+RTfBSzr1SN7a9JVim0Qf/vAT937XVYae4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ehfCuvvW; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dWCf3weT; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ehfCuvvW";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dWCf3weT"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68S6eQN2718408
	for <bpf@vger.kernel.org>; Mon, 28 Sep 2026 07:23:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=26JY99h+pS0QjWl2fYV2iX
	kQch2O4CTOJVLN00yVygc=; b=ehfCuvvWwkztX8U2y/h2lcCK0LFh9sRldBMJmT
	u+ZWZlwWaodsuraqN76fMI4lRyto/YRhzzFsB7dY/01Y+RXw/RRxm1hHMc2qIVWV
	gYOLAWBDmKNLqB2+RfX0oEyLSVOaq25rMRRb/o0Mo5DfUGF+T2SVsdYqLOKhxkIe
	JWxtpl2D/mNbJVHH2rGrVqDkiusC1CGR5o+to9y4JcErXuwjb3oP8lQuc0lQoB5E
	yP1NsgauKkJHi13ekKqdJ67szPN/du2c28a0usySZHtEolCDN/0/NSB5qobqaoW+
	32cGfut3LUN/+JLp4BB3wZfjqPReBCLSGHVMQDkmBH4LuYXg==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gx526n3d5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Mon, 28 Sep 2026 07:23:34 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-91454ecbd2fso34289176d6.1
        for <bpf@vger.kernel.org>; Mon, 28 Sep 2026 00:23:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790580214; x=1791185014; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=26JY99h+pS0QjWl2fYV2iXkQch2O4CTOJVLN00yVygc=;
        b=dWCf3weTdhJuu7WAEjF3RcizY+ki5/Nm01Ph/e6sjeP/ZaB3bd7spOXSB53N2jQXz6
         QQpdtBAb2ME3YhJeF7dIXD7+u1zB54lskqGRrAfNfD33+cGbxrN/sZoA+N7D9wg4PG/+
         5ZKTUPto9AJ79LKmHIkFGh4MMQ7mA/iM9i4hrm3WACT35VGtmqjlSq/uTS6LkRpwkZpd
         zpL9A34/oZPEfFD0uprWoNOLd8jROY1uQbwCzKdBeYeLQTPjEpFgXthkJaOZJixOB1Wh
         0VoR6lEDOOgfdAlqI5MWag2snLZtXcVyvaF1Hj7X3eWCXBIBA+3rMbdNCcGpe0GtEQhb
         NVqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790580214; x=1791185014;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=26JY99h+pS0QjWl2fYV2iXkQch2O4CTOJVLN00yVygc=;
        b=PMf9mGfn8XyjGy92h5ZmisD5lTii4MLiNc4HBEgBwqk+ezn3IpPie/NNABHGBMW9K5
         l8UrLoTzYxTfNUDNL2H2lpNidjKxJ/J3XrHyNrhOM91gW0Z/sQ1WmzzfiqBP5KssqbNz
         ppH56p9bb623ik50Ljt7rfoVFLzicw7aWMlcUsioZSFVsLv05/ZFYb7Pa00/VfgNd2XE
         F792UltN0wCFeWuxISLSkh1BEkmllkmvEhXCBs8bfTvk31rpCWlEe07tPwrk7ilcpE6c
         zlMIBcKwX4VEsuUt9bG/WLFZkOZ6KKWHVar+JNDRTEdpH1jXxjFLArSlj1KZRaapY9iW
         m/tg==
X-Forwarded-Encrypted: i=1; AKwUvBxNFhpxLrLSeCFcknuidEapnZY3QEeL5VrtCIMqFjmkcKfSP4uhQD793mamnsCsZe/hmPk=@vger.kernel.org
X-Gm-Message-State: AFuF++kIuouZfr3Dvxy4f3K1mbkiGXr/bSpY431BmOKcKWCPtpYqxjav
	e6efy85TGaabQWW4VaZNd+3/W17PnE6SzRb9V7vXqQKpXEid8hunO5xd3SMwfMRD/x4aTNk9BFo
	rZi5ZfIiuWzydy4eXD+dtWUEA4oc86EkLX4TyGEkqAg6/t/6x/hjSFgfMgqAPi+Q=
X-Gm-Gg: AYBFou2kT5ifB2OIrBAPR+Lp9yz4QOHofNSkxAp0g7CQDxbtwCvODuw4ZYpmC2OrCW6
	J5MF4JmUOtefgxcJjH5BB397S8KJylc14gNNt9pOsWerza9EGnrb2GNVRHFwFMJ1/CIFZHRpije
	bzSAwotfy9h45Ln3Ien0h0aVcIfuQCO5lTgt+jcw+id+8Xj/G54TQ/mzx2SF3zsQcu5BVfaqZS2
	NIWL46HDlk/DzP3uIiSmolE5E/W4G65QkOOQcYk1wx6Dx9w3ECFE5O/s35mOHJgyTJZY61kdhKa
	kFtwrjbAKDe3wThB6w3J+OSn95F2Ee01x2iWBLL6UDw+CnsmGvN8gbFOBiHcIpDr+5rmSMiBEUa
	C6OaEfjW2tRwraA==
X-Received: by 2002:a05:620a:4408:b0:936:dbd7:fcb3 with SMTP id af79cd13be357-93c43cfd229mr1943776585a.21.1790580213676;
        Mon, 28 Sep 2026 00:23:33 -0700 (PDT)
X-Received: by 2002:a05:620a:4408:b0:936:dbd7:fcb3 with SMTP id af79cd13be357-93c43cfd229mr1943771785a.21.1790580213090;
        Mon, 28 Sep 2026 00:23:33 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fee6ced69sm165493075e9.0.2026.09.28.00.23.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 00:23:32 -0700 (PDT)
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Date: Mon, 28 Sep 2026 09:23:11 +0200
Subject: [PATCH net v3] net: mvneta: clear XDP pfmemalloc flag between
 frames
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260928-mvneta-xdp-clear-frag-fix-v3-1-af4a51499eaf@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/33NwQqDMAwG4FcZPS9iK9Z1p73H2CHWVAtqXeuKQ
 3z3FXfZYXgJ/An/l5UF8pYCu55W5inaYN2YQnE+Md3h2BLYJmUmciFzxRUMcaQZYWkm0D2hB+O
 xBWMXqFBLxYnLUtUs9SdPab3bd5ZK7JGWnQ2z8+/9X+T76UuL/ICOHDg0FRlsSBtVqpsLIXu+s
 NduGLI0djyKX7A4AkUChbpIVWBFKOs/4LZtH8Hzdf4fAQAA
X-Change-ID: 20260919-mvneta-xdp-clear-frag-fix-7ac691e1659b
To: Marcin Wojtas <marcin.s.wojtas@gmail.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Stanislav Fomichev <sdf@fomichev.me>,
        Toke Hoiland-Jorgensen <toke@redhat.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org,
        Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Authority-Analysis: v=2.4 cv=VvS2kO2n c=1 sm=1 tr=0 ts=6aba15f6 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=Bf4p-39G4bmrPmVIT4wA:9
 a=0bXxn9q0MV6snEgNplNhOjQmxlI=:19 a=QEXdDO2ut3YA:10 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-GUID: FOV_hYVAYm21CyHqsJYs_A8QVRCGoqzf
X-Proofpoint-ORIG-GUID: FOV_hYVAYm21CyHqsJYs_A8QVRCGoqzf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDAyOSBTYWx0ZWRfXziJZT/k9xdi9
 Z9MXyVj9WPs+W1BOFpJ5m1pFXI6r1CZFwrP8Ns8lVPml6fniUSiw/4AfEA7ZX01E0Fe014NUFGI
 18Z3nBJ2yQE2OIwMUj0/fmw/QHSxb1Ibkp/k8Mljvmv+tvhM7d/Pb8JtE1j6qYZQPTTWQVWzl70
 UvK6Fsrj9kmsnOCe2goibXw1dhAkK6yKITwGu/BIeTGzzqXFFU7Ly48QWpMq/UszQpwNolKjfdT
 pBHEBifA9K4o2mAZ+6QvVqIPOWzbY9n/Rr2tvoDe4Emu5U2TWMH/sYAzjFsdAuPVjz3eV8V/zgI
 o3/XQYnsw4x0/y+IRecCvyUGUoYeoiOA5mcwxeGo5TwPCzfLpMp3mL8BbENH+k1SjCrOCf4MjKk
 D312iyKzGqNxUQBC6qv1cay4H6fCCQUcF3DfZ/Qa7uE30xiNYZD3z0lB3vZttqJWQf+qgg0Gm1L
 9RaVTbbqUHJnLTajpqg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDAyOSBTYWx0ZWRfX4A/yjrxDe//+
 u9UjHQyCd5dNmfD2w8kl/nKsiNxjS64wmvbpK7w9ZDgC6HBMiDuPL7HGNsImR7A0sEc9c6c+Ux2
 kholjRPtjFYGFc11b5fZYS+DZ0GujhI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-26_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0 clxscore=1015
 priorityscore=1501 spamscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609280029

mvneta_swbm_add_rx_fragment() sets XDP_FLAGS_FRAGS_PF_MEMALLOC on the
xdp_buff when a fragment page is a pfmemalloc one (page under memory
pressure). The xdp_buff is reused for the next frame, but only the
XDP_FLAGS_HAS_FRAGS bit was cleared at frame start, so the pfmemalloc
bit leaked from one frame into the following ones. mvneta_swbm_build_skb()
propagates the flag to skb->pfmemalloc through xdp_update_skb_frags_info(),
so the skb of a subsequent fragmented frame could be wrongly marked as
pfmemalloc even if none of its pages are under pressure.

Clear all the xdp_buff flags in mvneta_swbm_rx_frame(), which is invoked
for each new frame, instead of just the XDP_FLAGS_HAS_FRAGS bit.

Fixes: ed7a58cb40bd ("net: marvell: rely on xdp_update_skb_shared_info utility routine")
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
---
Changes in v3:
- Rename xdp_buff_clear_flags() in xdp_reinit_buf().
- Link to v2: https://lore.kernel.org/r/20260923-mvneta-xdp-clear-frag-fix-v2-1-298693a7ea6b@oss.qualcomm.com

Changes in v2:
- Introduce xdp_buff_clear_flags() utility routine.
- Link to v1: https://lore.kernel.org/r/20260920-mvneta-xdp-clear-frag-fix-v1-1-d7efadecf959@oss.qualcomm.com
---
 drivers/net/ethernet/marvell/mvneta.c | 2 +-
 include/net/xdp.h                     | 5 +++++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/mvneta.c b/drivers/net/ethernet/marvell/mvneta.c
index c2b1098d8d1d..485af7e395ae 100644
--- a/drivers/net/ethernet/marvell/mvneta.c
+++ b/drivers/net/ethernet/marvell/mvneta.c
@@ -2340,7 +2340,7 @@ mvneta_swbm_rx_frame(struct mvneta_port *pp,
 
 	/* Prefetch header */
 	prefetch(data);
-	xdp_buff_clear_frags_flag(xdp);
+	xdp_reinit_buf(xdp);
 	xdp_prepare_buff(xdp, data, pp->rx_offset_correction + MVNETA_MH_SIZE,
 			 data_len, true);
 }
diff --git a/include/net/xdp.h b/include/net/xdp.h
index aa742f413c35..8d928eb73dc1 100644
--- a/include/net/xdp.h
+++ b/include/net/xdp.h
@@ -106,6 +106,11 @@ struct xdp_buff {
 	};
 };
 
+static __always_inline void xdp_reinit_buf(struct xdp_buff *xdp)
+{
+	xdp->flags = 0;
+}
+
 static __always_inline bool xdp_buff_has_frags(const struct xdp_buff *xdp)
 {
 	return !!(xdp->flags & XDP_FLAGS_HAS_FRAGS);

---
base-commit: 014d795c73837ea2339a4ea8e8f82c6e959b845d
change-id: 20260919-mvneta-xdp-clear-frag-fix-7ac691e1659b

Best regards,
-- 
Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>

