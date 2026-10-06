Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE2A538642A
	for <bpf@vger.kernel.org>; Tue,  6 Oct 2026 10:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791280978; cv=none; b=OEw1CJhO51fp61ZsujZDdbNXSXVEgBjwFSUNuflUwLSYlwo4oJRmH+pdBZTAQYSUL4vuZbRtm/6psDOxD1aygAR1yJcFv41Z2KVrvrggdx0MwDn+xyAk2m0nU6zCgKEd/FJtbDidpzXFguD2yOpFCPvFXTtp1n1MnpuKm+9gS2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791280978; c=relaxed/simple;
	bh=2X+SJ2oaW0+RgIAxsjRii8FypRIhmvfsktQS98iPTQU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=rp9/H0cNLKvCwD9XRW0vm/I3ZrtKXY+bGA5sr7hVDerU4PK63eN0i+Fu3J5vJHrlXoHMd7wdxWGjn7ad9EXl6Qpum1u8oME/DJ4ronCyLlTNGmfi8mTKZZ7vdjwQKSGmhQVV4yVwjeF+nXImvBEMtTzqruxCYnItFfJabFyHVIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=V58utDWl; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=GMZ0vaze; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="V58utDWl";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GMZ0vaze"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6969UPuD084378
	for <bpf@vger.kernel.org>; Tue, 6 Oct 2026 10:02:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=y3bDkdlPgoyDZs/us+RW5I
	FOVL2T8UGRn5OXKbHaJfY=; b=V58utDWlwe/PemSqpco7YKyWAVcjvgnskeHyAb
	Qa4PyNqq2/yKt9w15jwMTBfKIorMj6sifsbP2kGSdP20z7bjpHAD1BdGOcMY8p9G
	UKH3CCwTsCjQ9lJ55hzC15booOs1JRJ2GjeaZxevWBEs/V0W7MR4qMrNDRv9cQxP
	p4rZKQcIPdpeqR75rslYuZ0JbARCPw0NHz5lvCvt2FkO1UGfViF217CAKixCCWDu
	/fx1IK4pXuLoyUkfp/StX2oDPujpZ81zXPtBWjKL0lQT7pZSOPHKv/zs07k09gJ0
	+xV6NrmMCDW/VShzqVT33BusBw0ee3w4ioqZCIjwNqHAnAsA==
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com [209.85.222.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h4xdu83vk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Tue, 06 Oct 2026 10:02:55 +0000 (GMT)
Received: by mail-ua1-f69.google.com with SMTP id a1e0cc1a2514c-98087b0c5deso2018651241.2
        for <bpf@vger.kernel.org>; Tue, 06 Oct 2026 03:02:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791280975; x=1791885775; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=y3bDkdlPgoyDZs/us+RW5IFOVL2T8UGRn5OXKbHaJfY=;
        b=GMZ0vazegotFYSPLbH8jUGsNCQSGLVyWPHZGam0+ePPnnxZ/0cKLk4T1IYiiMOHOUL
         MpHKR+prhn/r6QKemKLiYjIdCWyKo9gbqYeSv8exV54o7kXEQn1lk1cKa4tYY8/MJRzY
         UwUnn11x7XyCH88Vlq9Ntch7gAW9V45H+QL2VJYrY2j6NvWuYHx9srRfStJK8FJ8gRr/
         yjHoWQAY7Vi0J+Y1pFEvJXKx8B3sXSRWeI4Xjd94VuAoCezeA+1L6k4qN4Asgkilbh88
         SksREVxGuKSceRunC8llM74tBAEXtBCZnblXxhfCANHYgHNkyv+DS2K3XkzBhKEEYO8X
         mhVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791280975; x=1791885775;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=y3bDkdlPgoyDZs/us+RW5IFOVL2T8UGRn5OXKbHaJfY=;
        b=IDU9GXwQnX/zPd0PXG6ZUiklDfSw9SbzQgiKcQDgQsdA0Q9H/wasHbIKjkxd/rnmK8
         bsOBXbenrNuA9aTBhAhNfoEPG4LgFdklBxc2kKAZBrtxFtbwxIR69QLqApqjGIA8tHo7
         1Dd0Fhie+UPw2EIwfoijWQmecjKmZmkR4x40TTncnDehK7DwIbrTy4eOcd1AqzelipOY
         ojHAEXlQTtjEIKJ6CPGEtLAInVyd/1mmuzns2VJCFbzV9QXt2iUNwzFRVkltjq5sMJpo
         OZFiGT9PetQmPcrgGLrLqwEzJu+yxCi9jJGTZV5OwOPr2Ut0r2zWJ3+XH4j79b/GR364
         q72g==
X-Forwarded-Encrypted: i=1; AKwUvBzYlCsavYEghEMSakytTBRrOxpd1aTB22MMAUHBiR2zELJeQVXv/nGx7zkF8qGr5VxpgO0=@vger.kernel.org
X-Gm-Message-State: AFq9FYJQsDAZZrjlOrjUcjjEYf2DpL5YdXFjOYb57xSzhGxwJdqalG2E
	aV+cb0B0+H/24VMz5A0X1swpEJhB12wL2LRYJyt9lqQ8Q07jhBUG/eZIhQR9ptN31NDIoQmECO7
	yGIW0ro2nwkOcC76PnY8Bti+kkcltxexy4WNesJ+5ax8vYBnC0gxwFVY=
X-Gm-Gg: AYBFou2EUV7b1VUkuhgRIeuVAwOTjKTY7W4IsI3GooNSe+BqE+2L2Q8Vqah6SroSs7M
	7Sfcob2iGCBXur17KvK7drNtXgk11RmCagEgS2ZizEN5ckDbsj0bEgG70qrlX68mVw0lc54IKs6
	/PTQDQ1Ak7wKGzSWn7iuw0c67gz7B4gC08YFivEW8xarC9a+Inz/qwCWDSHk8U/ee/qmbM8eIxQ
	n1WsZwIQWS+t4xh/j+Vx+GHcbKkOAxTl9tFJ9gmoEenDEPhTPfPz4l+PhwHq3y4JVUzTunCTrVZ
	Djtjj5tmkO/rI0umbACfQCVH6Zb0SUAbm7MSMc6EI9/OJesu90/IlON0oxCXXGxECcn+/kpZyfE
	+Eig85y2B7WQaHg==
X-Received: by 2002:a05:6102:549e:b0:7c0:4d52:8cc9 with SMTP id ada2fe7eead31-7c879eff7b4mr197228137.14.1791280974093;
        Tue, 06 Oct 2026 03:02:54 -0700 (PDT)
X-Received: by 2002:a05:6102:549e:b0:7c0:4d52:8cc9 with SMTP id ada2fe7eead31-7c879eff7b4mr197220137.14.1791280973569;
        Tue, 06 Oct 2026 03:02:53 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a178c53997sm92744655e9.12.2026.10.06.03.02.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 03:02:52 -0700 (PDT)
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Subject: [PATCH net-next v4 0/2] net: stmmac: introduce XDP rx multi-buff
 support
Date: Tue, 06 Oct 2026 12:02:19 +0200
Message-Id: <20261006-stmmac-rx-mb-v4-0-efa4ca974e3d@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3XNQQrCMBAF0KtI1k6ZSWPauvIe4iKtExswrSa1V
 ErvbuhCRHQz8Pn8N7OIHBxHsd/MIvDoouu7FNR2I5rWdBcGd05ZSJQaKyohDt6bBsIEvgbSSld
 GFqTYiDS5BbZuWrmj6HiAjqdBnFLTujj04bn+GWntf5MjAQHWakfFWaEy9tDHmN0f5tr03mfpr
 N4oPwxJX4ZMhuZSaiZrc9R/jPxtEKL6MnJA2KE1VJCxFTc/jGVZXpZ1Ot1BAQAA
X-Change-ID: 20260918-stmmac-rx-mb-16469a2714ea
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
        James Hilliard <james.hilliard1@gmail.com>,
        Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA2MDAzOSBTYWx0ZWRfX6atzU0TiRv74
 Q0qVP8faMRcfmcwLxge+14dQ5KEQBU4axFJ4ZsHRGG3GV6vpOiXDoTFTBnhsQmWoMwycFdM50BW
 28vcGf5QnwJ3C74JhERuRObu0h6lFbA=
X-Authority-Analysis: v=2.4 cv=NshE4MdJ c=1 sm=1 tr=0 ts=6ac4c74f cx=c_pps
 a=UbhLPJ621ZpgOD2l3yZY1w==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=e9kd2x7fyNmJAygvsboA:9 a=QEXdDO2ut3YA:10
 a=TOPH6uDL9cOC6tEoww4z:22
X-Proofpoint-GUID: RqXNdvotVtJXEHLO-z1tLN_c6E2jaMiZ
X-Proofpoint-ORIG-GUID: RqXNdvotVtJXEHLO-z1tLN_c6E2jaMiZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA2MDAzOSBTYWx0ZWRfX/Uvs8uH9lstE
 vR8R4GoeJhIU/GMo31kq/MjRdzK7fvPyxT1n91PyjCxt6z8S5mJWs/W9Rk3LVYawyTJpsd1pbkO
 Pvvf5ixGfFribiAyj0rZjTRRRmT12zLcOneUingCkUfybPL4u4Yr1fEqF253PR8Z6yk3p3o5l3D
 N/ikE3G6qB5fQA4fi1syId+O1V0WEK+zfQdtECmeVs18kZXT7Gu9hgxS5s+m+1uqinhM+m2+iTj
 nk/j1563yNOlmyv9z5wMsFJ2eSlG2X0bplCWEje+qJ600mRuaya2TLJn7f5JHAaq72qVzDZHWSF
 wRBCqvCacRjgIvw2sG/I57ZHLMQRKL867QN7JfsEILrXJjQVdxBN/aPWlMSj60D5g7jWftZrYZl
 mMPsYS1zCIaK0Ib9NB2rsbO72ZH92cTsDkLoSIDyXqkmyucPh1kvXajizar+CwX/C1Na/UfWTyD
 TbOtO/1jOgGTrJ34PhQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-06_02,2026-10-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 malwarescore=0 phishscore=0 impostorscore=0
 spamscore=0 clxscore=1015 priorityscore=1501 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610060039

Rework stmmac_rx() to build the xdp_buff from all the descriptors that make
up a frame, so the XDP program runs on the whole (possibly fragmented)
packet instead of the first buffer only. Fix possible rx_q state leaks
when closing/opening the interface.

Note that an XDP program still cannot be attached with an MTU larger than
ETH_DATA_LEN and SPH is disabled while XDP is enabled, so an ordinary
frame fits in a single buffer. The multi-buffer path is exercised by
frames that do span several descriptors (for example jumbo frames the MAC
admits through its jumbo-enable bit) and is groundwork for extending XDP
to jumbo/SPH; it does not enable XDP jumbo support by itself.

---
Changes in v4:
- Reset in_progress flag when the packet is fully consumed.
- Advetise NETDEV_XDP_ACT_RX_SG capability.
- Link to v3: https://lore.kernel.org/r/20261004-stmmac-rx-mb-v3-0-50fa171af9ec@oss.qualcomm.com

Changes in v3:
- Return secondary page in case of error.
- Introduce stmmac_xdp_shrink_tail() to remove the ethernet FCS.
- Add patch 'net: stmmac: take ownership of saved RX state at poll
  entry' from James.
- Link to v2: https://lore.kernel.org/r/20260921-stmmac-rx-mb-v2-1-6e826e1ff306@oss.qualcomm.com

Changes in v2:
- Rely on xdp_buff_add_frag() to create xdp fragments
- Fix bugs in rx_q state recording
- Fix the corner case where we receive more than MAX_SKB_FRAGS fragments
- Cosmetics
- Link to v1: https://lore.kernel.org/r/20260918-stmmac-rx-mb-v1-1-0b4517d404af@oss.qualcomm.com

---
James Hilliard (1):
      net: stmmac: take ownership of saved RX state at poll entry

Lorenzo Bianconi (1):
      net: stmmac: rework stmmac_rx to support XDP rx multi-buff

 drivers/net/ethernet/stmicro/stmmac/stmmac.h      |   3 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 390 ++++++++++++++--------
 2 files changed, 250 insertions(+), 143 deletions(-)
---
base-commit: a5e7d8e446af9803e37a3b6a4d416fb41178348f
change-id: 20260918-stmmac-rx-mb-16469a2714ea

Best regards,
-- 
Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>

