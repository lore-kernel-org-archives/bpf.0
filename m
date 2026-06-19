Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com [209.85.221.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EC873C9EF8
	for <bpf@vger.kernel.org>; Fri, 19 Jun 2026 20:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781902791; cv=none; b=pLaPvbv7iGDN7o1kj5xYkoV3iP0wlHmYspd085MdWc0l9q4RUlqd+gRNugO1jEvG+RY+7hDqb3xUtZTxO3PF/11uWKccNO6ujodJWmI1i1YfJoFglfFKmF31iFvMBTNcSzUqfMQeD7C6xc6TouX2QN7UmmNK9cSOomI3Zo3AVHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781902791; c=relaxed/simple;
	bh=ejngk5IaIdUp/eeww2RpanJJ+XnQTK/q3oje45MB2ME=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NwcMzT8fFgphqv5f4uiCB9yhD4P4WqOwmK0Sh+C+wEFb9gCLvZPPbw59kBoyShHG3MPejeWwFAt9nWQY9k2lrjueEHYXWEsWYVRUrVDaGM7wrSZGfP8OV+DXZeKgyzbolxDidJ1pnA+kaRg0J1tcxsBgeVEsAwkrlu3zMt/WXos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jI3F6fqQ; arc=none smtp.client-ip=209.85.221.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jI3F6fqQ"
Received: by mail-wr1-f67.google.com with SMTP id ffacd0b85a97d-462342ac290so2827007f8f.2
        for <bpf@vger.kernel.org>; Fri, 19 Jun 2026 13:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781902778; x=1782507578; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yl9jZNm6hGjjFHBUgcVI8TOR200gcmzlUIKgqBHyI4I=;
        b=jI3F6fqQreeSapggmge0kj2X9YF/zRAfOK5MeVRZvxLPVAUt/zoCvfeV2ShD3vnJHA
         VEePhxwi+mBNgyfQkbwjKS/S2l98nuPQup1xo9zjdB1OBidNmI2QwmuGsVs0Z8n0Q0wi
         H5oKjLl6vqWoUULKk+y8GOAAdIMyt12WyiPx88FCSwGlfFXnYhVvKGD1hUhY/lDZanGt
         crqoCuzU2A1HFJPGYCMEgudkp7R8b1buF4R+3Vykn75UZbDoqErsWTnmWy15Be3Tw/I8
         l8GPXCEFpEBh9/nAwZitajXusai60nijyLGzw59rg+5s/dlAP8P+efR8c7K/fp05bEER
         XEow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781902778; x=1782507578;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Yl9jZNm6hGjjFHBUgcVI8TOR200gcmzlUIKgqBHyI4I=;
        b=pRCU1wpqJnQSrQpTKmKbC8zt4jQbnnqc6bq3CsiomCTkEptLGzDZ+xqPf8gGvSejt3
         5iUMa48+7YiaUmmLHw0gVsgNm5qYHQKVZ7QlKp3wXKiPYGeXnekyGeLOzllgq/Eit9dV
         R6ndu5+TqyKm3z8ckNmk6EQLc228sJYgnFEYpi8SATsCl/MLhfZ5D2LI9NEaS1mfbyFi
         CD+rM21f9T88Mk3Ee34kbYbVFGM6rYJPssgH/dAXM56fOtdG+Nfi2FH/IQzci2Odb72p
         m9sgid5gvHTNoAcQfGe1qYhUyASt6GsHeJ/aT0iqq1qFfop6K+qKHmCDY42GAhQRndoT
         lxKg==
X-Gm-Message-State: AOJu0YwsCKd0a7ahK8R4Cmjphi6L0B9f0cDHM7tec2R1fiXYBJx664kz
	gAH++FuwIIt1mNm75tCGL5Ux0FNRW9ZYNZDlXzgqegbFRV/vhXs7YOi1aBKQMhYV
X-Gm-Gg: AfdE7cn+3BQFYoEjd/NDcSJUpjfr21SreSQtTVUM3y9IpxxjIcaKuy4p+cjicR0dk6s
	uIRr6Od3lBe7ML6GHI3NIInquL7mJz1nMAyu0A1euSo2u2rGu/3w0Q/nwACIy82uZ4amX2971O9
	L1HA4kZ1142OTZqE4z9u1g72m8Hd0mcaIm5885H7ezjaVSYPdkUxZaklzCgdN4axHDyL8/v1R45
	YcduWJYAdapp6fDNMNyJSQhpO/7YM5X858oRtPEDpRtiWz9H7irgzFtwpehloEivZI7DttwppNv
	UfJ+ucmgs9vaNRrhXUPdtA8+a66Imy2odKii55z2MwsH1jecbuZlueRpeQKOGZYkDGJ/7eS4SAE
	+AE6Ppth4dG59o425rqhJxynOIphF0A0CIVEMZdpQ0yaoOtmon2z3FkAr19bYmoZD2t5GSARQJr
	YaL54P/cDIaI7hyP4W+NNvgOT3MRAiCPZsHKzd8rLURIZw2Ynb/hzzLAVDD5DI2GyRQPiO12qJ4
	hfh8bA4eml6WmBcJcypB4MUBhIJ2uz7bBpMyRFEluXyeV+SdIdBlOg=
X-Received: by 2002:a05:6000:4915:b0:460:194d:8df0 with SMTP id ffacd0b85a97d-4656bcc986fmr6495763f8f.4.1781902778171;
        Fri, 19 Jun 2026 13:59:38 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46666c57a0esm1693019f8f.27.2026.06.19.13.59.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2026 13:59:37 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v2 02/17] bpf: Add source and instruction diagnostic context
