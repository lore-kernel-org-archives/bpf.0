Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793937286;
	b=4pyTyrBAoVusTJABglaHiQUDvOXRChNZeCNAiRqzabRshfy/TX6tdeekbmu1HvYhAFWJ
	 Ol1l4jDfscJFrXerOePIguKPiwAmiZOKQznv6wWurKxIse5ePD7zC95Gm+Q9G9okzPxFd
	 alqt1JjVdDitFLv0dMfqTdhgayaTlJG+zZ8utqwdLzaIMh1eOlCjeMSm9GzvIuMsZDba5
	 0yiGH8np1/CqOvf+qJtdC7qKk/HNLhfbaj5LeJRS0v5Adj4fyxmPsJRv7ehGJw839RHL6
	 0kDdQXoj8vjlE87ysysu+0LcDMte+2+oLOtBJqn9J0PSlEFh4ysZI5tvs75jypBInIQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793937286;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=EZplWIhVdTgfxAOKg7yDI1ovYt/gaGnpnlbZ0CGMv9Q=;
	b=bNkUrqAWOUuyW3SQdGHSqwCpejtYsSE/bnKJS+dayN7ibNYHWDwi+0AnX/ds7eeOCXVw
	 lL28F0r4NJmVY6iGDgXXiHbPUBp4FJVqeaaFv9oQez+EPqxje/G6QEyPNg+wSSIgNW+9W
	 Rx3OrUWBf2YGZ8Zqpni3mE1zgjJjdsysVSaPOAoSSF0NnVCEn+KoLlj5+pwg0Mvksu/Fd
	 ao5gAB+ERt/Er97Q8EdTarRHP3uUxQfI+QX3d97xmWd/Dp1EFzZqyTOjLbTAvAswGqgpQ
	 1AGXAMjXK9J1z/l/rICehXeVJIY2uD3TX/ZVL/hvllyIvoL5mwGQ+AQ2Y+JkhIqLdkQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LGaee4LF;
	arc=none smtp.remote-ip=209.85.215.170
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC44C606A326
	for <bpf@vger.kernel.org>; Fri,  6 Nov 2026 03:54:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AC44C606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LGaee4LF
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-cdb684859cbso136577a12.1
        for <bpf@vger.kernel.org>; Thu, 05 Nov 2026 19:54:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793937285; x=1794542085; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EZplWIhVdTgfxAOKg7yDI1ovYt/gaGnpnlbZ0CGMv9Q=;
        b=LGaee4LFc0SI874NQjW6njo66tft/aI2E4RSqgz8Ea07Ry9wcjRWZbCAdtFCdGZZCm
         bFV3kNxWcmYqokb5D7vpB+c6ZlvBEPgadrA4JHH7+bJ+Ez9u1P7hf1uRWztadV1+dREO
         qLzXqMf96RySYeT8h7oLFIp/fUYuOJQDEhHd+o/vTcbl9Ttf3N55ebJk+/AwpG6DNlJ5
         Zd1SpapVNz3wpawZN9y+e3sseTZHQi2lHnuZ3nabtvY3xH+f88guRkQvHqT1sy40hPWs
         wWsu4rVWHtaQwQMwrVebhr4cJgYGyqITNej+Q8xR+kjVlirruYkWps5F1OmZJ1NG3t0l
         NPcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793937285; x=1794542085;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=EZplWIhVdTgfxAOKg7yDI1ovYt/gaGnpnlbZ0CGMv9Q=;
        b=dXxGrZl8mvHWnUT1S/p1SA0NQwA0Da2WZf4JsB7rsFL6SYS/7PtrP2XY5N83Jg/pr3
         Fwtqugzpv5n78ioqpP4LqXzNo2gXIzQzyNfJyaqfbBaq/Ys4HPR3B+We88A9+ORiTMYX
         3VEsO580jB8MpdxgXrd/gNT/xtXowzSVwyMaNWRyVI7f4YxZ6sA5I2KZBF/Kf0pNdW2c
         RYWesP8A549PrcykiJjovpVnlRCXJ417cSLKVDREN40X1K/YWcN8/Z3EywVQWL2dcmFw
         lQHZO7nv1mbzTo4MZum7EDtyZxOFrKhBiCvyIS0xvUiF3GXDDJplHt2sV7s3i/xvwOxa
         6bRw==
