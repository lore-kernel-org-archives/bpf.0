Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795282115;
	b=0CdA6Go6w9cHRYZEpxUIJ764vha3s0/r6VLz0HORGHeEbANoIUqUJA/uhx3S5x0cYxjz
	 kkT4hmHNnGxISeuwjBZpVb0dJB9yJlYj1c1MlMlwIW/0X7uhq4VfVNkdYi5XOlH/cxrdY
	 8ebR/auTWjbzjxB9hTqovW4m/Siy8aDuX/bg8EBHJPeS2wqNZVOqn/hay2Cl3zEoq7oJb
	 3QneFlJFREZg9c2EGygcsLBLY+OOznezFdwvOBAnpXhNQSi/zwR455UNuBPIDD53lQO/X
	 jbKMpOSsOL4+lYBuLkMCstMd7dlFJ3p/j3CMMkc9+XyMNvF24TvhwuxchB+gWoeTVGQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795282115;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:
	 Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=Atpvx34I5zy3w193SbuJM2Y7axw8mjZO4wtWdl2Uqks=;
	b=yJxIU1QlRkuivuO65w24W20pO60fkFyfTbhY/d0dnWmNHcvSXQYpeD+s+/cOR/6TL+2a
	 zT4mH/YTOaTOWXxtiHIJYOzmYcclUpeOHxluL8Tyv8V/yzS6TWnUXMUGmIBRS6jTrbsV5
	 D/PZb93LLv9UiYGjgOcWsQPre5vC3ObFwyXAZcbhgJxLGIjYzLsOybsXdF1Yidj94iQs2
	 Jmob8bK+9F2tL3FNWd6aaVi2e+X/4kd8G7ZeQfTHW4Lo6Uaf0JLFO8zLX5bBPncXeMACd
	 93o6DbSUEfr+8pzEQIowXPnXuWubdCrZwtY2RHTRb0sLih/w5TUEDNSyge/PqBI/7Tg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=P1oeZPA0;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b="GAcEC/tA";
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1842C606A32A
	for <bpf@vger.kernel.org>; Sat, 21 Nov 2026 17:28:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1842C606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=P1oeZPA0;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=GAcEC/tA
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ALFaK891875803
	for <bpf@vger.kernel.org>; Sat, 21 Nov 2026 17:28:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=Atpvx34I5zy3w193SbuJM2
	Y7axw8mjZO4wtWdl2Uqks=; b=P1oeZPA0xKGWSh3+uHGn4Fy9q4Wn5Vl6U/BKvx
	WiMjtEhZf2Jfllpsv2pepuNGRkejYJc9OxyprRFsDnWKtxZdVAmRUP9nZg4RckCg
	0XvEvfAt2BjOZ2F2TpwsN3cW9betl2pMQGtyS2MI4vl/5anEwp64wUzvVbjvCZD+
	bjFJWWnNmW3a/O1eXS3XEj4vSIswk3dCcTXZI9ptzONtnQ5eugd4NjwweIZEndtz
	DmZtpmkul6SUOAg28rYJHhYk5PliKndZ/syF6YooWH3vzLAyxINPPiNaNA5uN/aO
	KUlMT0ljMmvaROUSndP7B9DxRY6JcT8jXdg/CcQKblXIjcBw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j310f9y28-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Sat, 21 Nov 2026 17:28:34 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-9493e89d4f9so293584785a.2
        for <bpf@vger.kernel.org>; Sat, 21 Nov 2026 09:28:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795282113; x=1795886913; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Atpvx34I5zy3w193SbuJM2Y7axw8mjZO4wtWdl2Uqks=;
        b=GAcEC/tA+DtpZ5v9cYBFF480h6LJuDtVdB+1NCC+xFf0VvrHwPO+oMjexz39y0kSLi
         yzz3VPoN6W15TY0LFRPaREjjd2GHtvBgzPkztmwghoKBFKZC55wV4vwdnjduw+MpucyX
         ioah3XP+xfBrENrL9Fb4XhsW55dvjzGdXCa20sXtT8jCfjZZTaHTVpXl/C3dQu6BMRpP
         4o6MvcX4mZ4pAVT/2rCu+HxGoX6Q6peabagWwoFB1SrMXtVKTm14SOCas28zPEjDD6aA
         2i0RZpCvi2ULToxqs21DCNKGJnQWyUKsNx3oMQYchA2+a4sJ4dDo2KjoBU11D7jhzbT4
         /hqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795282113; x=1795886913;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Atpvx34I5zy3w193SbuJM2Y7axw8mjZO4wtWdl2Uqks=;
        b=e3W1lM+bvILDQYwfc4n+1sL/P7/foPhKtCYJP4KWAVT+60p5ZjmB7WdOgChuwi0MYw
         trVsZrik//LyYiyezORq7M7egKdTtWXIT9VlzzXqdEtBffe3UiPOyDsthkgsJ6JH8cIT
         e7G45igdF8OHXwderylPd7tUewlcsr7D0E26B6Ja1KzixraIzG4LCfQkJ5NOQZ8lwl5M
         ZYt/6L9s2wQn1jXkcgi9NL+qFKzLao5HFOFgFytjbqMSAAQ3t87kGTIhojlTlggDTn/A
         j7ofBLBbKB1KslWYDFzLZKCqPFPFnRcR7886FNDkX5xh7jMqYKeK32zn/nZ10/Ib7fa2
         niXQ==
