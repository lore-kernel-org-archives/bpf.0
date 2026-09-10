Received: from mta0.migadu.com (out-14.mta0.migadu.com [91.218.175.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B9A84AB1CB
	for <bpf@vger.kernel.org>; Thu, 10 Sep 2026 16:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789058860; cv=none; b=fN+ph9+96C1Gkg/9i9/kvHEWfUcYlbIKGhOiEItTdtZ9SHRbjYvZbWbKYkygwDlORS9jM7m3eo1ujC+7rZkTW8G4V3ooJpudgc5TCzOof8gh3y34R84ev83sGjmIORvbm+KPIydqgEmw4Qu6Ray7hiQqDf5PKlOh2yyDgYtJPoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789058860; c=relaxed/simple;
	bh=ZQzAHmXnQXRtT07FXharBiwXxPJzzGDcAjKVd5CAspk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u20AOxw3hRBLf1L2oYoK5+CfYSDmllvEORpPYkcBfWnWDuMUsTjSnMOl8lvjAAU6Mrc3Tr2jtTddS74znJOMsydmEmyeuI4P832oqbkBhIX6KmDUp1DeL/YZsx4Y+JBWGBnts3lK8U++wRxpuWzf2rF//ZNKi9ptKm1il00ZUs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pHYkqW+W; arc=none smtp.client-ip=91.218.175.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pHYkqW+W"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=ZQzAHmXnQXRtT07FXharBiwXxPJzzGDcAjKVd5CAspk=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789058847; v=1; x=1789663647;
 b=pHYkqW+WSuNvX8hTO5DUmDhjHYtYk9oOp+bh3rw4Av3BYfp1i0ohZI2zePmYJ256zOSRFjbB
 JMEnAaHSlBVemiykkXXfG0CO3XHkPZqql7CKduc2C3lGhboKlgiYtKd8ROidwN28HNf2Rd2fOwL
 LND7DT+nkZ2UpBcpkG3JJ1+s=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 28ef671506850e4e;
	Thu, 10 Sep 2026 16:47:27 +0000
X-Mizu-Trace-ID: 28ef671506850e4e
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
Subject: [PATCH bpf-next v2 07/13] bpf: track low-32 scalar equality across sign-extending movs
Date: Thu, 10 Sep 2026 22:16:29 +0530
Message-ID: <20260910164635.459558-8-vineet.gupta@linux.dev>
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

The zero-extending mov records that dst shares src's low 32 bits. A 32-bit
sign extension shares them too -- it keeps the low half and fills the high
half from bit 31 -- so the same link applies, with a different rule for
rebuilding the high bits:

  r6 = ...              /* full 64-bit unknown */
  r7 = (s32)r6          /* 32-bit sign-extending mov */
  if w6 == -1 goto ...  /* taken: r6's low 32 bits are all ones */
  ...                   /* r7 is -1, not deduced today */

Add SUBREG_SEXT alongside SUBREG_ZEXT, and sext_32_to_64() alongside
zext_32_to_64() to drive the reconstruction. Both work from the base's
32-bit range, which is what a 32-bit compare narrows.
coerce_reg_to_size_sx() cannot serve here: it reads smin/smax, which
straddle after such a compare and collapse to the full field range.

tnum_sext() is the counterpart to tnum_cast(). Unlike a tnum_range() over
the new bounds it keeps the known low bits.

The enum has room for the third value, so bpf_reg_state stays 80 bytes.

Unlike the zero-extending arm, a self-mov can form a link here, but only
when src is already linked: r0 = (s32)r0 is how a sign-extended int return
lands. On an unlinked register there is nothing to link to, and minting an
id would leave the register describing itself.

Signed-off-by: Vineet Gupta <vineet.gupta@linux.dev>
---
v2: was RFC 5/6.
 - no forward declaration (Eduard)
 - src renamed known_reg (Eduard)
 - sext_32_to_64() and tnum_sext() rather than reusing
   coerce_reg_to_size_sx(); the sync path needs the base's 32-bit range,
   see the cover letter
 - tnum_sext() keeps the known low bits a tnum_range() would drop (Eduard)
 - a self-mov links only when src already has an id, narrower than the RFC

 include/linux/bpf_verifier.h |  1 +
 include/linux/tnum.h         |  3 +++
 kernel/bpf/log.c             |  2 ++
 kernel/bpf/tnum.c            | 15 ++++++++++++
 kernel/bpf/verifier.c        | 47 +++++++++++++++++++++++++++++++++---
 5 files changed, 65 insertions(+), 3 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index f1b01059c5da..920c9490ecc8 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -53,6 +53,7 @@ enum bpf_add_const {
 enum bpf_subreg {
 	SUBREG_NONE = 0,
 	SUBREG_ZEXT,		/* high bits are zero (32-bit zero-extending mov) */
+	SUBREG_SEXT,		/* high bits repeat bit 31 (32-bit sign-extending mov) */
 };
 
 struct bpf_reg_state {
diff --git a/include/linux/tnum.h b/include/linux/tnum.h
index ca2cfec8de08..866803de5841 100644
--- a/include/linux/tnum.h
+++ b/include/linux/tnum.h
@@ -63,6 +63,9 @@ struct tnum tnum_union(struct tnum t1, struct tnum t2);
 /* Return @a with all but the lowest @size bytes cleared */
 struct tnum tnum_cast(struct tnum a, u8 size);
 
+/* Return the lowest @size bytes of @a sign-extended to 64 bits */
+struct tnum tnum_sext(struct tnum a, u8 size);
+
 /* Swap the bytes of a tnum */
 struct tnum tnum_bswap16(struct tnum a);
 struct tnum tnum_bswap32(struct tnum a);
diff --git a/kernel/bpf/log.c b/kernel/bpf/log.c
index 4047cfb0a698..b67bbd4d57f4 100644
--- a/kernel/bpf/log.c
+++ b/kernel/bpf/log.c
@@ -656,6 +656,8 @@ static void print_reg_state(struct bpf_verifier_env *env,
 		verbose(env, "%+d", reg->delta);
 	if (reg->subreg == SUBREG_ZEXT)
 		verbose(env, ".lo32");
+	else if (reg->subreg == SUBREG_SEXT)
+		verbose(env, ".lo32sx");
 	if (reg->parent_id)
 		verbose_a("parent_id=%d", reg->parent_id);
 	if (type_is_non_owning_ref(reg->type))
diff --git a/kernel/bpf/tnum.c b/kernel/bpf/tnum.c
index ec9c310cf5d7..e1dc57afd3d3 100644
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
index eb093194e2a3..308ff53232f0 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5708,6 +5708,16 @@ static void zext_32_to_64(struct bpf_reg_state *reg)
 	reg_set_urange64(reg, reg_u32_min(reg), reg_u32_max(reg));
 }
 
+/*
+ * The sign-extending counterpart. Signed bounds carry over directly because
+ * sign extension is monotonic over the signed 32-bit range.
+ */
+static void sext_32_to_64(struct bpf_reg_state *reg)
+{
+	reg->var_off = tnum_sext(reg->var_off, 4);
+	reg_set_srange64(reg, reg_s32_min(reg), reg_s32_max(reg));
+}
+
 /* truncate register to smaller size (in bytes)
  * must be called with size < BPF_REG_SIZE
  */
@@ -16248,12 +16258,23 @@ static int check_alu_op(struct bpf_verifier_env *env, struct bpf_insn *insn)
 						return -EACCES;
 					} else if (src_reg->type == SCALAR_VALUE) {
 						bool no_sext;
+						/*
+						 * A 32-bit sign extension keeps the low 32
+						 * bits, so record a low-32 link as the
+						 * zero-extending mov does. A self-mov
+						 * qualifies only if src is already linked.
+						 */
+						bool subreg_link = (insn->off >> 3) == 4 &&
+								   (src_reg != dst_reg ||
+								    src_reg->id);
 
 						no_sext = reg_umax(src_reg) < (1ULL << (insn->off - 1));
-						if (no_sext)
+						if (no_sext || subreg_link)
 							assign_scalar_id_before_mov(env, src_reg);
 						*dst_reg = *src_reg;
-						if (!no_sext)
+						if (!no_sext && subreg_link && src_reg->id)
+							dst_reg->subreg = SUBREG_SEXT;
+						else if (!no_sext)
 							clear_scalar_id(dst_reg);
 						coerce_reg_to_size_sx(dst_reg, insn->off >> 3);
 					} else {
@@ -17165,6 +17186,23 @@ static void reconstruct_zext32(struct bpf_reg_state *reg,
 	reg_bounds_sync(reg);
 }
 
+/*
+ * The sign-extending counterpart. Note this drives off the base's 32-bit
+ * range, not coerce_reg_to_size_sx(): after a 32-bit compare it is the low
+ * half that has been narrowed, and the 64-bit bounds still describe the
+ * base's high bits, which are not ours.
+ */
+static void reconstruct_sext32(struct bpf_reg_state *reg,
+			       struct bpf_reg_state *known_reg)
+{
+	enum bpf_subreg subreg = reg->subreg;
+
+	*reg = *known_reg;
+	reg->subreg = subreg;
+	sext_32_to_64(reg);
+	reg_bounds_sync(reg);
+}
+
 /* For all R in linked_regs, copy known_reg range into R
  * if R->id == known_reg->id.
  */
@@ -17192,7 +17230,10 @@ static void sync_linked_regs(struct bpf_verifier_env *env, struct bpf_verifier_s
 		if (reg->subreg) {
 			if (reg->add_const || known_reg->add_const)
 				continue;
-			reconstruct_zext32(reg, known_reg);
+			if (reg->subreg == SUBREG_ZEXT)
+				reconstruct_zext32(reg, known_reg);
+			else
+				reconstruct_sext32(reg, known_reg);
 			if (e->is_reg)
 				mark_reg_scratched(env, e->regno);
 			else
-- 
2.53.0-Meta

