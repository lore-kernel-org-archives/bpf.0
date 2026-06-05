Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com [209.85.221.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56E93409E0A
	for <bpf@vger.kernel.org>; Fri,  5 Jun 2026 06:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780641266; cv=none; b=DziECPDJMHb+rBv6aSuS1N5n+uYLfYZ3lhcXLAp2IOE5+TeQ+dXQ3+GzITsk+6Snnnwp8eIT89KR8ucdcXV5XYvsr7TWV/J4zgFfT1JJI4Q6L5AUsEfkUFV6ZXgmCqt48FpZgCkFsmFU3V5q+H7vpRyU+WLLKNYadulGDnj9pbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780641266; c=relaxed/simple;
	bh=aQXBB1pzfgXwNopsh1jiSt1X8bTXCyudiLSmnR3x8mM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X4Nkwliw59+e4r2IZWUJqsXwIUrf8RCwfAXt4n7/JuDhO8HM+DDIzYk44cmEeWLlrJKysQQQGBuYUo+bq9MZN6xh4x8j4Jyz+9zy4ZUT25f1FOsBiXx7REPBgIo9A4UuAQHqgt+iManoS0CYxhbaKBReSvi4H4kYO13fAQHY7T0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pv9dOY6J; arc=none smtp.client-ip=209.85.221.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pv9dOY6J"
Received: by mail-wr1-f65.google.com with SMTP id ffacd0b85a97d-45eec22fab7so780458f8f.3
        for <bpf@vger.kernel.org>; Thu, 04 Jun 2026 23:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780641263; x=1781246063; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fEsJZ9ZNGv/o/P60cUhTdIkEPNdL3wmF+nLUpxGXSHs=;
        b=pv9dOY6JZQQ2askhi47srzX/1FybzxGXjQfnuFFs+8HV1Gi8q4C9zGORHlHfUROcuP
         r0yCdYTMuVp/AggGpqWYbErijOrUYL0RE7deoQ+GWQOXupLBjrYR061R/AdAcPJNNqhn
         wg07NkOVEYMo03S5nu+HZAWvuIabS/YxHzLSDtKmeOxBEaL5zR7NnKyDFoEwF2VhXdot
         42ZkMWy84MEKXQ++rd3p42QJm/ehIzDMIAINyXXPhsGig+2pT7E//7qe77SL11JZiGUG
         if2b4h7IJB+JBKqbwMecORBErD0judyiftZZMQF53CsgFLWKK8/Fct0OD4DQwrH8JOA8
         I6aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780641263; x=1781246063;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fEsJZ9ZNGv/o/P60cUhTdIkEPNdL3wmF+nLUpxGXSHs=;
        b=E3sCRvKrfak1382f4JOtVtFqCfTosehO6eRpxXSve2D1WsJxlR9OtxdJi+SDbALH0i
         lEeI1KW8VD8oMHIZe+9Vj+FMHydVU8gw2QW7UJj9ZLH5PPht8P8Pe1VrpfTiFE6oGLAq
         0xvUEqeYTphzRvEAYvsGjaN6rC4SBpAN2O5y7UJa7NH8GBm3yYqdc7MoVUX0BNUZS1HY
         x1wzhFVSMfSDLpPdX2Gh9LQWN8csveK1GFGQhLUUMhAepnrltlDjA7AYHxrYKdv96HIW
         eTcMbW/TxDLC2kW52DOFFHh7BjjhUr45wYRAfbsEmkRF7Yz3zqvHh/2e0qMZdevNohds
         HpEA==
X-Gm-Message-State: AOJu0YwykUFXgsBedlDeub0iLGYYvOPLVkknMGEfJFN9p5vLNBsYmQTw
	yjs5410tjK0lAIvNWAE3vAkSKlTb5qWQXE37UfAJQ1yZcjJbnKQZFcwmoWNXcE2u
X-Gm-Gg: Acq92OFgxf93tesgouRSBiLbbXhdCaegBh9GhLmVrz78Ql6yPoNE2+gCYM/Xf6euthI
	wWlrcRa1lIpyuAPonf87lqhKrjDtiF42cJLvUY3MJYUy5xxxO8X3vVGLYT3yW8pSyXQqTXhqrTr
	F6wuz1cufdqMSD2dCnYyuUJdDrs/xMN0PYOqkI3oX/MuiQ6GgPp/qLWrMxShNJ+GFhWR48uWCuQ
	AGp6cg9gmEqjrv0n05Y7ujugEi9mbrnKBhgBE2JE+jH9g1e5TKco/fGJWpuntg6+r7ZabjPSmXz
	dRQVsg5XSRj8LEGLwvQAhVbn3i486iv+1GeExZCWoysfhxXS0/lTXaasNzJyqCea2gxw0M2NJqD
	5418KvICgpzCpGiHMR6DYwbTDV8GKi06A2epebxfRUdIJlaNaxzn7h2qlbgjYTeLGa+VDgYpXbN
	qr9JPK3G8G4Wg80XfjGh0K0UnWTLP31cATcHI7JkTZRYnqxkhVi7EwirDyRIPXfGo3oSoRQHE2N
	WXaCz8VVg2YsorxB6bXUzW8AjPiyY6qiJyUcImu+m/+RDAY7iwJCtmsT1YRWvJAyxCCs0qVOj3J
X-Received: by 2002:a05:600c:314e:b0:490:a29b:e72f with SMTP id 5b1f17b1804b1-490c25898d8mr30873045e9.4.1780641262166;
        Thu, 04 Jun 2026 23:34:22 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490c2d4891csm18250085e9.1.2026.06.04.23.34.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 23:34:21 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 08/17] bpf: Report Register Type Safety errors
