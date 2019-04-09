Return-Path: <SRS0=Zphp=SL=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE291C10F0E
	for <bpf@archiver.kernel.org>; Tue,  9 Apr 2019 14:07:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A1572133D
	for <bpf@archiver.kernel.org>; Tue,  9 Apr 2019 14:07:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="tFbkMOMv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726548AbfDIOHr (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 9 Apr 2019 10:07:47 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:35968 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726568AbfDIOHr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 9 Apr 2019 10:07:47 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x39E3iDG093158;
        Tue, 9 Apr 2019 14:07:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=Xy9VF43vGXfNEjtzXKL/joDrZ6UQKQIok9i1n2mYzLE=;
 b=tFbkMOMv7IFD0ZqyX1jY6HC1A2oN57bl5WgCxwl94pElWJi6sxlVSuc+M4oh99tMPe+w
 3pJ17kcEln6ULmoWr0PL9Nv2LXVgwLAYXdz5WcoUF9u6WHKagaXpm7oPRW1JoH6wRFXX
 p86ij1s+sKy24qAD35rWv6mwyw3lFAThsrZkl8KDRBTV2tlaWr8kPBEu8qky8x94AGSu
 obzm2us6KJHPeKvDej9HbSAQAtcjzDVT/yrC5BWhHAiVebL6fqLevUmtPqa3bYmJ9Cuc
 5vk6+2hEgKu+XWnyHAv6hs9nkt6Uv/DGB31buYedEZCfgXGtGir/fv8Kx2GfjEGEB/v3 EQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 2rpkhsw9ep-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 09 Apr 2019 14:07:21 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x39E5quL130014;
        Tue, 9 Apr 2019 14:07:21 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 2rpkeja1m2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 09 Apr 2019 14:07:20 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x39E7JWZ014911;
        Tue, 9 Apr 2019 14:07:20 GMT
Received: from dhcp-10-175-177-211.vpn.oracle.com (/10.175.177.211)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 09 Apr 2019 07:07:19 -0700
From:   Alan Maguire <alan.maguire@oracle.com>
To:     willemb@google.com, ast@kernel.org, daniel@iogearbox.net,
        davem@davemloft.net, shuah@kernel.org, kafai@fb.com,
        songliubraving@fb.com, yhs@fb.com, quentin.monnet@netronome.com,
        john.fastabend@gmail.com, rdna@fb.com,
        linux-kselftest@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Cc:     Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v3 bpf-next 4/4] selftests_bpf: add L2 encap to test_tc_tunnel
Date:   Tue,  9 Apr 2019 15:06:43 +0100
Message-Id: <1554818803-4070-5-git-send-email-alan.maguire@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1554818803-4070-1-git-send-email-alan.maguire@oracle.com>
References: <1554818803-4070-1-git-send-email-alan.maguire@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9221 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=4 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1904090090
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9221 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=4 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1904090090
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Update test_tc_tunnel to verify adding inner L2 header
encapsulation (an MPLS label or ethernet header) works.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 tools/testing/selftests/bpf/config                 |   4 +
 tools/testing/selftests/bpf/progs/test_tc_tunnel.c | 219 ++++++++++++++++++---
 tools/testing/selftests/bpf/test_tc_tunnel.sh      | 113 ++++++++---
 3 files changed, 277 insertions(+), 59 deletions(-)

diff --git a/tools/testing/selftests/bpf/config b/tools/testing/selftests/bpf/config
index 8e749c1..8c97647 100644
--- a/tools/testing/selftests/bpf/config
+++ b/tools/testing/selftests/bpf/config
@@ -29,3 +29,7 @@ CONFIG_NET_FOU=m
 CONFIG_NET_FOU_IP_TUNNELS=y
 CONFIG_IPV6_FOU=m
 CONFIG_IPV6_FOU_TUNNEL=m
+CONFIG_MPLS=y
+CONFIG_NET_MPLS_GSO=m
+CONFIG_MPLS_ROUTING=m
+CONFIG_MPLS_IPTUNNEL=m
diff --git a/tools/testing/selftests/bpf/progs/test_tc_tunnel.c b/tools/testing/selftests/bpf/progs/test_tc_tunnel.c
index 33b338e..bcb00d7 100644
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
@@ -22,7 +23,14 @@
 static const int cfg_port = 8000;
 
 static const int cfg_udp_src = 20000;
