Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 673514C6EEE
	for <bpf@vger.kernel.org>; Fri,  9 Oct 2026 10:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791542938; cv=none; b=SXAxKyRu4ThS5jKxSaWm/TG1HZxZrHttAHdYFa5JamN/KMy2wX05N3ODVCZYLw40aupqv7E/Ac5SuzdtrUfuX1USlJMSRXK6vVugsVrIZn4+oXAGVSg+NIj/CZ4xEs4e71GpvpR6dxwfnMzjw5WVoqktKSXfmbysxIZciH5YUyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791542938; c=relaxed/simple;
	bh=TXqD7cdGdIpkeIY9fwN0RsMe5MKRoiGfBoANdd1KWAs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I0/ZI2sTFFryGhUdG6rdXapH9ZxNQj0mCOa8e/g+I6F56eSF3HZjAKHsSZ8BZ8XxpwOnIw40idVgN59mW3jjPV12UwTnFGtjAXrZuejXSiLpMbG8x8EJgHSEeLDWkzNhc94uSJZGyv0K06s/g2eFM8pz2BaT/9ar3AfRW3cL+AM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DZ4QzC8Q; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DZ4QzC8Q"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2d6d28aa26cso30638715ad.2
        for <bpf@vger.kernel.org>; Fri, 09 Oct 2026 03:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791542924; x=1792147724; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=52/C6DOgM2JT0FyVOqWbYiTCDsM2f4k5RxV/n3yqRJ4=;
        b=DZ4QzC8Q9J0I5FkWFaAeYU5kp/YsOidfk6Ou0AdJYxQCh6v0toag6MR6kdlsJD/uN5
         KyjDVxudPUTWqZVBNKXkG2vOtUXVEGza3Bi3HnFBR7urDtZigmi5xTFV/WMtX/h1Unte
         48BlEdqdqN3XPkeYadqQk/LZsNkwf5XprkCRlzeYbW9X6XPmGj1/bsQH/VE70iTlnK9G
         eMvGtJSvU7PMwYU1JaWF0bUcd2t2Jw92jy4lwVEf7G9mtOdE65LIrm6JlqSeVgHzFzgy
         0Dpx4O4zdoxHfJJWaKWz9o6Fmj6fRCiOeyw+mDIcNQykyBP26gw4Xc1+JId1TXSpmbN5
         ptdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791542924; x=1792147724;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=52/C6DOgM2JT0FyVOqWbYiTCDsM2f4k5RxV/n3yqRJ4=;
        b=0ILlREHVfXz0B/WBdlb7qsIWgO1hkXIwy60sMrzSjeWSyuGVbzEGzaaYgF0mW6ZoKY
         xVsUO2JClUtbo03tcyA1yPiyqvblhO5lyPpV1s/AmTzAl/K/NK9II7P9VjH9j9d6gAWC
         SDzoo0jAxP2kMFeGGfL2PqvgFS4G7MIHGfZPyU2yaK6Rs/4WXF8Ta7NFTfLbL9Iijcny
         IFh1scDe/pn/hDXRNYXNGYmIQiccgAmXXNDGraHODixZ6aRQrLxWh9QchztDuOk0d/50
         PxdHCtsX2I0LgGlIK0JtNRJMJhgezk+0S8MUeor2fDE3g2fnN7rIRVet5tXooO4VLkJX
         tzoQ==
X-Gm-Message-State: AFq9FYLm5SJwMMX1kpyQuXvhc4HxbKE9UY5EhjVejilfl4jENJqZmXBM
	64UKvupvK7rRD9cyf756RaqzG1fDvDH3mJxqJaW07coF6VTOud6Kyys/XbnXBjx6
X-Gm-Gg: AYBFou2SmtywYkjAvY6LcnXIJsvDEwSLbUGhBKBwu2Sg1I/XDq+FbmKsl5+v1JIz3RL
	xlr8dZWG8sZY7yHJMQjCPP4B1eAiq+j0EYdDdtUIQW/j99gI/siNi3srnCLglwvAmoJbuhSMcjs
	u5YLnMTMOQ+6zSl/Yq8wh+r5S8mTBomTlSG1T/9kNfnjHqrT1IqI+QS5zSlfbhq+IWrWIJ2Ib8x
	1roiEQrCMJGRLiccanQx23cX+mYqW3HvQGJjSN7SejJx83T/RzSm9GfyPbyuE2Jw0/oRJPAkD9A
	YtQ4SwdmEPMLxhGKSv7j6GGCIlQ7FJ8DE3y9f3Fiw6zC/lI00pvaDA5bG4iA3TighoyhvM/Ml63
	D5BEpXvgpEibif4pcUikyncKeN6dWgGsaj6t9eUw4qIPyOBOQLe3fxXJYLhSf9wg+I85/TaiFcw
	nkRoOoRy9bd+XRxXHagLRRxC2Gqxzu8zxmeuEbrXxbCJ7DC4udu8eFUUVzeRBqztUKm8AQEfhXw
	VnB5TAcW42vYiQ=
