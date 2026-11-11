Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794374062;
	b=5n2XCLuD7eLy0oG2QvPud9bh7UFAxZWSZEVXfUMuyZEHSt+0jzVl1Bm6uNHrQcAYwSN/
	 x5KBoVW6HaWZqVUBj5WvFVnI/I6hGz3jkklAuZeU49FPx3Ibu2zqPX0ueEVhmHxkIyeGH
	 5q3eALxDLipv/eMhBpo6HdAxoMXldvlAdDQFzCqJF476IASpFDk++YLfbCX8cv2+4A4Vq
	 j1D2nGPl0tXqF0XCj/jt5RNNJKEsfiNkgjgTuDzq9juhCgdwd+LXLEU9rGD0htty78Bx5
	 39mZu4dJW11gjZLmZWx0Krhf3JduLvzQLPjUGifghsySyYpR/bum97KPj6Z/jh662yg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794374062;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=QmXHPXgAlxr1zhs7QJAhtcbDQd0I0K4rc/xRF7mdzH0=;
	b=ZZ/4XVBO3e43TNxcVdY0jw/kxISS1H2d3p1m5b422nLuKKhe+pwWYhj4jz1zSvTZ5XhO
	 IJ+TKkxlytvx036GW3PDT59UU/3uVc7KkrOuaRHJMbi4zumxzPyYJ/t1tTAH+u+wc1u9z
	 pHrJWjfMTI/zqz5K3jwh1y4itDVbbuwNBtYlL4i5jTpBDbKcDYcc4L5RhgqXmJ1Km+8L5
	 k1MGO1hJ0lrj9VpcNTRPgQIBgrZWFDQfJPdCbboYT3Xmq1kwERBfSkhQBxymBt9y6zfrm
	 IprjZlAyZVvmzSmVUIwoKybwiW7mU5YJt/TXqEuXv0rgubficYivxpP21ztIe/ufC2w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="0vav0/3v";
	arc=none smtp.remote-ip=209.85.210.173
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F01E4606A321
	for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 05:14:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F01E4606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0vav0/3v
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-8a9f9473029so2275164b3a.2
        for <bpf@vger.kernel.org>; Tue, 10 Nov 2026 21:14:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794374061; x=1794978861; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QmXHPXgAlxr1zhs7QJAhtcbDQd0I0K4rc/xRF7mdzH0=;
        b=0vav0/3vw/tBOB9dwmx0cjzp4xVzZNWUGudcQZP/zBG1FuOnzjz3rigsJ0IYqSv792
         H7Fp/LaTr61h4QE98Fy9kYlKVngjCfHSW0TflhKw2ULHNSs9OFzCJO5WaWF5zC4IM0eY
         Rh/u5Jt+JgQiupBBCwNuzwUgz84HUxULEwjXq+aQsE1i+UOHHRWgXofrat4hfoZsBKLC
         nto2ukMERu1aQRY51Z3tlT/m2pAHWGOfXyfD6rrkojUe6u3zW1ICdL1SVw7XStoD7qq9
         ZncjZUU3Xb/qBD7AoDvOnO5z7ROFHxiahqdiIROmoa0Kjh2gh3xQ4gg3fKkREX8B94hP
         zRQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794374061; x=1794978861;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=QmXHPXgAlxr1zhs7QJAhtcbDQd0I0K4rc/xRF7mdzH0=;
        b=UeO8ebxKiQMbHnNw7PoGJ1OKkV65XoTVQ3mxuAWTsFiGRgzdq+s3HmLeN0UQ4J+4Nc
         v+SsBp0Dg/MkG3QlCds2WOHH1PPIJUy/0rGhDTcYi8MsrVNV7TL7RNn588xEOXiR8sP8
         qNTUhIJ5GzLvFs+ioy/8MmkNxja4iniqrD+3/B7rEtb7BMizBwdUEsRBulJQSVvahBz8
         dLEEwDS1WbjUh3JQQSk7dHRnJjq8lB0syrjRiLNP5k3GOGrRzSN3daighkf6mdNY916F
         1p/RdxmzNw3vG1Nu8RKcKXXtRNNzztjK6N0mc4r+EIHGRU2W+cIW2zVAcyBxxvbnX3+s
         MN6A==
X-Gm-Message-State: APuU4Z+Ywje4MqJdYcN9rGJWqjHAvPgEhG2+XKzbS1i/A8rfGv8uEzRR
	/Zm3OxdMOqiXPJ3pwKwd5alr2tLhDfvP019elFCBNEwX73YakBmNFxejaMDZ0Q==
X-Gm-Gg: AYBFou0m9ZYMKkED88ZDHsuCBfQO3yjVhiOMQsIzNB82LbDHH7SNxItsuuQTge5X1fP
	aF3BuFo2kjSbELWsX43FsEv6NqhtpOmoX/rqFYebtSMWaNVGLeMH9rnnT4A4XBxVXsCgrXfToQN
	qcwyGNpUSexQxM1gQO2wBnJUNZV1++jjoJnIQfk4GohqIBASqEP92ene0NJ3cM+iH/LhpeYQBIv
	VVOiMcjnHLj2NSbtT/LdIckB5Y5JHMMfdoazM/4R/zrbqtL5dpYl7sDVSsNXWG4gRTAkpECm+Z+
	KY2lHq67nCNQzvb4HsI9y3KH0jsbu3JQBCsKVmzNJ8NYwonWs0Eo3xoRJuCNCIZH36ZJn9rCS3/
	v8YGqB/sZQiuYbwYJPk7HRGY7Fv/abXFb6EAsq3KjmCRiQac6NNuZcDY7meC5uxb65SpWjQEnqS
	fW75wPqE+wpYFIIeWVyonvc1CXb+Fwfzdg0Rk95uAXAsU1MXOUP4L3P4bGLRFq/sLUM1qGFlvAx
	w0Ayc0on4KBmfN+O4COlsKPiah7UslcJzHawaF/yitZZF6ibt59ZG53ZQncKjsiwSrzHlJFBRQV
	HO5gw4236QKllYZkVoTGPW3r+hDdnPsKOecImCYslQRVWIsI8PwAYmFv5pOdfXNZrreVT/wzAsT
	RZID249zqwOWRArRf+eOzcsKxxLFHAcZ2ICUQDJaHCAfRiirGuj9gPchKTosojqTDXQrxY0ZbBg
	==
X-Received: by 2002:a05:6a00:4c17:b0:880:78ca:8400 with SMTP id d2e1a72fcca58-8bc1b606284mr1499779b3a.12.1794374060771;
        Tue, 10 Nov 2026 21:14:20 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.255])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8baaad41578sm1763020b3a.32.2026.11.10.21.14.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 21:14:20 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next v2 06/29] bpf: Give SSA names to the values that scalar evolution does not track
Date: Wed, 11 Nov 2026 05:13:17 +0000
Message-ID: <20261111051341.2800252-7-alexei.starovoitov@gmail.com>
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

