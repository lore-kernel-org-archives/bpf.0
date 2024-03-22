Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B62C383B9
	for <bpf@vger.kernel.org>; Fri, 22 Mar 2024 10:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711103183; cv=none; b=YhlHwK7n0MOMN74Z8EHmyyTLaWoliWwUtweTHQQ2J9/5aH38q/1aNm14rQzdnLWYc1qyVwaP5+g7se+wiYkBlixolMVmOuTpPPc1syI70K3P3cEOYyKBhrKAzwzKt9szo0YtR6sF3dfk+VBdsMuFPjHpPG9ggycdRCBIsmRnxNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711103183; c=relaxed/simple;
	bh=4ZMB9i//Ed5xTFoHN97k//M3xd6QjwF6ADnFZWsFb8Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Q3tkySnMR+onLCWZV9de8m0KJCeV7zacRB2IDLYorhXs7qeoHabWgDnUi5SvRPzsMgrfJNwuzwYR2vtvEjcwT2qa+7ChVSiKV50OOjHk34x1Kc0CH+H+/Gu/Cdg50sEjahkXRL/MUTbceIkWftUWmka34kQxzQjWgfeoSyCl1k4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=d3/oS6SW; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="d3/oS6SW"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42M7YRcE008468;
	Fri, 22 Mar 2024 10:25:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-11-20;
 bh=4vDSKZ3PG0G18DqkeL9H36+H6gB7S95h651h3F3DtA8=;
 b=d3/oS6SWpGnEoYtzttaQ7i+ImEaLSJIE1/trTNeDhLzlpGTR10PDm7gdZJnWazb5lFW3
 diHAYGjn+yMDAIUFoXUL2AicPoTY00F81TwCXGomRDcQU3c57Qq45LlJDmGoKYX1Poik
 nqMHrLKIPlo91v22PdXopVm1v+EtoFIyqHY+W7YaL7ZmYicr4Sdu+QpQkT7owxPxcRM6
 0ZZy+VVtDXRlXl256QGd0EMrQYMMT9KMCnJsE810Y8hlponeef8jS8DvUeHQNKlI2d5Q
 /q/nWohjpX0d4dquii0tUm19VmZL0ups1HAX75aEnuaRjnrZ3PL6f1anh1Lh/2s4Srpa CQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3x0wvm8s7j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 22 Mar 2024 10:25:53 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42MALIoO014360;
	Fri, 22 Mar 2024 10:25:52 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3x0wvk2j73-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 22 Mar 2024 10:25:52 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 42MAK0kh030399;
	Fri, 22 Mar 2024 10:25:51 GMT
Received: from bpf.uk.oracle.com (dhcp-10-175-192-105.vpn.oracle.com [10.175.192.105])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3x0wvk2h75-11;
	Fri, 22 Mar 2024 10:25:50 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: andrii@kernel.org, jolsa@kernel.org, acme@redhat.com,
        quentin@isovalent.com
Cc: eddyz87@gmail.com, mykolal@fb.com, ast@kernel.org, daniel@iogearbox.net,
        martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, houtao1@huawei.com, bpf@vger.kernel.org,
        masahiroy@kernel.org, mcgrof@kernel.org, nathan@kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [RFC bpf-next 09/13] libbpf: split BTF reconciliation
Date: Fri, 22 Mar 2024 10:24:51 +0000
Message-Id: <20240322102455.98558-11-alan.maguire@oracle.com>
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
X-Proofpoint-GUID: EapgafgKxntXa1LOYjCrd-3UYYK8hPav
X-Proofpoint-ORIG-GUID: EapgafgKxntXa1LOYjCrd-3UYYK8hPav

Map base reference BTF type ids referenced in split BTF and their
references to the base BTF passed in, and if the mapping succeeds,
reparent the split BTF to the base BTF.

Reconciliation rules are

- base types must match exactly
- enum[64] types should match all value name/value pairs, but the
  to-be-reconciled enum[64] can also define additional name/value pairs
