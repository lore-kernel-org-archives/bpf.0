Received: from mx0b-00190b01.pphosted.com (mx0b-00190b01.pphosted.com [67.231.157.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A0EC40C5C5;
	Wed, 12 Aug 2026 09:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.157.127
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786527436; cv=none; b=Tf4PcgnnkCg7tRDHM8cSfqiZ4XSca31E+vEZV830PeI60HdQg7KEJELq+HsfwRCiX5BUi3nULYbfzXm7rdVbN/4c1QjUOSxR3nB/QBa4wyOG4r4GY0imLScjRZt09F7fNAM5KSF423om5hvUXTV/Mw6vZ62dvMoQV5qFxY5h0T4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786527436; c=relaxed/simple;
	bh=apjeyvmbD2LpmYlmSAHSqulCbbj/jedcu7lqF18OknI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ssm/w7sr4bC+neTisyuuGrtDp4WnbzUaRAM3uUkWmidnHDjZFg5za0M4IrzWZOZeXVkXygdLhG6YJFB/tWnd8eazDCFV8/vlSz934d8znfH2FshQ4gdgmeuj+oKNYcBRcq1ht6Q1Mlt1G0/zyumTy0QrtWVXP7SG7BWSM12qSBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=akamai.com; spf=pass smtp.mailfrom=akamai.com; dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b=I7PDi01c; arc=none smtp.client-ip=67.231.157.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=akamai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=akamai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b="I7PDi01c"
Received: from pps.filterd (m0409410.ppops.net [127.0.0.1])
	by m0409410.ppops.net-00190b01. (8.18.1.11/8.18.1.11) with ESMTP id 67C6052a039899;
	Wed, 12 Aug 2026 09:31:27 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=apr2026.eng; bh=iAFHUHSas
	EsJ5uhslqIC5Vwtc6xf1QMSboA/nM9Ccok=; b=I7PDi01cmUQLIuV609E5cxZVB
	AFfC9bok+9AEgEVG7il2Kl0JirXWdqDU7zwslXqlhsZfnnjZDqM8RldQCQRhyKm+
	oUWNega+oWXBdTUvCDHi5eKv7YHdtSAzWTzkIwFT2xdLVqy9DHR9OjKuw5YsLAoK
	zK/MT2GsYKKYOafKmQ3fr64VXTnKxuFqWMfUdU27sI7dFhxAK9YNcfqKeoZPTSZ/
	tJqsjcaTF2WjGqNF71HtpLXhSvS/Z6y9cgcWFk7yF9e4TtEECP7zhuijBYJR27Ce
	fGLBd3UX+LTuefhaWA6NZEFlL1zNdqILQ+b1kJFvCRcK8irNZRYvuo0U+AaCQ==
Received: from prod-mail-ppoint1 (prod-mail-ppoint1.akamai.com [184.51.33.18])
	by m0409410.ppops.net-00190b01. (PPS) with ESMTPS id 4fxfc7krpa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 09:31:27 +0100 (BST)
Received: from pps.filterd (prod-mail-ppoint1.akamai.com [127.0.0.1])
	by prod-mail-ppoint1.akamai.com (8.18.1.7/8.18.1.7) with ESMTP id 67C8Jj0b030876;
	Wed, 12 Aug 2026 04:31:26 -0400
Received: from prod-mail-relay01.akamai.com ([172.27.118.31])
	by prod-mail-ppoint1.akamai.com (PPS) with ESMTP id 4fwysw70gj-1;
	Wed, 12 Aug 2026 04:31:26 -0400 (EDT)
Received: from muc-lhvdhd.munich.corp.akamai.com (muc-lhvdhd.munich.corp.akamai.com [172.29.0.147])
	by prod-mail-relay01.akamai.com (Postfix) with ESMTP id F212080;
	Wed, 12 Aug 2026 08:31:24 +0000 (UTC)
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
Subject: [PATCH bpf-next v7 2/6] bpf: refactor masks for ADJ_ROOM flags and encap validation
Date: Wed, 12 Aug 2026 09:31:11 +0100
Message-Id: <20260812083115.73100-3-nhudson@akamai.com>
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
 malwarescore=0 adultscore=0 lowpriorityscore=0 spamscore=0 phishscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2606160000
 definitions=main-2608120066
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDA2NyBTYWx0ZWRfX4wVlaJScV0Kv
 KFjDjqtqqVWeXGJMglwA8kc0dobGeBNpX2VxG2WYR6yR0Vtm3unyK4ouQLWp2md3h4QAojekt1R
 xYc3eLduImX4GZ8X3GxdXQ5Io1dgb1k=
X-Proofpoint-GUID: tMckkw9m_tsG1Z0PzR5PYbVxy2TtHS12
X-Authority-Analysis: v=2.4 cv=Cf84Irrl c=1 sm=1 tr=0 ts=6a7c2f5f cx=c_pps
 a=StLZT/nZ0R8Xs+spdojYmg==:117 a=StLZT/nZ0R8Xs+spdojYmg==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Ifg-1AOnLHOf1gn6spyb:22
 a=KDzEjHMMTas96-nIEKpj:22 a=X7Ea-ya5AAAA:8 a=1XWaLZrsAAAA:8
 a=F30QDbW3dBX7F3vXnksA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDA2NyBTYWx0ZWRfX7WXsLjxvfVGh
 orKA2Pg/wGMUFnIpeK8hHVd2GnaIxkMGUQ+0Jp62evHCdQ0kDwuQ6rj3D9NjmZuM5CBAkALNc9b
 bKKM/b3NmKBd1/rg+6DLjZHZrpbwd4qgUXUSUKQLQTW96XCQRhxc/th+qyRgRvqTHA/72icyTe+
 MnRqvfw8wl0PEQLPWvtDSBnzEhRY2/TuGHYQnjQXkw28RZctvtZcD19Q5Hq0pt+J1lcLA12xFIr
 RMZ92QBHEXozEq0ZjRnLdOMHQBqitxrfb/D+BLO6Oc6DueXu0UldOR1bvtLuvOsk6/CTUtOvBia
 /GvdvScB1Yss2V0K6reXekCBOzeDzlR3jsFbLz9/Dvp1Bohd/lXZx3Yss/EmpbhTiu91dU+vJ0B
 oxbbelO2JrajRtik+XxnFEGvObu7kZJ7uj/z18g1m44RUA4w5IBdnAXueGWrdHzhprnju0ivO6i
 Yv8XmS9IcEQItjwngnA==
X-Proofpoint-ORIG-GUID: tMckkw9m_tsG1Z0PzR5PYbVxy2TtHS12
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_02,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 clxscore=1011
 malwarescore=0 adultscore=0 suspectscore=0 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606160001 definitions=main-2608120067

Refactor the helper masks for bpf_skb_adjust_room() flags to simplify
validation logic and introduce:

- BPF_F_ADJ_ROOM_ENCAP_MASK
- BPF_F_ADJ_ROOM_DECAP_MASK

Refactor existing validation checks in bpf_skb_net_shrink()
and bpf_skb_adjust_room() to use the new masks (no behavior change).

This is in preparation for supporting the new decap flags.

Co-developed-by: Max Tottenham <mtottenh@akamai.com>
Signed-off-by: Max Tottenham <mtottenh@akamai.com>
Co-developed-by: Anna Glasgall <aglasgal@akamai.com>
Signed-off-by: Anna Glasgall <aglasgal@akamai.com>
Signed-off-by: Nick Hudson <nhudson@akamai.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
---
 net/core/filter.c | 38 +++++++++++++++++++++-----------------
 1 file changed, 21 insertions(+), 17 deletions(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index 3423734124a5..89e516049c85 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -3572,14 +3572,19 @@ static u32 bpf_skb_net_base_len(const struct sk_buff *skb)
 #define BPF_F_ADJ_ROOM_DECAP_L3_MASK	(BPF_F_ADJ_ROOM_DECAP_L3_IPV4 | \
 					 BPF_F_ADJ_ROOM_DECAP_L3_IPV6)
 
-#define BPF_F_ADJ_ROOM_MASK		(BPF_F_ADJ_ROOM_FIXED_GSO | \
-					 BPF_F_ADJ_ROOM_ENCAP_L3_MASK | \
+#define BPF_F_ADJ_ROOM_ENCAP_MASK	(BPF_F_ADJ_ROOM_ENCAP_L3_MASK | \
 					 BPF_F_ADJ_ROOM_ENCAP_L4_GRE | \
 					 BPF_F_ADJ_ROOM_ENCAP_L4_UDP | \
 					 BPF_F_ADJ_ROOM_ENCAP_L2_ETH | \
 					 BPF_F_ADJ_ROOM_ENCAP_L2( \
-					  BPF_ADJ_ROOM_ENCAP_L2_MASK) | \
-					 BPF_F_ADJ_ROOM_DECAP_L3_MASK)
+					  BPF_ADJ_ROOM_ENCAP_L2_MASK))
+
+#define BPF_F_ADJ_ROOM_DECAP_MASK	(BPF_F_ADJ_ROOM_DECAP_L3_MASK)
+
+#define BPF_F_ADJ_ROOM_MASK		(BPF_F_ADJ_ROOM_FIXED_GSO | \
+					 BPF_F_ADJ_ROOM_ENCAP_MASK | \
+					 BPF_F_ADJ_ROOM_DECAP_MASK | \
+					 BPF_F_ADJ_ROOM_NO_CSUM_RESET)
 
 static int bpf_skb_net_grow(struct sk_buff *skb, u32 off, u32 len_diff,
 			    u64 flags)
