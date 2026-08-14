Received: from mta0.migadu.com (out-224.mta0.migadu.com [91.218.175.224])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1EE33E3C74
	for <bpf@vger.kernel.org>; Fri, 14 Aug 2026 23:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.224
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786749611; cv=none; b=pcHy0PL5WBEixUynZ5BgdSzVaYx87TVkhealbdTi6XnJYzGh/jPVbmmyM+AkST2LgtPKwk5NY7xeECm+kZwZ+tAN/B/xKmc2Zd2lrUp2/MvQQ8v0FyFVL3FtcQ6lxpRCB58PYHjK2NlMQi/3Lq52alB3L+pi7GJ0CZhdnZh2nW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786749611; c=relaxed/simple;
	bh=83G2vJPKsA0PHnFZqh1qlVx++CFo11gZxgu88reMHsE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GzWDXXcfrzlAKd75Td5KmPR7wMCqQZimf+QYm7Dy5ontIgQ+9anSHaW9LNQpFT8ORUb5H3uEXsjDPh1clsFavTEEFLVgvEDHIufN078WnweIt948hZknSHsn2m9pNmsvNRMtsoaCMkG/5JbGVzrcFEhO2sQrc5MAevGOE7wKkbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Fi5YjXtx; arc=none smtp.client-ip=91.218.175.224
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Fi5YjXtx"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=83G2vJPKsA0PHnFZqh1qlVx++CFo11gZxgu88reMHsE=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786749606; v=1; x=1787354406;
 b=Fi5YjXtx5GFUq2VAObg//TtsyuYz/fVmits/baBdggKaXK8hZLCdit+4HHtZGUs7PF4dH6sw
 bQ2k7UjDW0CoWJXzp1D7wnisRIKXHu288wSsY0bx1kvmqZTO3XIng/dlkaZDguGPjU+xX4qTFao
 EgXmgmvX3PhClFUNxX6HKmTg=
X-Envelope-To: bpf@vger.kernel.org
Received: from gvineet-fedora-PF5JGVFY.thefacebook.com (2620:10d:c090:500::6:7be4)
	by smtp.migadu.com with ESMTPS id 2f2552a5b17687f9;
	Fri, 14 Aug 2026 23:20:06 +0000
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
Subject: [RFC bpf-next 2/6] bpf: move the linked-scalar flags into bpf_reg_state->flags [NFC]
Date: Fri, 14 Aug 2026 16:19:41 -0700
Message-ID: <20260814231945.3884596-3-vineet.gupta@linux.dev>
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

bpf_reg_state->id is an overloaded container for:
 - "id" corresponding to "linked" registers
 - linkage type flags

This was fine so far, however new linkage types are coming so better to
separate them:
 - checking for "id" doesn't need masking out flags: this is both
   cleaner and future-proof
 - makes ->id full 32-bits

The best part is no additional space needed as it piggybacks on the
previous patch creating a flags field.

The cleanup of check_scalar_ids() alone is worth this:

 - Its two-level "check the compound id, then check the base id" dance
   existed only because the flag was part of the key. With a plain id there
   is one key and a single check_ids() suffices; the flag and delta equality
   that regsafe() already enforces cover the rest.

However, ->flags now sits past the end of every memcmp() window used for
state comparison (they stop at offsetof(id), offsetof(var_off) or
offsetof(frameno)), and check_ids() only ever sees the plain ->id. While the
flags lived in the top bits of ->id they were compared for free -- byte-wise
by states_maybe_looping(), and as part of the compound key by regs_exact().
Now they have to be compared explicitly, so add a helper and call it from
both places that compare a scalar identity:

	static bool link_flags_match(rold, rcur)
	{
		if (!rold->id)
			return true;
		return (rold->flags & BPF_FLAG_ADD_CONST) ==
		       (rcur->flags & BPF_FLAG_ADD_CONST);
	}

regsafe() keeps its check in the same spot, now expressed via the helper, so
its behaviour is unchanged. regs_exact() gains the check it lost; that is the
one place this patch is not bit-identical to the old compound-key behaviour,
but it restores the discrimination the compound key provided rather than
adding new strictness. states_maybe_looping() is covered through
states_equal(EXACT), which routes to regs_exact().

