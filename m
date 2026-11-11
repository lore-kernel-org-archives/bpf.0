Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794415591;
	b=zDQo+nzW6aglcJt5nobjT2vomxwh/SZ9hiNeJpY/L1DA3W/rQhdproDUTIa60KLoAaDS
	 rQa/y2kB98vQQqgTEiFNoCLx06MRZppfSrfwaeWRDyfwsi5vgoA27JqYCl33Sc15sLH0+
	 7Gun1P1Ck47GrMag7Azpwu2hgd0fXp3Xfg1FrkWV4q39vSbhxFELXgF3MJHlBGO+X7DDK
	 yHZ2HH3wKFjwbAe8iNpjw77nOQ/ZdPitqfUZJiqXxkasGvR8w6Ty+OhXyamnx5yEXe6ej
	 P7GXRNo8FMe2SBK7nzA9/M7D99eexKnRbQZP81wDzCH+hdHDcHZWrGe7zxQUrhYvw1Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794415591;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=FKSxELhjzXYDINSlaf5HUi/SGx1Iypt13v4oKwnOP4A=;
	b=EohOCSNuORSfdJywepDDAPLZU//jMBtZ37SKvo6rqEptGGlSYvOmBS5PXq6IYrA6HWzX
	 65YrPxjEkLirsUbZG2+SAVkWEY5KN0w+pKvnYMxbPVl7Hd2cVEk55dfm5YoGnsMv6oMpp
	 fkBiBoRgQqXi+Cg6lycAuMct4bA7oV2hpk45MVykQv9a8EBJ6bCt9879tR+eQZECkVuvZ
	 sAp7Y89rwQGRFJLQMr1qgYrxYSt1Rt+p4PeMGOO9TCEJKTvOisQbhW/nNO4vG6jlW48Qv
	 I9+H6KgdUcAjfkAGJ0X84RQvZ7J4+6FiDvqFsw7lSOUtNed77GivKq2PZu3DcxDpnyQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YQM6oBSC;
	arc=none smtp.remote-ip=209.85.214.175
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB513606A31C
	for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 16:46:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DB513606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YQM6oBSC
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2ed2b4348fcso13449805ad.2
        for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 08:46:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794415590; x=1795020390; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FKSxELhjzXYDINSlaf5HUi/SGx1Iypt13v4oKwnOP4A=;
        b=YQM6oBSCxZtV0aG8J5bvBwJY/qwC9b2TM4v1a3K17vpuyl+zHHlSZTiFLPEqpuJ52m
         nk+xadOxoWpYr+STxmp5bMv1ZcmOHIs87KeHPUcymJVNXG0aU2H6Fc8m6Hb8nZc6JH+D
         nN6DtbQDuMSsOItCzjIg8P8Zzbj53NIEUDK4WRYa0gnZWFqiYLVD/Mh1qneQTIcid2zg
         knf8RmDHbuL0G5FN0HeI8G9jZceJuxz5IwsBIMW2D4TgRPj7mikZgdCuaWpDBVXmGIGd
         81Eq7mtmXIs+w83QE81eIdxvMy1gi5mqf2wZwQF9UyRpbx7tqVNGLEmfEeLLfO6AYg/9
         ItpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794415590; x=1795020390;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=FKSxELhjzXYDINSlaf5HUi/SGx1Iypt13v4oKwnOP4A=;
        b=tamP7vWEX9MjR/wy15lScAqFfmMXuRxPg8F28ePgfhdDYgeSb+47eaTgojyM3mzEdX
         iTH8XIUkAp/gzGPclehX9GvFzU+KF59aVwNGSFiNvwLLN4whWiRpbRfuSDVMOLNrP7R5
         snEsNqfw3KuzF2vwN5UhDSAd+f4yfVAqP6eIJ1cWiV6BpIAKaD3dNNA92lO7oOIoQFoe
         MsfPV++cg4NiAg9q9sdt386RiqTKERuNv8hUX+FKNhQOvUjo10LVumevtgUFZdiucV63
         JBCFp2Uz/A96joR1KxmpOBQLDBNy3pg4gVsihnVVpw53gGRNIG5pW5nibZGxBON6TfzH
         RRZA==