- named fwds match to the correspondingly-named struct/union/enum/enum64
- anon struct/unions must have field names/offsets specified in base
  reference BTF matched by those in base BTF we are matching with

Reconciliation can not recurse, since it will be used in-kernel also and
we do not want to blow up the kernel stack when carrying out type
compatibility checks.  Hence we use a stack for reference type
reconciliation rather then recursive function calls.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 tools/lib/bpf/Build             |   2 +-
 tools/lib/bpf/btf.c             |  58 ++++
 tools/lib/bpf/btf.h             |   8 +
 tools/lib/bpf/btf_reconcile.c   | 590 ++++++++++++++++++++++++++++++++
 tools/lib/bpf/libbpf.map        |   1 +
 tools/lib/bpf/libbpf_internal.h |   2 +
 6 files changed, 660 insertions(+), 1 deletion(-)
 create mode 100644 tools/lib/bpf/btf_reconcile.c

diff --git a/tools/lib/bpf/Build b/tools/lib/bpf/Build
index b6619199a706..c05cc524ca30 100644
--- a/tools/lib/bpf/Build
+++ b/tools/lib/bpf/Build
@@ -1,4 +1,4 @@
 libbpf-y := libbpf.o bpf.o nlattr.o btf.o libbpf_errno.o str_error.o \
 	    netlink.o bpf_prog_linfo.o libbpf_probes.o hashmap.o \
 	    btf_dump.o ringbuf.o strset.o linker.o gen_loader.o relo_core.o \
-	    usdt.o zip.o elf.o features.o
+	    usdt.o zip.o elf.o features.o btf_reconcile.o
diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index d43c3eba27e0..09a11954cad8 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -5432,3 +5432,61 @@ struct btf *btf__new_split_base_ref(struct btf *src_btf)
 		errno = -ret;
 	return NULL;
 }
