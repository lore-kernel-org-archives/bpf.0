Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795288446;
	b=jyfpFLsCx0cWxYkgzHpw3Kq9j3BIhX0fD5Yy0XnSIXxtZyWodFdCtoK6AbYNYwqsBMVL
	 37smdgOdE76EuV4klEGWbV8f5qNN2fsLZLhaVNepdPZOfknAeSv6g7XCEys9cMSGyy6O0
	 6EgDZnK6/egDmJL331K8w4mn0aWlh6Xn6qNblzIeztNR8hshSlUpMDJ7OFH8vrJm8XRSW
	 VM+EQr5KeOO++YZIUC++8o92sL27VKeyjuF/C4Gsr7Wed6xqn2akFMHm94FlGK3T0FA08
	 04Q8Ln5Wqd4ITGCii046libWUqv9iKi4sZDPPu9lRoDZm9mV5kcCYGYM1XJSUGuWZ/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795288446;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=FjtfgqVOZLWWMnFKEunVqKNmMkTPE/BeVvxPlsV34gs=;
	b=jz9O5VV6kHH0DNW/HWsh1oU+u9vc7yyQd3Jitd8P4Ea8teQtisrTHWwtBMk3aR4pCpnd
	 3K4FrJx94wKXSsrWMG8uw9u839d1bAAPl/36EBO+pGQT1MDGjbwq8WOU5R6xYFxc/KL1Z
	 2f7wLZ7fyCXS5eY2apDq50uX+tAU1WCEs08uj3qRvlMnWt8GsQMaLUGsuCnmbdTUlGWO9
	 8jwd0Yoe2oMRiVukZWNveH4ucjayjBT2GlJOiF1OyGtWuIkGb/k85MYm8/aHfJN77yhll
	 zNE6pkwUKMx3y2UlLFJHvI2lKRIP2bT2M+nEXKQd1peQSnMpKf8VK/Q96NnZ7yAEC3A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MQoSTodG;
	arc=none smtp.remote-ip=209.85.216.47
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98F7C606A32A
	for <bpf@vger.kernel.org>; Sat, 21 Nov 2026 19:14:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 98F7C606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MQoSTodG
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3b0ae87069dso862396a91.2
        for <bpf@vger.kernel.org>; Sat, 21 Nov 2026 11:14:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795288445; x=1795893245; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FjtfgqVOZLWWMnFKEunVqKNmMkTPE/BeVvxPlsV34gs=;
        b=MQoSTodG1etsEM33r7D+9C43Y3LQ724qWa9F8b7w64dHqyiJCGA3zxNaO2bH38LImo
         uUC/RAEikZuEN0IMkJGn54QLGno+qKnpjgMOCDL3np3Gw71W0qQT4ROK4aZXavcfG4o2
         8X83zw4d0w7mbs/0o0z6VCeK/2rLO98X2sAdgYE5UxsqD4oU4wnUhtLJp2FZNgQ9QurD
         afcDbB0X7bZBEZppTmRVVPj8K4CiHzpennr4T81jGUJUFS2NAX+O2j04WkxCUYIGCGcf
         RbQ5dSTdK31bnJ6oEz1ABifUczjcDjB+gE66PtkJYzfj6kMyd9XxXsmmXUzkHlue2jtI
         ZT+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795288445; x=1795893245;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=FjtfgqVOZLWWMnFKEunVqKNmMkTPE/BeVvxPlsV34gs=;
        b=vHrIjznnBucRrprbULqDNr196zP9s8sASvW1hE+h/G4Wm8YFL5Z1ZPEFtvvHpH7tYg
         p01kXokRkivZCui4NNqPAJ2MiwaSWiZkiVeXPj4c+pl8yvDH1ZOzBLICOnpUcfxq5bh8
         sZnA6TKaATCaxeDs9Zl6cIOgx2XMz/IiNircZJ76oRdnewHImxbMO7Nl+MD4sUlwLZLd
         K/Y1keNDRfhMkc0Z0A8qFMRHPtn/DBedm2mHNyuIFC71VMWow5opnZilinJRBm6j+kSg
         ruSpGCEashNE5QWkN1ZPt97BBT/BAEwNsgejrTZlkSxOBWrBdMdfUMpGF5rOYun/yIZr
         mZ6A==
