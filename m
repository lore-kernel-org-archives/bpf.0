Return-Path: <SRS0=Zphp=SL=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8FE5C282CE
	for <bpf@archiver.kernel.org>; Tue,  9 Apr 2019 14:07:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4158208C0
	for <bpf@archiver.kernel.org>; Tue,  9 Apr 2019 14:07:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="COPaNrB1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbfDIOHp (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 9 Apr 2019 10:07:45 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:58302 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726471AbfDIOHo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 9 Apr 2019 10:07:44 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x39E44GG096207;
        Tue, 9 Apr 2019 14:07:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2018-07-02;
 bh=PyF5OFT61wGb6JVjWXPe0TT6F6dUQhWveFaJZMqjPio=;
 b=COPaNrB1gTy//811jEEDHJ9swv1wnjuMfOdiHODdjzEOddd4tejQWMT3VikSUT6IJBH6
 dWII2O4hIzurlzZAHnfnZyCxLpq57JKulKnDn+To0DWzYHEVlyGf7XkmG8Ks1H6QLoET
 e5KFHWs9cPi9FrcvVdSS2klZa0oGss7aVejm8zd/twpyl033aUGrK4/6CL5s+bEMU6kG
 2CLfzDDAupoiOaOa7rz+WzgcDStcSE3RxJ0gmtJx2A+4c9Kp7/qzCQB4Ayo5piT0bHdN
 q2u6QdkZgGfo5pCqlqs0H9OStsFFvrV5EZTpU2wzYK9v9H2qbjUpAMijQB+OQ8MDL7Zw Tw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2130.oracle.com with ESMTP id 2rphmedd1v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 09 Apr 2019 14:07:08 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x39E5qUq130055;
        Tue, 9 Apr 2019 14:07:07 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 2rpkeja1ey-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 09 Apr 2019 14:07:07 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x39E75vn014785;
        Tue, 9 Apr 2019 14:07:05 GMT
Received: from dhcp-10-175-177-211.vpn.oracle.com (/10.175.177.211)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 09 Apr 2019 07:07:04 -0700
From:   Alan Maguire <alan.maguire@oracle.com>
To:     willemb@google.com, ast@kernel.org, daniel@iogearbox.net,
        davem@davemloft.net, shuah@kernel.org, kafai@fb.com,
        songliubraving@fb.com, yhs@fb.com, quentin.monnet@netronome.com,
        john.fastabend@gmail.com, rdna@fb.com,
        linux-kselftest@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Cc:     Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v3 bpf-next 0/4] L2 encap support for bpf_skb_adjust_room
Date:   Tue,  9 Apr 2019 15:06:39 +0100
Message-Id: <1554818803-4070-1-git-send-email-alan.maguire@oracle.com>
X-Mailer: git-send-email 1.8.3.1
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

Extend bpf_skb_adjust_room growth to mark inner MAC header so that
L2 encapsulation can be used for tc tunnels.

Patch #1 extends the existing test_tc_tunnel to support UDP
encapsulation; later we want to be able to test MPLS over UDP and
MPLS over GRE encapsulation.

Patch #2 adds the BPF_F_ADJ_ROOM_ENCAP_L2(len) macro, which
allows specification of inner mac length.  Other approaches were
explored prior to taking this approach.  Specifically, I tried
automatically computing the inner mac length on the basis of the
specified flags (so inner maclen for GRE/IPv4 encap is the len_diff
specified to bpf_skb_adjust_room minus GRE + IPv4 header length
for example).  Problem with this is that we don't know for sure
what form of GRE/UDP header we have; is it a full GRE header,
or is it a FOU UDP header or generic UDP encap header? My fear
here was we'd end up with an explosion of flags.  The other approach
tried was to support inner L2 header marking as a separate room
adjustment, i.e. adjust for L3/L4 encap, then call
bpf_skb_adjust_room for L2 encap.  This can be made to work but
because it imposed an order on operations, felt a bit clunky.

Patch #3 syncs tools/ bpf.h.

Patch #4 extends the tests again to support MPLSoverGRE,
MPLSoverUDP, and transparent ethernet bridging (TEB) where
the inner L2 header is an ethernet header.  Testing of BPF
encap against tunnels is done for cases where configuration
of such tunnels is possible (MPLSoverGRE[6], MPLSoverUDP,
gre[6]tap), and skipped otherwise.  Testing of BPF encap/decap
is always carried out.

Changes since v2:
 - updated tools/testing/selftest/bpf/config with FOU/MPLS CONFIG 
   variables (patches 1, 4)
 - reduced noise in patch 1 by avoiding unnecessary movement of code
 - eliminated inner_mac variable in bpf_skb_net_grow (patch 2)

Changes since v1:
 - fixed formatting of commit references.
 - BPF_F_ADJ_ROOM_FIXED_GSO flag enabled on all variants (patch 1)
 - fixed fou6 options for UDP encap; checksum errors observed were
   due to the fact fou6 tunnel was not set up with correct ipproto
   options (41 -6).  0 checksums work fine (patch 1)
 - added definitions for mask and shift used in setting L2 length
   (patch 2)
 - allow udp encap with fixed GSO (patch 2)
 - changed "elen" to "l2_len" to be more descriptive (patch 4)


Alan Maguire (4):
  selftests_bpf: extend test_tc_tunnel for UDP encap
  bpf: add layer 2 encap support to bpf_skb_adjust_room
  bpf: sync bpf.h to tools/ for BPF_F_ADJ_ROOM_ENCAP_L2
  selftests_bpf: add L2 encap to test_tc_tunnel

 include/uapi/linux/bpf.h                           |  10 +
 net/core/filter.c                                  |  12 +-
 tools/include/uapi/linux/bpf.h                     |  10 +
 tools/testing/selftests/bpf/config                 |   8 +
 tools/testing/selftests/bpf/progs/test_tc_tunnel.c | 321 +++++++++++++++++----
 tools/testing/selftests/bpf/test_tc_tunnel.sh      | 136 +++++++--
 6 files changed, 417 insertions(+), 80 deletions(-)

-- 
1.8.3.1