X-Received: by 2002:a17:90b:4a90:b0:3a8:599b:23cc with SMTP id 98e67ed59e1d1-3ab3a9118b9mr1302790a91.15.1791542924448;
        Fri, 09 Oct 2026 03:48:44 -0700 (PDT)
Received: from badger ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ab36ed053csm3050107a91.4.2026.10.09.03.48.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 03:48:44 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v3 35/51] bpf: avoid widening registers that hinder exact stack-slot tracking
Date: Fri,  9 Oct 2026 03:47:53 -0700
Message-ID: <20261009-scev-minimal-rebase-v3-35-bcba9bc53ac9@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261009-scev-minimal-rebase-v3-0-bcba9bc53ac9@gmail.com>
References: <20261009-scev-minimal-rebase-v3-0-bcba9bc53ac9@gmail.com>
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
- During the loop-widening stage, bpf_compute_loop_iters() refuses to
  widen a loop when some of the registers the loop changes appear in
  store_base_regs.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 include/linux/bpf_verifier.h | 10 ++++++
 kernel/bpf/scev.c            | 86 ++++++++++++++++++++++++++++++++++++++++++--
 kernel/bpf/verifier.c        | 49 +++++++++++++++++++++++++
 3 files changed, 143 insertions(+), 2 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index d760d2283ac5..308e779c3f74 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -708,6 +708,9 @@ struct bpf_loop_exit {
 	int to; /* instruction outside the loop */
 };
 
+/* SCEV/widening register space: r0..r10 plus every stack slot of a frame. */
+#define BPF_SCEV_REGS_NUM (MAX_BPF_REG + MAX_BPF_STACK_SLOTS)
+
 struct bpf_loop {
 	struct bpf_backedge backedges[MAX_BACKEDGES];
 	/* edges exiting from this loop, includes edges from nested loops */
@@ -717,6 +720,12 @@ struct bpf_loop {
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
@@ -1876,6 +1885,7 @@ int bpf_stack_liveness_init(struct bpf_verifier_env *env);
 void bpf_stack_liveness_free(struct bpf_verifier_env *env);
 int bpf_live_stack_query_init(struct bpf_verifier_env *env, struct bpf_verifier_state *st);
 const unsigned long *bpf_may_write_mask(struct bpf_verifier_env *env, u32 insn_idx);
+bool bpf_needs_fixed_stack_off(struct bpf_verifier_env *env, int insn_idx);
 bool bpf_stack_slot_alive(struct bpf_verifier_env *env, u32 frameno, u32 spi);
 int bpf_compute_live_registers(struct bpf_verifier_env *env);
 
diff --git a/kernel/bpf/scev.c b/kernel/bpf/scev.c
index 05dd8e439609..adad32d8cb12 100644
--- a/kernel/bpf/scev.c
+++ b/kernel/bpf/scev.c
@@ -10,7 +10,7 @@
 #include <linux/tnum.h>
 #include <linux/overflow.h>
 
-#define REGS_NUM (MAX_BPF_REG + MAX_BPF_STACK_SLOTS)
+#define REGS_NUM BPF_SCEV_REGS_NUM
 #define UNKNOWN_EXPR_ID 0
 #define OPAQUE_EXPR_ID  1
 
@@ -1100,6 +1100,70 @@ static void reset_scevs_at_indirect_writes(struct bpf_verifier_env *env, struct
 	}
 }
 
+/*
+ * Collect loop-entry registers referenced by expr 'id', best effort.
+ * DEPTH_LIMIT may leave dependencies unrecorded. This mask only avoids
+ * widening that would lose stack-access precision; missing dependencies
+ * may cause false rejections, but this is not a soundness issue.
+ */
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
@@ -1184,6 +1248,7 @@ static int compute_scev_for_loop(struct bpf_verifier_env *env, int cur_header)
 	struct bpf_iarray *succ;
 	bool log_level2 = env->log.level & BPF_LOG_LEVEL2;
 	int s, i, err, idx, succ_idx;
+	u32 r;
 
 	if (log_level2)
 		bpf_log(&env->log, "Computing SCEV for loop at %d:\n", cur_header);
@@ -1197,6 +1262,7 @@ static int compute_scev_for_loop(struct bpf_verifier_env *env, int cur_header)
 		if (!header_env)
 			return -ENOMEM;
 		/* The freshly allocated environment has all expressions unknown. */
+		bitmap_fill(cur_loop->store_base_regs, REGS_NUM);
 		header_env->empty = false;
 		return 0;
 	}
