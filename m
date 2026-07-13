Received: from mail-wr2-f1.google.com (mail-wr2-f1.google.com [74.125.225.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A132D3438B5
	for <bpf@vger.kernel.org>; Mon, 13 Jul 2026 15:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783957164; cv=none; b=RSjcO0wYl2un0lIp2mOBO4hRzqzp786ilr+O9YfwLSNqU8H8yDS/pRAA+qxNI5V9ChbhAONb0nliqTqU382A9FMjjdMT/T1vEya+qpuf51INHY6R99fbd+Mb0Zr+9rPgz0Jb3AOATzegSNNIS8BIpbkya3ve2eQUMo7Bw8/kCPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783957164; c=relaxed/simple;
	bh=jBnkMQFHvYCmsB+iIgJbzt0LBhlibT9sSoo/vA+/LUU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gQ2tFFUcWM3uygk/lGY3112QdPjXuHQnAO0vYjF0y7EnY09FgMiSuRY6m3rrbqZrjffiUUi2IkBOEnL+HjPn6JfcTib0myDcMYUADYvsnbTlhs9h0L0iEVtd3QAOwubVnf02f3i9Uc/9PN9Of3dxEfxf1HMxjU7i15B++3SdjKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rY/U+/v7; arc=none smtp.client-ip=74.125.225.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rY/U+/v7"
Received: by mail-wr2-f1.google.com with SMTP id ffacd0b85a97d-4619e6c826bso1102049f8f.0
        for <bpf@vger.kernel.org>; Mon, 13 Jul 2026 08:39:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783957159; x=1784561959; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Yr51qhCA0QIU/zzPuyq8M+4zfkUrWsJv59qK+ObmdGs=;
        b=rY/U+/v7mJyOljOm6lvXq4qL5zyNRNNaZW5+QW/TEYHdtzAm7fGFR6A0s1grViMmEJ
         OwQJ32MaAG4QXtgkwvXgpZkd209swEYV3lRgyVBA6SP38lw4qmjsJ9LM0jxMiNd2o9vy
         GUXIVHn1d93WxBJRuYBNjGDpe7Y+paul5Z4AOe+Mh6I/dvRRQQNweYYGQV2RvhHzfaTE
         XEicdO5Q86SFcfy0f+8nvZEeHteVK1Ha99szSO4uWJ2rTRb79j8zQbnRCZ+L8Q5/oGqO
         1OPaElT6fgTv57wMQqH7lYy+AqBpessV7cPoMxC6QI80jjR1mngNVGB5cGFC4GIfm63A
         sAPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783957159; x=1784561959;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Yr51qhCA0QIU/zzPuyq8M+4zfkUrWsJv59qK+ObmdGs=;
        b=d5hLct5BvQB515vpW4fp3cfSfPiYZb0Ptk03JfYhiE8gUjfkfB+Sql2vJZjRJiUhlU
         qUocG1N4KfaMiYD8cCNBvPWdglQ3H4PfWGK8uzpPU+xuJZvPBPdX69q0S432yCyuFaPN
         SLuEjSjCPWmR1ibvnX0Wu/beF7F1TtcM8rfu13NqMvZn2ZT5indvbceGtvzb4krX/tW5
         c1TGD7JoMgB7tQP++MYghghtNPr31BkWmWSTuIb6M8mXywaGJGniGwCVKXG/RvfWCZrF
         s0zh1eTY4QoHZ5STYgeP35JnpK4w9ho7QVgWZ0W/hMjSFg/sfLUbuVz6SeaPd+8fvNGN
         HOKA==
X-Gm-Message-State: AOJu0YwOkXNT9aQ2ZIv7p1FsxmKxuOQoYaq0gP5DOy4HEVcDKJl8Yevo
	GxQrrKeB2LMA1oaQX0CDUQeS47RbNc2zQppJm9kc+hviyynLrtvMkrrDsMBO2Zxl
X-Gm-Gg: AfdE7cmNrVjX09ae37sbCgxjsK59iROvzYyUuUkJv+t0BW+ppsERKHt2I5evR8EWhG5
	ZDhPjS/HCXQLFUMQmIpiAjcmD6lsKrlqmdd1mlP5CF5Q0cxwwfFOoCeKJjhAs9kiPOfxRbD4XEY
	nJ+wn9MMuAddVhZxi6Za4MtaMaLXEMFZi6cmml59zk1VudYl1ZDBihWP6ppwO5pvvx+yz1H9XDt
	JBxAkgAvFLMPWAhVozowTpb2qZ09OPgc4LiSzuzXt0DxAfsPQRZx5FSmmRNJUIA8/DrLFQ1wQd6
	Lkhq0Vidm0DELBkytk/iCZdCQx5LDauzMFyHkTVq3TrXoXnYIrnml1/W7LUW+eiNR3tQTWjusHs
	mou88b9Q7g6LvLDzIOQB1sehufU3200kn3Dyup6meew3w3SLJ3c81FLw9TSLshTRS4zO2w/EsvR
	HQI8+KlYfo0E0OJiLtxTgkLRFKCE2nWoqFvqgHfGvyMuO77Xq2B5ycGi/BioY62abfR5gnE3dNu
	jXhJt2zzpUJl7dpw7fVJoXdKreB26lxDCrwZgM/45jXBn/xiBZ48LhjYQzHJPXrWQ==
X-Received: by 2002:a05:600c:3e1b:b0:493:e890:9e0b with SMTP id 5b1f17b1804b1-493f883157bmr102702255e9.26.1783957158600;
        Mon, 13 Jul 2026 08:39:18 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4950a32a2casm4493035e9.12.2026.07.13.08.39.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 08:39:17 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v3 05/17] bpf: Track verifier register diagnostic events
Date: Mon, 13 Jul 2026 17:38:54 +0200
Message-ID: <20260713153910.2556007-6-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260713153910.2556007-1-memxor@gmail.com>
References: <20260713153910.2556007-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=48882; i=memxor@gmail.com; h=from:subject; bh=jBnkMQFHvYCmsB+iIgJbzt0LBhlibT9sSoo/vA+/LUU=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JISuURV4gYnLAl2Xs8+5yV9xxOCgfpKC156fwquK0o6lxt XucjW90lLIwiHExyIopspT838dkfKLyd6DtMm6YOaxMIEMYuDgFYCInbBkZvuScrz6447BruNej jxViuVLf8hwffj0p53Td6tUOkVcKSgz/vdXqjb9KLu7nmLTfpl5tptZazvWuH1onuSs7VWo7uH9 jAAA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Record material register and outgoing stack argument changes so diagnostics can
explain how a value reached its current type, bounds, or unreadable state.

Store old and new register types, scalar ranges, tnum value and mask, map and
BTF type identity, and basic operand metadata in the environment-owned
diagnostic event stream.

Record invalidations when packet data moves, references are released, or
borrowed references leave their protected region. Register-scoped history
starts at the latest matching modification and then shows later branch
outcomes.

Also record fixed stack spills and overwrites, and tag register fills from
stack so register-scoped history can follow value flow through spilled stack
slots.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/linux/bpf_verifier.h |  12 +
 kernel/bpf/diagnostics.c     | 713 ++++++++++++++++++++++++++++++++++-
 kernel/bpf/diagnostics.h     |  81 ++++
 kernel/bpf/log.c             |  11 -
 kernel/bpf/verifier.c        | 363 ++++++++++++++++--
 5 files changed, 1126 insertions(+), 54 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 3ff27863e34d..625ea3e394a2 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -1343,6 +1343,18 @@ static inline bool type_is_non_owning_ref(u32 type)
 	return type_is_ptr_alloc_obj(type) && type_flag(type) & NON_OWN_REF;
 }
 
