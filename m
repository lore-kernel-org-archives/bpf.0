Received: from mail-pz2-f42.google.com (mail-pz2-f42.google.com [74.125.228.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E92D141837E
	for <bpf@vger.kernel.org>; Sun,  4 Oct 2026 13:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791121147; cv=none; b=J3UoJWK5NquHtpo5ZPsB7NAA4YICfyUQyYlyae3WtQRhqiopQkRWL0Gvu0bzc2bLq4Fesqfmh41ItdK3N/GDOfK4QjfpSYuZQn9ekaiGxPRS9K8azzc8wR3bsswAcBOjnlEekBwAbRpcH1HcnT8mrgVYLcrz43t46Fp+PBkyu+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791121147; c=relaxed/simple;
	bh=MKuMnysiWaQVgJTmBfPoJS8HI19ywyTODPs8+AWoh8E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TYVguR3u1DHBkCDb0ePgbwqmijR4j/Uojy7QkO3Ifrdd5AL831rF0K3hTnW4L6NnqJuhxCF2awmaxGoT8lXt5Vl8KsPw9qlT9BmbG5ouOoMSqEZkDKsyldlea93FyR061tuVZ/FsTJG812Mk6gDV35p2HABr9zWhsG+wgQm0nGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=o/qvgi7Q; arc=none smtp.client-ip=74.125.228.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o/qvgi7Q"
Received: by mail-pz2-f42.google.com with SMTP id 41be03b00d2f7-cc797656e44so272860a12.2
        for <bpf@vger.kernel.org>; Sun, 04 Oct 2026 06:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791121144; x=1791725944; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=SFxnkiutfQ1yfgo+meqNon9xu5V2RXUMJSG2M7ytqbE=;
        b=o/qvgi7QOAqyc25F56KHle/Rk/e3dTT4XpNqGjmjaKyeRdqhHyzX31tdJUFdG227a8
         ZkZXhyue8geCnPXGOCy4SxslAkPQyY9u8IxnWutB2NeeZQIbABdrcgADGifJ4kTHTC4R
         7NAXDURFJo3tvrF2bGMWTFZhyqmcbE6x4A1UG9q/1Ax8uAfmrpI78J9p9gRqOY0A1SAs
         /yD3zvtIEbsWkwX4iN8YB20ne4aMO0r5ZKlUDkqaGFp1A2APfD2FbFOrF9dV/nfQyrde
         0lHYDRm2TbZs8GhYJB6CiTgzVxbbLTu3/RctpONIac+yf0ijK9qc2hqg6oepvcyc9NCM
         63CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791121144; x=1791725944;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SFxnkiutfQ1yfgo+meqNon9xu5V2RXUMJSG2M7ytqbE=;
        b=axV2RuYMWgPQ5vWZwCWWqwNvYG8wwHqkU/AXNhQgZ6pqxtntfGcaO/Kr+7Mw5bds0c
         SRyR9mBzdB19rutYIj+xnH5qGdzwq5RI4k+NRuvgzKEZ+R/PWJxAuHiVB1LUI9zkf9M+
         zA0WDChAvagamb/byAH44c6V4xLpWoMMjVX+atmatt2XSoqcczWd8CwnGE5ZsC3bMcCC
         0P0uiYlh3ug0+JEeWWuwiN+OWulumGfhbUKACgmU8FVq0EF89riemCSll+rDMti3fSUv
         /rHjglB4zCMBhreob9YDd5NgSGMXSIPmxHMENs9Xm3Caqlk8LexnVtS01FyRAM+AuV00
         GV8w==
X-Gm-Message-State: AFq9FYIJZeDny2C2Wc/Bv9JunxxoDA98KOZ2s/p8KxdZ9ZpMApdwV1+A
	6LsfsWeauC7me3BBD5cY40zYniQPqPF58bnjUkmJqDb0sRmVoGZpfPYzMAT3ZA==
X-Gm-Gg: AYBFou1DWbu40QwZiqsgHypfhAw88BudL2kdbJ6mdujdRy4NpBLtn6cvErEdRXwbzrF
	qzao9Gl43qdmt0QRsN4R6ON4ElKNMiQkZL/JDoVH4dbvVnMC2dfgBNTC4bnmgG5lvpkOOdfnWH+
	nOYQsSxrQTdyp9XkI7ZXaMgxeAFzfhRt3F4H46AB3UIdPtQ4XIl5Po1HWNqYtgCh89r7n/Y8V2a
	lR2Phb5hsr91CnesudYKETAq1qVPH8k5ohAd39djh8Cih0sUpToOfhfWLFl0uSu6N8jFB+tAutE
	8dIV8paSUeAHMwqYdNJeLtL7SMKKL4qc4ySWTvPE2/f2oGRoZa3j1c1VtYUiyWjBlWhLoYDCyP7
	PIRqJsA1UONE3swoBi+kKm2YrCwXjlO/TXesHpACTJVyI59IpBbZGCnwX9j0CingknRQUx4NCXV
	4fonZSm2ypZdzjwdBw57xWm7B+mCJ0SwItlBAddib3qMXj8rfLKi+x5MkrG6af4eQ5kHT8yo3en
	lc6xKjf2qRlI7w=
X-Received: by 2002:a17:90a:1208:b0:3a0:cf4e:6bff with SMTP id 98e67ed59e1d1-3a6d33f5fd4mr3752890a91.32.1791121144123;
        Sun, 04 Oct 2026 06:39:04 -0700 (PDT)
Received: from badger ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc9f7398400sm2915173a12.25.2026.10.04.06.39.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2026 06:39:03 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v2 30/43] bpf: avoid widening registers that hinder exact stack-slot tracking
Date: Sun,  4 Oct 2026 06:38:12 -0700
Message-ID: <20261004-scev-minimal-rebase-v2-30-f6254e29fdf2@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261004-scev-minimal-rebase-v2-0-f6254e29fdf2@gmail.com>
References: <20261004-scev-minimal-rebase-v2-0-f6254e29fdf2@gmail.com>
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
 include/linux/bpf_verifier.h | 10 +++++
 kernel/bpf/scev.c            | 96 +++++++++++++++++++++++++++++++++++++++++---
 kernel/bpf/verifier.c        | 49 ++++++++++++++++++++++
 3 files changed, 149 insertions(+), 6 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index d13f662dcabc..d47d4613eb3c 100644
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
@@ -1854,6 +1863,7 @@ int bpf_stack_liveness_init(struct bpf_verifier_env *env);
 void bpf_stack_liveness_free(struct bpf_verifier_env *env);
 int bpf_live_stack_query_init(struct bpf_verifier_env *env, struct bpf_verifier_state *st);
 const unsigned long *bpf_may_write_mask(struct bpf_verifier_env *env, u32 insn_idx);
+bool bpf_needs_fixed_stack_off(struct bpf_verifier_env *env, int insn_idx);
 bool bpf_stack_slot_alive(struct bpf_verifier_env *env, u32 frameno, u32 spi);
 int bpf_compute_live_registers(struct bpf_verifier_env *env);
 
diff --git a/kernel/bpf/scev.c b/kernel/bpf/scev.c
index a98f3fea52ec..a093e9bf84b9 100644
--- a/kernel/bpf/scev.c
+++ b/kernel/bpf/scev.c
@@ -9,7 +9,7 @@
 #include <linux/tnum.h>
 #include <linux/overflow.h>
 
-#define REGS_NUM (MAX_BPF_REG + MAX_BPF_STACK_SLOTS)
+#define REGS_NUM BPF_SCEV_REGS_NUM
 #define UNKNOWN_EXPR_ID 0
 #define OPAQUE_EXPR_ID  1
 
@@ -1060,6 +1060,70 @@ static void reset_scevs_at_indirect_writes(struct bpf_verifier_env *env, struct
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
@@ -1144,6 +1208,7 @@ static int compute_scev_for_loop(struct bpf_verifier_env *env, int cur_header)
 	struct bpf_iarray *succ;
 	bool log_level2 = env->log.level & BPF_LOG_LEVEL2;
 	int s, i, err, idx, succ_idx;
+	u32 r;
 
 	if (log_level2)
 		bpf_log(&env->log, "Computing SCEV for loop at %d:\n", cur_header);
@@ -1157,6 +1222,7 @@ static int compute_scev_for_loop(struct bpf_verifier_env *env, int cur_header)
 		if (!header_env)
 			return -ENOMEM;
 		/* The freshly allocated environment has all expressions unknown. */
+		bitmap_fill(cur_loop->store_base_regs, REGS_NUM);
 		header_env->empty = false;
 		return 0;
 	}
@@ -1193,6 +1259,9 @@ static int compute_scev_for_loop(struct bpf_verifier_env *env, int cur_header)
 			 */
 			if (log_level2)
 				memcpy(old_env, cur_env, sizeof(*old_env));
+			/* Pull the nested loop's stack-store base dependencies up. */
+			for_each_set_bit(r, nested_loop->store_base_regs, BPF_SCEV_REGS_NUM)
+				or_expr_regs(env, cur_env->reg2expr[r], cur_loop->store_base_regs);
 			forget_non_invariants(env, cur_env, idx);
 			if (log_level2)
 				log_env_changes(env, LOG_AT_TRANSFER, old_env, cur_env, idx);
@@ -1214,6 +1283,7 @@ static int compute_scev_for_loop(struct bpf_verifier_env *env, int cur_header)
 			for (;;) {
 				if (log_level2)
 					memcpy(old_env, cur_env, sizeof(*old_env));
+				collect_store_base_regs(env, cur_env, idx, cur_loop->store_base_regs);
 				err = transfer(env, cur_env, idx);
 				if (err)
 					goto out;
@@ -2232,6 +2302,7 @@ int bpf_compute_loop_iters(struct bpf_verifier_env *env, struct bpf_verifier_sta
 	for (r = 0; r < REGS_NUM; r++) {
 		struct bpf_reg_state *reg;
 		u32 ra, r_scev, r_expr;
+		bool spill_base = false;
 
 		if (!scev_reg_alive(env, st, r))
 			continue;
@@ -2241,10 +2312,16 @@ int bpf_compute_loop_iters(struct bpf_verifier_env *env, struct bpf_verifier_sta
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
 
@@ -2253,8 +2330,13 @@ int bpf_compute_loop_iters(struct bpf_verifier_env *env, struct bpf_verifier_sta
 			continue;
 
 		/* (any 1 (any 2 (any 3 4))) */
-		if (is_any_imm_reg(env, cur_func, header_env, r, r_scev))
+		if (is_any_imm_reg(env, cur_func, header_env, r, r_scev)) {
+			if (test_bit(r, loop->store_base_regs)) {
+				spill_base = true;
+				goto cant_widen;
+			}
 			continue;
+		}
 
 cant_widen:
 		if (log->level & BPF_LOG_LEVEL2) {
@@ -2263,6 +2345,8 @@ int bpf_compute_loop_iters(struct bpf_verifier_env *env, struct bpf_verifier_sta
 			log_reg(env, r);
 			bpf_log(log, ", expr is ");
 			log_expr(env, r_expr);
+			if (spill_base)
+				bpf_log(log, ", requires exact stack-offset tracking");
 			bpf_log(log, "\n");
 		}
 		return 0;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 8e92c77b11a2..e4780c8bef13 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -14211,6 +14211,55 @@ static bool kfunc_spin_allowed(struct bpf_verifier_env *env, s32 func_id, s16 of
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
