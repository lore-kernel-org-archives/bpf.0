Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795160862;
	b=AzcdR7agXG8rKQVdvRhZ2wZX0vV/nBHTFnFHT6z21gOlLnqY5x46Pv2uDhM34LZry982
	 2/1xE9l8x8RoTdgdo99+2o3RvWottaTb0sWiDzEGJyiO5d+/lel7Jp6+OgT9Lz1pEF9am
	 ObgpqeZuOmdOKVB8FiqzXHybve34EYmfy3515SYhZ92LcDoOQDFs0XjVqG22S2CwUkJ1Y
	 6AG4JOzKfGpCI687I5QEy+PymiEBxyt3lIrCImbQv2MgLtseZNOeaRe9IZ8h1XEL+ICF2
	 sVlsnXBtl5WtqNq3L0AcMy/Pl1INemT7MRZ9W422FcI+WvE+vMOuLjzcl8ZIWi65msw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795160862;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=L96sqPje7fgKM0FVeR+Mu5fZeL/7bpjiInCe8ZqFpo8=;
	b=V9cvssBVhPi9CJZhXac/bocu8tySSTjKrV4SzqqnIoGBUBRueQwZtm3YKWp+je4DhY8V
	 2R4azx/Qi7MkHOHKXTcvsqH7OXiCGrBrCpbg2BA0oVVgtHRnOWMLwmyGaYOENa9kt/1ZE
	 +IIEoFBqu1EYztcGzYKuooYavniYy2ong1Ll4tbrhatRA4OBUtxdci4vJ1j7PA8xE4YDA
	 c8bVb5DaDimDuJuvWdK4fqS4YtT1kWPNGdG5Zq9F38v6iNc/F6Ppfvo/1BvGfyIyYLDpm
	 b6AJVS+KlyAF13l5XaxSOrPQvvNaPwm1aNg7hG9MZy6SOFZvi2PKikGtEH5fBYkBqMA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Xd0DKbKP;
	arc=none smtp.remote-ip=209.85.210.181
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1DA6606A320
	for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 07:47:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B1DA6606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Xd0DKbKP
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-8b58d6f67a5so382344b3a.2
        for <bpf@vger.kernel.org>; Thu, 19 Nov 2026 23:47:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795160861; x=1795765661; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=L96sqPje7fgKM0FVeR+Mu5fZeL/7bpjiInCe8ZqFpo8=;
        b=Xd0DKbKPQOg0Ib39wBT4ePO9jHHveOmDdd9qgC6XdkuB15pn3oNfJ34X3YQPxRnO1O
         biXODLFCmvK9/mTlkQahnr0qCv0SQ9E2ao9R385IhOSAlN24MBcpPXVkd7GmwdkLnxQr
         BqbP4wf1CB3XCnqsZsWB/Q+G+Lnv0Sqf89i6mTMq/AsrzxR5mqmdlNKabeQqjd9xjcOm
         427o2VS3FAs8hAdzxJSK/2rXTg1wiRLO/MbumzJiedtBtTy8F/bl8VJSM7RO+DaGll78
         7Vk3iWp6sh0XQxX4WcLwxcBWGflNJtfSkcP0dt6zm0MTlJ3h4JcF/QU1dgjGvUcOQq3q
         ib1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795160861; x=1795765661;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=L96sqPje7fgKM0FVeR+Mu5fZeL/7bpjiInCe8ZqFpo8=;
        b=Js6/WaUNsK7jtSat3qOBgMMEiXLSE9tZdJaU4Pfkd+DfkyjYPsspCPXtNuUpmHv7sc
         fxOtsPx39wZv47rHYYVNxGdZc8g+PtX7s0hSXl58H85OKTcb9KOm1eAAiNdErBHJm3MI
         VZCLjK8Icv9Y+9XSQJ87odbaNCD2786hZWhRnUhYcuNEIUjzZ9eB0NmMeZBgXj2Ry5be
         tkQZfxWi3C3Byngti9+OiL7A7A1iKjR9YyX2od4R5r3bayUlUlMT5ydqpNTjJWYK2W0d
         CBGxoCIWdvSjEf0XfryhLkVmTM19l4gAftadW95CgNna3rKO1k/TovHv5zN/uvb2FGPK
         xkng==
X-Gm-Message-State: APuU4Z8zMRxEaSMUgmwsDZh2pwqZc319f40IYuj5vIoCyyPzjqnpizMQ
	kMsXiMqmjeTfkX22++ooYhSP702553D37Gtm4VqBNBRMcAh7ASPn2G1x057hLw==
