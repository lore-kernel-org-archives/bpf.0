Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E45B440A12
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 11:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790248522; cv=none; b=ZnEnByxlv3p5l8L45p4Hq5v8tAqP6AJYjgo/EJBTkmCT/s1sg1ePzt0OIsXlX7JtSW1+Hjz3Cxytp3073+Kpl855ZTJcGyGMR6AnNOqQFJTMdZjG3ppp1bZYx1Be3/28/uCZiWrFHnjGCVKATBo5IsTRuv90NZ0mXRHhBy1xeVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790248522; c=relaxed/simple;
	bh=VieK0c5WI+Pqy/yIXsSOqDA0O4zFTOImisZlEEBNMhI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XvFDYkrGp6m9pA235NHU9zKtRfCtsZBkXZ288kuNL6UrqEScEntRuq7HH8V/Taml/Ormmhg43dB4pj+8IixGWdSj7N7X4/XiH5g5coJUW+tEhoswHdjGoH3LLdsjkaBBVKW9cbwlsRu1oM5Z6isUG3yUYyDIjQ0FC6jvHG87EXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=eFiBmJFW; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="eFiBmJFW"
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68O6CNJc1403441;
	Thu, 24 Sep 2026 11:14:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=aLu8R
	eLVOgw864uRgF8l/yi4b+iegBoF29IKjWg3M6M=; b=eFiBmJFWKN6zdkJeBPAFR
	kujGAsuwJG9l5CINbF5VjFTf5sSU6sGrYDQD6Ygwdu+ZU8C8d3relpHj/Pw3zWtL
	pxbz1OkMN114BVQv30+AfGlR93GGmd+e8q+IiDChW08uNeiTO7TsMByobLubDIVN
	L0wttL5uN8Y/EkBUI3a6cyG5CTIsFUAUNia6mDl3yhrjzKbNR/rs3Yp5h527ZltF
	3na51APtWc2Pb3+HzmDeTVYkO1JkJA267G9e+M4p2ahNfWwkDeRRgD4gPGcQRRO1
	efPi7rf3Kv7t8Wj0d+OY9SSiWyGKJpYTMGjIIfz82ZQx1vx/xNQ75nbienU//jWS
	g==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4gsk0h7fdv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Sep 2026 11:14:51 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 68OB5W7J013046;
	Thu, 24 Sep 2026 11:14:50 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4guf119m16-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Sep 2026 11:14:50 +0000 (GMT)
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 68OBEVuF002821;
	Thu, 24 Sep 2026 11:14:50 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-80-22.vpn.oracle.com [10.154.80.22])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4guf119knh-6;
	Thu, 24 Sep 2026 11:14:49 +0000 (GMT)
From: Alan Maguire <alan.maguire@oracle.com>
To: ast@kernel.org, andrii@kernel.org, eddyz87@gmail.com, qmo@kernel.org
Cc: jolsa@kernel.org, daniel@iogearbox.net, ihor.solodrai@linux.dev,
        yonghong.song@linux.dev, song@kernel.org, martin.lau@linux.dev,
        memxor@gmail.com, emil@etsalapatis.com, bpf@vger.kernel.org,
        nsc@kernel.org, puranjay@kernel.org, yatsenko@meta.com,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v4 bpf-next 05/11] selftests/bpf: Add LOC_PARAM, LOC_PROTO, LOCSEC to dedup split tests
Date: Thu, 24 Sep 2026 12:14:22 +0100
Message-ID: <20260924111428.75957-6-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20260924111428.75957-1-alan.maguire@oracle.com>
References: <20260924111428.75957-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-24_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 spamscore=0 bulkscore=0 lowpriorityscore=0 malwarescore=0 suspectscore=0
 mlxscore=0 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2609040000 definitions=main-2609240046
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDA0NiBTYWx0ZWRfX5rsLS9Mn8Dpw
 AkZ6dP3pptuYRYhxQC58GZH7YSJtVuI5Oh81CgO97DP8SGtSU0uwz5DfvG/s/MCO1ZJMqfYBH9v
 JEM2tWS8GBQXsAskmfVGduN83f6k092DlfQwX76Xj1GztJB7c7lM
