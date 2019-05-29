Return-Path: <SRS0=eg6P=T5=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E167C46470
	for <bpf@archiver.kernel.org>; Wed, 29 May 2019 17:36:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 189DB23FA5
	for <bpf@archiver.kernel.org>; Wed, 29 May 2019 17:36:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="mAZ3a04z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726205AbfE2RgW (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 29 May 2019 13:36:22 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:49036 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726054AbfE2RgW (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 29 May 2019 13:36:22 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4THTCfM002982
        for <bpf@vger.kernel.org>; Wed, 29 May 2019 10:36:21 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=sj9s2F5T80KgYKHxJIjF6yomOIk0Lca0i3wIj4qTiv0=;
 b=mAZ3a04zq2sxJ0Kd4E7a5cxSRUedLX3Zr6SfFp5KfVDJbczIjRoqEvGEPVeCHiqyeLxv
 zyYLZJxK0p5fa/QVoaxb8WJ9FkCuaQaX7R3hLElN6a99wZaR5xWikhUUJT7DjJdf+Zu0
 wqBJPpojvF8XJ7V92q97zZm4C7CDSkRHpog= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2ssvdurjdx-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 29 May 2019 10:36:20 -0700
Received: from mx-out.facebook.com (2620:10d:c081:10::13) by
 mail.thefacebook.com (2620:10d:c081:35::126) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5;
 Wed, 29 May 2019 10:36:20 -0700
Received: by dev101.prn2.facebook.com (Postfix, from userid 137359)
        id 977678617AE; Wed, 29 May 2019 10:36:19 -0700 (PDT)
Smtp-Origin-Hostprefix: dev
From:   Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Hostname: dev101.prn2.facebook.com
To:     <andrii.nakryiko@gmail.com>, <netdev@vger.kernel.org>,
        <bpf@vger.kernel.org>, <ast@fb.com>, <daniel@iogearbox.net>,
        <kernel-team@fb.com>
CC:     Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Cluster: prn2c23
Subject: [PATCH v2 bpf-next 2/9] libbpf: preserve errno before calling into user callback
Date:   Wed, 29 May 2019 10:36:04 -0700
Message-ID: <20190529173611.4012579-3-andriin@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190529173611.4012579-1-andriin@fb.com>
References: <20190529173611.4012579-1-andriin@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-29_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=916 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905290114
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

pr_warning ultimately may call into user-provided callback function,
which can clobber errno value, so we need to save it before that.

Acked-by: Song Liu <songliubraving@fb.com>
Signed-off-by: Andrii Nakryiko <andriin@fb.com>
---
 tools/lib/bpf/libbpf.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index c6c9d632624a..5af331cb8e4f 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -565,12 +565,12 @@ static int bpf_object__elf_init(struct bpf_object *obj)
 	} else {
 		obj->efile.fd = open(obj->path, O_RDONLY);
 		if (obj->efile.fd < 0) {
-			char errmsg[STRERR_BUFSIZE];
-			char *cp = libbpf_strerror_r(errno, errmsg,
-						     sizeof(errmsg));
+			char errmsg[STRERR_BUFSIZE], *cp;
 
+			err = -errno;
+			cp = libbpf_strerror_r(err, errmsg, sizeof(errmsg));
 			pr_warning("failed to open %s: %s\n", obj->path, cp);
-			return -errno;
+			return err;
 		}
 
 		obj->efile.elf = elf_begin(obj->efile.fd,
-- 
2.17.1

