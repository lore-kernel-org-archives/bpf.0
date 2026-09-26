Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67B56364933
	for <bpf@vger.kernel.org>; Sat, 26 Sep 2026 17:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790445117; cv=none; b=BmzOGfPOwWGcx//Xun8LKn3+0OGeCtXvjJuPa1t8K2/yRw6qdXp3fqIMXAoq571twVKoKlOb/RCKq6AkfWHuWxk4EqFbZ6VbqOfvOuH2uNnDdl4BoiCJxVXH5Ra5EK533F9UQJl8QanCS8bsNt9D3Zk7lJRRUWlt7tw9npMTUZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790445117; c=relaxed/simple;
	bh=1f4Ov4Qov1PZo9EI7fi0zlG9Are4tSxLRfNDia5+wl0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VSptmxcNWQNnmPxr5UppO8mhJWJA57z9R1YxRIvGuH34G725DJmtifOH4cBkFTHjqvGeDDcNRx8FCQGAe1U9Va15/siRDLvRIze6kdFYAJO9WSjTsBKQfAKsRAxn6F5db+lXHIikvhynI8IV7HGWZAwOoDxDLHCdSUnA6+jsnfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=CIyJtmEU; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CIyJtmEU"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68QGmRaH3917846;
	Sat, 26 Sep 2026 17:51:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=1COZG
	6kAhwouvu+qUXiKDZ4MFmowL8FQMaLREvoeCh0=; b=CIyJtmEUOOUm61RIG2JKh
	lqtB+UJ2S8j/QZLjFnW2vMfyejnY83Sfw4Y7axSxsroigSkeB1gUr8DCRRj22Iec
	mS8b90FiUcC3gIrY+eMxToyQUzwFvD2c07GXK/moZqhXVMjHQ8M3qKD5DsAwkt4j
	s2LgsFv0Kvq8wi2l3+LKe7q82CgzsRHUInWteSIVjvsAitV+gvHUvNQ3r7d/sDlF
	vvy5BxXjPLqXQvOw/NVDysEbqVAttudahQpxfPHHWYmmuHKKGDd/7SNH1Nh9EPx3
	GDHDpR3A3q/MBmnn/NtxxxuZ76qO0Hx6S671Bd+n8oOIWnCeaQdLRXqqXrNgUdnN
	Q==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4gx4my8cce-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 26 Sep 2026 17:51:29 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 68QHo3J3017918;
	Sat, 26 Sep 2026 17:51:29 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4gx4g8nbgw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 26 Sep 2026 17:51:29 +0000 (GMT)
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 68QHpHsb020485;
	Sat, 26 Sep 2026 17:51:28 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-81-123.vpn.oracle.com [10.154.81.123])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4gx4g8nbb1-4;
	Sat, 26 Sep 2026 17:51:28 +0000 (GMT)
From: Alan Maguire <alan.maguire@oracle.com>
To: ast@kernel.org, andrii@kernel.org, eddyz87@gmail.com, qmo@kernel.org
Cc: jolsa@kernel.org, daniel@iogearbox.net, ihor.solodrai@linux.dev,
        yonghong.song@linux.dev, song@kernel.org, martin.lau@linux.dev,
        memxor@gmail.com, emil@etsalapatis.com, bpf@vger.kernel.org,
        nsc@kernel.org, puranjay@kernel.org, yatsenko@meta.com,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v3 bpf-next 3/3] selftests/bpf: Fix up bpftool btf dump test for signatures
Date: Sat, 26 Sep 2026 18:51:13 +0100
Message-ID: <20260926175113.2368566-4-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20260926175113.2368566-1-alan.maguire@oracle.com>
References: <20260926175113.2368566-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-26_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxlogscore=999 lowpriorityscore=0 malwarescore=0 phishscore=0 suspectscore=0
 mlxscore=0 spamscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2609040000 definitions=main-2609260071
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI2MDA3MSBTYWx0ZWRfX/F95+JNVYJ7U
 k/qK00uGD75ybaZLkdJQB2M4mibhm0AGjrgBqSEGehjR7H/X8WJ5JqQ4RDjVISS+vD2XnxhSkXx
 fL+4oDgixSPZFyIf+jibIlFSJw9O2tbGH19lcmgImg2VEYHnzHAJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI2MDA3MSBTYWx0ZWRfX7ALEPrZltdzQ
 D8yCxqoc/JRc+7qTUZfJ07t3K0LFRvIrFePSifZ43xCrcwEeyX8M1ybrOdFYYgSB1Hiqp9YtT1Y
 emjJoAojxwAStPTaTfZlivm7fJxWlfxdsf9c/XJ91RomjlUq0kbyiWT7VTPMnkiYmi1ZJ7Rv3KY
 X9Rcp6blAyqq+hfh4ydQCUp9LZV1sQBJ/vTa928oqSejk3Oy+iL2bpboOuqv0YTuXPjhRxeXnXh
 RFShDMYdKojj7KDXyRGftHAlPawuDrt77VHQEpW/zLVjejxnS4yfcGrbIrl2TcP5un1xG7XWdzh
 9qdSJXDXksafGgURZlFqQCeiQEtKASBSaKrawynwxamchEJNYLR8KXOUi2dkxoYaoYGN9PMvLzE
 6vn2MabtYHplXLWZOB+fY8c9/pV9Torupn3syHO+MH4s9Wz6BOCLcejhH8UKnNBtjmAaOSLUFW3
 fR8WmfI+x5JJ7moMLzg==
X-Proofpoint-GUID: GF_5f2hJnXwcqtODCU8cQ3ye6XNqiHXm
X-Authority-Analysis: v=2.4 cv=DZmCOftW c=1 sm=1 tr=0 ts=6ab80621 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=RD47p0oAkeU5bO7t-o6f:22 a=yPCof4ZbAAAA:8 a=je0B4_M0PToKS-oWA3wA:9
 a=WmVTiCyuxqgg3mnwYu6p:22
X-Proofpoint-ORIG-GUID: GF_5f2hJnXwcqtODCU8cQ3ye6XNqiHXm

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

