Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FA01406287
	for <bpf@vger.kernel.org>; Fri,  5 Jun 2026 06:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780641271; cv=none; b=Yq0PwuvYD1t8oJBseMNrID82HYt+z2KeLRPmM7L3xbf/HwDhgJD3WXu4teAC9h572RkdExG4wx+B3ufim8BiE526Nm8EFyXNZlYTqtlHZt5UcZPeUJksRr070qkFIdUKpFTaJUcrWcngYlpAQPqIXue756woIp8TDrIUjG9026A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780641271; c=relaxed/simple;
	bh=eMkCCQrDZgDAIwp1isAdcv+2WReD2a3AQ9zyCYiM/Rs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kzP0L93OIzA/Hn/pwCY+c+KDhnHr2Zf+QXC4xVPr/u5QBD5tctAbUlobKLfRu5NBgDl8nGTpDuEf+/vWC0sXJ1fVamrYza17cfEZaexTk+G8naBcJmDDX+RtHJPsFd4cYFdS4Mir0Ne2D4WcJU7mtVzr4nKzu3r5T2pgzZ0aFSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DJerpx6U; arc=none smtp.client-ip=209.85.128.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DJerpx6U"
Received: by mail-wm1-f65.google.com with SMTP id 5b1f17b1804b1-490b613a17bso14247805e9.3
        for <bpf@vger.kernel.org>; Thu, 04 Jun 2026 23:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780641268; x=1781246068; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EG8y6/DotnQBATrVrcGAAgK6crmZ4Bw/NkoSAC90/kI=;
        b=DJerpx6UyDayUI4HlUfhKzyS+rd13dAordPxcPZXNWW17m1trSIrviVK62d9dAo9ix
         7lw/qHHHq2KAfawSUQSKCdzaNMVgpmAl1VHZf1PBkTfZa2wnm8Dtzb5Qx9gLomdrjEOZ
         nx7fUFhXNpD+Ca1uQCfQ4HaTsh2HL9GbXuKjbhzCzRr6Y0OWE+VFZ/PHX0dv5oxbJ4Ow
         2a6eiST7j0OfTO4VuPHorr4ILW5pVHLHMqp0WON8oTyEH4nhETKvVPvSh8jktJ7LswA3
         7329FzhC/B1/XCtmt0x1cGeXi3jGk+l9V7iVNgycMjwLKft2qq377fG1SgZio+f7aCtM
         XbvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780641268; x=1781246068;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EG8y6/DotnQBATrVrcGAAgK6crmZ4Bw/NkoSAC90/kI=;
        b=hjvrkA9dEhizJ4nJgVFhZOkpEJrFdx6qRp/Qt0SBPioYqFXJWkHIqS7AApgzBjshIn
         qaXGRCtU5DKbnkr2QW99F84pAloAHy93sFma4uRrTt9ANVo8w/vpRcU6ASoQQODfh9Pu
         eRIK/74B0NdV5iEyTpmVwLNf5yIM6HLknPTwVmJ04f04EzGLriuPTjtHXxMyzDyFqEGE
         fnY8AMU8LpoESHX9AXnXxqu0rfEWVJHHJaFJYjIcg18o/8BCU6qox2epEAcZ8AzEAjtB
         fCfIb3bItnjKjQ0UJhIXFysYOt7hW+orb06UHLvhLKF76HydACM2gcUsbn/wuQ4qQslj
         Dufg==
X-Gm-Message-State: AOJu0Ywy+BDoQRgcS2xZXy7qLQ1DiCU+76wuZap3WsCV5HcmsMi1EaTv
	kFu0CNiT8j2FZj7biXeKD+fZkhaSyWtjHCCzS4Op+i+4Hvvl0PfiujyD7l9mzv6c
X-Gm-Gg: Acq92OGf0QUuFM34cUTUgWYKheZqcL6ybRUvs4sHmZr6x+a4x3SGvFaLm97RWzC20SC
	UZZo+RFZB8bec59qz4WeGcE3VfdlkMG6+4SRZX+x40ipdB2lkz03kn3KFR0zRrdjZajHEjfA3vU
	8I1cwJQ9cBokZW6n6ikyH18M9X7uyiIPfrwjNaRRfnMZ9i4t0XMvgUptYmDa0MBYHdjAlrshSjX
	c7iU0tRdj9h/0wT4sJkUWEX7Rcs4CdArPIVos3HkwdtlWg4ULRjEdPEh5PnmQQG7X8G8cL+uTaY
	4NUeWZcIXdc42tSWOqTHvKPbfgw1Z8FibOOWH+c+Z6vJ7D/Tp3/4K7kJDc0LmF9k/Br3cpBDSee
	JpSJzhvOqus0oNGr9+JozYCltVoDcB7aSmvrRpPMovtFZtxE5qKZqWNe9a4iUGMcOrght7gMUqW
	/SUhooyUZ4ARW6C6lSxxBpOp8wdk7FAGMCllE4QvawEiUYlASYyEzbMOyL/yDIHwzB9cXTAs4oy
	1ywHWTXzFbylSkUh6SeiB1vUmFVRPt7f8qXW35xUZow73SMvNMMB1ZxLop08kUUQsaO/oKMPSkr
	AYSnkuFg8D8=
