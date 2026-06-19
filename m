Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com [209.85.221.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D9C83CBE71
	for <bpf@vger.kernel.org>; Fri, 19 Jun 2026 20:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781902801; cv=none; b=K2FI/XfqTtxvLtp7kUlfSv7B/ENYdBcTeBgrZZ17R3l7DiR5xYKdelldY9j2tT3v0fw4QYGsnGw02PZOIxUJxdRteISPS6ZmE2C5FQrwxiuBAMDmt6xv/mB5gIG3TxCLrTKHKpYYeWcvWw4+68Sp1i/Ju2/7PTZfRRJ1Qlp7BFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781902801; c=relaxed/simple;
	bh=R75Mnfjh1otcL0p3+KdzeyQfzHk2UDLaVrrbHPDSVjw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m9FGWbBj1p3O54y08WGGinqZZPor8amWCwVsVuh/30aFGsaOQlfcKDpM9aVTe3TlhbHyMyWgZ/tgAfAo7/EUlQoeVuXGa476aXKyqbUy0IQV4olkHuRHHJw9Ky4daFniF1FFjEMAA2lNeyj1zMrZYLIX9dkmbQlBqoMMqWMVCi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nHTp8QIp; arc=none smtp.client-ip=209.85.221.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nHTp8QIp"
Received: by mail-wr1-f65.google.com with SMTP id ffacd0b85a97d-46066e640easo1548651f8f.1
        for <bpf@vger.kernel.org>; Fri, 19 Jun 2026 13:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781902781; x=1782507581; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LIp71AjA05VW4Wn446ajDuACeDiOgW4fO1Ju2CGz3SM=;
        b=nHTp8QIp3xpMZ5CirLQ1/MQTdeRNImxX6jQz4Fp0x/N4HHMT3L9f22oh4AP+kq6E7X
         5roSILnYkjvNdSKnViVNnPWd3NoIqaggYAfSJUhDLzwQ049GXff7m/kCGvVM7J5fIwwv
         OpzDKxtCm1uJk2whct8wz+tvW3qWh0FBXce0/CA4qfrA9+hr00C7pgxE3b8mQkErNzqY
         9tq9lBBNSLzKcPL6uX2YhWtCPiIMSkCf/KiwH5uCDiI/j3izuHch+pUXX66cOwjIN5nJ
         RP4OZWGWAK/5KgJlL71pxYl2F69VrABpgJgF3Y6F0ynRtOYJbw+2ZnTaH8EU9d0+fld5
         E50A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781902781; x=1782507581;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LIp71AjA05VW4Wn446ajDuACeDiOgW4fO1Ju2CGz3SM=;
        b=HcwHEvBSXj82LFA9HNpUOHRX8zyRudF9JAOQLyY5pissk6JfmTdEK+ywf+l3JJ1/cg
         MTN4O+3ARwUGRLAAE1+2Xgi5tzekWd1yZDXSfZRRmX9L7t2sZgtJyYQ/xCQQ09IhxYBv
         OMHCkH2S9yDyIZwIuJtaBGF/MST2XinKRVkHCosb2yqtTJB+KSVLJL9MkS6jpUbn5Euq
         f3XQbG+70w0jaye4CXPJ5i807fzZuRUa/+KkPPIJkm9FDQ50zwIkkmkmX48mQUJclTcX
         Z9pernLT8RGGlDLNGAWZBGsp5cabm7WtbPKrPV19/obLbFbGjO40T5YyLo44RrW7DDLD
         1Kpw==
X-Gm-Message-State: AOJu0YzSm+XmMeERoxJ+ljKYZWqaO19ENdIOOtdoLfm5/9VG3DooAWol
	oN9Ez1DJQBGf4wt8Z/gHZ4CD5dV4hxvg1xFgXroySiG+ht1c+bjAjSUB0Cr2AMiZ
X-Gm-Gg: AfdE7cne/2p2wq+vIvDM5piiUl+LD7MP2RDOHon+Ykto9YpUHUqgyD3B8AkW4l+NNc8
	ZNa7CkiTromqOBIsL7rjBrUTQMEFB8sI79yOph76q9083kXth7gOc1e2+BCUYnYEAwJyzbCXZS3
	IHsllFt6nrqrOVYTv8ul/gOT8ErDYSY5os7xUIaJrwFecZTV85h4O32t2EVykvOF72sUsEBni7q
	aScKs6ZehrfRiUrrKuizk7VTiSWxgHRgiBmXppkAa0CpePKgmMjUi0GVDi+TcXS+6SvjJSD1CgI
	YX+gtjeMcVjiLVfkoQEDj9fonBZMNa/qgnXfDM+/4xWci9+cmcW6JsjwOBfh6FHNO5gRBTgfEoI
	nZxav/mN4fkjV9zsc+xglOT/h7gdMIPHmZjUIMKpXaTAZ6VBxg0PnsCyXHohfKZcsnRJnVG2O3e
	8ZrBgc0omoXMNGxv0MJmjnTRfvA+9+Q4Z0HbzSpERzML++xEaGnZoVUAyg9FgW5/lICl57gDsBI
	uVgkocNliIF9+uyEVRyGMb+Talphvtqw3VdcpjFd43OQepryGcFwGI=
X-Received: by 2002:a05:600d:8496:20b0:490:cf76:dea4 with SMTP id 5b1f17b1804b1-49240e20c6bmr61862395e9.2.1781902781088;
        Fri, 19 Jun 2026 13:59:41 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4923ff8a9e3sm97698885e9.14.2026.06.19.13.59.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2026 13:59:40 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v2 05/17] bpf: Track verifier register diagnostic events
Date: Fri, 19 Jun 2026 22:59:18 +0200
Message-ID: <20260619205934.1312876-6-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260619205934.1312876-1-memxor@gmail.com>
References: <20260619205934.1312876-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=47565; i=memxor@gmail.com; h=from:subject; bh=R75Mnfjh1otcL0p3+KdzeyQfzHk2UDLaVrrbHPDSVjw=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIct05T/DO9e4Xp13OlOsfSA5XXayRODKr85Hbe2KkqJYq xTYOeo6SlkYxLgYZMUUWUr+72MyPlH5O9B2GTfMHFYmkCEMXJwCMBHPGoa/guynzDXvH7eIvnD6 1fUTTPIhMRuefFoT/CY70PiT2DR7c4b/qXUK18459Pwr7GX8f/nWrPYrMdn2Qkl7bN/pZWh6xqg yAAA=
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
 kernel/bpf/diagnostics.c | 766 ++++++++++++++++++++++++++++++++++++++-
 kernel/bpf/diagnostics.h | 113 +++++-
 kernel/bpf/verifier.c    | 269 +++++++++++++-
 3 files changed, 1137 insertions(+), 11 deletions(-)

