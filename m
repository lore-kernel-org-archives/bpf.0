Received: from mail-wm2-f11.google.com (mail-wm2-f11.google.com [74.125.225.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E62804302F6
	for <bpf@vger.kernel.org>; Wed, 12 Aug 2026 23:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786577622; cv=none; b=fKMQO268x1u40IFk82kq1JNab7Bdzrk9+elDWWkDdeBdaWK2SY/lkgQc13PZUtg8OwqttDyNCDGYSVkMutgdHuZxAt+LVMLGjRXynl0//FdFAI57QT8w0GsLbAI742LxZkChddg+f/7o2Bh6FhGSv6vxkSP7doX9+bPfD6wLC7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786577622; c=relaxed/simple;
	bh=L9gALn8ugbK3HCKX90DR6mWzc7zF5Dsu0GLRvPGvqXs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q/oQAe/y2BMHUZLBFX/eofuqPI/usL1iUNVPn9puzHqhig2qcP20DONRrvMu1BT5DYMgsAan6cc+F9tARwRWwQRR+BRhOGa1nErJLm/KLHx6fupOGSIamb4r+pUAucvJQejD7+wyUyTBUu4zit6RLRUQK1/G/HcruRNKqoDF++s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oF8dQvdx; arc=none smtp.client-ip=74.125.225.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oF8dQvdx"
Received: by mail-wm2-f11.google.com with SMTP id 5b1f17b1804b1-4994d67d2e7so355035e9.0
        for <bpf@vger.kernel.org>; Wed, 12 Aug 2026 16:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786577618; x=1787182418; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qW9QVPF1SArgy2rYojxdOxySWjSjZ47dqwx8qREUh1U=;
        b=oF8dQvdx12FGPlSQEwLCouGoOB2w39J6Ihbic95r+9WnkeAe4tw44fCSwylE2x8GfM
         WUqNoeO5H3Hi8xZmbf0fZshxaHtXQ9fyvF2at+OfrfaCLAgoohavoygCZxACAgoQtqOh
         ZrJUehsuHKOkfM9P3S8Aeg1QdISqmnnM/QFUCpEC8h1sjOMlZ3yRawTv7z37TsJzc67g
         oAO/10oRYjofFng2TMZFH787SJNtyXYG8agPtf4nGKsbpEWtBleTX7RuU7uvKA8Oo+NN
         whgrkSs8mjXSH7KTIgYxWXmTa+vQcagAV0yhyYqSRrGcRd+RFUn+AO7jH4891dnlOr5v
         02Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786577618; x=1787182418;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=qW9QVPF1SArgy2rYojxdOxySWjSjZ47dqwx8qREUh1U=;
        b=ALGVuAp4tMlmian+Myxfngb7fTn31ubCb61c9dNVB09zbPffiC4+CZeq0nGU1Y5Vhw
         FwFIHeJ+8RnBtwRbAaGi1soLDcRqQ+N16pwtyt4Aru1xTo5OxpBdNfrnVJWbGFpbpzok
         vca+qwbw889JLfA5QsWODMFtmcsdtHtVOriQ1i9Gm2/G4TcQIv4IXvjSBRsJumZmiN77
         4y7p77XADZRY8ZXZOBlyuBvUYBGUGLOLEhjdI4M0B3+wv+v6xfV2TVmOt2J65TkEPPV8
         MBlaJXaXW2lQzdaQp8HLJe7P22RwWcqW9iAVm1EphHNjNwh+yIeyvkkLO/mLV+Fd6aLF
         jIEA==
X-Gm-Message-State: AOJu0YxPaAki4BdxbyDaLh/H2P/HPk9otmnSBGQhZVI9rGaOYB3KtJaF
	bULxWl/Fi2X/OfGXeSycWe8l496VH2lvBSqVRgKNOaOv+gkrxmLFSJYZxXkTL3ch
X-Gm-Gg: AR+sD13w9TVGJneStWqqnDDBvCjjGigNxdhzow27YcH+JUX2NqcdHmxhLJQsrS8HKON
	RTbsYEcgdDHxDuJFTrk8hiNriiVpCkb5TNLNIkUJWkiyULj973EzF0YuC/OdsMvoaF5Lr8qlti8
	dZVWBaRvCnz8+ehkPL6+1Qk+sxeG2FdS/2K8bZb8OiMAW8SNqWQ3IVGYmOVMf5NiiFiw6qJQ2IG
	lV/IKql8sUYoPUiaSojYlrrUWAXPrND8kHoDUbJamj9LYhYKg5qxEQVv+mkQmz12mVzh4RKzuYo
	pGChnPEAMo+oiVcEEdKaTv91iSj/YM97RzrROgivKskF79TMbuZ9MSWTCGFxy67UewZ8CcJSiC2
	MkLDoF5MaMvO7sDEwthzneH9wnjl88iH7CQm0ZAyBsANGAY+/D5Zo2DjN0D4ZU9k7MYuote96EH
	d5mXqiYH+Wek/rZ7yYRNJEAheJzI6uyeSrK3c/hMnMDBRz9+3k46R77groMZGHkU49Eo0AwWQrS
	BtFyOO/URntx5XpBnxVZePnWSq1i3oVEoA2JpaRdDzCp4Ie/41+j3joYIgqvdneb6sY1Tdry/1G
	Tugboz4RLPpro2KVMvAzaGWZUMA=
X-Received: by 2002:a05:600c:3ba2:b0:493:a966:d5b5 with SMTP id 5b1f17b1804b1-499821bd042mr13192565e9.2.1786577617586;
        Wed, 12 Aug 2026 16:33:37 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49981b631c1sm46237405e9.14.2026.08.12.16.33.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 16:33:36 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v4 05/16] bpf: Track verifier register diagnostic events
Date: Thu, 13 Aug 2026 01:33:08 +0200
Message-ID: <20260812233326.3575958-6-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260812233326.3575958-1-memxor@gmail.com>
References: <20260812233326.3575958-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=26389; i=memxor@gmail.com; h=from:subject; bh=L9gALn8ugbK3HCKX90DR6mWzc7zF5Dsu0GLRvPGvqXs=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIauWQevahUxfq2/uFx9PWMq+9warwKaNnTXtLoF3T8drt ef+ene8o5SFQYyLQVZMkaXk/z4m4xOVvwNtl3HDzGFlAhnCwMUpABO5WcLwh3Pv/DlurWsXuhrd 6ZeqWtzPpcrMNNe+2CdNqO9Wst+/CQx/Rdhu+p/0slQ7vOvTN/Ep4R+elJ+ZxTVN7njx0lhd7Zp 7PAA=
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

The type_is_map_ptr() helper previously lived as a static function in
kernel/bpf/log.c since commit 0c95c9fdb696 ("bpf: emit map name in register
state if applicable and available"). Move it verbatim to
include/linux/bpf_verifier.h as a static inline, next to the other type
classifiers, so diagnostics.c can reuse it without duplicating the case list.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/linux/bpf_verifier.h |  12 ++
 kernel/bpf/diagnostics.c     | 271 ++++++++++++++++++++++++++++++++++-
 kernel/bpf/diagnostics.h     |  80 +++++++++++
 kernel/bpf/log.c             |  11 --
 kernel/bpf/verifier.c        | 134 +++++++++++++----
 5 files changed, 468 insertions(+), 40 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 14cc174d31c1..3786961c4efc 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -1347,6 +1347,18 @@ static inline bool type_is_non_owning_ref(u32 type)
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
index 0e0aa3a7106c..460bb83ae33d 100644
--- a/kernel/bpf/diagnostics.c
+++ b/kernel/bpf/diagnostics.c
@@ -30,15 +30,23 @@
 #define BPF_DIAG_CONTEXT_CNT (1 + BPF_DIAG_CONTEXT * 2)
 #define BPF_DIAG_SOURCE_LANE_WIDTH 88
 #define BPF_DIAG_TAB_WIDTH 8
-#define BPF_DIAG_REG_DESC_LEN 512
-#define BPF_DIAG_REG_TMP_LEN 192
 #define BPF_DIAG_FMT_CHUNK_SIZE 1024
 #define BPF_DIAG_FMT_BUF_SIZE 256
 #define BPF_DIAG_EVENT_LOG_MAX_SIZE (1U << 20)
 #define DISASM_LINE_LEN 160
 
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
 };
 
 struct bpf_diag_history_event {
@@ -49,6 +57,13 @@ struct bpf_diag_history_event {
 		struct {
 			bool cond_true;
 		} branch;
+		struct {
+			struct bpf_diag_mod_target target;
+			struct bpf_diag_mod_target origin;
+			struct bpf_diag_reg_snapshot old, new;
+			u8 reason;
+			bool origin_valid;
+		} mod;
 	};
 };
 
@@ -87,10 +102,21 @@ struct bpf_diag_scratch {
 	struct disasm_line disasm_lines[BPF_DIAG_CONTEXT_CNT];
 };
 
+struct bpf_diag_mod_scope {
+	struct bpf_reg_state target_reg_snapshot;
+	struct bpf_diag_mod_target target;
+	struct bpf_diag_mod_target origin;
+	enum bpf_diag_mod_reason reason;
+	u32 insn_idx;
+	bool active;
+	bool origin_valid;
+};
+
 struct bpf_diag {
 	struct bpf_diag_log log;
 	struct bpf_diag_scratch scratch;
 	struct list_head fmt_chunks;
+	struct bpf_diag_mod_scope mod;
 };
 
 bool bpf_diag_enabled(const struct bpf_verifier_env *env)
@@ -375,6 +401,34 @@ static void diag_print_wrapped_prefixed(struct bpf_verifier_env *env, const char
 	}
 }
 
