Return-Path: <SRS0=Zphp=SL=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8898C10F0E
	for <bpf@archiver.kernel.org>; Tue,  9 Apr 2019 14:07:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EAFC2084F
	for <bpf@archiver.kernel.org>; Tue,  9 Apr 2019 14:07:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XFk/dTPg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726579AbfDIOHp (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 9 Apr 2019 10:07:45 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:35928 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726548AbfDIOHp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 9 Apr 2019 10:07:45 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x39E3sxx093236;
        Tue, 9 Apr 2019 14:07:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=e15YGGs7+WtKKzobY8IwNrGoCrUpOySpjcbKi/1SAvk=;
 b=XFk/dTPgAK4JMa+gquLCH9/jsvSubvMsJg/su53ItARodJ3U/MpzJ+OhUvtyEAkN1qri
 9KztZCwT2Q153QpYeq0CBVUj+NLlyvuBR8d+ueNgFQFJRQefQqd9U4VZ9KkJlnPYNcwe
 x/hhKr7ZttGriCzMqKlDz0SGjOUYMsFfCIccEVOpHN0vufRG1JLuE0dTiAuWgkwudBEN
 SMTnf6914uvYx9IIHKeWSlhlOF4ELEvyjtyBVraFlQWaTH9CRedrb0ioiMEaj3HUDSr1
 kUazfTUpmTRt2dY9/OcLBayMDY+wh5C2smG7bcdGBwQ3iluXoM5Cw7NMmWFTvS4cKrJy 5A== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 2rpkhsw9e0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 09 Apr 2019 14:07:15 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x39E5btF185025;
        Tue, 9 Apr 2019 14:07:14 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 2rpytbmmq2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 09 Apr 2019 14:07:14 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x39E7Cuj014866;
        Tue, 9 Apr 2019 14:07:13 GMT
Received: from dhcp-10-175-177-211.vpn.oracle.com (/10.175.177.211)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 09 Apr 2019 07:07:12 -0700
From:   Alan Maguire <alan.maguire@oracle.com>
To:     willemb@google.com, ast@kernel.org, daniel@iogearbox.net,
        davem@davemloft.net, shuah@kernel.org, kafai@fb.com,
        songliubraving@fb.com, yhs@fb.com, quentin.monnet@netronome.com,
        john.fastabend@gmail.com, rdna@fb.com,
        linux-kselftest@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Cc:     Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v3 bpf-next 2/4] bpf: add layer 2 encap support to bpf_skb_adjust_room
Date:   Tue,  9 Apr 2019 15:06:41 +0100
Message-Id: <1554818803-4070-3-git-send-email-alan.maguire@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1554818803-4070-1-git-send-email-alan.maguire@oracle.com>
References: <1554818803-4070-1-git-send-email-alan.maguire@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9221 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1904090090
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9221 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1904090090
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

commit 868d523535c2 ("bpf: add bpf_skb_adjust_room encap flags")
introduced support to bpf_skb_adjust_room for GSO-friendly GRE
and UDP encapsulation.

For GSO to work for skbs, the inner headers (mac and network) need to
be marked.  For L3 encapsulation using bpf_skb_adjust_room, the mac
and network headers are identical.  Here we provide a way of specifying
the inner mac header length for cases where L2 encap is desired.  Such
an approach can support encapsulated ethernet headers, MPLS headers etc.
For example to convert from a packet of form [eth][ip][tcp] to
[eth][ip][udp][inner mac][ip][tcp], something like the following could
be done:

	headroom = sizeof(iph) + sizeof(struct udphdr) + inner_maclen;

	ret = bpf_skb_adjust_room(skb, headroom, BPF_ADJ_ROOM_MAC,
				  BPF_F_ADJ_ROOM_ENCAP_L4_UDP |
				  BPF_F_ADJ_ROOM_ENCAP_L3_IPV4 |
				  BPF_F_ADJ_ROOM_ENCAP_L2(inner_maclen));

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 include/uapi/linux/bpf.h | 10 ++++++++++
 net/core/filter.c        | 12 ++++++++----
 2 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 8370245..912391c 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
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
diff --git a/net/core/filter.c b/net/core/filter.c
index 22eb2ed..a1654ef62 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -2969,11 +2969,14 @@ static u32 bpf_skb_net_base_len(const struct sk_buff *skb)
 #define BPF_F_ADJ_ROOM_MASK		(BPF_F_ADJ_ROOM_FIXED_GSO | \
 					 BPF_F_ADJ_ROOM_ENCAP_L3_MASK | \
 					 BPF_F_ADJ_ROOM_ENCAP_L4_GRE | \
-					 BPF_F_ADJ_ROOM_ENCAP_L4_UDP)
+					 BPF_F_ADJ_ROOM_ENCAP_L4_UDP | \
+					 BPF_F_ADJ_ROOM_ENCAP_L2( \
+					  BPF_ADJ_ROOM_ENCAP_L2_MASK))
 
 static int bpf_skb_net_grow(struct sk_buff *skb, u32 off, u32 len_diff,
 			    u64 flags)
 {
+	u8 inner_mac_len = flags >> BPF_ADJ_ROOM_ENCAP_L2_SHIFT;
 	bool encap = flags & BPF_F_ADJ_ROOM_ENCAP_L3_MASK;
 	u16 mac_len = 0, inner_net = 0, inner_trans = 0;
 	unsigned int gso_type = SKB_GSO_DODGY;
@@ -3008,6 +3011,8 @@ static int bpf_skb_net_grow(struct sk_buff *skb, u32 off, u32 len_diff,
 
 		mac_len = skb->network_header - skb->mac_header;
 		inner_net = skb->network_header;
+		if (inner_mac_len > len_diff)
+			return -EINVAL;
 		inner_trans = skb->transport_header;
 	}
 
@@ -3016,8 +3021,7 @@ static int bpf_skb_net_grow(struct sk_buff *skb, u32 off, u32 len_diff,
 		return ret;
 
 	if (encap) {
-		/* inner mac == inner_net on l3 encap */
-		skb->inner_mac_header = inner_net;
+		skb->inner_mac_header = inner_net - inner_mac_len;
 		skb->inner_network_header = inner_net;
 		skb->inner_transport_header = inner_trans;
 		skb_set_inner_protocol(skb, skb->protocol);
@@ -3031,7 +3035,7 @@ static int bpf_skb_net_grow(struct sk_buff *skb, u32 off, u32 len_diff,
 			gso_type |= SKB_GSO_GRE;
 		else if (flags & BPF_F_ADJ_ROOM_ENCAP_L3_IPV6)
 			gso_type |= SKB_GSO_IPXIP6;
-		else
+		else if (flags & BPF_F_ADJ_ROOM_ENCAP_L3_IPV4)
 			gso_type |= SKB_GSO_IPXIP4;
 
 		if (flags & BPF_F_ADJ_ROOM_ENCAP_L4_GRE ||
-- 
1.8.3.1

