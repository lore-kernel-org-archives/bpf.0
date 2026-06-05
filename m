Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com [209.85.221.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CC05407CED
	for <bpf@vger.kernel.org>; Fri,  5 Jun 2026 06:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780641264; cv=none; b=QgVeIf2Sv00HSUu/ARWOCiS/jfzzQ4cw9m6YRArjjYaACL6c0snritiZe4YL4gZsmm3FR8bmLvzQogrrQgYDxNn0Xem6Tvt7VXnZlRyXKpEt/JLNI4SE+V0YJ5EKqKyMEYDhPL0nyQv0jXqAAeQd4IUL0JJHlbmfJSrWL5aKFrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780641264; c=relaxed/simple;
	bh=CyVhG9/prhIuZwmhF7jp4lpp8S4uyY3NviN5WxcMQb4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=spb0ivfs9R5qs/Th2tdtT1OX053WpehWinp5e8mJGvHBVrIYVO4cqC8dPN83lGrOnwY9k0IIfaIl/GAa5RkxoxjiNg3gHOEkbTd/J0+Qoq3vaE1IYHCWzLbyPXkVVW9r+AX0tklWQ079e414p/roqioEqHAJP09YGpgSrJo0R+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CKitfPgr; arc=none smtp.client-ip=209.85.221.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CKitfPgr"
Received: by mail-wr1-f67.google.com with SMTP id ffacd0b85a97d-45ef29c5561so852222f8f.0
        for <bpf@vger.kernel.org>; Thu, 04 Jun 2026 23:34:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780641259; x=1781246059; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m1uwxh9U+NaBHAbhTniJ9TZJxE4q8c6Jfo+6RkTV1w4=;
        b=CKitfPgr0oRbYUe4mQl6sLV3lPFRgN7oabn75Jnq6Cv9s+gIhwpkaAMPQzyWYaFiOc
         IAtOI+EOVTCxOfNzi9PvrFw1ggyywel3fqeJBkosU8ikOS9m/N4ke1UgXM8gtC4qmU5O
         095bi9G3j8ohP3Y34XL958L3kmSm7g+IDOQCQIM/zMt77NBnAoNY3QXIulCOgOC2VWuI
         HZylzcgVt0JcUvQz6NISfG0NJHeLOshMRehdqeYn+VPKeWpAkg5+5WW2urZpF2BblAty
         qibKpTmmLxwu/aJHdQZVuoWhxCwxtnzd66i62nFIKZwtV6QZxdlSsFuB+qr3hN/46kGa
         6IoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780641259; x=1781246059;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=m1uwxh9U+NaBHAbhTniJ9TZJxE4q8c6Jfo+6RkTV1w4=;
        b=Sz3mJi0TCwM7UaVXZmiJBxgDS7l2N1GdH0RLIB72giF1dl+4PlRYT5C1JhwhjStiTe
         02Tt5iAhAAtUamhMfyiaQ6TQ9V2DVW+GtBR7eO9ddhi2fL9r2dFswyhyJ3Oq/EPPNAWg
         9ZOVHFOY6Fpdchx2jYbQRAyUfW0Rd9tYnnsIA2rWc6Sw05fznJk4tgvlxKYj47AaShEr
         d1GFy+aj+1qPAkNFQzVw1QwRfJ4yht5SvoDnzsGoQZ+eAC8xxAgAKepWBSLkU/bBGRiC
         bdVem4hPxxXOajZ7MNFI0SOVQochqMzUQHQANoHMaajeoGsMrJHnNajb8s1cyFFVEWNq
         M3Mw==
X-Gm-Message-State: AOJu0YxL8pPpsw0q0d6wy4bfbjglMMcEFl2RmnbGzH0t4TQO3S2ecJ1N
	J6/d8hb5j3T8yreZVHDOAG+fKFsyjmBWeW2uYQbpQ+LZfe5Afvrt7xWG9ZtzkdSH
X-Gm-Gg: Acq92OGddNJgcFgA1YksxXWlSt1SkCXXToSAsdyOVK9F2WBte8kQ5J1MHyQFoue+i6R
	oVmnKchDigWPHOqdU4+LF6YIlc9s9FYJKQjrdN7wXTiKJzFgi94buWYAeb8FwQ6rt3W47jIKlPC
	NWnj8O40vwt5rqH8ZAyGmAwq5hNnYX2TdlgWmaE07c5YNPjI1fgtDoaDbyukU+oA2sFQYxklIey
	5Doe1KsaC+eQrXgmmjYfKMkAMvYAULO7PxtnpLBAuCV0DZz9ktiVLqYH4bzqZ8yl4H72CtliwTs
	1Qfussf/oEtUnRu3nMHAWuiNcyCrn64Ag82wRKzv11Pcg0VihIH5nl4x+N8nDfHlPYa/ltpBzTd
	r4G4revQHE61N14M8qeed5+8THlhVLNncSGV0zbqpR0oSwUmhMMKPhbksa3+sdVg/FSdWbncGUU
	wZ7CRYAdhFY20yrefD3Z8C5bx/w1w02E3r1AG6h3UeM+FC4opCu7++YwtUne6vmpyNgvOmwHoXk
	f9hP9dcWotSJpfBxX9Fgre+UCR44c9M9kzNZypYC4z+83+5RaNm+N+J0pnxsULd7dTbr+s0w+JF
	VIF/oimfSMw=
X-Received: by 2002:a5d:4a4e:0:b0:452:75ca:3fab with SMTP id ffacd0b85a97d-4603063a3c1mr2494229f8f.38.1780641258269;
        Thu, 04 Jun 2026 23:34:18 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f3444fesm24908488f8f.20.2026.06.04.23.34.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 23:34:17 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 05/17] bpf: Track verifier register diagnostic history
