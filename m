Received: from mx0a-00190b01.pphosted.com (mx0a-00190b01.pphosted.com [67.231.149.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 299D63EB0F7;
	Wed, 12 Aug 2026 08:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786523522; cv=none; b=nLlj32m12gZDSJAQJy2y2w/z3XotJuBJOxSVx0lAZZzArAlLAmg+LD6+gyLWmggYpiAsFuCiTaPiLkhnzv+LFNudzqTc1Z2BptXWklZdoo48fhwu6TeM3AqlTTcOFCRKWDl0/q74o7pfzEG2Xddg3EHWyTp+eyF28RErJCcavhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786523522; c=relaxed/simple;
	bh=e1uS/hSg+6fPBXFtrp+JpxyU587yuJstxwkSaGa8h0U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=S2milSg2ryRJLk7lwbBTLglKnU181sx/CfstyLUrTI5+fOIOUtSGwL50T8IYu2/N94kXkDshFmBAdGwSf5ebhMW18lFX+x2UdRRbZb8lwcIcKWpzZme6jejLrHz1bKdV0yRAZmwa4jiwcjmojJ5nTcEbejeMOe8c7HLPeSgnCoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=akamai.com; spf=pass smtp.mailfrom=akamai.com; dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b=f27fgoTG; arc=none smtp.client-ip=67.231.149.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=akamai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=akamai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b="f27fgoTG"
Received: from pps.filterd (m0409408.ppops.net [127.0.0.1])
	by m0409408.ppops.net-00190b01. (8.18.1.11/8.18.1.11) with ESMTP id 67C63MXC1516807;
	Wed, 12 Aug 2026 09:31:38 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=apr2026.eng; bh=+d2oDq41o
	Zc+OhQNklBC1bE4E1YAiLf9VIvqsG90k6I=; b=f27fgoTGnGZW51I2q5GOftahs
	l52mlzx85Ek5rNaIXAa6Bwb3BFV+l3MjJ8ZlFLKK3tzVEs6uRNDy4w4YQyHjoeou
	iz3DeX/i8cHGvk4WRbowmOrNOphPksubMWmmcMlxxbc/eDLYtkcD5J8Zb+mncOiU
	/MhdV5aHADZtpTUdL9LKOeQoNcxtJ/WuwNOQK54tRyXdFr15qbnNZiGESuDwlYuo
	FsvIqZFAe9fGtNPhNuRTPpP39tziwFa0bX8d2POQyc7JGyDLbxGPV7Oq16w7wXCM
	lqE6GyS6/E3EFSALNO3yjUhHLfPSmglbi/Pu5+lwLe9+Q38nvY1UH35VrsGUQ==
Received: from prod-mail-ppoint6 (prod-mail-ppoint6.akamai.com [184.51.33.61])
	by m0409408.ppops.net-00190b01. (PPS) with ESMTPS id 4fxfc80v66-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 09:31:35 +0100 (BST)
Received: from pps.filterd (prod-mail-ppoint6.akamai.com [127.0.0.1])
	by prod-mail-ppoint6.akamai.com (8.18.1.7/8.18.1.7) with ESMTP id 67C8JYMZ004674;
	Wed, 12 Aug 2026 04:31:33 -0400
Received: from prod-mail-relay01.akamai.com ([172.27.118.31])
	by prod-mail-ppoint6.akamai.com (PPS) with ESMTP id 4fwystf0cb-1;
	Wed, 12 Aug 2026 04:31:33 -0400 (EDT)
Received: from muc-lhvdhd.munich.corp.akamai.com (muc-lhvdhd.munich.corp.akamai.com [172.29.0.147])
	by prod-mail-relay01.akamai.com (Postfix) with ESMTP id 47A7280;
	Wed, 12 Aug 2026 08:31:31 +0000 (UTC)
From: Nick Hudson <nhudson@akamai.com>
To: bpf@vger.kernel.org, netdev@vger.kernel.org,
        Willem de Bruijn <willemb@google.com>,
        Martin KaFai Lau <martin.lau@linux.dev>
Cc: Nick Hudson <nhudson@akamai.com>, Max Tottenham <mtottenh@akamai.com>,
        Anna Glasgall <aglasgal@akamai.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Eduard Zingerman <eddyz87@gmail.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v7 5/6] bpf: clear decap state on skb_adjust_room shrink path
Date: Wed, 12 Aug 2026 09:31:14 +0100
Message-Id: <20260812083115.73100-6-nhudson@akamai.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260812083115.73100-1-nhudson@akamai.com>
References: <20260812083115.73100-1-nhudson@akamai.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_02,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 phishscore=0 bulkscore=0 suspectscore=0 spamscore=0 malwarescore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2606160000
 definitions=main-2608120066
X-Authority-Analysis: v=2.4 cv=U4Ciy+ru c=1 sm=1 tr=0 ts=6a7c2f67 cx=c_pps
 a=WPLAOKU3JHlOa4eSsQmUFQ==:117 a=WPLAOKU3JHlOa4eSsQmUFQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Ifg-1AOnLHOf1gn6spyb:22
 a=BYUV7c42er6_Rx9bq0XK:22 a=X7Ea-ya5AAAA:8 a=1XWaLZrsAAAA:8
 a=cwecSWJ0lc1IdipTo1IA:9
X-Proofpoint-ORIG-GUID: 4VvO-i1EkFLWB5KI8J8VwgIyDmgNaUxo
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDA2NyBTYWx0ZWRfX/wJjiHF5fIOU
 HkDvcW40Gk0F1V1qAgtBs66qG5b7iqbqQ8FkoZ9PPNq5qcRwXPySYRybV5HEYOVLyIdF5dzrxXw
 rDjFb6+9Sewu5uNA+cRUpOZVfMq4jAo=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDA2NyBTYWx0ZWRfXyXxeMCHzUiOf
 w6lTkRqQU9nvcBpkKflW7sSOLT1nganLO+94i3Fpc0jUSEQnN6f8Q5RyTBjAxt8RghODgoW3hA0
 sohL3J1i2HDCr1PMDEn2EA9dPQ/2jAO/izJO3C7ilGWpWe5p9vsPQZLL3X5h0tzVVngj+bnQo25
 adFBcPRWoIvmyR8UqlJpFir2d0JOEHUTXTpXOWIhsxX+WzjLcaxSuL7vmr6ExfAfERo0Ojuicli
 pYkoZy/OfI28hr0bTLOMOZ4wyz4VABZQgi7h2EervMJo4qmockRBfoZPL+acAJUovP0Z7R+S+PF
 lOlcrihdWRSciDVfo31v0osWrv18s/ImmnMHaLtvmXG6LiNyVRLBRicZmDSvXXsJ/GGp6Eshoad
 LKt+uhYNWDyTNbbng0hj/TIzqwe9UVTGxLKwQsIm0rPVJYJA+zEF+Sm0CIwp2XT5O2pXJ4lQBUq
 bo87JTlRoGcSu85OT1g==
X-Proofpoint-GUID: 4VvO-i1EkFLWB5KI8J8VwgIyDmgNaUxo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_02,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 adultscore=0 malwarescore=0 spamscore=0 impostorscore=0 clxscore=1015
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606160001 definitions=main-2608120067

On shrink in bpf_skb_adjust_room(), apply decapsulation state updates
according to BPF_F_ADJ_ROOM_DECAP_* flags.

For GSO skbs, clear only the tunnel gso_type bits that correspond to the
requested decap layer:
- DECAP_L4_UDP: SKB_GSO_UDP_TUNNEL{,_CSUM}
- DECAP_L4_GRE: SKB_GSO_GRE{,_CSUM}
- DECAP_IPXIP4: SKB_GSO_IPXIP4
- DECAP_IPXIP6: SKB_GSO_IPXIP6

Then clear skb->encapsulation only if no tunnel GSO bits remain, keeping
encapsulation set for cases such as ESP-in-UDP where tunnel state remains.

For non-GSO skbs, there are no tunnel GSO bits to consult, so clear
skb->encapsulation directly when DECAP_L4_* or DECAP_IPXIP_* flags are set.

This keeps decap state handling consistent between GSO and non-GSO packets.

Co-developed-by: Max Tottenham <mtottenh@akamai.com>
Signed-off-by: Max Tottenham <mtottenh@akamai.com>
Co-developed-by: Anna Glasgall <aglasgal@akamai.com>
Signed-off-by: Anna Glasgall <aglasgal@akamai.com>
Signed-off-by: Nick Hudson <nhudson@akamai.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
---
 net/core/filter.c | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/net/core/filter.c b/net/core/filter.c
index 981b75941e7f..89effff3bc52 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -3754,9 +3754,48 @@ static int bpf_skb_net_shrink(struct sk_buff *skb, u32 off, u32 len_diff,
 		if (!(flags & BPF_F_ADJ_ROOM_FIXED_GSO))
 			skb_increase_gso_size(shinfo, len_diff);
 
+		/* Selective GSO flag clearing based on decap type.
+		 * Only clear the flags for the tunnel layer being removed.
+		 */
+		if ((flags & BPF_F_ADJ_ROOM_DECAP_L4_UDP) &&
+		    (shinfo->gso_type & (SKB_GSO_UDP_TUNNEL |
+					 SKB_GSO_UDP_TUNNEL_CSUM)))
+			shinfo->gso_type &= ~(SKB_GSO_UDP_TUNNEL |
+					      SKB_GSO_UDP_TUNNEL_CSUM);
+		if ((flags & BPF_F_ADJ_ROOM_DECAP_L4_GRE) &&
+		    (shinfo->gso_type & (SKB_GSO_GRE | SKB_GSO_GRE_CSUM)))
+			shinfo->gso_type &= ~(SKB_GSO_GRE |
+					      SKB_GSO_GRE_CSUM);
+		if ((flags & BPF_F_ADJ_ROOM_DECAP_IPXIP4) &&
+		    (shinfo->gso_type & SKB_GSO_IPXIP4))
+			shinfo->gso_type &= ~SKB_GSO_IPXIP4;
+		if ((flags & BPF_F_ADJ_ROOM_DECAP_IPXIP6) &&
+		    (shinfo->gso_type & SKB_GSO_IPXIP6))
+			shinfo->gso_type &= ~SKB_GSO_IPXIP6;
+
+		/* Clear encapsulation flag only when no tunnel GSO flags remain */
+		if (flags & (BPF_F_ADJ_ROOM_DECAP_L4_MASK |
+			     BPF_F_ADJ_ROOM_DECAP_IPXIP_MASK)) {
+			if (!(shinfo->gso_type & (SKB_GSO_UDP_TUNNEL |
+						  SKB_GSO_UDP_TUNNEL_CSUM |
+						  SKB_GSO_GRE |
+						  SKB_GSO_GRE_CSUM |
+						  SKB_GSO_IPXIP4 |
+						  SKB_GSO_IPXIP6 |
+						  SKB_GSO_ESP)))
+				if (skb->encapsulation)
+					skb->encapsulation = 0;
+		}
+
 		/* Header must be checked, and gso_segs recomputed. */
 		shinfo->gso_type |= SKB_GSO_DODGY;
 		shinfo->gso_segs = 0;
+	} else {
+		/* For non-GSO packets, clear encapsulation if decap flags are set */
+		if ((flags & (BPF_F_ADJ_ROOM_DECAP_L4_MASK |
+			      BPF_F_ADJ_ROOM_DECAP_IPXIP_MASK)) &&
+		    skb->encapsulation)
+			skb->encapsulation = 0;
 	}
 
 	return 0;
-- 
2.34.1

