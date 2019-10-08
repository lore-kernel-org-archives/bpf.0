Return-Path: <SRS0=X79y=YB=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97CA5C10F14
	for <bpf@archiver.kernel.org>; Tue,  8 Oct 2019 17:59:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 769A3217D7
	for <bpf@archiver.kernel.org>; Tue,  8 Oct 2019 17:59:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="ndAcQLmF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729506AbfJHR7z (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 8 Oct 2019 13:59:55 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:10082 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726320AbfJHR7z (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 8 Oct 2019 13:59:55 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x98HxTop016707
        for <bpf@vger.kernel.org>; Tue, 8 Oct 2019 10:59:54 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=76Gk0naCCpsyBqR1yVlnAM0v4hN68Eu2JwrVDrTYsZw=;
 b=ndAcQLmF05EHfzSned+5TckUXNIi6OQ50YvYbyg+CyhRBj/UX8fp4xpAQRvM4RbA+Gfz
 2Er4V4vWihX4xAx0luX7IjuUCKcaXHlnf49RiEfAIe9+sQBy9JiaF6eNNoVsLRib5Jge
 r4F3YTpf+6CVw96/zCr2IUGmtLiwhY1WWZ4= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2vg6ms6rvy-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 08 Oct 2019 10:59:54 -0700
Received: from 2401:db00:30:600c:face:0:1f:0 (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 8 Oct 2019 10:59:53 -0700
Received: by dev101.prn2.facebook.com (Postfix, from userid 137359)
        id C32498618D3; Tue,  8 Oct 2019 10:59:51 -0700 (PDT)
Smtp-Origin-Hostprefix: dev
From:   Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Hostname: dev101.prn2.facebook.com
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>, <ast@fb.com>,
        <daniel@iogearbox.net>
CC:     <andrii.nakryiko@gmail.com>, <kernel-team@fb.com>,
        Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Cluster: prn2c23
Subject: [PATCH v5 bpf-next 1/7] selftests/bpf: undo GCC-specific bpf_helpers.h changes
Date:   Tue, 8 Oct 2019 10:59:36 -0700
Message-ID: <20191008175942.1769476-2-andriin@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191008175942.1769476-1-andriin@fb.com>
References: <20191008175942.1769476-1-andriin@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-08_07:2019-10-08,2019-10-08 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 priorityscore=1501 mlxlogscore=999 clxscore=1015 spamscore=0 phishscore=0
 bulkscore=0 impostorscore=0 suspectscore=8 mlxscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1910080143
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Having GCC provide its own bpf-helper.h is not the right approach and is
going to be changed. Undo bpf_helpers.h change before moving
bpf_helpers.h into libbpf.

Acked-by: Song Liu <songliubraving@fb.com>
Acked-by: Ilya Leoshkevich <iii@linux.ibm.com>
Acked-by: John Fastabend <john.fastabend@gmail.com>
Signed-off-by: Andrii Nakryiko <andriin@fb.com>
---
 tools/testing/selftests/bpf/bpf_helpers.h | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/tools/testing/selftests/bpf/bpf_helpers.h b/tools/testing/selftests/bpf/bpf_helpers.h
index 15152280db6f..ffd4d8c9a087 100644
--- a/tools/testing/selftests/bpf/bpf_helpers.h
+++ b/tools/testing/selftests/bpf/bpf_helpers.h
@@ -15,8 +15,6 @@
 			 ##__VA_ARGS__);		\
 })
 
-#ifdef __clang__
-
 /* helper macro to place programs, maps, license in
  * different sections in elf_bpf file. Section names
  * are interpreted by elf_bpf loader
@@ -47,12 +45,6 @@ struct bpf_map_def {
 	unsigned int numa_node;
 };
 
-#else
-
-#include <bpf-helpers.h>
-
-#endif
-
 #define BPF_ANNOTATE_KV_PAIR(name, type_key, type_val)		\
 	struct ____btf_map_##name {				\
 		type_key key;					\
-- 
2.17.1

