Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D8F6485518;
	Tue,  1 Sep 2026 16:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788281916; cv=none; b=OHORjr9wUYXd8vskSx6Kw+bd3O9E3ijrBAs2yKdoRZ5AN4Yk0keH2G5CJDGT2maiWTnO2IPeLWaXQZ+GHPSNqW6UX7VXMamlwDaAwJampt3JogbDyHhmfvJzi1hqWxd06zlXwEIl7jJ4UtLfboemUGRNRBOIIyOhWDawccMAY60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788281916; c=relaxed/simple;
	bh=vg1v1G5xjWH7DNwhi0RPTPhw23RopTMQaaVRUDVwh5s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pfeoy+gX2Nl60sWiImLdnykNm69qLgBaiWB6krxl0w90ELqkszLbwsqvmqHTj97f4EQVpZXWAsC/OBSe9xDENGJvG4+tI8LyQi0zA2vttho7XxlunwgBBofv5tjCqyynLSojmzKw3wiQLipnCZ5av5UH+lN2gl80NC91kLD114Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=TMJWvmBX; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TMJWvmBX"
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 681EPwcR230962;
	Tue, 1 Sep 2026 16:58:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=fEXxT
	ABBlX6HJh3UcSW8VetQPlOCERPdeW36uG9gjT4=; b=TMJWvmBXSdI+sik43ffTR
	v0jRfGwJgN2pvifFhpdZLBnNZvVzPpxtgr7h/Kby2O5Euco4VC6PlABwaL72wmUh
	z3eZxc6b+foPe1wD1ctG5KmprTX62wbX/FMJ5w2AJz6hGVbBioXvVfRhoGwlP6su
	nGLLkWPm8HgQOozTkBibfVZOP4eViTDBycIYjSWzES4vzmQIAOunVGbg76x2wYpG
	V6+itJ6LD5W3YI3ZKzSSwsdsO4gexXJJ1JpYNd/9vaJ7A4GbYytZ/qXEdZz3Nb1i
	uo2ML9Fmuz3Aaufvl5iOc2e9EW8fsJVEcLPc6hSZxN0jkUa1w0ZPtmoqc3nUVYBM
	w==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4gbqa7n3sq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 01 Sep 2026 16:58:06 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 681GjSMw001822;
	Tue, 1 Sep 2026 16:58:05 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4gdymtg8jk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 01 Sep 2026 16:58:05 +0000 (GMT)
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 681Gw1Vr011129;
	Tue, 1 Sep 2026 16:58:04 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-52-250.vpn.oracle.com [10.154.52.250])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4gdymtg8f6-2;
	Tue, 01 Sep 2026 16:58:04 +0000 (GMT)
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
Subject: [PATCH v2 bpf-next 01/18] btf: Extend UAPI to support BTF location (inline site) info
Date: Tue,  1 Sep 2026 17:57:40 +0100
Message-ID: <20260901165757.801449-2-alan.maguire@oracle.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAxMDE1MCBTYWx0ZWRfX//crL0M/V56R
 RD+uHFXMHhlzzkM3KqlMidVQmxBkSloFfXPVbP4nUYHj9lNAMd0QOhG/e3dSQEG2c3SewxsizKL
 e0t6yXaMLFUnefrGkldU93ZcLFSlWO3fH/bueymJOYivBpm2q303
X-Proofpoint-GUID: KGA1EyvyHOwWQqpcL3kRGrOth_i-yZIH
X-Authority-Analysis: v=2.4 cv=DPu/JSNb c=1 sm=1 tr=0 ts=6a97041f b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=EIcjfB9IiI4px24ztqRk:22 a=yPCof4ZbAAAA:8 a=ThJMnvK8IdcDtQXm2XoA:9
 a=O8hF6Hzn-FEA:10 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf
 awl=host:13521
