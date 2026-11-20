Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795208042;
	b=RSez1LSVX58Q0mylxUum8U3uW/mSH0iXSf+kzzr0n8pWFSwT4NUww9jhhh2zTsNqIfwi
	 ZWBIW7thsHSl1qllxWchE2xQNHfDFIHUxQw91+yCI+wby2rOSZTQfSxBxmkXU6qjgj1oU
	 idnnbgQybZ/yCHwJrYEiUP9iObefuiNv/aqCONVNAN3vKbTN3FAJFRlJtmeGHI4C9xwND
	 x6KI8aVIecHEF0QrasrURgEyhv37rf6HtzHXtlvat1e4mz+GSOLG+dL5VYvjrtGKWiiSj
	 RHjU1kqFAlXQNG7DDr1YjlIVvxUTHYJNVlLFXUT2kSWA0quBjw8IaKxAyQ5K6OSOjJg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795208042;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Ce9TgQAajSgPw0T/9gAl0Q4Msn3WctV8Fj36Akvk01U=;
	b=JB02U0Y2kwb97ZiEXHTWlOeWm0eWQWU92xDav/CYsYVLr8JaACUVzrc0Zr68/xW2tco9
	 0ECkTi+EjGv1pbtjAOM6HQnfAkkVBrUn1xcz+A2XHxXMDfBY0Tsd3ON/DYWL9yoQ6bvqR
	 iQznU5ZXoKh0Mzn+VjUPoHv3+3fZSj3ZbVqCP2H+aBwVfJJPOtR0vdoOqbSo0NuwGob/0
	 MDuFNuUmjMPKLZtT2+vG3+iEu+esyTiXOa5WqpTkcLEqYQyxKT4Qatmh+P9rKO3P+PWvb
	 tnXNUKbrrcLTpAux3dEN5rOmIxrvBX3BGdt6FRQ9wbFBIMQGQt/kZbsSNuimlxId/JA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SPBMtzRX;
	arc=none smtp.remote-ip=209.85.215.177
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 117CD606A332
	for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 20:53:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 117CD606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SPBMtzRX
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-cdb2dfcca94so590111a12.1
        for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 12:53:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795208039; x=1795812839; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ce9TgQAajSgPw0T/9gAl0Q4Msn3WctV8Fj36Akvk01U=;
        b=SPBMtzRX4vBYHsXb8qf/rwxzXnGSoRHMt3cHucsLEZkYZ/9gf7ghGm732zMvnGQWTC
         vRx1RVvx6t4clwd5OXrLmAmSvpqo8Nol3l3/7JFBjdMnKEy/++N2Nl/0tdiR3xNAlN5h
         bsTti1TyoAjUgbgIc2kJil2PfqsBAL1S7m0Xkuy4Szkj819AQ+xxUgd+ojSQbZeCaR67
         hpmuorUyBex0r2GxlOrI/UaHnEnSpkxTnx+gOi2TA6p1qE+UgfvZQkevsroa06dMb0kL
         vjMaPJ34LZNRLv7DXspq3n/kBGYRL7yOa0ot3xJRrDlyPOODvjef890SnJI0e7pLw4it
         Mdfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795208039; x=1795812839;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Ce9TgQAajSgPw0T/9gAl0Q4Msn3WctV8Fj36Akvk01U=;
        b=UrLqjRK+dLOyAOZ7NlgtA7ww6kbIe5lOiD9wvu/AKa+ZVi9+of+pe/MnqqNTe8rvZG
         tYONrvMXGzT9+Ym/mBauNvbWlc/Q3M48BJXp2k4LsUIc/ppNct64tjjcIJCaIxhvnS8E
         i1pIda20dA8iGAuIDaQMI/n+/w55MYl+3/8Imvu6ivL957Mr0mCA9NXPQs7+KPn29GdQ
         lSjZxgTkzfSJkNuplay84TqWPSxYvc5Cu34l93w/9cJQDKQBuu+LN+WK+egHLwM1As8s
         4X3bAyOj9Cy08wlqHMMtr9QBP/5xyWMDX7SHbQk+lc6vksggapLtBTX5C8ySjRPMv1Ts
         +Csg==
