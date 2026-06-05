Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com [209.85.221.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A20240B6FC
	for <bpf@vger.kernel.org>; Fri,  5 Jun 2026 06:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780641262; cv=none; b=qrDVtqzQjarvUy3JUwsr3M9YaObDVhFs0YL0P/L/Fql2XsRfS1WXrJhtn/3aqvQXqEp09GIPOLUm0z7UHPx/p93DbtyFl25nESwP7ODAP7GGib6KPb4GBYhzDgUedQ7RPD+s5xJC8uPBnXeMj/EL4uGc6rehgNWgPZlzQZNLFwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780641262; c=relaxed/simple;
	bh=Zx8BVuewp3WDAm/Uv78SzIQlMFeLxi5T/kD/zBmP7LQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vo8ED135CrvDaAAzWlVXQ4Tsy/GWB3IdXzq1Zn3n0itjtR+Hc6DGdVMjiwgZfVtXOx1s7h31aaPEJ6ZfhB/GWbPdmWjgdB6xqJ+ipxKU4HtKfrhQlxZW5fZvaD8TOOqVilPPv1ZB01Xakyn6+wUJZQ5e88ghs0FGOc643VHeCc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pGnRaHv3; arc=none smtp.client-ip=209.85.221.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pGnRaHv3"
Received: by mail-wr1-f65.google.com with SMTP id ffacd0b85a97d-45ef56d9b67so1175403f8f.2
        for <bpf@vger.kernel.org>; Thu, 04 Jun 2026 23:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780641256; x=1781246056; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YzUUWWI8+qMI5ixrO3evvT6QNsH8Cv2XgC9/qu6j6zo=;
        b=pGnRaHv3YWmHBEG/J+dl6WhCabXN9K1DGOsECKgQ7hdPeLO5JbC7dA6iXdelpbHjvd
         PyVgmKAQ67hi+sUkTQYdY+ZmGmyW0/s6hTZdSrhR+ZiwrBIxIMjt+7ROAnfSdturHKA3
         hvnV54wFSD0/HIUtGzMFbqlNTv3wn0pCyYT+xVuVJoGOIGl4/z8eBT+E59ShCw+M3OV1
         xuhOTPvl3ezC98nOryBw8PoSP6jNiCAMAWJfH/afMVZ3mPZ3WSlhuVzos3u17KyGFMAm
         ze9UprGlkBzn5lOtcxhmTShi0SvEesqxkzR9lKXLrGdsHRFjju+k2bSaGZIT9QsHP31J
         Wv8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780641256; x=1781246056;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YzUUWWI8+qMI5ixrO3evvT6QNsH8Cv2XgC9/qu6j6zo=;
        b=EVCzWCq38P+4w4vS6VNg3z42FJvWJkarYle2RkasFEIWpi89TimhY72VmjqMDUNH/B
         RijMZOMNJ31wwVWAcIU67uQg6slFVcCe0B1dXolhalwl8WZcXBHjaDICXy0+Dpwl0lRm
         2IBbAI21JkC2qJT7BZ2IbjzyI08TT+39FRYFGedod1DmphOQKrWJB0chZXoqAwj+C8fq
         oe7xkWSEXJcreObBDJQfPBk/DYxqlLjS93PKB3oosHGpv8hBYJ8EyFhLwFacAEmCOWvY
         1iollD39W7W0XUg2Wt1cHkVZhuoU36XhbwxCzCk8kJxHduAfzgJW3uXKFMRpl5/wTygl
         BK5A==
X-Gm-Message-State: AOJu0YzUWAQEKh39FPIBFFsnuI8cyIop9QpFMvyAd0fcQC6zW7+z2jdp
	ZIaxg2xaJbp0CwJYWlwYCe1p6s7HFi6Xt2SM3a1I7YD90YZIYuTTR8/BvyGIFiSd
X-Gm-Gg: Acq92OEiVBKQ0OwzulbCkDFj57j0XPzkcBy6T5g8FIoZalL8Q8IYfS4omYUCMnwhP1J
	HNsNb17IiA74NJA6adCorNiny6fFUF8PcoT5CWD9XJdZ1hGhCtuSyFSE2GI7VScnjtD62WStt85
	KRGvgAaVzgyIq4WKl3X47o6IHHSQu+HIo5P8QQEyKj9QewFHGz0JNVAMmurdsF54nuUxQYbtfrS
	W5DBDpuG5pRBxLczznbOWgsXhiERE6vn8cleStqcvLOv/DJaae9CwTt4ltEI2cAIK4twXVdCqrD
	+l6uwZNZRx1gWLWfn3I2WVuf3/WrjhJiCAaxLRLuzm/0C+yh8ZsaJLchjZbEdXf2MyPCVzf5Zq2
	3uoa/83Qy2g3kb4BgUjvi5icH/XqyPP1wVBfAa58qlVQrD4YzAwPxbgp6hwKzqP1HNnzFtACAwU
	+m1CMHmpdrhcAwGaabCkpRRdsBmp7zbWgfQbqpf2+AQUZxqUYrqj7vBnxSI9ZsSdnrw5dCrQEKa
	p6d9Oj+h6esF4twWpfVZGo1RyRP4eAksE5+Ieh4EvguCJRIGZ+cc9Q81PJfP4iz2aOi3Q4w0Xmx
X-Received: by 2002:a05:6000:4697:b0:45e:739b:3e43 with SMTP id ffacd0b85a97d-46030186d90mr2405765f8f.0.1780641256338;
        Thu, 04 Jun 2026 23:34:16 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f35133csm22686403f8f.25.2026.06.04.23.34.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 23:34:15 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 03/17] bpf: Add source and instruction diagnostic context
