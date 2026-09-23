Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8179B59E325
	for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 22:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790202976; cv=none; b=o/PTv7+JspfHFXKpx4Dk5/4gGia4IjU6b+s5xM/rfppQGMWLxrh1tQZgJUIe1om69OrBQ0WyNgkrZAP8BbbC1v+b9R98Fltd3qAFp/RaSBhhgo5MBek/pTriQuA3Pm2ug22brT5oYQFQPThXjrixTCVCefOXQI9h1aThLSnctBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790202976; c=relaxed/simple;
	bh=2FmL/+37NmvVEKS/0XT2iAboN1/OSrPsMBzeOlYhxyg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oleGq0xcSLgMfXXlYbWNE9ivQqN6lTKh79MB69MuZggD79VhLuedEFkLU33t3dpoug7yszwT4fQPFZsM3ajKnfWkH+OZ30EgnfXWjf6swm8nld1HDuGKr6GquxUvQp8nh19jSX8snBJTczmjv0cMbtV+iYM5n4srA6pbyjujmzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ne8vICem; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ne8vICem"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-398a147688bso1074156a91.1
        for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 15:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790202972; x=1790807772; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iFszr27kWJFZRle6RRvSHrKd7NaUQge46LenJrXLZG4=;
        b=ne8vICemG4RoCmV7rLwHT7YxN1j2kOieGjpwH8jQdGpeyS2WxclZb1qeW6R2zP62/w
         lVjjcVxf0lyyUKG0iuJdjpMJokXRk0MBbT2JawdwS+GLtzalDSadl171X8EE8P1DIAe9
         taQtmNM3rMfLgSVjpFmPa5+lQS0Y5F0P13WgiRX8RiCH9+tq+6th6CyINTll/BicOsuw
         lm/WwueFrTNQ2+SpkUCAzkUowtfllkLzeLQbYe8zsqbaJ7NbmKB1M7Tw9yg4Mcttgoma
         56zUd95celA82zfx2MMJolX3WW7CRjUFY1oEHNBSVPgawaU3eXGf01lXNEaNHhV/dGcr
         bsxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790202972; x=1790807772;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=iFszr27kWJFZRle6RRvSHrKd7NaUQge46LenJrXLZG4=;
        b=ZNmmM1d3mTPvf4ucnQMibPrCUMylVF1toZmCtvd3Utzo87zGp3teF38b7727v0Nn0X
         YF1kqLIqL2AFi0mM7TuhnOW8ByHVYTbwP3K6ySlf65/ADhRTZXbcCOuSbzy7XnusPJlZ
         o+LBGr6sIEXV8jkZ5MPIH5E373NXRsYCGd1m/lHKz1DCgHqa0dpEXDCJoK2P7RvH5W+o
         D0XFT4P7f+cg4DbDIbnrggkraZ89PKQ/rnjPBsxmaGaR2CC6E1+xv0oE2MN7cuNqX8ER
         1v2zmtxovcwdDEn28rcQJvg21+6Xg5qVe/1feGpCxkjHs4Btu1x+nTZ6qDkYWIA9spAu
         gnHA==
X-Gm-Message-State: AFuF++ljKQvTelKQadR4Fn/jKICXrhJU5UEdmwnpHXbyd8qU/aki09hB
	lkEj9jxsAypHFnnHk9T+OiVC7Ws/nXqt1jnFDROA4xFbhrHVIjTLNsNx1xmQlw==
