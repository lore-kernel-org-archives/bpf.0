Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32BF63C73E5
	for <bpf@vger.kernel.org>; Wed, 27 May 2026 07:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779867012; cv=none; b=S44NHGSAfRaGWr8vhHkJ04rOYVXb/nIeutUmOc2L6iBA3s9zxao9ZoYGnIMoKWr5bUygmkC3pdduDkfYHPsLXEuBit0Z0YuWB1Fbthc+DSA32GC11OrMPDrjUK5lLYW1KuNq7SWlovi/dor2ftdcfadPVIkjekACb15ex3Eu8oM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779867012; c=relaxed/simple;
	bh=IYdOg8Txhoe8hHJ9zOHmHLo9dlrekv5mT8esg2VMy1w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iZbgSVC4bZZyXmLfVxr6s26VOT5srHKtfOXUaCMP3fdYSmvsAkyPprmNrQus0CRbacsiDNkrhWT91AXemR3uOFJcha/WCRfzT61GZHKg7QSNm6jN+tTbV1+scZSUd+XLAGCDeV6vgiZ0wIwcPnid72T0DH6p/79GW1cvykl7EV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mU1w+FXI; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mU1w+FXI"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2bd2051167eso56235015ad.1
        for <bpf@vger.kernel.org>; Wed, 27 May 2026 00:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779867009; x=1780471809; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ydsRROw4wB3tRYRj0upYmPjfXGsF5btBdL0BaKYCSc8=;
        b=mU1w+FXIuX/pO8jejDF2ffpNIOwZU0v3+UYCOka1nogZYlxxG5MJUc9txus6dU1FFx
         wTmjwBAE33ONd/6tm2h1fPjgqDcOoagK/ISr+SIO/IZCy3KbrqiZzfDv50/7otHFqJn3
         6DdDP2gH4lakdAGLiN2f9hiQOu388QYSKRKQwDutNGVrwzXxSyBVJlNlAlUz41Dgsqcc
         XuXr3H3b7eKtJoFD9gFtbrIg/2H40KGodK5T3efEdyFk6dWx+JgY2od7Ge4A1pcA94NL
         7zGH96Kd6TWt6VrMH1HKBfQqoLCd6pu9xoLAuTXMHo9+/9iN1uFcSmTEg9cTANVAn183
         uRwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779867009; x=1780471809;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ydsRROw4wB3tRYRj0upYmPjfXGsF5btBdL0BaKYCSc8=;
        b=sAwP24lIOWOoGjXb2WWkfId8X9iW3H7GI+ysiJE9R1Yma7P3oYQ0Mw6aZxVitfA9xQ
         tPTAZN2xQcdjFRZsHHEwMl3ootxQLX9c0ti2pXSQpjkh0VzM1jb1dOLtzxBlNjMCCYRR
         Tlv6ZSrhYsfGM6ZSa7SyX5vZkPsj2en8VIvCYmkZwKHxwk6a5Cz98/2kbve+0ZPtYNrw
         m6aQ1/v7cjSS54FpaJcRxEU5oM7J/6VdDKVuMqwTi+XHZJwkLYeptQ0RqcFOKuefCSDs
         Sb/0pK38LwhMs2QTRGAodhMci/qmlAnNkPVlHmSHgRTZ8jdUVsjECoMWwtyZSECVX5Bs
         ujig==
X-Gm-Message-State: AOJu0YxOgVJhIHstdJwubnjRwte/HSJNkq2x7WtOlkCpd5DlA/dYX0So
	kvoyxygX25ZTejJerZG/rcKxzhpw1jhxKA/7fp+dQf57qL7ePtfO++cvdR1Ts6Ua