X-Gm-Message-State: APuU4Z/+gqZUcCSdpPKP58ybGQUw7OCk6AB9it0TTw9OnYuHdd9OYFAh
	7npf10/itjQzsUNA6R6CfEjjdXVzlk/EKGQveBFJzKyP+CI1bkNMJHIDiWMX5w==
X-Gm-Gg: AYBFou0Q1hPHFhlfjZVhJpi45+3hAW88mLyYhK9kIcyPeGgZiA8ew0ArOjpL/ShhI25
	AlqjxadU+MZhr6gnuCQjcpxYTScGC3EAkn9X8VVEf36cbJHmGOo1HdPVaFHQ4YDNkaNvC+zg1Ot
	wQYJroFjsPdf5YCU4dWdo/0za+Q+Oi5yb6qz/vJKe6AeBAsrfHVEMs5aFkBStTSXn36487yWoN3
	bUiWcXmOrh87iJXHqSK+/Cb88y2kWx9jh5VBEmLs6luVI99YciQrVINxPM+S4PSUVR96sXTQoP0
	ethidEBUVw6WuJYt3RSitD7A0ygUAJxUlUAHXewoy8P2mxnXenZKBTm88GwIVfTs5ExueKMUvi8
	iu+ZDJm2ae1BEWwk0yaFuMfXEFRXahdTx1J6VjqVYrMggTUQkxiLcHs1yyHzQ+d3e6EoPN0WyDJ
	47AXF1vhAsoNVIFq6mk9KwxiESC0JY13t826PK8ZRjX90p/oozme2g+uuZkXT/V6Lys5JtbVdCw
	vcKhvp53h1OYcfsXh7eM0+jyDE+S86cCx71EFC2xienJFcrZEGl5jgEXSnqiqQaFgph/7/r+YwT
	xp4Zp6SuHPUJGOKsYrYhofxti0r6tWgv/IIMrzfRfCol1yCkv4iRmU5dN+ii2rHNB2vgcmg0KhZ
	OR3fYhy8qwGmLktULEpjTxgL7jY9gvpeCfFYo4Kp81If/L0SvqpiIlKKZ1ZRX1/IQkGPisbjNHg
	==
X-Received: by 2002:a17:90b:288e:b0:3ab:e588:c29b with SMTP id 98e67ed59e1d1-3b0db5f6fcfmr1321208a91.5.1793937284644;
        Thu, 05 Nov 2026 19:54:44 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.253])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b0b323cd3csm5962740a91.3.2026.11.05.19.54.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 19:54:44 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next v3 36/45] bpf: Keep the first iteration of a counted loop apart
