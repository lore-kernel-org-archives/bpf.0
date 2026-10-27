Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793108939;
	b=cmwEGmHHXMqunpX28z/pduTXk9ejdoA0necrEUS9iejJwMszwUCQlU2ixNclOOC27wjS
	 kJEtUVRGcfXCayPmA4VjtKeyc/a6PpTj2aNwEbw+Sr4PE8BWNEvAgwCpUMylGENgbcgcZ
	 6fzskqY4NlFOI/ueLVh7Aj3MXEYpostpkL4Ax/VS8i00uAiPSY4GLTyAv2bPBwTiGW3lK
	 +bqGXllpFR6dU7T9Du2uNEJkAdXrQFXJL1joq0nbj9EsGFk3MM8hxisx+Tt4SpH9DmOez
	 y9eSVoXRaScvqNB6g3x/kwnboQjXUjWeF+OEvSVXUXs/3JY+Zl2GeTu+Gi6iHIDS/sQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793108939;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:
	 Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=gogy6K4mHkApebhkUBNBSa8MX+km/CbZiAD1dzn6BOk=;
	b=zZ9OJt3TKXKhmzVHt1uE1UA0dptap/eB9+HW3SDhodsbUhoU+u644Kdd6WJ3YvwvWQx/
	 /NJwCgrzVONBjcodZBvgXxmvVFVHra8CgCztNMI/32+ZwNEEU13AIF9IIT0Dd/yZ6H2KG
	 9k3Mw3E3GqsgBqGnL7FfuZ7Voa7XUnbWx2yPX1QdE1J3rIfCWayLjpWx9cvRmsd0wKUVx
	 /NZVZyKDuLmX6yImAPTzqegGFMpLlByqRWk3yOq0AiUJ5MLtYzyQjK6gDAQ+0jW5Qu1m4
	 LsnZC4gLsFCx0sZATcG7FLITYmC6Fsw9oSK4JYzZ37fGjtqpHcDmtj2pxY/byC7UkIQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=kendgb81;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=QM3n1G7W;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B982C606A31B
	for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 13:48:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B982C606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=kendgb81;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=QM3n1G7W
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69RAdwNl2458110
	for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 13:48:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=gogy6K4mHkApebhkUBNBSa
	8MX+km/CbZiAD1dzn6BOk=; b=kendgb81mmep/bYskIEz2TaH/+8gari5zUDnUM
	l4OzLDP1YMi6b7/oECUovafhPY44oIAqGpo1CKoOs67WAJOmwDBBdEZr5nS0nXTO
	eNFnjOjCJeMF8ZfmP0bb1vr6NTO2eqDthyejVB44FFpZOmvWcbTdAx9RzX5jL7Yt
	ylPs0o6naSYjurrf/qN9TgiyMqheefsrnXdtg0TuzjEDKW+x/qhqijQgU93hEkr6
	ctgdJVmWHJ6CevI91z9q17KIbT5bsCUHg/ZXnWOChLoRvkhOMKFArWycBlEfjp1J
	7yovPzFx+2MNL8e7fziPZlsa+tNo1QFNl581PJjQST2Epi0w==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hjjbtajj1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 13:48:57 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93ce7a85f04so862393485a.0
        for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 06:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793108937; x=1793713737; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=gogy6K4mHkApebhkUBNBSa8MX+km/CbZiAD1dzn6BOk=;
        b=QM3n1G7Wnk9cxTMv19mswNr2gmEet/0GAbI4im6QSVSRe05637BsEem0E+Dql+/1qM
         klZ5jz6gIMIsLaZbNiieOGTRpDB9sp8fgJ8gCbPMjetOblqTgbVMfMTc00F+Eeh2M0No
         TxcjbIpPejx9btbJ4roo03Dkcn7Uko1pmFGpWDjZGrNXjhUXV8ZQIdy+wkirGNPABHuW
         v7TlFmMFwAIaYlJ2kHS4JWB1HiBqdRVwmSLjQbZEVjfPxTJTe3+Aw0PEwbT6c66F9i66
         KWRYG592nt+79U1ghnCEe7u/9jp5XQmrnWW7/ByqRfARttrtKzlLgMY+HAH01LRv3HMH
         PDxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793108937; x=1793713737;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=gogy6K4mHkApebhkUBNBSa8MX+km/CbZiAD1dzn6BOk=;
        b=jRwT3cITmPXjWf+BDVK6daMiBCK4NcKOwE/Ou1btwxJVze2ggHfs33+GJE6Op+DL0f
         YD2oKkRIwh1j50JW8hVyeSh+fY5Y7z71qP6CMObZZw/QH613FXU7fLDYejni7iRCfI0P
         0uoAHnRL+hklJTikLO20L0REbpdrbESyMoAWwWg7mUqbNwxdKK/Rj6AShZuXPyCwzQdG
         5wQAY/UJHj7+dzSH/GDpg5cK6b0248jQeR7uhLmE2980xqfDG4HTTQQgncT90x7dk89o
         UXHhTeXYLZ8Hi+k4O1/LoPnVu11YcSVI5s4MCPfBHVYIsVFdo+eh2oFo4TYp7QDbS8XL
         yEJg==
X-Forwarded-Encrypted: i=1; AKwUvBz8r15VM1BpwSIi8eSOne2T586kE8OztbPj8a5yHpgDdeyYdrPFFtED8D69D+OikAAncew=@vger.kernel.org
X-Gm-Message-State: AFq9FYLn1xsZyUSIkZyZrH7efTdUt/OdUvYEfEIM9qIKQQ2bIWoUdt/Z
	1hjy2Xq1q8gTtCI+GzQyKRdsng8dklKOZxFIH+DWIifa0xPuUtyM3IpKeTN7GOUwB1st5ecsKSN
	YnIJiGG9usfQHUnpFNnmZZiOyjAW+WZtS2QWO1Kxig+e+93feLnL+eZI=
