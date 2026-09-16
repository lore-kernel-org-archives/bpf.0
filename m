Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CB1B3ED5B9
	for <bpf@vger.kernel.org>; Wed, 16 Sep 2026 07:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789544548; cv=none; b=sduFXWhcKquERRtHRZRcC1+MGb9zMZdTYAchahxyuVQjrw74KUvB03x09M+RK1XOzONsBXa0zZ/xrjwt8LWOMz5DTFTyCs4GL0Nx9oVJtveXX97uxrGpDzDoEUbXHxpI21+37PWGJwzgbk+fGXKeTKgVoMuTGHPdxN7xb6FVxew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789544548; c=relaxed/simple;
	bh=6tKgMuZJfkAzMPuy2j88+9uUG4GpdWwc8a+KWpiUV9A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DZ25CcOXjzzWT3fPV3URxowEh/68mzD35CRbJcCJM7+uhkN2eQj5WX0py95oNh2Z4kGWnMIjZ1XfGFG82ekuq+sX6Rf8SBw7U2Lbqwhqc9Nnjr92QbdbvExI7LAX89h0IB23Dv12pYvCal1qRUEYfnjWnk2Gd78FsxGDU/Doo/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=BAv+NY3Y; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BAv+NY3Y"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68FLXxht1308185;
	Wed, 16 Sep 2026 07:41:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=M62gN
	5TAgVr3BhosesVdlCl6UPm5AvmrPj1ckzmsFx0=; b=BAv+NY3YEJ8d0Btnx+mX4
	as7UeWyyAvWceBlIJ35tFTsRxDz6cHJGaUmlyA8R9oM5xhlWEdA+CVx3tN7Ofvf7
	nrncPsStETdhOkOO0uTF4YLG6uA69CiaF0Sp5/oRRUfDIbobIyFPAf1n1ZWZQTq7
	RUKQwMM5o8zjXXz3Pwg1+u6LNNhAI43htQWDf7nBnUufgWeqUgBwHWgo5M/qDG9l
	hRk7tJb0/+wYuOi0CYYFHBbR96rRgWsOL9WW3ZuP9cM+wh3FClKOZgtV+V65Ov/S
	NXfI9Db+Q65atYsRyNR/ElB/2Cg2ouk9uDQUY/l8NMZbIt4pSEfaDA6igSaMTn3Y
	g==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4gmwn9550r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Sep 2026 07:41:42 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 68G7e200014680;
	Wed, 16 Sep 2026 07:41:42 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4gmw6au51n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Sep 2026 07:41:42 +0000 (GMT)
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 68G7exPp020284;
	Wed, 16 Sep 2026 07:41:41 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-86-81.vpn.oracle.com [10.154.86.81])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4gmw6au4u1-6;
	Wed, 16 Sep 2026 07:41:41 +0000 (GMT)
From: Alan Maguire <alan.maguire@oracle.com>
To: ast@kernel.org, andrii@kernel.org, eddyz87@gmail.com, jolsa@kernel.org
Cc: daniel@iogearbox.net, ihor.solodrai@linux.dev, yonghong.song@linux.dev,
        song@kernel.org, qmo@kernel.org, martin.lau@linux.dev,
        memxor@gmail.com, emil@etsalapatis.com, bpf@vger.kernel.org,
        nsc@kernel.org, puranjay@kernel.org, yatsenko@meta.com,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v3 bpf-next 05/11] selftests/bpf: Add LOC_PARAM, LOC_PROTO, LOCSEC to dedup split tests
Date: Wed, 16 Sep 2026 08:41:12 +0100
Message-ID: <20260916074118.1007116-6-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20260916074118.1007116-1-alan.maguire@oracle.com>
References: <20260916074118.1007116-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-15_05,2026-09-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 lowpriorityscore=0 mlxlogscore=999 adultscore=0 phishscore=0 malwarescore=0
 mlxscore=0 spamscore=0 suspectscore=0 bulkscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2609040000 definitions=main-2609160099
X-Proofpoint-GUID: DO3i3o_1WP_fXtTtAW_u2d_l5TitmoyI
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE2MDA5OCBTYWx0ZWRfX+GjE8BTkguRf
 19Njq2oLyjcdR24I1mFzU/5WtaIAajBO52GTcT16eBdU0xP6RJU4X4wxvVlr2UbJyHP2eU9lxUH
 fMhwR/M174cNlqmRdefjw4ba3M48DGgBF3L2/Il9kQQMPc/0ttNu
X-Proofpoint-ORIG-GUID: DO3i3o_1WP_fXtTtAW_u2d_l5TitmoyI
X-Authority-Analysis: v=2.4 cv=c9k+0h9l c=1 sm=1 tr=0 ts=6aaa4836 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=x0eKOSpe3m1H3M0S9YoZ:22 a=yPCof4ZbAAAA:8 a=Dqmx8x_qsB7B715aku4A:9
 a=WmVTiCyuxqgg3mnwYu6p:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE2MDA5OCBTYWx0ZWRfXz7/9ViRrP0VE
 Rg2/FNAjxWSboQsGwZAsR8KVXtdKCTIIHA0GTZVmwdvPxIuZFY2pS508IUeezdHzG/WSBdrh6Mn
 QflY+zBAM9nV0+6OSDp7sxOSLBw496jOtTIBNmlJ8jFpP9s93rLp9Dndb+I/TCgResT0qwZoUWq
 evWlrN+FZnQaqJ7t5fxAGf15gwuCW5f+ZdHDAJLBcJDJh98JJgcK51o38n8gEEgW7qulXIfx3A4
 8hZdaE4gleSsCQgQfVdaqhwfPK+1Bu+D4AvhDKUl+ZF+XLLJG8kik4AS49hSkBfLgfNp+WKJ7Vv
 rwG3Afh+GRo6CDbC2bRdjnBvrj9BN6o40Yu3Osc5IWwhCTsDYiiYb4nn5D6GEzIHEJ3eYZpy4zx
 Px9nMOEsExrTjqOS/HZ2k8tDX7GwaXfq+n/ytHyYJ7W7BL/eXFNikp3Dn/1fiW+0WDJrZzvg/Bs
 j1vaD8vpGe97GfsBRfA==

Ensure that location params/protos are deduplicated and location
sections are not, and that references to deduplicated locations within
location prototypes and sections are updated after deduplication.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
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

