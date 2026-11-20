Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795207962;
	b=xBGeH7IO+Fq5Bllh0nUSqvbnJFt35Tj/toeSomniqKzScdRawpbGImFHl87tSxkZA+F4
	 64qhK3TTuwOSznjDW5EObe31SCWsKSpSbNh39RbsXZzg/oyexYiOg99OIfHjQQMi3ik62
	 euPaMzsWPlwMuYpnFiX9VxcfQkFbmJInHnK6SMq9M5ndwJ5Mz6b0L5pxLskiEobBI+lxg
	 plajZ8q8ZxhActcM6JjWkP4vpv3tNWx1LE2mJGS9be3ilBthTgRKVVWmPPGRA2bTBW/AE
	 sXHNAZ1KnoFKUL6GVuUV7OS2eh4f9x5NABVy3yYIjjJapCPgRWGLCY2wqmDCXpZPhUw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795207962;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=1D4MzR2zcpjL+rptnZKLuypsAfAhVJySkJOjkbfW6BQ=;
	b=02SYC4HUHAqRdV1FCC3jWbgpixIUEI+BWKruBA6I2RQOT8fJqJuoqIOHSTasifdkmmxR
	 cbQ98dBl35BwZ9FtRc8DKegLocVtOXqX3AUSC2IEDjoe3s2KOFqGsvJz+CbjZd4l93rqg
	 +JNuWsWSO2vIvda6qUxlu9IKFw+BWcGwUPde1Qh+Eh64R387LGIjVTb7TNBsBOHHYYOGj
	 3qyf6tQ06V0TVDPKGaxSMjhKHYx9aD7ilQV++aUakPITvF7bjienDw8rykqnn4/d53/4X
	 O2Yyn5dQNw+NYl8fe5M/WJkq6Z79eVGNPSmgevnVplsygd3rSUp6JlIJznTTcWG/P5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ryAdskVb;
	arc=none smtp.remote-ip=209.85.214.171
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE544606A6AB
	for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 20:52:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AE544606A6AB
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ryAdskVb
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2eff92780daso10290445ad.1
        for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 12:52:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795207957; x=1795812757; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1D4MzR2zcpjL+rptnZKLuypsAfAhVJySkJOjkbfW6BQ=;
        b=ryAdskVbj0bHJ72xa2MatWBT0a6zkWxhsckA/n8AhzCB03rykwBQCQaBDv8OBU7hRR
         RICi8eTJNXnKXJqPMrYSzXogu8mWDZyxjNXmI9cu+0TUqJCBpKENp6mkzsSkrVpacvbK
         2TD8Z5CO+9UpAEseYL6ceQKoKiGAB8Mn9p++LxsNfae3fwELF9NTpxuv1UxhTbIr7quK
         hBP2Mc//n/4gHWrlo1uA/EG2gqMl6LeTgA7k+oK9ifzJSoXJqdsTY/Kppv5WsT82km7u
         iRAUu6GACbHBhzmWq5EQKEZCHhyTCVxpIYMjU4bPcOLr2FL0EAZByJuc3QrC/X68f9JB
         8lMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795207957; x=1795812757;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=1D4MzR2zcpjL+rptnZKLuypsAfAhVJySkJOjkbfW6BQ=;
        b=vYcnM5RrU+EfXNxAlvmU/p8NqEZ3mf6srprRQza9CqQkZOVX/qqlKIU4QXy3S4CISm
         ZM1964N42pijQsLwG7EVjbx3fMwX6zWaswKe0xYMxdjJ8ln85ZInVup/A4nzlik8KpXH
         APKhXb/HRBCVozVxDoLLLgsMoA+cLsQAdDhirp6/S7YoIBDjzK314i2o8jjikwEpAYym
         0FQTsk6atT6moNumFegqZgeTpzGr5xzsX8VlfpttBYbEXegp3h3fC+qMoO6JexNhpJap
         HJMwRFvQOgpXJaD6DrzTcqSuHgyxrpdmlKkQWVKQgipNBHqVpJ59k1T6NHVvEoTxdYp6
         rbrQ==
