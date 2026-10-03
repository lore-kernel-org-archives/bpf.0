Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2A8C35C6A7;
	Sat,  3 Oct 2026 19:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791056656; cv=none; b=NNIcS/kptKSvrsk9fPqfUlot61vtS0tkvshVsmjBKVAyioyYKbbHP5jC7Sddsjf5fa8xYfVWdHFHXpK2T3eCmmuM2mmfvgY0y07cDbkaicxwxldmpmgOtesecHdUmnVLbXx9NbTdpmUUgPOy8LPBEYK3DvT4icv+fYhhCGzcTpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791056656; c=relaxed/simple;
	bh=KNJIb+7Y+hRJ+1qwExFJTOu7PUW+Q2et+1W+ytuDWmM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zv+IetkpAw/Bh5egJ2m1jVerffNAnYXj+sVcMWHqVYHdDq2N/3deWJb+a8rmHsmm7CqG85XinPqck+vkr1WHIKQCjmlOwldVRrGw7iqqDsMO63Ab9gjRJhZlK1mi64qWk+JhzEe25RSE9brDPgm2avFJQDQ1slipPpe39SxDWqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=BlyuJSAc; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BlyuJSAc"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 693JPUo21829096;
	Sat, 3 Oct 2026 19:43:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=t+C8y
	OojIAO9PMqpydOYtQjkiVw5DHyxVTyEvdouOr0=; b=BlyuJSAcsPjnQcihgnSeX
	elX8KlyTJBm6nIPaEnkUcpIW2kteZxwblu4+JuFtjRoTU0j3o4GihAgWD0LnGAUz
	puwVqFWlDKQR7sGFLoIlwnr9Pc21xpdy/A+ibpmdKCrgW1LGr3tSHQKAZKcbo8+j
	XlJSFaAFMlaTeRQJaAYKiVO6F5HNWjspDVYg822YNfX3jW3epNlYHczFmtnWRNEq
	TrQQ5UMu/rkprgMmMsRfW+yaBx6DHGOpMLvkAMEJp3Kniq1NfTtB8tj9e4xVgat1
	VVcSMfF4Oi2A0IeYx1yC/BCq6cQcdoO8qrCTLRkMYm7Y/hkeASnv+GIDTAvHWhU+
	A==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4h2r4b8eec-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 03 Oct 2026 19:43:41 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 693JZ2Lt005069;
	Sat, 3 Oct 2026 19:43:38 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4h2r58yyqg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 03 Oct 2026 19:43:38 +0000 (GMT)
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 693JdEMt012617;
	Sat, 3 Oct 2026 19:43:37 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-83-182.vpn.oracle.com [10.154.83.182])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4h2r58yynt-2;
	Sat, 03 Oct 2026 19:43:34 +0000 (GMT)
From: Alan Maguire <alan.maguire@oracle.com>
To: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, eddyz87@gmail.com
Cc: jolsa@kernel.org, ihor.solodrai@linux.dev, yonghong.song@linux.dev,
        song@kernel.org, qmo@kernel.org, martin.lau@linux.dev,
        memxor@gmail.com, emil@etsalapatis.com, mcgrof@kernel.org,
        petr.pavlu@suse.com, tj@kernel.org, kees@kernel.org, nathan@kernel.org,
        arnd@arndb.de, puranjay@kernel.org, yatsenko@meta.com,
        atenart@kernel.org, ojeda@kernel.org, linux-modules@vger.kernel.org,
        arnaldo.melo@gmail.com, bpf@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v3 bpf-next 1/7] resolve_btfids: Build separate main and inline BTF objects
Date: Sat,  3 Oct 2026 20:43:17 +0100
Message-ID: <20261003194323.817885-2-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20261003194323.817885-1-alan.maguire@oracle.com>
References: <20261003194323.817885-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-03_03,2026-10-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 spamscore=0 suspectscore=0 phishscore=0 malwarescore=0 mlxscore=0 bulkscore=0
 adultscore=0 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2609040000 definitions=main-2610030078
