Received: from mail-wm2-f9.google.com (mail-wm2-f9.google.com [74.125.225.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A884642F6E2
	for <bpf@vger.kernel.org>; Wed, 12 Aug 2026 23:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786577624; cv=none; b=TALBv09dFeYzmjTGaMYgym4ePUnIAmauHZoSdzpG/WWPPjCGpLUhIKsjKweJuDhuq5/c67tKmQTL9jDBPD+3KPkSitTrpFvvSZpfLNdiEm0ZRSCWwHHdfqchtUafCKtHZ3eyVL4dlFugEUJ4gPfav2GAt1zkMhX8npoYDMIfh98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786577624; c=relaxed/simple;
	bh=uiCW1nVZSbOnVNRPdlw4Trcqu8S1CWvGkczJly0kbag=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DWsIc8OxiFnI1Ak8Nar63FZJR7CA745OXNb43Bbo835gN8J9gkn8C5GlCLnRsAuapVudIFCA4fY9uOnOdsiN9eh1HeoCj8kDIyuKVSFluAJYw46KAy3/F3DZvX7/JISUsg/1eBmn/rI3KfjGNeYMINwkkTxVD6k2NeP2Smwj1xU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T4+HILyT; arc=none smtp.client-ip=74.125.225.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T4+HILyT"
Received: by mail-wm2-f9.google.com with SMTP id 5b1f17b1804b1-49556ce3549so6043605e9.0
        for <bpf@vger.kernel.org>; Wed, 12 Aug 2026 16:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786577621; x=1787182421; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gFoONeCj35LjkdIQR+8uLO6h9P56XbzAGtEwNoZNnqU=;
        b=T4+HILyT4BexIT8cFt8TYFl6bPUSgtUKqKd6RedkDaccpw+McPdLl8XrSMKbUnwuUI
         upbl+yCJcYicEwnjb8EQDvXqLDWpT0Xlplo05X0Dpi9P/tX85kVbV1rkBG+B3f6pP+iP
         Xqu8RqW2CKyJY7UDIuFpcUlAN5839t6Qnlg72Pq0zU5NODSyK+rcVBZjisn8obEfHXas
         +ILW5lcS6GZjPat3RSUvrlG0yFDyvwhZbVZDcyJbwwmdrMJD7nGtHGl+1wdYtXwB4HmG
         ylJm3sTEYB45m+T9//03IE5KuWPPsjzvM/XHVPTXxqr8ACXwgJIf6lfOXdXCz53VaDSI
         F5cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786577621; x=1787182421;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=gFoONeCj35LjkdIQR+8uLO6h9P56XbzAGtEwNoZNnqU=;
        b=a1o5Bj2W6AB59NOirJGUi/OGL6jBNPuHGPlTtSV6E2xHbaWLR0v458micDNcGZl0v0
         Ml66PENYL1pDbbH9WF5QQvU++RJ9W3eFm+/MPONrcEHPpPJgS0yWKa1PDMWoN53tfygQ
         nbQG5jiDRYe4xv8+ZF/Qk/j6ndSrHIPYQZGT4/Nx6+S+iKB2Fwu7qtT23gaTjYHpNZzg
         JunMd/XBGSEVR8I8O/qqbKNfXPyhZVE4zn+PJEmIDFkPwuZDBJNIm6GuwOMw7Ihxit7a
         9t4aXQVi0svgMhbcYED4IUSEP+9oCOZ5ikpN97KV4akUtGtWEQQzT8PA2wejbDO6DC9h
         Ch6A==
X-Gm-Message-State: AOJu0YyhwHkOvZANO0WHwXAno1xlhA0iRZt3wi84WXksKG0QPqJOl49O
	ubWLopmnPxvWuUzQNdJvg1YYDp5HrAMacrvfpEFvJArB4Aa0Ye+YUhH5B/5C8T1l
X-Gm-Gg: AR+sD130n2ReREL+SLWV/dOHnmKrGWFju7JWqd3F9PC5e0BD/4L1nYj6lMVh6/j+89Y
	6rFXDrS8mcSZS6FwefhgGga2gowuSECb/hE845+1SuIBfoC1xvG9P4rYuaDfmXwmZAvJmaFY0Xg
	bFCtsRjsLaGHuejRkf1kPvVIqveh1HXyEYk5jk8N5Mj+IaqnwvLia4wFW5tJ6i4k5IgeN3nervl
	zncs9NSt3a/v5ezb//es9rn/NYo9MSLwl5FZBJjvQvt8Ua8qwbnql6tMmK5+Ik3x5hNRWtWl7CT
	4Cy38WdQsndhHCSLKYcxpIhFwSB8+RE0+oG8VmAYa2zDaV+7Yfk2Q8Xs4IXHfsqxn+1wkj2XE/1
	Ytne9169HHqt4RDRo1Xk/qk+ELUqc2riPUqrRtP4U/cQLFFTCc9/PVRh+r9O5BEmQNAVqlCV4BV
	CBHcbxv0MV1HZtjWn6Y1HyIC5bJ/FkB3WJ0aO2My1myUPgfJIeZbi2JSid1UFpulcgjiCJNL4jp
	+vjvKqC65URP2m78fTYoN+T1uOWAXv7pgxmh77ZkHYlf3ppCvE74mqch/Lav5Hgh7+pMQMrxUl7
	8chj0sgE2VG2hirdw2VSQCrh1o4=
X-Received: by 2002:a05:600c:524f:b0:495:7a04:b006 with SMTP id 5b1f17b1804b1-499821931e9mr12211045e9.8.1786577620814;
        Wed, 12 Aug 2026 16:33:40 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4815a56981csm1209445f8f.10.2026.08.12.16.33.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 16:33:40 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v4 07/16] bpf: Track verifier context diagnostic events
Date: Thu, 13 Aug 2026 01:33:10 +0200
Message-ID: <20260812233326.3575958-8-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260812233326.3575958-1-memxor@gmail.com>
References: <20260812233326.3575958-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=9369; i=memxor@gmail.com; h=from:subject; bh=uiCW1nVZSbOnVNRPdlw4Trcqu8S1CWvGkczJly0kbag=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIauWQXvq8vtz11+aUeKucOTGyTPaiTPUFj//YaQwi8FbM IWj+rNIRykLgxgXg6yYIkvJ/31MxicqfwfaLuOGmcPKBDKEgYtTACZy7zvDP42HBpk8Lata+6tU uN43yLlMKJ60zHrNLBOXmczay6q3aDEynOTKXLDZ3fyKxLrcpN41r1S+HqxZaLP5RrD8xIkfD6u dZgcA
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
index 0143ffe6fa03..823e0a7a0638 100644
--- a/kernel/bpf/diagnostics.c
+++ b/kernel/bpf/diagnostics.c
@@ -49,6 +49,7 @@ enum bpf_diag_history_kind {
 	BPF_DIAG_HISTORY_MOD,
 	BPF_DIAG_HISTORY_REF_ACQUIRE,
 	BPF_DIAG_HISTORY_REF_RELEASE,
+	BPF_DIAG_HISTORY_CONTEXT,
 };
 
 struct bpf_diag_history_event {
@@ -69,6 +70,11 @@ struct bpf_diag_history_event {
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
 
@@ -335,6 +341,19 @@ void bpf_diag_event_log_reset(struct bpf_verifier_env *env, u32 pos)
 	log->cnt = pos;
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
@@ -967,3 +986,23 @@ void bpf_diag_record_ref_release(struct bpf_verifier_env *env, u32 insn_idx, u32
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
index 40fe161525b9..0cf5427a1a1b 100644
--- a/kernel/bpf/diagnostics.h
+++ b/kernel/bpf/diagnostics.h
@@ -9,6 +9,7 @@
 
 struct bpf_reg_state;
 struct bpf_verifier_env;
+struct bpf_verifier_state;
 struct btf;
 
 enum bpf_diag_mod_reason {
@@ -81,6 +82,14 @@ static inline struct bpf_diag_mod_target bpf_diag_stack_range_target(u32 frameno
 	};
 }
 
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
 char *bpf_diag_fmt_buf(struct bpf_verifier_env *env, size_t size);
@@ -90,6 +99,7 @@ const char *bpf_diag_fmt(struct bpf_verifier_env *env, const char *fmt, ...) __p
 const char *bpf_diag_fmt_btf_type(struct bpf_verifier_env *env, const struct btf *btf, u32 type_id);
 u32 bpf_diag_event_log_pos(struct bpf_verifier_env *env);
 void bpf_diag_event_log_reset(struct bpf_verifier_env *env, u32 pos);
+u32 bpf_diag_irq_depth(const struct bpf_verifier_state *state);
 void bpf_diag_free(struct bpf_verifier_env *env);
 void bpf_diag_header(struct bpf_verifier_env *env, const char *category,
 			    const char *problem);
@@ -105,5 +115,7 @@ void bpf_diag_record_scrub_stack(struct bpf_verifier_env *env, u32 frameno, s16
 				 s16 max_off, enum bpf_diag_mod_reason reason);
 void bpf_diag_record_ref_acquire(struct bpf_verifier_env *env, u32 insn_idx, u32 ref_id);
 void bpf_diag_record_ref_release(struct bpf_verifier_env *env, u32 insn_idx, u32 ref_id);
+void bpf_diag_record_context(struct bpf_verifier_env *env, u32 insn_idx,
+			     enum bpf_diag_context_kind ctx_kind, bool enter, u32 depth);
 
 #endif /* __BPF_DIAGNOSTICS_H */
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 4f3416700ad7..a32f360d0f00 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -1046,7 +1046,7 @@ static int is_iter_reg_valid_init(struct bpf_verifier_env *env, struct bpf_reg_s
 }
 
 static int acquire_irq_state(struct bpf_verifier_env *env, int insn_idx);
-static int release_irq_state(struct bpf_verifier_state *state, int id);
+static int release_irq_state(struct bpf_verifier_env *env, int id);
 
 static int mark_stack_slot_irq_flag(struct bpf_verifier_env *env,
 				     struct bpf_call_arg_meta *meta,
@@ -1105,7 +1105,7 @@ static int unmark_stack_slot_irq_flag(struct bpf_verifier_env *env, struct bpf_r
 		return -EINVAL;
 	}
 
-	err = release_irq_state(env->cur_state, st->id);
+	err = release_irq_state(env, st->id);
 	WARN_ON_ONCE(err && err != -EACCES);
 	if (err) {
 		int insn_idx = 0;
@@ -1440,6 +1440,8 @@ static int acquire_lock_state(struct bpf_verifier_env *env, int insn_idx, enum r
 	state->active_locks++;
 	state->active_lock_id = id;
 	state->active_lock_ptr = ptr;
+	bpf_diag_record_context(env, insn_idx, BPF_DIAG_CONTEXT_LOCK, true,
+				state->active_locks);
 	return 0;
 }
 
@@ -1455,6 +1457,8 @@ static int acquire_irq_state(struct bpf_verifier_env *env, int insn_idx)
 	s->id = ++env->id_gen;
 
 	state->active_irq_id = s->id;
+	bpf_diag_record_context(env, insn_idx, BPF_DIAG_CONTEXT_IRQ, true,
+				bpf_diag_irq_depth(state));
 	return s->id;
 }
 
@@ -1496,8 +1500,9 @@ static bool reg_is_referenced(struct bpf_verifier_env *env, const struct bpf_reg
 	return find_reference_state(env->cur_state, reg->id);
 }
 
-static int release_lock_state(struct bpf_verifier_state *state, int type, int id, void *ptr)
+static int release_lock_state(struct bpf_verifier_env *env, int type, int id, void *ptr)
 {
+	struct bpf_verifier_state *state = env->cur_state;
 	void *prev_ptr = NULL;
 	u32 prev_id = 0;
 	int i;
@@ -1510,6 +1515,8 @@ static int release_lock_state(struct bpf_verifier_state *state, int type, int id
 			/* Reassign active lock (id, ptr). */
 			state->active_lock_id = prev_id;
 			state->active_lock_ptr = prev_ptr;
+			bpf_diag_record_context(env, env->insn_idx, BPF_DIAG_CONTEXT_LOCK,
+						false, state->active_locks);
 			return 0;
 		}
 		if (state->refs[i].type & REF_TYPE_LOCK_MASK) {
@@ -1520,8 +1527,9 @@ static int release_lock_state(struct bpf_verifier_state *state, int type, int id
 	return -EINVAL;
 }
 
-static int release_irq_state(struct bpf_verifier_state *state, int id)
+static int release_irq_state(struct bpf_verifier_env *env, int id)
 {
+	struct bpf_verifier_state *state = env->cur_state;
 	u32 prev_id = 0;
 	int i;
 
@@ -1534,6 +1542,8 @@ static int release_irq_state(struct bpf_verifier_state *state, int id)
 		if (state->refs[i].id == id) {
 			release_reference_state(state, i);
 			state->active_irq_id = prev_id;
+			bpf_diag_record_context(env, env->insn_idx, BPF_DIAG_CONTEXT_IRQ,
+						false, bpf_diag_irq_depth(state));
 			return 0;
 		} else {
 			prev_id = state->refs[i].id;
@@ -7142,7 +7152,7 @@ static int process_spin_lock(struct bpf_verifier_env *env, struct bpf_reg_state
 			verbose(env, "%s_unlock cannot be out of order\n", lock_str);
 			return -EINVAL;
 		}
-		if (release_lock_state(cur, type, reg->id, ptr)) {
+		if (release_lock_state(env, type, reg->id, ptr)) {
 			verbose(env, "%s_unlock of different lock\n", lock_str);
 			return -EINVAL;
 		}
@@ -13155,22 +13165,30 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 
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

