Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23F8E3E3D92
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 09:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790242194; cv=none; b=RQG+MLz/iKP+ImzTh2WIlLDHDVeXBPdmKWCQgcGKh1HkvGs5kEDQlIJrvzJUTowYtEI6bw/p0uxlF9wAzIp0HK21A6yKh2VepoV2pT4WdrLHMsLh313JE6c5R0vYScXQA9rlGkzVhZbjMeyTojJ/goEwFkRxF85sSP2h8CmS6Bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790242194; c=relaxed/simple;
	bh=UphuutUMZN4x0l9qvajTe9Dk01rKXgccrg3MU1/Yw0E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NT4ks9YaZ75iLPhKgH4dl3b96GBir7OUAPf/ZgoHYQ078Q/fWAPedqzvd5k0e7m1EqFAxR8digQ0L8ln4Zm1gw0ceI68N5Y3Kq+wmclJ/VZIAzcCl63A5dfNo8+n6D2fTKhRtDt7LBNC3QlUgETVpKMjXTyodxrIPw8vqLGNEKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iHY8ZzCs; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iHY8ZzCs"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-485933b24c3so1199006f8f.0
        for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 02:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790242190; x=1790846990; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5lT5DtGtTAxq9JQz/j6C5WoV6m6BK0tETgIL/wsXGFo=;
        b=iHY8ZzCs2kfzLsuF+nb7rJ3zxHIj14hnQFjcBGwmXOVj0VJzBnCHH3gJYiT9D5A03+
         H/501yzC/rG9epuRBw+AfIkGq/K33deo4RlBW/x7ZfoHeG3Nu9qfsNmXm3/q22Ua160Y
         ZOzqHgZG5/l99SgMMsLWYTkjMH1b2yx7YYsP3WFY9M9MLN1dot/O7jASs44zwBIPmhrH
         BQNLw3n1mO4WcRlcDiZdBraUrwIGyjtfxyg1kTzZ7JtlzbMktKXEzZjjO25YVQ/X2CoN
         1vs/Cjty4Q2iTS661S4ug7SpSH0aCAM8JpJFTTo4pQvou7O+xMYAHxxGOuDJwe/Fv5bx
         IGVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790242190; x=1790846990;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=5lT5DtGtTAxq9JQz/j6C5WoV6m6BK0tETgIL/wsXGFo=;
        b=qLfgIyMkqqZ4oEI+JhJkMElx0YDOro+9YEoCVwmrlaAr+QljI+No8Zv8s7m9CoIdCD
         JpLZ/wivL6SOwAWhe2IHEcr+tZtx3ZyzWCTDf/JzjAl2hH8JIyBG2oLYx4oAXFF9f6sD
         m1Z8KSH+yvF3DarJDiagToC4csBOm241qGDdMhItbImdPqRv6H0NJzznE1IQeagzrPyh
         c41gP5vBrktXrAeafmmZdwirs+eQCxu8AkTVktIRlHCVJtUt6bkswo4c4H1VtZxsNreW
         ttTStOeyKClRgxtP+IZpPUg2RKfHyiLOMgdJdDH0FuPMcpxyJwoCE6sogbdF37RHIBnw
         Y4+Q==
X-Gm-Message-State: AFuF++noNE2irT+mFOg2f1DZZ07W+blrGM7p8sp9iVloWsO26XNBQzEj
	RAWKOdm41HM9Iy+sI+yf9bXjOlKpoBmgYh75QZscrgIVlvuHEGyaEDAL3azcSA==
X-Gm-Gg: AYBFou1RFBQALSyKiL3QxEeo/bvBG0QEAEC8pyGeDdTRUVfsYHVhCMvmF/LFsJsB+kP
	AfMr/3O8dTBDUTVM59DTUbfMISzWjJFBFaxxSryRhaqoc460g0lZe9nfBhKpfSzjGZGrEwShwKt
	zS+aiUxPOSXZTrrtjKkyDnzQjdE3ru8B9TUPgTPsRf2jZDihx1lF8prWq7bhHhIefBGYfLClq5H
	QxM+ke/bb+uECpuyU7nOdp9IOO70G+ZGpspcOfjFKyd8H9bdJgI60+luoVlO+anxc6DYs06qVE2
	eJQ9ZLCiYFCR2lFR9pDWycLg8JOikcZhzSRONSxaYB4SyUQrYpAt2IcUr2ofz44hjsmUIIqGStQ
	nKl8PsarZ6Mb8tS8AG+veuCXdkWW0mGEn1XD738imm0GKIMWIp5NjIf/XioT6oxjKwfqvmJnh17
	TpROHONd6Xk6RDfJfLqLVI8gNCulChvAY0RbVJH7I0516Zkdox3T9cBPycwdQTSoVCrgzRa/ABi
	0bYs/js3oj0toVg1QumDK1fUJBwoWU9Ic2NLVGzGNDGmJU3uIzwZRo8+w6pvSIrNzmLZV+oJWiH
	bt2Zrsxp8niwcRfYCyy/QSKZgAapy5YUiKNsRQ==
