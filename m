Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794022805;
	b=SnVyqRx0JQpYjk3pobQtMoWsN0zylyF532JhTAGuSeDbsDyi78AqXRTlLwH66Ih7o11C
	 i2bLRg0rnI9slKVKOW5e6JqqIfkLrex9J1+vhnBl27kpAAheQdB/KG4KT4zHh7LAAHoJD
	 kd3cwWfymtY0Ie1JDZkKE96P9X/MTBYsGLC7TVTuOHgpLBarcKqlgP4osQu3dGGvGeM+n
	 zFE50oyUwxkge6n1ytYp8il9is/AYLsDVvHP6/92HkN1dcL3thERvr6clsyBN8/4xLI/H
	 oz2UL8YUz88BIv6RYpbeAz7aR5910GAdR/3ylHUKFLUoBeyiHATcEe6MLfomo8uRrpQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794022805;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=xsmQP/jAoaQMeVmbKTW7ViGPcdAJoJipzQ6hKyJYB4s=;
	b=y0ZSJJRursufIoS9fSxEy/wur+hPCu+SGU+ENKkzQXzl8wN28JX6iHILKoncSYapJjGn
	 EiTmZeP/BjEYgQSeN0yS6bolhlmv8H7oI+Bj+a0e01p302IxCkQlJgRa0vkQlv7/61ofl
	 N/PH0FMRZE52xnsFSacMZFOle28dh22qZwQv6lbcHb7hNHXnmyrOe9Q9SHsNEDxhKU2tf
	 GTvZvCqczyj1vuSXihGJJi+qxUmJCknAjgI6NsVp5ALqrts57eCGqn693a8zgZiPqvayr
	 zj9gtnuUHB5oagFKgTzZChA6dbiv+t+oe5L3E++UzEfvLYiSvtv8gT1jQrQvmWWbEHA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sp41G1s5;
	arc=none smtp.remote-ip=209.85.214.174
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2144E606A336
	for <bpf@vger.kernel.org>; Sat,  7 Nov 2026 03:40:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2144E606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sp41G1s5
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2e9d7791b00so9122805ad.0
        for <bpf@vger.kernel.org>; Fri, 06 Nov 2026 19:40:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794022804; x=1794627604; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xsmQP/jAoaQMeVmbKTW7ViGPcdAJoJipzQ6hKyJYB4s=;
        b=sp41G1s5ptFplNp8H8nPUj0RgwsAaElwgmJn/UEMcZlFEBKAeGxpVL3HAPyXVbXngq
         GJK3H0uGXF8vnwxaCK2KylVEYk4aYXB2vDj5O1D1sQ5Mkuh+uZm96VeKZimGnJ6mKdZR
         7lSbv6qeAw0EiI3ExObbqIMsyR4Tyc0TglHIroieHf4iJFBViQRr7Q0ul8kRu37Zz1Bt
         8YnU2Vi7Y3zjpdCt+KpYEyJeNHI/c66H4zej8NbpQwKDmvQ9W2CUVRNFjYzEkEFHDduP
         jIL9TCBLkDbCXB9u2yF8nmXsuBpD4ErT2K8whwxsBqqitSJirkZhxp+H0t1Fd/b91O4x
         reLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794022804; x=1794627604;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=xsmQP/jAoaQMeVmbKTW7ViGPcdAJoJipzQ6hKyJYB4s=;
        b=drJ7je9h5lnxXhLtujEYFaqmin7UFSeL4XT3NRqUOWxz4ybeYmF9UuquxygpW0PAfx
         8qG8ZqfZ7ZnCcrQFQqqmYC6aBAIUrPBJOZSTC3QirHbGTh3nsWxvqWfSNkyDh5i2y4Cj
         gJyndH7dl2xbHQEBCOUkZrnkK7iiifRtRQ9TvEn2eaWK+FnTb9sSryrq7aSUpZCbYMwf
         YS1i8NJNHUTdGMJuq/a2UngvRC1U5kDgUyDR50HhPuX5WDv3nwSIWvfJqNR3zZVfCgFB
         85my505syI4wZYgIumtgyif3Gfcxfd5vWb32hNjG+u+/hoJsfa7MHorCt7rVMVRnuL6k
         d1rQ==
X-Gm-Message-State: APuU4Z98wC3ojjnaYT5Gkj2rc7kmeyIi0Rs5wnlB3gucoYQznTnGfWFI
	bme2UPisCU3pntWJPylAmQtdAmEFyGs8MkYnG+DG2rWYauJyARjpa6KHFqcbtQ==
