Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795207994;
	b=VY+wgs1tju0fAyi5UvE9cy7+190MY6obskr+j6WlfcEtCzjsBvz5VTWi4fJRV3tFoxiR
	 Qq127Jla//ELdakzxtp7QMcnO+EbPwHwfg3pX7X6AM0pFQS5qZ/pCcbi7hGYz3vz1fTrC
	 PrJT355HK5IDKl3GDUYEGXctw+8RkmNFQUkUZBddOjjqTApKaCsP6O+6gAh9Fdik627mI
	 WzL6UIavGCI/pmlDwRxX05QDPDiAn+MeQpXhuAW+h2XvBXGh8vwiDfpjcQvJYudkAUPT0
	 E074C6gPnL5klFViEi2EvYOZsxoSeCS9eBFTKBwOy3NNNEqCj99mTyewaXgWmsaMxQQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795207994;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=vCmKVQ/7op5toZSHBhE774R5y8ERURVQW3NEq8t25xw=;
	b=j62Bsz75OzcCzW7swFq2T875CJT9Tj48dsxdxmJ2AgvYTfYrCF2lxKReiybhrTV1GVSq
	 1j/iHYsM1CRcBV52a3stIp+qjdoKCuZcV5ZmgS4w+7XZl/k80hTrzbAk/g91yS6nQbKck
	 k9wnOOf/z7ADktCqUPUhOOhfS9JPr47ZX4OexdUsPpJJj24a1hPwrrkxKMUtHmFx0iOGJ
	 OXRHPXvSfyBRfgaUGSYwDo/+di0NxZ3OVJwU1uCkVPqRY0pZyvJIHSBVA+cn0gs1ddPiH
	 nzkQP8of5MbiM0OyNLreW33B34jjlDqeY1U7A2/XS8GLjbBXrLe82hOCu35n9obFlLQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sO9oXJDh;
	arc=none smtp.remote-ip=209.85.214.171
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CD3F606A684
	for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 20:53:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8CD3F606A684
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sO9oXJDh
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2f00fc215f9so9279675ad.0
        for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 12:53:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795207981; x=1795812781; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vCmKVQ/7op5toZSHBhE774R5y8ERURVQW3NEq8t25xw=;
        b=sO9oXJDhm3cYwJliSBY1WSyTZI14NbAGlBxNnTjLTuNFr+mS9/t+GoVOCxsEQoO7iM
         c0fmJoiostwZ6W/OqQ8xVBwrU8bJA5kxElOJhXUcllVB66hjD0bMKR8Bkb4Q0Ta6JbVO
         G6btSXLr29fFrNBB71wGdlBSagN8Kg9CzET5nwbcYJfQIJUXoI/mKGcAF+Qun5xfYIrZ
         R8RJYf7P98qyKSdWA7jebbQO6i9Rp641eCiFRdjoMFkBLgv1HhAyLwoijxImUhnCBUhE
         OCYy+hjst1xzX+5dV/BF45n8TeA1LV3uYPHjUY7RAsN2QSWIm1MNOFHXjnmSi7x1aJKy
         OMkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795207981; x=1795812781;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=vCmKVQ/7op5toZSHBhE774R5y8ERURVQW3NEq8t25xw=;
        b=LkbjDrEqJbbLSUEM4nMPNhThSWM7IfnBb7CP4Xfz0cweTuJ7klIi0x+ChKmHxZPe5+
         iZyqrIt5SI4IMJmLPz7yr9/UdonkJBfAn5y6eaF87U20hPd79VzOxeBZ4uonmI/QHd6t
         ZIzVuygDGlvPCX7aBf6XN0oGoI5FtatUaLflVdwtIs5SyXLQdTVguBEWi0dXYL7zryi/
         hLbZCoP3bPEmtp6sB7MYJKM7+V9hasZtakQF4RoqnL5FSjKWBLGz/iUNtuldRRDhs/eL
         myxrMob0NuHdVt93fuK043SP496Wa63B42gJTVKhHsSHfuqJTb3V+Aga4VQvTinKWeqC
         In5g==
X-Gm-Message-State: APuU4Z8Dup/oFuE0dF/8JQ4O/DDiuNh9lclpbp0kvkwaBixZjDDqlnrj
	c9q/RDUqVgAP4rR+rDp37tbGELnw8i+ERM4csfk2DQ/3YGXg9hliwfKmfn2nEw==
X-Gm-Gg: AZFdTZfEMdNDAV7X+dwLQz0R7gk6TWG4nEaWmQyi9lM1QQT8RGhQI0arRo/cBU8AFh7
	vye9LJaYgy7MhCHCXH7iPOoHBeEpWOVpPBXtnTf600svwpg3YrQK0rTf+5TB5ug/p66YHmw5aDM
	Gy3NiKp8658mnsRn5evXt7eS443MVbujBaa5xfft2cZQhZkeNiawnpMzz7akqfFt+VcS7PE4cem
	h9QJChW/IPlMCP6UGjWH9W9kCxdQKUHDVT5npj25lrGkJaUw7oZJBrR/OfjrOqg/kgibWduFITi
	YNSWq9SuD7j+YylwWRaJy1BjQCDQlNaWLO/bDBGOmnIjq3SM7lI7DEtN3gkUiyb231EAdlVS4lV
	WdF5hcFVnLzvqzvxIYnP53ynU0VinRuISyHamS6aQIcAA5jlhDXsUrJ+QfgIyE+wrdlfgkzMoWG
	00Y0R0mv3IYe/rh6aQ8STMglLFpOcFktJTxAVePPiqdoR8F2VxRgNZY9ehd17aCDZ4YOk10l7/s
	36GqgixctK6yMAZpAf76iT1BeWF19Oj3Bbr2KmerMyS6MnSctTAC6M4TLUXuxctOweGn8iyqaYh
	uqa7h1paHM0jUyHFIVS9pD0q+Pd2+yP8cJuRHPn13NbG95a4+5LoBr1Fb89Fyqtb8HF08o0go6e
	Aj6SAwAoMS1TxNayfr0Mh8im4Ee1T7aknvC3JXVucOYN32uXfx+0R6406sQE5nVxsgrBFxa09yg
	==
