Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5B2D3CFF44
	for <bpf@vger.kernel.org>; Thu, 16 Apr 2026 14:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776350401; cv=none; b=mILKqIEhTb0B4tJ2T99XG/yMrSIaZe3TenxH+nrsKRXBha8ZWE6Ktjbwfx6NtgGglK/3tOFbeLVc63kPqjW0BkEjET4d8tL/llB+RRNOfKnGV9lTCNmqKCCjQq4OnUIyyi0UmsYmZaUNnv7QE2JMnYgXxqsrEhOtissvEk5eHmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776350401; c=relaxed/simple;
	bh=afybrujKljzNmJwnQ3abuAZIH64Kl4BWO8tjWnffACA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HBDFyaeQ1BHz0+rS7s6thCtwLtoVLOQsimHNmHuxENUj9AeH6MkKyehcfCki4FES1Je+YIRnvimCg8wEaznR6yky9RpWJjE2uNEAPVt4dqn1pVCre4t+Rq62dK2M9maLtMBNB3EfWYFiBjR4uTRM3sb0Y8xaFXlHS0tVxg5L1M8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=OyMXDgR5; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="OyMXDgR5"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63G6KOh51959107;
	Thu, 16 Apr 2026 14:39:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=tqrsr
	M1YhVNIihKJztbQ8mZYwXGu3abVHEBKYGFm7Cc=; b=OyMXDgR5LVH4qZnINIUb5
	EUFiwjv++AV9QGZ8Hmgv7Osm6kzeK/g8inJzqoX5xQFiokOjoQfbtAgnuTIMNse+
	FglgC0XiKFHOHrDGnyNBcRpjFvQMpns0MZzdJZgbswJOkzOWYDkffNLjNGAqs5HX
	3IydVmw2QKrPbX87YIZ5TurrgChk4A2ymEj3howmnP+D2FYF+QqPFyNCxeckIL1r
	0BDAlQTd+jPD8pBP1LeJ2y3bw8jwYd6/5dSGBx+nUcnEui5ul+GdWpWv4DKYoed5
	x3AMxWW4V0KGKJoqBt6kEXWh//xMjVjql08P+OBEXRCFJ2uZpIKcfGKxjk/SQ5nG
	w==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4dh85jqnac-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 Apr 2026 14:39:43 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 63GEdQO5017700;
	Thu, 16 Apr 2026 14:39:43 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4dh7nqkmkv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 Apr 2026 14:39:43 +0000 (GMT)
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 63GEdXab018534;
	Thu, 16 Apr 2026 14:39:42 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-52-74.vpn.oracle.com [10.154.52.74])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4dh7nqkm1k-5;
	Thu, 16 Apr 2026 14:39:42 +0000 (GMT)
From: Alan Maguire <alan.maguire@oracle.com>
To: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org
Cc: martin.lau@linux.dev, eddyz87@gmail.com, memxor@gmail.com, song@kernel.org,
        yonghong.song@linux.dev, jolsa@kernel.org, qmo@kernel.org,
        mykyta.yatsenko5@gmail.com, bpf@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v2 bpf-next 4/8] bpftool: Support 24-bit vlen
Date: Thu, 16 Apr 2026 15:39:00 +0100
Message-ID: <20260416143904.1220662-5-alan.maguire@oracle.com>
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
X-Proofpoint-ORIG-GUID: -MAVffwaCXr6PKr-IfiRK9eHgYidEnhm
X-Proofpoint-GUID: -MAVffwaCXr6PKr-IfiRK9eHgYidEnhm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE2MDE0MCBTYWx0ZWRfX4ZWcMRH2+T+7
 3t1sz8TIukFn5+y2WG0VDWV68dOyP9jRClVvTFNHESkR1e3X7cmL79GScZb7aL0vfAylgZM+4Lz
 sdJtscRxO3Y7/kh+ym8Kobo2KQYPCGLH3UeFeY+stLMHNxyDTJIIUFRqNSbszF3rqMRl+K2cHZ1
 3C1UVcAQsa5rdQlGko6uLPNjTlmmUfpFW/ax70Ga3YfcR5IhA+ltRamf2+FAZXgMQZNflCK28hW
 5TGheRO9aqYflQyDUig5WUJ1zbuUEQ4I6vLL0lGVw0a1JiDBjFRHGvKIIAaWNd3wD4bKu2nzfE+
 CppBjo5bhEoYu5rAU3EOAFRk6DGVLqng1666vceQWerVf0Tsm8zcF9Whxt4/oufCqmtSmK36+Di
 MUa0FzD4B8kgMaa8I7/lMfRFYWkNVkLESohBh4zWmaOmuoGwytbfyRTafh7Y1R/Yq2mB96G0Zos
 beE1PimQomvz7a9JK7lVfHBvd0QACxg1HucnF28Q=
