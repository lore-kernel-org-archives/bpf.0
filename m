Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792513180;
	b=bK1MxamE6qJZ9vkWc9t2+EK78ENN3Zo8Gp5DE2zFQczH5XMfYiLZvG5AY8yrwNNnrtLF
	 nYFVfbKu3AaGJH6O1Uzzjp2KRneBlsP35xHFSeD9GKWKqJTKNtyuWvYo9azPurE6PGf9P
	 aM8Yr0lpoiIBqq6kmcNyUUbAZSaUmX+du++H4ZcR/iSDpQ6Zq91mSdElLEi/zUeW4ezoL
	 dMvZL8L1uS13zT1oG14TjjjQrV0pN2HJApv67khodwsAz98t7AbTH4aDH0ov1DFSfeWRB
	 1FslCogqtltOh9I/uRuy+6RaiiH2nB3JalLftjK9DsctDBCUzRcbiH25s2I8r2v0juw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792513180;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=xOuUjih6X2TIb+lUDciXQxtLjErXb4T/m+4E2M3NG08=;
	b=jzNQGmNv/i+qV4DdLWdBtn0Jr06azpQJMVIHvMu7e63InQPbAgX2HnL/+XVWSXI7hmOk
	 O1UfPRYGTmryVynyZIw4K/xZJEI0gEAUamLAXEzvVOO4SkL2PwWeILdVTTzYkkMo2bMTo
	 9WiWoOc+i8e3atJIRfZZjEvTf5W9HVdasCmIYxN0Dpl4I8joBNgM10Nm5jEbqxgZjH3N+
	 Kpuhgr5h8Y5/OYERsAeFOSN/tn1m/mrLh5KOFKQFtAb/nMTxBfs7H1ZOuAPrdvWlPi2wV
	 +H1aTXYzvcBgCTwQgrZSNp/9Qg99t/1SQhtUEum27EK5pnApkXh2PqNHKn50DnbG1IQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=HEFbugmg;
	arc=none smtp.remote-ip=91.218.175.173
Received: from mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1429360A2620
	for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 16:19:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1429360A2620
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=HEFbugmg
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=DWmeemuCL66ayAqA3cbferSWYhEnEa7Zx7Qcunqx9fM=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792513177; v=1; x=1793117977;
 b=HEFbugmg5ajdyQBnjTxvt5xQoPHWNhi5dfy7aIavQrtgGgLktFgUsibkrA3wxx0dOmOb0d9u
 hEZuDU3qzOz2ll0RJnIc5MsBWr+0iMSBdyNhhpuHkod2euJsRyUTT+A5WI2MeGiWJOhg+00LcIC
 mAEqAiq53nmJgRUz1W2cIewE=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id e2e9066ebccbf743;
	Tue, 20 Oct 2026 16:19:37 +0000
X-Mizu-Trace-ID: e2e9066ebccbf743
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
Subject: [PATCH bpf-next v3 03/12] bpf: Prepare linked scalars for relations narrower than 64 bits
Date: Tue, 20 Oct 2026 09:18:58 -0700
Message-ID: <20261020161907.2115379-4-vineet.gupta@linux.dev>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261020161907.2115379-1-vineet.gupta@linux.dev>
References: <20261020161907.2115379-1-vineet.gupta@linux.dev>
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

Two scalars sharing an ->id are always related by full 64-bit equality
today: reg == base + delta over all 64 bits (this is true for
BPF_ADD_CONST32 as well, which implies upper bits to be all zero).
Sign-extension needs a genuinely low32 equal only relationship kind
with bit 31 supplying upper 32-bits.

Today the following 2 relationships exist

  #define BPF_ADD_CONST64 (1U << 31)
  #define BPF_ADD_CONST32 (1U << 30)

Model them differently as

  enum bpf_reg_link_kind { BPF_REG_LINK_NONE, BPF_REG_LINK_FULL,
                           BPF_REG_LINK_ZEXT, BPF_REG_LINK_SEXT };

So BPF_ADD_CONST64 becomes BPF_REG_LINK_FULL and BPF_ADD_CONST32 becomes
BPF_REG_LINK_ZEXT with the exact same semantics as today. But this paves
the way for a future BPF_REG_LINK_SEXT in the same framework.