X-Received: by 2002:a17:902:eccf:b0:2e9:64b9:a333 with SMTP id d9443c01a7336-2f03f17c766mr46298985ad.19.1795207980413;
        Fri, 20 Nov 2026 12:53:00 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.241])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f03ee84871sm19214655ad.8.2026.11.20.12.52.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 12:53:00 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next v2 30/49] bpf: Get the trip count from the trip index
Date: Fri, 20 Nov 2026 20:49:38 +0000
Message-ID: <20261120204959.614908-31-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261120204959.614908-1-alexei.starovoitov@gmail.com>
References: <20261120204959.614908-1-alexei.starovoitov@gmail.com>
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

A loop needs a trip count or may_goto. The trip index k is an xreg. It
is 0 at the entry, and each back edge adds 1. The join at the header
finds what moves with k. A jump that tests such an xreg refines k.

  for (i = 0; i < 100; i += 4)
    join        i = 4 * k
    threshold   'i < 100' holds up to k = 24: widen k to 0..25
    jump        i < 100  ->  k 0..24
    back edge   k + 1 is 1..25, the header state subsumes it

This is the proof: k grows in each trip and stays in 0..25. The next
patch checks that. No jump has to test p here, its equation limits it:

  for (i = 0, p = buf; i < 8; i++, p += 8)      p = buf + 8 * k
          *p = 0;

A threshold is a guess, see bpf_collect_iv_thresholds(). If it is too
small, k grows to the next one, and at last to S64_MAX. No run makes
2^63 trips, so a state with k = S64_MAX ends at the back edge.

Two states can enter a loop with two bounds. So each entry has the trip
index at which its jumps leave the loop, see exit_threshold:

  (n, size) = (1 << 18, 4) or (1 << 17, 8)
  for (i = 0; i != n; i++)
          buf[i * size];        1 << 18 is too much for size 8

- The trip count is known only when the pass ends. So pass 0 takes the
  edges of may_goto in all loops. After it only the loops that need
  may_goto keep them.
- 'i != n' with two ranges: add_distance_equation() makes a sym for
  i - n in the first trip. It does that for two pointers into one
  object too: for (p = t + 0..3; p != t + 4..7; p++)
- A test against the rest of a buffer gets a sym for the difference
  too, in a loop or not:
    if (len > 64 - off) return; read(buf + off, len);
  An equation has a cost, so len has to be in data_deps. If it is not,
  the pass is imprecise, and a later pass makes the sym.
- With -mcpu=v1 and v2 clang can count down and test the carry:
    x = (u32)x + 0xffffffff; if (x != (u32)x) continue;
  The two operands have one step. If the carry is set in the first
  trips, the jump gives the threshold of 'x > U32_MAX'.
- A distance of two truncated numbers can have a range of 2^31 after a
  widening. clamp_diff_start() takes the ranges of the two numbers.
- bpf_note_linear_xregs() notes the xregs that are linear in k, and
  those that are linear only at first: i = (i + 1) & 63
- A leftover is walked more than once. The new walk makes all values
  again. So flow_is_stale() frees a state of an earlier walk.
- With may_goto k has no bound. trip_index_safe() lets it start again
  from a smaller number, so the states can be pruned. loop_stack_safe()
  calls it for each loop of a frame.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/bpf_verifier.h |  20 ++-
 kernel/bpf/equation.c        | 130 +++++++++++++++++
 kernel/bpf/equation.h        |   5 +
 kernel/bpf/equation_join.c   | 276 +++++++++++++++++++++++++++++++++++
 kernel/bpf/flow.c            |  24 +++
 kernel/bpf/precision.c       |  10 ++
 kernel/bpf/states.c          |  35 ++++-
 kernel/bpf/verifier.c        |  19 +++
 8 files changed, 514 insertions(+), 5 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 6ccac5dff96..1ae2f57311c 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -427,6 +427,9 @@ static inline u32 bpf_xreg_to_spi(u32 xregno)
 
 /* The trip index of a loop is an xreg too. The loops of a frame come after its slots. */
 #define BPF_XREG_TRIP MAX_BPF_XREG
