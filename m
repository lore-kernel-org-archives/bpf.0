Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794498888;
	b=Rrn7RNZXvMfejjpKHwHiOuAZ6z1zqa1ECTu+rKKqZHAuVftTHixXhG6CD+kM1i8pxoYt
	 XZ4os2JOmjV6zrWb1yjyAjyUV5Hx67EK4WSb1skS73TDl9f1La6Kklkmk3Yq49E3+8OiC
	 8UoW9G8QxaC17XMxD7I8Tx5gq14cJ9EYgTIaaHKErN+cN8yyy0yqMRXd6eF6AEveYKf2H
	 FR/XYipPrSqO015Ml1tc++cL01H4Ce8XeRdH4AfaqRAr+s7DXxxrgke9QmDqT+BJuQTX6
	 2nb23F2+xFJu/e9KkzAh/jO9Hma1pqNwcbCYfyjRd/v6+Aa2vGVJ/j4w5vUEmDrOKDg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794498888;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=OUDzc9LRBke8q0NjUZSCLDVJVk5+6qZnB4EZDWXbUlc=;
	b=QKI/f8MuwT/7ZptMYHgCQGzMCEzvB9XzQcuT0vOS//gyPCbgU7VuOr4/Pf7eaGMcLdNS
	 hAiepl+tJMc8v1Ny2ciSoPIsdGazR+a5kF2ptKx3MVPl1P/wMp9zs27HKWAQH5CJLzz59
	 9d4fFTLF2kMmNsC3gv9ibiAhVrEwiWHZWShBEvouXvKty7+rqNRIwkChERVj7SYeIcwg9
	 gQPR5BuqYsiygbrq8IfyDZGeLvhGolNyD5vjXkcXmQsEyXAMvDPJyU0N6S57z/jy6agGc
	 OmAqjGvb/YHgDy9+OhkVdwxLu2WY9RtmTtlQiJyej+jsO78kj/qowu/VEIIijzYk72g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="DvihK0/w";
	arc=none smtp.remote-ip=209.85.216.45
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A933606A332
	for <bpf@vger.kernel.org>; Thu, 12 Nov 2026 15:54:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8A933606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DvihK0/w
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3b0e0e65adbso2323235a91.3
        for <bpf@vger.kernel.org>; Thu, 12 Nov 2026 07:54:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794498887; x=1795103687; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OUDzc9LRBke8q0NjUZSCLDVJVk5+6qZnB4EZDWXbUlc=;
        b=DvihK0/wscBdjVegxpU99zvC1CKqiBXq8zAJX2WZvbuO1TMwBz/cQ8zDkyAM8DRh77
         OckEI0uD4oS+4sUrg2Q/fIDoZxXXl1Vs34murVWLFulD5ErL2nU/rVud9+ZCpapsxUuT
         75PEJZFo8fYXEqNvNKc0l5lUC8bU3cnvP8ZW/BGY4RMulIAq8DqEDCc3jkwzqDYTzJin
         m/uj+N5UmZ8WL8CZ/ERs9693SPJLxalm7lOEHNVmWp33QPYOFzsRTFgtMBxRRiDnCvUY
         x/ocV2YpbdymSNc4cAHBYQlVwPptARJ5BDgxmxWmdWgLHltMi4ghl3yZ7qTDLb81eMMI
         1rEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794498887; x=1795103687;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=OUDzc9LRBke8q0NjUZSCLDVJVk5+6qZnB4EZDWXbUlc=;
        b=x6R2G5aBgahSSGppVRIuJoxBQjle579+PUQF8k86EjTi/Qb2rWWA9qEOq4JImctoLq
         tu8g9ZWPxPgU2CeG8eWErWwQo3QeMaisjbR50Wm7QZIyujPkCG05okaOLJ/Cl/14j4hT
         PE07TtImrdkPKkUzT41pJwN42N1BWSWmNjDri6/0W99j6XulWM942PbebdOBQCf3jcLY
         ADIA33BHSy/kpACFgv1F32hEypV/Hg+9LgAP48X36hEqCW9ivUSWopNKqPrbHy8QJZdM
         1+1flvyiqjlGo2t7xzFXTzk6tk63J3hVHWFibYw7qh4JqsGFNzZQ+0DjL1kX/iWIt6ic
         MU4A==
X-Gm-Message-State: APuU4Z8SxD7gCB2wdo+wN877UUkZUD5yXuQTCk6zV3Q8YivNJAO4GUzO
	Ee1Yv1oLKujzNnWedfIhX/ab5rlPJ/h1YOWB2rGgKZejBgAV2k3BsoYAYhO5TA==
X-Gm-Gg: AYBFou2Dz0oKrkjRF0AXlCd/0uNRiW1D+fYrac3c4JRFwd2QiSB5KizxNn4gV2CysY8
	XBktIZbdDGbGazH9PXkwNpem593oBwIy3cyn4dQcGy1q2c0d4s1ZupZlctS0/OcUrCf+jKMuD2t
	KHAxmzEWqWFN8ZqVP8LtrND5/oAezPk/liu2X/WuJptCSWlI+ZtYGrPQ/XzBIwewnijQu1SfiIt
	QFRi4fMd5o8dwRKyev+wprOGQV078zco7knc8HsnUVl0lgiUoym31RkZRm7u+YGRyi7mzXq3piR
	xbI0x96QL+vud56EnFl/LE3CTW3tsbojQKW1o4Y032KEdhgPQL2uk5qqH8Ff9MZU1iP2QOydqD3
	l26M7nVBNoEBZXvxXz0ZYzrwjcGN4JRzR/YRu+ZNPC4x6slQjNOZfsxWffDqOAvFmrpEmL+KRIy
	yro0UhradWxa50a/5v+ihbd3K2iFoENIz4ddJSPbzu1/EGAu4FBcLxE8s90wQyZhFH0bT+lsc6X
	3exGQlaZBE0aO0ZRKzseIA5XgOxPTaWca6K0SFI6sP1HlMJJ4gjywTKfipLlIJdwfRsOpEtqVYT
	KEXD7su2vInydDmmvRV44EpnpegmbzIfonXo4FFQsEJ20n6tEe5eC8Q+GsH6GPemyKWHUmPU9zb
	fJbVKg2p8yCSY7Cwe+15p8COl4eO2yNJFufSuzQ8Uctwft0fFPitUR1VA9fJT0cH6o5FX6ikMbQ
	ndrlIflUWD43B/HFwFcwU8TA==
X-Received: by 2002:a17:90b:3904:b0:3b0:99f8:eba8 with SMTP id 98e67ed59e1d1-3b182f8ba20mr6135847a91.66.1794498886053;
        Thu, 12 Nov 2026 07:54:46 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.244])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b197c73e27sm5076106a91.9.2026.11.12.07.54.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 07:54:45 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next 11/12] bpf: Evaluate the expression of a linked register
Date: Thu, 12 Nov 2026 15:53:36 +0000
Message-ID: <20261112155337.1040699-12-alexei.starovoitov@gmail.com>
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

