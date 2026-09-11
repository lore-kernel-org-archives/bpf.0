Received: from ustc.edu.cn (smtp.ustc.edu.cn [202.38.64.46])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77D5E46DFE7
	for <bpf@vger.kernel.org>; Fri, 11 Sep 2026 08:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.38.64.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789116186; cv=none; b=QUMIZ4r9ij6o6roi6OnWJTiQfMK/XX7Jlp91b7WaOlk1mO4pZXvrg+hk18EVUqjpnf5D9m1MHaAZQoZ+TDI6lklZ4FliICAIX4k/p37770H/ngjYrcSM4FbpdAxpyRGEsuytIfNqz8OLnBJxYC4dDWr7CjKGu4+rDuWnz38lQnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789116186; c=relaxed/simple;
	bh=xGoCuHo7mUQPDlmsqurPa1B3XkoCPGMyc0yg9T6bD/c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LsCcsL3GXz2W1lWeA85X2hcyPH+/hQGutnRFklFrbCvYf3Wrg7yWuptc2EK6Cjpfb9LKYP0D7ArCJjVubaK45569/bck+P+8Cd6HagLVhv93IefRDXeQ03EcKO+F4M9IRZPKgM6XfTMk+vn06dCEL/+MPREV9aPXRoxA78ye2Ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.ustc.edu.cn; spf=pass smtp.mailfrom=mail.ustc.edu.cn; dkim=pass (1024-bit key) header.d=mail.ustc.edu.cn header.i=@mail.ustc.edu.cn header.b=o+dcgZEf; arc=none smtp.client-ip=202.38.64.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.ustc.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.ustc.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mail.ustc.edu.cn header.i=@mail.ustc.edu.cn header.b="o+dcgZEf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mail.ustc.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-ID:In-Reply-To:References:MIME-Version:
	Content-Transfer-Encoding; bh=xzxgUgmrWni180JWr5nLwUS0QOxdA0fFbq
	Wot3NtMVk=; b=o+dcgZEfQ7xip55/bbTCSrYkaNN9TX4pSr7I0cdvsmOACx29CD
	GEdpgdtWhPwXTg+pIHG1szkgqsH20RAGYtoyYYp25Lk3u16bbxrsU40G1+ymhiX/
	FZQ/PWGpraK651eO4P/9Qio/LJP3XWNRmyLAJmKryYq0yLwjZ9yRN1nSE=
Received: from localhost (unknown [222.195.81.105])
	by mailimap2024 (Coremail) with SMTP id 3pYKCgDn5i0Sv6Nqu+8GAQ--.885S2;
	Fri, 11 Sep 2026 16:42:58 +0800 (CST)
From: Xu Yunxiang <xyx2021@mail.ustc.edu.cn>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Amery Hung <ameryhung@gmail.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Puranjay Mohan <puranjay@kernel.org>
Subject: [PATCH bpf v3 1/2] bpf: Invalidate iterator-owned BTF pointers on next and destroy
Date: Fri, 11 Sep 2026 16:42:53 +0800
Message-ID: <20260911084254.3481508-2-xyx2021@mail.ustc.edu.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260911084254.3481508-1-xyx2021@mail.ustc.edu.cn>
References: <20260911084254.3481508-1-xyx2021@mail.ustc.edu.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:3pYKCgDn5i0Sv6Nqu+8GAQ--.885S2
X-Coremail-Antispam: 1UD129KBjvJXoWxKw43uFWrGrWrJF4xKw47twb_yoWfKF18pF
	s7WrWDtF4kAF40grsrAa1DAryF9rW0q3y3Cry8K34fCF1rGryDAFy0gryYvF45AFWkGw17
	Aw40va98ZayUJFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Sb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwV
	C2z280aVCY1x0267AKxVW0oVCq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x0
	82IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUAVWUtw
	Av7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48J
	MxkF7I0En4kS14v26r1q6r43MxkIecxEwVAFwVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxV
	CFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r10
	6r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxV
	WUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG
	6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr
	1UYxBIdaVFxhVjvjDU0xZFpf9x07bwzuZUUUUU=
X-CM-SenderInfo: h010jiysr6zt1loo32lwfovvfxof0/

Open-coded iterator next kfuncs that return non-struct pointers associate
the returned PTR_TO_MEM with the iterator's reference ID. Struct pointer
returns take a separate PTR_TO_BTF_ID path which omits this relationship.

This leaves such pointers verifier-valid after their lifetime ends. The
task_vma iterator resets its VMA snapshot and drops the previous vm_file
reference when next advances, then frees the snapshot on destroy. Other
non-RCU struct iterators also release or replace their previous element on
advance.

