Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69A353B4EB4
	for <bpf@vger.kernel.org>; Fri, 17 Apr 2026 14:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776436253; cv=none; b=kci+gdshdd6Pilh9930DMW6BzlW9rVOKfMiV+9/O5SKjUeBf3VZFCLof4EitBU9GqLhcoKPux2Fwq4ZkkKiFFfX6/4rQgHMCnPaxU2CZQTcbIDNMsFrEgHzKTv7zlF5Ket2z4MTsexF0Mk7rbp45Bgwgv0LUCe+2K01LwpYiVd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776436253; c=relaxed/simple;
	bh=fjB447mZ+uE7470jo0vtkI0KJGTgBKdtKw52yLOgNVw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bfVAo6EPCFr6AXEof/GPkkkJMgTjCOz56kjrxUczwSLLgfQ33S6WguJgIu9DN9s/AzdT8jp7zrbgGujmRYEnCdCrMJ6jld3zvqRmDJmUbOz0uPSUzRAzbumae9fMkvxL2MyhtShemfUejzGjv6Ltwjsq7PfQlJWUHbjoc+w0tfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Qwxkl7fW; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Qwxkl7fW"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63HCfwMp3333888;
	Fri, 17 Apr 2026 14:30:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=3HQ1M
	szlAthqnz955Tka1CiRVrAM+8rebtC4LY0G3EU=; b=Qwxkl7fWCNKhPgMJH7u9B
	4NB7A1359ekisUQfsQl6JKtJd/Gkvc6KBwiDniwwQdo6P1T+720JdrkvhtSMX1G2
	R5LNZBIO66QAMNjpOAd34j1M5bSE2COiN/x8l7sPkSQgsDL3TiN5L8HsJHGlZv8A
	Nm8+uOT4eNFLOHISvlgieS3YLcfRPB5v2DoH/tOACzO1MO3OBwmwQV0S2gZiYcLC
	1EhAtMEisFHAE5JFQQtV68Vjr1UVLx510kQL1w/maqWKRWQhCKgbfBvsZVCHb9ML
	OR3k7YrJTTcPruBpWW4TD4eG5/HUT/vkuqXTMb3MuSOhZ41sTqxJxiJl/MdwsV0Z
	Q==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4dh85qhxby-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 17 Apr 2026 14:30:32 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 63HETR7F027316;
	Fri, 17 Apr 2026 14:30:31 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4dh7nrw8kb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 17 Apr 2026 14:30:30 +0000 (GMT)
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 63HEUSsv033610;
	Fri, 17 Apr 2026 14:30:30 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-53-148.vpn.oracle.com [10.154.53.148])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4dh7nrw8f6-2;
	Fri, 17 Apr 2026 14:30:30 +0000 (GMT)
From: Alan Maguire <alan.maguire@oracle.com>
To: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org
Cc: martin.lau@linux.dev, eddyz87@gmail.com, memxor@gmail.com, song@kernel.org,
        yonghong.song@linux.dev, jolsa@kernel.org, qmo@kernel.org,
        mykyta.yatsenko5@gmail.com, bpf@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v3 bpf-next 1/6] bpf: Extend BTF UAPI vlen, kinds to use unused bits
Date: Fri, 17 Apr 2026 15:30:18 +0100
Message-ID: <20260417143023.1551481-2-alan.maguire@oracle.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE3MDE0NCBTYWx0ZWRfXzUpEu5DrgBwF
 u7PZcOFgHpxPUOBhgBbyKuYYEBammGNa6IUIKJ8SeA9FcHI4NxIuow3ai2SSd4cMgvSLXzsYOKT
 P+ChCbrF4DlunCfghkgBecEFIk8g/GuQks/+n7BTFbqFLAkrCBq3aK0uTolPN8GyjbIr4t4tOCY
 2vEYYy7LnS421XFVzTXq7qm80uFJb9e8uw2JCb9aIOnZ5/WkiE8KAXqrPvvJeq0wWqaya5nnkpf
 9Z1rrMY3jNbU6h81+d1gDDI/3vJhAjUW6dJhBCO4Nl95I9ZFbnATglFpakWQLQkq8iNNVkC6WQG
 fAERwp9bkAwCRF8FUIKErGYoFx9x1lAyLOdkf2gq4k2aHS+Sw3SVxky7mEe0z9Xy47YXJ7QunlU
 2MBk0Y/12j3u1c2ai0uRj77hPEHGgX+Eqk6HfJuOM0Q33pIDcA6ElHtN0+l3tqkeU3ibzAvLtBJ
 ulDcXei4KvDdZrnl0TMfPAKu2wD5JGkak0dajeRE=
