Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C43EE3CA4BF
	for <bpf@vger.kernel.org>; Fri, 19 Jun 2026 20:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781902801; cv=none; b=IzrapS8HKtrzMjsk2NeTlZ/dxi6MUipuLQ9ByEzHqRYRZaS+A+teIyoxnaCjfYxQN7HQdwTKQ9ypDW0O9mnvZyf4hSJ76sNFXYRwbKofs4al5dK3H+sGl+2SDt6NzYT/bzvzkOXvHJ4gU+6OqMujk01QyTId7taPNzvhp+nfzxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781902801; c=relaxed/simple;
	bh=X4zZ0A+WulpUz+H9Nv34NTI/CoqIhc9Xk2vPudrHgcs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=abztwKdK73Wbb51l5L3dBMDNw3COVT9YMT9727W7MK/6c8pTemu/dN93cuB9wIHpWL+/rao+Eo9jBCWz0FkQ5PsphmD51N1K92gUxkF3apadPranVi3l84stdBWgpTKCsNHGLw5DHkD/XrK1DvEMJfZjIq9BfKQ76YDanKKxXfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g4xe8MYv; arc=none smtp.client-ip=209.85.128.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g4xe8MYv"
Received: by mail-wm1-f67.google.com with SMTP id 5b1f17b1804b1-490b613a17bso19880655e9.3
        for <bpf@vger.kernel.org>; Fri, 19 Jun 2026 13:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781902788; x=1782507588; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c0kYB1vzltmnAyR8MEKXJvOHykyuxV3zDthJmaMy6PY=;
        b=g4xe8MYvRk0LINz+l24kpzkroCwT0Rvp9L0qZOE500cXUtML/VG+eA4DPh9UKLodk+
         tjUTZPOn3+rHvnkWcGh6r1MYybDj1c0dfWJbirV//+LZkvCQ81ZkJoAuy/KykSwMg/k+
         CPTNHF47gQc1tF4lO+NpFQAhnqNLPGGLwuzAbg3pGj4QvG+Bv5Prj1u5Lxg75Sv1LwW1
         UnSjr6WjwXE4+1ao4kQKt/P/bxFRTSQvQ45FegmdLigEWt6M82KTBlOHuhCgxcF+DuVC
         IsVod4QaUPnenlOQmESir4oCTmDd8f2piC9q/gJY0DJVXXpSfbvwmAR0mM326U3PHB5B
         MLwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781902788; x=1782507588;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=c0kYB1vzltmnAyR8MEKXJvOHykyuxV3zDthJmaMy6PY=;
        b=p3TGt81JRNAoAMrkciDymbCi8zD7ukeb7T7uCQ8CmY80wLQXH18pbRwqnBjbFiB8m+
         2cgdCfndAdUYTWHTPPFeeubzpMlYNdRcx8iGJOpdr+Ecn8qcqFz0jZqVfQcJb+pwV6mS
         xKwAceFzY9LfUqIV3PknAc3hjAATpTuFVS9F6YtnYB0HEmZqOhWTW94oJAG4AHwfYl10
         6T+LniS4zBOidYFnSMi729+JVl9NU8Ow0p3z53v3o/BDX+jjJare5cACWTjshE8FjnrK
         BQHXW39Lu+E7cCyMQ7SU75w/vCf0lDPLihDnZ7AY+SV5QXUjYt34ZXyaZUyiG72xbrzS
         yoTQ==
X-Gm-Message-State: AOJu0Yy2C0snLjgED+/boMBbA8N+eFuRmbBkEczJKuk2/EfTUuB5CFcu
	ZEFTKEfOJKHO64SJzwxwphSEDSTqE/MqrAiGWpgyx7L6274mcLEmeClNR0zhHGk2
