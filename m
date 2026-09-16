Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEB8143CE7C
	for <bpf@vger.kernel.org>; Wed, 16 Sep 2026 07:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789544529; cv=none; b=Su8w1uaKslrJEHWzeVUDM7YScIdPoDe1jj4R+qQjMKPf6yprAGO1QdsI0JxPI/uEMkJORwjBg9843wxRzjfnbe20ao0UoLd6efcVbYZ1q3f3Xt2wuyK1ORsHB6/x0IF1bFmWd908vA7/ci6kCrtus523ecntLDCYSrZElB0vHb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789544529; c=relaxed/simple;
	bh=1hc5hu5m1wkq4N9hxguJDawFQkkk+k86OmuW9R7KyCQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rAju6Eqb5qPuMHkbRIV+d94i28N4cgwA5CLr52+NkGjrqOaiujHVWg810bESPT7RkYqrEjAD74MsCWAGiHq2PA9+CtFcWNM7RxFr9m62kDilsyDbe27Mz//B7TlGWnH+HxYPJetc2pBu0u1wHGlvGoSb9itEohRv2YKl4xzBVG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=jynb8kAv; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jynb8kAv"
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68G4uin01435744;
	Wed, 16 Sep 2026 07:41:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=aigDy
	+5guHSym5iZ2sVsvb4sBc6AaaB/Y2Jv2LcLsN4=; b=jynb8kAvhIj3zM5+czri1
	CC/l/5u8qbIi++zeiF6qGGnupajGyMNVwS/+EVAJyjCav7wTtvVWsw5dbV89G8Fe
	IqzGEWPstYlDfvtfVs9Ecxx74Ow/x+Ul9k9Oy5IJgWlD7FafwAwjvMXXRRMcDi1/
	A0RTJyPQSoRlrRegW/XymSCwC5guSaqC952IZxopCYvIZpmpg5A1fBu8MDxXNSSV
	PRX4L4GXVN8+aZ6AaaBzeAtMldIAF0e5V/hp1EyEgIbouhzm085URGzusyQ2V8Ez
	fz6CtKNV5F+h5rqWf1q94kXC4QJ/UkfgRQhKB3hhJJr9ibrvLThRk8wMg/jBZQrn
	A==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4gmxm7d35q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Sep 2026 07:41:28 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 68G7e3hw014871;
	Wed, 16 Sep 2026 07:41:27 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4gmw6au4wc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Sep 2026 07:41:27 +0000 (GMT)
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 68G7exPh020284;
	Wed, 16 Sep 2026 07:41:26 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-86-81.vpn.oracle.com [10.154.86.81])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4gmw6au4u1-2;
	Wed, 16 Sep 2026 07:41:26 +0000 (GMT)
From: Alan Maguire <alan.maguire@oracle.com>
To: ast@kernel.org, andrii@kernel.org, eddyz87@gmail.com, jolsa@kernel.org
Cc: daniel@iogearbox.net, ihor.solodrai@linux.dev, yonghong.song@linux.dev,
        song@kernel.org, qmo@kernel.org, martin.lau@linux.dev,
        memxor@gmail.com, emil@etsalapatis.com, bpf@vger.kernel.org,
        nsc@kernel.org, puranjay@kernel.org, yatsenko@meta.com,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v3 bpf-next 01/11] btf: Extend UAPI to support BTF location (inline site) info
Date: Wed, 16 Sep 2026 08:41:08 +0100
Message-ID: <20260916074118.1007116-2-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20260916074118.1007116-1-alan.maguire@oracle.com>
References: <20260916074118.1007116-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-15_05,2026-09-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 lowpriorityscore=0 mlxlogscore=999 adultscore=0 phishscore=0 malwarescore=0
 mlxscore=0 spamscore=0 suspectscore=0 bulkscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2609040000 definitions=main-2609160099
X-Proofpoint-GUID: IbA85L3KQrOr0aPkBvbnduJnaOp1amxs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE2MDA5OCBTYWx0ZWRfXxnNuR4UItf/p
 GEle1FFa8NYOePWd2nQwlDwyxyXNg5+5Bjct5yA9hKK2PDm6bBi6n/A4JZEjhW4p6ycFgfXOZAq
 lTrpyDCVbFrWe2c0RqeS3y2PaJ8QHYEvJfpH49sKz+gTzZrmUUyXcjdNYjCJR3erCNNUHcOnPUQ
 AIfZlY5ElzkmSTgOknAZ6DOL16EiaKMqB38Hjbr1G+PoHaR+Kgq/dsxBlMNSuMen/bjxwRm47lT
 7fj6/RS7tDkIZytBeyWPr8YKgFFYC7EA/y/NgPD9fBAvuRI3Xg6SxkysK8Co63HRmqHJYmqlxWZ
 hnZ+T3GexZZXVgcrK3XdhcMjpnwKEifGaQDY7wO1J5vohhi9qClNCWrv1JAWtNR5o/y3DXohHjE
 fxsfEGECHXcdpylHYGrmlcVMgcWytWVj3xklujzjA+sfoYAKV2JOEfqKV2fJx2Ja1qVKLWS0XXV
 ukWa3uxkWWYKJDIsWfA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE2MDA5OCBTYWx0ZWRfX1VP+GBm1+r1f
 1eTEljtGUt5tw6dG3pd+hJRgkp28+TY36z9dz4QAFlWIJCXXGHvB24l6qvaKBWo7oTQ5CqnTGbS
 +6CzOPwSywUY9C0utwW14YytqYKw3/4tVdrxwTChM2RWvfaafcsU