X-Received: by 2002:a05:600c:468a:b0:490:c2a2:e91e with SMTP id 5b1f17b1804b1-490c2a2ea2fmr25276415e9.34.1780641267944;
        Thu, 04 Jun 2026 23:34:27 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490c2c9ebeesm20223545e9.0.2026.06.04.23.34.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 23:34:27 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 12/17] bpf: Report Execution Context Safety errors
Date: Fri,  5 Jun 2026 08:34:02 +0200
Message-ID: <20260605063412.974640-13-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260605063412.974640-1-memxor@gmail.com>
References: <20260605063412.974640-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=16178; i=memxor@gmail.com; h=from:subject; bh=eMkCCQrDZgDAIwp1isAdcv+2WReD2a3AQ9zyCYiM/Rs=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIUspt2T5oswdE2vvVSqbzlSpmd8w6+6vvYEyX1cZrF4Vt mZuQNiXjlIWBjEuBlkxRZaS//uYjE9U/g60XcYNM4eVCWQIAxenAExkwVJGhjOFF7b2y0y8c2vd jea3S+pL03cc/iBis6B5HsfGmTVtL7cx/GLS+TTTwc3g6qJLj2ued/36kVXlXRP4TWTBtG5FIZ0 wHS4A
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Augment selected sleepability and critical-section failures with
Execution Context Safety reports. Keep the existing verifier messages
and add source context, path history, and suggestions tied to the
active context.

Use the context history recorded earlier to anchor causal paths to lock,
IRQ, RCU, and preempt regions instead of unrelated register updates.

Cover global calls while holding a lock, sleepable global function calls,
sleepable helpers, sleepable kfunc calls from disallowed contexts,
operations that exit while a context is still active, and unmatched
context exits.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/diagnostics.c | 153 +++++++++++++++++++++++++++++++++++++++
 kernel/bpf/diagnostics.h |  14 ++++
 kernel/bpf/verifier.c    |  89 +++++++++++++++++++++++
 3 files changed, 256 insertions(+)

diff --git a/kernel/bpf/diagnostics.c b/kernel/bpf/diagnostics.c
index 169c1a2425c8..2d8417f4efff 100644
--- a/kernel/bpf/diagnostics.c
+++ b/kernel/bpf/diagnostics.c
@@ -751,6 +751,159 @@ void bpf_diag_report_call_type(struct bpf_verifier_env *env, u32 insn_idx,
 	bpf_diag_report_suggestion(env, "%s", suggestion);
 }
 
