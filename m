Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22E84337BB3
	for <bpf@vger.kernel.org>; Mon, 23 Feb 2026 17:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771868923; cv=none; b=VSCqLvFEVYkRwQ9sZgqQQbVxwV1KBo+LO3j5G7t/hX6A6NVRkmxP9eyN/15b163uM50eYq8Ok04qQ/hUqAjtW6+w0WjMIldaz8whp+G3fwsxtYohRnkRJQNF8lZvallRRRwNYSQnswa3SYwpgUHpeHzhs7W3yGrTSh7d51hzZgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771868923; c=relaxed/simple;
	bh=RMPn4syhWP5S7SVYcD+PW3hlDa4r4EHbZGbq9JamIW0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SpNrjJ/pQH3KR2Z9BhE5z+sjc6PaLeuwz2tGx35L4tggstvzbEBrWn5MTYCRqej1OPKNViwkdQo4U8+Pm4yttVCaGIcXITzhP6GsdeQ6nzRmjWVgO4FCa1y8z4AOZb6MkZCk06ePW3vHErbVqkKv83Yrx6GoLFiQ09ugsyJurYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pSBqaH/c; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pSBqaH/c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F9F1C116C6;
	Mon, 23 Feb 2026 17:48:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771868922;
	bh=RMPn4syhWP5S7SVYcD+PW3hlDa4r4EHbZGbq9JamIW0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pSBqaH/cjtRzjhfTZDjQCnA/lJLr0h6UXRdh2D+6D+TwnyAdAnTDHn5SGH4CIJxIE
	 ZQSaFNgrG6xSDL8iDSddG2s/GK21vVGL48TJ3CMOLjTTIRruSxdv+vwoAIlGBn4Q/Z
	 Lg3bHWxf3K2y0dqGhdW5V/U5jIKHL3qQ4zj+HDPRRpqFnb8MFUr4KaHbIAiWU7yqNF
	 IuwToiXwR6UP3bqrkSfQVvmEz4k+CHFkve/RltGSN+SOigbhDGlZ6fXIpF8oI70DsK
	 q/E8US95f84wKBQ9jyIeJ7al80LOlyzm0jV5YZSr+te71jsI7sjECZRu5QOMM2Cjj0
	 qp96PAiRtPQWw==
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
Subject: [PATCH bpf-next v3 3/6] bpf: Add KF_FORBID_SLEEP modifier for KF_ACQUIRE kfuncs
Date: Mon, 23 Feb 2026 09:46:53 -0800
Message-ID: <20260223174659.2749964-4-puranjay@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260223174659.2749964-1-puranjay@kernel.org>
References: <20260223174659.2749964-1-puranjay@kernel.org>
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
 kernel/bpf/btf.c             |  3 +++
 kernel/bpf/verifier.c        | 46 ++++++++++++++++++++++++++++--------
 4 files changed, 42 insertions(+), 10 deletions(-)

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
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 4872d2a6c42d..65327d2f19c1 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -8644,6 +8644,9 @@ static int btf_check_kfunc_protos(struct btf *btf, u32 func_id, u32 func_flags)
 			return err;
 	}
 
+	if ((func_flags & KF_FORBID_SLEEP) && !(func_flags & KF_ACQUIRE))
+		return -EINVAL;
+
 	return 0;
 }
 
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index c2a63f8c8984..a90c3d1b2d72 100644
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
@@ -1052,7 +1053,7 @@ static int mark_stack_slots_iter(struct bpf_verifier_env *env,
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
@@ -10845,9 +10853,7 @@ static int check_func_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 			return -EINVAL;
 		}
 
-		if (env->subprog_info[subprog].might_sleep &&
-		    (env->cur_state->active_rcu_locks || env->cur_state->active_preempt_locks ||
-		     env->cur_state->active_irq_id || !in_sleepable(env))) {
+		if (env->subprog_info[subprog].might_sleep && !in_sleepable_context(env)) {
 			verbose(env, "global functions that may sleep are not allowed in non-sleepable context,\n"
 				     "i.e., in a RCU/IRQ/preempt-disabled section, or in\n"
 				     "a non-sleepable BPF program context\n");
@@ -11571,6 +11577,7 @@ static inline bool in_sleepable_context(struct bpf_verifier_env *env)
 	       !env->cur_state->active_preempt_locks &&
 	       !env->cur_state->active_locks &&
 	       !env->cur_state->active_irq_id &&
+	       !env->cur_state->forbid_sleep_count &&
 	       in_sleepable(env);
 }
 
@@ -11584,6 +11591,8 @@ static const char *non_sleepable_context_description(struct bpf_verifier_env *en
 		return "IRQ-disabled region";
 	if (env->cur_state->active_locks)
 		return "lock region";
+	if (env->cur_state->forbid_sleep_count)
+		return "nosleep region";
 	return "non-sleepable context";
 }
 
@@ -12035,7 +12044,7 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 		/* For release_reference() */
 		regs[BPF_REG_0].ref_obj_id = meta.ref_obj_id;
 	} else if (is_acquire_function(func_id, meta.map.ptr)) {
-		int id = acquire_reference(env, insn_idx);
+		int id = acquire_reference(env, insn_idx, false);
 
 		if (id < 0)
 			return id;
@@ -12140,6 +12149,11 @@ static bool is_kfunc_release(struct bpf_kfunc_call_arg_meta *meta)
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
@@ -14214,6 +14228,11 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 		return -EACCES;
 	}
 
+	if (sleepable && env->cur_state->forbid_sleep_count) {
+		verbose(env, "sleepable kfunc %s in nosleep region\n", func_name);
+		return -EACCES;
+	}
+
 	/* In case of release function, we get register number of refcounted
 	 * PTR_TO_BTF_ID in bpf_kfunc_arg_meta, do the release now.
 	 */
@@ -14405,7 +14424,8 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 				return err;
 		}
 		if (is_kfunc_acquire(&meta)) {
-			int id = acquire_reference(env, insn_idx);
+			bool forbid_sleep = is_kfunc_forbid_sleep(&meta);
+			int id = acquire_reference(env, insn_idx, forbid_sleep);
 
 			if (id < 0)
 				return id;
@@ -20049,6 +20069,9 @@ static bool refsafe(struct bpf_verifier_state *old, struct bpf_verifier_state *c
 	if (old->active_rcu_locks != cur->active_rcu_locks)
 		return false;
 
+	if (old->forbid_sleep_count != cur->forbid_sleep_count)
+		return false;
+
 	if (!check_ids(old->active_irq_id, cur->active_irq_id, idmap))
 		return false;
 
@@ -20062,6 +20085,9 @@ static bool refsafe(struct bpf_verifier_state *old, struct bpf_verifier_state *c
 			return false;
 		switch (old->refs[i].type) {
 		case REF_TYPE_PTR:
+			if (old->refs[i].forbid_sleep != cur->refs[i].forbid_sleep)
+				return false;
+			break;
 		case REF_TYPE_IRQ:
 			break;
 		case REF_TYPE_LOCK:
@@ -24584,7 +24610,7 @@ static int do_check_common(struct bpf_verifier_env *env, int subprog)
 	if (!subprog && env->prog->type == BPF_PROG_TYPE_STRUCT_OPS) {
 		for (i = 0; i < aux->ctx_arg_info_size; i++)
 			aux->ctx_arg_info[i].ref_obj_id = aux->ctx_arg_info[i].refcounted ?
-							  acquire_reference(env, 0) : 0;
+							  acquire_reference(env, 0, false) : 0;
 	}
 
 	ret = do_check(env);
-- 
2.47.3

