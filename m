Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9091630BB9B
	for <bpf@vger.kernel.org>; Tue, 14 Apr 2026 19:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776196265; cv=none; b=O2K4DluI+3/t+jWPCddyLeqpDmhsj03QljP/1KkiJFH+3m5LTZ0p+10g8COH5bzYXT5s/PrG3eyiikGg4mNyUnSChUnFa1SgiaQzxQYHVuf7zi8/i7PDWSmG4pWgMU5wWWX/AjTVZoCmJatgJFbRygBHHPqCm9aYrvrsot9T2x8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776196265; c=relaxed/simple;
	bh=YRsvA2/GutOkiSKE1uFyLJ9LYjMvLqCJY5KjiIhCqzM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xhr7ncRMHQ/myYwbzVi86dPEI+c0wNOM2HBhGsU0ofzD0TfFrM2E9BWwj4FsX3qWacmp/j5OmKoYPByc6oWwGFYlWpMI7nivUxiiLWrtUREQiX7AT3ZRWEyffmmrumcl7wts5bh3l93ClHd9nxnbTTZCUlw/TRH1vnsvdWjDXVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=fYQDKpny; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fYQDKpny"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63EGV9aa3851340;
	Tue, 14 Apr 2026 19:50:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=ZTrbV
	vb4bFyoqRW7kKSHBBe0opuwBZbWaaWBgJYQrWg=; b=fYQDKpnybry2crfzVQlLx
	KdHdAT6THVjWkY/H1ny4dMe95kMzFPeVS4gEY5Tlct46aDbMUqHXOsn4xCQjd14X
	Oteyto8jDw28SdoLeMIQQa/7L8kukFttfiidaSsqyt4YycBVvdF+aIC8Rkxg+euO
	aYkQr2HqVa5MV1SmBg9InCnhVxUccQ/vWgAvE81tc0muF+0A94UxGh6dX0Cge+fQ
	+gNv+AlEmxqmdk25iH+ZcDeRXC+BlwlLv3s6J7PTvnpES+4BOlOZhJ47kD+vP8Oy
	uA/US99nqPbxSyEqCcKM4bj2RWi+fyE5jYShUPxG2oRBetAQAclsDzefI8ezR9c7
	A==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4dh87mbjt3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 Apr 2026 19:50:32 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 63EJnPXf025486;
	Tue, 14 Apr 2026 19:50:31 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4dh7nkpgc1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 Apr 2026 19:50:31 +0000 (GMT)
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 63EJoP5R030710;
	Tue, 14 Apr 2026 19:50:30 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-50-225.vpn.oracle.com [10.154.50.225])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4dh7nkpg37-3;
	Tue, 14 Apr 2026 19:50:30 +0000 (GMT)
From: Alan Maguire <alan.maguire@oracle.com>
To: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org
Cc: martin.lau@linux.dev, eddyz87@gmail.com, memxor@gmail.com, song@kernel.org,
        yonghong.song@linux.dev, jolsa@kernel.org, qmo@kernel.org,
        bpf@vger.kernel.org, Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH bpf-next 2/6] libbpf: Adjust btf_vlen() to return a __u32
