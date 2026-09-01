Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84437488218;
	Tue,  1 Sep 2026 16:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788281936; cv=none; b=VtHWhmfCOSfLG6IbIhKc1RoYqMKTTM3WLVex0WnNE7RClin3TwrPHh8nomWnmjNXY69uT8tkxV90Sbo++wxtKbLoBypUwzifOVzBH27C0sjJNcytBr4RFbsncypVbvkasK7IoMTtDC9xKhDtwnNOHQ5oAgFseTnc4sFHElfnjxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788281936; c=relaxed/simple;
	bh=7rlkBHN8dEAlo/Zy23t2TOI7JPQbkeLfMfIJDj2J0GY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k/3S0HCOBn2EPx+7Le+dPab6u19IQEOzQICekVSD9xoBgfsuHRr0vSK4UprGbZBVqyLc0jki4P8Yajm0ydFFbT72foyea8PngRYkX+hp4/ZKTydmzX5EDkX8QOOg1kcWVYcsyScDvQvR4Hzw4fXlXykG5MGbD6xMvvl1XArzzjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=OPf0IhwM; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="OPf0IhwM"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 681EQshv3964158;
	Tue, 1 Sep 2026 16:58:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=B0X2x
	giUGBzMOZXSNTZl5zuVaBRO9AEyDhk5TeWYcuQ=; b=OPf0IhwMQr2w8zffT94T+
	pFuFnCwCwWoPCcy4gVJ9vihzvkl3ZyX2JpDgghzKStNCHAGwUPuDYME2k7iubDjv
	38+TXPFSaNXVVX+EYW6hti3qI6ogZ3s80B75HE1qxibOvk7I032QkpRu8UkkVsZF
	bBtzR/JliyUduHo3QoqNZoIdTgPAOfZ3zOx8/eVZt/Ie8dfbGT9vf7iN/MM81UAs
	PJokdSJw37kS9D1LIZ/mYIixpGzJc/RVvQr90qeR0IWvudv4MKz9MSmoX9M0b0ML
	PnIo0No1m9HMAZIJG7C+PGo/mXA24UK9tuT6snmYdHu+u79/R3cmUAoXGSlVJrWR
	Q==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4gbqyrw3t4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 01 Sep 2026 16:58:28 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 681GjSNF001822;
	Tue, 1 Sep 2026 16:58:27 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4gdymtg8vg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 01 Sep 2026 16:58:27 +0000 (GMT)
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 681Gw1W5011129;
	Tue, 1 Sep 2026 16:58:26 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-52-250.vpn.oracle.com [10.154.52.250])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4gdymtg8f6-8;
	Tue, 01 Sep 2026 16:58:26 +0000 (GMT)
From: Alan Maguire <alan.maguire@oracle.com>
To: ast@kernel.org, andrii@kernel.org
Cc: daniel@iogearbox.net, eddyz87@gmail.com, jolsa@kernel.org,
        ihor.solodrai@linux.dev, yonghong.song@linux.dev, song@kernel.org,
        qmo@kernel.org, martin.lau@linux.dev, memxor@gmail.com,
        emil@etsalapatis.com, mcgrof@kernel.org, petr.pavlu@suse.com,
        tj@kernel.org, kees@kernel.org, bpf@vger.kernel.org, nathan@kernel.org,
        nsc@kernel.org, arnd@arndb.de, puranjay@kernel.org, yatsenko@meta.com,
        atenart@kernel.org, ojeda@kernel.org, linux-modules@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v2 bpf-next 07/18] selftests/bpf: BTF distill tests to ensure LOC[_PARAM|_PROTO] add to split BTF
Date: Tue,  1 Sep 2026 17:57:46 +0100
Message-ID: <20260901165757.801449-8-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20260901165757.801449-1-alan.maguire@oracle.com>
References: <20260901165757.801449-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-01_04,2026-09-01_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 adultscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0 suspectscore=0
 bulkscore=0 mlxlogscore=999 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2606160000 definitions=main-2609010148
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAxMDE1MCBTYWx0ZWRfX22Ot0dE0Gj0T
 BSTE4OYfFvUbODmm4++Op+OQf25DeDEXiXlZI9I54Hc347Vi3W4ANNzr2dKm38ODrAcbdjLrJM7
 xdrA9jY7i6Y6ug+HAFnYKpghJm9u32yr07KkdxkMLxAqcTCr/C+DnqIZCeAUNa6xCQcAmccS0YZ
 uLxvjPe2Gupv9ukEwCg/ZJA85cYyJEqcvzl5uFg5mpdXcxbzP1Uw0yo3yHf/L+nPgt2+5yyKsOZ
 phdbMZuZKhVOh0ZQxstDc/+5m2QUYM/b3wgcdd/cVNrOth3rKg8VQqLucc7UtWExcWvyZcqNAIh
 eN25scQ7h1/GgftSU6hV5R0Sd3rWFUjiijx+jPFWXWUEuPiAnvPPA4562QpkDBwatQFjW488xwx
 WEgc7YTCbrexRhNgio+lYTTazftVBbxxxq7PFCGKUgzFdu2Q1gFWL2ocDIZx67rAs8Y6KX7l9z7
 7vvhQNX0Sh9/jZLJE2+/38mhCAjd39xReEfUhSUE=
