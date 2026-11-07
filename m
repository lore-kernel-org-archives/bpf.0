Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794022858;
	b=2aBFNIg+xb0p+Jn/rEpv9UeEQcHpEwxQD+V0Y9GEfTBqHCncblo2RfEvqiCGyxdCmoR/
	 5McfXE2s3OUcKG4/zP07HwV4PjmVD8pF9iLR5uVuwYb8YyQ4Ja385qSJQVUqig6Dl7h/P
	 IPHhhnvHLn9fGLwUmFcF6tKSNaj6B3mT4Q37EVfAsQq3XLY4usALqz0lfPDBBvV4OuLfy
	 rKWtzSK980aIFrN2IoLFemGt81fKI/L18y+6AfN2hHJRLUBsQsxEX9XVdQ17c5I/sj5Ty
	 Yngzg6k8C0IyTujSXtOamue2qczN7nAbTHV4YTyjsFJ+qVnXYUzlk6rZ78xXyyq01uw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794022858;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=x+U6Sh19A0/FoKrZfBLrW8gkYdGaQJ5cccR4R0Qt0DE=;
	b=QR+BzM3GxRkUhJ/GnVTyM+FZvUYK8EFG6v7kbctCzWis4GL7ENOTeisIyeB2oFt6LSWL
	 oESGFhbiccxTrNefY22wVWaVVbucEPJpPYIN96oWi0mO63jSrknsPe5Lz0u74zJ2qMdBL
	 wcjU4uBjg9QSt+GaVr9kenkPeQpz+R91XTeN0Ld2TMo70V5iUrxP/G1ZT4FiOLmhdEAfX
	 qwzs0mqI3JCSwkUmtfvBxA0rzdmgxk465GZSGsM/mdzLKAfCBtqZm19DSrfHYE+P1W0DW
	 h3nwRSpkJGdqg+u5MxDTO9OvJtb8rFNsj2cKGLI19mvgvifth/aLlT+2CBvY5Uc6UAA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uhwYKA3d;
	arc=none smtp.remote-ip=209.85.215.178
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68540606A326
	for <bpf@vger.kernel.org>; Sat,  7 Nov 2026 03:40:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 68540606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uhwYKA3d
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-cdadf7e248aso502442a12.3
        for <bpf@vger.kernel.org>; Fri, 06 Nov 2026 19:40:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794022858; x=1794627658; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=x+U6Sh19A0/FoKrZfBLrW8gkYdGaQJ5cccR4R0Qt0DE=;
        b=uhwYKA3djQm+R2zXvJftO2Pt60LzuJLGQFDVFRmQHxifOWMP/swkfXHw09aovc+AUd
         LkqPvnevQVkLSB8ZVTEkE7TFxCCCFsuIYBCohGzEUXydooSQKNY+QUJjr3NvCRqYYPlm
         3kgoFkxJ1hYm9zx0aTufMTOOzUWoFJED4SpQchqbSC9S7oaqiGV1H5Jy7KpghGuvvz1A
         MPiZmWhhdNBx4rGWKUtPLGVR1G87Y4lw/5+svyQNFdzEyQIxcC10SNrv0sUDB0B/09Mj
         l3LuUyJhqp5It5ZeAWlO3hmroov0J4KYUK89L/zyHkhiIkNEGsjrG9+jhNUbboX1WOwB
         jHaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794022858; x=1794627658;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=x+U6Sh19A0/FoKrZfBLrW8gkYdGaQJ5cccR4R0Qt0DE=;
        b=b1mZySzQPG0nR2RnvTg4kfDOrHI+oFEw3ZA+jUloYLUVo5Ak3wkZB82PWKKc2Jmu1m
         oTymRE8F17UlytjU7hA1jX1i7SurKURrmZSt8KT0PFl4HZSeT4nonGWtGkvVR9GEUAUZ
         NlsVQy50Ivq+gNpTUxrZXXNynmsBjHF+5I60Z2fRAQXmjX5GWriUUwBGkeQT8xJ4gg9/
         3MXyAJZMssZBOvLE69u82wha9OPVSGKKR/jf9R2okRGMXeKJ/q5eoxXN2wA4lKUXAP8L
         DSWIxf4inp8yO25gnp0DFIdfnAXSHgV/L3vhrTNOArrlOaJ3/OlPcnQOkyoS0/P8n6wS
         3F+w==
