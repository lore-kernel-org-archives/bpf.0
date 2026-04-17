Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADEFD3A6B86
	for <bpf@vger.kernel.org>; Fri, 17 Apr 2026 14:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776436255; cv=none; b=oyw1DJBoZOQE19rIQsEw+Q4xhoBDx5lkgZuD3G9yhih3qGElO318JEHXJPITgyaA7jh3p3dNstiScFVamFjF6dmGOpUE6E7PzNXiCFIG1chXgHeQx5XbYuR7IgWJCN73q81Po3YGZbjIfu8DzFtpDqAUOcEDn21CnlU/ejOLWPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776436255; c=relaxed/simple;
	bh=0gFJc0Rtx27oYJC/ALl41D3Es9I1J1uJF/O4hYyi53o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P6qIIFP1sPlg2HSCAyFYC1wQEDZRAoDRDHC3T8tiJ8d1+jNmBochCpj0gx2FTn4lIQ0em3THbWT3EoM5Z3vdUn0xq7FGtSQdHdsfkqPhoBDTzKTB8E6Tjdeq43jMhXa2ETrM2epWuwZR68T0X8rK7oUJ13JBqNoClIEbq21RnB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=cKjER0h8; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cKjER0h8"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63HCZ3FJ3334005;
	Fri, 17 Apr 2026 14:30:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=OGybr
	dklQSezW6ShbxdVDQAS9zKjvq3HAyC0SmVneWI=; b=cKjER0h8IiZWiBvM7bzzg
	nHc7zqDrPuNBrSoCXvFlBRXvq+qdiIWKVyh7EXX7Gf9GVcmVfGaLDGN2mf42vsYH
	86sawqKrvcmQ3XDYhTm2+pRcCFNdZNYVfJ73aoiOI6hT63hWs/IPtG1epQ8j5Q75
	oe7F/9ZSku4IHt3Aqs/DYwdCdoHHNmW2ntw70QLs7gd5Wq3ENmScNueJCvjvuzxP
	sZx61mCSSgE+mNe/StTJtVVm+hkqnw5IDZRxdPyofGUWzfjWiANueE1j27fPH1Z2
	S7rs+x3s72c8AQoV4T+xvMgs9TyFpECYOosvC+ecpWcNgez4aS0lUCnnGJuC7hZj
	Q==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4dh85qhxc6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 17 Apr 2026 14:30:34 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 63HETRWC027334;
	Fri, 17 Apr 2026 14:30:33 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4dh7nrw8md-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 17 Apr 2026 14:30:33 +0000 (GMT)
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 63HEUSsx033610;
	Fri, 17 Apr 2026 14:30:32 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-53-148.vpn.oracle.com [10.154.53.148])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4dh7nrw8f6-3;
	Fri, 17 Apr 2026 14:30:32 +0000 (GMT)
From: Alan Maguire <alan.maguire@oracle.com>
To: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org
Cc: martin.lau@linux.dev, eddyz87@gmail.com, memxor@gmail.com, song@kernel.org,
        yonghong.song@linux.dev, jolsa@kernel.org, qmo@kernel.org,
        mykyta.yatsenko5@gmail.com, bpf@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v3 bpf-next 2/6] libbpf: Adjust btf_vlen() to return a __u32
Date: Fri, 17 Apr 2026 15:30:19 +0100
Message-ID: <20260417143023.1551481-3-alan.maguire@oracle.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE3MDE0NCBTYWx0ZWRfX/JxsE9v5NfDq
 hAimWLqtnbZa5+Rvfu3WGo6tAtSWN0k8ZVUpJmebmIQlxKAWjr1LvkccT5G0GD1zyhTeGYddzEe
 Iq1Fjyfl7HQcIACkx2tf0pnE6LRLqDioEoN9Oe0ARHhuX/BFmJ0nuFzy6hrHHWxQSh5NrJMQkpi
 RgA0vYz7ctd6mdsKwT2mswXq1WqtB/qFFmVE0eedE9EsoSGypPLgATYsJvW8ACNj6QnZAVccCd3
 V7OVqKqtA3iIF3N2Kw3Td5DhH6waj6Xeio8nF9oOeF/PWxrFbJr+LLverAxbCNF6fDb176rvqWE
 LDmHEt9WqR/bG/joD4O+XbdYzPl+cu5S2fhe2gvTuZmWoRLukhb2fJYivM9LctuBtE2KpLD80ax
 Ze8SLnXeWy4xbFr8uqjJLSwhLh5z+ZYPlv3W38QDn27AGGKWwZ6HrOMRr3UsHqf2iHBEgzL7efS
 OlbV4D56qucsAmJvb4xDTmGiBj8WyhGMYdJfWMmA=