X-Received: by 2002:a5d:5d0e:0:b0:487:da0:df5a with SMTP id ffacd0b85a97d-4887170d3aamr3796687f8f.42.1790242190221;
        Thu, 24 Sep 2026 02:29:50 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48868889409sm10874054f8f.35.2026.09.24.02.29.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 02:29:49 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v2 4/7] bpf: Report non-sleepable kfunc programs accurately
Date: Thu, 24 Sep 2026 11:29:33 +0200
Message-ID: <20260924092941.3174809-5-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260924092941.3174809-1-memxor@gmail.com>
References: <20260924092941.3174809-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7800; i=memxor@gmail.com; h=from:subject; bh=UphuutUMZN4x0l9qvajTe9Dk01rKXgccrg3MU1/Yw0E=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWvL25xsxjLV15lXLc+47+6VjO1yE9+5YfX15Jf/pl3sV +lW2/Gko5SFQYyLQVZMkaXk/z4m4xOVvwNtl3HDzGFlAhnCwMUpABPJqmL4X6t0U8B73T+9PS9+ 5itNfcJd4qX/0rl9tsq52N8bjx5i38fw39X1YGbpLqlMMfdD6vdns9Q7zwhgSbJaJm/W+3zblc1 iXAA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

A sleepable kfunc call can fail either because the program is not
sleepable or because an otherwise sleepable program has entered a
non-sleepable critical section. check_kfunc_call() checks these
conditions separately. The first check is only gated by in_sleepable(),
so the shared diagnostic can blame an active RCU, preemption-disabled,
IRQ-disabled, or locked region even though leaving that region would not
make the program sleepable. Adding a second diagnostic entry point only
to force the program context would duplicate the API.

Reject the call once based on in_sleepable_context(). Teach the shared
bpf_diag_ctx_forbidden() reporter and non_sleepable_context_description()
to consider active RCU, preempt, IRQ, and lock regions only when the
program is sleepable, and to fall back to the non-sleepable program
otherwise. A non-sleepable program can still hold that context state, so
relying on the existing no-context fallback alone would keep blaming the
critical section.

Select the suggestion at the kfunc, helper, and global-function sites
according to that cause, and choose between the two existing kfunc
verifier messages the same way, so a sleepable program is told to leave
the critical section and a non-sleepable program is told to become
sleepable.

This avoids a diagnostic-only wrapper while retaining context history for
sleepable programs that enter a forbidden region.

Link: https://lore.kernel.org/bpf/2e42a1a2bf45f4d2aba7495bdc9f147558055740e2f3c8b9dae255f6c57fc13c@mail.kernel.org/
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/diagnostics.c | 21 +++++++-------
 kernel/bpf/verifier.c    | 62 ++++++++++++++++++++++++----------------
 2 files changed, 48 insertions(+), 35 deletions(-)