Date: Fri,  5 Jun 2026 08:33:53 +0200
Message-ID: <20260605063412.974640-4-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260605063412.974640-1-memxor@gmail.com>
References: <20260605063412.974640-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=12842; i=memxor@gmail.com; h=from:subject; bh=Zx8BVuewp3WDAm/Uv78SzIQlMFeLxi5T/kD/zBmP7LQ=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIUspt3C5tWr+RxaVjTy9J/Zf37MwoCft+o56prLc1UvOO wtmPmbvKGVhEONikBVTZCn5v4/J+ETl70DbZdwwc1iZQIYwcHEKwERyVjH8Zin/wjDlak67VbXf 31tWfy495Lt/4dHss49TNe9c/drqZMbwP6B3j/ouo0DV6+UeDx0XhLIk+c6IbBJQX6Sg3rb8znt TBgA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Teach verifier diagnostics to annotate an instruction with BTF source line
information and nearby BPF instructions. The renderer keeps source text in
a fixed-width lane and prints instructions in a stable right-hand gutter.

Wrap annotation text under the source line so long error labels are readable
while the source and instruction lanes keep their fixed layout.

Keeping source and instruction context in one commit preserves the visual
layout contract that later diagnostic reports rely on.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/diagnostics.c | 384 +++++++++++++++++++++++++++++++++++++++
 kernel/bpf/diagnostics.h |   4 +
 2 files changed, 388 insertions(+)

diff --git a/kernel/bpf/diagnostics.c b/kernel/bpf/diagnostics.c
index d9a103cf3a16..652d4627c2b0 100644
--- a/kernel/bpf/diagnostics.c
+++ b/kernel/bpf/diagnostics.c
@@ -1,16 +1,45 @@
 // SPDX-License-Identifier: GPL-2.0-only
 // Copyright (c) 2026 Meta Platforms, Inc. and affiliates.
 
+#include <linux/bpf.h>
 #include <linux/bpf_verifier.h>
+#include <linux/btf.h>
+#include <linux/kernel.h>
 #include <linux/stdarg.h>
 #include <linux/string.h>
 
+#include "disasm.h"
 #include "diagnostics.h"
 
 #define verbose(env, fmt, args...) bpf_verifier_log_write(env, fmt, ##args)
 #define BPF_DIAG_TEXT_WIDTH 120
 #define BPF_DIAG_TEXT_INDENT "  "
 #define BPF_DIAG_MSG_LEN 512
