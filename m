Received: from mta0.migadu.com (out-232.mta0.migadu.com [91.218.175.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEBF73E8C78
	for <bpf@vger.kernel.org>; Fri, 14 Aug 2026 23:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786749618; cv=none; b=ufGRiygwCx4ICvAtoluDyWs4snUQgVA4gSFvVJqxbU6EgTY0cu3EG1QAlp1OeJBBOiPHXa5OXKCHbAAV9iFXlT2XU+rKfiJ+Wu/tROvoXDxiRyWbv9123LT2meo++s4TnHDTu9s3ujA3hiOE6DGXlTy1ocCH/CqsoUB7GGvUq/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786749618; c=relaxed/simple;
	bh=32bCd92QrJ5CNFMIriXP22Lyz4CFQtB+v0/Z/V2E8wk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RwkqQ1mTyreAB2QY020CibjQhnr1qrQTa7a1Zfv013oMBC/ysIV6zSdW30ubUrsl6unHPLpncFd642nU+URrnZBd3rmNDzPgY596R0b06XdPB4nsVnUjZy9CdUIM31U2w/od2iwxwPQCD6Qe5pZ1i0cO/qkXkUwa933GeKW795s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=haUEDowS; arc=none smtp.client-ip=91.218.175.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="haUEDowS"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=32bCd92QrJ5CNFMIriXP22Lyz4CFQtB+v0/Z/V2E8wk=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786749610; v=1; x=1787354410;
 b=haUEDowS3aiummw114mtZgRiZmxyPBISz5DYTwjQuB9RwHPJLoNdF2rVZOSAjTDd2CEHT9C4
 dfKLG0bFosae4R8zAENcp38wbdkKO8AL1yisriJjqKJmWCrqjFgxBMUb0w0MG7OZVFleVdMKxCH
 YznhZDcb8BQc5fDoC8iGDXIs=
X-Envelope-To: bpf@vger.kernel.org
Received: from gvineet-fedora-PF5JGVFY.thefacebook.com (2620:10d:c090:500::6:7be4)
	by smtp.migadu.com with ESMTPS id 845d4f031579e439;
	Fri, 14 Aug 2026 23:20:09 +0000
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
Subject: [RFC bpf-next 3/6] bpf: support low-32 subreg scalar linking for zero-extending movs
Date: Fri, 14 Aug 2026 16:19:42 -0700
Message-ID: <20260814231945.3884596-4-vineet.gupta@linux.dev>
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

Problem
=======
Currently register equality tracking and propagation only works for full
64-bits (with additional constant offset). It is missing the
relationship: "these two regs share only their low 32-bits".

An illustrative snippet:

|  r6 = ...                    /* full 64-bit unknown */
|  w7 = w6                     /* 32-bit zero-extend mov from wide src */
|  if w6 != 0 goto .Lxx        /* branch not taken, src narrowed */
|  if w7 == 0 goto .Lok   <-- missing

It works if the register is narrow to begin with, e.g.
|  r6 = *(u32 *)(...)

Rephrased in verifier speak:

The linked-scalar equality relation sync_linked_regs() maintains is full
64-bit only; there is no subregister (low-32) equality link.
A 32-bit mov (w1 = w2) is therefore either promoted to a full-64-bit link
when the source is provably u32, or the link is dropped entirely when the
wider source has unknown high bits. A later narrowing of the source to its
low 32 bits never reaches dst, causing safe programs to be rejected. Note that
the ADD_CONST32 machinery only applies to += const offset, not to equality.

This was seen with bpf-gcc codegen that tends to reuse "w0 = idx" for
"return 0" on an idx==0 path, for bpf_loop callbacks.

Solution
========
 - Introduce a low-32-only link, BPF_FLAG_SUBREG_ZEXT, added to BPF_FLAG_LINK.
 - For a wide-source 32-bit mov, mark dst with BPF_FLAG_SUBREG_ZEXT instead
   of clearing it (when src carries a scalar id).
 - On a later low-32 narrowing sync_linked_regs() re-derives such a register as
   the zero-extension of the base's low 32 bits: it copies the base (keeping its
   precise low-32 tnum) and re-applies zext_32_to_64() -- the same helper the
   32-bit mov used -- which is sound even when the source has unknown high bits.
   This is applied only when neither side carries an ADD_CONST delta (the
   combined subreg+delta case is not modeled).
 - Sites that group a subreg-linked register by its scalar id compare ->id
   directly: no masking is needed, since BPF_FLAG_SUBREG_ZEXT lives in
   ->flags.

The reconstruction copies the base wholesale, so it must put back the fields
that identify reg rather than known_reg -- ->id and, now, the link flag. This
mirrors what the ADD_CONST arm below already does ("Must preserve off and id,
otherwise another sync_linked_regs() will be incorrect"). Dropping the flag
while keeping the ->id would be worse than losing the link: the register would
claim a full 64-bit equality with a base whose high bits are unknown, and the
next sync driven by it would copy a narrowed low-32 value straight onto the
base's high half.

The link_flags_match() helper added by the previous patch is widened from
BPF_FLAG_ADD_CONST to BPF_FLAG_LINK, so regs_exact() -- and through it
states_maybe_looping() -- discriminates the new flavour as well. regsafe()
additionally checks it early, before the explore_alu_limits and !precise
short-circuits, which the helper's call site below them does not cover.

Note: the sync_linked_regs() reconstruction is wrapped in an extra block that
looks redundant here. It is a placeholder for the sign-extension counterpart
patch, which turns it into the else arm of an if/else on the link flavour;
keeping it now avoids re-indenting the whole body there.

Results
=======
Improves verifier tracking (seen in the next selftest).
selftest runs:
 - clang: no new regressions (-mcpu=v3 and v4)
 - bpf-gcc: no new regressions; the measurable selftest pass improvements
   come with the sign-extension counterpart patch.

Signed-off-by: Vineet Gupta <vineet.gupta@linux.dev>
---
 include/linux/bpf_verifier.h | 10 ++++
 kernel/bpf/states.c          | 23 ++++++++-
 kernel/bpf/verifier.c        | 91 ++++++++++++++++++++++++++++++++----
 3 files changed, 114 insertions(+), 10 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 2b03fdba9acf..a4cba5c5099e 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -169,10 +169,20 @@ struct bpf_reg_state {
 	 *
 	 * BPF_FLAG_ADD_CONST{32,64}: this register is (base + ->delta) within
 	 * its ->id set, computed with a 32- or 64-bit ALU add.
+	 * BPF_FLAG_SUBREG_ZEXT: low-32-bit-only equality (as opposed to the
+	 * full equality implied by a bare shared ->id): this register shares
+	 * only the base's low 32 bits, and its high bits are zero (32-bit
+	 * zero-extending mov).
+	 * sync_linked_regs() propagates the low 32-bit subrange and rebuilds
+	 * the high half accordingly, so this is sound even when the base has
+	 * unknown high bits.
 	 */
 #define BPF_FLAG_ADD_CONST32	(1U << 0)
 #define BPF_FLAG_ADD_CONST64	(1U << 1)
 #define BPF_FLAG_ADD_CONST	(BPF_FLAG_ADD_CONST32 | BPF_FLAG_ADD_CONST64)
+#define BPF_FLAG_SUBREG_ZEXT	(1U << 2)
+/* Every flag describing how this register relates to its ->id set. */
+#define BPF_FLAG_LINK		(BPF_FLAG_ADD_CONST | BPF_FLAG_SUBREG_ZEXT)
 #define BPF_FLAG_PRECISE	(1U << 7)
 	u8 flags;
 };
diff --git a/kernel/bpf/states.c b/kernel/bpf/states.c
index d3105b9a9965..ef71999c4695 100644
--- a/kernel/bpf/states.c
+++ b/kernel/bpf/states.c
@@ -490,6 +490,9 @@ static int clean_verifier_state(struct bpf_verifier_env *env,
  *
  * Only meaningful when rold carries an id: the flags are only ever set
  * together with one, so rold->id == 0 implies none of them is set.
+ *
+ * BPF_FLAG_LINK covers every flavour, so this widens automatically as new
+ * ones are added.
  */
 static bool link_flags_match(const struct bpf_reg_state *rold,
 			     const struct bpf_reg_state *rcur)
@@ -497,7 +500,7 @@ static bool link_flags_match(const struct bpf_reg_state *rold,
 	if (!rold->id)
 		return true;
 
-	return (rold->flags & BPF_FLAG_ADD_CONST) == (rcur->flags & BPF_FLAG_ADD_CONST);
+	return (rold->flags & BPF_FLAG_LINK) == (rcur->flags & BPF_FLAG_LINK);
 }
 
 static bool regs_exact(const struct bpf_reg_state *rold,
@@ -554,6 +557,24 @@ static bool regsafe(struct bpf_verifier_env *env, struct bpf_reg_state *rold,
 
 	switch (base_type(rold->type)) {
 	case SCALAR_VALUE:
+		/*
+		 * A low-32-bit-only link has different sync_linked_regs()
+		 * semantics than a full/ADD_CONST equality. check_scalar_ids()
+		 * only ever sees the plain ->id and never looks at ->flags, so a
+		 * mismatch must be rejected explicitly.
+		 * Check it here, before the explore_alu_limits and !precise
+		 * short-circuits below (neither of which tests it). Note the
+		 * pre-existing BPF_FLAG_ADD_CONST check sits after those
+		 * short-circuits instead. The argument for checking early
+		 * applies to it equally, but moving it makes regsafe() stricter
+		 * on a path that predates this series, which is a pruning change
+		 * that wants measuring on its own; it is deliberately left
+		 * alone here.
+		 */
+		if (rold->id &&
+		    (rold->flags & BPF_FLAG_SUBREG_ZEXT) != (rcur->flags & BPF_FLAG_SUBREG_ZEXT))
+			return false;
+
 		if (env->explore_alu_limits) {
 			/* explore_alu_limits disables tnum_in() and range_within()
 			 * logic and requires everything to be strict
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 93e69116ca9e..8a802d49d0a4 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -1806,7 +1806,7 @@ static void __mark_reg_known(struct bpf_reg_state *reg, u64 imm)
 	       offsetof(struct bpf_reg_state, var_off) - sizeof(reg->type));
 	reg->id = 0;
 	reg->parent_id = 0;
-	reg->flags &= ~BPF_FLAG_ADD_CONST;
+	reg->flags &= ~BPF_FLAG_LINK;
 	___mark_reg_known(reg, imm);
 }
 
@@ -3309,7 +3309,7 @@ static void clear_scalar_id(struct bpf_reg_state *reg)
 {
 	reg->id = 0;
 	reg->delta = 0;
-	reg->flags &= ~BPF_FLAG_ADD_CONST;
+	reg->flags &= ~BPF_FLAG_LINK;
 }
 
 static void assign_scalar_id_before_mov(struct bpf_verifier_env *env,
@@ -15076,15 +15076,42 @@ static int check_alu_op(struct bpf_verifier_env *env, struct bpf_insn *insn)
 					if (insn->off == 0) {
 						bool is_src_reg_u32 = get_reg_width(src_reg) <= 32;
 
-						if (is_src_reg_u32)
+						/*
+						 * *dst_reg = *src_reg below copies src's id into dst, a
+						 * full 64-bit equality link. That is only sound when src
+						 * fits in u32: a 32-bit mov zero-extends dst, so for a
+						 * wider src the link would let sync_linked_regs()
+						 * propagate dst's [0, U32_MAX] range back onto src's
+						 * unknown high bits. For a wide src drop the full link
+						 * and form a low-32-only BPF_FLAG_SUBREG_ZEXT link instead, so a
+						 * later narrowing of src's low 32 bits still reaches dst.
+						 *
+						 * wide_subreg_link gates that low-32 link and excludes:
+						 *  - a self-mov (w6 = w6): src == dst, nothing to link;
+						 *    forming one would only mint an id and a spurious
+						 *    self-link (inert in sync_linked_regs()).
+						 *  - an ADD_CONST-linked src (rX = base + K):
+						 *    assign_scalar_id_before_mov() would clear its
+						 *    base+delta link, and a combined subreg+delta link
+						 *    isn't modeled anyway (sync_linked_regs() skips it).
+						 * In both cases src is left untouched and dst is cleared,
+						 * as before this feature.
+						 */
+						bool wide_subreg_link = !is_src_reg_u32 &&
+							src_reg != dst_reg &&
+							!(src_reg->flags & BPF_FLAG_ADD_CONST);
+
+						if (is_src_reg_u32 || wide_subreg_link)
 							assign_scalar_id_before_mov(env, src_reg);
 						*dst_reg = *src_reg;
-						/* Make sure ID is cleared if src_reg is not in u32
-						 * range otherwise dst_reg min/max could be incorrectly
-						 * propagated into src_reg by sync_linked_regs()
-						 */
-						if (!is_src_reg_u32)
-							clear_scalar_id(dst_reg);
+						if (!is_src_reg_u32) {
+							if (wide_subreg_link && src_reg->id) {
+								/* ->id already copied above */
+								dst_reg->flags |= BPF_FLAG_SUBREG_ZEXT;
+							} else {
+								clear_scalar_id(dst_reg);
+							}
+						}
 					} else {
 						/* case: W1 = (s8, s16)W2 */
 						bool no_sext = reg_umax(src_reg) < (1ULL << (insn->off - 1));
@@ -15953,6 +15980,52 @@ static void sync_linked_regs(struct bpf_verifier_env *env, struct bpf_verifier_s
 			continue;
 		if (reg->id != known_reg->id)
 			continue;
+		/*
+		 * A low-32 linked register shares only the base's low 32 bits;
+		 * the flag says how its high bits are derived. For
+		 * BPF_FLAG_SUBREG_ZEXT they are zero (32-bit zero-extending mov).
+		 * Rebuild it from known_reg's low 32 bits accordingly, but only
+		 * when neither side carries an ADD_CONST delta -- with a delta
+		 * the low bits differ from the base by that delta and the combined
+		 * subreg+ADD_CONST reconstruction isn't modeled here, so leave reg
+		 * unchanged (sound, just less precise).
+		 */
+		if (reg->flags & BPF_FLAG_SUBREG_ZEXT) {
+			if (!((reg->flags | known_reg->flags) & BPF_FLAG_ADD_CONST)) {
+				{
+					u32 saved_id = reg->id;
+					u8 saved_subreg = reg->flags & BPF_FLAG_SUBREG_ZEXT;
+
+					/*
+					 * reg = zext32(known_reg): its low 32 bits come from
+					 * the base and its high 32 are zero. Rather than
+					 * rebuild the value by hand, copy the base (keeping
+					 * its precise low-32 tnum) and re-clear the high half
+					 * with the same zext_32_to_64() the 32-bit
+					 * zero-extending mov used -- the zero high half is a
+					 * fallout of it, so no dedicated reconstruction is
+					 * needed.
+					 */
+					*reg = *known_reg;
+					reg->id = saved_id;
+					reg->flags = (reg->flags & ~BPF_FLAG_SUBREG_ZEXT) | saved_subreg;
+					zext_32_to_64(reg);
+					reg_bounds_sync(reg);
+				}
+				if (e->is_reg)
+					mark_reg_scratched(env, e->regno);
+				else
+					mark_stack_slot_scratched(env, e->spi);
+			}
+			continue;
+		}
+		/*
+		 * Dest-driven direction (known_reg is subreg-linked, reg is not):
+		 * copying known_reg's low-32-only state into a full register would
+		 * be unsound, so leave reg unchanged.
+		 */
+		if (known_reg->flags & BPF_FLAG_SUBREG_ZEXT)
+			continue;
 		/*
 		 * Skip mixed 32/64-bit links: the delta relationship doesn't
 		 * hold across different ALU widths.
-- 
2.53.0-Meta