diff --git a/kernel/bpf/diagnostics.c b/kernel/bpf/diagnostics.c
index 496d24064532..69c168e03732 100644
--- a/kernel/bpf/diagnostics.c
+++ b/kernel/bpf/diagnostics.c
@@ -1119,16 +1119,17 @@ void bpf_diag_ctx_forbidden(struct bpf_verifier_env *env, u32 insn_idx,
 	const char *constraint, *context;
 	u32 depth;
 
-	if (env->cur_state->active_rcu_locks)
-		ctx_kind = BPF_DIAG_CONTEXT_RCU;
-	else if (env->cur_state->active_preempt_locks)
-		ctx_kind = BPF_DIAG_CONTEXT_PREEMPT;
-	else if (env->cur_state->active_irq_id)
-		ctx_kind = BPF_DIAG_CONTEXT_IRQ;
-	else if (env->cur_state->active_locks)
-		ctx_kind = BPF_DIAG_CONTEXT_LOCK;
-	else
-		ctx_kind = BPF_DIAG_CONTEXT_NONE;
+	ctx_kind = BPF_DIAG_CONTEXT_NONE;
+	if (env->cur_state->in_sleepable) {
+		if (env->cur_state->active_rcu_locks)
+			ctx_kind = BPF_DIAG_CONTEXT_RCU;
+		else if (env->cur_state->active_preempt_locks)
+			ctx_kind = BPF_DIAG_CONTEXT_PREEMPT;
+		else if (env->cur_state->active_irq_id)
+			ctx_kind = BPF_DIAG_CONTEXT_IRQ;
+		else if (env->cur_state->active_locks)
+			ctx_kind = BPF_DIAG_CONTEXT_LOCK;
+	}
 
 	depth = diag_context_depth(env, ctx_kind);
 	opts = (struct bpf_diag_history_opts) {
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index dbb3153fe1b5..1c52e7bd570d 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -11086,11 +11086,16 @@ static int check_func_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 		}
 
 		if (env->subprog_info[subprog].might_sleep && !in_sleepable_context(env)) {
+			const char *suggestion;
+
 			verbose(env, "sleepable global function %s() called in %s\n",
 				sub_name, non_sleepable_context_description(env));
+			if (in_sleepable(env))
+				suggestion = "Move the call outside the critical section, or use a non-sleepable function.";
+			else
+				suggestion = "Mark the program sleepable if the program type allows it, or use a non-sleepable function.";
 			operation = bpf_diag_fmt(env, "sleepable global function %s()", sub_name);
-			bpf_diag_ctx_forbidden(env, *insn_idx, operation,
-				"Move the call outside the critical section, or use a non-sleepable function.");
+			bpf_diag_ctx_forbidden(env, *insn_idx, operation, suggestion);
 			return -EINVAL;
 		}
 
@@ -12021,14 +12026,16 @@ static inline bool in_sleepable_context(struct bpf_verifier_env *env)
 
 static const char *non_sleepable_context_description(struct bpf_verifier_env *env)
 {
-	if (env->cur_state->active_rcu_locks)
-		return "rcu_read_lock region";
-	if (env->cur_state->active_preempt_locks)
-		return "non-preemptible region";
-	if (env->cur_state->active_irq_id)
-		return "IRQ-disabled region";
-	if (env->cur_state->active_locks)
-		return "lock region";
+	if (in_sleepable(env)) {
+		if (env->cur_state->active_rcu_locks)
+			return "rcu_read_lock region";
+		if (env->cur_state->active_preempt_locks)
+			return "non-preemptible region";
+		if (env->cur_state->active_irq_id)
+			return "IRQ-disabled region";
+		if (env->cur_state->active_locks)
+			return "lock region";
+	}
 	return "non-sleepable prog";
 }
 
@@ -12120,12 +12127,17 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 	}
 
 	if (fn->might_sleep && !in_sleepable_context(env)) {
+		const char *suggestion;
+
 		verbose(env, "sleepable helper %s#%d in %s\n", func_id_name(func_id), func_id,
 			non_sleepable_context_description(env));
+		if (in_sleepable(env))
+			suggestion = "Move the helper call outside the critical section, or use a non-sleepable helper.";
+		else
+			suggestion = "Mark the program sleepable if the program type allows it, or use a non-sleepable helper.";
 		operation = bpf_diag_fmt(env, "sleepable helper %s#%d",
 					 func_id_name(func_id), func_id);
-		bpf_diag_ctx_forbidden(env, insn_idx, operation,
-			"Move the helper call outside the critical section, or use a non-sleepable helper.");
+		bpf_diag_ctx_forbidden(env, insn_idx, operation, suggestion);
 		return -EINVAL;
 	}
 
@@ -14745,11 +14757,20 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 	}
 
 	sleepable = bpf_is_kfunc_sleepable(&meta);
-	if (sleepable && !in_sleepable(env)) {
-		verbose(env, "program must be sleepable to call sleepable kfunc %s\n", func_name);
+	if (sleepable && !in_sleepable_context(env)) {
+		const char *suggestion;
+
+		if (in_sleepable(env)) {
+			verbose(env, "kernel func %s is sleepable within %s\n",
+				func_name, non_sleepable_context_description(env));
+			suggestion = "Move the kfunc call outside the critical section, or use a non-sleepable kfunc.";
+		} else {
+			verbose(env, "program must be sleepable to call sleepable kfunc %s\n",
+				func_name);
+			suggestion = "Mark the program sleepable if the program type allows it, or use a non-sleepable kfunc.";
+		}
 		operation = bpf_diag_fmt(env, "sleepable kfunc %s", func_name);
-		bpf_diag_ctx_forbidden(env, insn_idx, operation,
-			"Mark the program sleepable if the program type allows it, or use a non-sleepable kfunc.");
+		bpf_diag_ctx_forbidden(env, insn_idx, operation, suggestion);
 		return -EACCES;
 	}
 
@@ -14863,15 +14884,6 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 			invalidate_rcu_protected_refs(env);
 	}
 
-	if (sleepable && !in_sleepable_context(env)) {
-		verbose(env, "kernel func %s is sleepable within %s\n",
-			func_name, non_sleepable_context_description(env));
-		operation = bpf_diag_fmt(env, "sleepable kfunc %s", func_name);
-		bpf_diag_ctx_forbidden(env, insn_idx, operation,
-			"Move the kfunc call outside the critical section, or use a non-sleepable kfunc.");
-		return -EACCES;
-	}
-
 	if (in_rbtree_lock_required_cb(env) && (rcu_lock || rcu_unlock)) {
 		verbose(env, "Calling bpf_rcu_read_{lock,unlock} in unnecessary rbtree callback\n");
 		return -EACCES;
-- 
2.53.0

