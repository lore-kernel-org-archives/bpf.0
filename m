Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 232D1483BF2;
	Tue,  1 Sep 2026 16:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788281923; cv=none; b=bxebCtgCkfUc2RYo401SyQvMhdQ1SdWpuagOoL3j1xfx83EOPHsIix8mJje2vMN25g5oP6gRkraYcTAL5eZ6//uL/QfdLAjO1dPqOon4DEKHnk/x4vtQcqKjNoR6UpKHUkivNo3o+tPIXqb/VoqqhfE1RFKgbZ+Ktg8QzV9Cums=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788281923; c=relaxed/simple;
	bh=NCnsbIou2POk+NFVQ8DihrYK1qr1MDqopQxzAI/j6sw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dtx5On6rvvS0UTuq3o7l4kNGGOy9DCKhGU3rl3+QUiurKxSIBEl6j7BzJse9wuB7SOUAC6Hban1/MNrQAfzXQWbkjbbwuDWTkJ8kUvSVSGTflT9zpC6hetfWlnrItSYEFARl7yHIaRA22ry2xG8UWpT3ZYcqsJ9RyKZxxo5DAhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Ih+trUJH; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Ih+trUJH"
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 681EQBhB231367;
	Tue, 1 Sep 2026 16:58:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=rt5py
	FdV9cLZ4mJR9D45Vtjd0vvRd5strb48kc4O9Dw=; b=Ih+trUJH3RfR1iXVVqRAy
	WQUiGhZS3rlXaB8uovNKS6bFxV69o9k87XpKQV1f1y/Q2gxoF5Nt6o24Eg3AQvjb
	nKh3l+1zCjKhBVbGKTf/NyoMWY79xM2wIQp38znLdvfMipIZgMRQ+C96FSUyf5ju
	RNozzzlnEdcikWldF2iuA3kaDvRwhY7IeE37YKfZTowsRrAxgjdxd5pll3WsEyob
	vqy4BJCknAPMS8lE4Co5fwAmyQVsjrKYaPkwXuEo3YdFMDRFl9fJom476n8UCCx7
	vapXJLXhMbcXGkxYO0iX5aawQu5AqU/oo184B27WGNumJnJh77817FNhT1l8prq8
	Q==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4gbqa7n3t4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 01 Sep 2026 16:58:14 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 681GjWHP001976;
	Tue, 1 Sep 2026 16:58:13 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4gdymtg8pa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 01 Sep 2026 16:58:12 +0000 (GMT)
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 681Gw1Vv011129;
	Tue, 1 Sep 2026 16:58:12 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-52-250.vpn.oracle.com [10.154.52.250])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4gdymtg8f6-4;
	Tue, 01 Sep 2026 16:58:12 +0000 (GMT)
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
Subject: [PATCH v2 bpf-next 03/18] libbpf: Support moving permuted BTF types into split BTF
Date: Tue,  1 Sep 2026 17:57:42 +0100
Message-ID: <20260901165757.801449-4-alan.maguire@oracle.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAxMDE1MCBTYWx0ZWRfXyCeu2MrqC+SA
 CbYWus/Ht4A0V4TIqzzYhM8suGG3jECwTYvYDs4ygSgk2f1cdPX72BhIwh3XqdwsMRTQiO+G0vP
 NLRpRNcgHBIhWrCnzLxnUrpC2HttFwh8Gf9HC6QNkOqvvM66v9n7
X-Proofpoint-GUID: EZsr0VWFuU1oAIOaRqa_Dv0WRhDElTT7
X-Authority-Analysis: v=2.4 cv=DPu/JSNb c=1 sm=1 tr=0 ts=6a970426 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=EIcjfB9IiI4px24ztqRk:22 a=yPCof4ZbAAAA:8 a=juHUTOYQj8kbW7eh5z0A:9
 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:13521
