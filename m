Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 599AAC433EF
	for <bpf@archiver.kernel.org>; Fri, 17 Sep 2021 18:29:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4330661246
	for <bpf@archiver.kernel.org>; Fri, 17 Sep 2021 18:29:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242091AbhIQSbU (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 17 Sep 2021 14:31:20 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:23932 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242007AbhIQSbU (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 17 Sep 2021 14:31:20 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18HDlhrV018172
        for <bpf@vger.kernel.org>; Fri, 17 Sep 2021 11:29:58 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=/wV+DjX/3L0XlimD2FuWpOPj66stYlhj2Zuka6Vrw/E=;
 b=ebgKQdoeVqOL0VxPNQRvcPOruS37x1BCFhUIQzItOroq5SyAO+ml/p7TKUsJ67NQxsDS
 T5DJq29Fg5GG2hASdu+okxO01EoT8B804y/r/pPPy6kl7sPtzYmdAF9kBbFPENgSZ3Z8
 mALAtePaQB6MTEqwo8YpBE6upB6mGcxXfFA= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3b4v76hxwf-20
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 17 Sep 2021 11:29:58 -0700
Received: from intmgw001.38.frc1.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:21d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Fri, 17 Sep 2021 11:29:44 -0700
Received: by devbig030.frc3.facebook.com (Postfix, from userid 158236)
        id 18C146BF31DC; Fri, 17 Sep 2021 11:29:18 -0700 (PDT)
From:   Dave Marchevsky <davemarchevsky@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Yonghong Song <yhs@fb.com>, <netdev@vger.kernel.org>,
        Dave Marchevsky <davemarchevsky@fb.com>
Subject: [PATCH v6 bpf-next 5/9] libbpf: use static const fmt string in __bpf_printk
Date:   Fri, 17 Sep 2021 11:29:07 -0700
Message-ID: <20210917182911.2426606-6-davemarchevsky@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210917182911.2426606-1-davemarchevsky@fb.com>
References: <20210917182911.2426606-1-davemarchevsky@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-ORIG-GUID: eSKVmB-1jHr7yn-3bFFuHW-sRUa7DXit
X-Proofpoint-GUID: eSKVmB-1jHr7yn-3bFFuHW-sRUa7DXit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-17_07,2021-09-17_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 bulkscore=0 phishscore=0 mlxscore=0 clxscore=1015 impostorscore=0
 suspectscore=0 spamscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 mlxlogscore=909 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109170110
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The __bpf_printk convenience macro was using a 'char' fmt string holder
as it predates support for globals in libbpf. Move to more efficient
'static const char', but provide a fallback to the old way via
BPF_NO_GLOBAL_DATA so users on old kernels can still use the macro.

Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/bpf_helpers.h | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/bpf_helpers.h b/tools/lib/bpf/bpf_helpers.h
index 55a308796625..963b1060d944 100644
--- a/tools/lib/bpf/bpf_helpers.h
+++ b/tools/lib/bpf/bpf_helpers.h
@@ -216,9 +216,15 @@ enum libbpf_tristate {
 		     ___param, sizeof(___param));		\
 })
=20
+#ifdef BPF_NO_GLOBAL_DATA
+#define BPF_PRINTK_FMT_MOD
+#else
+#define BPF_PRINTK_FMT_MOD static const
+#endif
+
 #define __bpf_printk(fmt, ...)				\
 ({							\
-	char ____fmt[] =3D fmt;				\
+	BPF_PRINTK_FMT_MOD char ____fmt[] =3D fmt;	\
 	bpf_trace_printk(____fmt, sizeof(____fmt),	\
 			 ##__VA_ARGS__);		\
 })
--=20
2.30.2

