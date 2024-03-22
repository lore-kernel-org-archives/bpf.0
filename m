Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A57B835894
	for <bpf@vger.kernel.org>; Fri, 22 Mar 2024 10:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711103150; cv=none; b=frPyHg0OxyW7lq8k+3xa0KswE0fylybEwRiPYb/btynoyloR3KwDQvYEFxm2jWQ2siMZ7jbcK/1EE5R+Z94J77VL3ks0i+pin+VWAPBoQSVCHfAk9pwcSBpGGU9man/O7TX9Nsnfev4eNdXr7M5JWQU61ckherQSIifueh7vnG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711103150; c=relaxed/simple;
	bh=vWEQBd8xcEb7zV27EDAbn5yqwyq0ylbwxQUTICfJHcY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FYW64mHgiDwymD+JzSFH4vY9BSNm2l00Ml8hEMIfkWsDRcEi8JAJSTA/kA1X5mI2Y2IyodXFOnF/f9wnlwXHuRFUk9Cq4jnNZGSWHmfCp7S6muuBe8yUsSzLOpUZVXVrOB7cjf7pUk1BDMuWxRTVADYvpnO2Nra+i1lEghtDbNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Hfp9aqx3; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Hfp9aqx3"
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42M7YhST032212;
	Fri, 22 Mar 2024 10:25:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-11-20;
 bh=y0D0PHGL1EKKXsxRVGGW77JEHn5ciiwrj/9NYr+rrrU=;
 b=Hfp9aqx3/pYgMJdwjKY6qtILaocOcbPtkEhTWJFNGc3wWOp0EY4pX/NXJ4/maTuJn7iI
 RnwijlDVrXpN2hO1wqn5GEypiuyD/AVBUwnQwTu0toorxM/X19FpO7F0GYM/vgL7LiBO
 RmNyM36sy5V5Q+cJmM4CNN9o6zlVOHSqJ5SiU8/3IrcN+U2bN2+VPN3UIs/v9w4R6U46
 gKKqIekOfoysDyeShR3wNhyIr+ITLhytWi5ZO/osgz5E0RE87O29VOpmWsbHyXa2DYJo
 INjGUuKg6JlUcnCJwRS7DgPn9TR/b6qz1oGgDHoHJLHUDWwnK1pk8OL0a6v76Bz6q/df UQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3x0wvqrs7r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 22 Mar 2024 10:25:23 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42M9IrXs015200;
	Fri, 22 Mar 2024 10:25:22 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3x0wvk2hh7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 22 Mar 2024 10:25:22 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 42MAK0kV030399;
	Fri, 22 Mar 2024 10:25:21 GMT
Received: from bpf.uk.oracle.com (dhcp-10-175-192-105.vpn.oracle.com [10.175.192.105])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3x0wvk2h75-5;
	Fri, 22 Mar 2024 10:25:21 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: andrii@kernel.org, jolsa@kernel.org, acme@redhat.com,
        quentin@isovalent.com
Cc: eddyz87@gmail.com, mykolal@fb.com, ast@kernel.org, daniel@iogearbox.net,
        martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, houtao1@huawei.com, bpf@vger.kernel.org,
        masahiroy@kernel.org, mcgrof@kernel.org, nathan@kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [RFC bpf-next 03/13] selftests/bpf: test split base reference BTF generation
Date: Fri, 22 Mar 2024 10:24:45 +0000
Message-Id: <20240322102455.98558-5-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240322102455.98558-1-alan.maguire@oracle.com>
References: <20240322102455.98558-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-22_06,2024-03-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 mlxscore=0
 malwarescore=0 suspectscore=0 spamscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2403210000
 definitions=main-2403220074
X-Proofpoint-ORIG-GUID: bGWiUUexOgqhF_yv-dh1u3TcptFNjVuC
X-Proofpoint-GUID: bGWiUUexOgqhF_yv-dh1u3TcptFNjVuC

Test generation of split "base reference" BTF, ensuring that

- FWDs are used in place of full named struct/union declarations
- FWDs are used in place of full named enum declarations
- anonymous struct/unions are represented in full
- anonymous enums are represented in full
- types unreferenced from split BTF are not present in base reference
  BTF

