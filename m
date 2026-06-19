Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com [209.85.221.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 112E63CF208
	for <bpf@vger.kernel.org>; Fri, 19 Jun 2026 20:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781902801; cv=none; b=cLOE/2ufBRNwtxBmXR5a3F1nevXeh/raJKv5k24vUkP+8K7WDI+2BHh/VVV7dL3lpUP9+V4jwpSaLjCLI3k6nxOSRqgbrbVqIBINk5fv3dHcIhSJ0K1EVlET4Pr2l95vWL1c8vTbcPBp92Optv5Mn0BJnWabGCVHfIWQTB8IX+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781902801; c=relaxed/simple;
	bh=Bijl6AJnZmmfu10ZRSkQnoQhoo+UqNb9vdXYskJzRSU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QzMyvK9W42L3ItQ5aDbw13jys/WxduuCmue9I0bFnZhi1lsJi8ZE6PMvTDbau3kEC7vyiv91w0Q9lSDHIkS7Xpnqv0r3N3T7uKN9uj27ANe6UhPWuB83uhe/bvyVivtDgC+SS8d3HChk2MCP4QhLUsB+Xwp+91xLy3yfIK4l1+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gz3htxdS; arc=none smtp.client-ip=209.85.221.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gz3htxdS"
Received: by mail-wr1-f68.google.com with SMTP id ffacd0b85a97d-45fe59255beso1354376f8f.1
        for <bpf@vger.kernel.org>; Fri, 19 Jun 2026 13:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781902786; x=1782507586; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Or0sWcEl6O3JniLLLd+wzl+QCF9HVIOPqLwFZC9t+XM=;
        b=gz3htxdSt9O3Hc/BFP0icXhTZ7db5ofbe4qxQc3hDtwqeAOyhTjee3ES9kao+gopJP
         GP+GEVRh5UGe9eJJF5nM7WHKneSqTxN1W1Ml01vzfQxJ+LxVB0tNbFsUDsHE0ZqRoCN5
         8v2bGWjf17c8e93Q38QvQGf8Wu3qaOQbuRf4mhAuXjyB4HoTpFjoZP+uXe6cYud5PbgZ
         Xgn+I6TCAVJ6MGr3MAtKalbWerPNGTmxCTeBoDTIf/ocpJOPVjxv246JDdNnsm+5Uccz
         ChbBewYgQ2tZPAmKn+xEgUHhRhgvbRH0LxhCeRsH2GUysAMIjFUlLV8duE9K+U/Dec5Y
         eqzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781902786; x=1782507586;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Or0sWcEl6O3JniLLLd+wzl+QCF9HVIOPqLwFZC9t+XM=;
        b=TKlBzTA6EKbQhueADysuAci+i9wM2z6YFEDBrPJ7dOgkmp1JQj+ctPPKU17RsPK0dD
         9kT2E6+TUvQnoXgEmCYWxHhVGsU3V5pW/F91XPJtZKjwwCUF+PuMX+SIt/4R2GfpBG4r
         xBxz+TnuhGZX/TLE3YIK40SAVLyitteIp2tNmHqkt4ciVeGKG87r16wesNmKd2yceBqH
         h9NCtMQRdjEHtnB1AQLeYjHFNKcWkchj9YZiXrOeGoZK/6hzObrqr1saIsxnMjylNjDX
         NsScFbCcqXQRc8nrP9S4zRU6awyaEDKbf0RfsUIONey0sq4yS/q1IqXQb24j40BQXvjE
         4C/A==
X-Gm-Message-State: AOJu0YyqIankgVF2tqJCLN7JUWCFbb3f+q5+JlbiHZIoOCLllKwUGT4S
	a2t2xh5JmARn3Gf/1+9x02X2otXd1XUoepxG9x3B9AsLdSVC2TksDdAGqCVFDuI/
X-Gm-Gg: AfdE7cmlIADDl9GltiEhwvHDIcvrii6e1t4uZ/CYxRj88ncgsgrulyGLaxX7zgDtG+V
	N0VNilto3RH6o/EH4F359tsx7cvA/+SDO/ath6e2cNpcvKjEMom+YgdgedRfdQQLVv8IUFwInJe
	T825xxizA/fqn4d07axU7kqzHZZAPptHAjEyyEwzZ9qHLg8KrzDFTSkMYPudUWDlSfHUhTLJ9MB
	/rd8FzABCb/GP4BmghNY8CywLGBsrRpL8nxnmDRkP9WO3SvYjVrzH8017g8FLXMWqS9CvFOGrqG
	QkenP8gSjZpF68cHSCnfBiRUmJCpnC3wZ7KvjCrVbfQjI8w/DjfmoTmAvgyIAoTH3dXvISzCvvD
	PRgbAgSDF42Ye93GvZEWFDt9eFR+vVWtHdSOx4nLfpwKgBe4juenF7sUoK9dkHsGmXqH5O+Qtqn
	UpgHm1NxoQ7E7VvDXL8g6gn/mNnGjhjYCeGd5tryksfllP9eOGDsXFn4WeceXdFu2RaK+KzWSB+
	6nAopFZkyn2YRnJyHF4jGPE+W3y3EgZj6b0lYDUZL9DTvXVt+yEs6U=
X-Received: by 2002:a05:6000:4b1a:b0:45e:cd0a:b06a with SMTP id ffacd0b85a97d-4656f564845mr6509684f8f.26.1781902785771;
        Fri, 19 Jun 2026 13:59:45 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-466648c53fdsm1882303f8f.10.2026.06.19.13.59.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2026 13:59:45 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v2 10/17] bpf: Report Resource Lifetime reference leaks
