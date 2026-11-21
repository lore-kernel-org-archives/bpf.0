Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.163
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795221270;
	b=EGEKQBeYxpFDY+J/s7FX/NtRJpT2ts6Q9ljuNj20jdkvynUr2x1QMDi8ALK7sC6mEOEd
	 75nKijtDuhtwCAT5sSVNYc0SqyAQ8t/R1B+ncn7iST8aS3t6bh8efMVhFKP7El6hqQB/e
	 GzMutc40TV16Qw1Jmo6tyAPu3qCu23qyVsaSA85HwZoW+gQV6eS9+E5gq+twU1qHTTZrn
	 k8wXmQrzD9UMQfeCIEnEpHxB949ypyNOFNYLVTBynSauhRXdt3qXvUMi2A+y6sgKtujw+
	 3HgYyzbkV0ukkuS9RobxRFIHaaAIRMapXP0OMpAlhq0xCLgx9a2/mcIuv+P7d++3UKw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795221270;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=/D+Zhad86wjuATsbT8ohg/50USn4bj0NsQs4iN//PK8=;
	b=2kpPoycIdhO68xzfpoqky6uIaD7vnWJWzJiBlsJs7Fy3yExXfbMLBckUop8uxpNTgdoN
	 mrAFike8TK1Tcf79dPpRn/UfP1E2EmVJSb9QSfA0xNGOsXazPU/no1QX7cxx7tmOr1P0u
	 QCsJrn6pC5ZoVuBiqq4v9xZEGokWKUWFO6SFlTKtz8yM6XXeJ4TMs8rFpmnxMNQR0BZr2
	 UrT450nI6ZFco2jlEwm/sZ4rTm4ohiFcBxaabwfbbeXZiYouGdAVM/I/bH2IBYqPZndeU
	 UwLmonAPVNh5mRQg2rnHdGhMG8+I/ghFn0hbAItFPhC7w42i3YLtZexwj2JCOqSPukw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=UbBL8BrQ;
	arc=none smtp.remote-ip=91.218.175.163
Received: from mta0.migadu.com (out-163.mta0.migadu.com [91.218.175.163])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6F9560A2600
	for <bpf@vger.kernel.org>; Sat, 21 Nov 2026 00:34:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C6F9560A2600
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=UbBL8BrQ
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=vUBLLFu7exKFaLVeWVP1e19lJwUEn1zEA0S7uIyAxXw=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795221258; v=1; x=1795826058;
 b=UbBL8BrQ8Ro/aOrRc0+d7EsvcSEmxoG3Y7vq9beiNk45QOMQuq/GcoWiR2Efu3VzkjnFmCGj
 g2xTQ3yz4m5Opv9En7o5s79m6gblE9MA1XFub6xNFnc8OAgvmAaKLN2AjMJs6wTBTh4tgJyOreG
 z52wuIXVqHlIHHZHE5gp+hEc=
X-Envelope-To: bpf@vger.kernel.org
Received: by mta11.migadu.com with ESMTPS id edff4338751dc96c;
	Sat, 21 Nov 2026 00:34:18 +0000
X-Mizu-Trace-ID: edff4338751dc96c
X-Migadu-Flow: FLOW_OUT
From: Ihor Solodrai <ihor.solodrai@linux.dev>
To: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Alan Maguire <alan.maguire@oracle.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Song Liu <song@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev
Subject: [PATCH bpf-next v2 1/6] libbpf: Separate interfaces shared with in-tree tools
Date: Fri, 20 Nov 2026 17:33:58 -0700
Message-ID: <20261121003403.2928928-2-ihor.solodrai@linux.dev>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261121003403.2928928-1-ihor.solodrai@linux.dev>
References: <20261121003403.2928928-1-ihor.solodrai@linux.dev>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

resolve_btfids links libbpf statically and uses its BTF header
accessor, field iterator and SHA-256 helper. libbpf_internal.h
also defines logging macros and poisons kernel integer typedefs,
so resolve_btfids wraps the hash helper in a separate source file.

Move the shared declarations to libbpf_tools.h and use them
directly in resolve_btfids. The header is for in-tree tools and
stays uninstalled. No shared-library symbols change.

No functional change.

Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
---
 tools/bpf/bpftool/Makefile            |  9 +++---
 tools/bpf/resolve_btfids/btf_colors.c | 15 ++-------
 tools/bpf/resolve_btfids/btf_colors.h |  4 ---
 tools/bpf/resolve_btfids/main.c       |  5 +--
 tools/lib/bpf/libbpf_internal.h       | 30 +----------------
 tools/lib/bpf/libbpf_tools.h          | 46 +++++++++++++++++++++++++++
 6 files changed, 58 insertions(+), 51 deletions(-)
 create mode 100644 tools/lib/bpf/libbpf_tools.h

