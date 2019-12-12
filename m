Return-Path: <SRS0=rg0W=2C=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70339C43603
	for <bpf@archiver.kernel.org>; Thu, 12 Dec 2019 23:31:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40AA2214AF
	for <bpf@archiver.kernel.org>; Thu, 12 Dec 2019 23:31:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="PXXS8JDI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730868AbfLLXbR (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 12 Dec 2019 18:31:17 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:6928 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726427AbfLLXbR (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 12 Dec 2019 18:31:17 -0500
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBCNVDOY000909
        for <bpf@vger.kernel.org>; Thu, 12 Dec 2019 15:31:16 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=2j1bjPUzrEYgDVZgAt65XwSniFueFlCVFDpnkzSnY0A=;
 b=PXXS8JDIVlsrN3IsD6JVx9zDgFnZnTaAF/7NlGaUcqedX2QZ3Hmqb1csk/aBTRRSQdX6
 nxkw9h77mRfo5kWWknjPptqr9c9w49+tHpFcwctT1iqIyqYRBqlb6CO07rFLU81D+48k
 YIDMvSRD/APVzh1iXcaJkj2iod9ek1QFy/U= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2wusrmstyv-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 12 Dec 2019 15:31:16 -0800
Received: from intmgw002.41.prn1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 12 Dec 2019 15:31:12 -0800
Received: by dev082.prn2.facebook.com (Postfix, from userid 572249)
        id 038773712A1F; Thu, 12 Dec 2019 15:31:10 -0800 (PST)
Smtp-Origin-Hostprefix: dev
From:   Andrey Ignatov <rdna@fb.com>
Smtp-Origin-Hostname: dev082.prn2.facebook.com
To:     <bpf@vger.kernel.org>
CC:     Andrey Ignatov <rdna@fb.com>, <ast@kernel.org>,
        <daniel@iogearbox.net>, <kafai@fb.com>, <andriin@fb.com>,
        <kernel-team@fb.com>
Smtp-Origin-Cluster: prn2c23
Subject: [PATCH v2 bpf-next 2/6] bpf: Remove unused new_flags in hierarchy_allows_attach()
Date:   Thu, 12 Dec 2019 15:30:49 -0800
Message-ID: <678caf2c5f76fb9988d32c26a6587769677a648c.1576193131.git.rdna@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1576193131.git.rdna@fb.com>
References: <cover.1576193131.git.rdna@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-12_08:2019-12-12,2019-12-12 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0 mlxscore=0
 lowpriorityscore=0 bulkscore=0 phishscore=0 spamscore=0 priorityscore=1501
 suspectscore=13 impostorscore=0 adultscore=0 mlxlogscore=471 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1910280000
 definitions=main-1912120181
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

new_flags is unused, remove it.

Signed-off-by: Andrey Ignatov <rdna@fb.com>
Acked-by: Martin KaFai Lau <kafai@fb.com>
---
 kernel/bpf/cgroup.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index e8cbdd1be687..283efe3ce052 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -103,8 +103,7 @@ static u32 prog_list_length(struct list_head *head)
  * if parent has overridable or multi-prog, allow attaching
  */
 static bool hierarchy_allows_attach(struct cgroup *cgrp,
-				    enum bpf_attach_type type,
-				    u32 new_flags)
+				    enum bpf_attach_type type)
 {
 	struct cgroup *p;
 
@@ -303,7 +302,7 @@ int __cgroup_bpf_attach(struct cgroup *cgrp, struct bpf_prog *prog,
 		/* invalid combination */
 		return -EINVAL;
 
-	if (!hierarchy_allows_attach(cgrp, type, flags))
+	if (!hierarchy_allows_attach(cgrp, type))
 		return -EPERM;
 
 	if (!list_empty(progs) && cgrp->bpf.flags[type] != flags)
-- 
2.17.1

