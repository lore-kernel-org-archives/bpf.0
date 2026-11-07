Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794022888;
	b=Lkr83J4qjeIJD2tghI0nhl7GaZ79peViB3kUfNR7xFM6Iwi9uHHOBm6U6eOeh89cNl8R
	 E3b6nC6L6Ckc9dA/rfObjPOqTS+W6whAjaMTQSZDMvWQrIPPcEIly6U+Dg/xxxFiQuO9K
	 j2yKMGfTVqnByD7bxCkacvLkvYqBZP56SDcUgdOkQqd9LYdBkfW/YE8dTVmRgZHYnVCjY
	 AUJuEa4uwZf09oia18D6QF0od7DXwZjS63wZGHnLusMxISsAW9If0RXx0ruUqYVeYl5Ea
	 dh7yziodYM1+0/E1B2JhKByiI8JTbygM8f+zy+ECYMRooL36lh2XOW6fhPGT0gPj6RQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794022888;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=Sv8SapVT9DA70mR/bxXf0Z4dwFgq1lrdZjTs505lfos=;
	b=eA8vMkFPBw0ZcOxb/5XgidbVCI9RxQ+khMi3DjWHwVVzV6m9qKMm+AXSO1frjjgcs7VY
	 ien7KbDL22y2Qt9+xx74UKo0xaHTKqh30KBzDRfbuL6ymgqZi+xghWh89PMrojY9PPFp7
	 BwAViUl9YGh213e187em7g3eJ/1pUlvk6AVghd3OLFWJGorZjG9ezpNqNpxnVtuw2VTox
	 30DwEEze57umXAqput0yB+6j7F7x5or4M+KI1Gd354XpiQnBM3nL8X1Mc5aeXV3T0tiV+
	 p/fTzb1uyKbuQQUDGzZCpehLNUgkTDx5iqeM8w3S64h4I555BEvouyC0KnNmQXRY08g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ohw+0sqy;
	arc=none smtp.remote-ip=209.85.216.51
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BF6B606A326
	for <bpf@vger.kernel.org>; Sat,  7 Nov 2026 03:41:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4BF6B606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ohw+0sqy
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3b0e61a4decso888312a91.2
        for <bpf@vger.kernel.org>; Fri, 06 Nov 2026 19:41:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794022888; x=1794627688; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Sv8SapVT9DA70mR/bxXf0Z4dwFgq1lrdZjTs505lfos=;
        b=Ohw+0sqyAZGj8TOzct7370IUu2FTX9WNL5ltOH7Io6dk3aP8taqgPTHh2res8TeI7u
         oqtQ/NdgSMD2zPIArulNZ4yecSDizmtGmuSJJqweU/rY87Sk8gweYVA8W/zSZD1W/jrQ
         mOeEJzqbFMJDeYpwexoIX7UZV6ml2sBu0KOJSCZ2xIu114LIBA+4HmDiZ09Td5wFNvbJ
         mrs2FfGl4+NKodUYsRvW30wNYMo35szF8Z5ITdaIDZX0Gdfl+DUOS0lKh1QNUPwS4wHG
         7CV+qO39YQ5zl3hQ3VntpElL2tO30hPdIztLAJbxC5XgPH8O60BCw/hgAXztQtfh4KKO
         K5CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794022888; x=1794627688;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Sv8SapVT9DA70mR/bxXf0Z4dwFgq1lrdZjTs505lfos=;
        b=bVZmJshjrmUuVxDBWb12WwzpqCa8itVAlqqeR/W8VyPe9biChFzn22MSUdlP5Rg7/l
         gvhrZBeGe7iMdbU9Ajgt5nECyXQVAZXhXoDDryTGcX+YzfyQ8nxTRkY8z4ioIEz7TsMw
         MpsY+XvcLSnMhPb84XSMMr4E0w5kgaX4T4Ks3vtSzYN9oeK2uADvoX66QADeFuP6Q7aC
         FYtw4F1tOzbFDGLRWG6CXiXCpT8oEJ5h+NXCqRnbH79sf1tUtBsoQnd9YykjwUGE94Zb
         7F6sY5OAZ3Gnv7zOY4nwl+XEY59d3v8LIsP/uoarom5HNIxYBAfOQ+MzoPF4cWdHHpOX
         MwLA==