The implementation needs to change as well. Today the above 2 bits are
shoe-horned into ->id, needing masking and OR'ing to get ->id and kind
bits: with more types and bits needed, move them out into an enum
bitfield of its own. To avoid growing the storage (and stay within the
1K allocator bucket), borrow 2 bits out of ->map_uid, 31 -> 29, which is
still far more ids than a program can generate.

->id becomes a plain identifier, so check_scalar_ids() loses its "compare
the compound id, then the base id" dance in favour of one check_ids().

With the kind out of ->id it also leaves the idmap key, so regs_exact()
and regsafe()'s explore_alu_limits arm have to compare it explicitly.

One case changes behaviour -- old {r2.id=A+delta32} against
cur {r2.id=B+delta64} was accepted and is now rejected, correctly, since
alu32 and alu64 deltas diverge in sync_linked_regs().

Clearing a link is no longer just ->id = 0: any stale ->link_kind needs
to be cleared out as well. And given this needs to be done in the newly
added kernel/bpf/scev.c, it is moved into bpf_verifier.h as
bpf_clear_scalar_id().

The helper also zeroes ->delta, which the open-coded clear left behind.
Unlike ->id that field is inside the memcmp() prefix state comparison
uses, so a leftover value could keep two otherwise-identical states
apart; clearing it can only help pruning.

Suggested-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Vineet Gupta <vineet.gupta@linux.dev>
---
v3: was v2 1/13, with v2 2/13 folded in (Alexei: squash the [NFC] patch
into the one that needs it).
 - [NFC] dropped from the subject. It is not: check_ids() pairs ids
   rather than comparing them, so moving the kind out of ->id changes
   which states match. The message works through the one case.
 - new encoding, following Eduard's framing: enum bpf_reg_link_kind,
   with NONE/FULL/ZEXT/SEXT in the two bits add_const already had,
   replacing v2's add_const plus a separate subreg_sext bool.
   bpf_reg_state stays 80 bytes.
 - clear_scalar_id() exported as bpf_clear_scalar_id() for scev.c, which
   was the last site clearing a scalar ->id by hand.
 - regsafe()'s explore_alu_limits arm goes back to open-coding memcmp +
   check_scalar_ids(); v2's switch to regs_exact() had quietly changed
   which comparison that path used.

 include/linux/bpf_verifier.h                  | 50 ++++++++++++---
 kernel/bpf/log.c                              |  4 +-
 kernel/bpf/scev.c                             |  2 +-
 kernel/bpf/states.c                           | 38 ++++--------
 kernel/bpf/verifier.c                         | 62 +++++++++----------
 .../bpf/progs/verifier_linked_scalars.c       | 44 ++++++-------
 6 files changed, 108 insertions(+), 92 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 112ca1511da4..bb369b320334 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -50,6 +50,27 @@ enum bpf_iter_state {
 	BPF_ITER_STATE_DRAINED,
 };
 