Date: Fri, 19 Jun 2026 22:59:23 +0200
Message-ID: <20260619205934.1312876-11-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260619205934.1312876-1-memxor@gmail.com>
References: <20260619205934.1312876-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=17701; i=memxor@gmail.com; h=from:subject; bh=Bijl6AJnZmmfu10ZRSkQnoQhoo+UqNb9vdXYskJzRSU=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIct0FYP/rlcO1uEmLL+eWzdvMl/S3ug9PfbIbdndM6azM G8XkZPrKGVhEONikBVTZCn5v4/J+ETl70DbZdwwc1iZQIYwcHEKwETOVjL8D3sj7qmg3r1/2Z0n W2tYchb6LvO+4X3tYl7L+dPdYu/CSxj++4uXanQ0PHs0q3jp2d0H39YcvzGva8rXPod5f6bOi7L +wggA
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
 kernel/bpf/diagnostics.c | 65 ++++++++++++++++++++++++++++
 kernel/bpf/diagnostics.h | 11 +++++
 kernel/bpf/verifier.c    | 92 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 168 insertions(+)

diff --git a/kernel/bpf/diagnostics.c b/kernel/bpf/diagnostics.c
index 933540eb105b..e9c58f84ec89 100644
--- a/kernel/bpf/diagnostics.c
+++ b/kernel/bpf/diagnostics.c
@@ -1702,6 +1702,71 @@ void bpf_diag_report_mem_bounds(struct bpf_verifier_env *env, u32 insn_idx,
 				   "Add or adjust a bounds check that proves offset + access_size stays within the object.");
 }
 
