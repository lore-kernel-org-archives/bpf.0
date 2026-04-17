Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C59C03B38B6
	for <bpf@vger.kernel.org>; Fri, 17 Apr 2026 14:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776436267; cv=none; b=slOVDAZ0qt29NzYwsovT4anecC/EmRmat99Lp/3qbStT2PArJaSVvzqLEjxwT1MbLDhUyKXnKa+Nyt3JB/iqpn74vXt50OrQvhessse1wmD0pMpO9FHahTLKeGg66Jo3tMTXksmv/dIWpqIUWVwlnlqyoZuqNJ7peiRo9OTOyKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776436267; c=relaxed/simple;
	bh=Ki4dwtZxgxqxFe7s27yzDyt9vxVeqywazk99OokfYrw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vpp8LU5F2ORiFwaKNvS0q4+l0F/PPH7difyOymhcdVrlaMq0/4XBpu3bRBGEbO13/JDkLA7aVAFLyCXs+dinDkGH9TwxCOE5CCqvYbrBlY3Irwwfl1wZRoorM2LOma6A6a7WF78r8hBuPij1I92KQIR8SQembSUGSalHgiuAw/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=d7CbGCPF; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="d7CbGCPF"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63H0kfPf395578;
	Fri, 17 Apr 2026 14:30:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=6jeqV
	a2IwEiJRnNB9RnmCANUg9CXxwM/jxKNjnuTL6c=; b=d7CbGCPF1JFJkHiB+zWu3
	taXCp0cy9/7eJ+/KdfDpgI71c0HfiDC6jU44EM/GBBGDLIQHtgGz/jK+c1fiLPuX
	Kcgc4vEvKfKv6D/boicg7CXlyRIUt7vsT53J/Wpjauz1/as9MzvM2Jzr0m01R1qJ
	0tMz5SVB1iPRZ/VHZaLyABfyGpDZ1kVPbH6/EktavwqisBsXz6oGzM3u59M67rgS
	LosTYOfRrpjzrO2FIyt2C74CkR1GvFIbvKy50Eu9bIFRPczPt4VdiYXncfgx3mGk
	tlLjl5OppYCHfjybjw7VQ/+sfh3nNss56rS6TKBsror3MZg1c5WJp2kUUb8VBD3H
	A==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4dh85qsxrf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 17 Apr 2026 14:30:40 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 63HETQKs027260;
	Fri, 17 Apr 2026 14:30:39 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4dh7nrw8rd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 17 Apr 2026 14:30:39 +0000 (GMT)
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 63HEUSt5033610;
	Fri, 17 Apr 2026 14:30:39 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-53-148.vpn.oracle.com [10.154.53.148])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4dh7nrw8f6-6;
	Fri, 17 Apr 2026 14:30:38 +0000 (GMT)
From: Alan Maguire <alan.maguire@oracle.com>
To: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org
Cc: martin.lau@linux.dev, eddyz87@gmail.com, memxor@gmail.com, song@kernel.org,
        yonghong.song@linux.dev, jolsa@kernel.org, qmo@kernel.org,
        mykyta.yatsenko5@gmail.com, bpf@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v3 bpf-next 5/6] selftests/bpf: Fix up __u16 vlen assumptions
Date: Fri, 17 Apr 2026 15:30:22 +0100
Message-ID: <20260417143023.1551481-6-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20260417143023.1551481-1-alan.maguire@oracle.com>
References: <20260417143023.1551481-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-17_01,2026-04-17_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 lowpriorityscore=0 phishscore=0 mlxlogscore=999 bulkscore=0 spamscore=0
 malwarescore=0 suspectscore=0 mlxscore=0 adultscore=0 classifier=spam
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2604070000
 definitions=main-2604170146
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE3MDE0NSBTYWx0ZWRfX/Ky18zs8Gj7z
 ZPP/l2sZd3+MPdGJRYM2rbSiInRffibWRUGdJ4RhubSXz4p8wzcNupf3xPKxd64/Y9WNsZ6ttCr
 tL7ZZfcqC4C4rW8DGqLNep2gO6iyVB5Bbuy8sqgPQaa7Ty26thXKYZ4bWhHgDPX1jyCfZMSkhpX
 RFQp7/yBh/IVFARBAWEIrwZULsMDOSO+o4DMafmabG9JALhHhNWdzHV4x8v7WkJ9hGfzgTfz+vm
 vUU6FPla38538GWKBU1YC8RpEfKQvdkQ/aG483naKvfc2VKOM9Bcsv0tcacchlJOZe+r+IELJkU
 a53QYrzgIDZJtpAQobdL/8nAerdMLn6YggFpzeqdWQA2eYS3TVXEiRPoBdf3hYNfibJA98tGzkn
 I6hZBYH4tJcaAjmb0qPjzn8UnNpQaVP+a/XarSyw5hFZ3a8tmk4=