Date: Fri, 19 Jun 2026 22:59:15 +0200
Message-ID: <20260619205934.1312876-3-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260619205934.1312876-1-memxor@gmail.com>
References: <20260619205934.1312876-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=23079; i=memxor@gmail.com; h=from:subject; bh=ejngk5IaIdUp/eeww2RpanJJ+XnQTK/q3oje45MB2ME=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIct05d97xwLKZV8d2lGlVzRrVxh/QMXnTbHd9xReFqgax ddM0NDpKGVhEONikBVTZCn5v4/J+ETl70DbZdwwc1iZQIYwcHEKwERabBn+V3k6xin9ZfvVYbDK IKGyfLrhOunXOm+ql87gvbBpM5erHsP/wgYtKQm3NxanhD7XyzyyOGlwccqBLwyzpTzq2l/Oa7H gBQA=
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
 include/linux/bpf.h          |   4 +-
 include/linux/bpf_verifier.h |   3 +
 include/linux/btf.h          |   2 +
 kernel/bpf/btf.c             |  11 +
 kernel/bpf/core.c            |  10 +-
 kernel/bpf/diagnostics.c     | 538 ++++++++++++++++++++++++++++++++++-
 kernel/bpf/diagnostics.h     |  13 +
 kernel/bpf/verifier.c        |   6 +-
 8 files changed, 579 insertions(+), 8 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 7719f6528445..b59ec4144cf0 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -4148,8 +4148,10 @@ static inline bool bpf_is_subprog(const struct bpf_prog *prog)
 }
 
 const struct bpf_line_info *bpf_find_linfo(const struct bpf_prog *prog, u32 insn_off);
+#define BPF_LINFO_LINE_TRIM 1
 void bpf_get_linfo_file_line(struct btf *btf, const struct bpf_line_info *linfo,
-			     const char **filep, const char **linep, int *nump);
+			     const char **filep, const char **linep, int *nump,
+			     u32 flags);
 int bpf_prog_get_file_line(struct bpf_prog *prog, unsigned long ip, const char **filep,
 			   const char **linep, int *nump);
 struct bpf_prog *bpf_prog_find_from_stack(void);
diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 39a851e690ec..a5dc2568ceb9 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -835,6 +835,7 @@ static inline u16 bpf_in_stack_arg_cnt(const struct bpf_subprog_info *sub)
 	return 0;
 }
 