+static const char *bpf_diag_context_constraint(enum bpf_diag_context_kind kind)
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
+static void bpf_diag_format_active_context(char *buf, size_t size, u32 depth,
+					   const char *context)
+{
+	if (depth == 1)
+		scnprintf(buf, size, "an active %s (depth 1)", context);
+	else
+		scnprintf(buf, size, "%u active %ss (depth %u)", depth,
+			  context, depth);
+}
+
+static u32 bpf_diag_context_depth(struct bpf_verifier_env *env,
+				  enum bpf_diag_context_kind kind)
+{
+	if (!env->cur_state)
+		return 0;
+
+	switch (kind) {
+	case BPF_DIAG_CONTEXT_RCU:
+		return env->cur_state->active_rcu_locks;
+	case BPF_DIAG_CONTEXT_PREEMPT:
+		return env->cur_state->active_preempt_locks;
+	case BPF_DIAG_CONTEXT_IRQ:
+		return env->cur_state->active_irq_id ? 1 : 0;
+	case BPF_DIAG_CONTEXT_LOCK:
+		return env->cur_state->active_locks;
+	case BPF_DIAG_CONTEXT_NONE:
+	default:
+		return 0;
+	}
+}
+
+void bpf_diag_report_execution_context(struct bpf_verifier_env *env,
+				       u32 insn_idx, const char *operation,
+				       enum bpf_diag_context_kind ctx_kind,
+				       const char *context,
+				       const char *suggestion)
+{
+	struct bpf_diag_history_opts opts = {
+		.scope = BPF_DIAG_HISTORY_SCOPE_CONTEXT,
+		.ctx_kind = ctx_kind,
+	};
+	u32 depth = bpf_diag_context_depth(env, ctx_kind);
+	char depth_buf[80];
+
+	bpf_diag_report_header(env, BPF_DIAG_CATEGORY_EXECUTION_CONTEXT_SAFETY,
+			       "operation is not allowed in this context");
+	if (bpf_diag_context_constraint(ctx_kind)) {
+		if (depth) {
+			bpf_diag_format_active_context(depth_buf,
+						       sizeof(depth_buf),
+						       depth, context);
+			bpf_diag_report_reason(env,
+					       "The operation %s cannot be used in %s because %s. This path is still inside %s.",
+					       operation, context,
+					       bpf_diag_context_constraint(ctx_kind),
+					       depth_buf);
+		} else {
+			bpf_diag_report_reason(env,
+					       "The operation %s cannot be used in %s because %s.",
+					       operation, context,
+					       bpf_diag_context_constraint(ctx_kind));
+		}
+	} else {
+		bpf_diag_report_reason(env,
+				       "The operation %s cannot be used in %s.",
+				       operation, context);
+	}
+
+	bpf_diag_report_section(env, "At");
+	bpf_diag_report_source(env, insn_idx, '!',
+			       "%s is not allowed in %s", operation, context);
+
+	if (ctx_kind != BPF_DIAG_CONTEXT_NONE)
+		bpf_diag_print_history(env, &opts);
+
+	bpf_diag_report_suggestion(env, "%s", suggestion);
+}
+
+void bpf_diag_report_context_still_active(struct bpf_verifier_env *env,
+					  u32 insn_idx, const char *operation,
+					  enum bpf_diag_context_kind ctx_kind,
+					  const char *context,
+					  const char *suggestion)
+{
+	struct bpf_diag_history_opts opts = {
+		.scope = BPF_DIAG_HISTORY_SCOPE_CONTEXT,
+		.ctx_kind = ctx_kind,
+	};
+	u32 depth = bpf_diag_context_depth(env, ctx_kind);
+	char depth_buf[80];
+
+	bpf_diag_format_active_context(depth_buf, sizeof(depth_buf), depth,
+				       context);
+
+	bpf_diag_report_header(env, BPF_DIAG_CATEGORY_EXECUTION_CONTEXT_SAFETY,
+			       "operation is not allowed in this context");
+	bpf_diag_report_reason(env,
+			       "The operation %s cannot be used while this path is still inside %s. Leave the region before this operation.",
+			       operation, depth_buf);
+
+	bpf_diag_report_section(env, "At");
+	bpf_diag_report_source(env, insn_idx, '!',
+			       "%s is not allowed before leaving %s",
+			       operation, context);
+
+	bpf_diag_print_history(env, &opts);
+
+	bpf_diag_report_suggestion(env, "%s", suggestion);
+}
+
+void bpf_diag_report_context_underflow(struct bpf_verifier_env *env,
+				       u32 insn_idx, const char *operation,
+				       enum bpf_diag_context_kind ctx_kind,
+				       const char *suggestion)
+{
+	struct bpf_diag_history_opts opts = {
+		.scope = BPF_DIAG_HISTORY_SCOPE_CONTEXT,
+		.ctx_kind = ctx_kind,
+	};
+	const char *context = bpf_diag_context_name(ctx_kind);
+
+	bpf_diag_report_header(env, BPF_DIAG_CATEGORY_EXECUTION_CONTEXT_SAFETY,
+			       "unmatched context exit");
+	bpf_diag_report_reason(env,
+			       "The operation %s tries to leave %s, but this path has no active %s to leave. The current depth is 0.",
+			       operation, context, context);
+
+	bpf_diag_report_section(env, "At");
+	bpf_diag_report_source(env, insn_idx, '!',
+			       "%s has no matching enter on this path",
+			       operation);
+
+	bpf_diag_print_history(env, &opts);
+
+	bpf_diag_report_suggestion(env, "%s", suggestion);
+}
 void bpf_diag_report_invalid_deref(struct bpf_verifier_env *env, u32 insn_idx,
 				   int regno, const char *reg_name,
 				   const char *type_name,
diff --git a/kernel/bpf/diagnostics.h b/kernel/bpf/diagnostics.h
index d8c433759dee..e11abc30246d 100644
--- a/kernel/bpf/diagnostics.h
+++ b/kernel/bpf/diagnostics.h
@@ -185,6 +185,20 @@ void bpf_diag_report_call_type(struct bpf_verifier_env *env, u32 insn_idx,
 			       int regno, const char *call_name,
 			       const char *arg_name, const char *reason,
 			       const char *suggestion);
+void bpf_diag_report_execution_context(struct bpf_verifier_env *env,
+				       u32 insn_idx, const char *operation,
+				       enum bpf_diag_context_kind ctx_kind,
+				       const char *context,
+				       const char *suggestion);
+void bpf_diag_report_context_still_active(struct bpf_verifier_env *env,
+					  u32 insn_idx, const char *operation,
+					  enum bpf_diag_context_kind ctx_kind,
+					  const char *context,
+					  const char *suggestion);
+void bpf_diag_report_context_underflow(struct bpf_verifier_env *env,
+				       u32 insn_idx, const char *operation,
+				       enum bpf_diag_context_kind ctx_kind,
+				       const char *suggestion);
 
 void bpf_diag_clear_history(struct bpf_verifier_state *state);
 void bpf_diag_copy_history(struct bpf_verifier_state *dst,
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index d2a776d2059c..e30d79149cc7 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -211,6 +211,9 @@ static int ref_set_non_owning(struct bpf_verifier_env *env,
 static bool is_trusted_reg(struct bpf_verifier_env *env, const struct bpf_reg_state *reg);
 static inline bool in_sleepable_context(struct bpf_verifier_env *env);
 static const char *non_sleepable_context_description(struct bpf_verifier_env *env);
+static enum bpf_diag_context_kind
+non_sleepable_context_kind(struct bpf_verifier_env *env);
+static const char *non_sleepable_context_diag_description(struct bpf_verifier_env *env);
 static void scalar32_min_max_add(struct bpf_reg_state *dst_reg, struct bpf_reg_state *src_reg);
 static void scalar_min_max_add(struct bpf_reg_state *dst_reg, struct bpf_reg_state *src_reg);
 
@@ -9698,16 +9701,31 @@ static int check_func_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 		return err;
 	if (bpf_subprog_is_global(env, subprog)) {
 		const char *sub_name = subprog_name(env, subprog);
+		char operation[96];
 
 		if (env->cur_state->active_locks) {
 			verbose(env, "global function calls are not allowed while holding a lock,\n"
 				     "use static function instead\n");
+			scnprintf(operation, sizeof(operation),
+				  "global function %s()", sub_name);
+			bpf_diag_report_execution_context(env, *insn_idx,
+							  operation,
+							  BPF_DIAG_CONTEXT_LOCK,
+							  "lock region",
+							  "Release the lock before calling the global function, or use a static function instead.");
 			return -EINVAL;
 		}
 
 		if (env->subprog_info[subprog].might_sleep && !in_sleepable_context(env)) {
 			verbose(env, "sleepable global function %s() called in %s\n",
 				sub_name, non_sleepable_context_description(env));
+			scnprintf(operation, sizeof(operation),
+				  "sleepable global function %s()", sub_name);
+			bpf_diag_report_execution_context(env, *insn_idx,
+							  operation,
+							  non_sleepable_context_kind(env),
+							  non_sleepable_context_diag_description(env),
+							  "Move the call outside the critical section, or use a non-sleepable function.");
 			return -EINVAL;
 		}
 
@@ -10285,6 +10303,10 @@ static int check_resource_leak(struct bpf_verifier_env *env, bool exception_exit
 
 	if (check_lock && env->cur_state->active_locks) {
 		verbose(env, "%s cannot be used inside bpf_spin_lock-ed region\n", prefix);
+		bpf_diag_report_context_still_active(env, env->insn_idx, prefix,
+						     BPF_DIAG_CONTEXT_LOCK,
+						     "lock region",
+						     "Release the BPF spin lock before this operation on every path.");
 		return -EINVAL;
 	}
 
@@ -10296,16 +10318,28 @@ static int check_resource_leak(struct bpf_verifier_env *env, bool exception_exit
 
 	if (check_lock && env->cur_state->active_irq_id) {
 		verbose(env, "%s cannot be used inside bpf_local_irq_save-ed region\n", prefix);
+		bpf_diag_report_context_still_active(env, env->insn_idx, prefix,
+						     BPF_DIAG_CONTEXT_IRQ,
+						     "IRQ-disabled region",
+						     "Restore the saved IRQ state before this operation on every path.");
 		return -EINVAL;
 	}
 
 	if (check_lock && env->cur_state->active_rcu_locks) {
 		verbose(env, "%s cannot be used inside bpf_rcu_read_lock-ed region\n", prefix);
+		bpf_diag_report_context_still_active(env, env->insn_idx, prefix,
+						     BPF_DIAG_CONTEXT_RCU,
+						     "RCU read lock region",
+						     "Call bpf_rcu_read_unlock() before this operation on every path.");
 		return -EINVAL;
 	}
 
 	if (check_lock && env->cur_state->active_preempt_locks) {
 		verbose(env, "%s cannot be used inside bpf_preempt_disable-ed region\n", prefix);
+		bpf_diag_report_context_still_active(env, env->insn_idx, prefix,
+						     BPF_DIAG_CONTEXT_PREEMPT,
+						     "non-preemptible region",
+						     "Call bpf_preempt_enable() before this operation on every path.");
 		return -EINVAL;
 	}
 
@@ -10456,6 +10490,37 @@ static const char *non_sleepable_context_description(struct bpf_verifier_env *en
 	return "non-sleepable prog";
 }
 
+static enum bpf_diag_context_kind
+non_sleepable_context_kind(struct bpf_verifier_env *env)
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
@@ -10484,6 +10549,7 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 	enum bpf_type_flag ret_flag;
 	struct bpf_reg_state *regs;
 	struct bpf_call_arg_meta meta;
+	char operation[96];
 	int insn_idx = *insn_idx_p;
 	bool changes_data;
 	int i, err, func_id;
@@ -10532,6 +10598,12 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 	if (fn->might_sleep && !in_sleepable_context(env)) {
 		verbose(env, "sleepable helper %s#%d in %s\n", func_id_name(func_id), func_id,
 			non_sleepable_context_description(env));
+		scnprintf(operation, sizeof(operation), "sleepable helper %s#%d",
+			  func_id_name(func_id), func_id);
+		bpf_diag_report_execution_context(env, insn_idx, operation,
+						  non_sleepable_context_kind(env),
+						  non_sleepable_context_diag_description(env),
+						  "Move the helper call outside the critical section, or use a non-sleepable helper.");
 		return -EINVAL;
 	}
 
@@ -13414,6 +13486,7 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 	const struct btf_type *t, *ptr_type;
 	struct bpf_kfunc_call_arg_meta meta;
 	struct bpf_insn_aux_data *insn_aux;
+	char operation[96];
 	int err, insn_idx = *insn_idx_p;
 	u32 i, nargs, ptr_type_id, id;
 	const struct btf_param *args;
@@ -13472,6 +13545,12 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 	sleepable = bpf_is_kfunc_sleepable(&meta);
 	if (sleepable && !in_sleepable(env)) {
 		verbose(env, "program must be sleepable to call sleepable kfunc %s\n", func_name);
+		scnprintf(operation, sizeof(operation), "sleepable kfunc %s",
+			  func_name);
+		bpf_diag_report_execution_context(env, insn_idx, operation,
+						  BPF_DIAG_CONTEXT_NONE,
+						  "non-sleepable program",
+						  "Mark the program sleepable if the program type allows it, or use a non-sleepable kfunc.");
 		return -EACCES;
 	}
 
@@ -13533,6 +13612,10 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 	} else if (rcu_unlock) {
 		if (env->cur_state->active_rcu_locks == 0) {
 			verbose(env, "unmatched rcu read unlock (kernel function %s)\n", func_name);
+			bpf_diag_report_context_underflow(env, insn_idx,
+							  func_name,
+							  BPF_DIAG_CONTEXT_RCU,
+							  "Remove the extra bpf_rcu_read_unlock() call, or ensure this path first enters an RCU read lock region.");
 			return -EINVAL;
 		}
 		env->cur_state->active_rcu_locks--;
@@ -13560,6 +13643,12 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 	if (sleepable && !in_sleepable_context(env)) {
 		verbose(env, "kernel func %s is sleepable within %s\n",
 			func_name, non_sleepable_context_description(env));
+		scnprintf(operation, sizeof(operation), "sleepable kfunc %s",
+			  func_name);
+		bpf_diag_report_execution_context(env, insn_idx, operation,
+						  non_sleepable_context_kind(env),
+						  non_sleepable_context_diag_description(env),
+						  "Move the kfunc call outside the critical section, or use a non-sleepable kfunc.");
 		return -EACCES;
 	}
 
-- 
2.53.0