A prerequisite of the patch that refines linked registers at conditional
jumps: it turns the id of an expression into a value number. No users yet,
no verdict changes.

	i = v->idx;
	j = i;
	if (i > 100)
		return 0;
	use(buf[j]);

i and j hold the same value. The verifier knows it from the scalar id that
'j = i' assigns to both registers in a state. Scalar evolution could decide
it statically, by comparing two expression ids. But a loaded value is '_',
the result of a call is '_' too, and a value that is not tracked is '?'.
All loads have the same id, so the same id in two registers is not the same
value. Nor at a join point: 'x = c ? 1 : 2' and 'y = d ? 1 : 2' are
(any 1 2).

Give such a value an SSA name, struct expr_def: the def of a register or
stack slot by the insn at idx, or by a phi before the insn at idx, a join
point. forget_reg() makes the defs, join() the phis. struct expr has four
bytes of padding for it. The level 2 log prints '%', the register or stack
slot, '.', idx, and for a phi its operands:

	1: call bpf_get_prandom_u32    r0 is %r0.1
	2: r6 = r0                     r6 is %r0.1: the same value
	5: call bpf_get_prandom_u32    r0 is %r0.5
	7: join point                  r0 is %r0.7=phi(_)
	                               r8 is %r8.7=phi(1, 2)

The op of %r0.1 is '_', a trailing '?' says that it is '?'. phi(_) joins
distinct '_', phi(?) distinct '?' or more than 8 values. A def is printed
in full at every use: 'r0 += r8' at 7 is (+ %r0.7=phi(_) %r8.7=phi(1, 2)).

Where it differs from SSA in a compiler:

- Only a value that no expression describes gets a name. With a def, '?'
  and '_' are what LLVM calls SCEVUnknown: a leaf that stands for one
  value. Without a def '?' is SCEVCouldNotCompute.
- An insn that may write defines too (may_def in liveness.c, a MemoryDef in
  MemorySSA): insn 8 may write fp-8, %fp-8.8? is what the slot holds after
  it. A nested loop defines at its header what it leaves.
- The operands of a phi are a set, 8 at most, and have no defs:
  'if (c) sum += a[i]; else sum += b[i];' is %r6.9=phi((+ r6 _)), not
  phi((+ r6 %r2.4), (+ r6 %r2.7)). Every phi is a value number of its own.
  A later patch finds the congruent ones.
- Without its backedges and with nested loops collapsed the body of a loop
  is acyclic: an insn executes at most once per iteration, so a def is one
  value per iteration. A name is unique within the env of one loop.
- In the env of loop H a phi at H merges the backedge values only (the phi
  of the single latch that LoopSimplify would make). The header phi itself
  is (REG r). 'r6=%r6.1=phi(r6, (+ r6 1)) / ?' at header 1 is not {r6,+,1}:
  one backedge keeps r6, the other one adds 1.

def.phi is not only for the log. r0 before an insn and after it are
distinct values, so it is a part of the name. And later patches look
through the op of a def, which the insn at idx computed, but not through
a phi, whose op is what the joined values have in common.

Op and operands stay. A def tells one load from another. The code that
analyzes loops asks how a value is computed, and that is the same on the
two paths above. So strip_defs() takes the defs out of the operands of
a phi, all the way down, and that code matches what it matched.

struct expr::is_vn says that an id is a value number: all registers and
stack slots of an env that have it hold the same value. That is (REG r),
a constant, a def, an operation on such.

28 expected messages of verifier_scev.c follow the notation: 'r7=?' becomes
'r7=%r7.4?', 'r7=(any r7 100)' becomes 'r7=%r7.6=phi(r7, 100)'. The new
test phi_operands_have_no_defs has the sum above.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/scev.c                             | 339 ++++++++++++++----
 .../selftests/bpf/progs/verifier_scev.c       |  87 +++--
 2 files changed, 333 insertions(+), 93 deletions(-)

diff --git a/kernel/bpf/scev.c b/kernel/bpf/scev.c
index 4f02cd62305c..5fb31d6be97e 100644
--- a/kernel/bpf/scev.c
+++ b/kernel/bpf/scev.c
@@ -52,8 +52,39 @@ enum expr_op {
 	COPY_SCEV,
 };
 
