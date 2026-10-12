Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D38B44A093B
	for <bpf@vger.kernel.org>; Mon, 12 Oct 2026 15:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791818725; cv=none; b=NEzbT8RecLg0fi1S5aB+3pHhLoecrkVLVRW/74bTtyIgBQQOzMlmcJcnJfcEIeTqsxnhJOBSAFkwMCcyc0MPJY1S1TSmH7EHbgKtT031bHzV2q6I/iX7YpFjKsRsh6cN603BbdazG+1JGKk3Af0oFiN5us8N+jcDCOG+G9xhAvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791818725; c=relaxed/simple;
	bh=RYlmXp7AGFVS+ACX+tCb7XN2buLHBYos+Ik4dgl8m/o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iZMPc14w0wOBTiavFgtg7KYmYxB4jcGV4l9SDZzI11CaQD0a2I/aH0Sv3ZOqAxFzNKijDhGGUaE64yzQylzWtbnr+/IfWT7E25L0KCXe4zZEBihWRuNy5bbVakBLj3Rn7o1RjoOdxgBthOXXy1KRIHie5F1CEdb2ImEU5mCKc/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dxwrcQeb; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Qi6hvRoR; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dxwrcQeb";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Qi6hvRoR"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69CC06Jw1933158
	for <bpf@vger.kernel.org>; Mon, 12 Oct 2026 15:25:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	7jqF+qYHICj5HER0svNlKUByr8EgTf60Xnpf6q1p3Hc=; b=dxwrcQebicojW1Xq
	PvOE0VKUDwurCLfgVIQiiiAvDaOwAT6uZLscLJp12Q13kt5w00QoXCQo8sAF9vye
	vq5K1qF/8UY/sU50zGgiEg2soAPpj5g4vo01zdoS5dsdm2GohCjjCTyzu8MirCbi
	Ee3QFV/FCMX9abRkzAUqwK73+zUQfz10TK5vmPuzyRV1DnhET8oVkffRiNtlI7PC
	d2oFa9LMbLl0HYYhIjWIOuVEG1z3U/WOQzMgHC+IDbupdHEDHJ9FkAZs/uwaiKkv
	jxefz+3X14wlRHFW7mv1EXLYhTzRVXX3I+24G3pkt32OfSeGE3qAhcRmI52yuGry
	2kr9zg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h8qtkjvvp-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Mon, 12 Oct 2026 15:25:22 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-53397b6e05aso46156761cf.1
        for <bpf@vger.kernel.org>; Mon, 12 Oct 2026 08:25:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791818722; x=1792423522; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7jqF+qYHICj5HER0svNlKUByr8EgTf60Xnpf6q1p3Hc=;
        b=Qi6hvRoRT27DpeJwT3hcgovRmCSF0rmuRVqS/38V0dlKjFFn6Id1M5OMypgUVOmebZ
         O7OyGgUwUwhqXv/mkJrY/Z8MQTOT3rdGtX1YNNND8ZYywOYr6GEuNFdCwraGpHeCF6w1
         CIuTHosxPVvTWYYOB7xQqt6IFxcfk6AY1gfOGSxJE1deeOMORL8PJOmin2lvcZc5Wo7b
         RlT5SlMZzvhjFwbhZjge453n93nU5bSHDvRUOFM8WBHQTQnWbDkzvxZXCJeZegPTgAxw
         sbNp/sqOXigoljs7KiKIAM+mzI089x+ZRRU0NCkteaT3Vqk5M03/ueHUEsIsbKa/2uMo
         nnMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791818722; x=1792423522;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7jqF+qYHICj5HER0svNlKUByr8EgTf60Xnpf6q1p3Hc=;
        b=jFdluCf5N0YcU74As3xRrrORFhOd42NdlJbMq+ydGjJbCOccaOZQ2MkkxVll4XR2qm
         kufK3XkIP3RxHwSnpSafd9hQupbstHfTSa3lIh2ydcz4ChVckBJ1drp6GLdlVtw3pL0U
         FwR0/D+JLBSZKGYWyv/6GcF+ul1N4808CcMiLOi/HUAyiqGW53hthGrQyl7I6vyWO8b3
         Go6zP6nQ7vFKn3MLm0lxISdPNr4vW/wT9z/MJxLeejcdslTzFkFdYfwAjWW8wVjhpx7N
         dUBQaB1S62NNcpHX7Uz94EVKT8lnsqXai/hjoMHiEgpp02cp0NOTechoTQt9umQ0atVp
         KrTQ==
