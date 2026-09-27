Received: from ustc.edu.cn (smtp.ustc.edu.cn [202.38.64.46])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A67D2DA74C
	for <bpf@vger.kernel.org>; Sun, 27 Sep 2026 12:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.38.64.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790510729; cv=none; b=kU1hTYeBhpblzaqbE4sgVzazlMtKar27vbPIR0iTu0Ad0eErRNu/B6d6j7GQ4/kSoLEviS96PaCxwAZnlGorOgL/hd55CqBeN/BMTSmPhdfM3pOQYtlGJPO27iCRYH/IfS6Bm3A9D+mGmWI9JEuNKnKIihhh9SHxyb03ZRS1OKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790510729; c=relaxed/simple;
	bh=pxamEHXvC9cvKQZXLW2DEPLgzIeGrnfcTRgtYS9JNEI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MyagfNpFvwHc94Y46hyCK0lozv2U67ISYkYwWi6jB9wC+Cfs61S9tu6+IHPTIXTeRfiCIyQUfKimEtwSZ13bMwKbSpG3WQzcslb1B3tm2ZV2cyYdwuaQoiD6T4Np/muvZAUGU5Vnivh6sb3scutNu9Ei379sLCfBh2blB6twJYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.ustc.edu.cn; spf=pass smtp.mailfrom=mail.ustc.edu.cn; dkim=pass (1024-bit key) header.d=mail.ustc.edu.cn header.i=@mail.ustc.edu.cn header.b=PhBTrBAx; arc=none smtp.client-ip=202.38.64.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.ustc.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.ustc.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mail.ustc.edu.cn header.i=@mail.ustc.edu.cn header.b="PhBTrBAx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mail.ustc.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-ID:In-Reply-To:References:MIME-Version:
	Content-Transfer-Encoding; bh=Rogeh5a3EC6705qWAE59Gfbus1pEdZkUqX
	8oKnVyqyk=; b=PhBTrBAxUUYuhJ9HzfxnIS4URtHSa2+2XA++wz56TDA/JZPGxg
	NIIvc/TBdduQ1FkoqH3tBfV3F+j9CQcBbRneHgEgpuK3BaqhU8YGLsQeolkXPKlU
	gYEqxV6NN+c7Ct5ckR/kUiLDHWeBoYf6MqIzkRsGmxe1pip4aKF2cGH8Q=
Received: from localhost (unknown [222.195.81.76])
	by mailimap2024 (Coremail) with SMTP id 3pYKCgAHojM9Brlq+4hqAQ--.1501S2;
	Sun, 27 Sep 2026 20:04:13 +0800 (CST)
From: Xu Yunxiang <xyx2021@mail.ustc.edu.cn>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	ameryhung@gmail.com,
	yonghong.song@linux.dev,
	puranjay@kernel.org
Subject: [PATCH bpf-next v6 1/2] bpf: Track borrowed iterator results by default
Date: Sun, 27 Sep 2026 20:04:05 +0800
Message-ID: <20260927120406.1041915-2-xyx2021@mail.ustc.edu.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260927120406.1041915-1-xyx2021@mail.ustc.edu.cn>
References: <20260927120406.1041915-1-xyx2021@mail.ustc.edu.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:3pYKCgAHojM9Brlq+4hqAQ--.1501S2
X-Coremail-Antispam: 1UD129KBjvAXoW3Kr1fZF17tFyDXw18Zr15CFg_yoW8JF4UAo
	WxGr4SyF4xKr1kArWIyF17tF15Way3C3s5AF45Gws5u3W7WryUtr17KrW3Xas7uF1rKF4D
	AFykAas5trykCr13n29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UjIYCTnIWjp_UUUY97k0a2IF6w4kM7kC6x804xWl14x267AKxVW8JVW5JwAFc2x0
	x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj4
	1l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0
	I7IYx2IY6xkF7I0E14v26F4j6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwV
	C2z280aVCY1x0267AKxVW0oVCq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x0
	82IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAw
	Av7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48J
	MxkF7I0En4kS14v26r1q6r43MxkIecxEwVAFwVW5JwCF04k20xvY0x0EwIxGrwCFx2IqxV
	CFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r10
	6r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxV
	WUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG
	6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr
	1UYxBIdaVFxhVjvjDU0xZFpf9x07bO9N-UUUUU=
