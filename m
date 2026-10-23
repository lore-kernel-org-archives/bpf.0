Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792743034;
	b=gifTvH2m3B2TcZaAChDLefZYufMGLbwBQWGUTb6MQHXGEdxiPsHo6m8tGeVMcYaelvHI
	 ZE/A2IK3tQP2Av05M/pe8tFNjjbZG/C92vnGniflu+ZroF+o3mdP4QdLgqIiwSkU6K7Y2
	 /4NLt/kzdrhkRPdRkANoO8NMwJ+aeSROWzW7Ii3TYuqdYZvb6iq+LMKWL3dQ/joXWjzJX
	 oWE8osoTfB2pBmd3HZRXrJYShMxd367OEWja2jGyR3poDrd7hX769HxV7iEkeM8Ul3Xzs
	 Bj/joJc9RHyf0Wdn2FnmpgDTCnqtg/u6jE5zKmdHszd9yp7aavcOcO8gGYw7cjDlomg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792743034;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:
	 Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=Q9T5DRA+uqKDqTbkysqot+G2nwnmqz/LaQ5soZeW3wY=;
	b=r05IOO9MzkZPZXCZviYh5ek+pyf9g0QUsS5UcYJtgAP4CSAmekVfinwjRDOdpHIHFiML
	 ee78Vh5SzlH5JIn44kOpGWMujoDOohoIsYefLsxa954PvVR4VC3+RRnFJmrhANgHE5xXB
	 TOlKmjTQo24LmMAbMY8JilwMhFnGN3bnTsR42jN9EfjFSsmnQux+xdB2XZMu+S6reYjPM
	 UKhOGhkZiz9SwSX7CheDm6HDnet9idEg4CiS84zpHZwDOA0ncoGSTuhbHzBBwvxvkcRgv
	 82dkQ6md/QQw4NZpaVzfeyFJ+kEe7WoF4duiWTXIK7pzoM4N5CGGoKVYAJzRaIYM+JA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=lfPHrcTZ;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b="aWkhlb/k";
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AACE606A31D
	for <bpf@vger.kernel.org>; Fri, 23 Oct 2026 08:10:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5AACE606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=lfPHrcTZ;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=aWkhlb/k
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69N7F9se2067840
	for <bpf@vger.kernel.org>; Fri, 23 Oct 2026 08:10:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=Q9T5DRA+uqKDqTbkysqot+
	G2nwnmqz/LaQ5soZeW3wY=; b=lfPHrcTZPHwciuX5vPf4BM7XSbx201qyWTBi2d
	z4jrdP4O0O7Ntljn+qE8jlcT/vQBLD/EHCRFGit4tuXVURK7xpV6v/Kq+4fAnAJ1
	Ar9Gu7h7tdhSMbxibwJmNDqtqDcBUJmVFv7pEdOfH+Rcy10dmUi1+QHKNeeSYSB5
	Og3j5vVXfGms9RhUje8+7aO6Q/5GLUghS3PupICCmHgOxfr7XOntrK1kRpWUd5FP
	QsN3uCPYa9oDueb6CoPEkCO0DGycdggUIjKo9qOvh1pU0+h9QEpazr53T8dRLROC
	k9U9M+UnbIEr1MHBXjttMi4DQsuYPaxvyQzlj+8FKoPi15jQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfnyw35jy-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Fri, 23 Oct 2026 08:10:33 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-93cb7f9bb86so105446885a.2
        for <bpf@vger.kernel.org>; Fri, 23 Oct 2026 01:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792743033; x=1793347833; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Q9T5DRA+uqKDqTbkysqot+G2nwnmqz/LaQ5soZeW3wY=;
        b=aWkhlb/kJb+tHG+NSATZ1uHrZQPnTi6OwuZDhxnhLC6DXMwWkL5t9AimgipsTQ6yfj
         Aj0RtajxCvUpmoAokevUS3s9CtzXUf8+CBWJzYVcT/Ng92voHhDUFW7IKou5BcW1yXLa
         tV1RStrEucbjJGsW3kfAxG5fXCv4jlpHkP196lQdmYKYuSkaNmNDLAqR5BcfA7A3vbj3
         nGIrChSMwmVww46XB6R1emBoBKDj94r7sh7UCEOjmwQXKiq3wFtasDV8V7Zkw4gIoVkm
         3z+232B/0u/bW7t2wPQhHDMNX6kNsYTziHzhMGsrDOC0ymARuVtcK0kfZHorBkgrOGGz
         WocA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792743033; x=1793347833;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Q9T5DRA+uqKDqTbkysqot+G2nwnmqz/LaQ5soZeW3wY=;
        b=HbqaTh3Hulvsq3oCbITuCe6l9U6cL3JKgT4Gj8zzrV08RHTyIylQnHYb8ZxyCHNI1A
         qQeD9e2zplqAQzUAl5zhWEdwT6IohEQjukShqXom0NA31TLbRGzeQ4wLrOwDf2GK74vb
         YgUR2rx1NnyPWb7SJR+1eWKhmJzZWIb3Tm/XthFz/Oq0pboFlR/UDIQEZVGnecas2++R
         fyFwMP97NRcnfK0XzKCbCnPHke0ntnwcucsuuFBvMvQgY4w9fwMTbPLfWLQkJe5xe0vA
         zR/LblQk4ghsoJj2FbX+BqMGmra8Zk0nlnHwuZNNqPxR2khab2kbHykRTMd5943NP/qj
         E+sg==
