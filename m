Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93E9E377EAF
	for <bpf@vger.kernel.org>; Fri, 25 Sep 2026 17:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790356188; cv=none; b=JRyKKCvUGwtoyiQZuzL42lmwmX496ls65329e4Ao9lHo5pQxeUF7FnR5QOugQ7G2oBDrtbIcgLbmOKR1VBBpy7ZJHEqNP2jlwMvHmk1O5TyKuEQc49bxEi5lwSZuRYRSbAEiMu9GCVWQXJKxdBndCjA85KWAQuxBU41BQ7mF0AM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790356188; c=relaxed/simple;
	bh=1f4Ov4Qov1PZo9EI7fi0zlG9Are4tSxLRfNDia5+wl0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kAMKGHZch3GWT/taBYwdYJaSVI1lZBTRZ1cXacVav3+NY91eMwsfrotGTIOlNALjw9M6fxSpVjLA6eRdD0JuyD+LJGZMgjkhHCOz0uqHZkY4rd30H6PCVcTpS9Hi8FWSBr9WErP4JvK4rHcKM+Gw7hJUjNQlaRacb9dydvEEHBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=KetlDGw5; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KetlDGw5"
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68PEBpOB3193010;
	Fri, 25 Sep 2026 17:09:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=1COZG
	6kAhwouvu+qUXiKDZ4MFmowL8FQMaLREvoeCh0=; b=KetlDGw5sLwi8pytkitNk
	VeAzJrQM+zVtBb5Zw++UBf3h2QJf5HCF8ltR2HDahShbgXVIig9D7YGHihbAJsUU
	n+73bn+N79JNQ8uicY74y/Jr5zQTBJpiiqYiDU78+o4DSU3wfdmL5PbnSPhl9QDL
	anHDJ+qZJMYjMhMf4ji3IuGd3/UIbrJrfbJDhbha+aGLuTlyTZb0VT9/5MjmnU/n
	9Cfurs07UOlQwqRsma0fkFNPamkV6Ng2VmiJQUAIjkDdhWwQLGF8O/4uJNhcmOiF
	O4nGs7y+CLhOglH3Lp77KwOGicvmjGsOgAhfZQOaVuiHivEutodscK/eS1ainFGl
	w==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4gsk2d9phk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Sep 2026 17:09:07 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 68PGa7OU023481;
	Fri, 25 Sep 2026 17:09:06 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4gtepteu34-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Sep 2026 17:09:06 +0000 (GMT)
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 68PH8v8o008030;
	Fri, 25 Sep 2026 17:09:05 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-81-122.vpn.oracle.com [10.154.81.122])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4gteptetwn-4;
	Fri, 25 Sep 2026 17:09:05 +0000 (GMT)
From: Alan Maguire <alan.maguire@oracle.com>
To: ast@kernel.org, andrii@kernel.org, eddyz87@gmail.com, qmo@kernel.org
Cc: jolsa@kernel.org, daniel@iogearbox.net, ihor.solodrai@linux.dev,
        yonghong.song@linux.dev, song@kernel.org, martin.lau@linux.dev,
        memxor@gmail.com, emil@etsalapatis.com, bpf@vger.kernel.org,
        nsc@kernel.org, puranjay@kernel.org, yatsenko@meta.com,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v2 bpf-next 3/3] selftests/bpf: Fix up bpftool btf dump test for signatures
Date: Fri, 25 Sep 2026 18:08:54 +0100
Message-ID: <20260925170854.1240637-4-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20260925170854.1240637-1-alan.maguire@oracle.com>
References: <20260925170854.1240637-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 suspectscore=0 malwarescore=0 adultscore=0 bulkscore=0 mlxlogscore=999
 lowpriorityscore=0 spamscore=0 phishscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2609040000 definitions=main-2609250066
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDA2OCBTYWx0ZWRfXwGlCa2HVevWZ
 IPrE2bhHRfHPuAHwj+Z7gzqBlwRjWyNJ15odQt1pekC6hClqVy3lBRBV+wE+MFctlusf506IhMj
 YTs1R5mYLcTPygNpcDc5xCvicKPVRmO19iAyCkbRqTPgNrAw/a6SkV7Fp187IjV0iqY2S7qtMNU
 MTsi7t2y+mhTB36HncI7G/Tz4JuNVoMCatVy7H2CNyTgbnVg8RDNN+nB8KZtzQFUSnrTVS2CSZE
 ZC4siMH7vXC5XX2r8g8FYLotdJHQyLLYyvHtHTlhzXaYIrxrvzYQS3MdUd8RFX8AVHsXE82zU/3
 6au25Wz5R2Dxt4i43wpX4ZbhDuKWAILjLhhWER1Zd9TYunzPeDKPb1rNTQ+ivCF2LVYlHmdQB6s
 drK77rhQgs8TnGkY47YB17v34WUyZZn8a+1gJPgE6qZ7duH+krUh/4DYxs4Py7NrV9Z3RKenpT7
 QV4R+2NaREHQwUxkf+C6xKrYSC0QMhcNW+NlaJmk=
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDA2OCBTYWx0ZWRfXyIRPO1xVrdEn
 39EfCLzOeQMRdMwerEwZq6PS+Ojp18FoBqAa/mlKzvL3fZOhXxhtBxV2NFUDne4TxWDiF5x7QwF
 XwQ/NR1jf9HESKoxCNk3AlOwOmWsQJYjfHX0YIu/yEYjf6JvxryY
