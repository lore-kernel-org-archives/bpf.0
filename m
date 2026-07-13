Received: from mail-wm2-f9.google.com (mail-wm2-f9.google.com [74.125.225.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64B5643744A
	for <bpf@vger.kernel.org>; Mon, 13 Jul 2026 15:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783957171; cv=none; b=DSLknbUCgC0CkDgH1kRb6EgMh/hLIlw5CPNe9jxIQgPTmBG2tgK4YEeW8iDUajkIhNhY6xw77xHif8Ge+VkbuY6Z6oUDpFxmJtOoGW8ovmTWMIOkcsI5B3L2ohRb19caRw8nLHXjKEXU7lL/bTmMuXIBmS88s5SlR6g7l1xe5Cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783957171; c=relaxed/simple;
	bh=13NgJKnd5SgHpzUNHJyEAmqnJiZQZFbYHOQhBd1ub3w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=chkwk2ez41HudqsMsg/RvrAJI8A+trArLb1RkwQ5blLETjmYO6Zf9KdZ+MqymTnhjZRErji1nbP1Ha40JuMk2pjpUjrpYmDKIEMX5rJbDPzMDlekVn4dIBpY2i2OqPXEN7EgxPw+uBavxecFtsvCVzDUPiAt6uc1xe7TxFxZLeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AWOnpmH/; arc=none smtp.client-ip=74.125.225.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AWOnpmH/"
Received: by mail-wm2-f9.google.com with SMTP id 5b1f17b1804b1-493e55619a2so9306635e9.1
        for <bpf@vger.kernel.org>; Mon, 13 Jul 2026 08:39:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783957168; x=1784561968; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1dlUsp/ceycW5YxVWAnVYjFN3PtuAlRjJa3xkDrpVPg=;
        b=AWOnpmH/kUHMbRPISmZmLPPuo51Nl4ceiEMuWv/4X6K+EOt8r0GMI28irwBpE074bq
         2N6H76XZhyse+20ypa6efiXDBdYeaWrnrHy3hRV3xrqKRCq3rF5Eu7bZaRoF+DSe6C/F
         6UfJzoE0P+1jecyX0isGGM/F6q+k52m1oKES022wf5nlkrvWjH4b5x65LXmIzd0wVvlG
         /XWZA/PkJxxNYuU2X941begnpnFC5DNjMy5os+Zx9qP3Uee3kzj/FxQDP+lSGecdpwtV
         cf2Rx2aXTyPQQPQwtHaY+IUV2KVMB/q9bPOaVRhNK0gn6PtxiixoNd/xHH9kHupUK+F0
         H0dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783957168; x=1784561968;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=1dlUsp/ceycW5YxVWAnVYjFN3PtuAlRjJa3xkDrpVPg=;
        b=YxE9ZWY8b/EziInRq/6wDAWhWCb+JUDdpKz/2SUmC55aqzIliwig321om3Zifr+9Kv
         4vMz+jHRwAljaCXVPHJwbElmGpbJ1gcWaze6pV7vJ4mHxsUWzVyyBlJBXylmomsi+ROM
         26NmyNcqzIjLAIGf2Wz5y1kQpholro974V9mZsOXWGmy2FUBH5p/YSm9o4wunT3t6PqM
         00DbyS/fbyjWo76HeWstEpWPMf0SpebDzkBN9QBJnvMb9fIVEqzzDCOX8psA+3L1reGz
         5P16UjIngnv+HgOTGX7w0ecIiZ1h3a3yRq7LmpkjWYF1CXuVLrRb3kS4DAkYQDoh6e0j
         pkQA==
X-Gm-Message-State: AOJu0YzjgQSKa2D3quYktyQnUv5MW/5q/A77+8fnUL6bTO0tG+bUhijg
	pLEq2EHx9hl+vagbIUr9P47vXyILLoMsQ03O2nH8IPaXXLchRJOwqO+TzK5xqoSl
X-Gm-Gg: AfdE7ckDxxjFSWoJDoHhID49maWWIM0HEt35t23zcOqlWxH3tktm4RdWwsWK4sjU51U
	F77epmgcBfvq25R16Q0ogRP1yMw1e1Z5riekuKxQjirQ3mwJCV0Sq7Zur1FLIZDmkwk3d9WWyL2
	2i/fdoMpth0T7HOJAgx0Q9qhnA/quhpzsC7A7NPiOMeecijPQVIVoEK7KQsXDxVz/kn4bdfAhuu
	/8oaJML0FcsX6mXCAMYa3cQPZaAsKjnHzdE8UFebssMsVcKMw3k66cXjukaE2QdJUmAD7tu8LC5
	AQ1yjVlCRxIhQMgL2rLNhjaPREWyIreaz36R3Lg0B/SE2GXxl1Xk44mPSwu10duFTuq6/GHOs+K
	OLor9c53olF7YM/Ju3LadHOEXgBL7bab/DpOK/iMgJyVyvQ20TCBSp+MzzFf1V833ZO7A3LLucx
	z9KmzLg9sNdhqvegKFA+eSEz9FzWnOid/GSadHMajaxSOrx0FHFvw6TeM+6RX8/WqjAVFkCwjLW
	mmEMvsUT9AxtsQWYVr0y9SBCGYBK2HLvwy/sSaG5DNtBif709hAV3M=
X-Received: by 2002:a05:600c:4e49:b0:493:f744:e7d5 with SMTP id 5b1f17b1804b1-493fd3f21f4mr78948525e9.38.1783957167676;
        Mon, 13 Jul 2026 08:39:27 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f4635a940sm213325f8f.12.2026.07.13.08.39.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 08:39:27 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v3 12/17] bpf: Report Execution Context Safety errors
Date: Mon, 13 Jul 2026 17:39:01 +0200
Message-ID: <20260713153910.2556007-13-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260713153910.2556007-1-memxor@gmail.com>
References: <20260713153910.2556007-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=19488; i=memxor@gmail.com; h=from:subject; bh=13NgJKnd5SgHpzUNHJyEAmqnJiZQZFbYHOQhBd1ub3w=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JISuURTE6565J4+Jj6kfXCTnUsxxkesRQu8RySmCE0to/h oeWnVrbUcrCIMbFICumyFLyfx+T8YnK34G2y7hh5rAygQxh4OIUgIlcnsTI0NBfMrN8yaLnx7n8 7h0KOzql90XXxc+L3paIHzni6rHv909GhiaLr98eLWPm0xFs9Pt7vSev4cwkS7+TzLb+YSsbO3u ZOQA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Augment selected sleepability and critical-section failures with Execution
Context Safety reports. Keep the existing verifier messages and add source
context, path history, and suggestions tied to the active context.

Use the context history recorded earlier to anchor causal paths to lock, IRQ,
RCU, and preempt regions instead of unrelated register updates.

Cover global calls while holding a lock, sleepable global function calls,
sleepable helpers, sleepable kfunc calls from disallowed contexts, operations
that exit while a context is still active, and unmatched context exits.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/diagnostics.c | 198 +++++++++++++++++++++++++++++++++++----
 kernel/bpf/diagnostics.h |   9 ++
 kernel/bpf/verifier.c    |  93 ++++++++++++++++++
 3 files changed, 283 insertions(+), 17 deletions(-)

diff --git a/kernel/bpf/diagnostics.c b/kernel/bpf/diagnostics.c
index 111999e7682d..c90be89d4707 100644
--- a/kernel/bpf/diagnostics.c
+++ b/kernel/bpf/diagnostics.c
@@ -965,6 +965,23 @@ static u32 diag_current_frameno(const struct bpf_verifier_env *env)
 	return env->cur_state->frame[env->cur_state->curframe]->frameno;
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
 void bpf_diag_report_register_type(struct bpf_verifier_env *env, u32 insn_idx, int regno,
 				   const char *problem, const char *reason, const char *suggestion)
 {
@@ -1096,6 +1113,170 @@ void bpf_diag_report_call_type(struct bpf_verifier_env *env, u32 insn_idx, int a
 	diag_fmt_free(env);
 }
 
+static const char *diag_context_constraint(enum bpf_diag_context_kind kind)
+{
+	switch (kind) {
+	case BPF_DIAG_CONTEXT_RCU:
+		return "RCU read-side critical sections cannot call operations that may sleep";
+	case BPF_DIAG_CONTEXT_PREEMPT:
+		return "preemption-disabled code cannot call operations that may sleep";
+	case BPF_DIAG_CONTEXT_IRQ:
+		return "IRQ-disabled code cannot call operations that may sleep";
+	case BPF_DIAG_CONTEXT_LOCK:
+		return "code holding a BPF spin lock cannot call operations that may sleep";
+	case BPF_DIAG_CONTEXT_NONE:
+	default:
+		return NULL;
+	}
+}
+
+static void diag_format_active_context(char *buf, size_t size, u32 depth, const char *context)
+{
+	if (depth == 1)
+		scnprintf(buf, size, "an active %s (depth 1)", context);
+	else
+		scnprintf(buf, size, "%u active %ss (depth %u)", depth, context, depth);
+}
+
+static u32 diag_context_depth(struct bpf_verifier_env *env, enum bpf_diag_context_kind kind)
+{
+	switch (kind) {
+	case BPF_DIAG_CONTEXT_RCU:
+		return env->cur_state->active_rcu_locks;
+	case BPF_DIAG_CONTEXT_PREEMPT:
+		return env->cur_state->active_preempt_locks;
+	case BPF_DIAG_CONTEXT_IRQ:
+		return bpf_diag_irq_depth(env->cur_state);
+	case BPF_DIAG_CONTEXT_LOCK:
+		return env->cur_state->active_locks;
+	case BPF_DIAG_CONTEXT_NONE:
+	default:
+		return 0;
+	}
+}
+
+static void diag_ctx_forbidden(struct bpf_verifier_env *env, u32 insn_idx, const char *operation,
+			       enum bpf_diag_context_kind ctx_kind, const char *context,
+			       const char *suggestion)
+{
+	u32 depth = diag_context_depth(env, ctx_kind);
+	struct bpf_diag_history_opts opts = {
+		.scope = BPF_DIAG_HISTORY_SCOPE_CONTEXT,
+		.ctx_kind = ctx_kind,
+		.ctx_depth = depth,
+	};
+	const char *depth_buf;
+
+	bpf_diag_report_header(env, CATEGORY_EXECUTION_CONTEXT_SAFETY,
+			       "operation is not allowed in this context");
+	if (diag_context_constraint(ctx_kind)) {
+		if (depth) {
+			depth_buf = bpf_diag_scratch_buf(env, 2, NULL);
+			if (depth_buf)
+				diag_format_active_context((char *)depth_buf,
+							   BPF_DIAG_SCRATCH_STR_LEN, depth,
+							   context);
+			else
+				depth_buf = "";
+			diag_report_reason(env,
+					   "The operation %s cannot be used in %s because %s. This "
+					   "path is still inside %s.",
+					   operation, context, diag_context_constraint(ctx_kind),
+					   depth_buf);
+		} else {
+			diag_report_reason(env, "The operation %s cannot be used in %s because %s.",
+					   operation, context, diag_context_constraint(ctx_kind));
+		}
+	} else {
+		diag_report_reason(env, "The operation %s cannot be used in %s.", operation,
+				   context);
+	}
+
+	diag_report_section(env, "At");
+	bpf_diag_report_source(env, insn_idx, "error", "%s is not allowed in %s", operation,
+			       context);
+
+	if (ctx_kind != BPF_DIAG_CONTEXT_NONE)
+		diag_print_history(env, &opts);
+
+	diag_report_suggestion(env, "%s", suggestion);
+}
+
+static void diag_ctx_active(struct bpf_verifier_env *env, u32 insn_idx, const char *operation,
+			    enum bpf_diag_context_kind ctx_kind, const char *context,
+			    const char *suggestion)
+{
+	u32 depth = diag_context_depth(env, ctx_kind);
+	struct bpf_diag_history_opts opts = {
+		.scope = BPF_DIAG_HISTORY_SCOPE_CONTEXT,
+		.ctx_kind = ctx_kind,
+		.ctx_depth = depth,
+	};
+	const char *depth_buf;
+
+	depth_buf = bpf_diag_scratch_buf(env, 2, NULL);
+	if (depth_buf)
+		diag_format_active_context((char *)depth_buf, BPF_DIAG_SCRATCH_STR_LEN, depth,
+					   context);
+	else
+		depth_buf = "";
+
+	bpf_diag_report_header(env, CATEGORY_EXECUTION_CONTEXT_SAFETY,
+			       "operation is not allowed in this context");
+	diag_report_reason(env,
+			   "The operation %s cannot be used while this path is still inside %s. "
+			   "Leave the region before this operation.",
+			   operation, depth_buf);
+
+	diag_report_section(env, "At");
+	bpf_diag_report_source(env, insn_idx, "error", "%s is not allowed before leaving %s",
+			       operation, context);
+
+	diag_print_history(env, &opts);
+
+	diag_report_suggestion(env, "%s", suggestion);
+}
+
+static void diag_ctx_underflow(struct bpf_verifier_env *env, u32 insn_idx, const char *operation,
+			       enum bpf_diag_context_kind ctx_kind, const char *suggestion)
+{
+	struct bpf_diag_history_opts opts = {
+		.scope = BPF_DIAG_HISTORY_SCOPE_CONTEXT,
+		.ctx_kind = ctx_kind,
+	};
+	const char *context = diag_context_name(ctx_kind);
+
+	bpf_diag_report_header(env, CATEGORY_EXECUTION_CONTEXT_SAFETY, "unmatched context exit");
+	diag_report_reason(env,
+			   "The operation %s tries to leave %s, but this path has no active %s to "
+			   "leave. The current depth is 0.",
+			   operation, context, context);
+
+	diag_report_section(env, "At");
+	bpf_diag_report_source(env, insn_idx, "error", "%s has no matching enter on this path",
+			       operation);
+
+	diag_print_history(env, &opts);
+
+	diag_report_suggestion(env, "%s", suggestion);
+}
+
+void bpf_diag_ctx(struct bpf_verifier_env *env, enum bpf_diag_ctx_report report, u32 insn_idx,
+		  const char *operation, enum bpf_diag_context_kind ctx_kind, const char *context,
+		  const char *suggestion)
+{
+	switch (report) {
+	case BPF_DIAG_CTX_FORBIDDEN:
+		diag_ctx_forbidden(env, insn_idx, operation, ctx_kind, context, suggestion);
+		return;
+	case BPF_DIAG_CTX_ACTIVE:
+		diag_ctx_active(env, insn_idx, operation, ctx_kind, context, suggestion);
+		return;
+	case BPF_DIAG_CTX_UNDERFLOW:
+		diag_ctx_underflow(env, insn_idx, operation, ctx_kind, suggestion);
+		return;
+	}
+}
 void bpf_diag_report_invalid_deref(struct bpf_verifier_env *env, u32 insn_idx, int regno,
 				   const char *reg_name, const struct bpf_reg_state *reg,
 				   enum bpf_diag_invalid_deref_kind kind, s64 offset)
@@ -2108,23 +2289,6 @@ static void diag_print_ref_event(struct bpf_verifier_env *env,
 			       event->ref.ref_id);
 }
 
-static const char *diag_context_name(enum bpf_diag_context_kind kind)
-{
-	switch (kind) {
-	case BPF_DIAG_CONTEXT_RCU:
-		return "RCU read lock region";
-	case BPF_DIAG_CONTEXT_PREEMPT:
-		return "non-preemptible region";
-	case BPF_DIAG_CONTEXT_IRQ:
-		return "IRQ-disabled region";
-	case BPF_DIAG_CONTEXT_LOCK:
-		return "lock region";
-	case BPF_DIAG_CONTEXT_NONE:
-	default:
-		return "context";
-	}
-}
-
 static void diag_print_context_event(struct bpf_verifier_env *env,
 				     const struct bpf_diag_history_event *event)
 {
diff --git a/kernel/bpf/diagnostics.h b/kernel/bpf/diagnostics.h
index 7f1af8f50704..f26432e84d9f 100644
--- a/kernel/bpf/diagnostics.h
+++ b/kernel/bpf/diagnostics.h
@@ -96,6 +96,12 @@ enum bpf_diag_context_kind {
 	BPF_DIAG_CONTEXT_LOCK,
 };
 
+enum bpf_diag_ctx_report {
+	BPF_DIAG_CTX_FORBIDDEN,
+	BPF_DIAG_CTX_ACTIVE,
+	BPF_DIAG_CTX_UNDERFLOW,
+};
+
 enum bpf_diag_context_event_kind {
 	BPF_DIAG_CONTEXT_EVENT_RCU = BPF_DIAG_CONTEXT_RCU,
 	BPF_DIAG_CONTEXT_EVENT_PREEMPT = BPF_DIAG_CONTEXT_PREEMPT,
@@ -159,6 +165,9 @@ void bpf_diag_leak(struct bpf_verifier_env *env, u32 ref_id, u32 alloc_insn, u32
 void bpf_diag_report_call_type(struct bpf_verifier_env *env, u32 insn_idx, int argno, int regno,
 			       int stack_arg_slot, const char *call_name, const char *arg_name,
 			       const char *reason, const char *suggestion);
+void bpf_diag_ctx(struct bpf_verifier_env *env, enum bpf_diag_ctx_report report, u32 insn_idx,
+		  const char *operation, enum bpf_diag_context_kind ctx_kind, const char *context,
+		  const char *suggestion);
 int bpf_diag_record_branch(struct bpf_verifier_env *env, u32 insn_idx, bool cond_true);
 void bpf_diag_record_mod(struct bpf_verifier_env *env, u32 insn_idx,
 			 struct bpf_diag_mod_target target, enum bpf_diag_mod_reason reason,
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 07e2c1ed8fbe..e253fbc733a4 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -219,6 +219,8 @@ static int ref_set_non_owning(struct bpf_verifier_env *env,
 static bool is_trusted_reg(struct bpf_verifier_env *env, const struct bpf_reg_state *reg);
 static inline bool in_sleepable_context(struct bpf_verifier_env *env);
 static const char *non_sleepable_context_description(struct bpf_verifier_env *env);
+static enum bpf_diag_context_kind non_sleepable_context_kind(struct bpf_verifier_env *env);
+static const char *non_sleepable_context_diag_description(struct bpf_verifier_env *env);
 static void scalar32_min_max_add(struct bpf_reg_state *dst_reg, struct bpf_reg_state *src_reg);
 static void scalar_min_max_add(struct bpf_reg_state *dst_reg, struct bpf_reg_state *src_reg);
 
@@ -10109,17 +10111,32 @@ static int check_func_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 	if (err == -EFAULT)
 		return err;
 	if (bpf_subprog_is_global(env, subprog)) {
+		const char *context;
 		const char *sub_name = bpf_verifier_subprog_name(env, subprog);
+		const char *operation;
 
 		if (env->cur_state->active_locks) {
 			verbose(env, "global function calls are not allowed while holding a lock,\n"
 				     "use static function instead\n");
+			operation =
+				bpf_diag_scratch_printf(env, 1, "global function %s()", sub_name);
+			bpf_diag_ctx(env, BPF_DIAG_CTX_FORBIDDEN, *insn_idx, operation,
+				     BPF_DIAG_CONTEXT_LOCK, "lock region",
+				     "Release the lock before calling the global function, or use "
+				     "a static function instead.");
 			return -EINVAL;
 		}
 
 		if (env->subprog_info[subprog].might_sleep && !in_sleepable_context(env)) {
 			verbose(env, "sleepable global function %s() called in %s\n",
 				sub_name, non_sleepable_context_description(env));
+			context = non_sleepable_context_diag_description(env);
+			operation = bpf_diag_scratch_printf(
+				env, 1, "sleepable global function %s()", sub_name);
+			bpf_diag_ctx(env, BPF_DIAG_CTX_FORBIDDEN, *insn_idx, operation,
+				     non_sleepable_context_kind(env), context,
+				     "Move the call outside the critical section, or use a "
+				     "non-sleepable function.");
 			return -EINVAL;
 		}
 
@@ -10721,6 +10738,9 @@ static int check_resource_leak(struct bpf_verifier_env *env, bool exception_exit
 
 	if (check_lock && env->cur_state->active_locks) {
 		verbose(env, "%s cannot be used inside bpf_spin_lock-ed region\n", prefix);
+		bpf_diag_ctx(env, BPF_DIAG_CTX_ACTIVE, env->insn_idx, prefix, BPF_DIAG_CONTEXT_LOCK,
+			     "lock region",
+			     "Release the BPF spin lock before this operation on every path.");
 		return -EINVAL;
 	}
 
@@ -10732,16 +10752,25 @@ static int check_resource_leak(struct bpf_verifier_env *env, bool exception_exit
 
 	if (check_lock && env->cur_state->active_irq_id) {
 		verbose(env, "%s cannot be used inside bpf_local_irq_save-ed region\n", prefix);
+		bpf_diag_ctx(env, BPF_DIAG_CTX_ACTIVE, env->insn_idx, prefix, BPF_DIAG_CONTEXT_IRQ,
+			     "IRQ-disabled region",
+			     "Restore the saved IRQ state before this operation on every path.");
 		return -EINVAL;
 	}
 
 	if (check_lock && env->cur_state->active_rcu_locks) {
 		verbose(env, "%s cannot be used inside bpf_rcu_read_lock-ed region\n", prefix);
+		bpf_diag_ctx(env, BPF_DIAG_CTX_ACTIVE, env->insn_idx, prefix, BPF_DIAG_CONTEXT_RCU,
+			     "RCU read lock region",
+			     "Call bpf_rcu_read_unlock() before this operation on every path.");
 		return -EINVAL;
 	}
 
 	if (check_lock && env->cur_state->active_preempt_locks) {
 		verbose(env, "%s cannot be used inside bpf_preempt_disable-ed region\n", prefix);
+		bpf_diag_ctx(env, BPF_DIAG_CTX_ACTIVE, env->insn_idx, prefix,
+			     BPF_DIAG_CONTEXT_PREEMPT, "non-preemptible region",
+			     "Call bpf_preempt_enable() before this operation on every path.");
 		return -EINVAL;
 	}
 
@@ -10895,6 +10924,36 @@ static const char *non_sleepable_context_description(struct bpf_verifier_env *en
 	return "non-sleepable prog";
 }
 
+static enum bpf_diag_context_kind non_sleepable_context_kind(struct bpf_verifier_env *env)
+{
+	if (env->cur_state->active_rcu_locks)
+		return BPF_DIAG_CONTEXT_RCU;
+	if (env->cur_state->active_preempt_locks)
+		return BPF_DIAG_CONTEXT_PREEMPT;
+	if (env->cur_state->active_irq_id)
+		return BPF_DIAG_CONTEXT_IRQ;
+	if (env->cur_state->active_locks)
+		return BPF_DIAG_CONTEXT_LOCK;
+	return BPF_DIAG_CONTEXT_NONE;
+}
+
+static const char *non_sleepable_context_diag_description(struct bpf_verifier_env *env)
+{
+	switch (non_sleepable_context_kind(env)) {
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
+		return "non-sleepable program";
+	}
+}
+
 static int release_reg(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
 		       bool convert_rcu, bool release_dynptr)
 {
@@ -10923,6 +10982,7 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 	enum bpf_type_flag ret_flag;
 	struct bpf_reg_state *regs;
 	struct bpf_call_arg_meta meta;
+	const char *operation;
 	int insn_idx = *insn_idx_p;
 	bool changes_data;
 	int i, err, func_id;
@@ -10971,6 +11031,13 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 	if (fn->might_sleep && !in_sleepable_context(env)) {
 		verbose(env, "sleepable helper %s#%d in %s\n", func_id_name(func_id), func_id,
 			non_sleepable_context_description(env));
+		operation = bpf_diag_scratch_printf(env, 1, "sleepable helper %s#%d",
+						    func_id_name(func_id), func_id);
+		bpf_diag_ctx(env, BPF_DIAG_CTX_FORBIDDEN, insn_idx, operation,
+			     non_sleepable_context_kind(env),
+			     non_sleepable_context_diag_description(env),
+			     "Move the helper call outside the critical section, or use a "
+			     "non-sleepable helper.");
 		return -EINVAL;
 	}
 
@@ -13850,6 +13917,7 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 	const struct btf_type *t, *ptr_type;
 	struct bpf_kfunc_call_arg_meta meta;
 	struct bpf_insn_aux_data *insn_aux;
+	const char *operation;
 	int err, insn_idx = *insn_idx_p;
 	const struct btf_param *args;
 	u32 i, nargs, ptr_type_id;
@@ -13909,6 +13977,11 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 	sleepable = bpf_is_kfunc_sleepable(&meta);
 	if (sleepable && !in_sleepable(env)) {
 		verbose(env, "program must be sleepable to call sleepable kfunc %s\n", func_name);
+		operation = bpf_diag_scratch_printf(env, 1, "sleepable kfunc %s", func_name);
+		bpf_diag_ctx(env, BPF_DIAG_CTX_FORBIDDEN, insn_idx, operation,
+			     BPF_DIAG_CONTEXT_NONE, "non-sleepable program",
+			     "Mark the program sleepable if the program type allows it, or use a "
+			     "non-sleepable kfunc.");
 		return -EACCES;
 	}
 
@@ -13984,6 +14057,10 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 	} else if (rcu_unlock) {
 		if (env->cur_state->active_rcu_locks == 0) {
 			verbose(env, "unmatched rcu read unlock (kernel function %s)\n", func_name);
+			bpf_diag_ctx(env, BPF_DIAG_CTX_UNDERFLOW, insn_idx, func_name,
+				     BPF_DIAG_CONTEXT_RCU, NULL,
+				     "Remove the extra bpf_rcu_read_unlock() call, or ensure this "
+				     "path first enters an RCU read lock region.");
 			return -EINVAL;
 		}
 		env->cur_state->active_rcu_locks--;
@@ -13998,6 +14075,10 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 	} else if (preempt_enable) {
 		if (env->cur_state->active_preempt_locks == 0) {
 			verbose(env, "unmatched attempt to enable preemption (kernel function %s)\n", func_name);
+			bpf_diag_ctx(env, BPF_DIAG_CTX_UNDERFLOW, insn_idx, func_name,
+				     BPF_DIAG_CONTEXT_PREEMPT, NULL,
+				     "Remove the extra bpf_preempt_enable() call, or ensure this "
+				     "path first disables preemption.");
 			return -EINVAL;
 		}
 		env->cur_state->active_preempt_locks--;
@@ -14008,6 +14089,12 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 	if (sleepable && !in_sleepable_context(env)) {
 		verbose(env, "kernel func %s is sleepable within %s\n",
 			func_name, non_sleepable_context_description(env));
+		operation = bpf_diag_scratch_printf(env, 1, "sleepable kfunc %s", func_name);
+		bpf_diag_ctx(env, BPF_DIAG_CTX_FORBIDDEN, insn_idx, operation,
+			     non_sleepable_context_kind(env),
+			     non_sleepable_context_diag_description(env),
+			     "Move the kfunc call outside the critical section, or use a "
+			     "non-sleepable kfunc.");
 		return -EACCES;
 	}
 
@@ -18356,6 +18443,12 @@ static int do_check_insn(struct bpf_verifier_env *env, bool *do_print_state)
 				     (insn->off != 0 || !kfunc_spin_allowed(insn->imm)))) {
 					verbose(env,
 						"function calls are not allowed while holding a lock\n");
+					bpf_diag_ctx(env, BPF_DIAG_CTX_ACTIVE, env->insn_idx,
+						     "function call", BPF_DIAG_CONTEXT_LOCK,
+						     "lock region",
+						     "Release the BPF spin lock before making this "
+						     "call, or move the call outside the locked "
+						     "region.");
 					return -EINVAL;
 				}
 			}
-- 
2.53.0

