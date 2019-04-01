Return-Path: <SRS0=vda1=SD=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9DFBC10F05
	for <bpf@archiver.kernel.org>; Mon,  1 Apr 2019 15:33:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6503920880
	for <bpf@archiver.kernel.org>; Mon,  1 Apr 2019 15:33:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cujpGiq7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728624AbfDAPdd (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 1 Apr 2019 11:33:33 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:60240 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726514AbfDAPdc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 1 Apr 2019 11:33:32 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x31FTSPI040276;
        Mon, 1 Apr 2019 15:33:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=rGtOH+rk1p2SXwaoz1Y4HYVLfkkrIH67TBB29bhyEmM=;
 b=cujpGiq7l1Q5gPy+w4qKNarss31qFKJs+tSAihadg7jQdLJx1+/DNgJZ0hyXLRrM6tk/
 0wj/R39GCb5nDbBuGKc8Yw46CeBOTg8eCx66KQMKlyyVWgp78+YfgaDWNRDVJgqomETJ
 8Yg/W+xvESAt4sTkEcrlHTwnVycVseBeilp29475VCl8Xnfdf86ezWV/iCUYzXfSEWXf
 vgWMHhUiq2jUpdFuXmclLKjF0GexLfWN9mPojf5s8DVDzkoIKAbGqeOykmZMxWhxhqIt
 TYrTQ0mZWYNLkolycECHDvcMK62jnQRR1isbU1+I4BS+a/PcOGVLa+PbDT8poGQUD5t5 BQ== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2130.oracle.com with ESMTP id 2rhyvsyu3c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 01 Apr 2019 15:33:07 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x31FX5An001636
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 1 Apr 2019 15:33:05 GMT
Received: from abhmp0022.oracle.com (abhmp0022.oracle.com [141.146.116.28])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x31FX4JQ013954;
        Mon, 1 Apr 2019 15:33:04 GMT
Received: from dhcp-10-175-171-252.vpn.oracle.com (/10.175.171.252)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 01 Apr 2019 08:33:03 -0700
From:   Alan Maguire <alan.maguire@oracle.com>
To:     willemb@google.com, ast@kernel.org, daniel@iogearbox.net,
        davem@davemloft.net, shuah@kernel.org, kafai@fb.com,
        songliubraving@fb.com, yhs@fb.com, quentin.monnet@netronome.com,
        john.fastabend@gmail.com, rdna@fb.com,
        linux-kselftest@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Cc:     Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH bpf-next 4/4] selftests_bpf: extend test_tc_tunnel.sh test for L2 encap
Date:   Mon,  1 Apr 2019 16:32:11 +0100
Message-Id: <1554132731-3095-5-git-send-email-alan.maguire@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1554132731-3095-1-git-send-email-alan.maguire@oracle.com>
References: <1554132731-3095-1-git-send-email-alan.maguire@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9214 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=4 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1904010104
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Update test_tc_tunnel to verify adding inner L2 header
encapsulation (an MPLS label) works.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 tools/testing/selftests/bpf/progs/test_tc_tunnel.c | 172 +++++++++++++++++----
 tools/testing/selftests/bpf/test_tc_tunnel.sh      |  59 +++----
 2 files changed, 170 insertions(+), 61 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/test_tc_tunnel.c b/tools/testing/selftests/bpf/progs/test_tc_tunnel.c
index cc88379..5127b1b 100644
--- a/tools/testing/selftests/bpf/progs/test_tc_tunnel.c
+++ b/tools/testing/selftests/bpf/progs/test_tc_tunnel.c
@@ -11,6 +11,7 @@
 #include <linux/in.h>
 #include <linux/ip.h>
 #include <linux/ipv6.h>
+#include <linux/mpls.h>
 #include <linux/tcp.h>
 #include <linux/udp.h>
 #include <linux/pkt_cls.h>
@@ -23,7 +24,13 @@
 
 static const int cfg_udp_src = 20000;
 static const int cfg_udp_dst = 5555;
