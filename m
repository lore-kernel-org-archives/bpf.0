Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794498881;
	b=oyK7Fhi02vMIgZ1QY7wJqOJea5KceYao66F9l/P82hGNXy6W1/icc9zIRlFzt+Ml0Tap
	 cYx/tdZ3NRWqImywW1wAbPLXHG1UHSdhPJevMaFhRQjCc3PITRVCvTG0vZQ4ZKAQarb2E
	 v02UUM5gQrzdAgq/0kWmB5uHJNvVhAMvlw6ADEg60EFH4eq5WyA/1KfVOD9BWDKq18gJJ
	 rI42+zj/bSszAK4S+7nkx8da0fcHwyVyqnqfV3wNpvI4dETKtscUrOqJ0hZ5D3yPLEuyt
	 7GOwMsX5rlj2GGd5B0iEHHeC83qzSrWY4SDqZfB4cbWpUS7taP6suDQceQppRlXJWsA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794498881;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ebj6Lsq8pH33aOTAO0E70QKCpVIiAvLd+XmPZxs8ctc=;
	b=obVFFZUyEZDuoXQrR1stgWrugnbrviC0t4OPatqVSclC5nDlCe5YO1fl35cTJgaqX06T
	 hDHpXQtPBZNa9MdLMQmx6UgteenlAz4czxlgaLvdxJnTbZyfNhp1qAlB53sHmmCOy5Irs
	 Vx5vfqnSJORshWKSAkzrOUDHjt0DdZx+yxgvSvwGgbRwhkR2q/8kWilXhmMZ5lD+EwNTl
	 V5/t1vn18tzgeCpA8a1Ddvgs1Y1pRr7fwbySzqditctsRPM7czNUznfmhiSVJfj7rdOmg
	 RBvk9IP/Ndu2KY26UV3bS+ZoYZ+AszhANtJhS0/2YXujmMDlYmCjnryQyniftOiJypA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=x0Zav6tu;
	arc=none smtp.remote-ip=209.85.214.178
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47287606A337
	for <bpf@vger.kernel.org>; Thu, 12 Nov 2026 15:54:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 47287606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=x0Zav6tu
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2ed06b725fdso8511825ad.0
        for <bpf@vger.kernel.org>; Thu, 12 Nov 2026 07:54:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794498880; x=1795103680; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ebj6Lsq8pH33aOTAO0E70QKCpVIiAvLd+XmPZxs8ctc=;
        b=x0Zav6tuT6OjOPnLM3E48Xwb163bVtWKRxuLu9+5U/ZbpSvP59+6MWIqDlq3sGzB9n
         JPXPdYj1Pw+ZrGgHxOVF7Y0Dq3xjjAATSDGD7NqcncSYmQZrACTOB1VvxWjBXsDVHJND
         WzX2atOyGYC1Tq3y/+gWxWSqguRbt/DSgHLhYgMJDaKuZUHkmDjvFmaTNSl0FNQ8RBwa
         osWzKUgjsYUBrmyms8jsxs2VmAymjkli3X9s7UJiYpTti9VU0WEACheutF+u6vGDXihq
         5cBHvfSkOM1k02rOAzzWouM4vBU7texb3Dn8MOZTXUKIdh+KM0GpgjU7GYeeqBjn04nF
         nXNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794498880; x=1795103680;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ebj6Lsq8pH33aOTAO0E70QKCpVIiAvLd+XmPZxs8ctc=;
        b=yjgO1lZTUyKFKy9wOh88YfOALKeY0n5StcISu8XeUOs85foZJ/ie6YX+hAW44U2DlT
         jpytdJXKK9qjkBUUQsHrhzsT4wa5i4HcTqmVgCPoJ9llODUScok9AM3bNKzshO5+QbRY
         UF+a86KcNIh2DKhJYZMHVP2IhdBM8TaeKIV0p1oXFbw2+Bqi1ZqzhME2QbU7l1q4V7l0
         +PoyoVBm7m6BLm3hO3n2diluE0VyWLq8bnJtwIjrvOj/Yh8JJjNTTLy9BONj1oW2q1nP
         CTM9dngdk6BYq1iTXCdAY2s12KzUcSHiWjXcA2Yxvd2Ml2dqAp+9SghSx7Nq/z7bQE65
         h6ag==