X-Gm-Gg: AYBFou0qgXKU36Wxf/Tbckpx2XFoCVCE5IAyr/PhLLNs+WKZIOfASWY++0CPA8tGaDV
	HNqwoLQEVDHZyBZ6biaXh+S8uEJUrg7i+JwHxzhpBSJo5zPJb3bq0xuI8mDBM65/XRC39n8EVB1
	szo2trcmgIDz01kzelVCF2Eb12Z7yLZCpDEDwW57UEF7w6cHdxGuJofuGXHOffb2uqF4/UMPWsR
	a3OTo6CXS1Fdvfmds9ub38TtJmS9LILSbm5bHP9xvu7op5zmNn8aI7jYtcKv2lC8KMWiSvEIqul
	yEuWJ9YY3+kmdDyKXcHXVkpT4+InlJXhDQVOdv5E7BUM8J0cT7DIP3WJ1WusW3gO8+sozyU5ZJz
	PCrKw6maZAwQ=
X-Received: by 2002:a05:620a:4150:b0:939:4a44:5f99 with SMTP id af79cd13be357-940ef79eef6mr1574207785a.10.1793108936794;
        Tue, 27 Oct 2026 06:48:56 -0700 (PDT)
X-Received: by 2002:a05:620a:4150:b0:939:4a44:5f99 with SMTP id af79cd13be357-940ef79eef6mr1574201185a.10.1793108936217;
        Tue, 27 Oct 2026 06:48:56 -0700 (PDT)
Received: from localhost ([93.144.6.81])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c46bd7981a7sm455880366b.72.2026.10.27.06.48.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 06:48:54 -0700 (PDT)
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Subject: [PATCH net v2 0/6] net: stmmac: XDP path fixes
Date: Tue, 27 Oct 2026 14:48:35 +0100
Message-Id: <20261027-stmmac-xdp-fixes-v2-0-10eae8a093a8@oss.qualcomm.com>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3WNwQqDMBBEf0X23JUkYsWe+h/FQzSbGmgSm7ViE
 f+9IfdeBmYeM3MAU3LEcKsOSLQ5djFkoy4VTLMOT0Jnsgcl1FUK1SCv3usJd7OgdTsxCqG1ak3
 Xaysh15ZEBeTWAwKtMORwdrzG9C03myzo/+ImUSDZselI9rYdzT0y1++Pfk3R+zoLDOd5/gBnV
 dJLvAAAAA==
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
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Cc: netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        bpf@vger.kernel.org, James Hilliard <james.hilliard1@gmail.com>,
        Nicolai Buchwitz <nb@tipi-net.de>
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDA1NCBTYWx0ZWRfXxcFQQEuUNP/l
 2+hIWCZ9AbNRweiCyELSD28WGx/BGEhqsQDbJDwAA6liJs2Fy4Kbm+pMwWQ/4Z59U7/R6pPBF54
 9FBzuhXNflpOvaQVMPudX7WlIHK5HxA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA1NCBTYWx0ZWRfX4Cke8RKWQ5jX
 37ba6RyamsWY21t9eg6QYr3/XW7pVXsxKPxgLJkKZ//F+G3h0SHxctcZqi5isQPi8ibHp75FMXq
 vlVHPGLGuKVM60O/c18vtYDZYCnpHK9OanaaMSlDU6uIrUhDvjSJUhjgzWFAplEfwZKhkBzbe6f
 y7k8wvPaMyfOIXWekrTOkJbCXuOXkxJ0z1keLsqOnPx8Ab7O6pjSFoyUCS60NC/LD1zZZwGw5bu
 nNeTiglWwPkScKOlnI/Lq60tnbvE3P2pgJwpgnzc0dSX/9fUVSpaWKPsdi1C+RB2O1G0qOBF1a+
 t3DocdJ22c9p6GRlcJYNuXze/OWgDjk7uCjhwpkSjqbRdr56ko0DwYZI/eLEAOKsivzJQKj8GeR
 wbbU3H7O8SpsNtnRkb8nlit3PCNt2e1WH2M3VDaSKsMm3+/zHYDA/s/RtpvcR2I3MAIslwVwzPq
 sChnlG6TxQQpNQGd6hw==
X-Proofpoint-ORIG-GUID: v1-NcGVBSZSRJSGwiIq1niGiru1OAPp0
X-Proofpoint-GUID: v1-NcGVBSZSRJSGwiIq1niGiru1OAPp0
X-Authority-Analysis: v=2.4 cv=XaIcX455 c=1 sm=1 tr=0 ts=6ae0abc9 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=7fYLNvKHbgS61GKHX+yayQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=gDgEgTsMjVfdaljlQWwA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 spamscore=0 bulkscore=0 priorityscore=1501
 clxscore=1015 lowpriorityscore=0 suspectscore=0 impostorscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610270054

This series adds some stmmac XDP preliminary fixes needed to introduce XDP
RX multi-buff support.

---
Changes in v2:
- Rebase on top of net main branch
- Fix commit messages
- In order to avoid possible dirty cache overwrites, sync the full page
  dropping the xdp_buff in stmmac_rx().
- Link to v1: https://lore.kernel.org/r/20261023-stmmac-xdp-fixes-v1-0-efb37e19f5bd@oss.qualcomm.com

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
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 194 ++++++++++++----------
 3 files changed, 112 insertions(+), 86 deletions(-)
---
base-commit: f75062536e2d45ee182828f0e47e0124be2fdc8d
change-id: 20261023-stmmac-xdp-fixes-00aa25d79af1

Best regards,
-- 
Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>