diff --git a/kernel/bpf/diagnostics.c b/kernel/bpf/diagnostics.c
index fa5a25b314a0..f51b2860c11d 100644
--- a/kernel/bpf/diagnostics.c
+++ b/kernel/bpf/diagnostics.c
@@ -75,11 +75,24 @@ struct bpf_diag_log {
 	u32 cap;
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
 	struct bpf_diag_source source;
 	struct bpf_diag_source_line source_lines[BPF_DIAG_SOURCE_LINE_CNT];
 	struct bpf_diag_insn insns[BPF_DIAG_INSN_CNT];
+	struct bpf_diag_reg_fmt reg_fmt;
 };
 
 struct bpf_diag {
@@ -299,6 +312,47 @@ static void bpf_diag_print_wrapped_text(struct bpf_verifier_env *env,
 					BPF_DIAG_TEXT_INDENT, text);
 }
 
+static void bpf_diag_trim_btf_show_name(char *buf)
+{
+	size_t len = strlen(buf);
+
+	if (len && buf[len - 1] == '{')
+		buf[len - 1] = '\0';
+}
+
+void bpf_diag_format_btf_type(char *buf, size_t size, const struct btf *btf,
+			      u32 type_id)
+{
+	int ret;
+
+	if (!size)
+		return;
+
+	buf[0] = '\0';
+	ret = btf_type_snprintf_show_name(btf, type_id, buf, size);
+	if (ret < 0 || !buf[0]) {
+		scnprintf(buf, size, "BTF type ID %u", type_id);
+		return;
+	}
+
+	bpf_diag_trim_btf_show_name(buf);
+}
+
+const char *bpf_diag_format_btf_type_scratch(struct bpf_verifier_env *env,
+					     unsigned int slot,
+					     const struct btf *btf,
+					     u32 type_id)
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
 static void bpf_diag_vprint_indented(struct bpf_verifier_env *env,
 				     const char *fmt, va_list args)
 {
@@ -795,11 +849,703 @@ void bpf_diag_record_branch(struct bpf_verifier_env *env, u32 insn_idx,
 	bpf_diag_append_history(env, &event);
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
+	snapshot->var_off = reg->var_off;
+	snapshot->r64 = reg->r64;
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
+	       old->var_off.value == new->var_off.value &&
+	       old->var_off.mask == new->var_off.mask &&
+	       old->r64.base == new->r64.base &&
+	       old->r64.size == new->r64.size;
+}
+
+static bool bpf_diag_reg_snapshot_eq(const struct bpf_diag_history_event *event)
+{
+	return bpf_diag_snapshot_eq(&event->reg.old, &event->reg.new);
+}
+
+static void bpf_diag_record_reg_mod_reason(struct bpf_verifier_env *env,
+					   u32 insn_idx, u32 frameno,
+					   u8 dst_reg, bool src_valid,
+					   u8 src_reg, u8 opcode,
+					   bool stack_slot_valid,
+					   u32 stack_frameno,
+					   u16 stack_spi,
+					   enum bpf_diag_reg_mod_reason reason,
+					   const struct bpf_reg_state *old_reg,
+					   const struct bpf_reg_state *new_reg)
+{
+	struct bpf_diag_history_event event = {
+		.insn_idx = insn_idx,
+		.kind = BPF_DIAG_HISTORY_REG_MOD,
+		.reg.frameno = frameno,
+		.reg.dst_reg = dst_reg,
+		.reg.src_reg = src_reg,
+		.reg.opcode = opcode,
+		.reg.src_valid = src_valid,
+		.reg.stack_slot_valid = stack_slot_valid,
+		.reg.stack_frameno = stack_frameno,
+		.reg.stack_spi = stack_spi,
+	};
+
+	bpf_diag_snapshot_reg(&event, reason, old_reg, new_reg);
+	if (reason == BPF_DIAG_REG_MOD_WRITE &&
+	    bpf_diag_reg_snapshot_eq(&event))
+		return;
+
+	bpf_diag_append_history(env, &event);
+}
+
+void bpf_diag_record_reg_mod(struct bpf_verifier_env *env, u32 insn_idx,
+			     u32 frameno, u8 dst_reg, bool src_valid,
+			     u8 src_reg, u8 opcode,
+			     const struct bpf_reg_state *old_reg,
+			     const struct bpf_reg_state *new_reg)
+{
+	bpf_diag_record_reg_mod_reason(env, insn_idx, frameno, dst_reg,
+				       src_valid, src_reg, opcode, false, 0, 0,
+				       BPF_DIAG_REG_MOD_WRITE, old_reg,
+				       new_reg);
+}
+
+void bpf_diag_record_reg_stack_fill(struct bpf_verifier_env *env, u32 insn_idx,
+				    u32 frameno, u8 dst_reg, u32 stack_frameno,
+				    u16 stack_spi, bool src_valid, u8 src_reg,
+				    u8 opcode,
+				    const struct bpf_reg_state *old_reg,
+				    const struct bpf_reg_state *new_reg)
+{
+	bpf_diag_record_reg_mod_reason(env, insn_idx, frameno, dst_reg,
+				       src_valid, src_reg, opcode, true,
+				       stack_frameno, stack_spi,
+				       BPF_DIAG_REG_MOD_WRITE, old_reg,
+				       new_reg);
+}
+
+void bpf_diag_record_reg_invalidate(struct bpf_verifier_env *env, u32 insn_idx,
+				    u32 frameno, u8 dst_reg,
+				    enum bpf_diag_reg_mod_reason reason,
+				    const struct bpf_reg_state *old_reg,
+				    const struct bpf_reg_state *new_reg)
+{
+	bpf_diag_record_reg_mod_reason(env, insn_idx, frameno, dst_reg,
+				       false, 0, 0, false, 0, 0, reason, old_reg,
+				       new_reg);
+}
+
+void bpf_diag_record_stack_arg(struct bpf_verifier_env *env, u32 insn_idx,
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
+	bpf_diag_append_history(env, &event);
+}
+
+void bpf_diag_record_stack_slot(struct bpf_verifier_env *env, u32 insn_idx,
+				u32 frameno, u16 spi,
+				enum bpf_diag_stack_slot_reason reason,
+				const struct bpf_reg_state *old_reg,
+				const struct bpf_reg_state *new_reg)
+{
+	struct bpf_diag_history_event event = {
+		.insn_idx = insn_idx,
+		.kind = BPF_DIAG_HISTORY_STACK_SLOT,
+		.stack_slot.frameno = frameno,
+		.stack_slot.spi = spi,
+		.stack_slot.reason = reason,
+	};
+
+	bpf_diag_snapshot_one_reg(&event.stack_slot.old, old_reg);
+	bpf_diag_snapshot_one_reg(&event.stack_slot.new, new_reg);
+
+	if (reason == BPF_DIAG_STACK_SLOT_SPILL &&
+	    bpf_diag_snapshot_eq(&event.stack_slot.old,
+				 &event.stack_slot.new))
+		return;
+	if (reason == BPF_DIAG_STACK_SLOT_WRITE &&
+	    bpf_diag_snapshot_eq(&event.stack_slot.old,
+				 &event.stack_slot.new))
+		return;
+
+	bpf_diag_append_history(env, &event);
+}
+
+struct bpf_diag_history_filter {
+	const struct bpf_diag_history_opts *opts;
+	bool stack_slot_valid;
+	u32 stack_frameno;
+	u16 stack_spi;
+	u32 stack_until_idx;
+};
+
+static bool bpf_diag_reg_event_matches(const struct bpf_diag_history_event *event,
+				       const struct bpf_diag_history_opts *opts)
+{
+	return opts->scope == BPF_DIAG_HISTORY_SCOPE_REG &&
+	       event->kind == BPF_DIAG_HISTORY_REG_MOD &&
+	       event->reg.dst_reg == opts->regno &&
+	       event->reg.frameno == opts->frameno;
+}
+
+static bool bpf_diag_stack_slot_matches(const struct bpf_diag_history_event *event,
+					const struct bpf_diag_history_filter *filter)
+{
+	return event->kind == BPF_DIAG_HISTORY_STACK_SLOT &&
+	       event->stack_slot.spi == filter->stack_spi &&
+	       event->stack_slot.frameno == filter->stack_frameno;
+}
+
+static bool bpf_diag_reg_event_keeps_lineage(const struct bpf_diag_history_event *event)
+{
+	if (event->reg.reason != BPF_DIAG_REG_MOD_WRITE)
+		return false;
+
+	switch (event->reg.opcode) {
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
+static void bpf_diag_history_follow_reg_stack(const struct bpf_diag_log *log,
+					      struct bpf_diag_history_filter *filter)
+{
+	const struct bpf_diag_history_opts *opts = filter->opts;
+	int i;
+
+	if (!opts || opts->scope != BPF_DIAG_HISTORY_SCOPE_REG)
+		return;
+
+	for (i = log->cnt; i > 0; i--) {
+		const struct bpf_diag_history_event *event;
+
+		event = bpf_diag_history_event(log, i - 1);
+		if (!bpf_diag_reg_event_matches(event, opts))
+			continue;
+
+		if (event->reg.stack_slot_valid) {
+			filter->stack_slot_valid = true;
+			filter->stack_frameno = event->reg.stack_frameno;
+			filter->stack_spi = event->reg.stack_spi;
+			filter->stack_until_idx = i - 1;
+			return;
+		}
+
+		if (!bpf_diag_reg_event_keeps_lineage(event))
+			return;
+	}
+}
+
+static int bpf_diag_history_stack_start_idx(const struct bpf_diag_log *log,
+					    const struct bpf_diag_history_filter *filter)
+{
+	int fallback = filter->stack_until_idx;
+	int i;
+
+	for (i = filter->stack_until_idx + 1; i > 0; i--) {
+		const struct bpf_diag_history_event *event;
+
+		event = bpf_diag_history_event(log, i - 1);
+		if (!bpf_diag_stack_slot_matches(event, filter))
+			continue;
+
+		fallback = i - 1;
+		if (event->stack_slot.reason == BPF_DIAG_STACK_SLOT_SPILL)
+			return fallback;
+	}
+
+	return fallback;
+}
+
+static int bpf_diag_history_start_idx(const struct bpf_diag_log *log,
+				      const struct bpf_diag_history_filter *filter)
+{
+	const struct bpf_diag_history_opts *opts = filter->opts;
+	int i;
+
+	if (!opts || opts->scope == BPF_DIAG_HISTORY_SCOPE_ALL)
+		return 0;
+	if (filter->stack_slot_valid)
+		return bpf_diag_history_stack_start_idx(log, filter);
+
+	for (i = log->cnt; i > 0; i--) {
+		const struct bpf_diag_history_event *event;
+
+		event = bpf_diag_history_event(log, i - 1);
+
+		if (bpf_diag_reg_event_matches(event, opts))
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
+static bool
+bpf_diag_history_event_visible(const struct bpf_diag_history_event *event,
+			       u32 idx,
+			       const struct bpf_diag_history_filter *filter)
+{
+	const struct bpf_diag_history_opts *opts = filter->opts;
+
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
+	case BPF_DIAG_HISTORY_STACK_SLOT:
+		return filter->stack_slot_valid &&
+		       idx <= filter->stack_until_idx &&
+		       bpf_diag_stack_slot_matches(event, filter);
+	default:
+		return false;
+	}
+}
+
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
+static bool bpf_diag_cnum64_unknown(struct cnum64 range)
+{
+	return bpf_diag_range_unknown(cnum64_smin(range), cnum64_smax(range),
+				      cnum64_umin(range), cnum64_umax(range));
+}
+
+static bool bpf_diag_snapshot_unknown(const struct bpf_diag_reg_snapshot *snapshot)
+{
+	return tnum_is_unknown(snapshot->var_off) &&
+	       bpf_diag_cnum64_unknown(snapshot->r64);
+}
+
+static void bpf_diag_format_scalar_range(struct bpf_diag_reg_fmt *fmt,
+					 char *buf, size_t size,
+					 struct cnum64 range)
+{
+	s64 smin = cnum64_smin(range);
+	s64 smax = cnum64_smax(range);
+	u64 umin = cnum64_umin(range);
+	u64 umax = cnum64_umax(range);
+
+	bpf_diag_format_s64_value(fmt->smin_buf, sizeof(fmt->smin_buf), smin);
+	bpf_diag_format_s64_value(fmt->smax_buf, sizeof(fmt->smax_buf), smax);
+	bpf_diag_format_u64_value(fmt->umin_buf, sizeof(fmt->umin_buf), umin);
+	bpf_diag_format_u64_value(fmt->umax_buf, sizeof(fmt->umax_buf), umax);
+
+	scnprintf(buf, size,
+		  "signed range [%s, %s], unsigned range [%s, %s]",
+		  fmt->smin_buf, fmt->smax_buf, fmt->umin_buf, fmt->umax_buf);
+}
+
+static void bpf_diag_format_var_offset(struct bpf_diag_reg_fmt *fmt,
+				       char *buf, size_t size,
+				       const struct bpf_diag_reg_snapshot *snapshot)
+{
+	if (tnum_is_const(snapshot->var_off)) {
+		scnprintf(buf, size, "at offset %lld",
+			  (s64)snapshot->var_off.value);
+		return;
+	}
+
+	if (bpf_diag_snapshot_unknown(snapshot)) {
+		scnprintf(buf, size, "with unknown offset");
+		return;
+	}
+
+	bpf_diag_format_scalar_range(fmt, fmt->range, sizeof(fmt->range),
+				     snapshot->r64);
+	scnprintf(buf, size,
+		  "with variable offset: known bits %#llx, unknown mask %#llx, %s",
+		  snapshot->var_off.value, snapshot->var_off.mask, fmt->range);
+}
+
+static bool bpf_diag_format_snapshot_btf_type(char *buf, size_t size,
+					      const struct bpf_diag_reg_snapshot *snapshot)
+{
+	if (!snapshot->btf || !snapshot->btf_id)
+		return false;
+
+	bpf_diag_format_btf_type(buf, size, snapshot->btf, snapshot->btf_id);
+	return true;
+}
+
+static const char *bpf_diag_reg_map_name(const struct bpf_map *map)
+{
+	if (!map || !map->name[0])
+		return NULL;
+
+	return map->name;
+}
+
+static void bpf_diag_format_reg_snapshot(struct bpf_verifier_env *env,
+					 struct bpf_diag_reg_fmt *fmt,
+					 char *buf, size_t size,
+					 const struct bpf_diag_reg_snapshot *snapshot)
+{
+	const char *type_name = reg_type_str(env, snapshot->type);
+	const char *map_name;
+	bool has_btf_type;
+
+	bpf_diag_format_var_offset(fmt, fmt->offset_desc,
+				   sizeof(fmt->offset_desc), snapshot);
+	has_btf_type = bpf_diag_format_snapshot_btf_type(fmt->btf_type,
+							 sizeof(fmt->btf_type),
+							 snapshot);
+
+	if (snapshot->type == SCALAR_VALUE) {
+		if (tnum_is_const(snapshot->var_off)) {
+			scnprintf(buf, size, "integer scalar value %lld",
+				  (s64)snapshot->var_off.value);
+			return;
+		}
+
+		if (bpf_diag_snapshot_unknown(snapshot)) {
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
+		bpf_diag_format_scalar_range(fmt, fmt->range,
+					     sizeof(fmt->range),
+					     snapshot->r64);
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
+		map_name = bpf_diag_reg_map_name(snapshot->map_ptr);
+		if (map_name) {
+			scnprintf(buf, size, "%s from %s %s",
+				  type_may_be_null(snapshot->type) ?
+				  "nullable map value" : "map value",
+				  map_name, fmt->offset_desc);
+			return;
+		}
+		scnprintf(buf, size, "%s %s",
+			  type_may_be_null(snapshot->type) ?
+			  "nullable map value" : "map value",
+			  fmt->offset_desc);
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
+				  fmt->btf_type);
+		else
+			scnprintf(buf, size, "borrowed allocated object pointer");
+		return;
+	}
+
+	if (type_is_ptr_alloc_obj(snapshot->type)) {
+		if (has_btf_type)
+			scnprintf(buf, size,
+				  "owned allocated object pointer type=%s",
+				  fmt->btf_type);
+		else
+			scnprintf(buf, size, "owned allocated object pointer");
+		return;
+	}
+
+	if (base_type(snapshot->type) == PTR_TO_BTF_ID && has_btf_type) {
+		scnprintf(buf, size, "%s type=%s %s", type_name,
+			  fmt->btf_type, fmt->offset_desc);
+		return;
+	}
+
+	scnprintf(buf, size, "%s %s", type_name, fmt->offset_desc);
+}
+
+static void bpf_diag_print_reg_mod(struct bpf_verifier_env *env,
+				   const struct bpf_diag_history_event *event)
+{
+	struct bpf_diag_scratch *scratch = bpf_diag_scratch(env);
+	struct bpf_diag_reg_fmt *fmt = &scratch->reg_fmt;
+	const char *reason = NULL;
+
+	memset(fmt, 0, sizeof(*fmt));
+
+	bpf_diag_format_reg_snapshot(env, fmt, fmt->old_buf,
+				     sizeof(fmt->old_buf), &event->reg.old);
+	bpf_diag_format_reg_snapshot(env, fmt, fmt->new_buf,
+				     sizeof(fmt->new_buf), &event->reg.new);
+
+	switch (event->reg.reason) {
+	case BPF_DIAG_REG_MOD_REF_RELEASE:
+		reason = "resource release invalidated this pointer";
+		break;
+	case BPF_DIAG_REG_MOD_PKT_DATA_CHANGE:
+		reason = "packet data may have moved";
+		break;
+	case BPF_DIAG_REG_MOD_NON_OWN_REF:
+		reason = "leaving the protected region invalidated this borrowed pointer";
+		break;
+	case BPF_DIAG_REG_MOD_WRITE:
+	default:
+		break;
+	}
+
+	if (reason) {
+		bpf_diag_report_source(env, event->insn_idx, "invalidated",
+				       "R%d: %s; previous value was %s",
+				       event->reg.dst_reg, reason,
+				       fmt->old_buf);
+		return;
+	}
+
+	bpf_diag_report_source(env, event->insn_idx, "update",
+			       "R%d changed from %s to %s",
+			       event->reg.dst_reg, fmt->old_buf, fmt->new_buf);
+}
+
+static int bpf_diag_stack_argno(u8 slot)
+{
+	return MAX_BPF_FUNC_REG_ARGS + slot + 1;
+}
+
+static void bpf_diag_print_stack_arg(struct bpf_verifier_env *env,
+				     const struct bpf_diag_history_event *event)
+{
+	struct bpf_diag_scratch *scratch = bpf_diag_scratch(env);
+	struct bpf_diag_reg_fmt *fmt = &scratch->reg_fmt;
+	const char *reason = NULL;
+	int argno = bpf_diag_stack_argno(event->stack_arg.slot);
+
+	memset(fmt, 0, sizeof(*fmt));
+
+	bpf_diag_format_reg_snapshot(env, fmt, fmt->old_buf,
+				     sizeof(fmt->old_buf),
+				     &event->stack_arg.old);
+	bpf_diag_format_reg_snapshot(env, fmt, fmt->new_buf,
+				     sizeof(fmt->new_buf),
+				     &event->stack_arg.new);
+
+	switch (event->stack_arg.reason) {
+	case BPF_DIAG_STACK_ARG_REF_RELEASE:
+		reason = "resource release invalidated this value";
+		break;
+	case BPF_DIAG_STACK_ARG_PKT_DATA_CHANGE:
+		reason = "packet data may have moved";
+		break;
+	case BPF_DIAG_STACK_ARG_NON_OWN_REF:
+		reason = "leaving the protected region invalidated this borrowed pointer";
+		break;
+	case BPF_DIAG_STACK_ARG_WRITE:
+	default:
+		break;
+	}
+
+	if (reason) {
+		bpf_diag_report_source(env, event->insn_idx, "invalidated",
+				       "stack arg%d: %s; previous value was %s",
+				       argno, reason, fmt->old_buf);
+		return;
+	}
+
+	bpf_diag_report_source(env, event->insn_idx, "update",
+			       "stack arg%d changed from %s to %s",
+			       argno, fmt->old_buf, fmt->new_buf);
+}
+
+static int bpf_diag_stack_slot_off(u16 spi)
+{
+	return -(spi + 1) * BPF_REG_SIZE;
+}
+
+static void bpf_diag_print_stack_slot(struct bpf_verifier_env *env,
+				      const struct bpf_diag_history_event *event)
+{
+	struct bpf_diag_scratch *scratch = bpf_diag_scratch(env);
+	struct bpf_diag_reg_fmt *fmt = &scratch->reg_fmt;
+	const char *reason = NULL;
+	int off = bpf_diag_stack_slot_off(event->stack_slot.spi);
+
+	memset(fmt, 0, sizeof(*fmt));
+
+	bpf_diag_format_reg_snapshot(env, fmt, fmt->old_buf,
+				     sizeof(fmt->old_buf),
+				     &event->stack_slot.old);
+	bpf_diag_format_reg_snapshot(env, fmt, fmt->new_buf,
+				     sizeof(fmt->new_buf),
+				     &event->stack_slot.new);
+
+	switch (event->stack_slot.reason) {
+	case BPF_DIAG_STACK_SLOT_REF_RELEASE:
+		reason = "resource release invalidated this spilled value";
+		break;
+	case BPF_DIAG_STACK_SLOT_PKT_DATA_CHANGE:
+		reason = "packet data may have moved";
+		break;
+	case BPF_DIAG_STACK_SLOT_NON_OWN_REF:
+		reason = "leaving the protected region invalidated this borrowed pointer";
+		break;
+	case BPF_DIAG_STACK_SLOT_WRITE:
+		reason = "a later stack write overwrote this spilled value";
+		break;
+	case BPF_DIAG_STACK_SLOT_SPILL:
+	default:
+		break;
+	}
+
+	if (reason) {
+		bpf_diag_report_source(env, event->insn_idx, "invalidated",
+				       "stack slot fp%d: %s; previous value was %s",
+				       off, reason, fmt->old_buf);
+		return;
+	}
+
+	bpf_diag_report_source(env, event->insn_idx, "spilled",
+			       "stack slot fp%d changed from %s to %s",
+			       off, fmt->old_buf, fmt->new_buf);
+}
+
+void bpf_diag_print_history(struct bpf_verifier_env *env,
+			    const struct bpf_diag_history_opts *opts)
 {
 	const struct bpf_diag_history_event *event;
+	struct bpf_diag_history_filter filter = {
+		.opts = opts,
+	};
 	const struct bpf_diag_log *log;
 	bool printed = false;
+	int start_idx;
 	u32 i;
 
 	bpf_diag_report_section(env, "Causal path");
@@ -810,8 +1556,12 @@ void bpf_diag_print_history(struct bpf_verifier_env *env)
 	}
 	log = &env->diag->log;
 
-	for (i = 0; i < log->cnt; i++) {
+	bpf_diag_history_follow_reg_stack(log, &filter);
+	start_idx = bpf_diag_history_start_idx(log, &filter);
+	for (i = start_idx; i < log->cnt; i++) {
 		event = bpf_diag_history_event(log, i);
+		if (!bpf_diag_history_event_visible(event, i, &filter))
+			continue;
 
 		switch (event->kind) {
 		case BPF_DIAG_HISTORY_BRANCH:
@@ -823,6 +1573,18 @@ void bpf_diag_print_history(struct bpf_verifier_env *env)
 					       "not followed");
 			printed = true;
 			break;
+		case BPF_DIAG_HISTORY_REG_MOD:
+			bpf_diag_print_reg_mod(env, event);
+			printed = true;
+			break;
+		case BPF_DIAG_HISTORY_STACK_ARG:
+			bpf_diag_print_stack_arg(env, event);
+			printed = true;
+			break;
+		case BPF_DIAG_HISTORY_STACK_SLOT:
+			bpf_diag_print_stack_slot(env, event);
+			printed = true;
+			break;
 		default:
 			break;
 		}
diff --git a/kernel/bpf/diagnostics.h b/kernel/bpf/diagnostics.h
index 4bc44be757c4..7af0a694890b 100644
--- a/kernel/bpf/diagnostics.h
+++ b/kernel/bpf/diagnostics.h
@@ -5,9 +5,49 @@
 #define __BPF_DIAGNOSTICS_H
 
 #include <linux/compiler_attributes.h>
+#include <linux/cnum.h>
+#include <linux/tnum.h>
 #include <linux/types.h>
 
+struct bpf_map;
+struct bpf_reg_state;
 struct bpf_verifier_env;
+struct btf;
+struct btf_type;
+
+void bpf_diag_format_btf_type(char *buf, size_t size, const struct btf *btf,
+			      u32 type_id);
+
+struct bpf_diag_reg_snapshot {
+	u32 type;
+	const struct bpf_map *map_ptr;
+	const struct btf *btf;
+	u32 btf_id;
+	struct tnum var_off;
+	struct cnum64 r64;
+};
+
+enum bpf_diag_reg_mod_reason {
+	BPF_DIAG_REG_MOD_WRITE,
+	BPF_DIAG_REG_MOD_REF_RELEASE,
+	BPF_DIAG_REG_MOD_PKT_DATA_CHANGE,
+	BPF_DIAG_REG_MOD_NON_OWN_REF,
+};
+
+enum bpf_diag_stack_arg_reason {
+	BPF_DIAG_STACK_ARG_WRITE,
+	BPF_DIAG_STACK_ARG_REF_RELEASE,
+	BPF_DIAG_STACK_ARG_PKT_DATA_CHANGE,
+	BPF_DIAG_STACK_ARG_NON_OWN_REF,
+};
+
+enum bpf_diag_stack_slot_reason {
+	BPF_DIAG_STACK_SLOT_SPILL,
+	BPF_DIAG_STACK_SLOT_WRITE,
+	BPF_DIAG_STACK_SLOT_REF_RELEASE,
+	BPF_DIAG_STACK_SLOT_PKT_DATA_CHANGE,
+	BPF_DIAG_STACK_SLOT_NON_OWN_REF,
+};
 
 struct bpf_diag_history_event {
 	u32 insn_idx;
@@ -16,11 +56,51 @@ struct bpf_diag_history_event {
 		struct {
 			bool cond_true;
 		} branch;
+		struct {
+			u32 frameno;
+			u8 dst_reg;
+			u8 src_reg;
+			u8 opcode;
+			bool src_valid;
+			bool stack_slot_valid;
+			u8 reason;
+			u32 stack_frameno;
+			u16 stack_spi;
+			struct bpf_diag_reg_snapshot old, new;
+		} reg;
+		struct {
+			u32 frameno;
+			u8 slot;
+			u8 reason;
+			struct bpf_diag_reg_snapshot old, new;
+		} stack_arg;
+		struct {
+			u32 frameno;
+			u16 spi;
+			u8 reason;
+			struct bpf_diag_reg_snapshot old, new;
+		} stack_slot;
 	};
 };
 
 enum bpf_diag_history_kind {
 	BPF_DIAG_HISTORY_BRANCH,
+	BPF_DIAG_HISTORY_REG_MOD,
+	BPF_DIAG_HISTORY_STACK_ARG,
+	BPF_DIAG_HISTORY_STACK_SLOT,
+};
+
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
 };
 
 bool bpf_diag_enabled(const struct bpf_verifier_env *env);
@@ -33,6 +113,10 @@ const char *bpf_diag_scratch_printf(struct bpf_verifier_env *env,
 				    unsigned int slot,
 				    const char *fmt, ...)
 	__printf(3, 4);
+const char *bpf_diag_format_btf_type_scratch(struct bpf_verifier_env *env,
+					     unsigned int slot,
+					     const struct btf *btf,
+					     u32 type_id);
 u64 bpf_diag_event_log_pos(struct bpf_verifier_env *env);
 void bpf_diag_event_log_reset(struct bpf_verifier_env *env, u64 pos);
 void bpf_diag_free(struct bpf_verifier_env *env);
@@ -43,6 +127,33 @@ void bpf_diag_report_source(struct bpf_verifier_env *env, u32 insn_idx,
 	__printf(4, 5);
 void bpf_diag_record_branch(struct bpf_verifier_env *env, u32 insn_idx,
 			    bool cond_true);
-void bpf_diag_print_history(struct bpf_verifier_env *env);
+void bpf_diag_record_reg_mod(struct bpf_verifier_env *env, u32 insn_idx,
+			     u32 frameno, u8 dst_reg, bool src_valid,
+			     u8 src_reg, u8 opcode,
+			     const struct bpf_reg_state *old_reg,
+			     const struct bpf_reg_state *new_reg);
+void bpf_diag_record_reg_stack_fill(struct bpf_verifier_env *env, u32 insn_idx,
+				    u32 frameno, u8 dst_reg, u32 stack_frameno,
+				    u16 stack_spi, bool src_valid, u8 src_reg,
+				    u8 opcode,
+				    const struct bpf_reg_state *old_reg,
+				    const struct bpf_reg_state *new_reg);
+void bpf_diag_record_reg_invalidate(struct bpf_verifier_env *env, u32 insn_idx,
+				    u32 frameno, u8 dst_reg,
+				    enum bpf_diag_reg_mod_reason reason,
+				    const struct bpf_reg_state *old_reg,
+				    const struct bpf_reg_state *new_reg);
+void bpf_diag_record_stack_arg(struct bpf_verifier_env *env, u32 insn_idx,
+			       u32 frameno, u8 slot,
+			       enum bpf_diag_stack_arg_reason reason,
+			       const struct bpf_reg_state *old_reg,
+			       const struct bpf_reg_state *new_reg);
+void bpf_diag_record_stack_slot(struct bpf_verifier_env *env, u32 insn_idx,
+				u32 frameno, u16 spi,
+				enum bpf_diag_stack_slot_reason reason,
+				const struct bpf_reg_state *old_reg,
+				const struct bpf_reg_state *new_reg);
+void bpf_diag_print_history(struct bpf_verifier_env *env,
+			    const struct bpf_diag_history_opts *opts);
 
 #endif /* __BPF_DIAGNOSTICS_H */
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index ca4bba163418..fedabb6bb515 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3406,6 +3406,22 @@ static void assign_scalar_id_before_mov(struct bpf_verifier_env *env,
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
@@ -3485,6 +3501,8 @@ static int check_stack_write_fixed_off(struct bpf_verifier_env *env,
 	struct bpf_reg_state *reg = NULL;
 	int insn_flags = INSN_F_STACK_ACCESS;
 	int hist_spi = spi, hist_frame = state->frameno;
+	struct bpf_reg_state old_spill = state->stack[spi].spilled_ptr;
+	bool old_was_spill = bpf_is_spilled_reg(&state->stack[spi]);
 
 	/* caller checked that off % size == 0 and -MAX_BPF_STACK <= off < 0,
 	 * so it's aligned access and [off, off + size) are within stack limits
@@ -3533,6 +3551,11 @@ static int check_stack_write_fixed_off(struct bpf_verifier_env *env,
 		/* Break the relation on a narrowing spill. */
 		if (!reg_value_fits)
 			state->stack[spi].spilled_ptr.id = 0;
+		if (bpf_is_spilled_reg(&state->stack[spi]))
+			bpf_diag_record_stack_slot(env, insn_idx, state->frameno,
+						   spi, BPF_DIAG_STACK_SLOT_SPILL,
+						   &old_spill,
+						   &state->stack[spi].spilled_ptr);
 	} else if (!reg && !(off % BPF_REG_SIZE) && is_bpf_st_mem(insn) &&
 		   env->bpf_capable) {
 		struct bpf_reg_state *tmp_reg = &env->fake_reg[0];
@@ -3541,6 +3564,11 @@ static int check_stack_write_fixed_off(struct bpf_verifier_env *env,
 		__mark_reg_known(tmp_reg, insn->imm);
 		tmp_reg->type = SCALAR_VALUE;
 		save_register_state(env, state, spi, tmp_reg, size);
+		if (bpf_is_spilled_reg(&state->stack[spi]))
+			bpf_diag_record_stack_slot(env, insn_idx, state->frameno,
+						   spi, BPF_DIAG_STACK_SLOT_SPILL,
+						   &old_spill,
+						   &state->stack[spi].spilled_ptr);
 	} else if (reg && is_spillable_regtype(reg->type)) {
 		/* register containing pointer is being spilled into stack */
 		if (size != BPF_REG_SIZE) {
@@ -3553,6 +3581,11 @@ static int check_stack_write_fixed_off(struct bpf_verifier_env *env,
 			return -EINVAL;
 		}
 		save_register_state(env, state, spi, reg, size);
+		if (bpf_is_spilled_reg(&state->stack[spi]))
+			bpf_diag_record_stack_slot(env, insn_idx, state->frameno,
+						   spi, BPF_DIAG_STACK_SLOT_SPILL,
+						   &old_spill,
+						   &state->stack[spi].spilled_ptr);
 	} else {
 		u8 type = STACK_MISC;
 
@@ -3577,6 +3610,11 @@ static int check_stack_write_fixed_off(struct bpf_verifier_env *env,
 		for (i = 0; i < size; i++)
 			state->stack[spi].slot_type[(slot - i) % BPF_REG_SIZE] = type;
 		insn_flags = 0; /* not a register spill */
+		if (old_was_spill && !bpf_is_spilled_reg(&state->stack[spi]))
+			bpf_diag_record_stack_slot(env, insn_idx, state->frameno,
+						   spi, BPF_DIAG_STACK_SLOT_WRITE,
+						   &old_spill,
+						   &state->stack[spi].spilled_ptr);
 	}
 
 	if (insn_flags)
@@ -4061,6 +4099,8 @@ static int check_stack_arg_write(struct bpf_verifier_env *env, struct bpf_func_s
 	struct bpf_subprog_info *subprog = &env->subprog_info[state->subprogno];
 	int spi = -off / BPF_REG_SIZE - 1;
 	struct bpf_reg_state *arg;
+	struct bpf_reg_state old_arg = {};
+	bool slot_exists;
 	int err;
 
 	if (spi >= max_stack_arg_regs) {
@@ -4069,6 +4109,7 @@ static int check_stack_arg_write(struct bpf_verifier_env *env, struct bpf_func_s
 		return -EINVAL;
 	}
 
+	slot_exists = spi < state->out_stack_arg_cnt;
 	err = grow_stack_arg_slots(env, state, spi + 1);
 	if (err)
 		return err;
@@ -4077,13 +4118,25 @@ static int check_stack_arg_write(struct bpf_verifier_env *env, struct bpf_func_s
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
+		bpf_diag_record_stack_arg(env, env->insn_idx, state->frameno,
+					  spi, BPF_DIAG_STACK_ARG_WRITE,
+					  &old_arg,
+					  &state->stack_arg_regs[spi]);
 	} else {
 		/* BPF_ST: store immediate, treat as scalar */
-		arg = &state->stack_arg_regs[spi];
 		arg->type = SCALAR_VALUE;
 		__mark_reg_known(arg, env->prog->insnsi[env->insn_idx].imm);
+		bpf_diag_record_stack_arg(env, env->insn_idx, state->frameno,
+					  spi, BPF_DIAG_STACK_ARG_WRITE,
+					  &old_arg, arg);
 	}
 	state->no_stack_arg_load = true;
 	return bpf_push_jmp_history(env, env->cur_state,
@@ -6349,6 +6402,32 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, struct b
 static int save_aux_ptr_type(struct bpf_verifier_env *env, enum bpf_reg_type type,
 			     bool allow_trust_mismatch);
 
+static bool bpf_diag_stack_read_origin(struct bpf_verifier_env *env,
+				       const struct bpf_reg_state *reg,
+				       int off, int size,
+				       u32 *frameno, u16 *spi)
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
@@ -6356,15 +6435,32 @@ static int check_load_mem(struct bpf_verifier_env *env, struct bpf_insn *insn,
 	struct bpf_verifier_state *vstate = env->cur_state;
 	struct bpf_func_state *state = vstate->frame[vstate->curframe];
 	struct bpf_reg_state *regs = cur_regs(env);
+	struct bpf_reg_state old_dst = {};
 	enum bpf_reg_type src_reg_type;
+	u32 stack_frameno = 0;
+	u16 stack_spi = 0;
+	bool have_old_dst;
+	bool stack_origin;
+	int size;
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
+			bpf_diag_record_reg_mod(env, env->insn_idx,
+						state->frameno, insn->dst_reg,
+						true, insn->src_reg,
+						BPF_OP(insn->code), &old_dst,
+						&regs[insn->dst_reg]);
+		return err;
 	}
 
 	/* check src operand */
@@ -6385,9 +6481,32 @@ static int check_load_mem(struct bpf_verifier_env *env, struct bpf_insn *insn,
 	err = check_mem_access(env, env->insn_idx, regs + insn->src_reg, argno_from_reg(insn->src_reg), insn->off,
 			       BPF_SIZE(insn->code), BPF_READ, insn->dst_reg,
 			       strict_alignment_once, is_ldsx);
+	size = bpf_size_to_bytes(BPF_SIZE(insn->code));
+	stack_origin = !err &&
+		       bpf_diag_stack_read_origin(env, regs + insn->src_reg,
+						  insn->off, size,
+						  &stack_frameno, &stack_spi);
 	err = err ?: save_aux_ptr_type(env, src_reg_type,
 				       allow_trust_mismatch);
 	err = err ?: reg_bounds_sanity_check(env, &regs[insn->dst_reg], ctx);
+	if (!err && have_old_dst) {
+		if (stack_origin)
+			bpf_diag_record_reg_stack_fill(env, env->insn_idx,
+						       state->frameno,
+						       insn->dst_reg,
+						       stack_frameno,
+						       stack_spi, true,
+						       insn->src_reg,
+						       BPF_OP(insn->code),
+						       &old_dst,
+						       &regs[insn->dst_reg]);
+		else
+			bpf_diag_record_reg_mod(env, env->insn_idx,
+						state->frameno, insn->dst_reg,
+						true, insn->src_reg,
+						BPF_OP(insn->code), &old_dst,
+						&regs[insn->dst_reg]);
+	}
 
 	return err;
 }
@@ -8867,6 +8986,34 @@ static int check_func_proto(const struct bpf_func_proto *fn, struct bpf_call_arg
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
+static int bpf_diag_func_regno(const struct bpf_func_state *state,
+			       const struct bpf_reg_state *reg)
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
 /* Packet data might have moved, any old PTR_TO_PACKET[_META,_END]
  * are now invalid, so turn them into unknown SCALAR_VALUE.
  *
@@ -8875,12 +9022,38 @@ static int check_func_proto(const struct bpf_func_proto *fn, struct bpf_call_arg
  */
 static void clear_all_pkt_pointers(struct bpf_verifier_env *env)
 {
+	struct bpf_stack_state *stack;
 	struct bpf_func_state *state;
 	struct bpf_reg_state *reg;
 
-	bpf_for_each_reg_in_vstate(env->cur_state, state, reg, ({
-		if (reg_is_pkt_pointer_any(reg) || reg_is_dynptr_slice_pkt(reg))
+	bpf_for_each_reg_in_vstate_mask(env->cur_state, state, reg, stack,
+					1 << STACK_SPILL, ({
+		if (reg_is_pkt_pointer_any(reg) || reg_is_dynptr_slice_pkt(reg)) {
+			struct bpf_reg_state old_reg = *reg;
+			int regno = bpf_diag_func_regno(state, reg);
+			int slot = bpf_diag_stack_arg_slot(state, reg);
+			int spi = bpf_diag_stack_slot(state, stack);
+
 			mark_reg_invalid(env, reg);
+			if (regno >= 0)
+				bpf_diag_record_reg_invalidate(env,
+							       env->insn_idx,
+							       state->frameno,
+							       regno,
+							       BPF_DIAG_REG_MOD_PKT_DATA_CHANGE,
+							       &old_reg, reg);
+			if (slot >= 0)
+				bpf_diag_record_stack_arg(env, env->insn_idx,
+							  state->frameno,
+							  slot,
+							  BPF_DIAG_STACK_ARG_PKT_DATA_CHANGE,
+							  &old_reg, reg);
+			if (spi >= 0)
+				bpf_diag_record_stack_slot(env, env->insn_idx,
+							   state->frameno, spi,
+							   BPF_DIAG_STACK_SLOT_PKT_DATA_CHANGE,
+							   &old_reg, reg);
+		}
 	}));
 }
 
@@ -8986,6 +9159,11 @@ static int release_reference(struct bpf_verifier_env *env, int id)
 		}
 
 		bpf_for_each_reg_in_vstate_mask(vstate, state, reg, stack, mask, ({
+			struct bpf_reg_state old_reg;
+			int regno;
+			int slot;
+			int spi;
+
 			if (reg->id != id && reg->parent_id != id)
 				continue;
 
@@ -8996,10 +9174,31 @@ static int release_reference(struct bpf_verifier_env *env, int id)
 					return err;
 			}
 
+			old_reg = *reg;
+			regno = bpf_diag_func_regno(state, reg);
+			slot = bpf_diag_stack_arg_slot(state, reg);
+			spi = bpf_diag_stack_slot(state, stack);
 			if (!stack || stack->slot_type[BPF_REG_SIZE - 1] == STACK_SPILL)
 				mark_reg_invalid(env, reg);
 			else if (stack->slot_type[BPF_REG_SIZE - 1] == STACK_DYNPTR)
 				invalidate_dynptr(env, stack);
+			if (regno >= 0)
+				bpf_diag_record_reg_invalidate(env,
+							       env->insn_idx,
+							       state->frameno,
+							       regno,
+							       BPF_DIAG_REG_MOD_REF_RELEASE,
+							       &old_reg, reg);
+			if (slot >= 0)
+				bpf_diag_record_stack_arg(env, env->insn_idx,
+							  state->frameno, slot,
+							  BPF_DIAG_STACK_ARG_REF_RELEASE,
+							  &old_reg, reg);
+			if (spi >= 0)
+				bpf_diag_record_stack_slot(env, env->insn_idx,
+							   state->frameno, spi,
+							   BPF_DIAG_STACK_SLOT_REF_RELEASE,
+							   &old_reg, reg);
 		}));
 	}
 
@@ -9008,12 +9207,37 @@ static int release_reference(struct bpf_verifier_env *env, int id)
 
 static void invalidate_non_owning_refs(struct bpf_verifier_env *env)
 {
-	struct bpf_func_state *unused;
+	struct bpf_stack_state *stack;
+	struct bpf_func_state *state;
 	struct bpf_reg_state *reg;
 
-	bpf_for_each_reg_in_vstate(env->cur_state, unused, reg, ({
-		if (type_is_non_owning_ref(reg->type))
+	bpf_for_each_reg_in_vstate_mask(env->cur_state, state, reg, stack,
+					1 << STACK_SPILL, ({
+		if (type_is_non_owning_ref(reg->type)) {
+			struct bpf_reg_state old_reg = *reg;
+			int regno = bpf_diag_func_regno(state, reg);
+			int slot = bpf_diag_stack_arg_slot(state, reg);
+			int spi = bpf_diag_stack_slot(state, stack);
+
 			mark_reg_invalid(env, reg);
+			if (regno >= 0)
+				bpf_diag_record_reg_invalidate(env,
+							       env->insn_idx,
+							       state->frameno,
+							       regno,
+							       BPF_DIAG_REG_MOD_NON_OWN_REF,
+							       &old_reg, reg);
+			if (slot >= 0)
+				bpf_diag_record_stack_arg(env, env->insn_idx,
+							  state->frameno, slot,
+							  BPF_DIAG_STACK_ARG_NON_OWN_REF,
+							  &old_reg, reg);
+			if (spi >= 0)
+				bpf_diag_record_stack_slot(env, env->insn_idx,
+							   state->frameno, spi,
+							   BPF_DIAG_STACK_SLOT_NON_OWN_REF,
+							   &old_reg, reg);
+		}
 	}));
 }
 
@@ -10179,6 +10403,7 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 	const struct bpf_func_proto *fn = NULL;
 	enum bpf_return_type ret_type;
 	enum bpf_type_flag ret_flag;
+	struct bpf_reg_state old_r0;
 	struct bpf_reg_state *regs;
 	struct bpf_call_arg_meta meta;
 	int insn_idx = *insn_idx_p;
@@ -10253,6 +10478,7 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 		return err;
 
 	regs = cur_regs(env);
+	old_r0 = regs[BPF_REG_0];
 
 	/* Mark slots with STACK_MISC in case of raw mode, stack offset
 	 * is inferred from register state.
@@ -10603,6 +10829,10 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 	if (err)
 		return err;
 
+	bpf_diag_record_reg_mod(env, insn_idx, env->cur_state->curframe,
+				BPF_REG_0, false, 0, 0, &old_r0,
+				&regs[BPF_REG_0]);
+
 	err = check_map_func_compatibility(env, meta.map.ptr, func_id);
 	if (err)
 		return err;
@@ -12918,6 +13148,7 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 	const struct btf_type *t, *ptr_type;
 	struct bpf_kfunc_call_arg_meta meta;
 	struct bpf_insn_aux_data *insn_aux;
+	struct bpf_reg_state old_r0;
 	int err, insn_idx = *insn_idx_p;
 	const struct btf_param *args;
 	u32 i, nargs, ptr_type_id;
@@ -13114,6 +13345,7 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 		}
 	}
 
+	old_r0 = regs[BPF_REG_0];
 	for (i = 0; i < CALLER_SAVED_REGS; i++) {
 		u32 regno = caller_saved[i];
 
@@ -13282,6 +13514,10 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 			return err;
 	}
 
+	bpf_diag_record_reg_mod(env, insn_idx, env->cur_state->curframe,
+				BPF_REG_0, false, 0, 0, &old_r0,
+				&regs[BPF_REG_0]);
+
 	if (meta.func_id == special_kfunc_list[KF_bpf_session_cookie])
 		env->prog->call_session_cookie = true;
 
@@ -14915,10 +15151,17 @@ static int adjust_reg_min_max_vals(struct bpf_verifier_env *env,
 /* check validity of 32-bit and 64-bit arithmetic operations */
 static int check_alu_op(struct bpf_verifier_env *env, struct bpf_insn *insn)
 {
+	struct bpf_func_state *state = cur_func(env);
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
@@ -15099,7 +15342,17 @@ static int check_alu_op(struct bpf_verifier_env *env, struct bpf_insn *insn)
 			return err;
 	}
 
-	return reg_bounds_sanity_check(env, &regs[insn->dst_reg], "alu");
+	err = reg_bounds_sanity_check(env, &regs[insn->dst_reg], "alu");
+	if (err)
+		return err;
+
+	if (have_old_dst)
+		bpf_diag_record_reg_mod(env, env->insn_idx, state->frameno,
+					insn->dst_reg,
+					BPF_SRC(insn->code) == BPF_X,
+					insn->src_reg, opcode, &old_dst,
+					&regs[insn->dst_reg]);
+	return 0;
 }
 
 static void find_good_pkt_pointers(struct bpf_verifier_state *vstate,
-- 
2.53.0

