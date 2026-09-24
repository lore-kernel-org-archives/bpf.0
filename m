Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7E46443A9E
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 11:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790248523; cv=none; b=gIBdoNyFUVCq5ZXi6IaCACeJHJLOvhijIDuas1Piez9iH4Z0aRUzzAG+IZ/46Yu9IULrgSmuX7fmnO8rwdw3HxiG98F5xcAF+rZzWaTA5pVcdxcbG00GIbaPNIzb25TT44AMstQkIzNzV1hV0S8G0IzTuP2ku6EhLukyxb4pR40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790248523; c=relaxed/simple;
	bh=8GH9Mt1VtCS6YZUnGqExmSbBeGTAfEnEepthb0YWUVc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YZBzKDut6nMjSDgHkRPGaLuDVU4FLJ4wrgF7KmZX/yk9sVpV4vBRDr+vQ94cD21X+2rT8XhSIqCNWgJY+6NjNF+AbXnbncEUI1A8i9P01N/8ebhfKPoVXvOtHNxGt0kMwkfaQT4AjpoWu5nAK6wJnojdTD9IGQgT+v3Vu0xtkAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=lO08717k; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lO08717k"
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68O6CWxG1403713;
	Thu, 24 Sep 2026 11:14:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=6np0y
	3RETQ0VI+Qzd50+/GwJfOTgCeY8hICT8R3PR2o=; b=lO08717kfyyrNm521VKUc
	2Nw7y20Vn43uhVvbEXkM1KBD6vQiBkolalIoH/ZtaS7nWv7rdtHPBA1vgCLhsRuF
	0n0KuW6ZDmy8OHr/lucYgC53TCNsqMq28OB6D65h3XS7asN5f9M6Irmta5FpFSxK
	TgqtJy7yQIcr1S+gv0A/u5EgJ/ZuhMJEDIyvEuq0pvUoXv6sX9CV3Q/++P6EmkvM
	Joi13Y8q0/5xI0cZEK1wScToV9xYMqM97r3wifKgoArFbkpeiATVk5LDqmyzQkmf
	TCNr/KBJA9Kri5UV029m8R4BBEYueRlpTsRDVTJhQxXJqumVil1+bDRq6JQzlEpy
	g==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4gsk0h7fdw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Sep 2026 11:14:54 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 68OB5ZO2013153;
	Thu, 24 Sep 2026 11:14:54 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4guf119m32-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Sep 2026 11:14:53 +0000 (GMT)
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 68OBEVuH002821;
	Thu, 24 Sep 2026 11:14:53 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-80-22.vpn.oracle.com [10.154.80.22])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4guf119knh-7;
	Thu, 24 Sep 2026 11:14:53 +0000 (GMT)
From: Alan Maguire <alan.maguire@oracle.com>
To: ast@kernel.org, andrii@kernel.org, eddyz87@gmail.com, qmo@kernel.org
Cc: jolsa@kernel.org, daniel@iogearbox.net, ihor.solodrai@linux.dev,
        yonghong.song@linux.dev, song@kernel.org, martin.lau@linux.dev,
        memxor@gmail.com, emil@etsalapatis.com, bpf@vger.kernel.org,
        nsc@kernel.org, puranjay@kernel.org, yatsenko@meta.com,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v4 bpf-next 06/11] selftests/bpf: BTF distill tests to ensure LOC[_PARAM|_PROTO] add to split BTF
Date: Thu, 24 Sep 2026 12:14:23 +0100
Message-ID: <20260924111428.75957-7-alan.maguire@oracle.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDA0NiBTYWx0ZWRfX/lrp8+Knvv0/
 3pO+/VgyCY+a5ej66jinOaZjxYQcbDJEBUAsZXtdZGlV0RlMNnrfQi79WV+XgY3xRZz1XcOt+JI
 gfnUOiGeMJN7h0CPcwfvTXq+gOdKGPG9pUAS9R+2r27lqMGXHiKT
