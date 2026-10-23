Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792743052;
	b=BQM3S7JxPILJ4xxV5Fv67zcd8kCmqR4xs6ic4LTish3T7Jf5ohIHCMXOmk1fRMa39VKH
	 QWqm6ob41HdAx9Tk0FbSQb9rdFF14b2RGnveX1z3FrLgHqhI9zjAHvNOot1f0y9kIsz86
	 98ld7hygyi9rsVO4+IZSRWYcW00hpwCgeetx9ZOtRReg+uovMQ/SOmd/GWTqg39E6GgC4
	 ZrkaRGg81tl5pLAu/ebkFsnhzdZzToOkAk/m3qbQqMnPbLrD9kRAS2pV2Cs38hbP8JonS
	 vt2vJ2xN0tmiMoDPkZGCDEO6hwKgtbqwqugmBFSKJrJ2xC1rcuukT3aE6YP3ZAAB5mA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792743052;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=TZNgKdjNJ7/V7yrbPxsuyxt2ZkRELxHfzEqCxp/307Y=;
	b=GmbbVhjOoNMDPO5NoYZAeVxd0//aoGV7wk7e0qdl2ts/nZNv6qGioh3WOkVC7zhgCNIz
	 ToabjC77p/R8UWeNuWFiCLi1l2TPMaTexcuFPib7ASs1qy601+herFmomqRs8UNmaLORs
	 ygTod6RNN4/X2Eb1cehDyqsPfET8rYtmpYjzAHjeT+9dJYtpsXKhcYyDbbmxqAJMIQhBI
	 me3UyDu64Xvv/jJIh6gHHARv9d6kM5S45Qc6QZ8BKRaQcpupSTywfHUnIyJEyMWrLhirl
	 /e1zBx8R9FGooXfiLyqsO+WlSNpiZSlqVWszKzOEVXY6UKJGlpW41bwYcoP7iu1j2EQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=hQ19wM3z;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=gQxUCvSG;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8980960A260A
	for <bpf@vger.kernel.org>; Fri, 23 Oct 2026 08:10:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8980960A260A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=hQ19wM3z;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=gQxUCvSG
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69N7F9kU2067801
	for <bpf@vger.kernel.org>; Fri, 23 Oct 2026 08:10:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	TZNgKdjNJ7/V7yrbPxsuyxt2ZkRELxHfzEqCxp/307Y=; b=hQ19wM3zGfqTPoWh
	uxfUM4Wed00n8ocdmOx/GrKbM0W/dI5hem5jEsguz5O5hQEcM8OQLKZ00e/W7YoC
	c2vYstw96n9tx4IwSYzEnJHcbOCj79hhQBRagZZYFCVO9+XG/D/liRAeMyu4Cqxv
	h0IU9MNGutL/3OWO6dFzjuwfIbNyTNC+zv/8QvhG27a43zG4i+yc8HNcbiOWbG9u
	77YATjnXDbCS3JQUjnlnwet/EnTuFBmpBF8thMiR66l6Kqels3XV4w5ge9zr/onm
	zsKaA/c8ErHEsUQf9po2LrBAUIGy1qnEo+DXDfnz9k2pR5eFUBgaU5sgSdz5P7QN
	8/CQEA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfnyw35kt-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Fri, 23 Oct 2026 08:10:40 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-93f20addba1so120120785a.1
        for <bpf@vger.kernel.org>; Fri, 23 Oct 2026 01:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792743040; x=1793347840; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TZNgKdjNJ7/V7yrbPxsuyxt2ZkRELxHfzEqCxp/307Y=;
        b=gQxUCvSGiZHFs633Q11eCp52g6sxC91EwQHhnp3mKThg7Txyy1ZOPcXc89iCU9CDdF
         idPel4wyOTiTtJJD3VdgYeiIbkqW+DSTC1WKLmzkuaC6ZrEifWwd5X08h2Nh3abN5xsj
         2KGoiwcfnB9vE5bF969LnoJ0JkLeJeGvxE3mBTFiKEz/Jkx714K12MRHQ9MQqcTQ3kbr
         /B3secLPDn6sHjiuaPsMbWmitMJ2OcQlJ1+Un23ImXr+iA9EVeSykSB7SZsdpp/Kyal/
         4U7qBRx2xQmy69/3qAHA3lChQZUOcvkKO/1rmDQi1TYHjwFBxTCUUGSBdV6BI47aFZgI
         wH/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792743040; x=1793347840;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TZNgKdjNJ7/V7yrbPxsuyxt2ZkRELxHfzEqCxp/307Y=;
        b=yEEVbdextoZrNvqW4kUqKCJIl+UPZ2VUk09Xaszudc7tQdGHPoOSueRicUOHFi4CUT
         gGhXs6Ieo15zxFCDr55RhYcc3RBoLeuaVBrintQGm++ng1mWG6A+7tOaqqs/xk86arho
         1tKZv9LGdteuURMgmODHay4DuwxODh8awitsipa+M+ud7TMoyhbkqTB3//fzhwfi3eq1
         16wVBG+3mb2vEc9WeoLubdeGWyZgnyLij74+ivJuKlFncIKmEeXn1oqANaEQ38PSNYCC
         qEYM1mX3L/8ykLFjaSeApmww1QLyxBcLhQreJWpvyZHIW6lu+kCc/Ffp2uZfPcWvMeGZ
         Nr8g==
