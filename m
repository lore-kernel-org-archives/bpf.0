Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E7AE409E0A
	for <bpf@vger.kernel.org>; Fri,  5 Jun 2026 06:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780641269; cv=none; b=pYCo3MOaM09m7ZqZL8HGTggdIMzJI1bg57vaevcHgwp7RsYaiQFZhRQZWYzejAVQBvEEb2noHHOlh90Y3IozXy5qb+RIvtcVymhzq48Elnqrdfnd7sH1yuMZAISDJKl9oxrYeSiBkdBfLSulUA3XZK+ETVzfFNPxVf6uoFuMRHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780641269; c=relaxed/simple;
	bh=Hg8YyXi4DhSHFn65mfvkHQ2MytzVSmYxfIMZjiGqNrw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yo55pu7BYKyHl0xvz78musLWHF2v0CHF/AxxwvsLnJYddrv/Wfzb+fMzvnMwWQrIq15i/BJ1Fs4rkzHVrwF6ctOXEE5AMy+iPQmZPxb1XqhQs9c/42e+tP3XIFZap0NO/2t5zeWIxEWcXn5Eazt31axeJvJW2g7Xj6bJoHQywCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VaT/iDSw; arc=none smtp.client-ip=209.85.128.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VaT/iDSw"
Received: by mail-wm1-f65.google.com with SMTP id 5b1f17b1804b1-490b2b037d2so13036875e9.3
        for <bpf@vger.kernel.org>; Thu, 04 Jun 2026 23:34:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780641266; x=1781246066; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4e3XuryOhVpuzaLt2O6KyAaoyfgPcUzLOSXkcvyNa2Q=;
        b=VaT/iDSwqmpjFdfTDiasZYB5c7mjiUqsSM8PsDfOE9vq4zZdLiHoYzxj0e9yndgWJQ
         t+Kzc2Q9GdoWaLJ4p7wijVbAmN2JT8a9VQt80Nt86BpZ7F+aHAbpRaylvcoZN3yjVbhQ
         fteYvDMsg9QP9pURr1FvS7Zj5Bl5eGcfcoVsGHwU79Y8ee1xNt7PQf2mL3rG9UUMX/kT
         XIUrkAuTBgl/1SIjtbpjm28QiiYVGYwa99b7nkoxTxC/wV8cIFXkNJwJr3h+RkEBG6Y3
         k+pWxb4EEvpiE/g5rcfxzTLB4pM0Ol8w6p1b46o/zTVxcNy8iDch7jAxNj2F3Rtd/ko6
         +eXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780641266; x=1781246066;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4e3XuryOhVpuzaLt2O6KyAaoyfgPcUzLOSXkcvyNa2Q=;
        b=O2p+uWdnOkR6mOvcSvbcQtvb1rXDFR3/mLRuc+kG+PL6rg5yU3mAEXKeNtxYdDRuzd
         cFwyfFR9et5ldGZtB5Dk24p/xZz3LhrNasbfIJWWVP7N2Q4tUu56yO78jp8KTLJqaJ0p
         3C6aK60NdE3N5TIp3QIh8DcmlcwxbuwapCcsKNzXn9FMUF8R2VZBdEjqKohAEZQ6lQa4
         +22GrMMpPOSjw1ghOpHN76NA1DGo3FiiCNxZGqnehu7ieC9MXXknqoF5+06IgV3G0JW8
         RHH7yc6K7BLQ7bkCakJJbWWGxz3RTD2XjI+VCP4S4+NK5EK9N3zHkR+ezlZUYYfm2fIW
         jNGA==
X-Gm-Message-State: AOJu0YzcBvf9AnMdWfyfYjwg+Dj/MUTyF6YamDVuPgg1fWhVNI7WLvTi
	1H553qWiBe8tYsVe7K7qUaTnFDoFxWZffN50ryChjflvmNUqJPI5QV0FHu3jCVa1
