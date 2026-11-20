Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795208059;
	b=Q/nr4cT7BUP4w8MObUfSciWjym6Wp2QvZRwjGBNLOunibGN5XCJn6qTHlGN7DQA7Fizb
	 eUS5eThVJF8cJ0ioZNqA5khtX1h5fS1q27YiHy0dT1Fc4ZTmGFW+ookXMxUeWccCIHviM
	 faG98ibzpvRghQUI8hijyg/IdHhSNCFC3iXNo41A52pgL107Erqd/s9qa4gub9Kee6aus
	 Q5NhS9bWdE+oAh+wqsTdTTwbuQbIVFzKLWdu46duYF7M+Y7ElCYwmTHUWUVszBVe431j0
	 6Vb32GdxSegIkTPRD3aauKPui1VXsjAkxwAi/OYouKWmBUfBqqMJO+oMgr0EJndUTPg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795208059;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Hbd/S/OATjpXxkEdJaVDW5Sjq06W6/QHjjeE7kBslrI=;
	b=KCQ/1DY6L8zQzET+AK5OequGCg9rPu9SAB3LLponTr3ywLcAilecRtrKTjzDJ68Lg0Qq
	 DL1Dmw+Dbjk+CoRo1qldlACUXTpphukRLNe2Fjh+usB9fipuasOYNrsjwhLKFgXN+QplM
	 IWfFg7ho4EK2rWO9cBGSaFg/lizfQlr3e9qTBXAwJTUVUh7in/gB/efGERcEd1Byw8Imv
	 BkNur1rOsO7OwJvYXx1x54q9/8bIkZts/g3JmymPoEOnBQfOGNtgAc6Js+LQ+FsIZ2nZO
	 QJYvL2BinEZlyedPup/oZUeRKcnX7BYUyYHl3O1kc75WVE9mRZjFIsELfEqix5LNlGg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wkcQY0mQ;
	arc=none smtp.remote-ip=209.85.215.181
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97D10606A6A4
	for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 20:54:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 97D10606A6A4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wkcQY0mQ
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-cdb1199bfd8so683854a12.1
        for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 12:54:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795208057; x=1795812857; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Hbd/S/OATjpXxkEdJaVDW5Sjq06W6/QHjjeE7kBslrI=;
        b=wkcQY0mQvL9v3zRqdR8H8bB+dhGrEQEE+i+zd4eQSZJz+BUJ0YFXBjCb5+ZJB8Q4n+
         IP5KpJaZn8xtMzw1B+UI+VAuZQQhxvz6DM5PrAcQ1Cs86g/LI83E9cahDJW4hnc+HqqP
         nzfqecbsQCX8MsxoBwuos1bNvafSUtzy+RHtPh0XmZLbTgjxJFbxIX2sVf7vP+wUV3Ga
         Q8ZOHMXOIlFUeokpKWG7dO6fET5TdUiOL0KojeGg7jHt6L1YPH63svuwah89T9zEXroi
         TIo3/3nc4DEjE0GjlO8Nhq8TE8MgKD+H6e158DEp2u6FeO+gIu8fGaSrwPwBwYKo9eNn
         SMjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795208057; x=1795812857;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Hbd/S/OATjpXxkEdJaVDW5Sjq06W6/QHjjeE7kBslrI=;
        b=uh8tJpHmeBuTfAL2cBne3nBGxHBlaAqOihWdXfh1cWTdgWuoOaPATMyoxj1OY1ox+F
         Ld1spiQRF9Yexh+9qLCYk9eWIyVb1XNyBYj3UVHBxhuOJgtpOa4/+sVk/as67tpevtEV
         9GWkPrtWyyuZwtu3rrJryJqWQ//DOObmG8QD7LliRsJUSR1sOc+J8T7IKX0uPmzc1GGt
         UvvmSyT/zJ23BE/cHgsMU/akhVq0Fhagqnw/IcPh9Gq1W/X8tuVLbZ2SBzHltArrXjSl
         hTd1yiF1U5mblSsrXuwi530f6GV8W1FdDmjqBLndJ3Y8dTviRzma0mV+WbVn/SHF/h5s
         s8lw==
