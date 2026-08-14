Received: from mta0.migadu.com (out-241.mta0.migadu.com [91.218.175.241])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECCA13E4C66
	for <bpf@vger.kernel.org>; Fri, 14 Aug 2026 23:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.241
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786749628; cv=none; b=AA7NJnq85nJj9pPlAE5WXbbGBSuQCuCgl6suSh0Z2y2RN+D3VhD4nwOqGGtW1QwW1f77je6DGcCipGp8ZClyUEDr7eY+hyQg94Sd/Km1fdXOB12mHZOuDmc/fUef42Z224FIcPehS668irM9FOU5XHyKwsnAcxkqaYyX0HXUoWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786749628; c=relaxed/simple;
	bh=80DXt7oQQEjHjvAcq2i1Z5WDeJWkqq6nBI/XE5ZjR/Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qg/uQy7cytxgj4bdpEd86jr0rKqkxPRzfbTejXe0qTedQZAu5aCIbzpV5U+u2HHj9PBWd6FFaAUGzm/jCgn4ySx0PIKJGAkbAbj6fLaJ4NjZN6jalgLeuTLhqfZ30pXJHwQMl4msiVZbE/L+W8U0dxpaazJlkm68jnu4l7kyyEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Hk3eAfO7; arc=none smtp.client-ip=91.218.175.241
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Hk3eAfO7"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=80DXt7oQQEjHjvAcq2i1Z5WDeJWkqq6nBI/XE5ZjR/Q=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786749617; v=1; x=1787354417;
 b=Hk3eAfO7JNLAIeCN9enLd6caFh7uahkvofNaOgSVESs3JuhgNN8pv6SeIa071wrqBNtn5wZ2
 MxgCdhHl7/OsIXMelAXGToDqCSV3lwAztDpmksSgSNh3fqskr85QU6M89asNIwNz/4lHOnFQndr
 lEVLagJkXQn5pVTYBcskeVeQ=
X-Envelope-To: bpf@vger.kernel.org
Received: from gvineet-fedora-PF5JGVFY.thefacebook.com (2620:10d:c090:500::6:7be4)
	by smtp.migadu.com with ESMTPS id a2b5717daf086a07;
	Fri, 14 Aug 2026 23:20:17 +0000
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
Subject: [RFC bpf-next 5/6] bpf: support low-32 subreg scalar linking for sign-extending movs
Date: Fri, 14 Aug 2026 16:19:44 -0700
Message-ID: <20260814231945.3884596-6-vineet.gupta@linux.dev>
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

This is the sign-extension counterpart to the prior zero-extension movs
change, and the original motivation for the series: bpf-gcc codegen tends to
generate many more sign-extensions than clang, some of which the verifier
already understands and some of which it does not.

A 32-bit sign extension (r0 = (s32)r0) preserves the source's low 32 bits and
sets the high bits to their sign-extension. When the sign bit is not provably
zero the verifier clears the destination's scalar id, so a later narrowing of
the low 32 bits (e.g. "if w1 == 0") never reaches the sign-extended register and
safe programs are rejected.

Three patterns hit this under bpf-gcc, and not under clang, which emits very
few sign extensions even for -mcpu=v4 builds.

1. callback exit-code checks that reject "R0 ... should have been in [0, 1]".

|  0: (61) r2 = *(u32 *)(r1 +24)
|  1: (bf) r0 = (s32)r2
|  2: (56) if w2 != 0x0 goto pc+10       ; R2=0 (branch taken)
| 12: (95) exit

2. the errno-or-zero return, where a value clamped to [-4095, 0] is
   sign-extended again on "return ret" and coerce_reg_to_size_sx() then widens
   it back to [S32_MIN, S32_MAX] (verify_pkcs7_sig and many lsm.s progs)

