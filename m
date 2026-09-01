Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3F98483BD7;
	Tue,  1 Sep 2026 16:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788281921; cv=none; b=sYI3V2yhGkoZuDygCdzJRC2Dp1AtlzOgbef9ntvJ2FkWxUfwViEC51d6+Q2Jjc8BtKX7WfWpHxubceySuSoeNj00DDvOE/U9/RfHeMS1zp7J7sMmkWwaPcPKxO1trZeKe4Kb1Xktn1iCMb1YsAzIcQIc9hjIbBAbhVA2wDDYqKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788281921; c=relaxed/simple;
	bh=EPd6AzRqOdLc9BAdssR1HCwYo4u0e+wJl6nCxEVNzVo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wl7smJ7971zJXVMG43lExdxbPKNkodSe8P/+J6ydsesL4/Xc2oTUd2ZXiNVOVjujnBBdJUc00Znn6SGvehBWahJg+Ep+BUXmPaYcxFTur65iZoUt5q6RWs21T4aVr7eNLQVdoEYLJhL3ldItrgiJmuIwtZx8J5M71buYoxfUk+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=osfHrhiK; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="osfHrhiK"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 681ERRjM396205;
	Tue, 1 Sep 2026 16:58:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=RIu6s
	GvTI6b6Lxf71zEWryW10C7+hJROQZhoEHvdSG8=; b=osfHrhiKhC0zC8fRkww8N
	7wN3N/lX88axoskzsviCLoi5W/SVRmjyRyW9vDe1fzqWTjT2lsB3O+ZkqDZoBdt2
	WOfWfUd0zChZcZFugMNZBKTdzxHiTkco/itktvsq/1wxXJw2v+IHTwg74+pt8UxO
	alyXiuctAZLANyCcUKg5BfN9Spc7o7j/lvc7aABkUuP2moMKWUfpRyg+IUrOzs3o
	Y5nhKrcMfPrz1oAF585uzYusndbtjDZcdMvQFAhhTWhcBKhwx8mlzDYz6UpjowMa
	yRALxMoU6q9ApfGRQiF81U/Kp3YgelzdV9wRoDj1Ako0fkPoLy7iRTkR1t7yDgYc
	g==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4gbpbaw6nv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 01 Sep 2026 16:58:10 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 681GjSFW001835;
	Tue, 1 Sep 2026 16:58:09 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4gdymtg8mc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 01 Sep 2026 16:58:09 +0000 (GMT)
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 681Gw1Vt011129;
	Tue, 1 Sep 2026 16:58:08 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-52-250.vpn.oracle.com [10.154.52.250])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4gdymtg8f6-3;
	Tue, 01 Sep 2026 16:58:08 +0000 (GMT)
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
Subject: [PATCH v2 bpf-next 02/18] libbpf: Add support for BTF kinds LOC[_PARAM|_PROTO|SEC]
Date: Tue,  1 Sep 2026 17:57:41 +0100
Message-ID: <20260901165757.801449-3-alan.maguire@oracle.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAxMDE1MCBTYWx0ZWRfX6X02ycsTOF2I
 Urtvav6O+UdhOc2cosGph5kAOmJgvoAZuynyt7X+FfPZmnyERAiVkMqkO1I0f4tQlNYfTIDA/N7
 Vz9K9vcVgAy2saRmoKScutJDdisEE7RitnSayCBgERqzbMquuLT4
