Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23AB048986D;
	Tue,  1 Sep 2026 16:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788281953; cv=none; b=soSw9kwl5wkXPYD/SxvdzcB7PMapVAxxnY3/1o+9Z8pyxAqh9YJ5njysKvYVAZLxrHZmkQFgohvfk2xWi563hp6KfYlwBCHE1qlJDIS2iqyJp1uR2bVGYarM8n0HPzFS7gaZmLwYWOcDgYazr72slyIEOkezSR08xLjiQvCcCCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788281953; c=relaxed/simple;
	bh=dUe40HZzf+/0R5omxtMUxtsHIKdpY/p+PJL7fvppHBw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jOODiC5XuBQHMCyyhdb46v5+MG+jlIe4nlwdOaQsGs2/d7AOZoeRYtxYpMTsbzEsoOmqnOcfkOVf9MDvcxz7vd4n1Zu7Gk65NjcLWKMvNDRjgQdlZc5tzYVMDA3GoIJCFrs4H3eQsoLhIXVKYHyZ59yAOEiwJ8hl61jnTFh1xPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=fnhGrWQg; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fnhGrWQg"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 681EQbGC3963534;
	Tue, 1 Sep 2026 16:58:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=PSRKz
	lI1xFHPf4VHGg0fdKAch0Pl4pYsEAAVEqtD1zg=; b=fnhGrWQgFewdHpBvX7I1K
	XitPbqG3M4ZVBNC1l0ApviAaKlr+9NC62udaB2flnRiYABWN07z4cBs6bud6ang4
	eIc29ZMZrm0MuX4CI3vg+a7DP0yhAHCAUkLNLKTFroGjR3BnitYzmUlnsZEh4ehF
	WCXK07GPgCZP5VWqLFCP53JA64PLy7DyNwoumHUPODEkOdStiS3LIRxoGIerm3sy
	2aFVuyU2hTQRgNg1dfoie9TOcF4zK+yzaHpeFTleg/8OeFhEdGW9g2xvV+st9h+H
	lqYRmL+vCkLX+f7Yn2H0p+mCOhFgEPmqkF1F6hbNZmLSSuKJsqEAUnC0vXbacNvB
	w==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4gbqyrw3u3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 01 Sep 2026 16:58:46 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 681GjUH1001862;
	Tue, 1 Sep 2026 16:58:45 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4gdymtg945-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 01 Sep 2026 16:58:45 +0000 (GMT)
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 681Gw1WF011129;
	Tue, 1 Sep 2026 16:58:45 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-52-250.vpn.oracle.com [10.154.52.250])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4gdymtg8f6-13;
	Tue, 01 Sep 2026 16:58:44 +0000 (GMT)
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
Subject: [PATCH v2 bpf-next 12/18] resolve_btfids: Extract inline BTF
Date: Tue,  1 Sep 2026 17:57:51 +0100
Message-ID: <20260901165757.801449-13-alan.maguire@oracle.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAxMDE1MCBTYWx0ZWRfX7KA80ASY72P7
 j7zf7zkSJfV9tK4eWxo3lu8aR9alIaqqzxVB4PeURDAFwp4/6a2yqtDMbiKum3U5Xlkc0ZuvGaN
 CyR0SiHVobD3Bu2L7Ownza4dukZLFhWssJAou0bVyqBtSG5MkHmBTPJHaQkAImHDyPN+6GVrRJ6
 6vbWIxz8DANGHkxNL+Cfec4c1qMm+qNSe9zRwwwb9BknMFY0RqLDp7Ioiskw1AS60hBZYB968me
 /ses6MXwbUlb5v7oaFQioDTpWNyWM9qHhxUslvWwMlQXLSepvjX9EFTUpDoO++IPInTXuYbLYhF
 U4IM8VTTEZ7FhRF1ToscHRR65P0pIF+L0kg6AkSrtM6Hg5Dr60HscK++3HfqyVFx704wxjZFLQp
 pV0DDGkleMKjBTypQOvn3AS/EbLo4maOSelxnfKTzs96x03TRI8jj4nDi4RxyJUG7AwAWjqHSDM
 vx9NHegUUEG9DUHvulOl2sd48kWgeK0mwxml7yho=