Date: Fri,  5 Jun 2026 08:33:58 +0200
Message-ID: <20260605063412.974640-9-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260605063412.974640-1-memxor@gmail.com>
References: <20260605063412.974640-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=23516; i=memxor@gmail.com; h=from:subject; bh=aQXBB1pzfgXwNopsh1jiSt1X8bTXCyudiLSmnR3x8mM=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIUspt3jWYemdm254l3on/pc4q93DaBchVlsvrtNqabi6M 1JgQ15HKQuDGBeDrJgiS8n/fUzGJyp/B9ou44aZw8oEMoSBi1MAJtKkycjwU6L5eUdG9Oedwc8m 5XgcjXpbYXTlVeNczmNT/onNZfnxiZFhvx7rnucfz20Uk19t8WeV0s4N1Rc9mTSnGneXmPdyH5b lAgA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Augment selected register-state verifier failures with Register Type
Safety reports. The existing verbose verifier messages remain in place;
the new reports add reason, source context, causal path, and
suggestions.

Cover invalid pointer dereferences, unreadable registers, and missing
outgoing stack arguments for bpf2bpf calls. Use register-scoped history
so reports start from the latest relevant value change and then show
later branch outcomes.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/diagnostics.c | 254 +++++++++++++++++++++++++++++++++++++++
 kernel/bpf/diagnostics.h |  22 ++++
 kernel/bpf/verifier.c    | 126 +++++++++++++++++--
 3 files changed, 394 insertions(+), 8 deletions(-)

diff --git a/kernel/bpf/diagnostics.c b/kernel/bpf/diagnostics.c
index 7a122c5025c2..920ac17758c2 100644
--- a/kernel/bpf/diagnostics.c
+++ b/kernel/bpf/diagnostics.c
@@ -457,6 +457,16 @@ static const char *bpf_diag_context_name(enum bpf_diag_context_kind kind)
 	}
 }
 
+static u32 bpf_diag_current_frameno(const struct bpf_verifier_env *env)
+{
+	const struct bpf_verifier_state *state = env->cur_state;
+
+	if (!state || !state->frame[state->curframe])
+		return 0;
+
+	return state->frame[state->curframe]->frameno;
+}
+
 void bpf_diag_report_header(struct bpf_verifier_env *env,
 			    enum bpf_diag_category category,
 			    const char *problem)
@@ -648,6 +658,157 @@ void bpf_diag_report_source(struct bpf_verifier_env *env, u32 insn_idx,
 	}
 }
 