diff --git a/tools/bpf/bpftool/Makefile b/tools/bpf/bpftool/Makefile
index 49dabf2eded0..7e73e12af5b6 100644
--- a/tools/bpf/bpftool/Makefile
+++ b/tools/bpf/bpftool/Makefile
@@ -28,10 +28,11 @@ LIBBPF_BOOTSTRAP_INCLUDE := $(LIBBPF_BOOTSTRAP_DESTDIR)include
 LIBBPF_BOOTSTRAP_HDRS_DIR := $(LIBBPF_BOOTSTRAP_INCLUDE)/bpf
 LIBBPF_BOOTSTRAP := $(LIBBPF_BOOTSTRAP_OUTPUT)libbpf.a
 
-# We need to copy hashmap.h, nlattr.h, relo_core.h and libbpf_internal.h
-# which are not otherwise exported by libbpf, but still required by bpftool.
-LIBBPF_INTERNAL_HDRS := $(addprefix $(LIBBPF_HDRS_DIR)/,hashmap.h nlattr.h relo_core.h libbpf_internal.h)
-LIBBPF_BOOTSTRAP_INTERNAL_HDRS := $(addprefix $(LIBBPF_BOOTSTRAP_HDRS_DIR)/,hashmap.h relo_core.h libbpf_internal.h)
+# Stage private headers that bpftool uses and libbpf does not install.
+LIBBPF_COMMON_INTERNAL_HDRS := hashmap.h relo_core.h libbpf_internal.h libbpf_tools.h
+LIBBPF_INTERNAL_HDRS := $(addprefix $(LIBBPF_HDRS_DIR)/,$(LIBBPF_COMMON_INTERNAL_HDRS) nlattr.h)
+LIBBPF_BOOTSTRAP_INTERNAL_HDRS := $(addprefix $(LIBBPF_BOOTSTRAP_HDRS_DIR)/,\
+					     $(LIBBPF_COMMON_INTERNAL_HDRS))
 
 $(LIBBPF_OUTPUT) $(BOOTSTRAP_OUTPUT) $(LIBBPF_BOOTSTRAP_OUTPUT) $(LIBBPF_HDRS_DIR) $(LIBBPF_BOOTSTRAP_HDRS_DIR):
 	$(QUIET_MKDIR)mkdir -p $@
diff --git a/tools/bpf/resolve_btfids/btf_colors.c b/tools/bpf/resolve_btfids/btf_colors.c
index 5d307d70e7f2..7374aa2f8963 100644
--- a/tools/bpf/resolve_btfids/btf_colors.c
+++ b/tools/bpf/resolve_btfids/btf_colors.c
@@ -1,18 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0-only
-#include <bpf/libbpf_internal.h>
+#include <errno.h>
+#include <stdlib.h>
+#include <bpf/libbpf_tools.h>
 #include "btf_colors.h"
 