-static const int cfg_udp_dst = 5555;
+
+#define	UDP_PORT		5555
+#define	MPLS_OVER_UDP_PORT	6635
+#define	ETH_OVER_UDP_PORT	7777
+
+/* MPLS label 1000 with S bit (last label) set and ttl of 255. */
+static const __u32 mpls_label = __bpf_constant_htonl(1000 << 12 |
+						     MPLS_LS_S_MASK | 0xff);
 
 struct gre_hdr {
 	__be16 flags;
@@ -37,11 +45,13 @@ struct gre_hdr {
 struct v4hdr {
 	struct iphdr ip;
 	union l4hdr l4hdr;
+	__u8 pad[16];			/* enough space for L2 header */
 } __attribute__((packed));
 
 struct v6hdr {
 	struct ipv6hdr ip;
 	union l4hdr l4hdr;
+	__u8 pad[16];			/* enough space for L2 header */
 } __attribute__((packed));
 
 static __always_inline void set_ipv4_csum(struct iphdr *iph)
@@ -59,13 +69,15 @@ static __always_inline void set_ipv4_csum(struct iphdr *iph)
 	iph->check = ~((csum & 0xffff) + (csum >> 16));
 }
 
-static __always_inline int encap_ipv4(struct __sk_buff *skb, __u8 encap_proto)
+static __always_inline int encap_ipv4(struct __sk_buff *skb, __u8 encap_proto,
+				      __u16 l2_proto)
 {
+	__u16 udp_dst = UDP_PORT;
 	struct iphdr iph_inner;
 	struct v4hdr h_outer;
 	struct tcphdr tcph;
+	int olen, l2_len;
 	__u64 flags;
-	int olen;
 
 	if (bpf_skb_load_bytes(skb, ETH_HLEN, &iph_inner,
 			       sizeof(iph_inner)) < 0)
@@ -83,23 +95,38 @@ static __always_inline int encap_ipv4(struct __sk_buff *skb, __u8 encap_proto)
 		return TC_ACT_OK;
 
 	olen = sizeof(h_outer.ip);
+	l2_len = 0;
 
 	flags = BPF_F_ADJ_ROOM_FIXED_GSO | BPF_F_ADJ_ROOM_ENCAP_L3_IPV4;
+
+	switch (l2_proto) {
+	case ETH_P_MPLS_UC:
+		l2_len = sizeof(mpls_label);
+		udp_dst = MPLS_OVER_UDP_PORT;
+		break;
+	case ETH_P_TEB:
+		l2_len = ETH_HLEN;
+		udp_dst = ETH_OVER_UDP_PORT;
+		break;
+	}
+	flags |= BPF_F_ADJ_ROOM_ENCAP_L2(l2_len);
+
 	switch (encap_proto) {
 	case IPPROTO_GRE:
 		flags |= BPF_F_ADJ_ROOM_ENCAP_L4_GRE;
 		olen += sizeof(h_outer.l4hdr.gre);
-		h_outer.l4hdr.gre.protocol = bpf_htons(ETH_P_IP);
+		h_outer.l4hdr.gre.protocol = bpf_htons(l2_proto);
 		h_outer.l4hdr.gre.flags = 0;
 		break;
 	case IPPROTO_UDP:
 		flags |= BPF_F_ADJ_ROOM_ENCAP_L4_UDP;
 		olen += sizeof(h_outer.l4hdr.udp);
 		h_outer.l4hdr.udp.source = __bpf_constant_htons(cfg_udp_src);
-		h_outer.l4hdr.udp.dest = __bpf_constant_htons(cfg_udp_dst);
+		h_outer.l4hdr.udp.dest = bpf_htons(udp_dst);
 		h_outer.l4hdr.udp.check = 0;
 		h_outer.l4hdr.udp.len = bpf_htons(bpf_ntohs(iph_inner.tot_len) +
-						  sizeof(h_outer.l4hdr.udp));
+						  sizeof(h_outer.l4hdr.udp) +
+						  l2_len);
 		break;
 	case IPPROTO_IPIP:
 		break;
@@ -107,6 +134,19 @@ static __always_inline int encap_ipv4(struct __sk_buff *skb, __u8 encap_proto)
 		return TC_ACT_OK;
 	}
 
+	/* add L2 encap (if specified) */
+	switch (l2_proto) {
+	case ETH_P_MPLS_UC:
+		*((__u32 *)((__u8 *)&h_outer + olen)) = mpls_label;
+		break;
+	case ETH_P_TEB:
+		if (bpf_skb_load_bytes(skb, 0, (__u8 *)&h_outer + olen,
+				       ETH_HLEN))
+			return TC_ACT_SHOT;
+		break;
+	}
+	olen += l2_len;
+
 	/* add room between mac and network header */
 	if (bpf_skb_adjust_room(skb, olen, BPF_ADJ_ROOM_MAC, flags))
 		return TC_ACT_SHOT;
@@ -127,14 +167,16 @@ static __always_inline int encap_ipv4(struct __sk_buff *skb, __u8 encap_proto)
 	return TC_ACT_OK;
 }
 