| 63: (85) call bpf_verify_pkcs7_signature#88154
| ...
| 69: (c5) if r0 s< 0xfffff001 goto pc+1  ; R0=scalar(id=7,smin=smin32=-4095,smax=0x7fffffff)
| 70: (d5) if r0 s<= 0x0 goto pc+1 72:
| 72: (bf) r0 = (s32)r0                   ; R0=scalar(smin=0xffffffff80000000,smax=0x7fffffff)
| 73: (95) exit

3. loops whose induction variable is sign-extended every iteration, which
   without a link never converge: "The sequence of 8193 jumps is too complex".

Solution
========
Reuse the low-32-only link added for zero-extending movs, with a second
flavour flag:
 - for a wide-source 32-bit sign extension, mark dst with BPF_FLAG_SUBREG_SEXT
   so its high bits are known to be the sign-extension of the low field. Only
   32-bit sign extension is tracked -- (s8)/(s16) do not form a link (not seen
   in codegen so far) -- so the flag alone carries the width and no extra field
   is needed.
 - the flag tells sync_linked_regs() how to rebuild the high half:
   reconstruct_sext32() for the sign extension, versus the plain
   zero-extension BPF_FLAG_SUBREG_ZEXT uses.
 - reconstruct_sext32() rebuilds such a register from the base's low 32 bits,
   driven both at the sign-extend site (to keep an already-narrowed range, the
   errno case) and from sync_linked_regs() on a later low-32 narrowing.
 - as with the zero-extend link this applies only when neither side carries an
   ADD_CONST delta (the combined subreg+delta case is not modeled).
 - also as with that link, no link is formed when src itself carries an
   ADD_CONST delta: forming one calls assign_scalar_id_before_mov(), which
   would clear src's base+delta relationship. The zero-extend arm's other
   exclusion, a self-mov, deliberately does NOT carry over -- r0 = (s32)r0 is
   the motivating case here. The no_sext path is unaffected: it already
   called assign_scalar_id_before_mov() before this series, so an ADD_CONST
   src was cleared there already.
 - regsafe() extends its existing low-32 link check to cover both flavours,
   so the two are not pruned across each other:

	if (rold->id &&
	    (rold->flags & BPF_FLAG_SUBREG) != (rcur->flags & BPF_FLAG_SUBREG))

   The rold->id gate comes from the zero-extend patch and carries over
   unchanged. It matters for convergence here: these flags are only ever set
   together with an ->id, so rold->id == 0 implies neither is set, and the
   gate admits exactly "old knows no low-32 relationship, cur does" -- cur is
   then strictly more constrained than old, the safe direction for pruning,
   while the reverse is still rejected. Without it a register that first
   acquires a sext link inside a loop would never match its pre-loop state and
   verification would run to the 1M instruction limit (cond_break*, iters/*,
   verifier_bits_iter/* and the sext_in_loop_converges case added next).

Signed-off-by: Vineet Gupta <vineet.gupta@linux.dev>
---
 include/linux/bpf_verifier.h |   9 ++-
 kernel/bpf/states.c          |  13 ++++-
 kernel/bpf/verifier.c        | 110 +++++++++++++++++++++++++++++++----
 3 files changed, 120 insertions(+), 12 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index a4cba5c5099e..67ef54d70116 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -173,6 +173,10 @@ struct bpf_reg_state {
 	 * full equality implied by a bare shared ->id): this register shares
 	 * only the base's low 32 bits, and its high bits are zero (32-bit
 	 * zero-extending mov).
+	 * BPF_FLAG_SUBREG_SEXT is the same for a 32-bit sign extension
+	 * (r0 = (s32)r0); the two differ in how the high half is rebuilt.
+	 * Only 32-bit sign extension is tracked -- (s8)/(s16) do not form a
+	 * link -- so the flag alone carries the width.
 	 * sync_linked_regs() propagates the low 32-bit subrange and rebuilds
 	 * the high half accordingly, so this is sound even when the base has
 	 * unknown high bits.
@@ -181,8 +185,11 @@ struct bpf_reg_state {
 #define BPF_FLAG_ADD_CONST64	(1U << 1)
 #define BPF_FLAG_ADD_CONST	(BPF_FLAG_ADD_CONST32 | BPF_FLAG_ADD_CONST64)
 #define BPF_FLAG_SUBREG_ZEXT	(1U << 2)
+#define BPF_FLAG_SUBREG_SEXT	(1U << 3)
+/* A low-32-only link, of either flavour. */
+#define BPF_FLAG_SUBREG		(BPF_FLAG_SUBREG_ZEXT | BPF_FLAG_SUBREG_SEXT)
 /* Every flag describing how this register relates to its ->id set. */
-#define BPF_FLAG_LINK		(BPF_FLAG_ADD_CONST | BPF_FLAG_SUBREG_ZEXT)
+#define BPF_FLAG_LINK		(BPF_FLAG_ADD_CONST | BPF_FLAG_SUBREG)
 #define BPF_FLAG_PRECISE	(1U << 7)
 	u8 flags;
 };