X-Gm-Message-State: APuU4Z+0OFjtwX2vyIcmpjS6eNGJ+pkZAenXK/TYmgXLhtmk9RwXZE1r
	LBHlQPNV805o4zovrWlOIoqTes/U+zCnA9aJvb47TKMiiKeP3sJRnaKcRLL3Lw==
X-Gm-Gg: AZFdTZcfjl3zEN3RCWSsrTZrNIh2Xi4MPlD4E3VXO03Ookmj6qiJLCnkviYinhFT2ww
	i5lOZvAXTz+nTqjQ4qYvBJB5oQ2fzayhLaevD0hGphKyUUrkNOKPV+roqAoHNuIowJV0Z9AmDUo
	kIV68CTyZQBRGzFn3E8YqPZT54nYfT2v1qhZtgC8s2WBuiAXo4MnY5dIeN1pDWZQjDvLJ5E2rXD
	7d6n1O374+OihRQ4P3kNclqRWsA1IXGyA/cxeHjHMx4fGHOWdYxLlgMxL+u30IfBnx3+JuhcxxC
	LOEcuENeeYuALu6toCzzbDt0hXjvBAyUtbUli4HF5JSo/SBno5yX7ERZpTa3NHOXaDV/SsiyjMk
	rHppYrER86BdOpl1fm2C2MUHKohIVKMyb0696SMAh55g5ZYAda39sQ8dmiktRFkn6EQPlNd3LL6
	OfSNVdyhAEQtVzsfulwHxkY2QLF6deXIAVWmmib1VXdfIHxH+BGlNwciufR7Pwgah5Daq1p7C0G
	1hEBeJh0H8+nOPLUVq0iblcWyH1hhat7N1VofDIt2fqVpuC1hw2oXn0Wg6LT99k6mbCTu5AZ8yG
	f50qJhsR+6b4zwNHnEO1D29A67dEQaw35Bm9LQe4bIxsF5tkvFxt1q5yNC3eolKLYm4AWErwKxm
	EU8XAD5AurO2jjyPFGpnxATQErtk8YdrJqB7vC1tMiwvh6bJlqlhJZLnHnqvuUQul+9SCDyIDUQ
	==
X-Received: by 2002:a17:90b:3f0f:b0:3b3:ba43:54bf with SMTP id 98e67ed59e1d1-3b41c925a7amr7511350a91.27.1795288444744;
        Sat, 21 Nov 2026 11:14:04 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.255])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b41ad0b2c4sm9390333a91.4.2026.11.21.11.14.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 11:14:04 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next 3/7] bpf: Mark a skip of trips as a guess if a 32-bit value wraps
Date: Sat, 21 Nov 2026 19:13:38 +0000
Message-ID: <20261121191343.3670609-4-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261121191343.3670609-1-alexei.starovoitov@gmail.com>
References: <20261121191343.3670609-1-alexei.starovoitov@gmail.com>
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

A valid program can be rejected. No unsafe program is accepted, because
the path-sensitive run accepts nothing.

After a pass with an error, the run looks for one path to the error.
It skips trips of a loop: it adds step * trips to each xreg that moves.
It adds in 64 bits, but a 32-bit insn wraps:

  r7 = 0;
  for (i = 0; i < 100; i++) {
          x = r7;
          if (!flag) w7 += 0x4000000;
  }
  if (!flag) buf[x - 0x8c000000];

If flag is 0, x is 0x8c000000 after the loop. The skip gives
0x18c000000. No path has this value, but the access to buf fails with
it. The error counts as real, so the budget of the next passes is cut.
If the program needs more than that budget, it is rejected.

If the skip moves a number past a multiple of 2^31, a 32-bit insn can
wrap. If such an insn writes an xreg that the skip moves, and the upper
half is live, mark the skip as a guess. A guess does not cut the budget.

