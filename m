Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFEA9488222;
	Tue,  1 Sep 2026 16:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788281939; cv=none; b=pfFfvKRdCq6T7Hy2PLOfl0GEW5bw36FQh8JOwVEptqjupfiHpvIDkZdgQ2z/i0IzJb+bR45JfJcNpY9oh7muDd/+JyX26b9bL7DjWUFUMtobDjzVoCS3Owty8SXo7natKlp3qVUMdGm4mo6hBYyHwOnb8ADqlp/LKHxwRMsmwsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788281939; c=relaxed/simple;
	bh=05Rsc0i4Nf8OPOZCMbx5DEkx8eW6BUNR7s13GyOJH7k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nlw7JDUY1m2RIv+FCMumEGAlwXzLT3A4VVePfCTKY8Ejj1hnbz0YjsdRdSXX+i0Yuu1d7mXVDjWp2cGBlv7VDHMM4DHBFYicwMCjqK/ogYkOlxKcRnzv/zLOnpj7/zqRnMh4CEaZnl6L9/txbaMyJMEFpzXlkylgHo8oTGhUNKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=H9W8ZKRv; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="H9W8ZKRv"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 681ESJNw4036326;
	Tue, 1 Sep 2026 16:58:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=U7W8M
	ZrQSmQiKNLIawiPwpVTO08p12C3fyXknRPcAkM=; b=H9W8ZKRvk8PX/KkXkpkgz
	mTdzHnvT2SAr+5wkxk49WquT5lwQjsOW9LryDD0eR1k01r0IA5+lJk1iq9ca+2Cr
	G1BAln5r8ZoqKzPNaJBnFbmLSJLWpfKQZV6DT60djKCDRCk+NitDwQvRnh7YpUr+
	vBSd8qxqnAtXWYIXDGunjzDQhieI9f8uocTXd+JwLOdm/l7YPj5n2JDPIhIpBZlj
	SLxCz/BwJCGHNxpajo4+2ZovZO8rt5tdcVTJLobX4xmMjqLAfLbhEg2S4VGU9Lnl
	qVmdh+fm3d7ZmO8gzHR1mb8zzvbTXuluxsg3vte6Oqv12jcZAz5HjftdLOMloSJh
	A==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4gbp0xw55n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 01 Sep 2026 16:58:32 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 681GjWko001967;
	Tue, 1 Sep 2026 16:58:31 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4gdymtg8xg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 01 Sep 2026 16:58:31 +0000 (GMT)
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 681Gw1W7011129;
	Tue, 1 Sep 2026 16:58:30 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-52-250.vpn.oracle.com [10.154.52.250])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4gdymtg8f6-9;
	Tue, 01 Sep 2026 16:58:30 +0000 (GMT)
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
Subject: [PATCH v2 bpf-next 08/18] selftests/bpf: Validate that btf__permute transfer works
Date: Tue,  1 Sep 2026 17:57:47 +0100
Message-ID: <20260901165757.801449-9-alan.maguire@oracle.com>
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
X-Proofpoint-ORIG-GUID: kUtTDS6E5j4lJZhd4NA9SGyeXJwPOfOt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAxMDE1MCBTYWx0ZWRfX9hTdjVkLhhQY
 Iq00XYhuf5w2gwkv3xaGeFKw8cwKY71H5GV073By1BVsHjaw6SEfH6t+b3Y+S80bfuQSOifQOpI
 pJl1qEP7VJSW4O9Zt3j2vbMRPVvxiivXhUG9hw++4RraijmvQawJRl2jx+EI5A3diimtDUXCp3p
 7v9bl8C4P0fFO+jF1+B6WeLr5ISaVqgynmxFOUkC/ru+bT+NztiJlXxig7F4FaD1SyzAxNWZVfl
 Jsu2KyF0sqwv6dtIIypHheLBhvzFJEWPqZXxwo7m58rNit9SF/c+Ta9Nt7fIfuqyxU1QxaI4RaC
 aEKCJh+2ThSRgg7S/oQHQaGfFGta2+0H6KEjYmKsWiKPZLX1R7OaxZElQDawdVCifefHYwTx8up
 GmiUd8Xva1SoS2Clqq3Sh8qO274AnLogRYwGMPYAhTZJVJVZu45tJHnyCPBJbXpAHMep/u97vIZ
 apAHxQo6yJ7sn91brZCZXDme+XiLHSH7tPttRT+E=