Date: Fri,  6 Nov 2026 03:51:00 +0000
Message-ID: <20261106035111.3315285-37-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261106035111.3315285-1-alexei.starovoitov@gmail.com>
References: <20261106035111.3315285-1-alexei.starovoitov@gmail.com>
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
iterations one by one. 100000 iterations are too many for that. Then idx is
not known in the loop, and a prog that loaded before is rejected:

  math between map_value pointer and register with unbounded min value

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
index 4c0939d91fde..de2c5aa1567d 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -351,6 +351,11 @@ struct bpf_loop_iters {
 	u32 max_header_count;   /* max number of times header is executed */
 	/* live, changed by the loop, and there is no summary of how */
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
@@ -416,7 +426,7 @@ struct loop_stack_entry {
 /* The state is in a walk on patience, which may not get to the end of the loop */
 static inline bool bpf_loop_walk_may_give_up(const struct loop_stack_entry *entry)
 {
-	return entry->apart && entry->terminates && !entry->counted;
+	return entry->apart && entry->terminates && !entry->counted && !entry->first;
 }
 
 #define LOOP_STACK_SIZE 16
@@ -2161,7 +2171,8 @@ int bpf_compute_scev(struct bpf_verifier_env *env);
 int bpf_compute_loop_iters(struct bpf_verifier_env *env, struct bpf_verifier_state *st,
 			   struct bpf_loop_iters *iters);
 int bpf_widen_scev_regs(struct bpf_verifier_env *env, struct bpf_verifier_state *st,
-			struct bpf_verifier_state *loop_entry, struct bpf_loop_iters *iters);
+			struct bpf_verifier_state *loop_entry, struct bpf_loop_iters *iters,
+			bool back);
 int bpf_clamp_scev_regs(struct bpf_verifier_env *env, struct bpf_func_state *st, u32 insn_idx,
 			const struct loop_stack_entry *entry);
 
diff --git a/kernel/bpf/flow.c b/kernel/bpf/flow.c
index a14490511a25..24e7f99277eb 100644
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
index 147a2fa9aea9..0cbf158dae6d 100644
--- a/kernel/bpf/scev.c
+++ b/kernel/bpf/scev.c
@@ -1966,7 +1966,7 @@ scev_reg_for_read(struct bpf_verifier_env *env, const struct bpf_func_state *st,
  * This does not go through check_stack_write(). The buffer of a live dynptr slice, see
  * bpf_reg_state::buf, does not become a spill here. The callers skip the slots that are
  * is_unbound_scev_reg() when the loop is entered. A slot that a call in the loop may write
- * has no description: it is in forget_regs, and they skip these too.
+ * has no description: it is in forget_regs or fresh_regs, and they skip these too.
  */
 static int scev_reg_for_write(struct bpf_verifier_env *env, struct bpf_func_state *st,
 			      u32 r, struct bpf_reg_state **out)
@@ -3194,6 +3194,31 @@ static void iv_bounds(struct bounds *bounds, struct cnum64 iv_range)
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
@@ -3407,6 +3432,7 @@ int bpf_compute_loop_iters(struct bpf_verifier_env *env, struct bpf_verifier_sta
 		return err;
 
 	bitmap_zero(iters->forget_regs, REGS_NUM);
+	bitmap_zero(iters->fresh_regs, REGS_NUM);
 	bitmap_zero(iters->mask_regs, REGS_NUM);
 	iters->spill_base = false;
 	header_env = find_header_env(scev, insn_idx);
@@ -3520,7 +3546,23 @@ int bpf_compute_loop_iters(struct bpf_verifier_env *env, struct bpf_verifier_sta
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
@@ -3624,13 +3666,18 @@ static int union_any_reg(struct bpf_verifier_env *env, struct bpf_func_state *lo
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
@@ -3650,6 +3697,8 @@ int bpf_widen_scev_regs(struct bpf_verifier_env *env, struct bpf_verifier_state
 			scev_forget_reg(env, cur_func, r);
 			continue;
 		}
+		if (test_bit(r, iters->fresh_regs))
+			continue;
 
 		r_expr = header_env->reg2scev[r];
 		spill32 = spill32_counter(scev, cur_func, r_expr, r, &coefs);
@@ -3658,9 +3707,19 @@ int bpf_widen_scev_regs(struct bpf_verifier_env *env, struct bpf_verifier_state
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
@@ -3676,6 +3735,9 @@ int bpf_widen_scev_regs(struct bpf_verifier_env *env, struct bpf_verifier_state
 
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
index 83baaf1a6f2a..06265d617f4c 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -21488,6 +21488,26 @@ int bpf_flow_loop_enter(struct bpf_verifier_env *env, bool *backedge, bool *drop
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
@@ -21570,7 +21590,18 @@ int bpf_flow_loop_enter(struct bpf_verifier_env *env, bool *backedge, bool *drop
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