X-Gm-Message-State: APuU4Z8ONe2CutHDwPnvGA8uDYAg2ewn6SWkdfpbwXfhaHqEPdZlMLUC
	hUJwa7ZTNsmpj4/frRDINoyAhIa+WEU4J8wstnCL2Nb/kNH4QgcVY2KV1wkcYQ==
X-Gm-Gg: AYBFou0QxzudOmLMP6xBBSTRpPoC0rUY6J/js18/bi6bXrN812mSxp9syOb0F0zOZyM
	X/bPCUtpgxneeCaLQNNIanqThbjmZ3isSDlEVWwYWUIAglaoJz7aAz4VF466S44g5Ng6zn87cnB
	wOgFoqP9irKddgU7Lh4GIdU2B8yI+wgXYtRk31CCt+NGW3UQ5+vzGDvSKjPXkd1/cdSDC4FMS2M
	nDzIDmOh5RzrLClv8A54zoH7bsXTlXLabfvs6Z8Bb+9RnCDxL9qfQ1/KafQOfwb7AoJ9FtNi7wW
	gZ+kwDMzCyPeLWIlDphRAKLjnxd5c8JIcwuR/qp09Wjzh+k2b2n0eCBEXSoZxdcHClCA2Df/Y4/
	f8/ybd+SmcG/O8qGjX9ZAFbPoCt2T7sH/PblJYzzblb7z3TysXX3pW7vXdw2h30meXyXe70/8W4
	87b3jP98SSFgmUV/J2g+hGJys7/0GLLFYiJQfLJsutbgva0H2MDEqloPSmi1Zvz1gALoTM3YjFx
	tiMvIUiaEZ+0IsHARPuWgfV8zNuYjboDFCMKjUQuHa+WxNnGFL4bXiviZiJUwG+5VRdqtq3NcI0
	qWN9JppJehfBuLBfbac7o0Hl2uuyKlEImfX+jlyAE3QBDsPZ40J7olBk+1G6pPSD1whW9ZBRydQ
	r6yXK0qvTb28WEHSdoe0EDoTXUC+FHXYyqanAiKtaXOqzbh8v+WzgGxszjnTK7/8CGUWUfzaxcw
	==
X-Received: by 2002:a17:90b:1801:b0:3ab:884b:65b7 with SMTP id 98e67ed59e1d1-3b0db6d3f55mr4513291a91.25.1794022887465;
        Fri, 06 Nov 2026 19:41:27 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.253])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b101ea0282sm797201a91.4.2026.11.06.19.41.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 19:41:27 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next v4 34/46] bpf: Count a loop whose exit tests a copy of the counter
Date: Sat,  7 Nov 2026 03:37:42 +0000
Message-ID: <20261107033758.1547725-35-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261107033758.1547725-1-alexei.starovoitov@gmail.com>
References: <20261107033758.1547725-1-alexei.starovoitov@gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

	u32 i = 0;
	while (buf[i++] && i < 1023)
		;
	return buf[i];

clang keeps what i was before the increment in a second register. The
jump and the load use that one:

	l:   r1 += 1
	     if r2 > 1021 goto out
	     r2 += r0
	     w3 = *(u8 *)(r2 + 0)
	     r2 = r1
	     if w3 != 0 goto l
	out: r0 += r1

Scalar evolution has (linear r1 1) for r1 and nothing for r2, which is
made from another register: the loop has no count. No jump tests r1, so
widening has no stop for it:
  math between map_value pointer and register with unbounded min value

An iteration leaves the same number in r1 and r2. If they are equal when
the loop is entered as well, one constant or one id, r2 is a copy of r1
at the header in every iteration, and what is known about r1 is known
about r2: (copy r2 (linear r1 1)). The jump counts the loop, 1023
iterations, and both registers get their range from the count. They also
get one id, like after 'r2 = r1': what the jump says about r2 bounds r1.

That is true at the header. Behind the jump that counts, where ranges are
one iteration shorter, r1 has moved on: r2 gets its range, and no id. A
register that took the value of r2 on the way, 'r4 = r2', gets nothing:
what r4 was when the loop was entered has nothing to do with it.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/scev.c | 128 ++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 119 insertions(+), 9 deletions(-)