X-Proofpoint-ORIG-GUID: IbA85L3KQrOr0aPkBvbnduJnaOp1amxs
X-Authority-Analysis: v=2.4 cv=A/n5rKWG c=1 sm=1 tr=0 ts=6aaa4828 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=EIcjfB9IiI4px24ztqRk:22 a=yPCof4ZbAAAA:8 a=pGLkceISAAAA:8
 a=3UHWoLTpBnnWFvCYdDMA:9 a=O8hF6Hzn-FEA:10 a=WmVTiCyuxqgg3mnwYu6p:22

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
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
---
 include/linux/btf.h            |  22 ++-
 include/uapi/linux/btf.h       |  65 ++++++-
 kernel/bpf/btf.c               | 304 ++++++++++++++++++++++++++++++++-
 tools/include/uapi/linux/btf.h |  65 ++++++-
 4 files changed, 450 insertions(+), 6 deletions(-)

diff --git a/include/linux/btf.h b/include/linux/btf.h
index ddd0f4f32d24..f29ed358b7a8 100644
--- a/include/linux/btf.h
+++ b/include/linux/btf.h
@@ -261,6 +261,11 @@ const char *btf_type_str(const struct btf_type *t);
 	     i < btf_type_vlen(datasec_type);			\
 	     i++, member++)
 