X-Forwarded-Encrypted: i=1; AKwUvBzmV4ld2YHdBXVRpVahnp+gl+0TgEduAeeRgG1J6tRbxnOYUeAge03chXzJMY7fDQAZ67Y=@vger.kernel.org
X-Gm-Message-State: AFq9FYKzJclEKU5MF4zrXa4jF40TN4yYxoKh4wcRtdKWimBkiT7DsgBH
	5bx6/Y8+V80v6kRgXxK/rifhqPPl1zVahnVADjeLh/UQDNHz/DlYo9xS14/vqE23T2ncoX17fwV
	To0QOSnx2h+bsuhV/Wy5+u7sJibZoRIHlsSda27LxC541azpWd/ep2gA=
X-Gm-Gg: AYBFou0x/Sd4oBUqHlM3U3m9N5N4DKqslAExKBQrC/Z/I+FGnrnNeTgInwUvv9KnXLX
	8mFgWtEHKPJZajb0XK9OCVGPueh5eWEyOVahqZ3ZbhrxssLyvXw4GUrygjMoQlcZBfQO5zacMUw
	kq1IuIrWdRCpRXHZ1IFmBEyQSFh0e4a9avPr4b18MrXI18sJttGmqyelNXpIdfnTozt0p2kDrAS
	Jc66upPo2Qkm/Qd5KdOmze8ddgo8adet20ea/lU4BTUzbbKO+semACXDrEhfGydIqnHbjIy4S0L
	INhOUICXcG63M2eEbAIRlrODCICWS0L74x4Hl87P7mmAM08zS2sWUtpO3GoLhm8XNIZO1kDAxLx
	96FCSwOZJSRg=
X-Received: by 2002:a05:620a:3188:b0:93b:d7a0:d9e6 with SMTP id af79cd13be357-93f6f80685fmr302987085a.64.1792743032570;
        Fri, 23 Oct 2026 01:10:32 -0700 (PDT)
X-Received: by 2002:a05:620a:3188:b0:93b:d7a0:d9e6 with SMTP id af79cd13be357-93f6f80685fmr302985685a.64.1792743032087;
        Fri, 23 Oct 2026 01:10:32 -0700 (PDT)