X-Forwarded-Encrypted: i=1; AL+hErHxgx2v/K6o4yJ+4X5wWP3nh1bLKEfe2ty59IRiYzaZGzqQxSUQO2n9pze9vvTSxXmVhBw=@vger.kernel.org
X-Gm-Message-State: APuU4Z/Cii+KiHnKfCjxqBSEiBsB0sYaY7RwPWGZUWx+8xSftPt3ZbwE
	xe8KQbfQ1wJGdK4/GZWeMRIJ/g5nNnl6KuwZ7F+xqusRCVTu/pSmmPPUUTi3Wzka8/iQ/U/LV8l
	d1JhD5PxdtlOuufQIEEZXxL7nwPThU5HQpZ7uBXxHYxwcP6W7IZN3cyA=
X-Gm-Gg: AZFdTZeHrDHJuF9SK3uTyjuWEG0BMfVD0N58HF8aVW7k3oKkJwrgZz6WG9d8V8dO54U
	SGvG4zdA6PSQQOtXlO0F9k9i6kVcTBPyokMGGn0h07UVddmrtnMSRheb16TQOWOm5Gr5Dp2wp/n
	wcVVYdf2PRzP/b8GmxeoAF9G2NK/4TkwS8kmtgfOQCI80HCf4ii8Bc8mxMvrwK1d6jLNTTr2s8R
	j1eKfWmHJimNeLdM69ic5tppNb+IVhyOUbkQfhQKprum6idG7Bfp9EYtX4h0A8NT0zZTi7UywCz
	+lfVMizhU/VeZi0ghGB44J16p/IDNzDyKK+XTAx4/Sg2dWyQLVv3dFc1LSq01pOqfEZsL0rLEOG
	377ft66TYMOsis/d3D05wBuUKVOaACMohy3UajygqeRqo/TWhmYForMYZgCDI2HE=
X-Received: by 2002:a05:620a:458a:b0:949:5872:be1b with SMTP id af79cd13be357-949ba9fcc8fmr1063862685a.39.1795282112990;
        Sat, 21 Nov 2026 09:28:32 -0800 (PST)
X-Received: by 2002:a05:620a:458a:b0:949:5872:be1b with SMTP id af79cd13be357-949ba9fcc8fmr1063859885a.39.1795282112503;
        Sat, 21 Nov 2026 09:28:32 -0800 (PST)
Received: from localhost ([188.152.73.83])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb9067846esm70964255e9.4.2026.11.21.09.28.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 09:28:31 -0800 (PST)
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Subject: [PATCH net-next v12 0/4] net: stmmac: introduce XDP rx multi-buff
 support