X-Proofpoint-GUID: q3CdrS-0JvhRE82PdKY6sO6ySNYcBJUB
X-Authority-Analysis: v=2.4 cv=CNa/zhrD c=1 sm=1 tr=0 ts=6ab5062b b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=BqU2WV_vvsyTyxaotp0D:22 a=yPCof4ZbAAAA:8 a=pGLkceISAAAA:8
 a=X5_qelBVQC06SepyS9QA:9 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22
 cc=ntf awl=host:12106
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDA0NiBTYWx0ZWRfX4TX9pyyBZcly
 XLrt71hvTAmdKodXjBmf3yDa12HavPXnvhc2IHGGLNUmbEWAcEID/3kAwfDDCRTN6qJUWenyP65
 TUUdJx6CdVunqKmm4+ek23BKDW38MO5ysZPZg0EVtCbhYCdi2uogxmC6DoRmoy+aKvpdN2MD+LY
 WmjQVYO0N3b0udgzVFod8ynMtLlpIWbEZBusb2OIQLRErGxkrr4M38q+el9vYFW9CQKxmm4lpgM
 BCG0coKUrQZV5/3g/eS79X1uk0LdOS8+oruBFFRtJNlOV3lp62zq0XhaSHH0hutGhFOPYJEuy3z
 OZyyUoq6rKi8tEUqWIBpYVwdj1rooJsB9W064vS5B6anyIXUVZAE/MsPDSJ2pq1deoAKpPHUNsL
 PyKVOERvLOpqwgVsFsSKcbzw/IJip1BHbCOM59Ajob1gypqpbqYgbEB5V9C8eMwe9RKke4Zv+J7
 c1kdyLEeGAfOfih+xTPWpuppKDqMuYgkBOnWzafs=
X-Proofpoint-ORIG-GUID: q3CdrS-0JvhRE82PdKY6sO6ySNYcBJUB

Ensure that location params/protos are deduplicated and location
sections are not, and that references to deduplicated locations within
location prototypes and sections are updated after deduplication.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
---
 .../bpf/prog_tests/btf_dedup_split.c          | 116 ++++++++++++++++++
 1 file changed, 116 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/btf_dedup_split.c b/tools/testing/selftests/bpf/prog_tests/btf_dedup_split.c
index 9d6161151593..5c15a6b7f4fb 100644
--- a/tools/testing/selftests/bpf/prog_tests/btf_dedup_split.c
+++ b/tools/testing/selftests/bpf/prog_tests/btf_dedup_split.c
@@ -554,6 +554,120 @@ static void test_split_module(void)
 	btf__free(vmlinux_btf);
 }
 