X-Proofpoint-ORIG-GUID: n2Cn3oalCn-2ajceGfNXRL8ncV2DOStL
X-Authority-Analysis: v=2.4 cv=fbCdDUQF c=1 sm=1 tr=0 ts=6a970434 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=7Gl3-_t3PgB9XO-mQDs3:22 a=yPCof4ZbAAAA:8 a=hf7FfUZL3eI-ZkDr0lIA:9
 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:13521
X-Proofpoint-GUID: n2Cn3oalCn-2ajceGfNXRL8ncV2DOStL
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAxMDE1MCBTYWx0ZWRfX7ZO0/NEt39V3
 LtpFJDjln28+h4dnKEcaDjydxzoQCUOLfXrUqo7Vd7zkryGMcaBne+3zmfnXFTOW0G2s0XrOHZW
 6di/Gcrg2p8vjEAUxZkeBnZy1B8zm0ALk+2nmrLXkpHQ9FpJnihG

When creating distilled BTF, BTF_KIND_FUNC, _LOC_PARAM and _LOC_PROTO
should be added to split BTF.  This means potentially some duplication
of location information, but only for out-of-tree modules that use
distilled base/split BTF.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 .../selftests/bpf/prog_tests/btf_distill.c    | 76 +++++++++++++++++++
 1 file changed, 76 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/btf_distill.c b/tools/testing/selftests/bpf/prog_tests/btf_distill.c
index fb67ae195a73..f433b29ffce9 100644
--- a/tools/testing/selftests/bpf/prog_tests/btf_distill.c
+++ b/tools/testing/selftests/bpf/prog_tests/btf_distill.c
@@ -671,6 +671,80 @@ static void test_distilled_base_embedded_err(void)
 	btf__free(btf1);
 }
 
+/* LOC_PARAM, LOC_PROTO should be added to split BTF. */
+static void test_distilled_loc(void)
+{
+	struct btf *btf1 = NULL, *btf2 = NULL, *btf3 = NULL, *btf4 = NULL;
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
+
+	VALIDATE_RAW_BTF(
+		btf1,
+		"[1] INT 'int' size=4 bits_offset=0 nr_bits=32 encoding=SIGNED",
+		"[2] FUNC_PROTO '(anon)' ret_type_id=1 vlen=1\n"
+		"\t'p1' type_id=1",
+		"[3] FUNC 'foo' type_id=2 linkage=static",
+		"[4] LOC_PARAM '(anon)' size=4 flags=0x3 vlen=1\n"
+		"\tvalue=-1");
+
+	btf2 = btf__new_empty_split(btf1);
+	if (!ASSERT_OK_PTR(btf2, "empty_split_btf"))
+		goto cleanup;
+
+	btf__add_loc_proto(btf2);			/* [5] loc proto */
+	btf__add_loc_proto_param(btf2, 4);		/*  param value */
+
+	btf__add_locsec(btf2, ".locs");			/* [6] locsec */
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
+		"[6] LOCSEC '.locs' vlen=1\n"
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
+		"[2] LOC_PROTO '(anon)' vlen=1\n"
+		"\ttype_id=6",
+		"[3] LOCSEC '.locs' vlen=1\n"
+		"\tfunc_type_id=5 loc_proto_type_id=2 offset=256",
+		"[4] FUNC_PROTO '(anon)' ret_type_id=1 vlen=1\n"
+		"\t'p1' type_id=1",
+		"[5] FUNC 'foo' type_id=4 linkage=static",
+		"[6] LOC_PARAM '(anon)' size=4 flags=0x3 vlen=1\n"
+		"\tvalue=-1");
+cleanup:
+	btf__free(btf4);
+	btf__free(btf3);
+	btf__free(btf2);
+	btf__free(btf1);
+}
+
 void test_btf_distill(void)
 {
 	if (test__start_subtest("distilled_base"))
@@ -689,4 +763,6 @@ void test_btf_distill(void)
 		test_distilled_base_vmlinux();
 	if (test__start_subtest("distilled_endianness"))
 		test_distilled_endianness();
+	if (test__start_subtest("distilled_loc"))
+		test_distilled_loc();
 }
-- 
2.43.5

