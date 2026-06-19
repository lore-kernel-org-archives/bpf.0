Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com [209.85.221.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 058193CF695
	for <bpf@vger.kernel.org>; Fri, 19 Jun 2026 20:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781902796; cv=none; b=j+X5j30L6am9NFS3B2os57kc2C5a4UOTIvjzuCQUnAwpIK2JcA43OGHVAB+ejfXP1+c26zZsKoC+gYvq1jbSxiNnOM/yJhvcOrbFJM3/8Ul8ndh7vRKusxDk3hK8bYu8nhd4q8+nB3F5NRWUZG/18SlY/58xF6F8OhrJMTxuUF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781902796; c=relaxed/simple;
	bh=kwx88XHldEpP3rUuGxyOXPHuF7hVzAeEkFZEbyUp74I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dMje8DD5W73x6QCB7DPJ5S4qtaD2rFquXveTh3FPaM6kawV/+HOuNJtYeVresXzpyJrpayGTjis9RnMz9W1MtSrmfflJB71utb4oB309llZYOndE5UScQnzswbgip0yKgLXo7mrbseQCDbuCdl1/iQU8XM5dJ5xFQG5Db/TB2yY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HFJsooZe; arc=none smtp.client-ip=209.85.221.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HFJsooZe"
Received: by mail-wr1-f67.google.com with SMTP id ffacd0b85a97d-45ef41adbc1so2049166f8f.0
        for <bpf@vger.kernel.org>; Fri, 19 Jun 2026 13:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781902783; x=1782507583; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XGMiHCA0HkBL+ewnAq1jWTHp0QfW/VL9HJke2P2Lnso=;
        b=HFJsooZedPVp6mwen0NMMbFeq8ywiN+4k8yK5nnKuSZulFDJPaUKkgAttBcwwKUkCu
         RaMLxUtVJf4Y+dptorUUuQq8rIG/oi1j25H3NhkJkTca0RwO9e29a+FzRmT8V8iINc7p
         OarbVrIoa0vUs6QSS9BgaST4Gg+m/XraAqbI/kZk+TQsg4PpE6RFYgjNFYE56wPZ5VJF
         DXHI4us7k672s1sTWH+2SJ/bHwvmoL+4QsvqFnhs3w2E2BSvN4M9UI6jg50Tcf9Kaw+p
         insvAhdd/CuNG18jdqfcp05O80xzPRbTV3BZ4i3jRo+QxqdfyiNiOgsOAWPeiChQE6YR
         1Daw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781902783; x=1782507583;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XGMiHCA0HkBL+ewnAq1jWTHp0QfW/VL9HJke2P2Lnso=;
        b=lMafZtB4Ydl/1v9QjCBij7n1LzSz03vnKsclJb5U794MVO7sN6WxMSdCW8uMNnfXEW
         46IPB4zblMu2DYZz0LdatGfua5Q6ihLtOQDnm2rc+82WQ/JClaTFokwDSTGEys7Grh5j
         N97fZPqPH1Vn+cV298YjHh7La6MsX9v1QZMnGj6xHev+C46ven+cDzQbeyP6S3+4G4Vz
         lSsJlnoduiCqB9Wup4bfwy4OkLLZwCFNwrveyX9OFVb73NxwC0j6Eoil/nMaghe1qOsM
         kCXfkexwwQPuicmge0xZW/lEE2rgtEF4Qp3AaBni6znnBgVuNcLwQfy4ybqnw8/db9G1
         /yYQ==
X-Gm-Message-State: AOJu0Ywn9FxrbtbON78uMGNvr1cX7myuXafvS+48YDlcLHAgYArVVG+n
	2Hy9tbV0hsttGo+ZslMvowXp360apnmI+CK1aSH6CposOsDjIQXeFR1So8ggpGpf
X-Gm-Gg: AfdE7cnlPENQu6m82bEC2a/k3wicgU7KuuUMjORavHMNth6tUpV4OWuRWCrxISy0J2b
	FzCOTkv38ipmbVhPjadYlAa16ejHNsywW1W8O/95wFPw4czaphBU0D7xWxB1NvBisq9ufakhMls
	a0zbLabwAQ4egkRQgRCBczipOy9ht1RsPWTmILYJv6EOThIouZymHfkI9QzhBZYdjW4t8fa0buJ
	eSBvoye0FnxlyJsm6gV37FTATNFkzINFIQ9bOoI6Rqtz+ouNcYUqbmqgOTj8dR6FMtFSgJpuTab
	DKnYKO4ZW4tdsACETTWqVx7s3T0O8jDUz/leet5XqssA6AhW1aFlDLSERijZdv/j6LPddU61Ru4
	2ATnJTl4Ln3N9l7zXYnyghyhl28dntnZ6AB+kYVvHKR2UJ0JHgwptjtBogbq6dHlA4+5zPvaifl
	O9j/SN46+3zz7DRBL4cQ93BlBQ6zPEQgNNJ3xll3bSaikAmTNc/4vvWzWv+lx2lO30vrPyPztgY
	Ty23d+72wokWW2pvWs5i9iL0LYQ/zN3PjnSb/EP1AVM3zsJUVzgkcU=
X-Received: by 2002:a5d:608c:0:b0:464:98d2:4682 with SMTP id ffacd0b85a97d-465026e1126mr6743141f8f.35.1781902782894;
        Fri, 19 Jun 2026 13:59:42 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-466648c698dsm1998267f8f.16.2026.06.19.13.59.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2026 13:59:42 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v2 07/17] bpf: Track verifier context diagnostic events
