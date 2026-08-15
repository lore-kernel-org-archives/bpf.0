Received: from mail-wr2-f1.google.com (mail-wr2-f1.google.com [74.125.225.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6798C3B3888
	for <bpf@vger.kernel.org>; Sat, 15 Aug 2026 06:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786776411; cv=none; b=h+lq8jPs3dd3gED9w1ER6OmkZ9jk4V91rxyvjqZpb6tlbVGAoWM450dGtbhvdDcIgEy5IQXQ4dV3Lwog31wQMigGvhMR2xJozTJ8JqdrRik9ayDYF7eXCUDK3VNDpP4qC7XMgDcHUM/g8CyDcebYzi5AtP9tnlEZKM1VpjQA20s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786776411; c=relaxed/simple;
	bh=dLH9lAvlsjtVst0ZjEU9zGJUg/YCSjPvFM/3W853POk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=olGmvPiAZpaTvXG63fOSs1qaVNgzF0znkzhV3bYo/+/yGnnIhsyI5JkwuWlvo+DGivRQDaCFh1zY/fx16L8g6FOHWRTbO5UjTvHo70r/59pfpGreLddFyZUlQSP4u7yrGO1EO8kW48tUoPPsnaG3JfEdcf1HVw39jt6YLDVIS8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kkDj23zn; arc=none smtp.client-ip=74.125.225.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kkDj23zn"
Received: by mail-wr2-f1.google.com with SMTP id ffacd0b85a97d-47fd1b2021fso434481f8f.1
        for <bpf@vger.kernel.org>; Fri, 14 Aug 2026 23:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786776390; x=1787381190; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6PuHXIHuOicR1WwNp2UxbwSn/5w6G3pl+6FSTfO0gUo=;
        b=kkDj23znUdcuoPFpQEJC4HP4F7OqBmFxvbL6Et5/5iQ1zGWgzguEW6Q5SfvvA/Tk9v
         pNp4QK8yHKNY8/C9i5MIePZ3G2t6qfAh1iXOwAgH3VNtCycz3uHzZeKURkAet4UQeyu6
         IIY7/ZV2OAi2xb3Ol1IDQRsSK7V+pBIPKcGg4ttUT33HUADinMSmzrYRpnl68FF6+AyL
         9csbdg9cLwcfOgwL5qPcwSXPOMI+IFsSEP3m9+XeV9JzbSWrZf4iBWaLg6TBR5rfR/gW
         k11omx29N6tvFlnDoN55LG+b7980hIF++9TsuU183QD3TLxBbtBkeahTM0An9zYVHhOQ
         xYSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786776390; x=1787381190;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6PuHXIHuOicR1WwNp2UxbwSn/5w6G3pl+6FSTfO0gUo=;
        b=clwSoMA7SLeq5YRl0H34dJzZGljwhJRcfQYk6IaL8Qnk89yPUmJaAcMaKtUergU288
         2UCKhP10SthnoQdbMy2IIRJ3X1L0ObvSZv446isHiGqYtVlpX9BoiBm+UKQ9N6svyM7q
         A4mE+v8gZv7tPl7OLjdwXQpNp2n8rAcFqR2C+3XPg0TqdBWnPEiGzCOeWBXLmsb8Q9+o
         4ggQIPh+UriB+WpId/lmYmYSzCoGeCzgAF4bJJBECjuixvYH986HY72ayfy/IJz8sBlr
         PyStlXUzqQJeSsqDSpiqPT+S5ZcfU/tn3AqzGpOxwhZyIOCpKyeedgh5DWM44d8BZub+
         xUeg==
X-Gm-Message-State: AOJu0YzOZvDVncmBHEfKQiMoVYorgL8nZMLnR0EUk2iP+ot5mesHCvD6
	MevKAq0CD9sxSN8bEZFGtR9s/sglSiswuOZMf5T+QYtyE7AofMfStEc7JKb6gg+d
X-Gm-Gg: AR+sD13JIj4g0HxGjpMc3tJA2jF8INXKxqNN0vCdyx6mwqUuVIpvSPFS+bN3zdGgL+K
	BT6gVDA80E8jp7tDPbqYkbvE5ymjcyncIFJk07buU/JAB2/+2K4oYPep4h5tXFdbcG2Bn/7FBZi
	SLCgoXSAD5xHjtUDy8flpid7nzn9GhNHAJVBUXi21Vz1RqqPP3cGe2XaU8Dat0Py1IREDF1Pt9g
	rlOmW9lJwUzP9oWb2/v3xvBYpS4w1xuyZ0J1Ba5IqAVobSTV9+cq0xr06M+E3sQz3eaNjCZSL9x
	YthNXm9M5gJZYzvYBsZsGFmp6qdVV4mJf7MTWBY5II3WtFU4HEBtbF150O/Q9O8PfzNZpsDUr1G
	0iG/b6BThvvyQbz2dNTmKsXALTSCOS8Smy9JmJBzecPkizkhK5BjKbBRCaa3vUBLOuFeqgtsi5X
	glYlhjLnRxCuNIVspk1PiGOjcGNdqoF/6kBRMEAehRbf8M9IhXgsqlXLWWqwb6hfcDMxkYGbo+9
	LIbDHlTae/B3PUEhk67LsLHJn/qFICV5VQkORU+kEbYy5eae0fo2VJ0N/Q+HT0d0dqLr8wtFqcP
	pyjumsr5/1bLfKg85yfGB6KcX0nDqUmVuzl9NQ==
X-Received: by 2002:a05:6000:240c:b0:47f:80d1:be0a with SMTP id ffacd0b85a97d-4816074889bmr13386686f8f.14.1786776390465;
        Fri, 14 Aug 2026 23:46:30 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4815f2cc81csm14573580f8f.34.2026.08.14.23.46.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 23:46:29 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v5 12/14] bpf: Report Execution Context Safety errors
Date: Sat, 15 Aug 2026 08:46:07 +0200
Message-ID: <20260815064612.378577-13-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260815064612.378577-1-memxor@gmail.com>
References: <20260815064612.378577-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=16860; i=memxor@gmail.com; h=from:subject; bh=dLH9lAvlsjtVst0ZjEU9zGJUg/YCSjPvFM/3W853POk=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIauBy3f9bF974bp6qd8WCadfimpvTdtUULozI1pApuHWs ysOc/Q7SlkYxLgYZMUUWUr+72MyPlH5O9B2GTfMHFYmkCEMXJwCMJG8SQz/s4pvV56bw3x3/ulp FTq5Qtu2O22Z1vZ8hyv7EZ8GH/1sB0aGS4XsGsaKJ278v+PJubQhPWeN0D6ViAcf3t47YbMzg2U NIwA=
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
 kernel/bpf/diagnostics.c | 165 ++++++++++++++++++++++++++++++++++++++-
 kernel/bpf/diagnostics.h |   9 +++
 kernel/bpf/verifier.c    |  44 +++++++++++
 3 files changed, 217 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/diagnostics.c b/kernel/bpf/diagnostics.c
index 99784d465881..c69160f656e9 100644
--- a/kernel/bpf/diagnostics.c
+++ b/kernel/bpf/diagnostics.c
@@ -20,6 +20,7 @@
 #define MEMORY_SAFETY "Memory Safety"
 #define RESOURCE_LIFETIME_SAFETY "Resource Lifetime Safety"
 #define CALL_TYPE_SAFETY "Call Type Safety"
+#define EXECUTION_CONTEXT_SAFETY "Execution Context Safety"
 
 #define BPF_DIAG_TEXT_WIDTH 100
 #define BPF_DIAG_TEXT_INDENT "  "
@@ -163,6 +164,7 @@ static void diag_print_history(struct bpf_verifier_env *env,
 			       const struct bpf_diag_history_opts *opts);
 static bool diag_target_matches(const struct bpf_diag_mod_target *event_target,
 				const struct bpf_diag_mod_target *target);
+static const char *diag_context_name(enum bpf_diag_context_kind kind);
 struct disasm_line {
 	char text[DISASM_LINE_LEN];
 	int idx;
@@ -1029,6 +1031,167 @@ void bpf_diag_call_type(struct bpf_verifier_env *env, u32 insn_idx, int argno, i
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
+void bpf_diag_ctx_forbidden(struct bpf_verifier_env *env, u32 insn_idx,
+			    const char *operation, const char *suggestion)
+{
+	struct bpf_diag_history_opts opts;
+	enum bpf_diag_context_kind ctx_kind;
+	const char *constraint, *context;
+	u32 depth;
+
+	if (env->cur_state->active_rcu_locks)
+		ctx_kind = BPF_DIAG_CONTEXT_RCU;
+	else if (env->cur_state->active_preempt_locks)
+		ctx_kind = BPF_DIAG_CONTEXT_PREEMPT;
+	else if (env->cur_state->active_irq_id)
+		ctx_kind = BPF_DIAG_CONTEXT_IRQ;
+	else if (env->cur_state->active_locks)
+		ctx_kind = BPF_DIAG_CONTEXT_LOCK;
+	else
+		ctx_kind = BPF_DIAG_CONTEXT_NONE;
+
+	depth = diag_context_depth(env, ctx_kind);
+	opts = (struct bpf_diag_history_opts) {
+		.scope = BPF_DIAG_HISTORY_SCOPE_CONTEXT,
+		.ctx_kind = ctx_kind,
+		.ctx_depth = depth,
+	};
+	constraint = diag_context_constraint(ctx_kind);
+	context = diag_context_name(ctx_kind);
+
+	bpf_diag_header(env, EXECUTION_CONTEXT_SAFETY,
+			"operation is not allowed in this context");
+	if (constraint) {
+		if (depth) {
+			diag_reason(
+				env, "The operation %s cannot be used in %s because %s. This path is still inside %s.",
+				operation, context, constraint, diag_active_context(env, depth, context));
+		} else {
+			diag_reason(env, "The operation %s cannot be used in %s because %s.",
+				    operation, context, constraint);
+		}
+	} else {
+		diag_reason(env, "The operation %s cannot be used in %s.", operation,
+			    context);
+	}
+
+	diag_section(env, "At");
+	bpf_diag_source(env, insn_idx, "error", "%s is not allowed in %s", operation,
+			context);
+
+	if (ctx_kind != BPF_DIAG_CONTEXT_NONE)
+		diag_print_history(env, &opts);
+
+	diag_suggestion(env, "%s", suggestion);
+}
+
+void bpf_diag_ctx_active(struct bpf_verifier_env *env, u32 insn_idx, const char *operation,
+			 enum bpf_diag_context_kind ctx_kind, const char *suggestion)
+{
+	u32 depth = diag_context_depth(env, ctx_kind);
+	struct bpf_diag_history_opts opts = {
+		.scope = BPF_DIAG_HISTORY_SCOPE_CONTEXT,
+		.ctx_kind = ctx_kind,
+		.ctx_depth = depth,
+	};
+	const char *context = diag_context_name(ctx_kind);
+
+	bpf_diag_header(env, EXECUTION_CONTEXT_SAFETY,
+			"operation is not allowed in this context");
+	diag_reason(
+		env, "The operation %s cannot be used while this path is still inside %s. Leave the region before this operation.",
+		operation, diag_active_context(env, depth, context));
+
+	diag_section(env, "At");
+	bpf_diag_source(env, insn_idx, "error", "%s is not allowed before leaving %s",
+			operation, context);
+
+	diag_print_history(env, &opts);
+
+	diag_suggestion(env, "%s", suggestion);
+}
+
+void bpf_diag_ctx_required(struct bpf_verifier_env *env, u32 insn_idx, const char *operation,
+			   enum bpf_diag_context_kind ctx_kind, const char *suggestion)
+{
+	const char *context = diag_context_name(ctx_kind);
+
+	bpf_diag_header(env, EXECUTION_CONTEXT_SAFETY, "required context is not active");
+	diag_reason(env, "The operation %s requires an active %s, but this path is outside one.",
+		    operation, context);
+
+	diag_section(env, "At");
+	bpf_diag_source(env, insn_idx, "error", "%s requires %s", operation, context);
+
+	diag_suggestion(env, "%s", suggestion);
+}
+
+void bpf_diag_ctx_underflow(struct bpf_verifier_env *env, u32 insn_idx,
+			    const char *operation, enum bpf_diag_context_kind ctx_kind,
+			    const char *suggestion)
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
+			operation);
+
+	diag_print_history(env, &opts);
+
+	diag_suggestion(env, "%s", suggestion);
+}
+
 void bpf_diag_invalid_deref(struct bpf_verifier_env *env, u32 insn_idx, int regno,
 			    const char *reg_name, const struct bpf_reg_state *reg,
 			    enum bpf_diag_invalid_deref_kind kind, s64 offset)
@@ -2057,7 +2220,7 @@ static const char *diag_context_name(enum bpf_diag_context_kind kind)
 		return "lock region";
 	case BPF_DIAG_CONTEXT_NONE:
 	default:
-		return "context";
+		return "non-sleepable program";
 	}
 }
 