X-Authority-Analysis: v=2.4 cv=Co+PtH4D c=1 sm=1 tr=0 ts=69e0f4b0 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=x4eqshVgHu-cdnggieHk:22 a=yPCof4ZbAAAA:8 a=RpR09Kb1LV93WfcBO2MA:9 cc=ntf
 awl=host:13825

Adjust btf_vlen() usage to handle 24-bit vlen.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 tools/bpf/bpftool/btf.c        | 17 ++++++-----------
 tools/bpf/bpftool/btf_dumper.c |  4 ++--
 tools/bpf/bpftool/gen.c        | 16 +++++++++-------
 3 files changed, 17 insertions(+), 20 deletions(-)

diff --git a/tools/bpf/bpftool/btf.c b/tools/bpf/bpftool/btf.c
index 2e899e940034..6ef908adf3a4 100644
--- a/tools/bpf/bpftool/btf.c
+++ b/tools/bpf/bpftool/btf.c
@@ -179,8 +179,7 @@ static int dump_btf_type(const struct btf *btf, __u32 id,
 	case BTF_KIND_STRUCT:
 	case BTF_KIND_UNION: {
 		const struct btf_member *m = (const void *)(t + 1);
-		__u16 vlen = BTF_INFO_VLEN(t->info);
-		int i;
+		__u32 i, vlen = BTF_INFO_VLEN(t->info);
 
 		if (json_output) {
 			jsonw_uint_field(w, "size", t->size);
@@ -225,9 +224,8 @@ static int dump_btf_type(const struct btf *btf, __u32 id,
 	}
 	case BTF_KIND_ENUM: {
 		const struct btf_enum *v = (const void *)(t + 1);
-		__u16 vlen = BTF_INFO_VLEN(t->info);
+		__u32 i, vlen = BTF_INFO_VLEN(t->info);
 		const char *encoding;
-		int i;
 
 		encoding = btf_kflag(t) ? "SIGNED" : "UNSIGNED";
 		if (json_output) {
@@ -263,9 +261,8 @@ static int dump_btf_type(const struct btf *btf, __u32 id,
 	}
 	case BTF_KIND_ENUM64: {
 		const struct btf_enum64 *v = btf_enum64(t);
-		__u16 vlen = btf_vlen(t);
+		__u32 i, vlen = btf_vlen(t);
 		const char *encoding;
-		int i;
 
 		encoding = btf_kflag(t) ? "SIGNED" : "UNSIGNED";
 		if (json_output) {
@@ -325,8 +322,7 @@ static int dump_btf_type(const struct btf *btf, __u32 id,
 	}
 	case BTF_KIND_FUNC_PROTO: {
 		const struct btf_param *p = (const void *)(t + 1);
-		__u16 vlen = BTF_INFO_VLEN(t->info);
-		int i;
+		__u32 i, vlen = BTF_INFO_VLEN(t->info);
 
 		if (json_output) {
 			jsonw_uint_field(w, "ret_type_id", t->type);
@@ -369,8 +365,7 @@ static int dump_btf_type(const struct btf *btf, __u32 id,
 	case BTF_KIND_DATASEC: {
 		const struct btf_var_secinfo *v = (const void *)(t + 1);
 		const struct btf_type *vt;
-		__u16 vlen = BTF_INFO_VLEN(t->info);
-		int i;
+		__u32 i, vlen = BTF_INFO_VLEN(t->info);
 
 		if (json_output) {
 			jsonw_uint_field(w, "size", t->size);
@@ -675,7 +670,7 @@ static __u64 btf_name_hasher(__u64 hash, const struct btf *btf, __u32 name_off)
 static __u64 btf_type_disambig_hash(const struct btf *btf, __u32 id, bool include_members)
 {
 	const struct btf_type *t = btf__type_by_id(btf, id);
-	int i;
+	__u32 i;
 	size_t hash = 0;
 
 	hash = btf_name_hasher(hash, btf, t->name_off);
diff --git a/tools/bpf/bpftool/btf_dumper.c b/tools/bpf/bpftool/btf_dumper.c
index def297e879f4..9dc8425b1789 100644
--- a/tools/bpf/bpftool/btf_dumper.c
+++ b/tools/bpf/bpftool/btf_dumper.c
@@ -150,7 +150,7 @@ static int btf_dumper_enum(const struct btf_dumper *d,
 {
 	const struct btf_enum *enums = btf_enum(t);
 	__s64 value;
-	__u16 i;
+	__u32 i;
 
 	switch (t->size) {
 	case 8:
@@ -189,7 +189,7 @@ static int btf_dumper_enum64(const struct btf_dumper *d,
 	const struct btf_enum64 *enums = btf_enum64(t);
 	__u32 val_lo32, val_hi32;
 	__u64 value;
-	__u16 i;
+	__u32 i;
 
 	value = *(__u64 *)data;
 	val_lo32 = (__u32)value;
diff --git a/tools/bpf/bpftool/gen.c b/tools/bpf/bpftool/gen.c
index 2f9e10752e28..def7497e39c9 100644
--- a/tools/bpf/bpftool/gen.c
+++ b/tools/bpf/bpftool/gen.c
@@ -2094,7 +2094,8 @@ btfgen_mark_type(struct btfgen_info *info, unsigned int type_id, bool follow_poi
 	struct btf_type *cloned_type;
 	struct btf_param *param;
 	struct btf_array *array;
-	int err, i;
+	__u32 i;
+	int err;
 
 	if (type_id == 0)
 		return 0;
@@ -2229,7 +2230,8 @@ static int btfgen_mark_type_match(struct btfgen_info *info, __u32 type_id, bool
 	const struct btf_type *btf_type;
 	struct btf *btf = info->src_btf;
 	struct btf_type *cloned_type;
-	int i, err;
+	int err;
+	__u32 i;
 
 	if (type_id == 0)
 		return 0;
@@ -2249,7 +2251,7 @@ static int btfgen_mark_type_match(struct btfgen_info *info, __u32 type_id, bool
 	case BTF_KIND_STRUCT:
 	case BTF_KIND_UNION: {
 		struct btf_member *m = btf_members(btf_type);
-		__u16 vlen = btf_vlen(btf_type);
+		__u32 vlen = btf_vlen(btf_type);
 
 		if (behind_ptr)
 			break;
@@ -2286,7 +2288,7 @@ static int btfgen_mark_type_match(struct btfgen_info *info, __u32 type_id, bool
 		break;
 	}
 	case BTF_KIND_FUNC_PROTO: {
-		__u16 vlen = btf_vlen(btf_type);
+		__u32 vlen = btf_vlen(btf_type);
 		struct btf_param *param;
 
 		/* mark ret type */
@@ -2492,8 +2494,9 @@ static struct btf *btfgen_get_btf(struct btfgen_info *info)
 {
 	struct btf *btf_new = NULL;
 	unsigned int *ids = NULL;
-	unsigned int i, n = btf__type_cnt(info->marked_btf);
+	unsigned int n = btf__type_cnt(info->marked_btf);
 	int err = 0;
+	__u32 i;
 
 	btf_new = btf__new_empty();
 	if (!btf_new) {
@@ -2523,8 +2526,7 @@ static struct btf *btfgen_get_btf(struct btfgen_info *info)
 		/* add members for struct and union */
 		if (btf_is_composite(type)) {
 			struct btf_member *cloned_m, *m;
-			unsigned short vlen;
-			int idx_src;
+			unsigned int vlen, idx_src;
 
 			name = btf__str_by_offset(info->src_btf, type->name_off);
 
-- 
2.39.3

