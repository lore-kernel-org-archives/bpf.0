Return-Path: <SRS0=xPz+=SK=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B18B6C10F13
	for <bpf@archiver.kernel.org>; Mon,  8 Apr 2019 17:00:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DBC020880
	for <bpf@archiver.kernel.org>; Mon,  8 Apr 2019 17:00:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Wb04rO/s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728442AbfDHRAy (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 8 Apr 2019 13:00:54 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:54486 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727039AbfDHRAy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 8 Apr 2019 13:00:54 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x38GwwZh054207;
        Mon, 8 Apr 2019 17:00:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=CMVrZIfEgjYpyH3gKelr9fgvW/P28wv5eZkKnm8ue2M=;
 b=Wb04rO/ssZFO9eWIGCHYo/vJNO0rYOLsS6MblIHYI8nrqz4dsuUc+bxJ2vzG9lJK/mRk
 +ObQJd7Qm4mDpgoIDAw0AyHRjV1i5rzLU4vp5bcM73qOwL77Oikx+IjfRC4p4hTpEcmJ
 MECzdhytNxj9Uc65qvpKHk/cO45WQ++7i3nKdcfiD8aeeis+PJ7gOMEc5jIhnhH4VWGQ
 WY81vj+lg8kL5a2lQ2C2n6Bzq+zSwsJJEMgAP4vAsHToy/0Av1ISSSDpdAe9Ab1RKYQJ
 WY7XYWUGHI5A2F+qmaH/SuYCwSrwoW4EdWT5pKnOLHmCIbRINFQ6utwJlfXBCVIOD2Tt fw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2130.oracle.com with ESMTP id 2rphme800n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 08 Apr 2019 17:00:26 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x38GwPNa019531;
        Mon, 8 Apr 2019 16:58:25 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 2rph7s46ry-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 08 Apr 2019 16:58:25 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x38GwMwH005735;
        Mon, 8 Apr 2019 16:58:22 GMT
Received: from dhcp-10-175-203-155.vpn.oracle.com (/10.175.203.155)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 08 Apr 2019 09:58:21 -0700
From:   Alan Maguire <alan.maguire@oracle.com>
To:     willemb@google.com, ast@kernel.org, daniel@iogearbox.net,
        davem@davemloft.net, shuah@kernel.org, kafai@fb.com,
        songliubraving@fb.com, yhs@fb.com, quentin.monnet@netronome.com,
        john.fastabend@gmail.com, rdna@fb.com,
        linux-kselftest@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Cc:     Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v2 bpf-next 3/4] bpf: sync bpf.h to tools/ for BPF_F_ADJ_ROOM_ENCAP_L2
Date:   Mon,  8 Apr 2019 17:57:47 +0100
Message-Id: <1554742668-28313-4-git-send-email-alan.maguire@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1554742668-28313-1-git-send-email-alan.maguire@oracle.com>
References: <1554742668-28313-1-git-send-email-alan.maguire@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9221 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1904080137
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9221 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1904080137
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Sync include/uapi/linux/bpf.h with tools/ equivalent to add
BPF_F_ADJ_ROOM_ENCAP_L2(len) macro.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 tools/include/uapi/linux/bpf.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 8370245..912391c 100644
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
@@ -2641,10 +2645,16 @@ enum bpf_func_id {
 /* BPF_FUNC_skb_adjust_room flags. */
 #define BPF_F_ADJ_ROOM_FIXED_GSO	(1ULL << 0)
 
+#define	BPF_ADJ_ROOM_ENCAP_L2_MASK	0xff
+#define	BPF_ADJ_ROOM_ENCAP_L2_SHIFT	56
+
 #define BPF_F_ADJ_ROOM_ENCAP_L3_IPV4	(1ULL << 1)
 #define BPF_F_ADJ_ROOM_ENCAP_L3_IPV6	(1ULL << 2)
 #define BPF_F_ADJ_ROOM_ENCAP_L4_GRE	(1ULL << 3)
 #define BPF_F_ADJ_ROOM_ENCAP_L4_UDP	(1ULL << 4)
+#define	BPF_F_ADJ_ROOM_ENCAP_L2(len)	(((__u64)len & \
+					  BPF_ADJ_ROOM_ENCAP_L2_MASK) \
+					 << BPF_ADJ_ROOM_ENCAP_L2_SHIFT)
 
 /* Mode for BPF_FUNC_skb_adjust_room helper. */
 enum bpf_adj_room_mode {
-- 
1.8.3.1

