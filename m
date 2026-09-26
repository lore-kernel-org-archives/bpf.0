Received: from mail-pj2-f42.google.com (mail-pj2-f42.google.com [74.125.227.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC14E477E4D
	for <bpf@vger.kernel.org>; Sat, 26 Sep 2026 14:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790432472; cv=none; b=b/jx4e3M7loWjx6Mdidf3eu2cgp+kxlajJKo8GiKC8nc1mvpkQXbxxLZAg974fHh6wrTDkd6y+db1z1CD8WwAmfsUxeGV7JcLFRsqwR39sefiOHsCKvF5NTNmpIHtDozo4YfVjzzSolOPHHY62QSbob8P5s2mP9e72LmKDS06y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790432472; c=relaxed/simple;
	bh=oJuqNTjxwTWCCAuxE6RjsXQbdHtqp60tYhxJ4Fei7C0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U0oVUfNfHTvFcD2GY11aPhgXxHo7B8wPAsxZTe97wHFiGO3hSeR6csPvnB09gqAJSUz4vrCc10rA34wZGCdwe9Kd1jRWAL9MwYzASLoTVF1A4Y2hNCME3j3jClD8I6sasNsOes6SSlMgn+agtpmTVRm4i5TO8Eh4JJeU0kn3tHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SPvqaqjU; arc=none smtp.client-ip=74.125.227.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SPvqaqjU"
Received: by mail-pj2-f42.google.com with SMTP id 98e67ed59e1d1-398cb5615deso1454326a91.3
        for <bpf@vger.kernel.org>; Sat, 26 Sep 2026 07:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790432470; x=1791037270; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=P2cwOxGe7TWDTeZHTxfd+FbrITLrBB0nMZzvMOBnMck=;
        b=SPvqaqjUM7ifpRL49VvcCf80Uy6037B8DkZ9JaLmJSmzDwKVw+bPqrQEdm1GlCZPT8
         DWAbzFM58rRIdWzf3E/MqKNA85DuXPGCfnmN+TUoTVCZPrXyPDj0lLM6yAz1qevzDyLi
         b6vRNsRL+jtCRAWyPNPZPPo1WxEPQ7uhHgqqZIYK8Sqi7DawPIabUulNlgezeapbBezx
         uR1XabKwXvcJmeNGedA6eP3ykPiA586p0RIcVbnYgBgMvR4lXjOleaQ35ZpexbYBVyLU
         xk4Qrq7rDW3WVe+Dsw2+ribn0CJ1wQgOENkIpy7hGbI0E7/N3oJu3CmbTqSEy2lEIiTY
         lNQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790432470; x=1791037270;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=P2cwOxGe7TWDTeZHTxfd+FbrITLrBB0nMZzvMOBnMck=;
        b=aAgcj8rfJmg6TDqAS4bJ0UcNiYt9kq+9FDE7ErVO+Ae0TxDBKIosab6a0l9HQf12u4
         AkCZZR4xuqFsDTwo/Vq1Qtbagt9AcwczEOs3Ijt9WzT7+fAaEE2Eg0KsfXTQ/UD4o6wU
         3T8Vh6NxJD6gXGHb5YJROfQ+tLckyue3Enqg8/C0O0MRwAK2M8S2D00aG+yLG4xqWsY4
         8x7R/FhuALWF+xudWGaXd7V9xvF70CvU6GT7O293tycSs7vQdKUpFAJNIKjmmZtgwvry
         sFy/EANqa+n7hKuIJXyR1xawzQiQchJZ5VqVCxiJtfemvhIM4tGDqaJ6e2X8t75JTj0o
         og9A==
X-Gm-Message-State: AFq9FYL5D/+fphVsXoOD49bKqpOw8y52PUOmZTpQe3l7M427lgQjfwTI
	MoHIcbE+tUoAZVz7dEej1SysNlP3F84mf+cT9g8CspeW7z2S7hVanyD2jeFeLy1tRzc=
X-Gm-Gg: AYBFou3fP2k9zi9YxYfwip5w3tBNhAt7IMm5kP8gl+5RaBd9wEb+AjyQabMJuh6r5oJ
	rT/6O+TxGc22AaJxdj1uLZ1mZXFCmcK9ehSntz0PSPufE4h6uicvCeS35VINnHnOuxw7JBvmblj
	bUKO9hyZRwlMY1r6O3XfL7r23dcXZFUWIvEd1H4C6paUrDxsoYunvkIFHs9O/NoXgwnmDvcdHNy
	+YQnlD4GzCO+MB35VMO5h72pA8GCS4Ia9fsrzZVBnaUJMewVl6J03x5J+hC+wA1S1JoCYRHrIAZ
	YuZP/3TAH11WvKQf8o6d6CDWKhAAdHACfwkR32DZCZVAGOkBJumKQX7o1h2qzi7lSXw2Xk1Z2Xg
	sGJ20TDLbx1FHeVS/y4V17+7K29cw3Co5a6QAEt6zfaHeiWJZi2POFwvp7QTvuetiS7qQdEFxv/
	rzrVDF5UEZy0sjbFLj1AatMY2Tm1NAHtem5ojS2I1Qd/M8gx7fIeOJZOsz3H9ZOLAAX3P8Y6MRs
	tCifUqH9D9ZgNYqB62VkDRU0jGnnzryetsbA2bh5eY=
X-Received: by 2002:a17:90b:39c7:b0:3a0:d7e4:c4aa with SMTP id 98e67ed59e1d1-3a0d7e4c553mr2557311a91.61.1790432470027;
        Sat, 26 Sep 2026 07:21:10 -0700 (PDT)
Received: from ezingerman-fedora-PF4V722J ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0c2e986easm10949613a91.1.2026.09.26.07.21.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 07:21:09 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org
Cc: daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next 26/36] bpf: avoid widening registers that hinder exact stack-slot tracking
Date: Sat, 26 Sep 2026 07:20:24 -0700
Message-ID: <20260926-scev-minimal-rebase-v1-26-c8e5ab5ba79f@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260926-scev-minimal-rebase-v1-0-c8e5ab5ba79f@gmail.com>
References: <20260926-scev-minimal-rebase-v1-0-c8e5ab5ba79f@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

For loops like this:

  int arr[10];
  for (int i = 0; i < 10; i++)
    arr[i] = i;
  use(arr[i]);

SCEV-based loop widening converts `i` from being enumerated 10 times
as a constant value 0, 1, ..., 9 to being enumerated once as a range
[0..9]. From the point of view of the main verification pass, this
replaces constant-offset stack access with varying-offset
stack access.

The verifier tracks stack values accessed through varying offsets much
less precisely than those accessed via constant offsets.
For example, the read at use(arr[i]) would yield STACK_MISC.
Precision might be lost for the following operations:
- spills (BPF_ST/STX to the stack): stored value can no longer be
  recovered when read back, e.g. after the loop;
- fills (BPF_LDX from the stack): a varying-offset read of a spilled
  pointer yields a SCALAR_VALUE, so the pointer is lost.
- calls that construct objects on the stack (dynptr, iter, irq_flag,
  res_spin_lock): the stack argument is required to have a
  constant offset.

This commit adds logic to avoid widening registers used by
such instructions:
- During the main SCEV computation stage, collect_store_base_regs():
  - inspects instructions accessing the stack (spill, fill, call to a
    function listed in bpf_needs_fixed_stack_off), and
  - if there is a SCEV expression for a stack base address register,
    records which registers the expression depends on in
    the bpf_loop->store_base_reg field.
- `store_base_reg`s accumulated for nested loops are propagated
  to outer loops as well.
- During the loop-widening stage, bpf_widen_scev_regs() refuses to widen a
  loop when some of the registers the loop changes appear in
  store_base_regs.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 include/linux/bpf_verifier.h | 10 ++++++
 kernel/bpf/scev.c            | 84 +++++++++++++++++++++++++++++++++++++++++---
 kernel/bpf/verifier.c        | 40 +++++++++++++++++++++
 3 files changed, 129 insertions(+), 5 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index c0eea472949d..a5fa2b5cc0c0 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -692,6 +692,9 @@ struct bpf_loop_exit {
 	int to; /* instruction outside the loop */
 };
 
+/* SCEV/widening register space: r0..r10 plus every stack slot of a frame. */
+#define BPF_SCEV_REGS_NUM (MAX_BPF_REG + MAX_BPF_STACK_SLOTS)
+
 struct bpf_loop {
 	struct bpf_backedge backedges[MAX_BACKEDGES];
 	/* edges exiting from this loop, includes edges from nested loops */
@@ -701,6 +704,12 @@ struct bpf_loop {
 	bool irreducible;
 	bool backedges_overflow;
 	bool exits_overflow;
+	/*
+	 * Loop-entry registers used to compute stack addresses for loads,
+	 * stores and calls requiring fixed stack offsets, in this and nested
+	 * loops.
+	 */
+	unsigned long store_base_regs[BITS_TO_LONGS(BPF_SCEV_REGS_NUM)];
 };
 
 struct bpf_insn_aux_data {
@@ -1835,6 +1844,7 @@ int bpf_stack_liveness_init(struct bpf_verifier_env *env);
 void bpf_stack_liveness_free(struct bpf_verifier_env *env);
 int bpf_live_stack_query_init(struct bpf_verifier_env *env, struct bpf_verifier_state *st);
 const unsigned long *bpf_may_write_mask(struct bpf_verifier_env *env, u32 insn_idx);
+bool bpf_needs_fixed_stack_off(struct bpf_verifier_env *env, int insn_idx);
 bool bpf_stack_slot_alive(struct bpf_verifier_env *env, u32 frameno, u32 spi);
 int bpf_compute_live_registers(struct bpf_verifier_env *env);
 
diff --git a/kernel/bpf/scev.c b/kernel/bpf/scev.c
index 205bf8684c3d..1fa6b25a4f29 100644
--- a/kernel/bpf/scev.c
+++ b/kernel/bpf/scev.c
@@ -8,7 +8,7 @@
 #include <linux/tnum.h>
 #include <linux/overflow.h>
 
-#define REGS_NUM (MAX_BPF_REG + MAX_BPF_STACK_SLOTS)
+#define REGS_NUM BPF_SCEV_REGS_NUM
 #define UNKNOWN_EXPR_ID 0
 #define OPAQUE_EXPR_ID  1
 
@@ -1021,6 +1021,65 @@ static void reset_scevs_at_indirect_writes(struct bpf_verifier_env *env, struct
 	}
 }
 
+/* OR the loop-entry registers referenced by expr 'id' into 'mask'. */
+static void or_expr_regs(struct bpf_verifier_env *env, u32 id, unsigned long *mask)
+{
+	struct scev *scev = env->scev;
+	u32 order;
+
+	scev->stack_sz = 0;
+	expr_stack_push(scev, id);
+	while (expr_next(scev, &id, &order)) {
+		if ((order & PRE) && scev->exprs[id].op == REG)
+			__set_bit(scev->exprs[id].params[0], mask);
+	}
+}
+
+/* Mask of argument registers (R1..R5) a call at 'idx' passes by register. */
+static u16 call_params_mask(struct bpf_verifier_env *env, int idx)
+{
+	struct bpf_insn *insn = &env->prog->insnsi[idx];
+	struct bpf_call_summary cs;
+	int n = bpf_get_call_summary(env, insn, &cs) ? cs.arg_slot_cnt : MAX_BPF_FUNC_REG_ARGS;
+
+	return n ? GENMASK(BPF_REG_1 + n - 1, BPF_REG_1) : 0;
+}
+
+/*
+ * For instructions like:
+ * - *(u64 *)(rBase + off) = rX
+ * - rX = *(u64 *)(rBase + off)
+ * - calls that construct objects on stack (e.g. dynptr_from_mem(rBase, ...))
+ * When 'rBase' can be a stack pointer and is derived from some registers Rs
+ * defined at loop entry, record Rs into 'mask'.
+ */
+static void collect_store_base_regs(struct bpf_verifier_env *env,
+				    struct env *cur_env, int idx, unsigned long *mask)
+{
+	struct bpf_insn_aux_data *aux = env->insn_aux_data;
+	struct bpf_insn *insn = &env->prog->insnsi[idx];
+	u8 class = BPF_CLASS(insn->code);
+	u8 size = BPF_SIZE(insn->code);
+	u16 base_regs = 0;
+	u32 r;
+
+	if (size == BPF_W || size == BPF_DW) {
+		if ((class == BPF_STX || class == BPF_ST) && insn->dst_reg != BPF_REG_FP)
+			base_regs |= BIT(insn->dst_reg);
+		else if (class == BPF_LDX && insn->src_reg != BPF_REG_FP)
+			base_regs |= BIT(insn->src_reg);
+	}
+
+	if (class == BPF_JMP && BPF_OP(insn->code) == BPF_CALL &&
+	    bpf_needs_fixed_stack_off(env, idx))
+		base_regs |= call_params_mask(env, idx);
+
+	base_regs &= aux[idx].stack_ptrs;
+	for (r = 0; r < MAX_BPF_REG; r++)
+		if (base_regs & BIT(r))
+			or_expr_regs(env, cur_env->reg2expr[r], mask);
+}
+
 /* Find the topmost loop header containing idx inside cur_header, or -1 if none. */
 static int topmost_nested_loop(struct bpf_verifier_env *env, int idx, int cur_header)
 {
@@ -1099,6 +1158,7 @@ static int compute_scev_for_loop(struct bpf_verifier_env *env, int cur_header)
 	struct bpf_iarray *succ;
 	bool log_level2 = env->log.level & BPF_LOG_LEVEL2;
 	int s, i, err, idx, succ_idx;
+	u32 r;
 
 	if (log_level2)
 		bpf_log(&env->log, "Computing SCEV for loop at %d:\n", cur_header);
@@ -1112,6 +1172,7 @@ static int compute_scev_for_loop(struct bpf_verifier_env *env, int cur_header)
 		if (!header_env)
 			return -ENOMEM;
 		/* The freshly allocated environment has all expressions unknown. */
+		bitmap_fill(cur_loop->store_base_regs, REGS_NUM);
 		header_env->empty = false;
 		return 0;
 	}
@@ -1146,6 +1207,9 @@ static int compute_scev_for_loop(struct bpf_verifier_env *env, int cur_header)
 			 */
 			if (log_level2)
 				memcpy(old_env, cur_env, sizeof(*old_env));
+			/* Pull the nested loop's stack-store base dependencies up. */
+			for_each_set_bit(r, nested_loop->store_base_regs, BPF_SCEV_REGS_NUM)
+				or_expr_regs(env, cur_env->reg2expr[r], cur_loop->store_base_regs);
 			nested_header_env = find_header_env(scev, idx);
 			forget_non_invariants(scev, cur_env, nested_header_env);
 			if (log_level2)
@@ -1168,6 +1232,7 @@ static int compute_scev_for_loop(struct bpf_verifier_env *env, int cur_header)
 			for (;;) {
 				if (log_level2)
 					memcpy(old_env, cur_env, sizeof(*old_env));
+				collect_store_base_regs(env, cur_env, idx, cur_loop->store_base_regs);
 				err = transfer(env, cur_env, idx);
 				if (err)
 					goto out;
@@ -1975,6 +2040,7 @@ int bpf_compute_loop_iters(struct bpf_verifier_env *env, struct bpf_verifier_sta
 	for (r = 0; r < REGS_NUM; r++) {
 		struct bpf_reg_state *reg;
 		u32 ra, r_scev, r_expr;
+		bool spill_base = false;
 
 		if (!scev_reg_alive(env, st, r))
 			continue;
@@ -1984,10 +2050,16 @@ int bpf_compute_loop_iters(struct bpf_verifier_env *env, struct bpf_verifier_sta
 		/* If SCEV for r is (linear <reg> <slope>) */
 		if (is_simple_linear(scev, r_scev, &base_reg, &slope_imm) &&
 		    is_widenable_reg_type(reg)) {
-			/* Can't widen if the iteration range overflows */
-			if (base_reg == r &&
-			    !linear_bounds(reg, iters, slope_imm, &bounds))
-				goto cant_widen;
+			if (base_reg == r) {
+				/* Can't widen if the iteration range overflows */
+				if (!linear_bounds(reg, iters, slope_imm, &bounds))
+					goto cant_widen;
+				/* Spills at varying offsets lose precision */
+				if (test_bit(r, loop->store_base_regs)) {
+					spill_base = true;
+					goto cant_widen;
+				}
+			}
 			continue;
 		}
 
@@ -2006,6 +2078,8 @@ int bpf_compute_loop_iters(struct bpf_verifier_env *env, struct bpf_verifier_sta
 			log_reg(env, r);
 			bpf_log(log, ", expr is ");
 			log_expr(env, r_expr);
+			if (spill_base)
+				bpf_log(log, ", requires exact stack-offset tracking");
 			bpf_log(log, "\n");
 		}
 		return 0;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 9f56ffe09eba..327bfc00da5f 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -14087,6 +14087,46 @@ static bool kfunc_spin_allowed(struct bpf_verifier_env *env, s32 func_id, s16 of
 	return *kfunc.flags & KF_SPINLOCK_SAFE;
 }
 
+/*
+ * True if insn calls a helper/kfunc that requires one of its arguments to
+ * be a stack pointer with a constant offset.
+ */
+bool bpf_needs_fixed_stack_off(struct bpf_verifier_env *env, int insn_idx)
+{
+	const struct bpf_insn *insn = &env->prog->insnsi[insn_idx];
+	u32 *flags, btf_id;
+
+	if (bpf_helper_call(insn)) {
+		return insn->imm == BPF_FUNC_dynptr_from_mem ||
+		       insn->imm == BPF_FUNC_ringbuf_reserve_dynptr;
+	}
+
+	/* vmlinux kfuncs only */
+	if (!bpf_pseudo_kfunc_call(insn) || insn->off != 0)
+		return false;
+	btf_id = insn->imm;
+
+	flags = btf_kfunc_flags(btf_vmlinux, btf_id, env->prog);
+	if (flags && (*flags & (KF_ITER_NEW | KF_ITER_NEXT | KF_ITER_DESTROY)))
+		return true;
+
+	if (btf_id == special_kfunc_list[KF_bpf_res_spin_lock] ||
+	    btf_id == special_kfunc_list[KF_bpf_res_spin_unlock] ||
+	    btf_id == special_kfunc_list[KF_bpf_res_spin_lock_irqsave] ||
+	    btf_id == special_kfunc_list[KF_bpf_res_spin_unlock_irqrestore] ||
+	    btf_id == special_kfunc_list[KF_bpf_local_irq_save] ||
+	    btf_id == special_kfunc_list[KF_bpf_local_irq_restore])
+		return true;
+
+	if (btf_id == special_kfunc_list[KF_bpf_dynptr_from_skb] ||
+	    btf_id == special_kfunc_list[KF_bpf_dynptr_from_xdp] ||
+	    btf_id == special_kfunc_list[KF_bpf_dynptr_from_skb_meta] ||
+	    btf_id == special_kfunc_list[KF_bpf_dynptr_from_file])
+		return true;
+
+	return false;
+}
+
 static bool is_sync_callback_calling_kfunc(u32 btf_id)
 {
 	return is_bpf_rbtree_add_kfunc(btf_id);

-- 
2.55.0
