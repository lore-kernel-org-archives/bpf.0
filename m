Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D3A140A936
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 11:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790248505; cv=none; b=YkgzzJiapGWs8kvrvbsrnNN/czs3UQ0vK22sC4oj2STL1cIB+g/hKmEaYcb2ViyL7zOlSdniupyfdc6jCdLtKkPJhzEeKpn0hE79wAoOTLF+/+M6xPHA7ZH6CKEivLQM1w8nW114VUCha33pl2dcSZh0bECquz9WrDqa7WROv5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790248505; c=relaxed/simple;
	bh=zAS6C8N2vjtHv6JdnIpebBRkIL8Knq+cgeDCO7B0mBg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xg952qL8c5scG6oX+8sHNZdcsZLIKHZWhEw3VwhaQkIumQY8O66sioGYeG9Cr9oE3/infgOdPPkcc6q3Otw09wS8P0XQsJD62gxFyw/rBhgSiDxvjgNUcA3BI6EfrFayVExAfxx+JtaqnL3IyU2ZiEGslwWbYaTI982ofir4AGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=H2NlzG6v; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="H2NlzG6v"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68O6CVEh4017063;
	Thu, 24 Sep 2026 11:14:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=KpRNL
	KpOxA/HA5OV28lhEKOMbk2G5KnZBXW4g/cCcwI=; b=H2NlzG6vKrXTG/IGEAck8
	eJuTUbPmelUtoSaOtrSKFdnd7quWzALllveRtRT2ZaLC5GEHieXgATLR2/QCaG8H
	OnBKm1+IoVMIsdNgny2J4qtP7KC96W+qPLvbY7DlZ68DgSdKqeBo28ondY9wm42x
	ARii9rIMGrNqDd76NqBcHbVSjjHk7XM1nqx4yg681HwZfrHFTi9WcYq0+KYdiXcO
	DedGJpkXZjpJDbsJxI29HPWzUiDl4j3zaw4iFuS0yYKSKzGF/2kwFxwbE9rzGVkt
	zGkM3J5i3M/apf1KI480tg99Akmx0tExULA2HTWwZ1IAB36OJTsWvIyNdhoDV76s
	g==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4gsk0xqcb4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Sep 2026 11:14:40 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 68OB5WXb013030;
	Thu, 24 Sep 2026 11:14:40 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4guf119ku6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Sep 2026 11:14:39 +0000 (GMT)
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 68OBEVu9002821;
	Thu, 24 Sep 2026 11:14:39 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-80-22.vpn.oracle.com [10.154.80.22])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4guf119knh-3;
	Thu, 24 Sep 2026 11:14:39 +0000 (GMT)
From: Alan Maguire <alan.maguire@oracle.com>
To: ast@kernel.org, andrii@kernel.org, eddyz87@gmail.com, qmo@kernel.org
Cc: jolsa@kernel.org, daniel@iogearbox.net, ihor.solodrai@linux.dev,
        yonghong.song@linux.dev, song@kernel.org, martin.lau@linux.dev,
        memxor@gmail.com, emil@etsalapatis.com, bpf@vger.kernel.org,
        nsc@kernel.org, puranjay@kernel.org, yatsenko@meta.com,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v4 bpf-next 02/11] libbpf: Add support for BTF kinds LOC[_PARAM|_PROTO|SEC]
Date: Thu, 24 Sep 2026 12:14:19 +0100
Message-ID: <20260924111428.75957-3-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20260924111428.75957-1-alan.maguire@oracle.com>
References: <20260924111428.75957-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-24_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 spamscore=0 bulkscore=0 lowpriorityscore=0 malwarescore=0 suspectscore=0
 mlxscore=0 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2609040000 definitions=main-2609240046
X-Authority-Analysis: v=2.4 cv=F/bC5ahN c=1 sm=1 tr=0 ts=6ab50620 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=3I1J8UUJPc9JN9BFgKH3:22 a=yPCof4ZbAAAA:8 a=pGLkceISAAAA:8
 a=iu01JTvWpwfp2QHLodMA:9 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22
 cc=ntf awl=host:12106
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDA0NiBTYWx0ZWRfX7AEYit6+YpsD
 XZy5Sw5hygi2OQdWh3W1xr4mDqtGnyRn/Dx3Nt6GaTuEiG78eiWtmMz1YZOXpz+RRSyrgAEphn5
 ifKwO25myAwzPBcT3Fol5WsEBk+vvynsMvj4xZrVb6RlQD7nEIt/
