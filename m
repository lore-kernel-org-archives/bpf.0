Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795207920;
	b=bOqEwmPf2vId8Ww1XWZtFjM4HZZn4LrQYKOJk4NiC79Z0I42sfV1s5uNX7kpwi5NENpX
	 vaSSc7d+X0zc/8u3yhTuLfsNMR9hFyPVvkgbDsOL2OZ1zxHaB4SadyAFX72pPzCgwPBoW
	 sT9EOV9KCk6UuqE0nDuBsqBH2hHfkzH96M2tfVc/nyD2p2NuQSOvBzEEQFAMfSFw6tby1
	 QWbJXjCa7V1cMWw4dOHfiC4C8BKufzcCK5QRCdC/P7jirJl/HUOUx6Av1Ubws1CT3nAra
	 K5ceDFpPxKQCm5FbQoBP6EPMIbAh8MWILz8yUJLRC7EOMcQCTEnoAnbNXDApIvStALw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795207920;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=PoXyGK6XKKfrrYFSIswvllwMjyWv2hfs+YgfwLXy24o=;
	b=aWOyTVstuA2EwSv4MxcatB6cBn4piomfZwluqEeqlN27CWEI1AxIsYjBuKYSpTTthv61
	 jkEwAav4SiacG7ajFgoyyEYW2BxLR7ejSkn+SYZpzfImMM0BzUSbtmbi8yjLbu0ip/zr9
	 po1kLIYakCYhmToT7Mw82PqfG2UuEYpeFW2ClczT+VKEBAr6C6ABVw5+KhZFX6Q91BrdU
	 +/cp6TyL7NcQvuR2dRlr+2gs5zr1vr7QM/1km6Uz7UXmv5wi8d5Sgzxotem/AcxrnaZl6
	 eT1YohjTfUeXwRVRHT4kH7QTJQJz8STUf+W2+TKR1bwHKhcyB3+HWDsB8lZQhrkZ3wg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=inscbyK+;
	arc=none smtp.remote-ip=209.85.214.181
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B014F60A260D
	for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 20:51:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B014F60A260D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=inscbyK+
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2e9d7791b00so12908395ad.0
        for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 12:51:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795207910; x=1795812710; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PoXyGK6XKKfrrYFSIswvllwMjyWv2hfs+YgfwLXy24o=;
        b=inscbyK+XVR8Giv0VrQYr4miVuQiqCTpn3GPHF8pnIqqDqmjnx+fC6o1iK8KjS1NaE
         s/PNCj9qTCD+3tfjH0rHmoGz139VdTyvTEKouscB243ZH/PyRfTKRXlqpDdbTuHLPbwL
         olMZt1KOl3P7Oj8Vol2q4jSObisdK9n7Ipm5hz4ocT54SGMvnz+dqISH+MvOUPdowoKm
         VQ2Vt/nbOucs04hvyfh22A6AyjbKHpr4UP1RtuxoThusYn/ng4TMz5kuAqeRDXoLSueH
         GjA9R3+dDs9IZcovsAkFbhqJ3Zy6VYqqT4xYMvZaw4QrXwnXyBL5I8dZu+HRdnS/VJ3x
         iVQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795207910; x=1795812710;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=PoXyGK6XKKfrrYFSIswvllwMjyWv2hfs+YgfwLXy24o=;
        b=i1MHUKfC8p2+8BM8YlDJeAyBDW/3v9oVYFZoNPzyXD845g7yFPUuJ9J7T2PYcX4zAj
         RrlmiBlg+Ms0z/SG/3/21yox8puLGLlF0T50aerswRuvvFJQAGreeI/peLt+c9YDNNoK
         Q9RVUD1uQyZmu89vegvJgX5ZwA0MlaciOgvGvtpyJOwJ/tOxX3p7K9QsFkPww8Zc1Ysu
         kKL7s5BVTGWSjDGrwPIor/h8c4TOB1sn0trauzJ5zpMRDrbhc7eCsa/XO+g7jqrhmY14
         3K4/5+0zY3Rh+pj8VXwPiHMfBwvEVBx36YrTd1dCClSSGv1IJPYI0guLplmOwI4tALGy
         347A==
X-Gm-Message-State: APuU4Z/OmlYeiqfX6vwiyFQr5aH2/9xkpSr1jamg9nuAiUSSc2+r0Dam
	MkhZu1bGuj247U9ZweusVH3/iWpWRdx38uBOP/0DbwsnEVCbuuYG40x8/b39vQ==