X-Proofpoint-GUID: gFJmRK5IEfCy8_wTfcwhak9gmwZUDamP
X-Authority-Analysis: v=2.4 cv=V49NF+ni c=1 sm=1 tr=0 ts=69e24408 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=RD47p0oAkeU5bO7t-o6f:22 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=yPCof4ZbAAAA:8
 a=1uDM8Nt3CRED1N0S9fYA:9 cc=ntf awl=host:13825
X-Proofpoint-ORIG-GUID: gFJmRK5IEfCy8_wTfcwhak9gmwZUDamP

BTF maximum vlen is encoded using 16 bits with a maximum vlen
of 65535.  This has sufficed for structs, function parameters
and enumerated type values.  However, with upcoming BTF location
information - in particular information about inline sites -
this limit is surpassed.  Use bits 16-23 - currently unused in
BTF info - to extend to 24 bits, giving a max vlen of (2^24 - 1),
or 16 million.

Also extend BTF kind encoding from 5 to 7 bits, giving a maximum
available number of kinds of 128.  Since with the BTF location work
we use another 3 kinds, we are fast approaching the current limit
of 32.

Convert BTF_MAX_* values to enums to allow them to be encoded in
kernel BTF; this will allow us to detect if the running kernel
supports a 24-bit vlen or not.  Add one for max _possible_
(not used) kind.

Fix up a few places in the kernel where a 16-bit vlen is assumed;
remove BTF_INFO_MASK as now all bits are used.

The vlen expansion was suggested by Andrii in [1]; the kind expansion
is tackled here too as it may be needed also to support new kinds
in BTF.

[1] https://lore.kernel.org/bpf/CAEf4BzZx=X6vGqcA8SPU6D+v6k+TR=ZewebXMuXtpmML058piw@mail.gmail.com/

Suggested-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 include/linux/btf.h            |  4 ++--
 include/uapi/linux/btf.h       | 26 ++++++++++++++------------
 kernel/bpf/btf.c               | 27 ++++++++++-----------------
 tools/include/uapi/linux/btf.h | 26 ++++++++++++++------------
 4 files changed, 40 insertions(+), 43 deletions(-)

diff --git a/include/linux/btf.h b/include/linux/btf.h
index 48108471c5b1..c82d0d689059 100644
--- a/include/linux/btf.h
+++ b/include/linux/btf.h
@@ -415,12 +415,12 @@ static inline bool btf_type_is_array(const struct btf_type *t)
 	return BTF_INFO_KIND(t->info) == BTF_KIND_ARRAY;
 }
 
-static inline u16 btf_type_vlen(const struct btf_type *t)
+static inline u32 btf_type_vlen(const struct btf_type *t)
 {
 	return BTF_INFO_VLEN(t->info);
 }
 
-static inline u16 btf_vlen(const struct btf_type *t)
+static inline u32 btf_vlen(const struct btf_type *t)
 {
 	return btf_type_vlen(t);
 }
diff --git a/include/uapi/linux/btf.h b/include/uapi/linux/btf.h
index 638615ebddc2..618167cab4e6 100644
--- a/include/uapi/linux/btf.h
+++ b/include/uapi/linux/btf.h
@@ -33,20 +33,22 @@ struct btf_header {
 	__u32	layout_len;	/* length of layout section	*/
 };
 