X-Gm-Message-State: APuU4Z+WnnXyhYHkGJsb1shhT+5K19uiAxbz1tmct5OOmqs4C1k0KFyu
	CHnBShWsFCbWffd++09zz6X5RdHOdlSZpT0KU+wyMi7us6deQykX0hyoM94Ekw==
X-Gm-Gg: AYBFou1/SWMvHLMpaB2AnvIA1ZqxGtNbgtfbidusnZ9o0qOKurs0FJ+yP997iIvH7yI
	N6tQjsYJwlKp9F7FOqe6v3nDWDAWC7opVBBezAv87qrI/6etE1E2RloC29vEaU3IQ9DtjYTiDE9
	rGaGQUeiFuG/DoIrnnpK7tY7hIsbnat8EJnsK3EwtnuhhFMdUn+EsnG71DGjOoGoJoyODv7ZLE5
	sC42717rlPremJIu6SG26EqZjMTzI+SHVsDcYay6wsu3SigR415Q57cg3SxndjPPAdX0QuI/AVF
	bk7uy3NXs2Q+lMTVtTuaVIpljqlttQrn5vWEb3oJ8paa6keLeul08Pmv0vE3cRptlu6nlpUi2UG
	ufOYzm32eEj+59o7XQavh+mkbF7xjUUDPhIt7gm3zou/12vcFH12obD7WaPzd59quu/g+2zW+Mz
	2gQa/67Rt9HJ11y4d+BmME8HdvOvF3Vl9zNQrsK0jUnKJluldEtRVUfHLEd2aLVaDolXRiF/9Tx
	wxmzc7prcWWHGssCzs0CJz40GDHCmuXTiEdMqy6GAzOtXdcZSFlON2yaQxPgFREFdy2dpoSAIks
	dyhm1uknhVKfujn53Qba3jyhD8GQqct2RU1Pw98rNu3Rm+x4S2hEgrzoWV/Q9xtJqVKA8ayRAm7
	YQj1MexDEWuqMgIRl+lKdvDEgfQGndi/Qr4ruh0k77j08ps9mx6FFF3y8xUYn/mKszQoK3VA1Qg
	s=
X-Received: by 2002:a17:903:2f4f:b0:2e9:484d:693 with SMTP id d9443c01a7336-2edf1631283mr22121835ad.5.1794498880066;
        Thu, 12 Nov 2026 07:54:40 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.245])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2edbc8a1eb7sm34733535ad.39.2026.11.12.07.54.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 07:54:39 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next 10/12] bpf: Evaluate expressions by the transfer functions of the main pass
Date: Thu, 12 Nov 2026 15:53:35 +0000
Message-ID: <20261112155337.1040699-11-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261112155337.1040699-1-alexei.starovoitov@gmail.com>
References: <20261112155337.1040699-1-alexei.starovoitov@gmail.com>
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

	current_header = NULL;
	if (interesting_headers < HTTP2_MAX_HEADERS_COUNT_FOR_PROCESSING)
		current_header = &headers_to_process[interesting_headers];

clang computes the address before it tests the index (the HTTP/2 parser of
the Datadog agent). The jump bounds the index, and scalar evolution has the
expression of the pointer: (+ hdrs (* (zext8 n) 20)). What nobody computes
is the range of that expression after the jump. The next patch does.

eval_expr() is the evaluator that scev.c has. It computes the value of an
expression in a state at a loop header: the initial value, the step and the
bound of an induction variable. It knows a register, a constant, an add and
(zext32 slot) for a 32-bit spill.

Give it + - * / % & | ^ << >> s>> and the extensions. scev_value_alu()
applies an op to two values by scalar_alu(), the transfer function that the
main pass applies to the insn. scalar_ext() is new: the two casts of the
main pass under one name. No arithmetic is added. neg and the byte swaps
have no value, as before. Two things are not in struct scalar:

 - The width. A 32-bit spill holds the low 32 bits of a value: struct
   scev_value gets 'bits', the value is known modulo 2^bits.
   + - * & | ^ << respect that. An extension of N bits wants N bits and
   makes 64. >> s>> / % want 64. (zext32 slot) is no special case any more.
 - The type. Expressions have none, the state has it. A pointer can be an
   operand of an add, with a scalar, as in scev_value_add(), which goes
   with its level 2 message.