The helper is the single point to extend when further link flavours are added.

Two more places need care now that these flags share a byte with
BPF_FLAG_PRECISE:

- clear_scalar_id() and __mark_reg_known() clear only the ADD_CONST bits, not
  the whole byte, so the precise marking survives as before.
- sync_linked_regs() does "*reg = *known_reg" and then restores the fields
  that identify reg rather than known_reg. Only the ADD_CONST bits belong to
  that set (they used to live in ->id); BPF_FLAG_PRECISE must keep coming
  from known_reg, as it did when it was a separate bool. So the save/restore
  is masked to BPF_FLAG_ADD_CONST rather than covering ->flags wholesale.

No functional change intended.

Suggested-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Vineet Gupta <vineet.gupta@linux.dev>
---
 include/linux/bpf_verifier.h                  | 18 +++---
 kernel/bpf/log.c                              |  4 +-
 kernel/bpf/states.c                           | 64 ++++++++++++-------
 kernel/bpf/verifier.c                         | 27 ++++----
 .../bpf/progs/verifier_linked_scalars.c       | 23 +++----
 5 files changed, 81 insertions(+), 55 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index ebab483fc7f2..2b03fdba9acf 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -136,16 +136,13 @@ struct bpf_reg_state {
 	 * to a specific instance of bpf_iter.
 	 */
 	/*
-	 * Upper bit of ID is used to remember relationship between "linked"
-	 * registers. Example:
+	 * ->id identifies a set of "linked" registers; how a given member
+	 * relates to the others is recorded in ->flags. Example:
 	 * r1 = r2;    both will have r1->id == r2->id == N
-	 * r1 += 10;   r1->id == N | BPF_ADD_CONST and r1->delta == 10
+	 * r1 += 10;   r1 gets BPF_FLAG_ADD_CONST64 and r1->delta == 10
 	 * r3 = r2;    both will have r3->id == r2->id == N
-	 * w3 += 10;   r3->id == N | BPF_ADD_CONST32 and r3->delta == 10
+	 * w3 += 10;   r3 gets BPF_FLAG_ADD_CONST32 and r3->delta == 10
 	 */
-#define BPF_ADD_CONST64 (1U << 31)
-#define BPF_ADD_CONST32 (1U << 30)
-#define BPF_ADD_CONST (BPF_ADD_CONST64 | BPF_ADD_CONST32)
 	u32 id;
 	/*
 	 * Tracks the parent object this register was derived from.
@@ -166,11 +163,16 @@ struct bpf_reg_state {
 	 * Register state flags.
 	 * BPF_FLAG_PRECISE: if unset, and this is a SCALAR_VALUE, then
 	 * min/max/tnum don't affect safety.
-	 *
 	 * PRECISE is a property of this register alone, so it is placed at bit 7,
 	 * apart from the link flags, which grow up from bit 0 and are cleared as
 	 * a group -- a clear-the-link-bits mask can then never reach it.
+	 *
+	 * BPF_FLAG_ADD_CONST{32,64}: this register is (base + ->delta) within
+	 * its ->id set, computed with a 32- or 64-bit ALU add.
 	 */
+#define BPF_FLAG_ADD_CONST32	(1U << 0)
+#define BPF_FLAG_ADD_CONST64	(1U << 1)
+#define BPF_FLAG_ADD_CONST	(BPF_FLAG_ADD_CONST32 | BPF_FLAG_ADD_CONST64)
 #define BPF_FLAG_PRECISE	(1U << 7)
 	u8 flags;
 };
