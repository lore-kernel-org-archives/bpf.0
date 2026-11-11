Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794415639;
	b=060vBLq4JN/XWcCRP2JaUr0V4JLOZPoOGGxETIoD0IoDcp7IaW2SI75ExWQxsfVBslYD
	 HnAYrayYmJARJ0+CzPaLJtehUfn5DlrmS5XubBLanl8m+47GxCZDr9vKIoPrs+Rg+2jWk
	 96BGXk+foLdPqSTA9CRB1zbkvZA2y7a8S4BG01sSlYDgepPO5FN1msdoNfzLF7h9kzzQ7
	 gQIdaq+JDCy5vgO6SzgsK+1wyhFyk5fj8wz3cv3xeN7LO8xo+DqWBbJQw93nKLdTDy31r
	 CdAoIzeLWmbtwi9n9126hcgcNZG0ewFRdawSmbU/MDWw9yOzxg2vRwaUr3wP9Q2sNbg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794415639;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=U3yd4PAVOcOZsqD9xoAcEAmaruzvHs1fOkvi3kAzzfI=;
	b=j3uNfl+sssjmxmnA/z/0L7OKHs+3wZLdB9PdQxHlbK0SOpPmEIt5GmIuokmhTCJOY5iN
	 Weoiymwj0wF3XRLx06ZX/AK8s42lZSkMJSi2+XEotDB292uP+QiMN85iNURLpnHp6GHAX
	 7Vllti/LfHYFqlN0CpKImF8TGHixK3KNJTn4TijgFkTxWoixmckl8s6njPLoQY+kqzAyJ
	 HWvyylWauuDeWQFc7MSCJmZBnKIXAHok/A3NRrdwVUJNLBoo8qjoVU75eQexgBzgXK4VX
	 enTCsciEfYHZs0g3g9Xn2KYjYS2OAgTcb3AlX4ebPFkYS7SjIo5Fs3huRy1mCkENF6g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sfJHK1LV;
	arc=none smtp.remote-ip=209.85.216.50
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1635F606A335
	for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 16:47:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1635F606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sfJHK1LV
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3b09c07b3d2so2038713a91.3
        for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 08:47:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794415638; x=1795020438; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=U3yd4PAVOcOZsqD9xoAcEAmaruzvHs1fOkvi3kAzzfI=;
        b=sfJHK1LVJw22iFZIcOBr6ifAlSmtnsHmgm7fpMB26NhFpQ0B8QRuSyYqoakOveiSnx
         HHk5z9WjZmIZrjA8zktAG9+LpA7upqqdG9iTW3N1QF6BKIxkR4PKa+9mosPAEO7w22xC
         gJLjUuUI8u/j/1cSF21V3Dw6cq1ReJWO3aaMN4ZhvLgAs51cI+CEd3FwKPtbud3jOlO2
         H9tdgPtY1LB/W2bd+9/vtOP5vET38uxJMKG3GhpWRZhbqKFSHzw5Jps6z37ardN3cd0W
         HlzB2nAc17DUyJM7Utiz4CJO0KiD2Ixqcs4ulJ7ubH1J4AmBfBQ3lRpwEBmuBTvqzLvG
         nMpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794415638; x=1795020438;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=U3yd4PAVOcOZsqD9xoAcEAmaruzvHs1fOkvi3kAzzfI=;
        b=cSb7afPgv9gAedqH1fr9ELt5IuqYX/C/07n9DZYCMYjdQfGtxVIV4OiH6iptmOzMJu
         oxD0c1jIBU4w3fKtpOOlPkuDa7ahFMgjtiMJe+4q0rQITk/YBvaI7SLqBm9kqIyF6dTb
         cIAMSB9tadrjbbVA6PROnpVdBkXgh+kRau1tp5LVKHenchSkCf9lHbco5EYQdhaKwOY/
         OeWj3rWvujhZK2TKbcD5MQS2xmzTmu7Rv3FQGD1i0EjpOcFb7tzKJ73x/2hEM2CYKrjM
         3vWi7AIxOQIr6nLsSj7+tejvGDNgeyxUFWkaVcFPRRJn9uwL5TnUflMFxYSyNzb1OLAi
         fSPQ==
