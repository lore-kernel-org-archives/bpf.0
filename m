Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792513200;
	b=En9pqihM002eMDJepSphvcN1QPyVrpmZFyoFMuOa7/gn0Lzwg/wSdauwiFeeXejZSCHE
	 wJXrdZrL8QMBlgUH2Ppo2uEOdubxQHB1RQ3/q5H2xVVRBbPSI1phPxXId7O90XQekoGxf
	 zK3MZzUjdErAW3Tg+iPzU5W50vgviwnrpNTJxeaOfmWCSHIUjUza1Z2His1VptqqrOtTd
	 U36Cx4KspPpQ1F9HYsksgcpFEKDaGmbySsu8L4vM7UlJC3muhwrM+Y2Bh8EXg085sjsYm
	 RVzVx0HIxGk2WYQP40syZmXY43q6LJlXrbUd7olw6NUhIFzzjAr5GmbyNb4G+YXw0pw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792513200;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Ua7Lf9K5WBIncm71YXHcWygPR1Kpcb2CloeMCzqxAaA=;
	b=i24LMQW7f3aIzgVDCKYKfWe/x70/KrjwvV9E++WJPawq6MBj0G35v3ZQ0LlbXrEdahV5
	 rVqopl6aHbdHbqa7FC8uFS4VkDDLXMSnGxggpsor8DCiXhx3QTMl4cny/6MivEgLk2k9x
	 s3foIQSaEPHDZojyPj2wdkhZRKU1gvI7yfidKNgz51VY2hkwLbEeVaBKgW9cKZRcmXI9f
	 tZ3ADc6pM6H4rSElngxwpSCWNI2B8f0kER2cNUT7XZrzs32JqQCWczOH8KKgwBW0MiALl
	 KYxwSclO7zYpu7NDnj+RKR/j8cCurNyPSVpodRjTlOFBk2TRIfpMzA3BuyDc5q3AomA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=Kn3ZrhCC;
	arc=none smtp.remote-ip=95.215.58.199