X-Gm-Gg: AZFdTZcfWUNETN6R3HeQL/MOvsARHphe6FuQetxEqvzbkc+GFRhYVnJsHtQXjWZlTHU
	tSDS+9CXK7nGEybh7Z0ImOiunfy5JX+1swxueBcD0N8tflHyzmwKUFpWcDvyn2XTDEGsvXXETUd
	TrsFKb0GFV5iI/LRnxPn5V9+hPczjFoX7Teh5/HQF/o4eDJo6uds+HuWCKG1uC99gAoDVtx/QID
	18TEv/vDwTBreM12nkWAF4TTh4msLfuXAyZzKUl0SwYpdLDfSfNAfm2EAdTmHg3Hww6VPUYV8DR
	Qzmv1N5XafYAnFcy26nRKR1Hu/ToOsf2MaBIGTnHBhYtwIKssNK5CQV5B5NuZTIp342/T5gplB/
	0/YFy1VPrBonXbhbznOCG79LpOB/QbKNo45C52ra8oBuIser1Es45KV14GfVx1XoczejYcqNDOl
	TIkBeWNbvbycisIkXeFFbNpK+UDwMB/1PGmTktuEOAnk9jzHvESNEhZm4NuYZLqf8TUFtWFS2v/
	c/BtNqCCZWhBDfHIakmh8z4B7QPEcV5hFrp3hK4k1P397xUDf3PobFkTAVWqE3KhTYzosIlvxol
	m2BqXnnTKiHvBSh1PyKP/XOCDwU7USMu5CyDU5NgQztH+HcvH0lH2yGl2rJxvtHB0KQPKz7Dlje
	B8sZzlq9ObjkrAZPLESzmICKWYW8Y8lTnXvtaPt5hbHD2gq+mHR+DVbAo4JdZaq4iJG/uAtb7Z9
	o=
X-Received: by 2002:a05:6a00:2e12:b0:886:d769:615 with SMTP id d2e1a72fcca58-8c8794b8e3emr1759891b3a.1.1795160860684;
        Thu, 19 Nov 2026 23:47:40 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.243])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8c87077babfsm1127146b3a.5.2026.11.19.23.47.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 23:47:40 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next 32/49] bpf: Use the equations in the join rule
Date: Fri, 20 Nov 2026 07:42:04 +0000
Message-ID: <20261120074430.2704488-33-alexei.starovoitov@gmail.com>
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

The join rule compares the ranges of the deps. Two cases need the
equations.

1. State 1 has all ranges of state 2, but only state 1 has a relation:

                r1 (data)    r6 (control)
     state 1    0..99        0..99        r1 == r6
     state 2    0..7         0..99
     join       0..99        0..99        a test of r6 tells nothing

   bpf_equations_join_forgets() finds such a pair. It counts as two
   xregs that differ, so the states stay apart. One xreg has to be in
   data_deps: the rule joins what differs in control_deps only.

