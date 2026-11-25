Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795618156;
	b=XVStLlRnP3+3T5SRfQv+EiVBvMFaiplgQkqiqiMUr7WM/KOXG6Mj+OmEO3GR/LRkTuda
	 46jykQtjR09G87pPIywaAE1VYtm6KZvVdMZK9G6WY+MeM2OKrTG9Y0JcR5uC8nRnJWjXI
	 mFXmVhS6jRSJVXutoZzPLjbq6ISPhQeuOyd/Qt1zi+/+DL7bAphmKZECrawiEEVyShiIu
	 Z3s1m1gkdlip4M5rOVSaL2/eFS6rSGmVb9jxcyIs+L6tqeE/7l4SyJ3jRD7rTWMOh83q/
	 p6g/i/8dYyOOOOaNqeaoPmO/BUzxxKxi07QfRK5gtKw88v0l6VSBS0NNTJv+yC57/Yw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795618156;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:
	 Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=xjRidLxpYYpshyibMcUCN31eOmWh93d61nSZCZHtL/Q=;
	b=LXmenqGtm6RCFqPlp1diHIEwjC52eOcfdOKgIMkayNxE1/UariShSHnnUyYK5LGpQILt
	 rKWUs/XvJtRNpotH1d3uaeYURjZOl8s2S4aq3lg2MW2EGs4YhkAd9R4026EPUL1kVBNzp
	 uq7CutCfYWCaRftIx1weMCZi0RzAqAomuX3DxIIr0yWLwdA6w17xDB/0k0dYcJvOL3gKH
	 ENvLgO7+IoTYmkrl8d0Ge0o8n0AXuJlVWGzsbNr+oba5CRJfwk2APedd+f1kKvZJe9jUB
	 iojWepjKGL7mcrN2u6ILnmVJkCZ7DgYkvCAVQi53C/k97pqs7M87RSTL64Kz8Rnvb/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=kQuSyuks;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=C6x6gNM9;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89DA5606A321
	for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 14:49:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 89DA5606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=kQuSyuks;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=C6x6gNM9
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6APEM7mh2729772
	for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 14:49:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=xjRidLxpYYpshyibMcUCN3
	1eOmWh93d61nSZCZHtL/Q=; b=kQuSyuks+pNZvNPalZANYPCjN5rIqwyZSHFyC5
	tY45ajeRTTH2EyUfhU537IU7jD0nKpsXWpQ1zghwDEPBknkWWhVy/fLkTqwmXLXl
	EccPO8wX7vhDQpIVu7lZi5d45gI24yPsW7KP5hx/oCy1T54gYzvq/UUdxvJil5Rb
	9OrcvJ0t3LsRgYzzLmftKlCz59pnso50p++mTevejpIUIkTm6Da5WnqJV5sTw/lS
	jIXTSlGK18ILeEEHfaUVVidvg5lAPT7f2V909fVtsdksSPv3tbrTgGBI4ufkiZxZ
	3Mxe7vpRZQnLV8ajrYTRFMFlif/cfZOA5wQnM+nqR2JzGOkg==
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com [209.85.128.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j5vuksbsj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 14:49:14 +0000 (GMT)
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-8b0e878f574so89880817b3.1
        for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 06:49:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795618154; x=1796222954; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=xjRidLxpYYpshyibMcUCN31eOmWh93d61nSZCZHtL/Q=;
        b=C6x6gNM9kgmZzRty+0dkMYMp9SkPgEpMkxVA4nO+vED2OGfO80w2HuiRY7bVkhTocL
         BheB/Z03scx5YaPOHC69zGC3pqMtJ0mz+z2kO6YUK2IV4DOoibs210YBaWhD+Md7rP2O
         MFbnWVrr+oTp2zmmN+QmSYX3K4noWzlSKNF8vbPwcVHc2/DBHUe0hoam1a+nm6Kep6Pg
         iRn53Emcw30phWE0wg222Nedf6zU/nc34Nhoq9s9cAWf4hDs+TMQqPe0s2lNYMDshkn5
         Vn5k4+4HlaadJjzdZ5Kfy0kGW7N8o7L9Asqkd32uLUMaYqcy9xn0LUK83TSuBaM3sDaf
         WLqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795618154; x=1796222954;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=xjRidLxpYYpshyibMcUCN31eOmWh93d61nSZCZHtL/Q=;
        b=xYnJd6fMfRWWf3e4ugRGJES8i/9+i5hVL0oWcOhXbqUCMAh0P6obypiqPCrLkcncXN
         /mYAnTEDCfOrFEboDnLsicYpUEr5w2vPorgZveAa9f9Fi2EbXODn/7kwKDHjvVRZDAAi
         Oe/Q4E8iI+Vg45QwyfCoKUeVfcphB4opG+GOVJ4NKmREGLwJ+Qlgl4nPjT+mjcNaM/1a
         WVW2mm5XcjnmBr7wKK0f2z2NzPH38viMEh8L50Rqhulw/PjekNvTFCVrBFaV76LGv9sh
         JBHR19B7v9H4dG1fMFTzhWUjlsxPnluDVIJAwvQ4+6/M/tmGJBfBCTiEv+XF7xDFtI1r
         2BDA==
X-Forwarded-Encrypted: i=1; AL+hErE4LWBQGXzNpWiIhjlXkgH426WPEuNA16/UByvUSFXhi9lR3VV8xrcooOn3aK13sG9uqEI=@vger.kernel.org
X-Gm-Message-State: APuU4Z/HA/lRoSP0dXBRyJqWB/3r5mxZK1z/P8GtcY0yb7UPUu+C5kL3
	SiLuJcF4NN5oRSgjXZbX8ljhgHbPBF1JT2UfeY//k8q47ltoJH6Pob9ZQbRQQa9fX/u3mrWuEP2
	PKVrzJpkQHjEGomJVIne5Noyg2iMk/CXVSD8qgX7Iy9W6niEuedY/iVQ=
X-Gm-Gg: AZFdTZcYxtMmVFt9dM+Elcg8ftsMz8c+DacmOGaYwU1J4dA+2v9PDB5mvIFAFFjOc1y
	H5f3xm5N+z9PEedqZ7Pq5Cshyigwso16Dp9TTFgJ/5DjR5VYWmIHYW51ZueU/8NO52Heb17y9zz
	EPzykfh6yt03U1cXWiBBvl7RP9mOhmntsheRmCwgcEiRmU32FR3K1sHy6eTXIXTlbty1Zv5b12Z
	azwS+oy9k1d3K7fQwkobcvd4evUk8F7ENyjT2BpraJWHQfqEPCuhWCCoIZSgQ8BQ9qZkUiO4bqX
	FzFiHjc6/dBcNpoEUdJXcSE2bbtCMCZd3KF0gfODYsPWAo6aPRCqlmm4fnnf3wurzwk5wuTLO+3
	ryndW+sEGYc9u7Vumvo8PLi+G14OcCNX9Rt7SOXl8k4cdxUnw6p1jDBt8HCwY6nI=
X-Received: by 2002:a05:690c:a0ae:20b0:8b0:cd32:b8dd with SMTP id 00721157ae682-8b518ecd3eemr56670507b3.17.1795618153414;
        Wed, 25 Nov 2026 06:49:13 -0800 (PST)
X-Received: by 2002:a05:690c:a0ae:20b0:8b0:cd32:b8dd with SMTP id 00721157ae682-8b518ecd3eemr56670237b3.17.1795618152820;
        Wed, 25 Nov 2026 06:49:12 -0800 (PST)
Received: from localhost ([188.152.73.83])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6baa3c4dsm29175415f8f.46.2026.11.25.06.49.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 06:49:11 -0800 (PST)
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Subject: [PATCH net-next v13 0/5] net: stmmac: introduce XDP rx multi-buff
 support
Date: Wed, 25 Nov 2026 15:48:45 +0100
Message-Id: <20261125-stmmac-rx-mb-v13-0-0f6bac53e8d5@oss.qualcomm.com>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3XSS27DIBAG4KtEXpdoZniZrnqPqguMh8ZSbbe2a
 6WKcvcSL1rkhA0SID6Gf7hUM08dz9Xz4VJNvHZzNw5pgvLpUIWTH95ZdG1aqAjIgMNazEvf+yC
 ms+gbgUYZ58miYl+lI58Tx+68ea/VwIsY+LxUb2nn1M3LOP1sF6247T8mVxQooFEabatA+fgyz
 vPx69t/hLHvj2nYvJUyg3BnUDIM12QYY5RgCob8MxBA7QwpQGiIHi366DgUDJUbZmeoZHD0Knh
 nFcu2YOjccDtDJyPIOinsPcq6YJjMQNoZJhlEpEGnwHXAgmFzY5+HveXRUmshgqZQekudG/ve1
 jcj6jpAQ7pWrmC4fwPvMnWptwGcC46kMaopGAgZchcIQqqklS2oxuhgmlJ3EXPF7pX0U4WLXge
 pOJLSJYUy5e6zpuJASM8UZRMYrXqgXK/XX2/bdy2sAwAA
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
        Ihor Solodrai <ihor.solodrai@linux.dev>,
        Matthew Gerlach <matthew.gerlach@altera.com>,
        Boon Khai Ng <boon.khai.ng@altera.com>
Cc: netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        bpf@vger.kernel.org, Peilin He <he.peilin@zte.com.cn>,
        Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>,
        Nicolai Buchwitz <nb@tipi-net.de>
X-Mailer: b4 0.14.3
X-Authority-Analysis: v=2.4 cv=KfVHIgYD c=1 sm=1 tr=0 ts=6b06f56a cx=c_pps
 a=g1v0Z557R90hA0UpD/5Yag==:117 a=mlS0om9xteqVCAF/aDpb2g==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=93y8aKn5o8w3FQiO0KoA:9 a=QEXdDO2ut3YA:10
 a=MFSWADHSvvjO3QEy5MdX:22
X-Proofpoint-ORIG-GUID: tbZ__NUETRpcGaM6z5f9Np0-HN4ojg4r
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI1MDA1OCBTYWx0ZWRfX1G/vkHFH80Zv
 Icjj7OrgghZe2a45c8J6RXLExgwTEbOaRa1swm4XTYdYojzjTobSCL7NEYeKyo6DoKljOE7o8Dq
 bBwXp/pqU6cwf8QX9+gGamVaWp65TIU=
X-Proofpoint-GUID: tbZ__NUETRpcGaM6z5f9Np0-HN4ojg4r
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI1MDA1OCBTYWx0ZWRfX+355l8SLEPPG
 hvvsgkBdaOiNxB4F4bA0BSnnnEH1scPfEqCy7ego+4PKgurlU+CqFb23wNimHB+JvQdDDEa3hyQ
 z5ibi9NAFYRtNJp3YIjgVSDe1wG5e73NsLIlv1t/a8CBcz4q0c73E37ot/Thgv0ATlMQtY+rLoQ
 neUqfTSmwrGQbH6hxyMkEwXLK+eaER+JWnAuhm+R6y8cFoJAT7AQNgLKlUodZF90y4+LXCnJZpB
 AkdjFXoDt/DhkSwfJgcik5P7BYDT7mEBRchEeVXkVCdnswkZJB9/YDUnHK28YRTZSTGnR3Jg+Wb
 dDVVvYNhbC+hbrlHaCnKyeoHiBebmEh7TmV+OFObq9Na/qvc9ntcqQI0CZSvHeJ8j2KhFYSCW+Y
 WKinHJEgF6Etwv/6SqQyxx9ylG+1Q6zGDDBIWogVCrRF+FdsK18ZAD8ub11zabyX4ppZcTE3+Lz
 tTDZUGQeuh5d1wTgX4A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-25_04,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 priorityscore=1501 clxscore=1015 bulkscore=0
 impostorscore=0 lowpriorityscore=0 malwarescore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611250058

Rework stmmac_rx() to build the xdp_buff from all the descriptors that make
up a frame, so the XDP program runs on the whole (possibly fragmented)
packet instead of the first buffer only. Fix possible rx_q state leaks
when closing/opening the interface.

---
Changes in v13:
- Drop __xdp_build_skb_from_buff() utility routine.
- Cherry-pick patch 1/5 and 2/5 to remove sw vlan stripping.
- Drop NETDEV_XDP_ACT_RX_SG XDP feature.
- Link to v12: https://lore.kernel.org/r/20261121-stmmac-rx-mb-v12-0-3ae2f3bce174@oss.qualcomm.com

Changes in v12:
- Rebase on top of net-next main branch.
- Link to v11: https://lore.kernel.org/r/20261117-stmmac-rx-mb-v11-0-9fa5c34ef245@oss.qualcomm.com

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
      net: stmmac: remove software VLAN tag stripping
      net: xdp: add xdp_buff_shrink_tail() helper
      net: xdp: add __xdp_return_buff() helper
      net: stmmac: rework stmmac_rx to support XDP rx multi-buff

Maxime Chevallier (1):
      net: stmmac: selftests: Prevent RXC from being disabled in LPI

 drivers/net/ethernet/stmicro/stmmac/stmmac.h       |  15 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  | 319 +++++++++------------
 .../net/ethernet/stmicro/stmmac/stmmac_selftests.c |   2 +
 include/net/xdp.h                                  |  10 +-
 net/core/filter.c                                  |  80 +-----
 net/core/xdp.c                                     |  98 ++++++-
 6 files changed, 261 insertions(+), 263 deletions(-)
---
base-commit: 4cd558c2f1de7f1800f7d9065303ca5833cbad56
change-id: 20260918-stmmac-rx-mb-16469a2714ea

Best regards,
-- 
Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>