X-Proofpoint-GUID: -0ISfE44uDw_1Fs2u8jBQu2DtLnSfr9r
X-Authority-Analysis: v=2.4 cv=CNa/zhrD c=1 sm=1 tr=0 ts=6ab5062e b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=BqU2WV_vvsyTyxaotp0D:22 a=yPCof4ZbAAAA:8 a=zzdwoyd4zycw4srTGpYA:9
 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:12106
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDA0NiBTYWx0ZWRfX1LKWYwzsm288
 N0jiA7K5vFJC1XbOE8s2tvXj50bmk2SJKgfGKErCR6+Pm8CKP/ezVQk2DfVmuU3CJoelpIY4h88
 xwRRFEQEC6U3OR9vahwbDMSzHGgzf7Sc53lF0LZK+2his8jcz/lAzXYXf4Mc9jVMuDt80bMIaPi
 aHz7L8Xnn7MUGh+cfII4hbcI3CZ/DHtVJxhgckkGyze73dB3CPegYK91J8oyqszbSztEE8+dS4b
 XK/i6hkxN4HbHeo7PHiVSnhJEVOZFw5D4NlV3/mlCdMZDVo2j1xflEZfgDgKsDjAoXNhqAc/7Uc
 eaMaqx0hLDO2m3uqKG727215llu2sFew9jVZp2+tBFDhwtAQUxqZXyfJ673ZtaFe9VmMDI1vlfm
 h/2sZOqCP2mCnaSePpONXkJASrvNgD9kuULddC3aSFH+XC/Nur1P0rdAizHg3sFQVr7GAXl0s7A
 97Q3IOdle1eMwMYVzPgAr3aT3BZF339WBI+kf7qE=
X-Proofpoint-ORIG-GUID: -0ISfE44uDw_1Fs2u8jBQu2DtLnSfr9r

When creating distilled BTF, BTF_KIND_FUNC, _LOC_PARAM and _LOC_PROTO
should be added to split BTF.  This means potentially some duplication
of location information, but only for out-of-tree modules that use
distilled base/split BTF.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 .../selftests/bpf/prog_tests/btf_distill.c    | 106 ++++++++++++++++++
 1 file changed, 106 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/btf_distill.c b/tools/testing/selftests/bpf/prog_tests/btf_distill.c
index fb67ae195a73..f0900b47fd48 100644
--- a/tools/testing/selftests/bpf/prog_tests/btf_distill.c
+++ b/tools/testing/selftests/bpf/prog_tests/btf_distill.c
@@ -671,6 +671,110 @@ static void test_distilled_base_embedded_err(void)
 	btf__free(btf1);
 }
 
