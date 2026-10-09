Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B27F543DEC7;
	Fri,  9 Oct 2026 11:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791545056; cv=none; b=BW3DikSGeetDyzKKZnUXUOuBrJnx+QbKFArxHEhWKAo2gLqfKMbx7OVoGRk+C7vf8/xwImaYOGDknWjbWXp3O/ie7FOFNl3g0sMF5CBFFMvFL/DIup+QVKJp+iYxc9TXzZfsU33Yh+O+vTkOy938bAXQG0OIPKH+U8vT+6cMi3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791545056; c=relaxed/simple;
	bh=IHQhDu7mxqy33hjmia2Fi57bFiOFJFvBbp9cPvSN7g0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hocFHLacS1qe0VLEBZ8JKo+Iky6/JzLghYA2xpfFtuPo4H4pFHQC24caszsJBH57Gx7XEZDtiTC4zCff4DvSb15HDDwE4rCDhwWA0PIcmOqtD2fu4N6QY4/LfBCqKDpWv8EDFIoajYQVLnF4UeVj646dI8G/zW1J4cXhLUX3iVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=UWpENXDB; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="UWpENXDB"
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 698KA2I41664808;
	Fri, 9 Oct 2026 11:23:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=UFYOC
	2mvVF752L6YhnuDLXTrEkdVaIogXnZaB86324U=; b=UWpENXDBDpsluRiLekb8s
	OVm4z1MoszPaO21CDoegfNSfTIV76nmypOepxrbd/O+qUB9Vea4yOp6pV1dCM1eZ
	RoHy1Sb1/eH//8WHksa0PQUIzE+ZB3/7aT1GKzRBkfW+2OtA1bAwaTttj+eo7oXR
	fa5MRZD13s8D4GARpgPgXrbpYGTbfnOehgFqKIRPLK8McaIBbs6BC8BmdbZrvumR
	vwZU3IF2CQSKSNK6IJYCX2QQpk0lMS8/SeLF4vR31JBnfiBJBI/RxO3s6Q40zau1
	nV5aCsyaZCrqJW0y+4XNJ4bepoP+pvT8jdPowWYwKGpS91llP1iqdEzF/fp2erJ+
	Q==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4h5xehk0e6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 09 Oct 2026 11:23:33 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 699BLkn3039888;
	Fri, 9 Oct 2026 11:23:32 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4h5xfcsnau-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 09 Oct 2026 11:23:32 +0000 (GMT)
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 699BNRkS006543;
	Fri, 9 Oct 2026 11:23:31 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-85-231.vpn.oracle.com [10.154.85.231])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4h5xfcsn8m-2;
	Fri, 09 Oct 2026 11:23:31 +0000 (GMT)
From: Alan Maguire <alan.maguire@oracle.com>
To: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, eddyz87@gmail.com,
        jolsa@kernel.org
Cc: ihor.solodrai@linux.dev, yonghong.song@linux.dev, song@kernel.org,
        qmo@kernel.org, martin.lau@linux.dev, memxor@gmail.com,
        emil@etsalapatis.com, mcgrof@kernel.org, petr.pavlu@suse.com,
        tj@kernel.org, kees@kernel.org, nathan@kernel.org, arnd@arndb.de,
        puranjay@kernel.org, yatsenko@meta.com, atenart@kernel.org,
        ojeda@kernel.org, linux-modules@vger.kernel.org,
        arnaldo.melo@gmail.com, bpf@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v4 bpf-next 1/7] resolve_btfids: Build separate main and inline BTF objects
Date: Fri,  9 Oct 2026 12:23:18 +0100
Message-ID: <20261009112324.1442319-2-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20261009112324.1442319-1-alan.maguire@oracle.com>
References: <20261009112324.1442319-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-09_03,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 suspectscore=0 spamscore=0 mlxscore=0 mlxlogscore=999 bulkscore=0
 phishscore=0 lowpriorityscore=0 malwarescore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2610020000 definitions=main-2610090045
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDA0NSBTYWx0ZWRfX/PzcOiifsyhH
 2hTRK+vi4rnVnnOKoi22wc7Z7BfyBzzHubLrV08+D1AESF7uGEZW1oMkLLWD3Lg/85lCvBwmhxn
 PPbWQ9BAVloinavsVpUEhvJcz5feDq/KTzdYl3uthcOoJWxZE3ze
