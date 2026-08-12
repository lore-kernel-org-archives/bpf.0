Received: from mx0b-00190b01.pphosted.com (mx0b-00190b01.pphosted.com [67.231.157.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B15A283C9D;
	Wed, 12 Aug 2026 08:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.157.127
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786524691; cv=none; b=m7oiPW+pOx62pek/Lx18ZeED8u5Rkj+Lke2ZY/CZ6I2XLEut7R+mb22J81t+mX8HToXQM4aUoWLl9810yztTVF7xrJsqod7a9MWlHxRkqjjJ8tGKBAs3wZx8d3zZSv/IgJATdtujp7xtIl4+VPwc9gwa+TLWe2VoBCsoQAQHFTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786524691; c=relaxed/simple;
	bh=g/kHGK6gNkmvMbW+pgFF5YPLMuDW93pf3DI9OeSYaV0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HOBUSsw3x9/CrZwiE++dGYc1V4rgS0TaAL/M05dH9dQgPl7kcRSvvXJhLt4zaljQgCSzDUmSR9shruCLjoQUTG/iiJJpYKR5SrGsCYFCvUA+jePzcFJUAtWk9cyRAiiIVomcchOH0bsA89U2nhO3reVB/NJN5eB8yD2JePVHoNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=akamai.com; spf=pass smtp.mailfrom=akamai.com; dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b=iyOHINS1; arc=none smtp.client-ip=67.231.157.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=akamai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=akamai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b="iyOHINS1"
Received: from pps.filterd (m0409411.ppops.net [127.0.0.1])
	by m0409411.ppops.net-00190b01. (8.18.1.11/8.18.1.11) with ESMTP id 67C628jZ4181365;
	Wed, 12 Aug 2026 09:31:36 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=apr2026.eng; bh=7v1hZfrJd
	ZqHLDyRyZvoUqYTyz1P37PEbE1tEyF6GX8=; b=iyOHINS17wMqXl22u8iuQ9R4g
	QiAAybyK4mxY0boj4BtsrO/uwEmDmFCZUEYagjMGaAeFXx72BWfjNKnRiJ+ym7BN
	yd5mkmi5VfZ4PyoiTI3wFS9Enm4ne+Xp2ZP/BcfIKgDZm0mm1LGN3LqVddzN2JA+
	G/ffEDxtZOfNdtljekvxIBDJ2sNrui1HH6ciYvleY60fIlR5o8h2Npbyb7BoePOZ
	F5L+IZCv72U3DZRDf+mNkAXeTDIsJEIbWb354FYJukTLJyJ/BY29mUboZf/+AzIv
	gYoeDG/kKt95jrYfvtzK5MoMRN5uH28D4mz1SaUK3+vvPNpGpvJQ9qi7kcvwA==
Received: from prod-mail-ppoint1 (prod-mail-ppoint1.akamai.com [184.51.33.18])
	by m0409411.ppops.net-00190b01. (PPS) with ESMTPS id 4fxdt1n7ks-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 09:31:35 +0100 (BST)
Received: from pps.filterd (prod-mail-ppoint1.akamai.com [127.0.0.1])
	by prod-mail-ppoint1.akamai.com (8.18.1.7/8.18.1.7) with ESMTP id 67C8JqZl031361;
	Wed, 12 Aug 2026 04:31:35 -0400
Received: from prod-mail-relay01.akamai.com ([172.27.118.31])
	by prod-mail-ppoint1.akamai.com (PPS) with ESMTP id 4fwysw70jq-1;
	Wed, 12 Aug 2026 04:31:35 -0400 (EDT)
Received: from muc-lhvdhd.munich.corp.akamai.com (muc-lhvdhd.munich.corp.akamai.com [172.29.0.147])
	by prod-mail-relay01.akamai.com (Postfix) with ESMTP id 9958B80;
	Wed, 12 Aug 2026 08:31:33 +0000 (UTC)
From: Nick Hudson <nhudson@akamai.com>
To: bpf@vger.kernel.org, netdev@vger.kernel.org,
        Willem de Bruijn <willemb@google.com>,
        Martin KaFai Lau <martin.lau@linux.dev>
Cc: Nick Hudson <nhudson@akamai.com>, Andrii Nakryiko <andrii@kernel.org>,
        Eduard Zingerman <eddyz87@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v7 6/6] selftests/bpf: tc_tunnel - validate decap GSO and encapsulation state
Date: Wed, 12 Aug 2026 09:31:15 +0100
Message-Id: <20260812083115.73100-7-nhudson@akamai.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDA2NyBTYWx0ZWRfXwcxtmfFyGSmU
 j3g2g9sQhnsV4c/ZsdSjXZfeLv9B9Um4YwIAJfC7ipFFXFSd0IuzIP1eoBkVmSjofQgyB7GMcRH
 DhGjYl7Om/bhHiJpF45QZRPwsiyaAJWnEYj9w1O8iwaSN4MBtJFFJRYPHQsiKA/bxKerFmSeZjs
 805ASCmV9qzMGXJX8cQeeHgQwSjYN0u0edawt+6JQ/ZqKlaryxatTqWw+iorcMY6gUPH3RQ+uSo
 LQCSBD6T5G/Te+Ycw3bb1L+WKAnifUBy01Pb7LN5P786tBF8sUS2jRsfFIGMHvhfOXWMh5MnUxG
 ukjJJ6KhLa5CLYCW00b8L0G/43Ouh8wPHsZV7L9SbnbbcMcftFHNtIB3/PhsnKaM3ENnBdf+VSv
 heZK4+FmhX44T8nHUe51T7xeGFmqUTWK3KEONIc0jt8vgCvAPrIc1QpTR/xpvEJn7yzou6pT7bA
 vTP3ypJFJzXDFrjwksQ==
X-Proofpoint-GUID: sJPijdMV9qVpjzcndaebPM1E-Flv6h2u
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDA2NyBTYWx0ZWRfXyOglJg2c4i+5
 Ejt4JRODRMd+ztUIo3gbTWxmz02JXdYXZ6Na2xeDz2NFeXcAr4AELsKNJqCMeW0F/b+aNOMg9By
 HluJSmibaqWVIntwb0u9mAN5CAeG6Zs=
X-Authority-Analysis: v=2.4 cv=Rvn16imK c=1 sm=1 tr=0 ts=6a7c2f67 cx=c_pps
 a=StLZT/nZ0R8Xs+spdojYmg==:117 a=StLZT/nZ0R8Xs+spdojYmg==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Ifg-1AOnLHOf1gn6spyb:22
 a=XKgOefoLEnF0tNwW78TB:22 a=X7Ea-ya5AAAA:8 a=2QDB-QWHral9ImwuqTYA:9
X-Proofpoint-ORIG-GUID: sJPijdMV9qVpjzcndaebPM1E-Flv6h2u
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_02,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1011
 priorityscore=1501 impostorscore=0 suspectscore=0 spamscore=0 phishscore=0
 malwarescore=0 bulkscore=0 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606160001 definitions=main-2608120067

tc_tunnel only partially validated decap state and missed some tunnel
cases. In particular, IPXIP decap checks were not exercised for
IPIP/SIT paths, and non-GSO decap encapsulation state was not
verified.

Tighten the test by:

- setting DECAP_IPXIP4/6 flags for IPIP/SIT/IP6 decap paths based on
  the outer tunnel header family;
- requiring needed DECAP enum values via CO-RE enum existence checks
  so missing kernel support fails fast;
- validating post-decap tunnel state for both GSO and non-GSO packets:
  expected gso_type bits must be cleared and skb->encapsulation must
  match remaining tunnel flags;
- removing forced TSO disable in the test harness so GSO validation is
  exercised.

This improves coverage for decap tunnel-state regressions and ensures
sit_none/ipip-style paths are checked correctly.

Signed-off-by: Nick Hudson <nhudson@akamai.com>
---
 .../selftests/bpf/prog_tests/test_tc_tunnel.c |  1 -
 .../selftests/bpf/progs/test_tc_tunnel.c      | 91 +++++++++++++++++--
 2 files changed, 84 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/test_tc_tunnel.c b/tools/testing/selftests/bpf/prog_tests/test_tc_tunnel.c
index 1aa7c9463980..67ba27d69347 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_tc_tunnel.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_tc_tunnel.c
@@ -438,7 +438,6 @@ static int setup(void)
 	SYS(fail_close_ns_client, "ip link add %s type veth peer name %s",
 	    "veth1 mtu 1500 netns " CLIENT_NS " address " MAC_ADDR_VETH1,
 	    "veth2 mtu 1500 netns " SERVER_NS " address " MAC_ADDR_VETH2);
-	SYS(fail_close_ns_client, "ethtool -K veth1 tso off");
 	SYS(fail_close_ns_client, "ip link set veth1 up");
 	nstoken_server = open_netns(SERVER_NS);
 	if (!ASSERT_OK_PTR(nstoken_server, "open server ns"))
diff --git a/tools/testing/selftests/bpf/progs/test_tc_tunnel.c b/tools/testing/selftests/bpf/progs/test_tc_tunnel.c
index 7376df405a6b..853bca962910 100644
--- a/tools/testing/selftests/bpf/progs/test_tc_tunnel.c
+++ b/tools/testing/selftests/bpf/progs/test_tc_tunnel.c
@@ -6,6 +6,7 @@
 
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_endian.h>
+#include <bpf/bpf_core_read.h>
 #include "bpf_tracing_net.h"
 #include "bpf_compiler.h"
 
@@ -37,6 +38,22 @@ struct vxlanhdr___local {
 
 #define	EXTPROTO_VXLAN	0x1
 
+#define SKB_GSO_UDP_TUNNEL_MASK	(SKB_GSO_UDP_TUNNEL |			\
+				 SKB_GSO_UDP_TUNNEL_CSUM)
+
+#define SKB_GSO_TUNNEL_MASK	(SKB_GSO_UDP_TUNNEL_MASK |		\
+				 SKB_GSO_GRE |				\
+				 SKB_GSO_GRE_CSUM |			\
+				 SKB_GSO_IPXIP4 |			\
+				 SKB_GSO_IPXIP6 |			\
+				 SKB_GSO_ESP)
+
+#define BPF_F_ADJ_ROOM_DECAP_L4_MASK	(BPF_F_ADJ_ROOM_DECAP_L4_UDP |	\
+					 BPF_F_ADJ_ROOM_DECAP_L4_GRE)
+
+#define BPF_F_ADJ_ROOM_DECAP_IPXIP_MASK	(BPF_F_ADJ_ROOM_DECAP_IPXIP4 |	\
+					 BPF_F_ADJ_ROOM_DECAP_IPXIP6)
+
 #define	VXLAN_FLAGS     bpf_htonl(1<<27)
 #define	VNI_ID		1
 #define	VXLAN_VNI	bpf_htonl(VNI_ID << 8)