Fixes: a46de5d64e18 ("bpf: Reproduce an error on one path, with no joins")
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/bpf_verifier.h |  2 +-
 kernel/bpf/equation_join.c   | 45 ++++++++++++++++++++++++++++--------
 kernel/bpf/verifier.c        |  5 ++--
 3 files changed, 40 insertions(+), 12 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 88b3a5226c..942629cc49 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -2593,7 +2593,7 @@ void bpf_collect_iv_thresholds(struct bpf_verifier_env *env);
 int bpf_guess_first_trips(struct bpf_verifier_env *env, struct bpf_verifier_state *st,
 			  struct bpf_loop *loop);
 bool bpf_steps_are_constant(struct bpf_verifier_env *env, const struct loop_stack_entry *entry,
-			    const unsigned long *iv_xregs, bool infinite);
+			    const unsigned long *iv_xregs, bool infinite, u64 factor);
 void bpf_fast_forward_xregs(struct bpf_verifier_env *env, const struct bpf_verifier_state *old,
 			    struct bpf_verifier_state *cur, u64 factor, unsigned long *iv_xregs);
 
diff --git a/kernel/bpf/equation_join.c b/kernel/bpf/equation_join.c
index e601e3dda7..c7273d8800 100644
--- a/kernel/bpf/equation_join.c
+++ b/kernel/bpf/equation_join.c
@@ -826,24 +826,27 @@ static u32 slot_of_insn(struct bpf_verifier_env *env, const struct bpf_insn *ins
 	return 0;
 }
 
