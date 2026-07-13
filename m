Received: from mail-wm2-f9.google.com (mail-wm2-f9.google.com [74.125.225.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF8DD35202C
	for <bpf@vger.kernel.org>; Mon, 13 Jul 2026 15:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783957165; cv=none; b=kyONUxOZKEghzgDNLwBysK2BARADbktl9FftbQ+pGc159qgyKq5YkT/KVY44OTjU2pcFmTOyGYjyJOYipzyh6ljkm1lOx4IvgMj0ZRO2tYKJ6vdnZ8ozG83ev/HuyybxdB/wkzcEDQ3U1SSKG6VlEk/k+AyKcdXFpi1Z6rElT+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783957165; c=relaxed/simple;
	bh=sWTvrZ/KTTwcNJ4GhqNkRYkHVMY6R20jUAk4VMcMAPM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hyaVNQF0/NtP3HGo+kE4TxCgqHeBNXEp2o2gEA0DYzIrsp/sYuL5Egronct2SxlZ26p9OCGwngcsocavHSzTnJXcfVsQNUAbtRY5uOS+u7nO2raUYmlNCwNPPB7ZPRX/Vm4OWfQIosTOScQWF3fWAoAxvuI++jyg/HPkCvhXKQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BOA8d91O; arc=none smtp.client-ip=74.125.225.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BOA8d91O"
Received: by mail-wm2-f9.google.com with SMTP id 5b1f17b1804b1-493e55619a2so9306165e9.1
        for <bpf@vger.kernel.org>; Mon, 13 Jul 2026 08:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783957161; x=1784561961; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5YR/ByXJdSeBU7frM8SnyEWpyCSe5oLjHymZ3pePVcs=;
        b=BOA8d91ONWoazIiLp4jZk5Sr9XyGtk5v6xVOYxf6Tlf4O9IN4OrNcIR8cqPB8KeBJM
         BHULfS7E6mIc8ECe056HrjG76y2aCmlWCccUGUsaw7j/uX12eHhTjfqq66isS0H2sZdW
         K9jVXAOZ7VzZzahyGlwi1Wk6vhk0bNNa+AYPAtF7+h2GgpFCF4x/AmMnMjN6OduoFNq0
         yXFlHzVai2cSfbGoxkTmAqI+8t9QCASjqWim0PyCI1opV0A+ZrKrxl4Zia98Nmtndbin
         kBegwKCJ05UiemTJ+dUtNVHZg65mFS8K/gWNlT2HA8JUuCedY+SbkmJa9LM4bLL0ASxs
         mvZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783957161; x=1784561961;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=5YR/ByXJdSeBU7frM8SnyEWpyCSe5oLjHymZ3pePVcs=;
        b=e+8llZmWZME1mr6DCGLtlYEcHb1P09CMYuaFVVK8M13EFywssj64kd5ZHblFRjfb67
         VV3vjRx9auyoKhdkxsBH6CKf9gH7HeUjL+G24Ky2e4yv/GOXgLHxN/8JhbtCyv0IFqN4
         boJCOCR9+2grBre4gbvi5U2HOTewnf5ssYm3QfYWGu7rYhhABOi0XC23KbqYHTTEIRDz
         cECh/f5b6RA1Cz0foQd/i5ntpZ1oaXu7QJgyHnfbVpd37Z2VhVx1nY5P6UGVAAxQ4JdN
         Gbmx/Kw2u//jscIUgwCjCZNU4NGTMgHw/Q3a/2vMbV5NDUosTRxXA6JRP22XeEciE0x8
         KUxw==
X-Gm-Message-State: AOJu0YzpDgF9UaoRDOA8bJFNcTpbclRIb+dS/tm9cJs2dCYLOVlGxAcp
	+z2febbl/4veF8VQ4LmQxHRp+OWqkFnGAdFJo+loB4snrM5ec1acQZavmZ1rhYZX
X-Gm-Gg: AfdE7ckbjC5XxiyOPAmTclcejMCpTPZ9Fhd33H0A4AjVw/V2CaKP42JuwtdWX2gaB1P
	7Xjb6zOcghiGdQi9eXyL1DQmpxMVfNQ83QnU+yVjxvbs9M59Wt5HIqcp0ehAz/GIJ+jBQxkOQx9
	G3IAbrCurZxXNBX2RJo6iISghEsb9J0R0zSMcFof6lWdg3Imi5bPVD5e0k9bBCtBXEn96/iOzwJ
	V7Tycel58R1KWxXTRy8IfWbGSR6e5q9LF4MSM4gjoxTMV5Au9EwZ/BR4RvmQXEgHfUi1nwHfqBg
	6D9XRuG4zdPHuO3Nwc6xOj1tMGWiwCjyah5pQo/lNVX4upiBhXgno7zFY5kPHYCsKxjF9KnGELa
	wR3PmG1w/COAE45CRK5lFVYFQwulue+i71QzeekqbqaYUsqkCQX5QUBiaIGwj7Aoe2s7Lme7WBG
	0vN3atCT7PVPayCLh5NQ3Q2jNUxfAFN5iZYbE/oGyudc4ywDseX+Ii02Dldh7mRHYSJO08NwBeC
	kC+zSEEtYXvR/PwPPNmDuUrUtBP7J8b8iyXjXF5R4EijvsV5azuX1o=
X-Received: by 2002:a05:600c:4e09:b0:493:c76a:2363 with SMTP id 5b1f17b1804b1-493f87d9879mr97721815e9.6.1783957161073;
        Mon, 13 Jul 2026 08:39:21 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493fd3ccfd4sm127311395e9.2.2026.07.13.08.39.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 08:39:20 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v3 07/17] bpf: Track verifier context diagnostic events
Date: Mon, 13 Jul 2026 17:38:56 +0200
Message-ID: <20260713153910.2556007-8-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260713153910.2556007-1-memxor@gmail.com>
References: <20260713153910.2556007-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=13527; i=memxor@gmail.com; h=from:subject; bh=sWTvrZ/KTTwcNJ4GhqNkRYkHVMY6R20jUAk4VMcMAPM=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JISuURV6nLlr40Q2X7T9a1rRd+vrC16/kaPqiBZGLZBXMH 6hdSanoKGVhEONikBVTZCn5v4/J+ETl70DbZdwwc1iZQIYwcHEKwERCzzD8L5x/ZHfVtmsh0yy+ aYeGHLFZ0T1LctXm2qxFlpaiG+OVjzMy7ApyF3/Tud6gQb/+yg61IzUZW7TuyO/bEmherrqja8Y nRgA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Record verifier context transitions in the diagnostic history so later reports
can anchor causal paths to the critical section that made an operation invalid.

This covers lock, IRQ, RCU, and preempt regions without adding any new
verifier error reports. Category-specific commits decide where those recorded
events should be rendered.

Use context depth when selecting scoped history so nested regions anchor at the
outer active region, and fall back to the earliest retained event when the
matching entry was pruned.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/diagnostics.c | 106 ++++++++++++++++++++++++++++++++++++++-
 kernel/bpf/diagnostics.h |  18 +++++++
 kernel/bpf/verifier.c    |  31 +++++++++---
 3 files changed, 148 insertions(+), 7 deletions(-)

diff --git a/kernel/bpf/diagnostics.c b/kernel/bpf/diagnostics.c
index 4c1fbabf98d1..bd06974efd7b 100644
--- a/kernel/bpf/diagnostics.c
+++ b/kernel/bpf/diagnostics.c
@@ -52,6 +52,7 @@ enum bpf_diag_history_kind {
 	BPF_DIAG_HISTORY_MOD,
 	BPF_DIAG_HISTORY_REF_ACQUIRE,
 	BPF_DIAG_HISTORY_REF_RELEASE,
+	BPF_DIAG_HISTORY_CONTEXT,
 };
 
 struct bpf_diag_event_hdr {
@@ -81,6 +82,12 @@ struct bpf_diag_history_event {
 			struct bpf_diag_event_hdr hdr;
 			u32 ref_id;
 		} ref;
+		struct {
+			struct bpf_diag_event_hdr hdr;
+			u32 depth;
+			u8 kind;
+			bool enter;
+		} ctx;
 	};
 };
 