X-Proofpoint-ORIG-GUID: OyGGBTUwwQNP8lOtlP1dW86zaax-Fegf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDA0NiBTYWx0ZWRfX6IuNMOKhifRb
 fvSEagpRCc83jQ38Q2UAjJhKRlxacgmH6AB97e8VRmt8W5pg470hgWyNgsOOqkQMMWXjhB5gtpo
 JPbxY4FAPKU8T133s9ZCEPvdYf2eb6jw3XsZySyH+AYKg5UaRdCNqF7acNSo3EjKOEGFc8OMHcc
 FyvwwOeSTRGYiXKgtXA8ppu6O/efA1cG3JVzj4RWyNbyzMyovqYM7xqsZYndnuDz0kLDN3Dkl3m
 NzqKvMA08cw/4J4eLULA5NZm50idsvHRSwEtVRMk4GtqMLPzjPI0+4WUXBUdBoR1qlKHCqwnqAq
 IXN78fTnKls/qFKqewL9pNaiokexyScXgubGHWODtj5kGcMJNysN6EcO1Plaw8bAbFCBK5KKOin
 z05lMEAMAb5w7Cz5U/tWhZwHG2xoHoH8VqkRsvgMQvf2B/CcS/hjJNYdO/MYJHatpQNkqVLMlNY
 OsBuFIR0RVrwFshKtZMlvF6te8j9soeZG6WrFI0k=
X-Proofpoint-GUID: OyGGBTUwwQNP8lOtlP1dW86zaax-Fegf

Add support for new kinds to libbpf.  BTF_KIND_LOC_PARAM and
BTF_KIND_LOC_PROTO are dedup-able so add support for their
deduplication, whereas since BTF_KIND_LOCSEC contains a unique
offset it is not.  LOC_PARAM is considered a primary type
since it contains no external references; LOC_PROTO is a
reference type consisting of LOC_PARAM references so they
are handled in the primary and reference dedup phases
respectively.

For BTF field iteration, BTF_KIND_LOCSEC needs 2 m_offs[] values
for the associated KIND_FUNC and KIND_LOC_PROTO type ids in
each LOCSEC entry.

Add APIs to add location param, location prototypes and location
sections and btf_is_* tests, data accessors for each.

For BTF distillation we add location info to split BTF.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
---
 tools/lib/bpf/btf.c             | 408 +++++++++++++++++++++++++++++++-
 tools/lib/bpf/btf.h             |  50 ++++
 tools/lib/bpf/btf_dump.c        |   9 +
 tools/lib/bpf/btf_iter.c        |  18 ++
 tools/lib/bpf/libbpf.c          |   3 +
 tools/lib/bpf/libbpf.map        |   6 +
 tools/lib/bpf/libbpf_internal.h |   2 +-
 7 files changed, 491 insertions(+), 5 deletions(-)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index 908bd344229d..512b3962f75f 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -57,6 +57,9 @@ static struct btf_layout layouts[NR_BTF_KINDS] = {
 [BTF_KIND_DECL_TAG] =	{	sizeof(struct btf_decl_tag),	0,				0 },
 [BTF_KIND_TYPE_TAG] =	{	0,				0,				0 },
 [BTF_KIND_ENUM64] =	{	0,				sizeof(struct btf_enum64),	0 },
+[BTF_KIND_LOC_PARAM] =	{	sizeof(struct btf_loc_param),	sizeof(__u32),			0 },
+[BTF_KIND_LOC_PROTO] =	{	0,				sizeof(__u32),			0 },
+[BTF_KIND_LOCSEC] =	{	0,				sizeof(struct btf_loc),		0 },
 };
 
 struct btf {
@@ -486,6 +489,12 @@ static int btf_type_size(const struct btf *btf, const struct btf_type *t)
 		return base_size + vlen * sizeof(struct btf_var_secinfo);
 	case BTF_KIND_DECL_TAG:
 		return base_size + sizeof(struct btf_decl_tag);
+	case BTF_KIND_LOC_PARAM:
+		return base_size + sizeof(struct btf_loc_param) + vlen * sizeof(__u32);
+	case BTF_KIND_LOC_PROTO:
+		return base_size + vlen * sizeof(__u32);
+	case BTF_KIND_LOCSEC:
+		return base_size + vlen * sizeof(struct btf_loc);
 	default:
 		return btf_type_size_unknown(btf, t);
 	}