X-Proofpoint-ORIG-GUID: EZsr0VWFuU1oAIOaRqa_Dv0WRhDElTT7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAxMDE1MCBTYWx0ZWRfX7bdWiCFM0Kqb
 wYqMW7GPaPmnCYtqOiEawRhLZaA2RgEEvyxZ/9j4O2Hkymxh8JY6lyyeWGDhzWb6Ay4cVMZasgZ
 TK0q42LBFY1lqjfcmw8s+W7MSm6ZD2eRSvzSh4dIMrCuu34kW5Z2tUqxhBS+c+zNuYm/SCR9Zxf
 q476x190miZv/2O5fujXBgO9fhuKSeuFXR56LEgL8FK9CKcHWPveTCONeO5wMUlnFvMtXcOwUtY
 XBvPYSgKnxO5vaXn42GLSyy4wBPLfYmxtrv1/14ePBsepEP7AtJQ1rE5T1f5cdp5HJz/X5yMOA/
 DfAFBIFHYBJG5lPFLx/W0YD9BbVpWBAcCgJVoTHQOPt7J9habL2NYS71R7C3K66nO94+5+5czfb
 2lZSZqE6UTamdmiv7pGkZbpmF0HqA1D1RljFoSguFAZ7xd5TyK/ExodbgAW8l+DmLvTSGarmUs+
 UFpRKxB6qhcp3MoMWn8dsAN/o+5INBlyXVIYSfVw=

Extend btf__permute() with an optional transfer mode.  Type-map entries
marked with BTF_PERMUTE_ID_TRANSFER are removed from the input BTF and
copied into a newly-created split BTF returned through
btf_permute_opts.transfer_btf.

While moving types, remap type IDs for both retained and transferred
types, preserving split-BTF references to the parent BTF where needed.

String handling has to be done carefully as we do not want to have
strings that only exist in the split BTF to impose a cost on the base.
Copy referenced strings locally first, compact the parent string table
after the moved types are gone, rebase split-string offsets, and compact
the split string table.  This leaves strings exclusively needed by moved
types in the split BTF while retaining shared strings in the parent.
This will be important later for function names of inline-only functions;
these should not take up space in base BTF but should have strings in
inline BTF only.

This all provides the support needed to place inline-only BTF
in a separate BTF section, which resolve_btfids will use later.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
Assisted-by: Codex (GPT-5)
---
 tools/lib/bpf/btf.c | 285 +++++++++++++++++++++++++++++++++++++++-----
 tools/lib/bpf/btf.h |  16 ++-
 2 files changed, 271 insertions(+), 30 deletions(-)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index 9449f6f50f18..30f8c426d145 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -2147,16 +2147,9 @@ int btf__find_str(struct btf *btf, const char *s)
  *   - > 0 offset into string section, on success;
  *   - < 0, on error.
  */
-int btf__add_str(struct btf *btf, const char *s)
+static int btf_add_local_str(struct btf *btf, const char *s)
 {
-	int off;
-	int err;
-
-	if (btf->base_btf) {
-		off = btf__find_str(btf->base_btf, s);
-		if (off != -ENOENT)
-			return off;
-	}
+	int off, err;
 
 	err = btf_ensure_modifiable(btf);
 	if (err)
@@ -2167,10 +2160,24 @@ int btf__add_str(struct btf *btf, const char *s)
 		return libbpf_err(off);
 
 	btf->hdr.str_len = strset__data_size(btf->strs_set);
+	btf->strs_deduped = false;
 
 	return btf->start_str_off + off;
 }
 
