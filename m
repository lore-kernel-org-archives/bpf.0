Received: from mail-wm2-f8.google.com (mail-wm2-f8.google.com [74.125.225.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E74CB408018
	for <bpf@vger.kernel.org>; Wed, 12 Aug 2026 23:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786577630; cv=none; b=hujAHIeyRmFp0ZkwDoA1S2LfLiB5J9lW/dOHSVhDvBRuOh6j37tQzAscxsdM6QveYYyNavbSebltJNfJRP2xO+XRHJRAds74CQnUw7jCvwKA2/UCHFghjLdD9EvH0z1TBM+K0URjxdZYfg6I0F7oYumgChbgIHbDAwwg3yYbnHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786577630; c=relaxed/simple;
	bh=Xbes0VWB7UoOqyvnrEPypOeFcVWAIvt4Q7mygJlOqWE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FsLCXY5XvL1yB/ODK+nf1DLAttMyplJAJ0vuRo/vjW5pVs5SjePmAoM3us+kGlQiyL6588mYs+4k2fV2eeTw2zOi2KlKkslpcPVwBshXXx3e0uns15Ux4veKLWT6yyPrYrHGT+RMNrEvky4ZbcWwwelQWO8Ly2NzNNB3z5qxuds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nfZG2gsj; arc=none smtp.client-ip=74.125.225.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nfZG2gsj"
Received: by mail-wm2-f8.google.com with SMTP id 5b1f17b1804b1-4956bc73c0eso3997645e9.1
        for <bpf@vger.kernel.org>; Wed, 12 Aug 2026 16:33:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786577626; x=1787182426; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CwFzU3eOnbjFHhIZm2FclJor9YtSim47EeuqPP5a6Pc=;
        b=nfZG2gsjGaAqlZQ4NxIcBDBN6f5kG1SMVhyrvyYpKsGeaTzqC2GnP9BMtfv2aDcAOV
         FasS5Fpa/sPB5YoKApl/yfaBMAnXaRZHkUKvZkv0vH48/bhx05quOTLRYVQSk1iFrZVY
         PALijZZrjFRF/YuvG9Ujmztx+s52PHhB4D29LEYcBej+UP7BpzPuQzXaGkcMbg7S7H/U
         zohg38+R6G4gaVGNudRXchbMCtgenPSDfLUO83C1NzwK2MY3rrMScD2HXZ9TC0uLgoJF
         zFUv8/qY/i9JZ7byXeASsMVDK8Q2U+c7o301iguDc7HhEFt+B02qLONqiiLa9l5adhSI
         k8SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786577626; x=1787182426;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=CwFzU3eOnbjFHhIZm2FclJor9YtSim47EeuqPP5a6Pc=;
        b=X3B3GbEJc03oJJTkCVLtnn5e6tU09xOaSfomnxoE9cOayC1RhLXu+ZB67oMaDb8Q1l
         9tIqwlyoNsCB7++42pRn5z1sMnEIMafHDElm5iq7ISUdIqqlU/+RcdqFMcQByd4MbJ9V
         AgOFWpvhLnK/mbeu0qeP+rzgjrMklcNKcLfCvxsmPw8Y7t2FAy/tr9eJ1F6icACKVm0j
         HVOZnxCIcIqwXwuYDk98YYDKmi8vKSPWqNpLMnxNKoWfdkDtIVBDU7rRDigQGIi8X4sF
         JPn7KR+USyoBV1IXyiuTryk6HdJUxf7xKi2ep6dYg+l9nIEXy59212ChyowFsbSHV6Y8
         Qq7w==
X-Gm-Message-State: AOJu0Yx3zJ2oQ8zLEMzc9dWyQ+Lrf4YNhermzZhfZxoZ7X15vtsJTa6z
	Mh0kjx8ej2aAs8GVOCq4uH63aTboNQtz53gKT50JKdNL5+SvRMQDrFM3yPplOcJd
X-Gm-Gg: AR+sD132NsAW2OnlJDr6PIiv0qDKh2E/A6OYMqLy37WKuPgMcWMKUUnOlYDuuyDTmcs
	CvUGQCsmzhRJ3bmBPpJ7A3CRKkdHambweoCoqd6xehPei0Bez6MZOpsh03iWMnFwaSwwyr7RdV9
	PxRci3J/cdB+GLOA+AjgPSsfLRyRrdv8SAtjrp27HeWwIFh9lnuX3ykNnzSibZrJ4hWSrckTO8M
	qld/psMBBvxAPCNbHtw7a0bMaiv+zaCl09SNg3pidyk62RHj35STtginZSOksUcMaOuQRnY/nrs
	1Qht4n+K4nniho9LUDkIlgrOvVS7s5Yj/xGbTQtSloBVh/jS899jOobyM7VUPZVOl04bJ7aIHUW
	sUWIVLXlBqqWb7U2F7umaZSgb0+spoB4eLCcx44UjJXjADgbPnpKdx90FOSc6uugOsKWVvcrg4m
	PwQ0t/glfe9LzqTd25ctjEG/uMfRF03nipYV/ut35zD4PHLjifi310cqFb1SjeYOLKgu4ErHs9q
	kVoDJOk/1J2Ps+sG0dhUPRJH2eqeUdgeXmgla1UAALDz2hIujPVEyicBiOTY2ZR0X/Kkt6LjHj3
	iq7bXYKJMB8dqwB/eQVoVYRzQis=
X-Received: by 2002:a05:600c:8b2f:b0:496:c378:6420 with SMTP id 5b1f17b1804b1-499821a2051mr15427805e9.8.1786577626055;
        Wed, 12 Aug 2026 16:33:46 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49981b1063esm27410575e9.6.2026.08.12.16.33.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 16:33:45 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v4 10/16] bpf: Report Resource Lifetime reference leaks
Date: Thu, 13 Aug 2026 01:33:13 +0200
Message-ID: <20260812233326.3575958-11-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260812233326.3575958-1-memxor@gmail.com>
References: <20260812233326.3575958-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=22984; i=memxor@gmail.com; h=from:subject; bh=Xbes0VWB7UoOqyvnrEPypOeFcVWAIvt4Q7mygJlOqWE=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIauWQadxchm/V9lW21kWjmEiNY6OW3dVbmyvNq23+aLde HoPk3FHKQuDGBeDrJgiS8n/fUzGJyp/B9ou44aZw8oEMoSBi1MAJrJ/NsMfnp1JIf8+5xiZXepS kPVqVrjzh/NGyLo/F//9C7q2t+RLESPDh++5Km3qctzXTYymKvdZJDPkOWlsOX3+5IJN7B9fvp3 PDwA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Augment selected Resource Lifetime Safety failures with structured diagnostics
while preserving the existing verifier messages.

Report unreleased references from check_reference_leak() using
reference-scoped diagnostic history, and add state reports for dynptr,
iterator, lock, and IRQ-flag lifetime misuse.

IRQ restore mismatch and out-of-order diagnostics use IRQ context-scoped
history when an IRQ-disabled region is active, so retained save/restore context
is still visible after per-state history removal.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/diagnostics.c |  90 +++++++++++++++++++++
 kernel/bpf/diagnostics.h |   9 +++
 kernel/bpf/verifier.c    | 170 +++++++++++++++++++++++++++++++++------
 3 files changed, 245 insertions(+), 24 deletions(-)

diff --git a/kernel/bpf/diagnostics.c b/kernel/bpf/diagnostics.c
index 66b5ac451108..708415e74ceb 100644
--- a/kernel/bpf/diagnostics.c
+++ b/kernel/bpf/diagnostics.c
@@ -1698,6 +1698,96 @@ void bpf_diag_mem_bounds(struct bpf_verifier_env *env, u32 insn_idx, int regno,
 		env, "Add or adjust a bounds check that proves offset + access_size stays within the object.");
 }
 