-static __always_inline int encap_ipv6(struct __sk_buff *skb, __u8 encap_proto)
+static __always_inline int encap_ipv6(struct __sk_buff *skb, __u8 encap_proto,
+				      __u16 l2_proto)
 {
+	__u16 udp_dst = UDP_PORT;
 	struct ipv6hdr iph_inner;
 	struct v6hdr h_outer;
 	struct tcphdr tcph;
+	int olen, l2_len;
 	__u16 tot_len;
 	__u64 flags;
-	int olen;
 
 	if (bpf_skb_load_bytes(skb, ETH_HLEN, &iph_inner,
 			       sizeof(iph_inner)) < 0)
@@ -149,20 +191,34 @@ static __always_inline int encap_ipv6(struct __sk_buff *skb, __u8 encap_proto)
 		return TC_ACT_OK;
 
 	olen = sizeof(h_outer.ip);
+	l2_len = 0;
 
 	flags = BPF_F_ADJ_ROOM_FIXED_GSO | BPF_F_ADJ_ROOM_ENCAP_L3_IPV6;
+
+	switch (l2_proto) {
+	case ETH_P_MPLS_UC:
+		l2_len = sizeof(mpls_label);
+		udp_dst = MPLS_OVER_UDP_PORT;
+		break;
+	case ETH_P_TEB:
+		l2_len = ETH_HLEN;
+		udp_dst = ETH_OVER_UDP_PORT;
+		break;
+	}
+	flags |= BPF_F_ADJ_ROOM_ENCAP_L2(l2_len);
+
 	switch (encap_proto) {
 	case IPPROTO_GRE:
 		flags |= BPF_F_ADJ_ROOM_ENCAP_L4_GRE;
 		olen += sizeof(h_outer.l4hdr.gre);
-		h_outer.l4hdr.gre.protocol = bpf_htons(ETH_P_IPV6);
+		h_outer.l4hdr.gre.protocol = bpf_htons(l2_proto);
 		h_outer.l4hdr.gre.flags = 0;
 		break;
 	case IPPROTO_UDP:
 		flags |= BPF_F_ADJ_ROOM_ENCAP_L4_UDP;
 		olen += sizeof(h_outer.l4hdr.udp);
 		h_outer.l4hdr.udp.source = __bpf_constant_htons(cfg_udp_src);
-		h_outer.l4hdr.udp.dest = __bpf_constant_htons(cfg_udp_dst);
+		h_outer.l4hdr.udp.dest = bpf_htons(udp_dst);
 		tot_len = bpf_ntohs(iph_inner.payload_len) + sizeof(iph_inner) +
 			  sizeof(h_outer.l4hdr.udp);
 		h_outer.l4hdr.udp.check = 0;
@@ -174,6 +230,19 @@ static __always_inline int encap_ipv6(struct __sk_buff *skb, __u8 encap_proto)
 		return TC_ACT_OK;
 	}
 
+	/* add L2 encap (if specified) */
+	switch (l2_proto) {
+	case ETH_P_MPLS_UC:
+		*((__u32 *)((__u8 *)&h_outer + olen)) = mpls_label;
+		break;
+	case ETH_P_TEB:
+		if (bpf_skb_load_bytes(skb, 0, (__u8 *)&h_outer + olen,
+				       ETH_HLEN))
+			return TC_ACT_SHOT;
+		break;
+	}
+	olen += l2_len;
+
 	/* add room between mac and network header */
 	if (bpf_skb_adjust_room(skb, olen, BPF_ADJ_ROOM_MAC, flags))
 		return TC_ACT_SHOT;
@@ -193,56 +262,128 @@ static __always_inline int encap_ipv6(struct __sk_buff *skb, __u8 encap_proto)
 	return TC_ACT_OK;
 }
 
