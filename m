Received: from ustc.edu.cn (smtp.ustc.edu.cn [202.38.64.46])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D36A8401A02
	for <bpf@vger.kernel.org>; Sun, 20 Sep 2026 21:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.38.64.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789938283; cv=none; b=tUaoXUNMQVS0sZLFvwz9z49/X45HclROJDHEZHLaOq5ul5xJ98rqEV2PullQZIp2PncX5DVDfVMNTmv2284/5W2ybQZAA37OcIMQ9L3opinaLKXOFbnYsd1xDg1yFrpYk4ORe30heM20/jqosRXLi0u0cE1KKLhj1YD7X/Fubzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789938283; c=relaxed/simple;
	bh=miXekrGKvOio6//EH32UK6tt24lOHjiqa5FovhBuBgo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sNEwAza+a8v1DlWAGCPfX7d8QEaInZdHI4e2cswT1hPxJMLhD7hUkY38ySW85RtljJN4pQf2uFC4slbNYvvAKLVflMqw2RieTvlgMY+IblF4+R9xhOPpA67U8234PiAbG6AXH1b4WP68ywzz/E7Tq6L7s26Eqn3Bd7r4SrMBeuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.ustc.edu.cn; spf=pass smtp.mailfrom=mail.ustc.edu.cn; dkim=pass (1024-bit key) header.d=mail.ustc.edu.cn header.i=@mail.ustc.edu.cn header.b=jbZLmp/z; arc=none smtp.client-ip=202.38.64.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.ustc.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.ustc.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mail.ustc.edu.cn header.i=@mail.ustc.edu.cn header.b="jbZLmp/z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mail.ustc.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-ID:In-Reply-To:References:MIME-Version:
	Content-Transfer-Encoding; bh=3Qjyk6ShvujSW/Yp+DsH7BpEPMtYc5hQeG
	oVLCBSBLk=; b=jbZLmp/z+Zh4SXAJpsRPkQQ0000W7LYsj2rmr+tuPlbe3AK+bm
	1T9SsmgtDhFNTyKaY5bqKpmLYTJzebOTaPW294G3yUfcNOBbJ+BWqxr/H+CY/pt4
	Pa3JcPaN9DiZfkaTpqsH6ZzyS3JMiCyXcov1/jX7rC3VmdzXMPrxUUWqc=
Received: from localhost (unknown [222.195.81.68])
	by mailimap2024 (Coremail) with SMTP id 3pYKCgBXWTBiSrBq8TBAAQ--.2086S2;
	Mon, 21 Sep 2026 05:04:34 +0800 (CST)
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
Subject: [PATCH bpf-next v5 1/2] bpf: Track iterator-owned BTF pointer lifetimes
Date: Mon, 21 Sep 2026 05:04:31 +0800
Message-ID: <20260920210432.345758-2-xyx2021@mail.ustc.edu.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260920210432.345758-1-xyx2021@mail.ustc.edu.cn>
References: <20260920210432.345758-1-xyx2021@mail.ustc.edu.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:3pYKCgBXWTBiSrBq8TBAAQ--.2086S2
X-Coremail-Antispam: 1UD129KBjvAXoW3tw4UtrW8Jw47GrWDAry7Wrg_yoW8Xry3Wo
	WxCr4rta18Gr1kCrW2yF12qFWYga1DGas3AF4rG3Z5uayxXryavrW29343Wasa9F1fKF4D
	AFykGasYqrykAr4fn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UjIYCTnIWjp_UUUYP7k0a2IF6w4kM7kC6x804xWl14x267AKxVW8JVW5JwAFc2x0
	x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj4
	1l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0
	I7IYx2IY6xkF7I0E14v26F4j6r4UJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjc
	xK6I8E87Iv6xkF7I0E14v26F4UJVW0owAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE
	52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUAV
	WUtwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAK
	I48JMxkF7I0En4kS14v26r1q6r43MxkIecxEwVAFwVWxMxAIw28IcxkI7VAKI48JMxC20s
	026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_
	JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14
	v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xva
	j40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JV
	W8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU5EQ6tUUUUU==
