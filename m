Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71ABD409101
	for <bpf@vger.kernel.org>; Fri,  5 Jun 2026 06:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780641264; cv=none; b=UMou7r9J0mV7/AYi9TZjX0aoOXpSxDndbBckK4pD76GkzWTV/VNeAFCMP0OoM6a5HuwiUSAUjx29wlBCCX38coXtu9H3pRc3j8FIMooIFYZPOxx4xxHvFNJUmJ3tJ+VdVRBFGVE3mG1oROBIfzCQhc+piu77RiHGwFdXj2fbkjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780641264; c=relaxed/simple;
	bh=+2Voodl/vRxADctM6m9uTfPl4s496mFwiTUGQVD/U8E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UdvTnLYwvXclXQdj67rGQ4Tmjnm6nLOP9zFsBkC17pCvn8VvItkNrZO8fZUOGzO/0bmqAPi+2Y6xneWGzZsLsM5Z42Iisbq4e4Tg3KmLSvv+xX6MY9GAwXjcGtiwntlZDnsgcY25vFeQYXaYZVRSuo7KvoKm1OCxLSxkFI9EjDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rT4/eDzU; arc=none smtp.client-ip=209.85.128.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rT4/eDzU"
Received: by mail-wm1-f67.google.com with SMTP id 5b1f17b1804b1-4906869f0cbso18138705e9.1
        for <bpf@vger.kernel.org>; Thu, 04 Jun 2026 23:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780641261; x=1781246061; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9tYNGSZEyq6Q8eaEW9n3GPLAAbJU7FTF76CaCl6Bxko=;
        b=rT4/eDzUz6FtH9OOgXLSsx+aNwnZhdxFrr/MVP9qOL6roIUvrEWfHNRpnk+rSXp53j
         zRf3jJUIlxANLBwbDjMQa124Pvhva7JwO5YS6XURxB5rHfgjf36mbruinYtw0z6OTeu3
         Z1gokUeBcabRXOUTDv3+BWdi1CzMX44Qdv6Afn6k7KBoIrneBgScjA/a3gDuwTxQs3P+
         kPeBNRotdnTMTU9eJPqk7be9J7ywT0+GfkMcTt9L/GmUdZnASde+QXLs9AzGm+Iz4/YP
         nZPDAFMSrHYMpKT274SLcCgJ27ucspO3D49DHKSb8XdOoaGFt9JAP9n1bq68wb7kMwO7
         pHYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780641261; x=1781246061;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9tYNGSZEyq6Q8eaEW9n3GPLAAbJU7FTF76CaCl6Bxko=;
        b=FQC58bRUJSedzfVIgxdS/jajEDqisaPESNNdKyxWKLIR4calPqRVm82HAAUzIUvTU8
         JiqPi0NORI9f4HxgURxyEHdo45OIfFECCvHLrMyIEZIH9HZuFpyIOt6QWSjemAzw6ifI
         NTL5bvkd5o6+AMqMC3oACgPEdsA8KchIc36yJkC4diAnxvSY9Zy3Wtew5RsWq2OA94bf
         RNuijibZsmSIeaIV0IKw3YYiCD2+u62mCk18mpcd9npBwbpmEhHkShsD0VeVLHpc6eQD
         JHu3uXFBlDRJn0Lc8Hono4oDBlJqzvXBtWCBghA+lKqKxSrY3R7ET518vSmcTUio1vSN
         2T0A==
X-Gm-Message-State: AOJu0Yw+XQ/NcS34JUSnJ4zAwSLnBo7Fi0nu6v6WNrOeJXKxgjl6xHRy
	TW+w5Mp0h8JzvSV0uPWg9FvICtILldQK6FZ+Sf1XACAfw59vO1UA0iGtf57S8AgI
X-Gm-Gg: Acq92OG2s0t5B31GCL5nij6d2BehigYP6QpJ54xNuu3D3VH1amsQmvnym30m7/GzGmB
	3NCgouJ3Z7DeuqwDTKWhVHEYjQtMHPOYZty+v4sargzbLFJS2GrQ5KX6ACcbaWwTGuZHcRf+LcV
	hsfN0RRUXDisFOTwwTllvA6udfcnBUyIREfvSJM6YZuXut8+QU+i2XQcjCwPnlswynFwUOkkE4x
	gzmseY9c5MO5qDjbBCFaRKz6w6FqzHJTXsBoiEApRpkpk8xwipl4qVHGhYc5PHfXcYyKM+fmZ9k
	qVrcF4T2s0DkXAwY3UqsfvGS8LXOjgOPwDCKMSFPN7PVQMh4ojbKb/yDvFdKWVV0rUp1F7zDyPB
	49ojfkKrlCKa2zGQV990fQx8oaPrpCEoEgaqeIWDhE9+BpokpVUl21LxUlSktQsCGCMfnIbNajl
	EaSrGM1nZcWK/64CzBlzv0fo/3lfs26zWPRlX6rEjOHbIFDI0ADtR9wUeW6pagMZYxohv1UT1uU
	jSk7uUY6y/m9x/Un120XTnQGv0eMDn6E2hA0bUbf9KbKy/qgIO7LmtVyApsbN6F56QmttaNDApK