X-Gm-Gg: Acq92OFZ/tFCOOA4Uj7bw0rMldC00f4ZVD9zxlWnu1vzAue4dXrNf1QuZR1KZRoJ7rA
	NT+Tq4OR5vZC20Psb3yWg5NhZgK7Hpk3kDepWqQRVdR7nRBbN6quav9Xg6XhhUjHQK5+eOaHuxJ
	wyx4GiWpJeQeXf2paV9CLmsls7jHJSY7Uw7L0VzWUUylrLrcYg0oYGlkRuslgjoPfR8ort7HR+0
	dlyU71zccu48wSyNsGt046oLf4qoQf9xcEnSf07D1VenEAu7/JbtdCQUBTQMLXQ2QLNnfbtxT3G
	Xwg9Tx5clWxYaatDU/OwcwX9ZE5CL04j0G3Ha1DlhxLjza3r5FImS6bw8v8uXUjpkTOyrzmdNtz
	l23A1z49fuCdUJLM/NDW+/iBpuw7UGxSQV4NfoKaBDugM4miwEuWy6PAAH7wx8WAaAOKSktOuyl
	zaLUhbk964u+KdjEconqgOAPac4p9adxCdUUj7kpyanKthZRwJOmTYDpWuThPVUDWDmklNgAez/
	TGTDcxqK3AZq+flpGs7KKuKSViVjVExtKM/eF4JOTpCiEdHSFME8uz4AvEJJQtT4nW+sxN5ijis
X-Received: by 2002:a05:600c:a009:b0:490:6869:ef13 with SMTP id 5b1f17b1804b1-490c25d4cd3mr32212165e9.14.1780641265895;
        Thu, 04 Jun 2026 23:34:25 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc3e4b5asm132896245e9.13.2026.06.04.23.34.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 23:34:24 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 10/17] bpf: Report Resource Lifetime reference leaks
Date: Fri,  5 Jun 2026 08:34:00 +0200
Message-ID: <20260605063412.974640-11-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260605063412.974640-1-memxor@gmail.com>
References: <20260605063412.974640-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=16831; i=memxor@gmail.com; h=from:subject; bh=Hg8YyXi4DhSHFn65mfvkHQ2MytzVSmYxfIMZjiGqNrw=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIUspt8Rhwd4qrqmdiWnKMzjsboskeE/seGxutW6++u2D/ stlREo6SlkYxLgYZMUUWUr+72MyPlH5O9B2GTfMHFYmkCEMXJwCMBHdKIZ/Rltcov7fzTtuKGy/ c9VK4Xj+zz8vK166fyoz/HQ90wJ+CUaGOcnKil7fvzQdDb3orHYyqfzle9Oqiwu8fNQS2IT8Dk7 lAAA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Augment check_reference_leak() with a Resource Lifetime Safety report when
a reference is still live at exit or throw time. The existing verifier leak
message remains in place; the new report points at the failing instruction
and prints the causal path from the matching acquisition.

Keep release-candidate discovery out of this first report so the initial
change stays focused on lifetime tracking and presentation.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/diagnostics.c | 39 ++++++++++++++++
 kernel/bpf/diagnostics.h |  6 +++
 kernel/bpf/verifier.c    | 98 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 143 insertions(+)