@@ -89,6 +96,7 @@ enum bpf_diag_history_scope {
 	BPF_DIAG_HISTORY_SCOPE_REG,
 	BPF_DIAG_HISTORY_SCOPE_STACK_ARG,
 	BPF_DIAG_HISTORY_SCOPE_REF,
+	BPF_DIAG_HISTORY_SCOPE_CONTEXT,
 };
 
 struct bpf_diag_history_opts {
@@ -97,6 +105,8 @@ struct bpf_diag_history_opts {
 	int regno;
 	int stack_arg_slot;
 	u32 ref_id;
+	enum bpf_diag_context_kind ctx_kind;
+	u32 ctx_depth;
 };
 
 static void diag_print_history(struct bpf_verifier_env *env,
@@ -288,6 +298,19 @@ void bpf_diag_event_log_reset(struct bpf_verifier_env *env, u32 pos)
 	log->cnt = pos;
 }
 
+u32 bpf_diag_irq_depth(const struct bpf_verifier_state *state)
+{
+	u32 depth = 0;
+	int i;
+
+	for (i = 0; i < state->acquired_refs; i++) {
+		if (state->refs[i].type == REF_TYPE_IRQ)
+			depth++;
+	}
+
+	return depth;
+}
+
 void bpf_diag_free(struct bpf_verifier_env *env)
 {
 	struct bpf_diag *diag = env->diag;
@@ -956,6 +979,54 @@ void bpf_diag_record_ref_release(struct bpf_verifier_env *env, u32 insn_idx, u32
 	diag_record_ref(env, insn_idx, BPF_DIAG_HISTORY_REF_RELEASE, ref_id);
 }
 
+void bpf_diag_record_context(struct bpf_verifier_env *env, u32 insn_idx,
+			     enum bpf_diag_context_event_kind ctx_kind, bool enter, u32 depth)
+{
+	/*
+	 * Keep leave events so context rendering can stop at a depth-zero exit
+	 * and show nested-region depth accurately for the active path.
+	 */
+	struct bpf_diag_history_event event = {
+		.ctx = {
+			.hdr = {
+				.insn_idx = insn_idx,
+				.kind = BPF_DIAG_HISTORY_CONTEXT,
+			},
+			.kind = ctx_kind,
+			.enter = enter,
+			.depth = depth,
+		},
+	};
+
+	diag_append_history(env, &event);
+}
+
+static int diag_history_context_start_idx(const struct bpf_diag_log *log,
+					  const struct bpf_diag_history_opts *opts)
+{
+	int i;
+
+	if (!opts->ctx_depth)
+		return 0;
+
+	/* Find the most recent outermost entry, or a depth-zero exit. */
+	for (i = log->cnt; i > 0; i--) {
+		const struct bpf_diag_history_event *event;
+
+		event = diag_history_event(log, i - 1);
+
+		if (event->kind != BPF_DIAG_HISTORY_CONTEXT || event->ctx.kind != opts->ctx_kind)
+			continue;
+
+		if (event->ctx.enter && event->ctx.depth == 1)
+			return i - 1;
+		if (!event->ctx.enter && event->ctx.depth == 0)
+			return 0;
+	}
+
+	return 0;
+}
+
 struct bpf_diag_history_filter {
 	const struct bpf_diag_history_opts *opts;
 	unsigned long *lineage;
@@ -1111,6 +1182,8 @@ static int diag_history_start_idx(const struct bpf_diag_log *log,
 
 	if (!opts || opts->scope == BPF_DIAG_HISTORY_SCOPE_ALL)
 		return 0;
+	if (opts->scope == BPF_DIAG_HISTORY_SCOPE_CONTEXT)
+		return diag_history_context_start_idx(log, opts);
 	if (filter->lineage_valid)
 		return filter->lineage_start;
 	if (opts->scope != BPF_DIAG_HISTORY_SCOPE_REF)
@@ -1134,7 +1207,7 @@ static bool diag_history_event_visible(const struct bpf_diag_history_event *even
 	const struct bpf_diag_history_opts *opts = filter->opts;
 
 	if (!opts || opts->scope == BPF_DIAG_HISTORY_SCOPE_ALL)
-		return true;
+		return event->kind != BPF_DIAG_HISTORY_CONTEXT;
 
 	switch (event->kind) {
 	case BPF_DIAG_HISTORY_BRANCH:
@@ -1145,6 +1218,9 @@ static bool diag_history_event_visible(const struct bpf_diag_history_event *even
 	case BPF_DIAG_HISTORY_REF_RELEASE:
 		return opts->scope == BPF_DIAG_HISTORY_SCOPE_REF &&
 		       event->ref.ref_id == opts->ref_id;
+	case BPF_DIAG_HISTORY_CONTEXT:
+		return opts->scope == BPF_DIAG_HISTORY_SCOPE_CONTEXT &&
+		       event->ctx.kind == opts->ctx_kind;
 	default:
 		return false;
 	}
@@ -1442,6 +1518,31 @@ static void diag_print_ref_event(struct bpf_verifier_env *env,
 			       event->ref.ref_id);
 }
 
+static const char *diag_context_name(enum bpf_diag_context_kind kind)
+{
+	switch (kind) {
+	case BPF_DIAG_CONTEXT_RCU:
+		return "RCU read lock region";
+	case BPF_DIAG_CONTEXT_PREEMPT:
+		return "non-preemptible region";
+	case BPF_DIAG_CONTEXT_IRQ:
+		return "IRQ-disabled region";
+	case BPF_DIAG_CONTEXT_LOCK:
+		return "lock region";
+	case BPF_DIAG_CONTEXT_NONE:
+	default:
+		return "context";
+	}
+}
+
+static void diag_print_context_event(struct bpf_verifier_env *env,
+				     const struct bpf_diag_history_event *event)
+{
+	bpf_diag_report_source(env, event->insn_idx, "context", "%s %s; depth is now %u",
+			       event->ctx.enter ? "entered" : "left",
+			       diag_context_name(event->ctx.kind), event->ctx.depth);
+}
+
 static void diag_print_history(struct bpf_verifier_env *env,
 			       const struct bpf_diag_history_opts *opts)
 {
@@ -1505,6 +1606,9 @@ static void diag_print_history(struct bpf_verifier_env *env,
 		case BPF_DIAG_HISTORY_REF_RELEASE:
 			diag_print_ref_event(env, event);
 			break;
+		case BPF_DIAG_HISTORY_CONTEXT:
+			diag_print_context_event(env, event);
+			break;
 		default:
 			break;
 		}
diff --git a/kernel/bpf/diagnostics.h b/kernel/bpf/diagnostics.h
index 13b6f5c8f8da..931d880b7eda 100644
--- a/kernel/bpf/diagnostics.h
+++ b/kernel/bpf/diagnostics.h
@@ -9,6 +9,7 @@
 
 struct bpf_reg_state;
 struct bpf_verifier_env;
+struct bpf_verifier_state;
 struct btf;
 
 void bpf_diag_format_btf_type(char *buf, size_t size, const struct btf *btf, u32 type_id);
@@ -83,6 +84,20 @@ static inline struct bpf_diag_mod_target bpf_diag_stack_range_target(u32 frameno
 	};
 }
 
+enum bpf_diag_context_kind {
+	BPF_DIAG_CONTEXT_NONE,
+	BPF_DIAG_CONTEXT_RCU,
+	BPF_DIAG_CONTEXT_PREEMPT,
+	BPF_DIAG_CONTEXT_IRQ,
+	BPF_DIAG_CONTEXT_LOCK,
+};
+
+enum bpf_diag_context_event_kind {
+	BPF_DIAG_CONTEXT_EVENT_RCU = BPF_DIAG_CONTEXT_RCU,
+	BPF_DIAG_CONTEXT_EVENT_PREEMPT = BPF_DIAG_CONTEXT_PREEMPT,
+	BPF_DIAG_CONTEXT_EVENT_IRQ = BPF_DIAG_CONTEXT_IRQ,
+	BPF_DIAG_CONTEXT_EVENT_LOCK = BPF_DIAG_CONTEXT_LOCK,
+};
 bool bpf_diag_enabled(const struct bpf_verifier_env *env);
 int bpf_diag_init(struct bpf_verifier_env *env);
 char *bpf_diag_scratch_buf(struct bpf_verifier_env *env, unsigned int slot, size_t *size);
@@ -96,6 +111,7 @@ const char *bpf_diag_format_btf_type_scratch(struct bpf_verifier_env *env, unsig
 u32 bpf_diag_event_log_pos(struct bpf_verifier_env *env);
 void bpf_diag_event_log_reset(struct bpf_verifier_env *env, u32 pos);
 int bpf_diag_error(const struct bpf_verifier_env *env);
+u32 bpf_diag_irq_depth(const struct bpf_verifier_state *state);
 void bpf_diag_free(struct bpf_verifier_env *env);
 void bpf_diag_report_header(struct bpf_verifier_env *env, const char *category,
 			    const char *problem);
@@ -108,5 +124,7 @@ void bpf_diag_record_mod(struct bpf_verifier_env *env, u32 insn_idx,
 			 const struct bpf_diag_mod_target *origin);
 void bpf_diag_record_ref_acquire(struct bpf_verifier_env *env, u32 insn_idx, u32 ref_id);
 void bpf_diag_record_ref_release(struct bpf_verifier_env *env, u32 insn_idx, u32 ref_id);
+void bpf_diag_record_context(struct bpf_verifier_env *env, u32 insn_idx,
+			     enum bpf_diag_context_event_kind ctx_kind, bool enter, u32 depth);
 
 #endif /* __BPF_DIAGNOSTICS_H */
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 24bbeee3396e..4cc4f1cc01c0 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -1069,7 +1069,7 @@ static int is_iter_reg_valid_init(struct bpf_verifier_env *env, struct bpf_reg_s
 }
 
 static int acquire_irq_state(struct bpf_verifier_env *env, int insn_idx);
-static int release_irq_state(struct bpf_verifier_state *state, int id);
+static int release_irq_state(struct bpf_verifier_env *env, int id);
 
 static int mark_stack_slot_irq_flag(struct bpf_verifier_env *env,
 				     struct bpf_kfunc_call_arg_meta *meta,
@@ -1128,7 +1128,7 @@ static int unmark_stack_slot_irq_flag(struct bpf_verifier_env *env, struct bpf_r
 		return -EINVAL;
 	}
 
-	err = release_irq_state(env->cur_state, st->id);
+	err = release_irq_state(env, st->id);
 	WARN_ON_ONCE(err && err != -EACCES);
 	if (err) {
 		int insn_idx = 0;
@@ -1463,6 +1463,8 @@ static int acquire_lock_state(struct bpf_verifier_env *env, int insn_idx, enum r
 	state->active_locks++;
 	state->active_lock_id = id;
 	state->active_lock_ptr = ptr;
+	bpf_diag_record_context(env, insn_idx, BPF_DIAG_CONTEXT_EVENT_LOCK, true,
+				state->active_locks);
 	return 0;
 }
 
@@ -1478,6 +1480,8 @@ static int acquire_irq_state(struct bpf_verifier_env *env, int insn_idx)
 	s->id = ++env->id_gen;
 
 	state->active_irq_id = s->id;
+	bpf_diag_record_context(env, insn_idx, BPF_DIAG_CONTEXT_EVENT_IRQ, true,
+				bpf_diag_irq_depth(state));
 	return s->id;
 }
 
@@ -1519,8 +1523,9 @@ static bool reg_is_referenced(struct bpf_verifier_env *env, const struct bpf_reg
 	return find_reference_state(env->cur_state, reg->id);
 }
 
-static int release_lock_state(struct bpf_verifier_state *state, int type, int id, void *ptr)
+static int release_lock_state(struct bpf_verifier_env *env, int type, int id, void *ptr)
 {
+	struct bpf_verifier_state *state = env->cur_state;
 	void *prev_ptr = NULL;
 	u32 prev_id = 0;
 	int i;
@@ -1533,6 +1538,8 @@ static int release_lock_state(struct bpf_verifier_state *state, int type, int id
 			/* Reassign active lock (id, ptr). */
 			state->active_lock_id = prev_id;
 			state->active_lock_ptr = prev_ptr;
+			bpf_diag_record_context(env, env->insn_idx, BPF_DIAG_CONTEXT_EVENT_LOCK,
+						false, state->active_locks);
 			return 0;
 		}
 		if (state->refs[i].type & REF_TYPE_LOCK_MASK) {
@@ -1543,8 +1550,9 @@ static int release_lock_state(struct bpf_verifier_state *state, int type, int id
 	return -EINVAL;
 }
 
-static int release_irq_state(struct bpf_verifier_state *state, int id)
+static int release_irq_state(struct bpf_verifier_env *env, int id)
 {
+	struct bpf_verifier_state *state = env->cur_state;
 	u32 prev_id = 0;
 	int i;
 
@@ -1557,6 +1565,8 @@ static int release_irq_state(struct bpf_verifier_state *state, int id)
 		if (state->refs[i].id == id) {
 			release_reference_state(state, i);
 			state->active_irq_id = prev_id;
+			bpf_diag_record_context(env, env->insn_idx, BPF_DIAG_CONTEXT_EVENT_IRQ,
+						false, bpf_diag_irq_depth(state));
 			return 0;
 		} else {
 			prev_id = state->refs[i].id;
@@ -7345,7 +7355,7 @@ static int process_spin_lock(struct bpf_verifier_env *env, struct bpf_reg_state
 			verbose(env, "%s_unlock cannot be out of order\n", lock_str);
 			return -EINVAL;
 		}
-		if (release_lock_state(cur, type, reg->id, ptr)) {
+		if (release_lock_state(env, type, reg->id, ptr)) {
 			verbose(env, "%s_unlock of different lock\n", lock_str);
 			return -EINVAL;
 		}
@@ -13466,21 +13476,30 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 
 	if (rcu_lock) {
 		env->cur_state->active_rcu_locks++;
+		bpf_diag_record_context(env, insn_idx, BPF_DIAG_CONTEXT_EVENT_RCU, true,
+					env->cur_state->active_rcu_locks);
 	} else if (rcu_unlock) {
 		if (env->cur_state->active_rcu_locks == 0) {
 			verbose(env, "unmatched rcu read unlock (kernel function %s)\n", func_name);
 			return -EINVAL;
 		}
-		if (--env->cur_state->active_rcu_locks == 0)
+		env->cur_state->active_rcu_locks--;
+		bpf_diag_record_context(env, insn_idx, BPF_DIAG_CONTEXT_EVENT_RCU, false,
+					env->cur_state->active_rcu_locks);
+		if (env->cur_state->active_rcu_locks == 0)
 			invalidate_rcu_protected_refs(env);
 	} else if (preempt_disable) {
 		env->cur_state->active_preempt_locks++;
+		bpf_diag_record_context(env, insn_idx, BPF_DIAG_CONTEXT_EVENT_PREEMPT, true,
+					env->cur_state->active_preempt_locks);
 	} else if (preempt_enable) {
 		if (env->cur_state->active_preempt_locks == 0) {
 			verbose(env, "unmatched attempt to enable preemption (kernel function %s)\n", func_name);
 			return -EINVAL;
 		}
 		env->cur_state->active_preempt_locks--;
+		bpf_diag_record_context(env, insn_idx, BPF_DIAG_CONTEXT_EVENT_PREEMPT, false,
+					env->cur_state->active_preempt_locks);
 	}
 
 	if (sleepable && !in_sleepable_context(env)) {
-- 
2.53.0

