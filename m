Return-Path: <SRS0=xPz+=SK=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4A1AC10F14
	for <bpf@archiver.kernel.org>; Mon,  8 Apr 2019 16:58:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B524F20880
	for <bpf@archiver.kernel.org>; Mon,  8 Apr 2019 16:58:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GV0xxfZA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729356AbfDHQ6v (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 8 Apr 2019 12:58:51 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:53114 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729246AbfDHQ6u (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 8 Apr 2019 12:58:50 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x38GnJ8U049226;
        Mon, 8 Apr 2019 16:58:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2018-07-02;
 bh=/W6XDopVPqLlHvDQfOV/bIYHl5Wckpc4KGcPgxu3wxE=;
 b=GV0xxfZAlS1XLH3UVNEimrrU1r9OPLJqnv/ihGXzAitgpKezhhJb6kJCd4qb93TJLBnK
 SacdXGtq7B7DtGSEjbvFNAdWpt2xKHlgVVSZokUDPdUtjxzVoOg7cJ/QMVUCNJ5F3BIp
 phrMmwLhK0FVMLCLfH+yPGrJOkDRfbYAY81AoTs369b3e/N+bi0vwsNhi1p8MUwgbjik
 fLV9xRMlfiYLM4n0IcBLDZQd6X75DYIhiBnSqQhaOotn0cCcbjIcqLrxOw8Hptri4Iwq
 R2O4EcXLpueyIrXTR2lRwMgI3wyqwHTWweVdhoUesLlPJ5aU14NExZuBiow1fZthvo7z OA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2rpmrpyq3g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 08 Apr 2019 16:58:12 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x38GvWtW016530;
        Mon, 8 Apr 2019 16:58:12 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 2rph7s46p8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 08 Apr 2019 16:58:12 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x38Gw9Ss003823;
        Mon, 8 Apr 2019 16:58:09 GMT
Received: from dhcp-10-175-203-155.vpn.oracle.com (/10.175.203.155)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 08 Apr 2019 09:58:09 -0700
From:   Alan Maguire <alan.maguire@oracle.com>
To:     willemb@google.com, ast@kernel.org, daniel@iogearbox.net,
        davem@davemloft.net, shuah@kernel.org, kafai@fb.com,
        songliubraving@fb.com, yhs@fb.com, quentin.monnet@netronome.com,
        john.fastabend@gmail.com, rdna@fb.com,
        linux-kselftest@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Cc:     Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v2 bpf-next 0/4] L2 encap support for bpf_skb_adjust_room
Date:   Mon,  8 Apr 2019 17:57:44 +0100
Message-Id: <1554742668-28313-1-git-send-email-alan.maguire@oracle.com>
X-Mailer: git-send-email 1.8.3.1
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
 - added support for ethernet L2 encap to tests; testing against
   gre[6]tap tunnels (patch 4).

Alan Maguire (4):
  selftests_bpf: add UDP encap to test_tc_tunnel
  bpf: add layer 2 encap support to bpf_skb_adjust_room
  bpf: sync bpf.h to tools/ for BPF_F_ADJ_ROOM_ENCAP_L2
  selftests_bpf: add L2 encap to test_tc_tunnel

 include/uapi/linux/bpf.h                           |  10 +
 net/core/filter.c                                  |  15 +-
 tools/include/uapi/linux/bpf.h                     |  10 +
 tools/testing/selftests/bpf/progs/test_tc_tunnel.c | 335 +++++++++++++++++----
 tools/testing/selftests/bpf/test_tc_tunnel.sh      | 147 +++++++--
 5 files changed, 427 insertions(+), 90 deletions(-)

-- 
1.8.3.1