+/*
+ * An SSA name for a value that no expression describes: the def of the SCEV register 'reg'
+ * - by the insn at 'idx'. An insn that may write defines too (may_def in liveness.c). A nested loop
+ *   defines at its header what it leaves.
+ * - by a phi before the insn at 'idx': a join point, a loop header.
+ * Without its backedges and with nested loops collapsed the body of a loop is acyclic: an insn
+ * executes at most once per iteration, so a def is one value per iteration. A name is unique within
+ * the env of one loop.
+ * The operands of a phi are a set, 8 at most; a phi(a, b) among them is expanded. They have no
+ * defs, see strip_defs(): (+ r6 %r2.4) and (+ r6 %r2.7) are one operand, (+ r6 _). Every phi is
+ * a value number of its own.
+ * In the env of loop H a phi at H merges the backedge values only, the header phi itself is
+ * (REG r). In the env of the enclosing loop a phi at H merges the entering edges.
+ */
+struct expr_def {
+	u32 set:1;	/* 0: the expression has no def */
+	u32 phi:1;
+	u32 reg:9;
+	u32 idx:21;
+};
+static_assert(REGS_NUM <= 1 << 9 && BPF_COMPLEXITY_LIMIT_INSNS <= 1 << 21);
+
+static const struct expr_def no_def;
+
 struct expr {
-	u32 op;
+	u16 op;
+	/* A value number: all SCEV registers of an env that have this id hold the same value */
+	bool is_vn;
+	/*
+	 * UNKNOWN, OPAQUE and ANY don't describe a value. With a def the id stands for one value,
+	 * see struct expr_def. Without a def every use of the id can be another value.
+	 */
+	struct expr_def def;
 	union {
 		u32 params[2];
 		s64 imm;
@@ -116,12 +147,19 @@ struct scev {
 
 static u32 expr_hash(struct expr *e)
 {
-	return jhash_3words(e->op, e->params[0], e->params[1], 0);
+	/* def.phi is not hashed: the def by an insn and the phi before it share a chain */
+	return jhash_3words(e->op, e->params[0], e->params[1],
+			    e->def.idx * REGS_NUM + e->def.reg);
+}
+
+static bool same_def(struct expr_def a, struct expr_def b)
+{
+	return a.set == b.set && a.phi == b.phi && a.reg == b.reg && a.idx == b.idx;
 }
 
 static int expr_eq(struct expr *a, struct expr *b)
 {
-	return a->op == b->op && a->imm == b->imm;
+	return a->op == b->op && a->imm == b->imm && same_def(a->def, b->def);
 }
 
 static void exprs_ht_add(struct scev *scev, u32 id)
@@ -158,12 +196,41 @@ static int grow_exprs(struct scev *scev, u32 cap)
 	return 0;
 }
 
+static u32 op_params_num(u32 op);
+
+static bool expr_is_vn(struct scev *scev, struct expr *e)
+{
+	u32 i;
+
+	if (e->def.set)
+		return true;
+	switch (e->op) {
+	case UNKNOWN:
+	case OPAQUE:
+	case ANY:
+	/* a partial spill: the other bits of the slot are not known */
+	case SPILL8:
+	case SPILL16:
+	case SPILL32:
+	/* a function of the iteration number */
+	case LINEAR_SCEV:
+	case COPY_SCEV:
+		return false;
+	}
+	for (i = 0; i < op_params_num(e->op); i++)
+		if (!scev->exprs[e->params[i]].is_vn)
+			return false;
+	return true;
+}
+
 static int add_expr(struct scev *scev, struct expr e)
 {
 	u32 id;
 
 	if (e.op == REG)
 		return REG_EXPR_ID(e.params[0]);
+	if (!e.def.set && !e.imm && (e.op == UNKNOWN || e.op == OPAQUE))
+		return e.op == UNKNOWN ? UNKNOWN_EXPR_ID : OPAQUE_EXPR_ID;
 
 	id = scev->exprs_ht[expr_hash(&e) & (scev->exprs_cap - 1)];
 	for (; id; id = scev->exprs_next[id])
@@ -174,6 +241,7 @@ static int add_expr(struct scev *scev, struct expr e)
 		return -ENOMEM;
 
 	id = scev->exprs_cnt++;
+	e.is_vn = expr_is_vn(scev, &e);
 	scev->exprs[id] = e;
 	exprs_ht_add(scev, id);
 	return id;
@@ -217,6 +285,33 @@ static int imm_expr(struct scev *scev, s64 value)
 	return add_expr(scev, (struct expr){ .op = IMM, .imm = value });
 }
 
+/*
+ * The insn at @idx defines @reg. Without its backedges and with nested loops collapsed the body is
+ * acyclic: an insn executes at most once per iteration, so a def is one value per iteration.
+ */
+static struct expr_def insn_def(int idx, u32 reg)
+{
+	return (struct expr_def){ .set = 1, .reg = reg, .idx = idx };
+}
+
+/* The phi of @reg before the insn at @idx. One value per iteration for the same reason. */
+static struct expr_def phi_def(int idx, u32 reg)
+{
+	return (struct expr_def){ .set = 1, .phi = 1, .reg = reg, .idx = idx };
+}
+
+/* @id with another def */
+static int expr_with_def(struct scev *scev, int id, struct expr_def def)
+{
+	struct expr e;
+
+	if (id < 0)
+		return id;
+	e = scev->exprs[id];
+	e.def = def;
+	return add_expr(scev, e);
+}
+
 static bool same_exprs(struct scev *scev, int id_a, int id_b)
 {
 	return id_a == id_b;
@@ -486,27 +581,69 @@ static bool expr_next(struct scev *scev, u32 *id, u32 *order)
 	return expr_next(scev, id, order);
 }
 
+/*
+ * An SSA name is printed as '%', the SCEV register, '.', the insn. A def is printed in full at
+ * every use: (+ %r8.7=phi(1, 2) 4).
+ *	%r0.6			insn 6 defines r0. The value is OPAQUE, '_' without a def
+ *	%fp-8.8?		insn 8 may write fp-8. The value is UNKNOWN, '?' without a def
+ *	%r8.7=phi(1, 2)		the phi of r8 before insn 7
+ *	%r0.7=phi(_)		a phi of distinct OPAQUE values
+ *	%r6.9=phi(?)		a phi of distinct UNKNOWN values, or of more than 8 values
+ * A name is unique within the env of one loop. In the env of loop H a phi at H merges the backedge
+ * values only, the header phi itself is (REG r): in 'scev at header 1: r6=%r6.1=phi(r6, (+ r6 1))'
+ * one backedge leaves r6 as it is, the other one adds 1.
+ * '%' in front of r or fp is a name, followed by a blank it is BPF_MOD.
+ */
+static void log_def(struct bpf_verifier_env *env, struct expr_def def)
+{
+	if (!def.set)
+		return;
+	if (def.reg < MAX_BPF_REG)
+		bpf_log(&env->log, "%%r%d.%d", def.reg, def.idx);
+	else
+		bpf_log(&env->log, "%%fp%d.%d", (MAX_BPF_REG - def.reg - 1) * 8, def.idx);
+}
+
 static void log_expr(struct bpf_verifier_env *env, u32 id)
 {
 	struct bpf_verifier_log *log = &env->log;
+	bool operand, bare, first = false;
 	struct scev *scev = env->scev;
+	u32 order, d, bare_any = 0;
+	struct expr_def def;
 	struct expr *expr;
 	const char *str;
-	u32 order;
 
 	scev->stack_sz = 0;
 	expr_stack_push(scev, id);
 	while (expr_next(scev, &id, &order)) {
-		if ((order & PRE) && scev->stack_sz > 1)
-			bpf_log(log, " ");
 		expr = &scev->exprs[id];
+		def = expr->def;
+		/* the depth of @id in expr_stack[], expr_next() pops it before POST */
+		d = order & PRE ? scev->stack_sz - 1 : scev->stack_sz;
+		operand = d && (bare_any & BIT(d - 1));
+		/* No '(any' for the operands of phi(a, b). (any a b) among them is expanded. */
+		if (order & PRE) {
+			bare_any &= ~BIT(d);
+			if (expr->op == ANY && (def.set ? def.phi : operand))
+				bare_any |= BIT(d);
+		}
+		bare = bare_any & BIT(d);
+		if ((order & PRE) && (def.set || !bare)) {
+			if (d)
+				bpf_log(log, "%s", !operand ? " " : first ? "" : ", ");
+			log_def(env, def);
+			if (def.phi)
+				bpf_log(log, "=phi(");
+			first = bare;
+		}
 		switch (expr->op) {
 		case UNKNOWN:
 			if (order & PRE)
 				bpf_log(log, "?");
 			break;
 		case OPAQUE:
-			if (order & PRE)
+			if ((order & PRE) && (!def.set || def.phi))
 				bpf_log(log, "_");
 			break;
 		case REG:
@@ -518,19 +655,23 @@ static void log_expr(struct bpf_verifier_env *env, u32 id)
 				bpf_log(log, "%lld", expr->imm);
 			break;
 		default:
-			if (order & PRE) {
+			if ((order & PRE) && !bare) {
 				str = op_str(expr->op);
-				bpf_log(log, "(");
+				bpf_log(log, def.set && !def.phi ? "=(" : "(");
 				if (str)
 					bpf_log(log, "%s", str);
 				else
 					bpf_log(log, "bad-expr-op %x", expr->op);
 			}
-			if (order & DEPTH_LIMIT)
-				bpf_log(log, "...");
-			if (order & POST)
+			if (order & DEPTH_LIMIT) {
+				bpf_log(log, bare && !def.set && !first ? ", ..." : "...");
+				first = false;
+			}
+			if ((order & POST) && !bare)
 				bpf_log(log, ")");
 		}
+		if ((order & POST) && def.phi)
+			bpf_log(log, ")");
 	}
 }
 
@@ -570,7 +711,7 @@ static void print_env(struct bpf_verifier_env *env, struct env *e, u32 insn_idx)
 		log_reg(env, i);
 		bpf_log(log, "=");
 		log_expr(env, e->reg2expr[i]);
-		if (e->reg2expr[i] != UNKNOWN_EXPR_ID) {
+		if (!is_op(scev, e->reg2expr[i], UNKNOWN)) {
 			bpf_log(log, " / ");
 			log_expr(env, e->reg2scev[i]);
 		}
@@ -634,6 +775,12 @@ static int replace_reg(struct scev *scev, struct env *e, u32 reg, int id)
 	return 0;
 }
 
+/* The insn at @idx defines @reg. The value is not tracked: @id is UNKNOWN or OPAQUE. */
+static int forget_reg(struct scev *scev, struct env *e, u32 reg, int id, int idx)
+{
+	return replace_reg(scev, e, reg, expr_with_def(scev, id, insn_def(idx, reg)));
+}
+
 static void setup_initial_loop_env(struct env *e)
 {
 	int i;
@@ -648,12 +795,20 @@ static void setup_initial_loop_env(struct env *e)
 		e->reg2expr[i] = REG_EXPR_ID(i);
 }
 
-static void forget_call_regs(struct env *e)
+/* A subprog can return a pair in r0 and r2: a call defines r1 - r5 too if they are live after it */
+static int forget_call_regs(struct bpf_verifier_env *env, struct env *e, int idx)
 {
-	int i;
+	int i, err;
 
-	for (i = BPF_REG_0; i <= BPF_REG_5; i++)
+	for (i = BPF_REG_0; i <= BPF_REG_5; i++) {
 		e->reg2expr[i] = UNKNOWN_EXPR_ID;
+		if (idx + 1 >= env->prog->len || !reg_alive_at(env, i, idx + 1))
+			continue;
+		err = forget_reg(env->scev, e, i, UNKNOWN_EXPR_ID, idx);
+		if (err)
+			return err;
+	}
+	return 0;
 }
 
 static u32 spill_spi(struct bpf_insn *insn)
@@ -673,16 +828,19 @@ static bool is_spill_off(int off)
 	       off >= -MAX_BPF_STACK_JIT;
 }
 
-static void mark_opaque(struct env *e, int off, int size)
+static int mark_opaque(struct scev *scev, struct env *e, int idx, int off, int size)
 {
-	int b, spi;
+	int b, spi, err;
 
 	for (b = off; b < off + size; b++) {
 		if (b >= 0 || b < -MAX_BPF_STACK_JIT)
 			continue;
 		spi = (-b - 1) / BPF_REG_SIZE;
-		e->reg2expr[MAX_BPF_REG + spi] = OPAQUE_EXPR_ID;
+		err = forget_reg(scev, e, MAX_BPF_REG + spi, OPAQUE_EXPR_ID, idx);
+		if (err)
+			return err;
 	}
+	return 0;
 }
 
 static int mk_spill(struct scev *scev, u8 size, int id)
@@ -716,7 +874,7 @@ static int mk_fill(struct scev *scev, int id, u8 code)
 	return UNKNOWN_EXPR_ID;
 }
 
-static int maybe_store_fp(struct scev *scev, struct env *e, struct bpf_insn *insn, int id)
+static int maybe_store_fp(struct scev *scev, struct env *e, struct bpf_insn *insn, int idx, int id)
 {
 	u8 size = BPF_SIZE(insn->code);
 
@@ -724,19 +882,15 @@ static int maybe_store_fp(struct scev *scev, struct env *e, struct bpf_insn *ins
 		return 0;
 	if (is_spill_off(insn->off))
 		return replace_reg(scev, e, off_to_reg(insn), mk_spill(scev, size, id));
-	mark_opaque(e, insn->off, bpf_size_to_bytes(size));
-	return 0;
+	return mark_opaque(scev, e, idx, insn->off, bpf_size_to_bytes(size));
 }
 
-static int maybe_load_fp(struct scev *scev, struct env *e, struct bpf_insn *insn)
+static int maybe_load_fp(struct scev *scev, struct env *e, struct bpf_insn *insn, int idx)
 {
-	int id;
-
-	if (insn->src_reg == BPF_REG_FP && is_spill_off(insn->off))
-		id = mk_fill(scev, e->reg2expr[off_to_reg(insn)], insn->code);
-	else
-		id = OPAQUE_EXPR_ID;
-	return replace_reg(scev, e, insn->dst_reg, id);
+	if (insn->src_reg != BPF_REG_FP || !is_spill_off(insn->off))
+		return forget_reg(scev, e, insn->dst_reg, OPAQUE_EXPR_ID, idx);
+	return replace_reg(scev, e, insn->dst_reg,
+			   mk_fill(scev, e->reg2expr[off_to_reg(insn)], insn->code));
 }
 
 /*
@@ -912,30 +1066,34 @@ static int transfer(struct bpf_verifier_env *env, struct env *e, int idx)
 				imm = env->insn_aux_data[idx + 1].const_reg_vals[dst];
 				return replace_reg(scev, e, dst, imm_expr(scev, imm));
 			}
-			return maybe_load_fp(scev, e, insn);
+			return maybe_load_fp(scev, e, insn, idx);
 		default:
 			goto mark_dst_unknown;
 		}
 	case BPF_STX:
 		switch (mode) {
 		case BPF_MEM:
-			return maybe_store_fp(scev, e, insn, reg2expr[src]);
+			return maybe_store_fp(scev, e, insn, idx, reg2expr[src]);
 		case BPF_ATOMIC:
 			if (insn->imm == BPF_LOAD_ACQ)
-				return maybe_load_fp(scev, e, insn);
+				return maybe_load_fp(scev, e, insn, idx);
 			if (insn->imm == BPF_STORE_REL) {
-				return maybe_store_fp(scev, e, insn, reg2expr[src]);
+				return maybe_store_fp(scev, e, insn, idx, reg2expr[src]);
 			}
 			/*
 			 * verifier does not track other atomic ops precisely,
 			 * hence mark the results as opaque.
 			 */
-			if (insn->dst_reg == BPF_REG_FP)
-				mark_opaque(e, insn->off, bpf_size_to_bytes(BPF_SIZE(insn->code)));
+			if (insn->dst_reg == BPF_REG_FP) {
+				id = mark_opaque(scev, e, idx, insn->off,
+						 bpf_size_to_bytes(BPF_SIZE(insn->code)));
+				if (id < 0)
+					return id;
+			}
 			if (insn->imm == BPF_CMPXCHG)
-				return replace_reg(scev, e, BPF_REG_0, OPAQUE_EXPR_ID);
+				return forget_reg(scev, e, BPF_REG_0, OPAQUE_EXPR_ID, idx);
 			if (insn->imm & BPF_FETCH)
-				return replace_reg(scev, e, src, OPAQUE_EXPR_ID);
+				return forget_reg(scev, e, src, OPAQUE_EXPR_ID, idx);
 			break;
 		}
 		break;
@@ -944,15 +1102,17 @@ static int transfer(struct bpf_verifier_env *env, struct env *e, int idx)
 			id = imm_expr(scev, insn->imm);
 			if (id < 0)
 				return id;
-			return maybe_store_fp(scev, e, insn, id);
+			return maybe_store_fp(scev, e, insn, idx, id);
 		}
 		break;
 	case BPF_JMP:
 	case BPF_JMP32:
 		if (opcode == BPF_CALL) {
-			forget_call_regs(e);
+			id = forget_call_regs(env, e, idx);
+			if (id < 0)
+				return id;
 			/* made anew, like what is loaded. The parameter tells the two apart. */
-			return replace_reg(scev, e, BPF_REG_0, expr1(scev, OPAQUE, 1));
+			return forget_reg(scev, e, BPF_REG_0, expr1(scev, OPAQUE, 1), idx);
 		}
 		/* for non-CALL there are no changes in register states */
 		break;