Received: from localhost ([93.144.6.81])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a2153c1b7csm18523725e9.1.2026.10.23.01.10.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 01:10:31 -0700 (PDT)
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Subject: [PATCH net 0/6] net: stmmac: XDP path fixes
Date: Fri, 23 Oct 2026 10:09:52 +0200
Message-Id: <20261023-stmmac-xdp-fixes-v1-0-efb37e19f5bd@oss.qualcomm.com>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3LMQqAMAxA0atIZgNtRUWvIg7BpprBKo2IIL27x
 fHx+S8oJ2GFsXoh8S0qRyywdQXLRnFlFF8MzrjOGtegXvtOCz7+xCAPKxpD5FrfDxQslO1M/Id
 yTRD5gjnnD+NFBfxnAAAA
X-Change-ID: 20261023-stmmac-xdp-fixes-00aa25d79af1
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
        bpf@vger.kernel.org, James Hilliard <james.hilliard1@gmail.com>,
        Nicolai Buchwitz <nb@tipi-net.de>,
        Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-GUID: FCJCkzCXI5JrYBh6Gnj5kaLgvwPq5WGU
X-Proofpoint-ORIG-GUID: FCJCkzCXI5JrYBh6Gnj5kaLgvwPq5WGU
X-Authority-Analysis: v=2.4 cv=dphOmFg4 c=1 sm=1 tr=0 ts=6adb1679 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=7fYLNvKHbgS61GKHX+yayQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=mZfc6SlRgOl0Hnr-beQA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDAzMiBTYWx0ZWRfX90oxIqhXUFYt
 DFwQzw4dJImYLuF4JXg/kc/l8K52DMXcvfZB68Ek5y8CNcBVJnqo2amlwPbt1F/C0JGNUn7/L3C
 JgH8PqfBBLbkpb2Ex1Ycmr31rjn30WM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDAzMiBTYWx0ZWRfX4Lz7fu/4Exzj
 aIMUvkZsTNjMf7eKZDh2CIPIdnDPbBoH660QxYxt98s8f7rP/UfIEt8ogerpP5p1/y6kyoqlFMr
 Qta+5QKCzw9EMcj2wqHd5PfdpCb8SIz6lUzfixGNHKZcwYxbNCdn58eCMwVXutlzb6+4FL0QU+o
 NLt5SHTSQoPRV9va98ZkYFynr7dxq1/IbFJZcuF30S+hLDrRummcI4tv3w00+q/Evlfj0ksOGU7
 uGvaWPhW4Lm8/u/xHTU02CrzpDoPeOd9y1VOx074ZGo0DVOg8Wg5mnjRt0Vd5de5QUFWIFjx9t3
 vF3lL+7y7QMhYgAajKK+zm/Df2KXvUtQEkG+ZP/DfX0UvrBu1ODuOKciGz95Ojalr8n7Ne1voSg
 FUoONNS3VvgzqAOoaco09CX+hXdEV7C15Omb0ZNghLfmpaVqSLjXhf6NBPMQODtY19DZG2uMtfu
 /37HmwbYkywGW0Jdd4A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 clxscore=1015 impostorscore=0 adultscore=0
 lowpriorityscore=0 priorityscore=1501 suspectscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610230032

This series adds some stmmac XDP preliminary fixes needed to introduce XDP
RX multi-buff support.

---
James Hilliard (1):
      net: stmmac: take ownership of saved RX state at poll entry

Lorenzo Bianconi (5):
      net: stmmac: drop split frames on AF_XDP zero-copy RX
      net: stmmac: drop multi-buffer frames in XDP mode
      net: stmmac: copy XDP metadata in AF_XDP zero-copy RX
      net: stmmac: fix VLAN tag stripping on short and non-linear RX frames
      net: stmmac: fix XDP RX buffer DMA sync length

 drivers/net/ethernet/stmicro/stmmac/enh_desc.c    |   2 +-
 drivers/net/ethernet/stmicro/stmmac/norm_desc.c   |   2 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 183 +++++++++++++---------
 3 files changed, 112 insertions(+), 75 deletions(-)
---
base-commit: 734bef548a96e8774d6eef5dfa2026c6edc4e80b
change-id: 20261023-stmmac-xdp-fixes-00aa25d79af1

Best regards,
-- 
Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>