X-Gm-Gg: AYBFou1DWUlTj9j0tLY/tjCD4Uo+lVJmKcUpTleTBIwpcl/c/zXMr8I1jRlKKvDo61l
	CKUMaOBPaI9WW8vtjJRGmTgfezU7L5Qwbg/3GvNMgn5hbI4iiPsxCa40mgoxVf4c9hAiQJ6e023
	vcdugcCk3GIc2yu8KDwbT35ri6oIjEdgYNrX3k2ohHKMMfCS4IJJu1i6MyhHfldzGoSKiroywPn
	DjxSck8fmj2bh88Vc5F/qXlXBPptnpc0KnhD3Efv8iCXcBTlpIxm0YBKeFzSPu0Dui0PNNsAZS5
	3LsPhkha7650rsYfxyAA0sWSC7h2UQOBAXhnxtQzH5iwV38JG34y3AXcPYDJdpjjjTJqIqQ5emE
	k62+aO3WIFTIpzW/UbU2h3kP+jCXUD5HJ0LHWxQhsioK/1WlxpcezQ4wxGXJCMW+d/EzQTQ9Xma
	dIz56Nhysda8ELXkhacylbguHPC3lODlIhVdz/GKaj0/pNLZTKlkHqKBD8YQu7XBD5VgdxCU1QY
	2gxkdWw19EYiPGpzvMTU6h1ISbMvMmruu5Hcm4pFadquikc+0zEqF162Pkv4az0YE+N/MX6LPcR
	MzaDFlXVFYMnV5nK7pKuyYNI+TXZjM90goRWk+IOGikMcS4KRG8vMr1xn3jlWXMpd0w3VykrESw
	rlAdst5pCbQqRnVX9U3U6FlU+VoYsyWdo6mrly5pLSUfmR0C3r0uKzschRlx0R+sBIHlmI/bWws
	YpvgQFAYShcpNuinwGJlc=
X-Received: by 2002:a17:90b:4a84:b0:3ac:d19e:85f1 with SMTP id 98e67ed59e1d1-3b0db72e112mr4305478a91.53.1794022804138;
        Fri, 06 Nov 2026 19:40:04 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.247])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b105864390sm1415684a91.6.2026.11.06.19.40.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 19:40:03 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next v4 20/46] bpf: Keep the count of a loop when a register has no closed form
Date: Sat,  7 Nov 2026 03:37:28 +0000
Message-ID: <20261107033758.1547725-21-alexei.starovoitov@gmail.com>
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

Selftest pyperf600_nounroll, a profiler that reads the stack of Python:
  for (int i = 0; i < STACK_MAX_LEN; ++i) {                  /* 600 */
      if (!frame_ptr || !get_frame_data(..., &frame, &sym))
          break;
      ...
      event->stack[i] = *symbol_id;
      frame_ptr = frame.f_back;
  }
i is an induction variable: 600 iterations, i = [0, 599]. get_frame_data()
fills frame and sym, which are on the stack, in each iteration. These slots
have no closed form, "can't widen *fp-64, expr is ?", and scalar evolution
gives no count for the full loop. Then i is not known either. The main pass
goes through the 600 iterations, 153987 insns, and adds a may_goto without
need. pyperf600, the same loop unrolled 150 times, and strobemeta are
rejected: "math between map_value pointer and register with unbounded .."
So are res_spin_lock_test_held_lock_max and scx_lavd/lavd_dispatch.

Let the count decide what it knows about: induction variables get their
range from it, and the loop needs no may_goto. bpf_compute_loop_iters()
reports the registers and slots without a closed form in forget_regs, and
bpf_flow_loop_enter() selects a method:

1. No check depends on the value, bpf_flow_is_needed(): the bytes of sym,
   a hash, a checksum. It stays what it is when the loop is entered. What
   comes back to the head is joined with it and widened, as in a loop
   without a count. pyperf600_nounroll: 1281 insns, no may_goto.

2. A check depends on it. Selftest strobemeta_nounroll1:
     for (int i = 0; i < STROBE_MAX_STRS; ++i)               /* 25 */
         payload_off = read_str_var(cfg, i, .., data, payload_off);
   read_str_var() reads a string to &data->payload[off] and returns off or
   off + len. payload_off is loop-carried, but the step is not a constant:
   "(any r8 (+ r8 ?))". Walk the loop: each iteration has its own state,
   with [0, i] in it. The count tells where the walk ends. The limit is
   100000 insns. 17 progs of the selftests (strobemeta, profiler2,
   linked_list, xdp_synproxy) and scx_lavd/lavd_dispatch need it. A pointer
   and a slot that does not hold one full register always count as needed.

