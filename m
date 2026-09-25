Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98CD237998B
	for <bpf@vger.kernel.org>; Fri, 25 Sep 2026 09:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790329995; cv=none; b=PFwUb7KOjPhE/rshg43CA3+RmjtxuP0jIi3qcuga2x+mEMZAfm2xlG6U66i3D/2fCMel2OHsIQ8mg9BVJGDSKzlzb0v/Pc8UME7WIkboDscP3ZSvOfRcUcT8FdHFTLTd1WKRaAceTyq37LjubYrdXhwKkqHNKzkM2VWuWFSjqLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790329995; c=relaxed/simple;
	bh=1f4Ov4Qov1PZo9EI7fi0zlG9Are4tSxLRfNDia5+wl0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QRQrjUlcl2rpwjWecQkPvBqjNaZklEuPcJcXU16uOJPPekOMJ1apnXAonlaWIGK3TeH0vaDayzMwWCUsyo3+j+rfL1P+O46bpIXz+TjCy146kHq41xrIzhok/4f68VTC9M9cyEAnTo9lzWvqbblSBbR8Cu0fUrzr7l/PFbGQPbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=WdX9YrZ4; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WdX9YrZ4"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68P2aixH1891261;
	Fri, 25 Sep 2026 09:52:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=1COZG
	6kAhwouvu+qUXiKDZ4MFmowL8FQMaLREvoeCh0=; b=WdX9YrZ43i7dlLbVcVVjG
	uMrKCE/gu5XKRYm/MepbyTRDvv/OAlJYl8Lkkk1Ks0CGq69fjryo9UqN2uCircP5
	bjy6TGj3lsCmBmVkatNrDsM/fcyr9P4aZb1K7YLVYu58RbGM/nfcEaUIkSLjhs1N
	JAUXTx5JNSgfH29sQ2UlsN/jZSIzOgA1J7n0QI58IFtzxkdMB+DnM0R76B6Z0O5w
	xXpKypvL6kC3Fv00N5GIcJzCZWXR2xY8mCinKfFnfFh1veRTZJJGVcYSCV6KZ9Px
	kaFN8V3HZtA4schzqN4t2jd2tSFTOh+O3wVj1jpJNsECbY368q/aw/wcLjMD4pKq
	w==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4gsk0xs3qj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Sep 2026 09:52:43 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 68P9oOmu004004;
	Fri, 25 Sep 2026 09:52:43 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4gtept1dr5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Sep 2026 09:52:43 +0000 (GMT)
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 68P9mZYj001344;
	Fri, 25 Sep 2026 09:52:42 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-81-122.vpn.oracle.com [10.154.81.122])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4gtept1djn-4;
	Fri, 25 Sep 2026 09:52:42 +0000 (GMT)
From: Alan Maguire <alan.maguire@oracle.com>
To: ast@kernel.org, andrii@kernel.org, eddyz87@gmail.com, qmo@kernel.org
Cc: jolsa@kernel.org, daniel@iogearbox.net, ihor.solodrai@linux.dev,
        yonghong.song@linux.dev, song@kernel.org, martin.lau@linux.dev,
        memxor@gmail.com, emil@etsalapatis.com, bpf@vger.kernel.org,
        nsc@kernel.org, puranjay@kernel.org, yatsenko@meta.com,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH bpf-next 3/3] selftests/bpf: Fix up bpftool btf dump test for signatures
Date: Fri, 25 Sep 2026 10:52:31 +0100
Message-ID: <20260925095231.879708-4-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20260925095231.879708-1-alan.maguire@oracle.com>
References: <20260925095231.879708-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 suspectscore=0 malwarescore=0 adultscore=0 bulkscore=0 mlxlogscore=999
 lowpriorityscore=0 spamscore=0 phishscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2609040000 definitions=main-2609250039
X-Authority-Analysis: v=2.4 cv=F/bC5ahN c=1 sm=1 tr=0 ts=6ab6446b b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=3I1J8UUJPc9JN9BFgKH3:22 a=yPCof4ZbAAAA:8 a=je0B4_M0PToKS-oWA3wA:9
 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:13532
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDAzOSBTYWx0ZWRfX+FNMM5H6VbnJ
 kh810g6PSOiv9Gra/EDmHlPKGCNoOWSHaL+1BemfW8xc/q69pRNXqc+uLHSnS8vMjW0KIhV9b2d
 iqLMcBClajzmN4EuYwUuXi9pNpZCiqoR84iwhOJBskXSYiDO5LCA
X-Proofpoint-ORIG-GUID: onnRoZTFQY2DuF9v4thdijjsxNLycIyv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDAzOSBTYWx0ZWRfX6fcd85QTnJmv
 52hclaQyKDXWmyBHqy4zKIadrKPhAsqbHkTIQXT/RGHBHbDxr/yQmXQjvS4nI9wMDrkQIQfDjQc
 mV60BlGxW6m3mbVTZJDF0SdSriuiYgr/XA8vdf38LcO0+q42Aex0RwIotnwZFZUvVCUy8S+1s0O
 cS8KofCk64dnzcVtjkUJ69009rn+HSLfTNcQ5lyg7uVh8oCFc2AaHRKkr60fpDhxe9SQPW+kK6U
 Zs/+GHwCnU96CjHlLwSVqSHy9TUL9ABlaS4mnJccYK56hcASWndtBMCV1hTAKlMwuN4IJRvlGoA
 2l0eDQVv0bp6kEPWyLaLJ/dg+kohLm4Nd6o4StzAsq6XX1rff02+f0Zbl3c+s0zKKHcr/QlNsIG
 06xYghRrDtGMZxMhIViU0Loid3/4dLNDytnL6TzYkda4gNjttW+26YPuOdhJaSdFmpN675GRU9u
 gBJ/QHfJD+F7pLc8ex+9WdnBg14jIWxN98DAT69Q=
X-Proofpoint-GUID: onnRoZTFQY2DuF9v4thdijjsxNLycIyv

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