diff --git a/kernel/bpf/log.c b/kernel/bpf/log.c
index 9a4445d492c9..775b91f806ac 100644
--- a/kernel/bpf/log.c
+++ b/kernel/bpf/log.c
@@ -662,8 +662,8 @@ static void print_reg_state(struct bpf_verifier_env *env,
 		verbose(env, "%s", btf_type_name(reg->btf, reg->btf_id));
 	verbose(env, "(");
 	if (reg->id)
-		verbose_a("id=%d", reg->id & ~BPF_ADD_CONST);
-	if (reg->id & BPF_ADD_CONST)
+		verbose_a("id=%d", reg->id);
+	if (reg->flags & BPF_FLAG_ADD_CONST)
 		verbose(env, "%+d", reg->delta);
 	if (reg->parent_id)
 		verbose_a("parent_id=%d", reg->parent_id);
diff --git a/kernel/bpf/states.c b/kernel/bpf/states.c
index f7a0314fa106..d3105b9a9965 100644
--- a/kernel/bpf/states.c
+++ b/kernel/bpf/states.c
@@ -370,12 +370,12 @@ static bool check_ids(u32 old_id, u32 cur_id, struct bpf_idmap *idmap)
  * to cur_id=0 and pass. With temp IDs: r6 maps X->temp1, r7 tries to map
  * X->temp2, but X is already mapped to temp1, so the check fails correctly.
  *
- * When old_id has BPF_ADD_CONST set, the compound id (base | flag) and the
- * base id (flag stripped) must both map consistently. Example: old has
- * r2.id=A, r3.id=A|flag (r3 = r2 + delta), cur has r2.id=B, r3.id=C|flag
- * (r3 derived from unrelated r4). Without the base check, idmap gets two
- * independent entries A->B and A|flag->C|flag, missing that A->C conflicts
- * with A->B. The base ID cross-check catches this.
+ * ->id is a plain identifier -- the ADD_CONST relationship lives in
+ * ->flags -- so there is no compound (base | flag) key to unpack here.
+ * Registers sharing a base id go through one idmap entry, which is what
+ * catches e.g. old r2.id=A, r3.id=A (r3 = r2 + delta) against cur r2.id=B,
+ * r3.id=C: A->B and A->C conflict. Matching ->flags and ->delta are checked
+ * by the caller in regsafe().
  */
 static bool check_scalar_ids(u32 old_id, u32 cur_id, struct bpf_idmap *idmap)
 {
@@ -384,15 +384,7 @@ static bool check_scalar_ids(u32 old_id, u32 cur_id, struct bpf_idmap *idmap)
 
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
@@ -488,11 +480,32 @@ static int clean_verifier_state(struct bpf_verifier_env *env,
 	return 0;
 }
 
+/*
+ * Do rold and rcur describe the same relationship to their ->id set?
+ *
+ * The link flags live in ->flags, which sits past the end of every memcmp()
+ * window used for state comparison, and check_ids() only ever sees the plain
+ * ->id. So unlike when these bits rode along in the top of ->id, they have to
+ * be compared explicitly everywhere ->id is.
+ *
+ * Only meaningful when rold carries an id: the flags are only ever set
+ * together with one, so rold->id == 0 implies none of them is set.
+ */
+static bool link_flags_match(const struct bpf_reg_state *rold,
+			     const struct bpf_reg_state *rcur)
+{
+	if (!rold->id)
+		return true;
+
+	return (rold->flags & BPF_FLAG_ADD_CONST) == (rcur->flags & BPF_FLAG_ADD_CONST);
+}
+
 static bool regs_exact(const struct bpf_reg_state *rold,
 		       const struct bpf_reg_state *rcur,
 		       struct bpf_idmap *idmap)
 {
 	return memcmp(rold, rcur, offsetof(struct bpf_reg_state, id)) == 0 &&
+	       link_flags_match(rold, rcur) &&
 	       check_ids(rold->id, rcur->id, idmap) &&
 	       check_ids(rold->parent_id, rcur->parent_id, idmap);
 }
@@ -554,7 +567,7 @@ static bool regsafe(struct bpf_verifier_env *env, struct bpf_reg_state *rold,
 		 * Linked register tracking uses rold->id to detect relationships.
 		 * When rold->id == 0, the register is independent and any linking
 		 * in rcur only adds constraints. When rold->id != 0, we must verify
-		 * id mapping and (for BPF_ADD_CONST) offset consistency.
+		 * id mapping and (for BPF_FLAG_ADD_CONST) offset consistency.
 		 *
 		 * +------------------+-----------+------------------+---------------+
 		 * |                  | rold->id  | rold + ADD_CONST | rold->id == 0 |
@@ -590,17 +603,24 @@ static bool regsafe(struct bpf_verifier_env *env, struct bpf_reg_state *rold,
 		 */
 
 		/*
-		 * ADD_CONST flags must match exactly: BPF_ADD_CONST32 and
-		 * BPF_ADD_CONST64 have different linking semantics in
+		 * ADD_CONST flags must match exactly: BPF_FLAG_ADD_CONST32 and
+		 * BPF_FLAG_ADD_CONST64 have different linking semantics in
 		 * sync_linked_regs() (alu32 zero-extends, alu64 does not),
 		 * so pruning across different flag types is unsafe.
 		 */
-		if (rold->id &&
-		    (rold->id & BPF_ADD_CONST) != (rcur->id & BPF_ADD_CONST))
+		if (!link_flags_match(rold, rcur))
 			return false;
 
-		/* Both have offset linkage: offsets must match */
-		if ((rold->id & BPF_ADD_CONST) && rold->delta != rcur->delta)
+		/*
+		 * Both have offset linkage: offsets must match. The rold->id
+		 * test is redundant today -- BPF_FLAG_ADD_CONST is only ever set
+		 * together with an id -- but it used to be structural, because
+		 * the flag lived in the id itself. Keep it explicit so the
+		 * invariant does not rest on every ->id = 0 site remembering to
+		 * clear ->flags too.
+		 */
+		if (rold->id && (rold->flags & BPF_FLAG_ADD_CONST) &&
+		    rold->delta != rcur->delta)
 			return false;
 
 		if (!check_scalar_ids(rold->id, rcur->id, idmap))
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 8925749d636e..93e69116ca9e 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -1806,6 +1806,7 @@ static void __mark_reg_known(struct bpf_reg_state *reg, u64 imm)
 	       offsetof(struct bpf_reg_state, var_off) - sizeof(reg->type));
 	reg->id = 0;
 	reg->parent_id = 0;
+	reg->flags &= ~BPF_FLAG_ADD_CONST;
 	___mark_reg_known(reg, imm);
 }
 
@@ -3308,6 +3309,7 @@ static void clear_scalar_id(struct bpf_reg_state *reg)
 {
 	reg->id = 0;
 	reg->delta = 0;
+	reg->flags &= ~BPF_FLAG_ADD_CONST;
 }
 
 static void assign_scalar_id_before_mov(struct bpf_verifier_env *env,
@@ -3320,7 +3322,7 @@ static void assign_scalar_id_before_mov(struct bpf_verifier_env *env,
 	 * rY->id has special linked register already.
 	 * Cleared it, since multiple rX += const are not supported.
 	 */
-	if (src_reg->id & BPF_ADD_CONST)
+	if (src_reg->flags & BPF_FLAG_ADD_CONST)
 		clear_scalar_id(src_reg);
 	/*
 	 * Ensure that src_reg has a valid ID that will be copied to
@@ -14950,7 +14952,7 @@ static int adjust_reg_min_max_vals(struct bpf_verifier_env *env,
 			off = -off;
 		}
 
-		if (dst_reg->id & BPF_ADD_CONST) {
+		if (dst_reg->flags & BPF_FLAG_ADD_CONST) {
 			/*
 			 * If the register already went through rX += val
 			 * we cannot accumulate another val into rx->off.
@@ -14959,9 +14961,9 @@ static int adjust_reg_min_max_vals(struct bpf_verifier_env *env,
 			clear_scalar_id(dst_reg);
 		} else {
 			if (alu32)
-				dst_reg->id |= BPF_ADD_CONST32;
+				dst_reg->flags |= BPF_FLAG_ADD_CONST32;
 			else
-				dst_reg->id |= BPF_ADD_CONST64;
+				dst_reg->flags |= BPF_FLAG_ADD_CONST64;
 			dst_reg->delta = off;
 		}
 	} else {
@@ -15886,7 +15888,7 @@ static void __collect_linked_regs(struct linked_regs *reg_set, struct bpf_reg_st
 {
 	struct linked_reg *e;
 
-	if (reg->type != SCALAR_VALUE || (reg->id & ~BPF_ADD_CONST) != id)
+	if (reg->type != SCALAR_VALUE || reg->id != id)
 		return;
 
 	e = linked_regs_push(reg_set);
@@ -15914,7 +15916,6 @@ static void collect_linked_regs(struct bpf_verifier_env *env,
 	u16 live_regs;
 	int i, j;
 
-	id = id & ~BPF_ADD_CONST;
 	for (i = vstate->curframe; i >= 0; i--) {
 		live_regs = aux[bpf_frame_insn_idx(vstate, i)].live_regs_before;
 		func = vstate->frame[i];
@@ -15950,18 +15951,19 @@ static void sync_linked_regs(struct bpf_verifier_env *env, struct bpf_verifier_s
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
+		if (((reg->flags ^ known_reg->flags) & BPF_FLAG_ADD_CONST) == BPF_FLAG_ADD_CONST)
 			continue;
-		if ((!(reg->id & BPF_ADD_CONST) && !(known_reg->id & BPF_ADD_CONST)) ||
+		if ((!(reg->flags & BPF_FLAG_ADD_CONST) && !(known_reg->flags & BPF_FLAG_ADD_CONST)) ||
 		    reg->delta == known_reg->delta) {
 			*reg = *known_reg;
 		} else {
+			u8 saved_add_const = reg->flags & BPF_FLAG_ADD_CONST;
 			s32 saved_off = reg->delta;
 			u32 saved_id = reg->id;
 
@@ -15976,11 +15978,12 @@ static void sync_linked_regs(struct bpf_verifier_env *env, struct bpf_verifier_s
 			 */
 			reg->delta = saved_off;
 			reg->id = saved_id;
+			reg->flags = (reg->flags & ~BPF_FLAG_ADD_CONST) | saved_add_const;
 
 			scalar32_min_max_add(reg, &fake_reg);
 			scalar_min_max_add(reg, &fake_reg);
 			reg->var_off = tnum_add(reg->var_off, fake_reg.var_off);
-			if ((reg->id | known_reg->id) & BPF_ADD_CONST32)
+			if ((reg->flags | known_reg->flags) & BPF_FLAG_ADD_CONST32)
 				zext_32_to_64(reg);
 			reg_bounds_sync(reg);
 		}
@@ -17007,7 +17010,7 @@ void bpf_clear_singular_ids(struct bpf_verifier_env *env,
 			continue;
 		if (!reg->id)
 			continue;
-		idset_cnt_inc(idset, reg->id & ~BPF_ADD_CONST);
+		idset_cnt_inc(idset, reg->id);
 	}));
 
 	bpf_for_each_reg_in_vstate(st, func, reg, ({
@@ -17015,7 +17018,7 @@ void bpf_clear_singular_ids(struct bpf_verifier_env *env,
 			continue;
 		if (!reg->id)
 			continue;
-		if (idset_cnt_get(idset, reg->id & ~BPF_ADD_CONST) == 1)
+		if (idset_cnt_get(idset, reg->id) == 1)
 			clear_scalar_id(reg);
 	}));
 }
diff --git a/tools/testing/selftests/bpf/progs/verifier_linked_scalars.c b/tools/testing/selftests/bpf/progs/verifier_linked_scalars.c
index d571fbfc86a3..c80747c16bcf 100644
--- a/tools/testing/selftests/bpf/progs/verifier_linked_scalars.c
+++ b/tools/testing/selftests/bpf/progs/verifier_linked_scalars.c
@@ -349,8 +349,9 @@ l0_%=:							\
 }
 
 /*
- * Test that sync_linked_regs() checks reg->id (the linked target register)
- * for BPF_ADD_CONST32 rather than known_reg->id (the branch register).
+ * Test that sync_linked_regs() consults reg->flags (the linked target
+ * register) for BPF_FLAG_ADD_CONST32, not just known_reg->flags (the branch
+ * register): the gate is (reg->flags | known_reg->flags).
  */
 SEC("socket")
 __success
