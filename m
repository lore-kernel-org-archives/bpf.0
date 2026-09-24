Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65E9447668C
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 11:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790248514; cv=none; b=hvlqeu2zpida2xOS3gaVHL1OvR3hvijP8pF13qvNTh+kFf0IPlgiyOnNMTHQiluP8YnM09MSCDM1pJ29fUI53L4CDaMFlUSUMjN2ZA1qiFxiaM2SBfmNMQ3Pgl3okH6JnZyXA/ibqqNk1C9U8wc4nuaHRNopVPEHYELdYWVDGX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790248514; c=relaxed/simple;
	bh=fwkatxjPqgal12XpY2TYRgnX+74/7c9frpVd6kbBIjg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fjg5TYpX+VO6NQYsY7RbcrAhFkPkIfCIPizmI13FwgtBX6Q+LGXAQj3c3TZMtEgb02lvcxZs8aRviJklqHbicLGOo2CM8tLs1tD1DkfpVLwo644WUWNBhkyxgyM/pwP3c56mrITyLZl+IBXG0SOPJGKPRpjf4jWtnHAxYo720gI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=YaTprZeq; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="YaTprZeq"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68O6CL2w4016969;
	Thu, 24 Sep 2026 11:14:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=miP90
	hcy8SC12iw1ryc7Pg2PKNhiYRkeZ4/0pdPh2oE=; b=YaTprZeqoAtZkJdrfba2w
	vb0tku2ni/sxnI9i8QTcw6NT9bDyLU+xQLVv+74qI2Ql+jQJTN6X5BGcF6AXrD16
	wQVij4niEVFw12wLNDpMKYBJYC+MiN+KnItrvPBUDLcG8Bnb1s2PHkWGa+yCfjSp
	2uIAuDSUGVPOfzxbd9Avm4tfLJKWq+DUPK+Dh4KYsTKM2KAGQRAPu/6PR4avPaze
	4jLr5c5s8+Po5pOzPIRB8j3nFRtQymGUSL9oucFE4H9BURxDFYSKAhrmdrDe214L
	4ZTF2KHK6uO83MiOXlktO+8FVgVafarwNb6UI1shJlvUomnwKOpUoxLPJ7n0v9mC
	Q==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4gsk0xqcb8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Sep 2026 11:14:47 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 68OB5Z2f013210;
	Thu, 24 Sep 2026 11:14:47 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4guf119kya-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Sep 2026 11:14:47 +0000 (GMT)
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 68OBEVuD002821;
	Thu, 24 Sep 2026 11:14:46 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-80-22.vpn.oracle.com [10.154.80.22])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4guf119knh-5;
	Thu, 24 Sep 2026 11:14:46 +0000 (GMT)
From: Alan Maguire <alan.maguire@oracle.com>
To: ast@kernel.org, andrii@kernel.org, eddyz87@gmail.com, qmo@kernel.org
Cc: jolsa@kernel.org, daniel@iogearbox.net, ihor.solodrai@linux.dev,
        yonghong.song@linux.dev, song@kernel.org, martin.lau@linux.dev,
        memxor@gmail.com, emil@etsalapatis.com, bpf@vger.kernel.org,
        nsc@kernel.org, puranjay@kernel.org, yatsenko@meta.com,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v4 bpf-next 04/11] selftests/bpf: Add LOC_PARAM, LOC_PROTO, LOCSEC to field iter tests
Date: Thu, 24 Sep 2026 12:14:21 +0100
Message-ID: <20260924111428.75957-5-alan.maguire@oracle.com>
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
X-Authority-Analysis: v=2.4 cv=F/bC5ahN c=1 sm=1 tr=0 ts=6ab50628 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=3I1J8UUJPc9JN9BFgKH3:22 a=yPCof4ZbAAAA:8 a=pGLkceISAAAA:8
 a=VkB5D42UQONZS3aGHW4A:9 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22
 cc=ntf awl=host:12106
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDA0NiBTYWx0ZWRfX0ZcQH46O70PZ
 tekWZkXQRAZMN2vgULwgYJ+SqmSjw2bpTMHT0N2V9A0pJaxRoNcCCO1ryNLhW8BNahwq/ML8haP
 M4OoVEw7YTFF47RkfhO8pJ270dnby9abRNXSEf7JS+jDRxrqDquA
