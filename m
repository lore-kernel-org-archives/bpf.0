Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77E5949A3C1
	for <bpf@vger.kernel.org>; Fri,  9 Oct 2026 10:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791541615; cv=none; b=C1aagJPufil/DI567ZjPJ1Ch9YuBdKNwEf4Hy9dMp+Si8F+Zi3RCwcKXqzLuWnQoLR15JKsnq2Y6kMvBxfQVOS4m7Z7U3iOpahzPYIQDT/XW4JkW3wR6gKjzOGods3cygwETqJpbHipRUvSlukRTlGyIbCxsaGio1EE3nqfrWX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791541615; c=relaxed/simple;
	bh=M7mNStVKC1ugr04TAxWIyEHUaWMb2wYabMIiEfVYPco=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GNd3DwWF/2TXhe3FWp1JrNQ1T/Rfkhm4CaDHMDDwqQ7Q6wVE2AafQmtbMH4+m6N8O8m3ldFOvfVwA5jVxJ2BlCMhLZmMVb0dOEI1X4d7uoiPQv/hS9w4YuNz02b0kjjDDu4EVvlk/gBZAlNgsXh9B6sMMk+HFy9RYTpeNgmp+jU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NNOJ82jI; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=KbLi1pSe; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NNOJ82jI";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KbLi1pSe"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6998KHWP642384
	for <bpf@vger.kernel.org>; Fri, 9 Oct 2026 10:26:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	HrQRBTmL2QElj1OdIKBi4dLiSjrCHV8ryD7nPGM4RaU=; b=NNOJ82jIrvQaC7gr
	S7y0H6qn0uR+BGyXnmBQZUvkyf6TdsKaFvywPI0dIEuJjV4oO1MZ7PBWgJvNwMr/
	ny/W2J5c5ehGINVu2Mox/WGELpjMj3gpr8o5B/lXEYqFllB5GgBOYmdbOEQoy3+s
	cNgsxjvFNr3ThEpqCLcKlolfpzlY6Am0CW8tLAWgjm6hiIxI9aBE4iyW0H4fhnkp
	WTs7CSJB3xwJCBlU0wlvUYVZ0FLacCZxSPk3o1Dnb/0ZM9o3ZXnfRcb4ause769t
	uO3Pud0cULvjl/In+IOErOe7gSteXgo1v3Ph61/XiyVjLCRHT4y+r04QFDLzdacp
	p1grTw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h6fxru4au-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Fri, 09 Oct 2026 10:26:53 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-93e834ff4d0so1262759985a.3
        for <bpf@vger.kernel.org>; Fri, 09 Oct 2026 03:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791541613; x=1792146413; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HrQRBTmL2QElj1OdIKBi4dLiSjrCHV8ryD7nPGM4RaU=;
        b=KbLi1pSeGc9F8jywFqsragEEErg6QvOiM4biX3yTh1Rw96D/rFXJkHvV+qCee2vW5j
         Go+1v3tEAXgvLgjHOEdsp/nliKcR5BTxTqUXE1U99OITyajhzAxFWnk4KNnu0NYsYh46
         /CDzVKIqHmxDa5aB7W87JY/LTEajlnMICD/KZkn6tpJUERb8CI07CAvfYfq0KslPH+5Y
         m7tWOtdSCM8EtPyAoI+MOsq0BTGgEFgVodnog5EFkDm9ryouSHv/l7SDsNoe8CX64k7d
         rl/6v3lrZnRgKcwi8SSZh73zBwxfpR84oMR9Z5w0d8bEX70i1qiRWMccvGKq2VAMnsCq
         P2rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791541613; x=1792146413;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HrQRBTmL2QElj1OdIKBi4dLiSjrCHV8ryD7nPGM4RaU=;
        b=Bc4yUXePafhRnqkuDNeU1veUUbttshCfgsNkBSbHcibbaz23q26osbPz3Q6aAOaKYh
         eyrF3OOLj97yH0Z4wMe9TbDKWUMB2X1MWrfG2x5/VhTWI+9Hu7ZhV8RT1aFLbVWsS2BI
         ET5A8bb6XWSC3vGZ2eExC87nqwuav9THtf+QNiVKSKftYq9cKx7SHlmCcUzt/ODB+QD4
         Ay4CdyJ525x0OK4rK+/Ir1RntuplCn22UWGcwodTqmzuWk/z5eUWzWYcWKZ2IlNN+18i
         wR/8Jg86tOwl0j5vPDlE8PICfB+s/Va70dDsm7RDBiML/XANaD+NlDoA7ZT8EVSkCxAF
         jUxw==
X-Forwarded-Encrypted: i=1; AKwUvBwSHB0y62Vh6SKuo53P/5hENm5+jBbP+QnmPoIegA/jWwisNWdDn77wkMc+en+MrpPt+MM=@vger.kernel.org
X-Gm-Message-State: AFuF++nwub5dRlbhPaW6kbPBZCoyRgNIvUhmKxYMaC13gbpRVHajGrui
	Vaa7fd5Qt0Z7t1E+PvcnObSAsq1lbRA1Ys6en2bJe9cH6j+glMS1wInd2zi4RZWo/frFdZTA60d
	x1psAjtkIjAol45R5dxe9/zWxhlKWLQLXvi9tAYByjr7ddi9PJeePjdU=
