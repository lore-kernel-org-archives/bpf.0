Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795160769;
	b=eKlRIxRyDS2IoDEDo2+kaMKDQ+2rFFC90NDrEyeqfKpE826GOYyQ/bTuhzKYhfpro3nl
	 n+wdL5VX0HcCDcaDc2eWBz/CVDnp1HXrjEJ8WKS9VtEkbN7pXxwCQz+11ckjA7fH93K+O
	 pgywIFNbCUP7HoCVtvpLhe77YzuyjRNjLqPIMtNcTs2ivztYPRjvQAqLZo42d/sFuLWBc
	 9DNBNAFpv6Q2JsX+l+M+aJuEYnhKWaa85PJTcy6M0uVc/Y8cfBeG60fXaqQDa2BT1eHrn
	 f6LXcFNurYU3v0Lo2RJnHHPMfplUwvuIponoHjZLe87969oE9HRP8ix2qGUJ2o6abLw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795160769;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=YIWQXVBzlhCZFJW3MzR2zXbHzK0GpI5fgo4jsGlQrMI=;
	b=I6+aKZnN6aOtSY1TNdejjcXuMPkP8hRCwFj1PJs4vpMH+3z4UulLBvVy2vWMmuoHxWuu
	 +ysnOownJmFWNViPmwBGHo93utpGMHfeedyrjSZ/yluTZpZ2YKZ2FIBL1mVj8DSlqUcnS
	 lvvUdcWQgxac65qyo+OIPj367qpt5E58DTQsXOhP7r5L31WI2FIW4jWGzZBBWTyUmA0Fa
	 UP54S3mUB2vwlJCg2ptqVTmxfT3usxH6wDZ4s8Ntuy226dTid5GeJ8h7WZKYocDp1qjSN
	 R85VA9p4TRt5Ro7xn3HEXqNaC/HBAO1b15n2JUUzfLZ3w+FfV+sxshp5MQcQF/uuIxA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=u3nsoMYt;
	arc=none smtp.remote-ip=209.85.215.173
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EEC1606A320
	for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 07:46:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9EEC1606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=u3nsoMYt
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-cde5a7d7849so284127a12.0
        for <bpf@vger.kernel.org>; Thu, 19 Nov 2026 23:46:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795160768; x=1795765568; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YIWQXVBzlhCZFJW3MzR2zXbHzK0GpI5fgo4jsGlQrMI=;
        b=u3nsoMYtV86cuOvs+Makb/0MZizCuv0bqn1Y/Le3lOTIXoEfUayElDw3XtpSKGrm9j
         n73qXn0BbEEvfG6JxicO/U5r3fslXwh+VjFTqYG3fD8ObhcGlPsVpfxSRe+Zty2PpfPy
         xCHjReYo2lPctBkRxopm0kLo9lSSwOXEmAuRQ8wWQbbuENb7klEg3fV4VrUQfjjtnpcz
         tkz8Ll3h2hNNcDuAy8s+yZa1Rybvbei3vIRjGig9q8sBizQxWVovNfRCSRjRityvdYWz
         QRy/OnLNVJqWPP1A6HfS2uzTJ0jNz0wk/sZ+8cG2Y8raoZQWJZj99cPwjk/FOrN+LmKw
         XhAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795160768; x=1795765568;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=YIWQXVBzlhCZFJW3MzR2zXbHzK0GpI5fgo4jsGlQrMI=;
        b=O/mJiz2Tc/r1TUv34IuSl9D1GgeZXfpY8Psq/+Z8UU76uGinVMVcd1382YAqfHWiju
         GSv7UQWeEeXQlKmZETsX1LlLK2P2ik3Xzq/BVUi/hu0mz3QE9F8BQCbDYYSmIhgVNgwe
         Zj358CWQZzHjqUJfJhRlsMzUY05a3YGn+6S7Hbiih/1g1U5CtbUQbEtYN5U2m4cVISoC
         hXSpI4Z/oal7FOY1aBeal6e59oLSMvJ6Q2gfy2bfTlR4/tLCOVuoYFkj/OB8nXVKkZ98
         UDQUrUf0Bhb94avD9mdtfAbr4iz+tlkMedJQJbWVcECd++1ORUCw4EZcdmUG51MSlo8p
         e3LQ==
