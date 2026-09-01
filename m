Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B58B3486BA2;
	Tue,  1 Sep 2026 16:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788281932; cv=none; b=G/vQbW5DFld6jPD+YOUQSVWTIE3h/rHFVVFkb9pBBizdwGPmZh+Di3qHGm/PxNlhFFYYICP9WSIvObF1eNlCYqtrjkgdjgpKw7w/K5m69/hYil/Do8kFMB048BEHMyDWLQtkUS3XFLzklPy1EBuA5nvCKCws9ITJ++xBpUTEEMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788281932; c=relaxed/simple;
	bh=Hc6HlXImwwcX1jw6WvlE+mkrm+v5U0oloYmYB3Hbiz8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hka2hIMsFDq58ZwHAwZZMLdTBlesV5E5tenqIQSF6lV6mRd/iNTj1m6U4G7pHXVsRGsAkIYaGm/BxYwl/KP785Fy7eyFUIb4IyNkDupmCfrFiToPPSnmEG2VrhURhUqWQWEAZAmIS2+HRrWHlyC61Nvw3L9VSZz9im6FlDpuxdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=QmyCxRx4; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="QmyCxRx4"
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 681EQBsQ231372;
	Tue, 1 Sep 2026 16:58:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=1ORXY
	G68viJLQp8zLu/BapaQF1TUyEVvcxiALPc4/zM=; b=QmyCxRx40+kb0OckFhB/i
	7vIlGYH3ShiF1v5UybZJihhNv+pdCEX6w8BWskRhQXGlStGNJol/F7WYHGOTitPZ
	E0KIUXs0R5tVAv0Rf3+IQSBnA/TqqD+oo2T3IN6FbPChjOmxPrvUmR+1koTcm/JH
	BpWtsahotCXN40qXp/oXNBaLQBCm9CxWY1lwosROKHjO/KO3CagZiaWWqtwOnxuC
	UVlvsIxfKaoIEJtx1Qr0oXGPfq4splshFpC56zrnj+6j5qnthkgoXdxKLVlxgral
	ProxyrwFZD6oEPjHAoWUyD1An5bMFMnmPg3/FBxCTm7ZytlR5mOeZ9mjJadEiu+f
	g==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4gbqa7n3tn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 01 Sep 2026 16:58:25 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 681GjUGo001862;
	Tue, 1 Sep 2026 16:58:24 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4gdymtg8u5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 01 Sep 2026 16:58:24 +0000 (GMT)
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 681Gw1W3011129;
	Tue, 1 Sep 2026 16:58:23 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-52-250.vpn.oracle.com [10.154.52.250])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4gdymtg8f6-7;
	Tue, 01 Sep 2026 16:58:22 +0000 (GMT)
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
Subject: [PATCH v2 bpf-next 06/18] selftests/bpf: Add LOC_PARAM, LOC_PROTO, LOCSEC to dedup split tests
Date: Tue,  1 Sep 2026 17:57:45 +0100
Message-ID: <20260901165757.801449-7-alan.maguire@oracle.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAxMDE1MCBTYWx0ZWRfX4JBFNZbn+L0Y
 jL5jz032PoONrH1EvKvFGfwrgvfvH6hwI7z5Kt3ORUiPznn46n81jcoO6IT2h6qymCxqxv6LZEo
 xDSUpejDKMut7k6XxQqjzplrPIfxWXsNXzDyYSuI04eUl454AGqv
X-Proofpoint-GUID: IhaaH1U-Px2hTILii6pp_7eNv6hoQ6ZG
X-Authority-Analysis: v=2.4 cv=DPu/JSNb c=1 sm=1 tr=0 ts=6a970431 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=EIcjfB9IiI4px24ztqRk:22 a=yPCof4ZbAAAA:8 a=Dqmx8x_qsB7B715aku4A:9
 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:13521
X-Proofpoint-ORIG-GUID: IhaaH1U-Px2hTILii6pp_7eNv6hoQ6ZG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAxMDE1MCBTYWx0ZWRfXyZkxevxNivhj
 9swRVxLGi1Lo/eD7FRbh6pNBN2kU9VRcMu3glVgC/e0PnJkXO6ge2HQgayazVsZMgPLyZlJbPSi
 6kVFJjGiVS+qA5CzTZZkO/EEp+85O4traSfwlx80qb89nBX2abV5v2K1qmtkwgDf4WHj+nY9AzG
 8yQA522IBDhEj1tIZ6ZXv+Teh8dHkNS38mSkw5I4f5S/07uMfdYpc04fzQjEo2Ec3A9q39Nye53
 ZQACMyz75eXacPJwIUeiXjLwEei2gqgBM4T4TIUGUNmHA0DmxJmkG1fMRf9Dd8QfyYGrVrfIaY/
 5OVTZ/nYM49b5VhwdqUBTi6TG4n6PCrPsmA1xPpF3vYT115JukuKUhNn1O/6j1JMO/90AHUegwI
 wr2VUYEarezsJysmev1gDqdRVCZU9gsgXsdspssQnXGXP87c4qmy8vXAAferyHki07Spk4fi9Rw
 DDrUQ6sgSEcna5mRkLMBy9BcsWSo8si4e9IOc2sE=

Ensure that location params/protos are deduplicated and location
sections are not, and that references to deduplicated locations within
location prototypes and sections are updated after deduplication.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 .../bpf/prog_tests/btf_dedup_split.c          | 109 ++++++++++++++++++
 1 file changed, 109 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/btf_dedup_split.c b/tools/testing/selftests/bpf/prog_tests/btf_dedup_split.c
index 9d6161151593..34ca20f88afd 100644
--- a/tools/testing/selftests/bpf/prog_tests/btf_dedup_split.c
+++ b/tools/testing/selftests/bpf/prog_tests/btf_dedup_split.c
@@ -554,6 +554,113 @@ static void test_split_module(void)
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
+	btf__add_locsec(btf2, ".locs");			/* [9] locsec ".locs" */
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
+		"[10] LOCSEC '.locs' vlen=1\n"
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
+		"[8] LOCSEC '.locs' vlen=1\n"
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
@@ -566,4 +673,6 @@ void test_btf_dedup_split()
 		test_split_dup_struct_in_cu();
 	if (test__start_subtest("split_module"))
 		test_split_module();
+	if (test__start_subtest("split_loc"))
+		test_split_loc();
 }
-- 
2.43.5

