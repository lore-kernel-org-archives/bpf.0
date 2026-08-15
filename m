Received: from mail-wm2-f7.google.com (mail-wm2-f7.google.com [74.125.225.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC3EC3B19B4
	for <bpf@vger.kernel.org>; Sat, 15 Aug 2026 06:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786776404; cv=none; b=L/QcVOWWJ0RxZo7qCyE67+yFYYubWmbgBKbatQ/TbfpRrjYtO53LJPjCuB3fQAyrcUFAJ2OytgeOSWHtLFrwc/8MrGeVFi4V9ExV1fkVQVH10t11oBQFdt89ibk/W4uFIUow2kquh9EAYyh1pPSsw8BqIQ+X+OkMBRz0eyQzVG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786776404; c=relaxed/simple;
	bh=qG6p4gCO++XgCn7rFI3udueiNWBzgc4VPWgxd6OSpWc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NnCXCuvlNEPLYt8a9Lw3aUrN/4V23chur61t8loVlDXNL8OFZeUJCPqYf2fpE6I4f8cGfQ9yl666Gatk9VOY6S6d/sfzDr0rqoB+CbvvJJ5V/K+/IHiA7p/E3E+Guakph0h5yF2iz9smXjJ39B1bzQt1JxdwFgIA+hHRffELcwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z7gV9hBA; arc=none smtp.client-ip=74.125.225.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z7gV9hBA"
Received: by mail-wm2-f7.google.com with SMTP id 5b1f17b1804b1-498079e98beso4055845e9.1
        for <bpf@vger.kernel.org>; Fri, 14 Aug 2026 23:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786776388; x=1787381188; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0+ogF3y6YlWDEEEqsYUVFg436KKjHHBUnaiAkOY6jMM=;
        b=Z7gV9hBAcgtnkwjd134K7ZWRPYQWndE93tPeOe994D4XbNo2qzqbqtxKAtoV+s+LgX
         SIMZQr2lFCuRUt/IueOjvFeDY+rwfo9l6flXKbZBHRTUs2D2FIhJHTfNDHpUekEUg7hz
         LNYYmnAreJiVCbsFemNdtSLmphnkdy5SPUP+fT/Nvr01Zh63N2LkNavJxhsSnYCEAYZ4
         S3w4eEcfWjnQ3WQCbvXCv5Xm8z49/Q0TDI3iNHoc24rhrlUHzvb65aVNXPlYJepUYnkZ
         hEGtRLRX2u0aMVyimsRXdxyIr/z494EXpnaEAyzzyuBAX+jrZfFEprmjNSgAzRUV3CQt
         5tDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786776388; x=1787381188;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0+ogF3y6YlWDEEEqsYUVFg436KKjHHBUnaiAkOY6jMM=;
        b=GNgItfUL919hAV1EUAHGogC8j1x6PvfO7wHKOlaxAoWUG3mVlvNSUIGg+luiFoILur
         yLboeErhOG1xUhJyTjHz7BHn9052XA0eYVkGwI1Hh6D+FmBLK682LB109VmcZq+oEucy
         BuK3bP+OBbTsfdyE8EJw699zj62Sc6LGnzfM47xlu7myorkfaamKXone/7iJFnBjFLam
         yE+OOAYoadKxLFLSITU0MwHThhY3YGDudEfi0EI2WNcA2JxDdfIOsvNm/r7B00y3EISY
         hHEtGeutJkYnjN78dYRnb1wLSkEHl+clQViuD0Kpnufba3djgIZYs9UUrJu8yGW9IIzf
         fwhA==
X-Gm-Message-State: AOJu0YyEwLBds3WTB+iswgIfNA4O1ny90B+Vnly+fIZUPU3Voz+snd5g
	WqtnYntK22jViLEuYom8WxdK4Se0jMbWAcMvhpqEWv45fXxchtomwCtSWN5RRt5F
X-Gm-Gg: AR+sD11bZs1bhrD1oZUF2osVC+nekKMT7rXhOwUQQLpJlJJN8ZmOXD0jakAlCQgQISK
	0VijpaSQb7VpdFSZBqHQHx5z4E8qdiwmlw2KdNsQkmyrbmNeHUrZGeOmvYnFPRoR5AyxKvsS7hp
	co9wrf6xbdhsM5IBinFAfNNKlvbQGM9im2KwkQrC1M+yXDEeEyHSKUw0IzFvyjDH6zuTJ2I1nLg
	qlfumpwd6KYQ5qI3e1S7ANSyu51Tj9XA/2zWl3jgERWeVlIiVnDmBZRF6YC/IGXX6RqjCF8gPz6
	plAtJFsQtQdYCC7HRmbAwKrJrqlDS66aoDLAhu9L2anm1jWyUVmgfliRSqDcO3rYCby0JR0LS44
	ltF+WtBsWFlDqhTgpmbOw4+ZAWwAweu7qTEZq22iJQRUxa+Yoft6ZSprp88BXsywyWlTx72oaei
	n1Zli9WbJkQiY4QjCFu5ibcx5d+0vX2oUCNkOZQ8aoAPFvMlZ9qdAOVMnnR18wmLgZcU+jjmLsr
	reP1ljO2RAwF2/AjWEOy4EEp0W2V+8SByUtRxWURlwUCtjTKD5GUHFXrPH8cFVayWiKAKNSA76y
	Us3wo7Bg9v2JCZda3jjVAr8T3yrgKAxQ
X-Received: by 2002:a05:600c:37cd:b0:499:8596:3ba9 with SMTP id 5b1f17b1804b1-499879c279cmr176401635e9.18.1786776387587;
        Fri, 14 Aug 2026 23:46:27 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4815f21a31dsm15363637f8f.9.2026.08.14.23.46.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 23:46:27 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v5 10/14] bpf: Report Resource Lifetime reference leaks
Date: Sat, 15 Aug 2026 08:46:05 +0200
Message-ID: <20260815064612.378577-11-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260815064612.378577-1-memxor@gmail.com>
References: <20260815064612.378577-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=17962; i=memxor@gmail.com; h=from:subject; bh=qG6p4gCO++XgCn7rFI3udueiNWBzgc4VPWgxd6OSpWc=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIauBy/dZadV13j/aFqrx9yykOQQFmOMLZ01PfdvNIXn++ izFh64dpSwMYlwMsmKKLCX/9zEZn6j8HWi7jBtmDisTyBAGLk4BmAj/dUaGB//OxNuuXbfs67Jc p8XZAQeDTHxunHD/1jdn4hKui94GGQz/C6/Z3jTlcGD5bq/A/35673lb1kD+DR5l7qXdO0LNqjj 4AQ==
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
 kernel/bpf/diagnostics.c |  91 ++++++++++++++++++++++++++++++++++
 kernel/bpf/diagnostics.h |   9 ++++
 kernel/bpf/verifier.c    | 103 ++++++++++++++++++++++++++++++++++++---
 3 files changed, 195 insertions(+), 8 deletions(-)

diff --git a/kernel/bpf/diagnostics.c b/kernel/bpf/diagnostics.c
index 058574a1411e..5d20ea9e470e 100644
--- a/kernel/bpf/diagnostics.c
+++ b/kernel/bpf/diagnostics.c
@@ -18,6 +18,7 @@
 
 #define REGISTER_TYPE_SAFETY "Register Type Safety"
 #define MEMORY_SAFETY "Memory Safety"
+#define RESOURCE_LIFETIME_SAFETY "Resource Lifetime Safety"
 
 #define BPF_DIAG_TEXT_WIDTH 100
 #define BPF_DIAG_TEXT_INDENT "  "
@@ -1735,6 +1736,96 @@ void bpf_diag_mem_bounds(struct bpf_verifier_env *env, u32 insn_idx, int regno,
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
+				"active %s has verifier identity %d",
+				diag_lock_name(active_lock), active_lock->id);
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
+			"owned resource (id=%u) still needs release", ref_id);
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
index b5feda71de3e..66dd2bb655b7 100644
--- a/kernel/bpf/diagnostics.h
+++ b/kernel/bpf/diagnostics.h
@@ -9,6 +9,7 @@
 #include <linux/stdarg.h>
 #include <linux/types.h>
 
