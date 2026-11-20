Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795160792;
	b=Szd/59S21Du6/CPP9TNhEV8ArXUT10ED2J7sdRiAdlRu858YDxf95bnBlFQR7MmG5vK6
	 uj1jnT3IIop/HKtz/blS2TfnnHGCtdfRxQwaGvRu56ZxDyetdJ1yjPtcn6Zz3QgI0JCo6
	 onkFRN3NNbH/xNb9bYDYZyVTOKnL/p7G3bjH/ysA7OUrHeogiLAdNLKYBwJ5WlGESWi0C
	 DGj5kOaJEnAGWw9jlclo3gr7PIMc9a8CqzAX5Wsi15s3Ko0YTB+2ayGN74QG9KiYmUpsU
	 zCIV1QR3FO0B+9Xx892GabvSZBtTSpHuTeWzsa5oUXCJoh9t0RKvy1ah7wJvlzuWVQQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795160792;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=56kq9YSV0usNcP6vUjo1tb/tT6+qtV4NgdAFueLh8Ck=;
	b=4rXubhmXJ0ITddtRyHUWRu7kxPiHexCrN67Q9w4BJsIJZLogOSWiomc1jD2wWUrQNSWX
	 aKoaKxEN0VGmJh7mFxSlynjGD7Qo+oaDL/NANVp2vzkz7MBIcYa7I/7KW+n6D5CNEsMXB
	 FL3iln97cR6YcKf5IFNIpMquYv3tZPHDd0Z/FsPZh1l9INxgXepdXu1XZeoVfM/CO+HIF
	 DEX2NGHSMhki/Mj4hdQm/hVDyUq48lvVUHd1Kxh+kfNe+/rFB5Rc9S9cBs8uTrgzpX6PM
	 nAQJw8OabmO0wW0o6FONnBjatQu5TpWu7hKf4D5+xb5DYa6LzeTdC255igZ6gOoN4Fw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WMzNMnCA;
	arc=none smtp.remote-ip=209.85.215.181
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8FA7606A320
	for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 07:46:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C8FA7606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WMzNMnCA
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-cdb9f760337so980572a12.0
        for <bpf@vger.kernel.org>; Thu, 19 Nov 2026 23:46:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795160791; x=1795765591; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=56kq9YSV0usNcP6vUjo1tb/tT6+qtV4NgdAFueLh8Ck=;
        b=WMzNMnCAQbG+uRV9Bg/hEJKg2yCTeDlXeeqxns1DVd8k9hvl7uHjjnYvOYSQsPRsI+
         4U72CZ7lSc8WbSQwweu/8F6A5mvytkH1m5/17GJAwoJNErzgLtWKhN76dwGJX116OGIf
         eCGf3LISoyqZD1Hy4eJCMrTvrFxZDwgPEYHUtyHtjD/CZ6zDedwu//yhDRXq51Vnoc1S
         9kdUC9OtM/sSonvrzHhzHsMjGaduLQ+k3S4uCKq0DvjTckEapdd5JPPkzU7BL1mmS/Ys
         FF0zBUI96bpg9GXL1Ch6U8UEvQtbvOpkjKmCkOSL2Xmw0MFDYkptIVOIhnJN4jbqj/gA
         R88w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795160791; x=1795765591;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=56kq9YSV0usNcP6vUjo1tb/tT6+qtV4NgdAFueLh8Ck=;
        b=dCxOUQIouVO5LSvfIsfhf8rU1HQyM2k9+Kdj+LpbK2WjfKeG1I4RGWrTa1dh4XPoZZ
         lc99I/cOZK2alQaGqFKINj59caBv9ucsE5h6Z6CDdgZ/HG3PU3FpM1HWMJLjgqQzx4i6
         oocCZ8Br7o4ualvL9pHMalN4jQWUyIDYmmw6J1H2bFbrmFIns8rxJSAvJqh/5CwVgW/4
         r/5uxp3bCOdK+bBcLTA2s+jflLPNvikAPcFzZj6Lg/dmYtNfq/0jE2ej/FTmbpG0X8KD
         qq5ixJYSrGSHP1IVdOGPchD9FlypT40gA1rQ/cEHMKOwkakp0FTEU0sbd/OQgcBF8Eal
         Tg+A==
