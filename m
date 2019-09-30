Return-Path: <SRS0=vQPo=XZ=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE5D1C32792
	for <bpf@archiver.kernel.org>; Mon, 30 Sep 2019 20:41:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A05ED224FE
	for <bpf@archiver.kernel.org>; Mon, 30 Sep 2019 20:41:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="FeNfOuOw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731381AbfI3UlE (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 30 Sep 2019 16:41:04 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:64244 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729180AbfI3UlE (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 30 Sep 2019 16:41:04 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.42/8.16.0.42) with SMTP id x8UIqj5B021870
        for <bpf@vger.kernel.org>; Mon, 30 Sep 2019 11:59:07 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=1IgGt+QiRdji7VyWkyj+zGlrMheQ4AYaU5d2Vmsh644=;
 b=FeNfOuOwKpeZo7L2Q6m9h6y1jXmX5Ihtjc4IWmQml8lT2Ew6LJ0UX5GGk+Dg6FxO4Npy
 sg7xXnpSm0v9WpUJ9COjgzDn4d0M/DnhdxE5eOgMZmjfsblfPzX3zRku67VoBCUrx+/U
 lmwbW0QETUJx2pwLDbJDXdCMVKUdCeidxnY= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0001303.ppops.net with ESMTP id 2vbm2uh1m6-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 30 Sep 2019 11:59:07 -0700
Received: from mx-out.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 30 Sep 2019 11:59:05 -0700
Received: by dev101.prn2.facebook.com (Postfix, from userid 137359)
        id C740586185A; Mon, 30 Sep 2019 11:59:02 -0700 (PDT)
Smtp-Origin-Hostprefix: dev
From:   Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Hostname: dev101.prn2.facebook.com
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>, <ast@fb.com>,
        <daniel@iogearbox.net>
CC:     <andrii.nakryiko@gmail.com>, <kernel-team@fb.com>,
        Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Cluster: prn2c23
Subject: [PATCH bpf-next 1/6] selftests/bpf: undo GCC-specific bpf_helpers.h changes
Date:   Mon, 30 Sep 2019 11:58:50 -0700
Message-ID: <20190930185855.4115372-2-andriin@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190930185855.4115372-1-andriin@fb.com>
References: <20190930185855.4115372-1-andriin@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-09-30_11:2019-09-30,2019-09-30 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 malwarescore=0 phishscore=0 mlxscore=0 priorityscore=1501 bulkscore=0
 adultscore=0 mlxlogscore=999 clxscore=1015 impostorscore=0 spamscore=0
 suspectscore=8 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1909300167
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Having GCC provide its own bpf-helper.h is not the right approach and is
going to be changed. Undo bpf_helpers.h change before moving
bpf_helpers.h into libbpf.

Signed-off-by: Andrii Nakryiko <andriin@fb.com>
---
 tools/testing/selftests/bpf/bpf_helpers.h | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/tools/testing/selftests/bpf/bpf_helpers.h b/tools/testing/selftests/bpf/bpf_helpers.h
index 54a50699bbfd..a1d9b97b8e15 100644
--- a/tools/testing/selftests/bpf/bpf_helpers.h
+++ b/tools/testing/selftests/bpf/bpf_helpers.h
@@ -13,8 +13,6 @@
 			 ##__VA_ARGS__);		\
 })
 
-#ifdef __clang__
-
 /* helper macro to place programs, maps, license in
  * different sections in elf_bpf file. Section names
  * are interpreted by elf_bpf loader
@@ -258,12 +256,6 @@ struct bpf_map_def {
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

