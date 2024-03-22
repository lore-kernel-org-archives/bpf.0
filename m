Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 858102D630
	for <bpf@vger.kernel.org>; Fri, 22 Mar 2024 10:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711103142; cv=none; b=L3Q4Yx94LO0zwOvi9uBP+RkcaXaGvjfuhUlw5t1V2KE1kT3KMp+tLQjcu5c0rfkdQDKA9bi8tlms7EzpMN0I9RUu6JubFPssaDPgpKoW8Y6cZxIo0mIbuWf1TxNiz7XQ6X2/kEULABwJwMQRLCSxCXtRVxvBonZD/SdxbSibqa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711103142; c=relaxed/simple;
	bh=Zs9Y1wM2YsIbeOHTYB+ah9Q7gbpQDLBKAYMfNUd4Olo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RYtrZHa0Z3WdswyNQUOw0H0YJvZboxxgxlDaEdrXEPfM8sItga2MTYzPYGnt9cmJGIoCHxH/HRFjwZVuGaeMSj05mS4UhaMC7VYTsPBwEt1R/abdPRboc1GQOUxVdkddp6ZnHyp6wKhKbeGLyEIjrZw79CWlgZfHGtiJWziY8PY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=klG1Hk/U; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="klG1Hk/U"
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42M7YqKO032321;
	Fri, 22 Mar 2024 10:25:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-11-20;
 bh=Lx2GAqaYZWH+9g4BHoGy4oDLNSkIal734L0EnuJxvUY=;
 b=klG1Hk/UqkEHiNwzNzhtjTAXsGHBjUsgsXmfg2ySiXbSZd/WKzQirw/auEVVGKe9rmd2
 DrukIIvUuO1LyP3P8lZKh1ZjpLky7gaQy16dzOCaQMVTowpSCzO1FsIfVMHP5UzTsajZ
 Es7IxK2Cm/PkImDxKblQ4fIiY1o0x25j0ucIsbhdJ+mwOMhEUFIlPzETnm8d8wIctXqy
 Xxlc2IMG/ia+bIV5fdCiID55QphVzyvuEFQUaTT3h4wNn0E6Cnk2hGSYQKfRLEKVOCog
 2Nb+pMazr+4gfqIPOmzRAa+AkQ6uUxeDQNosJ3gX+uNB4/kdvYKoLxNZROjjEcyATyQH Lg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3x0wvqrs7k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 22 Mar 2024 10:25:18 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42M9Gra4014999;
	Fri, 22 Mar 2024 10:25:17 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3x0wvk2hf7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 22 Mar 2024 10:25:17 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 42MAK0kT030399;
	Fri, 22 Mar 2024 10:25:16 GMT
Received: from bpf.uk.oracle.com (dhcp-10-175-192-105.vpn.oracle.com [10.175.192.105])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3x0wvk2h75-4;
	Fri, 22 Mar 2024 10:25:16 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: andrii@kernel.org, jolsa@kernel.org, acme@redhat.com,
        quentin@isovalent.com
Cc: eddyz87@gmail.com, mykolal@fb.com, ast@kernel.org, daniel@iogearbox.net,
        martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, houtao1@huawei.com, bpf@vger.kernel.org,
        masahiroy@kernel.org, mcgrof@kernel.org, nathan@kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [RFC bpf-next 02/13] libbpf: add btf__new_split_base_ref() creating split BTF with reference base BTF
Date: Fri, 22 Mar 2024 10:24:44 +0000
Message-Id: <20240322102455.98558-4-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240322102455.98558-1-alan.maguire@oracle.com>
References: <20240322102455.98558-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-22_06,2024-03-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 mlxscore=0
 malwarescore=0 suspectscore=0 spamscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2403210000
 definitions=main-2403220074
X-Proofpoint-ORIG-GUID: e7nAVQmXzy1LvbFtAJLTdpFdlUR1P7cz
X-Proofpoint-GUID: e7nAVQmXzy1LvbFtAJLTdpFdlUR1P7cz

To support more robust split BTF, adding supplemental context for the
base BTF type ids that split BTF refers to is required.  Without such
references, a simple shuffling of base BTF type ids (without any other
significant change) invalidates the split BTF.  Here the attempt is made
to store additional context to make split BTF more robust.