+void bpf_diag_report_register_type(struct bpf_verifier_env *env,
+				   u32 insn_idx, int regno,
+				   const char *problem, const char *reason,
+				   const char *suggestion)
+{
+	struct bpf_diag_history_opts opts = {
+		.scope = BPF_DIAG_HISTORY_SCOPE_REG,
+		.frameno = bpf_diag_current_frameno(env),
+		.regno = regno,
+	};
+
+	bpf_diag_report_header(env, BPF_DIAG_CATEGORY_REGISTER_TYPE_SAFETY,
+			       problem);
+	bpf_diag_report_reason(env, "%s", reason);
+
+	bpf_diag_report_section(env, "At");
+	bpf_diag_report_source(env, insn_idx, '!', "%s", problem);
+
+	if (regno >= 0)
+		bpf_diag_print_history(env, &opts);
+
+	bpf_diag_report_suggestion(env, "%s", suggestion);
+}
+
+static const char *bpf_diag_arg_ordinal(int argno)
+{
+	switch (argno) {
+	case 1:
+		return "first";
+	case 2:
+		return "second";
+	case 3:
+		return "third";
+	case 4:
+		return "fourth";
+	case 5:
+		return "fifth";
+	case 6:
+		return "sixth";
+	case 7:
+		return "seventh";
+	case 8:
+		return "eighth";
+	case 9:
+		return "ninth";
+	case 10:
+		return "tenth";
+	case 11:
+		return "eleventh";
+	case 12:
+		return "twelfth";
+	default:
+		return NULL;
+	}
+}
+
+void bpf_diag_report_invalid_deref(struct bpf_verifier_env *env, u32 insn_idx,
+				   int regno, const char *reg_name,
+				   const char *type_name,
+				   enum bpf_diag_invalid_deref_kind kind,
+				   s64 offset)
+{
+	struct bpf_diag_history_opts opts = {
+		.scope = BPF_DIAG_HISTORY_SCOPE_REG,
+		.frameno = bpf_diag_current_frameno(env),
+		.regno = regno,
+	};
+
+	bpf_diag_report_header(env, BPF_DIAG_CATEGORY_REGISTER_TYPE_SAFETY,
+			       "invalid dereference");
+
+	switch (kind) {
+	case BPF_DIAG_DEREF_SCALAR:
+		bpf_diag_report_reason(env,
+				       "%s is an integer scalar here, not a pointer to memory.",
+				       reg_name);
+		break;
+	case BPF_DIAG_DEREF_NULLABLE_PTR:
+		bpf_diag_report_reason(env,
+				       "%s may be NULL here (%s). The program could dereference NULL on this path, so the verifier cannot prove this access is safe.",
+				       reg_name, type_name);
+		break;
+	case BPF_DIAG_DEREF_MODIFIED_PTR:
+		bpf_diag_report_reason(env,
+				       "%s has offset %lld here, but this pointer type must be dereferenced in its original form.",
+				       reg_name, offset);
+		break;
+	case BPF_DIAG_DEREF_INVALID_PTR:
+	default:
+		bpf_diag_report_reason(env,
+				       "%s has type %s here, which is not valid for this memory access.",
+				       reg_name, type_name);
+		break;
+	}
+
+	bpf_diag_report_section(env, "At");
+	if (kind == BPF_DIAG_DEREF_MODIFIED_PTR)
+		bpf_diag_report_source(env, insn_idx, '!',
+				       "dereference requires the original %s pointer",
+				       type_name);
+	else
+		bpf_diag_report_source(env, insn_idx, '!',
+				       "invalid dereference of %s (%s)",
+				       reg_name, type_name);
+
+	bpf_diag_print_history(env, &opts);
+
+	switch (kind) {
+	case BPF_DIAG_DEREF_NULLABLE_PTR:
+		bpf_diag_report_suggestion(env,
+					   "Add a NULL check and dereference the pointer only on the non-NULL path.");
+		break;
+	case BPF_DIAG_DEREF_MODIFIED_PTR:
+		bpf_diag_report_suggestion(env,
+					   "Preserve the original pointer in another register, or use an allowed pointer offset before dereferencing it.");
+		break;
+	case BPF_DIAG_DEREF_SCALAR:
+	case BPF_DIAG_DEREF_INVALID_PTR:
+	default:
+		bpf_diag_report_suggestion(env,
+					   "Preserve a pointer-valued register where needed, or reload and revalidate the pointer after scalar arithmetic, helper calls, or "
+					   "other operations that can invalidate it.");
+		break;
+	}
+}
+
+void bpf_diag_report_unreadable_reg(struct bpf_verifier_env *env,
+				    u32 insn_idx, int regno)
+{
+	struct bpf_diag_history_opts opts = {
+		.scope = BPF_DIAG_HISTORY_SCOPE_REG,
+		.frameno = bpf_diag_current_frameno(env),
+		.regno = regno,
+	};
+
+	bpf_diag_report_header(env, BPF_DIAG_CATEGORY_REGISTER_TYPE_SAFETY,
+			       "unreadable register");
+	bpf_diag_report_reason(env,
+			       "R%d is not readable here. A previous operation may have invalidated this register, so the verifier cannot use it as an input.",
+			       regno);
+
+	bpf_diag_report_section(env, "At");
+	bpf_diag_report_source(env, insn_idx, '!',
+			       "R%d is not readable", regno);
+
+	bpf_diag_print_history(env, &opts);
+
+	bpf_diag_report_suggestion(env,
+				   "Avoid using the register after it is invalidated, or reload and revalidate a fresh pointer before this instruction.");
+}
+
 void bpf_diag_clear_history(struct bpf_verifier_state *state)
 {
 	kfree(state->diag_history);
@@ -1165,6 +1326,95 @@ static void bpf_diag_print_reg_mod(struct bpf_verifier_env *env,
 			       event->reg.dst_reg, old_buf, new_buf);
 }
 