+/* A loop that can make more trips gets may_goto */
+#define BPF_MAX_TRIPS BIT_ULL(32)
+
 static inline u64 bpf_xreg(u32 frameno, u32 xregno)
 {
 	return (u64)frameno << 32 | xregno;
@@ -474,6 +477,7 @@ struct loop_stack_entry {
 	/* an xreg: how many times the program came back to the header */
 	struct scalar trip_index;
 	bool trip_widened;	/* it was moved to a threshold, or it does not grow */
+	u64 exit_threshold;	/* by the jumps that the state passed and that leave the loop */
 };
 
 /* The state is in a walk on patience, which may not get to the end of the loop */
@@ -863,6 +867,7 @@ enum bpf_loop_kind {
 
 /* What a pass finds about a loop */
 struct bpf_loop_per_pass {
+	bool needs_guard;	/* see bpf_flow_needs_guard() */
 	bool has_leftover;	/* the peeled trips were not enough */
 	/* a check failed in a state that the loop kept apart, with no other suspect */
 	bool has_unproven;
@@ -897,16 +902,22 @@ struct bpf_loop {
 	bool peeled_apart;	/* the join rule holds for states that start a peeled trip */
 	bool disjoint_apart;	/* disjoint values in data_deps stay apart, also in the leftover */
 	);
+	struct bpf_loop_per_pass last_pass;	/* the last pass whose partition was kept */
 	bool partitioned;	/* the last partition was for this loop */
 	bool peeled_joined;	/* at the start of a peeled trip, against the join rule */
+	bool guarded;		/* states take the edges of may_goto */
 	struct bpf_iv_threshold *iv_thresholds;	/* where an iv can stop, see equation_join.c */
 	u32 iv_threshold_cnt, iv_threshold_cap;
+	u32 leftover_epoch;	/* how many leftovers started */
+	u64 exit_trip;		/* the trip in which the loop can end, 0 if it is not known */
+	/* they move with the trip index, or only at first, see bpf_note_linear_xregs() */
+	DECLARE_BITMAP(linear_xregs, MAX_BPF_XREG);
+	DECLARE_BITMAP(nonlinear_xregs, MAX_BPF_XREG);
 	struct bpf_loop_per_pass this_pass;
 	/* sorted constants of the loop, the largest and the smallest constant that an insn adds */
 	s64 *thresholds;
 	u32 threshold_cnt, threshold_cap;
 	s32 max_step, min_step;
-	bool guarded;
 };
 
 static inline bool bpf_loop_has_budget(const struct bpf_loop *loop)
@@ -1026,6 +1037,8 @@ struct bpf_insn_aux_data {
 	u16 stack_ptrs; /* bitmask of regs that may hold a frame pointer here (arg_track) */
 
 	unsigned int orig_idx; /* original instruction index, initialized once */
+	u32 thresholds_epoch;	/* see bpf_collect_iv_thresholds() */
+	u8 iv_operand;		/* the operand of the jump that tests the iv, + 1 */
 	/* registers alive before this instruction. */
 	u16 live_regs_before;
 	/*
@@ -1712,6 +1725,8 @@ u64 bpf_hash_apart_xregs(struct bpf_verifier_env *env, const struct bpf_verifier
 u64 bpf_hash_args(struct bpf_verifier_env *env, const struct bpf_verifier_state *st, u64 hash);
 void bpf_range_of_data_dep(struct bpf_verifier_env *env, const struct bpf_verifier_state *st,
 			   u32 *first, u32 *last);
+bool bpf_xreg_in_data_deps(struct bpf_verifier_env *env, const struct bpf_verifier_state *st,
+			   u32 fr, u32 xregno);
 bool bpf_xreg_in_deps(struct bpf_verifier_env *env, const struct bpf_verifier_state *st,
 		      u32 fr, u32 xregno);
 void bpf_note_reads_from_unproven(struct bpf_verifier_env *env, u32 idx);
@@ -2469,6 +2484,8 @@ void bpf_equations_fill(struct bpf_verifier_env *env, struct bpf_func_state *fra
 void bpf_equations_refine_all(struct bpf_verifier_env *env, struct bpf_verifier_state *st);
 void bpf_equations_jump(struct bpf_verifier_env *env, struct bpf_verifier_state *st, int idx,
 			bool taken);
+void bpf_equations_next_trip(struct bpf_verifier_env *env, struct bpf_verifier_state *st,
+			     u32 depth);
 bool bpf_equations_subsume(struct bpf_verifier_env *env, const struct bpf_verifier_state *old,
 			   const struct bpf_verifier_state *cur);
 void bpf_equations_print(struct bpf_verifier_env *env, const struct bpf_verifier_state *st);
@@ -2478,6 +2495,7 @@ void bpf_equations_pre_join(struct bpf_verifier_env *env, struct bpf_verifier_st
 void bpf_equations_post_join(struct bpf_verifier_env *env, struct bpf_verifier_state *dst,
 			     const struct bpf_verifier_state *src);
 u32 bpf_equations_bytes(const struct bpf_equations *eqs);
+void bpf_collect_iv_thresholds(struct bpf_verifier_env *env);
 void scalar_bounds_sync(struct scalar *s);
 bool scalar_subsumes(const struct scalar *old, const struct scalar *cur);
 bool scalars_fit_in_bits(const struct scalar *a, const struct scalar *b, u32 bits);
diff --git a/kernel/bpf/equation.c b/kernel/bpf/equation.c
index 041311f0d56..76c04e33da9 100644
--- a/kernel/bpf/equation.c
+++ b/kernel/bpf/equation.c
@@ -1132,6 +1132,91 @@ void bpf_equations_fill(struct bpf_verifier_env *env, struct bpf_func_state *fra
 	env->eq_env->fill_bits = size * BITS_PER_BYTE;
 }
 
+/*
+ * The state came back to the header of the loop at @depth.
+ * A trip count or may_goto ends the loop long before the trip index gets to 2^63.
+ */
+void bpf_equations_next_trip(struct bpf_verifier_env *env, struct bpf_verifier_state *st, u32 depth)
+{
+	struct scalar *trip_index = &st->frame[st->curframe]->loop_stack[depth].trip_index;
+	struct bpf_xreg_equation *xreg_eq;
+
+	scalar_add_const(trip_index, 1);
+	trip_index->r64 = cnum64_intersect(trip_index->r64, cnum64_from_urange(0, S64_MAX));
+	scalar_bounds_sync(trip_index);
+	xreg_eq = bpf_find_xreg_equation(&st->equations,
+					 bpf_xreg(st->curframe, BPF_XREG_TRIP + depth));
+	if (!xreg_eq)
+		return;
+	xreg_eq->off++;
+	refine_sym_from_xreg(env, st, xreg_eq);
+	propagate_bounds(env, st, false);
+	bpf_equations_clean(env, st);
+}
+
+/*
+ * @rest is a constant minus a number, and not an iv that counts down. An equation has a cost,
+ * so wait until an unproven insn needs @len.
+ */
+static bool tests_rest(struct bpf_verifier_env *env, u32 len, u32 rest)
+{
+	const struct bpf_verifier_state *st = env->cur_state;
+	const struct bpf_xreg_equation *xreg_eq, *trip;
+	u32 i;
+
+	xreg_eq = bpf_find_xreg_equation(&st->equations, bpf_reg_to_xreg(st, rest));
+	if (!xreg_eq || xreg_eq->is_ptr || xreg_eq->coef > 0)
+		return false;
+	for (i = 0; i < st->frame[st->curframe]->loop_stack_cnt; i++) {
+		trip = bpf_find_xreg_equation(&st->equations,
+					      bpf_xreg(st->curframe, BPF_XREG_TRIP + i));
+		if (trip && trip->sym == xreg_eq->sym)
+			return false;
+	}
+	if (env->path_sensitive || bpf_xreg_in_data_deps(env, st, st->curframe, len))
+		return true;
+	env->imprecise |= !env->err;
+	return false;
+}
+
+/*
+ * The ranges of two numbers do not show how far they are from each other:
+ *	for (i = 0..3; i != n; i++)		for (p = t + 0..3; p != t + n; p++)
+ *	if (len > 64 - off) return; read(buf + off, len);
+ * Give the difference a sym. bpf_equations_jump() refines it if it does not wrap.
+ * For an iv and its bound the first trip makes the equation. The other trips find it.
+ */
+static void add_distance_equation(struct bpf_verifier_env *env, const struct bpf_insn *insn)
+{
+	struct bpf_verifier_state *st = env->cur_state;
+	const struct loop_stack_entry *e = bpf_top_loop(st->frame[st->curframe]);
+	struct expr a, b, diff;
+	struct scalar bounds;
+	struct equation_pos pos = {};
+	u8 op = BPF_OP(insn->code);
+	bool is_ptr, is_eq = op == BPF_JEQ || op == BPF_JNE;
+
+	if (op == BPF_JSET || !compares_numbers(st, insn))
+		return;
+	if (is_eq && (!e || (e->peeled && e->trip)))
+		return;
+	if (!is_eq && !tests_rest(env, insn->dst_reg, insn->src_reg) &&
+	    !tests_rest(env, insn->src_reg, insn->dst_reg))
+		return;
+	bpf_equations_clean(env, st);
+	if (!assign_sym(env, bpf_reg_to_xreg(st, insn->dst_reg), true, &a, &is_ptr) ||
+	    !assign_sym(env, bpf_reg_to_xreg(st, insn->src_reg), true, &b, &is_ptr) ||
+	    bpf_find_next_diff(env, &st->equations, &a, &b, &pos, &diff))
+		return;
+	bpf_eval_diff(env, st, &a, &b, &bounds);
+	/* len can get its bound from this jump */
+	if (!is_eq || !scalar_is_unknown(&bounds))
+		bpf_add_sym_equation(env, &st->equations, (struct bpf_sym_equation){
+			{ -1, a.coef, -b.coef },
+			{ bpf_new_sym(env, &st->equations, &bounds), a.var, b.var },
+			env->insn_idx, a.off - b.off });
+}
+
 /* Note the operands. Delete the equations of the registers that the insn writes. */
 void bpf_equations_before_insn(struct bpf_verifier_env *env)
 {
@@ -1169,6 +1254,9 @@ void bpf_equations_before_insn(struct bpf_verifier_env *env)
 					   &eq_env->operand_expr[i], &eq_env->is_ptr[i]);
 		}
 	}
+	if (bpf_insn_is_cond_jump(insn->code) && BPF_SRC(insn->code) == BPF_X && !st->speculative &&
+	    insn->dst_reg < BPF_REG_FP && insn->src_reg < BPF_REG_FP)
+		add_distance_equation(env, insn);
 	if (class == BPF_JMP && op == BPF_EXIT && fr && !st->frame[fr]->in_callback_fn)
 		copy_xreg_equation(env, eqs, bpf_xreg(fr - 1, BPF_REG_0), bpf_xreg(fr, BPF_REG_0));
 	if (class == BPF_JMP && op == BPF_CALL) {
@@ -2140,6 +2228,45 @@ bool bpf_equations_subsume(struct bpf_verifier_env *env, const struct bpf_verifi
 
 /* Join */
 
+static void join_trip_index(struct bpf_verifier_env *env, struct bpf_verifier_state *dst,
+			    const struct bpf_verifier_state *src, struct bpf_loop *leftover_loop,
+			    bool widen)
+{
+	const struct loop_stack_entry *s;
+	struct loop_stack_entry *e;
+	u64 xreg, threshold;
+	struct scalar old;
+	u32 fr, i;
+
+	for (fr = 0; fr <= dst->curframe; fr++) {
+		e = dst->frame[fr]->loop_stack;
+		s = src->frame[fr]->loop_stack;
+		for (i = 0; i < dst->frame[fr]->loop_stack_cnt; i++, e++, s++) {
+			xreg = bpf_xreg(fr, BPF_XREG_TRIP + i);
+			old = e->trip_index;
+			scalar_union(&e->trip_index, &s->trip_index);
+			/* an outer loop still has to find its thresholds */
+			e->trip_widened |= s->trip_widened || (widen && old.grew_once &&
+							       e->loop->header == dst->insn_idx);
+			e->exit_threshold = e->loop == leftover_loop ? s->exit_threshold :
+					    max(e->exit_threshold, s->exit_threshold);
+			if (!leftover_loop || scalar_equal(&e->trip_index, &old))
+				continue;
+			threshold = widen ? bpf_guess_trip_threshold(env, dst, e, xreg) : 0;
+			e->trip_index.grew_once = true;
+			if (!threshold || threshold < cnum64_umax(e->trip_index.r64))
+				continue;
+			e->trip_widened = true;
+			if (threshold != S64_MAX)
+				e->loop->exit_trip = max(e->loop->exit_trip, threshold + 1);
+			scalar_set_unknown(&old);
+			old.r64 = cnum64_from_urange(cnum64_umin(e->trip_index.r64), threshold);
+			scalar_bounds_sync(&old);
+			scalar_union(&e->trip_index, &old);
+		}
+	}
+}
+
 /*
  * Make the equations of @dst hold for @src too. Call it before the xregs are joined.
  * @leftover_loop: the states are at its header. @widen: @src came around it.
@@ -2162,10 +2289,13 @@ void bpf_equations_pre_join(struct bpf_verifier_env *env, struct bpf_verifier_st
 		normalize_equations(env, &env->eq_env->join_state);
 		while (!check_equations(env, eqs, dst, eqs) || !check_equations(env, eqs, src, eqs))
 			normalize_equations(env, &env->eq_env->join_state);
+		if (widen && !dst->speculative)
+			bpf_note_linear_xregs(env, dst, eqs);
 		eqs->needs_refine = widen || dst->equations.needs_refine ||
 				    src->equations.needs_refine;
 		swap(dst->equations, *eqs);
 	}
+	join_trip_index(env, dst, src, leftover_loop, widen);
 }
 
 /* The xregs of @dst are joined. Some of them are gone. */
diff --git a/kernel/bpf/equation.h b/kernel/bpf/equation.h
index 564ff6e5e6c..0b39d99c9b7 100644
--- a/kernel/bpf/equation.h
+++ b/kernel/bpf/equation.h
@@ -190,4 +190,9 @@ void bpf_eval_diff(struct bpf_verifier_env *env, const struct bpf_verifier_state
 void bpf_guess_equations(struct bpf_verifier_env *env, const struct bpf_verifier_state *dst,
 			 const struct bpf_verifier_state *src, struct bpf_loop *leftover_loop,
 			 bool widen);
+void bpf_note_linear_xregs(struct bpf_verifier_env *env, const struct bpf_verifier_state *dst,
+			   const struct bpf_equations *join);
+u64 bpf_guess_trip_threshold(struct bpf_verifier_env *env, const struct bpf_verifier_state *dst,
+			     const struct loop_stack_entry *e, u64 xreg);
+
 #endif
diff --git a/kernel/bpf/equation_join.c b/kernel/bpf/equation_join.c
index d47c4f04453..84a866e960e 100644
--- a/kernel/bpf/equation_join.c
+++ b/kernel/bpf/equation_join.c
@@ -485,6 +485,28 @@ static void join_bounds_by_selector(struct equation_join *j, u64 var, bool alway
 		join_diff(j, make_expr(1, var, 0), make_expr(max_slope, j->selector, 0), false);
 }
 
+/* Where the trip index of @e in @dst can stop. 0: it is too early to know. */
+u64 bpf_guess_trip_threshold(struct bpf_verifier_env *env, const struct bpf_verifier_state *dst,
+			     const struct loop_stack_entry *e, u64 xreg)
+{
+	const struct bpf_iv_threshold *threshold;
+	u64 value = S64_MAX;
+	int kind;
+
+	/* without an equation nothing limits it */
+	if (!bpf_find_xreg_equation(&dst->equations, xreg))
+		return value;
+	if (!e->trip_index.grew_once)
+		return 0;
+	if (e->exit_threshold < value && e->exit_threshold >= cnum64_umax(e->trip_index.r64))
+		return e->exit_threshold;
+	for (kind = THRESHOLD_EXIT_JUMP; kind <= THRESHOLD_BODY_JUMP && value == S64_MAX; kind++)
+		for_each_iv_threshold(env, e->loop, threshold, kind)
+			if (threshold->value >= cnum64_umax(e->trip_index.r64))
+				value = min_t(u64, value, threshold->value);
+	return value;
+}
+
 /*
  * Guess the equations that hold for @dst and @src, see bpf_equations_pre_join().
  * The first join shows what a trip moves. The next walk finds the thresholds.
@@ -539,3 +561,257 @@ void bpf_guess_equations(struct bpf_verifier_env *env, const struct bpf_verifier
 	for (i = 0, sym_cnt = j.eqs->sym_cnt; j.selector != VAR_NONE && i < sym_cnt; i++)
 		join_bounds_by_selector(&j, VAR_SYM | i, selector_is_trip);
 }
+
+/*
+ * Which xregs move with the trip index in @dst? Some do not in the equations of the @join:
+ *	i = (i + 1) & 63;
+ */
+void bpf_note_linear_xregs(struct bpf_verifier_env *env, const struct bpf_verifier_state *dst,
+			   const struct bpf_equations *join)
+{
+	const struct bpf_func_state *f = dst->frame[dst->curframe];
+	u64 trip_xreg = bpf_xreg(dst->curframe, BPF_XREG_TRIP + f->loop_stack_cnt - 1);
+	const struct bpf_xreg_equation *old_trip =
+		bpf_find_xreg_equation(&dst->equations, trip_xreg), *xreg_eq, *new;
+	const struct bpf_xreg_equation *new_trip = bpf_find_xreg_equation(join, trip_xreg);
+	struct bpf_loop *loop;
+
+	if (!f->loop_stack_cnt || !old_trip || !new_trip)
+		return;
+	loop = bpf_top_loop(f)->loop;
+	for_each_xreg_equation(env, &dst->equations, xreg_eq) {
+		if (xreg_eq->sym != old_trip->sym || xreg_eq->xreg >> 32 != dst->curframe ||
+		    (u32)xreg_eq->xreg >= BPF_XREG_TRIP)
+			continue;
+		new = bpf_find_xreg_equation(join, xreg_eq->xreg);
+		if (!new || new->sym != new_trip->sym)
+			__set_bit((u32)xreg_eq->xreg, loop->nonlinear_xregs);
+		else if (!__test_and_set_bit((u32)xreg_eq->xreg, loop->linear_xregs))
+			env->new_linear_xreg = true;
+	}
+}
+
+/* Thresholds */
+
+/*
+ * A jump gives thresholds in many states. Keep the last one in the direction of @step.
+ * No @step: @value is for the syms of the current state only.
+ */
+static void add_iv_threshold(struct bpf_verifier_env *env, struct bpf_loop *loop, s64 value,
+			     s64 step, enum iv_threshold_kind kind, u32 idx)
+{
+	struct bpf_iv_threshold *threshold;
+
+	for_each_iv_threshold(env, loop, threshold, kind)
+		if (threshold->insn_idx == env->insn_idx && threshold->idx == idx)
+			break;
+	if (threshold < loop->iv_thresholds + loop->iv_threshold_cnt) {
+		if (value == threshold->value || (step && (step > 0) == (value < threshold->value)))
+			return;
+		threshold->value = value;
+	} else if (bpf_grow_array(env, &loop->iv_thresholds, &loop->iv_threshold_cap,
+				  loop->iv_threshold_cnt + 1, sizeof(*threshold))) {
+		loop->iv_thresholds[loop->iv_threshold_cnt++] =
+			(struct bpf_iv_threshold){ value, kind, env->insn_idx, idx };
+	}
+	if (env->log.level & BPF_LOG_LEVEL2)
+		bpf_log(&env->log, "loop at %d: %s has threshold %lld\n", loop->header,
+			kind <= THRESHOLD_BODY_JUMP ? "the trip index" : "a number", value);
+}
+
+/* Write @expr as a function of @trip_var. It starts from the far end of what is added. */
+static bool match_iv(struct bpf_verifier_env *env, const struct bpf_verifier_state *st,
+		     struct expr *expr, u64 trip_var, bool *low32, bool *start_is_range)
+{
+	const struct bpf_sym_equation *sym_eq, *ext;
+	struct scalar bounds;
+	struct expr rest;
+	u32 n, i, k;
+
+	for (n = 0;
+	     expr->coef && expr->var != trip_var && n < st->equations.sym_equation_cnt; n++) {
+		if (!var_is_sym(expr->var) || over_limit(env))
+			return false;
+		ext = NULL;
+		for_each_sum(env, &st->equations, sym_eq) {
+			i = find_sym_pos(sym_eq, var_symno(expr->var));
+			if (i == 3)
+				continue;
+			k = find_sym_pos(sym_eq, var_symno(trip_var));
+			if (!i && !(u8)sym_eq->coef[2])
+				ext = sym_eq;
+			if (k == 3 || !is_plus_minus_one(sym_eq->coef[i]))
+				continue;
+			rest = sym_expr(-expr->coef * sym_eq->coef[i] * sym_eq->coef[3 - i - k],
+					sym_eq->sym[3 - i - k],
+					expr->off - expr->coef * sym_eq->coef[i] * sym_eq->off);
+			bpf_eval_expr(env, st, &rest, &bounds);
+			*expr = make_expr(-expr->coef * sym_eq->coef[i] * sym_eq->coef[k],
+					  trip_var, bounds.r64.base);
+			if (bounds.r64.size > U32_MAX && bounds.r32.size == U32_MAX)
+				return false;
+			*start_is_range = bounds.r64.size;
+			*low32 |= bounds.r64.size >= U32_MAX;
+			if (*low32)
+				expr->off = bounds.r32.base +
+					    (expr->coef < 0 ? bounds.r32.size : 0);
+			else if (expr->coef < 0)
+				expr->off += bounds.r64.size;
+			return expr->coef;
+		}
+		if (!ext)
+			return false;
+		*expr = expr_scale(rhs_expr(ext, 0), expr->coef, expr->off);
+	}
+	return expr->coef && expr->var == trip_var;
+}
+
+/*
+ * "*@x @op @bound" holds in the trips that continue. In how many, if each adds @step to it?
+ * *@x becomes the end of the range in which they continue.
+ */
+static u64 compute_trip_count(s64 step, u64 *x, u8 op, bool jmp32, struct scalar bound)
+{
+	struct cnum64 arc;
+	struct scalar body_range;
+	u64 left;
+
+	if (op == BPF_JNE && jmp32)
+		scalar_set_const(&bound, bound.r32.base + (step > 0 ? bound.r32.size : 0));
+	else if (op == BPF_JNE)
+		scalar_set_const(&bound, bound.r64.base + (step > 0 ? bound.r64.size : 0));
+	scalar_set_unknown(&body_range);
+	scalars_refine_cond_op(&body_range, &bound, op, jmp32);
+	arc = jmp32 ? (struct cnum64){ body_range.r32.base, body_range.r32.size } : body_range.r64;
+	left = jmp32 ? (u32)(*x - arc.base) : *x - arc.base;
+	if (left > arc.size)
+		return 0;
+	*x = arc.base + (step > 0 ? arc.size : 0);
+	*x = !jmp32 ? *x : op == bpf_signed_opcode(op) && op != BPF_JNE ? (s32)*x : (u32)*x;
+	return min(div64_u64(step > 0 ? arc.size - left : left, abs64(step)), U64_MAX - 1) + 1;
+}
+
+static bool insn_is_in_loop(struct bpf_verifier_env *env, const struct bpf_loop *loop, int idx)
+{
+	int h = bpf_loop_at_index(env, idx);
+
+	return h == loop->header || bpf_is_nested_loop(env, h, loop->header);
+}
+
+/* The jump stays in the loop if operand 0 or 1, or their difference, is "op" the bound */
+static u8 loop_cond_opcode(const struct bpf_insn *insn, bool taken, int i)
+{
+	u8 op = taken ? BPF_OP(insn->code) : bpf_rev_opcode(BPF_OP(insn->code));
+
+	return !i ? op : i == 1 ? bpf_flip_opcode(op) : bpf_signed_opcode(op);
+}
+
+/* The difference starts from @x, but not further out than @bound[1] - @bound[0] can be */
+static s64 clamp_diff_start(const struct scalar *bound, s64 x, s64 step)
+{
+	s64 a = step < 0 ? cnum64_smax(bound[1].r64) : cnum64_smin(bound[1].r64);
+	s64 b = step < 0 ? cnum64_smin(bound[0].r64) : cnum64_smax(bound[0].r64);
+
+	if (check_sub_overflow(a, b, &a))
+		return x;
+	return step < 0 ? min(x, a) : max(x, a);
+}
+
+/* The jump at env->insn_idx tests a number that moves with the trip index. Find thresholds. */
+void bpf_collect_iv_thresholds(struct bpf_verifier_env *env)
+{
+	struct bpf_insn_aux_data *aux = &env->insn_aux_data[env->insn_idx];
+	const struct bpf_insn *insn = &env->prog->insnsi[env->insn_idx];
+	const struct bpf_verifier_state *st = env->cur_state;
+	const struct bpf_func_state *f = st->frame[st->curframe];
+	bool is_ptr, is_iv[3], low32[3], start_is_range[3] = {}, stays_in_loop[2], is_body_jump;
+	struct loop_stack_entry *e = bpf_top_loop(f);
+	struct expr trip, step, expr[3];
+	struct scalar bound[3];
+	struct equation_pos pos = {};
+	bool tests_carry = false;
+	u32 i, n;
+	u64 start, x, cnt;
+	u8 op;
+
+	if (!env->eq_env || !e || e->loop->kind != BPF_LOOP_JUMPS ||
+	    (env->path_sensitive ? !aux->iv_operand : !st->equations.xreg_equation_cnt ||
+				   (e->trip_widened &&
+				    aux->thresholds_epoch == e->loop->leftover_epoch)))
+		return;
+	expr[1] = make_expr(0, 0, insn->imm);
+	if (!bpf_xreg_expr(env, st, bpf_reg_to_xreg(st, insn->dst_reg), &expr[0], &is_ptr) ||
+	    (BPF_SRC(insn->code) == BPF_X &&
+	     !bpf_xreg_expr(env, st, bpf_reg_to_xreg(st, insn->src_reg), &expr[1], &is_ptr)))
+		return;
+	bpf_eval_expr(env, st, &expr[1], &bound[0]);
+	bpf_eval_expr(env, st, &expr[0], &bound[1]);
+	scalar_set_const(&bound[2], 0);
+	stays_in_loop[0] = insn_is_in_loop(env, e->loop, env->insn_idx + 1);
+	stays_in_loop[1] = insn_is_in_loop(env, e->loop, env->insn_idx + insn->off + 1);
+	is_body_jump = stays_in_loop[0] && stays_in_loop[1];
+	low32[0] = low32[1] = low32[2] = BPF_CLASS(insn->code) == BPF_JMP32;
+	x = bpf_xreg(st->curframe, BPF_XREG_TRIP + f->loop_stack_cnt - 1);
+	if (!bpf_xreg_expr(env, st, x, &trip, &is_ptr) || !var_is_sym(trip.var))
+		return;
+	if (expr[0].coef && expr[1].coef &&
+	    bpf_find_next_diff(env, &st->equations, &expr[0], &expr[1], &pos, &expr[2])) {
+		/* it gets to 0 */
+		add_iv_threshold(env, e->loop, expr[0].off - expr[1].off, 0, THRESHOLD_DIFF, 0);
+		add_iv_threshold(env, e->loop, expr[1].off - expr[0].off, 0, THRESHOLD_DIFF, 1);
+		add_iv_threshold(env, e->loop, -expr[2].coef * expr[2].off, 0, THRESHOLD_DIFF, 2);
+	} else {
+		expr[2].coef = 0;
+	}
+	for (i = 0; i < 3; i++) {
+		is_iv[i] = match_iv(env, st, &expr[i], trip.var, &low32[i], &start_is_range[i]);
+		/* the step in one trip */
+		step = make_expr(0, 0, expr[i].coef);
+		is_iv[i] = is_iv[i] && bpf_expr_div_exact(&step, 0, trip.coef);
+		expr[i].coef = step.off;
+	}
+	/* they do not get closer */
+	if (is_iv[0] && is_iv[1] && !start_is_range[0] && !start_is_range[1] &&
+	    expr[0].coef == expr[1].coef) {
+		/* but 'x != (u32)x' is 'x > U32_MAX', see refine_carry(). Operand i is x. */
+		i = cnum64_umax(bound[1].r64) <= U32_MAX;
+		if ((insn->code != (BPF_JMP | BPF_JNE | BPF_X) &&
+		     insn->code != (BPF_JMP | BPF_JEQ | BPF_X)) ||
+		    expr[0].off == expr[1].off || (u32)(expr[0].off - expr[1].off) ||
+		    cnum64_umax(bound[i].r64) > U32_MAX)
+			return;
+		scalar_set_const(&bound[i], U32_MAX);
+		is_iv[!i] = is_iv[2] = low32[i] = false;
+		tests_carry = true;
+	}
+	start = e->trip_index.r64.base;
+	for (n = is_iv[0] && is_iv[1] && is_iv[2] ? 4 : 0; n < 6; n++) {
+		i = n / 2;
+		if (!is_iv[i] || !stays_in_loop[n & 1] || (is_body_jump && start_is_range[i]))
+			continue;
+		aux->thresholds_epoch = e->loop->leftover_epoch;
+		/* note_trips_left() takes the other operand as the bound */
+		if (i < 2 && !tests_carry)
+			aux->iv_operand = i + 1;
+		x = expr[i].coef * (start - trip.off) + expr[i].off;
+		if (i == 2 && start_is_range[i])
+			x = clamp_diff_start(bound, low32[i] ? (s32)x : x, expr[i].coef);
+		op = loop_cond_opcode(insn, n & 1, i);
+		if (tests_carry)
+			op = op == BPF_JNE ? BPF_JGT : BPF_JLE;
+		cnt = compute_trip_count(expr[i].coef, &x, op, low32[i], bound[i]);
+		/* its start is not known, so the trip index does not give its end */
+		if (cnt && start_is_range[i] && i < 2) {
+			add_iv_threshold(env, e->loop, x, expr[i].coef, THRESHOLD_SYM, 2 * n);
+			add_iv_threshold(env, e->loop, x + expr[i].coef, expr[i].coef,
+					 THRESHOLD_SYM, 2 * n + 1);
+		}
+		if (!cnt || cnt > BPF_MAX_TRIPS)
+			continue;
+		add_iv_threshold(env, e->loop, start + cnt, 1, is_body_jump, 2 * n);
+		if (is_body_jump)
+			add_iv_threshold(env, e->loop, start + cnt + 1, 1, is_body_jump, 2 * n + 1);
+		else
+			e->exit_threshold = min(e->exit_threshold, start + cnt);
+	}
+}
diff --git a/kernel/bpf/flow.c b/kernel/bpf/flow.c
index fbd81c1447d..856d38cc973 100644
--- a/kernel/bpf/flow.c
+++ b/kernel/bpf/flow.c
@@ -110,6 +110,7 @@ struct bpf_flow {
 	unsigned long *bb_starts;	/* insn starts a basic block */
 	unsigned long *join_points;	/* more than one edge leads to the insn */
 	struct bpf_loop call_loop;	/* from the exit of a function to its next call */
+	u32 start_cnt;			/* of passes and of path-sensitive runs */
 
 	/* of the pass */
 	u64 *cost;			/* per function */
@@ -416,6 +417,8 @@ int bpf_flow_place_guards(struct bpf_verifier_env *env)
 		loop->rt_bounded = flow_loop_is_bounded(env, h);
 		/* also when it's bounded: the main pass may find that it's not */
 		flow_place_guards(env, h, seen);
+		/* pass 0 does not know the trip count before it ends */
+		loop->guarded = loop->has_guards && !bpf_prog_is_offloaded(env->prog->aux);
 		if (aux[h].guard_at_header)
 			ret = 1;
 	}
@@ -973,6 +976,22 @@ static bool flow_same_entry(struct bpf_loop *loop, const struct flow_state *t,
 	       flow_loop_entry(&t->st, loop)->entry_id == flow_loop_entry(&s->st, loop)->entry_id;
 }
 
+/* @t is from an earlier walk over a leftover. The header state of @s subsumes that of @t. */
+static bool flow_is_stale(const struct flow_state *t, const struct flow_state *s)
+{
+	const struct loop_stack_entry *a, *b;
+	u32 fr, i;
+
+	for (fr = 0; !t->pending && fr <= s->st.curframe; fr++) {
+		a = t->st.frame[fr]->loop_stack;
+		b = s->st.frame[fr]->loop_stack;
+		for (i = 0; i < s->st.frame[fr]->loop_stack_cnt; i++, a++, b++)
+			if (a->entry_id == b->entry_id && a->trip < b->trip)
+				return true;
+	}
+	return false;
+}
+
 /*
  * All states arrive here. @s is
  * - pruned, if a state subsumes it,
@@ -1029,9 +1048,14 @@ static int flow_prune_or_join(struct bpf_verifier_env *env, struct flow_state *s
 			joined = true;
 			continue;
 		}
+		if (!leftover_loop && s->kind == FLOW_AT && flow_is_stale(t, s)) {
+			flow_free_state(env, t);
+			continue;
+		}
 		joined = true;
 		widened = leftover_loop;
 		s->returned |= widened;
+		/* what enters did not grow in this loop */
 		widen = !t->pending && !enters;
 		flow_unlink(env, t);
 		err = bpf_states_join(env, &t->st, &s->st, leftover_loop, widen);
diff --git a/kernel/bpf/precision.c b/kernel/bpf/precision.c
index efee61c4e08..84090f9a8e3 100644
--- a/kernel/bpf/precision.c
+++ b/kernel/bpf/precision.c
@@ -40,6 +40,16 @@ u32 bpf_frame_mask(struct bpf_verifier_env *env, unsigned long *masks,
 	return words * BITS_PER_LONG;
 }
 
+bool bpf_xreg_in_data_deps(struct bpf_verifier_env *env, const struct bpf_verifier_state *st,
+			   u32 fr, u32 xregno)
+{
+	unsigned long data_deps[XREG_WORDS];
+
+	return env->precision->data_deps &&
+	       xregno < bpf_frame_mask(env, env->precision->data_deps, st, fr, data_deps) &&
+	       test_bit(xregno, data_deps);
+}
+
 bool bpf_xreg_in_deps(struct bpf_verifier_env *env, const struct bpf_verifier_state *st,
 		      u32 fr, u32 xregno)
 {
diff --git a/kernel/bpf/states.c b/kernel/bpf/states.c
index 23e3adb9822..d8026295644 100644
--- a/kernel/bpf/states.c
+++ b/kernel/bpf/states.c
@@ -583,6 +583,34 @@ u64 bpf_hash_join_key(const struct bpf_verifier_env *env, const struct bpf_verif
 	return hash;
 }
 
+/*
+ * If may_goto or an iterator stops the loop, its trip index can start again from a smaller
+ * number, never from a larger one: see bpf_equations_next_trip().
+ */
+static bool trip_index_safe(const struct loop_stack_entry *old, const struct loop_stack_entry *cur)
+{
+	u64 min = cnum64_umin(old->trip_index.r64);
+	struct scalar first;
+
+	if (old->peeled || scalar_subsumes(&old->trip_index, &cur->trip_index))
+		return true;
+	if (!old->loop->rt_bounded && !old->loop->this_pass.needs_guard)
+		return false;
+	scalar_set_const(&first, min);
+	return min <= cnum64_umin(cur->trip_index.r64) &&
+	       scalar_subsumes(&old->trip_index, &first);
+}
+
+static bool loop_stack_safe(struct bpf_func_state *old, struct bpf_func_state *cur)
+{
+	u32 i;
+
+	for (i = 0; i < old->loop_stack_cnt; i++)
+		if (!trip_index_safe(&old->loop_stack[i], &cur->loop_stack[i]))
+			return false;
+	return true;
+}
+
 /* compare two verifier states
  *
  * The state that gets to an insn doesn't have to be looked at when there is
@@ -603,10 +631,9 @@ static bool func_states_equal(struct bpf_verifier_env *env, struct bpf_func_stat
 	u16 live_regs = env->insn_aux_data[insn_idx].live_regs_before;
 	u16 i;
 
-	if (old->callback_depth > cur->callback_depth)
-		return false;
-
-	if (!old->no_stack_arg_load && cur->no_stack_arg_load)
+	if (old->callback_depth > cur->callback_depth ||
+	    (!old->no_stack_arg_load && cur->no_stack_arg_load) ||
+	    !loop_stack_safe(old, cur))
 		return false;
 
 	for (i = 0; i < MAX_BPF_REG; i++)
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index f8779c51cf7..b6de3447b08 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -19253,6 +19253,7 @@ static int check_cond_jmp_op(struct bpf_verifier_env *env,
 	env->false_reg2 = *src_reg;
 	env->true_reg1 = *dst_reg;
 	env->true_reg2 = *src_reg;
+	bpf_collect_iv_thresholds(env);
 	pred = is_branch_taken(env, dst_reg, src_reg, opcode, is_jmp32);
 	if (pred == 1) {
 		/* Only follow the goto, ignore fall-through. If needed, push
@@ -20747,7 +20748,9 @@ static struct loop_stack_entry *push_loop(struct bpf_verifier_env *env,
 		.held_cnt = held_cnt(env->cur_state),
 		.entry_id = ++env->loop_entry_cnt,
 		.peeled = true,
+		.exit_threshold = U64_MAX,
 	};
+	scalar_set_const(&frame->loop_stack[cnt].trip_index, 0);
 	frame->loop_stack_cnt++;
 	return &frame->loop_stack[cnt];
 }
@@ -20768,10 +20771,17 @@ static void leave_peeled_trips(struct bpf_verifier_env *env, struct loop_stack_e
 {
 	struct bpf_func_state *frame;
 	struct bpf_reg_state *reg;
+	u32 i;
 
 	entry->peeled = false;
 	entry->loop->this_pass.has_leftover = true;
+	entry->loop->leftover_epoch++;
+	/* the leftover of the last pass had no trip count */
+	entry->loop->guarded |= entry->loop->last_pass.needs_guard && !env->cur_state->speculative;
+	entry->trip_index.grew_once = entry->trip_widened = false;
 	bpf_for_each_reg_in_vstate(env->cur_state, frame, reg, reg->grew_once = false);
+	for (i = 0; i < env->cur_state->equations.sym_cnt; i++)
+		env->cur_state->equations.syms[i].grew_once = false;
 }
 
 /*
@@ -20864,6 +20874,8 @@ static void loop_stack_pop(struct bpf_verifier_env *env)
 				verbose(env, "exiting loop %d\n",
 					frame->loop_stack[i].loop->header);
 	frame->loop_stack_cnt = new_cnt;
+	if (new_cnt != cnt)
+		bpf_equations_clean(env, env->cur_state);
 }
 
 static bool xreg_has_id(struct bpf_verifier_state *st, u32 id)
@@ -20938,6 +20950,13 @@ static int next_trip(struct bpf_verifier_env *env, struct loop_stack_entry *entr
 		     bool *starts_leftover)
 {
 	entry->trip++;
+	if (entry->loop->kind != BPF_LOOP_RECURSION) {
+		bpf_equations_next_trip(env, env->cur_state, entry - cur_func(env)->loop_stack);
+		/* No run makes 2^63 trips. The header is not dead code: a trip started there. */
+		if (infeasible_state_ends(env) ||
+		    (env->bypass_spec_v1 && cnum64_is_empty(entry->trip_index.r64)))
+			return 1;
+	}
 	if (!entry->peeled)
 		return check_held_in_leftover(env, entry);
 	return 0;
-- 
2.55.0

