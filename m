Return-Path: <SRS0=W4j7=SA=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FC6AC43381
	for <bpf@archiver.kernel.org>; Fri, 29 Mar 2019 05:30:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FAA52173C
	for <bpf@archiver.kernel.org>; Fri, 29 Mar 2019 05:30:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="HBqJeU1l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728674AbfC2Fa4 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 29 Mar 2019 01:30:56 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:59588 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726016AbfC2Fa4 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 29 Mar 2019 01:30:56 -0400
Received: from pps.filterd (m0044008.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2T5SLVO002003
        for <bpf@vger.kernel.org>; Thu, 28 Mar 2019 22:30:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=facebook;
 bh=JtmE7GZ3/nA/E6+3sYmcFgUtwxPpfaoxSfAqKNSFPN0=;
 b=HBqJeU1l/y6Ke3D4VNbQ3xYOoF2F/1mjqfHMCTVUPhijq25fiyeKlFG8USzx3A8UXfd8
 DzbUBa2CtVfCQtGh3w+mzscua6pbCxClO7JQ1+MI1lDmX7v4bsXLAMBmTNagL0UKIKNk
 9mWWXLnpacxDgKlLFjuA0uiNtUEaxe4zTSg= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2rhb9wrdys-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 28 Mar 2019 22:30:55 -0700
Received: from mx-out.facebook.com (2620:10d:c081:10::13) by
 mail.thefacebook.com (2620:10d:c081:35::130) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5;
 Thu, 28 Mar 2019 22:30:54 -0700
Received: by devbig003.ftw2.facebook.com (Postfix, from userid 128203)
        id D433B3702C78; Thu, 28 Mar 2019 22:30:53 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Yonghong Song <yhs@fb.com>
Smtp-Origin-Hostname: devbig003.ftw2.facebook.com
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>
CC:     Alexei Starovoitov <ast@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>,
        Yonghong Song <yhs@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH bpf-next] [tools/bpf] add bpffs multi-dimensional array tests in test_btf
Date:   Thu, 28 Mar 2019 22:30:53 -0700
Message-ID: <20190329053053.3968514-1-yhs@fb.com>
X-Mailer: git-send-email 2.17.1
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-29_03:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

For multiple dimensional arrays like below,
  int a[2][3]
both llvm and pahole generated one BTF_KIND_ARRAY type like
  . element_type: int
  . index_type: unsigned int
  . number of elements: 6

Such a collapsed BTF_KIND_ARRAY type will cause the divergence
in BTF vs. the user code. In the compile-once-run-everywhere
project, the header file is generated from BTF and used for bpf
program, and the definition in the header file will be different
from what user expects.

But the kernel actually supports chained multi-dimensional array
types properly. The above "int a[2][3]" can be represented as
  Type #n:
    . element_type: int
    . index_type: unsigned int
    . number of elements: 3
  Type #(n+1):
    . element_type: type #n
    . index_type: unsigned int
    . number of elements: 2

The following llvm commit
  https://reviews.llvm.org/rL357215
also enables llvm to generated proper chained multi-dimensional arrays.

The test_btf already has a raw test ("struct test #1") for chained
multi-dimensional arrays. This patch added amended bpffs test for
chained multi-dimensional arrays.

Acked-by: Martin KaFai Lau <kafai@fb.com>
Signed-off-by: Yonghong Song <yhs@fb.com>
---
 tools/testing/selftests/bpf/test_btf.c | 32 +++++++++++++++++++-------
 1 file changed, 24 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_btf.c b/tools/testing/selftests/bpf/test_btf.c
index 23e3b314ca60..5afc3f7dff81 100644
--- a/tools/testing/selftests/bpf/test_btf.c
+++ b/tools/testing/selftests/bpf/test_btf.c
@@ -3677,6 +3677,7 @@ struct pprint_mapv {
 	} aenum;
 	uint32_t ui32b;
 	uint32_t bits2c:2;
+	uint8_t si8_4[2][2];
 };
 
 #ifdef __SIZEOF_INT128__