X-Proofpoint-GUID: izT-aOXj4D__POH0KGsWs9OBAOVHT8Hf
X-Proofpoint-ORIG-GUID: izT-aOXj4D__POH0KGsWs9OBAOVHT8Hf
X-Authority-Analysis: v=2.4 cv=BIQmP1QG c=1 sm=1 tr=0 ts=6ac15aed cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=x4eqshVgHu-cdnggieHk:22 a=pGLkceISAAAA:8 a=yPCof4ZbAAAA:8
 a=9wEeqc_k_krk1YGEcvQA:9 a=n-iQ1lACIBT0aN_e:21
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAzMDA3OCBTYWx0ZWRfX0CYd94CMDmq+
 3xNhP1O0fms9PgUcaunphxB1L+vyl+n2WUGqfBgGwDbL4oAh7dUdxgDmWLUv+6O+DmxX/Fb5MKD
 tM+FW1OO/Jg3PheSJ90KiQfA2HSTyQTQsKYGVz0kD8L9d38sNk6x
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAzMDA3OCBTYWx0ZWRfXyfqvW3B++GZf
 twBONNmEfotdQ/Xz93pzhgZ/EnN3aNolyM7CLxZTVwJ6vH0+upvLqKzgpGxJOo28hwtvS/mKAlQ
 Y2WFfx7uqqpJdLV25OpXxUz2qdI48vRbax/wLl5U/VaIDOa77Vmv5wRvJhsGD3ouJAq1nAQsC+H
 t7aG9ZMxuVHCUZMMCTdOg8TUBCjxOatHn4OQ7yT4BLNlKusVm9ORjxF+Ih7VrY7Dm6Al4s8GV06
 FdsNn/h0A2HHGI8QR0SPwrKAuA2Ch+cI5fSCwJnGGmnkoOC2kDG6qjbcoUGUJUl132qBHLAlS+5
 yH0iQxlnKe1pBQX22tedweSRM/y8rzILsFwFD7JSpZtzUBp5LAD47++q5Y7ed0nyGQo2XNiSSZN
 5WbhcZM4KhOMsC1ZvtPBuMoJ/hrLHgauY7BKTfDdEli0Q6YSfL97PWvNUtNYNJITAui7WkkiAAc
 ZowiPH9pVv9s2I1iV5Q==

From: Eduard Zingerman <eddyz87@gmail.com>

Extract .BTF.inline via the following logic:
- Traverse all types reachable from LOC_PARAM, LOC_PROTO, LOCSEC
  entries and mark them as having LOC color.
- Traverse all types reachable from the remaining types
  and mark them as having MAIN or SHARED.
- Create a new base BTF object and copy all MAIN/SHARED types there.
- Create a new .BTF.inline object with base set to the new base BTF
  object, and copy all LOC types there.

This way .BTF.inline can refer to types and strings in the new base,
and strings used only by .BTF.inline remain in it.

Additionally, all BTF_KIND_FUNC types that map to ELF symbols with the
same name are forced to be in the base BTF. Same for types referenced
from BTF id sets.

Regular types referenced only from .BTF.inline remain in the base BTF,
and sizes are 5 and 9.5Mb for vmlinux and vmlinux.inline respectively.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 tools/bpf/resolve_btfids/Build        |   1 +
 tools/bpf/resolve_btfids/btf_colors.c | 139 ++++++++++++++++++++++
 tools/bpf/resolve_btfids/btf_colors.h |  20 ++++
 tools/bpf/resolve_btfids/main.c       | 160 +++++++++++++++++++++++++-
 tools/testing/selftests/bpf/Makefile  |   4 +-
 tools/testing/selftests/hid/Makefile  |   2 +
 6 files changed, 324 insertions(+), 2 deletions(-)
 create mode 100644 tools/bpf/resolve_btfids/btf_colors.c
 create mode 100644 tools/bpf/resolve_btfids/btf_colors.h