X-Proofpoint-ORIG-GUID: LKLBG46SQaM3FPdVqioHYoI1X0sMG3eG
X-Authority-Analysis: v=2.4 cv=f+Ddl+yM c=1 sm=1 tr=0 ts=6ab6aab3 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=EIcjfB9IiI4px24ztqRk:22 a=yPCof4ZbAAAA:8 a=je0B4_M0PToKS-oWA3wA:9
 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:13532
X-Proofpoint-GUID: LKLBG46SQaM3FPdVqioHYoI1X0sMG3eG

Now we show a function signature, fix up the test to expect it.
Also fix the fact that we did not add the right number of parameters
to the FUNC_PROTO, and ensure consts/addresses are prefixed
appropriately.

Fixes: 321562c34d5b ("bpftool: Add ability to dump LOC_PARAM, LOC_PROTO and LOCSEC")
Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 .../selftests/bpf/prog_tests/bpftool_btf_dump.c    | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/bpftool_btf_dump.c b/tools/testing/selftests/bpf/prog_tests/bpftool_btf_dump.c
index bed506badc75..abc62958b6ed 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpftool_btf_dump.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpftool_btf_dump.c
@@ -72,6 +72,7 @@ static struct btf *mk_loc_btf(void)
 	btf__add_func_param(btf, "arg3", 1);
 	btf__add_func_param(btf, "arg4", 1);
 	btf__add_func_param(btf, "arg5", 1);
+	btf__add_func_param(btf, "arg6", 1);
 	btf__add_func(btf, "foo", BTF_FUNC_STATIC, 2);
 
 	btf__add_loc_param(btf, 4, BTF_LOC_PARAM_REG);
@@ -230,28 +231,29 @@ static void test_loc_dump(const char *btf_path)
 {
 	const char expected[] =
 		"[1] INT 'int' size=4 bits_offset=0 nr_bits=32 encoding=SIGNED\n"
-		"[2] FUNC_PROTO '(anon)' ret_type_id=1 vlen=5\n"
+		"[2] FUNC_PROTO '(anon)' ret_type_id=1 vlen=6\n"
 		"\t'arg1' type_id=1\n"
 		"\t'arg2' type_id=1\n"
 		"\t'arg3' type_id=1\n"
 		"\t'arg4' type_id=1\n"
 		"\t'arg5' type_id=1\n"
+		"\t'arg6' type_id=1\n"
 		"[3] FUNC 'foo' type_id=2 linkage=static\n"
 		"[4] LOC_PARAM '(anon)' size=4 flags=0x8 vlen=1 values='reg1'\n"
 		"[5] LOC_PARAM '(anon)' size=8 flags=0x38 vlen=2 values='*(reg2 + 0x10)'\n"
 		"[6] LOC_PARAM '(anon)' size=8 flags=0x29 vlen=2 values='fbreg - 0x10'\n"
-		"[7] LOC_PARAM '(anon)' size=8 flags=0x6 vlen=2 values='0x123456789abcdef0 (addr)'\n"
-		"[8] LOC_PARAM '(anon)' size=8 flags=0x2 vlen=2 values='0xdeadbeeffeedface'\n"
+		"[7] LOC_PARAM '(anon)' size=8 flags=0x6 vlen=2 values='address 0x123456789abcdef0'\n"
+		"[8] LOC_PARAM '(anon)' size=8 flags=0x2 vlen=2 values='const 0xdeadbeeffeedface'\n"
 		"[9] LOC_PARAM '(anon)' size=8 flags=0x39 vlen=2 values='*(fbreg - 0x20)'\n"
 		"[10] LOC_PROTO '(anon)' vlen=6\n"
 		"\ttype_id=4 value='reg1'\n"
 		"\ttype_id=5 value='*(reg2 + 0x10)'\n"
 		"\ttype_id=6 value='fbreg - 0x10'\n"
-		"\ttype_id=7 value='0x123456789abcdef0 (addr)'\n"
-		"\ttype_id=8 value='0xdeadbeeffeedface'\n"
+		"\ttype_id=7 value='address 0x123456789abcdef0'\n"
+		"\ttype_id=8 value='const 0xdeadbeeffeedface'\n"
 		"\ttype_id=9 value='*(fbreg - 0x20)'\n"
 		"[11] LOCSEC 'inline.text' vlen=1\n"
-		"\tname='foo' func_type_id=3 loc_proto_type_id=10 offset=64\n";
+		"\tfunc='foo(arg1 [reg1], arg2 [*(reg2 + 0x10)], arg3 [fbreg - 0x10], arg4 [address 0x123456789abcdef0], arg5 [const 0xdeadbeeffeedface], arg6 [*(fbreg - 0x20)])' func_type_id=3 loc_proto_type_id=10 offset=64\n";
 	char *dump;
 
 	dump = dump_raw(btf_path);
-- 
2.43.5

