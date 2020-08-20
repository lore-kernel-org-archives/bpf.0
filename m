Return-Path: <SRS0=CWvS=B6=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09E79C433E3
	for <bpf@archiver.kernel.org>; Thu, 20 Aug 2020 23:13:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF061207DE
	for <bpf@archiver.kernel.org>; Thu, 20 Aug 2020 23:13:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="aHmQRIX4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728661AbgHTXNI (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 20 Aug 2020 19:13:08 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:57846 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728698AbgHTXNF (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 20 Aug 2020 19:13:05 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07KNAHGh013508
        for <bpf@vger.kernel.org>; Thu, 20 Aug 2020 16:13:04 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=NU91f1yJ+h2tEeDu40fhk0yytfxykqQh7ERls/mXCCE=;
 b=aHmQRIX4BeoYXpZ/kcBLbZdAWjMg8dDLGGcVia3xNNFOrR4VRuTO8IsCCndjEBZ7MRoe
 n7O5qTDL5eALkQbHKrAWU+xfq8Y75JAFvoPVgDGLTkPQQGaiWHfrgk+z/KyZxT5dYkPE
 PpJ3fX4J5Dr8ddrcbI6iOPlBaoNeSpPwO+Y= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3304ny18as-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 20 Aug 2020 16:13:04 -0700
Received: from intmgw004.08.frc2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::e) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 20 Aug 2020 16:13:03 -0700
Received: by devbig012.ftw2.facebook.com (Postfix, from userid 137359)
        id 9E2FB2EC5F42; Thu, 20 Aug 2020 16:12:58 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Hostname: devbig012.ftw2.facebook.com
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>, <ast@fb.com>,
        <daniel@iogearbox.net>
CC:     <andrii.nakryiko@gmail.com>, <kernel-team@fb.com>,
        Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH bpf-next 03/16] libbpf: add __noinline macro to bpf_helpers.h
Date:   Thu, 20 Aug 2020 16:12:37 -0700
Message-ID: <20200820231250.1293069-4-andriin@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200820231250.1293069-1-andriin@fb.com>
References: <20200820231250.1293069-1-andriin@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-20_07:2020-08-19,2020-08-20 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 adultscore=0
 impostorscore=0 spamscore=0 bulkscore=0 mlxlogscore=731 clxscore=1015
 priorityscore=1501 malwarescore=0 lowpriorityscore=0 suspectscore=8
 mlxscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008200189
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

__noinline is pretty frequently used, especially with BPF subprograms, so=
 add
them along the __always_inline, for user convenience and completeness.

Signed-off-by: Andrii Nakryiko <andriin@fb.com>
---
 tools/lib/bpf/bpf_helpers.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/lib/bpf/bpf_helpers.h b/tools/lib/bpf/bpf_helpers.h
index e9a4ecddb7a5..1106777df00b 100644
--- a/tools/lib/bpf/bpf_helpers.h
+++ b/tools/lib/bpf/bpf_helpers.h
@@ -32,6 +32,9 @@
 #ifndef __always_inline
 #define __always_inline __attribute__((always_inline))
 #endif
+#ifndef __noinline
+#define __noinline __attribute__((noinline))
+#endif
 #ifndef __weak
 #define __weak __attribute__((weak))
 #endif
--=20
2.24.1