+/* MPLSoverUDP */
+#define	MPLS_OVER_UDP_PORT 6635
+static const int cfg_mplsudp_dst = MPLS_OVER_UDP_PORT;
 
+/* MPLS label 1000 with S bit (last label) set and ttl of 255. */
+static const __u32 mpls_label = __bpf_constant_htonl(1000 << 12 |
+						     MPLS_LS_S_MASK | 0xff);
 struct gre_hdr {
 	__be16 flags;
 	__be16 protocol;
@@ -37,6 +44,7 @@ struct gre_hdr {
 struct v4hdr {
 	struct iphdr ip;
 	union l4hdr l4hdr;
+	__u8 pad[16];		/* enough space for eth header after udp hdr */
 } __attribute__((packed));
 
 struct v6hdr {
@@ -59,14 +67,17 @@ static __always_inline void set_ipv4_csum(struct iphdr *iph)
 	iph->check = ~((csum & 0xffff) + (csum >> 16));
 }
 
-static __always_inline int encap_ipv4(struct __sk_buff *skb, __u8 encap_proto)
+static __always_inline int encap_ipv4(struct __sk_buff *skb, __u8 encap_proto,
+				      __u16 l2_proto)
 {
 	struct iphdr iph_inner;
 	struct v4hdr h_outer;
 	struct udphdr *udph;
 	struct tcphdr tcph;
+	struct ethhdr eth;
+	int olen, elen;
 	__u64 flags;
-	int olen;
+	__u16 dst;
 
 	if (bpf_skb_load_bytes(skb, ETH_HLEN, &iph_inner,
 			       sizeof(iph_inner)) < 0)
@@ -84,23 +95,39 @@ static __always_inline int encap_ipv4(struct __sk_buff *skb, __u8 encap_proto)
 		return TC_ACT_OK;
 
 	olen = sizeof(h_outer.ip);
+	elen = 0;
 
 	flags = BPF_F_ADJ_ROOM_ENCAP_L3_IPV4;
+
+	if (l2_proto == ETH_P_MPLS_UC) {
+		elen = sizeof(mpls_label);
+		flags |= BPF_F_ADJ_ROOM_ENCAP_L2(elen);
+	}
+
 	switch (encap_proto) {
 	case IPPROTO_GRE:
 		flags |= BPF_F_ADJ_ROOM_ENCAP_L4_GRE | BPF_F_ADJ_ROOM_FIXED_GSO;
 		olen += sizeof(h_outer.l4hdr.gre);
-		h_outer.l4hdr.gre.protocol = bpf_htons(ETH_P_IP);
+		h_outer.l4hdr.gre.protocol = bpf_htons(l2_proto);
 		h_outer.l4hdr.gre.flags = 0;
 		break;
 	case IPPROTO_UDP:
 		flags |= BPF_F_ADJ_ROOM_ENCAP_L4_UDP;
 		olen += sizeof(h_outer.l4hdr.udp);
-		h_outer.l4hdr.udp.source = __bpf_constant_htons(cfg_udp_src);
-		h_outer.l4hdr.udp.dest = __bpf_constant_htons(cfg_udp_dst);
 		h_outer.l4hdr.udp.check = 0;
 		h_outer.l4hdr.udp.len = bpf_htons(bpf_ntohs(iph_inner.tot_len) +
-						  sizeof(h_outer.l4hdr.udp));
+						  sizeof(h_outer.l4hdr.udp) +
+						  elen);
+		h_outer.l4hdr.udp.source = __bpf_constant_htons(cfg_udp_src);
+		switch (l2_proto) {
+		case ETH_P_IP:
+			dst = cfg_udp_dst;
+			break;
+		case ETH_P_MPLS_UC:
+			dst = cfg_mplsudp_dst;
+			break;
+		}
+		h_outer.l4hdr.udp.dest = bpf_htons(dst);
 		break;
 	case IPPROTO_IPIP:
 		break;
@@ -108,6 +135,13 @@ static __always_inline int encap_ipv4(struct __sk_buff *skb, __u8 encap_proto)
 		return TC_ACT_OK;
 	}
 
+	/* add L2 encap (if specified) */
+	if (l2_proto == ETH_P_MPLS_UC)
+		__builtin_memcpy((__u8 *)&h_outer + olen, &mpls_label,
+				 sizeof(mpls_label));
+
+	olen += elen;
+
 	/* add room between mac and network header */
 	if (bpf_skb_adjust_room(skb, olen, BPF_ADJ_ROOM_MAC, flags))
 		return TC_ACT_SHOT;
@@ -124,18 +158,19 @@ static __always_inline int encap_ipv4(struct __sk_buff *skb, __u8 encap_proto)
 	if (bpf_skb_store_bytes(skb, ETH_HLEN, &h_outer, olen,
 				BPF_F_INVALIDATE_HASH) < 0)
 		return TC_ACT_SHOT;
-
 	return TC_ACT_OK;
 }
 
-static __always_inline int encap_ipv6(struct __sk_buff *skb, __u8 encap_proto)
+static __always_inline int encap_ipv6(struct __sk_buff *skb, __u8 encap_proto,
+				      __u16 l2_proto)
 {
 	struct ipv6hdr iph_inner;
 	struct v6hdr h_outer;
 	struct tcphdr tcph;
+	int olen, elen;
 	__u16 tot_len;
 	__u64 flags;
-	int olen;
+	__u16 dst;
 
 	if (bpf_skb_load_bytes(skb, ETH_HLEN, &iph_inner,
 			       sizeof(iph_inner)) < 0)
@@ -150,24 +185,39 @@ static __always_inline int encap_ipv6(struct __sk_buff *skb, __u8 encap_proto)
 		return TC_ACT_OK;
 
 	olen = sizeof(h_outer.ip);
+	elen = 0;
 
 	flags = BPF_F_ADJ_ROOM_ENCAP_L3_IPV6;
+
+	if (l2_proto == ETH_P_MPLS_UC) {
+		elen = sizeof(mpls_label);
+		flags |= BPF_F_ADJ_ROOM_ENCAP_L2(elen);
+	}
+
 	switch (encap_proto) {
 	case IPPROTO_GRE:
 		flags |= BPF_F_ADJ_ROOM_ENCAP_L4_GRE | BPF_F_ADJ_ROOM_FIXED_GSO;
 		olen += sizeof(h_outer.l4hdr.gre);
-		h_outer.l4hdr.gre.protocol = bpf_htons(ETH_P_IPV6);
+		h_outer.l4hdr.gre.protocol = bpf_htons(l2_proto);
 		h_outer.l4hdr.gre.flags = 0;
 		break;
 	case IPPROTO_UDP:
 		flags |= BPF_F_ADJ_ROOM_ENCAP_L4_UDP;
 		olen += sizeof(h_outer.l4hdr.udp);
-		h_outer.l4hdr.udp.source = __bpf_constant_htons(cfg_udp_src);
-		h_outer.l4hdr.udp.dest = __bpf_constant_htons(cfg_udp_dst);
 		h_outer.l4hdr.udp.check = 0;
 		tot_len = bpf_ntohs(iph_inner.payload_len) + sizeof(iph_inner);
 		h_outer.l4hdr.udp.len = bpf_htons(tot_len +
-					sizeof(h_outer.l4hdr.udp));
+					sizeof(h_outer.l4hdr.udp) + elen);
+		h_outer.l4hdr.udp.source = __bpf_constant_htons(cfg_udp_src);
+		switch (l2_proto) {
+		case ETH_P_IPV6:
+			dst = cfg_udp_dst;
+			break;
+		case ETH_P_MPLS_UC:
+			dst = cfg_mplsudp_dst;
+			break;
+		}
+		h_outer.l4hdr.udp.dest = bpf_htons(dst);
 		break;
 	case IPPROTO_IPV6:
 		break;
@@ -175,6 +225,13 @@ static __always_inline int encap_ipv6(struct __sk_buff *skb, __u8 encap_proto)
 		return TC_ACT_OK;
 	}
 
+	/* add L2 encap (if specified) */
+	if (l2_proto == ETH_P_MPLS_UC)
+		__builtin_memcpy((__u8 *)&h_outer + olen, &mpls_label,
+				 sizeof(mpls_label));
+
+	olen += elen;
+
 	/* add room between mac and network header */
 	if (bpf_skb_adjust_room(skb, olen, BPF_ADJ_ROOM_MAC, flags))
 		return TC_ACT_SHOT;
@@ -194,63 +251,104 @@ static __always_inline int encap_ipv6(struct __sk_buff *skb, __u8 encap_proto)
 	return TC_ACT_OK;
 }
 