-SEC("encap_ipip")
-int __encap_ipip(struct __sk_buff *skb)
+SEC("encap_ipip_none")
+int __encap_ipip_none(struct __sk_buff *skb)
+{
+	if (skb->protocol == __bpf_constant_htons(ETH_P_IP))
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
+	else
+		return TC_ACT_OK;
+}
+
+SEC("encap_gre_mpls")
+int __encap_gre_mpls(struct __sk_buff *skb)
+{
+	if (skb->protocol == __bpf_constant_htons(ETH_P_IP))
+		return encap_ipv4(skb, IPPROTO_GRE, ETH_P_MPLS_UC);
+	else
+		return TC_ACT_OK;
+}
+
+SEC("encap_gre_eth")
+int __encap_gre_eth(struct __sk_buff *skb)
 {
 	if (skb->protocol == __bpf_constant_htons(ETH_P_IP))
-		return encap_ipv4(skb, IPPROTO_IPIP);
+		return encap_ipv4(skb, IPPROTO_GRE, ETH_P_TEB);
 	else
 		return TC_ACT_OK;
 }
 
-SEC("encap_gre")
-int __encap_gre(struct __sk_buff *skb)
+SEC("encap_udp_none")
+int __encap_udp_none(struct __sk_buff *skb)
 {
 	if (skb->protocol == __bpf_constant_htons(ETH_P_IP))
-		return encap_ipv4(skb, IPPROTO_GRE);
+		return encap_ipv4(skb, IPPROTO_UDP, ETH_P_IP);
 	else
 		return TC_ACT_OK;
 }
 
-SEC("encap_udp")
-int __encap_udp(struct __sk_buff *skb)
+SEC("encap_udp_mpls")
+int __encap_udp_mpls(struct __sk_buff *skb)
 {
 	if (skb->protocol == __bpf_constant_htons(ETH_P_IP))
-		return encap_ipv4(skb, IPPROTO_UDP);
+		return encap_ipv4(skb, IPPROTO_UDP, ETH_P_MPLS_UC);
+	else
+		return TC_ACT_OK;
+}
+
+SEC("encap_udp_eth")
+int __encap_udp_eth(struct __sk_buff *skb)
+{
+	if (skb->protocol == __bpf_constant_htons(ETH_P_IP))
+		return encap_ipv4(skb, IPPROTO_UDP, ETH_P_TEB);
+	else
+		return TC_ACT_OK;
+}
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
+	else
+		return TC_ACT_OK;
+}
+
+SEC("encap_ip6gre_mpls")
+int __encap_ip6gre_mpls(struct __sk_buff *skb)
+{
+	if (skb->protocol == __bpf_constant_htons(ETH_P_IPV6))
+		return encap_ipv6(skb, IPPROTO_GRE, ETH_P_MPLS_UC);
+	else
+		return TC_ACT_OK;
+}
+
+SEC("encap_ip6gre_eth")
+int __encap_ip6gre_eth(struct __sk_buff *skb)
+{
+	if (skb->protocol == __bpf_constant_htons(ETH_P_IPV6))
+		return encap_ipv6(skb, IPPROTO_GRE, ETH_P_TEB);
 	else
 		return TC_ACT_OK;
 }
 
-SEC("encap_ip6tnl")
-int __encap_ip6tnl(struct __sk_buff *skb)
+SEC("encap_ip6udp_none")
+int __encap_ip6udp_none(struct __sk_buff *skb)
 {
 	if (skb->protocol == __bpf_constant_htons(ETH_P_IPV6))
-		return encap_ipv6(skb, IPPROTO_IPV6);
+		return encap_ipv6(skb, IPPROTO_UDP, ETH_P_IPV6);
 	else
 		return TC_ACT_OK;
 }
 
-SEC("encap_ip6gre")
-int __encap_ip6gre(struct __sk_buff *skb)
+SEC("encap_ip6udp_mpls")
+int __encap_ip6udp_mpls(struct __sk_buff *skb)
 {
 	if (skb->protocol == __bpf_constant_htons(ETH_P_IPV6))
-		return encap_ipv6(skb, IPPROTO_GRE);
+		return encap_ipv6(skb, IPPROTO_UDP, ETH_P_MPLS_UC);
 	else
 		return TC_ACT_OK;
 }
 
-SEC("encap_ip6udp")
-int __encap_ip6udp(struct __sk_buff *skb)
+SEC("encap_ip6udp_eth")
+int __encap_ip6udp_eth(struct __sk_buff *skb)
 {
 	if (skb->protocol == __bpf_constant_htons(ETH_P_IPV6))
-		return encap_ipv6(skb, IPPROTO_UDP);
+		return encap_ipv6(skb, IPPROTO_UDP, ETH_P_TEB);
 	else
 		return TC_ACT_OK;
 }