-/* Max # of type identifier */
-#define BTF_MAX_TYPE	0x000fffff
-/* Max offset into the string section */
-#define BTF_MAX_NAME_OFFSET	0x00ffffff
-/* Max # of struct/union/enum members or func args */
-#define BTF_MAX_VLEN	0xffff
+enum btf_max {
+	/* Max possible kind */
+	BTF_MAX_KIND =		0x0000007f,
+	/* Max # of type identifier */
+	BTF_MAX_TYPE =		0x000fffff,
+	/* Max offset into the string section */
+	BTF_MAX_NAME_OFFSET =	0x00ffffff,
+	/* Max # of struct/union/enum members or func args */
+	BTF_MAX_VLEN =		0x00ffffff,
+};
 
 struct btf_type {
 	__u32 name_off;
 	/* "info" bits arrangement
-	 * bits  0-15: vlen (e.g. # of struct's members)
-	 * bits 16-23: unused
-	 * bits 24-28: kind (e.g. int, ptr, array...etc)
-	 * bits 29-30: unused
+	 * bits  0-23: vlen (e.g. # of struct's members)
+	 * bits 24-30: kind (e.g. int, ptr, array...etc)
 	 * bit     31: kind_flag, currently used by
 	 *             struct, union, enum, fwd, enum64,
 	 *             decl_tag and type_tag
@@ -65,8 +67,8 @@ struct btf_type {
 	};
 };
 
-#define BTF_INFO_KIND(info)	(((info) >> 24) & 0x1f)
-#define BTF_INFO_VLEN(info)	((info) & 0xffff)
+#define BTF_INFO_KIND(info)	(((info) >> 24) & 0x7f)
+#define BTF_INFO_VLEN(info)	((info) & 0xffffff)
 #define BTF_INFO_KFLAG(info)	((info) >> 31)
 
 enum {
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index a62d78581207..fedead837b9a 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -182,7 +182,6 @@
 #define BITS_ROUNDUP_BYTES(bits) \
 	(BITS_ROUNDDOWN_BYTES(bits) + !!BITS_PER_BYTE_MASKED(bits))
 
-#define BTF_INFO_MASK 0x9f00ffff
 #define BTF_INT_MASK 0x0fffffff
 #define BTF_TYPE_ID_VALID(type_id) ((type_id) <= BTF_MAX_TYPE)
 #define BTF_STR_OFFSET_VALID(name_off) ((name_off) <= BTF_MAX_NAME_OFFSET)
@@ -289,7 +288,7 @@ enum verifier_phase {
 struct resolve_vertex {
 	const struct btf_type *t;
 	u32 type_id;
-	u16 next_member;
+	u32 next_member;
 };
 
 enum visit_state {
@@ -2031,7 +2030,7 @@ static int env_stack_push(struct btf_verifier_env *env,
 }
 
 static void env_stack_set_next_member(struct btf_verifier_env *env,
-				      u16 next_member)
+				      u32 next_member)
 {
 	env->stack[env->top_stack - 1].next_member = next_member;
 }
@@ -3293,7 +3292,7 @@ static s32 btf_struct_check_meta(struct btf_verifier_env *env,
 	struct btf *btf = env->btf;
 	u32 struct_size = t->size;
 	u32 offset;
-	u16 i;
+	u32 i;
 
 	meta_needed = btf_type_vlen(t) * sizeof(*member);
 	if (meta_left < meta_needed) {
@@ -3369,7 +3368,7 @@ static int btf_struct_resolve(struct btf_verifier_env *env,
 {
 	const struct btf_member *member;
 	int err;
-	u16 i;
+	u32 i;
 
 	/* Before continue resolving the next_member,
 	 * ensure the last member is indeed resolved to a
@@ -4447,7 +4446,7 @@ static s32 btf_enum_check_meta(struct btf_verifier_env *env,
 	const struct btf_enum *enums = btf_type_enum(t);
 	struct btf *btf = env->btf;
 	const char *fmt_str;
-	u16 i, nr_enums;
+	u32 i, nr_enums;
 	u32 meta_needed;
 
 	nr_enums = btf_type_vlen(t);
@@ -4555,7 +4554,7 @@ static s32 btf_enum64_check_meta(struct btf_verifier_env *env,
 	const struct btf_enum64 *enums = btf_type_enum64(t);
 	struct btf *btf = env->btf;
 	const char *fmt_str;
-	u16 i, nr_enums;
+	u32 i, nr_enums;
 	u32 meta_needed;
 
 	nr_enums = btf_type_vlen(t);
@@ -4683,7 +4682,7 @@ static void btf_func_proto_log(struct btf_verifier_env *env,
 			       const struct btf_type *t)
 {
 	const struct btf_param *args = (const struct btf_param *)(t + 1);
-	u16 nr_args = btf_type_vlen(t), i;
+	u32 nr_args = btf_type_vlen(t), i;
 
 	btf_verifier_log(env, "return=%u args=(", t->type);
 	if (!nr_args) {
@@ -4929,7 +4928,7 @@ static int btf_datasec_resolve(struct btf_verifier_env *env,
 {
 	const struct btf_var_secinfo *vsi;
 	struct btf *btf = env->btf;
-	u16 i;
+	u32 i;
 
 	env->resolve_mode = RESOLVE_TBD;
 	for_each_vsi_from(i, v->next_member, v->t, vsi) {
@@ -5183,7 +5182,7 @@ static int btf_func_proto_check(struct btf_verifier_env *env,
 	const struct btf_type *ret_type;
 	const struct btf_param *args;
 	const struct btf *btf;
-	u16 nr_args, i;
+	u32 nr_args, i;
 	int err;
 
 	btf = env->btf;
@@ -5278,7 +5277,7 @@ static int btf_func_check(struct btf_verifier_env *env,
 	const struct btf_type *proto_type;
 	const struct btf_param *args;
 	const struct btf *btf;
-	u16 nr_args, i;
+	u32 nr_args, i;
 
 	btf = env->btf;
 	proto_type = btf_type_by_id(btf, t->type);
@@ -5336,12 +5335,6 @@ static s32 btf_check_meta(struct btf_verifier_env *env,
 	}
 	meta_left -= sizeof(*t);
 
-	if (t->info & ~BTF_INFO_MASK) {
-		btf_verifier_log(env, "[%u] Invalid btf_info:%x",
-				 env->log_type_id, t->info);
-		return -EINVAL;
-	}
-
 	if (BTF_INFO_KIND(t->info) > BTF_KIND_MAX ||
 	    BTF_INFO_KIND(t->info) == BTF_KIND_UNKN) {
 		btf_verifier_log(env, "[%u] Invalid kind:%u",
diff --git a/tools/include/uapi/linux/btf.h b/tools/include/uapi/linux/btf.h
index 638615ebddc2..618167cab4e6 100644
--- a/tools/include/uapi/linux/btf.h
+++ b/tools/include/uapi/linux/btf.h
@@ -33,20 +33,22 @@ struct btf_header {
 	__u32	layout_len;	/* length of layout section	*/
 };
 
