Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5AFEC433EF
	for <bpf@archiver.kernel.org>; Fri, 13 May 2022 17:37:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355035AbiEMRhQ convert rfc822-to-8bit (ORCPT
        <rfc822;bpf@archiver.kernel.org>); Fri, 13 May 2022 13:37:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354148AbiEMRhP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 13 May 2022 13:37:15 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13C56DF92
        for <bpf@vger.kernel.org>; Fri, 13 May 2022 10:37:14 -0700 (PDT)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24DFCIsa020027
        for <bpf@vger.kernel.org>; Fri, 13 May 2022 10:37:14 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3g1srv119p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 13 May 2022 10:37:14 -0700
Received: from twshared18443.03.prn6.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 13 May 2022 10:37:13 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 8BD7E19DD19E6; Fri, 13 May 2022 10:37:05 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>,
        Mykola Lysenko <mykolal@fb.com>
Subject: [PATCH bpf-next] selftests/bpf: fix usdt_400 test case
Date:   Fri, 13 May 2022 10:37:03 -0700
Message-ID: <20220513173703.89271-1-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: pLKPU310l43GyteJpSeGMQIID1G2Iyah
X-Proofpoint-ORIG-GUID: pLKPU310l43GyteJpSeGMQIID1G2Iyah
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-13_09,2022-05-13_01,2022-02-23_01
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

usdt_400 test case relies on compiler using the same arg spec for
usdt_400 USDT. This assumption breaks with Clang (Clang generates
different arg specs with varying offsets relative to %rbp), so simplify
this further and hard-code the constant which will guarantee that arg
spec is the same across all 400 inlinings.

Fixes: 630301b0d59d ("selftests/bpf: Add basic USDT selftests")
Reported-by: Mykola Lysenko <mykolal@fb.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/testing/selftests/bpf/prog_tests/usdt.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/usdt.c b/tools/testing/selftests/bpf/prog_tests/usdt.c
index a71f51bdc08d..5f733d50b0d7 100644
--- a/tools/testing/selftests/bpf/prog_tests/usdt.c
+++ b/tools/testing/selftests/bpf/prog_tests/usdt.c
@@ -190,9 +190,7 @@ __weak void trigger_300_usdts(void)
 
 static void __always_inline f400(int x __attribute__((unused)))
 {
-	static int y;
-
-	STAP_PROBE1(test, usdt_400, y++);
+	STAP_PROBE1(test, usdt_400, 400);
 }
 
 /* this time we have 400 different USDT call sites, but they have uniform
@@ -299,7 +297,7 @@ static void subtest_multispec_usdt(void)
 	trigger_400_usdts();
 
 	ASSERT_EQ(bss->usdt_100_called, 400, "usdt_400_called");
-	ASSERT_EQ(bss->usdt_100_sum, 399 * 400 / 2, "usdt_400_sum");
+	ASSERT_EQ(bss->usdt_100_sum, 400 * 400, "usdt_400_sum");
 
 cleanup:
 	test_usdt__destroy(skel);
-- 
2.30.2