X-Gm-Message-State: APuU4Z8xBhUsI4O3O8webLbZteTIgMNN9gVMy2au2OeqIqFtyzlX6j2B
	qv+lqF23HGK7D6+7dqCrsPJF3NvOmZtlMdtmanRXPK9kJWiE1zFWa6EN3JASPw==
X-Gm-Gg: AZFdTZf3dq59Emb60XpUgId65Bk8+DR7nzb6wzUAwq3mDQwrgUZFDiEONQZbakl8+Nc
	hueQa6yHcPYXBS/AEivOVeky2SiTvHtqgmdCCSmYsl5uXMJyM1+ifWCAqpI3Y7Tq8s+gYW3Hsxd
	qiw50pYJeyUtINJy3jOpBMJdTaAN2gEbNmrfq5f9LzhM62oksKyYx3C/+T1hN+NYJqlf9zw0+W3
	kV8KuGQpj2KfsyHFRRFbMQUPIL6nBgtK7lTVLRcD/ncEJ1LXBk+n+VTOjUk0qM1PfSqRzrEhZLQ
	SwcemBIhipXxrsGKympuGPgxL+zdl1FRKIHQsvTQBYr50uGxOeQa4l707M0WM8dJ0eBGocD9Q6m
	uKpeyIolZ92+vBIFVdKb6cHkgPjAEEZjP3vgJQlX/GYyU/WOHc0ncaWvzK4NgJs5w4hS085s39B
	qy9pw1Rkp8A2W6MDu+l13B9b1wMK0IrrUmitkZUbXqvWy1bbqXoniN4zA7UQ5q0y6C1flVJuH5s
	758m2mAYm1S1KgwH1mNkzRDGF7QivrFV92AhZ0t/A0odvYAOtiYjhntmXp+X8Xm9+pbpJx/QD6r
	JfLE1QuAmUBEMM+wP2OM9JePRy/+UCu8RZcHTp/frnUpYS5oqKgoi/pxvVShZuFVbM9VzXXcXjl
	th6QLpvkv9JjFFW6SEbU43YzIrE1Jf+GFnJD/lXCH1ZylxlESOcR9YD/QmZWbxYSsTk8fSelLdC
	c=
X-Received: by 2002:a17:90b:5543:b0:3a7:250:333e with SMTP id 98e67ed59e1d1-3b41c8dd197mr1864281a91.11.1795160767532;
        Thu, 19 Nov 2026 23:46:07 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.243])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b40f4312dfsm4835865a91.3.2026.11.19.23.46.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 23:46:07 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next 16/49] bpf: Add equations and their arithmetic
Date: Fri, 20 Nov 2026 07:41:48 +0000
Message-ID: <20261120074430.2704488-17-alexei.starovoitov@gmail.com>
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

A state has a range for each xreg. It does not have the relation of two
xregs:

  r2 = r1
  r2 <<= 2
  if r1 > 7 goto out      r2 is 0..28, but nothing says so

An equation relates two or three numbers. A sym is a number that the
program had or could have had. There are three kinds:

  xreg = coef * sym + off                       r2 = 4 * sym0 + 8
  sym  = coef * sym + coef * sym + off    sum   sym2 = sym0 + sym1
  sym  = what an insn makes of two exprs  op    sym3 = sym2 & 0xf8

All equations hold mod 2^64, as the registers do. Add the types and
the arithmetic on ranges that the next patches use:

  scalar_scale()          sym0 = 0..7          ->  4 * sym0 = 0..28
  refine_from_product()   4 * sym0 = 8..20     ->  sym0 = 2..5
  bpf_expr_div_exact()    (4 * sym0 + 8) / 4   ->  sym0 + 2
  bpf_find_next_diff()    sym2 - sym0          ->  sym1