@@ -966,12 +1126,11 @@ static int transfer(struct bpf_verifier_env *env, struct env *e, int idx)
 			}
 			/* map, map value, BTF id, function */
 			if (BPF_SIZE(insn->code) == BPF_DW)
-				return replace_reg(scev, e, dst, OPAQUE_EXPR_ID);
+				return forget_reg(scev, e, dst, OPAQUE_EXPR_ID, idx);
 			goto mark_dst_unknown;
 		case BPF_ABS:
 		case BPF_IND:
-			forget_call_regs(e);
-			break;
+			return forget_call_regs(env, e, idx);
 		default:
 			goto mark_dst_unknown;
 		}
@@ -985,15 +1144,41 @@ static int transfer(struct bpf_verifier_env *env, struct env *e, int idx)
 	return 0;
 
 mark_dst_unknown:
-	reg2expr[dst] = UNKNOWN_EXPR_ID;
-	return 0;
+	return forget_reg(scev, e, dst, UNKNOWN_EXPR_ID, idx);
+}
+
+/*
+ *	if (c) sum += a[i]; else sum += b[i];
+ * @id without defs: (+ r6 %r2.4) -> (+ r6 _). A def tells one load from another. The code that
+ * analyzes loops asks how a value is computed, and that is the same on both paths.
+ * Beyond depth EXPR_STACK_DEPTH an expression keeps its defs: no user looks there.
+ */
+static int strip_defs(struct scev *scev, u32 id, u32 lvl)
+{
+	struct expr e = scev->exprs[id]; /* snapshot the expr before potential realloc */
+	int a;
+
+	switch (op_params_num(e.op)) {
+	case 0:
+		return e.def.set ? expr_with_def(scev, id, no_def) : id;
+	case 1:
+		if (lvl == EXPR_STACK_DEPTH)
+			return id;
+		return expr1(scev, e.op, strip_defs(scev, e.params[0], lvl + 1));
+	default:
+		if (lvl == EXPR_STACK_DEPTH)
+			return id;
+		a = strip_defs(scev, e.params[0], lvl + 1);
+		return expr2(scev, e.op, a, strip_defs(scev, e.params[1], lvl + 1));
+	}
 }
 
 /*
  * Construct minimal 'ANY' expression by traversing 'a' and 'b'
- * and accumulating non-duplicated non-ANY entries.
+ * and accumulating non-duplicated non-ANY entries, without their defs.
+ * 'def' is the def of the result, no_def if it has none.
  */
