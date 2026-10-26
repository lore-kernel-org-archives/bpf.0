Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792983870;
	b=V4Z8tJvQ2zOw4B1StsWGsFhs7yXul1BLmTUEOAlmW/gscypdDRzq3nMFP646ySe7elBj
	 HrCE5mDthw9r32hgDIRmW4UY69ItpNVfkFAttJJ5zqeAigQR8sqmNj71GcQex/rDuhwcV
	 y3/oHW7sw1VXIBKsLc8auQRZ669Pn0nIDkIZ2QbX5r5IpsZZjRVZX9vk018HvWbBF4JNT
	 XSHU6iSA/Gs5nxApa0SFhsoR0fpXlIHZUktY4DHN/XkkEP84Tf2yCY1bYpRdi3jmvYNcz
	 Z5NWSfvhfgBU7o6RoNEnGEOWD2WGBz+Bo79W47pyMYWDdQUOqaEEWqpMQxvNGm9Lktg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792983870;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=sbDo1/WucZ379YdCZSDQ27BYQbKEHFwIBslNzP9ILE8=;
	b=wjHehARW/Hr0MwdtcyAGgpdwcIytM03jvKhGUJrFo+cWHQohyIf812PTELRn4lrYqjd+
	 Yn/bobPECkeHD/B1fh2hqZPDuaxFWTzO0uHFiJZM8oRWQGPOMAWo/zApSeStDn+4TcSSd
	 hGnSzLdrASmdORwZFeOd7vKyN0Z5KHXFb2CpdXQTptinQpxTOAl5ry/y0nqg3N8DnPipL
	 LxsbleAIDqsVel2jIsjtMIhZGFKDLPXFkcK2EzkMs7Ff/nTQn+jI9aZkjwq9H1mgmInF9
	 h26TN90+f5FS9Romg4zTPEY+W8qN5bSaHcy4VczMbe5ewQR4Pih82ku1Es2I1vTg0/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=VcTfGXqD;
	arc=none smtp.remote-ip=209.85.215.175
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF1FA606A31B
	for <bpf@vger.kernel.org>; Mon, 26 Oct 2026 03:04:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DF1FA606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=VcTfGXqD
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-cd6acc50b8dso730090a12.3
        for <bpf@vger.kernel.org>; Sun, 25 Oct 2026 20:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792983868; x=1793588668; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sbDo1/WucZ379YdCZSDQ27BYQbKEHFwIBslNzP9ILE8=;
        b=VcTfGXqDyGEDo2YefA5z2PB3ONp/sXgrRkU0A30SVOfBEEgmnEx44IcrGQIJgFa7Eh
         Z96Kv52VDbb0i2Yr2ex0Si8ZPGFnH5Rq9PDVzbRMKpG8SUuN0j3DRzOFpvfCs6HPNvSw
         EqELNI+UuUyx9yPgzmIzOiIk+SrirpVJk/gb1T0uuAnUL/ADFfhTRejVG4K+H6Fd2OPz
         XvybeoTccw7UuRH9YpMp+cI2y8DPCUnpmYffE0E0DPKO+BfprMW52NvDBiATH3stgQe2
         D+l25HC/WIWL4L4zM83IywZpI4P3rXQksrzK9536bixSrkrR8CJBecFqmxBuU1x9PqIz
         6Isg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792983868; x=1793588668;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=sbDo1/WucZ379YdCZSDQ27BYQbKEHFwIBslNzP9ILE8=;
        b=Tx6oxUQoUR82i9yAxyg/A9CujRrCxURoZievvcgDw192jTQfw4JAWMUF7Tckzx8clj
         ZGWWp7MVMfc8/qSk9he9NrlzY8HW7GY1iuCKWa1olQKcNT2b59RkVr4+Ck9ZGZgwJhf6
         02TDtvu4S+X8QxZwRg8ZOzw/WmZ0yOIdXd2up662Oel0abju/QEioCEvLZpaJDNa8FVm
         R44TQ6iXC8x1bZFJBI2L8LaWhcO4nsgIiOsyAzmM4zq2E9AZFRxaCffoGkEpySAYxKVp
         ZdczWEpvfjR3YFI0F7K5Xcv5g8WE1X8uwxDuhZJ7B/Kxew6d5ykgHnpLZhIASDIoOPB8
         0mfw==
X-Gm-Message-State: AFq9FYJmvpbVue4dBoBIQ3EG2Xcbqzk9H94qVds5R0EajF6ISP3ETHtY
	VfBQ2ZHWBzLiD/tUkTJ5S7PWyip5bwVsSInwop/5416/6qKq/DH4ezOUYNppLg==
X-Gm-Gg: AYBFou2Z9Txp8q948wk42FkWmuyUp33CDL5igUf3VGTqyQPLODsIECSFj3Jc5JRyOcg
	1BZOcQrDrA/H4+AU/QcHKrQ8r3xV3eqKQlyLJhSXxPKnCyhqOzrI7DbIAdiStAhjKffRSJqYunh
	djLMv3MOsyZl88nXD5ZD5XXSnsEzLh9L7Tudps0DUWiLv3grFsabAO3T6NRAOwoNQDN5Pw3sxH/
	AvAwiaqHt3kgLSPendlEawOucKXgHK+e1LGf1YDFYeUHK+rvAeF8WpU6Tp4xa+P8OTH6RmDzRUV
	c6nrGns2t/fGAktuPcLr1JYGNqc+x+qc875LVN9s7OQQphqTO4jaLWgBrzc7rr/YjFDrddt0kA+
	V6z+5uBJdGdLI4e53PUGr9yxSoTIsmZR/lU/Z+Zgg2DkzpIsCkXGc4Ul8XoD75JPfwBh0MCJvtT
	N2Eb3NqaZK8lc4WrEIR/6S+XBAvAqb/gh6kxhCFKD5+bBr+by7Q9bG33dMvXIaohEfdK7zxEfaP
	Q1iquAXFDUPPmqoRKagV3zaV5QtgFKK5BMZKu5rFCgipdOV71bbY7MpaVRNJCAu6vfIaU+kc6JC
	iBAivXi49Env2X9PRzDoutLF0Pe6FVZP6EvjLuP5Jb1rk2GLyYnGzXnuANv1QzE2yofewG+58oS
	WsNtKGVQWjTkPfeu+eaHLHUrL
X-Received: by 2002:a17:90b:4e8b:b0:3ac:9d14:feb1 with SMTP id 98e67ed59e1d1-3adeafc4fd2mr4806431a91.43.1792983867344;
        Sun, 25 Oct 2026 20:04:27 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.242])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3adebaca727sm6424763a91.3.2026.10.25.20.04.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 20:04:26 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf 48/81] bpf: Describe loops that scalar evolution cannot count exactly
Date: Mon, 26 Oct 2026 02:59:09 +0000
Message-ID: <20261026025943.404450-49-alexei.starovoitov@gmail.com>
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

Scalar evolution examines each loop before the main pass. For
'for (i = 0; i < 10; i++)' it calculates the number of iterations. Then the
verifier gives each variable of the loop its range over all iterations, and
verifies the body one time. Such a loop is a counted loop. The verifier
unrolls all other loops: it verifies them one iteration at a time.

Few loops are counted. The first value of the variable must be a constant.
The bound in the latch, the jump back to the loop head, must be a constant.
Scalar evolution must describe each live register that the loop changes.

"bpf: Verify programs as a fixpoint over the control flow graph" needs, for
each loop, one state at the loop head that covers all iterations. Thus
scalar evolution must describe more loops. The patch makes three changes.

Change 1: count with ranges. When the first value or the bound is a range,
calculate the count for the two values that are furthest apart. The result
is an upper bound.

  for (i = up_to_16; i < 17; i++)        header_count is [0..17]

There is no count when the value that ends the loop can wrap around. The
variable that the latch tests gets the values that the latch lets through,
because 'first value + step * count' is too wide.

Change 2: describe more registers of a counted loop. Before this patch one
register without a description made the full loop not counted.

       what the loop does with a live register     the register at the head
  ---  ------------------------------------------  ------------------------
       adds a constant                             range from the count
       sets it to one of a few invariant values    union of the values
  new  loads it again in each iteration            unknown scalar
  new  only clears bits of [0, max]:               no change
       'idx &= ~(1 << order)', zero extension
  new  moves a pointer to arena                    it has no offset
  new  sets it to the same constant each time      no change
       something else                              no description

