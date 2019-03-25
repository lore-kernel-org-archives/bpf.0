Return-Path: <SRS0=sqwL=R4=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39366C10F03
	for <bpf@archiver.kernel.org>; Mon, 25 Mar 2019 09:37:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09A5520863
	for <bpf@archiver.kernel.org>; Mon, 25 Mar 2019 09:37:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="QQJ354/x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730152AbfCYJhI (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 25 Mar 2019 05:37:08 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:41028 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729608AbfCYJhI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 25 Mar 2019 05:37:08 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x2P9Xm58004452;
        Mon, 25 Mar 2019 09:36:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to :
 subject : message-id : mime-version : content-type; s=corp-2018-07-02;
 bh=ODXQUl6UiX0G3kTqElQQJlTaEZVLWMophi+7IsoU+iw=;
 b=QQJ354/xZi2frUtnwRNa76MGEyHo7e2VHm99+fw3AiMOxQhsHo5SFbQSsxp6G6ur1HN3
 zVrByaUzdHKfqmYM2T+edS7NjJMCCP9I5/ClaqjunS5w57mNppUAMQ9xH/FeVQEzRTRL
 YeSbuhBsyuQG4RDXSoakxtdrKvAQFNhAm6gR2Qep/gJPIF5xEUyZwOQptY+7u6Q1jGVq
 WSl4Bo1FhEdzDaPTchBd15zxMe3gZH7O/pz6KywsjKacIncpO+5Ph1wnAvDaP79pIaMX
 6ZPJTFhN8E867dVKtVnA4MXbQAyqcYl639gPfonCMjP9UUdMO36tBPGhtz1gju13nR/6 Hw== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2130.oracle.com with ESMTP id 2re6g0twm6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Mar 2019 09:36:45 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x2P9aiAn022953
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Mar 2019 09:36:44 GMT
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x2P9aion027456;
        Mon, 25 Mar 2019 09:36:44 GMT
Received: from dhcp-10-175-167-141.vpn.oracle.com (/10.175.167.141)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 25 Mar 2019 02:36:44 -0700
Date:   Mon, 25 Mar 2019 09:36:37 +0000 (GMT)
From:   Alan Maguire <alan.maguire@oracle.com>
X-X-Sender: alan@dhcp-10-175-167-141.vpn.oracle.com
To:     willemdebruijn.kernel@gmail.com, shuah@kernel.org, ast@kernel.org,
        daniel@iogearbox.net, kafai@fb.com, songliubraving@fb.com,
        yhs@fb.com, linux-kselftest@vger.kernel.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org
Subject: [PATCH bpf-next] bpf: test_tc_tunnel.sh needs reverse path filtering
 disabled
Message-ID: <alpine.LRH.2.20.1903250930270.2818@dhcp-10-175-167-141.vpn.oracle.com>
User-Agent: Alpine 2.20 (LRH 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9205 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=4 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1903250072
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

test_tc_tunnel.sh sets up a pair of namespaces connected by a
veth pair to verify encap/decap using bpf_skb_adjust_room.  In
testing this, it uses tunnel links as the peer of the bpf-based
encap/decap.  However because the same IP header is used for inner
and outer IP, when packets arrive at the tunnel interface they will
be dropped by reverse path filtering as those packets are expected
on the veth interface (where the destination IP of the decapped
packet is configured).

To avoid this, ensure reverse path filtering is disabled for the
namespace using tunneling.

Fixes: 98cdabcd0798 ("selftests/bpf: bpf tunnel encap test")
Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 tools/testing/selftests/bpf/test_tc_tunnel.sh | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/testing/selftests/bpf/test_tc_tunnel.sh b/tools/testing/selftests/bpf/test_tc_tunnel.sh
index dcf3206..c805adb 100755
--- a/tools/testing/selftests/bpf/test_tc_tunnel.sh
+++ b/tools/testing/selftests/bpf/test_tc_tunnel.sh
@@ -160,6 +160,14 @@ server_listen
 # client can connect again
 ip netns exec "${ns2}" ip link add dev testtun0 type "${tuntype}" \
 	remote "${addr1}" local "${addr2}"
+# Because packets are decapped by the tunnel they arrive on testtun0 from
+# the IP stack perspective.  Ensure reverse path filtering is disabled
+# otherwise we drop the TCP SYN as arriving on testtun0 instead of the
+# expected veth2 (veth2 is where 192.168.1.2 is configured).
+ip netns exec "${ns2}" sysctl -qw net.ipv4.conf.all.rp_filter=0
+# rp needs to be disabled for both all and testtun0 as the rp value is
+# selected as the max of the "all" and device-specific values.
+ip netns exec "${ns2}" sysctl -qw net.ipv4.conf.testtun0.rp_filter=0
 ip netns exec "${ns2}" ip link set dev testtun0 up
 echo "test bpf encap with tunnel device decap"
 client_connect
-- 
1.8.3.1