X-Authority-Analysis: v=2.4 cv=dfkVTnXe c=1 sm=1 tr=0 ts=6ac8ceb5 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=EIcjfB9IiI4px24ztqRk:22 a=pGLkceISAAAA:8 a=yPCof4ZbAAAA:8
 a=OUTQcmzGQZ642ndAERQA:9 a=kmS25aEdROflHBep:21 a=5yU3S35YU4bGjq-dph-N:22
 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:12108
X-Proofpoint-GUID: p8dXXfD-iMvVtVWXckdhFXxhgBa9zsAU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDA0NSBTYWx0ZWRfX0uZ9N9Ah70wz
 FgFSCvpkhS39Y+dPxmgbPZ6YnzGDhU5UogJVCwkzM3HGpL3osA1H1WAGR/C/an3ZYfCgPWfsPGb
 tOwC88sDHniI+VmsmeZfmZdjEN80NIMBHJSaOh9h715WZIsWq4KppLUlhlXA+bdwFB6f0bQWr6I
 cySVdRRvrh+xa/2fJWmzJK2CxIDWbpdjKqIFBl7aq12h7WGVN05ADkKRPVz3T5xWnccp3etrG6d
 jYyHGobYw/lZ7z3R7aZH5cE2jboUdWD6L9uQT3DCQ+h8EHFSS8wG3hkA2fDTlkCfVyi2C8WfVzw
 VasTFbVpx79I8p5CmFTbUq6a5CL/w7W+y6HPQx9eOHlwJCUwMM457IsfO4U0swRK5pmIBGpxS1M
 /llegCVio33wwiuXdEjYhqN+Ei6GCA2tTYGVLGVXor0C2+70DDber1SigcKU02MRmRuN0b10pDf
 JjefNOYxE1dnHehmMd9cJ85hFM0gvIgcMZqrkNHk=
X-Proofpoint-ORIG-GUID: p8dXXfD-iMvVtVWXckdhFXxhgBa9zsAU

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
 tools/bpf/resolve_btfids/btf_colors.c | 139 +++++++++++++++++++
 tools/bpf/resolve_btfids/btf_colors.h |  20 +++
 tools/bpf/resolve_btfids/main.c       | 193 +++++++++++++++++++++++---
 tools/testing/selftests/bpf/Makefile  |   4 +-
 tools/testing/selftests/hid/Makefile  |   2 +
 6 files changed, 336 insertions(+), 23 deletions(-)
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
index 37d7e7224207..15e7be13061f 100644
--- a/tools/bpf/resolve_btfids/main.c
+++ b/tools/bpf/resolve_btfids/main.c
@@ -89,6 +89,7 @@
 #include <linux/limits.h>
 #include <bpf/btf.h>
 #include <bpf/libbpf.h>
+#include "btf_colors.h"
 #include <subcmd/parse-options.h>
 
 #define BTF_IDS_SECTION	".BTF_ids"
@@ -142,7 +143,10 @@ struct object {
 
 	struct btf *btf;
 	struct btf *base_btf;
+	struct btf *inline_btf;
+	struct btf *orig_btf;
 	bool distill_base;
+	bool extract_inline;
 
 	struct {
 		int		 fd;
@@ -154,6 +158,10 @@ struct object {
 		size_t		 strtabidx;
 		unsigned long	 idlist_addr;
 		int		 encoding;
+		const char	**func_symbols;
+		u32		 func_symbols_cnt;
+		u32		 func_symbols_cap;
+		bool		 func_symbols_collected;
 	} efile;
 
 	struct rb_root	sets;
@@ -572,6 +580,58 @@ static const char *find_name_by_addr(struct object *obj, Elf64_Addr addr)
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
@@ -688,8 +748,9 @@ static int load_btf(struct object *obj)
 		if (err) {
 			pr_err("FAILED: load base BTF from %s: %s\n",
 			       obj->base_btf_path, strerror(-err));
-			goto out_err;
+			return err;
 		}
+		obj->base_btf = base_btf;
 	}
 
 	btf = btf__parse_split(obj->btf_path ?: obj->path, base_btf);
@@ -697,20 +758,12 @@ static int load_btf(struct object *obj)
 	if (err) {
 		pr_err("FAILED: load BTF from %s: %s\n",
 			obj->btf_path ?: obj->path, strerror(-err));
-		goto out_err;
+		return err;
 	}
 
-	obj->base_btf = base_btf;
 	obj->btf = btf;
 
 	return 0;
-
-out_err:
-	btf__free(base_btf);
-	btf__free(btf);
-	obj->base_btf = NULL;
-	obj->btf = NULL;
-	return err;
 }
 
 static int symbols_resolve(struct object *obj)