X-Gm-Message-State: APuU4Z/28R79UCo5ReACOyYO8E+ck2NL+l9L8PfEdRl2dfeLwUlrobDi
	+cKVpBcqMkF+9V+Dyul2LtwOPgV5GmDP123qjRTx29TTiUX0UWuOFH5pN34zHQ==
X-Gm-Gg: AYBFou1ye5DK0s+x+3Jw6i5OSr4V8KiLAAe0rOoYkVuWTLaNJGtpLK/lAXwwGN5/msH
	qlqBljFwxUsa4ODdGVPQiz9vbFTHER41kxUlghfLfuBdHAAXL3UW70dj1ONkOPhKwbFlPLYC569
	6tiBjtI+PNDprkZEe+joFmZl+lVlGXZkOpbs2LdQnO/2hDiUzUX1Mc6hyJUoN5GFX5w4V5rVUhA
	On9ZIkgXPdkkeczCBJOJEYzihfY4/vD73KIl4wzRClTWCDZz75p4GcjW/axYiWIY6E0IV/gALj9
	LOBLFUPwzDg7mVlkvUM05zwCtT6oaXpoo5zbKqqYHcwDTdmj9A98tjmR851J7AA+PbgFomKZKFa
	wnfX4X5RJUY2+q7++v+OCj6Fiy0oi/JjLS0UMw0GZP8bh9u7IX+7BKHyIeYQ8BwGOtUFYAAUHoD
	SRrFsOMgvAHNmFowXT0SRrMDh3t/5JsETOJT2XCR7+/uNQrwYM/7OUor07owPqy47F3d47TFi/V
	Grtm3e8KksYqRFSYrd1h9CaMhe+HRjAMtqBZEfejR836pQZ6FDyYalOZEgEQ1jXyjJ7HPUJKW6s
	6tFNNX4IQ69T3unxF3jeH77s3eLFTTk1dXUVI2RR8BwnkVAE11lJG0f7rlhVyLTpIGyoBIcQDZp
	WFXEAPFoGjgtgqUbAvxtFebOCxOZXxDTqn9qLQktywTzEuWN+i+pG2KxaYFeOLY2yyQlbh2CGXB
	GxESa7ncmkeIr8CsS3wyk=
X-Received: by 2002:a17:903:285:b0:2ed:e93:71af with SMTP id d9443c01a7336-2edd79ecd11mr33862125ad.41.1794415589810;
        Wed, 11 Nov 2026 08:46:29 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2edb6e0e50fsm22949945ad.73.2026.11.11.08.46.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 08:46:29 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next v3 05/29] bpf: Simplify scalar evolution expressions at construction
Date: Wed, 11 Nov 2026 16:45:28 +0000
Message-ID: <20261111164557.2659679-6-alexei.starovoitov@gmail.com>
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

A prerequisite of the patches that find linked registers. It is about the
shape of an expression, not about cost: a constant offset has to stand at
the root. These patches compare the expressions of registers at every
conditional jump:

	r2 = r1
	r2 += 1
	r2 += 2
	if r1 > 100 goto ..

The jump bounds r2 too if r2 is known to be r1 + 3. The scalar id of r2 is
dropped at the second '+='. Its expression has to be (+ r1 3), however many
insns computed it.

Today it is (+ (+ r1 1) 2). transfer() records what each insn does and
folds nothing. simplify() is called later, and only for the registers at
the header, the latches and the exits of a loop. It traverses the whole
expression until nothing changes, and beyond depth 8 its answer is '?'.

Simplify in expr2(). The operands of a new expression are simplified
already, so simplify() handles the root only. Its rules construct their
results with expr2() too, so one rule can enable the next, 8 deep at most:
a prog can nest partial spills as deep as it likes. An expression beyond
that limit is correct, but not as simple as it could be. This is no
canonical form: operands are not ordered. transform_expr(), the repeated
pass over a whole expression, goes away.

What can be seen at once: GCC unrolls the loop of while_true() in loop3.c
8 times, with 'volatile __u64 i' on the stack. Before and after:

	*fp-16=(+ (+ ? ?) 7) / ?
	loop header at 5, non-linear latch at 76

	*fp-16=(+ *fp-16 8) / (linear *fp-16 8)
	loop header at 5, header_count is [0..536870912]

