Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 354B33F412D
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 11:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790248510; cv=none; b=tsq3QQ73cTN2ygasjP0KMr4cHaT1pr4DPC8lwVizZGCitOl0htsdAzJcFPRCNmsMmPTktfQZ6wt86OM+XFufftxAXaKP/sCwuj4tf9yhfxJ8U30DW9U850gw3c6L85+HHfOlzEmECXrn1e2Ip+lXBHyXLArqJaF9baf/Rwu9S0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790248510; c=relaxed/simple;
	bh=gZEJKhRsPsEKDfwVDmtJ3L79AQ8Dp79s7pDh6t8SO6c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VGd7iw0wyEwwcne1DTbR5ryp+e6YMHr45vpQDQFitIt7dRM7kIzWocBWfDZ2Anjs7pomtsgOIC705b3AcM5bPC+Nm8G3VVsjJS6r0G9ovyZoH2pi1m4PC3vKkKlsdpJB0T0AOVOz0R/dBbASEpOHh/iZj3vWnjpU5ct0Gxi3YPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=JisH7LeH; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JisH7LeH"
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68O6Cc1v1404039;
	Thu, 24 Sep 2026 11:14:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=x3jpx
	Kv2rS7zCFka7w18GM64/gqPWOwkJFSDysRrfYU=; b=JisH7LeH1O6RdJ1lQFl95
	nxTgMgw1Kuk7dy422+1yYrY8veipVYzEZi3Mcjw36FvdUfezXLMP3YpG8Sz4PC9f
	0bM3EX/7fSlGc/+xxvM4AKx5m99bjrMIl2EbflkA0Vt0S2uCwhBBJBvd5haQYaVc
	kqlvDCXlEMKA+CBoHo7uSXaOCIGDJ2xtnONtG6F8sjQ9Mc1R0sAFYuqHzMdWg1J9
	Q/8S2+i5rG4IDcpZgJQ9mjFugHWwg6kuM5wg+fSsouFa4w8CqBQKllt84mzdhr+q
	1CQR7Nb5Iq/8z2/KYFRPH1zKCr8E5CwJFrl33JtkVRb1JOS0AAODuVKh5udWJdUn
	Q==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4gsk0h7fdn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Sep 2026 11:14:36 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 68OB5XaR013062;
	Thu, 24 Sep 2026 11:14:36 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4guf119kss-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Sep 2026 11:14:36 +0000 (GMT)
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 68OBEVu7002821;
	Thu, 24 Sep 2026 11:14:35 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-80-22.vpn.oracle.com [10.154.80.22])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4guf119knh-2;
	Thu, 24 Sep 2026 11:14:35 +0000 (GMT)
From: Alan Maguire <alan.maguire@oracle.com>
To: ast@kernel.org, andrii@kernel.org, eddyz87@gmail.com, qmo@kernel.org
Cc: jolsa@kernel.org, daniel@iogearbox.net, ihor.solodrai@linux.dev,
        yonghong.song@linux.dev, song@kernel.org, martin.lau@linux.dev,
        memxor@gmail.com, emil@etsalapatis.com, bpf@vger.kernel.org,
        nsc@kernel.org, puranjay@kernel.org, yatsenko@meta.com,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v4 bpf-next 01/11] btf: Extend UAPI to support BTF location (inline site) info
Date: Thu, 24 Sep 2026 12:14:18 +0100
Message-ID: <20260924111428.75957-2-alan.maguire@oracle.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDA0NiBTYWx0ZWRfXyhdu5jM/7Hw5
 zzpQH6RauqwtP0wRzut7vXw4JxwH08OxwY0A43nADiGgUoZZeGNZYD5Ise0iermvjgk3KNfOVkK
 qRsXKg/PyhMCJLpOL6XfRgSZi214SThrODcvNIu/Ifh7u0FiAVSA
X-Proofpoint-GUID: KbMe3TRE4nPfHDaXi_yRCA-x3HNaLlms
X-Authority-Analysis: v=2.4 cv=CNa/zhrD c=1 sm=1 tr=0 ts=6ab5061c b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=BqU2WV_vvsyTyxaotp0D:22 a=yPCof4ZbAAAA:8 a=pGLkceISAAAA:8
 a=CnholuigF2EZAvaUiV8A:9 a=O8hF6Hzn-FEA:10 a=5yU3S35YU4bGjq-dph-N:22
 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:12106
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDA0NiBTYWx0ZWRfX8eTkbYC3TYQH
 ARS6KL6IEZth41Ca95WJhN9+Nu5nElrEMDZ9rJXD4EcZOu8k4KlPr+UmewdBkXtb/1OyBMj9ZPP
 WKLWM3WnHKLlQD1fTzr1wto7J3zq0wbuQ8vWoeeh4QXtPlbYJHbsQgIm6Ti2c1p2KO8vekHO9eD
 vJH7SPVdvgXT7g5lLkTxE1tybNP56iwOHUL5QcyGaqUCAok6yoPOxxZ9hjpyH0FNHTjqeRP8+mw
 vc8TH3EZb8fhRVCHnMSXhZhRraMJ74VSnbQAYTUy46zWuCX+5/Hc1qKaOA9BbGf8MJ77sEpAokf
 X8S1SndIYO+dG+TBEi2XEUzFX0shiN/33EoPR8K1KHvx2aiaLDclZztXrkfkwKuLlvpEEIbf4cx
 IuQXJTlU/831SWpJNNW96SSiszBYapEsqEOGaGFj261ZNzGsORllPT9CWDOH7Oz+PnvGpfrcXXi
 7eKv0dJYIpp/Wfqk62cAzGZQ19kabXwVjKaoOVlE=
