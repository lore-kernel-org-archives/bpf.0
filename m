Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 094E2C433FE
	for <bpf@archiver.kernel.org>; Mon,  9 May 2022 01:29:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233965AbiEIBaq convert rfc822-to-8bit (ORCPT
        <rfc822;bpf@archiver.kernel.org>); Sun, 8 May 2022 21:30:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235656AbiEIAqB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 8 May 2022 20:46:01 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F1C16430
        for <bpf@vger.kernel.org>; Sun,  8 May 2022 17:42:09 -0700 (PDT)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 248LewBJ004266
        for <bpf@vger.kernel.org>; Sun, 8 May 2022 17:42:08 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3fwpksdphq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Sun, 08 May 2022 17:42:08 -0700
Received: from twshared13579.04.prn5.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:11d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sun, 8 May 2022 17:42:07 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 5491319A4ACAD; Sun,  8 May 2022 17:41:55 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH bpf-next 3/9] libbpf: improve usability of field-based CO-RE helpers
Date:   Sun, 8 May 2022 17:41:42 -0700
Message-ID: <20220509004148.1801791-4-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220509004148.1801791-1-andrii@kernel.org>
References: <20220509004148.1801791-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: 7tMNwIek2Y06qZK2m1s1AmoutH_k-0h_
X-Proofpoint-ORIG-GUID: 7tMNwIek2Y06qZK2m1s1AmoutH_k-0h_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-08_09,2022-05-06_01,2022-02-23_01
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Allow to specify field reference in two ways:
  - if user has variable of necessary type, they can use variable-based
    reference (my_var.my_field or my_var_ptr->my_field). This was the
    only supported syntax up till now.
  - now, bpf_core_field_exists() and bpf_core_field_size() support also
    specifying field in a fashion similar to offsetof() macro, by
    specifying type of the containing struct/union separately and field
    name separately: bpf_core_field_exists(struct my_type, my_field).
    This forms is quite often more convenient in practice and it matches
    type-based CO-RE helpers that support specifying type by its name
    without requiring any variables.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/bpf_core_read.h | 25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/tools/lib/bpf/bpf_core_read.h b/tools/lib/bpf/bpf_core_read.h
index e4aa9996a550..5ad415f9051f 100644
--- a/tools/lib/bpf/bpf_core_read.h
+++ b/tools/lib/bpf/bpf_core_read.h
@@ -110,21 +110,38 @@ enum bpf_enum_value_kind {
 	val;								      \
 })
 
+#define ___bpf_field_ref1(field)	(field)
+#define ___bpf_field_ref2(type, field)	(((typeof(type) *)0)->field)
+#define ___bpf_field_ref(args...)					    \
+	___bpf_apply(___bpf_field_ref, ___bpf_narg(args))(args)
+
 /*
  * Convenience macro to check that field actually exists in target kernel's.
  * Returns:
  *    1, if matching field is present in target kernel;
  *    0, if no matching field found.
+ *
+ * Supports two forms:
+ *   - field reference through variable access:
+ *     bpf_core_field_exists(p->my_field);
+ *   - field reference through type and field names:
+ *     bpf_core_field_exists(struct my_type, my_field).
  */
-#define bpf_core_field_exists(field)					    \
-	__builtin_preserve_field_info(field, BPF_FIELD_EXISTS)
+#define bpf_core_field_exists(field...)					    \
+	__builtin_preserve_field_info(___bpf_field_ref(field), BPF_FIELD_EXISTS)
 
 /*
  * Convenience macro to get the byte size of a field. Works for integers,
  * struct/unions, pointers, arrays, and enums.
+ *
+ * Supports two forms:
+ *   - field reference through variable access:
+ *     bpf_core_field_size(p->my_field);
+ *   - field reference through type and field names:
+ *     bpf_core_field_size(struct my_type, my_field).
  */
-#define bpf_core_field_size(field)					    \
-	__builtin_preserve_field_info(field, BPF_FIELD_BYTE_SIZE)
+#define bpf_core_field_size(field...)					    \
+	__builtin_preserve_field_info(___bpf_field_ref(field), BPF_FIELD_BYTE_SIZE)
 
 /*
  * Convenience macro to get BTF type ID of a specified type, using a local BTF
-- 
2.30.2

