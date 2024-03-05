Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6417D3FE5D
	for <bpf@vger.kernel.org>; Tue,  5 Mar 2024 04:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709614352; cv=none; b=h0kBBZZAH8jJHH1QcKsRu1zv7faZ17mLT0JTtAUI8F6INV1jyMo41fkMBYBW8m2z776OvqCK2/iHQpc6MeT+uoLNTYa2Vbk38Kyn/KVlJuvJm5df5UDbAJ9n3nBZ6FsyKWlpx25xN00gXMw/YRUCAmYHgHracuGOx1STn5llJdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709614352; c=relaxed/simple;
	bh=XxfQPu6EUKSLv0l3+Z2CjhbzewSlnRlviPglaZr4Xw0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cXSy3omgTNiqclfA3EHnZqQrFkx2yYhgMlJRF57dKSqEyWsfNVVq8Xhzn4o42ZveskMcOJ4LmCzYBzUrYcKL/zaTpvALFtOjHpFHr0KopEiY8lxMOqAJorR+/3E4vQAjIrWUOzmtIXTrO7AC9AWbLsVnb5ov+KtUaYv2y7n+Yx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SndZSQbe; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SndZSQbe"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-5d8b70b39efso4781085a12.0
        for <bpf@vger.kernel.org>; Mon, 04 Mar 2024 20:52:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709614349; x=1710219149; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l07LPbm0nnBYI/sTuJsZdLie13rgjSrAnpJTVfqJAMA=;
        b=SndZSQbe6fhJBqeosWK9XZmodrc8OZV6gZ0FKB2LzJfWdCLHTh6I1E4PG//yrWoPO0
         9+L6wIgkMFOGC/ZUAC0wikUOvOq/r4iziq2FJhRgCzocaAHiGTQ0BdhsHsAijypvm064
         GuthWo1uJaLtLaKC/opJTvZlWl7f3dY+Ls007IJJPnVZgn3calUX2DH2WjkesTFL/gfo
         i8kwPNKkC2U+XbEve/4BKA9SltLO9jT5b+Nv5pyAAh+/+Da08QGePgJZnQmZeFD1gi/E
         Jt11P497Y1R3zt7fRQFScHNGKvcChINrOJLOOaAzwpKcL7KEz3+PaUD2VnPok+Bu6OG6
         bGrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709614349; x=1710219149;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l07LPbm0nnBYI/sTuJsZdLie13rgjSrAnpJTVfqJAMA=;
        b=KjDjsyuHj/if2TTmEXRYVDzUpotZmALSZZ6NAmxiiUc4mnAkSOI3kA1V5gqOGhYyex
         eS4CB4YvLtOWW2EEyiEapfxfUihC3E8PSqrrG+o36IK9ZZYbiMvBJfJ2OG28hAy4PmLH
         G27vnAMhpwG5bBZctLVEqwON7jYaK4POGGnGnQHXGDAo+YF37EmXhrAQbmgE10J9PIpT
         ssBCOOLYYlhP6X1kJBdFgkPqQs8rYlx0kYRxG0wNe32IKPNwbjwpR+/vxD1+KNKiRj9a
         OqGpiNtex+uSZ1j/WbUkr5iM5/HKsL9Go3Pf+mzCg2d0Xe5YxiOiNTJYI9bnzTOaTzF8
         CF8Q==
X-Gm-Message-State: AOJu0Yyy/oxlIbK/N9KSuiJpxmeLWxYa9TN0RkGck/FYjEgX/OewZz05
	tylA3E5KzhV3PNLI80fHRDsDPyY1NnmY0WZw3i5aRRfIAbZqc7XAqBLKxayu
X-Google-Smtp-Source: AGHT+IGChOk7GlgBm0KQVpsToaSKc2KP4qH55OyQwENDblm7e/GdeSEsvFLNa2bTOPdj8/gXuEBw6Q==
X-Received: by 2002:a05:6a21:398a:b0:1a1:511b:eca0 with SMTP id ad10-20020a056a21398a00b001a1511beca0mr888180pzc.32.1709614348910;
        Mon, 04 Mar 2024 20:52:28 -0800 (PST)