X-Gm-Gg: AfdE7cmyee2BBn2hov/ozEyD5nYl+AxIvxhHRo0A832paJ9fmhLdPQL8AwRjmIlj6ym
	Omz7Pj+f7xIpxf+2dmUet2nd4yWq84A1CHZgh/JGChOBzvFJp42BvG+fChPlEfk8OINGGJS7Tya
	+7kNQoFuh9luNcW/h5ksHXwUmf5nzsKrfiVz8HL66x0OnlGbKva+ycXmFkKq4zczMSvwbOhhM54
	/SVXDf0WtKSgap/4QP9Bglqk8M6X+CEeEZGlh14OLFOHltLSEjjK/G2nJ577687xMTXwY/tI93O
	wZ3/GlTgs8XB+weSf/1ISZEam4CJLkv1+pnHp/4HtbPF/tNTIwYwXjVzoK9tW8WfolRPTm6zzoV
	h06bzAfMC9g1WcgDSHpdf0bg0wk7C+W9IGVtacELbrK2UVuFDf6mndGmdkmx1AF83xwif8zolVG
	/alCwCtD74lg6I+n8JzE1AYhGSjk5aJZ/AqCgf6r5E36CatyWIGgY5zbBlShDrkrv4S9DG504rO
	rnwf544u6kvzZds+jg3wYCDabVD51ACitdMDx1AkBMSFy5/dmuyTzE=
X-Received: by 2002:a05:600c:6211:b0:492:32f3:a344 with SMTP id 5b1f17b1804b1-492490af5f0mr12819065e9.31.1781902787611;
        Fri, 19 Jun 2026 13:59:47 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46666788226sm1898179f8f.23.2026.06.19.13.59.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2026 13:59:47 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v2 12/17] bpf: Report Execution Context Safety errors
Date: Fri, 19 Jun 2026 22:59:25 +0200
Message-ID: <20260619205934.1312876-13-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260619205934.1312876-1-memxor@gmail.com>
References: <20260619205934.1312876-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=18306; i=memxor@gmail.com; h=from:subject; bh=X4zZ0A+WulpUz+H9Nv34NTI/CoqIhc9Xk2vPudrHgcs=; b=kA0DAAoWRy03e2NUL4MByyZiAGo1qgCh7v5F3MAas8B1ORUaLXY3P7CX9ALVISWQ3eiMj73FV 4h1BAAWCgAdFiEEdP++AjPIeftRPaYLRy03e2NUL4MFAmo1qgAACgkQRy03e2NUL4NfSQD/ae3s /O/i8HAbJTCmB+/Sq3kZies8tK6XyWraDEi3J0EBAK8b8In0iCeUDVWPdaz1K0FKdLq6ywGpGfQ 5FXKhZQ0M
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
 kernel/bpf/diagnostics.c | 165 +++++++++++++++++++++++++++++++++++++++
 kernel/bpf/diagnostics.h |  14 ++++
 kernel/bpf/verifier.c    | 114 +++++++++++++++++++++++++++
 3 files changed, 293 insertions(+)

diff --git a/kernel/bpf/diagnostics.c b/kernel/bpf/diagnostics.c
index 19e72b07afc1..7c903e502973 100644
--- a/kernel/bpf/diagnostics.c
+++ b/kernel/bpf/diagnostics.c
@@ -844,6 +844,7 @@ static u32 bpf_diag_current_frameno(const struct bpf_verifier_env *env)
 }
 
 static int bpf_diag_stack_argno(u8 slot);