@@ -360,7 +361,7 @@ __naked void scalars_alu32_zext_linked_reg(void)
 	call %[bpf_get_prandom_u32];				\
 	w6 = w0;		/* r6 in [0, 0xFFFFFFFF] */	\
 	r7 = r6;		/* linked: same id as r6 */	\
-	w7 += 1;		/* alu32: r7.id |= BPF_ADD_CONST32 */ \
+	w7 += 1;		/* alu32: r7.flags |= BPF_FLAG_ADD_CONST32 */ \
 	r8 = 0xFFFFffff ll;					\
 	if r6 < r8 goto l0_%=;					\
 	/* r6 in [0xFFFFFFFF, 0xFFFFFFFF] */			\
@@ -381,7 +382,7 @@ l0_%=:								\
 
 /*
  * Test that sync_linked_regs() skips propagation when one register used
- * alu32 (BPF_ADD_CONST32) and the other used alu64 (BPF_ADD_CONST64).
+ * alu32 (BPF_FLAG_ADD_CONST32) and the other used alu64 (BPF_FLAG_ADD_CONST64).
  * The delta relationship doesn't hold across different ALU widths.
  */
 SEC("socket")
@@ -392,9 +393,9 @@ __naked void scalars_alu32_alu64_cross_type(void)
 	call %[bpf_get_prandom_u32];				\
 	w6 = w0;		/* r6 in [0, 0xFFFFFFFF] */	\
 	r7 = r6;		/* linked: same id as r6 */	\