X-Proofpoint-ORIG-GUID: Z4N1ZvxCXURG0GsywLuZB7iesNyBIp9A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAxMDE1MCBTYWx0ZWRfXxGwrko57rJ1P
 A8xIhdBWblKvYwmAAeNmxKYXk3JmwPmBBj61SYa/82uq2oc6gb5DhgvR3R1LHtxR2UySDKCKrXk
 kfiiyFGMtohHLVYa/qC0J0jmk977cnI6N0fAAz5yFKXispSD+DdJJ0UHJwAapGn1JPQlC0Rfir2
 Yl7E8ZodjwT8yufKQq200iPM/821IvvHlzp/qkRwwkpGI/3z8K7orFMov/3ITK4NteB8DfKvhP9
 4rONWolWTjTzdyrxIe1yoU3D9I0GdkCqgZiQJcxsanE+ktkJPsMOcJnvPH3OG5NiH8n0OkjV9eH
 BrgKM4Q2nuKOUy/hLBIQtaENhD9bOFAu3f2yDmJqFI7eKKuCpm2s1btU2TC+4SdU8uJ0duc4xyX
 9o+/x/0pBPYREwe30xwc0fC3bSGILC53wJ1YHP3gchjK88/PV94h/26EssZ8GPJ/6YpyNXzfP7Y
 3Ho3MtwA18F+j6BoRstBY5Vlu6GgsaN/Gm2PZous=
X-Authority-Analysis: v=2.4 cv=DMi/JSNb c=1 sm=1 tr=0 ts=6a970422 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=x0eKOSpe3m1H3M0S9YoZ:22 a=yPCof4ZbAAAA:8 a=r3duO8M3fcnYQWKYDvQA:9
 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:13521
X-Proofpoint-GUID: Z4N1ZvxCXURG0GsywLuZB7iesNyBIp9A

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
---
 tools/lib/bpf/btf.c             | 372 +++++++++++++++++++++++++++++++-
 tools/lib/bpf/btf.h             |  50 +++++
 tools/lib/bpf/btf_dump.c        |   9 +
 tools/lib/bpf/btf_iter.c        |  22 ++
 tools/lib/bpf/libbpf.map        |   6 +
 tools/lib/bpf/libbpf_internal.h |   2 +-
 6 files changed, 457 insertions(+), 4 deletions(-)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index c783359977b4..9449f6f50f18 100644
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
@@ -3344,6 +3400,208 @@ int btf__add_decl_attr(struct btf *btf, const char *value, int ref_type_id,
 	return btf_add_decl_tag(btf, value, ref_type_id, component_idx, 1);
 }
 