+struct bpf_diag;
 struct bpf_verifier_env;
 
 struct backtrack_state {
@@ -942,6 +943,7 @@ struct bpf_verifier_env {
 	struct bpf_insn_aux_data *insn_aux_data; /* array of per-insn state */
 	const struct bpf_line_info *prev_linfo;
 	struct bpf_verifier_log log;
+	struct bpf_diag *diag;
 	struct bpf_subprog_info subprog_info[BPF_MAX_SUBPROGS + 2]; /* max + 2 for the fake and exception subprogs */
 	/* subprog indices sorted in topological order: leaves first, callers last */
 	int subprog_topo_order[BPF_MAX_SUBPROGS + 2];
@@ -1399,6 +1401,7 @@ void print_verifier_state(struct bpf_verifier_env *env, const struct bpf_verifie
 void print_insn_state(struct bpf_verifier_env *env, const struct bpf_verifier_state *vstate,
 		      u32 frameno);
 u32 bpf_vlog_alignment(u32 pos);
+const char *bpf_disasm_kfunc_name(void *data, const struct bpf_insn *insn);
 
 struct bpf_subprog_info *bpf_find_containing_subprog(struct bpf_verifier_env *env, int off);
 int bpf_jmp_offset(struct bpf_insn *insn);
diff --git a/include/linux/btf.h b/include/linux/btf.h
index 240401d9b25b..ed01a369e6cd 100644
--- a/include/linux/btf.h
+++ b/include/linux/btf.h
@@ -213,6 +213,8 @@ int btf_type_seq_show_flags(const struct btf *btf, u32 type_id, void *obj,
  */
 int btf_type_snprintf_show(const struct btf *btf, u32 type_id, void *obj,
 			   char *buf, int len, u64 flags);
+int btf_type_snprintf_show_name(const struct btf *btf, u32 type_id,
+				char *buf, int len);
 
 int btf_get_fd_by_id(u32 id);
 u32 btf_obj_id(const struct btf *btf);
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 15ae7c43f594..6f08bf383c11 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -8255,6 +8255,17 @@ int btf_type_snprintf_show(const struct btf *btf, u32 type_id, void *obj,
 	return ssnprintf.len;
 }
 
+int btf_type_snprintf_show_name(const struct btf *btf, u32 type_id,
+				char *buf, int len)
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
index 649cce41e13f..7883449ead89 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -3408,7 +3408,8 @@ EXPORT_TRACEPOINT_SYMBOL_GPL(xdp_bulk_tx);
 #ifdef CONFIG_BPF_SYSCALL
 
 void bpf_get_linfo_file_line(struct btf *btf, const struct bpf_line_info *linfo,
-			     const char **filep, const char **linep, int *nump)
+			     const char **filep, const char **linep, int *nump,
+			     u32 flags)
 {
 	/* Get base component of the file path. */
 	if (filep) {
@@ -3416,10 +3417,10 @@ void bpf_get_linfo_file_line(struct btf *btf, const struct bpf_line_info *linfo,
 		*filep = kbasename(*filep);
 	}
 
-	/* Obtain the source line, and strip whitespace in prefix. */
+	/* Obtain the source line, and optionally strip whitespace in prefix. */
 	if (linep) {
 		*linep = btf_name_by_offset(btf, linfo->line_off);
-		while (isspace(**linep))
+		while ((flags & BPF_LINFO_LINE_TRIM) && isspace(**linep))
 			*linep += 1;
 	}
 
@@ -3498,7 +3499,8 @@ int bpf_prog_get_file_line(struct bpf_prog *prog, unsigned long ip, const char *
 	if (idx == -1)
 		return -ENOENT;
 
-	bpf_get_linfo_file_line(btf, &linfo[idx], filep, linep, nump);
+	bpf_get_linfo_file_line(btf, &linfo[idx], filep, linep, nump,
+				BPF_LINFO_LINE_TRIM);
 	return 0;
 }
 
diff --git a/kernel/bpf/diagnostics.c b/kernel/bpf/diagnostics.c
index a18fd5aa395d..534a7bc58781 100644
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
 
 #define BPF_DIAG_CATEGORY_MEMORY_SAFETY "Memory Safety"
@@ -21,12 +25,147 @@
 
 #define BPF_DIAG_TEXT_WIDTH 100
 #define BPF_DIAG_TEXT_INDENT "  "
+#define BPF_DIAG_MSG_LEN 512
+#define BPF_DIAG_SOURCE_CONTEXT 2
+#define BPF_DIAG_SOURCE_LINE_CNT (1 + BPF_DIAG_SOURCE_CONTEXT * 2)
+#define BPF_DIAG_INSN_CONTEXT 2
+#define BPF_DIAG_INSN_CNT (1 + BPF_DIAG_INSN_CONTEXT * 2)
+#define BPF_DIAG_COLUMN_GAP 3
+#define BPF_DIAG_SOURCE_LANE_WIDTH 88
+#define BPF_DIAG_TAB_WIDTH 8
+#define BPF_DIAG_REG_DESC_LEN 512
+#define BPF_DIAG_REG_TMP_LEN 192
+#define BPF_DIAG_SCRATCH_STR_CNT 3
+#define BPF_DIAG_SCRATCH_STR_LEN 256
+#define BPF_DIAG_TEXT_LEN 160
+
+struct bpf_diag_source {
+	const char *file;
+	const char *line;
+	u32 file_name_off;
+	int line_num;
+	int line_col;
+};
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
+	struct bpf_diag_source source;
+	struct bpf_diag_source_line source_lines[BPF_DIAG_SOURCE_LINE_CNT];
+	struct bpf_diag_insn insns[BPF_DIAG_INSN_CNT];
+};
+
+struct bpf_diag {
+	struct bpf_diag_scratch scratch;
+};
 
 bool bpf_diag_enabled(const struct bpf_verifier_env *env)
 {
 	return env->log.level & BPF_LOG_LEVEL;
 }
 
+static struct bpf_diag *bpf_diag_env(struct bpf_verifier_env *env)
+{
+	if (!bpf_diag_enabled(env))
+		return NULL;
+	if (env->diag)
+		return env->diag;
+
+	env->diag = kzalloc_obj(struct bpf_diag, GFP_KERNEL_ACCOUNT);
+	return env->diag;
+}
+
+static struct bpf_diag_scratch *bpf_diag_scratch(struct bpf_verifier_env *env)
+{
+	struct bpf_diag *diag = bpf_diag_env(env);
+
+	return diag ? &diag->scratch : NULL;
+}
+
+char *bpf_diag_scratch_buf(struct bpf_verifier_env *env,
+			   unsigned int slot, size_t *size)
+{
+	struct bpf_diag_scratch *scratch = bpf_diag_scratch(env);
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
+const char *bpf_diag_scratch_strcpy(struct bpf_verifier_env *env,
+				    unsigned int slot,
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
+const char *bpf_diag_scratch_printf(struct bpf_verifier_env *env,
+				    unsigned int slot,
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
 static void bpf_diag_log(struct bpf_verifier_env *env, const char *fmt, ...)
 {
 	va_list args;
@@ -38,7 +177,6 @@ static void bpf_diag_log(struct bpf_verifier_env *env, const char *fmt, ...)
 	bpf_verifier_vlog(&env->log, fmt, args);
 	va_end(args);
 }
-
 static void bpf_diag_print_wrapped_prefixed(struct bpf_verifier_env *env,
 					    const char *first_prefix,
 					    const char *next_prefix,
@@ -103,6 +241,287 @@ static void bpf_diag_vprint_indented(struct bpf_verifier_env *env,
 	kfree(buf);
 }
 
+static int bpf_diag_line_width(unsigned int line)
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
+static const char *bpf_diag_func_name(struct bpf_verifier_env *env, u32 insn_idx)
+{
+	const struct bpf_subprog_info *subprog;
+	const struct bpf_func_info *info;
+	const struct btf_type *type;
+	int subprogno;
+
+	subprog = bpf_find_containing_subprog(env, insn_idx);
+	if (!subprog)
+		return NULL;
+	if (subprog->name && *subprog->name)
+		return subprog->name;
+
+	if (!env->prog->aux->func_info || !env->prog->aux->btf)
+		return NULL;
+
+	subprogno = subprog - env->subprog_info;
+	if (subprogno < 0 || subprogno >= env->prog->aux->func_info_cnt)
+		return NULL;
+
+	info = &env->prog->aux->func_info[subprogno];
+	type = btf_type_by_id(env->prog->aux->btf, info->type_id);
+	if (!type)
+		return NULL;
+
+	return btf_name_by_offset(env->prog->aux->btf, type->name_off);
+}
+
+static bool bpf_diag_fill_source(struct bpf_verifier_env *env,
+				 const struct bpf_line_info *linfo,
+				 struct bpf_diag_source *src)
+{
+	const char *file, *line;
+	int line_num;
+
+	if (!env->prog->aux->btf)
+		return false;
+
+	bpf_get_linfo_file_line(env->prog->aux->btf, linfo, &file, &line,
+				&line_num, 0);
+	if (!file || !*file || !line || !*line)
+		return false;
+
+	src->file = file;
+	src->line = line;
+	src->file_name_off = linfo->file_name_off;
+	src->line_num = line_num;
+	src->line_col = BPF_LINE_INFO_LINE_COL(linfo->line_col);
+	return true;
+}
+
+static bool bpf_diag_get_source(struct bpf_verifier_env *env, u32 insn_idx,
+				struct bpf_diag_source *src)
+{
+	const struct bpf_line_info *linfo;
+
+	linfo = bpf_find_linfo(env->prog, insn_idx);
+	if (!linfo)
+		return false;
+
+	return bpf_diag_fill_source(env, linfo, src);
+}
+
+static void bpf_diag_fill_source_lines(struct bpf_verifier_env *env,
+				       const struct bpf_diag_source *src,
+				       int start_line, int end_line,
+				       struct bpf_diag_source_line *lines)
+{
+	const struct bpf_line_info *linfo = env->prog->aux->linfo;
+	struct btf *btf = env->prog->aux->btf;
+	u32 i;
+
+	for (i = 0; i < BPF_DIAG_SOURCE_LINE_CNT; i++)
+		lines[i].line_num = start_line + i;
+
+	if (!btf || !env->prog->aux->nr_linfo)
+		return;
+
+	for (i = 0; i < env->prog->aux->nr_linfo; i++) {
+		const char *file, *line;
+		int line_num, idx;
+
+		if (linfo[i].file_name_off != src->file_name_off)
+			continue;
+
+		bpf_get_linfo_file_line(btf, &linfo[i], &file, &line,
+					&line_num, 0);
+		if (line_num < start_line || line_num > end_line)
+			continue;
+
+		idx = line_num - start_line;
+		if (lines[idx].line)
+			continue;
+		if (line && *line)
+			lines[idx].line = line;
+	}
+}
+
+static int bpf_diag_line_indent(const char *line)
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
+static void bpf_diag_insn_print(void *private_data, const char *fmt, ...)
+{
+	struct bpf_diag_insn_ctx *ctx = private_data;
+	struct bpf_diag_insn_buf *buf = &ctx->buf;
+	va_list args;
+
+	if (buf->len >= buf->size)
+		return;
+
+	va_start(args, fmt);
+	buf->len += vscnprintf(buf->buf + buf->len, buf->size - buf->len,
+			       fmt, args);
+	va_end(args);
+}
+
+static const char *bpf_diag_disasm_kfunc_name(void *private_data,
+					      const struct bpf_insn *insn)
+{
+	struct bpf_diag_insn_ctx *ctx = private_data;
+
+	return bpf_disasm_kfunc_name(ctx->env, insn);
+}
+
+static void bpf_diag_format_insn(struct bpf_verifier_env *env, int insn_idx,
+				 struct bpf_diag_insn *diag_insn)
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
+		.cb_call = bpf_diag_disasm_kfunc_name,
+		.cb_print = bpf_diag_insn_print,
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
+static void bpf_diag_format_source_text(char *buf, size_t size,
+					const char *line, int width)
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
+		while (ellipsis_len-- && len + 1 < size) {
+			buf[len++] = '.';
+			col++;
+		}
+	}
+
+	buf[len] = '\0';
+}
+
+static void bpf_diag_format_source_lane(char *buf, size_t size,
+					const char *source_prefix,
+					int source_line_width,
+					int line_num, const char *line)
+{
+	int len, text_width;
+
+	if (line_num <= 0) {
+		buf[0] = '\0';
+		return;
+	}
+
+	len = scnprintf(buf, size, "%s%*d | ",
+			source_prefix, source_line_width, line_num);
+	if (len >= (int)size)
+		return;
+
+	text_width = BPF_DIAG_SOURCE_LANE_WIDTH - len;
+	bpf_diag_format_source_text(buf + len, size - len, line, text_width);
+}
+
+static void bpf_diag_print_source_insn_line(struct bpf_verifier_env *env,
+					    const char *source_prefix,
+					    int source_line_width,
+					    const struct bpf_diag_source_line *line,
+					    const struct bpf_diag_insn *diag_insn,
+					    int focus_insn_idx,
+					    int insn_width)
+{
+	size_t source_lane_size;
+	char *source_lane;
+
+	source_lane = bpf_diag_scratch_buf(env, 0,
+					   &source_lane_size);
+	if (!source_lane)
+		return;
+
+	bpf_diag_format_source_lane(source_lane, source_lane_size,
+				    source_prefix, source_line_width,
+				    line->line_num, line->line);
+
+	bpf_diag_log(env, "  %-*s%*s", BPF_DIAG_SOURCE_LANE_WIDTH,
+		     source_lane, BPF_DIAG_COLUMN_GAP, "");
+	if (diag_insn->valid)
+		bpf_diag_log(env, "%s%*d | %s",
+			     diag_insn->idx == focus_insn_idx ? ">>> " : "    ",
+			     insn_width, diag_insn->idx, diag_insn->text);
+	bpf_diag_log(env, "\n");
+}
+
 void bpf_diag_report_header(struct bpf_verifier_env *env,
 			    const char *category, const char *problem)
 {
@@ -168,3 +587,120 @@ static void bpf_diag_report_suggestion(struct bpf_verifier_env *env,
 	va_end(args);
 	bpf_diag_log(env, "\n");
 }
+
+static void bpf_diag_print_source_annotation(struct bpf_verifier_env *env,
+					     int line_width, int indent,
+					     const char *label,
+					     const char *msg)
+{
+	size_t first_prefix_size, next_prefix_size;
+	char *first_prefix, *next_prefix;
+	char *text;
+
+	first_prefix = bpf_diag_scratch_buf(env, 0,
+					    &first_prefix_size);
+	next_prefix = bpf_diag_scratch_buf(env,
+					   1,
+					   &next_prefix_size);
+	if (!first_prefix || !next_prefix)
+		return;
+
+	indent = min_t(int, indent,
+		       max_t(int, 0, BPF_DIAG_SOURCE_LANE_WIDTH -
+			     line_width - 8));
+	text = kasprintf(GFP_KERNEL_ACCOUNT, "%s: %s", label, msg);
+	if (!text) {
+		bpf_diag_log(env, "  %*s | %*s^-- %s\n",
+			     line_width + 4, "", indent, "", label);
+		return;
+	}
+
+	scnprintf(first_prefix, first_prefix_size, "  %*s | %*s^-- ",
+		  line_width + 4, "", indent, "");
+	scnprintf(next_prefix, next_prefix_size, "  %*s | %*s    ",
+		  line_width + 4, "", indent, "");
+
+	bpf_diag_print_wrapped_prefixed(env, first_prefix, next_prefix, text);
+	kfree(text);
+}
+
+void bpf_diag_report_source(struct bpf_verifier_env *env, u32 insn_idx,
+			    const char *label, const char *fmt, ...)
+{
+	struct bpf_diag_scratch *scratch;
+	struct bpf_diag_source_line *source_lines;
+	struct bpf_diag_insn *diag_insn;
+	struct bpf_diag_source *src;
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
+		msg = kstrdup("<failed to allocate diagnostic text>",
+			      GFP_KERNEL_ACCOUNT);
+	if (!msg)
+		return;
+
+	label = label ?: "note";
+	scratch = bpf_diag_scratch(env);
+	if (!scratch)
+		goto out_free_msg;
+
+	src = &scratch->source;
+	source_lines = scratch->source_lines;
+	diag_insn = scratch->insns;
+	memset(source_lines, 0, sizeof(scratch->source_lines));
+	memset(diag_insn, 0, sizeof(scratch->insns));
+
+	if (!bpf_diag_get_source(env, insn_idx, src)) {
+		bpf_diag_log(env, "  insn %u\n", insn_idx);
+		bpf_diag_print_source_annotation(env, 0, 0, label, msg);
+		goto out_free_msg;
+	}
+
+	func = bpf_diag_func_name(env, insn_idx);
+	if (func && *func)
+		bpf_diag_log(env, "  %s @ %s:%d:%d\n", func, src->file,
+			     src->line_num, src->line_col);
+	else
+		bpf_diag_log(env, "  %s:%d:%d\n", src->file, src->line_num,
+			     src->line_col);
+
+	start_line = src->line_num - BPF_DIAG_SOURCE_CONTEXT;
+	end_line = src->line_num + BPF_DIAG_SOURCE_CONTEXT;
+	width = bpf_diag_line_width(end_line);
+	indent = bpf_diag_line_indent(src->line);
+	insn_width = bpf_diag_line_width(env->prog->len ? env->prog->len - 1 : 0);
+	bpf_diag_fill_source_lines(env, src, start_line, end_line,
+				   source_lines);
+
+	for (i = 0; i < BPF_DIAG_INSN_CNT; i++) {
+		int row = i - BPF_DIAG_INSN_CONTEXT;
+
+		bpf_diag_format_insn(env, insn_idx + row, &diag_insn[i]);
+	}
+
+	for (i = 0; i < BPF_DIAG_SOURCE_LINE_CNT; i++) {
+		const char *source_prefix;
+
+		source_prefix = source_lines[i].line_num == src->line_num ?
+				">>> " : "    ";
+		bpf_diag_print_source_insn_line(env, source_prefix, width,
+						&source_lines[i],
+						&diag_insn[i],
+						insn_idx, insn_width);
+		if (source_lines[i].line_num == src->line_num)
+			bpf_diag_print_source_annotation(env, width, indent,
+							 label, msg);
+	}
+
+out_free_msg:
+	kfree(msg);
+}
diff --git a/kernel/bpf/diagnostics.h b/kernel/bpf/diagnostics.h
index 5fb3271530a1..7f1380508789 100644
--- a/kernel/bpf/diagnostics.h
+++ b/kernel/bpf/diagnostics.h
@@ -10,7 +10,20 @@
 struct bpf_verifier_env;
 
 bool bpf_diag_enabled(const struct bpf_verifier_env *env);
+char *bpf_diag_scratch_buf(struct bpf_verifier_env *env,
+			   unsigned int slot, size_t *size);
+const char *bpf_diag_scratch_strcpy(struct bpf_verifier_env *env,
+				    unsigned int slot,
+				    const char *str);
+const char *bpf_diag_scratch_printf(struct bpf_verifier_env *env,
+				    unsigned int slot,
+				    const char *fmt, ...)
+	__printf(3, 4);
+void bpf_diag_free(struct bpf_verifier_env *env);
 void bpf_diag_report_header(struct bpf_verifier_env *env,
 			    const char *category, const char *problem);
+void bpf_diag_report_source(struct bpf_verifier_env *env, u32 insn_idx,
+			    const char *label, const char *fmt, ...)
+	__printf(4, 5);
 
 #endif /* __BPF_DIAGNOSTICS_H */
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 2abc79dbf281..e81fdb0e22ae 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -32,6 +32,7 @@
 #include <linux/trace_events.h>
 #include <linux/kallsyms.h>
 
+#include "diagnostics.h"
 #include "disasm.h"
 
 static const struct bpf_verifier_ops * const bpf_verifier_ops[] = {
@@ -3227,7 +3228,7 @@ static void linked_regs_unpack(u64 val, struct linked_regs *s)
 	}
 }
 
-static const char *disasm_kfunc_name(void *data, const struct bpf_insn *insn)
+const char *bpf_disasm_kfunc_name(void *data, const struct bpf_insn *insn)
 {
 	const struct btf_type *func;
 	struct btf *desc_btf;
@@ -3246,7 +3247,7 @@ static const char *disasm_kfunc_name(void *data, const struct bpf_insn *insn)
 void bpf_verbose_insn(struct bpf_verifier_env *env, struct bpf_insn *insn)
 {
 	const struct bpf_insn_cbs cbs = {
-		.cb_call	= disasm_kfunc_name,
+		.cb_call	= bpf_disasm_kfunc_name,
 		.cb_print	= verbose,
 		.private_data	= env,
 	};
@@ -19995,6 +19996,7 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr,
 	kvfree(env->scc_info);
 	kvfree(env->succ);
 	kvfree(env->gotox_tmp_buf);
+	bpf_diag_free(env);
 	kvfree(env);
 	return ret;
 }
-- 
2.53.0