X-Gm-Message-State: APuU4Z84cZ3lrq+UUxMJv/lcp9DAovV9ALc7rqvOV2s9E656SFICqprv
	S3CWrOiP11OKAbs/h4ZPbpd8xsk+r1ZX99nslPPrq5LxCnS0IplGPTgu0KQf4Q==
X-Gm-Gg: AZFdTZftRyjK+MOKpm2bU7ELVWKgH1dHNrwjo4kAQeq16qnx+dX2Tf+6uZypSppkKhQ
	8l2er7/VNri1fb8qtpkjpnoDQRVrbfJ+s38Z6ATlZu/4/cJaYEoE18vwVUn2S2ly/pGQAa6/6tp
	RaCB+6CKg7yrH6xcjCvDXlTXMje9jNBqHq4cJuo7GuBbs+WNiqdo9zeIclA93AXesnvsAaCUCf9
	cxziRX/ioxvpFNLZLCXHqa4WRq55Xri/yOL7Jxsnohgtq1p7f7v5EtCmNR1NMmg5S8r1cQ1wwbv
	zOzYgSaFlAq+E2CSWKF9TTojXQkYxqjHjS2toU9eIdf39A0ZqOPuJ8WIzO6+p/N/TOGyKp/fpBe
	aPjSIT3L068neehSo6ynssHr/StT1jMowmo/XAwDdN6dMaJ7TaDRZ6AB3kKF5uQvay9f4d+KfCQ
	eU1f6uCA0QlBbTpMKWQKAG/x/g46z4Un4LW1tWffozGDf2ziZHgIxa0ejiaydEip0pEqrKwvnFY
	WkWP1yFDVZbv1IkmlaO4PJwuxEBsh9G60e/iJe34wKhSLrgSi/cndXCANHM0ykQEgsr1UORO5QU
	DBRcG8dBH4itIk6kTJDQiBdxDZcT6T3S/JSiHc/8a3/5zdQBHedNVfm0iecJ+DrX53O7N0fUGEL
	2wb9QXVNQMDNcZvicnRupAeYqkQ8KYrv9Oo46sVplln5HAtbpWGjw/itbT+0y1PAGcEDmwemNfU
	w=
X-Received: by 2002:a17:90b:5289:b0:3b0:9bfa:72ac with SMTP id 98e67ed59e1d1-3b41c908147mr1480620a91.21.1795160790848;
        Thu, 19 Nov 2026 23:46:30 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.244])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b40548711esm6571294a91.0.2026.11.19.23.46.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 23:46:30 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next 20/49] bpf: Delete the equations that say nothing
Date: Fri, 20 Nov 2026 07:41:52 +0000
Message-ID: <20261120074430.2704488-21-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261120074430.2704488-1-alexei.starovoitov@gmail.com>
References: <20261120074430.2704488-1-alexei.starovoitov@gmail.com>
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

Insns add syms, and registers die. Without a clean-up the table grows,
and two states with the same facts have tables that do not compare.

  if                      then
  sym0 is 5               put 5 into the equations
  sym1 = sym0 + 8         replace sym1
  r1 = sym0, only use     delete, the range of r1 says the same
  no xreg holds sym0      eliminate it:
    p = sym0 + len, sym0 = 8 * trip + sym1  ->  p = 8 * trip + sym2

The result can be a second equation for the same sum, often with a
smaller range than the guess of a join. refine_same_sum() gives the
range to the first equation and deletes the second one. Two sums can
also become the same when a sym is replaced.

The new range needs a sym to hold it. If the equation has no sym with
one use, the sym of the deleted equation holds it:

  x = m + d, m = 2 * k + 41 * j, k is dead  ->  x = 41 * j + d'

normalize_equations() also sets the order: each equation has at most
one sym that the xregs and the earlier equations do not determine. A
later patch needs that order to check a table in one walk.

A state keeps 2 * SUMS_PER_XREG sym equations for each xreg equation.
That cuts a chain such as 'x += k; x += k; ...'. A pass that is over
its budget drops all equations.

