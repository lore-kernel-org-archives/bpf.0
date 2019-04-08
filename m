Return-Path: <SRS0=xPz+=SK=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AC44C10F14
	for <bpf@archiver.kernel.org>; Mon,  8 Apr 2019 16:58:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D6B0214C6
	for <bpf@archiver.kernel.org>; Mon,  8 Apr 2019 16:58:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="j7FIOGn5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729246AbfDHQ6z (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 8 Apr 2019 12:58:55 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:52054 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729320AbfDHQ6q (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 8 Apr 2019 12:58:46 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x38GnJ3S046047;
        Mon, 8 Apr 2019 16:58:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=qJ22uhlA9Bbrf/4QO7sQyIebZNyASQlo0KHV/9l8gGU=;
 b=j7FIOGn5imvuJe9eNFJ7iJLvBMdEjlNqMhcYVMMJr6CV6PxqDAUOjJOU3yYz6LJF3u2n
 tO/5RebbGaQes7LXHgPn2vYqaEVaZpYQtk+ex7uVc4YO7YfnEesdcmJAYsNaAeXew6cj
 nrEdeTy3JxONs+WQi0FGe/y4ObdIfINrIWlZx9knhDmBXp/N7SVOLU7I0hxLbkwA4hQV
 NaIoYNJyHGpETaLadLd4C+98iHkgbe3ucVKdi+W6xlar3Br4P7j+hX1Qs1OkkYBkWbXi
 sq5OTdoqLvP9fT8U/f5lAwreHD8IyDL2arVpk63UtUNBrOiI09Ug9jPLyMFXxVJJB1bC pQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2130.oracle.com with ESMTP id 2rphme7ymr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 08 Apr 2019 16:58:16 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x38GvnXQ008269;
        Mon, 8 Apr 2019 16:58:15 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 2rpkehtmae-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 08 Apr 2019 16:58:15 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x38GwEPu001778;
        Mon, 8 Apr 2019 16:58:14 GMT
Received: from dhcp-10-175-203-155.vpn.oracle.com (/10.175.203.155)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 08 Apr 2019 09:58:14 -0700
From:   Alan Maguire <alan.maguire@oracle.com>
To:     willemb@google.com, ast@kernel.org, daniel@iogearbox.net,
        davem@davemloft.net, shuah@kernel.org, kafai@fb.com,
        songliubraving@fb.com, yhs@fb.com, quentin.monnet@netronome.com,
        john.fastabend@gmail.com, rdna@fb.com,
        linux-kselftest@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Cc:     Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v2 bpf-next 1/4] selftests_bpf: add UDP encap to test_tc_tunnel
Date:   Mon,  8 Apr 2019 17:57:45 +0100
Message-Id: <1554742668-28313-2-git-send-email-alan.maguire@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1554742668-28313-1-git-send-email-alan.maguire@oracle.com>
References: <1554742668-28313-1-git-send-email-alan.maguire@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9221 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=4 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1904080137
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9221 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=4 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1904080136
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

commit 868d523535c2 ("bpf: add bpf_skb_adjust_room encap flags")
introduced support to bpf_skb_adjust_room for GSO-friendly GRE
and UDP encapsulation and later introduced associated test_tc_tunnel
tests.  Here those tests are extended to cover UDP encapsulation also.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 tools/testing/selftests/bpf/progs/test_tc_tunnel.c | 141 +++++++++++++++------
 tools/testing/selftests/bpf/test_tc_tunnel.sh      |  60 +++++++--
 2 files changed, 147 insertions(+), 54 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/test_tc_tunnel.c b/tools/testing/selftests/bpf/progs/test_tc_tunnel.c
index f541c2d..7745a12 100644
--- a/tools/testing/selftests/bpf/progs/test_tc_tunnel.c
+++ b/tools/testing/selftests/bpf/progs/test_tc_tunnel.c
@@ -12,6 +12,7 @@
 #include <linux/ip.h>
 #include <linux/ipv6.h>
 #include <linux/tcp.h>