X-Proofpoint-ORIG-GUID: 67vj0pdK74OegcVXv0pSyCoEwFro6X8Y
X-Authority-Analysis: v=2.4 cv=fbCdDUQF c=1 sm=1 tr=0 ts=6a970447 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=7Gl3-_t3PgB9XO-mQDs3:22 a=yPCof4ZbAAAA:8 a=iAimDDjqTF20z95TCTwA:9
 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:13521
X-Proofpoint-GUID: 67vj0pdK74OegcVXv0pSyCoEwFro6X8Y
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAxMDE1MCBTYWx0ZWRfXz+v8WPr4NuS0
 vt1wduwppYjzFlD+tceekHD+3lzZ2jSMF0oLEHp3gBsYq0GKRwo0nz1XRsH2NI0zb+lfJzNLvH4
 lrYGcqUUxWjje08f0XQDb/pw3iOYUu8bZRVfkvw0AUBeElL9PA+c

Add an --inline option to extract LOC_PARAM, LOC_PROTO and LOCSEC
types to a new inline split .BTF.inline while sorting BTF.

Move LOC_PARAM, LOC_PROTO, and LOCSEC types to the split BTF.  Also move
a FUNC when it is referenced only by LOCSEC, has no defined STT_FUNC
symbol, and is not used by .BTF_ids.  Move its FUNC_PROTO when no
retained BTF type references that prototype.

Collect defined ELF function symbols to distinguish fully inlined
functions from functions that still have an out-of-line implementation.
The resulting .BTF.inline therefore contains only fully inlined FUNCs
(or any which have name collisions with other uninlined functions).

Sort types so transferred FUNCs, eligible FUNC_PROTOs, and LOC* types
form a self-contained split BTF.  Sort LOCSEC records by projected
function BTF ID, instruction offset, and location-prototype ID before
permuting, preserving lookup order after IDs are remapped.

The end state is

- strings are moved to split BTF along with inline-related types
  when they do not have another consumer in vmlinux BTF; the goal
 is to minimum cost for vmlinux of inline info
- partially-inlined functions referred to in LOCSEC are in vmlinux BTF
- fully inlined functions are in vmlinux inline BTF
- LOCSEC data is sorted by FUNC type id as the pattern for inline
  tracers will be to look up the function by name; once that is
  done a binary search based on FUNC type id can quickly identify
  relevant entries in LOCSEC

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 tools/bpf/resolve_btfids/main.c | 336 +++++++++++++++++++++++++++++++-
 1 file changed, 330 insertions(+), 6 deletions(-)