If the product can wrap, the range tells nothing. A power of two still
tells the low bits. If a range becomes empty, the equations cannot
hold: the state is infeasible.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/bpf_verifier.h |  14 +++
 kernel/bpf/Makefile          |   1 +
 kernel/bpf/equation.c        | 232 +++++++++++++++++++++++++++++++++++
 kernel/bpf/equation.h        | 112 +++++++++++++++++
 kernel/bpf/states.c          |   8 +-
 kernel/bpf/verifier.c        |   2 +-
 6 files changed, 366 insertions(+), 3 deletions(-)
 create mode 100644 kernel/bpf/equation.c
 create mode 100644 kernel/bpf/equation.h

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 77f1fe969a2..4d9cddb3588 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -535,6 +535,18 @@ struct bpf_func_state {
 #define BPF_ID_MAP_SIZE ((MAX_BPF_REG + MAX_BPF_STACK_SLOTS + MAX_STACK_ARG_SLOTS) * \
 			 MAX_CALL_FRAMES)
 
+/* See equation.c */
+struct bpf_equations {
+	struct bpf_xreg_equation *xreg_equations;	/* the three tables are one allocation */
+	struct bpf_sym_equation *sym_equations;
+	struct scalar *syms;
+	u32 xreg_equation_cnt, sym_equation_cnt, sym_cnt;
+	u32 xreg_equation_cap, sym_equation_cap, sym_cap;
+	bool normalized;	/* see normalize_equations() */
+	bool infeasible;	/* the equations cannot hold: the program does not get here */
+	bool needs_refine;	/* widened: the equations are not applied, see bpf_flow_next() */
+};
+
 struct bpf_verifier_state {
 	/* call stack tracking */
 	struct bpf_func_state *frame[MAX_CALL_FRAMES];
@@ -2289,6 +2301,8 @@ int bpf_compute_loops(struct bpf_verifier_env *env);
 int bpf_loop_at_index(struct bpf_verifier_env *env, u32 idx);
 bool bpf_is_nested_loop(struct bpf_verifier_env *env, int inner_header, int outer_header);
 
+void scalar_bounds_sync(struct scalar *s);
+bool scalar_subsumes(const struct scalar *old, const struct scalar *cur);
 
 /* How many bytes are checked from the start of the packet, wherever the pointer is */
 static inline int pkt_min_len(const struct bpf_reg_state *reg)
diff --git a/kernel/bpf/Makefile b/kernel/bpf/Makefile
index 4e5bb513a8a..d1f9ce7cc0c 100644
--- a/kernel/bpf/Makefile
+++ b/kernel/bpf/Makefile
@@ -12,6 +12,7 @@ obj-$(CONFIG_BPF_SYSCALL) += hashtab.o arraymap.o percpu_freelist.o bpf_lru_list
 obj-$(CONFIG_BPF_SYSCALL) += local_storage.o queue_stack_maps.o ringbuf.o bpf_insn_array.o
 obj-$(CONFIG_BPF_SYSCALL) += bpf_local_storage.o bpf_task_storage.o
 obj-$(CONFIG_BPF_SYSCALL) += fixups.o cfg.o states.o check_btf.o flow.o join.o
+obj-$(CONFIG_BPF_SYSCALL) += equation.o equation_join.o
 obj-${CONFIG_BPF_LSM}	  += bpf_inode_storage.o
 obj-$(CONFIG_BPF_SYSCALL) += disasm.o mprog.o
 obj-$(CONFIG_BPF_JIT) += trampoline.o
diff --git a/kernel/bpf/equation.c b/kernel/bpf/equation.c
new file mode 100644
index 00000000000..d49c01fa057
--- /dev/null
+++ b/kernel/bpf/equation.c
@@ -0,0 +1,232 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Each state has a table of equations. An equation relates two or three numbers.
+ *
+ *	xreg = coef * sym + off				r2 = 4 * sym0 + 8
+ *	sym  = coef * sym + coef * sym + off	(sum)	sym2 = sym0 + sym1
+ *	sym  = what an insn makes of two exprs	(op)	sym3 = (sym2 + 7) & 0xf8
+ *
+ * An xreg is a register, a stack slot or the trip index of a loop. The number in a pointer is
+ * its offset. A sym is a number that the program had or could have had. The state says: there
+ * are numbers for the syms, in their ranges, for which all equations hold (mod 2^64).
+ *
+ *	insn	deletes the equation of the xreg that it writes, the result gets a new equation
+ *	jump	refines an xreg -> its sym -> the other syms -> their xregs
+ *	join	guesses the equations, see equation_join.c
+ *	prune	checks them, see check_equations()
+ */
+#include <linux/bpf.h>
+#include <linux/cnum.h>
+#include <linux/filter.h>
+#include <linux/sizes.h>
+#include <linux/slab.h>
+#include <linux/tnum.h>
+#include "equation.h"
+
+static u64 low_bits(u32 bits)
+{
+	return bits ? GENMASK_ULL(bits - 1, 0) : 0;
+}
+
+/* Arithmetic */
+
+static bool scalar_is_unknown(const struct scalar *s)
+{
+	return s->r64.size == U64_MAX && s->r32.size == U32_MAX && tnum_is_unknown(s->var_off) &&
+	       s->step == 1;
+}
+
+static void scalar_scale(struct scalar *dst, const struct scalar *src, s64 coef)
+{
+	struct cnum64 r64 = src->r64;
+	struct cnum32 r32 = src->r32;
+	s32 coef32 = coef;
+	u64 size;
+
+	if (coef == 1) {
+		*dst = *src;
+		return;
+	}
+	if ((coef & 1) && scalar_is_unknown(src))
+		return scalar_set_unknown(dst);
+	*dst = *src;
+	scalar_step_scale(dst, coef);
+	dst->r64 = CNUM64_UNBOUNDED;
+	dst->r32 = CNUM32_UNBOUNDED;
+	if (!check_mul_overflow(abs64(coef), r64.size, &size) && size != U64_MAX)
+		dst->r64 = (struct cnum64){ coef * (r64.base + (coef < 0 ? r64.size : 0)), size };
+	size = abs64(coef32) * r32.size;
+	if (size < U32_MAX)
+		dst->r32 = (struct cnum32){ coef32 * (r32.base + (coef32 < 0 ? r32.size : 0)),
+					    size };
+	dst->var_off = tnum_mul(tnum_const(abs64(coef)), dst->var_off);
+	if (coef < 0)
+		dst->var_off = tnum_neg(dst->var_off);
+}
+
+/* @dst = @a + @coef * @b. It is not reduced, see scalar_add(). */
+static void scalar_add_scaled(struct scalar *dst, const struct scalar *a,
+			      const struct scalar *b, s64 coef)
+{
+	struct scalar tmp;
+
+	if (scalar_is_unknown(a) || ((coef & 1) && scalar_is_unknown(b)))
+		return scalar_set_unknown(dst);
+	scalar_scale(&tmp, b, coef);
+	scalar_add(dst, a, &tmp);
+}
+
+static void scalar_add_const(struct scalar *dst, u64 off)
+{
+	struct scalar tmp;
+
+	if (!off || scalar_is_unknown(dst))
+		return;
+	scalar_set_const(&tmp, off);
+	scalar_add(dst, dst, &tmp);
+}
+
+static void scalar_set_below(struct scalar *dst, u64 end)
+{
+	scalar_set_unknown(dst);
+	dst->r64 = cnum64_from_urange(0, end - 1);
+	scalar_bounds_sync(dst);
+}
+
+/* The ends of the ranges have the low bits that are known. False: there is no such number. */
+static bool scalar_align_bounds(struct scalar *s)
+{
+	u64 low = (s->var_off.mask & -s->var_off.mask) - 1;
+	u64 up = (s->var_off.value - s->r64.base) & low;
+	u64 down = (s->r64.base + s->r64.size - s->var_off.value) & low;
+	u32 up32 = (s->var_off.value - s->r32.base) & low;
+	u32 down32 = (s->r32.base + s->r32.size - s->var_off.value) & low;
+
+	if (up > s->r64.size || down > s->r64.size - up ||
+	    up32 > s->r32.size || down32 > s->r32.size - up32)
+		return false;
+	if (!up && !down && !up32 && !down32)
+		return true;
+	s->r64 = (struct cnum64){ s->r64.base + up, s->r64.size - up - down };
+	s->r32 = (struct cnum32){ s->r32.base + up32, s->r32.size - up32 - down32 };
+	return scalar_intersect(s, s, 64);
+}
+
+/* The number is in @s and in @bounds. Returns true if @s got smaller. */
+static bool refine_bounds(struct bpf_equations *eqs, struct scalar *s, const struct scalar *bounds)
+{
+	struct scalar new;
+
+	if (scalar_subsumes(bounds, s))
+		return false;
+	new = *s;
+	if (!scalar_intersect(&new, bounds, 64) || !scalar_align_bounds(&new)) {
+		eqs->infeasible = true;
+		return false;
+	}
+	if (scalar_equal(s, &new))
+		return false;
+	*s = new;
+	eqs->normalized = false;
+	return true;
+}
+
+/* @coef * (the number in @s) is in @bounds */
+static bool refine_from_product(struct bpf_equations *eqs, struct scalar *s, s64 coef,
+				const struct scalar *bounds)
+{
+	u64 span, lo, hi, step = abs64(coef);
+	struct scalar new;
+	struct tnum bits;
+
+	if (is_plus_minus_one(coef)) {
+		scalar_scale(&new, bounds, coef);
+		return refine_bounds(eqs, s, &new);
+	}
+	/* the products are on an arc of @span + 1 numbers. [lo, hi] is @bounds from its start */
+	if (check_mul_overflow(step, s->r64.size, &span) || bounds->r64.size == U64_MAX) {
+		if (hweight64(step) != 1)
+			return false;
+		/* a shift to the left: the bits that stay are known */
+		bits = tnum_rshift(coef < 0 ? tnum_neg(bounds->var_off) : bounds->var_off,
+				   ilog2(step));
+		scalar_set_unknown(&new);
+		new.var_off = (struct tnum){ bits.value, bits.mask | ~(U64_MAX >> ilog2(step)) };
+		return refine_bounds(eqs, s, &new);
+	}
+	lo = bounds->r64.base - coef * (s->r64.base + (coef < 0 ? s->r64.size : 0));
+	hi = lo + bounds->r64.size;
+	if (hi < lo && lo <= span)
+		return false;
+	lo = hi < lo || !lo ? 0 : div64_u64(lo - 1, step) + 1;
+	hi = div64_u64(min(hi, span), step);
+	if (lo > hi) {
+		eqs->infeasible = true;
+		return false;
+	}
+	scalar_set_unknown(&new);
+	new.r64.base = s->r64.base + (coef > 0 ? lo : s->r64.size - hi);
+	new.r64.size = hi - lo;
+	return new.r64.size != U64_MAX && refine_bounds(eqs, s, &new);
+}
+
+/* @expr = (@expr - @off) / @coef. False if the result is not an expr. */
+bool bpf_expr_div_exact(struct expr *expr, u64 off, s64 coef)
+{
+	struct expr quot;
+
+	if (!coef)
+		return false;
+	if (is_plus_minus_one(coef))
+		quot = make_expr(expr->coef * coef, expr->var, (expr->off - off) * coef);
+	else
+		quot = make_expr(div64_s64(expr->coef, coef), expr->var,
+				 div64_s64(expr->off - off, coef));
+	if (quot.coef * coef != expr->coef || quot.off * coef != expr->off - off)
+		return false;
+	*expr = quot;
+	return true;
+}
+
+/*
+ * @a - @b as an expr. There can be more than one. False: no more.
+ * The search goes around the table once, from the equation that @pos starts with.
+ */
+bool bpf_find_next_diff(struct bpf_verifier_env *env, const struct bpf_equations *eqs,
+			const struct expr *a, const struct expr *b, struct equation_pos *pos,
+			struct expr *diff)
+{
+	const struct bpf_sym_equation *sym_eq;
+	u32 seen_cnt = pos->seen_cnt;
+	struct expr factor;
+	int i, j;
+
+	if (!a->coef || !b->coef || a->var == b->var) {
+		*diff = make_expr(a->coef - b->coef, a->coef ? a->var : b->var, a->off - b->off);
+		return !pos->seen_cnt++;
+	}
+	if (!var_is_sym(a->var) || !var_is_sym(b->var) || over_limit(env))
+		return false;
+	while (pos->seen_cnt < eqs->sym_equation_cnt) {
+		pos->next = pos->next < eqs->sym_equation_cnt ? pos->next : 0;
+		sym_eq = eqs->sym_equations + pos->next++;
+		pos->seen_cnt++;
+		i = find_sym_pos(sym_eq, var_symno(a->var));
+		j = i < 3 ? find_sym_pos(sym_eq, var_symno(b->var)) : 3;
+		if (j == 3 || is_op(sym_eq))
+			continue;
+		factor = make_expr(0, 0, is_plus_minus_one(sym_eq->coef[j]) ? -b->coef : a->coef);
+		if (!bpf_expr_div_exact(&factor, 0,
+					sym_eq->coef[is_plus_minus_one(sym_eq->coef[j]) ? j :
+						       i]) ||
+		    factor.off * sym_eq->coef[i] != a->coef ||
+		    factor.off * sym_eq->coef[j] != -b->coef)
+			continue;
+		*diff = sym_expr(-factor.off * sym_eq->coef[3 - i - j], sym_eq->sym[3 - i - j],
+				 a->off - b->off - factor.off * sym_eq->off);
+		bpf_add_cost(env, pos->seen_cnt - seen_cnt, BPF_COST_SCAN);
+		return true;
+	}
+	bpf_add_cost(env, pos->seen_cnt - seen_cnt, BPF_COST_SCAN);
+	return false;
+}
diff --git a/kernel/bpf/equation.h b/kernel/bpf/equation.h
new file mode 100644
index 00000000000..cb7132739a3
--- /dev/null
+++ b/kernel/bpf/equation.h
@@ -0,0 +1,112 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef __BPF_EQUATION_H
+#define __BPF_EQUATION_H
+
+#include <linux/bpf_verifier.h>
+
+/* A var is an xreg, see bpf_xreg(), or a sym */
+#define VAR_SYM		BIT_ULL(63)
+#define VAR_NONE	U64_MAX
+#define NO_SYM		U32_MAX
+
+/* coef * var + off. A constant has no var and coef == 0. */
+struct expr {
+	s64 coef;
+	u64 off;
+	u64 var;
+};
+
+/* xreg = coef * sym + off. The table is sorted by xreg. */
+struct bpf_xreg_equation {
+	u64 xreg;
+	s64 coef;
+	u64 off;
+	u32 sym;
+	bool is_ptr;		/* the number is the offset of a pointer */
+};
+
+/*
+ * A sum: 0 = coef[0] * sym[0] + coef[1] * sym[1] + coef[2] * sym[2] + off, coef[0] is -1.
+ * An op: sym[0] is what @insn_idx makes of the operands, see rhs_expr(). coef[0] is 1.
+ */
+struct bpf_sym_equation {
+	s64 coef[3];
+	u32 sym[3];
+	s32 insn_idx;		/* that made the equation, -1 for a sum of a join */
+	u64 off, off_src;
+};
+
+/* See bpf_find_next_diff() */
+struct equation_pos {
+	u32 next, seen_cnt;
+};
+
+/* The pass is over its budget. It finds no more equations, a scan in a loop does not start. */
+static inline bool over_limit(struct bpf_verifier_env *env)
+{
+	return env->over_limit || bpf_check_limits(env);
+}
+
+static inline bool var_is_sym(u64 var)
+{
+	return var != VAR_NONE && (var & VAR_SYM);
+}
+
+static inline u32 var_symno(u64 var)
+{
+	return var;
+}
+
+static inline u64 abs64(s64 x)
+{
+	return x < 0 ? -(u64)x : x;
+}
+
+static inline bool is_plus_minus_one(s64 coef)
+{
+	return coef == 1 || coef == -1;
+}
+
+static inline struct expr make_expr(s64 coef, u64 var, u64 off)
+{
+	return (struct expr){ coef, off, coef ? var : VAR_NONE };
+}
+
+static inline struct expr sym_expr(s64 coef, u32 sym, u64 off)
+{
+	return make_expr(coef, VAR_SYM | sym, off);
+}
+
+static inline struct expr expr_scale(struct expr expr, s64 coef, u64 off)
+{
+	return make_expr(expr.coef * coef, expr.var, expr.off * coef + off);
+}
+
+static inline bool expr_equal(const struct expr *a, const struct expr *b)
+{
+	return a->coef == b->coef && a->off == b->off && a->var == b->var;
+}
+
+/* Operand @i on the right side */
+static inline struct expr rhs_expr(const struct bpf_sym_equation *sym_eq, int i)
+{
+	return sym_expr(sym_eq->coef[i + 1], sym_eq->sym[i + 1], i ? sym_eq->off_src : sym_eq->off);
+}
+
+static inline bool is_op(const struct bpf_sym_equation *sym_eq)
+{
+	return sym_eq->coef[0] == 1;
+}
+
+/* The position of @sym in @sym_eq. 3 if it is not there. */
+static inline int find_sym_pos(const struct bpf_sym_equation *sym_eq, u32 sym)
+{
+	return sym_eq->sym[0] == sym ? 0 : sym_eq->sym[1] == sym ? 1 :
+	       sym_eq->sym[2] == sym ? 2 : 3;
+}
+
+bool bpf_expr_div_exact(struct expr *expr, u64 off, s64 coef);
+bool bpf_find_next_diff(struct bpf_verifier_env *env, const struct bpf_equations *eqs,
+			const struct expr *a, const struct expr *b, struct equation_pos *pos,
+			struct expr *diff);
+#endif
diff --git a/kernel/bpf/states.c b/kernel/bpf/states.c
index 1e264757be4..df1866c2b55 100644
--- a/kernel/bpf/states.c
+++ b/kernel/bpf/states.c
@@ -6,8 +6,7 @@
 #include <linux/filter.h>
 
 /* check %cur's range satisfies %old's */
-static bool range_within(const struct bpf_reg_state *old,
-			 const struct bpf_reg_state *cur)
+static bool range_within(const struct scalar *old, const struct scalar *cur)
 {
 	if (!cnum64_is_subset(old->r64, cur->r64) ||
 	    !cnum32_is_subset(old->r32, cur->r32))
@@ -35,6 +34,11 @@ static bool range_within(const struct bpf_reg_state *old,
 	       (cur->base - old->base) % old->step == 0;
 }
 
+bool scalar_subsumes(const struct scalar *old, const struct scalar *cur)
+{
+	return range_within(old, cur) && tnum_in(old->var_off, cur->var_off);
+}
+
 static void renumber_id(struct bpf_verifier_env *env, u32 *id, u32 new_id)
 {
 	struct bpf_idmap *map = &env->idmap_scratch;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index e4c9ced59b2..49e98667b60 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -2318,7 +2318,7 @@ static void __update_bounds_from_step(struct scalar *s)
 
 static bool range_bounds_violation(const struct scalar *s);
 
-static void scalar_bounds_sync(struct scalar *s)
+void scalar_bounds_sync(struct scalar *s)
 {
 	/* If the input reg_state is invalid, we can exit early */
 	if (range_bounds_violation(s))
-- 
2.55.0

