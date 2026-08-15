Received: from mail-wr2-f1.google.com (mail-wr2-f1.google.com [74.125.225.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 948633B38BE
	for <bpf@vger.kernel.org>; Sat, 15 Aug 2026 06:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786776404; cv=none; b=W1RBr2HGZRZ5OXlSJykUH16n1nhIkat2PR6ErGuX3uB+UwnWYgIpWHs7qSQBuQMMGg9vCYSXrxk7fwBIUf/hxSSqcV0rh8nvMRRt5KhJipmyB/3FWwvYWmfvQVhxSAh4NgQtpml9AqMKOhz0QDrBNa70URN/dR/0ADp5AC1XqCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786776404; c=relaxed/simple;
	bh=KrGJg4NnvH8Ieit+0FOu57BILVLEo17uMlaD6hnpZlU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=buaLEdb+4+uEjaCIT0Se3IjkCa0SJA3Kk0Eus0myBBLkA28EDd7wqMxV6AwWjMJRauNx7ostDaoxdnXUP/MIRejbd2seDMwdh4rnbX/Kxv4x8AttJdZm+8/Wl4mIm7Ywz0Z+heDm1fpLipjZ9OyBR5xQHQc45P6j3wBZSLrMbE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c9BXCq3J; arc=none smtp.client-ip=74.125.225.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c9BXCq3J"
Received: by mail-wr2-f1.google.com with SMTP id ffacd0b85a97d-47f9c6bc99eso373991f8f.0
        for <bpf@vger.kernel.org>; Fri, 14 Aug 2026 23:46:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786776384; x=1787381184; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BWOp65rFtgfUbhq8AmKpOuTcTn86X3gvGdD/IdRtmME=;
        b=c9BXCq3JzTVaUtBpJKO4eqp/Hf7hvves9VZFznpHAl74OLgonyQbbsKS2c1bd5Rg5J
         gSBMF3OHbK7uJu7Rhm8d9XpSHR/ctktztQPYtXaALOONu0tvJj/MhKd+dtwScyDhFays
         9VqcAdZMm62JpkohERfO9IBPfvKIHabmsdmsxCwjOZ0mBxLdtFZT98b0tNZcHWjfFSBU
         UMYv/sDiAKgBFk8pQE0iN9QNcGWv3PXoBjwNs0Rhn2Qe8G1IN6rxAODw7BbDIFDmYF0f
         EJW2/Gfluh2ztPSC1u4T8WxNdtR3bUeA2OT8rNPwhE13KABPQGjnE6WvCOpm+rtpbsvL
         kAew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786776384; x=1787381184;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=BWOp65rFtgfUbhq8AmKpOuTcTn86X3gvGdD/IdRtmME=;
        b=N15ZKaccYz141H/OHmm2Ou3fj2Ko8ZJjs7q+8YyxSWpKpet52hQPugwjE6HojLrVka
         DoHrJ6z9etOKi5a0JPzddedo0nO3Vo1xBEKN+kt9DmvQRfNLKL0aoI6WCPav5NR5AJg2
         Q1WTumZ1adUU2/gxVPD/WGjUoErxWXdYbX9hxCKUNA7WQ66KXf16rtot3M/Jy5RHN1zm
         RuPJOtxfxuY/XSmg0SR/UYTCD8+vcGvhnK30WRNHdwJsXFTdBNvwY8ZLNYO7k4F60l69
         dmB0ECorLPcOSZV7et6CZgRwaLi9ZHmgfkbqeEpnSb60tIQ6K4dvC5ulpUmjWFJy5l00
         l73A==
X-Gm-Message-State: AOJu0YzT3I7cLqH0z3b5k5Mm8f7coSiEd1PA/VRjYAhc3k9IhEMFahoW
	26RXjRniay2qLagCY/nWAUsOOi7BSp4JiEi94w3YQ7w3T2pM5EU7mFMunSbAWaeT
X-Gm-Gg: AR+sD12cZ+aTST4dXWejk7ACqNYXWBcrxeN7KNyckRj6Pu5I+gK/Z7C3r2VMdzaQpCQ
	RSIZW0gciqQQoetB64QeQRrvUytv55oxbiBJh/qOLFAZyv8RhjUHHGuBogAltzy47/aeU6dqe/X
	LLMXj5qU/wFDZVLkXIEWZa1mzMOGaXhm9JGkuytyobMEAhFa+kcG4aD0xhR4dAwjpnFetBjgKUx
	I5056iILSIA03PsiMhzd6GMCqkhAaocUZoG77Arcu+YB0T6xQO5gsY6sxpEkR03zCXJSAXgstE6
	08DtfdgFWGI5jOqceFhinbqvXpqFQqReSQFbxlit9NPPQJp/pK8BTi3K5HZ/V2pB9fjWK9NPHVf
	693XAj3iyMbWYSM8wqjOzjI89y1b4k0sSiUBi8+3eOJJKKzNWCZLijOM9dD9E7ildYxjnLeTFlL
	yKbIj+EqPE9YjfHA4KU7KbGqYlaCQg90+sFDxnsuTeR4YVmwTBNVQRMNytSnKupouujtmrfnf9e
	CY/N//Pd/jcPbPjTu3jB6iCTQ1EqAG7DhBU2qRInSYhxRxoaQjYOJl8SaWi3mJfkpl20+qnsTr/
	5rF4Frlf8iz/Ok3WG8FqJz187sV9L6AM
X-Received: by 2002:a5d:5448:0:b0:47f:80ef:2c50 with SMTP id ffacd0b85a97d-48160756851mr13842850f8f.23.1786776383595;
        Fri, 14 Aug 2026 23:46:23 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4815f2c1307sm14707885f8f.27.2026.08.14.23.46.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 23:46:23 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v5 07/14] bpf: Track verifier context diagnostic events
Date: Sat, 15 Aug 2026 08:46:02 +0200
Message-ID: <20260815064612.378577-8-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260815064612.378577-1-memxor@gmail.com>
References: <20260815064612.378577-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=9465; i=memxor@gmail.com; h=from:subject; bh=KrGJg4NnvH8Ieit+0FOu57BILVLEo17uMlaD6hnpZlU=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIauBy4f5ctf9cvUb/0Ukn36K6rvZdOeHw4ObWwRWq2+60 ZO/76x3RykLgxgXg6yYIkvJ/31MxicqfwfaLuOGmcPKBDKEgYtTACby5jojw6f9G+I0Wxwu1zQp H27Yq8gQ/FdzQUphZCrv47crdfamBzP8zztyZ8I/pbltPzW1HHrVreyrFY8fft//MHNXyo8gBYW lHAA=
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

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/diagnostics.c | 39 +++++++++++++++++++++++++++++++++++++++
 kernel/bpf/diagnostics.h | 12 ++++++++++++
 kernel/bpf/verifier.c    | 28 +++++++++++++++++++++++-----
 3 files changed, 74 insertions(+), 5 deletions(-)

diff --git a/kernel/bpf/diagnostics.c b/kernel/bpf/diagnostics.c
index ddeaff1e90b7..15bca8a02a48 100644
--- a/kernel/bpf/diagnostics.c
+++ b/kernel/bpf/diagnostics.c
@@ -104,6 +104,7 @@ enum bpf_diag_history_kind {
 	BPF_DIAG_HISTORY_MOD,
 	BPF_DIAG_HISTORY_REF_ACQUIRE,
 	BPF_DIAG_HISTORY_REF_RELEASE,
+	BPF_DIAG_HISTORY_CONTEXT,
 };
 
 struct bpf_diag_history_event {
@@ -124,6 +125,11 @@ struct bpf_diag_history_event {
 		struct {
 			u32 ref_id;
 		} ref;
+		struct {
+			u32 depth;
+			u8 kind;
+			bool enter;
+		} ctx;
 	};
 };
 
@@ -388,6 +394,19 @@ void bpf_diag_event_log_restore(struct bpf_verifier_env *env, u64 log_pos)
 	log->cnt = log_pos - log->first_seq;
 }
 