X-Gm-Message-State: APuU4Z8e5WzcGF2uXlF3iOgMXBy98tIgi86RJ41+jK5QXokw5N6gQefN
	WBhef0/VUeGFaZvxE1UyFiW3gQI5lDoOXbo07gkm4nDpnL8yUCaeUEaZiRrOww==
X-Gm-Gg: AZFdTZfpejngvSsvyW4nYTuqa1yHL2l5/G5lwTfp1bJBaglasNabPIfJBaZz56Xw4KG
	SO54TfOsrYoSfw0xELL3LQTIVIfCZbRAiXvy59lXbWGQoOH7FA0+NbQDq1ct5PnCckdHgaHfuAM
	xGkerNWc4DtTsxxBipXaTMESl4HtAaaAXSEvLM8AB83dRdyp9GTuSzEPwOPmB8gRGTzxpOpHW/9
	M/ZCC9lm5SyS4wtCfPzzSij/KA9hbjV78+akRy6AzV0OOJswxRuKqMTpP+iF4f9HvyVrfuNwZa+
	WhT0NuJ9z96Ns/bxLy5bFXalOdK+u7eGiGia6CacUEAeuVWIEdBmkeZYAQ8ARulLlTQ2jDNZxPU
	+ujx7OmweHSqRa9agg26QLeqLiPx48VFvFVofZn1pQBD8BYnp0lfdUlQO5nZwNK78BZgHJbdF9s
	azBI5XwvKNWEVjMUh6i0dkajF8lRo0tm5393RlIhjLNXj0EAcVVqcHU+rRPcB+6dron2kCgQ7a6
	Q242xFUHif00xM5VRxw6mtkjqXc8UuJpYOrE4rqbC3cq7X5WSIGPzkysoTgGLAwhyVexoT8Aosv
	iCDktHgM9wZD69SsHudh3DjpnOmElsiPxTfTTUqOzI01kHf5BGGpouOWEqiWVtwe5nffnxYH5Wy
	GNXi0hlqoWAW0D+lGiNzD3aCHDsJDMZAlOHxO6P+iP+asjoJTLeUy30EJeqwRFMhVFBm0U5PZrE
	NME846f+ikrPMkWiDZSdM=
X-Received: by 2002:a17:90a:e7d0:b0:3b1:8396:ebf8 with SMTP id 98e67ed59e1d1-3b41c9325bcmr3942089a91.36.1795208056476;
        Fri, 20 Nov 2026 12:54:16 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.252])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b420e1307csm4488474a91.7.2026.11.20.12.54.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 12:54:16 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next v2 43/49] bpf: Keep spilled pointers at a range of stack offsets
Date: Fri, 20 Nov 2026 20:49:51 +0000
Message-ID: <20261120204959.614908-44-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261120204959.614908-1-alexei.starovoitov@gmail.com>
References: <20261120204959.614908-1-alexei.starovoitov@gmail.com>
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

An access to the stack with a range of offsets forgets the pointers
that are spilled in the range. The access is proven, and a later use of
the pointer is unproven. Two cases need no such loss.

1. A call writes at one of several offsets:

     *(u64 *)(r10 - 16) = ptr
     r1 = fp-24 or fp-8           the join is fp-24..fp-8, step 16
     r2 = 8
     call bpf_probe_read_kernel   it does not touch fp-16

   Skip the bytes between two offsets. The size has to be a constant,
   see size_at_max_offset().