diff --git a/kernel/bpf/diagnostics.c b/kernel/bpf/diagnostics.c
index 0abe1ab19d25..369b7813b5dc 100644
--- a/kernel/bpf/diagnostics.c
+++ b/kernel/bpf/diagnostics.c
@@ -922,6 +922,45 @@ void bpf_diag_report_mem_bounds(struct bpf_verifier_env *env, u32 insn_idx,
 				   "Add or adjust a bounds check that proves offset + access size stays within the object.");
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
+	bpf_diag_report_source(env, insn_idx, '!', "%s", problem);
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
+	bpf_diag_report_source(env, fail_insn, '!',
+			       "owned resource (id=%u) still needs release", ref_id);
+
+	bpf_diag_print_history(env, &opts);
+
+	bpf_diag_report_suggestion(env,
+				   "Release or transfer ownership of the acquired resource on every path before the program exits.");
+}
+
 void bpf_diag_clear_history(struct bpf_verifier_state *state)
 {
 	kfree(state->diag_history);
diff --git a/kernel/bpf/diagnostics.h b/kernel/bpf/diagnostics.h
index 4f7617fdb700..0bc5f3492c47 100644
--- a/kernel/bpf/diagnostics.h
+++ b/kernel/bpf/diagnostics.h
@@ -175,6 +175,12 @@ void bpf_diag_report_mem_bounds(struct bpf_verifier_env *env, u32 insn_idx,
 				enum bpf_diag_mem_bounds_kind kind,
 				int off, int size, u32 mem_size,
 				const struct bpf_reg_state *reg);
+void bpf_diag_report_resource_state(struct bpf_verifier_env *env,
+				    u32 insn_idx, const char *problem,
+				    const char *reason,
+				    const char *suggestion);
+void bpf_diag_report_ref_leak(struct bpf_verifier_env *env, u32 ref_id,
+			      u32 alloc_insn, u32 fail_insn);
 
 void bpf_diag_clear_history(struct bpf_verifier_state *state);
 void bpf_diag_copy_history(struct bpf_verifier_state *dst,
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index e9c121892b7e..1c26614bec2b 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -831,6 +831,11 @@ static int destroy_if_dynptr_stack_slot(struct bpf_verifier_env *env,
 	if (dynptr_type_referenced(state->stack[spi].spilled_ptr.dynptr.type) &&
 	    dynptr_ref_cnt(env, state->stack[spi].spilled_ptr.parent_id) <= 1) {
 		verbose(env, "cannot overwrite referenced dynptr\n");
+		bpf_diag_report_resource_state(env, env->insn_idx,
+					       "referenced dynptr overwrite",
+					       "This stack slot contains a dynptr that owns or protects a referenced resource. Overwriting the last dynptr for that resource "
+					       "would lose the verifier-tracked release path.",
+					       "Release or clone the dynptr so another live dynptr still tracks the referenced resource before overwriting this stack slot.");
 		return -EINVAL;
 	}
 
@@ -1114,9 +1119,18 @@ static int unmark_stack_slot_irq_flag(struct bpf_verifier_env *env, struct bpf_r
 	if (st->irq.kfunc_class != kfunc_class) {
 		const char *flag_kfunc = st->irq.kfunc_class == IRQ_NATIVE_KFUNC ? "native" : "lock";
 		const char *used_kfunc = kfunc_class == IRQ_NATIVE_KFUNC ? "native" : "lock";
+		char reason[256];
 
 		verbose(env, "irq flag acquired by %s kfuncs cannot be restored with %s kfuncs\n",
 			flag_kfunc, used_kfunc);
+		scnprintf(reason, sizeof(reason),
+			  "This IRQ flag was saved by %s IRQ kfuncs, but the restore call belongs to the %s IRQ kfunc family. Save and restore operations must "
+			  "use the same family.",
+			  flag_kfunc, used_kfunc);
+		bpf_diag_report_resource_state(env, env->insn_idx,
+					       "IRQ flag restore mismatch",
+					       reason,
+					       "Restore the flag with the matching IRQ restore kfunc for the save operation that created it.");
 		return -EINVAL;
 	}
 
@@ -1134,6 +1148,11 @@ static int unmark_stack_slot_irq_flag(struct bpf_verifier_env *env, struct bpf_r
 
 		verbose(env, "cannot restore irq state out of order, expected id=%d acquired at insn_idx=%d\n",
 			env->cur_state->active_irq_id, insn_idx);
+		bpf_diag_report_resource_state(env, env->insn_idx,
+					       "IRQ flag restore out of order",
+					       "IRQ-disabled regions must be restored in last-in, first-out order, but this restore does not match the currently active IRQ "
+					       "flag.",
+					       "Restore nested IRQ flags in the reverse order they were saved.");
 		return err;
 	}
 
@@ -7151,11 +7170,19 @@ static int process_spin_lock(struct bpf_verifier_env *env, struct bpf_reg_state
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
@@ -7182,6 +7209,10 @@ static int process_spin_lock(struct bpf_verifier_env *env, struct bpf_reg_state
 
 		if (!cur->active_locks) {
 			verbose(env, "%s_unlock without taking a lock\n", lock_str);
+			bpf_diag_report_resource_state(env, env->insn_idx,
+						       "unlock without lock",
+						       "This unlock operation has no matching active lock on the current path.",
+						       "Take the matching lock before this unlock, or remove the unmatched unlock path.");
 			return -EINVAL;
 		}
 
@@ -7193,15 +7224,27 @@ static int process_spin_lock(struct bpf_verifier_env *env, struct bpf_reg_state
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
 		if (release_lock_state(cur, type, reg->id, ptr,
 				       env->insn_idx)) {
 			verbose(env, "%s_unlock of different lock\n", lock_str);
+			bpf_diag_report_resource_state(env, env->insn_idx,
+						       "unlock of different lock",
+						       "The verifier could not release a lock state matching this unlock operation.",
+						       "Pass the same lock object and lock kind that were used for the matching lock operation.");
 			return -EINVAL;
 		}
 
@@ -7367,6 +7410,10 @@ static int process_dynptr_func(struct bpf_verifier_env *env, struct bpf_reg_stat
 		verbose(env,
 			"%s expected pointer to stack or const struct bpf_dynptr\n",
 			reg_arg_name(env, argno));
+		bpf_diag_report_resource_state(env, insn_idx,
+					       "invalid dynptr argument",
+					       "A dynptr argument must be a pointer to a dynptr stack slot or a verifier-provided const struct bpf_dynptr.",
+					       "Pass the address of a stack dynptr object, or use a const dynptr pointer returned by the verifier-supported path.");
 		return -EINVAL;
 	}
 
@@ -7389,6 +7436,11 @@ static int process_dynptr_func(struct bpf_verifier_env *env, struct bpf_reg_stat
 
 		if (!is_dynptr_reg_valid_uninit(env, reg)) {
 			verbose(env, "Dynptr has to be an uninitialized dynptr\n");
+			bpf_diag_report_resource_state(env, insn_idx,
+						       "dynptr is already initialized",
+						       "This kfunc constructs a dynptr and requires an uninitialized dynptr stack slot, but the selected slot already holds dynptr "
+						       "state.",
+						       "Use a fresh stack dynptr slot, or release/destroy the existing dynptr before reusing the slot.");
 			return -EINVAL;
 		}
 
@@ -7405,12 +7457,21 @@ static int process_dynptr_func(struct bpf_verifier_env *env, struct bpf_reg_stat
 		/* For the reg->type == PTR_TO_STACK case, bpf_dynptr is never const */
 		if (reg->type == CONST_PTR_TO_DYNPTR && (arg_type & OBJ_RELEASE)) {
 			verbose(env, "CONST_PTR_TO_DYNPTR cannot be released\n");
+			bpf_diag_report_resource_state(env, insn_idx,
+						       "const dynptr release",
+						       "This release operation was given a const dynptr. Const dynptr values are verifier-provided views and cannot be released by "
+						       "the program.",
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
 
@@ -7420,6 +7481,10 @@ static int process_dynptr_func(struct bpf_verifier_env *env, struct bpf_reg_stat
 				"Expected a dynptr of type %s as %s\n",
 				dynptr_type_str(arg_to_dynptr_type(arg_type)),
 				reg_arg_name(env, argno));
+			bpf_diag_report_resource_state(env, insn_idx,
+						       "wrong dynptr type",
+						       "The dynptr is initialized, but it was created for a different backing object type than this operation accepts.",
+						       "Use a dynptr constructor that matches this operation, or call an operation that accepts the dynptr's current type.");
 			return -EINVAL;
 		}
 
@@ -7488,6 +7553,10 @@ static int process_iter_arg(struct bpf_verifier_env *env, struct bpf_reg_state *
 	if (reg->type != PTR_TO_STACK) {
 		verbose(env, "%s expected pointer to an iterator on stack\n",
 			reg_arg_name(env, argno));
+		bpf_diag_report_resource_state(env, insn_idx,
+					       "invalid iterator argument",
+					       "Iterator state must live in verifier-tracked stack memory, but this argument is not a stack pointer.",
+					       "Pass the address of a stack iterator object for iterator new, next, and destroy calls.");
 		return -EINVAL;
 	}
 
@@ -7501,6 +7570,10 @@ static int process_iter_arg(struct bpf_verifier_env *env, struct bpf_reg_state *
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
@@ -7511,6 +7584,10 @@ static int process_iter_arg(struct bpf_verifier_env *env, struct bpf_reg_state *
 		if (!is_iter_reg_valid_uninit(env, reg, nr_slots)) {
 			verbose(env, "expected uninitialized iter_%s as %s\n",
 				iter_type_str(meta->btf, btf_id), reg_arg_name(env, argno));
+			bpf_diag_report_resource_state(env, insn_idx,
+						       "iterator is already initialized",
+						       "Iterator creation requires an uninitialized iterator stack object, but this stack range already contains iterator state.",
+						       "Use a fresh iterator stack slot, or destroy the existing iterator before reusing the slot.");
 			return -EINVAL;
 		}
 
@@ -7535,9 +7612,19 @@ static int process_iter_arg(struct bpf_verifier_env *env, struct bpf_reg_state *
 		case -EINVAL:
 			verbose(env, "expected an initialized iter_%s as %s\n",
 				iter_type_str(meta->btf, btf_id), reg_arg_name(env, argno));
+			bpf_diag_report_resource_state(env, insn_idx,
+						       "uninitialized iterator use",
+						       "This iterator operation requires an initialized iterator state object, but the stack range does not contain a live iterator "
+						       "on this path.",
+						       "Call the matching iterator new kfunc on every path before calling next or destroy, and do not destroy the iterator before "
+						       "this use.");
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
@@ -10119,6 +10206,8 @@ static int check_reference_leak(struct bpf_verifier_env *env, bool exception_exi
 			continue;
 		verbose(env, "Unreleased reference id=%d alloc_insn=%d\n",
 			state->refs[i].id, state->refs[i].insn_idx);
+		bpf_diag_report_ref_leak(env, state->refs[i].id,
+					 state->refs[i].insn_idx, env->insn_idx);
 		refs_lingering = true;
 	}
 	return refs_lingering ? -EINVAL : 0;
@@ -11576,6 +11665,11 @@ static int process_irq_flag(struct bpf_verifier_env *env, struct bpf_reg_state *
 		if (!is_irq_flag_reg_valid_uninit(env, reg)) {
 			verbose(env, "expected uninitialized irq flag as %s\n",
 				reg_arg_name(env, argno));
+				bpf_diag_report_resource_state(env, env->insn_idx,
+							       "IRQ flag is already initialized",
+							       "Saving IRQ state requires an uninitialized stack slot for the IRQ flag, but this slot already contains tracked IRQ flag "
+							       "state.",
+							       "Use a fresh stack slot for this save operation, or restore the existing IRQ flag before reusing the slot.");
 			return -EINVAL;
 		}
 
@@ -11592,6 +11686,10 @@ static int process_irq_flag(struct bpf_verifier_env *env, struct bpf_reg_state *
 		if (err) {
 			verbose(env, "expected an initialized irq flag as %s\n",
 				reg_arg_name(env, argno));
+				bpf_diag_report_resource_state(env, env->insn_idx,
+							       "uninitialized IRQ flag restore",
+							       "Restoring IRQ state requires a stack slot that was initialized by a matching IRQ save operation on this path.",
+							       "Pass the same stack slot that was previously initialized by the matching IRQ save kfunc.");
 			return err;
 		}
 
-- 
2.53.0