+
+struct btf_rewrite_strs {
+	struct btf *btf;
+	const struct btf *old_base_btf;
+	int str_start;
+	int str_diff;
+};
+
+static int btf_rewrite_strs(__u32 *str_off, void *ctx)
+{
+	struct btf_rewrite_strs *r = ctx;
+	const char *s;
+	int off;
+
+	if (!*str_off)
+		return 0;
+	if (*str_off >= r->str_start) {
+		*str_off += r->str_diff;
+	} else {
+		s = btf__str_by_offset(r->old_base_btf, *str_off);
+		if (!s)
+			return -ENOENT;
+		off = btf__add_str(r->btf, s);
+		if (off < 0)
+			return off;
+		*str_off = off;
+	}
+	return 0;
+}
+
+int btf_set_base_btf(struct btf *btf, struct btf *base_btf)
+{
+	struct btf_rewrite_strs r = {};
+	struct btf_type *t;
+	int i, err;
+
+	r.old_base_btf = btf__base_btf(btf);
+	if (!r.old_base_btf)
+		return -EINVAL;
+	r.btf = btf;
+	r.str_start = r.old_base_btf->hdr->str_len;
+	r.str_diff = base_btf->hdr->str_len - r.old_base_btf->hdr->str_len;
+	btf->base_btf = base_btf;
+	btf->start_id = btf__type_cnt(base_btf);
+	btf->start_str_off = base_btf->hdr->str_len;
+	for (i = 0; i < btf->nr_types; i++) {
+		t = (struct btf_type *)btf__type_by_id(btf, i + btf->start_id);
+		err = btf_type_visit_str_offs((struct btf_type *)t, btf_rewrite_strs, &r);
+		if (err)
+			break;
+	}
+	return err;
+}
+
+int btf__reconcile(struct btf *btf, const struct btf *base_btf)
+{
+	return btf_reconcile(btf, base_btf, NULL);
+}
diff --git a/tools/lib/bpf/btf.h b/tools/lib/bpf/btf.h
index c63043520149..4cda17cbcde9 100644
--- a/tools/lib/bpf/btf.h
+++ b/tools/lib/bpf/btf.h
@@ -279,6 +279,14 @@ struct btf_dedup_opts {
 
 LIBBPF_API int btf__dedup(struct btf *btf, const struct btf_dedup_opts *opts);
 
+/**
+ * @brief **btf__reconcile()** will check the split BTF *btf* for references
+ * to base BTF kinds, and verify those references are compatible with
+ * *base_btf*; if they are, *btf* is adjusted such that is re-parented to
+ * *base_btf* and type ids and strings are adjusted to accommodate this.
+ */
+LIBBPF_API int btf__reconcile(struct btf *btf, const struct btf *base_btf);
+
 struct btf_dump;
 
 struct btf_dump_opts {
diff --git a/tools/lib/bpf/btf_reconcile.c b/tools/lib/bpf/btf_reconcile.c
new file mode 100644
index 000000000000..84787328a1de
--- /dev/null
+++ b/tools/lib/bpf/btf_reconcile.c
@@ -0,0 +1,590 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2024, Oracle and/or its affiliates. */
+
+#include "btf.h"
+#include "bpf.h"
+#include "libbpf.h"
+#include "libbpf_internal.h"
+
+struct btf;
+
+#define BTF_MAX_NR_TYPES 0x7fffffffU
+#define BTF_UNPROCESSED_ID ((__u32)-1)
+
+struct btf_reconcile {
+	struct btf *btf;
+	const struct btf *base_btf;
+	const struct btf *base_ref_btf;
+	unsigned int nr_base_types;
+	__u32 *map;
+	__u32 *stack;
+	unsigned int stack_size;
+	unsigned int stack_limit;
+};
+
+/* Find next type after *id in base BTF that matches kind of type t passed in
+ * and name (if it is specified).  Match fwd kinds to appropriate kind also.
+ */
+static int btf_reconcile_find_next(struct btf_reconcile *r, const struct btf_type *t,
+				   __u32 *id, const struct btf_type **tp)
+{
+	const struct btf_type *nt;
+	int kind, tkind = btf_kind(t);
+	int tkflag = btf_kflag(t);
+	__u32 i;
+
+	for (i = *id + 1; i < r->nr_base_types; i++) {
+		nt = btf__type_by_id(r->base_btf, i);
+		kind = btf_kind(nt);
+		if (tkind != BTF_KIND_FWD) {
+			if (kind != tkind)
+				continue;
+		} else  {
+			switch (kind) {
+			case BTF_KIND_FWD:
+				continue;
+			case BTF_KIND_STRUCT:
+				if (tkflag)
+					continue;
+				break;
+			case BTF_KIND_UNION:
+				if (!tkflag)
+					continue;
+				break;
+			default:
+				break;
+			}
+		}
+		/* either names must match or both be anon. */
+		if (t->name_off && nt->name_off) {
+			if (strcmp(btf__name_by_offset(r->btf, t->name_off),
+				   btf__name_by_offset(r->base_btf, nt->name_off)))
+				continue;
+		} else if (t->name_off != nt->name_off) {
+			continue;
+		}
+		*tp = nt;
+		*id = i;
+		return 0;
+	}
+	return -ENOENT;
+}
+
+static int btf_reconcile_int(struct btf_reconcile *r, const char *name,
+			     const struct btf_type *t, const struct btf_type *bt)
+{
+	__u32 *info = (__u32 *)(t + 1);
+	__u32 *binfo = (__u32 *)(bt + 1);
+
+	if (t->size != bt->size) {
+		pr_warn("INT types '%s' disagree on size; reference base BTF says %d; base BTF says %d\n",
+			name, t->size, bt->size);
+		return -EINVAL;
+	}
+	if (BTF_INT_ENCODING(*info) != BTF_INT_ENCODING(*binfo)) {
+		pr_warn("INT types '%s' disagree on encoding; reference base BTF says '(%s/%s/%s); base BTF says '(%s/%s/%s)'\n",
+			name,
+			BTF_INT_ENCODING(*info) & BTF_INT_SIGNED ? "signed" : "unsigned",
+			BTF_INT_ENCODING(*info) & BTF_INT_CHAR ? "char" : "nonchar",
+			BTF_INT_ENCODING(*info) & BTF_INT_BOOL ? "bool" : "nonbool",
+			BTF_INT_ENCODING(*binfo) & BTF_INT_SIGNED ? "signed" : "unsigned",
+			BTF_INT_ENCODING(*binfo) & BTF_INT_CHAR ? "char" : "nonchar",
+			BTF_INT_ENCODING(*binfo) & BTF_INT_BOOL ? "bool" : "nonbool");
+		return -EINVAL;
+	}
+	if (BTF_INT_BITS(*info) != BTF_INT_BITS(*binfo)) {
+		pr_warn("INT types '%s' disagree on bit size; reference base BTF says %d; base BTF says %d\n",
+			name, BTF_INT_BITS(*info), BTF_INT_BITS(*binfo));
+		return -EINVAL;
+	}
+	return 0;
+}
+
+static int btf_reconcile_float(struct btf_reconcile *r, const char *name,
+			       const struct btf_type *t, const struct btf_type *bt)
+{
+
+	if (t->size != bt->size) {
+		pr_warn("float types '%s' disagree on size; reference base BTF says %d; base BTF says %d\n",
+			name, t->size, bt->size);
+		return -EINVAL;
+	}
+	return 0;
+}
+
+/* Ensure each enum value in type t has equivalent in base BTF and that values (if any) match. */
+static int btf_reconcile_enum(struct btf_reconcile *r, const char *name,
+			      const struct btf_type *t, const struct btf_type *bt)
+{
+	struct btf_enum *v = (struct btf_enum *)(t + 1);
+	struct btf_enum *bv = (struct btf_enum *)(bt + 1);
+	bool found, match;
+	int i, j;
+
+	for (i = 0; i < btf_vlen(t); i++, v++) {
+		found = match = false;
+
+		if (!v->name_off)
+			continue;
+		for (j = 0; j < btf_vlen(bt); j++, bv++) {
+			if (!bv->name_off)
+				continue;
+			if (strcmp(btf__name_by_offset(r->base_ref_btf, v->name_off),
+				   btf__name_by_offset(r->base_btf, bv->name_off)) != 0)
+				continue;
+			found = true;
+			match = (v->val == bv->val);
+			break;
+		}
+		if (!found) {
+			if (t->name_off)
+				pr_warn("ENUM types '%s' disagree; base reference BTF has enum value '%s' (%d), base BTF does not have that value.\n",
+					name,
+					btf__name_by_offset(r->base_ref_btf, v->name_off),
+					v->val);
+			return -EINVAL;
+		}
+		if (!match) {
+			if (t->name_off)
+				pr_warn("ENUM types '%s' disagree on enum value '%s'; reference base BTF specifies value %d; base BTF specifies value %d\n",
+					name,
+					btf__name_by_offset(r->base_ref_btf, v->name_off),
+					v->val, bv->val);
+			return -EINVAL;
+		}
+	}
+	return 0;
+}
+
+/* ensure each enum64 value in type t has equivalent in base BTF and that values match */
+static int btf_reconcile_enum64(struct btf_reconcile *r, const char *name,
+			      const struct btf_type *t, const struct btf_type *bt)
+{
+	struct btf_enum64 *v = (struct btf_enum64 *)(t + 1);
+	struct btf_enum64 *bv = (struct btf_enum64 *)(bt + 1);
+	bool found, match;
+	int i, j;
+
+	for (i = 0; i < btf_vlen(t); i++, v++) {
+		found = match = false;
+
+		if (!v->name_off)
+			continue;
+		for (j = 0; j < btf_vlen(bt); j++, bv++) {
+			if (!bv->name_off)
+				continue;
+			if (strcmp(btf__name_by_offset(r->base_ref_btf, v->name_off),
+				   btf__name_by_offset(r->base_btf, bv->name_off)) != 0)
+				continue;
+			found = true;
+			match = (btf_enum64_value(v) == btf_enum64_value(bv));
+			break;
+		}
+		if (!found) {
+			if (t->name_off)
+				pr_warn("ENUM64 types '%s' disagree; reference base BTF has enum64 value '%s' (%lld), base BTF does not have that value.\n",
+					name, btf__name_by_offset(r->base_ref_btf, v->name_off),
+					btf_enum64_value(v));
+			return -EINVAL;
+		}
+		if (!match) {
+			if (t->name_off)
+				pr_warn("ENUM64 types '%s' disagree on enum value '%s'; reference base BTF specifies value %lld; base BTF specifies value %lld\n",
+					name, btf__name_by_offset(r->base_ref_btf, v->name_off),
+					btf_enum64_value(v), btf_enum64_value(bv));
+			return -EINVAL;
+		}
+	}
+	return 0;
+}
+
+/* reconcile base types (int, float, enum, enum64 and fwd) */
+static int btf_reconcile_base_type(struct btf_reconcile *r, __u32 id)
+{
+	const struct btf_type *t = btf_type_by_id(r->base_ref_btf, id);
+	const char *name = btf__name_by_offset(r->base_ref_btf, t->name_off);
+	const struct btf_type *bt = NULL;
+	__u32 base_id = 0;
+	int err = 0;
+
+	switch (btf_kind(t)) {
+	case BTF_KIND_INT:
+	case BTF_KIND_ENUM:
+	case BTF_KIND_FLOAT:
+	case BTF_KIND_ENUM64:
+	case BTF_KIND_FWD:
+		break;
+	default:
+		return 0;
+	}
+
+	if (r->map[id] <= BTF_MAX_NR_TYPES)
+		return 0;
+
+	while ((err = btf_reconcile_find_next(r, t, &base_id, &bt)) != -ENOENT) {
+		bt = btf_type_by_id(r->base_btf, base_id);
+		switch (btf_kind(t)) {
+		case BTF_KIND_INT:
+			err = btf_reconcile_int(r, name, t, bt);
+			break;
+		case BTF_KIND_ENUM:
+			err = btf_reconcile_enum(r, name, t, bt);
+			break;
+		case BTF_KIND_FLOAT:
+			err = btf_reconcile_float(r, name, t, bt);
+			break;
+		case BTF_KIND_ENUM64:
+			err = btf_reconcile_enum64(r, name, t, bt);
+			break;
+		case BTF_KIND_FWD:
+			err = 0;
+			break;
+		default:
+			return 0;
+		}
+		if (!err) {
+			r->map[id] = base_id;
+			return 0;
+		}
+	}
+	return err;
+}
+
+/* all reference BTF members must be in base BTF equivalent. */
+static int btf_reconcile_check_member(struct btf_reconcile *r, const char *name,
+				      struct btf_member *m, const struct btf_type *bt,
+				      bool verbose)
+{
+	struct btf_member *bm = (struct btf_member *)(bt + 1);
+	const char *kindstr = btf_kind(bt) == BTF_KIND_STRUCT ? "STRUCT" : "UNION";
+	const char *mname, *bmname;
+	int i, bvlen = btf_vlen(bt);
+
+	mname = btf__name_by_offset(r->base_ref_btf, m->name_off);
+	for (i = 0; i < bvlen; i++, bm++) {
+		bmname = btf__name_by_offset(r->base_btf, bm->name_off);
+
+		if (!m->name_off || !bm->name_off) {
+			if (m->name_off != bm->name_off)
+				continue;
+			if (bm->offset != m->offset)
+				continue;
+		} else {
+			if (strcmp(mname, bmname) != 0)
+				continue;
+			if (bm->offset != m->offset) {
+				if (verbose) {
+					pr_warn("%s '%s' member '%s' disagrees about offset; %d in base reference BTF versus %d in base BTF\n",
+						kindstr, name, mname, bm->offset, m->offset);
+					return -EINVAL;
+				}
+			}
+		}
+		return 0;
+	}
+	if (verbose)
+		pr_warn("%s '%s' missing member '%s' found in base reference BTF\n",
+			kindstr, name, mname);
+	return -EINVAL;
+}
+
+static int btf_reconcile_struct_type(struct btf_reconcile *r, __u32 id)
+{
+	const struct btf_type *t = btf_type_by_id(r->base_ref_btf, id);
+	const char *name = btf__name_by_offset(r->base_ref_btf, t->name_off);
+	const struct btf_type *bt = NULL;
+	struct btf_member *m;
+	const char *kindstr;
+	int i, vlen, err = 0;
+	__u32 base_id = 0;
+
+	switch (btf_kind(t)) {
+	case BTF_KIND_STRUCT:
+		kindstr = "STRUCT";
+		break;
+	case BTF_KIND_UNION:
+		kindstr = "UNION";
+		break;
+	default:
+		return 0;
+	}
+
+	if (r->map[id] <= BTF_MAX_NR_TYPES)
+		return 0;
+
+	vlen = btf_vlen(t);
+
+	while ((err = btf_reconcile_find_next(r, t, &base_id, &bt)) != -ENOENT) {
+		/* must be at least as big */
+		if (bt->size < t->size) {
+			if (t->name_off) {
+				pr_warn("%s '%s' disagrees about size with reference base BTF (%d); base BTF is smaller (%d)\n",
+					kindstr, name, t->size, bt->size);
+				return -EINVAL;
+			}
+			continue;
+		}
+		/* must have at least as many elements */
+		if (btf_vlen(bt) < vlen) {
+			if (t->name_off) {
+				pr_warn("%s '%s' disagrees about number of members with reference base BTF (%d); base BTF has less (%d)\n",
+					kindstr, name, vlen, btf_vlen(bt));
+				return -EINVAL;
+			}
+			continue;
+		}
+		m = (struct btf_member *)(t + 1);
+		for (i = 0; i < vlen; i++, m++) {
+			if (btf_reconcile_check_member(r, name, m, bt, t->name_off != 0)) {
+				if (t->name_off)
+					return -EINVAL;
+				err = -EINVAL;
+				break;
+			}
+		}
+		if (!err) {
+			r->map[id] = base_id;
+			return 0;
+		}
+	}
+	return err;
+}
+
+/* Use a stack rather than recursion to manage dependent reference types.
+ * When a reference type with dependents is encountered, the approach we
+ * take depends on whether the dependents have been resolved to base
+ * BTF references via the map[].  If they all have, we can simply search
+ * for the base BTF type that has those references.  If the references
+ * are not resolved, we need to push the type and its dependents onto
+ * the stack for later resolution.  We first pop the dependents, and
+ * once these have been resolved we pop the reference type with dependents
+ * now resolved.
+ */
+static int btf_reconcile_push(struct btf_reconcile *r, __u32 id)
+{
+	if (r->stack_size >= r->stack_limit)
+		return -ENOSPC;
+	r->stack[r->stack_size++] = id;
+	return 0;
+}
+
+static __u32 btf_reconcile_pop(struct btf_reconcile *r)
+{
+	if (r->stack_size > 0)
+		return r->stack[--r->stack_size];
+	return BTF_UNPROCESSED_ID;
+}
+
+static int btf_reconcile_ref_type(struct btf_reconcile *r, __u32 id)
+{
+	const struct btf_type *t;
+	const struct btf_type *bt;
+	__u32 base_id;
+	int err = 0;
+
+	do {
+		if (r->map[id] <= BTF_MAX_NR_TYPES)
+			continue;
+		t = btf_type_by_id(r->base_ref_btf, id);
+		switch (btf_kind(t)) {
+		case BTF_KIND_CONST:
+		case BTF_KIND_VOLATILE:
+		case BTF_KIND_RESTRICT:
+		case BTF_KIND_PTR:
+		case BTF_KIND_TYPEDEF:
+		case BTF_KIND_FUNC:
+		case BTF_KIND_TYPE_TAG:
+		case BTF_KIND_DECL_TAG:
+			if (r->map[t->type] <= BTF_MAX_NR_TYPES) {
+				bt = NULL;
+				base_id = 0;
+				while ((err = btf_reconcile_find_next(r, t, &base_id, &bt))
+				       != -ENOENT) {
+					if (btf_kind(t) == BTF_KIND_DECL_TAG) {
+						if (btf_decl_tag(t) != btf_decl_tag(bt))
+							continue;
+					}
+					if (bt->type != r->map[t->type])
+						continue;
+					r->map[id] = base_id;
+					break;
+				}
+				if (err) {
+					pr_warn("could not find base BTF type for base reference type[%u]\n",
+						id);
+					return err;
+				}
+			} else {
+				if (btf_reconcile_push(r, id) < 0 ||
+				    btf_reconcile_push(r, t->type) < 0)
+					return -ENOSPC;
+			}
+			break;
+		case BTF_KIND_ARRAY: {
+			struct btf_array *ba, *a = btf_array(t);
+
+			if (r->map[a->type] <= BTF_MAX_NR_TYPES &&
+			    r->map[a->index_type] <= BTF_MAX_NR_TYPES) {
+				bt = NULL;
+				base_id = 0;
+				while ((err = btf_reconcile_find_next(r, t, &base_id, &bt))
+				       != -ENOENT) {
+					ba = btf_array(bt);
+					if (r->map[a->type] != ba->type ||
+					    r->map[a->index_type] != ba->index_type)
+						continue;
+					r->map[id] = base_id;
+					break;
+				}
+				if (err) {
+					pr_warn("could not matching find base BTF ARRAY for base reference ARRAY[%u]\n",
+						id);
+					return err;
+				}
+			} else {
+				if (btf_reconcile_push(r, id) < 0 ||
+				    btf_reconcile_push(r, a->type) < 0 ||
+				    btf_reconcile_push(r, a->index_type) < 0)
+					return -ENOSPC;
+			}
+			break;
+		}
+		case BTF_KIND_FUNC_PROTO: {
+			struct btf_param *p = btf_params(t);
+			int i, vlen = btf_vlen(t);
+
+			for (i = 0; i < vlen; i++, p++) {
+				if (r->map[p->type] > BTF_MAX_NR_TYPES)
+					break;
+			}
+			if (i == vlen && r->map[t->type] <= BTF_MAX_NR_TYPES) {
+				while ((err = btf_reconcile_find_next(r, t, &base_id, &bt))
+				       != -ENOENT) {
+					struct btf_param *bp = btf_params(bt);
+					int bvlen = btf_vlen(bt);
+					int j;
+
+					if (bvlen != vlen)
+						continue;
+					if (r->map[t->type] != bt->type)
+						continue;
+					for (j = 0, p = btf_params(t); j < bvlen; j++, bp++, p++) {
+						if (r->map[p->type] != bp->type)
+							break;
+					}
+					if (j < bvlen)
+						continue;
+					r->map[id] = base_id;
+					break;
+				}
+				if (err) {
+					pr_warn("could not find matching base BTF FUNC_PROTO for base reference FUNC_PROTO[%u]\n",
+						id);
+					return err;
+				}
+			} else {
+				if (btf_reconcile_push(r, id) < 0 ||
+				    btf_reconcile_push(r, t->type) < 0)
+					return -ENOSPC;
+				for (i = 0, p = btf_params(t); i < btf_vlen(t); i++, p++) {
+					if (btf_reconcile_push(r, p->type) < 0)
+						return -ENOSPC;
+				}
+			}
+			break;
+		}
+		default:
+			return -EINVAL;
+		}
+	} while ((id = btf_reconcile_pop(r)) <= BTF_MAX_NR_TYPES);
+
+	return 0;
+}
+
+static int btf_reconcile_rewrite_type_id(__u32 *id, void *ctx)
+{
+	struct btf_reconcile *r = ctx;
+
+	*id = r->map[*id];
+	return 0;
+}
+
+/* If successful, output of reconciliation is updated BTF with base BTF pointing
+ * at base_btf, and type ids, strings adjusted accordingly
+ */
+int btf_reconcile(struct btf *btf, const struct btf *base_btf, __u32 **map_ids)
+{
+	const struct btf *base_ref_btf = btf__base_btf(btf);
+	unsigned int nr_split_types, nr_base_ref_types;
+	unsigned int nr_types = btf__type_cnt(btf);
+	struct btf_reconcile r = {};
+	const struct btf_type *t;
+	int diff_id, err = 0;
+	__u32 id, i;
+
+	if (!base_btf || base_ref_btf == base_btf)
+		return 0;
+
+	nr_base_ref_types = btf__type_cnt(base_ref_btf);
+	r.nr_base_types = btf__type_cnt(base_btf);
+	nr_split_types = nr_types - nr_base_ref_types;
+	r.map = calloc(nr_types, sizeof(*r.map));
+	r.stack_limit = nr_base_ref_types;
+	r.stack = calloc(r.stack_limit, sizeof(*r.stack));
+	if (!r.map || !r.stack) {
+		err = -ENOMEM;
+		goto err_out;
+	}
+	diff_id = r.nr_base_types - nr_base_ref_types;
+	for (id = 1; id < nr_base_ref_types; id++)
+		r.map[id] = BTF_UNPROCESSED_ID;
+	for (id = nr_base_ref_types; id < nr_types; id++)
+		r.map[id] = id + diff_id;
+
+	r.btf = btf;
+	r.base_ref_btf = base_ref_btf;
+	r.base_btf = base_btf;
+
+	/* Build a map from base references to actual base BTF ids; it is used
+	 * to track the state of comparisons.  First map base types and fwds,
+	 * next structs/unions, and finally reference types (const, restrict,
+	 * ptr, array, func, func_proto etc).
+	 */
+	for (id = 1; id < nr_base_ref_types; id++) {
+		err = btf_reconcile_base_type(&r, id);
+		if (err)
+			goto err_out;
+	}
+	for (id = 1; id < nr_base_ref_types; id++) {
+		err = btf_reconcile_struct_type(&r, id);
+		if (err)
+			goto err_out;
+	}
+	for (id = 1; id < nr_base_ref_types; id++) {
+		err = btf_reconcile_ref_type(&r, id);
+		if (err)
+			goto err_out;
+	}
+	/* Next, rewrite type ids in split BTF, replacing split ids with updated
+	 * ids based on number of types in base BTF, and base ids with
+	 * reconciled ids from base_btf.
+	 */
+	for (i = 0, id = nr_base_ref_types; i < nr_split_types; i++, id++) {
+		t = btf__type_by_id(btf, id);
+		err = btf_type_visit_type_ids((struct btf_type *)t,
+					      btf_reconcile_rewrite_type_id, &r);
+		if (err)
+			goto err_out;
+	}
+	/* Finally reset base BTF to base_btf; as part of this operation, string
+	 * offsets are also updated, and we are done.
+	 */
+	err = btf_set_base_btf(r.btf, (struct btf *)r.base_btf);
+err_out:
+	if (!err && map_ids)
+		*map_ids = r.map;
+	else
+		free(r.map);
+	free(r.stack);
+	return err;
+}
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index e9a7cb9c3c5b..ef61985204ab 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -416,5 +416,6 @@ LIBBPF_1.4.0 {
 		btf__new_split;
 		btf__new_split_base_ref;
 		btf__parse_opts;
+		btf__reconcile;
 		btf_ext__raw_data;
 } LIBBPF_1.3.0;
diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_internal.h
index 864b36177424..097d4d1e4bf7 100644
--- a/tools/lib/bpf/libbpf_internal.h
+++ b/tools/lib/bpf/libbpf_internal.h
@@ -234,6 +234,8 @@ struct btf_type;
 struct btf_type *btf_type_by_id(const struct btf *btf, __u32 type_id);
 const char *btf_kind_str(const struct btf_type *t);
 const struct btf_type *skip_mods_and_typedefs(const struct btf *btf, __u32 id, __u32 *res_id);
+int btf_set_base_btf(struct btf *btf, struct btf *base_btf);
+int btf_reconcile(struct btf *btf, const struct btf *base_btf, __u32 **map_ids);
 
 static inline enum btf_func_linkage btf_func_linkage(const struct btf_type *t)
 {
-- 
2.39.3

