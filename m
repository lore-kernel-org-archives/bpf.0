Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795160786;
	b=obYTTgrV34y/YKKTK+PSiGlvUC2imOsGKYy4K1HAgC0+Oq3zF1nbjxMNfyp52uQfm7Po
	 HgO1aYhPpf2whUeIis4sTYes/5lMy5rSDqHrXLmER/cDKEBhgZVLV1T9nIIaAmQaSxEfb
	 /zkvFSruLuf+N99NxE007lfCfhT99z3ust8XgeEWATfLunb9k2Rj/ipiV4CA0pDel35V7
	 GNEqaqveK6i3HS4Cyl6591TRs17XLXhdMpLr0Y68nBiyaOKSClEwRcN5Pav3V2gnRarcN
	 uxulObOMveVGjcTS1Yx58j0xWPAXMtmMBX5x55MNpu2tZk5l5I4TKLdMZ/kcYfiPZIQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795160786;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=dAgwbTKBCosG4BypspXLNvwO1GUU1mEXXThyU+pQ0HM=;
	b=vxiuFuwBlxOXZyAVRDarRUObviBP8p7Po6UBc2UYTU7WYedTP88yLq5Lr9wImTPuZXfS
	 X3xYpq2I4oTJHuN3yytgPRvDhezbtUhYm86Er1P9eg040GiG1j1dwFDt2BjTlj0vxUIJ3
	 7kPH4E0IzsohREPkSe1CXPNE6tnuRzHtWysBM2yI+YJfb4qc8gDgLBBEtRDiSQK5zoWwo
	 SytwVkyNj9Eef5uDuJuRUNcrroo9VZxJPYfqYEeP9t80ZyqlBih5/K4Oz4azhG6CdlUqf
	 8QYYXKusag0Ea57kGTxpDoPw/6AXbqdVhKxE+7O9pLD5Hw0R0oZsE9ysU3f59sZcB+w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xF80aOcC;
	arc=none smtp.remote-ip=209.85.210.169
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13315606A320
	for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 07:46:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 13315606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xF80aOcC
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-8a9f9473029so537994b3a.2
        for <bpf@vger.kernel.org>; Thu, 19 Nov 2026 23:46:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795160785; x=1795765585; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dAgwbTKBCosG4BypspXLNvwO1GUU1mEXXThyU+pQ0HM=;
        b=xF80aOcC2G63+looH6G13zwSEle8D5RhdNpxd0SaEUURmKbY2y6OAmkoKAxevSNJvT
         p74LuIItUjNkNkhHHoDL9fp2AT2hC7PQ+eIzHfvkPfZIaHLQJ98XqviOueVIHBT3ncOj
         rnFgWNgZ0J6Qw/4RWERr+l2Q4wuT+Et78PMJXCsFq/ZatYZiD9qpLGbR+KHw7HgeznSH
         7FZtKbeHhee3qeXNlX/Po94lI6ekhC78tralLYqVRq07swRHl+i3+He9JtCA6AxqMjON
         P54ZYJYHEWY0EJJnu8ppMP1N3J7n8gkBAUe1IGRSZ465lbv6hG1/lToOg5bGgEw5/vX4
         4hrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795160785; x=1795765585;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=dAgwbTKBCosG4BypspXLNvwO1GUU1mEXXThyU+pQ0HM=;
        b=dfKu57LC0ZrARfGmjX+mvKJmcAJj+1cE8RkwbSfqHEji721oeK3bCOHHONYEi+l1G4
         d56xW77tK8qMfIsqdqrpf3ZJn5iNU5Eerxz/R6SB2OILjIWfofHgfR7XiOf0wsuUfDo8
         Nd7tRmrSgjtvp9UyA7i7aEyKM2Z/M2pN46JjFYJPy1ZcTvd+bICGiaQ4UeSbTUaP7G4R
         jKYzxbsixV8w4hLKbxfACIFDb6Fi1T4Vu/GAtZwy4pN7CP80Vr9xSXNnbXUBm05FPyzV
         epHSdRjhO/QMJYkXmOslnxDLL2VQ99J0LLN4DqmghNTd6NwcAvWdzf7KO9F5vjvsageb
         Z3Pw==
X-Gm-Message-State: APuU4Z8Tfn5r85QHlKB7u6OV7I6YCl++SW2fAidGZZtz5V/FIcE3xzQc
	qHRP9evTRJnSbaKzXO+bqDB9j83nlvcqN+KtJraS3j97iwBn5i5Ii0zPM441IA==
X-Gm-Gg: AZFdTZcLt6hOkH1uZ0DCCxCRqfXT1KuOgiCDlrLVaXrnr2ke+SpA1Ru4YtjWMwyVv7a
	4ZfBTMOMRUutH1MLnhjQ217HwLUNCszYFu/9eFBE5fvTSciYoq/4iuVALYHOdCJbDOjdvb0iyuE
	pN2OMcbg2kT08yn/Oj5ywu5bSNYf7Ws85oUwFlsbMmFcpKenNSgpufE6G3in5fdywIf/F3Aqyao
	EwZoHMc0FcEXPVMpldp3fEzndikrKUZHoxqwSdBXc2L9/YlLmCbwcO9Y4MMbgd15/MzHi9XX0IE
	xExfPTYaGjphbRNBwG22FJx5iVpgXwwkAimKP8oEe4D+SpbOkfqIfimXj/tqdgbNRp8r7BP4Fpv
	MaOLUErr96UnYmQnOxBWQyhZ8GfKyHRdLkxk7cA9acFFT6rabOi6xt2ql+NrWp3KHUlZVLLYO8j
	4BnTb9CTR+0RLk9DH1KQ41ISBTCvK9XTuem4IqoocBG6ioiAsB6hTaDgqExu5b6kRecbSNPqcCJ
	1BOEmZOVdKzb2+Mef/HCsES6tO9dJOQvPHdoPHw3J4cWKfr38LFSR+J3G3etdb/bTPI+DROPpM3
	WsQsGf9zBsBhpCpCGyR0HQDaAbLXHohP7RrqCwQjw1QBFimpBPLIsnHKJ9CdBRjVtNKeQvhCNxY
	+ps7pD42FhhgBXx0c395Q0EEHC3gytOTr74p8YT3oU5obylQDRWBqi8qfely6kYQazhauJChvrw
	TXLUDr4GTe9yDWV6fJhz4=
