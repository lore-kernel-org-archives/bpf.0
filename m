Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6650F4582E4
	for <bpf@vger.kernel.org>; Wed, 16 Sep 2026 07:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789544557; cv=none; b=aET0zpF6XVj8Lpr4AtaOXMzAZ7a+HrkAJleCW1Q8OC1nRJ5H6Tig+gW+XnzRmh5Ro1W8312N5OS8s7YTXy6zY3pTgy7GU6knsfjTcx+YjD5Xj5dtchVls3B7Q+2beJoPe7hFdHY1V9TNV5Np+7gjquTrAHeBGFMLFjgs2pXm7Wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789544557; c=relaxed/simple;
	bh=SLjzIxBT91gPOAkiUAqRYQmjMe2WjNNezKoKRZtTUUw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cj52H5j5t3zSVxvBVMCLIYhkbtMAHDLGd+YSdSm5Xze6/rI8qHi6APwMZkrsqg+xAFVCD69IjyU2rtO18qZ2tgUaqY6dOuF2itv8drn6frIayx3Nu+Bj6BJl0hsw6EghBcW0aQdi0jWppwgr0woIjeX+THfkKcrSyT9gn+zOudw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=pLfKgb4U; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="pLfKgb4U"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68G4w1Pf2043011;
	Wed, 16 Sep 2026 07:42:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=unGlb
	BaltWh4LDsn080SFQLBDODVEc6IsysU7rpJOQk=; b=pLfKgb4U7JNbdGnmIN1rN
	bUR60E1ocuv6c6Wt2E/XG5nud5eYWED3v3/2g3VhpXchlv4WCUNm9hLtmB861pzJ
	tH08lloYDtdoetTE5uSKB8AHF10Xj/3tpgqMeb52olgD656D5odYwLchAsvcOzyd
	j4LtHvL5piaoSBQiyKCC5VOtbVvGwKgtC+L4MDimH0q9cl2df7Lpznz1CC3/8Ez+
	dhBSUuAHGHx45N4jEecrFVremmEV8GlaDRmZ7B1Hj+fR/H4fZiM/g7n2+UzynwMT
	eVKYOLMbuQGbjKZdIIcf1Vg6RgCSP5nLCe9VLT8sPf6BxLo9KMYcI+nnXgzm0qNx
	g==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4gmwn95514-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Sep 2026 07:42:01 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 68G7e3A2014858;
	Wed, 16 Sep 2026 07:42:00 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4gmw6au57j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Sep 2026 07:42:00 +0000 (GMT)
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 68G7exQ1020284;
	Wed, 16 Sep 2026 07:41:59 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-86-81.vpn.oracle.com [10.154.86.81])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4gmw6au4u1-11;
	Wed, 16 Sep 2026 07:41:59 +0000 (GMT)
From: Alan Maguire <alan.maguire@oracle.com>
To: ast@kernel.org, andrii@kernel.org, eddyz87@gmail.com, jolsa@kernel.org
Cc: daniel@iogearbox.net, ihor.solodrai@linux.dev, yonghong.song@linux.dev,
        song@kernel.org, qmo@kernel.org, martin.lau@linux.dev,
        memxor@gmail.com, emil@etsalapatis.com, bpf@vger.kernel.org,
        nsc@kernel.org, puranjay@kernel.org, yatsenko@meta.com,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v3 bpf-next 10/11] selftests/bpf: Test bpftool dump of BTF location info
Date: Wed, 16 Sep 2026 08:41:17 +0100
Message-ID: <20260916074118.1007116-11-alan.maguire@oracle.com>
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
X-Proofpoint-GUID: 3qnMGV36s5BT6a9MAqO65znTvZGBXOno
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE2MDA5OSBTYWx0ZWRfX/2/ptOS4XFDf
 LO124mw3WgvyDXqI4frzBKJpEL9Z5FUgs2poLtT/KNJw3suDBSUW8hgcirORPF1RHKB6F9ZMfYp
 W4A7jJskftJGdySLG0rKB/YR8DjbZhVtH3lrr4o76p8sfjDjBa8R