Received: from mta1.migadu.com (out-199.mta1.migadu.com [95.215.58.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2B7C60A263E
	for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 16:19:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C2B7C60A263E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=Kn3ZrhCC
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=OcaKo8vBMcPK2i5mcytKpINtfxKb6f8YEnRBF3ZzBtQ=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792513198; v=1; x=1793117998;
 b=Kn3ZrhCC+gB/QqCHwBOmSvKUC8g/qWcvMvx9ILqJWWuAOvgAPw+Pww+LlrYe8+EixcT7Ui8J
 mkFbWWhdKGVutDR48lcNSNubhWeCDVS9D1WRKhPdPI77Sj62meNc6vpzeb0sFb4UNFLVQxqg7Lh
 EUA0vOFdj8XRbIdQsBRXVrt0=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id d45fc1b81ec5bdfa;
	Tue, 20 Oct 2026 16:19:57 +0000
X-Mizu-Trace-ID: d45fc1b81ec5bdfa
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
Subject: [PATCH bpf-next v3 06/12] bpf: Track low-32 scalar equality across sign-extending movs
Date: Tue, 20 Oct 2026 09:19:01 -0700
Message-ID: <20261020161907.2115379-7-vineet.gupta@linux.dev>
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

A 32-bit sign extension shares the source's low 32 bits too, filling the
high half from bit 31:

  r6 = ...              /* full 64-bit unknown */
  r7 = (s32)r6          /* 32-bit sign-extending mov */
  if w6 == -1 goto ...  /* taken: r6's low 32 bits are all ones */
  ...                   /* r7 is -1, not deduced today */

No constant k makes dst == (u32)(src + k) a sign extension, so this
needs a third kind, BPF_REG_LINK_SEXT, driven by sext_32_to_64() where
the zero-extending arm uses zext_32_to_64(). The enum already had room,
so bpf_reg_state stays 80 bytes.

Both work from the base's 32-bit range, which is what a 32-bit compare
narrows; coerce_reg_to_size_sx() cannot serve, as it reads smin/smax,
which straddle after such a compare. tnum_sext() is the counterpart to
tnum_cast(), keeping the known low bits where a tnum_range() over the new
bounds would not.

sext_32_to_64() resets the register's base/step line; the comment there
gives the arithmetic. Note it resets unconditionally, where
coerce_reg_to_size_sx() and coerce_subreg_to_size_sx() return early when
the extension is a provable no-op and keep the line. That costs a little
precision in the same case here, which is not worth an extra branch on a
path that has just rebuilt the value from the base.

Unlike the zero-extending arm, the source's delta comes along. Both
base + d and (u32)(base + d) have low half (base + d), so dst is
(s32)(base + d) whichever the source was:

	w7 = w6;	/* BPF_REG_LINK_ZEXT, delta 0 */
	w7 += 5;	/* BPF_REG_LINK_ZEXT, delta 5 */
	r8 = (s32)r7;	/* BPF_REG_LINK_SEXT, delta 5 */

keeps r8 tied to r6. sext_mov_inherits_delta pins it; without the
inheritance the program is rejected. A self-mov can form a link here too,
which is how a sign-extended int return lands.

sync_linked_regs() needs no separate sext path: the differencing arm
already copies the base and adds the delta difference, and which extension
follows is just the member's kind. Where the base does fit 32 bits the
reverse direction runs for both narrow kinds with the *zero* extension --
the base is then below 2^32 and equal to the member's low half, whichever
way the member filled its own high half.

One guard gains a new meaning. BPF_REG_LINK_ZEXT against
BPF_REG_LINK_SEXT is a sound deduction that is now declined on purpose:
bpf-gcc compiles "i += 1" for an int loop counter into exactly that
pair, and deducing the sign-extended half makes the counter a fresh
constant every iteration, so iters.c:iter_obfuscate_counter runs to the
1M instruction limit. sext_no_sync_from_zext_sibling pins it.

Signed-off-by: Vineet Gupta <vineet.gupta@linux.dev>
---
v3: was v2 7/13.
 - SUBREG_SEXT becomes BPF_REG_LINK_SEXT, a value of the same two-bit
   field, so the sign-extending link costs no space of its own, and v2's
   separate reconstruction in sync_linked_regs() is gone.
 - new capability: a sign-extending mov inherits the source's delta.
   Nothing in the corpus builds the shape, so sext_mov_inherits_delta
   covers it directly.
 - assign_scalar_id_before_mov() now keeps a BPF_REG_LINK_SEXT source's
   id. Without it bpf_iter_tasks/dump_task_sleepable hits the 8192-jump
   limit under bpf-gcc.
 - the mixed-kind guard also covers BPF_REG_LINK_ZEXT against
   BPF_REG_LINK_SEXT. That deduction is sound and declined on purpose:
   making it turns an int loop counter into a fresh constant each
   iteration and iter_obfuscate_counter stops converging.

 include/linux/bpf_verifier.h |  3 +-
 include/linux/tnum.h         |  7 +++
 kernel/bpf/log.c             |  2 +
 kernel/bpf/tnum.c            | 15 ++++++
 kernel/bpf/verifier.c        | 89 +++++++++++++++++++++++++++++++-----
 5 files changed, 103 insertions(+), 13 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 081facac7b86..16e3d5a951b5 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -57,13 +57,14 @@ enum bpf_iter_state {
  *
  *   BPF_REG_LINK_FULL:  reg == base + delta
  *   BPF_REG_LINK_ZEXT:  reg == (u32)(base + delta), for ANY base width
- *   BPF_REG_LINK_SEXT:  reg == (s32)(base + delta)
+ *   BPF_REG_LINK_SEXT:  reg == (s32)(base + delta), for ANY base width
  *
  *   r1 = r2;       r1 and r3 are linked to r2: id == N
  *   r3 = r2;
  *   r1 += 10;      r1 gets BPF_REG_LINK_FULL, delta 10
  *   w3 += 10;      w3 gets BPF_REG_LINK_ZEXT, delta 10
  *   w7 = w6;       r7 gets BPF_REG_LINK_ZEXT, delta 0  (r6 may be wide)
+ *   r8 = (s32)r7;  r8 gets BPF_REG_LINK_SEXT, delta 0
  */
 enum bpf_reg_link_kind {
 	BPF_REG_LINK_NONE = 0,
diff --git a/include/linux/tnum.h b/include/linux/tnum.h
index 16682248f963..0ad7ea0d4898 100644
--- a/include/linux/tnum.h
+++ b/include/linux/tnum.h
@@ -63,6 +63,13 @@ struct tnum tnum_union(struct tnum t1, struct tnum t2);
 /* Return @a with all but the lowest @size bytes cleared */
 struct tnum tnum_cast(struct tnum a, u8 size);
 
+/*
+ * Return the lowest @size bytes of @a sign-extended to 64 bits. @size must
+ * be 1, 2 or 4: tnum_cast() above cannot express a 64-bit field, and the
+ * shift here would be by 64 for @size 0.
+ */
+struct tnum tnum_sext(struct tnum a, u8 size);
+
 /* Swap the bytes of a tnum */
 struct tnum tnum_bswap16(struct tnum a);
 struct tnum tnum_bswap32(struct tnum a);
diff --git a/kernel/bpf/log.c b/kernel/bpf/log.c
index a6f205653a9e..2286576ccfe6 100644
--- a/kernel/bpf/log.c
+++ b/kernel/bpf/log.c
@@ -654,6 +654,8 @@ static void print_reg_state(struct bpf_verifier_env *env,
 		verbose_a("id=%d", reg->id);
 	if (reg->link_kind)
 		verbose(env, "%+d", reg->delta);
+	if (reg->link_kind == BPF_REG_LINK_SEXT)
+		verbose(env, ".sx");
 	if (reg->parent_id)
 		verbose_a("parent_id=%d", reg->parent_id);
 	if (type_is_non_owning_ref(reg->type))
diff --git a/kernel/bpf/tnum.c b/kernel/bpf/tnum.c
index 1f620facd1b7..55d10d362eed 100644
--- a/kernel/bpf/tnum.c
+++ b/kernel/bpf/tnum.c
@@ -200,6 +200,21 @@ struct tnum tnum_cast(struct tnum a, u8 size)
 	return a;
 }
 
+struct tnum tnum_sext(struct tnum a, u8 size)
+{
+	u8 shift = 64 - size * 8;
+
+	/*
+	 * Shifting the field up to the top and back down arithmetically
+	 * replicates its sign bit through the high half. Applying that to the
+	 * mask as well carries over whether the sign was known: an unknown
+	 * sign bit leaves every high bit unknown.
+	 */
+	a = tnum_cast(a, size);
+	return TNUM((s64)(a.value << shift) >> shift,
+		    (s64)(a.mask << shift) >> shift);
+}
+
 bool tnum_is_aligned(struct tnum a, u64 size)
 {
 	if (!size)
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index ce7016446936..dffcaa2e1392 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3763,7 +3763,7 @@ static void assign_scalar_id_before_mov(struct bpf_verifier_env *env,
 	 * rY->id has special linked register already.
 	 * Cleared it, since multiple rX += const are not supported.
 	 */
-	if (src_reg->link_kind)
+	if (src_reg->link_kind && src_reg->link_kind != BPF_REG_LINK_SEXT)
 		bpf_clear_scalar_id(src_reg);
 	/*
 	 * Ensure that src_reg has a valid ID that will be copied to
@@ -6057,6 +6057,25 @@ static void zext_32_to_64(struct bpf_reg_state *reg)
 	reg_set_urange64(reg, reg_u32_min(reg), reg_u32_max(reg));
 }
 
+/*
+ * The sign-extending counterpart. Signed bounds carry over directly because
+ * sign extension is monotonic over the signed 32-bit range.
+ */
+static void sext_32_to_64(struct bpf_reg_state *reg)
+{
+	/*
+	 * See comment at reg_step_check_unsigned(). Sign extension subtracts
+	 * 2^32 from every value with bit 31 set, which preserves a residue
+	 * mod step only when step divides 2^32, so the line cannot be kept.
+	 * The zero-extending twin calls reg_step_check_unsigned(reg, 32) for
+	 * the same reason; the unsigned form does not apply here because the
+	 * result is not the low 32 bits but the low 32 bits moved.
+	 */
+	reg_step_reset(reg);
+	reg->var_off = tnum_sext(reg->var_off, 4);
+	reg_set_srange64(reg, reg_s32_min(reg), reg_s32_max(reg));
+}
+
 /* truncate register to smaller size (in bytes)
  * must be called with size < BPF_REG_SIZE
  */
@@ -17544,12 +17563,29 @@ static int check_alu_op(struct bpf_verifier_env *env, struct bpf_insn *insn)
 						return -EACCES;
 					} else if (src_reg->type == SCALAR_VALUE) {
 						bool no_sext;
+						/*
+						 * A 32-bit sign extension keeps the low 32
+						 * bits, so dst shares them with whatever src
+						 * shares them with. Both base + d and
+						 * (u32)(base + d) have low half (base + d), so
+						 * dst is (s32)(base + d) either way: inherit
+						 * src's id and delta and record
+						 * BPF_REG_LINK_SEXT.
+						 */
+						bool subreg_link =
+							(insn->off >> 3) == 4 &&
+							(src_reg != dst_reg || src_reg->id);
 
 						no_sext = reg_umax(src_reg) < (1ULL << (insn->off - 1));
 						if (no_sext)
 							assign_scalar_id_before_mov(env, src_reg);
+						else if (subreg_link && !src_reg->id &&
+							 !tnum_is_const(src_reg->var_off))
+							src_reg->id = ++env->id_gen;
 						*dst_reg = *src_reg;
-						if (!no_sext)
+						if (!no_sext && subreg_link && src_reg->id)
+							dst_reg->link_kind = BPF_REG_LINK_SEXT;
+						else if (!no_sext)
 							bpf_clear_scalar_id(dst_reg);
 						coerce_reg_to_size_sx(dst_reg, insn->off >> 3);
 					} else {
@@ -18485,17 +18521,29 @@ static void sync_linked_regs(struct bpf_verifier_env *env, struct bpf_verifier_s
 		if (reg->id != known_reg->id)
 			continue;
 		/*
-		 * A zero-extending link, spelled BPF_REG_LINK_ZEXT: the
-		 * relation reg == (u32)(base + delta) does not invert once the
-		 * base is wider than 32 bits, so the reverse direction is
-		 * skipped.
+		 * The reverse direction does not work for a narrow known_reg:
+		 * it knows only its low 32 bits, which say nothing about a
+		 * wider reg's high half. Neither (u32)(base + delta) nor
+		 * (s32)(base + delta) inverts once the base is wider than 32
+		 * bits.
 		 */
-		if (known_reg->link_kind == BPF_REG_LINK_ZEXT &&
+		if ((known_reg->link_kind == BPF_REG_LINK_ZEXT ||
+		     known_reg->link_kind == BPF_REG_LINK_SEXT) &&
+		    reg->link_kind != BPF_REG_LINK_ZEXT &&
+		    reg->link_kind != BPF_REG_LINK_SEXT &&
 		    get_reg_width(reg) > 32)
 			continue;
 		/*
-		 * Skip mixed 32/64-bit links: the delta relationship doesn't
-		 * hold across different ALU widths.
+		 * Skip a pair of differing kinds. Where BPF_REG_LINK_FULL meets
+		 * a 32-bit kind the delta relationship genuinely does not hold:
+		 * the deltas were added at different ALU widths.
+		 * BPF_REG_LINK_ZEXT against BPF_REG_LINK_SEXT is not that case
+		 * -- both are base + delta in the low 32 bits, so narrowing one
+		 * really does narrow the other -- but that deduction is
+		 * declined on purpose. It makes an int loop counter a fresh
+		 * constant on every iteration, so no two iterations prune
+		 * against each other and the program runs to the instruction
+		 * limit. See sext_no_sync_from_zext_sibling.
 		 */
 		if (reg->link_kind && known_reg->link_kind &&
 		    reg->link_kind != known_reg->link_kind)
@@ -18504,7 +18552,7 @@ static void sync_linked_regs(struct bpf_verifier_env *env, struct bpf_verifier_s
 		 * Only an unlinked pair is a plain copy. Anything carrying a
 		 * kind goes through the differencing arm below, which adds the
 		 * delta difference (zero when the deltas match) and then
-		 * applies the BPF_REG_LINK_ZEXT zero-extension.
+		 * re-applies whichever extension the kinds call for.
 		 */
 		if (!reg->link_kind && !known_reg->link_kind) {
 			*reg = *known_reg;
@@ -18531,9 +18579,26 @@ static void sync_linked_regs(struct bpf_verifier_env *env, struct bpf_verifier_s
 			scalar32_min_max_add(reg, &fake_reg);
 			scalar_min_max_add(reg, &fake_reg);
 			reg->var_off = tnum_add(reg->var_off, fake_reg.var_off);
-			if (reg->link_kind == BPF_REG_LINK_ZEXT ||
-			    known_reg->link_kind == BPF_REG_LINK_ZEXT)
+			if (reg->link_kind == BPF_REG_LINK_SEXT) {
+				sext_32_to_64(reg);
+			} else if (reg->link_kind == BPF_REG_LINK_ZEXT ||
+				   known_reg->link_kind == BPF_REG_LINK_ZEXT ||
+				   known_reg->link_kind == BPF_REG_LINK_SEXT) {
+				/*
+				 * Either @reg is itself the zero extension, or
+				 * @reg has no 32-bit kind and @known_reg does
+				 * -- the reverse direction, where the guard
+				 * above has already proved @reg fits 32 bits.
+				 * Then @reg is @known_reg's low half with
+				 * nothing above it, whichever way @known_reg
+				 * filled its own high half, so the zero
+				 * extension is the reconstruction for both
+				 * kinds. BPF_REG_LINK_FULL is not here on
+				 * purpose: it relates all 64 bits and must not
+				 * be truncated.
+				 */
 				zext_32_to_64(reg);
+			}
 			/*
 			 * Intersect rather than overwrite. A BPF_REG_LINK_ZEXT
 			 * link over a wide base does not propagate back, so the
-- 
2.53.0-Meta