X-Gm-Message-State: APuU4Z8IarfVasAd7c1LdRwkOnPt9lE87qeBJDGOT/gqgJRmtYdl7ACL
	ctTZ+bgiQOi1om/v3/FbW540PNq87PfYsbW5pzUfjW5Q635c5vYW25hW15Ym3A==
X-Gm-Gg: AYBFou1+O1I03MtCKgdRXUt2eGlBKjchY+YaP0TQ2087d6xwRdZ6F5UqQT2dbYvdy91
	8zuLrWtWBnv/NqVBcdiLKmjylzmUXNaAvSCSMPezvaWqxFquZgMwnew2N/ePjL2qY3YAObOdkPu
	3CKUH3gyrZex03m2p0YFsfbRDVGmIBPDjjSCC5Doptz820VeeQCIkG2rI5GPLXP7Ak3ZYr5MyFI
	hc4uWsVN2u+mAe4aCXdvRsDnWdRRefCtXWrIfwSKfOX5vTgzUqHlbTd5p7JlDAyk84GS/zzBA9M
	YqXfC/TzcnOiWLvU6bJF3sVB+NAM3/KvLu/YMcLiavJ6FpgfYNkBeTWIWOXjjUzFwHaDUASFrBC
	aFlkTQFzcuClESAy8WeyHo9ivxkb/XtDFq2GUeFi8LY0zR8RBG7finvi+fiCebR7aarKkeCreyl
	X8wCOJ+BBd8awtb5aqo74AAlcmrA3o6wPOQ8aX/46O6pWSbMJNvV7JUQ+uPAWQT9J9YNj7FHRQM
	FExPbAvQGEQaLbPNJ6pB0fll9rAyxrjnS/qlllCbn0CSZcj+d+yBsivex1RXXAyE5QIA4fZ+iKd
	VoE9XzRDlcR3nRjPBF1wjbrjXlRPXa1keIPp2XI9/0cgcGGAAfvrQSCZ+TOY9ZOjPK0jgORJWdi
	hWm9c2SYeTtZX9I2kHFlddCCIXMqDeLB8XlAEOL+6Bs5ibTI/tR9OQ+H7Cf1zs/XERFe2LEvdan
	Y=
X-Received: by 2002:a17:90b:2786:b0:3b0:9e2f:cfc7 with SMTP id 98e67ed59e1d1-3b0db6febbbmr4493023a91.44.1794022857608;
        Fri, 06 Nov 2026 19:40:57 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.244])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b103435561sm965436a91.3.2026.11.06.19.40.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 19:40:57 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next v4 29/46] bpf: Keep the first iteration of a counted loop apart
Date: Sat,  7 Nov 2026 03:37:37 +0000
Message-ID: <20261107033758.1547725-30-alexei.starovoitov@gmail.com>
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
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

  idx = 0;
  for (i = 0; i < 100000; i++)
          idx = table[idx];       /* u8 table[256] */

Scalar evolution has the count and no formula for idx. If something looks
at such a register, like the load here, the verifier goes through the
iterations one by one. 100000 iterations are too many for that. Then what
returns to the loop head is joined with the 0 and widened: the bound that
grew goes to a fixed stop, and a prog that loaded before is rejected:

  R0 unbounded memory access, make sure to bounds check any such access

But nothing that idx is made from is what a register had at the loop head.
It is a byte in each iteration. Only the first one differs: it has the 0
from the entry.