X-Proofpoint-ORIG-GUID: KGA1EyvyHOwWQqpcL3kRGrOth_i-yZIH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAxMDE1MCBTYWx0ZWRfX0lgnfQdO8l2a
 evDUkwScwhTLPt+koih5oAa2zsug8QiiRMZan/+/AhhUcxJnk/vcsfkED9fOKG657nslJOUQGOJ
 nxrwx5oEf89V/jXz77p+UZpfVRQ/rAjFdFcLW4sXUdF97dDN+mOt8rDZDBEvxThYcoqfiMOVNL3
 uUi5qWA70ESMIFr644oO9gde/bjDqEoA14HBJ1OAIe54Ev+5HYNEe8qD6r069fXNE2cxxTK7N57
 WIOGefcP7lUVpLZ9St5Cs07FeJXzo81ojeJw7zhPqvdr0yEitG4RnbBYHC2ERtbVwjUQTXQM5Nn
 kpzW8exUFD0yZPE3hBruwpvBzbFf5QJVjMDAHONcI2BiTC2lHDIKW+6VgoNrlAhph71hzhgdSDz
 ybSDSDlYro8O2rak3EsjFxMFlyBTskpzcmUUZRFZ9Wk5IgtvAJyeSar27UGt1k7WwQiVwjjODxG
 Z1E/VaJKziunNmTWkKdBNiflQcs53nYaD2YG2xU0=

Add BTF_KIND_LOC_PARAM, BTF_KIND_LOC_PROTO and BTF_KIND_LOCSEC
to help represent location information for functions.

BTF_KIND_LOC_PARAM is used to represent how we retrieve data at a
location; either via register(s), or register+offset, a dereference
of a register+offset or a constant value.

BTF_KIND_LOC_PROTO represents location information about a location
with multiple BTF_KIND_LOC_PARAMs.

And finally BTF_KIND_LOCSEC is a set of location sites, each
of which has

- a BTF_KIND_FUNC function associated with the inline site
- a location prototype specifying where to find the function
  parameters
- an address offset relative to the kernel base address

This can be used to support representing

- a fully-inlined function at potentially multiple inline sites
  with potentially different parameter availability
- a partially-inlined function where some _LOC_PROTOs represent
  inlined sites as above and others have normal _FUNC representations

Also BTF_KIND_LOCSEC struct btf_loc will have two type id
references; one for the associated func, the other for the loc_proto.
Accordingly increase the number of m_offs references in btf_field_desc
to 2.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 include/linux/btf.h            |  17 ++-
 include/uapi/linux/btf.h       |  65 ++++++++-
 kernel/bpf/btf.c               | 238 ++++++++++++++++++++++++++++++++-
 tools/include/uapi/linux/btf.h |  65 ++++++++-
 4 files changed, 379 insertions(+), 6 deletions(-)

diff --git a/include/linux/btf.h b/include/linux/btf.h
index ddd0f4f32d24..a4412bc16688 100644
--- a/include/linux/btf.h
+++ b/include/linux/btf.h
@@ -329,6 +329,21 @@ static inline u64 btf_enum64_value(const struct btf_enum64 *e)
 	return ((u64)e->val_hi32 << 32) | e->val_lo32;
 }
 