+u32 bpf_diag_irq_depth(const struct bpf_verifier_state *state)
+{
+	u32 depth = 0;
+	int i;
+
+	for (i = 0; i < state->acquired_refs; i++) {
+		if (state->refs[i].type == REF_TYPE_IRQ)
+			depth++;
+	}
+
+	return depth;
+}
+
 static void diag_append_history(struct bpf_verifier_env *env,
 				const struct bpf_diag_history_event *event)
 {
@@ -1049,3 +1068,23 @@ void bpf_diag_record_ref_release(struct bpf_verifier_env *env, u32 insn_idx, u32
 {
 	diag_record_ref(env, insn_idx, BPF_DIAG_HISTORY_REF_RELEASE, ref_id);
 }
+
+void bpf_diag_record_context(struct bpf_verifier_env *env, u32 insn_idx,
+			     enum bpf_diag_context_kind ctx_kind, bool enter, u32 depth)
+{
+	/*
+	 * Keep leave events so context rendering can stop at a depth-zero exit
+	 * and show nested-region depth accurately for the active path.
+	 */
+	struct bpf_diag_history_event event = {
+		.insn_idx = insn_idx,
+		.kind = BPF_DIAG_HISTORY_CONTEXT,
+		.ctx = {
+			.kind = ctx_kind,
+			.enter = enter,
+			.depth = depth,
+		},
+	};
+
+	diag_append_history(env, &event);
+}
diff --git a/kernel/bpf/diagnostics.h b/kernel/bpf/diagnostics.h
index d17b498a3f66..ed64776736c6 100644
--- a/kernel/bpf/diagnostics.h
+++ b/kernel/bpf/diagnostics.h
@@ -11,6 +11,7 @@
 struct bpf_func_state;
 struct bpf_reg_state;
 struct bpf_verifier_env;
+struct bpf_verifier_state;
 struct btf;
 
 enum bpf_diag_mod_reason {
@@ -23,6 +24,14 @@ enum bpf_diag_mod_reason {
 	BPF_DIAG_MOD_CALLER_SAVED,
 };
 
+enum bpf_diag_context_kind {
+	BPF_DIAG_CONTEXT_NONE,
+	BPF_DIAG_CONTEXT_RCU,
+	BPF_DIAG_CONTEXT_PREEMPT,
+	BPF_DIAG_CONTEXT_IRQ,
+	BPF_DIAG_CONTEXT_LOCK,
+};
+
 bool bpf_diag_enabled(const struct bpf_verifier_env *env);
 int bpf_diag_init(struct bpf_verifier_env *env);
 void bpf_diag_init_frame(struct bpf_verifier_env *env, struct bpf_func_state *state);
@@ -33,6 +42,7 @@ const char *bpf_diag_fmt(struct bpf_verifier_env *env, const char *fmt, ...) __p
 const char *bpf_diag_fmt_btf_type(struct bpf_verifier_env *env, const struct btf *btf, u32 type_id);
 u64 bpf_diag_event_log_save(struct bpf_verifier_env *env);
 void bpf_diag_event_log_restore(struct bpf_verifier_env *env, u64 log_pos);
+u32 bpf_diag_irq_depth(const struct bpf_verifier_state *state);
 void bpf_diag_free(struct bpf_verifier_env *env);
 void bpf_diag_record_branch(struct bpf_verifier_env *env, u32 insn_idx, bool cond_true);
 void bpf_diag_mod_begin(struct bpf_verifier_env *env, const struct bpf_reg_state *reg,
@@ -45,5 +55,7 @@ void bpf_diag_record_scrub_stack(struct bpf_verifier_env *env,
 				 enum bpf_diag_mod_reason reason);
 void bpf_diag_record_ref_acquire(struct bpf_verifier_env *env, u32 insn_idx, u32 ref_id);
 void bpf_diag_record_ref_release(struct bpf_verifier_env *env, u32 insn_idx, u32 ref_id);
+void bpf_diag_record_context(struct bpf_verifier_env *env, u32 insn_idx,
+			     enum bpf_diag_context_kind ctx_kind, bool enter, u32 depth);
 
 #endif /* __BPF_DIAGNOSTICS_H */
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 8e32fa5fa30a..1f2a7f480ce3 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -1045,7 +1045,7 @@ static int is_iter_reg_valid_init(struct bpf_verifier_env *env, struct bpf_reg_s
 }
 
 static int acquire_irq_state(struct bpf_verifier_env *env, int insn_idx);
-static int release_irq_state(struct bpf_verifier_state *state, int id);
+static int release_irq_state(struct bpf_verifier_env *env, int id);
 
 static int mark_stack_slot_irq_flag(struct bpf_verifier_env *env,
 				     struct bpf_call_arg_meta *meta,
@@ -1104,7 +1104,7 @@ static int unmark_stack_slot_irq_flag(struct bpf_verifier_env *env, struct bpf_r
 		return -EINVAL;
 	}
 
-	err = release_irq_state(env->cur_state, st->id);
+	err = release_irq_state(env, st->id);
 	WARN_ON_ONCE(err && err != -EACCES);
 	if (err) {
 		int insn_idx = 0;
@@ -1439,6 +1439,8 @@ static int acquire_lock_state(struct bpf_verifier_env *env, int insn_idx, enum r
 	state->active_locks++;
 	state->active_lock_id = id;
 	state->active_lock_ptr = ptr;
+	bpf_diag_record_context(env, insn_idx, BPF_DIAG_CONTEXT_LOCK, true,
+				state->active_locks);
 	return 0;
 }
 
@@ -1454,6 +1456,8 @@ static int acquire_irq_state(struct bpf_verifier_env *env, int insn_idx)
 	s->id = ++env->id_gen;
 
 	state->active_irq_id = s->id;
+	bpf_diag_record_context(env, insn_idx, BPF_DIAG_CONTEXT_IRQ, true,
+				bpf_diag_irq_depth(state));
 	return s->id;
 }
 
@@ -1495,8 +1499,9 @@ static bool reg_is_referenced(struct bpf_verifier_env *env, const struct bpf_reg
 	return find_reference_state(env->cur_state, reg->id);
 }
 
-static int release_lock_state(struct bpf_verifier_state *state, int type, int id, void *ptr)
+static int release_lock_state(struct bpf_verifier_env *env, int type, int id, void *ptr)
 {
+	struct bpf_verifier_state *state = env->cur_state;
 	void *prev_ptr = NULL;
 	u32 prev_id = 0;
 	int i;
@@ -1509,6 +1514,8 @@ static int release_lock_state(struct bpf_verifier_state *state, int type, int id
 			/* Reassign active lock (id, ptr). */
 			state->active_lock_id = prev_id;
 			state->active_lock_ptr = prev_ptr;
+			bpf_diag_record_context(env, env->insn_idx, BPF_DIAG_CONTEXT_LOCK,
+						false, state->active_locks);
 			return 0;
 		}
 		if (state->refs[i].type & REF_TYPE_LOCK_MASK) {
@@ -1519,8 +1526,9 @@ static int release_lock_state(struct bpf_verifier_state *state, int type, int id
 	return -EINVAL;
 }
 
-static int release_irq_state(struct bpf_verifier_state *state, int id)
+static int release_irq_state(struct bpf_verifier_env *env, int id)
 {
+	struct bpf_verifier_state *state = env->cur_state;
 	u32 prev_id = 0;
 	int i;
 
@@ -1533,6 +1541,8 @@ static int release_irq_state(struct bpf_verifier_state *state, int id)
 		if (state->refs[i].id == id) {
 			release_reference_state(state, i);
 			state->active_irq_id = prev_id;
+			bpf_diag_record_context(env, env->insn_idx, BPF_DIAG_CONTEXT_IRQ,
+						false, bpf_diag_irq_depth(state));
 			return 0;
 		} else {
 			prev_id = state->refs[i].id;
@@ -7181,7 +7191,7 @@ static int process_spin_lock(struct bpf_verifier_env *env, struct bpf_reg_state
 			verbose(env, "%s_unlock cannot be out of order\n", lock_str);
 			return -EINVAL;
 		}
-		if (release_lock_state(cur, type, reg->id, ptr)) {
+		if (release_lock_state(env, type, reg->id, ptr)) {
 			verbose(env, "%s_unlock of different lock\n", lock_str);
 			return -EINVAL;
 		}
@@ -13242,22 +13252,30 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 
 	if (rcu_lock) {
 		env->cur_state->active_rcu_locks++;
+		bpf_diag_record_context(env, insn_idx, BPF_DIAG_CONTEXT_RCU, true,
+					env->cur_state->active_rcu_locks);
 	} else if (rcu_unlock) {
 		if (env->cur_state->active_rcu_locks == 0) {
 			verbose(env, "unmatched rcu read unlock (kernel function %s)\n", func_name);
 			return -EINVAL;
 		}
 		env->cur_state->active_rcu_locks--;
+		bpf_diag_record_context(env, insn_idx, BPF_DIAG_CONTEXT_RCU, false,
+					env->cur_state->active_rcu_locks);
 		if (!in_rcu_cs(env))
 			invalidate_rcu_protected_refs(env);
 	} else if (preempt_disable) {
 		env->cur_state->active_preempt_locks++;
+		bpf_diag_record_context(env, insn_idx, BPF_DIAG_CONTEXT_PREEMPT, true,
+					env->cur_state->active_preempt_locks);
 	} else if (preempt_enable) {
 		if (env->cur_state->active_preempt_locks == 0) {
 			verbose(env, "unmatched attempt to enable preemption (kernel function %s)\n", func_name);
 			return -EINVAL;
 		}
 		env->cur_state->active_preempt_locks--;
+		bpf_diag_record_context(env, insn_idx, BPF_DIAG_CONTEXT_PREEMPT, false,
+					env->cur_state->active_preempt_locks);
 		if (!in_rcu_cs(env))
 			invalidate_rcu_protected_refs(env);
 	}
-- 
2.53.0