X-Proofpoint-ORIG-GUID: 3qnMGV36s5BT6a9MAqO65znTvZGBXOno
X-Authority-Analysis: v=2.4 cv=c9k+0h9l c=1 sm=1 tr=0 ts=6aaa4849 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=x0eKOSpe3m1H3M0S9YoZ:22 a=yPCof4ZbAAAA:8 a=9B_al4-hnjAZ3VjU-jYA:9
 a=WmVTiCyuxqgg3mnwYu6p:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE2MDA5OSBTYWx0ZWRfX5E62RBzrhOjW
 g7/J069RJutXM/UTEjaUKTJhmcAyJ78VeP9Z2rYGaBbU256+WI7mob45rOR1wRUoT9jkwBFA4t+
 dGYm9XA8/wChjmFi/AVkTjqPacN+2hnAlzooRBnBpYeNnNliIy00Gidla5JtWAjpBWzNlfAbuG8
 C137oQ+MUeZbBJ9mz+Om36UXjrSm3O/2BWR12umTA7WR8BDgbmOdY+q50D2xxNYZbSPckvKc1R1
 gzRCQo2qPhT8bUWXutUuyK4n28Ag6avT7n2lSyQ5rJYLeItLagsgDHa8hPj/msvpOYx9ZH7CyTK
 p/hPSbqprjH9ExYIGJom8kDblfKhVkZ2bsS10xUMvewACcaGlGBWEU163Tj2W8ORQU5Ri5vjASZ
 vLcOyDDPrSDXu2oiCQiO0VD8/l2Z9NOo7KdbjYFFKQbo92zQnFWD/0QsyOQBiEBDEwKO6JGiViO
 BgfiGh/Fb8tyWtdWb6Q==

Add a bpftool raw BTF dump test covering LOC_PARAM, LOC_PROTO, and
LOCSEC types. Verify LOC_PARAM expressions, LOC_PROTO parameter values,
and LOCSEC function name, type id, and offset output.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
Assisted-by: OpenAI Codex (GPT 5.6)
---
 .../bpf/prog_tests/bpftool_btf_dump.c         | 84 +++++++++++++++++++
 1 file changed, 84 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/bpftool_btf_dump.c b/tools/testing/selftests/bpf/prog_tests/bpftool_btf_dump.c
index d5b25302b0c8..f8ea9dfd0780 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpftool_btf_dump.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpftool_btf_dump.c
@@ -57,6 +57,35 @@ static struct btf *mk_btf(void)
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
+	btf__add_func(btf, "foo", BTF_FUNC_STATIC, 2);
+
+	btf__add_loc_param(btf, 4, BTF_LOC_PARAM_REG);
+	btf__add_loc_param_value(btf, 1);
+	btf__add_loc_param(btf, 8, BTF_LOC_PARAM_REG |
+			    BTF_LOC_PARAM_DEREF | BTF_LOC_PARAM_OFFSET);
+	btf__add_loc_param_value(btf, 2);
+	btf__add_loc_param_value(btf, 0x10);
+	btf__add_loc_proto(btf);
+	btf__add_loc_proto_param(btf, 4);
+	btf__add_loc_proto_param(btf, 5);
+	btf__add_locsec(btf, "inline.text");
+	btf__add_locsec_loc(btf, 3, 6, 64);
+
+	return btf;
+}
+
 static int btf_to_tmpfile(const struct btf *btf, char *path)
 {
 	ssize_t written;
@@ -105,6 +134,26 @@ static char *dump_c(const char *btf_path, bool sorted)
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
@@ -155,6 +204,31 @@ static void test_dump(const char *btf_path, bool sorted)
 	free(dump);
 }
 
+static void test_loc_dump(const char *btf_path)
+{
+	const char expected[] =
+		"[1] INT 'int' size=4 bits_offset=0 nr_bits=32 encoding=SIGNED\n"
+		"[2] FUNC_PROTO '(anon)' ret_type_id=1 vlen=2\n"
+		"\t'arg1' type_id=1\n"
+		"\t'arg2' type_id=1\n"
+		"[3] FUNC 'foo' type_id=2 linkage=static\n"
+		"[4] LOC_PARAM '(anon)' size=4 flags=0x8 vlen=1 values='r1'\n"
+		"[5] LOC_PARAM '(anon)' size=8 flags=0x38 vlen=2 values='*(r2 + 0x10)'\n"
+		"[6] LOC_PROTO '(anon)' vlen=2\n"
+		"\ttype_id=4 value='r1'\n"
+		"\ttype_id=5 value='*(r2 + 0x10)'\n"
+		"[7] LOCSEC 'inline.text' vlen=1\n"
+		"\tname='foo' func_type_id=3 loc_proto_type_id=6 offset=64\n";
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
@@ -175,4 +249,14 @@ void test_bpftool_btf_dump(void)
 	unlink(path);
 out_btf:
 	btf__free(btf);
+
+	btf = mk_loc_btf();
+	if (!btf)
+		return;
+
+	if (!btf_to_tmpfile(btf, path) && test__start_subtest("loc_dump"))
+		test_loc_dump(path);
+
+	unlink(path);
+	btf__free(btf);
 }
-- 
2.43.5