X-Gm-Message-State: APuU4Z97lCXc2NyLLdHmJSfm2hAqLY5325AbFLYsjTTnB1c4lltU8oKF
	rMS5TZh8YLtDZDu5kln+TwKKaTAb0pVg1P4lNTuDAG45CorLXUiwN3Ab0mzqnQ==
X-Gm-Gg: AZFdTZf/A9iIEiRRko/UI5Z3JiAwF7TIJoxeUjmXR8D38kwUs+Hj0KAo9RAW1NxkTXE
	D4TObqnwVtKDO8yqZMTEP/9aFo+vwh6SFdP05EvtHZxFC4FUR29y1haI+gIfCf4G6ExrSP6koqT
	9Tu8swF7QCp3j5za8hLVSgorOO82CeQAsmhXcEK05G39aHCym4+PkjjtctN1kgKYYY+eXI2Ypij
	+VZcFOAvQFFypFWWb0cygXuyHbuUMo4KfHDtXHgUlJTr8Q6ji8fqM89S6lPInjAimIoSzRlSvQM
	vckx+EG62vVCas9GGGU5XjkHmsvPflpQTlQGjtPq2en5/onCkd5u+YhCuBOe8oJFvhrNW7EWOtW
	28ktaLgy3bQKPKG9zj3yt2tPvZyCUzg4XfU/fR2gt7Upt0r93K03SUWJwGC20JwiPNflKBjTI5Q
	1e3SKhTYmbcWjwSl7p++UkEzjgYT3cEARKMHTgtv0sjU7hvsiE/dT3h11u+e7MKgYGQCNw1cVLf
	GzD6h0ZacnyBBdPfdlEzirWZT9v3qSjvr9008t3hQZrEno3LePE52ZzgJ7kof8hWvVteLlhFyaA
	yd/bUKzJesHoTeldYzbizSLF2GuVj619oSasPDwVHg+89FVwI7gPC5yR6vF4dRBYemdvmvAH8vO
	/TlSN3z8uXJs7StXRcVuNVddeDOnADniMmAlF1itFWEQuq6M184epF4OvJAd6By/KunghEcygPQ
	Bg7GVMeeuMyqNXsQKKlV8=
X-Received: by 2002:a17:90b:2f8f:b0:3b0:d070:3c46 with SMTP id 98e67ed59e1d1-3b41c98a389mr3558924a91.12.1795207956801;
        Fri, 20 Nov 2026 12:52:36 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.241])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b405d6349bsm8842364a91.9.2026.11.20.12.52.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 12:52:36 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next v2 26/49] bpf: Check the equations when a state is pruned or joined
Date: Fri, 20 Nov 2026 20:49:34 +0000
Message-ID: <20261120204959.614908-27-alexei.starovoitov@gmail.com>
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

Ranges do not show that a state has a relation:

  old:  r1 0..7, r2 0..7, r1 == r2
  cur:  r1 0..7, r2 0..7              old does not subsume cur

check_equations() looks for a value in cur for each sym of old:

  old:  r1 = sym0       r2 = 4 * sym0 + 8     sym0 0..7
  cur:  r1 = sym5 + 1   r2 = 4 * sym5 + 12    sym5 0..3

  r1:   sym0 is sym5 + 1, and 1..4 is in 0..7
  r2:   (4 * sym5 + 12 - 8) / 4 is sym5 + 1 too

A join needs equations that hold in both states. The next patch guesses
them. This patch checks the guess with the same function:

  guess -> check in dst and in src -> delete what fails -> check again

The worst guess gives no equation.

A widened state is saved as it is. Its equations are applied to the
copy that runs, see needs_refine. Else the state at the header can get
smaller again, and the loop has no fixpoint.

