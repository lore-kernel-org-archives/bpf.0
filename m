Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792983980;
	b=mMTIoJSdUO4i8as8IhVSlLd6yTZfDOPfgTRxDb28+jno8Ex1bK5yBLNlARWBAsL9YuF1
	 u5FTEgOkyGW7iEsRzMnbRnJkOOZ4uqfNVNLlBbiamQOSGSwEVp2a9CGsBL9nCR6gI9qj6
	 /4QGqy/cpinl6SUyrnMGoDjThGLN3b21iIYObqqy45Y9EwOoe4HKRvQ7KFUGJ3gMC6zgz
	 ty9eqNOtHuwb3IchqD5NRjd+/h0sNgD3u7QqPW4qzJjUecSOIHbUtkdVhYUdO1emVkAmk
	 SbdjGiGcyVv18bieTxuqs4sGsE/S9Quh44HvufDvzeIogQqaiAUqXza572+G+gxTFQg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792983980;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=P43EFHxWNYcGPZGupIdCGH+n+HkHoKnERxi7qoEppzE=;
	b=GsYmiu4nfX9TA9u9ob2uxClzWXkysW8SGgRjEcvDKxbdHP8s2caUf6psRCwAhxfBmiAc
	 nYqSOs3vpXQy4ZuvCWXDKZu8wo/2NqKWw/qcUswfQYwMR8ReM9EgnAPzWDhfJ/77ZWF/+
	 KD8zLS4l7qAmwRHMU7PRdqkBZLt5shuefSqL/7JCnStecPi1VtBL7IbgokDk3YqOGen3S
	 ISaSWHpbOZ8YuO2ap70qlxlSHbtuIhwTTQ+fsXnF/QYaOf0O4XhtSULodS2iEaHvGCSEY
	 ViXf0UbGQcFIC9HHjCI9MnPRT1sXTIZnfYNX6By5/UO3ZA7bQkW4IbZHj689gAfE4Ew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=n3Mt9OWI;
	arc=none smtp.remote-ip=209.85.214.174
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB46C606A31A
	for <bpf@vger.kernel.org>; Mon, 26 Oct 2026 03:06:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CB46C606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=n3Mt9OWI
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2ea7190aea1so11040615ad.1
        for <bpf@vger.kernel.org>; Sun, 25 Oct 2026 20:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792983979; x=1793588779; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=P43EFHxWNYcGPZGupIdCGH+n+HkHoKnERxi7qoEppzE=;
        b=n3Mt9OWIH+lBOFC3x7HgtLo8fAxQjyHX3Z5NVHDiPgMYB5vyG257ExKl7c7djIRY5f
         av+btqUsyG2w923BCuYZwomRrTk8HSjZu68CJ2MTBMVzciIqnaRk2JTq3QL6AIIU2w20
         RB9OsYZ1ibF328kbE7eCc6CkfxXcKrE5wJu0q5yOOffo0UY9xS7WcbbVIREdA7uYnymk
         kRFHmVSAJP9fN7Ty90p6PZFlyruNSaU6l61W2gu4zq5nBaMqmdeP1nvgzUI4Qdd1ocwS
         R2BS30CHxlCFUa+90VQ0FL1Nvl4wNdIgTqnxaTa0tj8fdcTnEl+YV1CWMVQOGRCHg6dT
         idpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792983979; x=1793588779;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=P43EFHxWNYcGPZGupIdCGH+n+HkHoKnERxi7qoEppzE=;
        b=mToJsT+F5IX2v2ijdSESzyvhXZkBvwbrw+9UlUY8YF4+ymnk9fJEVsOmYfBjyC+0pG
         uObINtLmLAJGq4qbJfg1I1eaYO80OBTDcasHZXwOJAj+SYPE5KF0OEoIuExcVAx53k2i
         YM7inxsAhAeWQ494g6dDC2pYiPEOaJfrBoQ6GySYLCxQo2CqNA5GYXbyxbanAxdFJMk5
         oJFtgRhpJgWs8QjtSCUmmOpQFd+C2JewX5SWNAwVb5Hw1gkKkY6zQt7+tC3L+809oXHM
         ItKxV9wYTGLm/xkZrelWdKL1cgigcPc+LRIyQTGYHfjCtooKKv8/oIE4FJax3UV2TiNr
         S3uw==
X-Gm-Message-State: AFq9FYJZCU+PNku/R6nlIMKc+3Lh7tiVxRHslj0Uef6RCxjiatKLGYek
	V0RLhlcLpww32SICD+67Hmo221fSd7v5HZUxM7nRQOdxdJqntuWyA6Dzk6NEkA==
