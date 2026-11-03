Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793749410;
	b=r2/qOFVwIIs1QtFIGjuP2nWsmGUxZQEjXoFJZ1V4ud5V6A6IOzRVo6yMY/tPMl7rqqfE
	 mmr9TZBsMQnkNBwE0RlcMCzcmdU1q+XD8UehEHnQnsUe2Xi0ljJl5igyUt4qTRYyXCHlH
	 a1k8q1XYrFVlopAgQr5NtuMQqitMNXEZZkpgu07v7jesXQWKT3Ny1xXAndJJf4cjXKFeG
	 6v7FXaq7iIMf/T8vzEe38zb8utcAykQGo0djXo6vqoggOLK2lQEJSjHLJVUQo98L3mk85
	 ktlo77XONRuq++tsEL+I5WSaLNzs9Ec8l8ZbKUoYNTgwf5Dk62J/yPPLB2nVpbiniTQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793749410;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=qgvzkzN28wHBZkV0g7bdsZOumgQ/3zWqqdg5PAkmgO0=;
	b=PO3Xs1KFLVxLqBj6a6q9eclwaTmCMFdzKcnFj+jYA1foB8D5BJ8Gk2HPZJlKWhnU+wlD
	 EQH1Hq9Ts9wc9l/aOS9lnj9BRu4pb0ZcmISTN+mAq4Z+rfDlX3tyDnqAWIhhY9J7inwy0
	 7QRyN+RW/Plmj3/2ONJxqtIDXHrU5pUTHih9GT6dDd3y1dc2QEigAC8u3zQVNA/u8Nw/f
	 WUZ47N8OWH8hZTSkYPsVXYXvr7QJjOLg/ejKXkSzQtUdmEXizy/wG1yOMpkuu0FOT2iqD
	 Xba/MCxLiGG4S6eg+9ItkzrqPl1/6N8WQeX3yaw24u0P4tBydBn5KRW4VHXzzmC7yCg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eCUifVP6;
	arc=none smtp.remote-ip=209.85.210.174
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A417606A31B
	for <bpf@vger.kernel.org>; Tue,  3 Nov 2026 23:43:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0A417606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eCUifVP6
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-8a058315c79so74694b3a.3
        for <bpf@vger.kernel.org>; Tue, 03 Nov 2026 15:43:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793749409; x=1794354209; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qgvzkzN28wHBZkV0g7bdsZOumgQ/3zWqqdg5PAkmgO0=;
        b=eCUifVP6A6fFolgUGAz+bnWqZ+CzhO0T4FSufoGFuWd6aDGM7Ljif+DLqvbsGEnM2l
         jomOzbzoisjFc8Zp7Fz9cgQM26Ne+nrYfy2HCCCX9Ox1RqEyPJHq9BJbDKeb4BweJjZg
         X5kZySpdqLwSWcVNB9m4dvQ2g8mfxrGofweQ0+AXGGtClfyC81Fx55NyPspANaUBFwdP
         vYvo10Tc8T9li0J2xHxJr60sotbde4kCA56zMyyGT6SsI6tbSS5XTiAPD2/vK+hcQPyy
         VxfBHteO5kCWOfCa5j9KmzC2kQtHH4THKuUhxrFGeMxPyUoF4g2usngYTTsnPGvQS0iK
         4EiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793749409; x=1794354209;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=qgvzkzN28wHBZkV0g7bdsZOumgQ/3zWqqdg5PAkmgO0=;
        b=O3wLO2tDvJZUEtmO1JGL6sGgxvUNmNMa0xAcDvVq16VZNFXBAx7jx+hnfbCbSbxq47
         vIWTIghL8IoEZTmuD3RLPwX0kHi+sXqQO6bYJMKcikAxcwixMGih+a5/Bwax91jqv7o8
         52krap17jvutmNzxsA0nL6QBN+j9NQ5HFRhO8cuhP5xlSPhDOtyvUaFWc0pM+XlI15bG
         AZKrnhq1VSLcNwJR+MG+JD6FD706V6MuEHg+k+HlMlULBM0rz+CpvMK9yN/bMuinYYOF
         DEwJO0qtTlRpsFFdjrLXfLs0iGYAGQz1h+N5pzdydp+h9z2r2SyaoiA6BJ1pVsc7FzuV
         gzRw==