+void bpf_diag_report_resource_state(struct bpf_verifier_env *env,
+				    u32 insn_idx, const char *problem,
+				    const char *reason,
+				    const char *suggestion)
+{
+	bpf_diag_report_header(env, BPF_DIAG_CATEGORY_RESOURCE_LIFETIME_SAFETY,
+			       problem);
+	bpf_diag_report_reason(env, "%s", reason);
+
+	bpf_diag_report_section(env, "At");
+	bpf_diag_report_source(env, insn_idx, "error", "%s", problem);
+
+	bpf_diag_report_suggestion(env, "%s", suggestion);
+}
+
+void bpf_diag_report_irq_resource_state(struct bpf_verifier_env *env,
+					u32 insn_idx, const char *problem,
+					const char *reason,
+					const char *suggestion,
+					u32 depth)
+{
+	struct bpf_diag_history_opts opts = {
+		.scope = BPF_DIAG_HISTORY_SCOPE_CONTEXT,
+		.ctx_kind = BPF_DIAG_CONTEXT_IRQ,
+		.ctx_depth = depth,
+	};
+
+	bpf_diag_report_header(env, BPF_DIAG_CATEGORY_RESOURCE_LIFETIME_SAFETY,
+			       problem);
+	bpf_diag_report_reason(env, "%s", reason);
+
+	bpf_diag_report_section(env, "At");
+	bpf_diag_report_source(env, insn_idx, "error", "%s", problem);
+
+	if (depth)
+		bpf_diag_print_history(env, &opts);
+
+	bpf_diag_report_suggestion(env, "%s", suggestion);
+}
+
+void bpf_diag_report_ref_leak(struct bpf_verifier_env *env, u32 ref_id,
+			      u32 alloc_insn, u32 fail_insn)
+{
+	struct bpf_diag_history_opts opts = {
+		.scope = BPF_DIAG_HISTORY_SCOPE_REF,
+		.ref_id = ref_id,
+	};
+
+	bpf_diag_report_header(env, BPF_DIAG_CATEGORY_RESOURCE_LIFETIME_SAFETY,
+			       "unreleased resource");
+	bpf_diag_report_reason(env,
+			       "Owned resource (id=%u) was acquired at instruction %u and still needs to be released before this exit path.",
+			       ref_id, alloc_insn);
+
+	bpf_diag_report_section(env, "At");
+	bpf_diag_report_source(env, fail_insn, "error",
+			       "owned resource (id=%u) still needs release",
+			       ref_id);
+
+	bpf_diag_print_history(env, &opts);
+
+	bpf_diag_report_suggestion(env,
+				   "Release or transfer ownership of the acquired resource on every path before the program exits.");
+}
+
 static void bpf_diag_format_var_offset(struct bpf_diag_reg_fmt *fmt,
 				       char *buf, size_t size,
 				       const struct bpf_diag_reg_snapshot *snapshot)
diff --git a/kernel/bpf/diagnostics.h b/kernel/bpf/diagnostics.h
index fea7731d431c..4e0bb27ea951 100644
--- a/kernel/bpf/diagnostics.h
+++ b/kernel/bpf/diagnostics.h
@@ -187,6 +187,17 @@ void bpf_diag_report_mem_bounds(struct bpf_verifier_env *env, u32 insn_idx,
 				enum bpf_diag_mem_bounds_kind kind,
 				int off, int size, u32 mem_size,
 				const struct bpf_reg_state *reg);