X-Forwarded-Encrypted: i=1; AKwUvBxS8rxRuuYTVlcc00daiW/iDDjf4Oy3ToQD2qXURTFdvh/NA1GxoKEkXrJn+2JW1wQ6Ax4=@vger.kernel.org
X-Gm-Message-State: AFq9FYL7GGZDzotCJa4PyIRIjzBMFhSY0jT3OAoZtn7XNzfFz5p0Tb/b
	KZLSBjfaF2Vd211Selm+d7zyavkXRCnoejIA/PSQGebC1v7LPxZvUANDVVFSPCtV9TmFz8L0TZ6
	116zLspY0V/RAyfMSmobY7BGd60T95fybmKQ55g9qen4f3iA+iAVYG0A=
X-Gm-Gg: AYBFou1JmdMSC+vVQtEMJleU7nvP+oRwfXhpy3/0G/qkVQ5/yGtE6HQmLsvoCOYwgsg
	2bBFEfqEtr5Z7f3RQOeVq7iiw08ruBou+zguYTUXnE68O101UT/+SJTlPghyQ0ayJFmThk9X7pD
	wVbYJkwTAi1Np/tP6ArC2rh4UfBzU8Hst55eMVvweLVpPNnPo3pEMsUHIe8G9ex5POA7yJlTnwQ
	aSL0fW4m5QpF4LWTmWzjktOzyb0yAq1S5Asl1tU2L7nb23K+Wg/8kjnrAMTx1Ku0K9A+jNu9v4Y
	715T8QAtoA4V4FaLMZGERS06SFJvqxTYkv3pA9/bWB1n55bpT+dMYD/ZpEp8KbhfumZYtvvP6EQ
	OpPWJntyfuzx+QmKsD/X52A/1wxd/ZFbmH9EY0UUYn296Ea6i
X-Received: by 2002:a05:620a:1a24:b0:939:7fc4:fb1a with SMTP id af79cd13be357-93f6f7dc7bdmr308620485a.27.1792743039821;
        Fri, 23 Oct 2026 01:10:39 -0700 (PDT)
X-Received: by 2002:a05:620a:1a24:b0:939:7fc4:fb1a with SMTP id af79cd13be357-93f6f7dc7bdmr308616785a.27.1792743039278;
        Fri, 23 Oct 2026 01:10:39 -0700 (PDT)
Received: from localhost (net-93-144-6-81.cust.dsl.teletu.it. [93.144.6.81])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e37edfb3fsm3871572f8f.8.2026.10.23.01.10.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 01:10:38 -0700 (PDT)
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Date: Fri, 23 Oct 2026 10:09:56 +0200
Subject: [PATCH net 4/6] net: stmmac: copy XDP metadata in AF_XDP zero-copy
 RX
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
Message-Id: <20261023-stmmac-xdp-fixes-v1-4-efb37e19f5bd@oss.qualcomm.com>
References: <20261023-stmmac-xdp-fixes-v1-0-efb37e19f5bd@oss.qualcomm.com>
In-Reply-To: <20261023-stmmac-xdp-fixes-v1-0-efb37e19f5bd@oss.qualcomm.com>
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
        Oleksij Rempel <o.rempel@pengutronix.de>
Cc: netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        bpf@vger.kernel.org,
        Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-GUID: eqsQ32FFJ8GtxuboKPqGMjGTsm4CWKZY
X-Proofpoint-ORIG-GUID: eqsQ32FFJ8GtxuboKPqGMjGTsm4CWKZY
X-Authority-Analysis: v=2.4 cv=dphOmFg4 c=1 sm=1 tr=0 ts=6adb1680 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=7fYLNvKHbgS61GKHX+yayQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=9RzD3mWewD2guqUcLtsA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDAzMiBTYWx0ZWRfXyAWz+pIlvVDi
 VjD7CNdo7RE6AwuuirsgSM3GA0MxwM99x9GzvLttnuOmLQ6r+AkvQPj3u9bFum4EuHfEWcTY8tp
 vrQgoPjjQO51WOSgmKjsvWJSh2CYBhI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDAzMiBTYWx0ZWRfX+FW5OrUNiJ/y
 V7KeB13W1Ra9pFEsogMt+AAhswrIfmXKdnEmRGgX9tHNjQt7c/9MHlyPwcxs44rjfM0C+62tiZf
 sXmwWkXrOj4VEYYbOLb8NkFzlENT5uH6xcPNrHLJHOp56NrjkOGlUiA4so5TDr2+sPkXfUwzPI3
 S6J976I/zUI2JDyxirnJ6hEHSwrivuoY0a/PNZzMJNFeiqyz2Tc5tFLNfY+oSHMq0c2C+KvgAES
 pFP/QSZL75H2xFeS60fLU4Tao+biuUK4rS/RQGCGqk6d/CHqkbZrgBwS/5mrQUm51Cqha7KMXlz
 XelW4klTDqyiy3vinWOfInn2jpIYrbxbV6e+NmF+ueYX5Rs5UOAC21m4Gsht19yRE8FfKirCrJv
 DztRkD5PZuARJtKC3I3ijT555ONExSpANpC46N3YYYCebpkJPy76Um4ZOXdbMsjQDpdEmxmHQkW
 63vN9JBO97NMO00FsAQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 clxscore=1015 impostorscore=0 adultscore=0
 lowpriorityscore=0 priorityscore=1501 suspectscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610230032

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
data_meta valid for the stack and TC BPF, and keeps the metadata aligned
when stmmac_rx_vlan() relocates it with the MAC header while stripping a
tag.

Fixes: bba2556efad6 ("net: stmmac: Enable RX via AF_XDP zero-copy")
Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 30a2774d722b..8a2faf50d695 100644
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