+#define for_each_loc(i, locsec_type, member)			\
+	for (i = 0, member = btf_type_loc_secinfo(locsec_type);	\
+	     i < btf_type_vlen(locsec_type);			\
+	     i++, member++)
+
 static inline bool btf_type_is_ptr(const struct btf_type *t)
 {
 	return BTF_INFO_KIND(t->info) == BTF_KIND_PTR;
@@ -329,6 +334,21 @@ static inline u64 btf_enum64_value(const struct btf_enum64 *e)
 	return ((u64)e->val_hi32 << 32) | e->val_lo32;
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
+static inline struct btf_loc *btf_type_loc_secinfo(const struct btf_type *t)
+{
+	return (struct btf_loc *)(t + 1);
+}
+
 static inline bool btf_is_composite(const struct btf_type *t)
 {
 	u16 kind = btf_kind(t);
@@ -559,7 +579,7 @@ struct btf_field_desc {
 	/* member struct size, or zero, if no members */
 	int m_sz;
 	/* repeated per-member offsets */
-	int m_off_cnt, m_offs[1];
+	int m_off_cnt, m_offs[2];
 };
 
 struct btf_field_iter {
diff --git a/include/uapi/linux/btf.h b/include/uapi/linux/btf.h
index 618167cab4e6..a85d293f4127 100644
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
+	__u32 values[];
+};
+
+/*
+ * The combination of size, vlen and flags gives us the means to interpret
+ * the following vlen-specified set of 4-byte values:
+ *
+ * - a BTF_LOC_PARAM_CONST is a constant value; combination
+ *   of size, vlen and _SIGNED flag determines it. If the value requires
+ *   64 bits it is stored in {lo,hi} order.
+ * - a BTF_LOC_PARAM_ADDR|BTF_LOC_PARAM_CONST is an address that should be
+ *   normalized with respect to kernel/module base address.
+ * - a BTF_LOC_PARAM_REG with vlen 1 is a simple register number;
+ *   with vlen 2 it is a multi-register parameter.
+ * - a _REG | OFFSET describes an address without dereferencing it.
+ * - a _REG | DEREF with vlen 1 dereferences the value in the register
+ *   number specified.
+ * - a REG | DEREF | OFFSET with vlen specifies the register value in
+ *   the first 4-byte value and the offset in the remainder.
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
+ * vlen-specified number of __u32 BTF type ids which specify the associated
+ * BTF_KIND_LOC_PARAM for each function parameter associated with the
+ * location.  The type should either be 0 (no location info) or point at
+ * a BTF_KIND_LOC_PARAM.
+ */
+
+/*
+ * BTF_KIND_LOCSEC consists of vlen-specified number of "struct btf_loc"
+ * containing location site-specific information for a specific ELF section;
+ * for example locations in ".text" are in a LOCSEC named "inline.text".
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
index 7daf4c286c9b..af5f161b5bdd 100644
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
@@ -4729,6 +4750,279 @@ static const struct btf_kind_operations enum64_ops = {
 	.show = btf_enum64_show,
 };
 
+static s32 btf_loc_param_check_meta(struct btf_verifier_env *env,
+				    const struct btf_type *t,
+				    u32 meta_left)
+{
+	const struct btf_loc_param *p = btf_loc_param(t);
+	u32 size, meta_needed, vlen = btf_vlen(t);
+
+	meta_needed = sizeof(*p) + sizeof(__u32) * vlen;
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
+	if (btf_type_kflag(t)) {
+		btf_verifier_log_type(env, t, "Invalid btf_info kind_flag");
+		return -EINVAL;
+	}
+
+	btf_verifier_log_type(env, t, NULL);
+
+	return meta_needed;
+}
+
+static void btf_loc_param_log(struct btf_verifier_env *env,
+			 const struct btf_type *t)
+{
+	const struct btf_loc_param *p = btf_loc_param(t);
+	u32 i, vlen = btf_vlen(t);
+
+	btf_verifier_log(env, "size=%u vlen=%u flags=0x%x", t->size, vlen, p->flags);
+	for (i = 0; i < vlen; i++)
+		btf_verifier_log(env, ", %u", p->values[i]);
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
+
+	if (btf_type_kflag(t)) {
+		btf_verifier_log_type(env, t, "Invalid btf_info kind_flag");
+		return -EINVAL;
+	}
+
+	btf_verifier_log_type(env, t, NULL);
+
+	return meta_needed;
+}
+
+static void btf_loc_proto_log(struct btf_verifier_env *env,
+			      const struct btf_type *t)
+{
+	const __u32 *params = btf_loc_proto_params(t);
+	u32 i, nr_params = btf_type_vlen(t);
+
+	btf_verifier_log(env, "vlen=%u", nr_params);
+	for (i = 0; i < nr_params; i++, params++)
+		btf_verifier_log(env, ", %u", *params);
+}
+
+static int btf_loc_proto_resolve(struct btf_verifier_env *env,
+				 const struct resolve_vertex *v)
+{
+	const struct btf_type *t = v->t;
+	const __u32 *params = btf_loc_proto_params(t);
+	u32 i, nr_params = btf_type_vlen(t);
+	struct btf *btf = env->btf;
+
+	if (t->type) {
+		btf_verifier_log_type(env, t, "Invalid loc_proto type");
+		return -EINVAL;
+	}
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
+			btf_verifier_log_type(env, t,
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
+__printf(4, 5)
+static void btf_verifier_log_loc(struct btf_verifier_env *env,
+				 const struct btf_type *locsec_type,
+				 const struct btf_loc *loc,
+				 const char *fmt, ...)
+{
+	struct bpf_verifier_log *log = &env->log;
+	va_list args;
+
+	if (!bpf_verifier_log_needed(log))
+		return;
+	if (log->level == BPF_LOG_KERNEL && !fmt)
+		return;
+	if (env->phase != CHECK_META)
+		btf_verifier_log_type(env, locsec_type, NULL);
+
+	__btf_verifier_log(log, "\t func=%u loc_proto=%u offset=%u",
+			   loc->func, loc->loc_proto, loc->offset);
+	if (fmt && *fmt) {
+		__btf_verifier_log(log, " ");
+		va_start(args, fmt);
+		bpf_verifier_vlog(log, fmt, args);
+		va_end(args);
+	}
+
+	__btf_verifier_log(log, "\n");
+}
+
+static s32 btf_locsec_check_meta(struct btf_verifier_env *env,
+				 const struct btf_type *t,
+				 u32 meta_left)
+{
+	u32 i, meta_needed, vlen = btf_type_vlen(t);
+	const struct btf_loc *loc;
+
+	meta_needed = sizeof(struct btf_loc) * vlen;
+
+	if (meta_left < meta_needed) {
+		btf_verifier_log_basic(env, t,
+				       "meta_left:%u meta_needed:%u",
+				       meta_left, meta_needed);
+		return -EINVAL;
+	}
+
+	if (btf_type_kflag(t)) {
+		btf_verifier_log_type(env, t, "Invalid btf_info kind_flag");
+		return -EINVAL;
+	}
+
+	if (!t->name_off ||
+	    !btf_name_valid_section(env->btf, t->name_off)) {
+		btf_verifier_log_type(env, t, "Invalid name");
+		return -EINVAL;
+	}
+
+	for_each_loc(i, t, loc) {
+		/* A loc func, loc proto cannot be in type void */
+		if (!loc->func || !BTF_TYPE_ID_VALID(loc->func)) {
+			btf_verifier_log_loc(env, t, loc, "Invalid func");
+			return -EINVAL;
+		}
+		if (!loc->loc_proto || !BTF_TYPE_ID_VALID(loc->loc_proto)) {
+			btf_verifier_log_loc(env, t, loc, "Invalid loc_proto");
+			return -EINVAL;
+		}
+		btf_verifier_log_loc(env, t, loc, NULL);
+	}
+
+	return meta_needed;
+}
+
+static void btf_locsec_log(struct btf_verifier_env *env,
+			   const struct btf_type *t)
+{
+	btf_verifier_log(env, "vlen=%u", btf_type_vlen(t));
+}
+
+static int btf_locsec_resolve(struct btf_verifier_env *env,
+			      const struct resolve_vertex *v)
+{
+	const struct btf_type *t = v->t;
+	const struct btf_loc *loc;
+	struct btf *btf = env->btf;
+	u32 i;
+
+	if (t->type) {
+		btf_verifier_log_type(env, t, "Invalid locsec type");
+		return -EINVAL;
+	}
+
+	env->resolve_mode = RESOLVE_TBD;
+	for (i = v->next_member, loc = btf_type_loc_secinfo(t) + i;
+	     i < btf_type_vlen(t); i++, loc++) {
+		const struct btf_type *func_type, *loc_proto_type;
+		u32 func_type_id = loc->func;
+		u32 loc_proto_type_id = loc->loc_proto;
+
+		func_type = btf_type_by_id(btf, func_type_id);
+		if (!func_type || !btf_type_is_func(func_type)) {
+			btf_verifier_log_type(env, t,
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
+			btf_verifier_log_type(env, t,
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
@@ -5398,6 +5692,9 @@ static const struct btf_kind_operations * const kind_ops[NR_BTF_KINDS] = {
 	[BTF_KIND_DECL_TAG] = &decl_tag_ops,
 	[BTF_KIND_TYPE_TAG] = &modifier_ops,
 	[BTF_KIND_ENUM64] = &enum64_ops,
+	[BTF_KIND_LOC_PARAM] = &loc_param_ops,
+	[BTF_KIND_LOC_PROTO] = &loc_proto_ops,
+	[BTF_KIND_LOCSEC] = &locsec_ops,
 };
 
 static s32 btf_check_meta(struct btf_verifier_env *env,
@@ -5472,7 +5769,8 @@ static bool btf_resolve_valid(struct btf_verifier_env *env,
 	if (!env_type_is_resolved(env, type_id))
 		return false;
 
-	if (btf_type_is_struct(t) || btf_type_is_datasec(t))
+	if (btf_type_is_struct(t) || btf_type_is_datasec(t) ||
+	    btf_type_is_loc_proto(t) || btf_type_is_locsec(t))
 		return !btf_resolved_type_id(btf, type_id) &&
 		       !btf_resolved_type_size(btf, type_id);
 
diff --git a/tools/include/uapi/linux/btf.h b/tools/include/uapi/linux/btf.h
index 618167cab4e6..a85d293f4127 100644
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
+	__u32 values[];
+};
+
+/*
+ * The combination of size, vlen and flags gives us the means to interpret
+ * the following vlen-specified set of 4-byte values:
+ *
+ * - a BTF_LOC_PARAM_CONST is a constant value; combination
+ *   of size, vlen and _SIGNED flag determines it. If the value requires
+ *   64 bits it is stored in {lo,hi} order.
+ * - a BTF_LOC_PARAM_ADDR|BTF_LOC_PARAM_CONST is an address that should be
+ *   normalized with respect to kernel/module base address.
+ * - a BTF_LOC_PARAM_REG with vlen 1 is a simple register number;
+ *   with vlen 2 it is a multi-register parameter.
+ * - a _REG | OFFSET describes an address without dereferencing it.
+ * - a _REG | DEREF with vlen 1 dereferences the value in the register
+ *   number specified.
+ * - a REG | DEREF | OFFSET with vlen specifies the register value in
+ *   the first 4-byte value and the offset in the remainder.
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
+ * vlen-specified number of __u32 BTF type ids which specify the associated
+ * BTF_KIND_LOC_PARAM for each function parameter associated with the
+ * location.  The type should either be 0 (no location info) or point at
+ * a BTF_KIND_LOC_PARAM.
+ */
+
+/*
+ * BTF_KIND_LOCSEC consists of vlen-specified number of "struct btf_loc"
+ * containing location site-specific information for a specific ELF section;
+ * for example locations in ".text" are in a LOCSEC named "inline.text".
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