X-Authority-Analysis: v=2.4 cv=Ebb4hvmC c=1 sm=1 tr=0 ts=6a970438 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=RD47p0oAkeU5bO7t-o6f:22 a=yPCof4ZbAAAA:8 a=t_VFq3VvciteGG6EVC4A:9
 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:13521
X-Proofpoint-GUID: kUtTDS6E5j4lJZhd4NA9SGyeXJwPOfOt
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAxMDE1MCBTYWx0ZWRfX5ezOxO8JBpgg
 8YjPK0+Vjwy48/17Awzx0JS4UmYqc0D6M+dSfAo44w28fgNIWwHVruNjf6Xr5L01pgmCCBWbVXD
 dGeXuPxvJBm3tvKn/R+CKXHz/8w0dyVozP9aISffQCHK1Uij/ULb

Add coverage for btf__permute() transfer mode, including type-ID
remapping and LOCSEC record ordering in the resulting split BTF.

Verify string handling for both cases: a string used only by transferred
types is removed from the base BTF and deduplicated locally in the split
BTF, while a string also referenced by a retained base type remains a
base-string reference.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 .../selftests/bpf/prog_tests/btf_permute.c    | 128 ++++++++++++++++++
 1 file changed, 128 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/btf_permute.c b/tools/testing/selftests/bpf/prog_tests/btf_permute.c
index 04ade5ad77ac..ef75fd71df96 100644
--- a/tools/testing/selftests/bpf/prog_tests/btf_permute.c
+++ b/tools/testing/selftests/bpf/prog_tests/btf_permute.c
@@ -235,10 +235,138 @@ static void test_permute_split(void)
 	btf__free(base_btf);
 }
 