The HTTP/2 parsers of the Datadog agent, as shipped from 7.51 on, are
rejected:

	current_header = NULL;
	if (interesting_headers < HTTP2_MAX_HEADERS_COUNT_FOR_PROCESSING)
		current_header = &headers_to_process[interesting_headers];

	 873: r1 = *(u64 *)(r10 -352)	r1 is [0, 2]
	 874: r1 &= 255
	 875: r3 = r1
	 876: r3 *= 20			r3 is [0, 40]
	 877: r4 = *(u64 *)(r10 -320)	map_value, 40 bytes
	 878: r4 += r3
	 879: r3 = 2
	 880: if r3 > r1 goto pc+1	r1 is [0, 1] at 882
	 881: r4 = 0
	1001: *(u32 *)(r1 +4) = r2	r1 is r4
	invalid access to map value, value_size=40 off=44 size=4

A jump refines 'tested register + constant' and, by match_linked_add(),
'register + tested register + constant'. r4 is neither.

Evaluate instead of matching. A register is linked if a tested register is
among the operands of its expression (LLVM: SCEVExprContains()). After the
jump the expression is evaluated in the refined state (getRangeRef()), each
op by scev_value_alu(). An operand that no op describes is read from a live
SCEV register that holds it + a constant: its leader (GVN).

find_linked_regs() keeps the linked registers and the leaders of a jump, as
before. Expressions share operands, so a visit of the jump lists the bases
below the linked registers in post-order, each base once, with the
positions of its operands and leaders. A leader is found by base.
eval_linked_exprs() walks the list once: a value is the intersection of
what the leaders hold and what the operands give. A linked register is the
value of its base + its constant. A register that is dead after the jump is
left out.

'tested + constant' is a base whose leader is the tested register.
'x == tested (mod 2^8)' is a leader in 8 bits: scalar_intersect() has the
rule. 'p = x + i' is an add. match_linked_add() and the searches for the
other operand go, recompute_ptr() keeps its checks and loses its add,
refine_linked_regs() is called once per branch.

Not evaluated: below depth EXPR_STACK_DEPTH; an operand without a live
leader ('h += n * 20' overwrites the only register that holds h; of two
indexes that are tested after the add the first is dead at the second
jump). Beside the tested registers one leader of an operand is read, the
widest. A jump with 64K distinct subexpressions refines nothing.

The filter is cheap: an expression is constructed after its operands, so
what is older than the tested values is dropped without a look at its
operands. Kernel instructions at load: Falco and Datadog +1 %, rust-bpf and
Tetragon +2 %. A prog with 60 slots that hold 'tested + constant' and 1000
jumps loads in 3/4 of the time.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/bpf_verifier.h                  |   7 +-
 kernel/bpf/scev.c                             | 634 +++++++++++++-----
 kernel/bpf/verifier.c                         |  71 +-
 .../selftests/bpf/progs/verifier_scev.c       |   2 +-
 4 files changed, 524 insertions(+), 190 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 978aa6db16e0..0d039742c97a 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -2241,10 +2241,11 @@ struct scev_value {
 	struct scalar;
 	int ptr_reg;	/* SCEV register identifying the pointer origin, or -1. */
 	u8 bits;	/* The value is known modulo 2^bits. 0: nothing is known. */
+	bool refined;	/* It depends on a register that the jump refined. */
 };
-bool bpf_scev_next_linked_reg(struct bpf_verifier_env *env, int insn_idx, u32 regno, u32 *pos,
-			      u32 *linked_regno, u32 *fill_off, int *base_regno, s64 *delta,
-			      u32 *bits);
+bool bpf_scev_next_linked_reg(struct bpf_verifier_env *env, struct bpf_func_state *st, int insn_idx,
+			      int next_idx, u16 refined_regs, u32 *pos, u32 *linked_regno,
+			      u32 *fill_off, struct scev_value *val);
 bool bpf_scev_mem_addr(struct bpf_verifier_env *env, int insn_idx, u32 regno, u32 *base_regno,
 		       s64 *off);
 bool bpf_is_widenable_reg_type(const struct bpf_reg_state *reg);