X-Gm-Gg: AZFdTZevf3m75nJViuZ/l8V+InyDEfd3SjtxkaUz94+LI7PnY4Zd0MTAk2PJNpRCVW5
	d30lQ9uWUF16eIIwDwaUvZiqEQNiiX3CUhl8ffJZ2QEuYgrIOcHKnb/0hEgytZFbfNM6vGNMB2V
	Ir40muDjssVKkURzwy55iuJqVsUo3fUR4ACv3BZYOGazjsOsu7UtOT3TNPaaJKbFXhgCa1LSBhp
	cjyXc6Kfch6nwbI0YTt3bW6pWF9uVfFoFlb59hH6ftAVdvFuPlCnPUP8q1G9GwsreJvAm7PraRD
	40RGf6QJ5+nCOLVKgzpz76gBhubgUJn3PXYh1whGJvA1Bjlcg+ZzNEqp9fUPpnAJlZgHDcAOKYC
	Tz+mK5JTipfMNS1txI2O74A8IPQ0/8w5sBCrjh2A69N0eYOfwRsKCJl4+SkX6djqNciIhwFgsWZ
	QNZxosH5BlQXFXbvRF1/CqNM4/qsPk6ItTHlc0zGBZ3lGTCxm9EbKpWzHKrcOM4b3P16Ju1aA6e
	FpekTobxRBpXJN/vTwYsIF4/3kr/Y/td6F7pPk4Qamacu2BUkxl7be5t/cVoJ8JZP9DXSgKyMW4
	khTweB5FlZbkH9jAhTDxi6KtYW0lha0YUCV+cxUUVFz+D8O+sthc7P9wYLiZ+8A2nEArdIhzAmt
	gz81jPtR4b6F5PLAJTzHGciZSMyyoptZUj4VG+08l5YEmNnb0BSTydILuVOYAUt/CIe/iEBtQJw
	==
X-Received: by 2002:a17:903:22c6:b0:2ef:e563:d2a2 with SMTP id d9443c01a7336-2f03f18b46dmr39067375ad.57.1795207909771;
        Fri, 20 Nov 2026 12:51:49 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.240])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f03f12028dsm18127945ad.60.2026.11.20.12.51.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 12:51:49 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next v2 18/49] bpf: Refine all related numbers after a jump
Date: Fri, 20 Nov 2026 20:49:26 +0000
Message-ID: <20261120204959.614908-19-alexei.starovoitov@gmail.com>
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

A jump refines its operands. Take that through the equations:

  xreg -> its sym -> the other syms -> their xregs

  r1 = sym0, r2 = 4 * sym0
  if r1 > 7 goto out        r1 0..7 -> sym0 0..7 -> r2 0..28

propagate_bounds() keeps the refined syms in a queue, and links the
equations that use a sym. A sym propagates once, so the work is linear
in the size of the table. A sum refines all of its syms. An op refines
only its result: run_op() runs scalar_alu() on the new operands.

A jump that compares two numbers compares their difference with 0:

  end = p + sym0
  if (p != end)             sym0 != 0

A 32-bit test for equal does that for the numbers before a truncation
too, see skip_truncation():  w1 += 1; if w1 != w2

Code with no 32-bit insns can test the carry of a sum, see
refine_carry():

  r5 = r2; r5 <<= 32; r5 >>= 32
  if r5 != r2 goto carry    if the jump is taken, r2 is above U32_MAX

Packet pointers that share an id move together, see refine_ptr().

The two branches can get other bounds for one pointer. The test for the
end of the packet takes the operands of one branch for both. So
bpf_equations_jump() is last in check_cond_jmp_op().

If the equations cannot hold, the state ends after the next conditional
jump. The removal of dead code deletes an edge only from such a jump: a
call or a goto has to keep its target. The cpu can speculate past the
jump, so that needs bypass_spec_v1. See infeasible_state_ends().

Two pointers to one object have the order of their offsets:

  for (p = buf; p < end; p++)
          *p = 0;

The jump refines both offsets, and is_branch_taken() decides it. This
holds if no address wraps, so both offsets have to be near the object.
It is off without bypass_spec_v1.

This replaces refine_linked_regs().

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/bpf_verifier.h |  12 +
 kernel/bpf/equation.c        | 440 +++++++++++++++++++++++++++++++++++
 kernel/bpf/equation.h        |   6 +
 kernel/bpf/verifier.c        |  49 +++-
 4 files changed, 503 insertions(+), 4 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index d4fba11a891..39d79f0c1cb 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -2370,10 +2370,22 @@ void bpf_equation_env_free(struct bpf_verifier_env *env);
 int bpf_equations_copy(struct bpf_verifier_env *env, struct bpf_equations *dst,
 		       const struct bpf_equations *src);
 void bpf_equations_free(struct bpf_equations *eqs);
+void bpf_equations_refine_all(struct bpf_verifier_env *env, struct bpf_verifier_state *st);
+void bpf_equations_jump(struct bpf_verifier_env *env, struct bpf_verifier_state *st, int idx,
+			bool taken);
 void bpf_equations_print(struct bpf_verifier_env *env, const struct bpf_verifier_state *st);
 u32 bpf_equations_bytes(const struct bpf_equations *eqs);
 void scalar_bounds_sync(struct scalar *s);
 bool scalar_subsumes(const struct scalar *old, const struct scalar *cur);
+bool scalars_fit_in_bits(const struct scalar *a, const struct scalar *b, u32 bits);
+void scalars_refine_cond_op(struct scalar *a, struct scalar *b, u8 opcode, bool is_jmp32);
+
+static inline u8 bpf_signed_opcode(u8 op)
+{
+	if (op == BPF_JLT || op == BPF_JLE)
+		return op + BPF_JSLT - BPF_JLT;
+	return op == BPF_JGT || op == BPF_JGE ? op + BPF_JSGT - BPF_JGT : op;
+}
 
 /* How many bytes are checked from the start of the packet, wherever the pointer is */
 static inline int pkt_min_len(const struct bpf_reg_state *reg)