X-Gm-Message-State: APuU4Z/MrYRAyWUoSKY/sCNyBwyjZrzn/fMxRB473qKdTRyAvuP6Gkol
	nvc579mAb0/JMGjXYSwhrBcX/YNDWXOLglQ4N+skG/yTRK4nuEKtgTBZOJCO1Q==
X-Gm-Gg: AYBFou1jEC5syHyPeoEzd+FZjYZROsn9uvWteBU6R8PTMpSbbVOt99OjOscJPSgu0wJ
	71fIbPkWsDges0Qm0p5V8QzlW2n7TH8YdpNg5Ucn9531b/e5LZ1lnfcbbdGJV7tcindAFACxp5h
	RcUHRGUnbFnyQnSMZdqubFv7CEF1TJqZ81f7UKKOZHweF+necnYEG+CPwUF+WupAJIRnxkW4op1
	L+FFc1yxamG9Ck7c582RcMg3zyGNp0/AFC0ATvlTQ1zBciigUD48EDjT8erFAxO1YsF+pn4kB37
	647wkPSfwrdFPM0MG4LUzMvF9pvcw96rGbL8Y+4n4Iuzr6h2xxBnuEH9gIYgKZ7Sunc69Lou0O/
	17Gq/A13g0TL7U0Cpj8i5J3cso3fWSKlguA4lwXWZWK0ar1Le80i0X9pLRlcAcdObA8hZE5J8v4
	/a5bt3Q3LFy2e/hpcEsnl5XHnHDmsBGDSteFhj0cEhLM1q1M9iRIa8fmiTeNLnedQ3qhMgHO4lt
	iK/VEqANy531GDSt+Tac9vmkSYj7y0VoApM9l1m5YApzLTiwPH/u5nE0vPBS9xJBS/iMa5dj4Zs
	USF3ypJqsCUfBAQDyim2nZI8QbbjIlMiGAWtb5UlTbQpvjMub/HPIV0h3yqJyN0oVIoICAU8GkH
	AMLAoFzWjdwiW0DWdKVay7FyhAuY1EVotm1c47ke98iJPW50F8m8363xqSSw1BJoyahc1wpcAJx
	3siEHP0lvKYCnqsirZcyUq/A==
X-Received: by 2002:a05:6a21:a101:b0:3e2:a9cc:3ecd with SMTP id adf61e73a8af0-3e928aaf420mr9800820637.7.1793749409061;
        Tue, 03 Nov 2026 15:43:29 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.248])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cdb46974b71sm281377a12.23.2026.11.03.15.43.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 15:43:28 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next 24/37] bpf: Count a loop with several back edges
Date: Tue,  3 Nov 2026 23:40:49 +0000
Message-ID: <20261103234104.208239-25-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261103234104.208239-1-alexei.starovoitov@gmail.com>
References: <20261103234104.208239-1-alexei.starovoitov@gmail.com>
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

'continue', or a compiler that copies the end of the loop body, gives a
loop more than one back edge:

  1: r6 += 1
     if r0 == 0 goto 2f
     if r6 < 10 goto 1b         back edge 1
     goto 3f
  2: if r6 < 20 goto 1b         back edge 2
  3:

  loop header at 1, unsupported loop: multiple backedges

Scalar evolution joins what all back edges bring to the loop head. A
register is linear there only if each path adds the same step. Then it is
'first value + step * k' in iteration k, whatever back edges were taken.
Thus a jump that leaves the loop and dominates a back edge, a latch, tells
in which iterations this back edge can be taken:

  back edge 1    iterations 0 .. 8
  back edge 2    iterations 0 .. 18