+static void test_split_loc(void)
+{
+	struct btf *btf1, *btf2;
+	int err;
+
+	btf1 = btf__new_empty();
+	if (!ASSERT_OK_PTR(btf1, "empty_main_btf"))
+		return;
+
+	btf__set_pointer_size(btf1, 8); /* enforce 64-bit arch */
+
+
+	btf__add_int(btf1, "long", 8, BTF_INT_SIGNED);  /* [1] long */
+	btf__add_ptr(btf1, 1);                          /* [2] ptr to long */
+	btf__add_func_proto(btf1, 1);			/* [3] long (*)(long, long *); */
+	btf__add_func_param(btf1, "p1", 1);
+	btf__add_func_param(btf1, "p2", 2);
+	btf__add_func(btf1, "foo", BTF_FUNC_STATIC, 3);	/* [4] long foo(long, long *); */
+	btf__add_loc_param(btf1, 8, BTF_LOC_PARAM_CONST);
+	btf__add_loc_param_value(btf1, 3735928559);
+	btf__add_loc_param_value(btf1, 4277009102);	/* [5] loc value */
+	btf__add_loc_param(btf1, 8, BTF_LOC_PARAM_REG);	/* [6] loc reg 1 */
+	btf__add_loc_param_value(btf1, 1);
+	btf__add_loc_proto(btf1);			/* [7] loc proto */
+	btf__add_loc_proto_param(btf1, 5);		/*  param value */
+	btf__add_loc_proto_param(btf1, 6);		/*  param reg 1 */
+
+	VALIDATE_RAW_BTF(
+		btf1,
+		"[1] INT 'long' size=8 bits_offset=0 nr_bits=64 encoding=SIGNED",
+		"[2] PTR '(anon)' type_id=1",
+		"[3] FUNC_PROTO '(anon)' ret_type_id=1 vlen=2\n"
+		"\t'p1' type_id=1\n"
+		"\t'p2' type_id=2",
+		"[4] FUNC 'foo' type_id=3 linkage=static",
+		"[5] LOC_PARAM '(anon)' size=8 flags=0x2 vlen=2\n"
+		"\tvalue=3735928559\n"
+		"\tvalue=4277009102",
+		"[6] LOC_PARAM '(anon)' size=8 flags=0x8 vlen=1\n"
+		"\tvalue=1",
+		"[7] LOC_PROTO '(anon)' vlen=2\n"
+		"\ttype_id=5\n"
+		"\ttype_id=6");
+
+	btf2 = btf__new_empty_split(btf1);
+	if (!ASSERT_OK_PTR(btf2, "empty_split_btf"))
+		goto cleanup;
+	btf__add_loc_param(btf2, 8, BTF_LOC_PARAM_REG);
+	btf__add_loc_param_value(btf2, 1);		/* [8] loc reg 1 */
+	btf__add_loc_proto(btf2);			/* [9] loc proto */
+	btf__add_loc_proto_param(btf2, 5);		/* param value */
+	btf__add_loc_proto_param(btf2, 8);		/* param reg 1 */
+	btf__add_locsec(btf2, "inline.text");		/* [10] locsec "inline.text" */
+	/* add duplicate locsec */
+	btf__add_locsec_loc(btf2, 4, 9, 128);
+	btf__add_locsec(btf2, "inline.text");		/* [11] locsec "inline.text" */
+	btf__add_locsec_loc(btf2, 4, 9, 128);
+
+	VALIDATE_RAW_BTF(
+		btf2,
+		"[1] INT 'long' size=8 bits_offset=0 nr_bits=64 encoding=SIGNED",
+		"[2] PTR '(anon)' type_id=1",
+		"[3] FUNC_PROTO '(anon)' ret_type_id=1 vlen=2\n"
+		"\t'p1' type_id=1\n"
+		"\t'p2' type_id=2",
+		"[4] FUNC 'foo' type_id=3 linkage=static",
+		"[5] LOC_PARAM '(anon)' size=8 flags=0x2 vlen=2\n"
+		"\tvalue=3735928559\n"
+		"\tvalue=4277009102",
+		"[6] LOC_PARAM '(anon)' size=8 flags=0x8 vlen=1\n"
+		"\tvalue=1",
+		"[7] LOC_PROTO '(anon)' vlen=2\n"
+		"\ttype_id=5\n"
+		"\ttype_id=6",
+		"[8] LOC_PARAM '(anon)' size=8 flags=0x8 vlen=1\n"
+		"\tvalue=1",
+		"[9] LOC_PROTO '(anon)' vlen=2\n"
+		"\ttype_id=5\n"
+		"\ttype_id=8",
+		"[10] LOCSEC 'inline.text' vlen=1\n"
+		"\tfunc_type_id=4 loc_proto_type_id=9 offset=128",
+		"[11] LOCSEC 'inline.text' vlen=1\n"
+		"\tfunc_type_id=4 loc_proto_type_id=9 offset=128");
+
+	err = btf__dedup(btf2, NULL);
+	if (!ASSERT_OK(err, "btf_dedup"))
+		goto cleanup;
+
+	VALIDATE_RAW_BTF(
+		btf2,
+		"[1] INT 'long' size=8 bits_offset=0 nr_bits=64 encoding=SIGNED",
+		"[2] PTR '(anon)' type_id=1",
+		"[3] FUNC_PROTO '(anon)' ret_type_id=1 vlen=2\n"
+		"\t'p1' type_id=1\n"
+		"\t'p2' type_id=2",
+		"[4] FUNC 'foo' type_id=3 linkage=static",
+		"[5] LOC_PARAM '(anon)' size=8 flags=0x2 vlen=2\n"
+		"\tvalue=3735928559\n"
+		"\tvalue=4277009102",
+		"[6] LOC_PARAM '(anon)' size=8 flags=0x8 vlen=1\n"
+		"\tvalue=1",
+		"[7] LOC_PROTO '(anon)' vlen=2\n"
+		"\ttype_id=5\n"
+		"\ttype_id=6",
+		"[8] LOCSEC 'inline.text' vlen=1\n"
+		"\tfunc_type_id=4 loc_proto_type_id=7 offset=128",
+		"[9] LOCSEC 'inline.text' vlen=1\n"
+		"\tfunc_type_id=4 loc_proto_type_id=7 offset=128");
+
+cleanup:
+	btf__free(btf2);
+	btf__free(btf1);
+}
+
 void test_btf_dedup_split()
 {
 	if (test__start_subtest("split_simple"))
@@ -566,4 +680,6 @@ void test_btf_dedup_split()
 		test_split_dup_struct_in_cu();
 	if (test__start_subtest("split_module"))
 		test_split_module();
+	if (test__start_subtest("split_loc"))
+		test_split_loc();
 }
-- 
2.43.5

