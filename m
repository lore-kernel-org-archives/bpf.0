Return-Path: <SRS0=9Oao=SO=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF686C10F0E
	for <bpf@archiver.kernel.org>; Fri, 12 Apr 2019 11:28:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5A492171F
	for <bpf@archiver.kernel.org>; Fri, 12 Apr 2019 11:28:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Rr6yF1pC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726697AbfDLL22 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 12 Apr 2019 07:28:28 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:38376 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726682AbfDLL22 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 12 Apr 2019 07:28:28 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x3CBOO5b053207;
        Fri, 12 Apr 2019 11:28:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2018-07-02;
 bh=RBMO7aRrKZHF30Oq6PAhQrV9e2RFKnQ6x7Wu/3j9WGc=;
 b=Rr6yF1pCv+vFYWgZuqceey9xEa/ObbtZdJsuR2BaXEtKPEQEDZJoAlgOE6neEl8O2/W2
 pvMZtSl/VWtgDMNCKiJ/SwYN/cBCTKDa378fayp97D8LPNlTIe9OVJcZ+pRfCASYYxTo
 NPpCzV2UjzWNgQqL+mvtf+u0h0YAbACLK2Iv1Wj5FY+o4WedCWzdFiyhitnaKyj6lDn1
 ZFCgEPbmfSdZz4Ns/O+RBkhO/xgO8tTSImZPzBhNEedwjssj8q7zYIdo6GrhVddiplfN
 hYHBm+IP6acQw+FeaS+78h+pRqKveonDUCCGvdeiY9ZCPGgAAdy0Gpm4YqV1c+cAp3/C EA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2rpkhtdygn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Apr 2019 11:28:05 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x3CBQkmS083250;
        Fri, 12 Apr 2019 11:28:05 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 2rtqnp1jg7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Apr 2019 11:28:05 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x3CBS34i021197;
        Fri, 12 Apr 2019 11:28:03 GMT
Received: from dhcp-10-175-178-216.vpn.oracle.com (/10.175.178.216)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 12 Apr 2019 04:28:03 -0700
From:   Alan Maguire <alan.maguire@oracle.com>
To:     ast@kernel.org, daniel@iogearbox.net
Cc:     kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        quentin.monnet@netronome.com, john.fastabend@gmail.com,
        rdna@fb.com, netdev@vger.kernel.org, bpf@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH bpf-next] bpf: fix whitespace for ENCAP_L2 defines in bpf.h
Date:   Fri, 12 Apr 2019 12:27:34 +0100
Message-Id: <1555068454-27894-1-git-send-email-alan.maguire@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9224 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=669
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1904120075
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9224 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=697 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1904120075
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

replace tab after #define with space in line with rest of definitions

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 include/uapi/linux/bpf.h       | 6 +++---
 tools/include/uapi/linux/bpf.h | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 2e96d0b..dacf3fc 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -2668,14 +2668,14 @@ enum bpf_func_id {
 /* BPF_FUNC_skb_adjust_room flags. */
 #define BPF_F_ADJ_ROOM_FIXED_GSO	(1ULL << 0)
 
-#define	BPF_ADJ_ROOM_ENCAP_L2_MASK	0xff
-#define	BPF_ADJ_ROOM_ENCAP_L2_SHIFT	56
+#define BPF_ADJ_ROOM_ENCAP_L2_MASK	0xff
+#define BPF_ADJ_ROOM_ENCAP_L2_SHIFT	56
 
 #define BPF_F_ADJ_ROOM_ENCAP_L3_IPV4	(1ULL << 1)
 #define BPF_F_ADJ_ROOM_ENCAP_L3_IPV6	(1ULL << 2)
 #define BPF_F_ADJ_ROOM_ENCAP_L4_GRE	(1ULL << 3)
 #define BPF_F_ADJ_ROOM_ENCAP_L4_UDP	(1ULL << 4)
-#define	BPF_F_ADJ_ROOM_ENCAP_L2(len)	(((__u64)len & \
+#define BPF_F_ADJ_ROOM_ENCAP_L2(len)	(((__u64)len & \
 					  BPF_ADJ_ROOM_ENCAP_L2_MASK) \
 					 << BPF_ADJ_ROOM_ENCAP_L2_SHIFT)
 
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 2e96d0b..dacf3fc 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -2668,14 +2668,14 @@ enum bpf_func_id {
 /* BPF_FUNC_skb_adjust_room flags. */
 #define BPF_F_ADJ_ROOM_FIXED_GSO	(1ULL << 0)
 
-#define	BPF_ADJ_ROOM_ENCAP_L2_MASK	0xff
-#define	BPF_ADJ_ROOM_ENCAP_L2_SHIFT	56
+#define BPF_ADJ_ROOM_ENCAP_L2_MASK	0xff
+#define BPF_ADJ_ROOM_ENCAP_L2_SHIFT	56
 
 #define BPF_F_ADJ_ROOM_ENCAP_L3_IPV4	(1ULL << 1)
 #define BPF_F_ADJ_ROOM_ENCAP_L3_IPV6	(1ULL << 2)
 #define BPF_F_ADJ_ROOM_ENCAP_L4_GRE	(1ULL << 3)
 #define BPF_F_ADJ_ROOM_ENCAP_L4_UDP	(1ULL << 4)
-#define	BPF_F_ADJ_ROOM_ENCAP_L2(len)	(((__u64)len & \
+#define BPF_F_ADJ_ROOM_ENCAP_L2(len)	(((__u64)len & \
 					  BPF_ADJ_ROOM_ENCAP_L2_MASK) \
 					 << BPF_ADJ_ROOM_ENCAP_L2_SHIFT)
 
-- 
1.8.3.1