-SEC("encap_ipip")
+SEC("encap_ipip_none")
 int __encap_ipip(struct __sk_buff *skb)
 {
 	if (skb->protocol == __bpf_constant_htons(ETH_P_IP))
-		return encap_ipv4(skb, IPPROTO_IPIP);
+		return encap_ipv4(skb, IPPROTO_IPIP, ETH_P_IP);
+	else
+		return TC_ACT_OK;
+}
+
+SEC("encap_gre_none")
+int __encap_gre_none(struct __sk_buff *skb)
+{
+	if (skb->protocol == __bpf_constant_htons(ETH_P_IP))
+		return encap_ipv4(skb, IPPROTO_GRE, ETH_P_IP);
 	else
 		return TC_ACT_OK;
 }
 
-SEC("encap_gre")
-int __encap_gre(struct __sk_buff *skb)
+SEC("encap_gre_mpls")
+int __encap_gre_mpls(struct __sk_buff *skb)
 {
 	if (skb->protocol == __bpf_constant_htons(ETH_P_IP))
-		return encap_ipv4(skb, IPPROTO_GRE);
+		return encap_ipv4(skb, IPPROTO_GRE, ETH_P_MPLS_UC);
 	else
 		return TC_ACT_OK;
 }
 
-SEC("encap_udp")
+
+SEC("encap_udp_none")
 int __encap_udp(struct __sk_buff *skb)
 {
 	if (skb->protocol == __bpf_constant_htons(ETH_P_IP))
-		return encap_ipv4(skb, IPPROTO_UDP);
+		return encap_ipv4(skb, IPPROTO_UDP, ETH_P_IP);
+	else
+		return TC_ACT_OK;
+}
+
+SEC("encap_udp_mpls")
+int __encap_udp_mpls(struct __sk_buff *skb)
+{
+	if (skb->protocol == __bpf_constant_htons(ETH_P_IP))
+		return encap_ipv4(skb, IPPROTO_UDP, ETH_P_MPLS_UC);
+	else
+		return TC_ACT_OK;
+}
+
+
+SEC("encap_ip6tnl_none")
+int __encap_ip6tnl_none(struct __sk_buff *skb)
+{
+	if (skb->protocol == __bpf_constant_htons(ETH_P_IPV6))
+		return encap_ipv6(skb, IPPROTO_IPV6, ETH_P_IPV6);
+	else
+		return TC_ACT_OK;
+}
+
+SEC("encap_ip6gre_none")
+int __encap_ip6gre_none(struct __sk_buff *skb)
+{
+	if (skb->protocol == __bpf_constant_htons(ETH_P_IPV6))
+		return encap_ipv6(skb, IPPROTO_GRE, ETH_P_IPV6);
 	else
 		return TC_ACT_OK;
 }
 
