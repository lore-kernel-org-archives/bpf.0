Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.188
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792513190;
	b=1mgPN0pNaOzlC7UgQy7WWR9eGGa4B3ihHCBLd0SdZ77FtiVgnqu4ya4fgApgHjpEajfy
	 +/LjNiPWzJA5D/ZktU51/vj3daDzldFBC7kTIas9ZB8BR+aGrARYJ9Xl03daUdcxHBL2M
	 BuMEk/9mVzmvzsuCLUjXR7mifJl7Sf9BzjCr2+T45zCtk1zGTZh9T6LiQVkqIhVK9MCtJ
	 F2zxZO59iQkt6K0aQIbWiYsVRoL5vYD5uQYSshse/65L1b1wUmGD74PLZy4MZ3LNQNxv9
	 FZh8EwJRX+2l/i/BQvQkNCTuRjkOPZtMQEZ5tbXqy02iV/FauRBnZHo6QFKWD3JYJIg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792513190;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Llp9CtHbP5fENNNr0fR+13PjDZ+s1aBg9GXHdJM35JY=;
	b=Hkx2ahU0s3lWExSpxv8xQqwh9Z1ktfLR3g9MTvWtURxsYIuEf88ukPlVUquK6IKhretk
	 yyMHi1PSIsw3H3s98tY90XaoXINCw96JCZgW1gihnpBtBWIgTN3VGa1vz0wRDKJjTYRXM
	 bDAWm2VHXwdKadnyYJUEhVJXNj0U5pObLFnQerbjKHDnzP90+YP9lwiha/tt1H64p0M73
	 K90AbKMBH70DqqbV7vkxd9l7IrlMlVg22LDRemih4jw4QXTlp9bjiErifJMEZ9i+HNcGj
	 mZcSjkruECZuULwxjeeGy5g8xYmM3npvHlHEe1Zh+U2UFFzC+JTk6MK21RGO5Eoc8xA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=CP2lxElt;
	arc=none smtp.remote-ip=95.215.58.188
Received: from mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8CD260A2616
	for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 16:19:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D8CD260A2616
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=CP2lxElt
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=ngbD5FaCTV8a88nPzmwuDDRjDYld8LWFe8w1lxKov0c=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792513187; v=1; x=1793117987;
 b=CP2lxElt5UYh8/Y/5tcymPFC3vGgJmM+L+RHXBYy2LxmrJL9WlZ2DtEITDuu0ALzyYctIlAL
 myQ/JhxwpQr1/PQjmTnGlGSKvuQ51VrzZbvvffha7e/9g5F6yLNMslSScMJVMR9iaAvMPwMcrHw
 /728jopwADhYiJk8Ecy9yWp8=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 65075d431e4c50de;
	Tue, 20 Oct 2026 16:19:46 +0000
X-Mizu-Trace-ID: 65075d431e4c50de
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
Subject: [PATCH bpf-next v3 04/12] bpf: Track low-32 scalar equality across zero-extending movs
Date: Tue, 20 Oct 2026 09:18:59 -0700
Message-ID: <20261020161907.2115379-5-vineet.gupta@linux.dev>
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

Linked-scalar equality is full-64-bit only, so a 32-bit mov from a source
with unknown high bits drops the relationship:

  r6 = ...              /* full 64-bit unknown */
  w7 = w6               /* 32-bit zero-extending mov */
  if w6 != 0 goto ...   /* not taken: r6's low 32 bits are 0 */
  if w7 == 0 goto ...   /* not deduced today */

Record it with the kind the previous patch already provides.
BPF_REG_LINK_ZEXT, which is what BPF_ADD_CONST32 became, says exactly
what the mov did:

	dst == (u32)(src + 0)

However this changes the pre-existing semantics slightly:

	today    reg == base + delta, base known to fit u32
	here     reg == (u32)(base + delta), for any base width

Every link that forms today is over a narrow base, where the two
readings coincide, so nothing reachable now behaves differently; what is
new is that a wide base forms a link where it was previously refused
outright.