The loop gets an iteration count (header_count: how often the header is
executed), 4406 -> 150 insns processed. And two edges that bring the same
value, 'r6 += 1; r6 += 1' and 'r6 += 2', bring the same expression to
a join point. No verdict changes in the selftests, Cilium, sched_ext,
katran, bpfjailer and the programs in Rust. A verdict can change where
a loop gets an iteration count: it is summarized then, not unrolled. That
is how long loops load, and it is less precise for a register that has no
SCEV.

New rules. (+ x 0) is x. A fill that is not wider than the spill gets the
low bits of the spilled value: (sext8 (spill16 x)) is (sext8 x). Only
(zext32 (spill32 x)) had that. Little endian only, as before. No rule drops
a register from an expression: collect_tested_regs() and
collect_store_base_regs() see simplified expressions now.

The level 2 log has (+ r6 -2) for 'r6 -= 2' and 42 for 'w1 = 42'.

A by-product: the kernel spends 0.8 % fewer instructions (perf stat) on
loading the selftests, Cilium, sched_ext, katran, bpfjailer and programs in
Rust.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/scev.c                             | 112 +++++++++++-------
 .../selftests/bpf/progs/verifier_scev.c       |  20 +++-
 2 files changed, 84 insertions(+), 48 deletions(-)

diff --git a/kernel/bpf/scev.c b/kernel/bpf/scev.c
index 7031ab00a22a..4f02cd62305c 100644
--- a/kernel/bpf/scev.c
+++ b/kernel/bpf/scev.c
@@ -109,6 +109,7 @@ struct scev {
 	int exprs_cap;
 	int envs_cnt;
 	int stack_sz;
+	int simplify_depth;
 	struct expr_stack_elt expr_stack[EXPR_STACK_DEPTH];
 	u32 ids_buf[EXPR_STACK_DEPTH];
 };
@@ -178,13 +179,30 @@ static int add_expr(struct scev *scev, struct expr e)
 	return id;
 }
 
+static int simplify(struct scev *scev, u32 id);
+
+/*
+ * An expression is simplified at construction. Its params are simplified already, so simplify()
+ * rewrites the root only, whatever the depth of the expression.
+ * The rules construct expressions too, and one rule can enable the next: the depth of (zext32
+ * (spill32 (+ (spill32 (+ ..) 1)) 1)) is up to the prog. Beyond depth EXPR_STACK_DEPTH an
+ * expression is correct, but not simplified.
+ */
 static int expr2(struct scev *scev, u32 op, int a, int b)
 {
+	int id;
+
 	if (a < 0)
 		return a;
 	if (b < 0)
 		return b;
-	return add_expr(scev, (struct expr){ .op = op, .params = {a, b} });
+	id = add_expr(scev, (struct expr){ .op = op, .params = {a, b} });
+	if (id < 0 || scev->simplify_depth == EXPR_STACK_DEPTH)
+		return id;
+	scev->simplify_depth++;
+	id = simplify(scev, id);
+	scev->simplify_depth--;
+	return id;
 }
 
 static int expr1(struct scev *scev, u32 op, int a)
@@ -251,14 +269,47 @@ static bool is_zext32(struct scev *scev, int id, u32 *left)
 	return is_unop(scev, ZEXT32, id, left);
 }
 