-SEC("encap_ip6tnl")
-int __encap_ip6tnl(struct __sk_buff *skb)
+SEC("encap_ip6gre_mpls")
+int __encap_ip6gre_mpls(struct __sk_buff *skb)
 {
 	if (skb->protocol == __bpf_constant_htons(ETH_P_IPV6))
-		return encap_ipv6(skb, IPPROTO_IPV6);
+		return encap_ipv6(skb, IPPROTO_GRE, ETH_P_MPLS_UC);
 	else
 		return TC_ACT_OK;
 }
 
-SEC("encap_ip6gre")
-int __encap_ip6gre(struct __sk_buff *skb)
+SEC("encap_ip6udp_none")
+int __encap_ip6udp_none(struct __sk_buff *skb)
 {
 	if (skb->protocol == __bpf_constant_htons(ETH_P_IPV6))
-		return encap_ipv6(skb, IPPROTO_GRE);
+		return encap_ipv6(skb, IPPROTO_UDP, ETH_P_IPV6);
 	else
 		return TC_ACT_OK;
 }
 
-SEC("encap_ip6udp")
-int __encap_ip6udp(struct __sk_buff *skb)
+SEC("encap_ip6udp_mpls")
+int __encap_ip6udp_mpls(struct __sk_buff *skb)
 {
 	if (skb->protocol == __bpf_constant_htons(ETH_P_IPV6))
-		return encap_ipv6(skb, IPPROTO_UDP);
+		return encap_ipv6(skb, IPPROTO_UDP, ETH_P_MPLS_UC);
 	else
 		return TC_ACT_OK;
 }
 