-/* Max # of type identifier */
-#define BTF_MAX_TYPE	0x000fffff
-/* Max offset into the string section */
-#define BTF_MAX_NAME_OFFSET	0x00ffffff
-/* Max # of struct/union/enum members or func args */
-#define BTF_MAX_VLEN	0xffff
+enum btf_max {
+	/* Max possible kind */
+	BTF_MAX_KIND =		0x0000007f,
+	/* Max # of type identifier */
+	BTF_MAX_TYPE =		0x000fffff,
+	/* Max offset into the string section */
+	BTF_MAX_NAME_OFFSET =	0x00ffffff,
+	/* Max # of struct/union/enum members or func args */
+	BTF_MAX_VLEN =		0x00ffffff,
+};
 
 struct btf_type {
 	__u32 name_off;
 	/* "info" bits arrangement
-	 * bits  0-15: vlen (e.g. # of struct's members)
-	 * bits 16-23: unused
-	 * bits 24-28: kind (e.g. int, ptr, array...etc)
-	 * bits 29-30: unused
+	 * bits  0-23: vlen (e.g. # of struct's members)
+	 * bits 24-30: kind (e.g. int, ptr, array...etc)
 	 * bit     31: kind_flag, currently used by
 	 *             struct, union, enum, fwd, enum64,
 	 *             decl_tag and type_tag
@@ -65,8 +67,8 @@ struct btf_type {
 	};
 };
 
-#define BTF_INFO_KIND(info)	(((info) >> 24) & 0x1f)
-#define BTF_INFO_VLEN(info)	((info) & 0xffff)
+#define BTF_INFO_KIND(info)	(((info) >> 24) & 0x7f)
+#define BTF_INFO_VLEN(info)	((info) & 0xffffff)
 #define BTF_INFO_KFLAG(info)	((info) >> 31)
 
 enum {
-- 
2.39.3