+static const char *bpf_diag_context_name(enum bpf_diag_context_kind kind);
 
 void bpf_diag_report_register_type(struct bpf_verifier_env *env,
 				   u32 insn_idx, int regno,
@@ -953,6 +954,170 @@ void bpf_diag_report_call_type(struct bpf_verifier_env *env, u32 insn_idx,
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
+	u32 depth = bpf_diag_context_depth(env, ctx_kind);
+	struct bpf_diag_history_opts opts = {
+		.scope = BPF_DIAG_HISTORY_SCOPE_CONTEXT,
+		.ctx_kind = ctx_kind,
+		.ctx_depth = depth,
+	};
+	const char *depth_buf;
+
+	bpf_diag_report_header(env, BPF_DIAG_CATEGORY_EXECUTION_CONTEXT_SAFETY,
+			       "operation is not allowed in this context");
+	if (bpf_diag_context_constraint(ctx_kind)) {
+		if (depth) {
+			depth_buf = bpf_diag_scratch_buf(env,
+							 2,
+							 NULL);
+			if (depth_buf)
+				bpf_diag_format_active_context((char *)depth_buf,
+							       BPF_DIAG_SCRATCH_STR_LEN,
+							       depth, context);
+			else
+				depth_buf = "";
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
+	bpf_diag_report_source(env, insn_idx, "error",
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
+	u32 depth = bpf_diag_context_depth(env, ctx_kind);
+	struct bpf_diag_history_opts opts = {
+		.scope = BPF_DIAG_HISTORY_SCOPE_CONTEXT,
+		.ctx_kind = ctx_kind,
+		.ctx_depth = depth,
+	};
+	const char *depth_buf;
+
+	depth_buf = bpf_diag_scratch_buf(env, 2, NULL);
+	if (depth_buf)
+		bpf_diag_format_active_context((char *)depth_buf,
+					       BPF_DIAG_SCRATCH_STR_LEN, depth,
+					       context);
+	else
+		depth_buf = "";
+
+	bpf_diag_report_header(env, BPF_DIAG_CATEGORY_EXECUTION_CONTEXT_SAFETY,
+			       "operation is not allowed in this context");
+	bpf_diag_report_reason(env,
+			       "The operation %s cannot be used while this path is still inside %s. Leave the region before this operation.",
+			       operation, depth_buf);
+
+	bpf_diag_report_section(env, "At");
+	bpf_diag_report_source(env, insn_idx, "error",
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
+	bpf_diag_report_source(env, insn_idx, "error",
+			       "%s has no matching enter on this path",
+			       operation);
+
+	bpf_diag_print_history(env, &opts);
+
+	bpf_diag_report_suggestion(env, "%s", suggestion);
+}
+
 void bpf_diag_report_invalid_deref(struct bpf_verifier_env *env, u32 insn_idx,
 				   int regno, const char *reg_name,
 				   const char *type_name,
diff --git a/kernel/bpf/diagnostics.h b/kernel/bpf/diagnostics.h
index 07d06d366f22..4611d94e7a18 100644
--- a/kernel/bpf/diagnostics.h
+++ b/kernel/bpf/diagnostics.h
@@ -202,6 +202,20 @@ void bpf_diag_report_call_type(struct bpf_verifier_env *env, u32 insn_idx,
 			       int argno, int regno, int stack_arg_slot,
 			       const char *call_name, const char *arg_name,
 			       const char *reason, const char *suggestion);
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
 void bpf_diag_record_branch(struct bpf_verifier_env *env, u32 insn_idx,
 			    bool cond_true);
 void bpf_diag_record_reg_mod(struct bpf_verifier_env *env, u32 insn_idx,
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index fdbf92bffc17..3174e12bea9a 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -215,6 +215,10 @@ static int ref_set_non_owning(struct bpf_verifier_env *env,
 static bool is_trusted_reg(struct bpf_verifier_env *env, const struct bpf_reg_state *reg);
 static inline bool in_sleepable_context(struct bpf_verifier_env *env);
 static const char *non_sleepable_context_description(struct bpf_verifier_env *env);
+static enum bpf_diag_context_kind
+non_sleepable_context_kind(struct bpf_verifier_env *env);
+static const char *
+non_sleepable_context_diag_description(struct bpf_verifier_env *env);
 static void scalar32_min_max_add(struct bpf_reg_state *dst_reg, struct bpf_reg_state *src_reg);
 static void scalar_min_max_add(struct bpf_reg_state *dst_reg, struct bpf_reg_state *src_reg);
 
@@ -9914,17 +9918,38 @@ static int check_func_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 	if (err == -EFAULT)
 		return err;
 	if (bpf_subprog_is_global(env, subprog)) {
+		const char *context;
 		const char *sub_name = subprog_name(env, subprog);
+		const char *operation;
 
 		if (env->cur_state->active_locks) {
 			verbose(env, "global function calls are not allowed while holding a lock,\n"
 				     "use static function instead\n");
+			operation = bpf_diag_scratch_printf(env,
+							    1,
+							    "global function %s()",
+							    sub_name);
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
+			context = non_sleepable_context_diag_description(env);
+			operation = bpf_diag_scratch_printf(env,
+							    1,
+							    "sleepable global function %s()",
+							    sub_name);
+			bpf_diag_report_execution_context(env, *insn_idx,
+							  operation,
+							  non_sleepable_context_kind(env),
+							  context,
+							  "Move the call outside the critical section, or use a non-sleepable function.");
 			return -EINVAL;
 		}
 
@@ -10527,6 +10552,10 @@ static int check_resource_leak(struct bpf_verifier_env *env, bool exception_exit
 
 	if (check_lock && env->cur_state->active_locks) {
 		verbose(env, "%s cannot be used inside bpf_spin_lock-ed region\n", prefix);
+		bpf_diag_report_context_still_active(env, env->insn_idx, prefix,
+						     BPF_DIAG_CONTEXT_LOCK,
+						     "lock region",
+						     "Release the BPF spin lock before this operation on every path.");
 		return -EINVAL;
 	}
 
@@ -10538,16 +10567,28 @@ static int check_resource_leak(struct bpf_verifier_env *env, bool exception_exit
 
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
 
@@ -10701,6 +10742,38 @@ static const char *non_sleepable_context_description(struct bpf_verifier_env *en
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
+static const char *
+non_sleepable_context_diag_description(struct bpf_verifier_env *env)
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
@@ -10730,6 +10803,7 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 	struct bpf_reg_state old_r0;
 	struct bpf_reg_state *regs;
 	struct bpf_call_arg_meta meta;
+	const char *operation;
 	int insn_idx = *insn_idx_p;
 	bool changes_data;
 	int i, err, func_id;
@@ -10778,6 +10852,15 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 	if (fn->might_sleep && !in_sleepable_context(env)) {
 		verbose(env, "sleepable helper %s#%d in %s\n", func_id_name(func_id), func_id,
 			non_sleepable_context_description(env));
+		operation = bpf_diag_scratch_printf(env,
+						    1,
+						    "sleepable helper %s#%d",
+						    func_id_name(func_id),
+						    func_id);
+		bpf_diag_report_execution_context(env, insn_idx, operation,
+						  non_sleepable_context_kind(env),
+						  non_sleepable_context_diag_description(env),
+						  "Move the helper call outside the critical section, or use a non-sleepable helper.");
 		return -EINVAL;
 	}
 
@@ -13615,6 +13698,7 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 	struct bpf_kfunc_call_arg_meta meta;
 	struct bpf_insn_aux_data *insn_aux;
 	struct bpf_reg_state old_r0;
+	const char *operation;
 	int err, insn_idx = *insn_idx_p;
 	const struct btf_param *args;
 	u32 i, nargs, ptr_type_id;
@@ -13674,6 +13758,14 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 	sleepable = bpf_is_kfunc_sleepable(&meta);
 	if (sleepable && !in_sleepable(env)) {
 		verbose(env, "program must be sleepable to call sleepable kfunc %s\n", func_name);
+		operation = bpf_diag_scratch_printf(env,
+						    1,
+						    "sleepable kfunc %s",
+						    func_name);
+		bpf_diag_report_execution_context(env, insn_idx, operation,
+						  BPF_DIAG_CONTEXT_NONE,
+						  "non-sleepable program",
+						  "Mark the program sleepable if the program type allows it, or use a non-sleepable kfunc.");
 		return -EACCES;
 	}
 
@@ -13749,6 +13841,10 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
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
@@ -13764,6 +13860,10 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 	} else if (preempt_enable) {
 		if (env->cur_state->active_preempt_locks == 0) {
 			verbose(env, "unmatched attempt to enable preemption (kernel function %s)\n", func_name);
+			bpf_diag_report_context_underflow(env, insn_idx,
+							  func_name,
+							  BPF_DIAG_CONTEXT_PREEMPT,
+							  "Remove the extra bpf_preempt_enable() call, or ensure this path first disables preemption.");
 			return -EINVAL;
 		}
 		env->cur_state->active_preempt_locks--;
@@ -13775,6 +13875,14 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 	if (sleepable && !in_sleepable_context(env)) {
 		verbose(env, "kernel func %s is sleepable within %s\n",
 			func_name, non_sleepable_context_description(env));
+		operation = bpf_diag_scratch_printf(env,
+						    1,
+						    "sleepable kfunc %s",
+						    func_name);
+		bpf_diag_report_execution_context(env, insn_idx, operation,
+						  non_sleepable_context_kind(env),
+						  non_sleepable_context_diag_description(env),
+						  "Move the kfunc call outside the critical section, or use a non-sleepable kfunc.");
 		return -EACCES;
 	}
 
@@ -18121,6 +18229,12 @@ static int do_check_insn(struct bpf_verifier_env *env, bool *do_print_state)
 				     (insn->off != 0 || !kfunc_spin_allowed(insn->imm)))) {
 					verbose(env,
 						"function calls are not allowed while holding a lock\n");
+					bpf_diag_report_context_still_active(env,
+									     env->insn_idx,
+									     "function call",
+									     BPF_DIAG_CONTEXT_LOCK,
+									     "lock region",
+									     "Release the BPF spin lock before making this call, or move the call outside the locked region.");
 					return -EINVAL;
 				}
 			}
-- 
2.53.0

