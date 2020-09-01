Return-Path: <SRS0=+JL0=CK=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45F55C433E6
	for <bpf@archiver.kernel.org>; Tue,  1 Sep 2020 01:50:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 275762098B
	for <bpf@archiver.kernel.org>; Tue,  1 Sep 2020 01:50:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="Q7hPdgXV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726044AbgIABuv (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 31 Aug 2020 21:50:51 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:55252 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726537AbgIABuh (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 31 Aug 2020 21:50:37 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 0811m7Li009717
        for <bpf@vger.kernel.org>; Mon, 31 Aug 2020 18:50:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=0gj9ZEeX+SuwYYReXFv2KjTWVNIWQdZGMmhlRg5e800=;
 b=Q7hPdgXV1M4dj+paWgbuIAuKiDcGLsze3M+Qb4C+zngLyd9DTJ0V92vcNUGgzvb6+tYY
 LT3wCH4wy361cTTIQjVMD+Deg+qfWNNBitJdEWoKsEwDtzd/1Vg/0adwnRE2mpZ+Ke4t
 qEdPATlJPVIluE9/eg4kP64So9eKMIOOs3E= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0001303.ppops.net with ESMTP id 337jpnb75a-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 31 Aug 2020 18:50:36 -0700
Received: from intmgw004.08.frc2.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:11d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 31 Aug 2020 18:50:33 -0700
Received: by devbig012.ftw2.facebook.com (Postfix, from userid 137359)
        id 634C72EC663B; Mon, 31 Aug 2020 18:50:29 -0700 (PDT)
From:   Andrii Nakryiko <andriin@fb.com>
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>, <ast@fb.com>,
        <daniel@iogearbox.net>
CC:     <andrii.nakryiko@gmail.com>, <kernel-team@fb.com>,
        Andrii Nakryiko <andriin@fb.com>
Subject: [PATCH v2 bpf-next 11/14] selftests/bpf: turn fexit_bpf2bpf into test with subtests
Date:   Mon, 31 Aug 2020 18:50:00 -0700
Message-ID: <20200901015003.2871861-12-andriin@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200901015003.2871861-1-andriin@fb.com>
References: <20200901015003.2871861-1-andriin@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-01_01:2020-08-31,2020-09-01 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 bulkscore=0 adultscore=0
 mlxlogscore=868 impostorscore=0 spamscore=0 phishscore=0 suspectscore=8
 mlxscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009010014
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

There are clearly 4 subtests, so make it official.

Signed-off-by: Andrii Nakryiko <andriin@fb.com>
---
 .../selftests/bpf/prog_tests/fexit_bpf2bpf.c  | 21 ++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/fexit_bpf2bpf.c b/too=
ls/testing/selftests/bpf/prog_tests/fexit_bpf2bpf.c
index a550dab9ba7a..eda682727787 100644
--- a/tools/testing/selftests/bpf/prog_tests/fexit_bpf2bpf.c
+++ b/tools/testing/selftests/bpf/prog_tests/fexit_bpf2bpf.c
@@ -208,11 +208,18 @@ static void test_func_map_prog_compatibility(void)
=20
 void test_fexit_bpf2bpf(void)
 {
-	test_target_no_callees();
-	test_target_yes_callees();
-	test_func_replace();
-	test_func_replace_verify();
-	test_func_sockmap_update();
-	test_func_replace_return_code();
-	test_func_map_prog_compatibility();
+	if (test__start_subtest("target_no_callees"))
+		test_target_no_callees();
+	if (test__start_subtest("target_yes_callees"))
+		test_target_yes_callees();
+	if (test__start_subtest("func_replace"))
+		test_func_replace();
+	if (test__start_subtest("func_replace_verify"))
+		test_func_replace_verify();
+	if (test__start_subtest("func_sockmap_update"))
+		test_func_sockmap_update();
+	if (test__start_subtest("func_replace_return_code"))
+		test_func_replace_return_code();
+	if (test__start_subtest("func_map_prog_compatibility"))
+		test_func_map_prog_compatibility();
 }
--=20
2.24.1

