Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794374104;
	b=4xDpLMoPWm9/E9hgsiiscFYrEUa57cpmyqiIiP3EyAiBQJ23PymmPaJOoKB3d4HrTH34
	 CevHO+O7FkL5Yj7SdcWmtHk/ERHfAzq3Gzk0f0BoRPqwiSOoexuHuu5f0m+E2EQU0XLbp
	 oDknPzLjkdnVjS368XVyQu5Iyhh90LaAcg4Y7l3KXGgvLtybCsywbIk3msJWioysgKtCc
	 vdItriolfUMD4gZw/8FLofKsoEVqbvqUMr8UKbH5e91mzvmipG1zgiMHj8x3NEUSzJn/k
	 YFWijGIGZSTeNm6DGlkWppxh5cVWTwmaBedxRBblkaI8Ch8niW707H+hBt6QJkS6WYw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794374104;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=RhwwkpkiN5QdioLDLNmN7IHtkmWfCFSuF+U7xYMOuzU=;
	b=wZ+kTrGLdCUk7OWwMjZTrNV3iD353wW1BpqcNdJ1QaPRfwSmrt5+zX/1jH3F+wQcFgMp
	 l7DwNnFJxk6k4h/f+lO1c8VjHjqWwfdE3xXl2Gkyw7yXxEgJxzHroSlo6Rw9Q3qgRJFW+
	 j4SkDn3lPrAb+c2XtzwZtde+xsvCCtxfXBcERetIQSQvdqVW26cBNzvvMfNSfuiwjF2vt
	 vC+BKIFrT7GDkvGXnF7sXOZx/opuA/ZwQV6gXsxY/VQmsblRiggczFYsc9ulCMvywX5nY
	 gwDb8e294cIuQpMvjXfM/Sdi0lNJSDR3BwH6FW9RrgCawg5sS9DgGUjxMm1fkQBYaZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Afzv5BZx;
	arc=none smtp.remote-ip=209.85.210.169
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2325606A31C
	for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 05:15:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C2325606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Afzv5BZx
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-8b68e59ab33so2113252b3a.2
        for <bpf@vger.kernel.org>; Tue, 10 Nov 2026 21:15:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794374103; x=1794978903; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RhwwkpkiN5QdioLDLNmN7IHtkmWfCFSuF+U7xYMOuzU=;
        b=Afzv5BZxcwvDUrRVVy9tl27AQVsANxEkpsfJ4XTObGQDrKOxPuZ7+s5pcWqE0t3tx6
         2dxEWVTRUhm/RpmZlcDDCfLuJDQxNlcTglbBrTbNpMDy9Z5rHOKuPDus4grZE0U1GTEs
         dFqKimvg4H1Or3jScKQ14N3hkg51pH0wtmpNnm2KfPLW2lIbc0pZZaiYTFNSJFcRHouz
         3+g2RFEhLMIMPJ9qGrjVoMk1UoeGyLBhhp/98xG++q+oaTdSaG6y9P3fFBSAZS99+5bt
         eWW87ay+xQIj8dgz6rH+DjbFLPsTIX9Km8VO35ouO/5QwQ5N+SQCZGx80hYNBv5L9nWp
         ahhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794374103; x=1794978903;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=RhwwkpkiN5QdioLDLNmN7IHtkmWfCFSuF+U7xYMOuzU=;
        b=vNgO9tYAuQOkdXTsgqbzPV6HMP035sz6N+QmV2JIuRKpLfYi7L0gNa/uN9n1dSLNqT
         7YIaMMpsU/qTHc5of5HVVDw/cx+vEmXNYnI8sgJ6BDI9RxgR+wkBms9GWu6XHxpwnjWv
         z/Y5nFqFCqMgTslyg8H+/OuOlSIzv5E8gMmu5zI8PYquzcangSiI9EgEc1kt1f1FOqrF
         TT9+FOJAfl/PmPaWpWZnyEbgrEEB+eIywUNBI8Qxe6JVPbOMT9aXu0wwRsq7yHHdxpEf
         ItMoKrt80f9HHEgawlYvz5bTGLWRq8bJTxnwKDr0J8KxjAMHlAAYZYYRuezIawRDvwwr
         B9/w==