This is done by dropping the guard:

	if (alu32 && (dst_umax > U32_MAX))
		goto clear_id;

What the wide base costs is invertibility of the high half: dst pins
src's low 32 bits and says nothing about the rest. So sync_linked_regs()
drives such a link forwards only.

That also changes how a member is updated. Where the old code replaced
it with the base plus the delta difference, it now intersects the two: a
one-directional link leaves the member free to know more about itself
than the base does, and overwriting would discard that.

Intersecting can come out empty, when the two sides contradict -- the
link pins only the low 32 bits, so the verifier can walk a branch where
they disagree about the rest. Empty is the correct answer, and a bad
shape to leave behind: reg_bounds_sync() declines to touch an empty
range and the next reg_bounds_sanity_check() reports a verifier bug that
is not one. Keep the pre-intersect state instead. Without that,

	w7 = w6;		/* r7 == (u32)r6 */
	if w7 != 5 goto out;	/* r7 == 5 */
	if r6 != 7 goto out;	/* explored: r6 is wide and unknown */
	r9 = 0;
	r7 %= r9;		/* validates r7 without recomputing it */

prints a REG INVARIANTS VIOLATION and a WARNING from an ordinary socket
filter. zext_contradiction_keeps_range_sane covers it, and discriminates
only here: the later reverse-direction patch makes "if r6 != 7"
statically false, so the branch is never walked at the tip.

The patch also allows delta composition, once. "w3 = w0; w3 -= 1" is
ordinary codegen, and until now the subtract threw the link away: the
mov gives every zero-extending link a kind, and the test that refuses a
second delta could not tell a link that has one from a link that merely
has a kind. Let the zero-extending link, and only it, compose a single
32-bit delta onto a delta of zero. The updated sub32_partial_overflow
dump is this case, its register now rendering as id=N-1.

Composing any further is refused deliberately. Deltas are compared for
equality, so a link that keeps accumulating them turns every value a
loop reaches into a state of its own: on arena_strsearch allowing a
second delta costs 1176 -> 1751 insns and 102 -> 133 states, and
allowing it onto a zero delta that an add produced rather than the mov
still costs 1176 -> 1196. Neither buys a verdict.

Forming a link re-bases a wide source, since
assign_scalar_id_before_mov() drops whatever link it carried; that costs
precision only.

verifier_reg_equal's subreg_equality_2 becomes __success. It is the same
link with a 64-bit compare on the member: "w2 < 9" bounds r3 over all 64
bits, not just its low half, because the zero-extending mov leaves
nothing above them.