+#include <linux/udp.h>
 #include <linux/pkt_cls.h>
 #include <linux/types.h>
 
@@ -20,16 +21,27 @@
 
 static const int cfg_port = 8000;
 
-struct grev4hdr {
-	struct iphdr ip;
+static const int cfg_udp_src = 20000;
+static const int cfg_udp_dst = 5555;
+
+struct gre_hdr {
 	__be16 flags;
 	__be16 protocol;
 } __attribute__((packed));
 
-struct grev6hdr {
+union l4hdr {
+	struct udphdr udp;
+	struct gre_hdr gre;
+};
+
+struct v4hdr {
+	struct iphdr ip;
+	union l4hdr l4hdr;
+} __attribute__((packed));
+
+struct v6hdr {
 	struct ipv6hdr ip;
-	__be16 flags;
-	__be16 protocol;
+	union l4hdr l4hdr;
 } __attribute__((packed));
 
 static __always_inline void set_ipv4_csum(struct iphdr *iph)
@@ -47,10 +59,11 @@ static __always_inline void set_ipv4_csum(struct iphdr *iph)
 	iph->check = ~((csum & 0xffff) + (csum >> 16));
 }
 
-static __always_inline int encap_ipv4(struct __sk_buff *skb, bool with_gre)
+static __always_inline int encap_ipv4(struct __sk_buff *skb, __u8 encap_proto)
 {
-	struct grev4hdr h_outer;
 	struct iphdr iph_inner;
+	struct v4hdr h_outer;
+	struct udphdr *udph;
 	struct tcphdr tcph;
 	__u64 flags;
 	int olen;
@@ -70,12 +83,29 @@ static __always_inline int encap_ipv4(struct __sk_buff *skb, bool with_gre)
 	if (tcph.dest != __bpf_constant_htons(cfg_port))
 		return TC_ACT_OK;
 
+	olen = sizeof(h_outer.ip);
+
 	flags = BPF_F_ADJ_ROOM_FIXED_GSO | BPF_F_ADJ_ROOM_ENCAP_L3_IPV4;
-	if (with_gre) {
+	switch (encap_proto) {
+	case IPPROTO_GRE:
 		flags |= BPF_F_ADJ_ROOM_ENCAP_L4_GRE;
-		olen = sizeof(h_outer);
-	} else {
-		olen = sizeof(h_outer.ip);
+		olen += sizeof(h_outer.l4hdr.gre);
+		h_outer.l4hdr.gre.protocol = bpf_htons(ETH_P_IP);
+		h_outer.l4hdr.gre.flags = 0;
+		break;
+	case IPPROTO_UDP:
+		flags |= BPF_F_ADJ_ROOM_ENCAP_L4_UDP;
+		olen += sizeof(h_outer.l4hdr.udp);
+		h_outer.l4hdr.udp.source = __bpf_constant_htons(cfg_udp_src);
+		h_outer.l4hdr.udp.dest = __bpf_constant_htons(cfg_udp_dst);
+		h_outer.l4hdr.udp.check = 0;
+		h_outer.l4hdr.udp.len = bpf_htons(bpf_ntohs(iph_inner.tot_len) +
+						  sizeof(h_outer.l4hdr.udp));
+		break;
+	case IPPROTO_IPIP:
+		break;
+	default:
+		return TC_ACT_OK;
 	}
 
 	/* add room between mac and network header */
@@ -85,16 +115,10 @@ static __always_inline int encap_ipv4(struct __sk_buff *skb, bool with_gre)
 	/* prepare new outer network header */
 	h_outer.ip = iph_inner;
 	h_outer.ip.tot_len = bpf_htons(olen +
-				      bpf_htons(h_outer.ip.tot_len));
-	if (with_gre) {
-		h_outer.ip.protocol = IPPROTO_GRE;
-		h_outer.protocol = bpf_htons(ETH_P_IP);
-		h_outer.flags = 0;
-	} else {
-		h_outer.ip.protocol = IPPROTO_IPIP;
-	}
+				       bpf_htons(h_outer.ip.tot_len));
+	h_outer.ip.protocol = encap_proto;
 
-	set_ipv4_csum((void *)&h_outer.ip);
+	set_ipv4_csum(&h_outer.ip);
 
 	/* store new outer network header */
 	if (bpf_skb_store_bytes(skb, ETH_HLEN, &h_outer, olen,
@@ -104,11 +128,12 @@ static __always_inline int encap_ipv4(struct __sk_buff *skb, bool with_gre)
 	return TC_ACT_OK;
 }
 
-static __always_inline int encap_ipv6(struct __sk_buff *skb, bool with_gre)
+static __always_inline int encap_ipv6(struct __sk_buff *skb, __u8 encap_proto)
 {
 	struct ipv6hdr iph_inner;
-	struct grev6hdr h_outer;
+	struct v6hdr h_outer;
 	struct tcphdr tcph;
+	__u16 tot_len;
 	__u64 flags;
 	int olen;
 
@@ -124,15 +149,32 @@ static __always_inline int encap_ipv6(struct __sk_buff *skb, bool with_gre)
 	if (tcph.dest != __bpf_constant_htons(cfg_port))
 		return TC_ACT_OK;
 
+	olen = sizeof(h_outer.ip);
+
 	flags = BPF_F_ADJ_ROOM_FIXED_GSO | BPF_F_ADJ_ROOM_ENCAP_L3_IPV6;
-	if (with_gre) {
+	switch (encap_proto) {
+	case IPPROTO_GRE:
 		flags |= BPF_F_ADJ_ROOM_ENCAP_L4_GRE;
-		olen = sizeof(h_outer);
-	} else {
-		olen = sizeof(h_outer.ip);
+		olen += sizeof(h_outer.l4hdr.gre);
+		h_outer.l4hdr.gre.protocol = bpf_htons(ETH_P_IPV6);
+		h_outer.l4hdr.gre.flags = 0;
+		break;
+	case IPPROTO_UDP:
+		flags |= BPF_F_ADJ_ROOM_ENCAP_L4_UDP;
+		olen += sizeof(h_outer.l4hdr.udp);
+		h_outer.l4hdr.udp.source = __bpf_constant_htons(cfg_udp_src);
+		h_outer.l4hdr.udp.dest = __bpf_constant_htons(cfg_udp_dst);
+		tot_len = bpf_ntohs(iph_inner.payload_len) + sizeof(iph_inner) +
+			  sizeof(h_outer.l4hdr.udp);
+		h_outer.l4hdr.udp.check = 0;
+		h_outer.l4hdr.udp.len = bpf_htons(tot_len);
+		break;
+	case IPPROTO_IPV6:
+		break;
+	default:
+		return TC_ACT_OK;
 	}
 
-
 	/* add room between mac and network header */
 	if (bpf_skb_adjust_room(skb, olen, BPF_ADJ_ROOM_MAC, flags))
 		return TC_ACT_SHOT;
@@ -141,13 +183,8 @@ static __always_inline int encap_ipv6(struct __sk_buff *skb, bool with_gre)
 	h_outer.ip = iph_inner;
 	h_outer.ip.payload_len = bpf_htons(olen +
 					   bpf_ntohs(h_outer.ip.payload_len));
-	if (with_gre) {
-		h_outer.ip.nexthdr = IPPROTO_GRE;
-		h_outer.protocol = bpf_htons(ETH_P_IPV6);
-		h_outer.flags = 0;
-	} else {
-		h_outer.ip.nexthdr = IPPROTO_IPV6;
-	}
+
+	h_outer.ip.nexthdr = encap_proto;
 
 	/* store new outer network header */
 	if (bpf_skb_store_bytes(skb, ETH_HLEN, &h_outer, olen,
@@ -161,7 +198,7 @@ static __always_inline int encap_ipv6(struct __sk_buff *skb, bool with_gre)
 int __encap_ipip(struct __sk_buff *skb)
 {
 	if (skb->protocol == __bpf_constant_htons(ETH_P_IP))
-		return encap_ipv4(skb, false);
+		return encap_ipv4(skb, IPPROTO_IPIP);
 	else
 		return TC_ACT_OK;
 }
@@ -170,7 +207,16 @@ int __encap_ipip(struct __sk_buff *skb)
 int __encap_gre(struct __sk_buff *skb)
 {
 	if (skb->protocol == __bpf_constant_htons(ETH_P_IP))
-		return encap_ipv4(skb, true);
+		return encap_ipv4(skb, IPPROTO_GRE);
+	else
+		return TC_ACT_OK;
+}
+
+SEC("encap_udp")
+int __encap_udp(struct __sk_buff *skb)
+{
+	if (skb->protocol == __bpf_constant_htons(ETH_P_IP))
+		return encap_ipv4(skb, IPPROTO_UDP);
 	else
 		return TC_ACT_OK;
 }
@@ -179,7 +225,7 @@ int __encap_gre(struct __sk_buff *skb)
 int __encap_ip6tnl(struct __sk_buff *skb)
 {
 	if (skb->protocol == __bpf_constant_htons(ETH_P_IPV6))
-		return encap_ipv6(skb, false);
+		return encap_ipv6(skb, IPPROTO_IPV6);
 	else
 		return TC_ACT_OK;
 }
@@ -188,23 +234,34 @@ int __encap_ip6tnl(struct __sk_buff *skb)
 int __encap_ip6gre(struct __sk_buff *skb)
 {
 	if (skb->protocol == __bpf_constant_htons(ETH_P_IPV6))
-		return encap_ipv6(skb, true);
+		return encap_ipv6(skb, IPPROTO_GRE);
+	else
+		return TC_ACT_OK;
+}
+
+SEC("encap_ip6udp")
+int __encap_ip6udp(struct __sk_buff *skb)
+{
+	if (skb->protocol == __bpf_constant_htons(ETH_P_IPV6))
+		return encap_ipv6(skb, IPPROTO_UDP);
 	else
 		return TC_ACT_OK;
 }
 
 static int decap_internal(struct __sk_buff *skb, int off, int len, char proto)
 {
-	char buf[sizeof(struct grev6hdr)];
-	int olen;
+	char buf[sizeof(struct v6hdr)];
+	int olen = len;
 
 	switch (proto) {
 	case IPPROTO_IPIP:
 	case IPPROTO_IPV6:
-		olen = len;
 		break;
 	case IPPROTO_GRE:
-		olen = len + 4 /* gre hdr */;
+		olen += sizeof(struct gre_hdr);
+		break;
+	case IPPROTO_UDP:
+		olen += sizeof(struct udphdr);
 		break;
 	default:
 		return TC_ACT_OK;
diff --git a/tools/testing/selftests/bpf/test_tc_tunnel.sh b/tools/testing/selftests/bpf/test_tc_tunnel.sh
index c805adb..f87d645 100755
--- a/tools/testing/selftests/bpf/test_tc_tunnel.sh
+++ b/tools/testing/selftests/bpf/test_tc_tunnel.sh
@@ -15,6 +15,9 @@ readonly ns2_v4=192.168.1.2
 readonly ns1_v6=fd::1
 readonly ns2_v6=fd::2
 
+# Must match port used by bpf program
+readonly udpport=5555
+
 readonly infile="$(mktemp)"
 readonly outfile="$(mktemp)"
 
@@ -38,8 +41,8 @@ setup() {
 	# clamp route to reserve room for tunnel headers
 	ip -netns "${ns1}" -4 route flush table main
 	ip -netns "${ns1}" -6 route flush table main
-	ip -netns "${ns1}" -4 route add "${ns2_v4}" mtu 1476 dev veth1
-	ip -netns "${ns1}" -6 route add "${ns2_v6}" mtu 1456 dev veth1
+	ip -netns "${ns1}" -4 route add "${ns2_v4}" mtu 1472 dev veth1
+	ip -netns "${ns1}" -6 route add "${ns2_v6}" mtu 1452 dev veth1
 
 	sleep 1
 
@@ -103,6 +106,18 @@ if [[ "$#" -eq "0" ]]; then
 	echo "ip6 gre gso"
 	$0 ipv6 ip6gre 2000
 
+	echo "ip udp"
+	$0 ipv4 udp 100
+
+	echo "ip6 udp"
+	$0 ipv6 ip6udp 100
+
+	echo "ip udp gso"
+	$0 ipv4 udp 2000
+
+	echo "ip6 udp gso"
+	$0 ipv6 ip6udp 2000
+
 	echo "OK. All tests passed"
 	exit 0
 fi
@@ -117,12 +132,20 @@ case "$1" in
 "ipv4")
 	readonly addr1="${ns1_v4}"
 	readonly addr2="${ns2_v4}"
-	readonly netcat_opt=-4
+	readonly ipproto=4
+	readonly netcat_opt=-${ipproto}
+	readonly foumod=fou
+	readonly foutype=ipip
+	readonly fouproto=4
 	;;
 "ipv6")
 	readonly addr1="${ns1_v6}"
 	readonly addr2="${ns2_v6}"
-	readonly netcat_opt=-6
+	readonly ipproto=6
+	readonly netcat_opt=-${ipproto}
+	readonly foumod=fou6
+	readonly foutype=ip6tnl
+	readonly fouproto="41 -6"
 	;;
 *)
 	echo "unknown arg: $1"
@@ -158,12 +181,25 @@ server_listen
 # serverside, insert decap module
 # server is still running
 # client can connect again
-ip netns exec "${ns2}" ip link add dev testtun0 type "${tuntype}" \
-	remote "${addr1}" local "${addr2}"
-# Because packets are decapped by the tunnel they arrive on testtun0 from
-# the IP stack perspective.  Ensure reverse path filtering is disabled
-# otherwise we drop the TCP SYN as arriving on testtun0 instead of the
-# expected veth2 (veth2 is where 192.168.1.2 is configured).
+
+if [[ "$tuntype" =~ "udp" ]]; then
+	# Set up fou tunnel.
+	ttype="${foutype}"
+	targs="encap fou encap-sport auto encap-dport $udpport"
+	# fou may be a module; allow this to fail.
+	modprobe "${foumod}" ||true
+	ip netns exec "${ns2}" ip fou add port 5555 ipproto ${fouproto}
+else
+	ttype=$tuntype
+	targs=""
+fi
+ip netns exec "${ns2}" ip link add name testtun0 type "${ttype}" \
+	remote "${addr1}" local "${addr2}" $targs
+# Because packets are decapped by the tunnel they arrive on testtun0
+# from the IP stack perspective.  Ensure reverse path filtering is
+# disabled otherwise we drop the TCP SYN as arriving on testtun0
+# instead of the expected veth2 (veth2 is where 192.168.1.2 is
+# configured).
 ip netns exec "${ns2}" sysctl -qw net.ipv4.conf.all.rp_filter=0
 # rp needs to be disabled for both all and testtun0 as the rp value is
 # selected as the max of the "all" and device-specific values.
@@ -172,13 +208,13 @@ ip netns exec "${ns2}" ip link set dev testtun0 up
 echo "test bpf encap with tunnel device decap"
 client_connect
 verify_data
+ip netns exec "${ns2}" ip link del dev testtun0
 
+server_listen
 # serverside, use BPF for decap
-ip netns exec "${ns2}" ip link del dev testtun0
 ip netns exec "${ns2}" tc qdisc add dev veth2 clsact
 ip netns exec "${ns2}" tc filter add dev veth2 ingress \
 	bpf direct-action object-file ./test_tc_tunnel.o section decap
-server_listen
 echo "test bpf encap with bpf decap"
 client_connect
 verify_data
-- 
1.8.3.1