X-Gm-Message-State: APuU4Z+aBoPlfkD96sEtTpGew5tQxv44BYQRzIpA9jzJW+TkOwQmA6kt
	kwN0raGuZ1ew4qKdtlYVYseGAbHRoRyvE6mmVEB1G4ucC5faqXQbVOb8/hlpCQ==
X-Gm-Gg: AYBFou2pGlY5tLyG1Nb0/GiQZGaBZ3QcC9iZGbdPTebn5CgnwNfAds43IYWAwpnyUFe
	Thb1mNAKI68RuUsUzA8rdQTRZ5+4ymmY2c4mRKDMiNLKZnXELQcg0NOR6lGd/RzCsKo5byQm3w1
	iNtaJOLCaG5/cRaL3uxU/BR9KrXDIgwPKH8jSWSKi97OqhAqimmDhu5ZGl0ai8+jAjhTrGTrOAv
	sNBmaJi0eStrF5g2LMkG4HGivBDJDq+9DDvzOqPJBaJDXwaNr4QaQmtvTP0FS4DE18ZZy/M14pN
	2TkUuOUZ3q1i1qniG+WchR93OSTHGhpHhr/gubJcpOXeBSKkC5utJWUiatVtrLo7KCTvbvCJWEa
	97+6YYYo130kp6JRPLSiYFGMbDDMwJZH08w0FXyRqVwAsTE1u6i/oJh/lpy6Dg0Or4nklKnbhp2
	2y8RqAvBUkv91fUB9/jlcUqPWN8TRBYmQGFUBW4cILkBDMdEPWXJSKJR7gWBw8P1IeZd+F/VlXK
	L00xRzLuTDB3zbh7EEZIZR1HaFs/64Uo4BvX/BSm1A40BV5pkeVU4aXJLU+zCD7davHfCmOpAc3
	hT4PaCo6c2rVjV/eECVVnEjTGcO6Z/raTvde25PVDWqa+YcBeXZ3Ck1Z2QME8aNM6Mlbbde0wjX
	tHkBx4aBJLrEhUv7ZmiLni0F+g0bNtei5LqKt94g9+UZORCZXtDMpysR1ex7iqvU5R+to+8AlNm
	emw0swVP4MIQ5zPv88zaF6
X-Received: by 2002:a05:6a21:50f:b0:3e2:3392:53f8 with SMTP id adf61e73a8af0-3f2fd190bb8mr1510471637.12.1794374102776;
        Tue, 10 Nov 2026 21:15:02 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.249])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cdd8d67cf51sm1540622a12.7.2026.11.10.21.15.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 21:15:02 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next v2 13/29] bpf: Value number the phis of scalar evolution
Date: Wed, 11 Nov 2026 05:13:24 +0000
Message-ID: <20261111051341.2800252-14-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261111051341.2800252-1-alexei.starovoitov@gmail.com>
References: <20261111051341.2800252-1-alexei.starovoitov@gmail.com>
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

A prerequisite of the removal of scalar ids. Two registers are linked if
their expressions have the same base, and so far every phi is a base of
its own. A copy that is made on each of two paths is not linked after the
join point:

	if (c) { n = f(); m = n; } else { n = g(); m = n; }
	if (n > 100)
		return 0;
	use(buf[m]);

n is %r6.9=phi(_), m is %r7.9=phi(_): two value numbers. Scalar ids link
them, each path gives n and m one id. recvfrom_x of Falco's modern_bpf
probe depends on it: 'long ret' lives in a stack slot, is filled on each of
two paths, tested after the join point and filled again. Without ids:

  R2 unbounded memory access, use 'var &= const' or 'if (var < const)'

