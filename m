Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E42232C94A
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 11:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790248538; cv=none; b=MiVTosZBGkGOkI2z9nHa9L17jQIFJ5eTLK0OX07YAxY/lx5KwOU38+m2CU/zdPf2rfaFsFd2YYGlES8MrrBj2bq6YbrcKcvsXH2YdKpa+queWmHKo/DAG1yrKgMpFJ41X/BOEh4QRfOhHogp9+CJCRUcCmBsJz6w/si99xd+4Ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790248538; c=relaxed/simple;
	bh=p2XnadhWVgtWgVpvE/0BhbZN+rd1VNOrDdgj5ACoaHg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FRZS5CHru6FTDXyH2sc64iJ/yjSK7F8ib4l3aAc/8XBjECztzaNOVzQvJFgjer9XUIb+yH7z+52BdrMi+R0pzJm4HaUDxFQjbYsxcZtOOXDnVEQfI4NDtxQHFY0w5T7kAMwPzbw1A6bPlDOUmms6dkT5gcKgnhBxHPCzVnly2oE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ge6eeB5a; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ge6eeB5a"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68O6CVh74014715;
	Thu, 24 Sep 2026 11:15:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=L3Uaw
	XuLXV8CoukIRbJKb3vWSKzGqRTO8WrcWvVX8GE=; b=ge6eeB5aasdk6LIXc2HPb
	JF/OvTHfCOt228pdi6nKphrMnhOTgtGFVp2kOY7cUZBt/BamCSx4/5VJf61iVfx+
	NMwuh5wJovs+SKcahr2SCQmK7TzCWxC2hKc0fPDkpoil2ODgaO5mPhTfepRouL04
	ZlEtxUOydV2qTRXUNTi/UJaU1Oka9jvpSCfC+icErZh9AbPWyPBV9k2+zXSBxHwC
	153GYJd7+ZPzHsuoSN0ZLcbe2HVXloArsvUDDp5EJKhLIDbeQ0QInJVuXOJ/VBvC
	PQw4LJNOUXjcFr3aSiUSKNJi1GYQeQAAhVk5pcFNuheyL30Yv3sb98pwQ8YW9kAl
	A==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4gsk1dybun-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Sep 2026 11:15:08 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 68OB5bel013297;
	Thu, 24 Sep 2026 11:15:08 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4guf119mjt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Sep 2026 11:15:08 +0000 (GMT)
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 68OBEVuP002821;
	Thu, 24 Sep 2026 11:15:07 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-80-22.vpn.oracle.com [10.154.80.22])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4guf119knh-11;
	Thu, 24 Sep 2026 11:15:07 +0000 (GMT)
From: Alan Maguire <alan.maguire@oracle.com>
To: ast@kernel.org, andrii@kernel.org, eddyz87@gmail.com, qmo@kernel.org
Cc: jolsa@kernel.org, daniel@iogearbox.net, ihor.solodrai@linux.dev,
        yonghong.song@linux.dev, song@kernel.org, martin.lau@linux.dev,
        memxor@gmail.com, emil@etsalapatis.com, bpf@vger.kernel.org,
        nsc@kernel.org, puranjay@kernel.org, yatsenko@meta.com,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v4 bpf-next 10/11] selftests/bpf: Test bpftool dump of BTF location info
Date: Thu, 24 Sep 2026 12:14:27 +0100
Message-ID: <20260924111428.75957-11-alan.maguire@oracle.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDA0NiBTYWx0ZWRfX8FkysvhMn6Mx
 8UO7oU5FGWlhV990OIaJycJOrGb1d8GK2nA7e01qLOiJRR7TyLlcOc1UfGn5/px6uG9TkrDXUdw
 UCCIEIyl0hovjCsQT1L7atsA5nt74m0ZNNgt5lo/kzMZ0cXlMRQp7owNnH70DTZa8DYAJB6u/Z1
 UKC4jMhaOkpXrgJcIOm7L5OdOV75Y4FmmNVlmIpfA3D2WIhvnpHePhQ3bqjsw2hnpnLVg5E/3lm
 xLNxxstV3rz32A2W1XLDiHFA+gRTFV9Y0HmaLvdhv8zQpSL4cNlRrum59eDXI8n/Pa8V5ZuqB7Y
 GNeihtgEC6t8U5e15mZalTfI49+ZJM36Ei+GUqfKsNnLRgXAHZq2roA/cgY9BThVSFHngs8wElE
 UMiobdyV92lG07DkjyadM711ITprNs+U2pGdOzfM1G5ArWqWCG9QqV2qpOFBQEAYCrd8+hIntfG
 SjlF9egpcKsWV3fdtfGDDrozC5TxrX0LEI87Hwu8=
