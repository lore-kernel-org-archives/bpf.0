Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.38.64.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792616887;
	b=zOFfk6TaOzhQY/sw+0roZfzjwJSqfDtVeHYl6Z5hdfPavLEvl2mRvNevg7WVgxyS6o51
	 hprFgh2GPKGp4+tVlx8tLQixJviDtmAdnsOEKCEQ7Py8+puD+bsobvn0EMZLlusm+TCpz
	 PLQZ/YYLQzekx9/DegROrf3HT+FcHm/LCUNlNNJKAichps+HitYwwMQlhkDyMgcJXnE4X
	 TFFIHWoZ9boY0Cpll3PkqMQ/Id2FSG6/5c+HbXR+FzkDRyJDADyxOmsjRAxge1zljJDgt
	 ynd2DRE9xzSccB8d0lfNLUNMrwQJb9bmpfJol3EPTm3UjKrSbPdkY9cCXtPpukcT43Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792616887;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=i5VDKcCo7p4M5YKANH+BasW+1pqad9pSk3ZuPU5LV14=;
	b=4Shfj/HwfZaHcLXhdbp+ULZ53rBJ8ZZYBznMouqRDiqhRdIsiZ58FQAJz4zDIf3PbCCD
	 k8jw4aWtsdHoz1GgfaW6szzdpJUfwgZXGeRkPlwNDhtoky8gr5g4nj+NMZAJ3O7PusQW2
	 XpCc45wrZR6hrnfttSmtHQi654QFn4cl5Yid9JkKbnFLPT1nqvPGe0VwNoLGXP2Xj0IFT
	 Je+aXURd0jpM531TONcPUvoIAAgf7+w2ysbaXqOrWkIq8SvdKs4z8vDmFXKpFkuvMjGTj
	 644MtBIBnWRJpDMQgjl7s1jtRmCpKs+IORjtHYRVDcThSu/+lh+yiKl+sAEHwNiIzJQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mail.ustc.edu.cn;
	spf=pass smtp.mailfrom=mail.ustc.edu.cn;
	dkim=pass header.d=mail.ustc.edu.cn header.i=@mail.ustc.edu.cn header.a=rsa-sha256 header.s=dkim header.b=FQHCnLnS;
	arc=none smtp.remote-ip=202.38.64.46
Received: from ustc.edu.cn (smtp.ustc.edu.cn [202.38.64.46])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D13FC606A31A
	for <bpf@vger.kernel.org>; Wed, 21 Oct 2026 21:08:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D13FC606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.ustc.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.ustc.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mail.ustc.edu.cn header.i=@mail.ustc.edu.cn header.a=rsa-sha256 header.s=dkim header.b=FQHCnLnS
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mail.ustc.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-ID:In-Reply-To:References:MIME-Version:
	Content-Transfer-Encoding; bh=i5VDKcCo7p4M5YKANH+BasW+1pqad9pSk3
	ZuPU5LV14=; b=FQHCnLnSOgBg+wP3Q4Ko6g6tFSSUm33isnGDm8kCBB78FAoYsg
	YUA/3oOZrpaq/uy1YFermmB/FoXQUfXTkKokCw6hu/JTXtftwjHeGYQqIAdeyCkQ
	lcv2+pS1Tnjjr6qiO90lHyqOu2ISOUQTQtvmSPpk3sCR9B6uIEx7DflMM=
Received: from localhost (unknown [222.195.81.103])
	by mailimap2024 (Coremail) with SMTP id 3pYKCgAnozetKdlqzTsnAA--.7470S2;
	Thu, 22 Oct 2026 05:07:57 +0800 (CST)
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
Subject: [PATCH bpf-next v7 1/2] bpf: Track borrowed iterator results by default
Date: Thu, 22 Oct 2026 05:07:53 +0800
Message-ID: <20261021210754.3270023-2-xyx2021@mail.ustc.edu.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261021210754.3270023-1-xyx2021@mail.ustc.edu.cn>
References: <20261021210754.3270023-1-xyx2021@mail.ustc.edu.cn>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:3pYKCgAnozetKdlqzTsnAA--.7470S2
X-Coremail-Antispam: 1UD129KBjvAXoWfJr43Xr1rCw18Ww4xXr1UJrb_yoW8GF1UKo
	WxGr4SyF4xKF18ArW0yF17tF15Wa9xC3s5AF45Wws5u3W7WryUtr17K3y3Xas7uF1fKF4D
	AFykCas5trykAr13n29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UjIYCTnIWjp_UUUYP7k0a2IF6w4kM7kC6x804xWl14x267AKxVW8JVW5JwAFc2x0
	x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj4
	1l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0
	I7IYx2IY6xkF7I0E14v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4
	vEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJwAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE
	52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUGV
	WUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAK
	I48JMxkF7I0En4kS14v26r1q6r43MxkIecxEwVAFwVWxMxAIw28IcxkI7VAKI48JMxC20s
	026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_
	JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14
	v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xva
	j40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JV
	W8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU5C9aJUUUUU==
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

Trusted pointer field loads also need to preserve the source lifetime.
Loading a trusted field does not acquire a reference to the pointed-to
object. Set the field pointer's parent_id to the source's reference ID
if the source is referenced, or inherit its parent_id if it is borrowed.
This is a generic rule, including accesses unrelated to iterators. For
example, the following access is now rejected:

  file = bpf_get_task_exe_file(task);
  if (!file)
          return 0;
  inode = file->f_inode;
  bpf_put_file(file);
  ino = inode->i_ino;