This context comes in the form of "reference" base BTF - this base BTF
constitutes the minimal BTF representation needed to disambiguate split BTF
references to base BTF.  So for example if a struct is referred to from
split -> base BTF, a forward representation of that struct is retained
in reference base BTF, and split BTF refers to it.  Base types are kept
intact in reference base BTF, and reference types like pointers are stored
as-is.  Avoiding struct/union/enum/enum64 expansion is important to keep
reference base BTF representation to a minimum size; however anonymous
struct, union and enum[64] types are represented in full since type details
are needed to disambiguate the reference - the name is not enough in those
cases since there is no name.  In practice these are rare; in sample
cases where reference base BTF was generated for in-tree kernel modules,
only a few were needed in base reference BTF.  These represent the
anonymous struct/unions that are used by the module but were de-duplicated
to use base vmlinux BTF ids instead.

When successful, a new representation of the split BTF passed in is
returned.  It refers to the reference BTF as its base, and both returned
split and base BTF need to be freed by the caller.

So to take a simple example, with split BTF with a type referring
to "struct sk_buff", we will generate base reference BTF with a
FWD struct sk_buff, and the split BTF will refer to it instead.

Tools like pahole can utilize such split BTF to popuate the .BTF section
(split BTF) and an additional .BTF.base_ref section (base reference BTF).
Then when the split BTF is loaded, the base reference BTF can be used
to reconcile split BTF and the current - and possibly changed - base BTF.

So for example if "struct sk_buff" was id 502 when the split BTF was
originally generated,  we can use the reference base BTF to see that
id 502 refers to a "struct sk_buff" and replace instances of id 502
with the current (reconciled) base BTF sk_buff type id.

Base reference BTF is small; when building a kernel with all modules
using base reference BTF as a test, the average size for module
base reference BTF is 1555 bytes (standard deviation 1563).  The
maximum base reference BTF size across ~2700 modules was 37895 bytes.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 tools/lib/bpf/btf.c      | 215 +++++++++++++++++++++++++++++++++++++--
 tools/lib/bpf/btf.h      |  15 +++
 tools/lib/bpf/libbpf.map |   1 +
 3 files changed, 225 insertions(+), 6 deletions(-)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index dcff6c29c851..f02477af3d79 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -1771,9 +1771,8 @@ static int btf_rewrite_str(__u32 *str_off, void *ctx)
 	return 0;
 }
 