diff --git a/kernel/bpf/scev.c b/kernel/bpf/scev.c
index 008d8b2a53e6..ade4b4d0ddbf 100644
--- a/kernel/bpf/scev.c
+++ b/kernel/bpf/scev.c
@@ -70,9 +70,9 @@ enum expr_op {
  * In the env of loop H a phi at H merges the backedge values only, the header phi itself is
  * (REG r). In the env of the enclosing loop a phi at H merges the entering edges.
  * Op and params of a def by an insn are what that insn computes, see alu64_with_def():
- * set_expr_base() and match_linked_add() look through such an add, split_const_offset() and
- * match_linked_add() check prevent_zext of the insn. Those of a phi are the shape that its operands
- * share, no insn computes them: nothing looks through a phi.
+ * set_expr_base() looks through such an add, eval_linked_exprs() evaluates it, split_const_offset()
+ * and eval_linked_exprs() check prevent_zext of the insn. Those of a phi are the shape that its
+ * operands share, no insn computes them: nothing looks through a phi.
  */
 struct expr_def {
 	u32 set:1;	/* 0: the expression has no def */
@@ -87,9 +87,11 @@ static_assert(BASE_REG < 1 << 9 && BPF_COMPLEXITY_LIMIT_INSNS <= 1 << 21);
 static const struct expr_def no_def;
 
 struct expr {
-	u16 op;
+	u16 op:15;
 	/* A value number: all SCEV registers of an env that have this id hold the same value */
-	bool is_vn;
+	u16 is_vn:1;
+	/* Where find_linked_expr() looks for this id */
+	u16 linked_expr;
 	/*
 	 * UNKNOWN, OPAQUE and ANY don't describe a value. With a def the id stands for one value,
 	 * see struct expr_def. Without a def every use of the id can be another value.
@@ -136,6 +138,42 @@ struct scev_linked_reg {
 	u32 reg;
 	u32 id;
 	u32 addr;
+	/* The jump refines it. Otherwise it is a leader, or it holds the address of memory. */
+	bool refine;
+	/* At a visit: it is the linked expression 'expr' + a constant. NO_IDX: not evaluated. */
+	u16 expr;
+};
+
+#define NO_IDX U16_MAX
+#define LEADERS_NUM 3
+
+/*
+ * The expressions of the linked registers of a jump are a DAG. Its nodes are bases, see
+ * set_expr_base(): (+ x 4) and (+ x 8) are one node, x. A visit of the jump lists them in
+ * post-order: every base is there once, after its operands. The list is not kept.
+ */
+struct scev_linked_expr {
+	u32 id;
+	/* The bases of the operands: positions among the linked expressions of the jump */
+	u16 params[2];
+	/*
+	 * GVN's leader table. The SCEV registers that hold 'id' + a constant (mod 2^N): positions
+	 * among the linked registers of the jump. First the tested registers: they have news in any
+	 * number of bits. The last one is the widest of the others, in 'leader_bits' bits.
+	 */
+	u16 leaders[LEADERS_NUM];
+	u8 leader_bits;
+	/* It can be evaluated: it has a leader, or its operands can be evaluated */
+	u8 has_value:1;
+	/* find_linked_regs(): a register that the jump refines is made of it */
+	u8 needed:1;
+	/* By its innermost base it can have a constant difference to a tested register */
+	u8 tested_base:1;
+	/*
+	 * LLVM: SCEVExprContains(). By its bases a tested register can be among the
+	 * operands. Once the leaders are known: the value depends on a tested register.
+	 */
+	u8 has_tested:1;
 };
 
 struct insn_envs {
@@ -178,6 +216,9 @@ struct scev {
 	struct insn_envs **envs;
 	struct expr *exprs;
 	struct scev_linked_reg *linked;
+	/* The linked expressions of the jump at hand and their values, see eval_linked_exprs() */
+	struct scev_linked_expr *linked_exprs;
+	struct scev_value *vals;
 	/* The stack slots that a store through a dynptr slice may alias, see expr_is_vn() */
 	DECLARE_BITMAP(slice_slots, MAX_BPF_STACK_SLOTS);
 	/*
@@ -189,6 +230,9 @@ struct scev {
 	int exprs_cap;
 	u32 linked_cnt;
 	u32 linked_cap;
+	u32 linked_exprs_cnt;
+	u32 linked_exprs_cap;
+	u32 vals_cap;
 	int envs_cnt;
 	int stack_sz;
 	int simplify_depth;
@@ -1151,9 +1195,9 @@ static void forget_mem_regs(struct bpf_verifier_env *env, struct env *e, u32 add
 }
 
 /*
- * A jump tests a register, and a load makes a new value number. So a memory location is dead once
- * no register that is live after the insn at @idx has the base of its value: no jump is going to
- * link it.
+ * A jump tests a register, and a load makes a new value number. So once no register that is live
+ * after the insn at @idx has the base of its value no jump links a memory location by a constant
+ * difference: it goes. One that holds (* n 8) goes too, although a jump on n would evaluate it.
  */
 static void forget_dead_mem_regs(struct bpf_verifier_env *env, struct env *e, int idx)
 {
@@ -2182,41 +2226,6 @@ static bool const_diff_at_header(struct bpf_verifier_env *env, int h, u32 ra, u3
 	       base_a == REG_EXPR_ID(ra) && base_b == REG_EXPR_ID(rb) && off_a == c;
 }
 
-/*
- *	p = buf + i; if (i > 100) return 0; *p = 0;
- * @tested is the expression of the tested register and @id that of p, in one env as for
- * const_diff(). Is @id an add, and one operand @tested + a constant? Then
- * @id == *@other + @tested + *@delta (mod 2^*@bits). A header phi can be an add, see ADD_SCEV. For
- * an add with a def see split_const_offset(). Which operand is the pointer is not known here.
- */
-static bool match_linked_add(struct bpf_verifier_env *env, int h, u32 tested, u32 id, u32 *other,
-			     s64 *delta, u32 *bits)
-{
-	struct scev *scev = env->scev;
-	u32 reg, r, b, op = BPF_ADD;
-	struct expr_def def;
-	s64 c;
-
-	*bits = split_const_offset(env, id, &id, delta);
-	if (h >= 0 && is_reg(scev, id, &reg)) {
-		id = find_header_env(scev, h)->reg2scev[reg];
-		op = ADD_SCEV;
-	}
-	def = scev->exprs[id].def;
-	if (!is_binop(scev, op, id, other, &r) || def.phi)
-		return false;
-	if (def.set && !env->insn_aux_data[def.idx].prevent_zext)
-		*bits = min(*bits, 32);
-	if (!const_diff(env, h, tested, r, &c, &b)) {
-		swap(*other, r);
-		if (!const_diff(env, h, tested, r, &c, &b))
-			return false;
-	}
-	*delta = (u64)*delta + c;
-	*bits = min(*bits, b);
-	return true;
-}
-
 /*
  * const_diff() for the SCEV register @reg, which has the expression @id_b. A fill from byte
  * *@fill_off of a slot reads these bits. On big endian the low bytes of a spill are the last ones,
@@ -2264,91 +2273,298 @@ static u32 find_leader(struct bpf_verifier_env *env, struct env *e, int h,
 	return r;
 }
 
+/* The linked registers of a conditional jump */
+struct jump_links {
+	struct scev_linked_reg *regs;
+	u32 regs_cnt;
+	/* the loop of the expressions, -1: a subprog */
+	int h;
+	/* r0 - r10: what the jump refined */
+	u16 refined_regs;
+	/* their innermost bases */
+	u32 tested_base[2];
+	/* One is a header phi: these can have a constant difference, see const_diff_at_header() */
+	bool tested_phi;
+};
+
+static bool is_refined_reg(const struct jump_links *t, u32 reg)
+{
+	return reg < MAX_BPF_REG && (t->refined_regs & BIT(reg));
+}
+
+/* Make room for element @cnt of the array *@p, whose elements have @size bytes */
+static int grow_array(void *p, u32 cnt, u32 *cap, size_t size)
+{
+	u32 new_cap = max_t(u32, roundup_pow_of_two(cnt + 1), 16);
+	void *tmp;
+
+	if (cnt < *cap)
+		return 0;
+	tmp = kvrealloc(*(void **)p, array_size(new_cap, size), GFP_KERNEL_ACCOUNT);
+	if (!tmp)
+		return -ENOMEM;
+	*(void **)p = tmp;
+	*cap = new_cap;
+	return 0;
+}
+
+/*
+ * The op and the operands that the value of the base @id is computed from. NULL: it is a leaf, its
+ * value is what a leader holds.
+ */
+static struct expr *expr_to_eval(struct bpf_verifier_env *env, int h, u32 id)
+{
+	struct scev *scev = env->scev;
+	struct expr *e = &scev->exprs[id];
+	u32 reg;
+
+	/* A header phi can be an add of two header phis. Its other SCEVs have entry values. */
+	if (h >= 0 && is_reg(scev, id, &reg)) {
+		e = &scev->exprs[find_header_env(scev, h)->reg2scev[reg]];
+		if (e->op != ADD_SCEV)
+			return NULL;
+	}
+	/* nothing looks through a phi, see struct expr_def */
+	if (e->def.phi)
+		return NULL;
+	return op_params_num(e->op) ? e : NULL;
+}
+
+static struct scev_linked_expr *find_linked_expr(struct scev *scev, u32 id)
+{
+	u32 n = scev->exprs[id].linked_expr;
+
+	if (n >= scev->linked_exprs_cnt || scev->linked_exprs[n].id != id)
+		return NULL;
+	return &scev->linked_exprs[n];
+}
+
+/*
+ * Add the base of @id to the linked expressions, after its operands. Returns its position. An
+ * expression is a DAG, not a tree: a base that is there is not entered again. Below depth
+ * EXPR_STACK_DEPTH a base is a leaf.
+ */
+static int add_linked_expr(struct bpf_verifier_env *env, const struct jump_links *t, u32 id,
+			   u32 depth)
+{
+	struct scev *scev = env->scev;
+	struct scev_linked_expr x = { .id = scev->exprs[id].base, .params = { NO_IDX, NO_IDX },
+				      .leaders = { NO_IDX, NO_IDX, NO_IDX } };
+	struct expr *e;
+	u32 i, base;
+	int n;
+
+	if (find_linked_expr(scev, x.id))
+		return scev->exprs[x.id].linked_expr;
+	base = innermost_base(scev, x.id);
+	x.tested_base = base == t->tested_base[0] || base == t->tested_base[1] ||
+			(t->tested_phi && is_op(scev, base, REG));
+	x.has_tested = x.tested_base;
+	e = expr_to_eval(env, t->h, x.id);
+	for (i = 0; e && depth < EXPR_STACK_DEPTH && i < op_params_num(e->op); i++) {
+		/* the operands of ADD_SCEV are leaves: they could be adds of each other */
+		n = add_linked_expr(env, t, e->params[i],
+				    e->op == ADD_SCEV ? EXPR_STACK_DEPTH : depth + 1);
+		if (n < 0)
+			return n;
+		x.params[i] = n;
+		x.has_tested |= scev->linked_exprs[n].has_tested;
+	}
+	n = scev->linked_exprs_cnt;
+	if (n >= NO_IDX)
+		return -E2BIG;
+	if (grow_array(&scev->linked_exprs, n, &scev->linked_exprs_cap, sizeof(x)) ||
+	    grow_array(&scev->vals, n, &scev->vals_cap, sizeof(*scev->vals)))
+		return -ENOMEM;
+	scev->linked_exprs[scev->linked_exprs_cnt++] = x;
+	scev->exprs[x.id].linked_expr = n;
+	return n;
+}
+
+/* The linked register at position @k holds @x + a constant (mod 2^@bits) */
+static void add_leader(struct scev_linked_expr *x, u32 k, u32 bits, bool tested)
+{
+	u32 i = 0;
+
+	if (tested) {
+		while (x->leaders[i] != NO_IDX && x->leaders[i] != k)
+			i++;
+		x->leaders[i] = k;
+	} else if (bits > x->leader_bits) {
+		x->leaders[LEADERS_NUM - 1] = k;
+		x->leader_bits = bits;
+	}
+}
+
+/*
+ * List the bases below the expressions of the linked registers at the positions @roots, and find
+ * their leaders among all of @t. Most registers don't depend on a tested register: they leave
+ * @roots. -ENOENT: nothing but tested registers is left.
+ */
+static int add_linked_exprs(struct bpf_verifier_env *env, struct jump_links *t,
+			    unsigned long *roots)
+{
+	struct scev_linked_reg *q, *linked = t->regs;
+	struct scev *scev = env->scev;
+	struct scev_linked_expr *x;
+	u32 i, k, id, base, bits, fill_off, min_id, linked_cnt = 0;
+	s64 off;
+	int n;
+
+	scev->linked_exprs_cnt = 0;
+	for (k = 0; k < t->regs_cnt; k++) {
+		linked[k].expr = NO_IDX;
+		if (!is_refined_reg(t, linked[k].reg))
+			continue;
+		t->tested_base[1] = innermost_base(scev, linked[k].id);
+		if (!t->tested_base[0])
+			t->tested_base[0] = t->tested_base[1];
+	}
+	t->tested_phi = t->h >= 0 && (is_op(scev, t->tested_base[0], REG) ||
+				      is_op(scev, t->tested_base[1], REG));
+	min_id = t->tested_phi ? 0 : min(t->tested_base[0], t->tested_base[1]);
+	for_each_set_bit(k, roots, t->regs_cnt) {
+		q = &linked[k];
+		id = q->id;
+		/* an expression is constructed after its operands */
+		if (scev->exprs[id].base < min_id && !is_big_endian_slot(q->reg)) {
+			__clear_bit(k, roots);
+			continue;
+		}
+		/* the start of the slot was filled and tested, see const_diff_reg() */
+		for (i = 0; is_big_endian_slot(q->reg) && i < k; i++)
+			if (is_refined_reg(t, linked[i].reg) &&
+			    !const_diff(env, t->h, linked[i].id, q->id, &off, &bits) &&
+			    const_diff_reg(env, t->h, linked[i].id, q->reg, q->id, &fill_off, &off,
+					   &bits))
+				id = linked[i].id;
+		n = add_linked_expr(env, t, id, 0);
+		if (n < 0)
+			return n;
+		if (!scev->linked_exprs[n].has_tested) {
+			__clear_bit(k, roots);
+			continue;
+		}
+		q->expr = n;
+		linked_cnt += !is_refined_reg(t, q->reg);
+	}
+	if (!linked_cnt)
+		return -ENOENT;
+	/*
+	 * A register holds each of its bases + a constant: a leader is found by base. Memory is no
+	 * leader: which memory it is depends on the state.
+	 */
+	for (k = 0; k < t->regs_cnt && linked[k].reg < REGS_NUM; k++) {
+		if (is_refined_reg(t, linked[k].reg)) {
+			for (x = scev->linked_exprs;
+			     x < scev->linked_exprs + scev->linked_exprs_cnt; x++)
+				if (x->tested_base &&
+				    const_diff(env, t->h, linked[k].id, x->id, &off, &bits))
+					add_leader(x, k, bits, true);
+			continue;
+		}
+		base = scev->exprs[linked[k].id].base;
+		bits = 64;
+		off = 0;
+		do {
+			x = find_linked_expr(scev, base);
+			if (x)
+				add_leader(x, k, bits, false);
+		} while (next_base(scev, &base, &off, &bits));
+	}
+	return 0;
+}
+
 /*
  *	n = bpf_get_stack(..); m = n; if (n < 0) ..; use(m);
+ *	p = &hdr[i]; if (i > 1) return 0; p->len = 0;
  * The main pass refines the registers that the conditional jump at @idx tests. Find the live SCEV
- * registers that are linked to one of them in @e, the env before the jump, and keep them with their
- * expressions: what bpf_scev_next_linked_reg() needs of @e.
+ * registers whose expression in @e, the env before the jump, can be evaluated from a tested
+ * register and other live SCEV registers. Keep what bpf_scev_next_linked_reg() needs of @e: these
+ * registers and the leaders, with their expressions.
  */
 static int find_linked_regs(struct bpf_verifier_env *env, struct env *e, int h, int idx)
 {
 	struct bpf_insn_aux_data *aux = &env->insn_aux_data[idx];
 	struct bpf_insn *insn = &env->prog->insnsi[idx];
-	u32 dst = e->reg2expr[insn->dst_reg], src = dst;
+	struct jump_links t = { .h = h, .refined_regs = BIT(insn->dst_reg) };
 	struct insn_envs *envs = env->scev->envs[idx];
 	struct scev *scev = env->scev;
-	u32 r, q, other, id, fill_off, base, base_dst, base_src, bits, cap, tested = 0;
 	u32 first = scev->linked_cnt;
 	DECLARE_BITMAP(live, ENV_REGS_NUM) = {};
+	DECLARE_BITMAP(roots, ENV_REGS_NUM);
 	DECLARE_BITMAP(found, ENV_REGS_NUM) = {};
-	void *tmp;
-	s64 delta;
+	struct scev_linked_expr *x, *l, *p;
+	struct scev_linked_reg *q;
+	u32 i, k, r;
+	bool op;
+	int err;
 
 	if (!bpf_insn_is_cond_jump(insn->code) || BPF_OP(insn->code) == BPF_JCOND)
 		return 0;
 	if (BPF_SRC(insn->code) == BPF_X)
-		src = e->reg2expr[insn->src_reg];
+		t.refined_regs |= BIT(insn->src_reg);
 	bitmap_copy(live, aux->live_stack_before, MAX_BPF_STACK_SLOTS);
 	bitmap_shift_left(live, live, MAX_BPF_REG, REGS_NUM);
 	live[0] |= aux->live_regs_before;
 	for (r = REGS_NUM; r < ENV_REGS_NUM; r++)
 		if (e->mem_addr[r - REGS_NUM])
 			__set_bit(r, live);
-	base_dst = innermost_base(scev, dst);
-	base_src = innermost_base(scev, src);
 	for_each_set_bit(r, live, ENV_REGS_NUM) {
-		id = e->reg2expr[r];
-		/* most are not linked */
-		base = innermost_base(scev, id);
-		if (base != base_dst && base != base_src && !is_op(scev, base, BPF_ADD) &&
-		    (h < 0 || !is_op(scev, base, REG)) && !is_big_endian_slot(r))
-			continue;
-		if (const_diff_reg(env, h, dst, r, id, &fill_off, &delta, &bits) ||
-		    (src != dst && const_diff_reg(env, h, src, r, id, &fill_off, &delta, &bits))) {
-			__set_bit(r, found);
-			continue;
-		}
-		if (!match_linked_add(env, h, dst, id, &other, &delta, &bits) &&
-		    (src == dst || !match_linked_add(env, h, src, id, &other, &delta, &bits)))
-			continue;
-		/* an add is of use only with a live register that holds its other operand */
-		for_each_set_bit(q, live, REGS_NUM) {
-			if (q == r || !const_diff(env, h, e->reg2expr[q], other, &delta, &bits))
-				continue;
-			__set_bit(r, found);
-			__set_bit(q, found);
-			break;
-		}
+		if (grow_array(&scev->linked, scev->linked_cnt, &scev->linked_cap,
+			       sizeof(*scev->linked)))
+			return -ENOMEM;
+		scev->linked[scev->linked_cnt++] = (struct scev_linked_reg){
+			.reg = r, .id = e->reg2expr[r],
+			.addr = r < REGS_NUM ? 0 : e->mem_addr[r - REGS_NUM] };
 	}
-	/* the main pass finds memory by a live register that holds its address */
-	for (r = REGS_NUM; r < ENV_REGS_NUM; r++) {
-		if (!test_bit(r, found))
-			continue;
-		q = find_leader(env, e, h, live, e->mem_addr[r - REGS_NUM]);
-		if (q < REGS_NUM)
-			__set_bit(q, found);
-		else
-			__clear_bit(r, found);
+	t.regs = &scev->linked[first];
+	t.regs_cnt = scev->linked_cnt - first;
+	scev->linked_cnt = first;
+	bitmap_fill(roots, t.regs_cnt);
+	err = add_linked_exprs(env, &t, roots);
+	/* -E2BIG: too many expressions */
+	if (err)
+		return err == -E2BIG || err == -ENOENT ? 0 : err;
+	/* operands come first */
+	for (x = scev->linked_exprs; x < scev->linked_exprs + scev->linked_exprs_cnt; x++) {
+		l = x->params[0] == NO_IDX ? NULL : &scev->linked_exprs[x->params[0]];
+		p = x->params[1] == NO_IDX ? l : &scev->linked_exprs[x->params[1]];
+		op = l && l->has_value && p->has_value;
+		x->has_value = op || x->leader_bits || x->leaders[0] != NO_IDX ||
+			       is_op(scev, x->id, IMM);
+		x->has_tested = x->leaders[0] != NO_IDX ||
+				(op && (l->has_tested || p->has_tested));
 	}
-	for_each_set_bit(r, found, ENV_REGS_NUM) {
-		if (scev->linked_cnt == scev->linked_cap) {
-			cap = max(scev->linked_cap * 2, 16);
-			tmp = kvrealloc(scev->linked, array_size(cap, sizeof(*scev->linked)),
-					GFP_KERNEL_ACCOUNT);
-			if (!tmp)
-				return -ENOMEM;
-			scev->linked = tmp;
-			scev->linked_cap = cap;
+	for_each_set_bit(k, roots, t.regs_cnt) {
+		q = &t.regs[k];
+		x = &scev->linked_exprs[q->expr];
+		r = q->reg < REGS_NUM ? q->reg : find_leader(env, e, h, live, q->addr);
+		/* a tested register learns from the other one only */
+		if (!x->has_tested || (is_refined_reg(&t, q->reg) && x->leaders[1] == NO_IDX) ||
+		    /* the main pass finds memory by a live register that holds its address */
+		    r == REGS_NUM) {
+			__clear_bit(k, roots);
+			continue;
 		}
-		tested += r == insn->dst_reg || (src != dst && r == insn->src_reg);
-		scev->linked[scev->linked_cnt].reg = r;
-		scev->linked[scev->linked_cnt].addr = r < REGS_NUM ? 0 : e->mem_addr[r - REGS_NUM];
-		scev->linked[scev->linked_cnt++].id = e->reg2expr[r];
+		x->needed = true;
+		__set_bit(bitmap_weight(live, r), found);
 	}
-	/* nothing but the tested registers */
-	if (scev->linked_cnt - first == tested) {
-		scev->linked_cnt = first;
+	if (bitmap_empty(roots, t.regs_cnt))
 		return 0;
+	bitmap_or(found, found, roots, t.regs_cnt);
+	/* operands come first */
+	for (x = scev->linked_exprs + scev->linked_exprs_cnt; x-- > scev->linked_exprs;) {
+		for (i = 0; x->needed && i < LEADERS_NUM; i++)
+			if (x->leaders[i] != NO_IDX)
+				__set_bit(x->leaders[i], found);
+		for (i = 0; x->needed && i < 2 && x->params[i] != NO_IDX; i++)
+			scev->linked_exprs[x->params[i]].needed = true;
+	}
+	for_each_set_bit(k, found, t.regs_cnt) {
+		q = &scev->linked[scev->linked_cnt++];
+		*q = t.regs[k];
+		q->refine = test_bit(k, roots);
 	}
 	if (!envs) {
 		envs = kzalloc(sizeof(*envs), GFP_KERNEL_ACCOUNT);
@@ -2361,55 +2577,6 @@ static int find_linked_regs(struct bpf_verifier_env *env, struct env *e, int h,
 	return 0;
 }
 
-/*
- * Find the next SCEV register that is linked to @regno at the conditional jump at @insn_idx: on
- * every path to the jump *@linked_regno == @regno + *@delta (mod 2^*@bits). It is live there and of
- * the same frame. It is a register, or MAX_BPF_REG + the index of a stack slot: a fill from byte
- * *@fill_off of the slot reads these bits. *@pos is the position of the search, 0 at first. False:
- * no more links are known. Types are not known here: the caller checks them in its state.
- * A linked register can be a pointer: *base_regno + regno + delta. *base_regno is the address base,
- * as in store_base_regs. It is -1 for a link without a base.
- * BPF_SCEV_REGS_NUM and above is a memory location, see struct env and bpf_scev_mem_addr().
- */
-bool bpf_scev_next_linked_reg(struct bpf_verifier_env *env, int insn_idx, u32 regno, u32 *pos,
-			      u32 *linked_regno, u32 *fill_off, int *base_regno, s64 *delta,
-			      u32 *bits)
-{
-	struct insn_envs *envs = env->scev->envs[insn_idx];
-	int h = bpf_loop_at_index(env, insn_idx);
-	struct scev_linked_reg *linked;
-	u32 i, j, other, b;
-	s64 c;
-
-	if (!envs || !envs->linked_cnt)
-		return false;
-	linked = &env->scev->linked[envs->linked_first];
-	/* registers come first */
-	for (i = 0; linked[i].reg != regno; i++)
-		if (i + 1 == envs->linked_cnt || linked[i].reg > regno)
-			return false;
-	for (; *pos < envs->linked_cnt; ++*pos) {
-		*linked_regno = linked[*pos].reg;
-		*base_regno = -1;
-		if (*pos == i)
-			continue;
-		if (const_diff_reg(env, h, linked[i].id, *linked_regno, linked[*pos].id, fill_off,
-				   delta, bits))
-			return true;
-		if (!match_linked_add(env, h, linked[i].id, linked[*pos].id, &other, delta, bits))
-			continue;
-		for (j = 0; j < envs->linked_cnt; j++) {
-			if (j == *pos || !const_diff(env, h, linked[j].id, other, &c, &b))
-				continue;
-			*base_regno = linked[j].reg;
-			*delta = (u64)*delta + c;
-			*bits = min(*bits, b);
-			return true;
-		}
-	}
-	return false;
-}
-
 /*
  * The memory location @regno is a linked register of the conditional jump at @insn_idx. Its address
  * is *@base_regno + *@off. *@base_regno is a live register or stack slot. Which memory it is
@@ -3174,6 +3341,8 @@ void bpf_free_scev(struct bpf_verifier_env *env)
 	kvfree(scev->envs);
 	kvfree(scev->exprs);
 	kvfree(scev->linked);
+	kvfree(scev->linked_exprs);
+	kvfree(scev->vals);
 	kvfree(scev->discovered);
 	kfree(scev);
 	env->scev = NULL;
@@ -3565,6 +3734,12 @@ static void eval_reg(struct bpf_verifier_env *env, struct bpf_func_state *st, u3
 		v->ptr_reg = r;
 }
 
+static bool scalar_is_unknown(const struct scalar *s)
+{
+	return s->step <= 1 && tnum_is_unknown(s->var_off) && s->r64.size == U64_MAX &&
+	       s->r32.size == U32_MAX;
+}
+
 static void scev_value_set_const(struct scev_value *v, s64 imm)
 {
 	scalar_set_const(scalar_of(v), imm);
@@ -3646,6 +3821,165 @@ static void scev_value_alu(u32 op, struct scev_value *v, const struct scev_value
 	v->bits = 0;
 }
 
+/* @v = @v + @delta (mod 2^@bits) */
+static void scev_value_add_const(struct scev_value *v, s64 delta, u32 bits)
+{
+	struct scev_value c;
+
+	if (delta) {
+		scev_value_set_const(&c, delta);
+		scev_value_alu(BPF_ADD, v, &c);
+	}
+	v->bits = min(v->bits, bits);
+}
+
+/*
+ * @v and @w are two values of one expression: what a leader holds, what the operands give. Both
+ * hold: @v becomes their intersection. An empty one: the path is infeasible, @v is left as it is.
+ * Two pointers are not intersected, see recompute_ptr(): the one that has news is taken.
+ */
+static void scev_value_meet(struct scev_value *v, struct scev_value *w)
+{
+	if (!v->bits || !w->bits) {
+		if (w->bits)
+			*v = *w;
+		return;
+	}
+	if (w->bits > v->bits)
+		swap(*v, *w);
+	if (v->ptr_reg >= 0 || w->ptr_reg >= 0) {
+		if (v->ptr_reg >= 0 && w->ptr_reg >= 0 && w->bits == v->bits && w->refined)
+			*v = *w;
+		return;
+	}
+	scalar_intersect(scalar_of(v), scalar_of(w), w->bits);
+	v->refined |= w->refined;
+}
+
+/* The value of the operand @id. Its base is the linked expression at position @n. */
+static void eval_operand(struct bpf_verifier_env *env, u32 id, u32 n, struct scev_value *v)
+{
+	u32 base, bits;
+	s64 off;
+
+	*v = env->scev->vals[n];
+	bits = split_const_offset(env, id, &base, &off);
+	scev_value_add_const(v, off, bits);
+}
+
+/*
+ * LLVM: ScalarEvolution::getRangeRef(). Compute scev->vals[], the values of the linked expressions
+ * in the state @st. Operands come first: one walk over the array, every expression is evaluated
+ * once, from what its leaders hold in @st and from the values of its operands.
+ */
+static void eval_linked_exprs(struct bpf_verifier_env *env, struct bpf_func_state *st,
+			      const struct jump_links *t)
+{
+	struct scev_value w, r, *v, *vals = env->scev->vals;
+	const struct scev_linked_expr *x;
+	const struct scev_linked_reg *q;
+	struct scev *scev = env->scev;
+	struct expr *e;
+	u32 n, i, bits;
+	s64 delta;
+
+	for (n = 0; n < scev->linked_exprs_cnt; n++) {
+		x = &scev->linked_exprs[n];
+		v = &vals[n];
+		v->ptr_reg = -1;
+		v->bits = 0;
+		v->refined = false;
+		if (is_imm(scev, x->id, &delta))
+			scev_value_set_const(v, delta);
+		for (i = 0; i < LEADERS_NUM; i++) {
+			/* a tested register holds all bits: the others learn from it */
+			if (x->leaders[i] == NO_IDX || (i == LEADERS_NUM - 1 && v->bits == 64))
+				continue;
+			q = &t->regs[x->leaders[i]];
+			if (!const_diff(env, t->h, q->id, x->id, &delta, &bits))
+				continue;
+			eval_reg(env, st, q->reg, &w);
+			w.refined = is_refined_reg(t, q->reg);
+			scev_value_add_const(&w, delta, bits);
+			scev_value_meet(v, &w);
+		}
+		/* operands without news: the main pass evaluated the leader from them */
+		if (x->params[0] == NO_IDX || (v->bits == 64 && !vals[x->params[0]].refined &&
+		    (x->params[1] == NO_IDX || !vals[x->params[1]].refined)))
+			continue;
+		/* not NULL: it has operands */
+		e = expr_to_eval(env, t->h, x->id);
+		eval_operand(env, e->params[0], x->params[0], &w);
+		if (x->params[1] != NO_IDX) {
+			eval_operand(env, e->params[1], x->params[1], &r);
+			w.refined |= r.refined;
+		}
+		scev_value_alu(e->op == ADD_SCEV ? BPF_ADD : e->op, &w, &r);
+		/* The insn may become ALU32, see alu64_with_def(). The main pass knows. */
+		if (e->def.set && !env->insn_aux_data[e->def.idx].prevent_zext)
+			w.bits = e->op == BPF_ADD || e->op == ADD_SCEV ? min(w.bits, 32) : 0;
+		/* a product that can wrap: no news for those who are made of it */
+		if (w.bits && !scalar_is_unknown(scalar_of(&w)))
+			scev_value_meet(v, &w);
+	}
+}
+
+/*
+ * The jump at @insn_idx refined the registers @refined_regs in the state @st. Find the next SCEV
+ * register that is linked to one of them, and evaluate it: on every path to the jump
+ * *@linked_regno == *@val (mod 2^val->bits). It is of the same frame, and live at @next_idx, where
+ * @st goes on. It is a register, or MAX_BPF_REG + the index of a stack slot: a fill from byte
+ * *@fill_off of the slot reads these bits. *@pos is the position of the search, 0 at first. False:
+ * no more.
+ * Expressions have no types: a pointer is val->ptr_reg as it is in @st, with the offset *@val.
+ * BPF_SCEV_REGS_NUM and above is a memory location, see struct env and bpf_scev_mem_addr().
+ */
+bool bpf_scev_next_linked_reg(struct bpf_verifier_env *env, struct bpf_func_state *st, int insn_idx,
+			      int next_idx, u16 refined_regs, u32 *pos, u32 *linked_regno,
+			      u32 *fill_off, struct scev_value *val)
+{
+	struct insn_envs *envs = env->scev->envs[insn_idx];
+	DECLARE_BITMAP(roots, ENV_REGS_NUM) = {};
+	const struct scev_linked_reg *q;
+	struct scev *scev = env->scev;
+	struct jump_links t;
+	s64 delta;
+	u32 k, bits;
+
+	if (!envs || !envs->linked_cnt)
+		return false;
+	t = (struct jump_links){ .regs = &scev->linked[envs->linked_first],
+				 .regs_cnt = envs->linked_cnt,
+				 .h = bpf_loop_at_index(env, insn_idx),
+				 .refined_regs = refined_regs };
+	if (!*pos) {
+		for (k = 0; k < t.regs_cnt; k++)
+			if (t.regs[k].refine && reg_alive_at(env, t.regs[k].reg, next_idx))
+				__set_bit(k, roots);
+		if (add_linked_exprs(env, &t, roots))
+			return false;
+		eval_linked_exprs(env, st, &t);
+	}
+	for (; *pos < t.regs_cnt; ++*pos) {
+		q = &t.regs[*pos];
+		if (q->expr == NO_IDX || !scev->vals[q->expr].bits ||
+		    !scev->vals[q->expr].refined ||
+		    !const_diff_reg(env, t.h, scev->linked_exprs[q->expr].id, q->reg, q->id,
+				    fill_off, &delta, &bits))
+			continue;
+		*val = scev->vals[q->expr];
+		scev_value_add_const(val, delta, bits);
+		if (!val->bits)
+			continue;
+		/* the low bytes are the last ones */
+		if (is_big_endian_slot(q->reg))
+			*fill_off += (bits - val->bits) / BITS_PER_BYTE;
+		*linked_regno = q->reg;
+		return true;
+	}
+	return false;
+}
+
 /*
  * The value of @id in the state @st at a loop header: every SCEV register is its header phi there,
  * (REG r) is r. All 64 bits are wanted.
@@ -4142,9 +4476,7 @@ static bool is_unbound_scev_reg(struct bpf_verifier_env *env, const struct bpf_f
 {
 	const struct bpf_reg_state *reg = scev_reg_for_read(env, st, r);
 
-	return reg && reg->type == SCALAR_VALUE && reg->step <= 1 &&
-	       tnum_is_unknown(reg->var_off) &&
-	       reg->r64.size == U64_MAX && reg->r32.size == U32_MAX;
+	return reg && reg->type == SCALAR_VALUE && scalar_is_unknown(scalar_of(reg));
 }
 
 /*
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 3659cb839641..bb1659ce7a5c 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -19495,17 +19495,17 @@ static struct bpf_func_state *scev_mem_to_slot(struct bpf_verifier_env *env,
 
 /*
  *	p = buf + i; if (i > 100) return 0; *p = 0;
- * p is @dst_reg, x is @ptr_reg, i is @off_reg. Scalar evolution says that p == x + i. So the insns
+ * p is @dst_reg, x is @ptr_reg. Scalar evolution says that p == x + i. So the insns
  * 'p = x; p += i' are a no-op at run time, and a state that is sound before them is sound after
- * them: apply their transfer function. Type, object and offset of p are taken from x as it is now;
- * how p was computed does not matter.
+ * them: apply their transfer function. Type and object of p are taken from x as it is now, @off is
+ * the offset of x + i; how p was computed does not matter.
  * The old p is replaced, not intersected: a state does not distinguish two values of one hash map,
  * and the intersection of an offset into the one with an offset into the other holds for neither.
  * It is replaced only if the new range is a subset of the old one. An empty range is a subset too:
  * the path is infeasible, p is left as it is.
  */
 static bool recompute_ptr(struct bpf_verifier_env *env, struct bpf_reg_state *dst_reg,
-			  const struct bpf_reg_state *ptr_reg, const struct bpf_reg_state *off_reg)
+			  const struct bpf_reg_state *ptr_reg, const struct scalar *off)
 {
 	struct bpf_reg_state sum = *ptr_reg;
 
@@ -19516,8 +19516,8 @@ static bool recompute_ptr(struct bpf_verifier_env *env, struct bpf_reg_state *ds
 	if (ptr_reg->type == SCALAR_VALUE || type_is_pkt_pointer(ptr_reg->type) ||
 	    !bpf_is_widenable_reg_type(ptr_reg))
 		return false;
+	*scalar_of(&sum) = *off;
 	__mark_scalar32_unbounded(scalar_of(&sum));
-	scalar_add(scalar_of(&sum), scalar_of(&sum), scalar_of(off_reg));
 	reg_bounds_sync(&sum);
 	if (reg_is_empty(&sum) || const_tnum_range_mismatch(scalar_of(&sum)) ||
 	    const_tnum_range_mismatch_32(scalar_of(&sum)))
@@ -19535,25 +19535,31 @@ static bool recompute_ptr(struct bpf_verifier_env *env, struct bpf_reg_state *ds
 }
 
 /*
- * The jump at @idx refined @regno. A register that scalar evolution links to it holds
- * @regno + delta on every path to the jump: intersect the two. The intersection is empty: no
- * execution gets here with this state (the path is infeasible), the register is left as it is.
+ * The jump at @idx refined the scalars that it tests. Scalar evolution evaluates the expression of
+ * a register that is linked to them in this state. The register holds that value on every path to
+ * the jump: intersect the two.
  */
 static void refine_linked_regs(struct bpf_verifier_env *env, struct bpf_verifier_state *vstate,
-			       int idx, u32 regno)
+			       int idx, int next_idx)
 {
 	struct bpf_func_state *frame = vstate->frame[vstate->curframe], *linked_frame;
-	struct bpf_reg_state *reg, *base_reg, implied;
+	struct bpf_insn *insn = &env->prog->insnsi[idx];
+	struct bpf_reg_state *reg, *base_reg;
 	u32 pos, linked_regno, fill_off, bits;
-	int base_regno;
-	s64 delta;
-
-	if (frame->regs[regno].type != SCALAR_VALUE)
+	struct scev_value val;
+	u16 refined_regs = 0;
+
+	if (frame->regs[insn->dst_reg].type == SCALAR_VALUE)
+		refined_regs |= BIT(insn->dst_reg);
+	if (BPF_SRC(insn->code) == BPF_X && frame->regs[insn->src_reg].type == SCALAR_VALUE)
+		refined_regs |= BIT(insn->src_reg);
+	if (!refined_regs)
 		return;
 	for (pos = 0;
-	     bpf_scev_next_linked_reg(env, idx, regno, &pos, &linked_regno, &fill_off, &base_regno,
-				      &delta, &bits);
+	     bpf_scev_next_linked_reg(env, frame, idx, next_idx, refined_regs, &pos, &linked_regno,
+				      &fill_off, &val);
 	     pos++) {
+		bits = val.bits;
 		linked_frame = frame;
 		if (linked_regno >= BPF_SCEV_REGS_NUM)
 			linked_frame = scev_mem_to_slot(env, vstate, idx, &linked_regno, &fill_off);
@@ -19569,16 +19575,15 @@ static void refine_linked_regs(struct bpf_verifier_env *env, struct bpf_verifier
 			bits = 32;
 			reg = scev_reg_for_fill(linked_frame, linked_regno, fill_off, bits);
 		}
-		if (!reg || (base_regno < 0 && reg->type != SCALAR_VALUE))
+		if (!reg || (val.ptr_reg < 0 && reg->type != SCALAR_VALUE))
 			continue;
 
-		implied = frame->regs[regno];
-		add_scalar_to_reg(&implied, delta);
-		if (base_regno >= 0) {
-			base_reg = scev_reg_for_fill(frame, base_regno, 0, 64);
-			if (!base_reg || bits < 64 || !recompute_ptr(env, reg, base_reg, &implied))
+		if (val.ptr_reg >= 0) {
+			base_reg = scev_reg_for_fill(frame, val.ptr_reg, 0, 64);
+			if (!base_reg || bits < 64 ||
+			    !recompute_ptr(env, reg, base_reg, scalar_of(&val)))
 				continue;
-		} else if (!scalar_intersect(scalar_of(reg), scalar_of(&implied), bits)) {
+		} else if (!scalar_intersect(scalar_of(reg), scalar_of(&val), bits)) {
 			continue;
 		}
 		if (linked_regno < MAX_BPF_REG)
@@ -19612,7 +19617,7 @@ static void mark_loop_exit_decided(struct bpf_verifier_env *env, struct bpf_veri
  * the operands as that branch refines them. They hold every value that takes it, whether the other
  * branch is dead or not.
  */
-static int refine_live_branch(struct bpf_verifier_env *env, struct bpf_insn *insn,
+static int refine_live_branch(struct bpf_verifier_env *env, struct bpf_insn *insn, int next_idx,
 			      struct bpf_reg_state *reg1, struct bpf_reg_state *reg2)
 {
 	struct bpf_reg_state *regs = cur_regs(env);
@@ -19638,9 +19643,7 @@ static int refine_live_branch(struct bpf_verifier_env *env, struct bpf_insn *ins
 		regs[insn->src_reg] = *reg2;
 	if (!env->bpf_capable)
 		return 0;
-	if (BPF_SRC(insn->code) == BPF_X)
-		refine_linked_regs(env, env->cur_state, env->insn_idx, insn->src_reg);
-	refine_linked_regs(env, env->cur_state, env->insn_idx, insn->dst_reg);
+	refine_linked_regs(env, env->cur_state, env->insn_idx, next_idx);
 	return 0;
 }
 
@@ -19738,7 +19741,8 @@ static int check_cond_jmp_op(struct bpf_verifier_env *env,
 			if (err < 0)
 				return err;
 		}
-		err = refine_live_branch(env, insn, &env->true_reg1, &env->true_reg2);
+		err = refine_live_branch(env, insn, *insn_idx + insn->off + 1, &env->true_reg1,
+					 &env->true_reg2);
 		if (err)
 			return err;
 		if (env->log.level & BPF_LOG_LEVEL)
@@ -19756,7 +19760,8 @@ static int check_cond_jmp_op(struct bpf_verifier_env *env,
 			if (err < 0)
 				return err;
 		}
-		err = refine_live_branch(env, insn, &env->false_reg1, &env->false_reg2);
+		err = refine_live_branch(env, insn, *insn_idx + 1, &env->false_reg1,
+					 &env->false_reg2);
 		if (err)
 			return err;
 		if (env->log.level & BPF_LOG_LEVEL)
@@ -19780,12 +19785,8 @@ static int check_cond_jmp_op(struct bpf_verifier_env *env,
 		other_branch_regs[insn->src_reg] = env->true_reg2;
 
 	if (env->bpf_capable) {
-		if (BPF_SRC(insn->code) == BPF_X) {
-			refine_linked_regs(env, this_branch, *insn_idx, insn->src_reg);
-			refine_linked_regs(env, other_branch, *insn_idx, insn->src_reg);
-		}
-		refine_linked_regs(env, this_branch, *insn_idx, insn->dst_reg);
-		refine_linked_regs(env, other_branch, *insn_idx, insn->dst_reg);
+		refine_linked_regs(env, this_branch, *insn_idx, *insn_idx + 1);
+		refine_linked_regs(env, other_branch, *insn_idx, *insn_idx + insn->off + 1);
 	}
 
 	/* if one pointer register is compared to another pointer
diff --git a/tools/testing/selftests/bpf/progs/verifier_scev.c b/tools/testing/selftests/bpf/progs/verifier_scev.c
index f7ed39d4b186..012515859921 100644
--- a/tools/testing/selftests/bpf/progs/verifier_scev.c
+++ b/tools/testing/selftests/bpf/progs/verifier_scev.c
@@ -3640,7 +3640,7 @@ APPEND(append, "")
 LINKED(callback_tests_slot_of_caller, VALID, CALL_APPEND(append))
 /* The slot is written between the load and the jump: len is 0 1 3 7 15 31 63, the slot 126 */
 APPEND(append_stale, "r2 = r1; r2 <<= 1; *(u64 *)(r6 + 8) = r2;")
-LINKED(callback_tests_stale_copy_of_slot, UNBOUND, CALL_APPEND(append_stale))
+LINKED(callback_tests_stale_copy_of_slot, MAP_OOB, CALL_APPEND(append_stale))
 
 /*
  *	p = buf; i = 0; do { if (i > 62) break; i = *(u16 *)p; p = buf + i; } while (i);
-- 
2.55.0