X-Proofpoint-GUID: hlEExc7CVm13s1iStPn5EBOzh_lyAhvF
X-Authority-Analysis: v=2.4 cv=V49NF+ni c=1 sm=1 tr=0 ts=69e2440a b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=RD47p0oAkeU5bO7t-o6f:22 a=yPCof4ZbAAAA:8 a=Jj4SN8nbqpZ7Tacn4HwA:9 cc=ntf
 awl=host:13825
X-Proofpoint-ORIG-GUID: hlEExc7CVm13s1iStPn5EBOzh_lyAhvF

Now that vlen is 24 bits, btf_vlen() must return a __u32.
Adjust use cases in libbpf accordingly.  Also add error
handling to avoid vlen overflow in btf_type_inc_vlen().

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 tools/lib/bpf/btf.c       | 50 +++++++++++++++++++++++++--------------
 tools/lib/bpf/btf.h       |  2 +-
 tools/lib/bpf/btf_dump.c  | 24 +++++++++----------
 tools/lib/bpf/relo_core.c | 16 ++++++-------
 4 files changed, 53 insertions(+), 39 deletions(-)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index ceb57b46a878..267904939098 100644
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
@@ -2121,9 +2121,12 @@ static void *btf_add_type_mem(struct btf *btf, size_t add_sz)
 			      btf->hdr.type_len, UINT_MAX, add_sz);
 }
 
-static void btf_type_inc_vlen(struct btf_type *t)
+static int btf_type_inc_vlen(struct btf_type *t)
 {
+	if (btf_vlen(t) == BTF_MAX_VLEN)
+		return -ENOSPC;
 	t->info = btf_type_info(btf_kind(t), btf_vlen(t) + 1, btf_kflag(t));
+	return 0;
 }
 
 static void btf_hdr_update_type_len(struct btf *btf, int new_len)