In the last case the count is valid, and the verifier unrolls the loop.

Change 3: make a guess for a loop that has no count. bpf_scev_forget_regs()
changes the state that enters the loop:
 - A counter, 'r += c', gets its range at the entry together with the
   values that the latch lets through. A counter that the latch does not
   test becomes an unknown scalar, or [0, U32_MAX] for a 32-bit counter.
 - A register that the loop sets to one of a few invariant values gets the
   union of the values.

The caller must compare the state that returns to the loop head with the
guess, as with each other state. Thus an incorrect guess cannot hide an
unsafe iteration. bpf_scev_latch_decided() tells the caller when it is
better to unroll: constants decide an exit of the loop in the first
iteration. No code calls these two functions in this patch.

The verifier uses changes 1 and 2 immediately. Nothing stops a counted loop
at run time. Before this patch 'i < (n & 0x7fffffff)' hit the limit of
1M insns. Now it loads and can run for 0.48 sec, like 'i < 0x7fffffff'.

Three smaller changes make more loops agree with the table:
 - 'r += 1; r += 1' is a step of 2.
 - 'r <<= 32; r >>= 32' is a zero extension. This rule depends on
   "bpf: Mask the count of a 32-bit shift in scalar evolution".
 - The register of an implicit kfunc argument is not live before the call,
   because the verifier fills in this argument. A live register that the
   prog does not set has no description.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/bpf_verifier.h |  32 +-
 kernel/bpf/const_fold.c      |   7 +-
 kernel/bpf/liveness.c        |   3 +-
 kernel/bpf/loops.c           |  24 ++
 kernel/bpf/scev.c            | 795 ++++++++++++++++++++++++++++++++++-
 kernel/bpf/verifier.c        |  14 +-
 6 files changed, 850 insertions(+), 25 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 8001be4c3626..f0f054f98dc1 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -335,6 +335,18 @@ struct bpf_loop_iters {
 	u32 min_header_count;   /* min number of times header is executed */
 	u32 max_header_count;   /* max number of times header is executed */
 	unsigned long precise_regs[BITS_TO_LONGS(BPF_SCEV_REGS_NUM)];
+	/* live, changed by the loop, and there is no summary of how */
+	unsigned long forget_regs[BITS_TO_LONGS(BPF_SCEV_REGS_NUM)];
+	/* [0, max] at the entry, and the loop only clears bits */
+	unsigned long mask_regs[BITS_TO_LONGS(BPF_SCEV_REGS_NUM)];
+	/*
+	 * The variable that the latch tests, or -1, and what it can be at the
+	 * loop header: what it is at the entry or what the latch lets through.
+	 */
+	int iv_reg;
+	struct cnum64 iv_range;
+	/* a pointer to the stack that stores go through moves in the loop */
+	bool spill_base;
 };
 
 struct loop_stack_entry {
@@ -343,6 +355,8 @@ struct loop_stack_entry {
 	u32 max_header_count;
 	u32 loop_id:31;
 	u32 terminates:1;
+	int iv_reg;
+	struct cnum64 iv_range;
 };
 
 #define LOOP_STACK_SIZE 16
@@ -724,6 +738,14 @@ struct bpf_loop {
 	bool irreducible;
 	bool backedges_overflow;
 	bool exits_overflow;
+	/* every trip goes through may_goto or bpf_iter_*_next() */
+	bool rt_bounded;
+	/* insns in the loop, nested loops included */
+	u32 nr_insns;
+	/* functions of the program are called in the loop */
+	bool has_calls;
+	/* otherwise: there are places for may_goto, see guard_to in bpf_insn_aux_data */
+	bool has_guards;
 	/*
 	 * Loop-entry registers used to compute stack addresses for loads,
 	 * stores and calls requiring fixed stack offsets, in this and nested
@@ -832,12 +854,14 @@ struct bpf_insn_aux_data {
 	/*
 	 * Bitmask of R0-R9 that hold known values at this instruction.
 	 * const_reg_mask: scalar constants that fit in 32 bits.
+	 * const_reg_wide_mask: scalar constants that don't, there is no val.
 	 * const_reg_map_mask: map pointers, val is map_index into used_maps[].
 	 * const_reg_subprog_mask: subprog pointers, val is subprog number.
 	 * const_reg_vals[i] holds the 32-bit value for register i.
 	 * Populated by compute_const_regs() pre-pass.
 	 */
 	u16 const_reg_mask;
+	u16 const_reg_wide_mask;
 	u16 const_reg_map_mask;
 	u16 const_reg_subprog_mask;
 	u32 const_reg_vals[10];
@@ -1256,6 +1280,8 @@ static inline bool bpf_ret_reg_pair(struct bpf_verifier_env *env, int subprog)
 
 struct bpf_call_summary {
 	u8 arg_slot_cnt;
+	/* the last of them are filled in by the verifier, the prog doesn't pass them */
+	u8 implicit_slot_cnt;
 	bool is_void;
 	bool fastcall;
 };
@@ -1425,6 +1451,8 @@ int bpf_states_join(struct bpf_verifier_env *env, struct bpf_verifier_state *dst
 void bpf_join_free(struct bpf_verifier_env *env);
 
 int bpf_insert_unwound_reports(struct bpf_verifier_env *env);
+bool bpf_insn_leaves_loop(struct bpf_verifier_env *env, int h, int n);
+bool bpf_jump_leaves_loop(struct bpf_verifier_env *env, int h, int n);
 int bpf_split_cur_state(struct bpf_verifier_env *env);
 int bpf_update_branch_counts(struct bpf_verifier_env *env, struct bpf_verifier_state *st);
 
@@ -2058,12 +2086,14 @@ bool bpf_is_nested_loop(struct bpf_verifier_env *env, int inner_header, int oute
 int bpf_init_scev(struct bpf_verifier_env *env);
 void bpf_free_scev(struct bpf_verifier_env *env);
 int bpf_compute_scev(struct bpf_verifier_env *env);
+int bpf_scev_forget_regs(struct bpf_verifier_env *env, struct bpf_verifier_state *st);
+bool bpf_scev_latch_decided(struct bpf_verifier_env *env, struct bpf_verifier_state *st);
 
 int bpf_compute_loop_iters(struct bpf_verifier_env *env, struct bpf_verifier_state *st,
 			   struct bpf_loop_iters *iters);
 int bpf_widen_scev_regs(struct bpf_verifier_env *env, struct bpf_verifier_state *st,
 			struct bpf_verifier_state *loop_entry, struct bpf_loop_iters *iters);
 int bpf_clamp_scev_regs(struct bpf_verifier_env *env, struct bpf_func_state *st, u32 insn_idx,
-			struct bpf_verifier_state *entry_state, u32 max_header_count);
+			const struct loop_stack_entry *entry);
 
 #endif /* _LINUX_BPF_VERIFIER_H */
diff --git a/kernel/bpf/const_fold.c b/kernel/bpf/const_fold.c
index 0e0cad2b4b8e..bd251c8e82ee 100644
--- a/kernel/bpf/const_fold.c
+++ b/kernel/bpf/const_fold.c
@@ -285,7 +285,7 @@ int bpf_compute_const_regs(struct bpf_verifier_env *env)
 
 	/* Save computed constants into insn_aux[] if they fit into 32-bit */
 	for (i = 0; i < insn_cnt; i++) {
-		u16 mask = 0, map_mask = 0, subprog_mask = 0;
+		u16 mask = 0, wide_mask = 0, map_mask = 0, subprog_mask = 0;
 		struct bpf_insn_aux_data *aux = &insn_aux[i];
 		struct const_arg_info *ci = ci_in[i];
 
@@ -296,8 +296,10 @@ int bpf_compute_const_regs(struct bpf_verifier_env *env)
 			case CONST_ARG_CONST: {
 				u64 val = c->val;
 
-				if (val != (u32)val)
+				if (val != (u32)val) {
+					wide_mask |= BIT(r);
 					break;
+				}
 				mask |= BIT(r);
 				aux->const_reg_vals[r] = val;
 				break;
@@ -315,6 +317,7 @@ int bpf_compute_const_regs(struct bpf_verifier_env *env)
 			}
 		}
 		aux->const_reg_mask = mask;
+		aux->const_reg_wide_mask = wide_mask;
 		aux->const_reg_map_mask = map_mask;
 		aux->const_reg_subprog_mask = subprog_mask;
 	}
diff --git a/kernel/bpf/liveness.c b/kernel/bpf/liveness.c
index 044f275d28e9..985cd39acf3e 100644
--- a/kernel/bpf/liveness.c
+++ b/kernel/bpf/liveness.c
@@ -2631,7 +2631,8 @@ static void compute_insn_live_regs(struct bpf_verifier_env *env,
 			def = ALL_CALLER_SAVED_REGS;
 			use = def & ~BIT(BPF_REG_0);
 			if (bpf_get_call_summary(env, insn, &cs)) {
-				use = GENMASK(min_t(u8, cs.arg_slot_cnt, MAX_BPF_FUNC_REG_ARGS), 1);
+				use = GENMASK(min_t(u8, cs.arg_slot_cnt - cs.implicit_slot_cnt,
+						    MAX_BPF_FUNC_REG_ARGS), 1);
 			} else if (bpf_pseudo_call(insn)) {
 				/* a static callee's reads are added in bpf_compute_live_registers() */
 				subprog = callee_subprog(env, insn);
diff --git a/kernel/bpf/loops.c b/kernel/bpf/loops.c
index 2568079c2945..2e54dddb3236 100644
--- a/kernel/bpf/loops.c
+++ b/kernel/bpf/loops.c
@@ -457,6 +457,30 @@ bool bpf_is_nested_loop(struct bpf_verifier_env *env, int inner_header, int oute
 	return false;
 }
 
+/* Whether the conditional jump at @n, in the loop @h or in a loop nested in it, leaves @h */
+bool bpf_jump_leaves_loop(struct bpf_verifier_env *env, int h, int n)
+{
+	struct bpf_insn *insn = &env->prog->insnsi[n];
+	u8 class = BPF_CLASS(insn->code), op = BPF_OP(insn->code);
+	int t, f;
+
+	if ((class != BPF_JMP && class != BPF_JMP32) || op == BPF_JA || op == BPF_CALL ||
+	    op == BPF_EXIT || op == BPF_JCOND)
+		return false;
+	t = bpf_loop_at_index(env, n + insn->off + 1);
+	f = bpf_loop_at_index(env, n + 1);
+	return (t != h && !bpf_is_nested_loop(env, t, h)) ||
+	       (f != h && !bpf_is_nested_loop(env, f, h));
+}
+
+/* The same for an insn that is in the loop @h itself */
+bool bpf_insn_leaves_loop(struct bpf_verifier_env *env, int h, int n)
+{
+	if (bpf_loop_at_index(env, n) != h)
+		return false;
+	return bpf_jump_leaves_loop(env, h, n);
+}
+
 int bpf_compute_loops(struct bpf_verifier_env *env)
 {
 	int i, j, k, s, t, iloop, sloop, err = 0, len = env->prog->len;
diff --git a/kernel/bpf/scev.c b/kernel/bpf/scev.c
index 46ccce4ab130..853aac03d519 100644
--- a/kernel/bpf/scev.c
+++ b/kernel/bpf/scev.c
@@ -1499,6 +1499,25 @@ static int simplify(struct scev *scev, u32 id, void *priv)
 	int a, b, l, r, t, base, slope;
 	s64 imm1, imm2;
 
+	/* (- x imm) -> (+ x -imm) */
+	if (is_binop(scev, BPF_SUB, id, &l, &r) &&
+	    is_imm(scev, r, &imm1) && imm1 != S64_MIN)
+		return expr2(scev, BPF_ADD, l, imm_expr(scev, -imm1));
+
+	/* (+ (+ x imm) imm) -> (+ x imm) */
+	if (is_add(scev, id, &l, &r) &&
+	    is_imm(scev, r, &imm2) &&
+	    is_add(scev, l, &a, &b) &&
+	    is_imm(scev, b, &imm1))
+		return expr2(scev, BPF_ADD, a, imm_expr(scev, (s64)((u64)imm1 + (u64)imm2)));
+
+	/* (>> (<< x 32) 32) -> (zext32 x) */
+	if (is_binop(scev, BPF_RSH, id, &l, &r) &&
+	    is_imm(scev, r, &imm2) && imm2 == 32 &&
+	    is_binop(scev, BPF_LSH, l, &a, &b) &&
+	    is_imm(scev, b, &imm1) && imm1 == 32)
+		return expr1(scev, ZEXT32, a);
+
 	/* (+ (linear base slope) imm) -> (linear (+ base imm) slope) */
 	if (is_add(scev, id, &l, &r) &&
 	    is_linear(scev, l, &base, &slope) &&
@@ -2021,11 +2040,20 @@ static int match_linear_latch(struct bpf_verifier_env *env,
 	return false;
 }
 
+/* What is known about a scalar or about the offset of a pointer. */
 struct scev_value {
-	u64 value;	/* scalar value or a pointer offset */
+	u64 umin, umax;
+	s64 smin, smax;
+	u32 u32_min, u32_max;
+	s32 s32_min, s32_max;
 	int ptr_reg;	/* SCEV register identifying the pointer origin, or -1. */
 };
 
+static bool scev_value_is_const(const struct scev_value *v)
+{
+	return v->umin == v->umax;
+}
+
 static void log_scev_value(struct bpf_verifier_env *env, struct bpf_func_state *st,
 			   const struct scev_value *v)
 {
@@ -2035,8 +2063,10 @@ static void log_scev_value(struct bpf_verifier_env *env, struct bpf_func_state *
 		reg = scev_reg_for_read(env, st, v->ptr_reg);
 		log_reg(env, v->ptr_reg);
 		bpf_log(&env->log, " (%s)", reg ? reg_type_str(env, reg->type) : "unavailable");
+	} else if (scev_value_is_const(v)) {
+		bpf_log(&env->log, "scalar %llu", v->umin);
 	} else {
-		bpf_log(&env->log, "scalar %llu", v->value);
+		bpf_log(&env->log, "scalar %llu..%llu", v->umin, v->umax);
 	}
 }
 
@@ -2076,13 +2106,38 @@ static bool scev_value_add(struct bpf_verifier_env *env, struct bpf_func_state *
 			   const struct scev_value *a, const struct scev_value *b,
 			   struct scev_value *result)
 {
+	bool min_wraps, max_wraps;
+
 	if (a->ptr_reg >= 0 && b->ptr_reg >= 0) {
 		if (env->log.level & BPF_LOG_LEVEL2)
 			log_incompatible_scev_values(env, "can't add two pointers", st, a, b);
 		return false;
 	}
-	result->value = a->value + b->value;
 	result->ptr_reg = a->ptr_reg >= 0 ? a->ptr_reg : b->ptr_reg;
+
+	/* when both ends wrap around it is a range still */
+	min_wraps = check_add_overflow(a->umin, b->umin, &result->umin);
+	max_wraps = check_add_overflow(a->umax, b->umax, &result->umax);
+	if (min_wraps != max_wraps) {
+		result->umin = 0;
+		result->umax = U64_MAX;
+	}
+	if (check_add_overflow(a->smin, b->smin, &result->smin) ||
+	    check_add_overflow(a->smax, b->smax, &result->smax)) {
+		result->smin = S64_MIN;
+		result->smax = S64_MAX;
+	}
+	min_wraps = check_add_overflow(a->u32_min, b->u32_min, &result->u32_min);
+	max_wraps = check_add_overflow(a->u32_max, b->u32_max, &result->u32_max);
+	if (min_wraps != max_wraps) {
+		result->u32_min = 0;
+		result->u32_max = U32_MAX;
+	}
+	if (check_add_overflow(a->s32_min, b->s32_min, &result->s32_min) ||
+	    check_add_overflow(a->s32_max, b->s32_max, &result->s32_max)) {
+		result->s32_min = S32_MIN;
+		result->s32_max = S32_MAX;
+	}
 	return true;
 }
 
@@ -2096,13 +2151,23 @@ static bool eval_expr(struct bpf_verifier_env *env, struct scev *scev,
 
 	if (is_reg(scev, id, &regno)) {
 		reg = scev_reg_for_read(env, st, regno);
-		if (!reg || reg->type == NOT_INIT || !tnum_is_const(reg->var_off))
+		if (!reg || reg->type == NOT_INIT)
 			return false;
-		result->value = reg->var_off.value;
+		result->umin = reg_umin(reg);
+		result->umax = reg_umax(reg);
+		result->smin = reg_smin(reg);
+		result->smax = reg_smax(reg);
+		result->u32_min = reg_u32_min(reg);
+		result->u32_max = reg_u32_max(reg);
+		result->s32_min = reg_s32_min(reg);
+		result->s32_max = reg_s32_max(reg);
 		result->ptr_reg = reg->type == SCALAR_VALUE ? -1 : (int)regno;
 		return true;
 	} else if (is_imm(scev, id, &imm)) {
-		result->value = imm;
+		result->umin = result->umax = imm;
+		result->smin = result->smax = imm;
+		result->u32_min = result->u32_max = imm;
+		result->s32_min = result->s32_max = imm;
 		result->ptr_reg = -1;
 		return true;
 	} else if (is_add(scev, id, &l, &r) &&
@@ -2244,6 +2309,234 @@ static bool compute_backedge_taken_count(u8 op, u64 initial, u64 step, u64 bound
 	return true;
 }
 
+/*
+ * The first value of the induction variable at the latch and the bound it is
+ * compared with, as ranges of unsigned numbers. For a signed comparison the sign
+ * bit is flipped: that keeps the order and the differences.
+ * [lo, hi] is what the variable can be without wrapping around.
+ */
+struct latch_domain {
+	u64 imin, imax;
+	u64 bmin, bmax;
+	u64 lo, hi;
+};
+
+static void latch_domain(const struct linear_latch *latch, const struct scev_value *initial,
+			 const struct scev_value *bound, bool sign, struct latch_domain *d)
+{
+	u64 bias;
+
+	if (latch->jmp32) {
+		bias = sign ? 1U << 31 : 0;
+		d->imin = (sign ? (u32)initial->s32_min : initial->u32_min) ^ bias;
+		d->imax = (sign ? (u32)initial->s32_max : initial->u32_max) ^ bias;
+		d->bmin = (sign ? (u32)bound->s32_min : bound->u32_min) ^ bias;
+		d->bmax = (sign ? (u32)bound->s32_max : bound->u32_max) ^ bias;
+		d->lo = 0;
+		d->hi = U32_MAX;
+		return;
+	}
+	bias = sign ? 1ULL << 63 : 0;
+	d->bmin = (sign ? (u64)bound->smin : bound->umin) ^ bias;
+	d->bmax = (sign ? (u64)bound->smax : bound->umax) ^ bias;
+	if (latch->zext32) {
+		/* zero extended, so it is not negative */
+		d->imin = initial->u32_min ^ bias;
+		d->imax = initial->u32_max ^ bias;
+		d->lo = bias;
+		d->hi = bias + U32_MAX;
+		return;
+	}
+	d->imin = (sign ? (u64)initial->smin : initial->umin) ^ bias;
+	d->imax = (sign ? (u64)initial->smax : initial->umax) ^ bias;
+	d->lo = 0;
+	d->hi = U64_MAX;
+}
+
+/*
+ * '!=' with a step of one ends when the variable gets to the bound, given that
+ * it is on the right side of the bound to begin with.
+ */
+static bool count_ne_ranges(const struct latch_domain *d, bool down, u64 *cnt)
+{
+	if (d->bmin < d->lo || d->bmax > d->hi)
+		return false;
+	if (down ? d->imin < d->bmax : d->imax > d->bmin)
+		return false;
+	*cnt = down ? d->imax - d->bmin : d->bmax - d->imin;
+	return true;
+}
+
+static bool domain_add(const struct latch_domain *d, u64 v, s64 delta, u64 *res)
+{
+	if (delta >= 0 ? (u64)delta > d->hi - v : -(u64)delta > v - d->lo)
+		return false;
+	*res = v + delta;
+	return true;
+}
+
+/*
+ * The number of iterations depends on the first value, so 'first + slope * count'
+ * is far off when the first value is a range. There is a better bound for
+ * the variable that the latch tests. At the loop header it is
+ * - what it is at the entry, or
+ * - a value that the latch let through, @last is the last of them, plus what
+ *   is added between the latch and the header.
+ */
+static void latch_iv_range(struct bpf_verifier_env *env, struct bpf_func_state *st,
+			   const struct linear_latch *latch, const struct latch_domain *d,
+			   bool sign, bool down, u64 step, u64 last, struct bpf_loop_iters *iters)
+{
+	struct scev *scev = env->scev;
+	struct scev_value off, reg_val;
+	u64 bias, min, max, next;
+	u32 l, r, regno;
+	s64 c = 0;
+
+	l = latch->base_expr;
+	if (!is_reg(scev, l, &regno)) {
+		if (!is_add(scev, latch->base_expr, &l, &r) || !is_reg(scev, l, &regno) ||
+		    !eval_expr(env, scev, st, r, &off) || !scev_value_is_const(&off) ||
+		    off.ptr_reg >= 0)
+			return;
+		c = latch->jmp32 || latch->zext32 ? (s32)off.smin : off.smin;
+		if (c == S64_MIN)
+			return;
+	}
+	/* the lower half says nothing about a value that does not fit in it */
+	if (latch->jmp32 &&
+	    (!latch->zext32 || !eval_expr(env, scev, st, l, &reg_val) || reg_val.umax > U32_MAX))
+		return;
+	if (last < d->lo || last > d->hi ||
+	    !domain_add(d, d->imin, -c, &min) ||
+	    !domain_add(d, d->imax, -c, &max) ||
+	    !domain_add(d, last, -c, &next) ||
+	    !domain_add(d, next, down ? -(s64)step : (s64)step, &next))
+		return;
+	if (down)
+		min = min(min, next);
+	else
+		max = max(max, next);
+
+	if (latch->jmp32) {
+		bias = sign ? 1U << 31 : 0;
+		min ^= bias;
+		max ^= bias;
+		/* negative as s32 is large as zero extended u64 */
+		if (min > max)
+			return;
+		iters->iv_range = cnum64_from_urange(min, max);
+	} else if (sign) {
+		bias = 1ULL << 63;
+		iters->iv_range = cnum64_from_srange(min ^ bias, max ^ bias);
+	} else {
+		iters->iv_range = cnum64_from_urange(min, max);
+	}
+	iters->iv_reg = regno;
+}
+
+/*
+ * The first value or the bound is not a constant. The count is for the pair that is
+ * the furthest apart.
+ */
+static bool compute_backedge_taken_max(struct bpf_verifier_env *env, struct bpf_func_state *st,
+				       const struct linear_latch *latch,
+				       const struct scev_value *initial,
+				       const struct scev_value *step_val,
+				       const struct scev_value *bound,
+				       struct bpf_loop_iters *iters, u64 *result)
+{
+	struct scev *scev = env->scev;
+	bool sign = is_signed_op(latch->op), down;
+	struct scev_value reg_val;
+	struct latch_domain d;
+	/* the last value that the latch lets through */
+	u64 step, cnt, last;
+	u32 l, r;
+
+	/* halves of pointers are not compared */
+	if (initial->ptr_reg >= 0 && (latch->jmp32 || latch->zext32))
+		return false;
+	/*
+	 * (zext32 (linear ...)) is zext32() of something in all iterations but
+	 * the first one at the loop header, where it is what the register has.
+	 */
+	if (latch->zext32 && !latch->jmp32) {
+		l = latch->base_expr;
+		if (!is_reg(scev, l, &r) && !is_add(scev, latch->base_expr, &l, &r))
+			return false;
+		if (!eval_expr(env, scev, st, l, &reg_val) || reg_val.umax > U32_MAX)
+			return false;
+	}
+
+	step = latch->jmp32 || latch->zext32 ? (u64)(s64)(s32)step_val->umin : step_val->umin;
+	if (!step)
+		return false;
+	down = (s64)step < 0;
+	if (down)
+		step = -step;
+
+	latch_domain(latch, initial, bound, sign, &d);
+
+	/*
+	 * The value that ends the loop must not wrap around. It is less than a step
+	 * away from the bound whatever the first value is.
+	 */
+	switch (latch->op) {
+	case BPF_JLT:
+	case BPF_JSLT:
+		if (down || d.imin >= d.bmax ||
+		    check_add_overflow(div64_u64(d.bmax - d.imin - 1, step), 1, &cnt) ||
+		    d.bmax > d.hi || step - 1 > d.hi - d.bmax)
+			return false;
+		last = d.bmax - 1;
+		break;
+	case BPF_JLE:
+	case BPF_JSLE:
+		if (down || d.imin > d.bmax ||
+		    check_add_overflow(div64_u64(d.bmax - d.imin, step), 1, &cnt) ||
+		    d.bmax > d.hi || step > d.hi - d.bmax)
+			return false;
+		last = d.bmax;
+		break;
+	case BPF_JGT:
+	case BPF_JSGT:
+		if (!down || d.imax <= d.bmin ||
+		    check_add_overflow(div64_u64(d.imax - d.bmin - 1, step), 1, &cnt) ||
+		    d.bmin < d.lo || step - 1 > d.bmin - d.lo)
+			return false;
+		last = d.bmin + 1;
+		break;
+	case BPF_JGE:
+	case BPF_JSGE:
+		if (!down || d.imax < d.bmin ||
+		    check_add_overflow(div64_u64(d.imax - d.bmin, step), 1, &cnt) ||
+		    d.bmin < d.lo || step > d.bmin - d.lo)
+			return false;
+		last = d.bmin;
+		break;
+	case BPF_JNE:
+		if (step != 1)
+			return false;
+		if (!count_ne_ranges(&d, down, &cnt)) {
+			sign = true;
+			latch_domain(latch, initial, bound, true, &d);
+			if (!count_ne_ranges(&d, down, &cnt))
+				return false;
+		}
+		if (!cnt)
+			return false;
+		last = down ? d.bmin + 1 : d.bmax - 1;
+		break;
+	default:
+		return false;
+	}
+
+	latch_iv_range(env, st, latch, &d, sign, down, step, last, iters);
+	*result = cnt;
+	return true;
+}
+
 /*
  * Loop with post-condition:
  *
@@ -2280,8 +2573,11 @@ static bool compute_max_iters(struct bpf_verifier_env *env,
 	struct scev *scev = env->scev;
 	struct scev_value initial_val, step_val, bound_val;
 	u64 step, bound, initial, total_change, backedge_taken_count;
+	bool konst;
 	u8 op = latch->op;
 
+	iters->iv_reg = -1;
+
 	if (!eval_expr(env, scev, st, latch->base_expr, &initial_val) ||
 	    !eval_expr(env, scev, st, latch->step_expr, &step_val) ||
 	    !eval_expr(env, scev, st, latch->bound_expr, &bound_val))
@@ -2298,9 +2594,19 @@ static bool compute_max_iters(struct bpf_verifier_env *env,
 	if (!scev_value_compatible(env, st, &initial_val, &bound_val))
 		return false;
 
-	initial = initial_val.value;
-	step = step_val.value;
-	bound = bound_val.value;
+	if (!scev_value_is_const(&step_val))
+		return false;
+	konst = scev_value_is_const(&initial_val) && scev_value_is_const(&bound_val);
+	if (!konst) {
+		if (!compute_backedge_taken_max(env, st, latch, &initial_val, &step_val, &bound_val,
+						iters, &backedge_taken_count))
+			return false;
+		goto counted;
+	}
+
+	initial = initial_val.umin;
+	step = step_val.umin;
+	bound = bound_val.umin;
 
 	/*
 	 * The code below only handles mixed 64-bit/32-bit comparisons/recurrences
@@ -2321,9 +2627,9 @@ static bool compute_max_iters(struct bpf_verifier_env *env,
 			step    = (s64)(s32)(u32)step;
 		}
 	}
-	if (latch->zext32 ^ latch->jmp32 && (initial != initial_val.value ||
-					     bound != bound_val.value ||
-					     step != step_val.value)) {
+	if (latch->zext32 ^ latch->jmp32 && (initial != initial_val.umin ||
+					     bound != bound_val.umin ||
+					     step != step_val.umin)) {
 		if (env->log.level & BPF_LOG_LEVEL2)
 			bpf_log(&env->log,
 				"scev: mixed-width latch has operands outside 32-bit ranges\n");
@@ -2349,6 +2655,7 @@ static bool compute_max_iters(struct bpf_verifier_env *env,
 		}
 	}
 
+counted:
 	/*
 	 * max_header_count is u32 and U32_MAX means "infinite",
 	 * check to avoid overflow below.
@@ -2365,7 +2672,7 @@ static bool compute_max_iters(struct bpf_verifier_env *env,
 	 * In such case, conservatively assume that non-latch exit can happen
 	 * at any iteration, thus setting minimal number of iterations as 0.
 	 */
-	iters->min_header_count = loop->exits_cnt == 1 ? iters->max_header_count : 0;
+	iters->min_header_count = konst && loop->exits_cnt == 1 ? iters->max_header_count : 0;
 	return true;
 }
 
@@ -2391,6 +2698,19 @@ static bool is_unbound_scev_reg(struct bpf_verifier_env *env, const struct bpf_f
 	       reg->r64.size == U64_MAX && reg->r32.size == U32_MAX;
 }
 
+/*
+ * bpf_compute_const_regs() has @r as a constant at @insn_idx, the head of a loop: it's the same in
+ * every iteration. do_check() takes a value that a range adds to it, or to what is computed
+ * from it, for a bug.
+ */
+static bool is_const_scev_reg(struct bpf_verifier_env *env, int insn_idx, u32 r)
+{
+	struct bpf_insn_aux_data *aux = &env->insn_aux_data[insn_idx];
+
+	return r < ARRAY_SIZE(aux->const_reg_vals) &&
+	       ((aux->const_reg_mask | aux->const_reg_wide_mask) & BIT(r));
+}
+
 /* Main logic in verifier.c forbids varying offsets for certain register types. */
 static bool is_widenable_reg_type(const struct bpf_reg_state *reg)
 {
@@ -2571,6 +2891,14 @@ static void linear_bounds(struct bpf_reg_state *reg, u32 max_header_count,
 	out->r32 = r32;
 }
 
+static void iv_bounds(struct bounds *bounds, struct cnum64 iv_range)
+{
+	struct cnum64 r64 = cnum64_intersect(bounds->r64, iv_range);
+
+	if (!cnum64_is_empty(r64))
+		bounds->r64 = r64;
+}
+
 static int mark_expr_precise(struct bpf_verifier_env *env, struct bpf_func_state *st, u32 id,
 			     unsigned long *precise_regs)
 {
@@ -2595,6 +2923,71 @@ static int mark_expr_precise(struct bpf_verifier_env *env, struct bpf_func_state
 	return 0;
 }
 
+/*
+ * Nothing that @id is computed from is what a register had at the head of the loop, and
+ * some of it is not known: it's made anew in every iteration.
+ */
+static bool expr_is_fresh(struct bpf_verifier_env *env, u32 id)
+{
+	struct scev *scev = env->scev;
+	bool opaque = false;
+	u32 order, regno;
+
+	scev->stack_sz = 0;
+	expr_stack_push(scev, id);
+	while (expr_next(scev, &id, &order)) {
+		if (order & DEPTH_LIMIT)
+			return false;
+		if (!(order & PRE))
+			continue;
+		if (is_reg(scev, id, &regno) || is_op(scev, id, UNKNOWN))
+			return false;
+		if (is_opaque(scev, id))
+			opaque = true;
+	}
+	return opaque;
+}
+
+/*
+ * Does @id have no bit that register @r doesn't have at the head of the loop? 'x & e' and the
+ * low bits of x lose bits only. 'x >> e', 'x / e' and 'x % e' are not greater than x as well, but
+ * iterations one by one tell more about them: a number that is halved 8 times.
+ */
+static bool expr_loses_bits_only(struct scev *scev, u32 id, u32 r, int depth)
+{
+	struct expr *e = &scev->exprs[id];
+	u32 regno;
+
+	if (is_reg(scev, id, &regno))
+		return regno == r;
+	if (depth > 8)
+		return false;
+	switch (e->op) {
+	case BPF_AND:
+		return expr_loses_bits_only(scev, e->params[0], r, depth + 1) ||
+		       expr_loses_bits_only(scev, e->params[1], r, depth + 1);
+	case ANY:
+		return expr_loses_bits_only(scev, e->params[0], r, depth + 1) &&
+		       expr_loses_bits_only(scev, e->params[1], r, depth + 1);
+	case ZEXT8:
+	case ZEXT16:
+	case ZEXT32:
+		return expr_loses_bits_only(scev, e->params[0], r, depth + 1);
+	default:
+		return false;
+	}
+}
+
+/* Nothing but [0, max] is known about @reg. */
+static bool reg_is_zero_to_max(const struct bpf_reg_state *reg)
+{
+	struct cnum64 r64 = cnum64_from_urange(0, reg_umax(reg));
+
+	return cnum64_is_subset(reg->r64, r64) &&
+	       cnum32_is_subset(reg->r32, cnum32_from_cnum64(r64)) &&
+	       tnum_in(reg->var_off, tnum_range(0, reg_umax(reg))) && reg->step <= 1;
+}
+
 int bpf_compute_loop_iters(struct bpf_verifier_env *env, struct bpf_verifier_state *st,
 			   struct bpf_loop_iters *iters)
 {
@@ -2609,7 +3002,7 @@ int bpf_compute_loop_iters(struct bpf_verifier_env *env, struct bpf_verifier_sta
 	struct bpf_loop_iters tmp;
 	struct bpf_loop *loop;
 	int insn_idx = st->insn_idx;
-	bool found = false;
+	bool found = false, walk = false;
 	int linear_latch;
 	int latch_idx;
 	int err, j;
@@ -2665,6 +3058,8 @@ int bpf_compute_loop_iters(struct bpf_verifier_env *env, struct bpf_verifier_sta
 		}
 		if (!found || tmp.max_header_count < iters->max_header_count) {
 			iters->max_header_count = tmp.max_header_count;
+			iters->iv_reg = tmp.iv_reg;
+			iters->iv_range = tmp.iv_range;
 			best = latch;
 		}
 		iters->min_header_count = found ? min(iters->min_header_count, tmp.min_header_count)
@@ -2703,6 +3098,9 @@ int bpf_compute_loop_iters(struct bpf_verifier_env *env, struct bpf_verifier_sta
 	if (err)
 		return err;
 
+	bitmap_zero(iters->forget_regs, REGS_NUM);
+	bitmap_zero(iters->mask_regs, REGS_NUM);
+	iters->spill_base = false;
 	header_env = find_header_env(scev, insn_idx);
 	for (r = 0; r < REGS_NUM; r++) {
 		struct bpf_reg_state *reg;
@@ -2724,10 +3122,23 @@ int bpf_compute_loop_iters(struct bpf_verifier_env *env, struct bpf_verifier_sta
 		if (is_unbound_scev_reg(env, cur_func, r))
 			continue;
 
+		if (is_const_scev_reg(env, insn_idx, r))
+			continue;
+
 		r_scev = header_env->reg2scev[r];
 		reg = scev_reg_for_linear(cur_func, r);
+		/*
+		 * The offset of a pointer to arena is not tracked, so there is nothing to lose.
+		 * If the loop makes something else of it the state that returns to the head
+		 * is not covered by the state at the head.
+		 */
+		if (reg && reg->type == PTR_TO_ARENA) {
+			__set_bit(r, iters->forget_regs);
+			continue;
+		}
 		/* If SCEV for r is (linear <reg> <slope>) */
-		if (reg && is_simple_linear(scev, r_scev, &coefs) && is_widenable_reg_type(reg)) {
+		if (reg && is_simple_linear(scev, r_scev, &coefs) && is_widenable_reg_type(reg) &&
+		    (!coefs.zext32 || reg->type == SCALAR_VALUE)) {
 			/* Spills at varying offsets lose precision */
 			if (test_bit(r, loop->store_base_regs)) {
 				spill_base = true;
@@ -2748,6 +3159,18 @@ int bpf_compute_loop_iters(struct bpf_verifier_env *env, struct bpf_verifier_sta
 			}
 			continue;
 		}
+
+		/*
+		 * [0, max] that loses bits is in [0, max]: what enters the loop stands for all
+		 * iterations as it is. For 64 or [64, 127] that range would have values in it that
+		 * are made up.
+		 */
+		if (reg && reg->type == SCALAR_VALUE && !test_bit(r, loop->store_base_regs) &&
+		    reg_is_zero_to_max(reg) &&
+		    expr_loses_bits_only(scev, header_env->reg2expr[r], r, 0)) {
+			__set_bit(r, iters->mask_regs);
+			continue;
+		}
 cant_widen:
 		if (log->level & BPF_LOG_LEVEL2) {
 			r_expr = header_env->reg2expr[r];
@@ -2759,7 +3182,17 @@ int bpf_compute_loop_iters(struct bpf_verifier_env *env, struct bpf_verifier_sta
 				bpf_log(log, ", requires exact stack-offset tracking");
 			bpf_log(log, "\n");
 		}
-		return 0;
+		/* the count stands, it is this one that is not known in the loop */
+		if (spill_base)
+			iters->spill_base = true;
+		else
+			__set_bit(r, iters->forget_regs);
+		/*
+		 * What is loaded from memory or returned by a call in every iteration is
+		 * as little known when iterations are looked at one by one.
+		 */
+		if (spill_base || !expr_is_fresh(env, header_env->reg2expr[r]))
+			walk = true;
 	}
 
 	bitmap_zero(iters->precise_regs, REGS_NUM);
@@ -2773,7 +3206,47 @@ int bpf_compute_loop_iters(struct bpf_verifier_env *env, struct bpf_verifier_sta
 	if (err)
 		return err;
 
-	return 1;
+	/* 2: the count is known, what some of the live registers are is not */
+	return walk ? 2 : 1;
+}
+
+/* The loop changes @r in a way that has no summary. If it is a number it is not known. */
+static void scev_forget_reg(struct bpf_verifier_env *env, struct bpf_func_state *func, u32 r)
+{
+	struct bpf_stack_state *stack;
+	int i;
+
+	if (r < MAX_BPF_REG) {
+		if (func->regs[r].type == SCALAR_VALUE) {
+			bpf_mark_reg_unknown_imprecise(&func->regs[r]);
+			mark_scev_reg_scratched(env, r);
+		} else if (func->regs[r].type == PTR_TO_ARENA) {
+			/* NULL or not is all that is known about it */
+			bpf_reg_forget_range(&func->regs[r]);
+			mark_scev_reg_scratched(env, r);
+		}
+		return;
+	}
+	stack = scev_regno_to_stack(func, r);
+	if (!stack)
+		return;
+	if (bpf_is_spilled_reg(stack) && stack->spilled_ptr.type == PTR_TO_ARENA) {
+		bpf_reg_forget_range(&stack->spilled_ptr);
+		mark_scev_reg_scratched(env, r);
+		return;
+	}
+	if (bpf_is_spilled_reg(stack) && stack->spilled_ptr.type != SCALAR_VALUE)
+		return;
+	for (i = 0; i < BPF_REG_SIZE; i++)
+		if (stack->slot_type[i] == STACK_SPILL || stack->slot_type[i] == STACK_ZERO)
+			break;
+	if (i == BPF_REG_SIZE)
+		return;
+	for (i = 0; i < BPF_REG_SIZE; i++)
+		if (stack->slot_type[i] == STACK_SPILL || stack->slot_type[i] == STACK_ZERO)
+			stack->slot_type[i] = STACK_MISC;
+	bpf_mark_reg_not_init(env, &stack->spilled_ptr);
+	mark_scev_reg_scratched(env, r);
 }
 
 /* bpf_compute_loop_iters() checked that every leaf can be unioned into acc. */
@@ -2841,8 +3314,29 @@ int bpf_widen_scev_regs(struct bpf_verifier_env *env, struct bpf_verifier_state
 
 	header_env = find_header_env(scev, insn_idx);
 	for (r = 0; r < REGS_NUM; r++) {
-		if (!scev_reg_alive(env, st, r) || is_unbound_scev_reg(env, cur_func, r))
+		if (!scev_reg_alive(env, st, r) || is_unbound_scev_reg(env, cur_func, r) ||
+		    is_const_scev_reg(env, insn_idx, r))
+			continue;
+
+		if (test_bit(r, iters->forget_regs)) {
+			scev_forget_reg(env, cur_func, r);
+			continue;
+		}
+		if (test_bit(r, iters->mask_regs)) {
+			/* The range stays. It's no longer equal to the registers with its id. */
+			err = scev_reg_for_write(env, cur_func, r, &reg);
+			if (err)
+				return err;
+			if (log->level & BPF_LOG_LEVEL2) {
+				bpf_log(log, "loop header at %d, ", insn_idx);
+				log_reg(env, r);
+				bpf_log(log, " stays in 0..%llu, it loses bits only\n",
+					reg_umax(reg));
+			}
+			scratch_widened_reg_id(env, reg);
+			mark_scev_reg_scratched(env, r);
 			continue;
+		}
 
 		r_expr = header_env->reg2scev[r];
 		/* If SCEV for r is (linear <reg> <slope>)*/
@@ -2851,6 +3345,8 @@ int bpf_widen_scev_regs(struct bpf_verifier_env *env, struct bpf_verifier_state
 			if (err)
 				return err;
 			linear_bounds(reg, iters->max_header_count, &coefs, &bounds);
+			if (r == iters->iv_reg)
+				iv_bounds(&bounds, iters->iv_range);
 			if (log->level & BPF_LOG_LEVEL2) {
 				bpf_log(log, "loop header at %d, widening ", insn_idx);
 				log_reg(env, r);
@@ -2888,9 +3384,11 @@ int bpf_widen_scev_regs(struct bpf_verifier_env *env, struct bpf_verifier_state
 }
 
 int bpf_clamp_scev_regs(struct bpf_verifier_env *env, struct bpf_func_state *cur_func_state, u32 insn_idx,
-			struct bpf_verifier_state *entry_state, u32 max_header_count)
+			const struct loop_stack_entry *entry)
 {
+	struct bpf_verifier_state *entry_state = entry->entry_state;
 	struct bpf_func_state *entry_st = entry_state->frame[entry_state->curframe];
+	u32 max_header_count = entry->max_header_count;
 	struct bpf_verifier_log *log = &env->log;
 	struct bpf_reg_state *reg, *entry_reg;
 	struct scev *scev = env->scev;
@@ -2921,7 +3419,14 @@ int bpf_clamp_scev_regs(struct bpf_verifier_env *env, struct bpf_func_state *cur
 		    is_unbound_scev_reg(env, entry_st, r))
 			continue;
 
+		/* what was not summarized at the entry is not to be trusted here */
+		if (!is_widenable_reg_type(entry_reg) || entry_reg->type != reg->type ||
+		    (coefs.zext32 && entry_reg->type != SCALAR_VALUE))
+			continue;
+
 		linear_bounds(entry_reg, max_header_count, &coefs, &bounds);
+		if (r == entry->iv_reg)
+			iv_bounds(&bounds, entry->iv_range);
 		r64 = cnum64_intersect(reg->r64, bounds.r64);
 		r32 = cnum32_intersect(reg->r32, bounds.r32);
 		/*
@@ -2951,3 +3456,255 @@ int bpf_clamp_scev_regs(struct bpf_verifier_env *env, struct bpf_func_state *cur
 	}
 	return 0;
 }
+
+/*
+ * The number of iterations of the loop that @st enters is not known. Make @st
+ * stand for all of them as far as there is a summary of what the loop does:
+ * - a variable that a constant is added to can be anything, anything that
+ *   fits in 32 bits if it is computed in 32 bits,
+ * - a variable that is set to one of several values is one of them.
+ * The rest is left as it is: the state that comes back to the loop head tells.
+ * Guessing here would make up values that the program never has.
+ */
+
+/*
+ *	do { arr[i] = i; i--; } while (i < 1000);
+ * What register @r may be at the head of the loop: what it is at the entry, or what the
+ * jump that closes the loop lets through. It's a guess. The state that comes back to
+ * the head is compared with it like with any other state.
+ */
+static bool latch_range(struct bpf_verifier_env *env, struct bpf_loop *loop, int header, u32 r,
+			const struct bpf_reg_state *entry, struct cnum64 *range)
+{
+	struct bpf_insn *insn;
+	u64 uk;
+	s64 sk;
+	int idx;
+	u8 op;
+
+	if (r >= MAX_BPF_REG ||
+	    loop->backedges_cnt != 1 || loop->backedges_overflow)
+		return false;
+	idx = loop->backedges[0].from;
+	insn = &env->prog->insnsi[idx];
+	if (BPF_CLASS(insn->code) != BPF_JMP || BPF_SRC(insn->code) != BPF_K || insn->dst_reg != r)
+		return false;
+	op = BPF_OP(insn->code);
+	sk = insn->imm;
+	uk = sk;
+	if (idx + 1 == header && idx + insn->off + 1 != header) {
+		/* the loop goes on when the jump is not taken */
+		op = bpf_rev_opcode(op);
+	} else if (idx + insn->off + 1 != header) {
+		return false;
+	}
+	switch (op) {
+	case BPF_JLT:
+		if (!uk)
+			return false;
+		*range = cnum64_from_urange(0, uk - 1);
+		break;
+	case BPF_JLE:
+		*range = cnum64_from_urange(0, uk);
+		break;
+	case BPF_JGT:
+		if (uk == U64_MAX)
+			return false;
+		*range = cnum64_from_urange(uk + 1, U64_MAX);
+		break;
+	case BPF_JGE:
+		*range = cnum64_from_urange(uk, U64_MAX);
+		break;
+	case BPF_JSLT:
+		if (sk == S64_MIN)
+			return false;
+		*range = cnum64_from_srange(S64_MIN, sk - 1);
+		break;
+	case BPF_JSLE:
+		*range = cnum64_from_srange(S64_MIN, sk);
+		break;
+	case BPF_JSGT:
+		if (sk == S64_MAX)
+			return false;
+		*range = cnum64_from_srange(sk + 1, S64_MAX);
+		break;
+	case BPF_JSGE:
+		*range = cnum64_from_srange(sk, S64_MAX);
+		break;
+	default:
+		return false;
+	}
+	*range = cnum64_union(*range, entry->r64);
+	return true;
+}
+
+/*
+ *	elem = NULL; found = false;
+ *	loop { if (...) { found = true; elem = v; } }
+ *	if (found) use(*elem);
+ * The union of what "found" may be is known at the entry of the loop, what "elem" may be is
+ * not. [0, 1] next to NULL is something that the program never gets to. Leave such a
+ * loop alone: (1, pointer) that comes back has no join with (0, 0).
+ */
+static bool loop_looks_for_something(struct bpf_verifier_env *env, struct bpf_verifier_state *st,
+				     struct env *header_env)
+{
+	struct bpf_func_state *func = st->frame[st->curframe];
+	const struct bpf_reg_state *reg;
+	u32 r, left, right;
+
+	for (r = 0; r < REGS_NUM; r++) {
+		if (r == BPF_REG_FP || !scev_reg_alive(env, st, r) ||
+		    is_unbound_scev_reg(env, func, r))
+			continue;
+		reg = scev_reg_for_read(env, func, r);
+		if (reg && reg->type == SCALAR_VALUE && tnum_equals_const(reg->var_off, 0) &&
+		    is_any(env->scev, header_env->reg2scev[r], &left, &right) &&
+		    !is_widenable_any(env, func, header_env, r, header_env->reg2scev[r]))
+			return true;
+	}
+	return false;
+}
+
+/*
+ * @st enters a loop and the number of iterations is not known. Make @st stand for all of them
+ * ahead of time, it saves trips through the loop:
+ * - a counter, r = r + c, is what the jump that closes the loop lets through, see latch_range(),
+ *   32 bit if it's computed in 32 bit, otherwise it's not known,
+ * - a register that gets one of a few values that don't change in the loop is their union.
+ * It's a guess. The state that comes back to the head is compared with it like with any other.
+ */
+int bpf_scev_forget_regs(struct bpf_verifier_env *env, struct bpf_verifier_state *st)
+{
+	struct bpf_func_state *func = st->frame[st->curframe];
+	struct bpf_loop *loop = env->insn_aux_data[st->insn_idx].loop;
+	struct scev *scev = env->scev;
+	struct bpf_reg_state *reg;
+	struct env *header_env;
+	struct linear_coefs coefs;
+	struct cnum64 range;
+	u32 r, r_scev;
+	bool search;
+	int err;
+
+	err = bpf_live_stack_query_init(env, st);
+	if (err)
+		return err;
+
+	header_env = find_header_env(scev, st->insn_idx);
+	if (!header_env)
+		return 0;
+	search = loop_looks_for_something(env, st, header_env);
+	for (r = 0; r < REGS_NUM; r++) {
+		if (r == BPF_REG_FP || !scev_reg_alive(env, st, r) ||
+		    is_unbound_scev_reg(env, func, r))
+			continue;
+		r_scev = header_env->reg2scev[r];
+		reg = scev_reg_for_linear(func, r);
+		if (is_simple_linear(scev, r_scev, &coefs) && coefs.base_reg == r &&
+		    reg && reg->type == SCALAR_VALUE) {
+			if (latch_range(env, loop, st->insn_idx, r, reg, &range)) {
+				err = scev_reg_for_write(env, func, r, &reg);
+				if (err)
+					return err;
+				scratch_widened_reg_id(env, reg);
+				err = bpf_set_reg_range(env, reg, range, CNUM32_UNBOUNDED, 0, 1);
+				if (err)
+					return err;
+				mark_scev_reg_scratched(env, r);
+				continue;
+			}
+			if (!coefs.zext32 || reg_smin(reg) < 0 || reg_smax(reg) > U32_MAX) {
+				scev_forget_reg(env, func, r);
+				continue;
+			}
+			err = scev_reg_for_write(env, func, r, &reg);
+			if (err)
+				return err;
+			scratch_widened_reg_id(env, reg);
+			err = bpf_set_reg_range(env, reg, cnum64_from_urange(0, U32_MAX),
+						CNUM32_UNBOUNDED, 0, 1);
+			if (err)
+				return err;
+			mark_scev_reg_scratched(env, r);
+		} else if (!search && is_widenable_any(env, func, header_env, r, r_scev) &&
+			   !test_bit(r, loop->store_base_regs)) {
+			err = scev_reg_for_write(env, func, r, &reg);
+			if (err)
+				return err;
+			/* the leaves are invariant, so @func is as good as a copy of it */
+			err = union_any_reg(env, func, reg, r_scev);
+			if (err)
+				return err;
+			scratch_widened_reg_id(env, reg);
+			mark_scev_reg_scratched(env, r);
+		}
+	}
+	return 0;
+}
+
+/* Everything that @id is computed from is a constant in @func. */
+static bool expr_is_const(struct bpf_verifier_env *env, struct bpf_func_state *func, u32 id)
+{
+	const struct bpf_reg_state *reg;
+	struct scev *scev = env->scev;
+	u32 order, regno, l, r;
+	s64 imm;
+
+	scev->stack_sz = 0;
+	expr_stack_push(scev, id);
+	while (expr_next(scev, &id, &order)) {
+		if (order & DEPTH_LIMIT)
+			return false;
+		if (!(order & PRE) || is_imm(scev, id, &imm))
+			continue;
+		if (is_reg(scev, id, &regno)) {
+			reg = scev_reg_for_read(env, func, regno);
+			if (!reg || reg->type != SCALAR_VALUE || !tnum_is_const(reg->var_off))
+				return false;
+			continue;
+		}
+		if (is_opaque(scev, id) || is_op(scev, id, UNKNOWN) || is_any(scev, id, &l, &r))
+			return false;
+	}
+	return true;
+}
+
+/*
+ * @st enters a loop. Is it known which way one of the jumps that leave it goes in the first
+ * iteration? Then the loop counts something in a way that has no summary, and going
+ * through its iterations one by one is likely to get to its end.
+ */
+bool bpf_scev_latch_decided(struct bpf_verifier_env *env, struct bpf_verifier_state *st)
+{
+	struct bpf_func_state *func = st->frame[st->curframe];
+	struct bpf_loop *loop = env->insn_aux_data[st->insn_idx].loop;
+	struct bpf_insn *insn;
+	struct env *latch_env;
+	int latch_idx, i;
+
+	if (!env->allow_uninit_stack)
+		return false;
+	if (!loop || loop->irreducible || loop->backedges_cnt != 1 || loop->backedges_overflow)
+		return false;
+	/* and the head of the loop: it's not among the latches of a back edge from a nested loop */
+	for (i = 0; i <= loop->backedges[0].latches_cnt; i++) {
+		if (i < loop->backedges[0].latches_cnt)
+			latch_idx = loop->backedges[0].latches[i];
+		else if (bpf_insn_leaves_loop(env, st->insn_idx, st->insn_idx))
+			latch_idx = st->insn_idx;
+		else
+			break;
+		insn = &env->prog->insnsi[latch_idx];
+		if (bpf_is_may_goto_insn(insn))
+			return false;
+		latch_env = find_loop_env(env->scev, st->insn_idx, latch_idx);
+		if (!latch_env)
+			continue;
+		if (expr_is_const(env, func, latch_env->reg2expr[insn->dst_reg]) &&
+		    (BPF_SRC(insn->code) == BPF_K ||
+		     expr_is_const(env, func, latch_env->reg2expr[insn->src_reg])))
+			return true;
+	}
+	return false;
+}
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index bb42c2707db2..32b256bc1513 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -19862,6 +19862,7 @@ bool bpf_get_call_summary(struct bpf_verifier_env *env, struct bpf_insn *call,
 				bpf_jit_inlines_helper_call(call->imm));
 		cs->is_void = fn->ret_type == RET_VOID;
 		cs->arg_slot_cnt = 0;
+		cs->implicit_slot_cnt = 0;
 		for (i = 0; i < ARRAY_SIZE(fn->arg_type); ++i) {
 			if (fn->arg_type[i] == ARG_UNUSED)
 				break;
@@ -19878,6 +19879,14 @@ bool bpf_get_call_summary(struct bpf_verifier_env *env, struct bpf_insn *call,
 			/* error would be reported later */
 			return false;
 		cs->arg_slot_cnt = btf_proto_slots(meta.btf, meta.func_proto);
+		cs->implicit_slot_cnt = 0;
+		if (meta.kfunc_flags & KF_IMPLICIT_ARGS) {
+			const struct btf_type *func = btf_type_by_id(meta.btf, meta.func_id);
+
+			/* the prototype without implicit args, see is_kfunc_arg_implicit() */
+			cs->implicit_slot_cnt = cs->arg_slot_cnt -
+				btf_proto_slots(meta.btf, btf_type_by_id(meta.btf, func->type));
+		}
 		cs->fastcall = meta.kfunc_flags & KF_FASTCALL;
 		cs->is_void = btf_type_is_void(btf_type_by_id(meta.btf, meta.func_proto->type));
 		return true;
@@ -20716,8 +20725,7 @@ static int maybe_clamp_scev_regs(struct bpf_verifier_env *env)
 	if (!entry->terminates)
 		return 0;
 
-	return bpf_clamp_scev_regs(env, frame, env->insn_idx, entry->entry_state,
-				   entry->max_header_count);
+	return bpf_clamp_scev_regs(env, frame, env->insn_idx, entry);
 }
 
 static int handle_loop_entry_exit(struct bpf_verifier_env *env)
@@ -20763,6 +20771,8 @@ static int handle_loop_entry_exit(struct bpf_verifier_env *env)
 
 	entry->min_header_count = iters.min_header_count;
 	entry->max_header_count = iters.max_header_count;
+	entry->iv_reg = iters.iv_reg;
+	entry->iv_range = iters.iv_range;
 	entry->entry_state = cur->parent;
 	entry->terminates = true;
 	err = bpf_widen_scev_regs(env, cur, cur->parent, &iters);
-- 
2.55.0

