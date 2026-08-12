Received: from mx0a-00190b01.pphosted.com (mx0a-00190b01.pphosted.com [67.231.149.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12FFD383C89;
	Wed, 12 Aug 2026 08:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786523521; cv=none; b=JE3qcHh/D3lth3cKaPlUI/AEBIKSl/DnYp4QlMUcK/9NdFpjunEE8IdOjv+c0gnKwWpJ+lOWTJTPl/n/kiTMkRGOv4PpV683PSGE0PIAzNLU03NYpTuldSy5YLJPyMV7d6b7qndbVWXu9TJ1bEnoUgMneE5vjiwaBS/1Vf4cGqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786523521; c=relaxed/simple;
	bh=sXTmbG/f5byu7LKBkQCTR06Us+eFUBnt3s91bms2h24=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BSVUtBybc5Rup6R47w2AydAYis6CdrrJZLoz+kOQ1y9MZsUN8CHH8WHmrea3RnKeWKJlqpEe5/FbbfdHvT9IBtNKwbAVfjL/rptClXib+uQrCsWhQ1/h+C7FeaRiDT9jH+IUIWiZh1MnvLqApTte+6haASbjw9rlsIL05e5ft1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=akamai.com; spf=pass smtp.mailfrom=akamai.com; dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b=aneCS7f+; arc=none smtp.client-ip=67.231.149.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=akamai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=akamai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b="aneCS7f+"
Received: from pps.filterd (m0050093.ppops.net [127.0.0.1])
	by m0050093.ppops.net-00190b01. (8.18.1.11/8.18.1.11) with ESMTP id 67C63Y6I2560198;
	Wed, 12 Aug 2026 09:31:33 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=apr2026.eng; bh=yyPdj6sfL
	w7vKEtNc9hqa1LduSFcAIcDGOf1SNRjgDs=; b=aneCS7f+X7VUEDg/Qh0GT405F
	yA6zdrCd6R7tMpd5UrfRTUwY1PibViafeqkj8uRo4sYLQZ1lKK/jvG2pes7nqmF4
	Ycji47906B8F0oDkKMhCLuu4x9XRHUKL5d7SWu1mBsVpzMwOEHPsYZRQNlBKBfHY
	I90o/VE1XC+b5AtChX5g5dfrAyhhJ6Y8t4BVAlmJxNbrRaaH2oVWDDUECkAuRlcG
	M/jdSs/EYeVpa8l3o1xUxLgAaWselPWaD+SuGx+Ny4i15kYTVlqup861/KyJZqCG
	FRa9YClnOFR0Fqyv7tqWKafB4H9do/Iq/tgF1plBO5NADIZ1CQFj4qbU28fng==
Received: from prod-mail-ppoint5 (prod-mail-ppoint5.akamai.com [184.51.33.60])
	by m0050093.ppops.net-00190b01. (PPS) with ESMTPS id 4fwuqp6xh9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 09:31:32 +0100 (BST)
Received: from pps.filterd (prod-mail-ppoint5.akamai.com [127.0.0.1])
	by prod-mail-ppoint5.akamai.com (8.18.1.7/8.18.1.7) with ESMTP id 67C8JjHR031149;
	Wed, 12 Aug 2026 01:31:31 -0700
Received: from prod-mail-relay01.akamai.com ([172.27.118.31])
	by prod-mail-ppoint5.akamai.com (PPS) with ESMTP id 4fx2e7xnv2-1;
	Wed, 12 Aug 2026 01:31:31 -0700 (PDT)
Received: from muc-lhvdhd.munich.corp.akamai.com (muc-lhvdhd.munich.corp.akamai.com [172.29.0.147])
	by prod-mail-relay01.akamai.com (Postfix) with ESMTP id 170AE87;
	Wed, 12 Aug 2026 08:31:28 +0000 (UTC)
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
Subject: [PATCH bpf-next v7 4/6] bpf: allow new DECAP flags and add guard rails
Date: Wed, 12 Aug 2026 09:31:13 +0100
Message-Id: <20260812083115.73100-5-nhudson@akamai.com>
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
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 bulkscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2606160000
 definitions=main-2608120066
X-Proofpoint-ORIG-GUID: 40AOGrOOpRmJ8bDUCVflWPYq7tDyGkpL
X-Authority-Analysis: v=2.4 cv=b/KCJNGx c=1 sm=1 tr=0 ts=6a7c2f64 cx=c_pps
 a=NpDlK6FjLPvvy7XAFEyJFw==:117 a=NpDlK6FjLPvvy7XAFEyJFw==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Ifg-1AOnLHOf1gn6spyb:22
 a=d4nn1RXdvEacMIURMw2s:22 a=X7Ea-ya5AAAA:8 a=1XWaLZrsAAAA:8
 a=Hfnf2daL9bryszF4jIsA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDA2NyBTYWx0ZWRfX+CttmMnKIYvv
 MKwoSd/dS4Kke/fIScGoQQehUxI8f91BbaHxXClOc9MrHRJ5C4zkjkNrWggeotUjWhuyulL2ehK
 xkSkQZIBgRc3NDl8g4pP22lEK/wOAwc=
X-Proofpoint-GUID: 40AOGrOOpRmJ8bDUCVflWPYq7tDyGkpL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDA2NyBTYWx0ZWRfX8X+5McIoztYv
 P7dHoQ7AtAmxS+93suQp/IRZZ9jx7EdetOTCv3KzSfIMW/i+a3oT2GB2goCgriHqUppTwV16kvC
 WvnpzYbtRUuDiQLznaGKO9XQJAfeflEgZZacV4JZhX/v/Go7nm/KzYGSZHu16PWgwDJ6tDstj7a
 kuR2rnEqeoSdgsWuZDCL7JgQxw3u3d2+m1+TrtjAzm9Ppf8kb209aPysfDMFDPzRKUd4CHunub5
 QVawuk2UoHU6KnZpXv8yesl+waMFULS26cDWCbYy/PcnhV37xQm4oXCLKWD8aS40RQzCdFXOsDn
 a9qlk1Gw59hyf32tykRtAs9JpFGWxT/hWaEe/i26ef3BJVnN22MtRSBSO8TouCITF5djlNM+YVe
 VZlw5+3ArxpNHiNLcyPWxRca1bZJNuuGa/50HYV+pfugJssPPxXuX2uCo2gZK9FNQpfWrfOhbpp
 uKtqankgl3LvpkW/gHw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_02,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 suspectscore=0 phishscore=0 bulkscore=0 impostorscore=0
 clxscore=1015 malwarescore=0 adultscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606160001 definitions=main-2608120067

Add checks to require shrink-only decap, reject conflicting decap flag
combinations, and verify removed length is sufficient for claimed header
decapsulation.

Co-developed-by: Max Tottenham <mtottenh@akamai.com>
Signed-off-by: Max Tottenham <mtottenh@akamai.com>
Co-developed-by: Anna Glasgall <aglasgal@akamai.com>
Signed-off-by: Anna Glasgall <aglasgal@akamai.com>
Signed-off-by: Nick Hudson <nhudson@akamai.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
---
 net/core/filter.c | 44 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 43 insertions(+), 1 deletion(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index 89e516049c85..981b75941e7f 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -56,6 +56,7 @@
 #include <net/sock_reuseport.h>
 #include <net/busy_poll.h>
 #include <net/tcp.h>
+#include <net/gre.h>
 #include <net/xfrm.h>
 #include <net/udp.h>
 #include <linux/bpf_trace.h>
@@ -3572,6 +3573,12 @@ static u32 bpf_skb_net_base_len(const struct sk_buff *skb)
 #define BPF_F_ADJ_ROOM_DECAP_L3_MASK	(BPF_F_ADJ_ROOM_DECAP_L3_IPV4 | \
 					 BPF_F_ADJ_ROOM_DECAP_L3_IPV6)
 
+#define BPF_F_ADJ_ROOM_DECAP_L4_MASK	(BPF_F_ADJ_ROOM_DECAP_L4_UDP | \
+					 BPF_F_ADJ_ROOM_DECAP_L4_GRE)
+
+#define BPF_F_ADJ_ROOM_DECAP_IPXIP_MASK	(BPF_F_ADJ_ROOM_DECAP_IPXIP4 | \
+					 BPF_F_ADJ_ROOM_DECAP_IPXIP6)
+
 #define BPF_F_ADJ_ROOM_ENCAP_MASK	(BPF_F_ADJ_ROOM_ENCAP_L3_MASK | \
 					 BPF_F_ADJ_ROOM_ENCAP_L4_GRE | \
 					 BPF_F_ADJ_ROOM_ENCAP_L4_UDP | \