X-Received: by 2002:a05:600c:3551:b0:490:4b89:535f with SMTP id 5b1f17b1804b1-490c25c818cmr30180565e9.8.1780641260676;
        Thu, 04 Jun 2026 23:34:20 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f2dcde3sm25492680f8f.1.2026.06.04.23.34.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 23:34:19 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 07/17] bpf: Track verifier context diagnostic history
Date: Fri,  5 Jun 2026 08:33:57 +0200
Message-ID: <20260605063412.974640-8-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260605063412.974640-1-memxor@gmail.com>
References: <20260605063412.974640-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=10929; i=memxor@gmail.com; h=from:subject; bh=+2Voodl/vRxADctM6m9uTfPl4s496mFwiTUGQVD/U8E=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIUsptzin3sqV6R/vm0S9w0nZkUua7WJ/iYnci7z2/mTTu TOfl+/vKGVhEONikBVTZCn5v4/J+ETl70DbZdwwc1iZQIYwcHEKwERcdjH80z9RmfWtffVVh136 95/+nJtuNmfGvhe/UrUP3Gt1LxFdn8PI8FRWQ/5ahdA8F57pi+JzL658e2j9lI3n0osrv7yXNZ5 6hwMA
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Record verifier context transitions in the diagnostic history so later
reports can anchor causal paths to the critical section that made an
operation invalid.

This covers lock, IRQ, RCU, and preempt regions without adding any new
verifier error reports. Category-specific commits decide where those
recorded events should be rendered.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/diagnostics.c | 62 ++++++++++++++++++++++++++++++++++++++++
 kernel/bpf/diagnostics.h | 19 ++++++++++++
 kernel/bpf/verifier.c    | 39 +++++++++++++++++++++----
 3 files changed, 114 insertions(+), 6 deletions(-)

diff --git a/kernel/bpf/diagnostics.c b/kernel/bpf/diagnostics.c
index 56c1236ffe7c..7a122c5025c2 100644
--- a/kernel/bpf/diagnostics.c
+++ b/kernel/bpf/diagnostics.c
@@ -241,6 +241,8 @@ static const char *bpf_diag_marker_label(char marker)
 		return "acquired";
 	case '-':
 		return "released";
+	case '@':
+		return "context";
 	default:
 		return "note";
 	}
@@ -438,6 +440,23 @@ static const char *bpf_diag_category_name(enum bpf_diag_category category)
 	}
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
 void bpf_diag_report_header(struct bpf_verifier_env *env,
 			    enum bpf_diag_category category,
 			    const char *problem)
@@ -868,6 +887,24 @@ void bpf_diag_record_ref_release(struct bpf_verifier_state *state, u32 insn_idx,
 			    ref_id);
 }
 
+void bpf_diag_record_context(struct bpf_verifier_state *state, u32 insn_idx,
+			     enum bpf_diag_context_kind ctx_kind, bool enter,
+			     u32 depth)
+{
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
+	bpf_diag_append_history(state, &event);
+}
+
 static int bpf_diag_history_start_idx(const struct bpf_verifier_state *state,
 				      const struct bpf_diag_history_opts *opts)
 {
@@ -893,8 +930,16 @@ static int bpf_diag_history_start_idx(const struct bpf_verifier_state *state,
 		    event->kind == BPF_DIAG_HISTORY_REF_ACQUIRE &&
 		    event->ref.ref_id == opts->ref_id)
 			return i - 1;
+		if (opts->scope == BPF_DIAG_HISTORY_SCOPE_CONTEXT &&
+		    event->kind == BPF_DIAG_HISTORY_CONTEXT &&
+		    event->ctx.enter &&
+		    event->ctx.kind == opts->ctx_kind)
+			return i - 1;
 	}
 
+	if (opts->scope == BPF_DIAG_HISTORY_SCOPE_CONTEXT)
+		return state->diag_history_cnt;
+
 	return 0;
 }
 