+static void bpf_diag_format_stack_arg(char *buf, size_t size, u8 slot)
+{
+	int argno = MAX_BPF_FUNC_REG_ARGS + slot + 1;
+	const char *ordinal = bpf_diag_arg_ordinal(argno);
+
+	if (ordinal)
+		scnprintf(buf, size, "outgoing stack argument %u (%s argument)",
+			  slot + 1, ordinal);
+	else
+		scnprintf(buf, size, "outgoing stack argument %u", slot + 1);
+}
+
+static const char *
+bpf_diag_stack_arg_reason(enum bpf_diag_stack_arg_reason reason)
+{
+	switch (reason) {
+	case BPF_DIAG_STACK_ARG_REF_RELEASE:
+		return "resource release invalidated the pointer";
+	case BPF_DIAG_STACK_ARG_PKT_DATA_CHANGE:
+		return "packet data may have moved";
+	case BPF_DIAG_STACK_ARG_WRITE:
+	default:
+		return NULL;
+	}
+}
+
+static void bpf_diag_print_stack_arg_event(struct bpf_verifier_env *env,
+					   const struct bpf_diag_history_event *event)
+{
+	char old_buf[192], new_buf[192], arg_buf[64];
+	const char *reason;
+
+	bpf_diag_format_stack_arg(arg_buf, sizeof(arg_buf),
+				  event->stack_arg.slot);
+	bpf_diag_format_reg_snapshot(env, old_buf, sizeof(old_buf),
+				     &event->stack_arg.old);
+	bpf_diag_format_reg_snapshot(env, new_buf, sizeof(new_buf),
+				     &event->stack_arg.new);
+
+	if (event->stack_arg.reason == BPF_DIAG_STACK_ARG_WRITE) {
+		bpf_diag_report_source(env, event->insn_idx, '~',
+				       "%s set to %s", arg_buf, new_buf);
+		return;
+	}
+
+	reason = bpf_diag_stack_arg_reason(event->stack_arg.reason);
+	bpf_diag_report_source(env, event->insn_idx, 'x',
+			       "%s: %s; previous value was %s",
+			       arg_buf, reason ?: "the previous value is no longer valid",
+			       old_buf);
+}
+
+void bpf_diag_report_stack_arg_uninit(struct bpf_verifier_env *env,
+				      u32 insn_idx, int nargs,
+				      int stack_arg_slot,
+				      const char *callee_name)
+{
+	struct bpf_diag_history_opts opts = {
+		.scope = BPF_DIAG_HISTORY_SCOPE_STACK_ARG,
+		.frameno = bpf_diag_current_frameno(env),
+		.stack_arg_slot = stack_arg_slot,
+	};
+	char arg_buf[64];
+
+	bpf_diag_format_stack_arg(arg_buf, sizeof(arg_buf), stack_arg_slot);
+	bpf_diag_report_header(env, BPF_DIAG_CATEGORY_REGISTER_TYPE_SAFETY,
+			       "missing stack argument");
+	if (callee_name)
+		bpf_diag_report_reason(env,
+				       "Function %s expects %d arguments, but %s is not initialized at this call. Store a value for this argument after any operation "
+				       "that may invalidate it.",
+				       callee_name, nargs, arg_buf);
+	else
+		bpf_diag_report_reason(env,
+				       "The callee expects %d arguments, but %s is not initialized at this call. Store a value for this argument after any operation "
+				       "that may invalidate it.",
+				       nargs, arg_buf);
+
+	bpf_diag_report_section(env, "At");
+	bpf_diag_report_source(env, insn_idx, '!',
+			       "%s is not initialized", arg_buf);
+
+	bpf_diag_print_history(env, &opts);
+
+	bpf_diag_report_suggestion(env,
+				   "Write the outgoing stack argument again after releasing a resource, changing packet data, or calling another function that can "
+				   "invalidate stored pointer values.");
+}
+
 static void bpf_diag_print_ref_event(struct bpf_verifier_env *env,
 				     const struct bpf_diag_history_event *event)
 {
@@ -1228,6 +1478,10 @@ void bpf_diag_print_history(struct bpf_verifier_env *env,
 			bpf_diag_print_reg_mod(env, event);
 			printed = true;
 			break;
+		case BPF_DIAG_HISTORY_STACK_ARG:
+			bpf_diag_print_stack_arg_event(env, event);
+			printed = true;
+			break;
 		case BPF_DIAG_HISTORY_REF_ACQUIRE:
 		case BPF_DIAG_HISTORY_REF_RELEASE:
 			bpf_diag_print_ref_event(env, event);
diff --git a/kernel/bpf/diagnostics.h b/kernel/bpf/diagnostics.h
index ff6c55f9b5f7..b0d42cbdfd23 100644
--- a/kernel/bpf/diagnostics.h
+++ b/kernel/bpf/diagnostics.h
@@ -113,6 +113,13 @@ enum bpf_diag_stack_arg_reason {
 	BPF_DIAG_STACK_ARG_PKT_DATA_CHANGE,
 };
 
+enum bpf_diag_invalid_deref_kind {
+	BPF_DIAG_DEREF_SCALAR,
+	BPF_DIAG_DEREF_NULLABLE_PTR,
+	BPF_DIAG_DEREF_MODIFIED_PTR,
+	BPF_DIAG_DEREF_INVALID_PTR,
+};
+
 struct bpf_diag_history_opts {
 	enum bpf_diag_history_scope scope;
 	u32 frameno;
@@ -137,6 +144,21 @@ void bpf_diag_report_suggestion(struct bpf_verifier_env *env, const char *fmt, .
 void bpf_diag_report_source(struct bpf_verifier_env *env, u32 insn_idx,
 			    char marker, const char *fmt, ...)
 	__printf(4, 5);
+void bpf_diag_report_register_type(struct bpf_verifier_env *env,
+				   u32 insn_idx, int regno,
+				   const char *problem, const char *reason,
+				   const char *suggestion);
+void bpf_diag_report_invalid_deref(struct bpf_verifier_env *env, u32 insn_idx,
+				   int regno, const char *reg_name,
+				   const char *type_name,
+				   enum bpf_diag_invalid_deref_kind kind,
+				   s64 offset);
+void bpf_diag_report_unreadable_reg(struct bpf_verifier_env *env,
+				    u32 insn_idx, int regno);
+void bpf_diag_report_stack_arg_uninit(struct bpf_verifier_env *env,
+				      u32 insn_idx, int nargs,
+				      int stack_arg_slot,
+				      const char *callee_name);
 
 void bpf_diag_clear_history(struct bpf_verifier_state *state);
 void bpf_diag_copy_history(struct bpf_verifier_state *dst,
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 7bb2a81ee353..adf660ab9e7d 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3123,6 +3123,8 @@ static int __check_reg_arg(struct bpf_verifier_env *env, struct bpf_reg_state *r
 		/* check whether register used as source operand can be read */
 		if (reg->type == NOT_INIT) {
 			verbose(env, "R%d !read_ok\n", regno);
+			bpf_diag_report_unreadable_reg(env, env->insn_idx,
+						       regno);
 			return -EACCES;
 		}
 		/* We don't need to worry about FP liveness because it's read-only */
@@ -4134,8 +4136,9 @@ static int mark_stack_arg_precision(struct bpf_verifier_env *env, int arg_idx)
 	return mark_chain_precision_batch(env, env->cur_state);
 }
 
-static int check_outgoing_stack_args(struct bpf_verifier_env *env, struct bpf_func_state *caller,
-				     int nargs)
+static int check_outgoing_stack_args(struct bpf_verifier_env *env,
+				     struct bpf_func_state *caller, int nargs,
+				     const char *callee_name)
 {
 	int i, spi;
 
@@ -4145,6 +4148,9 @@ static int check_outgoing_stack_args(struct bpf_verifier_env *env, struct bpf_fu
 		    caller->stack_arg_regs[spi].type == NOT_INIT) {
 			verbose(env, "callee expects %d args, stack arg%d is not initialized\n",
 				nargs, spi + 1);
+			bpf_diag_report_stack_arg_uninit(env, env->insn_idx,
+							 nargs, spi,
+							 callee_name);
 			return -EFAULT;
 		}
 	}
@@ -4299,6 +4305,11 @@ static int __check_ptr_off_reg(struct bpf_verifier_env *env,
 	if (!fixed_off_ok && reg->var_off.value != 0) {
 		verbose(env, "dereference of modified %s ptr %s off=%lld disallowed\n",
 			reg_type_str(env, reg->type), reg_arg_name(env, argno), reg->var_off.value);
+		bpf_diag_report_invalid_deref(env, env->insn_idx, reg_from_argno(argno),
+					      reg_arg_name(env, argno),
+					      reg_type_str(env, reg->type),
+					      BPF_DIAG_DEREF_MODIFIED_PTR,
+					      reg->var_off.value);
 		return -EACCES;
 	}
 
@@ -6166,6 +6177,11 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, struct b
 		if (type_may_be_null(reg->type)) {
 			verbose(env, "%s invalid mem access '%s'\n", reg_arg_name(env, argno),
 				reg_type_str(env, reg->type));
+			bpf_diag_report_invalid_deref(env, insn_idx, reg_from_argno(argno),
+						      reg_arg_name(env, argno),
+						      reg_type_str(env, reg->type),
+						      BPF_DIAG_DEREF_NULLABLE_PTR,
+						      0);
 			return -EACCES;
 		}
 
@@ -6321,8 +6337,17 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, struct b
 		if (t == BPF_READ && value_regno >= 0)
 			mark_reg_unknown(env, regs, value_regno);
 	} else {
+		enum bpf_diag_invalid_deref_kind kind = BPF_DIAG_DEREF_INVALID_PTR;
+
 		verbose(env, "%s invalid mem access '%s'\n", reg_arg_name(env, argno),
 			reg_type_str(env, reg->type));
+		if (reg->type == SCALAR_VALUE)
+			kind = BPF_DIAG_DEREF_SCALAR;
+		else if (type_may_be_null(reg->type))
+			kind = BPF_DIAG_DEREF_NULLABLE_PTR;
+		bpf_diag_report_invalid_deref(env, insn_idx, reg_from_argno(argno),
+					      reg_arg_name(env, argno),
+					      reg_type_str(env, reg->type), kind, 0);
 		return -EACCES;
 	}
 
@@ -9216,14 +9241,17 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env, int subprog,
 	ret = btf_prepare_func_args(env, subprog);
 	if (ret) {
 		if (bpf_in_stack_arg_cnt(sub) > 0) {
-			err = check_outgoing_stack_args(env, caller, sub->arg_cnt);
+			err = check_outgoing_stack_args(env, caller,
+							sub->arg_cnt,
+							subprog_name(env, subprog));
 			if (err)
 				return err;
 		}
 		return ret;
 	}
 
-	ret = check_outgoing_stack_args(env, caller, sub->arg_cnt);
+	ret = check_outgoing_stack_args(env, caller, sub->arg_cnt,
+					subprog_name(env, subprog));
 	if (ret)
 		return ret;
 
@@ -11966,7 +11994,7 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 		return -ENOTSUPP;
 	}
 
-	ret = check_outgoing_stack_args(env, caller, nargs);
+	ret = check_outgoing_stack_args(env, caller, nargs, func_name);
 	if (ret)
 		return ret;
 
@@ -13684,6 +13712,7 @@ static int adjust_ptr_min_max_vals(struct bpf_verifier_env *env,
 	struct bpf_sanitize_info info = {};
 	u8 opcode = BPF_OP(insn->code);
 	u32 dst = insn->dst_reg;
+	char reason[256];
 	int ret, bounds_ret;
 
 	dst_reg = &regs[dst];
@@ -13707,12 +13736,28 @@ static int adjust_ptr_min_max_vals(struct bpf_verifier_env *env,
 		verbose(env,
 			"R%d 32-bit pointer arithmetic prohibited\n",
 			dst);
+		scnprintf(reason, sizeof(reason),
+			  "R%d holds %s. 32-bit ALU operations on pointers discard pointer provenance, so the verifier cannot keep the result as a safe "
+			  "pointer.",
+			  dst, bpf_diag_reg_type_plain(env, ptr_reg->type));
+		bpf_diag_report_register_type(env, env->insn_idx, dst,
+					      "32-bit pointer arithmetic",
+					      reason,
+					      "Use 64-bit pointer arithmetic with an allowed, bounded scalar offset, or convert the value to a scalar only after pointer use "
+					      "is complete.");
 		return -EACCES;
 	}
 
 	if (ptr_reg->type & PTR_MAYBE_NULL) {
 		verbose(env, "R%d pointer arithmetic on %s prohibited, null-check it first\n",
 			dst, reg_type_str(env, ptr_reg->type));
+		scnprintf(reason, sizeof(reason),
+			  "R%d may be NULL (%s). Pointer arithmetic is allowed only after the program proves the pointer is non-NULL on this path.",
+			  dst, reg_type_str(env, ptr_reg->type));
+		bpf_diag_report_register_type(env, env->insn_idx, dst,
+					      "pointer arithmetic before NULL check",
+					      reason,
+					      "Add a NULL check first, and do the pointer arithmetic only on the non-NULL branch.");
 		return -EACCES;
 	}
 
@@ -13749,6 +13794,13 @@ static int adjust_ptr_min_max_vals(struct bpf_verifier_env *env,
 	default:
 		verbose(env, "R%d pointer arithmetic on %s prohibited\n",
 			dst, reg_type_str(env, ptr_reg->type));
+		scnprintf(reason, sizeof(reason),
+			  "R%d holds %s. This pointer kind does not allow arithmetic because changing its offset would lose the verifier's required provenance.",
+			  dst, bpf_diag_reg_type_plain(env, ptr_reg->type));
+		bpf_diag_report_register_type(env, env->insn_idx, dst,
+					      "pointer arithmetic is not allowed",
+					      reason,
+					      "Keep this pointer unchanged, or derive an allowed pointer type before applying a bounded offset.");
 		return -EACCES;
 	}
 
@@ -13758,9 +13810,26 @@ static int adjust_ptr_min_max_vals(struct bpf_verifier_env *env,
 	dst_reg->type = ptr_reg->type;
 	dst_reg->id = ptr_reg->id;
 
-	if (!check_reg_sane_offset_scalar(env, off_reg, ptr_reg->type) ||
-	    !check_reg_sane_offset_ptr(env, ptr_reg, ptr_reg->type))
+	if (!check_reg_sane_offset_scalar(env, off_reg, ptr_reg->type)) {
+		scnprintf(reason, sizeof(reason),
+			  "The scalar offset used with R%d has a range the verifier cannot safely add to %s.",
+			  dst, bpf_diag_reg_type_plain(env, ptr_reg->type));
+		bpf_diag_report_register_type(env, env->insn_idx, dst,
+					      "pointer offset is not safe",
+					      reason,
+					      "Clamp or bound-check the scalar offset before adding it to the pointer.");
+		return -EINVAL;
+	}
+	if (!check_reg_sane_offset_ptr(env, ptr_reg, ptr_reg->type)) {
+		scnprintf(reason, sizeof(reason),
+			  "R%d already has an offset that is outside the verifier's safe pointer range for %s.",
+			  dst, bpf_diag_reg_type_plain(env, ptr_reg->type));
+		bpf_diag_report_register_type(env, env->insn_idx, dst,
+					      "pointer offset is not safe",
+					      reason,
+					      "Keep the base pointer within the verifier's allowed offset range before applying more arithmetic.");
 		return -EINVAL;
+	}
 
 	/* pointer types do not carry 32-bit bounds at the moment. */
 	__mark_reg32_unbounded(dst_reg);
@@ -13803,6 +13872,14 @@ static int adjust_ptr_min_max_vals(struct bpf_verifier_env *env,
 			/* scalar -= pointer.  Creates an unknown scalar */
 			verbose(env, "R%d tried to subtract pointer from scalar\n",
 				dst);
+			scnprintf(reason, sizeof(reason),
+				  "This operation subtracts a pointer from scalar register R%d. The verifier does not allow pointer provenance to flow through scalar "
+				  "subtraction.",
+				  dst);
+			bpf_diag_report_register_type(env, env->insn_idx, dst,
+						      "pointer subtracted from scalar",
+						      reason,
+						      "Keep pointer values in pointer registers, or use explicit scalar values that do not come from pointer arithmetic.");
 			return -EACCES;
 		}
 		/* We don't allow subtraction from FP, because (according to
@@ -13812,6 +13889,14 @@ static int adjust_ptr_min_max_vals(struct bpf_verifier_env *env,
 		if (ptr_reg->type == PTR_TO_STACK) {
 			verbose(env, "R%d subtraction from stack pointer prohibited\n",
 				dst);
+			scnprintf(reason, sizeof(reason),
+				  "R%d is derived from the frame pointer. Subtracting from a stack pointer is not allowed because stack accesses must stay within the "
+				  "verifier's tracked frame offsets.",
+				  dst);
+			bpf_diag_report_register_type(env, env->insn_idx, dst,
+						      "subtraction from stack pointer",
+						      reason,
+						      "Use fixed negative stack offsets from R10, and avoid arithmetic that moves the frame pointer backward.");
 			return -EACCES;
 		}
 		dst_reg->r64 = cnum64_add(ptr_reg->r64, cnum64_negate(off_reg->r64));
@@ -13837,16 +13922,41 @@ static int adjust_ptr_min_max_vals(struct bpf_verifier_env *env,
 		/* bitwise ops on pointers are troublesome, prohibit. */
 		verbose(env, "R%d bitwise operator %s on pointer prohibited\n",
 			dst, bpf_alu_string[opcode >> 4]);
+		scnprintf(reason, sizeof(reason),
+			  "R%d holds %s. Bitwise operator %s would destroy pointer provenance, so the verifier cannot track the result as a valid pointer.",
+			  dst, bpf_diag_reg_type_plain(env, ptr_reg->type),
+			  bpf_alu_string[opcode >> 4]);
+		bpf_diag_report_register_type(env, env->insn_idx, dst,
+					      "bitwise operation on pointer",
+					      reason,
+					      "Do bitwise operations on scalar values, not on pointer-valued registers.");
 		return -EACCES;
 	default:
 		/* other operators (e.g. MUL,LSH) produce non-pointer results */
 		verbose(env, "R%d pointer arithmetic with %s operator prohibited\n",
 			dst, bpf_alu_string[opcode >> 4]);
+		scnprintf(reason, sizeof(reason),
+			  "R%d holds %s. Operator %s is not one of the limited pointer arithmetic operations the verifier can track.",
+			  dst, bpf_diag_reg_type_plain(env, ptr_reg->type),
+			  bpf_alu_string[opcode >> 4]);
+		bpf_diag_report_register_type(env, env->insn_idx, dst,
+					      "invalid pointer arithmetic operator",
+					      reason,
+					      "Use only verifier-supported addition or subtraction with a bounded scalar offset, or perform this operation on a scalar "
+					      "value.");
 		return -EACCES;
 	}
 
-	if (!check_reg_sane_offset_ptr(env, dst_reg, ptr_reg->type))
+	if (!check_reg_sane_offset_ptr(env, dst_reg, ptr_reg->type)) {
+		scnprintf(reason, sizeof(reason),
+			  "After this arithmetic, R%d would have an offset outside the verifier's safe range for %s.",
+			  dst, bpf_diag_reg_type_plain(env, ptr_reg->type));
+		bpf_diag_report_register_type(env, env->insn_idx, dst,
+					      "pointer offset is not safe",
+					      reason,
+					      "Tighten the scalar bounds before the arithmetic so the resulting pointer remains within the allowed range.");
 		return -EINVAL;
+	}
 	reg_bounds_sync(dst_reg);
 	bounds_ret = sanitize_check_bounds(env, insn, dst_reg);
 	if (bounds_ret == -EACCES)
-- 
2.53.0