+static inline struct btf_loc_param *btf_loc_param(const struct btf_type *t)
+{
+	return (struct btf_loc_param *)(t + 1);
+}
+
+static inline __u32 *btf_loc_params(const struct btf_type *t)
+{
+	return (__u32 *)(t + 1);
+}
+
+static inline struct btf_loc *btf_type_loc_secinfo(const struct btf_type *t)
+{
+	return (struct btf_loc *)(t + 1);
+}
+
 static inline bool btf_is_composite(const struct btf_type *t)
 {
 	u16 kind = btf_kind(t);
@@ -559,7 +574,7 @@ struct btf_field_desc {
 	/* member struct size, or zero, if no members */
 	int m_sz;
 	/* repeated per-member offsets */
-	int m_off_cnt, m_offs[1];
+	int m_off_cnt, m_offs[2];
 };
 
 struct btf_field_iter {
diff --git a/include/uapi/linux/btf.h b/include/uapi/linux/btf.h
index 618167cab4e6..6062c9958034 100644
--- a/include/uapi/linux/btf.h
+++ b/include/uapi/linux/btf.h
@@ -92,7 +92,9 @@ enum {
 	BTF_KIND_DECL_TAG	= 17,	/* Decl Tag */
 	BTF_KIND_TYPE_TAG	= 18,	/* Type Tag */
 	BTF_KIND_ENUM64		= 19,	/* Enumeration up to 64-bit values */
-
+	BTF_KIND_LOC_PARAM	= 20,	/* Location parameter information */
+	BTF_KIND_LOC_PROTO	= 21,	/* Location prototype for site */
+	BTF_KIND_LOCSEC		= 22,	/* Location section */
 	NR_BTF_KINDS,
 	BTF_KIND_MAX		= NR_BTF_KINDS - 1,
 };
@@ -212,4 +214,65 @@ struct btf_enum64 {
 	__u32	val_hi32;
 };
 
+/*
+ * BTF_KIND_LOC_PARAM is followed by a single "struct btf_loc_param"
+ * that contains flags specifying the contents of the vlen-specified
+ * number of 4-byte values that follow.
+ */
+struct btf_loc_param {
+	__u32 flags;
+};
+
+/*
+ * The combination of size, vlen and flags gives us the means to interpret
+ * the following vlen-specified set of 4-byte values:
+ *
+ * - a BTF_LOC_PARAM_CONST is a constant value; combination
+ *   of size, vlen and _SIGNED flag determines it. If the value requires
+ *   64 bits it is stored in {lo,hi} order.
+ * - a BTF_LOC_PARAM_ADDR is an address that will be normalized with
+ *   respect to kernel base address.
+ * - a BTF_LOC_PARAM_REG with vlen 1 is a simple register number;
+ *   with vlen 2 it is a multi-register parameter.
+ * - a _REG | DEREF with vlen 1 dereferences the value in the register
+ *   number specified.
+ * - a REG | DEREF | OFFSET with vlen specifies the register value in
+ *   the first 4-byte value and the offset in the remainder.
+ * - binary logical operators operate on a combination of register
+ *   number and constant value, aside from _NOT which operates on
+ *   a register
+ */
+enum btf_loc_param_flags {
+	BTF_LOC_PARAM_SIGNED		=	0x1,
+	BTF_LOC_PARAM_CONST		=	0x2,
+	BTF_LOC_PARAM_ADDR		=	0x4,
+	BTF_LOC_PARAM_REG		=	0x8,
+	BTF_LOC_PARAM_DEREF		=	0x10,
+	BTF_LOC_PARAM_OFFSET		=	0x20,
+};
+
+/*
+ * BTF_KIND_LOC_PROTO specifies location prototypes; i.e. how locations relate
+ * to parameters; a struct btf_type of BTF_KIND_LOC_PROTO is followed by a
+ * a vlen-specified number of __u32 BTF type ids which specify the associated
+ * BTF_KIND_LOC_PARAM for each function parameter associated with the
+ * location.  The type should either be 0 (no location info) or point at
+ * a BTF_KIND_LOC_PARAM.
+ */
+
+/*
+ * BTF_KIND_LOCSEC consists of vlen-specified number of "struct btf_loc"
+ * containing location site-specific information;
+ *
+ * - function (func)
+ * - location prototype type id (loc_proto)
+ * - address offset (offset) relative to kernel base address
+ */
+
+struct btf_loc {
+	__u32 func;
+	__u32 loc_proto;
+	__u32 offset;
+};
+
 #endif /* _UAPI__LINUX_BTF_H__ */
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 9c2cab08bb79..d74c8668aa3f 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -345,6 +345,9 @@ static const char * const btf_kind_str[NR_BTF_KINDS] = {
 	[BTF_KIND_DECL_TAG]	= "DECL_TAG",
 	[BTF_KIND_TYPE_TAG]	= "TYPE_TAG",
 	[BTF_KIND_ENUM64]	= "ENUM64",
+	[BTF_KIND_LOC_PARAM]	= "LOC_PARAM",
+	[BTF_KIND_LOC_PROTO]	= "LOC_PROTO",
+	[BTF_KIND_LOCSEC]	= "LOCSEC",
 };
 
 const char *btf_type_str(const struct btf_type *t)
@@ -517,11 +520,27 @@ static bool btf_type_is_decl_tag(const struct btf_type *t)
 	return BTF_INFO_KIND(t->info) == BTF_KIND_DECL_TAG;
 }
 
+static bool btf_type_is_loc_param(const struct btf_type *t)
+{
+	return BTF_INFO_KIND(t->info) == BTF_KIND_LOC_PARAM;
+}
+
+static bool btf_type_is_loc_proto(const struct btf_type *t)
+{
+	return BTF_INFO_KIND(t->info) == BTF_KIND_LOC_PROTO;
+}
+
+static bool btf_type_is_locsec(const struct btf_type *t)
+{
+	return BTF_INFO_KIND(t->info) == BTF_KIND_LOCSEC;
+}
+
 static bool btf_type_nosize(const struct btf_type *t)
 {
 	return btf_type_is_void(t) || btf_type_is_fwd(t) ||
 	       btf_type_is_func(t) || btf_type_is_func_proto(t) ||
-	       btf_type_is_decl_tag(t);
+	       btf_type_is_decl_tag(t) || btf_type_is_loc_param(t) ||
+	       btf_type_is_loc_proto(t) || btf_type_is_locsec(t);
 }
 
 static bool btf_type_nosize_or_null(const struct btf_type *t)
@@ -796,7 +815,9 @@ static bool btf_type_needs_resolve(const struct btf_type *t)
 	       btf_type_is_var(t) ||
 	       btf_type_is_func(t) ||
 	       btf_type_is_decl_tag(t) ||
-	       btf_type_is_datasec(t);
+	       btf_type_is_datasec(t) ||
+	       btf_type_is_loc_proto(t) ||
+	       btf_type_is_locsec(t);
 }
 
 /* t->size can be used */