+/* LOC_PARAM, LOC_PROTO should be added to split BTF. */
+static void test_distilled_loc(void)
+{
+	struct btf *btf1 = NULL, *btf2 = NULL, *btf3 = NULL;
+	struct btf *btf4 = NULL, *btf5 = NULL;
+
+	btf1 = btf__new_empty();
+	if (!ASSERT_OK_PTR(btf1, "empty_main_btf"))
+		return;
+
+	btf__add_int(btf1, "int", 4, BTF_INT_SIGNED);	/* [1] int */
+	btf__add_func_proto(btf1, 1);                   /* [2] int (*)(int); */
+	btf__add_func_param(btf1, "p1", 1);
+	btf__add_func(btf1, "foo", BTF_FUNC_STATIC, 2);	/* [3] int foo(int); */
+	btf__add_loc_param(btf1, 4, BTF_LOC_PARAM_SIGNED | BTF_LOC_PARAM_CONST);
+	btf__add_loc_param_value(btf1, -1);		/* [4] loc value */
+	btf__add_loc_proto(btf1);			/* [5] loc proto */
+	btf__add_loc_proto_param(btf1, 4);		/*  param value */
+	btf__add_int(btf1, "unsigned int", 4, 0);	/* [6] unsigned int */
+
+	VALIDATE_RAW_BTF(
+		btf1,
+		"[1] INT 'int' size=4 bits_offset=0 nr_bits=32 encoding=SIGNED",
+		"[2] FUNC_PROTO '(anon)' ret_type_id=1 vlen=1\n"
+		"\t'p1' type_id=1",
+		"[3] FUNC 'foo' type_id=2 linkage=static",
+		"[4] LOC_PARAM '(anon)' size=4 flags=0x3 vlen=1\n"
+		"\tvalue=-1",
+		"[5] LOC_PROTO '(anon)' vlen=1\n"
+		"\ttype_id=4",
+		"[6] INT 'unsigned int' size=4 bits_offset=0 nr_bits=32 encoding=(none)");
+
+	btf2 = btf__new_empty_split(btf1);
+	if (!ASSERT_OK_PTR(btf2, "empty_split_btf"))
+		goto cleanup;
+
+	btf__add_locsec(btf2, "inline.text");		/* [6] locsec */
+	btf__add_locsec_loc(btf2, 3, 5, 256);		/* "foo" offset 256 */
+	VALIDATE_RAW_BTF(
+		btf2,
+		"[1] INT 'int' size=4 bits_offset=0 nr_bits=32 encoding=SIGNED",
+		"[2] FUNC_PROTO '(anon)' ret_type_id=1 vlen=1\n"
+		"\t'p1' type_id=1",
+		"[3] FUNC 'foo' type_id=2 linkage=static",
+		"[4] LOC_PARAM '(anon)' size=4 flags=0x3 vlen=1\n"
+		"\tvalue=-1",
+		"[5] LOC_PROTO '(anon)' vlen=1\n"
+		"\ttype_id=4",
+		"[6] INT 'unsigned int' size=4 bits_offset=0 nr_bits=32 encoding=(none)",
+		"[7] LOCSEC 'inline.text' vlen=1\n"
+		"\tfunc_type_id=3 loc_proto_type_id=5 offset=256");
+
+	if (!ASSERT_EQ(0, btf__distill_base(btf2, &btf3, &btf4),
+		       "distilled_base") ||
+	    !ASSERT_OK_PTR(btf3, "distilled_base") ||
+	    !ASSERT_OK_PTR(btf4, "distilled_split") ||
+	    !ASSERT_EQ(2, btf__type_cnt(btf3), "distilled_base_type_cnt"))
+		goto cleanup;
+
+	VALIDATE_RAW_BTF(
+		btf4,
+		"[1] INT 'int' size=4 bits_offset=0 nr_bits=32 encoding=SIGNED",
+		/* remainder is split BTF */
+		"[2] LOCSEC 'inline.text' vlen=1\n"
+		"\tfunc_type_id=4 loc_proto_type_id=6 offset=256",
+		"[3] FUNC_PROTO '(anon)' ret_type_id=1 vlen=1\n"
+		"\t'p1' type_id=1",
+		"[4] FUNC 'foo' type_id=3 linkage=static",
+		"[5] LOC_PARAM '(anon)' size=4 flags=0x3 vlen=1\n"
+		"\tvalue=-1",
+		"[6] LOC_PROTO '(anon)' vlen=1\n"
+		"\ttype_id=5");
+
+	btf5 = btf__new_empty();
+	if (!ASSERT_OK_PTR(btf5, "empty_reloc_btf"))
+		goto cleanup;
+	btf__add_int(btf5, "int", 4, BTF_INT_SIGNED);	/* [1] int */
+	btf__add_int(btf5, "char", 1, 0);		/* [2] char */
+
+	if (!ASSERT_EQ(btf__relocate(btf4, btf5), 0, "relocate_split"))
+		goto cleanup;
+	VALIDATE_RAW_BTF(
+		btf4,
+		"[1] INT 'int' size=4 bits_offset=0 nr_bits=32 encoding=SIGNED",
+		"[2] INT 'char' size=1 bits_offset=0 nr_bits=8 encoding=(none)",
+		/* remainder is split BTF */
+		"[3] LOCSEC 'inline.text' vlen=1\n"
+		"\tfunc_type_id=5 loc_proto_type_id=7 offset=256",
+		"[4] FUNC_PROTO '(anon)' ret_type_id=1 vlen=1\n"
+		"\t'p1' type_id=1",
+		"[5] FUNC 'foo' type_id=4 linkage=static",
+		"[6] LOC_PARAM '(anon)' size=4 flags=0x3 vlen=1\n"
+		"\tvalue=-1",
+		"[7] LOC_PROTO '(anon)' vlen=1\n"
+		"\ttype_id=6");
+
+cleanup:
+	btf__free(btf5);
+	btf__free(btf4);
+	btf__free(btf3);
+	btf__free(btf2);
+	btf__free(btf1);
+}
+
 void test_btf_distill(void)
 {
 	if (test__start_subtest("distilled_base"))
@@ -689,4 +793,6 @@ void test_btf_distill(void)
 		test_distilled_base_vmlinux();
 	if (test__start_subtest("distilled_endianness"))
 		test_distilled_endianness();
+	if (test__start_subtest("distilled_loc"))
+		test_distilled_loc();
 }
-- 
2.43.5

