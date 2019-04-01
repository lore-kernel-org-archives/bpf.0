Return-Path: <SRS0=vda1=SD=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31E7FC43381
	for <bpf@archiver.kernel.org>; Mon,  1 Apr 2019 15:33:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC77620880
	for <bpf@archiver.kernel.org>; Mon,  1 Apr 2019 15:33:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="wSmOpCzs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726754AbfDAPdI (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 1 Apr 2019 11:33:08 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:42698 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726514AbfDAPdI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 1 Apr 2019 11:33:08 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x31FTxJr043778;
        Mon, 1 Apr 2019 15:32:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2018-07-02;
 bh=hXd3JaN8fpRhH8lDhUnQvf5J1B/FBcY9Z8/cMX6ln8A=;
 b=wSmOpCzsfqYM04mCT2Px9y7bQ5dTU8q+fP+6KsiDhASyHlbNijfVJqPFKp+sNokNbBC9
 qAIll24hFSsPy+Y75qT2lKDBH4JLoB/XWySBf+znNSdmBQ3jzjQT4E2v1BHqE5iIE4Hc
 e4GHlJbooPLjFEveMfag3QN9W53NEYi+K+byFiAyTscACGV5GN3yNUQNS5dfCWzhxuTU
 kWdV388NTujroc4OUXXQ1RyLolu27idbVkZf8vzIKBZsw9U8dhFQL/WrjfcM9g82R+tD
 iCg3mFHfywPobaadblm9VAnEHmP3oMjEInbOQwEI7gv/jdyjlXrw3IcxLljz+bd/DuLc UQ== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by aserp2130.oracle.com with ESMTP id 2rhwycyxxb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 01 Apr 2019 15:32:36 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x31FWaQT015489
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 1 Apr 2019 15:32:36 GMT
Received: from abhmp0022.oracle.com (abhmp0022.oracle.com [141.146.116.28])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x31FWYlU005770;
        Mon, 1 Apr 2019 15:32:34 GMT
Received: from dhcp-10-175-171-252.vpn.oracle.com (/10.175.171.252)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 01 Apr 2019 08:32:34 -0700
From:   Alan Maguire <alan.maguire@oracle.com>
To:     willemb@google.com, ast@kernel.org, daniel@iogearbox.net,
        davem@davemloft.net, shuah@kernel.org, kafai@fb.com,
        songliubraving@fb.com, yhs@fb.com, quentin.monnet@netronome.com,
        john.fastabend@gmail.com, rdna@fb.com,
        linux-kselftest@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Cc:     Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH bpf-next 0/4] L2 encap support for bpf_skb_adjust_room
Date:   Mon,  1 Apr 2019 16:32:07 +0100
Message-Id: <1554132731-3095-1-git-send-email-alan.maguire@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9214 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=4 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=988 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1904010104
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

Patch #4 extends the tests again to support MPLSoverGRE and
MPLSoverUDP encap, along with existing test coverage.

Alan Maguire (4):
  selftests_bpf: extend test_tc_tunnel for UDP encap
  bpf: add layer 2 encap support to bpf_skb_adjust_room
  bpf: sync bpf.h to tools/ for BPF_F_ADJ_ROOM_ENCAP_L2
  selftests_bpf: extend test_tc_tunnel.sh test for L2 encap

 include/uapi/linux/bpf.h                           |   5 +
 net/core/filter.c                                  |  19 +-
 tools/include/uapi/linux/bpf.h                     |   5 +
 tools/testing/selftests/bpf/progs/test_tc_tunnel.c | 281 ++++++++++++++++-----
 tools/testing/selftests/bpf/test_tc_tunnel.sh      | 105 +++++---
 5 files changed, 318 insertions(+), 97 deletions(-)

-- 
1.8.3.1