@@ -4714,6 +4735,213 @@ static const struct btf_kind_operations enum64_ops = {
 	.show = btf_enum64_show,
 };
 
+static s32 btf_loc_param_check_meta(struct btf_verifier_env *env,
+				    const struct btf_type *t,
+				    u32 meta_left)
+{
+	const struct btf_loc_param *p = btf_loc_param(t);
+	u32 meta_needed;
+	u32 size;
+
+	meta_needed = sizeof(*p) + sizeof(__u32) * btf_vlen(t);
+	if (meta_left < meta_needed) {
+		btf_verifier_log_basic(env, t,
+				       "meta_left:%u meta_needed:%u",
+				      meta_left, meta_needed);
+		return -EINVAL;
+	}
+
+	if (t->name_off) {
+		btf_verifier_log_type(env, t, "Invalid name");
+		return -EINVAL;
+	}
+	size = t->size;
+	if (size > 16 || !is_power_of_2(size)) {
+		btf_verifier_log_type(env, t, "Unexpected size");
+		return -EINVAL;
+	}
+
+	return meta_needed;
+}
+
+static void btf_loc_param_log(struct btf_verifier_env *env,
+			 const struct btf_type *t)
+{
+	const struct btf_loc_param *p = btf_loc_param(t);
+	u32 *d = (u32 *)(p + 1);
+	u32 i, vlen = btf_vlen(t);
+
+	btf_verifier_log(env, "size=%u flags=0x%x param_data(", t->size, p->flags);
+	for (i = 0; i < vlen; i++, d++)
+		btf_verifier_log(env, "%u%s", *d,
+				 i + 1 == vlen ? ")" : ", ");
+}
+
+static const struct btf_kind_operations loc_param_ops = {
+	.check_meta = btf_loc_param_check_meta,
+	.resolve = btf_df_resolve,
+	.check_member = btf_df_check_member,
+	.check_kflag_member = btf_df_check_kflag_member,
+	.log_details = btf_loc_param_log,
+	.show = btf_df_show,
+};
+
+static s32 btf_loc_proto_check_meta(struct btf_verifier_env *env,
+				    const struct btf_type *t,
+				    u32 meta_left)
+{
+	u32 meta_needed;
+
+	meta_needed = sizeof(__u32) * btf_type_vlen(t);
+
+	if (meta_left < meta_needed) {
+		btf_verifier_log_basic(env, t,
+				       "meta_left:%u meta_needed:%u",
+				      meta_left, meta_needed);
+		return -EINVAL;
+	}
+
+	if (t->name_off) {
+		btf_verifier_log_type(env, t, "Invalid name");
+		return -EINVAL;
+	}
+	return meta_needed;
+}
+
+static void btf_loc_proto_log(struct btf_verifier_env *env,
+			      const struct btf_type *t)
+{
+	const __u32 *params = btf_loc_params(t);
+	u32 nr_params = btf_type_vlen(t), i;
+
+	btf_verifier_log(env, "loc_proto locs=(");
+	for (i = 0; i < nr_params; i++, params++) {
+		btf_verifier_log(env, "type=%u%s", *params,
+				 i + 1 == nr_params ? ")" : ", ");
+	}
+}
+
+static int btf_loc_proto_resolve(struct btf_verifier_env *env,
+				 const struct resolve_vertex *v)
+{
+	const __u32 *params = btf_loc_params(v->t);
+	u32 i, nr_params = btf_type_vlen(v->t);
+	struct btf *btf = env->btf;
+
+	for (i = 0; i < nr_params; i++) {
+		const struct btf_type *param_type;
+		u32 param_type_id = params[i];
+
+		if (!param_type_id)
+			continue;
+
+		param_type = btf_type_by_id(btf, param_type_id);
+		if (!param_type || !btf_type_is_loc_param(param_type)) {
+			btf_verifier_log_type(env, v->t,
+					      "Invalid loc_param#%u", i + 1);
+			return -EINVAL;
+		}
+	}
+
+	env_stack_pop_resolved(env, 0, 0);
+	return 0;
+}
+
+static const struct btf_kind_operations loc_proto_ops = {
+	.check_meta = btf_loc_proto_check_meta,
+	.resolve = btf_loc_proto_resolve,
+	.check_member = btf_df_check_member,
+	.check_kflag_member = btf_df_check_kflag_member,
+	.log_details = btf_loc_proto_log,
+	.show = btf_df_show,
+};
+
+static s32 btf_locsec_check_meta(struct btf_verifier_env *env,
+				 const struct btf_type *t,
+				 u32 meta_left)
+{
+	u32 meta_needed;
+
+	meta_needed = sizeof(struct btf_loc) * btf_type_vlen(t);
+
+	if (meta_left < meta_needed) {
+		btf_verifier_log_basic(env, t,
+				       "meta_left:%u meta_needed:%u",
+				       meta_left, meta_needed);
+		return -EINVAL;
+	}
+	return meta_needed;
+}
+
+static void btf_locsec_log(struct btf_verifier_env *env,
+			   const struct btf_type *t)
+{
+	const struct btf_loc *loc = btf_type_loc_secinfo(t);
+	u32 nr_locs = btf_type_vlen(t), i;
+	const struct btf *btf = env->btf;
+
+	btf_verifier_log(env, "locsec %s locs=(",
+			 __btf_name_by_offset(btf, t->name_off));
+	for (i = 0; i < nr_locs; i++, loc++) {
+		btf_verifier_log(env, "\n\tfunc %u loc_proto %u offset 0x%x%s",
+				 loc->func, loc->loc_proto, loc->offset,
+				 i + 1 == nr_locs ? ")" : ", ");
+	}
+}
+
+static int btf_locsec_resolve(struct btf_verifier_env *env,
+			      const struct resolve_vertex *v)
+{
+	const struct btf_loc *loc;
+	struct btf *btf = env->btf;
+	u32 i;
+
+	env->resolve_mode = RESOLVE_TBD;
+	for (i = v->next_member, loc = btf_type_loc_secinfo(v->t) + i;
+	     i < btf_type_vlen(v->t); i++, loc++) {
+		const struct btf_type *func_type, *loc_proto_type;
+		u32 func_type_id = loc->func;
+		u32 loc_proto_type_id = loc->loc_proto;
+
+		func_type = btf_type_by_id(btf, func_type_id);
+		if (!func_type || !btf_type_is_func(func_type)) {
+			btf_verifier_log_type(env, v->t,
+					      "Invalid func#%u", i + 1);
+			return -EINVAL;
+		}
+
+		if (!env_type_is_resolved(env, func_type_id)) {
+			env_stack_set_next_member(env, i);
+			return env_stack_push(env, func_type, func_type_id);
+		}
+
+		loc_proto_type = btf_type_by_id(btf, loc_proto_type_id);
+		if (!loc_proto_type || !btf_type_is_loc_proto(loc_proto_type)) {
+			btf_verifier_log_type(env, v->t,
+					      "Invalid loc_proto#%u", i + 1);
+			return -EINVAL;
+		}
+
+		if (!env_type_is_resolved(env, loc_proto_type_id)) {
+			env_stack_set_next_member(env, i + 1);
+			return env_stack_push(env, loc_proto_type,
+					      loc_proto_type_id);
+		}
+	}
+
+	env_stack_pop_resolved(env, 0, 0);
+	return 0;
+}
+
+static const struct btf_kind_operations locsec_ops = {
+	.check_meta = btf_locsec_check_meta,
+	.resolve = btf_locsec_resolve,
+	.check_member = btf_df_check_member,
+	.check_kflag_member = btf_df_check_kflag_member,
+	.log_details = btf_locsec_log,
+	.show = btf_df_show,
+};
+
 static s32 btf_func_proto_check_meta(struct btf_verifier_env *env,
 				     const struct btf_type *t,
 				     u32 meta_left)