X-Gm-Gg: AYBFou3lqv0sSS9V2xvv8c1nO1HWidcH8JtL+eBgdwuwvh5bVsrU9sMma7bb7QymUUu
	HDmTj1K/m7plEcR+c0Twaq5MXRuyYp7nZeuDyUp7CBuHGWLOsBfFypYc5z5dOUjLiyUbPRqydKK
	YMoVM80RFdGidS9Cj3649OjPWE6IQrXbH5H3Md6ASEA02EReNq68VohkfW2AUgILGjonf5jFVau
	ftVXrUaxSIJESCVXUG8uOgLVQzUDx9LsVmkvxx9rfs7bvTpA/mF8B5+93o6RDDbXgzwhapcsK1P
	aPSeAKdvRc6tFNeNwIoTiuDWRSJUEEheGxInnTY6LbaJ62T42P989CeTdv4CLpXEMJLNf3dwdpO
	GkOX83yKzHiFu4g==
X-Received: by 2002:a05:620a:1b8a:b0:93d:23b3:508e with SMTP id af79cd13be357-93ebd0c08demr190781185a.5.1791541612544;
        Fri, 09 Oct 2026 03:26:52 -0700 (PDT)
X-Received: by 2002:a05:620a:1b8a:b0:93d:23b3:508e with SMTP id af79cd13be357-93ebd0c08demr190777985a.5.1791541612035;
        Fri, 09 Oct 2026 03:26:52 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48db9acf232sm3175313f8f.47.2026.10.09.03.26.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 03:26:51 -0700 (PDT)
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Date: Fri, 09 Oct 2026 12:26:33 +0200
Subject: [PATCH net-next v5 3/3] net: stmmac: allow non-linear xdp_buff in
 XDP mode
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261009-stmmac-rx-mb-v5-3-c38fa4eaa138@oss.qualcomm.com>
References: <20261009-stmmac-rx-mb-v5-0-c38fa4eaa138@oss.qualcomm.com>
In-Reply-To: <20261009-stmmac-rx-mb-v5-0-c38fa4eaa138@oss.qualcomm.com>
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
        Ong Boon Leong <boon.leong.ong@intel.com>
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org,
        Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Authority-Analysis: v=2.4 cv=E+1YNqdl c=1 sm=1 tr=0 ts=6ac8c16d cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=o4XRzpSnRLoaN3dIwwgA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-GUID: m4TIILHrivwbF7GBEamzaYxbuU9bssFS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDA0MSBTYWx0ZWRfXzdAjo6WINlAr
 0LwhCRNrlr/EhkFhMSqRB3QMsmRYUQ59YU6UIn0oFfD8LLKMf0vpNzxUGhswavu2fks7r5S5ak7
 pI1HaGyLSsuSXiYU/6eMUtQ4B+Vb3hkXg6N/o4CooG5SNFUDZikRrz7vrdlxahjlj9MeyOVRBpW
 0tgB6LVCoDl3z6nlyzrz9V+qltvy8L/Wn66dYF99dX4i79PI3WqR4TifLoQamRj/2gQVAtJTtI/
 F21iiU7EJIemtJoQdl3Xwx5Ic3HGngpBFDgFyuy4Q4jZ3xYy/OfaWRe3ysLE7ABexQV6iIzvN54
 Q3S2Xri+LyGHf7eIPzVYDbJwYqukTk63l1pICxi40tHg+/1HkqAOuymM+Xy+zMd7ywB1pmxLugB
 NKElyat5UXp0u1YVZZ+8DzckzZl3SyjAwYf23kNeQ8IVYb/jC5vyfdKyPfLb2LBj2QTo2zpxmDm
 GFgu+LWNh8OdO1vh9RQ==
X-Proofpoint-ORIG-GUID: m4TIILHrivwbF7GBEamzaYxbuU9bssFS
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDA0MSBTYWx0ZWRfX3VMC/YlTSQKH
 0cxLPMyJgwd1grcRHXSHuvXKFT33pNjgt1V2QKSeGlH5d/yvCJL+oloZ51pVBA43BgnJ4WOfp7D
 Bg2xZzeIq05j7F6X3Fowc8QWlxjnewE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-09_03,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 suspectscore=0 malwarescore=0 spamscore=0
 phishscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610090041

Since the RX path now builds multi-buffer xdp_buffs, XDP can operate on
frames bigger than ETH_DATA_LEN (jumbo frames and scatter-gather
frames). Drop the checks that rejected attaching an XDP program when
the MTU is larger than ETH_DATA_LEN, and that refused to increase the
MTU while XDP is enabled.

Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 6 ------
 drivers/net/ethernet/stmicro/stmmac/stmmac_xdp.c  | 8 --------
 2 files changed, 14 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index be2cba8fcbc6..cbeb43011c4b 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -6351,12 +6351,6 @@ static int stmmac_change_mtu(struct net_device *dev, int new_mtu)
 		txfifosz = priv->dma_cap.tx_fifo_size;
 
 	txfifosz /= priv->plat->tx_queues_to_use;
-
-	if (stmmac_xdp_is_enabled(priv) && new_mtu > ETH_DATA_LEN) {
-		netdev_dbg(priv->dev, "Jumbo frames not supported for XDP\n");
-		return -EINVAL;
-	}
-
 	new_mtu = STMMAC_ALIGN(new_mtu);
 
 	/* If condition true, FIFO is too small or MTU too large */
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_xdp.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_xdp.c
index 9af9e0cb366c..f6b3e8628a7c 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_xdp.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_xdp.c
@@ -109,14 +109,6 @@ int stmmac_xdp_set_prog(struct stmmac_priv *priv, struct bpf_prog *prog,
 
 	if_running = netif_running(dev);
 
-	if (prog && dev->mtu > ETH_DATA_LEN) {
-		/* For now, the driver doesn't support XDP functionality with
-		 * jumbo frames so we return error.
-		 */
-		NL_SET_ERR_MSG_MOD(extack, "Jumbo frames not supported");
-		return -EOPNOTSUPP;
-	}
-
 	if (!prog)
 		xdp_features_clear_redirect_target(dev);
 

-- 
2.56.0

