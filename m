Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F57045C718
	for <bpf@vger.kernel.org>; Wed, 16 Sep 2026 07:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789544539; cv=none; b=pBa3Nzc9P0+2NyEsWet/8qtMbcf3OzpMWGfSpkf6M7mO+YnZtRXoxeL3UJq4SUv+py5+ph6FzmwUu7igDsu8zqBHBOAK2/rvSzdbbl+tPIN0WGghWizOy2qJ+dMUWQAXsOVSRRTO7x7ncYlDifg5vfqr7lkrC9GnFOYS7fKVgs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789544539; c=relaxed/simple;
	bh=TkJqfw0/qvSqCnx62vGNQuwhMTjAzNJcEC/lPlmJygA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VZQ9ePPNXe9YKHv1Imk8pZ0m/vIVYW7ZtQg+lfzM3HbXqd/GG9c9aWikwx3vhF9nd7c6iuR1b5EnahfviVcTABh9w4H7Oji1Yy/N+DAbFU8VleHQtHC0KgNzFNj2Ff9kkHHTgcLnG4w5/7zmQ5HgOK5h/Zh5pWspE/kNbh2SQ4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=XwqNRtB2; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XwqNRtB2"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68FLXsxO1308091;
	Wed, 16 Sep 2026 07:41:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=lUHgk
	hfGrwd93LNNCfzivTB7jGXEr8RKHtIJnSVeMqk=; b=XwqNRtB2+00t9TSSXqi57
	xKucUolIVIv2SOCUKgpHsNGOALE+pDjqFiYaUCBIxPaubTFXd0XgiElwvtaS4GAO
	x5PZUz7lQID/RBOv4b2AInOrZkjA1ku2owQUiGLeJFm/M4zBob8nk5caW74FvyZf
	pqyu1ccHNJ4aW6b5KvZiNuu2/8RgmSOPRKpgFHgl/MBVJB9Y8CaFfVp1+kTcUmE0
	CVh8xnYKKQlDFO+YTTyt73+V31gSUbG+wczJDsQZjWF+FzcmROsjEFuKAnztfm9T
	jmbxQrl4lLE5tOfISbS2kLAX/iKYgPCQLK6rRMZ2NfQXvxxRRASQfyFveoMSB80u
	g==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4gmwn9550u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Sep 2026 07:41:46 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 68G7e2la014684;
	Wed, 16 Sep 2026 07:41:45 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4gmw6au52x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Sep 2026 07:41:45 +0000 (GMT)
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 68G7exPr020284;
	Wed, 16 Sep 2026 07:41:45 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-86-81.vpn.oracle.com [10.154.86.81])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4gmw6au4u1-7;
	Wed, 16 Sep 2026 07:41:44 +0000 (GMT)
From: Alan Maguire <alan.maguire@oracle.com>
To: ast@kernel.org, andrii@kernel.org, eddyz87@gmail.com, jolsa@kernel.org
Cc: daniel@iogearbox.net, ihor.solodrai@linux.dev, yonghong.song@linux.dev,
        song@kernel.org, qmo@kernel.org, martin.lau@linux.dev,
        memxor@gmail.com, emil@etsalapatis.com, bpf@vger.kernel.org,
        nsc@kernel.org, puranjay@kernel.org, yatsenko@meta.com,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v3 bpf-next 06/11] selftests/bpf: BTF distill tests to ensure LOC[_PARAM|_PROTO] add to split BTF
Date: Wed, 16 Sep 2026 08:41:13 +0100
Message-ID: <20260916074118.1007116-7-alan.maguire@oracle.com>
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
X-Proofpoint-GUID: B2rPDXbWRzYZGIOOHHDRjIxta3sKfvv9
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE2MDA5OCBTYWx0ZWRfX4iX9GrE8x9dq
 i26TvYXRLy9YG5hDpRwV9wfY2zlux8IZ0THrw9SR+YCwNBlM8mFFouM40oe0IXlMMOu99krM63M
 xeEJmDoDNso+qCwVYUH0GbBtyPiu7AevzkYucSILcxJKBNyHLFiv
X-Proofpoint-ORIG-GUID: B2rPDXbWRzYZGIOOHHDRjIxta3sKfvv9
X-Authority-Analysis: v=2.4 cv=c9k+0h9l c=1 sm=1 tr=0 ts=6aaa483a b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=x0eKOSpe3m1H3M0S9YoZ:22 a=yPCof4ZbAAAA:8 a=zzdwoyd4zycw4srTGpYA:9
 a=WmVTiCyuxqgg3mnwYu6p:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE2MDA5OCBTYWx0ZWRfXzDza2EeQ2laY
 1u/cTs+hFZWHobcV1gozFaxtt7ud4bzN22v6r8jnzdojDC0QkBD9S3m7XWtkTF3N/9X576ojzjL
 HjXC6+6key5ohdsafXIaUTSTBOXlIxVnFJmNJYCxJpBbX9n0UoHe0h1savmqKQbovrV0NOc4Wv0
 poSMHLtGsx36rDGAfSCbAhFciTb9VzV8KSsDn0JAlTsN99edooO/ep3aVkmZLNwzXCY1hptt4Te
 3Y4q4IAdD3Xj319LrU4ROr5jB+ZifgzbekcsjV3rfbX9u3oUFah4XXtiseXW6AsNP3ksSbPU+86
 gbutemUmOAgGe3u31bMsXwXxJHxxMjHMq6CNOYVMZp8fWKXJMUBXMvUrr0lfsZHPDwosd/3iKDc
 kzPwz5Jx+pXqUjq+M+TyuR9hbVWBkCD5xL9XjGH0C6qOIn3GOb6G+OdYAnxp4E5rgYSkoBVvN+k
 FhKg242GhDVN59/GdAg==

When creating distilled BTF, BTF_KIND_FUNC, _LOC_PARAM and _LOC_PROTO
should be added to split BTF.  This means potentially some duplication
of location information, but only for out-of-tree modules that use
distilled base/split BTF.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 .../selftests/bpf/prog_tests/btf_distill.c    | 101 ++++++++++++++++++
 1 file changed, 101 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/btf_distill.c b/tools/testing/selftests/bpf/prog_tests/btf_distill.c
index fb67ae195a73..141a4cb1f405 100644
--- a/tools/testing/selftests/bpf/prog_tests/btf_distill.c
+++ b/tools/testing/selftests/bpf/prog_tests/btf_distill.c
@@ -671,6 +671,105 @@ static void test_distilled_base_embedded_err(void)
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
+		"\ttype_id=4");
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
+		"[6] LOCSEC 'inline.text' vlen=1\n"
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
+
+	if (!ASSERT_EQ(btf__relocate(btf4, btf5), 0, "relocate_split"))
+		goto cleanup;
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
@@ -689,4 +788,6 @@ void test_btf_distill(void)
 		test_distilled_base_vmlinux();
 	if (test__start_subtest("distilled_endianness"))
 		test_distilled_endianness();
+	if (test__start_subtest("distilled_loc"))
+		test_distilled_loc();
 }
-- 
2.43.5

