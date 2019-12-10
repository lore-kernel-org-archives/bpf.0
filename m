Return-Path: <SRS0=eM+6=2A=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 766BEC2BD09
	for <bpf@archiver.kernel.org>; Tue, 10 Dec 2019 01:15:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DAEB2077B
	for <bpf@archiver.kernel.org>; Tue, 10 Dec 2019 01:15:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="koGO0vzr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727717AbfLJBPO (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 9 Dec 2019 20:15:14 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:47472 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727684AbfLJBPL (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 9 Dec 2019 20:15:11 -0500
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBA1BPeR029234
        for <bpf@vger.kernel.org>; Mon, 9 Dec 2019 17:15:10 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=zzR6nON3D3o3R4BI/KRZUl99XEyIhqzUw+LZQGkqMFY=;
 b=koGO0vzr13cSXAV62lS6BU+lzNLsczCqpjaMkis/5XvkHsu0vqBx28nJ6g0oV6qWpH04
 7Jy8ZYOnzleOukKWl5CVSB0ONOcm8Ga5HDknz7HuTOd+GBFHz3aL10wRlYWrBZT2290j
 61o1SfdIiVp/1ri2cb+J4KcGIoN2B/w/yoM= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2wrvq1g280-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 09 Dec 2019 17:15:09 -0800
Received: from intmgw001.41.prn1.facebook.com (2620:10d:c081:10::13) by
 mail.thefacebook.com (2620:10d:c081:35::127) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5;
 Mon, 9 Dec 2019 17:15:07 -0800
Received: by devbig012.ftw2.facebook.com (Postfix, from userid 137359)
        id 01C072EC16B5; Mon,  9 Dec 2019 17:15:06 -0800 (PST)
Smtp-Origin-Hostprefix: devbig
From:   Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Hostname: devbig012.ftw2.facebook.com
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>, <ast@fb.com>,
        <daniel@iogearbox.net>
CC:     <andrii.nakryiko@gmail.com>, <kernel-team@fb.com>,
        Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH bpf-next 09/15] libbpf: reduce log level of supported section names dump
Date:   Mon, 9 Dec 2019 17:14:32 -0800
Message-ID: <20191210011438.4182911-10-andriin@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191210011438.4182911-1-andriin@fb.com>
References: <20191210011438.4182911-1-andriin@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-09_05:2019-12-09,2019-12-09 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0
 suspectscore=25 priorityscore=1501 bulkscore=0 phishscore=0 clxscore=1015
 spamscore=0 lowpriorityscore=0 adultscore=0 mlxlogscore=826 malwarescore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912100009
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

It's quite spammy. And now that bpf_object__open() is trying to determine
program type from its section name, we are getting these verbose messages all
the time. Reduce their log level to DEBUG.

Signed-off-by: Andrii Nakryiko <andriin@fb.com>
---
 tools/lib/bpf/libbpf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index f4a3ed73c9f5..a4cce8f1e6b1 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -5191,7 +5191,7 @@ int libbpf_prog_type_by_name(const char *name, enum bpf_prog_type *prog_type,
 	pr_warn("failed to guess program type from ELF section '%s'\n", name);
 	type_names = libbpf_get_type_names(false);
 	if (type_names != NULL) {
-		pr_info("supported section(type) names are:%s\n", type_names);
+		pr_debug("supported section(type) names are:%s\n", type_names);
 		free(type_names);
 	}
 
-- 
2.17.1