@@ -3702,8 +3707,8 @@ static int bpf_skb_net_shrink(struct sk_buff *skb, u32 off, u32 len_diff,
 	bool decap = flags & BPF_F_ADJ_ROOM_DECAP_L3_MASK;
 	int ret;
 
-	if (unlikely(flags & ~(BPF_F_ADJ_ROOM_FIXED_GSO |
-			       BPF_F_ADJ_ROOM_DECAP_L3_MASK |
+	if (unlikely(flags & ~(BPF_F_ADJ_ROOM_DECAP_MASK |
+			       BPF_F_ADJ_ROOM_FIXED_GSO |
 			       BPF_F_ADJ_ROOM_NO_CSUM_RESET)))
 		return -EINVAL;
 
@@ -3802,8 +3807,7 @@ BPF_CALL_4(bpf_skb_adjust_room, struct sk_buff *, skb, s32, len_diff,
 	u32 off;
 	int ret;
 
-	if (unlikely(flags & ~(BPF_F_ADJ_ROOM_MASK |
-			       BPF_F_ADJ_ROOM_NO_CSUM_RESET)))
+	if (unlikely(flags & ~BPF_F_ADJ_ROOM_MASK))
 		return -EINVAL;
 	if (unlikely(len_diff_abs > 0xfffU))
 		return -EFAULT;
@@ -3822,20 +3826,20 @@ BPF_CALL_4(bpf_skb_adjust_room, struct sk_buff *, skb, s32, len_diff,
 		return -ENOTSUPP;
 	}
 
-	if (flags & BPF_F_ADJ_ROOM_DECAP_L3_MASK) {
+	if (flags & BPF_F_ADJ_ROOM_DECAP_MASK) {
 		if (!shrink)
 			return -EINVAL;
 
-		switch (flags & BPF_F_ADJ_ROOM_DECAP_L3_MASK) {
-		case BPF_F_ADJ_ROOM_DECAP_L3_IPV4:
+		/* Reject mutually exclusive decap flag pairs. */
+		if ((flags & BPF_F_ADJ_ROOM_DECAP_L3_MASK) ==
+		    BPF_F_ADJ_ROOM_DECAP_L3_MASK)
+			return -EINVAL;
+
+		if (flags & BPF_F_ADJ_ROOM_DECAP_L3_IPV4)
 			len_min = sizeof(struct iphdr);
-			break;
-		case BPF_F_ADJ_ROOM_DECAP_L3_IPV6:
+
+		if (flags & BPF_F_ADJ_ROOM_DECAP_L3_IPV6)
 			len_min = sizeof(struct ipv6hdr);
-			break;
-		default:
-			return -EINVAL;
-		}
 	}
 
 	len_cur = skb->len - skb_network_offset(skb);
-- 
2.34.1

