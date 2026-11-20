Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795207965;
	b=QirIiG2x2BeEfwdOfPrRdMmDUIL2vVhm1MWNp+2nWKgkYJQet0q/fFzV0YIJox7rWzQh
	 XNi+ZKBUDRhfnnnJDMPdDQ0PaLXCm6gywFlZIX3iPYs27r625LGcu6tFNXzn9oZiOcaXM
	 qdFiMATtVrmcslWhd0PWb37YQa6NYk9Ly8bkzIjHIECJdnjOjD17MtsaBI2a8dOYrchLX
	 zIbeUL/oNFjxm9sI4Z2Qo7QXEobpsAhJegnYj0cFuCJoJHzwXDhMYDRQoM7WQPVcK88br
	 vEH/bcBk4ftXAoD9RKptcWmprBtRNFZTXiUtDT1BShlKjqiHX9jUOXLDyLcd3UIcm/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795207965;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=4zrBItvIkglEpFy/k5/SnCVeIwKbQPVZPArr4ZfaOxo=;
	b=yDsnZvHb4cRSvGTs1/Gj4QACBrz6F20T9o8tyvvtSH+J/xQah8JS/EfVOq1EaVkSCOJo
	 SqpA24h75GeIi9HUGlwenTXk8StNCfkjUME4o7+9WpEYC5QWNKX0p+PCAN+SY4CcXX5Re
	 d/OFTTl/pD7RcS63LPz+yVX5VyN5ZTp+2R1MOIIozNE8zZgNHOMr9QWzuO5bnDMOz8DE4
	 VcCGXnKrBO0WiSFb/3Go/XaUC+BruuFzkcVObnX3ZFP10cc8DPSKnaWlnc+20/6XIkWHs
	 oe5s0Op2oA7ucYiOhQFlh8URQZVaiYSBgED78onXYclwECTCrkieHEgyrJjUi3QVjQg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Muc+DnHd;
	arc=none smtp.remote-ip=209.85.215.169
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C617B606A686
	for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 20:52:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C617B606A686
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Muc+DnHd
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-cd60c5da24cso991532a12.0
        for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 12:52:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795207963; x=1795812763; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4zrBItvIkglEpFy/k5/SnCVeIwKbQPVZPArr4ZfaOxo=;
        b=Muc+DnHdVwLN4NowDOF/nguY9LIlmpqaZJd484sfT7AddPD6Ro9C/KMTguchZyZC1j
         HKI8o5bHu7J6h0VDi68pPqa6kklH/QjTFTdK5gCHeABip14uA7pDA/TuaVnhIIGYgfjC
         /VWAW578S7nU1V4M8z0J2mG9A7QFojc1yJhqQTTkaKPFl7I3yUnWHy4nkYHiA8JJZv/A
         YL9jPetIWKGoK1ihYvkTqIwWb6pfdDI/VoFuXtyWrGbUcnrrI1szqMW6xcSKPH6+SNvq
         IMJ+6Tyvx60abS1S4yIun1s67/Cwa6OAc/nJ67mxUpuSlwYlhCYn293swmuqSD19FSZA
         tXrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795207963; x=1795812763;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=4zrBItvIkglEpFy/k5/SnCVeIwKbQPVZPArr4ZfaOxo=;
        b=UInP/y2iWZrD7ypP20VpvhwwyC/yFXB0CQ42VIiVv6oJL/lMPa9/atQi/Y9eeuwKG1
         zF5tfxSF53v10cbMA9T9dkhQCZWXZZgHQRRpLciWrDPkCDFrUo5x3KPJBzGlxRHkCAAj
         7AZO8RemO4VvKYmMrx3osfz/fvqm5WuYhw+MQGCP+duZJmY9oSagX3xxUdeIpAUwadXe
         ETTLyEviBUFUQv5hpkFnY3yKQY4KS84uW6PP+B3F43Ut8yEqBqx6BJ2ozS7iF2cryXY7
         +QN18hL7W/NT3N47UhWwkYCrGT2Yga8+KYs2AtJRvB5xzgPg/6Fk6FfQc1KWRAALsUNM
         RavA==
X-Gm-Message-State: APuU4Z9mazOWZ+PfMQP3pRJgaOkJ70xF537N+j7Zxk9lXLkr2VEuFDNU
	KQdQTnCPjYAxJCRkqNtJqJkLeh//qnZXgLaadYmIY4b4JS8xBqeNjaiZesNgLA==
