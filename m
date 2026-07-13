Received: from mail-wr2-f0.google.com (mail-wr2-f0.google.com [74.125.225.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34B57431E6D
	for <bpf@vger.kernel.org>; Mon, 13 Jul 2026 15:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783957169; cv=none; b=hIr+Be79dDiueiT6fa2vnIggkspnG9iGOe109PVLOTaV/U3Cjz3UDFpQhkUMT2zIBjI8EqX6cDEJ8Dn03aTd+07mh7nRlNKh3R3LSAsJnVwlmADTOjpHRi20zwPOc9By+wkfcUBSl5dR8rZKqzjLvNYnkD8JLQfzar/nWU2NjHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783957169; c=relaxed/simple;
	bh=GYWVA/GfQb4mC7u2nMrfrb9Sxg+MCFUXnqyBuX8q89g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YWtkQogItbSK9gaAXeckoROnYvNkEh1xLwyjEwCEJH2zRSS+GZtTCWB6d4+aPioVa/AeISI2HaU73sGiXRH5Hsown+b9BONZD3IuGMzTQp8jvJ0eVflUetNuo6FRkxTbfKwrwm8Lq1Qp7puKPTAdpkbdHJh3/IK+/51VkOX9Yt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lJnAVZXl; arc=none smtp.client-ip=74.125.225.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lJnAVZXl"
Received: by mail-wr2-f0.google.com with SMTP id ffacd0b85a97d-47825ef4012so923103f8f.1
        for <bpf@vger.kernel.org>; Mon, 13 Jul 2026 08:39:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783957165; x=1784561965; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Zsrv4NO6w4UTqJbp9zo4msKVO+7i7dY3UwqHjIvEeDY=;
        b=lJnAVZXlbQ371/dv6sBXk/PmhCYRRrXv7yiWCPHlO0izPcRBZIWPx6fF7qrJrikpKV
         yW84pkZhin1s+BIiL89w3YReKPJjtuAVJslSzAA2vq01Zv4IFWGrrKXUsjuhO96qVzui
         Si0CgwE0/gUG5PkC5BKFNyBbAUaycwid13xaKE8RKevge5Z//Ds+x8Haer+IriAfiuT6
         qpVElb2k2L9P41DUO4h8Gh3Bn2dTawYEGc8wP4OJ7Il91ySTMYbq9vJAlDpx5pyJD7px
         UAO7X8/gvVtJfe8tJqtLzkjHO0fwKqmZB/bxbIUvhkLUFjhUlY1RLM7it/n7ydRGoHGm
         Ms0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783957165; x=1784561965;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Zsrv4NO6w4UTqJbp9zo4msKVO+7i7dY3UwqHjIvEeDY=;
        b=KpT47dJBn54QHtZz3zK8k/6msqE+vc6vzW/AsZRNli2UGdmYN6XdaG9Nh82bm0SZp5
         /LQwqoprH+U3W2cj9PfHoXjTY/3bl8uBBisqMDK1tV0jL8aVSFA5ZoC12FcvvhWKVdEJ
         UJ6OtkvO0FQG4NfSkDk0eL+3dN1qCEIFRrFFG29NTIHiOODUtMTSFycfDZz5DZSQkSl6
         l8UR39HU/9KgP1TUOv6HtQn5JyZBaMtoK2SCDxlkDT9iOE1hn7Mp3vwpIsdxxg9ByhZG
         L9mxUKL2AaEdqc6FtaVH7taYlm1IwkklX/eU3OdG3VbeULM/vJVxqPnCNJ+DezNop4rA
         nMBg==
X-Gm-Message-State: AOJu0YwtuznM7Bs6tOQDIulc0EzRfsL4rq7/ro/j4GjC8a6lvnrDIJNz
	7qOnTHK+DlGeMEBqOa2Rb8xpA1FBxnRqA04H58UDFc4CWTAMHsdhFdI4J/61dBO9
X-Gm-Gg: AfdE7clszSpE6RlDfZ/T5KIr570zSe1BJaMKzRyhlfVwT6nswhYxx3Mz9z55m/dlgHU
	vqqQvFk2nBcE8ys+US7kW4VccvSi85vZXRG6dWUdjNSij7vw/jHFCZq/nXGum97PF4VRwalfTep
	axuw5KWT87uk14vAYgspBLLAUtc47lBoyZofxuBpQ2wSZTT1WDFAABTbe08DBOyzr1XmNJkXepT
	kafzKBx8OR3e1ErkHJvVxNluQ0Kb8RgqshcYYVHapV8SrSi553unbnv8IHXc+j5ZrHtQng2ShDC
	U5lDFLb2M6UAkWCzDyTmj9fgXPsLGnMd9arQ/EtGjaQDeicd1yTvEV7ZnNaDEDxsl+EhYXbd3u/
	fA2yV1Y0GQTn9h12bSuVdVzZP1RhfKs/3zkiX1BCaCDYFjVziwnR1vBciaBIc6uHqy9zcEd3tdF
	K5ordefMwmIVlUEoCbou8x8XIyk++Z1ktwaJopu7aBS2b3HNf2HOt30/4jTmRSE3cQsCkU/kXq/
	7hJWFBkEeJbMXkNl6Klo47XN8UYfVsFnl2KJBZd/ZJ11LhPnQC3mwUbtUV22QgpXg==
X-Received: by 2002:a05:6000:26c9:b0:475:f100:35f3 with SMTP id ffacd0b85a97d-47f2dd2ef0dmr10984024f8f.48.1783957165320;
        Mon, 13 Jul 2026 08:39:25 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f464c25b2sm129373f8f.30.2026.07.13.08.39.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 08:39:24 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v3 10/17] bpf: Report Resource Lifetime reference leaks
Date: Mon, 13 Jul 2026 17:38:59 +0200
Message-ID: <20260713153910.2556007-11-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260713153910.2556007-1-memxor@gmail.com>
References: <20260713153910.2556007-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=23516; i=memxor@gmail.com; h=from:subject; bh=GYWVA/GfQb4mC7u2nMrfrb9Sxg+MCFUXnqyBuX8q89g=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JISuURUErfBLrsah8Zsf04zvNvC+Z6T8Prpy65Yz5pN99Z 53zgtd0lLIwiHExyIopspT838dkfKLyd6DtMm6YOaxMIEMYuDgFYCK7LjL896idNHH5p75F8667 JnI4e39mPJT2rcQhz1Zrp9T+318+7mRkWPtG7/klz7XXwpLDeDl+5HgLzc5wPz9PqELE/X9HOOs VFgA=
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
 kernel/bpf/diagnostics.c |  91 ++++++++++++++++++
 kernel/bpf/diagnostics.h |   9 ++
 kernel/bpf/verifier.c    | 198 ++++++++++++++++++++++++++++++++++-----
 3 files changed, 273 insertions(+), 25 deletions(-)

diff --git a/kernel/bpf/diagnostics.c b/kernel/bpf/diagnostics.c
index d4588b19aac9..e454bcd0a0e0 100644
--- a/kernel/bpf/diagnostics.c
+++ b/kernel/bpf/diagnostics.c
@@ -1644,6 +1644,97 @@ void bpf_diag_report_mem_bounds(struct bpf_verifier_env *env, u32 insn_idx, int
 				    "stays within the object.");
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
+	bpf_diag_report_header(env, CATEGORY_RESOURCE_LIFETIME_SAFETY, problem);
+	diag_report_reason(env, "%s", reason);
+
+	diag_report_section(env, "At");
+	bpf_diag_report_source(env, insn_idx, "error", "%s", problem);
+}
+
+void bpf_diag_res(struct bpf_verifier_env *env, u32 insn_idx, const char *problem,
+		  const char *reason, const char *suggestion)
+{
+	diag_res_report(env, insn_idx, problem, reason);
+	diag_report_suggestion(env, "%s", suggestion);
+}
+
+void bpf_diag_lock(struct bpf_verifier_env *env, u32 insn_idx, const char *problem,
+		   const char *reason, const char *suggestion,
+		   const struct bpf_reference_state *active_lock)
+{
+	diag_res_report(env, insn_idx, problem, reason);
+
+	if (active_lock) {
+		diag_report_section(env, "Active lock");
+		bpf_diag_report_source(env, active_lock->insn_idx, "acquired",
+				       "active %s has verifier identity %d",
+				       diag_lock_name(active_lock), active_lock->id);
+	}
+
+	diag_report_suggestion(env, "%s", suggestion);
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
+	bpf_diag_report_header(env, CATEGORY_RESOURCE_LIFETIME_SAFETY, problem);
+	diag_report_reason(env, "%s", reason);
+
+	diag_report_section(env, "At");
+	bpf_diag_report_source(env, insn_idx, "error", "%s", problem);
+
+	if (depth)
+		diag_print_history(env, &opts);
+
+	diag_report_suggestion(env, "%s", suggestion);
+}
+
+void bpf_diag_leak(struct bpf_verifier_env *env, u32 ref_id, u32 alloc_insn, u32 fail_insn)
+{
+	struct bpf_diag_history_opts opts = {
+		.scope = BPF_DIAG_HISTORY_SCOPE_REF,
+		.ref_id = ref_id,
+	};
+
+	bpf_diag_report_header(env, CATEGORY_RESOURCE_LIFETIME_SAFETY, "unreleased resource");
+	diag_report_reason(env,
+			   "Owned resource (id=%u) was acquired at instruction %u and still needs "
+			   "to be released before this exit path.",
+			   ref_id, alloc_insn);
+
+	diag_report_section(env, "At");
+	bpf_diag_report_source(env, fail_insn, "error",
+			       "owned resource (id=%u) still needs release", ref_id);
+
+	diag_print_history(env, &opts);
+
+	diag_report_suggestion(env, "Release or transfer ownership of the acquired resource on "
+				    "every path before the program exits.");
+}
+
 static void diag_format_var_offset(struct bpf_diag_reg_fmt *fmt, char *buf, size_t size,
 				   const struct bpf_diag_reg_snapshot *snapshot)
 {
diff --git a/kernel/bpf/diagnostics.h b/kernel/bpf/diagnostics.h
index 4fc8abb2f2b9..73ddede41d17 100644
--- a/kernel/bpf/diagnostics.h
+++ b/kernel/bpf/diagnostics.h
@@ -8,6 +8,7 @@
 #include <linux/compiler_attributes.h>
 #include <linux/types.h>
 
+struct bpf_reference_state;
 struct bpf_reg_state;
 struct bpf_verifier_env;
 struct bpf_verifier_state;
@@ -142,6 +143,14 @@ void bpf_diag_report_memory(struct bpf_verifier_env *env, u32 insn_idx, const ch
 void bpf_diag_report_mem_bounds(struct bpf_verifier_env *env, u32 insn_idx, int regno,
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
 int bpf_diag_record_branch(struct bpf_verifier_env *env, u32 insn_idx, bool cond_true);
 void bpf_diag_record_mod(struct bpf_verifier_env *env, u32 insn_idx,
 			 struct bpf_diag_mod_target target, enum bpf_diag_mod_reason reason,
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index bd233083b495..84eda5e83f87 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -840,6 +840,12 @@ static int destroy_if_dynptr_stack_slot(struct bpf_verifier_env *env,
 	if (dynptr_type_referenced(state->stack[spi].spilled_ptr.dynptr.type) &&
 	    dynptr_ref_cnt(env, state->stack[spi].spilled_ptr.parent_id) <= 1) {
 		verbose(env, "cannot overwrite referenced dynptr\n");
+		bpf_diag_res(env, env->insn_idx, "referenced dynptr overwrite",
+			     "This stack slot contains a dynptr that owns or protects a referenced "
+			     "resource. Overwriting the last dynptr for that resource would lose "
+			     "the verifier-tracked release path.",
+			     "Release or clone the dynptr so another live dynptr still tracks the "
+			     "referenced resource before overwriting this stack slot.");
 		return -EINVAL;
 	}
 
@@ -910,26 +916,29 @@ static bool is_dynptr_reg_valid_init(struct bpf_verifier_env *env, struct bpf_re
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
@@ -1120,11 +1129,21 @@ static int unmark_stack_slot_irq_flag(struct bpf_verifier_env *env, struct bpf_r
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
+		reason = bpf_diag_scratch_printf(env, 0, fmt, flag_kfunc, used_kfunc);
+		bpf_diag_irq(env, env->insn_idx, "IRQ flag restore mismatch", reason,
+			     "Restore the flag with the matching IRQ restore kfunc for the save "
+			     "operation that created it.",
+			     bpf_diag_irq_depth(env->cur_state));
 		return -EINVAL;
 	}
 
@@ -1142,6 +1161,11 @@ static int unmark_stack_slot_irq_flag(struct bpf_verifier_env *env, struct bpf_r
 
 		verbose(env, "cannot restore irq state out of order, expected id=%d acquired at insn_idx=%d\n",
 			env->cur_state->active_irq_id, insn_idx);
+		bpf_diag_irq(env, env->insn_idx, "IRQ flag restore out of order",
+			     "IRQ-disabled regions must be restored in last-in, first-out order, "
+			     "but this restore does not match the currently active IRQ flag.",
+			     "Restore nested IRQ flags in the reverse order they were saved.",
+			     bpf_diag_irq_depth(env->cur_state));
 		return err;
 	}
 
@@ -7356,11 +7380,13 @@ enum {
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
@@ -7410,14 +7436,30 @@ static int process_spin_lock(struct bpf_verifier_env *env, struct bpf_reg_state
 			ptr = btf;
 
 		if (!is_res_lock && cur->active_locks) {
-			if (find_lock_state(env->cur_state, REF_TYPE_LOCK, 0, NULL)) {
+			lock = find_lock_state(cur, REF_TYPE_LOCK, 0, NULL);
+			if (lock) {
 				verbose(env,
 					"Locking two bpf_spin_locks are not allowed\n");
+				bpf_diag_lock(env, env->insn_idx, "nested spin lock",
+					      "This path already holds a bpf_spin_lock. The "
+					      "verifier allows only one regular BPF spin lock at a "
+					      "time.",
+					      "Unlock the current bpf_spin_lock before taking "
+					      "another one.",
+					      lock);
 				return -EINVAL;
 			}
 		} else if (is_res_lock && cur->active_locks) {
-			if (find_lock_state(env->cur_state, REF_TYPE_RES_LOCK | REF_TYPE_RES_LOCK_IRQ, reg->id, ptr)) {
+			lock = find_lock_state(cur, REF_TYPE_RES_LOCK | REF_TYPE_RES_LOCK_IRQ,
+					       reg->id, ptr);
+			if (lock) {
 				verbose(env, "Acquiring the same lock again, AA deadlock detected\n");
+				bpf_diag_lock(env, env->insn_idx, "recursive resource spin lock",
+					      "This path already holds the same resource spin "
+					      "lock. Taking it again would deadlock.",
+					      "Avoid reacquiring the same resource spin lock "
+					      "before it is unlocked.",
+					      lock);
 				return -EINVAL;
 			}
 		}
@@ -7444,6 +7486,11 @@ static int process_spin_lock(struct bpf_verifier_env *env, struct bpf_reg_state
 
 		if (!cur->active_locks) {
 			verbose(env, "%s_unlock without taking a lock\n", lock_str);
+			bpf_diag_res(env, env->insn_idx, "unlock without lock",
+				     "This unlock operation has no matching active lock on the "
+				     "current path.",
+				     "Take the matching lock before this unlock, or remove the "
+				     "unmatched unlock path.");
 			return -EINVAL;
 		}
 
@@ -7453,16 +7500,40 @@ static int process_spin_lock(struct bpf_verifier_env *env, struct bpf_reg_state
 			type = REF_TYPE_RES_LOCK;
 		else
 			type = REF_TYPE_LOCK;
-		if (!find_lock_state(cur, type, reg->id, ptr)) {
-			verbose(env, "%s_unlock of different lock\n", lock_str);
+
+		lock = find_lock_state(cur, type, reg->id, ptr);
+		if (!lock) {
+			verbose(env, "%s_unlock of a different lock\n", lock_str);
+			lock = find_lock_state(cur, REF_TYPE_LOCK_MASK, cur->active_lock_id,
+					       cur->active_lock_ptr);
+			bpf_diag_lock(env, env->insn_idx, "unlock of a different lock",
+				      "This unlock does not match any active lock with the same "
+				      "tracked identity on the current path.",
+				      "Unlock the same lock object that was most recently "
+				      "acquired.",
+				      lock);
 			return -EINVAL;
 		}
 		if (reg->id != cur->active_lock_id || ptr != cur->active_lock_ptr) {
 			verbose(env, "%s_unlock cannot be out of order\n", lock_str);
+			lock = find_lock_state(cur, REF_TYPE_LOCK_MASK, cur->active_lock_id,
+					       cur->active_lock_ptr);
+			bpf_diag_lock(env, env->insn_idx, "unlock out of order",
+				      "Locks must be released in last-in, first-out order, but "
+				      "this unlock does not match the currently active lock.",
+				      "Release nested locks in the reverse order they were "
+				      "acquired.",
+				      lock);
 			return -EINVAL;
 		}
 		if (release_lock_state(env, type, reg->id, ptr)) {
-			verbose(env, "%s_unlock of different lock\n", lock_str);
+			verbose(env, "%s_unlock of a different lock\n", lock_str);
+			bpf_diag_lock(env, env->insn_idx, "unlock of a different lock",
+				      "The verifier could not release a lock state matching this "
+				      "unlock operation.",
+				      "Pass the same lock object and lock kind that were used for "
+				      "the matching lock operation.",
+				      lock);
 			return -EINVAL;
 		}
 
@@ -7471,7 +7542,6 @@ static int process_spin_lock(struct bpf_verifier_env *env, struct bpf_reg_state
 	return 0;
 }
 
-/* Check if @regno is a pointer to a specific field in a map value */
 static int check_map_field_pointer(struct bpf_verifier_env *env, struct bpf_reg_state *reg, argno_t argno,
 				   enum btf_field_type field_type,
 				   struct bpf_map_desc *map_desc)
@@ -7625,9 +7695,18 @@ static int process_dynptr_func(struct bpf_verifier_env *env, struct bpf_reg_stat
 	int spi, err = 0;
 
 	if (reg->type != PTR_TO_STACK && reg->type != CONST_PTR_TO_DYNPTR) {
+		const char *fmt = "A dynptr argument must be a pointer to a dynptr stack slot or a "
+				  "verifier-provided const struct bpf_dynptr, but %s is %s.";
+		const char *reason;
+
 		verbose(env,
 			"%s expected pointer to stack or const struct bpf_dynptr\n",
 			reg_arg_name(env, argno));
+		reason = bpf_diag_scratch_printf(env, 0, fmt, reg_arg_name(env, argno),
+						 bpf_diag_reg_type_plain(env, reg->type));
+		bpf_diag_res(env, insn_idx, "invalid dynptr argument", reason,
+			     "Pass the address of a stack dynptr object, or use a const dynptr "
+			     "pointer returned by the verifier-supported path.");
 		return -EINVAL;
 	}
 
@@ -7650,6 +7729,12 @@ static int process_dynptr_func(struct bpf_verifier_env *env, struct bpf_reg_stat
 
 		if (!is_dynptr_reg_valid_uninit(env, reg)) {
 			verbose(env, "Dynptr has to be an uninitialized dynptr\n");
+			bpf_diag_res(env, insn_idx, "dynptr is already initialized",
+				     "This kfunc constructs a dynptr and requires an uninitialized "
+				     "dynptr stack slot, but the selected slot already holds "
+				     "dynptr state.",
+				     "Use a fresh stack dynptr slot, or release/destroy the "
+				     "existing dynptr before reusing the slot.");
 			return -EINVAL;
 		}
 
@@ -7666,21 +7751,41 @@ static int process_dynptr_func(struct bpf_verifier_env *env, struct bpf_reg_stat
 		/* For the reg->type == PTR_TO_STACK case, bpf_dynptr is never const */
 		if (reg->type == CONST_PTR_TO_DYNPTR && (arg_type & OBJ_RELEASE)) {
 			verbose(env, "CONST_PTR_TO_DYNPTR cannot be released\n");
+			bpf_diag_res(env, insn_idx, "const dynptr release",
+				     "This release operation was given a const dynptr. Const "
+				     "dynptr values are verifier-provided views and cannot be "
+				     "released by the program.",
+				     "Release only mutable dynptrs that the program initialized or "
+				     "reserved.");
 			return -EINVAL;
 		}
 
 		if (!is_dynptr_reg_valid_init(env, reg)) {
 			verbose(env, "Expected an initialized dynptr as %s\n",
 				reg_arg_name(env, argno));
+			bpf_diag_res(env, insn_idx, "uninitialized dynptr use",
+				     "This operation requires an initialized dynptr, but the stack "
+				     "slot does not currently hold a valid dynptr on this path.",
+				     "Initialize the dynptr on every path before this call, and "
+				     "avoid overwriting or releasing it before this use.");
 			return -EINVAL;
 		}
 
 		/* Fold modifiers (in this case, OBJ_RELEASE) when checking expected type */
 		if (!is_dynptr_type_expected(env, reg, arg_type & ~OBJ_RELEASE)) {
-			verbose(env,
-				"Expected a dynptr of type %s as %s\n",
-				dynptr_type_str(arg_to_dynptr_type(arg_type)),
-				reg_arg_name(env, argno));
+			const char *fmt = "The dynptr is initialized with backing object type %s, "
+					  "but this operation expects dynptr type %s.";
+			enum bpf_dynptr_type expected_type = arg_to_dynptr_type(arg_type);
+			enum bpf_dynptr_type actual_type = dynptr_reg_type(env, reg);
+			const char *reason;
+
+			verbose(env, "Expected a dynptr of type %s as %s\n",
+				dynptr_type_str(expected_type), reg_arg_name(env, argno));
+			reason = bpf_diag_scratch_printf(env, 0, fmt, dynptr_type_str(actual_type),
+							 dynptr_type_str(expected_type));
+			bpf_diag_res(env, insn_idx, "wrong dynptr type", reason,
+				     "Use a dynptr constructor that matches this operation, or "
+				     "call an operation that accepts the dynptr's current type.");
 			return -EINVAL;
 		}
 
@@ -7747,8 +7852,17 @@ static int process_iter_arg(struct bpf_verifier_env *env, struct bpf_reg_state *
 	int spi, err, i, nr_slots, btf_id;
 
 	if (reg->type != PTR_TO_STACK) {
+		const char *fmt = "Iterator state must live in verifier-tracked stack memory, but "
+				  "%s is %s.";
+		const char *reason;
+
 		verbose(env, "%s expected pointer to an iterator on stack\n",
 			reg_arg_name(env, argno));
+		reason = bpf_diag_scratch_printf(env, 0, fmt, reg_arg_name(env, argno),
+						 bpf_diag_reg_type_plain(env, reg->type));
+		bpf_diag_res(env, insn_idx, "invalid iterator argument", reason,
+			     "Pass the address of a stack iterator object for iterator new, next, "
+			     "and destroy calls.");
 		return -EINVAL;
 	}
 
@@ -7762,6 +7876,10 @@ static int process_iter_arg(struct bpf_verifier_env *env, struct bpf_reg_state *
 	if (btf_id < 0) {
 		verbose(env, "expected valid iter pointer as %s\n",
 			reg_arg_name(env, argno));
+		bpf_diag_res(env, insn_idx, "invalid iterator type",
+			     "The kfunc expects a recognized iterator state pointer, but this "
+			     "argument does not match a valid iterator type.",
+			     "Pass the exact iterator state type expected by this kfunc.");
 		return -EINVAL;
 	}
 	t = btf_type_by_id(meta->btf, btf_id);
@@ -7772,6 +7890,12 @@ static int process_iter_arg(struct bpf_verifier_env *env, struct bpf_reg_state *
 		if (!is_iter_reg_valid_uninit(env, reg, nr_slots)) {
 			verbose(env, "expected uninitialized iter_%s as %s\n",
 				iter_type_str(meta->btf, btf_id), reg_arg_name(env, argno));
+			bpf_diag_res(env, insn_idx, "iterator is already initialized",
+				     "Iterator creation requires an uninitialized iterator stack "
+				     "object, but this stack range already contains iterator "
+				     "state.",
+				     "Use a fresh iterator stack slot, or destroy the existing "
+				     "iterator before reusing the slot.");
 			return -EINVAL;
 		}
 
@@ -7796,9 +7920,21 @@ static int process_iter_arg(struct bpf_verifier_env *env, struct bpf_reg_state *
 		case -EINVAL:
 			verbose(env, "expected an initialized iter_%s as %s\n",
 				iter_type_str(meta->btf, btf_id), reg_arg_name(env, argno));
+			bpf_diag_res(env, insn_idx, "uninitialized iterator use",
+				     "This iterator operation requires an initialized iterator "
+				     "state object, but the stack range does not contain a live "
+				     "iterator on this path.",
+				     "Call the matching iterator new kfunc on every path before "
+				     "calling next or destroy, and do not destroy the iterator "
+				     "before this use.");
 			return err;
 		case -EPROTO:
 			verbose(env, "expected an RCU CS when using %s\n", meta->func_name);
+			bpf_diag_res(env, insn_idx, "iterator requires RCU read lock",
+				     "This iterator was created for use under RCU protection, but "
+				     "this path is not currently inside an RCU read lock region.",
+				     "Wrap iterator use in bpf_rcu_read_lock() and "
+				     "bpf_rcu_read_unlock(), keeping all exit paths balanced.");
 			return err;
 		default:
 			return err;
@@ -10493,6 +10629,7 @@ static int check_reference_leak(struct bpf_verifier_env *env, bool exception_exi
 			continue;
 		verbose(env, "Unreleased reference id=%d alloc_insn=%d\n",
 			state->refs[i].id, state->refs[i].insn_idx);
+		bpf_diag_leak(env, state->refs[i].id, state->refs[i].insn_idx, env->insn_idx);
 		refs_lingering = true;
 	}
 	return refs_lingering ? -EINVAL : 0;
@@ -11988,6 +12125,12 @@ static int process_irq_flag(struct bpf_verifier_env *env, struct bpf_reg_state *
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
 
@@ -12004,6 +12147,11 @@ static int process_irq_flag(struct bpf_verifier_env *env, struct bpf_reg_state *
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

