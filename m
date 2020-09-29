Return-Path: <SRS0=PNb+=DG=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0B2AC4727C
	for <bpf@archiver.kernel.org>; Tue, 29 Sep 2020 22:15:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3EEF82083B
	for <bpf@archiver.kernel.org>; Tue, 29 Sep 2020 22:15:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="IWob2zHR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728655AbgI2WPe (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 29 Sep 2020 18:15:34 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:20466 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728529AbgI2WPc (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 29 Sep 2020 18:15:32 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08TMCDnH032410
        for <bpf@vger.kernel.org>; Tue, 29 Sep 2020 15:15:32 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=yTcvx7tygR7XtF0P0RwIc69L+jfYmUzkPcomTnhRn/I=;
 b=IWob2zHR8Gs1WfPKtzsH45cwzN5zSRya7//bfygSizjT2rRFNcFEz57J2IAy0+kEkREl
 FON824SIiDx4dUiYp2InaDNipQIwpSU/q5svkWBrjHPLSlCb8n3hGsO12zlpnZAXcSij
 gS23ZONi7A5ZUIZCg2MqZuRS9FNLIZ+/9xc= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 33v6v42cq0-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 29 Sep 2020 15:15:32 -0700
Received: from intmgw002.03.ash8.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 29 Sep 2020 15:15:29 -0700
Received: by devbig012.ftw2.facebook.com (Postfix, from userid 137359)
        id B4BED2EC77D4; Tue, 29 Sep 2020 15:15:25 -0700 (PDT)
From:   Andrii Nakryiko <andriin@fb.com>
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>, <ast@fb.com>,
        <daniel@iogearbox.net>
CC:     <andrii.nakryiko@gmail.com>, <kernel-team@fb.com>,
        Andrii Nakryiko <andriin@fb.com>
Subject: [PATCH bpf-next 2/3] libbpf: compile libbpf under -O2 level by default and catch extra warnings
Date:   Tue, 29 Sep 2020 15:06:03 -0700
Message-ID: <20200929220604.833631-2-andriin@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200929220604.833631-1-andriin@fb.com>
References: <20200929220604.833631-1-andriin@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-29_14:2020-09-29,2020-09-29 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 adultscore=0
 malwarescore=0 mlxscore=0 impostorscore=0 spamscore=0 bulkscore=0
 clxscore=1015 lowpriorityscore=0 mlxlogscore=697 phishscore=0
 suspectscore=8 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2009290191
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

For some reason compiler doesn't complain about uninitialized variable, f=
ixed
in previous patch, if libbpf is compiled without -O2 optimization level. =
So do
compile it with -O2 and never let similar issue slip by again. -Wall is a=
dded
unconditionally, so no need to specify it again.

Signed-off-by: Andrii Nakryiko <andriin@fb.com>
---
 tools/lib/bpf/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/bpf/Makefile b/tools/lib/bpf/Makefile
index f43249696d9f..70cb44efe8cb 100644
--- a/tools/lib/bpf/Makefile
+++ b/tools/lib/bpf/Makefile
@@ -98,7 +98,7 @@ PC_FILE		=3D libbpf.pc
 ifdef EXTRA_CFLAGS
   CFLAGS :=3D $(EXTRA_CFLAGS)
 else
-  CFLAGS :=3D -g -Wall
+  CFLAGS :=3D -g -O2
 endif
=20
 # Append required CFLAGS
--=20
2.24.1

