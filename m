Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795207996;
	b=kIyrUvyzsk/0gBm9j2aDjora+ARHRR/R5j9R1OEG4RJgGbF8qwr9vBfXLw07FEd/RNWQ
	 lT9dch0srQ/5Gdyx0oShAUgihSkirMtP/tRnE44Pn1yVP77HlJ9WSrDZLvyJxBhNh3JG3
	 uttw2e1DCSHqlPpk9lts0PTK1prEVPe2oNjLjJejSqnVQegmx2qENI+N9M+9QVzFBo1a7
	 YBun/md8e0fQtvTGlh/OGdph6B5EHHdu8JO9oeRVWOnqtuL+8XNr5xvhTA2TFzDC0Rx7K
	 0ptJ2w+zBu6OdNDypLqxF7K+Grolf+caGZ86a24i6CFjK8W9CnSvXNWlpzg/sb3eRbw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795207996;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=02prFa0eGjnFLFumX6k+Zw7IjTIqRzyilwt/aJx0ngc=;
	b=rFWRlQq4gtrgSaCUg3Jt1/jO/ncMAK/daAQ9mHWgQtgVZwIZ3GKPL95x1X13+7cHWn1t
	 EV/ijYClnZZMGfuD8EnKQcjGYuL3BRAcNTh+HKGG7J8ltoJ8NPhaAiv/Z1IX3MERzlcd0
	 IzrP/Ki2kEaFgcdWE5N7ZR3mwT7KSblPtOy1izEYiI3M3H6ihkhBp7J0B4AflWQkLv270
	 sNjspwEuAk4D7neo0hKMkdq/kG7LDHWi5aIaC9e9GTk4UohjgvSJ1B/J+8e/1saHYSmz7
	 1e2wZN0lUdg6QFMzXuFPJ8o+6oUt70CjBTlkIkdut8g0cN6UgsVxJ37iygahv2I8KIA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Np6eWb89;
	arc=none smtp.remote-ip=209.85.214.173
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD598606A334
	for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 20:53:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DD598606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Np6eWb89
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2e9d7791b00so12916455ad.0
        for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 12:53:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795207992; x=1795812792; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=02prFa0eGjnFLFumX6k+Zw7IjTIqRzyilwt/aJx0ngc=;
        b=Np6eWb896XR4Gnm86r4C71Jo63yMZklEe/+8XZ7ygPUoAR5CIMhdNWgRveZeJeXOir
         Dk7eiEBxxI3YQQ9MO+gjlL0mHiu8+rtUbz9XdCz9V4x9+giQF7pFGNio00lvVagGlleM
         JTia45J7FwVwYgvMYMtFGCU/pqrPMeYdmelwtDHLjkH+Iuu5MHXYusAEmn0Qa0kJKL+j
         jRA68S/nS2MNtxo8bYiWOfvGvQ8ujdQ09/sHtvQ+IYE5c3s4yveIyFy00wgdjzu57wvO
         LsgAsZ3mJwgIlo+Ax6LaSjGEX/90v6W1gJT1gbL14fpJatVCQTV/yhWl8fG/A5X0pfwh
         070Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795207992; x=1795812792;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=02prFa0eGjnFLFumX6k+Zw7IjTIqRzyilwt/aJx0ngc=;
        b=no1wQNOQKqYrAWV1mWQhVBVMoKlUyjHlbNHyt424EPvU5GH9wA/z26Fpo8cqAcIjIu
         lxmfSuwJ5qiIxwOkx7rXwSShLjSjSZSKUvPbhA5cR5+/8ZqAtOVUDAuP3umRvx08CNSv
         w15UpG93zlEJKhNKRHPTyPIrlhsYawjJg9gTX8KRWEahKvh2kXE2dZ3BxadJz0wwvxqK
         B1KqMRIcMI0+WRoLKIOJ3ZP93nicp6eIq2signIsCg+qPJlZccwWql4NYAj+nCvjM9j7
         aNvUBZpitOrN/E7PN+u9pYA78rSO0jT2JAHLyPh8wkuZXKN+3hMtHxEj+urMcpvy9WHb
         Z1zg==