@@ -250,6 +391,8 @@ int __encap_ip6udp(struct __sk_buff *skb)
 static int decap_internal(struct __sk_buff *skb, int off, int len, char proto)
 {
 	char buf[sizeof(struct v6hdr)];
+	struct gre_hdr greh;
+	struct udphdr udph;
 	int olen = len;
 
 	switch (proto) {
@@ -258,9 +401,29 @@ static int decap_internal(struct __sk_buff *skb, int off, int len, char proto)
 		break;
 	case IPPROTO_GRE:
 		olen += sizeof(struct gre_hdr);
+		if (bpf_skb_load_bytes(skb, off + len, &greh, sizeof(greh)) < 0)
+			return TC_ACT_OK;
+		switch (bpf_ntohs(greh.protocol)) {
+		case ETH_P_MPLS_UC:
+			olen += sizeof(mpls_label);
+			break;
+		case ETH_P_TEB:
+			olen += ETH_HLEN;
+			break;
+		}
 		break;
 	case IPPROTO_UDP:
 		olen += sizeof(struct udphdr);
+		if (bpf_skb_load_bytes(skb, off + len, &udph, sizeof(udph)) < 0)
+			return TC_ACT_OK;
+		switch (bpf_ntohs(udph.dest)) {
+		case MPLS_OVER_UDP_PORT:
+			olen += sizeof(mpls_label);
+			break;
+		case ETH_OVER_UDP_PORT:
+			olen += ETH_HLEN;
+			break;
+		}
 		break;
 	default:
 		return TC_ACT_OK;
diff --git a/tools/testing/selftests/bpf/test_tc_tunnel.sh b/tools/testing/selftests/bpf/test_tc_tunnel.sh
index 64f3091..d4d8d5d 100755
--- a/tools/testing/selftests/bpf/test_tc_tunnel.sh
+++ b/tools/testing/selftests/bpf/test_tc_tunnel.sh
@@ -17,6 +17,9 @@ readonly ns2_v6=fd::2
 
 # Must match port used by bpf program
 readonly udpport=5555
+# MPLSoverUDP
+readonly mplsudpport=6635
+readonly mplsproto=137
 
 readonly infile="$(mktemp)"
 readonly outfile="$(mktemp)"
@@ -41,8 +44,8 @@ setup() {
 	# clamp route to reserve room for tunnel headers
 	ip -netns "${ns1}" -4 route flush table main
 	ip -netns "${ns1}" -6 route flush table main
-	ip -netns "${ns1}" -4 route add "${ns2_v4}" mtu 1472 dev veth1
-	ip -netns "${ns1}" -6 route add "${ns2_v6}" mtu 1452 dev veth1
+	ip -netns "${ns1}" -4 route add "${ns2_v4}" mtu 1458 dev veth1
+	ip -netns "${ns1}" -6 route add "${ns2_v6}" mtu 1438 dev veth1
 
 	sleep 1
 
@@ -89,42 +92,44 @@ set -e
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
+	for mac in none mpls eth ; do
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
-	$0 ipv6 ip6udp 2000
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
+	echo "   or: $0 <ipv4|ipv6> <tuntype> <none|mpls|eth> <data_len>"
 	exit 1
 fi
 
@@ -137,6 +142,8 @@ case "$1" in
 	readonly foumod=fou
 	readonly foutype=ipip
 	readonly fouproto=4
+	readonly fouproto_mpls=${mplsproto}
+	readonly gretaptype=gretap
 	;;
 "ipv6")
 	readonly addr1="${ns1_v6}"
@@ -146,6 +153,8 @@ case "$1" in
 	readonly foumod=fou6
 	readonly foutype=ip6tnl
 	readonly fouproto="41 -6"
+	readonly fouproto_mpls="${mplsproto} -6"
+	readonly gretaptype=ip6gretap
 	;;
 *)
 	echo "unknown arg: $1"
@@ -154,9 +163,10 @@ case "$1" in
 esac
 
 readonly tuntype=$2
-readonly datalen=$3
+readonly mac=$3
+readonly datalen=$4
 
-echo "encap ${addr1} to ${addr2}, type ${tuntype}, len ${datalen}"
+echo "encap ${addr1} to ${addr2}, type ${tuntype}, mac ${mac} len ${datalen}"
 
 trap cleanup EXIT
 
@@ -173,7 +183,7 @@ verify_data
 ip netns exec "${ns1}" tc qdisc add dev veth1 clsact
 ip netns exec "${ns1}" tc filter add dev veth1 egress \
 	bpf direct-action object-file ./test_tc_tunnel.o \
-	section "encap_${tuntype}"
+	section "encap_${tuntype}_${mac}"
 echo "test bpf encap without decap (expect failure)"
 server_listen
 ! client_connect
@@ -184,7 +194,18 @@ if [[ "$tuntype" =~ "udp" ]]; then
 	targs="encap fou encap-sport auto encap-dport $udpport"
 	# fou may be a module; allow this to fail.
 	modprobe "${foumod}" ||true
-	ip netns exec "${ns2}" ip fou add port 5555 ipproto ${fouproto}
+	if [[ "$mac" == "mpls" ]]; then
+		dport=${mplsudpport}
+		dproto=${fouproto_mpls}
+		tmode="mode any ttl 255"
+	else
+		dport=${udpport}
+		dproto=${fouproto}
+	fi
+	ip netns exec "${ns2}" ip fou add port $dport ipproto ${dproto}
+	targs="encap fou encap-sport auto encap-dport $dport"
+elif [[ "$tuntype" =~ "gre" && "$mac" == "eth" ]]; then
+	ttype=$gretaptype
 else
 	ttype=$tuntype
 	targs=""
@@ -194,7 +215,31 @@ fi
 # server is still running
 # client can connect again
 ip netns exec "${ns2}" ip link add name testtun0 type "${ttype}" \
-	remote "${addr1}" local "${addr2}" $targs
+	${tmode} remote "${addr1}" local "${addr2}" $targs
+
+expect_tun_fail=0
+
+if [[ "$tuntype" == "ip6udp" && "$mac" == "mpls" ]]; then
+	# No support for MPLS IPv6 fou tunnel; expect failure.
+	expect_tun_fail=1
+elif [[ "$tuntype" =~ "udp" && "$mac" == "eth" ]]; then
+	# No support for TEB fou tunnel; expect failure.
+	expect_tun_fail=1
+elif [[ "$tuntype" =~ "gre" && "$mac" == "eth" ]]; then
+	# Share ethernet address between tunnel/veth2 so L2 decap works.
+	ethaddr=$(ip netns exec "${ns2}" ip link show veth2 | \
+		  awk '/ether/ { print $2 }')
+	ip netns exec "${ns2}" ip link set testtun0 address $ethaddr
+elif [[ "$mac" == "mpls" ]]; then
+	modprobe mpls_iptunnel ||true
+	modprobe mpls_gso ||true
+	ip netns exec "${ns2}" sysctl -qw net.mpls.platform_labels=65536
+	ip netns exec "${ns2}" ip -f mpls route add 1000 dev lo
+	ip netns exec "${ns2}" ip link set lo up
+	ip netns exec "${ns2}" sysctl -qw net.mpls.conf.testtun0.input=1
+	ip netns exec "${ns2}" sysctl -qw net.ipv4.conf.lo.rp_filter=0
+fi
+
 # Because packets are decapped by the tunnel they arrive on testtun0 from
 # the IP stack perspective.  Ensure reverse path filtering is disabled
 # otherwise we drop the TCP SYN as arriving on testtun0 instead of the
@@ -204,16 +249,22 @@ ip netns exec "${ns2}" sysctl -qw net.ipv4.conf.all.rp_filter=0
 # selected as the max of the "all" and device-specific values.
 ip netns exec "${ns2}" sysctl -qw net.ipv4.conf.testtun0.rp_filter=0
 ip netns exec "${ns2}" ip link set dev testtun0 up
-echo "test bpf encap with tunnel device decap"
-client_connect
-verify_data
+if [[ "$expect_tun_fail" == 1 ]]; then
+	# This tunnel mode is not supported, so we expect failure.
+	echo "test bpf encap with tunnel device decap (expect failure)"
+	! client_connect
+else
+	echo "test bpf encap with tunnel device decap"
+	client_connect
+	verify_data
+	server_listen
+fi
 
 # serverside, use BPF for decap
 ip netns exec "${ns2}" ip link del dev testtun0
 ip netns exec "${ns2}" tc qdisc add dev veth2 clsact
 ip netns exec "${ns2}" tc filter add dev veth2 ingress \
 	bpf direct-action object-file ./test_tc_tunnel.o section decap
-server_listen
 echo "test bpf encap with bpf decap"
 client_connect
 verify_data
-- 
1.8.3.1