X-Forwarded-Encrypted: i=1; AKwUvBy4HoqvB+MfcVH+SbQWVs9QK1iZQjwKyFDBltnAtUZN5BaYFjkqqL+onyx0+IHnL2UQXxk=@vger.kernel.org
X-Gm-Message-State: AFq9FYLWUSkDjnTP0LIKsVyXTp7M5M+NIT42rk2uLgFxRA5lFQJSYTto
	TuH8TFVWVkqupe94FCGPWlMf7hQLxbYhYVR/7Rqbi2hvd3MkjF+HX76vIq08ids44eg3Fw9wPAp
	v6+ku4r6lShHR2Fhkd0iY60l1kCSf+HjCnu6NpPoH/yotrHcEeliPHJk=
X-Gm-Gg: AYBFou2FJIsTzozBuyxjWQxjhBQD3E7XNIinpVu63dHiXwIbn+d/CFhxinZSHRSG0Sy
	n7DHcWaUFg7zUePncm3MxN5pbjKyli39FFA4gJrAqzwSGdlQBZtWkG1He8+WhhQ85FVum42y2KQ
	ITkk4OtlcEHoqjfR9G8yUG5kFMb72u4uOvq46Qfgdr3U4CC+iAqiIFcuOl6G7Q6u2XSiq9HTBht
	4sD4S1crY2lsI+H9HgICGRInEgvCk5RdIgCNBv2fOBen1wymrulHqOMRtc/Mj2K5v/MIHjrUxfn
	rd+VaKOTKDuUsF/siGw+jrqG6RfMnWltemGgiTPkK/yLxXU3V7/QDfa/i+tADJdc2G8S0fL8ddU
	HxOKG8YBG8dIXBA==
X-Received: by 2002:a05:620a:2a0f:b0:93b:d7a0:d9e1 with SMTP id af79cd13be357-93ebd2445b1mr1566452785a.59.1791818721629;
        Mon, 12 Oct 2026 08:25:21 -0700 (PDT)
X-Received: by 2002:a05:620a:2a0f:b0:93b:d7a0:d9e1 with SMTP id af79cd13be357-93ebd2445b1mr1566447285a.59.1791818721037;
        Mon, 12 Oct 2026 08:25:21 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a199e5db12sm177527835e9.2.2026.10.12.08.25.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 08:25:20 -0700 (PDT)
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Date: Mon, 12 Oct 2026 17:24:40 +0200
Subject: [PATCH net-next 2/2] net: stmmac: disable TX checksum offload for
 jumbo frames on bugged cores
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261012-stmmac-xdp-tx-pre-fixes-v1-2-05fd0c90f7e1@oss.qualcomm.com>
References: <20261012-stmmac-xdp-tx-pre-fixes-v1-0-05fd0c90f7e1@oss.qualcomm.com>
In-Reply-To: <20261012-stmmac-xdp-tx-pre-fixes-v1-0-05fd0c90f7e1@oss.qualcomm.com>
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
        Ong Boon Leong <boon.leong.ong@intel.com>
