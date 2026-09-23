Received: from mail-wr2-f10.google.com (mail-wr2-f10.google.com [74.125.225.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11C3842F715
	for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 19:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790190713; cv=none; b=pfscZk2GwgZcMnU/e7TCjKo6ITf13Y3mohjMiNyVyGLRNPzYffCvFitSCmSw+Vu6k9Jt2kTB/iycOLtEsX2ZrpDgHRpkipr7E3yS1zy+K1F0HyMUQNxLdUYyNDOnSYWmKiC8yqQEfSuHz+Bqp498mcdniFu5E20AaVzLk4/36BU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790190713; c=relaxed/simple;
	bh=2rffb2/22h3cPGNU03VRFqjex3KUiXc0UQiSHnzw2VQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J/MHrcrCBivfAL0N63J1aI2i4UNrJCQCuQIyal9LB1MTCus6WxQr4QX/rreMnwPRZekLShh6IQN5ylQLGacqINmuAYW1wEfOkBPzcBBJo2p7w/3YmVZ1DQcsVFdF+MCBQEbix8p4acemzGYeUt+UiFztSQ8YHVXB+H/89l69vk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LKAs8IIP; arc=none smtp.client-ip=74.125.225.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LKAs8IIP"
Received: by mail-wr2-f10.google.com with SMTP id ffacd0b85a97d-48433107499so578129f8f.0
        for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 12:11:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790190709; x=1790795509; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8iXzVCv1V6X1RUH449xt7QKbkO2ga7uTyZxGO/JUD+Y=;
        b=LKAs8IIPWUjxF5NBUI4F40SvTQpnUqXAaOh12OAQ850BDmrAB+CUhy/p3L97Qlggii
         pYJ5XXHbbUp7QhLmkitntWjjF03t4+/sYMjkg51VHzwdD1Q5VpOkX82fXRQLPnKupxcg
         Ftq0r1adlSVczrJ6WHmcp7gbFMhY6pFzcsDMjSyOu1/RDKw8HKs/IiLQAxvIb9mbeooZ
         4g7ZKp2VcBa1ONCwkXzIqfQrGNE9ZOKNLd+2cSR5e6pA/NpjRW5p1A8h6PowQ0Z8nTKE
         cm6lFpcNRu/Dd3Wa8X4j5oZFvGXCIC4eA9FdHa3eKuu62fYYOs62+tk+kXT+G4L0HMos
         mrog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790190709; x=1790795509;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8iXzVCv1V6X1RUH449xt7QKbkO2ga7uTyZxGO/JUD+Y=;
        b=A3XWIzdp1Xf4NIxNZzgRwbdEXYYVjrNXZMeWqiRNiGp/dFLptXcXZ3ZNYC1Jjm2nMy
         XfJLkvw0tDktm0BBCeACjIypT7z0CAyQzTU58/1tyK3B4kHEEEwxNZBfs2w0PXq+ZcXn
         cMI031h7pSxS2vRXfEwgkDEbEZNIOVa9GTAkr/Az4RekvFwjSKLXYhEZbZh5udJczpXk
         Uybbdl1/+/R0a9IkXIUWmePOgK9Gf6/sFwVecBZnNKIw2M5YgDrVv1IhjNoEhlBHpQWn
         1Ow7E6sRwkxUWAPyZbLdB6Lr1syZlR1Gq2DetzHizyuXnau7kF5o/UfeZBDwwWV0G/KR
         z09Q==
X-Gm-Message-State: AFuF++ntrJDdWFSVeCRlcDlXF+mYlxh3m48+RTXboZDG3okwgGRmq5en
	tTMCz6amSrtVScQRuqeeSq7VsYM1umzGDb5UOZryP2oP96K8lkfT5cfroU307ft/
X-Gm-Gg: AYBFou0xoenyT6PMVYtInoaBJBRgW0K6E4g2jYFD95pgNcRUv1yG/mRZhynTWwr0h3S
	X6smYokYWTHCCbKE9ynkUwyvcHI8TbFLhPXjfhyiSpjWGnL37XXij9P2YxngVsYH3BI3Tv0c4TS
	hfV8FV1eO0zhKuiFmneE18DO7cJQmgN6YApG1RkU6RV7yhSPqGusYoJf2WUuqMEyjhyx9RMVmnA
	FteGRt6ftyYs1Ap5fMYhyyuhzSfQvRuTDdOf35qDCevKu7b0gr/DkgTIqJrMD5ZJAyh9mOL2GVs
	b9kpMnaW7HPPb4Ih5NeVfwVVHSiTFsQDEenhUxU/cVxPQ2In7980cvrxGZ1AGvLYii+/s6mAlIi
	/xiDCVDLjq7V7NhYxisDaGQWyPlkPzlcw237+3vXbmCMA7Ix9a0O2r0t21AGth9EO1kDMqM2UPR
	rHx7YNr790e3CWhw8DGV19iuvIhSmQ4k8ZNfCNeTDGTrp83xTjwEuU2FaWc2R2VZl+OvoxGf9eC
	gxM9DO7SeQ9DRv2CrD2dyXLmdjgEWWsSSLGWsphLdTxKhBn5fZnNOu2cDg7Rld90+34AlC0cxFI
	/3AxQQuYXqv9/A6hornIhPHPA+3KuGTS+3QJSQ==
X-Received: by 2002:a05:600c:190e:b0:49d:1840:4fd2 with SMTP id 5b1f17b1804b1-49fe66fbed0mr2238755e9.23.1790190709027;
        Wed, 23 Sep 2026 12:11:49 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fdf158147sm71375255e9.0.2026.09.23.12.11.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 12:11:48 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Tejun Heo <tj@kernel.org>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 04/18] bpf: Track backtracking stack slots with bitmaps
Date: Wed, 23 Sep 2026 21:11:11 +0200
Message-ID: <20260923191139.2816206-5-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260923191139.2816206-1-memxor@gmail.com>
References: <20260923191139.2816206-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=9878; i=memxor@gmail.com; h=from:subject; bh=2rffb2/22h3cPGNU03VRFqjex3KUiXc0UQiSHnzw2VQ=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWuL4pfr8z7NfxlQWq7QWs5y3qSB35ovIrD+vy5L163YN 2LJhj86SlkYxLgYZMUUWUr+72MyPlH5O9B2GTfMHFYmkCEMXJwCMJFjaQx/5f7nTrFw2qbT7fC7 PN9036xsh2ll2x0S+6w6JuRkJXuHMfyzle/7IM49Y912/XQpri9OT5gmHtyn0sZ/x2d30us3hxa xAAA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Precision backtracking keeps the stack slots that still need a precise
mark in one u64 per frame, which ties it to frames of at most 64 slots.
Turn the per-frame masks into bitmaps sized by MAX_BPF_STACK_SLOTS and
use the bitmap helpers for setting, clearing, testing and iterating
them. The formatting helper takes a bitmap and the leftover-slot bug
reports print the formatted slot list instead of a hex mask.

mark_reg_stack_read() collected zero spills in a u64 of its own before
handing it to the backtracker; it now counts them and revisits the
range to mark each slot, which drops the only remaining mask-typed
entry point.

No functional change.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/linux/bpf_verifier.h | 13 +++-----
 kernel/bpf/backtrack.c       | 65 ++++++++++++++++++++++--------------
 kernel/bpf/verifier.c        | 15 ++++++---
 3 files changed, 54 insertions(+), 39 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 77cda3b3a3e9..905a081d4b62 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -879,7 +879,7 @@ struct backtrack_state {
 	struct bpf_verifier_env *env;
 	u32 frame;
 	u32 reg_masks[MAX_CALL_FRAMES];
-	u64 stack_masks[MAX_CALL_FRAMES];
+	unsigned long stack_masks[MAX_CALL_FRAMES][BITS_TO_LONGS(MAX_BPF_STACK_SLOTS)];
 	u8 stack_arg_masks[MAX_CALL_FRAMES];
 };
 
@@ -1317,12 +1317,7 @@ static inline void bpf_bt_set_frame_reg(struct backtrack_state *bt, u32 frame, u
 
 static inline void bpf_bt_set_frame_slot(struct backtrack_state *bt, u32 frame, u32 slot)
 {
-	bt->stack_masks[frame] |= 1ull << slot;
-}
-
-static inline void bpf_bt_set_frame_slot_mask(struct backtrack_state *bt, u32 frame, u64 mask)
-{
-	bt->stack_masks[frame] |= mask;
+	__set_bit(slot, bt->stack_masks[frame]);
 }
 
 static inline void bt_set_frame_stack_arg_slot(struct backtrack_state *bt, u32 frame, u32 slot)
@@ -1337,7 +1332,7 @@ static inline bool bt_is_frame_reg_set(struct backtrack_state *bt, u32 frame, u3
 
 static inline bool bt_is_frame_slot_set(struct backtrack_state *bt, u32 frame, u32 slot)
 {
-	return bt->stack_masks[frame] & (1ull << slot);
+	return test_bit(slot, bt->stack_masks[frame]);
 }
 
 bool bpf_map_is_rdonly(const struct bpf_map *map);
@@ -1531,7 +1526,7 @@ struct bpf_subprog_info *bpf_find_containing_subprog(struct bpf_verifier_env *en
 const char *bpf_subprog_name(const struct bpf_verifier_env *env, int subprog);
 int bpf_jmp_offset(struct bpf_insn *insn);
 struct bpf_iarray *bpf_insn_successors(struct bpf_verifier_env *env, u32 idx);
-void bpf_fmt_stack_mask(char *buf, ssize_t buf_sz, u64 stack_mask);
+void bpf_fmt_stack_mask(char *buf, ssize_t buf_sz, const unsigned long *stack_mask);
 bool bpf_subprog_is_global(const struct bpf_verifier_env *env, int subprog);
 
 /* Kinds of member a by-value struct or union may be composed of. */
diff --git a/kernel/bpf/backtrack.c b/kernel/bpf/backtrack.c
index 6733d4078930..db1be14d0a68 100644
--- a/kernel/bpf/backtrack.c
+++ b/kernel/bpf/backtrack.c
@@ -129,13 +129,26 @@ static inline void bt_reset(struct backtrack_state *bt)
 	bt->env = env;
 }
 
-static inline u32 bt_empty(struct backtrack_state *bt)
+static inline bool bt_frame_stack_empty(struct backtrack_state *bt, u32 frame)
 {
-	u64 mask = 0;
+	return bitmap_empty(bt->stack_masks[frame], MAX_BPF_STACK_SLOTS);
+}
+
+static inline bool bt_stack_empty(struct backtrack_state *bt)
+{
+	return bt_frame_stack_empty(bt, bt->frame);
+}
+
+static inline bool bt_empty(struct backtrack_state *bt)
+{
+	u32 mask = 0;
 	int i;
 
-	for (i = 0; i <= bt->frame; i++)
-		mask |= bt->reg_masks[i] | bt->stack_masks[i] | bt->stack_arg_masks[i];
+	for (i = 0; i <= bt->frame; i++) {
+		mask |= bt->reg_masks[i] | bt->stack_arg_masks[i];
+		if (!bt_frame_stack_empty(bt, i))
+			return false;
+	}
 
 	return mask == 0;
 }
@@ -187,7 +200,7 @@ static inline void bt_clear_reg(struct backtrack_state *bt, u32 reg)
 
 static inline void bt_clear_frame_slot(struct backtrack_state *bt, u32 frame, u32 slot)
 {
-	bt->stack_masks[frame] &= ~(1ull << slot);
+	__clear_bit(slot, bt->stack_masks[frame]);
 }
 
 static inline u32 bt_frame_reg_mask(struct backtrack_state *bt, u32 frame)
@@ -200,14 +213,14 @@ static inline u32 bt_reg_mask(struct backtrack_state *bt)
 	return bt->reg_masks[bt->frame];
 }
 
-static inline u64 bt_frame_stack_mask(struct backtrack_state *bt, u32 frame)
+static inline unsigned long *bt_frame_stack_mask(struct backtrack_state *bt, u32 frame)
 {
 	return bt->stack_masks[frame];
 }
 
-static inline u64 bt_stack_mask(struct backtrack_state *bt)
+static inline unsigned long *bt_stack_mask(struct backtrack_state *bt)
 {
-	return bt->stack_masks[bt->frame];
+	return bt_frame_stack_mask(bt, bt->frame);
 }
 
 static inline u8 bt_stack_arg_mask(struct backtrack_state *bt)
@@ -239,17 +252,16 @@ static void fmt_reg_mask(char *buf, ssize_t buf_sz, u32 reg_mask)
 			break;
 	}
 }