X-Proofpoint-ORIG-GUID: hC1JIFx-9rscQTdcKwxpS5SMLR48qGUd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDA0NiBTYWx0ZWRfX0EAQqAS436ez
 4n1v6xERFM4teLyMK5uQ6NqUMdoDbbgL4t2Q0rNQTtApTpXWdA8zVrOpEYxN2tAccgGClZJe2un
 CCz5wuRZjfpNpdI/CEoLSWzWe+SCziAcT30y4Z+xIk0BfUgSdf50C378EFrlOdm5ZD+YjGa52c0
 0FNsXn5PyNF0lJWn43D9rj9JgP872GeX0lIc2tlGn5M5ufn3BzfFDEekohV5TQpI3lw17ayCY/K
 iVDWAZFvCwwXd0nYiW08DfjvZNVpfEjq9bXPVNjEnMqjboILAIH4lxJPJ/RpEgOBpLQqesjwi+o
 iGICu/xM/2XRQPzLFp5skaViB1ku3E3GM3mhj4YAPYAbbS610BGoOr+bSwPvsH7DIZkOB1wfjNe
 jo/Xg0WPl6i1TcaVEK3vXsE60ujSLyxiLlUKDx+S/4z62wZ9QoRcXLFb+S3KwyXJtQd33umdO0z
 vyVGqlkcW3lmpOxCM/E25p/osqXNIOOet3uoMZhU=
X-Proofpoint-GUID: hC1JIFx-9rscQTdcKwxpS5SMLR48qGUd

BTF_KIND_LOC[_PARAM|_PROTO|SEC] need to work with field iteration, so
extend the selftest to cover these and ensure iteration over all types
and names succeeds.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
---
 .../selftests/bpf/prog_tests/btf_field_iter.c | 31 +++++++++++++++++--
 1 file changed, 28 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/btf_field_iter.c b/tools/testing/selftests/bpf/prog_tests/btf_field_iter.c
index 32159d3eb281..dcb5429d141d 100644
--- a/tools/testing/selftests/bpf/prog_tests/btf_field_iter.c
+++ b/tools/testing/selftests/bpf/prog_tests/btf_field_iter.c
@@ -31,8 +31,11 @@ struct field_data {
 	{ .ids = { 11 },	.strs = { "decltag" } },
 	{ .ids = { 6 },		.strs = { "typetag" } },
 	{ .ids = {},		.strs = { "e64", "eval1", "eval2", "eval3" } },
-	{ .ids = { 15, 16 },	.strs = { "datasec1" } }
-
+	{ .ids = { 15, 16 },	.strs = { "datasec1" } },
+	{ .ids = {},		.strs = { "" } },
+	{ .ids = {},		.strs = { "" } },
+	{ .ids = { 22, 23 },	.strs = { "" } },
+	{ .ids = { 14, 24 },	.strs = { ".loc" } }
 };
 
 /* Fabricate BTF with various types and check BTF field iteration finds types,
@@ -88,6 +91,19 @@ void test_btf_field_iter(void)
 	btf__add_datasec_var_info(btf, 15, 0, 4);
 	btf__add_datasec_var_info(btf, 16, 4, 8);
 
+	btf__add_loc_param(btf, 4, BTF_LOC_PARAM_CONST | BTF_LOC_PARAM_SIGNED);
+							/* [22] loc value -1 */
+	btf__add_loc_param_value(btf, -1);
+	btf__add_loc_param(btf, 8, BTF_LOC_PARAM_REG);	/* [23] loc reg 1 */
+	btf__add_loc_param_value(btf, 1);
+
+	btf__add_loc_proto(btf);			/* [24] loc proto */
+	btf__add_loc_proto_param(btf, 22);		/*  param value -1, */
+	btf__add_loc_proto_param(btf, 23);		/*  param reg 1 */
+
+	btf__add_locsec(btf, ".loc");			/* [25] locsec ".loc" */
+	btf__add_locsec_loc(btf, 14, 24, 128);		/* "func" */
+
 	VALIDATE_RAW_BTF(
 		btf,
 		"[1] INT 'int' size=4 bits_offset=0 nr_bits=32 encoding=SIGNED",
@@ -123,7 +139,16 @@ void test_btf_field_iter(void)
 		"\t'eval3' val=3000",
 		"[21] DATASEC 'datasec1' size=12 vlen=2\n"
 		"\ttype_id=15 offset=0 size=4\n"
-		"\ttype_id=16 offset=4 size=8");
+		"\ttype_id=16 offset=4 size=8",
+		"[22] LOC_PARAM '(anon)' size=4 flags=0x3 vlen=1\n"
+		"\tvalue=-1",
+		"[23] LOC_PARAM '(anon)' size=8 flags=0x8 vlen=1\n"
+		"\tvalue=1",
+		"[24] LOC_PROTO '(anon)' vlen=2\n"
+		"\ttype_id=22\n"
+		"\ttype_id=23",
+		"[25] LOCSEC '.loc' vlen=1\n"
+		"\tfunc_type_id=14 loc_proto_type_id=24 offset=128");
 
 	for (id = 1; id < btf__type_cnt(btf); id++) {
 		struct btf_type *t = btf_type_by_id(btf, id);
-- 
2.43.5