match_linear_latch() decides which expressions get here, and it does not
change. For these: (zext32 r) of a register or a 64-bit spill had no value
and has one. A slot with a 32-bit spill, read in 64 bits, was unknown and
has no value. A sum of scalars ends with the reduction.

struct scev_value moves to bpf_verifier.h: the main pass is going to get
one.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/bpf_verifier.h |   7 ++
 kernel/bpf/scev.c            | 171 +++++++++++++++++++++++++----------
 kernel/bpf/verifier.c        |   9 ++
 3 files changed, 140 insertions(+), 47 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 516e704c3d7d..978aa6db16e0 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -2071,6 +2071,7 @@ void scalar_set_const(struct scalar *s, u64 imm);
 void scalar_add(struct scalar *dst, const struct scalar *a, const struct scalar *b);
 void scalar_alu(struct scalar *dst, const struct scalar *src, const struct bpf_insn *insn);
 void scalar_zext32(struct scalar *s);
+void scalar_ext(struct scalar *s, u32 bits, bool sign);
 bool scalar_intersect(struct scalar *dst, const struct scalar *src, u32 bits);
 void scalar_union(struct scalar *acc, const struct scalar *src);
 int bpf_set_reg_range(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
@@ -2235,6 +2236,12 @@ int bpf_init_scev(struct bpf_verifier_env *env);
 void bpf_free_scev(struct bpf_verifier_env *env);
 int bpf_compute_scev(struct bpf_verifier_env *env);
 int bpf_scev_jump_counts(struct bpf_verifier_env *env, int header, int n, bool taken_leaves);
+/* What is known about a scalar or about the offset of a pointer. */
+struct scev_value {
+	struct scalar;
+	int ptr_reg;	/* SCEV register identifying the pointer origin, or -1. */
+	u8 bits;	/* The value is known modulo 2^bits. 0: nothing is known. */
+};
 bool bpf_scev_next_linked_reg(struct bpf_verifier_env *env, int insn_idx, u32 regno, u32 *pos,
 			      u32 *linked_regno, u32 *fill_off, int *base_regno, s64 *delta,
 			      u32 *bits);
diff --git a/kernel/bpf/scev.c b/kernel/bpf/scev.c
index af437e9286cb..008d8b2a53e6 100644
--- a/kernel/bpf/scev.c
+++ b/kernel/bpf/scev.c
@@ -3493,12 +3493,6 @@ int bpf_scev_jump_counts(struct bpf_verifier_env *env, int header, int n, bool t
 	return match_linear_latch(env, header, n, taken_leaves, &latch);
 }
 
-/* What is known about a scalar or about the offset of a pointer. */
-struct scev_value {
-	struct scalar;
-	int ptr_reg;	/* SCEV register identifying the pointer origin, or -1. */
-};
-
 static void log_scev_value(struct bpf_verifier_env *env, struct bpf_func_state *st,
 			   const struct scev_value *v)
 {
@@ -3548,53 +3542,135 @@ static bool scev_value_compatible(struct bpf_verifier_env *env, struct bpf_func_
 	return false;
 }
 
-static bool scev_value_add(struct bpf_verifier_env *env, struct bpf_func_state *st,
-			   const struct scev_value *a, const struct scev_value *b,
-			   struct scev_value *result)
+/* @v = the SCEV register @r in the state @st */
+static void eval_reg(struct bpf_verifier_env *env, struct bpf_func_state *st, u32 r,
+		     struct scev_value *v)
 {
-	if (a->ptr_reg >= 0 && b->ptr_reg >= 0) {
-		if (env->log.level & BPF_LOG_LEVEL2)
-			log_incompatible_scev_values(env, "can't add two pointers", st, a, b);
-		return false;
+	const struct bpf_reg_state *reg;
+
+	v->ptr_reg = -1;
+	v->bits = 64;
+	/* a 32-bit spill, or the upper half of the slot is dead: the low 32 bits of the value */
+	reg = scev_reg_for_spill32(st, r);
+	if (reg)
+		v->bits = 32;
+	else
+		reg = scev_reg_for_read(env, st, r);
+	if (!reg || reg->type == NOT_INIT) {
+		v->bits = 0;
+		return;
 	}
-	result->ptr_reg = a->ptr_reg >= 0 ? a->ptr_reg : b->ptr_reg;
-	scalar_add(scalar_of(result), scalar_of(a), scalar_of(b));
-	return true;
+	*scalar_of(v) = *scalar_of(reg);
+	if (reg->type != SCALAR_VALUE)
+		v->ptr_reg = r;
+}
+
+static void scev_value_set_const(struct scev_value *v, s64 imm)
+{
+	scalar_set_const(scalar_of(v), imm);
+	v->ptr_reg = -1;
+	v->bits = 64;
 }
 
+/*
+ * @v = @v @op @r, by the transfer functions of the main pass. @r is not read if @op has one
+ * operand. An op that is not evaluated: nothing is known.
+ * A value is known modulo 2^bits: the run-time value and a member of the abstract value have the
+ * same low bits. + - * & | ^ and << by an exact amount respect that. An extension of N bits wants N
+ * bits and makes 64. The other ops want 64.
+ * Expressions have no types, the state has them. A pointer can be an operand of an add, with a
+ * scalar, in 64 bits.
+ */
+static void scev_value_alu(u32 op, struct scev_value *v, const struct scev_value *r)
+{
+	struct bpf_insn insn = { .code = BPF_ALU64 | BPF_X | op };
+	u32 low = op_low_bits(op);
+
+	if (low) {
+		if (v->ptr_reg >= 0)
+			goto unknown;
+		/* a partial spill: the other bits of the slot are not known */
+		if (op == SPILL8 || op == SPILL16 || op == SPILL32) {
+			v->bits = min(v->bits, low);
+			return;
+		}
+		if (v->bits < low)
+			goto unknown;
+		scalar_ext(scalar_of(v), low, !is_zext(op));
+		v->bits = 64;
+		return;
+	}
+	if (op_params_num(op) != 2)
+		goto unknown;
+	v->bits = min(v->bits, r->bits);
+	switch (op) {
+	case BPF_ADD:
+		if (v->ptr_reg < 0 && r->ptr_reg < 0)
+			break;
+		if ((v->ptr_reg >= 0 && r->ptr_reg >= 0) || v->bits < 64)
+			goto unknown;
+		v->ptr_reg = max(v->ptr_reg, r->ptr_reg);
+		scalar_add(scalar_of(v), scalar_of(v), scalar_of(r));
+		return;
+	case BPF_SUB:
+	case BPF_MUL:
+	case BPF_AND:
+	case BPF_OR:
+	case BPF_XOR:
+		break;
+	case BPF_LSH:
+		if (r->bits < 64)
+			goto unknown;
+		break;
+	case SDIV:
+	case SMOD:
+		insn.code = BPF_ALU64 | BPF_X | (op == SDIV ? BPF_DIV : BPF_MOD);
+		insn.off = 1;
+		fallthrough;
+	case BPF_DIV:
+	case BPF_MOD:
+	case BPF_RSH:
+	case BPF_ARSH:
+		if (v->bits < 64)
+			goto unknown;
+		break;
+	default:
+		goto unknown;
+	}
+	if (v->ptr_reg >= 0 || r->ptr_reg >= 0)
+		goto unknown;
+	if (v->bits)
+		scalar_alu(scalar_of(v), scalar_of(r), &insn);
+	return;
+unknown:
+	v->bits = 0;
+}
+
+/*
+ * The value of @id in the state @st at a loop header: every SCEV register is its header phi there,
+ * (REG r) is r. All 64 bits are wanted.
+ */
 static bool eval_expr(struct bpf_verifier_env *env, struct scev *scev,
-		      struct bpf_func_state *st, u32 id, struct scev_value *result)
+		      struct bpf_func_state *st, u32 id, u32 lvl, struct scev_value *result)
 {
-	struct scev_value lval, rval;
-	const struct bpf_reg_state *reg;
-	u32 l, r, regno;
+	struct expr *e = &scev->exprs[id];
+	struct scev_value rval;
+	u32 regno;
 	s64 imm;
 
+	result->ptr_reg = -1;
+	result->bits = 0;
 	if (is_reg(scev, id, &regno)) {
-		reg = scev_reg_for_read(env, st, regno);
-		if (!reg || reg->type == NOT_INIT)
-			return false;
-		*scalar_of(result) = *scalar_of(reg);
-		result->ptr_reg = reg->type == SCALAR_VALUE ? -1 : (int)regno;
-		return true;
-	} else if (is_zext32(scev, id, &l) && is_reg(scev, l, &regno)) {
-		reg = scev_reg_for_spill32(st, regno);
-		if (!reg)
-			return false;
-		*scalar_of(result) = *scalar_of(reg);
-		scalar_zext32(scalar_of(result));
-		result->ptr_reg = -1;
-		return true;
+		eval_reg(env, st, regno, result);
 	} else if (is_imm(scev, id, &imm)) {
-		scalar_set_const(scalar_of(result), imm);
-		result->ptr_reg = -1;
-		return true;
-	} else if (is_add(scev, id, &l, &r) &&
-		   eval_expr(env, scev, st, l, &lval) &&
-		   eval_expr(env, scev, st, r, &rval)) {
-		return scev_value_add(env, st, &lval, &rval, result);
+		scev_value_set_const(result, imm);
+	} else if (op_params_num(e->op) && !e->def.set && lvl < EXPR_STACK_DEPTH) {
+		eval_expr(env, scev, st, e->params[0], lvl + 1, result);
+		if (op_params_num(e->op) == 2)
+			eval_expr(env, scev, st, e->params[1], lvl + 1, &rval);
+		scev_value_alu(e->op, result, &rval);
 	}
-	return false;
+	return result->bits == 64;
 }
 
 /* The range of @v. With @low32 that of its low 32 bits, in the upper half of a u64. */
@@ -3893,7 +3969,7 @@ static void latch_iv_range(struct bpf_verifier_env *env, struct bpf_func_state *
 	l = latch->base_expr;
 	if (!is_reg_or_low32(scev, l, &regno)) {
 		if (!is_add(scev, latch->base_expr, &l, &r) || !is_reg_or_low32(scev, l, &regno) ||
-		    !eval_expr(env, scev, st, r, &off) || !cnum64_is_const(off.r64) ||
+		    !eval_expr(env, scev, st, r, 0, &off) || !cnum64_is_const(off.r64) ||
 		    off.ptr_reg >= 0)
 			return;
 		c = off.r64.base;
@@ -3950,9 +4026,9 @@ static bool compute_max_iters(struct bpf_verifier_env *env,
 
 	iters->iv_reg = -1;
 
-	if (!eval_expr(env, scev, st, latch->base_expr, &initial_val) ||
-	    !eval_expr(env, scev, st, latch->step_expr, &step_val) ||
-	    !eval_expr(env, scev, st, latch->bound_expr, &bound_val))
+	if (!eval_expr(env, scev, st, latch->base_expr, 0, &initial_val) ||
+	    !eval_expr(env, scev, st, latch->step_expr, 0, &step_val) ||
+	    !eval_expr(env, scev, st, latch->bound_expr, 0, &bound_val))
 		return false;
 
 	if (step_val.ptr_reg >= 0) {
@@ -3982,7 +4058,8 @@ static bool compute_max_iters(struct bpf_verifier_env *env,
 		if (!is_reg_or_low32(scev, l, &r) && !is_add(scev, latch->base_expr, &l, &r))
 			return false;
 		if (cnum64_umax(initial_val.r64) > U32_MAX &&
-		    (!eval_expr(env, scev, st, l, &reg_val) || cnum64_umax(reg_val.r64) > U32_MAX))
+		    (!eval_expr(env, scev, st, l, 0, &reg_val) ||
+		     cnum64_umax(reg_val.r64) > U32_MAX))
 			return false;
 		if (!bound_of_zext32(latch->op, &bound_val))
 			return false;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 47ed36292e1b..3659cb839641 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -6417,6 +6417,15 @@ static void coerce_scalar_to_size_sx(struct scalar *s, int size)
 	set_sext64_default_val(s, size);
 }
 
+/* @s = (uN)@s or (sN)@s. N is @bits: 8, 16 or 32. */
+void scalar_ext(struct scalar *s, u32 bits, bool sign)
+{
+	if (sign)
+		coerce_scalar_to_size_sx(s, bits / BITS_PER_BYTE);
+	else
+		coerce_scalar_to_size(s, bits / BITS_PER_BYTE);
+}
+
 static void set_sext32_default_val(struct scalar *s, int size)
 {
 	if (size == 1)
-- 
2.55.0