X-Gm-Gg: AYBFou2BuC2tJxi/o+YF2SHOV423KTMfxb9IYhU+lg8xBJnsskvLj71P9jHrHCG2okt
	N2Y055n7M5lVvcXwkWhbzcOarFKMfMxjcNhIycvLX1yyhataia0tVGdOauyd0d8vXszaKfqfCoM
	tvvqWVjgaIC/ZlZBJqK7NtWZQ20Py5J39G7qemhZVRFem3hOWsJeKoO7ssF8j9mZSmRREwboLds
	OwC8Sk/MhsXeG1RKvzSpX3J0S4t08Ngt8trXfP5H/6lkUCcfW94iQ/9gIv3q4c7lFw65vjO/P+z
	vAOcqV9bkVBIQX2vzpHvfLxT77x4T0L9QYS8BCMoBxcMnHbjQ+Itfo/U9aHhSc9TzUW5G7nEBQj
	JDYs3W27Yv8Ku8DfLimbo8ZH1xPlpZECuugQkDVzchlF1WwuEogJcOWURDX7CIvEvHNqd8taYkP
	E0BxrWIAcEv15bIU2gAv3zY654yOp1jtth9d5kbl0C6ER680bqc8K1+sphWJzULfTWa2yBxymo6
	pQfLfkjNfsZcHIHoOb3AErhrOh0Ta+PGj78Y1r5Zl3myAazviDWOlk3HynAKFrqZHv2SkK+0nLH
	8YuuNx5u2rbLJNweek+nFdZo++fq/IYBR2idkIUhUHfL/qXAt3pVX2ulY6KBdKWfuV1c39AmITO
	kxP7qTFqsh3yAYdrOuvmFsyQIYgmiVLc5ramm4Trxup7Y1l6JPx0ZjTzK1jK4F2bGwn7V3q+8GA
	==
X-Received: by 2002:a05:6a20:ef0e:b0:3fa:df2d:d3c2 with SMTP id adf61e73a8af0-4014bc5577amr3773473637.37.1795207962895;
        Fri, 20 Nov 2026 12:52:42 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.252])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8c872e45756sm1976046b3a.27.2026.11.20.12.52.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 12:52:42 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next v2 27/49] bpf: Guess the equations of a join
Date: Fri, 20 Nov 2026 20:49:35 +0000
Message-ID: <20261120204959.614908-28-alexei.starovoitov@gmail.com>
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

A join of ranges forgets what moves together. A phi is a sym of the
join. It has one value in each state:

               trip   r1         r2             r3
   old state   0      0          p              0..9
   new state   1      4          p + 8          1..9
   join        sym0   4 * sym0   p + 8 * sym0   sym0 + (0..9)

join_expr() looks for a phi that gives both values. If there is none,
it makes one. The sums and ops of the two states are translated to the
phis. A sym can become two phis. Each of them is tried.

The phi that is 0 in the old state and 1 in the new state is the
selector. It can be a stored condition:

  c = 0, len = 0..8   |   c = 1, len = 64..72
  join: len - 64 * c = 0..8

A number gets a phi if its two ranges are disjoint, in 64 bits or in
the low 32 bits. A helper returns an int, and the high bits are not
known:

  w9 = 0; if w0 s> -1 goto L; w9 = -155; L: ...; if w0 s< 0 goto err

A phi that grows is widened to a threshold, and keeps its step. The
low 32 bits go around their own circle, so an int can go through 0:

  int i = -5; do { ... } while (++i != 3);      0xfffffffb .. 0 .. 2

It terminates. From the third join around a cycle only the equations
of the old state are kept, and an equation can only get weaker.

The cpu can speculate past the test of c. So a constant makes no
phi without bypass_spec_v1.

A number can grow in a loop and in the loop around it:

  for (j = 0; j < 13; j++) {
          for (k = 0; k < 20; k++)
                  off += 0..2;
          off += 0..1;
  }
  buf[off]                      off is 0..533

The second outer trip enters the inner loop again. Each state shows one
trip index, the other one is 0:

  old state   j = 0   off = 2 * k + d
  new state   k = 0   off = 41 * j + d

No equation holds in both, so off has no bound, and all trips have to
be peeled. Make a sym for the two parts:

  join        m = 2 * k + 41 * j,  off = m + d

All of this file is a guess, see the previous patch.

                          insns processed
  program                 bpf-next   without m   with m
  strobemeta_nounroll1    10658      48984       1127
  strobemeta_nounroll2    22116      52061       1127
  strobemeta_subprogs     10829      45634       1007

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/bpf_verifier.h |   3 +
 kernel/bpf/Makefile          |   1 +
 kernel/bpf/equation.c        |   1 +
 kernel/bpf/equation.h        |   5 +
 kernel/bpf/equation_join.c   | 541 +++++++++++++++++++++++++++++++++++
 kernel/bpf/fixups.c          |   1 +
 6 files changed, 552 insertions(+)
 create mode 100644 kernel/bpf/equation_join.c

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index a2e8844f291..065ffac5ffd 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -473,6 +473,7 @@ struct loop_stack_entry {
 	bool peeled;		/* in a peeled trip, not in the leftover */
 	/* an xreg: how many times the program came back to the header */
 	struct scalar trip_index;
+	bool trip_widened;	/* it was moved to a threshold, or it does not grow */
 };
 
 /* The state is in a walk on patience, which may not get to the end of the loop */
@@ -891,6 +892,8 @@ struct bpf_loop {
 	);
 	bool partitioned;	/* the last partition was for this loop */
 	bool peeled_joined;	/* at the start of a peeled trip, against the join rule */
