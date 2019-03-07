Return-Path: <SRS0=xp9Q=RK=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DD88C43381
	for <bpf@archiver.kernel.org>; Thu,  7 Mar 2019 00:14:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2650320842
	for <bpf@archiver.kernel.org>; Thu,  7 Mar 2019 00:14:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="qrt8vfwF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726076AbfCGAOP (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 6 Mar 2019 19:14:15 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:39598 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725790AbfCGAOO (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 6 Mar 2019 19:14:14 -0500
Received: from pps.filterd (m0044008.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2704fB5025921
        for <bpf@vger.kernel.org>; Wed, 6 Mar 2019 16:14:14 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=facebook;
 bh=Bnx1Bq1I9J9Zb41VgzpXMf22GhDET/gjGdvmYIidzeM=;
 b=qrt8vfwFa7AvApQy7ZFRgW4eiubP6HxRCj4VMjTGGua8DO2lB9ErSw/l7MV3Jj3yl4cn
 Z4bFDI0e1IdZVjlglGKXx58P53i6pxW7JsLMZJXZnemTusJaqorFkcfYZ0ZUE008PQmM
 JKSoyBwYiPTk2X2gybdyKkOGxU1SY9taC+k= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2r2nps0kxg-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 06 Mar 2019 16:14:14 -0800
Received: from mx-out.facebook.com (2620:10d:c0a1:3::13) by
 mail.thefacebook.com (2620:10d:c021:18::175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5;
 Wed, 6 Mar 2019 16:14:12 -0800
Received: by dev101.prn2.facebook.com (Postfix, from userid 137359)
        id 91EBF8614CE; Wed,  6 Mar 2019 16:14:11 -0800 (PST)
Smtp-Origin-Hostprefix: dev
From:   Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Hostname: dev101.prn2.facebook.com
To:     <acme@kernel.org>, <arnaldo.melo@gmail.com>,
        <andrii.nakryiko@gmail.com>, <ast@fb.com>, <yhs@fb.com>,
        <dwarves@vger.kernel.org>, <bpf@vger.kernel.org>
CC:     Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Cluster: prn2c23
Subject: [PATCH v2 pahole] libbpf: update reference to bring in btf_dedup fixes
Date:   Wed, 6 Mar 2019 16:14:08 -0800
Message-ID: <20190307001408.4041372-1-andriin@fb.com>
X-Mailer: git-send-email 2.17.1
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-06_16:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Latest version of libbpf has btf_dedup() fixes preventing it from stucking
in a loop on allyesconfig kernels.

v1->v2: 
- use git reference from github.com/libbpf/libbpf instead of personal fork

Signed-off-by: Andrii Nakryiko <andriin@fb.com>
---
 lib/bpf | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bpf b/lib/bpf
index d5fa415..cb658e9 160000
--- a/lib/bpf
+++ b/lib/bpf
@@ -1 +1 @@
-Subproject commit d5fa4150f0c3a36e3ce458e1301531bd2edbf74d
+Subproject commit cb658e9724e3c34973eee913b1ff0cb9c50b8e53
-- 
2.17.1