@@ -3579,7 +3586,9 @@ static u32 bpf_skb_net_base_len(const struct sk_buff *skb)
 					 BPF_F_ADJ_ROOM_ENCAP_L2( \
 					  BPF_ADJ_ROOM_ENCAP_L2_MASK))
 
-#define BPF_F_ADJ_ROOM_DECAP_MASK	(BPF_F_ADJ_ROOM_DECAP_L3_MASK)
+#define BPF_F_ADJ_ROOM_DECAP_MASK	(BPF_F_ADJ_ROOM_DECAP_L3_MASK | \
+					 BPF_F_ADJ_ROOM_DECAP_L4_MASK | \
+					 BPF_F_ADJ_ROOM_DECAP_IPXIP_MASK)
 
 #define BPF_F_ADJ_ROOM_MASK		(BPF_F_ADJ_ROOM_FIXED_GSO | \
 					 BPF_F_ADJ_ROOM_ENCAP_MASK | \
@@ -3827,6 +3836,8 @@ BPF_CALL_4(bpf_skb_adjust_room, struct sk_buff *, skb, s32, len_diff,
 	}
 
 	if (flags & BPF_F_ADJ_ROOM_DECAP_MASK) {
+		u32 len_decap_min = 0;
+
 		if (!shrink)
 			return -EINVAL;
 
@@ -3835,6 +3846,37 @@ BPF_CALL_4(bpf_skb_adjust_room, struct sk_buff *, skb, s32, len_diff,
 		    BPF_F_ADJ_ROOM_DECAP_L3_MASK)
 			return -EINVAL;
 
+		if ((flags & BPF_F_ADJ_ROOM_DECAP_L4_MASK) ==
+		    BPF_F_ADJ_ROOM_DECAP_L4_MASK)
+			return -EINVAL;
+
+		if ((flags & BPF_F_ADJ_ROOM_DECAP_IPXIP_MASK) ==
+		    BPF_F_ADJ_ROOM_DECAP_IPXIP_MASK)
+			return -EINVAL;
+
+		/* Reject mutually exclusive decap tunnel type flags. */
+		if ((flags & BPF_F_ADJ_ROOM_DECAP_L4_MASK) &&
+		    (flags & BPF_F_ADJ_ROOM_DECAP_IPXIP_MASK))
+			return -EINVAL;
+
+		if (flags & BPF_F_ADJ_ROOM_DECAP_L4_MASK)
+			len_decap_min += bpf_skb_net_base_len(skb);
+
+		if (flags & BPF_F_ADJ_ROOM_DECAP_L4_UDP)
+			len_decap_min += sizeof(struct udphdr);
+
+		if (flags & BPF_F_ADJ_ROOM_DECAP_L4_GRE)
+			len_decap_min += sizeof(struct gre_base_hdr);
+
+		if (flags & BPF_F_ADJ_ROOM_DECAP_IPXIP4)
+			len_decap_min += sizeof(struct iphdr);
+
+		if (flags & BPF_F_ADJ_ROOM_DECAP_IPXIP6)
+			len_decap_min += sizeof(struct ipv6hdr);
+
+		if (len_diff_abs < len_decap_min)
+			return -EINVAL;
+
 		if (flags & BPF_F_ADJ_ROOM_DECAP_L3_IPV4)
 			len_min = sizeof(struct iphdr);
 
-- 
2.34.1

