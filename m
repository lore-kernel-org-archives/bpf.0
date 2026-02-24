Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7089C33ADA9
	for <bpf@vger.kernel.org>; Tue, 24 Feb 2026 21:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771968363; cv=none; b=rEDGZsLVZmmCz2QZF37wiWId7enIqyD8YKy+EQELn2s5DLGj1LK8+B2F+oR9BDOLpDjBEujelxx2p59V9rU+9BXkdl5oSa/qN6dibK6B+S5XlbNnav2PcKOBMYZe+zUiYZaTYSHFnl/C4EMePwyLUaBMuh+43Y/P4oVoEQMBfsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771968363; c=relaxed/simple;
	bh=/3baXZfKl7ZKR5eQjaNfIb4EHW7GOPZVfVj/duCe7Iw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Upo3cy5/DwYadBikStR4qxsXtwfO29JZxvPLjIPnTDrjMIy+Ia30a61xYj8rqBqh+ZDzd5Mdi3l1JLClRxhPD+pMraESuMypDfhLDhOfnRrNecn1kSvCMqSDOQq1JFrFEDWSu2aer5kWYEEt78jbWx4GnmC3Vm5JqmOZYWI3UZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b79JGQ/v; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b79JGQ/v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D18D2C116D0;
	Tue, 24 Feb 2026 21:26:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771968363;
	bh=/3baXZfKl7ZKR5eQjaNfIb4EHW7GOPZVfVj/duCe7Iw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=b79JGQ/vRwKhGaPKOZyRABIEA+7SQAn/eZvs7x6p9ItIAVmE8hjvAB/1Jf/hsvGon
	 DV/Ty/5jdTtXlzoClYZBCyRDSEL2YLI+CQ2E82LZpMna96rBto7Rpv8MjjALsntmZw
	 lwSZJFa0qWZn2YU9oP6uGfzHXTEMcYRifh3+0cMJiC8fVg+LTCbpPNs5Iewk/RNWUZ
	 5+pv27Li1WTxcmFg/Ydon8QATdcSWf5SEnwXRIPTzrMf8nfnlsaTeH8ErH8zFr6pxx
	 GdVj4yaTNvcqAcav7w3PKZgIlLzFlrNRscB56UNHQywFFk/lBa6BiS30gx8fLk5oSG
	 JvxQMDLjSMZmw==
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
Subject: [PATCH bpf-next v4 1/7] bpf: Add KF_ACQUIRE and KF_RELEASE support for iterators
Date: Tue, 24 Feb 2026 13:25:23 -0800
Message-ID: <20260224212535.1165151-2-puranjay@kernel.org>
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

Some iterators hold resources (like mmap_lock in task_vma) that prevent
sleeping. To allow BPF programs to release such resources mid-iteration
and call sleepable helpers, the verifier needs to track acquire/release
semantics on iterator _next pointers.

Repurpose the st->id field on STACK_ITER slots to track the ref_obj_id
of the pointer returned by _next when the kfunc is annotated with
KF_ACQUIRE. This is safe because st->id is initialized to 0 by
__mark_reg_known_zero() in mark_stack_slots_iter() and is not compared
in stacksafe() for STACK_ITER slots.

The lifecycle is:

  _next (KF_ACQUIRE):
    - auto-release old ref if st->id != 0
    - acquire new ref, store ref_obj_id in st->id
    - DRAINED branch: release via st->id, set st->id = 0
    - ACTIVE branch: keeps ref, st->id tracks it

  _release (KF_RELEASE + __iter arg):
    - read st->id, release_reference(), set st->id = 0

  _destroy:
    - release st->id if non-zero before releasing iterator's own ref

Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
---
 kernel/bpf/verifier.c | 71 +++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 69 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 1153a828ce8d..af18cda06dc1 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -1038,6 +1038,8 @@ static void __mark_reg_known_zero(struct bpf_reg_state *reg);
 static bool in_rcu_cs(struct bpf_verifier_env *env);
 
 static bool is_kfunc_rcu_protected(struct bpf_kfunc_call_arg_meta *meta);