+static void bpf_diag_format_btf_type(char *buf, size_t size, const struct btf *btf, u32 type_id)
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
+const char *bpf_diag_fmt_btf_type(struct bpf_verifier_env *env, const struct btf *btf, u32 type_id)
+{
+	char *buf = bpf_diag_fmt_buf(env, BPF_DIAG_FMT_BUF_SIZE);
+
+	if (!buf)
+		return "";
+
+	bpf_diag_format_btf_type(buf, BPF_DIAG_FMT_BUF_SIZE, btf, type_id);
+	return buf;
+}
+
 static int diag_line_width(unsigned int line)
 {
 	int width = 1;
@@ -672,3 +726,216 @@ void bpf_diag_record_branch(struct bpf_verifier_env *env, u32 insn_idx, bool con
 
 	diag_append_history(env, &event);
 }
+
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
+static void bpf_diag_record_mod(struct bpf_verifier_env *env, u32 insn_idx,
+				struct bpf_diag_mod_target target,
+				enum bpf_diag_mod_reason reason,
+				const struct bpf_reg_state *old_reg,
+				const struct bpf_reg_state *new_reg,
+				const struct bpf_diag_mod_target *origin)
+{
+	struct bpf_diag_history_event event = {
+		.insn_idx = insn_idx,
+		.kind = BPF_DIAG_HISTORY_MOD,
+		.mod = {
+			.target = target,
+			.reason = reason,
+		},
+	};
+
+	if (old_reg)
+		diag_snapshot_reg(&event.mod.old, old_reg);
+	if (new_reg)
+		diag_snapshot_reg(&event.mod.new, new_reg);
+	if (old_reg && new_reg &&
+	    (reason == BPF_DIAG_MOD_WRITE || reason == BPF_DIAG_MOD_SPILL) &&
+	    diag_snapshot_eq(&event.mod.old, &event.mod.new))
+		return;
+	if (origin) {
+		event.mod.origin = *origin;
+		event.mod.origin_valid = true;
+	} else if (diag_mod_insn_origin(env, insn_idx, &target, &event.mod.origin)) {
+		event.mod.origin_valid = true;
+	}
+
+	diag_append_history(env, &event);
+}
+
+static struct bpf_func_state *diag_func_state(struct bpf_verifier_env *env, u32 frameno)
+{
+	struct bpf_verifier_state *vstate = env->cur_state;
+	int frame;
+
+	for (frame = 0; frame <= vstate->curframe; frame++) {
+		if (vstate->frame[frame]->frameno == frameno)
+			return vstate->frame[frame];
+	}
+	return NULL;
+}
+
+static struct bpf_reg_state *target_to_reg(struct bpf_verifier_env *env,
+					   const struct bpf_diag_mod_target *target)
+{
+	struct bpf_func_state *state = diag_func_state(env, target->frameno);
+
+	if (!state)
+		return NULL;
+
+	switch (target->kind) {
+	case BPF_DIAG_MOD_TARGET_REG:
+		if (target->regno >= MAX_BPF_REG)
+			return NULL;
+		return &state->regs[target->regno];
+	case BPF_DIAG_MOD_TARGET_STACK_ARG:
+		if (target->stack_arg >= state->out_stack_arg_cnt)
+			return NULL;
+		return &state->stack_arg_regs[target->stack_arg];
+	case BPF_DIAG_MOD_TARGET_STACK_SLOT:
+		if (target->spi >= state->allocated_stack / BPF_REG_SIZE)
+			return NULL;
+		return &state->stack[target->spi].spilled_ptr;
+	default:
+		return NULL;
+	}
+}
+
+static bool reg_to_target(struct bpf_verifier_env *env, const struct bpf_reg_state *reg,
+			  struct bpf_diag_mod_target *target)
+{
+	struct bpf_verifier_state *vstate = env->cur_state;
+	unsigned long addr = (unsigned long)reg;
+	int frame;
+
+	for (frame = 0; frame <= vstate->curframe; frame++) {
+		struct bpf_func_state *state = vstate->frame[frame];
+		unsigned long start, end;
+		u32 nslots = state->allocated_stack / BPF_REG_SIZE;
+		int spi;
+
+		start = (unsigned long)state->regs;
+		end = (unsigned long)(state->regs + MAX_BPF_REG);
+		if (addr >= start && addr < end) {
+			*target = bpf_diag_reg_target(state->frameno, reg - state->regs);
+			return true;
+		}
+
+		start = (unsigned long)state->stack_arg_regs;
+		end = (unsigned long)(state->stack_arg_regs + state->out_stack_arg_cnt);
+		if (state->out_stack_arg_cnt && addr >= start && addr < end) {
+			*target = bpf_diag_stack_arg_target(state->frameno,
+							    reg - state->stack_arg_regs);
+			return true;
+		}
+
+		start = (unsigned long)state->stack;
+		end = (unsigned long)(state->stack + nslots);
+		if (nslots && addr >= start && addr < end) {
+			spi = ((const char *)reg - (const char *)state->stack) /
+			      sizeof(*state->stack);
+			*target = bpf_diag_stack_slot_target(state->frameno, spi);
+			return true;
+		}
+	}
+	return false;
+}
+
+void bpf_diag_mod_begin(struct bpf_verifier_env *env, const struct bpf_reg_state *reg,
+			const struct bpf_reg_state *origin, enum bpf_diag_mod_reason reason)
+{
+	struct bpf_diag *diag = diag_env(env);
+
+	if (!diag)
+		return;
+	diag->mod.active = reg_to_target(env, reg, &diag->mod.target);
+	if (!diag->mod.active)
+		return;
+	diag->mod.target_reg_snapshot = *reg;
+	diag->mod.insn_idx = env->insn_idx;
+	diag->mod.reason = reason;
+	diag->mod.origin_valid = origin && reg_to_target(env, origin, &diag->mod.origin);
+}
+
+void bpf_diag_mod_end(struct bpf_verifier_env *env)
+{
+	struct bpf_diag *diag = diag_env(env);
+	const struct bpf_reg_state *new_reg;
+
+	if (!diag || !diag->mod.active)
+		return;
+	diag->mod.active = false;
+	/*
+	 * Resolve the target again because the enclosing function state's stack
+	 * may have been reallocated while the modification was in progress.
+	 */
+	new_reg = target_to_reg(env, &diag->mod.target);
+	if (!new_reg)
+		return;
+	bpf_diag_record_mod(env, diag->mod.insn_idx, diag->mod.target, diag->mod.reason,
+			    &diag->mod.target_reg_snapshot, new_reg,
+			    diag->mod.origin_valid ? &diag->mod.origin : NULL);
+}
+
+void bpf_diag_record_scrub(struct bpf_verifier_env *env, const struct bpf_reg_state *reg,
+			   enum bpf_diag_mod_reason reason)
+{
+	struct bpf_diag_mod_target target;
+
+	if (!diag_env(env) || reg->type == NOT_INIT || !reg_to_target(env, reg, &target))
+		return;
+	bpf_diag_record_mod(env, env->insn_idx, target, reason, reg, NULL, NULL);
+}
+
+void bpf_diag_record_scrub_stack(struct bpf_verifier_env *env, u32 frameno, s16 min_off,
+				 s16 max_off, enum bpf_diag_mod_reason reason)
+{
+	bpf_diag_record_mod(env, env->insn_idx,
+			    bpf_diag_stack_range_target(frameno, min_off, max_off), reason,
+			    NULL, NULL, NULL);
+}
diff --git a/kernel/bpf/diagnostics.h b/kernel/bpf/diagnostics.h
index 9cc6b4747a06..8785f8d9a9ca 100644
--- a/kernel/bpf/diagnostics.h
+++ b/kernel/bpf/diagnostics.h
@@ -7,7 +7,79 @@
 #include <linux/compiler_attributes.h>
 #include <linux/types.h>
 
+struct bpf_reg_state;
 struct bpf_verifier_env;
+struct btf;
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
@@ -15,6 +87,7 @@ char *bpf_diag_fmt_buf(struct bpf_verifier_env *env, size_t size);
 const char *bpf_diag_vfmt(struct bpf_verifier_env *env, const char *fmt, va_list args)
 	__printf(2, 0);
 const char *bpf_diag_fmt(struct bpf_verifier_env *env, const char *fmt, ...) __printf(2, 3);
+const char *bpf_diag_fmt_btf_type(struct bpf_verifier_env *env, const struct btf *btf, u32 type_id);
 u32 bpf_diag_event_log_pos(struct bpf_verifier_env *env);
 void bpf_diag_event_log_reset(struct bpf_verifier_env *env, u32 pos);
 void bpf_diag_free(struct bpf_verifier_env *env);
@@ -23,5 +96,12 @@ void bpf_diag_header(struct bpf_verifier_env *env, const char *category,
 void bpf_diag_source(struct bpf_verifier_env *env, u32 insn_idx, const char *label,
 			    const char *fmt, ...) __printf(4, 5);
 void bpf_diag_record_branch(struct bpf_verifier_env *env, u32 insn_idx, bool cond_true);
+void bpf_diag_mod_begin(struct bpf_verifier_env *env, const struct bpf_reg_state *reg,
+			const struct bpf_reg_state *origin, enum bpf_diag_mod_reason reason);
+void bpf_diag_mod_end(struct bpf_verifier_env *env);
+void bpf_diag_record_scrub(struct bpf_verifier_env *env, const struct bpf_reg_state *reg,
+			   enum bpf_diag_mod_reason reason);
+void bpf_diag_record_scrub_stack(struct bpf_verifier_env *env, u32 frameno, s16 min_off,
+				 s16 max_off, enum bpf_diag_mod_reason reason);
 
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
index 2e915292265b..ed8a239a964d 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -1792,6 +1792,17 @@ static const int caller_saved[CALLER_SAVED_REGS] = {
 	BPF_REG_0, BPF_REG_1, BPF_REG_2, BPF_REG_3, BPF_REG_4, BPF_REG_5
 };
 
+static void bpf_diag_record_caller_saved(struct bpf_verifier_env *env,
+					 struct bpf_reg_state *regs)
+{
+	int i;
+
+	for (i = 1; i < CALLER_SAVED_REGS; i++) {
+		bpf_diag_record_scrub(env, &regs[caller_saved[i]],
+				      BPF_DIAG_MOD_CALLER_SAVED);
+	}
+}
+
 /* This helper doesn't clear reg->id */
 static void ___mark_reg_known(struct bpf_reg_state *reg, u64 imm)
 {
@@ -3341,6 +3352,7 @@ static void save_register_state(struct bpf_verifier_env *env,
 {
 	int i;
 
+	bpf_diag_mod_begin(env, &state->stack[spi].spilled_ptr, reg, BPF_DIAG_MOD_SPILL);
 	state->stack[spi].spilled_ptr = *reg;
 
 	for (i = BPF_REG_SIZE; i > BPF_REG_SIZE - size; i--)
@@ -3349,6 +3361,8 @@ static void save_register_state(struct bpf_verifier_env *env,
 	/* size < 8 bytes spill */
 	for (; i; i--)
 		mark_stack_slot_misc(env, &state->stack[spi].slot_type[i - 1]);
+
+	bpf_diag_mod_end(env);
 }
 
 static bool is_bpf_st_mem(struct bpf_insn *insn)
@@ -3485,6 +3499,9 @@ static int check_stack_write_fixed_off(struct bpf_verifier_env *env,
 	} else {
 		u8 type = STACK_MISC;
 
+		if (bpf_is_spilled_reg(&state->stack[spi]))
+			bpf_diag_record_scrub(env, &state->stack[spi].spilled_ptr,
+					      BPF_DIAG_MOD_WRITE);
 		scrub_special_slot(state, spi);
 
 		/* when we zero initialize stack slots mark them as such */
@@ -3645,6 +3662,8 @@ static int check_stack_write_var_off(struct bpf_verifier_env *env,
 		if (err)
 			return err;
 	}
+	bpf_diag_record_scrub_stack(env, state->frameno, min_off, max_off,
+				    BPF_DIAG_MOD_VAR_WRITE);
 	return 0;
 }
 
@@ -3737,6 +3756,12 @@ static int check_stack_read_fixed_off(struct bpf_verifier_env *env,
 	mark_stack_slot_scratched(env, spi);
 	check_fastcall_stack_contract(env, state, env->insn_idx, off);
 
+	/*
+	 * Refine the in-progress load record's origin to the source stack slot.
+	 */
+	if (dst_regno >= 0)
+		bpf_diag_mod_begin(env, &state->regs[dst_regno], reg, BPF_DIAG_MOD_WRITE);
+
 	if (bpf_is_spilled_reg(&reg_state->stack[spi])) {
 		u8 spill_size = 1;
 
@@ -4031,14 +4056,17 @@ static int check_stack_arg_write(struct bpf_verifier_env *env, struct bpf_func_s
 	if (spi + 1 > subprog->max_out_stack_arg_cnt)
 		subprog->max_out_stack_arg_cnt = spi + 1;
 
+	arg = &state->stack_arg_regs[spi];
+	bpf_diag_mod_begin(env, arg, value_reg, BPF_DIAG_MOD_WRITE);
+
 	if (value_reg) {
 		state->stack_arg_regs[spi] = *value_reg;
 	} else {
 		/* BPF_ST: store immediate, treat as scalar */
-		arg = &state->stack_arg_regs[spi];
 		arg->type = SCALAR_VALUE;
 		__mark_reg_known(arg, env->prog->insnsi[env->insn_idx].imm);
 	}
+	bpf_diag_mod_end(env);
 	state->no_stack_arg_load = true;
 	return bpf_push_jmp_history(env, env->cur_state,
 				    INSN_F_STACK_ARG_ACCESS, spi, 0, 0);
@@ -4071,7 +4099,9 @@ static int check_stack_arg_read(struct bpf_verifier_env *env, struct bpf_func_st
 	caller = vstate->frame[vstate->curframe - 1];
 	arg = &caller->stack_arg_regs[spi];
 	cur = vstate->frame[vstate->curframe];
+	bpf_diag_mod_begin(env, &cur->regs[dst_regno], arg, BPF_DIAG_MOD_WRITE);
 	cur->regs[dst_regno] = *arg;
+	bpf_diag_mod_end(env);
 	return bpf_push_jmp_history(env, env->cur_state,
 				    INSN_F_STACK_ARG_ACCESS, spi, 0, 0);
 }
@@ -6391,15 +6421,19 @@ static int check_load_mem(struct bpf_verifier_env *env, struct bpf_insn *insn,
 
 	src_reg_type = regs[insn->src_reg].type;
 
-	/* Check if (src_reg + off) is readable. The state of dst_reg will be
-	 * updated by this call.
+	/*
+	 * check_stack_read_fixed_off() may refine the modification's origin to
+	 * the source stack slot.
 	 */
+	bpf_diag_mod_begin(env, &regs[insn->dst_reg], NULL, BPF_DIAG_MOD_WRITE);
 	err = check_mem_access(env, env->insn_idx, regs + insn->src_reg, argno_from_reg(insn->src_reg), insn->off,
 			       BPF_SIZE(insn->code), BPF_READ, insn->dst_reg,
 			       strict_alignment_once, is_ldsx);
 	err = err ?: save_aux_ptr_type(env, src_reg_type,
 				       allow_trust_mismatch);
 	err = err ?: reg_bounds_sanity_check(env, &regs[insn->dst_reg], ctx);
+	if (!err)
+		bpf_diag_mod_end(env);
 
 	return err;
 }
@@ -8902,13 +8936,18 @@ static int check_func_proto(const struct bpf_func_proto *fn, struct bpf_call_arg
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
+				bpf_diag_record_scrub(env, reg, BPF_DIAG_MOD_PKT_DATA_CHANGE);
+				mark_reg_invalid(env, reg);
+			}
+		}))
+		;
 }
 
 enum {
@@ -9012,22 +9051,39 @@ static int release_reference(struct bpf_verifier_env *env, int id)
 			return -EINVAL;
 		}
 
-		bpf_for_each_reg_in_vstate_mask(vstate, state, reg, stack, mask, ({
-			if (reg->id != id && reg->parent_id != id)
-				continue;
+		bpf_for_each_reg_in_vstate_mask(
+			vstate, state, reg, stack, mask, ({
+				if (reg->id != id && reg->parent_id != id)
+					continue;
 
-			/* Free objects derived from the current object */
-			if (reg->parent_id == id) {
-				err = idstack_push(idstack, reg->id);
-				if (err)
-					return err;
-			}
+				/* Free objects derived from the current object */
+				if (reg->parent_id == id) {
+					err = idstack_push(idstack, reg->id);
+					if (err)
+						return err;
+				}
 
-			if (!stack || stack->slot_type[BPF_REG_SIZE - 1] == STACK_SPILL)
-				mark_reg_invalid(env, reg);
-			else if (stack->slot_type[BPF_REG_SIZE - 1] == STACK_DYNPTR)
-				invalidate_dynptr(env, stack);
-		}));
+				/*
+				 * A dynptr occupies two stack slots that invalidate_dynptr()
+				 * clears together. Record both scrubs before invalidating it.
+				 */
+				if (stack && stack->slot_type[BPF_REG_SIZE - 1] == STACK_DYNPTR) {
+					struct bpf_stack_state *dyn_stack = stack;
+
+					if (reg->dynptr.first_slot)
+						dyn_stack--;
+					bpf_diag_record_scrub(env, &dyn_stack[0].spilled_ptr,
+							      BPF_DIAG_MOD_REF_RELEASE);
+					bpf_diag_record_scrub(env, &dyn_stack[1].spilled_ptr,
+							      BPF_DIAG_MOD_REF_RELEASE);
+					invalidate_dynptr(env, dyn_stack);
+					continue;
+				}
+				bpf_diag_record_scrub(env, reg, BPF_DIAG_MOD_REF_RELEASE);
+				if (!stack || stack->slot_type[BPF_REG_SIZE - 1] == STACK_SPILL)
+					mark_reg_invalid(env, reg);
+			}))
+			;
 	}
 
 	return 0;
@@ -9035,13 +9091,18 @@ static int release_reference(struct bpf_verifier_env *env, int id)
 
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
+				bpf_diag_record_scrub(env, reg, BPF_DIAG_MOD_NON_OWN_REF);
+				mark_reg_invalid(env, reg);
+			}
+		}))
+		;
 }
 
 static void invalidate_rcu_protected_refs(struct bpf_verifier_env *env)
