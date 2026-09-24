Received: from mail-wm2-f6.google.com (mail-wm2-f6.google.com [74.125.225.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF80641D216
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 17:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790269619; cv=none; b=rldoSFKLSa8tSQ2R2/qpKGxQH3W/ccahliPaBEhsrwvY8rPJ1HDvgM+wzJzJHvMz1knik4IOFG5a8Vi+1AQlXuVqKtXpr11fFHTTRii9GBq+4hy9AK0ZoX35kugkqknrNqeJd2uUpJ0qwPuZ0nnYLslbrdu5M3spqgo+w+c3Eew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790269619; c=relaxed/simple;
	bh=HNUoNwkdcsgnNFxYTA5BS+DWrDc1XikO3sZi2+Czgn4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eQJolnV9t2pfkhB7CAFG1o8NrIJz6RvtLPY3kouFoGvw7SC3DxHm50mPuzTqCJ9NI9VV1bcOt+VEQOnwl0JBbJf8wO16QbxSiey75o+45WpHn2DW4INqpnW2k6QSS6xzZPAAh5LAN07TZov23ewTOnaC+Ei5IP5AdtZQDY5RSgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MN6polQH; arc=none smtp.client-ip=74.125.225.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MN6polQH"
Received: by mail-wm2-f6.google.com with SMTP id 5b1f17b1804b1-49fe8bf90c9so209225e9.0
        for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 10:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790269616; x=1790874416; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4Q6XVTyAQ9DfKEV8oizsYHEqipoFvZPzEmbAg2pfPuc=;
        b=MN6polQHU3BIksvkBBhJF3IuvHr3uZu4VbjAj9o7FczO7IIWBe+fMrup3nZZRQoWg6
         pf5IATvvIWvp0zT8rrDeDuUcF57QJhrA5MlTD1S0Ea8qDwjK2WpRDvEgFs4R6QgjEdxX
         OBDatog7lW+D+KF/HUQ8osKonIQ8vpY/9YhNzgRCd+dqFgeAYhDHRA1fQWFMoOs1zSpI
         baDkiRGS7xtfut5SBZ8fmF5J+RTd9yY2vjEkOawtXR4BMgWKIuQ6hJQKt3mtUxwZAm2/
         qylDjW2xEsdO9h3jIEbra7LI2NdkKRzVCe7Wwn4hELj9dyBV0WUx2Wc9Cghh1JC2dLqm
         JK2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790269616; x=1790874416;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=4Q6XVTyAQ9DfKEV8oizsYHEqipoFvZPzEmbAg2pfPuc=;
        b=RtDl8wai2nmhcBF2kNTQjmwxpKaTk01kNLcRK55lUAA0cNvD3APadk/r63ORdLmOJy
         /ImsUl83BPMHxhy2fCnuedh9Syg69vl9MY4pOMycTt3PVh8kw5i2jAHhHQ1sPC+ZWhBr
         wP2w1j9hQ4JuZXQ5VaiVZaLa/73AJySQasJSzp2aeohsItA/PRct/izzNt6gLr4DeJLn
         jdhRWTgAbcR0SjtCPOzZma19wzPJNSpq2jEjFGuHUTX6C2VFxuOJ9XIbaCI4GJRD5a1E
         pr5tIDDYL7Eb9xf0YR08uceADDX8uP3iE+p8oeLzjdodpejxlqlvXsoMauskha35R/B3
         XfjQ==
X-Gm-Message-State: AFuF++mZO3uDTL+9R33aPF1l7geTxhZXUFY8PN8vSgDdVeVhumxBnTry
	UpmRAtmDLw3bD06oOVTy2LgAKuwhHQrZoMDq7OyhH05A0/8O5/KpahpLzSyKTWLs
X-Gm-Gg: AYBFou2UmGXlv35qzmvvSvZElj8LsPyv/ORqD+NSBCrsB4VB01xBs6/Adu7q18bkxKj
	GjKlm3jEGNyWExvRbz+htO3EPJ5TSL4j6TQdOqrvlT/8a1bFjSvRu7gpwmx2kUlxKKlzQ6HqYf+
	th/E0X8LVmebR86BnZaMVNkDHZIJKig54pt+ON6vgdzo5w6AkiP2VPzIx0eXi7qmRNkXotWqoMC
	uGp/8Z4PiLvxQsZnI92bEGydDwpHAXaVJ2vn0BdCNlxzgedI0UpdrDseh7Ru2TQNYIOur7WLp8b
	DLGwhABsJM1k3gAoMRcrmaVGBPQCIREb77R1gdcXiZHciGRKH9Nu1HWWOp8ovJrHmfQXYfGppkw
	8CF4nDZ++Sc6t5mZUecgIsHgfXgH+VYQqo6RajO6TLe8xhJnqOGRmNFw6WrGNcOQ5Idu0PBkME1
	Lu1+CRPkebrJnCVUjzkcM7C/76MaLsLbdHUlsLC0sI6vj5+B0sr3DHYkfGKT/6f33fqYzsHRy+9
	9BMtLmSHD0D2goHebaodSzSU4n2egiEuPS+dKj9Ye1JpH0qIyqE/p/ElzoXpm+u5p4HVglrZCzC
	kxbuxG+0ODMwZAiKjMEB00+sQWz3z4VUrrXu0Q==
X-Received: by 2002:a05:600c:1546:b0:49e:81a7:9fbc with SMTP id 5b1f17b1804b1-49fe66fa0ddmr58457005e9.24.1790269615621;
        Thu, 24 Sep 2026 10:06:55 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fee9203f0sm1407635e9.1.2026.09.24.10.06.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 10:06:55 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v3 4/7] bpf: Report non-sleepable kfunc programs accurately
Date: Thu, 24 Sep 2026 19:06:38 +0200
Message-ID: <20260924170646.2366016-5-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260924170646.2366016-1-memxor@gmail.com>
References: <20260924170646.2366016-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7800; i=memxor@gmail.com; h=from:subject; bh=HNUoNwkdcsgnNFxYTA5BS+DWrDc1XikO3sZi2+Czgn4=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWtrRPGSyetzjlpPaDASm3N5imT8rVXf1KRY33/o+iJVw 5vyVbCxo5SFQYyLQVZMkaXk/z4m4xOVvwNtl3HDzGFlAhnCwMUpABPhYmP4K6HNJz6995nNZ0+2 g0sPtOwJqNCZJtzNL3Zn99buSPuNCQz/VJPkjnmtqtYxjSnbuGdKunm80lZvmwi3hxIWl/zZT3g yAgA=
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
index 7fbe32ce9449..d5a2ca9a24c2 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -11116,11 +11116,16 @@ static int check_func_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
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
 
@@ -12049,14 +12054,16 @@ static inline bool in_sleepable_context(struct bpf_verifier_env *env)
 
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
 
@@ -12148,12 +12155,17 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
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
 
@@ -14787,11 +14799,20 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
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
 
@@ -14905,15 +14926,6 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
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