+static bool is_kfunc_acquire(struct bpf_kfunc_call_arg_meta *meta);
+static bool is_kfunc_release(struct bpf_kfunc_call_arg_meta *meta);
 
 static int mark_stack_slots_iter(struct bpf_verifier_env *env,
 				 struct bpf_kfunc_call_arg_meta *meta,
@@ -1083,6 +1085,22 @@ static int mark_stack_slots_iter(struct bpf_verifier_env *env,
 	return 0;
 }
 
+/*
+ * Release the acquired reference tracked by iter_st->id, if any.
+ * Used during auto-release in _next, DRAINED handling, and _destroy.
+ */
+static int iter_release_acquired_ref(struct bpf_verifier_env *env,
+				     struct bpf_reg_state *iter_st)
+{
+	int err;
+
+	if (!iter_st->id)
+		return 0;
+	err = release_reference(env, iter_st->id);
+	iter_st->id = 0;
+	return err;
+}
+
 static int unmark_stack_slots_iter(struct bpf_verifier_env *env,
 				   struct bpf_reg_state *reg, int nr_slots)
 {
@@ -1097,8 +1115,14 @@ static int unmark_stack_slots_iter(struct bpf_verifier_env *env,
 		struct bpf_stack_state *slot = &state->stack[spi - i];
 		struct bpf_reg_state *st = &slot->spilled_ptr;
 
-		if (i == 0)
+		if (i == 0) {
+			/*
+			 * Release any outstanding acquired ref tracked by st->id
+			 * before releasing the iterator's own ref.
+			 */
+			WARN_ON_ONCE(iter_release_acquired_ref(env, st));
 			WARN_ON_ONCE(release_reference(env, st->ref_obj_id));
+		}
 
 		__mark_reg_not_init(env, st);
 
@@ -8943,6 +8967,8 @@ static int process_iter_arg(struct bpf_verifier_env *env, int regno, int insn_id
 		/* remember meta->iter info for process_iter_next_call() */
 		meta->iter.spi = spi;
 		meta->iter.frameno = reg->frameno;
+		if (is_kfunc_release(meta))
+			meta->release_regno = regno;
 		meta->ref_obj_id = iter_ref_obj_id(env, reg, spi);
 
 		if (is_iter_destroy_kfunc(meta)) {
@@ -9178,6 +9204,12 @@ static int process_iter_next_call(struct bpf_verifier_env *env, int insn_idx,
 	/* mark current iter state as drained and assume returned NULL */
 	cur_iter->iter.state = BPF_ITER_STATE_DRAINED;
 	__mark_reg_const_zero(env, &cur_fr->regs[BPF_REG_0]);
+	/*
+	 * If _next acquired a ref (KF_ACQUIRE), release it in the DRAINED branch since NULL
+	 * was returned.
+	 */
+	if (is_kfunc_acquire(meta))
+		return iter_release_acquired_ref(env, cur_iter);
 
 	return 0;
 }
@@ -14201,6 +14233,22 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 
 		if (meta.initialized_dynptr.ref_obj_id) {
 			err = unmark_stack_slots_dynptr(env, reg);
+		} else if (base_type(reg->type) == PTR_TO_STACK) {
+			struct bpf_func_state *fstate;
+			struct bpf_reg_state *iter_st;
+
+			fstate = env->cur_state->frame[meta.iter.frameno];
+			if (fstate->stack[meta.iter.spi].slot_type[0] != STACK_ITER) {
+				verbose(env, "expected iterator on stack for release\n");
+				return -EINVAL;
+			}
+
+			iter_st = get_iter_from_state(env->cur_state, &meta);
+			if (!iter_st->id) {
+				verbose(env, "no acquired reference to release\n");
+				return -EINVAL;
+			}
+			err = iter_release_acquired_ref(env, iter_st);
 		} else {
 			err = release_reference(env, reg->ref_obj_id);
 			if (err)
@@ -14278,6 +14326,8 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 			__mark_reg_const_zero(env, &regs[BPF_REG_0]);
 		mark_btf_func_reg_size(env, BPF_REG_0, t->size);
 	} else if (btf_type_is_ptr(t)) {
+		struct bpf_reg_state *iter_acquire_st = NULL;
+
 		ptr_type = btf_type_skip_modifiers(desc_btf, t->type, &ptr_type_id);
 		err = check_special_kfunc(env, &meta, regs, insn_aux, ptr_type, desc_btf);
 		if (err) {
@@ -14361,7 +14411,21 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 		}
 		mark_btf_func_reg_size(env, BPF_REG_0, sizeof(void *));
 		if (is_kfunc_acquire(&meta)) {
-			int id = acquire_reference(env, insn_idx);
+			int id;
+
+			/*
+			 * For iterators with KF_ACQUIRE, auto-release the previous
+			 * iteration's ref before acquiring a new one, and after
+			 * acquisition track the new ref on the iter slot.
+			 */
+			if (is_iter_next_kfunc(&meta)) {
+				iter_acquire_st = get_iter_from_state(env->cur_state, &meta);
+				err = iter_release_acquired_ref(env, iter_acquire_st);
+				if (err)
+					return err;
+			}
+
+			id = acquire_reference(env, insn_idx);
 
 			if (id < 0)
 				return id;
@@ -14372,6 +14436,9 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 			ref_set_non_owning(env, &regs[BPF_REG_0]);
 		}
 
+		if (iter_acquire_st)
+			iter_acquire_st->id = regs[BPF_REG_0].ref_obj_id;
+
 		if (reg_may_point_to_spin_lock(&regs[BPF_REG_0]) && !regs[BPF_REG_0].id)
 			regs[BPF_REG_0].id = ++env->id_gen;
 	} else if (btf_type_is_void(t)) {
-- 
2.47.3