X-Gm-Gg: Acq92OH3xQB+bTANef9wKi6xrpVQy41mq9DC90VhEaRK1gbEYWAgBN6D/gHdAHtIbB4
	QpRu8q3R1uP6twcHSEyLGu5KXyCIP5AWfUZSyAg+SS0eL/8jRvpvgkmJlVVNEKCFedPaGEc/a/L
	+rmgFY9vkThenenex8JkzU69HleljkV80ahnYc2jhirTVb9wQmAJ1PGvURmpNkfqR1DEmRZXrzA
	DvOD6tt59dbiGFl5KsBADcf8I5W8tlIrMKPhejxvwnGoSY/6yqFRPW2yj8ugwqL1UZpZQVtRF1Y
	K//spgUDa+OL5xST1BIAbSA5X9lv0vsSmpLU8b7wR7gB+V+U4wY5c7qREbICg5pBmjrGxsZLaOu
	Zb2ARiy+KbHv1Vrb7fgvJvB0yfAY985KH1EzPVB9juhYNPz0iy4hY6b7E7S/XgZGDwW9JzBt115
	5n+a7iW1Cu0yze0V4cb8NWR9NYluXqiqfEZfq7cYWIOSgU4K3AkvI=
X-Received: by 2002:a17:903:3b83:b0:2b2:ec31:25b0 with SMTP id d9443c01a7336-2beb0616d02mr239813805ad.29.1779867009339;
        Wed, 27 May 2026 00:30:09 -0700 (PDT)
Received: from badger ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bed2061c59sm89242325ad.2.2026.05.27.00.30.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 00:30:09 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH RFC bpf-next v3 5/6] bpf: report register diff summary for hot callchains
Date: Wed, 27 May 2026 00:29:53 -0700
Message-ID: <20260527-better-1m-reporting-v3-5-b3ede0588a75@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260527-better-1m-reporting-v3-0-b3ede0588a75@gmail.com>
References: <20260527-better-1m-reporting-v3-0-b3ede0588a75@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

When a hot callchain ends at a iter_next, may_goto, or
callback-calling instruction, compare cached states from
explored_states to identify which registers or stack slots most
frequently differ between states. Report the top 3 most varying
locations.

The full states diff computation would require some statistical
analysis similar to k-means. To keep things simple, approximate this
by modifying states_equal() to return the first location where old and
current states differ, and counting most frequent diff locations.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 include/linux/bpf_verifier.h |  15 ++++
 kernel/bpf/states.c          | 184 +++++++++++++++++++++++++++++++++++++------
 kernel/bpf/verifier.c        |  57 +++++++++++---
 3 files changed, 225 insertions(+), 31 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 347a155d8e21..cc83359774f5 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -662,6 +662,17 @@ struct bpf_loop {
 	bool irreducible;
 };
 