3. The walk is too long: as in 1. Widening moves only the bound that grows:
     for (i = 0; i < 100; i++) for (j = 0; j < 100; j++) {
         if (*(volatile __u64 *)v == 1) continue;
         if (n < 8) v[n++] = 0; }                            /* long n */
   n is [0, S32_MAX] at the head. As an unknown scalar: "math between ..".

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/bpf_verifier.h |  4 ++
 kernel/bpf/scev.c            | 73 ++++++++++++++++++++++++++++--------
 kernel/bpf/verifier.c        | 16 +++++++-
 3 files changed, 76 insertions(+), 17 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 83cd9983a0b2..485c2abee665 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -353,6 +353,8 @@ struct bpf_loop_iters {
 	u32 min_header_count;   /* min number of times header is executed */
 	u32 max_header_count;   /* max number of times header is executed */
 	unsigned long precise_regs[BITS_TO_LONGS(BPF_SCEV_REGS_NUM)];
+	/* live, changed by the loop, no summary of how: left to the join at the head */
+	unsigned long forget_regs[BITS_TO_LONGS(BPF_SCEV_REGS_NUM)];
 	/* [0, max] at the entry, and the loop only clears bits */
 	unsigned long mask_regs[BITS_TO_LONGS(BPF_SCEV_REGS_NUM)];
 	/*
@@ -362,6 +364,8 @@ struct bpf_loop_iters {
 	 */
 	int iv_reg;
 	struct cnum64 iv_range;
+	/* a pointer to the stack that stores go through moves in the loop */
+	bool spill_base;
 };
 
 /* Where may_goto that the verifier adds goes, see check_loop_guard() */