@@ -501,12 +510,15 @@ static void btf_bswap_type_base(struct btf_type *t)
 static int btf_bswap_type_rest(struct btf_type *t)
 {
 	struct btf_var_secinfo *v;
+	struct btf_loc_param *lp;
 	struct btf_enum64 *e64;
 	struct btf_member *m;
 	struct btf_array *a;
 	struct btf_param *p;
 	struct btf_enum *e;
+	struct btf_loc *l;
 	__u32 vlen = btf_vlen(t);
+	__u32 *d;
 	int i;
 
 	switch (btf_kind(t)) {
@@ -569,6 +581,23 @@ static int btf_bswap_type_rest(struct btf_type *t)
 	case BTF_KIND_DECL_TAG:
 		btf_decl_tag(t)->component_idx = bswap_32(btf_decl_tag(t)->component_idx);
 		return 0;
+	case BTF_KIND_LOC_PARAM:
+		lp = btf_loc_param(t);
+		lp->flags = bswap_32(lp->flags);
+		for (i = 0, d = (__u32 *)(lp + 1); i < vlen; i++, d++)
+			*d = bswap_32(*d);
+		return 0;
+	case BTF_KIND_LOC_PROTO:
+		for (i = 0, d = btf_loc_proto_params(t); i < vlen; i++, d++)
+			*d = bswap_32(*d);
+		return 0;
+	case BTF_KIND_LOCSEC:
+		for (i = 0, l = btf_locsec_locs(t); i < vlen; i++, l++) {
+			l->func = bswap_32(l->func);
+			l->loc_proto = bswap_32(l->loc_proto);
+			l->offset = bswap_32(l->offset);
+		}
+		return 0;
 	default:
 		pr_debug("Unsupported BTF_KIND:%u\n", btf_kind(t));
 		return -EINVAL;
@@ -745,6 +774,33 @@ static int btf_validate_type(const struct btf *btf, const struct btf_type *t, __
 		}
 		break;
 	}
+	case BTF_KIND_LOC_PARAM:
+		break;
+	case BTF_KIND_LOC_PROTO: {
+		__u32 *p = btf_loc_proto_params(t);
+
+		n = btf_vlen(t);
+		for (i = 0; i < n; i++, p++) {
+			err = btf_validate_id(btf, *p, id);
+			if (err)
+				return err;
+		}
+		break;
+	}
+	case BTF_KIND_LOCSEC: {
+		const struct btf_loc *l = btf_locsec_locs(t);
+
+		n = btf_vlen(t);
+		for (i = 0; i < n; i++, l++) {
+			if (!err)
+				err = btf_validate_id(btf, l->func, id);
+			if (!err)
+				err = btf_validate_id(btf, l->loc_proto, id);
+			if (err)
+				return err;
+		}
+		break;
+	}
 	default:
 		/* Kind may be represented in kind layout information. */
 		if (btf_type_size_unknown(btf, t) < 0) {
@@ -3344,6 +3400,243 @@ int btf__add_decl_attr(struct btf *btf, const char *value, int ref_type_id,
 	return btf_add_decl_tag(btf, value, ref_type_id, component_idx, 1);
 }
 
+/*
+ * Append new BTF_KIND_LOC_PARAM with specified size and flags.  Values are
+ * added via btf__add_loc_param_value().
+ *
+ * - *byte_sz* - size of the type, in bytes (1 through 16);
+ * - *flags* - combination of enum btf_loc_param_flags values
+ *
+ * Returns:
+ *   -  >0, type ID of newly added BTF type;
+ *   - <0, on error.
+ */
+int btf__add_loc_param(struct btf *btf, __u32 byte_sz, __u32 flags)
+{
+	struct btf_loc_param *p;
+	struct btf_type *t;
+	int sz, err;
+
+	if (!byte_sz || byte_sz > 16)
+		return libbpf_err(-EINVAL);
+
+	err = btf_ensure_modifiable(btf);
+	if (err)
+		return libbpf_err(err);
+
+	sz = sizeof(struct btf_type) + sizeof(*p);
+	t = btf_add_type_mem(btf, sz);
+	if (!t)
+		return libbpf_err(-ENOMEM);
+
+	t->name_off = 0;
+	t->info = btf_type_info(BTF_KIND_LOC_PARAM, 0, 0);
+	t->size = byte_sz;
+
+	p = btf_loc_param(t);
+	p->flags = flags;
+
+	return btf_commit_type(btf, sz);
+}
+
+/*
+ * Append *value* to existing BTF_KIND_LOC_PARAM.
+ *
+ * Returns:
+ *   - 0 on success
+ *   - <0, on error.
+ */
+int btf__add_loc_param_value(struct btf *btf, __u32 value)
+{
+	struct btf_type *t;
+	int sz, err;
+	__u32 *v;
+
+	/* last type should be BTF_KIND_LOC_PARAM */
+	if (btf->nr_types == 0)
+		return libbpf_err(-EINVAL);
+	t = btf_last_type(btf);
+	if (!btf_is_loc_param(t))
+		return libbpf_err(-EINVAL);
+
+	/* decompose and invalidate raw data */
+	err = btf_ensure_modifiable(btf);
+	if (err)
+		return libbpf_err(err);
+
+	sz = sizeof(value);
+	v = btf_add_type_mem(btf, sz);
+	if (!v)
+		return libbpf_err(-ENOMEM);
+	*v = value;
+
+	/* update parent type's vlen */
+	t = btf_last_type(btf);
+	err = btf_type_inc_vlen(t);
+	if (err)
+		return libbpf_err(err);
+
+	btf_hdr_update_type_len(btf, btf->hdr.type_len + sz);
+	return 0;
+}
+
+/*
+ * Append new BTF_KIND_LOC_PROTO
+ *
+ * The prototype is then populated with 0 or more BTF_KIND_LOC_PARAMs via
+ * btf__add_loc_proto_param(); similar to how btf__add_func_param() adds
+ * parameters to a FUNC_PROTO.
+ *
+ * Returns:
+ *   -  >0, type ID of newly added BTF type;
+ *   - <0, on error.
+ */
+int btf__add_loc_proto(struct btf *btf)
+{
+	struct btf_type *t;
+	int err;
+
+	err = btf_ensure_modifiable(btf);
+	if (err)
+		return libbpf_err(err);
+
+	t = btf_add_type_mem(btf, sizeof(struct btf_type));
+	if (!t)
+		return libbpf_err(-ENOMEM);
+
+	t->name_off = 0;
+	t->info = btf_type_info(BTF_KIND_LOC_PROTO, 0, 0);
+	t->size = 0;
+
+	return btf_commit_type(btf, sizeof(struct btf_type));
+}
+
+/*
+ * Append a BTF_KIND_LOC_PARAM id/0 to BTF_KIND_LOC_PROTO.
+ *
+ * Returns:
+ *   - 0 on success;
+ *   - <0, on error.
+
+ */
+int btf__add_loc_proto_param(struct btf *btf, __u32 id)
+{
+	struct btf_type *t;
+	int sz, err;
+	__u32 *p;
+
+	if (validate_type_id(id))
+		return libbpf_err(-EINVAL);
+
+	/* last type should be BTF_KIND_LOC_PROTO */
+	if (btf->nr_types == 0)
+		return libbpf_err(-EINVAL);
+	t = btf_last_type(btf);
+	if (!btf_is_loc_proto(t))
+		return libbpf_err(-EINVAL);
+
+	/* decompose and invalidate raw data */
+	err = btf_ensure_modifiable(btf);
+	if (err)
+		return libbpf_err(err);
+
+	sz = sizeof(__u32);
+	p = btf_add_type_mem(btf, sz);
+	if (!p)
+		return libbpf_err(-ENOMEM);
+	*p = id;
+
+	/* update parent type's vlen */
+	t = btf_last_type(btf);
+	err = btf_type_inc_vlen(t);
+	if (err)
+		return libbpf_err(err);
+
+	btf_hdr_update_type_len(btf, btf->hdr.type_len + sz);
+	return 0;
+}
+
+/*
+ * Append new BTF_KIND_LOCSEC type with:
+ *   - *name* - non-empty/non-NULL name;
+ *
+ * Location section is initially empty. Location info can be added with
+ * btf__add_locsec_loc() calls, after btf__add_locsec() succeeds.
+ *
+ * Returns:
+ *   - >0, type ID of newly added BTF type;
+ *   - <0, on error.
+ */
+
+int btf__add_locsec(struct btf *btf, const char *name)
+{
+	struct btf_type *t;
+	int name_off = 0;
+	int err;
+
+	/* non-empty name */
+	if (str_is_empty(name))
+		return libbpf_err(-EINVAL);
+
+	err = btf_ensure_modifiable(btf);
+	if (err)
+		return libbpf_err(err);
+
+	t = btf_add_type_mem(btf, sizeof(struct btf_type));
+	if (!t)
+		return libbpf_err(-ENOMEM);
+
+	name_off = btf__add_str(btf, name);
+	if (name_off < 0)
+		return libbpf_err(name_off);
+	t->name_off = name_off;
+	t->info = btf_type_info(BTF_KIND_LOCSEC, 0, 0);
+	t->size = 0;
+
+	return btf_commit_type(btf, sizeof(struct btf_type));
+}
+
+int btf__add_locsec_loc(struct btf *btf, __u32 func, __u32 loc_proto,
+			__u32 offset)
+{
+	struct btf_type *t;
+	struct btf_loc *l;
+	int sz, err;
+
+	if (validate_type_id(func) || validate_type_id(loc_proto))
+		return libbpf_err(-EINVAL);
+
+	/* last type should be BTF_KIND_LOCSEC */
+	if (btf->nr_types == 0)
+		return libbpf_err(-EINVAL);
+	t = btf_last_type(btf);
+	if (!btf_is_locsec(t))
+		return libbpf_err(-EINVAL);
+
+	/* decompose and invalidate raw data */
+	err = btf_ensure_modifiable(btf);
+	if (err)
+		return libbpf_err(err);
+
+	sz = sizeof(*l);
+	l = btf_add_type_mem(btf, sz);
+	if (!l)
+		return libbpf_err(-ENOMEM);
+
+	l->func = func;
+	l->loc_proto = loc_proto;
+	l->offset = offset;
+
+	/* update parent type's vlen */
+	t = btf_last_type(btf);
+	err = btf_type_inc_vlen(t);
+	if (err)
+		return libbpf_err(err);
+
+	btf_hdr_update_type_len(btf, btf->hdr.type_len + sz);
+	return 0;
+}
+
 struct btf_ext_sec_info_param {
 	__u32 off;
 	__u32 len;
@@ -4114,8 +4407,8 @@ static struct btf_dedup *btf_dedup_new(struct btf *btf, const struct btf_dedup_o
 	for (i = 1; i < type_cnt; i++) {
 		struct btf_type *t = btf_type_by_id(d->btf, i);
 
-		/* VAR and DATASEC are never deduped and are self-canonical */
-		if (btf_is_var(t) || btf_is_datasec(t))
+		/* VAR, DATASEC and LOCSEC are never deduped and are self-canonical */
+		if (btf_is_var(t) || btf_is_datasec(t) || btf_is_locsec(t))
 			d->map[i] = i;
 		else
 			d->map[i] = BTF_UNPROCESSED_ID;
@@ -4395,6 +4688,47 @@ static bool btf_compat_enum(struct btf_type *t1, struct btf_type *t2)
 	       btf_is_any_enum(t1) && btf_is_any_enum(t2);
 }
 
+static long btf_hash_loc_param(struct btf_type *t)
+{
+	struct btf_loc_param *p = btf_loc_param(t);
+	long h = btf_hash_common(t);
+	int i, vlen = btf_vlen(t);
+
+	h = hash_combine(h, p->flags);
+
+	for (i = 0; i < vlen; i++)
+		h = hash_combine(h, p->values[i]);
+	return h;
+}
+
+static long btf_hash_loc_proto(struct btf_type *t)
+{
+	__u32 *p = btf_loc_proto_params(t);
+	long h = btf_hash_common(t);
+	int i, vlen = btf_vlen(t);
+
+	for (i = 0; i < vlen; i++, p++)
+		h = hash_combine(h, *p);
+	return h;
+}
+
+static bool btf_equal_loc_param(struct btf_type *t1, struct btf_type *t2)
+{
+	struct btf_loc_param *p1 = btf_loc_param(t1);
+	struct btf_loc_param *p2 = btf_loc_param(t2);
+	int i, vlen = btf_vlen(t1);
+
+	if (!btf_equal_common(t1, t2))
+		return false;
+	if (p1->flags != p2->flags)
+		return false;
+	for (i = 0; i < vlen; i++) {
+		if (p1->values[i] != p2->values[i])
+			return false;
+	}
+	return true;
+}
+
 /*
  * Calculate type signature hash of STRUCT/UNION, ignoring referenced type IDs,
  * as referenced type IDs equivalence is established separately during type
@@ -4589,7 +4923,8 @@ static int btf_dedup_prep(struct btf_dedup *d)
 		switch (btf_kind(t)) {
 		case BTF_KIND_VAR:
 		case BTF_KIND_DATASEC:
-			/* VAR and DATASEC are never hash/deduplicated */
+		case BTF_KIND_LOCSEC:
+			/* VAR DATASEC and LOCSEC are never hash/deduplicated */
 			continue;
 		case BTF_KIND_CONST:
 		case BTF_KIND_VOLATILE:
@@ -4622,6 +4957,12 @@ static int btf_dedup_prep(struct btf_dedup *d)
 		case BTF_KIND_FUNC_PROTO:
 			h = btf_hash_fnproto(t);
 			break;
+		case BTF_KIND_LOC_PARAM:
+			h = btf_hash_loc_param(t);
+			break;
+		case BTF_KIND_LOC_PROTO:
+			h = btf_hash_loc_proto(t);
+			break;
 		default:
 			pr_debug("unknown kind %d for type [%d]\n", btf_kind(t), type_id);
 			return -EINVAL;
@@ -4664,6 +5005,8 @@ static int btf_dedup_prim_type(struct btf_dedup *d, __u32 type_id)
 	case BTF_KIND_DATASEC:
 	case BTF_KIND_DECL_TAG:
 	case BTF_KIND_TYPE_TAG:
+	case BTF_KIND_LOC_PROTO:
+	case BTF_KIND_LOCSEC:
 		return 0;
 
 	case BTF_KIND_INT:
@@ -4713,6 +5056,18 @@ static int btf_dedup_prim_type(struct btf_dedup *d, __u32 type_id)
 		}
 		break;
 
+	case BTF_KIND_LOC_PARAM:
+		h = btf_hash_loc_param(t);
+		for_each_dedup_cand(d, hash_entry, h) {
+			cand_id = hash_entry->value;
+			cand = btf_type_by_id(d->btf, cand_id);
+			if (btf_equal_loc_param(t, cand)) {
+				new_id = cand_id;
+				break;
+			}
+		}
+		break;
+
 	default:
 		return -EINVAL;
 	}
@@ -5145,6 +5500,13 @@ static int btf_dedup_is_equiv(struct btf_dedup *d, __u32 cand_id,
 		return 1;
 	}
 
+	case BTF_KIND_LOC_PARAM:
+		return btf_equal_loc_param(cand_type, canon_type);
+
+	case BTF_KIND_LOC_PROTO:
+	case BTF_KIND_LOCSEC:
+		return 0;
+
 	default:
 		return -EINVAL;
 	}
@@ -5489,6 +5851,37 @@ static int btf_dedup_ref_type(struct btf_dedup *d, __u32 type_id)
 		break;
 	}
 