+int btf__add_str(struct btf *btf, const char *s)
+{
+	int off;
+
+	if (btf->base_btf) {
+		off = btf__find_str(btf->base_btf, s);
+		if (off != -ENOENT)
+			return off;
+	}
+
+	return btf_add_local_str(btf, s);
+}
+
 static void *btf_add_type_mem(struct btf *btf, size_t add_sz)
 {
 	return libbpf_add_mem(&btf->types_data, &btf->types_data_cap, 1,
@@ -2218,6 +2225,7 @@ struct btf_pipe {
 	const struct btf *src;
 	struct btf *dst;
 	struct hashmap *str_off_map; /* map string offsets from src to dst */
+	bool force_local_strs;
 };
 
 static int btf_rewrite_str(struct btf_pipe *p, __u32 *str_off)
@@ -2234,7 +2242,10 @@ static int btf_rewrite_str(struct btf_pipe *p, __u32 *str_off)
 		return 0;
 	}
 
-	off = btf__add_str(p->dst, btf__str_by_offset(p->src, *str_off));
+	if (p->force_local_strs)
+		off = btf_add_local_str(p->dst, btf__str_by_offset(p->src, *str_off));
+	else
+		off = btf__add_str(p->dst, btf__str_by_offset(p->src, *str_off));
 	if (off < 0)
 		return off;
 
@@ -4513,6 +4524,19 @@ static int btf_dedup_strings(struct btf_dedup *d)
 	return err;
 }
 