X-Proofpoint-ORIG-GUID: KbMe3TRE4nPfHDaXi_yRCA-x3HNaLlms

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
 include/uapi/linux/btf.h       |  83 ++++++++-
 kernel/bpf/btf.c               | 322 ++++++++++++++++++++++++++++++++-
 tools/include/uapi/linux/btf.h |  83 ++++++++-
 4 files changed, 499 insertions(+), 11 deletions(-)

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
index 618167cab4e6..11d65871d163 100644
--- a/include/uapi/linux/btf.h
+++ b/include/uapi/linux/btf.h
@@ -54,8 +54,8 @@ struct btf_type {
 	 *             decl_tag and type_tag
 	 */
 	__u32 info;
-	/* "size" is used by INT, ENUM, STRUCT, UNION, DATASEC and ENUM64.
-	 * "size" tells the size of the type it is describing.
+	/* "size" is used by INT, ENUM, STRUCT, UNION, DATASEC, ENUM64
+	 * and LOC_PARAM. "size" tells the size of the type it is describing.
 	 *
 	 * "type" is used by PTR, TYPEDEF, VOLATILE, CONST, RESTRICT,
 	 * FUNC, FUNC_PROTO, VAR, DECL_TAG and TYPE_TAG.
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
@@ -212,4 +214,79 @@ struct btf_enum64 {
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
+ *   with vlen 2 it is a multi-register parameter.  Register numbers are
+ *   numbers derived from DW_OP_reg values, i.e. 0 is DW_OP_reg0; since
+ *   DW_OP_fbreg has its own special DW_OP_value and DW_OP_regx can refer
+ *   to an arbitrary register number, we reserve BTF_LOC_PARAM_FBREG for
+ *   the frame base register to avoid collisions.
+ * - a _REG | OFFSET describes an address without dereferencing it.
+ * - a _REG | DEREF with vlen 1 dereferences the value in the register
+ *   number specified.
+ * - a REG | DEREF | OFFSET with vlen > 1 specifies the register number
+ *   in the first 4-byte value and the offset in the remainder.
+ *   In the case of REG and OFFSET combinations, the OFFSET has the width
+ *   of the value words while the type size describes the represented parameter,
+ *   so for example a REG | DEREF | OFFSET with size 8 and vlen 2 would be
+ *   an 8-byte register dereference with signed 4-byte offset, since the vlen 2
+ *   values consist of a register value and the signed value.
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
+enum {
+	BTF_LOC_PARAM_FBREG		=	0xffffffff
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
+ * - address offset (offset) relative to the runtime base address of the
+ *   ELF section associated with the LOCSEC
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
index 314ecb0e593b..2ef28c6f14f9 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -346,6 +346,9 @@ static const char * const btf_kind_str[NR_BTF_KINDS] = {
 	[BTF_KIND_DECL_TAG]	= "DECL_TAG",
 	[BTF_KIND_TYPE_TAG]	= "TYPE_TAG",
 	[BTF_KIND_ENUM64]	= "ENUM64",
+	[BTF_KIND_LOC_PARAM]	= "LOC_PARAM",
+	[BTF_KIND_LOC_PROTO]	= "LOC_PROTO",
+	[BTF_KIND_LOCSEC]	= "LOCSEC",
 };
 
 const char *btf_type_str(const struct btf_type *t)
@@ -518,11 +521,27 @@ static bool btf_type_is_decl_tag(const struct btf_type *t)
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
@@ -769,7 +788,9 @@ static bool btf_type_is_resolve_source_only(const struct btf_type *t)
 {
 	return btf_type_is_var(t) ||
 	       btf_type_is_decl_tag(t) ||
-	       btf_type_is_datasec(t);
+	       btf_type_is_datasec(t) ||
+	       btf_type_is_loc_proto(t) ||
+	       btf_type_is_locsec(t);
 }
 
 /* What types need to be resolved?
@@ -797,7 +818,9 @@ static bool btf_type_needs_resolve(const struct btf_type *t)
 	       btf_type_is_var(t) ||
 	       btf_type_is_func(t) ||
 	       btf_type_is_decl_tag(t) ||
-	       btf_type_is_datasec(t);
+	       btf_type_is_datasec(t) ||
+	       btf_type_is_loc_proto(t) ||
+	       btf_type_is_locsec(t);
 }
 
 /* t->size can be used */
@@ -4730,6 +4753,293 @@ static const struct btf_kind_operations enum64_ops = {
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
+	if (!size || size > 16) {
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
+		const struct btf_type *func_type, *func_proto_type;
+		const struct btf_type *loc_proto_type;
+		u32 func_type_id = loc->func;
+		u32 loc_proto_type_id = loc->loc_proto;
+		u32 proto_vlen;
+
+		func_type = btf_type_by_id(btf, func_type_id);
+		if (!func_type || !btf_type_is_func(func_type)) {
+			btf_verifier_log_type(env, t,
+					      "Invalid func#%u", i + 1);
+			return -EINVAL;
+		}
+		func_proto_type = btf_type_by_id(btf, func_type->type);
+		if (!func_proto_type || !btf_type_is_func_proto(func_proto_type)) {
+			btf_verifier_log_type(env, t,
+					      "Invalid func#%u", i + 1);
+			return -EINVAL;
+		}
+		proto_vlen = btf_vlen(func_proto_type);
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
+		if (proto_vlen != btf_vlen(loc_proto_type)) {
+			btf_verifier_log_type(env, t,
+					      "Mismatched vlen for loc_proto#%u", i + 1);
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
@@ -5399,6 +5709,9 @@ static const struct btf_kind_operations * const kind_ops[NR_BTF_KINDS] = {
 	[BTF_KIND_DECL_TAG] = &decl_tag_ops,
 	[BTF_KIND_TYPE_TAG] = &modifier_ops,
 	[BTF_KIND_ENUM64] = &enum64_ops,
+	[BTF_KIND_LOC_PARAM] = &loc_param_ops,
+	[BTF_KIND_LOC_PROTO] = &loc_proto_ops,
+	[BTF_KIND_LOCSEC] = &locsec_ops,
 };
 
 static s32 btf_check_meta(struct btf_verifier_env *env,
@@ -5473,7 +5786,8 @@ static bool btf_resolve_valid(struct btf_verifier_env *env,
 	if (!env_type_is_resolved(env, type_id))
 		return false;
 
-	if (btf_type_is_struct(t) || btf_type_is_datasec(t))
+	if (btf_type_is_struct(t) || btf_type_is_datasec(t) ||
+	    btf_type_is_loc_proto(t) || btf_type_is_locsec(t))
 		return !btf_resolved_type_id(btf, type_id) &&
 		       !btf_resolved_type_size(btf, type_id);
 
diff --git a/tools/include/uapi/linux/btf.h b/tools/include/uapi/linux/btf.h
index 618167cab4e6..11d65871d163 100644
--- a/tools/include/uapi/linux/btf.h
+++ b/tools/include/uapi/linux/btf.h
@@ -54,8 +54,8 @@ struct btf_type {
 	 *             decl_tag and type_tag
 	 */
 	__u32 info;
-	/* "size" is used by INT, ENUM, STRUCT, UNION, DATASEC and ENUM64.
-	 * "size" tells the size of the type it is describing.
+	/* "size" is used by INT, ENUM, STRUCT, UNION, DATASEC, ENUM64
+	 * and LOC_PARAM. "size" tells the size of the type it is describing.
 	 *
 	 * "type" is used by PTR, TYPEDEF, VOLATILE, CONST, RESTRICT,
 	 * FUNC, FUNC_PROTO, VAR, DECL_TAG and TYPE_TAG.
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
@@ -212,4 +214,79 @@ struct btf_enum64 {
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
+ *   with vlen 2 it is a multi-register parameter.  Register numbers are
+ *   numbers derived from DW_OP_reg values, i.e. 0 is DW_OP_reg0; since
+ *   DW_OP_fbreg has its own special DW_OP_value and DW_OP_regx can refer
+ *   to an arbitrary register number, we reserve BTF_LOC_PARAM_FBREG for
+ *   the frame base register to avoid collisions.
+ * - a _REG | OFFSET describes an address without dereferencing it.
+ * - a _REG | DEREF with vlen 1 dereferences the value in the register
+ *   number specified.
+ * - a REG | DEREF | OFFSET with vlen > 1 specifies the register number
+ *   in the first 4-byte value and the offset in the remainder.
+ *   In the case of REG and OFFSET combinations, the OFFSET has the width
+ *   of the value words while the type size describes the represented parameter,
+ *   so for example a REG | DEREF | OFFSET with size 8 and vlen 2 would be
+ *   an 8-byte register dereference with signed 4-byte offset, since the vlen 2
+ *   values consist of a register value and the signed value.
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
+enum {
+	BTF_LOC_PARAM_FBREG		=	0xffffffff
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
+ * - address offset (offset) relative to the runtime base address of the
+ *   ELF section associated with the LOCSEC
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