X-Gm-Message-State: APuU4Z9u4QsMgzCwooqKFX2BBE3+OsURfmwWcSZqDYEpua7nlZ022XVu
	HiqbZ+b1rnFEEZS2hbWlyD6eKWQtbyXWWDS0ODMjAfnrZUhHsF7bTxJwCS3aDw==
X-Gm-Gg: AZFdTZcvSb6c7XiYvSeUXrZeE37TecqA9a6qbppfgkOAWTtBhwmK55o78H1mEtmA3oF
	XnYRWf0LlSQxw6KOl7ZU0ioFnHiwQrL69WKUt2HEmS1jH95kkBpg5oZ4JVzZbXjXQ9oRRyxRJlJ
	uH0cjYZDU4h/QpGvnK7pA72hOdjh1FaIUZiOo22oxpC0OWBrTBhBErfrjZYU1phdrJpL/ILlo0R
	4VbTgwHJvEWGDb32kWGknTByUbS/mioLNPRtO8jiPQcRwE/cit1Y1kwYpP5Zl2YXqnebLfg6PTS
	yoAH/62pfeARb4t0x2mD6t58QmmYA03LFGUEX5oTlG1svtcR32MJ2UpjoQoQjirgEB1RNudRWq+
	CjGfR7oaTfCjiTYxufspRZMgTsnNtj0CvX5TbUcsaTzMgN2CJvBoD0iXaie2IK2yHKQQFfsFewz
	J9YAlRutOw8fcVXoEpXuDLpURn+rL7bh7/MOs6C15PMNcTQfvFc2CoF+592Y23NJ+2OwC4DGqho
	kowzsWjx+E01PWMdrNjuWUt0S/n1sLT4dCh0eE9byK1Dvd0i65Vwrp9q1YuhCK4eh1SlG1pYbCh
	RMfuN5Ukrw6C2kxdp/p1FFNumhEMzR6tG1QJjhbczZQ3ftARnPH1854TGa/14vVAyPkxC1n/m5W
	xk1WZDlzjZG3SsL+S0f6xrn0C1iqkue0GJrKKNokax1GgFrwOQ7BWr/LoKuT8fYRY84TjU2HDCG
	AIhhGwaiC3XrF379mtN0/b
X-Received: by 2002:a17:903:4586:b0:2df:9655:fe24 with SMTP id d9443c01a7336-2f03f14540emr38778445ad.30.1795207992050;
        Fri, 20 Nov 2026 12:53:12 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.240])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f03f14a432sm18857835ad.75.2026.11.20.12.53.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 12:53:11 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next v2 32/49] bpf: Use the equations in the join rule
Date: Fri, 20 Nov 2026 20:49:40 +0000
Message-ID: <20261120204959.614908-33-alexei.starovoitov@gmail.com>
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
 include/linux/bpf_verifier.h |  5 +++++
 kernel/bpf/equation.h        |  1 +
 kernel/bpf/equation_join.c   | 30 ++++++++++++++++++++++++++++++
 kernel/bpf/precision.c       | 11 +++++++++++
 4 files changed, 47 insertions(+)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 4ed4efcd45f..c5793f48ad3 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -2473,6 +2473,11 @@ void bpf_equations_pre_join(struct bpf_verifier_env *env, struct bpf_verifier_st
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
index 0b39d99c9b7..2142869092c 100644
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
index 84a866e960e..93ebf337e4c 100644
--- a/kernel/bpf/equation_join.c
+++ b/kernel/bpf/equation_join.c
@@ -591,6 +591,36 @@ void bpf_note_linear_xregs(struct bpf_verifier_env *env, const struct bpf_verifi
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
index 84090f9a8e3..29966b2d80d 100644
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