diff --git a/kernel/bpf/states.c b/kernel/bpf/states.c
index ef71999c4695..6aaedde6e9d1 100644
--- a/kernel/bpf/states.c
+++ b/kernel/bpf/states.c
@@ -562,6 +562,8 @@ static bool regsafe(struct bpf_verifier_env *env, struct bpf_reg_state *rold,
 		 * semantics than a full/ADD_CONST equality. check_scalar_ids()
 		 * only ever sees the plain ->id and never looks at ->flags, so a
 		 * mismatch must be rejected explicitly.
+		 * The two flavours also differ from each other, in how the high
+		 * half is rebuilt (zero-extension vs reconstruct_sext32()).
 		 * Check it here, before the explore_alu_limits and !precise
 		 * short-circuits below (neither of which tests it). Note the
 		 * pre-existing BPF_FLAG_ADD_CONST check sits after those
@@ -570,9 +572,18 @@ static bool regsafe(struct bpf_verifier_env *env, struct bpf_reg_state *rold,
 		 * on a path that predates this series, which is a pruning change
 		 * that wants measuring on its own; it is deliberately left
 		 * alone here.
+		 *
+		 * Only demand a match when the old state carries a link at all.
+		 * These flags are only ever set together with an ->id, so
+		 * rold->id == 0 implies none is set, and the only case this
+		 * admits is "old knows no low-32 relationship, cur does" -- cur
+		 * is then strictly more constrained than old, which is the safe
+		 * direction for pruning. The reverse is still rejected. Without
+		 * this a register that first acquires a link inside a loop would
+		 * never match its pre-loop state and pruning would not converge.
 		 */
 		if (rold->id &&
-		    (rold->flags & BPF_FLAG_SUBREG_ZEXT) != (rcur->flags & BPF_FLAG_SUBREG_ZEXT))
+		    (rold->flags & BPF_FLAG_SUBREG) != (rcur->flags & BPF_FLAG_SUBREG))
 			return false;
 
 		if (env->explore_alu_limits) {
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 8a802d49d0a4..45cb67dc3999 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -14976,6 +14976,8 @@ static int adjust_reg_min_max_vals(struct bpf_verifier_env *env,
 	return 0;
 }
 
+static void reconstruct_sext32(struct bpf_reg_state *reg, struct bpf_reg_state *src);
+
 /* check validity of 32-bit and 64-bit arithmetic operations */
 static int check_alu_op(struct bpf_verifier_env *env, struct bpf_insn *insn)
 {
@@ -15052,15 +15054,65 @@ static int check_alu_op(struct bpf_verifier_env *env, struct bpf_insn *insn)
 							insn->src_reg);
 						return -EACCES;
 					} else if (src_reg->type == SCALAR_VALUE) {
+						int sz = insn->off >> 3;
 						bool no_sext;
+						bool subreg_link;
 
 						no_sext = reg_umax(src_reg) < (1ULL << (insn->off - 1));
-						if (no_sext)
+						/*
+						 * When no_sext, dst == src exactly, so link them
+						 * (existing behavior). When !no_sext for a 32-bit sign
+						 * extension the low 32 bits are still identical (sext
+						 * preserves them), so form a BPF_FLAG_SUBREG_SEXT
+						 * link: a later narrowing of the low 32 bits
+						 * propagates here, and sync_linked_regs() rebuilds
+						 * the high half via reconstruct_sext32().
+						 *
+						 * An ADD_CONST-linked src is excluded for the same
+						 * reason as in the zero-extending arm below:
+						 * assign_scalar_id_before_mov() would clear its
+						 * base+delta link, and a combined subreg+delta link
+						 * isn't modeled anyway. Unlike that arm a self-mov is
+						 * NOT excluded -- r0 = (s32)r0 is the case this is
+						 * here for.
+						 */
+						subreg_link = (sz == 4) &&
+							      !(src_reg->flags & BPF_FLAG_ADD_CONST);
+
+						if (no_sext || subreg_link)
 							assign_scalar_id_before_mov(env, src_reg);
 						*dst_reg = *src_reg;
-						if (!no_sext)
-							clear_scalar_id(dst_reg);
-						coerce_reg_to_size_sx(dst_reg, insn->off >> 3);
+						if (!no_sext) {
+							if (subreg_link && src_reg->id) {
+								/* ->id already copied above */
+								dst_reg->flags = (dst_reg->flags & ~BPF_FLAG_SUBREG) |
+										 BPF_FLAG_SUBREG_SEXT;
+							} else {
+								clear_scalar_id(dst_reg);
+							}
+						}
+						/*
+						 * coerce_reg_to_size_sx() falls back to the full sext
+						 * range when smin/smax straddle the sign boundary (e.g.
+						 * an errno-or-zero value clamped to [-4095, 0]). For a
+						 * register tracked as the sign-extension of its low 32
+						 * bits the high half IS that sign-extension, so rebuild
+						 * the tighter 64-bit range from the low bounds, taken
+						 * from a snapshot because coerce overwrites them.
+						 *
+						 * Gated on sz == 4, not on the flag alone: an (s8)/(s16)
+						 * mov whose src is already SEXT-linked copies the flag
+						 * across in the *dst_reg = *src_reg above, and a 32-bit
+						 * reconstruction must not run for a narrower operation.
+						 */
+						if (sz == 4 && (dst_reg->flags & BPF_FLAG_SUBREG_SEXT)) {
+							struct bpf_reg_state sext_src = *dst_reg;
+
+							coerce_reg_to_size_sx(dst_reg, sz);
+							reconstruct_sext32(dst_reg, &sext_src);
+						} else {
+							coerce_reg_to_size_sx(dst_reg, sz);
+						}
 					} else {
 						mark_reg_unknown(env, regs, insn->dst_reg);
 					}
@@ -15107,7 +15159,15 @@ static int check_alu_op(struct bpf_verifier_env *env, struct bpf_insn *insn)
 						if (!is_src_reg_u32) {
 							if (wide_subreg_link && src_reg->id) {
 								/* ->id already copied above */
-								dst_reg->flags |= BPF_FLAG_SUBREG_ZEXT;
+								/*
+								 * Zero-extension: high bits are 0, not a
+								 * sign-extension of the low field. Drop any
+								 * SUBREG_SEXT copied from a sext-linked src
+								 * so sync_linked_regs() rebuilds dst by
+								 * zero-extension, not reconstruct_sext32().
+								 */
+								dst_reg->flags = (dst_reg->flags & ~BPF_FLAG_SUBREG) |
+										 BPF_FLAG_SUBREG_ZEXT;
 							} else {
 								clear_scalar_id(dst_reg);
 							}
@@ -15961,6 +16021,32 @@ static void collect_linked_regs(struct bpf_verifier_env *env,
 	}
 }
 
+/*
+ * Set @reg to the sign-extension of the low 32 bits currently held by @src.
+ * A BPF_FLAG_SUBREG_SEXT-linked register came from a 32-bit sign
+ * extension (r0 = (s32)r0): it shares @src's low 32 bits and its high bits are
+ * the sign-extension of that low field. Only the value fields are written;
+ * @reg's linkage fields (id, delta, flags) are left intact by
+ * the caller (___mark_reg_known touches only var_off/r64/r32). Callers must
+ * ensure no ADD_CONST delta is involved (see sync_linked_regs()).
+ */
+static void reconstruct_sext32(struct bpf_reg_state *reg, struct bpf_reg_state *src)
+{
+	s32 s32min = reg_s32_min(src);
+	s32 s32max = reg_s32_max(src);
+
+	if (s32min == s32max) {
+		/* Low 32 bits are constant -> the whole value is the sext constant. */
+		___mark_reg_known(reg, (u64)(s64)s32min);
+	} else {
+		/* Sign-extension is monotonic over the signed-32 range. */
+		reg_set_srange64(reg, (s64)s32min, (s64)s32max);
+		reg_set_srange32(reg, s32min, s32max);
+		reg->var_off = tnum_range((u64)(s64)s32min, (u64)(s64)s32max);
+		reg_bounds_sync(reg);
+	}
+}
+
 /* For all R in linked_regs, copy known_reg range into R
  * if R->id == known_reg->id.
  */
@@ -15984,17 +16070,21 @@ static void sync_linked_regs(struct bpf_verifier_env *env, struct bpf_verifier_s
 		 * A low-32 linked register shares only the base's low 32 bits;
 		 * the flag says how its high bits are derived. For
 		 * BPF_FLAG_SUBREG_ZEXT they are zero (32-bit zero-extending mov).
+		 * For BPF_FLAG_SUBREG_SEXT they are the sign-extension of the low
+		 * field (32-bit sign extension).
 		 * Rebuild it from known_reg's low 32 bits accordingly, but only
 		 * when neither side carries an ADD_CONST delta -- with a delta
 		 * the low bits differ from the base by that delta and the combined
 		 * subreg+ADD_CONST reconstruction isn't modeled here, so leave reg
 		 * unchanged (sound, just less precise).
 		 */
-		if (reg->flags & BPF_FLAG_SUBREG_ZEXT) {
+		if (reg->flags & BPF_FLAG_SUBREG) {
 			if (!((reg->flags | known_reg->flags) & BPF_FLAG_ADD_CONST)) {
-				{
+				if (reg->flags & BPF_FLAG_SUBREG_SEXT) {
+					reconstruct_sext32(reg, known_reg);
+				} else {
 					u32 saved_id = reg->id;
-					u8 saved_subreg = reg->flags & BPF_FLAG_SUBREG_ZEXT;
+					u8 saved_subreg = reg->flags & BPF_FLAG_SUBREG;
 
 					/*
 					 * reg = zext32(known_reg): its low 32 bits come from
@@ -16008,7 +16098,7 @@ static void sync_linked_regs(struct bpf_verifier_env *env, struct bpf_verifier_s
 					 */
 					*reg = *known_reg;
 					reg->id = saved_id;
-					reg->flags = (reg->flags & ~BPF_FLAG_SUBREG_ZEXT) | saved_subreg;
+					reg->flags = (reg->flags & ~BPF_FLAG_SUBREG) | saved_subreg;
 					zext_32_to_64(reg);
 					reg_bounds_sync(reg);
 				}
@@ -16024,7 +16114,7 @@ static void sync_linked_regs(struct bpf_verifier_env *env, struct bpf_verifier_s
 		 * copying known_reg's low-32-only state into a full register would
 		 * be unsound, so leave reg unchanged.
 		 */
-		if (known_reg->flags & BPF_FLAG_SUBREG_ZEXT)
+		if (known_reg->flags & BPF_FLAG_SUBREG)
 			continue;
 		/*
 		 * Skip mixed 32/64-bit links: the delta relationship doesn't
-- 
2.53.0-Meta