-static int mk_any(struct scev *scev, int a, int b)
+static int mk_any(struct scev *scev, int a, int b, struct expr_def def)
 {
 	struct expr_stack_elt *elt;
 	struct expr *expr;
@@ -1016,14 +1201,18 @@ static int mk_any(struct scev *scev, int a, int b)
 			if (expr->op == ANY) {
 				if (!expr_stack_push(scev, expr->params[1]) ||
 				    !expr_stack_push(scev, expr->params[0]))
-					return UNKNOWN_EXPR_ID;
+					return expr_with_def(scev, UNKNOWN_EXPR_ID, def);
 			} else {
-				for (j = 0; j < ids_buf_sz; j++) {
+				/* the operands of an ANY have no defs already */
+				if (id == roots[i])
+					id = strip_defs(scev, id, 0);
+				if (id < 0)
+					return id;
+				for (j = 0; j < ids_buf_sz; j++)
 					if (same_exprs(scev, scev->ids_buf[j], id))
 						goto next;
-				}
 				if (ids_buf_sz == ARRAY_SIZE(scev->ids_buf))
-					return UNKNOWN_EXPR_ID;
+					return expr_with_def(scev, UNKNOWN_EXPR_ID, def);
 				scev->ids_buf[ids_buf_sz++] = id;
 			}
 next:;
@@ -1037,7 +1226,7 @@ next:;
 		if (id < 0)
 			return id;
 	}
-	return id;
+	return expr_with_def(scev, id, def);
 }
 
 /* @acc is the env before the insn at @idx */
