Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D62D2DC77F
	for <bpf@vger.kernel.org>; Wed, 18 Feb 2026 18:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771439171; cv=none; b=TIM1lV+N9aLGDyytJ6w3VCPIc1M5vY15IsOmabyYbIUu8v8XbbaD+JXdGx5f9FFhm1oQ1K+Fj772eHjDj9TQFio3AC/7ALZbxPRqpoz9N7t69grL85GaPB57pMMGAvCS9Isx/slFmvy9BIC4J12F2p0tKbXuCqeybJz7V8Sltaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771439171; c=relaxed/simple;
	bh=zo3aZ3z8psFKXqQvI60GuKC41XTp9lrz2Wwfg9wfC9c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vCEeGkFM/DpSmUqt/OSBO20HW8bV6d4cXG6shKKrdvAiJlFFvfd5dUlJv7QAmobvzWAUlrBVYLqzcMfEmaDWvNNcNqPxyJm+cGS3Ir5X0laKh78FqEDc+swwQw9D0Qa6nxBGMVDiF2DGVBPXBj+dMNkhYciwwd+pYOv/zZQznRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CVb6bVx8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CVb6bVx8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68219C116D0;
	Wed, 18 Feb 2026 18:26:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771439170;
	bh=zo3aZ3z8psFKXqQvI60GuKC41XTp9lrz2Wwfg9wfC9c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CVb6bVx8QZXItEl2hSpYqoOyg461zxPaMSghhdpT6cIDmLFaRf1w73pBLyNuZBOol
	 YY8xuQXpa7oylT1YsIJ+ZsKQQ3j8rE+FyPS4hhmMraVTnLGhlkY+dHVbRfjOkB8/AR
	 JgmFapgxPn+abj9A3OoyJXHzc8R75x4SW7rg6iOaXUxIEagEs6RFOjZ9hPY18GYCyN
	 9NWTXeeytUhU7yjZ8F+dOGsZF6OLqGLUG31adWq4Mk44E7zdnmshlvMkY77jp7Wzg5
	 N4Gn+Cqk1CAc1lvUNSNB+QlbXWMArfQ/+Wfke0r61b28wnf4rl5EowVw0zNM/LUi/h
	 y0bSGqpc5o7Rg==
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
Subject: [PATCH bpf-next 2/5] bpf: Add KF_FORBID_SLEEP modifier for KF_ACQUIRE kfuncs
Date: Wed, 18 Feb 2026 10:25:47 -0800
Message-ID: <20260218182555.1501495-3-puranjay@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260218182555.1501495-1-puranjay@kernel.org>
References: <20260218182555.1501495-1-puranjay@kernel.org>
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
 kernel/bpf/verifier.c        | 54 ++++++++++++++++++++++++++++++------
 3 files changed, 49 insertions(+), 8 deletions(-)

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
index aa48180b6073..fd843dc93616 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -202,7 +202,7 @@ struct bpf_verifier_stack_elem {
 
 #define BPF_PRIV_STACK_MIN_SIZE		64
 
-static int acquire_reference(struct bpf_verifier_env *env, int insn_idx);
+static int acquire_reference(struct bpf_verifier_env *env, int insn_idx, bool forbid_sleep);
 static int release_reference_nomark(struct bpf_verifier_state *state, int ref_obj_id);
 static int release_reference(struct bpf_verifier_env *env, int ref_obj_id);
 static void invalidate_non_owning_refs(struct bpf_verifier_env *env);
@@ -810,7 +810,7 @@ static int mark_stack_slots_dynptr(struct bpf_verifier_env *env, struct bpf_reg_
 		if (clone_ref_obj_id)
 			id = clone_ref_obj_id;
 		else
-			id = acquire_reference(env, insn_idx);
+			id = acquire_reference(env, insn_idx, false);
 
 		if (id < 0)
 			return id;
@@ -1056,7 +1056,7 @@ static int mark_stack_slots_iter(struct bpf_verifier_env *env,
 	if (spi < 0)
 		return spi;
 
-	id = acquire_reference(env, insn_idx);
+	id = acquire_reference(env, insn_idx, false);
 	if (id < 0)
 		return id;
 
@@ -1476,6 +1476,7 @@ static int copy_reference_state(struct bpf_verifier_state *dst, const struct bpf
 	dst->active_irq_id = src->active_irq_id;
 	dst->active_lock_id = src->active_lock_id;
 	dst->active_lock_ptr = src->active_lock_ptr;
+	dst->forbid_sleep_count = src->forbid_sleep_count;
 	return 0;
 }
 
@@ -1549,7 +1550,7 @@ static struct bpf_reference_state *acquire_reference_state(struct bpf_verifier_e
 	return &state->refs[new_ofs];
 }
 
-static int acquire_reference(struct bpf_verifier_env *env, int insn_idx)
+static int acquire_reference(struct bpf_verifier_env *env, int insn_idx, bool forbid_sleep)
 {
 	struct bpf_reference_state *s;
 
@@ -1558,6 +1559,9 @@ static int acquire_reference(struct bpf_verifier_env *env, int insn_idx)
 		return -ENOMEM;
 	s->type = REF_TYPE_PTR;
 	s->id = ++env->id_gen;
+	s->forbid_sleep = forbid_sleep;
+	if (forbid_sleep)
+		env->cur_state->forbid_sleep_count++;
 	return s->id;
 }
 
@@ -10510,6 +10514,8 @@ static int release_reference_nomark(struct bpf_verifier_state *state, int ref_ob
 		if (state->refs[i].type != REF_TYPE_PTR)
 			continue;
 		if (state->refs[i].id == ref_obj_id) {
+			if (state->refs[i].forbid_sleep)
+				state->forbid_sleep_count--;
 			release_reference_state(state, i);
 			return 0;
 		}
@@ -10847,7 +10853,8 @@ static int check_func_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 
 		if (env->subprog_info[subprog].might_sleep &&
 		    (env->cur_state->active_rcu_locks || env->cur_state->active_preempt_locks ||
-		     env->cur_state->active_irq_id || !in_sleepable(env))) {
+		     env->cur_state->active_irq_id || env->cur_state->forbid_sleep_count ||
+		     !in_sleepable(env))) {
 			verbose(env, "global functions that may sleep are not allowed in non-sleepable context,\n"
 				     "i.e., in a RCU/IRQ/preempt-disabled section, or in\n"
 				     "a non-sleepable BPF program context\n");
@@ -11435,6 +11442,11 @@ static int check_resource_leak(struct bpf_verifier_env *env, bool exception_exit
 		return -EINVAL;
 	}
 
+	if (check_lock && env->cur_state->forbid_sleep_count) {
+		verbose(env, "%s cannot be used inside nosleep region\n", prefix);
+		return -EINVAL;
+	}
+
 	if (check_lock && env->cur_state->active_preempt_locks) {
 		verbose(env, "%s cannot be used inside bpf_preempt_disable-ed region\n", prefix);
 		return -EINVAL;
@@ -11571,6 +11583,7 @@ static inline bool in_sleepable_context(struct bpf_verifier_env *env)
 	       !env->cur_state->active_preempt_locks &&
 	       !env->cur_state->active_locks &&
 	       !env->cur_state->active_irq_id &&
+	       !env->cur_state->forbid_sleep_count &&
 	       in_sleepable(env);
 }
 
@@ -11658,6 +11671,14 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 		}
 	}
 
+	if (env->cur_state->forbid_sleep_count) {
+		if (fn->might_sleep) {
+			verbose(env, "sleepable helper %s#%d in nosleep region\n",
+				func_id_name(func_id), func_id);
+			return -EINVAL;
+		}
+	}
+
 	/* Track non-sleepable context for helpers. */
 	if (!in_sleepable_context(env))
 		env->insn_aux_data[insn_idx].non_sleepable = true;
@@ -12039,7 +12060,7 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 		/* For release_reference() */
 		regs[BPF_REG_0].ref_obj_id = meta.ref_obj_id;
 	} else if (is_acquire_function(func_id, meta.map.ptr)) {
-		int id = acquire_reference(env, insn_idx);
+		int id = acquire_reference(env, insn_idx, false);
 
 		if (id < 0)
 			return id;
@@ -12144,6 +12165,11 @@ static bool is_kfunc_release(struct bpf_kfunc_call_arg_meta *meta)
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
@@ -14113,6 +14139,11 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 		return -EACCES;
 	}
 
+	if (sleepable && env->cur_state->forbid_sleep_count) {
+		verbose(env, "sleepable kfunc %s in nosleep region\n", func_name);
+		return -EACCES;
+	}
+
 	/* Track non-sleepable context for kfuncs, same as for helpers. */
 	if (!in_sleepable_context(env))
 		insn_aux->non_sleepable = true;
@@ -14413,7 +14444,8 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 				return err;
 		}
 		if (is_kfunc_acquire(&meta)) {
-			int id = acquire_reference(env, insn_idx);
+			bool forbid_sleep = is_kfunc_forbid_sleep(&meta);
+			int id = acquire_reference(env, insn_idx, forbid_sleep);
 
 			if (id < 0)
 				return id;
@@ -20054,6 +20086,9 @@ static bool refsafe(struct bpf_verifier_state *old, struct bpf_verifier_state *c
 	if (old->active_rcu_locks != cur->active_rcu_locks)
 		return false;
 
+	if (old->forbid_sleep_count != cur->forbid_sleep_count)
+		return false;
+
 	if (!check_ids(old->active_irq_id, cur->active_irq_id, idmap))
 		return false;
 
@@ -20067,6 +20102,9 @@ static bool refsafe(struct bpf_verifier_state *old, struct bpf_verifier_state *c
 			return false;
 		switch (old->refs[i].type) {
 		case REF_TYPE_PTR:
+			if (old->refs[i].forbid_sleep != cur->refs[i].forbid_sleep)
+				return false;
+			break;
 		case REF_TYPE_IRQ:
 			break;
 		case REF_TYPE_LOCK:
@@ -24584,7 +24622,7 @@ static int do_check_common(struct bpf_verifier_env *env, int subprog)
 	if (!subprog && env->prog->type == BPF_PROG_TYPE_STRUCT_OPS) {
 		for (i = 0; i < aux->ctx_arg_info_size; i++)
 			aux->ctx_arg_info[i].ref_obj_id = aux->ctx_arg_info[i].refcounted ?
-							  acquire_reference(env, 0) : 0;
+							  acquire_reference(env, 0, false) : 0;
 	}
 
 	ret = do_check(env);
-- 
2.47.3

