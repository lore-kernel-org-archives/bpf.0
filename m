Return-Path: <bpf-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2148C74A5B
	for <bpf@archiver.kernel.org>; Fri, 17 Mar 2023 22:04:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230469AbjCQWEO convert rfc822-to-8bit (ORCPT
        <rfc822;bpf@archiver.kernel.org>); Fri, 17 Mar 2023 18:04:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbjCQWEM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 17 Mar 2023 18:04:12 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98E1D2E80A
        for <bpf@vger.kernel.org>; Fri, 17 Mar 2023 15:04:09 -0700 (PDT)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32HKFcur001680
        for <bpf@vger.kernel.org>; Fri, 17 Mar 2023 15:04:09 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3pcp01m3qd-9
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 17 Mar 2023 15:04:09 -0700
Received: from twshared13785.14.prn3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Fri, 17 Mar 2023 15:04:05 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 1947B2AEB74F2; Fri, 17 Mar 2023 15:04:01 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC:     <andrii@kernel.org>, <kernel-team@meta.com>
Subject: [PATCH bpf-next 4/6] libbpf: don't enfore verifier log levels on libbpf side
Date:   Fri, 17 Mar 2023 15:03:49 -0700
Message-ID: <20230317220351.2970665-5-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230317220351.2970665-1-andrii@kernel.org>
References: <20230317220351.2970665-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: fb1vLVv08cAfAXdHYjoF7oAIW_p7grqN
X-Proofpoint-GUID: fb1vLVv08cAfAXdHYjoF7oAIW_p7grqN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-17_17,2023-03-16_02,2023-02-09_01
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This basically prevents any forward compatibility. And we either way
just return -EINVAL, which would otherwise be returned from bpf()
syscall anyways.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/bpf.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
index e750b6f5fcc3..eb08a998b526 100644
--- a/tools/lib/bpf/bpf.c
+++ b/tools/lib/bpf/bpf.c
@@ -290,8 +290,6 @@ int bpf_prog_load(enum bpf_prog_type prog_type,
 
 	if (!!log_buf != !!log_size)
 		return libbpf_err(-EINVAL);
-	if (log_level > (4 | 2 | 1))
-		return libbpf_err(-EINVAL);
 	if (log_level && !log_buf)
 		return libbpf_err(-EINVAL);
 
-- 
2.34.1

