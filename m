Return-Path: <SRS0=5VBK=SF=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C18F1C4360F
	for <bpf@archiver.kernel.org>; Wed,  3 Apr 2019 15:43:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51089206B8
	for <bpf@archiver.kernel.org>; Wed,  3 Apr 2019 15:43:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RHtlzMkC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726157AbfDCPnq (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 3 Apr 2019 11:43:46 -0400
Received: from mail-vs1-f73.google.com ([209.85.217.73]:48955 "EHLO
        mail-vs1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726151AbfDCPnq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 3 Apr 2019 11:43:46 -0400
Received: by mail-vs1-f73.google.com with SMTP id a17so3170119vso.15
        for <bpf@vger.kernel.org>; Wed, 03 Apr 2019 08:43:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=35Z8+I1UBULkuhnkkrzcygjdVTydMNtCC9t8TeFT6Zc=;
        b=RHtlzMkCtzz8hlLYpJ+xYm3hd0IDlftp85RjRhHF8FemFj9R5c2oNjQG6J4/hHZDWj
         jhGtwCxXv/F3/5F2s7a6GW5QMgUS1SZgolpRyOXwzmZoBU53dDyeiHZfmb+blmRhSHHF
         jHlTkJoOWV9PcIvL4OK4JPlcw+w/FcJnkK0gzIHg9tVQa1Cb8AYtocEtN/ZV2jVk+MY+
         FHmcHHY55hsxKIypf3CN9VRj6OjaHciEJyoHHO1MqoizVElphgiA3ou8cfk3xyihgENo
         ikykIbvGQNDenXupngkGlghAZaVdVG75a00OSJiwwwNMmXRdrx9oEHw2rlxy7p1eROwO
         t2uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=35Z8+I1UBULkuhnkkrzcygjdVTydMNtCC9t8TeFT6Zc=;
        b=D2eQlqKpNVKaWJMieJAPwAYTCOsbFSSrlloO4r5NfW4IaLiE7R9abugATnPbCULzMX
         clfm3G3Zqh/c+TQ6B4Yr1MUDD4gIo66U37fkwLYY1+8GkKAgk0uUK0USBZojloJMezz+
         rgMPuMGUhzaAf5ngZf15TS2kHtXhtMNT3cqKWZ2CiHNngiLpwqu2Kknj9HCBF8kq3aq3
         +RHecaNK4kNccFEYh8ZB4pJQlDT4UT6651d5E/EX1CnS0J1m4XJZD24qwLeVPGFQ3Wvo
         4fGgQqiulhZVNCOkObnmTa8C4/NhE6JjjAFVYrQjY7m2FAFdialLz5xpN75mWvpy2KA+
         sklg==
X-Gm-Message-State: APjAAAVgjxkfh+p8XoRH7uEcS7ZmWmbG3aTbSl4wFdOpYQnrZJibfAII
        bU+nENCTawY1GifjKc7Yw+upmY7S
X-Google-Smtp-Source: APXvYqxFm82RoLdDWdjSQ/JTWvVWkva0I/duuJWzLhgor5vguK7XIfjHNd6Y+gVUAObpkE7XOHRrGED7
X-Received: by 2002:ab0:2396:: with SMTP id b22mr92835uan.1.1554306224478;
 Wed, 03 Apr 2019 08:43:44 -0700 (PDT)
Date:   Wed,  3 Apr 2019 08:43:38 -0700
Message-Id: <20190403154338.29990-1-posk@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
Subject: [PATCH bpf-next] selftests: bpf: add VRF test cases to lwt_ip_encap test.
From:   Peter Oskolkov <posk@google.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Cc:     David Ahern <dsahern@gmail.com>, Peter Oskolkov <posk@posk.io>,
        Peter Oskolkov <posk@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch adds tests validating that VRF and BPF-LWT
encap work together well, as requested by David Ahern.

Signed-off-by: Peter Oskolkov <posk@google.com>
---
 .../selftests/bpf/test_lwt_ip_encap.sh        | 134 +++++++++++-------
 1 file changed, 86 insertions(+), 48 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_lwt_ip_encap.sh b/tools/testing/selftests/bpf/test_lwt_ip_encap.sh
index d4d3391cc13af..acf7a74f97cd9 100755
--- a/tools/testing/selftests/bpf/test_lwt_ip_encap.sh
+++ b/tools/testing/selftests/bpf/test_lwt_ip_encap.sh
@@ -129,6 +129,24 @@ setup()
 	ip link set veth7 netns ${NS2}
 	ip link set veth8 netns ${NS3}
 
+	if [ ! -z "${VRF}" ] ; then
+		ip -netns ${NS1} link add red type vrf table 1001
+		ip -netns ${NS1} link set red up
+		ip -netns ${NS1} route add table 1001 unreachable default metric 8192
+		ip -netns ${NS1} -6 route add table 1001 unreachable default metric 8192
+		ip -netns ${NS1} link set veth1 vrf red
+		ip -netns ${NS1} link set veth5 vrf red
+
+		ip -netns ${NS2} link add red type vrf table 1001
+		ip -netns ${NS2} link set red up
+		ip -netns ${NS2} route add table 1001 unreachable default metric 8192
+		ip -netns ${NS2} -6 route add table 1001 unreachable default metric 8192
+		ip -netns ${NS2} link set veth2 vrf red
+		ip -netns ${NS2} link set veth3 vrf red
+		ip -netns ${NS2} link set veth6 vrf red
+		ip -netns ${NS2} link set veth7 vrf red
+	fi
+
 	# configure addesses: the top route (1-2-3-4)
 	ip -netns ${NS1}    addr add ${IPv4_1}/24  dev veth1
 	ip -netns ${NS2}    addr add ${IPv4_2}/24  dev veth2
@@ -163,29 +181,29 @@ setup()
 
 	# NS1
 	# top route
-	ip -netns ${NS1}    route add ${IPv4_2}/32  dev veth1
-	ip -netns ${NS1}    route add default dev veth1 via ${IPv4_2}  # go top by default
-	ip -netns ${NS1} -6 route add ${IPv6_2}/128 dev veth1
-	ip -netns ${NS1} -6 route add default dev veth1 via ${IPv6_2}  # go top by default
+	ip -netns ${NS1}    route add ${IPv4_2}/32  dev veth1 ${VRF}
+	ip -netns ${NS1}    route add default dev veth1 via ${IPv4_2} ${VRF}  # go top by default
+	ip -netns ${NS1} -6 route add ${IPv6_2}/128 dev veth1 ${VRF}
+	ip -netns ${NS1} -6 route add default dev veth1 via ${IPv6_2} ${VRF}  # go top by default
 	# bottom route
-	ip -netns ${NS1}    route add ${IPv4_6}/32  dev veth5
-	ip -netns ${NS1}    route add ${IPv4_7}/32  dev veth5 via ${IPv4_6}
-	ip -netns ${NS1}    route add ${IPv4_8}/32  dev veth5 via ${IPv4_6}
-	ip -netns ${NS1} -6 route add ${IPv6_6}/128 dev veth5
-	ip -netns ${NS1} -6 route add ${IPv6_7}/128 dev veth5 via ${IPv6_6}
-	ip -netns ${NS1} -6 route add ${IPv6_8}/128 dev veth5 via ${IPv6_6}
+	ip -netns ${NS1}    route add ${IPv4_6}/32  dev veth5 ${VRF}
+	ip -netns ${NS1}    route add ${IPv4_7}/32  dev veth5 via ${IPv4_6} ${VRF}
+	ip -netns ${NS1}    route add ${IPv4_8}/32  dev veth5 via ${IPv4_6} ${VRF}
+	ip -netns ${NS1} -6 route add ${IPv6_6}/128 dev veth5 ${VRF}
+	ip -netns ${NS1} -6 route add ${IPv6_7}/128 dev veth5 via ${IPv6_6} ${VRF}
+	ip -netns ${NS1} -6 route add ${IPv6_8}/128 dev veth5 via ${IPv6_6} ${VRF}
 
 	# NS2
 	# top route
-	ip -netns ${NS2}    route add ${IPv4_1}/32  dev veth2
-	ip -netns ${NS2}    route add ${IPv4_4}/32  dev veth3
-	ip -netns ${NS2} -6 route add ${IPv6_1}/128 dev veth2
-	ip -netns ${NS2} -6 route add ${IPv6_4}/128 dev veth3
+	ip -netns ${NS2}    route add ${IPv4_1}/32  dev veth2 ${VRF}
+	ip -netns ${NS2}    route add ${IPv4_4}/32  dev veth3 ${VRF}
+	ip -netns ${NS2} -6 route add ${IPv6_1}/128 dev veth2 ${VRF}
+	ip -netns ${NS2} -6 route add ${IPv6_4}/128 dev veth3 ${VRF}
 	# bottom route
-	ip -netns ${NS2}    route add ${IPv4_5}/32  dev veth6
-	ip -netns ${NS2}    route add ${IPv4_8}/32  dev veth7
-	ip -netns ${NS2} -6 route add ${IPv6_5}/128 dev veth6
-	ip -netns ${NS2} -6 route add ${IPv6_8}/128 dev veth7
+	ip -netns ${NS2}    route add ${IPv4_5}/32  dev veth6 ${VRF}
+	ip -netns ${NS2}    route add ${IPv4_8}/32  dev veth7 ${VRF}
+	ip -netns ${NS2} -6 route add ${IPv6_5}/128 dev veth6 ${VRF}
+	ip -netns ${NS2} -6 route add ${IPv6_8}/128 dev veth7 ${VRF}
 
 	# NS3
 	# top route
@@ -207,16 +225,16 @@ setup()
 	ip -netns ${NS3} tunnel add gre_dev mode gre remote ${IPv4_1} local ${IPv4_GRE} ttl 255
 	ip -netns ${NS3} link set gre_dev up
 	ip -netns ${NS3} addr add ${IPv4_GRE} dev gre_dev
-	ip -netns ${NS1} route add ${IPv4_GRE}/32 dev veth5 via ${IPv4_6}
-	ip -netns ${NS2} route add ${IPv4_GRE}/32 dev veth7 via ${IPv4_8}
+	ip -netns ${NS1} route add ${IPv4_GRE}/32 dev veth5 via ${IPv4_6} ${VRF}
+	ip -netns ${NS2} route add ${IPv4_GRE}/32 dev veth7 via ${IPv4_8} ${VRF}
 
 
 	# configure IPv6 GRE device in NS3, and a route to it via the "bottom" route
 	ip -netns ${NS3} -6 tunnel add name gre6_dev mode ip6gre remote ${IPv6_1} local ${IPv6_GRE} ttl 255
 	ip -netns ${NS3} link set gre6_dev up
 	ip -netns ${NS3} -6 addr add ${IPv6_GRE} nodad dev gre6_dev
-	ip -netns ${NS1} -6 route add ${IPv6_GRE}/128 dev veth5 via ${IPv6_6}
-	ip -netns ${NS2} -6 route add ${IPv6_GRE}/128 dev veth7 via ${IPv6_8}
+	ip -netns ${NS1} -6 route add ${IPv6_GRE}/128 dev veth5 via ${IPv6_6} ${VRF}
+	ip -netns ${NS2} -6 route add ${IPv6_GRE}/128 dev veth7 via ${IPv6_8} ${VRF}
 
 	# rp_filter gets confused by what these tests are doing, so disable it
 	ip netns exec ${NS1} sysctl -wq net.ipv4.conf.all.rp_filter=0
@@ -244,18 +262,18 @@ trap cleanup EXIT
 
 remove_routes_to_gredev()
 {
-	ip -netns ${NS1} route del ${IPv4_GRE} dev veth5
-	ip -netns ${NS2} route del ${IPv4_GRE} dev veth7
-	ip -netns ${NS1} -6 route del ${IPv6_GRE}/128 dev veth5
-	ip -netns ${NS2} -6 route del ${IPv6_GRE}/128 dev veth7
+	ip -netns ${NS1} route del ${IPv4_GRE} dev veth5 ${VRF}
+	ip -netns ${NS2} route del ${IPv4_GRE} dev veth7 ${VRF}
+	ip -netns ${NS1} -6 route del ${IPv6_GRE}/128 dev veth5 ${VRF}
+	ip -netns ${NS2} -6 route del ${IPv6_GRE}/128 dev veth7 ${VRF}
 }
 
 add_unreachable_routes_to_gredev()
 {
-	ip -netns ${NS1} route add unreachable ${IPv4_GRE}/32
-	ip -netns ${NS2} route add unreachable ${IPv4_GRE}/32
-	ip -netns ${NS1} -6 route add unreachable ${IPv6_GRE}/128
-	ip -netns ${NS2} -6 route add unreachable ${IPv6_GRE}/128
+	ip -netns ${NS1} route add unreachable ${IPv4_GRE}/32 ${VRF}
+	ip -netns ${NS2} route add unreachable ${IPv4_GRE}/32 ${VRF}
+	ip -netns ${NS1} -6 route add unreachable ${IPv6_GRE}/128 ${VRF}
+	ip -netns ${NS2} -6 route add unreachable ${IPv6_GRE}/128 ${VRF}
 }
 
 test_ping()
@@ -265,10 +283,10 @@ test_ping()
 	local RET=0
 
 	if [ "${PROTO}" == "IPv4" ] ; then
-		ip netns exec ${NS1} ping  -c 1 -W 1 -I ${IPv4_SRC} ${IPv4_DST} 2>&1 > /dev/null
+		ip netns exec ${NS1} ping  -c 1 -W 1 -I veth1 ${IPv4_DST} 2>&1 > /dev/null
 		RET=$?
 	elif [ "${PROTO}" == "IPv6" ] ; then
-		ip netns exec ${NS1} ping6 -c 1 -W 6 -I ${IPv6_SRC} ${IPv6_DST} 2>&1 > /dev/null
+		ip netns exec ${NS1} ping6 -c 1 -W 6 -I veth1 ${IPv6_DST} 2>&1 > /dev/null
 		RET=$?
 	else
 		echo "    test_ping: unknown PROTO: ${PROTO}"
@@ -328,7 +346,7 @@ test_gso()
 test_egress()
 {
 	local readonly ENCAP=$1
-	echo "starting egress ${ENCAP} encap test"
+	echo "starting egress ${ENCAP} encap test ${VRF}"
 	setup
 
 	# by default, pings work
@@ -336,26 +354,35 @@ test_egress()
 	test_ping IPv6 0
 
 	# remove NS2->DST routes, ping fails
-	ip -netns ${NS2}    route del ${IPv4_DST}/32  dev veth3
-	ip -netns ${NS2} -6 route del ${IPv6_DST}/128 dev veth3
+	ip -netns ${NS2}    route del ${IPv4_DST}/32  dev veth3 ${VRF}
+	ip -netns ${NS2} -6 route del ${IPv6_DST}/128 dev veth3 ${VRF}
 	test_ping IPv4 1
 	test_ping IPv6 1
 
 	# install replacement routes (LWT/eBPF), pings succeed
 	if [ "${ENCAP}" == "IPv4" ] ; then
-		ip -netns ${NS1} route add ${IPv4_DST} encap bpf xmit obj test_lwt_ip_encap.o sec encap_gre dev veth1
-		ip -netns ${NS1} -6 route add ${IPv6_DST} encap bpf xmit obj test_lwt_ip_encap.o sec encap_gre dev veth1
+		ip -netns ${NS1} route add ${IPv4_DST} encap bpf xmit obj \
+			test_lwt_ip_encap.o sec encap_gre dev veth1 ${VRF}
+		ip -netns ${NS1} -6 route add ${IPv6_DST} encap bpf xmit obj \
+			test_lwt_ip_encap.o sec encap_gre dev veth1 ${VRF}
 	elif [ "${ENCAP}" == "IPv6" ] ; then
-		ip -netns ${NS1} route add ${IPv4_DST} encap bpf xmit obj test_lwt_ip_encap.o sec encap_gre6 dev veth1
-		ip -netns ${NS1} -6 route add ${IPv6_DST} encap bpf xmit obj test_lwt_ip_encap.o sec encap_gre6 dev veth1
+		ip -netns ${NS1} route add ${IPv4_DST} encap bpf xmit obj \
+			test_lwt_ip_encap.o sec encap_gre6 dev veth1 ${VRF}
+		ip -netns ${NS1} -6 route add ${IPv6_DST} encap bpf xmit obj \
+			test_lwt_ip_encap.o sec encap_gre6 dev veth1 ${VRF}
 	else
 		echo "    unknown encap ${ENCAP}"
 		TEST_STATUS=1
 	fi
 	test_ping IPv4 0
 	test_ping IPv6 0
-	test_gso IPv4
-	test_gso IPv6
+
+	# skip GSO tests with VRF: VRF routing needs properly assigned
+	# source IP/device, which is easy to do with ping and hard with dd/nc.
+	if [ -z "${VRF}" ] ; then
+		test_gso IPv4
+		test_gso IPv6
+	fi
 
 	# a negative test: remove routes to GRE devices: ping fails
 	remove_routes_to_gredev
@@ -374,7 +401,7 @@ test_egress()
 test_ingress()
 {
 	local readonly ENCAP=$1
-	echo "starting ingress ${ENCAP} encap test"
+	echo "starting ingress ${ENCAP} encap test ${VRF}"
 	setup
 
 	# need to wait a bit for IPv6 to autoconf, otherwise
@@ -385,18 +412,22 @@ test_ingress()
 	test_ping IPv6 0
 
 	# remove NS2->DST routes, pings fail
-	ip -netns ${NS2}    route del ${IPv4_DST}/32  dev veth3
-	ip -netns ${NS2} -6 route del ${IPv6_DST}/128 dev veth3
+	ip -netns ${NS2}    route del ${IPv4_DST}/32  dev veth3 ${VRF}
+	ip -netns ${NS2} -6 route del ${IPv6_DST}/128 dev veth3 ${VRF}
 	test_ping IPv4 1
 	test_ping IPv6 1
 
 	# install replacement routes (LWT/eBPF), pings succeed
 	if [ "${ENCAP}" == "IPv4" ] ; then
-		ip -netns ${NS2} route add ${IPv4_DST} encap bpf in obj test_lwt_ip_encap.o sec encap_gre dev veth2
-		ip -netns ${NS2} -6 route add ${IPv6_DST} encap bpf in obj test_lwt_ip_encap.o sec encap_gre dev veth2
+		ip -netns ${NS2} route add ${IPv4_DST} encap bpf in obj \
+			test_lwt_ip_encap.o sec encap_gre dev veth2 ${VRF}
+		ip -netns ${NS2} -6 route add ${IPv6_DST} encap bpf in obj \
+			test_lwt_ip_encap.o sec encap_gre dev veth2 ${VRF}
 	elif [ "${ENCAP}" == "IPv6" ] ; then
-		ip -netns ${NS2} route add ${IPv4_DST} encap bpf in obj test_lwt_ip_encap.o sec encap_gre6 dev veth2
-		ip -netns ${NS2} -6 route add ${IPv6_DST} encap bpf in obj test_lwt_ip_encap.o sec encap_gre6 dev veth2
+		ip -netns ${NS2} route add ${IPv4_DST} encap bpf in obj \
+			test_lwt_ip_encap.o sec encap_gre6 dev veth2 ${VRF}
+		ip -netns ${NS2} -6 route add ${IPv6_DST} encap bpf in obj \
+			test_lwt_ip_encap.o sec encap_gre6 dev veth2 ${VRF}
 	else
 		echo "FAIL: unknown encap ${ENCAP}"
 		TEST_STATUS=1
@@ -418,6 +449,13 @@ test_ingress()
 	process_test_results
 }
 
+VRF=""
+test_egress IPv4
+test_egress IPv6
+test_ingress IPv4
+test_ingress IPv6
+
+VRF="vrf red"
 test_egress IPv4
 test_egress IPv6
 test_ingress IPv4
-- 
2.21.0.392.gf8f6787159e-goog

