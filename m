Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D49E36F419
	for <bpf@vger.kernel.org>; Wed,  2 Sep 2026 20:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788380205; cv=none; b=FO7swZDVEq9iNDyIgav8sgpoOk1nvAkwyimMG/x2YhpPRWgrEJtn1PkmyXjbBaENrSH7GSG/R24oEAM+9IEEd7hgghcH9RrETEp2IbvNp8o7YnQaBG/AGG7daZnavAiLbE6YLseK1LQMXpjTK55gHN5s51UJ7XOwP8mfRCrlOLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788380205; c=relaxed/simple;
	bh=J191DXr3WXOGR/U7ebzX6eaD/s+SxbIu1DtP7dXuruQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=bbEzsLRrpWxNti5YxqlDiT3i6E0LiBhKytV4Vf+37bdu0JN4qqYhnniAZnl8Pvh6ziXStrMcpoD0Jap1Q5Wj45RFI93fanDOG3tP7fTsQj1nT0CzDfoCbJcHYX/TMiMpQnI37Y99UCJ6SqKjWHHxB+N8lhAsuv6CudPza8k3dXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=eKIqNL8z; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=gFahedN5; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="eKIqNL8z";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gFahedN5"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 682Hqtor1586094
	for <bpf@vger.kernel.org>; Wed, 2 Sep 2026 20:16:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=5ltGb5qxPvD3jFiEXdQhEA
	pOI6vDeU/ug2xf9ZQ5zRw=; b=eKIqNL8zw812M4XVaezWsTyGhGKXMfrRbULuqs
	STB+uGQF2UySTlmKjIkk2LEuaZcYiG7DaAqzWXPua8qQYe8dyQZIXxclFHBkK3kk
	Jr0RbVJx/gqW8In4Yc+c/PFjBmP2ixnl+CXA6d4Np+dp4S128jEW7qGihNdj42Fh
	dIjB5U77mofw8VKqbO5RO6FRHvERVQVFZ2bPbI/hEzastUGynIXIDkUOJV+zVTOD
	j+T9X6MtWmCswsa4/oXA/YwMXwio3BaQk0D9GM1uEA/6ggof63uPjb+adnN3Xcla
	EsM+VSTpjfjosu7eMkWNC0LlSk8Qn12Dc0zqvCra2xwsimJQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gemb01wep-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Wed, 02 Sep 2026 20:16:43 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-938153538caso311900285a.1
        for <bpf@vger.kernel.org>; Wed, 02 Sep 2026 13:16:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788380202; x=1788985002; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=5ltGb5qxPvD3jFiEXdQhEApOI6vDeU/ug2xf9ZQ5zRw=;
        b=gFahedN5i4lnVDlBCi6vQpdVH9Xvf9hetWs2osOQFpY7Guptamh10lc2adgddmdORC
         Eua9NRD/Et4/pyFOFrkifRL5UfLKnK1+TcW0/ltR9e3wWNcVejONBUmVAg6plEx4hELi
         SzkbpQgPIqCtx/fpfnPs3xnKyzv3OxL3oCaPL4NS+D72tBaHQ2rRnemId9OLDiumnQUc
         k2gMZNam2UquOF3rUyS+/r+V2oGrD4IZCmttrOuUdTHShMt7ezz7daCpWFc/BdNUD2kV
         KwoE7PEfPC0c2eHrGk43i4YQNy2fSis4YzHKbjh/HdgFgAu/8ubQJIlMygbuS9lY6Yu8
         w7gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788380202; x=1788985002;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=5ltGb5qxPvD3jFiEXdQhEApOI6vDeU/ug2xf9ZQ5zRw=;
        b=PsnfzyVooxoTbwq623EVm77NkXJu22bI2/OI8fI50S8dzJW9DpwQHYq77RIzJZNanR
         wSb7QsUWmVXZi/U6DkbEZhrSPiMPzB7N8pkEsImDoCWl3lmsAWxO3etlzDb6EmaJwzJK
         YK/VyPTC/xVe1tfBd3MGuZeKtVLtaDFJKugCecCcZZyPlkxE4Hny2Ha9I97zkXtpdr7i
         vaLXYguNU7W9pkWIFuqHuhGR07IU+oW4JkP6rHmcF+U3uZk076OVjGOWXbFQypybfyER
         FigAd32gFblvjTUzJCF5MQTX9FAtw30u9Xohocs3a0VOdzJaaCR3db6wvgDdtuEanoeI
         4orQ==