X-Proofpoint-GUID: i-tgW2FogX573FOmo_6nADMSy7wXq2Da
X-Proofpoint-ORIG-GUID: i-tgW2FogX573FOmo_6nADMSy7wXq2Da
X-Authority-Analysis: v=2.4 cv=eNqGH3p1 c=1 sm=1 tr=0 ts=6ab5063c b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=o5oIOnhZENCTenyL_yNV:22 a=yPCof4ZbAAAA:8 a=vvOnMJ2gDJLj44B1wEoA:9
 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:12106
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDA0NiBTYWx0ZWRfX8VLeJ4eG/XBe
 eXmW3HsNo5hy+4qI4adJ95B4dbNfaV/E2G4syW9rXNYA8IANEtqOz5xtZC28XqFJ6ryY4KgNuXf
 6Zt9Yq6h+fkMm8inH0+ZDSAyQ9KPBqtwWtkzEZJC4r47aFg//0gl

Add a bpftool raw BTF dump test covering LOC_PARAM, LOC_PROTO, and
LOCSEC types. Verify LOC_PARAM expressions, LOC_PROTO parameter values,
and LOCSEC function name, type id, and offset output.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
Assisted-by: OpenAI Codex (GPT 5.6)
---
 .../bpf/prog_tests/bpftool_btf_dump.c         | 121 +++++++++++++++++-
 1 file changed, 120 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/bpftool_btf_dump.c b/tools/testing/selftests/bpf/prog_tests/bpftool_btf_dump.c
index d5b25302b0c8..bed506badc75 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpftool_btf_dump.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpftool_btf_dump.c
@@ -57,6 +57,57 @@ static struct btf *mk_btf(void)
 	return btf;
 }
 
+static struct btf *mk_loc_btf(void)
+{
+	struct btf *btf;
+
+	btf = btf__new_empty();
+	if (!ASSERT_OK_PTR(btf, "new_empty"))
+		return NULL;
+
+	btf__add_int(btf, "int", 4, BTF_INT_SIGNED);
+	btf__add_func_proto(btf, 1);
+	btf__add_func_param(btf, "arg1", 1);
+	btf__add_func_param(btf, "arg2", 1);
+	btf__add_func_param(btf, "arg3", 1);
+	btf__add_func_param(btf, "arg4", 1);
+	btf__add_func_param(btf, "arg5", 1);
+	btf__add_func(btf, "foo", BTF_FUNC_STATIC, 2);
+
+	btf__add_loc_param(btf, 4, BTF_LOC_PARAM_REG);
+	btf__add_loc_param_value(btf, 1);
+	btf__add_loc_param(btf, 8, BTF_LOC_PARAM_REG |
+			    BTF_LOC_PARAM_DEREF | BTF_LOC_PARAM_OFFSET);
+	btf__add_loc_param_value(btf, 2);
+	btf__add_loc_param_value(btf, 0x10);
+	btf__add_loc_param(btf, 8, BTF_LOC_PARAM_REG |
+			   BTF_LOC_PARAM_OFFSET | BTF_LOC_PARAM_SIGNED);
+	btf__add_loc_param_value(btf, BTF_LOC_PARAM_FBREG);
+	btf__add_loc_param_value(btf, -0x10);
+	btf__add_loc_param(btf, 8, BTF_LOC_PARAM_ADDR | BTF_LOC_PARAM_CONST);
+	btf__add_loc_param_value(btf, 0x9abcdef0);
+	btf__add_loc_param_value(btf, 0x12345678);
+	btf__add_loc_param(btf, 8, BTF_LOC_PARAM_CONST);
+	btf__add_loc_param_value(btf, 0xfeedface);
+	btf__add_loc_param_value(btf, 0xdeadbeef);
+	btf__add_loc_param(btf, 8, BTF_LOC_PARAM_REG |
+			    BTF_LOC_PARAM_DEREF | BTF_LOC_PARAM_OFFSET |
+			    BTF_LOC_PARAM_SIGNED);
+	btf__add_loc_param_value(btf, BTF_LOC_PARAM_FBREG);
+	btf__add_loc_param_value(btf, -0x20);
+	btf__add_loc_proto(btf);
+	btf__add_loc_proto_param(btf, 4);
+	btf__add_loc_proto_param(btf, 5);
+	btf__add_loc_proto_param(btf, 6);
+	btf__add_loc_proto_param(btf, 7);
+	btf__add_loc_proto_param(btf, 8);
+	btf__add_loc_proto_param(btf, 9);
+	btf__add_locsec(btf, "inline.text");
+	btf__add_locsec_loc(btf, 3, 10, 64);
+
+	return btf;
+}
+
 static int btf_to_tmpfile(const struct btf *btf, char *path)
 {
 	ssize_t written;
@@ -105,6 +156,26 @@ static char *dump_c(const char *btf_path, bool sorted)
 	return buf;
 }
 