@@ -2652,6 +2655,8 @@ int btf__add_field(struct btf *btf, const char *name, int type_id,
 	t = btf_last_type(btf);
 	if (!btf_is_composite(t))
 		return libbpf_err(-EINVAL);
+	if (btf_vlen(t) == BTF_MAX_VLEN)
+		return libbpf_err(-ENOSPC);
 
 	if (validate_type_id(type_id))
 		return libbpf_err(-EINVAL);
@@ -2686,6 +2691,7 @@ int btf__add_field(struct btf *btf, const char *name, int type_id,
 
 	/* btf_add_type_mem can invalidate t pointer */
 	t = btf_last_type(btf);
+
 	/* update parent type's vlen and kflag */
 	t->info = btf_type_info(btf_kind(t), btf_vlen(t) + 1, is_bitfield || btf_kflag(t));
 
@@ -2796,7 +2802,9 @@ int btf__add_enum_value(struct btf *btf, const char *name, __s64 value)
 
 	/* update parent type's vlen */
 	t = btf_last_type(btf);
-	btf_type_inc_vlen(t);
+	err = btf_type_inc_vlen(t);
+	if (err)
+		return libbpf_err(err);
 
 	/* if negative value, set signedness to signed */
 	if (value < 0)
@@ -2873,7 +2881,9 @@ int btf__add_enum64_value(struct btf *btf, const char *name, __u64 value)
 
 	/* update parent type's vlen */
 	t = btf_last_type(btf);
-	btf_type_inc_vlen(t);
+	err = btf_type_inc_vlen(t);
+	if (err)
+		return libbpf_err(err);
 
 	btf_hdr_update_type_len(btf, btf->hdr.type_len + sz);
 	return 0;
@@ -3115,7 +3125,9 @@ int btf__add_func_param(struct btf *btf, const char *name, int type_id)
 
 	/* update parent type's vlen */
 	t = btf_last_type(btf);
-	btf_type_inc_vlen(t);
+	err = btf_type_inc_vlen(t);
+	if (err)
+		return libbpf_err(err);
 
 	btf_hdr_update_type_len(btf, btf->hdr.type_len + sz);
 	return 0;
@@ -3257,7 +3269,9 @@ int btf__add_datasec_var_info(struct btf *btf, int var_type_id, __u32 offset, __
 
 	/* update parent type's vlen */
 	t = btf_last_type(btf);
-	btf_type_inc_vlen(t);
+	err = btf_type_inc_vlen(t);
+	if (err)
+		return libbpf_err(err);
 
 	btf_hdr_update_type_len(btf, btf->hdr.type_len + sz);
 	return 0;
@@ -4311,7 +4325,7 @@ static long btf_hash_enum(struct btf_type *t)
 static bool btf_equal_enum_members(struct btf_type *t1, struct btf_type *t2)
 {
 	const struct btf_enum *m1, *m2;
-	__u16 vlen;
+	__u32 vlen;
 	int i;
 
 	vlen = btf_vlen(t1);
@@ -4329,7 +4343,7 @@ static bool btf_equal_enum_members(struct btf_type *t1, struct btf_type *t2)
 static bool btf_equal_enum64_members(struct btf_type *t1, struct btf_type *t2)
 {
 	const struct btf_enum64 *m1, *m2;
-	__u16 vlen;
+	__u32 vlen;
 	int i;
 
 	vlen = btf_vlen(t1);
@@ -4406,7 +4420,7 @@ static long btf_hash_struct(struct btf_type *t)
 static bool btf_shallow_equal_struct(struct btf_type *t1, struct btf_type *t2)
 {
 	const struct btf_member *m1, *m2;
-	__u16 vlen;
+	__u32 vlen;
 	int i;
 
 	if (!btf_equal_common(t1, t2))
@@ -4482,7 +4496,7 @@ static bool btf_compat_array(struct btf_type *t1, struct btf_type *t2)
 static long btf_hash_fnproto(struct btf_type *t)
 {
 	const struct btf_param *member = btf_params(t);
-	__u16 vlen = btf_vlen(t);
+	__u32 vlen = btf_vlen(t);
 	long h = btf_hash_common(t);
 	int i;
 
@@ -4504,7 +4518,7 @@ static long btf_hash_fnproto(struct btf_type *t)
 static bool btf_equal_fnproto(struct btf_type *t1, struct btf_type *t2)
 {
 	const struct btf_param *m1, *m2;
-	__u16 vlen;
+	__u32 vlen;
 	int i;
 
 	if (!btf_equal_common(t1, t2))
@@ -4530,7 +4544,7 @@ static bool btf_equal_fnproto(struct btf_type *t1, struct btf_type *t2)
 static bool btf_compat_fnproto(struct btf_type *t1, struct btf_type *t2)
 {
 	const struct btf_param *m1, *m2;
-	__u16 vlen;
+	__u32 vlen;
 	int i;
 
 	/* skip return type ID */
@@ -5077,7 +5091,7 @@ static int btf_dedup_is_equiv(struct btf_dedup *d, __u32 cand_id,
 	case BTF_KIND_STRUCT:
 	case BTF_KIND_UNION: {
 		const struct btf_member *cand_m, *canon_m;
-		__u16 vlen;
+		__u32 vlen;
 
 		if (!btf_shallow_equal_struct(cand_type, canon_type))
 			return 0;
@@ -5105,7 +5119,7 @@ static int btf_dedup_is_equiv(struct btf_dedup *d, __u32 cand_id,
 
 	case BTF_KIND_FUNC_PROTO: {
 		const struct btf_param *cand_p, *canon_p;
-		__u16 vlen;
+		__u32 vlen;
 
 		if (!btf_compat_fnproto(cand_type, canon_type))
 			return 0;
@@ -5439,7 +5453,7 @@ static int btf_dedup_ref_type(struct btf_dedup *d, __u32 type_id)
 
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