Date: Tue, 14 Apr 2026 20:50:15 +0100
Message-ID: <20260414195019.684531-3-alan.maguire@oracle.com>
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
X-Authority-Analysis: v=2.4 cv=JKYLdcKb c=1 sm=1 tr=0 ts=69de9a88 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=7Gl3-_t3PgB9XO-mQDs3:22 a=yPCof4ZbAAAA:8 a=3sgBBc9L9v4sGCeyRngA:9
X-Proofpoint-ORIG-GUID: 35REtDDjO1O1ibO4QtkvL0aiI1kPGMY1
X-Proofpoint-GUID: 35REtDDjO1O1ibO4QtkvL0aiI1kPGMY1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE0MDE4NSBTYWx0ZWRfX8/PhtLdmoC7y
 G/f+jRKkhMMS+jysy7N+uZBU4bZLBB62TFIjYtUvvBAzq8pYY/T78BJP67n+LTOm0igJvYgxN1/
 XZmaW9LAD7YgHCdIm6UgcfYS+enM3zRUimv9cjhBgvS6XnkyjAB6B8/6J96ijI21xUn9EprLn54
 t1E0p1FLzaTzf4Y42y/J8GJXmh4ItRtN4gkQcrTVcOgzM1kJL33P1z8yBACNqFGHydSdpiX1sE5
 Rta1XPUNUm384DXf9GrouQOp2paOdtEydtNFgCqPm2rVENnWpULK9V7RvT2FN79Ejnhf8OLFubK
 pqGHtRfE1U0u9oh7oBt2L8bfCkKxCGab/SMTzJzoWHmAe5FZFrZqNaCGKXmq+3H9MotQB9P0Okh
 0IZ5wgNUw7uqMUSXS+fX1104gzWusSAez3ehSYSQEvS6cwH6r3QQ47nRceXKhLVG2+5ZMX3mqBD
 VrTlxUhUFrYvynJMJdw==