Cc: netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        bpf@vger.kernel.org,
        Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDA2MSBTYWx0ZWRfX4fa40m/ZHEeC
 M/wPjJOwzZBTVaqNBFOwPTdgplAECy8Psd2XuOi+NN/u0O+UDlYklmOVUNLXTlvpgzbNOyOIt1y
 C2b9PaIz0R7sA9H6niPGdbv7UE33NkChQsVkbXxyGsXTcBHGzYCTwMSqurFNGUcxvo/TVrnTet4
 BeIQ/GA3Kf4w3W/hv84J6Pp3RmLcORfxXjm9K5II+izV7zE/7IFyoKNGV6y8Jy7ctbXQZspXgA0
 n/FYQgzqqujDldysayPQqF5Q8wCQBHxRcbXYvb5se5ulvfTCLfLpebrk1TT93lPDvrmNKlNyNT0
 8axQPUKpvp4a5UffqDnVrX1LToScNw7+o/NlolvJermMZvb2kItLoheuOqhXArTfKXsu89oJo6C
 hNtmvQTVsa7FdzkvKVuQkCZHWN1YGCVe0kaztYeCE+cck9CzOun6mWOFjIq0rC8PLWT5KbVhgKq
 Yk3bwnwjjtohxL/vwgQ==
X-Authority-Analysis: v=2.4 cv=c8U+0h9l c=1 sm=1 tr=0 ts=6accfbe2 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=IBDDDhxC7lntIW3zH5MA:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDA2MSBTYWx0ZWRfX3DsqpGmwvIyu
 bsvBk5DaenQ4dgj1unhwK9opQfgliBa+dyk0zXS+7gIH4sJTCjTSr7DMDwCSDBTP5w3S+z/2GBk
 m1L84Vry52hGITbmiXtvOLGAV7fRzYw=
X-Proofpoint-ORIG-GUID: ey_Wzw-rrjdImQAzZtwEOPm_Lv48WrOg
X-Proofpoint-GUID: ey_Wzw-rrjdImQAzZtwEOPm_Lv48WrOg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_04,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0
 priorityscore=1501 spamscore=0 impostorscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610120061

stmmac_xdp_xmit_xdpf() decides TX checksum insertion from the queue COE
capability only:

	csum = !priv->plat->tx_queues_cfg[queue].coe_unsupported;

and lets the enhanced descriptor set TX_CIC_FULL accordingly. On the
bugged_jumbo cores (snps,dwmac-3.40a, snps,dwmac-3.610 and
snps,dwmac-3.710) hardware checksum insertion is broken for jumbo
frames; the skb path works around it by clearing NETIF_F_CSUM_MASK in
stmmac_fix_features() when the MTU exceeds ETH_DATA_LEN, so skbs are
never marked CHECKSUM_PARTIAL and no checksum is inserted. The XDP TX
path bypasses that workaround, so once XDP is allowed at MTU >
ETH_DATA_LEN, jumbo frames sent via XDP_TX or redirected into the
device would leave the interface with a full checksum insertion enabled
on those cores - exactly what the workaround is meant to avoid.

Disable checksum insertion for oversized frames on bugged_jumbo cores in
the XDP TX path too.

Fixes: be8b38a722e6 ("net: stmmac: Add support for XDP_TX action")
Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index ca61ab449e32..0e29c5d04714 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -5276,6 +5276,14 @@ static int stmmac_xdp_xmit_xdpf(struct stmmac_priv *priv, int queue,
 		return STMMAC_XDP_CONSUMED;
 	}
 
+	/* Disable TX checksum offload for jumbo frames on cores where
+	 * checksum insertion is broken for oversized frames, matching the
+	 * stmmac_fix_features() workaround used by the skb path.
+	 */
+	if (priv->plat->bugged_jumbo &&
+	    xdp_get_frame_len(xdpf) > ETH_FRAME_LEN)
+		csum = false;
+
 	while (true) {
 		skb_frag_t *frag = i ? &sinfo->frags[i - 1] : NULL;
 		int len = frag ? skb_frag_size(frag) : xdpf->len;

-- 
2.56.0