-/* The low half of the slot is the low half of @left. The other half is not known. */
-static bool is_spill32(struct scev *scev, int id, u32 *left)
+/* (zextN x), (sextN x) and (spillN x) depend on the low N bits of x only */
+static u32 op_low_bits(u32 op)
+{
+	switch (op) {
+	case ZEXT8:
+	case SEXT8:
+	case SPILL8:
+		return 8;
+	case ZEXT16:
+	case SEXT16:
+	case SPILL16:
+		return 16;
+	case ZEXT32:
+	case SEXT32:
+	case SPILL32:
+		return 32;
+	}
+	return 0;
+}
+
+/* The low @bits bits of the slot are those of @left. The other bits are not known. */
+static bool is_spill(struct scev *scev, int id, u32 *bits, u32 *left)
 {
+	u32 op = scev->exprs[id].op;
+
 #ifdef __BIG_ENDIAN
 	/* '*(u32 *)(r10 - 8) = rX' writes the high half, see mk_fill() */
 	return false;
 #endif
-	return is_unop(scev, SPILL32, id, left);
+	if (op != SPILL8 && op != SPILL16 && op != SPILL32)
+		return false;
+	*bits = op_low_bits(op);
+	*left = scev->exprs[id].params[0];
+	return true;
+}
+
+static bool is_spill32(struct scev *scev, int id, u32 *left)
+{
+	u32 bits;
+
+	return is_spill(scev, id, &bits, left) && bits == 32;
 }
 
 static bool is_any(struct scev *scev, int id, u32 *left, u32 *right)
@@ -1579,29 +1630,10 @@ static int transform_expr_once(struct scev *scev, u32 lvl, u32 root, void *priv,
 	return id < 0 ? id : fn(scev, id, priv);
 }
 
-static int transform_expr(struct scev *scev, u32 root, void *priv,
-			  int (*fn)(struct scev *scev, u32 id, void *priv))
-{
-	int i = 0, id_old, id_new = root;
-
-	do {
-		/*
-		 * The depth limit is somewhat arbitrary and is essentially a failsafe.
-		 * oscillation should not really happen. Still, it seems harsh to error out.
-		 */
-		if (i++ == 4 * EXPR_STACK_DEPTH)
-			return UNKNOWN_EXPR_ID;
-		id_old = id_new;
-		id_new = transform_expr_once(scev, 0, id_old, priv, fn);
-		if (id_new < 0)
-			return id_new;
-	} while (id_old != id_new);
-	return id_new;
-}
-
-static int simplify(struct scev *scev, u32 id, void *priv)
+static int simplify(struct scev *scev, u32 id)
 {
 	int a, b, l, r, t, base, slope;
+	u32 bits, op = scev->exprs[id].op;
 	s64 imm1, imm2;
 
 	/* (- x imm) -> (+ x -imm) */
@@ -1609,6 +1641,10 @@ static int simplify(struct scev *scev, u32 id, void *priv)
 	    is_imm(scev, r, &imm1) && imm1 != S64_MIN)
 		return expr2(scev, BPF_ADD, l, imm_expr(scev, -imm1));
 