Date: Fri,  5 Jun 2026 08:33:55 +0200
Message-ID: <20260605063412.974640-6-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260605063412.974640-1-memxor@gmail.com>
References: <20260605063412.974640-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=28749; i=memxor@gmail.com; h=from:subject; bh=CyVhG9/prhIuZwmhF7jp4lpp8S4uyY3NviN5WxcMQb4=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIUspt8h06o+MXWLpu2W9l4tVPjrdIqmjN++nS8sZBn7tJ 0nHgqd3lLIwiHExyIopspT838dkfKLyd6DtMm6YOaxMIEMYuDgFYCLzhBgZXmzZKPtUsddo6Zf0 7a4GDzgqWstbVm8++rJu32Ufa801+YwMW28eN/L/JfXMd9Ebo3myn5hdm0pn8hRm1DavP3vz9hM FRgA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Record material register and outgoing stack argument changes so diagnostics can
explain how a value reached its current type, bounds, or unreadable state.

Store old and new register types, scalar ranges, tnum value and mask, map and
BTF type identity, and basic operand metadata.

Register-scoped history starts at the latest matching modification and then
shows later branch outcomes.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/diagnostics.c | 492 ++++++++++++++++++++++++++++++++++++++-
 kernel/bpf/diagnostics.h |  82 ++++++-
 kernel/bpf/verifier.c    | 112 ++++++++-
 3 files changed, 677 insertions(+), 9 deletions(-)

diff --git a/kernel/bpf/diagnostics.c b/kernel/bpf/diagnostics.c
index 50cc50a394ca..1bdc7e69fbce 100644
--- a/kernel/bpf/diagnostics.c
+++ b/kernel/bpf/diagnostics.c
@@ -21,6 +21,7 @@
 #define BPF_DIAG_COLUMN_GAP 3
 #define BPF_DIAG_SOURCE_LANE_WIDTH 88
 #define BPF_DIAG_TAB_WIDTH 8
+#define BPF_DIAG_REG_DESC_LEN 512
 
 struct bpf_diag_source {
 	const char *file;
@@ -86,6 +87,34 @@ static void bpf_diag_print_wrapped_text(struct bpf_verifier_env *env,
 					BPF_DIAG_TEXT_INDENT, text);
 }
 
+void bpf_diag_format_btf_type(char *buf, size_t size,
+			      const struct btf_type *type,
+			      const char *type_name)
+{
+	const char *kind;
+
+	switch (BTF_INFO_KIND(type->info)) {
+	case BTF_KIND_STRUCT:
+		kind = "struct";
+		break;
+	case BTF_KIND_UNION:
+		kind = "union";
+		break;
+	case BTF_KIND_ENUM:
+	case BTF_KIND_ENUM64:
+		kind = "enum";
+		break;
+	default:
+		kind = btf_type_str(type);
+		break;
+	}
+
+	if (type_name && *type_name)
+		scnprintf(buf, size, "'%s %s'", kind, type_name);
+	else
+		scnprintf(buf, size, "'%s'", kind);
+}
+
 static void bpf_diag_vprint_indented(struct bpf_verifier_env *env,
 				     const char *fmt, va_list args)
 {
@@ -206,6 +235,8 @@ static const char *bpf_diag_marker_label(char marker)
 		return "branch";
 	case '~':
 		return "update";
+	case 'x':
+		return "invalidated";
 	case '+':
 		return "acquired";
 	case '-':
@@ -215,6 +246,14 @@ static const char *bpf_diag_marker_label(char marker)
 	}
 }
 
+static const char *bpf_diag_reg_map_name(const struct bpf_map *map)
+{
+	if (!map || !map->name[0])
+		return NULL;
+
+	return map->name;
+}
+
 static void bpf_diag_insn_print(void *private_data, const char *fmt, ...)
 {
 	struct bpf_diag_insn_buf *buf = private_data;
@@ -399,7 +438,6 @@ static const char *bpf_diag_category_name(enum bpf_diag_category category)
 	}
 }
 
-
 void bpf_diag_report_header(struct bpf_verifier_env *env,
 			    enum bpf_diag_category category,
 			    const char *problem)
@@ -442,6 +480,77 @@ void bpf_diag_report_suggestion(struct bpf_verifier_env *env, const char *fmt, .
 	verbose(env, "\n");
 }
 