-/* If the operand has a constant step, the result has one too. @prev: in the same block. */
+/*
+ * If the operand has a constant step, the result has one too. @prev: in the same block.
+ * @wraps: the low 32 bits of the result can wrap.
+ */
 static bool keeps_constant_step(const struct bpf_insn *insn, const struct bpf_insn *prev,
-				bool infinite)
+				bool wraps)
 {
 	u8 class = BPF_CLASS(insn->code), op = BPF_OP(insn->code);
 
 	if (bpf_is_ldimm64(insn))
 		return true;
-	if (class != BPF_ALU64 && (class != BPF_ALU || infinite))
+	if (class != BPF_ALU64 && (class != BPF_ALU || wraps))
 		return false;
 	if (op == BPF_MOV)
-		return !insn->off || (!infinite && insn->off == 32);
+		return !insn->off || (!wraps && insn->off == 32);
 	if (BPF_SRC(insn->code) == BPF_X)
 		return false;
 	if (op == BPF_ADD || op == BPF_SUB)
 		return true;
 	/* x <<= 32; x >>= 32; */
-	return !infinite && insn->imm == 32 &&
+	return !wraps && insn->imm == 32 &&
 	       (op == BPF_LSH || ((op == BPF_RSH || op == BPF_ARSH) && prev && prev->imm == 32 &&
 				  prev->code == (BPF_ALU64 | BPF_LSH | BPF_K) &&
 				  prev->dst_reg == insn->dst_reg));
@@ -862,6 +865,26 @@ static u64 step_of_xreg(struct bpf_verifier_env *env, const struct loop_stack_en
 	       bpf_find_var_bounds(env, &entry->header_state->st, xreg, &is_ptr)->r64.base;
 }
 
+/* An xreg of @xregs passes a multiple of 2^31 if it moves @factor times as far */
+static bool skip_wraps(struct bpf_verifier_env *env, const struct loop_stack_entry *entry,
+		       const unsigned long *xregs, u64 factor)
+{
+	u64 off, end;
+	struct cnum64 x;
+	bool is_ptr;
+	u32 n;
+
+	for_each_set_bit(n, xregs, MAX_BPF_XREG) {
+		x = bpf_find_var_bounds(env, env->cur_state,
+					bpf_xreg(env->cur_state->curframe, n), &is_ptr)->r64;
+		off = step_of_xreg(env, entry, xregs, n) * factor;
+		end = x.base + x.size;
+		if (!is_ptr && ((x.base ^ (x.base + off)) | (end ^ (end + off))) >> 31)
+			return true;
+	}
+	return false;
+}
+
 /*
  * Two trips gave the steps. Does each trip add the same constant to the operands of the jump on
  * the iv, and to @iv_xregs? The code shows it, or a pass saw it at the header.
@@ -869,9 +892,10 @@ static u64 step_of_xreg(struct bpf_verifier_env *env, const struct loop_stack_en
  *	sum += i; x = n / i;		no
  *	a = b; b = 0;			no, if a moved and b did not
  * @infinite: above 2^32 trips. Only the jump counts, and 32-bit insns wrap.
+ * @factor: of the skip. If a 32-bit insn wraps in it, the upper half of its result has no step.
  */
 bool bpf_steps_are_constant(struct bpf_verifier_env *env, const struct loop_stack_entry *entry,
-			    const unsigned long *iv_xregs, bool infinite)
+			    const unsigned long *iv_xregs, bool infinite, u64 factor)
 {
 	const struct bpf_insn_aux_data *aux = env->insn_aux_data;
 	const struct bpf_insn *insn, *prev = NULL;
@@ -881,11 +905,12 @@ bool bpf_steps_are_constant(struct bpf_verifier_env *env, const struct loop_stac
 	u16 new_step = 0;	/* the last write in this basic block has a constant step */
 	u16 last_round, uses_no_step;
 	u64 steps[MAX_BPF_EXT_REG];
-	bool has_step;
+	bool has_step, wraps, insn_wraps;
 	u32 slot;
 	int n;
 
 	bitmap_andnot(not_linear, iv_xregs, loop->linear_xregs, MAX_BPF_XREG);
+	wraps = skip_wraps(env, entry, not_linear, factor);
 	do {
 		last_round = no_step;
 		bpf_add_cost(env, loop->nr_insns, BPF_COST_SCAN);
@@ -902,11 +927,13 @@ bool bpf_steps_are_constant(struct bpf_verifier_env *env, const struct loop_stac
 			if (n == entry->iv_jump_idx && (uses_no_step & ~aux[n].const_reg_mask))
 				return false;
 			slot = slot_of_insn(env, insn);
-			has_step = !slot ? keeps_constant_step(insn, prev, infinite) :
+			insn_wraps = infinite || (wraps && (BPF_CLASS(insn->code) != BPF_ALU ||
+							    aux[n].zext_dst));
+			has_step = !slot ? keeps_constant_step(insn, prev, insn_wraps) :
 				   test_bit(bpf_xreg_to_spi(slot),
 					    aux[loop->header].live_stack_before) &&
 				   !test_bit(slot, not_linear) &&
-				   (!infinite || BPF_SIZE(insn->code) == BPF_DW);
+				   (!insn_wraps || BPF_SIZE(insn->code) == BPF_DW);
 			/* a copy that the run made has the step of its source */
 			if (has_step && aux[n].seen && (aux[n].def_regs & ~aux[n].use_regs))
 				steps[insn->dst_reg] =
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 0b8063dbb3..5bd6fa081f 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -21055,6 +21055,7 @@ static int fast_forward_trips(struct bpf_verifier_env *env, struct loop_stack_en
 	const struct loop_stack_entry *saved = bpf_top_loop(old->frame[old->curframe]);
 	u32 period = entry->trip - saved->trip;
 	bool infinite = entry->trips_left > BPF_MAX_TRIPS, guess;
+	u64 factor = div_u64(entry->trips_left - 1, period);
 	DECLARE_BITMAP(iv_xregs, MAX_BPF_XREG) = {};
 	int err;
 
@@ -21067,14 +21068,14 @@ static int fast_forward_trips(struct bpf_verifier_env *env, struct loop_stack_en
 	if (err <= 0)
 		return err;
 	guess = (!infinite && saved->exit_threshold != entry->exit_threshold) ||
-		!bpf_steps_are_constant(env, entry, iv_xregs, infinite);
+		!bpf_steps_are_constant(env, entry, iv_xregs, infinite, factor);
 	if (infinite) {
 		entry->loop->infinite = true;
 		entry->loop->infinite_is_guess = guess || env->run_has_guess;
 		return 0;
 	}
 	env->run_has_guess |= guess;
-	bpf_fast_forward_xregs(env, old, cur, div_u64(entry->trips_left - 1, period), iv_xregs);
+	bpf_fast_forward_xregs(env, old, cur, factor, iv_xregs);
 	entry->iv_jump_idx = 0;
 	entry->trips_left = 1;
 	return 1;
-- 
2.55.0