@@ -10442,12 +10503,14 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 		return err;
 
 	/* reset caller saved regs */
+	bpf_diag_record_caller_saved(env, regs);
 	for (i = 0; i < CALLER_SAVED_REGS; i++) {
 		bpf_mark_reg_not_init(env, &regs[caller_saved[i]]);
 		check_reg_arg(env, caller_saved[i], DST_OP_NO_MARK);
 	}
 	invalidate_outgoing_stack_args(env, cur_func(env));
 
+	bpf_diag_mod_begin(env, &regs[BPF_REG_0], NULL, BPF_DIAG_MOD_WRITE);
 	/* update return register (already marked as written above) */
 	ret_type = fn->ret_type;
 	ret_flag = type_flag(ret_type);
@@ -10630,6 +10693,8 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 	if (err)
 		return err;
 
+	bpf_diag_mod_end(env);
+
 	err = check_map_func_compatibility(env, meta.map.ptr, func_id);
 	if (err)
 		return err;
@@ -13142,6 +13207,8 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 		}
 	}
 
+	bpf_diag_record_caller_saved(env, regs);
+	bpf_diag_mod_begin(env, &regs[BPF_REG_0], NULL, BPF_DIAG_MOD_WRITE);
 	for (i = 0; i < CALLER_SAVED_REGS; i++) {
 		u32 regno = caller_saved[i];
 
@@ -13293,6 +13360,12 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 			caller_info->stack_arg_cnt = stack_arg_cnt;
 	}
 
