Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DB6133D508
	for <bpf@vger.kernel.org>; Tue, 24 Feb 2026 21:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771968376; cv=none; b=lMRPhJSTijkcxHJKRqR0MmPXGanZy9kaTol+j3DDNRWLvCedJ4obN5cAetqgNyZxTtgz2/KbC72vX+hmvAQsHKiB7mqgdrW30SPdTKoxu6AA0jpXYNf+G6X76yOiqfpLNzk28qEv1a1dvOFAvoWicWqf7NsgTElw0nmZY2U5eOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771968376; c=relaxed/simple;
	bh=jMdgFJI0UVUvJ9lvoOYfbJB3/DuGpWmvQ/YGw6H13P4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XwZoFhrTAFV1fipj0lTxXXUhFjQxy7aWF7cXmM59PClmBJgAVHF6SLe6ovCrdiQCnbAcFprblU86lueKpfZNoTlrUk+1m9zuG6FMunD9zHzGrgGanQ9hkHGz5aasPZVLlbgfyqAUL6RcLoPvN0PLvnC13BSONsalFhP5Gl5Vlgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dFPGxhmG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dFPGxhmG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DCE0C116D0;
	Tue, 24 Feb 2026 21:26:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771968376;
	bh=jMdgFJI0UVUvJ9lvoOYfbJB3/DuGpWmvQ/YGw6H13P4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dFPGxhmG0p22sbpNunITVaStADonNROYMySk8/xYuOt+bJJnszf0EnfzBkKzPGs3g
	 7VF3Y2EAGkNz2+KIFlHh3JWeJ33ZZoqhQlb7bJQZ3r1iP2UbsIk0sip6G/uqf6zpdC
	 wk/m3JNaKzrcPqgIR14QIKaqDsmTji74ek74byWU7i8imyYGssLYKeRFjGXF29v+Fj
	 uzJhV3ULpS7mpYol3boab4MnWZiMR7lwAm8k46cOgZMdk1lucxwHvze9gYEeUVk3gd
	 jAgE8hPRhSftF5yy8NN3Zt6iR2aLn0USjcowdK0wfvgTVxUiaFJgA2bkgynaWqRwr+
	 sN3HPyT2yvRsQ==
From: Puranjay Mohan <puranjay@kernel.org>
To: bpf@vger.kernel.org
Cc: Puranjay Mohan <puranjay@kernel.org>,
	Puranjay Mohan <puranjay12@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>,
	kernel-team@meta.com
Subject: [PATCH bpf-next v4 4/7] bpf: Add KF_FORBID_SLEEP modifier for KF_ACQUIRE kfuncs
Date: Tue, 24 Feb 2026 13:25:26 -0800
Message-ID: <20260224212535.1165151-5-puranjay@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260224212535.1165151-1-puranjay@kernel.org>
References: <20260224212535.1165151-1-puranjay@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With KF_ACQUIRE support for iterators in place, we need a way to tell
the verifier that holding a particular acquired reference forbids
sleeping. For example, task_vma's _next holds mmap_lock, so sleeping
between _next and _release must be rejected.

Add a KF_FORBID_SLEEP flag (1 << 17) that can be combined with
KF_ACQUIRE. When acquire_reference() is called for such a kfunc, the
reference is tagged with forbid_sleep=true and a per-state
forbid_sleep_count counter is incremented. When the reference is
released through release_reference_nomark(), the counter is decremented
in the same loop that already scans the refs array.

The counter is checked wherever the verifier decides if sleeping is
allowed.