X-Gm-Message-State: APuU4Z/LgKZ655UCX7tjvlIOHS20lyrJClqtdM+TMdsKjoWFEChUairq
	pOM4wXf/2+GdpiC/m2rdkvY3PE8xlTEcVdDawf5TbpUGplkpDs0OdVmb8naMxA==
X-Gm-Gg: AYBFou2QvpZuB6WiMkcl252kFzjgDIzIJ/9XV9IvZz4QE81KgBOnAyp2XFKGJKakYkg
	act9NO0JtNP9qu3mbwA/A2aog1doGUmn58R1dXUS6ageqI6FHRqB/s90egkv6ji/CdhGVhL1EWZ
	fgFLvKvoaOlpwVUxBPk5to+UW+YwQASObheWjVqXKtl3VoZue1nv7EsjJ8jNQpomncdNmJG42FW
	Sgrkv64WT7vtokjlYVmrlfTcfZtbGqh5SG3ToHTAopvYNg2YHnTR7un8uBqi+clciha3G10g5rC
	Td75qRx09+dUENDA3+9Koc16KVhCgeJKwDJqy4th3aRzdqUpmMXEkrS+u40U/mvGUJ9H7HB/qxl
	ZxLc9BomXFPYWskeQggdSzjpOqYrc0D2cgtHO7UiJE+frH3CCWYbzl+Gf08xtuQGvo4kQbXnTtl
	SkdBgxYnmMGa60Zf7xIiKENeyzQP6CiqEa5aiu5/gqoFxAmJFqek8zLzyR6YdA4/bPjZj8KAH1a
	xHgEheVI0OICshseYTJesY9I4+S1nmQam6/IyIIg75BEd0P5bxf99Zh5/A7+B7WQ5Ui6GNIRg2I
	1M2mCV3rthTtEdl3TSdO+AqEEFDADWFSu6eL6y4tkKgeDVCQxWMowOAnO4/2jGXOArq6rsWTu8G
	A/W4JHPq4z6ln1vKESS/gdtBvODONG8hXE8mdkoKclqJnpRjZoughx6kyxdQd1qN4IbMCtDAV0w
	==
X-Received: by 2002:a17:90b:3901:b0:3ad:4a8b:c703 with SMTP id 98e67ed59e1d1-3b182f670camr3063363a91.19.1794415638152;
        Wed, 11 Nov 2026 08:47:18 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.241])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b197d27cf1sm20415a91.12.2026.11.11.08.47.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 08:47:17 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next v3 13/29] bpf: Value number the phis of scalar evolution
Date: Wed, 11 Nov 2026 16:45:36 +0000
Message-ID: <20261111164557.2659679-14-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261111164557.2659679-1-alexei.starovoitov@gmail.com>
References: <20261111164557.2659679-1-alexei.starovoitov@gmail.com>
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
 kernel/bpf/scev.c                             | 101 +++++++++++++++---
 .../bpf/progs/verifier_linked_scalars.c       |   2 +
 2 files changed, 91 insertions(+), 12 deletions(-)

diff --git a/kernel/bpf/scev.c b/kernel/bpf/scev.c
index 5506e0d4e534..a793a096f646 100644
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
@@ -263,8 +273,8 @@ static u32 op_low_bits(u32 op);
 
 /*
  * @e gets the id @id. (+ x imm), an extension and a partial spill of x have the base of x, which
- * was constructed earlier. Every other expression is its own base. So split_const_offset() does not
- * traverse the expression.
+ * was constructed earlier. mk_phi() sets the base of a phi that it value numbers. Every other
+ * expression is its own base. So split_const_offset() does not traverse the expression.
  */
 static void set_expr_base(struct scev *scev, struct expr *e, u32 id)
 {
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

