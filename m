Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEB99C4167B
	for <bpf@archiver.kernel.org>; Wed,  2 Nov 2022 18:25:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbiKBSZl convert rfc822-to-8bit (ORCPT
        <rfc822;bpf@archiver.kernel.org>); Wed, 2 Nov 2022 14:25:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230516AbiKBSZc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 2 Nov 2022 14:25:32 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3892A21278
        for <bpf@vger.kernel.org>; Wed,  2 Nov 2022 11:25:29 -0700 (PDT)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A2HnKFM021768
        for <bpf@vger.kernel.org>; Wed, 2 Nov 2022 11:25:29 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3kkj3b64af-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 02 Nov 2022 11:25:29 -0700
Received: from twshared16837.02.prn6.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 2 Nov 2022 11:25:27 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id E6A3420FC7435; Wed,  2 Nov 2022 11:25:19 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <netdev@vger.kernel.org>, <kuba@kernel.org>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>
Subject: [PATCH bpf 1/2] net/ipv4: fix linux/in.h header dependencies
Date:   Wed, 2 Nov 2022 11:25:16 -0700
Message-ID: <20221102182517.2675301-1-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: yTVWTgxSfVMUXztS-o2R4JKWwSpaf3OG
X-Proofpoint-GUID: yTVWTgxSfVMUXztS-o2R4JKWwSpaf3OG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-02_14,2022-11-02_01,2022-06-22_01
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

__DECLARE_FLEX_ARRAY is defined in include/uapi/linux/stddef.h but
doesn't seem to be explicitly included from include/uapi/linux/in.h,
which breaks BPF selftests builds (once we sync linux/stddef.h into
tools/include directory in the next patch). Fix this by explicitly
including linux/stddef.h.

Given this affects BPF CI and bpf tree, targeting this for bpf tree.

Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Gustavo A. R. Silva <gustavoars@kernel.org>
Fixes: 5854a09b4957 ("net/ipv4: Use __DECLARE_FLEX_ARRAY() helper")
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 include/uapi/linux/in.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/uapi/linux/in.h b/include/uapi/linux/in.h
index f243ce665f74..07a4cb149305 100644
--- a/include/uapi/linux/in.h
+++ b/include/uapi/linux/in.h
@@ -20,6 +20,7 @@
 #define _UAPI_LINUX_IN_H
 
 #include <linux/types.h>
+#include <linux/stddef.h>
 #include <linux/libc-compat.h>
 #include <linux/socket.h>
 
-- 
2.30.2