@@ -3729,7 +3730,7 @@ static struct btf_raw_test pprint_test_template[] = {
 		BTF_ENUM_ENC(NAME_TBD, 2),
 		BTF_ENUM_ENC(NAME_TBD, 3),
 		/* struct pprint_mapv */		/* [16] */
-		BTF_TYPE_ENC(NAME_TBD, BTF_INFO_ENC(BTF_KIND_STRUCT, 0, 10), 40),
+		BTF_TYPE_ENC(NAME_TBD, BTF_INFO_ENC(BTF_KIND_STRUCT, 0, 11), 40),
 		BTF_MEMBER_ENC(NAME_TBD, 11, 0),	/* uint32_t ui32 */
 		BTF_MEMBER_ENC(NAME_TBD, 10, 32),	/* uint16_t ui16 */
 		BTF_MEMBER_ENC(NAME_TBD, 12, 64),	/* int32_t si32 */
@@ -3740,9 +3741,12 @@ static struct btf_raw_test pprint_test_template[] = {
 		BTF_MEMBER_ENC(NAME_TBD, 15, 192),	/* aenum */
 		BTF_MEMBER_ENC(NAME_TBD, 11, 224),	/* uint32_t ui32b */
 		BTF_MEMBER_ENC(NAME_TBD, 6, 256),	/* bits2c */
+		BTF_MEMBER_ENC(NAME_TBD, 17, 264),	/* si8_4 */
+		BTF_TYPE_ARRAY_ENC(18, 1, 2),		/* [17] */
+		BTF_TYPE_ARRAY_ENC(1, 1, 2),		/* [18] */
 		BTF_END_RAW,
 	},
-	BTF_STR_SEC("\0unsigned char\0unsigned short\0unsigned int\0int\0unsigned long long\0uint8_t\0uint16_t\0uint32_t\0int32_t\0uint64_t\0ui64\0ui8a\0ENUM_ZERO\0ENUM_ONE\0ENUM_TWO\0ENUM_THREE\0pprint_mapv\0ui32\0ui16\0si32\0unused_bits2a\0bits28\0unused_bits2b\0aenum\0ui32b\0bits2c"),
+	BTF_STR_SEC("\0unsigned char\0unsigned short\0unsigned int\0int\0unsigned long long\0uint8_t\0uint16_t\0uint32_t\0int32_t\0uint64_t\0ui64\0ui8a\0ENUM_ZERO\0ENUM_ONE\0ENUM_TWO\0ENUM_THREE\0pprint_mapv\0ui32\0ui16\0si32\0unused_bits2a\0bits28\0unused_bits2b\0aenum\0ui32b\0bits2c\0si8_4"),
 	.key_size = sizeof(unsigned int),
 	.value_size = sizeof(struct pprint_mapv),
 	.key_type_id = 3,	/* unsigned int */
@@ -3791,7 +3795,7 @@ static struct btf_raw_test pprint_test_template[] = {
 		BTF_ENUM_ENC(NAME_TBD, 2),
 		BTF_ENUM_ENC(NAME_TBD, 3),
 		/* struct pprint_mapv */		/* [16] */
-		BTF_TYPE_ENC(NAME_TBD, BTF_INFO_ENC(BTF_KIND_STRUCT, 1, 10), 40),
+		BTF_TYPE_ENC(NAME_TBD, BTF_INFO_ENC(BTF_KIND_STRUCT, 1, 11), 40),
 		BTF_MEMBER_ENC(NAME_TBD, 11, BTF_MEMBER_OFFSET(0, 0)),	/* uint32_t ui32 */
 		BTF_MEMBER_ENC(NAME_TBD, 10, BTF_MEMBER_OFFSET(0, 32)),	/* uint16_t ui16 */
 		BTF_MEMBER_ENC(NAME_TBD, 12, BTF_MEMBER_OFFSET(0, 64)),	/* int32_t si32 */
@@ -3802,9 +3806,12 @@ static struct btf_raw_test pprint_test_template[] = {
 		BTF_MEMBER_ENC(NAME_TBD, 15, BTF_MEMBER_OFFSET(0, 192)),	/* aenum */
 		BTF_MEMBER_ENC(NAME_TBD, 11, BTF_MEMBER_OFFSET(0, 224)),	/* uint32_t ui32b */
 		BTF_MEMBER_ENC(NAME_TBD, 6, BTF_MEMBER_OFFSET(2, 256)),	/* bits2c */
+		BTF_MEMBER_ENC(NAME_TBD, 17, 264),	/* si8_4 */
+		BTF_TYPE_ARRAY_ENC(18, 1, 2),		/* [17] */
+		BTF_TYPE_ARRAY_ENC(1, 1, 2),		/* [18] */
 		BTF_END_RAW,
 	},
-	BTF_STR_SEC("\0unsigned char\0unsigned short\0unsigned int\0int\0unsigned long long\0uint8_t\0uint16_t\0uint32_t\0int32_t\0uint64_t\0ui64\0ui8a\0ENUM_ZERO\0ENUM_ONE\0ENUM_TWO\0ENUM_THREE\0pprint_mapv\0ui32\0ui16\0si32\0unused_bits2a\0bits28\0unused_bits2b\0aenum\0ui32b\0bits2c"),
+	BTF_STR_SEC("\0unsigned char\0unsigned short\0unsigned int\0int\0unsigned long long\0uint8_t\0uint16_t\0uint32_t\0int32_t\0uint64_t\0ui64\0ui8a\0ENUM_ZERO\0ENUM_ONE\0ENUM_TWO\0ENUM_THREE\0pprint_mapv\0ui32\0ui16\0si32\0unused_bits2a\0bits28\0unused_bits2b\0aenum\0ui32b\0bits2c\0si8_4"),
 	.key_size = sizeof(unsigned int),
 	.value_size = sizeof(struct pprint_mapv),
 	.key_type_id = 3,	/* unsigned int */
@@ -3855,7 +3862,7 @@ static struct btf_raw_test pprint_test_template[] = {
 		BTF_ENUM_ENC(NAME_TBD, 2),
 		BTF_ENUM_ENC(NAME_TBD, 3),
 		/* struct pprint_mapv */		/* [16] */
-		BTF_TYPE_ENC(NAME_TBD, BTF_INFO_ENC(BTF_KIND_STRUCT, 1, 10), 40),
+		BTF_TYPE_ENC(NAME_TBD, BTF_INFO_ENC(BTF_KIND_STRUCT, 1, 11), 40),
 		BTF_MEMBER_ENC(NAME_TBD, 11, BTF_MEMBER_OFFSET(0, 0)),	/* uint32_t ui32 */
 		BTF_MEMBER_ENC(NAME_TBD, 10, BTF_MEMBER_OFFSET(0, 32)),	/* uint16_t ui16 */
 		BTF_MEMBER_ENC(NAME_TBD, 12, BTF_MEMBER_OFFSET(0, 64)),	/* int32_t si32 */
@@ -3866,13 +3873,16 @@ static struct btf_raw_test pprint_test_template[] = {
 		BTF_MEMBER_ENC(NAME_TBD, 15, BTF_MEMBER_OFFSET(0, 192)),	/* aenum */
 		BTF_MEMBER_ENC(NAME_TBD, 11, BTF_MEMBER_OFFSET(0, 224)),	/* uint32_t ui32b */
 		BTF_MEMBER_ENC(NAME_TBD, 17, BTF_MEMBER_OFFSET(2, 256)),	/* bits2c */
+		BTF_MEMBER_ENC(NAME_TBD, 20, BTF_MEMBER_OFFSET(0, 264)),	/* si8_4 */
 		/* typedef unsigned int ___int */	/* [17] */
 		BTF_TYPEDEF_ENC(NAME_TBD, 18),
 		BTF_TYPE_ENC(0, BTF_INFO_ENC(BTF_KIND_VOLATILE, 0, 0), 6),	/* [18] */
 		BTF_TYPE_ENC(0, BTF_INFO_ENC(BTF_KIND_CONST, 0, 0), 15),	/* [19] */
+		BTF_TYPE_ARRAY_ENC(21, 1, 2),					/* [20] */
+		BTF_TYPE_ARRAY_ENC(1, 1, 2),					/* [21] */
 		BTF_END_RAW,
 	},
-	BTF_STR_SEC("\0unsigned char\0unsigned short\0unsigned int\0int\0unsigned long long\0uint8_t\0uint16_t\0uint32_t\0int32_t\0uint64_t\0ui64\0ui8a\0ENUM_ZERO\0ENUM_ONE\0ENUM_TWO\0ENUM_THREE\0pprint_mapv\0ui32\0ui16\0si32\0unused_bits2a\0bits28\0unused_bits2b\0aenum\0ui32b\0bits2c\0___int"),
+	BTF_STR_SEC("\0unsigned char\0unsigned short\0unsigned int\0int\0unsigned long long\0uint8_t\0uint16_t\0uint32_t\0int32_t\0uint64_t\0ui64\0ui8a\0ENUM_ZERO\0ENUM_ONE\0ENUM_TWO\0ENUM_THREE\0pprint_mapv\0ui32\0ui16\0si32\0unused_bits2a\0bits28\0unused_bits2b\0aenum\0ui32b\0bits2c\0___int\0si8_4"),
 	.key_size = sizeof(unsigned int),
 	.value_size = sizeof(struct pprint_mapv),
 	.key_type_id = 3,	/* unsigned int */
@@ -4007,6 +4017,10 @@ static void set_pprint_mapv(enum pprint_mapv_kind_t mapv_kind,
 			v->aenum = i & 0x03;
 			v->ui32b = 4;
 			v->bits2c = 1;
+			v->si8_4[0][0] = (cpu + i) & 0xff;
+			v->si8_4[0][1] = (cpu + i + 1) & 0xff;
+			v->si8_4[1][0] = (cpu + i + 2) & 0xff;
+			v->si8_4[1][1] = (cpu + i + 3) & 0xff;
 			v = (void *)v + rounded_value_size;
 		}
 	}
@@ -4040,7 +4054,7 @@ ssize_t get_pprint_expected_line(enum pprint_mapv_kind_t mapv_kind,
 		nexpected_line = snprintf(expected_line, line_size,
 					  "%s%u: {%u,0,%d,0x%x,0x%x,0x%x,"
 					  "{%lu|[%u,%u,%u,%u,%u,%u,%u,%u]},%s,"
-					  "%u,0x%x}\n",
+					  "%u,0x%x,[[%d,%d],[%d,%d]]}\n",
 					  percpu_map ? "\tcpu" : "",
 					  percpu_map ? cpu : next_key,
 					  v->ui32, v->si32,
@@ -4054,7 +4068,9 @@ ssize_t get_pprint_expected_line(enum pprint_mapv_kind_t mapv_kind,
 					  v->ui8a[6], v->ui8a[7],
 					  pprint_enum_str[v->aenum],
 					  v->ui32b,
-					  v->bits2c);
+					  v->bits2c,
+					  v->si8_4[0][0], v->si8_4[0][1],
+					  v->si8_4[1][0], v->si8_4[1][1]);
 	}
 
 #ifdef __SIZEOF_INT128__
-- 
2.17.1