+struct bpf_state_diff {
+	u8 slot;
+	u8 frame;
+	enum {
+		DIFF_OTHER,
+		DIFF_REG,
+		DIFF_STACK,
+		DIFF_ARG,
+	} kind;
+};
+
 struct bpf_callchain {
 	u32 insn_idx[MAX_CALL_FRAMES];
 	u32 curframe;
@@ -1631,5 +1642,9 @@ int bpf_fixup_call_args(struct bpf_verifier_env *env);
 int bpf_do_misc_fixups(struct bpf_verifier_env *env);
 
 int bpf_compute_loops(struct bpf_verifier_env *env);
+int bpf_sample_state_diffs(struct bpf_verifier_env *env,
+			   struct bpf_callchain *cc,
+			   struct bpf_state_diff *top_diffs,
+			   int *nr_diffs);
 
 #endif /* _LINUX_BPF_VERIFIER_H */
diff --git a/kernel/bpf/states.c b/kernel/bpf/states.c
index 877338136009..b1256658189d 100644
--- a/kernel/bpf/states.c
+++ b/kernel/bpf/states.c
@@ -4,6 +4,7 @@
 #include <linux/bpf_verifier.h>
 #include <linux/cnum.h>
 #include <linux/filter.h>
+#include <linux/sort.h>
 
 #define verbose(env, fmt, args...) bpf_verifier_log_write(env, fmt, ##args)
 
@@ -696,7 +697,7 @@ static struct bpf_reg_state *scalar_reg_for_stack(struct bpf_verifier_env *env,
 
 static bool stacksafe(struct bpf_verifier_env *env, struct bpf_func_state *old,
 		      struct bpf_func_state *cur, struct bpf_idmap *idmap,
-		      enum exact_level exact)
+		      enum exact_level exact, struct bpf_state_diff *diff)
 {
 	int i, spi;
 
@@ -720,8 +721,11 @@ static bool stacksafe(struct bpf_verifier_env *env, struct bpf_func_state *old,
 				old_type = STACK_INVALID;
 			if (cur_type == STACK_POISON)
 				cur_type = STACK_INVALID;
-			if (i >= cur->allocated_stack || old_type != cur_type)
+			if (i >= cur->allocated_stack || old_type != cur_type) {
+				diff->slot = spi;
+				diff->kind = DIFF_STACK;
 				return false;
+			}
 		}
 
 		if (old->stack[spi].slot_type[i % BPF_REG_SIZE] == STACK_INVALID ||
@@ -735,8 +739,11 @@ static bool stacksafe(struct bpf_verifier_env *env, struct bpf_func_state *old,
 		/* explored stack has more populated slots than current stack
 		 * and these slots were used
 		 */
-		if (i >= cur->allocated_stack)
+		if (i >= cur->allocated_stack) {
+			diff->slot = spi;
+			diff->kind = DIFF_STACK;
 			return false;
+		}
 
 		/*
 		 * 64 and 32-bit scalar spills vs MISC/INVALID slots and vice versa.
@@ -748,8 +755,11 @@ static bool stacksafe(struct bpf_verifier_env *env, struct bpf_func_state *old,
 			old_reg = scalar_reg_for_stack(env, &old->stack[spi], im);
 			cur_reg = scalar_reg_for_stack(env, &cur->stack[spi], im);
 			if (old_reg && cur_reg) {
-				if (!regsafe(env, old_reg, cur_reg, idmap, exact))
+				if (!regsafe(env, old_reg, cur_reg, idmap, exact)) {
+					diff->slot = spi;
+					diff->kind = DIFF_STACK;
 					return false;
+				}
 				i += (im == 0 ? BPF_REG_SIZE - 1 : 3);
 				continue;
 			}
@@ -763,13 +773,16 @@ static bool stacksafe(struct bpf_verifier_env *env, struct bpf_func_state *old,
 		    cur->stack[spi].slot_type[i % BPF_REG_SIZE] == STACK_ZERO)
 			continue;
 		if (old->stack[spi].slot_type[i % BPF_REG_SIZE] !=
-		    cur->stack[spi].slot_type[i % BPF_REG_SIZE])
+		    cur->stack[spi].slot_type[i % BPF_REG_SIZE]) {
 			/* Ex: old explored (safe) state has STACK_SPILL in
 			 * this stack slot, but current has STACK_MISC ->
 			 * this verifier states are not equivalent,
 			 * return false to continue verification of this path
 			 */
+			diff->slot = spi;
+			diff->kind = DIFF_STACK;
 			return false;
+		}
 		if (i % BPF_REG_SIZE != BPF_REG_SIZE - 1)
 			continue;
 		/* Both old and cur are having same slot_type */
@@ -786,16 +799,22 @@ static bool stacksafe(struct bpf_verifier_env *env, struct bpf_func_state *old,
 			 * return false to continue verification of this path
 			 */
 			if (!regsafe(env, &old->stack[spi].spilled_ptr,
-				     &cur->stack[spi].spilled_ptr, idmap, exact))
+				     &cur->stack[spi].spilled_ptr, idmap, exact)) {
+				diff->slot = spi;
+				diff->kind = DIFF_STACK;
 				return false;
+			}
 			break;
 		case STACK_DYNPTR:
 			old_reg = &old->stack[spi].spilled_ptr;
 			cur_reg = &cur->stack[spi].spilled_ptr;
 			if (old_reg->dynptr.type != cur_reg->dynptr.type ||
 			    old_reg->dynptr.first_slot != cur_reg->dynptr.first_slot ||
-			    !check_ids(old_reg->ref_obj_id, cur_reg->ref_obj_id, idmap))
+			    !check_ids(old_reg->ref_obj_id, cur_reg->ref_obj_id, idmap)) {
+				diff->slot = spi;
+				diff->kind = DIFF_STACK;
 				return false;
+			}
 			break;
 		case STACK_ITER:
 			old_reg = &old->stack[spi].spilled_ptr;
@@ -810,15 +829,21 @@ static bool stacksafe(struct bpf_verifier_env *env, struct bpf_func_state *old,
 			    old_reg->iter.btf_id != cur_reg->iter.btf_id ||
 			    old_reg->iter.state != cur_reg->iter.state ||
 			    /* ignore {old_reg,cur_reg}->iter.depth, see above */
-			    !check_ids(old_reg->ref_obj_id, cur_reg->ref_obj_id, idmap))
+			    !check_ids(old_reg->ref_obj_id, cur_reg->ref_obj_id, idmap)) {
+				diff->slot = spi;
+				diff->kind = DIFF_STACK;
 				return false;
+			}
 			break;
 		case STACK_IRQ_FLAG:
 			old_reg = &old->stack[spi].spilled_ptr;
 			cur_reg = &cur->stack[spi].spilled_ptr;
 			if (!check_ids(old_reg->ref_obj_id, cur_reg->ref_obj_id, idmap) ||
-			    old_reg->irq.kfunc_class != cur_reg->irq.kfunc_class)
+			    old_reg->irq.kfunc_class != cur_reg->irq.kfunc_class) {
+				diff->slot = spi;
+				diff->kind = DIFF_STACK;
 				return false;
+			}
 			break;
 		case STACK_MISC:
 		case STACK_ZERO:
@@ -827,6 +852,8 @@ static bool stacksafe(struct bpf_verifier_env *env, struct bpf_func_state *old,
 			continue;
 		/* Ensure that new unhandled slot types return false by default */
 		default:
+			diff->slot = spi;
+			diff->kind = DIFF_STACK;
 			return false;
 		}
 	}
@@ -839,7 +866,7 @@ static bool stacksafe(struct bpf_verifier_env *env, struct bpf_func_state *old,
  */
 static bool stack_arg_safe(struct bpf_verifier_env *env, struct bpf_func_state *old,
 			   struct bpf_func_state *cur, struct bpf_idmap *idmap,
-			   enum exact_level exact)
+			   enum exact_level exact, struct bpf_state_diff *diff)
 {
 	int i, nslots;
 
@@ -852,8 +879,11 @@ static bool stack_arg_safe(struct bpf_verifier_env *env, struct bpf_func_state *
 			  &old->stack_arg_regs[i] : &not_init;
 		cur_arg = i < cur->out_stack_arg_cnt ?
 			  &cur->stack_arg_regs[i] : &not_init;
-		if (!regsafe(env, old_arg, cur_arg, idmap, exact))
+		if (!regsafe(env, old_arg, cur_arg, idmap, exact)) {
+			diff->slot = i;
+			diff->kind = DIFF_ARG;
 			return false;
+		}
 	}
 
 	return true;
@@ -933,7 +963,8 @@ static bool refsafe(struct bpf_verifier_state *old, struct bpf_verifier_state *c
  * the current state will reach 'bpf_exit' instruction safely
  */
 static bool func_states_equal(struct bpf_verifier_env *env, struct bpf_func_state *old,
-			      struct bpf_func_state *cur, u32 insn_idx, enum exact_level exact)
+			      struct bpf_func_state *cur, u32 insn_idx,
+			      enum exact_level exact, struct bpf_state_diff *diff)
 {
 	u16 live_regs = env->insn_aux_data[insn_idx].live_regs_before;
 	u16 i;
@@ -947,13 +978,16 @@ static bool func_states_equal(struct bpf_verifier_env *env, struct bpf_func_stat
 	for (i = 0; i < MAX_BPF_REG; i++)
 		if (((1 << i) & live_regs) &&
 		    !regsafe(env, &old->regs[i], &cur->regs[i],
-			     &env->idmap_scratch, exact))
+			     &env->idmap_scratch, exact)) {
+			diff->slot = i;
+			diff->kind = DIFF_REG;
 			return false;
+		}
 
-	if (!stacksafe(env, old, cur, &env->idmap_scratch, exact))
+	if (!stacksafe(env, old, cur, &env->idmap_scratch, exact, diff))
 		return false;
 
-	if (!stack_arg_safe(env, old, cur, &env->idmap_scratch, exact))
+	if (!stack_arg_safe(env, old, cur, &env->idmap_scratch, exact, diff))
 		return false;
 
 	return true;
@@ -970,11 +1004,14 @@ static void reset_idmap_scratch(struct bpf_verifier_env *env)
 static bool states_equal(struct bpf_verifier_env *env,
 			 struct bpf_verifier_state *old,
 			 struct bpf_verifier_state *cur,
-			 enum exact_level exact)
+			 enum exact_level exact,
+			 struct bpf_state_diff *diff)
 {
 	u32 insn_idx;
 	int i;
 
+	diff->kind = DIFF_OTHER;
+
 	if (old->curframe != cur->curframe)
 		return false;
 
@@ -999,8 +1036,11 @@ static bool states_equal(struct bpf_verifier_env *env,
 		insn_idx = bpf_frame_insn_idx(old, i);
 		if (old->frame[i]->callsite != cur->frame[i]->callsite)
 			return false;
-		if (!func_states_equal(env, old->frame[i], cur->frame[i], insn_idx, exact))
+		if (!func_states_equal(env, old->frame[i], cur->frame[i],
+				       insn_idx, exact, diff)) {
+			diff->frame = i;
 			return false;
+		}
 	}
 	return true;
 }