X-Gm-Gg: AYBFou16QVJG3E9H9Rw3QA1x/Z6zBNyA2/mL+wh/aCS9wYfZwzGp1qyDi6QTCsvks0B
	6pXZvs4/FlfUQDEocxhi+CtNoKf9lRCCNVhLP1qPV4ryNIQMig4cvAvZg85CBuxQwKfhpzMg1+Q
	CUxfg6kjCiOxoC12ga2hOtyLeFeKqP20cVYe+VGEq0uQX5Xhk2FRwI/hgWdV/uekvbYvCg0y7bJ
	HqW8DwgYs7F7lHN/FeQggOnJntHIws9cUpX+gyHAOoGvYmJjR0EckohiTEDRb+Tt6BKemzVWgKS
	ngpnMsbDwg/QqtVh408MDDfT27zyY0fjk3wma/6c6lhb9I4XIxI24dBazL/Z4aOVuJAYRSW828n
	oP0t/tbD27DATCWWZKyg1AmBGP7dEoNI71Nw6Nmrfmc5go6HMHl0jceCPR2LZdev63tx5dqpnx6
	wHKWAwbBDF1JhiOne4SgRmTIKwjH9UMneDUc/kYAoZqEAtjVX1hcdE/0lrjWB1S9Vpe7HlVX7EL
	L0+xfyi0gySlQuiwFdfA2t9cNZW3hUnBiukb1uiJoe5pJBFBBUEjOsE8F79YhfuA52nwIiAjaZX
	SPdjd8/U1qltiS/SohtVNQThB5GQh861zdHvKyqadG0=
X-Received: by 2002:a17:90b:5445:b0:3a0:7cbf:b8cd with SMTP id 98e67ed59e1d1-3a098d42137mr457156a91.14.1790202972447;
        Wed, 23 Sep 2026 15:36:12 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.249])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0972efa00sm1284387a91.5.2026.09.23.15.36.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 15:36:12 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next 5/8] bpf: Add may_goto to loops that are not walked to the end
Date: Wed, 23 Sep 2026 22:35:51 +0000
Message-ID: <20260923223554.562379-6-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260923223554.562379-1-alexei.starovoitov@gmail.com>
References: <20260923223554.562379-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

The loop that is accepted because the state at the loop head converged
can run for any number of iterations:

  l1: r0 = *(u32 *)(r7 +0)
      if r0 == 0 goto l1

Bound it at run time. When the walk goes over the back-edge and the trip
around the loop didn't take from the budget of may_goto and didn't get
an element from an iterator remember the insn. After the walk add
may_goto to such back-edges of the loops where some state converged.
The loops that are walked to the end are not touched.

The program cannot go on when may_goto is out of budget. Nothing but the
loop was verified for the state in the loop. So may_goto ends in
bpf_throw():

  17: (61) r0 = *(u32 *)(r7 +0)
  18: (15) if r0 == 0x0 goto pc+1
  19: (05) goto pc+10
  20: (79) r12 = *(u64 *)(r10 -24)
  21: (15) if r12 == 0x0 goto pc+6
  22: (17) r12 -= 1
  23: (55) if r12 != 0x0 goto pc+2
  24: (b7) r12 = -24
  25: (85) call arch_bpf_timed_may_goto
  26: (7b) *(u64 *)(r10 -24) = r12
  27: (05) goto pc-11
  28: (b7) r1 = 0
  29: (85) call bpf_throw
  30: (b7) r0 = 2

