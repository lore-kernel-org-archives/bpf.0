Received: from mail-wm2-f8.google.com (mail-wm2-f8.google.com [74.125.225.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB96E42DFE6
	for <bpf@vger.kernel.org>; Wed, 12 Aug 2026 23:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786577616; cv=none; b=o3ZBEe8KDMIonRr7zwqhmmAx+JG79ft+3e4V+8ESczV4H8kdV/RyIkrcE7kCQzlbRVYJTeLBE/aMZczqK+jtb8c96suMT+lI0RsW0q3ggGKGoyYyzWS1Yr0amZdo0RmQEeb61JJ+S1zPqyit/HYLmiT6OlI620hf4EILm9xeupM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786577616; c=relaxed/simple;
	bh=1u4nwWxAjDX5WTq0Bi+zKbzRm/wSgOgymQ7oisDht/4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kfklV6br2LWDCOhfAhea5JKGpOdDBTMpnTUWbbqSwhopT7kWMce6U8QaDbH/JEVUzxP6lW2tR4k3WcGif97LI4LxoQ2mEcTAfuk33fdR7kK6EBqZOoiHe/06VkgYNnmXLgQZ6aOXS+I3jeMkrYosGLKmCcR+Z/GMXESt1EpWV7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CVW7YYGI; arc=none smtp.client-ip=74.125.225.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CVW7YYGI"
Received: by mail-wm2-f8.google.com with SMTP id 5b1f17b1804b1-4956bc73c0eso3997235e9.1
        for <bpf@vger.kernel.org>; Wed, 12 Aug 2026 16:33:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786577612; x=1787182412; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UrTa8H3PYLXzx951ZvVYCwPtcZL5UZ5I5IqVPooQRIw=;
        b=CVW7YYGIBIUpdx3nDlsVvPF/QxdTEQ40P3vdbJYQKXWldQGtPBtJ3wTQBrgejXUwWY
         HQzpNRAZ3i6Y5/vFAQU6qBbQ4kC67MRdRaG4LztrI2MSek7vTe5U7Gs0CP4ausO3pauX
         DzKNFMj93u/8rUumKIaQdITZuMVHpnODKs4uQUdzFQyym6b0tcRP7EstuoaXeBhAio+o
         vUpQAkX1FDgzXSnPRNW6nP8Hc867Jlo1aFjdzfVM1krjTj0gDisT/XVIx5qvOsEv/FaL
         RqCJ9aYvuwxCxQkmBoGJEojxRvGIsUaETlqR/9XnJ+dyWaFneZpa3kC2Y9IdFPAYg2fD
         WwRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786577612; x=1787182412;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=UrTa8H3PYLXzx951ZvVYCwPtcZL5UZ5I5IqVPooQRIw=;
        b=no3nJH/74NEDPlSriVbRxqyejgfdJxq9k/93z4vPauFy8yLAMV8t0SL4BbEsHdR/Gg
         2f7cbL2cJpR6YeO3+a2ERvLvz+/J2P46CzIpkPPE63HQtfoCjmWQbzLh591eIZGOzp51
         ImV/AsTYnvXJcPV2gsp/0JjLV0jYm6GoIBEhFny0vgHWz2joj/fBUN8sEYAkAPcinXuE
         OG7aR680G+JEKe7LBUQaWrR+RGtRJMcNqbUwVP/soZ6MeoxhrjrUvkV0YP2n9g38va0R
         z2TFO/T303NfF7DEDL73H20TQJr5scuo5E0GTkgM5UiGTI0Vjsqu+pUIuNl4LV4ziMLZ
         qnOA==
X-Gm-Message-State: AOJu0YyKX4hC3EiQZFKeCBkpIczPI1839X1eX/QbIx9S0QtgT/GRHAwE
	jOdZexTdhvwQiZulQuUTd98ifFBEpnZmp2RIcPzXMUswQhoO71FJxiEQzX9HYPoS
X-Gm-Gg: AR+sD10n09uOO3ZM+FM07D+fm9u51Im/yJh/9IfaRsAp2WKCiKCrtiqWow8IKiUhPnj
	vy+tvRNHWKxT9+JXjtUK3CM3c5aN7+JuK5VBCzoO2cc93XbH5Nrcg3y+zgoVWfiR80c48l2G6lk
	HR27wO+S45MJd55ATwdBwOf1DWN2FJBrCBFRQZG6E6BHyyppiqOrDxIxOIsqcsbMXzbQLr9k+5v
	Fq4xX5BkVBFDOmQsr3Q+QNGQh2Mb/Cioeld/pwLT48/oNbKr6kDSM+1l4WlgQleAwUbVqiptaMW
	by482IcDqcle8Ff3YCb4ecK05+YFSgVrh1YeBg152z7lsCG8lvg9nY9j5rlMYxWbQl4lXG6cXTR
	cqhLEjsIpuceeqC3eBPfrH72eh3BMyP52MzwY+3abyKmcjXHxTOgWaVcaL79FbC7u1l0O3rQBsw
	N71hrccfxvmifTN5DURaZxJsLklVlpxWfjgp+q4kcWK9aOtyF0JD56JWhkmEOIZTrTpqIyTp5DR
	l8D4DgBJE3Li8HZ+JqoRti/CMoc4ai/h3/4aiPuTBGEg/o4mVqXvnFV5swY58WCfw3KxT2qiTjT
	J3tjFw5QJ3g1tZzOGs+g/saDI9jIkJ1U/ErzKg==
X-Received: by 2002:a05:600c:1c25:b0:499:726c:d658 with SMTP id 5b1f17b1804b1-499821d91d9mr10086765e9.19.1786577611841;
        Wed, 12 Aug 2026 16:33:31 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49982131261sm26377595e9.8.2026.08.12.16.33.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 16:33:31 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v4 02/16] bpf: Add source and instruction diagnostic context
Date: Thu, 13 Aug 2026 01:33:05 +0200
Message-ID: <20260812233326.3575958-3-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260812233326.3575958-1-memxor@gmail.com>
References: <20260812233326.3575958-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=26765; i=memxor@gmail.com; h=from:subject; bh=1u4nwWxAjDX5WTq0Bi+zKbzRm/wSgOgymQ7oisDht/4=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIauWQZPD+0Te3Wql12lCFlUBWYmRT7ef/yX2+feKcPsZB ZLxD406SlkYxLgYZMUUWUr+72MyPlH5O9B2GTfMHFYmkCEMXJwCMJGYe4wMr8SfCT5MvbNxwQTb +TN/HJink2rxq+GZeFv9QYOfbZWfDjD8L/590mntKseXOcZ7Tp6ZXvJI1znKpOyfwzT1J61LW7b 6MgMA
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
 include/linux/bpf.h          |  13 +-
 include/linux/bpf_verifier.h |   4 +
 include/linux/btf.h          |   1 +
 kernel/bpf/btf.c             |  10 +
 kernel/bpf/core.c            |  35 ++-
 kernel/bpf/diagnostics.c     | 511 +++++++++++++++++++++++++++++++++++
 kernel/bpf/diagnostics.h     |   8 +
 kernel/bpf/verifier.c        |  32 ++-
 8 files changed, 581 insertions(+), 33 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index b4a10c9878cf..7aad3bbed412 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -4147,8 +4147,17 @@ static inline bool bpf_is_subprog(const struct bpf_prog *prog)
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
 int bpf_prog_get_file_line(struct bpf_prog *prog, unsigned long ip, const char **filep,
 			   const char **linep, int *nump);
 struct bpf_prog *bpf_prog_find_from_stack(void);
diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 93f7c2075eea..14cc174d31c1 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -830,6 +830,7 @@ static inline u16 bpf_in_stack_arg_cnt(const struct bpf_subprog_info *sub)
 	return 0;
 }
 
