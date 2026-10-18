Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AABC8242D7B
	for <bpf@vger.kernel.org>; Sun, 18 Oct 2026 17:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792343237; cv=none; b=j6rOhROOP8klIsVnhX1gOG2wmyCX341v2nwDzoWe+QgsGXI+BGO+O5n15jBPSaBWBld7B+S6W/vZNxmvCLfhxYyyV+6xF1NVIjhUkgW5PyWKy0t4DmDKV3ZRGmdLrIBPIqxIoEQ2DzgE+t3Yw2v64N81PG6E1aZH6jtHb1KJ+Hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792343237; c=relaxed/simple;
	bh=xopertD/ZBkChQhgx/DShjuXfdSkhJPloPiCWK9K+X8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=q3l1Gb7SeNCflKtma7+jmY6dfnY6xvZFw4SE0OV/9mT4qPEiL8+9mbYReXxHN6ceZvcTzjPE1fjyQGLF2AlyYNCkLBIfLDU6hxatjEczValwH8nWXSTcrt37883e4icXlIkola1dgm/jHRxUDnoiZu2zVAffn1QfDVYTRkFRDWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GwKJhMBC; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=jb+g+WdU; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GwKJhMBC";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jb+g+WdU"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69IF6r3H3392652
	for <bpf@vger.kernel.org>; Sun, 18 Oct 2026 17:07:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=zkGr1FR6SIlZd2q171x8Ne
	vWe9GCqV1ciOs7Lm4JaCQ=; b=GwKJhMBCX/v16CfleU1lk/UqsiGdhI+5NWofk5
	I4b51PLmwiH63IKzDQgS++sGWNCXjArziE+BUMEGnQFqH3VPOa3lrwZmRLxLEftt
	jh0KxrQW0LawMd3dSaJk/xEAUG3PXyt3RVXmq/10PSjhIfqZ/NsHPx69zy4ba4Kf
	K/JAGy5I5akjd52OMzL+SpuxjjZi+bg2c858KnvWSZWfM1qXxSFU8LX5GDmlqRiK
	kKtKMO/Lb15eOYCznMxywoIute3NymGBcricRxELgjF6B/Ke4Bnqp4WLR4wEUoTb
	g3ZO+LshcrV43u9Fgsi2DNjTdiE8sSXR+vPKX2Hpj//0JH0Q==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hc2a9kcj3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Sun, 18 Oct 2026 17:07:15 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-93cbf2fd504so252341385a.2
        for <bpf@vger.kernel.org>; Sun, 18 Oct 2026 10:07:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792343235; x=1792948035; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=zkGr1FR6SIlZd2q171x8NevWe9GCqV1ciOs7Lm4JaCQ=;
        b=jb+g+WdUzFrSqmnCwoY01ceEM9fI33xW8wW6VMZuPSnlhKEVpYGqTSzgZEYigcYAMv
         UD0vSeNGHvnfPY2M7lcEhVa/oFqO3QVfmKnG9FZ32pOc7+mdnmeSVauSlRfS0Z5AUViM
         j1IRxaYXLTdKBfphOwpQSmaTJjdqGsPYoEItD71Pta9Av38EjW02Tz9p4BdTr0kRcM57
         UYfS2P/wSrUyeoNwAuSdv0/1V3+NDxNP1LIBoP4HtdI+3xxrYz9sPC57ZeGr4luwlurl
         tPkucLBOn7sVp3urJt2YEGMRqebGB83GJyPFkT9/1cbA4Yi9TwtLvS3DEhb1nGe0/xDf
         4Zrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792343235; x=1792948035;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=zkGr1FR6SIlZd2q171x8NevWe9GCqV1ciOs7Lm4JaCQ=;
        b=nUe5h+99tq/TX2QB8Eh4uYnIt9e2zn1sT5lQLs9XhCLToW6neg91MT5KNa/cVqzinp
         e0zmaQkss9EORWa+ao9Yk5j3PS8PJs9oj2WZ+09iigvHiQiXUOZwwJLYX+psyfZ5ZeMR
         ZV6/8SiL9PAiOazzZuiOT3guVLj7eueL+aC9QRMidfTAk0SUgf8rKJfHwDLZG4iVrKaL
         Lntvxps9g014YoI85rafQgKK+F4z4l4EGbUyx2RYCJyIyn92A2ecsTEYgC/kcgfjAOYc
         oGRaPn5hrtxm4E1m3ACONJ9aTstmUE2MbwCxlnXmJRi4KFWstrGMQdM0JSFEcjT4rrT+
         AYVg==
X-Forwarded-Encrypted: i=1; AKwUvBwEEV9vIv8Aeswkr/O1uLyUojMFJoCwQ4b/53GPuBIY9R2Gg1BswVLLDeTE/5Dj2mvL994=@vger.kernel.org
X-Gm-Message-State: AFq9FYJpCvDCMuIDbZsXFLKBZHk02Ruv50HdXNYosFNE04Fmc6pNGFRe
	ogZnivYKuaOk7A6oncbC6gHsjsCYB1oDkY2NTDM8VyCBltNcHjVbsqMUph8tWn8gBCwMMlvKgG5
	VadfJjuy3tilM75pxj4COgz5RdKcK+9QO6aFwOFyahchAnbx2oJ5iyYtKEAi2F5c=