bpf_throw() cannot be called when the program holds a reference or
a lock, from a callback, from a global function whose callers don't
expect it, when JIT doesn't support exceptions. The states that come
to the loop head over such back-edge are not widened, and if the loop
converges anyway the walk fails.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/bpf_verifier.h |  12 +++
 kernel/bpf/fixups.c          | 153 +++++++++++++++++++++++++++++++++++
 kernel/bpf/states.c          |  31 ++++++-
 kernel/bpf/verifier.c        |  68 ++++++++++++++++
 4 files changed, 263 insertions(+), 1 deletion(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 60f483d7e4a9..fb35f8a7aedd 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -714,6 +714,13 @@ struct bpf_insn_aux_data {
 	u32 loop_head:1; /* target of a back-edge */
 	u32 backedge_ft:1; /* the edge to the next insn is a back-edge */
 	u32 backedge_br:1; /* the jump is a back-edge */
+	/*
+	 * The walk went over the back-edge of this insn with nothing to bound
+	 * the number of trips, in a state where bpf_throw() can and cannot be called.
+	 */
+	u32 guard_pending:1;
+	u32 guard_impossible:1;
+	u32 loop_guard:1; /* may_goto has to be added to the back-edge of this insn */
 	/*
 	 * CFG strongly connected component this instruction belongs to,
 	 * zero if it is a singleton SCC.
@@ -1055,6 +1062,8 @@ struct bpf_verifier_env {
 	u32 scc_cnt;
 	/* per SCC constants that loop counters are compared with, see bpf_widen_loop_head() */
 	struct bpf_widen_thrs **scc_thrs;
+	/* SCCs where some state came back to a state that is still walked */
+	unsigned long *scc_converged;
 	/* states that come back to a loop head are widened instead of walking every iteration */
 	bool widen_loops;
 	/* the walk did or tried that, so a failure can be due to the lost precision */
@@ -1232,6 +1241,9 @@ int mark_chain_precision(struct bpf_verifier_env *env, int regno);
 
 int bpf_is_state_visited(struct bpf_verifier_env *env, int insn_idx);
 bool bpf_same_loop(struct bpf_verifier_state *old, struct bpf_verifier_state *cur);
+bool bpf_mark_loop_guard(struct bpf_verifier_env *env, struct bpf_verifier_state *cur);
+int bpf_commit_loop_guards(struct bpf_verifier_env *env);
+void bpf_throw(u64 cookie);
 void bpf_scc_mark_exit(struct bpf_verifier_env *env, struct bpf_verifier_state *st, int insn_idx);
 int bpf_widen_loop_head(struct bpf_verifier_env *env, int insn_idx, bool backedge,
 			struct bpf_verifier_state *old, struct bpf_verifier_state *cur);
diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
index 2add8001c3ec..2b965fa4bacc 100644
--- a/kernel/bpf/fixups.c
+++ b/kernel/bpf/fixups.c
@@ -1537,6 +1537,143 @@ static int add_hidden_subprog(struct bpf_verifier_env *env, struct bpf_insn *pat
 /* Do various post-verification rewrites in a single program pass.
  * These rewrites simplify JIT and interpreter implementations.
  */
+/*
+ * The walk with widened loops is done. Loops where some state came back to
+ * a state that was still walked were not walked to the end and have to be
+ * bounded at run time.
+ */
+int bpf_commit_loop_guards(struct bpf_verifier_env *env)
+{
+	struct bpf_insn_aux_data *aux = env->insn_aux_data;
+	int i;
+
+	for (i = 0; i < env->prog->len; i++) {
+		if (!aux[i].scc || !test_bit(aux[i].scc, env->scc_converged))
+			continue;
+		if (aux[i].guard_impossible) {
+			verbose(env, "loop with back-edge at insn %d cannot be bounded\n", i);
+			return -E2BIG;
+		}
+		if (aux[i].guard_pending) {
+			aux[i].loop_guard = true;
+			env->seen_exception = true;
+		}
+	}
+	return 0;
+}
+
+/* Jump from insn @from of the patch that replaces insn @idx to insn @target of the program. */
+static int guard_jump(struct bpf_insn *insn, int idx, int from, int cnt, int target)
+{
+	int off;
+
+	/* insns after @idx move by the size of the patch */
+	if (target > idx)
+		target += cnt - 1;
+	off = target - (idx + from) - 1;
+	if (BPF_OP(insn->code) == BPF_JA && BPF_CLASS(insn->code) == BPF_JMP32) {
+		insn->imm = off;
+		return 0;
+	}
+	if (off < S16_MIN || off > S16_MAX) {
+		if (BPF_OP(insn->code) != BPF_JA)
+			return -ERANGE;
+		*insn = BPF_JMP32_A(off);
+		return 0;
+	}
+	insn->off = off;
+	return 0;
+}
+
+/*
+ * The main pass went over the back-edge of jump @insn at @idx with a state
+ * that stands for any number of iterations. Nothing bounds the loop at run
+ * time, so add may_goto to the back-edge. The program cannot go on when
+ * may_goto is out of budget: nothing but the loop was verified for the state
+ * in the loop. Call bpf_throw(). The main pass made sure it can be called.
+ *
+ * back-edge is the jump:             back-edge is the edge to the next insn:
+ *   if cond goto guard                 if cond goto target
+ *   goto next                        guard:
+ * guard:                               may_goto throw
+ *   may_goto throw                     goto next
+ *   goto head                        throw:
+ * throw:                               r1 = 0
+ *   r1 = 0                             call bpf_throw
+ *   call bpf_throw                   next:
+ * next:
+ *
+ * Returns the number of insns in @buf.
+ */
+static int add_loop_guard(struct bpf_verifier_env *env, int idx, struct bpf_insn *buf,
+			  int stack_depth, u16 *stack_depth_extra)
+{
+	struct bpf_insn_aux_data *aux = &env->insn_aux_data[idx];
+	struct bpf_insn orig = env->prog->insnsi[idx];
+	bool ja = BPF_OP(orig.code) == BPF_JA;
+	bool gotol = ja && BPF_CLASS(orig.code) == BPF_JMP32;
+	int target = idx + 1 + (gotol ? orig.imm : orig.off);
+	bool guard_jump_edge = ja || aux->backedge_br;
+	struct bpf_insn *p = buf, *jeq, *skip = NULL, *back = NULL;
+	int stack_off, cnt, err = 0;
+
+	if (guard_jump_edge && !ja) {
+		*p = orig;
+		p->off = 1;
+		p++;
+		skip = p;
+		*p++ = BPF_JMP_A(0);
+	} else if (!guard_jump_edge) {
+		*p++ = orig;
+	}
+
+	/* the same insns may_goto is replaced with, see bpf_do_misc_fixups() */
+	if (bpf_jit_supports_timed_may_goto()) {
+		stack_off = -stack_depth - 16;
+		*stack_depth_extra = 16;
+		*p++ = BPF_LDX_MEM(BPF_DW, BPF_REG_AX, BPF_REG_10, stack_off);
+		jeq = p;
+		*p++ = BPF_JMP_IMM(BPF_JEQ, BPF_REG_AX, 0, 0);
+		*p++ = BPF_ALU64_IMM(BPF_SUB, BPF_REG_AX, 1);
+		*p++ = BPF_JMP_IMM(BPF_JNE, BPF_REG_AX, 0, 2);
+		*p++ = BPF_MOV64_IMM(BPF_REG_AX, stack_off);
+		*p++ = BPF_EMIT_CALL(arch_bpf_timed_may_goto);
+		*p++ = BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_AX, stack_off);
+	} else {
+		stack_off = -stack_depth - 8;
+		*stack_depth_extra = max_t(u16, *stack_depth_extra, 8);
+		*p++ = BPF_LDX_MEM(BPF_DW, BPF_REG_AX, BPF_REG_10, stack_off);
+		jeq = p;
+		*p++ = BPF_JMP_IMM(BPF_JEQ, BPF_REG_AX, 0, 0);
+		*p++ = BPF_ALU64_IMM(BPF_SUB, BPF_REG_AX, 1);
+		*p++ = BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_AX, stack_off);
+	}
+
+	if (guard_jump_edge) {
+		back = p;
+		*p++ = gotol ? orig : BPF_JMP_A(0);
+	} else {
+		/* over bpf_throw() to the loop head that follows */
+		*p++ = BPF_JMP_A(2);
+	}
+	jeq->off = p - jeq - 1;
+	*p++ = BPF_MOV64_IMM(BPF_REG_1, 0);
+	*p++ = BPF_EMIT_CALL(bpf_throw);
+	cnt = p - buf;
+
+	if (skip)
+		skip->off = cnt - (skip - buf) - 1;
+	if (back)
+		err = guard_jump(back, idx, back - buf, cnt, target);
+	else
+		err = guard_jump(&buf[0], idx, 0, cnt, target);
+	if (err) {
+		verbose(env, "insn %d: jump is out of range after may_goto is added\n", idx);
+		return err;
+	}
+	return cnt;
+}
+
 int bpf_do_misc_fixups(struct bpf_verifier_env *env)
 {
 	struct bpf_prog *prog = env->prog;
@@ -1573,6 +1710,22 @@ int bpf_do_misc_fixups(struct bpf_verifier_env *env)
 	}
 
 	for (i = 0; i < insn_cnt;) {
+		if (env->insn_aux_data[i + delta].loop_guard) {
+			cnt = add_loop_guard(env, i + delta, insn_buf, stack_depth,
+					     &stack_depth_extra);
+			if (cnt < 0)
+				return cnt;
+
+			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
+			if (!new_prog)
+				return -ENOMEM;
+
+			delta    += cnt - 1;
+			env->prog = prog = new_prog;
+			insn      = new_prog->insnsi + i + delta;
+			goto next_insn;
+		}
+
 		if (is_addr_space_cast32(env->prog, insn)) {
 			/* convert to 32-bit mov that clears upper 32-bit */
 			insn->code = BPF_ALU | BPF_MOV | BPF_X;
diff --git a/kernel/bpf/states.c b/kernel/bpf/states.c
index 39e6052922e5..24422b7db6d9 100644
--- a/kernel/bpf/states.c
+++ b/kernel/bpf/states.c
@@ -281,6 +281,8 @@ static int add_scc_backedge(struct bpf_verifier_env *env,
 	}
 	if (env->log.level & BPF_LOG_LEVEL2)
 		verbose(env, "SCC backedge %s\n", format_callchain(env, callchain));
+	if (env->scc_converged)
+		__set_bit(callchain->scc, env->scc_converged);
 	backedge->next = visit->backedges;
 	visit->backedges = backedge;
 	visit->num_backedges++;
@@ -1163,6 +1165,9 @@ static bool is_backedge(struct bpf_verifier_env *env, int insn_idx)
 	return insn_idx == prev + 1 ? aux->backedge_ft : aux->backedge_br;
 }
 
+static bool iter_active_depths_differ(struct bpf_verifier_state *old,
+				      struct bpf_verifier_state *cur);
+
 /* The state of this walk that was the last to get to loop head @insn_idx. */
 static struct bpf_verifier_state *loop_head_state(struct bpf_verifier_env *env, int insn_idx)
 {
@@ -1180,6 +1185,24 @@ static struct bpf_verifier_state *loop_head_state(struct bpf_verifier_env *env,
 	return NULL;
 }
 
+/*
+ * @cur got to loop head @insn_idx, @old is the state that started this trip
+ * around the loop if there is one. The trip is bounded at run time if it
+ * took from the budget of may_goto or got an element from an iterator.
+ * Otherwise may_goto has to be added to the back-edge if the loop is not
+ * walked to the end. Returns false if that is not possible.
+ */
+static bool loop_head_guard(struct bpf_verifier_env *env, int insn_idx,
+			    struct bpf_verifier_state *old, struct bpf_verifier_state *cur)
+{
+	if (!is_backedge(env, insn_idx))
+		return true;
+	if (old && (old->may_goto_depth != cur->may_goto_depth ||
+		    iter_active_depths_differ(old, cur)))
+		return true;
+	return bpf_mark_loop_guard(env, cur);
+}
+
 static bool states_maybe_looping(struct bpf_verifier_state *old,
 				 struct bpf_verifier_state *cur)
 {
@@ -1315,8 +1338,14 @@ int bpf_is_state_visited(struct bpf_verifier_env *env, int insn_idx)
 	int n, err, states_cnt = 0;
 	struct list_head *pos, *tmp, *head;
 
-	if (loop_head)
+	if (loop_head) {
 		widen_from = loop_head_state(env, insn_idx);
+		/* the loop cannot be bounded at run time, walk all of it */
+		if (!loop_head_guard(env, insn_idx, widen_from, cur)) {
+			loop_head = false;
+			widen_from = NULL;
+		}
+	}
 
 	force_new_state = env->test_state_freq || bpf_is_force_checkpoint(env, insn_idx) ||
 			  loop_head ||
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 06dc269991b2..2fb5a66bd7d4 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -8322,6 +8322,73 @@ int bpf_widen_loop_head(struct bpf_verifier_env *env, int insn_idx, bool backedg
 	return 0;
 }
 
+static bool program_returns_void(struct bpf_verifier_env *env);
+static bool return_retval_range(struct bpf_verifier_env *env, struct bpf_retval_range *range);
+
+/* Why bpf_throw() cannot be called in @st, NULL if it can. */
+static const char *cannot_throw(struct bpf_verifier_env *env, struct bpf_verifier_state *st)
+{
+	struct bpf_retval_range range;
+	struct bpf_func_state *frame;
+	int i;
+
+	if (!env->prog->jit_requested || !bpf_jit_supports_exceptions())
+		return "JIT does not support exceptions";
+	for (i = 0; i < st->acquired_refs; i++)
+		if (st->refs[i].type == REF_TYPE_PTR)
+			return "reference is held";
+	if (st->active_locks || st->active_irq_id || st->active_rcu_locks ||
+	    st->active_preempt_locks)
+		return "lock is held";
+	for (i = 0; i <= st->curframe; i++) {
+		frame = st->frame[i];
+		if (frame->in_callback_fn || frame->in_async_callback_fn ||
+		    frame->in_exception_callback_fn)
+			return "in callback";
+	}
+	/* callers of the global function were not told that it can throw */
+	if (st->frame[0]->subprogno && !subprog_info(env, st->frame[0]->subprogno)->might_throw)
+		return "in global function";
+	/* default exception callback returns the cookie, that is 0 */
+	if (!env->exception_callback_subprog && !program_returns_void(env) &&
+	    resolve_prog_type(env->prog) != BPF_PROG_TYPE_STRUCT_OPS &&
+	    return_retval_range(env, &range) && (range.minval > 0 || range.maxval < 0))
+		return "0 is not a valid return value";
+	return NULL;
+}
+
+/*
+ * The walk went over the back-edge of env->prev_insn_idx and nothing bounds
+ * the number of trips. If the loop is not walked to the end may_goto that
+ * ends in bpf_throw() is added to the back-edge, see commit_loop_guards().
+ * Returns false when that cannot be done in state @cur.
+ */
+bool bpf_mark_loop_guard(struct bpf_verifier_env *env, struct bpf_verifier_state *cur)
+{
+	struct bpf_insn_aux_data *aux = &env->insn_aux_data[env->prev_insn_idx];
+	struct bpf_insn *insn = &env->prog->insnsi[env->prev_insn_idx];
+	u8 class = BPF_CLASS(insn->code);
+	u8 op = BPF_OP(insn->code);
+	const char *why;
+
+	why = cannot_throw(env, cur);
+	if ((class != BPF_JMP && class != BPF_JMP32) ||
+	    op == BPF_CALL || op == BPF_EXIT || op == BPF_JCOND ||
+	    (op == BPF_JA && BPF_SRC(insn->code) == BPF_X))
+		why = "not a jump";
+	else if (op != BPF_JA && aux->backedge_ft && aux->backedge_br)
+		why = "both edges are back-edges";
+	if (why) {
+		if (env->log.level & BPF_LOG_LEVEL2)
+			verbose(env, "cannot add may_goto to back-edge of insn %d: %s\n",
+				env->prev_insn_idx, why);
+		aux->guard_impossible = true;
+		return false;
+	}
+	aux->guard_pending = true;
+	return true;
+}
+
 /*
  * Check if scalar registers are exact for the purpose of not widening.
  * More lenient than regs_exact()
@@ -22363,6 +22430,7 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr,
 	bpf_stack_liveness_free(env);
 	kvfree(env->cfg.insn_postorder);
 	kvfree(env->scc_info);
+	kvfree(env->scc_converged);
 	if (env->scc_thrs) {
 		for (i = 0; i < env->scc_cnt; i++)
 			kvfree(env->scc_thrs[i]);
-- 
2.55.0

