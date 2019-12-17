Return-Path: <SRS0=5bl/=2H=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A6A0C43603
	for <bpf@archiver.kernel.org>; Tue, 17 Dec 2019 23:42:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C98E32176D
	for <bpf@archiver.kernel.org>; Tue, 17 Dec 2019 23:42:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="LWDMT7J9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726205AbfLQXmd (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 17 Dec 2019 18:42:33 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:44342 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726090AbfLQXmd (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 17 Dec 2019 18:42:33 -0500
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.42/8.16.0.42) with SMTP id xBHNbxHQ019171
        for <bpf@vger.kernel.org>; Tue, 17 Dec 2019 15:42:32 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=facebook;
 bh=4cgWGlB9/h19dutJ9eZqwoN3DG9e6wfF4VOhWGjp2h4=;
 b=LWDMT7J9ei586goWvGIY5wGIvjSMMx0iMTgsDCA7LSTksImQJPabH4V5JFExagRw+rzT
 hlqEbh7Oan+AL6SN5Ijx8TXW0zx8L61EnzEbLsAWxOkFYklAg/Ug0F5/JUkwgipm4+jP
 445f6/s0mrx7W951ZWMS1Eb5iOKNj9/b1yo= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0001303.ppops.net with ESMTP id 2wxfr0eq5x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 17 Dec 2019 15:42:31 -0800
Received: from intmgw004.05.ash5.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::d) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 17 Dec 2019 15:42:31 -0800
Received: by devbig012.ftw2.facebook.com (Postfix, from userid 137359)
        id 892B92EC1A54; Tue, 17 Dec 2019 15:42:30 -0800 (PST)
Smtp-Origin-Hostprefix: devbig
From:   Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Hostname: devbig012.ftw2.facebook.com
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>, <ast@fb.com>,
        <daniel@iogearbox.net>
CC:     <andrii.nakryiko@gmail.com>, <kernel-team@fb.com>,
        Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH bpf-next] libbpf: reduce log level for custom section names
Date:   Tue, 17 Dec 2019 15:42:28 -0800
Message-ID: <20191217234228.1739308-1-andriin@fb.com>
X-Mailer: git-send-email 2.17.1
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-17_05:2019-12-17,2019-12-17 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 clxscore=1015 priorityscore=1501 malwarescore=0 adultscore=0
 suspectscore=25 mlxscore=0 phishscore=0 spamscore=0 mlxlogscore=837
 bulkscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-1910280000 definitions=main-1912170189
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Libbpf is trying to recognize BPF program type based on its section name
during bpf_object__open() phase. This is not strictly enforced and user code
has ability to specify/override correct BPF program type after open.  But if
BPF program is using custom section name, libbpf will still emit warnings,
which can be quite annoying to users. This patch reduces log level of
information messages emitted by libbpf if section name is not canonical. User
can still get a list of all supported section names as debug-level message.

Signed-off-by: Andrii Nakryiko <andriin@fb.com>
---
 tools/lib/bpf/libbpf.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 3fe42d6b0c2f..906bbbf7b2e4 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -5883,7 +5883,7 @@ int libbpf_prog_type_by_name(const char *name, enum bpf_prog_type *prog_type,
 		return 0;
 	}
 
-	pr_warn("failed to guess program type from ELF section '%s'\n", name);
+	pr_debug("failed to guess program type from ELF section '%s'\n", name);
 	type_names = libbpf_get_type_names(false);
 	if (type_names != NULL) {
 		pr_debug("supported section(type) names are:%s\n", type_names);
@@ -6001,10 +6001,10 @@ int libbpf_attach_type_by_name(const char *name,
 		*attach_type = section_defs[i].attach_type;
 		return 0;
 	}
-	pr_warn("failed to guess attach type based on ELF section name '%s'\n", name);
+	pr_debug("failed to guess attach type based on ELF section name '%s'\n", name);
 	type_names = libbpf_get_type_names(true);
 	if (type_names != NULL) {
-		pr_info("attachable section(type) names are:%s\n", type_names);
+		pr_debug("attachable section(type) names are:%s\n", type_names);
 		free(type_names);
 	}
 
-- 
2.17.1

