Return-Path: <SRS0=YLVI=R6=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69E9DC10F00
	for <bpf@archiver.kernel.org>; Wed, 27 Mar 2019 05:00:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4273D2075E
	for <bpf@archiver.kernel.org>; Wed, 27 Mar 2019 05:00:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732266AbfC0FAP (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 27 Mar 2019 01:00:15 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:56378 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732566AbfC0FAP (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 27 Mar 2019 01:00:15 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2R4wwJo010960
        for <bpf@vger.kernel.org>; Tue, 26 Mar 2019 22:00:14 -0700
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2rft66a4dn-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 26 Mar 2019 22:00:14 -0700
Received: from mx-out.facebook.com (2620:10d:c081:10::13) by
 mail.thefacebook.com (2620:10d:c081:35::128) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5;
 Tue, 26 Mar 2019 22:00:12 -0700
Received: by dev101.prn2.facebook.com (Postfix, from userid 137359)
        id 6F2548614AD; Tue, 26 Mar 2019 22:00:12 -0700 (PDT)
Smtp-Origin-Hostprefix: dev
From:   <andrii.nakryiko@gmail.com>
Smtp-Origin-Hostname: dev101.prn2.facebook.com
To:     <andrii.nakryiko@gmail.com>, <ast@fb.com>, <yhs@fb.com>,
        <bpf@vger.kernel.org>, <netdev@vger.kernel.org>, <acme@kernel.org>,
        <kernel-team@fb.com>, <daniel@iogearbox.net>
CC:     Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Cluster: prn2c23
Subject: [PATCH bpf 2/2] selftests/bpf: add btf_dedup test for VOID equivalence check
Date:   Tue, 26 Mar 2019 22:00:07 -0700
Message-ID: <20190327050007.2419746-3-andrii.nakryiko@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190327050007.2419746-1-andrii.nakryiko@gmail.com>
References: <20190327050007.2419746-1-andrii.nakryiko@gmail.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-27_03:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Andrii Nakryiko <andriin@fb.com>

This patch adds specific test exposing bug in btf_dedup_is_equiv() when
comparing candidate VOID type to a non-VOID canonical type. It's
important for canonical type to be anonymous, otherwise name equality
check will do the right thing and will exit early.

Signed-off-by: Andrii Nakryiko <andriin@fb.com>
---
 tools/testing/selftests/bpf/test_btf.c | 47 ++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/tools/testing/selftests/bpf/test_btf.c b/tools/testing/selftests/bpf/test_btf.c
index 23e3b314ca60..ec5794e4205b 100644
--- a/tools/testing/selftests/bpf/test_btf.c
+++ b/tools/testing/selftests/bpf/test_btf.c
@@ -5776,6 +5776,53 @@ const struct btf_dedup_test dedup_tests[] = {
 		.dedup_table_size = 1, /* force hash collisions */
 	},
 },
+{
+	.descr = "dedup: void equiv check",
+	/*
+	 * // CU 1:
+	 * struct s {
+	 *	struct {} *x;
+	 * };
+	 * // CU 2:
+	 * struct s {
+	 *	int *x;
+	 * };
+	 */
+	.input = {
+		.raw_types = {
+			/* CU 1 */
+			BTF_STRUCT_ENC(0, 0, 1),				/* [1] struct {}  */
+			BTF_PTR_ENC(1),						/* [2] ptr -> [1] */
+			BTF_STRUCT_ENC(NAME_NTH(1), 1, 8),			/* [3] struct s   */
+				BTF_MEMBER_ENC(NAME_NTH(2), 2, 0),
+			/* CU 2 */
+			BTF_PTR_ENC(0),						/* [4] ptr -> void */
+			BTF_STRUCT_ENC(NAME_NTH(1), 1, 8),			/* [5] struct s   */
+				BTF_MEMBER_ENC(NAME_NTH(2), 4, 0),
+			BTF_END_RAW,
+		},
+		BTF_STR_SEC("\0s\0x"),
+	},
+	.expect = {
+		.raw_types = {
+			/* CU 1 */
+			BTF_STRUCT_ENC(0, 0, 1),				/* [1] struct {}  */
+			BTF_PTR_ENC(1),						/* [2] ptr -> [1] */
+			BTF_STRUCT_ENC(NAME_NTH(1), 1, 8),			/* [3] struct s   */
+				BTF_MEMBER_ENC(NAME_NTH(2), 2, 0),
+			/* CU 2 */
+			BTF_PTR_ENC(0),						/* [4] ptr -> void */
+			BTF_STRUCT_ENC(NAME_NTH(1), 1, 8),			/* [5] struct s   */
+				BTF_MEMBER_ENC(NAME_NTH(2), 4, 0),
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

