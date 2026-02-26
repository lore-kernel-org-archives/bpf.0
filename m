Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD3F644CAD0
	for <bpf@vger.kernel.org>; Thu, 26 Feb 2026 16:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772122539; cv=none; b=THzAIrDo01dbxItoMkI/Jkn/GhEpluS7e/EGRZDzLV45QSX+ujlcdP0waFTrrmQLK7bqsvEZ1RZrjLc9EqfZTAkJhDZuM0eOfme3IxAgv6WxyuQyYM+sqhEAQeho2FtXWXQeDvzZOmz43bInIZpp1SDtTiQwEMM6PrVScea3BEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772122539; c=relaxed/simple;
	bh=NyzI3FGTgMYCOfCt90amK073EF2Kor6STWxI21r8woc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dCV+EML9aKseGjZYSGmmtUE1JF63mb4NQ1a4pIYv7Pbw00+EpxLiPr9w1s+j2RKLOVydBe4K2xO3TAom9iQbmuqyIeJ+4iMAavkdIlTDRsX9P32cFTsXlQ7nkub6JfjoouHk3kMIdfNuiyaXZsbKU5ce9EcwFZQcl4fcjMWHIGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P7D2a1uM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P7D2a1uM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C5C9C19423;
	Thu, 26 Feb 2026 16:15:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772122539;
	bh=NyzI3FGTgMYCOfCt90amK073EF2Kor6STWxI21r8woc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=P7D2a1uMQMLLdrTb4TqmUcS88qYhN1COeOT0aOuFzrMKzImi53vKJXH21wYALXgGM
	 flJGQzqtWEBR6+lf8NrdyhEHo57UTOmjDIT0OFrRhBrky4udgOKgyZmT2U62Tj0Pdr
	 svyI4bnCIeD2M3tQdw8TjKosFHTBxBkZzfagLGej0RbvjYkuOpY8pYuKoFOcfie9Y1
	 D5BVt9+jdbzt761s60r5BrKPtxj4p1AxOa1Xa9mYtS14fXCOF1/9iLxxsHNYMKwi5v
	 yVJ6uuNbQsiNH/DSkwjMTCpytP9hfd6jn7e6Vw5WMtXjJoPXj3p6qRlPXjehv601KB
	 XLE5RjSwe0OtA==
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
Subject: [PATCH bpf v5 5/8] bpf: Add KF_FORBID_FAULT modifier for KF_ACQUIRE kfuncs
Date: Thu, 26 Feb 2026 08:14:54 -0800
Message-ID: <20260226161500.775715-6-puranjay@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260226161500.775715-1-puranjay@kernel.org>
References: <20260226161500.775715-1-puranjay@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With KF_ACQUIRE support for iterators in place, we need a way to tell
the verifier that holding a particular acquired reference forbids
faulting. For example, task_vma's _next holds mmap_lock, so any
operation that might trigger a page fault between _next and _release
must be rejected to avoid deadlocking on mmap_lock re-acquisition.

Note that mmap_lock is a sleeping lock (rw_semaphore), so sleeping
itself is fine while holding it. The actual constraint is about
faulting, not sleeping. The flag is named KF_FORBID_FAULT to reflect
this. The current implementation conservatively blocks all sleepable
operations while the reference is held.