+	/* (+ x 0) -> x */
+	if (is_add(scev, id, &l, &r) && is_imm(scev, r, &imm1) && !imm1)
+		return l;
+
 	/* (+ (+ x imm) imm) -> (+ x imm) */
 	if (is_add(scev, id, &l, &r) &&
 	    is_imm(scev, r, &imm2) &&
@@ -1658,12 +1694,14 @@ static int simplify(struct scev *scev, u32 id, void *priv)
 		return expr1(scev, SPILL32, expr2(scev, BPF_ADD, a, b));
 
 	/*
-	 * 'rX = *(u32 *)(r10 - 8)' loads what was stored:
+	 * 'rX = *(u32 *)(r10 - 8)' fills what was spilled, a narrower fill the low bits of it:
 	 * (zext32 (spill32 $a)) -> (zext32 $a)
+	 * (sext8 (spill16 $a)) -> (sext8 $a)
 	 * (zext32 (+ (spill32 $a) $b)) -> (zext32 (+ $a $b))
 	 */
-	if (is_zext32(scev, id, &t) && is_spill32(scev, t, &a))
-		return expr1(scev, ZEXT32, a);
+	if (op_low_bits(op) && is_spill(scev, scev->exprs[id].params[0], &bits, &a) &&
+	    op_low_bits(op) <= bits)
+		return expr1(scev, op, a);
 	if (is_zext32(scev, id, &t) && is_add(scev, t, &l, &b) && is_spill32(scev, l, &a))
 		return expr1(scev, ZEXT32, expr2(scev, BPF_ADD, a, b));
 
@@ -1692,10 +1730,7 @@ static int compute_header_scevs(struct bpf_verifier_env *env, struct env *header
 	 *      ... at exit r1 is in {7,42} ...
 	 */
 	for (ra = 0; ra < REGS_NUM; ra++) {
-		ra_expr = transform_expr(scev, header_env->reg2expr[ra], NULL, simplify);
-		if (ra_expr < 0)
-			return ra_expr;
-		header_env->reg2expr[ra] = ra_expr;
+		ra_expr = header_env->reg2expr[ra];
 		/* rA = (+ rA IMM) -> (linear rA IMM) */
 		if (is_add(scev, ra_expr, &l, &r) &&
 		    is_reg(scev, l, &rb) &&
@@ -1843,17 +1878,8 @@ static int compute_insn_scevs(struct bpf_verifier_env *env, struct env *eheader,
 	int id, reg;
 
 	for (reg = 0; reg < REGS_NUM; reg++) {
-		/*
-		 * Simplify first. 'store, load, test' of a 32-bit counter on the stack with the
-		 * equation of the header in it is deeper than EXPR_STACK_DEPTH.
-		 */
-		id = transform_expr(scev, einsn->reg2expr[reg], NULL, simplify);
-		if (id < 0)
-			return id;
-		id = transform_expr_once(scev, 0, id, eheader->reg2scev, instantiate_header_scevs);
-		if (id < 0)
-			return id;
-		id = transform_expr(scev, id, NULL, simplify);
+		id = transform_expr_once(scev, 0, einsn->reg2expr[reg], eheader->reg2scev,
+					 instantiate_header_scevs);
 		if (id < 0)
 			return id;
 		einsn->reg2scev[reg] = id;
diff --git a/tools/testing/selftests/bpf/progs/verifier_scev.c b/tools/testing/selftests/bpf/progs/verifier_scev.c
index f2a53fe5f6ad..3d73a7107cba 100644
--- a/tools/testing/selftests/bpf/progs/verifier_scev.c
+++ b/tools/testing/selftests/bpf/progs/verifier_scev.c
@@ -324,10 +324,11 @@ __msg("r1 += 2 {{.*}}; r1 r6 -> (+ r6 2)")
 __msg("r1 += r7 {{.*}}; r1 r6 -> (+ r6 r7)")
 __msg("w1 += 2 {{.*}}; r1 r6 -> (zext32 (+ r6 2))")
 __msg("w1 += w7 {{.*}}; r1 r6 -> (zext32 (+ r6 r7))")
-__msg("r1 -= 2 {{.*}}; r1 r6 -> (- r6 2)")
+__msg("r1 -= 2 {{.*}}; r1 r6 -> (+ r6 -2)")
 __msg("r1 -= r7 {{.*}}; r1 r6 -> (- r6 r7)")
-__msg("w1 -= 2 {{.*}}; r1 r6 -> (zext32 (- r6 2))")
+__msg("w1 -= 2 {{.*}}; r1 r6 -> (zext32 (+ r6 -2))")
 __msg("w1 -= w7 {{.*}}; r1 r6 -> (zext32 (- r6 r7))")
+__msg("r1 -= 2 {{.*}}; r1 (+ r6 2) -> r6")
 __msg("r1 *= 2 {{.*}}; r1 r6 -> (* r6 2)")
 __msg("r1 *= r7 {{.*}}; r1 r6 -> (* r6 r7)")
 __msg("w1 *= 2 {{.*}}; r1 r6 -> (zext32 (* r6 2))")
@@ -375,7 +376,7 @@ __msg("w1 s>>= w7 {{.*}}; r1 r6 -> (zext32 (s>> (sext32 r6) (& r7 31)))")
 __msg("r1 = -r1 {{.*}}; r1 r6 -> (- r6)")
 __msg("w1 = -w1 {{.*}}; r1 r6 -> (zext32 (- r6))")
 __msg("r1 = 42 {{.*}}; r1 r6 -> 42")
-__msg("w1 = 42 {{.*}}; r1 r6 -> (zext32 42)")
+__msg("w1 = 42 {{.*}}; r1 r6 -> 42")
 __msg("r1 = r7 {{.*}}; r1 r6 -> r7")
 __msg("w1 = w7 {{.*}}; r1 r6 -> (zext32 r7)")
 __msg("r1 = (s8)r6 {{.*}}; r1 r6 -> (sext8 r6)")
@@ -417,6 +418,7 @@ __naked void alu_ops_exprs(void)
 	ALU_OP("r1 -= r7")
 	ALU_OP("w1 -= 2")
 	ALU_OP("w1 -= w7")
+	ALU_OP("r1 += 2; r1 -= 2")
 	ALU_OP("r1 *= 2")
 	ALU_OP("r1 *= r7")
 	ALU_OP("w1 *= 2")
@@ -511,7 +513,7 @@ __msg("*(u16 *)(r10 -8) = r1 {{.*}}; *fp-8 -8 -> (spill16 1)")
 __msg("*(u8 *)(r10 -8) = r1 {{.*}}; *fp-8 -8 -> (spill8 1)")
 __msg("r1 = *(u64 *)(r10 -8) {{.*}}; r1 1 -> -8")
 #if __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
-__msg("r1 = *(u32 *)(r10 -8) {{.*}}; r1 1 -> (zext32 -8)")
+__msg("r1 = *(u32 *)(r10 -8) {{.*}}; r1 1 -> 4294967288")
 __msg("r1 = *(u16 *)(r10 -8) {{.*}}; r1 1 -> (zext16 -8)")
 __msg("r1 = *(u8 *)(r10 -8) {{.*}}; r1 1 -> (zext8 -8)")
 __msg("r1 = *(s32 *)(r10 -8) {{.*}}; r1 1 -> (sext32 -8)")
@@ -519,7 +521,7 @@ __msg("r1 = *(s16 *)(r10 -8) {{.*}}; r1 1 -> (sext16 -8)")
 __msg("r1 = *(s8 *)(r10 -8) {{.*}}; r1 1 -> (sext8 -8)")
 __msg("r1 = load_acquire((u8 *)(r10 -8)) {{.*}}; r1 1 -> (zext8 -8)")
 __msg("r1 = load_acquire((u16 *)(r10 -8)) {{.*}}; r1 1 -> (zext16 -8)")
-__msg("r1 = load_acquire((u32 *)(r10 -8)) {{.*}}; r1 1 -> (zext32 -8)")
+__msg("r1 = load_acquire((u32 *)(r10 -8)) {{.*}}; r1 1 -> 4294967288")
 #else
 __msg("r1 = *(u32 *)(r10 -8) {{.*}}; r1 1 -> (>> -8 32)")
 __msg("r1 = *(u16 *)(r10 -8) {{.*}}; r1 1 -> (>> -8 48)")
@@ -543,6 +545,11 @@ __msg("r1 = atomic64_xchg((u64 *)(r10 -8), r1) {{.*}}; r1 1 -> _, *fp-8 -8 -> _"
 __msg("r0 = atomic64_cmpxchg((u64 *)(r10 -8), r0, r2) {{.*}}; r0 0 -> _, *fp-8 -8 -> _")
 __msg("*(u64 *)(r10 -8) = 42 {{.*}}; *fp-8 -8 -> 42")
 __msg("*(u8 *)(r10 -7) = r0 {{.*}}; *fp-8 -8 -> _")
+#if __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
+/* a fill that is not wider than the spill reads what was spilled */
+__msg("r1 = *(s8 *)(r10 -8) {{.*}}; r1 r7 -> (sext8 r7)")
+__msg("r1 = *(u16 *)(r10 -8) {{.*}}; r1 r7 -> (zext16 (spill8 r7))")
+#endif
 __naked void store_load_exprs(void)
 {
 	asm volatile (
@@ -579,6 +586,9 @@ __naked void store_load_exprs(void)
 	ST_OP("*(u64 *)(r10 - 8) = 42")
 	ST_OP("*(u8 *)(r10 - 7) = r0")
 
+	ST_OP("r1 = r7; *(u16 *)(r10 - 8) = r1; r1 = *(s8 *)(r10 - 8)")
+	ST_OP("r1 = r7; *(u8 *)(r10 - 8) = r1; r1 = *(u16 *)(r10 - 8)")
+
 	"r7 += 1;"
 	"if r7 < 2 goto 1b;"
 	"r0 = 0;"
-- 
2.55.0

