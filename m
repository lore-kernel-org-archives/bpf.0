Return-Path: <SRS0=vda1=SD=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E93CC43381
	for <bpf@archiver.kernel.org>; Mon,  1 Apr 2019 15:33:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C64BA20880
	for <bpf@archiver.kernel.org>; Mon,  1 Apr 2019 15:33:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Iih+d0T1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726754AbfDAPdY (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 1 Apr 2019 11:33:24 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:60102 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726514AbfDAPdY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 1 Apr 2019 11:33:24 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x31FTDWI040074;
        Mon, 1 Apr 2019 15:33:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=LV/VZ3XE0s/Oa+dHeYlxpbqvz0uWIzIQQtoD2TA66BY=;
 b=Iih+d0T1U0d0+yq2RJ7HB14HAgj6s+ESbybnsCEY/jfcidWIp9O+SOG5z6KzKaxY90Bs
 VWjXoXE3J2RvMalS/W7SVMcEANlWgTUB09g+zxPbKKuIxk8sydQnyyVv3U142o0A81/5
 racelpu2ghKcz8HSMnhtqkGioq7tL4YfaKirnxNLIvpbtQYs8fv0W9P3RP15+3Lxt6bV
 XH7nHcJ/RuhLA2j3m9GZm3/IbqP4Xp/LoQfe/X38MdRaAU+GclB0AoWi1QI/p4irC04C
 uG/tXgNq/H/+uFQ7MVmoLJoUUoZRc1OPgTOcs5OLYAJewXv89YPlfQRcUK2HeIGbs35K dg== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2130.oracle.com with ESMTP id 2rhyvsyu2f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 01 Apr 2019 15:33:00 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x31FWx3e016374
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 1 Apr 2019 15:32:59 GMT
Received: from abhmp0022.oracle.com (abhmp0022.oracle.com [141.146.116.28])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x31FWxfw006051;
        Mon, 1 Apr 2019 15:32:59 GMT
Received: from dhcp-10-175-171-252.vpn.oracle.com (/10.175.171.252)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 01 Apr 2019 08:32:59 -0700
From:   Alan Maguire <alan.maguire@oracle.com>
To:     willemb@google.com, ast@kernel.org, daniel@iogearbox.net,
        davem@davemloft.net, shuah@kernel.org, kafai@fb.com,
        songliubraving@fb.com, yhs@fb.com, quentin.monnet@netronome.com,
        john.fastabend@gmail.com, rdna@fb.com,
        linux-kselftest@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Cc:     Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH bpf-next 3/4] bpf: sync bpf.h to tools/ for BPF_F_ADJ_ROOM_ENCAP_L2
Date:   Mon,  1 Apr 2019 16:32:10 +0100
Message-Id: <1554132731-3095-4-git-send-email-alan.maguire@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1554132731-3095-1-git-send-email-alan.maguire@oracle.com>
References: <1554132731-3095-1-git-send-email-alan.maguire@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9214 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=975 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1904010104
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Sync include/uapi/linux/bpf.h with tools/ equivalent to add
BPF_F_ADJ_ROOM_ENCAP_L2(len) macro.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 tools/include/uapi/linux/bpf.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 8370245..6d8346a 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -1500,6 +1500,10 @@ struct bpf_stack_build_id {
  *		* **BPF_F_ADJ_ROOM_ENCAP_L4_UDP **:
  *		  Use with ENCAP_L3 flags to further specify the tunnel type.
  *
+ *		* **BPF_F_ADJ_ROOM_ENCAP_L2(len) **:
+ *		  Use with ENCAP_L3/L4 flags to further specify the tunnel
+ *		  type; **len** is the length of the inner MAC header.
+ *
  * 		A call to this helper is susceptible to change the underlaying
  * 		packet buffer. Therefore, at load time, all checks on pointers
  * 		previously done by the verifier are invalidated and must be
@@ -2645,6 +2649,7 @@ enum bpf_func_id {
 #define BPF_F_ADJ_ROOM_ENCAP_L3_IPV6	(1ULL << 2)
 #define BPF_F_ADJ_ROOM_ENCAP_L4_GRE	(1ULL << 3)
 #define BPF_F_ADJ_ROOM_ENCAP_L4_UDP	(1ULL << 4)
+#define	BPF_F_ADJ_ROOM_ENCAP_L2(len)	(((__u64)len & 0xff) << 56)
 
 /* Mode for BPF_FUNC_skb_adjust_room helper. */
 enum bpf_adj_room_mode {
-- 
1.8.3.1