-static int decap_internal(struct __sk_buff *skb, int off, int len, char proto)
+static __always_inline int decap_internal(struct __sk_buff *skb, int off,
+					  int len, char proto)
 {
 	char buf[sizeof(struct v6hdr)];
+	struct gre_hdr greh;
+	struct udphdr udph;
 	int olen = len;
 
 	switch (proto) {
@@ -259,9 +357,17 @@ static int decap_internal(struct __sk_buff *skb, int off, int len, char proto)
 		break;
 	case IPPROTO_GRE:
 		olen += sizeof(struct gre_hdr);
+		if (bpf_skb_load_bytes(skb, off + len, &greh, sizeof(greh)) < 0)
+			return TC_ACT_OK;
+		if (bpf_ntohs(greh.protocol) == ETH_P_MPLS_UC)
+			olen += sizeof(mpls_label);
 		break;
 	case IPPROTO_UDP:
 		olen += sizeof(struct udphdr);
+		if (bpf_skb_load_bytes(skb, off + len, &udph, sizeof(udph)) < 0)
+			return TC_ACT_OK;
+		if (bpf_ntohs(udph.dest) == MPLS_OVER_UDP_PORT)
+			olen += sizeof(mpls_label);
 		break;
 	default:
 		return TC_ACT_OK;
@@ -274,7 +380,7 @@ static int decap_internal(struct __sk_buff *skb, int off, int len, char proto)
 	return TC_ACT_OK;
 }
 
-static int decap_ipv4(struct __sk_buff *skb)
+static __always_inline int decap_ipv4(struct __sk_buff *skb)
 {
 	struct iphdr iph_outer;
 
@@ -289,7 +395,7 @@ static int decap_ipv4(struct __sk_buff *skb)
 			      iph_outer.protocol);
 }
 
-static int decap_ipv6(struct __sk_buff *skb)
+static __always_inline int decap_ipv6(struct __sk_buff *skb)
 {
 	struct ipv6hdr iph_outer;
 
@@ -302,7 +408,7 @@ static int decap_ipv6(struct __sk_buff *skb)
 }
 
 SEC("decap")