@@ -1056,7 +1245,8 @@ static int join(struct bpf_verifier_env *env, struct env *acc, struct env *cur,
 		if (!same_exprs(scev, acc->reg2expr[i], cur->reg2expr[i])) {
 			/* no phi for a dead register: pruned SSA */
 			id = reg_alive_at(env, i, idx) ?
-			     mk_any(scev, acc->reg2expr[i], cur->reg2expr[i]) : UNKNOWN_EXPR_ID;
+			     mk_any(scev, acc->reg2expr[i], cur->reg2expr[i],
+				    phi_def(idx, i)) : UNKNOWN_EXPR_ID;
 			if (id < 0)
 				return id;
 			acc->reg2expr[i] = id;
@@ -1078,12 +1268,12 @@ static void forget_modified_regs(struct scev *scev, struct env *acc, struct env
 }
 
 /* For a loop H at `header`, mark any register modified as a result of H execution as unknown. */
-static void forget_non_invariants(struct bpf_verifier_env *env, struct env *acc, int header)
+static int forget_non_invariants(struct bpf_verifier_env *env, struct env *acc, int header)
 {
 	struct bpf_insn_aux_data *aux = env->insn_aux_data;
 	struct bpf_loop *loop = aux[header].loop;
 	struct scev *scev = env->scev;
-	int i, idx, h;
+	int i, idx, h, err;
 
 	acc->empty = false;
 	forget_modified_regs(scev, acc, find_header_env(scev, header));
@@ -1120,6 +1310,15 @@ static void forget_non_invariants(struct bpf_verifier_env *env, struct env *acc,
 		 */
 		forget_modified_regs(scev, acc, find_loop_env(scev, header, idx));
 	}
+	/* the nested loop defines them at its header */
+	for (i = 0; i < REGS_NUM; i++) {
+		if (acc->reg2expr[i] != UNKNOWN_EXPR_ID)
+			continue;
+		err = forget_reg(scev, acc, i, UNKNOWN_EXPR_ID, header);
+		if (err)
+			return err;
+	}
+	return 0;
 }
 
 /* Order worklist in reverse post-order. */
@@ -1236,7 +1435,7 @@ static bool is_probe_read_helper(u32 func_id)
  * If instruction is an indirect write to stack, invalidate SCEVs for spi's
  * that this instruction can touch.
  */
-static void reset_scevs_at_indirect_writes(struct bpf_verifier_env *env, struct env *cur_env, int idx)
+static int reset_scevs_at_indirect_writes(struct bpf_verifier_env *env, struct env *cur_env, int idx)
 {
 	struct bpf_insn *insn = &env->prog->insnsi[idx];
 	struct scev *scev = env->scev;
@@ -1244,19 +1443,24 @@ static void reset_scevs_at_indirect_writes(struct bpf_verifier_env *env, struct
 	const unsigned long *mask;
 	u32 spi, reg;
 	bool opaque;
+	int err;
 
 	/* Direct fp stores are fine. */
 	if ((class == BPF_ST || class == BPF_STX) && insn->dst_reg == BPF_REG_FP)
-		return;
+		return 0;
 
 	mask = bpf_may_write_mask(env, idx);
 	opaque = bpf_helper_call(insn) && is_probe_read_helper(insn->imm);
 	for_each_set_bit(spi, mask, MAX_BPF_STACK_SLOTS) {
 		reg = MAX_BPF_REG + spi;
-		if (cur_env->reg2expr[reg] == UNKNOWN_EXPR_ID)
-			continue;
-		replace_reg(scev, cur_env, reg, opaque ? OPAQUE_EXPR_ID : UNKNOWN_EXPR_ID);
+		/* '?' stays '?' */
+		err = forget_reg(scev, cur_env, reg,
+				 opaque && !is_op(scev, cur_env->reg2expr[reg], UNKNOWN) ?
+				 OPAQUE_EXPR_ID : UNKNOWN_EXPR_ID, idx);
+		if (err)
+			return err;
 	}
+	return 0;
 }
 
 /*
@@ -1486,7 +1690,9 @@ static int compute_scev_for_loop(struct bpf_verifier_env *env, int cur_header)
 			/* And what its jumps depend on. */
 			for_each_set_bit(r, nested_loop->tested_regs, BPF_SCEV_REGS_NUM)
 				or_expr_regs(env, cur_env->reg2expr[r], cur_loop->tested_regs);
-			forget_non_invariants(env, cur_env, idx);
+			err = forget_non_invariants(env, cur_env, idx);
+			if (err)
+				goto out;
 			if (log_level2)
 				log_env_changes(env, LOG_AT_TRANSFER, old_env, cur_env, idx);
 			/*
@@ -1512,7 +1718,9 @@ static int compute_scev_for_loop(struct bpf_verifier_env *env, int cur_header)
 				err = transfer(env, cur_env, idx);
 				if (err)
 					goto out;
-				reset_scevs_at_indirect_writes(env, cur_env, idx);
+				err = reset_scevs_at_indirect_writes(env, cur_env, idx);
+				if (err)
+					goto out;
 				if (log_level2)
 					log_env_changes(env, LOG_AT_TRANSFER, old_env, cur_env, idx);
 				succ = bpf_insn_successors(env, idx);
@@ -1778,7 +1986,7 @@ static int compute_header_scevs(struct bpf_verifier_env *env, struct env *header
 		}
 		/* rA = (any 1 2 3 4 ...) -> (any rA 1 2 3 4 ...) */
 		if (is_any_imm_reg_opaque(scev, ra_expr)) {
-			id = mk_any(scev, expr1(scev, REG, ra), ra_expr);
+			id = mk_any(scev, expr1(scev, REG, ra), ra_expr, no_def);
 			if (id < 0)
 				return id;
 			header_env->reg2scev[ra] = id;
@@ -2022,7 +2230,8 @@ int bpf_init_scev(struct bpf_verifier_env *env)
 	scev->exprs[UNKNOWN_EXPR_ID] = (struct expr){ .op = UNKNOWN };
 	scev->exprs[OPAQUE_EXPR_ID] = (struct expr){ .op = OPAQUE };
 	for (r = 0; r < REGS_NUM; r++)
-		scev->exprs[REG_EXPR_ID(r)] = (struct expr){ .op = REG, .params = { r, 0 } };
+		scev->exprs[REG_EXPR_ID(r)] = (struct expr){ .op = REG, .is_vn = true,
+							     .params = { r, 0 } };
 	scev->exprs_cnt = REG_EXPR_ID(REGS_NUM);
 	scev->envs = kvcalloc(env->prog->len, sizeof(*scev->envs), GFP_KERNEL_ACCOUNT);
 	scev->discovered = kvcalloc(env->prog->len, sizeof(*scev->discovered), GFP_KERNEL_ACCOUNT);
diff --git a/tools/testing/selftests/bpf/progs/verifier_scev.c b/tools/testing/selftests/bpf/progs/verifier_scev.c
index 3d73a7107cba..cab2fe974d44 100644
--- a/tools/testing/selftests/bpf/progs/verifier_scev.c
+++ b/tools/testing/selftests/bpf/progs/verifier_scev.c
@@ -135,7 +135,7 @@ exit_%=:						\
 SEC("xdp")
 __success
 __log_level(2)
-__msg("8: (7b) *(u64 *)(r1 +0) = r0     ; *fp-8 (+ *fp-8 1) -> ?")
+__msg("8: (7b) *(u64 *)(r1 +0) = r0     ; *fp-8 (+ *fp-8 1) -> %fp-8.8?")
 __naked void indirect_write_invalidates_scev(void)
 {
 	asm volatile ("					\
@@ -165,7 +165,7 @@ __noinline int global_noop_counter(__u64 *p)
 SEC("xdp")
 __success
 __log_level(2)
-__msg("8: (85) call pc+{{[0-9]+}} {{.*}}; *fp-8 (+ *fp-8 1) -> ?")
+__msg("8: (85) call pc+{{[0-9]+}} {{.*}}; *fp-8 (+ *fp-8 1) -> %fp-8.8?")
 __naked void global_call_invalidates_scev(void)
 {
 	asm volatile (
@@ -242,7 +242,7 @@ SEC("xdp")
 __success __retval(0)
 __log_level(2)
 __msg_next("scev at header 1:")
-__msg_next("  r6=(any r6 (+ r6 1)) / ?")
+__msg_next("  r6=%r6.1=phi(r6, (+ r6 1)) / ?")
 __naked void meet_disagrees(void)
 {
 	asm volatile ("					\
@@ -261,6 +261,37 @@ __naked void meet_disagrees(void)
 	: __clobber_all);
 }
 
+/* 'if (c) sum += a; else sum += b;': two loads, one way to compute the sum */
+SEC("socket")
+__success
+__log_level(2)
+__msg("scev at header 3:")
+__msg_next("  r6=%r6.9=phi((+ r6 _)) / ?")
+__naked void phi_operands_have_no_defs(void)
+{
+	asm volatile ("					\
+	r9 = r1;					\
+	r6 = 0;						\
+	r7 = 0;						\
+1:							\
+	if r7 & 1 goto 2f;				\
+	r2 = *(u32 *)(r9 + %[len]);			\
+	r6 += r2;					\
+	goto 3f;					\
+2:							\
+	r2 = *(u32 *)(r9 + %[mark]);			\
+	r6 += r2;					\
+3:							\
+	r7 += 1;					\
+	if r7 < 10 goto 1b;				\
+	r0 = r6;					\
+	exit;						\
+"	:
+	: __imm_const(len, offsetof(struct __sk_buff, len)),
+	  __imm_const(mark, offsetof(struct __sk_buff, mark))
+	: __clobber_all);
+}
+
 /* Both entry state values for r1 should be accounted for */
 SEC("xdp")
 __success
@@ -538,13 +569,13 @@ __msg("store_release((u8 *)(r10 -8), r1) {{.*}}; *fp-8 -8 -> (spill8 1)")
 __msg("store_release((u16 *)(r10 -8), r1) {{.*}}; *fp-8 -8 -> (spill16 1)")
 __msg("store_release((u32 *)(r10 -8), r1) {{.*}}; *fp-8 -8 -> (spill32 1)")
 __msg("store_release((u64 *)(r10 -8), r1) {{.*}}; *fp-8 -8 -> 1")
-__msg("lock *(u64 *)(r10 -8) += r1 {{.*}}; *fp-8 -8 -> _")
-__msg("r1 = atomic64_fetch_add((u64 *)(r10 -8), r1) {{.*}}; r1 1 -> _, *fp-8 -8 -> _")
-__msg("r1 = atomic_fetch_add((u32 *)(r10 -8), r1) {{.*}}; r1 1 -> _, *fp-8 -8 -> _")
-__msg("r1 = atomic64_xchg((u64 *)(r10 -8), r1) {{.*}}; r1 1 -> _, *fp-8 -8 -> _")
-__msg("r0 = atomic64_cmpxchg((u64 *)(r10 -8), r0, r2) {{.*}}; r0 0 -> _, *fp-8 -8 -> _")
+__msg("lock *(u64 *)(r10 -8) += r1 {{.*}}; *fp-8 -8 -> %fp-8.{{[0-9]+}}")
+__msg("r1 = atomic64_fetch_add((u64 *)(r10 -8), r1) {{.*}}; r1 1 -> %r1.{{[0-9]+}}, *fp-8 -8 -> %fp-8.{{[0-9]+}}")
+__msg("r1 = atomic_fetch_add((u32 *)(r10 -8), r1) {{.*}}; r1 1 -> %r1.{{[0-9]+}}, *fp-8 -8 -> %fp-8.{{[0-9]+}}")
+__msg("r1 = atomic64_xchg((u64 *)(r10 -8), r1) {{.*}}; r1 1 -> %r1.{{[0-9]+}}, *fp-8 -8 -> %fp-8.{{[0-9]+}}")
+__msg("r0 = atomic64_cmpxchg((u64 *)(r10 -8), r0, r2) {{.*}}; r0 0 -> %r0.{{[0-9]+}}, *fp-8 -8 -> %fp-8.{{[0-9]+}}")
 __msg("*(u64 *)(r10 -8) = 42 {{.*}}; *fp-8 -8 -> 42")
-__msg("*(u8 *)(r10 -7) = r0 {{.*}}; *fp-8 -8 -> _")
+__msg("*(u8 *)(r10 -7) = r0 {{.*}}; *fp-8 -8 -> %fp-8.{{[0-9]+}}")
 #if __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
 /* a fill that is not wider than the spill reads what was spilled */
 __msg("r1 = *(s8 *)(r10 -8) {{.*}}; r1 r7 -> (sext8 r7)")
@@ -617,10 +648,10 @@ __success
 __log_level(2)
 __msg_next("scev at header 1:")
 __msg_next("  r6=(+ r6 1) / (linear r6 1)")
-__msg_next("  r7=?")
+__msg_next("  r7=%r7.4?")
 __msg_next(" scev at latch 1:")
 __msg_next("  r6=(+ r6 1) / (linear r6 1)")
-__msg_next("  r7=?")
+__msg_next("  r7=%r7.4?")
 __msg_next("scev at header 4:")
 __msg_next("  r7=(+ r7 1) / (linear r7 1)")
 __msg_next(" scev at latch 4:")
@@ -657,7 +688,7 @@ __msg_next("  backedge from 6, latch at 4")
 __msg_next("  exit from 4 to 1")
 __msg("scev at header 1:")
 __msg_next("  r6=(+ r6 1) / (linear r6 1)")
-__msg_next("  r7=?")
+__msg_next("  r7=%r7.4?")
 __msg_next("scev at header 4:")
 __msg_next("  r7=(+ r7 1) / (linear r7 1)")
 __msg_next(" scev at latch 4:")
@@ -702,7 +733,7 @@ __msg_next("  backedge from 5, latch at 5")
 __msg_next("  exit from 4 to 2")
 __msg_next("  exit from 5 to 6")
 __msg("scev at header 2:")
-__msg_next("  r6=?")
+__msg_next("  r6=%r6.3?")
 __msg_next("  r7=(+ r7 1) / (linear r7 1)")
 __msg_next("scev at header 3:")
 __msg_next("  r6=(+ r6 1) / (linear r6 1)")
@@ -737,8 +768,8 @@ __log_level(2)
 __flag(BPF_F_TEST_STATE_FREQ)
 __msg("loop at 3{{$}}")
 __msg("scev at header 3:")
-__msg_next("  r6=(any r6 (+ r6 1)) / ?")
-__msg_next("  r7=(any (+ r7 1) 0) / ?")
+__msg_next("  r6=%r6.3=phi(r6, (+ r6 1)) / ?")
+__msg_next("  r7=%r7.3=phi((+ r7 1), 0) / ?")
 __msg_next("  r8=(+ r8 1) / (linear r8 1)")
 __msg("loop header at 3, can't compute iterations count")
 __naked void nested_loops_shared_header(void)
@@ -1539,7 +1570,7 @@ __success __retval(7)
 __log_level(2)
 __msg("scev at header 1:")
 __msg_next("r6=(+ r6 1) / (linear r6 1)")
-__msg_next("*fp-8=(any *fp-8 7) / (any *fp-8 7)")
+__msg_next("*fp-8=%fp-8.3=phi(*fp-8, 7) / (any *fp-8 7)")
 __msg("loop header at 1, widening r6 to 0..2 step 1")
 __msg("3: (79) r0 = *(u64 *)(r10 -8)         ; R0=scalar() R10=fp0 loop_stack=1")
 __naked void widen_any_unallocated_slot(void)
@@ -1580,7 +1611,7 @@ __success __retval(7)
 __log_level(2)
 __msg("scev at header 2:")
 __msg_next("r6=(+ r6 1) / (linear r6 1)")
-__msg_next("*fp-8=(any *fp-8 7) / (any *fp-8 7)")
+__msg_next("*fp-8=%fp-8.5=phi(*fp-8, 7) / (any *fp-8 7)")
 __msg("loop header at 2, widening r6 to 0..2 step 1")
 __msg("3: (79) r1 = *(u64 *)(r10 -8)         ; R1=scalar() R10=fp0 fp-8=m???????")
 __naked void widen_any_misc_slot(void)
@@ -1683,7 +1714,7 @@ __success
 __log_level(2)
 __msg("scev at header 4:")
 __msg_next("  r6=(+ r6 1) / (linear r6 1)")
-__msg_next("  *fp-8=?")
+__msg_next("  *fp-8=%fp-8.7?")
 __msg("loop header at 4, widening r6 to 0..9 step 1")
 __naked void widen_subprog_probe_read(void)
 {
@@ -2604,7 +2635,7 @@ __msg("loop at 1{{$}}")
 __msg("loop at 5, nested in 1, irreducible")
 __msg("loop at 11, nested in 5")
 __msg("scev at header 1:")
-__msg_next("  r6=?")
+__msg_next("  r6=%r6.5?")
 __msg("scev at header 11:")
 __msg_next("  r9=(+ r9 1) / (linear r9 1)")
 __msg("loop header at 11, widening r9 to 0..2 step 1")
@@ -2851,7 +2882,7 @@ __success
 __log_level(2)
 __msg("scev at header 2:")
 __msg_next("  r6=(+ r6 1) / (linear r6 1)")
-__msg_next("  r7=(any r7 100) / (any r7 100)")
+__msg_next("  r7=%r7.6=phi(r7, 100) / (any r7 100)")
 __msg_next(" scev at latch 3:")
 __msg_next("  r6=(+ r6 1) / (linear (+ r6 1) 1)")
 __msg_next("  r7=r7 / (any r7 100)")
@@ -3126,12 +3157,12 @@ __naked void name(void)								\
 #define NOT_UNROLLED	"widening r6 to 0..0xf423f step 1"
 
 /* 'if (...) cnt++' */
-PARTIAL_SPILL_TEST(partial_spill32_inc, u32, 10, "can't widen *fp-8, expr is (any *fp-8 (spill32 ",
+PARTIAL_SPILL_TEST(partial_spill32_inc, u32, 10, "can't widen *fp-8, expr is %fp-8.{{[0-9]+}}=phi(*fp-8, (spill32 ",
 	SPILL32_0, "if r6 & 1 goto 2f;" SPILL32_INC "2:")
 PARTIAL_SPILL_TEST(partial_spill16_inc, u16, 10, "can't widen *fp-8, expr is (spill16 ",
 	"*(u16 *)(r10 - 8) = r1;", "r1 = *(u16 *)(r10 - 8); w1 += 1; *(u16 *)(r10 - 8) = r1;")
 /* A loop in the loop does it */
-PARTIAL_SPILL_TEST(partial_spill32_inc_in_nested_loop, u32, 10, "can't widen *fp-8, expr is ?",
+PARTIAL_SPILL_TEST(partial_spill32_inc_in_nested_loop, u32, 10, "can't widen *fp-8, expr is %fp-8.{{[0-9]+}}?",
 	SPILL32_0, "r7 = 0; 2:" SPILL32_INC "r7 += 1; if r7 < 3 goto 2b;")
 /* Two slots feed each other */
 PARTIAL_SPILL_TEST(partial_spill32_two_slots, u32, 10, "can't widen *fp-8, expr is (spill32 ",
@@ -3296,7 +3327,7 @@ NOT_LINEAR_TEST(zext32_or_nothing, "r7 >>= 8;", "if r8 == 0 goto +1; w7 = w7;",
 NOT_LINEAR_TEST(and_64_to_127, "r7 &= 63; r7 |= 64;", "r7 &= 127;", UNROLLED("(& r7 127)"))
 /* '>>' does not make a number greater, but iterations one by one tell more: 0 after 8 shifts */
 NOT_LINEAR_TEST(rsh_on_one_path, "r7 &= 255;", "if r8 == 0 goto +1; r7 >>= 1;",
-		UNROLLED("(any r7 (>> r7 1))"))
+		UNROLLED("%r7.8=phi(r7, (>> r7 1))"))
 NOT_LINEAR_TEST(rsh_then_and, "r7 &= 255;", "r7 >>= 1; r7 &= r8;", UNROLLED("(& (>> r7 1) r8)"))
 NOT_LINEAR_TEST(lsh_grows, "r7 &= 15;", "r7 <<= 1;", UNROLLED("(<< r7 1)"))
 
@@ -3458,9 +3489,9 @@ __failure
 __log_level(2)
 __flag(BPF_F_TEST_STATE_FREQ)
 __msg("scev at header 9:")
-__msg_next("  r6=(+ ? 1) / ?")
+__msg_next("  r6=(+ %r6.13? 1) / ?")
 __msg_next(" scev at latch 20:")
-__msg_next("  r6=(+ ? 1) / (+ ? 1)")
+__msg_next("  r6=(+ %r6.13? 1) / (+ %r6.13? 1)")
 __msg_next("scev at header 13:")
 __msg_next("  r9=(+ r9 1) / (linear r9 1)")
 __msg_next(" scev at latch 16:")
@@ -3534,7 +3565,7 @@ SEC("xdp")
 __success __retval(3)
 __log_level(2)
 __flag(BPF_F_TEST_STATE_FREQ)
-__msg("r6 = *(u64 *)(r10 -8) {{.*}}; r6 ? -> r6")
+__msg("r6 = *(u64 *)(r10 -8) {{.*}}; r6 %r6.4? -> r6")
 __msg("scev at header 1:")
 __msg_next("  r6=(+ r6 1) / (linear r6 1)")
 __msg_next(" scev at latch 16:")
@@ -3655,7 +3686,7 @@ __success
 __log_level(2)
 __flag(BPF_F_TEST_STATE_FREQ)
 __msg("scev at header 4:")
-__msg_next("r7=(any r7 8) / (any r7 8)")
+__msg_next("r7=%r7.11=phi(r7, 8) / (any r7 8)")
 __msg("loop header at 4, can't widen r7, expr is {{.*}}, requires exact stack-offset tracking")
 __naked void no_widen_stack_fill_any(void)
 {
@@ -4429,7 +4460,7 @@ SEC("socket")
 __success __retval(0)
 __log_level(2)
 __msg("header_count is 100000 ")
-__msg("can't widen r6, expr is _")
+__msg("can't widen r6, expr is %r6.13")
 __not_msg("widening r8")
 __msg("clamping r8 to 0..0x1869f step 1")
 __naked void index_loaded_in_previous_iteration(void)
-- 
2.55.0