Verify the first iteration with the state that enters the loop. The state
that returns to the loop head has idx in [0, 255]. Give its induction
variables the ranges that follow from the count, as at the entry. It stands
for all other iterations. What returns next must be within it, otherwise
the two are joined like at each loop head. The loop takes 12 insns.

expr_is_fresh() finds the registers, bpf_loop_iters.fresh_regs has them,
loop_stack_entry.first marks a state that is in the first iteration.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/bpf_verifier.h | 15 ++++++--
 kernel/bpf/flow.c            |  4 +--
 kernel/bpf/join.c            |  1 +
 kernel/bpf/scev.c            | 68 ++++++++++++++++++++++++++++++++++--
 kernel/bpf/states.c          |  1 +
 kernel/bpf/verifier.c        | 33 ++++++++++++++++-
 6 files changed, 114 insertions(+), 8 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 098b3c30c8b2..ae57853e7cc0 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -351,6 +351,11 @@ struct bpf_loop_iters {
 	u32 max_header_count;   /* max number of times header is executed */
 	/* live, changed by the loop, no summary of how: left to the join at the head */
 	unsigned long forget_regs[BITS_TO_LONGS(BPF_SCEV_REGS_NUM)];
+	/*
+	 * live, made anew in every iteration: the first one tells what it is in the rest.
+	 * Or not set at the entry, and also in forget_regs: the first one sets it.
+	 */
+	unsigned long fresh_regs[BITS_TO_LONGS(BPF_SCEV_REGS_NUM)];
 	/* [0, max] at the entry, and the loop only clears bits */
 	unsigned long mask_regs[BITS_TO_LONGS(BPF_SCEV_REGS_NUM)];
 	/*
@@ -395,6 +400,11 @@ struct loop_stack_entry {
 	 * flow_join_makes_up(). The test of the flag is decided in both, and decides nothing.
 	 */
 	u32 flag_apart:1;
+	/*
+	 * The first iteration of a counted loop is kept apart. The state that comes back
+	 * to the head is made to stand for the rest.
+	 */
+	u32 first:1;
 	/*
 	 * How many times the state came back to the head of the loop. With @apart that is
 	 * the iteration that it is in. A state that stands for many iterations is a join, and has
@@ -421,7 +431,7 @@ struct loop_stack_entry {
 /* The state is in a walk on patience, which may not get to the end of the loop */
 static inline bool bpf_loop_walk_may_give_up(const struct loop_stack_entry *entry)
 {
-	return entry->apart && entry->terminates && !entry->counted;
+	return entry->apart && entry->terminates && !entry->counted && !entry->first;
 }
 
 #define LOOP_STACK_SIZE 16
@@ -2181,7 +2191,8 @@ int bpf_compute_scev(struct bpf_verifier_env *env);
 int bpf_compute_loop_iters(struct bpf_verifier_env *env, struct bpf_verifier_state *st,
 			   struct bpf_loop_iters *iters);
 int bpf_widen_scev_regs(struct bpf_verifier_env *env, struct bpf_verifier_state *st,
-			struct bpf_verifier_state *loop_entry, struct bpf_loop_iters *iters);
+			struct bpf_verifier_state *loop_entry, struct bpf_loop_iters *iters,
+			bool back);
 int bpf_clamp_scev_regs(struct bpf_verifier_env *env, struct bpf_func_state *st, u32 insn_idx,
 			const struct loop_stack_entry *entry);
 