@@ -1510,6 +1563,84 @@ static int btf2btf(struct object *obj)
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
+	__u8 *colors;
+	int err;
+
+	colors = calloc(btf__type_cnt(btf), sizeof(*colors));
+	if (!colors)
+		return -ENOMEM;
+	err = color_btf(obj, colors);
+	if (err)
+		goto out;
+	err = btf_split_by_color(btf, colors, &main_btf, &inline_btf);
+	if (!err) {
+		obj->orig_btf = btf;
+		obj->btf = main_btf;
+		obj->inline_btf = inline_btf;
+	}
+out:
+	free(colors);
+	return err;
+}
+
 /*
  * Sort types by name in ascending order resulting in all
  * anonymous types being placed before named types.
@@ -1583,14 +1714,14 @@ static int finalize_btf(struct object *obj)
 	err = btf__dedup(obj->btf, NULL);
 	if (err) {
 		pr_err("FAILED to dedup BTF: %s\n", strerror(errno));
-		goto out_err;
+		return err;
 	}
 
 	if (obj->base_btf && obj->distill_base) {
 		err = btf__distill_base(obj->btf, &base_btf, &btf);
 		if (err) {
 			pr_err("FAILED to distill base BTF: %s\n", strerror(errno));
-			goto out_err;
+			return err;
 		}
 
 		btf__free(obj->base_btf);
@@ -1602,18 +1733,18 @@ static int finalize_btf(struct object *obj)
 	err = sort_btf_by_name(obj->btf);
 	if (err) {
 		pr_err("FAILED to sort BTF: %s\n", strerror(errno));
-		goto out_err;
+		return err;
 	}
 
-	return 0;
-
-out_err:
-	btf__free(base_btf);
-	btf__free(btf);
-	obj->base_btf = NULL;
-	obj->btf = NULL;
+	if (obj->extract_inline) {
+		err = extract_inline_btf(obj);
+		if (err) {
+			pr_err("FAILED to extract inline BTF: %s\n", strerror(-err));
+			return err;
+		}
+	}
 
-	return err;
+	return 0;
 }
 
 static inline int make_out_path(char *buf, u32 buf_sz, const char *in_path, const char *suffix)
@@ -1773,6 +1904,8 @@ int main(int argc, const char **argv)
 			    "turn warnings into errors"),
 		OPT_BOOLEAN(0, "distill_base", &obj.distill_base,
 			    "distill --btf_base and emit .BTF.base section data"),
+		OPT_BOOLEAN(0, "inline", &obj.extract_inline,
+			    "extract location BTF into a .BTF.inline file"),
 		OPT_STRING(0, "patch_btfids", &btfids_path, "file",
 			   "path to .BTF_ids section data blob to patch into ELF file"),
 		OPT_END()
@@ -1791,6 +1924,8 @@ int main(int argc, const char **argv)
 
 	if (elf_collect(&obj))
 		goto out;
+	if (obj.extract_inline && collect_func_symbols(&obj))
+		goto out;
 
 	/*
 	 * We did not find .BTF_ids section or symbols section,
@@ -1841,18 +1976,32 @@ int main(int argc, const char **argv)
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
+	/*
+	 * Free BTFs in reverse dependency order.  inline_btf borrows obj.btf;
+	 * obj.btf can borrow a base owned by orig_btf or obj.base_btf, and
+	 * orig_btf can also borrow obj.base_btf.
+	 */
+	btf__free(obj.inline_btf);
 	btf__free(obj.btf);
+	btf__free(obj.orig_btf);
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
index a22be7efd1fa..80d8bbbc3084 100644
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