X-Gm-Message-State: APuU4Z/LzgTILfKdNIQOkbJ4yq7SeGk/ZH8hYKQWDSdPrzpz4bYulXh8
	Q+m65NxyVYKJhdAzcNF3svFBlOMI18TWiOLcSniLeVPf7tKCC/5PbsCB83/kQw==
X-Gm-Gg: AZFdTZfINIVDwrf9eUAZtACtfVR0+zxP/d8jurJq0WunxazsNTH1tlwThM26YlgMf1e
	rHhTmbxb3ITvn3pIW2w/1sm7szjC4zl4zdXGbMZTPfsUy6gwimAJhU4ZS/ndev3BHTRAoBe3qQG
	ZDRDNN6ATbgVOl6CF4lZ1qKPoHAQPIyKCGamwodxAOVnpq+4i32OKnw4aSPNs5HBpTpFRgHNteO
	9/n0f2cAevNT2s1zTgouJ+Yqww77oxuiXaTqblPJC/TJ6Ok8iJYRfeYHfw8sfSR7+t8GrGAAuHl
	zJZaiyLAAfZeRQTPTYce9UZOFEVjGk8gVkmrlmxAhexo4bPkbvYolB1EqRDsQVNXiV/0lfsSur0
	GxgeMdY9YiRBbNnV7jEZHhesj2vEQGSgvbas8jda9fLETpE45rA6PI3eM6e9Pk+bAkqBUQfp+xC
	R1MW5k8R03lp+vFy+17EM07iQWjZIv4WhOTJRKH94UKjzCCeN/ncD0KpYxpVURr8lSPu/86Do+r
	zoy7gwAFjiLJQeCeseAzqO3tNOLS1ym/x2XZTGw/+VuJ3Oj4E8rzbhc4uGoEGhjckb87ezxlfMl
	+wkfCiKYQidCTTuzB+3Ahnkl7Ni6JEmN6Qfa0svZKaKA/er5q47THiekpxCyNu3UXroNBG5oZ6N
	BhaErNQWVjoARqxR5fnGFdrvYn5hTqOGCFG/MaG1kIhuCmGBYSrA4U2REhEb8h64KMa2JUj+DEQ
	==
X-Received: by 2002:a17:90b:1a90:b0:3b0:9941:8d42 with SMTP id 98e67ed59e1d1-3b41c92a1c0mr3857994a91.33.1795208039089;
        Fri, 20 Nov 2026 12:53:59 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.240])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b41ad0b2c4sm5500238a91.4.2026.11.20.12.53.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 12:53:58 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next v2 40/49] bpf: Check the body of a counted loop once
Date: Fri, 20 Nov 2026 20:49:48 +0000
Message-ID: <20261120204959.614908-41-alexei.starovoitov@gmail.com>
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

The leftover needs three walks over the body. Two walks only collect
what the third walk needs:

  walk 1   i = 0          shows the step, 150
  walk 2   i = 0, 150     shows the threshold, k <= 3
  walk 3   i = 150 * k    is the proof