+	struct bpf_iv_threshold *iv_thresholds;	/* where an iv can stop, see equation_join.c */
+	u32 iv_threshold_cnt, iv_threshold_cap;
 	struct bpf_loop_per_pass this_pass;
 	/* sorted constants of the loop, the largest and the smallest constant that an insn adds */
 	s64 *thresholds;
diff --git a/kernel/bpf/Makefile b/kernel/bpf/Makefile
index bb2841387d4..575c7d0ff4e 100644
--- a/kernel/bpf/Makefile
+++ b/kernel/bpf/Makefile
@@ -14,6 +14,7 @@ obj-$(CONFIG_BPF_SYSCALL) += local_storage.o queue_stack_maps.o ringbuf.o bpf_in
 obj-$(CONFIG_BPF_SYSCALL) += bpf_local_storage.o bpf_task_storage.o
 obj-$(CONFIG_BPF_SYSCALL) += fixups.o cfg.o states.o check_btf.o flow.o join.o
 obj-$(CONFIG_BPF_SYSCALL) += equation.o
+obj-$(CONFIG_BPF_SYSCALL) += equation_join.o
 obj-$(CONFIG_BPF_SYSCALL) += precision.o
 obj-${CONFIG_BPF_LSM}	  += bpf_inode_storage.o
 obj-$(CONFIG_BPF_SYSCALL) += disasm.o mprog.o
