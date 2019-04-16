Return-Path: <SRS0=hZ0g=SS=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CD52C282DA
	for <bpf@archiver.kernel.org>; Tue, 16 Apr 2019 18:47:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46522206BA
	for <bpf@archiver.kernel.org>; Tue, 16 Apr 2019 18:47:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730327AbfDPSrY (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 16 Apr 2019 14:47:24 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:42318 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727136AbfDPSrX (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 16 Apr 2019 14:47:23 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3GIZpfw017657
        for <bpf@vger.kernel.org>; Tue, 16 Apr 2019 11:47:23 -0700
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2rwg3h95uc-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 16 Apr 2019 11:47:22 -0700
Received: from mx-out.facebook.com (2620:10d:c0a1:3::13) by
 mail.thefacebook.com (2620:10d:c021:18::176) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5;
 Tue, 16 Apr 2019 11:47:21 -0700
Received: by dev101.prn2.facebook.com (Postfix, from userid 137359)
        id 9F2BD860CB0; Tue, 16 Apr 2019 11:47:19 -0700 (PDT)
Smtp-Origin-Hostprefix: dev
From:   <andrii.nakryiko@gmail.com>
Smtp-Origin-Hostname: dev101.prn2.facebook.com
To:     <andrii.nakryiko@gmail.com>, <netdev@vger.kernel.org>,
        <bpf@vger.kernel.org>, <evvers@ya.ru>
CC:     Andrii Nakryiko <andriin@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@fb.com>, Yonghong Song <yhs@fb.com>
Smtp-Origin-Cluster: prn2c23
Subject: [PATCH bpf-next] libbpf: fix printf formatter for ptrdiff_t argument
Date:   Tue, 16 Apr 2019 11:47:17 -0700
Message-ID: <20190416184717.1392147-1-andrii.nakryiko@gmail.com>
X-Mailer: git-send-email 2.17.1
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-16_07:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Andrii Nakryiko <andriin@fb.com>

Using %ld for printing out value of ptrdiff_t type is not portable
between 32-bit and 64-bit archs. This is causing compilation errors for
libbpf on 32-bit platform (discovered as part of an effort to integrate
libbpf into systemd ([0])). Proper formatter is %td, which is used in
this patch.

v2->v1:
  - add Reported-by
  - provide more context on how this issue was discovered

[0] https://github.com/systemd/systemd/pull/12151

Reported-by: Evgeny Vereshchagin <evvers@ya.ru>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Alexei Starovoitov <ast@fb.com>
Cc: Yonghong Song <yhs@fb.com>
Signed-off-by: Andrii Nakryiko <andriin@fb.com>
---
 tools/lib/bpf/libbpf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index e5b77ad97795..d817bf20f3d6 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -817,7 +817,7 @@ bpf_object__init_internal_map(struct bpf_object *obj, struct bpf_map *map,
 		memcpy(*data_buff, data->d_buf, data->d_size);
 	}
 
-	pr_debug("map %ld is \"%s\"\n", map - obj->maps, map->name);
+	pr_debug("map %td is \"%s\"\n", map - obj->maps, map->name);
 	return 0;
 }
 
-- 
2.17.1

