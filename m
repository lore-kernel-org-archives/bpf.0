Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6267C433F5
	for <bpf@archiver.kernel.org>; Thu,  7 Apr 2022 23:05:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232369AbiDGXHH convert rfc822-to-8bit (ORCPT
        <rfc822;bpf@archiver.kernel.org>); Thu, 7 Apr 2022 19:07:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232376AbiDGXHG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 7 Apr 2022 19:07:06 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CF776C974
        for <bpf@vger.kernel.org>; Thu,  7 Apr 2022 16:05:05 -0700 (PDT)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 237M0GNC017921
        for <bpf@vger.kernel.org>; Thu, 7 Apr 2022 16:05:04 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3f9nrng0na-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 07 Apr 2022 16:05:04 -0700
Received: from twshared27284.14.frc2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 7 Apr 2022 16:05:03 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id DC12016D7B0D1; Thu,  7 Apr 2022 16:04:47 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH bpf-next 1/2] libbpf: use strlcpy() in path resolution fallback logic
Date:   Thu, 7 Apr 2022 16:04:45 -0700
Message-ID: <20220407230446.3980075-1-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: 5e_HjE6Os5h35VBiyLWS8wP5tZETpV_6
X-Proofpoint-ORIG-GUID: 5e_HjE6Os5h35VBiyLWS8wP5tZETpV_6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-04-07_05,2022-04-07_01,2022-02-23_01
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Coverity static analyzer complains that strcpy() can cause buffer
overflow. Use libbpf_strlcpy() instead to be 100% sure this doesn't
happen.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/usdt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/bpf/usdt.c b/tools/lib/bpf/usdt.c
index b699e720136a..5d7ba171ad39 100644
--- a/tools/lib/bpf/usdt.c
+++ b/tools/lib/bpf/usdt.c
@@ -456,7 +456,7 @@ static int parse_lib_segs(int pid, const char *lib_path, struct elf_seg **segs,
 	if (!realpath(lib_path, path)) {
 		pr_warn("usdt: failed to get absolute path of '%s' (err %d), using path as is...\n",
 			lib_path, -errno);
-		strcpy(path, lib_path);
+		libbpf_strlcpy(path, lib_path, sizeof(path));
 	}
 
 proceed:
-- 
2.30.2