The loop ends, at the latest, in an iteration in which no back edge can be
taken. Count each back edge as before, with its latch that has the smallest
count, and take the largest count: 'header_count is [0..20]'.

With one back edge the loop ends when the latch is false. Here the loop can
go on through a different back edge and get to this latch again. The latch
must still be false in the iteration of the largest count:
 - '<' and the like stay false until the variable wraps around. For a
   pointer that is base + offset: the limit is an offset of 2^29.
 - '!=' is false in one iteration only. Its count must be the largest one,
   and its first value and bound must be constants.
 - When these latches are the same test, the first iteration in which it is
   false is the last one, as with one back edge.
If not, or if a back edge has no latch with a count, there is no count.
The other latches of a back edge are not tried.

These loops get ranges now, and the verifier never goes back to one
iteration at a time. It rejects a prog that needs the exact values of one
path, like the same loop with one back edge and 'break'. No prog of scx,
the selftests, Cilium or Meta is lost or needs more insns.
sched_process_exit of profiler1, 2 and 3, built by gcc, loads now.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/bpf_verifier.h                  |   9 +-
 kernel/bpf/scev.c                             | 189 +++++++++++++-----
 .../selftests/bpf/progs/verifier_scev.c       |   2 +-
 3 files changed, 140 insertions(+), 60 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 95e0d7face11..9a0ed5610650 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -351,8 +351,9 @@ struct bpf_loop_iters {
 	/* [0, max] at the entry, and the loop only clears bits */
 	unsigned long mask_regs[BITS_TO_LONGS(BPF_SCEV_REGS_NUM)];
 	/*
-	 * The variable that the latch tests, or -1, and what it can be at the
-	 * loop header: what it is at the entry or what the latch lets through.
+	 * The variable that the latches of all back edges test, or -1, and what
+	 * it can be at the loop header: what it is at the entry or what one of
+	 * the latches lets through.
 	 */
 	int iv_reg;
 	struct cnum64 iv_range;
@@ -726,8 +727,8 @@ struct bpf_backedge {
 	 * Conditional jumps within the loop that dominate 'from' and have
 	 * a successor outside the loop, nearest first. latches[0] is the
 	 * latch; the remaining entries are additional exit conditions.
-	 * Each usable condition gives an upper bound on the iteration count,
-	 * so keeping only a subset is sound.
+	 * Each usable condition tells iterations in which the back edge is
+	 * not taken, so keeping only a subset is sound.
 	 */
 	int latches[MAX_LATCHES];
 	u8 latches_cnt;
diff --git a/kernel/bpf/scev.c b/kernel/bpf/scev.c
index b41c2d4d98b4..fd6abc41b946 100644
--- a/kernel/bpf/scev.c
+++ b/kernel/bpf/scev.c
@@ -2638,6 +2638,31 @@ static bool compute_backedge_taken_max(struct bpf_verifier_env *env, struct bpf_
 	return true;
 }
 
+/*
+ * @latch is false in iteration @cnt, counted from 0. That is the end of a loop with one back
+ * edge. A loop with several back edges may go on through another one and get to @latch
+ * again. Return the last iteration in which @latch is still false:
+ * - '<', '>' and the like stay false until the variable leaves [lo, hi] of latch_domain():
+ *   a number wraps around, the offset of a pointer gets too large to tell,
+ * - '!=' is false in one iteration. Which one is known for constants only.
+ */
+static u64 latch_false_until(const struct linear_latch *latch, const struct scev_value *initial,
+			     const struct scev_value *step_val, const struct scev_value *bound,
+			     u64 cnt)
+{
+	bool sign = is_signed_op(latch->op) || initial->ptr_reg >= 0;
+	struct latch_domain d;
+	u64 step;
+
+	if (latch->op == BPF_JNE)
+		return scev_value_is_const(initial) && scev_value_is_const(bound) ? cnt : 0;
+
+	step = latch->jmp32 || latch->zext32 ? (u64)(s64)(s32)step_val->umin : step_val->umin;
+	latch_domain(latch, initial, bound, sign, &d);
+	/* The first value is in [lo, hi]. do_check() rejects a pointer with a larger offset. */
+	return (s64)step < 0 ? div64_u64(d.imin - d.lo, -step) : div64_u64(d.hi - d.imax, step);
+}
+
 /*
  * Loop with post-condition:
  *
@@ -2667,7 +2692,7 @@ static bool compute_backedge_taken_max(struct bpf_verifier_env *env, struct bpf_
 static bool compute_max_iters(struct bpf_verifier_env *env,
 			      struct bpf_func_state *st,
 			      struct linear_latch *latch,
-			      struct bpf_loop_iters *iters)
+			      struct bpf_loop_iters *iters, u64 *false_until)
 {
 	struct bpf_insn_aux_data *aux = env->insn_aux_data;
 	struct bpf_loop *loop = aux[bpf_loop_at_index(env, latch->insn_idx)].loop;
@@ -2764,11 +2789,12 @@ static bool compute_max_iters(struct bpf_verifier_env *env,
 	}
 
 counted:
+	*false_until = latch_false_until(latch, &initial_val, &step_val, &bound_val,
+					 backedge_taken_count);
 	/* The header executes once on entry and once for each taken backedge, hence +1. */
 	iters->max_header_count = backedge_taken_count + 1;
 	/*
 	 * The latch is a conditional jump with one jump target exiting the loop.
-	 * Linear latch is matched only if the loop has a single backedge.
 	 * The loop still, however can have multiple exits.
 	 * In such case, conservatively assume that non-latch exit can happen
 	 * at any iteration, thus setting minimal number of iterations as 0.
@@ -3146,57 +3172,32 @@ static bool reg_is_zero_to_max(const struct bpf_reg_state *reg)
 	       cnum32_is_subset(reg->r32, cnum32_from_cnum64(r64)) && reg->step <= 1;
 }
 
-int bpf_compute_loop_iters(struct bpf_verifier_env *env, struct bpf_verifier_state *st,
-			   struct bpf_loop_iters *iters)
+/*
+ * A jump that leaves the loop and dominates @backedge tells in which iterations @backedge can
+ * be taken: in none from the count of the jump to @false_until. That bounds the iterations of
+ * the loop only if it has no other back edge. Keep the jump with the smallest count.
+ * Return 1 if there is one.
+ */
+static int count_backedge(struct bpf_verifier_env *env, struct bpf_func_state *st, int insn_idx,
+			  struct bpf_backedge *backedge, struct bpf_loop_iters *iters,
+			  struct linear_latch *best, u64 *false_until)
 {
-	struct bpf_func_state *cur_func = st->frame[st->curframe];
-	struct bpf_insn_aux_data *aux = env->insn_aux_data;
 	struct bpf_verifier_log *log = &env->log;
-	struct scev *scev = env->scev;
-	struct env *header_env;
-	struct linear_latch latch, best;
-	struct linear_coefs coefs;
-	struct bpf_backedge *backedge;
 	struct bpf_loop_iters tmp;
-	struct bpf_loop *loop;
-	int insn_idx = st->insn_idx;
+	struct linear_latch latch;
 	bool found = false;
 	int linear_latch;
 	int latch_idx;
-	int err, j;
-	u32 r;
-
-	if (!env->allow_uninit_stack)
-		return 0;
-
-	/*
-	 * If insn_idx is a loop header for a reducible loop with a single backedge.
-	 * loop is NULL for secondary entries to irreducible loops.
-	 */
-	loop = aux[insn_idx].loop;
-	if (!loop || loop->irreducible || loop->backedges_cnt != 1 || loop->backedges_overflow ||
-	    loop->nested_exits_overflow) {
-		if (log->level & BPF_LOG_LEVEL2)
-			bpf_log(log, "loop header at %d, unsupported loop:%s%s%s\n", insn_idx,
-				!loop || loop->irreducible ? " irreducible" : "",
-				loop && loop->backedges_cnt > 1 ? " multiple backedges" : "",
-				loop && loop->nested_exits_overflow ?
-				" too many exits of a nested loop" : "");
-		return 0;
-	}
+	u64 until;
+	int j;
 
 	/* If this backedge has a latch */
-	backedge = &loop->backedges[0];
 	if (!backedge->latches_cnt) {
 		if (log->level & BPF_LOG_LEVEL2)
 			bpf_log(log, "loop header at %d, latch not identified\n", insn_idx);
 		return 0;
 	}
 
-	/*
-	 * Every condition dominating the backedge bounds the number of
-	 * iterations from above, keep the smallest bound.
-	 */
 	for (j = 0; j < backedge->latches_cnt; j++) {
 		latch_idx = backedge->latches[j];
 		linear_latch = match_linear_latch(env, insn_idx, latch_idx, &latch);
@@ -3208,7 +3209,7 @@ int bpf_compute_loop_iters(struct bpf_verifier_env *env, struct bpf_verifier_sta
 					insn_idx, j ? "exit" : "latch", latch_idx);
 			continue;
 		}
-		if (!compute_max_iters(env, cur_func, &latch, &tmp)) {
+		if (!compute_max_iters(env, st, &latch, &tmp, &until)) {
 			if (log->level & BPF_LOG_LEVEL2)
 				bpf_log(log,
 					"loop header at %d, can't compute iterations count at %d\n",
@@ -3219,18 +3220,107 @@ int bpf_compute_loop_iters(struct bpf_verifier_env *env, struct bpf_verifier_sta
 			iters->max_header_count = tmp.max_header_count;
 			iters->iv_reg = tmp.iv_reg;
 			iters->iv_range = tmp.iv_range;
-			best = latch;
+			*false_until = until;
+			*best = latch;
 		}
 		iters->min_header_count = found ? min(iters->min_header_count, tmp.min_header_count)
 						: tmp.min_header_count;
 		found = true;
 	}
-	if (!found) {
+	if (!found && (log->level & BPF_LOG_LEVEL2))
+		bpf_log(log, "loop header at %d, can't compute iterations count\n", insn_idx);
+	return found;
+}
+
+/* Two jumps that test the same thing: in each iteration both are true or both are false. */
+static bool same_latch(const struct linear_latch *a, const struct linear_latch *b)
+{
+	return a->base_expr == b->base_expr && a->step_expr == b->step_expr &&
+	       a->bound_expr == b->bound_expr && a->op == b->op &&
+	       a->zext32 == b->zext32 && a->jmp32 == b->jmp32;
+}
+
+int bpf_compute_loop_iters(struct bpf_verifier_env *env, struct bpf_verifier_state *st,
+			   struct bpf_loop_iters *iters)
+{
+	struct bpf_func_state *cur_func = st->frame[st->curframe];
+	struct bpf_insn_aux_data *aux = env->insn_aux_data;
+	struct bpf_verifier_log *log = &env->log;
+	struct scev *scev = env->scev;
+	struct env *header_env;
+	struct linear_latch latch, first;
+	struct linear_coefs coefs;
+	struct bpf_loop_iters tmp;
+	struct bpf_loop *loop;
+	int insn_idx = st->insn_idx;
+	u64 until, false_until;
+	bool same = true;
+	int err, i;
+	u32 r;
+
+	if (!env->allow_uninit_stack)
+		return 0;
+
+	/*
+	 * If insn_idx is a loop header for a reducible loop.
+	 * loop is NULL for secondary entries to irreducible loops.
+	 */
+	loop = aux[insn_idx].loop;
+	if (!loop || loop->irreducible || loop->backedges_overflow ||
+	    loop->nested_exits_overflow) {
 		if (log->level & BPF_LOG_LEVEL2)
-			bpf_log(log, "loop header at %d, can't compute iterations count\n", insn_idx);
+			bpf_log(log, "loop header at %d, unsupported loop:%s%s%s\n", insn_idx,
+				!loop || loop->irreducible ? " irreducible" : "",
+				loop && loop->backedges_overflow ? " too many backedges" : "",
+				loop && loop->nested_exits_overflow ?
+				" too many exits of a nested loop" : "");
+		return 0;
+	}
+
+	/*
+	 * A register that is linear at the header is 'first value + slope * k' in iteration k
+	 * whatever back edges were taken. So the jumps that dominate a back edge say in
+	 * which iterations it can be taken. The loop ends, at the latest, in an iteration
+	 * in which no back edge can be taken.
+	 */
+	bitmap_zero(iters->precise_regs, REGS_NUM);
+	for (i = 0; i < loop->backedges_cnt; i++) {
+		err = count_backedge(env, cur_func, insn_idx, &loop->backedges[i],
+				     i ? &tmp : iters, &latch, &until);
+		if (err <= 0)
+			return err;
+		err = mark_expr_precise(env, cur_func, latch.base_expr, iters->precise_regs) ?:
+		      mark_expr_precise(env, cur_func, latch.step_expr, iters->precise_regs) ?:
+		      mark_expr_precise(env, cur_func, latch.bound_expr, iters->precise_regs);
+		if (err)
+			return err;
+		if (!i) {
+			false_until = until;
+			first = latch;
+			continue;
+		}
+		same &= same_latch(&first, &latch);
+		false_until = min(false_until, until);
+		iters->max_header_count = max(iters->max_header_count, tmp.max_header_count);
+		iters->min_header_count = min(iters->min_header_count, tmp.min_header_count);
+		/* at the header the variable is what one of the latches lets through */
+		if (iters->iv_reg >= 0 && iters->iv_reg == tmp.iv_reg)
+			iters->iv_range = cnum64_union(iters->iv_range, tmp.iv_range);
+		else
+			iters->iv_reg = -1;
+	}
+	/*
+	 * When the latches that were kept are the same test, the first iteration in which it's
+	 * false is the last one. Otherwise take the largest count and make sure that the latches
+	 * which became false earlier are false still.
+	 */
+	if (!same && iters->max_header_count - 1 > false_until) {
+		if (log->level & BPF_LOG_LEVEL2)
+			bpf_log(log,
+				"loop header at %d, a latch may be true again in iteration %u\n",
+				insn_idx, iters->max_header_count - 1);
 		return 0;
 	}
-	latch = best;
 
 	if (iters->max_header_count == 0) {
 		if (log->level & BPF_LOG_LEVEL2)
@@ -3365,17 +3455,6 @@ int bpf_compute_loop_iters(struct bpf_verifier_env *env, struct bpf_verifier_sta
 		return 0;
 	}
 
-	bitmap_zero(iters->precise_regs, REGS_NUM);
-	err = mark_expr_precise(env, cur_func, latch.base_expr, iters->precise_regs);
-	if (err)
-		return err;
-	err = mark_expr_precise(env, cur_func, latch.step_expr, iters->precise_regs);
-	if (err)
-		return err;
-	err = mark_expr_precise(env, cur_func, latch.bound_expr, iters->precise_regs);
-	if (err)
-		return err;
-
 	return 1;
 }
 
diff --git a/tools/testing/selftests/bpf/progs/verifier_scev.c b/tools/testing/selftests/bpf/progs/verifier_scev.c
index 20141f45f28b..bb4ce07de1e5 100644
--- a/tools/testing/selftests/bpf/progs/verifier_scev.c
+++ b/tools/testing/selftests/bpf/progs/verifier_scev.c
@@ -729,7 +729,7 @@ __msg("scev at header 3:")
 __msg_next("  r6=(any r6 (+ r6 1)) / ?")
 __msg_next("  r7=(any (+ r7 1) 0) / ?")
 __msg_next("  r8=(+ r8 1) / (linear r8 1)")
-__msg("loop header at 3, unsupported loop: multiple backedges")
+__msg("loop header at 3, can't compute iterations count")
 __naked void nested_loops_shared_header(void)
 {
 	asm volatile ("					\
-- 
2.55.0