+struct bpf_diag;
 struct bpf_verifier_env;
 
 struct backtrack_state {
@@ -946,6 +947,7 @@ struct bpf_verifier_env {
 	struct bpf_insn_aux_data *insn_aux_data; /* array of per-insn state */
 	const struct bpf_line_info *prev_linfo;
 	struct bpf_verifier_log log;
+	struct bpf_diag *diag;
 	struct bpf_subprog_info subprog_info[BPF_MAX_SUBPROGS + 2]; /* max + 2 for the fake and exception subprogs */
 	/* subprog indices sorted in topological order: leaves first, callers last */
 	int subprog_topo_order[BPF_MAX_SUBPROGS + 2];
@@ -1429,8 +1431,10 @@ void print_verifier_state(struct bpf_verifier_env *env, const struct bpf_verifie
 void print_insn_state(struct bpf_verifier_env *env, const struct bpf_verifier_state *vstate,
 		      u32 frameno);
 u32 bpf_vlog_alignment(u32 pos);
+const char *bpf_disasm_kfunc_name(void *data, const struct bpf_insn *insn);
 
 struct bpf_subprog_info *bpf_find_containing_subprog(struct bpf_verifier_env *env, int off);
+const char *bpf_subprog_name(const struct bpf_verifier_env *env, int subprog);
 int bpf_jmp_offset(struct bpf_insn *insn);
 struct bpf_iarray *bpf_insn_successors(struct bpf_verifier_env *env, u32 idx);
 void bpf_fmt_stack_mask(char *buf, ssize_t buf_sz, u64 stack_mask);
diff --git a/include/linux/btf.h b/include/linux/btf.h
index 3f5255d095a2..d81e42551365 100644
--- a/include/linux/btf.h
+++ b/include/linux/btf.h
@@ -214,6 +214,7 @@ int btf_type_seq_show_flags(const struct btf *btf, u32 type_id, void *obj,
  */
 int btf_type_snprintf_show(const struct btf *btf, u32 type_id, void *obj,
 			   char *buf, int len, u64 flags);
+int btf_type_snprintf_show_name(const struct btf *btf, u32 type_id, char *buf, int len);
 
 int btf_get_fd_by_id(u32 id);
 u32 btf_obj_id(const struct btf *btf);
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 6606187ed4f4..5a6bab348aa1 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -8317,6 +8317,16 @@ int btf_type_snprintf_show(const struct btf *btf, u32 type_id, void *obj,
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
index a3e1fae32eac..92b6b9d1f770 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -3477,24 +3477,16 @@ EXPORT_TRACEPOINT_SYMBOL_GPL(xdp_bulk_tx);
 
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
-
-	/* Obtain the source line, and strip whitespace in prefix. */
-	if (linep) {
-		*linep = btf_name_by_offset(btf, linfo->line_off);
-		while (isspace(**linep))
-			*linep += 1;
-	}
-
-	if (nump)
-		*nump = BPF_LINE_INFO_LINE_NUM(linfo->line_col);
+	src->file = kbasename(btf_name_by_offset(btf, linfo->file_name_off));
+	src->line = btf_name_by_offset(btf, linfo->line_off);
+	while ((flags & BPF_LINFO_LINE_TRIM) && isspace(*src->line))
+		src->line++;
+	src->file_name_off = linfo->file_name_off;
+	src->line_num = BPF_LINE_INFO_LINE_NUM(linfo->line_col);
+	src->line_col = BPF_LINE_INFO_LINE_COL(linfo->line_col);
 }
 
 const struct bpf_line_info *bpf_find_linfo(const struct bpf_prog *prog, u32 insn_off)
@@ -3537,6 +3529,7 @@ const struct bpf_line_info *bpf_find_linfo(const struct bpf_prog *prog, u32 insn
 int bpf_prog_get_file_line(struct bpf_prog *prog, unsigned long ip, const char **filep,
 			   const char **linep, int *nump)
 {
+	struct bpf_linfo_source src;
 	int idx = -1, insn_start, insn_end, len;
 	struct bpf_line_info *linfo;
 	void **jited_linfo;
@@ -3568,7 +3561,13 @@ int bpf_prog_get_file_line(struct bpf_prog *prog, unsigned long ip, const char *
 	if (idx == -1)
 		return -ENOENT;
 
-	bpf_get_linfo_file_line(btf, &linfo[idx], filep, linep, nump);
+	bpf_get_linfo_source(btf, &linfo[idx], &src, BPF_LINFO_LINE_TRIM);
+	if (filep)
+		*filep = src.file;
+	if (linep)
+		*linep = src.line;
+	if (nump)
+		*nump = src.line_num;
 	return 0;
 }
 
diff --git a/kernel/bpf/diagnostics.c b/kernel/bpf/diagnostics.c
index ba57aabd399f..77dcffb9adee 100644
--- a/kernel/bpf/diagnostics.c
+++ b/kernel/bpf/diagnostics.c
@@ -1,10 +1,18 @@
 // SPDX-License-Identifier: GPL-2.0-only
 // Copyright (c) 2026 Meta Platforms, Inc. and affiliates.
 
+#include <linux/bpf.h>
 #include <linux/bpf_verifier.h>
+#include <linux/btf.h>
 #include <linux/ctype.h>
+#include <linux/kernel.h>
+#include <linux/list.h>
+#include <linux/seq_buf.h>
+#include <linux/slab.h>
 #include <linux/stdarg.h>
+#include <linux/string.h>
 
+#include "disasm.h"
 #include "diagnostics.h"
 
 #define MEMORY_SAFETY "Memory Safety"
@@ -16,6 +24,50 @@
 #define POLICY "Policy"
 #define VERIFIER_LIMIT "Verifier Limit"
 
+#define BPF_DIAG_TEXT_WIDTH 100
+#define BPF_DIAG_MSG_LEN 512
+#define BPF_DIAG_CONTEXT 2
+#define BPF_DIAG_CONTEXT_CNT (1 + BPF_DIAG_CONTEXT * 2)
+#define BPF_DIAG_SOURCE_LANE_WIDTH 88
+#define BPF_DIAG_TAB_WIDTH 8
+#define BPF_DIAG_REG_DESC_LEN 512
+#define BPF_DIAG_REG_TMP_LEN 192
+#define BPF_DIAG_FMT_CHUNK_SIZE 1024
+#define BPF_DIAG_FMT_BUF_SIZE 256
+#define DISASM_LINE_LEN 160
+
+struct disasm_line {
+	char text[DISASM_LINE_LEN];
+	int idx;
+	bool valid;
+};
+
+struct disasm_ctx {
+	struct bpf_verifier_env *env;
+	struct seq_buf seq;
+};
+
+struct diag_fmt_chunk {
+	struct list_head node;
+	struct seq_buf seq;
+	char data[];
+};
+
+struct diag_fmt_mark {
+	struct diag_fmt_chunk *chunk;
+	size_t len;
+};
+
+struct bpf_diag_scratch {
+	struct bpf_linfo_source source_lines[BPF_DIAG_CONTEXT_CNT];
+	struct disasm_line disasm_lines[BPF_DIAG_CONTEXT_CNT];
+};
+
+struct bpf_diag {
+	struct bpf_diag_scratch scratch;
+	struct list_head fmt_chunks;
+};
+
 bool bpf_diag_enabled(const struct bpf_verifier_env *env)
 {
 	return env->log.level & BPF_LOG_LEVEL;
@@ -23,6 +75,164 @@ bool bpf_diag_enabled(const struct bpf_verifier_env *env)
 
 static void diag_write(struct bpf_verifier_env *env, const char *fmt, ...) __printf(2, 3);
 
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
+	if (!env->diag)
+		return -ENOMEM;
+
+	INIT_LIST_HEAD(&env->diag->fmt_chunks);
+	return 0;
+}
+
+static struct bpf_diag_scratch *diag_scratch(struct bpf_verifier_env *env)
+{
+	struct bpf_diag *diag = diag_env(env);
+
+	return diag ? &diag->scratch : NULL;
+}
+
+static char *diag_fmt_alloc(struct bpf_verifier_env *env, size_t size)
+{
+	struct bpf_diag *diag = diag_env(env);
+	struct diag_fmt_chunk *chunk;
+	size_t capacity, available;
+	char *buf;
+
+	if (!diag || !size || size > INT_MAX)
+		return NULL;
+
+	if (!list_empty(&diag->fmt_chunks)) {
+		chunk = list_last_entry(&diag->fmt_chunks, struct diag_fmt_chunk, node);
+		available = seq_buf_get_buf(&chunk->seq, &buf);
+		if (available >= size)
+			goto commit;
+	}
+
+	capacity = max_t(size_t, BPF_DIAG_FMT_CHUNK_SIZE, size);
+	chunk = kmalloc(struct_size(chunk, data, capacity), GFP_KERNEL_ACCOUNT);
+	if (!chunk)
+		return NULL;
+
+	seq_buf_init(&chunk->seq, chunk->data, capacity);
+	list_add_tail(&chunk->node, &diag->fmt_chunks);
+	available = seq_buf_get_buf(&chunk->seq, &buf);
+	if (WARN_ON_ONCE(available < size))
+		return NULL;
+
+commit:
+	seq_buf_commit(&chunk->seq, size);
+	return buf;
+}
+
+char *bpf_diag_fmt_buf(struct bpf_verifier_env *env, size_t size)
+{
+	char *buf;
+
+	buf = diag_fmt_alloc(env, size);
+	if (buf)
+		buf[0] = '\0';
+	return buf;
+}
+
+const char *bpf_diag_vfmt(struct bpf_verifier_env *env, const char *fmt, va_list args)
+{
+	va_list copy;
+	char *buf;
+	int len;
+
+	va_copy(copy, args);
+	len = vsnprintf(NULL, 0, fmt, copy);
+	va_end(copy);
+	if (len < 0 || len == INT_MAX)
+		return "";
+
+	buf = diag_fmt_alloc(env, len + 1);
+	if (buf)
+		vsnprintf(buf, len + 1, fmt, args);
+	return buf ?: "";
+}
+
+const char *bpf_diag_fmt(struct bpf_verifier_env *env, const char *fmt, ...)
+{
+	const char *buf;
+	va_list args;
+
+	va_start(args, fmt);
+	buf = bpf_diag_vfmt(env, fmt, args);
+	va_end(args);
+	return buf;
+}
+
+static struct diag_fmt_mark diag_fmt_save(struct bpf_verifier_env *env)
+{
+	struct bpf_diag *diag = diag_env(env);
+	struct diag_fmt_mark mark = {};
+
+	if (!diag || list_empty(&diag->fmt_chunks))
+		return mark;
+
+	mark.chunk = list_last_entry(&diag->fmt_chunks, struct diag_fmt_chunk, node);
+	mark.len = mark.chunk->seq.len;
+	return mark;
+}
+
+static void diag_fmt_restore(struct bpf_verifier_env *env, struct diag_fmt_mark mark)
+{
+	struct bpf_diag *diag = diag_env(env);
+	struct diag_fmt_chunk *chunk;
+
+	if (!diag)
+		return;
+
+	while (!list_empty(&diag->fmt_chunks)) {
+		chunk = list_last_entry(&diag->fmt_chunks, struct diag_fmt_chunk, node);
+		if (chunk == mark.chunk)
+			break;
+		list_del(&chunk->node);
+		kfree(chunk);
+	}
+
+	if (mark.chunk) {
+		mark.chunk->seq.len = mark.len;
+		seq_buf_str(&mark.chunk->seq);
+	}
+}
+
+static void diag_fmt_free(struct bpf_verifier_env *env)
+{
+	struct bpf_diag *diag = diag_env(env);
+	struct diag_fmt_chunk *chunk, *tmp;
+
+	if (!diag)
+		return;
+
+	list_for_each_entry_safe(chunk, tmp, &diag->fmt_chunks, node) {
+		list_del(&chunk->node);
+		kfree(chunk);
+	}
+}
+
+void bpf_diag_free(struct bpf_verifier_env *env)
+{
+	struct bpf_diag *diag = env->diag;
+
+	if (!diag)
+		return;
+
+	diag_fmt_free(env);
+	kfree(diag);
+	env->diag = NULL;
+}
+
 static void diag_write(struct bpf_verifier_env *env, const char *fmt, ...)
 {
 	va_list args;
@@ -35,6 +245,182 @@ static void diag_write(struct bpf_verifier_env *env, const char *fmt, ...)
 	va_end(args);
 }
 
+static void diag_print_wrapped_prefixed(struct bpf_verifier_env *env, const char *first_prefix,
+					const char *next_prefix, const char *text)
+{
+	const char *prefix = first_prefix;
+
+	while (*text) {
+		const char *line = text;
+		int prefix_len = strlen(prefix);
+		int text_width = BPF_DIAG_TEXT_WIDTH - prefix_len;
+		int len = 0, last_space = -1;
+
+		if (text_width < 1)
+			text_width = 1;
+
+		while (line[len] && line[len] != '\n' && len < text_width) {
+			if (line[len] == ' ')
+				last_space = len;
+			len++;
+		}
+
+		if (line[len] && line[len] != '\n' && line[len] != ' ' && last_space > 0)
+			len = last_space;
+
+		diag_write(env, "%s%.*s\n", prefix, len, line);
+
+		text = line + len;
+		while (*text == ' ')
+			text++;
+		if (*text == '\n')
+			text++;
+
+		prefix = next_prefix;
+	}
+}
+
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
+static void disasm_print(void *private_data, const char *fmt, ...) __printf(2, 3);
+
+static void disasm_print(void *private_data, const char *fmt, ...)
+{
+	struct disasm_ctx *ctx = private_data;
+	va_list args;
+
+	va_start(args, fmt);
+	seq_buf_vprintf(&ctx->seq, fmt, args);
+	va_end(args);
+}
+
+static const char *disasm_kfunc_name(void *private_data, const struct bpf_insn *insn)
+{
+	struct disasm_ctx *ctx = private_data;
+
+	return bpf_disasm_kfunc_name(ctx->env, insn);
+}
+
+static void format_disasm_line(struct bpf_verifier_env *env, int insn_idx,
+			       struct disasm_line *line)
+{
+	struct disasm_ctx ctx = { .env = env };
+	struct bpf_insn *insn;
+	const struct bpf_insn_cbs cbs = {
+		.cb_call = disasm_kfunc_name,
+		.cb_print = disasm_print,
+		.private_data = &ctx,
+	};
+
+	line->idx = insn_idx;
+	line->valid = false;
+	seq_buf_init(&ctx.seq, line->text, sizeof(line->text));
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
+	seq_buf_str(&ctx.seq);
+	ctx.seq.len = strnlen(line->text, sizeof(line->text));
+	while (ctx.seq.len && line->text[ctx.seq.len - 1] == '\n')
+		seq_buf_pop(&ctx.seq);
+	seq_buf_str(&ctx.seq);
+
+	line->valid = true;
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
 void bpf_diag_header(struct bpf_verifier_env *env, const char *category, const char *problem)
 {
 	char first;
@@ -53,3 +439,128 @@ void bpf_diag_header(struct bpf_verifier_env *env, const char *category, const c
 	first = toupper(problem[0]);
 	diag_write(env, "\nVerification failed: %s: %c%s\n", category, first, problem + 1);
 }
+
+static void diag_print_source_annotation(struct bpf_verifier_env *env, int line_width, int indent,
+					 const char *label, const char *msg)
+{
+	const char *first_prefix, *next_prefix, *text;
+
+	indent = min_t(int, indent, max_t(int, 0, BPF_DIAG_SOURCE_LANE_WIDTH - line_width - 8));
+	text = bpf_diag_fmt(env, "%s: %s", label, msg);
+	first_prefix = bpf_diag_fmt(env, "  %*s | %*s^-- ", line_width + 4, "", indent, "");
+	next_prefix = bpf_diag_fmt(env, "  %*s | %*s    ", line_width + 4, "", indent, "");
+
+	diag_print_wrapped_prefixed(env, first_prefix, next_prefix, text);
+}
+
+void bpf_diag_source(struct bpf_verifier_env *env, u32 insn_idx, const char *label,
+			    const char *fmt, ...)
+{
+	struct bpf_diag_scratch *scratch;
+	struct bpf_linfo_source *source_lines;
+	struct disasm_line *disasm_lines;
+	struct bpf_linfo_source src;
+	struct diag_fmt_mark mark;
+	const struct bpf_line_info *linfo;
+	const struct bpf_subprog_info *subprog;
+	struct btf *btf = env->prog->aux->btf;
+	char *source_lane;
+	const char *msg;
+	const char *func;
+	int start_line, end_line, width, indent, insn_width, subprogno, i;
+	va_list args;
+
+	if (!bpf_diag_enabled(env))
+		return;
+
+	mark = diag_fmt_save(env);
+	label = label ?: "note";
+	scratch = diag_scratch(env);
+	source_lines = scratch->source_lines;
+	disasm_lines = scratch->disasm_lines;
+	memset(source_lines, 0, sizeof(scratch->source_lines));
+	memset(disasm_lines, 0, sizeof(scratch->disasm_lines));
+
+	va_start(args, fmt);
+	msg = bpf_diag_vfmt(env, fmt, args);
+	va_end(args);
+	if (!*msg)
+		msg = "<failed to allocate diagnostic text>";
+
+	linfo = bpf_find_linfo(env->prog, insn_idx);
+	if (!btf || !linfo) {
+		diag_write(env, "  insn %u\n", insn_idx);
+		diag_print_source_annotation(env, 0, 0, label, msg);
+		goto out_restore;
+	}
+	bpf_get_linfo_source(btf, linfo, &src, 0);
+	if (!src.file || !*src.file || !src.line || !*src.line) {
+		diag_write(env, "  insn %u\n", insn_idx);
+		diag_print_source_annotation(env, 0, 0, label, msg);
+		goto out_restore;
+	}
+
+	subprog = bpf_find_containing_subprog(env, insn_idx);
+	subprogno = subprog ? bpf_find_subprog(env, subprog->start) : -ENOENT;
+	func = subprogno >= 0 ? bpf_subprog_name(env, subprogno) : NULL;
+	if (func && *func)
+		diag_write(env, "  %s @ %s:%d:%d\n", func, src.file, src.line_num, src.line_col);
+	else
+		diag_write(env, "  %s:%d:%d\n", src.file, src.line_num, src.line_col);
+
+	start_line = src.line_num - BPF_DIAG_CONTEXT;
+	end_line = src.line_num + BPF_DIAG_CONTEXT;
+	width = diag_line_width(end_line);
+	indent = diag_line_indent(src.line);
+	insn_width = diag_line_width(env->prog->len ? env->prog->len - 1 : 0);
+	for (i = 0; i < BPF_DIAG_CONTEXT_CNT; i++)
+		source_lines[i].line_num = start_line + i;
+
+	linfo = env->prog->aux->linfo;
+	for (i = 0; i < env->prog->aux->nr_linfo; i++) {
+		struct bpf_linfo_source line_src;
+		int idx;
+
+		bpf_get_linfo_source(btf, &linfo[i], &line_src, 0);
+		if (line_src.file_name_off != src.file_name_off ||
+		    line_src.line_num < start_line || line_src.line_num > end_line ||
+		    !line_src.line || !*line_src.line)
+			continue;
+
+		idx = line_src.line_num - start_line;
+		if (!source_lines[idx].line)
+			source_lines[idx] = line_src;
+	}
+
+	for (i = 0; i < BPF_DIAG_CONTEXT_CNT; i++) {
+		int row = i - BPF_DIAG_CONTEXT;
+
+		format_disasm_line(env, insn_idx + row, &disasm_lines[i]);
+	}
+
+	diag_write(env, "  Source context:\n");
+	source_lane = bpf_diag_fmt_buf(env, BPF_DIAG_FMT_BUF_SIZE);
+	if (!source_lane)
+		goto out_restore;
+	for (i = 0; i < BPF_DIAG_CONTEXT_CNT; i++) {
+		const char *source_prefix;
+
+		source_prefix = source_lines[i].line_num == src.line_num ? ">>> " : "    ";
+		diag_format_source_lane(source_lane, BPF_DIAG_FMT_BUF_SIZE, source_prefix, width,
+					source_lines[i].line_num, source_lines[i].line);
+		diag_write(env, "  %s\n", source_lane);
+		if (source_lines[i].line_num == src.line_num)
+			diag_print_source_annotation(env, width, indent, label, msg);
+	}
+	diag_write(env, "  Instruction context:\n");
+	for (i = 0; i < BPF_DIAG_CONTEXT_CNT; i++) {
+		struct disasm_line *line = &disasm_lines[i];
+
+		if (line->valid)
+			diag_write(env, "  %s%*d | %s\n", line->idx == insn_idx ? ">>> " : "    ",
+				   insn_width, line->idx, line->text);
+	}
+
+out_restore:
+	diag_fmt_restore(env, mark);
+}
diff --git a/kernel/bpf/diagnostics.h b/kernel/bpf/diagnostics.h
index e8e4c06233e2..7b391cf49ae5 100644
--- a/kernel/bpf/diagnostics.h
+++ b/kernel/bpf/diagnostics.h
@@ -10,7 +10,15 @@
 struct bpf_verifier_env;
 
 bool bpf_diag_enabled(const struct bpf_verifier_env *env);
+int bpf_diag_init(struct bpf_verifier_env *env);
+char *bpf_diag_fmt_buf(struct bpf_verifier_env *env, size_t size);
+const char *bpf_diag_vfmt(struct bpf_verifier_env *env, const char *fmt, va_list args)
+	__printf(2, 0);
+const char *bpf_diag_fmt(struct bpf_verifier_env *env, const char *fmt, ...) __printf(2, 3);
+void bpf_diag_free(struct bpf_verifier_env *env);
 void bpf_diag_header(struct bpf_verifier_env *env, const char *category,
 			    const char *problem);
+void bpf_diag_source(struct bpf_verifier_env *env, u32 insn_idx, const char *label,
+			    const char *fmt, ...) __printf(4, 5);
 
 #endif /* __BPF_DIAGNOSTICS_H */
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 61ef43325c6f..6bc2ccf35971 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -34,6 +34,7 @@
 #include <linux/trace_events.h>
 #include <linux/kallsyms.h>
 
+#include "diagnostics.h"
 #include "disasm.h"
 
 static const struct bpf_verifier_ops * const bpf_verifier_ops[] = {
@@ -405,7 +406,7 @@ static bool subprog_returns_void(struct bpf_verifier_env *env, int subprog)
 	return btf_type_is_void(type);
 }
 
-static const char *subprog_name(const struct bpf_verifier_env *env, int subprog)
+const char *bpf_subprog_name(const struct bpf_verifier_env *env, int subprog)
 {
 	struct bpf_func_info *info;
 
@@ -3032,8 +3033,8 @@ static int sort_subprogs_topo(struct bpf_verifier_env *env)
 					if (bpf_pseudo_func(&insn[idx]))
 						continue;
 					verbose(env, "recursive call from %s() to %s()\n",
-						subprog_name(env, cur),
-						subprog_name(env, callee));
+						bpf_subprog_name(env, cur),
+						bpf_subprog_name(env, callee));
 					ret = -EINVAL;
 					goto out;
 				}
@@ -3053,8 +3054,8 @@ static int sort_subprogs_topo(struct bpf_verifier_env *env)
 
 	if (env->log.level & BPF_LOG_LEVEL2)
 		for (i = 0; i < cnt; i++)
-			verbose(env, "topo_order[%d] = %s\n",
-				i, subprog_name(env, env->subprog_topo_order[i]));
+			verbose(env, "topo_order[%d] = %s\n", i,
+				bpf_subprog_name(env, env->subprog_topo_order[i]));
 out:
 	kvfree(dfs_stack);
 	kvfree(color);
@@ -3198,7 +3199,7 @@ static void linked_regs_unpack(u64 val, struct linked_regs *s)
 	}
 }
 
-static const char *disasm_kfunc_name(void *data, const struct bpf_insn *insn)
+const char *bpf_disasm_kfunc_name(void *data, const struct bpf_insn *insn)
 {
 	const struct btf_type *func;
 	struct btf *desc_btf;
@@ -3217,9 +3218,9 @@ static const char *disasm_kfunc_name(void *data, const struct bpf_insn *insn)
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
@@ -9391,7 +9392,7 @@ static int check_func_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 	if (err == -EFAULT)
 		return err;
 	if (bpf_subprog_is_global(env, subprog)) {
-		const char *sub_name = subprog_name(env, subprog);
+		const char *sub_name = bpf_subprog_name(env, subprog);
 
 		if (env->cur_state->active_locks) {
 			verbose(env, "global function calls are not allowed while holding a lock,\n"
@@ -18433,7 +18434,7 @@ static int do_check_common(struct bpf_verifier_env *env, int subprog)
 
 	regs = state->frame[state->curframe]->regs;
 	if (subprog || env->prog->type == BPF_PROG_TYPE_EXT) {
-		const char *sub_name = subprog_name(env, subprog);
+		const char *sub_name = bpf_subprog_name(env, subprog);
 		struct bpf_subprog_arg_info *arg;
 		struct bpf_reg_state *reg;
 
@@ -18603,8 +18604,9 @@ static int do_check_subprogs(struct bpf_verifier_env *env)
 		if (ret) {
 			return ret;
 		} else if (env->log.level & BPF_LOG_LEVEL) {
-			verbose(env, "Func#%d ('%s') is safe for any args that match its prototype\n",
-				i, subprog_name(env, i));
+			verbose(env,
+				"Func#%d ('%s') is safe for any args that match its prototype\n", i,
+				bpf_subprog_name(env, i));
 		}
 
 		/* We verified new global subprog, it might have called some
@@ -20134,6 +20136,9 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr,
 	ret = bpf_vlog_init(&env->log, attr_log->level, attr_log->ubuf, attr_log->size);
 	if (ret)
 		goto err_free_env;
+	ret = bpf_diag_init(env);
+	if (ret)
+		goto err_prep;
 	if (env->signature) {
 		ret = bpf_prog_calc_tag(env->prog);
 		if (ret < 0)
@@ -20424,6 +20429,7 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr,
 	kvfree(env->scc_info);
 	kvfree(env->succ);
 	kvfree(env->gotox_tmp_buf);
+	bpf_diag_free(env);
 	kvfree(env);
 	return ret;
 }
-- 
2.53.0

