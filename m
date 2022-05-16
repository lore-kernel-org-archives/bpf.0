Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F427C433EF
	for <bpf@archiver.kernel.org>; Mon, 16 May 2022 18:46:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345008AbiEPSqJ convert rfc822-to-8bit (ORCPT
        <rfc822;bpf@archiver.kernel.org>); Mon, 16 May 2022 14:46:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345094AbiEPSp5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 16 May 2022 14:45:57 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B6623A5FB
        for <bpf@vger.kernel.org>; Mon, 16 May 2022 11:45:53 -0700 (PDT)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 24GIXE6Y016316
        for <bpf@vger.kernel.org>; Mon, 16 May 2022 11:45:52 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0001303.ppops.net (PPS) with ESMTPS id 3g283wbvmk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 16 May 2022 11:45:52 -0700
Received: from snc-exhub201.TheFacebook.com (2620:10d:c085:21d::7) by
 snc-exhub203.TheFacebook.com (2620:10d:c085:21d::6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 16 May 2022 11:45:51 -0700
Received: from twshared8307.18.frc3.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:21d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 16 May 2022 11:45:50 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 4743E19FDA28A; Mon, 16 May 2022 11:45:48 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH bpf-next] libbpf: fix memory leak in attach_tp for target-less tracepoint program
Date:   Mon, 16 May 2022 11:45:47 -0700
Message-ID: <20220516184547.3204674-1-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: afiMg8RSeiL7FkoyfcE8XFTWBNRfrCmc
X-Proofpoint-ORIG-GUID: afiMg8RSeiL7FkoyfcE8XFTWBNRfrCmc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-16_15,2022-05-16_02,2022-02-23_01
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Fix sec_name memory leak if user defines target-less SEC("tp").

Fixes: 9af8efc45eb1 ("libbpf: Allow "incomplete" basic tracing SEC() definitions")
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/libbpf.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 9aae886cbabf..ef7f302e542f 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -11592,16 +11592,16 @@ static int attach_tp(const struct bpf_program *prog, long cookie, struct bpf_lin
 {
 	char *sec_name, *tp_cat, *tp_name;
 
-	sec_name = strdup(prog->sec_name);
-	if (!sec_name)
-		return -ENOMEM;
-
 	*link = NULL;
 
 	/* no auto-attach for SEC("tp") or SEC("tracepoint") */
 	if (strcmp(prog->sec_name, "tp") == 0 || strcmp(prog->sec_name, "tracepoint") == 0)
 		return 0;
 
+	sec_name = strdup(prog->sec_name);
+	if (!sec_name)
+		return -ENOMEM;
+
 	/* extract "tp/<category>/<name>" or "tracepoint/<category>/<name>" */
 	if (str_has_pfx(prog->sec_name, "tp/"))
 		tp_cat = sec_name + sizeof("tp/") - 1;
-- 
2.30.2