-/*
- * Functions in this file mainly exist to refer to functions from libbpf_internal.h,
- * which can't be included in main.c because of the u32 poison and pr_warn macro conflicts.
- */
-
-void btf_sha256(const void *data, size_t len,
-		__u8 out[BTF_SHA256_DIGEST_LENGTH])
-{
-	libbpf_sha256(data, len, out);
-}
-
 /*
  * Marks `root_id` and local types reachable from it with `color`.
  * `colors` is indexed by source ID; worklist has room for every local type.
diff --git a/tools/bpf/resolve_btfids/btf_colors.h b/tools/bpf/resolve_btfids/btf_colors.h
index 56a85a242d6b..9cea757cb356 100644
--- a/tools/bpf/resolve_btfids/btf_colors.h
+++ b/tools/bpf/resolve_btfids/btf_colors.h
@@ -11,10 +11,6 @@ enum btf_color {
 	BTF_COLOR_SHARED = BTF_COLOR_MAIN | BTF_COLOR_LOC,
 };
 
-#define BTF_SHA256_DIGEST_LENGTH	32
-
-void btf_sha256(const void *data, size_t len,
-		__u8 out[BTF_SHA256_DIGEST_LENGTH]);
 void btf_mark_reachable(struct btf *btf, __u32 root, enum btf_color color,
 			__u8 *colors, __u32 *worklist);
 
diff --git a/tools/bpf/resolve_btfids/main.c b/tools/bpf/resolve_btfids/main.c
index 0ac895222a14..0e193c3c73aa 100644
--- a/tools/bpf/resolve_btfids/main.c
+++ b/tools/bpf/resolve_btfids/main.c
@@ -93,12 +93,14 @@
 #include <linux/limits.h>
 #include <bpf/btf.h>
 #include <bpf/libbpf.h>
+#include <bpf/libbpf_tools.h>
 #include "btf_colors.h"
 #include "fmodret.h"
 #include <subcmd/parse-options.h>
 
 #define BTF_IDS_SECTION	".BTF_ids"
 #define BTF_LINK_MODULE_NAME_MAX	64
+#define BTF_SHA256_DIGEST_LENGTH	SHA256_DIGEST_LENGTH
 #define BTF_ID_PREFIX	"__BTF_ID__"
 
 #define BTF_STRUCT	"struct"
@@ -1205,8 +1207,7 @@ static int patch_btf_link(struct object *obj, const struct btf_link *link)
 	}
 	memset(data->d_buf, 0, data->d_size);
 	memcpy(data->d_buf, link->module, strlen(link->module) + 1);
-	btf_sha256(raw_btf_data, raw_btf_size,
-		   (u8 *)data->d_buf + module_name_len);
+	libbpf_sha256(raw_btf_data, raw_btf_size, (u8 *)data->d_buf + module_name_len);
 	size = (u8 *)data->d_buf + module_name_len + BTF_SHA256_DIGEST_LENGTH;
 	if (obj->efile.encoding == ELFDATA2LSB) {
 		size[0] = raw_btf_size;
diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_internal.h
index e90b5336bac0..0ab15b5589d6 100644
--- a/tools/lib/bpf/libbpf_internal.h
+++ b/tools/lib/bpf/libbpf_internal.h
@@ -18,6 +18,7 @@
 #include <unistd.h>
 #include <sys/syscall.h>
 #include <libelf.h>
+#include "libbpf_tools.h"
 #include "relo_core.h"
 
 /* Android's libc doesn't support AT_EACCESS in faccessat() implementation
@@ -247,7 +248,6 @@ struct btf_type;
 struct btf_type *btf_type_by_id(const struct btf *btf, __u32 type_id);
 const char *btf_kind_str(const struct btf_type *t);
 const struct btf_type *skip_mods_and_typedefs(const struct btf *btf, __u32 id, __u32 *res_id);
-const struct btf_header *btf_header(const struct btf *btf);
 void btf_set_base_btf(struct btf *btf, const struct btf *base_btf);
 int btf_relocate(struct btf *btf, const struct btf *base_btf, __u32 **id_map,
 		 __u32 **str_map);
@@ -574,31 +574,6 @@ static inline void bpf_core_relo_bswap(struct bpf_core_relo *i)
 	i->kind = bswap_32(i->kind);
 }
 
-enum btf_field_iter_kind {
-	BTF_FIELD_ITER_IDS,
-	BTF_FIELD_ITER_STRS,
-};
-
-struct btf_field_desc {
-	/* once-per-type offsets */
-	int t_off_cnt, t_offs[2];
-	/* member struct size, or zero, if no members */
-	int m_sz;
-	/* repeated per-member offsets */
-	int m_off_cnt, m_offs[2];
-};
-
-struct btf_field_iter {
-	struct btf_field_desc desc;
-	void *p;
-	int m_idx;
-	int off_idx;
-	int vlen;
-};
-
-int btf_field_iter_init(struct btf_field_iter *it, struct btf_type *t, enum btf_field_iter_kind iter_kind);
-__u32 *btf_field_iter_next(struct btf_field_iter *it);
-
 typedef int (*type_id_visit_fn)(__u32 *type_id, void *ctx);
 typedef int (*str_off_visit_fn)(__u32 *str_off, void *ctx);
 int btf_ext_visit_type_ids(struct btf_ext *btf_ext, type_id_visit_fn visit, void *ctx);
@@ -772,8 +747,5 @@ int elf_resolve_pattern_offsets(const char *binary_path, const char *pattern,
 
 int probe_fd(int fd);
 
-#define SHA256_DIGEST_LENGTH 32
-
-void libbpf_sha256(const void *data, size_t len, __u8 out[SHA256_DIGEST_LENGTH]);
 int probe_sys_bpf_ext(void);
 #endif /* __LIBBPF_LIBBPF_INTERNAL_H */
diff --git a/tools/lib/bpf/libbpf_tools.h b/tools/lib/bpf/libbpf_tools.h
new file mode 100644
index 000000000000..c590ea4312f2
--- /dev/null
+++ b/tools/lib/bpf/libbpf_tools.h
@@ -0,0 +1,46 @@
+/* SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause) */
+#ifndef __LIBBPF_TOOLS_H
+#define __LIBBPF_TOOLS_H
+
+#include <linux/types.h>
+#include <stddef.h>
+
+/* Internal interfaces for kernel tools that link libbpf statically. */
+
+struct btf;
+struct btf_header;
+struct btf_type;
+
+const struct btf_header *btf_header(const struct btf *btf);
+
+enum btf_field_iter_kind {
+	BTF_FIELD_ITER_IDS,
+	BTF_FIELD_ITER_STRS,
+};
+
+struct btf_field_desc {
+	/* once-per-type offsets */
+	int t_off_cnt, t_offs[2];
+	/* member struct size, or zero, if no members */
+	int m_sz;
+	/* repeated per-member offsets */
+	int m_off_cnt, m_offs[2];
+};
+
+struct btf_field_iter {
+	struct btf_field_desc desc;
+	void *p;
+	int m_idx;
+	int off_idx;
+	int vlen;
+};
+
+int btf_field_iter_init(struct btf_field_iter *it, struct btf_type *t,
+			enum btf_field_iter_kind iter_kind);
+__u32 *btf_field_iter_next(struct btf_field_iter *it);
+
+#define SHA256_DIGEST_LENGTH 32
+
+void libbpf_sha256(const void *data, size_t len, __u8 out[SHA256_DIGEST_LENGTH]);
+
+#endif /* __LIBBPF_TOOLS_H */
-- 
2.56.1