diff --git a/kernel/bpf/scev.c b/kernel/bpf/scev.c
index 64903ab738a0..5415fcf9df2f 100644
--- a/kernel/bpf/scev.c
+++ b/kernel/bpf/scev.c
@@ -43,6 +43,11 @@ enum expr_op {
 	 * bpf_loop_at_index().
 	 */
 	LINEAR_SCEV,
+	/*
+	 * param[1], given that register param[0] and the register that param[1] starts from are
+	 * equal when the loop is entered. Not known otherwise.
+	 */
+	COPY_SCEV,
 };
 
 struct expr {
@@ -259,6 +264,13 @@ static bool is_linear(struct scev *scev, int id, u32 *base, u32 *slope)
 	return is_binop(scev, LINEAR_SCEV, id, base, slope);
 }
 
+static bool is_copy(struct scev *scev, int id, u32 *reg, u32 *orig)
+{
+	u32 t;
+
+	return is_binop(scev, COPY_SCEV, id, &t, orig) && is_reg(scev, t, reg);
+}
+
 static bool is_linear_or_linear32(struct scev *scev, int id, u32 *base, u32 *slope, bool *zext32)
 {
 	u32 t;
@@ -319,6 +331,7 @@ static const char *op_str(u32 op)
 	case SPILL32:  return "spill32";
 	case ANY:      return "any";
 	case LINEAR_SCEV:  return "linear";
+	case COPY_SCEV:    return "copy";
 	}
 	return NULL;
 }
@@ -341,6 +354,7 @@ static u32 op_params_num(u32 op)
 	case SMOD:
 	case ANY:
 	case LINEAR_SCEV:
+	case COPY_SCEV:
 		return 2;
 	case BPF_NEG:
 	case SEXT8:
