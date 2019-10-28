Return-Path: <SRS0=j4GQ=YW=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07A8ACA9EC0
	for <bpf@archiver.kernel.org>; Tue, 29 Oct 2019 00:49:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA2F521479
	for <bpf@archiver.kernel.org>; Tue, 29 Oct 2019 00:49:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="RCv5cGJn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727158AbfJ2AtM (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 28 Oct 2019 20:49:12 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:41824 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725848AbfJ2AtM (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 28 Oct 2019 20:49:12 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9T0mhPm005103
        for <bpf@vger.kernel.org>; Mon, 28 Oct 2019 17:49:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=facebook;
 bh=l+z+mDMW3mRbrvr3xcPGWZIjewh/Ku4e8YpmsgRCduQ=;
 b=RCv5cGJn1Ed9YBx5G0a3R6PEryNtLtgVW0YwYRWXThLwmgaNISWxyC1QYygb67drfyk8
 7rP2CamBPpo8UkIvIbrpURlkjja+AnqYpUxWqEFfLnclPctlpRkhNfe6FJOYv9XgtkB/
 bIxlcuck3dshJWezaLK2Pf6CqvJiClds5mw= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2vw6f2gcd8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 28 Oct 2019 17:49:11 -0700
Received: from 2401:db00:2120:81ca:face:0:31:0 (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 28 Oct 2019 17:49:09 -0700
Received: by devbig012.ftw2.facebook.com (Postfix, from userid 137359)
        id 84E8A2EC1639; Mon, 28 Oct 2019 16:37:28 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Hostname: devbig012.ftw2.facebook.com
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>, <ast@fb.com>,
        <daniel@iogearbox.net>
CC:     <andrii.nakryiko@gmail.com>, <kernel-team@fb.com>,
        Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH bpf-next] libbpf: fix off-by-one error in ELF sanity check
Date:   Mon, 28 Oct 2019 16:37:27 -0700
Message-ID: <20191028233727.1286699-1-andriin@fb.com>
X-Mailer: git-send-email 2.17.1
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-28_07:2019-10-28,2019-10-28 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 clxscore=1015 adultscore=0 impostorscore=0 priorityscore=1501 mlxscore=0
 malwarescore=0 spamscore=0 suspectscore=8 phishscore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1910290007
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

libbpf's bpf_object__elf_collect() does simple sanity check after iterating
over all ELF sections, if checks that .strtab index is correct. Unfortunately,
due to section indices being 1-based, the check breaks for cases when .strtab
ends up being the very last section in ELF.

Fixes: 77ba9a5b48a7 ("tools lib bpf: Fetch map names from correct strtab")
Signed-off-by: Andrii Nakryiko <andriin@fb.com>
---
 tools/lib/bpf/libbpf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index d71631a01926..5d15cc4dfcd6 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -1664,7 +1664,7 @@ static int bpf_object__elf_collect(struct bpf_object *obj, bool relaxed_maps)
 		}
 	}
 
-	if (!obj->efile.strtabidx || obj->efile.strtabidx >= idx) {
+	if (!obj->efile.strtabidx || obj->efile.strtabidx > idx) {
 		pr_warn("Corrupted ELF file: index of strtab invalid\n");
 		return -LIBBPF_ERRNO__FORMAT;
 	}
-- 
2.17.1