+/* Ensure selected types can be moved into a split BTF while permuting. */
+static void test_permute_transfer(void)
+{
+	struct btf *btf = NULL, *transfer_btf = NULL;
+	LIBBPF_OPTS(btf_permute_opts, opts);
+	__u32 permute_ids[11];
+	int err, id, foo_name_off = -1, shared_name_off, foo_funcs = 0, shared_funcs = 0;
+
+	btf = btf__new_empty();
+	if (!ASSERT_OK_PTR(btf, "empty_main_btf"))
+		return;
+
+	btf__add_int(btf, "int", 4, BTF_INT_SIGNED); /* [1] int */
+	btf__add_func_proto(btf, 1);                  /* [2] int (*)(void) */
+	btf__add_func(btf, "foo", BTF_FUNC_STATIC, 2); /* [3] int foo(void) */
+	btf__add_loc_param(btf, 4, BTF_LOC_PARAM_SIGNED); /* [4] location */
+	btf__add_loc_param_value(btf, 0);
+	btf__add_loc_proto(btf);                       /* [5] location proto */
+	btf__add_loc_proto_param(btf, 4);
+	btf__add_locsec(btf, ".locs");                /* [6] location section */
+	btf__add_locsec_loc(btf, 3, 5, 128);
+	btf__add_locsec_loc(btf, 3, 5, 0);
+	btf__add_int(btf, "long", 8, BTF_INT_SIGNED); /* [7] long */
+	btf__add_func(btf, "foo", BTF_FUNC_STATIC, 2);    /* [8] another foo */
+	btf__add_func(btf, "shared", BTF_FUNC_STATIC, 2); /* [9] shared string */
+	btf__add_struct(btf, "shared", 4);                /* [10] retains string */
+
+	permute_ids[0] = 0;
+	permute_ids[1] = 1;
+	permute_ids[2] = BTF_PERMUTE_ID_TRANSFER | 2;
+	permute_ids[3] = BTF_PERMUTE_ID_TRANSFER | 3;
+	permute_ids[4] = BTF_PERMUTE_ID_TRANSFER | 5;
+	permute_ids[5] = BTF_PERMUTE_ID_TRANSFER | 6;
+	permute_ids[6] = BTF_PERMUTE_ID_TRANSFER | 7;
+	permute_ids[7] = 4;
+	permute_ids[8] = BTF_PERMUTE_ID_TRANSFER | 8;
+	permute_ids[9] = BTF_PERMUTE_ID_TRANSFER | 9;
+	permute_ids[10] = 10;
+	opts.transfer_btf = &transfer_btf;
+	err = btf__permute(btf, permute_ids, ARRAY_SIZE(permute_ids), &opts);
+	if (!ASSERT_OK(err, "btf__permute_transfer") ||
+	    !ASSERT_OK_PTR(transfer_btf, "transfer_btf"))
+		goto cleanup;
+
+	ASSERT_EQ(4, btf__type_cnt(btf), "base_type_cnt");
+	ASSERT_EQ(-ENOENT, btf__find_str(btf, "foo"), "func_name_not_in_base");
+	shared_name_off = btf__find_str(btf, "shared");
+	if (!ASSERT_GE(shared_name_off, 0, "shared_name_in_base"))
+		goto cleanup;
+	for (id = btf__type_cnt(btf); id < btf__type_cnt(transfer_btf); id++) {
+		const struct btf_type *t = btf__type_by_id(transfer_btf, id);
+
+		if (!btf_is_func(t))
+			continue;
+		if (!strcmp(btf__name_by_offset(transfer_btf, t->name_off), "foo")) {
+			foo_funcs++;
+			if (foo_name_off < 0)
+				foo_name_off = t->name_off;
+			else if (!ASSERT_EQ(foo_name_off, t->name_off, "local_foo_dedup"))
+				goto cleanup;
+		} else if (!strcmp(btf__name_by_offset(transfer_btf, t->name_off), "shared")) {
+			shared_funcs++;
+			if (!ASSERT_EQ(shared_name_off, t->name_off, "shared_name_reuses_base"))
+				goto cleanup;
+		}
+	}
+	if (!ASSERT_GE(foo_name_off, 0, "local_foo_name"))
+		goto cleanup;
+	if (!ASSERT_EQ(2, foo_funcs, "local_foo_count") ||
+	    !ASSERT_EQ(1, shared_funcs, "shared_func_count"))
+		goto cleanup;
+	VALIDATE_RAW_BTF(
+		transfer_btf,
+		"[1] INT 'int' size=4 bits_offset=0 nr_bits=32 encoding=SIGNED",
+		"[2] INT 'long' size=8 bits_offset=0 nr_bits=64 encoding=SIGNED",
+		"[3] STRUCT 'shared' size=4 vlen=0",
+		"[4] FUNC_PROTO '(anon)' ret_type_id=1 vlen=0",
+		"[5] FUNC 'foo' type_id=4 linkage=static",
+		"[6] LOC_PARAM '(anon)' size=4 flags=0x1 vlen=1\n"
+		"\tvalue=0",
+		"[7] LOC_PROTO '(anon)' vlen=1\n"
+		"\ttype_id=6",
+		"[8] LOCSEC '.locs' vlen=2\n"
+		"\tfunc_type_id=5 loc_proto_type_id=7 offset=128\n"
+		"\tfunc_type_id=5 loc_proto_type_id=7 offset=0",
+		"[9] FUNC 'foo' type_id=4 linkage=static",
+		"[10] FUNC 'shared' type_id=4 linkage=static");
+cleanup:
+	btf__free(transfer_btf);
+	btf__free(btf);
+}
+
+/* Permuting BTF with a layout section must keep section offsets in sync. */
+static void test_permute_layout(void)
+{
+	LIBBPF_OPTS(btf_new_opts, opts, .add_layout = true);
+	LIBBPF_OPTS(btf_permute_opts, permute_opts);
+	struct btf *btf, *parsed, *transfer_btf = NULL;
+	const void *raw;
+	__u32 raw_sz;
+	__u32 permute_ids[] = { 0, 1, BTF_PERMUTE_ID_TRANSFER | 2 };
+	int err;
+
+	btf = btf__new_empty_opts(&opts);
+	if (!ASSERT_OK_PTR(btf, "empty_layout_btf"))
+		return;
+
+	btf__add_int(btf, "int", 4, BTF_INT_SIGNED);
+	btf__add_ptr(btf, 1);
+	permute_opts.transfer_btf = &transfer_btf;
+	err = btf__permute(btf, permute_ids, ARRAY_SIZE(permute_ids), &permute_opts);
+	if (!ASSERT_OK(err, "btf__permute_layout"))
+		goto cleanup;
+
+	raw = btf__raw_data(btf, &raw_sz);
+	parsed = btf__new(raw, raw_sz);
+	if (!ASSERT_OK_PTR(parsed, "parse_permuted_layout"))
+		goto cleanup;
+	btf__free(parsed);
+cleanup:
+	btf__free(transfer_btf);
+	btf__free(btf);
+}
+
 void test_btf_permute(void)
 {
 	if (test__start_subtest("permute_base"))
 		test_permute_base();
 	if (test__start_subtest("permute_split"))
 		test_permute_split();
+	if (test__start_subtest("permute_transfer"))
+		test_permute_transfer();
+	if (test__start_subtest("permute_layout"))
+		test_permute_layout();
 }
-- 
2.43.5