2. A load reads one element of an array of pointers:

     char *p[2] = { a, b };
     bpf_for(i, 0, 2)
             sum += p[i][63];

   i is 0..1 in each trip. The range comes from a load and a test, not
   from a join. So it does not help to keep states apart.
   fork_stack_load() does the load once for each slot:

     r1 = *(u64 *)(r2 + 0)

     r2 = fp-16 or fp-8  --+--> r2 = fp-16, r1 = a
                           +--> r2 = fp-8,  r1 = b

   The equations refine the related numbers: i is 0 in the first state
   and 1 in the second one.

   A program can also use such a word as a number. 'sum += word[i]'
   fails if the word is a pointer. So a load forks only if its result
   flows into an insn that needed a pointer and got a number. ADD_DEPS
   finds these loads with one more backward slice. The slice follows
   both operands of an add. So if a program adds such a word to such a
   pointer, both loads fork, and the add can fail.

   The cpu can speculate with the address of another state, so the fork
   needs bypass_spec_v1.

                                             insns processed
  program                                bpf-next   without   with
  wprof wprof_task_switch                32379      123446    79727
  tetragon generic_lsm_process_event     114211     64030     31347
  tracee trace_ret_vfs_write             5418       9413      3495
  bpf_flow flow_dissector_0              715        2235      701

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/bpf_verifier.h |  5 +++
 kernel/bpf/equation.c        | 10 +++++
 kernel/bpf/precision.c       | 60 +++++++++++++++++++++++++
 kernel/bpf/precision.h       |  4 ++
 kernel/bpf/verifier.c        | 87 ++++++++++++++++++++++++++++++++++--
 5 files changed, 163 insertions(+), 3 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index bb20fde51f0..ce7675dd4dc 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -1038,6 +1038,7 @@ struct bpf_insn_aux_data {
 	 * are not in @use_regs. The bits above r10 are not valid.
 	 */
 	u16 use_regs, def_regs;
+	u16 needs_ptr_regs;	/* see bpf_note_needs_ptr() */
 	/*
 	 * Bitmask of R0-R9 that hold known values at this instruction.
 	 * const_reg_mask: scalar constants that fit in 32 bits.
@@ -1762,6 +1763,8 @@ void bpf_precision_new_pass(struct bpf_verifier_env *env);
 u64 bpf_pass_max_cost(struct bpf_verifier_env *env);
 u64 bpf_precision_budget(struct bpf_verifier_env *env);
 u64 bpf_precision_first_budget(struct bpf_verifier_env *env);
+void bpf_note_needs_ptr(struct bpf_verifier_env *env, const struct bpf_reg_state *reg);
+bool bpf_insn_makes_ptr(struct bpf_verifier_env *env);
 bool bpf_failing_path_is_due(struct bpf_verifier_env *env);
 int bpf_failing_path_prepare(struct bpf_verifier_env *env, bool repeat);
 bool bpf_failing_path_may_end_at(struct bpf_verifier_env *env, u32 idx);
@@ -2530,6 +2533,8 @@ void bpf_equations_spill(struct bpf_verifier_env *env, struct bpf_func_state *fr
 void bpf_equations_fill(struct bpf_verifier_env *env, struct bpf_func_state *frame, int spi,
 			int size);
 void bpf_equations_refine_all(struct bpf_verifier_env *env, struct bpf_verifier_state *st);
+void bpf_equations_refine_by_reg(struct bpf_verifier_env *env, struct bpf_verifier_state *st,
+				 u32 regno);
 void bpf_equations_jump(struct bpf_verifier_env *env, struct bpf_verifier_state *st, int idx,
 			bool taken);
 u16 bpf_args_with_equation(const struct bpf_verifier_state *st);
diff --git a/kernel/bpf/equation.c b/kernel/bpf/equation.c
index 86b2c08c698..c84ebcba948 100644
--- a/kernel/bpf/equation.c
+++ b/kernel/bpf/equation.c
@@ -875,6 +875,16 @@ static void refine_from_reg(struct bpf_verifier_env *env, struct bpf_verifier_st
 	eq_env->jump_expr.coef = 0;
 }
 
+/* @regno has fewer values now */
+void bpf_equations_refine_by_reg(struct bpf_verifier_env *env, struct bpf_verifier_state *st,
+				 u32 regno)
+{
+	if (!env->eq_env)
+		return;
+	refine_from_reg(env, st, regno);
+	propagate_bounds(env, st, false);
+}
+
 /* Apply all equations */
 void bpf_equations_refine_all(struct bpf_verifier_env *env, struct bpf_verifier_state *st)
 {
diff --git a/kernel/bpf/precision.c b/kernel/bpf/precision.c
index 9d55d3134e4..c53099a82ae 100644
--- a/kernel/bpf/precision.c
+++ b/kernel/bpf/precision.c
@@ -749,6 +749,14 @@ static u16 compute_call_deps(struct bpf_verifier_env *env, unsigned long *masks,
 	       (GENMASK(BPF_REG_5, BPF_REG_1) | BIT(XREG_STACK_ARGS));
 }
 
+static bool may_keep_ptr(const struct bpf_insn *insn)
+{
+	u8 class = BPF_CLASS(insn->code), op = BPF_OP(insn->code);
+
+	return class != BPF_ALU &&
+	       (class != BPF_ALU64 || op == BPF_MOV || op == BPF_ADD || op == BPF_SUB);
+}
+
 /* What the insn at @idx of function @s needs before it. @in has what is needed after it. */
 static bool compute_insn_deps(struct bpf_verifier_env *env, unsigned long *masks, u8 *ret, int s,
 			      int idx, bool is_seed, unsigned long *in, bool held)
@@ -760,6 +768,7 @@ static bool compute_insn_deps(struct bpf_verifier_env *env, unsigned long *masks
 	bool changed = false, stores, reads, loads, call, held_after;
 	struct taken_funcs *taken = &env->precision->taken;
 	u8 class = BPF_CLASS(insn->code), needs;
+	u16 ptrs = 0;
 	int t, callee;
 
 	call = class == BPF_JMP && BPF_OP(insn->code) == BPF_CALL;
@@ -785,6 +794,11 @@ static bool compute_insn_deps(struct bpf_verifier_env *env, unsigned long *masks
 		  test_bit(idx, env->precision->last_pass.bad_read_insns));
 	if (!loads && class == BPF_STX)
 		use = BIT(insn->dst_reg);
+	if (env->precision->ptr_deps_only) {
+		reads &= may_keep_ptr(insn);
+		ptrs = is_seed ? aux->needs_ptr_regs : 0;
+		is_seed = false;
+	}
 	reads |= is_seed;
 	in[0] &= ~(unsigned long)(def & XREG_REGS);
 	for (t = 0; t < BITS_TO_LONGS(bits); t++)
@@ -829,6 +843,7 @@ static bool compute_insn_deps(struct bpf_verifier_env *env, unsigned long *masks
 	if (held)
 		changed |= !__test_and_set_bit(idx, env->precision->held_insns);
 	in[0] |= args | (reads ? use & XREG_REGS : 0);
+	in[0] |= ptrs;
 	if (reads && (call || is_stack_arg_ldx(insn)))
 		__set_bit(XREG_STACK_ARGS, in);
 	if ((reads && loads) || (needs & RET_LOADS)) {
@@ -1127,6 +1142,43 @@ static int compute_deps_of_unproven(struct bpf_verifier_env *env)
 	return add_control_deps(env);
 }
 
+/* The current insn needs a pointer in @reg */
+void bpf_note_needs_ptr(struct bpf_verifier_env *env, const struct bpf_reg_state *reg)
+{
+	const struct bpf_reg_state *regs = cur_regs(env);
+
+	if (reg->type != SCALAR_VALUE || reg->from_unproven || env->path_sensitive ||
+	    reg < regs || reg >= regs + BPF_REG_FP)
+		return;
+	__set_bit(env->insn_idx, env->precision->needs_ptr_insns);
+	env->insn_aux_data[env->insn_idx].needs_ptr_regs |= BIT(reg - regs);
+}
+
+/* The current insn can load a pointer. Does a later insn need it? */
+bool bpf_insn_makes_ptr(struct bpf_verifier_env *env)
+{
+	env->precision->this_pass.can_fork = true;
+	return test_bit(env->insn_idx, env->precision->makes_ptr_insns);
+}
+
+/* See fork_stack_load(). Returns 1 if there are more such insns. */
+static int add_makes_ptr_insns(struct bpf_verifier_env *env)
+{
+	struct bpf_precision *prec = env->precision;
+	u32 len = env->prog->len;
+	int err;
+
+	if (!prec->last_pass.can_fork || bitmap_empty(prec->needs_ptr_insns, len))
+		return 0;
+	prec->ptr_deps_only = true;
+	err = bpf_compute_deps(env, prec->new_data_deps, prec->needs_ptr_insns);
+	prec->ptr_deps_only = false;
+	if (err || bitmap_subset(prec->controlled_insns, prec->makes_ptr_insns, len))
+		return err;
+	bitmap_or(prec->makes_ptr_insns, prec->makes_ptr_insns, prec->controlled_insns, len);
+	return 1;
+}
+
 /* An unreadable xreg needs one type and object, whatever the numbers are. Try that first. */
 static int add_deps(struct bpf_verifier_env *env)
 {
@@ -1145,6 +1197,10 @@ static int add_deps(struct bpf_verifier_env *env)
 			      prec->last_pass.bad_read_insns, len);
 	bitmap_or(prec->bad_read_insns_done, prec->bad_read_insns_done,
 		  prec->last_pass.bad_read_insns, len);
+	ret = add_makes_ptr_insns(env);
+	if (ret < 0)
+		return ret;
+	more |= ret;
 	ret = compute_deps_of_unproven(env);
 	for (i = 0; i < 5 * prec->words; i++)
 		prec->kept[i] |= prec->data_deps[i] & ~prec->undo[i];
@@ -1625,6 +1681,8 @@ void bpf_precision_new_pass(struct bpf_verifier_env *env)
 	bitmap_zero(prec->this_pass.unproven_funcs, env->subprog_cnt);
 	prec->this_pass.suspect_loops = prec->this_pass.first_suspect_loops =
 		prec->this_pass.disjoint_joined = prec->this_pass.arg_lost_equation = 0;
+	prec->this_pass.can_fork = false;
+	bitmap_zero(prec->needs_ptr_insns, env->prog->len);
 	if (prec->apart_xregno)
 		memset(prec->apart_xregno, 0, env->prog->len * sizeof(u16));
 	if (prec->data_deps && !env->replay && (prec->budget_grew || env->for_log)) {
@@ -1695,6 +1753,8 @@ int bpf_precision_init(struct bpf_verifier_env *env)
 	prec->bad_value_insns = bits + 15 * words;
 	prec->this_pass.unproven_funcs = bits + 16 * words;
 	prec->last_pass.unproven_funcs = bits + 17 * words;
+	prec->needs_ptr_insns = bits + 18 * words;
+	prec->makes_ptr_insns = bits + 19 * words;
 	prec->pass_cost = env->cost;
 	prec->live_types_cost = env->max_cost / LIVE_TYPES_PART;
 	prec->live_types_mem = env->max_mem / LIVE_TYPES_PART;
diff --git a/kernel/bpf/precision.h b/kernel/bpf/precision.h
index 3af6f10eed7..295c744cfd7 100644
--- a/kernel/bpf/precision.h
+++ b/kernel/bpf/precision.h
@@ -24,6 +24,7 @@ struct precision_per_pass {
 	bool disjoint_joined;			/* disjoint values in data_deps were joined */
 	bool over_budget, calls_joined;
 	bool arg_lost_equation;			/* see bpf_call_needs_frames() */
+	bool can_fork;				/* see fork_stack_load() */
 };
 
 /* callx calls one of the functions whose address is taken. They count as one function. */
@@ -54,6 +55,8 @@ struct bpf_precision {
 	unsigned long *last_unproven_insns;	/* in the last pass */
 	unsigned long *bad_read_insns_done;
 	unsigned long *earlier_unproven_insns;	/* in an earlier pass */
+	unsigned long *needs_ptr_insns;		/* got a number in place of a pointer */
+	unsigned long *makes_ptr_insns;		/* the result flows into needs_ptr_insns */
 	unsigned long *control_seeds, *controlled_insns, *controlled_insns_done, *def_insns;
 	u32 first_unproven_insn;	/* of the last pass */
 	u32 last_unproven_left;		/* last_unproven_insns whose check did not fail again */
@@ -67,6 +70,7 @@ struct bpf_precision {
 	bool failing_path_due;		/* see bpf_failing_path_is_due() */
 	bool budget_grew;		/* see partition_next() */
 	bool new_nospec;
+	bool ptr_deps_only;		/* see add_makes_ptr_insns() */
 	/* see bpf_hash_live_types() */
 	u64 live_types_cost, live_types_mem, start_mem;
 	bool live_types_over, join_live_types;	/* in this pass, in all next passes */
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 8d0767b3bd4..53482161684 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -4716,6 +4716,7 @@ static int map_kptr_match_type(struct bpf_verifier_env *env,
 	verbose(env, "invalid kptr access, R%d type=%s%s ", regno,
 		reg_type_str(env, reg->type), reg_name);
 	verbose(env, "expected=%s%s", reg_type_str(env, PTR_TO_BTF_ID), targ_name);
+	bpf_note_needs_ptr(env, reg);
 	if (kptr_field->type == BPF_KPTR_UNREF)
 		verbose(env, " or %s%s\n", reg_type_str(env, PTR_TO_BTF_ID | PTR_UNTRUSTED),
 			targ_name);
@@ -7346,8 +7347,10 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, struct b
 		return size;
 
 	err = check_ptr_alignment(env, reg, off, size, strict_alignment_once);
-	if (err)
+	if (err) {
+		bpf_note_needs_ptr(env, reg);
 		return err;
+	}
 
 	if (reg->type == PTR_TO_MAP_KEY) {
 		if (t == BPF_WRITE) {
@@ -7560,6 +7563,7 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, struct b
 
 		verbose(env, "%s invalid mem access '%s'\n", reg_arg_name(env, argno),
 			reg_type_str(env, reg->type));
+		bpf_note_needs_ptr(env, reg);
 		if (reg->type == SCALAR_VALUE)
 			kind = BPF_DIAG_DEREF_SCALAR;
 		else if (type_may_be_null(reg->type))
@@ -7888,8 +7892,9 @@ static int check_stack_range_initialized(
 	u32 arg_slot = arg_slot_from_argno(argno);
 	bool uninit = clobber && meta && arg_slot < MAX_BPF_FUNC_ARGS &&
 		      (meta->arg_raw_mem.mask & BIT(arg_slot));
-	bool raw_mode = uninit && env->allow_uninit_stack &&
-			!(meta->arg_raw_mem.var_size_mask & BIT(arg_slot));
+	bool var_size = meta && arg_slot < MAX_BPF_FUNC_ARGS &&
+			(meta->arg_raw_mem.var_size_mask & BIT(arg_slot));
+	bool raw_mode = uninit && env->allow_uninit_stack && !var_size;
 
 	access_size = abs(access_size);
 
@@ -7938,6 +7943,10 @@ static int check_stack_range_initialized(
 		struct bpf_stack_state *ss;
 		u8 *stype;
 
+		/* The byte is between two accesses. See size_at_max_offset() for @var_size. */
+		if (reg->step > 1 && !var_size &&
+		    imod(i - off - reg->base, reg->step) >= access_size)
+			continue;
 		slot = -i - 1;
 		spi = slot / BPF_REG_SIZE;
 		if (state->allocated_stack <= slot) {
@@ -8089,6 +8098,7 @@ static int check_helper_mem_access(struct bpf_verifier_env *env, struct bpf_reg_
 		verbose(env, "%s type=%s ", reg_arg_name(env, argno),
 			reg_type_str(env, reg->type));
 		verbose(env, "expected=%s\n", reg_type_str(env, PTR_TO_STACK));
+		bpf_note_needs_ptr(env, reg);
 		return -EACCES;
 	}
 }
@@ -9444,6 +9454,7 @@ static int check_reg_type(struct bpf_verifier_env *env, struct bpf_reg_state *re
 	for (j = 0; j + 1 < i; j++)
 		verbose(env, "%s, ", reg_type_str(env, compatible->types[j]));
 	verbose(env, "%s\n", reg_type_str(env, compatible->types[j]));
+	bpf_note_needs_ptr(env, reg);
 	actual = bpf_diag_fmt(env, "%s", reg_type_str(env, reg->type));
 	accepted = bpf_diag_expected_reg_types(env, compatible->types, i);
 	bpf_diag_call_arg_fmt(env, env->insn_idx, argno, meta->func_name,
@@ -12079,6 +12090,7 @@ static int check_func_callx(struct bpf_verifier_env *env, struct bpf_insn *insn,
 
 	reg = reg_state(env, insn->dst_reg);
 	if (reg->type != PTR_TO_FUNC) {
+		bpf_note_needs_ptr(env, reg);
 		verbose(env, "R%d has type %s, expected func\n", insn->dst_reg,
 			reg_type_str(env, reg->type));
 		reason = bpf_diag_fmt(
@@ -21606,6 +21618,74 @@ static void free_pushed_states(struct bpf_verifier_env *env)
 	}
 }
 
+/*
+ * A load with a range of offsets makes a number of the pointers that are spilled there. If an
+ * insn needed a pointer and got that number, load each slot in its own state:
+ *	char *p[2] = { a, b };
+ *	return p[i & 1][63];
+ * Other loads keep the number: 'sum += word[i]' fails for a pointer.
+ */
+static int fork_stack_load(struct bpf_verifier_env *env, const struct bpf_insn *insn,
+			   unsigned long ranges)
+{
+	struct bpf_verifier_state *st = env->cur_state, *part;
+	DECLARE_BITMAP(slots, MAX_BPF_XREG) = {};
+	u32 regno = insn->src_reg, xregno, last;
+	struct bpf_stack_state *slot;
+	struct bpf_func_state *frame;
+	struct bpf_reg_state *reg;
+	struct scalar value = {};
+	bool has_ptr = false, needs_ptr;
+	s64 min_off, max_off;
+	int spi;
+
+	/* the cpu can speculate with the address of another state */
+	if (insn->code != (BPF_LDX | BPF_MEM | BPF_DW) || !(ranges & BIT(regno)) ||
+	    cur_regs(env)[regno].type != PTR_TO_STACK || !env->bypass_spec_v1)
+		return 0;
+	/* without allow_ptr_leaks the load fails */
+	needs_ptr = !env->allow_ptr_leaks || bpf_insn_makes_ptr(env);
+	reg = &cur_regs(env)[regno];
+	frame = bpf_func(env, reg);
+	min_off = reg_smin(reg) + insn->off;
+	max_off = reg_smax(reg) + insn->off;
+	if (offset_is_far(reg) || min_off < -frame->allocated_stack || max_off >= 0 ||
+	    !tnum_is_aligned(tnum_add(reg->var_off, tnum_const(insn->off)), BPF_REG_SIZE))
+		return 0;
+	bpf_add_cost(env, (max_off - min_off) / BPF_REG_SIZE, BPF_COST_XREG);
+	for (spi = bpf_get_spi(max_off); spi <= bpf_get_spi(min_off); spi++) {
+		scalar_set_const(&value, -(spi + 1) * BPF_REG_SIZE - insn->off);
+		if (!scalar_subsumes(scalar_of(reg), &value))
+			continue;
+		slot = bpf_stack_slot(frame, spi);
+		__set_bit(bpf_spi_to_xreg(spi), slots);
+		has_ptr |= bpf_is_spilled_reg(slot) && !bpf_is_spilled_scalar_reg(slot);
+	}
+	if (!has_ptr)
+		return 0;
+	env->imprecise |= !env->err;
+	if (!needs_ptr)
+		return 0;
+	/* no run has to load from all slots */
+	env->extra_values = true;
+	if (env->log.level & BPF_LOG_LEVEL)
+		verbose(env, "fork R%d\n", regno);
+	mark_reg_scratched(env, regno);
+	last = find_last_bit(slots, MAX_BPF_XREG);
+	for_each_set_bit(xregno, slots, MAX_BPF_XREG) {
+		part = xregno == last ? st : push_stack(env, env->insn_idx, env->insn_idx, false);
+		if (IS_ERR(part))
+			return PTR_ERR(part);
+		spi = bpf_xreg_to_spi(xregno);
+		scalar_set_const(scalar_of(&part->frame[part->curframe]->regs[regno]),
+				 -(spi + 1) * BPF_REG_SIZE - insn->off);
+		bpf_equations_refine_by_reg(env, part, regno);
+		if (part != st)
+			env->head->again = true;
+	}
+	return 0;
+}
+
 /* Process the current state until it gets to the start of a basic block. */
 static int do_check_block(struct bpf_verifier_env *env, int prev_insn_idx)
 {
@@ -21737,6 +21817,7 @@ static int do_check_block(struct bpf_verifier_env *env, int prev_insn_idx)
 		stack_args = cur_func(env)->out_stack_arg_cnt;
 
 		err = check_loop_guard(env) ?: check_recursion_guard(env);
+		err = err ?: fork_stack_load(env, insn, ranges);
 		if (err)
 			return err;
 
-- 
2.55.0