diff --git a/tools/bpf/resolve_btfids/main.c b/tools/bpf/resolve_btfids/main.c
index 37d7e7224207..20b228c4d678 100644
--- a/tools/bpf/resolve_btfids/main.c
+++ b/tools/bpf/resolve_btfids/main.c
@@ -142,7 +142,9 @@ struct object {
 
 	struct btf *btf;
 	struct btf *base_btf;
+	struct btf *inline_btf;
 	bool distill_base;
+	bool extract_inline;
 
 	struct {
 		int		 fd;
@@ -154,6 +156,10 @@ struct object {
 		size_t		 strtabidx;
 		unsigned long	 idlist_addr;
 		int		 encoding;
+		const char	**func_symbols;
+		u32		 func_symbols_cnt;
+		u32		 func_symbols_cap;
+		bool		 func_symbols_collected;
 	} efile;
 
 	struct rb_root	sets;
@@ -572,6 +578,58 @@ static const char *find_name_by_addr(struct object *obj, Elf64_Addr addr)
 	return res ? res->name : NULL;
 }
 
+static int cmp_func_symbol(const void *a, const void *b)
+{
+	const char * const *name = a;
+	const char * const *other = b;
+
+	return strcmp(*name, *other);
+}
+
+static int collect_func_symbols(struct object *obj)
+{
+	Elf_Scn *scn;
+	GElf_Shdr sh;
+	int n, i;
+
+	if (obj->efile.symbols_shndx == -1)
+		return 0;
+
+	scn = elf_getscn(obj->efile.elf, obj->efile.symbols_shndx);
+	if (!scn || gelf_getshdr(scn, &sh) != &sh)
+		return -EINVAL;
+	n = sh.sh_size / sh.sh_entsize;
+
+	for (i = 0; i < n; i++) {
+		GElf_Sym sym;
+		const char *name;
+
+		if (!gelf_getsym(obj->efile.symbols, i, &sym))
+			return -EINVAL;
+		if (GELF_ST_TYPE(sym.st_info) != STT_FUNC ||
+		    sym.st_shndx == SHN_UNDEF || !sym.st_name)
+			continue;
+		name = elf_strptr(obj->efile.elf, obj->efile.strtabidx, sym.st_name);
+		if (!name)
+			return -EINVAL;
+		if (ensure_mem(&obj->efile.func_symbols, &obj->efile.func_symbols_cap,
+			       obj->efile.func_symbols_cnt + 1))
+			return -ENOMEM;
+		obj->efile.func_symbols[obj->efile.func_symbols_cnt++] = name;
+	}
+
+	qsort(obj->efile.func_symbols, obj->efile.func_symbols_cnt,
+	      sizeof(*obj->efile.func_symbols), cmp_func_symbol);
+	obj->efile.func_symbols_collected = true;
+	return 0;
+}
+
+static bool has_func_symbol(const struct object *obj, const char *name)
+{
+	return bsearch(&name, obj->efile.func_symbols, obj->efile.func_symbols_cnt,
+		       sizeof(*obj->efile.func_symbols), cmp_func_symbol) != NULL;
+}
+
 static int symbols_collect(struct object *obj)
 {
 	Elf_Scn *scn = NULL;
@@ -1514,14 +1572,193 @@ static int btf2btf(struct object *obj)
  * Sort types by name in ascending order resulting in all
  * anonymous types being placed before named types.
  */
+struct btf_name_sort {
+	struct btf *btf;
+	bool extract_inline;
+	bool *transfer_funcs;
+	bool *transfer_protos;
+};
+
+static int btf_inline_kind_order(const struct btf_type *t, bool transfer_func,
+				 bool transfer_proto)
+{
+	if (transfer_func)
+		return 1;
+	if (transfer_proto)
+		return 2;
+	if (btf_is_loc_param(t))
+		return 3;
+	if (btf_is_loc_proto(t))
+		return 4;
+	if (btf_is_locsec(t))
+		return 5;
+	return 0;
+}
+
+enum inline_ref_kind {
+	INLINE_REF_FUNC,
+	INLINE_REF_FUNC_PROTO,
+};
+
+static void mark_inline_ref(struct btf *btf, bool *refs, int start_id,
+			    int type_cnt, __u32 type_id, enum inline_ref_kind ref_kind)
+{
+	const struct btf_type *t;
+
+	if (type_id < start_id || type_id >= type_cnt)
+		return;
+	t = btf__type_by_id(btf, type_id);
+	if ((ref_kind == INLINE_REF_FUNC && btf_is_func(t)) ||
+	    (ref_kind == INLINE_REF_FUNC_PROTO && btf_is_func_proto(t)))
+		refs[type_id] = true;
+}
+
+static void mark_inline_type_refs(struct btf *btf, bool *refs, int start_id,
+				  int type_cnt, const struct btf_type *t,
+				  enum inline_ref_kind ref_kind)
+{
+	/*
+	 * These are the only BTF kinds that can directly reference a FUNC or
+	 * FUNC_PROTO (aside from LOCSEC).
+	 */
+	switch (btf_kind(t)) {
+	case BTF_KIND_CONST:
+	case BTF_KIND_VOLATILE:
+	case BTF_KIND_RESTRICT:
+	case BTF_KIND_PTR:
+	case BTF_KIND_TYPEDEF:
+	case BTF_KIND_FUNC:
+	case BTF_KIND_VAR:
+	case BTF_KIND_DECL_TAG:
+	case BTF_KIND_TYPE_TAG:
+		mark_inline_ref(btf, refs, start_id, type_cnt, t->type, ref_kind);
+		break;
+	default:
+		return;
+	}
+}
+
+/* A FUNC can move to inline BTF only when LOCSEC is its sole BTF user. */
+static int find_inline_funcs(struct object *obj, bool **transfer_funcsp,
+			     bool **transfer_protosp)
+{
+	bool *locsec_refs, *other_refs, *proto_candidates, *proto_base_refs;
+	int i, type_cnt, start_id = 0;
+	struct btf *btf = obj->btf;
+
+	type_cnt = btf__type_cnt(btf);
+	*transfer_funcsp = NULL;
+	*transfer_protosp = NULL;
+	if (btf__base_btf(btf))
+		start_id = btf__type_cnt(btf__base_btf(btf));
+
+	locsec_refs = calloc(type_cnt, sizeof(*locsec_refs));
+	other_refs = calloc(type_cnt, sizeof(*other_refs));
+	proto_candidates = calloc(type_cnt, sizeof(*proto_candidates));
+	proto_base_refs = calloc(type_cnt, sizeof(*proto_base_refs));
+	if (!locsec_refs || !other_refs || !proto_candidates || !proto_base_refs)
+		goto err;
+
+	/* First identify locsec FUNC references */
+	for (i = start_id; i < type_cnt; i++) {
+		const struct btf_type *t = btf__type_by_id(btf, i);
+		const struct btf_loc *loc;
+		int j;
+
+		if (!btf_is_locsec(t))
+			continue;
+		loc = btf_locsec_locs(t);
+		for (j = 0; j < btf_vlen(t); j++, loc++) {
+			if (loc->func >= start_id && loc->func < type_cnt &&
+			    btf_is_func(btf__type_by_id(btf, loc->func)))
+				locsec_refs[loc->func] = true;
+		}
+	}
+
+	/*
+	 * Then mark any additional references to them; references outside
+	 * of LOCSEC make the FUNC ineligible for transfer.
+	 */
+	for (i = start_id; i < type_cnt; i++) {
+		const struct btf_type *t = btf__type_by_id(btf, i);
+
+		if (btf_is_locsec(t))
+			continue;
+		mark_inline_type_refs(btf, other_refs, start_id, type_cnt, t,
+				      INLINE_REF_FUNC);
+	}
+
+	for (i = start_id; i < type_cnt; i++) {
+		const struct btf_type *t = btf__type_by_id(btf, i);
+		const char *name;
+
+		/* If there are no locsec references, or we find additional
+		 * non-locsec references, skip as ineligible.
+		 */
+		if (!locsec_refs[i] || other_refs[i])
+			continue;
+		name = btf__name_by_offset(btf, t->name_off);
+		/* Keep out-of-line functions and BTF ID users in the main BTF. */
+		if (!obj->efile.func_symbols_collected || has_func_symbol(obj, name) ||
+		    btf_id__find(&obj->funcs, name))
+			locsec_refs[i] = false;
+	}
+
+	for (i = start_id; i < type_cnt; i++) {
+		const struct btf_type *t;
+
+		if (!locsec_refs[i])
+			continue;
+		t = btf__type_by_id(btf, i);
+		proto_candidates[t->type] = true;
+	}
+
+	/* Mark every FUNC_PROTO directly needed by retained base BTF types. */
+	for (i = start_id; i < type_cnt; i++) {
+		const struct btf_type *t = btf__type_by_id(btf, i);
+
+		if (locsec_refs[i] || proto_candidates[i] ||
+		    btf_is_loc_param(t) || btf_is_loc_proto(t) ||
+		    btf_is_locsec(t))
+			continue;
+		mark_inline_type_refs(btf, proto_base_refs, start_id, type_cnt, t,
+				      INLINE_REF_FUNC_PROTO);
+	}
+	for (i = start_id; i < type_cnt; i++)
+		proto_candidates[i] &= !proto_base_refs[i];
+
+	free(other_refs);
+	*transfer_funcsp = locsec_refs;
+	*transfer_protosp = proto_candidates;
+	free(proto_base_refs);
+	return 0;
+err:
+	free(locsec_refs);
+	free(other_refs);
+	free(proto_candidates);
+	free(proto_base_refs);
+	return -ENOMEM;
+}
+
 static int cmp_type_names(const void *a, const void *b, void *priv)
 {
-	struct btf *btf = (struct btf *)priv;
+	struct btf_name_sort *sort = priv;
+	struct btf *btf = sort->btf;
 	const struct btf_type *ta = btf__type_by_id(btf, *(__u32 *)a);
 	const struct btf_type *tb = btf__type_by_id(btf, *(__u32 *)b);
 	const char *na, *nb;
+	int inline_order;
 	int r;
 
+	if (sort->extract_inline) {
+		inline_order = btf_inline_kind_order(ta, sort->transfer_funcs[*(__u32 *)a],
+					     sort->transfer_protos[*(__u32 *)a]) -
+			       btf_inline_kind_order(tb, sort->transfer_funcs[*(__u32 *)b],
+					     sort->transfer_protos[*(__u32 *)b]);
+		if (inline_order)
+			return inline_order;
+	}
+
 	na = btf__str_by_offset(btf, ta->name_off);
 	nb = btf__str_by_offset(btf, tb->name_off);
 	r = strcmp(na, nb);
@@ -1532,8 +1769,60 @@ static int cmp_type_names(const void *a, const void *b, void *priv)
 	return *(__u32 *)a < *(__u32 *)b ? -1 : 1;
 }
 
-static int sort_btf_by_name(struct btf *btf)
+struct loc_sort {
+	const __u32 *id_map;
+	__u32 start_id;
+};
+
+static __u32 projected_type_id(const struct loc_sort *sort, __u32 id)
+{
+	if (id < sort->start_id)
+		return id;
+	return sort->id_map[id - sort->start_id] & ~BTF_PERMUTE_ID_TRANSFER;
+}
+
+static int cmp_loc(const void *a, const void *b, void *priv)
 {
+	const struct loc_sort *sort = priv;
+	const struct btf_loc *la = a, *lb = b;
+	__u32 afunc = projected_type_id(sort, la->func);
+	__u32 bfunc = projected_type_id(sort, lb->func);
+	__u32 aproto = projected_type_id(sort, la->loc_proto);
+	__u32 bproto = projected_type_id(sort, lb->loc_proto);
+
+	if (afunc != bfunc)
+		return afunc < bfunc ? -1 : 1;
+	if (la->offset != lb->offset)
+		return la->offset < lb->offset ? -1 : 1;
+	if (aproto != bproto)
+		return aproto < bproto ? -1 : 1;
+	return 0;
+}
+
+static void sort_locsecs(struct btf *btf, const __u32 *id_map, __u32 start_id,
+			 int nr_types)
+{
+	struct loc_sort sort = { .id_map = id_map, .start_id = start_id };
+	int i;
+
+	for (i = 0; i < nr_types; i++) {
+		struct btf_type *t = (struct btf_type *)btf__type_by_id(btf, start_id + i);
+
+		if (btf_is_locsec(t))
+			qsort_r(btf_locsec_locs(t), btf_vlen(t), sizeof(struct btf_loc),
+				cmp_loc, &sort);
+	}
+}
+
+static int sort_btf_by_name(struct object *obj)
+{
+	struct btf *btf = obj->btf;
+	bool *transfer_funcs = NULL, *transfer_protos = NULL;
+	struct btf_name_sort sort = {
+		.btf = btf,
+		.extract_inline = obj->extract_inline,
+	};
+	LIBBPF_OPTS(btf_permute_opts, opts);
 	__u32 *permute_ids = NULL, *id_map = NULL;
 	int nr_types, i, err = 0;
 	__u32 start_id = 0, id;
@@ -1541,6 +1830,13 @@ static int sort_btf_by_name(struct btf *btf)
 	if (btf__base_btf(btf))
 		start_id = btf__type_cnt(btf__base_btf(btf));
 	nr_types = btf__type_cnt(btf) - start_id;
+	if (obj->extract_inline) {
+		err = find_inline_funcs(obj, &transfer_funcs, &transfer_protos);
+		if (err)
+			goto out;
+		sort.transfer_funcs = transfer_funcs;
+		sort.transfer_protos = transfer_protos;
+	}
 
 	permute_ids = calloc(nr_types, sizeof(*permute_ids));
 	if (!permute_ids) {
@@ -1557,21 +1853,37 @@ static int sort_btf_by_name(struct btf *btf)
 	for (i = 0, id = start_id; i < nr_types; i++, id++)
 		permute_ids[i] = id;
 
-	qsort_r(permute_ids, nr_types, sizeof(*permute_ids), cmp_type_names,
-		btf);
+	qsort_r(permute_ids, nr_types, sizeof(*permute_ids), cmp_type_names, &sort);
 
 	for (i = 0; i < nr_types; i++) {
 		id = permute_ids[i] - start_id;
 		id_map[id] = i + start_id;
+		if (obj->extract_inline &&
+		    btf_inline_kind_order(btf__type_by_id(btf, permute_ids[i]),
+					  transfer_funcs[permute_ids[i]],
+					  transfer_protos[permute_ids[i]]))
+			id_map[id] |= BTF_PERMUTE_ID_TRANSFER;
 	}
 
-	err = btf__permute(btf, id_map, nr_types, NULL);
+	/*
+	 * Key LOCSEC records by their post-permutation function ID and offset
+	 * since the tracer pattern will be to look up FUNC by name, then
+	 * find LOCSEC records for that function.
+	 */
+	sort_locsecs(btf, id_map, start_id, nr_types);
+
+	if (obj->extract_inline)
+		opts.transfer_btf = &obj->inline_btf;
+	err = btf__permute(btf, id_map, nr_types,
+			   obj->extract_inline ? &opts : NULL);
 	if (err)
 		pr_err("FAILED: btf permute: %s\n", strerror(-err));
 
 out:
 	free(permute_ids);
 	free(id_map);
+	free(transfer_funcs);
+	free(transfer_protos);
 	return err;
 }
 
@@ -1599,7 +1911,7 @@ static int finalize_btf(struct object *obj)
 		obj->btf = btf;
 	}
 
-	err = sort_btf_by_name(obj->btf);
+	err = sort_btf_by_name(obj);
 	if (err) {
 		pr_err("FAILED to sort BTF: %s\n", strerror(errno));
 		goto out_err;
@@ -1773,6 +2085,8 @@ int main(int argc, const char **argv)
 			    "turn warnings into errors"),
 		OPT_BOOLEAN(0, "distill_base", &obj.distill_base,
 			    "distill --btf_base and emit .BTF.base section data"),
+		OPT_BOOLEAN(0, "inline", &obj.extract_inline,
+			    "extract location BTF into a .BTF.inline file"),
 		OPT_STRING(0, "patch_btfids", &btfids_path, "file",
 			   "path to .BTF_ids section data blob to patch into ELF file"),
 		OPT_END()
@@ -1791,6 +2105,8 @@ int main(int argc, const char **argv)
 
 	if (elf_collect(&obj))
 		goto out;
+	if (obj.extract_inline && collect_func_symbols(&obj))
+		goto out;
 
 	/*
 	 * We did not find .BTF_ids section or symbols section,
@@ -1841,11 +2157,18 @@ int main(int argc, const char **argv)
 		if (err)
 			goto out;
 	}
+	if (obj.inline_btf) {
+		err = make_out_path(out_path, sizeof(out_path), obj.path, BTF_ELF_SEC ".inline");
+		err = err ?: dump_raw_btf(obj.inline_btf, out_path);
+		if (err)
+			goto out;
+	}
 
 	if (!(fatal_warnings && warnings))
 		err = 0;
 out:
 	btf__free(obj.base_btf);
+	btf__free(obj.inline_btf);
 	btf__free(obj.btf);
 	btf_id__free_all(&obj.structs);
 	btf_id__free_all(&obj.unions);
@@ -1853,6 +2176,7 @@ int main(int argc, const char **argv)
 	btf_id__free_all(&obj.funcs);
 	btf_id__free_all(&obj.sets);
 	free(obj.addr_syms);
+	free(obj.efile.func_symbols);
 	if (obj.efile.elf) {
 		elf_end(obj.efile.elf);
 		close(obj.efile.fd);
-- 
2.43.5