X-Received: by 2002:a05:6a00:bb8c:b0:89e:2a91:4fd1 with SMTP id d2e1a72fcca58-8c8794b8c20mr2028312b3a.6.1795160784917;
        Thu, 19 Nov 2026 23:46:24 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8c8706844a0sm1139222b3a.1.2026.11.19.23.46.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 23:46:24 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next 19/49] bpf: Make equations from ALU, spill, fill and call insns
Date: Fri, 20 Nov 2026 07:41:51 +0000
Message-ID: <20261120074430.2704488-20-alexei.starovoitov@gmail.com>
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

An insn deletes the equations of the registers that it writes, see
def_regs. The result gets a new equation:

  r2 = r1             r1 = sym0, r2 = sym0
  r2 += 8             r2 = sym0 + 8
  r2 <<= 2            r2 = 4 * sym0 + 32
  r2 += r3            r2 = sym2, sum: sym2 = 4 * sym0 + sym1 + 32
  r1 >>= 3            r1 = quot, sum: rem = sym0 - 8 * quot
  w4 = w1             r4 = low,  sum: low = sym0 - 2^32 * high
  r1 ^= 5             r1 = sym3, op:  sym3 = sym0 ^ 5
  *(fp - 8) = r1      fp-8 = sym0, and a fill reads it back
  call                r1-r5 go to the frame of the callee
  exit                r0 goes to the frame of the caller

A number gets a sym only when a second xreg needs it.

A truncation is a sum for the low bits. Compilers test one truncation
and use another one:

  w2 = w1; w2 += -1; w2 &= 255; if w2 > 99 goto out; use (u8)r1

expr_low_bits() looks for a number with the same low bits before it
makes a new sym. 'w1 <<= 24; w1 s>>= 24' is a truncation to 8 bits.
An op that reads only the low bits gets them from a truncation, also if
the test of the truncation was earlier:

  w2 = w1; w2 &= 0xff; if w2 > 0xdf goto out; w1 &= 0xf0     0..0xd0

find_same_op() finds an op with the same operands. So two insns that
compute one number get one sym.

A call uses the equations of its arguments before it deletes them. The
largest offset and the largest size do not have to go together:

  read(buf + off, 64 - off)     r1 = buf + sym0, r2 = 64 - sym0

size_at_max_offset() gives the check the size that is left at the
largest offset. It can be 0 for a call that touches memory. So
check_stack_access_within_bounds() tests the range, not the size.

A speculative state gets no equations.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/bpf_verifier.h |   9 +
 kernel/bpf/equation.c        | 535 +++++++++++++++++++++++++++++++++++
 kernel/bpf/equation.h        |   9 +
 kernel/bpf/verifier.c        |  44 ++-
 4 files changed, 592 insertions(+), 5 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 297f19271ff..1a9adf126f9 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -2321,6 +2321,15 @@ void bpf_equation_env_free(struct bpf_verifier_env *env);
 int bpf_equations_copy(struct bpf_verifier_env *env, struct bpf_equations *dst,
 		       const struct bpf_equations *src);
 void bpf_equations_free(struct bpf_equations *eqs);
+s64 bpf_equations_max_sum(struct bpf_verifier_env *env, int regno1, int regno2);
+void bpf_equations_before_insn(struct bpf_verifier_env *env);
+int bpf_equations_after_insn(struct bpf_verifier_env *env);
+void bpf_equations_forget_xreg(struct bpf_verifier_env *env, struct bpf_verifier_state *st,
+			       u64 xreg);
+void bpf_equations_spill(struct bpf_verifier_env *env, struct bpf_func_state *frame, int spi,
+			 int regno);
+void bpf_equations_fill(struct bpf_verifier_env *env, struct bpf_func_state *frame, int spi,
+			int size);
 void bpf_equations_refine_all(struct bpf_verifier_env *env, struct bpf_verifier_state *st);
 void bpf_equations_jump(struct bpf_verifier_env *env, struct bpf_verifier_state *st, int idx,
 			bool taken);
diff --git a/kernel/bpf/equation.c b/kernel/bpf/equation.c
index 16b50253a6e..5c9a3df8ce4 100644
--- a/kernel/bpf/equation.c
+++ b/kernel/bpf/equation.c
@@ -1039,6 +1039,541 @@ void bpf_equations_jump(struct bpf_verifier_env *env, struct bpf_verifier_state
 		refine_diff(env, st, &untruncated[0], &untruncated[1], op, true);
 }
 
