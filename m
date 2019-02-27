Return-Path: <SRS0=P9GS=RC=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A995EC00319
	for <bpf@archiver.kernel.org>; Wed, 27 Feb 2019 22:47:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 730A7213A2
	for <bpf@archiver.kernel.org>; Wed, 27 Feb 2019 22:47:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="YTYB6Kfg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730189AbfB0WrD (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 27 Feb 2019 17:47:03 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:40156 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730149AbfB0Wqy (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 27 Feb 2019 17:46:54 -0500
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.27/8.16.0.27) with SMTP id x1RMbOKQ005766
        for <bpf@vger.kernel.org>; Wed, 27 Feb 2019 14:46:51 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=y3lAPtTPfGuTKfWufaJ+6qdfeI4yRivOrYZvuORDGyA=;
 b=YTYB6KfgPD54I+QCIbTYgBINUqcr/Br4huWZN3eWAa4ItCihA89iOMk8R4SUrdciJNM1
 27IcS7sO9zqZ4YkKbM27n7ITB1mcdhpRc+PAth1MAm46aq65+hlzwQ9KyemJjXExTMln
 bw20qjYCiNRjmhbvXqpZ4iLJ+5lMxtGqjvg= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by m0001303.ppops.net with ESMTP id 2qx25v89r6-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 27 Feb 2019 14:46:51 -0800
Received: from mx-out.facebook.com (2620:10d:c0a1:3::13) by
 mail.thefacebook.com (2620:10d:c021:18::172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1531.3;
 Wed, 27 Feb 2019 14:46:49 -0800
Received: by devvm7221.prn2.facebook.com (Postfix, from userid 137359)
        id A205BC07CCD6; Wed, 27 Feb 2019 14:46:47 -0800 (PST)
Smtp-Origin-Hostprefix: devvm
From:   Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Hostname: devvm7221.prn2.facebook.com
To:     <andrii.nakryiko@gmail.com>, <kernel-team@fb.com>, <ast@fb.com>,
        <acme@kernel.org>, <netdev@vger.kernel.org>, <bpf@vger.kernel.org>,
        <daniel@iogearbox.net>
CC:     Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Cluster: prn2c23
Subject: [PATCH bpf-next 5/5] selftests/bpf: add btf_dedup test of FWD/STRUCT resolution
Date:   Wed, 27 Feb 2019 14:46:41 -0800
Message-ID: <20190227224642.1069138-6-andriin@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190227224642.1069138-1-andriin@fb.com>
References: <20190227224642.1069138-1-andriin@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-27_15:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch adds a btf_dedup test exercising logic of STRUCT<->FWD
resolution and validating that STRUCT is not resolved to a FWD. It also
forces hash collisions, forcing both FWD and STRUCT to be candidates for
each other. Previously this condition caused infinite loop due to FWD
pointing to STRUCT and STRUCT pointing to its FWD.

Reported-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Andrii Nakryiko <andriin@fb.com>
---
 tools/testing/selftests/bpf/test_btf.c | 45 ++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/tools/testing/selftests/bpf/test_btf.c b/tools/testing/selftests/bpf/test_btf.c
index 1426c0a905c8..38797aa627a7 100644
--- a/tools/testing/selftests/bpf/test_btf.c
+++ b/tools/testing/selftests/bpf/test_btf.c
@@ -5731,6 +5731,51 @@ const struct btf_dedup_test dedup_tests[] = {
 		.dont_resolve_fwds = false,
 	},
 },
+{
+	.descr = "dedup: struct <-> fwd resolution w/ hash collision",
+	/*
+	 * // CU 1:
+	 * struct x;
+	 * struct s {
+	 *	struct x *x;
+	 * };
+	 * // CU 2:
+	 * struct x {};
+	 * struct s {
+	 *	struct x *x;
+	 * };
+	 */
+	.input = {
+		.raw_types = {
+			/* CU 1 */
+			BTF_FWD_ENC(NAME_TBD, 0 /* struct fwd */),	/* [1] fwd x      */
+			BTF_PTR_ENC(1),					/* [2] ptr -> [1] */
+			BTF_STRUCT_ENC(NAME_TBD, 1, 8),			/* [3] struct s   */
+				BTF_MEMBER_ENC(NAME_TBD, 2, 0),
+			/* CU 2 */
+			BTF_STRUCT_ENC(NAME_TBD, 0, 0),			/* [4] struct x   */
+			BTF_PTR_ENC(4),					/* [5] ptr -> [4] */
+			BTF_STRUCT_ENC(NAME_TBD, 1, 8),			/* [6] struct s   */
+				BTF_MEMBER_ENC(NAME_TBD, 5, 0),
+			BTF_END_RAW,
+		},
+		BTF_STR_SEC("\0x\0s\0x\0x\0s\0x\0"),
+	},
+	.expect = {
+		.raw_types = {
+			BTF_PTR_ENC(3),					/* [1] ptr -> [3] */
+			BTF_STRUCT_ENC(NAME_TBD, 1, 8),			/* [2] struct s   */
+				BTF_MEMBER_ENC(NAME_TBD, 1, 0),
+			BTF_STRUCT_ENC(NAME_NTH(2), 0, 0),		/* [3] struct x   */
+			BTF_END_RAW,
+		},
+		BTF_STR_SEC("\0s\0x"),
+	},
+	.opts = {
+		.dont_resolve_fwds = false,
+		.dedup_table_size = 1, /* force hash collisions */
+	},
+},
 {
 	.descr = "dedup: all possible kinds (no duplicates)",
 	.input = {
-- 
2.17.1