A trusted field derived from an iterator result can also back a
resource-tracked object. In particular, bpf_dynptr_from_file() does not
take its own file reference. Losing vm_file's iterator parent while
constructing a FILE dynptr therefore lets the dynptr outlive the snapshot's
file reference.

Associate non-RCU PTR_TO_BTF_ID results with the iterator reference. Before
modeling another next result, invalidate older BTF pointers carrying that
parent. Do this before constructing R0 and for both the ACTIVE and DRAINED
iterator branches. The existing iterator reference release invalidates the
current result on destroy.

Preserve the parent across BTF field loads when the result remains fully
trusted and its lifetime is tied to the parent. Do not propagate it to
MEM_RCU, MEM_PERCPU, MEM_USER, or untrusted results, whose lifetime or
access domain follows separate rules.

When bpf_dynptr_from_file() consumes a borrowed file carrying such a
parent, use that parent as the FILE dynptr's lifetime anchor. Reject
iterator next or destroy while a resource child remains live, requiring
the program to discard the dynptr before its backing file can be released.

This issue was found during BPF verifier testing with an in-house runtime
semantic checker.

Fixes: 4cbee026db54 ("bpf: return VMA snapshot from task_vma iterator")
Suggested-by: Amery Hung <ameryhung@gmail.com>
Link: https://lore.kernel.org/bpf/CAMB2axMV4rZ_Mb91OdzGH6T4Yym7nB+wz+EtxP_wUEniwA+EzA@mail.gmail.com
Assisted-by: LLM
Signed-off-by: Xu Yunxiang <xyx2021@mail.ustc.edu.cn>
---
 include/linux/bpf_verifier.h |   6 +-
 kernel/bpf/verifier.c        | 110 ++++++++++++++++++++++++++++-------
 2 files changed, 92 insertions(+), 24 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 36b65797877d0..ae30df629d5b3 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -1518,9 +1518,9 @@ struct bpf_dynptr_desc {
 
 /*
  * The last seen rereferenced object; Updated by update_ref_obj() when a register refers to a
- * referenced object. Used when the helper or kfunc is casting a referenced object, returning
- * allocated memory derived from referenced object or creating a dynptr with a referenced
- * object as parent.
+ * referenced object or another verifier-tracked lifetime anchor. Used when the helper or kfunc
+ * is casting a referenced object, returning allocated memory derived from a referenced object
+ * or creating a dynptr whose backing object has a tracked lifetime.
  */
 struct ref_obj_desc {
 	u32 id;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 72a3f5998dd27..eb013954182f2 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -238,13 +238,18 @@ static void bpf_map_key_store(struct bpf_insn_aux_data *aux, u64 state)
 			     (poisoned ? BPF_MAP_KEY_POISON : 0ULL);
 }
 
-static void update_ref_obj(struct ref_obj_desc *ref_obj, struct bpf_reg_state *reg)
+static void update_ref_obj_id(struct ref_obj_desc *ref_obj, u32 id, u32 parent_id)
 {
-	ref_obj->id = reg->id;
-	ref_obj->parent_id = reg->parent_id;
+	ref_obj->id = id;
+	ref_obj->parent_id = parent_id;
 	ref_obj->cnt++;
 }
 
+static void update_ref_obj(struct ref_obj_desc *ref_obj, struct bpf_reg_state *reg)
+{
+	update_ref_obj_id(ref_obj, reg->id, reg->parent_id);
+}
+
 static int validate_ref_obj(struct bpf_verifier_env *env, struct ref_obj_desc *ref_obj)
 {
 	if (ref_obj->cnt > 1) {
@@ -977,7 +982,7 @@ static int unmark_stack_slots_iter(struct bpf_verifier_env *env,
 				   struct bpf_reg_state *reg, int nr_slots)
 {
 	struct bpf_func_state *state = bpf_func(env, reg);
-	int spi, i, j;
+	int spi, i, j, err;
 
 	spi = iter_get_spi(env, reg, nr_slots);
 	if (spi < 0)
@@ -987,8 +992,11 @@ static int unmark_stack_slots_iter(struct bpf_verifier_env *env,
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
 
@@ -6140,9 +6148,16 @@ static int check_ptr_to_btf_access(struct bpf_verifier_env *env,
 	}
 
 	if (atype == BPF_READ && value_regno >= 0) {
-		ret = mark_btf_ld_reg(env, regs, value_regno, ret, reg->btf, btf_id, flag);
+		enum bpf_reg_type reg_type = ret;
+		u32 parent_id = reg->parent_id;
+
+		ret = mark_btf_ld_reg(env, regs, value_regno, reg_type,
+				      reg->btf, btf_id, flag);
 		if (ret < 0)
 			return ret;
+		if ((regs[value_regno].type & PTR_TRUSTED) &&
+		    !(regs[value_regno].type & (MEM_RCU | MEM_PERCPU | MEM_USER)))
+			regs[value_regno].parent_id = parent_id;
 	}
 
 	return 0;
@@ -9456,6 +9471,24 @@ static int idstack_pop(struct bpf_idmap *idmap)
 	return idmap->map[--idmap->cnt].old;
 }
 
+static int check_reference_children(struct bpf_verifier_env *env, int parent_id)
+{
+	struct bpf_verifier_state *vstate = env->cur_state;
+	int i;
+
+	for (i = 0; i < vstate->acquired_refs; i++) {
+		if (vstate->refs[i].type != REF_TYPE_PTR)
+			continue;
+		if (vstate->refs[i].parent_id != parent_id)
+			continue;
+		verbose(env, "Leaking reference id=%d alloc_insn=%d. Release it first.\n",
+			vstate->refs[i].id, vstate->refs[i].insn_idx);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 /* Release id and objects derived from it iteratively in a DFS manner */
 static int release_reference(struct bpf_verifier_env *env, int id)
 {
@@ -9465,31 +9498,25 @@ static int release_reference(struct bpf_verifier_env *env, int id)
 	struct bpf_stack_state *stack;
 	struct bpf_func_state *state;
 	struct bpf_reg_state *reg;
-	int i, err;
+	int err;
 
 	idstack->cnt = 0;
 	err = idstack_push(idstack, id);
 	if (err)
 		return err;
 
-	if (find_reference_state(vstate, id)) {
-		err = release_reference_nomark(env, id);
-		WARN_ON_ONCE(err);
-	}
-
 	while ((id = idstack_pop(idstack))) {
 		/*
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
+		err = check_reference_children(env, id);
+		if (err)
+			return err;
+
+		if (find_reference_state(vstate, id)) {
+			err = release_reference_nomark(env, id);
+			WARN_ON_ONCE(err);
 		}
 
 		bpf_for_each_reg_in_vstate_mask(vstate, state, reg, stack, mask, ({
@@ -9541,6 +9568,33 @@ static void invalidate_non_owning_refs(struct bpf_verifier_env *env)
 	}));
 }
 
+static int invalidate_iter_owned_btf_ptrs(struct bpf_verifier_env *env, u32 parent_id)
+{
+	struct bpf_func_state *unused;
+	struct bpf_reg_state *reg;
+	int err;
+
+	if (WARN_ON_ONCE(!parent_id))
+		return -EFAULT;
+
+	err = check_reference_children(env, parent_id);
+	if (err)
+		return err;
+
+	/*
+	 * Struct iterators can release the previous element on each next call.
+	 * PTR_TO_MEM iterator results use storage that remains valid until destroy.
+	 */
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
 static void invalidate_rcu_protected_refs(struct bpf_verifier_env *env)
 {
 	struct bpf_stack_state *stack;
@@ -13100,6 +13154,10 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_call_arg_me
 				ret = process_kf_arg_ptr_to_btf_id(env, reg, ref_t, ref_tname, ref_id, meta, i, argno);
 				if (ret < 0)
 					return ret;
+				if (meta->btf == btf_vmlinux &&
+				    meta->func_id == special_kfunc_list[KF_bpf_dynptr_from_file] &&
+				    i == 0 && !reg_is_referenced(env, reg) && reg->parent_id)
+					update_ref_obj_id(&meta->ref_obj, reg->parent_id, 0);
 				break;
 			}
 
@@ -13995,6 +14053,13 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 		}
 	}
 
+	if (bpf_is_iter_next_kfunc(&meta) &&
+	    !(get_iter_from_state(env->cur_state, &meta)->type & MEM_RCU)) {
+		err = invalidate_iter_owned_btf_ptrs(env, meta.ref_obj.id);
+		if (err)
+			return err;
+	}
+
 	bpf_diag_record_caller_saved(env, regs);
 	bpf_diag_mod_begin(env, &regs[BPF_REG_0], NULL, BPF_DIAG_MOD_WRITE);
 	for (i = 0; i < CALLER_SAVED_REGS; i++) {
@@ -14105,6 +14170,9 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 			regs[BPF_REG_0].btf = desc_btf;
 			regs[BPF_REG_0].type = type;
 			regs[BPF_REG_0].btf_id = ptr_type_id;
+
+			if (bpf_is_iter_next_kfunc(&meta) && !(type & MEM_RCU))
+				regs[BPF_REG_0].parent_id = meta.ref_obj.id;
 		}
 
 		if (is_kfunc_ret_null(&meta)) {
-- 
2.43.0

