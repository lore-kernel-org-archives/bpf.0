Return-Path: <SRS0=nDT5=2E=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F10C6C2D0C9
	for <bpf@archiver.kernel.org>; Sat, 14 Dec 2019 00:47:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDC6B20724
	for <bpf@archiver.kernel.org>; Sat, 14 Dec 2019 00:47:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="jSzlgJvh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726739AbfLNArv (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 13 Dec 2019 19:47:51 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:49022 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726783AbfLNArt (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 13 Dec 2019 19:47:49 -0500
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBE0VQ69013540
        for <bpf@vger.kernel.org>; Fri, 13 Dec 2019 16:47:48 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=r81yLaamRDrJuMG+02OJ+C554sfaS+0BuGA9hnPfmRk=;
 b=jSzlgJvh+mHpa9+isM921aS1EkINNgkH4U2H1279yUq1lsft6cJXz0fJE6t0mfZWMxFn
 G8FmTkJcbbDCx45g58n+uEMIQYx8n3x5ODCFLAuJIoTLKc7TdLDuJAr4KK/gJXqTxQqk
 bYR+smy9B64OWpHGm5iyiqL6p8Bx1TFYXQ4= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2wusrmyedr-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 13 Dec 2019 16:47:48 -0800
Received: from intmgw002.08.frc2.facebook.com (2620:10d:c081:10::13) by
 mail.thefacebook.com (2620:10d:c081:35::130) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5;
 Fri, 13 Dec 2019 16:47:47 -0800
Received: by devbig005.ftw2.facebook.com (Postfix, from userid 6611)
        id 9E4E82943AB4; Fri, 13 Dec 2019 16:47:46 -0800 (PST)
Smtp-Origin-Hostprefix: devbig
From:   Martin KaFai Lau <kafai@fb.com>
Smtp-Origin-Hostname: devbig005.ftw2.facebook.com
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        David Miller <davem@davemloft.net>, <kernel-team@fb.com>,
        <netdev@vger.kernel.org>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH bpf-next 04/13] bpf: Support bitfield read access in btf_struct_access
Date:   Fri, 13 Dec 2019 16:47:46 -0800
Message-ID: <20191214004746.1652586-1-kafai@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191214004737.1652076-1-kafai@fb.com>
References: <20191214004737.1652076-1-kafai@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-13_09:2019-12-13,2019-12-13 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0 mlxscore=0
 lowpriorityscore=0 bulkscore=0 phishscore=0 spamscore=0 priorityscore=1501
 suspectscore=13 impostorscore=0 adultscore=0 mlxlogscore=740 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1910280000
 definitions=main-1912140001
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch allows bitfield access as a scalar.  It currently limits
the access to sizeof(u64) and upto the end of the struct.  It is needed
in a later bpf-tcp-cc example that reads bitfield from
inet_connection_sock and tcp_sock.

Signed-off-by: Martin KaFai Lau <kafai@fb.com>
---
 kernel/bpf/btf.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 6e652643849b..011194831499 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -3744,10 +3744,6 @@ int btf_struct_access(struct bpf_verifier_log *log,
 	}
 
 	for_each_member(i, t, member) {
-		if (btf_member_bitfield_size(t, member))
-			/* bitfields are not supported yet */
-			continue;
-
 		/* offset of the field in bytes */
 		moff = btf_member_bit_offset(t, member) / 8;
 		if (off + size <= moff)
@@ -3757,6 +3753,15 @@ int btf_struct_access(struct bpf_verifier_log *log,
 		if (off < moff)
 			continue;
 
+		if (btf_member_bitfield_size(t, member)) {
+			if (off == moff &&
+			    !(btf_member_bit_offset(t, member) % 8) &&
+			    size <= sizeof(u64) &&
+			    off + size <= t->size)
+				return SCALAR_VALUE;
+			continue;
+		}
+
 		/* type of the field */
 		mtype = btf_type_by_id(btf_vmlinux, member->type);
 		mname = __btf_name_by_offset(btf_vmlinux, member->name_off);
-- 
2.17.1