+static inline bool type_is_map_ptr(enum bpf_reg_type type)
+{
+	switch (base_type(type)) {
+	case CONST_PTR_TO_MAP:
+	case PTR_TO_MAP_KEY:
+	case PTR_TO_MAP_VALUE:
+		return true;
+	default:
+		return false;
+	}
+}
+
 static inline bool type_is_pkt_pointer(enum bpf_reg_type type)
 {
 	type = base_type(type);
diff --git a/kernel/bpf/diagnostics.c b/kernel/bpf/diagnostics.c
index ed19220aca9a..1a45ec926c71 100644
--- a/kernel/bpf/diagnostics.c
+++ b/kernel/bpf/diagnostics.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only
 // Copyright (c) 2026 Meta Platforms, Inc. and affiliates.
 
+#include <linux/bitmap.h>
 #include <linux/bpf.h>
 #include <linux/bpf_verifier.h>
 #include <linux/btf.h>
@@ -34,23 +35,64 @@
 #define BPF_DIAG_REG_TMP_LEN 192
 #define BPF_DIAG_SCRATCH_STR_CNT 3
 #define BPF_DIAG_SCRATCH_STR_LEN 256
+#define BPF_DIAG_SCRATCH_REG_CNT CALLER_SAVED_REGS
 #define BPF_DIAG_TEXT_LEN 160
 
+struct bpf_diag_reg_snapshot {
+	u32 type;
+	u32 btf_id;
+	const struct bpf_map *map_ptr;
+	const struct btf *btf;
+	struct tnum var_off;
+	struct cnum64 r64;
+};
+
 enum bpf_diag_history_kind {
 	BPF_DIAG_HISTORY_BRANCH,
+	BPF_DIAG_HISTORY_MOD,
+};
+
+struct bpf_diag_event_hdr {
+	u32 insn_idx : 24;
+	u32 kind : 8;
 };
 
 struct bpf_diag_history_event {
-	u32 insn_idx;
-	u8 kind;
 	union {
 		struct {
+			u32 insn_idx : 24;
+			u32 kind : 8;
+		};
+		struct {
+			struct bpf_diag_event_hdr hdr;
 			bool cond_true;
 		} branch;
+		struct {
+			struct bpf_diag_event_hdr hdr;
+			struct bpf_diag_mod_target target;
+			struct bpf_diag_mod_target origin;
+			struct bpf_diag_reg_snapshot old, new;
+			u8 reason;
+			bool origin_valid;
+		} mod;
 	};
 };
 
-static void diag_print_history(struct bpf_verifier_env *env);
+enum bpf_diag_history_scope {
+	BPF_DIAG_HISTORY_SCOPE_ALL,
+	BPF_DIAG_HISTORY_SCOPE_REG,
+	BPF_DIAG_HISTORY_SCOPE_STACK_ARG,
+};
+
+struct bpf_diag_history_opts {
+	enum bpf_diag_history_scope scope;
+	u32 frameno;
+	int regno;
+	int stack_arg_slot;
+};
+
+static void diag_print_history(struct bpf_verifier_env *env,
+			       const struct bpf_diag_history_opts *opts);
 
 struct bpf_diag_source_line {
 	const char *line;
@@ -81,11 +123,27 @@ struct bpf_diag_log {
 	int error;
 };
 
+struct bpf_diag_reg_fmt {
+	char old_buf[BPF_DIAG_REG_DESC_LEN];
+	char new_buf[BPF_DIAG_REG_DESC_LEN];
+	char offset_desc[BPF_DIAG_REG_DESC_LEN];
+	char btf_type[BPF_DIAG_REG_TMP_LEN];
+	char range[BPF_DIAG_REG_TMP_LEN];
+	char smin_buf[32];
+	char smax_buf[32];
+	char umin_buf[32];
+	char umax_buf[32];
+};
+
 struct bpf_diag_scratch {
 	char str[BPF_DIAG_SCRATCH_STR_CNT][BPF_DIAG_SCRATCH_STR_LEN];
+	struct bpf_reg_state regs[BPF_DIAG_SCRATCH_REG_CNT];
 	struct bpf_linfo_source source;
 	struct bpf_diag_source_line source_lines[BPF_DIAG_CONTEXT_CNT];
 	struct bpf_diag_insn insns[BPF_DIAG_CONTEXT_CNT];
+	unsigned long *history_bitmap;
+	u32 history_bitmap_nbits;
+	struct bpf_diag_reg_fmt reg_fmt;
 };
 
 struct bpf_diag {
@@ -168,6 +226,15 @@ const char *bpf_diag_scratch_printf(struct bpf_verifier_env *env, unsigned int s
 	return buf;
 }
 
+struct bpf_reg_state *bpf_diag_reg_scratch(struct bpf_verifier_env *env, unsigned int slot)
+{
+	struct bpf_diag_scratch *scratch = diag_scratch(env);
+
+	if (!scratch || slot >= BPF_DIAG_SCRATCH_REG_CNT)
+		return NULL;
+	return &scratch->regs[slot];
+}
+
 static void diag_write(struct bpf_verifier_env *env, const char *fmt, ...)
 {
 	va_list args;
@@ -221,6 +288,7 @@ void bpf_diag_free(struct bpf_verifier_env *env)
 		return;
 
 	kfree(diag->log.events);
+	kfree(diag->scratch.history_bitmap);
 	kfree(diag);
 	env->diag = NULL;
 }
@@ -311,6 +379,36 @@ static void diag_print_wrapped_text(struct bpf_verifier_env *env, const char *te
 	diag_print_wrapped_prefixed(env, BPF_DIAG_TEXT_INDENT, BPF_DIAG_TEXT_INDENT, text);
 }
 
+void bpf_diag_format_btf_type(char *buf, size_t size, const struct btf *btf, u32 type_id)
+{
+	size_t len;
+	int ret;
+
+	buf[0] = '\0';
+	ret = btf_type_snprintf_show_name(btf, type_id, buf, size);
+	if (ret < 0 || !buf[0]) {
+		scnprintf(buf, size, "BTF type ID %u", type_id);
+		return;
+	}
+
+	len = strlen(buf);
+	if (len && buf[len - 1] == '{')
+		buf[len - 1] = '\0';
+}
+
+const char *bpf_diag_format_btf_type_scratch(struct bpf_verifier_env *env, unsigned int slot,
+					     const struct btf *btf, u32 type_id)
+{
+	size_t size;
+	char *buf = bpf_diag_scratch_buf(env, slot, &size);
+
+	if (!buf)
+		return "";
+
+	bpf_diag_format_btf_type(buf, size, btf, type_id);
+	return buf;
+}
+
 static void diag_vprint_indented(struct bpf_verifier_env *env, const char *fmt, va_list args)
 {
 	char *buf;
@@ -727,47 +825,628 @@ void bpf_diag_report_source(struct bpf_verifier_env *env, u32 insn_idx, const ch
 int bpf_diag_record_branch(struct bpf_verifier_env *env, u32 insn_idx, bool cond_true)
 {
 	struct bpf_diag_history_event event = {
-		.insn_idx = insn_idx,
-		.kind = BPF_DIAG_HISTORY_BRANCH,
-		.branch.cond_true = cond_true,
+		.branch = {
+			.hdr = {
+				.insn_idx = insn_idx,
+				.kind = BPF_DIAG_HISTORY_BRANCH,
+			},
+			.cond_true = cond_true,
+		},
 	};
 
 	return diag_append_history(env, &event);
 }
 
-static void diag_print_history(struct bpf_verifier_env *env)
+static void diag_snapshot_reg(struct bpf_diag_reg_snapshot *snapshot,
+			      const struct bpf_reg_state *reg)
+{
+	snapshot->type = reg->type;
+	if (type_is_map_ptr(reg->type))
+		snapshot->map_ptr = reg->map_ptr;
+	if (base_type(reg->type) == PTR_TO_BTF_ID && reg->btf && reg->btf_id) {
+		snapshot->btf_id = reg->btf_id;
+		snapshot->btf = reg->btf;
+	}
+	snapshot->var_off = reg->var_off;
+	snapshot->r64 = reg->r64;
+}
+
+static bool diag_snapshot_eq(const struct bpf_diag_reg_snapshot *old,
+			     const struct bpf_diag_reg_snapshot *new)
+{
+	return old->type == new->type && old->map_ptr == new->map_ptr && old->btf == new->btf &&
+	       old->btf_id == new->btf_id && old->var_off.value == new->var_off.value &&
+	       old->var_off.mask == new->var_off.mask && old->r64.base == new->r64.base &&
+	       old->r64.size == new->r64.size;
+}
+
+static bool diag_mod_snapshot_eq(const struct bpf_diag_history_event *event)
+{
+	return diag_snapshot_eq(&event->mod.old, &event->mod.new);
+}
+
+static bool diag_mod_insn_origin(struct bpf_verifier_env *env, u32 insn_idx,
+				 const struct bpf_diag_mod_target *target,
+				 struct bpf_diag_mod_target *origin)
+{
+	const struct bpf_insn *insn = &env->prog->insnsi[insn_idx];
+	u8 class = BPF_CLASS(insn->code);
+	u32 frameno;
+
+	if (target->kind == BPF_DIAG_MOD_TARGET_REG && (class == BPF_ALU || class == BPF_ALU64) &&
+	    BPF_OP(insn->code) == BPF_MOV && BPF_SRC(insn->code) == BPF_X) {
+		*origin = bpf_diag_reg_target(target->frameno, insn->src_reg);
+		return true;
+	}
+
+	if ((target->kind != BPF_DIAG_MOD_TARGET_STACK_ARG &&
+	     target->kind != BPF_DIAG_MOD_TARGET_STACK_SLOT) ||
+	    class != BPF_STX)
+		return false;
+
+	frameno = env->cur_state->frame[env->cur_state->curframe]->frameno;
+	*origin = bpf_diag_reg_target(frameno, insn->src_reg);
+	return true;
+}
+
+void bpf_diag_record_mod(struct bpf_verifier_env *env, u32 insn_idx,
+			 struct bpf_diag_mod_target target, enum bpf_diag_mod_reason reason,
+			 const struct bpf_reg_state *old_reg, const struct bpf_reg_state *new_reg,
+			 const struct bpf_diag_mod_target *origin)
+{
+	struct bpf_diag_history_event event = {
+		.mod = {
+			.hdr = {
+				.insn_idx = insn_idx,
+				.kind = BPF_DIAG_HISTORY_MOD,
+			},
+			.target = target,
+			.reason = reason,
+		},
+	};
+
+	if (old_reg && new_reg) {
+		diag_snapshot_reg(&event.mod.old, old_reg);
+		diag_snapshot_reg(&event.mod.new, new_reg);
+		if ((reason == BPF_DIAG_MOD_WRITE || reason == BPF_DIAG_MOD_SPILL) &&
+		    diag_mod_snapshot_eq(&event))
+			return;
+	}
+	if (origin) {
+		event.mod.origin = *origin;
+		event.mod.origin_valid = true;
+	} else {
+		event.mod.origin_valid =
+			diag_mod_insn_origin(env, insn_idx, &target, &event.mod.origin);
+	}
+
+	diag_append_history(env, &event);
+}
+
+struct bpf_diag_history_filter {
+	const struct bpf_diag_history_opts *opts;
+	unsigned long *lineage;
+	u32 lineage_start;
+	bool lineage_valid;
+};
+
+static bool diag_target_matches(const struct bpf_diag_mod_target *event_target,
+				const struct bpf_diag_mod_target *target)
+{
+	int slot_off;
+
+	if (event_target->frameno != target->frameno)
+		return false;
+
+	if (event_target->kind == BPF_DIAG_MOD_TARGET_STACK_RANGE &&
+	    target->kind == BPF_DIAG_MOD_TARGET_STACK_SLOT) {
+		slot_off = -(target->spi + 1) * BPF_REG_SIZE;
+		return event_target->range.min_off < slot_off + BPF_REG_SIZE &&
+		       event_target->range.max_off > slot_off;
+	}
+
+	if (event_target->kind != target->kind)
+		return false;
+
+	switch (target->kind) {
+	case BPF_DIAG_MOD_TARGET_REG:
+		return event_target->regno == target->regno;
+	case BPF_DIAG_MOD_TARGET_STACK_ARG:
+		return event_target->stack_arg == target->stack_arg;
+	case BPF_DIAG_MOD_TARGET_STACK_SLOT:
+		return event_target->spi == target->spi;
+	default:
+		return false;
+	}
+}
+
+static bool diag_mod_keeps_lineage(struct bpf_verifier_env *env,
+				   const struct bpf_diag_history_event *event)
+{
+	const struct bpf_insn *insn;
+	u8 class;
+
+	if (event->mod.reason != BPF_DIAG_MOD_WRITE ||
+	    event->mod.target.kind != BPF_DIAG_MOD_TARGET_REG)
+		return false;
+
+	insn = &env->prog->insnsi[event->insn_idx];
+	class = BPF_CLASS(insn->code);
+	if (class != BPF_ALU && class != BPF_ALU64)
+		return false;
+
+	switch (BPF_OP(insn->code)) {
+	case BPF_ADD:
+	case BPF_SUB:
+	case BPF_MUL:
+	case BPF_OR:
+	case BPF_AND:
+	case BPF_LSH:
+	case BPF_RSH:
+	case BPF_ARSH:
+	case BPF_XOR:
+	case BPF_NEG:
+	case BPF_END:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static int diag_prepare_lineage(struct bpf_verifier_env *env, const struct bpf_diag_log *log,
+				struct bpf_diag_history_filter *filter)
+{
+	struct bpf_diag_scratch *scratch = diag_scratch(env);
+	unsigned long *bitmap;
+	size_t words;
+
+	if (!log->cnt)
+		return 0;
+
+	words = BITS_TO_LONGS(log->cnt);
+	if (scratch->history_bitmap_nbits < log->cnt) {
+		bitmap = krealloc_array(scratch->history_bitmap, words, sizeof(*bitmap),
+					GFP_KERNEL_ACCOUNT);
+		if (!bitmap)
+			return -ENOMEM;
+		scratch->history_bitmap = bitmap;
+		scratch->history_bitmap_nbits = words * BITS_PER_LONG;
+	}
+	bitmap_zero(scratch->history_bitmap, log->cnt);
+	filter->lineage = scratch->history_bitmap;
+	return 0;
+}
+
+static int diag_build_lineage(struct bpf_verifier_env *env, const struct bpf_diag_log *log,
+			      struct bpf_diag_history_filter *filter)
+{
+	const struct bpf_diag_history_opts *opts = filter->opts;
+	struct bpf_diag_mod_target target;
+	int i, err;
+
+	if (!opts)
+		return 0;
+
+	if (opts->scope == BPF_DIAG_HISTORY_SCOPE_REG)
+		target = bpf_diag_reg_target(opts->frameno, opts->regno);
+	else if (opts->scope == BPF_DIAG_HISTORY_SCOPE_STACK_ARG)
+		target = bpf_diag_stack_arg_target(opts->frameno, opts->stack_arg_slot);
+	else
+		return 0;
+
+	err = diag_prepare_lineage(env, log, filter);
+	if (err)
+		return err;
+
+	/*
+	 * Find the nearest mutation of the active target. A fill or spill changes
+	 * the target to its origin, so the same walk follows register/stack
+	 * lineage recursively until it reaches the write that created the value.
+	 */
+	for (i = log->cnt; i > 0; i--) {
+		const struct bpf_diag_history_event *event;
+
+		event = diag_history_event(log, i - 1);
+		if (event->kind != BPF_DIAG_HISTORY_MOD ||
+		    !diag_target_matches(&event->mod.target, &target))
+			continue;
+
+		__set_bit(i - 1, filter->lineage);
+		filter->lineage_start = i - 1;
+		filter->lineage_valid = true;
+
+		if (event->mod.origin_valid) {
+			target = event->mod.origin;
+			continue;
+		}
+		if (event->mod.reason != BPF_DIAG_MOD_WRITE &&
+		    event->mod.reason != BPF_DIAG_MOD_SPILL)
+			continue;
+		if (diag_mod_keeps_lineage(env, event))
+			continue;
+		break;
+	}
+
+	return 0;
+}
+
+static int diag_history_start_idx(const struct bpf_diag_log *log,
+				  const struct bpf_diag_history_filter *filter)
+{
+	const struct bpf_diag_history_opts *opts = filter->opts;
+
+	if (!opts || opts->scope == BPF_DIAG_HISTORY_SCOPE_ALL)
+		return 0;
+	if (filter->lineage_valid)
+		return filter->lineage_start;
+
+	return 0;
+}
+
+static bool diag_history_event_visible(const struct bpf_diag_history_event *event, u32 idx,
+				       const struct bpf_diag_history_filter *filter)
+{
+	const struct bpf_diag_history_opts *opts = filter->opts;
+
+	if (!opts || opts->scope == BPF_DIAG_HISTORY_SCOPE_ALL)
+		return true;
+
+	switch (event->kind) {
+	case BPF_DIAG_HISTORY_BRANCH:
+		return true;
+	case BPF_DIAG_HISTORY_MOD:
+		return filter->lineage_valid && test_bit(idx, filter->lineage);
+	default:
+		return false;
+	}
+}
+
+static const char *diag_s64_bound_name(s64 value)
+{
+	if (value == S64_MIN)
+		return "S64_MIN";
+	if (value == S64_MAX)
+		return "S64_MAX";
+	return NULL;
+}
+
+static const char *diag_u64_bound_name(u64 value)
+{
+	if (value == U64_MAX)
+		return "U64_MAX";
+	return NULL;
+}
+
+static void diag_format_s64_value(char *buf, size_t size, s64 value)
+{
+	const char *name = diag_s64_bound_name(value);
+
+	if (name)
+		strscpy(buf, name, size);
+	else
+		scnprintf(buf, size, "%lld", value);
+}
+
+static void diag_format_u64_value(char *buf, size_t size, u64 value)
+{
+	const char *name = diag_u64_bound_name(value);
+
+	if (name)
+		strscpy(buf, name, size);
+	else
+		scnprintf(buf, size, "%llu", value);
+}
+
+static bool diag_range_unknown(s64 smin, s64 smax, u64 umin, u64 umax)
+{
+	return smin == S64_MIN && smax == S64_MAX && umin == 0 && umax == U64_MAX;
+}
+
+static bool diag_cnum64_unknown(struct cnum64 range)
+{
+	return diag_range_unknown(cnum64_smin(range), cnum64_smax(range), cnum64_umin(range),
+				  cnum64_umax(range));
+}
+
+static bool diag_snapshot_unknown(const struct bpf_diag_reg_snapshot *snapshot)
+{
+	return tnum_is_unknown(snapshot->var_off) && diag_cnum64_unknown(snapshot->r64);
+}
+
+static void diag_format_scalar_range(struct bpf_diag_reg_fmt *fmt, char *buf, size_t size,
+				     struct cnum64 range)
+{
+	s64 smin = cnum64_smin(range);
+	s64 smax = cnum64_smax(range);
+	u64 umin = cnum64_umin(range);
+	u64 umax = cnum64_umax(range);
+
+	diag_format_s64_value(fmt->smin_buf, sizeof(fmt->smin_buf), smin);
+	diag_format_s64_value(fmt->smax_buf, sizeof(fmt->smax_buf), smax);
+	diag_format_u64_value(fmt->umin_buf, sizeof(fmt->umin_buf), umin);
+	diag_format_u64_value(fmt->umax_buf, sizeof(fmt->umax_buf), umax);
+
+	scnprintf(buf, size, "signed range [%s, %s], unsigned range [%s, %s]", fmt->smin_buf,
+		  fmt->smax_buf, fmt->umin_buf, fmt->umax_buf);
+}
+
+static void diag_format_var_offset(struct bpf_diag_reg_fmt *fmt, char *buf, size_t size,
+				   const struct bpf_diag_reg_snapshot *snapshot)
+{
+	if (tnum_is_const(snapshot->var_off)) {
+		scnprintf(buf, size, "at offset %lld", (s64)snapshot->var_off.value);
+		return;
+	}
+
+	if (diag_snapshot_unknown(snapshot)) {
+		scnprintf(buf, size, "with unknown offset");
+		return;
+	}
+
+	diag_format_scalar_range(fmt, fmt->range, sizeof(fmt->range), snapshot->r64);
+	scnprintf(buf, size, "with variable offset: known bits %#llx, unknown mask %#llx, %s",
+		  snapshot->var_off.value, snapshot->var_off.mask, fmt->range);
+}
+
+static bool diag_format_snapshot_btf_type(char *buf, size_t size,
+					  const struct bpf_diag_reg_snapshot *snapshot)
+{
+	if (!snapshot->btf || !snapshot->btf_id)
+		return false;
+
+	bpf_diag_format_btf_type(buf, size, snapshot->btf, snapshot->btf_id);
+	return true;
+}
+
+static const char *diag_reg_map_name(const struct bpf_map *map)
+{
+	if (!map || !map->name[0])
+		return NULL;
+
+	return map->name;
+}
+
+static void diag_format_reg_snapshot(struct bpf_verifier_env *env, struct bpf_diag_reg_fmt *fmt,
+				     char *buf, size_t size,
+				     const struct bpf_diag_reg_snapshot *snapshot)
+{
+	const char *type_name = reg_type_str(env, snapshot->type);
+	const char *map_name;
+	bool has_btf_type;
+
+	diag_format_var_offset(fmt, fmt->offset_desc, sizeof(fmt->offset_desc), snapshot);
+	has_btf_type =
+		diag_format_snapshot_btf_type(fmt->btf_type, sizeof(fmt->btf_type), snapshot);
+
+	if (snapshot->type == SCALAR_VALUE) {
+		if (tnum_is_const(snapshot->var_off)) {
+			scnprintf(buf, size, "integer scalar value %lld",
+				  (s64)snapshot->var_off.value);
+			return;
+		}
+
+		if (diag_snapshot_unknown(snapshot)) {
+			scnprintf(buf, size, "integer scalar with unknown value");
+			return;
+		}
+
+		if (cnum64_is_const(snapshot->r64)) {
+			scnprintf(buf, size, "integer scalar value %lld",
+				  cnum64_smin(snapshot->r64));
+			return;
+		}
+
+		diag_format_scalar_range(fmt, fmt->range, sizeof(fmt->range), snapshot->r64);
+		scnprintf(buf, size, "integer scalar with %s", fmt->range);
+		return;
+	}
+
+	if (snapshot->type == NOT_INIT) {
+		scnprintf(buf, size, "uninitialized value");
+		return;
+	}
+
+	if (base_type(snapshot->type) == PTR_TO_CTX) {
+		scnprintf(buf, size, "context pointer %s", fmt->offset_desc);
+		return;
+	}
+
+	if (base_type(snapshot->type) == PTR_TO_STACK) {
+		scnprintf(buf, size, "stack pointer %s", fmt->offset_desc);
+		return;
+	}
+
+	if (base_type(snapshot->type) == PTR_TO_MAP_VALUE) {
+		map_name = diag_reg_map_name(snapshot->map_ptr);
+		if (map_name) {
+			scnprintf(buf, size, "%s from %s %s",
+				  type_may_be_null(snapshot->type) ? "nullable map value" :
+								     "map value",
+				  map_name, fmt->offset_desc);
+			return;
+		}
+		scnprintf(buf, size, "%s %s",
+			  type_may_be_null(snapshot->type) ? "nullable map value" : "map value",
+			  fmt->offset_desc);
+		return;
+	}
+
+	if (base_type(snapshot->type) == CONST_PTR_TO_MAP) {
+		map_name = diag_reg_map_name(snapshot->map_ptr);
+		if (map_name)
+			scnprintf(buf, size, "map pointer for map %s", map_name);
+		else
+			scnprintf(buf, size, "map pointer");
+		return;
+	}
+
+	if (type_is_non_owning_ref(snapshot->type)) {
+		if (has_btf_type)
+			scnprintf(buf, size, "borrowed allocated object pointer type=%s",
+				  fmt->btf_type);
+		else
+			scnprintf(buf, size, "borrowed allocated object pointer");
+		return;
+	}
+
+	if (type_is_ptr_alloc_obj(snapshot->type)) {
+		if (has_btf_type)
+			scnprintf(buf, size, "owned allocated object pointer type=%s",
+				  fmt->btf_type);
+		else
+			scnprintf(buf, size, "owned allocated object pointer");
+		return;
+	}
+
+	if (base_type(snapshot->type) == PTR_TO_BTF_ID && has_btf_type) {
+		scnprintf(buf, size, "%s type=%s %s", type_name, fmt->btf_type, fmt->offset_desc);
+		return;
+	}
+
+	scnprintf(buf, size, "%s %s", type_name, fmt->offset_desc);
+}
+
+static const char *diag_mod_target_desc(struct bpf_verifier_env *env,
+					const struct bpf_diag_mod_target *target)
+{
+	switch (target->kind) {
+	case BPF_DIAG_MOD_TARGET_REG:
+		return bpf_diag_scratch_printf(env, 0, "R%u", target->regno);
+	case BPF_DIAG_MOD_TARGET_STACK_ARG:
+		return bpf_diag_scratch_printf(env, 0, "stack arg%d",
+					       diag_stack_argno(target->stack_arg));
+	case BPF_DIAG_MOD_TARGET_STACK_SLOT:
+		return bpf_diag_scratch_printf(env, 0, "stack slot fp%d",
+					       -(target->spi + 1) * BPF_REG_SIZE);
+	default:
+		return "value";
+	}
+}
+
+static void diag_print_mod(struct bpf_verifier_env *env, const struct bpf_diag_history_event *event)
+{
+	struct bpf_diag_scratch *scratch = diag_scratch(env);
+	struct bpf_diag_reg_fmt *fmt = &scratch->reg_fmt;
+	const struct bpf_diag_mod_target *target = &event->mod.target;
+	const char *target_desc, *reason = NULL;
+	const char *label = "update";
+
+	if (target->kind == BPF_DIAG_MOD_TARGET_STACK_RANGE) {
+		bpf_diag_report_source(env, event->insn_idx, "invalidated",
+				       "variable-offset stack write may affect bytes fp%d through "
+				       "fp%d",
+				       target->range.min_off, target->range.max_off - 1);
+		return;
+	}
+
+	memset(fmt, 0, sizeof(*fmt));
+	diag_format_reg_snapshot(env, fmt, fmt->old_buf, sizeof(fmt->old_buf), &event->mod.old);
+	diag_format_reg_snapshot(env, fmt, fmt->new_buf, sizeof(fmt->new_buf), &event->mod.new);
+	target_desc = diag_mod_target_desc(env, target);
+
+	switch (event->mod.reason) {
+	case BPF_DIAG_MOD_REF_RELEASE:
+		reason = target->kind == BPF_DIAG_MOD_TARGET_REG ? "resource release invalidated "
+								   "this pointer" :
+								   "resource release invalidated "
+								   "this value";
+		break;
+	case BPF_DIAG_MOD_PKT_DATA_CHANGE:
+		reason = "packet data may have moved";
+		break;
+	case BPF_DIAG_MOD_NON_OWN_REF:
+		reason = "leaving the protected region invalidated this borrowed pointer";
+		break;
+	case BPF_DIAG_MOD_CALLER_SAVED:
+		reason = "call invalidated this caller-saved register";
+		break;
+	case BPF_DIAG_MOD_WRITE:
+		if (target->kind == BPF_DIAG_MOD_TARGET_STACK_SLOT)
+			reason = "a later stack write overwrote this spilled value";
+		break;
+	case BPF_DIAG_MOD_SPILL:
+		label = "spilled";
+		break;
+	case BPF_DIAG_MOD_VAR_WRITE:
+	default:
+		break;
+	}
+
+	if (reason) {
+		bpf_diag_report_source(env, event->insn_idx, "invalidated",
+				       "%s: %s; previous value was %s", target_desc, reason,
+				       fmt->old_buf);
+		return;
+	}
+
+	bpf_diag_report_source(env, event->insn_idx, label, "%s changed from %s to %s", target_desc,
+			       fmt->old_buf, fmt->new_buf);
+}
+
+static void diag_print_history(struct bpf_verifier_env *env,
+			       const struct bpf_diag_history_opts *opts)
 {
 	const struct bpf_diag_history_event *event;
+	struct bpf_diag_history_filter filter = {
+		.opts = opts,
+	};
 	const struct bpf_diag_log *log;
-	bool printed = false;
+	bool first = true;
+	bool visible = false;
+	int start_idx, err;
 	u32 i;
 
-	diag_report_section(env, "Causal path");
+	if (!bpf_diag_enabled(env))
+		return;
 
-	if (!env->diag) {
-		diag_write(env, "  no recorded diagnostic events on this path\n");
+	if (!env->diag)
 		return;
-	}
 	log = &env->diag->log;
 
-	for (i = 0; i < log->cnt; i++) {
+	err = diag_build_lineage(env, log, &filter);
+	if (err) {
+		diag_report_section(env, "Causal path");
+		diag_write(env, "  failed to allocate causal-history scratch space\n");
+		return;
+	}
+
+	start_idx = diag_history_start_idx(log, &filter);
+	for (i = start_idx; i < log->cnt; i++) {
+		event = diag_history_event(log, i);
+		if (diag_history_event_visible(event, i, &filter)) {
+			visible = true;
+			break;
+		}
+	}
+
+	if (!visible && opts && opts->scope == BPF_DIAG_HISTORY_SCOPE_STACK_ARG)
+		return;
+
+	diag_report_section(env, "Causal path");
+	for (i = start_idx; i < log->cnt; i++) {
 		event = diag_history_event(log, i);
+		if (!diag_history_event_visible(event, i, &filter))
+			continue;
+
+		if (!first)
+			diag_write(env, "\n");
+		first = false;
 
 		switch (event->kind) {
 		case BPF_DIAG_HISTORY_BRANCH:
-			if (printed)
-				diag_write(env, "\n");
 			bpf_diag_report_source(env, event->insn_idx, "branch",
 					       "took the %s branch of this conditional, goto %s",
 					       event->branch.cond_true ? "true" : "false",
 					       event->branch.cond_true ? "followed" : "not followed");
-			printed = true;
+			break;
+		case BPF_DIAG_HISTORY_MOD:
+			diag_print_mod(env, event);
 			break;
 		default:
 			break;
 		}
 	}
 
-	if (!printed)
+	if (!visible)
 		diag_write(env, "  no retained diagnostic events on this path\n");
 }
diff --git a/kernel/bpf/diagnostics.h b/kernel/bpf/diagnostics.h
index e32ac64dd23c..440142b09e7a 100644
--- a/kernel/bpf/diagnostics.h
+++ b/kernel/bpf/diagnostics.h
@@ -7,15 +7,92 @@
 #include <linux/compiler_attributes.h>
 #include <linux/types.h>
 
+struct bpf_reg_state;
 struct bpf_verifier_env;
+struct btf;
+
+void bpf_diag_format_btf_type(char *buf, size_t size, const struct btf *btf, u32 type_id);
+
+enum bpf_diag_mod_reason {
+	BPF_DIAG_MOD_WRITE,
+	BPF_DIAG_MOD_SPILL,
+	BPF_DIAG_MOD_VAR_WRITE,
+	BPF_DIAG_MOD_REF_RELEASE,
+	BPF_DIAG_MOD_PKT_DATA_CHANGE,
+	BPF_DIAG_MOD_NON_OWN_REF,
+	BPF_DIAG_MOD_CALLER_SAVED,
+};
+
+enum bpf_diag_mod_target_kind {
+	BPF_DIAG_MOD_TARGET_NONE,
+	BPF_DIAG_MOD_TARGET_REG,
+	BPF_DIAG_MOD_TARGET_STACK_ARG,
+	BPF_DIAG_MOD_TARGET_STACK_SLOT,
+	BPF_DIAG_MOD_TARGET_STACK_RANGE,
+};
+
+struct bpf_diag_mod_target {
+	union {
+		struct {
+			s16 min_off;
+			s16 max_off;
+		} range;
+		u16 spi;
+		u8 regno;
+		u8 stack_arg;
+	};
+	u8 frameno;
+	u8 kind;
+};
+
+static inline struct bpf_diag_mod_target bpf_diag_reg_target(u32 frameno, u8 regno)
+{
+	return (struct bpf_diag_mod_target){
+		.frameno = frameno,
+		.kind = BPF_DIAG_MOD_TARGET_REG,
+		.regno = regno,
+	};
+}
+
+static inline struct bpf_diag_mod_target bpf_diag_stack_arg_target(u32 frameno, u8 slot)
+{
+	return (struct bpf_diag_mod_target){
+		.frameno = frameno,
+		.kind = BPF_DIAG_MOD_TARGET_STACK_ARG,
+		.stack_arg = slot,
+	};
+}
+
+static inline struct bpf_diag_mod_target bpf_diag_stack_slot_target(u32 frameno, u16 spi)
+{
+	return (struct bpf_diag_mod_target){
+		.frameno = frameno,
+		.kind = BPF_DIAG_MOD_TARGET_STACK_SLOT,
+		.spi = spi,
+	};
+}
+
+static inline struct bpf_diag_mod_target bpf_diag_stack_range_target(u32 frameno, s16 min_off,
+								     s16 max_off)
+{
+	return (struct bpf_diag_mod_target){
+		.frameno = frameno,
+		.kind = BPF_DIAG_MOD_TARGET_STACK_RANGE,
+		.range.min_off = min_off,
+		.range.max_off = max_off,
+	};
+}
 
 bool bpf_diag_enabled(const struct bpf_verifier_env *env);
 int bpf_diag_init(struct bpf_verifier_env *env);
 char *bpf_diag_scratch_buf(struct bpf_verifier_env *env, unsigned int slot, size_t *size);
+struct bpf_reg_state *bpf_diag_reg_scratch(struct bpf_verifier_env *env, unsigned int slot);
 const char *bpf_diag_scratch_strcpy(struct bpf_verifier_env *env, unsigned int slot,
 				    const char *str);
 const char *bpf_diag_scratch_printf(struct bpf_verifier_env *env, unsigned int slot,
 				    const char *fmt, ...) __printf(3, 4);
+const char *bpf_diag_format_btf_type_scratch(struct bpf_verifier_env *env, unsigned int slot,
+					     const struct btf *btf, u32 type_id);
 u32 bpf_diag_event_log_pos(struct bpf_verifier_env *env);
 void bpf_diag_event_log_reset(struct bpf_verifier_env *env, u32 pos);
 int bpf_diag_error(const struct bpf_verifier_env *env);
@@ -25,5 +102,9 @@ void bpf_diag_report_header(struct bpf_verifier_env *env, const char *category,
 void bpf_diag_report_source(struct bpf_verifier_env *env, u32 insn_idx, const char *label,
 			    const char *fmt, ...) __printf(4, 5);
 int bpf_diag_record_branch(struct bpf_verifier_env *env, u32 insn_idx, bool cond_true);
+void bpf_diag_record_mod(struct bpf_verifier_env *env, u32 insn_idx,
+			 struct bpf_diag_mod_target target, enum bpf_diag_mod_reason reason,
+			 const struct bpf_reg_state *old_reg, const struct bpf_reg_state *new_reg,
+			 const struct bpf_diag_mod_target *origin);
 
 #endif /* __BPF_DIAGNOSTICS_H */
diff --git a/kernel/bpf/log.c b/kernel/bpf/log.c
index b740fa73ee26..589770ca3d3a 100644
--- a/kernel/bpf/log.c
+++ b/kernel/bpf/log.c
@@ -615,17 +615,6 @@ static void print_scalar_ranges(struct bpf_verifier_env *env,
 	}
 }
 
-static bool type_is_map_ptr(enum bpf_reg_type t) {
-	switch (base_type(t)) {
-	case CONST_PTR_TO_MAP:
-	case PTR_TO_MAP_KEY:
-	case PTR_TO_MAP_VALUE:
-		return true;
-	default:
-		return false;
-	}
-}
-
 /*
  * _a stands for append, was shortened to avoid multiline statements below.
  * This macro is used to output a comma separated list of attributes.
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 648adf3b7aaa..4a468299f05e 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -1834,6 +1834,50 @@ static const int caller_saved[CALLER_SAVED_REGS] = {
 	BPF_REG_0, BPF_REG_1, BPF_REG_2, BPF_REG_3, BPF_REG_4, BPF_REG_5
 };
 
+static void bpf_diag_save_caller_saved_regs(struct bpf_verifier_env *env,
+					    struct bpf_reg_state *regs)
+{
+	struct bpf_reg_state *old_reg;
+	int i;
+
+	for (i = 0; i < CALLER_SAVED_REGS; i++) {
+		old_reg = bpf_diag_reg_scratch(env, i);
+		if (!old_reg)
+			return;
+		*old_reg = regs[caller_saved[i]];
+	}
+}
+
+static void bpf_diag_record_caller_saved_invals(struct bpf_verifier_env *env, u32 insn_idx,
+						struct bpf_reg_state *regs)
+{
+	struct bpf_reg_state *old_reg;
+	u32 frameno = env->cur_state->curframe;
+	int i;
+
+	for (i = 1; i < CALLER_SAVED_REGS; i++) {
+		old_reg = bpf_diag_reg_scratch(env, i);
+		if (!old_reg)
+			return;
+		if (old_reg->type == NOT_INIT && regs[caller_saved[i]].type == NOT_INIT)
+			continue;
+		bpf_diag_record_mod(env, insn_idx, bpf_diag_reg_target(frameno, caller_saved[i]),
+				    BPF_DIAG_MOD_CALLER_SAVED, old_reg, &regs[caller_saved[i]],
+				    NULL);
+	}
+}
+
+static void bpf_diag_record_call_ret(struct bpf_verifier_env *env, u32 insn_idx,
+				     struct bpf_reg_state *regs)
+{
+	struct bpf_reg_state *old_reg = bpf_diag_reg_scratch(env, 0);
+
+	if (!old_reg)
+		return;
+	bpf_diag_record_mod(env, insn_idx, bpf_diag_reg_target(env->cur_state->curframe, BPF_REG_0),
+			    BPF_DIAG_MOD_WRITE, old_reg, &regs[BPF_REG_0], NULL);
+}
+
 /* This helper doesn't clear reg->id */
 static void ___mark_reg_known(struct bpf_reg_state *reg, u64 imm)
 {
@@ -3448,6 +3492,22 @@ static void assign_scalar_id_before_mov(struct bpf_verifier_env *env,
 		src_reg->id = ++env->id_gen;
 }
 
+static int bpf_diag_stack_slot(const struct bpf_func_state *state,
+			       const struct bpf_stack_state *stack)
+{
+	unsigned long start, end, addr;
+
+	if (!stack)
+		return -1;
+
+	addr = (unsigned long)stack;
+	start = (unsigned long)state->stack;
+	end = (unsigned long)(state->stack + state->allocated_stack / BPF_REG_SIZE);
+	if (addr < start || addr >= end)
+		return -1;
+	return stack - state->stack;
+}
+
 static void save_register_state(struct bpf_verifier_env *env,
 				struct bpf_func_state *state,
 				int spi, struct bpf_reg_state *reg,
@@ -3525,8 +3585,14 @@ static int check_stack_write_fixed_off(struct bpf_verifier_env *env,
 	int i, slot = -off - 1, spi = slot / BPF_REG_SIZE, err;
 	struct bpf_insn *insn = &env->prog->insnsi[insn_idx];
 	struct bpf_reg_state *reg = NULL;
+	struct bpf_reg_state *old_spill;
 	int insn_flags = INSN_F_STACK_ACCESS;
 	int hist_spi = spi, hist_frame = state->frameno;
+	bool old_was_spill = bpf_is_spilled_reg(&state->stack[spi]);
+
+	old_spill = bpf_diag_reg_scratch(env, 0);
+	if (old_spill)
+		*old_spill = state->stack[spi].spilled_ptr;
 
 	/* caller checked that off % size == 0 and -MAX_BPF_STACK <= off < 0,
 	 * so it's aligned access and [off, off + size) are within stack limits
@@ -3622,6 +3688,15 @@ static int check_stack_write_fixed_off(struct bpf_verifier_env *env,
 		insn_flags = 0; /* not a register spill */
 	}
 
+	if (old_spill && (old_was_spill || bpf_is_spilled_reg(&state->stack[spi]))) {
+		enum bpf_diag_mod_reason reason = bpf_is_spilled_reg(&state->stack[spi]) ?
+							  BPF_DIAG_MOD_SPILL :
+							  BPF_DIAG_MOD_WRITE;
+
+		bpf_diag_record_mod(env, insn_idx, bpf_diag_stack_slot_target(state->frameno, spi),
+				    reason, old_spill, &state->stack[spi].spilled_ptr, NULL);
+	}
+
 	if (insn_flags)
 		return bpf_push_jmp_history(env, env->cur_state, insn_flags,
 					    hist_spi, hist_frame, 0);
@@ -3759,6 +3834,9 @@ static int check_stack_write_var_off(struct bpf_verifier_env *env,
 		if (err)
 			return err;
 	}
+	bpf_diag_record_mod(env, insn_idx,
+			    bpf_diag_stack_range_target(state->frameno, min_off, max_off),
+			    BPF_DIAG_MOD_VAR_WRITE, NULL, NULL, NULL);
 	return 0;
 }
 
@@ -4135,6 +4213,8 @@ static int check_stack_arg_write(struct bpf_verifier_env *env, struct bpf_func_s
 	struct bpf_subprog_info *subprog = &env->subprog_info[state->subprogno];
 	int spi = -off / BPF_REG_SIZE - 1;
 	struct bpf_reg_state *arg;
+	struct bpf_reg_state *old_arg;
+	bool slot_exists;
 	int err;
 
 	if (spi >= max_stack_arg_regs) {
@@ -4143,6 +4223,7 @@ static int check_stack_arg_write(struct bpf_verifier_env *env, struct bpf_func_s
 		return -EINVAL;
 	}
 
+	slot_exists = spi < state->out_stack_arg_cnt;
 	err = grow_stack_arg_slots(env, state, spi + 1);
 	if (err)
 		return err;
@@ -4151,14 +4232,26 @@ static int check_stack_arg_write(struct bpf_verifier_env *env, struct bpf_func_s
 	if (spi + 1 > subprog->max_out_stack_arg_cnt)
 		subprog->max_out_stack_arg_cnt = spi + 1;
 
+	arg = &state->stack_arg_regs[spi];
+	old_arg = bpf_diag_reg_scratch(env, 0);
+	if (old_arg) {
+		if (slot_exists)
+			*old_arg = *arg;
+		else
+			bpf_mark_reg_not_init(env, old_arg);
+	}
+
 	if (value_reg) {
 		state->stack_arg_regs[spi] = *value_reg;
 	} else {
 		/* BPF_ST: store immediate, treat as scalar */
-		arg = &state->stack_arg_regs[spi];
 		arg->type = SCALAR_VALUE;
 		__mark_reg_known(arg, env->prog->insnsi[env->insn_idx].imm);
 	}
+	if (old_arg)
+		bpf_diag_record_mod(env, env->insn_idx,
+				    bpf_diag_stack_arg_target(state->frameno, spi),
+				    BPF_DIAG_MOD_WRITE, old_arg, arg, NULL);
 	state->no_stack_arg_load = true;
 	return bpf_push_jmp_history(env, env->cur_state,
 				    INSN_F_STACK_ARG_ACCESS, spi, 0, 0);
@@ -6445,6 +6538,31 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, struct b
 static int save_aux_ptr_type(struct bpf_verifier_env *env, enum bpf_reg_type type,
 			     bool allow_trust_mismatch);
 
+static bool diag_is_single_slot_stack_read(struct bpf_verifier_env *env,
+					   const struct bpf_reg_state *reg, int off, int size,
+					   u32 *frameno, u16 *spi)
+{
+	struct bpf_func_state *state;
+	int first_slot, last_slot;
+
+	if (reg->type != PTR_TO_STACK || !tnum_is_const(reg->var_off))
+		return false;
+
+	off += reg->var_off.value;
+	if (off >= 0 || off + size > 0)
+		return false;
+
+	first_slot = -off - 1;
+	last_slot = -off - size;
+	if (first_slot / BPF_REG_SIZE != last_slot / BPF_REG_SIZE)
+		return false;
+
+	state = bpf_func(env, reg);
+	*frameno = state->frameno;
+	*spi = first_slot / BPF_REG_SIZE;
+	return true;
+}
+
 static int check_load_mem(struct bpf_verifier_env *env, struct bpf_insn *insn,
 			  bool strict_alignment_once, bool is_ldsx,
 			  bool allow_trust_mismatch, const char *ctx)
@@ -6452,15 +6570,37 @@ static int check_load_mem(struct bpf_verifier_env *env, struct bpf_insn *insn,
 	struct bpf_verifier_state *vstate = env->cur_state;
 	struct bpf_func_state *state = vstate->frame[vstate->curframe];
 	struct bpf_reg_state *regs = cur_regs(env);
+	struct bpf_diag_mod_target origin;
+	struct bpf_reg_state *old_dst;
 	enum bpf_reg_type src_reg_type;
+	u32 stack_frameno = 0;
+	u16 stack_spi = 0;
+	bool have_old_dst;
+	bool stack_origin;
+	int size;
 	int err;
 
+	old_dst = bpf_diag_reg_scratch(env, 0);
+	have_old_dst = old_dst && insn->dst_reg < MAX_BPF_REG;
+	if (have_old_dst)
+		*old_dst = regs[insn->dst_reg];
+
 	/* Handle stack arg read */
 	if (is_stack_arg_ldx(insn)) {
 		err = check_reg_arg(env, insn->dst_reg, DST_OP_NO_MARK);
 		if (err)
 			return err;
-		return check_stack_arg_read(env, state, insn->off, insn->dst_reg);
+		err = check_stack_arg_read(env, state, insn->off, insn->dst_reg);
+		if (!err && have_old_dst) {
+			origin = bpf_diag_stack_arg_target(
+				vstate->frame[vstate->curframe - 1]->frameno,
+				insn->off / BPF_REG_SIZE - 1);
+			bpf_diag_record_mod(env, env->insn_idx,
+					    bpf_diag_reg_target(state->frameno, insn->dst_reg),
+					    BPF_DIAG_MOD_WRITE, old_dst, &regs[insn->dst_reg],
+					    &origin);
+		}
+		return err;
 	}
 
 	/* check src operand */
@@ -6474,6 +6614,10 @@ static int check_load_mem(struct bpf_verifier_env *env, struct bpf_insn *insn,
 		return err;
 
 	src_reg_type = regs[insn->src_reg].type;
+	size = bpf_size_to_bytes(BPF_SIZE(insn->code));
+	stack_origin = have_old_dst &&
+		       diag_is_single_slot_stack_read(env, regs + insn->src_reg, insn->off, size,
+						      &stack_frameno, &stack_spi);
 
 	/* Check if (src_reg + off) is readable. The state of dst_reg will be
 	 * updated by this call.
@@ -6484,6 +6628,20 @@ static int check_load_mem(struct bpf_verifier_env *env, struct bpf_insn *insn,
 	err = err ?: save_aux_ptr_type(env, src_reg_type,
 				       allow_trust_mismatch);
 	err = err ?: reg_bounds_sanity_check(env, &regs[insn->dst_reg], ctx);
+	if (!err && have_old_dst) {
+		if (stack_origin) {
+			origin = bpf_diag_stack_slot_target(stack_frameno, stack_spi);
+			bpf_diag_record_mod(env, env->insn_idx,
+					    bpf_diag_reg_target(state->frameno, insn->dst_reg),
+					    BPF_DIAG_MOD_WRITE, old_dst, &regs[insn->dst_reg],
+					    &origin);
+		} else {
+			bpf_diag_record_mod(env, env->insn_idx,
+					    bpf_diag_reg_target(state->frameno, insn->dst_reg),
+					    BPF_DIAG_MOD_WRITE, old_dst, &regs[insn->dst_reg],
+					    NULL);
+		}
+	}
 
 	return err;
 }
@@ -8965,6 +9123,56 @@ static int check_func_proto(const struct bpf_func_proto *fn, struct bpf_call_arg
 	       check_btf_id_ok(fn) ? 0 : -EINVAL;
 }
 
+static int bpf_diag_stack_arg_slot(const struct bpf_func_state *state,
+				   const struct bpf_reg_state *reg)
+{
+	unsigned long start, end, addr;
+
+	if (!state->stack_arg_regs)
+		return -1;
+
+	addr = (unsigned long)reg;
+	start = (unsigned long)state->stack_arg_regs;
+	end = (unsigned long)(state->stack_arg_regs + state->out_stack_arg_cnt);
+	if (addr < start || addr >= end)
+		return -1;
+	return reg - state->stack_arg_regs;
+}
+
+static int bpf_diag_func_regno(const struct bpf_func_state *state, const struct bpf_reg_state *reg)
+{
+	unsigned long start = (unsigned long)state->regs;
+	unsigned long end = (unsigned long)(state->regs + MAX_BPF_REG);
+	unsigned long addr = (unsigned long)reg;
+
+	if (addr < start || addr >= end)
+		return -1;
+	return reg - state->regs;
+}
+
+static bool diag_mod_target(const struct bpf_func_state *state, const struct bpf_reg_state *reg,
+			    const struct bpf_stack_state *stack, struct bpf_diag_mod_target *target)
+{
+	int id;
+
+	id = bpf_diag_func_regno(state, reg);
+	if (id >= 0) {
+		*target = bpf_diag_reg_target(state->frameno, id);
+		return true;
+	}
+	id = bpf_diag_stack_arg_slot(state, reg);
+	if (id >= 0) {
+		*target = bpf_diag_stack_arg_target(state->frameno, id);
+		return true;
+	}
+	id = bpf_diag_stack_slot(state, stack);
+	if (id >= 0) {
+		*target = bpf_diag_stack_slot_target(state->frameno, id);
+		return true;
+	}
+	return false;
+}
+
 /* Packet data might have moved, any old PTR_TO_PACKET[_META,_END]
  * are now invalid, so turn them into unknown SCALAR_VALUE.
  *
@@ -8973,13 +9181,29 @@ static int check_func_proto(const struct bpf_func_proto *fn, struct bpf_call_arg
  */
 static void clear_all_pkt_pointers(struct bpf_verifier_env *env)
 {
+	struct bpf_stack_state *stack;
 	struct bpf_func_state *state;
 	struct bpf_reg_state *reg;
 
-	bpf_for_each_reg_in_vstate(env->cur_state, state, reg, ({
-		if (reg_is_pkt_pointer_any(reg) || reg_is_dynptr_slice_pkt(reg))
-			mark_reg_invalid(env, reg);
-	}));
+	bpf_for_each_reg_in_vstate_mask(
+		env->cur_state, state, reg, stack, 1 << STACK_SPILL, ({
+			if (reg_is_pkt_pointer_any(reg) || reg_is_dynptr_slice_pkt(reg)) {
+				struct bpf_diag_mod_target target;
+				struct bpf_reg_state *old_reg;
+				bool tracked;
+
+				tracked = diag_mod_target(state, reg, stack, &target);
+				old_reg = bpf_diag_reg_scratch(env, 0);
+				if (old_reg)
+					*old_reg = *reg;
+				mark_reg_invalid(env, reg);
+				if (tracked && old_reg)
+					bpf_diag_record_mod(env, env->insn_idx, target,
+							    BPF_DIAG_MOD_PKT_DATA_CHANGE, old_reg,
+							    reg, NULL);
+			}
+		}))
+		;
 }
 
 enum {
@@ -9083,22 +9307,69 @@ static int release_reference(struct bpf_verifier_env *env, int id)
 			return -EINVAL;
 		}
 
-		bpf_for_each_reg_in_vstate_mask(vstate, state, reg, stack, mask, ({
-			if (reg->id != id && reg->parent_id != id)
-				continue;
+		bpf_for_each_reg_in_vstate_mask(
+			vstate, state, reg, stack, mask, ({
+				struct bpf_diag_mod_target target;
+				struct bpf_reg_state *old_reg, *old_reg2;
+				bool tracked;
 
-			/* Free objects derived from the current object */
-			if (reg->parent_id == id) {
-				err = idstack_push(idstack, reg->id);
-				if (err)
-					return err;
-			}
+				if (reg->id != id && reg->parent_id != id)
+					continue;
 
-			if (!stack || stack->slot_type[BPF_REG_SIZE - 1] == STACK_SPILL)
-				mark_reg_invalid(env, reg);
-			else if (stack->slot_type[BPF_REG_SIZE - 1] == STACK_DYNPTR)
-				invalidate_dynptr(env, stack);
-		}));
+				/* Free objects derived from the current object */
+				if (reg->parent_id == id) {
+					err = idstack_push(idstack, reg->id);
+					if (err)
+						return err;
+				}
+
+				old_reg = bpf_diag_reg_scratch(env, 0);
+				if (old_reg)
+					*old_reg = *reg;
+				tracked = diag_mod_target(state, reg, stack, &target);
+				if (!stack || stack->slot_type[BPF_REG_SIZE - 1] == STACK_SPILL) {
+					mark_reg_invalid(env, reg);
+				} else if (stack->slot_type[BPF_REG_SIZE - 1] == STACK_DYNPTR) {
+					struct bpf_stack_state *dyn_stack = stack;
+					int dyn_spi = stack - state->stack;
+
+					if (reg->dynptr.first_slot) {
+						dyn_stack--;
+						dyn_spi--;
+					}
+
+					old_reg2 = bpf_diag_reg_scratch(env, 1);
+					if (old_reg)
+						*old_reg = dyn_stack[0].spilled_ptr;
+					if (old_reg2)
+						*old_reg2 = dyn_stack[1].spilled_ptr;
+					invalidate_dynptr(env, dyn_stack);
+					if (old_reg) {
+						target = bpf_diag_stack_slot_target(state->frameno,
+										    dyn_spi);
+						bpf_diag_record_mod(env, env->insn_idx, target,
+								    BPF_DIAG_MOD_REF_RELEASE,
+								    old_reg,
+								    &dyn_stack[0].spilled_ptr,
+								    NULL);
+					}
+					if (old_reg2) {
+						target = bpf_diag_stack_slot_target(state->frameno,
+										    dyn_spi + 1);
+						bpf_diag_record_mod(env, env->insn_idx, target,
+								    BPF_DIAG_MOD_REF_RELEASE,
+								    old_reg2,
+								    &dyn_stack[1].spilled_ptr,
+								    NULL);
+					}
+					continue;
+				}
+				if (tracked && old_reg)
+					bpf_diag_record_mod(env, env->insn_idx, target,
+							    BPF_DIAG_MOD_REF_RELEASE, old_reg, reg,
+							    NULL);
+			}))
+			;
 	}
 
 	return 0;
@@ -9106,13 +9377,29 @@ static int release_reference(struct bpf_verifier_env *env, int id)
 
 static void invalidate_non_owning_refs(struct bpf_verifier_env *env)
 {
-	struct bpf_func_state *unused;
+	struct bpf_stack_state *stack;
+	struct bpf_func_state *state;
 	struct bpf_reg_state *reg;
 
-	bpf_for_each_reg_in_vstate(env->cur_state, unused, reg, ({
-		if (type_is_non_owning_ref(reg->type))
-			mark_reg_invalid(env, reg);
-	}));
+	bpf_for_each_reg_in_vstate_mask(
+		env->cur_state, state, reg, stack, 1 << STACK_SPILL, ({
+			if (type_is_non_owning_ref(reg->type)) {
+				struct bpf_diag_mod_target target;
+				struct bpf_reg_state *old_reg;
+				bool tracked;
+
+				tracked = diag_mod_target(state, reg, stack, &target);
+				old_reg = bpf_diag_reg_scratch(env, 0);
+				if (old_reg)
+					*old_reg = *reg;
+				mark_reg_invalid(env, reg);
+				if (tracked && old_reg)
+					bpf_diag_record_mod(env, env->insn_idx, target,
+							    BPF_DIAG_MOD_NON_OWN_REF, old_reg, reg,
+							    NULL);
+			}
+		}))
+		;
 }
 
 static void invalidate_rcu_protected_refs(struct bpf_verifier_env *env)
@@ -10512,10 +10799,12 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 		return err;
 
 	/* reset caller saved regs */
+	bpf_diag_save_caller_saved_regs(env, regs);
 	for (i = 0; i < CALLER_SAVED_REGS; i++) {
 		bpf_mark_reg_not_init(env, &regs[caller_saved[i]]);
 		check_reg_arg(env, caller_saved[i], DST_OP_NO_MARK);
 	}
+	bpf_diag_record_caller_saved_invals(env, insn_idx, regs);
 	invalidate_outgoing_stack_args(env, cur_func(env));
 
 	/* helper call returns 64-bit value. */
@@ -10701,6 +10990,8 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 	if (err)
 		return err;
 
+	bpf_diag_record_call_ret(env, insn_idx, regs);
+
 	err = check_map_func_compatibility(env, meta.map.ptr, func_id);
 	if (err)
 		return err;
@@ -13224,12 +13515,14 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 		}
 	}
 
+	bpf_diag_save_caller_saved_regs(env, regs);
 	for (i = 0; i < CALLER_SAVED_REGS; i++) {
 		u32 regno = caller_saved[i];
 
 		bpf_mark_reg_not_init(env, &regs[regno]);
 		regs[regno].subreg_def = DEF_NOT_SUBREG;
 	}
+	bpf_diag_record_caller_saved_invals(env, insn_idx, regs);
 	invalidate_outgoing_stack_args(env, cur_func(env));
 
 	/* Check return type */
@@ -13392,6 +13685,8 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 			return err;
 	}
 
+	bpf_diag_record_call_ret(env, insn_idx, regs);
+
 	if (meta.func_id == special_kfunc_list[KF_bpf_session_cookie])
 		env->prog->call_session_cookie = true;
 
@@ -15025,10 +15320,18 @@ static int adjust_reg_min_max_vals(struct bpf_verifier_env *env,
 /* check validity of 32-bit and 64-bit arithmetic operations */
 static int check_alu_op(struct bpf_verifier_env *env, struct bpf_insn *insn)
 {
+	struct bpf_func_state *state = cur_func(env);
 	struct bpf_reg_state *regs = cur_regs(env);
+	struct bpf_reg_state *old_dst;
 	u8 opcode = BPF_OP(insn->code);
+	bool have_old_dst;
 	int err;
 
+	old_dst = bpf_diag_reg_scratch(env, 0);
+	have_old_dst = old_dst && insn->dst_reg < MAX_BPF_REG;
+	if (have_old_dst)
+		*old_dst = regs[insn->dst_reg];
+
 	if (opcode == BPF_END || opcode == BPF_NEG) {
 		/* check src operand */
 		err = check_reg_arg(env, insn->dst_reg, SRC_OP);
@@ -15209,7 +15512,15 @@ static int check_alu_op(struct bpf_verifier_env *env, struct bpf_insn *insn)
 			return err;
 	}
 
-	return reg_bounds_sanity_check(env, &regs[insn->dst_reg], "alu");
+	err = reg_bounds_sanity_check(env, &regs[insn->dst_reg], "alu");
+	if (err)
+		return err;
+
+	if (have_old_dst)
+		bpf_diag_record_mod(env, env->insn_idx,
+				    bpf_diag_reg_target(state->frameno, insn->dst_reg),
+				    BPF_DIAG_MOD_WRITE, old_dst, &regs[insn->dst_reg], NULL);
+	return 0;
 }
 
 static void find_good_pkt_pointers(struct bpf_verifier_state *vstate,
-- 
2.53.0