Signed-off-by: Vineet Gupta <vineet.gupta@linux.dev>
---
v3: was v2 3/13.
 - the zero-extending link is now ADD_CONST32 with delta 0, spelled
   BPF_REG_LINK_ZEXT, rather than a kind of its own (Alexei). That
   generalises the kind to "(u32)(base + delta), for any base width",
   dropping the dst_umax > U32_MAX guard and making the link
   one-directional. It is the one pre-existing semantic the series
   changes; see the cover.
 - a BPF_REG_LINK_ZEXT link may take one delta, so "w3 = w0; w3 -= 1"
   keeps it where v2 dropped it. Composing further costs arena_strsearch
   1176 -> 1751 insns for no verdict, so it is restricted to one.
 - a second 32-bit mov now drops the link, where v2's separate kind kept
   it.
 - NEW IN THIS REVISION: the intersect step no longer leaves an empty
   range behind when the two sides contradict. Without the guard that
   printed a WARNING from an ordinary socket filter; patch 8 happened to
   mask it, so the window was patches 4-7.

 include/linux/bpf_verifier.h                  |   3 +-
 kernel/bpf/verifier.c                         | 112 ++++++++++++++----
 .../selftests/bpf/progs/verifier_bounds.c     |   2 +-
 .../selftests/bpf/progs/verifier_reg_equal.c  |  14 +--
 4 files changed, 101 insertions(+), 30 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index bb369b320334..081facac7b86 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -56,13 +56,14 @@ enum bpf_iter_state {
  * how much, and is meaningful for every kind:
  *
  *   BPF_REG_LINK_FULL:  reg == base + delta
- *   BPF_REG_LINK_ZEXT:  reg == (u32)(base + delta), base known to fit u32
+ *   BPF_REG_LINK_ZEXT:  reg == (u32)(base + delta), for ANY base width
  *   BPF_REG_LINK_SEXT:  reg == (s32)(base + delta)
  *
  *   r1 = r2;       r1 and r3 are linked to r2: id == N
  *   r3 = r2;
  *   r1 += 10;      r1 gets BPF_REG_LINK_FULL, delta 10
  *   w3 += 10;      w3 gets BPF_REG_LINK_ZEXT, delta 10
+ *   w7 = w6;       r7 gets BPF_REG_LINK_ZEXT, delta 0  (r6 may be wide)
  */
 enum bpf_reg_link_kind {
 	BPF_REG_LINK_NONE = 0,
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 609342940d1a..ce7016446936 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -17287,13 +17287,6 @@ static int adjust_reg_min_max_vals(struct bpf_verifier_env *env,
 		verbose(env, "verifier internal error: no src_reg\n");
 		return -EFAULT;
 	}
-	/*
-	 * For alu32 linked register tracking, we need to check dst_reg's
-	 * umax_value before the ALU operation. After adjust_scalar_min_max_vals(),
-	 * alu32 ops will have zero-extended the result, making umax_value <= U32_MAX.
-	 */
-	u64 dst_umax = reg_umax(dst_reg);
-
 	err = adjust_scalar_min_max_vals(env, insn, dst_reg, *src_reg);
 	if (err)
 		return err;
@@ -17316,9 +17309,6 @@ static int adjust_reg_min_max_vals(struct bpf_verifier_env *env,
 		if (!alu32 && ((s64)val < S32_MIN || (s64)val > S32_MAX))
 			goto clear_id;
 
-		if (alu32 && (dst_umax > U32_MAX))
-			goto clear_id;
-
 		off = (s32)val;
 
 		if (BPF_OP(insn->code) == BPF_SUB) {
@@ -17330,11 +17320,28 @@ static int adjust_reg_min_max_vals(struct bpf_verifier_env *env,
 
 		if (dst_reg->link_kind) {
 			/*
-			 * If the register already went through rX += val
-			 * we cannot accumulate another val into rx->off.
+			 * Only the zero-extending link the mov above records,
+			 * BPF_REG_LINK_ZEXT with delta 0, can take a delta:
+			 * (u32)((u32)(base + 0) + off) is (u32)(base + off).
+			 * The add has to be 32-bit as well, since a 64-bit one
+			 * parts company with the link once the low half wraps.
+			 *
+			 * Everything else still drops the link. A zero delta
+			 * reached by an add rather than by the mov, say "r1 +=
+			 * r3" with r3 known to be 0, has already spent its
+			 * delta; composing onto it keeps a link alive across a
+			 * loop's increments, and since the delta is compared
+			 * for equality, every value the loop reaches becomes a
+			 * state of its own and stops pruning.
 			 */
+			if (dst_reg->link_kind != BPF_REG_LINK_ZEXT || !alu32 ||
+			    dst_reg->delta) {
+				/* also the target of the two gotos above */
 clear_id:
-			bpf_clear_scalar_id(dst_reg);
+				bpf_clear_scalar_id(dst_reg);
+			} else {
+				dst_reg->delta = off;
+			}
 		} else {
 			if (alu32)
 				dst_reg->link_kind = BPF_REG_LINK_ZEXT;
@@ -17559,16 +17566,43 @@ static int check_alu_op(struct bpf_verifier_env *env, struct bpf_insn *insn)
 				} else if (src_reg->type == SCALAR_VALUE) {
 					if (insn->off == 0) {
 						bool is_src_reg_u32 = get_reg_width(src_reg) <= 32;
+						/*
+						 * A wide src shares only its low 32 bits. A
+						 * full link would let dst's [0, U32_MAX]
+						 * propagate onto src's unknown high bits, so
+						 * record a low-32-only link instead. A
+						 * self-mov has nothing to link.
+						 */
+						bool subreg_link = !is_src_reg_u32 &&
+								   src_reg != dst_reg;
 
-						if (is_src_reg_u32)
+						if (is_src_reg_u32 || subreg_link)
 							assign_scalar_id_before_mov(env, src_reg);
 						*dst_reg = *src_reg;
-						/* Make sure ID is cleared if src_reg is not in u32
-						 * range otherwise dst_reg min/max could be incorrectly
-						 * propagated into src_reg by sync_linked_regs()
-						 */
-						if (!is_src_reg_u32)
+						if (subreg_link && src_reg->id) {
+							/*
+							 * Keep src's delta. It is
+							 * always zero here, since
+							 * assign_scalar_id_before_mov()
+							 * above has just dropped any
+							 * kind src carried; the
+							 * inheritance starts to matter
+							 * once BPF_REG_LINK_SEXT is
+							 * spared there, because dst is
+							 * (u32)(base + delta) whatever
+							 * kind src had --
+							 * (u32)((s32)(base + d)) ==
+							 * (u32)(base + d).
+							 */
+							dst_reg->link_kind = BPF_REG_LINK_ZEXT;
+						} else if (!is_src_reg_u32) {
+							/*
+							 * dst min/max could otherwise be
+							 * propagated back into a src that
+							 * is not in u32 range.
+							 */
 							bpf_clear_scalar_id(dst_reg);
+						}
 					} else {
 						/* case: W1 = (s8, s16)W2 */
 						bool no_sext = reg_umax(src_reg) < (1ULL << (insn->off - 1));
@@ -18450,6 +18484,15 @@ static void sync_linked_regs(struct bpf_verifier_env *env, struct bpf_verifier_s
 			continue;
 		if (reg->id != known_reg->id)
 			continue;
+		/*
+		 * A zero-extending link, spelled BPF_REG_LINK_ZEXT: the
+		 * relation reg == (u32)(base + delta) does not invert once the
+		 * base is wider than 32 bits, so the reverse direction is
+		 * skipped.
+		 */
+		if (known_reg->link_kind == BPF_REG_LINK_ZEXT &&
+		    get_reg_width(reg) > 32)
+			continue;
 		/*
 		 * Skip mixed 32/64-bit links: the delta relationship doesn't
 		 * hold across different ALU widths.
@@ -18457,13 +18500,19 @@ static void sync_linked_regs(struct bpf_verifier_env *env, struct bpf_verifier_s
 		if (reg->link_kind && known_reg->link_kind &&
 		    reg->link_kind != known_reg->link_kind)
 			continue;
-		if ((!reg->link_kind && !known_reg->link_kind) ||
-		    reg->delta == known_reg->delta) {
+		/*
+		 * Only an unlinked pair is a plain copy. Anything carrying a
+		 * kind goes through the differencing arm below, which adds the
+		 * delta difference (zero when the deltas match) and then
+		 * applies the BPF_REG_LINK_ZEXT zero-extension.
+		 */
+		if (!reg->link_kind && !known_reg->link_kind) {
 			*reg = *known_reg;
 		} else {
 			enum bpf_reg_link_kind saved_link_kind = reg->link_kind;
 			s32 saved_off = reg->delta;
 			u32 saved_id = reg->id;
+			struct bpf_reg_state prev = *reg;
 
 			fake_reg.type = SCALAR_VALUE;
 			__mark_reg_known(&fake_reg, (s64)reg->delta - (s64)known_reg->delta);
@@ -18485,6 +18534,27 @@ static void sync_linked_regs(struct bpf_verifier_env *env, struct bpf_verifier_s
 			if (reg->link_kind == BPF_REG_LINK_ZEXT ||
 			    known_reg->link_kind == BPF_REG_LINK_ZEXT)
 				zext_32_to_64(reg);
+			/*
+			 * Intersect rather than overwrite. A BPF_REG_LINK_ZEXT
+			 * link over a wide base does not propagate back, so the
+			 * base can be wider than what @reg has already proved
+			 * about itself; replacing it would lose that.
+			 */
+			cnum64_intersect_with(&reg->r64, prev.r64);
+			cnum32_intersect_with(&reg->r32, prev.r32);
+			reg->var_off = tnum_intersect(reg->var_off, prev.var_off);
+			/*
+			 * An empty intersection means the two sides contradict,
+			 * so this path is unreachable. Say nothing rather than
+			 * say it with an empty range: reg_bounds_sync() below
+			 * refuses to touch one, and the first later
+			 * reg_bounds_sanity_check() would report it as a
+			 * verifier bug, which it is not. Keeping the wider
+			 * pre-intersect state only costs precision on a path
+			 * that cannot be taken.
+			 */
+			if (range_bounds_violation(reg))
+				*reg = prev;
 			reg_bounds_sync(reg);
 		}
 		if (e->is_reg)
diff --git a/tools/testing/selftests/bpf/progs/verifier_bounds.c b/tools/testing/selftests/bpf/progs/verifier_bounds.c
index df8d5309657e..ad346dec1150 100644
--- a/tools/testing/selftests/bpf/progs/verifier_bounds.c
+++ b/tools/testing/selftests/bpf/progs/verifier_bounds.c
@@ -1516,7 +1516,7 @@ __naked void sub32_full_overflow(void)
 SEC("socket")
 __description("32-bit subtraction, partial overflow, result in unbounded u32 bounds")
 __success __log_level(2)
-__msg("3: (1c) w3 -= w2 {{.*}} R3=scalar(smin=0,smax=umax=0xffffffff,var_off=(0x0; 0xffffffff))")
+__msg("3: (1c) w3 -= w2 {{.*}} R3=scalar(id={{[0-9]+}}-1,smin=0,smax=umax=0xffffffff,var_off=(0x0; 0xffffffff))")
 __retval(0)
 __naked void sub32_partial_overflow(void)
 {
diff --git a/tools/testing/selftests/bpf/progs/verifier_reg_equal.c b/tools/testing/selftests/bpf/progs/verifier_reg_equal.c
index dc1d8c30fb0e..34214ec92670 100644
--- a/tools/testing/selftests/bpf/progs/verifier_reg_equal.c
+++ b/tools/testing/selftests/bpf/progs/verifier_reg_equal.c
@@ -31,23 +31,23 @@ l1_%=:	exit;						\
 }
 
 SEC("socket")
-__description("check w reg not equal if r reg upper32 bits not 0")
-__failure __msg("R1 !read_ok")
+__description("check w reg equal if r reg upper32 bits not 0")
+__success
 __naked void subreg_equality_2(void)
 {
 	asm volatile ("					\
 	call %[bpf_ktime_get_ns];			\
 	r2 = r0;					\
-	/* Upper 4-bytes of r2 may not be 0, thus insn	\
-	 * w3 = w2 should not propagate reg id,	and	\
-	 * w2 < 9 comparison should not propagate	\
-	 * the range for r3 either.			\
+	/* Upper 4-bytes of r2 may not be 0, so r3 does	\
+	 * not equal r2. It does share r2's low 32 bits	\
+	 * though, so w2 < 9 still bounds r3: the	\
+	 * zero-extending mov leaves nothing above them.\
 	 */						\
 	w3 = w2;					\
 	if w2 < 9 goto l0_%=;				\
 	exit;						\
 l0_%=:	if r3 < 9 goto l1_%=;				\
-	/* r1 read is illegal at this point */		\
+	/* unreachable, so the r1 read is never made */	\
 	r0 -= r1;					\
 l1_%=:	exit;						\
 "	:
-- 
2.53.0-Meta