+/*
+ * Records how a register derives from the base of its ->id set. The kind
+ * says which bits are shared and how the rest are filled; ->delta says by
+ * how much, and is meaningful for every kind:
+ *
+ *   BPF_REG_LINK_FULL:  reg == base + delta
+ *   BPF_REG_LINK_ZEXT:  reg == (u32)(base + delta), base known to fit u32
+ *   BPF_REG_LINK_SEXT:  reg == (s32)(base + delta)
+ *
+ *   r1 = r2;       r1 and r3 are linked to r2: id == N
+ *   r3 = r2;
+ *   r1 += 10;      r1 gets BPF_REG_LINK_FULL, delta 10
+ *   w3 += 10;      w3 gets BPF_REG_LINK_ZEXT, delta 10
+ */
+enum bpf_reg_link_kind {
+	BPF_REG_LINK_NONE = 0,
+	BPF_REG_LINK_FULL,		/* all 64 bits shared */
+	BPF_REG_LINK_ZEXT,		/* low 32 shared, high half zero */
+	BPF_REG_LINK_SEXT,		/* low 32 shared, high half repeats bit 31 */
+};
+
 struct bpf_reg_state {
 	/* Ordering of fields matters.  See states_equal() */
 	enum bpf_reg_type type;
@@ -160,16 +181,9 @@ struct bpf_reg_state {
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
@@ -184,11 +198,29 @@ struct bpf_reg_state {
 	 * other registers. Kept outside the metadata union for ID remapping
 	 * during state comparisons.
 	 */
-	u32 map_uid:31;
+	u32 map_uid:29;
 	/* if (!precise && SCALAR_VALUE) min/max/tnum don't affect safety */
 	u32 precise:1;
+	/*
+	 * How this register relates to the others sharing its ->id.
+	 * Non-zero only if ->id is. Shares the word above so that
+	 * bpf_reg_state stays 80 bytes.
+	 */
+	enum bpf_reg_link_kind link_kind:2;
 };
 
+/*
+ * Drop a scalar out of its ->id set. ->link_kind and ->delta are only
+ * meaningful next to an ->id, so all three have to go together; this is the
+ * only correct way to clear them.
+ */
+static inline void bpf_clear_scalar_id(struct bpf_reg_state *reg)
+{
+	reg->id = 0;
+	reg->delta = 0;
+	reg->link_kind = BPF_REG_LINK_NONE;
+}
+
 static inline s64 reg_smin(const struct bpf_reg_state *reg)
 {
 	return cnum64_smin(reg->r64);
diff --git a/kernel/bpf/log.c b/kernel/bpf/log.c
index 5432c0fc442b..a6f205653a9e 100644
--- a/kernel/bpf/log.c
+++ b/kernel/bpf/log.c
@@ -651,8 +651,8 @@ static void print_reg_state(struct bpf_verifier_env *env,
 		verbose(env, "%s", btf_type_name(reg->btf, reg->btf_id));
 	verbose(env, "(");
 	if (reg->id)
-		verbose_a("id=%d", reg->id & ~BPF_ADD_CONST);
-	if (reg->id & BPF_ADD_CONST)
+		verbose_a("id=%d", reg->id);
+	if (reg->link_kind)
 		verbose(env, "%+d", reg->delta);
 	if (reg->parent_id)
 		verbose_a("parent_id=%d", reg->parent_id);
diff --git a/kernel/bpf/scev.c b/kernel/bpf/scev.c
index 48500d73105a..f0aa314233c8 100644
--- a/kernel/bpf/scev.c
+++ b/kernel/bpf/scev.c
@@ -2285,7 +2285,7 @@ static void scratch_widened_reg_id(struct bpf_verifier_env *env, struct bpf_reg_
 {
 	switch (base_type(reg->type)) {
 	case SCALAR_VALUE:
-		reg->id = 0;
+		bpf_clear_scalar_id(reg);
 		break;
 	case PTR_TO_PACKET:
 	case PTR_TO_PACKET_META:
diff --git a/kernel/bpf/states.c b/kernel/bpf/states.c
index 953700822fa7..a1b90a31747a 100644
--- a/kernel/bpf/states.c
+++ b/kernel/bpf/states.c
@@ -391,13 +391,6 @@ static bool check_ids(u32 old_id, u32 cur_id, struct bpf_idmap *idmap)
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
@@ -406,15 +399,7 @@ static bool check_scalar_ids(u32 old_id, u32 cur_id, struct bpf_idmap *idmap)
 
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
@@ -512,6 +497,7 @@ static bool regs_exact(const struct bpf_reg_state *rold,
 		       struct bpf_idmap *idmap)
 {
 	return memcmp(rold, rcur, offsetof(struct bpf_reg_state, id)) == 0 &&
+	       rold->link_kind == rcur->link_kind &&
 	       check_ids(rold->id, rcur->id, idmap) &&
 	       check_ids(rold->parent_id, rcur->parent_id, idmap) &&
 	       check_ids(rold->map_uid, rcur->map_uid, idmap);
@@ -566,6 +552,7 @@ static bool regsafe(struct bpf_verifier_env *env, struct bpf_reg_state *rold,
 			 * logic and requires everything to be strict
 			 */
 			return memcmp(rold, rcur, offsetof(struct bpf_reg_state, id)) == 0 &&
+			       rold->link_kind == rcur->link_kind &&
 			       check_scalar_ids(rold->id, rcur->id, idmap);
 		}
 		if (!rold->precise && exact == NOT_EXACT)
@@ -574,13 +561,14 @@ static bool regsafe(struct bpf_verifier_env *env, struct bpf_reg_state *rold,
 		 * Linked register tracking uses rold->id to detect relationships.
 		 * When rold->id == 0, the register is independent and any linking
 		 * in rcur only adds constraints. When rold->id != 0, we must verify
-		 * id mapping and (for BPF_ADD_CONST) offset consistency.
+		 * id mapping and that the link kinds agree, along with any delta
+		 * they carry.
 		 *
 		 * +------------------+-----------+------------------+---------------+
-		 * |                  | rold->id  | rold + ADD_CONST | rold->id == 0 |
+		 * |                  | rold->id  | rold linked kind | rold->id == 0 |
 		 * |------------------+-----------+------------------+---------------|
 		 * | rcur->id         | range,ids | false            | range         |
-		 * | rcur + ADD_CONST | false     | range,ids,off    | range         |
+		 * | rcur linked kind | false     | range,ids,delta  | range         |
 		 * | rcur->id == 0    | range,ids | false            | range         |
 		 * +------------------+-----------+------------------+---------------+
 		 *
@@ -610,17 +598,15 @@ static bool regsafe(struct bpf_verifier_env *env, struct bpf_reg_state *rold,
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
+		if (rold->id && rold->link_kind != rcur->link_kind)
 			return false;
 
 		/* Both have offset linkage: offsets must match */
-		if ((rold->id & BPF_ADD_CONST) && rold->delta != rcur->delta)
+		if (rold->link_kind && rold->delta != rcur->delta)
 			return false;
 
 		if (!check_scalar_ids(rold->id, rcur->id, idmap))
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index e1b41975a442..609342940d1a 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -2060,6 +2060,7 @@ static void __mark_reg_known(struct bpf_reg_state *reg, u64 imm)
 	reg->id = 0;
 	reg->parent_id = 0;
 	reg->map_uid = 0;
+	reg->link_kind = BPF_REG_LINK_NONE;
 	___mark_reg_known(reg, imm);
 }
 
@@ -3752,12 +3753,6 @@ static bool __is_pointer_value(bool allow_ptr_leaks,
 	return is_pointer_regtype(reg->type);
 }
 
-static void clear_scalar_id(struct bpf_reg_state *reg)
-{
-	reg->id = 0;
-	reg->delta = 0;
-}
-
 static void assign_scalar_id_before_mov(struct bpf_verifier_env *env,
 					struct bpf_reg_state *src_reg)
 {
@@ -3768,8 +3763,8 @@ static void assign_scalar_id_before_mov(struct bpf_verifier_env *env,
 	 * rY->id has special linked register already.
 	 * Cleared it, since multiple rX += const are not supported.
 	 */
-	if (src_reg->id & BPF_ADD_CONST)
-		clear_scalar_id(src_reg);
+	if (src_reg->link_kind)
+		bpf_clear_scalar_id(src_reg);
 	/*
 	 * Ensure that src_reg has a valid ID that will be copied to
 	 * dst_reg and then will be used by sync_linked_regs() to
@@ -3921,7 +3916,7 @@ static int check_stack_write_fixed_off(struct bpf_verifier_env *env,
 		save_register_state(env, state, spi, reg, size);
 		/* Break the relation on a narrowing spill. */
 		if (!reg_value_fits)
-			clear_scalar_id(&ss->spilled_ptr);
+			bpf_clear_scalar_id(&ss->spilled_ptr);
 	} else if (!reg && !(off % BPF_REG_SIZE) && is_bpf_st_mem(insn) &&
 		   env->bpf_capable) {
 		struct bpf_reg_state *tmp_reg = &env->fake_reg[0];
@@ -4278,7 +4273,7 @@ static int check_stack_read_fixed_off(struct bpf_verifier_env *env,
 				 * coerce_reg_to_size will adjust the boundaries.
 				 */
 				if (get_reg_width(reg) > size * BITS_PER_BYTE)
-					clear_scalar_id(&state->regs[dst_regno]);
+					bpf_clear_scalar_id(&state->regs[dst_regno]);
 			} else {
 				int spill_cnt = 0, zero_cnt = 0;
 
@@ -7385,7 +7380,7 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, struct b
 
 			coerce_reg_to_size_sx(&regs[value_regno], size);
 			if (!no_sext)
-				clear_scalar_id(&regs[value_regno]);
+				bpf_clear_scalar_id(&regs[value_regno]);
 		}
 	}
 
@@ -16894,7 +16889,7 @@ static void scalar_byte_swap(struct bpf_reg_state *dst_reg, struct bpf_insn *ins
 	 * any existing ties and avoid incorrect bounds propagation.
 	 */
 	if (need_bswap || insn->imm == 16 || insn->imm == 32)
-		clear_scalar_id(dst_reg);
+		bpf_clear_scalar_id(dst_reg);
 
 	if (need_bswap) {
 		if (insn->imm == 16)
@@ -17333,18 +17328,18 @@ static int adjust_reg_min_max_vals(struct bpf_verifier_env *env,
 			off = -off;
 		}
 
-		if (dst_reg->id & BPF_ADD_CONST) {
+		if (dst_reg->link_kind) {
 			/*
 			 * If the register already went through rX += val
 			 * we cannot accumulate another val into rx->off.
 			 */
 clear_id:
-			clear_scalar_id(dst_reg);
+			bpf_clear_scalar_id(dst_reg);
 		} else {
 			if (alu32)
-				dst_reg->id |= BPF_ADD_CONST32;
+				dst_reg->link_kind = BPF_REG_LINK_ZEXT;
 			else
-				dst_reg->id |= BPF_ADD_CONST64;
+				dst_reg->link_kind = BPF_REG_LINK_FULL;
 			dst_reg->delta = off;
 		}
 	} else {
@@ -17352,7 +17347,7 @@ static int adjust_reg_min_max_vals(struct bpf_verifier_env *env,
 		 * Make sure ID is cleared otherwise dst_reg min/max could be
 		 * incorrectly propagated into other registers by sync_linked_regs()
 		 */
-		clear_scalar_id(dst_reg);
+		bpf_clear_scalar_id(dst_reg);
 	}
 	return 0;
 }
@@ -17548,7 +17543,7 @@ static int check_alu_op(struct bpf_verifier_env *env, struct bpf_insn *insn)
 							assign_scalar_id_before_mov(env, src_reg);
 						*dst_reg = *src_reg;
 						if (!no_sext)
-							clear_scalar_id(dst_reg);
+							bpf_clear_scalar_id(dst_reg);
 						coerce_reg_to_size_sx(dst_reg, insn->off >> 3);
 					} else {
 						mark_reg_unknown(env, regs, insn->dst_reg);
@@ -17573,7 +17568,7 @@ static int check_alu_op(struct bpf_verifier_env *env, struct bpf_insn *insn)
 						 * propagated into src_reg by sync_linked_regs()
 						 */
 						if (!is_src_reg_u32)
-							clear_scalar_id(dst_reg);
+							bpf_clear_scalar_id(dst_reg);
 					} else {
 						/* case: W1 = (s8, s16)W2 */
 						bool no_sext = reg_umax(src_reg) < (1ULL << (insn->off - 1));
@@ -17582,7 +17577,7 @@ static int check_alu_op(struct bpf_verifier_env *env, struct bpf_insn *insn)
 							assign_scalar_id_before_mov(env, src_reg);
 						*dst_reg = *src_reg;
 						if (!no_sext)
-							clear_scalar_id(dst_reg);
+							bpf_clear_scalar_id(dst_reg);
 						coerce_subreg_to_size_sx(dst_reg, insn->off >> 3);
 					}
 				} else {
@@ -18388,7 +18383,7 @@ static void __collect_linked_regs(struct linked_regs *reg_set, struct bpf_reg_st
 {
 	struct linked_reg *e;
 
-	if (reg->type != SCALAR_VALUE || (reg->id & ~BPF_ADD_CONST) != id)
+	if (reg->type != SCALAR_VALUE || reg->id != id)
 		return;
 
 	e = linked_regs_push(reg_set);
@@ -18397,7 +18392,7 @@ static void __collect_linked_regs(struct linked_regs *reg_set, struct bpf_reg_st
 		e->is_reg = is_reg;
 		e->regno = spi_or_reg;
 	} else {
-		clear_scalar_id(reg);
+		bpf_clear_scalar_id(reg);
 	}
 }
 
@@ -18416,7 +18411,6 @@ static void collect_linked_regs(struct bpf_verifier_env *env,
 	u16 live_regs;
 	int i, j;
 
-	id = id & ~BPF_ADD_CONST;
 	for (i = vstate->curframe; i >= 0; i--) {
 		live_regs = aux[bpf_frame_insn_idx(vstate, i)].live_regs_before;
 		func = vstate->frame[i];
@@ -18454,18 +18448,20 @@ static void sync_linked_regs(struct bpf_verifier_env *env, struct bpf_verifier_s
 				: &bpf_stack_slot(vstate->frame[e->frameno], e->spi)->spilled_ptr;
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
+		if (reg->link_kind && known_reg->link_kind &&
+		    reg->link_kind != known_reg->link_kind)
 			continue;
-		if ((!(reg->id & BPF_ADD_CONST) && !(known_reg->id & BPF_ADD_CONST)) ||
+		if ((!reg->link_kind && !known_reg->link_kind) ||
 		    reg->delta == known_reg->delta) {
 			*reg = *known_reg;
 		} else {
+			enum bpf_reg_link_kind saved_link_kind = reg->link_kind;
 			s32 saved_off = reg->delta;
 			u32 saved_id = reg->id;
 
@@ -18475,17 +18471,19 @@ static void sync_linked_regs(struct bpf_verifier_env *env, struct bpf_verifier_s
 			/* reg = known_reg; reg += delta */
 			*reg = *known_reg;
 			/*
-			 * Must preserve off and id, otherwise another sync_linked_regs()
-			 * will be incorrect.
+			 * Must preserve off, id and link_kind, otherwise another
+			 * sync_linked_regs() will be incorrect.
 			 */
 			reg->delta = saved_off;
 			reg->id = saved_id;
+			reg->link_kind = saved_link_kind;
 
 			scalar_step_add(reg, reg, &fake_reg);
 			scalar32_min_max_add(reg, &fake_reg);
 			scalar_min_max_add(reg, &fake_reg);
 			reg->var_off = tnum_add(reg->var_off, fake_reg.var_off);
-			if ((reg->id | known_reg->id) & BPF_ADD_CONST32)
+			if (reg->link_kind == BPF_REG_LINK_ZEXT ||
+			    known_reg->link_kind == BPF_REG_LINK_ZEXT)
 				zext_32_to_64(reg);
 			reg_bounds_sync(reg);
 		}
@@ -19582,7 +19580,7 @@ void bpf_clear_singular_ids(struct bpf_verifier_env *env,
 			continue;
 		if (!reg->id)
 			continue;
-		idset_cnt_inc(idset, reg->id & ~BPF_ADD_CONST);
+		idset_cnt_inc(idset, reg->id);
 	}));
 
 	bpf_for_each_reg_in_vstate(st, func, reg, ({
@@ -19590,8 +19588,8 @@ void bpf_clear_singular_ids(struct bpf_verifier_env *env,
 			continue;
 		if (!reg->id)
 			continue;
-		if (idset_cnt_get(idset, reg->id & ~BPF_ADD_CONST) == 1)
-			clear_scalar_id(reg);
+		if (idset_cnt_get(idset, reg->id) == 1)
+			bpf_clear_scalar_id(reg);
 	}));
 }
 
diff --git a/tools/testing/selftests/bpf/progs/verifier_linked_scalars.c b/tools/testing/selftests/bpf/progs/verifier_linked_scalars.c
index d571fbfc86a3..5a120fc7c1e7 100644
--- a/tools/testing/selftests/bpf/progs/verifier_linked_scalars.c
+++ b/tools/testing/selftests/bpf/progs/verifier_linked_scalars.c
@@ -349,8 +349,8 @@ l0_%=:							\
 }
 
 /*
- * Test that sync_linked_regs() checks reg->id (the linked target register)
- * for BPF_ADD_CONST32 rather than known_reg->id (the branch register).
+ * Test that sync_linked_regs() checks the linked target register (reg) for
+ * BPF_REG_LINK_ZEXT rather than the branch register (known_reg).
  */
 SEC("socket")
 __success
@@ -360,7 +360,7 @@ __naked void scalars_alu32_zext_linked_reg(void)
 	call %[bpf_get_prandom_u32];				\
 	w6 = w0;		/* r6 in [0, 0xFFFFFFFF] */	\
 	r7 = r6;		/* linked: same id as r6 */	\
-	w7 += 1;		/* alu32: r7.id |= BPF_ADD_CONST32 */ \
+	w7 += 1;		/* BPF_REG_LINK_ZEXT delta */ \
 	r8 = 0xFFFFffff ll;					\
 	if r6 < r8 goto l0_%=;					\
 	/* r6 in [0xFFFFFFFF, 0xFFFFFFFF] */			\
@@ -381,7 +381,7 @@ l0_%=:								\
 
 /*
  * Test that sync_linked_regs() skips propagation when one register used
- * alu32 (BPF_ADD_CONST32) and the other used alu64 (BPF_ADD_CONST64).
+ * alu32 (BPF_REG_LINK_ZEXT) and the other used alu64 (BPF_REG_LINK_FULL).
  * The delta relationship doesn't hold across different ALU widths.
  */
 SEC("socket")
@@ -392,13 +392,13 @@ __naked void scalars_alu32_alu64_cross_type(void)
 	call %[bpf_get_prandom_u32];				\
 	w6 = w0;		/* r6 in [0, 0xFFFFFFFF] */	\
 	r7 = r6;		/* linked: same id as r6 */	\
-	w7 += 1;		/* alu32: BPF_ADD_CONST32, delta = 1 */ \
+	w7 += 1;		/* BPF_REG_LINK_ZEXT delta */ \
 	r8 = r6;		/* linked: same id as r6 */	\
-	r8 += 2;		/* alu64: BPF_ADD_CONST64, delta = 2 */ \
+	r8 += 2;		/* BPF_REG_LINK_FULL delta */ \
 	r9 = 0xFFFFffff ll;					\
 	if r7 < r9 goto l0_%=;					\
 	/* r7 = 0xFFFFFFFF */					\
-	/* sync: known_reg=r7 (ADD_CONST32), reg=r8 (ADD_CONST64) */ \
+	/* sync: known_reg=r7 (BPF_REG_LINK_ZEXT), reg=r8 (BPF_REG_LINK_FULL) */ \
 	/* Without fix: r8 = zext(0xFFFFFFFF + 1) = 0 */	\
 	/* With fix: r8 stays [2, 0x100000001] (r8 >= 2) */	\
 	if r8 > 0 goto l1_%=;					\
@@ -416,7 +416,7 @@ l0_%=:								\
 /*
  * Test that regsafe() prevents pruning when two paths reach the same program
  * point with linked registers carrying different ADD_CONST flags (one
- * BPF_ADD_CONST32 from alu32, another BPF_ADD_CONST64 from alu64).
+ * BPF_REG_LINK_ZEXT from alu32, another BPF_REG_LINK_FULL from alu64).
  */
 SEC("socket")
 __failure __msg("div by zero")
@@ -431,11 +431,11 @@ __naked void scalars_alu32_alu64_regsafe_pruning(void)
 	call %[bpf_get_prandom_u32];				\
 	if r0 > 0 goto l_pathb_%=;				\
 	/* Path A: alu32 */					\
-	w7 += 1;		/* BPF_ADD_CONST32, delta = 1 */\
+	w7 += 1;		/* BPF_REG_LINK_ZEXT delta */\
 	goto l_merge_%=;					\
 l_pathb_%=:							\
 	/* Path B: alu64 */					\
-	r7 += 1;		/* BPF_ADD_CONST64, delta = 1 */\
+	r7 += 1;		/* BPF_REG_LINK_FULL delta */\
 l_merge_%=:							\
 	/* Merge point: regsafe() compares path B against cached path A. */ \
 	/* Narrow r6 to trigger sync_linked_regs for r7 */	\
@@ -593,7 +593,7 @@ l_exit_%=:							\
 }
 
 /*
- * Test that stale delta from a cleared BPF_ADD_CONST does not leak
+ * Test that a stale delta from a cleared link does not leak
  * through assign_scalar_id_before_mov() into a new id, causing
  * sync_linked_regs() to compute an incorrect offset.
  */
@@ -605,10 +605,10 @@ __naked void scalars_stale_delta_from_cleared_id(void)
 	asm volatile ("						\
 	call %[bpf_get_prandom_u32];				\
 	r6 = r0;		/* r6 unknown, gets id A */	\
-	r6 += 5;		/* id A|ADD_CONST, delta 5 */	\
+	r6 += 5;		/* id A, BPF_REG_LINK_FULL delta */	\
 	r6 ^= 0;		/* id cleared; delta stays 5 */	\
 	r8 = r6;		/* new id B, stale delta 5 */	\
-	r8 += 3;		/* id B|ADD_CONST, delta 3 */	\
+	r8 += 3;		/* id B, BPF_REG_LINK_FULL delta */	\
 	r9 = r6;		/* id B, stale delta 5 */	\
 	if r9 != 10 goto l_exit_%=;				\
 	/* Bug: r8 = 10+(3-5) = 8; Fix: r8 = 10+(3-0) = 13 */	\
@@ -648,19 +648,19 @@ l_exit_%=:							\
 }
 
 /*
- * Test that regsafe() verifies base_id consistency for BPF_ADD_CONST
- * linked scalars during state pruning.
+ * Test that regsafe() verifies id consistency for linked scalars
+ * during state pruning.
  *
- * The false branch (explored first) links R3 to R2 via ADD_CONST.
- * The true branch (runtime path) links R3 to R4 (unrelated base_id).
+ * The false branch (explored first) links R3 to R2 via BPF_REG_LINK_FULL.
+ * The true branch (runtime path) links R3 to R4 (unrelated id).
  * At the merge point, pruning must fail because the linkage topology
  * differs.
  */
 SEC("socket")
-__description("linked scalars: add_const base_id must be consistent for pruning")
+__description("linked scalars: add_const id must be consistent for pruning")
 __failure __msg("invalid variable-offset")
 __flag(BPF_F_TEST_STATE_FREQ)
-__naked void add_const_base_id_pruning(void)
+__naked void add_const_id_pruning(void)
 {
 	asm volatile ("						\
 	r1 = 0;							\
@@ -675,7 +675,7 @@ __naked void add_const_base_id_pruning(void)
 	r2 = r0;						\
 	r2 &= 0xff;		/* R2 = scalar(id=A) [0,255] */	\
 	r3 = r2;		/* R3 linked to R2 (id=A) */	\
-	r3 += 10;		/* R3 id=A|ADD_CONST, delta=10 */\
+	r3 += 10;		/* BPF_REG_LINK_FULL delta */\
 	r6 = 0;							\
 	goto l_merge_%=;					\
 								\
@@ -687,12 +687,12 @@ l_true_%=:							\
 	r4 = r0;						\
 	r4 &= 0xff;		/* R4 = scalar [0,255], id=0 */	\
 	r3 = r4;		/* R3 linked to R4 (new id=C) */\
-	r3 += 10;		/* R3 id=C|ADD_CONST, delta=10 */\
+	r3 += 10;		/* BPF_REG_LINK_FULL delta */\
 	r6 = 0;							\
 								\
 l_merge_%=:							\
 	/* At merge, old R3 linked to R2, cur R3 linked to R4. */\
-	/* Pruning must fail: base_ids A vs C inconsistent. */	\
+	/* Pruning must fail: ids A vs C inconsistent. */	\
 	if r2 >= 6 goto l_exit_%=;				\
 	/* sync_linked_regs: R2<6 => R3<16 in old state. */	\
 	/* Without fix: R3 in [10,15] from incorrect pruning. */\
-- 
2.53.0-Meta