+#define BPF_DIAG_SOURCE_CONTEXT 2
+#define BPF_DIAG_INSN_CONTEXT 2
+#define BPF_DIAG_COLUMN_GAP 3
+#define BPF_DIAG_SOURCE_LANE_WIDTH 88
+#define BPF_DIAG_TAB_WIDTH 8
+
+struct bpf_diag_source {
+	const char *file;
+	const char *line;
+	u32 file_name_off;
+	int line_num;
+	int line_col;
+};
+
+struct bpf_diag_insn {
+	char text[160];
+	int idx;
+	bool valid;
+};
+
+struct bpf_diag_insn_buf {
+	char *buf;
+	size_t size;
+	size_t len;
+};
 
 static void bpf_diag_print_wrapped_prefixed(struct bpf_verifier_env *env,
 					    const char *first_prefix,
@@ -68,6 +97,282 @@ static void bpf_diag_vprint_indented(struct bpf_verifier_env *env,
 	bpf_diag_print_wrapped_text(env, buf);
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
+	if (!env->prog->aux->func_info || !env->prog->aux->btf)
+		return NULL;
+
+	subprog = bpf_find_containing_subprog(env, insn_idx);
+	if (!subprog)
+		return NULL;
+
+	subprogno = subprog - env->subprog_info;
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
+
+	file = btf_name_by_offset(env->prog->aux->btf, linfo->file_name_off);
+	line = btf_name_by_offset(env->prog->aux->btf, linfo->line_off);
+	if (!file || !*file || !line || !*line)
+		return false;
+
+	src->file = kbasename(file);
+	src->line = line;
+	src->file_name_off = linfo->file_name_off;
+	src->line_num = BPF_LINE_INFO_LINE_NUM(linfo->line_col);
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
+static const char *bpf_diag_find_source_line(struct bpf_verifier_env *env,
+					     u32 file_name_off, int line_num)
+{
+	const struct bpf_line_info *linfo = env->prog->aux->linfo;
+	struct bpf_diag_source src;
+	u32 i;
+
+	for (i = 0; i < env->prog->aux->nr_linfo; i++) {
+		if (linfo[i].file_name_off != file_name_off ||
+		    BPF_LINE_INFO_LINE_NUM(linfo[i].line_col) != line_num)
+			continue;
+		if (bpf_diag_fill_source(env, &linfo[i], &src))
+			return src.line;
+	}
+
+	return NULL;
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
+static const char *bpf_diag_marker_label(char marker)
+{
+	switch (marker) {
+	case '!':
+		return "error";
+	case '?':
+		return "branch";
+	case '~':
+		return "update";
+	case '+':
+		return "acquired";
+	case '-':
+		return "released";
+	default:
+		return "note";
+	}
+}
+
+static void bpf_diag_insn_print(void *private_data, const char *fmt, ...)
+{
+	struct bpf_diag_insn_buf *buf = private_data;
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
+static const char *bpf_diag_kfunc_name(void *private_data,
+				       const struct bpf_insn *insn)
+{
+	const struct btf_type *func;
+	struct btf *btf;
+
+	(void)private_data;
+
+	if (insn->src_reg != BPF_PSEUDO_KFUNC_CALL || insn->off)
+		return NULL;
+
+	btf = bpf_get_btf_vmlinux();
+	if (IS_ERR_OR_NULL(btf))
+		return NULL;
+
+	func = btf_type_by_id(btf, insn->imm);
+	if (!func)
+		return NULL;
+
+	return btf_name_by_offset(btf, func->name_off);
+}
+
+static void bpf_diag_format_insn(struct bpf_verifier_env *env, int insn_idx,
+				 struct bpf_diag_insn *diag_insn)
+{
+	struct bpf_insn *insn;
+	struct bpf_diag_insn_buf buf = {
+		.buf = diag_insn->text,
+		.size = sizeof(diag_insn->text),
+	};
+	const struct bpf_insn_cbs cbs = {
+		.cb_call = bpf_diag_kfunc_name,
+		.cb_print = bpf_diag_insn_print,
+		.private_data = &buf,
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
+	while (buf.len && (diag_insn->text[buf.len - 1] == '\n' ||
+			   diag_insn->text[buf.len - 1] == '\r'))
+		diag_insn->text[--buf.len] = '\0';
+
+	diag_insn->valid = true;
+}
+
+static void bpf_diag_format_source_text(char *buf, size_t size,
+					const char *line, int width)
+{
+	bool truncated = false;
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
+	if (*line)
+		truncated = true;
+	if (truncated) {
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
+					    int line_num, const char *line,
+					    const struct bpf_diag_insn *diag_insn,
+					    int focus_insn_idx,
+					    int insn_width)
+{
+	char source_lane[BPF_DIAG_SOURCE_LANE_WIDTH + 1];
+
+	bpf_diag_format_source_lane(source_lane, sizeof(source_lane),
+				    source_prefix, source_line_width,
+				    line_num, line);
+
+	verbose(env, "  %-*s%*s", BPF_DIAG_SOURCE_LANE_WIDTH,
+		source_lane, BPF_DIAG_COLUMN_GAP, "");
+	if (diag_insn->valid)
+		verbose(env, "%s%*d | %s",
+			diag_insn->idx == focus_insn_idx ? ">>> " : "    ",
+			insn_width, diag_insn->idx, diag_insn->text);
+	verbose(env, "\n");
+}
+
 static const char *bpf_diag_category_name(enum bpf_diag_category category)
 {
 	switch (category) {
@@ -93,6 +398,7 @@ static const char *bpf_diag_category_name(enum bpf_diag_category category)
 	}
 }
 
+
 void bpf_diag_report_header(struct bpf_verifier_env *env,
 			    enum bpf_diag_category category,
 			    const char *problem)
@@ -134,3 +440,81 @@ void bpf_diag_report_suggestion(struct bpf_verifier_env *env, const char *fmt, .
 	va_end(args);
 	verbose(env, "\n");
 }
+
+static void bpf_diag_print_source_annotation(struct bpf_verifier_env *env,
+					     int line_width, int indent,
+					     const char *label,
+					     const char *msg)
+{
+	char first_prefix[128], next_prefix[128], text[BPF_DIAG_MSG_LEN];
+
+	scnprintf(first_prefix, sizeof(first_prefix), "  %*s | %*s^-- ",
+		  line_width + 4, "", indent, "");
+	scnprintf(next_prefix, sizeof(next_prefix), "  %*s | %*s    ",
+		  line_width + 4, "", indent, "");
+	scnprintf(text, sizeof(text), "%s: %s", label, msg);
+
+	bpf_diag_print_wrapped_prefixed(env, first_prefix, next_prefix, text);
+}
+
+void bpf_diag_report_source(struct bpf_verifier_env *env, u32 insn_idx,
+			    char marker, const char *fmt, ...)
+{
+	struct bpf_diag_source src;
+	struct bpf_diag_insn diag_insn[1 + BPF_DIAG_INSN_CONTEXT * 2];
+	char msg[BPF_DIAG_MSG_LEN];
+	const char *func, *label;
+	int start_line, end_line, line_num, indent, width;
+	int insn_width, i;
+	va_list args;
+
+	va_start(args, fmt);
+	vscnprintf(msg, sizeof(msg), fmt, args);
+	va_end(args);
+	label = bpf_diag_marker_label(marker);
+
+	if (!bpf_diag_get_source(env, insn_idx, &src)) {
+		verbose(env, "  insn %u\n", insn_idx);
+		bpf_diag_print_source_annotation(env, 0, 0, label, msg);
+		return;
+	}
+
+	func = bpf_diag_func_name(env, insn_idx);
+	if (func && *func)
+		verbose(env, "  %s @ %s:%d:%d\n", func, src.file,
+			src.line_num, src.line_col);
+	else
+		verbose(env, "  %s:%d:%d\n", src.file, src.line_num,
+			src.line_col);
+
+	start_line = max_t(int, 1, src.line_num - BPF_DIAG_SOURCE_CONTEXT);
+	end_line = src.line_num + BPF_DIAG_SOURCE_CONTEXT;
+	width = bpf_diag_line_width(end_line);
+	indent = bpf_diag_line_indent(src.line);
+	insn_width = bpf_diag_line_width(env->prog->len ? env->prog->len - 1 : 0);
+
+	for (i = 0; i < ARRAY_SIZE(diag_insn); i++) {
+		int row = i - BPF_DIAG_INSN_CONTEXT;
+
+		bpf_diag_format_insn(env, insn_idx + row, &diag_insn[i]);
+	}
+
+	for (line_num = start_line; line_num <= end_line; line_num++) {
+		const char *line;
+		int row = line_num - src.line_num;
+
+		line = line_num == src.line_num ?
+		       src.line :
+		       bpf_diag_find_source_line(env, src.file_name_off, line_num);
+
+		bpf_diag_print_source_insn_line(env,
+						line_num == src.line_num ?
+						">>> " : "    ",
+						width, line_num, line,
+						&diag_insn[row + BPF_DIAG_INSN_CONTEXT],
+						insn_idx, insn_width);
+		if (line_num == src.line_num)
+			bpf_diag_print_source_annotation(env, width, indent,
+							 label, msg);
+	}
+}
diff --git a/kernel/bpf/diagnostics.h b/kernel/bpf/diagnostics.h
index 8bfc7104eeec..ba60cc3af548 100644
--- a/kernel/bpf/diagnostics.h
+++ b/kernel/bpf/diagnostics.h
@@ -5,6 +5,7 @@
 #define __BPF_DIAGNOSTICS_H
 
 #include <linux/compiler_attributes.h>
+#include <linux/types.h>
 
 enum bpf_diag_category {
 	BPF_DIAG_CATEGORY_MEMORY_SAFETY,
@@ -28,5 +29,8 @@ void bpf_diag_report_reason(struct bpf_verifier_env *env, const char *fmt, ...)
 void bpf_diag_report_section(struct bpf_verifier_env *env, const char *title);
 void bpf_diag_report_suggestion(struct bpf_verifier_env *env, const char *fmt, ...)
 	__printf(2, 3);
+void bpf_diag_report_source(struct bpf_verifier_env *env, u32 insn_idx,
+			    char marker, const char *fmt, ...)
+	__printf(4, 5);
 
 #endif /* __BPF_DIAGNOSTICS_H */
-- 
2.53.0

