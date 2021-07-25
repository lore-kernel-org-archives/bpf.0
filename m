Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C59C9C432BE
	for <bpf@archiver.kernel.org>; Sun, 25 Jul 2021 17:39:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A55A060F23
	for <bpf@archiver.kernel.org>; Sun, 25 Jul 2021 17:39:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230303AbhGYQ6s convert rfc822-to-8bit (ORCPT
        <rfc822;bpf@archiver.kernel.org>); Sun, 25 Jul 2021 12:58:48 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:50690 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230110AbhGYQ6s (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sun, 25 Jul 2021 12:58:48 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16PHYmCC021984
        for <bpf@vger.kernel.org>; Sun, 25 Jul 2021 10:39:18 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3a0ewrwqyp-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Sun, 25 Jul 2021 10:39:18 -0700
Received: from intmgw001.06.ash9.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::e) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Sun, 25 Jul 2021 10:39:16 -0700
Received: by devbig012.ftw2.facebook.com (Postfix, from userid 137359)
        id 653C23D405B6; Sun, 25 Jul 2021 10:39:11 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Rafael David Tinoco <rafaeldtinoco@gmail.com>
Subject: [PATCH bpf-next 08/14] libbpf: remove unused bpf_link's destroy operation, but add dealloc
Date:   Sun, 25 Jul 2021 10:38:39 -0700
Message-ID: <20210725173845.2593626-9-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210725173845.2593626-1-andrii@kernel.org>
References: <20210725173845.2593626-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: ZZkXq1Pafs4FOJgg2EOUHyg89nlxKomS
X-Proofpoint-ORIG-GUID: ZZkXq1Pafs4FOJgg2EOUHyg89nlxKomS
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-25_05:2021-07-23,2021-07-25 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 impostorscore=0
 malwarescore=0 spamscore=0 suspectscore=0 adultscore=0 mlxscore=0
 bulkscore=0 clxscore=1015 mlxlogscore=947 priorityscore=1501 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107250126
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

bpf_link->destroy() isn't used by any code, so remove it. Instead, add ability
to override deallocation procedure, with default doing plain free(link). This
is necessary for cases when we want to "subclass" struct bpf_link to keep
extra information, as is the case in the next patch adding struct
bpf_link_perf.

Cc: Rafael David Tinoco <rafaeldtinoco@gmail.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/libbpf.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index a53ca29b44ab..f944342c0152 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -10070,7 +10070,7 @@ int bpf_prog_load_xattr(const struct bpf_prog_load_attr *attr,
 
 struct bpf_link {
 	int (*detach)(struct bpf_link *link);
-	int (*destroy)(struct bpf_link *link);
+	void (*dealloc)(struct bpf_link *link);
 	char *pin_path;		/* NULL, if not pinned */
 	int fd;			/* hook FD, -1 if not applicable */
 	bool disconnected;
@@ -10109,11 +10109,12 @@ int bpf_link__destroy(struct bpf_link *link)
 
 	if (!link->disconnected && link->detach)
 		err = link->detach(link);
-	if (link->destroy)
-		link->destroy(link);
 	if (link->pin_path)
 		free(link->pin_path);
-	free(link);
+	if (link->dealloc)
+		link->dealloc(link);
+	else
+		free(link);
 
 	return libbpf_err(err);
 }
-- 
2.30.2

