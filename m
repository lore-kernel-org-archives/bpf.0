Received: from mail-wr2-f0.google.com (mail-wr2-f0.google.com [74.125.225.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C836A348C5C
	for <bpf@vger.kernel.org>; Mon, 13 Jul 2026 15:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783957160; cv=none; b=aYi2MPx4cqcZoxNOKF0KmwMNAdKmzg7DDfOwZZtksbnRGGfceWGeXnqGO14Vvz5y3Sd2q4ELyhlY0+hOXpm90eZ3rcwfNF8pn8S+rYIVq+f4k6ib2O3ZzL/vlx7LP9X23r9IXpbkgLzRLSbtfEUwWwg67QnzqXAK2ZutO3n5Faw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783957160; c=relaxed/simple;
	bh=xYI5Dkdmmfbtvhm56WSq5CeiK+sfZnOM99lOvzpeqWU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KqCsQBxdrhYKdww5omUqG257x1zjMnvl9QyOQ7tHmo7Fp8+5MLOd4F2oKAQRAXrCjIegtvOLbaOGEYOfwp+NzuRFRXWS3byo5ExIN7Ck4m/qoDDFfBfgtuEJNQwgQShdq3JFkk0nUpb+Eqr3NJ+haI/fL9WjpQPn2mb2hBIVaLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pRam8+8C; arc=none smtp.client-ip=74.125.225.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pRam8+8C"
Received: by mail-wr2-f0.google.com with SMTP id ffacd0b85a97d-47825ef4012so923041f8f.1
        for <bpf@vger.kernel.org>; Mon, 13 Jul 2026 08:39:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783957155; x=1784561955; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lZBOqqt3ouBLbhYCJ9Psn13Z/ps5zrK0j2NMl/SCAg0=;
        b=pRam8+8CETgAqNXKwe5kgJ3ZOSapm28JwcvIs3pWNFCehT+cwfWqIlW0G59dTAR1ed
         nyrbhxhnoDQgsQyUr/UCe4d7R+Hj3X6jTtgNFC/z967SKiPWCYvcfBHp2QryPNjLLpH1
         GZJYZ+CZ6nmx622Q7OnF6MkfxgatIreZDjnMHyYIF4qSLMDZNoBImK+v1IS0JVSi2mJ5
         YXw+tZgtlxtf/TYrnPCpY7XSowog4MBzr3/lBxtcowbWjnvPZEqZwkFDUBdD6dCyknU9
         joMZIlymWd2JlotGCa3y00B7cgILWYTTQbS/UbH72zKi0XzQVXZ7g1/eloSojRe5oc69
         9oEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783957155; x=1784561955;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=lZBOqqt3ouBLbhYCJ9Psn13Z/ps5zrK0j2NMl/SCAg0=;
        b=VdNSJmKpZJKUAyr7H4mbulFrn+o2f0XjxqCjWNzWg6YEohnJggt7dzbJvhMvZPZx7o
         IPoWzyFw2M6o44gleV1zCaKDFBnORCSyn6hMeMK0+i+myQVdcG+KMCH3+MuPvTN50j9a
         7zVq8ft0qRRtL9hssyoSWmyzBb4l8tsYeZF0WN1ZIeDfNiNTrdoSOhgjiWelVr58KcAC
         oCQqwtRWXk2qp3veq0XlqP2eLezez0HefBRmcTNHBUt+U7vX4SxE9DnHov9ZWXTpYm0x
         3GDn6eU+i6NNaSKN4Kt5FpYWPDSbMvGPNnmVELyJB3q/6IPldq+UOy5uNKcVf52zh3oR
         MBYA==
X-Gm-Message-State: AOJu0YyZXmGsJrSgtQzjlh2YvkDOIXRF49jbxYGST7HNL0q8hacRWaQc
	/IWFaYxSTYcu9MWA6rtGoNf6VjB9/LXwTOUyl5VZgCJRiBdveLUn/R1bUMZenlzM
X-Gm-Gg: AfdE7ckwRPPY1/jXC3+eXjv19kns2wogHq5oNVr/FME7uBrcMe0TmRgvcb5TlHO1HKT
	o9kkcdQiDsopaw7FGeaHa1iwxqph0Z9h5OzSk+pgdgSDtNcWP9uuUDOgs1ox9nsKKtMCXiM+R3D
	fm7Z8ELk/hwJvrVACY8VWtez6LB8jR+FmPX5byFbr8Lw7OJuWN9INaPfX3pi253OIjESaz3YL6N
	Dq6pArBw6lcylhrWFHvkK0WkNARIiJLPcVuTAGe2mLgsk4qW17sYcWkfuyRBcpZTny9pU1PjN+1
	VhwNiu9pahsm8SNcoumOXkO+vXNDfoIJpyDTb8zS7pQjOYE3YEnmrvIHRxq1c2Gm74CVYUY8Bkh
	gR79DswnFTu7EjxtnTBGz3y4RhyAEZXKhilMAaYfG/sadbxRwawgYD2NqRSLaI8GF8FilTXQJca
	g44wI1QJZCtTku0PBIYVAnxOVqZ74SlB5JPoTLADAgZw9ixKKDwNr16BvBbZz7TtrJPc0xQkYLe
	g7wRMsB1P0D5v0S8FOxw+jKCZ/WLoTeTWO26pkHABht9f1pr7zy/7k=
X-Received: by 2002:a5d:64eb:0:b0:472:d154:facf with SMTP id ffacd0b85a97d-47f2dd2bd5fmr12618704f8f.42.1783957154743;
        Mon, 13 Jul 2026 08:39:14 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f4635aa34sm227663f8f.15.2026.07.13.08.39.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 08:39:14 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v3 02/17] bpf: Add source and instruction diagnostic context
Date: Mon, 13 Jul 2026 17:38:51 +0200
Message-ID: <20260713153910.2556007-3-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260713153910.2556007-1-memxor@gmail.com>
References: <20260713153910.2556007-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=25822; i=memxor@gmail.com; h=from:subject; bh=xYI5Dkdmmfbtvhm56WSq5CeiK+sfZnOM99lOvzpeqWU=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JISuURVbrve9uee2Ynzs3q/ht43/AnGoYPuGYmhxTudxlh wMeS752lLIwiHExyIopspT838dkfKLyd6DtMm6YOaxMIEMYuDgFYCK7XRkZvov+mHFJ7GT/52Dv C1X9K3d8rDu7WPdQa9iT1bvmhqRphTEyHC7Sq0rf/2W9pn/9Ph2RdQaZ+7ml/1/eZlAXtaMp4Eg KOwA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Teach verifier diagnostics to annotate an instruction with BTF source
line information and nearby BPF instructions. The renderer keeps source
text in a fixed-width lane and prints instructions in a stable right-hand
gutter.

Wrap annotation text under the source line so long error labels remain
readable while the source and instruction lanes keep their fixed layout.

Keeping source and instruction context in one commit preserves the visual
layout contract that later diagnostic reports rely on.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/linux/bpf.h          |  15 +-
 include/linux/bpf_verifier.h |   4 +
 include/linux/btf.h          |   1 +
 kernel/bpf/btf.c             |  10 +
 kernel/bpf/core.c            |  36 +--
 kernel/bpf/diagnostics.c     | 464 +++++++++++++++++++++++++++++++++++
 kernel/bpf/diagnostics.h     |   9 +
 kernel/bpf/verifier.c        |  32 ++-
 8 files changed, 541 insertions(+), 30 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 31181e0c2b80..9bf3eda75ed3 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -4142,8 +4142,19 @@ static inline bool bpf_is_subprog(const struct bpf_prog *prog)
 }
 
 const struct bpf_line_info *bpf_find_linfo(const struct bpf_prog *prog, u32 insn_off);