X-Forwarded-Encrypted: i=1; AKwUvBxKWeeJoMHekE5o87P6XqH1NY15PPkpBeORL3oQJJ5lwLAoHg4yHTWH8elvM4PLZbR+/WM=@vger.kernel.org
X-Gm-Message-State: AFuF++m9Z9mNhG9nqzJOPMXKX1qzMhMc4f4TuEdP4D5tzGxZOl+Gzm96
	g2ZC6ccHOjKL8Me2ZBMq3IGo+kgpCzuM/EsHVi0xtPSZWf4gpLRYFsfoC8C6xw+vLbwTlRr004Y
	20ybSba1kGocvwRfKrsKS2dvBEUndK2QuH2UQ9LRdFmFMuvJoVyBGRdQ=
X-Gm-Gg: AYBFou2k6EXdc5oGsAuhNj7M7T2fUzxBRT10RipvZqWnQajipwy7c59147vNLk9wYqx
	TYfrLxKujze3j2YvhY8EEAG7IelR/v1l+/9FXLska7EuFtmL8KvymKFHeXZeUFYghMSbuVZqOGs
	zNhi8GLs9Utj2R9x7jdxOCwCGTW9I4qiFdsd85OMIJRZxP1o7FqzCfRu+/BXxfVJM8vvtua4eSW
	1wz6ELKShPiJKaS9aIASgnEH1cXJdKy6Xj6z53VqS6LbJK+zdVQEZ/1+ZKFT8GHVimS5WqqTJoN
	zfodTNZZxpr3iYQg3sZ0FSX5WGwEDWPyDHzqJuAEnf4XyuJxFYi0nW4tKc+Inl9YATw832TDAv2
	Fd1v7wlBLmdvgGQ==
X-Received: by 2002:a05:620a:a80b:b0:930:a26a:fb2a with SMTP id af79cd13be357-93960cb8422mr878376485a.2.1788380202237;
        Wed, 02 Sep 2026 13:16:42 -0700 (PDT)
X-Received: by 2002:a05:620a:a80b:b0:930:a26a:fb2a with SMTP id af79cd13be357-93960cb8422mr878371285a.2.1788380201749;
        Wed, 02 Sep 2026 13:16:41 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48448eea961sm8577632f8f.28.2026.09.02.13.16.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 13:16:40 -0700 (PDT)
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Subject: [PATCH net v3 0/4] net: stmmac: re-apply taprio offload in
 __stmmac_open() and stmmac_resume()
Date: Wed, 02 Sep 2026 22:15:40 +0200
Message-Id: <20260902-stmmac-est-reapply-after-open-v3-0-e72a6df5a7ef@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4XNywqDMBAF0F+RrDtiYuOjq/5H6SLGsQbMo0kqF
 fHfG6SLLgpuBu5cOHclAb3CQC7ZSjzOKihrUihPGZGjMA8E1adMWMGqomFnCFFrIQFDBI/CuWk
 BMUT0YB0aoA3t60JQjl1FkuE8Duq9+zdiMJJ7eo4qROuXfXOme/Xl+QE/U6DQD6Ip6pJj2rnaE
 PLnS0zSap2nsw/M7Bdtj1CWUI5cyo42HFv2B9227QNL3Ub7KwEAAA==
