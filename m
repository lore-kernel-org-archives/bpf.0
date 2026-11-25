Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795618159;
	b=FlTwOIcBlyZM60hUt/9U5J+KTeqwz+FNK/WFMPjCGViYtj73iaAZdNk2XSUvNiUD3htY
	 eNcIw3B+1tRFvzmXB3Pk+CIUXEEwbHU+hQNBvna+nCTJOZUIqLjq0ahHdPU5B0n1gCkTy
	 MHMvt4r/B+NN6z1xLiAo6CRZ9yhQwyGzY+imm/Lv3hFSLkwWz/Wdu4LlfPujsTscLVVjl
	 u0y4VLcJ3m9FAMZ18T6gZhr8YpicoyiTfyvvqGbMQ9mj1soR6+v+DxRnNxLAF0aNY5Jon
	 zBBiE2v3NCkMbBptlcovUeHhwF4Kqup0zBTGQ5FvD5UNEsTxCIKfhZuFFoq0fraWPLw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795618159;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=FG6F1MPd7/ppBGO8fakRa3Fq+vuHnKwphQ+D28uefl4=;
	b=qRJj0B99QHHBXIKHwdXVSnI8HeFK6ya17p00EtECpS9fb/m5nQYhxb1PVqYfGh44i8Dp
	 lRaGt65eEkJ0jKEO+vY/sPPyPOllWQTDMsZdLTw4CpbdpcvbXTTUQsEQDk4JrOzNSzRZa
	 zDQ8e9xfq5KmDdH31NYLj9ibf+IG6lBHQKwDBeE/XKHxTK4POWU9uAJ/0qMqFXhUlm7kR
	 OvfKSEWe0wl194Iag4U8MjcN6IPA3XleNQpPKmodj3v8U+zaTymeUbDhILWOh18i0RrKv
	 nzANefpsK/YKEE6nAsyBwvRgN3tE86dUf9tETu8x+fEHuBJyHzlihF0qulw4iVBBhWQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=TOdwFPyo;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=fJkI4DnI;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C50FD606A336
	for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 14:49:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C50FD606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=TOdwFPyo;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=fJkI4DnI
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6APEMAOe1158261
	for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 14:49:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	FG6F1MPd7/ppBGO8fakRa3Fq+vuHnKwphQ+D28uefl4=; b=TOdwFPyoO11pw1pY
	UEendRjrLm/jA/GjCcHwvSvef7PvzP3VkIwf0KUdUEuQV0l6ScAi/NvEZRgazsbg
	MVMN87Gq0ql8iOmMQOSiFv/JQd6j2RDFZhtk+uiws3tNkjT52M2q4pRZP8Piru5p
	buCTkGSl8PBLX5D20JM1EJURpk/OPjz3pyMArxexJ9OSZo0fec9G/Vf4wM2U76AC
	o/3jnL3EsgbshcaQxSNfTDK5zMmcTD2YyG0mUCZkStbaas2OGqykvrHX5bDjhdr0
	OUv6tpco/DPt0okNC4UiM3XNbe4Clzq1Afq04OFurqJGrgrhgIeW67JERf3o7PT2
	7ZHmBw==
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com [209.85.128.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j5vvnsaye-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 14:49:17 +0000 (GMT)
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-8b35b88aa94so73721797b3.3
        for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 06:49:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795618157; x=1796222957; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FG6F1MPd7/ppBGO8fakRa3Fq+vuHnKwphQ+D28uefl4=;
        b=fJkI4DnIU+MDOg7Ze0PZeRBOzMi6bPgG/IYpBzgyniSkJLtxOPSNeqHHodGxjbOMy9
         srghNrn/ALFStapRGJ83QDLwKE0Y5GIvczNoV2JqCXog9f4YS5wkCZJyTaKDoRUVA3aQ
         xxz1pYfxVcSmhXwCSM3DIo4JYUKblnQw7MhkYgzLMPxj29er7tdfC9os/2r4Ddh0paWm
         tTNfH6Lk1UkDKeJAP6AB1JcZczlGjjoHpFrfo5P7GrE5ocfnJeosrhRnXEpsnx3NdN0c
         ctstbB+RDUVlytjAP5lAeXDRy+srpUC0q5TR2jfhQeZJawIPIJBghFVpiH2kPb0giU95
         LH5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795618157; x=1796222957;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FG6F1MPd7/ppBGO8fakRa3Fq+vuHnKwphQ+D28uefl4=;
        b=I3ztkUThXB1HTySOhh7/wKYMP4DePDYnzb/OkEL3hNJ955fGNMN+ctluNNp8a0FRyA
         KUrPaoJNEs4McKsLj9hR88ix1/KsQDLYU+JWgvmFUPeAXFR5v+H6+u8Y/hVZIGW+qXnx
         gZjoj0+KCpq0nqD93fCxlYO3DoUVfxGnWX4c2sOhOyJWX/iysSecTmZ+DasoV7KIa8UH
         ECMWIUlhsp2dXDakf0d9vnT2fUpRRg/Qgffh3mtyizfy3EILBwFxHcieqq2bFSRwriGL
         daST0M03AwBRog1sWPj2W039BXBNHEXLG3/IgXwM3VufXySs/L5BPRzLKGw8i80tg1Sv
         4XHA==
X-Forwarded-Encrypted: i=1; AL+hErFWSZYDYz8Dv+rQ4IyAl+EMU2zOr6qxOUqObCZigI9gt4B82e/ekfpafxdHAPexHqjqlVI=@vger.kernel.org
X-Gm-Message-State: APuU4Z9V2aOSo7z79YqdrisrxC9PCi85xTUc9FGEuk45JSfB9p0geck+
	F+dgjBoG2TScDj5XTn87GAsFg7oQk5dpw8WchKWbdBY6F1t7teeTxh/RSKbjCuf2eJMjdyHvxHd
	NesR+BAq5JJdMG9TZLhbETQNv7A4O9uHD3lN6brJUw20WayClownzRn4=
X-Gm-Gg: AZFdTZd4Um162u1FTfNNhcTW53CNm+8JSK/hQ/oCahcJkVrYsSy0t4wdZh2ilEFZQ1K
	XodrLzt5T8FS3aPu0+vgfRKGP2Yx4G+8kUeML4PBE1zZbHKYMA/uTicIxBN3DgxJVvSl2zXJ697
	0OKiZGmM8aOTGEh6CjVReFwGYako2VBgR71W6jT3bEcVOmWkkkXFbEN5Os+jfWGTxtTljePi799
	VrMSfoXhUdT3OTNzy7FLfd1IoH41Yakuqz5NH1J8Y6BCGv/xEz5cZQSszfHSfcF9/I+SsTJmNaF
	JXTE5MRYA8Da0PLh2grXSODltU+EQieDln8y9FRolLV4d8niDwC1UzgtCll/TPkLyes9yAvIgcw
	wschVXT24G7n/9GaUFef+MJ+v3fGr0vRKkc/5jsNA/MGjoq6+fovqXRVOYCX9plM=
X-Received: by 2002:a05:690c:61c4:b0:8b4:d554:3245 with SMTP id 00721157ae682-8b520435e12mr61349107b3.26.1795618156782;
        Wed, 25 Nov 2026 06:49:16 -0800 (PST)
X-Received: by 2002:a05:690c:61c4:b0:8b4:d554:3245 with SMTP id 00721157ae682-8b520435e12mr61348857b3.26.1795618156087;
        Wed, 25 Nov 2026 06:49:16 -0800 (PST)
Received: from localhost ([188.152.73.83])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6baa3c4dsm29175679f8f.46.2026.11.25.06.49.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 06:49:15 -0800 (PST)
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Date: Wed, 25 Nov 2026 15:48:47 +0100
Subject: [PATCH net-next v13 2/5] net: stmmac: remove software VLAN tag
 stripping
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
Message-Id: <20261125-stmmac-rx-mb-v13-2-0f6bac53e8d5@oss.qualcomm.com>
References: <20261125-stmmac-rx-mb-v13-0-0f6bac53e8d5@oss.qualcomm.com>
In-Reply-To: <20261125-stmmac-rx-mb-v13-0-0f6bac53e8d5@oss.qualcomm.com>
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
        Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI1MDA1OCBTYWx0ZWRfX3Zmtd2d6S4H2
 6ZJR1nhlKlBdtNPKgShnUpsunXdIVLWkmKq3Sts9pnuPaZRfVJBYr87jFXdBFoVHaNviYAYrDrm
 FNy/WXpn8ZKAaYZNHjQuIO7FF081dmyl9yUGUjrkM6DoxN3IeJcWtRBh/oHfJlH4uR46I+/b3Fa
 ne1suDJvqX5qIQ+neOwufRE147DU4PejtdJrUoVdN+ZSQr/oVXGV2i5xAqbRo62N7r7BwLiNSpW
 fgeCblFlETgiQpkQYHREeNV6QVYN85kiwN9HTOvxw6lz2vxNdQMsuviGdJWxUVWk6Gy1b6K04IC
 dIteeT4kpHxB01EK8F8ggd67DfLnIQQbhsHc6qCv4I7/T381z/PfBBSCVOlYosn3N7eSPRRoaKq
 CXqqVNV5ykZsqdqJD5y9TeYzqIqo045K6JNwyH+7nA4a/2WF2A4LrrRYL9M32CYvNV7JPkW8WGP
 3PxuynlshCiUd9Nnlyg==
X-Proofpoint-ORIG-GUID: sUukZRZE5Ldf-TebrGbTNwbXxnGopm2O
X-Proofpoint-GUID: sUukZRZE5Ldf-TebrGbTNwbXxnGopm2O
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI1MDA1OCBTYWx0ZWRfXy/AtCA5jyJuE
 fs5ao98Jsa1CUgJrBwFvx8RjesTRTgR71VU1S+sEZV7i2eN9YQQsPREZ29Ryq6d6E88zH3jLg5S
 PZq6QoyrWPTeK+2ltXf8DZ2irQtl1dE=
X-Authority-Analysis: v=2.4 cv=R4mWitRX c=1 sm=1 tr=0 ts=6b06f56d cx=c_pps
 a=g1v0Z557R90hA0UpD/5Yag==:117 a=mlS0om9xteqVCAF/aDpb2g==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=P-IC7800AAAA:8 a=1RTuLK3dAAAA:8 a=EUspDBNiAAAA:8 a=EH79fr7-9Oi-GOabCPsA:9
 a=QEXdDO2ut3YA:10 a=MFSWADHSvvjO3QEy5MdX:22 a=d3PnA9EDa4IxuAV0gXij:22
 a=kRpfLKi8w9umh8uBmg1i:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-25_04,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 bulkscore=0 adultscore=0 clxscore=1015
 impostorscore=0 spamscore=0 phishscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611250058

The software VLAN stripping logic in stmmac_rx_vlan() was originally
introduced in 2014 by commit b93819854d6e ("stmmac: Add vlan rx for
better GRO performance.") as a workaround to improve GRO performance,
since at that time GRO could not handle frames with VLAN tags. However,
this limitation was resolved in 2015 by commit 66e5133f19e9 ("vlan: Add
GRO support for non hardware accelerated vlan"), which added GRO support
for non-hardware-accelerated VLAN frames. Keeping a software fallback
path for VLAN stripping is no longer necessary and only adds complexity.

After removing it, VLAN tags remain in the packet, so
stmmac_has_ip_ethertype() has to keep recognising IPv4/IPv6 behind a
single in-payload VLAN tag. On RX the helper runs after eth_type_trans(),
which has already pulled the Ethernet header, so walk the tag chain with
skb_mac_offset() instead of __vlan_get_protocol(), which assumes the MAC
header still sits at skb->data. On TX the helper still runs before the
header is pulled.

Make the tolerated L2 depth explicit:
- on RX allow a single in-payload C-tag while the MAC is not stripping
  tags (VLAN_ETH_HLEN); when HW stripping is active the payload must be
  tag-free, so keep the ETH_HLEN limit and reject any tag that is still
  there;
- in-payload S-tags are always rejected, as only an S-tag that the
  hardware stripped (and whose type is reported through
  get_rx_vlan_proto) is known to have been parsed by the checksum engine;
- on TX keep the old ETH_HLEN limit, so DSA-tagged frames that the
  checksum engine ignores (see commit c2945c435c99 ("net: stmmac:
  Prevent DSA tags from breaking COE")) remain excluded from hardware
  checksum and TSO.

This intentionally changes the advertised features:
- dwmac100/dwmac1000 no longer advertise NETIF_F_HW_VLAN_CTAG_RX;
  they have no hardware VLAN stripping.
- On xmac cores NETIF_F_HW_VLAN_CTAG_RX is advertised only when the
  VLAN ops provide .set_hw_vlan_mode and .rx_hw_vlan, so DWXLGMAC no
  longer falsely advertises RX VLAN offload.
- NETIF_F_HW_VLAN_STAG_RX is advertised only on cores that provide
  hardware RX VLAN offload and whose descriptor ops report the stripped
  tag protocol (get_rx_vlan_proto), i.e. DWXGMAC. DWXLGMAC loses it
  because it has no RX VLAN offload, while cores without
  get_rx_vlan_proto report stripped S-tags as C-tags.

The DWXLGMAC mis-advertisement was introduced when the RX VLAN offload
gate was widened to all xmac cores, so tag the fix accordingly.

With NETIF_F_VLAN_FEATURES possibly empty, EEE RX clock stop may be
enabled on some platforms; the preceding selftests patch blocks RX
clock stop while the ethtool selftests run.

This depends on the preceding selftests fix.

Fixes: 534df0c1724b ("net: stmmac: dwxgmac2: Add support for HW-accelerated VLAN stripping")
Suggested-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
Co-developed-by: Peilin He <he.peilin@zte.com.cn>
Signed-off-by: Peilin He <he.peilin@zte.com.cn>
Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac.h      | 12 +++
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 89 ++++++++---------------
 2 files changed, 44 insertions(+), 57 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac.h b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
index fcc395321816..fa9ef4212982 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac.h
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
@@ -478,4 +478,16 @@ static inline int stmmac_selftest_get_count(struct stmmac_priv *priv)
 }
 #endif /* CONFIG_STMMAC_SELFTESTS */
 
+static inline bool stmmac_rx_8021q_offload(struct stmmac_priv *priv)
+{
+	return priv->hw->vlan && priv->hw->vlan->set_hw_vlan_mode &&
+	       priv->hw->vlan->rx_hw_vlan;
+}
+
+static inline bool stmmac_rx_8021ad_offload(struct stmmac_priv *priv)
+{
+	return stmmac_rx_8021q_offload(priv) &&
+	       priv->hw->desc->get_rx_vlan_proto;
+}
+
 #endif /* __STMMAC_H__ */
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index ca4c7fb11b73..7896364c43e9 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -4879,7 +4879,9 @@ static netdev_tx_t stmmac_tso_xmit(struct sk_buff *skb, struct net_device *dev)
 
 /**
  * stmmac_has_ip_ethertype() - Check if packet has IP ethertype
+ * @priv: driver private structure
  * @skb: socket buffer to check
+ * @xmit: transmit path
  *
  * Check if a packet has an ethertype that will trigger the IP header checks
  * and IP/TCP checksum engine of the stmmac core.
@@ -4887,16 +4889,25 @@ static netdev_tx_t stmmac_tso_xmit(struct sk_buff *skb, struct net_device *dev)
  * Return: true if the ethertype can trigger the checksum engine, false
  * otherwise
  */
-static bool stmmac_has_ip_ethertype(struct sk_buff *skb)
+static bool stmmac_has_ip_ethertype(struct stmmac_priv *priv,
+				    struct sk_buff *skb, bool xmit)
 {
-	int depth = 0;
-	__be16 proto;
+	__be16 proto, h_proto = eth_header_parse_protocol(skb);
+	int max_l2_hlen, depth = 0;
+
+	/* An S-tag still in the payload may not have been parsed by the
+	 * checksum engine; only trust it when the hardware stripped it, in
+	 * which case h_proto is no longer ETH_P_8021AD.
+	 */
+	if (h_proto == htons(ETH_P_8021AD))
+		return false;
 
-	proto = __vlan_get_protocol(skb, eth_header_parse_protocol(skb),
-				    &depth);
+	proto = vlan_get_protocol_offset_inline(skb, h_proto,
+						skb_mac_offset(skb), &depth);
 
-	return (depth <= ETH_HLEN) &&
-		(proto == htons(ETH_P_IP) || proto == htons(ETH_P_IPV6));
+	max_l2_hlen = xmit || priv->hw->hw_vlan_en ? ETH_HLEN : VLAN_ETH_HLEN;
+	return depth <= max_l2_hlen &&
+	       (proto == htons(ETH_P_IP) || proto == htons(ETH_P_IPV6));
 }
 
 /**
@@ -5153,7 +5164,7 @@ static netdev_features_t stmmac_features_check(struct sk_buff *skb,
 	 * harmonize_features() in net/core/dev.c
 	 */
 	if (priv->plat->tx_queues_cfg[queue].coe_unsupported ||
-	    !stmmac_has_ip_ethertype(skb))
+	    !stmmac_has_ip_ethertype(priv, skb, true))
 		features &= ~(NETIF_F_IP_CSUM | NETIF_F_IPV6_CSUM);
 
 	if (skb_is_gso(skb)) {
@@ -5175,37 +5186,6 @@ static netdev_features_t stmmac_features_check(struct sk_buff *skb,
 	return vlan_features_check(skb, features);
 }
 
-static int stmmac_rx_vlan(struct net_device *dev, struct sk_buff *skb)
-{
-	struct vlan_ethhdr *veth;
-
-	if (!pskb_may_pull(skb, ETH_HLEN))
-		return -EINVAL;
-
-	veth = skb_vlan_eth_hdr(skb);
-	if ((veth->h_vlan_proto == htons(ETH_P_8021Q) &&
-	     dev->features & NETIF_F_HW_VLAN_CTAG_RX) ||
-	    (veth->h_vlan_proto == htons(ETH_P_8021AD) &&
-	     dev->features & NETIF_F_HW_VLAN_STAG_RX)) {
-		__be16 vlan_proto = veth->h_vlan_proto;
-		u8 meta_len = skb_metadata_len(skb);
-		u16 vlanid;
-
-		/* pop the vlan tag */
-		if (!pskb_may_pull(skb, VLAN_ETH_HLEN))
-			return -EINVAL;
-
-		veth = skb_vlan_eth_hdr(skb);
-		vlanid = ntohs(veth->h_vlan_TCI);
-		memmove(skb->data - meta_len + VLAN_HLEN,
-			skb->data - meta_len, meta_len + ETH_ALEN * 2);
-		skb_pull(skb, VLAN_HLEN);
-		__vlan_hwaccel_put_tag(skb, vlan_proto, vlanid);
-	}
-
-	return 0;
-}
-
 static bool stmmac_rx_need_ic(struct stmmac_priv *priv,
 			      struct stmmac_rx_queue *rx_q, u32 queue)
 {
@@ -5626,15 +5606,11 @@ static void stmmac_dispatch_skb_zc(struct stmmac_priv *priv, u32 queue,
 	if (priv->hw->hw_vlan_en) {
 		/* MAC level stripping. */
 		stmmac_rx_hw_vlan(priv, priv->hw, p, skb);
-	} else if (stmmac_rx_vlan(priv->dev, skb)) {
-		dev_kfree_skb_any(skb);
-		priv->xstats.rx_dropped++;
-		return;
 	}
 
 	skb->protocol = eth_type_trans(skb, priv->dev);
 
-	if (unlikely(!coe) || !stmmac_has_ip_ethertype(skb) ||
+	if (unlikely(!coe) || !stmmac_has_ip_ethertype(priv, skb, false) ||
 	    (status & csum_none))
 		skb_checksum_none_assert(skb);
 	else
@@ -6142,15 +6118,12 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
 		if (priv->hw->hw_vlan_en) {
 			/* MAC level stripping. */
 			stmmac_rx_hw_vlan(priv, priv->hw, p, skb);
-		} else if (stmmac_rx_vlan(priv->dev, skb)) {
-			dev_kfree_skb_any(skb);
-			rx_dropped++;
-			goto next;
 		}
 
 		skb->protocol = eth_type_trans(skb, priv->dev);
 
-		if (unlikely(!coe) || !stmmac_has_ip_ethertype(skb) ||
+		if (unlikely(!coe) ||
+		    !stmmac_has_ip_ethertype(priv, skb, false) ||
 		    (status & csum_none))
 			skb_checksum_none_assert(skb);
 		else
@@ -6429,7 +6402,7 @@ static netdev_features_t stmmac_fix_features(struct net_device *dev,
 	if (priv->plat->bugged_jumbo && (dev->mtu > ETH_DATA_LEN))
 		features &= ~NETIF_F_CSUM_MASK;
 
-	if (priv->plat->core_type == DWMAC_CORE_XGMAC) {
+	if (stmmac_rx_8021ad_offload(priv)) {
 		if (features & NETIF_F_HW_VLAN_CTAG_RX)
 			features |= NETIF_F_HW_VLAN_STAG_RX;
 		else
@@ -6462,7 +6435,7 @@ static int stmmac_set_features(struct net_device *netdev,
 			stmmac_enable_sph(priv, priv->ioaddr, sph_en, chan);
 	}
 
-	if (features & NETIF_F_HW_VLAN_CTAG_RX)
+	if (features & (NETIF_F_HW_VLAN_CTAG_RX | NETIF_F_HW_VLAN_STAG_RX))
 		priv->hw->hw_vlan_en = true;
 	else
 		priv->hw->hw_vlan_en = false;
@@ -8275,15 +8248,17 @@ static int __stmmac_dvr_probe(struct device *device,
 	ndev->features |= ndev->hw_features | NETIF_F_HIGHDMA;
 	ndev->watchdog_timeo = msecs_to_jiffies(watchdog);
 #ifdef STMMAC_VLAN_TAG_USED
-	/* Both mac100 and gmac support receive VLAN tag detection */
-	ndev->features |= NETIF_F_HW_VLAN_CTAG_RX;
-	if (priv->plat->core_type == DWMAC_CORE_XGMAC)
-		ndev->features |= NETIF_F_HW_VLAN_STAG_RX;
-
-	if (dwmac_is_xmac(priv->plat->core_type)) {
+	if (stmmac_rx_8021q_offload(priv)) {
+		ndev->features |= NETIF_F_HW_VLAN_CTAG_RX;
 		ndev->hw_features |= NETIF_F_HW_VLAN_CTAG_RX;
 		priv->hw->hw_vlan_en = true;
 	}
+
+	if (stmmac_rx_8021ad_offload(priv)) {
+		ndev->features |= NETIF_F_HW_VLAN_STAG_RX;
+		ndev->hw_features |= NETIF_F_HW_VLAN_STAG_RX;
+	}
+
 	if (priv->dma_cap.vlhash) {
 		ndev->features |= NETIF_F_HW_VLAN_CTAG_FILTER;
 		if (priv->plat->core_type == DWMAC_CORE_XGMAC)

-- 
2.56.1