2. LOOP_DISJOINT_APART keeps disjoint values apart at the header. A
   counter has another value in each trip, so it keeps all trips apart:

     for (i = 0; i < 400; i++) if (x > best) { best = x; at = i; }

   The join has i = trip index and keeps i. So an xreg that moves
   with the trip index keeps no trips of one entry apart.
   bpf_note_linear_xregs() notes these xregs. If a pass notes a new
   one, it does not stop at the errors of the last pass. Later trips
   can show that the xreg moves with the trip index only at first.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/bpf_verifier.h |  6 ++++++
 kernel/bpf/equation.h        |  1 +
 kernel/bpf/equation_join.c   | 32 ++++++++++++++++++++++++++++++++
 kernel/bpf/precision.c       | 11 +++++++++++
 4 files changed, 50 insertions(+)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 2d4d8531ced..c2636f5a6ed 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -1374,6 +1374,7 @@ struct bpf_verifier_env {
 	bool restart;			/* see bpf_flow_next_is_no_bound() */
 	bool guards_late;		/* see bpf_flow_needs_guard() */
 	bool extra_values;		/* a state can have constants that no run has */
+	bool new_linear_xreg;		/* see bpf_same_insns_unproven() */
 	bool seen_direct_write;
 	/* a register may point to the stack and is not PTR_TO_STACK, see bpf_reg_state::buf */
 	bool seen_stack_slice;
@@ -2469,6 +2470,11 @@ void bpf_equations_pre_join(struct bpf_verifier_env *env, struct bpf_verifier_st
 void bpf_equations_post_join(struct bpf_verifier_env *env, struct bpf_verifier_state *dst,
 			     const struct bpf_verifier_state *src);
 u32 bpf_equations_bytes(const struct bpf_equations *eqs);
+/* equation_join.c */
+bool bpf_equations_join_forgets(struct bpf_verifier_env *env, const struct bpf_verifier_state *a,
+				const struct bpf_verifier_state *b, u32 fr,
+				const unsigned long *data_deps, const unsigned long *xregs,
+				u32 bits);
 void bpf_collect_iv_thresholds(struct bpf_verifier_env *env);
 void scalar_bounds_sync(struct scalar *s);
 bool scalar_subsumes(const struct scalar *old, const struct scalar *cur);
diff --git a/kernel/bpf/equation.h b/kernel/bpf/equation.h
index b91f5cf5c49..9430f935bde 100644
--- a/kernel/bpf/equation.h
+++ b/kernel/bpf/equation.h
@@ -54,6 +54,7 @@ struct sym_scratch {
 	u32 first_use;		/* see link_sym_equations() */
 	u32 new_symno;
 	bool determined, by_op;
+	bool forgotten, in_data_deps;	/* bpf_equations_join_forgets() */
 	const struct bpf_sym_equation *op;	/* that makes it */
 	struct expr cur_expr;	/* check_equations(): its value in the other state */
 };
diff --git a/kernel/bpf/equation_join.c b/kernel/bpf/equation_join.c
index 1df6a1cce03..93ebf337e4c 100644
--- a/kernel/bpf/equation_join.c
+++ b/kernel/bpf/equation_join.c
@@ -574,9 +574,11 @@ void bpf_note_linear_xregs(struct bpf_verifier_env *env, const struct bpf_verifi
 	const struct bpf_xreg_equation *old_trip =
 		bpf_find_xreg_equation(&dst->equations, trip_xreg), *xreg_eq, *new;
 	const struct bpf_xreg_equation *new_trip = bpf_find_xreg_equation(join, trip_xreg);
+	struct bpf_loop *loop;
 
 	if (!f->loop_stack_cnt || !old_trip || !new_trip)
 		return;
+	loop = bpf_top_loop(f)->loop;
 	for_each_xreg_equation(env, &dst->equations, xreg_eq) {
 		if (xreg_eq->sym != old_trip->sym || xreg_eq->xreg >> 32 != dst->curframe ||
 		    (u32)xreg_eq->xreg >= BPF_XREG_TRIP)
@@ -589,6 +591,36 @@ void bpf_note_linear_xregs(struct bpf_verifier_env *env, const struct bpf_verifi
 	}
 }
 
+/* An xreg of @data_deps and an xreg of @xregs in frame @fr have one sym in @a and not in @b */
+bool bpf_equations_join_forgets(struct bpf_verifier_env *env, const struct bpf_verifier_state *a,
+				const struct bpf_verifier_state *b, u32 fr,
+				const unsigned long *data_deps, const unsigned long *xregs,
+				u32 bits)
+{
+	const struct bpf_xreg_equation *xreg_eq;
+	struct sym_scratch *sym;
+	struct expr expr;
+	bool is_ptr;
+
+	for_each_xreg_equation(env, &a->equations, xreg_eq)
+		env->eq_env->scratch[xreg_eq->sym] = (struct sym_scratch){};
+	for_each_xreg_equation(env, &a->equations, xreg_eq) {
+		if (xreg_eq->xreg >> 32 != fr || (u32)xreg_eq->xreg >= bits ||
+		    !test_bit((u32)xreg_eq->xreg, xregs))
+			continue;
+		sym = &env->eq_env->scratch[xreg_eq->sym];
+		if (bpf_xreg_expr(env, b, xreg_eq->xreg, &expr, &is_ptr)) {
+			sym->forgotten |= sym->determined && expr.var != sym->cur_expr.var;
+			sym->determined = true;
+			sym->cur_expr = expr;
+		}
+		sym->in_data_deps |= test_bit((u32)xreg_eq->xreg, data_deps);
+		if (sym->forgotten && sym->in_data_deps)
+			return true;
+	}
+	return false;
+}
+
 /* Thresholds */
 
 /*
diff --git a/kernel/bpf/precision.c b/kernel/bpf/precision.c
index d5ec2dfb561..aa9f7f76256 100644
--- a/kernel/bpf/precision.c
+++ b/kernel/bpf/precision.c
@@ -336,6 +336,13 @@ void bpf_compare_states(struct bpf_verifier_env *env, const struct bpf_verifier_
 		bitmap_or(all, all, deps, bits);
 		bitmap_or(deps, deps, data_deps, bits);
 		bpf_add_cost(env, 4 + bitmap_weight(all, bits), BPF_COST_COPY);
+		/* r1 == r6 in one state only: two xregs differ, count both */
+		flags = (bpf_equations_join_forgets(env, old, new, fr, data_deps, deps, bits) ?
+			 CMP_NEW : 0) |
+			(bpf_equations_join_forgets(env, new, old, fr, data_deps, deps, bits) ?
+			 CMP_OLD : 0);
+		note_cmp(cmp, flags, true, true);
+		note_cmp(cmp, flags, true, true);
 		for_each_set_bit(xregno, all, bits) {
 			if (xregno == XREG_STACK_ARGS) {
 				arg_cnt = max(fa->out_stack_arg_cnt, fb->out_stack_arg_cnt);
@@ -355,6 +362,10 @@ void bpf_compare_states(struct bpf_verifier_env *env, const struct bpf_verifier_
 			} else {
 				flags = compare_slots(env, cmp, fa, fb, bpf_xreg_to_spi(xregno));
 			}
+			if (iv_loop && fr == old->curframe && !(flags & CMP_TYPE) &&
+			    test_bit(xregno, iv_loop->linear_xregs) &&
+			    !test_bit(xregno, iv_loop->nonlinear_xregs))
+				flags &= ~(CMP_DISJOINT | CMP_GAP);
 			note_cmp(cmp, flags, test_bit(xregno, data_deps), test_bit(xregno, deps));
 			if (fr == old->curframe && (flags & CMP_DISJOINT) &&
 			    test_bit(xregno, data_deps))
-- 
2.55.0