X-Gm-Gg: AYBFou1NZi7QdKd8zGfxwdKWpMfeiKRQlW8lOlUrou0DVdfKVAOIaiGWY03ul3lJTMN
	QcypvMWVFJfB8U6YKoRcFeU2wbAu1jk6/v9c/wFgkRXWjmUSlNWHzxQhPSPKFGUl95CeiqjspPB
	SzTxImNHd/i+bQ/swrGNKNAI+eKSsaXHS9Wy8bqNo3eguzlBFFLXuhBD99GkeBx0S5MZJuj1yFC
	/SSCAJ5sFWw5KdgWod2yMTpyR3NeyaqWrZI8NStmk3ckzxwPNILN5mAsha5csu5HfHbX/mpklZJ
	ZhyRjJqPS4Cp94wtXQ+INA18YEpya+NmEBs6MR9RVAKwwITnmIA0ofzPSqMK5icU25/3OInJ8st
	vkEgFFh0ySMX8mAqMJpkf7WICHhHF6OrqcjoZudtBCIgs/X4/N/dTyX/KmiIaBdURXO1UJyfdAC
	cYXKRQOYtphpKBNUHwLzUAH85ZSbDSKyZpV4Pa7bQQRjfFDVAkN/Q870EGCZL/ozTNsUA8SS+S7
	uViqQrbHXKpZCOevX9OwynmwCu2FSF3YT2vmZRtneHBMPQZo06QW5QkJY1Clg7w1IdHkdWgI0xf
	QssBq+u/o0wg+na8EMwJB7jNj2SbhCQ6SvpLEyMqNYbYALmjTfJv3TvpF9KwIZhDcBUpY7QAAVg
	6IFe1BYTRY0gmLQHVc3aAxBYs
X-Received: by 2002:a17:90b:1cc4:b0:3a8:195f:186 with SMTP id 98e67ed59e1d1-3adeb0f893fmr4394060a91.42.1792983978997;
        Sun, 25 Oct 2026 20:06:18 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.252])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3adebfa3794sm6385835a91.14.2026.10.25.20.06.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 20:06:18 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf 67/81] bpf: Remove leftovers of precision tracking and read marks
Date: Mon, 26 Oct 2026 02:59:28 +0000
Message-ID: <20261026025943.404450-68-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261026025943.404450-1-alexei.starovoitov@gmail.com>
References: <20261026025943.404450-1-alexei.starovoitov@gmail.com>
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

From: Alexei Starovoitov <ast@kernel.org>

"bpf: Remove precision tracking" removed the 'precise' bit and backtrack.c.
This code has no purpose after that:
 - __mark_reg_unknown() and __mark_reg_const_zero() have the argument env
   only to set the bit. Replace the first function with
   bpf_mark_reg_unknown(). Remove env from the second function.
 - Only backtrack.c used BPF_REGMASK_ARGS.

The verifier has no read marks, and nothing sets longest_mark_read_walk.
Remove it. veristat and other tools parse the statistics line of the
verifier log. Thus the line continues to show "mark_read 0".

No functional changes.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/bpf_verifier.h |  6 ----
 kernel/bpf/states.c          |  2 --
 kernel/bpf/verifier.c        | 53 +++++++++++++++---------------------
 3 files changed, 22 insertions(+), 39 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index f46963591e18..0cd7fa277fe5 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -274,10 +274,6 @@ enum bpf_stack_slot_type {
 #define BPF_HALF_REG_SIZE	4
 #define STACK_SLOT_SZ		4
 
-#define BPF_REGMASK_ARGS ((1 << BPF_REG_1) | (1 << BPF_REG_2) | \
-			  (1 << BPF_REG_3) | (1 << BPF_REG_4) | \
-			  (1 << BPF_REG_5))
-
 #define BPF_MAIN_FUNC (-1)
 
 #define BPF_DYNPTR_SIZE		sizeof(struct bpf_dynptr_kern)
@@ -1088,8 +1084,6 @@ struct bpf_verifier_env {
 	 * memory consumption during verification
 	 */
 	u32 peak_states;
-	/* longest register parentage chain walked for liveness marking */
-	u32 longest_mark_read_walk;
 	/*
 	 * The program's fd_array comes in two shapes, told apart by whether
 	 * the caller passed fd_array_cnt. They are mutually exclusive:
diff --git a/kernel/bpf/states.c b/kernel/bpf/states.c
index 91c3a23b6e12..8b7c13be9265 100644
--- a/kernel/bpf/states.c
+++ b/kernel/bpf/states.c
@@ -5,8 +5,6 @@
 #include <linux/cnum.h>
 #include <linux/filter.h>
 
-#define verbose(env, fmt, args...) bpf_verifier_log_write(env, fmt, ##args)
-
 /* check %cur's range satisfies %old's */
 static bool range_within(const struct bpf_reg_state *old,
 			 const struct bpf_reg_state *cur)
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 17a9d1bf5318..21ea43422133 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -847,15 +847,12 @@ static int unmark_stack_slots_dynptr(struct bpf_verifier_env *env, struct bpf_re
 				      : reg->id);
 }
 