+struct bpf_reference_state;
 struct bpf_func_state;
 struct bpf_reg_state;
 struct bpf_verifier_env;
@@ -68,6 +69,14 @@ void bpf_diag_memory(struct bpf_verifier_env *env, u32 insn_idx, const char *pro
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
index cfc14167cad1..f5bf8cf644b8 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -816,6 +816,10 @@ static int destroy_if_dynptr_stack_slot(struct bpf_verifier_env *env,
 	if (dynptr_type_referenced(state->stack[spi].spilled_ptr.dynptr.type) &&
 	    dynptr_ref_cnt(env, state->stack[spi].spilled_ptr.parent_id) <= 1) {
 		verbose(env, "cannot overwrite referenced dynptr\n");
+		bpf_diag_res(
+			env, env->insn_idx, "referenced dynptr overwrite",
+			"This stack slot contains a dynptr that owns or protects a referenced resource. Overwriting the last dynptr for that resource would lose the verifier-tracked release path.",
+			"Release or clone the dynptr so another live dynptr still tracks the referenced resource before overwriting this stack slot.");
 		return -EINVAL;
 	}
 
@@ -1098,9 +1102,19 @@ static int unmark_stack_slot_irq_flag(struct bpf_verifier_env *env, struct bpf_r
 	if (st->irq.kfunc_class != kfunc_class) {
 		const char *flag_kfunc = st->irq.kfunc_class == IRQ_NATIVE_KFUNC ? "native" : "lock";
 		const char *used_kfunc = kfunc_class == IRQ_NATIVE_KFUNC ? "native" : "lock";
+		const char *reason;
 
 		verbose(env, "irq flag acquired by %s kfuncs cannot be restored with %s kfuncs\n",
 			flag_kfunc, used_kfunc);
+		reason = bpf_diag_fmt(env,
+				      "This IRQ flag was saved by %s IRQ kfuncs, but the restore call "
+			"belongs to the %s IRQ kfunc family. Save and restore operations "
+			"must use the same family.",
+			flag_kfunc, used_kfunc);
+		bpf_diag_irq(env, env->insn_idx, "IRQ flag restore mismatch", reason,
+			     "Restore the flag with the matching IRQ restore kfunc for the save "
+			     "operation that created it.",
+			     bpf_diag_irq_depth(env->cur_state));
 		return -EINVAL;
 	}
 
@@ -1118,6 +1132,11 @@ static int unmark_stack_slot_irq_flag(struct bpf_verifier_env *env, struct bpf_r
 
 		verbose(env, "cannot restore irq state out of order, expected id=%d acquired at insn_idx=%d\n",
 			env->cur_state->active_irq_id, insn_idx);
+		bpf_diag_irq(env, env->insn_idx, "IRQ flag restore out of order",
+			     "IRQ-disabled regions must be restored in last-in, first-out order, "
+			     "but this restore does not match the currently active IRQ flag.",
+			     "Restore nested IRQ flags in the reverse order they were saved.",
+			     bpf_diag_irq_depth(env->cur_state));
 		return err;
 	}
 
@@ -7184,6 +7203,7 @@ static int process_spin_lock(struct bpf_verifier_env *env, struct bpf_reg_state
 	bool is_lock = flags & PROCESS_SPIN_LOCK, is_res_lock = flags & PROCESS_RES_LOCK;
 	const char *lock_str = is_res_lock ? "bpf_res_spin" : "bpf_spin";
 	struct bpf_verifier_state *cur = env->cur_state;
+	struct bpf_reference_state *lock;
 	bool is_const = tnum_is_const(reg->var_off);
 	bool is_irq = flags & PROCESS_LOCK_IRQ;
 	u64 val = reg->var_off.value;
@@ -7233,14 +7253,25 @@ static int process_spin_lock(struct bpf_verifier_env *env, struct bpf_reg_state
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
@@ -7267,6 +7298,10 @@ static int process_spin_lock(struct bpf_verifier_env *env, struct bpf_reg_state
 
 		if (!cur->active_locks) {
 			verbose(env, "%s_unlock without taking a lock\n", lock_str);
+			bpf_diag_res(
+				env, env->insn_idx, "unlock without lock",
+				"This unlock operation has no matching active lock on the current path.",
+				"Take the matching lock before this unlock, or remove the unmatched unlock path.");
 			return -EINVAL;
 		}
 
@@ -7276,16 +7311,35 @@ static int process_spin_lock(struct bpf_verifier_env *env, struct bpf_reg_state
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
@@ -7463,6 +7517,10 @@ static int process_dynptr_func(struct bpf_verifier_env *env, struct bpf_reg_stat
 
 		if (!is_dynptr_reg_valid_uninit(env, reg)) {
 			verbose(env, "Dynptr has to be an uninitialized dynptr\n");
+			bpf_diag_res(
+				env, insn_idx, "dynptr is already initialized",
+				"This kfunc constructs a dynptr and requires an uninitialized dynptr stack slot, but the selected slot already holds dynptr state.",
+				"Use a fresh stack dynptr slot, or release/destroy the existing dynptr before reusing the slot.");
 			return -EINVAL;
 		}
 
@@ -7479,21 +7537,29 @@ static int process_dynptr_func(struct bpf_verifier_env *env, struct bpf_reg_stat
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
+			enum bpf_dynptr_type expected_type = arg_to_dynptr_type(arg_type);
+
+			verbose(env, "Expected a dynptr of type %s as %s\n",
+				dynptr_type_str(expected_type), reg_arg_name(env, argno));
 			return -EINVAL;
 		}
 
@@ -7580,6 +7646,10 @@ static int process_iter_arg(struct bpf_verifier_env *env, struct bpf_reg_state *
 		if (!is_iter_reg_valid_uninit(env, reg, nr_slots)) {
 			verbose(env, "expected uninitialized iter_%s as %s\n",
 				iter_type_str(meta->btf, btf_id), reg_arg_name(env, argno));
+			bpf_diag_res(
+				env, insn_idx, "iterator is already initialized",
+				"Iterator creation requires an uninitialized iterator stack object, but this stack range already contains iterator state.",
+				"Use a fresh iterator stack slot, or destroy the existing iterator before reusing the slot.");
 			return -EINVAL;
 		}
 
@@ -7604,6 +7674,10 @@ static int process_iter_arg(struct bpf_verifier_env *env, struct bpf_reg_state *
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
@@ -9476,7 +9550,8 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env, int subprog,
 			if (ret)
 				return ret;
 
-			ret = process_dynptr_func(env, reg, argno, -1, arg->arg_type, &ref_obj, NULL);
+			ret = process_dynptr_func(env, reg, argno, env->insn_idx, arg->arg_type,
+						  &ref_obj, NULL);
 			if (ret)
 				return ret;
 		} else if (base_type(arg->arg_type) == ARG_PTR_TO_BTF_ID) {
@@ -10274,6 +10349,7 @@ static int check_reference_leak(struct bpf_verifier_env *env, bool exception_exi
 			continue;
 		verbose(env, "Unreleased reference id=%d alloc_insn=%d\n",
 			state->refs[i].id, state->refs[i].insn_idx);
+		bpf_diag_leak(env, state->refs[i].id, state->refs[i].insn_idx, env->insn_idx);
 		refs_lingering = true;
 	}
 	return refs_lingering ? -EINVAL : 0;
@@ -11824,6 +11900,12 @@ static int process_irq_flag(struct bpf_verifier_env *env, struct bpf_reg_state *
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
 
@@ -11840,6 +11922,11 @@ static int process_irq_flag(struct bpf_verifier_env *env, struct bpf_reg_state *
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