X-Authority-Analysis: v=2.4 cv=Lo6iDHdc c=1 sm=1 tr=0 ts=69e24410 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=x0eKOSpe3m1H3M0S9YoZ:22 a=yPCof4ZbAAAA:8 a=kBqtXVcF2UskK4TY5j8A:9 cc=ntf
 awl=host:13825
X-Proofpoint-GUID: 4n3w1SExaQh77LLCPnes_X3z7aay5tEl
X-Proofpoint-ORIG-GUID: 4n3w1SExaQh77LLCPnes_X3z7aay5tEl

Fix up a few cases where we assume vlen is 16 bits.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 tools/testing/selftests/bpf/prog_tests/btf.c             | 2 +-
 tools/testing/selftests/bpf/prog_tests/btf_dedup_split.c | 3 +--
 tools/testing/selftests/bpf/prog_tests/ctx_rewrite.c     | 3 +--
 tools/testing/selftests/bpf/test_progs.c                 | 2 +-
 4 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/btf.c b/tools/testing/selftests/bpf/prog_tests/btf.c
index 0cc347e32db3..a9de328a8697 100644
--- a/tools/testing/selftests/bpf/prog_tests/btf.c
+++ b/tools/testing/selftests/bpf/prog_tests/btf.c
@@ -8092,7 +8092,7 @@ static struct btf_dedup_test dedup_tests[] = {
 static int btf_type_size(const struct btf_type *t)
 {
 	int base_size = sizeof(struct btf_type);
-	__u16 vlen = BTF_INFO_VLEN(t->info);
+	__u32 vlen = BTF_INFO_VLEN(t->info);
 	__u16 kind = BTF_INFO_KIND(t->info);
 
 	switch (kind) {
diff --git a/tools/testing/selftests/bpf/prog_tests/btf_dedup_split.c b/tools/testing/selftests/bpf/prog_tests/btf_dedup_split.c
index 5bc15bb6b7ce..6bc31236805c 100644
--- a/tools/testing/selftests/bpf/prog_tests/btf_dedup_split.c
+++ b/tools/testing/selftests/bpf/prog_tests/btf_dedup_split.c
@@ -487,9 +487,8 @@ static void test_split_module(void)
 	for (i = 0; i < ARRAY_SIZE(mod_funcs); i++) {
 		const struct btf_param *p;
 		const struct btf_type *t;
-		__u16 vlen;
+		__u32 vlen, j;
 		__u32 id;
-		int j;
 
 		id = btf__find_by_name_kind(btf1, mod_funcs[i], BTF_KIND_FUNC);
 		if (!ASSERT_GE(id, nr_base_types, "func_id"))
diff --git a/tools/testing/selftests/bpf/prog_tests/ctx_rewrite.c b/tools/testing/selftests/bpf/prog_tests/ctx_rewrite.c
index 469e92869523..5064aeb8fe67 100644
--- a/tools/testing/selftests/bpf/prog_tests/ctx_rewrite.c
+++ b/tools/testing/selftests/bpf/prog_tests/ctx_rewrite.c
@@ -253,8 +253,7 @@ static int find_field_offset_aux(struct btf *btf, int btf_id, char *field_name,
 {
 	const struct btf_type *type = btf__type_by_id(btf, btf_id);
 	const struct btf_member *m;
-	__u16 mnum;
-	int i;
+	__u32 mnum, i;
 
 	if (!type) {
 		PRINT_FAIL("Can't find btf_type for id %d\n", btf_id);
diff --git a/tools/testing/selftests/bpf/test_progs.c b/tools/testing/selftests/bpf/test_progs.c
index 7fe16b5131b1..cc14b13e23fe 100644
--- a/tools/testing/selftests/bpf/test_progs.c
+++ b/tools/testing/selftests/bpf/test_progs.c
@@ -1257,7 +1257,7 @@ int get_bpf_max_tramp_links_from(struct btf *btf)
 	const struct btf_type *t;
 	__u32 i, type_cnt;
 	const char *name;
-	__u16 j, vlen;
+	__u32 j, vlen;
 
 	for (i = 1, type_cnt = btf__type_cnt(btf); i < type_cnt; i++) {
 		t = btf__type_by_id(btf, i);
-- 
2.39.3

