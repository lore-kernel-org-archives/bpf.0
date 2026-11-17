Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794920337;
	b=CQSWWI/JyL7R61w30qTyEK41XhhRHq7ONX8ZkZlrH9MhKUZ3M8ngTIM8p9xvXEvnIoht
	 0a+RODUTjk4Bue0DRb8JejYbLSFO5LnETB2F5dpshKV8yKe+Cuodq+RaeTrigA6hzpZ3M
	 cGooOVWexHdDXMH8BoyF8+eoo6Ohp6PF5nhjJk77kV97vG8rmNmiWOUS6gj4bVKxlb2tu
	 s2FBtK6fkPfNV2nckwrmYNArwQbcls8kc6HfXrA7BhZTeI90Ia13KdRL3ZmQqEWFtngDu
	 46acM7dQVaN6ondeOK47/N//6xRxIJ0OnZnpsLpGbpx//J8cpcaCaszU+aRhXp4JwdQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794920337;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:
	 Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=DEAmJc2BKBMJhjgbpTTHRFsGLFfRdAaxjZhuC9y68F8=;
	b=dj/wYUS1r0a8cPwv9pD11G8q97T4Ph1lgO7M5R6qLGnUEPu9I1y3U1byrwQp5FIY5S1t
	 vo95Gjf1tn0BOIGcHDWoS/PWWJ1+LjZrikAChtp1bvImWjRzIMi9e8U3FZtC4n/LBTIGa
	 Rj1umD1EmGfFFApO+IortPRqTitQ0IXWxwseOud0HsMobZ9Opm4+mrPaonFs3OuhcDVeM
	 puZGg5/NKIsII169tsZx7dOcNTIfC9Ae5E88zDE8kGBukAxdmRGjy2gf5dT/xNetAwB/N
	 eT7yDXBJpVH45JlHz2DT9U9oD+2aZm5A+N6Maxu5HF52F2CGmzMomUGY5aklv/FoE3Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=YFcyMzWp;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=bgcWvI3h;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1685606A881
	for <bpf@vger.kernel.org>; Tue, 17 Nov 2026 12:58:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E1685606A881
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=YFcyMzWp;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=bgcWvI3h
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AHC1JuB2756010
	for <bpf@vger.kernel.org>; Tue, 17 Nov 2026 12:58:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=DEAmJc2BKBMJhjgbpTTHRF
	sGLFfRdAaxjZhuC9y68F8=; b=YFcyMzWp4lhV3Z/xZxPI3Apu642Ptn83zZ6Y57
	htGLyUD732cvGFKAcz21pea1PRU3bWcmeMUh85cnfC2Tl4C5KFlCVSiPUl0I8PDW
	MXonOHbykPksp6aPE3scE8pu8Z8yUr9ifAHsgd0T5uPOOkrOcYHtVMKcIHjZulzY
	84nE6r/UWeBoTgQiQXuo6w6sRLs/WS0wZ6ckSOlzz/HyFAXWlsT9lPs6KdB4ABe/
	enfaAPER7Q4DqKBHrnSyRiq242RSRLceJnweCBKzlqEEdfKjj7F0X7SoWN2ceWPj
	R1vHRt3x4Gh/fgPuJKc7bRvL1EppzQcOiI98BXq0F47ym5kQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j0fjuhyhg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Tue, 17 Nov 2026 12:58:55 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-94607500fb0so370713385a.2
        for <bpf@vger.kernel.org>; Tue, 17 Nov 2026 04:58:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794920335; x=1795525135; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=DEAmJc2BKBMJhjgbpTTHRFsGLFfRdAaxjZhuC9y68F8=;
        b=bgcWvI3hJm4tvape/uEut86o29ptWPRBPREHd/GyvU9gg7ohlR5rGbvPwxys6gpzB4
         Gu0egFUP8mqbsM8dUH76awFhNm7ukoH8soyCMgcUnraRDAEbCgpuBEdYu/ct0tT6oYYd
         8V/McLebtmRGUJbpMSEIhGWaz9+UnRAxhwcnXAHKWQvdT+eNZ4EZbOaElbTLjnQ8lr92
         WiF4/+CYPpOTSTk6dliSPa2zCGmXDhrcQBUetM+KDz2sTKT6MR6veCztQPBUctrx7BWX
         jphGg+qse3mEEUMg5BvT/D0YQO1+CfsKsRQyeHcP2Chi/qLMeVRj5L9XBDNDi0KAix7m
         GU2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794920335; x=1795525135;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=DEAmJc2BKBMJhjgbpTTHRFsGLFfRdAaxjZhuC9y68F8=;
        b=s8oQ5mRcWcRzKoFPPCm5s4c8LTtPIECJfJqFu5LJkBQX6KiJIDyOhHD9heLAzLFo8v
         HFtL/FRF2oelvvTWhaHa7lYlgwmt75+IsHfSCGTSF0Rw5d9uBTBW1hIyLbjEwg77fJt5
         Trrz2MBY1ZOt6sBOazajCrl3V5jkW/htUWf8+1Rt35K7CAhe4HLiK36KZqjvjiw1zy+M
         +DKGYVxmXfKW8aTiOk/X9lp5LFxXBK1WeZkDHDFZe8GhCLrpNDPxuNIAtzE1khjcQRbs
         zkUOwX67j4+rcUG5XizPMOK/Av9upI+Lbs9dK3U1tj5UsqLID2mT0+UZ36VUKTcfehV5
         miaA==