-/* format stack slots bitmask, e.g., "-8,-24,-40" for 0x15 mask */
-void bpf_fmt_stack_mask(char *buf, ssize_t buf_sz, u64 stack_mask)
+
+/* format stack slots bitmask, e.g., "-8,-24,-40" for slots 0, 2 and 4 */
+void bpf_fmt_stack_mask(char *buf, ssize_t buf_sz, const unsigned long *stack_mask)
 {
-	DECLARE_BITMAP(mask, 64);
 	bool first = true;
 	int i, n;
 
 	buf[0] = '\0';
 
-	bitmap_from_u64(mask, stack_mask);
-	for_each_set_bit(i, mask, 64) {
+	for_each_set_bit(i, stack_mask, MAX_BPF_STACK_SLOTS) {
 		n = snprintf(buf, buf_sz, "%s%d", first ? "" : ",", -(i + 1) * 8);
 		first = false;
 		buf += n;
@@ -458,10 +470,11 @@ static int backtrack_insn(struct bpf_verifier_env *env, int idx, int subseq_idx,
 				/* we are now tracking register spills correctly,
 				 * so any instance of leftover slots is a bug
 				 */
-				if (bt_stack_mask(bt) != 0) {
-					verifier_bug(env,
-						     "static subprog leftover stack slots %llx",
-						     bt_stack_mask(bt));
+				if (!bt_stack_empty(bt)) {
+					bpf_fmt_stack_mask(env->tmp_str_buf, TMP_STR_BUF_LEN,
+							   bt_stack_mask(bt));
+					verifier_bug(env, "static subprog leftover stack slots %s",
+						     env->tmp_str_buf);
 					return -EFAULT;
 				}
 				/* propagate r1-r5 to the caller */
@@ -494,9 +507,11 @@ static int backtrack_insn(struct bpf_verifier_env *env, int idx, int subseq_idx,
 					     bt_reg_mask(bt));
 				return -EFAULT;
 			}
-			if (bt_stack_mask(bt) != 0) {
-				verifier_bug(env, "callback leftover stack slots %llx",
-					     bt_stack_mask(bt));
+			if (!bt_stack_empty(bt)) {
+				bpf_fmt_stack_mask(env->tmp_str_buf, TMP_STR_BUF_LEN,
+						   bt_stack_mask(bt));
+				verifier_bug(env, "callback leftover stack slots %s",
+					     env->tmp_str_buf);
 				return -EFAULT;
 			}
 			/* clear r1-r5 in callback subprog's mask */
@@ -874,7 +889,7 @@ int bpf_mark_chain_precision(struct bpf_verifier_env *env,
 			if (st->curframe == 0 &&
 			    st->frame[0]->subprogno > 0 &&
 			    st->frame[0]->callsite == BPF_MAIN_FUNC &&
-			    bt_stack_mask(bt) == 0 &&
+			    bt_stack_empty(bt) &&
 			    (bt_reg_mask(bt) & ~BPF_REGMASK_ARGS) == 0) {
 				bitmap_from_u64(mask, bt_reg_mask(bt));
 				for_each_set_bit(i, mask, 32) {
@@ -888,8 +903,9 @@ int bpf_mark_chain_precision(struct bpf_verifier_env *env,
 				return 0;
 			}
 
-			verifier_bug(env, "backtracking func entry subprog %d reg_mask %x stack_mask %llx",
-				     st->frame[0]->subprogno, bt_reg_mask(bt), bt_stack_mask(bt));
+			bpf_fmt_stack_mask(env->tmp_str_buf, TMP_STR_BUF_LEN, bt_stack_mask(bt));
+			verifier_bug(env, "backtracking func entry subprog %d reg_mask %x stack_mask %s",
+				     st->frame[0]->subprogno, bt_reg_mask(bt), env->tmp_str_buf);
 			return -EFAULT;
 		}
 
@@ -950,8 +966,7 @@ int bpf_mark_chain_precision(struct bpf_verifier_env *env,
 				}
 			}
 
-			bitmap_from_u64(mask, bt_frame_stack_mask(bt, fr));
-			for_each_set_bit(i, mask, 64) {
+			for_each_set_bit(i, bt_frame_stack_mask(bt, fr), MAX_BPF_STACK_SLOTS) {
 				if (verifier_bug_if(i >= bpf_stack_nr_slots(func),
 						    env, "stack slot %d, total slots %d",
 						    i, bpf_stack_nr_slots(func)))
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index fa80f95105fb..a66f1688407c 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3864,10 +3864,9 @@ static int mark_reg_stack_read(struct bpf_verifier_env *env,
 {
 	struct bpf_verifier_state *vstate = env->cur_state;
 	struct bpf_func_state *state = vstate->frame[vstate->curframe];
-	u64 zero_spill_mask = 0;
 	int i, slot, spi;
 	u8 *stype;
-	int zeros = 0;
+	int zeros = 0, zero_spills = 0;
 
 	for (i = min_off; i < max_off; i++) {
 		slot = -i - 1;
@@ -3880,7 +3879,7 @@ static int mark_reg_stack_read(struct bpf_verifier_env *env,
 		}
 		if (stype[slot % BPF_REG_SIZE] == STACK_SPILL &&
 		    bpf_register_is_null(&bpf_stack_slot(ptr_state, spi)->spilled_ptr)) {
-			zero_spill_mask |= 1ull << spi;
+			zero_spills++;
 			zeros++;
 			continue;
 		}
@@ -3891,8 +3890,14 @@ static int mark_reg_stack_read(struct bpf_verifier_env *env,
 		 * so the whole register == const_zero.
 		 */
 		__mark_reg_const_zero(env, &state->regs[dst_regno]);
-		if (zero_spill_mask) {
-			bpf_bt_set_frame_slot_mask(&env->bt, ptr_state->frameno, zero_spill_mask);
+		if (zero_spills) {
+			for (i = min_off; i < max_off; i++) {
+				slot = -i - 1;
+				spi = slot / BPF_REG_SIZE;
+				stype = bpf_stack_slot(ptr_state, spi)->slot_type;
+				if (stype[slot % BPF_REG_SIZE] == STACK_SPILL)
+					bpf_bt_set_frame_slot(&env->bt, ptr_state->frameno, spi);
+			}
 			return mark_chain_precision_batch(env, env->cur_state);
 		}
 	} else {
-- 
2.53.0