X-CM-SenderInfo: h010jiysr6zt1loo32lwfovvfxof0/

Some non-RCU struct iterator results borrow their lifetime from the
iterator's current element. Other iterators may return objects with an
independent lifetime, so make current-element lifetime tracking opt-in
through KF_ITER_LIFETIME on the next kfunc. Validate that the flag is used
with a borrowed struct pointer result.

Opt in task_vma, css_task, kmem_cache and dmabuf, whose next and destroy
operations can release the previous element or its backing references.
Associate their PTR_TO_BTF_ID results with the iterator reference and
invalidate the previous result before modeling either next outcome.
Destroy invalidates the result through reference release. Unflagged
iterators and RCU-protected results retain their existing rules.

Preserve that lifetime when loading a fully trusted BTF field. Capture the
source lifetime before marking the destination, as the registers can
alias. Keep RCU, user and percpu field results under their existing rules.

A borrowed field can also back a dynptr. For example, a FILE dynptr owns
reader state but borrows its file. Record the backing register's lifetime
in the common dynptr constructor path, using the acquired ID for an owned
reference and parent_id for a borrowed pointer. Keep clone handling and
the ownership meaning of reg_is_referenced() unchanged.

Reuse the existing child-reference leak check before advancing an iterator
and propagate destroy errors. Outstanding child resources must be
explicitly released before their backing lifetime ends. Preserve the
existing rule that only the initial ID is removed from acquired references
when release_reference() invalidates descendants.

This issue was found during BPF verifier testing with an in-house runtime
semantic checker.

Fixes: 4cbee026db54 ("bpf: return VMA snapshot from task_vma iterator")
Suggested-by: Amery Hung <ameryhung@gmail.com>
Assisted-by: LLM
Signed-off-by: Xu Yunxiang <xyx2021@mail.ustc.edu.cn>
---
 Documentation/bpf/bpf_iterators.rst |  9 +++
 include/linux/btf.h                 |  1 +
 kernel/bpf/btf.c                    | 12 +++-
 kernel/bpf/helpers.c                | 10 ++--
 kernel/bpf/verifier.c               | 88 ++++++++++++++++++++++++-----
 5 files changed, 100 insertions(+), 20 deletions(-)

diff --git a/Documentation/bpf/bpf_iterators.rst b/Documentation/bpf/bpf_iterators.rst
index 189e3ec1c6c8e..814e63296bee1 100644
--- a/Documentation/bpf/bpf_iterators.rst
+++ b/Documentation/bpf/bpf_iterators.rst
@@ -86,6 +86,15 @@ Constructor/next/destructor implementation contract is as follows:
     resources and marks stack space used by `struct bpf_iter_<type>` as usable
     for something else. Destructor is marked with KF_ITER_DESTROY flag.
 
+An iterator whose non-RCU struct result borrows the lifetime of its current
+element must additionally mark its next method with ``KF_ITER_LIFETIME``.
+The verifier invalidates the previous result and its trusted derived fields
+on the next call, including when that call returns NULL, and on destruction
+of the iterator. Resources borrowing that lifetime must be released first.
+The flag requires ``KF_ITER_NEXT`` and a struct pointer return type, and
+cannot be combined with ``KF_ACQUIRE``. It does not change RCU lifetime rules.
+Iterators whose results have an independent lifetime should omit this flag.
+
 Any open-coded BPF iterator implementation has to implement at least these
 three methods. It is enforced that for any given type of iterator only
 applicable constructor/destructor/next are callable. I.e., verifier ensures
diff --git a/include/linux/btf.h b/include/linux/btf.h
index ddd0f4f32d24b..9877f1455a0ef 100644
--- a/include/linux/btf.h
+++ b/include/linux/btf.h
@@ -80,6 +80,7 @@
 #define KF_ARENA_ARG2   (1 << 15) /* kfunc takes an arena pointer as its second argument */
 #define KF_IMPLICIT_ARGS (1 << 16) /* kfunc has implicit arguments supplied by the verifier */
 #define KF_SPINLOCK_SAFE (1 << 17) /* kfunc is allowed inside bpf_spin_lock-ed region */
