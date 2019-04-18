Return-Path: <SRS0=qXn4=SU=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00D50C10F14
	for <bpf@archiver.kernel.org>; Thu, 18 Apr 2019 05:23:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4E4021479
	for <bpf@archiver.kernel.org>; Thu, 18 Apr 2019 05:23:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="ku0Xz4tK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725876AbfDRFXf (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 18 Apr 2019 01:23:35 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:35678 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725888AbfDRFXe (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 18 Apr 2019 01:23:34 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.27/8.16.0.27) with SMTP id x3I5IW2C020385
        for <bpf@vger.kernel.org>; Wed, 17 Apr 2019 22:23:33 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=facebook;
 bh=mLDHIFvzX0PBOH/78X6nPknukeVFJrxVOY1pN5LDExA=;
 b=ku0Xz4tKxQ4hU4KLJPlDi+qJZP/Pg8VhMxbkKSuP2Iht/8eH45zoK309kbBYLFzW7Pmx
 ANx/m8MNkldg2DI02t0nR+y8wAkua5byKaVL2I624sGhcEibWbqzLEGh56lt7HtYfuvP
 ObvwEbjQP46MtdeQzMz2Qp8k5MxWScQ2OSU= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by m0089730.ppops.net with ESMTP id 2rx69vaj5s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 17 Apr 2019 22:23:33 -0700
Received: from mx-out.facebook.com (2620:10d:c081:10::13) by
 mail.thefacebook.com (2620:10d:c081:35::126) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5;
 Wed, 17 Apr 2019 22:23:31 -0700
Received: by devbig003.ftw2.facebook.com (Postfix, from userid 128203)
        id A0DD43702E15; Wed, 17 Apr 2019 22:23:30 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Yonghong Song <yhs@fb.com>
Smtp-Origin-Hostname: devbig003.ftw2.facebook.com
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>
CC:     Alexei Starovoitov <ast@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>,
        Yonghong Song <yhs@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH bpf-next] selftests/bpf: fix a compilation error
Date:   Wed, 17 Apr 2019 22:23:30 -0700
Message-ID: <20190418052330.4180377-1-yhs@fb.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-18_03:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

I hit the following compilation error with gcc 4.8.5.

  prog_tests/flow_dissector.c: In function =E2=80=98test_flow_dissector=E2=
=80=99:
  prog_tests/flow_dissector.c:155:2: error: =E2=80=98for=E2=80=99 loop in=
itial declarations are only allowed in C99 mode
    for (int i =3D 0; i < ARRAY_SIZE(tests); i++) {
    ^
  prog_tests/flow_dissector.c:155:2: note: use option -std=3Dc99 or -std=3D=
gnu99 to compile your code

Let us fix the issue by avoiding this particular c99 feature.

Fixes: a5cb33464e53 ("selftests/bpf: make flow dissector tests more exten=
sible")
Signed-off-by: Yonghong Song <yhs@fb.com>
---
 tools/testing/selftests/bpf/prog_tests/flow_dissector.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/flow_dissector.c b/to=
ols/testing/selftests/bpf/prog_tests/flow_dissector.c
index 1a73937826b0..126319f9a97c 100644
--- a/tools/testing/selftests/bpf/prog_tests/flow_dissector.c
+++ b/tools/testing/selftests/bpf/prog_tests/flow_dissector.c
@@ -143,7 +143,7 @@ struct test tests[] =3D {
 void test_flow_dissector(void)
 {
 	struct bpf_object *obj;
-	int err, prog_fd;
+	int i, err, prog_fd;
=20
 	err =3D bpf_flow_load(&obj, "./bpf_flow.o", "flow_dissector",
 			    "jmp_table", &prog_fd);
@@ -152,7 +152,7 @@ void test_flow_dissector(void)
 		return;
 	}
=20
-	for (int i =3D 0; i < ARRAY_SIZE(tests); i++) {
+	for (i =3D 0; i < ARRAY_SIZE(tests); i++) {
 		struct bpf_flow_keys flow_keys;
 		struct bpf_prog_test_run_attr tattr =3D {
 			.prog_fd =3D prog_fd,
--=20
2.17.1