Date: Fri, 19 Jun 2026 22:59:20 +0200
Message-ID: <20260619205934.1312876-8-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260619205934.1312876-1-memxor@gmail.com>
References: <20260619205934.1312876-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=11568; i=memxor@gmail.com; h=from:subject; bh=kwx88XHldEpP3rUuGxyOXPHuF7hVzAeEkFZEbyUp74I=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIct05f9G96pZmkvqwxVVby/9VhcwP3RR7+YayZIkvU6+K y43Vc06SlkYxLgYZMUUWUr+72MyPlH5O9B2GTfMHFYmkCEMXJwCMJGqC4wMO+RUbl61TQj7nNR7 qM20j63zWV84v6reVwN9za1lToy2jAxfxa+m5G6xrt7VlznvU+O0nLvrkk/m+Cv3G93UyTuZ7MQ EAA==
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

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/diagnostics.c | 85 +++++++++++++++++++++++++++++++++++++++-
 kernel/bpf/diagnostics.h | 20 ++++++++++
 kernel/bpf/verifier.c    | 35 ++++++++++++++---
 3 files changed, 133 insertions(+), 7 deletions(-)

diff --git a/kernel/bpf/diagnostics.c b/kernel/bpf/diagnostics.c
index 58cc7c18cf98..d6a9a2315f54 100644
--- a/kernel/bpf/diagnostics.c
+++ b/kernel/bpf/diagnostics.c
@@ -1041,6 +1041,53 @@ void bpf_diag_record_ref_release(struct bpf_verifier_env *env, u32 insn_idx,
 			    ref_id);
 }
 