X-Gm-Gg: AYBFou1aqiTqyyG4ZeqODCWI5ylzb3uNlsCX+WfERvW+uExA8LGktZBHrU62qkHMKCJ
	4dWiV47sXl6DVo6iJeZjfdBY5HXdRNLLg+Mq1ZsdHvttzof1+iHXowYUBI4Ni5HHLnUxbIRmGlF
	KALtk9ktbx0VFLG9/fnd5bYuGXdCiKJ5oWVteGEzcFy9eiCpcHyDfU8xrMrT9aKRnuT65wJA9Ib
	iQxX5vyEZoCDcU+gs+9igITG6+OOkcvQmVUUkTOFheBodIS7IuLQrJS/cycoTYaYDgDR8riuI/L
	Ep5ChLgwZmEOP/YVvkT7CjEp//Z7DsNLUdymx+oSi5sE1SQNepkqlYzhV8S9XnmMfvHAUhLDnDa
	IBbYWdadkrp1WxA==
X-Received: by 2002:a05:620a:6007:b0:93f:cbd:8e20 with SMTP id af79cd13be357-93f29db47d7mr961764185a.73.1792343234660;
        Sun, 18 Oct 2026 10:07:14 -0700 (PDT)
X-Received: by 2002:a05:620a:6007:b0:93f:cbd:8e20 with SMTP id af79cd13be357-93f29db47d7mr961757785a.73.1792343234094;
        Sun, 18 Oct 2026 10:07:14 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48dfd471877sm15028522f8f.1.2026.10.18.10.07.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 10:07:13 -0700 (PDT)
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Subject: [PATCH net-next v8 0/5] net: stmmac: introduce XDP rx multi-buff
 support
Date: Sun, 18 Oct 2026 19:06:58 +0200
Message-Id: <20261018-stmmac-rx-mb-v8-0-5f58c0b25849@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3XQzWrDMAwH8FcpPs/Fkr+SnfYeYwfVkVfDkmxxF
 jJK331eDiOY5iIQQj+h/01knhJn8Xy6iYmXlNM4lKZ5OolwpeGdZepKL1ChUy00Ms99T0FOq+w
 vEpxxLaEHwyTKyufEMa0b9yoGnuXA6yzeyuSa8jxOP9udBbb5Y3IBCVJdjAXfGWUovow5n7++6
 SOMfX8uZfMW3BkIlYHFcNygY4hRK3dg6H8DlDKVoaWSVkUCDxRbDgeG2RuuMkwxOJIJ1HrDujs
 w7N5oK8MWI+imKEwEujkw3M4ArAxXDES0ypbAbYADw++NOg//l0eHnVdRWQyPfrnf77/4mIx7U
 QIAAA==
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
Cc: netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        bpf@vger.kernel.org, James Hilliard <james.hilliard1@gmail.com>,
        Nicolai Buchwitz <nb@tipi-net.de>,
        Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE4MDA2OCBTYWx0ZWRfX2REx7oeLBz5V
 sWOOVPz78MUObnETebcSFa3buV/eprO1yZairYpzmeWPtRQ5sXKU7KcEYm4Y/dpFWUKzEWm7i74
 f+AlTXqdB3FfnILxtMhUpfjLPM5ujbk=
X-Proofpoint-GUID: 7I9SJVt1W3eoSebB9dUlafxEKS0zyC1r
X-Proofpoint-ORIG-GUID: 7I9SJVt1W3eoSebB9dUlafxEKS0zyC1r
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE4MDA2OCBTYWx0ZWRfXwzvH95mck59m
 AcSVT5AH2BAdeDXqg/U7BCe6cB1Bk8RD2dfmumm4CniTwpG46YoCOZP/r58tu8txg8fo3Zo7/Q6
 7G82wg13oTqpzcq8gMVLqVyNvtcw5QCOng3LcuqngK4R9iXStyUfVXmUp1UuND2CJn77VxHooMq
 LwMtBZePWj7D1JOxsQZAl+MjWV8zayuJG4sr6HFdafloIC/R9XVFJAERRE+pNhUZyd1dAF3cb3E
 LvAzWANyX57SbvRm43rBm4SSX8wS81hE8m5G92T4Kqa+AD5PtrJ1n74YMnsy7p0lueLcgbUJrY1
 Dp9fBsazkEay3bUfIbrnnKQYuunp/tB5d8mv/yCIV39R8M9ZJXIE7AfBWH10C2aSAFDw52UGhZ4
 L6GSJHz0XMVlxD/pkxqMw0MK66SvPE7jqERysze0SJQZFT3tgY4VURGKuhj4SQD+eiMXctaTxXD
 4br1jdp+28XYV/Zu7Yw==
X-Authority-Analysis: v=2.4 cv=PMeaavqC c=1 sm=1 tr=0 ts=6ad4fcc3 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=u4BqklbH0r9NqUsF4ZAA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-18_03,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 spamscore=0 clxscore=1015 suspectscore=0
 priorityscore=1501 adultscore=0 malwarescore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610180068

Rework stmmac_rx() to build the xdp_buff from all the descriptors that make
up a frame, so the XDP program runs on the whole (possibly fragmented)
packet instead of the first buffer only. Fix possible rx_q state leaks
when closing/opening the interface.

---
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
Lorenzo Bianconi (5):
      net: stmmac: take ownership of saved RX state at poll entry
      net: stmmac: drop split frames on AF_XDP zero-copy RX
      net: stmmac: drop multi-buffer frames in XDP mode
      net: stmmac: fix VLAN tag stripping on non-linear RX frames
      net: stmmac: rework stmmac_rx to support XDP rx multi-buff

 drivers/net/ethernet/stmicro/stmmac/enh_desc.c    |   2 +-
 drivers/net/ethernet/stmicro/stmmac/norm_desc.c   |   2 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac.h      |   3 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 453 ++++++++++++++--------
 4 files changed, 289 insertions(+), 171 deletions(-)
---
base-commit: 98c2ad4f5d805dbc1ea436a334ee59311806a48c
change-id: 20260918-stmmac-rx-mb-16469a2714ea

Best regards,
-- 
Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>

