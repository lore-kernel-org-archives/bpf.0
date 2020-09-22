Return-Path: <SRS0=pAHC=C7=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3A32C4727F
	for <bpf@archiver.kernel.org>; Tue, 22 Sep 2020 07:39:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7FF5F23A9F
	for <bpf@archiver.kernel.org>; Tue, 22 Sep 2020 07:39:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="T20dFoM2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729762AbgIVHjT (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 22 Sep 2020 03:39:19 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:28944 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729875AbgIVHjS (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 22 Sep 2020 03:39:18 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08M6xOlA024968
        for <bpf@vger.kernel.org>; Tue, 22 Sep 2020 00:04:45 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=JQs4yCBmwrBRj2O+cC9AypDTZzdopaOsaNpSJObeoQU=;
 b=T20dFoM2MXNFdebiJwkZ6sGXGQLkBbvy7slHGX2VrDv25RyAM8vhVlFhsHakqbVKyzZU
 Yrcutg0175NDNIWkamV4sz5Z3EaPymERhM0g6hXE2A9b+HijvNNBqa2qiltDz+IeCcUu
 3VyjRAEhoJvin1Fb2ROWgqs89AcbClxaxX8= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 33nftgv5da-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 22 Sep 2020 00:04:45 -0700
Received: from intmgw004.08.frc2.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:21d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 22 Sep 2020 00:04:44 -0700
Received: by devbig005.ftw2.facebook.com (Postfix, from userid 6611)
        id D202B294641C; Tue, 22 Sep 2020 00:04:40 -0700 (PDT)
From:   Martin KaFai Lau <kafai@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>,
        Lorenz Bauer <lmb@cloudflare.com>, <netdev@vger.kernel.org>
Subject: [PATCH v3 bpf-next 05/11] bpf: Change bpf_tcp_*_syncookie to accept ARG_PTR_TO_BTF_ID_SOCK_COMMON
Date:   Tue, 22 Sep 2020 00:04:40 -0700
Message-ID: <20200922070440.1920065-1-kafai@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200922070409.1914988-1-kafai@fb.com>
References: <20200922070409.1914988-1-kafai@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-22_05:2020-09-21,2020-09-22 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0 spamscore=0
 impostorscore=0 mlxscore=0 adultscore=0 malwarescore=0 priorityscore=1501
 suspectscore=13 lowpriorityscore=0 mlxlogscore=977 bulkscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009220056
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch changes the bpf_tcp_*_syncookie() to take
ARG_PTR_TO_BTF_ID_SOCK_COMMON such that they will work with the pointer
returned by the bpf_skc_to_*() helpers also.

Signed-off-by: Martin KaFai Lau <kafai@fb.com>
---
 net/core/filter.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index 532a85894ce0..6ab12d8cdd85 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -6088,7 +6088,7 @@ BPF_CALL_5(bpf_tcp_check_syncookie, struct sock *, =
sk, void *, iph, u32, iph_len
 	u32 cookie;
 	int ret;
=20
-	if (unlikely(th_len < sizeof(*th)))
+	if (unlikely(!sk || th_len < sizeof(*th)))
 		return -EINVAL;
=20
 	/* sk_listener() allows TCP_NEW_SYN_RECV, which makes no sense here. */
@@ -6141,7 +6141,8 @@ static const struct bpf_func_proto bpf_tcp_check_sy=
ncookie_proto =3D {
 	.gpl_only	=3D true,
 	.pkt_access	=3D true,
 	.ret_type	=3D RET_INTEGER,
-	.arg1_type	=3D ARG_PTR_TO_SOCK_COMMON,
+	.arg1_type	=3D ARG_PTR_TO_BTF_ID_SOCK_COMMON,
+	.arg1_btf_id	=3D &btf_sock_ids[BTF_SOCK_TYPE_SOCK_COMMON],
 	.arg2_type	=3D ARG_PTR_TO_MEM,
 	.arg3_type	=3D ARG_CONST_SIZE,
 	.arg4_type	=3D ARG_PTR_TO_MEM,
@@ -6155,7 +6156,7 @@ BPF_CALL_5(bpf_tcp_gen_syncookie, struct sock *, sk=
, void *, iph, u32, iph_len,
 	u32 cookie;
 	u16 mss;
=20
-	if (unlikely(th_len < sizeof(*th) || th_len !=3D th->doff * 4))
+	if (unlikely(!sk || th_len < sizeof(*th) || th_len !=3D th->doff * 4))
 		return -EINVAL;
=20
 	if (sk->sk_protocol !=3D IPPROTO_TCP || sk->sk_state !=3D TCP_LISTEN)
@@ -6210,7 +6211,8 @@ static const struct bpf_func_proto bpf_tcp_gen_sync=
ookie_proto =3D {
 	.gpl_only	=3D true, /* __cookie_v*_init_sequence() is GPL */
 	.pkt_access	=3D true,
 	.ret_type	=3D RET_INTEGER,
-	.arg1_type	=3D ARG_PTR_TO_SOCK_COMMON,
+	.arg1_type	=3D ARG_PTR_TO_BTF_ID_SOCK_COMMON,
+	.arg1_btf_id	=3D &btf_sock_ids[BTF_SOCK_TYPE_SOCK_COMMON],
 	.arg2_type	=3D ARG_PTR_TO_MEM,
 	.arg3_type	=3D ARG_CONST_SIZE,
 	.arg4_type	=3D ARG_PTR_TO_MEM,
--=20
2.24.1