+void bpf_diag_record_context(struct bpf_verifier_env *env, u32 insn_idx,
+			     enum bpf_diag_context_kind ctx_kind, bool enter,
+			     u32 depth)
+{
+	/* Keep leave events so context rendering can stop at a depth-zero exit
+	 * and show nested-region depth accurately for the active path.
+	 */
+	struct bpf_diag_history_event event = {
+		.insn_idx = insn_idx,
+		.kind = BPF_DIAG_HISTORY_CONTEXT,
+		.ctx.kind = ctx_kind,
+		.ctx.enter = enter,
+		.ctx.depth = depth,
+	};
+
+	if (ctx_kind == BPF_DIAG_CONTEXT_NONE)
+		return;
+
+	bpf_diag_append_history(env, &event);
+}
+
+static int bpf_diag_history_context_start_idx(const struct bpf_diag_log *log,
+					      const struct bpf_diag_history_opts *opts)
+{
+	int i;
+
+	if (!opts->ctx_depth)
+		return 0;
+
+	for (i = log->cnt; i > 0; i--) {
+		const struct bpf_diag_history_event *event;
+
+		event = bpf_diag_history_event(log, i - 1);
+
+		if (event->kind != BPF_DIAG_HISTORY_CONTEXT ||
+		    event->ctx.kind != opts->ctx_kind)
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
 	bool stack_slot_valid;
@@ -1147,6 +1194,8 @@ static int bpf_diag_history_start_idx(const struct bpf_diag_log *log,
 
 	if (!opts || opts->scope == BPF_DIAG_HISTORY_SCOPE_ALL)
 		return 0;
+	if (opts->scope == BPF_DIAG_HISTORY_SCOPE_CONTEXT)
+		return bpf_diag_history_context_start_idx(log, opts);
 	if (filter->stack_slot_valid)
 		return bpf_diag_history_stack_start_idx(log, filter);
 
@@ -1179,7 +1228,7 @@ bpf_diag_history_event_visible(const struct bpf_diag_history_event *event,
 	const struct bpf_diag_history_opts *opts = filter->opts;
 
 	if (!opts || opts->scope == BPF_DIAG_HISTORY_SCOPE_ALL)
-		return true;
+		return event->kind != BPF_DIAG_HISTORY_CONTEXT;
 
 	switch (event->kind) {
 	case BPF_DIAG_HISTORY_BRANCH:
@@ -1200,6 +1249,9 @@ bpf_diag_history_event_visible(const struct bpf_diag_history_event *event,
 	case BPF_DIAG_HISTORY_REF_RELEASE:
 		return opts->scope == BPF_DIAG_HISTORY_SCOPE_REF &&
 		       event->ref.ref_id == opts->ref_id;
+	case BPF_DIAG_HISTORY_CONTEXT:
+		return opts->scope == BPF_DIAG_HISTORY_SCOPE_CONTEXT &&
+		       event->ctx.kind == opts->ctx_kind;
 	default:
 		return false;
 	}
@@ -1584,6 +1636,33 @@ static void bpf_diag_print_ref_event(struct bpf_verifier_env *env,
 			       "owned resource (id=%u)", event->ref.ref_id);
 }
 
+static const char *bpf_diag_context_name(enum bpf_diag_context_kind kind)
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
+static void bpf_diag_print_context_event(struct bpf_verifier_env *env,
+					 const struct bpf_diag_history_event *event)
+{
+	bpf_diag_report_source(env, event->insn_idx, "context",
+			       "%s %s; depth is now %u",
+			       event->ctx.enter ? "entered" : "left",
+			       bpf_diag_context_name(event->ctx.kind),
+			       event->ctx.depth);
+}
+
 void bpf_diag_print_history(struct bpf_verifier_env *env,
 			    const struct bpf_diag_history_opts *opts)
 {
@@ -1638,6 +1717,10 @@ void bpf_diag_print_history(struct bpf_verifier_env *env,
 			bpf_diag_print_ref_event(env, event);
 			printed = true;
 			break;
+		case BPF_DIAG_HISTORY_CONTEXT:
+			bpf_diag_print_context_event(env, event);
+			printed = true;
+			break;
 		default:
 			break;
 		}
diff --git a/kernel/bpf/diagnostics.h b/kernel/bpf/diagnostics.h
index af8b738f7087..684574388343 100644
--- a/kernel/bpf/diagnostics.h
+++ b/kernel/bpf/diagnostics.h
@@ -83,6 +83,11 @@ struct bpf_diag_history_event {
 		struct {
 			u32 ref_id;
 		} ref;
+		struct {
+			u8 kind;
+			bool enter;
+			u32 depth;
+		} ctx;
 	};
 };
 
@@ -93,6 +98,7 @@ enum bpf_diag_history_kind {
 	BPF_DIAG_HISTORY_STACK_SLOT,
 	BPF_DIAG_HISTORY_REF_ACQUIRE,
 	BPF_DIAG_HISTORY_REF_RELEASE,
+	BPF_DIAG_HISTORY_CONTEXT,
 };
 
 enum bpf_diag_history_scope {
@@ -100,6 +106,15 @@ enum bpf_diag_history_scope {
 	BPF_DIAG_HISTORY_SCOPE_REG,
 	BPF_DIAG_HISTORY_SCOPE_STACK_ARG,
 	BPF_DIAG_HISTORY_SCOPE_REF,
+	BPF_DIAG_HISTORY_SCOPE_CONTEXT,
+};
+
+enum bpf_diag_context_kind {
+	BPF_DIAG_CONTEXT_NONE,
+	BPF_DIAG_CONTEXT_RCU,
+	BPF_DIAG_CONTEXT_PREEMPT,
+	BPF_DIAG_CONTEXT_IRQ,
+	BPF_DIAG_CONTEXT_LOCK,
 };
 
 struct bpf_diag_history_opts {
@@ -108,6 +123,8 @@ struct bpf_diag_history_opts {
 	int regno;
 	int stack_arg_slot;
 	u32 ref_id;
+	enum bpf_diag_context_kind ctx_kind;
+	u32 ctx_depth;
 };
 
 bool bpf_diag_enabled(const struct bpf_verifier_env *env);
@@ -164,6 +181,9 @@ void bpf_diag_record_ref_acquire(struct bpf_verifier_env *env, u32 insn_idx,
 				 u32 ref_id);
 void bpf_diag_record_ref_release(struct bpf_verifier_env *env, u32 insn_idx,
 				 u32 ref_id);
+void bpf_diag_record_context(struct bpf_verifier_env *env, u32 insn_idx,
+			     enum bpf_diag_context_kind ctx_kind, bool enter,
+			     u32 depth);
 void bpf_diag_print_history(struct bpf_verifier_env *env,
 			    const struct bpf_diag_history_opts *opts);
 
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 93941deb2cd8..e584dec04b34 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -1064,7 +1064,7 @@ static int is_iter_reg_valid_init(struct bpf_verifier_env *env, struct bpf_reg_s
 }
 
 static int acquire_irq_state(struct bpf_verifier_env *env, int insn_idx);
-static int release_irq_state(struct bpf_verifier_state *state, int id);
+static int release_irq_state(struct bpf_verifier_env *env, int id);
 
 static int mark_stack_slot_irq_flag(struct bpf_verifier_env *env,
 				     struct bpf_kfunc_call_arg_meta *meta,
@@ -1123,7 +1123,7 @@ static int unmark_stack_slot_irq_flag(struct bpf_verifier_env *env, struct bpf_r
 		return -EINVAL;
 	}
 
-	err = release_irq_state(env->cur_state, st->id);
+	err = release_irq_state(env, st->id);
 	WARN_ON_ONCE(err && err != -EACCES);
 	if (err) {
 		int insn_idx = 0;
@@ -1458,6 +1458,8 @@ static int acquire_lock_state(struct bpf_verifier_env *env, int insn_idx, enum r
 	state->active_locks++;
 	state->active_lock_id = id;
 	state->active_lock_ptr = ptr;
+	bpf_diag_record_context(env, insn_idx, BPF_DIAG_CONTEXT_LOCK, true,
+				state->active_locks);
 	return 0;
 }
 
@@ -1473,6 +1475,7 @@ static int acquire_irq_state(struct bpf_verifier_env *env, int insn_idx)
 	s->id = ++env->id_gen;
 
 	state->active_irq_id = s->id;
+	bpf_diag_record_context(env, insn_idx, BPF_DIAG_CONTEXT_IRQ, true, 1);
 	return s->id;
 }
 
@@ -1514,8 +1517,10 @@ static bool reg_is_referenced(struct bpf_verifier_env *env, const struct bpf_reg
 	return find_reference_state(env->cur_state, reg->id);
 }
 
-static int release_lock_state(struct bpf_verifier_state *state, int type, int id, void *ptr)
+static int release_lock_state(struct bpf_verifier_env *env, int type, int id,
+			      void *ptr)
 {
+	struct bpf_verifier_state *state = env->cur_state;
 	void *prev_ptr = NULL;
 	u32 prev_id = 0;
 	int i;
@@ -1528,6 +1533,9 @@ static int release_lock_state(struct bpf_verifier_state *state, int type, int id
 			/* Reassign active lock (id, ptr). */
 			state->active_lock_id = prev_id;
 			state->active_lock_ptr = prev_ptr;
+			bpf_diag_record_context(env, env->insn_idx,
+						BPF_DIAG_CONTEXT_LOCK, false,
+						state->active_locks);
 			return 0;
 		}
 		if (state->refs[i].type & REF_TYPE_LOCK_MASK) {
@@ -1538,8 +1546,9 @@ static int release_lock_state(struct bpf_verifier_state *state, int type, int id
 	return -EINVAL;
 }
 
-static int release_irq_state(struct bpf_verifier_state *state, int id)
+static int release_irq_state(struct bpf_verifier_env *env, int id)
 {
+	struct bpf_verifier_state *state = env->cur_state;
 	u32 prev_id = 0;
 	int i;
 
@@ -1552,6 +1561,9 @@ static int release_irq_state(struct bpf_verifier_state *state, int id)
 		if (state->refs[i].id == id) {
 			release_reference_state(state, i);
 			state->active_irq_id = prev_id;
+			bpf_diag_record_context(env, env->insn_idx,
+						BPF_DIAG_CONTEXT_IRQ, false,
+						state->active_irq_id ? 1 : 0);
 			return 0;
 		} else {
 			prev_id = state->refs[i].id;
@@ -7209,7 +7221,7 @@ static int process_spin_lock(struct bpf_verifier_env *env, struct bpf_reg_state
 			verbose(env, "%s_unlock cannot be out of order\n", lock_str);
 			return -EINVAL;
 		}
-		if (release_lock_state(cur, type, reg->id, ptr)) {
+		if (release_lock_state(env, type, reg->id, ptr)) {
 			verbose(env, "%s_unlock of different lock\n", lock_str);
 			return -EINVAL;
 		}
@@ -13290,21 +13302,32 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 
 	if (rcu_lock) {
 		env->cur_state->active_rcu_locks++;
+		bpf_diag_record_context(env, insn_idx, BPF_DIAG_CONTEXT_RCU,
+					true, env->cur_state->active_rcu_locks);
 	} else if (rcu_unlock) {
 		if (env->cur_state->active_rcu_locks == 0) {
 			verbose(env, "unmatched rcu read unlock (kernel function %s)\n", func_name);
 			return -EINVAL;
 		}
-		if (--env->cur_state->active_rcu_locks == 0)
+		env->cur_state->active_rcu_locks--;
+		bpf_diag_record_context(env, insn_idx, BPF_DIAG_CONTEXT_RCU,
+					false, env->cur_state->active_rcu_locks);
+		if (env->cur_state->active_rcu_locks == 0)
 			invalidate_rcu_protected_refs(env);
 	} else if (preempt_disable) {
 		env->cur_state->active_preempt_locks++;
+		bpf_diag_record_context(env, insn_idx,
+					BPF_DIAG_CONTEXT_PREEMPT, true,
+					env->cur_state->active_preempt_locks);
 	} else if (preempt_enable) {
 		if (env->cur_state->active_preempt_locks == 0) {
 			verbose(env, "unmatched attempt to enable preemption (kernel function %s)\n", func_name);
 			return -EINVAL;
 		}
 		env->cur_state->active_preempt_locks--;
+		bpf_diag_record_context(env, insn_idx,
+					BPF_DIAG_CONTEXT_PREEMPT, false,
+					env->cur_state->active_preempt_locks);
 	}
 
 	if (sleepable && !in_sleepable_context(env)) {
-- 
2.53.0

