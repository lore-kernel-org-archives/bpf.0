Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B8353B38A9
	for <bpf@vger.kernel.org>; Fri, 17 Apr 2026 14:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776436295; cv=none; b=eRKzi8slbiGjodLaxBbp4gUs+U4+4kLXEA0ZlBfeRwbsqaV3OXcmDfF+tW648GrWTDuHepAX6TAdVm/F7dXVpmqumLYxU5eMAFXB4X1ZrSEDHrUn1Hsdq8vGv8SOK1hPevIgNoPAVgTEaK30w/2j2HNyTq+5YdOMNCJgVlUYnaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776436295; c=relaxed/simple;
	bh=z79X2R/K2xtjbvf3Spu7xxKFxPQR1wFRX+Kx/Nq+6AQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G8v2fOWewDKROJx2Jc0vebV6WIY/fdlZ0kSFy6BUc8IhNSXFHU17gL6qAWWVP2yjn52ebA9FBBovmtNil6UaaY/bHgd6at9IcSRt6K0gvaK871M102CPZ8UWLEAL3r03KXWUW+BuTMhK1b+Z52z8zjUsfTveNAFJQ9qsBQ0yeX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ZILz4ebF; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZILz4ebF"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63HCR7Ql3128953;
	Fri, 17 Apr 2026 14:30:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=gk5x0
	hAdHVkajv8D0iBw3IxHuVIUEUmtewYCGB0fHxg=; b=ZILz4ebFkTOhOk/hEwvRP
	C+H8g6Xvo0RWdyhId1J/L1i9wuAdrqavyUGPA3MOqG3Xv7u0imRTBfO2Jb1rX7U7
	zS17qAaKVsCcoLjWXWGghI584zycHBkJB/PhQ3yuUi75hwRTr7HmsXGQ0Vsfn//w
	DXx0s7Fs/YG9/6rla0q+WHlVi9ivXoDVnHDTPj/Y2oA8FvK2lbCk7u7bSQ1ckxgv
	rU8XndyWjspfnq4vEJVZ50ED9BWLXYml33YdLpPKWBgESib6CscW2PGGhPyzo+fi
	TFkgwyMG2MbOum5d50tuv5kvpMqXNP9ZvuxbcmcvEGV9IuoMxOf49DjecskXmCjY
	A==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4dh87mj05e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 17 Apr 2026 14:30:36 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 63HETRSg027400;
	Fri, 17 Apr 2026 14:30:35 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4dh7nrw8ne-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 17 Apr 2026 14:30:35 +0000 (GMT)
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 63HEUSt1033610;
	Fri, 17 Apr 2026 14:30:34 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-53-148.vpn.oracle.com [10.154.53.148])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4dh7nrw8f6-4;
	Fri, 17 Apr 2026 14:30:34 +0000 (GMT)
From: Alan Maguire <alan.maguire@oracle.com>
To: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org
Cc: martin.lau@linux.dev, eddyz87@gmail.com, memxor@gmail.com, song@kernel.org,
        yonghong.song@linux.dev, jolsa@kernel.org, qmo@kernel.org,
        mykyta.yatsenko5@gmail.com, bpf@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v3 bpf-next 3/6] bpftool: Support 24-bit vlen
Date: Fri, 17 Apr 2026 15:30:20 +0100
Message-ID: <20260417143023.1551481-4-alan.maguire@oracle.com>
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
X-Authority-Analysis: v=2.4 cv=JKYLdcKb c=1 sm=1 tr=0 ts=69e2440c b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=7Gl3-_t3PgB9XO-mQDs3:22 a=yPCof4ZbAAAA:8 a=Dk1qj_UXkZxh548tLOIA:9 cc=ntf
 awl=host:13825
X-Proofpoint-ORIG-GUID: F7gCWOv6WHNAsdDzYOfK3ZNtZntZ1aSS
X-Proofpoint-GUID: F7gCWOv6WHNAsdDzYOfK3ZNtZntZ1aSS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE3MDE0NSBTYWx0ZWRfX7eDWs3Q1E2DF
 dWCkFMnfK/9RjGrb1e5M/QpYYI4IJEOXQcccWDiXDMK6FDPRI6klNgf4Ch88GUP6pBNqVDrFKuP
 VtRx/3GAxQSteIIwU6nvF5WXR5Y7AvPvV28utuq1Cx7ANpnqWt2mg1YET/UXZlFUXSvHJEpKhJT
 c7aXbtko5o6SWLTw1YjJG+JT2eAEg5N4thgZdhH5T7IWU732zhJkX/f6RGhxOWsDdhq9gOcgeOz
 IDi8wAowDYXw8p+r0BOKIqNXYGpClNUGuHPPYB50LCQibWaniK0Kl+VpD+P20LJa8rZRh5YeiSg
 vKBDE7VZkGWqS+CJenS64VVaNJE502QoSWAhJVNaA7zK/eike8UJe/zaNHB7QMKIIVltmtSHKed
 pOEoEUq3IiJTGkOgfpNvfNHark81W2icecAbc6+4wlbIa48PjBG/JlP5ncR2DN5NK2VL0zptB9a
 UYy+d6UGR56kXgVm5kYJRDm7ushTGegEPODiwrTE=

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
index 2f9e10752e28..37159e02f418 100644
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
+			__u32 vlen, idx_src;
 
 			name = btf__str_by_offset(info->src_btf, type->name_off);
 
-- 
2.39.3