Number phis as global value numbering does, by join point and operands
(Alpern, Wegman, Zadeck 1988; LLVM's GVN and NewGVN), up to a constant
offset (InstCombine's foldPHIArgBinOpIntoPHI()). With a == base_a + off_a
on the edges so far and b == base_b + off_b on this edge

	phi(a, b) == phi(base_a, base_b + off_b - off_a) + off_a

The phi of the bases is hashed by the join point and its two operands,
not by the register. All registers that have a constant difference on
each edge get the same one, and const_diff() finds them like 'x' and
'x + 4'. There is no search for pairs. The next edge merges the phi of
the bases with the next base, so the id stands for the list of operands,
for any number of edges.

The base is a part of the key of the phi of a register: the shape of a
phi can be the same after the second and after the third edge, its base
is not. The level 2 log prints the phi of a register as before, without
its base.

It is sound because the equation above holds on each edge by what
split_const_offset64() says about a and b there, and an execution gets to
the join point over one of the edges. The body of a loop without its
backedges is acyclic: no edge brings a phi of the join point itself, a phi
of bases is one value per iteration like every other def.

Phis are numbered in 64 bits: split_const_offset64() strips no extension
and no partial spill from an operand. (zext32 x) is a value number of its
own there. That it is x modulo 2^32 is not seen after a join point.

The selftest "add_const base_id must be consistent for pruning" expects
a rejection, but its r2 and r4 are both 'r0 & 0xff': r3 == r2 + 10 on both
paths, the prog is safe and loads now. 'r4 >>= 8' makes r4 the unrelated
value that the test wants. With it the prog is rejected before and after
the patch.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/scev.c                             | 97 +++++++++++++++++--
 .../bpf/progs/verifier_linked_scalars.c       |  2 +
 2 files changed, 89 insertions(+), 10 deletions(-)

diff --git a/kernel/bpf/scev.c b/kernel/bpf/scev.c
index 5506e0d4e534..f45abe90d498 100644
--- a/kernel/bpf/scev.c
+++ b/kernel/bpf/scev.c
@@ -61,8 +61,8 @@ enum expr_op {
  * executes at most once per iteration, so a def is one value per iteration. A name is unique within
  * the env of one loop.
  * The operands of a phi are a set, 8 at most; a phi(a, b) among them is expanded. They have no
- * defs, see strip_defs(): (+ r6 %r2.4) and (+ r6 %r2.7) are one operand, (+ r6 _). Every phi is
- * a value number of its own.
+ * defs, see strip_defs(): (+ r6 %r2.4) and (+ r6 %r2.7) are one operand, (+ r6 _). So they don't
+ * tell one phi from another: phis are value numbered by their bases, see mk_phi().
  * In the env of loop H a phi at H merges the backedge values only, the header phi itself is
  * (REG r). In the env of the enclosing loop a phi at H merges the entering edges.
  * Op and params of a def by an insn are what that insn computes, see alu64_with_def():
@@ -76,7 +76,9 @@ struct expr_def {
 	u32 reg:9;
 	u32 idx:21;
 };
-static_assert(REGS_NUM <= 1 << 9 && BPF_COMPLEXITY_LIMIT_INSNS <= 1 << 21);
+/* def.reg of the phi of two bases, see mk_phi() */
+#define BASE_REG REGS_NUM
+static_assert(BASE_REG < 1 << 9 && BPF_COMPLEXITY_LIMIT_INSNS <= 1 << 21);
 
 static const struct expr_def no_def;
 
@@ -186,9 +188,16 @@ static bool same_def(struct expr_def a, struct expr_def b)
 	return a.set == b.set && a.phi == b.phi && a.reg == b.reg && a.idx == b.idx;
 }
 
-static int expr_eq(struct expr *a, struct expr *b)
+/* Is @e the expression @id? The base of a phi is a part of its key. 0: the phi is its own base. */
+static int expr_eq(struct scev *scev, struct expr *e, u32 id)
 {
-	return a->op == b->op && a->imm == b->imm && same_def(a->def, b->def);
+	struct expr *x = &scev->exprs[id];
+
+	if (e->op != x->op || e->imm != x->imm || !same_def(e->def, x->def))
+		return false;
+	if (!e->def.phi)
+		return true;
+	return e->base ? e->base == x->base && e->off == x->off : x->base == id;
 }
 
 static void exprs_ht_add(struct scev *scev, u32 id)
@@ -239,7 +248,8 @@ static bool expr_is_vn(struct scev *scev, struct expr *e)
 	 * comes from a call that may write to the slot.
 	 */
 	if (e->def.set)
-		return reg < MAX_BPF_REG || !test_bit(reg - MAX_BPF_REG, scev->slice_slots);
+		return reg < MAX_BPF_REG || reg == BASE_REG ||
+		       !test_bit(reg - MAX_BPF_REG, scev->slice_slots);
 	switch (e->op) {
 	case UNKNOWN:
 	case OPAQUE:
@@ -272,10 +282,13 @@ static void set_expr_base(struct scev *scev, struct expr *e, u32 id)
 	struct expr *x;
 	s64 imm = 0;
 
+	e->arena_add = 0;
+	/* mk_phi() found the base */
+	if (e->def.phi && e->base)
+		return;
 	e->base = id;
 	e->off = 0;
 	e->bits = 64;
-	e->arena_add = 0;
 	/* nothing looks through a phi, see struct expr_def */
 	if (e->def.phi)
 		return;
@@ -301,7 +314,7 @@ static int add_expr(struct scev *scev, struct expr e)
 
 	id = scev->exprs_ht[expr_hash(&e) & (scev->exprs_cap - 1)];
 	for (; id; id = scev->exprs_next[id])
-		if (expr_eq(&e, &scev->exprs[id]))
+		if (expr_eq(scev, &e, id))
 			return id;
 
 	if (scev->exprs_cnt == scev->exprs_cap && grow_exprs(scev, scev->exprs_cap * 2))
@@ -378,6 +391,7 @@ static int expr_with_def(struct scev *scev, int id, struct expr_def def)
 		return id;
 	e = scev->exprs[id];
 	e.def = def;
+	e.base = 0;
 	return add_expr(scev, e);
 }
 
@@ -1366,6 +1380,69 @@ next:;
 	return expr_with_def(scev, id, def);
 }
 
+static void split_const_offset(struct bpf_verifier_env *env, u32 id, u32 *base, s64 *off,
+			       u32 *bits);
+
+/* @id == *@base + *@off in 64 bits: no extension and no partial spill is stripped */
+static void split_const_offset64(struct bpf_verifier_env *env, u32 id, u32 *base, s64 *off)
+{
+	struct scev *scev = env->scev;
+	u32 bits, l, r;
+
+	split_const_offset(env, id, base, off, &bits);
+	if (bits == 64)
+		return;
+	*base = id;
+	*off = 0;
+	if (!scev->exprs[id].def.set && is_add(scev, id, &l, &r) && is_imm(scev, r, off))
+		*base = l;
+}
+
+/*
+ *	if (c) { n = f(); m = n; } else { n = g(); m = n; }	if (n > 100) return 0;	use(m);
+ * The phi of @reg before the insn at @idx. It merges @a, which came over the edges so far, and @b.
+ * Phis are value numbered as GVN does it, by join point and operands, up to a constant offset:
+ * a == base_a + off_a and b == base_b + off_b, so
+ *	phi == phi(base_a, base_b + off_b - off_a) + off_a
+ * The phi of the bases is hashed without @reg. All registers that have a constant difference on
+ * each edge get the same one, and const_diff() finds them as it finds 'x' and 'x + 4'. The next
+ * edge merges the phi of the bases with the next base: the id stands for the list of the operands,
+ * for any number of edges. No edge brings a phi of this join point, so every phi here gets a new
+ * base with every edge.
+ */
+static int mk_phi(struct bpf_verifier_env *env, u32 a, u32 b, int idx, u32 reg)
+{
+	struct scev *scev = env->scev;
+	u32 base_a, base_b;
+	s64 off_a, off_b;
+	struct expr e;
+	int id;
+
+	id = mk_any(scev, a, b, no_def);
+	if (id < 0)
+		return id;
+	e = scev->exprs[id];
+	e.def = phi_def(idx, reg);
+	e.base = 0;
+	split_const_offset64(env, a, &base_a, &off_a);
+	split_const_offset64(env, b, &base_b, &off_b);
+	if (!expr_is_vn(scev, &e) || !scev->exprs[base_a].is_vn || !scev->exprs[base_b].is_vn)
+		return add_expr(scev, e);
+	id = base_b;
+	if (off_a != off_b)
+		id = expr2(scev, BPF_ADD, base_b, imm_expr(scev, (u64)off_b - off_a));
+	if (id < 0)
+		return id;
+	id = add_expr(scev, (struct expr){ .op = ANY, .params = { base_a, id },
+					   .def = phi_def(idx, BASE_REG) });
+	if (id < 0)
+		return id;
+	e.base = id;
+	e.off = off_a;
+	e.bits = 64;
+	return add_expr(scev, e);
+}
+
 /* @acc is the env before the insn at @idx */
 static int join(struct bpf_verifier_env *env, struct env *acc, struct env *cur, int idx)
 {
@@ -1382,8 +1459,8 @@ static int join(struct bpf_verifier_env *env, struct env *acc, struct env *cur,
 		if (!same_exprs(scev, acc->reg2expr[i], cur->reg2expr[i])) {
 			/* no phi for a dead register: pruned SSA */
 			id = reg_alive_at(env, i, idx) ?
-			     mk_any(scev, acc->reg2expr[i], cur->reg2expr[i],
-				    phi_def(idx, i)) : UNKNOWN_EXPR_ID;
+			     mk_phi(env, acc->reg2expr[i], cur->reg2expr[i], idx, i) :
+			     UNKNOWN_EXPR_ID;
 			if (id < 0)
 				return id;
 			acc->reg2expr[i] = id;
diff --git a/tools/testing/selftests/bpf/progs/verifier_linked_scalars.c b/tools/testing/selftests/bpf/progs/verifier_linked_scalars.c
index 42b9e46a88af..c8b3690dd810 100644
--- a/tools/testing/selftests/bpf/progs/verifier_linked_scalars.c
+++ b/tools/testing/selftests/bpf/progs/verifier_linked_scalars.c
@@ -676,6 +676,7 @@ l_false_%=:							\
 	r2 = r0;						\
 	r2 &= 0xff;		/* R2 = scalar(id=A) [0,255] */	\
 	r4 = r0;						\
+	r4 >>= 8;						\
 	r4 &= 0xff;		/* R4 = scalar [0,255], id=0 */	\
 	r3 = r2;		/* R3 linked to R2 (id=A) */	\
 	r3 += 10;		/* R3 id=A|ADD_CONST, delta=10 */\
@@ -688,6 +689,7 @@ l_true_%=:							\
 	r2 = r0;						\
 	r2 &= 0xff;		/* R2 = scalar [0,255], id=0 */	\
 	r4 = r0;						\
+	r4 >>= 8;						\
 	r4 &= 0xff;		/* R4 = scalar [0,255], id=0 */	\
 	r3 = r4;		/* R3 linked to R4 (new id=C) */\
 	r3 += 10;		/* R3 id=C|ADD_CONST, delta=10 */\
-- 
2.55.0