diff --git a/tools/bpf/resolve_btfids/Build b/tools/bpf/resolve_btfids/Build
index 077de3829c72..602e1508bf09 100644
--- a/tools/bpf/resolve_btfids/Build
+++ b/tools/bpf/resolve_btfids/Build
@@ -1,6 +1,7 @@
 hostprogs := resolve_btfids
 
 resolve_btfids-y += main.o
+resolve_btfids-y += btf_colors.o
 resolve_btfids-y += rbtree.o
 resolve_btfids-y += zalloc.o
 resolve_btfids-y += string.o
diff --git a/tools/bpf/resolve_btfids/btf_colors.c b/tools/bpf/resolve_btfids/btf_colors.c
new file mode 100644
index 000000000000..347ae85d6bc7
--- /dev/null
+++ b/tools/bpf/resolve_btfids/btf_colors.c
@@ -0,0 +1,139 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include <bpf/libbpf_internal.h>
+#include "btf_colors.h"
+
+/*
+ * Functions in this file mainly exist to refer to functions from libbpf_internal.h,
+ * which can't be included in main.c because of the u32 poison and pr_warn macro conflicts.
+ */
+
+/*
+ * Marks `root_id` and local types reachable from it with `color`.
+ * `colors` is indexed by source ID; worklist has room for every local type.
+ */
+void btf_mark_reachable(struct btf *btf, __u32 root_id, enum btf_color color,
+			__u8 *colors, __u32 *worklist)
+{
+	const struct btf *base = btf__base_btf(btf);
+	__u32 start_id = base ? btf__type_cnt(base) : 1;
+	__u32 pending = 0;
+
+	if (root_id < start_id || (colors[root_id] & color) == color)
+		return;
+	colors[root_id] |= color;
+	worklist[pending++] = root_id;
+	while (pending) {
+		const struct btf_type *t = btf__type_by_id(btf, worklist[--pending]);
+		struct btf_field_iter it;
+		__u32 *id;
+
+		btf_field_iter_init(&it, (struct btf_type *)t, BTF_FIELD_ITER_IDS);
+		while ((id = btf_field_iter_next(&it))) {
+			if (*id < start_id || (colors[*id] & color) == color)
+				continue;
+			colors[*id] |= color;
+			worklist[pending++] = *id;
+		}
+	}
+}
+
+static int cmp_loc(const void *a, const void *b)
+{
+	const struct btf_loc *la = a, *lb = b;
+
+	if (la->func != lb->func)
+		return la->func < lb->func ? -1 : 1;
+	if (la->offset != lb->offset)
+		return la->offset < lb->offset ? -1 : 1;
+	if (la->loc_proto != lb->loc_proto)
+		return la->loc_proto < lb->loc_proto ? -1 : 1;
+	return 0;
+}
+
+static void remap(struct btf *btf, const __u32 *id_map, __u32 src_start_id)
+{
+	const struct btf *base = btf__base_btf(btf);
+	__u32 start_id = base ? btf__type_cnt(base) : 1;
+	__u32 i, type_cnt = btf__type_cnt(btf);
+
+	for (i = start_id; i < type_cnt; i++) {
+		struct btf_type *t = (struct btf_type *)btf__type_by_id(btf, i);
+		struct btf_field_iter it;
+		__u32 *id;
+
+		btf_field_iter_init(&it, t, BTF_FIELD_ITER_IDS);
+		while ((id = btf_field_iter_next(&it))) {
+			/* Void and types in the original ancestor are unchanged. */
+			if (*id >= src_start_id)
+				*id = id_map[*id - src_start_id];
+		}
+		if (btf_is_locsec(t))
+			qsort(btf_locsec_locs(t), btf_vlen(t), sizeof(struct btf_loc), cmp_loc);
+	}
+}
+
+/*
+ * Split the `src` into `main_out` base and `inline_out`,
+ * according to `colors` array. Relative ordering remains
+ * the same as in `src`.
+ */
+int btf_split_by_color(struct btf *src, const __u8 *colors,
+		       struct btf **main_out, struct btf **inline_out)
+{
+	LIBBPF_OPTS(btf_new_opts, opts,
+		    .base_btf = (struct btf *)btf__base_btf(src),
+		    .add_layout = btf_header(src)->layout_len != 0,
+	);
+	struct btf *main_btf, *inline_btf = NULL;
+	__u32 start_id = opts.base_btf ? btf__type_cnt(opts.base_btf) : 1;
+	__u32 type_cnt = btf__type_cnt(src);
+	__u32 *id_map, i;
+	int err = -ENOMEM;
+
+	*main_out = NULL;
+	*inline_out = NULL;
+	id_map = malloc((type_cnt - start_id ?: 1) * sizeof(*id_map));
+	if (!id_map)
+		return -ENOMEM;
+	main_btf = btf__new_empty_opts(&opts);
+	if (!main_btf)
+		goto out;
+	btf__set_endianness(main_btf, btf__endianness(src));
+	/* Copy MAIN and SHARED marked types to `main_out`. */
+	for (i = start_id; i < type_cnt; i++) {
+		if (colors[i] == BTF_COLOR_LOC)
+			continue;
+		err = btf__add_type(main_btf, src, btf__type_by_id(src, i));
+		if (err < 0)
+			goto out;
+		id_map[i - start_id] = err;
+	}
+	/*
+	 * Copy LOC marked types to `inline_out`.
+	 * `main_btf` types count is stable at this point.
+	 */
+	inline_btf = btf__new_empty_split(main_btf);
+	if (!inline_btf) {
+		err = -ENOMEM;
+		goto out;
+	}
+	for (i = start_id; i < type_cnt; i++) {
+		if (colors[i] != BTF_COLOR_LOC)
+			continue;
+		err = btf__add_type(inline_btf, src, btf__type_by_id(src, i));
+		if (err < 0)
+			goto out;
+		id_map[i - start_id] = err;
+	}
+	remap(main_btf, id_map, start_id);
+	remap(inline_btf, id_map, start_id);
+	*main_out = main_btf;
+	*inline_out = inline_btf;
+	free(id_map);
+	return 0;
+out:
+	btf__free(inline_btf);
+	btf__free(main_btf);
+	free(id_map);
+	return err;
+}
diff --git a/tools/bpf/resolve_btfids/btf_colors.h b/tools/bpf/resolve_btfids/btf_colors.h
new file mode 100644
index 000000000000..9cea757cb356
--- /dev/null
+++ b/tools/bpf/resolve_btfids/btf_colors.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef __RESOLVE_BTFIDS_BTF_COLORS_H
+#define __RESOLVE_BTFIDS_BTF_COLORS_H
+
+#include <bpf/btf.h>
+
+enum btf_color {
+	BTF_COLOR_NONE = 0,
+	BTF_COLOR_MAIN = 1,
+	BTF_COLOR_LOC = 2,
+	BTF_COLOR_SHARED = BTF_COLOR_MAIN | BTF_COLOR_LOC,
+};
+
+void btf_mark_reachable(struct btf *btf, __u32 root, enum btf_color color,
+			__u8 *colors, __u32 *worklist);
+
+int btf_split_by_color(struct btf *src, const __u8 *colors,
+		       struct btf **main_out, struct btf **inline_out);
+
+#endif
diff --git a/tools/bpf/resolve_btfids/main.c b/tools/bpf/resolve_btfids/main.c
index 37d7e7224207..dcd289d16faf 100644
--- a/tools/bpf/resolve_btfids/main.c
+++ b/tools/bpf/resolve_btfids/main.c
@@ -89,6 +89,7 @@
 #include <linux/limits.h>
 #include <bpf/btf.h>
 #include <bpf/libbpf.h>
