Return-Path: <SRS0=RZwz=SR=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C5FBC10F0E
	for <bpf@archiver.kernel.org>; Mon, 15 Apr 2019 23:48:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54C8E20848
	for <bpf@archiver.kernel.org>; Mon, 15 Apr 2019 23:48:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727720AbfDOXsU (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 15 Apr 2019 19:48:20 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:37120 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727456AbfDOXsN (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 15 Apr 2019 19:48:13 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3FNdntr027942
        for <bpf@vger.kernel.org>; Mon, 15 Apr 2019 16:48:13 -0700
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2rvvdu9t5q-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 15 Apr 2019 16:48:12 -0700
Received: from mx-out.facebook.com (2620:10d:c081:10::13) by
 mail.thefacebook.com (2620:10d:c081:35::126) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5;
 Mon, 15 Apr 2019 16:48:11 -0700
Received: by dev101.prn2.facebook.com (Postfix, from userid 137359)
        id 4D95286177B; Mon, 15 Apr 2019 16:48:10 -0700 (PDT)
Smtp-Origin-Hostprefix: dev
From:   <andrii.nakryiko@gmail.com>
Smtp-Origin-Hostname: dev101.prn2.facebook.com
To:     <andrii.nakryiko@gmail.com>, <netdev@vger.kernel.org>,
        <bpf@vger.kernel.org>, <kernel-team@fb.com>
CC:     Andrii Nakryiko <andriin@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Yonghong Song <yhs@fb.com>, Alexei Starovoitov <ast@fb.com>
Smtp-Origin-Cluster: prn2c23
Subject: [PATCH bpf-next 2/2] selftests/btf: add VAR and DATASEC case for dedup tests
Date:   Mon, 15 Apr 2019 16:48:08 -0700
Message-ID: <20190415234808.2225360-3-andrii.nakryiko@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190415234808.2225360-1-andrii.nakryiko@gmail.com>
References: <20190415234808.2225360-1-andrii.nakryiko@gmail.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-15_08:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Andrii Nakryiko <andriin@fb.com>

Add test case verifying that dedup happens (INTs are deduped in this
case) and VAR/DATASEC types are not deduped, but have their referenced
type IDs adjusted correctly.

Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Yonghong Song <yhs@fb.com>
Cc: Alexei Starovoitov <ast@fb.com>
Signed-off-by: Andrii Nakryiko <andriin@fb.com>
---
 tools/testing/selftests/bpf/test_btf.c | 49 ++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/tools/testing/selftests/bpf/test_btf.c b/tools/testing/selftests/bpf/test_btf.c
index 44cd3378d216..f8eb7987b794 100644
--- a/tools/testing/selftests/bpf/test_btf.c
+++ b/tools/testing/selftests/bpf/test_btf.c
@@ -6642,6 +6642,51 @@ const struct btf_dedup_test dedup_tests[] = {
 		.dont_resolve_fwds = false,
 	},
 },
+{
+	.descr = "dedup: datasec and vars pass-through",
+	.input = {
+		.raw_types = {
+			/* int */
+			BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),	/* [1] */
+			/* static int t */
+			BTF_VAR_ENC(NAME_NTH(2), 1, 0),			/* [2] */
+			/* .bss section */				/* [3] */
+			BTF_TYPE_ENC(NAME_NTH(1), BTF_INFO_ENC(BTF_KIND_DATASEC, 0, 1), 4),
+			BTF_VAR_SECINFO_ENC(2, 0, 4),
+			/* int, referenced from [5] */
+			BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),	/* [4] */
+			/* another static int t */
+			BTF_VAR_ENC(NAME_NTH(2), 4, 0),			/* [5] */
+			/* another .bss section */			/* [6] */
+			BTF_TYPE_ENC(NAME_NTH(1), BTF_INFO_ENC(BTF_KIND_DATASEC, 0, 1), 4),
+			BTF_VAR_SECINFO_ENC(5, 0, 4),
+			BTF_END_RAW,
+		},
+		BTF_STR_SEC("\0.bss\0t"),
+	},
+	.expect = {
+		.raw_types = {
+			/* int */
+			BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),	/* [1] */
+			/* static int t */
+			BTF_VAR_ENC(NAME_NTH(2), 1, 0),			/* [2] */
+			/* .bss section */				/* [3] */
+			BTF_TYPE_ENC(NAME_NTH(1), BTF_INFO_ENC(BTF_KIND_DATASEC, 0, 1), 4),
+			BTF_VAR_SECINFO_ENC(2, 0, 4),
+			/* another static int t */
+			BTF_VAR_ENC(NAME_NTH(2), 1, 0),			/* [4] */
+			/* another .bss section */			/* [5] */
+			BTF_TYPE_ENC(NAME_NTH(1), BTF_INFO_ENC(BTF_KIND_DATASEC, 0, 1), 4),
+			BTF_VAR_SECINFO_ENC(4, 0, 4),
+			BTF_END_RAW,
+		},
+		BTF_STR_SEC("\0.bss\0t"),
+	},
+	.opts = {
+		.dont_resolve_fwds = false,
+		.dedup_table_size = 1
+	},
+},
 
 };
 
@@ -6671,6 +6716,10 @@ static int btf_type_size(const struct btf_type *t)
 		return base_size + vlen * sizeof(struct btf_member);
 	case BTF_KIND_FUNC_PROTO:
 		return base_size + vlen * sizeof(struct btf_param);
+	case BTF_KIND_VAR:
+		return base_size + sizeof(struct btf_var);
+	case BTF_KIND_DATASEC:
+		return base_size + vlen * sizeof(struct btf_var_secinfo);
 	default:
 		fprintf(stderr, "Unsupported BTF_KIND:%u\n", kind);
 		return -EINVAL;
-- 
2.17.1