X-Forwarded-Encrypted: i=1; AL+hErEskCh83hMPxl1slQZDP3a7xiUnt+x8I3kxQymzim9pXi9zLgNvCeAX3bSqbrUmNdKJCQ8=@vger.kernel.org
X-Gm-Message-State: APuU4Z9pg9QAL3xxJptjYoh3/LdpkVqgDQW4RlNhUZO7b59t6qPu7iIe
	ApzrjwqeoJX1GWQF6ePsE6a/fLYVnD/JoQGWXoxk9OaJfPWZdrVjmKMGe4R0IfIkWbLucG9mKF8
	G1JRej8tb4AecFQ4pYNpOW9rBcx4gv79PIQvpi66RV3aKxfFvP0lHBJc=
X-Gm-Gg: AYBFou1Wpj2jATieZwxrXZOtcCXoJ085a5Ily22/7SwBOnKEm3rikWbifhT6BTOktby
	lXlSH5VZDt74sufg9mCUsCBfjbQR8ivL/wMWcq4/wrwFQ18azGSI6DV52zNK177Y3RWU8LKXAJE
	CiczF6X1qhDRIF0GIokvrbnmh2rcxbQliw2pJpM8CuzizJoKJjjdn/4EtQ75w5xA8icqB8m9xSL
	YWfwkai3EJMl0g5HDNydh5OOOKEblcgutCHP9LfSRsKDxK8B6cwwpa8o4adD75A+msg73NTTqT3
	eEi33hDN5xPB4VSISM5cneXo9OZU6Z2UQICjlCZ5He0cJdgZc4sTjX3fnGYgX3/CrmNPEVjfDo3
	zKJPvvlc8hSVFmqe0yVk7AHLE+UzAljepDZG+QjdUP6rz3xlraD1Sgo0UULAX4vaot68cgCO1DD
	uZIlKctI0YI3Epqpw6ePne8N9M3rs=
X-Received: by 2002:a05:620a:2991:b0:949:6e15:e1d4 with SMTP id af79cd13be357-9496e15eb7cmr1406042585a.56.1794920334778;
        Tue, 17 Nov 2026 04:58:54 -0800 (PST)
X-Received: by 2002:a05:620a:2991:b0:949:6e15:e1d4 with SMTP id af79cd13be357-9496e15eb7cmr1406037085a.56.1794920334227;
        Tue, 17 Nov 2026 04:58:54 -0800 (PST)
Received: from localhost (net-188-152-73-83.cust.dsl.teletu.it. [188.152.73.83])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4a32155283bsm5688237f8f.37.2026.11.17.04.58.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 04:58:53 -0800 (PST)
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Subject: [PATCH net-next v11 0/4] net: stmmac: introduce XDP rx multi-buff
 support
Date: Tue, 17 Nov 2026 13:58:26 +0100
Message-Id: <20261117-stmmac-rx-mb-v11-0-9fa5c34ef245@oss.qualcomm.com>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3XRS27DIBAG4KtErEs0M7y76j2qLjCGxlJtt7Zrp
 Ypy9xIvWouEDRKM+Bj+ubA5Tl2c2fPhwqa4dnM3DnmD+HRg4eSH98i7Nh8wAtLg0PJ56Xsf+HT
 mfcNRS+08GZTRs3zlc4qpO2/eKxviwod4Xthbrpy6eRmnn+2hFbf6Y3JFjhwaqdC0EqRPL+M8H
 7++/UcY+/6Yl81baWcQFgZlQ0dLOmJKAnTFEH8GAsjCEBy4guTRoE8uhooh94YuDJmNmLwM3hk
 ZRVsx1N5whaGyEYTNSvQeha0YemcgFYbOBhEpUDlwFbBimL1R5mFuebTUGkigKNT+YvdGOVt7M
 5KyARpSVrqK4f4NvMvU5dkGcC44ElrLpmIg7JC7QBByJ61oQTZaBd08mu71ev0FYjXVoyADAAA
 =
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
        Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>,
        Nicolai Buchwitz <nb@tipi-net.de>
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE3MDA1MSBTYWx0ZWRfX32BvWX5RWfxB
 Vd+DTzctBmkml4Pq5pK45wJ9Sxf5fgFi6lKZtPNhWzc/YEnMVx/tLSGDgkeSO/Dqo9MPWYp/sv1
 RkqmsxqRTBi1+R5UCCyCEA8D401ZKhbBoZLxV5IvXWovI0t/2DPMB0dBK51L1Wkm6OzE3QIEvHb
 A+dYOE2xpM0QLlT+zdwnkn66oKXC93YiSQS2QBhtfwgo8M21m1L6im09JCp8MrG2feHe4lX9Ayw
 ohDfmPQSnCpezAJ5xpn9HPhuUZl2Oq4uWztJaz7Idll26mEW9fwMJWJmD6mhh/Ivu0+DPqvXZiK
 +B/qxXgBpncb+yourY8xoc3sOessAFakpCPqMjjy7V9/z5W19vou91rlpcVs6yVGKVEE1LkAx+Q
 eS/ABs6CuVlYFm+1EAIvIgfXnCvDJsFJ4InQ7tYnhD4JO1yqhFXVEKP8PLw2Cp07L+5iVUgOuoX
 Zbs8FYrudQQM8VAYpzA==