diff --git a/kernel/bpf/flow.c b/kernel/bpf/flow.c
index 866835eef0cc..a286f43594cd 100644
--- a/kernel/bpf/flow.c
+++ b/kernel/bpf/flow.c
@@ -1891,8 +1891,8 @@ static void flow_shape_ctx(const struct bpf_verifier_state *st, struct flow_shap
 		for (i = 0; i < frame->loop_stack_cnt; i++) {
 			entry = &frame->loop_stack[i];
 			chain = jhash_1word(entry->loop_id << 1 | entry->apart, chain);
-			ctx = jhash_3words(entry->counted << 2 | entry->guarded << 1 |
-					   entry->terminates,
+			ctx = jhash_3words(entry->counted << 3 | entry->guarded << 2 |
+					   entry->first << 1 | entry->terminates,
 					   entry->max_header_count,
 					   entry->counted ? entry->trip : 0, ctx);
 		}
diff --git a/kernel/bpf/join.c b/kernel/bpf/join.c
index 0110e5f85003..88fe3d32a6de 100644
--- a/kernel/bpf/join.c
+++ b/kernel/bpf/join.c
@@ -415,6 +415,7 @@ static bool join_loop_stack(const struct bpf_func_state *fa, const struct bpf_fu
 		    fa->loop_stack[i].guarded != fb->loop_stack[i].guarded ||
 		    fa->loop_stack[i].counted != fb->loop_stack[i].counted ||
 		    fa->loop_stack[i].apart != fb->loop_stack[i].apart ||
+		    fa->loop_stack[i].first != fb->loop_stack[i].first ||
 		    (fa->loop_stack[i].apart && fa->loop_stack[i].trip != fb->loop_stack[i].trip) ||
 		    fa->loop_stack[i].refs != fb->loop_stack[i].refs ||
 		    fa->loop_stack[i].max_header_count != fb->loop_stack[i].max_header_count ||
diff --git a/kernel/bpf/scev.c b/kernel/bpf/scev.c
index 9377b0907f21..d8c847efbd7f 100644
--- a/kernel/bpf/scev.c
+++ b/kernel/bpf/scev.c
@@ -2024,7 +2024,7 @@ scev_reg_for_read(struct bpf_verifier_env *env, const struct bpf_func_state *st,
  * This does not go through check_stack_write(). The buffer of a live dynptr slice, see
  * bpf_reg_state::buf, does not become a spill here. The callers skip the slots that are
  * is_unbound_scev_reg() when the loop is entered. A slot that a call in the loop may write
- * has no description: it is in forget_regs, and they skip these too.
+ * has no description: it is in forget_regs or fresh_regs, and they skip these too.
  */
 static int scev_reg_for_write(struct bpf_verifier_env *env, struct bpf_func_state *st,
 			      u32 r, struct bpf_reg_state **out)
@@ -3252,6 +3252,31 @@ static void iv_bounds(struct bounds *bounds, struct cnum64 iv_range)
 		bounds->r64 = r64;
 }
 
+/*
+ * Nothing that @id is computed from is what a register had at the head of the loop, and
+ * some of it is not known: it's made anew in every iteration.
+ */
+static bool expr_is_fresh(struct bpf_verifier_env *env, u32 id)
+{
+	struct scev *scev = env->scev;
+	bool opaque = false;
+	u32 order, regno;
+
+	scev->stack_sz = 0;
+	expr_stack_push(scev, id);
+	while (expr_next(scev, &id, &order)) {
+		if (order & DEPTH_LIMIT)
+			return false;
+		if (!(order & PRE))
+			continue;
+		if (is_reg(scev, id, &regno) || is_op(scev, id, UNKNOWN))
+			return false;
+		if (is_opaque(scev, id))
+			opaque = true;
+	}
+	return opaque;
+}
+
 /*
  * Does @id have no bit that register @r doesn't have at the head of the loop? 'x & e' and the
  * low bits of x lose bits only. 'x >> e', 'x / e' and 'x % e' are not greater than x as well, but
@@ -3465,6 +3490,7 @@ int bpf_compute_loop_iters(struct bpf_verifier_env *env, struct bpf_verifier_sta
 		return err;
 
 	bitmap_zero(iters->forget_regs, REGS_NUM);
+	bitmap_zero(iters->fresh_regs, REGS_NUM);
 	bitmap_zero(iters->mask_regs, REGS_NUM);
 	iters->spill_base = false;
 	header_env = find_header_env(scev, insn_idx);
@@ -3578,7 +3604,23 @@ int bpf_compute_loop_iters(struct bpf_verifier_env *env, struct bpf_verifier_sta
 			walk = true;
 			continue;
 		}
+		/*
+		 * What is loaded from memory in every iteration is the same kind of thing in all
+		 * of them. One iteration tells what. There is nothing more to find out when
+		 * iterations are looked at one by one.
+		 */
+		if (expr_is_fresh(env, header_env->reg2expr[r])) {
+			__set_bit(r, iters->fresh_regs);
+			continue;
+		}
 		__set_bit(r, iters->forget_regs);
+		/*
+		 *	for (i = 0; i < 40; i++) { if (i) sum += prev; prev = (x ^ i) * 3; }
+		 * It's not set in the first iteration only. That counts if the loop is not walked:
+		 * nothing looks at prev, or there are too many iterations.
+		 */
+		if (reg && reg->type == NOT_INIT)
+			__set_bit(r, iters->fresh_regs);
 		/*
 		 * Only a walk through the iterations tells what it is in each of them. That is not
 		 * worth it for a number that nothing looks at: a sum, a hash, what a call leaves in
@@ -3643,13 +3685,18 @@ static int union_any_reg(struct bpf_verifier_env *env, struct bpf_func_state *lo
 /*
  * Make @st, which is at the head of a counted loop, stand for all iterations. @loop_entry is the
  * state that entered the loop and @iters is what bpf_compute_loop_iters() says about it.
- * @st is a copy of @loop_entry.
+ *
+ * @st is a copy of @loop_entry, or, if the loop has iters->fresh_regs, the state that comes back to
+ * the head after the first iteration, @back. These registers are left as the first iteration
+ * made them. At the entry they are something else: 0, a pointer, not set.
  */
 int bpf_widen_scev_regs(struct bpf_verifier_env *env, struct bpf_verifier_state *st,
-			struct bpf_verifier_state *loop_entry, struct bpf_loop_iters *iters)
+			struct bpf_verifier_state *loop_entry, struct bpf_loop_iters *iters,
+			bool back)
 {
 	struct bpf_func_state *cur_func = st->frame[st->curframe];
 	struct bpf_func_state *entry_func = loop_entry->frame[loop_entry->curframe];
+	const struct bpf_reg_state *val, *entry_val;
 	struct bpf_verifier_log *log = &env->log;
 	struct scev *scev = env->scev;
 	struct bpf_reg_state *reg, *spill32;
@@ -3678,6 +3725,8 @@ int bpf_widen_scev_regs(struct bpf_verifier_env *env, struct bpf_verifier_state
 			}
 			continue;
 		}
+		if (test_bit(r, iters->fresh_regs))
+			continue;
 
 		r_expr = header_env->reg2scev[r];
 		spill32 = spill32_counter(scev, cur_func, r_expr, r, &coefs);
@@ -3686,9 +3735,19 @@ int bpf_widen_scev_regs(struct bpf_verifier_env *env, struct bpf_verifier_state
 				 is_const_scev_reg(env, insn_idx, r)))
 			continue;
 
+		/*
+		 * A call in the loop can change the type, see bpf_clamp_scev_regs(). Then the
+		 * register is left alone. What comes back to the head next is compared with it.
+		 */
+		val = scev_reg_for_read(env, cur_func, r);
+		entry_val = scev_reg_for_read(env, entry_func, r);
+		if (back && (!val || !entry_val || !bpf_reg_union_compatible(val, entry_val)))
+			continue;
 		if (test_bit(r, iters->mask_regs)) {
 			/* The range stays. It's no longer equal to the registers with its id. */
 			err = scev_reg_for_write(env, cur_func, r, &reg);
+			if (!err && back)
+				err = bpf_reg_union(env, reg, entry_val);
 			if (err)
 				return err;
 			if (log->level & BPF_LOG_LEVEL2) {
@@ -3704,6 +3763,9 @@ int bpf_widen_scev_regs(struct bpf_verifier_env *env, struct bpf_verifier_state
 
 		/* If SCEV for r is (linear <reg> <slope>)*/
 		if (spill32 || (is_simple_linear(scev, r_expr, &coefs) && coefs.base_reg == r)) {
+			/* the range is derived from @loop_entry: bpf_clamp_scev_regs() */
+			if (back)
+				continue;
 			/* the other half of the slot stays as it is */
 			reg = spill32;
 			err = reg ? 0 : scev_reg_for_write(env, cur_func, r, &reg);
diff --git a/kernel/bpf/states.c b/kernel/bpf/states.c
index 07b1f0becd2e..efc0870b85c2 100644
--- a/kernel/bpf/states.c
+++ b/kernel/bpf/states.c
@@ -646,6 +646,7 @@ static bool loop_stack_safe(struct bpf_verifier_env *env, struct bpf_func_state
 		    old_stack[i].guarded == cur_stack[i].guarded &&
 		    old_stack[i].counted == cur_stack[i].counted &&
 		    old_stack[i].apart == cur_stack[i].apart &&
+		    old_stack[i].first == cur_stack[i].first &&
 		    (!old_stack[i].apart ||
 		     (old_stack[i].probe ? old_stack[i].trip <= cur_stack[i].trip :
 					   old_stack[i].trip == cur_stack[i].trip)))
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index a3095efb1ee0..1e97444f0279 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -21511,6 +21511,26 @@ int bpf_flow_loop_enter(struct bpf_verifier_env *env, bool *backedge, bool *drop
 			*backedge = true;
 			return check_refs_taken_in_loop(env, entry) ?: maybe_clamp_scev_regs(env);
 		}
+		/*
+		 * The first iteration is over. What the loop makes anew in every iteration is
+		 * in this state. The rest is what the count says, like at the entry.
+		 */
+		if (entry->first) {
+			entry->first = false;
+			entry->apart = false;
+			entry->trip++;
+			err = bpf_compute_loop_iters(env, entry->entry_state, &iters);
+			if (err < 0)
+				return err;
+			if (verifier_bug_if(!err, env, "loop at %d is not counted any more",
+					    env->insn_idx))
+				return -EFAULT;
+			err = maybe_clamp_scev_regs(env);
+			if (err)
+				return err;
+			err = bpf_widen_scev_regs(env, cur, entry->entry_state, &iters, true);
+			return err < 0 ? err : 0;
+		}
 		loop = env->insn_aux_data[env->insn_idx].loop;
 		/* the next iteration is another kind of state, there is no cycle */
 		trip = entry->trip;
@@ -21593,7 +21613,18 @@ int bpf_flow_loop_enter(struct bpf_verifier_env *env, bool *backedge, bool *drop
 	entry->iv_range = iters.iv_range;
 	entry->entry_state = entry_state;
 	entry->terminates = true;
-	err = bpf_widen_scev_regs(env, cur, entry_state, &iters);
+	/*
+	 *	idx = 0; for (i = 0; i < 100; i++) idx = table[idx];
+	 * What the loop makes of idx is not known before its body is looked at, and what idx is
+	 * at the entry goes with i == 0 only. So the state goes through the first iteration as
+	 * it is. The state that comes back to the head has idx in 0..255.
+	 */
+	if (!bitmap_empty(iters.fresh_regs, BPF_SCEV_REGS_NUM)) {
+		entry->first = true;
+		entry->apart = true;
+		return 0;
+	}
+	err = bpf_widen_scev_regs(env, cur, entry_state, &iters, false);
 	return err < 0 ? err : 0;
 }
 
-- 
2.55.0