+	/*
+	 * Record R0 before process_iter_next_call() snapshots the alternate
+	 * iterator path's diagnostic position.
+	 */
+	bpf_diag_mod_end(env);
+
 	if (bpf_is_iter_next_kfunc(&meta)) {
 		err = process_iter_next_call(env, insn_idx, &meta);
 		if (err)
@@ -14935,6 +15008,8 @@ static int check_alu_op(struct bpf_verifier_env *env, struct bpf_insn *insn)
 	u8 opcode = BPF_OP(insn->code);
 	int err;
 
+	bpf_diag_mod_begin(env, &regs[insn->dst_reg], NULL, BPF_DIAG_MOD_WRITE);
+
 	if (opcode == BPF_END || opcode == BPF_NEG) {
 		/* check src operand */
 		err = check_reg_arg(env, insn->dst_reg, SRC_OP);
@@ -15108,7 +15183,12 @@ static int check_alu_op(struct bpf_verifier_env *env, struct bpf_insn *insn)
 			return err;
 	}
 
-	return reg_bounds_sanity_check(env, &regs[insn->dst_reg], "alu");
+	err = reg_bounds_sanity_check(env, &regs[insn->dst_reg], "alu");
+	if (err)
+		return err;
+
+	bpf_diag_mod_end(env);
+	return 0;
 }
 
 static void find_good_pkt_pointers(struct bpf_verifier_state *vstate,
-- 
2.53.0