@@ -1231,6 +1271,7 @@ int bpf_is_state_visited(struct bpf_verifier_env *env, int insn_idx)
 	struct bpf_verifier_state_list *new_sl;
 	struct bpf_verifier_state_list *sl;
 	struct bpf_verifier_state *cur = env->cur_state, *new;
+	struct bpf_state_diff diff = {};
 	bool force_new_state, add_new_state, loop;
 	int n, err, states_cnt = 0;
 	struct list_head *pos, *tmp, *head;
@@ -1320,7 +1361,7 @@ int bpf_is_state_visited(struct bpf_verifier_env *env, int insn_idx)
 			 * => unsafe memory access at 11 would not be caught.
 			 */
 			if (is_iter_next_insn(env, insn_idx)) {
-				if (states_equal(env, &sl->state, cur, RANGE_WITHIN)) {
+				if (states_equal(env, &sl->state, cur, RANGE_WITHIN, &diff)) {
 					struct bpf_func_state *cur_frame;
 					struct bpf_reg_state *iter_state, *iter_reg;
 					int spi;
@@ -1345,13 +1386,13 @@ int bpf_is_state_visited(struct bpf_verifier_env *env, int insn_idx)
 			}
 			if (is_may_goto_insn_at(env, insn_idx)) {
 				if (sl->state.may_goto_depth != cur->may_goto_depth &&
-				    states_equal(env, &sl->state, cur, RANGE_WITHIN)) {
+				    states_equal(env, &sl->state, cur, RANGE_WITHIN, &diff)) {
 					loop = true;
 					goto hit;
 				}
 			}
 			if (bpf_calls_callback(env, insn_idx)) {
-				if (states_equal(env, &sl->state, cur, RANGE_WITHIN)) {
+				if (states_equal(env, &sl->state, cur, RANGE_WITHIN, &diff)) {
 					loop = true;
 					goto hit;
 				}
@@ -1359,7 +1400,7 @@ int bpf_is_state_visited(struct bpf_verifier_env *env, int insn_idx)
 			}
 			/* attempt to detect infinite loop to avoid unnecessary doomed work */
 			if (states_maybe_looping(&sl->state, cur) &&
-			    states_equal(env, &sl->state, cur, EXACT) &&
+			    states_equal(env, &sl->state, cur, EXACT, &diff) &&
 			    !iter_active_depths_differ(&sl->state, cur) &&
 			    sl->state.may_goto_depth == cur->may_goto_depth &&
 			    sl->state.callback_unroll_depth == cur->callback_unroll_depth) {
@@ -1392,7 +1433,7 @@ int bpf_is_state_visited(struct bpf_verifier_env *env, int insn_idx)
 		}
 		/* See comments for mark_all_regs_read_and_precise() */
 		loop = incomplete_read_marks(env, &sl->state);
-		if (states_equal(env, &sl->state, cur, loop ? RANGE_WITHIN : NOT_EXACT)) {
+		if (states_equal(env, &sl->state, cur, loop ? RANGE_WITHIN : NOT_EXACT, &diff)) {
 hit:
 			sl->hit_cnt++;
 
@@ -1588,3 +1629,102 @@ int bpf_is_state_visited(struct bpf_verifier_env *env, int insn_idx)
 	list_add(&new_sl->node, head);
 	return 0;
 }
+
+static bool callchain_matches_state(struct bpf_callchain *cc,
+				    struct bpf_verifier_state *st)
+{
+	int i;
+
+	if (st->curframe != cc->curframe)
+		return false;
+	for (i = 0; i < (int)cc->curframe; i++)
+		if (st->frame[i + 1]->callsite != cc->insn_idx[i])
+			return false;
+	return st->insn_idx == cc->insn_idx[cc->curframe];
+}
+
+struct state_diff_cnt {
+	struct bpf_state_diff diff;
+	u32 cnt;
+};
+
+static int state_diff_cmp(const void *a, const void *b)
+{
+	return cmp_int(((struct state_diff_cnt *)b)->cnt, ((struct state_diff_cnt *)a)->cnt);
+}
+
+static bool state_diff_eq(struct bpf_state_diff *a, struct bpf_state_diff *b)
+{
+	return a->frame == b->frame && a->slot == b->slot && a->kind == b->kind;
+}
+
+int bpf_sample_state_diffs(struct bpf_verifier_env *env,
+			   struct bpf_callchain *cc,
+			   struct bpf_state_diff *top_diffs,
+			   int *nr_diffs)
+{
+	struct bpf_verifier_state_list *sl_i, *sl_j;
+	struct state_diff_cnt *diff_cnts = NULL;
+	struct list_head *pos_i, *pos_j, *head;
+	u32 leaf_insn, callsite, hash_idx;
+	int i, cap = 0, nr_locs = 0;
+
+	leaf_insn = cc->insn_idx[cc->curframe];
+	callsite = cc->curframe > 0 ? cc->insn_idx[cc->curframe - 1] : BPF_MAIN_FUNC;
+	hash_idx = (leaf_insn ^ callsite) % env->prog->len;
+	head = &env->explored_states[hash_idx];
+
+	/*
+	 * Single bucket accumulates up to 64 states, no cond_resched() necessary.
+	 * See limits in is_state_visited().
+	 */
+	list_for_each(pos_i, head) {
+		sl_i = container_of(pos_i, struct bpf_verifier_state_list, node);
+		if (!callchain_matches_state(cc, &sl_i->state))
+			continue;
+		list_for_each(pos_j, head) {
+			struct bpf_state_diff diff = {};
+
+			if (pos_i == pos_j)
+				continue;
+			sl_j = container_of(pos_j, struct bpf_verifier_state_list, node);
+			if (!callchain_matches_state(cc, &sl_j->state))
+				continue;
+			if (states_equal(env, &sl_i->state, &sl_j->state, NOT_EXACT, &diff))
+				continue;
+			if (diff.kind == DIFF_OTHER)
+				continue;
+			for (i = 0; i < nr_locs; i++) {
+				if (state_diff_eq(&diff_cnts[i].diff, &diff)) {
+					diff_cnts[i].cnt++;
+					goto next;
+				}
+			}
+			if (nr_locs == cap) {
+				int new_cap = cap ? cap * 2 : 16;
+				struct state_diff_cnt *new;
+
+				new = kvrealloc(diff_cnts, new_cap * sizeof(*new),
+						GFP_KERNEL_ACCOUNT);
+				if (!new) {
+					kvfree(diff_cnts);
+					return -ENOMEM;
+				}
+				memset(new + cap, 0, (new_cap - cap) * sizeof(*new));
+				diff_cnts = new;
+				cap = new_cap;
+			}
+			diff_cnts[nr_locs].diff = diff;
+			diff_cnts[nr_locs].cnt = 1;
+			nr_locs++;
+next:;
+		}
+	}
+
+	sort(diff_cnts, nr_locs, sizeof(*diff_cnts), state_diff_cmp, NULL);
+	*nr_diffs = min(nr_locs, *nr_diffs);
+	for (i = 0; i < *nr_diffs; i++)
+		top_diffs[i] = diff_cnts[i].diff;
+	kvfree(diff_cnts);
+	return 0;
+}
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 54b7ad65b7fc..d09c014462f1 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -17292,13 +17292,13 @@ static void free_callchain_profile(struct bpf_verifier_env *env)
 	}
 }
 
-static void print_callchain_entry(struct bpf_verifier_env *env,
-				  struct bpf_callchain_entry *entry, int idx)
+static int print_callchain_entry(struct bpf_verifier_env *env,
+				 struct bpf_callchain_entry *entry, int idx)
 {
 	struct bpf_callchain *cc = &entry->cc;
 	const struct bpf_line_info *linfo;
 	struct bpf_subprog_info *sub;
-	int i, insn_idx;
+	int i, err, insn_idx;
 
 	verbose(env, "#%d most visited simulated stacktrace (visited %llu times):\n",
 		idx, entry->count);
@@ -17316,6 +17316,38 @@ static void print_callchain_entry(struct bpf_verifier_env *env,
 				BPF_LINE_INFO_LINE_NUM(linfo->line_col));
 		verbose(env, "\n");
 	}
+
+	insn_idx = cc->insn_idx[cc->curframe];
+	if (bpf_is_force_checkpoint(env, insn_idx)) {
+		struct bpf_state_diff top_diffs[3];
+		int nr_diffs = ARRAY_SIZE(top_diffs);
+
+		err = bpf_sample_state_diffs(env, cc, top_diffs, &nr_diffs);
+		if (err)
+			return err;
+		for (i = 0; i < nr_diffs; i++) {
+			struct bpf_state_diff *d = &top_diffs[i];
+
+			switch (d->kind) {
+			case DIFF_REG:
+				verbose(env, "    Most varying: R%d (frame %d)\n",
+					d->slot, d->frame);
+				break;
+			case DIFF_STACK:
+				verbose(env, "    Most varying: fp-%d (frame %d)\n",
+					(d->slot + 1) * BPF_REG_SIZE, d->frame);
+				break;
+			case DIFF_ARG:
+				verbose(env, "    Most varying: arg#%d (frame %d)\n",
+					d->slot, d->frame);
+				break;
+			default:
+				/* shouldn't really happen */
+				continue;
+			}
+		}
+	}
+	return 0;
 }
 
 static void disasm_subprog(struct bpf_verifier_env *env, struct bpf_subprog_info *sub)
@@ -17340,16 +17372,16 @@ static void disasm_subprog(struct bpf_verifier_env *env, struct bpf_subprog_info
  * Print several most visited simulated stack traces,
  * and a disasembly of related subprograms.
  */
-static void print_hotspots(struct bpf_verifier_env *env)
+static int print_hotspots(struct bpf_verifier_env *env)
 {
 	DECLARE_BITMAP(printed_subs, BPF_MAX_SUBPROGS + 2) = {};
 	struct bpf_callchain_entry *top[3] = {};
 	struct bpf_callchain_entry *entry;
 	struct bpf_subprog_info *sub;
-	int i, j, bkt, nr_top = 0;
+	int i, j, err, bkt, nr_top = 0;
 
 	if (!(env->log.level & BPF_LOG_LEVEL))
-		return;
+		return 0;
 
 	/* Collect the hottest callchains */
 	hash_for_each(env->callchain_htab, bkt, entry, node) {
@@ -17366,7 +17398,7 @@ static void print_hotspots(struct bpf_verifier_env *env)
 		nr_top++;
 
 	if (!nr_top)
-		return;
+		return 0;
 
 	if (!(env->log.level & BPF_LOG_LEVEL2))
 		bpf_vlog_reset(&env->log, 0);
@@ -17388,9 +17420,14 @@ static void print_hotspots(struct bpf_verifier_env *env)
 
 	/* Print the hot callchains */
 	for (i = 0; i < nr_top; i++) {
-		print_callchain_entry(env, top[i], i + 1);
+		err = print_callchain_entry(env, top[i], i + 1);
+		if (err)
+			return err;
+
 		verbose(env, "\n");
 	}
+
+	return 0;
 }
 
 static int do_check_insn(struct bpf_verifier_env *env, bool *do_print_state)
@@ -17527,7 +17564,9 @@ static int do_check(struct bpf_verifier_env *env)
 		insn_aux = &env->insn_aux_data[env->insn_idx];
 
 		if (++env->insn_processed > BPF_COMPLEXITY_LIMIT_INSNS) {
-			print_hotspots(env);
+			err = print_hotspots(env);
+			if (err)
+				return err;
 			verbose(env,
 				"BPF program is too large. Processed %d insn\n",
 				env->insn_processed);

-- 
2.53.0