Often the code shows the step and the bound. The spine is the insns
that each trip runs once. find_steps() follows the xregs along it:

  header -> a -> b -> ... -> back edge    on the spine:  x += constant
             `-> c -'                     off the spine: x is inexact

bpf_guess_first_trips() makes the states that trips 1 and 2 possibly
give, and joins them with the state that enters. So walk 3 is first.

It is a guess. The state only grows, and the state that comes back is
compared with it as before. The guess is not used if
- a carried xreg is a sum, or the last value of an iv, and its start
  is known: only two walks show its equation,
- 'i != n' has a range, see add_distance_equation(),
- a partition needs an xreg that the loop changes,
- a state had no trip count for the loop.

A wrong guess can cost the trip count. Then the loop gets may_goto. It
can also move a register that const_fold.c knows as a constant. So
do_check_block() does not compare the two after env->extra_values is
set.

                       insns processed
  program              bpf-next   without   with this patch
  pyperf600            37285      109729    37284
  pyperf180            22165      43304     22164
  pyperf600_nounroll   1289       1758      1288

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/bpf_verifier.h |   6 +
 kernel/bpf/equation_join.c   | 409 +++++++++++++++++++++++++++++++++++
 kernel/bpf/fixups.c          |   1 +
 kernel/bpf/flow.c            |   6 +
 kernel/bpf/precision.c       |  15 ++
 5 files changed, 437 insertions(+)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 47939e49908..df4a46cfa04 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -897,6 +897,8 @@ struct bpf_loop {
 	bool was_infinite;	/* at the start of the last path-sensitive run */
 	bool infinite;		/* see failing_path_trip() */
 	bool infinite_is_guess;	/* see fast_forward_trips() */
+	bool no_first_trips_guess;	/* a state had no trip count, @steps can be wrong */
+	struct bpf_loop_steps *steps;	/* see bpf_guess_first_trips() */
 	struct bpf_iv_threshold *iv_thresholds;	/* where an iv can stop, see equation_join.c */
 	u32 iv_threshold_cnt, iv_threshold_cap;
 	u32 leftover_epoch;	/* how many leftovers started */
@@ -1739,6 +1741,8 @@ void bpf_range_of_data_dep(struct bpf_verifier_env *env, const struct bpf_verifi
 			   u32 *first, u32 *last);
 bool bpf_call_needs_frames(struct bpf_verifier_env *env, const struct bpf_verifier_state *st,
 			   u16 args);
+bool bpf_xregs_are_partitioned(struct bpf_verifier_env *env, const struct bpf_verifier_state *st,
+			       u32 fr, const unsigned long *xregs);
 bool bpf_xreg_in_data_deps(struct bpf_verifier_env *env, const struct bpf_verifier_state *st,
 			   u32 fr, u32 xregno);
 bool bpf_xreg_in_deps(struct bpf_verifier_env *env, const struct bpf_verifier_state *st,
@@ -2548,6 +2552,8 @@ bool bpf_equations_join_forgets(struct bpf_verifier_env *env, const struct bpf_v
 u32 bpf_equations_hash(struct bpf_verifier_env *env, const struct bpf_verifier_state *st, u32 fr,
 		       const unsigned long *xregs, u32 bits);
 void bpf_collect_iv_thresholds(struct bpf_verifier_env *env);
+int bpf_guess_first_trips(struct bpf_verifier_env *env, struct bpf_verifier_state *st,
+			  struct bpf_loop *loop);
 bool bpf_steps_are_constant(struct bpf_verifier_env *env, const struct loop_stack_entry *entry,
 			    const unsigned long *iv_xregs, bool infinite);
 void bpf_fast_forward_xregs(struct bpf_verifier_env *env, const struct bpf_verifier_state *old,
diff --git a/kernel/bpf/equation_join.c b/kernel/bpf/equation_join.c
index 47db8f8ae2b..a01f0fdc746 100644
--- a/kernel/bpf/equation_join.c
+++ b/kernel/bpf/equation_join.c
@@ -1047,3 +1047,412 @@ void bpf_collect_iv_thresholds(struct bpf_verifier_env *env)
 			e->exit_threshold = min(e->exit_threshold, start + cnt);
 	}
 }
+
+/* Steps */
+
+#define ORIGIN_CONST	(U16_MAX - 1)
+#define ORIGIN_NONE	U16_MAX
+
+/* The value that @xregno has at the header, plus @off */
+struct origin {
+	s64 off, step;
+	u16 xregno;
+	bool exact;	/* on all paths */
+	bool changed;	/* by more than a constant, or not on all paths */
+	bool shifted;	/* by 32 bits, to truncate */
+	bool low32;	/* the high bits are 0, or */
+	bool sext;	/* copies of the sign */
+};
+
+struct bpf_loop_steps {
+	DECLARE_BITMAP(changed_xregs, MAX_BPF_XREG);
+	DECLARE_BITMAP(nonlinear_xregs, MAX_BPF_XREG);
+	DECLARE_BITMAP(sum_xregs, MAX_BPF_XREG);	/* sums, and the last values of ivs */
+	u32 jump_cnt, cnt;
+	/* the operands of the jumps that leave the loop, then the xregs that move */
+	struct {
+		u32 insn_idx;
+		struct origin op[2];
+	} at[];
+};
+
+struct scan {
+	struct bpf_verifier_env *env;
+	struct bpf_loop_steps *steps;
+	struct origin xregs[MAX_BPF_XREG];
+	struct origin before[MAX_BPF_XREG];	/* the writes off the spine */
+	DECLARE_BITMAP(written, MAX_BPF_XREG);
+	bool on_spine;
+};
+
+static const struct origin no_origin = { .xregno = ORIGIN_NONE };
+
+static struct origin const_origin(s64 value)
+{
+	return (struct origin){ .off = value, .xregno = ORIGIN_CONST, .exact = true };
+}
+
+static u64 extend_low32(u64 x, bool sext)
+{
+	return sext ? (s64)(s32)x : (u32)x;
+}
+
+static struct origin truncate_origin(struct origin x, bool sext)
+{
+	x.low32 = x.xregno != ORIGIN_CONST;
+	x.sext = sext;
+	if (!x.low32)
+		x.off = extend_low32(x.off, sext);
+	return x;
+}
+
+/* The result of an insn has the origin that changes most */
+static int origin_rank(const struct scan *scan, const struct origin *x)
+{
+	return x->xregno >= ORIGIN_CONST ? 0 : 1 + test_bit(x->xregno, scan->steps->changed_xregs);
+}
+
+static struct origin alu_origin(const struct scan *scan, const struct bpf_insn *insn)
+{
+	struct origin dst = scan->xregs[insn->dst_reg], src = const_origin(insn->imm);
+	u8 op = BPF_OP(insn->code);
+
+	if (BPF_SRC(insn->code) == BPF_X)
+		src = scan->xregs[insn->src_reg];
+	if (op == BPF_MOV && (!insn->off || insn->off == 32))
+		return insn->off ? truncate_origin(src, true) : src;
+	if (op == BPF_MOV)
+		dst = no_origin;
+	if (src.xregno == ORIGIN_CONST && src.off == 32 && BPF_CLASS(insn->code) == BPF_ALU64 &&
+	    (dst.shifted ? op == BPF_RSH || op == BPF_ARSH : op == BPF_LSH)) {
+		dst.shifted = !dst.shifted;
+		return dst.shifted ? dst : truncate_origin(dst, op == BPF_ARSH);
+	}
+	if (origin_rank(scan, &dst) < origin_rank(scan, &src)) {
+		swap(dst, src);
+		dst.exact &= op == BPF_ADD;
+	}
+	dst.off += op == BPF_ADD ? src.off : -src.off;
+	dst.exact &= (op == BPF_ADD || op == BPF_SUB) && !dst.shifted && !src.shifted &&
+		     src.xregno == ORIGIN_CONST && src.exact;
+	dst.changed |= !dst.exact;
+	return dst.xregno < ORIGIN_CONST || dst.exact ? dst : no_origin;
+}
+
+static void write_origin(struct scan *scan, u32 xregno, struct origin value)
+{
+	struct origin *before = &scan->before[xregno];
+
+	bpf_add_cost(scan->env, 1, BPF_COST_COPY);
+	if (!scan->on_spine && !__test_and_set_bit(xregno, scan->written))
+		*before = scan->xregs[xregno];
+	before->changed |= value.xregno == before->xregno &&
+			   (value.changed || value.off != before->off);
+	scan->xregs[xregno] = value;
+}
+
+/* Paths meet. Some of them went around the writes. */
+static void merge_origins(struct scan *scan)
+{
+	struct origin *old, *new;
+	u32 i;
+
+	for_each_set_bit(i, scan->written, MAX_BPF_XREG) {
+		bpf_add_cost(scan->env, 1, BPF_COST_COPY);
+		old = &scan->before[i];
+		new = &scan->xregs[i];
+		if (old->xregno == new->xregno && old->off == new->off && old->exact &&
+		    new->exact && old->shifted == new->shifted)
+			continue;
+		new->xregno = new->xregno < ORIGIN_CONST ? new->xregno : old->xregno;
+		new->changed |= old->changed;
+		new->exact = false;
+	}
+	if (scan->on_spine)
+		bitmap_zero(scan->written, MAX_BPF_XREG);
+}
+
+static void scan_insn(struct scan *scan, int idx)
+{
+	struct bpf_verifier_env *env = scan->env;
+	const struct bpf_insn_aux_data *aux = &env->insn_aux_data[idx];
+	const struct bpf_insn *insn = &env->prog->insnsi[idx];
+	struct origin *xregs = scan->xregs, value = no_origin;
+	u32 i, slot = slot_of_insn(env, insn);
+	unsigned long def = aux->def_regs;
+	u8 class = BPF_CLASS(insn->code);
+
+	if (class == BPF_ALU || class == BPF_ALU64)
+		value = alu_origin(scan, insn);
+	else if (slot)
+		value = class == BPF_ST ? const_origin(insn->imm) :
+			xregs[class == BPF_LDX ? slot : insn->src_reg];
+	if (class == BPF_ALU || (slot && BPF_SIZE(insn->code) == BPF_W))
+		value = truncate_origin(value,
+					class == BPF_LDX && BPF_MODE(insn->code) == BPF_MEMSX);
+	if (slot && class != BPF_LDX)
+		return write_origin(scan, slot, value);
+	for_each_set_bit(i, &def, BPF_REG_FP)
+		write_origin(scan, i, value);
+	for_each_set_bit(i, aux->may_write_mask, MAX_BPF_STACK_SLOTS)
+		write_origin(scan, bpf_spi_to_xreg(i), no_origin);
+}
+
+/* What one trip adds to the origin of @op. False if that is not a constant. */
+static bool find_step(const struct origin *xregs, struct origin *op)
+{
+	const struct origin *end = op->xregno < ORIGIN_CONST ? &xregs[op->xregno] : op;
+
+	op->step = end == op ? 0 : end->off;
+	return op->exact && !op->shifted && end->exact && !end->shifted &&
+	       end->xregno == op->xregno;
+}
+
+static bool is_invariant(const struct origin *xregs, u32 xregno)
+{
+	return xregs[xregno].xregno == xregno && xregs[xregno].exact && !xregs[xregno].off;
+}
+
+/*
+ * The spine is the insns that each trip runs once. Follow the xregs along it:
+ *
+ *	header -> a -> b -> ... -> back edge	on the spine:  x = x at the header + constant
+ *		   `-> c -'			off the spine: a write makes x inexact
+ */
+static void scan_loop(struct scan *scan, const struct bpf_loop *loop, const unsigned long *live,
+		      const int *spine, u32 top)
+{
+	struct bpf_verifier_env *env = scan->env;
+	const struct bpf_insn_aux_data *aux = &env->insn_aux_data[loop->header];
+	unsigned long consts = aux->const_reg_mask;
+	struct bpf_loop_steps *steps = scan->steps;
+	struct origin *xregs = scan->xregs;
+	int n, prev = -1, h = loop->header;
+	const struct bpf_insn *insn;
+	u32 i;
+
+	bpf_add_cost(env, loop->nr_insns + MAX_BPF_XREG, BPF_COST_XREG);
+	bitmap_zero(scan->written, MAX_BPF_XREG);
+	steps->cnt = 0;
+	for (i = 0; i < MAX_BPF_XREG; i++)
+		xregs[i] = !test_bit(i, live) ? no_origin :
+			   (struct origin){ .xregno = i, .exact = true };
+	for_each_set_bit(i, &consts, BPF_REG_FP)
+		xregs[i] = const_origin(aux->const_reg_vals[i]);
+	for (n = h; n >= 0 && (n == h || insn_is_in_loop(env, loop, n)) && !over_limit(env);
+	     prev = n, n = bpf_flow_insn_after(env, n)) {
+		insn = &env->prog->insnsi[n];
+		scan->on_spine = top && spine[top - 1] == n;
+		top -= scan->on_spine;
+		scan->on_spine &= bpf_loop_at_index(env, n) == h;
+		if (n != h && (env->idoms[n] != prev ||
+			       bpf_loop_at_index(env, n) != bpf_loop_at_index(env, prev)))
+			merge_origins(scan);
+		if (scan->on_spine && bpf_insn_leaves_loop(env, h, n)) {
+			steps->at[steps->cnt].insn_idx = n;
+			steps->at[steps->cnt].op[0] = xregs[insn->dst_reg];
+			steps->at[steps->cnt++].op[1] = BPF_SRC(insn->code) == BPF_X ?
+				xregs[insn->src_reg] : const_origin(insn->imm);
+		}
+		scan_insn(scan, n);
+	}
+	merge_origins(scan);
+	for_each_set_bit(i, live, MAX_BPF_XREG)
+		__assign_bit(i, steps->changed_xregs, !is_invariant(xregs, i));
+}
+
+static int find_steps(struct bpf_verifier_env *env, struct bpf_loop *loop)
+{
+	const struct bpf_insn_aux_data *aux = &env->insn_aux_data[loop->header];
+	DECLARE_BITMAP(live, MAX_BPF_XREG) = {};
+	struct bpf_loop_steps *steps;
+	struct origin *xregs, op;
+	struct scan *scan;
+	int *spine, n, h = loop->header, err = -ENOMEM;
+	u32 i, top = 0, jumps = 0;
+
+	live[0] = aux->live_regs_before & ~aux->const_reg_mask & GENMASK(BPF_REG_9, BPF_REG_0);
+	for_each_set_bit(i, aux->live_stack_before, MAX_BPF_STACK_SLOTS)
+		__set_bit(bpf_spi_to_xreg(i), live);
+	scan = kvzalloc_obj(*scan, BPF_VERIFIER_GFP);
+	spine = kvmalloc_objs(*spine, loop->nr_insns, BPF_VERIFIER_GFP);
+	for (n = bpf_loop_spine_end(env, loop); spine && n >= 0 && top < loop->nr_insns;
+	     n = n == h ? -1 : env->idoms[n]) {
+		spine[top++] = n;
+		jumps += bpf_insn_leaves_loop(env, h, n);
+	}
+	steps = kvzalloc_flex(*steps, at, jumps + bitmap_weight(live, MAX_BPF_XREG),
+			      BPF_VERIFIER_GFP);
+	if (!scan || !spine || !steps)
+		goto out;
+	scan->env = env;
+	scan->steps = steps;
+	xregs = scan->xregs;
+	/* the second scan knows which xregs change */
+	for (i = 0; i < 2; i++)
+		scan_loop(scan, loop, live, spine, top);
+	err = bpf_check_limits(env);
+	if (err)
+		goto out;
+	/* keep the jumps that compare an iv with a bound */
+	for (i = 0; i < steps->cnt; i++)
+		if (find_step(xregs, &steps->at[i].op[0]) &&
+		    find_step(xregs, &steps->at[i].op[1]) &&
+		    !steps->at[i].op[0].step != !steps->at[i].op[1].step)
+			steps->at[steps->jump_cnt++] = steps->at[i];
+	steps->cnt = steps->jump_cnt;
+	for_each_set_bit(i, live, MAX_BPF_XREG) {
+		op = xregs[i];
+		if (op.xregno != i || !op.exact)
+			__set_bit(i, steps->nonlinear_xregs);
+		if (op.xregno >= ORIGIN_CONST)
+			continue;
+		if (op.changed ? !is_invariant(xregs, op.xregno) :
+				 op.xregno != i && find_step(xregs, &op) && op.step)
+			__set_bit(i, steps->sum_xregs);
+		else if (op.xregno == i && find_step(xregs, &op) && op.step)
+			steps->at[steps->cnt++].op[0] = op;
+	}
+	loop->steps = kvmemdup(steps, struct_size(steps, at, steps->cnt), BPF_VERIFIER_GFP);
+	env->mem += struct_size(steps, at, steps->cnt);
+	err = loop->steps ? 0 : -ENOMEM;
+out:
+	kvfree(steps);
+	kvfree(scan);
+	kvfree(spine);
+	return err;
+}
+
+static struct scalar *origin_bounds(struct bpf_verifier_env *env,
+				    const struct bpf_verifier_state *st, const struct origin *op,
+				    bool *is_ptr)
+{
+	return bpf_find_var_bounds(env, st, bpf_xreg(st->curframe, op->xregno), is_ptr);
+}
+
+/* In how many trips does the jump at @idx stay in the loop? */
+static u64 trips_by_steps(struct bpf_verifier_env *env, const struct bpf_verifier_state *st,
+			  const struct bpf_loop *loop, int idx, const struct origin *op)
+{
+	const struct bpf_insn *insn = &env->prog->insnsi[idx];
+	bool is_ptr[2] = {}, i = !op[0].step;
+	u8 cond = loop_cond_opcode(insn, insn_is_in_loop(env, loop, idx + insn->off + 1), i);
+	struct scalar bound, off, *iv, *s;
+	u64 x;
+
+	iv = origin_bounds(env, st, &op[i], &is_ptr[0]);
+	if (!iv)
+		return U64_MAX;
+	scalar_set_const(&bound, op[!i].off);
+	if (op[!i].xregno != ORIGIN_CONST) {
+		s = origin_bounds(env, st, &op[!i], &is_ptr[1]);
+		if (!s)
+			return U64_MAX;
+		off = bound;
+		scalar_add(&bound, s, &off);
+		scalar_bounds_sync(&bound);
+	}
+	/* it needs the first trip, see add_distance_equation() */
+	if (cond == BPF_JNE && (iv->r64.size || bound.r64.size))
+		return 0;
+	if (iv->r64.size || is_ptr[0] != is_ptr[1])
+		return U64_MAX;
+	x = iv->r64.base + op[i].off;
+	x = op[i].low32 ? extend_low32(x, op[i].sext) : x;
+	return compute_trip_count(op[i].step, &x, cond, BPF_CLASS(insn->code) == BPF_JMP32, bound);
+}
+
+/* Make @st the state that the steps give for the next trip */
+static bool move_by_steps(struct bpf_verifier_env *env, struct bpf_verifier_state *st,
+			  const struct bpf_loop_steps *steps)
+{
+	struct bpf_xreg_equation *xreg_eq;
+	const struct origin *op;
+	struct scalar *s;
+	bool is_ptr;
+	u64 last;
+	u32 i;
+
+	for (i = steps->jump_cnt; i < steps->cnt; i++) {
+		op = steps->at[i].op;
+		s = origin_bounds(env, st, op, &is_ptr);
+		if (!s || (is_ptr && op->low32) ||
+		    type_is_pkt_pointer(container_of(&s->var_off, struct bpf_reg_state,
+						     var_off)->type))
+			return false;
+		move_bounds(env, s, is_ptr, op->step);
+		last = s->r64.base + s->r64.size;
+		if (op->low32 && !s->r64.size)
+			scalar_set_const(s, extend_low32(last, op->sext));
+		else if (op->low32 &&
+			 (s->r64.size > U32_MAX || extend_low32(last, op->sext) != last ||
+			  extend_low32(s->r64.base, op->sext) != s->r64.base))
+			return false;
+		xreg_eq = bpf_find_xreg_equation(&st->equations,
+						 bpf_xreg(st->curframe, op->xregno));
+		if (xreg_eq)
+			xreg_eq->off += op->step;
+	}
+	bpf_top_loop(st->frame[st->curframe])->trip++;
+	bpf_equations_next_trip(env, st, st->frame[st->curframe]->loop_stack_cnt - 1);
+	return true;
+}
+
+/*
+ * @st starts the leftover of @loop. Two trips show the steps and the thresholds. If the code
+ * shows them, join @st with what these trips possibly give, and check the body once:
+ *
+ *	i = 0  ->  i = 0, 150  ->  i = 0..450, i = 150 * k
+ *
+ * A wrong guess can cause an error or may_goto. Then it is not used again.
+ * Returns 1 if @st grew.
+ */
+int bpf_guess_first_trips(struct bpf_verifier_env *env, struct bpf_verifier_state *st,
+			  struct bpf_loop *loop)
+{
+	struct loop_stack_entry *e = bpf_top_loop(st->frame[st->curframe]);
+	struct bpf_verifier_state next = {};
+	struct bpf_loop_steps *steps;
+	u64 trips = U64_MAX, xreg;
+	struct scalar *s;
+	bool is_ptr;
+	int err;
+	u32 i;
+
+	if (!env->eq_env || !env->bypass_spec_v1 || bpf_prog_is_offloaded(env->prog->aux) ||
+	    st->speculative || st->equations.infeasible || e->loop != loop ||
+	    loop->no_first_trips_guess || loop->irreducible || loop->backedges_overflow ||
+	    e->trip_index.r64.size)
+		return 0;
+	err = loop->steps ? 0 : find_steps(env, loop);
+	if (err)
+		return err;
+	steps = loop->steps;
+	if (bpf_xregs_are_partitioned(env, st, st->curframe, steps->changed_xregs))
+		return 0;
+	/* only two trips show how a sum goes with the ivs, if its start is known */
+	for_each_set_bit(i, steps->sum_xregs, MAX_BPF_XREG) {
+		xreg = bpf_xreg(st->curframe, i);
+		s = bpf_find_var_bounds(env, st, xreg, &is_ptr);
+		if (s && (s->r32.size != U32_MAX || bpf_find_xreg_equation(&st->equations, xreg)))
+			return 0;
+	}
+	for (i = 0; i < steps->jump_cnt; i++)
+		trips = min(trips, trips_by_steps(env, st, loop, steps->at[i].insn_idx,
+						  steps->at[i].op));
+	if (!trips || trips > BPF_MAX_TRIPS)
+		return 0;
+	e->exit_threshold = e->trip_index.r64.base + trips;
+	add_iv_threshold(env, loop, e->exit_threshold, 1, THRESHOLD_EXIT_JUMP, U32_MAX);
+	for (i = 0; i < min(trips, 2) && !err; i++) {
+		err = bpf_copy_verifier_state(env, &next, st);
+		if (err || !move_by_steps(env, &next, steps))
+			break;
+		err = bpf_states_join(env, st, &next, loop, true);
+		env->extra_values = true;
+		bitmap_or(loop->nonlinear_xregs, loop->nonlinear_xregs, steps->nonlinear_xregs,
+			  MAX_BPF_XREG);
+	}
+	bpf_free_verifier_state(env, &next, false);
+	return err ?: i > 0;
+}
diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
index 3bec52051a9..eed9d13f6a6 100644
--- a/kernel/bpf/fixups.c
+++ b/kernel/bpf/fixups.c
@@ -755,6 +755,7 @@ static void free_loop(struct bpf_loop *loop)
 		return;
 	kvfree(loop->thresholds);
 	kvfree(loop->iv_thresholds);