-	w7 += 1;		/* alu32: BPF_ADD_CONST32, delta = 1 */ \
+	w7 += 1;		/* alu32: BPF_FLAG_ADD_CONST32, delta = 1 */ \
 	r8 = r6;		/* linked: same id as r6 */	\
-	r8 += 2;		/* alu64: BPF_ADD_CONST64, delta = 2 */ \
+	r8 += 2;		/* alu64: BPF_FLAG_ADD_CONST64, delta = 2 */ \
 	r9 = 0xFFFFffff ll;					\
 	if r7 < r9 goto l0_%=;					\
 	/* r7 = 0xFFFFFFFF */					\
@@ -416,7 +417,7 @@ l0_%=:								\
 /*
  * Test that regsafe() prevents pruning when two paths reach the same program
  * point with linked registers carrying different ADD_CONST flags (one
- * BPF_ADD_CONST32 from alu32, another BPF_ADD_CONST64 from alu64).
+ * BPF_FLAG_ADD_CONST32 from alu32, another BPF_FLAG_ADD_CONST64 from alu64).
  */
 SEC("socket")
 __failure __msg("div by zero")
@@ -431,11 +432,11 @@ __naked void scalars_alu32_alu64_regsafe_pruning(void)
 	call %[bpf_get_prandom_u32];				\
 	if r0 > 0 goto l_pathb_%=;				\
 	/* Path A: alu32 */					\
