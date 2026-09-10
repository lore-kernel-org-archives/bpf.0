Received: from mta0.migadu.com (out-197.mta0.migadu.com [91.218.175.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 740534AA030
	for <bpf@vger.kernel.org>; Thu, 10 Sep 2026 16:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789058824; cv=none; b=qHhpa04DTLyXLsnAS/tO8cud+z1IIuwHqadzNMuFgYBI8LrY0rUAOOSyYP3v4w2Yv+e4OmOSvep4L3OwJ1QvsS3mt2LpSFX40UL6Ha0rjXGgarecLXEwo6nIAuEkshyJLQBoZoH88yNgHYlapw+J4kNScpv+nI+yQikjRPXlAzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789058824; c=relaxed/simple;
	bh=nqFQ9oxsGrAj7hA8jLiWqmOy+bWh5bP0VEzW3mMQKO0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DoKBrVYdUyUHpWcJtU2XZBX1fTxAoPWQHJBuuHjQLyXlnHl1d/Tatl5dfc2xVWVZvxIl9XukhntvCSu49yQAZntSYoIFA4Sx6r+LO41Ovl8bW25fykBrhC1HJC4VzHAPvlVC7JtmWGMzjCTwnPUecCaWGg0VW/4+MgKHBkRx3mE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=SdEaH6Ms; arc=none smtp.client-ip=91.218.175.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="SdEaH6Ms"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=nqFQ9oxsGrAj7hA8jLiWqmOy+bWh5bP0VEzW3mMQKO0=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789058815; v=1; x=1789663615;
 b=SdEaH6Ms+TFgPEIXCdBVWNLAzNXYNdSm//u7+C2QqJ31PYU8nfpGehMttvrYRMdnLrRQ89Xn
 tedDGKOSSkOMWBW/hOxlm8cjgi9W+g0zt1cxBPFT10SoKLgii7XuYotx7HlFi/7GF0kUddZSI/p
 myovJYmPYdO7l6B8Ct34KkY4=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id c5233e1d0dae7e4e;
	Thu, 10 Sep 2026 16:46:54 +0000
X-Mizu-Trace-ID: c5233e1d0dae7e4e
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
Subject: [PATCH bpf-next v2 01/13] bpf: move linked-scalar flags out of bpf_reg_state->id [NFC]
Date: Thu, 10 Sep 2026 22:16:23 +0530
Message-ID: <20260910164635.459558-2-vineet.gupta@linux.dev>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260910164635.459558-1-vineet.gupta@linux.dev>
References: <20260910164635.459558-1-vineet.gupta@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bpf_reg_state->id doubles as a linked-register id and, in its top two
bits, as a record of how the register relates to that set:

  #define BPF_ADD_CONST64 (1U << 31)
  #define BPF_ADD_CONST32 (1U << 30)

Every user of ->id therefore has to mask, and more link kinds are coming.
Move the two bits into a bitfield next to ->precise, which is the last
field of the struct and outside every memcmp() window used for state
comparison, so the layout and all byte-wise comparisons are unchanged. The
two kinds are mutually exclusive, so a 2-bit enum captures them and makes
ADD_CONST_32 vs ADD_CONST_64 explicit at each use.

->id becomes a plain 32-bit identifier: no masking anywhere, and
check_scalar_ids() loses its two-level "check the compound id, then the
base id" dance in favour of a single check_ids().

While here, use regs_exact() for the explore_alu_limits case in regsafe():
it is what that open-coded memcmp+check_scalar_ids pair amounts to, and it
picks up the add_const comparison for free (parent_id is 0 for
SCALAR_VALUE).

check_stack_write_fixed_off() cleared ->id directly on a narrowing spill,
which would now leave ->add_const set without an id; use
clear_scalar_id().

Moving the kind out of ->id also drops an incidental comparison in
regs_exact(), which used to see it as part of the idmap key; the next
patch restores it. Otherwise no functional change intended.

Suggested-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Vineet Gupta <vineet.gupta@linux.dev>
---
v2: was RFC 2/6.
 - kinds are a 2-bit enum bitfield, not a byte of flags; RFC 1/6, which
   turned ->precise into that byte, is dropped (Eduard)
 - use regs_exact() for the explore_alu_limits case
 - clear_scalar_id() on the narrowing spill, which would otherwise leave
   ->add_const set without an id

 include/linux/bpf_verifier.h                  | 25 ++++++++-----
 kernel/bpf/log.c                              |  4 +--
 kernel/bpf/states.c                           | 35 +++++--------------
 kernel/bpf/verifier.c                         | 35 +++++++++++--------
 .../bpf/progs/verifier_linked_scalars.c       | 34 +++++++++---------
 5 files changed, 65 insertions(+), 68 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 9727df5af83a..afb1e5628698 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -35,6 +35,17 @@ enum bpf_iter_state {
 	BPF_ITER_STATE_DRAINED,
 };
 
+/*
+ * Records that a register is (base + ->delta) within its ->id set:
+ * r1 += 10;   r1 gets ADD_CONST_64 delta
+ * w3 += 10;   r3 gets ADD_CONST_32 delta
+ */
+enum bpf_add_const {
+	ADD_CONST_NONE = 0,
+	ADD_CONST_32,		/* delta was added with a 32-bit ALU op */
+	ADD_CONST_64,		/* ... with a 64-bit ALU op */
+};
+
 struct bpf_reg_state {
 	/* Ordering of fields matters.  See states_equal() */
 	enum bpf_reg_type type;
@@ -136,16 +147,9 @@ struct bpf_reg_state {
 	 * to a specific instance of bpf_iter.
 	 */
 	/*
-	 * Upper bit of ID is used to remember relationship between "linked"
-	 * registers. Example:
+	 * Registers sharing an ->id are "linked":
 	 * r1 = r2;    both will have r1->id == r2->id == N
-	 * r1 += 10;   r1->id == N | BPF_ADD_CONST and r1->delta == 10
-	 * r3 = r2;    both will have r3->id == r2->id == N
-	 * w3 += 10;   r3->id == N | BPF_ADD_CONST32 and r3->delta == 10
 	 */
-#define BPF_ADD_CONST64 (1U << 31)
-#define BPF_ADD_CONST32 (1U << 30)
-#define BPF_ADD_CONST (BPF_ADD_CONST64 | BPF_ADD_CONST32)
 	u32 id;
 	/*
 	 * Tracks the parent object this register was derived from.
@@ -164,6 +168,11 @@ struct bpf_reg_state {
 	u32 frameno;
 	/* if (!precise && SCALAR_VALUE) min/max/tnum don't affect safety */
 	bool precise;
+	/*
+	 * How this register relates to the others sharing its ->id.
+	 * Non-zero only if ->id is.
+	 */
+	enum bpf_add_const add_const:2;
 };
 
 static inline s64 reg_smin(const struct bpf_reg_state *reg)
diff --git a/kernel/bpf/log.c b/kernel/bpf/log.c
index fb032dfdc0de..f8d7a5c8052f 100644
--- a/kernel/bpf/log.c
+++ b/kernel/bpf/log.c
@@ -651,8 +651,8 @@ static void print_reg_state(struct bpf_verifier_env *env,
 		verbose(env, "%s", btf_type_name(reg->btf, reg->btf_id));
 	verbose(env, "(");
 	if (reg->id)
-		verbose_a("id=%d", reg->id & ~BPF_ADD_CONST);
-	if (reg->id & BPF_ADD_CONST)
+		verbose_a("id=%d", reg->id);
+	if (reg->add_const)
 		verbose(env, "%+d", reg->delta);
 	if (reg->parent_id)
 		verbose_a("parent_id=%d", reg->parent_id);
diff --git a/kernel/bpf/states.c b/kernel/bpf/states.c
index 66fb11b6c6a7..d974baad37ee 100644
--- a/kernel/bpf/states.c
+++ b/kernel/bpf/states.c
@@ -369,13 +369,6 @@ static bool check_ids(u32 old_id, u32 cur_id, struct bpf_idmap *idmap)
  * and r7.id=0 (both independent), without temp IDs both would map old_id=X
  * to cur_id=0 and pass. With temp IDs: r6 maps X->temp1, r7 tries to map
  * X->temp2, but X is already mapped to temp1, so the check fails correctly.
- *
- * When old_id has BPF_ADD_CONST set, the compound id (base | flag) and the
- * base id (flag stripped) must both map consistently. Example: old has
- * r2.id=A, r3.id=A|flag (r3 = r2 + delta), cur has r2.id=B, r3.id=C|flag
- * (r3 derived from unrelated r4). Without the base check, idmap gets two
- * independent entries A->B and A|flag->C|flag, missing that A->C conflicts
- * with A->B. The base ID cross-check catches this.
  */
 static bool check_scalar_ids(u32 old_id, u32 cur_id, struct bpf_idmap *idmap)
 {
@@ -384,15 +377,7 @@ static bool check_scalar_ids(u32 old_id, u32 cur_id, struct bpf_idmap *idmap)
 
 	cur_id = cur_id ? cur_id : ++idmap->tmp_id_gen;
 
-	if (!check_ids(old_id, cur_id, idmap))
-		return false;
-	if (old_id & BPF_ADD_CONST) {
-		old_id &= ~BPF_ADD_CONST;
-		cur_id &= ~BPF_ADD_CONST;
-		if (!check_ids(old_id, cur_id, idmap))
-			return false;
-	}
-	return true;
+	return check_ids(old_id, cur_id, idmap);
 }
 
 static void __clean_func_state(struct bpf_verifier_env *env,
@@ -542,8 +527,7 @@ static bool regsafe(struct bpf_verifier_env *env, struct bpf_reg_state *rold,
 			/* explore_alu_limits disables tnum_in() and range_within()
 			 * logic and requires everything to be strict
 			 */
-			return memcmp(rold, rcur, offsetof(struct bpf_reg_state, id)) == 0 &&
-			       check_scalar_ids(rold->id, rcur->id, idmap);
+			return regs_exact(rold, rcur, idmap);
 		}
 		if (!rold->precise && exact == NOT_EXACT)
 			return true;
@@ -551,7 +535,8 @@ static bool regsafe(struct bpf_verifier_env *env, struct bpf_reg_state *rold,
 		 * Linked register tracking uses rold->id to detect relationships.
 		 * When rold->id == 0, the register is independent and any linking
 		 * in rcur only adds constraints. When rold->id != 0, we must verify
-		 * id mapping and (for BPF_ADD_CONST) offset consistency.
+		 * id mapping and that the link kinds agree, along with any delta
+		 * they carry.
 		 *
 		 * +------------------+-----------+------------------+---------------+
 		 * |                  | rold->id  | rold + ADD_CONST | rold->id == 0 |
@@ -587,17 +572,15 @@ static bool regsafe(struct bpf_verifier_env *env, struct bpf_reg_state *rold,
 		 */
 
 		/*
-		 * ADD_CONST flags must match exactly: BPF_ADD_CONST32 and
-		 * BPF_ADD_CONST64 have different linking semantics in
-		 * sync_linked_regs() (alu32 zero-extends, alu64 does not),
-		 * so pruning across different flag types is unsafe.
+		 * The link kinds must match: alu32 and alu64 adds have different
+		 * linking semantics in sync_linked_regs() (alu32 zero-extends,
+		 * alu64 does not), so pruning across them is unsafe.
 		 */
-		if (rold->id &&
-		    (rold->id & BPF_ADD_CONST) != (rcur->id & BPF_ADD_CONST))
+		if (rold->id && rold->add_const != rcur->add_const)
 			return false;
 
 		/* Both have offset linkage: offsets must match */
-		if ((rold->id & BPF_ADD_CONST) && rold->delta != rcur->delta)
+		if (rold->add_const && rold->delta != rcur->delta)
 			return false;
 
 		if (!check_scalar_ids(rold->id, rcur->id, idmap))
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 9e79750e2480..0ca229f6e7ac 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -1907,6 +1907,7 @@ static void __mark_reg_known(struct bpf_reg_state *reg, u64 imm)
 	       offsetof(struct bpf_reg_state, var_off) - sizeof(reg->type));
 	reg->id = 0;
 	reg->parent_id = 0;
+	reg->add_const = ADD_CONST_NONE;
 	___mark_reg_known(reg, imm);
 }
 
@@ -3480,6 +3481,7 @@ static void clear_scalar_id(struct bpf_reg_state *reg)
 {
 	reg->id = 0;
 	reg->delta = 0;
+	reg->add_const = ADD_CONST_NONE;
 }
 
 static void assign_scalar_id_before_mov(struct bpf_verifier_env *env,
@@ -3492,7 +3494,7 @@ static void assign_scalar_id_before_mov(struct bpf_verifier_env *env,
 	 * rY->id has special linked register already.
 	 * Cleared it, since multiple rX += const are not supported.
 	 */
-	if (src_reg->id & BPF_ADD_CONST)
+	if (src_reg->add_const)
 		clear_scalar_id(src_reg);
 	/*
 	 * Ensure that src_reg has a valid ID that will be copied to
@@ -3642,7 +3644,7 @@ static int check_stack_write_fixed_off(struct bpf_verifier_env *env,
 		save_register_state(env, state, spi, reg, size);
 		/* Break the relation on a narrowing spill. */
 		if (!reg_value_fits)
-			state->stack[spi].spilled_ptr.id = 0;
+			clear_scalar_id(&state->stack[spi].spilled_ptr);
 	} else if (!reg && !(off % BPF_REG_SIZE) && is_bpf_st_mem(insn) &&
 		   env->bpf_capable) {
 		struct bpf_reg_state *tmp_reg = &env->fake_reg[0];
@@ -16117,7 +16119,7 @@ static int adjust_reg_min_max_vals(struct bpf_verifier_env *env,
 			off = -off;
 		}
 
-		if (dst_reg->id & BPF_ADD_CONST) {
+		if (dst_reg->add_const) {
 			/*
 			 * If the register already went through rX += val
 			 * we cannot accumulate another val into rx->off.
@@ -16126,9 +16128,9 @@ static int adjust_reg_min_max_vals(struct bpf_verifier_env *env,
 			clear_scalar_id(dst_reg);
 		} else {
 			if (alu32)
-				dst_reg->id |= BPF_ADD_CONST32;
+				dst_reg->add_const = ADD_CONST_32;
 			else
-				dst_reg->id |= BPF_ADD_CONST64;
+				dst_reg->add_const = ADD_CONST_64;
 			dst_reg->delta = off;
 		}
 	} else {
@@ -17067,7 +17069,7 @@ static void __collect_linked_regs(struct linked_regs *reg_set, struct bpf_reg_st
 {
 	struct linked_reg *e;
 
-	if (reg->type != SCALAR_VALUE || (reg->id & ~BPF_ADD_CONST) != id)
+	if (reg->type != SCALAR_VALUE || reg->id != id)
 		return;
 
 	e = linked_regs_push(reg_set);
@@ -17095,7 +17097,6 @@ static void collect_linked_regs(struct bpf_verifier_env *env,
 	u16 live_regs;
 	int i, j;
 
-	id = id & ~BPF_ADD_CONST;
 	for (i = vstate->curframe; i >= 0; i--) {
 		live_regs = aux[bpf_frame_insn_idx(vstate, i)].live_regs_before;
 		func = vstate->frame[i];
@@ -17131,18 +17132,20 @@ static void sync_linked_regs(struct bpf_verifier_env *env, struct bpf_verifier_s
 				: &vstate->frame[e->frameno]->stack[e->spi].spilled_ptr;
 		if (reg->type != SCALAR_VALUE || reg == known_reg)
 			continue;
-		if ((reg->id & ~BPF_ADD_CONST) != (known_reg->id & ~BPF_ADD_CONST))
+		if (reg->id != known_reg->id)
 			continue;
 		/*
 		 * Skip mixed 32/64-bit links: the delta relationship doesn't
 		 * hold across different ALU widths.
 		 */
-		if (((reg->id ^ known_reg->id) & BPF_ADD_CONST) == BPF_ADD_CONST)
+		if (reg->add_const && known_reg->add_const &&
+		    reg->add_const != known_reg->add_const)
 			continue;
-		if ((!(reg->id & BPF_ADD_CONST) && !(known_reg->id & BPF_ADD_CONST)) ||
+		if ((!reg->add_const && !known_reg->add_const) ||
 		    reg->delta == known_reg->delta) {
 			*reg = *known_reg;
 		} else {
+			enum bpf_add_const saved_add_const = reg->add_const;
 			s32 saved_off = reg->delta;
 			u32 saved_id = reg->id;
 
@@ -17152,16 +17155,18 @@ static void sync_linked_regs(struct bpf_verifier_env *env, struct bpf_verifier_s
 			/* reg = known_reg; reg += delta */
 			*reg = *known_reg;
 			/*
-			 * Must preserve off and id, otherwise another sync_linked_regs()
-			 * will be incorrect.
+			 * Must preserve off, id and add_const, otherwise another
+			 * sync_linked_regs() will be incorrect.
 			 */
 			reg->delta = saved_off;
 			reg->id = saved_id;
+			reg->add_const = saved_add_const;
 
 			scalar32_min_max_add(reg, &fake_reg);
 			scalar_min_max_add(reg, &fake_reg);
 			reg->var_off = tnum_add(reg->var_off, fake_reg.var_off);
-			if ((reg->id | known_reg->id) & BPF_ADD_CONST32)
+			if (reg->add_const == ADD_CONST_32 ||
+			    known_reg->add_const == ADD_CONST_32)
 				zext_32_to_64(reg);
 			reg_bounds_sync(reg);
 		}
@@ -18255,7 +18260,7 @@ void bpf_clear_singular_ids(struct bpf_verifier_env *env,
 			continue;
 		if (!reg->id)
 			continue;
-		idset_cnt_inc(idset, reg->id & ~BPF_ADD_CONST);
+		idset_cnt_inc(idset, reg->id);
 	}));
 
 	bpf_for_each_reg_in_vstate(st, func, reg, ({
@@ -18263,7 +18268,7 @@ void bpf_clear_singular_ids(struct bpf_verifier_env *env,
 			continue;
 		if (!reg->id)
 			continue;
-		if (idset_cnt_get(idset, reg->id & ~BPF_ADD_CONST) == 1)
+		if (idset_cnt_get(idset, reg->id) == 1)
 			clear_scalar_id(reg);
 	}));
 }
diff --git a/tools/testing/selftests/bpf/progs/verifier_linked_scalars.c b/tools/testing/selftests/bpf/progs/verifier_linked_scalars.c
index d571fbfc86a3..da6cb961a520 100644
--- a/tools/testing/selftests/bpf/progs/verifier_linked_scalars.c
+++ b/tools/testing/selftests/bpf/progs/verifier_linked_scalars.c
@@ -349,8 +349,8 @@ l0_%=:							\
 }
 
 /*
- * Test that sync_linked_regs() checks reg->id (the linked target register)
- * for BPF_ADD_CONST32 rather than known_reg->id (the branch register).
+ * Test that sync_linked_regs() checks the linked target register (reg) for
+ * ADD_CONST_32 rather than the branch register (known_reg).
  */
 SEC("socket")
 __success
@@ -360,7 +360,7 @@ __naked void scalars_alu32_zext_linked_reg(void)
 	call %[bpf_get_prandom_u32];				\
 	w6 = w0;		/* r6 in [0, 0xFFFFFFFF] */	\
 	r7 = r6;		/* linked: same id as r6 */	\
-	w7 += 1;		/* alu32: r7.id |= BPF_ADD_CONST32 */ \
+	w7 += 1;		/* ADD_CONST_32 delta */ \
 	r8 = 0xFFFFffff ll;					\
 	if r6 < r8 goto l0_%=;					\
 	/* r6 in [0xFFFFFFFF, 0xFFFFFFFF] */			\
@@ -381,7 +381,7 @@ l0_%=:								\
 
 /*
  * Test that sync_linked_regs() skips propagation when one register used
- * alu32 (BPF_ADD_CONST32) and the other used alu64 (BPF_ADD_CONST64).
+ * alu32 (ADD_CONST_32) and the other used alu64 (ADD_CONST_64).
  * The delta relationship doesn't hold across different ALU widths.
  */
 SEC("socket")
@@ -392,13 +392,13 @@ __naked void scalars_alu32_alu64_cross_type(void)
 	call %[bpf_get_prandom_u32];				\
 	w6 = w0;		/* r6 in [0, 0xFFFFFFFF] */	\
 	r7 = r6;		/* linked: same id as r6 */	\
-	w7 += 1;		/* alu32: BPF_ADD_CONST32, delta = 1 */ \
+	w7 += 1;		/* ADD_CONST_32 delta */ \
 	r8 = r6;		/* linked: same id as r6 */	\
-	r8 += 2;		/* alu64: BPF_ADD_CONST64, delta = 2 */ \
+	r8 += 2;		/* ADD_CONST_64 delta */ \
 	r9 = 0xFFFFffff ll;					\
 	if r7 < r9 goto l0_%=;					\
 	/* r7 = 0xFFFFFFFF */					\
-	/* sync: known_reg=r7 (ADD_CONST32), reg=r8 (ADD_CONST64) */ \
+	/* sync: known_reg=r7 (ADD_CONST_32), reg=r8 (ADD_CONST_64) */ \
 	/* Without fix: r8 = zext(0xFFFFFFFF + 1) = 0 */	\
 	/* With fix: r8 stays [2, 0x100000001] (r8 >= 2) */	\
 	if r8 > 0 goto l1_%=;					\
@@ -416,7 +416,7 @@ l0_%=:								\
 /*
  * Test that regsafe() prevents pruning when two paths reach the same program
  * point with linked registers carrying different ADD_CONST flags (one
- * BPF_ADD_CONST32 from alu32, another BPF_ADD_CONST64 from alu64).
+ * ADD_CONST_32 from alu32, another ADD_CONST_64 from alu64).
  */
 SEC("socket")
 __failure __msg("div by zero")
@@ -431,11 +431,11 @@ __naked void scalars_alu32_alu64_regsafe_pruning(void)
 	call %[bpf_get_prandom_u32];				\
 	if r0 > 0 goto l_pathb_%=;				\
 	/* Path A: alu32 */					\
-	w7 += 1;		/* BPF_ADD_CONST32, delta = 1 */\
+	w7 += 1;		/* ADD_CONST_32 delta */\
 	goto l_merge_%=;					\
 l_pathb_%=:							\
 	/* Path B: alu64 */					\
-	r7 += 1;		/* BPF_ADD_CONST64, delta = 1 */\
+	r7 += 1;		/* ADD_CONST_64 delta */\
 l_merge_%=:							\
 	/* Merge point: regsafe() compares path B against cached path A. */ \
 	/* Narrow r6 to trigger sync_linked_regs for r7 */	\
@@ -593,7 +593,7 @@ l_exit_%=:							\
 }
 
 /*
- * Test that stale delta from a cleared BPF_ADD_CONST does not leak
+ * Test that stale delta from a cleared ADD_CONST_* does not leak
  * through assign_scalar_id_before_mov() into a new id, causing
  * sync_linked_regs() to compute an incorrect offset.
  */
@@ -605,10 +605,10 @@ __naked void scalars_stale_delta_from_cleared_id(void)
 	asm volatile ("						\
 	call %[bpf_get_prandom_u32];				\
 	r6 = r0;		/* r6 unknown, gets id A */	\
-	r6 += 5;		/* id A|ADD_CONST, delta 5 */	\
+	r6 += 5;		/* id A, ADD_CONST_64 delta */	\
 	r6 ^= 0;		/* id cleared; delta stays 5 */	\
 	r8 = r6;		/* new id B, stale delta 5 */	\
-	r8 += 3;		/* id B|ADD_CONST, delta 3 */	\
+	r8 += 3;		/* id B, ADD_CONST_64 delta */	\
 	r9 = r6;		/* id B, stale delta 5 */	\
 	if r9 != 10 goto l_exit_%=;				\
 	/* Bug: r8 = 10+(3-5) = 8; Fix: r8 = 10+(3-0) = 13 */	\
@@ -648,10 +648,10 @@ l_exit_%=:							\
 }
 
 /*
- * Test that regsafe() verifies base_id consistency for BPF_ADD_CONST
+ * Test that regsafe() verifies base_id consistency for ADD_CONST_*
  * linked scalars during state pruning.
  *
- * The false branch (explored first) links R3 to R2 via ADD_CONST.
+ * The false branch (explored first) links R3 to R2 via ADD_CONST_64.
  * The true branch (runtime path) links R3 to R4 (unrelated base_id).
  * At the merge point, pruning must fail because the linkage topology
  * differs.
@@ -675,7 +675,7 @@ __naked void add_const_base_id_pruning(void)
 	r2 = r0;						\
 	r2 &= 0xff;		/* R2 = scalar(id=A) [0,255] */	\
 	r3 = r2;		/* R3 linked to R2 (id=A) */	\
-	r3 += 10;		/* R3 id=A|ADD_CONST, delta=10 */\
+	r3 += 10;		/* ADD_CONST_64 delta */\
 	r6 = 0;							\
 	goto l_merge_%=;					\
 								\
@@ -687,7 +687,7 @@ l_true_%=:							\
 	r4 = r0;						\
 	r4 &= 0xff;		/* R4 = scalar [0,255], id=0 */	\
 	r3 = r4;		/* R3 linked to R4 (new id=C) */\
-	r3 += 10;		/* R3 id=C|ADD_CONST, delta=10 */\
+	r3 += 10;		/* ADD_CONST_64 delta */\
 	r6 = 0;							\
 								\
 l_merge_%=:							\
-- 
2.53.0-Meta