+	case BTF_KIND_LOC_PROTO: {
+		__u32 *p1, *p2;
+		__u32 i, vlen;
+
+		p1 = btf_loc_proto_params(t);
+		vlen = btf_vlen(t);
+
+		for (i = 0; i < vlen; i++, p1++) {
+			ref_type_id = btf_dedup_ref_type(d, *p1);
+			if (ref_type_id < 0)
+				return ref_type_id;
+			*p1 = ref_type_id;
+		}
+
+		h = btf_hash_loc_proto(t);
+		for_each_dedup_cand(d, hash_entry, h) {
+			cand_id = hash_entry->value;
+			cand = btf_type_by_id(d->btf, cand_id);
+			if (!btf_equal_common(t, cand))
+				continue;
+			vlen = btf_vlen(cand);
+			p1 = btf_loc_proto_params(t);
+			p2 = btf_loc_proto_params(cand);
+			if (memcmp(p1, p2, vlen * sizeof(__u32)) == 0) {
+				new_id = cand_id;
+				break;
+			}
+		}
+		break;
+	}
+
 	default:
 		return -EINVAL;
 	}
@@ -5970,8 +6363,11 @@ static int btf_add_distilled_type_ids(struct btf_distill *dist, __u32 i)
 		case BTF_KIND_CONST:
 		case BTF_KIND_RESTRICT:
 		case BTF_KIND_VOLATILE:
+		case BTF_KIND_FUNC:
 		case BTF_KIND_FUNC_PROTO:
 		case BTF_KIND_TYPE_TAG:
+		case BTF_KIND_LOC_PARAM:
+		case BTF_KIND_LOC_PROTO:
 			dist->id_map[*id] = *id;
 			break;
 		default:
@@ -5997,7 +6393,7 @@ static int btf_add_distilled_type_ids(struct btf_distill *dist, __u32 i)
 
 static int btf_add_distilled_types(struct btf_distill *dist)
 {
-	bool adding_to_base = dist->pipe.dst->start_id == 1;
+	bool adding_to_base = dist->pipe.dst->base_btf == NULL;
 	int id = btf__type_cnt(dist->pipe.dst);
 	struct btf_type *t;
 	int i, err = 0;
@@ -6065,8 +6461,12 @@ static int btf_add_distilled_types(struct btf_distill *dist)
 		case BTF_KIND_CONST:
 		case BTF_KIND_RESTRICT:
 		case BTF_KIND_VOLATILE:
+		case BTF_KIND_FUNC:
 		case BTF_KIND_FUNC_PROTO:
 		case BTF_KIND_TYPE_TAG:
+		case BTF_KIND_LOC_PARAM:
+		case BTF_KIND_LOC_PROTO:
+		case BTF_KIND_LOCSEC:
 			/* All other types are added to split BTF. */
 			if (adding_to_base)
 				continue;
diff --git a/tools/lib/bpf/btf.h b/tools/lib/bpf/btf.h
index 587172c0de08..57f12630c5d1 100644
--- a/tools/lib/bpf/btf.h
+++ b/tools/lib/bpf/btf.h
@@ -274,6 +274,20 @@ LIBBPF_API int btf__add_decl_tag(struct btf *btf, const char *value, int ref_typ
 LIBBPF_API int btf__add_decl_attr(struct btf *btf, const char *value, int ref_type_id,
 				  int component_idx);
 
+/* location construction APIs */
+LIBBPF_API int btf__add_loc_param(struct btf *btf, __u32 size, __u32 flags);
+
+LIBBPF_API int btf__add_loc_param_value(struct btf *btf, __u32 value);
+
+LIBBPF_API int btf__add_loc_proto(struct btf *btf);
+
+LIBBPF_API int btf__add_loc_proto_param(struct btf *btf, __u32 id);
+
+LIBBPF_API int btf__add_locsec(struct btf *btf, const char *name);
+
+LIBBPF_API int btf__add_locsec_loc(struct btf *btf, __u32 func, __u32 loc_proto,
+				   __u32 offset);
+
 struct btf_dedup_opts {
 	size_t sz;
 	/* optional .BTF.ext info to dedup along the main BTF info */
@@ -431,6 +445,12 @@ btf_dump__dump_type_data(struct btf_dump *d, __u32 id,
 #define BTF_KIND_DECL_TAG	17	/* Decl Tag */
 #define BTF_KIND_TYPE_TAG	18	/* Type Tag */
 #define BTF_KIND_ENUM64		19	/* Enum for up-to 64bit values */
+#define BTF_KIND_LOC_PARAM	20	/* Parameter at location */
+#define BTF_KIND_LOC_PROTO	21	/* Parameter set at location */
+#define BTF_KIND_LOCSEC		22	/* Section containing location info */
+
+struct btf_loc_param;
+struct btf_loc;
 
 static inline __u16 btf_kind(const struct btf_type *t)
 {
@@ -569,6 +589,21 @@ static inline bool btf_is_any_enum(const struct btf_type *t)
 	return btf_is_enum(t) || btf_is_enum64(t);
 }
 
+static inline bool btf_is_loc_param(const struct btf_type *t)
+{
+	return btf_kind(t) == BTF_KIND_LOC_PARAM;
+}
+
+static inline bool btf_is_loc_proto(const struct btf_type *t)
+{
+	return btf_kind(t) == BTF_KIND_LOC_PROTO;
+}
+
+static inline bool btf_is_locsec(const struct btf_type *t)
+{
+	return btf_kind(t) == BTF_KIND_LOCSEC;
+}
+
 static inline bool btf_kind_core_compat(const struct btf_type *t1,
 					const struct btf_type *t2)
 {
@@ -683,6 +718,21 @@ static inline struct btf_decl_tag *btf_decl_tag(const struct btf_type *t)
 	return (struct btf_decl_tag *)(t + 1);
 }
 
+static inline struct btf_loc_param *btf_loc_param(const struct btf_type *t)
+{
+	return (struct btf_loc_param *)(t + 1);
+}
+
+static inline __u32 *btf_loc_proto_params(const struct btf_type *t)
+{
+	return (__u32 *)(t + 1);
+}
+
+static inline struct btf_loc *btf_locsec_locs(const struct btf_type *t)
+{
+	return (struct btf_loc *)(t + 1);
+}
+
 #ifdef __cplusplus
 } /* extern "C" */
 #endif
diff --git a/tools/lib/bpf/btf_dump.c b/tools/lib/bpf/btf_dump.c
index 123c448f20c7..fa995c02a170 100644
--- a/tools/lib/bpf/btf_dump.c
+++ b/tools/lib/bpf/btf_dump.c
@@ -328,6 +328,9 @@ static int btf_dump_mark_referenced(struct btf_dump *d)
 		case BTF_KIND_ENUM64:
 		case BTF_KIND_FWD:
 		case BTF_KIND_FLOAT:
+		case BTF_KIND_LOC_PARAM:
+		case BTF_KIND_LOC_PROTO:
+		case BTF_KIND_LOCSEC:
 			break;
 
 		case BTF_KIND_VOLATILE:
@@ -609,6 +612,9 @@ static int btf_dump_order_type(struct btf_dump *d, __u32 id, bool through_ptr)
 	case BTF_KIND_VAR:
 	case BTF_KIND_DATASEC:
 	case BTF_KIND_DECL_TAG:
+	case BTF_KIND_LOC_PARAM:
+	case BTF_KIND_LOC_PROTO:
+	case BTF_KIND_LOCSEC:
 		d->type_states[id].order_state = ORDERED;
 		return 0;
 
@@ -2525,6 +2531,9 @@ static int btf_dump_dump_type_data(struct btf_dump *d,
 	case BTF_KIND_FUNC:
 	case BTF_KIND_FUNC_PROTO:
 	case BTF_KIND_DECL_TAG:
+	case BTF_KIND_LOC_PARAM:
+	case BTF_KIND_LOC_PROTO:
+	case BTF_KIND_LOCSEC:
 		err = btf_dump_unsupported_data(d, t, id);
 		break;
 	case BTF_KIND_INT:
diff --git a/tools/lib/bpf/btf_iter.c b/tools/lib/bpf/btf_iter.c
index 9a6c822c2294..199063b55ebe 100644
--- a/tools/lib/bpf/btf_iter.c
+++ b/tools/lib/bpf/btf_iter.c
@@ -29,6 +29,7 @@ int btf_field_iter_init(struct btf_field_iter *it, struct btf_type *t,
 		case BTF_KIND_FLOAT:
 		case BTF_KIND_ENUM:
 		case BTF_KIND_ENUM64:
+		case BTF_KIND_LOC_PARAM:
 			it->desc = (struct btf_field_desc) {};
 			break;
 		case BTF_KIND_FWD:
@@ -71,6 +72,20 @@ int btf_field_iter_init(struct btf_field_iter *it, struct btf_type *t,
 				1, {offsetof(struct btf_var_secinfo, type)}
 			};
 			break;
+		case BTF_KIND_LOC_PROTO:
+			it->desc = (struct btf_field_desc) {
+				0, {},
+				sizeof(__u32),
+				1, {0}};
+			break;
+		case BTF_KIND_LOCSEC:
+			it->desc = (struct btf_field_desc) {
+				0, {},
+				sizeof(struct btf_loc),
+				2, {offsetof(struct btf_loc, func),
+				    offsetof(struct btf_loc, loc_proto)}};
+			break;
+
 		default:
 			return -EINVAL;
 		}
@@ -94,6 +109,9 @@ int btf_field_iter_init(struct btf_field_iter *it, struct btf_type *t,
 		case BTF_KIND_DECL_TAG:
 		case BTF_KIND_TYPE_TAG:
 		case BTF_KIND_DATASEC:
+		case BTF_KIND_LOC_PARAM:
+		case BTF_KIND_LOC_PROTO:
+		case BTF_KIND_LOCSEC:
 			it->desc = (struct btf_field_desc) {
 				1, {offsetof(struct btf_type, name_off)}
 			};
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 2f53afc985cf..930588950ab3 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -2483,6 +2483,9 @@ static const char *__btf_kind_str(__u16 kind)
 	case BTF_KIND_DECL_TAG: return "decl_tag";
 	case BTF_KIND_TYPE_TAG: return "type_tag";
 	case BTF_KIND_ENUM64: return "enum64";
+	case BTF_KIND_LOC_PARAM: return "loc_param";
+	case BTF_KIND_LOC_PROTO: return "loc_proto";
+	case BTF_KIND_LOCSEC: return "locsec";
 	default: return "unknown";
 	}
 }
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index 7a84dd00ce95..18d27d20102e 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -463,6 +463,12 @@ LIBBPF_1.8.0 {
 		bpf_program__attach_tracing_multi;
 		bpf_program__clear_flags;
 		bpf_program__clone;
+		btf__add_loc_param;
+		btf__add_loc_param_value;
+		btf__add_loc_proto;
+		btf__add_loc_proto_param;
+		btf__add_locsec;
+		btf__add_locsec_loc;
 		btf__find_by_name_kind_own;
 		btf__new_empty_opts;
 } LIBBPF_1.7.0;
diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_internal.h
index cb4d96233844..546f65b95cf4 100644
--- a/tools/lib/bpf/libbpf_internal.h
+++ b/tools/lib/bpf/libbpf_internal.h
@@ -580,7 +580,7 @@ struct btf_field_desc {
 	/* member struct size, or zero, if no members */
 	int m_sz;
 	/* repeated per-member offsets */
-	int m_off_cnt, m_offs[1];
+	int m_off_cnt, m_offs[2];
 };
 
 struct btf_field_iter {
-- 
2.43.5