@@ -5383,6 +5611,9 @@ static const struct btf_kind_operations * const kind_ops[NR_BTF_KINDS] = {
 	[BTF_KIND_DECL_TAG] = &decl_tag_ops,
 	[BTF_KIND_TYPE_TAG] = &modifier_ops,
 	[BTF_KIND_ENUM64] = &enum64_ops,
+	[BTF_KIND_LOC_PARAM] = &loc_param_ops,
+	[BTF_KIND_LOC_PROTO] = &loc_proto_ops,
+	[BTF_KIND_LOCSEC] = &locsec_ops,
 };
 
 static s32 btf_check_meta(struct btf_verifier_env *env,
@@ -5457,7 +5688,8 @@ static bool btf_resolve_valid(struct btf_verifier_env *env,
 	if (!env_type_is_resolved(env, type_id))
 		return false;
 
-	if (btf_type_is_struct(t) || btf_type_is_datasec(t))
+	if (btf_type_is_struct(t) || btf_type_is_datasec(t) ||
+	    btf_type_is_loc_proto(t) || btf_type_is_locsec(t))
 		return !btf_resolved_type_id(btf, type_id) &&
 		       !btf_resolved_type_size(btf, type_id);
 
diff --git a/tools/include/uapi/linux/btf.h b/tools/include/uapi/linux/btf.h
index 618167cab4e6..6062c9958034 100644
--- a/tools/include/uapi/linux/btf.h
+++ b/tools/include/uapi/linux/btf.h
@@ -92,7 +92,9 @@ enum {
 	BTF_KIND_DECL_TAG	= 17,	/* Decl Tag */
 	BTF_KIND_TYPE_TAG	= 18,	/* Type Tag */
 	BTF_KIND_ENUM64		= 19,	/* Enumeration up to 64-bit values */
-
+	BTF_KIND_LOC_PARAM	= 20,	/* Location parameter information */
+	BTF_KIND_LOC_PROTO	= 21,	/* Location prototype for site */
+	BTF_KIND_LOCSEC		= 22,	/* Location section */
 	NR_BTF_KINDS,
 	BTF_KIND_MAX		= NR_BTF_KINDS - 1,
 };
@@ -212,4 +214,65 @@ struct btf_enum64 {
 	__u32	val_hi32;
 };
 
+/*
+ * BTF_KIND_LOC_PARAM is followed by a single "struct btf_loc_param"
+ * that contains flags specifying the contents of the vlen-specified
+ * number of 4-byte values that follow.
+ */
+struct btf_loc_param {
+	__u32 flags;
+};
+
+/*
+ * The combination of size, vlen and flags gives us the means to interpret
+ * the following vlen-specified set of 4-byte values:
+ *
+ * - a BTF_LOC_PARAM_CONST is a constant value; combination
+ *   of size, vlen and _SIGNED flag determines it. If the value requires
+ *   64 bits it is stored in {lo,hi} order.
+ * - a BTF_LOC_PARAM_ADDR is an address that will be normalized with
+ *   respect to kernel base address.
+ * - a BTF_LOC_PARAM_REG with vlen 1 is a simple register number;
+ *   with vlen 2 it is a multi-register parameter.
+ * - a _REG | DEREF with vlen 1 dereferences the value in the register
+ *   number specified.
+ * - a REG | DEREF | OFFSET with vlen specifies the register value in
+ *   the first 4-byte value and the offset in the remainder.
+ * - binary logical operators operate on a combination of register
+ *   number and constant value, aside from _NOT which operates on
+ *   a register
+ */
+enum btf_loc_param_flags {
+	BTF_LOC_PARAM_SIGNED		=	0x1,
+	BTF_LOC_PARAM_CONST		=	0x2,
+	BTF_LOC_PARAM_ADDR		=	0x4,
+	BTF_LOC_PARAM_REG		=	0x8,
+	BTF_LOC_PARAM_DEREF		=	0x10,
+	BTF_LOC_PARAM_OFFSET		=	0x20,
+};
+
+/*
+ * BTF_KIND_LOC_PROTO specifies location prototypes; i.e. how locations relate
+ * to parameters; a struct btf_type of BTF_KIND_LOC_PROTO is followed by a
+ * a vlen-specified number of __u32 BTF type ids which specify the associated
+ * BTF_KIND_LOC_PARAM for each function parameter associated with the
+ * location.  The type should either be 0 (no location info) or point at
+ * a BTF_KIND_LOC_PARAM.
+ */
+
+/*
+ * BTF_KIND_LOCSEC consists of vlen-specified number of "struct btf_loc"
+ * containing location site-specific information;
+ *
+ * - function (func)
+ * - location prototype type id (loc_proto)
+ * - address offset (offset) relative to kernel base address
+ */
+
+struct btf_loc {
+	__u32 func;
+	__u32 loc_proto;
+	__u32 offset;
+};
+
 #endif /* _UAPI__LINUX_BTF_H__ */
-- 
2.43.5