+static const char *diag_lock_name(const struct bpf_reference_state *lock)
+{
+	switch (lock->type) {
+	case REF_TYPE_LOCK:
+		return "bpf_spin_lock";
+	case REF_TYPE_RES_LOCK:
+		return "resource spin lock";
+	case REF_TYPE_RES_LOCK_IRQ:
+		return "IRQ-saving resource spin lock";
+	default:
+		return "lock";
+	}
+}
+
+static void diag_res_report(struct bpf_verifier_env *env, u32 insn_idx, const char *problem,
+			    const char *reason)
+{
+	bpf_diag_header(env, RESOURCE_LIFETIME_SAFETY, problem);
+	diag_reason(env, "%s", reason);
+
+	diag_section(env, "At");
+	bpf_diag_source(env, insn_idx, "error", "%s", problem);
+}
+
+void bpf_diag_res(struct bpf_verifier_env *env, u32 insn_idx, const char *problem,
+		  const char *reason, const char *suggestion)
+{
+	diag_res_report(env, insn_idx, problem, reason);
+	diag_suggestion(env, "%s", suggestion);
+}
+
+void bpf_diag_lock(struct bpf_verifier_env *env, u32 insn_idx, const char *problem,
+		   const char *reason, const char *suggestion,
+		   const struct bpf_reference_state *active_lock)
+{
+	diag_res_report(env, insn_idx, problem, reason);
+
+	if (active_lock) {
+		diag_section(env, "Active lock");
+		bpf_diag_source(env, active_lock->insn_idx, "acquired",
+				       "active %s has verifier identity %d",
+				       diag_lock_name(active_lock), active_lock->id);
+	}
+
+	diag_suggestion(env, "%s", suggestion);
+}
+
+void bpf_diag_irq(struct bpf_verifier_env *env, u32 insn_idx, const char *problem,
+		  const char *reason, const char *suggestion, u32 depth)
+{
+	struct bpf_diag_history_opts opts = {
+		.scope = BPF_DIAG_HISTORY_SCOPE_CONTEXT,
+		.ctx_kind = BPF_DIAG_CONTEXT_IRQ,
+		.ctx_depth = depth,
+	};
+
+	bpf_diag_header(env, RESOURCE_LIFETIME_SAFETY, problem);
+	diag_reason(env, "%s", reason);
+
+	diag_section(env, "At");
+	bpf_diag_source(env, insn_idx, "error", "%s", problem);
+
+	if (depth)
+		diag_print_history(env, &opts);
+
+	diag_suggestion(env, "%s", suggestion);
+}
+
+void bpf_diag_leak(struct bpf_verifier_env *env, u32 ref_id, u32 alloc_insn, u32 fail_insn)
+{
+	struct bpf_diag_history_opts opts = {
+		.scope = BPF_DIAG_HISTORY_SCOPE_REF,
+		.ref_id = ref_id,
+	};
+
+	bpf_diag_header(env, RESOURCE_LIFETIME_SAFETY, "unreleased resource");
+	diag_reason(
+		env, "Owned resource (id=%u) was acquired at instruction %u and still needs to be released before this exit path.",
+		ref_id, alloc_insn);
+
+	diag_section(env, "At");
+	bpf_diag_source(env, fail_insn, "error",
+			       "owned resource (id=%u) still needs release", ref_id);
+
+	diag_print_history(env, &opts);
+
+	diag_suggestion(
+		env, "Release or transfer ownership of the acquired resource on every path before the program exits.");
+}
+
 static const char *diag_var_offset(struct bpf_verifier_env *env,
 				   const struct bpf_diag_reg_snapshot *snapshot)
 {
diff --git a/kernel/bpf/diagnostics.h b/kernel/bpf/diagnostics.h
index 51e6a527b075..053655550856 100644
--- a/kernel/bpf/diagnostics.h
+++ b/kernel/bpf/diagnostics.h
@@ -8,6 +8,7 @@
 #include <linux/compiler_attributes.h>
 #include <linux/types.h>
 
+struct bpf_reference_state;
 struct bpf_reg_state;
 struct bpf_verifier_env;
 struct bpf_verifier_state;
@@ -129,6 +130,14 @@ void bpf_diag_memory(struct bpf_verifier_env *env, u32 insn_idx, const char *pro
 void bpf_diag_mem_bounds(struct bpf_verifier_env *env, u32 insn_idx, int regno,
 				const char *reg_name, const char *type_name, const char *proof,
 				int off, int size, u32 mem_size, const struct bpf_reg_state *reg);
+void bpf_diag_res(struct bpf_verifier_env *env, u32 insn_idx, const char *problem,
+		  const char *reason, const char *suggestion);
+void bpf_diag_lock(struct bpf_verifier_env *env, u32 insn_idx, const char *problem,
+		   const char *reason, const char *suggestion,
+		   const struct bpf_reference_state *active_lock);
+void bpf_diag_irq(struct bpf_verifier_env *env, u32 insn_idx, const char *problem,
+		  const char *reason, const char *suggestion, u32 depth);
+void bpf_diag_leak(struct bpf_verifier_env *env, u32 ref_id, u32 alloc_insn, u32 fail_insn);
 void bpf_diag_record_branch(struct bpf_verifier_env *env, u32 insn_idx, bool cond_true);
 void bpf_diag_mod_begin(struct bpf_verifier_env *env, const struct bpf_reg_state *reg,
 			const struct bpf_reg_state *origin, enum bpf_diag_mod_reason reason);
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 080c6b893fb0..24ae3cb38f6d 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -817,6 +817,10 @@ static int destroy_if_dynptr_stack_slot(struct bpf_verifier_env *env,
 	if (dynptr_type_referenced(state->stack[spi].spilled_ptr.dynptr.type) &&
 	    dynptr_ref_cnt(env, state->stack[spi].spilled_ptr.parent_id) <= 1) {
 		verbose(env, "cannot overwrite referenced dynptr\n");
+		bpf_diag_res(
+			env, env->insn_idx, "referenced dynptr overwrite",
+			"This stack slot contains a dynptr that owns or protects a referenced resource. Overwriting the last dynptr for that resource would lose the verifier-tracked release path.",
+			"Release or clone the dynptr so another live dynptr still tracks the referenced resource before overwriting this stack slot.");
 		return -EINVAL;
 	}
 
@@ -887,26 +891,29 @@ static bool is_dynptr_reg_valid_init(struct bpf_verifier_env *env, struct bpf_re
 	return true;
 }
 
-static bool is_dynptr_type_expected(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
-				    enum bpf_arg_type arg_type)
+static enum bpf_dynptr_type dynptr_reg_type(struct bpf_verifier_env *env, struct bpf_reg_state *reg)
 {
-	struct bpf_func_state *state = bpf_func(env, reg);
-	enum bpf_dynptr_type dynptr_type;
+	struct bpf_func_state *state;
 	int spi;
 
+	if (reg->type == CONST_PTR_TO_DYNPTR)
+		return reg->dynptr.type;
+
+	spi = dynptr_get_spi(env, reg);
+	if (spi < 0)
+		return BPF_DYNPTR_TYPE_INVALID;
+	state = bpf_func(env, reg);
+	return state->stack[spi].spilled_ptr.dynptr.type;
+}
+
+static bool is_dynptr_type_expected(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
+				    enum bpf_arg_type arg_type)
+{
 	/* ARG_PTR_TO_DYNPTR takes any type of dynptr */
 	if (arg_type == ARG_PTR_TO_DYNPTR)
 		return true;
 
-	dynptr_type = arg_to_dynptr_type(arg_type);
-	if (reg->type == CONST_PTR_TO_DYNPTR) {
-		return reg->dynptr.type == dynptr_type;
-	} else {
-		spi = dynptr_get_spi(env, reg);
-		if (spi < 0)
-			return false;
-		return state->stack[spi].spilled_ptr.dynptr.type == dynptr_type;
-	}
+	return dynptr_reg_type(env, reg) == arg_to_dynptr_type(arg_type);
 }
 
 static void __mark_reg_known_zero(struct bpf_reg_state *reg);
@@ -1097,11 +1104,21 @@ static int unmark_stack_slot_irq_flag(struct bpf_verifier_env *env, struct bpf_r
 	st = &slot->spilled_ptr;
 
 	if (st->irq.kfunc_class != kfunc_class) {
-		const char *flag_kfunc = st->irq.kfunc_class == IRQ_NATIVE_KFUNC ? "native" : "lock";
+		const char *fmt = "This IRQ flag was saved by %s IRQ kfuncs, but the restore call "
+				  "belongs to the %s IRQ kfunc family. Save and restore operations "
+				  "must use the same family.";
+		const char *flag_kfunc = st->irq.kfunc_class == IRQ_NATIVE_KFUNC ? "native" :
+										   "lock";
 		const char *used_kfunc = kfunc_class == IRQ_NATIVE_KFUNC ? "native" : "lock";
+		const char *reason;
 
 		verbose(env, "irq flag acquired by %s kfuncs cannot be restored with %s kfuncs\n",
 			flag_kfunc, used_kfunc);
+		reason = bpf_diag_fmt(env, fmt, flag_kfunc, used_kfunc);
+		bpf_diag_irq(env, env->insn_idx, "IRQ flag restore mismatch", reason,
+			     "Restore the flag with the matching IRQ restore kfunc for the save "
+			     "operation that created it.",
+			     bpf_diag_irq_depth(env->cur_state));
 		return -EINVAL;
 	}
 
@@ -1119,6 +1136,11 @@ static int unmark_stack_slot_irq_flag(struct bpf_verifier_env *env, struct bpf_r
 
 		verbose(env, "cannot restore irq state out of order, expected id=%d acquired at insn_idx=%d\n",
 			env->cur_state->active_irq_id, insn_idx);
+		bpf_diag_irq(env, env->insn_idx, "IRQ flag restore out of order",
+			     "IRQ-disabled regions must be restored in last-in, first-out order, "
+			     "but this restore does not match the currently active IRQ flag.",
+			     "Restore nested IRQ flags in the reverse order they were saved.",
+			     bpf_diag_irq_depth(env->cur_state));
 		return err;
 	}
 
@@ -7136,11 +7158,13 @@ enum {
  * env->cur_state->active_locks remembers which map value element or allocated
  * object got locked and clears it after bpf_spin_unlock.
  */
-static int process_spin_lock(struct bpf_verifier_env *env, struct bpf_reg_state *reg, argno_t argno, int flags)
+static int process_spin_lock(struct bpf_verifier_env *env, struct bpf_reg_state *reg, argno_t argno,
+			     int flags)
 {
 	bool is_lock = flags & PROCESS_SPIN_LOCK, is_res_lock = flags & PROCESS_RES_LOCK;
 	const char *lock_str = is_res_lock ? "bpf_res_spin" : "bpf_spin";
 	struct bpf_verifier_state *cur = env->cur_state;
+	struct bpf_reference_state *lock;
 	bool is_const = tnum_is_const(reg->var_off);
 	bool is_irq = flags & PROCESS_LOCK_IRQ;
 	u64 val = reg->var_off.value;
@@ -7190,14 +7214,25 @@ static int process_spin_lock(struct bpf_verifier_env *env, struct bpf_reg_state
 			ptr = btf;
 
 		if (!is_res_lock && cur->active_locks) {
-			if (find_lock_state(env->cur_state, REF_TYPE_LOCK, 0, NULL)) {
+			lock = find_lock_state(cur, REF_TYPE_LOCK, 0, NULL);
+			if (lock) {
 				verbose(env,
 					"Locking two bpf_spin_locks are not allowed\n");
+				bpf_diag_lock(
+					env, env->insn_idx, "nested spin lock",
+					"This path already holds a bpf_spin_lock. The verifier allows only one regular BPF spin lock at a time.",
+					"Unlock the current bpf_spin_lock before taking another one.", lock);
 				return -EINVAL;
 			}
 		} else if (is_res_lock && cur->active_locks) {
-			if (find_lock_state(env->cur_state, REF_TYPE_RES_LOCK | REF_TYPE_RES_LOCK_IRQ, reg->id, ptr)) {
+			lock = find_lock_state(cur, REF_TYPE_RES_LOCK | REF_TYPE_RES_LOCK_IRQ,
+					       reg->id, ptr);
+			if (lock) {
 				verbose(env, "Acquiring the same lock again, AA deadlock detected\n");
+				bpf_diag_lock(
+					env, env->insn_idx, "recursive resource spin lock",
+					"This path already holds the same resource spin lock. Taking it again would deadlock.",
+					"Avoid reacquiring the same resource spin lock before it is unlocked.", lock);
 				return -EINVAL;
 			}
 		}
@@ -7224,6 +7259,10 @@ static int process_spin_lock(struct bpf_verifier_env *env, struct bpf_reg_state
 
 		if (!cur->active_locks) {
 			verbose(env, "%s_unlock without taking a lock\n", lock_str);
+			bpf_diag_res(
+				env, env->insn_idx, "unlock without lock",
+				"This unlock operation has no matching active lock on the current path.",
+				"Take the matching lock before this unlock, or remove the unmatched unlock path.");
 			return -EINVAL;
 		}
 
@@ -7233,16 +7272,35 @@ static int process_spin_lock(struct bpf_verifier_env *env, struct bpf_reg_state
 			type = REF_TYPE_RES_LOCK;
 		else
 			type = REF_TYPE_LOCK;
-		if (!find_lock_state(cur, type, reg->id, ptr)) {
+
+		lock = find_lock_state(cur, type, reg->id, ptr);
+		if (!lock) {
 			verbose(env, "%s_unlock of different lock\n", lock_str);
+			lock = find_lock_state(cur, REF_TYPE_LOCK_MASK, cur->active_lock_id,
+					       cur->active_lock_ptr);
+			bpf_diag_lock(
+				env, env->insn_idx, "unlock of a different lock",
+				"This unlock does not match any active lock with the same tracked identity on the current path.",
+				"Unlock the same lock object that was most recently acquired.", lock);
 			return -EINVAL;
 		}
 		if (reg->id != cur->active_lock_id || ptr != cur->active_lock_ptr) {
 			verbose(env, "%s_unlock cannot be out of order\n", lock_str);
+			lock = find_lock_state(cur, REF_TYPE_LOCK_MASK, cur->active_lock_id,
+					       cur->active_lock_ptr);
+			bpf_diag_lock(
+				env, env->insn_idx, "unlock out of order",
+				"Locks must be released in last-in, first-out order, but this unlock does not match the currently active lock.",
+				"Release nested locks in the reverse order they were acquired.", lock);
 			return -EINVAL;
 		}
 		if (release_lock_state(env, type, reg->id, ptr)) {
 			verbose(env, "%s_unlock of different lock\n", lock_str);
+			bpf_diag_lock(
+				env, env->insn_idx, "unlock of a different lock",
+				"The verifier could not release a lock state matching this unlock operation.",
+				"Pass the same lock object and lock kind that were used for the matching lock operation.",
+				lock);
 			return -EINVAL;
 		}
 		if (!in_rcu_cs(env))
@@ -7253,7 +7311,6 @@ static int process_spin_lock(struct bpf_verifier_env *env, struct bpf_reg_state
 	return 0;
 }
 
-/* Check if @regno is a pointer to a specific field in a map value */
 static int check_map_field_pointer(struct bpf_verifier_env *env, struct bpf_reg_state *reg, argno_t argno,
 				   enum btf_field_type field_type,
 				   struct bpf_map_desc *map_desc)
@@ -7395,9 +7452,17 @@ static int process_dynptr_func(struct bpf_verifier_env *env, struct bpf_reg_stat
 	int spi, err = 0;
 
 	if (reg->type != PTR_TO_STACK && reg->type != CONST_PTR_TO_DYNPTR) {
+		const char *fmt = "A dynptr argument must be a pointer to a dynptr stack slot or a verifier-provided const struct bpf_dynptr, but %s is %s.";
+		const char *reason;
+
 		verbose(env,
 			"%s expected pointer to stack or const struct bpf_dynptr\n",
 			reg_arg_name(env, argno));
+		reason = bpf_diag_fmt(env, fmt, reg_arg_name(env, argno),
+						 bpf_diag_reg_type_plain(env, reg->type));
+		bpf_diag_res(
+			env, insn_idx, "invalid dynptr argument", reason,
+			"Pass the address of a stack dynptr object, or use a const dynptr pointer returned by the verifier-supported path.");
 		return -EINVAL;
 	}
 
@@ -7420,6 +7485,10 @@ static int process_dynptr_func(struct bpf_verifier_env *env, struct bpf_reg_stat
 
 		if (!is_dynptr_reg_valid_uninit(env, reg)) {
 			verbose(env, "Dynptr has to be an uninitialized dynptr\n");
+			bpf_diag_res(
+				env, insn_idx, "dynptr is already initialized",
+				"This kfunc constructs a dynptr and requires an uninitialized dynptr stack slot, but the selected slot already holds dynptr state.",
+				"Use a fresh stack dynptr slot, or release/destroy the existing dynptr before reusing the slot.");
 			return -EINVAL;
 		}
 
@@ -7436,21 +7505,37 @@ static int process_dynptr_func(struct bpf_verifier_env *env, struct bpf_reg_stat
 		/* For the reg->type == PTR_TO_STACK case, bpf_dynptr is never const */
 		if (reg->type == CONST_PTR_TO_DYNPTR && (arg_type & OBJ_RELEASE)) {
 			verbose(env, "CONST_PTR_TO_DYNPTR cannot be released\n");
+			bpf_diag_res(
+				env, insn_idx, "const dynptr release",
+				"This release operation was given a const dynptr. Const dynptr values are verifier-provided views and cannot be released by the program.",
+				"Release only mutable dynptrs that the program initialized or reserved.");
 			return -EINVAL;
 		}
 
 		if (!is_dynptr_reg_valid_init(env, reg)) {
 			verbose(env, "Expected an initialized dynptr as %s\n",
 				reg_arg_name(env, argno));
+			bpf_diag_res(
+				env, insn_idx, "uninitialized dynptr use",
+				"This operation requires an initialized dynptr, but the stack slot does not currently hold a valid dynptr on this path.",
+				"Initialize the dynptr on every path before this call, and avoid overwriting or releasing it before this use.");
 			return -EINVAL;
 		}
 
 		/* Fold modifiers (in this case, OBJ_RELEASE) when checking expected type */
 		if (!is_dynptr_type_expected(env, reg, arg_type & ~OBJ_RELEASE)) {
-			verbose(env,
-				"Expected a dynptr of type %s as %s\n",
-				dynptr_type_str(arg_to_dynptr_type(arg_type)),
-				reg_arg_name(env, argno));
+			const char *fmt = "The dynptr is initialized with backing object type %s, but this operation expects dynptr type %s.";
+			enum bpf_dynptr_type expected_type = arg_to_dynptr_type(arg_type);
+			enum bpf_dynptr_type actual_type = dynptr_reg_type(env, reg);
+			const char *reason;
+
+			verbose(env, "Expected a dynptr of type %s as %s\n",
+				dynptr_type_str(expected_type), reg_arg_name(env, argno));
+			reason = bpf_diag_fmt(env, fmt, dynptr_type_str(actual_type),
+							 dynptr_type_str(expected_type));
+			bpf_diag_res(
+				env, insn_idx, "wrong dynptr type", reason,
+				"Use a dynptr constructor that matches this operation, or call an operation that accepts the dynptr's current type.");
 			return -EINVAL;
 		}
 
@@ -7513,8 +7598,16 @@ static int process_iter_arg(struct bpf_verifier_env *env, struct bpf_reg_state *
 	int spi, err, i, nr_slots, btf_id;
 
 	if (reg->type != PTR_TO_STACK) {
+		const char *fmt = "Iterator state must live in verifier-tracked stack memory, but %s is %s.";
+		const char *reason;
+
 		verbose(env, "%s expected pointer to an iterator on stack\n",
 			reg_arg_name(env, argno));
+		reason = bpf_diag_fmt(env, fmt, reg_arg_name(env, argno),
+						 bpf_diag_reg_type_plain(env, reg->type));
+		bpf_diag_res(
+			env, insn_idx, "invalid iterator argument", reason,
+			"Pass the address of a stack iterator object for iterator new, next, and destroy calls.");
 		return -EINVAL;
 	}
 
@@ -7528,6 +7621,10 @@ static int process_iter_arg(struct bpf_verifier_env *env, struct bpf_reg_state *
 	if (btf_id < 0) {
 		verbose(env, "expected valid iter pointer as %s\n",
 			reg_arg_name(env, argno));
+		bpf_diag_res(
+			env, insn_idx, "invalid iterator type",
+			"The kfunc expects a recognized iterator state pointer, but this argument does not match a valid iterator type.",
+			"Pass the exact iterator state type expected by this kfunc.");
 		return -EINVAL;
 	}
 	t = btf_type_by_id(meta->btf, btf_id);
@@ -7538,6 +7635,10 @@ static int process_iter_arg(struct bpf_verifier_env *env, struct bpf_reg_state *
 		if (!is_iter_reg_valid_uninit(env, reg, nr_slots)) {
 			verbose(env, "expected uninitialized iter_%s as %s\n",
 				iter_type_str(meta->btf, btf_id), reg_arg_name(env, argno));
+			bpf_diag_res(
+				env, insn_idx, "iterator is already initialized",
+				"Iterator creation requires an uninitialized iterator stack object, but this stack range already contains iterator state.",
+				"Use a fresh iterator stack slot, or destroy the existing iterator before reusing the slot.");
 			return -EINVAL;
 		}
 
@@ -7562,9 +7663,17 @@ static int process_iter_arg(struct bpf_verifier_env *env, struct bpf_reg_state *
 		case -EINVAL:
 			verbose(env, "expected an initialized iter_%s as %s\n",
 				iter_type_str(meta->btf, btf_id), reg_arg_name(env, argno));
+			bpf_diag_res(
+				env, insn_idx, "uninitialized iterator use",
+				"This iterator operation requires an initialized iterator state object, but the stack range does not contain a live iterator on this path.",
+				"Call the matching iterator new kfunc on every path before calling next or destroy, and do not destroy the iterator before this use.");
 			return err;
 		case -EPROTO:
 			verbose(env, "expected an RCU CS when using %s\n", meta->func_name);
+			bpf_diag_res(
+				env, insn_idx, "iterator requires RCU read lock",
+				"This iterator was created for use under RCU protection, but this path is not currently inside an RCU read lock region.",
+				"Wrap iterator use in bpf_rcu_read_lock() and bpf_rcu_read_unlock(), keeping all exit paths balanced.");
 			return err;
 		default:
 			return err;
@@ -9428,7 +9537,8 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env, int subprog,
 			if (ret)
 				return ret;
 
-			ret = process_dynptr_func(env, reg, argno, -1, arg->arg_type, &ref_obj, NULL);
+			ret = process_dynptr_func(env, reg, argno, env->insn_idx, arg->arg_type,
+					  &ref_obj, NULL);
 			if (ret)
 				return ret;
 		} else if (base_type(arg->arg_type) == ARG_PTR_TO_BTF_ID) {
@@ -10179,6 +10289,7 @@ static int check_reference_leak(struct bpf_verifier_env *env, bool exception_exi
 			continue;
 		verbose(env, "Unreleased reference id=%d alloc_insn=%d\n",
 			state->refs[i].id, state->refs[i].insn_idx);
+		bpf_diag_leak(env, state->refs[i].id, state->refs[i].insn_idx, env->insn_idx);
 		refs_lingering = true;
 	}
 	return refs_lingering ? -EINVAL : 0;
@@ -11732,6 +11843,12 @@ static int process_irq_flag(struct bpf_verifier_env *env, struct bpf_reg_state *
 		if (!is_irq_flag_reg_valid_uninit(env, reg)) {
 			verbose(env, "expected uninitialized irq flag as %s\n",
 				reg_arg_name(env, argno));
+			bpf_diag_res(env, env->insn_idx, "IRQ flag is already initialized",
+				     "Saving IRQ state requires an uninitialized stack slot for "
+				     "the IRQ flag, but this slot already contains tracked IRQ "
+				     "flag state.",
+				     "Use a fresh stack slot for this save operation, or restore "
+				     "the existing IRQ flag before reusing the slot.");
 			return -EINVAL;
 		}
 
@@ -11748,6 +11865,11 @@ static int process_irq_flag(struct bpf_verifier_env *env, struct bpf_reg_state *
 		if (err) {
 			verbose(env, "expected an initialized irq flag as %s\n",
 				reg_arg_name(env, argno));
+			bpf_diag_res(env, env->insn_idx, "uninitialized IRQ flag restore",
+				     "Restoring IRQ state requires a stack slot that was "
+				     "initialized by a matching IRQ save operation on this path.",
+				     "Pass the same stack slot that was previously initialized by "
+				     "the matching IRQ save kfunc.");
 			return err;
 		}
 
-- 
2.53.0