diff --git a/kernel/bpf/equation.c b/kernel/bpf/equation.c
index 2e182636094..041311f0d56 100644
--- a/kernel/bpf/equation.c
+++ b/kernel/bpf/equation.c
@@ -2158,6 +2158,7 @@ void bpf_equations_pre_join(struct bpf_verifier_env *env, struct bpf_verifier_st
 		/* what enters the loop can break the equations that keep the xregs small */
 		if (enters && dst->equations.needs_refine)
 			bpf_equations_refine_all(env, dst);
+		bpf_guess_equations(env, dst, src, leftover_loop, widen);
 		normalize_equations(env, &env->eq_env->join_state);
 		while (!check_equations(env, eqs, dst, eqs) || !check_equations(env, eqs, src, eqs))
 			normalize_equations(env, &env->eq_env->join_state);
diff --git a/kernel/bpf/equation.h b/kernel/bpf/equation.h
index 5a2d7f24658..564ff6e5e6c 100644
--- a/kernel/bpf/equation.h
+++ b/kernel/bpf/equation.h
@@ -79,6 +79,7 @@ struct bpf_equation_env {
 	struct bpf_verifier_state join_state;	/* it has equations and no frames */
 	struct join_phi *phis;
 	u32 *phi_index;
+	u32 phi_cap, phi_index_cap;
 };
 
 #define for_each_sym_equation(env, eqs, pos)						\
@@ -185,4 +186,8 @@ bool bpf_find_next_diff(struct bpf_verifier_env *env, const struct bpf_equations
 void bpf_eval_diff(struct bpf_verifier_env *env, const struct bpf_verifier_state *st,
 		   const struct expr *a, const struct expr *b, struct scalar *bounds);
 
+/* equation_join.c */
+void bpf_guess_equations(struct bpf_verifier_env *env, const struct bpf_verifier_state *dst,
+			 const struct bpf_verifier_state *src, struct bpf_loop *leftover_loop,
+			 bool widen);
 #endif
diff --git a/kernel/bpf/equation_join.c b/kernel/bpf/equation_join.c
new file mode 100644
index 00000000000..d47c4f04453
--- /dev/null
+++ b/kernel/bpf/equation_join.c
@@ -0,0 +1,541 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * The equations of a join and the thresholds of a trip index.
+ *
+ * A phi is a sym of the join. It has one value in each state:
+ *
+ *              trip   r1         r2             r3
+ *  old state   0      0          p              0..9
+ *  new state   1      4          p + 8          1..9
+ *  join        sym0   4 * sym0   p + 8 * sym0   sym1 = sym0 + sym2, sym2 is 0..9
+ */
+#include <linux/bpf.h>
+#include <linux/cnum.h>
+#include <linux/filter.h>
+#include <linux/slab.h>
+#include <linux/tnum.h>
+#include "equation.h"
+
+/* The values of a sym of the join in the two states */
+struct join_phi {
+	struct expr arg[2];
+	u32 next_phi;	/* see phi_list() */
+	bool in_sym_equation;
+};
+
+/* Only the range is known */
+static const struct expr no_expr = { 1, 0, VAR_NONE };
+
+struct equation_join {
+	struct bpf_verifier_env *env;
+	const struct bpf_verifier_state *st[2];
+	struct bpf_equations *eqs;
+	const struct bpf_loop *leftover_loop;
+	bool widen;
+	/* the sym that is 0 in the old state and 1 in the new state */
+	u64 selector;
+	/* by the sym of a state. 0: none, else the sym of the join + 1 */
+	u32 *sym2phi[2], *phi_lists;
+	/* after the equation that was found last in the two states and in the join */
+	u32 hint[3];
+	u32 sums;
+};
+
+enum iv_threshold_kind {
+	THRESHOLD_EXIT_JUMP,	/* of the trip index, by a jump that leaves the loop */
+	THRESHOLD_BODY_JUMP,	/* by another jump: the next trip can test its result */
+	THRESHOLD_SYM,		/* of a number that moves with it */
+	THRESHOLD_DIFF,		/* of the difference of two numbers */
+};
+
+struct bpf_iv_threshold {
+	s64 value;
+	enum iv_threshold_kind kind;
+	/* the jump that gave it, and its index among the thresholds of that jump */
+	u32 insn_idx, idx;
+};
+
+#define for_each_iv_threshold(env, loop, threshold, k)					\
+	for (bpf_add_cost(env, (loop)->iv_threshold_cnt, BPF_COST_SCAN),		\
+	     threshold = (loop)->iv_thresholds;						\
+	     threshold < (loop)->iv_thresholds + (loop)->iv_threshold_cnt; threshold++)	\
+		if (threshold->kind == (k))
+
+static const struct expr *phi_args(const struct equation_join *j, u64 var)
+{
+	return j->env->eq_env->phis[var_symno(var)].arg;
+}
+
+static bool phi_has_exprs(const struct expr *arg)
+{
+	return !expr_equal(&arg[0], &no_expr) && !expr_equal(&arg[1], &no_expr);
+}
+
+/* The list of phis that are made of the vars in @arg. NULL if there can be only one. */
+static u32 *phi_list(const struct equation_join *j, const struct expr *arg)
+{
+	int i = !arg[0].coef;
+
+	if (!arg[i].coef)
+		return j->phi_lists;
+	return !var_is_sym(arg[i].var) ? NULL :
+	       j->phi_lists + 1 + i * j->st[0]->equations.sym_cnt + var_symno(arg[i].var);
+}
+
+/*
+ * The low 32 bits go around their own circle to the next threshold:
+ *	int i = -5; do { ... } while (++i != 3);	i is 0xfffffffb..0xffffffff, 0..2
+ */
+static void widen_low32(struct equation_join *j, struct scalar *widened,
+			const struct scalar *joined, const struct scalar *old,
+			enum iv_threshold_kind kind)
+{
+	u32 start = joined->r32.base, end = start + joined->r32.size;
+	u64 up = end == old->r32.base + old->r32.size ? 0 : U32_MAX;
+	u64 down = start == old->r32.base ? 0 : U32_MAX;
+	const struct bpf_iv_threshold *threshold;
+
+	if (!up && !down)
+		widened->var_off = tnum_with_subreg(widened->var_off, joined->var_off);
+	for_each_iv_threshold(j->env, j->leftover_loop, threshold, kind) {
+		up = min_t(u64, up, (u32)(threshold->value - end));
+		down = min_t(u64, down, (u32)(start - threshold->value));
+	}
+	if (joined->r32.size + up + down < U32_MAX)
+		cnum32_intersect_with(&widened->r32, (struct cnum32){ start - down,
+								      joined->r32.size +
+								      up + down });
+}
+
+static u64 new_phi(struct equation_join *j, const struct expr *arg, const struct scalar *bounds,
+		   enum iv_threshold_kind kind)
+{
+	struct bpf_equation_env *eq_env = j->env->eq_env;
+	struct scalar joined = bounds[0], widened;
+	s64 min = S64_MIN, max = S64_MAX;
+	const struct bpf_iv_threshold *threshold;
+	bool is_ptr, grew_before, grows;
+	u32 *list;
+	u64 var;
+	int i;
+
+	bpf_add_cost(j->env, 1, BPF_COST_INSN);
+	scalar_union(&joined, &bounds[1]);
+	grows = j->leftover_loop && !scalar_equal(&joined, &bounds[0]);
+	grew_before = arg[0].var != VAR_NONE &&
+		      bpf_find_var_bounds(j->env, j->st[0], arg[0].var, &is_ptr)->grew_once;
+	if (grows && j->widen && grew_before) {
+		widened = joined;
+		for_each_iv_threshold(j->env, j->leftover_loop, threshold, kind) {
+			if (threshold->value >= cnum64_smax(joined.r64))
+				max = min(max, threshold->value);
+			if (threshold->value <= cnum64_smin(joined.r64))
+				min = max(min, threshold->value);
+		}
+		if (kind == THRESHOLD_SYM) {
+			scalar_widen(&widened, &bounds[0], min, max);
+		} else {
+			if (cnum64_smin(joined.r64) >= cnum64_smin(bounds[0].r64))
+				min = cnum64_smin(joined.r64);
+			if (cnum64_smax(joined.r64) <= cnum64_smax(bounds[0].r64))
+				max = cnum64_smax(joined.r64);
+			scalar_set_unknown(&widened);
+			widened.r64 = cnum64_union(cnum64_from_srange(min, max), joined.r64);
+		}
+		widen_low32(j, &widened, &joined, &bounds[0], kind);
+		/* the step changes only to a divisor. A number that can wrap has no step. */
+		if (cnum64_smin(widened.r64) != S64_MIN && cnum64_smax(widened.r64) != S64_MAX) {
+			widened.step = joined.step;
+			widened.base = joined.base;
+		}
+		joined = widened;
+	}
+	if (!bpf_grow_array(j->env, &eq_env->phis, &eq_env->phi_cap,
+			    j->eqs->sym_cnt + 1, sizeof(*eq_env->phis)))
+		return VAR_NONE;
+	var = bpf_new_sym(j->env, j->eqs, &joined);
+	if (!var_is_sym(var))
+		return var;
+	j->eqs->syms[var_symno(var)].grew_once = grew_before || grows;
+	for (i = 0; i < 2; i++) {
+		eq_env->phis[var_symno(var)].arg[i] = arg[i];
+		if (arg[i].coef == 1 && var_is_sym(arg[i].var) &&
+		    !j->sym2phi[i][var_symno(arg[i].var)])
+			j->sym2phi[i][var_symno(arg[i].var)] = var_symno(var) + 1;
+	}
+	eq_env->phis[var_symno(var)].next_phi = 0;
+	eq_env->phis[var_symno(var)].in_sym_equation = false;
+	list = phi_has_exprs(arg) ? phi_list(j, arg) : NULL;
+	for (; list && *list; list = &eq_env->phis[*list - 1].next_phi)
+		bpf_add_cost(j->env, 1, BPF_COST_SCAN);
+	if (list)
+		*list = var_symno(var) + 1;
+	if (!arg[0].coef && !arg[1].coef)
+		j->selector = var;
+	return var;
+}
+
+/* The expr that is @expr[0] in the old state and @expr[1] in the new state */
+static struct expr join_expr(struct equation_join *j, const struct expr *expr,
+			     enum iv_threshold_kind kind)
+{
+	struct expr arg[2], res;
+	struct scalar bounds[2];
+	const struct expr *phi_arg;
+	u32 symno, i, *list;
+
+	if (!expr[0].coef && expr_equal(&expr[0], &expr[1]))
+		return expr[0];
+	/* the cpu can speculate past the test of one number that only goes with another one */
+	if ((!expr[0].coef || !expr[1].coef) && !j->env->bypass_spec_v1)
+		return no_expr;
+	for (list = phi_list(j, expr); list && *list;
+	     list = &j->env->eq_env->phis[symno].next_phi) {
+		symno = *list - 1;
+		phi_arg = phi_args(j, symno);
+		bpf_add_cost(j->env, 1, BPF_COST_COPY);
+		if (phi_arg[0].var != expr[0].var || phi_arg[1].var != expr[1].var)
+			continue;
+		bpf_add_cost(j->env, 1, BPF_COST_XREG);
+		i = !phi_arg[0].coef;
+		res = make_expr(0, 0, phi_arg[i].coef ? expr[i].coef : expr[1].off - expr[0].off);
+		if (phi_arg[i].coef && !bpf_expr_div_exact(&res, 0, phi_arg[i].coef))
+			continue;
+		res = make_expr(res.off, VAR_SYM | symno, expr[0].off - res.off * phi_arg[0].off);
+		arg[0] = expr_scale(phi_arg[0], res.coef, res.off);
+		arg[1] = expr_scale(phi_arg[1], res.coef, res.off);
+		if (expr_equal(&arg[0], &expr[0]) && expr_equal(&arg[1], &expr[1]))
+			return res;
+	}
+	res.coef = expr[0].coef ?: expr[1].coef ?: expr[1].off - expr[0].off;
+	res.off = expr[0].coef || !expr[1].coef ? expr[0].off : expr[1].off;
+	arg[0] = expr[0];
+	arg[1] = expr[1];
+	if (!bpf_expr_div_exact(&arg[0], res.off, res.coef) ||
+	    !bpf_expr_div_exact(&arg[1], res.off, res.coef)) {
+		res = make_expr(1, VAR_NONE, 0);
+		arg[0] = expr[0];
+	}
+	bpf_eval_expr(j->env, j->st[0], &arg[0], &bounds[0]);
+	bpf_eval_expr(j->env, j->st[1], &arg[1], &bounds[1]);
+	res.var = new_phi(j, arg, bounds, kind);
+	return res;
+}
+
+static void join_xreg(struct equation_join *j, u64 xreg)
+{
+	struct expr expr[2];
+	bool is_ptr[2];
+
+	if (over_limit(j->env) || bpf_find_xreg_equation(j->eqs, xreg) ||
+	    !bpf_xreg_expr(j->env, j->st[0], xreg, &expr[0], &is_ptr[0]) ||
+	    !bpf_xreg_expr(j->env, j->st[1], xreg, &expr[1], &is_ptr[1]) || is_ptr[0] != is_ptr[1])
+		return;
+	expr[0] = join_expr(j, expr,
+			    (u32)xreg < BPF_XREG_TRIP ? THRESHOLD_SYM : THRESHOLD_EXIT_JUMP);
+	bpf_set_xreg_equation(j->env, j->eqs, xreg, &expr[0], is_ptr[0]);
+}
+
+static bool scalars_are_disjoint(const struct scalar *a, const struct scalar *b)
+{
+	return cnum64_is_empty(cnum64_intersect(a->r64, b->r64)) ||
+	       cnum32_is_empty(cnum32_intersect(a->r32, b->r32));
+}
+
+/* The xregs that have no equation. @all: what a trip changes. */
+static void join_other_xregs(struct equation_join *j, bool all)
+{
+	const struct scalar *a, *b;
+	u32 fr, xregno, cnt;
+	bool is_ptr;
+
+	for (fr = 0; fr <= j->st[0]->curframe; fr++) {
+		cnt = bpf_spi_to_xreg(bpf_stack_nr_slots(j->st[0]->frame[fr]));
+		bpf_add_cost(j->env, cnt, BPF_COST_XREG);
+		for (xregno = 0; xregno < cnt; xregno++) {
+			a = bpf_find_var_bounds(j->env, j->st[0], bpf_xreg(fr, xregno), &is_ptr);
+			b = a ? bpf_find_var_bounds(j->env, j->st[1], bpf_xreg(fr, xregno),
+						    &is_ptr) : NULL;
+			if (b && !scalar_equal(a, b) && (all || scalars_are_disjoint(a, b)))
+				join_xreg(j, bpf_xreg(fr, xregno));
+		}
+	}
+}
+
+/* Most equations are in the same order in all tables */
+static bool find_diff(struct equation_join *j, int i, const struct expr *a, const struct expr *b,
+		      struct expr *diff)
+{
+	struct equation_pos pos = { .next = j->hint[i] };
+
+	if (!bpf_find_next_diff(j->env, i < 2 ? &j->st[i]->equations : j->eqs, a, b, &pos, diff))
+		return false;
+	j->hint[i] = pos.next;
+	return true;
+}
+
+static void join_add_sym_equation(struct equation_join *j, struct bpf_sym_equation sym_eq)
+{
+	int i;
+
+	for (i = 0; i < 3; i++)
+		if (sym_eq.coef[i] && sym_eq.sym[i] != NO_SYM)
+			j->env->eq_env->phis[sym_eq.sym[i]].in_sym_equation = true;
+	j->sums += bpf_add_sym_equation(j->env, j->eqs, sym_eq);
+}
+
+/* An equation for @a - @b. True if it needs no new sym. @needs_expr: a range is not enough. */
+static bool join_diff(struct equation_join *j, struct expr a, struct expr b, bool needs_expr)
+{
+	struct join_phi *phis = j->env->eq_env->phis;
+	u32 sym_cnt = j->eqs->sym_cnt;
+	struct expr expr[2], x, y, res;
+	struct scalar bounds[2];
+	int i;
+
+	if (!a.coef || !b.coef || a.var == b.var || over_limit(j->env))
+		return true;
+	if (phis[var_symno(a.var)].in_sym_equation && phis[var_symno(b.var)].in_sym_equation &&
+	    find_diff(j, 2, &a, &b, &res))
+		return true;
+	if (!phi_has_exprs(phi_args(j, a.var)) || !phi_has_exprs(phi_args(j, b.var)))
+		return false;
+	for (i = 0; i < 2; i++) {
+		x = expr_scale(phi_args(j, a.var)[i], a.coef, 0);
+		y = expr_scale(phi_args(j, b.var)[i], b.coef, 0);
+		if (find_diff(j, i, &x, &y, &expr[i]))
+			continue;
+		if (needs_expr || !j->env->bypass_spec_v1 || (i && expr_equal(&expr[0], &no_expr)))
+			return false;
+		bpf_eval_diff(j->env, j->st[i], &x, &y, &bounds[i]);
+		expr[i] = no_expr;
+	}
+	i = expr_equal(&expr[0], &no_expr);
+	if (!phi_has_exprs(expr))
+		bpf_eval_expr(j->env, j->st[i], &expr[i], &bounds[i]);
+	res = phi_has_exprs(expr) ? join_expr(j, expr, THRESHOLD_DIFF) :
+				    make_expr(1, new_phi(j, expr, bounds, THRESHOLD_DIFF), 0);
+	if (res.coef && !var_is_sym(res.var))
+		return false;
+	join_add_sym_equation(j, (struct bpf_sym_equation){
+		{ a.coef, -b.coef, -res.coef },
+		{ a.var, b.var, res.var },
+		-1, -res.off });
+	return sym_cnt == j->eqs->sym_cnt;
+}
+
+/* Translate @expr from state @input to the join */
+static bool translate_expr(struct equation_join *j, int input, struct expr *expr)
+{
+	u32 symno;
+
+	if (!expr->coef)
+		return true;
+	symno = j->sym2phi[input][var_symno(expr->var)];
+	if (!symno--)
+		return false;
+	*expr = make_expr(expr->coef, VAR_SYM | symno,
+			  expr->off - expr->coef * phi_args(j, symno)[input].off);
+	return true;
+}
+
+static void join_op(struct equation_join *j, int input, const struct bpf_sym_equation *sym_eq)
+{
+	struct expr op[2], arg[2], res[2];
+	int i, k;
+
+	for (k = 0; k < 2; k++) {
+		op[k] = rhs_expr(sym_eq, k);
+		if (!translate_expr(j, input, &op[k]) ||
+		    (op[k].coef && !phi_has_exprs(phi_args(j, op[k].var))))
+			return;
+	}
+	if (bpf_find_op(j->env, j->eqs, sym_eq->insn_idx, op, res))
+		return;
+	for (i = 0; i < 2; i++) {
+		for (k = 0; k < 2; k++)
+			arg[k] = !op[k].coef ? op[k] :
+				 expr_scale(phi_args(j, op[k].var)[i], op[k].coef, op[k].off);
+		if (!bpf_find_op(j->env, &j->st[i]->equations, sym_eq->insn_idx, arg, &res[i]))
+			return;
+	}
+	res[0] = join_expr(j, res, THRESHOLD_SYM);
+	bpf_add_op(j->env, j->eqs, sym_eq->insn_idx, op, res);
+}
+
+/* The equations between the syms of state @input */
+static void join_sym_equations(struct equation_join *j, int input)
+{
+	const struct bpf_sym_equation *sym_eq;
+	struct expr a, b;
+	int last;
+
+	for_each_sym_equation(j->env, &j->st[input]->equations, sym_eq) {
+		if (is_op(sym_eq))
+			join_op(j, input, sym_eq);
+		if (is_op(sym_eq) || j->sums >= SUMS_PER_XREG * j->eqs->xreg_equation_cnt)
+			continue;
+		for (last = 2; last >= (sym_eq->coef[2] ? 0 : 2); last--) {
+			a = sym_expr(sym_eq->coef[!last], sym_eq->sym[!last], 0);
+			b = sym_expr(-sym_eq->coef[2 - (last == 2)],
+				     sym_eq->sym[2 - (last == 2)], 0);
+			if (translate_expr(j, input, &a) && translate_expr(j, input, &b) &&
+			    join_diff(j, a, b, false))
+				break;
+		}
+	}
+}
+
+/* Two phis are one sym in state @input: i, or i + 1. The first @xreg_phi_cnt phis have xregs. */
+static void join_keep_diffs(struct equation_join *j, int input, u32 xreg_phi_cnt)
+{
+	u32 symno, first_symno, cnt = j->eqs->sym_cnt, *sym2phi;
+	struct expr arg;
+
+	for (symno = 1; symno < cnt && !over_limit(j->env); symno++) {
+		arg = phi_args(j, symno)[input];
+		sym2phi = var_is_sym(arg.var) ? &j->sym2phi[input][var_symno(arg.var)] : NULL;
+		first_symno = sym2phi ? *sym2phi - 1 : symno;
+		if (first_symno >= symno)
+			continue;
+		join_diff(j, sym_expr(1, symno, 0), sym_expr(arg.coef, first_symno, 0), true);
+		if (arg.coef != 1 || symno >= xreg_phi_cnt)
+			continue;
+		/* the equations of the sym can hold for this phi only */
+		*sym2phi = symno + 1;
+		join_sym_equations(j, input);
+		*sym2phi = first_symno + 1;
+	}
+}
+
+/* Find "@x = *@part + rest" in state @input. *@part is a constant in the other state. */
+static bool find_sum_part(struct equation_join *j, int input, u64 x, struct expr *part)
+{
+	const struct bpf_sym_equation *sym_eq;
+	int i, pos;
+
+	for_each_sum(j->env, &j->st[input]->equations, sym_eq) {
+		pos = find_sym_pos(sym_eq, var_symno(x));
+		for (i = 0; i < 3 && pos < 3 && is_plus_minus_one(sym_eq->coef[pos]); i++) {
+			if (i == pos || !sym_eq->coef[i])
+				continue;
+			*part = sym_expr(-sym_eq->coef[pos] * sym_eq->coef[i],
+					 sym_eq->sym[i], 0);
+			if (!translate_expr(j, input, part) || phi_args(j, part->var)[!input].coef)
+				continue;
+			part->off = 0;
+			return true;
+		}
+	}
+	return false;
+}
+
+/*
+ * A number grows with two trip indexes. Each state shows one of them:
+ *	old state  j = 0  x = 2 * k + d		join  m = 2 * k + 41 * j
+ *	new state  k = 0  x = 41 * j + d	      x = m + d
+ */
+static void join_sum_parts(struct equation_join *j, u32 phi_cnt)
+{
+	struct expr part[2], arg[2], sum;
+	u32 symno;
+
+	for (symno = 0; symno < phi_cnt && !over_limit(j->env); symno++) {
+		memcpy(arg, phi_args(j, symno), sizeof(arg));
+		if (arg[0].coef != 1 || arg[1].coef != 1 ||
+		    !var_is_sym(arg[0].var) || !var_is_sym(arg[1].var) ||
+		    !find_sum_part(j, 0, arg[0].var, &part[0]) ||
+		    !find_sum_part(j, 1, arg[1].var, &part[1]))
+			continue;
+		part[1].coef = -part[1].coef;
+		join_diff(j, part[0], part[1], true);
+		if (find_diff(j, 2, &part[0], &part[1], &sum))
+			join_diff(j, sym_expr(1, symno, 0), sum, true);
+	}
+}
+
+/*
+ * The ends of the range of @var in the two states are on two lines. So a stored condition
+ * gives the range:
+ *	c = x == 0; ... if (c)
+ */
+static void join_bounds_by_selector(struct equation_join *j, u64 var, bool always)
+{
+	const struct expr *arg = phi_args(j, var);
+	struct scalar a, b;
+	s64 min_slope, max_slope;
+
+	if (var == j->selector || !phi_has_exprs(arg))
+		return;
+	bpf_eval_expr(j->env, j->st[0], &arg[0], &a);
+	bpf_eval_expr(j->env, j->st[1], &arg[1], &b);
+	if (!always && !scalars_are_disjoint(&a, &b))
+		return;
+	min_slope = b.r64.base - a.r64.base;
+	max_slope = min_slope + b.r64.size - a.r64.size;
+	if (max(a.r64.size, b.r64.size) >= U32_MAX) {
+		if (!always && max(a.r32.size, b.r32.size) == U32_MAX)
+			return;
+		min_slope = (s32)(b.r32.base - a.r32.base);
+		max_slope = (s32)(min_slope + b.r32.size - a.r32.size);
+	}
+	if (min_slope)
+		join_diff(j, make_expr(1, var, 0), make_expr(min_slope, j->selector, 0), false);
+	if (max_slope && max_slope != min_slope)
+		join_diff(j, make_expr(1, var, 0), make_expr(max_slope, j->selector, 0), false);
+}
+
+/*
+ * Guess the equations that hold for @dst and @src, see bpf_equations_pre_join().
+ * The first join shows what a trip moves. The next walk finds the thresholds.
+ *
+ * It terminates. From the third join around a cycle, only the equations of @dst are kept.
+ * An equation can only get weaker:
+ *	two xregs with one sym -> a sum with a new sym -> a wider sym -> no equation
+ * New equations come from constants, and a constant in @dst gets a range only once.
+ */
+void bpf_guess_equations(struct bpf_verifier_env *env, const struct bpf_verifier_state *dst,
+			 const struct bpf_verifier_state *src, struct bpf_loop *leftover_loop,
+			 bool widen)
+{
+	struct bpf_equation_env *eq_env = env->eq_env;
+	struct equation_join j = { env, { dst, src }, &eq_env->join_state.equations,
+				   leftover_loop, widen, .selector = VAR_NONE };
+	const struct loop_stack_entry *top = bpf_top_loop(dst->frame[dst->curframe]);
+	const struct bpf_xreg_equation *xreg_eq;
+	u32 i, sym_cnt;
+	bool selector_is_trip, both_inputs;
+	int fr;
+
+	j.eqs->xreg_equation_cnt = j.eqs->sym_equation_cnt = j.eqs->sym_cnt = 0;
+	sym_cnt = dst->equations.sym_cnt + src->equations.sym_cnt;
+	if (!bpf_grow_array(env, &eq_env->phi_index, &eq_env->phi_index_cap,
+			    2 * sym_cnt + 1, sizeof(u32)))
+		return;
+	memset(eq_env->phi_index, 0, (2 * sym_cnt + 1) * sizeof(u32));
+	j.sym2phi[0] = eq_env->phi_index;
+	j.sym2phi[1] = eq_env->phi_index + dst->equations.sym_cnt;
+	j.phi_lists = eq_env->phi_index + sym_cnt;
+	eq_env->equation_added = true;
+	for (fr = dst->curframe; fr >= 0; fr--)
+		for (i = dst->frame[fr]->loop_stack_cnt; i--;)
+			join_xreg(&j, bpf_xreg(fr, BPF_XREG_TRIP + i));
+	selector_is_trip = j.selector != VAR_NONE;
+	for (i = 0; i < 2; i++)
+		for_each_xreg_equation(env, &j.st[i]->equations, xreg_eq)
+			join_xreg(&j, xreg_eq->xreg);
+	join_other_xregs(&j, selector_is_trip);
+	both_inputs = !widen || selector_is_trip ||
+		      (top && top->trip_index.grew_once && !top->trip_widened);
+	for (i = 0, sym_cnt = j.eqs->sym_cnt; i <= both_inputs; i++) {
+		join_keep_diffs(&j, i, sym_cnt);
+		join_sym_equations(&j, i);
+	}
+	/* the equations made phis too: i, and i before it was truncated to 32 bits */
+	if (leftover_loop)
+		join_keep_diffs(&j, 0, 0);
+	if (leftover_loop && !widen)
+		join_sum_parts(&j, sym_cnt);
+	for (i = 0, sym_cnt = j.eqs->sym_cnt; j.selector != VAR_NONE && i < sym_cnt; i++)
+		join_bounds_by_selector(&j, VAR_SYM | i, selector_is_trip);
+}
diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
index bd26c6f563e..9f816e2818d 100644
--- a/kernel/bpf/fixups.c
+++ b/kernel/bpf/fixups.c
@@ -754,6 +754,7 @@ static void free_loop(struct bpf_loop *loop)
 	if (!loop)
 		return;
 	kvfree(loop->thresholds);
+	kvfree(loop->iv_thresholds);
 	kvfree(loop);
 }
 
-- 
2.55.0