Received: from localhost.localdomain ([2620:10d:c090:400::5:9426])
        by smtp.gmail.com with ESMTPSA id a21-20020a170902ee9500b001db5753e8b8sm9385493pld.218.2024.03.04.20.52.27
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 04 Mar 2024 20:52:28 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	memxor@gmail.com,
	eddyz87@gmail.com,
	john.fastabend@gmail.com,
	kernel-team@fb.com
Subject: [PATCH v5 bpf-next 2/4] bpf: Recognize that two registers are safe when their ranges match
Date: Mon,  4 Mar 2024 20:52:17 -0800
Message-Id: <20240305045219.66142-3-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
In-Reply-To: <20240305045219.66142-1-alexei.starovoitov@gmail.com>
References: <20240305045219.66142-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

When open code iterators, bpf_loop or may_goto is used the following two states
are equivalent and safe to prune the search:

cur state: fp-8_w=scalar(id=3,smin=umin=smin32=umin32=2,smax=umax=smax32=umax32=11,var_off=(0x0; 0xf))
old state: fp-8_rw=scalar(id=2,smin=umin=smin32=umin32=1,smax=umax=smax32=umax32=11,var_off=(0x0; 0xf))

In other words "exact" state match should ignore liveness and precision marks,
since open coded iterator logic didn't complete their propagation,
but range_within logic that applies to scalars, ptr_to_mem, map_value, pkt_ptr
is safe to rely on.

Avoid doing such comparison when regular infinite loop detection logic is used,
otherwise bounded loop logic will declare such "infinite loop" as false
positive. Such example is in progs/verifier_loops1.c not_an_inifinite_loop().

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/verifier.c | 39 ++++++++++++++++++++++-----------------
 1 file changed, 22 insertions(+), 17 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 226bb65f9c2c..74b55d5571c7 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -16254,8 +16254,8 @@ static int check_btf_info(struct bpf_verifier_env *env,
 }
 
 /* check %cur's range satisfies %old's */