diff --git a/kernel/bpf/scev.c b/kernel/bpf/scev.c
index d62e087f811d..677b64a63be4 100644
--- a/kernel/bpf/scev.c
+++ b/kernel/bpf/scev.c
@@ -2025,8 +2025,10 @@ scev_reg_for_read(struct bpf_verifier_env *env, const struct bpf_func_state *st,
 
 /*
  * Materialize a writable value in the current state, growing its stack if needed.
- * This does not go through check_stack_write(). The callers skip is_unbound_scev_reg() slots,
- * thus the buffer of a live dynptr slice, see bpf_reg_state::buf, does not become a spill here.
+ * This does not go through check_stack_write(). The buffer of a live dynptr slice, see
+ * bpf_reg_state::buf, does not become a spill here. The callers skip the slots that are
+ * is_unbound_scev_reg() when the loop is entered. A slot that a call in the loop may write
+ * has no description: it is in forget_regs, and they skip these too.
  */
 static int scev_reg_for_write(struct bpf_verifier_env *env, struct bpf_func_state *st,
 			      u32 r, struct bpf_reg_state **out)
@@ -3403,7 +3405,7 @@ int bpf_compute_loop_iters(struct bpf_verifier_env *env, struct bpf_verifier_sta
 	struct bpf_loop *loop;
 	int insn_idx = st->insn_idx;
 	u64 until, false_until;
-	bool same = true;
+	bool same = true, walk = false;
 	int err, i;
 	u32 r;
 
@@ -3496,10 +3498,12 @@ int bpf_compute_loop_iters(struct bpf_verifier_env *env, struct bpf_verifier_sta
 	if (err)
 		return err;
 
+	bitmap_zero(iters->forget_regs, REGS_NUM);
 	bitmap_zero(iters->mask_regs, REGS_NUM);
+	iters->spill_base = false;
 	header_env = find_header_env(scev, insn_idx);
 	for (r = 0; r < REGS_NUM; r++) {
-		struct bpf_reg_state *reg;
+		struct bpf_reg_state *reg = NULL;
 		u32 ra, r_scev, r_expr;
 		bool spill_base = false;
 
@@ -3546,13 +3550,14 @@ int bpf_compute_loop_iters(struct bpf_verifier_env *env, struct bpf_verifier_sta
 
 		reg = scev_reg_for_linear(cur_func, r);
 		/*
-		 * The offset of a pointer to arena is not tracked: what enters the loop stands
-		 * for all iterations. If the loop makes something else of it the state that
-		 * returns to the head is not covered by the state at the head, and the body is
-		 * verified again from that state.
+		 * The offset of a pointer to arena is not tracked, so there is nothing to lose.
+		 * If the loop makes something else of it the state that returns to the head
+		 * is not covered by the state at the head.
 		 */
-		if (reg && reg->type == PTR_TO_ARENA)
+		if (reg && reg->type == PTR_TO_ARENA) {
+			__set_bit(r, iters->forget_regs);
 			continue;
+		}
 		/* If SCEV for r is (linear <reg> <slope>) */
 		if (reg && is_simple_linear(scev, r_scev, &coefs) && is_widenable_reg_type(reg)) {
 			/* 32-bit ALU operations on pointers convert them to scalars */
@@ -3601,10 +3606,30 @@ int bpf_compute_loop_iters(struct bpf_verifier_env *env, struct bpf_verifier_sta
 				bpf_log(log, ", requires exact stack-offset tracking");
 			bpf_log(log, "\n");
 		}
-		return 0;
+		/* the count stands, it is this one that is not known in the loop */
+		if (spill_base) {
+			iters->spill_base = true;
+			walk = true;
+			continue;
+		}
+		__set_bit(r, iters->forget_regs);
+		/*
+		 * Only a walk through the iterations tells what it is in each of them. That is not
+		 * worth it for a number that nothing looks at: a sum, a hash, what a call leaves in
+		 * r1 - r5. What comes back to the head is joined with what entered then. A pointer,
+		 * or a slot that holds something else than a register, has no such join.
+		 */
+		if (!reg || (reg->type != SCALAR_VALUE && reg->type != NOT_INIT) ||
+		    bpf_flow_is_needed(env, insn_idx, r)) {
+			walk = true;
+			continue;
+		}
+		if (log->level & BPF_LOG_LEVEL2)
+			bpf_log(log, "loop header at %d, nothing looks at it\n", insn_idx);
 	}
 
-	return 1;
+	/* 2: the count is known, what some of the live registers are is not and it matters */
+	return walk ? 2 : 1;
 }
 
 /* bpf_compute_loop_iters() checked that every leaf can be unioned into acc. */
@@ -3649,6 +3674,11 @@ static int union_any_reg(struct bpf_verifier_env *env, struct bpf_func_state *lo
 	return 0;
 }
 
+/*
+ * Make @st, which is at the head of a counted loop, stand for all iterations. @loop_entry is the
+ * state that entered the loop and @iters is what bpf_compute_loop_iters() says about it.
+ * @st is a copy of @loop_entry.
+ */
 int bpf_widen_scev_regs(struct bpf_verifier_env *env, struct bpf_verifier_state *st,
 			struct bpf_verifier_state *loop_entry, struct bpf_loop_iters *iters)
 {
@@ -3679,16 +3709,27 @@ int bpf_widen_scev_regs(struct bpf_verifier_env *env, struct bpf_verifier_state
 		if (!scev_reg_alive(env, st, r))
 			continue;
 
+		/*
+		 * It stays what it is in @st. What comes back to the head is joined with it and
+		 * widened to where the jumps of the loop stop it, like in a loop without a count.
+		 * NULL or not is all that is known about a pointer to arena.
+		 */
+		if (test_bit(r, iters->forget_regs)) {
+			reg = scev_reg_for_linear(cur_func, r);
+			if (reg && reg->type == PTR_TO_ARENA) {
+				bpf_reg_forget_range(reg);
+				mark_scev_reg_scratched(env, r);
+			}
+			continue;
+		}
+
 		r_expr = header_env->reg2scev[r];
 		spill32 = spill32_counter(scev, cur_func, r_expr, r, &coefs);
-		if (!spill32 && (is_unbound_scev_reg(env, cur_func, r) ||
+		/* @iters says nothing about a register that is not known in @loop_entry */
+		if (!spill32 && (is_unbound_scev_reg(env, entry_func, r) ||
 				 is_const_scev_reg(env, insn_idx, r)))
 			continue;
 
-		reg = scev_reg_for_linear(cur_func, r);
-		if (reg && reg->type == PTR_TO_ARENA)
-			continue;
-
 		if (test_bit(r, iters->mask_regs)) {
 			/* The range stays. It's no longer equal to the registers with its id. */
 			err = scev_reg_for_write(env, cur_func, r, &reg);
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 0e35f4454c80..0a315a88e355 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -21680,8 +21680,22 @@ int bpf_flow_loop_enter(struct bpf_verifier_env *env, bool *backedge, bool *drop
 	if (err < 0)
 		return err;
 
-	/* @per_trip: the insns of one iteration, times the walks around the loop. */
+	/*
+	 * There is no summary of what the loop does to something that is live.
+	 * Go through the iterations one by one if that is not too long.
+	 * @per_trip: the insns of one iteration, times the walks around the loop.
+	 */
 	per_trip = flow_walk_factor(cur) * loop->nr_insns;
+	if (err == 2 && per_trip <= BPF_FLOW_MAX_WALK &&
+	    iters.max_header_count <= BPF_FLOW_MAX_WALK / (u32)per_trip) {
+		entry->max_header_count = iters.max_header_count;
+		entry->terminates = true;
+		entry->counted = true;
+		entry->apart = true;
+		return 0;
+	}
+	if (err == 2 && iters.spill_base)
+		err = 0;
 	/* The walk has to get to the end of the loop, so it is known to have one. Or not: */
 	if (!err) {
 		err = flow_try_walk(env, entry);
-- 
2.55.0