Now that vlen is 24 bits, btf_vlen() must return a __u32.
Adjust use cases in libbpf accordingly.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 tools/lib/bpf/btf.c       | 26 +++++++++++++-------------
 tools/lib/bpf/btf.h       |  2 +-
 tools/lib/bpf/btf_dump.c  | 24 ++++++++++++------------
 tools/lib/bpf/relo_core.c | 16 ++++++++--------
 4 files changed, 34 insertions(+), 34 deletions(-)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index ceb57b46a878..8225b48ee9da 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -421,7 +421,7 @@ static int btf_type_size_unknown(const struct btf *btf, const struct btf_type *t
 {
 	__u32 l_cnt = btf->hdr.layout_len / sizeof(struct btf_layout);
 	struct btf_layout *l = btf->layout;
-	__u16 vlen = btf_vlen(t);
+	__u32 vlen = btf_vlen(t);
 	__u32 kind = btf_kind(t);
 
 	/* Fall back to base BTF if needed as they share layout information */
@@ -454,7 +454,7 @@ static int btf_type_size_unknown(const struct btf *btf, const struct btf_type *t
 static int btf_type_size(const struct btf *btf, const struct btf_type *t)
 {
 	const int base_size = sizeof(struct btf_type);
-	__u16 vlen = btf_vlen(t);
+	__u32 vlen = btf_vlen(t);
 
 	switch (btf_kind(t)) {
 	case BTF_KIND_FWD:
@@ -506,7 +506,7 @@ static int btf_bswap_type_rest(struct btf_type *t)
 	struct btf_array *a;
 	struct btf_param *p;
 	struct btf_enum *e;
-	__u16 vlen = btf_vlen(t);
+	__u32 vlen = btf_vlen(t);
 	int i;
 
 	switch (btf_kind(t)) {
@@ -1007,7 +1007,7 @@ int btf__align_of(const struct btf *btf, __u32 id)
 	case BTF_KIND_STRUCT:
 	case BTF_KIND_UNION: {
 		const struct btf_member *m = btf_members(t);
-		__u16 vlen = btf_vlen(t);
+		__u32 vlen = btf_vlen(t);
 		int i, max_align = 1, align;
 
 		for (i = 0; i < vlen; i++, m++) {
@@ -4311,7 +4311,7 @@ static long btf_hash_enum(struct btf_type *t)
 static bool btf_equal_enum_members(struct btf_type *t1, struct btf_type *t2)
 {
 	const struct btf_enum *m1, *m2;
-	__u16 vlen;
+	__u32 vlen;
 	int i;
 
 	vlen = btf_vlen(t1);
@@ -4329,7 +4329,7 @@ static bool btf_equal_enum_members(struct btf_type *t1, struct btf_type *t2)
 static bool btf_equal_enum64_members(struct btf_type *t1, struct btf_type *t2)
 {
 	const struct btf_enum64 *m1, *m2;
-	__u16 vlen;
+	__u32 vlen;
 	int i;
 
 	vlen = btf_vlen(t1);
@@ -4406,7 +4406,7 @@ static long btf_hash_struct(struct btf_type *t)
 static bool btf_shallow_equal_struct(struct btf_type *t1, struct btf_type *t2)
 {
 	const struct btf_member *m1, *m2;
-	__u16 vlen;
+	__u32 vlen;
 	int i;
 
 	if (!btf_equal_common(t1, t2))
@@ -4482,7 +4482,7 @@ static bool btf_compat_array(struct btf_type *t1, struct btf_type *t2)
 static long btf_hash_fnproto(struct btf_type *t)
 {
 	const struct btf_param *member = btf_params(t);
-	__u16 vlen = btf_vlen(t);
+	__u32 vlen = btf_vlen(t);
 	long h = btf_hash_common(t);
 	int i;
 
@@ -4504,7 +4504,7 @@ static long btf_hash_fnproto(struct btf_type *t)
 static bool btf_equal_fnproto(struct btf_type *t1, struct btf_type *t2)
 {
 	const struct btf_param *m1, *m2;
-	__u16 vlen;
+	__u32 vlen;
 	int i;
 
 	if (!btf_equal_common(t1, t2))
@@ -4530,7 +4530,7 @@ static bool btf_equal_fnproto(struct btf_type *t1, struct btf_type *t2)
 static bool btf_compat_fnproto(struct btf_type *t1, struct btf_type *t2)
 {
 	const struct btf_param *m1, *m2;
-	__u16 vlen;
+	__u32 vlen;
 	int i;
 
 	/* skip return type ID */
@@ -5077,7 +5077,7 @@ static int btf_dedup_is_equiv(struct btf_dedup *d, __u32 cand_id,
 	case BTF_KIND_STRUCT:
 	case BTF_KIND_UNION: {
 		const struct btf_member *cand_m, *canon_m;
-		__u16 vlen;
+		__u32 vlen;
 
 		if (!btf_shallow_equal_struct(cand_type, canon_type))
 			return 0;
@@ -5105,7 +5105,7 @@ static int btf_dedup_is_equiv(struct btf_dedup *d, __u32 cand_id,
 
 	case BTF_KIND_FUNC_PROTO: {
 		const struct btf_param *cand_p, *canon_p;
-		__u16 vlen;
+		__u32 vlen;
 
 		if (!btf_compat_fnproto(cand_type, canon_type))
 			return 0;
@@ -5439,7 +5439,7 @@ static int btf_dedup_ref_type(struct btf_dedup *d, __u32 type_id)
 
 	case BTF_KIND_FUNC_PROTO: {
 		struct btf_param *param;
-		__u16 vlen;
+		__u32 vlen;
 		int i;
 
 		ref_type_id = btf_dedup_ref_type(d, t->type);
diff --git a/tools/lib/bpf/btf.h b/tools/lib/bpf/btf.h
index a1f8deca2603..1a31f2da947f 100644
--- a/tools/lib/bpf/btf.h
+++ b/tools/lib/bpf/btf.h
@@ -435,7 +435,7 @@ static inline __u16 btf_kind(const struct btf_type *t)
 	return BTF_INFO_KIND(t->info);
 }
 
-static inline __u16 btf_vlen(const struct btf_type *t)
+static inline __u32 btf_vlen(const struct btf_type *t)
 {
 	return BTF_INFO_VLEN(t->info);
 }
diff --git a/tools/lib/bpf/btf_dump.c b/tools/lib/bpf/btf_dump.c
index 53c6624161d7..cc1ba65bb6c5 100644
--- a/tools/lib/bpf/btf_dump.c
+++ b/tools/lib/bpf/btf_dump.c
@@ -316,7 +316,7 @@ static int btf_dump_mark_referenced(struct btf_dump *d)
 {
 	int i, j, n = btf__type_cnt(d->btf);
 	const struct btf_type *t;
-	__u16 vlen;
+	__u32 vlen;
 
 	for (i = d->last_id + 1; i < n; i++) {
 		t = btf__type_by_id(d->btf, i);
@@ -485,7 +485,7 @@ static int btf_dump_order_type(struct btf_dump *d, __u32 id, bool through_ptr)
 	 */
 	struct btf_dump_type_aux_state *tstate = &d->type_states[id];
 	const struct btf_type *t;
-	__u16 vlen;
+	__u32 vlen;
 	int err, i;
 
 	/* return true, letting typedefs know that it's ok to be emitted */
@@ -798,7 +798,7 @@ static void btf_dump_emit_type(struct btf_dump *d, __u32 id, __u32 cont_id)
 		 */
 		if (top_level_def || t->name_off == 0) {
 			const struct btf_member *m = btf_members(t);
-			__u16 vlen = btf_vlen(t);
+			__u32 vlen = btf_vlen(t);
 			int i, new_cont_id;
 
 			new_cont_id = t->name_off == 0 ? cont_id : id;
@@ -820,7 +820,7 @@ static void btf_dump_emit_type(struct btf_dump *d, __u32 id, __u32 cont_id)
 		break;
 	case BTF_KIND_FUNC_PROTO: {
 		const struct btf_param *p = btf_params(t);
-		__u16 n = btf_vlen(t);
+		__u32 n = btf_vlen(t);
 		int i;
 
 		btf_dump_emit_type(d, t->type, cont_id);
@@ -839,7 +839,7 @@ static bool btf_is_struct_packed(const struct btf *btf, __u32 id,
 {
 	const struct btf_member *m;
 	int max_align = 1, align, i, bit_sz;
-	__u16 vlen;
+	__u32 vlen;
 
 	m = btf_members(t);
 	vlen = btf_vlen(t);
@@ -973,7 +973,7 @@ static void btf_dump_emit_struct_def(struct btf_dump *d,
 	bool is_struct = btf_is_struct(t);
 	bool packed, prev_bitfield = false;
 	int align, i, off = 0;
-	__u16 vlen = btf_vlen(t);
+	__u32 vlen = btf_vlen(t);
 
 	align = btf__align_of(d->btf, id);
 	packed = is_struct ? btf_is_struct_packed(d->btf, id, t) : 0;
@@ -1064,7 +1064,7 @@ static void btf_dump_emit_enum_fwd(struct btf_dump *d, __u32 id,
 
 static void btf_dump_emit_enum32_val(struct btf_dump *d,
 				     const struct btf_type *t,
-				     int lvl, __u16 vlen)
+				     int lvl, __u32 vlen)
 {
 	const struct btf_enum *v = btf_enum(t);
 	bool is_signed = btf_kflag(t);
@@ -1089,7 +1089,7 @@ static void btf_dump_emit_enum32_val(struct btf_dump *d,
 
 static void btf_dump_emit_enum64_val(struct btf_dump *d,
 				     const struct btf_type *t,
-				     int lvl, __u16 vlen)
+				     int lvl, __u32 vlen)
 {
 	const struct btf_enum64 *v = btf_enum64(t);
 	bool is_signed = btf_kflag(t);
@@ -1122,7 +1122,7 @@ static void btf_dump_emit_enum_def(struct btf_dump *d, __u32 id,
 				   const struct btf_type *t,
 				   int lvl)
 {
-	__u16 vlen = btf_vlen(t);
+	__u32 vlen = btf_vlen(t);
 
 	btf_dump_printf(d, "enum%s%s",
 			t->name_off ? " " : "",
@@ -1542,7 +1542,7 @@ static void btf_dump_emit_type_chain(struct btf_dump *d,
 		}
 		case BTF_KIND_FUNC_PROTO: {
 			const struct btf_param *p = btf_params(t);
-			__u16 vlen = btf_vlen(t);
+			__u32 vlen = btf_vlen(t);
 			int i;
 
 			/*
@@ -2159,7 +2159,7 @@ static int btf_dump_struct_data(struct btf_dump *d,
 				const void *data)
 {
 	const struct btf_member *m = btf_members(t);
-	__u16 n = btf_vlen(t);
+	__u32 n = btf_vlen(t);
 	int i, err = 0;
 
 	/* note that we increment depth before calling btf_dump_print() below;
@@ -2449,7 +2449,7 @@ static int btf_dump_type_data_check_zero(struct btf_dump *d,
 	case BTF_KIND_STRUCT:
 	case BTF_KIND_UNION: {
 		const struct btf_member *m = btf_members(t);
-		__u16 n = btf_vlen(t);
+		__u32 n = btf_vlen(t);
 
 		/* if any struct/union member is non-zero, the struct/union
 		 * is considered non-zero and dumped.
diff --git a/tools/lib/bpf/relo_core.c b/tools/lib/bpf/relo_core.c
index 0ccc8f548cba..6ae3f2a15ad0 100644
--- a/tools/lib/bpf/relo_core.c
+++ b/tools/lib/bpf/relo_core.c
@@ -191,8 +191,8 @@ int __bpf_core_types_are_compat(const struct btf *local_btf, __u32 local_id,
 	case BTF_KIND_FUNC_PROTO: {
 		struct btf_param *local_p = btf_params(local_type);
 		struct btf_param *targ_p = btf_params(targ_type);
-		__u16 local_vlen = btf_vlen(local_type);
-		__u16 targ_vlen = btf_vlen(targ_type);
+		__u32 local_vlen = btf_vlen(local_type);
+		__u32 targ_vlen = btf_vlen(targ_type);
 		int i, err;
 
 		if (local_vlen != targ_vlen)
@@ -1457,8 +1457,8 @@ static bool bpf_core_names_match(const struct btf *local_btf, size_t local_name_
 static int bpf_core_enums_match(const struct btf *local_btf, const struct btf_type *local_t,
 				const struct btf *targ_btf, const struct btf_type *targ_t)
 {
-	__u16 local_vlen = btf_vlen(local_t);
-	__u16 targ_vlen = btf_vlen(targ_t);
+	__u32 local_vlen = btf_vlen(local_t);
+	__u32 targ_vlen = btf_vlen(targ_t);
 	int i, j;
 
 	if (local_t->size != targ_t->size)
@@ -1498,8 +1498,8 @@ static int bpf_core_composites_match(const struct btf *local_btf, const struct b
 				     bool behind_ptr, int level)
 {
 	const struct btf_member *local_m = btf_members(local_t);
-	__u16 local_vlen = btf_vlen(local_t);
-	__u16 targ_vlen = btf_vlen(targ_t);
+	__u32 local_vlen = btf_vlen(local_t);
+	__u32 targ_vlen = btf_vlen(targ_t);
 	int i, j, err;
 
 	if (local_vlen > targ_vlen)
@@ -1674,8 +1674,8 @@ int __bpf_core_types_match(const struct btf *local_btf, __u32 local_id, const st
 	case BTF_KIND_FUNC_PROTO: {
 		struct btf_param *local_p = btf_params(local_t);
 		struct btf_param *targ_p = btf_params(targ_t);
-		__u16 local_vlen = btf_vlen(local_t);
-		__u16 targ_vlen = btf_vlen(targ_t);
+		__u32 local_vlen = btf_vlen(local_t);
+		__u32 targ_vlen = btf_vlen(targ_t);
 		int i, err;
 
 		if (local_k != targ_k)
-- 
2.39.3