-static bool range_within(struct bpf_reg_state *old,
-			 struct bpf_reg_state *cur)
+static bool range_within(const struct bpf_reg_state *old,
+			 const struct bpf_reg_state *cur)
 {
 	return old->umin_value <= cur->umin_value &&
 	       old->umax_value >= cur->umax_value &&
@@ -16419,21 +16419,26 @@ static bool regs_exact(const struct bpf_reg_state *rold,
 	       check_ids(rold->ref_obj_id, rcur->ref_obj_id, idmap);
 }
 
+enum exact_level {
+	NOT_EXACT,
+	EXACT,
+	RANGE_WITHIN
+};
+
 /* Returns true if (rold safe implies rcur safe) */
 static bool regsafe(struct bpf_verifier_env *env, struct bpf_reg_state *rold,
-		    struct bpf_reg_state *rcur, struct bpf_idmap *idmap, bool exact)
+		    struct bpf_reg_state *rcur, struct bpf_idmap *idmap,
+		    enum exact_level exact)
 {
-	if (exact)
+	if (exact == EXACT)
 		return regs_exact(rold, rcur, idmap);
 
-	if (!(rold->live & REG_LIVE_READ))
+	if (!(rold->live & REG_LIVE_READ) && exact != RANGE_WITHIN)
 		/* explored state didn't use this */
 		return true;
-	if (rold->type == NOT_INIT)
+	if (rold->type == NOT_INIT && exact != RANGE_WITHIN)
 		/* explored state can't have used this */
 		return true;
-	if (rcur->type == NOT_INIT)
-		return false;
 
 	/* Enforce that register types have to match exactly, including their
 	 * modifiers (like PTR_MAYBE_NULL, MEM_RDONLY, etc), as a general
@@ -16468,7 +16473,7 @@ static bool regsafe(struct bpf_verifier_env *env, struct bpf_reg_state *rold,
 			return memcmp(rold, rcur, offsetof(struct bpf_reg_state, id)) == 0 &&
 			       check_scalar_ids(rold->id, rcur->id, idmap);
 		}
-		if (!rold->precise)
+		if (!rold->precise && exact != RANGE_WITHIN)
 			return true;
 		/* Why check_ids() for scalar registers?
 		 *
@@ -16579,7 +16584,7 @@ static struct bpf_reg_state *scalar_reg_for_stack(struct bpf_verifier_env *env,
 }
 
 static bool stacksafe(struct bpf_verifier_env *env, struct bpf_func_state *old,
-		      struct bpf_func_state *cur, struct bpf_idmap *idmap, bool exact)
+		      struct bpf_func_state *cur, struct bpf_idmap *idmap, enum exact_level exact)
 {
 	int i, spi;
 
@@ -16743,7 +16748,7 @@ static bool refsafe(struct bpf_func_state *old, struct bpf_func_state *cur,
  * the current state will reach 'bpf_exit' instruction safely
  */
 static bool func_states_equal(struct bpf_verifier_env *env, struct bpf_func_state *old,
-			      struct bpf_func_state *cur, bool exact)
+			      struct bpf_func_state *cur, enum exact_level exact)
 {
 	int i;
 
@@ -16770,7 +16775,7 @@ static void reset_idmap_scratch(struct bpf_verifier_env *env)
 static bool states_equal(struct bpf_verifier_env *env,
 			 struct bpf_verifier_state *old,
 			 struct bpf_verifier_state *cur,
-			 bool exact)
+			 enum exact_level exact)
 {
 	int i;
 
@@ -17144,7 +17149,7 @@ static int is_state_visited(struct bpf_verifier_env *env, int insn_idx)
 			 * => unsafe memory access at 11 would not be caught.
 			 */
 			if (is_iter_next_insn(env, insn_idx)) {
-				if (states_equal(env, &sl->state, cur, true)) {
+				if (states_equal(env, &sl->state, cur, RANGE_WITHIN)) {
 					struct bpf_func_state *cur_frame;
 					struct bpf_reg_state *iter_state, *iter_reg;
 					int spi;
@@ -17168,20 +17173,20 @@ static int is_state_visited(struct bpf_verifier_env *env, int insn_idx)
 				goto skip_inf_loop_check;
 			}
 			if (is_may_goto_insn(env, insn_idx)) {
-				if (states_equal(env, &sl->state, cur, true)) {
+				if (states_equal(env, &sl->state, cur, RANGE_WITHIN)) {
 					update_loop_entry(cur, &sl->state);
 					goto hit;
 				}
 				goto skip_inf_loop_check;
 			}
 			if (calls_callback(env, insn_idx)) {
-				if (states_equal(env, &sl->state, cur, true))
+				if (states_equal(env, &sl->state, cur, RANGE_WITHIN))
 					goto hit;
 				goto skip_inf_loop_check;
 			}
 			/* attempt to detect infinite loop to avoid unnecessary doomed work */
 			if (states_maybe_looping(&sl->state, cur) &&
-			    states_equal(env, &sl->state, cur, true) &&
+			    states_equal(env, &sl->state, cur, EXACT) &&
 			    !iter_active_depths_differ(&sl->state, cur) &&
 			    sl->state.may_goto_cnt == cur->may_goto_cnt &&
 			    sl->state.callback_unroll_depth == cur->callback_unroll_depth) {
@@ -17239,7 +17244,7 @@ static int is_state_visited(struct bpf_verifier_env *env, int insn_idx)
 		 */
 		loop_entry = get_loop_entry(&sl->state);
 		force_exact = loop_entry && loop_entry->branches > 0;
-		if (states_equal(env, &sl->state, cur, force_exact)) {
+		if (states_equal(env, &sl->state, cur, force_exact ? RANGE_WITHIN : NOT_EXACT)) {
 			if (force_exact)
 				update_loop_entry(cur, loop_entry);
 hit:
-- 
2.43.0