+#define KF_ITER_LIFETIME (1 << 18) /* next result borrows the current element's lifetime */
 
 /*
  * Tag marking a kernel function as a kfunc. This is meant to minimize the
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 314ecb0e593b0..6a287f808200b 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -8886,6 +8886,10 @@ static int btf_check_iter_kfuncs(struct btf *btf, const char *func_name,
 	if (!flags || (flags & (flags - 1)))
 		return -EINVAL;
 
+	if ((func_flags & KF_ITER_LIFETIME) &&
+	    (!(flags & KF_ITER_NEXT) || (func_flags & KF_ACQUIRE)))
+		return -EINVAL;
+
 	/* any BPF iter kfunc should have `struct bpf_iter_<type> *` first arg */
 	nr_args = btf_type_vlen(func);
 	if (nr_args < 1)
@@ -8926,6 +8930,12 @@ static int btf_check_iter_kfuncs(struct btf *btf, const char *func_name,
 		t = btf_type_skip_modifiers(btf, func->type, NULL);
 		if (!t || !btf_type_is_ptr(t))
 			return -EINVAL;
+		/* Lifetime-bound results are borrowed struct pointers. */
+		if (func_flags & KF_ITER_LIFETIME) {
+			t = btf_type_skip_modifiers(btf, t->type, NULL);
+			if (!t || !__btf_type_is_struct(t))
+				return -EINVAL;
+		}
 	}
 
 	if (flags & KF_ITER_DESTROY) {
@@ -8992,7 +9002,7 @@ static int btf_check_kfunc_protos(struct btf *btf, u32 func_id, u32 func_flags)
 	if (!func || !btf_type_is_func_proto(func))
 		return -EINVAL;
 
-	if (func_flags & (KF_ITER_NEW | KF_ITER_NEXT | KF_ITER_DESTROY)) {
+	if (func_flags & (KF_ITER_NEW | KF_ITER_NEXT | KF_ITER_DESTROY | KF_ITER_LIFETIME)) {
 		err = btf_check_iter_kfuncs(btf, func_name, func, func_flags);
 		if (err)
 			return err;
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 82402d97ce67c..0606ce279893c 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -5021,11 +5021,11 @@ BTF_ID_FLAGS(func, bpf_iter_num_new, KF_ITER_NEW | KF_SPINLOCK_SAFE)
 BTF_ID_FLAGS(func, bpf_iter_num_next, KF_ITER_NEXT | KF_RET_NULL | KF_SPINLOCK_SAFE)
 BTF_ID_FLAGS(func, bpf_iter_num_destroy, KF_ITER_DESTROY | KF_SPINLOCK_SAFE)
 BTF_ID_FLAGS(func, bpf_iter_task_vma_new, KF_ITER_NEW | KF_RCU)
-BTF_ID_FLAGS(func, bpf_iter_task_vma_next, KF_ITER_NEXT | KF_RET_NULL)
+BTF_ID_FLAGS(func, bpf_iter_task_vma_next, KF_ITER_NEXT | KF_RET_NULL | KF_ITER_LIFETIME)
 BTF_ID_FLAGS(func, bpf_iter_task_vma_destroy, KF_ITER_DESTROY)
 #ifdef CONFIG_CGROUPS
 BTF_ID_FLAGS(func, bpf_iter_css_task_new, KF_ITER_NEW)
-BTF_ID_FLAGS(func, bpf_iter_css_task_next, KF_ITER_NEXT | KF_RET_NULL)
+BTF_ID_FLAGS(func, bpf_iter_css_task_next, KF_ITER_NEXT | KF_RET_NULL | KF_ITER_LIFETIME)
 BTF_ID_FLAGS(func, bpf_iter_css_task_destroy, KF_ITER_DESTROY)
 BTF_ID_FLAGS(func, bpf_iter_css_new, KF_ITER_NEW | KF_RCU_PROTECTED)
 BTF_ID_FLAGS(func, bpf_iter_css_next, KF_ITER_NEXT | KF_RET_NULL)
@@ -5058,7 +5058,8 @@ BTF_ID_FLAGS(func, bpf_copy_from_user_mm_str, KF_SLEEPABLE)
 BTF_ID_FLAGS(func, bpf_copy_from_user_task_str, KF_SLEEPABLE)
 BTF_ID_FLAGS(func, bpf_get_kmem_cache)
 BTF_ID_FLAGS(func, bpf_iter_kmem_cache_new, KF_ITER_NEW | KF_SLEEPABLE)
-BTF_ID_FLAGS(func, bpf_iter_kmem_cache_next, KF_ITER_NEXT | KF_RET_NULL | KF_SLEEPABLE)
+BTF_ID_FLAGS(func, bpf_iter_kmem_cache_next,
+	     KF_ITER_NEXT | KF_RET_NULL | KF_SLEEPABLE | KF_ITER_LIFETIME)
 BTF_ID_FLAGS(func, bpf_iter_kmem_cache_destroy, KF_ITER_DESTROY | KF_SLEEPABLE)
 BTF_ID_FLAGS(func, bpf_local_irq_save)
 BTF_ID_FLAGS(func, bpf_local_irq_restore)
@@ -5074,7 +5075,8 @@ BTF_ID_FLAGS(func, bpf_copy_from_user_task_str_dynptr, KF_SLEEPABLE)
 #endif
 #ifdef CONFIG_DMA_SHARED_BUFFER
 BTF_ID_FLAGS(func, bpf_iter_dmabuf_new, KF_ITER_NEW | KF_SLEEPABLE)
-BTF_ID_FLAGS(func, bpf_iter_dmabuf_next, KF_ITER_NEXT | KF_RET_NULL | KF_SLEEPABLE)
+BTF_ID_FLAGS(func, bpf_iter_dmabuf_next,
+	     KF_ITER_NEXT | KF_RET_NULL | KF_SLEEPABLE | KF_ITER_LIFETIME)
 BTF_ID_FLAGS(func, bpf_iter_dmabuf_destroy, KF_ITER_DESTROY | KF_SLEEPABLE)
 #endif
 BTF_ID_FLAGS(func, __bpf_trap)
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 18aad4886f9cf..4cf2010dcbbdd 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -209,6 +209,9 @@ static int acquire_reference(struct bpf_verifier_env *env, int insn_idx, int par
 static int __release_reference_nomark(struct bpf_verifier_state *state, int id);
 static int release_reference_nomark(struct bpf_verifier_env *env, int id);
 static int release_reference(struct bpf_verifier_env *env, int id);
+static int check_reference_children_leak(struct bpf_verifier_env *env, int parent_id);
+static u32 reg_lifetime_id(struct bpf_verifier_env *env,
+			   const struct bpf_reg_state *reg);
 static void invalidate_non_owning_refs(struct bpf_verifier_env *env);
 static void invalidate_rcu_protected_refs(struct bpf_verifier_env *env);
 static bool in_rbtree_lock_required_cb(struct bpf_verifier_env *env);
@@ -753,8 +756,8 @@ static int mark_stack_slots_dynptr(struct bpf_verifier_env *env, struct bpf_reg_
 		if (err)
 			return err;
 
-		/* Track parent's id if the parent is a referenced object */
-		parent_id = ref_obj->id;
+		/* All non-clone constructors take their backing object in R1. */
+		parent_id = reg_lifetime_id(env, &cur_regs(env)[BPF_REG_1]);
 
 		if (dynptr_type_referenced(type)) {
 			int id;
@@ -1024,7 +1027,7 @@ static int unmark_stack_slots_iter(struct bpf_verifier_env *env,
 				   struct bpf_reg_state *reg, int nr_slots)
 {
 	struct bpf_func_state *state = bpf_func(env, reg);
-	int spi, i, j;
+	int spi, i, j, err;
 
 	spi = iter_get_spi(env, reg, nr_slots);
 	if (spi < 0)
@@ -1034,8 +1037,11 @@ static int unmark_stack_slots_iter(struct bpf_verifier_env *env,
 		struct bpf_stack_state *slot = &state->stack[spi - i];
 		struct bpf_reg_state *st = &slot->spilled_ptr;
 
-		if (i == 0)
-			WARN_ON_ONCE(release_reference(env, st->id));
+		if (i == 0) {
+			err = release_reference(env, st->id);
+			if (err)
+				return err;
+		}
 
 		bpf_mark_reg_not_init(env, st);
 
@@ -1577,6 +1583,12 @@ static bool reg_is_referenced(struct bpf_verifier_env *env, const struct bpf_reg
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
@@ -6224,9 +6236,14 @@ static int check_ptr_to_btf_access(struct bpf_verifier_env *env,
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
@@ -7824,6 +7841,27 @@ static bool is_kfunc_arg_iter(struct bpf_call_arg_meta *meta, int arg_idx,
 	return btf_param_match_suffix(meta->btf, arg, "__iter");
 }
 
+static int invalidate_iter_owned_btf_ptrs(struct bpf_verifier_env *env, u32 parent_id)
+{
+	struct bpf_func_state *unused;
+	struct bpf_reg_state *reg;
+	int err;
+
+	err = check_reference_children_leak(env, parent_id);
+	if (err)
+		return err;
+
+	/* Opted-in iterators can release their previous element on next. */
+	bpf_for_each_reg_in_vstate(env->cur_state, unused, reg, ({
+		if (base_type(reg->type) != PTR_TO_BTF_ID || reg->parent_id != parent_id)
+			continue;
+		bpf_diag_record_scrub(env, reg, BPF_DIAG_MOD_REF_RELEASE);
+		mark_reg_invalid(env, reg);
+	}));
+
+	return 0;
+}
+
 static int process_iter_arg(struct bpf_verifier_env *env, struct bpf_reg_state *reg, argno_t argno, int insn_idx,
 			    struct bpf_call_arg_meta *meta)
 {
@@ -7921,6 +7959,13 @@ static int process_iter_arg(struct bpf_verifier_env *env, struct bpf_reg_state *
 		meta->iter.frameno = reg->frameno;
 		update_ref_obj(&meta->ref_obj, &state->stack[spi].spilled_ptr);
 
+		if ((meta->kfunc_flags & KF_ITER_LIFETIME) &&
+		    !(state->stack[spi].spilled_ptr.type & MEM_RCU)) {
+			err = invalidate_iter_owned_btf_ptrs(env, meta->ref_obj.id);
+			if (err)
+				return err;
+		}
+
 		if (is_iter_destroy_kfunc(meta)) {
 			err = unmark_stack_slots_iter(env, reg, nr_slots);
 			if (err)
@@ -10106,6 +10151,23 @@ static int idstack_pop(struct bpf_idmap *idmap)
 	return idmap->map[--idmap->cnt].old;
 }
 
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
 /* Release id and objects derived from it iteratively in a DFS manner */
 static int release_reference(struct bpf_verifier_env *env, int id)
 {
@@ -10115,7 +10177,7 @@ static int release_reference(struct bpf_verifier_env *env, int id)
 	struct bpf_stack_state *stack;
 	struct bpf_func_state *state;
 	struct bpf_reg_state *reg;
-	int i, err;
+	int err;
 
 	idstack->cnt = 0;
 	err = idstack_push(idstack, id);
@@ -10132,15 +10194,9 @@ static int release_reference(struct bpf_verifier_env *env, int id)
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
@@ -14485,6 +14541,8 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 			regs[BPF_REG_0].btf = desc_btf;
 			regs[BPF_REG_0].type = type;
 			regs[BPF_REG_0].btf_id = ptr_type_id;
+			if ((meta.kfunc_flags & KF_ITER_LIFETIME) && !(type & MEM_RCU))
+				regs[BPF_REG_0].parent_id = meta.ref_obj.id;
 		}
 
 		if (is_kfunc_ret_null(&meta)) {
-- 
2.43.0