-static void __mark_reg_unknown(const struct bpf_verifier_env *env,
-			       struct bpf_reg_state *reg);
-
 static void mark_reg_invalid(const struct bpf_verifier_env *env, struct bpf_reg_state *reg)
 {
 	if (!env->allow_ptr_leaks)
 		bpf_mark_reg_not_init(env, reg);
 	else
-		__mark_reg_unknown(env, reg);
+		bpf_mark_reg_unknown(reg);
 }
 
 static int dynptr_ref_cnt(struct bpf_verifier_env *env, int v_parent_id)
@@ -1998,7 +1995,7 @@ static void __mark_reg_known_zero(struct bpf_reg_state *reg)
 	__mark_reg_known(reg, 0);
 }
 
-static void __mark_reg_const_zero(const struct bpf_verifier_env *env, struct bpf_reg_state *reg)
+static void __mark_reg_const_zero(struct bpf_reg_state *reg)
 {
 	__mark_reg_known(reg, 0);
 	reg->type = SCALAR_VALUE;
@@ -2343,16 +2340,10 @@ void bpf_mark_reg_unknown(struct bpf_reg_state *reg)
 	reg_step_reset(reg);
 }
 
-static void __mark_reg_unknown(const struct bpf_verifier_env *env,
-			       struct bpf_reg_state *reg)
-{
-	bpf_mark_reg_unknown(reg);
-}
-
 static void mark_reg_unknown(struct bpf_verifier_env *env,
 			     struct bpf_reg_state *regs, u32 regno)
 {
-	__mark_reg_unknown(env, regs + regno);
+	bpf_mark_reg_unknown(regs + regno);
 }
 
 static int __mark_reg_s32_range(struct bpf_verifier_env *env,
@@ -2378,7 +2369,7 @@ static int __mark_reg_s32_range(struct bpf_verifier_env *env,
 void bpf_mark_reg_not_init(const struct bpf_verifier_env *env,
 			   struct bpf_reg_state *reg)
 {
-	__mark_reg_unknown(env, reg);
+	bpf_mark_reg_unknown(reg);
 	reg->type = NOT_INIT;
 }
 
@@ -3973,7 +3964,7 @@ static void mark_reg_stack_read(struct bpf_verifier_env *env,
 		/* Any access_size read into register is zero extended,
 		 * so the whole register == const_zero.
 		 */
-		__mark_reg_const_zero(env, &state->regs[dst_regno]);
+		__mark_reg_const_zero(&state->regs[dst_regno]);
 	} else {
 		/* have read misc data from the stack */
 		mark_reg_unknown(env, state->regs, dst_regno);
@@ -4115,10 +4106,10 @@ static int check_stack_read_fixed_off(struct bpf_verifier_env *env,
 
 				if (spill_cnt == size &&
 				    tnum_is_const(reg->var_off) && reg->var_off.value == 0) {
-					__mark_reg_const_zero(env, &state->regs[dst_regno]);
+					__mark_reg_const_zero(&state->regs[dst_regno]);
 				} else if (zero_cnt == size) {
 					/* similarly to mark_reg_stack_read(), preserve zeroes */
-					__mark_reg_const_zero(env, &state->regs[dst_regno]);
+					__mark_reg_const_zero(&state->regs[dst_regno]);
 				} else {
 					mark_reg_stack_read(env, reg_state, off, off + size,
 							    dst_regno);
@@ -7744,7 +7735,7 @@ static int check_stack_range_initialized(
 		    (ss->spilled_ptr.type == SCALAR_VALUE ||
 		     env->allow_ptr_leaks)) {
 			if (clobber) {
-				__mark_reg_unknown(env, &ss->spilled_ptr);
+				bpf_mark_reg_unknown(&ss->spilled_ptr);
 				for (j = 0; j < BPF_REG_SIZE; j++)
 					scrub_spilled_slot(&ss->slot_type[j]);
 			}
@@ -8709,7 +8700,7 @@ static int process_iter_next_call(struct bpf_verifier_env *env, int insn_idx,
 
 	/* mark current iter state as drained and assume returned NULL */
 	cur_iter->iter.state = BPF_ITER_STATE_DRAINED;
-	__mark_reg_const_zero(env, &cur_fr->regs[BPF_REG_0]);
+	__mark_reg_const_zero(&cur_fr->regs[BPF_REG_0]);
 
 	return 0;
 }
@@ -15815,7 +15806,7 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 		ret_nregs = mark_kfunc_ret_regs(env, regs, t->size);
 		if (meta.btf == btf_vmlinux && (meta.func_id == special_kfunc_list[KF_bpf_res_spin_lock] ||
 		    meta.func_id == special_kfunc_list[KF_bpf_res_spin_lock_irqsave]))
-			__mark_reg_const_zero(env, &regs[BPF_REG_0]);
+			__mark_reg_const_zero(&regs[BPF_REG_0]);
 	} else if (btf_type_is_struct(t)) {
 		struct btf_member_path path = {};
 		const char *member_note = "";
@@ -16445,14 +16436,14 @@ static int adjust_ptr_min_max_vals(struct bpf_verifier_env *env, struct bpf_insn
 		/* Taint dst register if offset had invalid bounds derived from
 		 * e.g. dead branches.
 		 */
-		__mark_reg_unknown(env, dst_reg);
+		bpf_mark_reg_unknown(dst_reg);
 		return 0;
 	}
 
 	if (BPF_CLASS(insn->code) != BPF_ALU64 && !to_scalar) {
 		/* 32-bit ALU ops on pointers produce (meaningless) scalars */
 		if (opcode == BPF_SUB && env->allow_ptr_leaks) {
-			__mark_reg_unknown(env, dst_reg);
+			bpf_mark_reg_unknown(dst_reg);
 			return 0;
 		}
 
@@ -16516,7 +16507,7 @@ static int adjust_ptr_min_max_vals(struct bpf_verifier_env *env, struct bpf_insn
 	}
 
 	if (to_scalar) {
-		__mark_reg_unknown(env, dst_reg);
+		bpf_mark_reg_unknown(dst_reg);
 		return 0;
 	}
 
@@ -17463,7 +17454,7 @@ static int adjust_scalar_min_max_vals(struct bpf_verifier_env *env,
 	int ret;
 
 	if (!is_safe_to_compute_dst_reg_range(insn, &src_reg)) {
-		__mark_reg_unknown(env, dst_reg);
+		bpf_mark_reg_unknown(dst_reg);
 		return 0;
 	}
 
@@ -19392,7 +19383,7 @@ static int check_ld_imm(struct bpf_verifier_env *env, struct bpf_insn *insn)
 	if (insn->src_reg == BPF_PSEUDO_MAP_VALUE ||
 	    insn->src_reg == BPF_PSEUDO_MAP_IDX_VALUE) {
 		if (map->map_type == BPF_MAP_TYPE_ARENA) {
-			__mark_reg_unknown(env, dst_reg);
+			bpf_mark_reg_unknown(dst_reg);
 			dst_reg->map_ptr = map;
 			bpf_diag_mod_end(env);
 			return 0;
@@ -20487,7 +20478,7 @@ static void null_to_arena(struct bpf_verifier_env *env, int regno)
 	reg = &cur_regs(env)[regno];
 	if (reg->type != SCALAR_VALUE || !tnum_equals_const(reg->var_off, 0))
 		return;
-	__mark_reg_const_zero(env, reg);
+	__mark_reg_const_zero(reg);
 	reg->type = PTR_TO_ARENA;
 }
 
@@ -20983,9 +20974,9 @@ static int push_budget_exit(struct bpf_verifier_env *env)
 		return PTR_ERR(branch);
 	branch->unwound = sub->bail_unwinds;
 	regs = branch->frame[branch->curframe]->regs;
-	__mark_reg_const_zero(env, &regs[BPF_REG_0]);
+	__mark_reg_const_zero(&regs[BPF_REG_0]);
 	if (bpf_ret_reg_pair(env, cur_func(env)->subprogno))
-		__mark_reg_const_zero(env, &regs[BPF_REG_2]);
+		__mark_reg_const_zero(&regs[BPF_REG_2]);
 	return 0;
 }
 
@@ -21070,7 +21061,7 @@ static int check_loop_guard(struct bpf_verifier_env *env)
 			aux->guard_zero |= BIT(i);
 	for (i = BPF_REG_0; i < BPF_REG_FP; i++)
 		if (aux->guard_zero & BIT(i))
-			__mark_reg_const_zero(env, &regs[i]);
+			__mark_reg_const_zero(&regs[i]);
 
 	func = branch->frame[branch->curframe];
 	branch->insn_idx = aux->guard_to;
@@ -22721,12 +22712,12 @@ static void print_verification_stats(struct bpf_verifier_env *env)
 				env->subprog_info[i].stack_depth);
 		}
 	}
-	/* user space parses this line. There is no limit. */
+	/* user space parses this line. There is no limit and there are no read marks. */
 	verbose(env, "processed %d insns (limit 0) max_states_per_insn %d "
-		"total_states %d peak_states %d mark_read %d\n",
+		"total_states %d peak_states %d mark_read 0\n",
 		env->insn_processed,
 		env->max_states_per_insn, env->total_states,
-		env->peak_states, env->longest_mark_read_walk);
+		env->peak_states);
 }
 
 int bpf_prog_ctx_arg_info_init(struct bpf_prog *prog,
-- 
2.55.0

