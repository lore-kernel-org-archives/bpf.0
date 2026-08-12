Received: from mail-wm2-f7.google.com (mail-wm2-f7.google.com [74.125.225.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DE594252A8
	for <bpf@vger.kernel.org>; Wed, 12 Aug 2026 23:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786577634; cv=none; b=Bwnd+aLWMg295lw3Ta5DWyGZyoevKk5PmffXbUcPtC8oxzirO2sIcjR1XlW/0o+SoPm2/Wh5Ekn2WMrjE9SEABY6RwS/1iOxn6MWLnbPp+NCIORjAnvV8ms0LAxXCzfVxKfOkewTgrDe9qdS4RAwvgC9msF+C105oD36+nlm7CM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786577634; c=relaxed/simple;
	bh=hzV1Rtmtblgpym1wtZf1mMliTAk1EkuYyL1A56X12D0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ct/aZ4Rofw4K2aLYRuznsN48yWrqne2sgZR1DDN3v0+LOLFFQTSi3KaZfLId+z/Xj6myQJZPpPHUKx+hXbMd54zSvtNfvhKIsDbhn13voKBxNtK9hNf+FZikGuA/QlgUAYSAbcwNMWQsvpUV5C8j8jpmDkZ3aoSAKM101IU7nBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kgMGndZ8; arc=none smtp.client-ip=74.125.225.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kgMGndZ8"
Received: by mail-wm2-f7.google.com with SMTP id 5b1f17b1804b1-498074920dcso6671465e9.1
        for <bpf@vger.kernel.org>; Wed, 12 Aug 2026 16:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786577629; x=1787182429; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FlIfDNTJjcEIvGyUWzHWReO97KGBxa642Mb+wXJUAhQ=;
        b=kgMGndZ8LFjaZRHu3yIHUezSLs9FAiJ50PsnuDTFdFwGXT6J7DMwCH04jSSN75b6ci
         vgvuuKQS9YawdV3OfDVvUOYH0A2hNtY3h5m4wrqt3w+eX7NpuA1aicIJT65+ocaArTyC
         Wtq1ssYItOzIn2WooHgI/XXmMSVBVomCeRnkI/lBKM9XkuRkYbotrBxpGaT40lv0T2Jj
         zgmySY+QKQY4B/xXMh7c+AyhmJFcOFBuX2JQXZciyVmf/BL5I5OHSHrpVbG+0Uh2tavz
         OSarE0OT79l7PBIFOsVTZPr85sK/Eqc0WcXfFDbhjakdGQtwT0voWapUPxksz0sEzpw1
         T8xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786577629; x=1787182429;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=FlIfDNTJjcEIvGyUWzHWReO97KGBxa642Mb+wXJUAhQ=;
        b=jir3duNiUGeq7VPEYNLq584jK7b/+kSZ7MUc4FoyrNpaH67X5mxmjNd5/q6KKi2IH9
         WpI6faNj1muEIAKSvO2y8CSpfdxjPey5J8e2b5SKsXDCwu4P2cxey8nkYqsZz9RaT/4l
         gTUL3oXkjIJeYZZRt4XWJ+x85+WQM0zwKmHGnyk/gXxO+QbpU9EBEnkwc7LA1ekxcqXa
         x4NdCCShXqj134GSR/FNYM5PkkmzKFbgb/fJ4Ywzdevmrw5Nm7KdqZKemA0IjpDeCbH3
         jTKB2yu8Cdx62BrTt/PtDmZmcluNpccFEr+mT+wto9KJ2wh2z/E2IZEIgIKX4jSoNZnp
         gDjQ==
X-Gm-Message-State: AOJu0YyUey/E0CAr/mSMVK9OwVfy2SQcUHowsuTp4FZQUJ0NGkHWB1XD
	UE6raQ6h4lzUPyl+xkZqFBPdA8xdAJzJ24V3rooP6VZmmL3STLVfGBELaymgMG4P
X-Gm-Gg: AR+sD13GKtauJ6DG9Oc6VkrgG7r4ioE+amURAuvgiDR1ZOU6+AUW17A9E1/yJdGcsKZ
	BeLTBS2FNqGtjcZA7CSNtwr8I+Mped+QEcCgn1rmVm4AdXjoMyz0J5xfDnLKjPfxJ6lI91nccbt
	zuiLdWKGrdEQX2XCFjcIuRnZjsUAXp/m1FzHhvOU4qDtJZxsw6OOWjqv0ZP5eJ66mBX9zFsvwci
	+EsFMuSUURZRq0XJxR6r7rkdyBRmTRmLhZjpfWIzxxCHdM9xycE8nupwKCMM4kZgPYvYTOq6CpR
	SBpC3BSCuP+AmjktbTF/SyMFWUG7zXCVri9G2oV1a4TpwS5mcQzu+aKb/irvgVWs/HYuoJ9dLOq
	BYJ7Xt10x8afHRIw2In1QyZ0SrUnEVwNxyZm4y3mhrxo8WuE3ddVu9U+Z0/EtBe92BHBx9Ji30D
	rsouuRX8cuelf9jSEmnaClzcpnyvwsPvvdaWqv2KFhvyQ84LpvmHKHYduuycMVImyXrypjMQxsM
	DDe6BNY9Q8oueptXivVE9+GrMZ6y8UoX9mABrjZDPCRIVPTQ7YlFrVRqH6CKNbP+1BkYI1c3ko2
	DiJc2NQ0tEZfmTdgj8wmhNhLAmgOaHTztLh8Uw==
X-Received: by 2002:a05:600c:6298:b0:499:8174:9f39 with SMTP id 5b1f17b1804b1-49982113bddmr15446745e9.0.1786577629352;
        Wed, 12 Aug 2026 16:33:49 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49981e47441sm15663655e9.4.2026.08.12.16.33.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 16:33:48 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v4 12/16] bpf: Report Execution Context Safety errors
Date: Thu, 13 Aug 2026 01:33:15 +0200
Message-ID: <20260812233326.3575958-13-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260812233326.3575958-1-memxor@gmail.com>
References: <20260812233326.3575958-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=23461; i=memxor@gmail.com; h=from:subject; bh=hzV1Rtmtblgpym1wtZf1mMliTAk1EkuYyL1A56X12D0=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIauWQXdXbN2Wzw/ib+9QFprDYKpj47rIamUoo4JlyOkuG db98kwdpSwMYlwMsmKKLCX/9zEZn6j8HWi7jBtmDisTyBAGLk4BmIgbGyNDc+ozzvbZc2auMvxW fdAr/knq3+cxqrIGj89s/npfXXduHSPDI8Gi9UzLOyQCvbey2oX+uxpk86jeYrWwSu8MiUr/fc8 YAA==
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
 kernel/bpf/diagnostics.c | 186 +++++++++++++++++++++++++++++++++++----
 kernel/bpf/diagnostics.h |  12 +++
 kernel/bpf/verifier.c    | 130 ++++++++++++++++++++++-----
 3 files changed, 288 insertions(+), 40 deletions(-)

diff --git a/kernel/bpf/diagnostics.c b/kernel/bpf/diagnostics.c
index c4022aba8e67..01bcc9b6b980 100644
--- a/kernel/bpf/diagnostics.c
+++ b/kernel/bpf/diagnostics.c
@@ -839,6 +839,23 @@ static u32 diag_current_frameno(const struct bpf_verifier_env *env)
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
 void bpf_diag_register_type(struct bpf_verifier_env *env, u32 insn_idx, int regno,
 				   const char *problem, const char *reason, const char *suggestion)
 {
@@ -969,6 +986,158 @@ void bpf_diag_call_type(struct bpf_verifier_env *env, u32 insn_idx, int argno, i
 	diag_suggestion(env, "%s", suggestion);
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
+static const char *diag_active_context(struct bpf_verifier_env *env, u32 depth,
+				       const char *context)
+{
+	if (depth == 1)
+		return bpf_diag_fmt(env, "an active %s (depth 1)", context);
+	return bpf_diag_fmt(env, "%u active %ss (depth %u)", depth, context, depth);
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
+			       const char *constraint, const char *suggestion)
+{
+	u32 depth = diag_context_depth(env, ctx_kind);
+	struct bpf_diag_history_opts opts = {
+		.scope = BPF_DIAG_HISTORY_SCOPE_CONTEXT,
+		.ctx_kind = ctx_kind,
+		.ctx_depth = depth,
+	};
+
+	bpf_diag_header(env, EXECUTION_CONTEXT_SAFETY,
+			       "operation is not allowed in this context");
+	if (constraint) {
+		if (depth) {
+			diag_reason(
+				env, "The operation %s cannot be used in %s because %s. This path is still inside %s.",
+				operation, context, constraint, diag_active_context(env, depth, context));
+		} else {
+			diag_reason(env, "The operation %s cannot be used in %s because %s.",
+					   operation, context, constraint);
+		}
+	} else {
+		diag_reason(env, "The operation %s cannot be used in %s.", operation,
+				   context);
+	}
+
+	diag_section(env, "At");
+	bpf_diag_source(env, insn_idx, "error", "%s is not allowed in %s", operation,
+			       context);
+
+	if (ctx_kind != BPF_DIAG_CONTEXT_NONE)
+		diag_print_history(env, &opts);
+
+	diag_suggestion(env, "%s", suggestion);
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
+
+	bpf_diag_header(env, EXECUTION_CONTEXT_SAFETY,
+			       "operation is not allowed in this context");
+	diag_reason(
+		env, "The operation %s cannot be used while this path is still inside %s. Leave the region before this operation.",
+		operation, diag_active_context(env, depth, context));
+
+	diag_section(env, "At");
+	bpf_diag_source(env, insn_idx, "error", "%s is not allowed before leaving %s",
+			       operation, context);
+
+	diag_print_history(env, &opts);
+
+	diag_suggestion(env, "%s", suggestion);
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
+	bpf_diag_header(env, EXECUTION_CONTEXT_SAFETY, "unmatched context exit");
+	diag_reason(
+		env, "The operation %s tries to leave %s, but this path has no active %s to leave. The current depth is 0.",
+		operation, context, context);
+
+	diag_section(env, "At");
+	bpf_diag_source(env, insn_idx, "error", "%s has no matching enter on this path",
+			       operation);
+
+	diag_print_history(env, &opts);
+
+	diag_suggestion(env, "%s", suggestion);
+}
+
+void bpf_diag_ctx(struct bpf_verifier_env *env, enum bpf_diag_ctx_report report, u32 insn_idx,
+		  const char *operation, enum bpf_diag_context_kind ctx_kind, const char *context,
+		  const char *suggestion)
+{
+	switch (report) {
+	case BPF_DIAG_CTX_FORBIDDEN:
+		diag_ctx_forbidden(env, insn_idx, operation, ctx_kind, context,
+				   diag_context_constraint(ctx_kind), suggestion);
+		return;
+	case BPF_DIAG_CTX_ACTIVE:
+		diag_ctx_active(env, insn_idx, operation, ctx_kind, context, suggestion);
+		return;
+	case BPF_DIAG_CTX_UNDERFLOW:
+		diag_ctx_underflow(env, insn_idx, operation, ctx_kind, suggestion);
+		return;
+	}
+}
+
+void bpf_diag_ctx_restricted(struct bpf_verifier_env *env, u32 insn_idx, const char *operation,
+			     enum bpf_diag_context_kind ctx_kind, const char *context,
+			     const char *constraint, const char *suggestion)
+{
+	diag_ctx_forbidden(env, insn_idx, operation, ctx_kind, context, constraint, suggestion);
+}
 void bpf_diag_invalid_deref(struct bpf_verifier_env *env, u32 insn_idx, int regno,
 				   const char *reg_name, const struct bpf_reg_state *reg,
 				   enum bpf_diag_invalid_deref_kind kind, s64 offset)
@@ -2005,23 +2174,6 @@ static void diag_print_ref_event(struct bpf_verifier_env *env,
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
index 9d4cdbcb1c75..9479a42d105a 100644
--- a/kernel/bpf/diagnostics.h
+++ b/kernel/bpf/diagnostics.h
@@ -94,6 +94,12 @@ enum bpf_diag_context_kind {
 	BPF_DIAG_CONTEXT_LOCK,
 };
 
+enum bpf_diag_ctx_report {
+	BPF_DIAG_CTX_FORBIDDEN,
+	BPF_DIAG_CTX_ACTIVE,
+	BPF_DIAG_CTX_UNDERFLOW,
+};
+
 enum bpf_diag_invalid_deref_kind {
 	BPF_DIAG_DEREF_SCALAR,
 	BPF_DIAG_DEREF_NULLABLE_PTR,
@@ -142,6 +148,12 @@ void bpf_diag_leak(struct bpf_verifier_env *env, u32 ref_id, u32 alloc_insn, u32
 void bpf_diag_call_type(struct bpf_verifier_env *env, u32 insn_idx, int argno, int regno,
 			       int stack_arg_slot, const char *call_name, const char *arg_name,
 			       const char *reason, const char *suggestion);
+void bpf_diag_ctx(struct bpf_verifier_env *env, enum bpf_diag_ctx_report report, u32 insn_idx,
+		  const char *operation, enum bpf_diag_context_kind ctx_kind, const char *context,
+		  const char *suggestion);
+void bpf_diag_ctx_restricted(struct bpf_verifier_env *env, u32 insn_idx, const char *operation,
+			     enum bpf_diag_context_kind ctx_kind, const char *context,
+			     const char *constraint, const char *suggestion);
 void bpf_diag_record_branch(struct bpf_verifier_env *env, u32 insn_idx, bool cond_true);
 void bpf_diag_mod_begin(struct bpf_verifier_env *env, const struct bpf_reg_state *reg,
 			const struct bpf_reg_state *origin, enum bpf_diag_mod_reason reason);
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 7e28f4d9f5c4..71893c36ecce 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -217,6 +217,8 @@ static int ref_set_non_owning(struct bpf_verifier_env *env,
 static bool is_trusted_reg(struct bpf_verifier_env *env, const struct bpf_reg_state *reg);
 static inline bool in_sleepable_context(struct bpf_verifier_env *env);
 static const char *non_sleepable_context_description(struct bpf_verifier_env *env);
+static enum bpf_diag_context_kind non_sleepable_context_kind(struct bpf_verifier_env *env);
+static const char *non_sleepable_context_diag_description(struct bpf_verifier_env *env);
 static void scalar32_min_max_add(struct bpf_reg_state *dst_reg, struct bpf_reg_state *src_reg);
 static void scalar_min_max_add(struct bpf_reg_state *dst_reg, struct bpf_reg_state *src_reg);
 
@@ -1104,9 +1106,7 @@ static int unmark_stack_slot_irq_flag(struct bpf_verifier_env *env, struct bpf_r
 	st = &slot->spilled_ptr;
 
 	if (st->irq.kfunc_class != kfunc_class) {
-		const char *fmt = "This IRQ flag was saved by %s IRQ kfuncs, but the restore call "
-				  "belongs to the %s IRQ kfunc family. Save and restore operations "
-				  "must use the same family.";
+		const char *fmt = "This IRQ flag was saved by %s IRQ kfuncs, but the restore call belongs to the %s IRQ kfunc family. Save and restore operations must use the same family.";
 		const char *flag_kfunc = st->irq.kfunc_class == IRQ_NATIVE_KFUNC ? "native" :
 										   "lock";
 		const char *used_kfunc = kfunc_class == IRQ_NATIVE_KFUNC ? "native" : "lock";
@@ -1115,10 +1115,10 @@ static int unmark_stack_slot_irq_flag(struct bpf_verifier_env *env, struct bpf_r
 		verbose(env, "irq flag acquired by %s kfuncs cannot be restored with %s kfuncs\n",
 			flag_kfunc, used_kfunc);
 		reason = bpf_diag_fmt(env, fmt, flag_kfunc, used_kfunc);
-		bpf_diag_irq(env, env->insn_idx, "IRQ flag restore mismatch", reason,
-			     "Restore the flag with the matching IRQ restore kfunc for the save "
-			     "operation that created it.",
-			     bpf_diag_irq_depth(env->cur_state));
+		bpf_diag_irq(
+			env, env->insn_idx, "IRQ flag restore mismatch", reason,
+			"Restore the flag with the matching IRQ restore kfunc for the save operation that created it.",
+			bpf_diag_irq_depth(env->cur_state));
 		return -EINVAL;
 	}
 
@@ -1136,11 +1136,11 @@ static int unmark_stack_slot_irq_flag(struct bpf_verifier_env *env, struct bpf_r
 
 		verbose(env, "cannot restore irq state out of order, expected id=%d acquired at insn_idx=%d\n",
 			env->cur_state->active_irq_id, insn_idx);
-		bpf_diag_irq(env, env->insn_idx, "IRQ flag restore out of order",
-			     "IRQ-disabled regions must be restored in last-in, first-out order, "
-			     "but this restore does not match the currently active IRQ flag.",
-			     "Restore nested IRQ flags in the reverse order they were saved.",
-			     bpf_diag_irq_depth(env->cur_state));
+		bpf_diag_irq(
+			env, env->insn_idx, "IRQ flag restore out of order",
+			"IRQ-disabled regions must be restored in last-in, first-out order, but this restore does not match the currently active IRQ flag.",
+			"Restore nested IRQ flags in the reverse order they were saved.",
+			bpf_diag_irq_depth(env->cur_state));
 		return err;
 	}
 
@@ -9766,17 +9766,31 @@ static int check_func_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 	if (err == -EFAULT)
 		return err;
 	if (bpf_subprog_is_global(env, subprog)) {
+		const char *context;
 		const char *sub_name = bpf_subprog_name(env, subprog);
+		const char *operation;
 
 		if (env->cur_state->active_locks) {
 			verbose(env, "global function calls are not allowed while holding a lock,\n"
 				     "use static function instead\n");
+			operation =
+				bpf_diag_fmt(env, "global function %s()", sub_name);
+			bpf_diag_ctx_restricted(
+				env, *insn_idx, operation, BPF_DIAG_CONTEXT_LOCK, "lock region",
+				"global calls are prohibited while any lock is held",
+				"Release the lock before calling the global function, or use a static function instead.");
 			return -EINVAL;
 		}
 
 		if (env->subprog_info[subprog].might_sleep && !in_sleepable_context(env)) {
 			verbose(env, "sleepable global function %s() called in %s\n",
 				sub_name, non_sleepable_context_description(env));
+			context = non_sleepable_context_diag_description(env);
+			operation = bpf_diag_fmt(env, "sleepable global function %s()", sub_name);
+			bpf_diag_ctx(
+				env, BPF_DIAG_CTX_FORBIDDEN, *insn_idx, operation,
+				non_sleepable_context_kind(env), context,
+				"Move the call outside the critical section, or use a non-sleepable function.");
 			return -EINVAL;
 		}
 
@@ -10377,6 +10391,9 @@ static int check_resource_leak(struct bpf_verifier_env *env, bool exception_exit
 
 	if (check_lock && env->cur_state->active_locks) {
 		verbose(env, "%s cannot be used inside bpf_spin_lock-ed region\n", prefix);
+		bpf_diag_ctx(
+			env, BPF_DIAG_CTX_ACTIVE, env->insn_idx, prefix, BPF_DIAG_CONTEXT_LOCK,
+			"lock region", "Release the BPF spin lock before this operation on every path.");
 		return -EINVAL;
 	}
 
@@ -10388,16 +10405,26 @@ static int check_resource_leak(struct bpf_verifier_env *env, bool exception_exit
 
 	if (check_lock && env->cur_state->active_irq_id) {
 		verbose(env, "%s cannot be used inside bpf_local_irq_save-ed region\n", prefix);
+		bpf_diag_ctx(
+			env, BPF_DIAG_CTX_ACTIVE, env->insn_idx, prefix, BPF_DIAG_CONTEXT_IRQ,
+			"IRQ-disabled region", "Restore the saved IRQ state before this operation on every path.");
 		return -EINVAL;
 	}
 
 	if (check_lock && env->cur_state->active_rcu_locks) {
 		verbose(env, "%s cannot be used inside bpf_rcu_read_lock-ed region\n", prefix);
+		bpf_diag_ctx(
+			env, BPF_DIAG_CTX_ACTIVE, env->insn_idx, prefix, BPF_DIAG_CONTEXT_RCU,
+			"RCU read lock region", "Call bpf_rcu_read_unlock() before this operation on every path.");
 		return -EINVAL;
 	}
 
 	if (check_lock && env->cur_state->active_preempt_locks) {
 		verbose(env, "%s cannot be used inside bpf_preempt_disable-ed region\n", prefix);
+		bpf_diag_ctx(
+			env, BPF_DIAG_CTX_ACTIVE, env->insn_idx, prefix,
+			BPF_DIAG_CONTEXT_PREEMPT, "non-preemptible region",
+			"Call bpf_preempt_enable() before this operation on every path.");
 		return -EINVAL;
 	}
 
@@ -10551,6 +10578,36 @@ static const char *non_sleepable_context_description(struct bpf_verifier_env *en
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
@@ -10579,6 +10636,7 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 	enum bpf_type_flag ret_flag;
 	struct bpf_reg_state *regs;
 	struct bpf_call_arg_meta meta;
+	const char *operation;
 	int insn_idx = *insn_idx_p;
 	bool changes_data;
 	int i, err, func_id;
@@ -10626,6 +10684,12 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 	if (fn->might_sleep && !in_sleepable_context(env)) {
 		verbose(env, "sleepable helper %s#%d in %s\n", func_id_name(func_id), func_id,
 			non_sleepable_context_description(env));
+		operation = bpf_diag_fmt(env, "sleepable helper %s#%d",
+						    func_id_name(func_id), func_id);
+		bpf_diag_ctx(
+			env, BPF_DIAG_CTX_FORBIDDEN, insn_idx, operation,
+			non_sleepable_context_kind(env), non_sleepable_context_diag_description(env),
+			"Move the helper call outside the critical section, or use a non-sleepable helper.");
 		return -EINVAL;
 	}
 
@@ -11919,12 +11983,10 @@ static int process_irq_flag(struct bpf_verifier_env *env, struct bpf_reg_state *
 		if (!is_irq_flag_reg_valid_uninit(env, reg)) {
 			verbose(env, "expected uninitialized irq flag as %s\n",
 				reg_arg_name(env, argno));
-			bpf_diag_res(env, env->insn_idx, "IRQ flag is already initialized",
-				     "Saving IRQ state requires an uninitialized stack slot for "
-				     "the IRQ flag, but this slot already contains tracked IRQ "
-				     "flag state.",
-				     "Use a fresh stack slot for this save operation, or restore "
-				     "the existing IRQ flag before reusing the slot.");
+			bpf_diag_res(
+				env, env->insn_idx, "IRQ flag is already initialized",
+				"Saving IRQ state requires an uninitialized stack slot for the IRQ flag, but this slot already contains tracked IRQ flag state.",
+				"Use a fresh stack slot for this save operation, or restore the existing IRQ flag before reusing the slot.");
 			return -EINVAL;
 		}
 
@@ -11941,11 +12003,10 @@ static int process_irq_flag(struct bpf_verifier_env *env, struct bpf_reg_state *
 		if (err) {
 			verbose(env, "expected an initialized irq flag as %s\n",
 				reg_arg_name(env, argno));
-			bpf_diag_res(env, env->insn_idx, "uninitialized IRQ flag restore",
-				     "Restoring IRQ state requires a stack slot that was "
-				     "initialized by a matching IRQ save operation on this path.",
-				     "Pass the same stack slot that was previously initialized by "
-				     "the matching IRQ save kfunc.");
+			bpf_diag_res(
+				env, env->insn_idx, "uninitialized IRQ flag restore",
+				"Restoring IRQ state requires a stack slot that was initialized by a matching IRQ save operation on this path.",
+				"Pass the same stack slot that was previously initialized by the matching IRQ save kfunc.");
 			return err;
 		}
 
@@ -13450,6 +13511,7 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 	const struct btf_type *t, *ptr_type;
 	struct bpf_call_arg_meta meta;
 	struct bpf_insn_aux_data *insn_aux;
+	const char *operation;
 	int err, insn_idx = *insn_idx_p;
 	u32 i, nargs, ptr_type_id;
 	struct bpf_kfunc_desc *desc;
@@ -13515,6 +13577,11 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 	sleepable = bpf_is_kfunc_sleepable(&meta);
 	if (sleepable && !in_sleepable(env)) {
 		verbose(env, "program must be sleepable to call sleepable kfunc %s\n", func_name);
+		operation = bpf_diag_fmt(env, "sleepable kfunc %s", func_name);
+		bpf_diag_ctx(
+			env, BPF_DIAG_CTX_FORBIDDEN, insn_idx, operation,
+			BPF_DIAG_CONTEXT_NONE, "non-sleepable program",
+			"Mark the program sleepable if the program type allows it, or use a non-sleepable kfunc.");
 		return -EACCES;
 	}
 
@@ -13585,6 +13652,10 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 	} else if (rcu_unlock) {
 		if (env->cur_state->active_rcu_locks == 0) {
 			verbose(env, "unmatched rcu read unlock (kernel function %s)\n", func_name);
+			bpf_diag_ctx(
+				env, BPF_DIAG_CTX_UNDERFLOW, insn_idx, func_name,
+				BPF_DIAG_CONTEXT_RCU, NULL,
+				"Remove the extra bpf_rcu_read_unlock() call, or ensure this path first enters an RCU read lock region.");
 			return -EINVAL;
 		}
 		env->cur_state->active_rcu_locks--;
@@ -13599,6 +13670,10 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 	} else if (preempt_enable) {
 		if (env->cur_state->active_preempt_locks == 0) {
 			verbose(env, "unmatched attempt to enable preemption (kernel function %s)\n", func_name);
+			bpf_diag_ctx(
+				env, BPF_DIAG_CTX_UNDERFLOW, insn_idx, func_name,
+				BPF_DIAG_CONTEXT_PREEMPT, NULL,
+				"Remove the extra bpf_preempt_enable() call, or ensure this path first disables preemption.");
 			return -EINVAL;
 		}
 		env->cur_state->active_preempt_locks--;
@@ -13611,6 +13686,11 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 	if (sleepable && !in_sleepable_context(env)) {
 		verbose(env, "kernel func %s is sleepable within %s\n",
 			func_name, non_sleepable_context_description(env));
+		operation = bpf_diag_fmt(env, "sleepable kfunc %s", func_name);
+		bpf_diag_ctx(
+			env, BPF_DIAG_CTX_FORBIDDEN, insn_idx, operation,
+			non_sleepable_context_kind(env), non_sleepable_context_diag_description(env),
+			"Move the kfunc call outside the critical section, or use a non-sleepable kfunc.");
 		return -EACCES;
 	}
 
@@ -17890,6 +17970,10 @@ static int do_check_insn(struct bpf_verifier_env *env, bool *do_print_state)
 				     !kfunc_spin_allowed(env, insn->imm, insn->off))) {
 					verbose(env,
 						"function calls are not allowed while holding a lock\n");
+					bpf_diag_ctx(
+						env, BPF_DIAG_CTX_ACTIVE, env->insn_idx,
+						"function call", BPF_DIAG_CONTEXT_LOCK, "lock region",
+						"Release the BPF spin lock before making this call, or move the call outside the locked region.");
 					return -EINVAL;
 				}
 			}
-- 
2.53.0