X-Authority-Analysis: v=2.4 cv=JfIpPkKV c=1 sm=1 tr=0 ts=6afc4f8f cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=mlS0om9xteqVCAF/aDpb2g==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=u4BqklbH0r9NqUsF4ZAA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-ORIG-GUID: MAtrWHpBEdPnOdDRnVYBTQz2crkD30Dc
X-Proofpoint-GUID: MAtrWHpBEdPnOdDRnVYBTQz2crkD30Dc
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE3MDA1MSBTYWx0ZWRfX/fFJ5SGPS4gd
 KpplrEyFsuPnpCxum010Qbs3pTsQr+6QmXXXw+uol+8MO2dyZOsDHysblgcCnEN6MLBvJT7DRBD
 BW5lysOeZfpiRINEZPwrum3vM6fNfBk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-17_02,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 clxscore=1015 suspectscore=0 spamscore=0
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 malwarescore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611170051

Rework stmmac_rx() to build the xdp_buff from all the descriptors that make
up a frame, so the XDP program runs on the whole (possibly fragmented)
packet instead of the first buffer only. Fix possible rx_q state leaks
when closing/opening the interface.

---
Changes in v11:
- Fix kernel-doc for __xdp_build_skb_from_buff().
- Add sanity checks for xdp_buff_shrink_tail().
- Link to v10: https://lore.kernel.org/r/20261112-stmmac-rx-mb-v10-0-d3d04b65c6bc@oss.qualcomm.com

Changes in v10:
- Introduce __xdp_return_buff(), xdp_buff_shrink_tail() and
  __xdp_build_skb_from_buff() helpers.
- Link to v9: https://lore.kernel.org/r/20261106-stmmac-rx-mb-v9-1-c099c923664b@oss.qualcomm.com

Changes in v9:
- Rebase on top of net-next main branch.
- Link to v8: https://lore.kernel.org/r/20261018-stmmac-rx-mb-v8-0-5f58c0b25849@oss.qualcomm.com

Changes in v8:
- Add patch 'net: stmmac: fix VLAN tag stripping on non-linear RX
  frames' to fix sw rx vlan parsing.
- Rebase on top of net-next main branch.
- Link to v7: https://lore.kernel.org/r/20261014-stmmac-rx-mb-v7-0-5d2d70f052cd@oss.qualcomm.com

Changes in v7:
- Take into account the case where buf2_len is not 0 for the single
  descriptor case if the interface is running in xdp mode.
- Report rx_not_ls bit if the packet is splitted over multiple
  descriptors for dwmac100 and dwmac1000 cores.
- Link to v6: https://lore.kernel.org/r/20261012-stmmac-rx-mb-v6-0-2225050915c1@oss.qualcomm.com

Changes in v6:
- Drop patch 'net: stmmac: allow non-linear xdp_buff in XDP mode' since
  it requires some XDP fixes.
- Introduce patch 'net: stmmac: drop split frames on AF_XDP zero-copy
  RX' to always drop XDP multi-buff frames for AF_XDP mode since it not
  yet supported there.
- Introduce patch 'net: stmmac: drop multi-buffer frames in XDP mode' to
  fix pending bugs due to missing XDP multi-buffer support before patch
  'net: stmmac: rework stmmac_rx to support XDP rx multi-buff'
- Link to v5: https://lore.kernel.org/r/20261009-stmmac-rx-mb-v5-0-c38fa4eaa138@oss.qualcomm.com

Changes in v5:
- Fix possible read after bound issue in patch 1/3.
- Do not allow parsing non-linear XDP buffers if the program loaded does
  not support frags.
- Add patch 3/3 to remove MTU constraint for XDP prog.
- Link to v4: https://lore.kernel.org/r/20261006-stmmac-rx-mb-v4-0-efa4ca974e3d@oss.qualcomm.com

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
Lorenzo Bianconi (4):
      net: xdp: add __xdp_build_skb_from_buff() helper
      net: xdp: add xdp_buff_shrink_tail() helper
      net: xdp: add __xdp_return_buff() helper
      net: stmmac: rework stmmac_rx to support XDP rx multi-buff

 drivers/net/ethernet/stmicro/stmmac/stmmac.h      |   3 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 231 ++++++++++------------
 include/net/xdp.h                                 |  39 +++-
 net/core/filter.c                                 |  80 +-------
 net/core/xdp.c                                    | 113 ++++++++++-
 5 files changed, 254 insertions(+), 212 deletions(-)
---
base-commit: 500da33276f5d81da764775223de9e9a251a4dbf
change-id: 20260918-stmmac-rx-mb-16469a2714ea

Best regards,
-- 
Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>