An infeasible state ends after the next jump. It does not subsume a
state that is feasible.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/bpf_verifier.h |   7 ++
 kernel/bpf/equation.c        | 180 +++++++++++++++++++++++++++++++++++
 kernel/bpf/join.c            |   2 +
 kernel/bpf/states.c          |   2 +-
 4 files changed, 190 insertions(+), 1 deletion(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 1a42a5e1ab2..a2e8844f291 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -2459,7 +2459,14 @@ void bpf_equations_fill(struct bpf_verifier_env *env, struct bpf_func_state *fra
 void bpf_equations_refine_all(struct bpf_verifier_env *env, struct bpf_verifier_state *st);
 void bpf_equations_jump(struct bpf_verifier_env *env, struct bpf_verifier_state *st, int idx,
 			bool taken);
+bool bpf_equations_subsume(struct bpf_verifier_env *env, const struct bpf_verifier_state *old,
+			   const struct bpf_verifier_state *cur);
 void bpf_equations_print(struct bpf_verifier_env *env, const struct bpf_verifier_state *st);
+void bpf_equations_pre_join(struct bpf_verifier_env *env, struct bpf_verifier_state *dst,
+			    const struct bpf_verifier_state *src, struct bpf_loop *leftover_loop,
+			    bool widen);
+void bpf_equations_post_join(struct bpf_verifier_env *env, struct bpf_verifier_state *dst,
+			     const struct bpf_verifier_state *src);
 u32 bpf_equations_bytes(const struct bpf_equations *eqs);
 void scalar_bounds_sync(struct scalar *s);
 bool scalar_subsumes(const struct scalar *old, const struct scalar *cur);
diff --git a/kernel/bpf/equation.c b/kernel/bpf/equation.c
index d33e686f299..2e182636094 100644
--- a/kernel/bpf/equation.c
+++ b/kernel/bpf/equation.c
@@ -2000,6 +2000,186 @@ void bpf_equations_clean(struct bpf_verifier_env *env, struct bpf_verifier_state
 	eqs->clean_sym_cnt = eqs->sym_cnt;
 }
 
+/* Subsume */
+
+/* Translate @expr to the other state */
+static bool match_expr(const struct sym_scratch *scratch, struct expr *expr)
+{
+	if (!expr->coef)
+		return true;
+	scratch += var_symno(expr->var);
+	*expr = expr_scale(scratch->cur_expr, expr->coef, expr->off);
+	return scratch->determined;
+}
+
+/* @sym of @old is @expr in @cur */
+static bool match_sym(struct bpf_verifier_env *env, const struct bpf_equations *old,
+		      const struct bpf_verifier_state *cur, u32 sym, const struct expr *expr)
+{
+	struct sym_scratch *scratch = &env->eq_env->scratch[sym];
+	struct scalar bounds;
+	struct expr diff;
+	struct equation_pos pos = {};
+
+	while (scratch->determined &&
+	       bpf_find_next_diff(env, &cur->equations, &scratch->cur_expr, expr, &pos, &diff))
+		if (!diff.coef && !diff.off)
+			return true;
+	if (scratch->determined)
+		return false;
+	bpf_eval_expr(env, cur, expr, &bounds);
+	scratch->determined = scalar_subsumes(&old->syms[sym], &bounds);
+	scratch->cur_expr = *expr;
+	return scratch->determined;
+}
+
+/* @hint: after the equation of @cur that was found last. Most are in the same order. */
+static bool check_sym_equation(struct bpf_verifier_env *env, const struct bpf_equations *old,
+			       const struct bpf_verifier_state *cur,
+			       const struct bpf_sym_equation *sym_eq, u32 *hint)
+{
+	const struct sym_scratch *scratch = env->eq_env->scratch;
+	struct equation_pos pos = { .next = *hint };
+	struct expr expr[2], diff;
+	struct scalar bounds;
+	int i, unmatched;
+
+	if (is_op(sym_eq)) {
+		expr[0] = rhs_expr(sym_eq, 0);
+		expr[1] = rhs_expr(sym_eq, 1);
+		return match_expr(scratch, &expr[0]) && match_expr(scratch, &expr[1]) &&
+		       bpf_find_op(env, &cur->equations, sym_eq->insn_idx, expr, &diff) &&
+		       match_sym(env, old, cur, sym_eq->sym[0], &diff);
+	}
+	/* -coef[unmatched] * sym[unmatched] = expr[0] - expr[1] */
+	for (unmatched = 0; unmatched < 2 && scratch[sym_eq->sym[unmatched]].determined;
+	     unmatched++)
+		;
+	for (i = 0; i < 2; i++) {
+		expr[i] = sym_expr(sym_eq->coef[i + (i >= unmatched)] * (i ? -1 : 1),
+				   sym_eq->sym[i + (i >= unmatched)], i ? 0 : sym_eq->off);
+		if (!match_expr(scratch, &expr[i]))
+			return false;
+	}
+	while (bpf_find_next_diff(env, &cur->equations, &expr[0], &expr[1], &pos, &diff)) {
+		if (!sym_eq->coef[unmatched] ? !diff.coef && !diff.off :
+		    bpf_expr_div_exact(&diff, 0, -sym_eq->coef[unmatched]) &&
+		    match_sym(env, old, cur, sym_eq->sym[unmatched], &diff)) {
+			*hint = pos.next;
+			return true;
+		}
+	}
+	/* no other equation uses it */
+	if (!sym_has_one_use(scratch, sym_eq->sym[unmatched]) ||
+	    !is_plus_minus_one(sym_eq->coef[unmatched]))
+		return false;
+	bpf_eval_diff(env, cur, &expr[sym_eq->coef[unmatched] > 0],
+		      &expr[sym_eq->coef[unmatched] < 0], &bounds);
+	return scalar_subsumes(&old->syms[sym_eq->sym[unmatched]], &bounds);
+}
+
+/*
+ * Are there values for the syms of @old for which its equations hold in @cur?
+ * @forget: it is @old. Mark the equations that do not hold, normalize_equations() deletes them.
+ */
+static bool check_equations(struct bpf_verifier_env *env, const struct bpf_equations *old,
+			    const struct bpf_verifier_state *cur, struct bpf_equations *forget)
+{
+	struct bpf_xreg_equation *xreg_eq;
+	struct bpf_sym_equation *sym_eq;
+	bool is_ptr, ok = true;
+	struct expr expr;
+	u32 hint = 0;
+
+	count_sym_uses(env, old);
+	for_each_xreg_equation(env, old, xreg_eq) {
+		if (bpf_xreg_expr(env, cur, xreg_eq->xreg, &expr, &is_ptr) &&
+		    is_ptr == xreg_eq->is_ptr &&
+		    bpf_expr_div_exact(&expr, xreg_eq->off, xreg_eq->coef) &&
+		    match_sym(env, old, cur, xreg_eq->sym, &expr))
+			continue;
+		if (!forget)
+			return false;
+		xreg_eq->coef = 0;
+		forget->normalized = ok = false;
+	}
+	for_each_sym_equation(env, old, sym_eq) {
+		/* it depends on an equation that does not hold */
+		if (!ok && find_undetermined_sym(env->eq_env->scratch, sym_eq) < 0)
+			continue;
+		if (check_sym_equation(env, old, cur, sym_eq, &hint))
+			continue;
+		if (!forget)
+			return false;
+		sym_eq->sym[0] = NO_SYM;
+		forget->normalized = ok = false;
+	}
+	return ok;
+}
+
+bool bpf_equations_subsume(struct bpf_verifier_env *env, const struct bpf_verifier_state *old,
+			   const struct bpf_verifier_state *cur)
+{
+	const struct bpf_xreg_equation *xreg_eq;
+	const struct scalar *s;
+
+	/* @old ends after the next jump. The equations that showed it can be gone. */
+	if (old->equations.infeasible && !cur->equations.infeasible && env->bypass_spec_v1)
+		return false;
+	/* see loop_stack_safe() */
+	for_each_xreg_equation(env, &old->equations, xreg_eq) {
+		if ((u32)xreg_eq->xreg < BPF_XREG_TRIP)
+			continue;
+		s = equation_xreg_bounds(env, cur, xreg_eq);
+		if (!s || !scalar_subsumes(equation_xreg_bounds(env, old, xreg_eq), s))
+			return false;
+	}
+	return !old->equations.xreg_equation_cnt ||
+	       check_equations(env, &old->equations, cur, NULL);
+}
+
+/* Join */
+
+/*
+ * Make the equations of @dst hold for @src too. Call it before the xregs are joined.
+ * @leftover_loop: the states are at its header. @widen: @src came around it.
+ */
+void bpf_equations_pre_join(struct bpf_verifier_env *env, struct bpf_verifier_state *dst,
+			    const struct bpf_verifier_state *src, struct bpf_loop *leftover_loop,
+			    bool widen)
+{
+	const struct loop_stack_entry *top = bpf_top_loop(src->frame[src->curframe]);
+	bool enters = leftover_loop && top &&
+		      top->trip < bpf_top_loop(dst->frame[dst->curframe])->trip;
+	struct bpf_equations *eqs;
+
+	if (env->eq_env) {
+		eqs = &env->eq_env->join_state.equations;
+		/* what enters the loop can break the equations that keep the xregs small */
+		if (enters && dst->equations.needs_refine)
+			bpf_equations_refine_all(env, dst);
+		normalize_equations(env, &env->eq_env->join_state);
+		while (!check_equations(env, eqs, dst, eqs) || !check_equations(env, eqs, src, eqs))
+			normalize_equations(env, &env->eq_env->join_state);
+		eqs->needs_refine = widen || dst->equations.needs_refine ||
+				    src->equations.needs_refine;
+		swap(dst->equations, *eqs);
+	}
+}
+
+/* The xregs of @dst are joined. Some of them are gone. */
+void bpf_equations_post_join(struct bpf_verifier_env *env, struct bpf_verifier_state *dst,
+			     const struct bpf_verifier_state *src)
+{
+	u32 cnt = dst->equations.xreg_equation_cnt;
+
+	bpf_equations_clean(env, dst);
+	while (cnt != dst->equations.xreg_equation_cnt &&
+	       !check_equations(env, &dst->equations, src, &dst->equations))
+		normalize_equations(env, dst);
+	dst->equations.infeasible = false;
+}
+
 static void print_operand(struct bpf_verifier_log *log, const char *prefix, struct expr expr)
 {
 	if (expr.coef)
diff --git a/kernel/bpf/join.c b/kernel/bpf/join.c
index 9b9cddfa124..caaf711570a 100644
--- a/kernel/bpf/join.c
+++ b/kernel/bpf/join.c
@@ -235,9 +235,11 @@ int bpf_states_join(struct bpf_verifier_env *env, struct bpf_verifier_state *dst
 	env->pkt_pair_cnt = 0;
 	env->imprecise |= !env->err;
 	dst->suspect_loops |= src->suspect_loops;
+	bpf_equations_pre_join(env, dst, src, leftover_loop, leftover_loop && widen);
 	for (j.fr = 0; j.fr <= dst->curframe; j.fr++)
 		join_func(&j, dst->frame[j.fr], src->frame[j.fr],
 			  env->insn_aux_data[bpf_frame_insn_idx(dst, j.fr)].live_regs_before);
+	bpf_equations_post_join(env, dst, src);
 	dst->max_held_cnt = max(dst->max_held_cnt, src->max_held_cnt);
 	/* no equation is found over a limit */
 	if (env->test_reg_invariants && !bpf_state_subsumes(env, dst, src) &&
diff --git a/kernel/bpf/states.c b/kernel/bpf/states.c
index fa21a9174f6..23e3adb9822 100644
--- a/kernel/bpf/states.c
+++ b/kernel/bpf/states.c
@@ -640,5 +640,5 @@ bool bpf_state_subsumes(struct bpf_verifier_env *env, const struct bpf_verifier_
 				       bpf_frame_insn_idx(old, i)))
 			return false;
 
-	return true;
+	return bpf_equations_subsume(env, old, cur);
 }
-- 
2.55.0