X-CM-SenderInfo: h010jiysr6zt1loo32lwfovvfxof0/

An open-coded iterator can return a struct pointer borrowed from its
current element. The verifier has not tied such results to iterator
state since the task_vma iterator was introduced, so a saved result
can still be used after destroy. Commit bee9ef4a40a27 ("bpf: switch
task_vma iterator from mmap_lock to per-VMA locks") also made next
release the protection of the prior element. A later snapshot
conversion made vm_file explicitly borrowed from that element.

Associate non-RCU, non-acquired struct results with the iterator
reference by default. Invalidate dependents before next forks its
NULL and non-NULL paths, while retaining the iterator itself. Let
destroy propagate child-reference errors. Add KF_ITER_RET_INDEPENDENT
for results that outlive the current element, preserving existing
RCU and acquired-reference rules.

Propagate the source lifetime through trusted field loads and dynptr
constructors so their descendants remain in the invalidation graph.
Reuse the reference-release traversal for next without releasing the
iterator's own reference.

Fixes: 4ac454682158 ("bpf: Introduce task_vma open-coded iterator kfuncs")
Suggested-by: Amery Hung <ameryhung@gmail.com>
Assisted-by: LLM
Signed-off-by: Xu Yunxiang <xyx2021@mail.ustc.edu.cn>
---
 Documentation/bpf/bpf_iterators.rst |  10 +++
 include/linux/btf.h                 |   1 +
 kernel/bpf/btf.c                    |  13 +++-
 kernel/bpf/verifier.c               | 103 +++++++++++++++++++++++-----
 4 files changed, 108 insertions(+), 19 deletions(-)

diff --git a/Documentation/bpf/bpf_iterators.rst b/Documentation/bpf/bpf_iterators.rst
index 189e3ec1c6c8e..72435e32ffa16 100644
--- a/Documentation/bpf/bpf_iterators.rst
+++ b/Documentation/bpf/bpf_iterators.rst
@@ -86,6 +86,16 @@ Constructor/next/destructor implementation contract is as follows:
     resources and marks stack space used by `struct bpf_iter_<type>` as usable
     for something else. Destructor is marked with KF_ITER_DESTROY flag.
 
+The verifier treats a non-RCU, non-acquired struct result as borrowed from
+the iterator's current element. It invalidates the previous result and its
+tracked derived pointers on the next call, including when it returns NULL,
+and on destruction of the iterator. Resources borrowing that lifetime must
+be released first. A next method whose struct result has an independent
+lifetime must use ``KF_ITER_RET_INDEPENDENT``. This flag requires
+``KF_ITER_NEXT`` and a struct pointer return type, and cannot be combined
+with ``KF_ACQUIRE``. RCU-protected and acquired results retain their own
+lifetime rules.
+
 Any open-coded BPF iterator implementation has to implement at least these
 three methods. It is enforced that for any given type of iterator only
 applicable constructor/destructor/next are callable. I.e., verifier ensures
diff --git a/include/linux/btf.h b/include/linux/btf.h
index 4b63bb91550a1..3c2f92e517849 100644
--- a/include/linux/btf.h
+++ b/include/linux/btf.h
@@ -81,6 +81,7 @@
 #define KF_IMPLICIT_ARGS (1 << 16) /* kfunc has implicit arguments supplied by the verifier */
 #define KF_SPINLOCK_SAFE (1 << 17) /* kfunc is allowed inside bpf_spin_lock-ed region */
 #define KF_PERFMON      (1 << 18) /* kfunc requires CAP_PERFMON */
+#define KF_ITER_RET_INDEPENDENT (1 << 19) /* next result outlives the current element */
 
 /*
  * Tag marking a kernel function as a kfunc. This is meant to minimize the
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 9bcfefdfb7346..df7545e16995c 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -9245,6 +9245,10 @@ static int btf_check_iter_kfuncs(struct btf *btf, const char *func_name,
 	if (!flags || (flags & (flags - 1)))
 		return -EINVAL;
 
+	if ((func_flags & KF_ITER_RET_INDEPENDENT) &&
+	    (!(flags & KF_ITER_NEXT) || (func_flags & KF_ACQUIRE)))
+		return -EINVAL;
+
 	/* any BPF iter kfunc should have `struct bpf_iter_<type> *` first arg */
 	nr_args = btf_type_vlen(func);
 	if (nr_args < 1)
@@ -9285,6 +9289,12 @@ static int btf_check_iter_kfuncs(struct btf *btf, const char *func_name,
 		t = btf_type_skip_modifiers(btf, func->type, NULL);
 		if (!t || !btf_type_is_ptr(t))
 			return -EINVAL;
+		/* The opt-out applies only to non-acquired struct results. */
+		if (func_flags & KF_ITER_RET_INDEPENDENT) {
+			t = btf_type_skip_modifiers(btf, t->type, NULL);
+			if (!t || !__btf_type_is_struct(t))
+				return -EINVAL;
+		}
 	}
 
 	if (flags & KF_ITER_DESTROY) {
@@ -9351,7 +9361,8 @@ static int btf_check_kfunc_protos(struct btf *btf, u32 func_id, u32 func_flags)
 	if (!func || !btf_type_is_func_proto(func))
 		return -EINVAL;
 
-	if (func_flags & (KF_ITER_NEW | KF_ITER_NEXT | KF_ITER_DESTROY)) {
+	if (func_flags & (KF_ITER_NEW | KF_ITER_NEXT | KF_ITER_DESTROY |
+			  KF_ITER_RET_INDEPENDENT)) {
 		err = btf_check_iter_kfuncs(btf, func_name, func, func_flags);
 		if (err)
 			return err;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 03dbc0e003986..4c8aa607cb86f 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -209,6 +209,10 @@ static int acquire_reference(struct bpf_verifier_env *env, int insn_idx, int par
 static int __release_reference_nomark(struct bpf_verifier_state *state, int id);
 static int release_reference_nomark(struct bpf_verifier_env *env, int id);
 static int release_reference(struct bpf_verifier_env *env, int id);
+static int invalidate_reference_dependents(struct bpf_verifier_env *env, int id);
+static int check_reference_children_leak(struct bpf_verifier_env *env, int parent_id);
+static u32 reg_lifetime_id(struct bpf_verifier_env *env,
+			   const struct bpf_reg_state *reg);
 static void invalidate_non_owning_refs(struct bpf_verifier_env *env);
 static void invalidate_rcu_protected_refs(struct bpf_verifier_env *env);
 static bool in_rbtree_lock_required_cb(struct bpf_verifier_env *env);
@@ -765,8 +769,8 @@ static int mark_stack_slots_dynptr(struct bpf_verifier_env *env, struct bpf_reg_
 		if (err)
 			return err;
 
-		/* Track parent's id if the parent is a referenced object */
-		parent_id = ref_obj->id;
+		/* All non-clone constructors take their backing object in R1. */
+		parent_id = reg_lifetime_id(env, &cur_regs(env)[BPF_REG_1]);
 
 		if (dynptr_type_referenced(type)) {
 			int id;
@@ -1041,7 +1045,7 @@ static int unmark_stack_slots_iter(struct bpf_verifier_env *env,
 				   struct bpf_reg_state *reg, int nr_slots)
 {
 	struct bpf_func_state *state = bpf_func(env, reg);
-	int spi, i, j;
+	int spi, i, j, err;
 
 	spi = iter_get_spi(env, reg, nr_slots);
 	if (spi < 0)
@@ -1051,8 +1055,11 @@ static int unmark_stack_slots_iter(struct bpf_verifier_env *env,
 		struct bpf_stack_state *slot = bpf_stack_slot(state, spi - i);
 		struct bpf_reg_state *st = &slot->spilled_ptr;
 
-		if (i == 0)
-			WARN_ON_ONCE(release_reference(env, st->id));
+		if (i == 0) {
+			err = release_reference(env, st->id);
+			if (err)
+				return err;
+		}
 
 		bpf_mark_reg_not_init(env, st);
 
@@ -1594,6 +1601,12 @@ static bool reg_is_referenced(struct bpf_verifier_env *env, const struct bpf_reg
 	return find_reference_state(env->cur_state, reg->id);
 }
 
+static u32 reg_lifetime_id(struct bpf_verifier_env *env,
+			   const struct bpf_reg_state *reg)
+{
+	return reg_is_referenced(env, reg) ? reg->id : reg->parent_id;
+}
+
 static int release_lock_state(struct bpf_verifier_env *env, int type, int id, void *ptr)
 {
 	struct bpf_verifier_state *state = env->cur_state;
@@ -6490,9 +6503,14 @@ static int check_ptr_to_btf_access(struct bpf_verifier_env *env,
 	}
 
 	if (atype == BPF_READ && value_regno >= 0) {
+		u32 parent_id = reg_lifetime_id(env, reg);
+
 		ret = mark_btf_ld_reg(env, regs, value_regno, ret, reg->btf, btf_id, flag);
 		if (ret < 0)
 			return ret;
+		if ((regs[value_regno].type & PTR_TRUSTED) &&
+		    !(regs[value_regno].type & (MEM_RCU | MEM_PERCPU | MEM_USER)))
+			regs[value_regno].parent_id = parent_id;
 	}
 
 	return 0;
@@ -8251,6 +8269,21 @@ static bool is_iter_destroy_kfunc(struct bpf_call_arg_meta *meta)
 	return meta->kfunc_flags & KF_ITER_DESTROY;
 }
 
+static bool iter_next_borrows_struct(struct bpf_call_arg_meta *meta)
+{
+	const struct btf_type *t;
+
+	if (!(meta->kfunc_flags & KF_ITER_NEXT) ||
+	    (meta->kfunc_flags & (KF_ITER_RET_INDEPENDENT | KF_ACQUIRE)))
+		return false;
+
+	t = btf_type_skip_modifiers(meta->btf, meta->func_proto->type, NULL);
+	if (!t || !btf_type_is_ptr(t))
+		return false;
+	t = btf_type_skip_modifiers(meta->btf, t->type, NULL);
+	return t && __btf_type_is_struct(t);
+}
+
 static bool is_kfunc_arg_iter(struct bpf_call_arg_meta *meta, int arg_idx,
 			      const struct btf_param *arg)
 {
@@ -8361,6 +8394,14 @@ static int process_iter_arg(struct bpf_verifier_env *env, struct bpf_reg_state *
 		meta->iter.frameno = reg->frameno;
 		update_ref_obj(&meta->ref_obj, &bpf_stack_slot(state, spi)->spilled_ptr);
 
+		if (iter_next_borrows_struct(meta) &&
+		    !is_kfunc_rcu_protected(meta) &&
+		    !(bpf_stack_slot(state, spi)->spilled_ptr.type & MEM_RCU)) {
+			err = invalidate_reference_dependents(env, meta->ref_obj.id);
+			if (err)
+				return err;
+		}
+
 		if (is_iter_destroy_kfunc(meta)) {
 			err = unmark_stack_slots_iter(env, reg, nr_slots);
 			if (err)
@@ -10578,8 +10619,25 @@ static int idstack_pop(struct bpf_idmap *idmap)
 	return idmap->map[--idmap->cnt].old;
 }
 
-/* Release id and objects derived from it iteratively in a DFS manner */
-static int release_reference(struct bpf_verifier_env *env, int id)
+static int check_reference_children_leak(struct bpf_verifier_env *env, int parent_id)
+{
+	struct bpf_verifier_state *state = env->cur_state;
+	int i;
+
+	for (i = 0; i < state->acquired_refs; i++) {
+		if (state->refs[i].type != REF_TYPE_PTR ||
+		    state->refs[i].parent_id != parent_id)
+			continue;
+		verbose(env, "Leaking reference id=%d alloc_insn=%d. Release it first.\n",
+			state->refs[i].id, state->refs[i].insn_idx);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+/* Invalidate id and its descendants, optionally retaining the root reference. */
+static int __release_reference(struct bpf_verifier_env *env, int id, bool release_root)
 {
 	u32 mask = (1 << STACK_SPILL) | (1 << STACK_DYNPTR);
 	struct bpf_verifier_state *vstate = env->cur_state;
@@ -10587,14 +10645,15 @@ static int release_reference(struct bpf_verifier_env *env, int id)
 	struct bpf_stack_state *stack;
 	struct bpf_func_state *state;
 	struct bpf_reg_state *reg;
-	int i, err;
+	int root_id = id;
+	int err;
 
 	idstack->cnt = 0;
 	err = idstack_push(idstack, id);
 	if (err)
 		return err;
 
-	if (find_reference_state(vstate, id)) {
+	if (release_root && find_reference_state(vstate, id)) {
 		err = release_reference_nomark(env, id);
 		WARN_ON_ONCE(err);
 	}
@@ -10604,19 +10663,15 @@ static int release_reference(struct bpf_verifier_env *env, int id)
 		 * Child references are inaccessible after parent is released,
 		 * any child references that exist at this point are a leak.
 		 */
-		for (i = 0; i < vstate->acquired_refs; i++) {
-			if (vstate->refs[i].type != REF_TYPE_PTR)
-				continue;
-			if (vstate->refs[i].parent_id != id)
-				continue;
-			verbose(env, "Leaking reference id=%d alloc_insn=%d. Release it first.\n",
-				vstate->refs[i].id, vstate->refs[i].insn_idx);
-			return -EINVAL;
-		}
+		err = check_reference_children_leak(env, id);
+		if (err)
+			return err;
 
 		bpf_for_each_reg_in_vstate_mask(vstate, state, reg, stack, mask, ({
 			if (reg->id != id && reg->parent_id != id)
 				continue;
+			if (!release_root && id == root_id && reg->parent_id != id)
+				continue;
 
 			/* Free objects derived from the current object */
 			if (reg->parent_id == id) {
@@ -10650,6 +10705,16 @@ static int release_reference(struct bpf_verifier_env *env, int id)
 	return 0;
 }
 
+static int release_reference(struct bpf_verifier_env *env, int id)
+{
+	return __release_reference(env, id, true);
+}
+
+static int invalidate_reference_dependents(struct bpf_verifier_env *env, int id)
+{
+	return __release_reference(env, id, false);
+}
+
 static void invalidate_non_owning_refs(struct bpf_verifier_env *env)
 {
 	struct bpf_func_state *unused;
@@ -15153,6 +15218,8 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 			regs[BPF_REG_0].btf = desc_btf;
 			regs[BPF_REG_0].type = type;
 			regs[BPF_REG_0].btf_id = ptr_type_id;
+			if (iter_next_borrows_struct(&meta) && !(type & MEM_RCU))
+				regs[BPF_REG_0].parent_id = meta.ref_obj.id;
 		}
 
 		if (is_kfunc_ret_null(&meta)) {
-- 
2.43.0