-	w7 += 1;		/* BPF_ADD_CONST32, delta = 1 */\
+	w7 += 1;		/* BPF_FLAG_ADD_CONST32, delta = 1 */\
 	goto l_merge_%=;					\
 l_pathb_%=:							\
 	/* Path B: alu64 */					\
-	r7 += 1;		/* BPF_ADD_CONST64, delta = 1 */\
+	r7 += 1;		/* BPF_FLAG_ADD_CONST64, delta = 1 */\
 l_merge_%=:							\
 	/* Merge point: regsafe() compares path B against cached path A. */ \
 	/* Narrow r6 to trigger sync_linked_regs for r7 */	\
@@ -593,7 +594,7 @@ l_exit_%=:							\
 }
 
 /*
- * Test that stale delta from a cleared BPF_ADD_CONST does not leak
+ * Test that stale delta from a cleared BPF_FLAG_ADD_CONST does not leak
  * through assign_scalar_id_before_mov() into a new id, causing
  * sync_linked_regs() to compute an incorrect offset.
  */
@@ -648,7 +649,7 @@ l_exit_%=:							\
 }
 
 /*
- * Test that regsafe() verifies base_id consistency for BPF_ADD_CONST
+ * Test that regsafe() verifies base_id consistency for BPF_FLAG_ADD_CONST
  * linked scalars during state pruning.
  *
  * The false branch (explored first) links R3 to R2 via ADD_CONST.
-- 
2.53.0-Meta

