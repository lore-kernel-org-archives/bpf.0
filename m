Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 638911E0B86
	for <bpf@vger.kernel.org>; Wed, 18 Feb 2026 18:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771439166; cv=none; b=NJ3XcPE9tm49U3liSuQtaqsoG2t8RJSA+kKUU8TzXSownxqK+6qAIk1YP7Q7Jsxb1FnHZJnHNxjZwuR2KY6F9ex7RuwzP5KAPQQ+rWrlJG6qfJCExPvqZvaMkey7znuEMR3PB9OLJjpQcEbGJa3uh+2ac+I9U4gap6HPJwdrJVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771439166; c=relaxed/simple;
	bh=2YTENgW2p4sd9k0hNsBAmnkD75H/7NKEnYEgHSMZQlM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JDdJZFLfUVM3T0s7HUU6QyQmwg6D4x2XdhLXEt1+ICkMw+XlkAy0IIs5zBPepJoFSvcXxTpsG9Qy9PhMuib0IRN5NvV4i+mqXa6OLH612k0wpdtXREt1hJahgdwtC4T9aL/UHYmuQ3uRNRtQ9+Jpl2GVJz3bxeCOCfbFnf9f1V8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JE8AAk1i; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JE8AAk1i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB327C116D0;
	Wed, 18 Feb 2026 18:26:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771439166;
	bh=2YTENgW2p4sd9k0hNsBAmnkD75H/7NKEnYEgHSMZQlM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JE8AAk1i6KuIRZsag1JEHxzo7p31WqRur+NzoghnE2JtVDYDBYluspQoEs+Hx8Qa4
	 mVhkmaZhd4XH80OSqciRqZJRPHStUSs0GZYlOmwmAraSkypfAzzMHvLNdiLVbBn6ne
	 fJ1GLhm+W866Ww4tqNRLPACN1I6RHFJkMXqZ3obqpQm/oI88VVCjaA/3CzrOp/9IUG
	 2cOwJtQ7QNXdRoGIp4RFy3nP7l4OYUJlJJmLEZeeo670crHZXOP6yT9b//bOpu1MmC
	 Zqhexz7Rcdf5j2k1NE1JaIiTW+p2I5Z8QJiSAyE0KTMJ7RSk/QSPd+Q9gCyNewB734
	 0KXkM2f/RjffQ==
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
Subject: [PATCH bpf-next 1/5] bpf: Add KF_ACQUIRE and KF_RELEASE support for iterators
Date: Wed, 18 Feb 2026 10:25:46 -0800
Message-ID: <20260218182555.1501495-2-puranjay@kernel.org>
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
 kernel/bpf/verifier.c | 67 ++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 63 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 0162f946032f..aa48180b6073 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -355,6 +355,11 @@ struct bpf_kfunc_call_arg_meta {
 		u8 spi;
 		u8 frameno;
 	} iter;
+	/* Set when a kfunc takes an __iter arg. Used by the KF_RELEASE
+	 * path to release the reference tracked on the iterator slot
+	 * (st->id) instead of requiring a refcounted PTR_TO_BTF_ID arg.
+	 */
+	bool has_iter_arg;
 	struct bpf_map_desc map;
 	u64 mem_size;
 };
@@ -1083,6 +1088,22 @@ static int mark_stack_slots_iter(struct bpf_verifier_env *env,
 	return 0;
 }
 
+/* Release the acquired reference tracked by iter_st->id, if any.
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
+	if (!err)
+		iter_st->id = 0;
+	return err;
+}
+
 static int unmark_stack_slots_iter(struct bpf_verifier_env *env,
 				   struct bpf_reg_state *reg, int nr_slots)
 {
@@ -1097,8 +1118,13 @@ static int unmark_stack_slots_iter(struct bpf_verifier_env *env,
 		struct bpf_stack_state *slot = &state->stack[spi - i];
 		struct bpf_reg_state *st = &slot->spilled_ptr;
 
-		if (i == 0)
+		if (i == 0) {
+			/* Release any outstanding acquired ref tracked by
+			 * st->id before releasing the iterator's own ref.
+			 */
+			WARN_ON_ONCE(iter_release_acquired_ref(env, st));
 			WARN_ON_ONCE(release_reference(env, st->ref_obj_id));
+		}
 
 		__mark_reg_not_init(env, st);
 
@@ -8943,6 +8969,7 @@ static int process_iter_arg(struct bpf_verifier_env *env, int regno, int insn_id
 		/* remember meta->iter info for process_iter_next_call() */
 		meta->iter.spi = spi;
 		meta->iter.frameno = reg->frameno;
+		meta->has_iter_arg = true;
 		meta->ref_obj_id = iter_ref_obj_id(env, reg, spi);
 
 		if (is_iter_destroy_kfunc(meta)) {
@@ -9178,8 +9205,10 @@ static int process_iter_next_call(struct bpf_verifier_env *env, int insn_idx,
 	/* mark current iter state as drained and assume returned NULL */
 	cur_iter->iter.state = BPF_ITER_STATE_DRAINED;
 	__mark_reg_const_zero(env, &cur_fr->regs[BPF_REG_0]);
-
-	return 0;
+	/* If _next acquired a ref (KF_ACQUIRE), release it in the DRAINED
+	 * branch since NULL was returned.
+	 */
+	return iter_release_acquired_ref(env, cur_iter);
 }
 
 static bool arg_type_is_mem_size(enum bpf_arg_type type)
@@ -13797,7 +13826,7 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 		}
 	}
 
-	if (is_kfunc_release(meta) && !meta->release_regno) {
+	if (is_kfunc_release(meta) && !meta->release_regno && !meta->has_iter_arg) {
 		verbose(env, "release kernel function %s expects refcounted PTR_TO_BTF_ID\n",
 			func_name);
 		return -EINVAL;
@@ -14205,6 +14234,21 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 		}
 		if (err)
 			return err;
+	} else if (meta.has_iter_arg && is_kfunc_release(&meta)) {
+		/* For KF_RELEASE kfuncs taking an __iter arg, release the
+		 * reference tracked by st->id on the iterator slot.
+		 */
+		struct bpf_reg_state *iter_st;
+
+		iter_st = get_iter_from_state(env->cur_state, &meta);
+		if (!iter_st->id) {
+			verbose(env, "no acquired reference to release\n");
+			return -EINVAL;
+		}
+		err = release_reference(env, iter_st->id);
+		if (err)
+			return err;
+		iter_st->id = 0;
 	}
 
 	if (meta.func_id == special_kfunc_list[KF_bpf_list_push_front_impl] ||
@@ -14356,6 +14400,18 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 			regs[BPF_REG_0].id = ++env->id_gen;
 		}
 		mark_btf_func_reg_size(env, BPF_REG_0, sizeof(void *));
+		/* For iterators with KF_ACQUIRE, auto-release the previous
+		 * iteration's ref before acquiring a new one, and after
+		 * acquisition track the new ref on the iter slot.
+		 */
+		struct bpf_reg_state *iter_acquire_st = NULL;
+
+		if (is_iter_next_kfunc(&meta) && is_kfunc_acquire(&meta)) {
+			iter_acquire_st = get_iter_from_state(env->cur_state, &meta);
+			err = iter_release_acquired_ref(env, iter_acquire_st);
+			if (err)
+				return err;
+		}
 		if (is_kfunc_acquire(&meta)) {
 			int id = acquire_reference(env, insn_idx);
 
@@ -14368,6 +14424,9 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
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