+	kvfree(loop->steps);
 	kvfree(loop);
 }
 
diff --git a/kernel/bpf/flow.c b/kernel/bpf/flow.c
index d6f353a7bb2..33e50e1ad8c 100644
--- a/kernel/bpf/flow.c
+++ b/kernel/bpf/flow.c
@@ -392,6 +392,7 @@ int bpf_flow_needs_guard(struct bpf_verifier_env *env, struct bpf_loop *loop)
 {
 	if (loop->rt_bounded)
 		return 0;
+	loop->no_first_trips_guess = true;
 	if (!loop->has_guards) {
 		verbose(env, "loop at insn %d never exits\n", loop->header);
 		return -EINVAL;
@@ -1266,6 +1267,11 @@ static int flow_prune_or_join(struct bpf_verifier_env *env, struct flow_state *s
 		joined = false;
 	if (log && joined)
 		verbose(env, "from %d to %d: %s\n", prev, insn_idx, widened ? "widened" : "joined");
+	err = enters && !widened ? bpf_guess_first_trips(env, &s->st, loop) : 0;
+	if (err < 0)
+		goto free;
+	if (err)
+		flow_find(env, s);
 	flow_link(env, s);
 	return 0;
 free:
diff --git a/kernel/bpf/precision.c b/kernel/bpf/precision.c
index a33cc8664bc..9d55d3134e4 100644
--- a/kernel/bpf/precision.c
+++ b/kernel/bpf/precision.c
@@ -84,6 +84,21 @@ bool bpf_call_needs_frames(struct bpf_verifier_env *env, const struct bpf_verifi
 	return false;
 }
 
+/* Did a partition ask for the value or the type of one of @xregs in frame @fr? */
+bool bpf_xregs_are_partitioned(struct bpf_verifier_env *env, const struct bpf_verifier_state *st,
+			       u32 fr, const unsigned long *xregs)
+{
+	unsigned long types[XREG_WORDS], control_deps[XREG_WORDS];
+	u32 bits;
+
+	if (!env->precision->data_deps)
+		return false;
+	bits = bpf_frame_mask(env, env->precision->type_apart, st, fr, types);
+	bpf_frame_mask(env, env->precision->control_deps, st, fr, control_deps);
+	return bitmap_intersects(xregs, types, bits) ||
+	       bitmap_intersects(xregs, control_deps, bits);
+}
+
 /* The value in a slot. NULL if the slot has bytes of several types. */
 static const struct bpf_reg_state *slot_value(struct bpf_verifier_env *env,
 					      const struct bpf_func_state *f, u32 spi,
-- 
2.55.0