@@ -589,9 +606,12 @@ int __encap_ip6vxlan_eth(struct __sk_buff *skb)
 		return TC_ACT_OK;
 }
 
-static int decap_internal(struct __sk_buff *skb, int off, int len, char proto)
+static int decap_internal(struct __sk_buff *skb, int off, int len, char proto,
+			  __u64 ipxip_flag)
 {
 	__u64 flags = BPF_F_ADJ_ROOM_FIXED_GSO;
+	struct sk_buff *kskb;
+	struct skb_shared_info *shinfo;
 	struct ipv6_opt_hdr ip6_opt_hdr;
 	struct gre_hdr greh;
 	struct udphdr udph;
@@ -599,10 +619,12 @@ static int decap_internal(struct __sk_buff *skb, int off, int len, char proto)
 
 	switch (proto) {
 	case IPPROTO_IPIP:
-		flags |= BPF_F_ADJ_ROOM_DECAP_L3_IPV4;
+		flags |= BPF_F_ADJ_ROOM_DECAP_L3_IPV4 |
+			 ipxip_flag;
 		break;
 	case IPPROTO_IPV6:
-		flags |= BPF_F_ADJ_ROOM_DECAP_L3_IPV6;
+		flags |= BPF_F_ADJ_ROOM_DECAP_L3_IPV6 |
+			 ipxip_flag;
 		break;
 	case NEXTHDR_DEST:
 		if (bpf_skb_load_bytes(skb, off + len, &ip6_opt_hdr,
@@ -610,10 +632,12 @@ static int decap_internal(struct __sk_buff *skb, int off, int len, char proto)
 			return TC_ACT_OK;
 		switch (ip6_opt_hdr.nexthdr) {
 		case IPPROTO_IPIP:
-			flags |= BPF_F_ADJ_ROOM_DECAP_L3_IPV4;
+			flags |= BPF_F_ADJ_ROOM_DECAP_L3_IPV4 |
+				 ipxip_flag;
 			break;
 		case IPPROTO_IPV6:
-			flags |= BPF_F_ADJ_ROOM_DECAP_L3_IPV6;
+			flags |= BPF_F_ADJ_ROOM_DECAP_L3_IPV6 |
+				 ipxip_flag;
 			break;
 		default:
 			return TC_ACT_OK;
@@ -621,6 +645,11 @@ static int decap_internal(struct __sk_buff *skb, int off, int len, char proto)
 		break;
 	case IPPROTO_GRE:
 		olen += sizeof(struct gre_hdr);
+		if (!bpf_core_enum_value_exists(enum bpf_adj_room_flags,
+						BPF_F_ADJ_ROOM_DECAP_L4_GRE))
+			return TC_ACT_SHOT;
+		flags |= BPF_F_ADJ_ROOM_DECAP_L4_GRE;
+
 		if (bpf_skb_load_bytes(skb, off + len, &greh, sizeof(greh)) < 0)
 			return TC_ACT_OK;
 		switch (bpf_ntohs(greh.protocol)) {
@@ -634,6 +663,10 @@ static int decap_internal(struct __sk_buff *skb, int off, int len, char proto)
 		break;
 	case IPPROTO_UDP:
 		olen += sizeof(struct udphdr);
+		if (!bpf_core_enum_value_exists(enum bpf_adj_room_flags,
+						BPF_F_ADJ_ROOM_DECAP_L4_UDP))
+			return TC_ACT_SHOT;
+		flags |= BPF_F_ADJ_ROOM_DECAP_L4_UDP;
 		if (bpf_skb_load_bytes(skb, off + len, &udph, sizeof(udph)) < 0)
 			return TC_ACT_OK;
 		switch (bpf_ntohs(udph.dest)) {
@@ -655,6 +688,40 @@ static int decap_internal(struct __sk_buff *skb, int off, int len, char proto)
 	if (bpf_skb_adjust_room(skb, -olen, BPF_ADJ_ROOM_MAC, flags))
 		return TC_ACT_SHOT;
 
+	kskb = bpf_cast_to_kern_ctx(skb);
+	shinfo = bpf_core_cast(kskb->head + kskb->end, struct skb_shared_info);
+	if (shinfo->gso_size) {
+		if ((flags & BPF_F_ADJ_ROOM_DECAP_L4_UDP) &&
+		    (shinfo->gso_type & SKB_GSO_UDP_TUNNEL_MASK))
+			return TC_ACT_SHOT;
+
+		if ((flags & BPF_F_ADJ_ROOM_DECAP_L4_GRE) &&
+		    (shinfo->gso_type & (SKB_GSO_GRE | SKB_GSO_GRE_CSUM)))
+			return TC_ACT_SHOT;
+
+		if ((flags & BPF_F_ADJ_ROOM_DECAP_IPXIP4) &&
+		    (shinfo->gso_type & SKB_GSO_IPXIP4))
+			return TC_ACT_SHOT;
+
+		if ((flags & BPF_F_ADJ_ROOM_DECAP_IPXIP6) &&
+		    (shinfo->gso_type & SKB_GSO_IPXIP6))
+			return TC_ACT_SHOT;
+
+		if (flags & (BPF_F_ADJ_ROOM_DECAP_L4_MASK |
+			     BPF_F_ADJ_ROOM_DECAP_IPXIP_MASK)) {
+			if ((shinfo->gso_type & SKB_GSO_TUNNEL_MASK) &&
+			    !kskb->encapsulation)
+				return TC_ACT_SHOT;
+			if (!(shinfo->gso_type & SKB_GSO_TUNNEL_MASK) &&
+			    kskb->encapsulation)
+				return TC_ACT_SHOT;
+		}
+	} else if ((flags & (BPF_F_ADJ_ROOM_DECAP_L4_MASK |
+			     BPF_F_ADJ_ROOM_DECAP_IPXIP_MASK)) &&
+		   kskb->encapsulation) {
+		return TC_ACT_SHOT;
+	}
+
 	return TC_ACT_OK;
 }
 
@@ -662,6 +729,10 @@ static int decap_ipv4(struct __sk_buff *skb)
 {
 	struct iphdr iph_outer;
 
+	if (!bpf_core_enum_value_exists(enum bpf_adj_room_flags,
+					BPF_F_ADJ_ROOM_DECAP_IPXIP4))
+		return TC_ACT_SHOT;
+
 	if (bpf_skb_load_bytes(skb, ETH_HLEN, &iph_outer,
 			       sizeof(iph_outer)) < 0)
 		return TC_ACT_OK;
@@ -670,19 +741,25 @@ static int decap_ipv4(struct __sk_buff *skb)
 		return TC_ACT_OK;
 
 	return decap_internal(skb, ETH_HLEN, sizeof(iph_outer),
-			      iph_outer.protocol);
+			      iph_outer.protocol,
+			      BPF_F_ADJ_ROOM_DECAP_IPXIP4);
 }
 
 static int decap_ipv6(struct __sk_buff *skb)
 {
 	struct ipv6hdr iph_outer;
 
+	if (!bpf_core_enum_value_exists(enum bpf_adj_room_flags,
+					BPF_F_ADJ_ROOM_DECAP_IPXIP6))
+		return TC_ACT_SHOT;
+
 	if (bpf_skb_load_bytes(skb, ETH_HLEN, &iph_outer,
 			       sizeof(iph_outer)) < 0)
 		return TC_ACT_OK;
 
 	return decap_internal(skb, ETH_HLEN, sizeof(iph_outer),
-			      iph_outer.nexthdr);
+			      iph_outer.nexthdr,
+			      BPF_F_ADJ_ROOM_DECAP_IPXIP6);
 }
 
 SEC("tc")
-- 
2.34.1

