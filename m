Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAE5042EEA8
	for <bpf@vger.kernel.org>; Thu, 26 Feb 2026 16:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772122521; cv=none; b=qciFqfir9VHJ9sDBEAN0q/ouW+tdMyTTf7jSCjWK69f9bBXv/c1O8QDDaGBuNJnbPD1GpEP6eD1kBviYO5V2Idi7Cq3sFGJIzCScNCMGtL/+6nAU+/xfYvxkInGIOfqSp1IyVMo9NMRycenOmE23/jSUzv25zPcODJ2OtpSFoBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772122521; c=relaxed/simple;
	bh=JxSx2dL6DSydmHS2f74bKr6I1aLbBySO3uQ3lWkMygs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oJVJhdLNjNZ9P+D8EVLSKG7DZINygb5IWwER/RZ/RZtJTK3JceR9h1nmdq5q6yrY1GJk62putBpMs8QDCQwrIY0ZZx+5V2kLAi7d74WuHJwt6+YdFQM4n1i7gXTDNDELp3H2rahhuCXcD3VZWn3+gADtSsOonfh3hluJjIUhTIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tnMKufh8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tnMKufh8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E2F9C116C6;
	Thu, 26 Feb 2026 16:15:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772122521;
	bh=JxSx2dL6DSydmHS2f74bKr6I1aLbBySO3uQ3lWkMygs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tnMKufh8N5FefqCueLofdAyVl6AbCkFXTZLZH6/Xw3g20dgwn/jp/FmYikGXgObG8
	 ZO1YNJ1m0fgRvz2ZdgYhdbQrPH/A7tCe3T7mIPgZqpoVYd7aqBvkBrxJcNq4TKOFML
	 nsKmxIKgBQKJO9fcqMrQHD47ysa1wf2kxqFyZZgnzhzk6/U8EqCL1/Dk8SRmwwD02t
	 9T+1o/jDXbv4Iui1IfU0+cfuOf/HD8HywvKdUvnnff1+HMwxSTL20Y/FI86c0NaBGW
	 XBoMVdbX65ijxF0AHudsgvMKqHZkiq7Es0DBBv/gmY1Cvljf+npf+FrIGlnQTqIjge
	 Id57TJ736zubA==
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
Subject: [PATCH bpf v5 1/8] bpf: Add KF_ACQUIRE and KF_RELEASE support for iterators
Date: Thu, 26 Feb 2026 08:14:50 -0800
Message-ID: <20260226161500.775715-2-puranjay@kernel.org>
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
index bb12ba020649..c80e96c2c271 100644
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
 
@@ -8963,6 +8987,8 @@ static int process_iter_arg(struct bpf_verifier_env *env, int regno, int insn_id
 		/* remember meta->iter info for process_iter_next_call() */
 		meta->iter.spi = spi;
 		meta->iter.frameno = reg->frameno;
+		if (is_kfunc_release(meta))
+			meta->release_regno = regno;
 		meta->ref_obj_id = iter_ref_obj_id(env, reg, spi);
 
 		if (is_iter_destroy_kfunc(meta)) {
@@ -9198,6 +9224,12 @@ static int process_iter_next_call(struct bpf_verifier_env *env, int insn_idx,
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
@@ -14214,6 +14246,22 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 
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
@@ -14291,6 +14339,8 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 			__mark_reg_const_zero(env, &regs[BPF_REG_0]);
 		mark_btf_func_reg_size(env, BPF_REG_0, t->size);
 	} else if (btf_type_is_ptr(t)) {
+		struct bpf_reg_state *iter_acquire_st = NULL;
+
 		ptr_type = btf_type_skip_modifiers(desc_btf, t->type, &ptr_type_id);
 		err = check_special_kfunc(env, &meta, regs, insn_aux, ptr_type, desc_btf);
 		if (err) {
@@ -14374,7 +14424,21 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
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
@@ -14385,6 +14449,9 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
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