-int decap_f(struct __sk_buff *skb)
+static int decap_f(struct __sk_buff *skb)
 {
 	switch (skb->protocol) {
 	case __bpf_constant_htons(ETH_P_IP):
diff --git a/tools/testing/selftests/bpf/test_tc_tunnel.sh b/tools/testing/selftests/bpf/test_tc_tunnel.sh
index 3ae54f0..37c479e 100755
--- a/tools/testing/selftests/bpf/test_tc_tunnel.sh
+++ b/tools/testing/selftests/bpf/test_tc_tunnel.sh
@@ -89,42 +89,44 @@ set -e
 # no arguments: automated test, run all
 if [[ "$#" -eq "0" ]]; then
 	echo "ipip"
-	$0 ipv4 ipip 100
+	$0 ipv4 ipip none 100
 
 	echo "ip6ip6"
-	$0 ipv6 ip6tnl 100
+	$0 ipv6 ip6tnl none 100
 
-	echo "ip gre"
-	$0 ipv4 gre 100
+	for mac in none mpls  ; do
+		echo "ip gre $mac"
+		$0 ipv4 gre $mac 100
 
-	echo "ip6 gre"
-	$0 ipv6 ip6gre 100
+		echo "ip6 gre $mac"
+		$0 ipv6 ip6gre $mac 100
 
-	echo "ip gre gso"
-	$0 ipv4 gre 2000
+		echo "ip gre $mac gso"
+		$0 ipv4 gre $mac 2000
 
-	echo "ip6 gre gso"
-	$0 ipv6 ip6gre 2000
+		echo "ip6 gre $mac gso"
+		$0 ipv6 ip6gre $mac 2000
 
-	echo "ip udp"
-	$0 ipv4 udp 100
+		echo "ip udp $mac"
+		$0 ipv4 udp $mac 100
 
-	echo "ip6 udp"
-	$0 ipv6 ip6udp 100
+		echo "ip6 udp $mac"
+		$0 ipv6 ip6udp $mac 100
 
-	echo "ip udp gso"
-	$0 ipv4 udp 2000
+		echo "ip udp $mac gso"
+		$0 ipv4 udp $mac 2000
 
-	echo "ip6 udp gso"
-        $0 ipv6 ip6udp 2000
+		echo "ip6 udp $mac gso"
+		$0 ipv6 ip6udp $mac 2000
+	done
 
 	echo "OK. All tests passed"
 	exit 0
 fi
 
-if [[ "$#" -ne "3" ]]; then
+if [[ "$#" -ne "4" ]]; then
 	echo "Usage: $0"
-	echo "   or: $0 <ipv4|ipv6> <tuntype> <data_len>"
+	echo "   or: $0 <ipv4|ipv6> <tuntype> <none|mpls> <data_len>"
 	exit 1
 fi
 
@@ -148,9 +150,10 @@ case "$1" in
 esac
 
 readonly tuntype=$2
-readonly datalen=$3
+readonly mactype=$3
+readonly datalen=$4
 
-echo "encap ${addr1} to ${addr2}, type ${tuntype}, len ${datalen}"
+echo "encap ${addr1} to ${addr2}, tun ${tuntype} mac ${mactype} len ${datalen}"
 
 trap cleanup EXIT
 
@@ -167,7 +170,7 @@ verify_data
 ip netns exec "${ns1}" tc qdisc add dev veth1 clsact
 ip netns exec "${ns1}" tc filter add dev veth1 egress \
 	bpf direct-action object-file ./test_tc_tunnel.o \
-	section "encap_${tuntype}"
+	section "encap_${tuntype}_${mactype}"
 echo "test bpf encap without decap (expect failure)"
 server_listen
 ! client_connect
@@ -176,11 +179,11 @@ server_listen
 # server is still running
 # client can connect again
 
-# Skip tunnel tests for ip6udp.  For IPv6, a UDP checksum is required
-# and there seems to be no way to tell a fou6 tunnel to allow 0
-# checksums.  Accordingly for both these cases, we skip tests against
-# tunnel peer, and test encap using BPF decap only.
-if [[ "$tuntype" != "ip6udp" ]]; then
+# Skip tunnel tests for L2 encap and ip6udp.  For IPv6, a UDP checksum
+# is required and there seems to be no way to tell a fou6 tunnel to
+# allow 0 checksums.  Accordingly for both these cases, we skip tests
+# against tunnel peer and test using BPF decap only.
+if [[ "$mactype" == "none" && "$tuntype" != "ip6udp" ]]; then
 	if [[ "$tuntype" == "udp" ]]; then
 		# Set up fou tunnel.
 		ttype=ipip
-- 
1.8.3.1

