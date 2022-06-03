Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6DFEC433EF
	for <bpf@archiver.kernel.org>; Fri,  3 Jun 2022 19:04:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245139AbiFCTD6 convert rfc822-to-8bit (ORCPT
        <rfc822;bpf@archiver.kernel.org>); Fri, 3 Jun 2022 15:03:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348732AbiFCTD5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 3 Jun 2022 15:03:57 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F0AF30F7E
        for <bpf@vger.kernel.org>; Fri,  3 Jun 2022 12:03:56 -0700 (PDT)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 253GmRs0021921
        for <bpf@vger.kernel.org>; Fri, 3 Jun 2022 12:03:56 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3gewq996un-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 03 Jun 2022 12:03:56 -0700
Received: from twshared3657.05.prn5.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Fri, 3 Jun 2022 12:03:54 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 3F0AA1AC9C426; Fri,  3 Jun 2022 12:03:51 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH bpf-next 10/15] libbpf: cleanup LIBBPF_DEPRECATED_SINCE supporting macros for v0.x
Date:   Fri, 3 Jun 2022 12:01:50 -0700
Message-ID: <20220603190155.3924899-11-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220603190155.3924899-1-andrii@kernel.org>
References: <20220603190155.3924899-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 3c1xvYel7A0uX83e3OFBJ8mPuFIm4vIW
X-Proofpoint-GUID: 3c1xvYel7A0uX83e3OFBJ8mPuFIm4vIW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-03_06,2022-06-03_01,2022-02-23_01
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Keep the LIBBPF_DEPRECATED_SINCE macro "framework" for future
deprecations, but clean up 0.x related helper macros.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/libbpf_common.h | 16 +++-------------
 1 file changed, 3 insertions(+), 13 deletions(-)

diff --git a/tools/lib/bpf/libbpf_common.h b/tools/lib/bpf/libbpf_common.h
index 000e37798ff2..9a7937f339df 100644
--- a/tools/lib/bpf/libbpf_common.h
+++ b/tools/lib/bpf/libbpf_common.h
@@ -30,20 +30,10 @@
 /* Add checks for other versions below when planning deprecation of API symbols
  * with the LIBBPF_DEPRECATED_SINCE macro.
  */
-#if __LIBBPF_CURRENT_VERSION_GEQ(0, 6)
-#define __LIBBPF_MARK_DEPRECATED_0_6(X) X
+#if __LIBBPF_CURRENT_VERSION_GEQ(1, 0)
+#define __LIBBPF_MARK_DEPRECATED_1_0(X) X
 #else
-#define __LIBBPF_MARK_DEPRECATED_0_6(X)
-#endif
-#if __LIBBPF_CURRENT_VERSION_GEQ(0, 7)
-#define __LIBBPF_MARK_DEPRECATED_0_7(X) X
-#else
-#define __LIBBPF_MARK_DEPRECATED_0_7(X)
-#endif
-#if __LIBBPF_CURRENT_VERSION_GEQ(0, 8)
-#define __LIBBPF_MARK_DEPRECATED_0_8(X) X
-#else
-#define __LIBBPF_MARK_DEPRECATED_0_8(X)
+#define __LIBBPF_MARK_DEPRECATED_1_0(X)
 #endif
 
 /* This set of internal macros allows to do "function overloading" based on
-- 
2.30.2