diff --git a/kernel/bpf/diagnostics.h b/kernel/bpf/diagnostics.h
index 4b85a7ad2019..95bc654e5b3e 100644
--- a/kernel/bpf/diagnostics.h
+++ b/kernel/bpf/diagnostics.h
@@ -80,6 +80,15 @@ void bpf_diag_leak(struct bpf_verifier_env *env, u32 ref_id, u32 alloc_insn, u32
 void bpf_diag_call_type(struct bpf_verifier_env *env, u32 insn_idx, int argno, int regno,
 			int stack_arg_slot, const char *call_name, const char *arg_name,
 			const char *reason, const char *suggestion);
+void bpf_diag_ctx_forbidden(struct bpf_verifier_env *env, u32 insn_idx,
+			    const char *operation, const char *suggestion);
+void bpf_diag_ctx_active(struct bpf_verifier_env *env, u32 insn_idx, const char *operation,
+			 enum bpf_diag_context_kind ctx_kind, const char *suggestion);
+void bpf_diag_ctx_required(struct bpf_verifier_env *env, u32 insn_idx, const char *operation,
+			   enum bpf_diag_context_kind ctx_kind, const char *suggestion);
+void bpf_diag_ctx_underflow(struct bpf_verifier_env *env, u32 insn_idx,
+			    const char *operation, enum bpf_diag_context_kind ctx_kind,
+			    const char *suggestion);
 void bpf_diag_record_branch(struct bpf_verifier_env *env, u32 insn_idx, bool cond_true);
 void bpf_diag_mod_begin(struct bpf_verifier_env *env, const struct bpf_reg_state *reg,
 			const struct bpf_reg_state *origin, enum bpf_diag_mod_reason reason);
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 2c067be53106..a81a7ed18d76 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -7740,6 +7740,9 @@ static int process_iter_arg(struct bpf_verifier_env *env, struct bpf_reg_state *
 			return err;
 		case -EPROTO:
 			verbose(env, "expected an RCU CS when using %s\n", meta->func_name);
+			bpf_diag_ctx_required(
+				env, insn_idx, meta->func_name, BPF_DIAG_CONTEXT_RCU,
+				"Wrap iterator use in bpf_rcu_read_lock() and bpf_rcu_read_unlock(), keeping all exit paths balanced.");
 			return err;
 		default:
 			return err;
@@ -9839,17 +9842,24 @@ static int check_func_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 		return err;
 	if (bpf_subprog_is_global(env, subprog)) {
 		const char *sub_name = bpf_subprog_name(env, subprog);
+		const char *operation;
 		bool returns_void;
 
 		if (env->cur_state->active_locks) {
 			verbose(env, "global function calls are not allowed while holding a lock,\n"
 				     "use static function instead\n");
+			operation = bpf_diag_fmt(env, "global function %s()", sub_name);
+			bpf_diag_ctx_active(env, *insn_idx, operation, BPF_DIAG_CONTEXT_LOCK,
+					    "Release the lock before calling the global function, or use a static function instead.");
 			return -EINVAL;
 		}
 
 		if (env->subprog_info[subprog].might_sleep && !in_sleepable_context(env)) {
 			verbose(env, "sleepable global function %s() called in %s\n",
 				sub_name, non_sleepable_context_description(env));
+			operation = bpf_diag_fmt(env, "sleepable global function %s()", sub_name);
+			bpf_diag_ctx_forbidden(env, *insn_idx, operation,
+				"Move the call outside the critical section, or use a non-sleepable function.");
 			return -EINVAL;
 		}
 
@@ -10496,6 +10506,8 @@ static int check_resource_leak(struct bpf_verifier_env *env, bool exception_exit
 
 	if (check_lock && env->cur_state->active_locks) {
 		verbose(env, "%s cannot be used inside bpf_spin_lock-ed region\n", prefix);
+		bpf_diag_ctx_active(env, env->insn_idx, prefix, BPF_DIAG_CONTEXT_LOCK,
+				    "Release the BPF spin lock before this operation on every path.");
 		return -EINVAL;
 	}
 
@@ -10507,16 +10519,23 @@ static int check_resource_leak(struct bpf_verifier_env *env, bool exception_exit
 
 	if (check_lock && env->cur_state->active_irq_id) {
 		verbose(env, "%s cannot be used inside bpf_local_irq_save-ed region\n", prefix);
+		bpf_diag_ctx_active(env, env->insn_idx, prefix, BPF_DIAG_CONTEXT_IRQ,
+				    "Restore the saved IRQ state before this operation on every path.");
 		return -EINVAL;
 	}
 
 	if (check_lock && env->cur_state->active_rcu_locks) {
 		verbose(env, "%s cannot be used inside bpf_rcu_read_lock-ed region\n", prefix);
+		bpf_diag_ctx_active(env, env->insn_idx, prefix, BPF_DIAG_CONTEXT_RCU,
+				    "Call bpf_rcu_read_unlock() before this operation on every path.");
 		return -EINVAL;
 	}
 
 	if (check_lock && env->cur_state->active_preempt_locks) {
 		verbose(env, "%s cannot be used inside bpf_preempt_disable-ed region\n", prefix);
+		bpf_diag_ctx_active(
+			env, env->insn_idx, prefix, BPF_DIAG_CONTEXT_PREEMPT,
+			"Call bpf_preempt_enable() before this operation on every path.");
 		return -EINVAL;
 	}
 
@@ -10698,6 +10717,7 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 	enum bpf_type_flag ret_flag;
 	struct bpf_reg_state *regs;
 	struct bpf_call_arg_meta meta;
+	const char *operation;
 	int insn_idx = *insn_idx_p;
 	bool changes_data;
 	int i, err, func_id;
@@ -10745,6 +10765,10 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 	if (fn->might_sleep && !in_sleepable_context(env)) {
 		verbose(env, "sleepable helper %s#%d in %s\n", func_id_name(func_id), func_id,
 			non_sleepable_context_description(env));
+		operation = bpf_diag_fmt(env, "sleepable helper %s#%d",
+					 func_id_name(func_id), func_id);
+		bpf_diag_ctx_forbidden(env, insn_idx, operation,
+			"Move the helper call outside the critical section, or use a non-sleepable helper.");
 		return -EINVAL;
 	}
 
@@ -13592,6 +13616,7 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 	const struct btf_type *t, *ptr_type;
 	struct bpf_call_arg_meta meta;
 	struct bpf_insn_aux_data *insn_aux;
+	const char *operation;
 	int err, insn_idx = *insn_idx_p;
 	u32 i, nargs, ptr_type_id;
 	struct bpf_kfunc_desc *desc;
@@ -13657,6 +13682,9 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 	sleepable = bpf_is_kfunc_sleepable(&meta);
 	if (sleepable && !in_sleepable(env)) {
 		verbose(env, "program must be sleepable to call sleepable kfunc %s\n", func_name);
+		operation = bpf_diag_fmt(env, "sleepable kfunc %s", func_name);
+		bpf_diag_ctx_forbidden(env, insn_idx, operation,
+			"Mark the program sleepable if the program type allows it, or use a non-sleepable kfunc.");
 		return -EACCES;
 	}
 
@@ -13727,6 +13755,9 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 	} else if (rcu_unlock) {
 		if (env->cur_state->active_rcu_locks == 0) {
 			verbose(env, "unmatched rcu read unlock (kernel function %s)\n", func_name);
+			bpf_diag_ctx_underflow(
+				env, insn_idx, func_name, BPF_DIAG_CONTEXT_RCU,
+				"Remove the extra bpf_rcu_read_unlock() call, or ensure this path first enters an RCU read lock region.");
 			return -EINVAL;
 		}
 		env->cur_state->active_rcu_locks--;
@@ -13741,6 +13772,9 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 	} else if (preempt_enable) {
 		if (env->cur_state->active_preempt_locks == 0) {
 			verbose(env, "unmatched attempt to enable preemption (kernel function %s)\n", func_name);
+			bpf_diag_ctx_underflow(
+				env, insn_idx, func_name, BPF_DIAG_CONTEXT_PREEMPT,
+				"Remove the extra bpf_preempt_enable() call, or ensure this path first disables preemption.");
 			return -EINVAL;
 		}
 		env->cur_state->active_preempt_locks--;
@@ -13753,6 +13787,9 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 	if (sleepable && !in_sleepable_context(env)) {
 		verbose(env, "kernel func %s is sleepable within %s\n",
 			func_name, non_sleepable_context_description(env));
+		operation = bpf_diag_fmt(env, "sleepable kfunc %s", func_name);
+		bpf_diag_ctx_forbidden(env, insn_idx, operation,
+			"Move the kfunc call outside the critical section, or use a non-sleepable kfunc.");
 		return -EACCES;
 	}
 
@@ -13763,6 +13800,9 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 
 	if (is_kfunc_rcu_protected(&meta) && !in_rcu_cs(env)) {
 		verbose(env, "kernel func %s requires RCU critical section protection\n", func_name);
+		bpf_diag_ctx_required(
+			env, insn_idx, func_name, BPF_DIAG_CONTEXT_RCU,
+			"Call this kfunc between bpf_rcu_read_lock() and bpf_rcu_read_unlock(), keeping all exit paths balanced.");
 		return -EACCES;
 	}
 
@@ -18040,6 +18080,10 @@ static int do_check_insn(struct bpf_verifier_env *env, bool *do_print_state)
 				     !kfunc_spin_allowed(env, insn->imm, insn->off))) {
 					verbose(env,
 						"function calls are not allowed while holding a lock\n");
+					bpf_diag_ctx_active(
+						env, env->insn_idx,
+						"function call", BPF_DIAG_CONTEXT_LOCK,
+						"Release the BPF spin lock before making this call, or move the call outside the locked region.");
 					return -EINVAL;
 				}
 			}
-- 
2.53.0