X-Change-ID: 20260824-stmmac-est-reapply-after-open-181d70a15eb6
To: Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Jose Abreu <Jose.Abreu@synopsys.com>,
        Rayagond Kokatanur <rayagond@vayavyalabs.com>,
        Thierry Reding <treding@nvidia.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Stanislav Fomichev <sdf@fomichev.me>
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org,
        Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-ORIG-GUID: SDYm48paQE_UXatn6oBNNUlci2XvhZdW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDE3OSBTYWx0ZWRfX1kG8TcdRw5yu
 yF0IovayVQSTP5U9cUNkpVPeXyj+uSSDFBP9/vf3GyCTQ/2otmshXZe/NseXOYTePIzoM13bgMA
 b4vE5VmYEFbtjwLGBrewS8I9ABoQq7h1N6gtbgGzhXZUdfgR7wDAV8PRFCXqqQW9BtHUAszlAte
 7Op/JismXtzsIesAc4TY4oDRGdP1Lmx/09dYB/+glCU5cLPyzhjMC/UeBbKUj+VA4YkT2ftYV1m
 qmPxhsUdWS7Ejbt4v2nrNi2y8zVR1ZvJbsnWz71zzBzAIlZELtAqll6XFFYXbQT1HpBbTnaXcsz
 7xtLtu8SsHvdDth49rZlG5n9/40ZL+wWB9LJNIJcozAHR/mrw6H20yYAbmQXSnVYxBDU+GVKgdB
 PWcPV29sB2QtUF4GZMTl6fB6v3/968gVgvG7sy9tp76UAP2L76tqzhAiOpKpqXp5qVGMG34cJmK
 qGyGmRSWYAGkUcH11jQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDE3OSBTYWx0ZWRfX5sPihsKfBluR
 pekEav/YtMyNamqaAd1JCezcbYFHGQw/XBb3slXcRz/ZqOWLZt3JfJtzkOylgxdzZckBM0onR5A
 zgFyWqf1M+UH6/adNMcAynytidQmrh4=
X-Authority-Analysis: v=2.4 cv=EuPiaycA c=1 sm=1 tr=0 ts=6a98842b cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=98BwIGCMshqbzBBwbswA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-GUID: SDYm48paQE_UXatn6oBNNUlci2XvhZdW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-02_04,2026-09-02_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 adultscore=0 clxscore=1015 spamscore=0
 malwarescore=0 suspectscore=0 priorityscore=1501 lowpriorityscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609020179


---
Changes in v3:
- Guard priv->est.enable update using est_lock mutex.
- Embed stmmac_est in stmmac_priv struct.
- Rework locking in tc_taprio_configure().
- Fix possible divided by zero crash in tc_taprio_configure().
- Add missing reconfiguration during stmmac_resume().
- Honor ptp error code in __stmmac_open() and stmmac_resume().
- Link to v2: https://lore.kernel.org/r/20260829-stmmac-est-reapply-after-open-v2-1-5e5ccb185e92@oss.qualcomm.com

Changes in v2:
- Rename stmmac_est_reconfigure() in stmmac_setup_est().
- Rely on stmmac_setup_est() in tc_taprio_configure().
- Link to v1: https://lore.kernel.org/r/20260825-stmmac-est-reapply-after-open-v1-1-dfa80735e0a1@oss.qualcomm.com

---
Lorenzo Bianconi (4):
      net: stmmac: propagate PTP init failures in stmmac_setup_ptp()
      net: stmmac: embed struct stmmac_est in stmmac_priv struct
      net: stmmac: pass the desired EST enable state to est_configure()
      net: stmmac: re-apply taprio offload in __stmmac_open() and stmmac_resume()

 drivers/net/ethernet/stmicro/stmmac/hwif.h        |   2 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac.h      |   2 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_est.c  |  36 +++++-
 drivers/net/ethernet/stmicro/stmmac/stmmac_est.h  |  13 +++
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c |  76 ++++++++----
 drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c  |  41 ++-----
 drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c   | 134 +++++++++++-----------
 7 files changed, 176 insertions(+), 128 deletions(-)
---
base-commit: f695390ea63941a9e412bf1f3afe65ab245fc681
change-id: 20260824-stmmac-est-reapply-after-open-181d70a15eb6

Best regards,
-- 
Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>