+static char *dump_raw(const char *btf_path)
+{
+	char args[MAX_BPFTOOL_CMD_LEN];
+	char *buf;
+	int err;
+
+	buf = malloc(DUMP_BUF_SZ);
+	if (!ASSERT_OK_PTR(buf, "alloc_dump"))
+		return NULL;
+
+	snprintf(args, sizeof(args), "btf dump file %s", btf_path);
+	err = get_bpftool_command_output(args, buf, DUMP_BUF_SZ);
+	if (!ASSERT_OK(err, "btf_dump_raw")) {
+		free(buf);
+		return NULL;
+	}
+
+	return buf;
+}
+
 static char *read_expected(const char *path)
 {
 	char *buf = NULL;
@@ -155,10 +226,46 @@ static void test_dump(const char *btf_path, bool sorted)
 	free(dump);
 }
 
+static void test_loc_dump(const char *btf_path)
+{
+	const char expected[] =
+		"[1] INT 'int' size=4 bits_offset=0 nr_bits=32 encoding=SIGNED\n"
+		"[2] FUNC_PROTO '(anon)' ret_type_id=1 vlen=5\n"
+		"\t'arg1' type_id=1\n"
+		"\t'arg2' type_id=1\n"
+		"\t'arg3' type_id=1\n"
+		"\t'arg4' type_id=1\n"
+		"\t'arg5' type_id=1\n"
+		"[3] FUNC 'foo' type_id=2 linkage=static\n"
+		"[4] LOC_PARAM '(anon)' size=4 flags=0x8 vlen=1 values='reg1'\n"
+		"[5] LOC_PARAM '(anon)' size=8 flags=0x38 vlen=2 values='*(reg2 + 0x10)'\n"
+		"[6] LOC_PARAM '(anon)' size=8 flags=0x29 vlen=2 values='fbreg - 0x10'\n"
+		"[7] LOC_PARAM '(anon)' size=8 flags=0x6 vlen=2 values='0x123456789abcdef0 (addr)'\n"
+		"[8] LOC_PARAM '(anon)' size=8 flags=0x2 vlen=2 values='0xdeadbeeffeedface'\n"
+		"[9] LOC_PARAM '(anon)' size=8 flags=0x39 vlen=2 values='*(fbreg - 0x20)'\n"
+		"[10] LOC_PROTO '(anon)' vlen=6\n"
+		"\ttype_id=4 value='reg1'\n"
+		"\ttype_id=5 value='*(reg2 + 0x10)'\n"
+		"\ttype_id=6 value='fbreg - 0x10'\n"
+		"\ttype_id=7 value='0x123456789abcdef0 (addr)'\n"
+		"\ttype_id=8 value='0xdeadbeeffeedface'\n"
+		"\ttype_id=9 value='*(fbreg - 0x20)'\n"
+		"[11] LOCSEC 'inline.text' vlen=1\n"
+		"\tname='foo' func_type_id=3 loc_proto_type_id=10 offset=64\n";
+	char *dump;
+
+	dump = dump_raw(btf_path);
+	if (!dump)
+		return;
+
+	ASSERT_OK(compare_text_to_expected(dump, expected), "cmp_loc_dump");
+	free(dump);
+}
+
 void test_bpftool_btf_dump(void)
 {
 	char path[PATH_MAX];
-	struct btf *btf;
+	struct btf *btf = NULL;
 
 	btf = mk_btf();
 	if (!btf)
@@ -171,7 +278,19 @@ void test_bpftool_btf_dump(void)
 		test_dump(path, true);
 	if (test__start_subtest("c_unsorted"))
 		test_dump(path, false);
+	unlink(path);
+
+	btf__free(btf);
+
+	btf = mk_loc_btf();
+	if (!btf)
+		return;
+
+	if (btf_to_tmpfile(btf, path))
+		goto out_btf;
 
+	if (test__start_subtest("loc_dump"))
+		test_loc_dump(path);
 	unlink(path);
 out_btf:
 	btf__free(btf);
-- 
2.43.5

