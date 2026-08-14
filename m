Received: from mta0.migadu.com (out-219.mta0.migadu.com [91.218.175.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46F5A3A4267
	for <bpf@vger.kernel.org>; Fri, 14 Aug 2026 23:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786749606; cv=none; b=HvTu+v8FNSOQG+HzDtq72vlLym7ZNKnqKiAeSlsLcnONRy6IHaWu1ia1nPypRbMjymc4qlogX6ArD7fzJ/CvI1Oz9ZjDm1VYDQ4OK85XTAAKX0cBVXrS9Hm1jlq5/Dk54GxQA/wmyOVqnJKoXkBjFkVCyL4/oxCo/ph7NpECN9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786749606; c=relaxed/simple;
	bh=jeRfA0YnR5WMkbNr7KUT+VYUIX8ePdKg2Lq5oDnizEk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KnXCczdn68h+qglIuEhH6jp5LvbFMhCgmPFefd36zpmm8Dw/5fj8th+jV80MuGbFhpoXO0kKBz1Q5QJor6x2xNKYcSpHV7XEYUcEdE7Uoq2aYFNaTm+4P884JoE6C2xq+17099366NB26asPtabFOB2NpjYa1yBwTA0QuPDyhKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jwGr4BS5; arc=none smtp.client-ip=91.218.175.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jwGr4BS5"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=jeRfA0YnR5WMkbNr7KUT+VYUIX8ePdKg2Lq5oDnizEk=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786749602; v=1; x=1787354402;
 b=jwGr4BS515Fi0N6Dh5IN9M2EUk5qIS72d+rCu4SoS35pdgWq/T/HFszunkB0x+5TIgb50iH9
 /gTTBFjGiObedoWUQbexIQracEtc4/Jo3A8k+LLG/xmCtcfDTLtxr8DfowasikeKPkCDzYS+vXC
 uWVGrO9yd1X4v23f1dSNKNy0=
X-Envelope-To: bpf@vger.kernel.org
Received: from gvineet-fedora-PF5JGVFY.thefacebook.com (2620:10d:c090:500::6:7be4)
	by smtp.migadu.com with ESMTPS id 194f4ff2d32dc14a;
	Fri, 14 Aug 2026 23:19:59 +0000
X-Migadu-Flow: FLOW_OUT
From: Vineet Gupta <vineet.gupta@linux.dev>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Cc: martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	ihor.solodrai@linux.dev,
	john.fastabend@gmail.com,
	shuah@kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Vineet Gupta <vineet.gupta@linux.dev>
Subject: [RFC bpf-next 1/6] bpf: turn bpf_reg_state->precise into a flags field [NFC]
Date: Fri, 14 Aug 2026 16:19:40 -0700
Message-ID: <20260814231945.3884596-2-vineet.gupta@linux.dev>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260814231945.3884596-1-vineet.gupta@linux.dev>
References: <20260814231945.3884596-1-vineet.gupta@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bpf_reg_state carries a single bool, ->precise. Other per-register boolean
properties exist (and more are coming), so convert the bool into a u8,
call it flags and give the property a name.

  -	bool precise;
  +#define BPF_FLAG_PRECISE	(1U << 7)
  +	u8 flags;

Both occupy 1 byte at the same offset, so the struct layout is unchanged.
->precise was the last field, after ->frameno, and ->flags takes exactly
that slot, so the memcmp()/offsetof() based comparisons are unaffected:
every one of them stops at offsetof(id), offsetof(var_off) or
offsetof(frameno), i.e. at or before the field either way.

That tail position is not an accident -- it is where fields live that are
compared semantically rather than byte-wise. ->precise is never memcmp()ed;
regsafe() tests it explicitly, and an imprecise old scalar is a wildcard:

	if (!reg_is_precise(rold) && exact == NOT_EXACT)
		return true;

PRECISE also takes bit 7 rather than bit 0, because it is the odd one out
among the flags that will share this byte: the others describe how a register
relates to its ->id set and are cleared as a group, while PRECISE belongs to
the register alone and must survive that clearing. Growing the rest up from
bit 0 keeps a clear-the-link-bits mask from reaching it by construction.

Reads go through a helper, since they are the common case and read better.
Set and clear stay open-coded as the usual reg->flags |= / &= ~ bit ops.

No functional change intended.

Suggested-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Vineet Gupta <vineet.gupta@linux.dev>
---
 include/linux/bpf_verifier.h | 18 ++++++++++++++++--
 kernel/bpf/backtrack.c       | 22 +++++++++++-----------
 kernel/bpf/log.c             |  2 +-
 kernel/bpf/states.c          | 10 +++++-----
 kernel/bpf/verifier.c        | 14 +++++++++-----
 5 files changed, 42 insertions(+), 24 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 27b43fda9b17..ebab483fc7f2 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -162,10 +162,24 @@ struct bpf_reg_state {
 	 * pointing to bpf_func_state.
 	 */
 	u32 frameno;
-	/* if (!precise && SCALAR_VALUE) min/max/tnum don't affect safety */
-	bool precise;
+	/*
+	 * Register state flags.
+	 * BPF_FLAG_PRECISE: if unset, and this is a SCALAR_VALUE, then
+	 * min/max/tnum don't affect safety.
+	 *
+	 * PRECISE is a property of this register alone, so it is placed at bit 7,
+	 * apart from the link flags, which grow up from bit 0 and are cleared as
+	 * a group -- a clear-the-link-bits mask can then never reach it.
+	 */
+#define BPF_FLAG_PRECISE	(1U << 7)
+	u8 flags;
 };
 
+static inline bool reg_is_precise(const struct bpf_reg_state *reg)
+{
+	return reg->flags & BPF_FLAG_PRECISE;
+}
+
 static inline s64 reg_smin(const struct bpf_reg_state *reg)
 {
 	return cnum64_smin(reg->r64);
diff --git a/kernel/bpf/backtrack.c b/kernel/bpf/backtrack.c
index a2b18a9f1694..400c69152ed2 100644
--- a/kernel/bpf/backtrack.c
+++ b/kernel/bpf/backtrack.c
@@ -675,9 +675,9 @@ void bpf_mark_all_scalars_precise(struct bpf_verifier_env *env,
 			func = st->frame[i];
 			for (j = 0; j < BPF_REG_FP; j++) {
 				reg = &func->regs[j];
-				if (reg->type != SCALAR_VALUE || reg->precise)
+				if (reg->type != SCALAR_VALUE || reg_is_precise(reg))
 					continue;
-				reg->precise = true;
+				reg->flags |= BPF_FLAG_PRECISE;
 				if (env->log.level & BPF_LOG_LEVEL2) {
 					verbose(env, "force_precise: frame%d: forcing r%d to be precise\n",
 						i, j);
@@ -687,9 +687,9 @@ void bpf_mark_all_scalars_precise(struct bpf_verifier_env *env,
 				if (!bpf_is_spilled_reg(&func->stack[j]))
 					continue;
 				reg = &func->stack[j].spilled_ptr;
-				if (reg->type != SCALAR_VALUE || reg->precise)
+				if (reg->type != SCALAR_VALUE || reg_is_precise(reg))
 					continue;
-				reg->precise = true;
+				reg->flags |= BPF_FLAG_PRECISE;
 				if (env->log.level & BPF_LOG_LEVEL2) {
 					verbose(env, "force_precise: frame%d: forcing fp%d to be precise\n",
 						i, -(j + 1) * 8);
@@ -851,7 +851,7 @@ int bpf_mark_chain_precision(struct bpf_verifier_env *env,
 					reg = &st->frame[0]->regs[i];
 					bt_clear_reg(bt, i);
 					if (reg->type == SCALAR_VALUE) {
-						reg->precise = true;
+						reg->flags |= BPF_FLAG_PRECISE;
 						*changed = true;
 					}
 				}
@@ -912,10 +912,10 @@ int bpf_mark_chain_precision(struct bpf_verifier_env *env,
 					bt_clear_frame_reg(bt, fr, i);
 					continue;
 				}
-				if (reg->precise) {
+				if (reg_is_precise(reg)) {
 					bt_clear_frame_reg(bt, fr, i);
 				} else {
-					reg->precise = true;
+					reg->flags |= BPF_FLAG_PRECISE;
 					*changed = true;
 				}
 			}
@@ -932,10 +932,10 @@ int bpf_mark_chain_precision(struct bpf_verifier_env *env,
 					continue;
 				}
 				reg = &func->stack[i].spilled_ptr;
-				if (reg->precise) {
+				if (reg_is_precise(reg)) {
 					bt_clear_frame_slot(bt, fr, i);
 				} else {
-					reg->precise = true;
+					reg->flags |= BPF_FLAG_PRECISE;
 					*changed = true;
 				}
 			}
@@ -943,10 +943,10 @@ int bpf_mark_chain_precision(struct bpf_verifier_env *env,
 				if (!bt_is_frame_stack_arg_slot_set(bt, fr, i))
 					continue;
 				reg = &func->stack_arg_regs[i];
-				if (reg->type != SCALAR_VALUE || reg->precise) {
+				if (reg->type != SCALAR_VALUE || reg_is_precise(reg)) {
 					bt_clear_frame_stack_arg_slot(bt, fr, i);
 				} else {
-					reg->precise = true;
+					reg->flags |= BPF_FLAG_PRECISE;
 					*changed = true;
 				}
 			}
diff --git a/kernel/bpf/log.c b/kernel/bpf/log.c
index b740fa73ee26..9a4445d492c9 100644
--- a/kernel/bpf/log.c
+++ b/kernel/bpf/log.c
@@ -640,7 +640,7 @@ static void print_reg_state(struct bpf_verifier_env *env,
 	const char *sep = "";
 
 	t = reg->type;
-	if (t == SCALAR_VALUE && reg->precise)
+	if (t == SCALAR_VALUE && reg_is_precise(reg))
 		verbose(env, "P");
 	if (t == SCALAR_VALUE && tnum_is_const(reg->var_off)) {
 		verbose_snum(env, reg->var_off.value);
diff --git a/kernel/bpf/states.c b/kernel/bpf/states.c
index 4e6aafad33bd..f7a0314fa106 100644
--- a/kernel/bpf/states.c
+++ b/kernel/bpf/states.c
@@ -548,7 +548,7 @@ static bool regsafe(struct bpf_verifier_env *env, struct bpf_reg_state *rold,
 			return memcmp(rold, rcur, offsetof(struct bpf_reg_state, id)) == 0 &&
 			       check_scalar_ids(rold->id, rcur->id, idmap);
 		}
-		if (!rold->precise && exact == NOT_EXACT)
+		if (!reg_is_precise(rold) && exact == NOT_EXACT)
 			return true;
 		/*
 		 * Linked register tracking uses rold->id to detect relationships.
@@ -1034,7 +1034,7 @@ static int propagate_precision(struct bpf_verifier_env *env,
 		first = true;
 		for (i = 0; i < BPF_REG_FP; i++, state_reg++) {
 			if (state_reg->type != SCALAR_VALUE ||
-			    !state_reg->precise)
+			    !reg_is_precise(state_reg))
 				continue;
 			if (env->log.level & BPF_LOG_LEVEL2) {
 				if (first)
@@ -1051,7 +1051,7 @@ static int propagate_precision(struct bpf_verifier_env *env,
 				continue;
 			state_reg = &state->stack[i].spilled_ptr;
 			if (state_reg->type != SCALAR_VALUE ||
-			    !state_reg->precise)
+			    !reg_is_precise(state_reg))
 				continue;
 			if (env->log.level & BPF_LOG_LEVEL2) {
 				if (first)
@@ -1223,7 +1223,7 @@ static void mark_all_scalars_imprecise(struct bpf_verifier_env *env, struct bpf_
 			reg = &func->regs[j];
 			if (reg->type != SCALAR_VALUE)
 				continue;
-			reg->precise = false;
+			reg->flags &= ~BPF_FLAG_PRECISE;
 		}
 		for (j = 0; j < func->allocated_stack / BPF_REG_SIZE; j++) {
 			if (!bpf_is_spilled_reg(&func->stack[j]))
@@ -1231,7 +1231,7 @@ static void mark_all_scalars_imprecise(struct bpf_verifier_env *env, struct bpf_
 			reg = &func->stack[j].spilled_ptr;
 			if (reg->type != SCALAR_VALUE)
 				continue;
-			reg->precise = false;
+			reg->flags &= ~BPF_FLAG_PRECISE;
 		}
 	}
 }
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 6ac1afced20b..8925749d636e 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -1830,7 +1830,9 @@ static void __mark_reg_const_zero(const struct bpf_verifier_env *env, struct bpf
 	/* all scalars are assumed imprecise initially (unless unprivileged,
 	 * in which case everything is forced to be precise)
 	 */
-	reg->precise = !env->bpf_capable;
+	reg->flags &= ~BPF_FLAG_PRECISE;
+	if (!env->bpf_capable)
+		reg->flags |= BPF_FLAG_PRECISE;
 }
 
 static void mark_reg_known_zero(struct bpf_verifier_env *env,
@@ -2139,13 +2141,14 @@ void bpf_mark_reg_unknown_imprecise(struct bpf_reg_state *reg)
 }
 
 /* Mark a register as having a completely unknown (scalar) value,
- * initialize .precise as true when not bpf capable.
+ * set BPF_FLAG_PRECISE when not bpf capable.
  */
 static void __mark_reg_unknown(const struct bpf_verifier_env *env,
 			       struct bpf_reg_state *reg)
 {
 	bpf_mark_reg_unknown_imprecise(reg);
-	reg->precise = !env->bpf_capable;
+	if (!env->bpf_capable)
+		reg->flags |= BPF_FLAG_PRECISE;
 }
 
 static void mark_reg_unknown(struct bpf_verifier_env *env,
@@ -7506,7 +7509,8 @@ static void maybe_widen_reg(struct bpf_verifier_env *env,
 		return;
 	if (rold->type != rcur->type)
 		return;
-	if (rold->precise || rcur->precise || scalars_exact_for_widen(rold, rcur))
+	if (reg_is_precise(rold) || reg_is_precise(rcur) ||
+	    scalars_exact_for_widen(rold, rcur))
 		return;
 	__mark_reg_unknown(env, rcur);
 }
@@ -14876,7 +14880,7 @@ static int adjust_reg_min_max_vals(struct bpf_verifier_env *env,
 				return err;
 			return adjust_ptr_min_max_vals(env, insn,
 						       dst_reg, src_reg);
-		} else if (dst_reg->precise) {
+		} else if (reg_is_precise(dst_reg)) {
 			/* if dst_reg is precise, src_reg should be precise as well */
 			err = mark_chain_precision(env, insn->src_reg);
 			if (err)
-- 
2.53.0-Meta

