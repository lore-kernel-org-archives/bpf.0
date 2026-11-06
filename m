Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793962483;
	b=tZp0Zrqi2FPVI5fT02GKzEEv6UlOSBa1vTVLkNJ2gQsWeuuQXVqEEJbxfTUOikDSEwkU
	 jl0+GDKJW88Q+7jzu8TWgzJHxeMrIyeaemzMdlemTShohV8wWZ+eEOCYyw3rvLKHGyqcS
	 doEZ/mK7hF8DlpHuRjIfnDp9yjv2s9mYIt/l9YQnlLi01U8sIeLULqXVgc8bLfxw6ZKRp
	 rAhxgAvvBg59UqMbpQO5kyhvaMqjxqDFWL7W0PyYNj4BCeo6rcuhUQzYRfHwGSnAosEaa
	 1H+HpIbNRrw1TnGv168cHRQskkIOqifVwbmQQwMhEGr4rS+X1dKs7jGHVC4XzBpe/aA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793962483;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=0XbpM/gJsRYhHZDTB458TqqrO+RcZJXBd303+TCBCeg=;
	b=QvECDMw6/HUFyqBxp261UX241DlEl0Ul8CRMCnhI47YOC3+9FJRYspR1cJZvBYsfsNX+
	 xdBs5hKd9y/uKqys+PmyCHIjpvQUkj/KG8V5lLOYTSZk+i9uiYjqkNV1+vJAZyZiJUhDw
	 /hq/ThGGO0pJy+qx5TBETpGD/6xAv0060qfv2zVj/Np6GmoByOeVN1fsrA7/akodYKeIn
	 WPAw3RFS2uBUaN67y+/hiXcpIMQzOpicuOy3v9Ih3vQFC5IvIFD2MTCY9E5ErlMMZJEbI
	 QVEUqJbUkKWWJBnFsCF6Bi9ei1L+Si2W5RaTQejtYv8jLz48e73zhc6jJlWTvsMRivw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=NPPkmNHP;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=deCqHeTT;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A079606D803
	for <bpf@vger.kernel.org>; Fri,  6 Nov 2026 10:54:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6A079606D803
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=NPPkmNHP;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=deCqHeTT
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A6AP7ul3335296
	for <bpf@vger.kernel.org>; Fri, 6 Nov 2026 10:54:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=0XbpM/gJsRYhHZDTB458Tq
	qrO+RcZJXBd303+TCBCeg=; b=NPPkmNHPbTzA4L6GJprkiBln4P0Q/7H1TxUwUh
	Y+GhToXIsxrFGawU3jpxgDCZ/OEmnMYXyjWXnSyTmo07ThJ4YIOlGCOrc39lyjYM
	UF74IxpSWPT+zJzmVfRqytl0hEDke6U3y3pho6dBMyXUohxK5pMgsDEhAqEqaG4l
	l7RJvpKyN4Y/hTyl7gc2zXcMKzLaGB602+897YSw3d6v7t9LL1Rmzl1sHQsLYvn5
	PnP2KMKU2XQFVsBctZbDR7NCNKLcMcsMcDahGigOHnNXFmJmDKydtqTdLc0fbx9K
	uQ7Kptgh6LpjvYW/oRj3WNJ764PRtETuCcIIDcK6kKehzvqw==
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com [209.85.222.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hs3pa2ffm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Fri, 06 Nov 2026 10:54:41 +0000 (GMT)
Received: by mail-ua1-f70.google.com with SMTP id a1e0cc1a2514c-990c957f129so1307048241.1
        for <bpf@vger.kernel.org>; Fri, 06 Nov 2026 02:54:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793962480; x=1794567280; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=0XbpM/gJsRYhHZDTB458TqqrO+RcZJXBd303+TCBCeg=;
        b=deCqHeTT4V0FYmVAhirfklcmxGCuzA+POeEBwJ79xFf+4Rdkl8lUBioEl7Hq41BGRR
         Y/JXnjgY++E8Ca0+0Ta48NhmKqwcD8nTVgH4HQksWe106eByCaKdZJz7QOcXVPsE5D0k
         LWd0tgNt2HPEqimajAa4FORQ4gaTZx/B3dnkZNmF+Qs6MUgjxHDw+MM5iCz7B+4gr1Gz
         kzLqfRHqjXQhXzc/TeSt1KUfztU55Yk+rmCzT1qx2pDZGcV51w9ZA1rtUNDkIzJO6DJO
         jZY9DOcPjLk35iG6hzppg/7nfojM/TXUmxsgXPv6jR1wShPFsG4sNF+EeFAxr121UGRx
         DNnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793962480; x=1794567280;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=0XbpM/gJsRYhHZDTB458TqqrO+RcZJXBd303+TCBCeg=;
        b=iTRAfNYIOSjKsU34ZO5+293EvEq6UCNbuSqC5fwDgXP5Hje0cDVSqtylF+DxqpJvy3
         uaxxn8Ep5AmIbV1RpTmdLMNyHfDsSGK2tWRUtJYn3/4cr6pnmRzCk1zQaqB59EV9xdIi
         xLkGz+AosJLnqLlQqHixLRIQuXzsjqFjS6cFkYwLDpdpqBsgfh785/V0zmUf7dn+rtgS
         H/inrRqZpcE6ZTEdRleEo6R6slYmBzsgdtUK6hMtxwQeJyEYMO/8etFMA+HTmDQ0tU0a
         JeU8+DxgADYKdebZ8HqQVViIKCQFF/gwE47bSC395hzoBqkVtpzKzxUPLikEionUlKbq
         GN2A==
X-Forwarded-Encrypted: i=1; AKwUvByUypMNyqUM/X0UEZx110EjkMrwQLhlE3p3lrCoaOUH5qpBraySUngOtwePvjcEWqmv5sw=@vger.kernel.org
X-Gm-Message-State: APuU4Z8e0mpujxcj678mg77/SxewOtdj4RnyuJtZk4ubY0FSRM9qVWZF
	Zcq+227X/KwAOdqXzXnlWa94NOeHi+76C95/QYD0lWjeIVjfQPp3GZRdBiZAsWXtUd1PhDV7Ybv
	u1d8C0w/D2qL6fSz/X5tJl/j/MWoDpGXiVlkpStERR83oweMCzF/FSxo=
X-Gm-Gg: AYBFou34NasujOxJ11yJiYw35fORre2YBQ+/Iy/nZ+2OPbBET0IUDM0gAX/wKRG/Tbe
	g3Hb4DkmMi/3SlhIhEVICzaK/NM/MrsD3LsDqsqfr5/1LVKB/Zu0LH4sZsFCKNFJdMF0eHI5bPZ
	jxNrHAjuh34DmtrA2AZosvrmwObZMuGjd6rZHOgVGs5vJWBtg0IaKIBhxGt/O7gVFtUPzF3j7Ci
	prC3N3/Iy2NnxKXQXFwOxT+2eepjxQUcomoX+oH56tkqaefVYfF0tyaD6mtAdNmyyKDavHW8SZg
	4Mc7XMJAtNMlftEwt1FRzRmhOJxUb72r0wmMUKqD8ZPzFj4zyKw0ofJrKGd+u3p9nIIC3RgTIr9
	J9ncRm+Y3lY1ozKtUbAyfOlVrFP/qTA+sIJa1yFOiM+BdX1yUmbtK9LxSO74ZcHc=
X-Received: by 2002:a05:6102:3750:b0:7ca:9674:a58f with SMTP id ada2fe7eead31-7d286b2ed7amr2809996137.32.1793962479957;
        Fri, 06 Nov 2026 02:54:39 -0800 (PST)
X-Received: by 2002:a05:6102:3750:b0:7ca:9674:a58f with SMTP id ada2fe7eead31-7d286b2ed7amr2809978137.32.1793962479229;
        Fri, 06 Nov 2026 02:54:39 -0800 (PST)
Received: from localhost ([93.66.104.131])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-492d7701af6sm3112516f8f.38.2026.11.06.02.54.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 02:54:38 -0800 (PST)
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Date: Fri, 06 Nov 2026 11:54:19 +0100
Subject: [PATCH net-next v9] net: stmmac: rework stmmac_rx to support XDP
 rx multi-buff
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
Message-Id: <20261106-stmmac-rx-mb-v9-1-c099c923664b@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3XRzWrDMAwH8FcpPs9FUvy5095j7OA68hpYki7OQ
 kfpu8/NYQTTXAxC6Cf8101knjrO4vVwExMvXe7GoRT+5SDiOQyfLLu21IKADHh0Ms99H6KcrrI
 /STTK+EAWFQdRRi4Tp+66cu9i4FkOfJ3FR+mcuzyP0++6Z8G1/5xcUKKEk9JoWwUqpLcx5+P3T
 /iKY98fy7N6C20MwsqgYhh2ZBhTasDsGM2/gQCqMhoJUkMKaDEkz3HHUFvDVIYqBqegYvBWcdP
 uGHpr+MrQxYiNKwqHgI3bMczGQKoMUwwi0qBL4DrijmG3Rp2HfeTRUmshgaa49xe3NerbuoeRt
 ItwIu2Uf2Lc7/c/mXwov5UCAAA=
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
        bpf@vger.kernel.org, Nicolai Buchwitz <nb@tipi-net.de>,
        Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-GUID: LGLa7wcjoeRxFrWvvwOdg9CKInlJfGzc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDA0MyBTYWx0ZWRfXwDqdDeLZS7Al
 wAcE1TA+87F/T6IBKMXLDAhecpyzgA+llj5cPSvV0z/U0KRiysjDlIThGOIa4LD3pNhz389BOXD
 N+QhF+6xhySuJ7A8oiNVOulzIEXN5H8IhEVIaUWAmayUgJoYugOyGAugLoVYI2PkvyloRsckTCn
 hxx8FgBDg9WVM3ea/oRK4LncRfNvY6W3RsRBW5mv1B9tCej2Ro6//sZGbOPcZyCvswTFWUN28WD
 I3OitX27EYaYqNmgKeshRS6NoD1X6j7bdAbQEhe9gBZ2hj/2mCehi/U1pGuvB5skpOVNw5w5ch/
 V5E2CmDUITkvA0zQCJRe27jE8RHxhc+fqks9xTlL43slvSvzw9hlEbuAtFyjqWc+8nw+jSxXgEl
 eTXWG17WlIDbFDC6Zdem1AdTfZY47cSknb+Fi3ol89zfD9HJGnh295zhirzJcx9iQfWuDmG1YaM
 4jhY2NfLuSpCoX5IYeQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDA0MyBTYWx0ZWRfX761XId6JJ34F
 aSEdLPX0XbHz9oMK1/EutoX/jBIa0wlXUgqY/+Ef/Hj6/lPR3PEqA6vi1BLGkKz4Sg8iWswbsrd
 98wGnSnjNfnXLOUz1Ca/DrSX7lwAL/0=
X-Proofpoint-ORIG-GUID: LGLa7wcjoeRxFrWvvwOdg9CKInlJfGzc
X-Authority-Analysis: v=2.4 cv=CaKdd7rl c=1 sm=1 tr=0 ts=6aedb1f1 cx=c_pps
 a=R6oCqFB+Yf/t2GF8e0/dFg==:117 a=cAAIdyqZgEis9HJxay2Blw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=B7jOgYJIo-6LHEY0UBkA:9 a=QEXdDO2ut3YA:10
 a=TD8TdBvy0hsOASGTdmB-:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_03,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 adultscore=0 malwarescore=0 spamscore=0
 bulkscore=0 clxscore=1015 suspectscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611060043

An earlier commit dropped frames split across multiple descriptors, or
using a second buffer, while XDP was enabled. This prevented the
per-descriptor XDP path from re-parsing frame tails and from applying FCS
handling to truncated buffers.

Rework stmmac_rx() to accumulate all the descriptors that make up a frame
in an xdp_buff, so the XDP program runs on the full (possibly fragmented)
packet instead of just the first buffer. Frames split across descriptors
or buffers are now passed to programs loaded with BPF_F_XDP_HAS_FRAGS;
programs without that capability continue to drop fragmented frames. When
the frame is not consumed by the program, assemble the skb from the head
buffer and the collected fragments via napi_build_skb()/
xdp_update_skb_frags_info().

Note that XDP still rejects an MTU larger than ETH_DATA_LEN
(stmmac_xdp_set_prog(), stmmac_change_mtu()) and disables SPH, so an
ordinary frame fits in a single buffer. This path is therefore exercised
by frames that do span several descriptors (for example jumbo frames the
MAC admits through its jumbo-enable bit) and is groundwork for extending
XDP to jumbo/SPH; it does not enable XDP jumbo support by itself.

To do so, store the in-progress xdp_buff in rx_q->state instead of the
partially built skb, so the accumulated head and fragments survive a NAPI
poll boundary (mid-frame dma_own or dirty_rx break). The state is saved
only while a frame is in progress and cleared once it completes, leaving
it untouched when the poll does not process anything (e.g. netpoll invoked
with a zero budget).

In addition:
- advertise NETDEV_XDP_ACT_RX_SG, since the RX path can now deliver
  non-linear buffers to XDP;
- register the xdp_rxq with the fragment allocation size, so
  bpf_xdp_adjust_tail() can grow the tail of fragmented frames;
- build the skb head with napi_build_skb() passing xdp->frame_sz, so
  skb_shinfo() lands on the same shared_info the fragments were accumulated
  into;
- carry the XDP metadata written with bpf_xdp_adjust_meta() into the skb
  via skb_metadata_set(), so it is no longer dropped and TC/BPF programs
  can read it through data_meta;
- attach fragments with xdp_buff_add_frag(), which initializes all the
  shared_info fields and takes care of the pfmemalloc bit;
- charge fragments the whole page_pool page size (xdp->frame_sz) as
  truesize instead of the old dma_buf_sz; with SPH/buf2 most frames carry
  a fragment, so skb->truesize grows by roughly 1.5x on 4K pages and 2x on
  64K pages, which reduces the effective socket receive buffer. The new
  value is more accurate now that a fragment is a full page_pool page, but
  it is a behavior change;
- release the buffers collected in the xdp_buff when a frame is dropped
  on RX errors; the previous code relied on dev_kfree_skb() recycling the
  skb frags, which no longer applies now that the head and fragments live
  in an xdp_buff rather than a partially built skb;
- drop the whole frame when it would exceed MAX_SKB_FRAGS, where the
  previous skb_add_rx_frag() calls were unbounded;
- strip the Ethernet FCS from the accumulated xdp_buff with a driver-local
  tail shrink (stmmac_xdp_shrink_tail()) for both linear and fragmented
  frames, instead of trimming the skb or the first descriptor length.

Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>
Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
---
Rework stmmac_rx() to build the xdp_buff from all the descriptors that make
up a frame, so the XDP program runs on the whole (possibly fragmented)
packet instead of the first buffer only. Fix possible rx_q state leaks
when closing/opening the interface.
---
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
 drivers/net/ethernet/stmicro/stmmac/stmmac.h      |   3 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 326 ++++++++++++++--------
 2 files changed, 206 insertions(+), 123 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac.h b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
index b76acfe0d958..5c8a38b69391 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac.h
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
@@ -132,7 +132,8 @@ struct stmmac_rx_queue {
 	dma_addr_t dma_rx_phy;
 	unsigned int state_saved;
 	struct {
-		struct sk_buff *skb;
+		struct xdp_buff xdp;
+		unsigned int n_descs;
 		unsigned int len;
 		unsigned int error;
 	} state;
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index a2177777727e..c215cc70caa1 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -159,6 +159,8 @@ static void stmmac_flush_tx_descriptors(struct stmmac_priv *priv, int queue);
 static void stmmac_set_dma_operation_mode(struct stmmac_priv *priv, u32 txmode,
 					  u32 rxmode, u32 chan);
 static void stmmac_vlan_restore(struct stmmac_priv *priv);
+static void stmmac_xdp_put_buff(struct stmmac_rx_queue *rx_q,
+				struct xdp_buff *xdp, bool allow_direct);
 
 #ifdef CONFIG_DEBUG_FS
 static const struct net_device_ops stmmac_netdev_ops;
@@ -2183,8 +2185,10 @@ static void __free_dma_rx_desc_resources(struct stmmac_priv *priv,
 	else
 		dma_free_rx_skbufs(priv, dma_conf, queue);
 
-	dev_kfree_skb_any(rx_q->state.skb);
-	rx_q->state.skb = NULL;
+	if (rx_q->state.n_descs && !rx_q->xsk_pool) {
+		stmmac_xdp_put_buff(rx_q, &rx_q->state.xdp, false);
+		rx_q->state.n_descs = 0;
+	}
 	rx_q->state_saved = false;
 	rx_q->buf_alloc_num = 0;
 	rx_q->xsk_pool = NULL;
@@ -2290,10 +2294,6 @@ static int __alloc_dma_rx_desc_resources(struct stmmac_priv *priv,
 			 SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
 	num_pages = DIV_ROUND_UP(dma_buf_sz_pad, PAGE_SIZE);
 
-	rx_q->queue_index = queue;
-	rx_q->priv_data = priv;
-	rx_q->napi_skb_frag_size = num_pages * PAGE_SIZE;
-
 	pp_params.flags = PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV;
 	pp_params.pool_size = dma_conf->dma_rx_size;
 	pp_params.order = order_base_2(num_pages);
@@ -2321,6 +2321,10 @@ static int __alloc_dma_rx_desc_resources(struct stmmac_priv *priv,
 	if (!addr)
 		return -ENOMEM;
 
+	rx_q->queue_index = queue;
+	rx_q->priv_data = priv;
+	rx_q->napi_skb_frag_size = PAGE_SIZE << pp_params.order;
+
 	if (priv->extend_desc)
 		rx_q->dma_erx = addr;
 	else
@@ -2332,7 +2336,8 @@ static int __alloc_dma_rx_desc_resources(struct stmmac_priv *priv,
 	else
 		napi_id = ch->rx_napi.napi_id;
 
-	ret = xdp_rxq_info_reg(&rx_q->xdp_rxq, priv->dev, queue, napi_id);
+	ret = __xdp_rxq_info_reg(&rx_q->xdp_rxq, priv->dev, queue, napi_id,
+				 rx_q->napi_skb_frag_size);
 	if (ret) {
 		netdev_err(priv->dev, "Failed to register xdp rxq info\n");
 		return -EINVAL;
@@ -5495,8 +5500,8 @@ static int __stmmac_xdp_run_prog(struct stmmac_priv *priv,
 static struct sk_buff *stmmac_xdp_run_prog(struct stmmac_priv *priv,
 					   struct xdp_buff *xdp)
 {
+	int res = STMMAC_XDP_CONSUMED;
 	struct bpf_prog *prog;
-	int res;
 
 	prog = READ_ONCE(priv->xdp_prog);
 	if (!prog) {
@@ -5504,7 +5509,8 @@ static struct sk_buff *stmmac_xdp_run_prog(struct stmmac_priv *priv,
 		goto out;
 	}
 
-	res = __stmmac_xdp_run_prog(priv, prog, xdp);
+	if (likely(!xdp_buff_has_frags(xdp) || prog->aux->xdp_has_frags))
+		res = __stmmac_xdp_run_prog(priv, prog, xdp);
 out:
 	return ERR_PTR(-res);
 }
@@ -5836,6 +5842,119 @@ static int stmmac_rx_zc(struct stmmac_priv *priv, int limit, u32 queue)
 	return failure ? limit : (int)count;
 }
 
+static void
+stmmac_xdp_put_buff(struct stmmac_rx_queue *rx_q, struct xdp_buff *xdp,
+		    bool allow_direct)
+{
+	struct skb_shared_info *sinfo = xdp_get_shared_info_from_buff(xdp);
+	int i;
+
+	if (likely(!xdp_buff_has_frags(xdp)))
+		goto out;
+
+	for (i = 0; i < sinfo->nr_frags; i++)
+		page_pool_put_full_page(rx_q->page_pool,
+					skb_frag_page(&sinfo->frags[i]),
+					allow_direct);
+out:
+	page_pool_put_full_page(rx_q->page_pool, virt_to_head_page(xdp->data),
+				allow_direct);
+}
+
+static struct sk_buff *stmmac_build_skb(struct xdp_buff *xdp)
+{
+	struct skb_shared_info *sinfo = xdp_get_shared_info_from_buff(xdp);
+	u32 metasize = xdp->data - xdp->data_meta;
+	struct sk_buff *skb;
+	u8 num_frags = 0;
+
+	if (unlikely(xdp_buff_has_frags(xdp)))
+		num_frags = sinfo->nr_frags;
+
+	skb = napi_build_skb(xdp->data_hard_start, xdp->frame_sz);
+	if (!skb)
+		return NULL;
+
+	skb_mark_for_recycle(skb);
+	skb_reserve(skb, xdp->data - xdp->data_hard_start);
+	skb_put(skb, xdp->data_end - xdp->data);
+	if (metasize)
+		skb_metadata_set(skb, metasize);
+
+	if (unlikely(xdp_buff_has_frags(xdp)))
+		xdp_update_skb_frags_info(skb, num_frags, sinfo->xdp_frags_size,
+					  sinfo->xdp_frags_truesize,
+					  xdp_buff_get_skb_flags(xdp));
+	return skb;
+}
+
+static bool stmmac_build_xdp_frags(struct stmmac_priv *priv,
+				   struct stmmac_rx_queue *rx_q,
+				   unsigned int len, struct page *page,
+				   unsigned int offset,
+				   enum dma_data_direction dma_dir,
+				   struct xdp_buff *xdp)
+{
+	dma_addr_t dma_addr = page_pool_get_dma_addr(page) + offset;
+
+	dma_sync_single_for_cpu(priv->device, dma_addr, len, dma_dir);
+	if (!xdp_buff_add_frag(xdp, page_to_netmem(page), offset, len,
+			       xdp->frame_sz)) {
+		page_pool_put_full_page(rx_q->page_pool, page, true);
+		return false;
+	}
+
+	return true;
+}
+
+static int stmmac_xdp_shrink_tail(struct stmmac_rx_queue *rx_q,
+				  struct xdp_buff *xdp, int offset)
+{
+	struct skb_shared_info *sinfo;
+	int i;
+
+	if (unlikely(offset < 0 ||
+		     offset > (int)xdp_get_buff_len(xdp) - ETH_HLEN))
+		return -EINVAL;
+
+	if (likely(!xdp_buff_has_frags(xdp))) {
+		xdp->data_end -= offset;
+		return 0;
+	}
+
+	sinfo = xdp_get_shared_info_from_buff(xdp);
+	for (i = sinfo->nr_frags - 1; i >= 0 && offset > 0; i--) {
+		skb_frag_t *frag = &sinfo->frags[i];
+		int delta = min_t(int, offset, skb_frag_size(frag));
+
+		if (delta == skb_frag_size(frag)) {
+			/* The whole frag is consumed by the strip: return it
+			 * to the page pool right away. Its ring slot still
+			 * carries the page DMA address until stmmac_rx_refill()
+			 * re-arms it at the end of the NAPI poll. This is
+			 * safe because HW cannot touch the slot until then.
+			 */
+			page_pool_put_full_page(rx_q->page_pool,
+						skb_frag_page(frag), true);
+			sinfo->nr_frags--;
+			sinfo->xdp_frags_truesize -= xdp->frame_sz;
+		} else {
+			skb_frag_size_sub(frag, delta);
+		}
+
+		sinfo->xdp_frags_size -= delta;
+		offset -= delta;
+	}
+
+	if (unlikely(!sinfo->nr_frags)) {
+		xdp_buff_clear_frags_flag(xdp);
+		xdp_buff_clear_frag_pfmemalloc(xdp);
+		xdp->data_end -= offset;
+	}
+
+	return 0;
+}
+
 /**
  * stmmac_rx - manage the receive process
  * @priv: driver private structure
@@ -5849,21 +5968,20 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
 	u32 rx_errors = 0, rx_dropped = 0, rx_bytes = 0, rx_packets = 0;
 	struct stmmac_rxq_stats *rxq_stats = &priv->xstats.rxq_stats[queue];
 	struct stmmac_rx_queue *rx_q = &priv->dma_conf.rx_queue[queue];
+	unsigned int n_descs = 0, next_entry = rx_q->cur_rx;
 	struct stmmac_channel *ch = &priv->channel[queue];
 	unsigned int count = 0, error = 0, len = 0;
-	unsigned int next_entry = rx_q->cur_rx;
 	bool in_progress = rx_q->state_saved;
 	enum dma_data_direction dma_dir;
 	int coe = priv->hw->rx_csum;
-	unsigned int desc_size;
-	struct sk_buff *skb = NULL;
 	struct stmmac_xdp_buff ctx;
-	bool fcs_stripped = false;
+	unsigned int desc_size;
 	int xdp_status = 0;
 	int bufsz;
 
 	dma_dir = page_pool_get_dma_dir(rx_q->page_pool);
-	bufsz = DIV_ROUND_UP(priv->dma_conf.dma_buf_sz, PAGE_SIZE) * PAGE_SIZE;
+	bufsz = rx_q->napi_skb_frag_size;
+	ctx.priv = priv;
 
 	if (netif_msg_rx_status(priv)) {
 		void *rx_head = stmmac_get_rx_desc(priv, rx_q, 0);
@@ -5876,11 +5994,12 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
 	}
 
 	if (rx_q->state_saved) {
-		skb = rx_q->state.skb;
+		ctx.xdp = rx_q->state.xdp;
 		error = rx_q->state.error;
+		n_descs = rx_q->state.n_descs;
 		len = rx_q->state.len;
-		rx_q->state.skb = NULL;
 		rx_q->state_saved = false;
+		rx_q->state.n_descs = 0;
 	}
 
 	while (count < limit) {
@@ -5888,11 +6007,11 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
 		enum pkt_hash_types hash_type;
 		struct stmmac_rx_buffer *buf;
 		struct dma_desc *np, *p;
+		struct sk_buff *skb;
 		int entry, status;
 		u32 hash;
 
 		if (!in_progress) {
-			skb = NULL;
 			error = 0;
 			len = 0;
 		}
@@ -5940,19 +6059,11 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
 				rx_errors++;
 		}
 
-		/* We do not support SG in XDP mode */
-		if (unlikely(!error && (status & rx_not_ls) &&
-			     stmmac_xdp_is_enabled(priv))) {
-			rx_dropped++;
-			error = 1;
-		}
-
 		if (unlikely(error)) {
 			if (status & rx_not_ls)
 				goto read_again;
 
-			dev_kfree_skb(skb);
-			goto next;
+			goto error_free_frag;
 		}
 
 		/* Buffer is good. Go on. */
@@ -5962,120 +6073,79 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
 		buf2_len = stmmac_rx_buf2_len(priv, p, status, len);
 		len += buf2_len;
 
-		/* Drop the packet if it is split over buf1 and buf2 on a
-		 * single descriptor if the interface is running in XDP mode.
-		 */
-		if (unlikely(stmmac_xdp_is_enabled(priv) && buf2_len)) {
-			rx_dropped++;
-			goto next;
-		}
-
-		/* ACS is disabled; strip manually. */
-		if (likely(!(status & rx_not_ls)))
-			len -= ETH_FCS_LEN;
-
-		if (!skb) {
-			/* Each frame starts here: reset the FCS handling */
-			fcs_stripped = false;
-
+		if (!n_descs) {
 			dma_sync_single_for_cpu(priv->device, buf->addr,
 						buf1_len, dma_dir);
 			net_prefetch(page_address(buf->page) +
 				     buf->page_offset);
 
-			if (stmmac_xdp_is_enabled(priv) && !buf2_len) {
-				buf1_len -= ETH_FCS_LEN;
-				fcs_stripped = true;
-			}
-
 			xdp_init_buff(&ctx.xdp, bufsz, &rx_q->xdp_rxq);
 			xdp_prepare_buff(&ctx.xdp, page_address(buf->page),
 					 buf->page_offset, buf1_len, true);
-
-			ctx.priv = priv;
-			ctx.desc = p;
-			ctx.ndesc = np;
-
-			skb = stmmac_xdp_run_prog(priv, &ctx.xdp);
-			/* For Not XDP_PASS verdict */
-			if (IS_ERR(skb)) {
-				unsigned int xdp_res = -PTR_ERR(skb);
-
-				if (xdp_res & STMMAC_XDP_CONSUMED) {
-					page_pool_recycle_direct(rx_q->page_pool,
-								 virt_to_head_page(ctx.xdp.data));
-					buf->page = NULL;
-					rx_dropped++;
-					goto next;
-				} else if (xdp_res & (STMMAC_XDP_TX |
-						      STMMAC_XDP_REDIRECT)) {
-					xdp_status |= xdp_res;
-					buf->page = NULL;
-					goto next;
-				}
-			}
-		}
-
-		if (!skb) {
-			unsigned int metasize;
-
-			/* XDP program may expand or reduce tail */
-			buf1_len = ctx.xdp.data_end - ctx.xdp.data;
-
-			skb = napi_build_skb(page_address(buf->page),
-					     rx_q->napi_skb_frag_size);
-			if (!skb) {
-				page_pool_recycle_direct(rx_q->page_pool,
-							 buf->page);
-				buf->page = NULL;
-				rx_dropped++;
-				count++;
-				goto drain_data;
-			}
-
-			/* XDP program may adjust header */
-			skb_reserve(skb,
-				    ctx.xdp.data - ctx.xdp.data_hard_start);
-			skb_put(skb, buf1_len);
-			skb_mark_for_recycle(skb);
-
-			metasize = ctx.xdp.data - ctx.xdp.data_meta;
-			if (metasize)
-				skb_metadata_set(skb, metasize);
 			buf->page = NULL;
 		} else if (buf1_len) {
-			dma_sync_single_for_cpu(priv->device, buf->addr,
-						buf1_len, dma_dir);
-			skb_add_rx_frag(skb, skb_shinfo(skb)->nr_frags,
-					buf->page, buf->page_offset, buf1_len,
-					priv->dma_conf.dma_buf_sz);
+			if (!stmmac_build_xdp_frags(priv, rx_q, buf1_len,
+						    buf->page,
+						    buf->page_offset,
+						    dma_dir, &ctx.xdp)) {
+				if (!error)
+					rx_dropped++;
+				error = 1;
+			}
 			buf->page = NULL;
 		}
 
 		if (buf2_len) {
-			dma_sync_single_for_cpu(priv->device, buf->sec_addr,
-						buf2_len, dma_dir);
-			skb_add_rx_frag(skb, skb_shinfo(skb)->nr_frags,
-					buf->sec_page, 0, buf2_len,
-					priv->dma_conf.dma_buf_sz);
+			if (!stmmac_build_xdp_frags(priv, rx_q, buf2_len,
+						    buf->sec_page, 0,
+						    dma_dir, &ctx.xdp)) {
+				if (!error)
+					rx_dropped++;
+				error = 1;
+			}
 			buf->sec_page = NULL;
 		}
+		n_descs++;
 
-drain_data:
 		if (likely(status & rx_not_ls))
 			goto read_again;
-		if (!skb)
-			continue;
 
-		/* Got entire packet into SKB. Finish it. */
+		/* ACS is disabled; strip manually. */
+		len -= ETH_FCS_LEN;
+		if (stmmac_xdp_shrink_tail(rx_q, &ctx.xdp, ETH_FCS_LEN)) {
+			if (!error)
+				rx_dropped++;
+			error = 1;
+		}
 
-		/* Remove FCS if needed */
-		if (!fcs_stripped && pskb_trim(skb, len)) {
-			dev_kfree_skb_any(skb);
-			rx_dropped++;
+		if (unlikely(error))
+			goto error_free_frag;
+
+		ctx.desc = p;
+		ctx.ndesc = np;
+
+		skb = stmmac_xdp_run_prog(priv, &ctx.xdp);
+		/* For Not XDP_PASS verdict */
+		if (IS_ERR(skb)) {
+			unsigned int xdp_res = -PTR_ERR(skb);
+
+			if (xdp_res & STMMAC_XDP_CONSUMED) {
+				stmmac_xdp_put_buff(rx_q, &ctx.xdp, true);
+				rx_dropped++;
+			} else if (xdp_res & (STMMAC_XDP_TX |
+					      STMMAC_XDP_REDIRECT)) {
+				xdp_status |= xdp_res;
+			}
 			goto next;
 		}
 
+		skb = stmmac_build_skb(&ctx.xdp);
+		if (!skb) {
+			rx_dropped++;
+			goto error_free_frag;
+		}
+
+		/* Got entire packet into SKB. Finish it. */
 		stmmac_get_rx_hwtstamp(priv, p, np, skb);
 
 		if (priv->hw->hw_vlan_en) {
@@ -6104,15 +6174,23 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
 		rx_bytes += len;
 next:
 		in_progress = false;
-		skb = NULL;
+		n_descs = 0;
+		count++;
+		continue;
+error_free_frag:
+		if (n_descs)
+			stmmac_xdp_put_buff(rx_q, &ctx.xdp, true);
+		in_progress = false;
+		n_descs = 0;
 		count++;
 	}
 
-	if (in_progress || skb) {
-		rx_q->state_saved = true;
-		rx_q->state.skb = skb;
+	if (in_progress || n_descs) {
+		rx_q->state.xdp = ctx.xdp;
+		rx_q->state.n_descs = n_descs;
 		rx_q->state.error = error;
 		rx_q->state.len = len;
+		rx_q->state_saved = true;
 	}
 
 	stmmac_finalize_xdp_rx(priv, xdp_status);
@@ -8129,6 +8207,7 @@ static int __stmmac_dvr_probe(struct device *device,
 	ndev->hw_features = NETIF_F_SG | NETIF_F_IP_CSUM | NETIF_F_IPV6_CSUM |
 			    NETIF_F_RXCSUM;
 	ndev->xdp_features = NETDEV_XDP_ACT_BASIC | NETDEV_XDP_ACT_REDIRECT |
+			     NETDEV_XDP_ACT_RX_SG |
 			     NETDEV_XDP_ACT_XSK_ZEROCOPY;
 
 	/* Default qdisc num_tx_queues */
@@ -8455,9 +8534,12 @@ static void stmmac_reset_rx_queue(struct stmmac_priv *priv, u32 queue)
 {
 	struct stmmac_rx_queue *rx_q = &priv->dma_conf.rx_queue[queue];
 
-	dev_kfree_skb_any(rx_q->state.skb);
-	rx_q->state.skb = NULL;
+	if (rx_q->state.n_descs && !rx_q->xsk_pool) {
+		stmmac_xdp_put_buff(rx_q, &rx_q->state.xdp, false);
+		rx_q->state.n_descs = 0;
+	}
 	rx_q->state_saved = false;
+
 	rx_q->cur_rx = 0;
 	rx_q->dirty_rx = 0;
 }

---
base-commit: 6584acd42820478910a771efb28a355a707e9cb0
change-id: 20260918-stmmac-rx-mb-16469a2714ea

Best regards,
-- 
Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>