+/*
+ * Append new BTF_KIND_LOC_PARAM with specified size and flags.  Values are
+ * added via btf__add_loc_param_value().
+ *
+ * Returns:
+ *   -  >0, type ID of newly added BTF type;
+ *   - <0, on error.
+ */
+int btf__add_loc_param(struct btf *btf, __u32 size, __u32 flags)
+{
+	struct btf_loc_param *p;
+	struct btf_type *t;
+	int sz, err;
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
+	t->size = size;
+
+	p = btf_loc_param(t);
+	p->flags = flags;
+
+	return btf_commit_type(btf, sz);
+}
+
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
+int btf__add_locsec(struct btf *btf, const char *name)
+{
+	struct btf_type *t;
+	int name_off = 0;
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
+	if (!str_is_empty(name)) {
+		name_off = btf__add_str(btf, name);
+		if (name_off < 0)
+			return name_off;
+	}
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
@@ -4114,8 +4372,8 @@ static struct btf_dedup *btf_dedup_new(struct btf *btf, const struct btf_dedup_o
 	for (i = 1; i < type_cnt; i++) {
 		struct btf_type *t = btf_type_by_id(d->btf, i);
 
-		/* VAR and DATASEC are never deduped and are self-canonical */
-		if (btf_is_var(t) || btf_is_datasec(t))
+		/* VAR, DATASEC and LOCSEC are never deduped and are self-canonical */
+		if (btf_is_var(t) || btf_is_datasec(t) || btf_is_locsec(t))
 			d->map[i] = i;
 		else
 			d->map[i] = BTF_UNPROCESSED_ID;
@@ -4395,6 +4653,45 @@ static bool btf_compat_enum(struct btf_type *t1, struct btf_type *t2)
 	       btf_is_any_enum(t1) && btf_is_any_enum(t2);
 }
 
+static long btf_hash_loc_param(struct btf_type *t)
+{
+	long h = btf_hash_common(t);
+	__u32 *v = (__u32 *)btf_loc_param(t);
+	int i, vlen = btf_vlen(t);
+
+	for (i = 0; i <= vlen; i++, v++)
+		h = hash_combine(h, *v);
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
+	__u32 *v1 = (__u32 *)(p1 + 1);
+	__u32 *v2 = (__u32 *)(p2 + 1);
+	int i, vlen = btf_vlen(t1);
+
+	if (!btf_equal_common(t1, t2))
+		return false;
+	for (i = 0; i < vlen; i++, v1++, v2++) {
+		if (*v1 != *v2)
+			return false;
+	}
+	return true;
+}
+
 /*
  * Calculate type signature hash of STRUCT/UNION, ignoring referenced type IDs,
  * as referenced type IDs equivalence is established separately during type
@@ -4622,6 +4919,12 @@ static int btf_dedup_prep(struct btf_dedup *d)
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
@@ -4664,6 +4967,8 @@ static int btf_dedup_prim_type(struct btf_dedup *d, __u32 type_id)
 	case BTF_KIND_DATASEC:
 	case BTF_KIND_DECL_TAG:
 	case BTF_KIND_TYPE_TAG:
+	case BTF_KIND_LOC_PROTO:
+	case BTF_KIND_LOCSEC:
 		return 0;
 
 	case BTF_KIND_INT:
@@ -4713,6 +5018,18 @@ static int btf_dedup_prim_type(struct btf_dedup *d, __u32 type_id)
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
@@ -5145,6 +5462,13 @@ static int btf_dedup_is_equiv(struct btf_dedup *d, __u32 cand_id,
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
@@ -5489,6 +5813,41 @@ static int btf_dedup_ref_type(struct btf_dedup *d, __u32 type_id)
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
+			if (vlen == 0) {
+				new_id = cand_id;
+				break;
+			}
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
@@ -5970,8 +6329,11 @@ static int btf_add_distilled_type_ids(struct btf_distill *dist, __u32 i)
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
@@ -5997,7 +6359,7 @@ static int btf_add_distilled_type_ids(struct btf_distill *dist, __u32 i)
 
 static int btf_add_distilled_types(struct btf_distill *dist)
 {
-	bool adding_to_base = dist->pipe.dst->start_id == 1;
+	bool adding_to_base = dist->pipe.dst->base_btf == NULL;
 	int id = btf__type_cnt(dist->pipe.dst);
 	struct btf_type *t;
 	int i, err = 0;
@@ -6065,8 +6427,12 @@ static int btf_add_distilled_types(struct btf_distill *dist)
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
index 9a6c822c2294..54428e422ec3 100644
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
@@ -94,6 +109,8 @@ int btf_field_iter_init(struct btf_field_iter *it, struct btf_type *t,
 		case BTF_KIND_DECL_TAG:
 		case BTF_KIND_TYPE_TAG:
 		case BTF_KIND_DATASEC:
+		case BTF_KIND_LOC_PARAM:
+		case BTF_KIND_LOC_PROTO:
 			it->desc = (struct btf_field_desc) {
 				1, {offsetof(struct btf_type, name_off)}
 			};
@@ -127,6 +144,11 @@ int btf_field_iter_init(struct btf_field_iter *it, struct btf_type *t,
 				1, {offsetof(struct btf_param, name_off)}
 			};
 			break;
+		case BTF_KIND_LOCSEC:
+			it->desc = (struct btf_field_desc) {
+				1, {offsetof(struct btf_type, name_off)}
+			};
+			break;
 		default:
 			return -EINVAL;
 		}
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index 08ab2ea881fb..7f51783df129 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -460,6 +460,12 @@ LIBBPF_1.8.0 {
 	global:
 		bpf_program__attach_tracing_multi;
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
index cb4d96233844..ebac8db1ccfd 100644
--- a/tools/lib/bpf/libbpf_internal.h
+++ b/tools/lib/bpf/libbpf_internal.h
@@ -580,7 +580,7 @@ struct btf_field_desc {
 	/* member struct size, or zero, if no members */
 	int m_sz;
 	/* repeated per-member offsets */
-	int m_off_cnt, m_offs[1];
+	int m_off_cnt, m_offs[22];
 };
 
 struct btf_field_iter {
-- 
2.43.5