-int btf__add_type(struct btf *btf, const struct btf *src_btf, const struct btf_type *src_type)
+static int btf_add_type(struct btf_pipe *p, const struct btf_type *src_type)
 {
-	struct btf_pipe p = { .src = src_btf, .dst = btf };
 	struct btf_type *t;
 	int sz, err;
 
@@ -1782,20 +1781,27 @@ int btf__add_type(struct btf *btf, const struct btf *src_btf, const struct btf_t
 		return libbpf_err(sz);
 
 	/* deconstruct BTF, if necessary, and invalidate raw_data */
-	if (btf_ensure_modifiable(btf))
+	if (btf_ensure_modifiable(p->dst))
 		return libbpf_err(-ENOMEM);
 
-	t = btf_add_type_mem(btf, sz);
+	t = btf_add_type_mem(p->dst, sz);
 	if (!t)
 		return libbpf_err(-ENOMEM);
 
 	memcpy(t, src_type, sz);
 
-	err = btf_type_visit_str_offs(t, btf_rewrite_str, &p);
+	err = btf_type_visit_str_offs(t, btf_rewrite_str, p);
 	if (err)
 		return libbpf_err(err);
 
-	return btf_commit_type(btf, sz);
+	return btf_commit_type(p->dst, sz);
+}
+
+int btf__add_type(struct btf *btf, const struct btf *src_btf, const struct btf_type *src_type)
+{
+	struct btf_pipe p = { .src = src_btf, .dst = btf };
+
+	return btf_add_type(&p, src_type);
 }
 
 static int btf_rewrite_type_ids(__u32 *type_id, void *ctx)
@@ -5217,3 +5223,200 @@ int btf_ext_visit_str_offs(struct btf_ext *btf_ext, str_off_visit_fn visit, void
 
 	return 0;
 }
+
+struct btf_ref {
+	struct btf_pipe pipe;
+	__u32 *ids;
+	unsigned int nr_base_types;
+	unsigned int diff_id;
+};
+
+static bool btf_is_eligible_named_fwd(const struct btf_type *t)
+{
+	return (btf_is_composite(t) || btf_is_any_enum(t)) && t->name_off != 0;
+}
+
+static int btf_add_ref_type_ids(__u32 *id, void *ctx)
+{
+	struct btf_ref *ref = ctx;
+	struct btf_type *t = btf_type_by_id(ref->pipe.src, *id);
+	int ret;
+
+	/* split BTF id, not needed */
+	if (*id > ref->nr_base_types)
+		return 0;
+	/* already added ? */
+	if (ref->ids[*id] <= BTF_MAX_NR_TYPES)
+		return 0;
+	ref->ids[*id] = *id;
+
+	/* struct/union members not needed, except for anonymous structs
+	 * and unions, which we need since name won't help us determine
+	 * matches; so if a named struct/union, no need to recurse
+	 * into members.
+	 */
+	if (btf_is_eligible_named_fwd(t))
+		return 0;
+
+	/* ensure references in type are added also. */
+	ret = btf_type_visit_type_ids(t, btf_add_ref_type_ids, ctx);
+	if (ret < 0)
+		return ret;
+	return 0;
+}
+
+/* All split BTF ids will be shifted downwards since there are less base BTF
+ * in reference base BTF, and for those that refer to base BTF, we use the
+ * reference map to map from original base BTF to reference base BTF id.
+ */
+static int btf_update_ref_type_ids(__u32 *id, void *ctx)
+{
+	struct btf_ref *ref = ctx;
+
+	if (*id >= ref->nr_base_types)
+		*id -= ref->diff_id;
+	else
+		*id = ref->ids[*id];
+	return 0;
+}
+
+/* Create updated split BTF with "reference" base BTF; reference base BTF
+ * consists of BTF information required to clarify the types that split
+ * BTF refers to, omitting unneeded details.  Specifically it will contain
+ * base types and forward declarations of structs, unions and enumerated
+ * types, along with associated reference types like pointers, arrays etc.
+ *
+ * The only case where structs, unions or enumerated types are fully represented
+ * is when they are anonymous; in such cases, info about type content is needed
+ * to clarify type references.
+ *
+ * We return newly-created split BTF where the split BTf refers to a newly-created
+ * base reference BTF. Both must be freed separately by the caller.
+ *
+ * When creating the BTF representation for a module and provided with the
+ * base_ref option, pahole will create split BTF using this API, and store
+ * the base reference BTF in the .BTF.base.reference section.
+ */
+struct btf *btf__new_split_base_ref(struct btf *src_btf)
+{
+	unsigned int n = btf__type_cnt(src_btf);
+	const struct btf_type *t;
+	struct btf_ref ref = {};
+	struct btf *base_btf = NULL, *split_btf = NULL;
+	__u32 i, id = 0;
+	int ret = 0;
+
+	/* src BTF must be split BTF. */
+	if (!btf__base_btf(src_btf)) {
+		errno = -EINVAL;
+		return NULL;
+	}
+	base_btf = btf__new_empty();
+	if (!base_btf)
+		return NULL;
+	ref.ids = calloc(n, sizeof(*ref.ids));
+	if (!ref.ids) {
+		ret = -ENOMEM;
+		goto err_out;
+	}
+	for (i = 1; i < n; i++)
+		ref.ids[i] = BTF_UNPROCESSED_ID;
+	ref.pipe.src = src_btf;
+	ref.pipe.dst = base_btf;
+	ref.pipe.str_off_map = hashmap__new(btf_dedup_identity_hash_fn, btf_dedup_equal_fn, NULL);
+	if (IS_ERR(ref.pipe.str_off_map)) {
+		ret = -ENOMEM;
+		goto err_out;
+	}
+	ref.nr_base_types = btf__type_cnt(btf__base_btf(src_btf));
+
+	/* Pass over src split BTF; generate the list of base BTF
+	 * type ids it references; these will constitute our base
+	 * reference BTF set.
+	 */
+	for (i = src_btf->start_id; i < n; i++) {
+		t = btf__type_by_id(src_btf, i);
+
+		ret = btf_type_visit_type_ids((struct btf_type *)t,  btf_add_ref_type_ids, &ref);
+		if (ret < 0)
+			goto err_out;
+	}
+	/* Next add types for each of the required references. */
+	for (i = 1; i < src_btf->start_id; i++) {
+		if (ref.ids[i] > BTF_MAX_NR_TYPES)
+			continue;
+		t = btf_type_by_id(src_btf, i);
+		/* for named struct/unions/enums, use a fwd since we can match
+		 * via name without details.
+		 */
+		if (btf_is_eligible_named_fwd(t)) {
+			enum btf_fwd_kind fwd_kind;
+
+			switch (btf_kind(t)) {
+			case BTF_KIND_STRUCT:
+				fwd_kind = BTF_FWD_STRUCT;
+				break;
+			case BTF_KIND_UNION:
+				fwd_kind = BTF_FWD_UNION;
+				break;
+			case BTF_KIND_ENUM:
+				fwd_kind = BTF_FWD_ENUM;
+				break;
+			case BTF_KIND_ENUM64:
+				fwd_kind = BTF_FWD_ENUM64;
+				break;
+			default:
+				pr_warn("unexpected kind [%u] when creating base reference BTF.\n",
+					btf_kind(t));
+				goto err_out;
+			}
+			ret = btf__add_fwd(base_btf, btf__name_by_offset(src_btf, t->name_off),
+					   fwd_kind);
+		} else {
+			ret = btf_add_type(&ref.pipe, t);
+		}
+		if (ret < 0)
+			goto err_out;
+		ref.ids[i] = ++id;
+	}
+	/* now create new split BTF with reference base BTF as its base; we end up with
+	 * split BTF that has base BTF that represents enough about its base references
+	 * to allow it to be reconciled with the base BTF available.
+	 */
+	split_btf = btf__new_empty_split(base_btf);
+	if (!split_btf)
+		goto err_out;
+
+	ref.pipe.dst = split_btf;
+	/* all split BTF ids will be shifted downwards since there are less base BTF ids
+	 * in reference base BTF.
+	 */
+	ref.diff_id = ref.nr_base_types - btf__type_cnt(base_btf);
+
+	/* First add all split types */
+	for (i = src_btf->start_id; i < n; i++) {
+		t = btf_type_by_id(src_btf, i);
+		ret = btf_add_type(&ref.pipe, t);
+		if (ret < 0)
+			goto err_out;
+	}
+	/* Now update base/split BTF ids. */
+	for (i = 1; i < btf__type_cnt(split_btf); i++) {
+		t = btf_type_by_id(split_btf, i);
+
+		ret = btf_type_visit_type_ids((struct btf_type *)t,  btf_update_ref_type_ids, &ref);
+		if (ret < 0)
+			goto err_out;
+	}
+	free(ref.ids);
+	hashmap__free(ref.pipe.str_off_map);
+	return split_btf;
+err_out:
+	free(ref.ids);
+	hashmap__free(ref.pipe.str_off_map);
+	btf__free(split_btf);
+	btf__free(base_btf);
+	if (ret < 0)
+		errno = -ret;
+	return NULL;
+}
diff --git a/tools/lib/bpf/btf.h b/tools/lib/bpf/btf.h
index 47d3e00b25c7..f2a853d6fa55 100644
--- a/tools/lib/bpf/btf.h
+++ b/tools/lib/bpf/btf.h
@@ -107,6 +107,21 @@ LIBBPF_API struct btf *btf__new_empty(void);
  */
 LIBBPF_API struct btf *btf__new_empty_split(struct btf *base_btf);
 
+/**
+ * @brief **btf__new_split_base_ref()** creates a new version of the
+ * split BTF *src_btf* passed in.  Its new base BTF will only contain
+ * the types needed to improve robustness of the split BTF to
+ * small changes in base BTF.  When that split BTF is loaded against
+ * a (possibly changed) base, this reference base BTF will help update
+ * references to that (possibly changed) base BTF.
+ *
+ * Both the new split and its reference base BTF it is built on top of
+ * must be freed by the caller.
+ *
+ * On error, NULL is returned and errno set.
+ */
+LIBBPF_API struct btf *btf__new_split_base_ref(struct btf *src_btf);
+
 LIBBPF_API struct btf *btf__parse(const char *path, struct btf_ext **btf_ext);
 LIBBPF_API struct btf *btf__parse_split(const char *path, struct btf *base_btf);
 LIBBPF_API struct btf *btf__parse_elf(const char *path, struct btf_ext **btf_ext);
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index 51732ecb1385..3d53b1781af1 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -414,5 +414,6 @@ LIBBPF_1.4.0 {
 		bpf_raw_tracepoint_open_opts;
 		bpf_token_create;
 		btf__new_split;
+		btf__new_split_base_ref;
 		btf_ext__raw_data;
 } LIBBPF_1.3.0;
-- 
2.39.3