Date: Sat, 21 Nov 2026 18:28:11 +0100
Message-Id: <20261121-stmmac-rx-mb-v12-0-3ae2f3bce174@oss.qualcomm.com>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3XSS27DIBAG4KtEXpdoZnh31XtUXWAMjaXabm3XS
 hXl7iVetIiEDRKM+IB/uDRLmPuwNM+HSzOHrV/6aUwTpKdD409ufA+s79JCQ0AKLBq2rMPgPJv
 PbGgZKqGsI40iuCZt+ZxD7M+799qMYWVjOK/NW6qc+mWd5p/9oA33+mNyQ4YMWiFRdwKEiy/Ts
 hy/vt2Hn4bhmIbd2ygzCAuDkqGCIRUwRg6qYvA/AwFEYXAGTEJ0qNFFG3zFELmhCkMkI0QnvLN
 aBN5VDJkbtjBkMjw3SQnOITcVQ2UGUmGoZBCRBJkClx4rhs6NMg99y6OjTkMESb72FpMbZW/Nz
 YjSeGhJGmErhv038C5Tm3rrwVpviSsl2oqBkCF3gSCkm3S8A9Eq6VVb6y5iruhSST+V2eik5yJ
 EEvKBcr1efwFY0nK/ZgMAAA==
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIxMDA2OSBTYWx0ZWRfX8P70pGzYhBm2
 PdSPEuYONM59SSFqbupOrX2QODN4TPXa6vniAbtVzzQBGKbGZLPgQ7gkcwPnXdTxKO5ol7mGi7K
 t3NS09NYwJWN3ShSUylFfW09O/3MKZjy4f3CxSwIZ9UIzu8Qm0o5tU1wVth3f8/9BdNCHUEmtdl
 bs2rlsGKyq5yvo3pItyfj6dsUVzpfW3bVuficxHc4l5Yj67gG7R8kWn/OTJsqN5/eCOtnJgBv++
 XnmrxnnJjFqHgtMbkmm++P1AgWBYtRRgYaeh+UVwdt23FoIwKBp1dpCbfWmZG6KQ69NQW7SDWjL
 qoXD6cFZUCP3u440w4yKVA1yGfuvqF9+aosJ5mpYLE9/1pNIKQNm7AVat0xuAQl/Y7bwSnMSGJz
 ua0wXeRBYJH3UsT+uowbjCn/io/aiAlQY9nSGbHN7gpRY8EK3V+LlZLSlF8fAf2dpBkYyBwyUz5
 pE4DNZm9V2dEgHMlQmw==
X-Proofpoint-ORIG-GUID: tfIA8X6Qp14AHWPQKeaHKvRMwSkyWhhU
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIxMDA2OSBTYWx0ZWRfX4Ma64vPOifJn
 483s7sD3X3EtpBl5QgilNmKHONopXh0YC4GEbdSev+M6iNnsrQOE55tnp2b7T4XlSdI8uFwOV8W
 u9YShgbQRY597kegEwCcs1fFh0iILpw=
X-Proofpoint-GUID: tfIA8X6Qp14AHWPQKeaHKvRMwSkyWhhU
X-Authority-Analysis: v=2.4 cv=UN1Ijyfy c=1 sm=1 tr=0 ts=6b01d4c2 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=mlS0om9xteqVCAF/aDpb2g==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=UDig4O-PjbkV-u4TaL0A:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-21_04,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 clxscore=1015 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 adultscore=0 suspectscore=0 bulkscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611210069

Rework stmmac_rx() to build the xdp_buff from all the descriptors that make
up a frame, so the XDP program runs on the whole (possibly fragmented)
packet instead of the first buffer only. Fix possible rx_q state leaks
when closing/opening the interface.

---
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
      net: xdp: add __xdp_build_skb_from_buff() helper
      net: xdp: add xdp_buff_shrink_tail() helper
      net: xdp: add __xdp_return_buff() helper
      net: stmmac: rework stmmac_rx to support XDP rx multi-buff

 drivers/net/ethernet/stmicro/stmmac/stmmac.h      |   3 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 229 ++++++++++------------
 include/net/xdp.h                                 |  39 +++-
 net/core/filter.c                                 |  80 +-------
 net/core/xdp.c                                    | 113 ++++++++++-
 5 files changed, 253 insertions(+), 211 deletions(-)
---
base-commit: d23de0bd0bfd62405e6c80028008838ec140af25
change-id: 20260918-stmmac-rx-mb-16469a2714ea

Best regards,
-- 
Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>

