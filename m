Return-Path: <SRS0=Cb5B=BC=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E4E1C433EA
	for <bpf@archiver.kernel.org>; Thu, 23 Jul 2020 01:04:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E38DE2086A
	for <bpf@archiver.kernel.org>; Thu, 23 Jul 2020 01:04:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="WJ/jyijC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387509AbgGWBEK (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 22 Jul 2020 21:04:10 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:40680 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387482AbgGWBEJ (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 22 Jul 2020 21:04:09 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06N11GmJ024918
        for <bpf@vger.kernel.org>; Wed, 22 Jul 2020 18:04:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=gLZhrnpgSp/OQsN8K77cACh0WztsxbYp4YUQdub05fk=;
 b=WJ/jyijC/DZnrK7Uo8C2bXAZkfZ/6GA1dgiJdu84H4fsAqm4IU4bT2syvX9njx49U7qM
 Ak2yCZk7vmTcrSWuwLdAmpjf924Au84QbAFhMcDbdA5HDGbWvcKGAh2qKB8ByeQ24DR0
 vLcCPDi2PizOb9lAsd1mlVwsJ6pL/l04TtQ= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 32etg39s3y-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 22 Jul 2020 18:04:09 -0700
Received: from intmgw002.03.ash8.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:21d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 22 Jul 2020 18:04:08 -0700
Received: by devbig005.ftw2.facebook.com (Postfix, from userid 6611)
        id F181C2945AD1; Wed, 22 Jul 2020 18:04:05 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Martin KaFai Lau <kafai@fb.com>
Smtp-Origin-Hostname: devbig005.ftw2.facebook.com
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Eric Dumazet <edumazet@google.com>, <kernel-team@fb.com>,
        Lawrence Brakmo <brakmo@fb.com>,
        Neal Cardwell <ncardwell@google.com>, <netdev@vger.kernel.org>,
        Yuchung Cheng <ycheng@google.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH v2 bpf-next 5/9] bpf: sock_ops: Change some members of sock_ops_kern from u32 to u8
Date:   Wed, 22 Jul 2020 18:04:05 -0700
Message-ID: <20200723010405.1907980-1-kafai@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200723010334.1905574-1-kafai@fb.com>
References: <20200723010334.1905574-1-kafai@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-22_17:2020-07-22,2020-07-22 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 spamscore=0
 malwarescore=0 suspectscore=13 bulkscore=0 mlxlogscore=718
 priorityscore=1501 phishscore=0 lowpriorityscore=0 impostorscore=0
 mlxscore=0 adultscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2007230005
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

A latter patch needs to add a few pointers and a few u8 to
sock_ops_kern.  Hence, this patch saves some spaces by moving
some of the existing members from u32 to u8 so that the latter
patch can still fit everything in a cacheline.

Signed-off-by: Martin KaFai Lau <kafai@fb.com>
---
 include/linux/filter.h |  4 ++--
 net/core/filter.c      | 15 ++++++++++-----
 2 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/include/linux/filter.h b/include/linux/filter.h
index 1c6b6d982bf4..4e3a62a8bdd2 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -1234,13 +1234,13 @@ struct bpf_sock_addr_kern {
=20
 struct bpf_sock_ops_kern {
 	struct	sock *sk;
-	u32	op;
 	union {
 		u32 args[4];
 		u32 reply;
 		u32 replylong[4];
 	};
-	u32	is_fullsock;
+	u8	op;
+	u8	is_fullsock;
 	u64	temp;			/* temp and everything after is not
 					 * initialized to 0 before calling
 					 * the BPF program. New fields that
diff --git a/net/core/filter.c b/net/core/filter.c
index 04266a21229f..cb674f7eae64 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -8403,17 +8403,22 @@ static u32 sock_ops_convert_ctx_access(enum bpf_a=
ccess_type type,
 		return insn - insn_buf;
=20
 	switch (si->off) {
-	case offsetof(struct bpf_sock_ops, op) ...
+	case offsetof(struct bpf_sock_ops, op):
+		*insn++ =3D BPF_LDX_MEM(BPF_FIELD_SIZEOF(struct bpf_sock_ops_kern,
+						       op),
+				      si->dst_reg, si->src_reg,
+				      offsetof(struct bpf_sock_ops_kern, op));
+		break;
+
+	case offsetof(struct bpf_sock_ops, replylong[0]) ...
 	     offsetof(struct bpf_sock_ops, replylong[3]):
-		BUILD_BUG_ON(sizeof_field(struct bpf_sock_ops, op) !=3D
-			     sizeof_field(struct bpf_sock_ops_kern, op));
 		BUILD_BUG_ON(sizeof_field(struct bpf_sock_ops, reply) !=3D
 			     sizeof_field(struct bpf_sock_ops_kern, reply));
 		BUILD_BUG_ON(sizeof_field(struct bpf_sock_ops, replylong) !=3D
 			     sizeof_field(struct bpf_sock_ops_kern, replylong));
 		off =3D si->off;
-		off -=3D offsetof(struct bpf_sock_ops, op);
-		off +=3D offsetof(struct bpf_sock_ops_kern, op);
+		off -=3D offsetof(struct bpf_sock_ops, replylong[0]);
+		off +=3D offsetof(struct bpf_sock_ops_kern, replylong[0]);
 		if (type =3D=3D BPF_WRITE)
 			*insn++ =3D BPF_STX_MEM(BPF_W, si->dst_reg, si->src_reg,
 					      off);
--=20
2.24.1