@@ -1233,6 +1299,9 @@ static int compute_scev_for_loop(struct bpf_verifier_env *env, int cur_header)
 			 */
 			if (log_level2)
 				memcpy(old_env, cur_env, sizeof(*old_env));
+			/* Pull the nested loop's stack-store base dependencies up. */
+			for_each_set_bit(r, nested_loop->store_base_regs, BPF_SCEV_REGS_NUM)
+				or_expr_regs(env, cur_env->reg2expr[r], cur_loop->store_base_regs);
 			forget_non_invariants(env, cur_env, idx);
 			if (log_level2)
 				log_env_changes(env, LOG_AT_TRANSFER, old_env, cur_env, idx);
@@ -1254,6 +1323,7 @@ static int compute_scev_for_loop(struct bpf_verifier_env *env, int cur_header)
 			for (;;) {
 				if (log_level2)
 					memcpy(old_env, cur_env, sizeof(*old_env));
+				collect_store_base_regs(env, cur_env, idx, cur_loop->store_base_regs);
 				err = transfer(env, cur_env, idx);
 				if (err)
 					goto out;
@@ -2451,6 +2521,7 @@ int bpf_compute_loop_iters(struct bpf_verifier_env *env, struct bpf_verifier_sta
 	for (r = 0; r < REGS_NUM; r++) {
 		struct bpf_reg_state *reg;
 		u32 ra, r_scev, r_expr;
+		bool spill_base = false;
 
 		if (!scev_reg_alive(env, st, r))
 			continue;
@@ -2472,6 +2543,11 @@ int bpf_compute_loop_iters(struct bpf_verifier_env *env, struct bpf_verifier_sta
 		/* If SCEV for r is (linear <reg> <slope>) */
 		if (is_simple_linear(scev, r_scev, &base_reg, &slope_imm) &&
 		    reg && is_widenable_reg_type(reg)) {
+			/* Spills at varying offsets lose precision */
+			if (test_bit(r, loop->store_base_regs)) {
+				spill_base = true;
+				goto cant_widen;
+			}
 			continue;
 		}
 
@@ -2481,15 +2557,21 @@ int bpf_compute_loop_iters(struct bpf_verifier_env *env, struct bpf_verifier_sta
 
 		/* (any 1 (any 2 (any 3 4))) */
 		if (is_widenable_any(env, cur_func, header_env, r, r_scev)) {
+			if (test_bit(r, loop->store_base_regs)) {
+				spill_base = true;
+				goto cant_widen;
+			}
 			continue;
 		}
-
+cant_widen:
 		if (log->level & BPF_LOG_LEVEL2) {
 			r_expr = header_env->reg2expr[r];
 			bpf_log(log, "loop header at %d, can't widen ", insn_idx);
 			log_reg(env, r);
 			bpf_log(log, ", expr is ");
 			log_expr(env, r_expr);
+			if (spill_base)
+				bpf_log(log, ", requires exact stack-offset tracking");
 			bpf_log(log, "\n");
 		}
 		return 0;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index a597a8c18972..2f190abe3448 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -14257,6 +14257,55 @@ static bool kfunc_spin_allowed(struct bpf_verifier_env *env, s32 func_id, s16 of
 	return *kfunc.flags & KF_SPINLOCK_SAFE;
 }
 
+/*
+ * True if insn calls a helper/kfunc that requires one of its arguments to
+ * be a stack pointer with a constant offset.
+ */
+bool bpf_needs_fixed_stack_off(struct bpf_verifier_env *env, int insn_idx)
+{
+	const struct bpf_insn *insn = &env->prog->insnsi[insn_idx];
+	const struct bpf_func_proto *fn;
+	struct bpf_kfunc_desc *desc;
+	u32 *flags, btf_id;
+	int i;
+
+	if (bpf_helper_call(insn)) {
+		if (bpf_get_helper_proto(env, insn->imm, &fn) < 0)
+			return false;
+	} else if (bpf_pseudo_kfunc_call(insn)) {
+		desc = find_kfunc_desc(env->prog, insn->imm, insn->off);
+		if (!desc)
+			return false;
+		fn = &desc->proto;
+	} else {
+		return false;
+	}
+
+	/* Both initialized and uninitialized stack dynptrs need a fixed offset. */
+	for (i = 0; i < ARRAY_SIZE(fn->arg_type); i++)
+		if (arg_type_is_dynptr(fn->arg_type[i]))
+			return true;
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
+	return false;
+}
+
 static bool is_sync_callback_calling_kfunc(u32 btf_id)
 {
 	return is_bpf_rbtree_add_kfunc(btf_id);

-- 
2.53.0