+/* The largest sum of two arguments of a call: numbers, or offsets of pointers. Modulo 2^64. */
+s64 bpf_equations_max_sum(struct bpf_verifier_env *env, int regno1, int regno2)
+{
+	struct bpf_equation_env *eq_env = env->eq_env;
+	struct bpf_verifier_state *st = env->cur_state;
+	struct equation_pos pos = {};
+	struct expr neg, sum;
+	struct scalar bounds;
+	s64 max = S64_MAX;
+
+	if (!eq_env || regno1 < 0 || regno2 < 0 ||
+	    (~eq_env->has_arg_expr & (BIT(regno1) | BIT(regno2))))
+		return max;
+	neg = expr_scale(eq_env->arg_expr[regno2], -1, 0);
+	while (bpf_find_next_diff(env, &st->equations, &eq_env->arg_expr[regno1], &neg, &pos,
+				  &sum)) {
+		bpf_eval_expr(env, st, &sum, &bounds);
+		max = min(max, cnum64_smax(bounds.r64));
+	}
+	return max;
+}
+
+/* Insns write */
+
+void bpf_equations_forget_xreg(struct bpf_verifier_env *env,
+			       struct bpf_verifier_state *st, u64 xreg)
+{
+	bpf_set_xreg_equation(env, &st->equations, xreg, NULL, false);
+}
+
+/* @to gets the number of @from */
+static void copy_xreg_equation(struct bpf_verifier_env *env, struct bpf_equations *eqs,
+			       u64 to, u64 from)
+{
+	const struct bpf_xreg_equation *xreg_eq = bpf_find_xreg_equation(eqs, from);
+	struct expr expr;
+
+	if (!xreg_eq)
+		return bpf_set_xreg_equation(env, eqs, to, NULL, false);
+	expr = sym_expr(xreg_eq->coef, xreg_eq->sym, xreg_eq->off);
+	bpf_set_xreg_equation(env, eqs, to, &expr, xreg_eq->is_ptr);
+}
+
+/* The number in @xreg is copied to another xreg. It needs a sym if it is @live_after. */
+static bool assign_sym(struct bpf_verifier_env *env, u64 xreg, bool live_after, struct expr *expr,
+		       bool *is_ptr)
+{
+	struct bpf_verifier_state *st = env->cur_state;
+
+	if (!bpf_xreg_expr(env, st, xreg, expr, is_ptr))
+		return false;
+	if (expr->var != xreg)
+		return true;
+	if (!live_after)
+		return false;
+	expr->var = bpf_new_sym(env, &st->equations, bpf_find_var_bounds(env, st, xreg, is_ptr));
+	bpf_set_xreg_equation(env, &st->equations, xreg, expr, *is_ptr);
+	return var_is_sym(expr->var);
+}
+
+static bool reg_is_live_after(struct bpf_verifier_env *env, u32 regno)
+{
+	return env->insn_aux_data[env->insn_idx + 1].live_regs_before & BIT(regno);
+}
+
+/* Register @regno is spilled */
+void bpf_equations_spill(struct bpf_verifier_env *env, struct bpf_func_state *frame, int spi,
+			 int regno)
+{
+	struct bpf_verifier_state *st = env->cur_state;
+	u64 slot = bpf_xreg(frame->frameno, bpf_spi_to_xreg(spi));
+	struct expr expr;
+	bool is_ptr;
+
+	if (env->eq_env && regno >= 0 && !st->speculative &&
+	    assign_sym(env, bpf_reg_to_xreg(st, regno), reg_is_live_after(env, regno),
+		       &expr, &is_ptr))
+		bpf_set_xreg_equation(env, &st->equations, slot, &expr, is_ptr);
+	else
+		bpf_equations_forget_xreg(env, st, slot);
+}
+
+/* The low @size bytes of what is loaded are from the spilled register */
+void bpf_equations_fill(struct bpf_verifier_env *env, struct bpf_func_state *frame,
+			int spi, int size)
+{
+	if (!env->eq_env)
+		return;
+	env->eq_env->fill_xreg = bpf_xreg(frame->frameno, bpf_spi_to_xreg(spi));
+	env->eq_env->fill_bits = size * BITS_PER_BYTE;
+}
+
+/* Note the operands. Delete the equations of the registers that the insn writes. */
+void bpf_equations_before_insn(struct bpf_verifier_env *env)
+{
+	const struct bpf_insn *insn = &env->prog->insnsi[env->insn_idx];
+	u8 class = BPF_CLASS(insn->code), op = BPF_OP(insn->code);
+	bool src_is_reg = BPF_SRC(insn->code) == BPF_X && op != BPF_END;
+	bool alu = class == BPF_ALU || class == BPF_ALU64;
+	struct bpf_verifier_state *st = env->cur_state;
+	struct bpf_equation_env *eq_env = env->eq_env;
+	u32 def = env->insn_aux_data[env->insn_idx].def_regs, fr = st->curframe, i, r;
+	struct bpf_equations *eqs = &st->equations;
+	bool is_ptr;
+
+	if (!eq_env)
+		return;
+	if (st->speculative || eqs->sym_cnt > 2 * eqs->clean_sym_cnt + MAX_BPF_REG)
+		bpf_equations_clean(env, st);
+	eq_env->insn_idx = env->insn_idx;
+	eq_env->fill_xreg = VAR_NONE;
+	eq_env->has_arg_expr = 0;
+	eq_env->equation_added = eq_env->divided = false;
+	for (i = 0; i < 2; i++) {
+		r = i ? insn->src_reg : insn->dst_reg;
+		eq_env->has_expr[i] = eq_env->is_ptr[i] = false;
+		if (!alu || st->speculative)
+			continue;
+		if (i && !src_is_reg) {
+			eq_env->operand_expr[1] = make_expr(0, 0, insn->imm);
+			scalar_set_const(&eq_env->operand_bounds[1], insn->imm);
+			eq_env->has_expr[1] = true;
+		} else if (r <= BPF_REG_FP && cur_regs(env)[r].type != NOT_INIT) {
+			eq_env->operand_bounds[i] = *scalar_of(&cur_regs(env)[r]);
+			eq_env->has_expr[i] =
+				assign_sym(env, bpf_reg_to_xreg(st, r), false,
+					   &eq_env->operand_expr[i], &eq_env->is_ptr[i]);
+		}
+	}
+	if (class == BPF_JMP && op == BPF_EXIT && fr && !st->frame[fr]->in_callback_fn)
+		copy_xreg_equation(env, eqs, bpf_xreg(fr - 1, BPF_REG_0), bpf_xreg(fr, BPF_REG_0));
+	if (class == BPF_JMP && op == BPF_CALL) {
+		i = xreg_equation_pos(eqs, bpf_xreg(fr + 1, 0)) - eqs->xreg_equations;
+		eqs->normalized &= i == eqs->xreg_equation_cnt;
+		eqs->xreg_equation_cnt = i;
+		for (r = BPF_REG_1; r <= BPF_REG_5 && i; r++)
+			if (bpf_xreg_expr(env, st, bpf_xreg(fr, r), &eq_env->arg_expr[r], &is_ptr))
+				eq_env->has_arg_expr |= BIT(r);
+	}
+	for (r = 0; r < BPF_REG_FP && def >> r && eqs->xreg_equation_cnt; r++) {
+		if (!(def & BIT(r)))
+			continue;
+		/* the arguments are in the frame of the callee, if it gets one */
+		if (r && (bpf_pseudo_call(insn) || bpf_is_callx(insn)))
+			copy_xreg_equation(env, eqs, bpf_xreg(fr + 1, r), bpf_xreg(fr, r));
+		bpf_equations_forget_xreg(env, st, bpf_xreg(fr, r));
+	}
+}
+
+/* @expr = @divisor * quot + rem. Returns the expr of a new sym: @quot or @rem. */
+static bool add_divmod_equation(struct bpf_verifier_env *env, struct expr *expr, u64 divisor,
+				const struct scalar *quot, const struct scalar *rem, bool want_quot)
+{
+	struct bpf_equations *eqs = &env->cur_state->equations;
+	struct bpf_sym_equation sym_eq = { { -1, expr->coef, -divisor }, { 0, expr->var },
+					     env->eq_env->insn_idx, expr->off };
+
+	sym_eq.sym[0] = bpf_new_sym(env, eqs, rem);
+	sym_eq.sym[2] = bpf_new_sym(env, eqs, quot);
+	*expr = sym_expr(1, sym_eq.sym[want_quot ? 2 : 0], 0);
+	env->eq_env->divided = true;
+	if (!bpf_add_sym_equation(env, eqs, sym_eq))
+		return false;
+	refine_syms_by_equation(env, env->cur_state,
+				&eqs->sym_equations[eqs->sym_equation_cnt - 1], 0);
+	for (i = 0; i < 3; i++)
+		if (sym_eq.coef[i])
+			env->eq_env->scratch[sym_eq.sym[i]].refined_sweep = 0;
+	return true;
+}
+
+/* Make @expr an expr of the left side of @sym_eq that has the same low @bits bits */
+static bool rewrite_expr_by_truncation(const struct bpf_sym_equation *sym_eq,
+				       struct expr *expr, u32 bits)
+{
+	struct expr factor = make_expr(0, 0, expr->coef);
+
+	if (sym_eq->sym[1] != var_symno(expr->var) ||
+	    !bpf_expr_div_exact(&factor, 0, sym_eq->coef[1]) ||
+	    ((factor.off * sym_eq->coef[2]) & low_bits(bits)))
+		return false;
+	*expr = sym_expr(factor.off, sym_eq->sym[0], expr->off - factor.off * sym_eq->off);
+	return true;
+}
+
+static void set_operand(struct bpf_sym_equation *op, int i, const struct expr *expr)
+{
+	op->coef[i + 1] = expr->coef;
+	op->sym[i + 1] = expr->var;
+	*(i ? &op->off_src : &op->off) = expr->off;
+}
+
+/* How many low bits of its operands does the insn of @op read? */
+static u32 bits_read(struct bpf_verifier_env *env, const struct bpf_sym_equation *op)
+{
+	const struct bpf_insn *insn = &env->prog->insnsi[op->insn_idx];
+	u32 bits = BPF_CLASS(insn->code) == BPF_ALU64 ? 64 : 32;
+
+	if (BPF_OP(insn->code) == BPF_END)
+		return insn->imm;
+	if (BPF_OP(insn->code) == BPF_MOV)
+		return insn->off ?: bits;
+	if (BPF_OP(insn->code) == BPF_AND && !op->coef[2])
+		return min_t(u32, fls64(op->off_src), bits);
+	return bits;
+}
+
+static void op_skips_truncations(struct bpf_verifier_env *env, struct bpf_equations *eqs,
+				 struct bpf_sym_equation *op)
+{
+	u32 i, bits = bits_read(env, op);
+	struct expr expr;
+
+	for (i = 0; i < 2 && bits < 64; i++) {
+		expr = rhs_expr(op, i);
+		if (!expr.coef)
+			continue;
+		skip_truncation(env, eqs, &expr, bits, false);
+		set_operand(op, i, &expr);
+	}
+}
+
+/*
+ * A test of @truncation tells more, if @op reads no other bits:
+ *	r2 = r1; r2 &= 0xf8; r1 &= 0xff; if r1 > 8 goto out;
+ */
+static void read_from_truncation(struct bpf_verifier_env *env, struct bpf_sym_equation *op,
+				 const struct bpf_sym_equation *truncation)
+{
+	struct expr expr;
+	int i;
+
+	for (i = 0; i < 2 && is_op(op) && truncation->sym[0] != op->sym[0]; i++) {
+		expr = rhs_expr(op, i);
+		if (expr.coef && rewrite_expr_by_truncation(truncation, &expr, bits_read(env, op)))
+			set_operand(op, i, &expr);
+	}
+}
+
+/* @res and @candidate have the same low @bits bits. If they are equal @expr gets @candidate. */
+static bool take_expr_if_fits(struct bpf_verifier_env *env, const struct scalar *res,
+			      struct expr *expr, struct expr candidate, u32 bits)
+{
+	struct scalar bounds;
+
+	bpf_eval_expr(env, env->cur_state, &candidate, &bounds);
+	if (!scalars_fit_in_bits(&bounds, res, bits))
+		return false;
+	*expr = candidate;
+	return true;
+}
+
+/* @res is an extension of the low @bits bits of @expr. Make @expr the value of @res. */
+static bool expr_low_bits(struct bpf_verifier_env *env, struct scalar *res,
+			  struct expr *expr, u32 bits)
+{
+	struct bpf_verifier_state *st = env->cur_state;
+	struct bpf_sym_equation *sym_eq;
+	struct scalar bounds;
+	struct expr operand;
+
+	if (bits == 64)
+		return true;
+	if (!(expr->coef & low_bits(bits)))
+		return false;
+	if (take_expr_if_fits(env, res, expr, *expr, bits))
+		return true;
+	operand = *expr;
+	skip_truncation(env, &st->equations, &operand, bits, true);
+	if (take_expr_if_fits(env, res, expr, operand, bits))
+		return true;
+	skip_truncation(env, &st->equations, expr, bits, false);
+	for_each_sum(env, &st->equations, sym_eq) {
+		operand = *expr;
+		if (rewrite_expr_by_truncation(sym_eq, &operand, bits) &&
+		    take_expr_if_fits(env, res, expr, operand, bits))
+			return true;
+	}
+	scalar_set_unknown(&bounds);
+	if (!add_divmod_equation(env, expr, BIT_ULL(bits), &bounds, res, false))
+		return false;
+	/* a number has a range for 32 bits */
+	if (bits < 32)
+		for_each_sym_equation(env, &st->equations, sym_eq)
+			read_from_truncation(env, sym_eq, st->equations.sym_equations +
+					     st->equations.sym_equation_cnt - 1);
+	return true;
+}
+
+/* The source goes into the equation of the result */
+static bool assign_sym_to_src(struct bpf_verifier_env *env)
+{
+	struct bpf_equation_env *eq_env = env->eq_env;
+	const struct bpf_insn *insn = &env->prog->insnsi[eq_env->insn_idx];
+
+	if (!eq_env->has_expr[1] && insn->src_reg != insn->dst_reg &&
+	    reg_is_live_after(env, insn->src_reg))
+		eq_env->has_expr[1] =
+			assign_sym(env, bpf_reg_to_xreg(env->cur_state, insn->src_reg), true,
+				   &eq_env->operand_expr[1], &eq_env->is_ptr[1]);
+	return eq_env->has_expr[1];
+}
+
+static bool alu_add(struct bpf_verifier_env *env, struct expr *expr, s64 sign, u32 bits)
+{
+	struct bpf_equations *eqs = &env->cur_state->equations;
+	struct bpf_equation_env *eq_env = env->eq_env;
+	struct expr *a = &eq_env->operand_expr[0], *b = &eq_env->operand_expr[1], neg;
+	struct scalar bounds;
+	struct equation_pos pos = {};
+	int i;
+
+	for (i = 0; i < 2; i++) {
+		if (i ? assign_sym_to_src(env) : eq_env->has_expr[0])
+			continue;
+		/* it is dead after the insn. Its range is the sum minus the other operand. */
+		if ((bits == 64 ? !~eq_env->operand_bounds[i].r64.size :
+		     eq_env->operand_bounds[i].r32.size == U32_MAX) ||
+		    !(i || assign_sym_to_src(env)) || !eq_env->operand_expr[!i].coef)
+			return false;
+		eq_env->operand_expr[i] =
+			make_expr(1,
+				  bpf_new_sym(env, eqs, &eq_env->operand_bounds[i]), 0);
+		if (env->no_mem)
+			return false;
+	}
+	neg = expr_scale(*b, -sign, 0);
+	if (bpf_find_next_diff(env, eqs, a, &neg, &pos, expr))
+		return true;
+	scalar_add_scaled(&bounds, &eq_env->operand_bounds[0], &eq_env->operand_bounds[1], sign);
+	scalar_bounds_sync(&bounds);
+	*expr = make_expr(1, bpf_new_sym(env, eqs, &bounds), 0);
+	return bpf_add_sym_equation(env, eqs, (struct bpf_sym_equation){
+		{ -1, a->coef, -neg.coef },
+		{ expr->var, a->var, b->var }, eq_env->insn_idx, a->off - neg.off });
+}
+
+/* An insn that is a sum, a product with a constant, or the reverse of that */
+static bool alu_linear(struct bpf_verifier_env *env, const struct bpf_insn *insn,
+		       struct scalar *res, struct expr *expr)
+{
+	u32 bits = BPF_CLASS(insn->code) == BPF_ALU64 ? 64 : 32;
+	struct bpf_equation_env *eq_env = env->eq_env;
+	struct tnum a = eq_env->operand_bounds[0].var_off;
+	struct tnum b = eq_env->operand_bounds[1].var_off;
+	u8 op = BPF_OP(insn->code);
+	struct scalar bounds;
+	struct expr untruncated;
+	u64 c;
+
+	if (op == BPF_MOV) {
+		if (insn->imm || !assign_sym_to_src(env))
+			return false;
+		*expr = eq_env->operand_expr[1];
+		return expr_low_bits(env, res, expr, insn->off ?: bits);
+	}
+	if (insn->off)
+		return false;
+	if ((op == BPF_OR || op == BPF_XOR) && !((a.value | a.mask) & (b.value | b.mask)))
+		op = BPF_ADD;
+	if (op == BPF_ADD || op == BPF_SUB)
+		return alu_add(env, expr, op == BPF_ADD ? 1 : -1, bits) &&
+		       expr_low_bits(env, res, expr, bits);
+	if (!eq_env->has_expr[0])
+		return false;
+	if (op == BPF_MUL && !eq_env->operand_expr[0].coef && assign_sym_to_src(env))
+		swap(eq_env->operand_expr[0], eq_env->operand_expr[1]);
+	if (!eq_env->has_expr[1] || eq_env->operand_expr[1].coef)
+		return false;
+	*expr = eq_env->operand_expr[0];
+	c = eq_env->operand_expr[1].off & low_bits(bits);
+	switch (op) {
+	case BPF_NEG:
+		*expr = expr_scale(*expr, -1, 0);
+		return expr_low_bits(env, res, expr, bits);
+	case BPF_LSH:
+		if (c >= bits)
+			return false;
+		c = BIT_ULL(c);
+		fallthrough;
+	case BPF_MUL:
+		*expr = expr_scale(*expr, bits == 32 ? (s32)c : c, 0);
+		return expr_low_bits(env, res, expr, bits);
+	case BPF_AND:
+		if (c && !(c & (c + 1)))
+			return expr_low_bits(env, res, expr, min_t(u32, fls64(c), bits));
+		/* x & -8 == x - (x & 7) */
+		scalar_set_unknown(&bounds);
+		bounds.var_off = tnum_and(a, tnum_const(~c));
+		scalar_bounds_sync(&bounds);
+		return add_divmod_equation(env, expr, 1, res, &bounds, true);
+	case BPF_RSH:
+	case BPF_ARSH:
+		if (!c || c >= bits)
+			return false;
+		/* w1 <<= 24; w1 s>>= 24; */
+		untruncated = *expr;
+		if (expr->coef & low_bits(c))
+			skip_truncation(env, &env->cur_state->equations, &untruncated, bits, true);
+		if (!((untruncated.coef | untruncated.off) & low_bits(c))) {
+			*expr = make_expr(untruncated.coef >> c, untruncated.var,
+					  (s64)untruncated.off >> c);
+			return expr_low_bits(env, res, expr, bits - c);
+		}
+		c = BIT_ULL(c);
+		fallthrough;
+	case BPF_DIV:
+		if (c < 2 || (bits == 32 && cnum64_umax(eq_env->operand_bounds[0].r64) >
+					    (op == BPF_ARSH ? S32_MAX : U32_MAX)))
+			return false;
+		scalar_set_below(&bounds, c);
+		return add_divmod_equation(env, expr, c, res, &bounds, true);
+	}
+	return false;
+}
+
+/* The operands of an op possibly skipped their truncations, see op_skips_truncations() */
+static bool find_same_op(struct bpf_verifier_env *env, struct expr *expr)
+{
+	struct bpf_equations *eqs = &env->cur_state->equations;
+	struct bpf_equation_env *eq_env = env->eq_env;
+	struct bpf_sym_equation sym_eq = { .insn_idx = eq_env->insn_idx };
+	struct expr op[2];
+	int i;
+
+	if (bpf_find_op(env, eqs, eq_env->insn_idx, eq_env->operand_expr, expr))
+		return true;
+	for (i = 0; i < 2; i++)
+		set_operand(&sym_eq, i, &eq_env->operand_expr[i]);
+	op_skips_truncations(env, eqs, &sym_eq);
+	for (i = 0; i < 2; i++)
+		op[i] = rhs_expr(&sym_eq, i);
+	return bpf_find_op(env, eqs, eq_env->insn_idx, op, expr);
+}
+
+/*
+ * The same as read_from_truncation(), the test is before @op:
+ *	r2 = r1; r2 &= 0xff; if r2 > 0xdf goto out; r1 &= 0xf0;
+ */
+static void refine_op_by_truncations(struct bpf_verifier_env *env,
+				     const struct bpf_sym_equation *op)
+{
+	struct bpf_equations *eqs = &env->cur_state->equations;
+	struct bpf_sym_equation *sym_eq, copy;
+	struct scalar bounds;
+
+	if (bits_read(env, op) >= 32)
+		return;
+	for_each_sum(env, eqs, sym_eq) {
+		copy = *op;
+		read_from_truncation(env, &copy, sym_eq);
+		if (memcmp(&copy, op, sizeof(copy)) && run_op(env, env->cur_state, &copy, &bounds))
+			refine_bounds(eqs, &eqs->syms[op->sym[0]], &bounds);
+	}
+}
+
+/*
+ * A sum does not tell all about the result. A jump that refines the operands runs the op again:
+ *	r2 = r1; r2 ^= 5; if r1 > 20 goto out;
+ */
+static bool alu_scalar(struct bpf_verifier_env *env, const struct bpf_insn *insn,
+		       struct scalar *res, struct expr *expr)
+{
+	struct bpf_equations *eqs = &env->cur_state->equations;
+	struct bpf_equation_env *eq_env = env->eq_env;
+	bool ok;
+
+	if (BPF_OP(insn->code) == BPF_MOV) {
+		eq_env->operand_expr[0] = make_expr(0, 0, 0);
+		eq_env->has_expr[0] = !insn->imm;
+	}
+	if (eq_env->has_expr[0] && eq_env->has_expr[1] && find_same_op(env, expr))
+		return true;
+	ok = alu_linear(env, insn, res, expr);
+	if ((ok && !eq_env->divided) || !eq_env->has_expr[0] || !assign_sym_to_src(env))
+		return ok;
+	if (!ok)
+		*expr = make_expr(1, bpf_new_sym(env, eqs, res), 0);
+	if (!bpf_add_op(env, eqs, eq_env->insn_idx, eq_env->operand_expr, expr))
+		return true;
+	op_skips_truncations(env, eqs, &eqs->sym_equations[eqs->sym_equation_cnt - 1]);
+	refine_op_by_truncations(env, &eqs->sym_equations[eqs->sym_equation_cnt - 1]);
+	return true;
+}
+
+/* The insn is proven */
+int bpf_equations_after_insn(struct bpf_verifier_env *env)
+{
+	struct bpf_verifier_state *st = env->cur_state;
+	struct bpf_equation_env *eq_env = env->eq_env;
+	const struct bpf_insn *insn;
+	struct scalar *res, bounds;
+	bool is_ptr, ok, was_ptr;
+	struct expr expr;
+	u8 class, op;
+	u64 dst;
+
+	if (!eq_env)
+		return 0;
+	insn = &env->prog->insnsi[eq_env->insn_idx];
+	dst = bpf_reg_to_xreg(st, insn->dst_reg);
+	class = bpf_atomic_is_load_acq(insn) ? BPF_LDX : BPF_CLASS(insn->code);
+	op = BPF_OP(insn->code);
+	if ((class != BPF_ALU && class != BPF_ALU64 && class != BPF_LDX) || st->speculative)
+		goto out;
+	res = bpf_find_var_bounds(env, st, dst, &is_ptr);
+	if (!res || tnum_is_const(res->var_off))
+		goto out;
+	bounds = *res;
+	if (!is_ptr && scalar_align_bounds(&bounds))
+		*res = bounds;
+	else if (!is_ptr)
+		st->equations.infeasible = true;
+	if (class == BPF_LDX)
+		ok = eq_env->fill_xreg != VAR_NONE &&
+		     assign_sym(env, eq_env->fill_xreg, true, &expr, &was_ptr) &&
+		     was_ptr == is_ptr && expr_low_bits(env, res, &expr, eq_env->fill_bits);
+	else if (op == BPF_MOV ? is_ptr != eq_env->is_ptr[1] :
+		 is_ptr != eq_env->is_ptr[0] + eq_env->is_ptr[1])
+		ok = false;
+	else if (is_ptr)
+		ok = class == BPF_ALU64 && alu_linear(env, insn, res, &expr);
+	else
+		ok = alu_scalar(env, insn, res, &expr);
+	if (!ok || (expr.coef && !var_is_sym(expr.var)))
+		goto out;
+	/* it was computed before */
+	eval_expr_nosync(env, st, &expr, &bounds);
+	if (!is_ptr)
+		refine_bounds(&st->equations, res, &bounds);
+	bpf_set_xreg_equation(env, &st->equations, dst, &expr, is_ptr);
+out:
+	return env->no_mem ? -ENOMEM : 0;
+}
+
 static void print_operand(struct bpf_verifier_log *log, const char *prefix, struct expr expr)
 {
 	if (expr.coef)
diff --git a/kernel/bpf/equation.h b/kernel/bpf/equation.h
index 1cb2f358199..db068a58c30 100644
--- a/kernel/bpf/equation.h
+++ b/kernel/bpf/equation.h
@@ -59,7 +59,16 @@ struct bpf_equation_env {
 	struct sym_scratch *scratch;
 	u32 *use_links;
 	u32 scratch_cap, use_link_cap, refined_cnt;
+	/* the insn that is checked and its operands */
+	s32 insn_idx;
+	struct expr operand_expr[2];
+	struct scalar operand_bounds[2];
 	bool has_expr[2], is_ptr[2], equation_added, divided;
+	/* the arguments of a call */
+	struct expr arg_expr[BPF_REG_5 + 1];
+	u8 has_arg_expr;
+	u64 fill_xreg;
+	u32 fill_bits;
 	/* the operand of a jump and its bounds, see refine_from_reg() */
 	struct expr jump_expr;
 	struct scalar jump_bounds;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 033f6b42ab1..cfcb20dda5e 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3754,7 +3754,9 @@ static int check_stack_write_fixed_off(struct bpf_verifier_env *env,
 		/* Mark slots affected by this stack write. */
 		for (i = 0; i < size; i++)
 			ss->slot_type[(slot - i) % BPF_REG_SIZE] = type;
+		return 0;
 	}
+	bpf_equations_spill(env, state, spi, value_regno);
 	return 0;
 }
 
@@ -4016,6 +4018,7 @@ static int check_stack_read_fixed_off(struct bpf_verifier_env *env,
 
 				/* coerce_scalar_to_size will adjust the boundaries. */
 				state->regs[dst_regno] = *reg;
+				bpf_equations_fill(env, reg_state, spi, size);
 			} else {
 				/* the low bytes are from the spill */
 				bool fill_exceeds_spill =
@@ -4023,6 +4026,9 @@ static int check_stack_read_fixed_off(struct bpf_verifier_env *env,
 					!IS_ENABLED(CONFIG_CPU_BIG_ENDIAN);
 				int spill_cnt = 0, zero_cnt = 0;
 
+				if (fill_exceeds_spill)
+					bpf_equations_fill(env, reg_state, spi, spill_size);
+
 				for (i = 0; i < size; i++) {
 					type = stype[(slot - i) % BPF_REG_SIZE];
 					if (type == STACK_SPILL) {
@@ -4069,6 +4075,7 @@ static int check_stack_read_fixed_off(struct bpf_verifier_env *env,
 		} else if (dst_regno >= 0) {
 			/* restore register state from stack */
 			state->regs[dst_regno] = *reg;
+			bpf_equations_fill(env, reg_state, spi, size);
 		} else if (__is_pointer_value(env->allow_ptr_leaks, reg)) {
 			/* If dst_regno==-1, the caller is asking us whether
 			 * it is acceptable to use this value as a SCALAR_VALUE
@@ -7043,9 +7050,9 @@ static int check_stack_access_within_bounds(
 	 * Every stack access passes through here, including buffers passed to
 	 * helpers and kfuncs and accesses into a caller's frame, so check the
 	 * fastcall contract of the frame that owns the slots once for all of
-	 * them. Zero-sized accesses touch no stack and keep the rewrite enabled.
+	 * them. An empty range touches no stack and keeps the rewrite enabled.
 	 */
-	if (access_size)
+	if (min_off < max_off)
 		check_fastcall_stack_contract(env, state, env->insn_idx, min_off);
 
 	/* Note that there is no stack access with offset zero, so the needed stack
@@ -8053,6 +8060,28 @@ enum bpf_mem_size_failure {
 	BPF_MEM_SIZE_FAIL_SIZE,
 };
 
+/*
+ * The check looks at the bytes from the smallest offset to the largest offset plus the size.
+ * The largest offset and the largest size do not have to go together:
+ *	read(buf + off, 64 - off);
+ * So the result is not the size of the access. It is 0 for off = 0..64.
+ * The checked bytes of a packet pointer are relative to the pointer. It needs the largest size.
+ */
+static u32 size_at_max_offset(struct bpf_verifier_env *env, struct bpf_reg_state *mem_reg,
+			      struct bpf_reg_state *size_reg, argno_t mem_argno, argno_t size_argno)
+{
+	u32 type = base_type(mem_reg->type);
+	s64 end;
+
+	if ((type != PTR_TO_MAP_VALUE && type != PTR_TO_MEM && type != PTR_TO_STACK) ||
+	    reg_smin(mem_reg) <= -BPF_MAX_VAR_OFF || reg_smax(mem_reg) >= BPF_MAX_VAR_OFF)
+		return reg_umax(size_reg);
+	end = bpf_equations_max_sum(env, reg_from_argno(mem_argno), reg_from_argno(size_argno));
+	end = clamp(end, reg_smax(mem_reg) + (s64)reg_umin(size_reg),
+		    reg_smax(mem_reg) + (s64)reg_umax(size_reg));
+	return end - reg_smax(mem_reg);
+}
+
 /* verify arguments to helpers or kfuncs consisting of a pointer and an access
  * size.
  *
@@ -8067,6 +8096,7 @@ static int check_mem_size_reg(struct bpf_verifier_env *env,
 			      enum bpf_mem_size_failure *failure)
 {
 	int err = 0;
+	u32 size;
 
 	if (failure)
 		*failure = BPF_MEM_SIZE_FAIL_NONE;
@@ -8110,11 +8140,12 @@ static int check_mem_size_reg(struct bpf_verifier_env *env,
 		goto size_error;
 	}
 
+	size = size_at_max_offset(env, mem_reg, size_reg, mem_argno, size_argno);
 	if (access_type & BPF_READ)
-		err = check_helper_mem_access(env, mem_reg, mem_argno, reg_umax(size_reg),
+		err = check_helper_mem_access(env, mem_reg, mem_argno, size,
 					      BPF_READ, zero_size_allowed, meta, NULL);
 	if (!err && access_type & BPF_WRITE)
-		err = check_helper_mem_access(env, mem_reg, mem_argno, reg_umax(size_reg),
+		err = check_helper_mem_access(env, mem_reg, mem_argno, size,
 					      BPF_WRITE, zero_size_allowed, meta, NULL);
 	if (err && failure)
 		*failure = BPF_MEM_SIZE_FAIL_MEMORY;
@@ -21079,6 +21110,8 @@ static int push_unwind_exit(struct bpf_verifier_env *env)
 	__mark_reg_const_zero(&regs[BPF_REG_0]);
 	if (bpf_ret_reg_pair(env, cur_func(env)->subprogno))
 		__mark_reg_const_zero(&regs[BPF_REG_2]);
+	bpf_equations_forget_xreg(env, branch, bpf_xreg(branch->curframe, BPF_REG_0));
+	bpf_equations_forget_xreg(env, branch, bpf_xreg(branch->curframe, BPF_REG_2));
 	return 0;
 }
 
@@ -21343,8 +21376,9 @@ static int do_check_block(struct bpf_verifier_env *env, int prev_insn_idx)
 		if (err)
 			return err;
 
-		err = do_check_insn(env, &do_print_state);
+		bpf_equations_before_insn(env);
 		fixups = insn_aux->fixups;
+		err = do_check_insn(env, &do_print_state) ?: bpf_equations_after_insn(env);
 		if (nospec_ends_path(env, state, err)) {
 			/* Prevent this speculative path from ever reaching the
 			 * insn that would have been unsafe to execute.
-- 
2.55.0

