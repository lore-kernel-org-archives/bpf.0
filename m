Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16711C46467
	for <bpf@archiver.kernel.org>; Mon,  9 May 2022 01:29:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234255AbiEIBbD convert rfc822-to-8bit (ORCPT
        <rfc822;bpf@archiver.kernel.org>); Sun, 8 May 2022 21:31:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235652AbiEIAp6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 8 May 2022 20:45:58 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F304F6430
        for <bpf@vger.kernel.org>; Sun,  8 May 2022 17:42:06 -0700 (PDT)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 248NpBZq023563
        for <bpf@vger.kernel.org>; Sun, 8 May 2022 17:42:06 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3fwpgw5pm8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Sun, 08 May 2022 17:42:06 -0700
Received: from twshared3657.05.prn5.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::e) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sun, 8 May 2022 17:42:05 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 71CA019A4AD12; Sun,  8 May 2022 17:41:59 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH bpf-next 5/9] libbpf: complete field-based CO-RE helpers with field offset helper
Date:   Sun, 8 May 2022 17:41:44 -0700
Message-ID: <20220509004148.1801791-6-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220509004148.1801791-1-andrii@kernel.org>
References: <20220509004148.1801791-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: xVSkajYUkcPtJ0iRG4G-7bggQykcWkXX
X-Proofpoint-GUID: xVSkajYUkcPtJ0iRG4G-7bggQykcWkXX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-08_09,2022-05-06_01,2022-02-23_01
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add bpf_core_field_offset() helper to complete field-based CO-RE
helpers. This helper can be useful for feature-detection and for some
more advanced cases of field reading (e.g., reading flexible array members).

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/bpf_core_read.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/tools/lib/bpf/bpf_core_read.h b/tools/lib/bpf/bpf_core_read.h
index 5ad415f9051f..fd48b1ff59ca 100644
--- a/tools/lib/bpf/bpf_core_read.h
+++ b/tools/lib/bpf/bpf_core_read.h
@@ -143,6 +143,18 @@ enum bpf_enum_value_kind {
 #define bpf_core_field_size(field...)					    \
 	__builtin_preserve_field_info(___bpf_field_ref(field), BPF_FIELD_BYTE_SIZE)
 
+/*
+ * Convenience macro to get field's byte offset.
+ *
+ * Supports two forms:
+ *   - field reference through variable access:
+ *     bpf_core_field_offset(p->my_field);
+ *   - field reference through type and field names:
+ *     bpf_core_field_offset(struct my_type, my_field).
+ */
+#define bpf_core_field_offset(field...)					    \
+	__builtin_preserve_field_info(___bpf_field_ref(field), BPF_FIELD_BYTE_OFFSET)
+
 /*
  * Convenience macro to get BTF type ID of a specified type, using a local BTF
  * information. Return 32-bit unsigned integer with type ID from program's own
-- 
2.30.2