A state without an equation has more values. So it is always safe to
delete an equation.

The clean-up runs when a state is cleaned, and when the number of syms
doubles.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/bpf_verifier.h |   2 +
 kernel/bpf/equation.c        | 426 +++++++++++++++++++++++++++++++++++
 kernel/bpf/equation.h        |   3 +
 kernel/bpf/states.c          |   1 +
 4 files changed, 432 insertions(+)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 1a9adf126f9..d4159384821 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -555,6 +555,7 @@ struct bpf_equations {
 	bool normalized;	/* see normalize_equations() */
 	bool infeasible;	/* the equations cannot hold: the program does not get here */
 	bool needs_refine;	/* widened: the equations are not applied, see bpf_flow_next() */
+	u32 clean_sym_cnt;	/* after the last bpf_equations_clean() */
 };
 
 struct bpf_verifier_state {
@@ -2321,6 +2322,7 @@ void bpf_equation_env_free(struct bpf_verifier_env *env);
 int bpf_equations_copy(struct bpf_verifier_env *env, struct bpf_equations *dst,
 		       const struct bpf_equations *src);
 void bpf_equations_free(struct bpf_equations *eqs);
+void bpf_equations_clean(struct bpf_verifier_env *env, struct bpf_verifier_state *st);
 s64 bpf_equations_max_sum(struct bpf_verifier_env *env, int regno1, int regno2);
 void bpf_equations_before_insn(struct bpf_verifier_env *env);
 int bpf_equations_after_insn(struct bpf_verifier_env *env);
diff --git a/kernel/bpf/equation.c b/kernel/bpf/equation.c
index 5c9a3df8ce4..479cb1466e1 100644
--- a/kernel/bpf/equation.c
+++ b/kernel/bpf/equation.c
@@ -640,6 +640,7 @@ static bool refine_ptr(struct bpf_verifier_env *env, struct bpf_verifier_state *
 	return true;
 }
 
+/* All states share the marks. If propagate_bounds() does not follow, clear the mark. */
 static void mark_sym_refined(struct bpf_verifier_env *env, u32 sym, u32 sweep)
 {
 	struct bpf_equation_env *eq_env = env->eq_env;
@@ -1195,6 +1196,7 @@ static bool add_divmod_equation(struct bpf_verifier_env *env, struct expr *expr,
 	struct bpf_equations *eqs = &env->cur_state->equations;
 	struct bpf_sym_equation sym_eq = { { -1, expr->coef, -divisor }, { 0, expr->var },
 					     env->eq_env->insn_idx, expr->off };
+	int i;
 
 	sym_eq.sym[0] = bpf_new_sym(env, eqs, rem);
 	sym_eq.sym[2] = bpf_new_sym(env, eqs, quot);
@@ -1574,6 +1576,430 @@ int bpf_equations_after_insn(struct bpf_verifier_env *env)
 	return env->no_mem ? -ENOMEM : 0;
 }
 
+/* Clean up */
+
+static bool sym_has_one_use(const struct sym_scratch *scratch, u32 sym)
+{
+	return sym != NO_SYM && scratch[sym].use_cnt == 1;
+}
+
+static void count_sym_uses(struct bpf_verifier_env *env, const struct bpf_equations *eqs)
+{
+	struct sym_scratch *scratch = env->eq_env->scratch;
+	const struct bpf_xreg_equation *xreg_eq;
+	const struct bpf_sym_equation *sym_eq;
+	u32 i;
+
+	bpf_add_cost(env, eqs->sym_cnt, BPF_COST_COPY);
+	memset(scratch, 0, eqs->sym_cnt * sizeof(*scratch));
+	for_each_xreg_equation(env, eqs, xreg_eq)
+		if (xreg_eq->coef)
+			scratch[xreg_eq->sym].use_cnt++;
+	for_each_sym_equation(env, eqs, sym_eq) {
+		for (i = 0; i < 3; i++)
+			if (sym_eq->coef[i])
+				scratch[sym_eq->sym[i]].use_cnt++;
+		if (is_op(sym_eq))
+			scratch[sym_eq->sym[0]].op = sym_eq;
+	}
+}
+
+static void replace_operand(struct bpf_sym_equation *sym_eq, u32 sym, const struct expr *new_expr)
+{
+	struct expr expr;
+	int i;
+
+	for (i = 0; i < 2; i++) {
+		if (sym_eq->sym[i + 1] != sym)
+			continue;
+		expr = expr_scale(*new_expr, sym_eq->coef[i + 1], rhs_expr(sym_eq, i).off);
+		set_operand(sym_eq, i, &expr);
+	}
+	if (sym_eq->sym[0] == sym || sym_eq->sym[0] == var_symno(new_expr->var))
+		sym_eq->sym[0] = NO_SYM;
+}
+
+/* Replace @sym with @expr */
+static bool substitute_sym(struct bpf_verifier_env *env, struct bpf_equations *eqs, u32 sym,
+			   const struct expr *expr, const struct bpf_sym_equation *def_equation)
+{
+	struct bpf_xreg_equation *xreg_eq;
+	struct bpf_sym_equation *sym_eq, new;
+	bool changed = false;
+	int i;
+
+	if (over_limit(env))
+		return false;
+	for_each_xreg_equation(env, eqs, xreg_eq) {
+		if (xreg_eq->sym != sym)
+			continue;
+		xreg_eq->off += xreg_eq->coef * expr->off;
+		xreg_eq->coef *= expr->coef;
+		xreg_eq->sym = expr->var;
+	}
+	for_each_sym_equation(env, eqs, sym_eq) {
+		i = find_sym_pos(sym_eq, sym);
+		if (i == 3 || sym_eq == def_equation || sym_eq->sym[0] == NO_SYM)
+			continue;
+		if (is_op(sym_eq)) {
+			replace_operand(sym_eq, sym, expr);
+			continue;
+		}
+		new = *sym_eq;
+		new.off += new.coef[i] * expr->off;
+		new.coef[i] *= expr->coef;
+		new.sym[i] = expr->var;
+		if (isolate_sym(&new))
+			*sym_eq = new;
+		else if (i || !expr->coef || find_sym_pos(sym_eq, expr->var) < 3)
+			sym_eq->sym[0] = NO_SYM;
+		changed = true;
+	}
+	return changed;
+}
+
+/* The position of the sym that only @sym_eq uses. -1 if there is none. */
+static int find_one_use_sym(const struct sym_scratch *scratch,
+			    const struct bpf_sym_equation *sym_eq)
+{
+	int i;
+
+	for (i = 2; i >= 0 && !sym_has_one_use(scratch, sym_eq->sym[i]); i--)
+		;
+	return i;
+}
+
+/* Another equation is for the same sum as @sym_eq. It gets the range of the sym at @one_use. */
+static bool refine_same_sum(struct bpf_verifier_env *env, struct bpf_equations *eqs,
+			    const struct bpf_sym_equation *sym_eq, int one_use)
+{
+	int i = !one_use, j = 2 - (one_use == 2);
+	struct expr a = sym_expr(sym_eq->coef[i], sym_eq->sym[i], sym_eq->off), diff;
+	struct expr b = sym_expr(-sym_eq->coef[j], sym_eq->sym[j], 0);
+	struct equation_pos pos = {};
+	struct scalar bounds;
+
+	/* the other equation can be a wrong guess, and then both are lost */
+	if (eqs == &env->eq_env->join_state.equations)
+		return false;
+	while (b.coef && bpf_find_next_diff(env, eqs, &a, &b, &pos, &diff)) {
+		if (!is_plus_minus_one(diff.coef) || var_symno(diff.var) == NO_SYM ||
+		    var_symno(diff.var) == sym_eq->sym[one_use])
+			continue;
+		scalar_scale(&bounds, &eqs->syms[sym_eq->sym[one_use]], -sym_eq->coef[one_use]);
+		refine_sym(env, eqs, diff, bounds, 1);
+		eqs->sym_equations[pos.next - 1].insn_idx = -1;
+		return true;
+	}
+	return false;
+}
+
+/*
+ * No xreg holds the sym at @pos of @def_equation any more. Eliminate it from the equations:
+ *	p' = sym0 + len, sym0 = 8 * trip + sym1	->	p' = 8 * trip + sym2, sym2 is sym1 + len
+ */
+static bool eliminate_sym(struct bpf_verifier_env *env, struct bpf_equations *eqs,
+			  struct bpf_sym_equation *def_equation, int pos)
+{
+	struct sym_scratch *scratch = env->eq_env->scratch;
+	int one_use = find_one_use_sym(scratch, def_equation), i, j, k;
+	struct bpf_sym_equation *sym_eq, def = *def_equation;
+	struct scalar bounds, rest, *s;
+	bool spare = def.insn_idx < 0;
+	u32 one_use_sym;
+	s64 factor;
+
+	if (one_use < 0 || one_use == pos || !is_plus_minus_one(def.coef[pos]))
+		return false;
+	def_equation->sym[0] = NO_SYM;
+	rest = eqs->syms[def.sym[one_use]];
+	for_each_sum(env, eqs, sym_eq) {
+		i = find_sym_pos(sym_eq, def.sym[pos]);
+		if (i == 3 || sym_eq == def_equation)
+			continue;
+		j = find_one_use_sym(scratch, sym_eq);
+		for (k = 0; k < 3 && j < 0 && spare; k++)
+			if (k != i && sym_eq->coef[k] && !scratch[sym_eq->sym[k]].determined)
+				j = k;
+		if (j < 0)
+			continue;
+		bpf_add_cost(env, 4, BPF_COST_XREG);
+		factor = -sym_eq->coef[i] * def.coef[pos];
+		scalar_scale(&bounds, &eqs->syms[sym_eq->sym[j]], sym_eq->coef[j]);
+		/* no xreg gives the value of that sym. The sym of @def takes its place. */
+		if (!sym_has_one_use(scratch, sym_eq->sym[j])) {
+			sym_eq->sym[j] = def.sym[one_use];
+			spare = false;
+		}
+		s = &eqs->syms[sym_eq->sym[j]];
+		scalar_add_scaled(s, &bounds, &rest, factor * def.coef[one_use]);
+		scalar_bounds_sync(s);
+		sym_eq->coef[j] = 1;
+		sym_eq->coef[i] = factor * def.coef[3 - pos - one_use];
+		sym_eq->sym[i] = def.sym[3 - pos - one_use];
+		sym_eq->off += factor * def.off;
+		sym_eq->insn_idx = -1;
+		/* a sym with one use is the last choice for the left side */
+		swap(sym_eq->coef[j], sym_eq->coef[2]);
+		swap(sym_eq->sym[j], sym_eq->sym[2]);
+		one_use_sym = sym_eq->sym[2];
+		if (!isolate_sym(sym_eq) ||
+		    refine_same_sum(env, eqs, sym_eq, find_sym_pos(sym_eq, one_use_sym)))
+			sym_eq->sym[0] = NO_SYM;
+	}
+	return true;
+}
+
+/* No xreg holds @sym, no jump tested it. An op made it of the syms of @sum: w1 += 1; w1 += 1; */
+static bool only_op_is_left(struct bpf_verifier_env *env, struct bpf_verifier_state *st,
+			    const struct bpf_sym_equation *sum, u32 sym)
+{
+	const struct sym_scratch *scratch = &env->eq_env->scratch[sym];
+	const struct bpf_sym_equation *op = scratch->op;
+	struct scalar bounds;
+
+	return op && scratch->use_cnt == 2 && (!op->coef[1] || find_sym_pos(sum, op->sym[1]) < 3) &&
+	       (!op->coef[2] || find_sym_pos(sum, op->sym[2]) < 3) &&
+	       run_op(env, st, op, &bounds) && scalar_subsumes(&st->equations.syms[sym], &bounds);
+}
+
+static bool equation_is_useless(struct bpf_verifier_env *env, struct bpf_verifier_state *st,
+				const struct bpf_sym_equation *sym_eq)
+{
+	const struct sym_scratch *scratch = env->eq_env->scratch;
+	int i, sym_cnt = 0, one_use_cnt = 0;
+
+	if (is_op(sym_eq))
+		return sym_has_one_use(scratch, sym_eq->sym[0]) ||
+		       (!sym_eq->coef[1] && !sym_eq->coef[2]);
+	for (i = 0; i < 3; i++) {
+		sym_cnt += sym_eq->coef[i] && !only_op_is_left(env, st, sym_eq, sym_eq->sym[i]);
+		if (!sym_has_one_use(scratch, sym_eq->sym[i]))
+			continue;
+		one_use_cnt++;
+		if ((sym_eq->coef[i] & 1) && scalar_is_unknown(&st->equations.syms[sym_eq->sym[i]]))
+			return true;
+	}
+	return one_use_cnt >= sym_cnt - 1;
+}
+
+static void forget_useless_equations(struct bpf_verifier_env *env, struct bpf_verifier_state *st)
+{
+	struct bpf_equations *eqs = &st->equations;
+	struct sym_scratch *scratch = env->eq_env->scratch;
+	struct bpf_xreg_equation *xreg_eq, *next;
+	struct bpf_sym_equation *sym_eq;
+	bool more;
+	int i;
+
+	do {
+		more = false;
+		for_each_sym_equation(env, eqs, sym_eq) {
+			if (sym_eq->sym[0] == NO_SYM || !equation_is_useless(env, st, sym_eq))
+				continue;
+			for (i = 0; i < 3; i++)
+				more |= sym_eq->coef[i] && --scratch[sym_eq->sym[i]].use_cnt == 1;
+			sym_eq->sym[0] = NO_SYM;
+		}
+	} while (more && !over_limit(env));
+	forget_sym_equations(env, eqs, S32_MIN);
+	next = eqs->xreg_equations;
+	for_each_xreg_equation(env, eqs, xreg_eq) {
+		if (xreg_eq->coef && !sym_has_one_use(scratch, xreg_eq->sym))
+			*next++ = *xreg_eq;
+		else if (xreg_eq->coef)
+			scratch[xreg_eq->sym].use_cnt = 0;
+	}
+	eqs->xreg_equation_cnt = next - eqs->xreg_equations;
+}
+
+/* The sym that @sym_eq determines. 3: all are determined. -1: more than one is not. */
+static int find_undetermined_sym(const struct sym_scratch *scratch,
+				 const struct bpf_sym_equation *sym_eq)
+{
+	int i, pos = 3;
+
+	for (i = 0; i < 3; i++) {
+		if (!sym_eq->coef[i] || scratch[sym_eq->sym[i]].determined)
+			continue;
+		if (pos < 3 || (i && is_op(sym_eq)))
+			return -1;
+		pos = i;
+	}
+	return pos;
+}
+
+/* Only an op tells a sym of @sym_eq */
+static bool leans_on_op(const struct sym_scratch *scratch, const struct bpf_sym_equation *sym_eq)
+{
+	int i;
+
+	for (i = 0; i < 3; i++)
+		if (sym_eq->coef[i] && scratch[sym_eq->sym[i]].by_op)
+			return true;
+	return is_op(sym_eq);
+}
+
+/* Delete what says nothing. Put the rest in the order that check_equations() needs. */
+static void normalize_equations(struct bpf_verifier_env *env, struct bpf_verifier_state *st)
+{
+	struct sym_scratch *scratch = env->eq_env->scratch;
+	struct bpf_equations *eqs = &st->equations;
+	struct bpf_xreg_equation *xreg_eq;
+	struct bpf_sym_equation *sym_eq, *done, *sweep_start, *end;
+	bool substituted = false;
+	struct expr expr;
+	u32 i, cnt;
+	int pos;
+
+	if (eqs->normalized)
+		return;
+	for (i = 0; i < eqs->sym_cnt; i++) {
+		expr = make_expr(0, 0, eqs->syms[i].var_off.value);
+		if (tnum_is_const(eqs->syms[i].var_off))
+			substituted |= substitute_sym(env, eqs, i, &expr, NULL);
+	}
+	/* see read_from_truncation() */
+	for_each_sym_equation(env, eqs, sym_eq)
+		if (is_op(sym_eq) && bits_read(env, sym_eq) < 32)
+			op_skips_truncations(env, eqs, sym_eq);
+again:
+	if (over_limit(env))
+		eqs->xreg_equation_cnt = eqs->sym_equation_cnt = 0;
+	forget_sym_equations(env, eqs, S32_MIN);
+	count_sym_uses(env, eqs);
+	for_each_sum(env, eqs, sym_eq) {
+		if (sym_eq->coef[2] || sym_eq->sym[0] == NO_SYM)
+			continue;
+		refine_syms_by_equation(env, st, sym_eq, 0);
+		expr = rhs_expr(sym_eq, 0);
+		/* sym0 = 2 * sym1, the only use of sym1: it shows only the low bits of sym0 */
+		if (!is_plus_minus_one(expr.coef) && sym_has_one_use(scratch, sym_eq->sym[1]))
+			continue;
+		substitute_sym(env, eqs, sym_eq->sym[0], &expr, sym_eq);
+		substituted = true;
+	}
+	if (substituted) {
+		forget_sym_equations(env, eqs, S32_MIN);
+		count_sym_uses(env, eqs);
+		/* two sums can be the same now. What an insn made keeps its form. */
+		for_each_sum(env, eqs, sym_eq) {
+			pos = find_one_use_sym(scratch, sym_eq);
+			if (pos >= 0 && sym_eq->insn_idx < 0 &&
+			    refine_same_sum(env, eqs, sym_eq, pos))
+				sym_eq->sym[0] = NO_SYM;
+		}
+		forget_sym_equations(env, eqs, S32_MIN);
+		count_sym_uses(env, eqs);
+		substituted = false;
+	}
+	forget_useless_equations(env, st);
+
+	for_each_xreg_equation(env, eqs, xreg_eq)
+		scratch[xreg_eq->sym].determined = true;
+	/* The equations near the xregs go first. Cut a long chain: x += k; x += k; ... */
+	done = eqs->sym_equations;
+	end = eqs->sym_equations +
+	      min(eqs->sym_equation_cnt, 2 * SUMS_PER_XREG * eqs->xreg_equation_cnt);
+	do {
+		bpf_add_cost(env, eqs->sym_equation_cnt - (done - eqs->sym_equations),
+			     BPF_COST_COPY);
+		sweep_start = done;
+		for (sym_eq = done;
+		     sym_eq < eqs->sym_equations + eqs->sym_equation_cnt && done < end; sym_eq++) {
+			pos = find_undetermined_sym(scratch, sym_eq);
+			/* sum += i & 1: go around the old sum, see eliminate_sym() */
+			if (pos < 0 || (pos % 3 && sym_eq->insn_idx >= 0 &&
+					!sym_has_one_use(scratch, sym_eq->sym[pos]) &&
+					leans_on_op(scratch, sym_eq)))
+				continue;
+			if (sym_eq != done)
+				swap(*sym_eq, *done);
+			done++;
+		}
+		for (sym_eq = sweep_start; sym_eq < done; sym_eq++) {
+			pos = find_undetermined_sym(scratch, sym_eq);
+			if (pos == 3)
+				continue;
+			scratch[sym_eq->sym[pos]].by_op = leans_on_op(scratch, sym_eq);
+			scratch[sym_eq->sym[pos]].determined = true;
+		}
+	} while (sweep_start < done && done < end && !over_limit(env));
+	/* Nothing refines the operands of the other ops. The other sums need a sym with one use. */
+	for (sym_eq = done; sym_eq < eqs->sym_equations + eqs->sym_equation_cnt; sym_eq++)
+		for (i = 0; i < 3 && !is_op(sym_eq) && find_one_use_sym(scratch, sym_eq) < 0; i++)
+			if (sym_eq->coef[i])
+				scratch[sym_eq->sym[i]].new_symno = scratch[sym_eq->sym[i]].by_op;
+	cnt = 0;
+	for_each_sym_equation(env, eqs, sym_eq) {
+		if (!is_op(sym_eq) || (sym_eq < done && !scratch[sym_eq->sym[0]].new_symno))
+			continue;
+		sym_eq->sym[0] = NO_SYM;
+		cnt++;
+	}
+	if (cnt)
+		goto again;
+	/* the equations that are left lead through unknown syms. The last insn goes first. */
+	for (cnt = 0; cnt < 2 && done < end; cnt++)
+		for (sym_eq = eqs->sym_equations + eqs->sym_equation_cnt; sym_eq-- > done;)
+			for (i = 0; i < 3 && (cnt || sym_eq->insn_idx >= 0); i++)
+				if (sym_eq->coef[i] &&
+				    !scratch[sym_eq->sym[i]].determined &&
+				    eliminate_sym(env, eqs, sym_eq, i))
+					goto again;
+	if (done != eqs->sym_equations + eqs->sym_equation_cnt) {
+		eqs->sym_equation_cnt = done - eqs->sym_equations;
+		goto again;
+	}
+
+	eqs->normalized = true;
+	for (i = 0, cnt = 0; i < eqs->sym_cnt; i++) {
+		scratch[i].refined_sweep = 0;
+		if (!scratch[i].use_cnt)
+			continue;
+		if (cnt != i)
+			eqs->syms[cnt] = eqs->syms[i];
+		scratch[i].new_symno = cnt++;
+	}
+	if (cnt == eqs->sym_cnt)
+		return;
+	eqs->sym_cnt = cnt;
+	for_each_xreg_equation(env, eqs, xreg_eq)
+		xreg_eq->sym = scratch[xreg_eq->sym].new_symno;
+	for_each_sym_equation(env, eqs, sym_eq)
+		for (i = 0; i < 3; i++)
+			if (sym_eq->coef[i])
+				sym_eq->sym[i] = scratch[sym_eq->sym[i]].new_symno;
+}
+
+/* Dead xregs are cleared */
+void bpf_equations_clean(struct bpf_verifier_env *env, struct bpf_verifier_state *st)
+{
+	struct bpf_xreg_equation *xreg_eq, *next = st->equations.xreg_equations;
+	struct bpf_equations *eqs = &st->equations;
+	const struct scalar *s;
+
+	if (!env->eq_env)
+		return;
+	if (st->speculative)
+		eqs->xreg_equation_cnt = 0;
+	for_each_xreg_equation(env, eqs, xreg_eq) {
+		s = equation_xreg_bounds(env, st, xreg_eq);
+		if (s && !tnum_is_const(s->var_off)) {
+			*next++ = *xreg_eq;
+			continue;
+		}
+		refine_sym_from_xreg(env, st, xreg_eq);
+		env->eq_env->scratch[xreg_eq->sym].refined_sweep = 0;
+	}
+	eqs->normalized &= next == xreg_eq;
+	eqs->xreg_equation_cnt = next - eqs->xreg_equations;
+	if (!eqs->xreg_equation_cnt)
+		eqs->sym_equation_cnt = eqs->sym_cnt = 0;
+	normalize_equations(env, st);
+	eqs->clean_sym_cnt = eqs->sym_cnt;
+}
+
 static void print_operand(struct bpf_verifier_log *log, const char *prefix, struct expr expr)
 {
 	if (expr.coef)
diff --git a/kernel/bpf/equation.h b/kernel/bpf/equation.h
index db068a58c30..35efc6d86a6 100644
--- a/kernel/bpf/equation.h
+++ b/kernel/bpf/equation.h
@@ -9,6 +9,9 @@
 #define VAR_NONE	U64_MAX
 #define NO_SYM		U32_MAX
 
+/* For each xreg a state keeps twice that many sums and ops in total, see normalize_equations() */
+#define SUMS_PER_XREG	2
+
 /* coef * var + off. A constant has no var and coef == 0. */
 struct expr {
 	s64 coef;
diff --git a/kernel/bpf/states.c b/kernel/bpf/states.c
index df1866c2b55..bb8fa008a8a 100644
--- a/kernel/bpf/states.c
+++ b/kernel/bpf/states.c
@@ -224,6 +224,7 @@ int bpf_clean_verifier_state(struct bpf_verifier_env *env, struct bpf_verifier_s
 
 		__clean_func_state(env, st->frame[i], live_regs, i);
 	}
+	bpf_equations_clean(env, st);
 	return bpf_renumber_ids(env, st);
 }
 
-- 
2.55.0