The inode pointer borrows the file's lifetime. Releasing the acquired
file reference removes that lifetime guarantee, so the verifier must
invalidate the derived inode pointer as well. This does not imply that
bpf_put_file() immediately frees the file or inode. Reading the inode
while the file reference is held remains valid. Fields with independent
RCU protection retain their existing lifetime rules.

For an iterator result, the same propagation keeps trusted fields such
as vm_file and f_inode tied to the current element. Propagate the backing
object's lifetime through dynptr construction too, so its descendants
remain in the invalidation graph. Reuse the reference-release traversal
for next without releasing the iterator's own reference.

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
index b66e20a18c54f..a18254b7521bd 100644
--- a/include/linux/btf.h
+++ b/include/linux/btf.h
@@ -82,6 +82,7 @@
 #define KF_IMPLICIT_ARGS (1 << 16) /* kfunc has implicit arguments supplied by the verifier */
 #define KF_SPINLOCK_SAFE (1 << 17) /* kfunc is allowed inside bpf_spin_lock-ed region */
 #define KF_PERFMON      (1 << 18) /* kfunc requires CAP_PERFMON */
+#define KF_ITER_RET_INDEPENDENT (1 << 19) /* next result outlives the current element */
 
 /*
  * Tag marking a kernel function as a kfunc. This is meant to minimize the
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 538129ed24188..e360c0aefc375 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -9716,6 +9716,10 @@ static int btf_check_iter_kfuncs(struct btf *btf, const char *func_name,
 	if (!flags || (flags & (flags - 1)))
 		return -EINVAL;
 
+	if ((func_flags & KF_ITER_RET_INDEPENDENT) &&
+	    (!(flags & KF_ITER_NEXT) || (func_flags & KF_ACQUIRE)))
+		return -EINVAL;
+
 	/* any BPF iter kfunc should have `struct bpf_iter_<type> *` first arg */
 	nr_args = btf_type_vlen(func);
 	if (nr_args < 1)
@@ -9756,6 +9760,12 @@ static int btf_check_iter_kfuncs(struct btf *btf, const char *func_name,
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
@@ -9822,7 +9832,8 @@ static int btf_check_kfunc_protos(struct btf *btf, u32 func_id, u32 func_flags)
 	if (!func || !btf_type_is_func_proto(func))
 		return -EINVAL;
 
-	if (func_flags & (KF_ITER_NEW | KF_ITER_NEXT | KF_ITER_DESTROY)) {
+	if (func_flags & (KF_ITER_NEW | KF_ITER_NEXT | KF_ITER_DESTROY |
+			  KF_ITER_RET_INDEPENDENT)) {
 		err = btf_check_iter_kfuncs(btf, func_name, func, func_flags);
 		if (err)
 			return err;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 5601d20562186..19ec9c07c35b9 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -211,6 +211,10 @@ static int acquire_reference(struct bpf_verifier_env *env, int insn_idx, int par
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
@@ -793,8 +797,8 @@ static int mark_stack_slots_dynptr(struct bpf_verifier_env *env, struct bpf_reg_
 		if (err)
 			return err;
 
-		/* Track parent's id if the parent is a referenced object */
-		parent_id = ref_obj->id;
+		/* All non-clone constructors take their backing object in R1. */
+		parent_id = reg_lifetime_id(env, &cur_regs(env)[BPF_REG_1]);
 
 		if (dynptr_type_referenced(type)) {
 			int id;
@@ -1074,7 +1078,7 @@ static int unmark_stack_slots_iter(struct bpf_verifier_env *env,
 				   struct bpf_reg_state *reg, int nr_slots)
 {
 	struct bpf_func_state *state = bpf_func(env, reg);
-	int spi, i, j;
+	int spi, i, j, err;
 
 	spi = iter_get_spi(env, reg, nr_slots);
 	if (spi < 0)
@@ -1084,8 +1088,11 @@ static int unmark_stack_slots_iter(struct bpf_verifier_env *env,
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
 
@@ -1627,6 +1634,12 @@ static bool reg_is_referenced(struct bpf_verifier_env *env, const struct bpf_reg
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
@@ -6848,9 +6861,14 @@ static int check_ptr_to_btf_access(struct bpf_verifier_env *env,
 		flag &= ~PTR_MAYBE_NULL;
 
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
@@ -8636,6 +8654,21 @@ static bool is_iter_destroy_kfunc(struct bpf_call_arg_meta *meta)
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
@@ -8746,6 +8779,14 @@ static int process_iter_arg(struct bpf_verifier_env *env, struct bpf_reg_state *
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
@@ -11073,8 +11114,25 @@ static int idstack_pop(struct bpf_idmap *idmap)
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
@@ -11082,14 +11140,15 @@ static int release_reference(struct bpf_verifier_env *env, int id)
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
@@ -11099,19 +11158,15 @@ static int release_reference(struct bpf_verifier_env *env, int id)
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
@@ -11145,6 +11200,16 @@ static int release_reference(struct bpf_verifier_env *env, int id)
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
@@ -15822,6 +15887,8 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 			regs[BPF_REG_0].btf = desc_btf;
 			regs[BPF_REG_0].type = type;
 			regs[BPF_REG_0].btf_id = ptr_type_id;
+			if (iter_next_borrows_struct(&meta) && !(type & MEM_RCU))
+				regs[BPF_REG_0].parent_id = meta.ref_obj.id;
 		}
 
 		if (is_kfunc_ret_null(&meta)) {
-- 
2.43.0

