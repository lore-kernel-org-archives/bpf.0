Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E4FD486B8B;
	Tue,  1 Sep 2026 16:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788281927; cv=none; b=lSodEYyltiA3y1eVLUfDXzRQAZ/0lG/dPzR4SyYDljbmgyZ/H8aueMHxsTTWnu5Xl/psK4kU6vyh45IQNb7XaNFJmcEE6X6uaIw9MWwsYV4wkkLwhpZr7/NQ34Uf9oIv4AdaNbDqVav8IF5OL39V65hiUuN7S2urWO6QyOKfuCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788281927; c=relaxed/simple;
	bh=hVRG9xvMvJdplhDelcKBT2fqLLs39aY4+Jih4zX6wvI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hanhGWv1gfpbTSJQ0l9MlOMo7SliDgHJ2aMQn6M3zYFW0N5uoUpZbdTr0VinljY2gd4IqW7ehyEKq+9cxABhf0PTWDWv3yDSWMGxVV1IIjQUBwYCqejYTkn2zBfKIMkggHYMkGEI7Zr0pkPuQUlGxdZ3TbmfjwDkYWDXtUPwP48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=iBj5RFl3; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="iBj5RFl3"
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 681EQBhD231367;
	Tue, 1 Sep 2026 16:58:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=TZujB
	HZWOQtbx1M0MPBGAQFNZqKW0XqpVTaorAkbDn4=; b=iBj5RFl3udz7ndRpMHe6f
	56mjWk5HZd3rTdARgcLe8lf8Hd8YjifaMtR0R0ldIfHi4QVMVtwx/b2qmgYBN6HC
	SK5JDou6JCqUklGiKSJL0ZK39i2n46GnyXNNpP9SYWlM5gcUg9JWSUUTBAVGxp2G
	6cK/qQ6QP3+sXZKRvU93gls1rELDnxeuKhulE9+mkZ8Wj0ZT+S5Q8OEIInD+cnzO
	9+y7CzpkEG09nxClE1Yck84tfbxVboCzuoeAZvaX468KbVKnf+o9DQhL146dPqc5
	INYOyD+/6a/xvtFJ2+oebY1H/g/mpzjo8Q/29vasC3GgDtDwvXX1bTLWD+m7DiKd
	A==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4gbqa7n3td-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 01 Sep 2026 16:58:21 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 681GjSP9001831;
	Tue, 1 Sep 2026 16:58:20 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4gdymtg8sg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 01 Sep 2026 16:58:20 +0000 (GMT)
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 681Gw1W1011129;
	Tue, 1 Sep 2026 16:58:19 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-52-250.vpn.oracle.com [10.154.52.250])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4gdymtg8f6-6;
	Tue, 01 Sep 2026 16:58:19 +0000 (GMT)
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
Subject: [PATCH v2 bpf-next 05/18] selftests/bpf: Add LOC_PARAM, LOC_PROTO, LOCSEC to field iter tests
Date: Tue,  1 Sep 2026 17:57:44 +0100
Message-ID: <20260901165757.801449-6-alan.maguire@oracle.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAxMDE1MCBTYWx0ZWRfX3QUaVtUX28HR
 ZSoqf9K2QgWefiXHB8Ztq36W6UJ4eGMMbhbMoB2LnCaDP6QqOLs8hyn//mGsnEJD0XXkINyAnt/
 MYEhaJeSz09F9l2yEH1qAN9WcR9nifG/stbCJZ46YiBHMuivn9q7
X-Proofpoint-GUID: 591JIqi0f3Lvii-f6B3AKO_HQ5hJJdQ-
X-Authority-Analysis: v=2.4 cv=DPu/JSNb c=1 sm=1 tr=0 ts=6a97042d b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=EIcjfB9IiI4px24ztqRk:22 a=yPCof4ZbAAAA:8 a=VkB5D42UQONZS3aGHW4A:9
 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:13521
X-Proofpoint-ORIG-GUID: 591JIqi0f3Lvii-f6B3AKO_HQ5hJJdQ-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAxMDE1MCBTYWx0ZWRfX1RMgeEn6S3ug
 QRhQnbwgmwxBLTe/GZY0oWOfQu9VpRMUvnuvaGJ4tmOLM1JEATaL9X6S1Xv4b2H59suAmUy0C1k
 cw2hxkKBWskbbg5hU1Q94yXoLibjUr/HkAB7egIKM7L8zdu+9u5E1ggLrY+ea6C2tr4MKh+Ql3v
 a+m/TRdVa3/GzOqjjM+Vfj/XWwNtYXGoLeW2FJP7OZJcbY0ntDyJTazXa2gKZbMbngB7ZjXs3DV
 o/v7Zp8HQmelQ+6VNuOuS9YsHxyFitThB+LOwnhk7lPNEiSarI6uRwTTOX7dQHS5cM0zycgafRI
 8fVK7YAMA5B9M6CyerJbh0+/7NPExh0j1cr3B5am/Pru3/LZSPrm5UB1V0ffJY8o5vwU48+0kwM
 9bt+fg10qn6Q8pZANIN6nmAVvlUfO5NbI1jnusFEMEbIoIc1EkC/mvKUT9LcFtm9ye0/XLE/ShG
 iNv/1jbV2Sn9Oa/CtRMWQAYI3EzND6x4z8lYcv6U=

BTF_KIND_LOC[_PARAM|_PROTO|SEC] need to work with field iteration, so
extend the selftest to cover these and ensure iteration over all types
and names succeeds.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
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

