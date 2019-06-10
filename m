Return-Path: <SRS0=GDV9=UJ=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF718C31E40
	for <bpf@archiver.kernel.org>; Mon, 10 Jun 2019 16:57:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B824420859
	for <bpf@archiver.kernel.org>; Mon, 10 Jun 2019 16:57:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="dOYMbarm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387493AbfFJQ5R (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 10 Jun 2019 12:57:17 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:59498 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387492AbfFJQ5R (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 10 Jun 2019 12:57:17 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5AGruF0018873
        for <bpf@vger.kernel.org>; Mon, 10 Jun 2019 09:57:16 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=facebook;
 bh=9BE1kuKEd/d1CaubpyzGYTEpwxSNCGkMYDWvVyo5h6Q=;
 b=dOYMbarm3Ut3otnfV4gOTAA0piclk1Kg2QxxK79Ak5E2hyxu7bk7CP3n2txmm/qwU328
 MMWudXhO1jomZarJwiL0NQ66KG4HQNh8TM8QKGSfTZV7DQtDRfXOO0/LdA9aG4mnqI6j
 fb4zbDT7jeaO/XsqrbvU9GkwsOMEQ94jA/Q= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2t1r8j0yh6-11
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 10 Jun 2019 09:57:16 -0700
Received: from mx-out.facebook.com (2620:10d:c081:10::13) by
 mail.thefacebook.com (2620:10d:c081:35::130) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5;
 Mon, 10 Jun 2019 09:57:11 -0700
Received: by devvm3632.prn2.facebook.com (Postfix, from userid 172007)
        id 3FF82CFC0CAD; Mon, 10 Jun 2019 09:57:10 -0700 (PDT)
Smtp-Origin-Hostprefix: devvm
From:   Hechao Li <hechaol@fb.com>
Smtp-Origin-Hostname: devvm3632.prn2.facebook.com
To:     <bpf@vger.kernel.org>
CC:     <netdev@vger.kernel.org>, <daniel@iogearbox.net>, <ast@kernel.org>,
        <kernel-team@fb.com>, Hechao Li <hechaol@fb.com>
Smtp-Origin-Cluster: prn2c23
Subject: [PATCH v1 bpf-next] selftests/bpf : Clean up feature/ when make clean
Date:   Mon, 10 Jun 2019 09:57:08 -0700
Message-ID: <20190610165708.2083220-1-hechaol@fb.com>
X-Mailer: git-send-email 2.17.1
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-10_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=13 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=581 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906100115
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

I got an error when compiling selftests/bpf:

libbpf.c:411:10: error: implicit declaration of function 'reallocarray';
did you mean 'realloc'? [-Werror=implicit-function-declaration]
  progs = reallocarray(progs, nr_progs + 1, sizeof(progs[0]));

It was caused by feature-reallocarray=1 in FEATURE-DUMP.libbpf and it
was fixed by manually removing feature/ folder. This diff adds feature/
to EXTRA_CLEAN to avoid this problem.

Signed-off-by: Hechao Li <hechaol@fb.com>
---
 tools/testing/selftests/bpf/Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 2b426ae1cdc9..44fb61f4d502 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -279,4 +279,5 @@ $(OUTPUT)/verifier/tests.h: $(VERIFIER_TESTS_DIR) $(VERIFIER_TEST_FILES)
 		 ) > $(VERIFIER_TESTS_H))
 
 EXTRA_CLEAN := $(TEST_CUSTOM_PROGS) $(ALU32_BUILD_DIR) \
-	$(VERIFIER_TESTS_H) $(PROG_TESTS_H) $(MAP_TESTS_H)
+	$(VERIFIER_TESTS_H) $(PROG_TESTS_H) $(MAP_TESTS_H) \
+	feature
-- 
2.17.1