+void bpf_diag_report_resource_state(struct bpf_verifier_env *env,
+				    u32 insn_idx, const char *problem,
+				    const char *reason,
+				    const char *suggestion);
+void bpf_diag_report_irq_resource_state(struct bpf_verifier_env *env,
+					u32 insn_idx, const char *problem,
+					const char *reason,
+					const char *suggestion,
+					u32 depth);
+void bpf_diag_report_ref_leak(struct bpf_verifier_env *env, u32 ref_id,
+			      u32 alloc_insn, u32 fail_insn);
 void bpf_diag_record_branch(struct bpf_verifier_env *env, u32 insn_idx,
 			    bool cond_true);
 void bpf_diag_record_reg_mod(struct bpf_verifier_env *env, u32 insn_idx,
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index af04709c5178..db151e6b8949 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -835,6 +835,10 @@ static int destroy_if_dynptr_stack_slot(struct bpf_verifier_env *env,
 	if (dynptr_type_referenced(state->stack[spi].spilled_ptr.dynptr.type) &&
 	    dynptr_ref_cnt(env, state->stack[spi].spilled_ptr.parent_id) <= 1) {
 		verbose(env, "cannot overwrite referenced dynptr\n");
+		bpf_diag_report_resource_state(env, env->insn_idx,
+					       "referenced dynptr overwrite",
+					       "This stack slot contains a dynptr that owns or protects a referenced resource. Overwriting the last dynptr for that resource would lose the verifier-tracked release path.",
+					       "Release or clone the dynptr so another live dynptr still tracks the referenced resource before overwriting this stack slot.");
 		return -EINVAL;
 	}
 
@@ -1120,6 +1124,15 @@ static int unmark_stack_slot_irq_flag(struct bpf_verifier_env *env, struct bpf_r
 
 		verbose(env, "irq flag acquired by %s kfuncs cannot be restored with %s kfuncs\n",
 			flag_kfunc, used_kfunc);
+		bpf_diag_report_irq_resource_state(env, env->insn_idx,
+						   "IRQ flag restore mismatch",
+						   bpf_diag_scratch_printf(env,
+									   0,
+									   "This IRQ flag was saved by %s IRQ kfuncs, but the restore call belongs to the %s IRQ kfunc family. Save and restore operations must use the same family.",
+									   flag_kfunc,
+									   used_kfunc),
+						   "Restore the flag with the matching IRQ restore kfunc for the save operation that created it.",
+						   env->cur_state->active_irq_id ? 1 : 0);
 		return -EINVAL;
 	}
 
@@ -1137,6 +1150,11 @@ static int unmark_stack_slot_irq_flag(struct bpf_verifier_env *env, struct bpf_r
 
 		verbose(env, "cannot restore irq state out of order, expected id=%d acquired at insn_idx=%d\n",
 			env->cur_state->active_irq_id, insn_idx);
+		bpf_diag_report_irq_resource_state(env, env->insn_idx,
+						   "IRQ flag restore out of order",
+						   "IRQ-disabled regions must be restored in last-in, first-out order, but this restore does not match the currently active IRQ flag.",
+						   "Restore nested IRQ flags in the reverse order they were saved.",
+						   env->cur_state->active_irq_id ? 1 : 0);
 		return err;
 	}
 
@@ -7258,11 +7276,19 @@ static int process_spin_lock(struct bpf_verifier_env *env, struct bpf_reg_state
 			if (find_lock_state(env->cur_state, REF_TYPE_LOCK, 0, NULL)) {
 				verbose(env,
 					"Locking two bpf_spin_locks are not allowed\n");
+				bpf_diag_report_resource_state(env, env->insn_idx,
+							       "nested spin lock",
+							       "This path already holds a bpf_spin_lock. The verifier allows only one regular BPF spin lock at a time.",
+							       "Unlock the current bpf_spin_lock before taking another one.");
 				return -EINVAL;
 			}
 		} else if (is_res_lock && cur->active_locks) {
 			if (find_lock_state(env->cur_state, REF_TYPE_RES_LOCK | REF_TYPE_RES_LOCK_IRQ, reg->id, ptr)) {
 				verbose(env, "Acquiring the same lock again, AA deadlock detected\n");
+				bpf_diag_report_resource_state(env, env->insn_idx,
+							       "recursive resource spin lock",
+							       "This path already holds the same resource spin lock. Taking it again would deadlock.",
+							       "Avoid reacquiring the same resource spin lock before it is unlocked.");
 				return -EINVAL;
 			}
 		}
@@ -7289,6 +7315,10 @@ static int process_spin_lock(struct bpf_verifier_env *env, struct bpf_reg_state
 
 		if (!cur->active_locks) {
 			verbose(env, "%s_unlock without taking a lock\n", lock_str);
+			bpf_diag_report_resource_state(env, env->insn_idx,
+						       "unlock without lock",
+						       "This unlock operation has no matching active lock on the current path.",
+						       "Take the matching lock before this unlock, or remove the unmatched unlock path.");
 			return -EINVAL;
 		}
 
@@ -7300,14 +7330,26 @@ static int process_spin_lock(struct bpf_verifier_env *env, struct bpf_reg_state
 			type = REF_TYPE_LOCK;
 		if (!find_lock_state(cur, type, reg->id, ptr)) {
 			verbose(env, "%s_unlock of different lock\n", lock_str);
+			bpf_diag_report_resource_state(env, env->insn_idx,
+						       "unlock of different lock",
+						       "This unlock does not match any active lock with the same tracked identity on the current path.",
+						       "Unlock the same lock object that was most recently acquired.");
 			return -EINVAL;
 		}
 		if (reg->id != cur->active_lock_id || ptr != cur->active_lock_ptr) {
 			verbose(env, "%s_unlock cannot be out of order\n", lock_str);
+			bpf_diag_report_resource_state(env, env->insn_idx,
+						       "unlock out of order",
+						       "Locks must be released in last-in, first-out order, but this unlock does not match the currently active lock.",
+						       "Release nested locks in the reverse order they were acquired.");
 			return -EINVAL;
 		}
 		if (release_lock_state(env, type, reg->id, ptr)) {
 			verbose(env, "%s_unlock of different lock\n", lock_str);
+			bpf_diag_report_resource_state(env, env->insn_idx,
+						       "unlock of different lock",
+						       "The verifier could not release a lock state matching this unlock operation.",
+						       "Pass the same lock object and lock kind that were used for the matching lock operation.");
 			return -EINVAL;
 		}
 
@@ -7473,6 +7515,10 @@ static int process_dynptr_func(struct bpf_verifier_env *env, struct bpf_reg_stat
 		verbose(env,
 			"%s expected pointer to stack or const struct bpf_dynptr\n",
 			reg_arg_name(env, argno));
+		bpf_diag_report_resource_state(env, insn_idx,
+					       "invalid dynptr argument",
+					       "A dynptr argument must be a pointer to a dynptr stack slot or a verifier-provided const struct bpf_dynptr.",
+					       "Pass the address of a stack dynptr object, or use a const dynptr pointer returned by the verifier-supported path.");
 		return -EINVAL;
 	}
 
@@ -7495,6 +7541,10 @@ static int process_dynptr_func(struct bpf_verifier_env *env, struct bpf_reg_stat
 
 		if (!is_dynptr_reg_valid_uninit(env, reg)) {
 			verbose(env, "Dynptr has to be an uninitialized dynptr\n");
+			bpf_diag_report_resource_state(env, insn_idx,
+						       "dynptr is already initialized",
+						       "This kfunc constructs a dynptr and requires an uninitialized dynptr stack slot, but the selected slot already holds dynptr state.",
+						       "Use a fresh stack dynptr slot, or release/destroy the existing dynptr before reusing the slot.");
 			return -EINVAL;
 		}
 
@@ -7511,12 +7561,20 @@ static int process_dynptr_func(struct bpf_verifier_env *env, struct bpf_reg_stat
 		/* For the reg->type == PTR_TO_STACK case, bpf_dynptr is never const */
 		if (reg->type == CONST_PTR_TO_DYNPTR && (arg_type & OBJ_RELEASE)) {
 			verbose(env, "CONST_PTR_TO_DYNPTR cannot be released\n");
+			bpf_diag_report_resource_state(env, insn_idx,
+						       "const dynptr release",
+						       "This release operation was given a const dynptr. Const dynptr values are verifier-provided views and cannot be released by the program.",
+						       "Release only mutable dynptrs that the program initialized or reserved.");
 			return -EINVAL;
 		}
 
 		if (!is_dynptr_reg_valid_init(env, reg)) {
 			verbose(env, "Expected an initialized dynptr as %s\n",
 				reg_arg_name(env, argno));
+			bpf_diag_report_resource_state(env, insn_idx,
+						       "uninitialized dynptr use",
+						       "This operation requires an initialized dynptr, but the stack slot does not currently hold a valid dynptr on this path.",
+						       "Initialize the dynptr on every path before this call, and avoid overwriting or releasing it before this use.");
 			return -EINVAL;
 		}
 
@@ -7526,6 +7584,10 @@ static int process_dynptr_func(struct bpf_verifier_env *env, struct bpf_reg_stat
 				"Expected a dynptr of type %s as %s\n",
 				dynptr_type_str(arg_to_dynptr_type(arg_type)),
 				reg_arg_name(env, argno));
+			bpf_diag_report_resource_state(env, insn_idx,
+						       "wrong dynptr type",
+						       "The dynptr is initialized, but it was created for a different backing object type than this operation accepts.",
+						       "Use a dynptr constructor that matches this operation, or call an operation that accepts the dynptr's current type.");
 			return -EINVAL;
 		}
 
@@ -7594,6 +7656,10 @@ static int process_iter_arg(struct bpf_verifier_env *env, struct bpf_reg_state *
 	if (reg->type != PTR_TO_STACK) {
 		verbose(env, "%s expected pointer to an iterator on stack\n",
 			reg_arg_name(env, argno));
+		bpf_diag_report_resource_state(env, insn_idx,
+					       "invalid iterator argument",
+					       "Iterator state must live in verifier-tracked stack memory, but this argument is not a stack pointer.",
+					       "Pass the address of a stack iterator object for iterator new, next, and destroy calls.");
 		return -EINVAL;
 	}
 
@@ -7607,6 +7673,10 @@ static int process_iter_arg(struct bpf_verifier_env *env, struct bpf_reg_state *
 	if (btf_id < 0) {
 		verbose(env, "expected valid iter pointer as %s\n",
 			reg_arg_name(env, argno));
+		bpf_diag_report_resource_state(env, insn_idx,
+					       "invalid iterator type",
+					       "The kfunc expects a recognized iterator state pointer, but this argument does not match a valid iterator type.",
+					       "Pass the exact iterator state type expected by this kfunc.");
 		return -EINVAL;
 	}
 	t = btf_type_by_id(meta->btf, btf_id);
@@ -7617,6 +7687,10 @@ static int process_iter_arg(struct bpf_verifier_env *env, struct bpf_reg_state *
 		if (!is_iter_reg_valid_uninit(env, reg, nr_slots)) {
 			verbose(env, "expected uninitialized iter_%s as %s\n",
 				iter_type_str(meta->btf, btf_id), reg_arg_name(env, argno));
+			bpf_diag_report_resource_state(env, insn_idx,
+						       "iterator is already initialized",
+						       "Iterator creation requires an uninitialized iterator stack object, but this stack range already contains iterator state.",
+						       "Use a fresh iterator stack slot, or destroy the existing iterator before reusing the slot.");
 			return -EINVAL;
 		}
 
@@ -7641,9 +7715,17 @@ static int process_iter_arg(struct bpf_verifier_env *env, struct bpf_reg_state *
 		case -EINVAL:
 			verbose(env, "expected an initialized iter_%s as %s\n",
 				iter_type_str(meta->btf, btf_id), reg_arg_name(env, argno));
+			bpf_diag_report_resource_state(env, insn_idx,
+						       "uninitialized iterator use",
+						       "This iterator operation requires an initialized iterator state object, but the stack range does not contain a live iterator on this path.",
+						       "Call the matching iterator new kfunc on every path before calling next or destroy, and do not destroy the iterator before this use.");
 			return err;
 		case -EPROTO:
 			verbose(env, "expected an RCU CS when using %s\n", meta->func_name);
+			bpf_diag_report_resource_state(env, insn_idx,
+						       "iterator requires RCU read lock",
+						       "This iterator was created for use under RCU protection, but this path is not currently inside an RCU read lock region.",
+						       "Wrap iterator use in bpf_rcu_read_lock() and bpf_rcu_read_unlock(), keeping all exit paths balanced.");
 			return err;
 		default:
 			return err;
@@ -10333,6 +10415,8 @@ static int check_reference_leak(struct bpf_verifier_env *env, bool exception_exi
 			continue;
 		verbose(env, "Unreleased reference id=%d alloc_insn=%d\n",
 			state->refs[i].id, state->refs[i].insn_idx);
+		bpf_diag_report_ref_leak(env, state->refs[i].id,
+					 state->refs[i].insn_idx, env->insn_idx);
 		refs_lingering = true;
 	}
 	return refs_lingering ? -EINVAL : 0;
@@ -11829,6 +11913,10 @@ static int process_irq_flag(struct bpf_verifier_env *env, struct bpf_reg_state *
 		if (!is_irq_flag_reg_valid_uninit(env, reg)) {
 			verbose(env, "expected uninitialized irq flag as %s\n",
 				reg_arg_name(env, argno));
+			bpf_diag_report_resource_state(env, env->insn_idx,
+						       "IRQ flag is already initialized",
+						       "Saving IRQ state requires an uninitialized stack slot for the IRQ flag, but this slot already contains tracked IRQ flag state.",
+						       "Use a fresh stack slot for this save operation, or restore the existing IRQ flag before reusing the slot.");
 			return -EINVAL;
 		}
 
@@ -11845,6 +11933,10 @@ static int process_irq_flag(struct bpf_verifier_env *env, struct bpf_reg_state *
 		if (err) {
 			verbose(env, "expected an initialized irq flag as %s\n",
 				reg_arg_name(env, argno));
+			bpf_diag_report_resource_state(env, env->insn_idx,
+						       "uninitialized IRQ flag restore",
+						       "Restoring IRQ state requires a stack slot that was initialized by a matching IRQ save operation on this path.",
+						       "Pass the same stack slot that was previously initialized by the matching IRQ save kfunc.");
 			return err;
 		}
 
-- 
2.53.0