diff --git a/kernel/bpf/equation.c b/kernel/bpf/equation.c
index ce000ad0374..27c743e995a 100644
--- a/kernel/bpf/equation.c
+++ b/kernel/bpf/equation.c
@@ -599,6 +599,446 @@ void bpf_eval_diff(struct bpf_verifier_env *env, const struct bpf_verifier_state
 		scalar_bounds_sync(bounds);
 }
 
+/* Jumps refine */
+
+/*
+ * Packet pointers that share an id move together, see find_good_pkt_pointers().
+ * Do not reduce them one by one: the known bits cut one range and leave the other.
+ *	p = 20..40, bit 4 is set	q = p - 16 = 4..24, not 4..12
+ */
+static bool refine_ptr(struct bpf_verifier_env *env, struct bpf_verifier_state *st,
+		       struct scalar *s, const struct scalar *bounds)
+{
+	struct bpf_reg_state *ptr = container_of(&s->var_off, struct bpf_reg_state, var_off), *reg;
+	struct scalar new = *s, shift;
+	struct cnum64 old = s->r64;
+	struct bpf_func_state *f;
+	struct tnum known;
+	s64 smax;
+
+	/* a constant offset has to fit in an int */
+	if (!refine_bounds(&st->equations, &new, bounds) ||
+	    cnum64_smin(new.r64) <= -BPF_MAX_VAR_OFF || cnum64_smax(new.r64) >= BPF_MAX_VAR_OFF)
+		return false;
+	if (!type_is_pkt_pointer(ptr->type)) {
+		*s = new;
+		return true;
+	}
+	bpf_add_cost(env, bpf_xreg_cnt(st), BPF_COST_SCAN);
+	bpf_for_each_reg_in_vstate(st, f, reg, ({
+		if (reg->type != ptr->type || reg->id != ptr->id)
+			continue;
+		smax = reg_smax(reg);
+		scalar_set_const(&shift, reg->r64.base - old.base);
+		known = reg->var_off;
+		scalar_add(scalar_of(reg), &shift, &new);
+		known = tnum_intersect(known, reg->var_off);
+		if (!tnum_subreg_is_const(known))
+			reg->var_off = known;
+		bpf_trim_pkt_range(reg, smax);
+	}));
+	return true;
+}
+
+static void mark_sym_refined(struct bpf_verifier_env *env, u32 sym, u32 sweep)
+{
+	struct bpf_equation_env *eq_env = env->eq_env;
+
+	if (eq_env->scratch[sym].refined_sweep)
+		return;
+	eq_env->scratch[sym].refined_sweep = sweep;
+	if (sweep > 1)
+		eq_env->scratch[eq_env->refined_cnt++].queued_sym = sym;
+}
+
+/* @expr is in @bounds. If its sym got smaller, @sweep has to look at the equations of the sym. */
+static void refine_sym(struct bpf_verifier_env *env, struct bpf_equations *eqs,
+		       struct expr expr, struct scalar bounds, u32 sweep)
+{
+	scalar_add_const(&bounds, -expr.off);
+	if (refine_from_product(eqs, &eqs->syms[var_symno(expr.var)], expr.coef, &bounds))
+		mark_sym_refined(env, var_symno(expr.var), sweep);
+}
+
+/* eval_expr_nosync(), and what the jump tells about a multiple of its operand */
+static void expr_bounds_after_jump(struct bpf_verifier_env *env, struct bpf_verifier_state *st,
+				   const struct expr *expr, struct scalar *bounds)
+{
+	const struct expr *jump_expr = &env->eq_env->jump_expr;
+	struct scalar tmp;
+	s64 coef;
+
+	eval_expr_nosync(env, st, expr, bounds);
+	if (!jump_expr->coef || !expr->coef || expr->var != jump_expr->var)
+		return;
+	coef = div64_s64(expr->coef, jump_expr->coef);
+	if (coef * jump_expr->coef != expr->coef)
+		return;
+	scalar_scale(&tmp, &env->eq_env->jump_bounds, coef);
+	scalar_add_const(&tmp, expr->off - coef * jump_expr->off);
+	refine_bounds(&st->equations, bounds, &tmp);
+}
+
+static bool sym_is_refined(struct bpf_verifier_env *env, u32 sym, u32 sweep)
+{
+	return sym != NO_SYM && (!sweep || env->eq_env->scratch[sym].refined_sweep == sweep);
+}
+
+/* What @op makes of its operands. False: they have no number. */
+static bool run_op(struct bpf_verifier_env *env, struct bpf_verifier_state *st,
+		   const struct bpf_sym_equation *op, struct scalar *res)
+{
+	struct expr expr[2] = { rhs_expr(op, 0), rhs_expr(op, 1) };
+	struct scalar src;
+
+	bpf_add_cost(env, 1, BPF_COST_INSN);
+	expr_bounds_after_jump(env, st, &expr[0], res);
+	expr_bounds_after_jump(env, st, &expr[1], &src);
+	if (!scalar_intersect(res, res, 64) || !scalar_intersect(&src, &src, 64))
+		return false;
+	scalar_alu(res, &src, &env->prog->insnsi[op->insn_idx]);
+	return true;
+}
+
+static void refine_syms_by_equation(struct bpf_verifier_env *env, struct bpf_verifier_state *st,
+				    struct bpf_sym_equation *sym_eq, u32 sweep)
+{
+	struct expr expr[2] = { rhs_expr(sym_eq, 0), rhs_expr(sym_eq, 1) };
+	struct bpf_equations *eqs = &st->equations;
+	struct scalar operand[2], bounds, *lhs = &eqs->syms[sym_eq->sym[0]];
+	bool refined[3];
+	int i;
+
+	for (i = 0; i < 3; i++)
+		refined[i] = sym_is_refined(env, sym_eq->sym[i], sweep);
+	if ((!refined[0] || is_op(sym_eq)) && !refined[1] && !refined[2])
+		return;
+	if (is_op(sym_eq)) {
+		if (run_op(env, st, sym_eq, &bounds) && refine_bounds(eqs, lhs, &bounds))
+			mark_sym_refined(env, sym_eq->sym[0], sweep + 1);
+		return;
+	}
+	bpf_add_cost(env, 1, BPF_COST_INSN);
+	expr_bounds_after_jump(env, st, &expr[0], &operand[0]);
+	expr_bounds_after_jump(env, st, &expr[1], &operand[1]);
+	for (i = 1; i >= 0; i--) {
+		if (!expr[i].coef || !(refined[0] || refined[2 - i]))
+			continue;
+		scalar_add_scaled(&bounds, lhs, &operand[!i], -1);
+		if (!refine_bounds(eqs, &operand[i], &bounds))
+			continue;
+		refined[i + 1] = true;
+		refine_sym(env, eqs, expr[i], operand[i], sweep + 1);
+	}
+	scalar_add_scaled(&bounds, &operand[0], &operand[1], 1);
+	if (tnum_is_const(operand[1].var_off)) {
+		sym_eq->off += operand[1].var_off.value;
+		sym_eq->coef[2] = 0;
+		sym_eq->sym[2] = NO_SYM;
+	}
+	if ((refined[1] || refined[2]) && refine_bounds(eqs, lhs, &bounds))
+		mark_sym_refined(env, sym_eq->sym[0], sweep + 1);
+}
+
+static void refine_sym_from_xreg(struct bpf_verifier_env *env, struct bpf_verifier_state *st,
+				 const struct bpf_xreg_equation *xreg_eq)
+{
+	struct expr expr = sym_expr(xreg_eq->coef, xreg_eq->sym, xreg_eq->off);
+	const struct scalar *s = equation_xreg_bounds(env, st, xreg_eq);
+	struct scalar bounds;
+
+	if (!s)
+		return;
+	bpf_add_cost(env, 2, BPF_COST_XREG);
+	eval_expr_nosync(env, st, &expr, &bounds);
+	if (refine_bounds(&st->equations, &bounds, s))
+		refine_sym(env, &st->equations, expr, bounds, 1);
+}
+
+/* The number in the xreg of @xreg_eq is in @bounds */
+static void refine_xreg(struct bpf_verifier_env *env, struct bpf_verifier_state *st,
+			const struct bpf_xreg_equation *xreg_eq, const struct scalar *bounds)
+{
+	struct scalar *s = equation_xreg_bounds(env, st, xreg_eq);
+	u32 xregno = xreg_eq->xreg;
+
+	bpf_add_cost(env, 4, BPF_COST_XREG);
+	if (!s || over_limit(env) ||
+	    !(xreg_eq->is_ptr ? refine_ptr(env, st, s, bounds) :
+	      refine_bounds(&st->equations, s, bounds)) ||
+	    xreg_eq->xreg >> 32 != st->curframe)
+		return;
+	if (xregno < BPF_REG_FP)
+		mark_reg_scratched(env, xregno);
+	else if (xregno < BPF_XREG_TRIP)
+		mark_stack_slot_scratched(env, bpf_xreg_to_spi(xregno));
+}
+
+/* Link the equations that use a sym. A link is 3 * equation + position of the sym + 1. */
+static bool link_sym_equations(struct bpf_verifier_env *env, const struct bpf_equations *eqs)
+{
+	struct bpf_equation_env *eq_env = env->eq_env;
+	u32 i = 3 * eqs->sym_equation_cnt, sym;
+
+	if (!bpf_grow_array(env, &eq_env->use_links, &eq_env->use_link_cap, i,
+			    sizeof(*eq_env->use_links)))
+		return false;
+	bpf_add_cost(env, eqs->sym_equation_cnt, BPF_COST_COPY);
+	for (sym = 0; sym < eqs->sym_cnt; sym++)
+		eq_env->scratch[sym].first_use = 0;
+	while (i--) {
+		sym = eqs->sym_equations[i / 3].sym[i % 3];
+		if (sym == NO_SYM)
+			continue;
+		eq_env->use_links[i] = eq_env->scratch[sym].first_use;
+		eq_env->scratch[sym].first_use = i + 1;
+	}
+	return true;
+}
+
+/* Each sweep goes one equation further. A sym propagates once. @all: to all xregs. */
+static void propagate_bounds(struct bpf_verifier_env *env, struct bpf_verifier_state *st, bool all)
+{
+	struct bpf_equation_env *eq_env = env->eq_env;
+	struct sym_scratch *scratch = eq_env->scratch, *refined;
+	struct bpf_equations *eqs = &st->equations;
+	struct bpf_xreg_equation *xreg_eq;
+	struct bpf_sym_equation *sym_eq;
+	struct scalar bounds;
+	struct expr expr;
+	u32 i, link;
+
+	bpf_add_cost(env, eqs->sym_cnt, BPF_COST_SCAN);
+	for (i = eq_env->refined_cnt = 0; i < eqs->sym_cnt; i++)
+		if (scratch[i].refined_sweep)
+			scratch[eq_env->refined_cnt++].queued_sym = i;
+	if (!eq_env->refined_cnt && !all)
+		return;
+	for (i = 0;
+	     i < eq_env->refined_cnt && (i || link_sym_equations(env, eqs)) &&
+	     !over_limit(env); i++) {
+		refined = &scratch[scratch[i].queued_sym];
+		for (link = refined->first_use; link--; link = eq_env->use_links[link]) {
+			sym_eq = &eqs->sym_equations[link / 3];
+			/* once in a sweep */
+			if ((link % 3 < 1 ||
+			     !sym_is_refined(env, sym_eq->sym[0], refined->refined_sweep)) &&
+			    (link % 3 < 2 ||
+			     !sym_is_refined(env, sym_eq->sym[1], refined->refined_sweep)))
+				refine_syms_by_equation(env, st, sym_eq, refined->refined_sweep);
+		}
+	}
+	for_each_xreg_equation(env, eqs, xreg_eq) {
+		if (!all && !scratch[xreg_eq->sym].refined_sweep)
+			continue;
+		expr = sym_expr(xreg_eq->coef, xreg_eq->sym, xreg_eq->off);
+		expr_bounds_after_jump(env, st, &expr, &bounds);
+		refine_xreg(env, st, xreg_eq, &bounds);
+	}
+	for (i = 0; i < eqs->sym_cnt; i++)
+		scratch[i].refined_sweep = 0;
+}
+
+static void refine_from_reg(struct bpf_verifier_env *env, struct bpf_verifier_state *st, u32 regno)
+{
+	const struct bpf_xreg_equation *xreg_eq =
+		bpf_find_xreg_equation(&st->equations, bpf_reg_to_xreg(st, regno));
+	struct bpf_reg_state *reg = &st->frame[st->curframe]->regs[regno];
+	struct scalar bounds = *scalar_of(reg);
+	struct bpf_equation_env *eq_env = env->eq_env;
+	struct expr expr;
+	u64 span;
+
+	if (reg->type == SCALAR_VALUE && scalar_align_bounds(&bounds))
+		*scalar_of(reg) = bounds;
+	else if (reg->type != SCALAR_VALUE && ptr_off_is_tracked(env, reg) &&
+		 !type_is_pkt_pointer(reg->type) && scalar_align_bounds(&bounds))
+		refine_ptr(env, st, scalar_of(reg), &bounds);
+	if (!xreg_eq)
+		return;
+	refine_sym_from_xreg(env, st, xreg_eq);
+	if (is_plus_minus_one(xreg_eq->coef) || xreg_eq->is_ptr ||
+	    !equation_xreg_bounds(env, st, xreg_eq))
+		return;
+	/* the sym cannot show it if the product wraps */
+	expr = sym_expr(xreg_eq->coef, xreg_eq->sym, xreg_eq->off);
+	bpf_eval_expr(env, st, &expr, &bounds);
+	if (scalar_subsumes(scalar_of(reg), &bounds) &&
+	    !check_mul_overflow(abs64(expr.coef),
+				st->equations.syms[xreg_eq->sym].r64.size, &span))
+		return;
+	eq_env->jump_expr = expr;
+	eq_env->jump_bounds = *scalar_of(reg);
+	mark_sym_refined(env, xreg_eq->sym, 1);
+	propagate_bounds(env, st, false);
+	eq_env->jump_expr.coef = 0;
+}
+
+/* Apply all equations */
+void bpf_equations_refine_all(struct bpf_verifier_env *env, struct bpf_verifier_state *st)
+{
+	struct bpf_xreg_equation *xreg_eq;
+	struct bpf_sym_equation *sym_eq;
+
+	st->equations.needs_refine = false;
+	for_each_xreg_equation(env, &st->equations, xreg_eq)
+		refine_sym_from_xreg(env, st, xreg_eq);
+	for_each_sym_equation(env, &st->equations, sym_eq)
+		refine_syms_by_equation(env, st, sym_eq, 0);
+	propagate_bounds(env, st, true);
+}
+
+static bool sym_has_xreg(struct bpf_verifier_env *env, const struct bpf_equations *eqs, u32 sym)
+{
+	const struct bpf_xreg_equation *xreg_eq;
+
+	if (over_limit(env))
+		return true;
+	for_each_xreg_equation(env, eqs, xreg_eq)
+		if (xreg_eq->sym == sym)
+			return true;
+	return false;
+}
+
+/*
+ * A truncation is a sum 'low bits = x - 2^n * high bits', see expr_low_bits(). Go back to x if
+ * only the low @bits bits matter, and no xreg holds the low bits. @all: also if an xreg does.
+ *	w2 = w1; w2 += -1; w2 &= 255;		the low 8 bits of r1 - 1
+ */
+static void skip_truncation(struct bpf_verifier_env *env, const struct bpf_equations *eqs,
+			    struct expr *expr, u32 bits, bool all)
+{
+	const struct bpf_sym_equation *sym_eq = eqs->sym_equations + eqs->sym_equation_cnt;
+
+	if (over_limit(env))
+		return;
+	bpf_add_cost(env, eqs->sym_equation_cnt, BPF_COST_COPY);
+	while (sym_eq-- > eqs->sym_equations)
+		if (var_is_sym(expr->var) && sym_eq->sym[0] == var_symno(expr->var) &&
+		    !is_op(sym_eq) && !((expr->coef * sym_eq->coef[2]) & low_bits(bits)) &&
+		    (all || !sym_has_xreg(env, eqs, sym_eq->sym[0])))
+			*expr = expr_scale(rhs_expr(sym_eq, 0), expr->coef, expr->off);
+}
+
+/* "@a - @b @op 0" holds */
+static void refine_diff(struct bpf_verifier_env *env, struct bpf_verifier_state *st,
+			const struct expr *a, const struct expr *b, u8 op, bool jmp32)
+{
+	struct equation_pos pos = {};
+	struct scalar bounds, zero;
+	struct expr diff;
+
+	while (bpf_find_next_diff(env, &st->equations, a, b, &pos, &diff)) {
+		bpf_eval_expr(env, st, &diff, &bounds);
+		scalar_set_const(&zero, 0);
+		scalars_refine_cond_op(&bounds, &zero, op, jmp32);
+		if (!scalar_intersect(&bounds, &bounds, 64)) {
+			st->equations.infeasible = true;
+			return;
+		}
+		if (!var_is_sym(diff.var))
+			continue;
+		refine_sym(env, &st->equations, diff, bounds, 1);
+		propagate_bounds(env, st, false);
+	}
+}
+
+/* "@x != @low" holds. If @low is (u32)@x, then @x is above U32_MAX. */
+static void refine_carry(struct bpf_verifier_env *env, struct bpf_verifier_state *st,
+			 struct expr x, struct expr low, const struct bpf_reg_state *low_reg)
+{
+	struct expr untruncated = x;
+	struct scalar bounds;
+
+	if (reg_umax(low_reg) > U32_MAX || !var_is_sym(x.var))
+		return;
+	skip_truncation(env, &st->equations, &low, 32, true);
+	skip_truncation(env, &st->equations, &untruncated, 32, true);
+	if (low.var != untruncated.var || (u32)(low.coef - untruncated.coef) ||
+	    (u32)(low.off - untruncated.off))
+		return;
+	scalar_set_unknown(&bounds);
+	bounds.r64 = cnum64_from_urange(BIT_ULL(32), U64_MAX);
+	refine_sym(env, &st->equations, x, bounds, 1);
+	propagate_bounds(env, st, false);
+}
+
+/* The jump compares two numbers, or the offsets of two pointers into one object */
+static bool compares_numbers(const struct bpf_verifier_state *st, const struct bpf_insn *insn)
+{
+	const struct bpf_reg_state *dst = &st->frame[st->curframe]->regs[insn->dst_reg];
+	const struct bpf_reg_state *src = &st->frame[st->curframe]->regs[insn->src_reg];
+
+	if (dst->type == SCALAR_VALUE)
+		return src->type == SCALAR_VALUE;
+	return BPF_CLASS(insn->code) == BPF_JMP && bpf_same_memory_origin(dst, src);
+}
+
+/*
+ * @st went through the jump at @idx, and its operands are refined. A jump that compares two
+ * numbers compares their difference with 0:
+ *	end = p + sym0; ... if (p != end)		sym0 != 0
+ */
+void bpf_equations_jump(struct bpf_verifier_env *env, struct bpf_verifier_state *st, int idx,
+			bool taken)
+{
+	const struct bpf_insn *insn = &env->prog->insnsi[idx];
+	const struct bpf_reg_state *dst = &st->frame[st->curframe]->regs[insn->dst_reg];
+	const struct bpf_reg_state *src = &st->frame[st->curframe]->regs[insn->src_reg];
+	u8 op = taken ? BPF_OP(insn->code) : bpf_rev_opcode(BPF_OP(insn->code));
+	bool jmp32 = BPF_CLASS(insn->code) == BPF_JMP32;
+	bool src_is_reg = BPF_SRC(insn->code) == BPF_X, is_ptr;
+	s64 max = jmp32 ? S32_MAX : S64_MAX / 2, min = -max - 1;
+	struct expr a, b, untruncated[2];
+	struct cnum64 lim;
+
+	if (!env->eq_env)
+		return;
+	refine_from_reg(env, st, insn->dst_reg);
+	if (src_is_reg)
+		refine_from_reg(env, st, insn->src_reg);
+	if (!st->equations.xreg_equation_cnt)
+		return;
+	propagate_bounds(env, st, false);
+	if (!src_is_reg || BPF_OP(insn->code) == BPF_JSET || !compares_numbers(st, insn) ||
+	    !bpf_xreg_expr(env, st, bpf_reg_to_xreg(st, insn->dst_reg), &a, &is_ptr) ||
+	    !bpf_xreg_expr(env, st, bpf_reg_to_xreg(st, insn->src_reg), &b, &is_ptr))
+		return;
+	if (op == BPF_JEQ || op == BPF_JNE) {
+		jmp32 |= scalars_fit_in_bits(scalar_of(dst), scalar_of(src), 32);
+	} else {
+		/* the difference does not wrap. An object is not in the first page. */
+		if (is_ptr)
+			lim = cnum64_from_srange(-SZ_4K, BPF_MAX_VAR_OFF);
+		else if (op != bpf_signed_opcode(op))
+			lim = cnum64_from_srange(0, max * 2 + 1);
+		else
+			lim = cnum64_from_srange(min, max);
+		if (!cnum64_is_subset(lim, dst->r64) || !cnum64_is_subset(lim, src->r64))
+			return;
+		op = bpf_signed_opcode(op);
+		jmp32 = false;
+	}
+	refine_diff(env, st, &a, &b, op, jmp32);
+	if (op == BPF_JNE && !jmp32) {
+		refine_carry(env, st, a, b, src);
+		refine_carry(env, st, b, a, dst);
+	}
+	if (!jmp32)
+		return;
+	/* w1 += 1; if w1 != w2: the equation is for the number before the truncation */
+	untruncated[0] = a;
+	untruncated[1] = b;
+	skip_truncation(env, &st->equations, &untruncated[0], 32, true);
+	skip_truncation(env, &st->equations, &untruncated[1], 32, true);
+	if (!expr_equal(&untruncated[0], &a))
+		refine_diff(env, st, &untruncated[0], &b, op, true);
+	if (!expr_equal(&untruncated[1], &b))
+		refine_diff(env, st, &a, &untruncated[1], op, true);
+	if (!expr_equal(&untruncated[0], &a) && !expr_equal(&untruncated[1], &b))
+		refine_diff(env, st, &untruncated[0], &untruncated[1], op, true);
+}
+
 static void print_operand(struct bpf_verifier_log *log, const char *prefix, struct expr expr)
 {
 	if (expr.coef)
diff --git a/kernel/bpf/equation.h b/kernel/bpf/equation.h
index db1f9fe3776..4e9b83ba419 100644
--- a/kernel/bpf/equation.h
+++ b/kernel/bpf/equation.h
@@ -46,6 +46,9 @@ struct sym_scratch {
 	u32 use_cnt;		/* equations that use it */
 	/* propagate_bounds(): the sweep that has to look at its equations */
 	u32 refined_sweep;
+	/* propagate_bounds(): not of this sym. The queue of refined syms. */
+	u32 queued_sym;
+	u32 first_use;		/* see link_sym_equations() */
 	u32 new_symno;
 	bool determined, by_op;
 	const struct bpf_sym_equation *op;	/* that makes it */
@@ -57,6 +60,9 @@ struct bpf_equation_env {
 	u32 *use_links;
 	u32 scratch_cap, use_link_cap, refined_cnt;
 	bool has_expr[2], is_ptr[2], equation_added, divided;
+	/* the operand of a jump and its bounds, see refine_from_reg() */
+	struct expr jump_expr;
+	struct scalar jump_bounds;
 	/* equation_join.c */
 	struct bpf_verifier_state join_state;	/* it has equations and no frames */
 	struct join_phi *phis;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 5cd1d83d0c0..2f558a89e19 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -17467,6 +17467,7 @@ static bool is_safe_to_compute_dst_reg_range(const struct bpf_insn *insn,
 	}
 
 	switch (BPF_OP(insn->code)) {
+	case BPF_MOV:
 	case BPF_ADD:
 	case BPF_SUB:
 	case BPF_NEG:
@@ -17535,7 +17536,7 @@ static int maybe_fork_scalars(struct bpf_verifier_env *env, struct bpf_insn *ins
 }
 
 /*
- * dst = dst <op> src: the transfer function of the ALU insn @insn, all but BPF_MOV.
+ * dst = dst <op> src: the transfer function of the ALU insn @insn.
  * @src can't be @dst. BPF_NEG and BPF_END ignore its value: any valid scalar will do.
  *
  * WARNING: This function does calculations on 64-bit values, but the actual
@@ -17575,6 +17576,13 @@ void scalar_alu(struct scalar *dst, const struct scalar *src, const struct bpf_i
 	 * tnum to calculate an approximation of the sign/unsigned bounds.
 	 */
 	switch (opcode) {
+	case BPF_MOV:
+		*dst = *src;
+		if (off && alu32)
+			coerce_subreg_to_size_sx(dst, off >> 3);
+		else if (off)
+			coerce_scalar_to_size_sx(dst, off >> 3);
+		break;
 	case BPF_ADD:
 		scalar_add(dst, dst, src);
 		break;
@@ -18327,7 +18335,6 @@ static void find_good_pkt_pointers(struct bpf_verifier_state *vstate,
 	}));
 }
 
-static void scalars_refine_cond_op(struct scalar *a, struct scalar *b, u8 opcode, bool is_jmp32);
 /*
  * Learn more information about live branches by simulating refinement on both branches.
  * scalars_refine_cond_op() is sound, so producing ill-formed register bounds for the branch means
@@ -18598,6 +18605,18 @@ static int is_branch_taken(struct bpf_verifier_env *env, struct bpf_reg_state *r
 	if (reg_is_pkt_pointer_any(reg1) && reg_is_pkt_pointer_any(reg2) && !is_jmp32)
 		return is_pkt_ptr_branch_taken(reg1, reg2, opcode);
 
+	/* Two pointers to one object have the order of their offsets */
+	if (reg1->type != SCALAR_VALUE && !is_jmp32 && opcode != BPF_JSET && env->bypass_spec_v1 &&
+	    !(reg1->type & PTR_UNTRUSTED) && bpf_same_memory_origin(reg1, reg2)) {
+		/* an object can be at a low address, but not in the first page */
+		struct cnum64 lim = cnum64_from_srange(opcode == BPF_JEQ || opcode == BPF_JNE ?
+						       -BPF_MAX_VAR_OFF : -SZ_4K, BPF_MAX_VAR_OFF);
+
+		if (!cnum64_is_subset(lim, reg1->r64) || !cnum64_is_subset(lim, reg2->r64))
+			return -1;
+		return is_scalar_branch_taken(env, reg1, reg2, bpf_signed_opcode(opcode), false);
+	}
+
 	if (__is_pointer_value(false, reg1) || __is_pointer_value(false, reg2)) {
 		u64 val;
 
@@ -18667,7 +18686,7 @@ u8 bpf_rev_opcode(u8 opcode)
 }
 
 /* Refine range knowledge for <a> <op> <b> conditional operation. */
-static void scalars_refine_cond_op(struct scalar *a, struct scalar *b, u8 opcode, bool is_jmp32)
+void scalars_refine_cond_op(struct scalar *a, struct scalar *b, u8 opcode, bool is_jmp32)
 {
 	struct tnum t;
 	u64 val;
@@ -18981,7 +19000,7 @@ static bool try_match_pkt_pointers(const struct bpf_insn *insn,
 }
 
 /* a == b (mod 2^N) implies a == b if both fit in uN or both fit in sN. N is @bits. */
-static bool scalars_fit_in_bits(const struct scalar *a, const struct scalar *b, u32 bits)
+bool scalars_fit_in_bits(const struct scalar *a, const struct scalar *b, u32 bits)
 {
 	u64 umax = GENMASK_ULL(bits - 1, 0);
 	s64 smax = umax >> 1;
@@ -19228,6 +19247,7 @@ static int check_cond_jmp_op(struct bpf_verifier_env *env,
 		err = refine_live_branch(env, insn, &env->true_reg1, &env->true_reg2);
 		if (err)
 			return err;
+		bpf_equations_jump(env, this_branch, *insn_idx, true);
 		if (env->log.level & BPF_LOG_LEVEL)
 			print_insn_state(env, this_branch, this_branch->curframe);
 		*insn_idx += insn->off;
@@ -19246,6 +19266,7 @@ static int check_cond_jmp_op(struct bpf_verifier_env *env,
 		err = refine_live_branch(env, insn, &env->false_reg1, &env->false_reg2);
 		if (err)
 			return err;
+		bpf_equations_jump(env, this_branch, *insn_idx, false);
 		if (env->log.level & BPF_LOG_LEVEL)
 			print_insn_state(env, this_branch, this_branch->curframe);
 		return 0;
@@ -19336,6 +19357,9 @@ static int check_cond_jmp_op(struct bpf_verifier_env *env,
 			insn->dst_reg);
 		return -EACCES;
 	}
+	/* last: the code above takes the operands of one branch for both */
+	bpf_equations_jump(env, this_branch, *insn_idx, false);
+	bpf_equations_jump(env, other_branch, *insn_idx, true);
 	if (env->log.level & BPF_LOG_LEVEL)
 		print_insn_state(env, this_branch, this_branch->curframe);
 	return 0;
@@ -20845,6 +20869,18 @@ static int check_held_in_leftover(struct bpf_verifier_env *env,
 	return held_cnt(st) > st->max_held_cnt;
 }
 
+/*
+ * The cpu can speculate past the jump that the equations decide.
+ * The removal of dead code can delete an edge only from a conditional jump.
+ */
+static bool infeasible_state_ends(struct bpf_verifier_env *env)
+{
+	int from = env->cur_state->last_insn_idx;
+
+	return env->cur_state->equations.infeasible && env->bypass_spec_v1 && from >= 0 &&
+	       bpf_insn_is_cond_jump(env->prog->insnsi[from].code);
+}
+
 /* The current state came back to the header of the loop of @entry. Returns 1 if it ends here. */
 static int next_trip(struct bpf_verifier_env *env, struct loop_stack_entry *entry,
 		     bool *starts_leftover)
@@ -20920,11 +20956,16 @@ int bpf_flow_loop_enter(struct bpf_verifier_env *env, struct bpf_loop **backedge
 	bool pushed;
 	int err;
 
+	if (infeasible_state_ends(env))
+		return 1;
+
 	/* The callback came back to the helper that calls it, in the same trip. */
 	if (frame->callback_depth)
 		return enter_callback(env, true, backedge_loop);
 
 	loop_stack_pop(env);
+	if (infeasible_state_ends(env))
+		return 1;
 
 	err = loop_stack_push(env, &pushed);
 	if (err)
-- 
2.55.0