+/* Compact strings after a type-only transformation such as btf__permute(). */
+static int btf_compact_strings(struct btf *btf, struct btf_ext *btf_ext)
+{
+	struct btf_dedup d = {
+		.btf = btf,
+		.btf_ext = btf_ext,
+	};
+
+	/* Types may have been removed since the last string compaction. */
+	btf->strs_deduped = false;
+	return btf_dedup_strings(&d);
+}
+
 /*
  * Calculate type signature hash of TYPEDEF, ignoring referenced type IDs,
  * as referenced type IDs equivalence is established separately during type
@@ -6617,8 +6641,15 @@ struct btf_permute {
 	struct btf *btf;
 	__u32 *id_map;
 	__u32 start_offs;
+	__u32 transfer_start_id;
+	bool reject_transfer;
 };
 
+static bool btf_permute_id_is_transfer(__u32 id)
+{
+	return id & BTF_PERMUTE_ID_TRANSFER;
+}
+
 /* Callback function to remap individual type ID references */
 static int btf_permute_remap_type_id(__u32 *type_id, void *ctx)
 {
@@ -6633,18 +6664,54 @@ static int btf_permute_remap_type_id(__u32 *type_id, void *ctx)
 		return -EINVAL;
 
 	*type_id = p->id_map[new_id - p->btf->start_id + p->start_offs];
+	if (p->reject_transfer && *type_id >= p->transfer_start_id)
+		return -EINVAL;
+	return 0;
+}
+
+/*
+ * String offsets in a split BTF are absolute.  If its parent string table is
+ * compacted after the split was populated, move its local string offsets to
+ * start at the parent's new end.
+ */
+static int btf_permute_rebase_split_strs(struct btf *split_btf, __u32 old_start_str_off)
+{
+	__s64 delta = split_btf->base_btf->start_str_off + split_btf->base_btf->hdr.str_len -
+		      old_start_str_off;
+	int i;
+
+	for (i = 0; i < split_btf->nr_types; i++) {
+		struct btf_field_iter it;
+		struct btf_type *t = btf_type_by_id(split_btf,
+						    split_btf->start_id + i);
+		__u32 *str_off;
+		int err;
+
+		err = btf_field_iter_init(&it, t, BTF_FIELD_ITER_STRS);
+		if (err)
+			return err;
+		while ((str_off = btf_field_iter_next(&it))) {
+			if (*str_off >= old_start_str_off)
+				*str_off += delta;
+		}
+	}
+
+	btf_set_base_btf(split_btf, split_btf->base_btf);
 	return 0;
 }
 
 int btf__permute(struct btf *btf, __u32 *id_map, __u32 id_map_cnt,
 		 const struct btf_permute_opts *opts)
 {
-	struct btf_permute p;
-	struct btf_ext *btf_ext;
+	__u32 n, start_offs = 0, nr_transfer = 0, nr_base_types;
+	__u32 next_base_id, next_transfer_id, old_str_off = 0;
+	struct btf **transfer_btfp, *transfer_btf = NULL;
+	__u32 *new_id_map = NULL, *order_map = NULL;
 	void *nt, *new_types = NULL;
-	__u32 *order_map = NULL;
+	struct btf_ext *btf_ext;
+	bool committed = false;
+	struct btf_permute p;
 	int err = 0, i;
-	__u32 n, id, start_offs = 0;
 
 	if (!OPTS_VALID(opts, btf_permute_opts))
 		return libbpf_err(-EINVAL);
@@ -6661,7 +6728,21 @@ int btf__permute(struct btf *btf, __u32 *id_map, __u32 id_map_cnt,
 	if (id_map_cnt != n)
 		return libbpf_err(-EINVAL);
 
-	/* record the sequence of types */
+	transfer_btfp = OPTS_GET(opts, transfer_btf, NULL);
+	if (transfer_btfp)
+		*transfer_btfp = NULL;
+
+	/*
+	 * Make a working copy of the id map; it will be modified (such as
+	 * removing transfer flags) unlike the caller-passed original.
+	 */
+	new_id_map = calloc(id_map_cnt, sizeof(*new_id_map));
+	if (!new_id_map) {
+		err = -ENOMEM;
+		goto done;
+	}
+	memcpy(new_id_map, id_map, id_map_cnt * sizeof(*new_id_map));
+
 	order_map = calloc(id_map_cnt, sizeof(*id_map));
 	if (!order_map) {
 		err = -ENOMEM;
@@ -6678,33 +6759,82 @@ int btf__permute(struct btf *btf, __u32 *id_map, __u32 id_map_cnt,
 	if (err)
 		goto done;
 
+	/*
+	 * Build the inverse map: for each requested destination ID, record the
+	 * original type ID that will occupy it. order_map is indexed by the
+	 * destination ID relative to the first ID represented by id_map. The
+	 * caller id_map maps old IDs to requested destinations, but BTF types
+	 * must be emitted in destination-ID order; the inverse map supplies the
+	 * old type to copy for each output slot without repeatedly searching
+         * id_map.
+         */
 	for (i = start_offs; i < id_map_cnt; i++) {
-		id = id_map[i];
-		if (id < btf->start_id || id >= btf__type_cnt(btf)) {
+		__u32 requested_id = new_id_map[i];
+		__u32 order_idx;
+
+		if (btf_permute_id_is_transfer(requested_id)) {
+			if (!transfer_btfp) {
+				err = -EINVAL;
+				goto done;
+			}
+			requested_id &= ~BTF_PERMUTE_ID_TRANSFER;
+			nr_transfer++;
+		}
+		if (requested_id < btf->start_id || requested_id >= btf__type_cnt(btf)) {
 			err = -EINVAL;
 			goto done;
 		}
-		id -= btf->start_id - start_offs;
+		order_idx = requested_id - btf->start_id + start_offs;
 		/* cannot be mapped to the same ID */
-		if (order_map[id]) {
+		if (order_map[order_idx]) {
 			err = -EINVAL;
 			goto done;
 		}
-		order_map[id] = i + btf->start_id - start_offs;
+		order_map[order_idx] = i + btf->start_id - start_offs;
+	}
+
+	/*
+	 * Turn requested destination IDs into final IDs. Retained types
+	 * occupy the compacted parent BTF first; transferred types immediately
+	 * follow them, which is where they will start in returned split BTF.
+	 */
+	nr_base_types = n - nr_transfer - start_offs;
+	next_base_id = btf->start_id;
+	next_transfer_id = btf->start_id + nr_base_types;
+	for (i = start_offs; i < id_map_cnt; i++) {
+		__u32 old_id = order_map[i];
+		__u32 old_id_idx = old_id - btf->start_id + start_offs;
+
+		if (btf_permute_id_is_transfer(new_id_map[old_id_idx]))
+			new_id_map[old_id_idx] = next_transfer_id++;
+		else
+			new_id_map[old_id_idx] = next_base_id++;
 	}
 
+	/*
+	 * Copy retained types and reject references into the split (transfer)
+	 * BTF from the original BTF.
+	 */
 	p.btf = btf;
-	p.id_map = id_map;
+	p.id_map = new_id_map;
 	p.start_offs = start_offs;
+	p.transfer_start_id = btf->start_id + nr_base_types;
+	p.reject_transfer = true;
 	nt = new_types;
 	for (i = start_offs; i < id_map_cnt; i++) {
 		struct btf_field_iter it;
 		const struct btf_type *t;
 		__u32 *type_id;
+		__u32 old_id;
+		__u32 old_id_idx;
 		int type_size;
 
-		id = order_map[i];
-		t = btf__type_by_id(btf, id);
+		old_id = order_map[i];
+		old_id_idx = old_id - btf->start_id + start_offs;
+
+		if (new_id_map[old_id_idx] >= btf->start_id + nr_base_types)
+			continue;
+		t = btf__type_by_id(btf, old_id);
 		type_size = btf_type_size(btf, t);
 		memcpy(nt, t, type_size);
 
@@ -6714,14 +6844,71 @@ int btf__permute(struct btf *btf, __u32 *id_map, __u32 id_map_cnt,
 			goto done;
 		while ((type_id = btf_field_iter_next(&it))) {
 			err = btf_permute_remap_type_id(type_id, &p);
-			if (err)
+			if (err < 0)
 				goto done;
 		}
 
 		nt += type_size;
 	}
 
-	/* fix up referenced IDs for btf_ext */
+	/*
+	 * Copy transferred types into a split BTF. They can reference both
+	 * retained parent types and other transferred types, so do not reject
+	 * final IDs in the split-ID range while rewriting their references.
+	 */
+	if (nr_transfer) {
+		struct btf_permute transfer_p;
+
+		transfer_btf = btf__new_empty_split(btf);
+		if (!transfer_btf) {
+			err = -errno;
+			goto done;
+		}
+		old_str_off = transfer_btf->start_str_off;
+
+		transfer_p = p;
+		/* Split transfer types may refer to other split types */
+		transfer_p.reject_transfer = false;
+		for (i = start_offs; i < id_map_cnt; i++) {
+			struct btf_field_iter it;
+			struct btf_pipe pipe = {
+				.src = btf,
+				.dst = transfer_btf,
+				.force_local_strs = true,
+			};
+			const struct btf_type *t;
+			struct btf_type *new_t;
+			__u32 *type_id;
+			__u32 old_id;
+			__u32 old_id_idx;
+			int new_id;
+
+			old_id = order_map[i];
+			old_id_idx = old_id - btf->start_id + start_offs;
+
+			if (!btf_permute_id_is_transfer(id_map[old_id_idx]))
+				continue;
+			t = btf__type_by_id(btf, old_id);
+			new_id = btf_add_type(&pipe, t);
+			if (new_id < 0) {
+				err = new_id;
+				goto done;
+			}
+			new_t = btf_type_by_id(transfer_btf, new_id);
+			err = btf_field_iter_init(&it, new_t, BTF_FIELD_ITER_IDS);
+			if (!err) {
+				while ((type_id = btf_field_iter_next(&it))) {
+					err = btf_permute_remap_type_id(type_id, &transfer_p);
+					if (err)
+						break;
+				}
+			}
+			if (err < 0)
+				goto done;
+		}
+	}
+
+	/* Rewrite optional .BTF.ext references to retained type IDs. */
 	btf_ext = OPTS_GET(opts, btf_ext, NULL);
 	if (btf_ext) {
 		err = btf_ext_visit_type_ids(btf_ext, btf_permute_remap_type_id, &p);
@@ -6729,18 +6916,58 @@ int btf__permute(struct btf *btf, __u32 *id_map, __u32 id_map_cnt,
 			goto done;
 	}
 
-	for (nt = new_types, i = 0; i < id_map_cnt - start_offs; i++) {
+	/* Install the compacted parent types and rebuild their index. */
+	for (nt = new_types, i = 0; i < nr_base_types; i++) {
 		btf->type_offs[i] = nt - new_types;
 		nt += btf_type_size(btf, nt);
 	}
-
-	free(order_map);
 	free(btf->types_data);
 	btf->types_data = new_types;
+	committed = true;
+	btf_hdr_update_type_len(btf, nt - new_types);
+	btf->nr_types = nr_base_types;
+
+	/*
+	 * An important goal is to also transfer strings to the transfer
+	 * BTF where they do not have duplicates in BTF. This is important
+	 * for cases like inline BTF where inline function names could
+	 * comprise a significant portion of the string table. The approach
+	 * is to first compact the set of strings in the base now transfer
+	 * is complete; this will remove unreferenced strings. Then
+	 * local references in the transfer BTF have to be moved downwards
+	 * based upon that compaction. Finally also compact transfer BTF
+	 * references so that we replace duplicate references in split with
+	 * base references where present.
+	 *
+	 * Once all this is done, we end up with transfer-only strings in
+	 * transfer split BTF and shared strings in BTF. The result is
+	 * a transfer BTF with a lot of transfer-only strings will not
+	 * pollute the string table of the non-transfer BTF.
+	 */
+	if (transfer_btf) {
+		err = btf_compact_strings(btf, btf_ext);
+		if (err)
+			goto done;
+		err = btf_permute_rebase_split_strs(transfer_btf, old_str_off);
+		if (err)
+			goto done;
+		err = btf_compact_strings(transfer_btf, NULL);
+		if (err)
+			goto done;
+		*transfer_btfp = transfer_btf;
+	}
+
+	/* On success return the final old-to-new type-ID map to the caller. */
+	memcpy(id_map, new_id_map, id_map_cnt * sizeof(*id_map));
+	free(new_id_map);
+	free(order_map);
 	return 0;
 
 done:
+	free(new_id_map);
 	free(order_map);
-	free(new_types);
+	if (!committed)
+		free(new_types);
+	btf__free(transfer_btf);
 	return libbpf_err(err);
 }
diff --git a/tools/lib/bpf/btf.h b/tools/lib/bpf/btf.h
index 57f12630c5d1..8ce569755773 100644
--- a/tools/lib/bpf/btf.h
+++ b/tools/lib/bpf/btf.h
@@ -321,9 +321,17 @@ struct btf_permute_opts {
 	size_t sz;
 	/* optional .BTF.ext info along the main BTF info */
 	struct btf_ext *btf_ext;
+	/*
+	 * If set, types whose map entry has BTF_PERMUTE_ID_TRANSFER set are
+	 * removed from @btf and returned in a new split BTF based on @btf.
+	 */
+	struct btf **transfer_btf;
 	size_t :0;
 };
-#define btf_permute_opts__last_field btf_ext
+#define btf_permute_opts__last_field transfer_btf
+
+/* Mark an id_map entry as a type to be moved to .transfer_btf. */
+#define BTF_PERMUTE_ID_TRANSFER (1U << 31)
 
 /**
  * @brief **btf__permute()** rearranges BTF types in-place according to a specified ID mapping
@@ -349,6 +357,12 @@ struct btf_permute_opts {
  * - Mapping is defined as `id_map[original_id - start_id] = new_id`
  * - `start_id` equals `btf__type_cnt(btf__base_btf(btf))`
  *
+ * An @id_map entry can be ORed with BTF_PERMUTE_ID_TRANSFER to move that
+ * type to a newly-created split BTF returned through @opts->transfer_btf.
+ * The low bits still specify the type's position in the requested ordering.
+ * The id map is updated to contain the final IDs in the base and returned
+ * split BTF.
+ *
  * After permutation, all type references within the BTF data and optional
  * BTF extension (if provided via @opts) are updated automatically.
  *
-- 
2.43.5