+#include "btf_colors.h"
 #include <subcmd/parse-options.h>
 
 #define BTF_IDS_SECTION	".BTF_ids"
@@ -142,7 +143,9 @@ struct object {
 
 	struct btf *btf;
 	struct btf *base_btf;
+	struct btf *inline_btf;
 	bool distill_base;
+	bool extract_inline;
 
 	struct {
 		int		 fd;
@@ -154,6 +157,10 @@ struct object {
 		size_t		 strtabidx;
 		unsigned long	 idlist_addr;
 		int		 encoding;
+		const char	**func_symbols;
+		u32		 func_symbols_cnt;
+		u32		 func_symbols_cap;
+		bool		 func_symbols_collected;
 	} efile;
 
 	struct rb_root	sets;
@@ -572,6 +579,58 @@ static const char *find_name_by_addr(struct object *obj, Elf64_Addr addr)
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
+	if (!scn || gelf_getshdr(scn, &sh) != &sh || !sh.sh_entsize)
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
@@ -1510,6 +1569,85 @@ static int btf2btf(struct object *obj)
 	return err;
 }
 
+static bool keep_in_base_btf(struct object *obj, const struct btf_type *t)
+{
+	const char *name;
+
+	switch (btf_kind(t)) {
+	case BTF_KIND_FUNC:
+		name = btf__name_by_offset(obj->btf, t->name_off);
+		return !obj->efile.func_symbols_collected || has_func_symbol(obj, name) ||
+		       btf_id__find(&obj->funcs, name);
+	case BTF_KIND_FUNC_PROTO:
+	case BTF_KIND_LOC_PARAM:
+	case BTF_KIND_LOC_PROTO:
+	case BTF_KIND_LOCSEC:
+		return false;
+	default:
+		/*
+		 * Ordinary types stay in base btf even if only inline records use them.
+		 * Should we relax this?
+		 */
+		return true;
+	}
+}
+
+/* Mark which types should go to .BTF.inline */
+static int color_btf(struct object *obj, __u8 *colors)
+{
+	struct btf *btf = obj->btf;
+	const struct btf *base = btf__base_btf(btf);
+	__u32 start_id = base ? btf__type_cnt(base) : 1;
+	__u32 type_cnt = btf__type_cnt(btf), i;
+	__u32 *worklist;
+
+	worklist = malloc((type_cnt - start_id ?: 1) * sizeof(*worklist));
+	if (!worklist)
+		return -ENOMEM;
+	/* First, mark all types reachable from LOC BTF entries. */
+	for (i = start_id; i < type_cnt; i++) {
+		const struct btf_type *t = btf__type_by_id(btf, i);
+
+		if (!btf_is_locsec(t) && !btf_is_loc_proto(t) && !btf_is_loc_param(t))
+			continue;
+		btf_mark_reachable(btf, i, BTF_COLOR_LOC, colors, worklist);
+	}
+	/* Next, traverse non-marked types converting some LOC markings to SHARED. */
+	for (i = start_id; i < type_cnt; i++) {
+		const struct btf_type *t = btf__type_by_id(btf, i);
+
+		if (colors[i] == BTF_COLOR_LOC && !keep_in_base_btf(obj, t))
+			continue;
+		btf_mark_reachable(btf, i, BTF_COLOR_MAIN, colors, worklist);
+	}
+	free(worklist);
+	return 0;
+}
+
+static int extract_inline_btf(struct object *obj)
+{
+	struct btf *btf = obj->btf, *main_btf, *inline_btf;
+	__u32 type_cnt = btf__type_cnt(btf);
+	__u8 *colors;
+	int err;
+
+	colors = calloc(type_cnt, sizeof(*colors));
+	if (!colors)
+		return -ENOMEM;
+	err = color_btf(obj, colors);
+	if (err)
+		goto out;
+	err = btf_split_by_color(btf, colors, &main_btf, &inline_btf);
+	if (!err) {
+		obj->btf = main_btf;
+		obj->inline_btf = inline_btf;
+		btf__free(btf);
+	}
+out:
+	free(colors);
+	return err;
+}
+
 /*
  * Sort types by name in ascending order resulting in all
  * anonymous types being placed before named types.
@@ -1605,6 +1743,14 @@ static int finalize_btf(struct object *obj)
 		goto out_err;
 	}
 
+	if (obj->extract_inline) {
+		err = extract_inline_btf(obj);
+		if (err) {
+			pr_err("FAILED to extract inline BTF: %s\n", strerror(-err));
+			goto out_err;
+		}
+	}
+
 	return 0;
 
 out_err:
@@ -1773,6 +1919,8 @@ int main(int argc, const char **argv)
 			    "turn warnings into errors"),
 		OPT_BOOLEAN(0, "distill_base", &obj.distill_base,
 			    "distill --btf_base and emit .BTF.base section data"),
+		OPT_BOOLEAN(0, "inline", &obj.extract_inline,
+			    "extract location BTF into a .BTF.inline file"),
 		OPT_STRING(0, "patch_btfids", &btfids_path, "file",
 			   "path to .BTF_ids section data blob to patch into ELF file"),
 		OPT_END()
@@ -1791,6 +1939,8 @@ int main(int argc, const char **argv)
 
 	if (elf_collect(&obj))
 		goto out;
+	if (obj.extract_inline && collect_func_symbols(&obj))
+		goto out;
 
 	/*
 	 * We did not find .BTF_ids section or symbols section,
@@ -1841,18 +1991,26 @@ int main(int argc, const char **argv)
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
-	btf__free(obj.base_btf);
+	btf__free(obj.inline_btf);
 	btf__free(obj.btf);
+	btf__free(obj.base_btf);
 	btf_id__free_all(&obj.structs);
 	btf_id__free_all(&obj.unions);
 	btf_id__free_all(&obj.typedefs);
 	btf_id__free_all(&obj.funcs);
 	btf_id__free_all(&obj.sets);
 	free(obj.addr_syms);
+	free(obj.efile.func_symbols);
 	if (obj.efile.elf) {
 		elf_end(obj.efile.elf);
 		close(obj.efile.fd);
diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index afa589a27b15..00ad1b2833a3 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -343,7 +343,9 @@ else
 endif
 
 $(RESOLVE_BTFIDS): $(HOST_BPFOBJ) | $(HOST_BUILD_DIR)/resolve_btfids	\
-		       $(TOOLSDIR)/bpf/resolve_btfids/main.c	\
+		       $(TOOLSDIR)/bpf/resolve_btfids/main.c		\
+		       $(TOOLSDIR)/bpf/resolve_btfids/btf_colors.c	\
+		       $(TOOLSDIR)/bpf/resolve_btfids/btf_colors.h	\
 		       $(TOOLSDIR)/lib/rbtree.c			\
 		       $(TOOLSDIR)/lib/zalloc.c			\
 		       $(TOOLSDIR)/lib/string.c			\
diff --git a/tools/testing/selftests/hid/Makefile b/tools/testing/selftests/hid/Makefile
index 2f423de83147..d1b65fd37911 100644
--- a/tools/testing/selftests/hid/Makefile
+++ b/tools/testing/selftests/hid/Makefile
@@ -148,6 +148,8 @@ endif
 
 $(RESOLVE_BTFIDS): $(HOST_BPFOBJ) | $(HOST_BUILD_DIR)/resolve_btfids	\
 		       $(TOOLSDIR)/bpf/resolve_btfids/main.c	\
+		       $(TOOLSDIR)/bpf/resolve_btfids/btf_colors.c	\
+		       $(TOOLSDIR)/bpf/resolve_btfids/btf_colors.h	\
 		       $(TOOLSDIR)/lib/rbtree.c			\
 		       $(TOOLSDIR)/lib/zalloc.c			\
 		       $(TOOLSDIR)/lib/string.c			\
-- 
2.43.5