@@ -919,6 +964,9 @@ static bool bpf_diag_history_event_visible(const struct bpf_diag_history_event *
 	case BPF_DIAG_HISTORY_REF_RELEASE:
 		return opts->scope == BPF_DIAG_HISTORY_SCOPE_REF &&
 		       event->ref.ref_id == opts->ref_id;
+	case BPF_DIAG_HISTORY_CONTEXT:
+		return opts->scope == BPF_DIAG_HISTORY_SCOPE_CONTEXT &&
+		       event->ctx.kind == opts->ctx_kind;
 	default:
 		return false;
 	}
@@ -1132,6 +1180,16 @@ static void bpf_diag_print_ref_event(struct bpf_verifier_env *env,
 			       event->ref.ref_id);
 }
 
+static void bpf_diag_print_context_event(struct bpf_verifier_env *env,
+					 const struct bpf_diag_history_event *event)
+{
+	bpf_diag_report_source(env, event->insn_idx, '@',
+			       "%s %s; depth is now %u",
+			       event->ctx.enter ? "entered" : "left",
+			       bpf_diag_context_name(event->ctx.kind),
+			       event->ctx.depth);
+}
+
 void bpf_diag_print_history(struct bpf_verifier_env *env,
 			    const struct bpf_diag_history_opts *opts)
 {
@@ -1175,6 +1233,10 @@ void bpf_diag_print_history(struct bpf_verifier_env *env,
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
index c6ace61547c6..ff6c55f9b5f7 100644
--- a/kernel/bpf/diagnostics.h
+++ b/kernel/bpf/diagnostics.h
@@ -72,6 +72,11 @@ struct bpf_diag_history_event {
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
 
@@ -83,6 +88,7 @@ enum bpf_diag_history_kind {
 	BPF_DIAG_HISTORY_STACK_ARG,
 	BPF_DIAG_HISTORY_REF_ACQUIRE,
 	BPF_DIAG_HISTORY_REF_RELEASE,
+	BPF_DIAG_HISTORY_CONTEXT,
 };
 
 enum bpf_diag_history_scope {
@@ -90,6 +96,15 @@ enum bpf_diag_history_scope {
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
 
 enum bpf_diag_stack_arg_reason {
@@ -104,6 +119,7 @@ struct bpf_diag_history_opts {
 	int regno;
 	int stack_arg_slot;
 	u32 ref_id;
+	enum bpf_diag_context_kind ctx_kind;
 };
 
 struct bpf_verifier_env;
@@ -145,6 +161,9 @@ void bpf_diag_record_ref_acquire(struct bpf_verifier_state *state, u32 insn_idx,
 				 u32 ref_id);
 void bpf_diag_record_ref_release(struct bpf_verifier_state *state, u32 insn_idx,
 				 u32 ref_id);
+void bpf_diag_record_context(struct bpf_verifier_state *state, u32 insn_idx,
+			     enum bpf_diag_context_kind ctx_kind, bool enter,
+			     u32 depth);
 void bpf_diag_print_history(struct bpf_verifier_env *env,
 			    const struct bpf_diag_history_opts *opts);
 
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 9b9ffa57b95a..7bb2a81ee353 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -1060,7 +1060,8 @@ static int is_iter_reg_valid_init(struct bpf_verifier_env *env, struct bpf_reg_s
 }
 
 static int acquire_irq_state(struct bpf_verifier_env *env, int insn_idx);
-static int release_irq_state(struct bpf_verifier_state *state, int id);
+static int release_irq_state(struct bpf_verifier_state *state, int id,
+			     int insn_idx);
 
 static int mark_stack_slot_irq_flag(struct bpf_verifier_env *env,
 				     struct bpf_kfunc_call_arg_meta *meta,
@@ -1119,7 +1120,7 @@ static int unmark_stack_slot_irq_flag(struct bpf_verifier_env *env, struct bpf_r
 		return -EINVAL;
 	}
 
-	err = release_irq_state(env->cur_state, st->id);
+	err = release_irq_state(env->cur_state, st->id, env->insn_idx);
 	WARN_ON_ONCE(err && err != -EACCES);
 	if (err) {
 		int insn_idx = 0;
@@ -1454,6 +1455,8 @@ static int acquire_lock_state(struct bpf_verifier_env *env, int insn_idx, enum r
 	state->active_locks++;
 	state->active_lock_id = id;
 	state->active_lock_ptr = ptr;
+	bpf_diag_record_context(state, insn_idx, BPF_DIAG_CONTEXT_LOCK, true,
+				state->active_locks);
 	return 0;
 }
 
@@ -1469,6 +1472,8 @@ static int acquire_irq_state(struct bpf_verifier_env *env, int insn_idx)
 	s->id = ++env->id_gen;
 
 	state->active_irq_id = s->id;
+	bpf_diag_record_context(state, insn_idx, BPF_DIAG_CONTEXT_IRQ, true,
+				1);
 	return s->id;
 }
 
@@ -1510,7 +1515,8 @@ static bool reg_is_referenced(struct bpf_verifier_env *env, const struct bpf_reg
 	return find_reference_state(env->cur_state, reg->id);
 }
 
-static int release_lock_state(struct bpf_verifier_state *state, int type, int id, void *ptr)
+static int release_lock_state(struct bpf_verifier_state *state, int type,
+			      int id, void *ptr, int insn_idx)
 {
 	void *prev_ptr = NULL;
 	u32 prev_id = 0;
@@ -1524,6 +1530,9 @@ static int release_lock_state(struct bpf_verifier_state *state, int type, int id
 			/* Reassign active lock (id, ptr). */
 			state->active_lock_id = prev_id;
 			state->active_lock_ptr = prev_ptr;
+			bpf_diag_record_context(state, insn_idx,
+						BPF_DIAG_CONTEXT_LOCK, false,
+						state->active_locks);
 			return 0;
 		}
 		if (state->refs[i].type & REF_TYPE_LOCK_MASK) {
@@ -1534,7 +1543,8 @@ static int release_lock_state(struct bpf_verifier_state *state, int type, int id
 	return -EINVAL;
 }
 
-static int release_irq_state(struct bpf_verifier_state *state, int id)
+static int release_irq_state(struct bpf_verifier_state *state, int id,
+			     int insn_idx)
 {
 	u32 prev_id = 0;
 	int i;
@@ -1548,6 +1558,9 @@ static int release_irq_state(struct bpf_verifier_state *state, int id)
 		if (state->refs[i].id == id) {
 			release_reference_state(state, i);
 			state->active_irq_id = prev_id;
+			bpf_diag_record_context(state, insn_idx,
+						BPF_DIAG_CONTEXT_IRQ, false,
+						state->active_irq_id ? 1 : 0);
 			return 0;
 		} else {
 			prev_id = state->refs[i].id;
@@ -7084,7 +7097,8 @@ static int process_spin_lock(struct bpf_verifier_env *env, struct bpf_reg_state
 			verbose(env, "%s_unlock cannot be out of order\n", lock_str);
 			return -EINVAL;
 		}
-		if (release_lock_state(cur, type, reg->id, ptr)) {
+		if (release_lock_state(cur, type, reg->id, ptr,
+				       env->insn_idx)) {
 			verbose(env, "%s_unlock of different lock\n", lock_str);
 			return -EINVAL;
 		}
@@ -13029,21 +13043,34 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 
 	if (rcu_lock) {
 		env->cur_state->active_rcu_locks++;
+		bpf_diag_record_context(env->cur_state, insn_idx,
+					BPF_DIAG_CONTEXT_RCU, true,
+					env->cur_state->active_rcu_locks);
 	} else if (rcu_unlock) {
 		if (env->cur_state->active_rcu_locks == 0) {
 			verbose(env, "unmatched rcu read unlock (kernel function %s)\n", func_name);
 			return -EINVAL;
 		}
-		if (--env->cur_state->active_rcu_locks == 0)
+		env->cur_state->active_rcu_locks--;
+		bpf_diag_record_context(env->cur_state, insn_idx,
+					BPF_DIAG_CONTEXT_RCU, false,
+					env->cur_state->active_rcu_locks);
+		if (env->cur_state->active_rcu_locks == 0)
 			invalidate_rcu_protected_refs(env);
 	} else if (preempt_disable) {
 		env->cur_state->active_preempt_locks++;
+		bpf_diag_record_context(env->cur_state, insn_idx,
+					BPF_DIAG_CONTEXT_PREEMPT, true,
+					env->cur_state->active_preempt_locks);
 	} else if (preempt_enable) {
 		if (env->cur_state->active_preempt_locks == 0) {
 			verbose(env, "unmatched attempt to enable preemption (kernel function %s)\n", func_name);
 			return -EINVAL;
 		}
 		env->cur_state->active_preempt_locks--;
+		bpf_diag_record_context(env->cur_state, insn_idx,
+					BPF_DIAG_CONTEXT_PREEMPT, false,
+					env->cur_state->active_preempt_locks);
 	}
 
 	if (sleepable && !in_sleepable_context(env)) {
-- 
2.53.0