Also test that with vmlinux BTF and split BTF based upon it,
we only represent needed base types referenced from split BTF.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 .../bpf/prog_tests/btf_split_base_ref.c       | 219 ++++++++++++++++++
 1 file changed, 219 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/btf_split_base_ref.c

diff --git a/tools/testing/selftests/bpf/prog_tests/btf_split_base_ref.c b/tools/testing/selftests/bpf/prog_tests/btf_split_base_ref.c
new file mode 100644
index 000000000000..d611167fa4b2
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/btf_split_base_ref.c
@@ -0,0 +1,219 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2024, Oracle and/or its affiliates. */
+
+#include <test_progs.h>
+#include <bpf/btf.h>
+#include "btf_helpers.h"
+
+/* Fabricate base, split BTF with references to base types needed; then create
+ * split BTF with reference base BTF and ensure expectations are met:
+ *  - only referenced base types from split BTF are present
+ *  - struct/union/enum are represented as FWDs unless anonymous, when they
+ *    are represented in full
+ */
+static void test_split_base_ref(void)
+{
+	struct btf *btf1 = NULL, *btf2 = NULL, *btf3 = NULL, *btf4 = NULL;
+
+	btf1 = btf__new_empty();
+	if (!ASSERT_OK_PTR(btf1, "empty_main_btf"))
+		return;
+
+	btf__add_int(btf1, "int", 4, BTF_INT_SIGNED);	/* [1] int */
+	btf__add_ptr(btf1, 1);				/* [2] ptr to int */
+	btf__add_struct(btf1, "s1", 8);			/* [3] struct s1 { */
+	btf__add_field(btf1, "f1", 2, 0, 0);		/*      int *f1; */
+							/* } */
+	btf__add_struct(btf1, "", 12);			/* [4] struct { */
+	btf__add_field(btf1, "f1", 1, 0, 0);		/*	int f1; */
+	btf__add_field(btf1, "f2", 3, 32, 0);		/*	struct s1 f2; */
+							/* } */
+	btf__add_int(btf1, "unsigned int", 4, 0);	/* [5] unsigned int */
+	btf__add_union(btf1, "u1", 12);			/* [6] union u1 { */
+	btf__add_field(btf1, "f1", 1, 0, 0);		/*	int f1; */
+	btf__add_field(btf1, "f2", 2, 0, 0);		/*	int *f2; */
+							/* } */
+	btf__add_union(btf1, "", 4);			/* [7] union { */
+	btf__add_field(btf1, "f1", 1, 0, 0);		/*	int f1; */
+							/* } */
+	btf__add_enum(btf1, "e1", 4);			/* [8] enum e1 { */
+	btf__add_enum_value(btf1, "v1", 1);		/*	v1 = 1; */
+							/* } */
+	btf__add_enum(btf1, "", 4);			/* [9] enum { */
+	btf__add_enum_value(btf1, "av1", 2);		/*	av1 = 2; */
+							/* } */
+	btf__add_enum64(btf1, "e641", 8, true);		/* [10] enum64 { */
+	btf__add_enum64_value(btf1, "v1", 1024);	/*	v1 = 1024; */
+							/* } */
+	btf__add_enum64(btf1, "", 8, true);		/* [11] enum64 { */
+	btf__add_enum64_value(btf1, "v1", 1025);	/*	v1 = 1025; */
+							/* } */
+	btf__add_struct(btf1, "unneeded", 4);		/* struct unneeded { */
+	btf__add_field(btf1, "f1", 1, 0, 0);		/*	int f1; */
+							/* } */
+	VALIDATE_RAW_BTF(
+		btf1,
+		"[1] INT 'int' size=4 bits_offset=0 nr_bits=32 encoding=SIGNED",
+		"[2] PTR '(anon)' type_id=1",
+		"[3] STRUCT 's1' size=8 vlen=1\n"
+		"\t'f1' type_id=2 bits_offset=0",
+		"[4] STRUCT '(anon)' size=12 vlen=2\n"
+		"\t'f1' type_id=1 bits_offset=0\n"
+		"\t'f2' type_id=3 bits_offset=32",
+		"[5] INT 'unsigned int' size=4 bits_offset=0 nr_bits=32 encoding=(none)",
+		"[6] UNION 'u1' size=12 vlen=2\n"
+		"\t'f1' type_id=1 bits_offset=0\n"
+		"\t'f2' type_id=2 bits_offset=0",
+		"[7] UNION '(anon)' size=4 vlen=1\n"
+		"\t'f1' type_id=1 bits_offset=0",
+		"[8] ENUM 'e1' encoding=UNSIGNED size=4 vlen=1\n"
+		"\t'v1' val=1",
+		"[9] ENUM '(anon)' encoding=UNSIGNED size=4 vlen=1\n"
+		"\t'av1' val=2",
+		"[10] ENUM64 'e641' encoding=SIGNED size=8 vlen=1\n"
+		"\t'v1' val=1024",
+		"[11] ENUM64 '(anon)' encoding=SIGNED size=8 vlen=1\n"
+		"\t'v1' val=1025",
+		"[12] STRUCT 'unneeded' size=4 vlen=1\n"
+		"\t'f1' type_id=1 bits_offset=0");
+
+	btf2 = btf__new_empty_split(btf1);
+	if (!ASSERT_OK_PTR(btf2, "empty_split_btf"))
+		goto cleanup;
+
+	btf__add_ptr(btf2, 3);				/* [9] ptr to struct s1 */
+	/* add ptr to struct anon */
+	btf__add_ptr(btf2, 4);				/* [10] ptr to struct (anon) */
+	btf__add_const(btf2, 6);			/* [11] const union u1 */
+	btf__add_restrict(btf2, 7);			/* [12] restrict union (anon) */
+	btf__add_volatile(btf2, 8);			/* [13] volatile enum e1 */
+	btf__add_typedef(btf2, "et", 9);		/* [14] typedef enum (anon) */
+	btf__add_const(btf2, 10);			/* [15] const enum64 e641 */
+	btf__add_ptr(btf2, 11);				/* [16] restrict enum64 (anon) */
+
+	VALIDATE_RAW_BTF(
+		btf2,
+		"[1] INT 'int' size=4 bits_offset=0 nr_bits=32 encoding=SIGNED",
+		"[2] PTR '(anon)' type_id=1",
+		"[3] STRUCT 's1' size=8 vlen=1\n"
+		"\t'f1' type_id=2 bits_offset=0",
+		"[4] STRUCT '(anon)' size=12 vlen=2\n"
+		"\t'f1' type_id=1 bits_offset=0\n"
+		"\t'f2' type_id=3 bits_offset=32",
+		"[5] INT 'unsigned int' size=4 bits_offset=0 nr_bits=32 encoding=(none)",
+		"[6] UNION 'u1' size=12 vlen=2\n"
+		"\t'f1' type_id=1 bits_offset=0\n"
+		"\t'f2' type_id=2 bits_offset=0",
+		"[7] UNION '(anon)' size=4 vlen=1\n"
+		"\t'f1' type_id=1 bits_offset=0",
+		"[8] ENUM 'e1' encoding=UNSIGNED size=4 vlen=1\n"
+		"\t'v1' val=1",
+		"[9] ENUM '(anon)' encoding=UNSIGNED size=4 vlen=1\n"
+		"\t'av1' val=2",
+		"[10] ENUM64 'e641' encoding=SIGNED size=8 vlen=1\n"
+		"\t'v1' val=1024",
+		"[11] ENUM64 '(anon)' encoding=SIGNED size=8 vlen=1\n"
+		"\t'v1' val=1025",
+		"[12] STRUCT 'unneeded' size=4 vlen=1\n"
+		"\t'f1' type_id=1 bits_offset=0",
+		"[13] PTR '(anon)' type_id=3",
+		"[14] PTR '(anon)' type_id=4",
+		"[15] CONST '(anon)' type_id=6",
+		"[16] RESTRICT '(anon)' type_id=7",
+		"[17] VOLATILE '(anon)' type_id=8",
+		"[18] TYPEDEF 'et' type_id=9",
+		"[19] CONST '(anon)' type_id=10",
+		"[20] PTR '(anon)' type_id=11");
+
+	btf3 = btf__new_split_base_ref(btf2);
+	if (!ASSERT_OK_PTR(btf1, "new_split_base_ref"))
+		goto cleanup;
+
+	btf4 = (struct btf *)btf__base_btf(btf3);
+	if (!ASSERT_OK_PTR(btf4, "base_ref_btf"))
+		goto cleanup;
+
+	VALIDATE_RAW_BTF(
+		btf3,
+		"[1] INT 'int' size=4 bits_offset=0 nr_bits=32 encoding=SIGNED",
+		"[2] FWD 's1' fwd_kind=struct",
+		"[3] STRUCT '(anon)' size=12 vlen=2\n"
+		"\t'f1' type_id=1 bits_offset=0\n"
+		"\t'f2' type_id=2 bits_offset=32",
+		"[4] FWD 'u1' fwd_kind=union",
+		"[5] UNION '(anon)' size=4 vlen=1\n"
+		"\t'f1' type_id=1 bits_offset=0",
+		"[6] ENUM 'e1' encoding=UNSIGNED size=4 vlen=0",
+		"[7] ENUM '(anon)' encoding=UNSIGNED size=4 vlen=1\n"
+		"\t'av1' val=2",
+		"[8] ENUM64 'e641' encoding=SIGNED size=8 vlen=0",
+		"[9] ENUM64 '(anon)' encoding=SIGNED size=8 vlen=1\n"
+		"\t'v1' val=1025",
+		"[10] PTR '(anon)' type_id=2",
+		"[11] PTR '(anon)' type_id=3",
+		"[12] CONST '(anon)' type_id=4",
+		"[13] RESTRICT '(anon)' type_id=5",
+		"[14] VOLATILE '(anon)' type_id=6",
+		"[15] TYPEDEF 'et' type_id=7",
+		"[16] CONST '(anon)' type_id=8",
+		"[17] PTR '(anon)' type_id=9");
+
+cleanup:
+	btf__free(btf4);
+	btf__free(btf3);
+	btf__free(btf2);
+	btf__free(btf1);
+}
+
+/* create split reference BTF from vmlinux + split BTF with a few type references;
+ * ensure the resultant split reference BTF is as expected, containing only types
+ * needed to disambiguate references from split BTF.
+ */
+static void test_split_base_ref_vmlinux(void)
+{
+	struct btf *split_btf = NULL, *vmlinux_btf = btf__load_vmlinux_btf();
+	struct btf *split_ref = NULL, *base_ref = NULL;
+	__s32 int_id, sk_buff_id;
+
+	if (!ASSERT_OK_PTR(vmlinux_btf, "load_vmlinux"))
+		return;
+	int_id = btf__find_by_name_kind(vmlinux_btf, "int", BTF_KIND_INT);
+	if (!ASSERT_GT(int_id, 0, "find_int"))
+		goto cleanup;
+	sk_buff_id = btf__find_by_name_kind(vmlinux_btf, "sk_buff", BTF_KIND_STRUCT);
+	if (!ASSERT_GT(sk_buff_id, 0, "find_sk_buff_id"))
+		goto cleanup;
+	split_btf = btf__new_empty_split(vmlinux_btf);
+	if (!ASSERT_OK_PTR(split_btf, "new_split"))
+		goto cleanup;
+	btf__add_typedef(split_btf, "myint", int_id);
+	btf__add_ptr(split_btf, sk_buff_id);
+
+	split_ref = btf__new_split_base_ref(split_btf);
+	if (!ASSERT_OK_PTR(split_ref, "new_split_base_ref"))
+		goto cleanup;
+
+	base_ref = (struct btf *)btf__base_btf(split_ref);
+	if (!ASSERT_OK_PTR(split_ref, "base_ref_btf"))
+		goto cleanup;
+	VALIDATE_RAW_BTF(
+		split_ref,
+		"[1] INT 'int' size=4 bits_offset=0 nr_bits=32 encoding=SIGNED",
+		"[2] FWD 'sk_buff' fwd_kind=struct",
+		"[3] TYPEDEF 'myint' type_id=1",
+		"[4] PTR '(anon)' type_id=2");
+
+cleanup:
+	btf__free(split_ref);
+	btf__free(base_ref);
+	btf__free(split_btf);
+	btf__free(vmlinux_btf);
+}
+
+void test_btf_split_base_ref(void)
+{
+	if (test__start_subtest("split_base_ref"))
+		test_split_base_ref();
+	if (test__start_subtest("split_base_ref_vmlinux"))
+		test_split_base_ref_vmlinux();
+}
-- 
2.39.3

