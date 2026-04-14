Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B397D30BB9B
	for <bpf@vger.kernel.org>; Tue, 14 Apr 2026 19:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776196271; cv=none; b=ubY8ndWtYgH8Gmzzt4tESX7ou5yJMlTdlhFpz/6LEEj1BILYMp4R5TrQlCzxFQxP8x1c5F9hYtoQwUgYP0+0ak1aMWc5EuowzyeqfLAC1Mtf2Gw3a5gsNuKqp9oJfrI90pkmDE6OR4+taraDVPqhUY1LccUYmaI4fSI5/A7xeH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776196271; c=relaxed/simple;
	bh=GU8Oiqgl7ymYT5929lE/eCuY76EFnWn2ya23aRQZCsc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eyOCTENkVny3kLA9dB9iLSebMHZrJqhzhBdAI/2nNpFzYoH2U+31RsJ5L8UoPqehxnuGswPVm39d3w0ArNtfvPAPpDJJjKlT5mHIh6kabgFkKdhrSBK6TTC/xzBC3ot9Fg0Ph7q9zP9yqhyLrJz8Yo6DXQP2ZNTDC9qCy1GeEsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=OlAquIER; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="OlAquIER"
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63EIhj4H3230154;
	Tue, 14 Apr 2026 19:50:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=P7MCL
	ihnVGkYeeDVYQWXyCumJtzH4bElNg/bmWCB45g=; b=OlAquIERNZIsKTQrKqlqH
	Q4UwXYYGXO9jUDuAkLYEjRb+iASMVG94zmT/uXpA0T2q5g4kSADnE4oT5xeY43yT
	Hslafimsnp1r/6NdHoCzPfxavETv0g8gw50sgNm1EVs8hNfvK+XAIV6rAnAsBUYU
	bq5V4xoGY9R/cDZ1sIjaJZOuha/httZsxqYPDf+quXRWOSh/iJB18A3oW+kDRF1b
	lFg55Wy6jh/qfNt3xxxX8qOtnL7UjY++eYkwYnHujAgLinwlDO1ForFV8FJA72Qt
	mOAWffmC0EG4IET2SEV7rS6MS3v5rscYF5pPDva9ncdhTWRG40OEOKS9KK+V3904
	A==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4dh867bsuj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 Apr 2026 19:50:38 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 63EJnQiG025686;
	Tue, 14 Apr 2026 19:50:37 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4dh7nkpgg8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 Apr 2026 19:50:37 +0000 (GMT)
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 63EJoP5V030710;
	Tue, 14 Apr 2026 19:50:36 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-50-225.vpn.oracle.com [10.154.50.225])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4dh7nkpg37-5;
	Tue, 14 Apr 2026 19:50:36 +0000 (GMT)
From: Alan Maguire <alan.maguire@oracle.com>
To: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org
Cc: martin.lau@linux.dev, eddyz87@gmail.com, memxor@gmail.com, song@kernel.org,
        yonghong.song@linux.dev, jolsa@kernel.org, qmo@kernel.org,
        bpf@vger.kernel.org, Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH bpf-next 4/6] bpftool: Support 24-bit vlen
Date: Tue, 14 Apr 2026 20:50:17 +0100
Message-ID: <20260414195019.684531-5-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20260414195019.684531-1-alan.maguire@oracle.com>
References: <20260414195019.684531-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-14_04,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 lowpriorityscore=0 mlxscore=0 mlxlogscore=999 spamscore=0 adultscore=0
 suspectscore=0 bulkscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2604070000 definitions=main-2604140185
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE0MDE4NSBTYWx0ZWRfX8q0XGgnQRodq
 HwKH463IfSJPBGVg1mYHdmgnhztmGKanfCafxAZ8861AmnNrRVM7yUr0W9ZYOQ1ap8GXaY2WzB7
 ApxBMDCHEHvnF6fIxcnNI5hCt0ykn0Hu5f0Fyjb1c2B/mvlcfVpx9uhZ3d+Oe1j/9LlwURgHcEB
 wiZX32yUw/xxG7ijfHmM7RQlMUHYHSiN/ACEWuF8MjCxQ1wr6XbqqpKoVYZvaBPn9QhaqphmTbS
 0ld7h1dOMi/97jKHSEVeVvurO6cNUm83n9SdJdhenYezzlPKUoaF7uvfA3H7efhLAt+dJi4oRCJ
 s55YE/s05/PmZOlZbak9ZoQFxF+dFmTbMaWYRjBGQrmWa0y/jhQCBYOs6hKCxIKaF+4O3gqJqlR
 Yoplf8kqSTJeodk6kUuC8ehBBr7nOWXramhq1MuxciNa4SfzzQK5+5AzhfAmpCIcn70GijpSJbf
 9+NdbNyzUuDrp+20nCw==
X-Authority-Analysis: v=2.4 cv=cbjiaHDM c=1 sm=1 tr=0 ts=69de9a8e cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=BqU2WV_vvsyTyxaotp0D:22 a=yPCof4ZbAAAA:8 a=lDM9fdfY_ibW7PiTWI4A:9
X-Proofpoint-GUID: zEgO2_k_559zmadxZwMzRdm0uRZazOPr
X-Proofpoint-ORIG-GUID: zEgO2_k_559zmadxZwMzRdm0uRZazOPr

Adjust btf_vlen() usage to handle 24-bit vlen.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 tools/bpf/bpftool/btf.c | 17 ++++++-----------
 tools/bpf/bpftool/gen.c | 16 +++++++++-------
 2 files changed, 15 insertions(+), 18 deletions(-)

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