@@ -1626,6 +1640,7 @@ static int compute_header_scevs(struct bpf_verifier_env *env, struct env *header
 {
 	struct scev *scev = env->scev;
 	int l, r, t, id, ra, rb, ra_expr;
+	bool zext32;
 	s64 imm;
 
 	/*
@@ -1702,6 +1717,28 @@ static int compute_header_scevs(struct bpf_verifier_env *env, struct env *header
 		}
 
 	}
+	/*
+	 *	do { i++; if (old > 1021) break; c = buf[old]; old = i; } while (c);
+	 * rA = (+ rB IMM) and rB = (+ rB IMM): an iteration leaves the same number in both. If
+	 * they are equal when the loop is entered rA is at the header what rB is.
+	 */
+	for (ra = 0; ra < REGS_NUM; ra++) {
+		if (header_env->reg2scev[ra] != UNKNOWN_EXPR_ID ||
+		    header_env->reg2expr[ra] == UNKNOWN_EXPR_ID)
+			continue;
+		for (rb = 0; rb < REGS_NUM; rb++) {
+			id = header_env->reg2scev[rb];
+			if (header_env->reg2expr[rb] != header_env->reg2expr[ra] ||
+			    !is_linear_or_linear32(scev, id, &l, &r, &zext32) ||
+			    !is_reg(scev, l, &t) || t != rb)
+				continue;
+			id = expr2(scev, COPY_SCEV, expr1(scev, REG, ra), id);
+			if (id < 0)
+				return id;
+			header_env->reg2scev[ra] = id;
+			break;
+		}
+	}
 	return 0;
 }
 
@@ -1977,6 +2014,19 @@ static struct bpf_reg_state *scev_reg_for_linear(struct bpf_func_state *st, u32
 	return &stack->spilled_ptr;
 }
 
+/* Do the registers or stack slots @a and @b hold the same number in @st? */
+static bool scev_regs_equal(struct bpf_func_state *st, u32 a, u32 b)
+{
+	const struct bpf_reg_state *ra = scev_reg_for_linear(st, a);
+	const struct bpf_reg_state *rb = scev_reg_for_linear(st, b);
+
+	if (!ra || !rb || ra->type != SCALAR_VALUE || rb->type != SCALAR_VALUE)
+		return false;
+	if (tnum_is_const(ra->var_off) && tnum_is_const(rb->var_off))
+		return ra->var_off.value == rb->var_off.value;
+	return ra->id && ra->id == rb->id && ra->delta == rb->delta;
+}
+
 /* '*(u32 *)(r10 - 8) = rX' left a number in the low half of the slot. */
 static struct bpf_reg_state *scev_reg_for_spill32(struct bpf_func_state *st, u32 r)
 {
@@ -2090,12 +2140,16 @@ static bool scev_reg_alive(struct bpf_verifier_env *env, struct bpf_verifier_sta
  * 'i' is the loop iteration number, starting from 0.
  * 'zext32' indicates the latch is for (zext32 (linear ...)) SCEV.
  * 'jmp32' indicates that the latch is a JMP32 instruction.
+ * 'base_reg' is the register in <base>. 'copy_reg' is -1, or <reg> is made from that register,
+ * which has to be equal to 'base_reg' at the entry of the loop, see COPY_SCEV.
  */
 struct linear_latch {
 	u32 insn_idx;
 	u32 base_expr;
 	u32 step_expr;
 	u32 bound_expr;
+	u32 base_reg;
+	int copy_reg;
 	u8 op;
 	bool zext32;
 	bool jmp32;
@@ -2149,6 +2203,11 @@ static int match_linear_latch(struct bpf_verifier_env *env,
 		return -EFAULT;
 	dst_reg_scev = latch_env->reg2scev[insn->dst_reg];
 	src_reg_scev = latch_env->reg2scev[insn->src_reg];
+	latch->copy_reg = -1;
+	if (is_copy(scev, dst_reg_scev, &latch->copy_reg, &t))
+		dst_reg_scev = t;
+	else if (BPF_SRC(insn->code) == BPF_X && is_copy(scev, src_reg_scev, &latch->copy_reg, &t))
+		src_reg_scev = t;
 	/*
 	 * Make sure (linear ...) is in dst_reg_scev:
 	 *   'if <invariant> <op> <linear>' ⇔
@@ -2187,12 +2246,12 @@ static int match_linear_latch(struct bpf_verifier_env *env,
 		return false;
 
 	/* (linear register step) */
-	if (is_reg_or_low32(scev, latch->base_expr, &t))
+	if (is_reg_or_low32(scev, latch->base_expr, &latch->base_reg))
 		return true;
 
 	/* (linear (+ register imm) step) */
 	if (is_add(scev, latch->base_expr, &l, &r) &&
-	    is_reg_or_low32(scev, l, &t) &&
+	    is_reg_or_low32(scev, l, &latch->base_reg) &&
 	    loop_invariant(scev, r))
 		return true;
 
@@ -2846,6 +2905,8 @@ static bool compute_max_iters(struct bpf_verifier_env *env,
 
 	iters->iv_reg = -1;
 
+	if (latch->copy_reg >= 0 && !scev_regs_equal(st, latch->copy_reg, latch->base_reg))
+		return false;
 	if (!eval_expr(env, scev, st, latch->base_expr, &initial_val) ||
 	    !eval_expr(env, scev, st, latch->step_expr, &step_val) ||
 	    !eval_expr(env, scev, st, latch->bound_expr, &bound_val))
@@ -3180,6 +3241,50 @@ static bool is_simple_linear(struct scev *scev, u32 id, struct linear_coefs *out
 	       is_simple_slope(scev, slope, &out->slope);
 }
 
+/*
+ * Is @r 'what it is in @st + slope * k' at the header in iteration k? @id is its SCEV there, @st is
+ * the state that entered the loop. At a jump in the loop @id can be what another register was at
+ * the header. @st says nothing about @r then.
+ */
+static bool is_linear_at_header(struct scev *scev, struct bpf_func_state *st, u32 id, u32 r,
+				struct linear_coefs *out)
+{
+	u32 copy, orig;
+
+	if (is_copy(scev, id, &copy, &orig))
+		return copy == r && is_simple_linear(scev, orig, out) &&
+		       scev_regs_equal(st, r, out->base_reg);
+	return is_simple_linear(scev, id, out) && out->base_reg == r;
+}
+
+/*
+ * @st is at the header of a loop that @entry entered. A copy of an induction variable is equal to
+ * it there in every iteration. They got their ranges one by one: give them one id, like 'r2 = r1'
+ * does, so that a test of one of them is a test of both.
+ */
+static void link_copies(struct bpf_verifier_env *env, struct env *header_env,
+			struct bpf_func_state *entry, struct bpf_func_state *st)
+{
+	struct bpf_reg_state *reg, *orig;
+	struct linear_coefs coefs;
+	u32 r;
+
+	for (r = 0; r < REGS_NUM; r++) {
+		if (!is_linear_at_header(env->scev, entry, header_env->reg2scev[r], r, &coefs) ||
+		    coefs.base_reg == r)
+			continue;
+		reg = scev_reg_for_linear(st, r);
+		orig = scev_reg_for_linear(st, coefs.base_reg);
+		if (!reg || !orig || reg->type != SCALAR_VALUE || orig->type != SCALAR_VALUE ||
+		    tnum_is_const(orig->var_off))
+			continue;
+		if (!orig->id)
+			orig->id = ++env->id_gen;
+		reg->id = orig->id;
+		reg->delta = orig->delta;
+	}
+}
+
 /*
  * A 32-bit counter that lives on the stack: the SCEV of slot @r is
  * (spill32 (linear (zext32 @r) slope)) and there is a 32-bit number in the slot in @st.
@@ -3588,7 +3693,8 @@ int bpf_compute_loop_iters(struct bpf_verifier_env *env, struct bpf_verifier_sta
 			continue;
 		}
 		/* If SCEV for r is (linear <reg> <slope>) */
-		if (reg && is_simple_linear(scev, r_scev, &coefs) && is_widenable_reg_type(reg)) {
+		if (reg && is_linear_at_header(scev, cur_func, r_scev, r, &coefs) &&
+		    is_widenable_reg_type(reg)) {
 			/* 32-bit ALU operations on pointers convert them to scalars */
 			if (coefs.zext32 && reg->type != SCALAR_VALUE)
 				goto cant_widen;
@@ -3802,7 +3908,7 @@ int bpf_widen_scev_regs(struct bpf_verifier_env *env, struct bpf_verifier_state
 		}
 
 		/* If SCEV for r is (linear <reg> <slope>)*/
-		if (spill32 || (is_simple_linear(scev, r_expr, &coefs) && coefs.base_reg == r)) {
+		if (spill32 || is_linear_at_header(scev, entry_func, r_expr, r, &coefs)) {
 			/* the range is derived from @loop_entry: bpf_clamp_scev_regs() */
 			if (back)
 				continue;
@@ -3812,7 +3918,7 @@ int bpf_widen_scev_regs(struct bpf_verifier_env *env, struct bpf_verifier_state
 			if (err)
 				return err;
 			linear_bounds(reg, iters->max_header_count, &coefs, &bounds);
-			if (r == iters->iv_reg)
+			if (coefs.base_reg == iters->iv_reg)
 				iv_bounds(&bounds, iters->iv_range);
 			if (log->level & BPF_LOG_LEVEL2) {
 				bpf_log(log, "loop header at %d, widening ", insn_idx);
@@ -3850,6 +3956,7 @@ int bpf_widen_scev_regs(struct bpf_verifier_env *env, struct bpf_verifier_state
 			mark_scev_reg_scratched(env, r);
 		}
 	}
+	link_copies(env, header_env, entry_func, cur_func);
 	return 1;
 }
 
@@ -3906,9 +4013,9 @@ int bpf_clamp_scev_regs(struct bpf_verifier_env *env, struct bpf_func_state *cur
 			goto clamp;
 
 		/* If SCEV for r is (linear <reg> <slope>)*/
-		if ((!is_simple_linear(scev, r_scev, &coefs) &&
-		     !(behind && is_moved_linear(scev, r_scev, &coefs, &moved))) ||
-		    coefs.base_reg != r)
+		if (!is_linear_at_header(scev, entry_st, r_scev, r, &coefs) &&
+		    !(behind && is_moved_linear(scev, r_scev, &coefs, &moved) &&
+		      coefs.base_reg == r))
 			continue;
 
 		entry_reg = scev_reg_for_linear(entry_st, r);
@@ -3934,7 +4041,7 @@ int bpf_clamp_scev_regs(struct bpf_verifier_env *env, struct bpf_func_state *cur
 			continue;
 clamp:
 		linear_bounds(entry_reg, max_header_count, &coefs, &bounds);
-		if (r == entry->iv_reg && !moved)
+		if (coefs.base_reg == entry->iv_reg && !moved)
 			iv_bounds(&bounds, entry->iv_range);
 		if (moved) {
 			bounds.r64 = cnum64_add(bounds.r64, cnum64_from_srange(moved, moved));
@@ -3972,5 +4079,8 @@ int bpf_clamp_scev_regs(struct bpf_verifier_env *env, struct bpf_func_state *cur
 			return err;
 		mark_scev_reg_scratched(env, r);
 	}
+	/* behind the jump the variable may have moved on: its copy is what it was at the head */
+	if (!behind)
+		link_copies(env, header_env, entry_st, cur_func_state);
 	return 0;
 }
-- 
2.55.0