+static const char *bpf_diag_s64_bound_name(s64 value)
+{
+	if (value == S64_MIN)
+		return "S64_MIN";
+	if (value == S64_MAX)
+		return "S64_MAX";
+	return NULL;
+}
+
+static const char *bpf_diag_u64_bound_name(u64 value)
+{
+	if (value == U64_MAX)
+		return "U64_MAX";
+	return NULL;
+}
+
+static void bpf_diag_format_s64_value(char *buf, size_t size, s64 value)
+{
+	const char *name = bpf_diag_s64_bound_name(value);
+
+	if (name)
+		strscpy(buf, name, size);
+	else
+		scnprintf(buf, size, "%lld", value);
+}
+
+static void bpf_diag_format_u64_value(char *buf, size_t size, u64 value)
+{
+	const char *name = bpf_diag_u64_bound_name(value);
+
+	if (name)
+		strscpy(buf, name, size);
+	else
+		scnprintf(buf, size, "%llu", value);
+}
+
+static bool bpf_diag_range_unknown(s64 smin, s64 smax, u64 umin, u64 umax)
+{
+	return smin == S64_MIN && smax == S64_MAX &&
+	       umin == 0 && umax == U64_MAX;
+}
+
+static bool bpf_diag_var_off_unknown(u64 value, u64 mask)
+{
+	return value == 0 && mask == U64_MAX;
+}
+
+static bool bpf_diag_snapshot_unknown(const struct bpf_diag_reg_snapshot *snapshot)
+{
+	return bpf_diag_var_off_unknown(snapshot->var_off_value,
+					snapshot->var_off_mask) &&
+	       bpf_diag_range_unknown(snapshot->smin_value, snapshot->smax_value,
+				      snapshot->umin_value, snapshot->umax_value);
+}
+
+static void bpf_diag_format_scalar_range(char *buf, size_t size,
+					 s64 smin, s64 smax,
+					 u64 umin, u64 umax)
+{
+	char smin_buf[32], smax_buf[32], umin_buf[32], umax_buf[32];
+
+	bpf_diag_format_s64_value(smin_buf, sizeof(smin_buf), smin);
+	bpf_diag_format_s64_value(smax_buf, sizeof(smax_buf), smax);
+	bpf_diag_format_u64_value(umin_buf, sizeof(umin_buf), umin);
+	bpf_diag_format_u64_value(umax_buf, sizeof(umax_buf), umax);
+
+	scnprintf(buf, size,
+		  "signed range [%s, %s], unsigned range [%s, %s]",
+		  smin_buf, smax_buf, umin_buf, umax_buf);
+}
+
 static void bpf_diag_print_source_annotation(struct bpf_verifier_env *env,
 					     int line_width, int indent,
 					     const char *label,
@@ -609,11 +718,379 @@ void bpf_diag_record_branch(struct bpf_verifier_state *state, u32 insn_idx,
 	bpf_diag_append_history(state, &event);
 }
 
-void bpf_diag_print_history(struct bpf_verifier_env *env)
+static void bpf_diag_snapshot_one_reg(struct bpf_diag_reg_snapshot *snapshot,
+				      const struct bpf_reg_state *reg)
+{
+	snapshot->type = reg->type;
+	if (base_type(reg->type) == PTR_TO_MAP_VALUE ||
+	    base_type(reg->type) == CONST_PTR_TO_MAP ||
+	    base_type(reg->type) == PTR_TO_MAP_KEY)
+		snapshot->map_ptr = reg->map_ptr;
+	if (base_type(reg->type) == PTR_TO_BTF_ID && reg->btf && reg->btf_id) {
+		snapshot->btf = reg->btf;
+		snapshot->btf_id = reg->btf_id;
+	}
+	snapshot->var_off_known = tnum_is_const(reg->var_off);
+	snapshot->var_off_value = reg->var_off.value;
+	snapshot->var_off_mask = reg->var_off.mask;
+	snapshot->smin_value = reg_smin(reg);
+	snapshot->smax_value = reg_smax(reg);
+	snapshot->umin_value = reg_umin(reg);
+	snapshot->umax_value = reg_umax(reg);
+}
+
+static void bpf_diag_snapshot_reg(struct bpf_diag_history_event *event,
+				  enum bpf_diag_reg_mod_reason reason,
+				  const struct bpf_reg_state *old_reg,
+				  const struct bpf_reg_state *new_reg)
+{
+	event->reg.reason = reason;
+	bpf_diag_snapshot_one_reg(&event->reg.old, old_reg);
+	bpf_diag_snapshot_one_reg(&event->reg.new, new_reg);
+}
+
+static bool bpf_diag_snapshot_eq(const struct bpf_diag_reg_snapshot *old,
+				 const struct bpf_diag_reg_snapshot *new)
+{
+	return old->type == new->type &&
+	       old->map_ptr == new->map_ptr &&
+	       old->btf == new->btf &&
+	       old->btf_id == new->btf_id &&
+	       old->var_off_known == new->var_off_known &&
+	       old->var_off_value == new->var_off_value &&
+	       old->var_off_mask == new->var_off_mask &&
+	       old->smin_value == new->smin_value &&
+	       old->smax_value == new->smax_value &&
+	       old->umin_value == new->umin_value &&
+	       old->umax_value == new->umax_value;
+}
+
+static bool bpf_diag_reg_snapshot_eq(const struct bpf_diag_history_event *event)
+{
+	return bpf_diag_snapshot_eq(&event->reg.old, &event->reg.new);
+}
+
+static void bpf_diag_record_reg_mod_reason(struct bpf_verifier_state *state,
+					   u32 insn_idx, u8 dst_reg,
+					   bool src_valid, u8 src_reg,
+					   u8 opcode,
+					   enum bpf_diag_reg_mod_reason reason,
+					   const struct bpf_reg_state *old_reg,
+					   const struct bpf_reg_state *new_reg)
+{
+	struct bpf_diag_history_event event = {
+		.insn_idx = insn_idx,
+		.kind = BPF_DIAG_HISTORY_REG_MOD,
+		.reg.dst_reg = dst_reg,
+		.reg.src_reg = src_reg,
+		.reg.opcode = opcode,
+		.reg.src_valid = src_valid,
+	};
+
+	if (state && state->frame[state->curframe])
+		event.reg.frameno = state->frame[state->curframe]->frameno;
+
+	bpf_diag_snapshot_reg(&event, reason, old_reg, new_reg);
+	if (reason == BPF_DIAG_REG_MOD_WRITE &&
+	    bpf_diag_reg_snapshot_eq(&event))
+		return;
+
+	bpf_diag_append_history(state, &event);
+}
+
+void bpf_diag_record_reg_mod(struct bpf_verifier_state *state, u32 insn_idx,
+			     u8 dst_reg, bool src_valid, u8 src_reg, u8 opcode,
+			     const struct bpf_reg_state *old_reg,
+			     const struct bpf_reg_state *new_reg)
+{
+	bpf_diag_record_reg_mod_reason(state, insn_idx, dst_reg, src_valid,
+				       src_reg, opcode, BPF_DIAG_REG_MOD_WRITE,
+				       old_reg, new_reg);
+}
+
+void bpf_diag_record_reg_invalidate(struct bpf_verifier_state *state,
+				    u32 insn_idx, u8 dst_reg,
+				    enum bpf_diag_reg_mod_reason reason,
+				    const struct bpf_reg_state *old_reg,
+				    const struct bpf_reg_state *new_reg)
+{
+	bpf_diag_record_reg_mod_reason(state, insn_idx, dst_reg, false, 0, 0,
+				       reason, old_reg, new_reg);
+}
+
+void bpf_diag_record_stack_arg(struct bpf_verifier_state *state, u32 insn_idx,
+			       u32 frameno, u8 slot,
+			       enum bpf_diag_stack_arg_reason reason,
+			       const struct bpf_reg_state *old_reg,
+			       const struct bpf_reg_state *new_reg)
+{
+	struct bpf_diag_history_event event = {
+		.insn_idx = insn_idx,
+		.kind = BPF_DIAG_HISTORY_STACK_ARG,
+		.stack_arg.frameno = frameno,
+		.stack_arg.slot = slot,
+		.stack_arg.reason = reason,
+	};
+
+	bpf_diag_snapshot_one_reg(&event.stack_arg.old, old_reg);
+	bpf_diag_snapshot_one_reg(&event.stack_arg.new, new_reg);
+
+	if (reason == BPF_DIAG_STACK_ARG_WRITE &&
+	    bpf_diag_snapshot_eq(&event.stack_arg.old, &event.stack_arg.new))
+		return;
+
+	bpf_diag_append_history(state, &event);
+}
+
+static int bpf_diag_history_start_idx(const struct bpf_verifier_state *state,
+				      const struct bpf_diag_history_opts *opts)
+{
+	int i;
+
+	if (!opts || (opts->scope != BPF_DIAG_HISTORY_SCOPE_REG &&
+		      opts->scope != BPF_DIAG_HISTORY_SCOPE_STACK_ARG))
+		return 0;
+
+	for (i = state->diag_history_cnt; i > 0; i--) {
+		const struct bpf_diag_history_event *event = &state->diag_history[i - 1];
+
+		if (opts->scope == BPF_DIAG_HISTORY_SCOPE_REG &&
+		    event->kind == BPF_DIAG_HISTORY_REG_MOD &&
+		    event->reg.dst_reg == opts->regno &&
+		    event->reg.frameno == opts->frameno)
+			return i - 1;
+		if (opts->scope == BPF_DIAG_HISTORY_SCOPE_STACK_ARG &&
+		    event->kind == BPF_DIAG_HISTORY_STACK_ARG &&
+		    event->stack_arg.slot == opts->stack_arg_slot &&
+		    event->stack_arg.frameno == opts->frameno)
+			return i - 1;
+	}
+
+	return 0;
+}
+
+static bool bpf_diag_history_event_visible(const struct bpf_diag_history_event *event,
+					   const struct bpf_diag_history_opts *opts)
+{
+	if (!opts || opts->scope == BPF_DIAG_HISTORY_SCOPE_ALL)
+		return true;
+
+	switch (event->kind) {
+	case BPF_DIAG_HISTORY_BRANCH:
+		return true;
+	case BPF_DIAG_HISTORY_REG_MOD:
+		return opts->scope == BPF_DIAG_HISTORY_SCOPE_REG &&
+		       event->reg.dst_reg == opts->regno &&
+		       event->reg.frameno == opts->frameno;
+	case BPF_DIAG_HISTORY_STACK_ARG:
+		return opts->scope == BPF_DIAG_HISTORY_SCOPE_STACK_ARG &&
+		       event->stack_arg.slot == opts->stack_arg_slot &&
+		       event->stack_arg.frameno == opts->frameno;
+	default:
+		return false;
+	}
+}
+
+static void bpf_diag_format_var_offset(char *buf, size_t size,
+				       const struct bpf_diag_reg_snapshot *snapshot)
+{
+	char range[BPF_DIAG_REG_DESC_LEN];
+
+	if (snapshot->var_off_known) {
+		scnprintf(buf, size, "at offset %lld",
+			  snapshot->var_off_value);
+		return;
+	}
+
+	if (bpf_diag_snapshot_unknown(snapshot)) {
+		scnprintf(buf, size, "with unknown offset");
+		return;
+	}
+
+	bpf_diag_format_scalar_range(range, sizeof(range),
+				     snapshot->smin_value, snapshot->smax_value,
+				     snapshot->umin_value, snapshot->umax_value);
+	scnprintf(buf, size,
+		  "with variable offset: known bits %#llx, unknown mask %#llx, %s",
+		  (u64)snapshot->var_off_value, snapshot->var_off_mask,
+		  range);
+}
+
+static bool bpf_diag_format_snapshot_btf_type(char *buf, size_t size,
+					      const struct bpf_diag_reg_snapshot *snapshot)
+{
+	const struct btf_type *type;
+	const char *name;
+
+	if (!snapshot->btf || !snapshot->btf_id)
+		return false;
+
+	type = btf_type_by_id(snapshot->btf, snapshot->btf_id);
+	if (!type)
+		return false;
+
+	name = btf_name_by_offset(snapshot->btf, type->name_off);
+	bpf_diag_format_btf_type(buf, size, type, name);
+	return true;
+}
+
+static void bpf_diag_format_reg_snapshot(struct bpf_verifier_env *env, char *buf,
+					 size_t size,
+					 const struct bpf_diag_reg_snapshot *snapshot)
+{
+	const char *type_name = reg_type_str(env, snapshot->type);
+	char offset_desc[BPF_DIAG_REG_DESC_LEN];
+	char btf_type[BPF_DIAG_REG_DESC_LEN];
+	const char *map_name;
+	bool has_btf_type;
+
+	bpf_diag_format_var_offset(offset_desc, sizeof(offset_desc), snapshot);
+	has_btf_type = bpf_diag_format_snapshot_btf_type(btf_type,
+							 sizeof(btf_type),
+							 snapshot);
+
+	if (snapshot->type == SCALAR_VALUE) {
+		char range[BPF_DIAG_REG_DESC_LEN];
+
+		if (snapshot->var_off_known) {
+			scnprintf(buf, size, "integer scalar value %lld",
+				  snapshot->var_off_value);
+			return;
+		}
+
+		if (bpf_diag_snapshot_unknown(snapshot)) {
+			scnprintf(buf, size, "integer scalar with unknown value");
+			return;
+		}
+
+		if (snapshot->smin_value == snapshot->smax_value &&
+		    snapshot->umin_value == snapshot->umax_value) {
+			scnprintf(buf, size, "integer scalar value %lld",
+				  snapshot->smin_value);
+			return;
+		}
+
+		bpf_diag_format_scalar_range(range, sizeof(range),
+					     snapshot->smin_value,
+					     snapshot->smax_value,
+					     snapshot->umin_value,
+					     snapshot->umax_value);
+		scnprintf(buf, size,
+			  "integer scalar with %s", range);
+		return;
+	}
+
+	if (snapshot->type == NOT_INIT) {
+		scnprintf(buf, size, "uninitialized value");
+		return;
+	}
+
+	if (base_type(snapshot->type) == PTR_TO_CTX) {
+		scnprintf(buf, size, "context pointer %s", offset_desc);
+		return;
+	}
+
+	if (base_type(snapshot->type) == PTR_TO_STACK) {
+		scnprintf(buf, size, "stack pointer %s", offset_desc);
+		return;
+	}
+
+	if (base_type(snapshot->type) == PTR_TO_MAP_VALUE) {
+		map_name = bpf_diag_reg_map_name(snapshot->map_ptr);
+		if (map_name) {
+			scnprintf(buf, size, "%s from %s %s",
+				  type_may_be_null(snapshot->type) ?
+				  "nullable map value" : "map value",
+				  map_name, offset_desc);
+			return;
+		}
+		scnprintf(buf, size, "%s %s",
+			  type_may_be_null(snapshot->type) ?
+			  "nullable map value" : "map value",
+			  offset_desc);
+		return;
+	}
+
+	if (base_type(snapshot->type) == CONST_PTR_TO_MAP) {
+		map_name = bpf_diag_reg_map_name(snapshot->map_ptr);
+		if (map_name)
+			scnprintf(buf, size, "map pointer for map %s", map_name);
+		else
+			scnprintf(buf, size, "map pointer");
+		return;
+	}
+
+	if (type_is_non_owning_ref(snapshot->type)) {
+		if (has_btf_type)
+			scnprintf(buf, size,
+				  "borrowed allocated object pointer type=%s",
+				  btf_type);
+		else
+			scnprintf(buf, size, "borrowed allocated object pointer");
+		return;
+	}
+
+	if (type_is_ptr_alloc_obj(snapshot->type)) {
+		if (has_btf_type)
+			scnprintf(buf, size,
+				  "owned allocated object pointer type=%s",
+				  btf_type);
+		else
+			scnprintf(buf, size, "owned allocated object pointer");
+		return;
+	}
+
+	if (base_type(snapshot->type) == PTR_TO_BTF_ID && has_btf_type) {
+		scnprintf(buf, size, "%s type=%s %s", type_name, btf_type,
+			  offset_desc);
+		return;
+	}
+
+	scnprintf(buf, size, "%s %s", type_name, offset_desc);
+}
+
+static void bpf_diag_print_reg_mod(struct bpf_verifier_env *env,
+				   const struct bpf_diag_history_event *event)
+{
+	char old_buf[BPF_DIAG_REG_DESC_LEN], new_buf[BPF_DIAG_REG_DESC_LEN];
+	const char *reason = NULL;
+
+	bpf_diag_format_reg_snapshot(env, old_buf, sizeof(old_buf),
+				     &event->reg.old);
+	bpf_diag_format_reg_snapshot(env, new_buf, sizeof(new_buf),
+				     &event->reg.new);
+
+	switch (event->reg.reason) {
+	case BPF_DIAG_REG_MOD_REF_RELEASE:
+		reason = "resource release invalidated this pointer";
+		break;
+	case BPF_DIAG_REG_MOD_PKT_DATA_CHANGE:
+		reason = "packet data may have moved";
+		break;
+	case BPF_DIAG_REG_MOD_WRITE:
+	default:
+		break;
+	}
+
+	if (reason) {
+		bpf_diag_report_source(env, event->insn_idx, 'x',
+				       "R%d: %s; previous value was %s",
+				       event->reg.dst_reg, reason, old_buf);
+		return;
+	}
+
+	bpf_diag_report_source(env, event->insn_idx, '~',
+			       "R%d changed from %s to %s",
+			       event->reg.dst_reg, old_buf, new_buf);
+}
+
+void bpf_diag_print_history(struct bpf_verifier_env *env,
+			    const struct bpf_diag_history_opts *opts)
 {
 	const struct bpf_verifier_state *state = env->cur_state;
 	const struct bpf_diag_history_event *event;
 	bool printed = false;
+	int start_idx;
 	u32 i;
 
 	bpf_diag_report_section(env, "Causal path");
@@ -621,12 +1098,15 @@ void bpf_diag_print_history(struct bpf_verifier_env *env)
 	if (!state)
 		return;
 
-	if (state->diag_history_omitted)
+	start_idx = bpf_diag_history_start_idx(state, opts);
+	if (state->diag_history_omitted && start_idx == 0)
 		verbose(env, "  ... %u earlier diagnostic events omitted by display limit ...\n",
 			state->diag_history_omitted);
 
-	for (i = 0; i < state->diag_history_cnt; i++) {
+	for (i = start_idx; i < state->diag_history_cnt; i++) {
 		event = &state->diag_history[i];
+		if (!bpf_diag_history_event_visible(event, opts))
+			continue;
 
 		switch (event->kind) {
 		case BPF_DIAG_HISTORY_BRANCH:
@@ -638,6 +1118,10 @@ void bpf_diag_print_history(struct bpf_verifier_env *env)
 					       "not followed");
 			printed = true;
 			break;
+		case BPF_DIAG_HISTORY_REG_MOD:
+			bpf_diag_print_reg_mod(env, event);
+			printed = true;
+			break;
 		default:
 			break;
 		}
diff --git a/kernel/bpf/diagnostics.h b/kernel/bpf/diagnostics.h
index 1392ff5fb027..b8dfe8103966 100644
--- a/kernel/bpf/diagnostics.h
+++ b/kernel/bpf/diagnostics.h
@@ -19,6 +19,34 @@ enum bpf_diag_category {
 	BPF_DIAG_CATEGORY_VERIFIER_INTERNAL_ERROR,
 };
 
+struct bpf_map;
+struct btf;
+struct btf_type;
+
+void bpf_diag_format_btf_type(char *buf, size_t size,
+			      const struct btf_type *type,
+			      const char *type_name);
+
+struct bpf_diag_reg_snapshot {
+	u32 type;
+	const struct bpf_map *map_ptr;
+	const struct btf *btf;
+	u32 btf_id;
+	bool var_off_known;
+	s64 var_off_value;
+	u64 var_off_mask;
+	s64 smin_value;
+	s64 smax_value;
+	u64 umin_value;
+	u64 umax_value;
+};
+
+enum bpf_diag_reg_mod_reason {
+	BPF_DIAG_REG_MOD_WRITE,
+	BPF_DIAG_REG_MOD_REF_RELEASE,
+	BPF_DIAG_REG_MOD_PKT_DATA_CHANGE,
+};
+
 struct bpf_diag_history_event {
 	u32 insn_idx;
 	u8 kind;
@@ -26,6 +54,21 @@ struct bpf_diag_history_event {
 		struct {
 			bool cond_true;
 		} branch;
+		struct {
+			u32 frameno;
+			u8 dst_reg;
+			u8 src_reg;
+			u8 opcode;
+			bool src_valid;
+			u8 reason;
+			struct bpf_diag_reg_snapshot old, new;
+		} reg;
+		struct {
+			u32 frameno;
+			u8 slot;
+			u8 reason;
+			struct bpf_diag_reg_snapshot old, new;
+		} stack_arg;
 	};
 };
 
@@ -33,9 +76,31 @@ struct bpf_diag_history_event {
 
 enum bpf_diag_history_kind {
 	BPF_DIAG_HISTORY_BRANCH,
+	BPF_DIAG_HISTORY_REG_MOD,
+	BPF_DIAG_HISTORY_STACK_ARG,
+};
+
+enum bpf_diag_history_scope {
+	BPF_DIAG_HISTORY_SCOPE_ALL,
+	BPF_DIAG_HISTORY_SCOPE_REG,
+	BPF_DIAG_HISTORY_SCOPE_STACK_ARG,
+};
+
+enum bpf_diag_stack_arg_reason {
+	BPF_DIAG_STACK_ARG_WRITE,
+	BPF_DIAG_STACK_ARG_REF_RELEASE,
+	BPF_DIAG_STACK_ARG_PKT_DATA_CHANGE,
+};
+
+struct bpf_diag_history_opts {
+	enum bpf_diag_history_scope scope;
+	u32 frameno;
+	int regno;
+	int stack_arg_slot;
 };
 
 struct bpf_verifier_env;
+struct bpf_reg_state;
 struct bpf_verifier_state;
 
 void bpf_diag_report_header(struct bpf_verifier_env *env,
@@ -55,6 +120,21 @@ void bpf_diag_copy_history(struct bpf_verifier_state *dst,
 			   const struct bpf_verifier_state *src);
 void bpf_diag_record_branch(struct bpf_verifier_state *state, u32 insn_idx,
 			    bool cond_true);
-void bpf_diag_print_history(struct bpf_verifier_env *env);
+void bpf_diag_record_reg_mod(struct bpf_verifier_state *state, u32 insn_idx,
+			     u8 dst_reg, bool src_valid, u8 src_reg, u8 opcode,
+			     const struct bpf_reg_state *old_reg,
+			     const struct bpf_reg_state *new_reg);
+void bpf_diag_record_reg_invalidate(struct bpf_verifier_state *state,
+				    u32 insn_idx, u8 dst_reg,
+				    enum bpf_diag_reg_mod_reason reason,
+				    const struct bpf_reg_state *old_reg,
+				    const struct bpf_reg_state *new_reg);
+void bpf_diag_record_stack_arg(struct bpf_verifier_state *state, u32 insn_idx,
+			       u32 frameno, u8 slot,
+			       enum bpf_diag_stack_arg_reason reason,
+			       const struct bpf_reg_state *old_reg,
+			       const struct bpf_reg_state *new_reg);
+void bpf_diag_print_history(struct bpf_verifier_env *env,
+			    const struct bpf_diag_history_opts *opts);
 
 #endif /* __BPF_DIAGNOSTICS_H */
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index d60e1309957a..188201d48108 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -4033,6 +4033,8 @@ static int check_stack_arg_write(struct bpf_verifier_env *env, struct bpf_func_s
 	struct bpf_subprog_info *subprog = &env->subprog_info[state->subprogno];
 	int spi = -off / BPF_REG_SIZE - 1;
 	struct bpf_reg_state *arg;
+	struct bpf_reg_state old_arg;
+	bool slot_exists;
 	int err;
 
 	if (spi >= max_stack_arg_regs) {
@@ -4041,6 +4043,7 @@ static int check_stack_arg_write(struct bpf_verifier_env *env, struct bpf_func_s
 		return -EINVAL;
 	}
 
+	slot_exists = spi < state->out_stack_arg_cnt;
 	err = grow_stack_arg_slots(env, state, spi + 1);
 	if (err)
 		return err;
@@ -4049,13 +4052,27 @@ static int check_stack_arg_write(struct bpf_verifier_env *env, struct bpf_func_s
 	if (spi + 1 > subprog->max_out_stack_arg_cnt)
 		subprog->max_out_stack_arg_cnt = spi + 1;
 
+	arg = &state->stack_arg_regs[spi];
+	if (slot_exists)
+		old_arg = *arg;
+	else
+		bpf_mark_reg_not_init(env, &old_arg);
+
 	if (value_reg) {
 		state->stack_arg_regs[spi] = *value_reg;
+		bpf_diag_record_stack_arg(env->cur_state, env->insn_idx,
+					  state->frameno, spi,
+					  BPF_DIAG_STACK_ARG_WRITE,
+					  &old_arg,
+					  &state->stack_arg_regs[spi]);
 	} else {
 		/* BPF_ST: store immediate, treat as scalar */
-		arg = &state->stack_arg_regs[spi];
 		arg->type = SCALAR_VALUE;
 		__mark_reg_known(arg, env->prog->insnsi[env->insn_idx].imm);
+		bpf_diag_record_stack_arg(env->cur_state, env->insn_idx,
+					  state->frameno, spi,
+					  BPF_DIAG_STACK_ARG_WRITE,
+					  &old_arg, arg);
 	}
 	state->no_stack_arg_load = true;
 	return bpf_push_jmp_history(env, env->cur_state,
@@ -6316,15 +6333,27 @@ static int check_load_mem(struct bpf_verifier_env *env, struct bpf_insn *insn,
 	struct bpf_verifier_state *vstate = env->cur_state;
 	struct bpf_func_state *state = vstate->frame[vstate->curframe];
 	struct bpf_reg_state *regs = cur_regs(env);
+	struct bpf_reg_state old_dst = {};
 	enum bpf_reg_type src_reg_type;
+	bool have_old_dst;
 	int err;
 
+	have_old_dst = insn->dst_reg < MAX_BPF_REG;
+	if (have_old_dst)
+		old_dst = regs[insn->dst_reg];
+
 	/* Handle stack arg read */
 	if (is_stack_arg_ldx(insn)) {
 		err = check_reg_arg(env, insn->dst_reg, DST_OP_NO_MARK);
 		if (err)
 			return err;
-		return check_stack_arg_read(env, state, insn->off, insn->dst_reg);
+		err = check_stack_arg_read(env, state, insn->off, insn->dst_reg);
+		if (!err && have_old_dst)
+			bpf_diag_record_reg_mod(env->cur_state, env->insn_idx,
+						insn->dst_reg, true,
+						insn->src_reg, BPF_OP(insn->code),
+						&old_dst, &regs[insn->dst_reg]);
+		return err;
 	}
 
 	/* check src operand */
@@ -6348,6 +6377,11 @@ static int check_load_mem(struct bpf_verifier_env *env, struct bpf_insn *insn,
 	err = err ?: save_aux_ptr_type(env, src_reg_type,
 				       allow_trust_mismatch);
 	err = err ?: reg_bounds_sanity_check(env, &regs[insn->dst_reg], ctx);
+	if (!err && have_old_dst)
+		bpf_diag_record_reg_mod(env->cur_state, env->insn_idx,
+					insn->dst_reg, true, insn->src_reg,
+					BPF_OP(insn->code), &old_dst,
+					&regs[insn->dst_reg]);
 
 	return err;
 }
@@ -8833,14 +8867,51 @@ static int check_func_proto(const struct bpf_func_proto *fn, struct bpf_call_arg
  * This also applies to dynptr slices belonging to skb and xdp dynptrs,
  * since these slices point to packet data.
  */
+static int bpf_diag_stack_arg_slot(const struct bpf_func_state *state,
+				   const struct bpf_reg_state *reg)
+{
+	if (!state->stack_arg_regs)
+		return -1;
+	if (reg < state->stack_arg_regs ||
+	    reg >= state->stack_arg_regs + state->out_stack_arg_cnt)
+		return -1;
+	return reg - state->stack_arg_regs;
+}
+
+static int bpf_diag_func_regno(const struct bpf_func_state *state,
+			       const struct bpf_reg_state *reg)
+{
+	if (reg < state->regs || reg >= state->regs + MAX_BPF_REG)
+		return -1;
+	return reg - state->regs;
+}
+
 static void clear_all_pkt_pointers(struct bpf_verifier_env *env)
 {
 	struct bpf_func_state *state;
 	struct bpf_reg_state *reg;
 
 	bpf_for_each_reg_in_vstate(env->cur_state, state, reg, ({
-		if (reg_is_pkt_pointer_any(reg) || reg_is_dynptr_slice_pkt(reg))
+		if (reg_is_pkt_pointer_any(reg) || reg_is_dynptr_slice_pkt(reg)) {
+			struct bpf_reg_state old_reg = *reg;
+			int regno = bpf_diag_func_regno(state, reg);
+			int slot = bpf_diag_stack_arg_slot(state, reg);
+
 			mark_reg_invalid(env, reg);
+			if (regno >= 0)
+				bpf_diag_record_reg_invalidate(env->cur_state,
+							       env->insn_idx,
+							       regno,
+							       BPF_DIAG_REG_MOD_PKT_DATA_CHANGE,
+							       &old_reg, reg);
+			if (slot >= 0)
+				bpf_diag_record_stack_arg(env->cur_state,
+							  env->insn_idx,
+							  state->frameno,
+							  slot,
+							  BPF_DIAG_STACK_ARG_PKT_DATA_CHANGE,
+							  &old_reg, reg);
+		}
 	}));
 }
 
@@ -8946,6 +9017,10 @@ static int release_reference(struct bpf_verifier_env *env, int id)
 		}
 
 		bpf_for_each_reg_in_vstate_mask(vstate, state, reg, stack, mask, ({
+			struct bpf_reg_state old_reg;
+			int regno;
+			int slot;
+
 			if (reg->id != id && reg->parent_id != id)
 				continue;
 
@@ -8956,10 +9031,24 @@ static int release_reference(struct bpf_verifier_env *env, int id)
 					return err;
 			}
 
+			old_reg = *reg;
+			regno = bpf_diag_func_regno(state, reg);
+			slot = bpf_diag_stack_arg_slot(state, reg);
 			if (!stack || stack->slot_type[BPF_REG_SIZE - 1] == STACK_SPILL)
 				mark_reg_invalid(env, reg);
 			else if (stack->slot_type[BPF_REG_SIZE - 1] == STACK_DYNPTR)
 				invalidate_dynptr(env, stack);
+			if (regno >= 0)
+				bpf_diag_record_reg_invalidate(vstate,
+							       env->insn_idx,
+							       regno,
+							       BPF_DIAG_REG_MOD_REF_RELEASE,
+							       &old_reg, reg);
+			if (slot >= 0)
+				bpf_diag_record_stack_arg(vstate, env->insn_idx,
+							  state->frameno, slot,
+							  BPF_DIAG_STACK_ARG_REF_RELEASE,
+							  &old_reg, reg);
 		}));
 	}
 
@@ -14801,9 +14890,15 @@ static int adjust_reg_min_max_vals(struct bpf_verifier_env *env,
 static int check_alu_op(struct bpf_verifier_env *env, struct bpf_insn *insn)
 {
 	struct bpf_reg_state *regs = cur_regs(env);
+	struct bpf_reg_state old_dst = {};
 	u8 opcode = BPF_OP(insn->code);
+	bool have_old_dst;
 	int err;
 
+	have_old_dst = insn->dst_reg < MAX_BPF_REG;
+	if (have_old_dst)
+		old_dst = regs[insn->dst_reg];
+
 	if (opcode == BPF_END || opcode == BPF_NEG) {
 		/* check src operand */
 		err = check_reg_arg(env, insn->dst_reg, SRC_OP);
@@ -14984,7 +15079,16 @@ static int check_alu_op(struct bpf_verifier_env *env, struct bpf_insn *insn)
 			return err;
 	}
 
-	return reg_bounds_sanity_check(env, &regs[insn->dst_reg], "alu");
+	err = reg_bounds_sanity_check(env, &regs[insn->dst_reg], "alu");
+	if (err)
+		return err;
+
+	if (have_old_dst)
+		bpf_diag_record_reg_mod(env->cur_state, env->insn_idx,
+					insn->dst_reg, BPF_SRC(insn->code) == BPF_X,
+					insn->src_reg, opcode, &old_dst,
+					&regs[insn->dst_reg]);
+	return 0;
 }
 
 static void find_good_pkt_pointers(struct bpf_verifier_state *vstate,
-- 
2.53.0