This is generic and works for both iterator and non-iterator kfuncs.
For iterators, the auto-release and explicit _release from the previous
commit handle the counter decrement automatically via
release_reference().

Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
---
 include/linux/bpf_verifier.h |  2 ++
 include/linux/btf.h          |  1 +
 kernel/bpf/verifier.c        | 41 +++++++++++++++++++++++++++---------
 3 files changed, 34 insertions(+), 10 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index c1e30096ea7b..39904401df3d 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -260,6 +260,7 @@ struct bpf_reference_state {
 	 * it matches on unlock.
 	 */
 	void *ptr;
+	bool forbid_sleep;	/* ref prevents sleeping while held */
 };
 
 struct bpf_retval_range {
@@ -420,6 +421,7 @@ struct bpf_verifier_state {
 	u32 active_lock_id;
 	void *active_lock_ptr;
 	u32 active_rcu_locks;
+	u32 forbid_sleep_count;
 
 	bool speculative;
 	bool in_sleepable;
diff --git a/include/linux/btf.h b/include/linux/btf.h
index 48108471c5b1..c326c5ba49cb 100644
--- a/include/linux/btf.h
+++ b/include/linux/btf.h
@@ -79,6 +79,7 @@
 #define KF_ARENA_ARG1   (1 << 14) /* kfunc takes an arena pointer as its first argument */
 #define KF_ARENA_ARG2   (1 << 15) /* kfunc takes an arena pointer as its second argument */
 #define KF_IMPLICIT_ARGS (1 << 16) /* kfunc has implicit arguments supplied by the verifier */
+#define KF_FORBID_SLEEP  (1 << 17) /* acquired reference forbids sleeping while held */
 
 /*
  * Tag marking a kernel function as a kfunc. This is meant to minimize the
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index d54a04871c44..3aa638b1163c 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -202,7 +202,7 @@ struct bpf_verifier_stack_elem {
 
 #define BPF_PRIV_STACK_MIN_SIZE		64
 
-static int acquire_reference(struct bpf_verifier_env *env, int insn_idx);
+static int acquire_reference(struct bpf_verifier_env *env, int insn_idx, bool forbid_sleep);
 static int release_reference_nomark(struct bpf_verifier_state *state, int ref_obj_id);
 static int release_reference(struct bpf_verifier_env *env, int ref_obj_id);
 static void invalidate_non_owning_refs(struct bpf_verifier_env *env);
@@ -210,6 +210,7 @@ static bool in_rbtree_lock_required_cb(struct bpf_verifier_env *env);
 static int ref_set_non_owning(struct bpf_verifier_env *env,
 			      struct bpf_reg_state *reg);
 static bool is_trusted_reg(const struct bpf_reg_state *reg);
+static inline bool in_sleepable_context(struct bpf_verifier_env *env);
 
 static bool bpf_map_ptr_poisoned(const struct bpf_insn_aux_data *aux)
 {
@@ -805,7 +806,7 @@ static int mark_stack_slots_dynptr(struct bpf_verifier_env *env, struct bpf_reg_
 		if (clone_ref_obj_id)
 			id = clone_ref_obj_id;
 		else
-			id = acquire_reference(env, insn_idx);
+			id = acquire_reference(env, insn_idx, false);
 
 		if (id < 0)
 			return id;
@@ -1053,7 +1054,7 @@ static int mark_stack_slots_iter(struct bpf_verifier_env *env,
 	if (spi < 0)
 		return spi;
 
-	id = acquire_reference(env, insn_idx);
+	id = acquire_reference(env, insn_idx, false);
 	if (id < 0)
 		return id;
 
@@ -1474,6 +1475,7 @@ static int copy_reference_state(struct bpf_verifier_state *dst, const struct bpf
 	dst->active_irq_id = src->active_irq_id;
 	dst->active_lock_id = src->active_lock_id;
 	dst->active_lock_ptr = src->active_lock_ptr;
+	dst->forbid_sleep_count = src->forbid_sleep_count;
 	return 0;
 }
 
@@ -1547,7 +1549,7 @@ static struct bpf_reference_state *acquire_reference_state(struct bpf_verifier_e
 	return &state->refs[new_ofs];
 }
 
-static int acquire_reference(struct bpf_verifier_env *env, int insn_idx)
+static int acquire_reference(struct bpf_verifier_env *env, int insn_idx, bool forbid_sleep)
 {
 	struct bpf_reference_state *s;
 
@@ -1556,6 +1558,9 @@ static int acquire_reference(struct bpf_verifier_env *env, int insn_idx)
 		return -ENOMEM;
 	s->type = REF_TYPE_PTR;
 	s->id = ++env->id_gen;
+	s->forbid_sleep = forbid_sleep;
+	if (forbid_sleep)
+		env->cur_state->forbid_sleep_count++;
 	return s->id;
 }
 
@@ -1598,6 +1603,9 @@ static void release_reference_state(struct bpf_verifier_state *state, int idx)
 	int last_idx;
 	size_t rem;
 
+	if (state->refs[idx].forbid_sleep)
+		state->forbid_sleep_count--;
+
 	/* IRQ state requires the relative ordering of elements remaining the
 	 * same, since it relies on the refs array to behave as a stack, so that
 	 * it can detect out-of-order IRQ restore. Hence use memmove to shift
@@ -10852,9 +10860,7 @@ static int check_func_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 			return -EINVAL;
 		}
 
-		if (env->subprog_info[subprog].might_sleep &&
-		    (env->cur_state->active_rcu_locks || env->cur_state->active_preempt_locks ||
-		     env->cur_state->active_irq_id || !in_sleepable(env))) {
+		if (env->subprog_info[subprog].might_sleep && !in_sleepable_context(env)) {
 			verbose(env, "global functions that may sleep are not allowed in non-sleepable context,\n"
 				     "i.e., in a RCU/IRQ/preempt-disabled section, or in\n"
 				     "a non-sleepable BPF program context\n");
@@ -11578,6 +11584,7 @@ static inline bool in_sleepable_context(struct bpf_verifier_env *env)
 	       !env->cur_state->active_preempt_locks &&
 	       !env->cur_state->active_locks &&
 	       !env->cur_state->active_irq_id &&
+	       !env->cur_state->forbid_sleep_count &&
 	       in_sleepable(env);
 }
 
@@ -11591,6 +11598,8 @@ static const char *non_sleepable_context_description(struct bpf_verifier_env *en
 		return "IRQ-disabled region";
 	if (env->cur_state->active_locks)
 		return "lock region";
+	if (env->cur_state->forbid_sleep_count)
+		return "nosleep region";
 	return "non-sleepable context";
 }
 
@@ -12042,7 +12051,7 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 		/* For release_reference() */
 		regs[BPF_REG_0].ref_obj_id = meta.ref_obj_id;
 	} else if (is_acquire_function(func_id, meta.map.ptr)) {
-		int id = acquire_reference(env, insn_idx);
+		int id = acquire_reference(env, insn_idx, false);
 
 		if (id < 0)
 			return id;
@@ -12147,6 +12156,11 @@ static bool is_kfunc_release(struct bpf_kfunc_call_arg_meta *meta)
 	return meta->kfunc_flags & KF_RELEASE;
 }
 
+static bool is_kfunc_forbid_sleep(struct bpf_kfunc_call_arg_meta *meta)
+{
+	return meta->kfunc_flags & KF_FORBID_SLEEP;
+}
+
 static bool is_kfunc_sleepable(struct bpf_kfunc_call_arg_meta *meta)
 {
 	return meta->kfunc_flags & KF_SLEEPABLE;
@@ -14395,6 +14409,7 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 		}
 		mark_btf_func_reg_size(env, BPF_REG_0, sizeof(void *));
 		if (is_kfunc_acquire(&meta)) {
+			bool forbid_sleep = is_kfunc_forbid_sleep(&meta);
 			int id;
 
 			/*
@@ -14409,7 +14424,7 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 					return err;
 			}
 
-			id = acquire_reference(env, insn_idx);
+			id = acquire_reference(env, insn_idx, forbid_sleep);
 
 			if (id < 0)
 				return id;
@@ -20053,6 +20068,9 @@ static bool refsafe(struct bpf_verifier_state *old, struct bpf_verifier_state *c
 	if (old->active_rcu_locks != cur->active_rcu_locks)
 		return false;
 
+	if (old->forbid_sleep_count != cur->forbid_sleep_count)
+		return false;
+
 	if (!check_ids(old->active_irq_id, cur->active_irq_id, idmap))
 		return false;
 
@@ -20066,6 +20084,9 @@ static bool refsafe(struct bpf_verifier_state *old, struct bpf_verifier_state *c
 			return false;
 		switch (old->refs[i].type) {
 		case REF_TYPE_PTR:
+			if (old->refs[i].forbid_sleep != cur->refs[i].forbid_sleep)
+				return false;
+			break;
 		case REF_TYPE_IRQ:
 			break;
 		case REF_TYPE_LOCK:
@@ -24589,7 +24610,7 @@ static int do_check_common(struct bpf_verifier_env *env, int subprog)
 	if (!subprog && env->prog->type == BPF_PROG_TYPE_STRUCT_OPS) {
 		for (i = 0; i < aux->ctx_arg_info_size; i++)
 			aux->ctx_arg_info[i].ref_obj_id = aux->ctx_arg_info[i].refcounted ?
-							  acquire_reference(env, 0) : 0;
+							  acquire_reference(env, 0, false) : 0;
 	}
 
 	ret = do_check(env);
-- 
2.47.3