-void bpf_get_linfo_file_line(struct btf *btf, const struct bpf_line_info *linfo,
-			     const char **filep, const char **linep, int *nump);
+#define BPF_LINFO_LINE_TRIM 1
+struct bpf_linfo_source {
+	const char *file;
+	const char *line;
+	u32 file_name_off;
+	int line_num;
+	int line_col;
+};
+
+void bpf_get_linfo_source(struct btf *btf, const struct bpf_line_info *linfo,
+			  struct bpf_linfo_source *src, u32 flags);
+void bpf_get_linfo_file_line(struct btf *btf, const struct bpf_line_info *linfo, const char **filep,
+			     const char **linep, int *nump, u32 flags);
 int bpf_prog_get_file_line(struct bpf_prog *prog, unsigned long ip, const char **filep,
 			   const char **linep, int *nump);
 struct bpf_prog *bpf_prog_find_from_stack(void);
diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 317e99b9acc0..3ff27863e34d 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -835,6 +835,7 @@ static inline u16 bpf_in_stack_arg_cnt(const struct bpf_subprog_info *sub)
 	return 0;
 }
 
+struct bpf_diag;
 struct bpf_verifier_env;
 
 struct backtrack_state {
@@ -951,6 +952,7 @@ struct bpf_verifier_env {
 	struct bpf_insn_aux_data *insn_aux_data; /* array of per-insn state */
 	const struct bpf_line_info *prev_linfo;
 	struct bpf_verifier_log log;
+	struct bpf_diag *diag;
 	struct bpf_subprog_info subprog_info[BPF_MAX_SUBPROGS + 2]; /* max + 2 for the fake and exception subprogs */
 	/* subprog indices sorted in topological order: leaves first, callers last */
 	int subprog_topo_order[BPF_MAX_SUBPROGS + 2];
@@ -1425,8 +1427,10 @@ void print_verifier_state(struct bpf_verifier_env *env, const struct bpf_verifie
 void print_insn_state(struct bpf_verifier_env *env, const struct bpf_verifier_state *vstate,
 		      u32 frameno);
 u32 bpf_vlog_alignment(u32 pos);
+const char *bpf_disasm_kfunc_name(void *data, const struct bpf_insn *insn);
 
 struct bpf_subprog_info *bpf_find_containing_subprog(struct bpf_verifier_env *env, int off);
+const char *bpf_verifier_subprog_name(const struct bpf_verifier_env *env, int subprog);
 int bpf_jmp_offset(struct bpf_insn *insn);
 struct bpf_iarray *bpf_insn_successors(struct bpf_verifier_env *env, u32 idx);
 void bpf_fmt_stack_mask(char *buf, ssize_t buf_sz, u64 stack_mask);
diff --git a/include/linux/btf.h b/include/linux/btf.h
index 240401d9b25b..90e865d116b8 100644
--- a/include/linux/btf.h
+++ b/include/linux/btf.h
@@ -213,6 +213,7 @@ int btf_type_seq_show_flags(const struct btf *btf, u32 type_id, void *obj,
  */
 int btf_type_snprintf_show(const struct btf *btf, u32 type_id, void *obj,
 			   char *buf, int len, u64 flags);
+int btf_type_snprintf_show_name(const struct btf *btf, u32 type_id, char *buf, int len);
 
 int btf_get_fd_by_id(u32 id);
 u32 btf_obj_id(const struct btf *btf);
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 8c04c340f499..abe8f6a9f361 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -8297,6 +8297,16 @@ int btf_type_snprintf_show(const struct btf *btf, u32 type_id, void *obj,
 	return ssnprintf.len;
 }
 
+int btf_type_snprintf_show_name(const struct btf *btf, u32 type_id, char *buf, int len)
+{
+	struct btf_show show = {
+		.btf = btf,
+		.state.type_id = type_id,
+	};
+
+	return snprintf(buf, len, "%s", btf_show_name(&show));
+}
+
 #ifdef CONFIG_PROC_FS
 static void bpf_btf_show_fdinfo(struct seq_file *m, struct file *filp)
 {
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 47fe047ad30b..b35721ab3712 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -3460,24 +3460,30 @@ EXPORT_TRACEPOINT_SYMBOL_GPL(xdp_bulk_tx);
 
 #ifdef CONFIG_BPF_SYSCALL
 
-void bpf_get_linfo_file_line(struct btf *btf, const struct bpf_line_info *linfo,
-			     const char **filep, const char **linep, int *nump)
+void bpf_get_linfo_source(struct btf *btf, const struct bpf_line_info *linfo,
+			  struct bpf_linfo_source *src, u32 flags)
 {
-	/* Get base component of the file path. */
-	if (filep) {
-		*filep = btf_name_by_offset(btf, linfo->file_name_off);
-		*filep = kbasename(*filep);
-	}
+	src->file = kbasename(btf_name_by_offset(btf, linfo->file_name_off));
+	src->line = btf_name_by_offset(btf, linfo->line_off);
+	while ((flags & BPF_LINFO_LINE_TRIM) && isspace(*src->line))
+		src->line++;
+	src->file_name_off = linfo->file_name_off;
+	src->line_num = BPF_LINE_INFO_LINE_NUM(linfo->line_col);
+	src->line_col = BPF_LINE_INFO_LINE_COL(linfo->line_col);
+}
 
-	/* Obtain the source line, and strip whitespace in prefix. */
-	if (linep) {
-		*linep = btf_name_by_offset(btf, linfo->line_off);
-		while (isspace(**linep))
-			*linep += 1;
-	}
+void bpf_get_linfo_file_line(struct btf *btf, const struct bpf_line_info *linfo, const char **filep,
+			     const char **linep, int *nump, u32 flags)
+{
+	struct bpf_linfo_source src;
 
+	bpf_get_linfo_source(btf, linfo, &src, flags);
+	if (filep)
+		*filep = src.file;
+	if (linep)
+		*linep = src.line;
 	if (nump)
-		*nump = BPF_LINE_INFO_LINE_NUM(linfo->line_col);
+		*nump = src.line_num;
 }
 
 const struct bpf_line_info *bpf_find_linfo(const struct bpf_prog *prog, u32 insn_off)
@@ -3551,7 +3557,7 @@ int bpf_prog_get_file_line(struct bpf_prog *prog, unsigned long ip, const char *
 	if (idx == -1)
 		return -ENOENT;
 
-	bpf_get_linfo_file_line(btf, &linfo[idx], filep, linep, nump);
+	bpf_get_linfo_file_line(btf, &linfo[idx], filep, linep, nump, BPF_LINFO_LINE_TRIM);
 	return 0;
 }
 
diff --git a/kernel/bpf/diagnostics.c b/kernel/bpf/diagnostics.c
index 6d28a3481cfa..49106115621d 100644
--- a/kernel/bpf/diagnostics.c
+++ b/kernel/bpf/diagnostics.c
@@ -1,12 +1,16 @@
 // SPDX-License-Identifier: GPL-2.0-only
 // Copyright (c) 2026 Meta Platforms, Inc. and affiliates.
 
+#include <linux/bpf.h>
 #include <linux/bpf_verifier.h>
+#include <linux/btf.h>
 #include <linux/ctype.h>
+#include <linux/kernel.h>
 #include <linux/slab.h>
 #include <linux/stdarg.h>
 #include <linux/string.h>
 
+#include "disasm.h"
 #include "diagnostics.h"
 
 #define CATEGORY_MEMORY_SAFETY "Memory Safety"
@@ -21,12 +25,136 @@
 
 #define BPF_DIAG_TEXT_WIDTH 100
 #define BPF_DIAG_TEXT_INDENT "  "
+#define BPF_DIAG_MSG_LEN 512
+#define BPF_DIAG_CONTEXT 2
+#define BPF_DIAG_CONTEXT_CNT (1 + BPF_DIAG_CONTEXT * 2)
+#define BPF_DIAG_SOURCE_LANE_WIDTH 88
+#define BPF_DIAG_TAB_WIDTH 8
+#define BPF_DIAG_REG_DESC_LEN 512
+#define BPF_DIAG_REG_TMP_LEN 192
+#define BPF_DIAG_SCRATCH_STR_CNT 3
+#define BPF_DIAG_SCRATCH_STR_LEN 256
+#define BPF_DIAG_TEXT_LEN 160
+
+struct bpf_diag_source_line {
+	const char *line;
+	int line_num;
+};
+
+struct bpf_diag_insn {
+	char text[BPF_DIAG_TEXT_LEN];
+	int idx;
+	bool valid;
+};
+
+struct bpf_diag_insn_buf {
+	char *buf;
+	size_t size;
+	size_t len;
+};
+
+struct bpf_diag_insn_ctx {
+	struct bpf_verifier_env *env;
+	struct bpf_diag_insn_buf buf;
+};
+
+struct bpf_diag_scratch {
+	char str[BPF_DIAG_SCRATCH_STR_CNT][BPF_DIAG_SCRATCH_STR_LEN];
+	struct bpf_linfo_source source;
+	struct bpf_diag_source_line source_lines[BPF_DIAG_CONTEXT_CNT];
+	struct bpf_diag_insn insns[BPF_DIAG_CONTEXT_CNT];
+};
+
+struct bpf_diag {
+	struct bpf_diag_scratch scratch;
+};
 
 bool bpf_diag_enabled(const struct bpf_verifier_env *env)
 {
 	return env->log.level & BPF_LOG_LEVEL;
 }
 
+static struct bpf_diag *diag_env(struct bpf_verifier_env *env)
+{
+	return env->diag;
+}
+
+int bpf_diag_init(struct bpf_verifier_env *env)
+{
+	if (!bpf_diag_enabled(env))
+		return 0;
+
+	env->diag = kzalloc_obj(struct bpf_diag, GFP_KERNEL_ACCOUNT);
+	return env->diag ? 0 : -ENOMEM;
+}
+
+static struct bpf_diag_scratch *diag_scratch(struct bpf_verifier_env *env)
+{
+	struct bpf_diag *diag = diag_env(env);
+
+	return diag ? &diag->scratch : NULL;
+}
+
+char *bpf_diag_scratch_buf(struct bpf_verifier_env *env, unsigned int slot, size_t *size)
+{
+	struct bpf_diag_scratch *scratch = diag_scratch(env);
+	char *buf = NULL;
+	size_t buf_size = 0;
+
+	if (!scratch)
+		goto out;
+
+	if ((unsigned int)slot >= BPF_DIAG_SCRATCH_STR_CNT)
+		goto out;
+
+	buf = scratch->str[slot];
+	buf_size = sizeof(scratch->str[slot]);
+
+out:
+	if (size)
+		*size = buf_size;
+	return buf;
+}
+
+const char *bpf_diag_scratch_strcpy(struct bpf_verifier_env *env, unsigned int slot,
+				    const char *str)
+{
+	size_t size;
+	char *buf = bpf_diag_scratch_buf(env, slot, &size);
+
+	if (!buf)
+		return "";
+	strscpy(buf, str ?: "", size);
+	return buf;
+}
+
+const char *bpf_diag_scratch_printf(struct bpf_verifier_env *env, unsigned int slot,
+				    const char *fmt, ...)
+{
+	size_t size;
+	va_list args;
+	char *buf = bpf_diag_scratch_buf(env, slot, &size);
+
+	if (!buf)
+		return "";
+
+	va_start(args, fmt);
+	vscnprintf(buf, size, fmt, args);
+	va_end(args);
+	return buf;
+}
+
+void bpf_diag_free(struct bpf_verifier_env *env)
+{
+	struct bpf_diag *diag = env->diag;
+
+	if (!diag)
+		return;
+
+	kfree(diag);
+	env->diag = NULL;
+}
+
 static void diag_log(struct bpf_verifier_env *env, const char *fmt, ...)
 {
 	va_list args;
@@ -96,6 +224,238 @@ static void diag_vprint_indented(struct bpf_verifier_env *env, const char *fmt,
 	kfree(buf);
 }
 
+static int diag_line_width(unsigned int line)
+{
+	int width = 1;
+
+	while (line >= 10) {
+		line /= 10;
+		width++;
+	}
+
+	return width;
+}
+
+static const char *diag_func_name(struct bpf_verifier_env *env, u32 insn_idx)
+{
+	const struct bpf_subprog_info *subprog;
+	int subprogno;
+
+	subprog = bpf_find_containing_subprog(env, insn_idx);
+	if (!subprog)
+		return NULL;
+
+	subprogno = subprog - env->subprog_info;
+	return bpf_verifier_subprog_name(env, subprogno);
+}
+
+static bool diag_fill_source(struct bpf_verifier_env *env, const struct bpf_line_info *linfo,
+			     struct bpf_linfo_source *src)
+{
+	if (!env->prog->aux->btf)
+		return false;
+
+	bpf_get_linfo_source(env->prog->aux->btf, linfo, src, 0);
+	return src->file && *src->file && src->line && *src->line;
+}
+
+static bool diag_get_source(struct bpf_verifier_env *env, u32 insn_idx,
+			    struct bpf_linfo_source *src)
+{
+	const struct bpf_line_info *linfo;
+
+	linfo = bpf_find_linfo(env->prog, insn_idx);
+	if (!linfo)
+		return false;
+
+	return diag_fill_source(env, linfo, src);
+}
+
+static void diag_fill_source_lines(struct bpf_verifier_env *env, const struct bpf_linfo_source *src,
+				   int start_line, int end_line, struct bpf_diag_source_line *lines)
+{
+	const struct bpf_line_info *linfo = env->prog->aux->linfo;
+	struct btf *btf = env->prog->aux->btf;
+	u32 i;
+
+	for (i = 0; i < BPF_DIAG_CONTEXT_CNT; i++)
+		lines[i].line_num = start_line + i;
+
+	if (!btf || !env->prog->aux->nr_linfo)
+		return;
+
+	for (i = 0; i < env->prog->aux->nr_linfo; i++) {
+		struct bpf_linfo_source line_src;
+		int idx;
+
+		bpf_get_linfo_source(btf, &linfo[i], &line_src, 0);
+		if (line_src.file_name_off != src->file_name_off ||
+		    line_src.line_num < start_line || line_src.line_num > end_line ||
+		    !line_src.line || !*line_src.line)
+			continue;
+
+		idx = line_src.line_num - start_line;
+		if (!lines[idx].line)
+			lines[idx].line = line_src.line;
+	}
+}
+
+static int diag_line_indent(const char *line)
+{
+	int indent = 0;
+
+	while (*line == ' ' || *line == '\t') {
+		if (*line == '\t')
+			indent = round_up(indent + 1, BPF_DIAG_TAB_WIDTH);
+		else
+			indent++;
+		line++;
+	}
+
+	return indent;
+}
+
+static void diag_insn_print(void *private_data, const char *fmt, ...)
+{
+	struct bpf_diag_insn_ctx *ctx = private_data;
+	struct bpf_diag_insn_buf *buf = &ctx->buf;
+	va_list args;
+
+	if (buf->len >= buf->size)
+		return;
+
+	va_start(args, fmt);
+	buf->len += vscnprintf(buf->buf + buf->len, buf->size - buf->len, fmt, args);
+	va_end(args);
+}
+
+static const char *diag_disasm_kfunc_name(void *private_data, const struct bpf_insn *insn)
+{
+	struct bpf_diag_insn_ctx *ctx = private_data;
+
+	return bpf_disasm_kfunc_name(ctx->env, insn);
+}
+
+static void diag_format_insn(struct bpf_verifier_env *env, int insn_idx,
+			     struct bpf_diag_insn *diag_insn)
+{
+	struct bpf_insn *insn;
+	struct bpf_diag_insn_ctx ctx = {
+		.env = env,
+		.buf = {
+			.buf = diag_insn->text,
+			.size = sizeof(diag_insn->text),
+		},
+	};
+	const struct bpf_insn_cbs cbs = {
+		.cb_call = diag_disasm_kfunc_name,
+		.cb_print = diag_insn_print,
+		.private_data = &ctx,
+	};
+
+	diag_insn->idx = insn_idx;
+	diag_insn->valid = false;
+	diag_insn->text[0] = '\0';
+
+	if (insn_idx < 0 || insn_idx >= env->prog->len)
+		return;
+
+	if (insn_idx > 0 && bpf_is_ldimm64(&env->prog->insnsi[insn_idx - 1]))
+		return;
+
+	insn = &env->prog->insnsi[insn_idx];
+	if (bpf_is_ldimm64(insn) && insn_idx + 1 >= env->prog->len)
+		return;
+
+	print_bpf_insn(&cbs, insn, env->allow_ptr_leaks);
+	while (ctx.buf.len && diag_insn->text[ctx.buf.len - 1] == '\n')
+		diag_insn->text[--ctx.buf.len] = '\0';
+
+	diag_insn->valid = true;
+}
+
+static void diag_format_source_text(char *buf, size_t size, const char *line, int width)
+{
+	int col = 0, len = 0;
+
+	if (!size)
+		return;
+	if (width <= 0) {
+		buf[0] = '\0';
+		return;
+	}
+
+	line = line ?: "...";
+	while (*line && col < width && len + 1 < size) {
+		if (*line == '\t') {
+			int next = round_up(col + 1, BPF_DIAG_TAB_WIDTH);
+
+			while (col < next && col < width && len + 1 < size) {
+				buf[len++] = ' ';
+				col++;
+			}
+			line++;
+			continue;
+		}
+
+		buf[len++] = *line++;
+		col++;
+	}
+
+	if (*line) {
+		int ellipsis_len = min(3, width);
+
+		while (len > 0 && col > width - ellipsis_len) {
+			len--;
+			col--;
+		}
+		while (ellipsis_len-- && len + 1 < size)
+			buf[len++] = '.';
+	}
+
+	buf[len] = '\0';
+}
+
+static void diag_format_source_lane(char *buf, size_t size, const char *source_prefix,
+				    int source_line_width, int line_num, const char *line)
+{
+	int len, text_width;
+
+	if (line_num <= 0) {
+		buf[0] = '\0';
+		return;
+	}
+
+	len = scnprintf(buf, size, "%s%*d | ", source_prefix, source_line_width, line_num);
+	if (len >= (int)size)
+		return;
+
+	text_width = BPF_DIAG_SOURCE_LANE_WIDTH - len;
+	diag_format_source_text(buf + len, size - len, line, text_width);
+}
+
+static void diag_print_source_line(struct bpf_verifier_env *env, const char *source_prefix,
+				   int source_line_width, const struct bpf_diag_source_line *line)
+{
+	size_t source_lane_size;
+	char *source_lane;
+
+	source_lane = bpf_diag_scratch_buf(env, 0, &source_lane_size);
+	diag_format_source_lane(source_lane, source_lane_size, source_prefix, source_line_width,
+				line->line_num, line->line);
+	diag_write(env, "  %s\n", source_lane);
+}
+
+static void diag_print_insn_line(struct bpf_verifier_env *env,
+				 const struct bpf_diag_insn *diag_insn, int focus_insn_idx,
+				 int insn_width)
+{
+	if (!diag_insn->valid)
+		return;
+	diag_write(env, "  %s%*d | %s\n", diag_insn->idx == focus_insn_idx ? ">>> " : "    ",
+		   insn_width, diag_insn->idx, diag_insn->text);
+}
+
 void bpf_diag_report_header(struct bpf_verifier_env *env, const char *category, const char *problem)
 {
 	char first;
@@ -155,3 +515,107 @@ static void diag_report_suggestion(struct bpf_verifier_env *env, const char *fmt
 	va_end(args);
 	diag_log(env, "\n");
 }
+
+static void diag_print_source_annotation(struct bpf_verifier_env *env, int line_width, int indent,
+					 const char *label, const char *msg)
+{
+	size_t first_prefix_size, next_prefix_size;
+	char *first_prefix, *next_prefix;
+	char *text;
+
+	first_prefix = bpf_diag_scratch_buf(env, 0, &first_prefix_size);
+	next_prefix = bpf_diag_scratch_buf(env, 1, &next_prefix_size);
+	indent = min_t(int, indent, max_t(int, 0, BPF_DIAG_SOURCE_LANE_WIDTH - line_width - 8));
+	text = kasprintf(GFP_KERNEL_ACCOUNT, "%s: %s", label, msg);
+	if (!text) {
+		diag_write(env, "  %*s | %*s^-- %s: %s\n", line_width + 4, "", indent, "", label,
+			   msg);
+		return;
+	}
+
+	scnprintf(first_prefix, first_prefix_size, "  %*s | %*s^-- ", line_width + 4, "", indent,
+		  "");
+	scnprintf(next_prefix, next_prefix_size, "  %*s | %*s    ", line_width + 4, "", indent, "");
+
+	diag_print_wrapped_prefixed(env, first_prefix, next_prefix, text);
+	kfree(text);
+}
+
+void bpf_diag_report_source(struct bpf_verifier_env *env, u32 insn_idx, const char *label,
+			    const char *fmt, ...)
+{
+	struct bpf_diag_scratch *scratch;
+	struct bpf_diag_source_line *source_lines;
+	struct bpf_diag_insn *diag_insn;
+	struct bpf_linfo_source *src;
+	char *msg;
+	const char *func;
+	int start_line, end_line, width, indent, insn_width, i;
+	va_list args;
+
+	if (!bpf_diag_enabled(env))
+		return;
+
+	va_start(args, fmt);
+	msg = kvasprintf(GFP_KERNEL_ACCOUNT, fmt, args);
+	va_end(args);
+	if (!msg)
+		msg = kstrdup("<failed to allocate diagnostic text>", GFP_KERNEL_ACCOUNT);
+	if (!msg)
+		return;
+
+	label = label ?: "note";
+	scratch = diag_scratch(env);
+
+	src = &scratch->source;
+	source_lines = scratch->source_lines;
+	diag_insn = scratch->insns;
+	memset(source_lines, 0, sizeof(scratch->source_lines));
+	memset(diag_insn, 0, sizeof(scratch->insns));
+
+	if (!diag_get_source(env, insn_idx, src)) {
+		diag_log(env, "  insn %u\n", insn_idx);
+		diag_print_source_annotation(env, 0, 0, label, msg);
+		goto out_free_msg;
+	}
+
+	func = diag_func_name(env, insn_idx);
+	if (func && *func)
+		diag_log(env, "  %s @ %s:%d:%d\n", func, src->file, src->line_num, src->line_col);
+	else
+		diag_log(env, "  %s:%d:%d\n", src->file, src->line_num, src->line_col);
+
+	start_line = src->line_num - BPF_DIAG_CONTEXT;
+	end_line = src->line_num + BPF_DIAG_CONTEXT;
+	width = diag_line_width(end_line);
+	indent = diag_line_indent(src->line);
+	insn_width = diag_line_width(env->prog->len ? env->prog->len - 1 : 0);
+	diag_fill_source_lines(env, src, start_line, end_line, source_lines);
+
+	for (i = 0; i < BPF_DIAG_CONTEXT_CNT; i++) {
+		int row = i - BPF_DIAG_CONTEXT;
+
+		diag_format_insn(env, insn_idx + row, &diag_insn[i]);
+	}
+
+	/*
+	 * Source lines and BPF instructions are independent context windows.
+	 * Only their focused entries describe the same location, so render
+	 * separate blocks instead of pairing neighboring rows.
+	 */
+	diag_write(env, "  Source context:\n");
+	for (i = 0; i < BPF_DIAG_CONTEXT_CNT; i++) {
+		const char *source_prefix;
+
+		source_prefix = source_lines[i].line_num == src->line_num ? ">>> " : "    ";
+		diag_print_source_line(env, source_prefix, width, &source_lines[i]);
+		if (source_lines[i].line_num == src->line_num)
+			diag_print_source_annotation(env, width, indent, label, msg);
+	}
+	diag_write(env, "  Instruction context:\n");
+	for (i = 0; i < BPF_DIAG_CONTEXT_CNT; i++)
+		diag_print_insn_line(env, &diag_insn[i], insn_idx, insn_width);
+
+out_free_msg:
+	kfree(msg);
+}
diff --git a/kernel/bpf/diagnostics.h b/kernel/bpf/diagnostics.h
index be7ad5142726..d852386bf5f2 100644
--- a/kernel/bpf/diagnostics.h
+++ b/kernel/bpf/diagnostics.h
@@ -10,7 +10,16 @@
 struct bpf_verifier_env;
 
 bool bpf_diag_enabled(const struct bpf_verifier_env *env);
+int bpf_diag_init(struct bpf_verifier_env *env);
+char *bpf_diag_scratch_buf(struct bpf_verifier_env *env, unsigned int slot, size_t *size);
+const char *bpf_diag_scratch_strcpy(struct bpf_verifier_env *env, unsigned int slot,
+				    const char *str);
+const char *bpf_diag_scratch_printf(struct bpf_verifier_env *env, unsigned int slot,
+				    const char *fmt, ...) __printf(3, 4);
+void bpf_diag_free(struct bpf_verifier_env *env);
 void bpf_diag_report_header(struct bpf_verifier_env *env, const char *category,
 			    const char *problem);
+void bpf_diag_report_source(struct bpf_verifier_env *env, u32 insn_idx, const char *label,
+			    const char *fmt, ...) __printf(4, 5);
 
 #endif /* __BPF_DIAGNOSTICS_H */
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 03e2202cca13..4f127c8db134 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -34,6 +34,7 @@
 #include <linux/trace_events.h>
 #include <linux/kallsyms.h>
 
+#include "diagnostics.h"
 #include "disasm.h"
 
 static const struct bpf_verifier_ops * const bpf_verifier_ops[] = {
@@ -425,7 +426,7 @@ static bool subprog_returns_void(struct bpf_verifier_env *env, int subprog)
 	return btf_type_is_void(type);
 }
 
-static const char *subprog_name(const struct bpf_verifier_env *env, int subprog)
+const char *bpf_verifier_subprog_name(const struct bpf_verifier_env *env, int subprog)
 {
 	struct bpf_func_info *info;
 
@@ -3014,8 +3015,8 @@ static int sort_subprogs_topo(struct bpf_verifier_env *env)
 					if (bpf_pseudo_func(&insn[idx]))
 						continue;
 					verbose(env, "recursive call from %s() to %s()\n",
-						subprog_name(env, cur),
-						subprog_name(env, callee));
+						bpf_verifier_subprog_name(env, cur),
+						bpf_verifier_subprog_name(env, callee));
 					ret = -EINVAL;
 					goto out;
 				}
@@ -3035,8 +3036,8 @@ static int sort_subprogs_topo(struct bpf_verifier_env *env)
 
 	if (env->log.level & BPF_LOG_LEVEL2)
 		for (i = 0; i < cnt; i++)
-			verbose(env, "topo_order[%d] = %s\n",
-				i, subprog_name(env, env->subprog_topo_order[i]));
+			verbose(env, "topo_order[%d] = %s\n", i,
+				bpf_verifier_subprog_name(env, env->subprog_topo_order[i]));
 out:
 	kvfree(dfs_stack);
 	kvfree(color);
@@ -3290,7 +3291,7 @@ static void linked_regs_unpack(u64 val, struct linked_regs *s)
 	}
 }
 
-static const char *disasm_kfunc_name(void *data, const struct bpf_insn *insn)
+const char *bpf_disasm_kfunc_name(void *data, const struct bpf_insn *insn)
 {
 	const struct btf_type *func;
 	struct btf *desc_btf;
@@ -3309,9 +3310,9 @@ static const char *disasm_kfunc_name(void *data, const struct bpf_insn *insn)
 void bpf_verbose_insn(struct bpf_verifier_env *env, struct bpf_insn *insn)
 {
 	const struct bpf_insn_cbs cbs = {
-		.cb_call	= disasm_kfunc_name,
-		.cb_print	= verbose,
-		.private_data	= env,
+		.cb_call = bpf_disasm_kfunc_name,
+		.cb_print = verbose,
+		.private_data = env,
 	};
 
 	print_bpf_insn(&cbs, insn, env->allow_ptr_leaks);
@@ -9439,7 +9440,7 @@ static int check_func_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 	if (err == -EFAULT)
 		return err;
 	if (bpf_subprog_is_global(env, subprog)) {
-		const char *sub_name = subprog_name(env, subprog);
+		const char *sub_name = bpf_verifier_subprog_name(env, subprog);
 
 		if (env->cur_state->active_locks) {
 			verbose(env, "global function calls are not allowed while holding a lock,\n"
@@ -18515,7 +18516,7 @@ static int do_check_common(struct bpf_verifier_env *env, int subprog)
 
 	regs = state->frame[state->curframe]->regs;
 	if (subprog || env->prog->type == BPF_PROG_TYPE_EXT) {
-		const char *sub_name = subprog_name(env, subprog);
+		const char *sub_name = bpf_verifier_subprog_name(env, subprog);
 		struct bpf_subprog_arg_info *arg;
 		struct bpf_reg_state *reg;
 
@@ -18685,8 +18686,9 @@ static int do_check_subprogs(struct bpf_verifier_env *env)
 		if (ret) {
 			return ret;
 		} else if (env->log.level & BPF_LOG_LEVEL) {
-			verbose(env, "Func#%d ('%s') is safe for any args that match its prototype\n",
-				i, subprog_name(env, i));
+			verbose(env,
+				"Func#%d ('%s') is safe for any args that match its prototype\n", i,
+				bpf_verifier_subprog_name(env, i));
 		}
 
 		/* We verified new global subprog, it might have called some
@@ -20081,6 +20083,9 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr,
 	ret = bpf_vlog_init(&env->log, attr_log->level, attr_log->ubuf, attr_log->size);
 	if (ret)
 		goto err_free_env;
+	ret = bpf_diag_init(env);
+	if (ret)
+		goto err_prep;
 	if (env->signature) {
 		ret = bpf_prog_calc_tag(env->prog);
 		if (ret < 0)
@@ -20362,6 +20367,7 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr,
 	kvfree(env->scc_info);
 	kvfree(env->succ);
 	kvfree(env->gotox_tmp_buf);
+	bpf_diag_free(env);
 	kvfree(env);
 	return ret;
 }
-- 
2.53.0

