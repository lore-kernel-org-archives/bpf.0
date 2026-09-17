Received: from ustc.edu.cn (smtp.ustc.edu.cn [202.38.64.46])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6D3A3F4829
	for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 05:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.38.64.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789622415; cv=none; b=YevLpOalDXeAphAbZAaj7OLw/8PrHC/d5ycUqh5JX3IvHyOYziifPU/NlWbeOjbN7FFsTTDshF0dTLnap0OQ8QxCtVj0ZIZCUIN7iIIHki2HhjpGn3JYHX3GrzWd2SNv5g/5rDqBvTYzy0rns08/NtBUxGYeQod3pfyoOID+AbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789622415; c=relaxed/simple;
	bh=UcAgFsYJ8z2aS2TnlgZD3hVdhhVdinT/Es+ic1mjM0A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FlqPU/qsmTDjXfK45pIgp2esu5ax7ZPdX/nJFXJqR2WbpaBCQM9jm08XWz9cyrYOxmggXTevJwMk0yLL6krTgEEpudv4tEykEtK/oeh7tvkmRR24bUcVg0q1g4RGVsUVVxy37KE0IxBDbeeoZDvXRgCO2dsxSAKMOnxuuEhUIrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.ustc.edu.cn; spf=pass smtp.mailfrom=mail.ustc.edu.cn; dkim=pass (1024-bit key) header.d=mail.ustc.edu.cn header.i=@mail.ustc.edu.cn header.b=etl5jW45; arc=none smtp.client-ip=202.38.64.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.ustc.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.ustc.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mail.ustc.edu.cn header.i=@mail.ustc.edu.cn header.b="etl5jW45"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mail.ustc.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-ID:In-Reply-To:References:MIME-Version:
	Content-Transfer-Encoding; bh=zhAvH9sPSLLfCE6NrB4dSHf7FfY7pUr7hk
	1YYaO1Sxg=; b=etl5jW45RJtPczugFqi6aFDtToAuR+DMCj+a+QGniHftTkhW61
	85p7CP2dNo3VWOqivxsM1mz4sTxviec8lqNKyO7ujHjb3+ZwLVXgKCWQOkadQvdr
	xl7Kv2AYSjADZXaHEyiIzep/66rMgJb4Dkx6i0xWeJdwIZ+xIzT8kSWNs=
Received: from localhost (unknown [222.195.81.43])
	by mailimap2024 (Coremail) with SMTP id 3pYKCgAnIil6eKtq4aYqAQ--.2831S2;
	Thu, 17 Sep 2026 13:19:54 +0800 (CST)
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
Subject: [PATCH bpf-next v4 1/2] bpf: Track iterator-owned BTF pointer lifetimes
Date: Thu, 17 Sep 2026 13:19:47 +0800
Message-ID: <20260917051948.1588826-2-xyx2021@mail.ustc.edu.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260917051948.1588826-1-xyx2021@mail.ustc.edu.cn>
References: <20260917051948.1588826-1-xyx2021@mail.ustc.edu.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:3pYKCgAnIil6eKtq4aYqAQ--.2831S2
X-Coremail-Antispam: 1UD129KBjvJXoWxtryrZw13uw1kJr4DGFWDCFg_yoW3Kr17pF
	4kK3yDtr4kAF47WrsrAF1DZr9Y9FyIq3y3Cry8G3ySyF1rXrn8JFyvg34jva13AFWkGw17
	Aw40va98Xw47JFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9ab7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I
	8E87Iv6xkF7I0E14v26rxl6s0DM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x2
	0xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17Mc
	Ij6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l
	c7CjxVAaw2AFwI0_Jw0_GFylc2xSY4AK67AK6r4rMxAIw28IcxkI7VAKI48JMxC20s026x
	CaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_
	JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r
	1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_
	Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8Jr
	UvcSsGvfC2KfnxnUUI43ZEXa7IU5ynQ5UUUUU==
X-CM-SenderInfo: h010jiysr6zt1loo32lwfovvfxof0/

Non-RCU struct iterator results borrow their lifetime from the iterator's
current element. Associate these PTR_TO_BTF_ID results with the iterator
reference and invalidate the previous result when processing the next
iterator argument. This applies before modeling either next outcome;
destroy continues to invalidate the result through reference release.

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
 kernel/bpf/verifier.c | 88 +++++++++++++++++++++++++++++++++++--------
 1 file changed, 73 insertions(+), 15 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 6c6b8d8520cdf..3d47487233b75 100644
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
@@ -6219,9 +6231,14 @@ static int check_ptr_to_btf_access(struct bpf_verifier_env *env,
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
@@ -7817,6 +7834,27 @@ static bool is_kfunc_arg_iter(struct bpf_call_arg_meta *meta, int arg_idx,
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
+	/* Struct iterators can release their previous element on next. */
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
@@ -7914,6 +7952,13 @@ static int process_iter_arg(struct bpf_verifier_env *env, struct bpf_reg_state *
 		meta->iter.frameno = reg->frameno;
 		update_ref_obj(&meta->ref_obj, &state->stack[spi].spilled_ptr);
 
+		if (bpf_is_iter_next_kfunc(meta) &&
+		    !(state->stack[spi].spilled_ptr.type & MEM_RCU)) {
+			err = invalidate_iter_owned_btf_ptrs(env, meta->ref_obj.id);
+			if (err)
+				return err;
+		}
+
 		if (is_iter_destroy_kfunc(meta)) {
 			err = unmark_stack_slots_iter(env, reg, nr_slots);
 			if (err)
@@ -10088,6 +10133,23 @@ static int idstack_pop(struct bpf_idmap *idmap)
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
@@ -10097,7 +10159,7 @@ static int release_reference(struct bpf_verifier_env *env, int id)
 	struct bpf_stack_state *stack;
 	struct bpf_func_state *state;
 	struct bpf_reg_state *reg;
-	int i, err;
+	int err;
 
 	idstack->cnt = 0;
 	err = idstack_push(idstack, id);
@@ -10114,15 +10176,9 @@ static int release_reference(struct bpf_verifier_env *env, int id)
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
@@ -14446,6 +14502,8 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 			regs[BPF_REG_0].btf = desc_btf;
 			regs[BPF_REG_0].type = type;
 			regs[BPF_REG_0].btf_id = ptr_type_id;
+			if (bpf_is_iter_next_kfunc(&meta) && !(type & MEM_RCU))
+				regs[BPF_REG_0].parent_id = meta.ref_obj.id;
 		}
 
 		if (is_kfunc_ret_null(&meta)) {
-- 
2.43.0

