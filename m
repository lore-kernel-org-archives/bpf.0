Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F2263CFF44
	for <bpf@vger.kernel.org>; Thu, 16 Apr 2026 14:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776350406; cv=none; b=BF8DSP4Jn2aZtbaTGFNWJTEL3UlX8YV3POavGu1edlw6Ia7sTInOoowA1iBmdsHiSNqATFmcP2+4vKA4iDwmy8r5xkSLHIlFdZvujY4HSNqglZG63GfQnHMsZ5ngG8N6eLghnvjusOYFlJqb8KVOs3h8xg6Zy9cQ4npZKtGvKdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776350406; c=relaxed/simple;
	bh=A1+MNfrbbMXkCYkSFymeoe07DkPhk3OOoMi6kyLPQcc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N9LdK48VrrhNjGu5E/umi8L/PMMNGYc79BnNrEZuOqzz2hsX+MStw63X61w5FtrLm+83dAOAPFMMaX5QNMSarrwtKoh4kQAD+byenMhRUwH+ZWOLbafrZy3f2YblEgE/EONVLRqAC/bhRkPGcX9cEKHHgRpY2kMmMabUW1ZuRVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=o/pZB5OO; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="o/pZB5OO"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63G6P94M2136590;
	Thu, 16 Apr 2026 14:39:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=+tj/d
	1IB+7dtPZbKdu0xIOUvHj8cEKZCz+UEZ/iZ934=; b=o/pZB5OO+nriTebrFyRNA
	HaGYs/B2ikkvRNRKl1gh5djXh2iOcXc0wSoxgD/gj3VXzrC9SwCaHn0aaTMcKn4I
	fE9qOXgRcDQ+9FA8aTfWWNCuxat75LYWPewYWhs0WmkdbDSbsYgaCqKW/ywdt8CA
	F6RHDVDJ/kr/xlDyQ1HXaRvn2W4qh3itdPDtpvhUsuEy3CuyJufn+QOcIl1hGl8Z
	RhPf0Y2bYYNU4Ks9NsuVlFglkBjo1iiGGeO1IajBzTSagOC0DeF23URA1rd/eihW
	T5Y1p2xSeCH6UfwxsUkxVoU58bmPhjzx2+ZkyPNGCABao2l5Fg0h2jRO0JKY82oT
	g==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4dh8687rnb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 Apr 2026 14:39:50 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 63GEdQ4n017681;
	Thu, 16 Apr 2026 14:39:49 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4dh7nqkmrd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 Apr 2026 14:39:49 +0000 (GMT)
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 63GEdXah018534;
	Thu, 16 Apr 2026 14:39:49 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-52-74.vpn.oracle.com [10.154.52.74])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4dh7nqkm1k-8;
	Thu, 16 Apr 2026 14:39:48 +0000 (GMT)
From: Alan Maguire <alan.maguire@oracle.com>
To: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org
Cc: martin.lau@linux.dev, eddyz87@gmail.com, memxor@gmail.com, song@kernel.org,
        yonghong.song@linux.dev, jolsa@kernel.org, qmo@kernel.org,
        mykyta.yatsenko5@gmail.com, bpf@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v2 bpf-next 7/8] selftests/bpf: Fix up __u16 vlen assumptions
Date: Thu, 16 Apr 2026 15:39:03 +0100
Message-ID: <20260416143904.1220662-8-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20260416143904.1220662-1-alan.maguire@oracle.com>
References: <20260416143904.1220662-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-16_03,2026-04-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 lowpriorityscore=0 phishscore=0 mlxlogscore=999 bulkscore=0 spamscore=0
 malwarescore=0 suspectscore=0 mlxscore=0 adultscore=0 classifier=spam
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2604070000
 definitions=main-2604160141
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE2MDE0MCBTYWx0ZWRfX5VQ9GIlrEWMe
 pcWww3u7JoJYA3RgkG2SRTE/TZQM9sM99nWB181NcK7iDijkpkFbdknxXZwbaehgYMRriWRx7M+
 jgSZp+YDHRTx7eXNWjUOK18reIepfl6OY9j/PFkPXHh8RKwFbn94qU43BGtgT4U2XX95FOR+MSb
 XkTz1bhh6odAMNVRqlweQ9Bk7ScPaimsP9kbSgbeDsgz1AMsCNcmvnYxbZr2zUYV6FJ8rIu67Pu
 LTNJXs6YwdZKdX2E3cer4yXljINl/ox+BhdCTT//ae6e/JD0WulduQDNf/Y3DyqDaIsXQvPmLEM
 6BkCnqVBYCkei1iL7mU4+AdHRYwxUsFW+7aSmMaNV6lqRJDYnZRbWXB7Ym7qP5z4hdp5QUw811r
 kYd847BrcqtsLPOMGUT3Fq/X8CfMDwtfT2EBR+i7AeC19SOu/rfcUMB10wAPS1gi65GgiO9wjdY
 H0XiiDJOquzOsbRlgbYxcIMAtP87ztypBrcDDrkw=
X-Proofpoint-GUID: 2gnLKZgL4wXjm7aToDiGuiy4EVCZfYyF
X-Proofpoint-ORIG-GUID: 2gnLKZgL4wXjm7aToDiGuiy4EVCZfYyF
X-Authority-Analysis: v=2.4 cv=JY6Ma0KV c=1 sm=1 tr=0 ts=69e0f4b6 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=3I1J8UUJPc9JN9BFgKH3:22 a=yPCof4ZbAAAA:8 a=e2D_I8xkSMYFWNAVTp4A:9 cc=ntf
 awl=host:13825

Fix up a few cases where we assume vlen is 16 bits.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 tools/testing/selftests/bpf/prog_tests/btf.c             | 2 +-
 tools/testing/selftests/bpf/prog_tests/btf_dedup_split.c | 2 +-
 tools/testing/selftests/bpf/test_progs.c                 | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

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
index 5bc15bb6b7ce..4517b03bbd1c 100644
--- a/tools/testing/selftests/bpf/prog_tests/btf_dedup_split.c
+++ b/tools/testing/selftests/bpf/prog_tests/btf_dedup_split.c
@@ -487,7 +487,7 @@ static void test_split_module(void)
 	for (i = 0; i < ARRAY_SIZE(mod_funcs); i++) {
 		const struct btf_param *p;
 		const struct btf_type *t;
-		__u16 vlen;
+		__u32 vlen;
 		__u32 id;
 		int j;
 
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