Add a KF_FORBID_FAULT flag (1 << 17) that can be combined with
KF_ACQUIRE. When acquire_reference() is called for such a kfunc, the
reference is tagged with forbid_fault=true and a per-state
forbid_fault_count counter is incremented. When the reference is
released through release_reference_state(), the counter is decremented.

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
 kernel/bpf/verifier.c        | 36 +++++++++++++++++++++++++++++-------
 3 files changed, 32 insertions(+), 7 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index ef8e45a362d9..11102e1b53ef 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -261,6 +261,7 @@ struct bpf_reference_state {
 	 * it matches on unlock.
 	 */
 	void *ptr;
+	bool forbid_fault;	/* ref prevents faulting while held */
 };
 
 struct bpf_retval_range {
@@ -421,6 +422,7 @@ struct bpf_verifier_state {
 	u32 active_lock_id;
 	void *active_lock_ptr;
 	u32 active_rcu_locks;
+	u32 forbid_fault_count;
 
 	bool speculative;
 	bool in_sleepable;
diff --git a/include/linux/btf.h b/include/linux/btf.h
index 48108471c5b1..fec8298692a2 100644
--- a/include/linux/btf.h
+++ b/include/linux/btf.h
@@ -79,6 +79,7 @@
 #define KF_ARENA_ARG1   (1 << 14) /* kfunc takes an arena pointer as its first argument */
 #define KF_ARENA_ARG2   (1 << 15) /* kfunc takes an arena pointer as its second argument */
 #define KF_IMPLICIT_ARGS (1 << 16) /* kfunc has implicit arguments supplied by the verifier */
+#define KF_FORBID_FAULT  (1 << 17) /* acquired reference forbids faulting while held */
 
 /*
  * Tag marking a kernel function as a kfunc. This is meant to minimize the
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 061f93d0c2c2..cb69761332ab 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -202,7 +202,7 @@ struct bpf_verifier_stack_elem {
 
 #define BPF_PRIV_STACK_MIN_SIZE		64
 
-static int acquire_reference(struct bpf_verifier_env *env, int insn_idx);
+static int acquire_reference(struct bpf_verifier_env *env, int insn_idx, bool forbid_fault);
 static int release_reference_nomark(struct bpf_verifier_state *state, int ref_obj_id);
 static int release_reference(struct bpf_verifier_env *env, int ref_obj_id);
 static void invalidate_non_owning_refs(struct bpf_verifier_env *env);
@@ -807,7 +807,7 @@ static int mark_stack_slots_dynptr(struct bpf_verifier_env *env, struct bpf_reg_
 		if (clone_ref_obj_id)
 			id = clone_ref_obj_id;
 		else
-			id = acquire_reference(env, insn_idx);
+			id = acquire_reference(env, insn_idx, false);
 
 		if (id < 0)
 			return id;
@@ -1055,7 +1055,7 @@ static int mark_stack_slots_iter(struct bpf_verifier_env *env,
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
+	dst->forbid_fault_count = src->forbid_fault_count;
 	return 0;
 }
 
@@ -1549,7 +1550,7 @@ static struct bpf_reference_state *acquire_reference_state(struct bpf_verifier_e
 	return &state->refs[new_ofs];
 }
 
-static int acquire_reference(struct bpf_verifier_env *env, int insn_idx)
+static int acquire_reference(struct bpf_verifier_env *env, int insn_idx, bool forbid_fault)
 {
 	struct bpf_reference_state *s;
 
@@ -1558,6 +1559,9 @@ static int acquire_reference(struct bpf_verifier_env *env, int insn_idx)
 		return -ENOMEM;
 	s->type = REF_TYPE_PTR;
 	s->id = ++env->id_gen;
+	s->forbid_fault = forbid_fault;
+	if (forbid_fault)
+		env->cur_state->forbid_fault_count++;
 	return s->id;
 }
 
@@ -1600,6 +1604,9 @@ static void release_reference_state(struct bpf_verifier_state *state, int idx)
 	int last_idx;
 	size_t rem;
 
+	if (state->refs[idx].forbid_fault)
+		state->forbid_fault_count--;
+
 	/* IRQ state requires the relative ordering of elements remaining the
 	 * same, since it relies on the refs array to behave as a stack, so that
 	 * it can detect out-of-order IRQ restore. Hence use memmove to shift
@@ -11589,6 +11596,7 @@ static inline bool in_sleepable_context(struct bpf_verifier_env *env)
 	       !env->cur_state->active_preempt_locks &&
 	       !env->cur_state->active_locks &&
 	       !env->cur_state->active_irq_id &&
+	       !env->cur_state->forbid_fault_count &&
 	       in_sleepable(env);
 }
 
@@ -11602,6 +11610,8 @@ static const char *non_sleepable_context_description(struct bpf_verifier_env *en
 		return "IRQ-disabled region";
 	if (env->cur_state->active_locks)
 		return "lock region";
+	if (env->cur_state->forbid_fault_count)
+		return "nofault region";
 	return "non-sleepable prog";
 }
 
@@ -12047,7 +12057,7 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 		/* For release_reference() */
 		regs[BPF_REG_0].ref_obj_id = meta.ref_obj_id;
 	} else if (is_acquire_function(func_id, meta.map.ptr)) {
-		int id = acquire_reference(env, insn_idx);
+		int id = acquire_reference(env, insn_idx, false);
 
 		if (id < 0)
 			return id;
@@ -12152,6 +12162,11 @@ static bool is_kfunc_release(struct bpf_kfunc_call_arg_meta *meta)
 	return meta->kfunc_flags & KF_RELEASE;
 }
 
+static bool is_kfunc_forbid_fault(struct bpf_kfunc_call_arg_meta *meta)
+{
+	return meta->kfunc_flags & KF_FORBID_FAULT;
+}
+
 static bool is_kfunc_sleepable(struct bpf_kfunc_call_arg_meta *meta)
 {
 	return meta->kfunc_flags & KF_SLEEPABLE;
@@ -14403,6 +14418,7 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 		}
 		mark_btf_func_reg_size(env, BPF_REG_0, sizeof(void *));
 		if (is_kfunc_acquire(&meta)) {
+			bool forbid_fault = is_kfunc_forbid_fault(&meta);
 			int id;
 
 			/*
@@ -14417,7 +14433,7 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 					return err;
 			}
 
-			id = acquire_reference(env, insn_idx);
+			id = acquire_reference(env, insn_idx, forbid_fault);
 
 			if (id < 0)
 				return id;
@@ -20091,6 +20107,9 @@ static bool refsafe(struct bpf_verifier_state *old, struct bpf_verifier_state *c
 	if (old->active_rcu_locks != cur->active_rcu_locks)
 		return false;
 
+	if (old->forbid_fault_count != cur->forbid_fault_count)
+		return false;
+
 	if (!check_ids(old->active_irq_id, cur->active_irq_id, idmap))
 		return false;
 
@@ -20104,6 +20123,9 @@ static bool refsafe(struct bpf_verifier_state *old, struct bpf_verifier_state *c
 			return false;
 		switch (old->refs[i].type) {
 		case REF_TYPE_PTR:
+			if (old->refs[i].forbid_fault != cur->refs[i].forbid_fault)
+				return false;
+			break;
 		case REF_TYPE_IRQ:
 			break;
 		case REF_TYPE_LOCK:
@@ -24629,7 +24651,7 @@ static int do_check_common(struct bpf_verifier_env *env, int subprog)
 	if (!subprog && env->prog->type == BPF_PROG_TYPE_STRUCT_OPS) {
 		for (i = 0; i < aux->ctx_arg_info_size; i++)
 			aux->ctx_arg_info[i].ref_obj_id = aux->ctx_arg_info[i].refcounted ?
-							  acquire_reference(env, 0) : 0;
+							  acquire_reference(env, 0, false) : 0;
 	}
 
 	ret = do_check(env);
-- 
2.47.3

